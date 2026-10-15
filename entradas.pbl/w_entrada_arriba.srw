//objectcomments Ventana para la Captura de Entradas
forward
global type w_entrada_arriba from w_fa_padre
end type
type dw_2 from datawindow within w_entrada_arriba
end type
type dw_3 from datawindow within w_entrada_arriba
end type
type dw_4 from datawindow within w_entrada_arriba
end type
type dw_5 from datawindow within w_entrada_arriba
end type
type cb_1 from commandbutton within w_entrada_arriba
end type
type cb_2 from commandbutton within w_entrada_arriba
end type
type dw_6 from datawindow within w_entrada_arriba
end type
type pb_1 from picturebutton within w_entrada_arriba
end type
type uo_1 from u_ddcalen within w_entrada_arriba
end type
type pb_2 from picturebutton within w_entrada_arriba
end type
type st_1 from statictext within w_entrada_arriba
end type
type dw_7 from datawindow within w_entrada_arriba
end type
type pb_pase from picturebutton within w_entrada_arriba
end type
type cb_3 from commandbutton within w_entrada_arriba
end type
type dw_8 from datawindow within w_entrada_arriba
end type
type cbx_existencias from checkbox within w_entrada_arriba
end type
type dw_9 from datawindow within w_entrada_arriba
end type
type dw_10 from datawindow within w_entrada_arriba
end type
type cb_pasar_salidas from commandbutton within w_entrada_arriba
end type
type cb_4 from commandbutton within w_entrada_arriba
end type
type dw_11 from datawindow within w_entrada_arriba
end type
type cb_5 from commandbutton within w_entrada_arriba
end type
type cb_6 from commandbutton within w_entrada_arriba
end type
type dw_12 from datawindow within w_entrada_arriba
end type
type cb_7 from commandbutton within w_entrada_arriba
end type
type dw_13 from datawindow within w_entrada_arriba
end type
type dw_14 from datawindow within w_entrada_arriba
end type
type dw_15 from datawindow within w_entrada_arriba
end type
type dw_16 from datawindow within w_entrada_arriba
end type
type cb_8 from commandbutton within w_entrada_arriba
end type
end forward

global type w_entrada_arriba from w_fa_padre
integer x = 0
integer y = 0
integer width = 5614
integer height = 1952
string title = "Captura de Entrada de Mercancia"
string menuname = "m_hs"
boolean controlmenu = false
boolean maxbox = false
long backcolor = 12639424
event ue_syscommand pbm_syscommand
event ue_aceptar_por_linea ( )
dw_2 dw_2
dw_3 dw_3
dw_4 dw_4
dw_5 dw_5
cb_1 cb_1
cb_2 cb_2
dw_6 dw_6
pb_1 pb_1
uo_1 uo_1
pb_2 pb_2
st_1 st_1
dw_7 dw_7
pb_pase pb_pase
cb_3 cb_3
dw_8 dw_8
cbx_existencias cbx_existencias
dw_9 dw_9
dw_10 dw_10
cb_pasar_salidas cb_pasar_salidas
cb_4 cb_4
dw_11 dw_11
cb_5 cb_5
cb_6 cb_6
dw_12 dw_12
cb_7 cb_7
dw_13 dw_13
dw_14 dw_14
dw_15 dw_15
dw_16 dw_16
cb_8 cb_8
end type
global w_entrada_arriba w_entrada_arriba

type prototypes
Function long ShellExecute( long hwnd,  string lpOperation, string lpFile, string lpParameters,  string lpDirectory,  integer nShowCmd ) Library "shell32.dll"   alias for "ShellExecuteW"

FUNCTION long ShellExecuteW ( &
    long hwnd, &
    string lpOperation, &
    string lpFile, &
    string lpParameters, &
    string lpDirectory, &
    long nShowCmd &
) LIBRARY "shell32.dll" ALIAS FOR "ShellExecuteW"

end prototypes

type variables
integer ii_usuario_bodega, ii_ann, datawindow, il_row, ii_cantidad_unidad, ii_cantidad_empaque, ii_empresa, ii_g_financiero, ii_costea_cubicaje, ii_tipo_medida
String  is_ruta_archivos, is_entrada, is_unidad_empaque, is_actualiza, is_bodega_ubica_compra, is_concepto, is_documento, is_cuenta_inventarios, is_cuenta_costo_venta
date	  idt_desde, idt_hasta
long    il_tiempo, il_segundos, il_secuencia, il_empaque, il_ucom
decimal{4} id_peso, id_cubicaje
decimal{8} id_costo
decimal id_gasto_admon, id_cargos, id_descuento
datawindowchild idw_child, idwc_grupo, idwc_region, idwc_gastos
str_in_parametros str_in
boolean ib_rebajar_pedido, ib_transito = false
str_pase_pedido istr_pedidos
datastore ids_kardex

date         id_fecha2 
datetime		id_fechatime
end variables

forward prototypes
public function boolean wf_recupera ()
public function boolean wf_child_productos ()
public function boolean wf_orden_nueva ()
public function boolean wf_carga_prod (ref string ls_codigo, ref string ls_descripcion, ref string ls_uni, ref string ls_modelo)
public subroutine wf_pasar_estructura (str_pase_pedido lstr_pedidos)
public function boolean wf_asigna_pedido (str_pase_pedido astr_pedidos)
public function boolean wf_rebaja_pedido ()
public function boolean wf_rebaja_transito ()
public subroutine wf_recuperar_2 (string as_producto)
public function boolean wf_cambiar_tipo (string as_concepto_anterior)
public function double wf_cubicaje ()
public function boolean wf_orden_nueva_empresa (integer ai_empresa, ref long ai_secuencia)
end prototypes

event ue_syscommand;call super::ue_syscommand;if commandtype = 61536 then
	close(this)
end if
end event

public function boolean wf_recupera ();long ll_fila, ll_recuperados

str.frame.setmicrohelp('Espere mientras se recuperan los registros...')

ll_fila = dw_1.getrow()

ll_recuperados = dw_1.retrieve(str.g_financiero, str.empresa, idt_desde, idt_hasta)
if ll_recuperados > ll_fila then
	dw_1.scrolltorow(ll_fila)
end if

il_segundos = 0

str.frame.setmicrohelp('Bodegas Wireless Backoffice')

return true
end function

public function boolean wf_child_productos ();//override
String	ls_expresion
Integer	li_pos
datawindowchild ldwc_division, ldwc_subg, ldwc_clase, ldwc_arancel, ldwc_clase_prod, ldwc_tipo, &
					 ldwc_espec, ldwc_proveedor, ldwc_condicion, ldwc_color, ldwc_tama, ldwc_marca, ldwc_provee
dw = dw_6

sqlca.autocommit= true

dw_6.settransobject(sqlca)

dw_6.getchild('prod_division', ldwc_division)
ldwc_division.settransobject(sqlca)
ldwc_division.retrieve(str.g_financiero, str.empresa)
ldwc_division.insertrow(1)

dw_6.getchild('prod_grupo', idwc_grupo)
idwc_grupo.settransobject(sqlca)
idwc_grupo.retrieve(str.g_financiero, str.empresa)
idwc_grupo.insertrow(1)

dw_6.getchild('prod_marca', ldwc_marca)
ldwc_marca.settransobject(sqlca)
ldwc_marca.retrieve(str.g_financiero, str.empresa)
ldwc_marca.insertrow(1)

dw_6.getchild('prod_arancel', ldwc_arancel)
ldwc_arancel.settransobject(sqlca)
ldwc_arancel.retrieve(str.g_financiero, str.empresa)
ldwc_arancel.insertrow(1)

dw_6.getchild('prod_compuesto', ldwc_espec)
ldwc_espec.settransobject(sqlca)
ldwc_espec.retrieve(str.g_financiero, str.empresa)
ldwc_espec.insertrow(1)

dw_6.getchild('prod_color', ldwc_color)
ldwc_color.settransobject(sqlca)
ldwc_color.retrieve(str.g_financiero, str.empresa)
ldwc_color.insertrow(1)


dw_6.getchild('prod_cod_clase_tam', ldwc_tama)
ldwc_tama.settransobject(sqlca)
ldwc_tama.retrieve(str.g_financiero, str.empresa)
ldwc_tama.insertrow(1)

dw_6.getchild('prod_tercero', ldwc_provee)
ldwc_provee.settransobject(sqlca)
ldwc_provee.retrieve('P')
ldwc_provee.insertrow(1)


This.SetRedraw(True)

return true
end function

public function boolean wf_orden_nueva ();long ll_max
integer li_ann

//li_ann = year(date(gf_fecha_serv()))
//ii_ann = li_ann
dw_1.setitem(1,'tmov_anual',ii_ann)

select max(tmov_secuencia)
into	:ll_max
from intmovim
where tmov_g_financiero = :str.g_financiero and
		tmov_empresa		= :str.empresa and
		tmov_anual				= :ii_ann and
		tmov_tipo_transaccion = 'EN';
	if sqlca.sqlcode = -1  then
		gf_mensaje('','Error al Buscar Secuencia '+sqlca.sqlerrtext,1,1,'E')		
		return false
	end if
	
	if isnull(ll_max) then ll_max = 0
	
	ll_max ++
	
	dw_1.setitem(1,'tmov_secuencia',ll_max)
	
	il_secuencia = ll_max
return true
end function

public function boolean wf_carga_prod (ref string ls_codigo, ref string ls_descripcion, ref string ls_uni, ref string ls_modelo);if ls_modelo = '' then
   SELECT inmprodu.prod_descripcion,   
         inmprodu.prod_empaque,   
         inmprodu.prod_medida,   
         inamedid_a.medi_cantidad,   
         inamedid_b.medi_cantidad,
		inmprodu.prod_peso,
		inmprodu.prod_cubicaje,
		inmprodu.prod_costo_fob,
		inmprodu.prod_producto_dos,
		inamedid_a.medi_tipo_medida
    INTO :ls_descripcion,   
         :il_empaque,   
         :ls_uni,   
         :ii_cantidad_unidad,   
         :ii_cantidad_empaque,
		:id_peso,
		:id_cubicaje,
		:id_costo,
		:ls_modelo,
		:ii_tipo_medida
    FROM inmprodu,   
         inamedid inamedid_a,   
         inamedid inamedid_b  
   WHERE ( inamedid_a.medi_medida = inmprodu.prod_medida ) and  
         ( inmprodu.prod_empaque_um = inamedid_b.medi_medida ) and  
         ( ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
         ( inmprodu.prod_empresa = :str.empresa ) AND  
         ( inmprodu.prod_producto = :ls_codigo ) )   ;
else
	  SELECT inmprodu.prod_descripcion,   
         inmprodu.prod_empaque,   
         inmprodu.prod_medida,   
         inamedid_a.medi_cantidad,   
         inamedid_b.medi_cantidad,
		inmprodu.prod_peso,
		inmprodu.prod_cubicaje,
		inmprodu.prod_costo_fob,
		inmprodu.prod_producto,
		inamedid_a.medi_tipo_medida
    INTO :ls_descripcion,   
         :il_empaque,   
         :ls_uni,   
         :ii_cantidad_unidad,   
         :ii_cantidad_empaque,
		:id_peso,
		:id_cubicaje,
		:id_costo,
		:ls_codigo,
		:ii_tipo_medida
    FROM inmprodu,   
         inamedid inamedid_a,   
         inamedid inamedid_b  
   WHERE ( inamedid_a.medi_medida = inmprodu.prod_medida ) and  
         ( inmprodu.prod_empaque_um = inamedid_b.medi_medida ) and  
         ( ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
         ( inmprodu.prod_empresa = :str.empresa ) AND  
         ( inmprodu.prod_producto_dos = :ls_modelo ) )   ;

end if

if sqlca.sqlcode = -1 then
	gf_mensaje('','Error al recuperar datos del producto '+sqlca.sqlerrtext,1,1,'E')
	return false
end if
		
return true

end function

public subroutine wf_pasar_estructura (str_pase_pedido lstr_pedidos);istr_pedidos = lstr_pedidos
end subroutine

public function boolean wf_asigna_pedido (str_pase_pedido astr_pedidos);string ls_modelo, ls_cuenta, ls_condicion, ls_tipo, ls_movimiento, ls_consignado, ls_a_nombre, ls_direccion, ls_despachado, &
		ls_comentario, ls_pasaporte, ls_linea_aerea, ls_producto, ls_descripcion, ls_unidad, ls_bodega, ls_ubicacion, ls_unidad_venta, ls_item, ls_marca, ls_documento, ls_contrato
datetime ldt_fecha_despacho, ldt_fecha
decimal{2} ld_bultos, ld_bultos_original, ld_saldo, ld_limite, ld_descuento, ld_gastos, ld_monto, ld_monto_final , ld_costo_fob, ld_costo_cif, ld_cantidad, ld_precio_original, ld_costo_total, ld_precio, ld_precio_recargo, ld_rec_especial		
integer i, li_dias, li_vendedor, li_tipo, li_linea, li_index, li_fraccion, li_bultos, li_tipo_medida, li_bulto_inicio, li_bulto_fin
long ll_cliente, ll_fila, ll_bultos, ll_tercero
  
datawindow = 1

this.triggerevent('ue_adicionar')
  
  	// Crea un nuevo registro
		dw_1.reset()
//		dw_2.object.cargos.expression = "'"+string(0.00,'#,##0.00')+"'"	//Para blanquear los cargos
		dw_2.reset()
		dw_1.insertrow(1)
		//Pone invisible el insertar	
		dw_1.setitem(1,'tmov_g_financiero',str.g_financiero)
		dw_1.setitem(1,'tmov_empresa',str.empresa)
		dw_1.setitem(1,'tmov_fecha',date(gf_fecha_serv()))
		dw_1.setitem(1,'intmovim_tmov_fecha_registro',date(gf_fecha_serv()))		
		dw_1.setitem(1,'tmov_id',str.usuario)	
		dw_1.setitem(1,'tmov_autoriza',str.usuario)	
		dw_1.setitem(1,'tmov_estado_entrada','A')
		if ib_transito then
			SELECT transito.enca_proveedor  , transito.enca_documento
			 INTO :ll_tercero , :ls_documento 
			 FROM transito  
			WHERE ( transito.enca_g_financiero = :str.g_financiero ) AND  
					( transito.enca_empresa = :str.empresa ) AND  
					( transito.enca_secuencia = :istr_pedidos.ordenes[1] ) AND  
					( transito.enca_ann = :istr_pedidos.ann_orden[1] )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Buscar Proveedor '+sqlca.sqlerrtext,1,1,'E')
					return false
				end if

		else
			SELECT orden.enca_proveedor  , orden.enca_documento
			 INTO :ll_tercero , :ls_documento 
			 FROM orden  
			WHERE ( orden.enca_g_financiero = :str.g_financiero ) AND  
					( orden.enca_empresa = :str.empresa ) AND  
					( orden.enca_secuencia = :istr_pedidos.ordenes[1] ) AND  
					( orden.enca_ann = :istr_pedidos.ann_orden[1] )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Buscar Proveedor en OC '+sqlca.sqlerrtext,1,1,'E')
					return false
				end if
		end if
		dw_1.setitem(1,'tmov_terceros',ll_tercero)
		dw_1.setitem(1,'intmovim_tmov_documento_entrada', istr_pedidos.ordenes[1])
		dw_1.setitem(1,'tmov_documento', ls_documento)
		dw_1.setcolumn('tmov_documento')
		dw_1.setfocus()
		wf_orden_nueva()
		
	//	ll_fila = idwc_cliente.find('terc_tercero = '+string(ll_cliente),1,idwc_cliente.rowcount())
		if ll_fila > 0 then
//			idwc_cliente.scrolltorow(ll_fila)
		end if
	
		li_bulto_inicio = 1

for i = 1 to upperbound(istr_pedidos.referencia)
		
			ls_producto = istr_pedidos.referencia[i]
			
			  SELECT inmprodu.prod_descripcion,   
				inmprodu.prod_empaque,     
				inamedid_a.medi_cantidad,   
				inamedid_b.medi_cantidad,
				inmprodu.prod_peso,
				inmprodu.prod_cubicaje,
				inmprodu.prod_medida,
				inmprodu.prod_costo_promedio,
				inmprodu.prod_producto_dos
		 INTO :ls_descripcion,   
				:il_empaque,   
				:ii_cantidad_unidad,   
				:ii_cantidad_empaque,
				:id_peso,
				:id_cubicaje,
				:ls_unidad,
				:ld_costo_cif,
				:ls_modelo
		 FROM inmprodu,   
				inamedid inamedid_a,   
				inamedid inamedid_b  
		WHERE ( inamedid_a.medi_medida = inmprodu.prod_medida ) and  
				( inmprodu.prod_empaque_um = inamedid_b.medi_medida ) and  
				( ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
				( inmprodu.prod_empresa = :str.empresa ) AND  
				( inmprodu.prod_producto = :ls_producto ) )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al recuperar datos del producto '+sqlca.sqlerrtext,1,1,'E')
				return false
			end if
			
			dw_2.scrolltorow(dw_2.insertrow(0))
			ld_cantidad = istr_pedidos.cantidad[i]
			li_fraccion  = 0 // istr_pedidos.fraccion[i]
			
			if (il_empaque * ii_cantidad_empaque) <> 0 then
				ll_bultos = (ld_cantidad * ii_cantidad_unidad ) / (il_empaque * ii_cantidad_empaque)
				ld_bultos = (ld_cantidad * ii_cantidad_unidad ) / (il_empaque * ii_cantidad_empaque)
			end if
			if ll_bultos = 0 then ll_bultos = 1		
			
			ld_monto_final = round( (ld_cantidad * istr_pedidos.costo[i]) + ((istr_pedidos.costo[i] / ii_cantidad_unidad) * li_fraccion ) ,2)
			
			dw_2.setitem(dw_2.getrow(),'dmov_g_financiero',str.g_financiero)
			dw_2.setitem(dw_2.getrow(),'dmov_empresa',str.empresa)
			dw_2.setitem(dw_2.getrow(),'dmov_id',str.usuario)
			dw_2.setitem(dw_2.getrow(),'dmov_producto',ls_producto)
			dw_2.setitem(dw_2.getrow(),'dmov_cantidad', ld_cantidad)
			dw_2.setitem(dw_2.getrow(),'dmov_cant1', li_fraccion)
			dw_2.setitem(dw_2.getrow(),'prod_descripcion',ls_descripcion)
			dw_2.setitem(dw_2.getrow(),'dmov_modelo', ls_modelo)
			dw_2.setitem(dw_2.getrow(),'dmov_unidad_medida',ls_unidad)			
			dw_2.setitem(dw_2.getrow(),'medi_cantidad',ii_cantidad_unidad)			
			dw_2.setitem(dw_2.getrow(),'dmov_costo_cif', ld_costo_cif)			
			dw_2.setitem(dw_2.getrow(),'dmov_costo_fob', istr_pedidos.costo[i])
			if ib_transito then
				dw_2.setitem(dw_2.getrow(),'dmov_transito', istr_pedidos.ordenes[i])
				dw_2.setitem(dw_2.getrow(),'dmov_ann_transito', istr_pedidos.ann_orden[i])
				dw_2.setitem(dw_2.getrow(),'dmov_linea_transito', istr_pedidos.linea[i])
			else
				dw_2.setitem(dw_2.getrow(),'dmov_orden_compra', istr_pedidos.ordenes[i])
				dw_2.setitem(dw_2.getrow(),'dmov_ann_orden', istr_pedidos.ann_orden[i])
				dw_2.setitem(dw_2.getrow(),'dmov_linea_orden', istr_pedidos.linea[i])
			end if
			dw_2.setitem(dw_2.getrow(),'dmov_linea', i)
			ls_bodega = '1'
			dw_2.setitem(dw_2.getrow(),'dmov_bodega', ls_bodega)
			dw_2.setitem(dw_2.getrow(),'dmov_ubicacion', ls_ubicacion)			
//			dw_2.setitem(dw_2.getrow(),'facd_costo_total', round( (ld_cantidad * id_costo_cif) + ((id_costo_cif / ii_cantidad_unidad) * li_fraccion ) ,2))
			dw_2.setitem(dw_2.getrow(),'dmov_bulto', ll_bultos)
			dw_2.setitem(dw_2.getrow(),'dmov_monto_final', ld_monto_final)
			dw_2.setitem(dw_2.getrow(),'dmov_peso',ll_bultos * id_peso)
			dw_2.setitem(dw_2.getrow(),'dmov_cubicaje',ll_bultos * id_cubicaje)
			dw_2.setitem(dw_2.getrow(),'prod_empaque',il_empaque)
			
			  SELECT isnull(orden_detalle.deta_precio_venta  ,0), orden_detalle.deta_contrato
				 INTO :ld_precio  , :ls_contrato
				 FROM orden_detalle  
				WHERE ( orden_detalle.deta_g_financiero = :str.g_financiero ) AND  
						( orden_detalle.deta_empresa = :str.empresa ) AND  
						( orden_detalle.deta_secuencia = :istr_pedidos.ordenes[i] ) AND  
						( orden_detalle.deta_ann = :istr_pedidos.ann_orden[i] ) AND  
						( orden_detalle.deta_linea = :istr_pedidos.linea[i] )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al recuperar precio de venta '+sqlca.sqlerrtext,1,1,'E')
					return false
				end if
			
			dw_2.setitem(dw_2.getrow(),'dmov_precio',ld_precio)
			dw_2.setitem(dw_2.getrow(),'dmov_contrato',ls_contrato)
			ls_item = ls_producto			
next

ib_rebajar_pedido = true

return true
end function

public function boolean wf_rebaja_pedido ();integer i, li_fraccion, li_cantidad_medida, li_existe
decimal{2} ld_cantidad, ld_pasada
string ls_error
	for i = 1 to upperbound(istr_pedidos.referencia)
		
		 DECLARE cur_detalle CURSOR FOR  
		  SELECT inamedid.medi_cantidad  
			 FROM orden_detalle,   
					inamedid  
			WHERE ( orden_detalle.deta_unidad = inamedid.medi_medida ) and  
					( ( orden_detalle.deta_g_financiero = :str.g_financiero ) AND  
					( orden_detalle.deta_empresa = :str.empresa ) AND  
					( orden_detalle.deta_secuencia = :istr_pedidos.ordenes[i] ) AND  
					( orden_detalle.deta_ann = :istr_pedidos.ann_orden[i] ) AND  
					( orden_detalle.deta_linea = :istr_pedidos.linea[i] ) AND  
					( orden_detalle.deta_referencia = :istr_pedidos.referencia[i] ) )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Declarar el Cursor '+sqlca.sqlerrtext,1,1,'E')
						return false
					end if
				
		open cur_detalle ;
		
		fetch cur_detalle into :li_cantidad_medida;

			ld_cantidad = istr_pedidos.cantidad[i]
			if isnull(ld_cantidad) then ld_cantidad = 0
			li_fraccion  = 0 //istr_pedidos.fraccion[i]
			if isnull(li_fraccion) then li_fraccion = 0
			ld_pasada = ld_cantidad * li_cantidad_medida + li_fraccion
			
			  UPDATE orden_detalle  
				  SET deta_pasada = deta_pasada + :ld_pasada  
				WHERE ( ( orden_detalle.deta_g_financiero = :str.g_financiero ) AND  
					( orden_detalle.deta_empresa = :str.empresa ) AND  
					( orden_detalle.deta_secuencia = :istr_pedidos.ordenes[i] ) AND  
					( orden_detalle.deta_ann = :istr_pedidos.ann_orden[i] ) AND  
					( orden_detalle.deta_linea = :istr_pedidos.linea[i] ) AND  
					( orden_detalle.deta_referencia = :istr_pedidos.referencia[i] ) )   ;					
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Actualizar detalle de la orden pasada '+sqlca.sqlerrtext,1,1,'E')
						return false
					end if						
			
		close cur_detalle;

		//	gf_actualiza_reserva_producto_transito(istr_pedidos.referencia[i])
		
		SELECT Count(*) 
		 INTO :li_existe
		 FROM orden_detalle,
					orden
			WHERE ( orden.enca_g_financiero = orden_detalle.deta_g_financiero ) and
					( orden.enca_empresa = orden_detalle.deta_empresa ) and
					( orden.enca_secuencia = orden_detalle.deta_secuencia ) and
					( orden.enca_ann = orden_detalle.deta_ann ) and
				( orden.enca_g_financiero = :str.g_financiero) AND
					( orden.enca_empresa = :str.empresa ) and
					( orden.enca_secuencia = :istr_pedidos.ordenes[i] ) and
					( orden.enca_ann = :istr_pedidos.ann_orden[i] ) and
						orden_detalle.deta_pasada <  ( orden_detalle.deta_cantidad * (SELECT inamedid.medi_cantidad
											FROM    inamedid
											WHERE inamedid.medi_medida = orden_detalle.deta_unidad)) ;
				If sqlca.sqlcode = -1 then
					ls_error =sqlca.sqlerrtext
					mensaje("Error ","Error al verificar lo pasado "+ls_error,"")
					return false
				End If
		
			If li_existe = 0 then
			  UPDATE orden  
				  SET enca_estado = "P"  
				WHERE ( orden.enca_g_financiero = :str.g_financiero ) AND  
						( orden.enca_empresa 	= :str.empresa ) AND  
						( orden.enca_secuencia 	= :istr_pedidos.ordenes[i] ) AND  
						( orden.enca_ann = :istr_pedidos.ann_orden[i] )   ;		
				If sqlca.sqlcode = -1 then
					ls_error =sqlca.sqlerrtext
					mensaje("Error ","Error al marcar estado del Pedido Pasado "+ls_error,"")
					return false
				End If
				commit using sqlca;	
			End If

Next 
ib_rebajar_pedido = false		
return true
end function

