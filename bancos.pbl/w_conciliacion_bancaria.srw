//objectcomments Consulta de transacciones de clientes Vista Previa
forward
global type w_conciliacion_bancaria from w_fa_padre_reportes
end type
type st_sel_marca from statictext within w_conciliacion_bancaria
end type
type ddlb_1 from dropdownlistbox within w_conciliacion_bancaria
end type
type dw_2 from datawindow within w_conciliacion_bancaria
end type
type cb_consultar from commandbutton within w_conciliacion_bancaria
end type
type cb_2 from commandbutton within w_conciliacion_bancaria
end type
type uo_1 from u_ddcalen within w_conciliacion_bancaria
end type
type uo_2 from u_ddcalen within w_conciliacion_bancaria
end type
type dw_3 from datawindow within w_conciliacion_bancaria
end type
type dw_4 from datawindow within w_conciliacion_bancaria
end type
type dw_5 from datawindow within w_conciliacion_bancaria
end type
type st_1 from statictext within w_conciliacion_bancaria
end type
type em_saldo_banco from editmask within w_conciliacion_bancaria
end type
type cb_1 from commandbutton within w_conciliacion_bancaria
end type
type dw_6 from datawindow within w_conciliacion_bancaria
end type
type dw_7 from datawindow within w_conciliacion_bancaria
end type
type pb_anteriores from picturebutton within w_conciliacion_bancaria
end type
type st_2 from statictext within w_conciliacion_bancaria
end type
end forward

global type w_conciliacion_bancaria from w_fa_padre_reportes
integer width = 4553
integer height = 2908
string title = "Conciliacion Bancaria"
string menuname = "m_hs"
boolean controlmenu = false
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
dw_4 dw_4
dw_5 dw_5
st_1 st_1
em_saldo_banco em_saldo_banco
cb_1 cb_1
dw_6 dw_6
dw_7 dw_7
pb_anteriores pb_anteriores
st_2 st_2
end type
global w_conciliacion_bancaria w_conciliacion_bancaria

type variables
str_fa_ventafact str_informe
datawindowchild idwc_cuenta, idwc_bancos
integer ii_banco
string is_cuenta

end variables

forward prototypes
public function boolean wf_recuperar (datawindow adw)
public function boolean wf_conciliaciones_anteriores ()
end prototypes

public function boolean wf_recuperar (datawindow adw);string ls_dinero, ls_tran, ls_documento, ls_fecha_text
integer li_ann
datetime ldt_desde, ldt_hasta, ldt_hasta_impresion
decimal{2} ldec_saldo_anterior, ldec_saldo
ldt_desde = datetime(date(dw_2.getitemdatetime(1,'fecha1')),00:00:00)
ldt_hasta = datetime(date(dw_2.getitemdatetime(1,'fecha2')),00:00:00) //23:59:59)
ldt_hasta_impresion = ldt_hasta //datetime(relativedate(date(dw_2.getitemdatetime(1,'fecha2')), - 1))

if ldt_desde > ldt_hasta then
	gf_mensaje('','La fecha inicial debe ser menor a la fecha final.  Verifique.',1,1,'E')
	dw_2.setitem(1,'fecha2',date(gf_fecha_serv()))
	return false
end if

ii_banco = dw_2.getitemnumber(1,'banco')
is_cuenta = dw_2.getitemstring(1,'cuenta')
dw_1.retrieve(str.g_financiero, str.empresa, ii_banco, is_cuenta, ldt_hasta)
dw_3.retrieve(str.g_financiero, str.empresa, ii_banco, is_cuenta, ldt_hasta)
dw_4.retrieve(str.g_financiero, str.empresa, ii_banco, is_cuenta, ldt_hasta)

if adw.retrieve(str.g_financiero, str.empresa, ii_banco, is_cuenta, ldt_desde, ldt_hasta) = 0 then adw.insertrow(1)

SELECT isnull(cuen_monto_conciliacion,0) //saldo en libros
INTO :ldec_saldo_anterior
FROM bamcuent
WHERE (cuen_g_financiero = :str.g_financiero ) AND (cuen_empresa = :str.empresa ) AND  
(cuen_banco = :ii_banco ) AND (cuen_no_cuenta = :is_cuenta);
if sqlca.sqlcode = -1 then
	gf_mensaje('','Error al seleccionar saldo '+sqlca.sqlerrtext,1,1,'E')
