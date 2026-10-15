//objectcomments Balance de Pruebas
forward
global type w_reporte_balance_de_prueba from w_fa_padre_reportes
end type
type st_sel_marca from statictext within w_reporte_balance_de_prueba
end type
type ddlb_1 from dropdownlistbox within w_reporte_balance_de_prueba
end type
type cb_consultar from commandbutton within w_reporte_balance_de_prueba
end type
type cb_2 from commandbutton within w_reporte_balance_de_prueba
end type
type cbx_1 from checkbox within w_reporte_balance_de_prueba
end type
type cb_1 from commandbutton within w_reporte_balance_de_prueba
end type
type em_ann from editmask within w_reporte_balance_de_prueba
end type
type st_1 from statictext within w_reporte_balance_de_prueba
end type
type ddlb_mes from dropdownlistbox within w_reporte_balance_de_prueba
end type
type cb_cierre from commandbutton within w_reporte_balance_de_prueba
end type
type dw_2 from datawindow within w_reporte_balance_de_prueba
end type
end forward

global type w_reporte_balance_de_prueba from w_fa_padre_reportes
integer width = 3904
integer height = 2680
string title = "Balance de Prueba"
boolean minbox = false
boolean maxbox = false
long backcolor = 12639424
st_sel_marca st_sel_marca
ddlb_1 ddlb_1
cb_consultar cb_consultar
cb_2 cb_2
cbx_1 cbx_1
cb_1 cb_1
em_ann em_ann
st_1 st_1
ddlb_mes ddlb_mes
cb_cierre cb_cierre
dw_2 dw_2
end type
global w_reporte_balance_de_prueba w_reporte_balance_de_prueba

type variables
str_fa_ventafact str_informe
datawindowchild idwc_cuenta, idwc_cuenta2, idwc_plan, idwc_barco
integer ii_banco, ii_mes, ii_ann, ii_ann_actual, ii_mes_actual
string is_cuenta

end variables

on w_reporte_balance_de_prueba.create
int iCurrent
call super::create
this.st_sel_marca=create st_sel_marca
this.ddlb_1=create ddlb_1
this.cb_consultar=create cb_consultar
this.cb_2=create cb_2
this.cbx_1=create cbx_1
this.cb_1=create cb_1
this.em_ann=create em_ann
this.st_1=create st_1
this.ddlb_mes=create ddlb_mes
this.cb_cierre=create cb_cierre
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_sel_marca
this.Control[iCurrent+2]=this.ddlb_1
this.Control[iCurrent+3]=this.cb_consultar
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cbx_1
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.em_ann
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.ddlb_mes
this.Control[iCurrent+10]=this.cb_cierre
this.Control[iCurrent+11]=this.dw_2
end on

on w_reporte_balance_de_prueba.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_sel_marca)
destroy(this.ddlb_1)
destroy(this.cb_consultar)
destroy(this.cb_2)
destroy(this.cbx_1)
destroy(this.cb_1)
destroy(this.em_ann)
destroy(this.st_1)
destroy(this.ddlb_mes)
destroy(this.cb_cierre)
destroy(this.dw_2)
end on

event ue_post_open;//override
string  ls_dinero, ls_tran, ls_documento, ls_stran, ls_ref, ls_cuenta, ls_masca, ls_empre
Integer li_ann, li_banco
datetime ldt_desde, ldt_hasta
string mes[12] 
mes[1] = 'ENERO'; mes[2] = 'FEBRERO';mes[3] = 'MARZO';mes[4] = 'ABRIL';mes[5] = 'MAYO';mes[6] = 'JUNIO';
mes[7] = 'JULIO';mes[8] = 'AGOSTO';mes[9] = 'SEPTIEMBRE';mes[10] = 'OCTUBRE';mes[11] = 'NOVIEMBRE';mes[12] = 'DICIEMBRE';

dw_2.settransobject(sqlca)

//ldt_desde = datetime(relativedate(date(gf_fecha_serv()), - 30),00:00:00)
ii_ann = year(date(gf_fecha_serv()))
ii_mes = month(date(gf_fecha_serv()))
ldt_desde = datetime(date('01/'+string(ii_mes)+'/'+string(ii_ann)),23:59:59)

