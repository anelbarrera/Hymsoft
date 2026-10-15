//objectcomments Reporte de Transacciones de cuentas por cobrar
forward
global type w_reporte_antiguedad_inventario from w_cc_padre_reporte
end type
type em_1 from editmask within w_reporte_antiguedad_inventario
end type
type em_2 from editmask within w_reporte_antiguedad_inventario
end type
type st_2 from statictext within w_reporte_antiguedad_inventario
end type
type st_1 from statictext within w_reporte_antiguedad_inventario
end type
type cb_generar from commandbutton within w_reporte_antiguedad_inventario
end type
type cb_2 from commandbutton within w_reporte_antiguedad_inventario
end type
type calendario from picture within w_reporte_antiguedad_inventario
end type
type calendario2 from picture within w_reporte_antiguedad_inventario
end type
type uo_1 from u_ddcalen within w_reporte_antiguedad_inventario
end type
type uo_2 from u_ddcalen within w_reporte_antiguedad_inventario
end type
type cbx_1 from checkbox within w_reporte_antiguedad_inventario
end type
type st_3 from statictext within w_reporte_antiguedad_inventario
end type
type dw_2 from datawindow within w_reporte_antiguedad_inventario
end type
type dw_3 from datawindow within w_reporte_antiguedad_inventario
end type
type rb_mensual from radiobutton within w_reporte_antiguedad_inventario
end type
type rb_anual from radiobutton within w_reporte_antiguedad_inventario
end type
type rb_division from radiobutton within w_reporte_antiguedad_inventario
end type
type gb_2 from groupbox within w_reporte_antiguedad_inventario
end type
end forward

global type w_reporte_antiguedad_inventario from w_cc_padre_reporte
integer width = 4338
integer height = 2564
string title = "Antiguedad del Inventario"
string menuname = "m_cc_principal_listados"
boolean resizable = true
windowtype windowtype = main!
long backcolor = 12639424
em_1 em_1
em_2 em_2
st_2 st_2
st_1 st_1
cb_generar cb_generar
cb_2 cb_2
calendario calendario
calendario2 calendario2
uo_1 uo_1
uo_2 uo_2
cbx_1 cbx_1
st_3 st_3
dw_2 dw_2
dw_3 dw_3
rb_mensual rb_mensual
rb_anual rb_anual
rb_division rb_division
gb_2 gb_2
end type
global w_reporte_antiguedad_inventario w_reporte_antiguedad_inventario

type variables
str_rangofecha lstr_rangfech
end variables

on w_reporte_antiguedad_inventario.create
int iCurrent
call super::create
if this.MenuName = "m_cc_principal_listados" then this.MenuID = create m_cc_principal_listados
this.em_1=create em_1
this.em_2=create em_2
this.st_2=create st_2
this.st_1=create st_1
this.cb_generar=create cb_generar
this.cb_2=create cb_2
this.calendario=create calendario
this.calendario2=create calendario2
this.uo_1=create uo_1
this.uo_2=create uo_2
this.cbx_1=create cbx_1
this.st_3=create st_3
this.dw_2=create dw_2
this.dw_3=create dw_3
this.rb_mensual=create rb_mensual
this.rb_anual=create rb_anual
this.rb_division=create rb_division
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_generar
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.calendario
this.Control[iCurrent+8]=this.calendario2
this.Control[iCurrent+9]=this.uo_1
this.Control[iCurrent+10]=this.uo_2
this.Control[iCurrent+11]=this.cbx_1
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.dw_2
this.Control[iCurrent+14]=this.dw_3
this.Control[iCurrent+15]=this.rb_mensual
this.Control[iCurrent+16]=this.rb_anual
this.Control[iCurrent+17]=this.rb_division
this.Control[iCurrent+18]=this.gb_2
end on

