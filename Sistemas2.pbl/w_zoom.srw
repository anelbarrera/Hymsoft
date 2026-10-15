//objectcomments FCS datawindow Zoom window
forward
global type w_zoom from Window
end type
type cbx_regla from checkbox within w_zoom
end type
type sle_custom from editmask within w_zoom
end type
type cb_cancel from commandbutton within w_zoom
end type
type cb_ok from commandbutton within w_zoom
end type
type st_1 from statictext within w_zoom
end type
type rb_custom from radiobutton within w_zoom
end type
type rb_25 from radiobutton within w_zoom
end type
type rb_75 from radiobutton within w_zoom
end type
type rb_100 from radiobutton within w_zoom
end type
type rb_200 from radiobutton within w_zoom
end type
type gb_1 from groupbox within w_zoom
end type
end forward

global type w_zoom from Window
int X=860
int Y=337
int Width=1212
int Height=801
boolean TitleBar=true
string Title="Zoom"
long BackColor=12632256
boolean ControlMenu=true
boolean Resizable=true
WindowType WindowType=response!
cbx_regla cbx_regla
sle_custom sle_custom
cb_cancel cb_cancel
cb_ok cb_ok
st_1 st_1
rb_custom rb_custom
rb_25 rb_25
rb_75 rb_75
rb_100 rb_100
rb_200 rb_200
gb_1 gb_1
end type
global w_zoom w_zoom

type variables
dataWindow dw_parm
boolean ib_preview
end variables

event open;string	zoom, ruler

dw_parm = message.powerobjectparm

zoom = dw_parm.describe("datawindow.print.preview.zoom")

	choose case zoom
		case "200"
			rb_200.checked = true
		case "100"
			rb_100.checked = true
		case "75"
			rb_75.checked = true
		case "25"
			rb_25.checked = true
		case else
			rb_custom.checked = true
	end choose

	sle_custom.text = zoom

IF dw_parm.describe("datawindow.print.preview") = "yes" THEN
	ib_preview = true
ELSE
	ib_preview = false
END IF

ruler = dw_parm.describe("datawindow.print.preview.rulers")

If ruler = "yes" Then
	cbx_regla.checked = true
Else
	cbx_regla.checked = false
End If
end event

on w_zoom.create
this.cbx_regla=create cbx_regla
this.sle_custom=create sle_custom
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_1=create st_1
this.rb_custom=create rb_custom
this.rb_25=create rb_25
this.rb_75=create rb_75
this.rb_100=create rb_100
this.rb_200=create rb_200
this.gb_1=create gb_1
this.Control[]={ this.cbx_regla,&
this.sle_custom,&
this.cb_cancel,&
this.cb_ok,&
this.st_1,&
this.rb_custom,&
this.rb_25,&
this.rb_75,&
this.rb_100,&
this.rb_200,&
this.gb_1}
end on

on w_zoom.destroy
destroy(this.cbx_regla)
destroy(this.sle_custom)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.rb_custom)
destroy(this.rb_25)
destroy(this.rb_75)
destroy(this.rb_100)
destroy(this.rb_200)
destroy(this.gb_1)
end on

type cbx_regla from checkbox within w_zoom
int X=796
int Y=481
int Width=321
int Height=77
string Text="Regla"
boolean LeftText=true
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_custom from editmask within w_zoom
int X=417
int Y=481
int Width=215
int Height=77
int TabOrder=31
string Mask="###"
boolean Spin=true
string DisplayData=""
double Increment=10
string MinMax="10~~200"
long BackColor=16777215
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancel from commandbutton within w_zoom
int X=796
int Y=185
int Width=321
int Height=109
int TabOrder=30
string Text="Cancel"
boolean Cancel=true
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close(Parent)
end on

type cb_ok from commandbutton within w_zoom
int X=796
int Y=61
int Width=321
int Height=109
int TabOrder=20
string Text="OK"
boolean Default=true
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;If cbx_regla.checked Then
	dw_parm.modify("datawindow.print.preview=yes")
	dw_parm.modify("datawindow.print.preview.rulers=yes")
Else
	If Not ib_preview Then dw_parm.modify("datawindow.print.preview=no")
	dw_parm.modify("datawindow.print.preview.rulers=no")
End If

dw_parm.modify("datawindow.print.preview.zoom =" + sle_custom.text  )

close(parent)
end event

type st_1 from statictext within w_zoom
int X=627
int Y=497
int Width=55
int Height=61
boolean Enabled=false
string Text="%"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_custom from radiobutton within w_zoom
int X=115
int Y=485
int Width=316
int Height=73
string Text="Custom"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_custom.SetFocus()
end on

type rb_25 from radiobutton within w_zoom
int X=115
int Y=397
int Width=247
int Height=73
string Text="30%"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_custom.text = "30"
end on

type rb_75 from radiobutton within w_zoom
int X=115
int Y=309
int Width=247
int Height=73
string Text="65%"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_custom.text = "65"
end on

type rb_100 from radiobutton within w_zoom
int X=115
int Y=221
int Width=247
int Height=73
string Text="100%"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_custom.text = "100"
end on

type rb_200 from radiobutton within w_zoom
int X=115
int Y=133
int Width=247
int Height=73
string Text="200%"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;sle_custom.text = "200"
end on

type gb_1 from groupbox within w_zoom
int X=51
int Y=37
int Width=700
int Height=585
int TabOrder=10
string Text="Magnification"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