end if
ldec_saldo = double(em_saldo_banco.text)
adw.Modify("c_dia.Expression='" + string(day(date(ldt_hasta_impresion)))    	 + "'")
adw.Modify("c_mes.Expression='" + string(month(date(ldt_hasta_impresion)))    	 + "'")
adw.Modify("c_ann.Expression='" + string(year(date(ldt_hasta_impresion)))    	 + "'")
adw.Modify("c_saldo_anterior.Expression='" + string(ldec_saldo_anterior) + "'")
adw.Modify("c_sald.Expression='" + string(ldec_saldo)    + "'")
if dw_1.rowcount() > 0 then adw.Modify("c_depo.Expression='" + string(dw_1.getitemnumber(1,'transito')) + "'")
if dw_3.rowcount() > 0 then adw.Modify("c_cheq.Expression='" + string(dw_3.getitemnumber(1,'transito'))  + "'")
if dw_4.rowcount() > 0 then adw.Modify("c_notas_db.Expression='" + string(dw_4.getitemnumber(1,'tot_debito')) + "'")
if dw_4.rowcount() > 0 then adw.Modify("c_notas_cr.Expression='" + string(dw_4.getitemnumber(1,'tot_credito')) + "'")

//dw_1.setfocus()

return true
end function

public function boolean wf_conciliaciones_anteriores ();
	str_cc_formatos str_formato1	
	str_formato1.cuenta_banco = is_cuenta
	str_formato1.banco = ii_banco
	OpenSheetwithparm(w_conciliaciones_anteriores,str_formato1,this,2, Original!)


return true
end function

on w_conciliacion_bancaria.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.st_sel_marca=create st_sel_marca
this.ddlb_1=create ddlb_1
this.dw_2=create dw_2
this.cb_consultar=create cb_consultar
this.cb_2=create cb_2
this.uo_1=create uo_1
this.uo_2=create uo_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.dw_5=create dw_5
this.st_1=create st_1
this.em_saldo_banco=create em_saldo_banco
this.cb_1=create cb_1
this.dw_6=create dw_6
this.dw_7=create dw_7
this.pb_anteriores=create pb_anteriores
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_sel_marca
this.Control[iCurrent+2]=this.ddlb_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_consultar
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.uo_2
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.dw_4
this.Control[iCurrent+10]=this.dw_5
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.em_saldo_banco
this.Control[iCurrent+13]=this.cb_1
this.Control[iCurrent+14]=this.dw_6
this.Control[iCurrent+15]=this.dw_7
this.Control[iCurrent+16]=this.pb_anteriores
this.Control[iCurrent+17]=this.st_2
end on

on w_conciliacion_bancaria.destroy
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
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.st_1)
destroy(this.em_saldo_banco)
destroy(this.cb_1)
destroy(this.dw_6)
destroy(this.dw_7)
destroy(this.pb_anteriores)
destroy(this.st_2)
end on

event ue_post_open;//override
string  ls_dinero, ls_tran, ls_documento, ls_stran, ls_ref, ls_cuenta
Integer li_ann, li_banco
datetime ldt_desde, ldt_hasta
sqlca.autocommit = true
ldt_desde = datetime(relativedate(date(gf_fecha_serv()), - 30),00:00:00)
ldt_hasta = datetime(date(gf_fecha_serv()),23:59:59)

dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_5.settransobject(sqlca)
dw_6.settransobject(sqlca)
dw_7.settransobject(sqlca)
dw_2.getchild('cuenta', idwc_cuenta)
idwc_cuenta.settransobject(sqlca)
if idwc_cuenta.retrieve(str.g_financiero, str.empresa) = 0 then
	gf_mensaje('','Debe crear las Cuentas Bancarias, Verifique !!',1,1,'E')
	this.postevent('close')
end if

dw_2.getchild('banco', idwc_bancos)
idwc_bancos.settransobject(sqlca)
if idwc_bancos.retrieve(str.g_financiero, str.empresa) = 0 then
end if
dw_1.reset()
dw_3.reset()
dw_4.reset()
dw_5.reset()

dw_2.insertrow(1)
dw_2.setitem(1,'fecha1',ldt_desde)
dw_2.setitem(1,'fecha2',ldt_hasta)
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
//If dw_1.Describe("nom_empresa.x") <> "?" And dw_1.Describe("nom_empresa.x") <> "!" Then
//	dw_1.object.nom_empresa.expression = "'"+ gf_dg_nombre_empresa() +"'"
//End If	
////
//dw_1.object.datawindow.print.preview = True
//dw_1.object.datawindow.print.preview.zoom = 100
end event

event resize;//Override
//this.SetRedraw(false)
//dw_1.width  = this.width  - 99
//dw_1.height = this.height - 378

//this.SetRedraw(true)
end event

