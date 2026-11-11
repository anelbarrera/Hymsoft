//objectcomments Pase de Pedidos a otra empresa
forward
global type w_fa_man_pasar_facturas from w_fa_padre_reportes
end type
type st_4 from statictext within w_fa_man_pasar_facturas
end type
type cb_procesar from commandbutton within w_fa_man_pasar_facturas
end type
type st_3 from statictext within w_fa_man_pasar_facturas
end type
type dw_4 from datawindow within w_fa_man_pasar_facturas
end type
type dw_3 from datawindow within w_fa_man_pasar_facturas
end type
type sle_lineas from singlelineedit within w_fa_man_pasar_facturas
end type
type cbx_cargos from checkbox within w_fa_man_pasar_facturas
end type
type ddlb_1 from dropdownlistbox within w_fa_man_pasar_facturas
end type
type st_1 from statictext within w_fa_man_pasar_facturas
end type
end forward

global type w_fa_man_pasar_facturas from w_fa_padre_reportes
integer x = 1271
integer y = 160
integer width = 2688
integer height = 1392
string title = "(FA) Pasar los Pedidos a "
string menuname = ""
boolean controlmenu = false
boolean maxbox = false
boolean resizable = false
string icon = "Application!"
event ue_help ( )
st_4 st_4
cb_procesar cb_procesar
st_3 st_3
dw_4 dw_4
dw_3 dw_3
sle_lineas sle_lineas
cbx_cargos cbx_cargos
ddlb_1 ddlb_1
st_1 st_1
end type
global w_fa_man_pasar_facturas w_fa_man_pasar_facturas

type variables
//Variable para asignar el nombre de la Empresa al DW
string is_unian
Integer id_selec, ii_contador,id_fraccion,id_cantidad
window iw_pedidos
integer ii_g_financiero, ii_empresa
Datawindowchild dwc_tipo_fact, dwc_pedido, dwc_cliente
long il_tercero
end variables

forward prototypes
public subroutine wf_botones ()
public subroutine wf_procesar ()
end prototypes

event ue_help;//wf_buscar_factura()

end event

public subroutine wf_botones ();//Deshabilitar botones no necesarios.
//	m_fa_padre.m_edicin.m_siguienteregistro.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_registroanterior.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_ultimoregistro.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_primerregistro.toolbaritemvisible=false

   m_fa_padre.m_archivo.m_vistapreliminar.toolbaritemvisible=false
   m_fa_padre.m_edicin.m_sortear.toolbaritemvisible=false
	m_fa_padre.m_edicin.m_filtrar.toolbaritemvisible=false


end subroutine

public subroutine wf_procesar ();//Función que hace el pase de los pedidos seleccionados hacia la empresa correspondiente
integer  i, li_encontrado
string	ls_incluir, ls_pedido, ls_tipo, ls_bodega_des, ls_ubicacion_des
long		ll_ann
boolean 	lb_entro = false

dw_4.setfilter("fact_incluir = 'S'")
dw_4.filter()							

if dw_4.rowcount() = 0 then 
	gf_mensaje('','Debe Seleccionar el Pedido a Pasar',1,1,'E') 
	dw_4.setfilter("")
	dw_4.filter()	
	return
elseif gf_mensaje('','Está seguro de Efectuar el Pase',1,2,'E') = 2 then 
	dw_4.setfilter("")
	dw_4.filter()
	return		
end if

/*Selecciona la bodega y ubicacion a la que va a pasar las facturas*/

SELECT para_bodega_entrada, para_ubicacion_entrada
 into  :ls_bodega_des,:ls_ubicacion_des
from inaparam
where para_g_financiero=:str.g_financiero 
  and para_empresa=:str.empresa ;
  
if sqlca.sqlcode = -1 then
	mensaje('Aviso','Error al Seleccionar parametro',sqlca.sqlerrtext)
	return
end if

if isnull(ls_bodega_des) or isnull(ls_ubicacion_des) then 
	messagebox('Aviso'," -* Bodega o Ubicacion no Definida en Inventarios *- ")
elseif ls_bodega_des = '' or ls_ubicacion_des = '' then
	//Si tiene espacios, se le asigna null para que al insertar, asigne la bodega y ubicacion
	//original de la factura
	setnull(ls_bodega_des)
	setnull(ls_ubicacion_des)
end if

for i = 1 to dw_4.rowcount()
	
//	ls_incluir = dw_4.getitemstring(i,"fact_incluir")
	