on w_reporte_antiguedad_inventario.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_generar)
destroy(this.cb_2)
destroy(this.calendario)
destroy(this.calendario2)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.cbx_1)
destroy(this.st_3)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.rb_mensual)
destroy(this.rb_anual)
destroy(this.rb_division)
destroy(this.gb_2)
end on

event resize;//Override
this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 450
gb_1.width  = this.width  - 60
gb_1.height = this.height - 380


st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180
this.SetRedraw(true)
end event

event ue_reg_anterior;//Override
dw.ScrollPriorPage( )
end event

event ue_siguiente_reg;call super::ue_siguiente_reg;//Override
dw.scrollNextpage()
end event

event ue_post_open;call super::ue_post_open;datetime ld_fecha1, ld_fecha2
integer li_grupo
string ls_empresa, ls_grupo, ls_tran
datawindowchild ldwc_prov
dw.SettransObject(sqlca)
ld_fecha1 = gf_fecha_serv()
ld_fecha2 = gf_fecha_serv() //datetime(lstr_rangfech.fecha2)

//em_1.text = '01/'+string(month(date(ld_fecha1)))+'/'+string(year(date(ld_fecha1)))
em_1.text = string(date(ld_fecha2))

dw.object.nom_empresa.text = str.nombre_empresa
dw.Object.datawindow.print.preview = true



end event

event ue_zoom_down;call super::ue_zoom_down;//Zoom the display area of the datawindow down//

string ls_factor
integer li_factor
m_cc_principal_listados  lm_menu

//get the current zoom//

ls_factor = dw.object.datawindow.print.preview.zoom
li_factor = integer (ls_factor)

//only zoom down if magnification is greater than 20%//

if li_factor >= 40 and li_factor <= 100 then
	li_factor = li_factor -20
else
	//if magnification is currently 200%, zoom down to 100%
	if li_factor = 200 then
		li_factor = 100
	end if
end if

//set the new zoom level//

dw.object.datawindow.print.preview.zoom = li_factor

//check/uncheck the zoom menu items//
lm_menu = this.menuid

lm_menu.m_ventana.m_zoom.m_20%.checked = false
lm_menu.m_ventana.m_zoom.m_40%.checked = false
lm_menu.m_ventana.m_zoom.m_60%.checked = false
lm_menu.m_ventana.m_zoom.m_80%.checked = false
lm_menu.m_ventana.m_zoom.m_100%.checked = false
lm_menu.m_ventana.m_zoom.m_200%.checked = false

choose case li_factor
	case 20
		lm_menu.m_ventana.m_zoom.m_20%.checked = true
	case 40
		lm_menu.m_ventana.m_zoom.m_40%.checked = true
	case 60
		lm_menu.m_ventana.m_zoom.m_60%.checked = true
	case 80
		lm_menu.m_ventana.m_zoom.m_80%.checked = true
	case 100
		lm_menu.m_ventana.m_zoom.m_100%.checked = true
	case 200
		lm_menu.m_ventana.m_zoom.m_200%.checked = true
end choose

end event

type st_ayuda from w_cc_padre_reporte`st_ayuda within w_reporte_antiguedad_inventario
end type

type st_nom_ventana from w_cc_padre_reporte`st_nom_ventana within w_reporte_antiguedad_inventario
boolean visible = false
integer y = 1380
end type

