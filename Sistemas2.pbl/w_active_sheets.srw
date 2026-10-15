forward
global type w_active_sheets from w_a
end type
type dw_1 from datawindow within w_active_sheets
end type
type st_1 from statictext within w_active_sheets
end type
type ole_1 from olecustomcontrol within w_active_sheets
end type
type pb_cerrar from u_pb_cerrar within w_active_sheets
end type
type gb_1 from groupbox within w_active_sheets
end type
end forward

global type w_active_sheets from w_a
int X=567
int Y=348
int Width=2706
int Height=816
WindowType WindowType=response!
boolean TitleBar=true
string Title="Ventanas Activas"
long BackColor=79741120
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event ue_nuevo pbm_custom13
dw_1 dw_1
st_1 st_1
ole_1 ole_1
pb_cerrar pb_cerrar
gb_1 gb_1
end type
global w_active_sheets w_active_sheets

type variables
PRIVATE:
string     boton, dw_error
integer   ii_txt_timer
boolean ib_espero
str_active_sheet str_as

end variables

forward prototypes
public subroutine wf_display_text (statictext stxt, picturebutton pb_tag)
end prototypes

public subroutine wf_display_text (statictext stxt, picturebutton pb_tag);If (boton = pb_tag.tag) and (stxt.visible = true) Then Return
If (boton = pb_tag.tag) and (stxt.visible = false) Then Return

If ib_espero Then
	ib_espero = false
	stxt.text = pb_tag.tag
	stxt.width = len(stxt.text) * 32
	stxt.x = this.PointerX() + 20
	stxt.y = this.PointerY() + 70
	stxt.BringToTop = True
	stxt.show()
	boton = pb_tag.tag
Else
	stxt.hide()
	stxt.x = this.PointerX() + 20
	stxt.y = this.PointerY() + 70
	ib_espero = true
End If

ii_txt_timer = 0
Timer(1, This)










end subroutine

on w_active_sheets.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_1=create st_1
this.ole_1=create ole_1
this.pb_cerrar=create pb_cerrar
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.ole_1
this.Control[iCurrent+4]=this.pb_cerrar
this.Control[iCurrent+5]=this.gb_1
end on

on w_active_sheets.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.ole_1)
destroy(this.pb_cerrar)
destroy(this.gb_1)
end on

event ue_close;call super::ue_close;Integer	li_rows, li_i


li_rows = dw_1.RowCount()

FOR li_i=1 TO li_rows
	If dw_1.GetItemString(li_i, "cerrar") = 'S' Then close(str_as.wsheet[li_i])
NEXT

This.TriggerEvent(close!)
end event

event open;call super::open;gf_center_win(this)

str_as = Message.PowerObjectParm
end event

event ue_micro;call super::ue_micro;st_1.hide()
boton = ""

end event

event timer;call super::timer;ii_txt_timer ++

If ib_espero Then
	If ii_txt_timer >= 4 Then
		st_1.hide() 
		Timer(0)
	End If
Else
	If ii_txt_timer >= 2 Then
		st_1.hide() 
		Timer(0)	
	End If
End If
end event

event ue_init;call super::ue_init;Integer	li_top, li_i


li_top = UpperBound(str_as.wSheet[]) - 1

If li_top > 0 Then
	FOR li_i=1 TO li_top
		dw_1.ScrollToRow(dw_1.InsertRow(0))
		dw_1.SetItem(li_i, "nombre", str_as.nombre[li_i])
		dw_1.SetItem(li_i, "titulo", str_as.titulo[li_i])
		dw_1.SetItem(li_i, "cerrar", 'S')
	NEXT
End If
end event

event ue_w_controls;i_b_close_x = false

end event

type st_msghlp from w_a`st_msghlp within w_active_sheets
int TabOrder=10
end type

type st_window_name from w_a`st_window_name within w_active_sheets
int X=32
end type

type dw_1 from datawindow within w_active_sheets
event micro pbm_nchittest
int X=78
int Y=180
int Width=2565
int Height=400
int TabOrder=20
boolean BringToTop=true
string DataObject="dw_active_sheets"
boolean Border=false
boolean VScrollBar=true
boolean LiveScroll=true
end type

event micro;st_1.visible = false

end event

event dberror;If sqldbcode <> 0 Then
	dw_error = sqlerrtext
	Return(1)
End If
end event

type st_1 from statictext within w_active_sheets
int X=155
int Y=128
int Width=247
int Height=76
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
string Text="none"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=15793151
long BorderColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ole_1 from olecustomcontrol within w_active_sheets
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
int X=805
int Y=36
int Width=503
int Height=72
int TabOrder=40
boolean Visible=false
boolean BringToTop=true
long BackColor=16777215
BorderStyle BorderStyle=StyleLowered!
string BinaryKey="w_active_sheets.win"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type pb_cerrar from u_pb_cerrar within w_active_sheets
event we_nchittest pbm_nchittest
int X=37
int Y=32
int TabOrder=30
end type

event ue_nchittest;call super::ue_nchittest;wf_display_text(st_1, this)
end event

type gb_1 from groupbox within w_active_sheets
int X=32
int Y=124
int Width=2619
int Height=476
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Bookman Old Style"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

