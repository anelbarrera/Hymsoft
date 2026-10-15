forward
global type w_factura_eliminar_modificar from window
end type
type dw_3 from datawindow within w_factura_eliminar_modificar
end type
type dw_2 from datawindow within w_factura_eliminar_modificar
end type
type cb_2 from commandbutton within w_factura_eliminar_modificar
end type
type cb_1 from commandbutton within w_factura_eliminar_modificar
end type
type dw_1 from datawindow within w_factura_eliminar_modificar
end type
type em_ann from editmask within w_factura_eliminar_modificar
end type
type st_2 from statictext within w_factura_eliminar_modificar
end type
type st_1 from statictext within w_factura_eliminar_modificar
end type
type sle_factura from singlelineedit within w_factura_eliminar_modificar
end type
end forward

global type w_factura_eliminar_modificar from window
integer width = 3369
integer height = 2588
boolean titlebar = true
string title = "Modificacion de Fechas"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_3 dw_3
dw_2 dw_2
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
em_ann em_ann
st_2 st_2
st_1 st_1
sle_factura sle_factura
end type
global w_factura_eliminar_modificar w_factura_eliminar_modificar

type variables
integer  ii_ann

end variables

on w_factura_eliminar_modificar.create
this.dw_3=create dw_3
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.em_ann=create em_ann
this.st_2=create st_2
this.st_1=create st_1
this.sle_factura=create sle_factura
this.Control[]={this.dw_3,&
this.dw_2,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.em_ann,&
this.st_2,&
this.st_1,&
this.sle_factura}
end on

on w_factura_eliminar_modificar.destroy
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.em_ann)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_factura)
end on

event open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)

ii_ann = year(date(gf_fecha_serv()))
em_ann.text = string(ii_ann)

sqlca.autocommit = true

end event

event resize;dw_1.width = newwidth - 100
dw_2.width = newwidth - 100
dw_3.width = newwidth - 100

end event

type dw_3 from datawindow within w_factura_eliminar_modificar
integer x = 55
integer y = 1044
integer width = 3145
integer height = 428
integer taborder = 40
boolean titlebar = true
string title = "Contabilidad"
string dataobject = "dw_conta_eliminar"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_factura_eliminar_modificar
integer x = 55
integer y = 608
integer width = 3145
integer height = 432
integer taborder = 40
boolean titlebar = true
string title = "Movimiento de CXC"
string dataobject = "dw_movim_eliminar"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_factura_eliminar_modificar
integer x = 2565
integer y = 48
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar"
end type

event clicked;if gf_mensaje('','Seguro de Actualizar ?',2,1,'Q') = 2 then return

sqlca.autocommit = false

if dw_1.update() = -1 then
	gf_mensaje('','Error en Factura '+sqlca.sqlerrtext,1,1,'E')
	rollback;
	sqlca.autocommit = true
	return
elseif dw_2.update() = -1 then
	gf_mensaje('','Error en Movimiento de Cxc '+sqlca.sqlerrtext,1,1,'E')
	rollback;
	sqlca.autocommit = true
	return
elseif dw_3.update() = -1 then
	gf_mensaje('','Error en Inventarios '+sqlca.sqlerrtext,1,1,'E')
	rollback;
	sqlca.autocommit = true
	return	
end if

commit ;

sqlca.autocommit = true
end event

type cb_1 from commandbutton within w_factura_eliminar_modificar
integer x = 1961
integer y = 44
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Eliminar"
end type

type dw_1 from datawindow within w_factura_eliminar_modificar
integer x = 55
integer y = 176
integer width = 3145
integer height = 424
integer taborder = 30
boolean titlebar = true
string title = "Factura"
string dataobject = "dw_facturas_eliminar"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;date ldt_fecha
this.accepttext()
if dwo.name = 'fact_fecha' then
	ldt_fecha = date(this.getitemdatetime(1,'fact_fecha'))
	if dw_2.rowcount() > 0 then	dw_2.setitem(1,'movi_fecha_tran',ldt_fecha)
	if dw_3.rowcount() > 0 then	dw_3.setitem(1,'diar_fecha_transaccion',ldt_fecha)
//	if dw_3.rowcount() > 1 then	
//		dw_3.setitem(1,'tdia_fecha_transaccion',ldt_fecha)
//		dw_3.setitem(2,'tdia_fecha_transaccion',ldt_fecha)
//	end if
end if
end event

type em_ann from editmask within w_factura_eliminar_modificar
integer x = 864
integer y = 16
integer width = 302
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###0"
boolean spin = true
double increment = 1
string minmax = "2010~~4000"
end type

event modified;ii_ann = integer(em_ann.text)
end event

type st_2 from statictext within w_factura_eliminar_modificar
integer x = 722
integer y = 40
integer width = 155
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_factura_eliminar_modificar
integer x = 18
integer y = 36
integer width = 247
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Factura:"
boolean focusrectangle = false
end type

type sle_factura from singlelineedit within w_factura_eliminar_modificar
integer x = 274
integer y = 12
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;string ls_factura

ls_factura = sle_factura.text

dw_1.retrieve(str.g_financiero, str.empresa, ls_factura, ii_ann)
dw_2.retrieve(str.g_financiero, str.empresa, ls_factura, ii_ann)
dw_3.retrieve(str.g_financiero, str.empresa, ls_factura, ii_ann)
end event

