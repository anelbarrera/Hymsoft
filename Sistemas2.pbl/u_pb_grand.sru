//objectcomments PictureButton ancestor
forward
global type u_pb_grand from u_pba
end type
end forward

global type u_pb_grand from u_pba
int Width=101
int Height=89
string Tag="Otorga todos los Accesos"
string PictureName="accesos_y.bmp"
boolean OriginalSize=true
end type
global u_pb_grand u_pb_grand

event constructor;call super::constructor;fu_setevent ("ue_grand")

fu_set_microhelp ("Otorga Todos los Accesos")
end event

