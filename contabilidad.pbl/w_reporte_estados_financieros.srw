//objectcomments Balance de Pruebas
forward
global type w_reporte_estados_financieros from w_fa_padre_reportes
end type
type st_sel_marca from statictext within w_reporte_estados_financieros
end type
type ddlb_1 from dropdownlistbox within w_reporte_estados_financieros
end type
type cb_consultar from commandbutton within w_reporte_estados_financieros
end type
type cb_2 from commandbutton within w_reporte_estados_financieros
end type
type cbx_1 from checkbox within w_reporte_estados_financieros
end type
type cb_1 from commandbutton within w_reporte_estados_financieros
end type
type dw_3 from datawindow within w_reporte_estados_financieros
end type
type ddlb_tipo from dropdownlistbox within w_reporte_estados_financieros
end type
type em_ann from editmask within w_reporte_estados_financieros
end type
type st_1 from statictext within w_reporte_estados_financieros
end type
type ddlb_mes from dropdownlistbox within w_reporte_estados_financieros
end type
type ddlb_rango from dropdownlistbox within w_reporte_estados_financieros
end type
type cb_cierre_mensual from commandbutton within w_reporte_estados_financieros
end type
type dw_2 from datawindow within w_reporte_estados_financieros
end type
end forward

global type w_reporte_estados_financieros from w_fa_padre_reportes
integer width = 4279
integer height = 2680
string title = "Estados Financieros"
string menuname = "m_hs"
boolean controlmenu = false
boolean minbox = false
long backcolor = 12639424
st_sel_marca st_sel_marca
ddlb_1 ddlb_1
cb_consultar cb_consultar
cb_2 cb_2
cbx_1 cbx_1
cb_1 cb_1
dw_3 dw_3
ddlb_tipo ddlb_tipo
em_ann em_ann
st_1 st_1
ddlb_mes ddlb_mes
ddlb_rango ddlb_rango
cb_cierre_mensual cb_cierre_mensual
dw_2 dw_2
end type
global w_reporte_estados_financieros w_reporte_estados_financieros

type variables
str_fa_ventafact str_informe
datawindowchild idwc_cuenta, idwc_cuenta2
integer ii_banco, ii_contribuyente, ii_ann, ii_mes
string is_cuenta
datastore ids_renta
end variables

on w_reporte_estados_financieros.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.st_sel_marca=create st_sel_marca
this.ddlb_1=create ddlb_1
this.cb_consultar=create cb_consultar
this.cb_2=create cb_2
this.cbx_1=create cbx_1
this.cb_1=create cb_1
this.dw_3=create dw_3
this.ddlb_tipo=create ddlb_tipo
this.em_ann=create em_ann
this.st_1=create st_1
this.ddlb_mes=create ddlb_mes
this.ddlb_rango=create ddlb_rango
this.cb_cierre_mensual=create cb_cierre_mensual
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_sel_marca
this.Control[iCurrent+2]=this.ddlb_1
this.Control[iCurrent+3]=this.cb_consultar
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cbx_1
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.ddlb_tipo
this.Control[iCurrent+9]=this.em_ann
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.ddlb_mes
this.Control[iCurrent+12]=this.ddlb_rango
this.Control[iCurrent+13]=this.cb_cierre_mensual
this.Control[iCurrent+14]=this.dw_2
end on

on w_reporte_estados_financieros.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_sel_marca)
destroy(this.ddlb_1)
destroy(this.cb_consultar)
destroy(this.cb_2)
destroy(this.cbx_1)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.ddlb_tipo)
destroy(this.em_ann)
destroy(this.st_1)
destroy(this.ddlb_mes)
destroy(this.ddlb_rango)
destroy(this.cb_cierre_mensual)
destroy(this.dw_2)
end on

event ue_post_open;//override
string  ls_dinero, ls_tran, ls_documento, ls_stran, ls_ref, ls_cuenta, ls_masca, ls_empre
string mes[12] 
mes[1] = 'ENERO'; mes[2] = 'FEBRERO';mes[3] = 'MARZO';mes[4] = 'ABRIL';mes[5] = 'MAYO';mes[6] = 'JUNIO';
mes[7] = 'JULIO';mes[8] = 'AGOSTO';mes[9] = 'SEPTIEMBRE';mes[10] = 'OCTUBRE';mes[11] = 'NOVIEMBRE';mes[12] = 'DICIEMBRE';
Integer li_ann, li_banco
datetime ldt_desde, ldt_hasta

ddlb_tipo.text = 'Estado de Resultados'

//ldt_desde = datetime(relativedate(date(gf_fecha_serv()), - 30),00:00:00)
ii_ann = year(date(gf_fecha_serv()))
ii_mes = month(date(gf_fecha_serv()))
ldt_desde = datetime(date('01/'+string(ii_mes)+'/'+string(ii_ann)),23:59:59)

em_ann.text   = string(ii_ann)
ddlb_mes.text = mes[ii_mes]

dw_3.settransobject(sqlca)

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
ddlb_rango.text = 'Al'
string ls_mes = ''
gf_mes_de_proceso(ls_mes)
this.title = this.title + ls_mes 
end event

event ue_save_as;//override
integer li_respuesta, i, li_dia, li_mes_anterior
string ls_hasta, ls_path, ls_nombre, ls_cuenta, ls_campo, ls_formato
decimal{2} ld_monto1, ld_monto2, ld_monto3, ld_monto4, ld_monto5, ld_monto6, ld_monto7, ld_monto8, ld_monto9, ld_monto10, ld_monto11, ld_monto12
String	ls_expresion, ls_empre, ls_subtitulo
Integer	li_pos
//ls_title = this.title

