//objectcomments Busqueda
forward
global type w_fa_man_busqueda from window
end type
type cb_2 from commandbutton within w_fa_man_busqueda
end type
type cb_1 from commandbutton within w_fa_man_busqueda
end type
type sle_prod from singlelineedit within w_fa_man_busqueda
end type
type cb_buscar from commandbutton within w_fa_man_busqueda
end type
type gb_1 from groupbox within w_fa_man_busqueda
end type
end forward

global type w_fa_man_busqueda from window
integer x = 750
integer y = 500
integer width = 1143
integer height = 484
boolean titlebar = true
string title = "(FA) Busqueda ..."
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
cb_2 cb_2
cb_1 cb_1
sle_prod sle_prod
cb_buscar cb_buscar
gb_1 gb_1
end type
global w_fa_man_busqueda w_fa_man_busqueda

type variables
window iw_window
end variables

on w_fa_man_busqueda.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_prod=create sle_prod
this.cb_buscar=create cb_buscar
this.gb_1=create gb_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.sle_prod,&
this.cb_buscar,&
this.gb_1}
end on

on w_fa_man_busqueda.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_prod)
destroy(this.cb_buscar)
destroy(this.gb_1)
end on

event open;iw_window = message.powerobjectparm

sle_prod.text = iw_window.dynamic wf_asigna_ultima_busqueda()
end event

event close;close(this)
end event

type cb_2 from commandbutton within w_fa_man_busqueda
integer x = 430
integer y = 260
integer width = 261
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Linea"
end type

event clicked;//Para asignar la busqueda y luego cerrar, el 0 indica que es referencia
iw_window.dynamic wf_asigna_busqueda(sle_prod.text, 1)
parent.postevent("close")
end event

type cb_1 from commandbutton within w_fa_man_busqueda
integer x = 827
integer y = 260
integer width = 261
integer height = 104
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
end type

event clicked;//para que no busque en el detalle y cierre
iw_window.dynamic wf_asigna_busqueda('',0)
parent.postevent("close")
end event

type sle_prod from singlelineedit within w_fa_man_busqueda
event ue_key pbm_dwnkey
integer x = 178
integer y = 80
integer width = 768
integer height = 88
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event ue_key;if Key = KeyEscape! then
	this.Postevent("close")
end if
end event

type cb_buscar from commandbutton within w_fa_man_busqueda
integer x = 32
integer y = 260
integer width = 261
integer height = 104
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Buscar"
boolean default = true
end type

event clicked;//Para asignar la busqueda y luego cerrar, el 0 indica que es referencia
iw_window.dynamic wf_asigna_busqueda(sle_prod.text, 0)
parent.postevent("close")
end event

type gb_1 from groupbox within w_fa_man_busqueda
integer x = 23
integer y = 4
integer width = 1074
integer height = 220
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
borderstyle borderstyle = stylelowered!
end type