public function boolean wf_rebaja_transito ();integer i, li_fraccion, li_cantidad_medida, li_existe
decimal{2} ld_cantidad, ld_pasada
string ls_error
	for i = 1 to upperbound(istr_pedidos.referencia)
		
		 DECLARE cur_detalle CURSOR FOR  
		  SELECT inamedid.medi_cantidad  
			 FROM transito_detalle,   
					inamedid  
			WHERE ( transito_detalle.deta_unidad = inamedid.medi_medida ) and  
					( ( transito_detalle.deta_g_financiero = :str.g_financiero ) AND  
					( transito_detalle.deta_empresa = :str.empresa ) AND  
					( transito_detalle.deta_secuencia = :istr_pedidos.ordenes[i] ) AND  
					( transito_detalle.deta_ann = :istr_pedidos.ann_orden[i] ) AND  
					( transito_detalle.deta_linea = :istr_pedidos.linea[i] ) AND  
					( transito_detalle.deta_referencia = :istr_pedidos.referencia[i] ) )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Declarar el Cursor '+sqlca.sqlerrtext,1,1,'E')
						return false
					end if
				
		open cur_detalle ;
		
		fetch cur_detalle into :li_cantidad_medida;

			ld_cantidad = istr_pedidos.cantidad[i]
			if isnull(ld_cantidad) then ld_cantidad = 0
			li_fraccion  = 0 //istr_pedidos.fraccion[i]
			if isnull(li_fraccion) then li_fraccion = 0
			ld_pasada = ld_cantidad * li_cantidad_medida + li_fraccion
			
			  UPDATE transito_detalle  
				  SET deta_pasada = deta_pasada + :ld_pasada  
				WHERE ( ( transito_detalle.deta_g_financiero = :str.g_financiero ) AND  
					( transito_detalle.deta_empresa = :str.empresa ) AND  
					( transito_detalle.deta_secuencia = :istr_pedidos.ordenes[i] ) AND  
					( transito_detalle.deta_ann = :istr_pedidos.ann_orden[i] ) AND  
					( transito_detalle.deta_linea = :istr_pedidos.linea[i] ) AND  
					( transito_detalle.deta_referencia = :istr_pedidos.referencia[i] ) )   ;					
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
						return false
					end if						
			
		close cur_detalle;

		//	gf_actualiza_reserva_producto_transito(istr_pedidos.referencia[i])
		
		SELECT Count(*) 
		 INTO :li_existe
		 FROM transito_detalle,
					transito
			WHERE ( transito.enca_g_financiero = transito_detalle.deta_g_financiero ) and
					( transito.enca_empresa = transito_detalle.deta_empresa ) and
					( transito.enca_secuencia = transito_detalle.deta_secuencia ) and
					( transito.enca_ann = transito_detalle.deta_ann ) and
				( transito.enca_g_financiero = :str.g_financiero) AND
					( transito.enca_empresa = :str.empresa ) and
					( transito.enca_secuencia = :istr_pedidos.ordenes[i] ) and
					( transito.enca_ann = :istr_pedidos.ann_orden[i] ) and
						transito_detalle.deta_pasada <  ( transito_detalle.deta_cantidad * (SELECT inamedid.medi_cantidad
											FROM    inamedid
											WHERE inamedid.medi_medida = transito_detalle.deta_unidad)) ;
				If sqlca.sqlcode = -1 then
					ls_error =sqlca.sqlerrtext
					mensaje("Error ","Error al verificar lo pasado "+ls_error,"")
					return false
				End If
		
			If li_existe = 0 then
			  UPDATE transito  
				  SET enca_estado = "P"  
				WHERE ( transito.enca_g_financiero = :str.g_financiero ) AND  
						( transito.enca_empresa 	= :str.empresa ) AND  
						( transito.enca_secuencia 	= :istr_pedidos.ordenes[i] ) AND  
						( transito.enca_ann = :istr_pedidos.ann_orden[i] )   ;		
				If sqlca.sqlcode = -1 then
					ls_error =sqlca.sqlerrtext
					mensaje("Error ","Error al marcar estado del Pedido Pasado "+ls_error,"")
					return false
				End If
				commit using sqlca;	
			End If

Next 
ib_rebajar_pedido = false		
return true
end function

public subroutine wf_recuperar_2 (string as_producto);/* Funcion intermedia utilizada para llamar a la que calcula el costo promedio */

datetime dt_anterior,dt_posterior
time tiempo1 = 00:00:00, tiempo2 = 23:59:59

dt_anterior=datetime(date("01/01/1980"),tiempo1)
dt_posterior=datetime(id_fecha2,tiempo2)

/* Recupera los datos del Kardex */
//ids_kardex.retrieve(str.g_financiero,str.empresa,as_producto,dt_anterior,dt_posterior)
ids_kardex.retrieve(str.g_financiero,str.empresa,as_producto,dt_anterior,id_fechatime)

/* llama a la funcion para calcular el costo promedio */

/*Sólo calcula costo prom para último y penúltimo registro*/
//gf_in_calcula_costo_promedio_ds(ids_kardex)	
//if as_producto = 'RAD-10134' then
//	string ls_producto
//	ls_producto = 'RAD-10134'
//end if

/*Calcula el costo promedio de todo el mvimiento*/
gf_in_calcula_costo_promedio_ds_for(ids_kardex)	


end subroutine

public function boolean wf_cambiar_tipo (string as_concepto_anterior);sqlca.autocommit = false
string ls_error

  INSERT INTO intmovim  
         ( tmov_g_financiero,   
           tmov_empresa,   
           tmov_aplicacion,   
           tmov_tipo_transaccion,   
           tmov_secuencia,   
           tmov_concepto,   
           tmov_anual,   
           tmov_descripcion,   
           tmov_fecha,   
           tmov_autoriza,   
           tmov_documento,   
           tmov_fecha_registro,   
           tmov_terceros,   
           tmov_comentario,   
           tmov_tipo_costo,   
           tmov_id,   
           tmov_tipo,   
           tmov_estado,   
           tmov_anulado,   
           tmov_total_cargos,   
           tmov_fecha_actualizacion,   
           tmov_documento_entrada,   
           tmov_estado_costo,   
           tmov_forma_costeo,   
           tmov_tipo_trafico,   
           tmov_documento_comercial,   
           tmov_fecha_cierre_mensual,   
           tmov_cuenta,   
           tmov_nombre_tercero,   
           tmov_pase,   
           tmov_moneda,   
           tmov_cambio,   
           tmov_constante,   
           tmov_descuento,   
           tmov_tipo_gasto,   
           tmov_por_admin,   
           tmov_no_pedido,   
           tmov_precio_base,   
           tmov_pasada_a_empresa,   
           tmov_rebaja_reserva,   
           tmov_marca,   
           tmov_descuento_subdeta,   
           tmov_itbm,   
           tmov_itbm_subdeta,   
           tmov_secuencia_actual,   
           tmov_centro_costo,   
           tmov_codigo_uso,   
           tmov_descuento_ncr,   
           tmov_tipo_movimiento,   
           tmov_activada_por,   
           tmov_fecha_activacion )  
     SELECT intmovim.tmov_g_financiero,   
            intmovim.tmov_empresa,   
            intmovim.tmov_aplicacion,   
            intmovim.tmov_tipo_transaccion,   
            intmovim.tmov_secuencia,   
            :is_concepto,   
            intmovim.tmov_anual,   
            intmovim.tmov_descripcion,   
            intmovim.tmov_fecha,   
            intmovim.tmov_autoriza,   
            intmovim.tmov_documento,   
            intmovim.tmov_fecha_registro,   
            intmovim.tmov_terceros,   
            intmovim.tmov_comentario,   
            intmovim.tmov_tipo_costo,   
            intmovim.tmov_id,   
            intmovim.tmov_tipo,   
            intmovim.tmov_estado,   
            intmovim.tmov_anulado,   
            intmovim.tmov_total_cargos,   
            intmovim.tmov_fecha_actualizacion,   
            intmovim.tmov_documento_entrada,   
            intmovim.tmov_estado_costo,   
            intmovim.tmov_forma_costeo,   
            intmovim.tmov_tipo_trafico,   
            intmovim.tmov_documento_comercial,   
            intmovim.tmov_fecha_cierre_mensual,   
            intmovim.tmov_cuenta,   
            intmovim.tmov_nombre_tercero,   
            intmovim.tmov_pase,   
            intmovim.tmov_moneda,   
            intmovim.tmov_cambio,   
            intmovim.tmov_constante,   
            intmovim.tmov_descuento,   
            intmovim.tmov_tipo_gasto,   
            intmovim.tmov_por_admin,   
            intmovim.tmov_no_pedido,   
            intmovim.tmov_precio_base,   
            intmovim.tmov_pasada_a_empresa,   
            intmovim.tmov_rebaja_reserva,   
            intmovim.tmov_marca,   
            intmovim.tmov_descuento_subdeta,   
            intmovim.tmov_itbm,   
            intmovim.tmov_itbm_subdeta,   
            intmovim.tmov_secuencia_actual,   
            intmovim.tmov_centro_costo,   
            intmovim.tmov_codigo_uso,   
            intmovim.tmov_descuento_ncr,   
            intmovim.tmov_tipo_movimiento,   
            intmovim.tmov_activada_por,   
            intmovim.tmov_fecha_activacion  
       FROM intmovim 
      WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
            ( intmovim.tmov_empresa = :str.empresa ) AND  
            ( intmovim.tmov_aplicacion = 'IN' ) AND  
            ( intmovim.tmov_tipo_transaccion = 'EN' ) AND  
            ( intmovim.tmov_secuencia = :il_secuencia ) AND  
            ( intmovim.tmov_anual = :ii_ann ) AND
		   ( intmovim.tmov_concepto = :as_concepto_anterior);
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			gf_mensaje('','Error al Cambiar Tipo Encabezado '+ls_error,1,1,'E')
			sqlca.autocommit = true
			return false
		end if

    update indgasto
	 Set  indgasto.gast_concepto = :is_concepto
       FROM indgasto  
      WHERE ( indgasto.gast_g_financiero = :str.g_financiero ) AND  
            ( indgasto.gast_empresa = :str.empresa ) AND  
            ( indgasto.gast_aplicacion = 'IN' ) AND  
            ( indgasto.gast_transaccion = 'EN' ) AND  
            ( indgasto.gast_concepto = :as_concepto_anterior ) AND  
            ( indgasto.gast_secuencia = :il_secuencia ) AND  
            ( indgasto.gast_ann = :ii_ann )   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			gf_mensaje('','Error al Cambiar Cargos '+ls_error,1,1,'E')
			sqlca.autocommit = true
			return false
		end if

  UPDATE indmovim  
     SET dmov_concepto = :is_concepto  
   WHERE ( indmovim.dmov_g_financiero = :str.g_financiero ) AND  
         ( indmovim.dmov_empresa = :str.empresa ) AND  
         ( indmovim.dmov_aplicacion = 'IN' ) AND  
         ( indmovim.dmov_tipo_transaccion = 'EN' ) AND  
         ( indmovim.dmov_concepto = :as_concepto_anterior ) AND  
         ( indmovim.dmov_secuencia = :il_secuencia ) AND  
         ( indmovim.dmov_anual = :ii_ann )   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			gf_mensaje('','Error al Cambiar Detalle '+ls_error,1,1,'E')
			sqlca.autocommit = true
			return false
		end if

	DELETE FROM intmovim 
      WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
            ( intmovim.tmov_empresa = :str.empresa ) AND  
            ( intmovim.tmov_aplicacion = 'IN' ) AND  
            ( intmovim.tmov_tipo_transaccion = 'EN' ) AND  
            ( intmovim.tmov_secuencia = :il_secuencia ) AND  
            ( intmovim.tmov_anual = :ii_ann ) AND
		   ( intmovim.tmov_concepto = :as_concepto_anterior);
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			gf_mensaje('','Error al Eliminar Encabezado '+ls_error,1,1,'E')
			sqlca.autocommit = true
			return false
		end if


Commit ;
sqlca.autocommit = true

dw_1.retrieve(str.g_financiero, str.empresa, il_secuencia, ii_ann )
is_concepto  = dw_1.getitemstring(1,'tmov_concepto')
is_documento = dw_1.getitemstring(1,'tmov_documento')
dw_2.reset()
dw_2.retrieve(str.g_financiero, str.empresa, il_secuencia, ii_ann )
dw_2.scrolltorow(dw_2.rowcount())
dw_2.setfocus()

return true
end function

public function double wf_cubicaje ();// Función que  Calcula el cubicaje de un Producto tomando en cuenta la cantidad y
// Llamada desde ue_fraccion

Double ld_cubifin,ld_frac,ld_resultado,ld_gecubi,&
       ld_cubi, ld_total_minimo 
long	 ll_gecan, ll_gefrac, ll_total,ll_mconvera, ll_mconverb,ll_mconverc
Integer li_linea
datawindow ldw
String ls_medac,ls_unive,ls_bodega, ls_item

//****************************************************************************
                         // Inicio del Programa
//****************************************************************************
ldw = dw_2
li_linea = dw_2.Getrow()

// For li_linea = 1 To ldw.Rowcount() 
//   Si la Linea es un producto

		ls_item =   ldw.getitemstring(li_linea,"dmov_producto")
		//Funcion que extrae el codigo del producto del compute Concatenado de prod...+bodega+ubicacion	
		//Si el compute tiene "_" , el item se modifica en la funcion
		//wf_extrae_codigo(is_item)
		ls_bodega = ldw.getitemString(li_linea,"dmov_bodega")
		ll_gecan =  ldw.getitemNumber(li_linea,"dmov_cantidad")	
		ll_gefrac = ldw.getitemNumber(li_linea,"dmov_cant1")
		ld_gecubi = id_cubicaje
		
		If ld_gecubi = 0 Then
			//messagebox("ATENCIÓN SR. USUARIO","Verifique el Cubicaje del Producto",Exclamation!)
			//ld_gecubi = 1
		   ldw.Setitem(li_linea,"dmov_cubicaje", 0)
			return 0
		End If	
			
			  ld_cubi =   ldw.getitemNumber(li_linea,"dmov_cubicaje")
			  
	       // Unidad del producto
           ls_medac = ldw.getitemstring(li_linea,"dmov_unidad_medida")
			  
		    // Unidad con la cual se esta vendiendo el producto a un cliente		
		      ls_unive = ldw.GetItemString(li_linea,"dmov_unidad_medida")		
			
  		    //Tipo de medida de la unidad del producto	(UNIDADES, UNIDAD DE PESO, CONVERSIONES, ETC)	 
 			 	il_ucom = gf_medi_prod(ls_medac)
				  		  
			//* Carga Los Datos de Converción de la Unidad del Producto a la Nueva unidad o 
			// Cantidad de unidades minimas de la unidade de venta
			 ll_mconverb = gf_unidad_prod(ls_medac, il_ucom)

			 if ll_mconverb	= 0 then ll_mconverb = 1
			 
         //* cantidad de unidades minimas que tiene la unidad del producto
	      ll_mconvera = gf_unidad_venta(ls_unive, il_ucom)			  			 

///		Calcula la cantidad minima del cubicaje	 
//			//Valor del empaque																				
			ll_mconverc = ii_cantidad_empaque //gf_unidad_venta(w_fa_fondo.strp.emp_um, il_ucom)
			
			if ll_mconverc = 0 or isnull(ll_mconverc) then ll_mconverc = 1

			//0 al peso, si no hay empaque definido para el producto
			if il_empaque = 0.00 or isnull(il_empaque) then 
				ld_resultado = 0
			else
			  //Cubicaje minimo
			  ld_total_minimo = ld_gecubi / il_empaque / ll_mconverc
	
			  if ld_total_minimo = 0 or isnull(ld_total_minimo) then ld_total_minimo = 1			
				
			  //total de cantidad en unidad minima																		
			  ll_total = ll_gecan * ll_mconvera + ll_gefrac									
					
			  ld_cubifin = (ll_total   *  ld_total_minimo ) 
			  
			  ld_resultado = ld_cubifin // (/ ld_mconvera)
		  
		   end if
	  
	//	ldw.Setitem(li_linea,"dped_cubicaje", truncate(round(ld_resultado,4),4))	  	 
	
// Next		  
	return(ld_resultado)
end function

public function boolean wf_orden_nueva_empresa (integer ai_empresa, ref long ai_secuencia);long ll_max
integer li_ann

//li_ann = year(date(gf_fecha_serv()))
//ii_ann = li_ann
dw_1.setitem(1,'tmov_anual',ii_ann)

select max(tmov_secuencia)
into	:ll_max
from intmovim
where tmov_g_financiero = :str.g_financiero and
		tmov_empresa		= :ai_empresa and
		tmov_anual				= :ii_ann and
		tmov_tipo_transaccion = 'EN';
	if sqlca.sqlcode = -1  then
		gf_mensaje('','Error al Buscar Secuencia '+sqlca.sqlerrtext,1,1,'E')		
		return false
	end if
	
	if isnull(ll_max) then ll_max = 0
	
	ll_max ++
	
	ai_secuencia = ll_max
return true
end function

on w_entrada_arriba.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.dw_5=create dw_5
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_6=create dw_6
this.pb_1=create pb_1
this.uo_1=create uo_1
this.pb_2=create pb_2
this.st_1=create st_1
this.dw_7=create dw_7
this.pb_pase=create pb_pase
this.cb_3=create cb_3
this.dw_8=create dw_8
this.cbx_existencias=create cbx_existencias
this.dw_9=create dw_9
this.dw_10=create dw_10
this.cb_pasar_salidas=create cb_pasar_salidas
this.cb_4=create cb_4
this.dw_11=create dw_11
this.cb_5=create cb_5
this.cb_6=create cb_6
this.dw_12=create dw_12
this.cb_7=create cb_7
this.dw_13=create dw_13
this.dw_14=create dw_14
this.dw_15=create dw_15
this.dw_16=create dw_16
this.cb_8=create cb_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.dw_4
this.Control[iCurrent+4]=this.dw_5
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.dw_6
this.Control[iCurrent+8]=this.pb_1
this.Control[iCurrent+9]=this.uo_1
this.Control[iCurrent+10]=this.pb_2
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.dw_7
this.Control[iCurrent+13]=this.pb_pase
this.Control[iCurrent+14]=this.cb_3
this.Control[iCurrent+15]=this.dw_8
this.Control[iCurrent+16]=this.cbx_existencias
this.Control[iCurrent+17]=this.dw_9
this.Control[iCurrent+18]=this.dw_10
this.Control[iCurrent+19]=this.cb_pasar_salidas
this.Control[iCurrent+20]=this.cb_4
this.Control[iCurrent+21]=this.dw_11
this.Control[iCurrent+22]=this.cb_5
this.Control[iCurrent+23]=this.cb_6
this.Control[iCurrent+24]=this.dw_12
this.Control[iCurrent+25]=this.cb_7
this.Control[iCurrent+26]=this.dw_13
this.Control[iCurrent+27]=this.dw_14
this.Control[iCurrent+28]=this.dw_15
this.Control[iCurrent+29]=this.dw_16
this.Control[iCurrent+30]=this.cb_8
end on

on w_entrada_arriba.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_6)
destroy(this.pb_1)
destroy(this.uo_1)
destroy(this.pb_2)
destroy(this.st_1)
destroy(this.dw_7)
destroy(this.pb_pase)
destroy(this.cb_3)
destroy(this.dw_8)
destroy(this.cbx_existencias)
destroy(this.dw_9)
destroy(this.dw_10)
destroy(this.cb_pasar_salidas)
destroy(this.cb_4)
destroy(this.dw_11)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.dw_12)
destroy(this.cb_7)
destroy(this.dw_13)
destroy(this.dw_14)
destroy(this.dw_15)
destroy(this.dw_16)
destroy(this.cb_8)
end on

event ue_post_open;//override
integer i, li_bodegas_definidas, li_existe
string ls_cadena
datawindowchild  ldwc_plan
dw.settransobject(sqlca)
THIS.postevent("ue_hay_data")


dw_1.settransobject(sqlca);			
dw_5.settransobject(sqlca);	
dw_14.settransobject(sqlca);	
dw_15.settransobject(sqlca);	
//dw_16.settransobject(sqlca);	
//dw_16.retrieve(str.empresa)
if pos(upper(str.empr_acceso_especial),'HPSA') > 0 then
	cb_5.visible = true
else
	cb_5.visible = false
end if

select count(1) 
into :li_existe
from usuarios
where usua_id = :str.usuario and usua_especial = 1;
if sqlca.sqlcode = -1 then
	gf_mensaje('','Error al buscar usuario admin '+sqlca.sqlerrtext,1,1,'E')
	return
end if

if li_existe > 0 then
	cb_6.visible = true
end if

select isnull(usua_usuario_bodega,0)
into :ii_usuario_bodega
from usuarios
where usua_id = :str.usuario;
if sqlca.sqlcode = -1 then
	gf_mensaje('','Error al buscar usuario bodega '+sqlca.sqlerrtext,1,1,'E')
	return
end if

dw_7.settransobject(sqlca);	
dw_8.settransobject(sqlca);
dw_9.settransobject(sqlca);
dw_10.settransobject(sqlca);
dw_11.settransobject(sqlca);
ii_ann = year(date(gf_fecha_serv()))
datawindow = 1

dw_10.getchild('ddia_mg_cuenta', ldwc_plan)
ldwc_plan.settransobject(sqlca)
ldwc_plan.retrieve(str.g_financiero, str.empresa)
ldwc_plan.insertrow(1)

dw_5.getchild('gast_codigo_gasto', idwc_gastos)
idwc_gastos.settransobject(sqlca)
If idwc_gastos.retrieve(str.g_financiero, str.empresa) = 0 Then idwc_gastos.Insertrow(0)

DataWindowChild dwc 
str_in.transaccion = 'EN'
is_concepto = '005'
dw_1.GetChild('tmov_concepto', dwc)
dwc.settransobject(sqlca)
if dwc.retrieve(str.g_financiero,str.empresa,'IN',str_in.transaccion) = 0 then
	dwc.insertrow(0)
end if

dw_1.GetChild('tmov_terceros', dwc)
dwc.settransobject(sqlca)
dwc.retrieve(str.g_financiero, str.empresa)
dwc.insertrow(1)

  SELECT isnull(inaparam.para_gastos_admon,0)  ,
  			isnull( inaparam.para_grupo_f_entrada,0),   
		     isnull( inaparam.para_empresa_entrada ,0),
			 isnull( inaparam.para_costea_cubicaje,0) 
    INTO :id_gasto_admon,
	 	:ii_g_financiero,   
         :ii_empresa ,
		:ii_costea_cubicaje
    FROM inaparam  
   WHERE ( inaparam.para_g_financiero = :str.g_financiero ) AND  
         ( inaparam.para_empresa = :str.empresa )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al Seleccionar Empresa Origen '+sqlca.sqlerrtext,1,1,'E')
	end if

//SI MANEJA LOTES, CAMBIA EL DW DEL DETALLE Y AGRANDA EL DETALLE
if str.maneja_lotes = 1 then
	this.width = 5120
	dw_2.dataobject = 'dw_entrada_detalle_arriba_lote'
	dw_4.dataobject = 'dw_rep_entrada_arriba_lote'	
else
	if ii_empresa = 0 then
//		this.width = 4280
		cb_pasar_salidas.visible = false
	else
		cb_pasar_salidas.visible = true
//		this.width = 4393
	end if
	dw_2.dataobject = 'dw_entrada_detalle_arriba'
	if pos(upper(str.empr_acceso_especial),'HPSA') > 0 then
		dw_4.dataobject = 'dw_rep_entrada_arriba_hpsa'
	elseif pos(upper(str.empr_acceso_especial),'FOSTER') > 0 then
		dw_4.dataobject = 'dw_rep_entrada_arriba_foster'
	else
		dw_4.dataobject = 'dw_rep_entrada_arriba'
	end if
end if

dw_2.settransobject(sqlca);	
dw_4.settransobject(sqlca)


//  SELECT crmparam.mpar_bodega+crmparam.mpar_ubicacion
//    INTO :is_bodega_ubica_compra
//    FROM crmparam  
//   WHERE ( crmparam.mpar_g_financiero = :str.g_financiero ) AND  
//         ( crmparam.mpar_empresa = :str.empresa )   ;
//	if sqlca.sqlcode = -1 then
//		mensaje('Aviso','Error al Seleccionar la Bodega y Ubicación en Compras',sqlca.sqlerrtext)
//	end if

if isnull(is_bodega_ubica_compra) then is_bodega_ubica_compra = ' '

this.triggerevent('ue_adicionar')