li_respuesta = gf_mensaje('','Yes = Salvar a Excel, No = Otro Formato o Cancelar',4,1,'Q')
choose case li_respuesta
	case 1
		ls_path = nv_f.of_browseforfolder("Guardar Excel en ..",true)
		if ddlb_tipo.text = 'Balance de Situacion' then
			dw_2.dataobject = 'dw_save_as_balance_situacion'
			If Len(Trim(ls_path)) > 0 then		
				//Recorre para llenar el datawindow
				dw_2.reset()
				for i = 1 to dw_1.rowcount()
					ls_campo = dw_1.getitemstring(i,'campo')
					choose case ls_campo
						case 'titulo', 'subtitulo', 'total'
							ls_cuenta = dw_1.getitemstring(i,'titulo')
							if ls_campo = 'total' then ls_campo = 'titulo' 
						//case 'subtitulo'
							ls_subtitulo = dw_1.getitemstring(i,'subtitulo')
						case else
							ls_cuenta = dw_1.getitemstring(i,'descripcion')
					end choose
					dw_2.scrolltorow(dw_2.insertrow(0))
			
						ld_monto1 = dw_1.getitemnumber(i,'monto')
						dw_2.setitem(i,'campo',ls_campo)
						dw_2.setitem(i,'cuenta',ls_cuenta)
						dw_2.setitem(i,'monto1',ld_monto1)
				next
				If dw_2.Describe("nom_empresa.x") <> "?" And dw_2.Describe("nom_empresa.x") <> "!" Then
					ls_empre = gf_dg_nombre_empresa()
					dw_2.object.nom_empresa.expression = "'"+ ls_empre +"'"
				End If	
				If dw_2.Describe("ruc.x") <> "?" And dw_2.Describe("ruc.x") <> "!" Then
					dw_2.object.ruc.expression = "'"+ str.ruc+ ' D.V. '+str.dv +"'"	
				End If	
				li_dia = gf_last_day(ii_mes, ii_ann)
				dw_2.object.fecha_titulo.expression = "'" + " Al " +  string(li_dia) + " de " + gf_dg_mes_minusculas(ii_mes) +" de " + string(ii_ann)+"'"
	
				//Setea fecha
				ls_expresion = string(date(gf_fecha_serv()))
				dw_2.object.fecha.expression = "'"+ls_expresion+"'"
				//Setea hora
				ls_expresion = string(gf_fecha_serv(), "dd/mm/yyyy hh:mm AM/PM")
				li_pos = Pos(ls_expresion," ")
				ls_expresion = Right(ls_expresion, Len(ls_expresion) - li_pos)		
				dw_2.object.hora.expression = "'"+ls_expresion+"'"
		
				if cbx_1.text = 'Detallado' then
					ls_formato = 'Resumido'
				else
					ls_formato = 'Detallado'
				end if
				ls_nombre = ddlb_tipo.text+' '+ddlb_mes.text+' '+em_ann.text+' '+ls_formato
				uf_save_dw_as_excel(dw_2,ls_path+'\'+ls_nombre+'.xls')
			End If  //del ls_path > 0
		else //SI ES ESTADO DE RESULTADOS
			if ddlb_rango.text = 'Hasta el' then
				ls_hasta=' Hasta '
				dw_2.dataobject = 'dw_save_as_estado_resultado_meses'
			else
				ls_hasta=''
				dw_2.dataobject = 'dw_save_as_estado_resultado'
			end if
			If Len(Trim(ls_path)) > 0 then		
				//Recorre para llenar el datawindow
				dw_2.reset()
				for i = 1 to dw_1.rowcount()
					ls_campo = dw_1.getitemstring(i,'campo')
					choose case ls_campo
						case 'titulo'
							ls_cuenta = dw_1.getitemstring(i,'titulo')
						case 'subtitulo'
							ls_cuenta = dw_1.getitemstring(i,'subtitulo')
						case else
							ls_cuenta = dw_1.getitemstring(i,'descripcion')
					end choose
					dw_2.scrolltorow(dw_2.insertrow(0))
					if not isnull(ls_cuenta) then
						ld_monto1 = dw_1.getitemnumber(i,'monto1')
						ld_monto2 = dw_1.getitemnumber(i,'monto2')
						ld_monto3 = dw_1.getitemnumber(i,'monto3')	
						dw_2.setitem(i,'campo',ls_campo)
						dw_2.setitem(i,'cuenta',ls_cuenta)
						dw_2.setitem(i,'monto1',ld_monto1)
						dw_2.setitem(i,'monto2',ld_monto2)
						dw_2.setitem(i,'monto3',ld_monto3)			
						if ddlb_rango.text = 'Hasta el' then
							ld_monto4 = dw_1.getitemnumber(i,'monto4')
							ld_monto5 = dw_1.getitemnumber(i,'monto5')
							ld_monto6 = dw_1.getitemnumber(i,'monto6')		
							ld_monto7 = dw_1.getitemnumber(i,'monto7')
							ld_monto8 = dw_1.getitemnumber(i,'monto8')
							ld_monto9 = dw_1.getitemnumber(i,'monto9')		
							ld_monto10 = dw_1.getitemnumber(i,'monto10')
							ld_monto11 = dw_1.getitemnumber(i,'monto11')
							ld_monto12 = dw_1.getitemnumber(i,'monto12')		
							dw_2.setitem(i,'monto4',ld_monto4)
							dw_2.setitem(i,'monto5',ld_monto5)
							dw_2.setitem(i,'monto6',ld_monto6)			
							dw_2.setitem(i,'monto7',ld_monto7)
							dw_2.setitem(i,'monto8',ld_monto8)
							dw_2.setitem(i,'monto9',ld_monto9)			
							dw_2.setitem(i,'monto10',ld_monto10)
							dw_2.setitem(i,'monto11',ld_monto11)
							dw_2.setitem(i,'monto12',ld_monto12)			
						end if 
					end if
				next
				If dw_2.Describe("nom_empresa.x") <> "?" And dw_2.Describe("nom_empresa.x") <> "!" Then
					ls_empre = gf_dg_nombre_empresa()
					dw_2.object.nom_empresa.expression = "'"+ ls_empre +"'"
				End If	
				If dw_2.Describe("ruc.x") <> "?" And dw_2.Describe("ruc.x") <> "!" Then
					dw_2.object.ruc.expression = "'"+ str.ruc+ ' D.V. '+str.dv +"'"	
				End If	
				li_dia = gf_last_day(ii_mes, ii_ann)
				dw_2.object.fecha_titulo.expression = "'" + " Al " +  string(li_dia) + " de " + gf_dg_mes_minusculas(ii_mes) +" de " + string(ii_ann)+"'"
	
				//Setea fecha
				ls_expresion = string(date(gf_fecha_serv()))
				dw_2.object.fecha.expression = "'"+ls_expresion+"'"
				//Setea hora
				ls_expresion = string(gf_fecha_serv(), "dd/mm/yyyy hh:mm AM/PM")
				li_pos = Pos(ls_expresion," ")
				ls_expresion = Right(ls_expresion, Len(ls_expresion) - li_pos)		
				dw_2.object.hora.expression = "'"+ls_expresion+"'"
	
				li_mes_anterior = ii_mes - 1
				if li_mes_anterior = 0 then
					li_mes_anterior = 12
				end if
				dw_2.Object.mes_ant.expression ="'" + gf_dg_mes_minusculas(li_mes_anterior) + "'"
				dw_2.Object.mes_act.expression ="'" + gf_dg_mes_minusculas(ii_mes) + "'"
				
				if cbx_1.text = 'Detallado' then
					ls_formato = 'Resumido'
				else
					ls_formato = 'Detallado'
				end if
				ls_nombre = ddlb_tipo.text+' '+ls_hasta+ddlb_mes.text+' '+em_ann.text+' '+ls_formato
				uf_save_dw_as_excel(dw_2,ls_path+'\'+ls_nombre+'.xls')
			End If  //del ls_path > 0
		end if //Del estado de resultado
	case 2
		dw.saveas()
end choose

end event

event close;Window lw_frame

lw_frame = ParentWindow()

If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_sheet_closed")
 End If
 Close(this)
end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_reporte_estados_financieros
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_reporte_estados_financieros
boolean visible = false
integer x = 32
integer y = 1384
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_reporte_estados_financieros
integer x = 41
integer y = 156
integer width = 3749
integer height = 2292
string dataobject = "dw_reporte_estado_resultados"
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
		li_mes = ii_mes //month(date(dw_2.getitemdatetime(1,'fecha1')))
		li_ann = ii_ann //year(date(dw_2.getitemdatetime(1,'fecha1')))
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
		li_mes = ii_mes //month(date(dw_2.getitemdatetime(1,'fecha1')))
		li_ann = ii_ann //year(date(dw_2.getitemdatetime(1,'fecha1')))
		gf_fecha_ini_fecha_fin(li_mes, li_ann, ld_desde, ld_hasta)
		ldt_desde = datetime(ld_desde,00:00:00)
		
		str_formato2.fecha1 = ldt_desde

		OpenSheetwithparm(w_reporte_auxiliares,str_formato2,parent,2, layered!)
		
	end if
end if
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_reporte_estados_financieros
boolean visible = false
integer x = 27
integer y = 192
integer width = 2967
integer height = 1364
long backcolor = 12639424
end type

type st_sel_marca from statictext within w_reporte_estados_financieros
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

type ddlb_1 from dropdownlistbox within w_reporte_estados_financieros
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

type cb_consultar from commandbutton within w_reporte_estados_financieros
integer x = 2491
integer y = 28
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

event clicked;string ls_dinero, ls_tran, ls_documento, ls_fecha_text, ls_cuenta, ls_cuenta2, ls_grupo, ls_titulo, ls_descripcion, ls_sub_grupo, ls_temp, ls_total, ls_tipo_cuenta, ls_rango
integer i, j, k, li_ann, li_mes, li_caracteres_nivel1, li_linea, li_mes_anterior, li_ann_anterior, li_dia, li_nivel
date ldt_desde, ldt_hasta
date ldt_fecha_anterior
decimal{2} ld_saldo_anterior, ld_saldo, ld_debito, ld_credito, ld_total1_ing = 0, ld_total2_ing = 0, ld_total3_ing = 0, &
			  ld_total1_costo = 0, ld_total2_costo = 0, ld_total3_costo = 0, ld_total1_gasto = 0, ld_total2_gasto = 0, ld_total3_gasto = 0, &
			  ld_porcentaje_renta, ld_total_act, ld_total_pas, ld_total_cap, ld_sub_total, ld_utilidad, &
			  ld_total_ing[13], ld_total_costo[13], ld_total_gasto[13]

ldt_desde = date('01/'+string(ii_mes)+'/'+string(ii_ann))
li_ann = year(ldt_desde)
li_mes = month(ldt_desde)
dw_1.reset()
ls_rango = ddlb_rango.text

if ddlb_tipo.text = 'Balance de Situacion' then
	//Inserta los activos
	ls_grupo  = '1'
	ls_titulo = 'ACTIVOS'
	li_linea = dw_1.insertrow(0)
	dw_1.SetItem(li_linea,"titulo",ls_titulo)
	dw_1.SetItem(li_linea,"campo","titulo")
	dw_1.setitem(li_linea,'tipo_registro','T')	
	
	//busca los saldos del mes solicitado
	ld_sub_total = 0
	ld_total_act = 0
	if dw_3.retrieve(str.g_financiero, str.empresa, li_ann, li_mes, ls_grupo) > 0 then
		ls_sub_grupo = dw_3.getitemstring(1,'asgr_descrip_subgrupo')
		ls_temp		 = ls_sub_grupo
		
		for i = 1 to dw_3.rowcount()
			ls_sub_grupo = dw_3.getitemstring(i,'asgr_descrip_subgrupo')
			if i = 1 then
				li_linea   = dw_1.insertrow(0)	
				dw_1.SetItem(li_linea,"titulo",ls_sub_grupo)
				dw_1.SetItem(li_linea,"campo","subtitulo")
				dw_1.setitem(li_linea,'tipo_registro','T')
				ls_total		 = dw_3.getitemstring(i,'asgr_total_subgrupo')							
			elseif ls_sub_grupo <> ls_temp then
				li_linea   = dw_1.insertrow(0)	
				dw_1.SetItem(li_linea,"titulo",upper(ls_total))
				dw_1.SetItem(li_linea,"campo","total")
				dw_1.setitem(li_linea,"monto",ld_sub_total)
				dw_1.setitem(li_linea,'tipo_registro','T')
				ld_sub_total = 0 
				
				ls_total		= dw_3.getitemstring(i,'asgr_total_subgrupo')							
				ls_temp 		= ls_sub_grupo
				li_linea   = dw_1.insertrow(0)	
				dw_1.SetItem(li_linea,"titulo",ls_sub_grupo)
				dw_1.SetItem(li_linea,"campo","subtitulo")
				dw_1.setitem(li_linea,'tipo_registro','T')
			end if
			li_linea   = dw_1.insertrow(0)	
			ls_cuenta  = dw_3.getitemstring(i, 'mayo_cuenta')
			ls_descripcion  = dw_3.getitemstring(i, 'mg_descripcion')
			ls_tipo_cuenta = dw_3.getitemstring(i, 'dgmplanc_mg_tipo_cuenta')
			li_nivel			= dw_3.getitemnumber(i, 'mg_nivel')			
			
			ld_saldo	  = dw_3.getitemnumber(i, 'saldo')		
			dw_1.setitem(li_linea,'monto', ld_saldo )				
			dw_1.setitem(li_linea,'mg_cuenta', ls_cuenta)
			dw_1.setitem(li_linea,'descripcion', ls_descripcion)
			dw_1.SetItem(li_linea,"campo","activos")		
			dw_1.setitem(li_linea,'tipo_registro','D')
			if cbx_1.text = 'Resumido' then //Si el informe se solicito detallado
				dw_1.setitem(li_linea,'mg_nivel', li_nivel)
				dw_1.setitem(li_linea,'tipo_cuenta', ls_tipo_cuenta)
				if li_nivel = 1 then
					dw_1.SetItem(li_linea,"grupo","ST")
					ld_total_act = ld_total_act + ld_saldo		
					ld_sub_total = ld_sub_total + ld_saldo									
				end if
			else
				ld_total_act = ld_total_act + ld_saldo
				ld_sub_total = ld_sub_total + ld_saldo						
			end if
			
		next
		li_linea   = dw_1.insertrow(0)	
		dw_1.SetItem(li_linea,"titulo",upper(ls_total))
		dw_1.SetItem(li_linea,"campo","total")
		dw_1.setitem(li_linea,"monto",ld_sub_total)
		dw_1.setitem(li_linea,'tipo_registro','T')
		
		li_linea   = dw_1.insertrow(0)	
		dw_1.SetItem(li_linea,"titulo",upper('TOTAL DE ACTIVOS'))
		dw_1.SetItem(li_linea,"grupo","T")
		dw_1.SetItem(li_linea,"campo","titulo")
		dw_1.setitem(li_linea,"monto",ld_total_act)		
		dw_1.setitem(li_linea,'tipo_registro','T')
	end if
	
	li_linea = dw_1.insertrow(0)
	dw_1.setitem(li_linea,'tipo_registro','T')
	
	//Inserta los Pasivos
	ls_grupo  = '2'
	ls_titulo = 'PASIVOS'
	li_linea = dw_1.insertrow(0)
	dw_1.SetItem(li_linea,"titulo",ls_titulo)
	dw_1.SetItem(li_linea,"campo","titulo")
	dw_1.setitem(li_linea,'tipo_registro','T')	
			//busca los saldos del mes solicitado
	ld_sub_total = 0
	ld_total_pas = 0
	if dw_3.retrieve(str.g_financiero, str.empresa, li_ann, li_mes, ls_grupo) > 0 then
		ls_sub_grupo = dw_3.getitemstring(1,'asgr_descrip_subgrupo')
		ls_temp		 = ls_sub_grupo
		
		for i = 1 to dw_3.rowcount()
			ls_sub_grupo = dw_3.getitemstring(i,'asgr_descrip_subgrupo')
			if i = 1 then
				li_linea   = dw_1.insertrow(0)	
				dw_1.SetItem(li_linea,"titulo",ls_sub_grupo)
				dw_1.SetItem(li_linea,"campo","subtitulo")
				dw_1.setitem(li_linea,'tipo_registro','T')
				ls_total		 = dw_3.getitemstring(i,'asgr_total_subgrupo')							
			elseif ls_sub_grupo <> ls_temp then
				li_linea   = dw_1.insertrow(0)	
				dw_1.SetItem(li_linea,"titulo",upper(ls_total))
				dw_1.SetItem(li_linea,"campo","total")
				dw_1.setitem(li_linea,"monto",ld_sub_total)
				dw_1.setitem(li_linea,'tipo_registro','T')
				ld_sub_total = 0 
				
				ls_total		= dw_3.getitemstring(i,'asgr_total_subgrupo')							
				ls_temp 		= ls_sub_grupo
				li_linea   = dw_1.insertrow(0)	
				dw_1.SetItem(li_linea,"titulo",ls_sub_grupo)
				dw_1.SetItem(li_linea,"campo","subtitulo")
			end if
			li_linea   = dw_1.insertrow(0)	
			ls_cuenta  = dw_3.getitemstring(i, 'mayo_cuenta')
			ls_descripcion = dw_3.getitemstring(i, 'mg_descripcion')
			ls_tipo_cuenta = dw_3.getitemstring(i, 'dgmplanc_mg_tipo_cuenta')
			li_nivel			= dw_3.getitemnumber(i, 'mg_nivel')			
			
			ld_saldo	  = dw_3.getitemnumber(i, 'saldo')		
			dw_1.setitem(li_linea,'monto', ld_saldo )
			dw_1.setitem(li_linea,'mg_cuenta', ls_cuenta)
			dw_1.setitem(li_linea,'descripcion', ls_descripcion)
			dw_1.SetItem(li_linea,"campo","pasivos")		
			dw_1.setitem(li_linea,'tipo_registro','D')
			if cbx_1.text = 'Resumido' then //Si el informe se solicito detallado			
				if li_nivel = 1 then
					ld_total_pas = ld_total_pas + ld_saldo			
					ld_sub_total = ld_sub_total + ld_saldo							
					dw_1.SetItem(li_linea,"grupo","ST")
				end if
				dw_1.setitem(li_linea,'mg_nivel', li_nivel)
				dw_1.setitem(li_linea,'tipo_cuenta', ls_tipo_cuenta)
			else
				ld_total_pas = ld_total_pas + ld_saldo
				ld_sub_total = ld_sub_total + ld_saldo						
			end if	
		next
		li_linea   = dw_1.insertrow(0)	
		dw_1.SetItem(li_linea,"titulo",upper(ls_total))
		dw_1.SetItem(li_linea,"campo","total")
		dw_1.setitem(li_linea,"monto",ld_sub_total)
		dw_1.setitem(li_linea,'tipo_registro','T')
		
		li_linea   = dw_1.insertrow(0)	
		dw_1.SetItem(li_linea,"titulo",upper('TOTAL DE PASIVOS'))
		dw_1.SetItem(li_linea,"grupo","T")
		dw_1.SetItem(li_linea,"campo","titulo")
		dw_1.setitem(li_linea,"monto",ld_total_pas)		
		dw_1.setitem(li_linea,'tipo_registro','T')
	end if

	li_linea = dw_1.insertrow(0)
	dw_1.setitem(li_linea,'tipo_registro','T')

	//Inserta Capital
	ls_grupo  = '3'
	ls_titulo = 'CAPITAL'
	li_linea = dw_1.insertrow(0)
	dw_1.SetItem(li_linea,"titulo",ls_titulo)
	dw_1.SetItem(li_linea,"campo","titulo")
	dw_1.setitem(li_linea,'tipo_registro','T')
	//busca los saldos del mes solicitado
	ld_sub_total = 0
	ld_total_cap = 0
	if dw_3.retrieve(str.g_financiero, str.empresa, li_ann, li_mes, ls_grupo) > 0 then
		ls_sub_grupo = dw_3.getitemstring(1,'asgr_descrip_subgrupo')
		ls_temp		 = ls_sub_grupo
		
		for i = 1 to dw_3.rowcount()
			ls_sub_grupo = dw_3.getitemstring(i,'asgr_descrip_subgrupo')
			if i = 1 then
				li_linea   = dw_1.insertrow(0)	
				dw_1.SetItem(li_linea,"titulo",ls_sub_grupo)
				dw_1.SetItem(li_linea,"campo","subtitulo")
				dw_1.setitem(li_linea,'tipo_registro','T')
				ls_total		 = dw_3.getitemstring(i,'asgr_total_subgrupo')							
			elseif ls_sub_grupo <> ls_temp then
				li_linea   = dw_1.insertrow(0)	
				dw_1.SetItem(li_linea,"titulo",upper(ls_total))
				dw_1.SetItem(li_linea,"campo","total")
				dw_1.setitem(li_linea,"monto",ld_sub_total)
				dw_1.setitem(li_linea,'tipo_registro','T')
				ld_sub_total = 0 
				
				ls_total		= dw_3.getitemstring(i,'asgr_total_subgrupo')							
				ls_temp 		= ls_sub_grupo
				li_linea   = dw_1.insertrow(0)	
				dw_1.SetItem(li_linea,"titulo",ls_sub_grupo)
				dw_1.SetItem(li_linea,"campo","subtitulo")
				dw_1.setitem(li_linea,'tipo_registro','T')
			end if
			li_linea   = dw_1.insertrow(0)	
			ls_cuenta  = dw_3.getitemstring(i, 'mayo_cuenta')
			ls_descripcion = dw_3.getitemstring(i, 'mg_descripcion')
			ls_tipo_cuenta = dw_3.getitemstring(i, 'dgmplanc_mg_tipo_cuenta')
			li_nivel			= dw_3.getitemnumber(i, 'mg_nivel')			
			
			ld_saldo	  = dw_3.getitemnumber(i, 'saldo')		
			dw_1.setitem(li_linea,'monto', ld_saldo )
			dw_1.setitem(li_linea,'mg_cuenta', ls_cuenta)
			dw_1.setitem(li_linea,'descripcion', ls_descripcion)
			dw_1.SetItem(li_linea,"campo","capital")		
			dw_1.setitem(li_linea,'tipo_registro','D')
			
			if cbx_1.text = 'Resumido' then //Si el informe se solicito detallado
				dw_1.setitem(li_linea,'mg_nivel', li_nivel)
				dw_1.setitem(li_linea,'tipo_cuenta', ls_tipo_cuenta)
				if li_nivel = 1 then
					ld_total_cap = ld_total_cap + ld_saldo
					ld_sub_total = ld_sub_total + ld_saldo							
					dw_1.SetItem(li_linea,"grupo","ST")
				end if
			else
				ld_total_cap = ld_total_cap + ld_saldo
				ld_sub_total = ld_sub_total + ld_saldo		
			end if
		next
		
		//Linea de ganancia o perdida
		li_linea   = dw_1.insertrow(0)	
		
		  SELECT dgmplanc.mg_cuenta,   
					dgmplanc.mg_descripcion,
					dgmplanc.mg_nivel,
					dgmplanc.mg_tipo_cuenta
			 INTO :ls_cuenta,   
					:ls_descripcion,
					:li_nivel,
					:ls_tipo_cuenta
			 FROM comparam,   
					dgmplanc  
			WHERE ( dgmplanc.mg_g_financiero = comparam.para_g_financiero ) and  
					( dgmplanc.mg_empresa = comparam.para_empresa ) and  
					( dgmplanc.mg_cuenta = comparam.para_cuenta_utilidad ) and  
					( ( comparam.para_g_financiero = :str.g_financiero ) AND  
					( comparam.para_empresa = :str.empresa ) )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al buscar cuenta '+sqlca.sqlerrtext,1,1,'E')
				end if
		dw_1.setitem(li_linea,'mg_cuenta', ls_cuenta)
		dw_1.setitem(li_linea,'descripcion', ls_descripcion)
		dw_1.SetItem(li_linea,"campo","capital")	
		dw_1.setitem(li_linea,'tipo_registro','D')
		if cbx_1.text = 'Resumido' then //Si el informe se solicito detallado
			dw_1.setitem(li_linea,'mg_nivel', li_nivel)
			dw_1.setitem(li_linea,'tipo_cuenta', ls_tipo_cuenta)
		end if
		
		if ld_total_act > (( ld_total_pas + ld_total_cap) * -1 ) then
			ld_utilidad = (ld_total_act - (( ld_total_pas + ld_total_cap) * -1 ) ) * -1 
		else
			ld_utilidad = (( ld_total_pas + ld_total_cap) * -1 ) - ld_total_act
		end if
		dw_1.setitem(li_linea,"monto",ld_utilidad)
		
		ld_sub_total = ld_sub_total + ld_utilidad
		li_linea   = dw_1.insertrow(0)	
		dw_1.SetItem(li_linea,"titulo",upper(ls_total))
		dw_1.SetItem(li_linea,"campo","total")
		dw_1.setitem(li_linea,"monto",ld_sub_total)
		dw_1.setitem(li_linea,'tipo_registro','T')
		
		li_linea   = dw_1.insertrow(0)	
		dw_1.SetItem(li_linea,"titulo",upper('TOTAL DE CAPITAL'))
		dw_1.SetItem(li_linea,"grupo","T")
		dw_1.SetItem(li_linea,"campo","titulo")
		dw_1.setitem(li_linea,'tipo_registro','T')
		
		ld_total_cap = ld_total_cap + ld_utilidad
		dw_1.setitem(li_linea,"monto",ld_total_cap)		
	end if

	li_linea = dw_1.insertrow(0)
	dw_1.setitem(li_linea,'tipo_registro','T')

	li_linea   = dw_1.insertrow(0)	
	dw_1.SetItem(li_linea,"titulo",upper('TOTAL DE PASIVOS Y CAPITAL'))
	dw_1.SetItem(li_linea,"grupo","T")
	dw_1.SetItem(li_linea,"campo","titulo")
	dw_1.setitem(li_linea,"monto",ld_total_pas + ld_total_cap)		
	dw_1.setitem(li_linea,'tipo_registro','T')

	dw_1.setfilter('abs( monto) > 0 or tipo_registro = "T"')
	dw_1.filter()
	
else //Estado de Resultados
	//Inserta los Ingresos
	ls_grupo  = '4'
	ls_titulo = 'INGRESOS'
	li_linea = dw_1.insertrow(0)
	dw_1.SetItem(li_linea,"titulo",ls_titulo)
	dw_1.SetItem(li_linea,"campo","titulo")
	dw_1.setitem(li_linea,'tipo_registro','T')	
	//busca los saldos del mes solicitado
	if ls_rango = 'Hasta el' then
		for j = 1 to li_mes			
			if dw_3.retrieve(str.g_financiero, str.empresa, li_ann, j, ls_grupo) > 0 then
				for i = 1 to dw_3.rowcount()				
					ls_cuenta  = dw_3.getitemstring(i, 'mayo_cuenta')
					if j = 1 then
						li_linea   = dw_1.insertrow(0)	
					else
						li_linea = dw_1.find('mg_cuenta = "'+ls_cuenta+'"',1,dw_1.rowcount())
						if li_linea = 0 then
							li_linea   = dw_1.insertrow(0)
						end if
					end if
					
					ls_tipo_cuenta = dw_3.getitemstring(i, 'dgmplanc_mg_tipo_cuenta')
					li_nivel			= dw_3.getitemnumber(i, 'mg_nivel')			
					dw_1.setitem(li_linea,'tipo_registro','D')			
					ls_descripcion  = dw_3.getitemstring(i, 'mg_descripcion')
					ld_debito  = dw_3.getitemnumber(i, 'debito')	
					ld_credito = dw_3.getitemnumber(i, 'credito')		
					ld_saldo	  = dw_3.getitemnumber(i, 'saldo')		
					dw_1.setitem(li_linea,'monto'+string(j), (ld_debito - ld_credito) * -1 )
//					dw_1.setitem(li_linea,'monto3', ld_saldo * -1)
					dw_1.setitem(li_linea,'mg_cuenta', ls_cuenta)
					dw_1.setitem(li_linea,'mg_nivel', li_nivel)
								
					if cbx_1.text = 'Resumido' then //Si el informe se solicito detallado
						if ls_tipo_cuenta = 'R' then
							dw_1.setitem(li_linea,'subtitulo', ls_descripcion)
							dw_1.SetItem(li_linea,"campo","subtitulo")			
						else
							dw_1.setitem(li_linea,'descripcion', ls_descripcion)
							dw_1.SetItem(li_linea,"campo","ingreso")									
						end if
						if li_nivel = 1 then //Acumula para nivel 1, ya que pueden haber de detalle para nivel 1 y debe sumar
							ld_total2_ing = ld_total2_ing + ((ld_debito - ld_credito) * -1)			
							ld_total_ing[j] = ld_total_ing[j] + ((ld_debito - ld_credito) * -1)
	//						ld_total3_ing = ld_total3_ing + (ld_saldo * -1)		
						end if
						dw_1.setitem(li_linea,'tipo_cuenta', ls_tipo_cuenta)							
					else
						dw_1.setitem(li_linea,'descripcion', ls_descripcion)
						dw_1.SetItem(li_linea,"campo","ingreso")	
						ld_total2_ing = ld_total2_ing + ((ld_debito - ld_credito) * -1)			
						ld_total_ing[j] = ld_total_ing[j] + ((ld_debito - ld_credito) * -1)						
						ld_total3_ing = ld_total3_ing + (ld_saldo * -1)
					end if
				next  //Recorre el datawindow
			end if //del dw_3 > 0
			
		next //Del rango de meses
	else
		if dw_3.retrieve(str.g_financiero, str.empresa, li_ann, li_mes, ls_grupo) > 0 then
			for i = 1 to dw_3.rowcount()
				li_linea   = dw_1.insertrow(0)	
				ls_cuenta  = dw_3.getitemstring(i, 'mayo_cuenta')
				ls_tipo_cuenta = dw_3.getitemstring(i, 'dgmplanc_mg_tipo_cuenta')
				li_nivel			= dw_3.getitemnumber(i, 'mg_nivel')			
				dw_1.setitem(li_linea,'tipo_registro','D')			
				ls_descripcion  = dw_3.getitemstring(i, 'mg_descripcion')
				ld_debito  = dw_3.getitemnumber(i, 'debito')	
				ld_credito = dw_3.getitemnumber(i, 'credito')		
				ld_saldo	  = dw_3.getitemnumber(i, 'saldo')		
				dw_1.setitem(li_linea,'monto2', (ld_debito - ld_credito) * -1 )
				dw_1.setitem(li_linea,'monto3', ld_saldo * -1)
				dw_1.setitem(li_linea,'mg_cuenta', ls_cuenta)
				dw_1.setitem(li_linea,'mg_nivel', li_nivel)
							
				if cbx_1.text = 'Resumido' then //Si el informe se solicito detallado
					if ls_tipo_cuenta = 'R' then
						dw_1.setitem(li_linea,'subtitulo', ls_descripcion)
						dw_1.SetItem(li_linea,"campo","subtitulo")			
					else
						dw_1.setitem(li_linea,'descripcion', ls_descripcion)
						dw_1.SetItem(li_linea,"campo","ingreso")									
					end if
					if li_nivel = 1 then //Acumula para nivel 1, ya que pueden haber de detalle para nivel 1 y debe sumar
						ld_total2_ing = ld_total2_ing + ((ld_debito - ld_credito) * -1)			
						ld_total3_ing = ld_total3_ing + (ld_saldo * -1)		
					end if
					dw_1.setitem(li_linea,'tipo_cuenta', ls_tipo_cuenta)							
				else
					dw_1.setitem(li_linea,'descripcion', ls_descripcion)
					dw_1.SetItem(li_linea,"campo","ingreso")	
					ld_total2_ing = ld_total2_ing + ((ld_debito - ld_credito) * -1)			
					ld_total3_ing = ld_total3_ing + (ld_saldo * -1)
				end if
			next
		end if
		
		
		if ls_rango <> 'Hasta el' then	
			//busca los saldos del mes Anterior
			li_mes_anterior = li_mes - 1
			if li_mes_anterior = 0 then
				li_mes_anterior = 12
				li_ann_anterior = li_ann - 1
			else
				li_ann_anterior = li_ann
			end if
			if dw_3.retrieve(str.g_financiero, str.empresa, li_ann_anterior, li_mes_anterior, ls_grupo) > 0 then
				for i = 1 to dw_3.rowcount()	
					ld_saldo  = dw_3.getitemnumber(i, 'saldo')	
					ls_cuenta = dw_3.getitemstring(i, 'mayo_cuenta')
					li_linea = dw_1.find('mg_cuenta = "'+ls_cuenta+'"',1,dw_1.rowcount())
					if li_linea > 0 then
						dw_1.setitem(li_linea,'monto1', ld_saldo * -1  )
						if dw_1.getitemnumber(li_linea,'mg_nivel') = 1 then
							ld_total1_ing = ld_total1_ing + (ld_saldo * -1)
						end if
					end if
				next
			end if
		end if
	end if //Del rango = 'Al'
	
	//Inserta los totales de los ingresos
	li_linea   = dw_1.insertrow(0)	
	dw_1.SetItem(li_linea,"subtitulo","TOTAL DE INGRESOS")
	dw_1.SetItem(li_linea,"campo","subtitulo")
	dw_1.setitem(li_linea,'tipo_cuenta', ' ')						
	if ls_rango <> 'Hasta el' then		
		dw_1.SetItem(li_linea,"monto1",ld_total1_ing)
		dw_1.SetItem(li_linea,"monto2",ld_total2_ing)
		dw_1.SetItem(li_linea,"monto3",ld_total3_ing)
	else
		for k = 1 to li_mes
			dw_1.SetItem(li_linea,"monto"+string(k),ld_total_ing[k])
		next
	end if
	dw_1.setitem(li_linea,'tipo_registro','T')
	
	//Linea en blanco
	li_linea = dw_1.insertrow(0)	
	dw_1.setitem(li_linea,'tipo_registro','T')
	
	//Inserta los Costos
	ls_grupo  = '5'
	ls_titulo = 'COSTOS'
	li_linea = dw_1.insertrow(0)
	dw_1.SetItem(li_linea,"titulo",ls_titulo)
	dw_1.SetItem(li_linea,"campo","titulo")
	dw_1.setitem(li_linea,'tipo_registro','T')
	
	//busca los saldos del mes solicitado para los costos
	if ls_rango = 'Hasta el' then
		for j = 1 to li_mes						
			if dw_3.retrieve(str.g_financiero, str.empresa, li_ann, j, ls_grupo) > 0 then
				for i = 1 to dw_3.rowcount()
					ls_cuenta  = dw_3.getitemstring(i, 'mayo_cuenta')
					if j = 1 then
						li_linea   = dw_1.insertrow(0)	
					else
						li_linea = dw_1.find('mg_cuenta = "'+ls_cuenta+'"',1,dw_1.rowcount())
						if li_linea = 0 then
							li_linea   = dw_1.insertrow(0)
						end if
					end if					
					ls_tipo_cuenta = dw_3.getitemstring(i, 'dgmplanc_mg_tipo_cuenta')			
					li_nivel			= dw_3.getitemnumber(i, 'mg_nivel')			
					ls_descripcion  = dw_3.getitemstring(i, 'mg_descripcion')
					dw_1.setitem(li_linea,'tipo_registro','D')			
					ld_debito  = dw_3.getitemnumber(i, 'debito')	
					ld_credito = dw_3.getitemnumber(i, 'credito')		
					ld_saldo	  = dw_3.getitemnumber(i, 'saldo')		
					dw_1.setitem(li_linea,'monto'+string(j), ld_debito - ld_credito)
//					dw_1.setitem(li_linea,'monto3', ld_saldo )
					dw_1.setitem(li_linea,'mg_cuenta', ls_cuenta)			
					dw_1.setitem(li_linea,'mg_nivel', li_nivel)
					
					if cbx_1.text = 'Resumido' then //Si el informe se solicito detallado
						if ls_tipo_cuenta = 'R' then
							dw_1.setitem(li_linea,'subtitulo', ls_descripcion)
							dw_1.SetItem(li_linea,"campo","subtitulo")
						else
							dw_1.setitem(li_linea,'descripcion', ls_descripcion)
							dw_1.SetItem(li_linea,"campo","costo")									
						end if
						if li_nivel = 1 then //Acumula para nivel 1, ya que pueden haber de detalle para nivel 1 y debe sumar
							ld_total_costo[j] = ld_total_costo[j] + (ld_debito - ld_credito)
							ld_total2_costo = ld_total2_costo + (ld_debito - ld_credito)
							ld_total3_costo = ld_total3_costo + ld_saldo					
						end if
						
						dw_1.setitem(li_linea,'tipo_cuenta', ls_tipo_cuenta)							
					else
						dw_1.setitem(li_linea,'descripcion', ls_descripcion)
						dw_1.SetItem(li_linea,"campo","costo")	
						ld_total_costo[j] = ld_total_costo[j] + (ld_debito - ld_credito)
						ld_total2_costo = ld_total2_costo + (ld_debito - ld_credito)
						ld_total3_costo = ld_total3_costo + ld_saldo				
					end if
				next
			end if	
		next //Recorre el total del meses
		
	else //Tira los costos para un mes especifico
		if dw_3.retrieve(str.g_financiero, str.empresa, li_ann, li_mes, ls_grupo) > 0 then
			for i = 1 to dw_3.rowcount()
				li_linea   = dw_1.insertrow(0)	
				ls_cuenta  = dw_3.getitemstring(i, 'mayo_cuenta')
				ls_tipo_cuenta = dw_3.getitemstring(i, 'dgmplanc_mg_tipo_cuenta')			
				li_nivel			= dw_3.getitemnumber(i, 'mg_nivel')			
				ls_descripcion  = dw_3.getitemstring(i, 'mg_descripcion')
				dw_1.setitem(li_linea,'tipo_registro','D')			
				ld_debito  = dw_3.getitemnumber(i, 'debito')	
				ld_credito = dw_3.getitemnumber(i, 'credito')		
				ld_saldo	  = dw_3.getitemnumber(i, 'saldo')		
				dw_1.setitem(li_linea,'monto2', ld_debito - ld_credito)
				dw_1.setitem(li_linea,'monto3', ld_saldo )
				dw_1.setitem(li_linea,'mg_cuenta', ls_cuenta)			
				dw_1.setitem(li_linea,'mg_nivel', li_nivel)
				
				if cbx_1.text = 'Resumido' then //Si el informe se solicito detallado
					if ls_tipo_cuenta = 'R' then
						dw_1.setitem(li_linea,'subtitulo', ls_descripcion)
						dw_1.SetItem(li_linea,"campo","subtitulo")
					else
						dw_1.setitem(li_linea,'descripcion', ls_descripcion)
						dw_1.SetItem(li_linea,"campo","costo")									
					end if
					if li_nivel = 1 then //Acumula para nivel 1, ya que pueden haber de detalle para nivel 1 y debe sumar
						ld_total2_costo = ld_total2_costo + (ld_debito - ld_credito)
						ld_total3_costo = ld_total3_costo + ld_saldo					
					end if
					
					dw_1.setitem(li_linea,'tipo_cuenta', ls_tipo_cuenta)							
				else
					dw_1.setitem(li_linea,'descripcion', ls_descripcion)
					dw_1.SetItem(li_linea,"campo","costo")	
					ld_total2_costo = ld_total2_costo + (ld_debito - ld_credito)
					ld_total3_costo = ld_total3_costo + ld_saldo				
				end if
			next
		end if
		
	end if //Del 'Hasta el'	
	
	if ls_rango <> 'Hasta el' then	
		//busca los saldos del mes Anterior
		if dw_3.retrieve(str.g_financiero, str.empresa, li_ann_anterior, li_mes_anterior, ls_grupo) > 0 then
			for i = 1 to dw_3.rowcount()	
				ld_saldo  = dw_3.getitemnumber(i, 'saldo')	
				ls_cuenta = dw_3.getitemstring(i, 'mayo_cuenta')
				li_linea = dw_1.find('mg_cuenta = "'+ls_cuenta+'"',1,dw_1.rowcount())
				if li_linea > 0 then
					dw_1.setitem(li_linea,'monto1', ld_saldo )
					if dw_1.getitemnumber(li_linea,'mg_nivel') = 1 then				
						ld_total1_costo = ld_total1_costo + ld_saldo
					end if
				end if
			next
		end if
	end if
	
	//Inserta los totales de los ingresos
	li_linea   = dw_1.insertrow(0)	
	dw_1.SetItem(li_linea,"subtitulo","TOTAL DE COSTOS")
	dw_1.SetItem(li_linea,"campo","subtitulo")
	dw_1.setitem(li_linea,'tipo_cuenta', ' ')			
	dw_1.setitem(li_linea,'tipo_registro','T')				
	if ls_rango <> 'Hasta el' then	
		dw_1.SetItem(li_linea,"monto1",ld_total1_costo)
		dw_1.SetItem(li_linea,"monto2",ld_total2_costo)
		dw_1.SetItem(li_linea,"monto3",ld_total3_costo)
	else
		for k = 1 to li_mes
			dw_1.SetItem(li_linea,"monto"+string(k),ld_total_costo[k])
		next
	end if
	
	//Linea en blanco
	li_linea = dw_1.insertrow(0)	
	dw_1.setitem(li_linea,'tipo_registro','T')
	
	//Inserta utilidad bruta
	li_linea   = dw_1.insertrow(0)	
	dw_1.SetItem(li_linea,"titulo","UTILIDAD BRUTA EN OPERACIONES")
	dw_1.SetItem(li_linea,"campo","titulo")
	if ls_rango <> 'Hasta el' then	
		dw_1.SetItem(li_linea,"monto1",ld_total1_ing - ld_total1_costo)
		dw_1.SetItem(li_linea,"monto2",ld_total2_ing - ld_total2_costo)
		dw_1.SetItem(li_linea,"monto3",ld_total3_ing - ld_total3_costo)
	else
		for k = 1 to li_mes
			dw_1.SetItem(li_linea,"monto"+string(k),ld_total_ing[k] - ld_total_costo[k])
		next
	end if
	dw_1.setitem(li_linea,'tipo_registro','T')			

	//Linea en blanco
	li_linea = dw_1.insertrow(0)	
	dw_1.setitem(li_linea,'tipo_registro','T')
		
	//Inserta los Gastos
	ls_grupo  = '6'
	ls_titulo = 'GASTOS'
	li_linea = dw_1.insertrow(0)
	dw_1.SetItem(li_linea,"titulo",ls_titulo)
	dw_1.SetItem(li_linea,"campo","titulo")
	dw_1.setitem(li_linea,'tipo_registro','T')			

	//busca los saldos para el rango de meses
	if ls_rango = 'Hasta el' then
		for j = 1 to li_mes			
			if dw_3.retrieve(str.g_financiero, str.empresa, li_ann, j, ls_grupo) > 0 then
				for i = 1 to dw_3.rowcount()
					ls_cuenta  = dw_3.getitemstring(i, 'mayo_cuenta')
					if j = 1 then
						li_linea   = dw_1.insertrow(0)	
					else
						li_linea = dw_1.find('mg_cuenta = "'+ls_cuenta+'"',1,dw_1.rowcount())
						if li_linea = 0 then
							li_linea   = dw_1.insertrow(0)
						end if
					end if										
					ls_tipo_cuenta = dw_3.getitemstring(i, 'dgmplanc_mg_tipo_cuenta')
					li_nivel			= dw_3.getitemnumber(i, 'mg_nivel')
					ls_descripcion  = dw_3.getitemstring(i, 'mg_descripcion')
					dw_1.setitem(li_linea,'tipo_registro','D')						
					ld_debito  = dw_3.getitemnumber(i, 'debito')	
					ld_credito = dw_3.getitemnumber(i, 'credito')		
					ld_saldo	  = dw_3.getitemnumber(i, 'saldo')		
					dw_1.setitem(li_linea,'monto'+string(j), ld_debito - ld_credito)
//					dw_1.setitem(li_linea,'monto3', ld_saldo)
					dw_1.setitem(li_linea,'mg_cuenta', ls_cuenta)
					dw_1.setitem(li_linea,'mg_nivel', li_nivel)
					
					if cbx_1.text = 'Resumido' then //Si el informe se solicito detallado
						if ls_tipo_cuenta = 'R' then
							dw_1.setitem(li_linea,'subtitulo', ls_descripcion)
							dw_1.SetItem(li_linea,"campo","subtitulo")
						else
							dw_1.setitem(li_linea,'descripcion', ls_descripcion)
							dw_1.SetItem(li_linea,"campo","gasto")									
						end if
						if li_nivel = 1 then //Acumula para nivel 1, ya que pueden haber de detalle para nivel 1 y debe sumar
							ld_total_gasto[j] = ld_total_gasto[j] + (ld_debito - ld_credito)						
							ld_total2_gasto = ld_total2_gasto + (ld_debito - ld_credito)			
							ld_total3_gasto = ld_total3_gasto + ld_saldo					
						end if
						dw_1.setitem(li_linea,'tipo_cuenta', ls_tipo_cuenta)							
					else
						dw_1.setitem(li_linea,'descripcion', ls_descripcion)
						dw_1.SetItem(li_linea,"campo","gasto")	
						ld_total_gasto[j] = ld_total_gasto[j] + (ld_debito - ld_credito)						
						ld_total2_gasto = ld_total2_gasto + (ld_debito - ld_credito)			
						ld_total3_gasto = ld_total3_gasto + ld_saldo				
					end if		
				next
			end if
				
		next
	else
		//busca los saldos del mes solicitado
		if dw_3.retrieve(str.g_financiero, str.empresa, li_ann, li_mes, ls_grupo) > 0 then
			for i = 1 to dw_3.rowcount()
				li_linea   = dw_1.insertrow(0)	
				ls_cuenta  = dw_3.getitemstring(i, 'mayo_cuenta')
				ls_tipo_cuenta = dw_3.getitemstring(i, 'dgmplanc_mg_tipo_cuenta')
				li_nivel			= dw_3.getitemnumber(i, 'mg_nivel')
				ls_descripcion  = dw_3.getitemstring(i, 'mg_descripcion')
				dw_1.setitem(li_linea,'tipo_registro','D')						
				ld_debito  = dw_3.getitemnumber(i, 'debito')	
				ld_credito = dw_3.getitemnumber(i, 'credito')		
				ld_saldo	  = dw_3.getitemnumber(i, 'saldo')		
				dw_1.setitem(li_linea,'monto2', ld_debito - ld_credito)
				dw_1.setitem(li_linea,'monto3', ld_saldo)
				dw_1.setitem(li_linea,'mg_cuenta', ls_cuenta)
				dw_1.setitem(li_linea,'mg_nivel', li_nivel)
				
				if cbx_1.text = 'Resumido' then //Si el informe se solicito detallado
					if ls_tipo_cuenta = 'R' then
						dw_1.setitem(li_linea,'subtitulo', ls_descripcion)
						dw_1.SetItem(li_linea,"campo","subtitulo")
					else
						dw_1.setitem(li_linea,'descripcion', ls_descripcion)
						dw_1.SetItem(li_linea,"campo","gasto")									
					end if
					if li_nivel = 1 then //Acumula para nivel 1, ya que pueden haber de detalle para nivel 1 y debe sumar
						ld_total2_gasto = ld_total2_gasto + (ld_debito - ld_credito)			
						ld_total3_gasto = ld_total3_gasto + ld_saldo					
					end if
					dw_1.setitem(li_linea,'tipo_cuenta', ls_tipo_cuenta)							
				else
					dw_1.setitem(li_linea,'descripcion', ls_descripcion)
					dw_1.SetItem(li_linea,"campo","gasto")	
					ld_total2_gasto = ld_total2_gasto + (ld_debito - ld_credito)			
					ld_total3_gasto = ld_total3_gasto + ld_saldo				
				end if		
			next
		end if
	end if //del hasta un mes especifico
	
	if ls_rango <> 'Hasta el' then	
		//busca los saldos del mes Anterior
		if dw_3.retrieve(str.g_financiero, str.empresa, li_ann_anterior, li_mes_anterior, ls_grupo) > 0 then
			for i = 1 to dw_3.rowcount()	
				ld_saldo  = dw_3.getitemnumber(i, 'saldo')	
				ls_cuenta = dw_3.getitemstring(i, 'mayo_cuenta')
				li_linea = dw_1.find('mg_cuenta = "'+ls_cuenta+'"',1,dw_1.rowcount())
				if li_linea > 0 then
					dw_1.setitem(li_linea,'monto1', ld_saldo)
					if dw_1.getitemnumber(li_linea,'mg_nivel') = 1 then				
						ld_total1_gasto = ld_total1_gasto + ld_saldo
					end if
				end if
			next
		end if
	end if
	
	//Inserta los totales de los ingresos
	li_linea   = dw_1.insertrow(0)	
	dw_1.SetItem(li_linea,"subtitulo","TOTAL DE GASTOS")
	dw_1.SetItem(li_linea,"campo","subtitulo")
	dw_1.setitem(li_linea,'tipo_cuenta', ' ')			
	dw_1.setitem(li_linea,'tipo_registro','T')				
	if ls_rango <> 'Hasta el' then	
		dw_1.SetItem(li_linea,"monto1",ld_total1_gasto)
		dw_1.SetItem(li_linea,"monto2",ld_total2_gasto)
		dw_1.SetItem(li_linea,"monto3",ld_total3_gasto)
	else
		for k = 1 to li_mes
			dw_1.SetItem(li_linea,"monto"+string(k),ld_total_gasto[k])
		next
	end if
	//Linea en blanco
	li_linea = dw_1.insertrow(0)	
	dw_1.setitem(li_linea,'tipo_registro','T')
		
	//Inserta utilidad Neta, antes de impuesto
	li_linea   = dw_1.insertrow(0)	
	dw_1.SetItem(li_linea,"titulo","GANANCIA/PERDIDA NETA")
	dw_1.SetItem(li_linea,"campo","titulo")
	dw_1.setitem(li_linea,'tipo_registro','T')			
	
	if ls_rango <> 'Hasta el' then		
		dw_1.SetItem(li_linea,"monto1",ld_total1_ing - ld_total1_costo - ld_total1_gasto )
		dw_1.SetItem(li_linea,"monto2",ld_total2_ing - ld_total2_costo - ld_total2_gasto )
		dw_1.SetItem(li_linea,"monto3",ld_total3_ing - ld_total3_costo - ld_total3_gasto )
	else
		for k = 1 to li_mes
			dw_1.SetItem(li_linea,"monto"+string(k),ld_total_ing[k] - ld_total_costo[k] - ld_total_gasto[k] )
		next		
	end if			
	//Linea en blanco
	li_linea = dw_1.insertrow(0)	
	dw_1.setitem(li_linea,'tipo_registro','T')
	
	
	//Inserta Impuesto Sobre la Renta
	/*********************  CALCULO DEL IMPUESTO SOBRE LA RENTA ********************************
									Especificaciones de contribuyente */
	/*								
	// DataStore para determinar según tipo de contribuyente , ¿ cómo calcular el impuesto ?
	DataStore  lds_contribuyente
	decimal{2} ld_impuesto_base, ld_utilidad_base, ld_impuesto_exed, ld_imp_renta_ant   = 0, ld_imp_renta_act   = 0, ld_imp_renta_saldo = 0, &
				  ld_utilidad_antes1, ld_utilidad_antes2, ld_utilidad_antes3
	
	lds_contribuyente = Create DataStore
	lds_contribuyente.DataObject  = "dw_dd_contribuyente"
	lds_contribuyente.SetTransObject(sqlca)
	
	If lds_contribuyente.Retrieve(ii_contribuyente) = 0 Then lds_contribuyente.InsertRow(0)
	
	ld_impuesto_base =lds_contribuyente.GetItemNumber(lds_contribuyente.GetRow(),"juna_impuesto_base")
	ld_utilidad_base =lds_contribuyente.GetItemNumber(lds_contribuyente.GetRow(),"juna_utilidad_base")
	ld_impuesto_exed =lds_contribuyente.GetItemNumber(lds_contribuyente.GetRow(),"juna_impuesto_excedente")
	
	if IsNull(ld_impuesto_base) Then ld_impuesto_base =0
	if IsNull(ld_utilidad_base) Then ld_utilidad_base =0
	if IsNull(ld_impuesto_exed) Then ld_impuesto_exed =0
	
	// Datastore para calcular el impuesto de los contribuyentes como Persona Natural
	ids_renta = Create DataStore
	ids_renta.DataObject  = "dddw_dg_renta"
	ids_renta.SetTransObject(sqlca)
	ids_renta.Retrieve() //ids_renta
	
	ld_imp_renta_ant   = 0
	ld_imp_renta_act   = 0
	ld_imp_renta_saldo = 0
	
	CHOOSE CASE ii_contribuyente
		CASE 1	//  Jurídico Panamá se calcula en base al 30 % de la utilidad
			
				// Utilidad del mes anterior
				If ld_utilidad_antes1 > 0 Then
					ld_imp_renta_ant =  round(ld_utilidad_antes1*(ld_impuesto_base/100),2)
				End If
				// Utilidad del mes actual
				If ld_utilidad_antes2 > 0 Then
					ld_imp_renta_act =  round(ld_utilidad_antes2*(ld_impuesto_base/100),2)
				End If
				// Utilidad acumulada
				If ld_utilidad_antes3 > 0 Then
					ld_imp_renta_saldo =  round(ld_utilidad_antes3*(ld_impuesto_base/100),2)
				End If
		CASE 2,3	//*  Jurídico Panamá con contr. Nación o Reg. Industrial
					//   se le aplica el 30% hasta utilidad de $500,000.00 y al excedente el 34 %  
	
				// Utilidad del mes anterior
				If ld_utilidad_antes1 <= ld_utilidad_base Then
					If ld_utilidad_antes1 > 0 Then
						ld_imp_renta_ant =  round(ld_utilidad_antes1*(ld_impuesto_base/100),2)
					End If	
				Else
					ld_imp_renta_ant =  round(ld_utilidad_base*(ld_impuesto_base/100),2)+round( (ld_utilidad_antes1 - ld_utilidad_base ) * (ld_impuesto_exed/100),2)
				End If
	
				// Utilidad del mes actual
				If ld_utilidad_antes2 <= ld_utilidad_base Then
					If ld_utilidad_antes2 > 0 Then
						ld_imp_renta_act =  round(ld_utilidad_antes2*(ld_impuesto_base/100),2)
					End If 	
				Else
					ld_imp_renta_act =  round(ld_utilidad_base*(ld_impuesto_base/100),2)+round( (ld_utilidad_antes2 - ld_utilidad_base ) * (ld_impuesto_exed/100),2)
				End If
	
				// Utilidad acumulada
				If ld_utilidad_antes3 <= ld_utilidad_base Then
					If ld_utilidad_antes3 > 0 Then
						ld_imp_renta_saldo =  round(ld_utilidad_antes3*(ld_impuesto_base/100),2)
					End If	
				Else
					ld_imp_renta_saldo =  round(ld_utilidad_base*(ld_impuesto_base/100),2)+round( (ld_utilidad_antes3 - ld_utilidad_base ) * (ld_impuesto_exed/100),2)
				End If
	
				ld_imp_renta_act = ld_imp_renta_saldo - ld_imp_renta_ant
				
				if ld_imp_renta_act < 0 Then ld_imp_renta_act = 0
				
		CASE 4	// Jurídico Zona Libre paga Cero Impuesto
			
		CASE 5,6,7	// Persona natural y Natural Comerciante en base a la tabla de renta dgarenta,
						//   Micro y Mediana Empresa en base a la renta natural hasta los 100,000.00 y
						 //  un 30 % adicional al exedente
	
		//		Utilidad del mes anterior*/
				
							
	//			iF ld_ingresos_mes_ant > 0 Then
	//				wf_renta_natural(ld_imp_renta_ant,   ld_utilidad_antes1,ld_ingresos_mes_ant , ii_contribuyente, ld_utilidad_base, ld_impuesto_base, ld_impuesto_exed)
	//			End If
	//			// Utilidad del mes actual
	//
	//			iF ld_ingresos_mes_act > 0 Then
	//				wf_renta_natural(ld_imp_renta_act,   ld_utilidad_antes2,ld_ingresos_mes_act ,ii_contribuyente, ld_utilidad_base, ld_impuesto_base, ld_impuesto_exed)
	//			End If
	//			// Utilidad acumulada
	//			iF ld_ingresos_saldo > 0 Then
	//				wf_renta_natural(ld_imp_renta_saldo, ld_utilidad_antes3,ld_ingresos_saldo ,ii_contribuyente, ld_utilidad_base, ld_impuesto_base, ld_impuesto_exed)
	//			End If
	END CHOOSE
	
	//
	//If li_linea > 0 then
	//	dw_1.SetItem(li_linea,"monto1",ld_imp_renta_ant)
	//	dw_1.SetItem(li_linea,"monto2",ld_imp_renta_act)
	//	dw_1.SetItem(li_linea,"monto3",ld_imp_renta_saldo)
	//End If
	
	
	li_linea   = dw_1.insertrow(0)	
	dw_1.SetItem(li_linea,"titulo","IMPUESTO SOBRE LA RENTA")
	dw_1.SetItem(li_linea,"campo","titulo")
	dw_1.SetItem(li_linea,"monto1",(ld_total1_ing - ld_total1_costo - ld_total1_gasto) * ld_porcentaje_renta )
	dw_1.SetItem(li_linea,"monto2",(ld_total2_ing - ld_total2_costo - ld_total2_gasto) * ld_porcentaje_renta )
	dw_1.SetItem(li_linea,"monto3",(ld_total3_ing - ld_total3_costo - ld_total3_gasto) * ld_porcentaje_renta )
	
	*/

	if ls_rango <> 'Hasta el' then		
		dw_1.setfilter('abs( monto1 )+abs( monto2 )+abs( monto3 ) > 0 or tipo_registro = "T"')
	else
		dw_1.setfilter('abs( monto1 )+abs( monto2 )+abs( monto3 )+abs( monto4 )+abs( monto5 )+abs( monto6 )+abs( monto7 )+abs( monto8 )+abs( monto9 )+abs( monto10 )+abs( monto11 )+abs( monto12 ) > 0 or tipo_registro = "T"')
	end if
	dw_1.filter()

	dw_1.Object.mes_ant.expression ="'" + gf_dg_mes_minusculas(li_mes_anterior) + "'"
	dw_1.Object.mes_act.expression ="'" + gf_dg_mes_minusculas(li_mes) + "'"

end if

li_dia = gf_last_day(li_mes, li_ann)
dw_1.object.fecha_titulo.expression = "'" + " Al " +  string(li_dia) + " de " + gf_dg_mes_minusculas(li_mes) +" de " + string(li_ann)+"'"

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

//Para setear el nombre de la Cia. al DW de impresion.
string ls_empre
If dw_1.Describe("nom_empresa.x") <> "?" And dw_1.Describe("nom_empresa.x") <> "!" Then
	ls_empre = gf_dg_nombre_empresa()
	dw_1.object.nom_empresa.expression = "'"+ ls_empre +"'"
End If	
If dw_1.Describe("ruc.x") <> "?" And dw_1.Describe("ruc.x") <> "!" Then
	dw_1.object.ruc.expression = "'"+ str.ruc+ ' D.V. '+str.dv +"'"	
End If	
dw_1.object.datawindow.print.preview = True
dw_1.object.datawindow.print.preview.zoom = 100
dw_1.setfocus()
end event

type cb_2 from commandbutton within w_reporte_estados_financieros
integer x = 2871
integer y = 28
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

type cbx_1 from checkbox within w_reporte_estados_financieros
integer x = 3319
integer y = 48
integer width = 361
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

//if ddlb_tipo.text = 'Estado de Resultados' then
	if dw_3.dataobject = 'dw_saldos_resumidos_por_grupo' then
	//if dw_1.dataobject = 'dw_reporte_estado_resultados' then
	//	dw_1.dataobject = 'dw_reporte_estado_resultados_det'
		dw_3.dataobject = 'dw_saldos_detallados_por_grupo'
		cbx_1.text = 'Resumido'
	else
	//	dw_1.dataobject = 'dw_reporte_estado_resultados'
		dw_3.dataobject = 'dw_saldos_resumidos_por_grupo'		
		cbx_1.text = 'Detallado'	
	end if
//else
//	if dw_1.dataobject = 'dw_reporte_balance_situacion' then
//	//	dw_1.dataobject = 'dw_reporte_balance_situacion_det'
//		dw_3.dataobject = 'dw_saldos_detallados_por_grupo'
//		cbx_1.text = 'Resumido'
//	else
//	//	dw_1.dataobject = 'dw_reporte_balance_situacion'
//		dw_3.dataobject = 'dw_saldos_resumidos_por_grupo'		
//		cbx_1.text = 'Detallado'	
//	end if
//end if

cbx_1.checked = false

dw_1.settransobject(sqlca)
dw_3.settransobject(sqlca)

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

type cb_1 from commandbutton within w_reporte_estados_financieros
boolean visible = false
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

type dw_3 from datawindow within w_reporte_estados_financieros
boolean visible = false
integer x = 677
integer y = 1124
integer width = 2240
integer height = 780
integer taborder = 11
boolean bringtotop = true
string title = "none"
string dataobject = "dw_saldos_resumidos_por_grupo"
boolean border = false
boolean livescroll = true
end type

type ddlb_tipo from dropdownlistbox within w_reporte_estados_financieros
integer x = 41
integer y = 36
integer width = 933
integer height = 376
integer taborder = 40
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
string item[] = {"Estado de Resultados","Balance de Situacion"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if index = 1 then
	if ddlb_rango.text = 'Al' then
		dw_1.dataobject = 'dw_reporte_estado_resultados'
	else
		dw_1.dataobject = 'dw_reporte_estado_resultados_rango'
	end if
else
	dw_1.dataobject = 'dw_reporte_balance_situacion'
end if

dw_1.settransobject(sqlca)
//Para setear el nombre de la Cia. al DW de impresion.
string ls_empre
If dw_1.Describe("nom_empresa.x") <> "?" And dw_1.Describe("nom_empresa.x") <> "!" Then
	ls_empre = gf_dg_nombre_empresa()
	dw_1.object.nom_empresa.expression = "'"+ ls_empre +"'"
End If	

end event

type em_ann from editmask within w_reporte_estados_financieros
integer x = 983
integer y = 36
integer width = 247
integer height = 88
integer taborder = 50
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
string minmax = "2010~~4000"
end type

event modified;ii_ann = integer(this.text)
end event

type st_1 from statictext within w_reporte_estados_financieros
integer x = 1577
integer y = 56
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

type ddlb_mes from dropdownlistbox within w_reporte_estados_financieros
integer x = 1787
integer y = 36
integer width = 658
integer height = 836
integer taborder = 11
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
string item[] = {"ENERO","FEBRERO","MARZO","ABRIL","MAYO","JUNIO","JULIO","AGOSTO","SEPTIEMBRE","OCTUBRE","NOVIEMBRE","DICIEMBRE"}
end type

event selectionchanged;ii_mes = index
end event

type ddlb_rango from dropdownlistbox within w_reporte_estados_financieros
integer x = 1257
integer y = 36
integer width = 325
integer height = 352
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
string item[] = {"Al","Hasta el"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if ddlb_tipo.text = 'Estado de Resultados' then
	if ddlb_rango.text = 'Al' then
		dw_1.dataobject = 'dw_reporte_estado_resultados'
	else
		dw_1.dataobject = 'dw_reporte_estado_resultados_rango'
	end if
end if
end event

type cb_cierre_mensual from commandbutton within w_reporte_estados_financieros
integer x = 3767
integer y = 32
integer width = 192
integer height = 104
integer taborder = 21
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "CM"
end type

event clicked;OpenSheet(w_cierre_mensual,parent,2, Original!)

end event

type dw_2 from datawindow within w_reporte_estados_financieros
boolean visible = false
integer x = 1143
integer y = 492
integer width = 2811
integer height = 1536
integer taborder = 11
boolean bringtotop = true
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

