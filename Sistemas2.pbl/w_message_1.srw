forward
global type w_message_1 from w_a
end type
type cb_2 from u_cb_mas within w_message_1
end type
type mle_1 from multilineedit within w_message_1
end type
type mle_2 from multilineedit within w_message_1
end type
type cb_3 from u_cb_close within w_message_1
end type
type p_1 from picture within w_message_1
end type
type p_print from picture within w_message_1
end type
type sle_print from singlelineedit within w_message_1
end type
end forward

global type w_message_1 from w_a
integer width = 1847
integer height = 1260
string title = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 79416533
cb_2 cb_2
mle_1 mle_1
mle_2 mle_2
cb_3 cb_3
p_1 p_1
p_print p_print
sle_print sle_print
end type
global w_message_1 w_message_1

type prototypes
FUNCTION boolean SetCursorPos(int cx, int cy) LIBRARY "user32.dll"

end prototypes

type variables
Integer ii_normal = 760, &
            ii_mas = 1280
end variables

forward prototypes
public subroutine wf_set_picture ()
end prototypes

public subroutine wf_set_picture ();String	ls_path, ls_pic = "else"


ls_path = str.path

If Lower(Right(ls_path, 8)) = "harr.ini" Then gf_find_path(ls_path)

ls_path += "Art\msj_"

If Match(Upper(This.Title), "ADVERTENCIA+") Then ls_pic = "advertencia"
If Match(Upper(This.Title), "ERROR+") Then ls_pic = "error"
If Match(Upper(This.Title), "ATENCI+") Then ls_pic = "error"
If Match(Upper(This.Title), "INFORMAC+") Then ls_pic = "informacion"
If Match(Upper(This.Title), "PREGUNTA+") Then ls_pic = "pregunta"

p_1.picturename = ls_path + ls_pic + ".bmp"

end subroutine

on w_message_1.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.mle_1=create mle_1
this.mle_2=create mle_2
this.cb_3=create cb_3
this.p_1=create p_1
this.p_print=create p_print
this.sle_print=create sle_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.mle_1
this.Control[iCurrent+3]=this.mle_2
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.p_1
this.Control[iCurrent+6]=this.p_print
this.Control[iCurrent+7]=this.sle_print
end on

on w_message_1.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.mle_1)
destroy(this.mle_2)
destroy(this.cb_3)
destroy(this.p_1)
destroy(this.p_print)
destroy(this.sle_print)
end on

event open;call super::open;str_mensaje	str_m
This.Icon = str.icono

gf_center_win(this)

//This.SetPosition(TopMost!)

This.Height = ii_normal

str_m = Message.PowerObjectParm

This.Title = str_m.title

wf_set_picture()

mle_1.text = str_m.error_1
mle_2.text = str_m.error_2
cb_2.visible = str_m.boton

This.p_print.picturename = str.path+'\Art\Prnbatch.bmp'
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

event key;// Gianni Araúz (18/03/2000)
// Para que se ejecute el evento clicked de los commandbuttons


if key = keyenter! then
	if getfocus().typeof() = commandbutton! then getfocus().triggerevent(clicked!)
end if

end event

event timer;call super::timer;
if sle_print.visible = true then
	sle_print.visible = false
	timer(0)
end if
end event

type st_msghlp from w_a`st_msghlp within w_message_1
end type

type st_window_name from w_a`st_window_name within w_message_1
integer x = 78
string text = ""
end type

type cb_2 from u_cb_mas within w_message_1
integer x = 1376
integer y = 512
integer width = 352
integer height = 96
integer taborder = 20
string text = "<<   &Más"
end type

event clicked;call super::clicked;this.enabled = false
end event

type mle_1 from multilineedit within w_message_1
integer x = 261
integer y = 32
integer width = 1467
integer height = 420
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean vscrollbar = true
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type mle_2 from multilineedit within w_message_1
integer x = 78
integer y = 684
integer width = 1650
integer height = 420
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Bookman Old Style"
boolean vscrollbar = true
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from u_cb_close within w_message_1
integer x = 722
integer y = 512
integer width = 352
integer height = 96
integer taborder = 10
string text = "&Aceptar"
boolean default = true
end type

type p_1 from picture within w_message_1
integer x = 78
integer y = 176
integer width = 146
integer height = 128
boolean bringtotop = true
boolean originalsize = true
string picturename = "\harr2000\art\msj_else.bmp"
boolean focusrectangle = false
end type

type p_print from picture within w_message_1
event ue_microhelp pbm_nchittest
integer x = 96
integer y = 492
integer width = 96
integer height = 84
boolean bringtotop = true
boolean originalsize = true
string picturename = "F:\Harr2000\Art\Prnbatch.bmp"
boolean focusrectangle = false
end type

event ue_microhelp;timer(1)
sle_print.visible = true
end event

event clicked;Long ll_Job

SetPointer(Hourglass!)

//Abre el Job y le asigna un titulo
ll_Job = PrintOpen("Impresión de Pantalla")
If ll_Job = -1 Then
	Messagebox("Error al Abrir el Job de Impresión","No se pudo abrir el job. Verifique la Impresora " + &
	"Configure en el Administrador de Impresoras")
	Return
End If

SetPointer(Hourglass!)

// Imprime la imagen en pantalla en la coordenada x y y de la pagina 
PrintScreen(ll_Job, 500,1000)


//Cierra el Job de Impresión, el cual será enviadop a la impresora
PrintClose(ll_Job)

end event

type sle_print from singlelineedit within w_message_1
boolean visible = false
integer x = 219
integer y = 468
integer width = 494
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15793151
string text = " Imprimir Pantalla"
end type

