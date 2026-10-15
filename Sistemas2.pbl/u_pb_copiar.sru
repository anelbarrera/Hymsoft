//objectcomments PictureButton ancestor
forward
global type u_pb_copiar from u_pba
end type
end forward

global type u_pb_copiar from u_pba
int Width=101
int Height=89
string Tag="Copiar"
string PictureName="book.bmp"
boolean OriginalSize=true
end type
global u_pb_copiar u_pb_copiar

event constructor;call super::constructor;fu_setevent ("ue_copiar")

fu_set_microhelp ("Copia...")
end event

