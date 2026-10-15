forward
global type uo_paleta_colores2 from UserObject
end type
type cb_3 from commandbutton within uo_paleta_colores2
end type
type dw_2 from datawindow within uo_paleta_colores2
end type
type cb_2 from commandbutton within uo_paleta_colores2
end type
type cb_1 from commandbutton within uo_paleta_colores2
end type
type dw_1 from datawindow within uo_paleta_colores2
end type
type gb_1 from groupbox within uo_paleta_colores2
end type
type gb_2 from groupbox within uo_paleta_colores2
end type
end forward

global type uo_paleta_colores2 from UserObject
int Width=1020
int Height=833
long BackColor=12632256
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=16777215
event ue_color ( long al_texto,  long al_fondo )
cb_3 cb_3
dw_2 dw_2
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
gb_2 gb_2
end type
global uo_paleta_colores2 uo_paleta_colores2

type variables
str_paleta_color istr_pc
string is_old_objeto
end variables

forward prototypes
public subroutine uf_color ()
public subroutine uf_close ()
public subroutine uf_set_color (long texto, long fondo)
end prototypes

public subroutine uf_color ();//Retorna el color seleccionado


istr_pc.color1 = Long(dw_2.Object.column2.Background.Color)
istr_pc.color2 = Long(dw_2.Object.column3.Background.Color)
end subroutine

public subroutine uf_close ();cb_3.TriggerEvent(clicked!)
end subroutine

public subroutine uf_set_color (long texto, long fondo);//Coloca el color actual


dw_2.Object.column2.Background.Color = texto
dw_2.Object.column3.Background.Color = fondo
end subroutine

on uo_paleta_colores2.create
this.cb_3=create cb_3
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={ this.cb_3,&
this.dw_2,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.gb_1,&
this.gb_2}
end on

on uo_paleta_colores2.destroy
destroy(this.cb_3)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

type cb_3 from commandbutton within uo_paleta_colores2
event clicked pbm_bnclicked
int X=572
int Y=581
int Width=403
int Height=109
int TabOrder=31
string Text="&Cancelar"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.Trigger Event ue_color(-1, -1)
end event

type dw_2 from datawindow within uo_paleta_colores2
event micro pbm_nchittest
int X=581
int Y=65
int Width=380
int Height=381
int TabOrder=20
string DataObject="dw_colors4"
boolean Border=false
boolean LiveScroll=true
end type

event micro;integer  li_pos
long 		ll_color
string 	ls_objeto


ls_objeto = This.GetObjectAtPointer()

If Len(TRIM(ls_objeto)) < 1 Then Return

li_pos = Pos(ls_objeto, "~t")

ls_objeto = Left(ls_objeto, li_pos - 1)

If (ls_objeto = is_old_objeto) Or (ls_objeto = "column1") Then Return

If Len(Trim(ls_objeto)) < 1 Then Return

If lower(ls_objeto) = "column2" Then
	This.Modify(ls_objeto + ".Border='1'")
	This.Modify("column3.Border='5'")
Else
	This.Modify(ls_objeto + ".Border='1'")
	This.Modify("column2.Border='5'")	
End If

is_old_objeto = ls_objeto
end event

type cb_2 from commandbutton within uo_paleta_colores2
int X=572
int Y=689
int Width=403
int Height=109
int TabOrder=40
string Text="&Aceptar"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;uf_color()
Parent.Trigger Event ue_color(istr_pc.color1, istr_pc.color2)
end event

type cb_1 from commandbutton within uo_paleta_colores2
int X=572
int Y=473
int Width=403
int Height=109
int TabOrder=30
string Text="&Más Colores"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//Aquí se llama a un API de la Paleta de Colores
//Herick Guillén Jair Padilla


long ll_color
uo_change_color uo_cc

dw_1.Enabled = FALSE
cb_1.Enabled = FALSE
uo_cc = Create uo_change_color

uo_cc.of_shoosecolor(ll_color)

If dw_2.Describe("column2.Border") = "1" Then
	dw_2.Object.column2.Background.Color = ll_color
Else
	dw_2.Object.column3.Background.Color = ll_color
End If

destroy uo_cc

dw_1.Enabled = TRUE
cb_1.Enabled = TRUE
end event

type dw_1 from datawindow within uo_paleta_colores2
event micro pbm_nchittest
int X=46
int Y=69
int Width=481
int Height=729
int TabOrder=10
string DataObject="dw_colors3"
boolean Border=false
boolean LiveScroll=true
end type

event micro;integer  li_pos, li_row
long 		ll_color
string 	ls_objeto


ls_objeto = This.GetObjectAtPointer()

If Len(TRIM(ls_objeto)) < 1 Then Return

li_pos = Pos(ls_objeto, "~t")

li_row = integer(Right(ls_objeto, Len(ls_objeto) - (li_pos)))

If li_row < 1 Then Return

ls_objeto = Left(ls_objeto, li_pos - 1)

If is_old_objeto = ls_objeto Then Return

IF Left(UPPER(ls_objeto),3) = "COL" THEN
	ls_objeto = "c_" + Mid(ls_objeto,4,Len(ls_objeto) - 3)
END IF

dw_2.Object.column1.Background.Color = string(This.GetItemNumber(li_row,ls_objeto))

is_old_objeto = ls_objeto
end event

event clicked;If dw_2.Describe("column2.Border") = "1" Then
	dw_2.Object.column2.Background.Color = dw_2.Object.column1.Background.Color
Else
	dw_2.Object.column3.Background.Color = dw_2.Object.column1.Background.Color
End If
end event

type gb_1 from groupbox within uo_paleta_colores2
int X=37
int Y=17
int Width=517
int Height=789
string Text=" Colores "
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within uo_paleta_colores2
int X=567
int Y=17
int Width=407
int Height=437
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

