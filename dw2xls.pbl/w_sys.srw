forward
global type w_sys from window
end type
type st_temp from statictext within w_sys
end type
end forward

global type w_sys from window
boolean visible = false
integer width = 2784
integer height = 772
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_temp st_temp
end type
global w_sys w_sys

on w_sys.create
this.st_temp=create st_temp
this.Control[]={this.st_temp}
end on

on w_sys.destroy
destroy(this.st_temp)
end on

type st_temp from statictext within w_sys
boolean visible = false
integer x = 1015
integer y = 208
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "0"
borderstyle borderstyle = StyleBox!
boolean focusrectangle = false
end type

