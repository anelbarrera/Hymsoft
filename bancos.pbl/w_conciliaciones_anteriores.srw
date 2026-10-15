//objectcomments Consulta de transacciones de clientes Vista Previa
forward
global type w_conciliaciones_anteriores from w_fa_padre_reportes
end type
type st_sel_marca from statictext within w_conciliaciones_anteriores
end type
type ddlb_1 from dropdownlistbox within w_conciliaciones_anteriores
end type
type cb_consultar from commandbutton within w_conciliaciones_anteriores
end type
type cb_2 from commandbutton within w_conciliaciones_anteriores
end type
type uo_1 from u_ddcalen within w_conciliaciones_anteriores
end type
type uo_2 from u_ddcalen within w_conciliaciones_anteriores
end type
type dw_6 from datawindow within w_conciliaciones_anteriores
end type
type dw_7 from datawindow within w_conciliaciones_anteriores
end type
type dw_2 from datawindow within w_conciliaciones_anteriores
end type
type dw_3 from datawindow within w_conciliaciones_anteriores
end type
end forward

global type w_conciliaciones_anteriores from w_fa_padre_reportes
integer width = 4219
integer height = 2844
string title = "Conciliaciones Actualizadas"
long backcolor = 12639424
windowanimationstyle openanimation = leftroll!
windowanimationstyle closeanimation = leftslide!
st_sel_marca st_sel_marca
ddlb_1 ddlb_1
cb_consultar cb_consultar
cb_2 cb_2
uo_1 uo_1
uo_2 uo_2
dw_6 dw_6
dw_7 dw_7
dw_2 dw_2
dw_3 dw_3
end type
global w_conciliaciones_anteriores w_conciliaciones_anteriores

type variables
str_fa_ventafact str_informe
datawindowchild idwc_cuenta, idwc_fechas
integer ii_banco
string is_cuenta

end variables

forward prototypes
public function boolean wf_conciliaciones_anteriores ()
public function boolean wf_recuperar (datawindow adw)
end prototypes

public function boolean wf_conciliaciones_anteriores ();
	str_cc_formatos str_formato1	
	str_formato1.cuenta_banco = dw_2.getitemString(1,'cuenta')
	str_formato1.banco = dw_2.getitemnumber(1,'banco')
	OpenSheetwithparm(w_mant_clientes,str_formato1,this,2, Original!)


return true
end function

public function boolean wf_recuperar (datawindow adw);string ls_dinero, ls_tran, ls_documento, ls_fecha_text
integer li_ann
datetime ldt_desde, ldt_hasta
decimal{2} ldec_saldo_anterior, ldec_saldo
ldt_hasta = datetime(date(dw_3.getitemdatetime(1,'fecha')),00:00:00)
ldt_desde = datetime(date(idwc_fechas.getitemdatetime(idwc_fechas.getrow(),'sald_fecha_ini_periodo')),00:00:00) //23:59:59)

if ldt_desde > ldt_hasta then
	gf_mensaje('','La fecha inicial debe ser menor a la fecha final.  Verifique.',1,1,'E')
	dw_2.setitem(1,'fecha2',date(gf_fecha_serv()))
	return false
end if

ii_banco = dw_2.getitemnumber(1,'banco')
is_cuenta = dw_2.getitemstring(1,'cuenta')

if dw_1.dataobject = 'dw_doc_circulacion_print' then
	if dw_1.retrieve(str.g_financiero, str.empresa, ii_banco, is_cuenta, ldt_hasta) = 0 then adw.insertrow(1)	
else
	if dw_1.retrieve(str.g_financiero, str.empresa, ii_banco, is_cuenta, ldt_desde, ldt_hasta) = 0 then adw.insertrow(1)
end if

