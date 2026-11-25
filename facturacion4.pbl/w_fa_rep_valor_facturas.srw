//objectcomments  
forward
global type w_fa_rep_valor_facturas from w_fa_padre_reportes
end type
end forward

global type w_fa_rep_valor_facturas from w_fa_padre_reportes
integer width = 2912
integer height = 1524
string title = "(FA) Reporte de Facturas en US Dollars"
string menuname = "m_hs"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
end type
global w_fa_rep_valor_facturas w_fa_rep_valor_facturas

on w_fa_rep_valor_facturas.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_hs" then this.MenuID = create m_hs
end on

on w_fa_rep_valor_facturas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;string ls_empre, ls_logo
str_rangofecha lstr_rangfech

lstr_rangfech = message.powerObjectParm
//If lstr_rangfech.opcion = 'Pedido' then
//	dw_1.DataObject = "dw_fa_rep_valor_pedidos"
//else
If pos(upper(str.nombre_empresa),'ELECTROVISION') > 0 or &
   pos(upper(str.nombre_empresa),'SONAKI') > 0 Then 
	dw_1.DataObject = "dw_fa_rep_valor_factura_electro"
else
	if lstr_rangfech.tipo_reporte = 1 then
		dw_1.DataObject = "dw_fa_rep_valor_factura_tipo" //dw_fa_rep_valor_factura_tipo_costo
	else																		 //Con columna de costo, solicitado por Oscar
		dw_1.DataObject = "dw_fa_rep_valor_factura"
	end if
end if
//end If
dw = dw_1
dw.settransobject(sqlca)
ls_empre = gf_dg_nombre_empresa()
dw.object.empresa.expression = "'"+ ls_empre +"'"
if pos(lower(ls_empre),"fragancia") > 0  then
	dw_1.modify("cgastos_t.text='I.T.B.M'")
else
	dw_1.modify("cgastos_t.text='Cargos'")
end if
ls_logo = gf_logo_empr_foto_chica_fa()
dw.object.logo_chico.expression = "bitmap ('"+ls_logo+"')"
dw.object.logo_fondo.expression = "bitmap ('"+ls_logo+"')"
dw.retrieve(str.g_financiero,str.empresa,lstr_rangfech.fecha1,lstr_rangfech.fecha2, lstr_rangfech.opcion)
dw.Object.datawindow.print.preview = true




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

event ue_post_open;//Override
dw = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()
dw_impresion = dw

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

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_rep_valor_facturas
boolean visible = false
integer x = 37
integer y = 1288
end type

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_rep_valor_facturas
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_rep_valor_facturas
integer y = 44
integer width = 2789
integer height = 1216
string dataobject = "dw_fa_rep_valor_factura"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_rep_valor_facturas
integer y = 4
integer width = 2821
integer height = 1268
end type

