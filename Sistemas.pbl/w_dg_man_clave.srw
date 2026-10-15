//objectcomments Para la Validación de la Clave del Usuario
forward
global type w_dg_man_clave from w_fa_padre
end type
type gb_1 from groupbox within w_dg_man_clave
end type
type st_1 from statictext within w_dg_man_clave
end type
type sle_clave from singlelineedit within w_dg_man_clave
end type
type cb_1 from commandbutton within w_dg_man_clave
end type
type cb_2 from commandbutton within w_dg_man_clave
end type
type st_2 from statictext within w_dg_man_clave
end type
type em_user from editmask within w_dg_man_clave
end type
end forward

global type w_dg_man_clave from w_fa_padre
integer width = 1019
integer height = 624
string title = "[FA]  Control de Modificaciones"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event ue_postopen ( )
gb_1 gb_1
st_1 st_1
sle_clave sle_clave
cb_1 cb_1
cb_2 cb_2
st_2 st_2
em_user em_user
end type
global w_dg_man_clave w_dg_man_clave

type variables
String	is_autoriza_s_n
end variables

event ue_postopen;//io_encryptor = Create nv_encryptor
//io_encryptor.of_setkey("ReMe")

//iw_window = message.PowerObjectParm
is_autoriza_s_n = message.StringParm
em_user.Setfocus()

this.Setredraw(true)
end event

event open;call super::open;this.Setredraw(false)
gf_center_win(this)
this.postevent("ue_postopen")
end event

on w_dg_man_clave.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.st_1=create st_1
this.sle_clave=create sle_clave
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.em_user=create em_user
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.sle_clave
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.em_user
end on

on w_dg_man_clave.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.sle_clave)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.em_user)
end on

event key;//Override

end event

event closequery;call super::closequery;//Override

end event

event close;/*Primero se ejecuta el closeaquery y luego el close*/
CloseWithReturn(this,is_autoriza_s_n)

end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_dg_man_clave
boolean visible = false
integer x = 18
integer y = 560
end type

type dw_1 from w_fa_padre`dw_1 within w_dg_man_clave
boolean visible = false
integer x = 78
integer y = 136
integer width = 69
integer height = 36
integer taborder = 0
end type

type gb_1 from groupbox within w_dg_man_clave
integer x = 14
integer y = 16
integer width = 978
integer height = 504
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 15780518
string text = "Introduzca la Clave de Autorización"
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_dg_man_clave
integer x = 146
integer y = 220
integer width = 297
integer height = 80
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Calisto MT"
long textcolor = 8388608
long backcolor = 15780518
boolean enabled = false
string text = "Clave:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_clave from singlelineedit within w_dg_man_clave
integer x = 494
integer y = 228
integer width = 343
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_dg_man_clave
integer x = 151
integer y = 336
integer width = 311
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Aceptar"
boolean default = true
end type

event clicked;Integer	li_autoriza_s_n
If isNull(sle_clave.text) then
	messagebox('Atención ','Digite su clave')
	return
end if

If isNull(em_user.text) then
	messagebox('Atención ','Digite su código de usuario')
	return
end if

em_user.text =upper(em_user.text)
sle_clave.text = lower(sle_clave.text)

gf_controla_modificaciones(li_autoriza_s_n,em_user.text,sle_clave.text)

is_autoriza_s_n = string(li_autoriza_s_n)

CHOOSE CASE is_autoriza_s_n
CASE '1'	//Usuario Autorizado
	CloseWithReturn(parent,is_autoriza_s_n)
CASE '2'	//Usuario no Autorizado
	messagebox('Atención ','Estimado Usuario Ud. no está autorizado para Modificar Facturas, consulte a su Supervisor...!!!')
	return
CASE ELSE
	messagebox('Atención ','Error al validar autorización')
	CloseWithReturn(parent,is_autoriza_s_n)
	return
END CHOOSE

end event

type cb_2 from commandbutton within w_dg_man_clave
integer x = 517
integer y = 336
integer width = 302
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Cancelar"
end type

event clicked;is_autoriza_s_n = '0'

CloseWithReturn(parent,is_autoriza_s_n)

end event

type st_2 from statictext within w_dg_man_clave
integer x = 78
integer y = 100
integer width = 370
integer height = 76
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Calisto MT"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "Usuario:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_user from editmask within w_dg_man_clave
integer x = 494
integer y = 112
integer width = 343
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "xxxxx"
end type

event losefocus;sle_clave.setfocus()

end event

