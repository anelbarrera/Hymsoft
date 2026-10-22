//objectcomments Consulta de transacciones de clientes Vista Previa
forward
global type w_reporte_transacciones_bco from w_fa_padre_reportes
end type
type st_sel_marca from statictext within w_reporte_transacciones_bco
end type
type ddlb_1 from dropdownlistbox within w_reporte_transacciones_bco
end type
type dw_2 from datawindow within w_reporte_transacciones_bco
end type
type cb_consultar from commandbutton within w_reporte_transacciones_bco
end type
type cb_2 from commandbutton within w_reporte_transacciones_bco
end type
type uo_1 from u_ddcalen within w_reporte_transacciones_bco
end type
type uo_2 from u_ddcalen within w_reporte_transacciones_bco
end type
type dw_3 from datawindow within w_reporte_transacciones_bco
end type
type cbx_1 from checkbox within w_reporte_transacciones_bco
end type
end forward

global type w_reporte_transacciones_bco from w_fa_padre_reportes
integer width = 4398
integer height = 2680
string title = "Reporte de Transacciones Bancarias"
<<<<<<< HEAD
=======
string menuname = "m_hs"
boolean controlmenu = false
>>>>>>> feature/Inventario
boolean minbox = false
boolean maxbox = false
long backcolor = 12639424
st_sel_marca st_sel_marca
ddlb_1 ddlb_1
dw_2 dw_2
cb_consultar cb_consultar
cb_2 cb_2
uo_1 uo_1
uo_2 uo_2
dw_3 dw_3
cbx_1 cbx_1
end type
global w_reporte_transacciones_bco w_reporte_transacciones_bco

type variables
str_fa_ventafact str_informe
datawindowchild idwc_cuenta, idwc_banco, idwc_tran
integer ii_banco
string is_cuenta

end variables

on w_reporte_transacciones_bco.create
int iCurrent
call super::create
<<<<<<< HEAD
=======
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_hs" then this.MenuID = create m_hs
>>>>>>> feature/Inventario
this.st_sel_marca=create st_sel_marca
this.ddlb_1=create ddlb_1
this.dw_2=create dw_2
this.cb_consultar=create cb_consultar
this.cb_2=create cb_2
this.uo_1=create uo_1
this.uo_2=create uo_2
this.dw_3=create dw_3
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_sel_marca
this.Control[iCurrent+2]=this.ddlb_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_consultar
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.uo_2
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.cbx_1
end on

on w_reporte_transacciones_bco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_sel_marca)
destroy(this.ddlb_1)
destroy(this.dw_2)
destroy(this.cb_consultar)
destroy(this.cb_2)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.dw_3)
destroy(this.cbx_1)
end on

event ue_post_open;//override
string  ls_dinero, ls_tran, ls_documento, ls_stran, ls_ref, ls_cuenta
Integer li_ann, li_banco
datetime ldt_desde, ldt_hasta

ldt_desde = datetime(relativedate(date(gf_fecha_serv()), - 30),00:00:00)
ldt_hasta = datetime(date(gf_fecha_serv()),23:59:59)

dw_2.settransobject(sqlca)
dw_2.getchild('banco', idwc_banco)
idwc_banco.settransobject(sqlca)
idwc_banco.retrieve(str.g_financiero, str.empresa)
dw_2.getchild('cuenta', idwc_cuenta)
idwc_cuenta.settransobject(sqlca)
idwc_cuenta.retrieve(str.g_financiero, str.empresa)
dw_2.insertrow(1)
dw_2.setitem(1,'fecha1',ldt_desde)
dw_2.setitem(1,'fecha2',ldt_hasta)
dw_3.getchild('transac', idwc_tran)
idwc_tran.settransobject(sqlca)
idwc_tran.retrieve(str.g_financiero, str.empresa)
idwc_tran.insertrow(1)

dw_2.setfocus()
dw_2.setcolumn('banco')



str_cc_formatos lstr_sec
lstr_sec = Message.PowerObjectParm
if isvalid(lstr_sec) then 
	ls_documento = lstr_sec.documento
	li_ann	 = lstr_sec.anio
	ls_tran	 = lstr_sec.transaccion
	ls_stran	 = lstr_sec.sub_transaccion
	ls_ref	 = lstr_sec.referencia
	ls_cuenta = lstr_sec.cuenta_banco
	li_banco	 = lstr_sec.banco
	dw_2.setitem(1,'banco',li_banco)
	dw_2.setitem(1,'cuenta',ls_cuenta)