//	if ls_incluir = 'S' then
		
		  ls_pedido = dw_4.getitemString(i,"pedi_no_pedido")
		  ll_ann		= dw_4.getitemNumber(i,"pedi_ann")
		  ls_tipo	= dw_4.getitemString(i,"pedi_tipo") //Para el detalle de faddiari
		 //Si el Pase va hacia Pedidos o hacia Facturas
		 if ddlb_1.text = 'PEDIDO' then			
					  //Para validar que el pedido no exista en la empresa a pasar
					  SELECT count(*)  
						 INTO :li_encontrado
						 FROM fatpedid  
						WHERE ( fatpedid.pedi_g_financiero = :ii_g_financiero ) AND  
								( fatpedid.pedi_empresa = :ii_empresa ) AND  
								( fatpedid.pedi_no_pedido = :ls_pedido ) AND  
								( fatpedid.pedi_ann = :ll_ann )   ;
						if sqlca.sqlcode = -1 then	
							mensaje("Aviso","Error al verificar existencia del pedido",sqlca.sqlerrtext)
							rollback using sqlca;
							dw_4.setfilter("")
							dw_4.filter()															
							return
						end if
						
					  if li_encontrado > 0 then
						 mensaje("Aviso","Atención Sr. Usuario, el Pedido "+ls_pedido+" del "+string(ll_ann)+ " Ya existe. Verifique","")
						 continue //Para que pase al siguiente registro
					  end if
					  
					 //Inserta el Encabezado del Pedido 			
					  INSERT INTO fatpedid  
						( pedi_g_financiero,   
						  pedi_empresa,   
						  pedi_tipo,   
						  pedi_no_pedido,   
						  pedi_ann,   
						  pedi_cliente,   
						  pedi_ruc_cliente,   
						  pedi_condicion_pago,   
						  pedi_tipo_venta,   
						  pedi_tipo_movimiento,   
						  pedi_no_traspaso,   
						  pedi_fecha,   
						  pedi_fecha_creacion,   
						  pedi_fecha_modificacion,   
						  pedi_dias_pago,   
						  pedi_consignado,   
						  pedi_a_nombre,   
						  pedi_a_nombre_direccion,   
						  pedi_despachado,   
						  pedi_via,   
						  pedi_con_emb_no,   
						  pedi_marca,   
						  pedi_bultos_total,   
						  pedi_cubicaje_total,   
						  pedi_peso_total,   
						  pedi_unidad_peso,   
						  pedi_gastos_total,   
						  pedi_monto_total,   
						  pedi_descu_subt_deta,   
						  pedi_por_descuento,   
						  pedi_supervisor,   
						  pedi_monto_final,   
						  pedi_comentario,   
						  pedi_estado,   
						  pedi_autorizacion,   
						  pedi_actualizo_cargos,   
						  pedi_actualizo_vendedor,   
						  pedi_factura_de_bodega,   
						  pedi_fecha_fin_plazo,
						  pedi_cuatro_decimales,
						  pedi_usuario,
						  pedi_precio_a_utilizar,
						  pedi_costos_total)  
				  SELECT :ii_g_financiero,   
							:ii_empresa,   
							fatpedid.pedi_tipo,   
							fatpedid.pedi_no_pedido,   
							fatpedid.pedi_ann,   
							fatpedid.pedi_cliente,   
							fatpedid.pedi_ruc_cliente,   
							fatpedid.pedi_condicion_pago,   
							fatpedid.pedi_tipo_venta,   
							fatpedid.pedi_tipo_movimiento,   
							fatpedid.pedi_no_traspaso,   
							fatpedid.pedi_fecha,   
							fatpedid.pedi_fecha_creacion,   
							fatpedid.pedi_fecha_modificacion,   
							fatpedid.pedi_dias_pago,   
							fatpedid.pedi_consignado,   
							fatpedid.pedi_a_nombre,   
							fatpedid.pedi_a_nombre_direccion,   
							fatpedid.pedi_despachado,   
							fatpedid.pedi_via,   
							fatpedid.pedi_con_emb_no,   
							fatpedid.pedi_marca,   
							fatpedid.pedi_bultos_total,   
							fatpedid.pedi_cubicaje_total,   
							fatpedid.pedi_peso_total,   
							fatpedid.pedi_unidad_peso,   
							fatpedid.pedi_gastos_total,   
							fatpedid.pedi_monto_total,   
							fatpedid.pedi_descu_subt_deta,   
							fatpedid.pedi_por_descuento,   
							fatpedid.pedi_supervisor,   
							fatpedid.pedi_monto_final,   
							fatpedid.pedi_comentario,   
							'A',   
							fatpedid.pedi_autorizacion,   
							fatpedid.pedi_actualizo_cargos,   
							fatpedid.pedi_actualizo_vendedor,   
							fatpedid.pedi_factura_de_bodega,   
							fatpedid.pedi_fecha_fin_plazo,
							fatpedid.pedi_cuatro_decimales,
						   fatpedid.pedi_usuario,
						   fatpedid.pedi_precio_a_utilizar,
						   fatpedid.pedi_costos_total
					 FROM fatpedid  
					WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
							( fatpedid.pedi_empresa = :str.empresa ) AND  
							( fatpedid.pedi_no_pedido = :ls_pedido ) AND  
							( fatpedid.pedi_ann = :ll_ann )   ;
						if sqlca.sqlcode = -1 then	
							mensaje("Aviso","Error al Crear el Encabezado del Pedido "+ls_pedido,sqlca.sqlerrtext)
							rollback using sqlca;
							dw_4.setfilter("")
							dw_4.filter()															
							return
						end if
						
						
					//Inserta el detalle del Pedido
					  INSERT INTO fadpedid  
						( dped_g_financiero,   
						  dped_empresa,   
						  dped_no_pedido,   
						  dped_ann,   
						  dped_linea,   
						  dped_producto_servicio,   
						  dped_codigo_item,   
						  dped_descripcion_alterna,   
						  dped_cubicaje,   
						  dped_peso,   
						  dped_unidad_peso,   
						  dped_unidad_producto,   
						  dped_precio_mayor,   
						  dped_precio_menor,   
						  dped_bodega,   
						  dped_costo_fob,   
						  dped_costo_cif,   
						  dped_precio_unidad_producto,   
						  dped_unidad_venta,   
						  dped_cantidad,   
						  dped_fraccion,   
						  dped_monto_total,   
						  dped_por_descuento,   
						  dped_monto_final,   
						  dped_fecha_reg,   
						  dped_usuario,   
						  dped_supervisor,   
						  dped_bultos,   
						  dped_ubicacion,   
						  dped_pasada,   
						  dped_cant_asignada,   
						  dped_index,   
						  dped_validado,   
						  dped_vendedor,   
						  dped_pedido_vta_detal,
						  dped_bulto_inicio,
						  dped_bulto_fin,
						  dped_precio_original,
						  dped_costo_total,
						  dped_bultos_cambiados,
						  dped_peso_cambiado,
						  dped_cubicaje_cambiado)  
				  SELECT :ii_g_financiero,   
							:ii_empresa,   
							fadpedid.dped_no_pedido,   
							fadpedid.dped_ann,   
							fadpedid.dped_linea,   
							fadpedid.dped_producto_servicio,   
							fadpedid.dped_codigo_item,   
							fadpedid.dped_descripcion_alterna,   
							fadpedid.dped_cubicaje,   
							fadpedid.dped_peso,   
							fadpedid.dped_unidad_peso,   
							fadpedid.dped_unidad_producto,   
							fadpedid.dped_precio_mayor,   
							fadpedid.dped_precio_menor,   
							isnull(:ls_bodega_des, fadpedid.dped_bodega),   
							fadpedid.dped_costo_fob,   
							fadpedid.dped_costo_cif,   
							fadpedid.dped_precio_unidad_producto,   
							fadpedid.dped_unidad_venta,   
							fadpedid.dped_cantidad,   
							fadpedid.dped_fraccion,   
							fadpedid.dped_monto_total,   
							fadpedid.dped_por_descuento,   
							fadpedid.dped_monto_final,   
							fadpedid.dped_fecha_reg,   
							fadpedid.dped_usuario,   
							fadpedid.dped_supervisor,   
							fadpedid.dped_bultos,   
							isnull(:ls_ubicacion_des, fadpedid.dped_ubicacion) ,   
							0,
							fadpedid.dped_cant_asignada,   
							fadpedid.dped_index,   
							fadpedid.dped_validado,   
							fadpedid.dped_vendedor,   
							fadpedid.dped_pedido_vta_detal,
						   fadpedid.dped_bulto_inicio,
						   fadpedid.dped_bulto_fin,
						   fadpedid.dped_precio_original,
						   fadpedid.dped_costo_total,
						   fadpedid.dped_bultos_cambiados,
						   fadpedid.dped_peso_cambiado,
					 		fadpedid.dped_cubicaje_cambiado							
					 FROM fadpedid,inamedid  
					WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
							( fadpedid.dped_empresa = :str.empresa ) AND  
							( fadpedid.dped_no_pedido = :ls_pedido ) AND  
							( fadpedid.dped_ann = :ll_ann ) and
							( fadpedid.dped_unidad_venta = inamedid.medi_medida ) ;
						if sqlca.sqlcode = -1 then	
							mensaje("Aviso","Error al Crear el Detalle del Pedido "+ls_pedido,sqlca.sqlerrtext)
							rollback using sqlca;
							dw_4.setfilter("")
							dw_4.filter()															
							return
						end if
