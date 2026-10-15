forward
global type w_notas from window
end type
type dw_1 from datawindow within w_notas
end type
end forward

global type w_notas from window
integer x = 1499
integer width = 1797
integer height = 1464
boolean titlebar = true
string title = "Notas"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 0
string icon = "DosEdit5!"
windowanimationstyle openanimation = bottomroll!
windowanimationstyle closeanimation = bottomslide!
dw_1 dw_1
end type
global w_notas w_notas

on w_notas.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_notas.destroy
destroy(this.dw_1)
end on

event open;long ll_tercero
str_cc_formatos str_formato2		
str_formato2 = message.powerobjectparm
ll_tercero = str_formato2.tercero
dw_1.settransobject(sqlca)
dw_1.retrieve(str.g_financiero, str.empresa, ll_tercero)
dw_1.scrolltorow(dw_1.insertrow(0))
dw_1.setitem(dw_1.getrow(),'nota_g_financiero', str.g_financiero)
dw_1.setitem(dw_1.getrow(),'nota_empresa', str.empresa)
dw_1.setitem(dw_1.getrow(),'nota_tercero', ll_tercero)
dw_1.setitem(dw_1.getrow(),'nota_fecha', gf_fecha_serv())
dw_1.setitem(dw_1.getrow(),'nota_usuario', str.usuario)
this.x = 1500
end event

event close;dw_1.accepttext()
if dw_1.getitemstring(dw_1.rowcount(),'nota_detalle') <> '' and not isnull(dw_1.getitemstring(dw_1.rowcount(),'nota_detalle')) then
	dw_1.update()
end if
close(this)
end event

type dw_1 from datawindow within w_notas
event ue_down pbm_dwnkey
integer x = 27
integer y = 28
integer width = 1723
integer height = 1268
integer taborder = 10
string title = "none"
string dataobject = "dw_notas_clientes"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_down;if keydown(Keyescape!) then
	dw_1.accepttext()
	if dw_1.getitemstring(dw_1.rowcount(),'nota_detalle') <> '' and not isnull(dw_1.getitemstring(dw_1.rowcount(),'nota_detalle')) then
		dw_1.update()
	end if
	parent.postevent('close')
end if
end event

event itemchanged;this.accepttext()
dw_1.update()
end event