//Recupera la secuencia siguiente y da opcion para buscar una
wf_orden_nueva()

  SELECT isnull(dgmempre.empr_bodegas_definidas  ,0), isnull(dgmempre.empr_ruta_entradas  ,'C:\') 
    INTO :li_bodegas_definidas , :is_ruta_archivos 
    FROM dgmempre  
   WHERE ( dgmempre.empr_g_financiero = :str.g_financiero ) AND  
         ( dgmempre.empr_empresa = :str.empresa )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Seleccionar las Bodegas '+sqlca.sqlerrtext,1,1,'E')
			return
		end if

for i = 1 to li_bodegas_definidas
	if i = 1 then
		ls_cadena = '"'+string(i)+"~t"+string(i)
		if li_bodegas_definidas = 1 then
			ls_cadena = ls_cadena + '"'
		end if
	else
		ls_cadena = ls_cadena + "/"+string(i)+"~t"+string(i)
		if li_bodegas_definidas = i then
			ls_cadena = ls_cadena + '"'
		end if
	end if
next
dw_2.Object.dmov_bodega.Values = ls_cadena
dw_12.insertrow(1)
dw_13.getchild('empresa',ldwc_plan)
ldwc_plan.settransobject(sqlca)
ldwc_plan.retrieve(str.usuario)
dw_13.insertrow(1)

  SELECT isnull(facuentas.para_cuenta_inventarios,''),   
         isnull(facuentas.para_cuenta_costos,'')  
    INTO :is_cuenta_inventarios,   
         :is_cuenta_costo_venta  
    FROM facuentas  
   WHERE ( facuentas.para_g_financiero = :str.g_financiero ) AND  
         ( facuentas.para_empresa = :str.empresa )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al Buscar Cuentas '+sqlca.sqlerrtext,1,1,'E')
	end if
	
	if is_cuenta_costo_venta = '' or is_cuenta_inventarios = '' then
		gf_mensaje('','Debe Asignar las Cuentas de Inventarios y Costos de Ventas en Parametros, Verifique !!!',1,1,'E')
		close(this)
	end if

str.frame.setmicrohelp('Entradas')
//il_tiempo = 150
//em_tiempo.text = string(150)
//timer(1)

end event

event ue_pre_aceptar;//Override
dw_1.Accepttext()

this.postevent("ue_aceptar")

end event

event ue_adicionar;//Override
if dw_1.rowcount() > 0 then
	if dw_1.getitemnumber(1,'tmov_estado') = 1 then
		dw_1.reset()
		dw_2.reset()
		dw_1.insertrow(1)
		//Pone invisible el insertar	
		dw_1.setitem(1,'tmov_g_financiero',str.g_financiero)
		dw_1.setitem(1,'tmov_empresa',str.empresa)
		dw_1.setitem(1,'tmov_autoriza',str.usuario)	
		dw_1.setitem(1,'tmov_id',str.usuario)		
		dw_1.setitem(1,'tmov_anulado',0)				
		dw_1.setitem(1,'tmov_anual',ii_ann)
		dw_1.setitem(1,'tmov_fecha',date(gf_fecha_serv()))
		dw_1.setitem(1,'intmovim_tmov_fecha_registro',gf_fecha_serv())
		dw_1.setitem(1,'tmov_estado_entrada','A')		
		dw_1.setfocus()
		dw_1.setcolumn('tmov_documento')
		wf_orden_nueva()
		dw_14.reset()
		dw_14.insertrow(1)			
		is_concepto = '005' //ASIGNA DEL EXTERIOR	
		return
	end if
end if

if datawindow = 1 then	
	dw_1.reset()
	dw_2.reset()
	dw_1.insertrow(1)
	//Pone invisible el insertar	
	dw_1.setitem(1,'tmov_g_financiero',str.g_financiero)
	dw_1.setitem(1,'tmov_empresa',str.empresa)
	dw_1.setitem(1,'tmov_autoriza',str.usuario)	
	dw_1.setitem(1,'tmov_id',str.usuario)		
	dw_1.setitem(1,'tmov_anual',ii_ann)
	dw_1.setitem(1,'tmov_anulado',0)					
	dw_1.setitem(1,'tmov_fecha',date(gf_fecha_serv()))
	dw_1.setitem(1,'intmovim_tmov_fecha_registro',gf_fecha_serv())
	dw_1.setitem(1,'tmov_estado_entrada','A')		
	dw_1.setfocus()
	dw_1.setcolumn('tmov_documento')
	dw_14.reset()
	dw_14.insertrow(1)			
	wf_orden_nueva()
	is_concepto = '005' //ASIGNA DEL EXTERIOR
	id_cargos = 0
	id_descuento = 0
else
	if ii_usuario_bodega = 1 then return
	if dw_2.getrow() > 0 then	
		if dw_2.getitemstring(dw_2.rowcount(), 'dmov_producto') <> '' or &
			not isnull(dw_2.getitemstring(dw_2.rowcount(), 'dmov_producto')) then
			dw_2.scrolltorow(dw_2.insertrow(0))
			dw_2.setitem(dw_2.getrow(),'dmov_g_financiero',str.g_financiero)
			dw_2.setitem(dw_2.getrow(),'dmov_empresa',str.empresa)
			dw_2.setitem(dw_2.getrow(),'dmov_aplicacion','IN')
			dw_2.setitem(dw_2.getrow(),'dmov_tipo_transaccion','EN')
			dw_2.setitem(dw_2.getrow(),'dmov_concepto',is_concepto)
			dw_2.setitem(dw_2.getrow(),'dmov_documento',is_documento)			
			dw_2.setitem(dw_2.getrow(),'indmovim_dmov_costo',0)
			dw_2.setitem(dw_2.getrow(),'dmov_costo_cif',0)
		end if
	else
		dw_2.scrolltorow(dw_2.insertrow(0))
		dw_2.setitem(dw_2.getrow(),'dmov_g_financiero',str.g_financiero)
		dw_2.setitem(dw_2.getrow(),'dmov_empresa',str.empresa)
		dw_2.setitem(dw_2.getrow(),'dmov_aplicacion','IN')
		dw_2.setitem(dw_2.getrow(),'dmov_tipo_transaccion','EN')
		dw_2.setitem(dw_2.getrow(),'dmov_concepto',is_concepto)		
		dw_2.setitem(dw_2.getrow(),'dmov_documento',is_documento)					
		dw_2.setitem(dw_2.getrow(),'indmovim_dmov_costo',0)
		dw_2.setitem(dw_2.getrow(),'dmov_costo_cif',0)		
	end if
	dw_2.setfocus()
	if pos(str.empr_acceso_especial, 'HPSA') > 0 then
		dw_2.setcolumn('dmov_modelo')
	else
		dw_2.setcolumn('dmov_producto')
	end if
end if

end event

event key;//override
end event

event close;Window lw_frame

lw_frame = ParentWindow()

If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_sheet_closed")
 End If
if isvalid(this) then close(this)
end event

event ue_hay_data;//Override
end event

event resize;//Override
dw_1.width = newwidth - 50
dw_2.width = newwidth - 50
dw_2.height= newheight - 400
dw_14.y = newheight - 550
end event

event open;//override
gf_acelerador()
dw = dw_2

this.y = 0
this.x = 805
//this.height = w_fa_fondo.height - 50

This.Icon = str.icono

this.postevent("ue_post_open")


This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)

str.frame.SetRedraw ( True )
end event

event ue_print;////override
string ls_expresion

if il_secuencia = 0 then return
if ii_usuario_bodega = 1 then return

if dw_8.visible then
	OpenWithParm(w_dw_print_options, dw_8)
	If Message.DoubleParm = -1 Then Return
	dw_8.Print(True)
elseif dw_7.visible then
	OpenWithParm(w_dw_print_options, dw_7)
	If Message.DoubleParm = -1 Then Return
	dw_7.Print(True)
else
	THIS.TRIGGEREVENT('ue_aceptar')
	
	dw_4.retrieve(str.g_financiero, str.empresa, il_secuencia , ii_ann)
	//
	if dw_4.rowcount() = 0 then return
	//
	ls_expresion = str.nombre_empresa
	dw_4.object.nom_empresa.expression = "'"+ls_expresion+"'"
	
	dw_4.object.datawindow.print.preview = 'yes'
	dw_4.object.datawindow.print.preview.zoom = 100
	dw_4.visible = true
	//
	OpenWithParm(w_dw_print_options, dw_4)
	//
	If Message.DoubleParm = -1 Then Return
	dw_4.Print(True)
end if
end event

event ue_aceptar;integer  li_contador,ll_update,ll_update2,li_encontro,li_lin_ref,li_posicion,li_frac2, li_find
integer  li_costo,anulado=0,li_linea_uno,li_linea_dos,indice, li_existe_detalle, li_empresa ,li_salvar
decimal  li_cantidad,li_cantid, li_cos_tran
datetime ldt_fecha,ldt_fecha_real
string   ls_documento,ls_aplic,ls_tipo,ls_medida,ls_producto,ls_concepto, fila, ls_conc,ls_error,ls_cuenta, ls_expresion, ls_doc, ls_bodega
Long		ll_found, ll_ann,ll_secuencia
boolean  lb_existe

dw_1.acceptText()
dw_2.acceptText()
//dw=dw_1  

if ii_usuario_bodega = 1 then return

if dw_1.getitemnumber(1, 'tmov_estado', primary!, true) <> 0 then
	gf_mensaje('','La Entrada ya fue Actualizada, Verifique !!!',1,1,'E')
	return
end if

ls_tipo = dw_1.getitemstring(1,'tmov_concepto')

if ls_tipo <> 'DV' then
	if (dw_1.getitemNumber(1,"tmov_terceros")) = 0 or isnull(dw_1.getitemNumber(1,"tmov_terceros")) then
		gf_mensaje("Atencion Sr. Usuario","Debe asignar el proveedor antes de guardar.",1,1,'E')
		dw_1.setcolumn("tmov_terceros")
		return
	end if
end if	

ldt_fecha = dw_1.getitemdatetime(1,'tmov_fecha')
if not gf_valida_fecha_conta(ldt_fecha) then
	return
end if

sqlca.autocommit = false

indice = 0

il_secuencia = dw_1.getitemNumber(1,"tmov_secuencia")

/*grabamos los datos del DW_1 de la tabla de INTMOVIM*////////////////
if dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = New! or &
	dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = NewModified! then 	
	
	//ll_secuencia = wf_buscar_secuencia() //buscamos la secuencia de dgmserie//
//	wf_buscar_secuencia(ll_secuencia)
   indice = 1
	
	if (dw_1.getitemNumber(1,"tmov_secuencia")) = 0 or isnull(dw_1.getitemNumber(1,"tmov_secuencia")) then
		mensaje("Atencion Sr. Usuario","Debe Asignar un valor valido, Verifique.","")
		sqlca.autocommit = true
		return
	end if	
	if (dw_1.getitemString(1,"tmov_documento")) = '' or isnull(dw_1.getitemString(1,"tmov_documento")) then
		mensaje("Atencion Sr. Usuario","Debe Asignar el Documento, Verifique.","")
		dw_1.setcolumn('tmov_documento')
		sqlca.autocommit = true
		return
	end if	
	
	/*Actualiza el Encabezado*/
	ll_update = dw_1.update()
	
	/*Actualiza la Secuencia en Dgmserie*/
	if ll_update =1 then
		 commit using sqlca;
	else
		ls_error =sqlca.sqlerrtext
		rollback using sqlca;
		sqlca.autocommit = true
		gf_Mensaje("---Atención---","¡Error al Actualizar el encabezado !" +ls_error,1,1,'E')
		ib_aceptar = False
		is_actualiza=''
		return
	end if
	 sqlca.autocommit = true
	 
//	if ll_secuencia <> ii_secuencia then
//		 messagebox('Atención ',' La Secuencia ha Cambiado a: '+string(ll_secuencia))
//	end if
	/**/
else
	ll_update = dw_1.update()
  if ll_update = 1 then
		commit;
		sqlca.autocommit = true
	else
		ls_error =sqlca.sqlerrtext
		rollback using sqlca;
		sqlca.autocommit = true
		ib_aceptar = False
		gf_Mensaje("---Atención---","¡Error al Actualizar el encabezado !"+ls_error,1,1,'E')
		is_actualiza=''
		return
	end if
//	ll_secuencia = long(dw_1.getitemstring(1,'no_orden'))
end if

sqlca.autocommit = false

/*grabamos los datos de DW_2 en la tabla INDTRANS*/
dwItemStatus ls_status


// Borra registros en blanco

for li_contador = 1 to dw_2.rowcount()
	ls_producto = dw_2.getitemstring(li_contador,"dmov_producto")
	if ls_producto = "" or isnull(ls_producto) then		
		dw_2.deleterow(li_contador)
		li_contador --
	End If
	ls_bodega = dw_2.getitemstring(li_contador,"dmov_bodega")
	if ls_bodega = '' or isnull(ls_bodega) then
		rollback using sqlca;
		sqlca.autocommit = true
		ib_aceptar = False
		is_actualiza=''
		gf_Mensaje("---Aviso---","Debe Asignar la Bodega antes de Guardar",1,1,'E')
		dw_2.scrolltorow(li_contador)
		dw_2.setcolumn('dmov_bodega')
		return
	end if

	
	dw_2.setitem(li_contador,'dmov_secuencia',il_secuencia)
	dw_2.setitem(li_contador,'dmov_anual',ii_ann)
	dw_2.setitem(li_contador,"dmov_linea",li_contador)
	dw_2.setitem(li_contador,"dmov_aplicacion",'IN')
	dw_2.setitem(li_contador,"dmov_tipo_transaccion",'EN')
	dw_2.setitem(li_contador,"dmov_concepto",is_concepto)
	dw_2.setitem(li_contador,"dmov_g_financiero",str.g_financiero)
	dw_2.setitem(li_contador,"dmov_empresa",str.empresa)
	dw_2.setitem(li_contador,"dmov_documento",is_documento)
	
Next
//
li_salvar=1

If li_salvar = 1 then //Si todas las bodegas/ubicacion destino existen que salve
													
	ll_update =dw_2.update()
			if ll_update = -1 then
				ls_error =sqlca.sqlerrtext
				rollback using sqlca;
				sqlca.autocommit = true
				ib_aceptar = False
				is_actualiza=''
				gf_Mensaje("---Aviso---","¡Error al Actualizar Detalle de la Entrada! "+ls_error,1,1,'E')
				return
			end if

		
	  if ll_update = 1 then
		  sqlca.autocommit = true
		  ib_aceptar = True

		  if ib_rebajar_pedido then //SI VIENE DE PASE DE PEDIDOS
		  	if ib_transito then
				if not wf_rebaja_transito() then
					ls_error =sqlca.sqlerrtext
					rollback using sqlca;
					sqlca.autocommit = true
					gf_Mensaje("---Atención---","¡Error al Actualizar Cantidades Pasadas ! "+ls_error,1,1,'E')
					ib_aceptar = False
					is_actualiza=''
					return						
				 end if				
		    else
				if not wf_rebaja_pedido() then
					ls_error =sqlca.sqlerrtext
					rollback using sqlca;
					sqlca.autocommit = true
					gf_Mensaje("---Atención---","¡Error al Actualizar Cantidades Pasadas ! "+ls_error,1,1,'E')
					ib_aceptar = False
					is_actualiza=''
					return						
				 end if
			end if
		  end if

		  /* Refresca los datos del datawindows cuando la Actualizacion fue correcta */
		  dw_1.setredraw(false)
		  dw_2.setredraw(false)				
		  long ll_fila
		  ll_fila = dw_2.getrow()
		  dw_1.retrieve(str.g_financiero, str.empresa, il_secuencia, ii_ann )
		  dw_2.retrieve(str.g_financiero, str.empresa, il_secuencia, ii_ann )
		  if dw_2.rowcount() = 0 then
			 datawindow = 2
			 dw = dw_2
			 this.triggerevent("ue_adicionar")
			 ll_fila = 1
		  else
			id_descuento 		    = dw_1.getitemnumber(1,'tmov_descuento')
			id_cargos			    = dw_1.getitemnumber(1,'tmov_total_cargos_final')
			dw_2.setitem(1,'cargos',id_cargos)
			dw_2.setitem(1,'descuento',id_descuento)			
		  end if
		  
		  dw_2.scrolltorow(il_row)
		  dw_1.setredraw(true)
		  dw_2.setredraw(true)	
		  
		  /////////////mensaje("Atención","Acualización Existosa","")
		  
		  str.frame.setmicrohelp('Entrada Guardada.')
		  commit using sqlca ; 
		  
		else
			ls_error =sqlca.sqlerrtext
			rollback using sqlca;
			sqlca.autocommit = true
			ib_aceptar = False
			is_actualiza=''
			gf_Mensaje("---Aviso---","¡Error al Actualizar! "+ls_error,1,1,'E')
		end if
end if

sqlca.autocommit = true
//mensaje('Informacion','Actualizacion Exitosa','')
is_actualiza=''

end event

event timer;call super::timer;il_segundos = il_segundos + 1

if il_segundos > il_tiempo then
	wf_recupera()
	il_segundos = 0
end if
end event

event ue_busqueda;call super::ue_busqueda;//
String  ls_find,ls_codigo, ls_documento
integer li_c, li_b
long    ll_lter
string  ls_lter,ls_des
dw_1.accepttext()
Datawindow        dww
str_dg_dynamic_find	lstr_df

	lstr_df.texto_campo [1,1] = "intmovim.tmov_secuencia"
	lstr_df.texto_campo [1,2] = "Secuencia"
	lstr_df.texto_campo [1,3] = "tmov_secuencia"
	lstr_df.texto_campo [1,4] = 'V'
	lstr_df.texto_campo [1,5] = '280'	
	lstr_df.texto_campo [2,1] = "intmovim.tmov_documento"
	lstr_df.texto_campo [2,2] = "Factura"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '315'	
	lstr_df.texto_campo [3,1] = "dgmsubse.subs_descripcion"
	lstr_df.texto_campo [3,2] = "Tipo"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [3,5] = '415'	
	lstr_df.texto_campo [4,1] = "dgmterce.terc_descripcion"
	lstr_df.texto_campo [4,2] = "Proveedor"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '650'
	lstr_df.texto_campo [5,1] = "intmovim.tmov_fecha"
	lstr_df.texto_campo [5,2] = "Fecha"
	lstr_df.texto_campo [5,3] = ""
	lstr_df.texto_campo [5,4] = 'V'
	lstr_df.texto_campo [5,5] = '285'
	lstr_df.texto_campo [6,1] = "intmovim.tmov_documento_entrada"
	lstr_df.texto_campo [6,2] = "Entrada"
	lstr_df.texto_campo [6,3] = ""
	lstr_df.texto_campo [6,4] = 'V'
	lstr_df.texto_campo [6,5] = '420'	
	lstr_df.texto_campo [7,1] = "case when intmovim.tmov_estado = 1 then 'ACTUALIZADA' else 'PENDIENTE' end ESTADO"
	lstr_df.texto_campo [7,2] = "Estado"
	lstr_df.texto_campo [7,3] = ""
	lstr_df.texto_campo [7,4] = 'V'
	lstr_df.texto_campo [7,5] = '280'	
	lstr_df.texto_campo [8,1] = "(SELECT round(sum(dmov_cantidad * dmov_costo_fob),2)  FROM indmovim  WHERE ( intmovim.tmov_g_financiero = indmovim.dmov_g_financiero ) and ( intmovim.tmov_empresa = indmovim.dmov_empresa ) and ( intmovim.tmov_aplicacion = indmovim.dmov_aplicacion ) and  ( intmovim.tmov_tipo_transaccion = indmovim.dmov_tipo_transaccion ) and  ( intmovim.tmov_secuencia = indmovim.dmov_secuencia ) and  ( intmovim.tmov_anual = indmovim.dmov_anual ) and   ( intmovim.tmov_concepto = indmovim.dmov_concepto )    ) valor "
	lstr_df.texto_campo [8,2] = "Valor"
	lstr_df.texto_campo [8,3] = ""
	lstr_df.texto_campo [8,4] = 'V'
	lstr_df.texto_campo [8,5] = '350'		
	lstr_df.texto_campo [9,1] = "intmovim.tmov_comentario"
	lstr_df.texto_campo [9,2] = "Observacion"
	lstr_df.texto_campo [9,3] = ""
	lstr_df.texto_campo [9,4] = 'V'
	lstr_df.texto_campo [9,5] = '600'		

	lstr_df.tabla = " intmovim, dgmterce, dgmsubse "
		
	lstr_df.tabla_where = &
				"WHERE (intmovim.tmov_g_financiero = dgmsubse.subs_g_financiero) and " +&
						 "(intmovim.tmov_empresa = dgmsubse.subs_empresa ) 	and " +&
						 "(intmovim.tmov_concepto = dgmsubse.subs_sub_trans ) 	and " +&						 
						 " (intmovim.tmov_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(intmovim.tmov_empresa = " + string(str.empresa) + ") 	and " +&
 						 "(intmovim.tmov_anual = " + string(ii_ann) + ") 	and " +&
						 "(intmovim.tmov_tipo_transaccion = 'EN' ) and " +&
						"(intmovim.tmov_terceros = dgmterce.terc_tercero)"
	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm



If len (ls_find) = 0 Then Return
	
ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)
il_secuencia = long(ls_codigo)
dw_1.retrieve(str.g_financiero, str.empresa, il_secuencia, ii_ann )
is_concepto  = dw_1.getitemstring(1,'tmov_concepto')
is_documento = dw_1.getitemstring(1,'tmov_documento')
dw_2.reset()
dw_2.retrieve(str.g_financiero, str.empresa, il_secuencia, ii_ann )
dw_2.scrolltorow(dw_2.rowcount())
dw_2.setfocus()
if dw_1.rowcount() > 0 then
	ll_lter = dw_1.getitemnumber(1,'tmov_terceros')
	ls_documento = dw_1.getitemstring(1,'tmov_documento')
	dw_14.retrieve(str.g_financiero, str.empresa, ll_lter, ls_documento, ii_ann )
else
	dw_14.reset()
	dw_14.insertrow(1)
end if
id_descuento 		    = dw_1.getitemnumber(1,'tmov_descuento')
id_cargos			    = dw_1.getitemnumber(1,'tmov_total_cargos_final')
if dw_2.rowcount() > 0 then
	dw_2.setitem(1,'cargos',id_cargos)
	dw_2.setitem(1,'descuento',id_descuento)
	dw_2.setitem(1,'usuario_bodega',ii_usuario_bodega)
end if
end event

event ue_eliminar;//override
datetime ldt_fecha_tran
if ii_usuario_bodega = 1 then return

if datawindow = 1 then	
	if dw_1.getitemnumber(1,'tmov_estado') <> 0 then
		gf_mensaje('','No Puede Eliminar una Entrada Actualizada, Verifique !!!',1,1,'E')
		return
	end if

	ldt_fecha_tran = dw_1.getitemdatetime(1,'tmov_fecha')
	if not gf_valida_fecha_conta(ldt_fecha_tran) then
		return
	end if
	
	if gf_mensaje('','Esta Seguro de Eliminar la Entrada ?',2,2,'E') = 1 then
		sqlca.autocommit = false
	  DELETE FROM indmovim  
		WHERE ( indmovim.dmov_g_financiero = :str.g_financiero ) AND  
				( indmovim.dmov_empresa = :str.empresa ) AND  
				( indmovim.dmov_aplicacion = 'IN' ) AND  
				( indmovim.dmov_tipo_transaccion = 'EN' ) AND  
				( indmovim.dmov_secuencia = :il_secuencia ) AND  
				( indmovim.dmov_anual = :ii_ann )  ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al eliminar detalle ' + sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if
	
	  DELETE FROM indgasto  
		WHERE ( indgasto.gast_g_financiero = :str.g_financiero ) AND  
				( indgasto.gast_empresa = :str.empresa ) AND  
				( indgasto.gast_aplicacion = 'IN' ) AND  
				( indgasto.gast_transaccion = 'EN' ) AND  
				( indgasto.gast_secuencia = :il_secuencia ) AND  
				( indgasto.gast_ann = :ii_ann )  ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al eliminar gastos ' + sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if
	
	
	  DELETE FROM intmovim  
		WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
				( intmovim.tmov_empresa = :str.empresa ) AND  
				( intmovim.tmov_aplicacion = 'IN' ) AND  
				( intmovim.tmov_tipo_transaccion = 'EN' ) AND  
				( intmovim.tmov_secuencia = :il_secuencia ) AND  
				( intmovim.tmov_anual = :ii_ann )  ;
	
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al eliminar encabezado ' + sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if
			commit;
			sqlca.autocommit = true
			this.triggerevent('ue_adicionar')			
	end if
else
	if dw_2.rowcount() > 0 then
		dw_2.deleterow(dw_2.getrow())
	else 
		messagebox("Atención","No hay registros para borrar!")
	end if
end if
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_entrada_arriba
boolean visible = false
integer x = 46
integer y = 2040
integer width = 101
string text = ""
end type