//Antes ponia el pedido como pasado y asignaba la cantidad a dped_pasada ?
//quitado el 07/05/2001 (fadpedid.dped_cantidad * inamedid.medi_cantidad) + fadpedid.dped_fraccion,			

					//Inserta los Cargos del Pedido
					INSERT INTO fadpecar  
						( peca_g_financiero,   
						  peca_empresa,   
						  peca_no_pedido,   
						  peca_ann,   
						  peca_codigo_cargo,   
						  peca_monto )  
				  SELECT :ii_g_financiero,   
							:ii_empresa,   
							fadpecar.peca_no_pedido,   
							fadpecar.peca_ann,   
							fadpecar.peca_codigo_cargo,   
							fadpecar.peca_monto  
					 FROM fadpecar  
					WHERE ( fadpecar.peca_g_financiero = :str.g_financiero ) AND  
							( fadpecar.peca_empresa = :str.empresa ) AND  
							( fadpecar.peca_no_pedido = :ls_pedido ) AND  
							( fadpecar.peca_ann = :ll_ann )   ;
						if sqlca.sqlcode = -1 then	
							mensaje("Aviso","Error al Crear los Cargos del Pedido "+ls_pedido,sqlca.sqlerrtext)
							rollback using sqlca;
							dw_4.setfilter("")
							dw_4.filter()															
							return
						end if
					
					//Se insertan los vendedores asociados
					  INSERT INTO fadvenpe  
						( vped_g_financiero,   
						  vped_empresa,   
						  vped_tipo,   
						  vped_no_pedido,   
						  vped_ann,   
						  vped_vendedor )  
					  SELECT :ii_g_financiero,   
								:ii_empresa,   
								fadvenpe.vped_tipo,   
								fadvenpe.vped_no_pedido,   
								fadvenpe.vped_ann,   
								fadvenpe.vped_vendedor  
						 FROM fadvenpe  
						WHERE ( fadvenpe.vped_g_financiero = :str.g_financiero ) AND  
								( fadvenpe.vped_empresa = :str.empresa ) AND  
								( fadvenpe.vped_no_pedido = :ls_pedido ) AND  
								( fadvenpe.vped_ann = :ll_ann )   ;
						if sqlca.sqlcode = -1 then	
							mensaje("Aviso","Error al Crear los Vendedores del Pedido "+ls_pedido,sqlca.sqlerrtext)
							rollback using sqlca;
							dw_4.setfilter("")
							dw_4.filter()															
							return
						end if
			Else   //Si va hacia facturas
					
					//Valida la existencia del pedido
					  SELECT count(*)  
						 INTO :li_encontrado  
						 FROM fatdiari  
						WHERE ( fatdiari.fact_g_financiero = :ii_g_financiero ) AND  
								( fatdiari.fact_empresa = :ii_empresa ) AND  
								( fatdiari.fact_no_pedido = :ls_pedido ) AND  
								( fatdiari.fact_ann = :ll_ann )   ;				
								
					if sqlca.sqlcode = -1 then	
							mensaje("Aviso","Error al verificar existencia del pedido",sqlca.sqlerrtext)
							rollback using sqlca;
							dw_4.setfilter("")
							dw_4.filter()															
							return
						end if
						
					  if li_encontrado > 0 then
						 mensaje("Aviso","Atención Sr. Usuario, el Pedido "+ls_pedido+" del "+string(ll_ann)+ " Ya existe. Verifique","")
						 continue //Para que pase al siguiente registro
					  end if
				
					// Inserta el encabezado
					  INSERT INTO fatdiari  
						( fact_g_financiero,   
						  fact_empresa,   
						  fact_tipo,   
						  fact_no_pedido,   
						  fact_ann,   
						  fact_no_factura,   
						  fact_cliente,   
						  fact_ruc_cliente,   
						  fact_condicion_pago,   
						  fact_tipo_venta,   
						  fact_tipo_movimiento,   
						  fact_no_traspaso,   
						  fact_fecha,   
						  fact_fecha_creacion,   
						  fact_fecha_modificacion,   
						  fact_dias_pago,   
						  fact_fecha_fin_plazo,   
						  fact_fecha_cancelado,   
						  fact_consignado,   
						  fact_a_nombre,   
						  fact_a_nombre_direccion,   
						  fact_despachado,   
						  fact_via,   
						  fact_con_emb_no,   
						  fact_marca,   
						  fact_bultos_total,   
						  fact_cubicaje_total,   
						  fact_peso_total,   
						  fact_unidad_peso,   
						  fact_gastos_total,   
						  fact_monto_fact_total,   
						  fact_descuento_subt_deta,   
						  fact_por_descuento,   
						  fact_supervisor,   
						  fact_monto_final,   
						  fact_comentario,   
						  fact_estado,   
						  fact_autorizacion,   
						  fact_actualizo_cargos,   
						  fact_actualizo_vendedor,   
						  fact_factura_de_bodega,   
						  fact_viene_de_pedido,
						  fact_cuatro_decimales,
						  fact_usuario,
						  fact_precio_a_utilizar,
						  fact_costos_total )  
				 Select  :ii_g_financiero,
							:ii_empresa,
							fatpedid.pedi_tipo,   
							fatpedid.pedi_no_pedido,   
							fatpedid.pedi_ann,   
							'',
							fatpedid.pedi_cliente,   
							fatpedid.pedi_ruc_cliente,   
							fatpedid.pedi_condicion_pago,   
							fatpedid.pedi_tipo_venta,   
							fatpedid.pedi_tipo_movimiento,   
							fatpedid.pedi_no_traspaso,   
							fatpedid.pedi_fecha,   
							fatpedid.pedi_fecha_creacion,   
							fatpedid.pedi_fecha_modificacion,   
							fatpedid.pedi_dias_pago,   
							isnull(fatpedid.pedi_fecha_fin_plazo,pedi_fecha),
							null,
							fatpedid.pedi_consignado,   
							fatpedid.pedi_a_nombre,   
							fatpedid.pedi_a_nombre_direccion,   
							fatpedid.pedi_despachado,   
							fatpedid.pedi_via,   
							fatpedid.pedi_con_emb_no,   
							fatpedid.pedi_marca,   
							fatpedid.pedi_bultos_total,   
							fatpedid.pedi_cubicaje_total,   
							fatpedid.pedi_peso_total,   
							fatpedid.pedi_unidad_peso,   
							fatpedid.pedi_gastos_total,   
							fatpedid.pedi_monto_total,   
							fatpedid.pedi_descu_subt_deta,   
							fatpedid.pedi_por_descuento,   
							fatpedid.pedi_supervisor,   
							fatpedid.pedi_monto_final,   
							fatpedid.pedi_comentario,   
							'A',   
							fatpedid.pedi_autorizacion,   
							fatpedid.pedi_actualizo_cargos,   
							fatpedid.pedi_actualizo_vendedor,   
							fatpedid.pedi_factura_de_bodega,   
							0,
						   fatpedid.pedi_cuatro_decimales,
						   fatpedid.pedi_usuario,
						   fatpedid.pedi_precio_a_utilizar,
						   fatpedid.pedi_costos_total							
					 FROM fatpedid  
					WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
							( fatpedid.pedi_empresa = :str.empresa ) AND  
							( fatpedid.pedi_no_pedido = :ls_pedido ) AND  
							( fatpedid.pedi_ann = :ll_ann )   ;							 
						if sqlca.sqlcode = -1 then	
							mensaje("Aviso","Error al Crear el Encabezado del Pedido "+ls_pedido,sqlca.sqlerrtext)
							rollback using sqlca;
							dw_4.setfilter("")
							dw_4.filter()															
							return
						end if
		
						//Inserta el detalle del Pedido
						INSERT INTO faddiari  
							( facd_g_financiero,   
							  facd_empresa,   
							  facd_tipo,   
							  facd_no_pedido,   
							  facd_linea,   
							  facd_ann,   
							  facd_producto_servicio,   
							  facd_codigo_item,   
							  facd_descripcion_alterna,   
							  facd_cubicaje,   
							  facd_peso,   
							  facd_unidad_peso,   
							  facd_unidad_producto,   
							  facd_precio_mayor,   
							  facd_precio_menor,   
							  facd_bodega,   
							  facd_costo_fob,   
							  facd_costo_cif,   
							  facd_precio_unidad_producto,   
							  facd_unidad_venta,   
							  facd_cantidad,   
							  facd_cantidad_fraccion,   
							  facd_monto_total,   
							  facd_por_descuento,   
							  facd_monto_final,   
							  facd_fecha_reg,   
							  facd_usuario,   
							  facd_supervisor,   
							  facd_bultos,   
							  facd_ubicacion,   
							  facd_index,   
							  facd_validado,   
							  facd_viene_de_pedido,
							  facd_bulto_inicio,
							  facd_bulto_fin,
							  facd_precio_original,
							  facd_costo_total,
							  facd_bultos_cambiados,
							  facd_peso_cambiado,
							  facd_cubicaje_cambiado)  
							 SELECT  :ii_g_financiero,
									   :ii_empresa,
										:ls_tipo,
										fadpedid.dped_no_pedido,   
										fadpedid.dped_linea,   
										fadpedid.dped_ann,   										
										fadpedid.dped_producto_servicio,   
										fadpedid.dped_codigo_item,   
										fadpedid.dped_descripcion_alterna,   
										fadpedid.dped_cubicaje,   
										fadpedid.dped_peso,   
										fadpedid.dped_unidad_peso,   
										fadpedid.dped_unidad_producto,   
										fadpedid.dped_precio_mayor,   
										fadpedid.dped_precio_menor,   
										isnull(:ls_bodega_des, fadpedid.dped_bodega),   
										fadpedid.dped_costo_fob,   
										fadpedid.dped_costo_cif,   
										fadpedid.dped_precio_unidad_producto,   
										fadpedid.dped_unidad_venta,   
										fadpedid.dped_cantidad,   
										fadpedid.dped_fraccion,   
										fadpedid.dped_monto_total,   
										fadpedid.dped_por_descuento,   
										fadpedid.dped_monto_final,   
										fadpedid.dped_fecha_reg,   
										fadpedid.dped_usuario,   
										fadpedid.dped_supervisor,   
										fadpedid.dped_bultos,   
										isnull(:ls_ubicacion_des, fadpedid.dped_ubicacion),   
										fadpedid.dped_index,   
										fadpedid.dped_validado,   
										0,
									  fadpedid.dped_bulto_inicio,
									  fadpedid.dped_bulto_fin,
									  fadpedid.dped_precio_original,
									  fadpedid.dped_costo_total,
									  fadpedid.dped_bultos_cambiados,
									  fadpedid.dped_peso_cambiado,
									  fadpedid.dped_cubicaje_cambiado										
								 FROM fadpedid  
								WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
										( fadpedid.dped_empresa = :str.empresa ) AND  
										( fadpedid.dped_no_pedido = :ls_pedido ) AND  
										( fadpedid.dped_ann = :ll_ann )   ;
								if sqlca.sqlcode = -1 then	
									mensaje("Aviso","Error al Crear el Detalle del Pedido "+ls_pedido,sqlca.sqlerrtext)
									rollback using sqlca;
									dw_4.setfilter("")
									dw_4.filter()																	
									return
								end if
		
							//Inserta los Cargos del Pedido
							  INSERT INTO fadcargo  
									( dcar_g_financiero,   
									  dcar_empresa,   
									  dcar_tipo,   
									  dcar_no_pedido,   
									  dcar_ann,   
									  dcar_codigo,   
									  dcar_monto )  
							  SELECT :ii_g_financiero,   
										:ii_empresa,   
										:ls_tipo,   
										fadpecar.peca_no_pedido,   
										fadpecar.peca_ann,   
										fadpecar.peca_codigo_cargo,   
										fadpecar.peca_monto  
								 FROM fadpecar  
								WHERE ( fadpecar.peca_g_financiero = :str.g_financiero ) AND  
										( fadpecar.peca_empresa = :str.empresa ) AND  
										( fadpecar.peca_no_pedido = :ls_pedido ) AND  
										( fadpecar.peca_ann = :ll_ann ) ;							
									if sqlca.sqlcode = -1 then	
										mensaje("Aviso","Error al Crear los Cargos del Pedido "+ls_pedido,sqlca.sqlerrtext)
										rollback using sqlca;
										dw_4.setfilter("")
										dw_4.filter()																		
										return
									end if
								
							//Se insertan los vendedores asociados
								  INSERT INTO fadvenfa  
										( vfac_g_financiero,   
										  vfac_empresa,   
										  vfac_tipo,   
										  vfac_no_pedido,   
										  vfac_ann,   
										  vfac_vendedor )  
								  SELECT :ii_g_financiero,   
											:ii_empresa,   
											:ls_tipo,   
											fadvenpe.vped_no_pedido,   
											fadvenpe.vped_ann,   
											fadvenpe.vped_vendedor  
									 FROM fadvenpe  
									WHERE ( fadvenpe.vped_g_financiero = :str.g_financiero ) AND  
											( fadvenpe.vped_empresa = :str.empresa ) AND  
											( fadvenpe.vped_no_pedido = :ls_pedido ) AND  
											( fadvenpe.vped_ann = :ll_ann )   ;									
									if sqlca.sqlcode = -1 then	
										mensaje("Aviso","Error al Crear los Vendedores del Pedido "+ls_pedido,sqlca.sqlerrtext)
										rollback using sqlca;
										dw_4.setfilter("")
										dw_4.filter()																		
										return
									end if						
							
			End if //Del Hacia donde va ..Pedidos o factura	 
			//Actualiza el Estado de Pasado a empresa = 1
			  UPDATE fatpedid  
				  SET pedi_pasado_a_empresa = 1
				WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
						( fatpedid.pedi_empresa = :str.empresa ) AND  
						( fatpedid.pedi_no_pedido = :ls_pedido ) AND  
						( fatpedid.pedi_ann = :ll_ann )   ;
			if sqlca.sqlcode = -1 then	
				mensaje("Aviso","Error al Actualizar Estado de Pasado a Empresa"+ls_pedido,sqlca.sqlerrtext)
				rollback using sqlca;
				dw_4.setfilter("")
				dw_4.filter()													
				return
		   end if			
	
	lb_entro = true
	
	commit;
		
