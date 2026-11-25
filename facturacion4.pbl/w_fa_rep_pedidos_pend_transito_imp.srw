//objectcomments Ventana donde se establece la Fecha hasta la cual se desea obtener el informe de los pedidos pendientes de facturar en Transito Impresion
forward
global type w_fa_rep_pedidos_pend_transito_imp from w_fa_padre_reportes
end type
end forward

global type w_fa_rep_pedidos_pend_transito_imp from w_fa_padre_reportes
integer width = 2912
integer height = 1524
string title = "(FA) Reporte de Pedidos Confirmados o en Tránsito"
string menuname = "m_hs"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
end type
global w_fa_rep_pedidos_pend_transito_imp w_fa_rep_pedidos_pend_transito_imp

type variables

end variables

on w_fa_rep_pedidos_pend_transito_imp.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_hs" then this.MenuID = create m_hs
end on

on w_fa_rep_pedidos_pend_transito_imp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;str_rangofecha lstr_rangfech
string ls_empresa
datetime	ldt_fecha1,ldt_fecha2
string ls_reserva[]

lstr_rangfech = message.powerObjectParm
ldt_fecha1 = datetime(lstr_rangfech.fecha1,00:00:00)
ldt_fecha2 = datetime(lstr_rangfech.fecha2,23:59:59)

dw = dw_1
dw.settransobject(sqlca)
dw.object.fecha_repo.expression= "'Del día: "+string(lstr_rangfech.fecha1)+" al "+string(lstr_rangfech.fecha2)+"'"
dw.object.data_window.expression= "'"+dw_1.dataobject+"'"
ls_empresa = gf_dg_nombre_empresa()
if dw.Describe("nomb_empresa.x") <> "?" and dw.Describe("nomb_empresa.x") <> "!" then &
dw.object.nomb_empresa.expression= "'"+ls_empresa+"'"

dw.Object.datawindow.print.preview = true
if lstr_rangfech.opcion = 'Ambos' then
	ls_reserva[1] = 'T'
	ls_reserva[2] = 'C'
	dw.retrieve(str.g_financiero,str.empresa,ldt_fecha1,ldt_fecha2,ls_reserva[])
else
	if lstr_rangfech.opcion = 'Tránsito' then
		ls_reserva[1] = 'T'
	else
		ls_reserva[1] = 'C'
	end if
	dw.retrieve(str.g_financiero,str.empresa,ldt_fecha1,ldt_fecha2,ls_reserva[])
end if



end event

event resize;//Override
this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 278
gb_1.width  = this.width  - 63
gb_1.height = this.height - 220


st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180
this.SetRedraw(true)
end event

event closequery;call super::closequery;constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)

This.SetRedraw(false)
end event

event close;Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
 
end event

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_rep_pedidos_pend_transito_imp
integer x = 37
integer y = 1288
end type

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_rep_pedidos_pend_transito_imp
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_rep_pedidos_pend_transito_imp
integer y = 44
integer width = 2789
integer height = 1216
string dataobject = "dw_fa_rep_pck_fact_transito_imp"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_rep_pedidos_pend_transito_imp
integer y = 4
integer width = 2821
integer height = 1268
end type

