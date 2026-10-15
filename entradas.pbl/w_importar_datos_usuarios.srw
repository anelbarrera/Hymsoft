//objectcomments Ventana de Impresión del Reporte de Ventas x Factura
forward
global type w_importar_datos_usuarios from w_fa_padre_reportes
end type
type cb_1 from commandbutton within w_importar_datos_usuarios
end type
type cb_2 from commandbutton within w_importar_datos_usuarios
end type
type cb_3 from commandbutton within w_importar_datos_usuarios
end type
type cb_4 from commandbutton within w_importar_datos_usuarios
end type
type cb_5 from commandbutton within w_importar_datos_usuarios
end type
end forward

global type w_importar_datos_usuarios from w_fa_padre_reportes
integer width = 3483
integer height = 1676
string title = "Importacion de Productos"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 15780518
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
end type
global w_importar_datos_usuarios w_importar_datos_usuarios

type variables
Boolean	ib_cerrar
datawindowchild idwc_division, idwc_grupo
end variables

forward prototypes
public subroutine wf_valida_ingles ()
end prototypes

public subroutine wf_valida_ingles ();
end subroutine

on w_importar_datos_usuarios.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_4
this.Control[iCurrent+5]=this.cb_5
end on

on w_importar_datos_usuarios.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
end on

event resize;//Override
this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 378
gb_1.width  = this.width  - 63
gb_1.height = this.height - 220

st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180


this.SetRedraw(true)

end event

event ue_post_open;//override
String	ls_expresion
Integer	li_pos
datawindowchild ldwc_child
dw = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()
sqlca.autocommit = true
dw_1.settransobject(sqlca)

//dw_1.object.hora.expression = "'"+ls_expresion+"'"
//
//dw_1.object.datawindow.print.preview = True
//dw_1.object.datawindow.print.preview.zoom = 100

dw_1.getchild('prod_division',idwc_division)
idwc_division.settransobject(sqlca)
idwc_division.retrieve(str.g_financiero, str.empresa)

dw_1.getchild('prod_grupo',idwc_grupo)
idwc_grupo.settransobject(sqlca)
idwc_grupo.retrieve(str.g_financiero, str.empresa)

dw_1.getchild('prod_marca',ldwc_child)
ldwc_child.settransobject(sqlca)
ldwc_child.retrieve(str.g_financiero, str.empresa)

dw_1.getchild('prod_proveedor',ldwc_child)
ldwc_child.settransobject(sqlca)
ldwc_child.retrieve(str.g_financiero, str.empresa)

dw_1.getchild('prod_arancel',ldwc_child)
ldwc_child.settransobject(sqlca)
ldwc_child.retrieve()

dw_1.getchild('prod_medida',ldwc_child)
ldwc_child.settransobject(sqlca)
ldwc_child.retrieve()

dw_1.getchild('prod_medida_empaque',ldwc_child)
ldwc_child.settransobject(sqlca)
ldwc_child.retrieve()

dw_1.getchild('prod_pais',ldwc_child)
ldwc_child.settransobject(sqlca)
ldwc_child.retrieve()

dw_1.Object.datawindow.horizontalscrollsplit = 2210 

This.SetRedraw(True)
end event

event timer;call super::timer;if ib_cerrar then
	//this.postevent("close")
end if
end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_importar_datos_usuarios
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_importar_datos_usuarios
boolean visible = false
integer x = 32
integer y = 1384
integer width = 1010
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_importar_datos_usuarios
integer x = 41
integer y = 136
integer width = 2935
integer height = 1212
string dataobject = "dw_productos_importar"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event dw_1::itemfocuschanged;call super::itemfocuschanged;//override
string ls_filtro
integer li_rtn

this.accepttext()

CHOOSE CASE dwo.name
	CASE "prod_grupo"
	//Se filtran los grupo por la división seleccionada
	ls_filtro = This.GetItemString(row,"prod_division")
	if ls_filtro = '' or isnull(ls_filtro) then
		gf_mensaje('','Asigne la Division y despues el Grupo, Verifique !!!',1,1,'E')
		this.setcolumn('prod_division')
		return
	end if
	idwc_grupo.SetFilter("adiv_nombre_div = '" + ls_filtro + "'")	
	li_rtn = idwc_grupo.Filter()
end choose
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;//override
string ls_filtro
integer li_rtn

accepttext()

