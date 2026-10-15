forward
global type u_cb_cambiar from u_cba
end type
end forward

global type u_cb_cambiar from u_cba
string Text="C&ambiar"
end type
global u_cb_cambiar u_cb_cambiar

event constructor;call super::constructor;fu_setevent ("ue_cambiar")

fu_set_microhelp ("Cambia la Clave del Usuario")
end event

