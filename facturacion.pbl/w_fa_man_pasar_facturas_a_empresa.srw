//objectcomments Pase de Pedidos a otra empresa
forward
global type w_fa_man_pasar_facturas_a_empresa from w_fa_padre_reportes
end type
type st_4 from statictext within w_fa_man_pasar_facturas_a_empresa
end type
type cb_procesar from commandbutton within w_fa_man_pasar_facturas_a_empresa
end type
type st_3 from statictext within w_fa_man_pasar_facturas_a_empresa
end type
type dw_4 from datawindow within w_fa_man_pasar_facturas_a_empresa
end type
type dw_3 from datawindow within w_fa_man_pasar_facturas_a_empresa
end type
type sle_lineas from singlelineedit within w_fa_man_pasar_facturas_a_empresa
end type
type cbx_cargos from checkbox within w_fa_man_pasar_facturas_a_empresa
end type
type st_1 from statictext within w_fa_man_pasar_facturas_a_empresa
end type
type em_ann from editmask within w_fa_man_pasar_facturas_a_empresa
end type
type st_2 from statictext within w_fa_man_pasar_facturas_a_empresa
end type
type dw_2 from datawindow within w_fa_man_pasar_facturas_a_empresa
end type
end forward

global type w_fa_man_pasar_facturas_a_empresa from w_fa_padre_reportes
integer x = 1271
integer y = 160
integer width = 2688
integer height = 1740
string title = "Pasar Facturas a ..."
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 12639424
string icon = "Application!"
boolean center = true
windowanimationstyle openanimation = bottomslide!
event ue_help ( )
st_4 st_4
cb_procesar cb_procesar
st_3 st_3
dw_4 dw_4
dw_3 dw_3
sle_lineas sle_lineas
cbx_cargos cbx_cargos
st_1 st_1
em_ann em_ann
st_2 st_2
dw_2 dw_2
end type
global w_fa_man_pasar_facturas_a_empresa w_fa_man_pasar_facturas_a_empresa

type variables
//Variable para asignar el nombre de la Empresa al DW
string is_unian
Integer id_selec, ii_contador,id_fraccion,id_cantidad, ii_ann
window iw_pedidos
integer ii_g_financiero, ii_empresa
Datawindowchild dwc_tipo_fact, dwc_pedido, dwc_cliente, dwc_cliente_destino
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
string	ls_incluir, ls_pedido, ls_tipo, ls_bodega_des, ls_ubicacion_des, ls_a_nombre_destino, ls_direccion_destino, ls_cuenta_destino
long		ll_ann, ll_cliente_destino
boolean 	lb_entro = false

ll_cliente_destino = dw_2.getitemnumber(1,'cliente')
if ll_cliente_destino = 0 or isnull(ll_cliente_destino) then
	gf_mensaje('','Debe Seleccionar el Cliente Destino, Verifique !!!',1,1,'E')
	dw_2.setfocus()
	return
else
	  SELECT ccmclien.clie_ref_anterior,   
				dgmterce.terc_descripcion,   
				dgmterce.terc_direccion  
		 INTO :ls_cuenta_destino,   
				:ls_a_nombre_destino,   
				:ls_direccion_destino  
		 FROM ccmclien,   
				dgmterce  
		WHERE ( dgmterce.terc_tercero = ccmclien.clie_tercero ) and  
				( ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
				( ccmclien.clie_empresa = :str.empresa ) AND  
				( ccmclien.clie_tercero = :ll_cliente_destino ) )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Buscar datos del cliente '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
end if

dw_4.setfilter("fact_incluir = 'S'")
dw_4.filter()

if dw_4.rowcount() = 0 then
	gf_mensaje('','¿ Debe seleccionar la factura a pasar ?',1,1,'E')
	dw_4.setfilter("")
	dw_4.filter()
	return
elseif gf_mensaje('','Está seguro de Efectuar el Pase de la Factura',2,1,'E') = 2 then 
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
end if

