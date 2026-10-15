forward
global type w_reloj from Window
end type
type st_3 from statictext within w_reloj
end type
type cb_1 from commandbutton within w_reloj
end type
type uo_clock from u_analog_clock within w_reloj
end type
type st_1 from statictext within w_reloj
end type
type st_2 from statictext within w_reloj
end type
type gb_1 from groupbox within w_reloj
end type
end forward

global type w_reloj from Window
int X=832
int Y=356
int Width=1394
int Height=840
boolean TitleBar=true
string Title="La Hora es:"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_init pbm_custom01
st_3 st_3
cb_1 cb_1
uo_clock uo_clock
st_1 st_1
st_2 st_2
gb_1 gb_1
end type
global w_reloj w_reloj

type variables
Long tam1, tam2, tam3, tam4
end variables

event ue_init;st_1.Text = String(now(),"hh:mm:ss")
st_2.Text = String(now(),"dd/mm/yyyy")

//This.x = gidesktopwidth / 3
//This.y = gidesktopheight / 3

//If ge_Environment.OSType = macintosh! Then
//	Timer(1)
//Else
	uo_clock.uf_start_ticking()
//End if

end event

event close;If ge_Environment.OSType = macintosh! Then
	Timer(0)
Else
	uo_clock.uf_stop_ticking()
End if

end event

event open;Timer(1,this)

tam1 = This.WorkSpaceWidth()
tam2 = This.WorkSpaceHeight()

st_3.text = gf_hoy_word()	
st_3.width = 417
st_3.height= 129

This.PostEvent("ue_init")

end event

event resize;This.Resize(tam1 + 30,tam2 + 125)

tam3 = This.WorkSpaceWidth()
tam4 = This.WorkSpaceHeight()
end event

event timer;st_1.Text = String(now(),"hh:mm:ss")
st_2.Text = String(now(),"dd/mm/yyyy")

uo_clock.TriggerEvent("timer")

IF (tam3 = 1) and (tam4 = 1) THEN//IF (tam3 = 732) and (tam4 = 97) THEN
	This.Title = (st_1.text)
ELSEIF (tam3 > 732) and (tam4 > 97) THEN
	This.Title = ("La Hora es:")
END IF
end event

on w_reloj.create
this.st_3=create st_3
this.cb_1=create cb_1
this.uo_clock=create uo_clock
this.st_1=create st_1
this.st_2=create st_2
this.gb_1=create gb_1
this.Control[]={this.st_3,&
this.cb_1,&
this.uo_clock,&
this.st_1,&
this.st_2,&
this.gb_1}
end on

on w_reloj.destroy
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.uo_clock)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.gb_1)
end on

type st_3 from statictext within w_reloj
int X=937
int Y=376
int Width=416
int Height=128
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Times New Roman"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_reloj
int X=969
int Y=584
int Width=352
int Height=96
int TabOrder=30
string Text="&Cerrar"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type uo_clock from u_analog_clock within w_reloj
int X=32
int Y=16
int Width=887
int Height=692
int TabOrder=10
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

on uo_clock.destroy
call u_analog_clock::destroy
end on

type st_1 from statictext within w_reloj
int X=997
int Y=132
int Width=297
int Height=72
boolean Enabled=false
string Text="Hora"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-11
int Weight=700
string FaceName="Times New Roman"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_reloj
int X=997
int Y=200
int Width=297
int Height=72
boolean Enabled=false
string Text="Fecha"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Times New Roman"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_reloj
int X=969
int Y=68
int Width=347
int Height=228
int TabOrder=20
BorderStyle BorderStyle=StyleRaised!
long BackColor=12632256
int TextSize=-11
int Weight=700
string FaceName="Times New Roman"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

