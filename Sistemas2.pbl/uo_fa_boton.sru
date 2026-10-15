//objectcomments Boton del informe
forward
global type uo_fa_boton from UserObject
end type
type p_1 from picture within uo_fa_boton
end type
type st_boton from statictext within uo_fa_boton
end type
end forward

global type uo_fa_boton from UserObject
int Width=233
int Height=120
boolean Border=true
long BackColor=67108864
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
event ue_clicked pbm_bnclicked
p_1 p_1
st_boton st_boton
end type
global uo_fa_boton uo_fa_boton

forward prototypes
public function integer of_setpicture (string as_picture)
end prototypes

public function integer of_setpicture (string as_picture);/* Funcion que cambia la imagen para el boton
   Retorna 1 = Exitoso, -1 = Error, Null = Argumento Nulo */

Integer li_rtn

If IsNull(as_picture) Then Return SetNull(li_rtn)
If Not(FileExists(as_picture)) Then Return -1
p_1.PictureName = as_picture
Return 1
end function

on uo_fa_boton.create
this.p_1=create p_1
this.st_boton=create st_boton
this.Control[]={this.p_1,&
this.st_boton}
end on

on uo_fa_boton.destroy
destroy(this.p_1)
destroy(this.st_boton)
end on

type p_1 from picture within uo_fa_boton
event lbuttondown pbm_lbuttondown
event lbuttonup pbm_lbuttonup
int X=27
int Y=12
int Width=165
int Height=88
boolean FocusRectangle=false
end type

event lbuttondown;st_boton.TriggerEvent('lbuttondown')
end event

event lbuttonup;st_boton.TriggerEvent('lbuttonup')
end event

event clicked;Parent.TriggerEvent('ue_clicked')
end event

type st_boton from statictext within uo_fa_boton
event lbuttondown pbm_lbuttondown
event lbuttonup pbm_lbuttonup
int Width=224
int Height=112
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
Alignment Alignment=Center!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event lbuttondown;st_boton.BorderStyle = StyleLowered!
end event

event lbuttonup;st_boton.BorderStyle = StyleRaised!
end event

event clicked;Parent.TriggerEvent('ue_clicked')
end event