//	End if //Del incluir = 'S'
next

if lb_entro then
	mensaje("Atención","Pase Ejecutado Satisfactoriamente","")
	dw_4.setfilter("")
	dw_4.filter()									
	dw_4.Retrieve(str.g_financiero, str.empresa,il_tercero)
	dw_4.setfocus()
end if
end subroutine

on w_fa_man_pasar_facturas.create
int iCurrent
call super::create
this.st_4=create st_4
this.cb_procesar=create cb_procesar
this.st_3=create st_3
this.dw_4=create dw_4
this.dw_3=create dw_3
this.sle_lineas=create sle_lineas
this.cbx_cargos=create cbx_cargos
this.ddlb_1=create ddlb_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_4
this.Control[iCurrent+2]=this.cb_procesar
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.dw_4
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.sle_lineas
this.Control[iCurrent+7]=this.cbx_cargos
this.Control[iCurrent+8]=this.ddlb_1
this.Control[iCurrent+9]=this.st_1
end on

on w_fa_man_pasar_facturas.destroy
call super::destroy
destroy(this.st_4)
destroy(this.cb_procesar)
destroy(this.st_3)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.sle_lineas)
destroy(this.cbx_cargos)
destroy(this.ddlb_1)
destroy(this.st_1)
end on

event ue_post_open;//Override
long  	ll_tercero, ll_encontro
string ls_nombre
this.y = 1
this.setredraw(false)
  SELECT inaparam.para_cliente_control ,
  			inaparam.para_grupo_f_entrada,
			inaparam.para_empresa_entrada  
    INTO :ll_tercero,
	 		:ii_g_financiero,
			:ii_empresa 
    FROM inaparam  
   WHERE ( inaparam.para_g_financiero = :str.g_financiero ) AND  
         ( inaparam.para_empresa = :str.empresa )   ;
	if sqlca.sqlcode = -1 then
		mensaje("Aviso","Error al seleccionar el cliente control",sqlca.sqlerrtext)
	end if
	
  SELECT dgmempre.empr_razon_social  
    INTO :ls_nombre  
    FROM dgmempre  
   WHERE ( dgmempre.empr_g_financiero = :ii_g_financiero ) AND  
         ( dgmempre.empr_empresa = :ii_empresa )   ;
	if sqlca.sqlcode = -1 then
		mensaje("Aviso","Error al seleccionar el nombre de la empresa",sqlca.sqlerrtext)
	end if	

	This.title = 'Pasar los Pedidos a '+ls_nombre
	
