//objectcomments Consulta de transacciones de clientes Vista Previa
forward
global type w_reporte_cuentas_bancarias from w_fa_padre_reportes
end type
type st_sel_marca from statictext within w_reporte_cuentas_bancarias
end type
type ddlb_1 from dropdownlistbox within w_reporte_cuentas_bancarias
end type
type dw_2 from datawindow within w_reporte_cuentas_bancarias
end type
type cb_consultar from commandbutton within w_reporte_cuentas_bancarias
end type
type cb_2 from commandbutton within w_reporte_cuentas_bancarias
end type
type uo_1 from u_ddcalen within w_reporte_cuentas_bancarias
end type
type uo_2 from u_ddcalen within w_reporte_cuentas_bancarias
end type
type dw_3 from datawindow within w_reporte_cuentas_bancarias
end type
type dw_4 from datawindow within w_reporte_cuentas_bancarias
end type
type cbx_resumido from checkbox within w_reporte_cuentas_bancarias
end type
end forward

global type w_reporte_cuentas_bancarias from w_fa_padre_reportes
integer x = 0
integer y = 0
integer width = 5061
integer height = 2680
string title = "Consulta de Saldos Bancarios"
long backcolor = 12639424
windowanimationstyle openanimation = rightroll!
windowanimationstyle closeanimation = rightslide!
st_sel_marca st_sel_marca
ddlb_1 ddlb_1
dw_2 dw_2
cb_consultar cb_consultar
cb_2 cb_2
uo_1 uo_1
uo_2 uo_2
dw_3 dw_3
dw_4 dw_4
cbx_resumido cbx_resumido
end type
global w_reporte_cuentas_bancarias w_reporte_cuentas_bancarias

type variables
str_fa_ventafact str_informe
datawindowchild idwc_cuenta
integer ii_banco
string is_cuenta
datetime idt_fecha1, idt_fecha2, idt_fecha3, idt_fecha4, idt_fecha5, idt_fecha6

end variables

forward prototypes
public function datetime wf_busca_dia_habil (datetime ad_fecha)
end prototypes

public function datetime wf_busca_dia_habil (datetime ad_fecha);integer j
string ls_day
datetime ldt_desde
ldt_desde = ad_fecha

	for j = 1 to 7
		ldt_desde = datetime(relativedate(date(ldt_desde), 1),time('00:00:00'))
		
		ls_day	 = dayname(date(ldt_desde))
		if ls_day = 'Sunday' or ls_day = 'Saturday' then
			continue
		else
			exit
		end if
	next

return ldt_desde
end function

on w_reporte_cuentas_bancarias.create
int iCurrent
call super::create
this.st_sel_marca=create st_sel_marca
this.ddlb_1=create ddlb_1
this.dw_2=create dw_2
this.cb_consultar=create cb_consultar
this.cb_2=create cb_2
this.uo_1=create uo_1
this.uo_2=create uo_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.cbx_resumido=create cbx_resumido
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
this.Control[iCurrent+10]=this.cbx_resumido
end on

on w_reporte_cuentas_bancarias.destroy
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
destroy(this.cbx_resumido)
end on

event ue_post_open;//override
string  ls_dinero, ls_tran, ls_documento, ls_stran, ls_ref, ls_cuenta
Integer li_ann, li_banco
datetime ldt_desde, ldt_hasta

ldt_desde = datetime(relativedate(date(gf_fecha_serv()), - 30),00:00:00)
ldt_hasta = datetime(date(gf_fecha_serv()),23:59:59)

dw_4.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_2.getchild('cuenta', idwc_cuenta)
idwc_cuenta.settransobject(sqlca)
//idwc_cuenta.retrieve(str.g_financiero, str.empresa)
idwc_cuenta.insertrow(1)
dw_2.insertrow(1)
dw_2.setitem(1,'fecha1',ldt_desde)
dw_2.setitem(1,'fecha2',ldt_hasta)
dw_2.setcolumn('banco')

dw_1.retrieve(str.g_financiero, str.empresa)

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

dw_1.setfocus()

dw_1.sharedata(dw_3)
dw_3.object.datawindow.print.preview = True
dw_3.object.datawindow.zoom = 95
end event