type dw_1 from w_fa_padre`dw_1 within w_entrada_arriba
event ue_escape pbm_dwescape
integer x = 27
integer y = 12
integer width = 5504
integer height = 380
integer taborder = 10
string dataobject = "dw_entrada_encabezado"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event dw_1::ue_escape;//Override
////Codigo de Escape
//close(parent)
////parent.triggerevent("closequery")
////messagebox("Escape","Entro ...")
end event

event dw_1::ue_tabfinal;//override

end event

event dw_1::ue_down;//override
// Toma la Tecla que el usuario presione

CHOOSE CASE key
		
	CASE KeyF1! 
		
		This.Postevent("ue_helpcol")
		
	CASE	  Keyenter! 
		
	  This.Triggerevent("ue_entercol")
	  
END CHOOSE
end event

event dw_1::rbuttondown;//override
end event

event dw_1::ue_microayuda;//override
end event

event dw_1::buttonclicked;call super::buttonclicked;long ll_codigo
integer li_encontro, li_rpta
if dwo.name = 'b_1' then
	dw_3.dataobject = 'dw_proveedores'
	dw_3.title =	'Proveedores'
	dw_3.settransobject(sqlca)
	if dw_3.retrieve() = 0 then
		dw_3.insertrow(1)
	else
		ll_codigo	= dw_1.getitemnumber(1,'enca_proveedor')
		li_encontro = dw_3.find('prov_codigo = '+string(ll_codigo),1,dw_3.rowcount())
		if li_encontro > 0 then
			dw_3.scrolltorow(li_encontro)
		end if
	end if
	dw_3.setfocus()
	dw_3.width = 2500
	dw_3.x = 1493	
	dw_3.visible = true
elseif dwo.name = 'b_secuencia' then
	parent.triggerevent('ue_busqueda')
elseif dwo.name = 'b_ver' then
	string ls_column, ls_filename
	string ls_null, ls_ruta
	SetNull(ls_null)

		ls_ruta = this.getitemstring(row, 'tmov_ruta_factura')
		
		if len(ls_ruta) = 0 then return
		
		if fileexists(ls_ruta) then
			
		else
			gf_mensaje('','Archivo no Existe, Verifique !!!',1,1,'E')
			return
		end if
		
		ls_filename =ls_ruta
		
		ShellExecutew( 0 , "open", ls_filename, ls_Null, ls_Null, 1)


end if
end event

event dw_1::clicked;call super::clicked;datawindow = 1
string ls_path, ls_filename
integer li_rpta
accepttext()
date 	ld_date,ld_ini_date, ld_hoy
ld_hoy = date(gf_fecha_serv())
if dwo.name='calendario' then
	ld_ini_date=date(dw_1.GetItemDateTime(dw_1.getrow(),"tmov_fecha"))
	if year(ld_ini_date) = 1900 then
		ld_ini_date = ld_hoy
	end if
	if uo_1.visible=false then
		uo_1.wf_set_value(ld_ini_date)
		uo_1.visible=true
		uo_1.allow_close=false
		uo_1.inicializar()
		uo_1.TriggerEvent('ue_abrir')
	end if
elseif dwo.name='tmov_ruta_factura' then	
	ls_path = is_ruta_archivos
			li_rpta=GetFileOpenName ('Seleccione el archivo',ls_path,ls_filename,'XLSX','Archivos Excel (*.xlsx),*.xlsx, Archivos JPG (*.jpg),*.jpg, Archivos JPG (*.jpeg),*.jpeg, Archivos PDF (*.pdf),*.pdf')
			if li_rpta=1 then
				//this.setitem(this.getrow(), 'file_ruta_archivo', ls_path)				
				this.setitem(this.getrow(), 'tmov_ruta_factura', ls_path)
				this.accepttext()
				if this.update() = -1 then
					gf_mensaje('','Error al Guardar '+sqlca.sqlerrtext,1,1,'E')
				end if
			end if
end if
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;datawindow = 1
this.selecttext(1,100)
end event

event dw_1::itemchanged;call super::itemchanged;accepttext()
datetime ldt_fecha_tran, ldt_fecha_anterior
integer li_ann_anterior
string ls_concepto_anterior
choose case this.getcolumnname()
	case 'tmov_ruta_factura'
		if this.update() = -1 then
			gf_mensaje('','Error al Guardar '+sqlca.sqlerrtext,1,1,'E')
		end if
	case 'tmov_descuento'
		id_descuento = this.getitemnumber(1,'tmov_descuento')
		if dw_2.rowcount() > 0 then
			dw_2.setitem(1,'descuento',id_descuento)
		end if

	case 'tmov_secuencia'
		il_secuencia = this.getitemnumber(1,'tmov_secuencia')
		if dw_1.retrieve(str.g_financiero, str.empresa, il_secuencia, ii_ann ) > 0 then
			is_concepto  = dw_1.getitemstring(1,'tmov_concepto')
			is_documento = dw_1.getitemstring(1,'tmov_documento')
			id_descuento 		    = dw_1.getitemnumber(1,'tmov_descuento')
			id_cargos			    = dw_1.getitemnumber(1,'tmov_total_cargos_final')
			dw_2.reset()
			dw_2.retrieve(str.g_financiero, str.empresa, il_secuencia, ii_ann )
			dw_2.scrolltorow(dw_2.rowcount())
			dw_2.setfocus()
			if dw_2.rowcount() > 0 then
				dw_2.setitem(1,'cargos',id_cargos)
				dw_2.setitem(1,'descuento',id_descuento)
			end if
		else
			parent.triggerevent('ue_adicionar')
			dw_1.setitem(1,'tmov_secuencia',il_secuencia)
		end if
	case 'tmov_concepto'
		is_concepto = data
//		if this.getitemnumber(1,'tmov_estado') = 0 then
			if dw_2.rowcount() > 0  then
				if dw_2.getitemstring(1,'dmov_producto') <> '' and not isnull(dw_2.getitemstring(1,'dmov_producto')) then
					ls_concepto_anterior = dw_1.getitemstring(1,'tmov_concepto', Primary!, true)
					if gf_mensaje('','Esta Seguro de Cambiar el Tipo de la Entrada ???',2,1,'E') = 1 then
							if is_concepto <> ls_concepto_anterior then
								wf_cambiar_tipo(ls_concepto_anterior)
							end if
					else
						dw_1.setitem(1,'tmov_concepto',ls_concepto_anterior)
						return 2	
					end if
				end if
	//		end if
		end if		
	case 'tmov_documento'
		is_documento = data
	case 'tmov_anual'
		ii_ann = integer(data)
		datawindow = 1
		parent.triggerevent('ue_adicionar')
		
	case 'tmov_fecha'
		ldt_fecha_tran 	 = this.getitemdatetime(this.getrow(),'tmov_fecha')		
		ldt_fecha_anterior = this.getitemdatetime(this.getrow(),'tmov_fecha', Primary!, True)		
		ii_ann = year(date(dw_1.getitemdatetime(dw_1.getrow(),'tmov_fecha')))
		li_ann_anterior = dw_1.getitemnumber(1,'tmov_anual')
		
		if not gf_valida_fecha_conta(ldt_fecha_anterior) then			
			dw_1.setitem(1,'tmov_fecha', ldt_fecha_anterior)
			dw_1.setcolumn('tmov_fecha')
			return 2
		end if

		if not gf_valida_fecha_conta(ldt_fecha_tran) then			
			dw_1.setitem(1,'tmov_fecha', ldt_fecha_anterior)
			dw_1.setcolumn('tmov_fecha')
			return 2
		end if
	
		if not gf_valida_fecha_futura(ldt_fecha_tran) then			
			if ldt_fecha_tran = ldt_fecha_anterior then
				dw_1.setitem(1,'tmov_fecha', date(gf_fecha_serv()))				
			else
				dw_1.setitem(1,'tmov_fecha', ldt_fecha_anterior)
			end if
			dw_1.setcolumn('tmov_fecha')
			return 2
		end if
		
		//Si los anios son diferentes asigna el anio
		if ii_ann <> li_ann_anterior then
			dw_1.setitem(1,'tmov_anual',ii_ann)
		end if
	case 'tmov_comentario'
		if this.getitemnumber(1,'tmov_estado') = 1 then
			if dw_1.update() = -1 then
				gf_mensaje('','Error al Actualizar Comentario '+sqlca.sqlerrtext,1,1,'E')
			end if
		end if

end choose
end event

event dw_1::doubleclicked;call super::doubleclicked;string ls_column, ls_filename
string ls_null, ls_ruta
SetNull(ls_null)
ls_column = dwo.name

if ls_column = 'enca_secuencia_t' then
	if il_secuencia <> 0 and not isnull(il_secuencia) then
		dw_12.visible = true
		dw_12.setfocus()
	end if
elseif ls_column = 'tmov_ruta_factura' then
		ls_ruta = this.getitemstring(row, 'tmov_ruta_factura')
		
		if len(ls_ruta) = 0 then return
		
		if fileexists(ls_ruta) then
			
		else
			gf_mensaje('','Archivo no Existe, Verifique !!!',1,1,'E')
			return
		end if
		
		ls_filename =ls_ruta
		
		ShellExecutew( 0 , "open", ls_filename, ls_Null, ls_Null, 1)
end if

end event

type st_ayuda from w_fa_padre`st_ayuda within w_entrada_arriba
integer x = 2793
integer y = 636
end type

type dw_2 from datawindow within w_entrada_arriba
event ue_enter pbm_dwnprocessenter
event ue_down pbm_dwnkey
event ue_helpcol ( )
integer x = 18
integer y = 408
integer width = 4983
integer height = 1320
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle de la Orden"
string dataobject = "dw_entrada_detalle_arriba"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_enter;if str.maneja_lotes = 0 then
	if this.getcolumnname() = 'dmov_contrato' then		
		if this.getrow() = this.rowcount() then
			parent.triggerevent('ue_aceptar')
				datawindow = 2		
			parent.triggerevent('ue_adicionar')
		else
			this.scrolltorow(this.getrow() + 1)
		//	if pos(str.empr_acceso_especial, 'HPSA') > 0 then
		//		this.setcolumn('dmov_modelo')
		//	else
				this.setcolumn('dmov_producto')
		//	end if
		end if
	elseif this.getcolumnname() = 'dmov_producto' or this.getcolumnname() = 'dmov_modelo' then	
		this.setcolumn('dmov_bodega')
	elseif this.getcolumnname() = 'dmov_bodega' then	
		this.setcolumn('dmov_cantidad')	
	elseif this.getcolumnname() = 'dmov_peso' then	
		this.setcolumn('dmov_contrato')			
	elseif this.getcolumnname() = 'dmov_costo_fob' then	
		this.setcolumn('dmov_bulto')	
	elseif this.getcolumnname() = 'dmov_bulto' then	
		this.setcolumn('dmov_peso')		
	elseif this.getcolumnname() = 'dmov_cantidad' then	
		this.setcolumn('dmov_costo_fob')	
	end if
else
	if this.getcolumnname() = 'dmov_fecha_expiracion' then		
		if this.getrow() = this.rowcount() then
			parent.triggerevent('ue_aceptar')
				datawindow = 2		
			parent.triggerevent('ue_adicionar')
		else
			this.scrolltorow(this.getrow() + 1)
		//	if pos(str.empr_acceso_especial, 'HPSA') > 0 then
		//		this.setcolumn('dmov_modelo')
		//	else
				this.setcolumn('dmov_producto')
		//	end if
		end if
	elseif this.getcolumnname() = 'dmov_producto' or this.getcolumnname() = 'dmov_modelo' then	
		this.setcolumn('dmov_bodega')
	elseif this.getcolumnname() = 'dmov_bodega' then	
		this.setcolumn('dmov_cantidad')	
	elseif this.getcolumnname() = 'dmov_costo_fob' then	
		this.setcolumn('dmov_bulto')	
	elseif this.getcolumnname() = 'dmov_bulto' then	
		this.setcolumn('dmov_peso')		
	elseif this.getcolumnname() = 'dmov_cantidad' then	
		this.setcolumn('dmov_costo_fob')	
	elseif this.getcolumnname() = 'dmov_peso' then	
		this.setcolumn('dmov_cubicaje')
	elseif this.getcolumnname() = 'dmov_cubicaje' then	
		this.setcolumn('dmov_lote')
	elseif this.getcolumnname() = 'dmov_lote' then	
		this.setcolumn('dmov_fecha_elaboracion')	
	elseif this.getcolumnname() = 'dmov_fecha_elaboracion' then	
		this.setcolumn('dmov_fecha_expiracion')			
	end if	
end if
return 2
end event

event ue_down;//override
// Toma la Tecla que el usuario presione

CHOOSE CASE key
		
	CASE KeyF1! 
		if this.getcolumnname() = 'dmov_producto' or this.getcolumnname() = 'dmov_modelo'  then
			This.Postevent("ue_helpcol")
		end if
		
	CASE	  Keyenter! 
		
	  This.Triggerevent("ue_entercol")
	  
END CHOOSE
end event

event ue_helpcol();//Busqueda del producto
//
String  ls_find,ls_codigo, ls_modelo
integer li_c, li_b, li_fila, li_fila2
long    ll_lter
string  ls_lter,ls_des

Datawindow        dww
str_dg_dynamic_find	lstr_df
	
	if this.getcolumnname() = 'dmov_producto' then
		li_fila = 1
		li_fila2 = 2
	else
		li_fila = 2
		li_fila2 = 1
	end if
	
	lstr_df.texto_campo [li_fila,1] = "inmprodu.prod_producto"
	lstr_df.texto_campo [li_fila,2] = "Referencia"
	lstr_df.texto_campo [li_fila,3] = "prod_producto"
	lstr_df.texto_campo [li_fila,4] = 'V'
//	lstr_df.texto_campo [1,5] = '280'	
	lstr_df.texto_campo [li_fila2,1] = "inmprodu.prod_producto_dos"
	lstr_df.texto_campo [li_fila2,2] = "Modelo"
	lstr_df.texto_campo [li_fila2,3] = ""
	lstr_df.texto_campo [li_fila2,4] = 'V'
//	lstr_df.texto_campo [2,5] = '770'
	lstr_df.texto_campo [3,1] = "inmprodu.prod_descripcion"
	lstr_df.texto_campo [3,2] = "Descripcion"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [3,5] = '1070'
	
	lstr_df.texto_campo [4,1] = "datediff(month, prod_entrada_fecha, getdate()) mes"
	lstr_df.texto_campo [4,2] = "M"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '100'
	
	lstr_df.texto_campo [5,1] = "convert(numeric(8,2),inmprodu.prod_existencia_total / medi_cantidad) prod_existencia_total"
	lstr_df.texto_campo [5,2] = "Exist."
	lstr_df.texto_campo [5,3] = ""
	lstr_df.texto_campo [5,4] = 'V'
	lstr_df.texto_campo [5,5] = '270'

	lstr_df.texto_campo [6,1] = "convert(numeric(8,2),inmprodu.prod_reserva_total / medi_cantidad) prod_reserva_total"
	lstr_df.texto_campo [6,2] = "Reserva"
	lstr_df.texto_campo [6,3] = ""
	lstr_df.texto_campo [6,4] = 'V'
	lstr_df.texto_campo [6,5] = '270'

	lstr_df.texto_campo [7,1] = "convert(numeric(8,2),(inmprodu.prod_existencia_total  - inmprodu.prod_reserva_total) / medi_cantidad) disponible"
	lstr_df.texto_campo [7,2] = "Dispo."
	lstr_df.texto_campo [7,3] = ""
	lstr_df.texto_campo [7,4] = 'V'
	lstr_df.texto_campo [7,5] = '270'

	lstr_df.texto_campo [8,1] = "convert(numeric(8), inmprodu.prod_empaque) prod_empaque"
	lstr_df.texto_campo [8,2] = "Empaque"
	lstr_df.texto_campo [8,3] = ""
	lstr_df.texto_campo [8,4] = 'V'
	lstr_df.texto_campo [8,5] = '270'
	
	lstr_df.texto_campo [9,1] = "inmprodu.prod_medida"
	lstr_df.texto_campo [9,2] = "Uni."
	lstr_df.texto_campo [9,3] = ""
	lstr_df.texto_campo [9,4] = 'V'
	lstr_df.texto_campo [9,5] = '120'
	
	lstr_df.texto_campo [10,1] = "cradivis.adiv_nombre_div"
	lstr_df.texto_campo [10,2] = "Division"
	lstr_df.texto_campo [10,3] = ""
	lstr_df.texto_campo [10,4] = 'V'
	lstr_df.texto_campo [10,5] = '870'
	
	lstr_df.texto_campo [11,1] = "cragrupo.agru_descripcion_grupo"
	lstr_df.texto_campo [11,2] = "Grupo"
	lstr_df.texto_campo [11,3] = ""
	lstr_df.texto_campo [11,4] = 'V'
	lstr_df.texto_campo [11,5] = '870'


	lstr_df.tabla = " inmprodu, cradivis, cragrupo, inamedid "
		
	lstr_df.tabla_where = &
		"WHERE ( cragrupo.agru_g_financiero = inmprodu.prod_g_financiero ) and  " +&
         "( cragrupo.agru_empresa = inmprodu.prod_empresa ) and  " +&
         "( cragrupo.agru_codigo_div = inmprodu.prod_division ) and " +&  
         "( cragrupo.agru_codigo_grupo = inmprodu.prod_grupo ) and " +&  			
         "( inmprodu.prod_g_financiero = cradivis.adiv_g_financiero ) and " +& 
         "( inmprodu.prod_empresa = cradivis.adiv_empresa ) and  " +&
         "( inmprodu.prod_division = cradivis.adiv_codigo_div ) and " +&  
         "( inmprodu.prod_medida = inamedid.medi_medida ) and " +&  			
		"(inmprodu.prod_g_financiero = " + string(str.g_financiero) + ") and " +&
		"(inmprodu.prod_empresa = " + string(str.empresa) + ") "	
		 
	OpenWithParm(w_buscar_producto, lstr_df)
	ls_find = Message.StringParm



If len (ls_find) = 0 Then Return
	
ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)
this.setitem(this.getrow(),'dmov_producto',ls_codigo)
	  SELECT inmprodu.prod_producto_dos  
		 INTO :ls_modelo  
		 FROM inmprodu  
		WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
				( inmprodu.prod_empresa = :str.empresa ) AND  
				( inmprodu.prod_producto = :ls_codigo )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Buscar Modelo '+sqlca.sqlerrtext,1,1,'E')
		end if
this.setitem(this.getrow(),'dmov_modelo',ls_modelo)
this.accepttext()
if this.getcolumnname() = 'dmov_producto' then
	this.trigger event itemchanged(this.getrow(), object, ls_codigo)
else
	this.trigger event itemchanged(this.getrow(), object, ls_modelo)
end if
end event

event itemfocuschanged;datawindow = 2
integer li_retorno
li_retorno = this.SelectText( 1, 99) 

end event

event clicked;if dwo.name = 'p_delete' then
	dw_2.scrolltorow(row)
	parent.triggerevent('ue_eliminar')
	return
end if

if this.rowcount() = 0 then
	datawindow = 1
	parent.triggerevent('ue_aceptar')
end if

datawindow = 2

if	dwo.name = 'p_add' then
	parent.triggerevent('ue_adicionar')
elseif dwo.name = 'p_buscar' then
	dw_2.scrolltorow(row)
	This.triggerevent("ue_helpcol")
end if
end event

event buttonclicked;string ls_codigo
integer li_encontro, li_imprimir, i
if dwo.name = 'b_marcar' then
	if this.rowcount() > 0 then
		if this.getitemnumber(1,'imprimir') = 1 then
			li_imprimir = 0
		else
			li_imprimir = 1
		end if
		for i = 1 to this.rowcount()
			this.setitem(i,'imprimir',li_imprimir)
		next
	end if	
elseif dwo.name = 'b_productos' then
	
	string ls_producto
	str_kardex  str_opcion
			
	if dw_2.rowcount() > 0 then
		ls_producto = dw_2.getitemstring(dw_2.getrow(),'dmov_producto')				
	end if			
	str_opcion.kproducto=ls_producto
	
	OpenSheetWithParm(w_productos,str_opcion,str.frame,2,Original!)		
	
elseif dwo.name = 'b_unidades' then
	dw_3.dataobject = 'dw_unidades'
	dw_3.title =	'Unidades de Medida'
	dw_3.settransobject(sqlca)
	if dw_3.retrieve() = 0 then
		dw_3.insertrow(1)
	else
		ls_codigo	= dw_2.getitemstring(dw_2.getrow(),'deta_unidad')
		li_encontro = dw_3.find('medi_unidad = "'+string(ls_codigo)+'"',1,dw_3.rowcount())
		if li_encontro > 0 then
			dw_3.scrolltorow(li_encontro)
		end if
	end if
	dw_3.setfocus()
	dw_3.width = 1800
	dw_3.x = 1493
	dw_3.visible = true	
end if
end event

event itemchanged;string ls_codigo, ls_descripcion, ls_uni_empaque, ls_uni, ls_modelo
long   ll_bultos, ll_cantidad, ll_fraccion
decimal{4} ld_costo
decimal{3} ld_peso, ld_cubicaje, ld_bultos
decimal{2} ld_cantidad, ld_monto_final
accepttext()
if this.getcolumnname() = 'dmov_producto' then
	  ls_codigo = data
	  if not wf_carga_prod(ls_codigo, ls_descripcion, ls_uni, ls_modelo) then return 2
		if ls_descripcion = '' or isnull(ls_descripcion) then
			gf_mensaje('','Referencia no Existe, Verifique !!!',1,1,'E')
			this.setitem(row,'dmov_producto','')
			this.setcolumn('dmov_producto')
			return 2
		else
			this.setitem(row, 'prod_descripcion', ls_descripcion)
			this.setitem(row, 'dmov_unidad_medida', ls_uni)
			this.setitem(row, 'dmov_costo_fob', id_costo)
			this.setitem(row, 'medi_cantidad',ii_cantidad_unidad)
			this.setitem(row, 'dmov_modelo',ls_modelo)			
			this.setitem(row,'prod_empaque',il_empaque)
			this.setitem(row,'tipo_medida',ii_tipo_medida)			
			this.setcolumn('dmov_bodega')
		end if
elseif this.getcolumnname() = 'dmov_modelo' then
	  ls_modelo = data
	  if not wf_carga_prod(ls_codigo, ls_descripcion, ls_uni, ls_modelo) then return 2
		if ls_descripcion = '' or isnull(ls_descripcion) then
			gf_mensaje('','Referencia no Existe, Verifique !!!',1,1,'E')
			this.setitem(row,'dmov_producto','')
			this.setitem(row,'dmov_modelo','')
			this.setcolumn('dmov_modelo')
			return 2
		else
			this.setitem(row, 'dmov_producto', ls_codigo)
			this.setitem(row, 'prod_descripcion', ls_descripcion)
			this.setitem(row, 'dmov_unidad_medida', ls_uni)
			this.setitem(row, 'dmov_costo_fob', id_costo)
			this.setitem(row, 'medi_cantidad',ii_cantidad_unidad)
			this.setitem(row,'prod_empaque',il_empaque)			
			this.setitem(row,'tipo_medida',ii_tipo_medida)						
			this.setcolumn('dmov_bodega')
		end if
elseif this.getcolumnname() = 'dmov_cantidad' then
	ll_cantidad = long(data)	
	ll_fraccion = this.getitemnumber(row,'dmov_cant1')
	ld_cantidad = double(data)
	ld_costo = this.getitemnumber(row,'dmov_costo_fob')
	if (il_empaque * ii_cantidad_empaque) <> 0 then
		ll_bultos = (ld_cantidad * ii_cantidad_unidad + ll_fraccion ) / (il_empaque * ii_cantidad_empaque)
		ld_bultos = (ld_cantidad * ii_cantidad_unidad + ll_fraccion) / (il_empaque * ii_cantidad_empaque)			

		if ll_bultos = 0 then ll_bultos = 1
		if ld_bultos = 0 then ld_bultos = 1		
		ld_peso = ll_bultos * id_peso
		ld_cubicaje = ll_bultos * id_cubicaje
	end if
	if ll_bultos = 0 then ll_bultos = 1
	this.setitem(row,'dmov_monto_final',ld_costo * ld_cantidad)
	this.setitem(row,'dmov_bulto',ll_bultos)
	this.setitem(row,'dmov_peso',ld_peso)
	ld_cubicaje = wf_cubicaje()
	this.setitem(row,'dmov_cubicaje',ld_cubicaje)
		
//	ld_monto_final = this.getitemnumber(row,'dmov_monto_final')
//	if ld_cantidad > 0 then
//		ld_costo = ld_monto_final / ld_cantidad
//		this.setitem(row,'dmov_costo_fob',ld_costo)
//	end if

elseif this.getcolumnname() = 'dmov_costo_fob' then	
	ld_cantidad    = this.getitemnumber(row,'dmov_cantidad')
	ld_costo = this.getitemnumber(row,'dmov_costo_fob')

	if il_empaque <> 0 and ii_cantidad_empaque <> 0 then
		ll_bultos = (ld_cantidad * ii_cantidad_unidad ) / (il_empaque * ii_cantidad_empaque)
		ld_peso = ll_bultos * id_peso
		ld_cubicaje = ll_bultos * id_cubicaje
	end if
	if ll_bultos = 0 then ll_bultos = 1
	this.setitem(row,'dmov_monto_final',ld_costo * ld_cantidad)
	this.setitem(row,'dmov_bulto',ll_bultos)
	this.setitem(row,'dmov_peso',ld_peso)
	this.setitem(row,'dmov_cubicaje',ld_cubicaje)

	if this.getrow() = this.rowcount() then
		parent.triggerevent('ue_adicionar')
	else
		this.scrolltorow(this.getrow() + 1)
		this.setcolumn('dmov_producto')
	end if	

end if
end event

event rowfocuschanged;string ls_codigo, ls_descripcion, ls_uni, ls_modelo
this.accepttext()
//if this.getcolumnname() = 'dmov_producto' then
	  ls_codigo = this.getitemstring(currentrow,'dmov_producto')
	  wf_carga_prod(ls_codigo, ls_descripcion, ls_uni, ls_modelo)
       this.setitem(currentrow,'prod_empaque',il_empaque)
//end if
end event

event doubleclicked;string ls_bodega
integer i

ls_bodega = this.getitemString(row,'dmov_bodega')

for i = row to this.rowcount()
	this.setitem(i,'dmov_bodega',ls_bodega)
next
end event

type dw_3 from datawindow within w_entrada_arriba
boolean visible = false
integer x = 1193
integer y = 260
integer width = 2501
integer height = 1376
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Proveedores"
string dataobject = "dw_proveedores"
boolean controlmenu = true
boolean vscrollbar = true
string icon = "AppIcon!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;integer i
string ls_producto
datawindowchild ldwc_proveedor
if dwo.name = 'b_cerrar' then
	this.update()
	this.visible = false
	if this.dataobject = 'dw_proveedores' then
		dw_1.getchild('enca_proveedor', ldwc_proveedor)
		ldwc_proveedor.settransobject(sqlca)
		ldwc_proveedor.retrieve()
		dw_1.setfocus()
		dw_1.setcolumn('enca_proveedor')
	end if
elseif dwo.name = 'b_grabar' then
	for i = 1 to this.rowcount()
		this.setitem(i,'prod_g_financiero', str.g_financiero)
		this.setitem(i,'prod_empresa', str.empresa)
	next
	if this.update() = -1 then
		gf_mensaje('','Error al actualizar '+sqlca.sqlerrtext,1,1,'E')
	end if
end if
end event

type dw_4 from datawindow within w_entrada_arriba
boolean visible = false
integer x = 55
integer y = 20
integer width = 3817
integer height = 1876
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Impresión de la Entrada"
string dataobject = "dw_rep_entrada_arriba"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
string icon = "AppIcon!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;integer i, li_linea, li_lineas[], li_null[], j, k, li_medi_cantidad
string ls_producto, ls_temp
decimal{8} ld_costo, ld_cargo, ld_costo_cif, ld_promedio_actual, ld_costo_promedio, ld_costo_temp, ld_decimales, ld_costo_mas_gasto
decimal{2} ld_cargo_total, ld_costo_total, ld_cantidad, ld_cantidad_actual, ld_cantidad_total, ld_total_actual, ld_total_nuevo, ld_cantidad_x_producto, ld_cubicaje_x_producto, ld_cubicaje
decimal{3} ld_cubicaje_total

if rowcount = 0 then return
if dw_1.getitemnumber(1,'tmov_estado') = 1 then return
ld_cargo_total = dw_1.getitemnumber(1,'tmov_total_cargos')
ld_costo_total = dw_2.getitemnumber(1, 'valor')
if ii_costea_cubicaje = 1 then ld_cubicaje_total = dw_2.getitemnumber(1, 'cubicaje_total')

 ls_temp = this.getitemstring(1,'dmov_producto')
 j = 1
//calcula costo cif y el nuevo promedio
for i = 1 to rowcount
	
  ls_producto = this.getitemstring(i,'dmov_producto')
  ld_cantidad = this.getitemnumber(i,'dmov_cantidad')  
  ld_costo	 = this.getitemnumber(i,'dmov_costo_fob')
  if ii_costea_cubicaje = 1 then  
	ld_cubicaje = this.getitemnumber(i,'dmov_cubicaje')  
	  if ld_cubicaje = 0 or isnull(ld_cubicaje) then 
		gf_mensaje('','Cubicaje Invalido  !!',1,1,'E')
		return
	  end if
