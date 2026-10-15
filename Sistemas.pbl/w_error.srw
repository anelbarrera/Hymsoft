//objectcomments Ventana de Errores
forward
global type w_error from Window
end type
type st_2 from statictext within w_error
end type
type cb_2 from commandbutton within w_error
end type
type mle_1 from multilineedit within w_error
end type
type st_1 from statictext within w_error
end type
type cb_1 from commandbutton within w_error
end type
type p_1 from picture within w_error
end type
end forward

global type w_error from Window
int X=924
int Y=877
int Width=1811
int Height=505
boolean TitleBar=true
string Title="Error"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
event ue_postopen ( )
st_2 st_2
cb_2 cb_2
mle_1 mle_1
st_1 st_1
cb_1 cb_1
p_1 p_1
end type
global w_error w_error

type variables
string is_error
end variables

event ue_postopen;beep(1)
mle_1.text = is_error











end event

on w_error.create
this.st_2=create st_2
this.cb_2=create cb_2
this.mle_1=create mle_1
this.st_1=create st_1
this.cb_1=create cb_1
this.p_1=create p_1
this.Control[]={ this.st_2,&
this.cb_2,&
this.mle_1,&
this.st_1,&
this.cb_1,&
this.p_1}
end on

on w_error.destroy
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.mle_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.p_1)
end on

event open;This.Icon = str.icono

is_error = Message.StringParm	

This.postevent("ue_postopen")

//lb_1.text = ls_error
end event

type st_2 from statictext within w_error
int X=261
int Y=213
int Width=924
int Height=165
boolean Enabled=false
string Text="Si el problema persiste, consulte al porveedor del programa"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_error
event clicked pbm_bnclicked
int X=1299
int Y=69
int Width=403
int Height=89
int TabOrder=10
string Text="&Cerrar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close (parent)

end event

type mle_1 from multilineedit within w_error
int X=33
int Y=477
int Width=1747
int Height=461
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean DisplayOnly=true
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_error
int X=261
int Y=49
int Width=883
int Height=157
boolean Enabled=false
string Text="Ha ocurrido un Error al intentar almacenar la información."
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_error
int X=1299
int Y=257
int Width=403
int Height=89
int TabOrder=20
string Text="D&etalles >>"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;This.enabled = false
parent.Height = 1100

end event

type p_1 from picture within w_error
int Y=33
int Width=229
int Height=189
string PictureName="\art\error.bmp"
boolean FocusRectangle=false
end type