event open;//str_informe = Message.PowerObjectParm
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
wf_recuperar(dw_6)
dw_6.object.empresanom.expression = "'"+str.nombre_empresa+"'"
dw_6.object.datawindow.print.preview = True
dw_6.object.datawindow.print.preview.zoom = 100

OpenWithParm(w_dw_print_options, dw_6)
If Message.DoubleParm = -1 Then Return
dw_6.Print(True)




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

event close;call super::close;w_hs_frame.Post Event ue_evaluar_panel_acciones()
end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_conciliacion_bancaria
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_conciliacion_bancaria
boolean visible = false
integer x = 32
integer y = 1384
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_conciliacion_bancaria
event ue_postitem ( )
integer x = 37
integer y = 204
integer width = 1993
integer height = 1048
integer taborder = 10
boolean titlebar = true
string title = "Depositos"
string dataobject = "dw_depositos_conciliacion"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event dw_1::ue_postitem();
if this.update() = -1 then
	gf_mensaje('','Error al actualizar depositos '+sqlca.sqlerrtext,1,1,'E')
else
	if dw_1.rowcount() > 0 then dw_5.Modify("c_depo.Expression='" + string(dw_1.getitemnumber(1,'transito')) + "'")
end if
end event

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

event dw_1::clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.
dw = dw_1
string ls_objeto, ls_column, ls_contenido
integer li_pos , i

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

ls_column = dwo.name

if ls_column = 'btdi_documento' then
	str_cc_formatos str_formato1	
	str_formato1.transaccion = dw_1.getitemstring(row,'btdi_tipo_transaccion')
	str_formato1.sub_transaccion = dw_1.getitemstring(row,'btdi_sub_transaccion')
	str_formato1.cuenta_banco = dw_1.getitemString(row,'btdi_no_cuenta')
	str_formato1.banco = dw_1.getitemnumber(row,'btdi_banco')
	str_formato1.documento = dw_1.getitemstring(row,'btdi_documento')
	str_formato1.referencia = dw_1.getitemstring(row,'btdi_referencia')
	str_formato1.anio = dw_1.getitemnumber(row,'btdi_ann')
	OpenSheetwithparm(w_consulta_transacciones_bco,str_formato1,parent,2, Original!)
elseif ls_column = 'btdi_conciliacion_t' then
	if this.rowcount() > 0 then
		if this.getitemstring(1,'btdi_conciliacion') = 'C' then
			if gf_mensaje('','Desmarcar todos los Depositos ?',2,1,'Q') = 2 then return
			ls_contenido = 'P'
		else
			if gf_mensaje('','Marcar todos los Depositos ?',2,1,'Q') = 2 then return
			ls_contenido = 'C'			
		end if
		for i = 1 to this.rowcount()
			this.setitem(i,'btdi_conciliacion',ls_contenido)
		next
		
		if this.update() = -1 then
			gf_mensaje('','Error al actualizar depositos '+sqlca.sqlerrtext,1,1,'E')
		else
			if dw_1.rowcount() > 0 then dw_5.Modify("c_depo.Expression='" + string(dw_1.getitemnumber(1,'transito')) + "'")
		end if
	end if
end if

//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

this.Setredraw(false)

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if right(ls_objeto,2)='_t' then

	ls_objeto = left(ls_objeto,len(ls_objeto)-2)
	
	if ls_objeto = is_ultima_ or is_ultima_ = "" then	//Si es la misma columna 
																	// o si es la primera vez
		if is_orden_  = "" or is_orden_ = "D" then
			is_orden_ = 'A'		
			this.SetSort(ls_objeto+" A")	//Ordena Ascendente
			this.sort()		
		else
			is_orden_ = 'D'					
			this.SetSort(ls_objeto+" D")	//Ordena Descendente
			this.sort()				
		end if	
		is_ultima_ = ls_objeto		
	else				
			is_orden_ = 'A'
			this.SetSort(ls_objeto+" A")
			this.sort()
			is_ultima_ = ls_objeto
	end if

end if

this.Setredraw(true)
end event

event dw_1::itemchanged;call super::itemchanged;this.accepttext()
this.postevent('ue_postitem')

end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;dw = dw_1
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_conciliacion_bancaria
boolean visible = false
integer x = 27
integer y = 192
integer width = 2967
integer height = 1364
integer taborder = 20
long backcolor = 12639424
end type

type st_sel_marca from statictext within w_conciliacion_bancaria
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

type ddlb_1 from dropdownlistbox within w_conciliacion_bancaria
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

type dw_2 from datawindow within w_conciliacion_bancaria
integer x = 55
integer y = 16
integer width = 3547
integer height = 88
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_conciliacion"
boolean border = false
boolean livescroll = true
end type