dw_1.GetChild('cliente', dwc_cliente)
dwc_cliente.Settransobject(sqlca);

If dwc_cliente.Retrieve(str.g_financiero, str.empresa) < 1 Then  dwc_cliente.Insertrow(0)

dw_1.insertrow(0)

ll_encontro = dwc_cliente.find("terc_tercero = "+string(ll_tercero),1,dwc_cliente.rowcount())

if ll_encontro <> 0 then
	dwc_cliente.Scrolltorow(ll_encontro)
	dw_1.setitem(1,"cliente",ll_tercero)
	il_tercero = ll_tercero
else
	dwc_cliente.Scrolltorow(1)
end if

ddlb_1.text = 'PEDIDO'

dw_4.Settransobject(sqlca);
dw_4.insertrow(0)
dw_4.Retrieve(str.g_financiero, str.empresa,ll_tercero)

dw_4.SetFocus()
this.setredraw(true)
end event

event resize;//Override
//
//this.X=5
//tHIS.Y=5
//
end event

event key;call super::key;if key = keyF1! then
//	this.Postevent("ue_help")
end if
end event

event open;///***************************/
gf_center_win(This)
dw = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()


This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)
str.frame.SetRedraw ( True )
This.Icon = str.icono
this.postevent("ue_post_open")
end event

