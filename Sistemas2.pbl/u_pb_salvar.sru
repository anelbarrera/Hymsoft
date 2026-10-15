//objectcomments PictureButton ancestor
forward
global type u_pb_salvar from u_pba
end type
end forward

global type u_pb_salvar from u_pba
int Width=101
int Height=89
string Tag="Salvar"
string PictureName="3_5disk.bmp"
boolean OriginalSize=true
end type
global u_pb_salvar u_pb_salvar

event constructor;call super::constructor;fu_setevent ("ue_salvar")

fu_set_microhelp ("Salva los Cambios")
end event

