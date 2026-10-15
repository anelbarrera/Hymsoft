forward
global type w_presentacion from Window
end type
type st_1 from statictext within w_presentacion
end type
type p_1 from picture within w_presentacion
end type
end forward

global type w_presentacion from Window
int X=832
int Y=360
int Width=2309
int Height=1352
boolean Enabled=false
long BackColor=79741120
WindowType WindowType=popup!
event ue_post_event ( )
st_1 st_1
p_1 p_1
end type
global w_presentacion w_presentacion

type variables
Time it_cierra
end variables

on w_presentacion.create
this.st_1=create st_1
this.p_1=create p_1
this.Control[]={this.st_1,&
this.p_1}
end on

on w_presentacion.destroy
destroy(this.st_1)
destroy(this.p_1)
end on

event open;String	ls_path

gf_center_win(this)


If Message.StringParm <> "No Password" Then
	it_cierra = RelativeTime(now(), 3)
	Timer(0.5, This)
End If
ls_path = str.path
gf_find_path(ls_path)
p_1.picturename = ls_path + "art\present_harr.bmp"
//this.PostEvent("ue_post_event")

end event

event timer;SetPointer(HourGlass!)

//If now() > = it_cierra Then
// 	This.Hide()
	Open(w_clave)
	Close(This)
//End If
end event

type st_1 from statictext within w_presentacion
int X=59
int Y=1196
int Width=2194
int Height=76
string Text="Programa Protegido por leyes de derechos de autor como se describe en la Ayuda en Acerca de..."
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_1 from picture within w_presentacion
int Width=2309
int Height=1352
string PictureName="f:\harr98\art\present_harr.bmp"
boolean FocusRectangle=false
end type

