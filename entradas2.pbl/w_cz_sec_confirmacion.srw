//objectcomments Ventana para secuencia de confirmaciones para el pase
forward
global type w_cz_sec_confirmacion from w_fa_padre
end type
type st_2 from statictext within w_cz_sec_confirmacion
end type
type gb_1 from groupbox within w_cz_sec_confirmacion
end type
type st_1 from statictext within w_cz_sec_confirmacion
end type
type sle_1 from singlelineedit within w_cz_sec_confirmacion
end type
type cb_1 from commandbutton within w_cz_sec_confirmacion
end type
type cb_2 from commandbutton within w_cz_sec_confirmacion
end type
type p_1 from picture within w_cz_sec_confirmacion
end type
end forward

global type w_cz_sec_confirmacion from w_fa_padre
integer width = 1463
integer height = 588
string title = "(CR) Secuencia de Confirmaciones"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event ue_syscommand pbm_syscommand
st_2 st_2
gb_1 gb_1
st_1 st_1
sle_1 sle_1
cb_1 cb_1
cb_2 cb_2
p_1 p_1
end type
global w_cz_sec_confirmacion w_cz_sec_confirmacion

type variables
str_pase_fact	lstr_pase
end variables

event ue_syscommand;if commandtype = 61536 then
	if messagebox('Atención','¿Desea cerrar la Ventana?',Question!,YesNo!,2) = 1 then
		lstr_pase.orden = 'Cancelar'
		closewithreturn(this,lstr_pase)
	else
		return 1
	end if
end if

end event

on w_cz_sec_confirmacion.create
int iCurrent
call super::create
this.st_2=create st_2
this.gb_1=create gb_1
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.sle_1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.p_1
end on

on w_cz_sec_confirmacion.destroy
call super::destroy
destroy(this.st_2)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.p_1)
end on

event closequery;// Override

end event

event ue_aceptar;long ll_acepta

ll_acepta = Messagebox("AVISO","Desea Utilizar el Número dado en la SECUENCIA "+string(lstr_pase.orden )+'?',Information!,OKCancel!,1)
lstr_pase.orden = sle_1.text

CHOOSE CASE ll_acepta
	CASE 1
		closewithreturn(this,lstr_pase)
	CASE 2
		return
END CHOOSE

end event

event ue_post_open;// OverRide

is_nombre = This.ClassName()

gf_win_used_by_user(is_nombre, true)

dw.settransobject(sqlca)

st_nom_ventana.text = is_nombre


//this.postevent("ue_hay_data")

this.visible=true

//If This.MenuName = "m_cr_principal" Then m_cr_principal.archivo.m_cerrar.toolbaritemvisible = False

gf_cr_ult_factura(sle_1.Text)

end event

event open;string	ls_secuencia

gf_center_win(This)
gf_acelerador()

THIS.SetToolbar(1, true, alignattop!)
THIS.SetToolbarPos(1, 1, 50, false)

this.y = this.y - 150
lstr_pase = Message.PowerObjectParm
str.frame.SetRedraw (TRUE)

sle_1.text = lstr_pase.orden


end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_cz_sec_confirmacion
boolean visible = false
integer x = 27
integer y = 396
integer width = 699
end type

type dw_1 from w_fa_padre`dw_1 within w_cz_sec_confirmacion
boolean visible = false
integer x = 0
integer y = 84
integer height = 664
end type

type st_2 from statictext within w_cz_sec_confirmacion
integer x = 82
integer y = 60
integer width = 1266
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long backcolor = 74481808
boolean enabled = false
string text = "SECUENCIA DEL DOCUMENTO "
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_cz_sec_confirmacion
integer x = 82
integer y = 108
integer width = 1266
integer height = 248
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 74481808
borderstyle borderstyle = styleraised!
end type

type st_1 from statictext within w_cz_sec_confirmacion
integer x = 343
integer y = 184
integer width = 347
integer height = 116
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long backcolor = 74481808
boolean enabled = false
string text = "Número de la Secuencia"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_cz_sec_confirmacion
event ue_key pbm_keydown
integer x = 777
integer y = 200
integer width = 457
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long backcolor = 16777215
boolean autohscroll = false
integer limit = 10
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

event modified;long ll_sec_ret, ll_sec_ant,ll_acepta
string ls_secuencia

lstr_pase.orden = sle_1.text
ls_secuencia = sle_1.text

end event

type cb_1 from commandbutton within w_cz_sec_confirmacion
integer x = 699
integer y = 392
integer width = 279
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
boolean underline = true
string text = "ACEPTAR"
end type

event clicked;Parent.TriggerEvent("ue_aceptar")
//Parent.TriggerEvent("close")

end event

type cb_2 from commandbutton within w_cz_sec_confirmacion
integer x = 1056
integer y = 392
integer width = 315
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
boolean underline = true
string text = "CANCELAR"
end type

event clicked;lstr_pase.orden = 'Cancelar'
closewithreturn(Parent,lstr_pase)

end event

type p_1 from picture within w_cz_sec_confirmacion
integer x = 160
integer y = 176
integer width = 165
integer height = 144
boolean bringtotop = true
string picturename = "f:\harr2000\art\economia.bmp"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_ayuda from w_fa_padre`st_ayuda within w_cz_sec_confirmacion
end type

