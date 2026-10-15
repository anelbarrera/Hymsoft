//objectcomments Standard "Close" button
forward
global type u_cb_close from u_cba
end type
end forward

global type u_cb_close from u_cba
string Text="&Cerrar"
end type
global u_cb_close u_cb_close

on constructor;call u_cba::constructor;fu_setevent ("ue_close")

fu_set_microhelp ("Cierra la Ventana")
end on