type dw_1 from w_cc_padre_reporte`dw_1 within w_reporte_antiguedad_inventario
integer x = 27
integer y = 232
integer width = 4233
integer height = 2060
string dataobject = "dw_antiguedad_inventario_producto_mes"
boolean hsplitscroll = false
end type

event dw_1::sqlpreview;sqlsyntax += lstr_rangfech.cadena

This.SetSqlPreview(sqlsyntax)
end event

event dw_1::clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto, ls_column
integer li_pos 

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if right(ls_objeto,2)='_t' then

	ls_objeto = left(ls_objeto,len(ls_objeto)-2)
	
	if ls_objeto = is_ultima or is_ultima = "" then	//Si es la misma columna 
																	// o si es la primera vez
		if is_orden  = "" or is_orden = "D" then
			is_orden = 'A'		
			this.SetSort(ls_objeto+" A")	//Ordena Ascendente
			this.sort()		
		else
			is_orden = 'D'					
			this.SetSort(ls_objeto+" D")	//Ordena Descendente
			this.sort()				
		end if	
		is_ultima = ls_objeto		
	else				
			is_orden = 'A'
			this.SetSort(ls_objeto+" A")
			this.sort()
			is_ultima = ls_objeto
	end if

end if
ls_column = dwo.name
if ls_column = "movi_documento" then
	
	if row = 0 then return
	
	str_secuencia_doc lstr_sec
	lstr_sec.ano = dw_1.getitemNumber(row,"movi_anno")
	lstr_sec.sec_manual = dw_1.getitemstring(row,"movi_documento")
	lstr_sec.tran	= dw_1.getitemstring(row,"movi_tipo_transaccion")
	lstr_sec.subtran	= dw_1.getitemstring(row,"movi_sub_transaccion")	
	opensheetwithparm(w_consulta_transacciones, lstr_sec,str.frame,2,original!)
	
elseif ls_column = 'dgmterce_terc_descripcion' then
	str_cc_formatos str_formato1		
	str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	str_formato1.tercero = dw_1.getitemNumber(row,"cctmovim_movi_tercero")
	Opensheetwithparm(w_estadocuenta,str_formato1,str.frame,2,original!)
	
end if
end event

event dw_1::ue_microayuda;//return
end event

type gb_1 from w_cc_padre_reporte`gb_1 within w_reporte_antiguedad_inventario
integer x = 41
integer y = 192
integer width = 4247
integer height = 2072
long backcolor = 12639424
end type

type em_1 from editmask within w_reporte_antiguedad_inventario
event ue_key pbm_keydown
event ue_postkey ( )
integer x = 1861
integer y = 52
integer width = 443
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean spin = true
end type

event ue_key;
this.PostEvent("ue_postKey")
end event

event ue_postkey;string ls_mes, ls_ano
//Date 		ldt_fecha_ini,ldt_fecha_fin
//Integer	li_anio,li_mes
//
//ls_mes = string(month(date(em_1.text)))
//ls_ano = string(year(date(em_1.text)))
//
//ldt_fecha_ini = date(em_1.text)
//li_anio = year(ldt_fecha_ini)
//li_mes  = month(ldt_fecha_fin)
//
//gf_fecha_ini_fecha_fin(li_mes,li_anio,ldt_fecha_ini,ldt_fecha_fin)
//
//em_1.text = string(ldt_fecha_ini)
//em_2.text = String(ldt_fecha_fin)
//


//em_2.text = string(gf_last_day(integer(ls_mes),integer(ls_ano))) + "/" + string(ls_mes) + "/" + string(ls_ano)

end event

event losefocus;Date 		ldt_fecha_ini,ldt_fecha_fin
Integer	li_anio,li_mes

ldt_fecha_ini = date(em_1.text)
li_anio = year(ldt_fecha_ini)
li_mes  = month(ldt_fecha_ini)

//gf_fecha_ini_fecha_fin(li_mes,li_anio,ldt_fecha_ini,ldt_fecha_fin)

//em_1.text = string(ldt_fecha_ini)
//em_2.text = String(ldt_fecha_fin)

end event

type em_2 from editmask within w_reporte_antiguedad_inventario
boolean visible = false
integer x = 1125
integer y = 64
integer width = 443
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean spin = true
end type

event losefocus;If date(em_2.text) < date(em_1.text) Then
	mensaje("Aviso ","La fecha hasta es incorrecta.. Verifique ...!!","")
	em_1.Setfocus()
	return
End If
end event