SELECT isnull(cuen_monto_conciliacion,0) //saldo en libros
INTO :ldec_saldo_anterior
FROM bamcuent
WHERE (cuen_g_financiero = :str.g_financiero ) AND (cuen_empresa = :str.empresa ) AND  
(cuen_banco = :ii_banco ) AND (cuen_no_cuenta = :is_cuenta);
if sqlca.sqlcode = -1 then
	gf_mensaje('','Error al seleccionar saldo '+sqlca.sqlerrtext,1,1,'E')
end if


return true
end function

on w_conciliaciones_anteriores.create
int iCurrent
call super::create
this.st_sel_marca=create st_sel_marca
this.ddlb_1=create ddlb_1
this.cb_consultar=create cb_consultar
this.cb_2=create cb_2
this.uo_1=create uo_1
this.uo_2=create uo_2
this.dw_6=create dw_6
this.dw_7=create dw_7
this.dw_2=create dw_2
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_sel_marca
this.Control[iCurrent+2]=this.ddlb_1
this.Control[iCurrent+3]=this.cb_consultar
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.uo_2
this.Control[iCurrent+7]=this.dw_6
this.Control[iCurrent+8]=this.dw_7
this.Control[iCurrent+9]=this.dw_2
this.Control[iCurrent+10]=this.dw_3
end on

on w_conciliaciones_anteriores.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_sel_marca)
destroy(this.ddlb_1)
destroy(this.cb_consultar)
destroy(this.cb_2)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.dw_6)
destroy(this.dw_7)
destroy(this.dw_2)
destroy(this.dw_3)
end on

event ue_post_open;//override
string  ls_dinero, ls_tran, ls_documento, ls_stran, ls_ref, ls_cuenta
Integer li_ann, li_banco
datetime ldt_fecha
sqlca.autocommit = true
dw_1.settransobject(sqlca)	
dw_3.settransobject(sqlca)
dw_3.getchild('fecha',idwc_fechas)
idwc_fechas.settransobject(sqlca)
idwc_fechas.insertrow(1)
dw_3.insertrow(1)
dw_2.settransobject(sqlca)
dw_2.getchild('banco', idwc_cuenta)
idwc_cuenta.settransobject(sqlca)
idwc_cuenta.retrieve(str.g_financiero, str.empresa)
dw_2.getchild('cuenta', idwc_cuenta)
idwc_cuenta.settransobject(sqlca)
if idwc_cuenta.retrieve(str.g_financiero, str.empresa) = 0 then
	gf_mensaje('','Debe crear las Cuentas Bancarias, Verifique !!',1,1,'E')
	this.postevent('close')
end if

dw_2.insertrow(1)
dw_2.setfocus()
dw_2.setcolumn('banco')
str_cc_formatos lstr_sec
lstr_sec = Message.PowerObjectParm
if isvalid(lstr_sec) then 

	ls_cuenta = lstr_sec.cuenta_banco
	li_banco	 = lstr_sec.banco
	dw_2.setitem(1,'banco',li_banco)
	dw_2.setitem(1,'cuenta',ls_cuenta)
	if ls_cuenta <> '' and not isnull(ls_cuenta) then
		if idwc_fechas.retrieve(str.g_financiero, str.empresa, li_banco, ls_cuenta ) > 0 then
			ldt_fecha = idwc_fechas.getitemdatetime(1,'sald_fecha_fin_periodo')
			dw_3.setitem(1,'fecha',ldt_fecha)
		else
			idwc_fechas.insertrow(1)
			gf_mensaje('','Esta cuenta no tiene cierres generados',1,1,'E')
		end if
	end if
	dw_3.setitem(1,'tipo',1)
end if

if ls_cuenta <> '' and not isnull(ls_cuenta) and idwc_fechas.rowcount() > 0 then
	cb_consultar.triggerevent('clicked')
//	if dw_1.retrieve(str.g_financiero, str.empresa, li_banco, ls_cuenta, ldt_desde, ldt_hasta) = 0 then
//		gf_mensaje('','Transaccion no Registrada, Verifique!!!',1,1,'E')
//		return
//	end if		
end if

