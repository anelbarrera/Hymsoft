//objectcomments PictureButton ancestor
forward
global type u_pb_filtrar from u_pba
end type
end forward

global type u_pb_filtrar from u_pba
int Width=101
int Height=89
string Tag="Filtrar"
string PictureName="filtro.bmp"
boolean OriginalSize=true
end type
global u_pb_filtrar u_pb_filtrar

event constructor;call super::constructor;fu_setevent ("ue_filtrar")

fu_set_microhelp ("Permite Filtrar los Datos")
end event

