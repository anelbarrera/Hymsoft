//objectcomments Mueve todos los registros
forward
global type u_cb_selectall from u_cba
end type
end forward

global type u_cb_selectall from u_cba
int Width=147
string Text=">>"
end type
global u_cb_selectall u_cb_selectall

event constructor;call super::constructor;fu_setevent ("ue_selectall")

fu_set_microhelp ("Mueve todos los registros")
end event

