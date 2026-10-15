//objectcomments Reporte de Ordene de Compra
forward
global type w_reporte_ordenes from w_cc_padre_reporte
end type
type em_1 from editmask within w_reporte_ordenes
end type
type em_2 from editmask within w_reporte_ordenes
end type
type st_2 from statictext within w_reporte_ordenes
end type
type st_1 from statictext within w_reporte_ordenes
end type
type cb_generar from commandbutton within w_reporte_ordenes
end type
type cb_2 from commandbutton within w_reporte_ordenes
end type
type calendario from picture within w_reporte_ordenes
end type
type calendario2 from picture within w_reporte_ordenes
end type
type uo_1 from u_ddcalen within w_reporte_ordenes
end type
type uo_2 from u_ddcalen within w_reporte_ordenes
end type
type cbx_1 from checkbox within w_reporte_ordenes
end type
type st_3 from statictext within w_reporte_ordenes
end type
type dw_2 from datawindow within w_reporte_ordenes
end type
type st_4 from statictext within w_reporte_ordenes
end type
type dw_3 from datawindow within w_reporte_ordenes
end type
type cbx_2 from checkbox within w_reporte_ordenes
end type
type cbx_pendientes from checkbox within w_reporte_ordenes
end type
type cb_eliminar from commandbutton within w_reporte_ordenes
end type
end forward

global type w_reporte_ordenes from w_cc_padre_reporte
integer width = 5042
integer height = 2800
string title = "Informe de Ordenes"
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
st_4 st_4
dw_3 dw_3
cbx_2 cbx_2
cbx_pendientes cbx_pendientes
cb_eliminar cb_eliminar
end type
global w_reporte_ordenes w_reporte_ordenes

type variables
str_rangofecha lstr_rangfech
end variables

on w_reporte_ordenes.create
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
this.st_4=create st_4
this.dw_3=create dw_3
this.cbx_2=create cbx_2
this.cbx_pendientes=create cbx_pendientes
this.cb_eliminar=create cb_eliminar
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
this.Control[iCurrent+14]=this.st_4
this.Control[iCurrent+15]=this.dw_3
this.Control[iCurrent+16]=this.cbx_2
this.Control[iCurrent+17]=this.cbx_pendientes
this.Control[iCurrent+18]=this.cb_eliminar
end on

on w_reporte_ordenes.destroy
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
destroy(this.st_4)
destroy(this.dw_3)
destroy(this.cbx_2)
destroy(this.cbx_pendientes)
destroy(this.cb_eliminar)
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

em_1.text = string( relativedate( date(ld_fecha1) ,-360)) // '01/'+string(month(date(ld_fecha1)))+'/'+string(year(date(ld_fecha1)))
em_2.text = string(date(ld_fecha2))

ls_empresa = gf_dg_nombre_empresa()
dw.object.nom_empresa.expression = "'"+ls_empresa+"'"
dw.Object.datawindow.print.preview = true

dw_3.getchild('proveedor',ldwc_prov)
ldwc_prov.settransobject(sqlca)
ldwc_prov.retrieve(str.g_financiero, str.empresa)
ldwc_prov.insertrow(1)
dw_3.settransobject(sqlca)
dw_3.insertrow(1)

dw_2.settransobject(sqlca)
dw_2.insertrow(1)

str.frame.setredraw(true)		

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

event open;call super::open;this.y = 0
this.x = 805
end event

type st_ayuda from w_cc_padre_reporte`st_ayuda within w_reporte_ordenes
end type

type st_nom_ventana from w_cc_padre_reporte`st_nom_ventana within w_reporte_ordenes
boolean visible = false
integer y = 1380
end type

