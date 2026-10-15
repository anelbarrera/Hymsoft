//objectcomments  
forward
global type u_vsplitter from statictext
end type
end forward

global type u_vsplitter from statictext
integer width = 23
integer height = 1184
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 134217739
string pointer = "SizeWE!"
boolean focusrectangle = false
event ue_lbuttondown pbm_lbuttondown
event ue_mousemove pbm_mousemove
event ue_lbuttonup pbm_lbuttonup
event ue_lbuttondblclk pbm_lbuttondblclk
end type
global u_vsplitter u_vsplitter

type prototypes
Function Long SetCapture(Long hWnd) Library "user32.dll"
Function Boolean ReleaseCapture() Library "user32.dll"
end prototypes

type variables
Private:
Boolean ib_dragging = False
Long    il_min_width = 800
Long    il_max_width = 3000
Long    il_last_width = 1200
Boolean ib_collapsed = False
String  is_reg_key = "HKEY_CURRENT_USER\Software\PBApp\Layout"
Window  iw_parent
end variables

forward prototypes
public function integer of_init (window aw_parent, long al_min, long al_max, string as_appname)
public function integer of_save_position ()
public function long of_restore_position ()
public function integer of_toggle_collapse ()
end prototypes

event ue_lbuttondown;
ib_dragging = True
SetCapture(Handle(This))
This.BackColor = RGB(0, 120, 215)
Return 0
end event

event ue_mousemove;
Long ll_x

If Not ib_dragging Then Return 0
If Not IsValid(iw_parent) Then Return 0

ll_x = iw_parent.PointerX()

If ll_x < il_min_width Then ll_x = il_min_width
If ll_x > il_max_width Then ll_x = il_max_width

This.X = ll_x
iw_parent.Dynamic Event ue_splitter_moved(ll_x)

Return 0
end event

event ue_lbuttonup;
If ib_dragging Then
	ib_dragging = False
	ReleaseCapture()
	This.BackColor = 134217739
	il_last_width = This.X
	ib_collapsed = False
	of_save_position()
End If
Return 0
end event

event ue_lbuttondblclk;
of_toggle_collapse()
Return 0
end event

public function integer of_init (window aw_parent, long al_min, long al_max, string as_appname);
If IsNull(aw_parent) Or Not IsValid(aw_parent) Then Return -1

iw_parent = aw_parent
If al_min > 0 Then il_min_width = al_min
If al_max > 0 Then il_max_width = al_max

If Len(Trim(as_appname)) > 0 Then
	is_reg_key = "HKEY_CURRENT_USER\Software\" + as_appname + "\Layout"
End If

Return 1
end function

public function integer of_save_position ();
RegistrySet(is_reg_key, "SplitterX", RegString!, String(This.X))
Return 1
end function

public function long of_restore_position ();
String ls_val
Long ll_saved_x

If RegistryGet(is_reg_key, "SplitterX", RegString!, ls_val) = 1 Then
	ll_saved_x = Long(ls_val)
	If ll_saved_x >= il_min_width And ll_saved_x <= il_max_width Then
		il_last_width = ll_saved_x
		Return ll_saved_x
	End If
End If

Return il_min_width
end function

public function integer of_toggle_collapse ();
Long ll_target_x

If Not IsValid(iw_parent) Then Return -1

If ib_collapsed Then
	ll_target_x = il_last_width
	ib_collapsed = False
Else
	il_last_width = This.X
	ll_target_x = 220
	ib_collapsed = True
End If

This.X = ll_target_x
iw_parent.Dynamic Event ue_splitter_moved(ll_target_x)
of_save_position()

Return 1
end function

on u_vsplitter.create
end on

on u_vsplitter.destroy
end on