if isnull(ls_bodega_des) or isnull(ls_ubicacion_des) then 
	messagebox('Aviso'," -* Bodega o Ubicacion no Definida en Inventarios *- ")
elseif ls_bodega_des = '' or ls_ubicacion_des = '' then
	//Si tiene espacios, se le asigna null para que al insertar, asigne la bodega y ubicacion
	//original de la factura
	setnull(ls_bodega_des)
	setnull(ls_ubicacion_des)
end if

sqlca.autocommit = false

for i = 1 to dw_4.rowcount()
		
		  ls_pedido = dw_4.getitemString(i,"fact_no_pedido")
		  ll_ann		= dw_4.getitemNumber(i,"fact_ann")
		  ls_tipo	= dw_4.getitemString(i,"fact_tipo") //Para el detalle de faddiari
					
					//Valida la existencia del pedido
					  SELECT count(*)  
						 INTO :li_encontrado  
						 FROM fatdiari  
						WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
								( fatdiari.fact_empresa = :str.empresa ) AND  
								( fatdiari.fact_no_pedido = :ls_pedido ) AND  
								( fatdiari.fact_tipo = :ls_tipo ) AND  								
								( fatdiari.fact_ann = :ll_ann )   ;				
								
					if sqlca.sqlcode = -1 then	
							mensaje("Aviso","Error al verificar existencia del pedido",sqlca.sqlerrtext)
							dw_4.setfilter("")
						   dw_4.filter()							
							rollback;
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
						  fact_costos_total,
						  fact_fecha_despacho,
						  fact_pasaporte,
						  fact_linea_aerea)  
				 Select  :str.g_financiero,
							:str.empresa,
							fatdiari.fact_tipo,   
							fatdiari.fact_no_pedido,   
							fatdiari.fact_ann,   
							'',
							:ll_cliente_destino,   
							:ls_cuenta_destino,   
							fatdiari.fact_condicion_pago,   
							fatdiari.fact_tipo_venta,   
							fatdiari.fact_tipo_movimiento,   
							fatdiari.fact_no_traspaso,   
							fatdiari.fact_fecha,   
							fatdiari.fact_fecha_creacion,   
							fatdiari.fact_fecha_modificacion,   
							fatdiari.fact_dias_pago,   
							isnull(fatdiari.fact_fecha_fin_plazo,fact_fecha),
							null,
							fatdiari.fact_consignado,   
							:ls_a_nombre_destino,   
							:ls_direccion_destino,   
							fatdiari.fact_despachado,   
							fatdiari.fact_via,   
							fatdiari.fact_con_emb_no,   
							fatdiari.fact_marca,   
							fatdiari.fact_bultos_total,   
							fatdiari.fact_cubicaje_total,   
							fatdiari.fact_peso_total,   
							fatdiari.fact_unidad_peso,   
							fatdiari.fact_gastos_total,   
							fatdiari.fact_monto_fact_total,   
							fatdiari.fact_descuento_subt_deta,   
							fatdiari.fact_por_descuento,   
							fatdiari.fact_supervisor,   
							fatdiari.fact_monto_final,   
							fatdiari.fact_comentario,   
							'A',   
							fatdiari.fact_autorizacion,   
							fatdiari.fact_actualizo_cargos,   
							fatdiari.fact_actualizo_vendedor,   
							fatdiari.fact_factura_de_bodega,   
							0,
						   fatdiari.fact_cuatro_decimales,
							:str.usuario,
						   fatdiari.fact_precio_a_utilizar,
						   fatdiari.fact_costos_total,
						   fatdiari.fact_fecha_despacho,
						   fatdiari.fact_pasaporte,
						   fatdiari.fact_linea_aerea		
					 FROM fatdiari
					WHERE ( fatdiari.fact_g_financiero = :ii_g_financiero ) AND  
							( fatdiari.fact_empresa = :ii_empresa ) AND  
							( fatdiari.fact_no_pedido = :ls_pedido ) AND  
							( fatdiari.fact_tipo = :ls_tipo ) AND  															
							( fatdiari.fact_ann = :ll_ann )   ;							 
						if sqlca.sqlcode = -1 then	
							mensaje("Aviso","Error al Crear el Encabezado del Pedido "+ls_pedido,sqlca.sqlerrtext)
							rollback;
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
							  facd_cubicaje_cambiado,
							  facd_peso_neto,
							  facd_cubicaje_metros) 
							 SELECT  :str.g_financiero,
									     :str.empresa,
										:ls_tipo,
										faddiari.facd_no_pedido,   
										faddiari.facd_linea,   
										faddiari.facd_ann,   										
										faddiari.facd_producto_servicio,   
										faddiari.facd_codigo_item,   
										faddiari.facd_descripcion_alterna,   
										faddiari.facd_cubicaje,   
										faddiari.facd_peso,   
										faddiari.facd_unidad_peso,   
										faddiari.facd_unidad_producto,   
										faddiari.facd_precio_mayor,   
										faddiari.facd_precio_menor,   
										isnull(:ls_bodega_des,faddiari.facd_bodega),   
										faddiari.facd_costo_fob,   
										faddiari.facd_costo_cif,   
										faddiari.facd_precio_unidad_producto,   
										faddiari.facd_unidad_venta,   
										faddiari.facd_cantidad,   
										faddiari.facd_cantidad_fraccion,   
										faddiari.facd_monto_total,   
										faddiari.facd_por_descuento,   
										faddiari.facd_monto_final,   
										faddiari.facd_fecha_reg,   
										faddiari.facd_usuario,   
										faddiari.facd_supervisor,   
										faddiari.facd_bultos,   
										isnull(:ls_ubicacion_des,faddiari.facd_ubicacion) ,   
										faddiari.facd_index,   
										faddiari.facd_validado,   
										0,
									   faddiari.facd_bulto_inicio,
									   faddiari.facd_bulto_fin,
									   faddiari.facd_precio_original,
									   faddiari.facd_costo_total,
									   faddiari.facd_bultos_cambiados,
									   faddiari.facd_peso_cambiado,
									   faddiari.facd_cubicaje_cambiado,
									   facd_peso_neto,
									   facd_cubicaje_metros
								 FROM faddiari  
								WHERE ( faddiari.facd_g_financiero = :ii_g_financiero ) AND  
										( faddiari.facd_empresa = :ii_empresa ) AND  
										( faddiari.facd_no_pedido = :ls_pedido ) AND  
										( faddiari.facd_tipo = :ls_tipo ) AND  																		
										( faddiari.facd_ann = :ll_ann )   ;
								if sqlca.sqlcode = -1 then	
									mensaje("Aviso","Error al Crear el Detalle del Pedido "+ls_pedido,sqlca.sqlerrtext)
									rollback;
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
							  SELECT :str.g_financiero,   
										:str.empresa,   
										:ls_tipo,   
										fadcargo.dcar_no_pedido,   
										fadcargo.dcar_ann,   
										fadcargo.dcar_codigo,   
										fadcargo.dcar_monto  
								 FROM fadcargo  
								WHERE ( fadcargo.dcar_g_financiero = :ii_g_financiero ) AND  
										( fadcargo.dcar_empresa = :ii_empresa ) AND  
										( fadcargo.dcar_no_pedido = :ls_pedido ) AND  
										( fadcargo.dcar_tipo = :ls_tipo ) AND  
										( fadcargo.dcar_ann = :ll_ann ) ;							
									if sqlca.sqlcode = -1 then	
										mensaje("Aviso","Error al Crear los Cargos de la Factura "+ls_pedido,sqlca.sqlerrtext)
										rollback;
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
								  SELECT :str.g_financiero,   
											:str.empresa,   
											:ls_tipo,   
											fadvenfa.vfac_no_pedido,   
											fadvenfa.vfac_ann,   
											fadvenfa.vfac_vendedor  
									 FROM fadvenfa 
									WHERE ( fadvenfa.vfac_g_financiero = :ii_g_financiero ) AND  
											( fadvenfa.vfac_empresa = :ii_empresa ) AND  
											( fadvenfa.vfac_no_pedido = :ls_pedido ) AND  
											( fadvenfa.vfac_tipo = :ls_tipo ) AND  											
											( fadvenfa.vfac_ann = :ll_ann )   ;									
									if sqlca.sqlcode = -1 then	
										mensaje("Aviso","Error al Crear los Vendedores de la Factura"+ls_pedido,sqlca.sqlerrtext)
										rollback;
										dw_4.setfilter("")
										dw_4.filter()																	
										return
									end if						
							
			//Actualiza el Estado de Pasado a empresa = 1
			  UPDATE fatdiari
				  SET fact_pasado_a_empresa = 1  
				WHERE ( fatdiari.fact_g_financiero = :ii_g_financiero ) AND  
						( fatdiari.fact_empresa = :ii_empresa ) AND  
						( fatdiari.fact_no_pedido = :ls_pedido ) AND  
						( fatdiari.fact_tipo = :ls_tipo ) AND  
						( fatdiari.fact_ann = :ll_ann )   ;

			if sqlca.sqlcode = -1 then	
				mensaje("Aviso","Error al Actualizar Estado de Pasado a Empresa"+ls_pedido,sqlca.sqlerrtext)
				rollback;
				dw_4.setfilter("")
				dw_4.filter()											
				return
		   end if			
	
	lb_entro = true
	
	commit;
		