em_ann.text   = string(ii_ann)
ddlb_mes.text = mes[ii_mes]

ls_masca = gf_mascara()
//dw_2.MODIFY("cuenta1.editmask.mask='"+ls_masca+"'") //mascara para el compute de la cuenta
idwc_cuenta.MODIFY("mg_cuenta.editmask.mask='"+ls_masca+"'") //cuenta que se graba en el detalle contable
idwc_cuenta2.MODIFY("mg_cuenta.editmask.mask='"+ls_masca+"'") //cuenta que se graba en el detalle contable
dw_1.modify("mayo_cuenta.editmask.mask='"+ls_masca+"'")

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
	// = ii_mes
	// = ii_ann
end if

if ls_cuenta <> '' and not isnull(ls_cuenta) then
	dw_1.settransobject(sqlca)	
	cb_consultar.triggerevent('clicked')
//	if dw_1.retrieve(str.g_financiero, str.empresa, li_banco, ls_cuenta, ldt_desde, ldt_hasta) = 0 then
//		gf_mensaje('','Transaccion no Registrada, Verifique!!!',1,1,'E')
//		return
//	end if		
end if
	  SELECT comparam.para_ann_actual,   
				comparam.para_mes_actual  
		 INTO :ii_ann_actual,   
				:ii_mes_actual  
		 FROM comparam  
		WHERE ( comparam.para_g_financiero = :str.g_financiero ) AND  
				( comparam.para_empresa = :str.empresa )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al buscar periodo contable '+sqlca.sqlerrtext,1,1,'E')
			return
		end if
//Para setear el nombre de la Cia. al DW de impresion.
If dw_1.Describe("nom_empresa.x") <> "?" And dw_1.Describe("nom_empresa.x") <> "!" Then
	ls_empre = gf_dg_nombre_empresa()
	dw_1.object.nom_empresa.expression = "'"+ ls_empre +"'"
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

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_reporte_balance_de_prueba
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_reporte_balance_de_prueba
boolean visible = false
integer x = 32
integer y = 1384
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_reporte_balance_de_prueba
integer x = 41
integer y = 200
integer width = 3749
integer height = 2256
string dataobject = "dw_reporte_balance_resumido"
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

if dw_1.dataobject = 'dw_reporte_balance_detallado' then

	if ls_column = 'mg_descripcion' or ls_column = 'mayo_cuenta' then
		str_cc_formatos str_formato1	
		if dw_1.getitemnumber(row,'mg_nivel') = 1 then return  
		str_formato1.cuenta = dw_1.getitemstring(row,'mayo_cuenta')
		li_mes = ii_mes 
		li_ann = ii_ann 
		gf_fecha_ini_fecha_fin(li_mes, li_ann, ld_desde, ld_hasta)
		ldt_desde = datetime(ld_desde,00:00:00)
		ldt_hasta = datetime(ld_hasta,23:59:59)
	
		str_formato1.fecha1 = ldt_desde
		str_formato1.fecha2 = ldt_hasta
		OpenSheetwithparm(w_reporte_historico_cuentas,str_formato1,parent,2, layered!)
		
	end if
	
else
	if ls_column = 'mg_descripcion' or ls_column = 'mayo_cuenta' then
		str_cc_formatos str_formato2	
		if dw_1.getitemnumber(row,'mg_nivel') <> 1 then return  
		str_formato2.cuenta = dw_1.getitemstring(row,'mayo_cuenta')
		li_mes = ii_mes 
		li_ann = ii_ann
		gf_fecha_ini_fecha_fin(li_mes, li_ann, ld_desde, ld_hasta)
		ldt_desde = datetime(ld_desde,00:00:00)
		
		str_formato2.fecha1 = ldt_desde

		OpenSheetwithparm(w_reporte_auxiliares,str_formato2,parent,2, layered!)
		
	end if
end if
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_reporte_balance_de_prueba
boolean visible = false
integer x = 27
integer y = 192
integer width = 2967
integer height = 1364
long backcolor = 12639424
end type