//Para setear el nombre de la Cia. al DW de impresion.
If dw_1.Describe("empresanom.x") <> "?" And dw_1.Describe("empresanom.x") <> "!" Then
	dw_1.object.empresanom.expression = "'"+ gf_dg_nombre_empresa() +"'"
End If	
//
dw_1.object.datawindow.print.preview = True
dw_1.object.datawindow.print.preview.zoom = 100
end event

event resize;//Override
//this.SetRedraw(false)
//dw_1.width  = this.width  - 99
//dw_1.height = this.height - 378

//this.SetRedraw(true)
end event

event open;//str_informe = Message.PowerObjectParm
this.y = 0
this.x = 805
//this.width  = 2680// this.width - 99
this.height = this.height - 90
dw = dw_1
dw_impresion = dw_1
dw.settransobject(sqlca)
//st_nom_ventana.text = this.classname()

//Configurar los Accesos
//mf_accesos(this.menuid, this)

This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)
str.frame.SetRedraw ( True )

This.Icon = str.icono
this.postevent("ue_post_open")
end event

event ue_print;//override
//wf_recuperar(dw_6)
//dw_6.object.empresanom.expression = "'"+str.nombre_empresa+"'"
//dw_6.object.datawindow.print.preview = True
//dw_6.object.datawindow.print.preview.zoom = 100
//
OpenWithParm(w_dw_print_options, dw_1)
If Message.DoubleParm = -1 Then Return
dw_1.Print(True)




end event

event ue_save_as;//override

if dw = dw_6 then
	wf_recuperar(dw_6)
	dw_6.object.empresanom.expression = "'"+str.nombre_empresa+"'"
end if