next

if lb_entro then
	mensaje("Atención","Pase Ejecutado Satisfactoriamente","")
	dw_4.setfilter("")
	dw_4.filter()
	dw_4.Retrieve(ii_g_financiero, ii_empresa,ii_ann,il_tercero)
	dw_4.setfocus()
end if
end subroutine

on w_fa_man_pasar_facturas_a_empresa.create
int iCurrent
call super::create
this.st_4=create st_4
this.cb_procesar=create cb_procesar
this.st_3=create st_3
this.dw_4=create dw_4
this.dw_3=create dw_3
this.sle_lineas=create sle_lineas
this.cbx_cargos=create cbx_cargos
this.st_1=create st_1
this.em_ann=create em_ann
this.st_2=create st_2
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_4
this.Control[iCurrent+2]=this.cb_procesar
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.dw_4
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.sle_lineas
this.Control[iCurrent+7]=this.cbx_cargos
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.em_ann
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.dw_2
end on

on w_fa_man_pasar_facturas_a_empresa.destroy
call super::destroy
destroy(this.st_4)
destroy(this.cb_procesar)
destroy(this.st_3)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.sle_lineas)
destroy(this.cbx_cargos)
destroy(this.st_1)
destroy(this.em_ann)
destroy(this.st_2)
destroy(this.dw_2)
end on

