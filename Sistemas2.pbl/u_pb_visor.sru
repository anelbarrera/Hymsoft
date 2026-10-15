//objectcomments PictureButton ancestor
forward
global type u_pb_visor from u_pba
end type
end forward

global type u_pb_visor from u_pba
int Width=115
string Tag="Visor"
string PictureName="ojo_1.bmp"
boolean OriginalSize=true
end type
global u_pb_visor u_pb_visor

event constructor;call super::constructor;fu_setevent ("ue_spy")

fu_set_microhelp ("Abre el Visor de Accesos y Modificaciones")
end event