type st_sel_marca from statictext within w_reporte_balance_de_prueba
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

type ddlb_1 from dropdownlistbox within w_reporte_balance_de_prueba
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

type cb_consultar from commandbutton within w_reporte_balance_de_prueba
integer x = 1394
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

event clicked;string ls_dinero, ls_tran, ls_documento, ls_fecha_text, ls_cuenta1, ls_cuenta2
integer li_ann, li_mes, li_caracteres_nivel1
date ldt_fecha_anterior
decimal{2} ld_saldo_anterior

li_ann = ii_ann
li_mes = ii_mes

if dw_1.retrieve(str.g_financiero, str.empresa, li_ann, li_mes) = 0 then
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

type cb_2 from commandbutton within w_reporte_balance_de_prueba
integer x = 1774
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

type cbx_1 from checkbox within w_reporte_balance_de_prueba
integer x = 2240
integer y = 56
integer width = 485
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Detallado"
end type

event clicked;string ls_masca, ls_empre

if dw_1.dataobject = 'dw_reporte_balance_resumido' then
	dw_1.dataobject = 'dw_reporte_balance_detallado'
	cbx_1.text = 'Resumido'
else
	dw_1.dataobject = 'dw_reporte_balance_resumido'
	cbx_1.text = 'Detallado'	
end if

cbx_1.checked = false

dw_1.settransobject(sqlca)
If dw_1.Describe("nom_empresa.x") <> "?" And dw_1.Describe("nom_empresa.x") <> "!" Then
	ls_empre = gf_dg_nombre_empresa()
	dw_1.object.nom_empresa.expression = "'"+ ls_empre +"'"
End If	
ls_masca = gf_mascara()
dw_1.modify("mayo_cuenta.editmask.mask='"+ls_masca+"'")
cb_consultar.triggerevent('clicked')

dw_1.object.datawindow.print.preview = True
dw_1.object.datawindow.print.preview.zoom = 100
end event

type cb_1 from commandbutton within w_reporte_balance_de_prueba
integer x = 3419
integer y = 32
integer width = 402
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recalcular"
end type

event clicked;	OpenSheet(w_recalcula_mayor_general,str.frame,2,Original!)		
end event

type em_ann from editmask within w_reporte_balance_de_prueba
integer x = 123
integer y = 44
integer width = 261
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
string mask = "###0"
boolean spin = true
double increment = 1
string minmax = "2009~~3000"
end type

event modified;ii_ann = integer(this.text)
integer li_ann
if ddlb_mes.text = 'DICIEMBRE' then ii_mes = 12
if ii_mes = 12 then
	li_ann = ii_ann
	if ii_ann_actual + 1 = li_ann or ii_ann_actual = li_ann then
		cb_cierre.visible = true		
	else
		cb_cierre.visible = false
	end if
else
	cb_cierre.visible = false
end if
end event

type st_1 from statictext within w_reporte_balance_de_prueba
integer x = 407
integer y = 68
integer width = 197
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Mes:"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_mes from dropdownlistbox within w_reporte_balance_de_prueba
integer x = 599
integer y = 52
integer width = 658
integer height = 948
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
boolean sorted = false
string item[] = {"ENERO","FEBRERO","MARZO","ABRIL","MAYO","JUNIO","JULIO","AGOSTO","SEPTIEMBRE","OCTUBRE","NOVIEMBRE","DICIEMBRE","CIERRE"}
end type

event selectionchanged;integer li_ann
ii_mes = index
if ii_mes = 12 then
	li_ann = integer(em_ann.text)
	if ii_ann_actual + 1 = li_ann or ii_ann_actual = li_ann then
		cb_cierre.visible = true		
	else
		cb_cierre.visible = false
	end if
else
	cb_cierre.visible = false
end if
end event

type cb_cierre from commandbutton within w_reporte_balance_de_prueba
boolean visible = false
integer x = 2811
integer y = 32
integer width = 512
integer height = 104
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cierre Nominal"
end type