event itemchanged;string ls_nulo, ls_cuenta
setnull(ls_nulo)
integer li_rtn
datetime ldt_fecha
date ldt_fecha2
accepttext()
choose case this.getcolumnname()
	case 'banco'
		ii_banco = this.getitemnumber(this.getrow(),'banco')
		this.setitem(this.getrow(),'cuenta',ls_nulo)
		this.setcolumn('cuenta')
		idwc_cuenta.SetFilter("cuen_banco = " + string(ii_banco) )	
		li_rtn = idwc_cuenta.Filter()
		if idwc_cuenta.rowcount() > 0 then
			is_cuenta = idwc_cuenta.getitemstring(1,'cuen_no_cuenta')
				this.setitem(1,'cuenta',is_cuenta)
				SELECT bamcuent.cuen_fecha_conci  
				 INTO :ldt_fecha  
				 FROM bamcuent  
				WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
						( bamcuent.cuen_empresa = :str.empresa ) AND  
						( bamcuent.cuen_banco = :ii_banco ) AND  
						( bamcuent.cuen_no_cuenta = :is_cuenta ) ;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al seleccionar fecha '+sqlca.sqlerrtext,1,1,'E')
							return
						end if
	
			this.setitem(1,'fecha1',relativedate(date(ldt_fecha), 1))
			ldt_fecha2 = relativedate(date(ldt_fecha), 1)
			ldt_fecha2 = date(string(gf_last_day(month(ldt_fecha2) , year(ldt_fecha2)))+'/'+string(month(ldt_fecha2))+'/'+string(year(ldt_fecha2)))
			this.setitem(1,'fecha2',date(ldt_fecha2))
			this.setcolumn('fecha2')
		end if
	case 'cuenta'
		is_cuenta = data
		  SELECT bamcuent.cuen_fecha_conci  
			 INTO :ldt_fecha  
			 FROM bamcuent  
			WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
					( bamcuent.cuen_empresa = :str.empresa ) AND  
					( bamcuent.cuen_banco = :ii_banco ) AND  
					( bamcuent.cuen_no_cuenta = :is_cuenta ) ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al seleccionar fecha '+sqlca.sqlerrtext,1,1,'E')
						return
					end if

		this.setitem(1,'fecha1',relativedate(date(ldt_fecha), 1))
		ldt_fecha2 = relativedate(date(ldt_fecha), 1)
		ldt_fecha2 = date(string(gf_last_day(month(ldt_fecha2) , year(ldt_fecha2)))+'/'+string(month(ldt_fecha2))+'/'+string(year(ldt_fecha2)))
		this.setitem(1,'fecha2',date(ldt_fecha2))
		this.setcolumn('fecha2')
	case 'fecha1'
		this.setcolumn('fecha2')
	case 'fecha2'
		cb_consultar.triggerevent('clicked')
end choose
end event

event itemfocuschanged;//override
string ls_filtro
integer li_rtn
dw = dw_6
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
dw = dw_6
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

type cb_consultar from commandbutton within w_conciliacion_bancaria
integer x = 3639
integer y = 36
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
wf_recuperar(dw_5)
em_saldo_banco.setfocus()
end event

type cb_2 from commandbutton within w_conciliacion_bancaria
integer x = 4009
integer y = 36
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

type uo_1 from u_ddcalen within w_conciliacion_bancaria
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

type uo_2 from u_ddcalen within w_conciliacion_bancaria
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

type dw_3 from datawindow within w_conciliacion_bancaria
event ue_postitem ( )
event ue_sobre pbm_nchittest
integer x = 2094
integer y = 204
integer width = 1989
integer height = 792
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "Cheques"
string dataobject = "dw_cheques_conciliacion"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_postitem();if this.update() = -1 then
	gf_mensaje('','Error al actualizar cheques '+sqlca.sqlerrtext,1,1,'E')
else
	if dw_3.rowcount() > 0 then dw_5.Modify("c_cheq.Expression='" + string(dw_3.getitemnumber(1,'transito'))  + "'")
end if
end event

event ue_sobre;//override
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

event itemchanged;this.accepttext()
this.postevent('ue_postitem')

end event

event clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.
dw = dw_3
string ls_objeto, ls_column, ls_contenido
integer li_pos , i

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

ls_column = dwo.name

