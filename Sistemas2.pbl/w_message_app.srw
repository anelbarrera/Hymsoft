forward
global type w_message_app from w_a
end type
type cb_2 from u_cb_mas within w_message_app
end type
type mle_1 from multilineedit within w_message_app
end type
type mle_2 from multilineedit within w_message_app
end type
type cb_3 from u_cb_close within w_message_app
end type
type sle_print from singlelineedit within w_message_app
end type
type p_print from picture within w_message_app
end type
end forward

global type w_message_app from w_a
integer x = 9
integer y = 48
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
sle_print sle_print
p_print p_print
end type
global w_message_app w_message_app

type prototypes
FUNCTION boolean SetCursorPos(int cx, int cy) LIBRARY "user32.dll"

end prototypes

type variables
Integer ii_normal = 760, &
            ii_mas = 1280
end variables

on w_message_app.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.mle_1=create mle_1
this.mle_2=create mle_2
this.cb_3=create cb_3
this.sle_print=create sle_print
this.p_print=create p_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.mle_1
this.Control[iCurrent+3]=this.mle_2
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.sle_print
this.Control[iCurrent+6]=this.p_print
end on

on w_message_app.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.mle_1)
destroy(this.mle_2)
destroy(this.cb_3)
destroy(this.sle_print)
destroy(this.p_print)
end on

event open;/*******************************************************************************************
*	System Name:	SEGURIDAD
*								Sistema de Seguridad
********************************************************************************************
*	
*	PROPOSITO:
*	 Darle tiempo a la ventana para que pueda abrirse bien, osea cuando los objetos que se 
*	 encuentran en la ventana se puedan terminar de dibujar y esto no dara la impresion
*	 que la ventana se abrio lentamente o que el sistema esta pesado
*	
*	OBJETO:						TIPO						NOMBRE						EVENTO
*									----						------						------
*								  Ventana					 w_a							 open
*	
*	PARAMETROS:				 RECIBIDOS					ENVIADO
*								 ---------					-------
*								  Ninguno					Ninguno
*	
*	AUTOR:				Herick Guillén
*	------
*	DÍA DE CREACIÓN:	07 de Septiembre de 1998
*	----------------
********************************************************************************************
*	Modificaciones:
*	---------------
*	
*	
*	Fecha de la Modificación		Modificado por el Programador			Referencia
*	------------------------		-----------------------------			----------
*	
*	
********************************************************************************************
*					DERECHO DE AUTOR (c) 1998	HARR. , S.A.									 
*******************************************************************************************/

gf_acelerador()

Long	ll_sysmenu


If Not ib_acerca then Return

ll_sysmenu = GetSystemMenu(Handle(this), False)

InsertMenuA(ll_sysmenu, 1, 0, 1319, "Acerca de...")
InsertMenuA(ll_sysmenu, 2, 0, 1320, "Imprimir Error")

DrawMenuBar(handle(this))

ib_acerca = false

st_window_name.BackColor = this.BackColor

//This.PostEvent("ue_init")

//------
str_mensaje	str_m
This.Icon = str.icono
This.p_print.picturename = str.path+'\Art\Prnbatch.bmp'
gf_center_win(this)

//This.SetPosition(TopMost!)

This.Height = ii_normal

str_m = Message.PowerObjectParm

This.Title = str_m.title
mle_1.text = str_m.error_1
mle_2.text = str_m.error_2
cb_2.visible = str_m.boton
end event

event ue_mas;call super::ue_mas;This.Height = ii_mas
end event

event ue_init;call super::ue_init;u_external_function uo_extern
string	ls_path


f_create_external_func_uo(uo_extern)
ls_path = str.path

DO WHILE Upper(Right(ls_path, 7)) <> "HARR2000\"
	gf_find_path(ls_path)
LOOP


If Not cb_2.visible Then
	SetCursorPos(393, 303)
Else
	SetCursorPos(538, 303)
End If

uo_extern.uf_playsound(ls_path + "art\sonidos\bomba.wav", 3)
end event

event ue_close;call super::ue_close;This.TriggerEvent(close!)
end event

event ue_syscommand;call super::ue_syscommand;If commandtype = 1320 Then This.TriggerEvent("ue_print")
end event

event ue_print;call super::ue_print;Long 			Job
DataStore	lds_error


lds_error = Create DataStore
lds_error.DataObject = "dw_error_extern"

Job = PrintOpen()

PrintDefineFont(Job, 3, "Courier 10Cps", 200,700, Default!, AnyFont!, FALSE, FALSE)

lds_error.InsertRow(1)
lds_error.SetItem(1, "error", mle_1.text)

lds_error.InsertRow(2)
lds_error.SetItem(2, "error", mle_2.text)

lds_error.Print()

Destroy lds_error

PrintClose(Job)
end event

event timer;call super::timer;
if sle_print.visible = true then
	sle_print.visible = false
	timer(0)
end if
end event

type st_msghlp from w_a`st_msghlp within w_message_app
end type

type st_window_name from w_a`st_window_name within w_message_app
integer x = 78
string text = ""
end type

type cb_2 from u_cb_mas within w_message_app
integer x = 1376
integer y = 512
integer width = 352
integer height = 96
integer taborder = 30
string text = "<<   &Más"
end type

event clicked;call super::clicked;this.enabled = false
end event

type mle_1 from multilineedit within w_message_app
integer x = 73
integer y = 32
integer width = 1655
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

type mle_2 from multilineedit within w_message_app
integer x = 78
integer y = 684
integer width = 1650
integer height = 420
integer taborder = 50
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

type cb_3 from u_cb_close within w_message_app
integer x = 722
integer y = 512
integer width = 352
integer height = 96
integer taborder = 10
string text = "&Aceptar"
boolean default = true
end type

type sle_print from singlelineedit within w_message_app
boolean visible = false
integer x = 219
integer y = 468
integer width = 494
integer height = 80
integer taborder = 50
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

type p_print from picture within w_message_app
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

