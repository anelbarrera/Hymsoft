forward
global type aa_borrar_importacion from window
end type
type cb_2 from commandbutton within aa_borrar_importacion
end type
type cb_1 from commandbutton within aa_borrar_importacion
end type
type dw_1 from datawindow within aa_borrar_importacion
end type
end forward

global type aa_borrar_importacion from window
integer width = 4887
integer height = 2556
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global aa_borrar_importacion aa_borrar_importacion

on aa_borrar_importacion.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on aa_borrar_importacion.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
dw_1.retrieve()

end event

type cb_2 from commandbutton within aa_borrar_importacion
integer x = 4279
integer y = 192
integer width = 530
integer height = 104
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crear Detalle Fac"
end type

event clicked;long i, j, ll_total, ll_tercero, ll_secuencia, ll_bultos
integer li_ann, li_linea
string ls_referencia, ls_producto, ls_tran, ls_concepto, ls_descripcion, ls_bodega, ls_temp, ls_unidad, ls_pedido, ls_modelo
datetime ldt_fecha
decimal ld_cantidad, ld_costo_fob, ld_costo_cif, ld_precio1, ld_peso_bruto, ld_peso_neto, ld_total_venta, ld_total_costo, ld_cubicaje, ld_metro_cubico
sqlca.autocommit = true
ll_total = dw_1.rowcount()
j = 0
ll_secuencia = 0
li_linea = 0
for i = 1 to ll_total
	dw_1.scrolltorow(i)
	yield()
	ls_pedido = dw_1.getitemstring(i,'pedido')	
	ls_producto   = dw_1.getitemstring(i,'codigodeproducto')
	ls_bodega      = string(dw_1.getitemnumber(i,'bodega')	)
	ls_descripcion = dw_1.getitemstring(i,'descripcion')	
	ldt_fecha		   = dw_1.getitemdatetime(i,'fechadefactura')	
	li_ann 		   = year(date(ldt_fecha))
	ld_cantidad	   = truncate(round(dw_1.getitemnumber(i,'cantidad'),2),2)
	ld_precio1  	   = truncate(round(dw_1.getitemnumber(i,'precio'),2),2)
	
	ld_peso_neto   = truncate(round(dw_1.getitemnumber(i,'pesoneto'),2),2)
	ld_peso_bruto	   = truncate(round(dw_1.getitemnumber(i,'pesobruto'),2),2)

	ld_cubicaje  = truncate(round(dw_1.getitemnumber(i,'cubicaje'),2),2)
	ld_metro_cubico	   = truncate(round(dw_1.getitemnumber(i,'metrocubico'),2),2)
	
	ld_costo_fob   = truncate(round(dw_1.getitemnumber(i,'costofob'),2),2)
	ld_costo_cif	   = truncate(round(dw_1.getitemnumber(i,'costocif'),2),2)
	ld_total_costo	   = truncate(round(dw_1.getitemnumber(i,'totalcosto'),2),2)
	ld_total_venta	   = truncate(round(dw_1.getitemnumber(i,'totalventa'),2),2)
		
	ll_bultos	   = truncate(round(dw_1.getitemnumber(i,'cantidaddebultos'),2),2)
	ls_unidad	   = dw_1.getitemstring(i,'nombredeunidad')	
	ls_modelo   = dw_1.getitemstring(i,'codigodefabrica')	
	
	if ls_temp <> ls_pedido+string(li_ann) then
		j ++
		ll_secuencia = j 
		li_linea = 0			  
	end if
	
	ls_temp = ls_pedido+string(li_ann)
	li_linea ++
		
		  INSERT INTO faddiari  
         ( facd_g_financiero,   
           facd_empresa,   
           facd_tipo,   
           facd_no_pedido,   
           facd_pedido_original,   
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
           facd_pais,   
           facd_ubicacion,   
           facd_cant_devuelta,   
           facd_linea_articulo_dev,   
           facd_cant_asignada,   
           facd_index,   
           facd_validado,   
           facd_viene_de_pedido,   
           facd_bulto_inicio,   
           facd_bulto_fin,   
           facd_precio_original,   
           facd_actualizado,   
           facd_costo_total,   
           facd_bultos_cambiados,   
           facd_peso_cambiado,   
           facd_cubicaje_cambiado,   
           facd_lote,   
           facd_precio_descuento,   
           facd_descuento_ncr,   
           facd_precio_recargo,   
           facd_metal_pendiente,   
           facd_cantidad_cerrada,   
           facd_rebajar,   
           facd_cantidad_orden,   
           facd_monto_orden,   
           facd_modelo,   
           facd_bultos_original,   
           facd_comentario,   
           facd_peso_neto,   
           facd_cubicaje_metros )  
  VALUES ( :str.g_financiero,   
           :str.empresa,   
           '0',   
           :ls_pedido,   
           :ls_pedido,   
           :li_linea,   
           :li_ann,   
           'P',   
           :ls_producto,   
           :ls_descripcion,   
           :ld_cubicaje,   
           :ld_peso_bruto,   
           'KG',   
           :ls_unidad,   
           0,   
           0,   
           :ls_bodega,   
           :ld_costo_fob,   
           :ld_costo_cif,   
           :ld_precio1,   
           :ls_unidad,   
           :ld_cantidad,   
           0,   
           :ld_total_venta,   
           null,   
           :ld_total_venta,   
           getdate(),   
           'SA',   
           null,   
           :ll_bultos,   
           null,   
           '01',   
           0,   
           null,   
           0,   
           :li_linea,   
           0,   
           0,   
           0,   
           0,   
           :ld_precio1,   
           null,   
           :ld_total_costo,   
           0,   
           0,   
           0,   
           null,   
           null,   
           null,   
           0,   
           0,   
           0,   
           0,   
           0,   
           0,   
           :ls_modelo,   
           :ll_bultos,   
           null,   
           :ld_peso_neto,   
           :ld_metro_cubico )  ;
	
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Insertar detalle '+ls_pedido+ '  ' + ls_producto + '  '+sqlca.sqlerrtext,1,1,'E')
			return
		end if
		
	