event resize;//Override
//this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 378

//this.SetRedraw(true)
end event

event open;call super::open;//str_informe = Message.PowerObjectParm
//this.y = 0
//this.x = 805
//this.width  = 2680// this.width - 99
//this.height = this.height - 90
end event

event ue_print;//override
dw_3.visible = true
dw_3.setfilter('saldo_actual <> 0')
dw_3.filter()
OpenWithParm(w_dw_print_options, dw_3)
If Message.DoubleParm = -1 Then Return
dw_3.Print(True)
end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_reporte_cuentas_bancarias
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_reporte_cuentas_bancarias
boolean visible = false
integer x = 32
integer y = 1384
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_reporte_cuentas_bancarias
integer x = 27
integer y = 96
integer width = 4974
integer height = 2324
string dataobject = "dw_reporte_saldos_cuenta"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

event dw_1::doubleclicked;call super::doubleclicked;integer li_banco
time lt_time
string ls_cuenta, ls_campo
datetime ldt_fecha_habilita, ldt_fecha_habilita2


lt_time = time('00:00:00')
li_banco = this.getitemnumber(row,'bamcuent_cuen_banco')
ls_cuenta=this.getitemstring(row,'bamcuent_cuen_no_cuenta')

choose case dwo.name
	case 'saldo_1'
		ldt_fecha_habilita = idt_fecha1
		ldt_fecha_habilita2 = idt_fecha1 
	case 'saldo_2'
		ldt_fecha_habilita = idt_fecha2
		ldt_fecha_habilita2 = idt_fecha2 
	case 'saldo_3'
		ldt_fecha_habilita = idt_fecha3
		ldt_fecha_habilita2 = idt_fecha3 
	case 'saldo_4'
		ldt_fecha_habilita = idt_fecha4
		ldt_fecha_habilita2 = idt_fecha4 
	case 'saldo_5'
		ldt_fecha_habilita = idt_fecha5
		ldt_fecha_habilita2 = idt_fecha5 
	case 'saldo_6'
		ldt_fecha_habilita = idt_fecha6
		ldt_fecha_habilita2 = idt_fecha6 
end choose

dw_4.title = 'Detalle del día '+string(date(ldt_fecha_habilita))+' de la cuenta '+ls_cuenta
dw_4.retrieve(str.g_financiero, str.empresa, li_banco, ls_cuenta, ldt_fecha_habilita, ldt_fecha_habilita2)
dw_4.visible  = true
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
//	OpenSheetwithparm(w_mant_clientes,str_formato1,parent,2, Original!)
	
end if
end event

event dw_1::retrieveend;call super::retrieveend;//Buscar el saldo
integer i, li_banco, j
string ls_cuenta, ls_day
datetime ldt_desde, ldt_desde_temp, ldt_hasta, ldt_anterior, ldt_desde_anterior
date ldt_fecha, ldt_fecha_anterior_temp
time lt_time
decimal{2} ld_saldo_anterior, ld_dep1, ld_dep2, ld_dep3, ld_dep4, ld_dep5, ld_monto
ldt_desde = gf_fecha_serv()
ldt_desde_temp = gf_fecha_serv()
lt_time = time('00:00:00')

