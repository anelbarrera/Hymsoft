forward
global type w_estado_cta_cxp from window
end type
type sle_codigo from singlelineedit within w_estado_cta_cxp
end type
type cb_2 from commandbutton within w_estado_cta_cxp
end type
type cb_1 from commandbutton within w_estado_cta_cxp
end type
type pb_1 from picturebutton within w_estado_cta_cxp
end type
type dw_1 from datawindow within w_estado_cta_cxp
end type
type st_3 from statictext within w_estado_cta_cxp
end type
type em_fecha2 from editmask within w_estado_cta_cxp
end type
type st_2 from statictext within w_estado_cta_cxp
end type
type st_1 from statictext within w_estado_cta_cxp
end type
type em_fecha1 from editmask within w_estado_cta_cxp
end type
type gb_1 from groupbox within w_estado_cta_cxp
end type
end forward

global type w_estado_cta_cxp from window
integer width = 2208
integer height = 996
boolean titlebar = true
string title = "Estado de Cuenta Proveedores"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 8421376
event ue_key pbm_keydown
sle_codigo sle_codigo
cb_2 cb_2
cb_1 cb_1
pb_1 pb_1
dw_1 dw_1
st_3 st_3
em_fecha2 em_fecha2
st_2 st_2
st_1 st_1
em_fecha1 em_fecha1
gb_1 gb_1
end type
global w_estado_cta_cxp w_estado_cta_cxp

type variables
datawindowchild ldwc_prov
end variables

event ue_key;if Key = KeyEscape! then
	this.postevent('close')
end if
end event

on w_estado_cta_cxp.create
this.sle_codigo=create sle_codigo
this.cb_2=create cb_2
this.cb_1=create cb_1
this.pb_1=create pb_1
this.dw_1=create dw_1
this.st_3=create st_3
this.em_fecha2=create em_fecha2
this.st_2=create st_2
this.st_1=create st_1
this.em_fecha1=create em_fecha1
this.gb_1=create gb_1
this.Control[]={this.sle_codigo,&
this.cb_2,&
this.cb_1,&
this.pb_1,&
this.dw_1,&
this.st_3,&
this.em_fecha2,&
this.st_2,&
this.st_1,&
this.em_fecha1,&
this.gb_1}
end on

on w_estado_cta_cxp.destroy
destroy(this.sle_codigo)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.pb_1)
destroy(this.dw_1)
destroy(this.st_3)
destroy(this.em_fecha2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_fecha1)
destroy(this.gb_1)
end on

event open;
gf_center_win(this)
dw_1.settransobject( sqlca)
em_fecha1.text = '01/01/'+string(year(date(gf_fecha_serv())))
em_fecha2.text = string(date(gf_fecha_serv()))

dw_1.getchild('proveedor',ldwc_prov)
ldwc_prov.settransobject(sqlca)
ldwc_prov.retrieve(str.g_financiero, str.empresa)
ldwc_prov.insertrow(1)
ldwc_prov.setitem(1,'terc_tercero',0)
dw_1.insertrow(1)
dw_1.setfocus()
sle_codigo.setfocus()
end event

event close;close(this)
end event

type sle_codigo from singlelineedit within w_estado_cta_cxp
integer x = 389
integer y = 352
integer width = 270
integer height = 112
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;string ls_find, ls_null
integer li_encontro
long ll_tercero
setnull(ls_null)
li_encontro = ldwc_prov.find('prov_cod_proveedor = "'+sle_codigo.text+'"',1,ldwc_prov.rowcount())

if li_encontro > 0 then
	ll_tercero = ldwc_prov.getitemnumber(li_encontro,'terc_tercero')
	dw_1.setitem(1,'proveedor',ll_tercero)
else
	sle_codigo.text = ''
	dw_1.setitem(1,'proveedor',0)	
end if
end event

type cb_2 from commandbutton within w_estado_cta_cxp
integer x = 1198
integer y = 688
integer width = 379
integer height = 104
integer taborder = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_estado_cta_cxp
integer x = 672
integer y = 688
integer width = 379
integer height = 104
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;long ll_tercero
date fecha, fecha1
		ll_tercero = dw_1.getitemnumber(dw_1.getrow(),'proveedor')
		fecha = date(em_fecha1.text)
		fecha1 = date(em_fecha2.text)
		
	str_rangofecha str_formato1		
	str_formato1.codigo = ll_tercero
	str_formato1.fecha1  = fecha
	str_formato1.fecha2  = fecha1
	Opensheetwithparm(w_estadocuenta_imp_cxp,str_formato1,str.frame,2,layered!)

end event

type pb_1 from picturebutton within w_estado_cta_cxp
integer x = 1906
integer y = 360
integer width = 110
integer height = 96
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Sistemas\Hymsoft\Art\BLIND.bmp"
end type

event clicked;	str_dg_dynamic_find	lstr_df
	string ls_find, ls_codigo1
	
		lstr_df.texto_campo [1,1] = "cpmprove.prov_cod_proveedor" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [1,2] = "Cuenta"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '350'
		lstr_df.texto_campo [2,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [2,2] = "Descripción"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '700'		
		lstr_df.texto_campo [3,1] = "dgmterce.terc_tercero"
		lstr_df.texto_campo [3,2] = "Secuencial"
		lstr_df.texto_campo [3,3] = "terc_tercero"
		lstr_df.texto_campo [3,4] = 'V'
		
		lstr_df.tabla = " dgmterce, cpmprove "	
		
		lstr_df.tabla_where = &
					"WHERE (cpmprove.prov_g_financiero = " + string(str.g_financiero) + " and " +&
							 "cpmprove.prov_empresa = " + string(str.empresa) + ") 	and " +&
							"(dgmterce.terc_tercero = cpmprove.prov_tercero) and " +&
					      "(cpmprove.prov_estado = 'A' ) "
		
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	If len (ls_find) = 0 Then Return		
		
	ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	//gf_replace_cadena(ls_codigo1,"'"," ")
	ls_codigo1 = Trim(ls_codigo1)

	dw_1.setitem(1,'proveedor',long(ls_codigo1))
	dw_1.accepttext()
	dw_1.setcolumn('proveedor')
	dw_1.trigger event itemchanged(1,dw_1.object,ls_codigo1)	
end event

type dw_1 from datawindow within w_estado_cta_cxp
integer x = 677
integer y = 352
integer width = 1207
integer height = 112
integer taborder = 50
string title = "none"
string dataobject = "dw_proveedor_external"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_codigo
ls_codigo = ldwc_prov.getitemstring(ldwc_prov.getrow(),'prov_cod_proveedor')
sle_codigo.text = ls_codigo
end event

type st_3 from statictext within w_estado_cta_cxp
integer x = 55
integer y = 376
integer width = 366
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
string text = "Proveedor:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fecha2 from editmask within w_estado_cta_cxp
integer x = 1257
integer y = 208
integer width = 393
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_2 from statictext within w_estado_cta_cxp
integer x = 1047
integer y = 216
integer width = 233
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
string text = "Hasta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_estado_cta_cxp
integer x = 352
integer y = 220
integer width = 233
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
string text = "Desde:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fecha1 from editmask within w_estado_cta_cxp
integer x = 585
integer y = 208
integer width = 393
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type gb_1 from groupbox within w_estado_cta_cxp
integer x = 37
integer y = 92
integer width = 2085
integer height = 532
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
string text = "Rango de Fechas"
borderstyle borderstyle = stylelowered!
end type