end if

if ls_cuenta <> '' and not isnull(ls_cuenta) then
	dw_1.settransobject(sqlca)	
	cb_consultar.triggerevent('clicked')
//	if dw_1.retrieve(str.g_financiero, str.empresa, li_banco, ls_cuenta, ldt_desde, ldt_hasta) = 0 then
//		gf_mensaje('','Transaccion no Registrada, Verifique!!!',1,1,'E')
//		return
//	end if		
end if

//Para setear el nombre de la Cia. al DW de impresion.
If dw_1.Describe("nom_empresa.x") <> "?" And dw_1.Describe("nom_empresa.x") <> "!" Then
	dw_1.object.nom_empresa.expression = "'"+ gf_dg_nombre_empresa() +"'"
End If	
//
dw_3.insertrow(1)
dw_1.object.datawindow.print.preview = True
dw_1.object.datawindow.print.preview.zoom = 100
end event

event resize;//Override
//this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 528

//this.SetRedraw(true)
end event

event open;call super::open;//str_informe = Message.PowerObjectParm
//this.width  = 2680// this.width - 99
//this.height = this.height - 90
end event

<<<<<<< HEAD
=======
event close;Window lw_frame

lw_frame = ParentWindow()

If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_sheet_closed")
 End If
 Close(this)
end event

