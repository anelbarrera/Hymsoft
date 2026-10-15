forward
global type u_pb_revoke from u_pba
end type
end forward

global type u_pb_revoke from u_pba
int Width=101
int Height=89
string Tag="Deniega todos los Accesos"
string PictureName="accesos_x.bmp"
boolean OriginalSize=true
end type
global u_pb_revoke u_pb_revoke

event constructor;call super::constructor;fu_setevent ("ue_revoke")

fu_set_microhelp ("Deniega Todos los Accesos")
end event

