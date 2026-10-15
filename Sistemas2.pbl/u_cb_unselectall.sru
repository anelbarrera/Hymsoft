//objectcomments Regresa todos los registros
forward
global type u_cb_unselectall from u_cba
end type
end forward

global type u_cb_unselectall from u_cba
int Width=147
string Text="<<"
end type
global u_cb_unselectall u_cb_unselectall

event constructor;call super::constructor;fu_setevent ("ue_unselectall")

fu_set_microhelp ("Regresa todos los registros")
end event