integer li_respuesta
li_respuesta = gf_mensaje('','Yes = Salvar a Excel, No = Otro Formato o Cancelar',4,1,'Q')
choose case li_respuesta
	case 1
		uf_save_dw_as_excel(dw,'C:\'+this.title+'.xls')
	case 2
		dw.saveas()
end choose

end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_conciliaciones_anteriores
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_conciliaciones_anteriores
boolean visible = false
integer x = 32
integer y = 1384
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_conciliaciones_anteriores
event ue_postitem ( )
integer x = 82
integer y = 236
integer width = 3863
integer height = 2348
integer taborder = 10
boolean titlebar = true
string title = "Conciliaciones"
string dataobject = "dw_conciliaciones_anteriores"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
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
	case 'btdi_conciliacion_t'
		this.Modify("btdi_conciliacion_t.Font.Underline='1'")
		this.Modify("btdi_conciliacion_t.Color='63743'")
	CASE ELSE
		this.Modify("btdi_documento.Font.Underline='0'")
		this.Modify("btdi_documento.Color='0'")
		this.Modify("btdi_conciliacion_t.Font.Underline='0'")
		this.Modify("btdi_conciliacion_t.Color='16777215'")

END CHOOSE
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;dw = dw_1
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_conciliaciones_anteriores
boolean visible = false
integer x = 27
integer y = 192
integer width = 2967
integer height = 1364
integer taborder = 20
long backcolor = 12639424
end type

type st_sel_marca from statictext within w_conciliaciones_anteriores
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

type ddlb_1 from dropdownlistbox within w_conciliaciones_anteriores
boolean visible = false
integer x = 2240
integer y = 1388
integer width = 754
integer height = 244
integer taborder = 120
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

type cb_consultar from commandbutton within w_conciliaciones_anteriores
integer x = 3214
integer y = 48
integer width = 357
integer height = 100
integer taborder = 80
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

event clicked;dw_2.accepttext()
dw_3.accepttext()
wf_recuperar(dw_1)
dw_1.setfocus()
end event

type cb_2 from commandbutton within w_conciliaciones_anteriores
integer x = 3607
integer y = 48
integer width = 343
integer height = 100
integer taborder = 90
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

type uo_1 from u_ddcalen within w_conciliaciones_anteriores
boolean visible = false
integer x = 2098
integer y = 124
integer taborder = 100
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

type uo_2 from u_ddcalen within w_conciliaciones_anteriores
boolean visible = false
integer x = 2802
integer y = 120
integer taborder = 110
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

type dw_6 from datawindow within w_conciliaciones_anteriores
boolean visible = false
integer x = 448
integer y = 576
integer width = 2126
integer height = 1388
integer taborder = 20
boolean bringtotop = true
string title = "Conciliacion Bancaria"
string dataobject = "dw_saldos_conciliacion_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_7 from datawindow within w_conciliaciones_anteriores
boolean visible = false
integer x = 178
integer y = 456
integer width = 1783
integer height = 1532
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Documentos en Transito"
string dataobject = "dw_doc_circulacion_print"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_conciliaciones_anteriores
integer x = 14
integer y = 32
integer width = 2126
integer height = 112
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_conciliacion"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;this.accepttext()
integer li_banco
string ls_cuenta, ls_filter
datetime ldt_fecha
li_banco = dw_2.getitemnumber(1,'banco')
ls_cuenta = dw_2.getitemstring(1,'cuenta')

choose case dwo.name
	case 'banco'
		idwc_cuenta.setfilter('cuen_banco = '+string(li_banco))
		idwc_cuenta.filter()
		if idwc_cuenta.rowcount() > 0 then 
			ls_cuenta = idwc_cuenta.getitemstring(1,'cuen_no_cuenta')
			this.setitem(1,'cuenta',ls_cuenta)
			if idwc_fechas.retrieve(str.g_financiero, str.empresa, li_banco, ls_cuenta ) = 0 then
				gf_mensaje('','Esta cuenta no tiene cierres generados',1,1,'E')
				idwc_fechas.insertrow(1)
			else
				ldt_fecha = idwc_fechas.getitemdatetime(1,'sald_fecha_fin_periodo')
				dw_3.setitem(1,'fecha',ldt_fecha)
				cb_consultar.triggerevent('clicked')
			end if
		end if
	case 'cuenta'
		if idwc_fechas.retrieve(str.g_financiero, str.empresa, li_banco, ls_cuenta ) = 0 then
			gf_mensaje('','Esta cuenta no tiene cierres generados',1,1,'E')
			idwc_fechas.insertrow(1)
		else
			ldt_fecha = idwc_fechas.getitemdatetime(1,'sald_fecha_fin_periodo')
			dw_3.setitem(1,'fecha',ldt_fecha)
			cb_consultar.triggerevent('clicked')
		end if		
end choose
dw_3.setfocus()
end event

type dw_3 from datawindow within w_conciliaciones_anteriores
integer x = 2171
integer y = 12
integer width = 992
integer height = 200
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_fechas_cerradas"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;dw_3.accepttext()
choose case this.getcolumnname()
	case 'tipo'
		if data = '1' then
			dw_1.dataobject = 'dw_conciliaciones_anteriores'
			dw_1.title = 'Conciliaciones Actualizadas'
			parent.title = 'Conciliaciones Actualizadas'
		else
			dw_1.dataobject = 'dw_doc_circulacion_print'			
			dw_1.title = 'Documentos en Circulacion'
			parent.title = 'Documentos en Circulacion'			
		end if
	dw_1.settransobject(sqlca)
	dw_1.object.datawindow.print.preview = True
	dw_1.object.datawindow.print.preview.zoom = 100		
	If dw_1.Describe("empresanom.x") <> "?" And dw_1.Describe("empresanom.x") <> "!" Then
		dw_1.object.empresanom.expression = "'"+ gf_dg_nombre_empresa() +"'"
	End If	
	
end choose

cb_consultar.triggerevent('clicked')

end event

