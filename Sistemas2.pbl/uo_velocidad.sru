forward
global type uo_velocidad from UserObject
end type
type st_diezmilecima from statictext within uo_velocidad
end type
type st_milecima from statictext within uo_velocidad
end type
type st_centena from statictext within uo_velocidad
end type
type st_decena from statictext within uo_velocidad
end type
type st_unidad from statictext within uo_velocidad
end type
type ole_1 from olecustomcontrol within uo_velocidad
end type
end forward

global type uo_velocidad from UserObject
int Width=906
int Height=521
boolean Border=true
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=16777215
st_diezmilecima st_diezmilecima
st_milecima st_milecima
st_centena st_centena
st_decena st_decena
st_unidad st_unidad
ole_1 ole_1
end type
global uo_velocidad uo_velocidad

forward prototypes
public subroutine uf_incrementa (integer incremento)
end prototypes

public subroutine uf_incrementa (integer incremento);If incremento >= 100 Then incremento = 100

ole_1.Object.Value = incremento

end subroutine

on uo_velocidad.create
this.st_diezmilecima=create st_diezmilecima
this.st_milecima=create st_milecima
this.st_centena=create st_centena
this.st_decena=create st_decena
this.st_unidad=create st_unidad
this.ole_1=create ole_1
this.Control[]={ this.st_diezmilecima,&
this.st_milecima,&
this.st_centena,&
this.st_decena,&
this.st_unidad,&
this.ole_1}
end on

on uo_velocidad.destroy
destroy(this.st_diezmilecima)
destroy(this.st_milecima)
destroy(this.st_centena)
destroy(this.st_decena)
destroy(this.st_unidad)
destroy(this.ole_1)
end on

type st_diezmilecima from statictext within uo_velocidad
int X=321
int Y=429
int Width=46
int Height=65
boolean Enabled=false
boolean Border=true
string Text="0"
boolean FocusRectangle=false
long BackColor=15793151
int TextSize=-11
int Weight=400
string FaceName="Fixedsys"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type st_milecima from statictext within uo_velocidad
int X=371
int Y=429
int Width=46
int Height=65
boolean Enabled=false
boolean Border=true
string Text="0"
boolean FocusRectangle=false
long BackColor=15793151
int TextSize=-11
int Weight=400
string FaceName="Fixedsys"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type st_centena from statictext within uo_velocidad
int X=421
int Y=429
int Width=46
int Height=65
boolean Enabled=false
boolean Border=true
string Text="0"
boolean FocusRectangle=false
long BackColor=15793151
int TextSize=-11
int Weight=400
string FaceName="Fixedsys"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type st_decena from statictext within uo_velocidad
int X=471
int Y=429
int Width=46
int Height=65
boolean Enabled=false
boolean Border=true
string Text="0"
boolean FocusRectangle=false
long BackColor=15793151
int TextSize=-11
int Weight=400
string FaceName="Fixedsys"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type st_unidad from statictext within uo_velocidad
int X=522
int Y=429
int Width=46
int Height=65
boolean Enabled=false
boolean Border=true
string Text="0"
boolean FocusRectangle=false
long BackColor=15793151
int TextSize=-11
int Weight=400
string FaceName="Fixedsys"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type ole_1 from olecustomcontrol within uo_velocidad
event click ( )
event dblclick ( )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
int Width=897
int Height=517
int TabOrder=1
boolean Enabled=false
long BackColor=16777215
boolean Border=false
boolean FocusRectangle=false
string BinaryKey="uo_velocidad.udo"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

