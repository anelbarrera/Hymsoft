forward
global type u_cb_login from u_cba
end type
end forward

global type u_cb_login from u_cba
string Text="&Login"
end type
global u_cb_login u_cb_login

event constructor;call super::constructor;fu_setevent ("ue_login")

fu_set_microhelp ("Realiza la Entrada del Usuario")
end event