event ue_post_open;//Override
long  	ll_tercero, ll_encontro
string ls_nombre
this.y = 1
sqlca.autocommit = true

ii_ann = year(date(gf_fecha_serv()))
em_ann.text = string(ii_ann)

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

	This.title = 'Pasar las Facturas de '+ls_nombre
	
dw_1.GetChild('cliente', dwc_cliente)
dwc_cliente.Settransobject(sqlca);
If dwc_cliente.Retrieve(ii_g_financiero, ii_empresa, ii_ann) < 1 Then  dwc_cliente.Insertrow(0)
dw_1.insertrow(0)

ll_encontro = dwc_cliente.find("terc_tercero = "+string(ll_tercero),1,dwc_cliente.rowcount())
if ll_encontro <> 0 then
	dwc_cliente.Scrolltorow(ll_encontro)
	dw_1.setitem(1,"cliente",ll_tercero)
	il_tercero = ll_tercero
else
	dwc_cliente.Scrolltorow(1)
end if

dw_2.GetChild('cliente', dwc_cliente_destino)
dwc_cliente_destino.Settransobject(sqlca);
If dwc_cliente_destino.Retrieve(str.g_financiero, str.empresa) < 1 Then  dwc_cliente_destino.Insertrow(0)
dw_2.insertrow(0)