CHOOSE CASE dw_1.getcolumnname()
	CASE "prod_grupo"
	//Se filtran los grupo por la división seleccionada
	ls_filtro = This.GetItemString(currentrow,"prod_division")
	if ls_filtro = '' or isnull(ls_filtro) then
	//	gf_mensaje('','Asigne la Division y despues el Grupo, Verifique !!!',1,1,'E')
		this.setcolumn('prod_division')
		return
	end if
	idwc_grupo.SetFilter("adiv_nombre_div = '" + ls_filtro + "'")	
	li_rtn = idwc_grupo.Filter()
end choose
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_importar_datos_usuarios
integer x = 27
integer y = 0
integer width = 2967
integer height = 1364
long backcolor = 15780518
end type

type cb_1 from commandbutton within w_importar_datos_usuarios
integer x = 41
integer y = 40
integer width = 677
integer height = 88
integer taborder = 11
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Importar Productos"
end type

event clicked;string docname, named
integer value, i, li_id, li_total


dw_1.reset()

value = GetFileOpenName("Seleccione el Archivo...", &
		+ docname, named, "csv", &
		+ "Archivo CSV (*.csv),*.csv")

IF value = 1 THEN 
	dw_1.ImportFile(docname)
end if

  SELECT isnull(max(prod_id)  ,0)
    INTO :li_id  
    FROM productos_importar  ;
if sqlca.sqlcode = -1 then
	gf_mensaje('','Error al Contar '+sqlca.sqlerrtext,1,1,'E')
	return
end if

li_id ++

li_total = dw_1.rowcount()

for i = 1 to li_total
	dw_1.setitem(i,'prod_id',li_id)
	if dw_1.getitemstring(i,'prod_producto') = '' or isnull(dw_1.getitemstring(i,'prod_producto')) then
		dw_1.deleterow(i)
		i --
		li_total --
	end if
	dw_1.setitem(i,'prod_secuencia',i)
next

end event

type cb_2 from commandbutton within w_importar_datos_usuarios
integer x = 905
integer y = 40
integer width = 448
integer height = 92
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Actualizar"
end type

event clicked;long ll_total, i, j, ll_tercero, ll_empaque, ll_pais
integer li_existe
string ls_proveedor, ls_pais, ls_marca, ls_error, ls_medida, ls_medida_empaque, ls_modelo, ls_cliente_consolidado ,ls_nombre, ls_producto, ls_descripcion, ls_barra, ls_arancel, ls_division, ls_grupo, ls_comentarios, ls_cuenta, ls_tamano
decimal{2} ld_saldo, ld_alto, ld_ancho, ld_largo
decimal{3} ld_peso, ld_cubicaje, ld_metros_cubicos
datetime ldt_fecha
dw_1.accepttext()

ll_total = dw_1.rowcount()

if gf_mensaje('','Esta Seguro de Importar los Productos al Sistema ?',2,1,'E')  = 2 then return
dw_1.setfocus()

sqlca.autocommit = false

for i = 1 to ll_total
	yield()
	str.frame.setmicrohelp('Procesando el Registro '+string(i) +' de '+string(ll_total))