type st_2 from statictext within w_reporte_antiguedad_inventario
boolean visible = false
integer x = 869
integer y = 64
integer width = 247
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
boolean enabled = false
string text = "Hasta :"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_1 from statictext within w_reporte_antiguedad_inventario
integer x = 1605
integer y = 52
integer width = 247
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 8421376
boolean enabled = false
string text = "Fecha :"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_generar from commandbutton within w_reporte_antiguedad_inventario
integer x = 2702
integer y = 32
integer width = 402
integer height = 104
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Consultar"
end type

event clicked;datetime ldt_fecha

ldt_fecha = datetime(date(em_1.text), time('23:59:59'))

setpointer(HourGlass!)

delete from inhprome		
 where   prom_g_financiero = :str.g_financiero and   
         prom_empresa = :str.empresa and
		prom_maquina = :str.maquina ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Eliminar '+sqlca.sqlerrtext,1,1,'E')
		end if
DECLARE sp_in_proc_costo_promedio_p1 PROCEDURE FOR sp_in_proc_costo_promedio_p1 
         @p_gf = :str.g_financiero,   
         @p_emp = :str.empresa,   
         @maquina = :str.maquina,   
         @p_fecha_i = :ldt_fecha  ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Declarar Procedimiento '+sqlca.sqlerrtext,1,1,'E')
		end if
str.frame.setmicrohelp('Procesando las Existencias a la fecha seleccionada....')

execute sp_in_proc_costo_promedio_p1 ;

if sqlca.sqlcode = -1 then
	gf_mensaje('','Error al Procesar '+sqlca.sqlerrtext,1,1,'E')
	return
end if

close sp_in_proc_costo_promedio_p1;
str.frame.setmicrohelp('Listo')
dw.object.nom_empresa.text = str.nombre_empresa
dw_1.retrieve(str.g_financiero, str.empresa, str.maquina)
dw.Object.datawindow.print.preview = true
dw_1.Object.DataWindow.Zoom = 95
dw_1.object.t_fecha.text='Análisis de Antiguedad de Inventario al '+string(date(ldt_fecha))

setpointer(Arrow!)
end event

type cb_2 from commandbutton within w_reporte_antiguedad_inventario
integer x = 3141
integer y = 32
integer width = 402
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Cerrar"
end type

event clicked;parent.triggerevent('close')
end event

type calendario from picture within w_reporte_antiguedad_inventario
integer x = 2304
integer y = 52
integer width = 69
integer height = 80
boolean bringtotop = true
string picturename = "C:\Sistemas\Hymsoft\Art\ddfec.bmp"
boolean focusrectangle = false
end type

event clicked;date 	ld_date,ld_ini_date, ld_hoy
//parent.height = 1144
	
	ld_ini_date=date(em_1.text)
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

end event

type calendario2 from picture within w_reporte_antiguedad_inventario
boolean visible = false
integer x = 1568
integer y = 64
integer width = 69
integer height = 80
boolean bringtotop = true
string picturename = "C:\Sistemas\Hymsoft\Art\ddfec.bmp"
boolean focusrectangle = false
end type

event clicked;date 	ld_date,ld_ini_date, ld_hoy
//parent.height = 1144
	
	ld_ini_date=date(em_2.text)
	if year(ld_ini_date) = 1900 then
		ld_ini_date = ld_hoy
	end if
	if uo_2.visible=false then
		uo_2.wf_set_value(ld_ini_date)
		uo_2.visible=true
		uo_2.allow_close=false
		uo_2.inicializar()
		uo_2.TriggerEvent('ue_abrir')
	end if

end event

type uo_1 from u_ddcalen within w_reporte_antiguedad_inventario
boolean visible = false
integer x = 1650
integer y = 128
integer taborder = 70
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;em_1.text = string(uo_1.return_sel_date())

if uo_1.allow_close then
	this.visible=false
	em_1.SetFocus()
//	parent.height = 640
end if


end event

on uo_1.destroy
call u_ddcalen::destroy
end on

