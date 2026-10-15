//objectcomments  
forward
global type uo_base_module from userobject
end type
end forward

global type uo_base_module from userobject
integer width = 2800
integer height = 1800
long backcolor = 16053497
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_init ( string as_params )
end type
global uo_base_module uo_base_module

forward prototypes
public function boolean of_can_close ()
public subroutine of_init (string as_params)
end prototypes

event ue_init(string as_params);of_init(as_params)
end event

public function boolean of_can_close ();return true
end function

public subroutine of_init (string as_params);
end subroutine

on uo_base_module.create
end on

on uo_base_module.destroy
end on