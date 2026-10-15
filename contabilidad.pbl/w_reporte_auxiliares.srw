//objectcomments Consulta de transacciones de clientes Vista Previa
forward
global type w_reporte_auxiliares from w_fa_padre_reportes
end type
type st_sel_marca from statictext within w_reporte_auxiliares
end type
type ddlb_1 from dropdownlistbox within w_reporte_auxiliares
end type
type dw_2 from datawindow within w_reporte_auxiliares
end type
type cb_consultar from commandbutton within w_reporte_auxiliares
end type
type cb_2 from commandbutton within w_reporte_auxiliares
end type
type uo_1 from u_ddcalen within w_reporte_auxiliares
end type
end forward

global type w_reporte_auxiliares from w_fa_padre_reportes
integer width = 3904
integer height = 2680
string title = "Reporte de Auxiliares"
boolean minbox = false
boolean maxbox = false
long backcolor = 12639424
st_sel_marca st_sel_marca
ddlb_1 ddlb_1
dw_2 dw_2
cb_consultar cb_consultar
cb_2 cb_2
uo_1 uo_1
end type
global w_reporte_auxiliares w_reporte_auxiliares

type variables
str_fa_ventafact str_informe
datawindowchild idwc_cuenta, idwc_cuenta2
integer ii_banco
string is_cuenta

end variables

on w_reporte_auxiliares.create
int iCurrent
call super::create
this.st_sel_marca=create st_sel_marca
this.ddlb_1=create ddlb_1
this.dw_2=create dw_2
this.cb_consultar=create cb_consultar
this.cb_2=create cb_2
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_sel_marca
this.Control[iCurrent+2]=this.ddlb_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_consultar
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.uo_1
end on

on w_reporte_auxiliares.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_sel_marca)
destroy(this.ddlb_1)
destroy(this.dw_2)
destroy(this.cb_consultar)
destroy(this.cb_2)
destroy(this.uo_1)
end on

event ue_post_open;//override
string  ls_dinero, ls_tran, ls_documento, ls_stran, ls_ref, ls_cuenta, ls_masca
Integer li_ann, li_banco, li_mes
datetime ldt_desde

//ldt_desde = datetime(relativedate(date(gf_fecha_serv()), - 30),00:00:00)
ldt_desde = datetime(date(gf_fecha_serv()),23:59:59)

dw_2.settransobject(sqlca)
dw_2.getchild('cuenta1', idwc_cuenta)
idwc_cuenta.settransobject(sqlca)
idwc_cuenta.retrieve(str.g_financiero, str.empresa)

dw_2.getchild('cuenta2', idwc_cuenta2)
idwc_cuenta2.settransobject(sqlca)
idwc_cuenta2.retrieve(str.g_financiero, str.empresa)

ls_masca = gf_mascara()
//dw_2.MODIFY("cuenta1.editmask.mask='"+ls_masca+"'") //mascara para el compute de la cuenta
idwc_cuenta.MODIFY("mg_cuenta.editmask.mask='"+ls_masca+"'") //cuenta que se graba en el detalle contable
idwc_cuenta2.MODIFY("mg_cuenta.editmask.mask='"+ls_masca+"'") //cuenta que se graba en el detalle contable
dw_1.modify("mayo_cuenta.editmask.mask='"+ls_masca+"'")
dw_2.insertrow(1)
dw_2.setitem(1,'fecha1',ldt_desde)
dw_2.setfocus()
dw_2.setcolumn('cuenta1')

str_cc_formatos lstr_sec
lstr_sec = Message.PowerObjectParm
if isvalid(lstr_sec) then 

	ls_cuenta = lstr_sec.cuenta
	ldt_desde = lstr_sec.fecha1	
	dw_2.setitem(1,'cuenta1',ls_cuenta)
	dw_2.setitem(1,'cuenta2',ls_cuenta)
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
dw_1.object.datawindow.print.preview = True
dw_1.object.datawindow.print.preview.zoom = 100
end event

event resize;//Override
//this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 378

//this.SetRedraw(true)
end event

