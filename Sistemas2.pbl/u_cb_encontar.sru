//objectcomments Standard "Close" button
forward
global type u_cb_encontar from u_cba
end type
end forward

global type u_cb_encontar from u_cba
int Width=293
int Height=81
string Text="&Encontrar"
string FaceName="Bookman Old Style"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type
global u_cb_encontar u_cb_encontar

event constructor;call super::constructor;fu_setevent ("ue_encontrar")

fu_set_microhelp ("Encuentra el Registro Deseado")
end event