end if

  if ls_temp <> ls_producto then
  	
	  SELECT isnull(inmprodu.prod_existencia_total,0) / isnull(inamedid.medi_cantidad,1), isnull(prod_costo_promedio,0)  , medi_cantidad
		 INTO :ld_cantidad_actual , :ld_promedio_actual, :li_medi_cantidad
		 FROM inmprodu,   
				inamedid  
		WHERE ( inamedid.medi_medida = inmprodu.prod_medida ) and  
				( ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
		         ( inmprodu.prod_empresa = :str.empresa ) AND  
      		    ( inmprodu.prod_producto = :ls_temp ) )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al buscar en producto '+sqlca.sqlerrtext,1,1,'E')
				end if

	ld_costo		= this.getitemnumber(i,'dmov_costo_fob')

	ld_cantidad_actual = ld_cantidad_actual - ld_cantidad_x_producto
	//prorratea los cargos y asigna el nuevo costo cif
	if ld_costo_total = 0 then ld_costo_total = 1
	if ld_cantidad_x_producto = 0 then ld_cantidad_x_producto= 1
	if ld_cubicaje_x_producto = 0 then ld_cubicaje_x_producto= 1
	
	//CALCULA EL VALOR ADICIONAL PARA EL CIF EN BASE A LA CANTIDAD O EN BASE AL CUBICAJE
	if ii_costea_cubicaje = 1 then
		ld_cargo = ((ld_cargo_total / ld_cubicaje_total) * ld_cubicaje_x_producto) / ld_cantidad_x_producto
		//ld_cargo=(ld_cargo_total *( ( ld_costo_temp  * ld_cubicaje_x_producto)  /ld_costo_total))/ ld_cubicaje_x_producto
	else //En BASE A LA CANTIDAD
		ld_cargo=(ld_cargo_total *( ( ld_costo_temp  * ld_cantidad_x_producto)  /ld_costo_total))/ ld_cantidad_x_producto
	end if
	
	ld_costo_cif = ld_costo_temp + ld_cargo	
	ld_costo_mas_gasto = ld_costo_cif	
	//Que solo calcule el cif * .01 + .01 si es HPSA
	if id_gasto_admon > 0 and pos(str.empr_acceso_especial,'HPSA') > 0 then
		ld_costo_cif = (ld_costo_cif * id_gasto_admon) * id_gasto_admon
		ld_decimales = ld_costo_cif - truncate(ld_costo_cif,2)
		if ld_decimales * 1000 >= 1 then
			ld_costo_cif = truncate(ld_costo_cif,2) + 0.01
		end if
	end if		
		
	//calcula el costo promedio
	ld_total_actual = ld_cantidad_actual * ld_promedio_actual
	ld_total_nuevo  = ld_cantidad_x_producto * ld_costo_cif
	ld_cantidad_total = ld_cantidad_actual + ld_cantidad_x_producto
	if ld_cantidad_total = 0 then ld_cantidad_total = 1

	for k = 1 to upperbound(li_lineas)
		if ld_cantidad_actual > 0 then
			ld_costo_promedio = round(( ld_total_actual + ld_total_nuevo )	/ ld_cantidad_total	,2)
			this.setitem(li_lineas[k],'dmov_costo_promedio', ld_costo_promedio)
		else
			this.setitem(li_lineas[k],'dmov_costo_promedio', ld_costo_cif)
		end if
		this.setitem(li_lineas[k],'dmov_costo_cif',ld_costo_cif)
		this.setitem(li_lineas[k],'cantidad_por_producto',ld_cantidad_x_producto * li_medi_cantidad)	
		if pos(str.empr_acceso_especial,'HPSA') > 0 then
			this.setitem(li_lineas[k],'dmov_cargos',ld_cargo)
			this.setitem(li_lineas[k],'costo_mas_gasto',ld_costo_mas_gasto)
		end if
		if ii_costea_cubicaje = 1 then
			this.setitem(li_lineas[k],'cubicaje_por_producto',ld_cubicaje_x_producto)	
		end if
	next
	ls_temp = ls_producto
	ld_cantidad_x_producto = ld_cantidad	
	ld_cubicaje_x_producto = ld_cubicaje
	ld_costo_temp = ld_costo
    li_lineas[] = li_null[]
	li_lineas[1] = i
	j = 1
else
	 j ++
	 ld_cantidad_x_producto = ld_cantidad_x_producto + ld_cantidad	
	 ld_cubicaje_x_producto = ld_cubicaje_x_producto + ld_cubicaje
	 ld_costo_temp = ld_costo
	 li_lineas[j] = i
end if

next

SELECT inmprodu.prod_existencia_total / isnull(inamedid.medi_cantidad,1), prod_costo_promedio  , medi_cantidad
		 INTO :ld_cantidad_actual , :ld_promedio_actual, :li_medi_cantidad
		 FROM inmprodu,   
				inamedid  
		WHERE ( inamedid.medi_medida = inmprodu.prod_medida ) and  
				( ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
		         ( inmprodu.prod_empresa = :str.empresa ) AND  
      		    ( inmprodu.prod_producto = :ls_temp ) )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al buscar en producto '+sqlca.sqlerrtext,1,1,'E')
				end if

	ld_cantidad_actual = ld_cantidad_actual - ld_cantidad_x_producto
	//prorratea los cargos y asigna el nuevo costo cif
	if ld_costo_total = 0 then ld_costo_total = 1
	if ld_cantidad_x_producto = 0 then ld_cantidad_x_producto= 1
	if ld_cubicaje_x_producto = 0 then ld_cubicaje_x_producto = 1
	
	//CALCULA EL VALOR ADICIONAL PARA EL CIF EN BASE A LA CANTIDAD O EN BASE AL CUBICAJE
	if ii_costea_cubicaje = 1 then
//		ld_cargo=(ld_cargo_total *( ( ld_costo_temp  * ld_cubicaje_x_producto)  /ld_costo_total))/ ld_cubicaje_x_producto
		ld_cargo = ((ld_cargo_total / ld_cubicaje_total) * ld_cubicaje_x_producto) / ld_cantidad_x_producto
	else //En BASE A LA CANTIDAD
		ld_cargo=(ld_cargo_total *( ( ld_costo_temp  * ld_cantidad_x_producto)  /ld_costo_total))/ ld_cantidad_x_producto
	end if
	ld_costo_cif = ld_costo_temp + ld_cargo	
	ld_costo_mas_gasto = ld_costo_cif
	
	//Solo para PUNJABI
	if id_gasto_admon > 0 and pos(str.empr_acceso_especial,'HPSA') > 0 then
		ld_costo_cif = (ld_costo_cif * id_gasto_admon) * id_gasto_admon
		ld_decimales = ld_costo_cif - truncate(ld_costo_cif,2)
		if ld_decimales * 10000000 >= 1 then
			ld_costo_cif = truncate(ld_costo_cif,2) + 0.01
		end if
	end if
		
	//calcula el costo promedio
	ld_total_actual = ld_cantidad_actual * ld_promedio_actual
	ld_total_nuevo  = ld_cantidad_x_producto * ld_costo_cif
	ld_cantidad_total = ld_cantidad_actual + ld_cantidad_x_producto
	if ld_cantidad_total = 0 then ld_cantidad_total = 1

	for k = 1 to upperbound(li_lineas)
		if ld_cantidad_actual > 0 then
			ld_costo_promedio = round(( ld_total_actual + ld_total_nuevo )	/ ld_cantidad_total	,2)
			this.setitem(li_lineas[k],'dmov_costo_promedio', ld_costo_promedio)
		else
			this.setitem(li_lineas[k],'dmov_costo_promedio', ld_costo_cif)
		end if
		this.setitem(li_lineas[k],'dmov_costo_cif',ld_costo_cif)
		this.setitem(li_lineas[k],'cantidad_por_producto',ld_cantidad_x_producto * li_medi_cantidad)	
		if pos(str.empr_acceso_especial,'HPSA') > 0 then
			this.setitem(li_lineas[k],'dmov_cargos',ld_cargo)
			this.setitem(li_lineas[k],'costo_mas_gasto',ld_costo_mas_gasto)
		end if
		if ii_costea_cubicaje = 1 then
			this.setitem(li_lineas[K],'cubicaje_por_producto',ld_cubicaje_x_producto)
		end if
	next
end event

type dw_5 from datawindow within w_entrada_arriba
event ue_enter pbm_dwnprocessenter
boolean visible = false
integer x = 1829
integer y = 256
integer width = 1691
integer height = 764
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Gastos de las Entradas"
string dataobject = "dw_gastos_entradas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_enter;this.accepttext()
if this.getcolumnname() = 'dmov_monto_final' then		
	if this.getrow() = this.rowcount() then
		parent.triggerevent('ue_aceptar')
   	datawindow = 2		
		parent.triggerevent('ue_adicionar')
	else
		this.scrolltorow(this.getrow() + 1)
		this.setcolumn('dmov_producto')
	end if
elseif this.getcolumnname() = 'gast_descripcion' then	
	this.setcolumn('gast_valor')
elseif this.getcolumnname() = 'gast_codigo_gasto' then	
	this.setcolumn('gast_valor')	
end if

return 2
end event

event clicked;decimal{2} ld_gasto_total, ld_gasto_total_final

choose case dwo.name
	case 'b_cerrar'	
		
		if this.rowcount() > 0 then
			if this.getitemnumber(1,'gast_valor') = 0 then
				this.deleterow(1)
			end if
		end if
		
		if this.update() = -1 then
			gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return
		end if		
		if this.rowcount() > 0 then
			ld_gasto_total = this.getitemnumber(1,'gasto_total_costea')
			ld_gasto_total_final = this.getitemnumber(1,'gasto_total')
		else
			ld_gasto_total = 0
			ld_gasto_total_final = 0
		end if
		
		id_cargos = ld_gasto_total_final
		
		UPDATE intmovim  
		  SET tmov_total_cargos = :ld_gasto_total,
		  		tmov_total_cargos_final = :ld_gasto_total_final
		WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
				( intmovim.tmov_empresa = :str.empresa ) AND  
				( intmovim.tmov_aplicacion = 'IN' ) AND  
				( intmovim.tmov_tipo_transaccion = 'EN' ) AND  
				( intmovim.tmov_secuencia = :il_secuencia ) AND  
				( intmovim.tmov_anual = :ii_ann )  ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al grabar los cargos totales '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return
		end if
		
		commit;		
		if dw_2.rowcount() > 0 then
			dw_2.setitem(1,'cargos',id_cargos)
		end if
		this.visible = false
	case 'b_adicionar'
		if this.rowcount() < 3 then
			this.scrolltorow(this.insertrow(0))
			dw_5.setitem(this.getrow(),'gast_g_financiero',str.g_financiero)
			dw_5.setitem(this.getrow(),'gast_empresa',str.empresa)
			dw_5.setitem(this.getrow(),'gast_secuencia',il_secuencia)
			dw_5.setitem(this.getrow(),'gast_concepto',is_concepto)			
			dw_5.setitem(this.getrow(),'gast_ann',ii_ann)
			dw_5.setitem(this.getrow(),'gast_linea',this.getrow())		
			dw_5.setcolumn('gast_codigo_gasto')			
		end if
	case	'b_grabar'

		if this.update() = -1 then
			gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return
		end if
		if this.rowcount() = 0 then 
			ld_gasto_total = 0
			ld_gasto_total_final = 0
		else
			ld_gasto_total = this.getitemnumber(1,'gasto_total_costea')
			ld_gasto_total_final = this.getitemnumber(1,'gasto_total')			
		end if
		
		id_cargos = ld_gasto_total_final
		
		UPDATE intmovim  
		  SET tmov_total_cargos = :ld_gasto_total  ,
		  		tmov_total_cargos_final = :ld_gasto_total_final
		WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
				( intmovim.tmov_empresa = :str.empresa ) AND  
				( intmovim.tmov_aplicacion = 'IN' ) AND  
				( intmovim.tmov_tipo_transaccion = 'EN' ) AND  
				( intmovim.tmov_secuencia = :il_secuencia ) AND  
				( intmovim.tmov_anual = :ii_ann )  ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al grabar los cargos totales '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return
		end if
		
		commit;

		if dw_2.rowcount() > 0 then
			dw_2.setitem(1,'cargos',id_cargos)
		end if
		
end choose
end event

event itemchanged;this.accepttext()
string ls_descrip

choose case dwo.name
	case 'gast_codigo_gasto'
		ls_descrip = this.getitemstring(row,'descrip')
		this.setitem(row,'gast_descripcion',ls_descrip)
		this.setitem(row,'gast_costea',idwc_gastos.getitemnumber(idwc_gastos.getrow(),'inag_costea'))
		this.setcolumn('gast_valor')
end choose
end event

type cb_1 from commandbutton within w_entrada_arriba
integer x = 3040
integer y = 28
integer width = 402
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Gastos"
end type

event clicked;integer li_existe

if dw_1.getitemnumber(1, 'tmov_estado') <> 0 then
	gf_mensaje('','La Entrada ya fue Actualizada, Verifique !!!',1,1,'E')
	return
end if

THIS.TRIGGEREVENT('ue_aceptar')

if dw_5.retrieve(str.g_financiero, str.empresa, il_secuencia, ii_ann) = 0 then
	select count(1) into :li_existe
	from intmovim where tmov_g_financiero = :str.g_financiero and tmov_empresa = :str.empresa and
							  tmov_aplicacion = 'IN' and tmov_tipo_transaccion = 'EN' and tmov_secuencia = :il_secuencia and
							  tmov_anual = :ii_ann ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al validar encabezado '+sqlca.sqlerrtext,1,1,'E')
					return
				end if
	if li_existe > 0 then
		dw_5.scrolltorow(dw_5.insertrow(1))
		dw_5.setitem(1,'gast_g_financiero',str.g_financiero)
		dw_5.setitem(1,'gast_empresa',str.empresa)
		dw_5.setitem(1,'gast_secuencia',il_secuencia)
		dw_5.setitem(1,'gast_concepto',is_concepto)			
		dw_5.setitem(1,'gast_ann',ii_ann)
		dw_5.setitem(1,'gast_anulado',0)
		dw_5.setitem(1,'gast_linea',1)
//		dw_5.setitem(1,'gast_descripcion','FLETE')					
		dw_5.setcolumn('gast_codigo_gasto')
	else
		return
	end if
end if
dw_5.visible = true
dw_5.setfocus()
end event

type cb_2 from commandbutton within w_entrada_arriba
integer x = 3040
integer y = 144
integer width = 398
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "ACTUALIZAR"
end type

event clicked;/*ADD BY HGN 15/08/2002 PARA QUE ACTUALICE COSTO CIF*/	
	String	ls_subtran_inven, ls_tran_inven, ls_entrada, ls_expresion, ls_concepto, ls_costo_proc , ls_dbcode, ls_errtext, ls_producto, ls_documento, ls_comentario, ls_referencia, ls_cuenta, ls_cuenta_contable_proveedor, ls_nombre, ls_tran = 'FF', ls_subtran = 'FF', ls_cuenta_compras, ls_documento_entrada, ls_cuenta_descuento, ls_contrato
	integer  i, li_linea, li_existe, li_excluir_sugerido = 0, li_encontro, j
	decimal{4} ld_costo_promedio, ld_costo_cif, ld_costo_fob, ld_gastos_admon, cargo, costo_cif, costo
	decimal ld_costo_global, total_cargos, cantidad 
	decimal{2} ld_monto, ld_descuento, ld_cargos_total, ld_monto_conta, ld_cargos_costear, ld_monto_inventario
	datetime ldt_fecha	
	long ll_cantidad_por_producto, ll_tercero, linea


	parent.triggerevent('ue_aceptar')

	if dw_4.retrieve(str.g_financiero, str.empresa, il_secuencia , ii_ann) = 0 then
		gf_mensaje('','No se puede actualizar la entrada, verifique la impresion !!!',1,1,'E')
		return
	else
		
		if dw_1.getitemnumber(1, 'tmov_estado', primary!, true) <> 0 then
			return
		end if
		ls_expresion = str.nombre_empresa
		dw_4.object.nom_empresa.expression = "'"+ls_expresion+"'"

		dw_4.visible = true
		
		if gf_mensaje('','Esta Seguro de Actualizar la Entrada ?',2,1,'E') = 2 then return
		
		ldt_fecha = dw_1.getitemdatetime(1,'tmov_fecha')
		ls_documento = dw_1.getitemstring(1,'tmov_documento')
		ld_monto		= dw_2.getitemnumber(1,'valor')
		if isnull(id_descuento) then id_descuento = 0
		ld_descuento = id_descuento		
		if isnull(id_cargos) then id_cargos = 0
		ld_cargos_total = id_cargos
		ld_cargos_costear = dw_4.getitemnumber(1,'tmov_total_cargos')
		if isnull(ld_cargos_costear) then ld_cargos_costear = 0
		
		  SELECT isnull(count(*) ,0)
			 INTO :li_existe  
			 FROM intmovim  
			WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
					( intmovim.tmov_empresa = :str.empresa ) AND  
					( intmovim.tmov_aplicacion = 'IN' ) AND  
					( intmovim.tmov_tipo_transaccion = 'EN' ) AND  
					( intmovim.tmov_estado = 0 ) AND  
					( intmovim.tmov_fecha < :ldt_fecha ) AND  
					( intmovim.tmov_secuencia <> :il_secuencia )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Buscar Existencia '+sqlca.sqlerrtext,1,1,'E')
						return
					end if
			if li_existe > 0 then
		//		gf_mensaje('','Existen Entradas con Fechas Anteriores Pendientes de Actualizar, Verifique !!!',1,1,'E')
		//		return
			end if
		
		//Recorre para validar que no existan costos promedios en 0
		for i = 1 to dw_4.rowcount()
			ld_costo_promedio = dw_4.getitemnumber(i,'dmov_costo_promedio')
			if ld_costo_promedio = 0 or isnull(ld_costo_promedio) then
				gf_mensaje('','Existen Costos Invalidos, Verifique y Vuelva a Intentarlo !!!',1,1,'E')
				return		
			end if	
		next
		///////////////////////////////////////////////////////////////////
			
		sqlca.autocommit = false
		ll_tercero = dw_1.getitemnumber(1,'tmov_terceros')
		ls_concepto = dw_1.getitemString(1,'tmov_concepto')
		ls_documento_entrada = dw_1.getitemString(1,'intmovim_tmov_documento_entrada')
		
		if ls_concepto = '007' and pos(str.empr_acceso_especial,'HPSA') > 0 then  //Si es Despacho Directo, excluye de sugerido
			li_excluir_sugerido = 1	
		end if
		
	if ls_concepto <> '007' OR ( ls_concepto = '007' and pos(str.empr_acceso_especial,'HPSA') > 0 )  then
		for i = 1 to dw_4.rowcount()
			ls_producto			= dw_4.getitemstring(i,'dmov_producto')
			ld_costo_promedio = dw_4.getitemnumber(i,'dmov_costo_promedio')
			ld_costo_cif		= dw_4.getitemnumber(i,'dmov_costo_cif')
			cargo				= dw_4.getitemnumber(i,'dmov_cargos')
			ld_costo_fob		= dw_4.getitemnumber(i,'dmov_costo_fob')			
			li_linea				= dw_4.getitemnumber(i,'indmovim_dmov_linea')			
			ll_cantidad_por_producto = dw_4.getitemnumber(i,'cantidad_por_producto')									
			ls_contrato			= dw_4.getitemstring(i,'dmov_contrato')
			
		  UPDATE inmprodu  
			  SET prod_costo_fob = :ld_costo_fob,   
					prod_costo_cif = :ld_costo_cif,   
					prod_costo_promedio = :ld_costo_promedio  ,
					prod_ultima_entrada_can = :ll_cantidad_por_producto,
					prod_entrada_fecha = :ldt_fecha,
					prod_ultima_entrada_sec = :il_secuencia,
					prod_ultima_entrada_doc = :ls_documento,
					prod_tercero = :ll_tercero,
					prod_excluir_de_sugerido = :li_excluir_sugerido,
					prod_documento_entrada = :ls_documento_entrada,
					prod_contrato = :ls_contrato
			WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
					( inmprodu.prod_empresa = :str.empresa ) AND  
					( inmprodu.prod_producto = :ls_producto )  ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Actualizar producto '+sqlca.sqlerrtext,1,1,'E')
					rollback;
					sqlca.autocommit = true
					return
				end if
				li_encontro = dw_2.find('dmov_linea = '+string(li_linea),1,dw_2.rowcount())
				if li_encontro > 0 then
					dw_2.setitem(li_encontro,'dmov_cargos', cargo)
					dw_2.setitem(li_encontro,'dmov_costo_promedio', ld_costo_promedio)					
					dw_2.setitem(li_encontro,'indmovim_dmov_costo', ld_costo_cif)
					dw_2.setitem(li_encontro,'dmov_costo_cif', ld_costo_cif)
				end if
	
		next
	end if  //DEL ENTRADA DIRECTA Y NO ES HPSA
end if  // DEL ROWCOUNT() > 0

if dw_2.update() = -1 then
	gf_mensaje('','Error al Actualizar Detalle de la Entrada '+sqlca.sqlerrtext,1,1,'E')
end if

//SI NO ES ENTRADA DIRECTA O SI ES ENTRADA DIRECTA PERO ES HERMANOS PUNJABI	
if false then // ls_concepto <> '007' OR ( ls_concepto = '007' and pos(str.empr_acceso_especial,'HPSA') > 0 ) then	
	
	select  isnull(para_gastos_admon,0) 
		into :ld_gastos_admon
		from inaparam 
		where para_g_financiero= :str.g_financiero and 
				para_empresa= :str.empresa ; 
			 If Sqlca.sqlcode = -1 Then
				 gf_mensaje("","¡Error al Selecionar Parametro " +sqlca.sqlerrtext,1,1,'E')
				 Rollback;
				sqlca.autocommit = true
				return
			 End If 


	select sum((dmov_cantidad * dmov_costo_fob )+((dmov_costo_fob / medi_cantidad) * dmov_cant1)), 
			 sum(intmovim.tmov_total_cargos) 
		into :ld_costo_global, :total_cargos
	  from indmovim,intmovim,inamedid 
	where ( intmovim.tmov_g_financiero = indmovim.dmov_g_financiero ) and 
				( intmovim.tmov_empresa = indmovim.dmov_empresa ) and 
				( intmovim.tmov_aplicacion = indmovim.dmov_aplicacion ) and 
				( intmovim.tmov_tipo_transaccion = indmovim.dmov_tipo_transaccion ) and 
				( intmovim.tmov_secuencia = indmovim.dmov_secuencia ) and 
				( intmovim.tmov_anual = indmovim.dmov_anual ) and 
				( intmovim.tmov_concepto = indmovim.dmov_concepto ) and 
				( dmov_unidad_medida=medi_medida) and 
			  	(( tmov_g_financiero=:str.g_financiero ) and 
				( tmov_empresa=:str.empresa ) and 
				( tmov_aplicacion = 'IN' ) and 
				( tmov_tipo_transaccion = 'EN' ) and 
				( tmov_concepto = :ls_concepto ) and 
				( tmov_secuencia=:il_secuencia ) and 
				( tmov_anual = :ii_ann )) 
	group by tmov_g_financiero,tmov_empresa,tmov_aplicacion, tmov_tipo_transaccion,tmov_concepto,tmov_secuencia,tmov_anual ;
			 If Sqlca.sqlcode = -1 Then
				 gf_mensaje("","¡Error al Selecionar Totales de la Entrada " +sqlca.sqlerrtext,1,1,'E')
				 Rollback;
				sqlca.autocommit = true
				return
			 End If 

declare cur_entrada cursor for 
select dmov_producto,dmov_costo_fob,isnull(dmov_cantidad,0)+(isnull(dmov_cant1,0)/medi_cantidad), 
         dmov_linea 
  from indmovim,inamedid 
where dmov_g_financiero=:str.g_financiero and 
      dmov_empresa=:str.empresa and 
      dmov_aplicacion='IN' and 
      dmov_tipo_transaccion='EN' and 
      dmov_concepto = :ls_concepto and 
      dmov_secuencia= :il_secuencia and 
      dmov_anual = : ii_ann  and 
      dmov_unidad_medida=medi_medida ;	
		if sqlca.sqlcode = -1 then
			ls_errtext = sqlca.sqlerrtext
			ls_dbcode = ' # '+string(sqlca.sqldbcode)
			rollback;
			mensaje('Error'+ls_dbcode,'Error al Declarar el Cursor',ls_errtext)
			sqlca.autocommit = true
			return
		end if

		open cur_entrada;
	
		fetch cur_entrada into :ls_producto,:costo,:cantidad,:linea  ;
	
		do while sqlca.sqlcode = 0
			str.frame.setmicrohelp("Actualizando el Costo Cif de la Entrada ")		
			cargo = 0.0 
		    if ld_costo_global <> 0 then
	   	      cargo=(total_cargos *( ( costo  * cantidad)  / ld_costo_global))/ cantidad 		
		    end if 
 
 		  costo_cif=cargo+( ( costo * ld_gastos_admon ) * ld_gastos_admon )
 
		update indmovim 
		set dmov_costo =:costo_cif, 
			 dmov_costo_cif =:costo_cif, 
			 dmov_cargos = :cargo 
		where dmov_g_financiero = :str.g_financiero and 
				dmov_empresa = :str.empresa and 
				dmov_aplicacion = 'IN' and 
				dmov_tipo_transaccion = 'EN' and 
				dmov_concepto = :ls_concepto and 
				dmov_secuencia = :il_secuencia and 
				dmov_anual = :ii_ann  and 
				dmov_linea = :linea; // and 
