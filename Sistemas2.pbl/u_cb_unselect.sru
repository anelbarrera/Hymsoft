//objectcomments Regresa los registros seleccionados
forward
global type u_cb_unselect from u_cba
end type
end forward

global type u_cb_unselect from u_cba
int Width=147
string Text="<"
end type
global u_cb_unselect u_cb_unselect

event constructor;call super::constructor;fu_setevent ("ue_unselect")

fu_set_microhelp ("Regresa los registros seleccionados")
end event