if ls_column = 'btdi_documento' then
	str_cc_formatos str_formato1	
	str_formato1.transaccion = dw_3.getitemstring(row,'btdi_tipo_transaccion')
	str_formato1.sub_transaccion = dw_3.getitemstring(row,'btdi_sub_transaccion')
	str_formato1.cuenta_banco = dw_3.getitemString(row,'btdi_no_cuenta')
	str_formato1.banco = dw_3.getitemnumber(row,'btdi_banco')
	str_formato1.documento = dw_3.getitemstring(row,'btdi_documento')
	str_formato1.referencia = dw_3.getitemstring(row,'btdi_referencia')
	str_formato1.anio = dw_3.getitemnumber(row,'btdi_ann')
	OpenSheetwithparm(w_consulta_transacciones_bco,str_formato1,parent,2, Original!)
elseif ls_column = 'btdi_conciliacion_t' then
	if this.rowcount() > 0 then
		if this.getitemstring(1,'btdi_conciliacion') = 'C' then
			if gf_mensaje('','Desmarcar todos los Cheques ?',2,1,'Q') = 2 then return
			ls_contenido = 'P'
		else
			if gf_mensaje('','Marcar todos los Cheques ?',2,1,'Q') = 2 then return
			ls_contenido = 'C'			
		end if
		for i = 1 to this.rowcount()
			this.setitem(i,'btdi_conciliacion',ls_contenido)
		next
		if this.update() = -1 then
			gf_mensaje('','Error al actualizar cheques '+sqlca.sqlerrtext,1,1,'E')
		else
			if dw_3.rowcount() > 0 then dw_5.Modify("c_cheq.Expression='" + string(dw_3.getitemnumber(1,'transito'))  + "'")
		end if	
	end if
end if

//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

this.Setredraw(false)

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if right(ls_objeto,2)='_t' then

	ls_objeto = left(ls_objeto,len(ls_objeto)-2)
	
	if ls_objeto = is_ultima_ or is_ultima_ = "" then	//Si es la misma columna 
																	// o si es la primera vez
		if is_orden_  = "" or is_orden_ = "D" then
			is_orden_ = 'A'		
			this.SetSort(ls_objeto+" A")	//Ordena Ascendente
			this.sort()		
		else
			is_orden_ = 'D'					
			this.SetSort(ls_objeto+" D")	//Ordena Descendente
			this.sort()				
		end if	
		is_ultima_ = ls_objeto		
	else				
			is_orden_ = 'A'
			this.SetSort(ls_objeto+" A")
			this.sort()
			is_ultima_ = ls_objeto
	end if

end if

this.Setredraw(true)
end event

event itemfocuschanged;dw = dw_3

end event

type dw_4 from datawindow within w_conciliacion_bancaria
event ue_postitem ( )
event ue_sobre pbm_nchittest
integer x = 41
integer y = 1264
integer width = 2002
integer height = 1440
integer taborder = 60
boolean bringtotop = true
boolean titlebar = true
string title = "Otras Transacciones"
string dataobject = "dw_otras_conciliacion"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_postitem();//
if this.update() = -1 then
	gf_mensaje('','Error al actualizar transacciones '+sqlca.sqlerrtext,1,1,'E')
	rollback;
else
	commit;
	if dw_4.rowcount() > 0 then dw_5.Modify("c_notas_db.Expression='" + string(dw_4.getitemnumber(1,'tot_debito')) + "'")
	if dw_4.rowcount() > 0 then dw_5.Modify("c_notas_cr.Expression='" + string(dw_4.getitemnumber(1,'tot_credito')) + "'")
end if
end event

event ue_sobre;//override
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

event itemchanged;this.accepttext()
this.postevent('ue_postitem')
end event

event clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.
dw = dw_4
string ls_objeto, ls_column, ls_contenido
integer li_pos , i

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

ls_column = dwo.name

if ls_column = 'btdi_documento' then
	str_cc_formatos str_formato1	
	str_formato1.transaccion = dw_4.getitemstring(row,'btdi_tipo_transaccion')
	str_formato1.sub_transaccion = dw_4.getitemstring(row,'btdi_sub_transaccion')
	str_formato1.cuenta_banco = dw_4.getitemString(row,'btdi_no_cuenta')
	str_formato1.banco = dw_4.getitemnumber(row,'btdi_banco')
	str_formato1.documento = dw_4.getitemstring(row,'btdi_documento')
	str_formato1.referencia = dw_4.getitemstring(row,'btdi_referencia')
	str_formato1.anio = dw_4.getitemnumber(row,'btdi_ann')
	OpenSheetwithparm(w_consulta_transacciones_bco,str_formato1,parent,2, Original!)
