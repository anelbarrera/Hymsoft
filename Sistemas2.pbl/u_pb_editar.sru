//objectcomments PictureButton ancestor
forward
global type u_pb_editar from u_pba
end type
end forward

global type u_pb_editar from u_pba
int Width=101
int Height=89
string Tag="Editar"
string PictureName="hand3.bmp"
boolean OriginalSize=true
end type
global u_pb_editar u_pb_editar

event constructor;call super::constructor;fu_setevent ("ue_editar")

fu_set_microhelp ("Permite Editar los Registros")
end event

