//objectcomments PictureButton ancestor
forward
global type u_pb_ordenar from u_pba
end type
end forward

global type u_pb_ordenar from u_pba
int Width=101
int Height=89
string Tag="Ordenar"
string PictureName="sort.bmp"
boolean OriginalSize=true
end type
global u_pb_ordenar u_pb_ordenar

event constructor;call super::constructor;fu_setevent ("ue_ordenar")

fu_set_microhelp ("Permite Ordenar los Campos")
end event

