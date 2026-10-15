forward
global type w_a_wizzard from w_a
end type
type cb_1 from u_cb_anterior within w_a_wizzard
end type
type cb_2 from u_cb_siguiente within w_a_wizzard
end type
type cb_3 from u_cb_cancelar within w_a_wizzard
end type
type cb_4 from u_cb_terminar within w_a_wizzard
end type
type p_1 from picture within w_a_wizzard
end type
end forward

shared variables
Window sw_ventanas[]
Long      sl_x, sl_y
end variables

global type w_a_wizzard from w_a
int Width=2702
WindowType WindowType=response!
boolean TitleBar=true
string Title=""
long BackColor=79741120
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event ue_siguiente pbm_custom15
event ue_anterior pbm_custom16
event ue_cancelar pbm_custom17
event ue_terminar pbm_custom18
event ue_post_anterior pbm_custom20
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
p_1 p_1
end type
global w_a_wizzard w_a_wizzard

type variables
String        boton
Boolean    ib_espero
Integer      ii_txt_timer
end variables

forward prototypes
public subroutine wf_new_window ()
public subroutine wf_close_wizzard ()
public subroutine wf_siguiente ()
public subroutine wf_anterior ()
public subroutine wf_set_picture (string as_picture)
public subroutine wf_display_text (statictext stxt, picturebutton pb_tag)
public subroutine wf_set_xy_anterior ()
end prototypes

event ue_siguiente;sl_x = This.x
sl_y = This.y
end event

event ue_anterior;This.PostEvent("ue_post_anterior")
end event

event ue_cancelar;call super::ue_cancelar;This.TriggerEvent("ue_close")
end event

event ue_post_anterior;wf_anterior()
end event

public subroutine wf_new_window ();Integer li_bound


li_bound = UpperBound(sw_ventanas[])

If li_bound < 1 Then
	sw_ventanas[1] = this
Else
	li_bound ++
	sw_ventanas[li_bound] = this
End If
end subroutine

public subroutine wf_close_wizzard ();Integer li_i, li_bound


li_bound = UpperBound(sw_ventanas[])

FOR li_i=li_bound TO 1 STEP -1
	If Not IsValid(sw_ventanas[li_i]) Then Continue
	
	Close(sw_ventanas[li_i])
NEXT

end subroutine

public subroutine wf_siguiente ();Integer li_i, li_bound, li_cont
Window  lw_ventanas[]
//------
/////////////////////////////////////////////////////////
li_bound = UpperBound(sw_ventanas[])

FOR li_i=1 TO li_bound
	If	Not IsValid(sw_ventanas[li_i]) Then Continue
	
	li_cont ++
	lw_ventanas[li_cont] = sw_ventanas[li_i]
NEXT

sw_ventanas = lw_ventanas
//------
li_bound = UpperBound(sw_ventanas[]) - 1

FOR li_i=li_bound TO 1 STEP -1
	
	If Not IsValid(sw_ventanas[li_i]) Then Continue
	If Not sw_ventanas[li_i].visible Then Continue
	
	sw_ventanas[li_bound].hide()
	
	Exit
NEXT


end subroutine

public subroutine wf_anterior ();Integer li_i, li_bound, li_temp


li_bound = UpperBound(sw_ventanas[])

li_temp = li_bound + 1

sl_x = This.x
sl_y = This.y

FOR li_i = li_bound TO 1 STEP -1
	li_temp --
	
	If Not IsValid(sw_ventanas[li_i]) Then Continue
	If Not sw_ventanas[li_i].visible Then Continue
	
	li_temp --
	sw_ventanas[li_temp].Dynamic wf_set_xy_anterior()
	sw_ventanas[li_temp].show()
	
	li_temp ++
	Close(sw_ventanas[li_temp])
	
	Exit
NEXT
end subroutine

public subroutine wf_set_picture (string as_picture);p_1.picturename = str.path + "Art\" + as_picture
end subroutine

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

public subroutine wf_set_xy_anterior ();This.x = sl_x
This.y = sl_y
end subroutine

on w_a_wizzard.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_4
this.Control[iCurrent+5]=this.p_1
end on

on w_a_wizzard.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.p_1)
end on

event open;call super::open;If sl_x > 0 Or sl_y > 0 Then
	If sl_x > 0 Then
		This.x = sl_x
	End If

	If sl_y > 0 Then
		This.y = sl_y
	End If
End If

If sl_x = 0 Or sl_y = 0 Then
Else
	gf_center_win(this)
End If

This.Icon = str.icono

wf_new_window()
end event

event ue_close;call super::ue_close;wf_close_wizzard()
end event

event ue_init;call super::ue_init;If UpperBound(sw_ventanas[]) > 1 Then	wf_siguiente()

wf_set_picture("wizzard_br.bmp")

end event

event timer;call super::timer;ii_txt_timer ++

If ib_espero Then
	If ii_txt_timer >= 4 Then
		st_msghlp.hide() 
		Timer(0)
	End If
Else
	If ii_txt_timer >= 2 Then
		st_msghlp.hide() 
		Timer(0)	
	End If
End If
end event

type st_msghlp from w_a`st_msghlp within w_a_wizzard
int X=878
int Y=120
int Width=151
int TabOrder=50
end type

type st_window_name from w_a`st_window_name within w_a_wizzard
int Width=882
long BackColor=79741120
end type

type cb_1 from u_cb_anterior within w_a_wizzard
int X=1582
int Y=996
int TabOrder=40
end type

type cb_2 from u_cb_siguiente within w_a_wizzard
int X=1934
int Y=996
int TabOrder=30
boolean Default=true
end type

type cb_3 from u_cb_cancelar within w_a_wizzard
int X=1230
int Y=996
int TabOrder=20
end type

type cb_4 from u_cb_terminar within w_a_wizzard
int X=2286
int Y=996
int TabOrder=10
boolean Enabled=false
end type

type p_1 from picture within w_a_wizzard
int X=32
int Y=48
int Width=425
int Height=920
boolean BringToTop=true
string PictureName="\harr2000\art\wizzard_br.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

