forward
global type w_analisis_de_compras from window
end type
type dw_1 from datawindow within w_analisis_de_compras
end type
end forward

global type w_analisis_de_compras from window
integer x = 1499
integer width = 3721
integer height = 1464
boolean titlebar = true
string title = "Análisis de Compras"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 12632256
string icon = "AppIcon!"
windowanimationstyle openanimation = toproll!
windowanimationstyle closeanimation = topslide!
dw_1 dw_1
end type
global w_analisis_de_compras w_analisis_de_compras

on w_analisis_de_compras.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_analisis_de_compras.destroy
destroy(this.dw_1)
end on

event open;long ll_tercero
str_cc_formatos str_formato2		
str_formato2 = message.powerobjectparm
ll_tercero = str_formato2.tercero
dw_1.settransobject(sqlca)
dw_1.retrieve(str.g_financiero, str.empresa, ll_tercero)
this.x = 1500
end event

event close;This.setredraw(false)
close(this)
end event

type dw_1 from datawindow within w_analisis_de_compras
event ue_down pbm_dwnkey
integer x = 27
integer y = 28
integer width = 3657
integer height = 1268
integer taborder = 10
string title = "none"
string dataobject = "dw_analisis"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_down;if keydown(Keyescape!) then
	parent.postevent('close')
end if
end event

event clicked;if dwo.name = 'b_cerrar' then
	parent.triggerevent('close')
end if
end event