//	dw_1.scrolltorow(i)
	ls_producto	= dw_1.getitemString(i,'prod_producto')
	ls_descripcion	= dw_1.getitemString(i,'prod_descripcion')
	ls_modelo   =  dw_1.getitemstring(i,'prod_modelo')
	ls_barra	   =  dw_1.getitemstring(i,'prod_barra')	
	ls_arancel   =  dw_1.getitemstring(i,'prod_arancel')
	ls_tamano   =  dw_1.getitemstring(i,'prod_tamano')
	if ls_arancel = '' or isnull(ls_arancel) then
		rollback;
		gf_mensaje('','Arancel Invalido, Verifique !!!',1,1,'E')
		sqlca.autocommit = true
		dw_1.scrolltorow(i)
		dw_1.setcolumn('prod_arancel')
		return	
	end if
	ls_division   =  upper(dw_1.getitemstring(i,'prod_division'))
	  SELECT cradivis.adiv_codigo_div  
		 INTO :ls_division  
		 FROM cradivis  
		WHERE ( cradivis.adiv_g_financiero = :str.g_financiero ) AND  
				( cradivis.adiv_empresa = :str.empresa ) AND  
				( cradivis.adiv_nombre_div = :ls_division )   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			gf_mensaje('','Error al buscar division '+ls_error,1,1,'E')
			rollback;
			sqlca.autocommit = true
			return
		end if
	if ls_division = '' or isnull(ls_division) then
		rollback;
		gf_mensaje('','Division Invalida, Verifique !!!',1,1,'E')
		rollback;
		sqlca.autocommit = true
		dw_1.scrolltorow(i)
		dw_1.setcolumn('prod_division')
		return	
	end if	
	ls_grupo  =  upper(dw_1.getitemstring(i,'prod_grupo'))	
		
		  SELECT cragrupo.agru_codigo_grupo  
			 INTO :ls_grupo  
			 FROM cragrupo  
			WHERE ( cragrupo.agru_g_financiero = :str.g_financiero ) AND  
					( cragrupo.agru_empresa = :str.empresa ) AND  
					( cragrupo.agru_codigo_div = :ls_division ) AND  
					( cragrupo.agru_descripcion_grupo = :ls_grupo )   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			gf_mensaje('','Error al buscar grupo '+ls_error,1,1,'E')
			rollback;
			sqlca.autocommit = true
			return
		end if
	if ls_division = '' or isnull(ls_division) then
		rollback;
		gf_mensaje('','Grupo Invalido, Verifique !!!',1,1,'E')
		rollback;
		sqlca.autocommit = true
		dw_1.scrolltorow(i)
		dw_1.setcolumn('prod_grupo')
		return	
	end if
	
	ls_medida		= upper(dw_1.getitemstring(i,'prod_medida'))
	  SELECT inamedid.medi_medida  
		 INTO :ls_medida  
		 FROM inamedid  
		WHERE inamedid.medi_descripcion = :ls_medida   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			gf_mensaje('','Error al buscar medida '+ls_error,1,1,'E')
			rollback;
			sqlca.autocommit = true
			return
		end if
	if ls_medida = '' or isnull(ls_medida) then
		rollback;
		gf_mensaje('','Medida Invalida, Verifique !!!',1,1,'E')
		rollback;
		sqlca.autocommit = true
		dw_1.scrolltorow(i)
		dw_1.setcolumn('prod_medida')
		return	
	end if

  SELECT cracltam.acta_cod_clase_tam  
    INTO :ls_tamano  
    FROM cracltam  
   WHERE ( cracltam.acta_g_financiero = :str.g_financiero ) AND  
         ( cracltam.acta_empresa = :str.empresa ) AND  
         ( cracltam.acta_descripcion = :ls_tamano )   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			gf_mensaje('','Error al buscar tamano '+ls_error,1,1,'E')
			rollback;
			sqlca.autocommit = true
			return
		end if
	if ls_tamano = '' or isnull(ls_tamano) then
		rollback;
		gf_mensaje('','Tamano Invalido, Verifique !!!',1,1,'E')
		rollback;
		sqlca.autocommit = true
		dw_1.scrolltorow(i)
		dw_1.setcolumn('prod_tamano')
		return	
	end if	

	ll_empaque		= dw_1.getitemnumber(i,'prod_empaque')
	ls_medida_empaque		= upper(dw_1.getitemstring(i,'prod_medida_empaque'))
	
	  SELECT inamedid.medi_medida  
		 INTO :ls_medida_empaque  
		 FROM inamedid  
		WHERE inamedid.medi_descripcion = :ls_medida_empaque   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			gf_mensaje('','Error al buscar medida '+ls_error,1,1,'E')
			rollback;
			sqlca.autocommit = true
			return
		end if
	if ls_medida_empaque = '' or isnull(ls_medida_empaque) then
		rollback;
		gf_mensaje('','Medida del empaque Invalida, Verifique !!!',1,1,'E')
		rollback;
		sqlca.autocommit = true
		dw_1.scrolltorow(i)
		dw_1.setcolumn('prod_medida_empaque')
		return	
	end if
	ls_marca		= upper(dw_1.getitemstring(i,'prod_marca'))
	  SELECT cramarca.amar_num_marca  
		 INTO :ls_marca  
		 FROM cramarca  
		WHERE cramarca.amar_nombre_marca = :ls_marca  and
				  cramarca.amar_g_financiero = :str.g_financiero and
				  cramarca.amar_empresa = :str.empresa ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			gf_mensaje('','Error al buscar marca '+ls_error,1,1,'E')
			rollback;
			sqlca.autocommit = true
			return
		end if
	if ls_marca = '' or isnull(ls_marca) then
		rollback;
		gf_mensaje('','Marca del Producto Invalida, Verifique !!!',1,1,'E')
		rollback;
		sqlca.autocommit = true
		dw_1.scrolltorow(i)
		dw_1.setcolumn('prod_marca')
		return	
	end if
	//----------------------
	ls_pais		= upper(dw_1.getitemstring(i,'prod_pais'))
	  SELECT dgapais.pais_pais 
		 INTO :ll_pais
		 FROM dgapais  
		WHERE dgapais.pais_descripcion = :ls_pais;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			gf_mensaje('','Error al buscar Pais '+ls_error,1,1,'E')
			rollback;
			sqlca.autocommit = true
			return
		end if
	if ll_pais = 0 or isnull(ll_pais) then
		rollback;
		gf_mensaje('','Pais del Producto Invalido, Verifique !!!',1,1,'E')
		rollback;
		sqlca.autocommit = true
		dw_1.scrolltorow(i)
		dw_1.setcolumn('prod_pais')
		return	
	end if
	//-------------------------------------------
	ls_proveedor		= upper(dw_1.getitemstring(i,'prod_proveedor'))
	  SELECT dgmterce.terc_tercero 
		 INTO :ll_tercero
		 FROM dgmterce, cpmprove  
		WHERE dgmterce.terc_descripcion = :ls_proveedor and					
				  dgmterce.terc_tercero = cpmprove.prov_tercero and
				  cpmprove.prov_g_financiero = :str.g_financiero and
				  cpmprove.prov_empresa = :str.empresa ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			gf_mensaje('','Error al buscar proveedor '+ls_error,1,1,'E')
			rollback;
			sqlca.autocommit = true
			return
		end if
	if ll_tercero = 0 or isnull(ll_tercero) then
		rollback;
		gf_mensaje('','Proveedor del Producto Invalido, Verifique !!!',1,1,'E')
		rollback;
		sqlca.autocommit = true
		dw_1.scrolltorow(i)
		dw_1.setcolumn('prod_proveedor')
		return	
	end if
	ld_peso = dw_1.getitemnumber(i,'prod_peso')
	ld_cubicaje = dw_1.getitemnumber(i,'prod_cubicaje')
	ld_alto = dw_1.getitemnumber(i,'prod_alto')
	ld_ancho = dw_1.getitemnumber(i,'prod_ancho')
	ld_largo = dw_1.getitemnumber(i,'prod_largo')
	
	////////////////////////////////////////////////
		  SELECT count(*)  
			 INTO :li_existe  
			 FROM inmprodu  
			WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
					( inmprodu.prod_empresa = :str.empresa ) AND  
					( inmprodu.prod_producto = :ls_producto )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al validar existencia '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if
					
	if li_existe = 0 then
		j ++
		  INSERT INTO inmprodu  
         ( prod_g_financiero,   
           prod_empresa,   
           prod_producto,   
           prod_owner,   
           prod_producto_dos,   
           prod_cod_alternativo,   
           prod_barra,   
           prod_descripcion,   
           prod_descripcion_dos,   
           prod_division,   
           prod_grupo,   
           prod_sub_grupo,   
           prod_clase,   
           prod_num_producto,   
           prod_num_tipo,   
           prod_compuesto,   
           prod_marca,   
           prod_codigo_modelo,   
           prod_medida,   
           prod_color,   
           prod_cod_clase_tam,   
           prod_fecha_creacion,   
           prod_ultima_actualizacion,   
           prod_costo_fob,   
           prod_flete,   
           prod_seguros,   
           prod_otros_gastos,   
           prod_costo_cif,   
           prod_precio_venta_unidad,   
           prod_impuesto,   
           prod_arancel,   
           prod_status,   
           prod_estatus_ref,   
           prod_foto_dir,   
           prod_desc_local,   
           prod_desc_exterior,   
           prod_costou_local,   
           prod_itbm_local,   
           prod_definicion,   
           prod_peso,   
           prod_peso_descripcion,   
           prod_empaque,   
           prod_empaque_descripcion,   
           prod_cubicaje,   
           prod_unidad_cub,   
           prod_id_usuario,   
           prod_pais,   
           prod_base1,   
           prod_base2,   
           prod_tipo_base,   
           prod_porc_apli,   
           prod_costo_unitario,   
           prod_ultima_entrada_doc,   
           prod_ultima_entrada_can,   
           prod_precio1,   
           prod_precio2,   
           prod_precio3,   
           prod_precio4,   
           prod_precio5,   
           prod_punto_maximo,   
           prod_punto_minimo,   
           prod_cant_a_pedir,   
           prod_comision,   
           prod_descuento_maximo,   
           prod_descuento_siono,   
           prod_existencia_total,   
           prod_reserva_total,   
           prod_entrada_fecha,   
           prod_salida_fecha,   
           prod_ultima_salida_doc,   
           prod_observacion,   
           prod_cant_transito,   
           prod_reserva_trans,   
           prod_empaque_um,   
           prod_peso_unidad_medida,   
           prod_fecha_agotado,   
           prod_board,   
           prod_precio_venta_minimo,   
           prod_porcentaje_regalias,   
           prod_contrato_regalias,   
           prod_unidad_venta,   
           prod_clave_costo,   
           prod_por_precio1,   
           prod_por_precio2,   
           prod_por_precio3,   
           prod_por_precio4,   
           prod_por_precio5,   
           prod_costo_ult_entrada,   
           prod_costo_por,   
           prod_mg_cuenta,   
           prod_concepto,   
           prod_temporada,   
           prod_empaque_caja,   
           prod_reserva_conf,   
           prod_cant_confirma,   
           prod_gramaje,   
           prod_yarda_bulto,   
           prod_tercero,   
           prod_descuento,   
           prod_kilates,   
           prod_producto_referencia,   
           prod_costo_promedio,   
           prod_alto,   
           prod_ancho,   
           prod_largo,   
           prod_cantidad_limite,   
           prod_existencia1,   
           prod_existencia2,   
           prod_existencia3,   
           prod_existencia4,   
           prod_existencia5,   
           prod_existencia6,   
           prod_existencia7,   
           prod_reserva1,   
           prod_reserva2,   
           prod_reserva3,   
           prod_reserva4,   
           prod_reserva5,   
           prod_reserva6,   
           prod_reserva7,   
           prod_metros_cubicos,   
           prod_excluir_de_sugerido,   
           prod_cantidad_oc,   
           prod_costo_oc )  
  VALUES ( :str.g_financiero,   
           :str.empresa,   
           :ls_producto,   
           '11',   
           :ls_modelo,   
           null,   
           :ls_barra,   
           :ls_descripcion,   
           null,   
           :ls_division,   
           :ls_grupo,   
           'BAS',   
           'BAS',   
           1,   
           1,   
           'BAS',   
           :ls_marca,   
           null,   
           :ls_medida,   
           'BAS',   
           :ls_tamano,   
           getdate(),   
           null,   
           0,   
           0,   
           0,   
           0,   
           0,   
           0,   
           null,   
           :ls_arancel,   
           1,   
           1,   
           null,   
           0,   
           0,   
           0,   
           1,   
           0,   
           :ld_peso,   
           'KGS',   
           :ll_empaque,   
           'BULTOS',   
           :ld_cubicaje,   
           null,   
           :str.usuario,   
           :ll_pais,   
           0,   
           0,   
           0,   
           0,   
           0,   
           null,   
           null,   
           0,   
           0,   
           0,   
           0,   
           0,   
           0,   
           12,   
           0,   
           null,   
           50,   
           0,   
           0,   
           0,   
           null,   
           null,   
           null,   
           null,   
           0,   
           0,   
           :ls_medida_empaque,   
           'KL',   
           null,   
           null,   
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
           0,   
           null,   
           null,   
           null,   
           0,   
           0,   
           0,   
           null,   
           null,   
           :ll_tercero,   
           0,   
           0,   
           null,   
           0,   
           :ld_alto,   
           :ld_ancho,   
           :ld_largo,   
           null,   
           0,   
           0,   
           0,   
           0,   
           0,   
           0,   
           0,   
           0,   
           0,   
           0,   
           0,   
           0,   
           0,   
           0,   
           :ld_metros_cubicos,   
           0,   
           0,   
           0 )  ;
				
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				gf_mensaje('','Error al insertar producto '+ls_error,1,1,'E')
				sqlca.autocommit = true
				return
			end if
		
	end if
next

//if dw_1.update() = -1 then
//	ls_error = sqlca.sqlerrtext
//	rollback;
//	gf_mensaje('','Error al Actualizar DW '+ls_error,1,1,'E')
//	rollback;
//	sqlca.autocommit = true
//	return
//end if
//
commit ;
sqlca.autocommit = true

gf_mensaje('','Se Actualizaron '+string(j)+' Registros',1,1,'E')
dw_1.reset()

end event

type cb_3 from commandbutton within w_importar_datos_usuarios
boolean visible = false
integer x = 2043
integer y = 36
integer width = 402
integer height = 104
integer taborder = 31
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "dw"
end type

event clicked;dw_1.insertrow(1)
end event

type cb_4 from commandbutton within w_importar_datos_usuarios
integer x = 2450
integer y = 24
integer width = 402
integer height = 96
integer taborder = 31
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar"
end type

event clicked;if dw_1.update() = -1 then
	gf_mensaje('','Error al Guardar '+sqlca.sqlerrtext,1,1,'E')
end if
end event

type cb_5 from commandbutton within w_importar_datos_usuarios
integer x = 2930
integer y = 20
integer width = 402
integer height = 104
integer taborder = 41
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recuperar"
end type

event clicked;dw_1.retrieve()
end event

