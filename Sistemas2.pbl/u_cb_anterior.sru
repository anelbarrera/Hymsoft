//objectcomments Anterior
forward
global type u_cb_anterior from u_cba
end type
end forward

global type u_cb_anterior from u_cba
string Text="&Anterior"
end type
global u_cb_anterior u_cb_anterior

event constructor;call super::constructor;fu_setevent ("ue_anterior")

fu_set_microhelp ("Muestra la Ventana Anterior")
end event