event open;call super::open;//str_informe = Message.PowerObjectParm
this.y = 0
this.x = 805
this.width  = 4000// this.width - 99
this.height = this.height - 90
string ls_mes = ''
gf_mes_de_proceso(ls_mes)
this.title = this.title + ls_mes 
end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_reporte_auxiliares
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_reporte_auxiliares
boolean visible = false
integer x = 32
integer y = 1384
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_reporte_auxiliares
integer x = 41
integer y = 200
integer width = 3749
integer height = 2256
string dataobject = "dw_reporte_auxiliares"
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
	CASE 'mg_descripcion'
		this.Modify("mg_descripcion.Font.Underline='1'")
		this.Modify("mg_descripcion.Color='7536640'")
	CASE 'mayo_cuenta'
		this.Modify("mayo_cuenta.Font.Underline='1'")
		this.Modify("mayo_cuenta.Color='7536640'")
	CASE ELSE
		this.Modify("mg_descripcion.Font.Underline='0'")
		this.Modify("mg_descripcion.Color='0'")
		this.Modify("mayo_cuenta.Font.Underline='0'")
		this.Modify("mayo_cuenta.Color='0'")

END CHOOSE
end event

event dw_1::clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto, ls_column
integer li_pos, li_mes, li_ann 
datetime ldt_desde, ldt_hasta
date ld_desde, ld_hasta
ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

ls_column = dwo.name

if ls_column = 'mg_descripcion' or ls_column = 'mayo_cuenta' then
	str_cc_formatos str_formato1	
	if dw_1.getitemnumber(row,'mg_nivel') = 1 then return  
	str_formato1.cuenta = dw_1.getitemstring(row,'mayo_cuenta')
	li_mes = month(date(dw_2.getitemdatetime(1,'fecha1')))
	li_ann = year(date(dw_2.getitemdatetime(1,'fecha1')))
	gf_fecha_ini_fecha_fin(li_mes, li_ann, ld_desde, ld_hasta)
	ldt_desde = datetime(ld_desde,00:00:00)
   ldt_hasta = datetime(ld_hasta,23:59:59)

	str_formato1.fecha1 = ldt_desde
	str_formato1.fecha2 = ldt_hasta
	OpenSheetwithparm(w_reporte_historico_cuentas,str_formato1,parent,2, Original!)
	
end if
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_reporte_auxiliares
boolean visible = false
integer x = 27
integer y = 192
integer width = 2967
integer height = 1364
long backcolor = 12639424
end type

type st_sel_marca from statictext within w_reporte_auxiliares
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

type ddlb_1 from dropdownlistbox within w_reporte_auxiliares
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

type dw_2 from datawindow within w_reporte_auxiliares
integer x = 55
integer y = 32
integer width = 3022
integer height = 120
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_auxiliares"
boolean border = false
boolean livescroll = true
end type

event itemchanged;string ls_nulo
setnull(ls_nulo)

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

end choose
end event

type cb_consultar from commandbutton within w_reporte_auxiliares
integer x = 3095
integer y = 40
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

event clicked;string ls_dinero, ls_tran, ls_documento, ls_fecha_text, ls_cuenta1, ls_cuenta2
integer li_ann, li_mes, li_caracteres_nivel1
date ldt_desde, ldt_hasta
date ldt_fecha_anterior
decimal{2} ld_saldo_anterior

ldt_desde = date(dw_2.getitemdatetime(1,'fecha1'))
li_ann = year(ldt_desde)
li_mes = month(ldt_desde)
ls_cuenta1 = dw_2.getitemstring(1,'cuenta1')
ls_cuenta2 = dw_2.getitemstring(1,'cuenta2')

  SELECT dganivec.nive_cada_nivel  
    INTO :li_caracteres_nivel1  
    FROM dganivec  
   WHERE ( dganivec.nive_g_financiero = :str.g_financiero ) AND  
         ( dganivec.nive_empresa = :str.empresa ) AND  
         ( dganivec.nive_no_nivel = 1 ) ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al buscar la cantidad de caracteres por nivel '+sqlca.sqlerrtext,1,1,'E')
		return
	end if

ls_cuenta2 = mid(ls_cuenta2,1,li_caracteres_nivel1)+Fill("9", 20 - li_caracteres_nivel1)

if dw_1.retrieve(str.g_financiero, str.empresa, li_ann, li_mes, ls_cuenta1, ls_cuenta2) = 0 then
	gf_mensaje('','No se recupero informacion, Verifique!!!',1,1,'E')
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
If dw_1.Describe("ruc.x") <> "?" And dw_1.Describe("ruc.x") <> "!" Then
	dw_1.object.ruc.expression = "'"+ str.ruc+ ' D.V. '+str.dv +"'"	
End If	
dw_1.object.datawindow.print.preview = True
dw_1.object.datawindow.print.preview.zoom = 100
dw_1.setfocus()
end event

type cb_2 from commandbutton within w_reporte_auxiliares
integer x = 3474
integer y = 40
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

type uo_1 from u_ddcalen within w_reporte_auxiliares
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

