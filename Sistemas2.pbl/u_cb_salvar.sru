forward
global type u_cb_salvar from u_cba
end type
end forward

global type u_cb_salvar from u_cba
string Text="&Salvar"
end type
global u_cb_salvar u_cb_salvar

event constructor;call super::constructor;fu_setevent ("ue_salvar")

fu_set_microhelp ("Salva los Cambios")
end event

