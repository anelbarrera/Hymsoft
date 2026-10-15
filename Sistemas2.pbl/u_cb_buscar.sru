//objectcomments Standard "Close" button
forward
global type u_cb_buscar from u_cba
end type
end forward

global type u_cb_buscar from u_cba
string Text="&Buscar"
end type
global u_cb_buscar u_cb_buscar

event constructor;call super::constructor;fu_setevent ("ue_buscar")

fu_set_microhelp ("Abre la Ventana de Busqueda")
end event