for i = 1 to rowcount

	ldt_fecha = date('01/'+string(month(date(ldt_desde_temp)))+'/'+string(year(date(ldt_desde_temp))))
	ldt_hasta = datetime(ldt_fecha, lt_time)
	
	li_banco = this.getitemnumber(i,'bamcuent_cuen_banco')
	ls_cuenta= this.getitemstring(i,'bamcuent_cuen_no_cuenta')

	//Busca el saldo Anterior
	ldt_fecha_anterior_temp = relativedate(date(ldt_desde), -1)
	ldt_anterior = datetime(ldt_fecha_anterior_temp, lt_time)
	ld_saldo_anterior = gf_saldo_anterior_ba(li_banco, ls_cuenta, ldt_anterior)
	this.setitem(i,'saldo',ld_saldo_anterior)

	//Busca el saldo actual
	ld_saldo_anterior = gf_saldo_anterior_ba(li_banco, ls_cuenta, ldt_desde)	
	this.setitem(i,'saldo_actual',ld_saldo_anterior)
	this.setitem(i,'saldo',ld_saldo_anterior)  //Se ubico aqui para probar, traia un saldo equivocado
	
	//Busca el saldo inicial, final del mes anterior
	ldt_desde = datetime(relativedate(ldt_fecha, -1), lt_time)
	ld_saldo_anterior = gf_saldo_anterior_ba(li_banco, ls_cuenta, ldt_desde)	
	this.setitem(i,'saldo_inicial',ld_saldo_anterior)

	//Depositos del mes
	SELECT sum(batdiari.btdi_monto)   
	into :ld_monto
    FROM batdiari  
   WHERE ( batdiari.btdi_g_financiero = :str.g_financiero ) AND  
         ( batdiari.btdi_empresa = :str.empresa ) AND  
         ( batdiari.btdi_banco = :li_banco ) AND  
         ( batdiari.btdi_no_cuenta = :ls_cuenta ) AND  
         ( batdiari.btdi_fecha_tran >= :ldt_hasta ) AND  
         ( batdiari.btdi_fecha_tran <= :ldt_desde_temp ) AND  			
         ( batdiari.btdi_tipo_transaccion in ('DE','SD') ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Buscar depositos '+sqlca.sqlerrtext,1,1,'E')
		end if
		
		this.setitem(i,'depositos',ld_monto)	
		
	//Cheques del mes
	SELECT sum(batdiari.btdi_monto)   
	into :ld_monto
    FROM batdiari  
   WHERE ( batdiari.btdi_g_financiero = :str.g_financiero ) AND  
         ( batdiari.btdi_empresa = :str.empresa ) AND  
         ( batdiari.btdi_banco = :li_banco ) AND  
         ( batdiari.btdi_no_cuenta = :ls_cuenta ) AND  
         ( batdiari.btdi_fecha_tran >= :ldt_hasta ) AND  
         ( batdiari.btdi_fecha_tran <= :ldt_desde_temp ) AND  			
         ( batdiari.btdi_tipo_transaccion = 'CH' ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Buscar depositos '+sqlca.sqlerrtext,1,1,'E')
		end if
	this.setitem(i,'cheques',ld_monto)	
	
	//Notas de Debito
	SELECT sum(batdiari.btdi_monto)   
	into :ld_monto
    FROM batdiari  
   WHERE ( batdiari.btdi_g_financiero = :str.g_financiero ) AND  
         ( batdiari.btdi_empresa = :str.empresa ) AND  
         ( batdiari.btdi_banco = :li_banco ) AND  
         ( batdiari.btdi_no_cuenta = :ls_cuenta ) AND  
         ( batdiari.btdi_fecha_tran >= :ldt_hasta ) AND  
         ( batdiari.btdi_fecha_tran <= :ldt_desde_temp ) AND  	
			( batdiari.btdi_naturaleza = 'C') AND
         ( batdiari.btdi_tipo_transaccion not in ('CH','DE','SD') ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Buscar depositos '+sqlca.sqlerrtext,1,1,'E')
		end if
	this.setitem(i,'ndebito',ld_monto)		
	
	//Notas de Credito
	SELECT sum(batdiari.btdi_monto)   
	into :ld_monto
    FROM batdiari  
   WHERE ( batdiari.btdi_g_financiero = :str.g_financiero ) AND  
         ( batdiari.btdi_empresa = :str.empresa ) AND  
         ( batdiari.btdi_banco = :li_banco ) AND  
         ( batdiari.btdi_no_cuenta = :ls_cuenta ) AND  
         ( batdiari.btdi_fecha_tran >= :ldt_hasta ) AND  
         ( batdiari.btdi_fecha_tran <= :ldt_desde_temp ) AND  	
			( batdiari.btdi_naturaleza = 'D') AND
         ( batdiari.btdi_tipo_transaccion not in ('CH','DE','SD') ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Buscar depositos '+sqlca.sqlerrtext,1,1,'E')
		end if
	this.setitem(i,'ncredito',ld_monto)		
	
	ldt_desde = ldt_desde_temp
	ldt_desde_anterior = datetime(relativedate(date(ldt_desde), 1),time('00:00:00'))
	//Asigna el primer dia de depositos
	for j = 1 to 7
		ldt_desde = datetime(relativedate(date(ldt_desde), 1),time('00:00:00'))
		
		ls_day	 = dayname(date(ldt_desde))
		if ls_day = 'Sunday' or ls_day = 'Saturday' then
			continue
		else
			exit
		end if
	next
	idt_fecha1 = ldt_desde
	ld_dep1 = gf_saldo_anterior_ba_dep(li_banco, ls_cuenta, ldt_desde_anterior, ldt_desde,0)		
	this.setitem(i,'saldo_1',ld_dep1)
	this.modify('saldo_1_t.text = "'+string(date(ldt_desde))+'"')
	this.setitem(i,'saldo_f1',string(date(ldt_desde)))
	

	//Asigna el segundo dia de depositos
	ldt_desde_anterior = datetime(relativedate(date(ldt_desde), 1),time('00:00:00'))
	for j = 1 to 7
		ldt_desde = datetime(relativedate(date(ldt_desde), 1),time('00:00:00'))
		ls_day	 = dayname(date(ldt_desde))
		if ls_day = 'Sunday' or ls_day = 'Saturday' then
			continue
		else
			exit
		end if
	next	
	idt_fecha2 = ldt_desde
	ld_dep2 = gf_saldo_anterior_ba_dep(li_banco, ls_cuenta, ldt_desde_anterior, ldt_desde,0)	
	this.setitem(i,'saldo_2',ld_dep2)
	this.modify('saldo_2_t.text = "'+string(date(ldt_desde))+'"')
	this.setitem(i,'saldo_f2',string(date(ldt_desde)))
	
	//Asigna el tercer dia de depositos
	ldt_desde_anterior = datetime(relativedate(date(ldt_desde), 1),time('00:00:00'))	
	for j = 1 to 7		
		ldt_desde = datetime(relativedate(date(ldt_desde), 1),time('00:00:00'))
		ls_day	 = dayname(date(ldt_desde))
		if ls_day = 'Sunday' or ls_day = 'Saturday' then
			continue
		else
			exit
		end if
	next	
	idt_fecha3 = ldt_desde
	ld_dep3 = gf_saldo_anterior_ba_dep(li_banco, ls_cuenta, ldt_desde_anterior, ldt_desde,0)	
	this.setitem(i,'saldo_3',ld_dep3)
	this.modify('saldo_3_t.text = "'+string(date(ldt_desde))+'"')
	this.setitem(i,'saldo_f3',string(date(ldt_desde)))
	
	//Asigna el cuarto dia de depositos
	ldt_desde_anterior = datetime(relativedate(date(ldt_desde), 1),time('00:00:00'))	
	for j = 1 to 7		
		ldt_desde = datetime(relativedate(date(ldt_desde), 1),time('00:00:00'))
		ls_day	 = dayname(date(ldt_desde))
		if ls_day = 'Sunday' or ls_day = 'Saturday' then
			continue
		else
			exit
		end if
	next		
	idt_fecha4 = ldt_desde
	ld_dep4 = gf_saldo_anterior_ba_dep(li_banco, ls_cuenta, ldt_desde_anterior, ldt_desde,0)	
	this.setitem(i,'saldo_4',ld_dep4)
	this.modify('saldo_4_t.text = "'+string(date(ldt_desde))+'"')
	this.setitem(i,'saldo_f4',string(date(ldt_desde)))
	//Asigna el quinto dia de depositos
	ldt_desde_anterior = datetime(relativedate(date(ldt_desde), 1),time('00:00:00'))	
	for j = 1 to 7		
		ldt_desde = datetime(relativedate(date(ldt_desde), 1),time('00:00:00'))
		ls_day	 = dayname(date(ldt_desde))
		if ls_day = 'Sunday' or ls_day = 'Saturday' then
				continue
			else
				exit
			end if
	next
	idt_fecha5 = ldt_desde
	ld_dep5 = gf_saldo_anterior_ba_dep(li_banco, ls_cuenta, ldt_desde_anterior, ldt_desde,0)	
	this.setitem(i,'saldo_5',ld_dep5)
	this.modify('saldo_5_t.text = "'+string(date(ldt_desde))+'"')
	this.setitem(i,'saldo_f5',string(date(ldt_desde)))	
	
	//Asigna el Sexto dia de depositos
	ldt_desde_anterior = datetime(relativedate(date(ldt_desde), 1),time('00:00:00'))	
	for j = 1 to 7		
		ldt_desde = datetime(relativedate(date(ldt_desde), 20),time('00:00:00'))
		ls_day	 = dayname(date(ldt_desde))
		if ls_day = 'Sunday' or ls_day = 'Saturday' then
				continue
			else
				exit
			end if
	next
	idt_fecha6 = ldt_desde
	ld_dep5 = gf_saldo_anterior_ba_dep(li_banco, ls_cuenta, ldt_desde_anterior, ldt_desde,0)	
	this.setitem(i,'saldo_6',ld_dep5)
	this.modify('saldo_6_t.text = " >= a '+string(date(ldt_desde_anterior))+'"')
	this.setitem(i,'saldo_f6',string(date(ldt_desde)))	
next
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_reporte_cuentas_bancarias
boolean visible = false
integer x = 27
integer y = 192
integer width = 2967
integer height = 1364
long backcolor = 12639424
end type

type st_sel_marca from statictext within w_reporte_cuentas_bancarias
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

type ddlb_1 from dropdownlistbox within w_reporte_cuentas_bancarias
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

type dw_2 from datawindow within w_reporte_cuentas_bancarias
boolean visible = false
integer x = 55
integer y = 72
integer width = 1467
integer height = 120
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_reporte_tran_cuentas"
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

type cb_consultar from commandbutton within w_reporte_cuentas_bancarias
boolean visible = false
integer x = 2990
integer y = 44
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
	ld_saldo_anterior = gf_saldo_anterior_ba(ii_banco, is_cuenta, ldt_desde)	
	if ld_saldo_anterior <> 0 then
		dw_1.RowsCopy(1, 1, Primary!, dw_1, 1, Primary!)
		ldt_fecha_anterior = RelativeDate(date(ldt_desde), -1)
		if ld_saldo_anterior > 0 then
			dw_1.setitem(1,'debito',ld_saldo_anterior)
			dw_1.setitem(1,'credito',0)
		else
			dw_1.setitem(1,'credito',ld_saldo_anterior)			
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

type cb_2 from commandbutton within w_reporte_cuentas_bancarias
boolean visible = false
integer x = 3369
integer y = 44
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

type uo_1 from u_ddcalen within w_reporte_cuentas_bancarias
boolean visible = false
integer x = 55
integer y = 128
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

type uo_2 from u_ddcalen within w_reporte_cuentas_bancarias
boolean visible = false
integer x = 759
integer y = 124
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

type dw_3 from datawindow within w_reporte_cuentas_bancarias
boolean visible = false
integer x = 82
integer y = 100
integer width = 3493
integer height = 1352
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Impresion de Disponibilidad"
string dataobject = "dw_reporte_saldos_cuenta_impresion"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type dw_4 from datawindow within w_reporte_cuentas_bancarias
boolean visible = false
integer x = 1637
integer y = 212
integer width = 1737
integer height = 1372
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Disponibles para el dia"
string dataobject = "dw_depositos_fecha_de_disponibilidad"
boolean controlmenu = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type cbx_resumido from checkbox within w_reporte_cuentas_bancarias
integer x = 50
integer y = 12
integer width = 507
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Ver Resumido"
end type

event clicked;if this.checked then
	dw_1.dataobject = 'dw_reporte_saldos_cuenta_resumen'
	dw_3.dataobject = 'dw_reporte_saldos_cuenta_resumen_impresion'
else
	dw_1.dataobject = 'dw_reporte_saldos_cuenta'
	dw_3.dataobject = 'dw_reporte_saldos_cuenta_impresion'
end if
dw_1.settransobject(sqlca)
parent.triggerevent('ue_post_open')
end event