elseif ls_column = 'btdi_conciliacion_t' then
	if this.rowcount() > 0 then
		if this.getitemstring(1,'btdi_conciliacion') = 'C' then
			if gf_mensaje('','Desmarcar todos los Registros ?',2,1,'Q') = 2 then return
			ls_contenido = 'P'
		else
			if gf_mensaje('','Marcar todos los Registros ?',2,1,'Q') = 2 then return
			ls_contenido = 'C'			
		end if
		for i = 1 to this.rowcount()
			this.setitem(i,'btdi_conciliacion',ls_contenido)
		next
	
//
		if this.update() = -1 then
			gf_mensaje('','Error al actualizar transacciones '+sqlca.sqlerrtext,1,1,'E')
			rollback;
		else
			commit;
			if dw_4.rowcount() > 0 then dw_5.Modify("c_notas_db.Expression='" + string(dw_4.getitemnumber(1,'tot_debito')) + "'")
			if dw_4.rowcount() > 0 then dw_5.Modify("c_notas_cr.Expression='" + string(dw_4.getitemnumber(1,'tot_credito')) + "'")
		end if
	end if
end if


//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

this.Setredraw(false)

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if right(ls_objeto,2)='_t' then

	ls_objeto = left(ls_objeto,len(ls_objeto)-2)
	
	if ls_objeto = is_ultima_ or is_ultima_ = "" then	//Si es la misma columna 
																	// o si es la primera vez
		if is_orden_  = "" or is_orden_ = "D" then
			is_orden_ = 'A'		
			this.SetSort(ls_objeto+" A")	//Ordena Ascendente
			this.sort()		
		else
			is_orden_ = 'D'					
			this.SetSort(ls_objeto+" D")	//Ordena Descendente
			this.sort()				
		end if	
		is_ultima_ = ls_objeto		
	else				
			is_orden_ = 'A'
			this.SetSort(ls_objeto+" A")
			this.sort()
			is_ultima_ = ls_objeto
	end if

end if

this.Setredraw(true)
end event

event itemfocuschanged;dw = dw_4
end event

type dw_5 from datawindow within w_conciliacion_bancaria
integer x = 2107
integer y = 1004
integer width = 1993
integer height = 1708
integer taborder = 70
boolean bringtotop = true
boolean titlebar = true
string title = "Conciliacion"
string dataobject = "dw_saldos_conciliacion"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemfocuschanged;dw = dw_6
end event

event clicked;dw = dw_6
end event

type st_1 from statictext within w_conciliacion_bancaria
integer x = 430
integer y = 116
integer width = 549
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
string text = "SALDO EN BANCO: "
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_saldo_banco from editmask within w_conciliacion_bancaria
integer x = 1001
integer y = 116
integer width = 379
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###,##0.00"
end type

event modified;decimal{2} ldec_saldo
ldec_saldo = double(em_saldo_banco.text)
dw_5.Modify("c_sald.Expression='" + string(ldec_saldo)    + "'")
end event

type cb_1 from commandbutton within w_conciliacion_bancaria
integer x = 4110
integer y = 2292
integer width = 366
integer height = 100
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "ACTUALIZAR"
end type

event clicked;decimal{2} ld_libro, ld_conciliado
integer li_banco, i, j
string  ls_cuenta, ls_tran, ls_tran_temp, ls_mg
datetime ldt_fecha1, ldt_fecha2
date     ldt_fecha_actual
decimal{2} ld_saldo_bancos, ld_saldo_conciliado, ld_depo_tran, ld_notas_cr_tran, ld_cheques_tran, ld_notas_db_tran, &
           ld_saldo_anterior_libros, ld_monto, ld_monto_transaccion
decimal{2} ld_cheques, ld_depositos, ld_ncredito, ld_ndebito, ld_trandebito, ld_trancredito
decimal{2} ld_valores[]
string ls_transacciones[]

dw_2.accepttext()

ldt_fecha_actual = date(gf_fecha_serv())
ld_libro = dw_5.getitemnumber(1,'c_libro')
ld_conciliado = dw_5.getitemnumber(1,'c_saldo_conciliado')

if ld_libro <> ld_conciliado then
	gf_mensaje('','Debe Conciliar los Saldos de la Cuenta para Actualizar, Verifique !!!',1,1,'E')
	return
end if


if gf_mensaje('','Seguro de cerrar la Conciliacion de la Cuenta '+is_cuenta,2,2,'E') = 2 then Return

li_banco = dw_2.GetItemNumber(1,"banco")
ls_cuenta= dw_2.getitemstring(1,'cuenta')
ldt_fecha1 = dw_2.getitemdatetime(1,'fecha1')
ldt_fecha2 = dw_2.getitemdatetime(1,'fecha2')

parent.triggerevent('ue_print')

