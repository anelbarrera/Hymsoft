//objectcomments Terminar del Wizzard
forward
global type u_cb_terminar from u_cba
end type
end forward

global type u_cb_terminar from u_cba
string Text="&Terminar"
end type
global u_cb_terminar u_cb_terminar

event constructor;call super::constructor;fu_setevent ("ue_terminar")

fu_set_microhelp ("Finaliza la Ejecución del Wizzard con la Información Introducida")
end event

