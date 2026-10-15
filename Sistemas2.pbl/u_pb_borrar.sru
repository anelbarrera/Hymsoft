//objectcomments PictureButton ancestor
forward
global type u_pb_borrar from u_pba
end type
end forward

global type u_pb_borrar from u_pba
int Width=101
int Height=89
string Tag="Borrar"
string PictureName="dellettr.bmp"
boolean OriginalSize=true
end type
global u_pb_borrar u_pb_borrar

event constructor;call super::constructor;fu_setevent ("ue_borrar")

fu_set_microhelp ("Permite Borrar la Linea Seleccionada")
end event

