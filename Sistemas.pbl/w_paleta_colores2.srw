//objectcomments Paleta de Colores
forward
global type w_paleta_colores2 from Window
end type
type uo_1 from uo_paleta_colores2 within w_paleta_colores2
end type
end forward

global type w_paleta_colores2 from Window
int X=832
int Y=360
int Width=1024
int Height=912
boolean TitleBar=true
string Title="Paleta de Colores"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
event syscommand pbm_syscommand
uo_1 uo_1
end type
global w_paleta_colores2 w_paleta_colores2

type prototypes
Function long SetWindowLongA(long handlewnd, int  nIndex, long lNewLong) Library "user32"
end prototypes

event syscommand;If commandtype = 61536 Then
	uo_1.uf_close()
	Return 1
End If
end event

on w_paleta_colores2.create
this.uo_1=create uo_1
this.Control[]={this.uo_1}
end on

on w_paleta_colores2.destroy
destroy(this.uo_1)
end on

event open;//Herick
str_paleta_color lstr_pc

SetWindowLongA(handle(this), -20, 128)

lstr_pc = Message.PowerObjectParm

uo_1.uf_set_color(lstr_pc.color1, lstr_pc.color2)
end event

type uo_1 from uo_paleta_colores2 within w_paleta_colores2
int X=0
int Y=0
int Width=1001
int Height=812
int TabOrder=1
end type

on uo_1.destroy
call uo_paleta_colores2::destroy
end on

event ue_color;call super::ue_color;str_paleta_color	lstr_pc


lstr_pc.color1 = al_texto
lstr_pc.color2 = al_fondo

CloseWithReturn(Parent, lstr_pc)
end event

