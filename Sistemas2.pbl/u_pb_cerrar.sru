//objectcomments PictureButton ancestor
forward
global type u_pb_cerrar from u_pba
end type
end forward

global type u_pb_cerrar from u_pba
int Width=101
int Height=89
string Tag="Cerrar"
string PictureName="exit.bmp"
boolean OriginalSize=true
end type
global u_pb_cerrar u_pb_cerrar

event constructor;call super::constructor;fu_setevent ("ue_close")

fu_set_microhelp ("Cierra la Hoja")
end event