//				dmov_producto = :ls_producto ;
			 If Sqlca.sqlcode = -1 Then
				 gf_mensaje("","¡Error al Actualizar El Costo Cif! " +sqlca.sqlerrtext,1,1,'E')
				 Rollback;
				sqlca.autocommit = true
				return
			 End If 

	 		fetch cur_entrada into :ls_producto,:costo,:cantidad,:linea  ;
			 
		loop
		close cur_entrada;
	
	END IF //Si no es entrada directa actualiza costos

	/*GENERA ASIENTO DE ENTRADAS*/
	if str.genera_asiento_entradas = 1 then
		ls_comentario = dw_1.getitemstring(1,'tmov_comentario')
		ls_entrada = dw_1.getitemstring(1,'intmovim_tmov_documento_entrada')
		ls_comentario = 'ENTRADA A INV. '+string(il_secuencia)+' FACTURA '+ls_documento+' - '+ls_comentario
		ls_referencia = string(il_secuencia)
		//Datos y cuenta del proveedor
		  SELECT dgmterce.terc_descripcion,   
					cpmprove.prov_cod_proveedor,   
					cpmprove.prov_mg_cuenta  
			 INTO :ls_nombre,   
					:ls_cuenta,   
					:ls_cuenta_contable_proveedor  
			 FROM cpmprove,   
					dgmterce  
			WHERE ( dgmterce.terc_tercero = cpmprove.prov_tercero ) and  
					( ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
					( cpmprove.prov_empresa = :str.empresa ) AND  
					( cpmprove.prov_tercero = :ll_tercero ) )   ;
			 If Sqlca.sqlcode = -1 Then
				 gf_mensaje("","¡Error al Buscar datos del Proveedor " +sqlca.sqlerrtext,1,1,'E')
				 Rollback;
				sqlca.autocommit = true
				return
			 End If 				 
			 
		//Cuenta del concepto, Cuenta de COMPRAS
		  SELECT isnull(dgmserdr.serd_mgcuenta  ,'')
			 INTO :ls_cuenta_compras  
			 FROM dgmserdr  
			WHERE ( dgmserdr.serd_g_financiero = :str.g_financiero ) AND  
					( dgmserdr.serd_empresa = :str.empresa ) AND  
					( dgmserdr.serd_transaccion = 'EN' ) AND  
					( dgmserdr.serd_sub_trans = :ls_concepto ) AND  
					( dgmserdr.serd_aplicacion = 'IN' )   ;
			 If Sqlca.sqlcode = -1 Then
				 gf_mensaje("","¡Error al Buscar datos del Proveedor " +sqlca.sqlerrtext,1,1,'E')
				 Rollback;
				sqlca.autocommit = true
				return
			 End If 	
			
			if ls_cuenta_compras = '' then
				 gf_mensaje("","Debe Asignar la Cuenta de Compras en Parametros de Inventarios, Cuentas de Compras ",1,1,'E')
				 Rollback;
				sqlca.autocommit = true
				return
			end if
	
	ls_tran 	  = 'FF'
	ls_subtran = 'FF'
	
	ls_tran_inven = 'EN'
	ls_subtran_inven = dw_1.getitemstring(1,'tmov_concepto')
	
			//Calcula el monto total del Asiento contable
			ld_monto_conta = ld_monto + ld_cargos_total - ld_descuento				
			
			//Monto del Valor de la Entrada a Inventarios
			ld_monto_inventario = ld_monto + ld_cargos_costear
				
		  INSERT INTO cptmovim  
				( movi_g_financiero,   
				  movi_empresa,   
				  movi_aplicacion,   
				  movi_tipo_transaccion,   
				  movi_sub_transaccion,   
				  movi_documento,   
				  movi_anno,   
				  movi_referencia,   
				  movi_tercero,   
				  movi_ruc_tercero,   
				  movi_naturaleza,   
				  movi_monto,   
				  movi_fecha_tran,   
				  movi_fecha_reg,   
				  movi_usuario,   
				  movi_estado,   
				  movi_comentario,   
				  movi_saldo,   
				  movi_itbm,   
				  movi_cierre_mensual,   
				  movi_pase_conta,   
				  movi_a_nombre,   
				  movi_impreso,   
				  movi_historico,   
				  movi_monto_aplicado,   
				  movi_paga_itbm,   
				  movi_monto_final,
				  movi_entrada)  
	  VALUES ( :str.g_financiero,   
				  :str.empresa,   
				  'CP',   
				  :ls_tran,   
				  :ls_subtran,   
				  :ls_documento,   
				  :ii_ann,   
				  :ls_referencia,   
				  :ll_tercero,   
				  :ls_cuenta,   
				  'C',   
				  :ld_monto_conta,   
				  :ldt_fecha,   
				  getdate(),   
				  :str.usuario,   
				  'IM',   
				  :ls_comentario,   
				  :ld_monto_conta,   
				  0,   
				  'N',   
				  'N',    
				  :ls_nombre,   
				  'S',   
				  0,   
				  0,   
				  0,   
				  :ld_monto_conta,
				  :ls_entrada)  ;
			 If Sqlca.sqlcode = -1 Then
				 gf_mensaje("","¡Error al Insertar Movimiento " +sqlca.sqlerrtext,1,1,'E')
				 Rollback;
				sqlca.autocommit = true
				return
			 End If 
			
			//Inserta el Encabezado de Contabilidad Compras
			  INSERT INTO cotdiari  
				( diar_g_financiero,   
				  diar_empresa,   
				  diar_aplicacion_mg,   
				  diar_tipo_transaccion,   
				  diar_sub_trans,   
				  diar_no_documento,   
				  diar_no_referencia,   
				  diar_banco_cuenta,   
				  diar_ann,   
				  diar_fecha_transaccion,   
				  diar_descripcion,   
				  diar_id,   
				  diar_fecha_creacion,   
				  diar_estado,   
				  diar_monto,   
				  diar_balance,   
				  diar_modificado,   
				  diar_cerrado,   
				  diar_cierre_mensual,   
				  diar_banco,   
				  diar_documento_a,   
				  diar_nombre,   
				  diar_impreso,
				  diar_comentario)  
	  VALUES ( :str.g_financiero,   
				  :str.empresa,   
				  'CP',   
				  :ls_tran,   
				  :ls_subtran,   
				  :ls_documento,   
				  :ls_referencia,   
				  '1',   
				  :ii_ann,   
				  :ldt_fecha,   
				  'COMPRAS EXTERIOR',   
				  :str.usuario,   
				  getdate(),   
				  'I',   
				  :ld_monto_conta,   
				  1,   
				  0,   
				  'N',   
				  'N',   
				  null,   
				  :ls_entrada,   
				  :ls_nombre,   
				  'S',
				  :ls_comentario)  ;
	 		If Sqlca.sqlcode = -1 Then
				 gf_mensaje("","¡Error al Insertar Encabezado Contable " +sqlca.sqlerrtext,1,1,'E')
				 Rollback;
				sqlca.autocommit = true
				return
			 End If 
		
		
			//Inserta el Detalle Contable
			//Cuenta del Proveedor
			dw_10.scrolltorow(dw_10.insertrow(0))
			dw_10.setitem(dw_10.getrow(),'ddia_fecha', date(gf_fecha_serv()))
			dw_10.setitem(dw_10.getrow(),'ddia_g_financiero',str.g_financiero)
			dw_10.setitem(dw_10.getrow(),'ddia_empresa',str.empresa)
			dw_10.setitem(dw_10.getrow(),'ddia_aplicacion_mg','CP')
			dw_10.setitem(dw_10.getrow(),'ddia_id', str.usuario)
			dw_10.setitem(dw_10.getrow(),'ddia_tipo_transaccion', ls_tran)
			dw_10.setitem(dw_10.getrow(),'ddia_sub_trans', ls_subtran)
			dw_10.setitem(dw_10.getrow(),'naturaleza','C')	
			dw_10.setitem(dw_10.getrow(),'ddia_linea',dw_10.getrow())
			dw_10.setitem(dw_10.getrow(),'tipo','I')
			dw_10.setitem(dw_10.getrow(),'ddia_ann',ii_ann)
			dw_10.setitem(dw_10.getrow(),'ddia_no_documento',ls_documento)
			dw_10.setitem(dw_10.getrow(),'ddia_no_referencia',ls_referencia)
			dw_10.setitem(dw_10.getrow(),'monto_credito',ld_monto_conta)
			dw_10.setitem(dw_10.getrow(),'ddia_mg_cuenta', ls_cuenta_contable_proveedor)
			dw_10.setitem(dw_10.getrow(),'ddia_monto',ld_monto_conta)
			dw_10.setitem(dw_10.getrow(),'ddia_tercero',ll_tercero)
			dw_10.setitem(dw_10.getrow(),'ddia_banco_cuenta','1')			
			//Cuenta de Compras
			dw_10.scrolltorow(dw_10.insertrow(0))
			dw_10.setitem(dw_10.getrow(),'ddia_fecha', date(gf_fecha_serv()))
			dw_10.setitem(dw_10.getrow(),'ddia_g_financiero',str.g_financiero)
			dw_10.setitem(dw_10.getrow(),'ddia_empresa',str.empresa)
			dw_10.setitem(dw_10.getrow(),'ddia_aplicacion_mg','CP')
			dw_10.setitem(dw_10.getrow(),'ddia_id', str.usuario)
			dw_10.setitem(dw_10.getrow(),'ddia_tipo_transaccion', ls_tran)
			dw_10.setitem(dw_10.getrow(),'ddia_sub_trans', ls_subtran)
			dw_10.setitem(dw_10.getrow(),'naturaleza','D')	
			dw_10.setitem(dw_10.getrow(),'ddia_linea',dw_10.getrow())
			dw_10.setitem(dw_10.getrow(),'tipo','I')
			dw_10.setitem(dw_10.getrow(),'ddia_ann',ii_ann)
			dw_10.setitem(dw_10.getrow(),'ddia_no_documento',ls_documento)
			dw_10.setitem(dw_10.getrow(),'ddia_no_referencia',ls_referencia)
			dw_10.setitem(dw_10.getrow(),'monto_debito',ld_monto)
			dw_10.setitem(dw_10.getrow(),'ddia_mg_cuenta', ls_cuenta_compras)
			dw_10.setitem(dw_10.getrow(),'ddia_monto',ld_monto)
			dw_10.setitem(dw_10.getrow(),'ddia_tercero',ll_tercero)				
			dw_10.setitem(dw_10.getrow(),'ddia_banco_cuenta','1')						
			//Cuentas de los cargos
			if dw_15.retrieve(str.g_financiero, str.empresa, il_secuencia , ii_ann) > 0 then			 
				for j = 1 to dw_15.rowcount()
					ls_cuenta = dw_15.getitemstring(j,'cuenta')
					ld_monto = dw_15.getitemnumber(j,'valor')

					dw_10.scrolltorow(dw_10.insertrow(0))
					dw_10.setitem(dw_10.getrow(),'ddia_fecha', date(gf_fecha_serv()))
					dw_10.setitem(dw_10.getrow(),'ddia_g_financiero',str.g_financiero)
					dw_10.setitem(dw_10.getrow(),'ddia_empresa',str.empresa)
					dw_10.setitem(dw_10.getrow(),'ddia_aplicacion_mg','CP')
					dw_10.setitem(dw_10.getrow(),'ddia_id', str.usuario)
					dw_10.setitem(dw_10.getrow(),'ddia_tipo_transaccion', ls_tran)
					dw_10.setitem(dw_10.getrow(),'ddia_sub_trans', ls_subtran)
					dw_10.setitem(dw_10.getrow(),'naturaleza','D')	
					dw_10.setitem(dw_10.getrow(),'ddia_linea',dw_10.getrow())
					dw_10.setitem(dw_10.getrow(),'tipo','I')
					dw_10.setitem(dw_10.getrow(),'ddia_ann',ii_ann)
					dw_10.setitem(dw_10.getrow(),'ddia_no_documento',ls_documento)
					dw_10.setitem(dw_10.getrow(),'ddia_no_referencia',ls_referencia)
					dw_10.setitem(dw_10.getrow(),'monto_debito',ld_monto)
					dw_10.setitem(dw_10.getrow(),'ddia_mg_cuenta', ls_cuenta)
					dw_10.setitem(dw_10.getrow(),'ddia_monto',ld_monto)
					dw_10.setitem(dw_10.getrow(),'ddia_tercero',ll_tercero)
					dw_10.setitem(dw_10.getrow(),'ddia_banco_cuenta','1')			
					
				next
			end if
			//Cuenta de Descuento
			if ld_descuento > 0 then
				
				  SELECT inaparam.para_cuenta_descuento  
					 INTO :ls_cuenta_descuento  
					 FROM inaparam  
					WHERE ( inaparam.para_g_financiero = :str.g_financiero ) AND  
							( inaparam.para_empresa = :str.empresa )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Buscar Cuenta de Descuento '+sqlca.sqlerrtext,1,1,'E')
						Rollback;
						sqlca.autocommit = true
						return
					end if
				
				dw_10.scrolltorow(dw_10.insertrow(0))
				dw_10.setitem(dw_10.getrow(),'ddia_fecha', date(gf_fecha_serv()))
				dw_10.setitem(dw_10.getrow(),'ddia_g_financiero',str.g_financiero)
				dw_10.setitem(dw_10.getrow(),'ddia_empresa',str.empresa)
				dw_10.setitem(dw_10.getrow(),'ddia_aplicacion_mg','CP')
				dw_10.setitem(dw_10.getrow(),'ddia_id', str.usuario)
				dw_10.setitem(dw_10.getrow(),'ddia_tipo_transaccion', ls_tran)
				dw_10.setitem(dw_10.getrow(),'ddia_sub_trans', ls_subtran)
				dw_10.setitem(dw_10.getrow(),'naturaleza','C')	
				dw_10.setitem(dw_10.getrow(),'ddia_linea',dw_10.getrow())
				dw_10.setitem(dw_10.getrow(),'tipo','I')
				dw_10.setitem(dw_10.getrow(),'ddia_ann',ii_ann)
				dw_10.setitem(dw_10.getrow(),'ddia_no_documento',ls_documento)
				dw_10.setitem(dw_10.getrow(),'ddia_no_referencia',ls_referencia)
				dw_10.setitem(dw_10.getrow(),'monto_credito',ld_descuento)
				dw_10.setitem(dw_10.getrow(),'ddia_mg_cuenta', ls_cuenta_descuento)
				dw_10.setitem(dw_10.getrow(),'ddia_monto',ld_descuento)
				dw_10.setitem(dw_10.getrow(),'ddia_tercero',ll_tercero)				
				dw_10.setitem(dw_10.getrow(),'ddia_banco_cuenta','1')									
			end if
			
			//Inserta la transaccion de Entrada de Inventarios			
			  INSERT INTO cotdiari  
				( diar_g_financiero,   
				  diar_empresa,   
				  diar_aplicacion_mg,   
				  diar_tipo_transaccion,   
				  diar_sub_trans,   
				  diar_no_documento,   
				  diar_no_referencia,   
				  diar_banco_cuenta,   
				  diar_ann,   
				  diar_fecha_transaccion,   
				  diar_descripcion,   
				  diar_id,   
				  diar_fecha_creacion,   
				  diar_estado,   
				  diar_monto,   
				  diar_balance,   
				  diar_modificado,   
				  diar_cerrado,   
				  diar_cierre_mensual,   
				  diar_banco,   
				  diar_documento_a,   
				  diar_nombre,   
				  diar_impreso,
				  diar_comentario)  
	  VALUES ( :str.g_financiero,   
				  :str.empresa,   
				  'IN',   
				  :ls_tran_inven,   
				  :ls_subtran_inven,   
				  :ls_documento,   
				  :ls_referencia,   
				  '1',   
				  :ii_ann,   
				  :ldt_fecha,   
				  'ENTRADA INVENTARIO',   
				  :str.usuario,   
				  getdate(),   
				  'I',   
				  :ld_monto_inventario,   
				  1,   
				  0,   
				  'N',   
				  'N',   
				  null,   
				  :ls_entrada,   
				  :ls_nombre,   
				  'S',
				  :ls_comentario)  ;
	 		If Sqlca.sqlcode = -1 Then
				 gf_mensaje("","¡Error al Insertar Encabezado Contable Entrada " +sqlca.sqlerrtext,1,1,'E')
				 Rollback;
				sqlca.autocommit = true
				return
			 End If 
		
	
			//Inserta el Detalle Contable
			//Cuenta del Inventario
			dw_10.scrolltorow(dw_10.insertrow(0))
			dw_10.setitem(dw_10.getrow(),'ddia_fecha', date(gf_fecha_serv()))
			dw_10.setitem(dw_10.getrow(),'ddia_g_financiero',str.g_financiero)
			dw_10.setitem(dw_10.getrow(),'ddia_empresa',str.empresa)
			dw_10.setitem(dw_10.getrow(),'ddia_aplicacion_mg','IN')
			dw_10.setitem(dw_10.getrow(),'ddia_id', str.usuario)
			dw_10.setitem(dw_10.getrow(),'ddia_tipo_transaccion', ls_tran_inven)
			dw_10.setitem(dw_10.getrow(),'ddia_sub_trans', ls_subtran_inven)
			dw_10.setitem(dw_10.getrow(),'naturaleza','D')	
			dw_10.setitem(dw_10.getrow(),'ddia_linea',1)
			dw_10.setitem(dw_10.getrow(),'tipo','I')
			dw_10.setitem(dw_10.getrow(),'ddia_ann',ii_ann)
			dw_10.setitem(dw_10.getrow(),'ddia_no_documento',ls_documento)
			dw_10.setitem(dw_10.getrow(),'ddia_no_referencia',ls_referencia)
			dw_10.setitem(dw_10.getrow(),'monto_debito',ld_monto_inventario)
			dw_10.setitem(dw_10.getrow(),'ddia_mg_cuenta', is_cuenta_inventarios)
			dw_10.setitem(dw_10.getrow(),'ddia_monto',ld_monto_inventario)
			dw_10.setitem(dw_10.getrow(),'ddia_tercero',ll_tercero)
			dw_10.setitem(dw_10.getrow(),'ddia_banco_cuenta','1')			
			//Cuenta de Costos de la Mercancia Vendida
			dw_10.scrolltorow(dw_10.insertrow(0))
			dw_10.setitem(dw_10.getrow(),'ddia_fecha', date(gf_fecha_serv()))
			dw_10.setitem(dw_10.getrow(),'ddia_g_financiero',str.g_financiero)
			dw_10.setitem(dw_10.getrow(),'ddia_empresa',str.empresa)
			dw_10.setitem(dw_10.getrow(),'ddia_aplicacion_mg','IN')
			dw_10.setitem(dw_10.getrow(),'ddia_id', str.usuario)
			dw_10.setitem(dw_10.getrow(),'ddia_tipo_transaccion', ls_tran_inven)
			dw_10.setitem(dw_10.getrow(),'ddia_sub_trans', ls_subtran_inven)
			dw_10.setitem(dw_10.getrow(),'naturaleza','C')	
			dw_10.setitem(dw_10.getrow(),'ddia_linea',2)
			dw_10.setitem(dw_10.getrow(),'tipo','I')
			dw_10.setitem(dw_10.getrow(),'ddia_ann',ii_ann)
			dw_10.setitem(dw_10.getrow(),'ddia_no_documento',ls_documento)
			dw_10.setitem(dw_10.getrow(),'ddia_no_referencia',ls_referencia)
			dw_10.setitem(dw_10.getrow(),'monto_credito',ld_monto_inventario)
			dw_10.setitem(dw_10.getrow(),'ddia_mg_cuenta', is_cuenta_costo_venta)
			dw_10.setitem(dw_10.getrow(),'ddia_monto',ld_monto_inventario)
			dw_10.setitem(dw_10.getrow(),'ddia_tercero',ll_tercero)				
			dw_10.setitem(dw_10.getrow(),'ddia_banco_cuenta','1')						
			
			
			//valida q este en balance
			if dw_10.getitemnumber(1,'balance') <> 0 then
				gf_mensaje('','Debe Balancear la Transaccion para Guardar, Verifique !!!',1,1,'E')
				rollback;
				return
			end if
			
			if dw_10.update() = -1 then
				gf_mensaje('','Error al Actualizar Detalle del Asiento Contable '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				return		
			end if
			
	end if
	/**/
	commit;
	dw_1.setitem(1,'tmov_estado',1)
	parent.triggerevent('ue_aceptar')
	
	if dw_9.retrieve(str.g_financiero, str.empresa, il_secuencia , ii_ann) > 0 then	
		dw_9.visible = true
		dw_9.setfocus()
	end if





//string ls_fecha, ls_PathName, ls_PathName2, ls_PathName3, ls_raiz, ls_archivo2, ls_archivo
//Long ll_return
//Integer li_FileNum, li_formato_decimal_costo
//datetime ldt_fecha_inicial

//ldt_fecha_inicial = datetime(relativedate(date(idt_fecha), - 365),time('00:00:00'))

//li_formato_decimal_costo = 2
//	w_resumen_ventas_frame.setmicrohelp('Actualiza Costos Factura')
//	 update  faddiari set facd_costo_cif =   
//					convert(numeric(12,:li_formato_decimal_costo),ROUND((IsNull ( inmprodu.prod_costo_cif,0) / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad,:li_formato_decimal_costo)) ,   
//					facd_costo_fob =   
//					convert(numeric(12,:li_formato_decimal_costo),ROUND((IsNull (inmprodu.prod_costo_fob,0) / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad,:li_formato_decimal_costo)) ,   			
//					faddiari.facd_costo_total = 
//					convert(numeric(12,:li_formato_decimal_costo),convert(numeric(12,:li_formato_decimal_costo),ROUND((IsNull(inmprodu.prod_costo_cif,0) / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad,:li_formato_decimal_costo)) * (isNull(faddiari.facd_cantidad ,0)+ ( IsNull(faddiari.facd_cantidad_fraccion,0) /   inamedid_a.medi_cantidad )) )  
//			 FROM faddiari,   
//					fatdiari,   
//					inamedid inamedid_a,   
//					inamedid inamedid_b,   
//					inmprodu  
//			WHERE ( faddiari.facd_g_financiero = fatdiari.fact_g_financiero ) and  
//					( faddiari.facd_empresa = fatdiari.fact_empresa ) and  
//					( faddiari.facd_tipo = fatdiari.fact_tipo ) and  
//					( faddiari.facd_no_pedido = fatdiari.fact_no_pedido ) and  
//					( faddiari.facd_ann = fatdiari.fact_ann ) and  
//					( faddiari.facd_unidad_venta = inamedid_a.medi_medida ) and  
//					( inamedid_b.medi_medida = inmprodu.prod_medida ) and  
//					( faddiari.facd_codigo_item = inmprodu.prod_producto ) and  
//					( faddiari.facd_g_financiero = inmprodu.prod_g_financiero ) and  
//					( faddiari.facd_empresa = inmprodu.prod_empresa ) and  
//					( ( faddiari.facd_g_financiero = 1 ) AND  
//					( faddiari.facd_empresa = :ii_empresa ) AND  
//					( fatdiari.fact_fecha >= :ldt_fecha_inicial and  faddiari.facd_costo_cif = 0 ) ) ;								
//					If sqlca.sqlcode = -1 then
//						Rollback;
//					end if
//	w_resumen_ventas_frame.setmicrohelp('Actualiza Costos Pedido')
//w_resumen_ventas_frame.setmicrohelp('Actualiza Costos Proforma')	
//		 update  fadprofo set dpro_costo_cif =   
//					convert(numeric(12,:li_formato_decimal_costo),ROUND((IsNull ( inmprodu.prod_costo_cif,0) / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad,:li_formato_decimal_costo)) ,   
//					dpro_costo_fob =   
//					convert(numeric(12,:li_formato_decimal_costo),ROUND((IsNull (inmprodu.prod_costo_fob,0) / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad,:li_formato_decimal_costo)) ,   			
//					fadprofo.dpro_costo_total = 
//					convert(numeric(12,:li_formato_decimal_costo),convert(numeric(12,:li_formato_decimal_costo),ROUND((IsNull(inmprodu.prod_costo_cif,0) / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad,:li_formato_decimal_costo)) * (isNull(fadprofo.dpro_cantidad ,0)+ ( IsNull(fadprofo.dpro_fraccion,0) /   inamedid_a.medi_cantidad )) )  
//			 FROM fadprofo,   
//					fatprofo,   
//					inamedid inamedid_a,   
//					inamedid inamedid_b,   
//					inmprodu  
//			WHERE ( fadprofo.dpro_g_financiero = fatprofo.prof_g_financiero ) and  
//					( fadprofo.dpro_empresa = fatprofo.prof_empresa ) and  
//					( fadprofo.dpro_no_proforma = fatprofo.prof_no_proforma ) and  
//					( fadprofo.dpro_ann = fatprofo.prof_ann ) and  
//					( fadprofo.dpro_unidad_venta = inamedid_a.medi_medida ) and  
//					( inamedid_b.medi_medida = inmprodu.prod_medida ) and  
//					( fadprofo.dpro_codigo_item = inmprodu.prod_producto ) and  
//					( fadprofo.dpro_g_financiero = inmprodu.prod_g_financiero ) and  
//					( fadprofo.dpro_empresa = inmprodu.prod_empresa ) and  
//					( ( fadprofo.dpro_g_financiero = 1 ) AND  
//					( fadprofo.dpro_empresa = :ii_empresa ) AND  
//					( fatprofo.prof_fecha >= :ldt_fecha_inicial and  isnull(fadprofo.dpro_costo_cif,0) = 0 ) ) ;													
//					If sqlca.sqlcode = -1 then
//						Rollback;
//					end if

//	w_resumen_ventas_frame.setmicrohelp('Actualiza Costos Factura Encabezado')
	
//		update  fatdiari  set fact_costos_total = 
//		( SELECT sum(faddiari.facd_costo_total)   
//			 FROM faddiari
//			WHERE ( faddiari.facd_g_financiero = fatdiari.fact_g_financiero ) and  
//					( faddiari.facd_empresa = fatdiari.fact_empresa ) and  
//					( faddiari.facd_tipo = fatdiari.fact_tipo ) and  
//					( faddiari.facd_no_pedido = fatdiari.fact_no_pedido ) and  
//					( faddiari.facd_ann = fatdiari.fact_ann ) 
//			GROUP BY faddiari.facd_g_financiero,   
//						faddiari.facd_empresa,   
//						faddiari.facd_tipo,   
//						faddiari.facd_no_pedido,   
//						faddiari.facd_ann)
//			WHERE  (fatdiari.fact_g_financiero = 1 ) AND  
//					 (fatdiari.fact_empresa = :ii_empresa ) AND  
//					( fatdiari.fact_fecha >= :idt_fecha and fatdiari.fact_fecha <= :idt_fecha ) ;
//					If sqlca.sqlcode = -1 then
//						Rollback;
//					end if
//		w_resumen_ventas_frame.setmicrohelp('Actualiza Costos Pedido Encabezado')

//	w_resumen_ventas_frame.setmicrohelp('Actualiza Costos Proforma Encabezado')
	
//		update  fatprofo  set prof_costos_total = 
//		( SELECT sum(fadprofo.dpro_costo_total)   
//			 FROM fadprofo
//			WHERE ( fadprofo.dpro_g_financiero = fatprofo.prof_g_financiero ) and  
//					( fadprofo.dpro_empresa = fatprofo.prof_empresa ) and  
//					( fadprofo.dpro_no_proforma = fatprofo.prof_no_proforma ) and  
//					( fadprofo.dpro_ann = fatprofo.prof_ann ) 
//		GROUP BY fadprofo.dpro_g_financiero,   
//					fadprofo.dpro_empresa,   
//					fadprofo.dpro_no_proforma,   
//					fadprofo.dpro_ann )
//			WHERE  (fatprofo.prof_g_financiero = 1 ) AND  
//					 (fatprofo.prof_empresa = :ii_empresa ) AND  
//					( fatprofo.prof_fecha between :idt_fecha and :idt_fecha ) ;
//					If sqlca.sqlcode = -1 then
//						Rollback;
//					end if
//w_resumen_ventas_frame.setmicrohelp('Recupera informacion')	
//dw_4.retrieve( 1,ii_empresa, idt_fecha, idt_fecha )
//dw_4.groupcalc( )
//sleep(2)
		


end event

type dw_6 from datawindow within w_entrada_arriba
event ue_helpcol ( )
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 773
integer y = 124
integer width = 2565
integer height = 1744
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Productos"
boolean controlmenu = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_helpcol();//Busqueda del producto
//
String  ls_find,ls_codigo
integer li_c, li_b
long    ll_lter
string  ls_lter,ls_des

Datawindow        dww
str_dg_dynamic_find	lstr_df

	lstr_df.texto_campo [1,1] = "inmprodu.prod_producto"
	lstr_df.texto_campo [1,2] = "Referencia"
	lstr_df.texto_campo [1,3] = "prod_producto"
	lstr_df.texto_campo [1,4] = 'V'
//	lstr_df.texto_campo [1,5] = '280'	
	lstr_df.texto_campo [2,1] = "inmprodu.prod_descripcion"
	lstr_df.texto_campo [2,2] = "Descripcion"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '770'
//	lstr_df.texto_campo [3,1] = "orden.enca_fecha"
//	lstr_df.texto_campo [3,2] = "Fecha"
//	lstr_df.texto_campo [3,3] = ""
//	lstr_df.texto_campo [3,4] = 'V'
//	lstr_df.texto_campo [3,5] = '285'
	lstr_df.tabla = " inmprodu "
		
	lstr_df.tabla_where = &
				"WHERE (inmprodu.prod_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(inmprodu.prod_empresa = " + string(str.empresa) + ") "	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm



If len (ls_find) = 0 Then Return
	
ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)
this.setitem(this.getrow(),'prod_producto',ls_codigo)
this.accepttext()
this.trigger event itemchanged(this.getrow(), object, ls_codigo)
end event