event ue_print;//Override

OpenWithParm(w_dw_print_options, dw)
If Message.DoubleParm = -1 Then Return
dw.Print(True)

end event

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_man_pasar_facturas
boolean visible = false
integer y = 1196
integer width = 832
integer height = 72
end type

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_man_pasar_facturas
integer x = 1202
integer y = 772
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_man_pasar_facturas
event ue_positemchanged ( string as_columna,  long row,  string data )
integer x = 421
integer y = 40
integer width = 1070
integer height = 100
integer taborder = 10
string dataobject = "dw_pr_fa_pedidos_cliente"
boolean livescroll = false
borderstyle borderstyle = stylelowered!
end type

event dw_1::ue_positemchanged;Integer	li_dias_pago
String	ls_peri_descripcion,ls_condicion_de_pago,ls_cond_pago
Long		ll_rows

il_tercero = long(data)

dw_4.Retrieve(str.g_financiero, str.empresa,il_tercero)

end event

event dw_1::ue_escape;//Override
end event

event dw_1::itemchanged;this.post event ue_positemchanged(dw_1.Getcolumnname(),row,data)

end event

event dw_1::clicked;call super::clicked;//str_pedi.cliente = dwc_cliente.GetItemNumber(dwc_cliente.GetRow(),"terc_tercero")
//dw_4.Retrieve(str.g_financiero, str.empresa,str_pedi.cliente) 