event clicked;datetime ldt_fecha
time lt_time
integer i, li_total, li_existe
string ls_error, ls_cuenta, ls_naturaleza, ls_cuenta_utilidad, ls_comentario
decimal{2} ld_saldo, ld_balance, ld_monto, ld_saldo_original
sqlca.autocommit = true

if gf_mensaje('','Esta Seguro de Generar el Asiento de Cierre Anual ?',2,1,'E') = 2 then return

SetPointer ( HourGlass! )

dw_2.getchild('ddia_mg_cuenta', idwc_plan)
idwc_plan.settransobject(sqlca)
idwc_plan.retrieve(str.g_financiero, str.empresa)
idwc_plan.insertrow(1)

dw_2.getchild('ddia_transito_1', idwc_barco)
idwc_barco.settransobject(sqlca)
if idwc_barco.retrieve(str.g_financiero, str.empresa) = 0 then
	idwc_barco.insertrow(1)
end if

lt_time = time('00:00:00')
ldt_fecha = datetime(date('31/'+string(ii_mes)+'/'+string(ii_ann)), lt_time)

cb_consultar.triggerevent('clicked')

if cbx_1.text = 'Detallado' then
	cbx_1.triggerevent('clicked')
end if

  SELECT comparam.para_cuenta_utilidad  
    INTO :ls_cuenta_utilidad  
    FROM comparam  
   WHERE ( comparam.para_g_financiero = :str.g_financiero ) AND  
         ( comparam.para_empresa = :str.empresa )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Buscar Cuentas '+sqlca.sqlerrtext,1,1,'E')
			return
		end if

  SELECT count(*)  
    INTO :li_existe  
    FROM cotdiari  
   WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
         ( cotdiari.diar_empresa = :str.empresa ) AND  
         ( cotdiari.diar_aplicacion_mg = 'CO' ) AND  
         ( cotdiari.diar_tipo_transaccion = 'RA' ) AND  
         ( cotdiari.diar_sub_trans = 'RA' ) AND  
         ( cotdiari.diar_no_documento = '1' ) AND  
         ( cotdiari.diar_no_referencia = '1' ) AND  
         ( cotdiari.diar_ann = :ii_ann )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Validar Existencia '+sqlca.sqlerrtext,1,1,'E')
			return
		end if

sqlca.autocommit = false

	if li_existe > 0 then
		
		  DELETE FROM coddiari  
		WHERE ( coddiari.ddia_g_financiero = :str.g_financiero ) AND  
				( coddiari.ddia_empresa = :str.empresa ) AND  
				( coddiari.ddia_aplicacion_mg = 'CO' ) AND  
				( coddiari.ddia_tipo_transaccion = 'RA' ) AND  
				( coddiari.ddia_sub_trans = 'RA' ) AND  
				( coddiari.ddia_no_documento = '1' ) AND  
				( coddiari.ddia_no_referencia = '1' ) AND  
				( coddiari.ddia_ann = :ii_ann )   ;
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					gf_mensaje('','Error al Eliminar Detalle '+ls_error,1,1,'E')
					sqlca.autocommit = true					
					return
				end if
			
			DELETE FROM cotdiari  
			WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
					( cotdiari.diar_empresa = :str.empresa ) AND  
					( cotdiari.diar_aplicacion_mg = 'CO' ) AND  
					( cotdiari.diar_tipo_transaccion = 'RA' ) AND  
					( cotdiari.diar_sub_trans = 'RA' ) AND  
					( cotdiari.diar_no_documento = '1' ) AND  
					( cotdiari.diar_no_referencia = '1' ) AND  
					( cotdiari.diar_ann = :ii_ann )   ;
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					gf_mensaje('','Error al Eliminar Encabezado '+ls_error,1,1,'E')
					sqlca.autocommit = true					
					return
				end if
							
	end if

dw_1.setfilter("dgmplanc_mg_tipo_cuenta = 'D' and integer(mid(mayo_cuenta,1,1)) >= 4 and round(saldo,2) <> 0")
dw_1.filter()

li_total = dw_1.rowcount()
dw_2.reset()

ls_comentario = 'REGISTRO DE CIERRE ANUAL '+string(ii_ann) 