event ue_keydown;//override
CHOOSE CASE key
		
	CASE KeyF1! 

			if this.dataobject = 'dw_producto' then
				This.Postevent("ue_helpcol")
			end if
end choose
end event

event itemchanged;String ls_codigo, ls_nulo
long 	 ll_fila, ll_tercero, ll_pais
integer li_existe

this.accepttext()
Setnull(ls_nulo)

choose case this.getcolumnname() 
	case  "prod_producto"
		str.frame.setredraw(false)
		data = this.getitemstring(this.getrow(), 'prod_producto')
		if this.retrieve(str.g_financiero, str.empresa, data) = 0 then
			this.insertrow(1)
			this.setitem(1,'prod_g_financiero',str.g_financiero)
			this.setitem(1,'prod_empresa',str.empresa)
			this.setitem(1,'prod_producto',data)
			this.setcolumn('prod_producto')
		end if
		str.frame.setredraw(true)		
end choose
end event

event buttonclicked;integer i, li_conteo
datawindowchild ldwc_proveedor
string ls_division, ls_producto
long ll_pais, ll_tercero, ll_row
THIS.ACCEPTTEXT()

choose case dwo.name 						
	case 'b_kardex'
		Window lw_child_v				
		str_kardex  str_opcion
		
		str_opcion.opcion_menu = 'MCP'
		str_opcion.opcion_ventana    = 'P'
		str_opcion.dwpantalla     = 'dw_in_mcp_prod_kard_1'
		str_opcion.dwreporte      = 'dw_in_mcp_prod_kard_2'
		str_opcion.titulo_ventana = 'Movimiento del Producto (Kardex)'
		
		if this.rowcount() > 0 then
			ls_producto = this.getitemstring(this.getrow(),'prod_producto')				
		end if
		
		str_opcion.kproducto=ls_producto
	
		OpenSheetWithParm(lw_child_v,str_opcion,"w_in_movi_prod_kardex",str.frame,2,Original!)		
		
	case 'b_adicionar_producto'
		this.reset()
		this.scrolltorow(this.insertrow(0))
		this.setitem(this.getrow(),'prod_g_financiero', str.g_financiero)
		this.setitem(this.getrow(),'prod_empresa', str.empresa)
	case 'b_grabar_producto'
		if this.getitemstring(1,'prod_producto') = '' or isnull(this.getitemstring(1,'prod_producto')) then 
			gf_mensaje('','Debe asignar el codigo del producto para grabar, verifique !!!',1,1,'E')
			return 2
		end if
		if this.getitemstring(1,'prod_descripcion') = '' or isnull(this.getitemstring(1,'prod_descripcion')) then 
			gf_mensaje('','Debe asignar la descripcion del producto para grabar, verifique !!!',1,1,'E')
			return 2
		end if		
		if this.update() = -1 then
			gf_mensaje('','Error al actualizar los productos '+sqlca.sqlerrtext,1,1,'E')
		else
			commit;
		end if		
	case 'b_cerrar_producto'
		if this.getitemstring(1,'prod_producto') = '' or isnull(this.getitemstring(1,'prod_producto')) then 
			this.visible = false
			dw_2.setfocus()
			return
		end if			
		if this.update() = -1 then
			gf_mensaje('','Error al actualizar los productos '+sqlca.sqlerrtext,1,1,'E')
		end if		
		this.visible = false
	case 'b_eliminar_producto'
		ls_producto = this.getitemstring(1,'prod_producto')
		if ls_producto = '' or isnull(ls_producto) then return 		
		
		select count(*)
		into :li_conteo
		from indmovim
		where dmov_g_financiero = :str.g_financiero and
				dmov_empresa		= :str.empresa and
				dmov_producto		= :ls_producto ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al verificar existencia '+sqlca.sqlerrtext,1,1,'E')
				end if
		
		if li_conteo > 0 then
			gf_mensaje('','No se puede eliminar un producto que tiene movimientos, verifique el kardex !!!',1,1,'E')
			return
		end if
		
		if gf_mensaje('','Esta seguro de eliminar el producto ?',2,1,'E') = 2 then return
				
		this.deleterow(this.getrow())
		
		if this.update() = -1 then
			gf_mensaje('','Error al eliminar los productos '+sqlca.sqlerrtext,1,1,'E')
		end if		
		this.reset()
		this.scrolltorow(this.insertrow(0))
		this.setitem(this.getrow(),'prod_g_financiero', str.g_financiero)
		this.setitem(this.getrow(),'prod_empresa', str.empresa)				
	case else
		
		//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
		//en la misma columna.
		
		string ls_objeto
		integer li_pos 
		
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
	
		
end choose

end event

type pb_1 from picturebutton within w_entrada_arriba
integer x = 4105
integer y = 160
integer width = 343
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
string pointer = "HyperLink!"
string text = "KARDEX"
boolean originalsize = true
end type

event clicked;		Window lw_child_v				
		string ls_producto
		str_kardex  str_opcion
		
			str_opcion.opcion_menu = 'MCP'
			str_opcion.opcion_ventana    = 'P'
			str_opcion.dwpantalla     = 'dw_in_mcp_prod_kard_1'
			if str.contabiliza = 0 then
				str_opcion.dwreporte      = 'dw_in_mcp_prod_kard_2'
			else
				str_opcion.dwreporte      = 'dw_in_mcp_prod_kard_2_arriba'
			end if
			str_opcion.titulo_ventana = 'Movimientos de Productos (Kardex)'
			
			if dw_2.rowcount() > 0 then
				ls_producto = dw_2.getitemstring(dw_2.getrow(),'dmov_producto')				
			end if
			
			str_opcion.kproducto=ls_producto
	
			window lw_win, lw_first
			lw_first = str.frame.GetFirstSheet()	
			lw_win = str.frame.GetNextSheet(lw_first)
				do while isvalid(lw_win)
					if lw_win.classname()  = "w_in_movi_prod_kardex" then
						//gf_mensaje('','Esta abierta  Dirigirse a DMC',1,1,'E')
						lw_win.BringToTop = TRUE
						w_in_movi_prod_kardex.wf_asignar(str_opcion.kproducto)
						return
					end if
					lw_win = str.frame.GetNextSheet(lw_win)					
				loop	
		
			OpenSheetWithParm(w_in_movi_prod_kardex,str_opcion,str.frame,2,Original!)		
				
end event

type uo_1 from u_ddcalen within w_entrada_arriba
boolean visible = false
integer x = 1426
integer y = 116
integer taborder = 40
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;dw_1.SetItem ( dw_1.getrow(), 'tmov_fecha', uo_1.return_sel_date() )
datetime ldt_fecha_tran, ldt_fecha_anterior
integer li_ann_anterior
if uo_1.allow_close then
	this.visible=false
	dw_1.SetFocus()

		ldt_fecha_tran 	 = dw_1.getitemdatetime(dw_1.getrow(),'tmov_fecha')		
		ldt_fecha_anterior = dw_1.getitemdatetime(dw_1.getrow(),'tmov_fecha', Primary!, True)		
		ii_ann = year(date(dw_1.getitemdatetime(dw_1.getrow(),'tmov_fecha')))
		li_ann_anterior = dw_1.getitemnumber(1,'tmov_anual')
		
		if not gf_valida_fecha_conta(ldt_fecha_anterior) then			
			dw_1.setitem(1,'tmov_fecha', ldt_fecha_anterior)
			dw_1.setcolumn('tmov_fecha')
			return
		end if

		if not gf_valida_fecha_conta(ldt_fecha_tran) then			
			dw_1.setitem(1,'tmov_fecha', ldt_fecha_anterior)
			dw_1.setcolumn('tmov_fecha')
			return
		end if

		if not gf_valida_fecha_futura(ldt_fecha_tran) then			
			if ldt_fecha_tran = ldt_fecha_anterior then
				dw_1.setitem(1,'tmov_fecha', date(gf_fecha_serv()))				
			else
				dw_1.setitem(1,'tmov_fecha', ldt_fecha_anterior)
			end if
			dw_1.setcolumn('tmov_fecha')
		end if
		
		//Si los anios son diferentes asigna el anio
		if ii_ann <> li_ann_anterior then
			dw_1.setitem(1,'tmov_anual',ii_ann)
		end if

end if


end event

on uo_1.destroy
call u_ddcalen::destroy
end on

type pb_2 from picturebutton within w_entrada_arriba
integer x = 3543
integer y = 36
integer width = 110
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Print!"
alignment htextalign = left!
string powertiptext = "Imprimir Etiquetas"
end type

event clicked;string ls_descripcion, ls_item, ls_barra
Decimal ld_precio
integer li_cantidad, i
long ll_archivo
if gf_mensaje("","Se procedera a imprimir la etiqueta de los productos, esta seguro ?",2,1,"E") = 1 then

	filedelete("C:\Sistemas\codigo_barra.txt")
	dw_2.accepttext()
	SetPointer(HourGlass!)
	for i = 1 to dw_2.rowcount()
		if dw_2.getitemnumber(i,'imprimir') = 0 or isnull(dw_2.getitemnumber(i,'imprimir')) then continue
		ls_item = dw_2.getitemstring(i,'dmov_producto')
		if isnull(ls_item) or ls_item = '' then continue
		li_cantidad = dw_2.getitemnumber(i,'cantidad_etiqueta')
		if li_cantidad = 0 then continue
		
		  SELECT inmprodu.prod_descripcion,   
					inmprodu.prod_precio1,
					inmprodu.prod_cod_alternativo
			 INTO :ls_descripcion,   
					:ld_precio,
					:ls_barra
			 FROM inmprodu  
			WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
					( inmprodu.prod_empresa = :str.empresa ) AND  
					( inmprodu.prod_producto = :ls_item )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al buscar producto '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
		if ii_usuario_bodega = 1 then
			gf_imprime_barras_union_bodega(ls_item, ls_descripcion, li_cantidad, ld_precio, ls_barra, ii_usuario_bodega)
		else
			gf_imprime_barras_union(ls_item, ls_descripcion, li_cantidad, ld_precio, ls_barra, ii_usuario_bodega)
		end if
		
		ll_archivo = FileOpen ("c:\Sistemas\codigo_barra.txt" , LineMode!  , Write!  , LockWrite!  , Append!  )
		filewrite(ll_archivo,'^XZ')						
		fileclose(ll_archivo)			
		
	Next
		
Integer        li_return_code
 string     ls_null
 long       ll_null

SetNull(ls_null)
SetNull(ll_null)

li_return_code = ShellExecute(ll_null, "print", "C:\Sistemas\codigo_barra.txt", ls_null, ls_null, 0)

SetPointer(Arrow!)

PrintSetPrinter (str.printer1)

end if


end event

type st_1 from statictext within w_entrada_arriba
integer x = 3474
integer y = 128
integer width = 265
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Etiquetas"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_7 from datawindow within w_entrada_arriba
boolean visible = false
integer x = 1737
integer y = 28
integer width = 1760
integer height = 1980
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "Listado de Etiquetas"
string dataobject = "dw_impresion_etiquetas_entrada"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "AppIcon!"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event retrieveend;integer i, li_total
decimal{2} ld_costo, ld_precio
string ls_costo, ls_precio

li_total = rowcount
for i = 1 to li_total
	ld_costo = this.getitemnumber(i,'inmprodu_prod_costo_cif')
	ls_costo = gf_clave_costos(ld_costo)		
	this.setitem(i,'costo',ls_costo)
	ld_precio = this.getitemnumber(i,'inmprodu_prod_precio1')
	ls_precio = gf_clave_costos(ld_precio)		
	this.setitem(i,'precio',ls_precio)	
next
end event

type pb_pase from picturebutton within w_entrada_arriba
integer x = 1390
integer y = 16
integer width = 137
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean flatstyle = true
string picturename = "Retrieve!"
alignment htextalign = left!
string powertiptext = "Pasar Ordenes Pendientes"
end type

event clicked;str_pase_pedido lstr_pedidos
istr_pedidos = lstr_pedidos
ib_rebajar_pedido = false

if gf_mensaje('','Pasar Orden de Compra ? ',2,1,'E') = 1 then
	ib_transito = false
	openwithparm(w_pasar_ordenes, istr_pedidos) //, w_fa_fondo, 2, Original!)
else
	ib_transito = true
	openwithparm(w_pasar_transitos, istr_pedidos) //, w_fa_fondo, 2, Original!)
end if
//istr_pedidos = message.powerobjectparm

if not isvalid(istr_pedidos) then return

wf_asigna_pedido(istr_pedidos)
	
end event

type cb_3 from commandbutton within w_entrada_arriba
integer x = 46
integer y = 296
integer width = 224
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Fotos"
end type

event clicked;string ls_expresion, ls_producto[]
integer i, j = 0
for i = 1 to  dw_2.rowcount()
	if dw_2.getitemnumber(i,'imprimir') = 1 then
		j ++
		ls_producto[j] = dw_2.getitemstring(i,'dmov_producto')
	end if
next
if upperbound(ls_producto) = 0 then return

	dw_8.retrieve(str.g_financiero, str.empresa, il_secuencia , ii_ann, ls_producto)
	//
	if dw_8.rowcount() = 0 then return	
	
	if cbx_existencias.checked then
		dw_8.setitem(1,'ver_existencia',1)
	else
		dw_8.setitem(1,'ver_existencia',0)	
	end if
	
	ls_expresion = str.nombre_empresa
	dw_8.object.empresa_nom.expression = "'"+ls_expresion+"'"
	
	dw_8.object.datawindow.print.preview = 'yes'
	dw_8.object.datawindow.print.preview.zoom = 100
	dw_8.visible = true
	
end event

type dw_8 from datawindow within w_entrada_arriba
boolean visible = false
integer x = 421
integer y = 176
integer width = 3406
integer height = 2048
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "Fotos de Productos"
string dataobject = "dw_reporte_entradas_catalogo"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
string icon = "Application5!"
boolean livescroll = true
end type

event retrieveend;long i, ll_total, ll_encontro, ll_siguiente, ll_disponible
integer li_encontro
string ls_producto, ls_find, ls_factura, ls_modelo


ll_total = rowcount

this.setsort('inmprodu_prod_producto')
this.sort()

for i = 1 to ll_total
	yield()
	//if i = 1 then
		ll_siguiente = i + 1
	//end if
	ls_producto  = this.getitemstring(i,'inmprodu_prod_producto')
	ls_find = "inmprodu_prod_producto = '"+ls_producto+"'"
	
	ll_encontro = 0
	if ll_siguiente <= ll_total then ll_encontro = this.find(ls_find,ll_siguiente, ll_total)
		
	if ll_encontro > 0 then
		this.deleterow(ll_encontro)
		i --
		ll_total --
	end if
next
str.frame.setmicrohelp('Hymsoft')
this.setsort('inmprodu_prod_descripcion')
this.sort()

end event

type cbx_existencias from checkbox within w_entrada_arriba
integer x = 279
integer y = 300
integer width = 210
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Exis."
boolean checked = true
end type

type dw_9 from datawindow within w_entrada_arriba
boolean visible = false
integer x = 677
integer y = 404
integer width = 2039
integer height = 908
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Pedidos Reservados en la Entrada"
string dataobject = "dw_pedidos_activos_por_entrada"
boolean controlmenu = true
boolean minbox = true
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_10 from datawindow within w_entrada_arriba
boolean visible = false
integer x = 297
integer y = 936
integer width = 4027
integer height = 1212
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_detalle_contable"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_pasar_salidas from commandbutton within w_entrada_arriba
boolean visible = false
integer x = 3831
integer y = 216
integer width = 434
integer height = 148
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hebrewcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pasar Salidas"
end type

event clicked;opensheetwithparm(w_pasar_salida_a_entradas, ii_ann,str.frame,2,Original!)
end event

type cb_4 from commandbutton within w_entrada_arriba
boolean visible = false
integer x = 3355
integer y = 1852
integer width = 512
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar Costos"
end type

event clicked;///* Boton para el proceso de actualizar costos de productos al inventario  */
//Integer  li_linea, li_final, li_1, li_tipo_costo,ll_formato_decimal, li_para_act_precio_ent, li_para_decimal_precio
//String   ls_producto, ls_costo_aplica, ls_bodega, ls_ubicacion, ls_error
//Decimal  ld_cargos, ld_costo_fob, ld_dmov_costo, ld_costo_promedio, ld_precio_base, ld_precio_venta
//Decimal  ld_precio1, ld_precio2, ld_precio3, ld_precio4, ld_precio5,ld_cantidad

//Decimal  ld_pprecio1, ld_pprecio2, ld_pprecio3, ld_roun
//datetime dt_fecha
///* Variables para el encabezado */
//String   ls_aplicacion, ls_tipo_t, ls_concepto,ls_costo_proc, ls_clase_costo 
//Integer  li_anual, li_flag,li_actualiza_precio
//long     ll_secuencia
//string   ls_transaccion,ls_formato,ls_documento
	   
//ls_aplicacion = 'IN'
//li_anual      = dw_1.getitemnumber(1,"tmov_anual")
//ls_tipo_t     = 'EN'
//ls_concepto   = dw_1.getitemstring(1,"tmov_concepto")
//ll_secuencia  = dw_1.getitemnumber(1,"tmov_secuencia")
//ls_transaccion = 'EN'
//li_tipo_costo =  dw_1.GetItemnumber(1,"tmov_tipo_costo")

//dt_fecha = dw_1.GetItemDateTime(1,"tmov_fecha")

//ls_documento=dw_1.getItemString(1,"tmov_documento")


//select tmov_estado, tmov_precio_base 
//into :li_1 , :ld_precio_base
//from intmovim 
//WHERE tmov_g_financiero     = :str.g_financiero AND 
// 		tmov_empresa          = :str.empresa AND 
//		tmov_aplicacion       = :ls_aplicacion AND 
//		tmov_tipo_transaccion = :ls_tipo_t AND 
//		tmov_concepto         = :ls_concepto  AND 		
//		tmov_secuencia        = :ll_secuencia AND
//		tmov_anual            = :li_anual ; 	
		
//		if sqlca.sqlcode = -1 then
//			mensaje('Aviso','Error al Seleccionar el estado de los Costos',sqlca.sqlerrtext)
//		end if
		
//If li_1 = 1 Then
//	MessageBox('Aviso','Los Costos de esta Entrada ya han sido actualizados , por favor verifique')
//	Return
//End If
////--------------------------------------------------------------------------------------------

//if gf_mensaje('','Está Seguro de Actualizar los Costos de la Entrada #'+string(ll_secuencia),2,1,'E') = 2 then return

////Recuperamos el parametro del costo aplicado si es por Bodega o Maestro----------------------
//Select para_costo_aplicado, para_sistema_costeo,  para_roun,para_formato_decimal,
//		 isnull(para_act_precio_ent,0), isnull(para_decimal_precio,2)
//Into	 :ls_costo_aplica, :ls_clase_costo , :ld_roun,:ll_formato_decimal,
//		 :li_para_act_precio_ent, :li_para_decimal_precio
//From   inaparam
//Where  para_g_financiero =: str.g_financiero And
//       para_empresa      =:  str.empresa ;
//if sqlca.sqlcode = -1 then
//	mensaje('Aviso','Error al seleccionar el costo Aplicado',sqlca.sqlerrtext)
//	return
//end if

//If IsNull(ls_costo_aplica) Then
//	ls_costo_aplica = 'P'
//End If

//dw=dw_2
////--------------------------------------------------------------------------------------------
//ids_kardex = Create ds_dg_import_file

//ids_kardex.DataObject = 'in_dw_valor_inv_espec_2002_1'

//ids_kardex.SetTransObject(Sqlca)

////** No cambiar esta instruccion por favor ( Alexis - 31/Mayo/2002 )
//id_fecha2 = Date(dw_1.GetItemDateTime(1,"tmov_fecha"))
///*HGN 30/08/02 Para que tome en cuenta los minutos y segundos*/
//id_fechatime = dw_1.GetItemDateTime(1,"tmov_fecha")
////--------------------------------------------------------------------------------------------

//li_final = dw.RowCount()


//If li_final > 0 Then
//	For li_linea = 1 To li_final
//		 ls_producto = dw.getitemstring(li_linea,"dmov_producto")
//		 ls_bodega = dw.GetItemString(li_linea,"dmov_bodega")
//		 ls_ubicacion = dw.GetItemString(li_linea, "dmov_ubicacion")

//		 wf_recuperar_2(ls_producto)	
		 
//		 ld_cargos   = dw.getitemdecimal(li_linea,"dmov_cargos")
		 
//		 ld_costo_fob = dw.getitemdecimal(li_linea,"dmov_costo_fob")		 
//		 ld_dmov_costo = dw.getitemdecimal(li_linea,"dmov_costo")

//		 if ids_kardex.rowcount() > 0 then
//			 ld_costo_promedio = ids_kardex.getitemdecimal(ids_kardex.rowcount(),"cc2")
//		 else 
//			 ld_costo_promedio = ld_dmov_costo
//	 	 end if 
//		 /* */ 
		 
		 
//		 ld_cargos  = Round(ld_cargos,ll_formato_decimal)
//		 ld_costo_fob = Round(ld_costo_fob,ll_formato_decimal)
//		 ld_dmov_costo = Round(ld_dmov_costo,ll_formato_decimal)
//		 ld_costo_promedio = Round(ld_costo_promedio,ll_formato_decimal)

		 
//		 /*Para guardar el precio de rodeo, Cif X el base */

////------Actualizamos el maestro de productos-----------------------------------------------
//		 /* Pendiente los valores que se asignan en 0.0 */
		
//		 If ls_costo_aplica = "P" Then
////          if li_tipo_costo = 0 then			
//				 UPDATE inmprodu
//				 SET prod_otros_gastos     = case when :li_tipo_costo = 0 then (:ld_costo_promedio - :ld_costo_fob) else 0.0 end,
//					  prod_costo_fob        =:ld_costo_fob,
//					  prod_flete            = 0.0 , 
//					  prod_seguros          = 0.0,				  
//					  prod_costo_unitario   =:ld_dmov_costo,				  				 
//					  prod_costo_cif 		  =:ld_costo_promedio
//				  WHERE prod_g_financiero = :str.g_financiero and
//						  prod_empresa = :str.empresa and 
//						  prod_producto = :ls_producto ;		
//					  If Sqlca.sqlcode = -1 Then
//						  ls_error = sqlca.sqlerrtext
//						  mensaje("-----Atención-----1","¡Error al Actualizar Maestro de Productos!", & 
//										ls_error)
//						  Rollback Using Sqlca;
//						  li_flag = 1
//						  Goto Error
//					End if


		
//			end if
					
			
//	Next	  
 		 
