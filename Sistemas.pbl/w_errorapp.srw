//objectcomments Ventana de errores para las Aplicaciones
forward
global type w_errorapp from window
end type
type cb_1 from commandbutton within w_errorapp
end type
type cb_2 from commandbutton within w_errorapp
end type
type p_1 from picture within w_errorapp
end type
type st_1 from statictext within w_errorapp
end type
type st_2 from statictext within w_errorapp
end type
type mle_1 from multilineedit within w_errorapp
end type
end forward

global type w_errorapp from window
integer x = 987
integer y = 688
integer width = 1810
integer height = 508
boolean titlebar = true
string title = "Error"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
event ue_postopen ( )
cb_1 cb_1
cb_2 cb_2
p_1 p_1
st_1 st_1
st_2 st_2
mle_1 mle_1
end type
global w_errorapp w_errorapp

type variables
string is_error
end variables

event ue_postopen;beep(1)
mle_1.text = is_error











end event

on w_errorapp.create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.p_1=create p_1
this.st_1=create st_1
this.st_2=create st_2
this.mle_1=create mle_1
this.Control[]={this.cb_1,&
this.cb_2,&
this.p_1,&
this.st_1,&
this.st_2,&
this.mle_1}
end on

on w_errorapp.destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.p_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.mle_1)
end on

event open;This.Icon = str.icono

is_error = Message.StringParm	

This.postevent("ue_postopen")

//lb_1.text = ls_error
end event

type cb_1 from commandbutton within w_errorapp
event clicked pbm_bnclicked
integer x = 1298
integer y = 256
integer width = 402
integer height = 88
integer taborder = 2
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "D&etalles >>"
end type

event clicked;This.enabled = false
parent.Height = 1100

end event

type cb_2 from commandbutton within w_errorapp
event clicked pbm_bnclicked
integer x = 1298
integer y = 68
integer width = 402
integer height = 88
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cerrar"
end type

event clicked;close (parent)

end event

type p_1 from picture within w_errorapp
integer y = 32
integer width = 229
integer height = 188
string picturename = "\art\error.bmp"
boolean focusrectangle = false
end type

type st_1 from statictext within w_errorapp
integer x = 261
integer y = 48
integer width = 992
integer height = 156
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Ha ocurrido un Error en el programa."
boolean focusrectangle = false
end type

type st_2 from statictext within w_errorapp
integer x = 261
integer y = 212
integer width = 951
integer height = 164
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Si el problema persiste, consulte al proveedor del programa."
boolean focusrectangle = false
end type

type mle_1 from multilineedit within w_errorapp
integer x = 32
integer y = 440
integer width = 1746
integer height = 460
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean vscrollbar = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

