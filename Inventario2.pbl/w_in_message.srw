//objectcomments (A)ventana de mensaje
forward
global type w_in_message from w_a
end type
type cb_2 from u_cb_mas within w_in_message
end type
type mle_1 from multilineedit within w_in_message
end type
type cb_4 from u_cb_aceptar within w_in_message
end type
type st_1 from statictext within w_in_message
end type
type st_2 from statictext within w_in_message
end type
type st_3 from statictext within w_in_message
end type
type st_4 from statictext within w_in_message
end type
type p_1 from picture within w_in_message
end type
type st_abrir from statictext within w_in_message
end type
type st_cerrar from statictext within w_in_message
end type
type mle_2 from multilineedit within w_in_message
end type
type st_5 from statictext within w_in_message
end type
type gb_1 from groupbox within w_in_message
end type
end forward

global type w_in_message from w_a
integer width = 2738
integer height = 1456
string title = "----------Informacion de Ayuda----------"
boolean minbox = false
boolean maxbox = false
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = false
windowtype windowtype = response!
long backcolor = 12632256
cb_2 cb_2
mle_1 mle_1
cb_4 cb_4
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
p_1 p_1
st_abrir st_abrir
st_cerrar st_cerrar
mle_2 mle_2
st_5 st_5
gb_1 gb_1
end type
global w_in_message w_in_message

type prototypes
FUNCTION boolean SetCursorPos(int cx, int cy) LIBRARY "user32.dll"

end prototypes

type variables
Integer ii_normal = 760, &
            ii_mas = 1280
string is_ventana_abrir
end variables

forward prototypes
public subroutine wf_set_picture ()
end prototypes

public subroutine wf_set_picture ();String	ls_path, ls_pic = "else"


ls_path = str.path + "Art\msj_"

If Match(Upper(This.Title), "ADVERTENCIA+") Then ls_pic = "advertencia"
If Match(Upper(This.Title), "ERROR+") Then ls_pic = "error"
If Match(Upper(This.Title), "ATENCI+") Then ls_pic = "error"
If Match(Upper(This.Title), "INFORMAC+") Then ls_pic = "informacion"
If Match(Upper(This.Title), "PREGUNTA+") Then ls_pic = "pregunta"

p_1.picturename = ls_path + ls_pic + ".bmp"
end subroutine

on w_in_message.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.mle_1=create mle_1
this.cb_4=create cb_4
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.p_1=create p_1
this.st_abrir=create st_abrir
this.st_cerrar=create st_cerrar
this.mle_2=create mle_2
this.st_5=create st_5
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.mle_1
this.Control[iCurrent+3]=this.cb_4
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.p_1
this.Control[iCurrent+9]=this.st_abrir
this.Control[iCurrent+10]=this.st_cerrar
this.Control[iCurrent+11]=this.mle_2
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.gb_1
end on

on w_in_message.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.mle_1)
destroy(this.cb_4)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.p_1)
destroy(this.st_abrir)
destroy(this.st_cerrar)
destroy(this.mle_2)
destroy(this.st_5)
destroy(this.gb_1)
end on

event open;call super::open;str_mensaje	str_m
This.Icon = str.icono

gf_center_win(this)

//This.SetPosition(TopMost!)

//This.Height = ii_normal

str_m = Message.PowerObjectParm

//This.Title = str_m.title 
This.Title = 'Información de Ayuda'

wf_set_picture()

mle_1.text 			= str_m.error_1
mle_2.text 			= str_m.error_2
cb_2.visible 		= str_m.boton
is_ventana_abrir 	= str_m.v_abrir

end event

event ue_mas;call super::ue_mas;This.Height = ii_mas
end event

event ue_init;call super::ue_init;If Not cb_2.visible Then
	SetCursorPos(393, 303)
Else
	SetCursorPos(538, 303)
End If
end event

event ue_close;call super::ue_close;This.TriggerEvent(close!)
end event

event ue_aceptar;/* Abre la Ventana que es necesaria para poder continuar con la que llamo a esta */

window ventana
opensheet(ventana,is_ventana_abrir,str.frame,11,original!)
close(this)


end event

event ue_micro;//st_cerrar.visible = false
//st_abrir.visible = false
end event

type st_msghlp from w_a`st_msghlp within w_in_message
end type

type st_window_name from w_a`st_window_name within w_in_message
boolean visible = false
integer x = 119
end type

type cb_2 from u_cb_mas within w_in_message
integer x = 1819
integer y = 1136
integer width = 777
integer taborder = 30
string text = "&Cerrar Ventana"
end type

event clicked;//this.enabled = false

close(parent)
end event

event we_nchittest;//st_cerrar.visible = true
//st_abrir.visible = false
end event

type mle_1 from multilineedit within w_in_message
event ue_micro_help pbm_nchittest
integer x = 978
integer y = 168
integer width = 1632
integer height = 472
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Bookman Old Style"
boolean autovscroll = true
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

event ue_micro_help;//st_cerrar.visible = false
//st_abrir.visible = false
end event

type cb_4 from u_cb_aceptar within w_in_message
string tag = "Abre la Ventana que le permite continuar con la Captura"
integer x = 1001
integer y = 1136
integer width = 777
integer taborder = 10
boolean bringtotop = true
string text = "&Abrir Ventana Necesaria"
end type

event we_nchittest;//st_abrir.visible = true
//st_cerrar.visible = false
end event

type st_1 from statictext within w_in_message
integer x = 978
integer y = 1116
integer width = 818
integer height = 132
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 10789024
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within w_in_message
integer x = 1797
integer y = 1116
integer width = 818
integer height = 132
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 10789024
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_3 from statictext within w_in_message
integer x = 978
integer y = 60
integer width = 1637
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
boolean enabled = false
string text = "Mensajes de Restriccioón para la Ventana"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_4 from statictext within w_in_message
integer x = 978
integer y = 656
integer width = 1637
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
boolean enabled = false
string text = "Soluciones para la Restricción de la Ventana"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type p_1 from picture within w_in_message
boolean visible = false
integer x = 1938
integer y = 1232
integer width = 165
integer height = 144
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_abrir from statictext within w_in_message
boolean visible = false
integer x = 1431
integer y = 1088
integer width = 343
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15793151
boolean enabled = false
string text = "Abrir Ventana"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_cerrar from statictext within w_in_message
boolean visible = false
integer x = 2222
integer y = 1088
integer width = 375
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15793151
boolean enabled = false
string text = "Cerrar Ventana"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type mle_2 from multilineedit within w_in_message
event ue_micro_help pbm_nchittest
integer x = 978
integer y = 760
integer width = 1637
integer height = 336
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Bookman Old Style"
string text = "Menú de inventarios,   Opción de Parámetros,  Opción de Bodegas"
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

event ue_micro_help;//st_cerrar.visible = false
//st_abrir.visible = false
end event

type st_5 from statictext within w_in_message
integer x = 37
integer y = 60
integer width = 923
integer height = 1188
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Bookman Old Style"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_in_message
integer x = 9
integer y = 8
integer width = 2629
integer height = 1260
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

