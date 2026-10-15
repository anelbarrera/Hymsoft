forward
global type w_imagen from window
end type
type st_1 from statictext within w_imagen
end type
type pb_1 from picturebutton within w_imagen
end type
type p_1 from picture within w_imagen
end type
type gb_1 from groupbox within w_imagen
end type
end forward

global type w_imagen from window
integer width = 3835
integer height = 2704
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
windowanimationstyle openanimation = centeranimation!
windowanimationstyle closeanimation = fadeanimation!
st_1 st_1
pb_1 pb_1
p_1 p_1
gb_1 gb_1
end type
global w_imagen w_imagen

on w_imagen.create
this.st_1=create st_1
this.pb_1=create pb_1
this.p_1=create p_1
this.gb_1=create gb_1
this.Control[]={this.st_1,&
this.pb_1,&
this.p_1,&
this.gb_1}
end on

on w_imagen.destroy
destroy(this.st_1)
destroy(this.pb_1)
destroy(this.p_1)
destroy(this.gb_1)
end on

event open;string ls_foto

ls_foto = Message.StringParm
p_1.picturename = ls_foto

this.title = "Imagen "+ls_foto

gb_1.width = this.width - 100
gb_1.width = this.height - 100
end event

event resize;gb_1.width = newwidth - 25
gb_1.height= newheight - 25

//p_1.height = newheight - 175
end event

type st_1 from statictext within w_imagen
boolean visible = false
integer x = 41
integer y = 176
integer width = 251
integer height = 68
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Imprimir"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

event clicked;pb_1.triggerevent('clicked')
end event

type pb_1 from picturebutton within w_imagen
boolean visible = false
integer x = 110
integer y = 72
integer width = 110
integer height = 96
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "Print!"
alignment htextalign = left!
string powertiptext = "Imprimir la Foto ..."
end type

event clicked;long Job, ll_x, ll_y, ll_height,ll_width

Job = PrintOpen('Print Picture' , False)

ll_x = p_1.x
ll_y = p_1.y
ll_width = p_1.width
ll_height = p_1.height

p_1.Print(Job, ll_x, ll_y) //, 500, 1000 ) //ll_width,ll_height)

PrintClose(Job)
end event

type p_1 from picture within w_imagen
integer x = 754
integer y = 100
integer width = 2519
integer height = 2528
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_imagen
integer x = 18
integer y = 16
integer width = 3799
integer height = 2244
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

