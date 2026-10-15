forward
global type u_cb_aceptar from u_cba
end type
end forward

global type u_cb_aceptar from u_cba
string Text="&Aceptar"
end type
global u_cb_aceptar u_cb_aceptar

event constructor;call super::constructor;fu_setevent ("ue_aceptar")

fu_set_microhelp ("Salva los Cambios y Cierra la Ventana")
end event

