//objectcomments Siguiente
forward
global type u_cb_siguiente from u_cba
end type
end forward

global type u_cb_siguiente from u_cba
string Text="&Siguiente"
end type
global u_cb_siguiente u_cb_siguiente

event constructor;call super::constructor;fu_setevent ("ue_siguiente")

fu_set_microhelp ("Muestra la Siguiente Ventana")
end event