dw_4.Settransobject(sqlca);
dw_4.insertrow(0)
dw_4.Retrieve(ii_g_financiero, ii_empresa, ii_ann, ll_tercero)

dw_4.SetFocus()

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

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_man_pasar_facturas_a_empresa
integer x = 1202
integer y = 772
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_man_pasar_facturas_a_empresa
boolean visible = false
integer y = 1196
integer width = 832
integer height = 72
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_man_pasar_facturas_a_empresa
event ue_positemchanged ( string as_columna,  long row,  string data )
integer x = 690
integer y = 40
integer width = 1056
integer height = 92
integer taborder = 10
string dataobject = "dw_pr_fa_facturas_cliente"
boolean livescroll = false
borderstyle borderstyle = stylelowered!
end type

event dw_1::ue_positemchanged(string as_columna, long row, string data);Integer	li_dias_pago
String	ls_peri_descripcion,ls_condicion_de_pago,ls_cond_pago
Long		ll_rows

il_tercero = long(data)

dw_4.Retrieve(ii_g_financiero, ii_empresa,ii_ann,il_tercero)


end event

event dw_1::ue_escape;//Override
end event

event dw_1::itemchanged;this.post event ue_positemchanged(dw_1.Getcolumnname(),row,data)

end event

event dw_1::clicked;call super::clicked;//str_pedi.cliente = dwc_cliente.GetItemNumber(dwc_cliente.GetRow(),"terc_tercero")
//dw_4.Retrieve(str.g_financiero, str.empresa,w_fa_fondo.str_para.ano,str_pedi.cliente) 

end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_man_pasar_facturas_a_empresa
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

type st_4 from statictext within w_fa_man_pasar_facturas_a_empresa
integer x = 448
integer y = 44
integer width = 224
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
boolean enabled = false
string text = "Cliente"
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_procesar from commandbutton within w_fa_man_pasar_facturas_a_empresa
integer x = 2245
integer y = 1548
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
wf_procesar()
end event

type st_3 from statictext within w_fa_man_pasar_facturas_a_empresa
integer x = 2235
integer y = 1540
integer width = 288
integer height = 108
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

type dw_4 from datawindow within w_fa_man_pasar_facturas_a_empresa
integer x = 123
integer y = 172
integer width = 2395
integer height = 1348
integer taborder = 20
string dataobject = "dw_pr_fa_facturas_por_pasar_cliente"
boolean hscrollbar = true
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

type dw_3 from datawindow within w_fa_man_pasar_facturas_a_empresa
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

type sle_lineas from singlelineedit within w_fa_man_pasar_facturas_a_empresa
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

type cbx_cargos from checkbox within w_fa_man_pasar_facturas_a_empresa
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

type st_1 from statictext within w_fa_man_pasar_facturas_a_empresa
integer x = 14
integer y = 48
integer width = 146
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
boolean enabled = false
string text = "Año:"
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_ann from editmask within w_fa_man_pasar_facturas_a_empresa
integer x = 174
integer y = 32
integer width = 261
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###0"
boolean spin = true
double increment = 1
string minmax = "2014~~3000"
end type

event modified;ii_ann = integer(em_ann.text)

If dwc_cliente.Retrieve(ii_g_financiero, ii_empresa, ii_ann) < 1 Then  dwc_cliente.Insertrow(0)
end event

type st_2 from statictext within w_fa_man_pasar_facturas_a_empresa
integer x = 498
integer y = 1548
integer width = 224
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
boolean enabled = false
string text = "Cliente"
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_fa_man_pasar_facturas_a_empresa
integer x = 741
integer y = 1536
integer width = 1248
integer height = 92
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_clientes_nombre"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

