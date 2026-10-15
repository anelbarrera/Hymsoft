//objectcomments PictureButton de encontrar
forward
global type u_pb_find from u_pba
end type
end forward

global type u_pb_find from u_pba
int Width=101
int Height=89
string Tag="Encontrar"
string PictureName="find.bmp"
end type
global u_pb_find u_pb_find

event constructor;call super::constructor;fu_setevent ("ue_find")

fu_set_microhelp ("Encuentra un Item")
end event