type dw_1 from w_cc_padre_reporte`dw_1 within w_reporte_ordenes
integer x = 5
integer y = 308
integer width = 4919
integer height = 2256
string dataobject = "dw_reporte_ordenes"
boolean hscrollbar = false
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

event dw_1::ue_microayuda;////override
////Para cuando pasa por encima del objeto
////Override
//
//Integer li_pos, li_x, li_y,li_largo
//String ls_objeto, ls_col
//
//ls_objeto = This.GetObjectAtPointer()
//li_pos = pos  (ls_objeto,"~t")
//ls_col = left (ls_objeto, li_pos - 1)
//
////li_x	 = str.frame.GetActiveSheet ().PointerX () 
////li_largo = len("Haga click para ordenar por la Columna de " + this.describe(ls_col+".text"))*28
//
//
////li_y	 = str.frame.GetActiveSheet ().PointerY () - 200
//
//// Dependiendo de la Columna el Mensaje de Ayuda varía
//CHOOSE CASE ls_col
//	CASE 'movi_documento'
//		this.Modify("movi_documento.Font.Underline='1'")
//		this.Modify("movi_documento.Color='7536640'")
//	CASE 'dgmterce_terc_descripcion'
//		this.Modify("dgmterce_terc_descripcion.Font.Underline='1'")
//		this.Modify("dgmterce_terc_descripcion.Color='7536640'")
//	CASE ELSE
//		this.Modify("movi_documento.Font.Underline='0'")
//		this.Modify("movi_documento.Color='0'")
//		this.Modify("dgmterce_terc_descripcion.Font.Underline='0'")
//		this.Modify("dgmterce_terc_descripcion.Color='0'")
//
//END CHOOSE
end event

type gb_1 from w_cc_padre_reporte`gb_1 within w_reporte_ordenes
integer y = 248
integer width = 4969
integer height = 2340
long backcolor = 12639424
end type

type em_1 from editmask within w_reporte_ordenes
event ue_key pbm_keydown
event ue_postkey ( )
integer x = 288
integer y = 64
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

type em_2 from editmask within w_reporte_ordenes
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

type st_2 from statictext within w_reporte_ordenes
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

type st_1 from statictext within w_reporte_ordenes
integer x = 32
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
long textcolor = 15793151
long backcolor = 8421376
boolean enabled = false
string text = "Desde :"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_generar from commandbutton within w_reporte_ordenes
integer x = 2135
integer y = 36
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
boolean default = true
end type

event clicked;String   ls_wherem, ls_transaccion, ls_empresa
Long 		ll_filas, ll_entrada, ll_proveedor
dw_2.accepttext()
If isDate(em_1.text) then
	If isDate(em_2.text) then
		If date(em_1.text) <= date(em_2.text) Then
			lstr_rangfech.fecha1 = date(em_1.text)
			lstr_rangfech.fecha2 = date(em_2.text)
			ls_empresa = gf_dg_nombre_empresa()
			dw_1.retrieve(str.g_financiero, str.empresa, lstr_rangfech.fecha1, lstr_rangfech.fecha2)			
			dw_1.object.rango_fecha.expression = "'"+"Desde el " +gf_fecha_palabras(lstr_rangfech.fecha1)+" al "+gf_fecha_palabras(lstr_rangfech.fecha2)+"'"			
			dw_1.object.nom_empresa.expression = "'"+ls_empresa+"'"			
			dw.Object.datawindow.print.preview = true
			ll_entrada = dw_2.getitemnumber(1, 'entrada')
			if ll_entrada > 0 and not isnull(ll_entrada) then
				dw_1.setfilter('orden_enca_secuencia = "'+string(ll_entrada)+'"')
				dw_1.filter()
				dw_1.groupcalc()
			end if
			ll_proveedor = dw_3.getitemnumber(1,'proveedor')	
			if ll_proveedor > 0 and not isnull(ll_proveedor) then
				dw_1.setfilter('orden_enca_proveedor = '+string(ll_proveedor))
				dw_1.filter()
				dw_1.groupcalc()			
			end if
		Else
			gf_Mensaje("Aviso","La fecha DESDE es Invalida, Verifique de que la fecha no es mayor que la fecha HASTA",1,1,'E')
		End If
		
	Else
		gf_Mensaje("Aviso","La fecha HASTA es Invalida, Verifique de que la fecha esta en el formato valido DIA/MES/AÑO",1,1,'E')
	End If
Else
	gf_Mensaje("Aviso","La fecha DESDE es Invalida, Verifique de que la fecha esta en el formato valido DIA/MES/AÑO",1,1,'E')
End IF	


end event

type cb_2 from commandbutton within w_reporte_ordenes
integer x = 2574
integer y = 36
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