////-----Actualizamos el Estatus de la Actualizacion de los Costos de la Entrada		  
//		  UPDATE intmovim 		  
//			SET tmov_estado_costo = 1,
//				 tmov_estado = 1
//			WHERE tmov_g_financiero     = :str.g_financiero AND 
//       			tmov_empresa          = :str.empresa      AND 
//					tmov_aplicacion       = :ls_aplicacion    AND 
//					tmov_tipo_transaccion = :ls_tipo_t        AND 
//					tmov_concepto         = :ls_concepto      AND 					
//					tmov_secuencia        = :ll_secuencia     AND
//					tmov_anual            = :li_anual ; 
					
// 		 If sqlca.sqlcode = -1 Then
//		    ls_error = sqlca.sqlerrtext			
//			 mensaje("-----Atención-----","¡Error al Actualizar el Estatus de la Entrada !", & 
//								ls_error)
//			 Rollback ;
//		    li_flag = 1
//			 Goto Error
//		  Else
//			  Commit Using Sqlca;
//			  li_flag = 0
//		 End If 
////Para actualizar los costos de las facturas
// dt_fecha = DateTime(date(dt_fecha),00:00:00)
//String	ls_fec_ini,ls_fec_fin
//integer  li_formato_decimal_costo
//  SELECT inaparam.para_formato_decimal  
//    INTO :li_formato_decimal_costo
//    FROM inaparam  
//   WHERE ( inaparam.para_g_financiero =:str.g_financiero  ) AND  
//         ( inaparam.para_empresa =:str.empresa  )   ;

////Formato de costos

//update  faddiari set facd_costo_cif =   
//					convert(numeric(12,:li_formato_decimal_costo),ROUND((IsNull ( inmprodu.prod_costo_promedio,0) / inamedid_a.medi_cantidad ) * inamedid_b.medi_cantidad,:li_formato_decimal_costo)),   
//					faddiari.facd_costo_fob =   
//					convert(numeric(12,:li_formato_decimal_costo),ROUND((IsNull (inmprodu.prod_costo_fob,0) / inamedid_a.medi_cantidad ) * inamedid_b.medi_cantidad,:li_formato_decimal_costo)),   
//					faddiari.facd_costo_total =   
//					convert(numeric(12,:li_formato_decimal_costo),convert(numeric(12,:li_formato_decimal_costo),ROUND((IsNull(inmprodu.prod_costo_promedio,0) / inamedid_a.medi_cantidad ) * inamedid_b.medi_cantidad,:li_formato_decimal_costo)) * (isNull(faddiari.facd_cantidad ,0)+ ( IsNull(faddiari.facd_cantidad_fraccion,0) / inamedid_b.medi_cantidad )) ) 
//			 FROM faddiari,   
//					fatdiari,   
//					inmprodu,   indmovim ,
//					inamedid inamedid_a,   
//					inamedid inamedid_b  
//			WHERE ( fatdiari.fact_g_financiero = faddiari.facd_g_financiero ) and  
//					( fatdiari.fact_empresa = faddiari.facd_empresa ) and  
//					( fatdiari.fact_tipo = faddiari.facd_tipo ) and  
//					( fatdiari.fact_no_pedido = faddiari.facd_no_pedido ) and  
//					( fatdiari.fact_ann = faddiari.facd_ann ) and  
//					( inmprodu.prod_g_financiero = faddiari.facd_g_financiero ) and  
//					( inmprodu.prod_empresa = faddiari.facd_empresa ) and  
//					( inmprodu.prod_producto = faddiari.facd_codigo_item ) and  
//					( inamedid_a.medi_medida = inmprodu.prod_medida ) and  
//					( inamedid_b.medi_medida = faddiari.facd_unidad_venta ) and  
//					(( inmprodu.prod_g_financiero = indmovim.dmov_g_financiero ) and  
//         ( inmprodu.prod_empresa = indmovim.dmov_empresa ) and  
//         ( inmprodu.prod_producto = indmovim.dmov_producto ) and  
//         ( ( indmovim.dmov_g_financiero = :str.g_financiero ) AND  
//         ( indmovim.dmov_empresa = :str.empresa   ) AND  
//         ( indmovim.dmov_aplicacion =  :ls_aplicacion   ) AND  
//         ( indmovim.dmov_tipo_transaccion = :ls_tipo_t   ) AND  
//         ( indmovim.dmov_concepto = :ls_concepto   ) AND  
//         ( indmovim.dmov_secuencia = :ll_secuencia   ) AND  
//         ( indmovim.dmov_anual = :li_anual  ) )    		
//					) and 
//					( ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
//					( faddiari.facd_empresa = :str.empresa ) AND  
//					( fatdiari.fact_fecha >= :dt_fecha) );

//					If sqlca.sqlcode = -1 then
//						ls_error = sqlca.sqlerrText
//						Rollback;
//						mensaje("Atención","Error al actualizar el costo del detalle de faddiari ",ls_error)
//						return 
//					end if


//	//Actualiza el costo de la factura
	
//		update  fatdiari  set fact_costos_total = 
//		( SELECT sum(faddiari.facd_costo_total)   
//			 FROM faddiari
//			WHERE ( faddiari.facd_g_financiero = fatdiari.fact_g_financiero ) and  
//					( faddiari.facd_empresa = fatdiari.fact_empresa ) and  
//					( faddiari.facd_tipo = fatdiari.fact_tipo ) and  
//					( faddiari.facd_no_pedido = fatdiari.fact_no_pedido ) and  
//					( faddiari.facd_ann = fatdiari.fact_ann ) )
//			WHERE  (fatdiari.fact_g_financiero = :str.g_financiero ) AND  
//					 (fatdiari.fact_empresa = :str.empresa ) AND  
//					( fatdiari.fact_fecha >= :dt_fecha ) ;
		
//					If sqlca.sqlcode = -1 then
//						ls_error = sqlca.sqlerrText
//						Rollback;
//						mensaje("Atención","Error al actualizar el costo total de la factura fatdiari ",ls_error)
//						return 
//					end if
//					/* Costo */ 
//UPDATE   indmovim SET dmov_costo =
//         round( case when inamedid_b.medi_cantidad = inamedid_a.medi_cantidad then prod_costo_cif 
//		else ( case when inamedid_b.medi_cantidad > inamedid_a.medi_cantidad then 
//			prod_costo_cif  * inamedid_b.medi_cantidad / inamedid_a.medi_cantidad else 
//			prod_costo_cif  / inamedid_a.medi_cantidad * inamedid_b.medi_cantidad end ) end ,4)
//    FROM
//         inmprodu, 
//         inamedid inamedid_a,
//         inamedid inamedid_b,
//         intmovim
//WHERE
//         ( inamedid_a.medi_medida = inmprodu.prod_medida ) and
//         ( indmovim.dmov_unidad_medida = inamedid_b.medi_medida ) and
//         ( intmovim.tmov_g_financiero = indmovim.dmov_g_financiero ) and
//         ( intmovim.tmov_empresa = indmovim.dmov_empresa ) and
//         ( intmovim.tmov_aplicacion = indmovim.dmov_aplicacion ) and
//         ( intmovim.tmov_tipo_transaccion = indmovim.dmov_tipo_transaccion ) and
//         ( intmovim.tmov_secuencia = indmovim.dmov_secuencia ) and
//         ( intmovim.tmov_anual = indmovim.dmov_anual ) and
//         ( intmovim.tmov_concepto = indmovim.dmov_concepto ) and
			
//         ( indmovim.dmov_g_financiero = inmprodu.prod_g_financiero ) and  
//         ( indmovim.dmov_empresa = inmprodu.prod_empresa ) and  
//         ( indmovim.dmov_producto = inmprodu.prod_producto )  and

//         ( intmovim.tmov_fecha >=  :dt_fecha ) and 
//	    ( not  intmovim.tmov_tipo_transaccion = 'EN' )     and 
//	    ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
//         ( intmovim.tmov_empresa = :str.empresa   )  
			
//			and 
//		 isnull ((select sum(1) from indmovim indmovim_a where 
//		 ( indmovim_a.dmov_g_financiero = indmovim.dmov_g_financiero ) and  
//         ( indmovim_a.dmov_empresa = indmovim.dmov_empresa ) and  
//         ( indmovim_a.dmov_producto = indmovim.dmov_producto )  
			
//			and 
//         ( ( indmovim_a.dmov_g_financiero = :str.g_financiero ) AND  
//         ( indmovim_a.dmov_empresa = :str.empresa   ) AND  
//         ( indmovim_a.dmov_aplicacion =  :ls_aplicacion   ) AND  
//         ( indmovim_a.dmov_tipo_transaccion = :ls_tipo_t   ) AND  
//         ( indmovim_a.dmov_concepto = :ls_concepto   ) AND  
//         ( indmovim_a.dmov_secuencia = :ll_secuencia   ) AND  
//         ( indmovim_a.dmov_anual = :li_anual  ) )  ) , 0 ) <>  0 

// ; 

//					If sqlca.sqlcode = -1 then
//						ls_error = sqlca.sqlerrText
//						Rollback;
//						mensaje("Atención","Error al actualizar el costo del detalle de faddiari ",ls_error)
//						return 
//					end if

//	commit;
//	sqlca.autocommit = true
	 

//End If

//Goto Fin

//Error:
//   Return


//Fin:
//If li_flag = 0 Then
//	MessageBox('Información','Actualización Exitosa',Information!)
//	dw_1.SetRedraw(False)
//   dw_1.retrieve(str.g_financiero, str.empresa,ls_transaccion,ll_secuencia,ls_aplicacion,li_anual,ls_concepto)
//	dw_1.SetRedraw(True)
//	Return
//End If
   
end event

type dw_11 from datawindow within w_entrada_arriba
boolean visible = false
integer x = 151
integer y = 240
integer width = 4105
integer height = 2040
integer taborder = 60
boolean bringtotop = true
boolean titlebar = true
string title = "Factura"
string dataobject = "dw_imprimir_factura_gear"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
string icon = "Question!"
boolean livescroll = true
end type

type cb_5 from commandbutton within w_entrada_arriba
boolean visible = false
integer x = 3913
integer y = 236
integer width = 416
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Factura Gear"
end type

event clicked;////override
string ls_expresion

if il_secuencia = 0 then return

	THIS.TRIGGEREVENT('ue_aceptar')
	
	dw_11.retrieve(str.g_financiero, str.empresa, il_secuencia , ii_ann)
	//
	if dw_11.rowcount() = 0 then return
	//
	dw_11.visible = true
	ls_expresion = str.nombre_empresa
	dw_11.object.nom_empresa.expression = "'"+ls_expresion+"'"
	
	dw_11.object.datawindow.print.preview = 'yes'
	dw_11.object.datawindow.print.preview.zoom = 100
	dw_11.visible = true
	//
	OpenWithParm(w_dw_print_options, dw_11)
	//
	If Message.DoubleParm = -1 Then Return
	dw_11.Print(True)

end event

type cb_6 from commandbutton within w_entrada_arriba
boolean visible = false
integer x = 4119
integer y = 20
integer width = 137
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "AE"
end type

event clicked;OpenSheet(w_activar_entradas,str.frame,2, Original!)
end event

type dw_12 from datawindow within w_entrada_arriba
boolean visible = false
integer x = 608
integer y = 128
integer width = 663
integer height = 400
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Cambiar #"
string dataobject = "dw_cambio_de_secuencia"
boolean controlmenu = true
string icon = "Form!"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;long ll_secuencia, ll_secuencia_new
integer li_ann, li_existe
boolean lb_salvo
this.accepttext()
ll_secuencia = il_secuencia
ll_secuencia_new = this.getitemNumber(1,'secuencia')
li_ann = dw_1.getitemnumber(1,'tmov_anual')

if isnull(ll_secuencia_new) or ll_secuencia_new = 0 then
	gf_mensaje('','Asigne un numero de Entrada valido !!!',1,1,'E')
	this.setcolumn('secuencia')
	return
end if

  SELECT isnull(count(*),0)  
    INTO :li_existe  
    FROM intmovim  
   WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
         ( intmovim.tmov_empresa = :str.empresa ) AND  
		( intmovim.tmov_aplicacion = 'IN') AND
		( intmovim.tmov_tipo_transaccion = 'EN' ) AND
         ( intmovim.tmov_secuencia = :ll_secuencia_new ) AND  
         ( intmovim.tmov_anual = :li_ann )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al validar existencia '+sqlca.sqlerrtext,1,1,'E')
		return
	end if
	if li_existe > 0 then
		gf_mensaje('','El número de Entrada ya existe, Verifique !!!',1,1,'E')
		this.setcolumn('secuencia')
		return
	end if
	sqlca.autocommit = false
	gf_in_cambiar_secuencia(ll_secuencia, li_ann, ll_secuencia_new, lb_salvo)
	sqlca.autocommit = true
	this.setitem(1,'secuencia',0)
	this.visible = false
	if lb_salvo then
		dw_1.setcolumn('tmov_secuencia')
		dw_1.setitem(1,'tmov_secuencia',ll_secuencia_new)
		dw_1.triggerevent('itemchanged')
	end if

	
	
end event

event itemfocuschanged;this.selecttext(1,100)
end event

type cb_7 from commandbutton within w_entrada_arriba
integer x = 3735
integer y = 32
integer width = 325
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Copiar a ..."
end type

event clicked;dw_13.visible = true
dw_13.setfocus()
end event

type dw_13 from datawindow within w_entrada_arriba
boolean visible = false
integer x = 3159
integer y = 168
integer width = 1006
integer height = 476
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "Copiar Entrada a ..."
string dataobject = "dw_copiar_entrada"
boolean controlmenu = true
string icon = "Report5!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;long ll_secuencia, ll_secuencia_new
integer li_ann, li_existe, li_empresa
boolean lb_salvo
this.accepttext()
ll_secuencia = il_secuencia
li_empresa = this.getitemNumber(1,'empresa')

if isnull(li_empresa) or li_empresa = 0 then
	gf_mensaje('','Asigne una empresa valida !!!',1,1,'E')
	this.setcolumn('empresa')
	return
end if

li_ann = dw_1.getitemnumber(1,'tmov_anual')

wf_orden_nueva_empresa(li_empresa, ll_secuencia_new)

if isnull(ll_secuencia_new) or ll_secuencia_new = 0 then
	gf_mensaje('','Asigne un numero de Entrada valido !!!',1,1,'E')
	this.setcolumn('empresa')
	return
end if

  SELECT isnull(count(*),0)  
    INTO :li_existe  
    FROM intmovim  
   WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
         ( intmovim.tmov_empresa = :li_empresa ) AND  
		( intmovim.tmov_aplicacion = 'IN') AND
		( intmovim.tmov_tipo_transaccion = 'EN' ) AND
         ( intmovim.tmov_secuencia = :ll_secuencia_new ) AND  
         ( intmovim.tmov_anual = :li_ann )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al validar existencia '+sqlca.sqlerrtext,1,1,'E')
		return
	end if
	if li_existe > 0 then
		gf_mensaje('','El número de Entrada ya existe, Verifique !!!',1,1,'E')
		this.setcolumn('empresa')
		return
	end if
	sqlca.autocommit = false
	gf_in_copiar_secuencia(ll_secuencia, li_ann, ll_secuencia_new, lb_salvo,li_empresa)
	sqlca.autocommit = true
	this.setitem(1,'empresa',0)
	this.visible = false
	if lb_salvo and li_empresa = str.empresa then
		dw_1.setcolumn('tmov_secuencia')
		dw_1.setitem(1,'tmov_secuencia',ll_secuencia_new)
		dw_1.triggerevent('itemchanged')
	end if

	
	
end event

type dw_14 from datawindow within w_entrada_arriba
boolean visible = false
integer x = 27
integer y = 1720
integer width = 2281
integer height = 484
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_pagos_a_entradas"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event retrieveend;decimal{2} ld_pagos
if rowcount > 0 then
	ld_pagos = this.getitemnumber(1,'total')
else
	ld_pagos = 0
end if

if dw_2.rowcount() > 0 then dw_2.setitem(1,'pagos',ld_pagos)
end event

type dw_15 from datawindow within w_entrada_arriba
boolean visible = false
integer x = 1266
integer y = 308
integer width = 1445
integer height = 960
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_gastos_entradas_contabilidad"
boolean resizable = true
boolean livescroll = true
end type

type dw_16 from datawindow within w_entrada_arriba
boolean visible = false
integer x = 50
integer y = 244
integer width = 4686
integer height = 732
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "aa_listado_entradas_asiento"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_8 from commandbutton within w_entrada_arriba
boolean visible = false
integer x = 4256
integer y = 132
integer width = 709
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "ACTUALIZAR ASIENTO EN"
end type

event clicked;/*ADD BY HGN 15/08/2002 PARA QUE ACTUALICE COSTO CIF*/	
	String	ls_subtran_inven, ls_tran_inven, ls_entrada, ls_expresion, ls_concepto, ls_costo_proc , ls_dbcode, ls_errtext, ls_producto, ls_documento, ls_comentario, ls_referencia, ls_cuenta, ls_cuenta_contable_proveedor, ls_nombre, ls_tran = 'FF', ls_subtran = 'FF', ls_cuenta_compras, ls_documento_entrada, ls_cuenta_descuento, ls_contrato
	integer  i, li_linea, li_existe, li_excluir_sugerido = 0, li_encontro, j, k
	decimal{4} ld_costo_promedio, ld_costo_cif, ld_costo_fob, ld_gastos_admon, cargo, costo_cif, costo
	decimal ld_costo_global, total_cargos, cantidad 
	decimal{2} ld_monto, ld_descuento, ld_cargos_total, ld_monto_conta, ld_cargos_costear, ld_monto_inventario
	datetime ldt_fecha	
	long ll_cantidad_por_producto, ll_tercero, linea, ll_secuencia
sqlca.autocommit = true
	for k =  1 to dw_16.rowcount()
		dw_16.scrolltorow(k)

		ldt_fecha = dw_16.getitemdatetime(k,'tmov_fecha')
		ls_documento = dw_16.getitemstring(k,'tmov_documento')
		ld_monto		= dw_16.getitemnumber(k,'valor')
		ll_secuencia = dw_16.getitemnumber(k,'tmov_secuencia')
		if isnull(id_descuento) then id_descuento = 0
		ld_descuento = id_descuento		
		if isnull(id_cargos) then id_cargos = 0
		ld_cargos_total = id_cargos
		ld_cargos_costear = dw_16.getitemnumber(k,'tmov_total_cargos')
		if isnull(ld_cargos_costear) then ld_cargos_costear = 0
		///////////////////////////////////////////////////////////////////	
		
		ll_tercero = dw_16.getitemnumber(k,'tmov_terceros')
		ls_concepto = dw_16.getitemString(k,'tmov_concepto')
				
	/*GENERA ASIENTO DE ENTRADAS*/
	if str.genera_asiento_entradas = 1 then
		ls_comentario = dw_16.getitemstring(k,'tmov_comentario')
		ls_entrada = dw_16.getitemstring(k,'tmov_documento_entrada')
		ls_comentario = 'ENTRADA A INV. '+string(il_secuencia)+' FACTURA '+ls_documento+' - '+ls_comentario
		ls_referencia = string(ll_secuencia)
		//Datos y cuenta del proveedor
		  SELECT dgmterce.terc_descripcion,   
					cpmprove.prov_cod_proveedor,   
					cpmprove.prov_mg_cuenta  
			 INTO :ls_nombre,   
					:ls_cuenta,   
					:ls_cuenta_contable_proveedor  
			 FROM cpmprove,   
					dgmterce  
			WHERE ( dgmterce.terc_tercero = cpmprove.prov_tercero ) and  
					( ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
					( cpmprove.prov_empresa = :str.empresa ) AND  
					( cpmprove.prov_tercero = :ll_tercero ) )   ;
			 If Sqlca.sqlcode = -1 Then
				 gf_mensaje("","¡Error al Buscar datos del Proveedor " +sqlca.sqlerrtext,1,1,'E')
				 Rollback;
				sqlca.autocommit = true
				return
			 End If 				 
			 
			ls_tran 	  = 'FF'
			ls_subtran = 'FF'
			
			ls_tran_inven = 'EN'
			ls_subtran_inven = dw_16.getitemstring(k,'tmov_concepto')
	
			//Calcula el monto total del Asiento contable
			ld_monto_conta = ld_monto + ld_cargos_total - ld_descuento				
			
			//Monto del Valor de la Entrada a Inventarios
			ld_monto_inventario = ld_monto + ld_cargos_costear
						
			//Inserta la transaccion de Entrada de Inventarios			
			  INSERT INTO cotdiari  
				( diar_g_financiero,   
				  diar_empresa,   
				  diar_aplicacion_mg,   
				  diar_tipo_transaccion,   
				  diar_sub_trans,   
				  diar_no_documento,   
				  diar_no_referencia,   
				  diar_banco_cuenta,   
				  diar_ann,   
				  diar_fecha_transaccion,   
				  diar_descripcion,   
				  diar_id,   
				  diar_fecha_creacion,   
				  diar_estado,   
				  diar_monto,   
				  diar_balance,   
				  diar_modificado,   
				  diar_cerrado,   
				  diar_cierre_mensual,   
				  diar_banco,   
				  diar_documento_a,   
				  diar_nombre,   
				  diar_impreso,
				  diar_comentario)  
	  VALUES ( :str.g_financiero,   
				  :str.empresa,   
				  'IN',   
				  :ls_tran_inven,   
				  :ls_subtran_inven,   
				  :ls_documento,   
				  :ls_referencia,   
				  '1',   
				  :ii_ann,   
				  :ldt_fecha,   
				  'ENTRADA INVENTARIO',   
				  :str.usuario,   
				  getdate(),   
				  'I',   
				  :ld_monto_inventario,   
				  1,   
				  0,   
				  'N',   
				  'N',   
				  null,   
				  :ls_entrada,   
				  :ls_nombre,   
				  'S',
				  :ls_comentario)  ;
	 		If Sqlca.sqlcode = -1 Then
				 gf_mensaje("","¡Error al Insertar Encabezado Contable Entrada " +sqlca.sqlerrtext,1,1,'E')
				 Rollback;
				sqlca.autocommit = true
				return
			 End If 
		
	
			//Inserta el Detalle Contable
			dw_10.reset()
			
			//Cuenta del Inventario
			dw_10.scrolltorow(dw_10.insertrow(0))
			dw_10.setitem(dw_10.getrow(),'ddia_fecha', date(gf_fecha_serv()))
			dw_10.setitem(dw_10.getrow(),'ddia_g_financiero',str.g_financiero)
			dw_10.setitem(dw_10.getrow(),'ddia_empresa',str.empresa)
			dw_10.setitem(dw_10.getrow(),'ddia_aplicacion_mg','IN')
			dw_10.setitem(dw_10.getrow(),'ddia_id', str.usuario)
			dw_10.setitem(dw_10.getrow(),'ddia_tipo_transaccion', ls_tran_inven)
			dw_10.setitem(dw_10.getrow(),'ddia_sub_trans', ls_subtran_inven)
			dw_10.setitem(dw_10.getrow(),'naturaleza','D')	
			dw_10.setitem(dw_10.getrow(),'ddia_linea',1)
			dw_10.setitem(dw_10.getrow(),'tipo','I')
			dw_10.setitem(dw_10.getrow(),'ddia_ann',ii_ann)
			dw_10.setitem(dw_10.getrow(),'ddia_no_documento',ls_documento)
			dw_10.setitem(dw_10.getrow(),'ddia_no_referencia',ls_referencia)
			dw_10.setitem(dw_10.getrow(),'monto_debito',ld_monto_inventario)
			dw_10.setitem(dw_10.getrow(),'ddia_mg_cuenta', is_cuenta_inventarios)
			dw_10.setitem(dw_10.getrow(),'ddia_monto',ld_monto_inventario)
			dw_10.setitem(dw_10.getrow(),'ddia_tercero',ll_tercero)
			dw_10.setitem(dw_10.getrow(),'ddia_banco_cuenta','1')			
			//Cuenta de Costos de la Mercancia Vendida
			dw_10.scrolltorow(dw_10.insertrow(0))
			dw_10.setitem(dw_10.getrow(),'ddia_fecha', date(gf_fecha_serv()))
			dw_10.setitem(dw_10.getrow(),'ddia_g_financiero',str.g_financiero)
			dw_10.setitem(dw_10.getrow(),'ddia_empresa',str.empresa)
			dw_10.setitem(dw_10.getrow(),'ddia_aplicacion_mg','IN')
			dw_10.setitem(dw_10.getrow(),'ddia_id', str.usuario)
			dw_10.setitem(dw_10.getrow(),'ddia_tipo_transaccion', ls_tran_inven)
			dw_10.setitem(dw_10.getrow(),'ddia_sub_trans', ls_subtran_inven)
			dw_10.setitem(dw_10.getrow(),'naturaleza','C')	
			dw_10.setitem(dw_10.getrow(),'ddia_linea',2)
			dw_10.setitem(dw_10.getrow(),'tipo','I')
			dw_10.setitem(dw_10.getrow(),'ddia_ann',ii_ann)
			dw_10.setitem(dw_10.getrow(),'ddia_no_documento',ls_documento)
			dw_10.setitem(dw_10.getrow(),'ddia_no_referencia',ls_referencia)
			dw_10.setitem(dw_10.getrow(),'monto_credito',ld_monto_inventario)
			dw_10.setitem(dw_10.getrow(),'ddia_mg_cuenta', is_cuenta_costo_venta)
			dw_10.setitem(dw_10.getrow(),'ddia_monto',ld_monto_inventario)
			dw_10.setitem(dw_10.getrow(),'ddia_tercero',ll_tercero)				
			dw_10.setitem(dw_10.getrow(),'ddia_banco_cuenta','1')						
			
			
			//valida q este en balance
			if dw_10.getitemnumber(1,'balance') <> 0 then
				gf_mensaje('','Debe Balancear la Transaccion para Guardar, Verifique !!!',1,1,'E')
				rollback;
				return
			end if
			
			if dw_10.update() = -1 then
				gf_mensaje('','Error al Actualizar Detalle del Asiento Contable '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				return		
			end if
	
	  end if //Del genera asiento
	
	next
	/**/
	commit;

end event

