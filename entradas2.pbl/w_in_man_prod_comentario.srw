//objectcomments  
forward
global type w_in_man_prod_comentario from Window
end type
type sle_41 from singlelineedit within w_in_man_prod_comentario
end type
type sle_31 from singlelineedit within w_in_man_prod_comentario
end type
type sle_21 from singlelineedit within w_in_man_prod_comentario
end type
type sle_11 from singlelineedit within w_in_man_prod_comentario
end type
type sle_40 from singlelineedit within w_in_man_prod_comentario
end type
type sle_30 from singlelineedit within w_in_man_prod_comentario
end type
type sle_20 from singlelineedit within w_in_man_prod_comentario
end type
type sle_10 from singlelineedit within w_in_man_prod_comentario
end type
type sle_4 from singlelineedit within w_in_man_prod_comentario
end type
type sle_3 from singlelineedit within w_in_man_prod_comentario
end type
type sle_2 from singlelineedit within w_in_man_prod_comentario
end type
type sle_1 from singlelineedit within w_in_man_prod_comentario
end type
type gb_2 from groupbox within w_in_man_prod_comentario
end type
type gb_1 from groupbox within w_in_man_prod_comentario
end type
end forward

global type w_in_man_prod_comentario from Window
int X=823
int Y=360
int Width=2062
int Height=1208
boolean TitleBar=true
string Title="Comentarios para la Captura Resumida de Productos"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
sle_41 sle_41
sle_31 sle_31
sle_21 sle_21
sle_11 sle_11
sle_40 sle_40
sle_30 sle_30
sle_20 sle_20
sle_10 sle_10
sle_4 sle_4
sle_3 sle_3
sle_2 sle_2
sle_1 sle_1
gb_2 gb_2
gb_1 gb_1
end type
global w_in_man_prod_comentario w_in_man_prod_comentario

on w_in_man_prod_comentario.create
this.sle_41=create sle_41
this.sle_31=create sle_31
this.sle_21=create sle_21
this.sle_11=create sle_11
this.sle_40=create sle_40
this.sle_30=create sle_30
this.sle_20=create sle_20
this.sle_10=create sle_10
this.sle_4=create sle_4
this.sle_3=create sle_3
this.sle_2=create sle_2
this.sle_1=create sle_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.sle_41,&
this.sle_31,&
this.sle_21,&
this.sle_11,&
this.sle_40,&
this.sle_30,&
this.sle_20,&
this.sle_10,&
this.sle_4,&
this.sle_3,&
this.sle_2,&
this.sle_1,&
this.gb_2,&
this.gb_1}
end on

on w_in_man_prod_comentario.destroy
destroy(this.sle_41)
destroy(this.sle_31)
destroy(this.sle_21)
destroy(this.sle_11)
destroy(this.sle_40)
destroy(this.sle_30)
destroy(this.sle_20)
destroy(this.sle_10)
destroy(this.sle_4)
destroy(this.sle_3)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type sle_41 from singlelineedit within w_in_man_prod_comentario
int X=1198
int Y=924
int Width=768
int Height=92
BorderStyle BorderStyle=StyleShadowBox!
boolean AutoHScroll=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_31 from singlelineedit within w_in_man_prod_comentario
int X=1198
int Y=836
int Width=768
int Height=92
BorderStyle BorderStyle=StyleShadowBox!
boolean AutoHScroll=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_21 from singlelineedit within w_in_man_prod_comentario
int X=1198
int Y=744
int Width=768
int Height=92
BorderStyle BorderStyle=StyleShadowBox!
boolean AutoHScroll=false
string Text="TAMAÑOS = BAS"
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_11 from singlelineedit within w_in_man_prod_comentario
int X=1198
int Y=656
int Width=768
int Height=92
BorderStyle BorderStyle=StyleShadowBox!
boolean AutoHScroll=false
string Text="COLORES = BAS"
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_40 from singlelineedit within w_in_man_prod_comentario
int X=146
int Y=924
int Width=1010
int Height=92
BorderStyle BorderStyle=StyleShadowBox!
boolean AutoHScroll=false
string Text="MARCAS  = BAS"
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_30 from singlelineedit within w_in_man_prod_comentario
int X=146
int Y=836
int Width=1010
int Height=92
BorderStyle BorderStyle=StyleShadowBox!
boolean AutoHScroll=false
string Text="ESPECIFICACIONES= BAS"
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_20 from singlelineedit within w_in_man_prod_comentario
int X=146
int Y=744
int Width=1010
int Height=92
BorderStyle BorderStyle=StyleShadowBox!
boolean AutoHScroll=false
string Text="TIPO DE PRODUCTOS = 909"
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_10 from singlelineedit within w_in_man_prod_comentario
int X=146
int Y=656
int Width=1010
int Height=92
BorderStyle BorderStyle=StyleShadowBox!
boolean AutoHScroll=false
string Text="CLASE DE PRODUCTOS = 909"
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_4 from singlelineedit within w_in_man_prod_comentario
int X=288
int Y=412
int Width=768
int Height=92
BorderStyle BorderStyle=StyleShadowBox!
boolean AutoHScroll=false
string Text="LINEA  = BAS"
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_3 from singlelineedit within w_in_man_prod_comentario
int X=219
int Y=324
int Width=768
int Height=92
BorderStyle BorderStyle=StyleShadowBox!
boolean AutoHScroll=false
string Text="SUB-GRUPO = BAS"
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_2 from singlelineedit within w_in_man_prod_comentario
int X=151
int Y=232
int Width=768
int Height=92
BorderStyle BorderStyle=StyleShadowBox!
boolean AutoHScroll=false
string Text="GRUPO = BAS"
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_in_man_prod_comentario
int X=105
int Y=144
int Width=768
int Height=92
BorderStyle BorderStyle=StyleShadowBox!
boolean AutoHScroll=false
string Text="DIVISION  = BAS"
long TextColor=8388608
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_in_man_prod_comentario
int X=64
int Y=568
int Width=1938
int Height=492
string Text="Clasificaciones Adicionales"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_in_man_prod_comentario
int X=50
int Y=52
int Width=1106
int Height=492
string Text="Organizacion de Inventarios "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

