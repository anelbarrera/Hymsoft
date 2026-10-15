forward
global type u_pb_buscar from u_pba
end type
end forward

global type u_pb_buscar from u_pba
int Width=101
int Height=88
string Tag="Buscar"
string PictureName="blind.bmp"
end type
global u_pb_buscar u_pb_buscar

event constructor;call super::constructor;fu_setevent ("ue_buscar")

fu_set_microhelp ("Abre una Ventana de Búsqueda")
end event