for i = 1 to li_total
	if i = 1 then

	  INSERT INTO cotdiari  
         ( diar_g_financiero,   
           diar_empresa,   
           diar_aplicacion_mg,   
           diar_tipo_transaccion,   
           diar_sub_trans,   
           diar_no_documento,   
           diar_no_referencia,   
           diar_banco_cuenta,   
           diar_ann,   
           diar_fecha_transaccion,   
           diar_descripcion,   
           diar_id,   
           diar_fecha_creacion,   
           diar_estado,   
           diar_monto,   
           diar_balance,   
           diar_modificado,   
           diar_cerrado,   
           diar_cierre_mensual,   
           diar_banco,   
           diar_documento_a,   
           diar_nombre,   
           diar_impreso )  
  VALUES ( :str.g_financiero,   
           :str.empresa,   
           'CO',   
           'RA',   
           'RA',   
           '1',   
           '1',   
           '1',   
           :ii_ann,   
           :ldt_fecha,   
           :ls_comentario,
           'SA',   
           getdate(),   
           'A',   
           0,   
           null,   
           null,   
           'S',   
           'S',   
           null,   
           null,   
           'CIERRE ANUAL',   
           'S' )  ;
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				gf_mensaje('','Error al Insertar Encabezado '+ls_error,1,1,'E')
				sqlca.autocommit = true					
				return
			end if

	end if
	
	ls_cuenta = dw_1.getitemstring(i,'mayo_cuenta')
	ls_naturaleza = dw_1.getitemstring(i,'mg_naturaleza')
	ld_saldo_original = dw_1.getitemnumber(i,'saldo')
	ld_saldo = abs(ld_saldo_original)
//	if mid(ls_cuenta,1,6) = '604010' then
//		ls_cuenta = ls_cuenta
//	end if
	dw_2.insertrow(i)
	if ls_naturaleza = 'D' then 
		if ld_saldo_original < 0 then
			ls_naturaleza = 'D'
			dw_2.setitem(i,'debito',ld_saldo)		
			dw_2.setitem(i,'monto_debito',ld_saldo)			
		else
			ls_naturaleza = 'C'			
			dw_2.setitem(i,'credito',ld_saldo)		
			dw_2.setitem(i,'monto_credito',ld_saldo)			
		end if
	else
		if ld_saldo_original > 0 then
			ls_naturaleza = 'C'
			dw_2.setitem(i,'credito',ld_saldo)		
			dw_2.setitem(i,'monto_credito',ld_saldo)			
		else
			ls_naturaleza = 'D'
			dw_2.setitem(i,'debito',ld_saldo)		
			dw_2.setitem(i,'monto_debito',ld_saldo)			
		end if
	end if
	dw_2.setitem(i,'naturaleza',ls_naturaleza)	
	dw_2.setitem(i,'ddia_fecha', date(gf_fecha_serv()))
	dw_2.setitem(i,'ddia_g_financiero',str.g_financiero)
	dw_2.setitem(i,'ddia_empresa',str.empresa)
	dw_2.setitem(i,'ddia_aplicacion_mg','CO')
	dw_2.setitem(i,'ddia_ann', ii_ann)
	dw_2.setitem(i,'ddia_id', str.usuario)
	dw_2.setitem(i,'ddia_tipo_transaccion', 'RA')
	dw_2.setitem(i,'ddia_sub_trans', 'RA')
	dw_2.setitem(i,'ddia_no_documento', '1')
	dw_2.setitem(i,'ddia_no_referencia', '1')
	dw_2.setitem(i,'naturaleza',ls_naturaleza)	
	dw_2.setitem(i,'ddia_linea',i)
	dw_2.setitem(i,'tipo','I')
	dw_2.setitem(i,'ddia_mg_cuenta',ls_cuenta)
	dw_2.setitem(i,'cuenta',ls_cuenta)	
	dw_2.setitem(i,'ddia_monto',ld_saldo)
		
next

ld_balance = dw_2.getitemnumber(dw_2.rowcount(),'balance')