//recorrer el dw_5, para acumular los valores de las transacciones generadas en libros
j = 1
for i = 1 to dw_5.rowcount()
	if i = 1 then
		ls_tran_temp  = dw_5.getitemstring(i,'btdi_tipo_transaccion')
	end if
	ld_monto = dw_5.getitemnumber(i,'btdi_monto')
	ls_tran  = dw_5.getitemstring(i,'btdi_tipo_transaccion')
	if ls_tran <> ls_tran_temp then
		ls_transacciones[j] = ls_tran_temp
		ld_valores[j] = ld_monto_transaccion
		j ++
		ld_monto_transaccion = ld_monto
		ls_tran_temp = ls_tran
	else
		ld_monto_transaccion = ld_monto_transaccion + ld_monto	
		ls_transacciones[j] = ls_tran_temp
		ld_valores[j] = ld_monto_transaccion
	end if	
next
ls_transacciones[j] = ls_tran_temp
ld_valores[j] = ld_monto_transaccion

for i = 1 to upperbound(ls_transacciones)
	ls_tran = ls_transacciones[i]
	choose case ls_tran
		case 'CH'
			ld_cheques = ld_valores[i]
		case 'DE','SD'
			ld_depositos = ld_depositos + ld_valores[i]
		case 'CB' //Nota de credito bancaria
			ld_ncredito = ld_valores[i]
		case 'NR', 'NB' //Nota de debito bancaria
			ld_ndebito = ld_valores[i]			
		case 'TC'
			ld_trancredito = ld_valores[i]
		case 'TD'
			ld_trandebito = ld_valores[i]			
	end choose
next

sqlca.autocommit = false

	//actualiza la tabla de cuentas, montos y fechas	
		
	//Actualiza la tabla de saldos
	ld_saldo_bancos 		= dw_5.getitemnumber(1,'c_sald')
	ld_saldo_conciliado  = dw_5.getitemnumber(1,'c_saldo_conciliado')
	
	//Para q actualice con la fecha final menos 1 dia
	//ldt_fecha2 = datetime(relativedate(date(ldt_fecha2),-1), time('00:00:00'))
		
	//otros valores libros
	ld_saldo_anterior_libros = dw_5.getitemnumber(1,'c_saldo_anterior')
	
	//saldos segun banco
	ld_depo_tran	= dw_5.getitemnumber(1,'c_depo')
	ld_notas_cr_tran	= dw_5.getitemnumber(1,'c_notas_cr')
	ld_notas_db_tran	= dw_5.getitemnumber(1,'c_notas_db')
	ld_cheques_tran	= dw_5.getitemnumber(1,'c_cheq')
	
	//guarda la conciliacion en la tabla de saldos
	
  INSERT INTO bamsaldo  
         ( sald_g_financiero, sald_empresa, sald_banco, sald_cuenta, sald_fecha_ini_periodo, sald_fecha_fin_periodo,   
           sald_fecha_lib, sald_monto_lib_ini, sald_cheq_girados, sald_depo_lib, sald_ajustes_db, sald_ajustes_cr,   
           sald_nota_cr_lib, sald_nota_db_lib, sald_transf_cr_lib, sald_transf_db_lib, sald_fecha_ban, sald_monto_ban_ini,   
           sald_depo_transito, sald_cheq_circula, sald_nota_db_trans, sald_nota_cr_trans, sald_user_id, sald_fecha_conciliacion )  
  VALUES ( :str.g_financiero,   :str.empresa,   :li_banco,   :ls_cuenta,   :ldt_fecha1,   :ldt_fecha2,   
           :ldt_fecha1, :ld_saldo_anterior_libros, :ld_cheques, :ld_depositos,  0, 0 ,
           :ld_ncredito, :ld_ndebito, :ld_trancredito, :ld_trandebito, :ldt_fecha2,  :ld_saldo_bancos  ,
			  :ld_depo_tran, :ld_cheques_tran, :ld_notas_db_tran, :ld_notas_cr_tran, :str.usuario, :ldt_fecha_actual)  ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al insertar saldos '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			sqlca.autocommit = true
			return
		end if
			

INSERT INTO badsaldo  
		(bdsa_g_financiero,bdsa_empresa,bdsa_tipo_transaccion, bdsa_sub_transaccion, bdsa_banco,bdsa_no_cuenta,   
		bdsa_documento,bdsa_referencia,bdsa_ann,bdsa_fecha_fin_periodo,bdsa_monto,bdsa_naturaleza,bdsa_fecha_tran,bdsa_a_nombre_de, bdsa_circulacion)
