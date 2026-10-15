//objectcomments PictureButton ancestor
forward
global type u_pb_deshacer from u_pba
end type
end forward

global type u_pb_deshacer from u_pba
int Width=252
int Height=145
string Tag="Deshacer"
string PictureName="connect3.bmp"
boolean OriginalSize=true
end type
global u_pb_deshacer u_pb_deshacer

event constructor;call super::constructor;fu_setevent ("ue_deshacer")

fu_set_microhelp ("Recupera los Registros Borrados en su Orden Contrario")
end event