if ld_balance <> 0 then
	dw_2.insertrow(i)
	if ld_balance < 0 then
		ls_naturaleza = 'C'			
		dw_2.setitem(i,'credito',abs(ld_balance))		
		dw_2.setitem(i,'monto_credito',abs(ld_balance))			
	else
		ls_naturaleza = 'D'		
		dw_2.setitem(i,'debito',ld_balance)		
		dw_2.setitem(i,'monto_debito',ld_balance)			
	end if
	
	dw_2.setitem(i,'naturaleza',ls_naturaleza)
	dw_2.setitem(i,'ddia_fecha', date(gf_fecha_serv()))
	dw_2.setitem(i,'ddia_g_financiero',str.g_financiero)
	dw_2.setitem(i,'ddia_empresa',str.empresa)
	dw_2.setitem(i,'ddia_aplicacion_mg','CO')
	dw_2.setitem(i,'ddia_ann', ii_ann)
	dw_2.setitem(i,'ddia_id', str.usuario)
	dw_2.setitem(i,'ddia_tipo_transaccion', 'RA')
	dw_2.setitem(i,'ddia_sub_trans', 'RA')
	dw_2.setitem(i,'ddia_no_documento', '1')
	dw_2.setitem(i,'ddia_no_referencia', '1')
	dw_2.setitem(i,'naturaleza',ls_naturaleza)	
	dw_2.setitem(i,'ddia_linea',i)
	dw_2.setitem(i,'tipo','I')
	dw_2.setitem(i,'ddia_mg_cuenta',ls_cuenta_utilidad)
	dw_2.setitem(i,'cuenta',ls_cuenta_utilidad)	
	dw_2.setitem(i,'ddia_monto',abs(ld_balance))

end if
if dw_2.update() = -1 then
	ls_error = sqlca.sqlerrtext
	rollback;
	gf_mensaje('','Error al Insertar Detalle '+ls_error,1,1,'E')
	sqlca.autocommit = true					
	return
else
	
		 SELECT sum(case when ddia_naturaleza = 'D' then ddia_monto end)  
			 INTO :ld_monto  
			 FROM coddiari  
			WHERE ( coddiari.ddia_g_financiero = :str.g_financiero ) AND  
					( coddiari.ddia_empresa = :str.empresa ) AND  
					( coddiari.ddia_aplicacion_mg = 'CO' ) AND  
					( coddiari.ddia_tipo_transaccion = 'RA' ) AND  
					( coddiari.ddia_sub_trans = 'RA' ) AND  
					( coddiari.ddia_no_documento = '1' ) AND  
					( coddiari.ddia_no_referencia = '1' ) AND  
					( coddiari.ddia_ann = :ii_ann )   ;
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				gf_mensaje('','Error al Buscar Monto '+ls_error,1,1,'E')
				sqlca.autocommit = true					
				return
			end if
			
			  UPDATE cotdiari  
				  SET diar_monto = :ld_monto  
				WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
						( cotdiari.diar_empresa = :str.empresa ) AND  
						( cotdiari.diar_aplicacion_mg = 'CO' ) AND  
						( cotdiari.diar_tipo_transaccion = 'RA' ) AND  
						( cotdiari.diar_sub_trans = 'RA' ) AND  
						( cotdiari.diar_no_documento = '1' ) AND  
						( cotdiari.diar_no_referencia = '1' ) AND  
						( cotdiari.diar_ann = :ii_ann )   ;
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				gf_mensaje('','Error al Buscar Monto '+ls_error,1,1,'E')
				sqlca.autocommit = true					
				return
			end if
	
	commit;
	
end if
dw_1.setfilter("")
dw_1.filter()
sqlca.autocommit = true

gf_mensaje('','Asiento de Cierre Exitoso !!!',1,1,'E')

cb_1.triggerevent('clicked')
end event

type dw_2 from datawindow within w_reporte_balance_de_prueba
boolean visible = false
integer x = 256
integer y = 528
integer width = 2711
integer height = 1112
integer taborder = 11
boolean bringtotop = true
string title = "none"
string dataobject = "dw_detalle_contable"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

