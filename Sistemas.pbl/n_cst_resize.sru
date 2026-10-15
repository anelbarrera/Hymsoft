//objectcomments  
forward
global type n_cst_resize from nonvisualobject
end type
end forward

global type n_cst_resize from nonvisualobject
end type
global n_cst_resize n_cst_resize

type prototypes
Function Boolean LockWindowUpdate(Long hWnd) Library "user32.dll"
end prototypes

type variables
Private:
Window iw_parent
Long il_parent_orig_w
Long il_parent_orig_h
s_resize_item istr_items[]
Long il_item_count = 0
end variables

forward prototypes
public function integer of_init (window aw_parent)
public function integer of_register (dragobject ado_ctrl, integer ai_move_x, integer ai_move_y, integer ai_scale_x, integer ai_scale_y)
public function integer of_doresize (long al_new_width, long al_new_height)
end prototypes

public function integer of_init (window aw_parent);
If IsNull(aw_parent) Or Not IsValid(aw_parent) Then Return -1

iw_parent = aw_parent
il_parent_orig_w = iw_parent.WorkSpaceWidth()
il_parent_orig_h = iw_parent.WorkSpaceHeight()

Return 1
end function

public function integer of_register (dragobject ado_ctrl, integer ai_move_x, integer ai_move_y, integer ai_scale_x, integer ai_scale_y);
If IsNull(ado_ctrl) Or Not IsValid(ado_ctrl) Then Return -1

il_item_count++
istr_items[il_item_count].wo_control    = ado_ctrl
istr_items[il_item_count].il_orig_x     = ado_ctrl.X
istr_items[il_item_count].il_orig_y     = ado_ctrl.Y
istr_items[il_item_count].il_orig_width = ado_ctrl.Width
istr_items[il_item_count].il_orig_height= ado_ctrl.Height
istr_items[il_item_count].ii_move_x     = ai_move_x
istr_items[il_item_count].ii_move_y     = ai_move_y
istr_items[il_item_count].ii_scale_x    = ai_scale_x
istr_items[il_item_count].ii_scale_y    = ai_scale_y

Return 1
end function

public function integer of_doresize (long al_new_width, long al_new_height);
Long ll_i
Long ll_delta_w, ll_delta_h
Long ll_calc_x, ll_calc_y, ll_calc_w, ll_calc_h

If il_item_count = 0 Then Return 0
If al_new_width <= 0 Or al_new_height <= 0 Then Return 0

LockWindowUpdate(Handle(iw_parent))

ll_delta_w = al_new_width - il_parent_orig_w
ll_delta_h = al_new_height - il_parent_orig_h

For ll_i = 1 To il_item_count
	If IsValid(istr_items[ll_i].wo_control) Then
		ll_calc_x = istr_items[ll_i].il_orig_x + (ll_delta_w * (istr_items[ll_i].ii_move_x / 100.0))
		ll_calc_y = istr_items[ll_i].il_orig_y + (ll_delta_h * (istr_items[ll_i].ii_move_y / 100.0))
		ll_calc_w = istr_items[ll_i].il_orig_width + (ll_delta_w * (istr_items[ll_i].ii_scale_x / 100.0))
		ll_calc_h = istr_items[ll_i].il_orig_height + (ll_delta_h * (istr_items[ll_i].ii_scale_y / 100.0))
		
		istr_items[ll_i].wo_control.Move(ll_calc_x, ll_calc_y)
		istr_items[ll_i].wo_control.Resize(ll_calc_w, ll_calc_h)
	End If
Next

LockWindowUpdate(0)

Return 1
end function

on n_cst_resize.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_resize.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on