forward
global type u_pb_adicionar from u_pba
end type
end forward

global type u_pb_adicionar from u_pba
int Width=101
int Height=88
string Tag="Adicionar"
string PictureName="lapiz.bmp"
boolean OriginalSize=true
end type
global u_pb_adicionar u_pb_adicionar

event constructor;call super::constructor;fu_setevent ("ue_adicionar")

fu_set_microhelp ("Permite Adicinar Nuevos Registros")
end event

