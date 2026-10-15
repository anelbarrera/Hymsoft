forward
global type w_ajustes_caja from window
end type
type uo_1 from u_ddcalen within w_ajustes_caja
end type
type cb_2 from commandbutton within w_ajustes_caja
end type
type cb_1 from commandbutton within w_ajustes_caja
end type
type dw_1 from datawindow within w_ajustes_caja
end type
end forward

global type w_ajustes_caja from window
integer width = 2107
integer height = 960
boolean titlebar = true
string title = "Ajustes de Caja"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12639424
windowanimationstyle openanimation = bottomroll!
windowanimationstyle closeanimation = bottomslide!
uo_1 uo_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_ajustes_caja w_ajustes_caja

on w_ajustes_caja.create
this.uo_1=create uo_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.uo_1,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_ajustes_caja.destroy
destroy(this.uo_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;this.y = 0
this.x = 805
sqlca.autocommit = true
datetime ldt_fecha
if dw_1.rowcount() > 0 then
	ldt_fecha = dw_1.getitemdatetime(1,'caja_fecha_inicio')
else
	ldt_fecha = datetime(date(gf_fecha_serv()))
end if
dw_1.settransobject(sqlca)
if dw_1.retrieve(str.g_financiero, str.empresa, 1, ldt_fecha) = 0 then
	dw_1.insertrow(1)
	dw_1.setitem(1,'caja_g_financiero', str.g_financiero)
	dw_1.setitem(1,'caja_empresa', str.empresa)
	dw_1.setitem(1,'caja_id',1)
	dw_1.setitem(1,'caja_fecha_inicio',ldt_fecha)	
	dw_1.setitem(1,'caja_fecha_cierre',ldt_fecha)		
	dw_1.setitem(1,'caja_cerrada',0)	
end if
end event

event close;Window lw_frame

lw_frame = ParentWindow()

If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_sheet_closed")
 End If
end event

type uo_1 from u_ddcalen within w_ajustes_caja
event destroy ( )
boolean visible = false
integer x = 1253
integer y = 112
integer taborder = 31
boolean bringtotop = true
end type

on uo_1.destroy
call u_ddcalen::destroy
end on

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;dw_1.SetItem ( dw_1.getrow(), 'caja_fecha_inicio', uo_1.return_sel_date() )

if uo_1.allow_close then
	this.visible=false
	dw_1.SetFocus()
end if


end event

type cb_2 from commandbutton within w_ajustes_caja
integer x = 1134
integer y = 604
integer width = 402
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar"
end type

event clicked;dw_1.accepttext()
if dw_1.update() = -1 then
	gf_mensaje('','Error al grabar el ajuste '+sqlca.sqlerrtext,1,1,'E')
end if
end event

type cb_1 from commandbutton within w_ajustes_caja
integer x = 585
integer y = 608
integer width = 402
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_ajustes_caja
event ue_down pbm_dwnkey
integer x = 46
integer y = 20
integer width = 1984
integer height = 544
integer taborder = 10
string title = "none"
string dataobject = "dw_ajustes_caja"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_down;if keydown(Keyescape!) then
	close(parent)
end if
end event

event itemchanged;this.accepttext()
if dwo.name = 'caja_fecha_inicio' then
	parent.triggerevent('open')
end if
end event

event clicked;accepttext()
date 	ld_date,ld_ini_date, ld_hoy
ld_hoy = date(gf_fecha_serv())
if dwo.name='calendario' then
	ld_ini_date=date(dw_1.GetItemDateTime(dw_1.getrow(),"caja_fecha_inicio"))
	if year(ld_ini_date) = 1900 then
		ld_ini_date = ld_hoy
	end if
	if uo_1.visible=false then
		uo_1.wf_set_value(ld_ini_date)
		uo_1.visible=true
		uo_1.allow_close=false
		uo_1.inicializar()
		uo_1.TriggerEvent('ue_abrir')
	end if
end if
end event