SELECT btdi_g_financiero,btdi_empresa,btdi_tipo_transaccion,btdi_sub_transaccion,btdi_banco,btdi_no_cuenta,
		btdi_documento,btdi_referencia,btdi_ann,:ldt_fecha2,btdi_monto,btdi_naturaleza,btdi_fecha_tran,btdi_a_nombre_de,
		case btdi_conciliacion when 'C' then 0 when 'P' then 1 end
 FROM batdiari  
where btdi_g_financiero = :str.g_financiero and btdi_empresa = :str.empresa and
		btdi_banco = :li_banco and btdi_no_cuenta = :ls_cuenta and
		btdi_fecha_tran <= :ldt_fecha2 and
		btdi_conciliacion in ('C','P');

if sqlca.sqlcode = -1 then
	ls_mg = sqlca.sqlerrtext
	rollback;
	sqlca.autocommit = TRUE
	gf_mensaje('','Error al guardar historicos '+ls_mg,1,1,'E')
	return
end if

//Actualiza la conciliacion, se actualizan las transacciones del periodo conciliado
		update batdiari
         set  batdiari.btdi_conciliacion = 'F',
			     batdiari.btdi_fecha_concilia = :ldt_fecha_actual ,
				   batdiari.btdi_fecha_conciliacion = :ldt_fecha2    
        FROM batdiari ,
           bamcuent ,
           bancos     
        WHERE ( bamcuent.cuen_g_financiero = batdiari.btdi_g_financiero ) and   
       ( bamcuent.cuen_empresa = batdiari.btdi_empresa ) and   
       ( bamcuent.cuen_no_cuenta = batdiari.btdi_no_cuenta ) and  
        ( bamcuent.cuen_banco = batdiari.btdi_banco ) and    
      ( bancos.banc_codigo = bamcuent.cuen_banco ) and    
      ( (  batdiari.btdi_g_financiero = :str.g_financiero  ) and  
        (  batdiari.btdi_empresa = :str.empresa  ) and   
        (  batdiari.btdi_banco = :li_banco  ) and  
        (  batdiari.btdi_no_cuenta = :ls_cuenta  ) and  
        (  batdiari.btdi_fecha_tran <= :ldt_fecha2 ) and   
		  (  batdiari.btdi_conciliacion = 'C' ) and
        (  batdiari.btdi_tipo_transaccion not in ( 'SI' ) ) )  ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al actualizar Transacciones a Conciliadas '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			sqlca.autocommit = true
			return
		end if				
			
			update bamcuent
			set cuen_monto_conciliacion = :ld_saldo_conciliado,  //saldo de conciliacion
				cuen_saldo_libros = :ld_libro, //saldo en libros
				cuen_saldo_banco =    :ld_saldo_bancos, //saldo en banco
				cuen_fecha_conci = :ldt_fecha2,
				cuen_fecha_saldo_banco = :ldt_fecha2,
				cuen_fecha_saldo_libros = :ldt_fecha2
			where cuen_g_financiero = :str.g_financiero and
				cuen_empresa = :str.empresa and
				cuen_banco = :li_banco and
				cuen_no_cuenta = :ls_cuenta ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al actualizar cheques '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if		
			
commit ;

dw_7.retrieve(str.g_financiero, str.empresa, ii_banco, is_cuenta, ldt_fecha2)

dw_7.object.empresanom.expression = "'"+str.nombre_empresa+"'"
dw_7.object.datawindow.print.preview = True
dw_7.object.datawindow.print.preview.zoom = 100

OpenWithParm(w_dw_print_options, dw_7)
If Message.DoubleParm = -1 Then Return
dw_7.Print(True)


gf_mensaje('','Actualizacion Exitosa',1,1,'E')

dw_2.setitem(1,'cuenta','')
dw_2.setcolumn('cuenta')
em_saldo_banco.text = '0.00'
parent.triggerevent('ue_post_open')
end event

type dw_6 from datawindow within w_conciliacion_bancaria
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

type dw_7 from datawindow within w_conciliacion_bancaria
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

type pb_anteriores from picturebutton within w_conciliacion_bancaria
integer x = 4233
integer y = 312
integer width = 133
integer height = 116
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "C:\Sistemas\Hymsoft\Art\PRNBATCH.BMP"
string powertiptext = "Ver Conciliaciones Anteriores ..."
end type

event clicked;wf_conciliaciones_anteriores()
end event

type st_2 from statictext within w_conciliacion_bancaria
integer x = 4087
integer y = 436
integer width = 407
integer height = 140
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long textcolor = 8388608
long backcolor = 12639424
string text = "Conciliaciones Anteriores"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

event clicked;wf_conciliaciones_anteriores()
end event

