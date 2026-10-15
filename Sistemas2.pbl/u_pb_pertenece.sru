//objectcomments PictureButton ancestor
forward
global type u_pb_pertenece from u_pba
end type
end forward

global type u_pb_pertenece from u_pba
int Width=101
int Height=89
string PictureName="pertenece.bmp"
boolean OriginalSize=true
end type
global u_pb_pertenece u_pb_pertenece

event constructor;call super::constructor;fu_setevent ("ue_pertenece")

fu_set_microhelp ("Muestra la Pertenece")
end event

