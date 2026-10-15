//objectcomments Ventana padre de las ventanas de rango fecha
forward
global type w_cc_padre_rango_fecha from w_cc_padre
end type
type p_1 from picture within w_cc_padre_rango_fecha
end type
type em_2 from editmask within w_cc_padre_rango_fecha
end type
type st_2 from statictext within w_cc_padre_rango_fecha
end type
type em_1 from editmask within w_cc_padre_rango_fecha
end type
type st_1 from statictext within w_cc_padre_rango_fecha
end type
type gb_1 from groupbox within w_cc_padre_rango_fecha
end type
type st_7 from statictext within w_cc_padre_rango_fecha
end type
type cb_1 from commandbutton within w_cc_padre_rango_fecha
end type
type pb_1 from picturebutton within w_cc_padre_rango_fecha
end type
type pb_2 from picturebutton within w_cc_padre_rango_fecha
end type
end forward

global type w_cc_padre_rango_fecha from w_cc_padre
integer width = 1979
integer height = 612
string menuname = ""
event ue_vistaprevia ( )
p_1 p_1
em_2 em_2
st_2 st_2
em_1 em_1
st_1 st_1
gb_1 gb_1
st_7 st_7
cb_1 cb_1
pb_1 pb_1
pb_2 pb_2
end type
global w_cc_padre_rango_fecha w_cc_padre_rango_fecha

type variables

end variables

event ue_vistaprevia;call super::ue_vistaprevia;//str_rangofecha lstr_rangfech
//
//If isDate(em_1.text) then
//	If isDate(em_2.text) then
//	
//		lstr_rangfech.fecha1 = date(em_1.text)
//		lstr_rangfech.fecha2 = date(em_2.text)
//	
//		OpenSheetWithParm(w_inf_cc_movmes,lstr_rangfech,this,1,Original!)
//	
//	
//	Else
//		Mensaje("Aviso","La fecha HASTA es Invalida","Cersiorese de que la fecha esta en el formato valido DIA/MES/AÑO")
//	End If
//Else
//	Mensaje("Aviso","La fecha DESDE es Invalida","Cersiorese de que la fecha esta en el formato valido DIA/MES/AÑO")
//End IF	
////copiarlo identico solo cambiar la ventana y el menu
//
end event

on w_cc_padre_rango_fecha.create
int iCurrent
call super::create
this.p_1=create p_1
this.em_2=create em_2
this.st_2=create st_2
this.em_1=create em_1
this.st_1=create st_1
this.gb_1=create gb_1
this.st_7=create st_7
this.cb_1=create cb_1
this.pb_1=create pb_1
this.pb_2=create pb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_1
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.st_7
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.pb_1
this.Control[iCurrent+10]=this.pb_2
end on

on w_cc_padre_rango_fecha.destroy
call super::destroy
destroy(this.p_1)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.st_7)
destroy(this.cb_1)
destroy(this.pb_1)
destroy(this.pb_2)
end on

event open;//Override
sqlca.autocommit = true
integer li_mes, li_ano

gf_center_win(This)
gf_acelerador()
dw = dw_1

This.Icon = str.icono

this.postevent("ue_post_open")


This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)
str.frame.SetRedraw ( True )

//li_mes = w_cc_fondo.str_para.mes
//li_ano = w_cc_fondo.str_para.ano

em_1.text = string(01)+ "/" +string(li_mes)+ "/" +string(li_ano - 1)
em_2.text =  string(gf_last_day(li_mes,li_ano))+ "/" +string(li_mes)+ "/" +string(li_ano)




end event

event key;If Key = keyEscape! then close(this)

end event

event ue_post_open;call super::ue_post_open;Date 		ldt_fecha_ini,ldt_fecha_fin
Integer	li_anio,li_mes

ldt_fecha_ini = Date(gf_fecha_serv())
li_anio = year(ldt_fecha_ini)
li_mes  = month(ldt_fecha_ini)

gf_fecha_ini_fecha_fin(li_mes,li_anio,ldt_fecha_ini,ldt_fecha_fin)

em_1.text = string(ldt_fecha_ini)
em_2.text = String(ldt_fecha_fin)


end event

type st_nom_ventana from w_cc_padre`st_nom_ventana within w_cc_padre_rango_fecha
integer y = 448
end type

type dw_1 from w_cc_padre`dw_1 within w_cc_padre_rango_fecha
boolean visible = false
integer width = 997
integer height = 248
integer taborder = 60
boolean enabled = false
end type

type p_1 from picture within w_cc_padre_rango_fecha
integer x = 32
integer y = 24
integer width = 201
integer height = 160
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type em_2 from editmask within w_cc_padre_rango_fecha
integer x = 1499
integer y = 120
integer width = 379
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
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

type st_2 from statictext within w_cc_padre_rango_fecha
integer x = 1143
integer y = 120
integer width = 247
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 78682240
boolean enabled = false
string text = "Hasta :"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_1 from editmask within w_cc_padre_rango_fecha
event ue_key pbm_keydown
event ue_postkey ( )
integer x = 663
integer y = 120
integer width = 379
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

type st_1 from statictext within w_cc_padre_rango_fecha
integer x = 302
integer y = 120
integer width = 247
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 78682240
boolean enabled = false
string text = "Desde :"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_cc_padre_rango_fecha
integer x = 251
integer y = 24
integer width = 1687
integer height = 388
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Rango fecha"
borderstyle borderstyle = stylelowered!
end type

type st_7 from statictext within w_cc_padre_rango_fecha
integer x = 891
integer y = 260
integer width = 407
integer height = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
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

type cb_1 from commandbutton within w_cc_padre_rango_fecha
event mousemove pbm_nchittest
integer x = 901
integer y = 268
integer width = 389
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar"
boolean default = true
end type

event clicked;Parent.TriggerEvent("ue_vistaprevia")
end event

type pb_1 from picturebutton within w_cc_padre_rango_fecha
boolean visible = false
integer x = 32
integer y = 340
integer width = 96
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
boolean originalsize = true
alignment htextalign = left!
end type

type pb_2 from picturebutton within w_cc_padre_rango_fecha
boolean visible = false
integer x = 32
integer y = 340
integer width = 96
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
boolean originalsize = true
alignment htextalign = left!
end type

