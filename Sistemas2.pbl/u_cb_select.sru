//objectcomments Mueve los registros seleccionados
forward
global type u_cb_select from u_cba
end type
end forward

global type u_cb_select from u_cba
int Width=147
string Text=">"
end type
global u_cb_select u_cb_select

event constructor;call super::constructor;fu_setevent ("ue_select")

fu_set_microhelp ("Mueve los registros seleccionados")
end event

