forward
global type w_asigna_cantidades from window
end type
type cb_2 from commandbutton within w_asigna_cantidades
end type
type cb_1 from commandbutton within w_asigna_cantidades
end type
type dw_1 from datawindow within w_asigna_cantidades
end type
end forward

global type w_asigna_cantidades from window
integer width = 1143
integer height = 760
boolean titlebar = true
string title = "Asignar Cantidades"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 15780518
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_asigna_cantidades w_asigna_cantidades

event open;dw_1.settransobject(sqlca)
dw_1.insertrow(1)
dw_1.setfocus()
end event

on w_asigna_cantidades.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_asigna_cantidades.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_2 from commandbutton within w_asigna_cantidades
integer x = 599
integer y = 524
integer width = 402
integer height = 104
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Cancelar"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_asigna_cantidades
integer x = 128
integer y = 524
integer width = 402
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Aceptar"
end type

event clicked;str_cantidades_producto lstr_cantidades

dw_1.accepttext()

lstr_cantidades.minima = dw_1.getitemnumber(1,'minima')
lstr_cantidades.reorden = dw_1.getitemnumber(1,'reorden')
lstr_cantidades.maxima = dw_1.getitemnumber(1,'maxima')

closewithreturn(parent, lstr_cantidades)
end event

type dw_1 from datawindow within w_asigna_cantidades
integer x = 82
integer y = 68
integer width = 951
integer height = 376
integer taborder = 10
string title = "none"
string dataobject = "dw_external_cantidades"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