>>>>>>> feature/Inventario
type st_ayuda from w_fa_padre_reportes`st_ayuda within w_reporte_transacciones_bco
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_reporte_transacciones_bco
boolean visible = false
integer x = 32
integer y = 1384
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_reporte_transacciones_bco
integer x = 41
integer y = 420
integer width = 4297
integer height = 2036
string dataobject = "dw_rep_transacciones_banco"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::doubleclicked;call super::doubleclicked;string         ls_pointer
long           li_fila
datetime       ldt_fecha1
window		   lw_child
str_rangofecha	str_rangofecha_opcion
str_fa_bus_var str_busqueda

//If pos(upper(str.nombre_empresa),'ELECTROVISION') > 0 Then 
if w_fa_fondo.str_aplica_links.habilita_links = 1	then
	ls_pointer = dw_1.GetObjectAtPointer()
	li_fila = integer(trim(mid(ls_pointer,7)))
	if pos(ls_pointer,'numero') > 0 then 
		str_rangofecha_opcion.opcion = 'Kardex'
		str_rangofecha_opcion.orden = dw_1.getitemstring(li_fila,'fact_no_factura')
		if w_fa_fondo.str_aplica_links.factura_activa_fa = 'A' then
			OpenSheetWithParm(lw_child,str_rangofecha_opcion,"w_fa_co_facturas_cab_det_99_e",str.frame,11,Original!)
		end if
	else
		if pos(ls_pointer,'nomcli') > 0 then 
			str_rangofecha_opcion.opcion = 'Kardex'
			str_rangofecha_opcion.cliente = dw_1.getitemnumber(li_fila,'terc_tercero')
//			ldt_fecha1 = dw_1.getitemdatetime(li_fila,'fact_fecha')
			str_rangofecha_opcion.fecha1 = date('01/01/1990')
			if w_fa_fondo.str_aplica_links.cxc_activa_cc = 'A' then
				OpenSheetWithParm(lw_child,str_rangofecha_opcion,"w_fa_co_mov_cliente_saldo",str.frame,11,Original!)
			end if
		end if
	end if
end if 

//	dw_3.Object.dmov_secuencia.Pointer = 'Cross!'

end event

event dw_1::ue_microayuda;//override
//Para cuando pasa por encima del objeto
//Override
return

Integer li_pos, li_x, li_y,li_largo
String ls_objeto, ls_col

ls_objeto = This.GetObjectAtPointer()
li_pos = pos  (ls_objeto,"~t")
ls_col = left (ls_objeto, li_pos - 1)

//li_x	 = str.frame.GetActiveSheet ().PointerX () 
//li_largo = len("Haga click para ordenar por la Columna de " + this.describe(ls_col+".text"))*28


//li_y	 = str.frame.GetActiveSheet ().PointerY () - 200

// Dependiendo de la Columna el Mensaje de Ayuda varía
CHOOSE CASE ls_col
	CASE 'btdi_documento'
		this.Modify("btdi_documento.Font.Underline='1'")
		this.Modify("btdi_documento.Color='7536640'")

	CASE ELSE
		this.Modify("btdi_documento.Font.Underline='0'")
		this.Modify("btdi_documento.Color='0'")

END CHOOSE
end event

event dw_1::clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto, ls_column
integer li_pos 

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

ls_column = dwo.name

if ls_column = 'btdi_documento' then
	str_cc_formatos str_formato1	
	str_formato1.transaccion = dw_1.getitemstring(row,'batdiari_btdi_tipo_transaccion')
	str_formato1.sub_transaccion = dw_1.getitemstring(row,'batdiari_btdi_sub_transaccion')
	str_formato1.cuenta_banco = dw_2.getitemString(1,'cuenta')
	str_formato1.banco = dw_2.getitemnumber(1,'banco')
	str_formato1.documento = dw_1.getitemstring(row,'btdi_documento')
	str_formato1.referencia = dw_1.getitemstring(row,'batdiari_btdi_referencia')
	str_formato1.anio = dw_1.getitemnumber(row,'batdiari_btdi_ann')
	OpenSheetwithparm(w_consulta_transacciones_bco,str_formato1,parent,2, Original!)
	
end if



end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_reporte_transacciones_bco
boolean visible = false
integer x = 27
integer y = 192
integer width = 2967
integer height = 1364
long backcolor = 12639424
end type

type st_sel_marca from statictext within w_reporte_transacciones_bco
boolean visible = false
integer x = 1541
integer y = 1408
integer width = 640
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleccione la Marca"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_reporte_transacciones_bco
boolean visible = false
integer x = 2240
integer y = 1388
integer width = 754
integer height = 244
integer taborder = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
boolean vscrollbar = true
string item[] = {"NATURAL EXCHANGE","PUNTOCOM","TODAS"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String	ls_filtro
ls_filtro = 'PC'

if index = 1 then	//NATURAL
	dw_1.setFilter("fact_ruc_cliente not like '" +ls_filtro+ "%'")
	dw_1.filter()
	dw_1.groupcalc()
elseIf index = 2 then //PUNTO COM
	dw_1.setFilter( "fact_ruc_cliente like '" +ls_filtro+ "%'")
	dw_1.filter()
	dw_1.groupcalc()
elseIf index = 3 then //TOTAL
	ls_filtro = 'XX'
	dw_1.setFilter( "fact_ruc_cliente not like '" +ls_filtro+ "%'")
	dw_1.filter()
	dw_1.groupcalc()
end if

end event

type dw_2 from datawindow within w_reporte_transacciones_bco
integer x = 55
integer y = 32
integer width = 3547
integer height = 120
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_reporte_tran"
boolean border = false
boolean livescroll = true
end type

event itemchanged;string ls_nulo
setnull(ls_nulo)
accepttext()
choose case this.getcolumnname()
	case 'banco'
		ii_banco = this.getitemnumber(this.getrow(),'banco')
		this.setitem(this.getrow(),'cuenta',ls_nulo)
		this.setcolumn('cuenta')
	case 'cuenta'
		is_cuenta = data
		this.setcolumn('fecha1')
	case 'fecha1'
		this.setcolumn('fecha2')
end choose
end event

event itemfocuschanged;//override
string ls_filtro
integer li_rtn

accepttext()

CHOOSE CASE dwo.name
	CASE "cuenta"
	//Se filtran los grupo por la división seleccionada
	ls_filtro = string(This.GetItemNumber(row,"banco"))
	idwc_cuenta.SetFilter("cuen_banco = " + ls_filtro )	
	li_rtn = idwc_cuenta.Filter()
end choose
end event

event clicked;date 	ld_date,ld_ini_date, ld_hoy
ld_hoy = date(gf_fecha_serv())
accepttext()

CHOOSE CASE dwo.name
	case 'calendario'
		ld_ini_date=date(this.GetItemDateTime(this.getrow(),"fecha1"))
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
	case 'calendario1'
		ld_ini_date=date(this.GetItemDateTime(this.getrow(),"fecha2"))
		if year(ld_ini_date) = 1900 then
			ld_ini_date = ld_hoy
		end if
		if uo_2.visible=false then
			uo_2.wf_set_value(ld_ini_date)
			uo_2.visible=true
			uo_2.allow_close=false
			uo_2.inicializar()
			uo_2.TriggerEvent('ue_abrir')
		end if

end choose
end event

type cb_consultar from commandbutton within w_reporte_transacciones_bco
integer x = 3630
integer y = 36
integer width = 343
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
boolean default = true
end type

event clicked;string ls_dinero, ls_tran, ls_documento, ls_fecha_text
integer li_ann
datetime ldt_desde, ldt_hasta
date ldt_fecha_anterior
decimal{2} ld_saldo_anterior
dw_2.accepttext()
ldt_desde = datetime(date(dw_2.getitemdatetime(1,'fecha1')),00:00:00)
ldt_hasta = datetime(date(dw_2.getitemdatetime(1,'fecha2')),23:59:59)
ii_banco = dw_2.getitemnumber(1,'banco')
is_cuenta = dw_2.getitemstring(1,'cuenta')

if dw_1.retrieve(str.g_financiero, str.empresa, ii_banco, is_cuenta, ldt_desde, ldt_hasta) > 0 then
	ld_saldo_anterior = gf_saldo_anterior_ba_reporte(ii_banco, is_cuenta, ldt_desde)	
	if ld_saldo_anterior <> 0 and dw_1.dataobject = 'dw_rep_transacciones_banco' then
		dw_1.RowsCopy(1, 1, Primary!, dw_1, 1, Primary!)
		ldt_fecha_anterior = RelativeDate(date(ldt_desde), -1)
		if ld_saldo_anterior > 0 then
			dw_1.setitem(1,'debito',ld_saldo_anterior)
			dw_1.setitem(1,'credito',0)
		else
			dw_1.setitem(1,'credito',abs(ld_saldo_anterior))			
			dw_1.setitem(1,'debito',0)						
		end if
		dw_1.setitem(1,'batdiari_btdi_a_nombre_de','SALDO ANTERIOR')
		dw_1.setitem(1,'dgmsubse_subs_descripcion','')
		dw_1.setitem(1,'btdi_documento','')
		dw_1.setitem(1,'batdiari_btdi_referencia','')
		dw_1.setitem(1,'btdi_fecha_tran',ldt_fecha_anterior)
	end if
else
	gf_mensaje('','Transaccion no Registrada, Verifique!!!',1,1,'E')
	return
end if		


String	ls_expresion
Integer	li_pos
//Setea fecha
ls_expresion = string(date(gf_fecha_serv()))
dw_1.object.fecha.expression = "'"+ls_expresion+"'"
//Setea hora
ls_expresion = string(gf_fecha_serv(), "dd/mm/yyyy hh:mm AM/PM")
li_pos = Pos(ls_expresion," ")

ls_expresion = Right(ls_expresion, Len(ls_expresion) - li_pos)		
	
dw_1.object.hora.expression = "'"+ls_expresion+"'"
//titulo
ls_fecha_text = 'Desde '+gf_fecha_palabras_datetime(ldt_desde)+'  Hasta '+gf_fecha_palabras_datetime(ldt_hasta)
dw_1.object.tipo_fecha.expression = "'"+ls_fecha_text+"'"

dw_1.object.datawindow.print.preview = True
dw_1.object.datawindow.print.preview.zoom = 100
dw_1.setfocus()
end event

type cb_2 from commandbutton within w_reporte_transacciones_bco
integer x = 4009
integer y = 36
integer width = 343
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
end type

event clicked;parent.triggerevent('close')
end event

type uo_1 from u_ddcalen within w_reporte_transacciones_bco
boolean visible = false
integer x = 2098
integer y = 124
integer taborder = 40
boolean bringtotop = true
end type

on uo_1.destroy
call u_ddcalen::destroy
end on

event ue_clicked;call super::ue_clicked;dw_2.SetItem ( dw_2.getrow(), 'fecha1', uo_1.return_sel_date() )

if uo_1.allow_close then
	this.visible=false
	dw_2.SetFocus()
end if
end event

event destructor;call super::destructor;call u_ddcalen::destroy
end event

type uo_2 from u_ddcalen within w_reporte_transacciones_bco
boolean visible = false
integer x = 2802
integer y = 120
integer taborder = 50
boolean bringtotop = true
end type

on uo_2.destroy
call u_ddcalen::destroy
end on

event ue_clicked;call super::ue_clicked;dw_2.SetItem ( dw_2.getrow(), 'fecha2', uo_2.return_sel_date() )

if uo_2.allow_close then
	this.visible=false
	dw_2.SetFocus()
end if
end event

event destructor;call super::destructor;call u_ddcalen::destroy
end event

type dw_3 from datawindow within w_reporte_transacciones_bco
integer x = 50
integer y = 172
integer width = 3726
integer height = 216
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_nombre_detalle_transac"
boolean livescroll = true
end type

event editchanged;string ls_nombre, ls_detalle, ls_filter, ls_tran
decimal{2} ld_monto
this.accepttext()

ls_nombre = this.getitemstring(1,'nombre')
ls_detalle   = this.getitemstring(1,'detalle')
ld_monto   = this.getitemnumber(1,'monto')
ls_tran       = this.getitemstring(1,'transac')

if len(ls_nombre) > 0 then
	ls_filter = 'left(upper(batdiari_btdi_a_nombre_de),'+ string(len(ls_nombre))+ ') = "'+upper(ls_nombre)+'"'
end if

if ld_monto > 0 then
	if len(ls_filter) > 0 then
		ls_filter = ls_filter +" and batdiari_btdi_monto = "+string(ld_monto)
	else
		ls_filter = "batdiari_btdi_monto = "+string(ld_monto)
	end if
end if

if len(ls_detalle) > 0 then
	if len(ls_filter) > 0 then
		ls_filter = ls_filter +" and upper(batdiari_btdi_comentario) like '%"+upper(ls_detalle)+"%'"
	else
		ls_filter = "upper(batdiari_btdi_comentario) like '%"+upper(ls_detalle)+"%'"
	end if
end if

if len(ls_tran) > 0 then
	if len(ls_filter) > 0 then
		ls_filter = ls_filter +" and upper(batdiari_btdi_tipo_transaccion) = '"+upper(ls_tran)+"'"
	else
		ls_filter = "upper(batdiari_btdi_tipo_transaccion) = '"+upper(ls_tran)+"'"
	end if
end if

if len(ls_filter) > 0 then
	dw_1.setfilter(ls_filter)
else
	dw_1.setfilter("")
end if

dw_1.filter()
end event

event itemfocuschanged;this.selecttext(1,100)
end event

event itemchanged;string ls_nombre, ls_detalle, ls_filter, ls_tran
decimal{2} ld_monto
this.accepttext()

ls_nombre = this.getitemstring(1,'nombre')
ls_detalle   = this.getitemstring(1,'detalle')
ld_monto   = this.getitemnumber(1,'monto')
ls_tran       = this.getitemstring(1,'transac')

if len(ls_tran) > 0 then
	dw_1.dataobject = 'dw_rep_transacciones_banco_transac'
else
	dw_1.dataobject = 'dw_rep_transacciones_banco'
end if
dw_1.settransobject(sqlca)
cb_consultar.triggerevent('clicked')

if len(ls_nombre) > 0 then
	ls_filter = 'left(upper(batdiari_btdi_a_nombre_de),'+ string(len(ls_nombre))+ ') = "'+upper(ls_nombre)+'"'
end if

if ld_monto > 0 then
	if len(ls_filter) > 0 then
		ls_filter = ls_filter +" and batdiari_btdi_monto = "+string(ld_monto)
	else
		ls_filter = "batdiari_btdi_monto = "+string(ld_monto)
	end if
end if

if len(ls_detalle) > 0 then
	if len(ls_filter) > 0 then
		ls_filter = ls_filter +" and upper(batdiari_btdi_comentario) like '%"+upper(ls_detalle)+"%'"
	else
		ls_filter = "upper(batdiari_btdi_comentario) like '%"+upper(ls_detalle)+"%'"
	end if
end if

if len(ls_tran) > 0 then
	if len(ls_filter) > 0 then
		ls_filter = ls_filter +" and upper(batdiari_btdi_tipo_transaccion) = '"+upper(ls_tran)+"'"
	else
		ls_filter = "upper(batdiari_btdi_tipo_transaccion) = '"+upper(ls_tran)+"'"
	end if
end if

if len(ls_filter) > 0 then
	dw_1.setfilter(ls_filter)
else
	dw_1.setfilter("")
end if

dw_1.filter()
end event

type cbx_1 from checkbox within w_reporte_transacciones_bco
integer x = 3826
integer y = 188
integer width = 425
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Ver detalle "
end type

event clicked;if this.checked then
	dw_1.Modify("DataWindow.Detail.Height.AutoSize=Yes")
else
	dw_1.Modify("DataWindow.Detail.Height.AutoSize=No")
end if
end event