end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_man_pasar_facturas
boolean visible = false
integer x = 32
integer y = 876
integer width = 2670
integer height = 120
integer taborder = 0
long textcolor = 8388608
long backcolor = 79741120
string text = "Seleccione los Datos del Informe"
borderstyle borderstyle = styleraised!
end type

type st_4 from statictext within w_fa_man_pasar_facturas
integer x = 174
integer y = 52
integer width = 224
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Cliente"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_procesar from commandbutton within w_fa_man_pasar_facturas
integer x = 2208
integer y = 1196
integer width = 274
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked;//Función en la que se procede a pasar los pedidos seleccionados a la empresa seleccionada
//en inventario
sqlca.autocommit = false
wf_procesar()
end event

type st_3 from statictext within w_fa_man_pasar_facturas
integer x = 2199
integer y = 1188
integer width = 288
integer height = 104
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_4 from datawindow within w_fa_man_pasar_facturas
integer x = 187
integer y = 172
integer width = 2299
integer height = 1000
integer taborder = 20
string dataobject = "dw_pr_fa_pedidos_por_cliente"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto
integer li_pos 

this.Setredraw(false)

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if right(ls_objeto,2)='_t' then

	ls_objeto = left(ls_objeto,len(ls_objeto)-2)
	
	if ls_objeto = is_ultima_ or is_ultima_ = "" then	//Si es la misma columna 
																	// o si es la primera vez
		if is_orden_  = "" or is_orden_ = "D" then
			is_orden_ = 'A'		
			this.SetSort(ls_objeto+" A")	//Ordena Ascendente
			this.sort()		
		else
			is_orden_ = 'D'					
			this.SetSort(ls_objeto+" D")	//Ordena Descendente
			this.sort()				
		end if	
		is_ultima_ = ls_objeto		
	else				
			is_orden_ = 'A'
			this.SetSort(ls_objeto+" A")
			this.sort()
			is_ultima_ = ls_objeto
	end if

end if

this.Setredraw(true)
end event

event retrieveend;sqlca.autocommit = true
end event

type dw_3 from datawindow within w_fa_man_pasar_facturas
boolean visible = false
integer x = 553
integer y = 1076
integer width = 1298
integer height = 368
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ma_fa_carfactura_resumida"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_lineas from singlelineedit within w_fa_man_pasar_facturas
boolean visible = false
integer x = 1769
integer y = 1196
integer width = 247
integer height = 60
integer taborder = 50
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cbx_cargos from checkbox within w_fa_man_pasar_facturas
boolean visible = false
integer x = 1184
integer y = 1196
integer width = 530
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detalle de gastos"
boolean lefttext = true
end type

type ddlb_1 from dropdownlistbox within w_fa_man_pasar_facturas
integer x = 2135
integer y = 52
integer width = 361
integer height = 276
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"PEDIDO","FACTURA"}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_fa_man_pasar_facturas
integer x = 1893
integer y = 64
integer width = 219
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Pasar a:"
boolean focusrectangle = false
end type