type uo_2 from u_ddcalen within w_reporte_antiguedad_inventario
boolean visible = false
integer x = 910
integer y = 148
integer taborder = 80
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;em_2.text = string(uo_2.return_sel_date())

if uo_2.allow_close then
	this.visible=false
	em_2.SetFocus()
//	parent.height = 640
end if


end event

on uo_2.destroy
call u_ddcalen::destroy
end on

type cbx_1 from checkbox within w_reporte_antiguedad_inventario
boolean visible = false
integer x = 1655
integer y = 68
integer width = 443
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Para Bodega"
end type

event clicked;datawindowchild ldwc_prov
string ls_empresa
if this.checked then
	dw_1.dataobject = 'dw_informe_entradas_bodega'
else
		dw_1.dataobject = 'dw_informe_entradas'
end if
dw_1.settransobject(sqlca)

dw_1.getchild('tmov_terceros',ldwc_prov)
ldwc_prov.settransobject(sqlca)
ldwc_prov.retrieve('P')
ldwc_prov.insertrow(1)

ls_empresa = gf_dg_nombre_empresa()
dw.object.empresanom.expression = "'"+ls_empresa+"'"
dw.Object.datawindow.print.preview = true

cb_generar.triggerevent('clicked')



end event

type st_3 from statictext within w_reporte_antiguedad_inventario
boolean visible = false
integer x = 1687
integer y = 96
integer width = 242
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Ajuste: "
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_reporte_antiguedad_inventario
boolean visible = false
integer x = 2153
integer y = 172
integer width = 425
integer height = 92
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_entrada"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;dw_2.accepttext()
long ll_entrada

ll_entrada = long(data)

if ll_entrada = 0 or isnull(ll_entrada) then
	dw_1.setfilter('')
else
	dw_1.setfilter('tmov_secuencia = '+string(ll_entrada))
	dw_1.modify('tmov_terceros.visible=false')	
end if
dw_1.filter()
dw_1.groupcalc()

end event

type dw_3 from datawindow within w_reporte_antiguedad_inventario
boolean visible = false
integer x = 2469
integer y = 152
integer width = 1056
integer height = 100
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_proveedor"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;long ll_proveedor

ll_proveedor = long(data)

if ll_proveedor = 0 or isnull(ll_proveedor) then
	dw_1.setfilter('')
	dw_1.modify('tmov_terceros.visible=false')	
else
	dw_1.setfilter('tmov_terceros = '+string(ll_proveedor))
	dw_1.modify('tmov_terceros.visible=true')
end if
dw_1.filter()
dw_1.groupcalc()

end event

type rb_mensual from radiobutton within w_reporte_antiguedad_inventario
integer x = 155
integer y = 72
integer width = 430
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Mensual"
boolean checked = true
end type

event clicked;if this.checked then 
	dw_1.dataobject = 'dw_antiguedad_inventario_producto_mes'
	rb_anual.checked= false
	rb_division.checked= false
end if

dw_1.settransobject(sqlca);
end event

type rb_anual from radiobutton within w_reporte_antiguedad_inventario
integer x = 608
integer y = 72
integer width = 384
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Anual"
end type

event clicked;if this.checked = true then 
	rb_mensual.checked= false
	rb_division.checked= false
	dw_1.dataobject = 'dw_antiguedad_inventario_producto_ann'
end if

dw_1.settransobject(sqlca);
end event

type rb_division from radiobutton within w_reporte_antiguedad_inventario
integer x = 1010
integer y = 68
integer width = 389
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Por Division"
end type

event clicked;if this.checked = true then 
	rb_mensual.checked= false
	rb_anual.checked= false
	dw_1.dataobject = 'dw_antiguedad_inventario_por_depto_ok'
end if

dw_1.settransobject(sqlca);
end event

type gb_2 from groupbox within w_reporte_antiguedad_inventario
integer x = 32
integer width = 1504
integer height = 168
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean italic = true
long backcolor = 12639424
string text = "Tipo de Informe"
end type

