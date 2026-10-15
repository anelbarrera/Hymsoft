//objectcomments Cancelar
forward
global type u_cb_cancelar from u_cba
end type
end forward

global type u_cb_cancelar from u_cba
string Text="&Cancelar"
end type
global u_cb_cancelar u_cb_cancelar

event constructor;call super::constructor;fu_setevent ("ue_cancelar")

fu_set_microhelp ("Cancela la Ejecución")
end event

