forward
global type w_select_proceso from window
end type
type cb_3 from commandbutton within w_select_proceso
end type
type cb_2 from commandbutton within w_select_proceso
end type
type cb_1 from commandbutton within w_select_proceso
end type
end forward

global type w_select_proceso from window
integer width = 736
integer height = 580
boolean titlebar = true
string title = "Opciones"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 134217728
string icon = "AppIcon!"
boolean center = true
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_select_proceso w_select_proceso

type variables
string vis_return = '0'
end variables

on w_select_proceso.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_select_proceso.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event close;closewithreturn(this,vis_return)
end event

type cb_3 from commandbutton within w_select_proceso
integer x = 73
integer y = 324
integer width = 567
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cerrar"
boolean cancel = true
end type

event clicked;vis_return = '0'
close(parent)

end event

type cb_2 from commandbutton within w_select_proceso
integer x = 73
integer y = 184
integer width = 567
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Restaurar Backup"
end type

event clicked;vis_return = '2'
close(parent)
end event

type cb_1 from commandbutton within w_select_proceso
integer x = 73
integer y = 48
integer width = 567
integer height = 112
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crear &Backup"
end type

event clicked;vis_return = '1'
close(parent)
end event