type calendario from picture within w_reporte_ordenes
integer x = 731
integer y = 64
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

type calendario2 from picture within w_reporte_ordenes
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

type uo_1 from u_ddcalen within w_reporte_ordenes
boolean visible = false
integer x = 78
integer y = 144
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

type uo_2 from u_ddcalen within w_reporte_ordenes
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

type cbx_1 from checkbox within w_reporte_ordenes
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

type st_3 from statictext within w_reporte_ordenes
integer x = 1463
integer y = 180
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
string text = "Orden: "
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_reporte_ordenes
integer x = 1701
integer y = 156
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
	dw_1.setfilter('orden_enca_secuencia  = "'+string(ll_entrada)+'"')
end if
dw_1.filter()
dw_1.groupcalc()

end event

type st_4 from statictext within w_reporte_ordenes
integer x = 2162
integer y = 172
integer width = 297
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Proveedor:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_reporte_ordenes
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
else
	dw_1.setfilter('orden_enca_proveedor = '+string(ll_proveedor))
end if
dw_1.filter()
dw_1.groupcalc()

end event

type cbx_2 from checkbox within w_reporte_ordenes
integer x = 41
integer y = 176
integer width = 421
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Resumido"
end type

event clicked;if this.checked then
	dw_1.dataobject = 'dw_reporte_ordenes_resumen'		
else
	dw_1.dataobject = 'dw_reporte_ordenes'
end if

dw_1.settransobject(sqlca)
cb_generar.triggerevent('clicked')
end event

type cbx_pendientes from checkbox within w_reporte_ordenes
integer x = 3607
integer y = 164
integer width = 640
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Ver Sólo Pendientes"
end type

event clicked;long ll_proveedor
string ls_cadena
ls_cadena = ''
ll_proveedor = dw_3.getitemnumber(1,'proveedor')

if cbx_2.checked then return

if ll_proveedor > 0 and not isnull(ll_proveedor) then
	ls_cadena = 'orden_enca_proveedor = '+string(ll_proveedor)
end if

if len(ls_cadena) > 0 then
	if this.checked then
		ls_cadena = ls_cadena + ' and pendiente > 0'
	end if
else
	if this.checked then
		ls_cadena = 'pendiente > 0'
	end if
end if
dw_1.setfilter(ls_cadena)
dw_1.filter()
dw_1.groupcalc()
dw.Object.datawindow.print.preview = false

end event

type cb_eliminar from commandbutton within w_reporte_ordenes
integer x = 4279
integer y = 152
integer width = 695
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Eliminar Pendientes"
end type

event clicked;if gf_mensaje('','Esta Seguro de Eliminar los Pendientes de las Ordenes ?',2,1,'E') = 2 then return

integer i, li_ann, li_linea
string ls_oc, ls_referencia
decimal ld_cantidad, ld_medi_cantidad, ld_pasada

for i =  1 to dw_1.rowcount()
	if dw_1.getitemnumber(i,'eliminar') = 1 then
		ls_oc = dw_1.getitemstring(i,'orden_enca_secuencia')
		li_ann= dw_1.getitemnumber(i,'orden_enca_ann')
		li_linea = dw_1.getitemnumber(i,'orden_detalle_deta_linea')
		ld_cantidad = dw_1.getitemnumber(i,'orden_detalle_deta_cantidad')
		ld_medi_cantidad = dw_1.getitemnumber(i,'medi_cantidad')
		ld_pasada  = round(ld_cantidad * ld_medi_cantidad,2)
		
		  UPDATE orden_detalle  
			  SET deta_pasada = :ld_pasada  
			WHERE ( orden_detalle.deta_g_financiero = :str.g_financiero ) AND  
					( orden_detalle.deta_empresa = :str.empresa ) AND  
					( orden_detalle.deta_secuencia = :ls_oc ) AND  
					( orden_detalle.deta_ann = :li_ann ) AND  
					( orden_detalle.deta_linea = :li_linea )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Liberar los Pendientes '+sqlca.sqlerrtext,1,1,'E')
			end if
		
	end if
next
commit;
gf_mensaje('','Eliminacion Exitosa de los Pendientes',1,1,'E')
cb_generar.triggerevent('clicked')
end event

