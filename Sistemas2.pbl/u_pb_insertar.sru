//objectcomments PictureButton ancestor
forward
global type u_pb_insertar from u_pba
end type
end forward

global type u_pb_insertar from u_pba
int Width=101
int Height=89
string Tag="Insertar"
string PictureName="inkpen.bmp"
boolean OriginalSize=true
end type
global u_pb_insertar u_pb_insertar

event constructor;call super::constructor;fu_setevent ("ue_insertar")

fu_set_microhelp ("Permite Insertar Nuevos Registros")
end event