next

end event

type cb_1 from commandbutton within aa_borrar_importacion
integer x = 4279
integer y = 64
integer width = 530
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crear Kardex"
end type

event clicked;long i, j, ll_total, ll_tercero, ll_secuencia
integer li_ann, li_linea
string ls_referencia, ls_producto, ls_tran, ls_concepto, ls_descripcion, ls_bodega, ls_temp, ls_unidad
datetime ldt_fecha
decimal ld_cantidad, ld_costo_fob, ld_costo_cif, ld_precio1, ld_precio2
sqlca.autocommit = true
ll_total = dw_1.rowcount()
j = 0
ll_secuencia = 0
li_linea = 0
for i = 1 to ll_total
	dw_1.scrolltorow(i)
	yield()
	ls_referencia = dw_1.getitemstring(i,'referencia')	
	ls_producto   = dw_1.getitemstring(i,'codigodeproducto')
	ls_tran  		  = dw_1.getitemstring(i,'transac')
	ls_concepto    = dw_1.getitemstring(i,'concepto')
	ls_bodega      = string(dw_1.getitemnumber(i,'bodega')	)
	ls_descripcion = dw_1.getitemstring(i,'descripcion')	
	ldt_fecha		   = dw_1.getitemdatetime(i,'fechaderegistro')	
	li_ann 		   = year(date(ldt_fecha))
	ll_tercero	   = dw_1.getitemnumber(i,'tercero')
	ld_cantidad	   = truncate(round(dw_1.getitemnumber(i,'cantidad'),2),2)
	ld_costo_fob   = truncate(round(dw_1.getitemnumber(i,'costofob'),2),2)
	ld_costo_cif	   = truncate(round(dw_1.getitemnumber(i,'costocif'),2),2)
	ld_precio1  	   = truncate(round(dw_1.getitemnumber(i,'precio'),2),2)
	ld_precio2	   = truncate(round(dw_1.getitemnumber(i,'precio2'),2),2)
	ls_unidad	   = dw_1.getitemstring(i,'unidad')	
		
	if ls_temp <> ls_referencia+ls_tran then
		j ++
		ll_secuencia = j 
		li_linea = 0
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
           tmov_rebaja_reserva)  
  VALUES ( :str.g_financiero,   
           :str.empresa,   
           case when :ls_tran = 'SA' then 'FA' else 'IN' end,   
           :ls_tran,   
           :ll_secuencia,   
           :ls_concepto,   
           :li_ann,   
           :ls_descripcion,   
           :ldt_fecha,   
           'SA',   
           :ls_referencia,   
           getdate(),   
           :ll_tercero,   
           :ls_descripcion,   
           0,   
           'SA',   
		case :ls_tran when 'EN' then 'D' when 'SA' then 'C' when 'AE' then 'D' else 'D' end,   
           1,   
           0,   
           0,   
           :ldt_fecha,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           :ls_descripcion,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           0)  ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Insertar '+sqlca.sqlerrtext,1,1,'E')
			return
		end if
			  
	end if
	ls_temp = ls_referencia + ls_tran
	li_linea ++
	
	  INSERT INTO indmovim  
         ( dmov_g_financiero,   
           dmov_empresa,   
           dmov_aplicacion,   
           dmov_tipo_transaccion,   
           dmov_concepto,   
           dmov_secuencia,   
           dmov_anual,   
           dmov_linea,   
           dmov_documento,   
           dmov_linea_referencia,   
           dmov_bodega,   
           dmov_ubicacion,   
           dmov_producto,   
           dmov_cantidad,   
           dmov_cant1,   
           dmov_unidad_medida,   
           dmov_costo,   
           dmov_precio,   
           dmov_cubicaje,   
           dmov_peso,   
           dmov_bulto,   
           dmov_costo_cif,   
           dmov_cargos,   
           dmov_precio_ent,   
           dmov_id,   
           dmov_bodega_destino,   
           dmov_ubicacion_destino,   
           dmov_fabricante,   
           dmov_anulado,   
           dmov_id_precio,   
           dmov_fecha_agotado,   
           dmov_existe_detalle,   
           dmov_num_orden,   
           dmov_comentarios,   
           dmov_clave,   
           dmov_costo_fob,   
           dmov_precio1,   
           dmov_precio2,   
           dmov_precio3,   
           dmov_secuencia_ea,   
           dmov_terceros_ea,   
           dmov_numpo_ea,   
           dmov_board,   
           dmov_color,   
           dmov_porcentaje_gasto,   
           dmov_lote,   
           dmov_fecha_registro,   
           dmov_descuento,   
           dmov_itbm,   
           dmov_precio_descuento,   
           dmov_descuento_ncr,   
           dmov_monto_final,   
           dmov_costo_promedio,   
           dmov_modelo )  
  VALUES ( :str.g_financiero,   
           :str.empresa,   
           case when :ls_tran = 'SA' then 'FA' else 'IN' end,   
           :ls_tran,   
           :ls_concepto,   
           :ll_secuencia,   
           :li_ann,   
           :li_linea,   
           :ls_referencia,   
           :li_linea,   
           :ls_bodega,   
           '01',   
           :ls_producto,   
           :ld_cantidad,   
           0,   
           :ls_unidad,   
           :ld_costo_cif,   
           :ld_precio1,   
           0,   
           0,   
           0,   
           :ld_costo_cif,   
           0,   
           0,   
           'SA',   
           case when :ls_tran = 'TR' then case :ls_bodega when '1' then '2' else '1' end end,   
           case when :ls_tran = 'TR' then '01' end,   
           null,   
           0,   
           null,   
           null,   
           null,   
           null,   
           :ls_descripcion,   
           null,   
           :ld_costo_fob,   
           :ld_precio1,   
           :ld_precio2,   
           null,   
           null,   
           null,   
           null,   
           '',   
           '',   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           convert(numeric(12,2),case when :ls_tran = 'SA' then :ld_cantidad * :ld_precio1 else :ld_costo_cif * :ld_cantidad end),   
           :ld_costo_cif,   
           null )  ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Insertar detalle '+ls_referencia+ '  ' + ls_producto + '  '+sqlca.sqlerrtext,1,1,'E')
			return
		end if
		
	
next

end event

type dw_1 from datawindow within aa_borrar_importacion
integer x = 32
integer y = 64
integer width = 4128
integer height = 1940
integer taborder = 10
string title = "none"
string dataobject = "aa_borrar_detalle_factura"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

