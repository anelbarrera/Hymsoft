forward
global type w_ba_genera_pago_a_tercero from w_fa_padre
end type
type cbx_rellena_concepto11 from checkbox within w_ba_genera_pago_a_tercero
end type
type cbx_rellena_concepto10 from checkbox within w_ba_genera_pago_a_tercero
end type
type dw_5 from datawindow within w_ba_genera_pago_a_tercero
end type
type dw_4 from datawindow within w_ba_genera_pago_a_tercero
end type
type dw_3 from datawindow within w_ba_genera_pago_a_tercero
end type
type dw_2 from datawindow within w_ba_genera_pago_a_tercero
end type
type em_ann from editmask within w_ba_genera_pago_a_tercero
end type
type st_5 from statictext within w_ba_genera_pago_a_tercero
end type
type st_3 from statictext within w_ba_genera_pago_a_tercero
end type
type st_2 from statictext within w_ba_genera_pago_a_tercero
end type
type st_1 from statictext within w_ba_genera_pago_a_tercero
end type
type ddlb_meses from dropdownlistbox within w_ba_genera_pago_a_tercero
end type
type cb_1 from commandbutton within w_ba_genera_pago_a_tercero
end type
end forward

global type w_ba_genera_pago_a_tercero from w_fa_padre
integer width = 4791
integer height = 1924
string title = "Reporte de pago a terceros"
string menuname = "m_fa_rep"
event ue_generar_pago ( )
event ue_imprimir ( )
cbx_rellena_concepto11 cbx_rellena_concepto11
cbx_rellena_concepto10 cbx_rellena_concepto10
dw_5 dw_5
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
em_ann em_ann
st_5 st_5
st_3 st_3
st_2 st_2
st_1 st_1
ddlb_meses ddlb_meses
cb_1 cb_1
end type
global w_ba_genera_pago_a_tercero w_ba_genera_pago_a_tercero

type variables
int ii_mes_seleccionado
long il_ann
string is_nombre_archivo,is_ruta_grabar
end variables

event ue_generar_pago();long ll_registros,li_ficha,li_rollo,li_imagen,li_2,li_cantidad_registros,ll_row,ll_cantidad_pagos_total
long ll_cantidad_reg_c11,ll_row5
integer li_FileNum,li,li_largo_fecha_factura,li_pos
string ls_concepto_pago,ls_digito,ls_ruc,ls_tipo_persona,ls_nombre_beneficiario,ls_numero_fact, ls_itbm_c11
string ls_ruta_archivo, ls_ficha,ls_rollo,ls_imagen, ls_ruc_union, ls_ann, ls_periodo_informado, ls_itbm, ls_itbm11
string ls_fecha_factura,ls_monto,ls_cadena,ls_cantidad_pagos_total,ls_monto_total
string ls_mg,ls_numero_factura, ls_nombre_empresa_origen
decimal{2} ldec_monto,ldec_itbm, ldec_total,ldec_monto_concep_10,ldec_monto_concep_11,ldec_monto_agrup, ldec_itbm_agrup, ldec_itbm_concep_10, ldec_itbm_concep_11
datetime ldt_fecha_factura,ldt_fecha_orden
integer i,li_rowdw_4
string ls_concepto_pago_c11,ls_digito_c11,ls_ruc_c11,ls_tipo_persona_c11,ls_numero_fact_c11
string ls_nombre_beneficiario_c11, ls_monto_c11, ls_fecha_factura_c11,ls_cadena_c11
string ls_con_espacios,ls_dv_empresa

if MessageBox('Mensaje','Est? seguro de generar el Reporte de pago a terceros autom?ticamente.',question!,yesno!,1) = 2 then return
dw_1.reset()
dw_2.reset()
dw_3.reset()
dw_4.reset()
dw_5.reset()
if ii_mes_seleccionado < 1 then
	MessageBox('Mensaje','Debe seleccionar un mes para el que desea generar el archivo.')
	Return
end if
em_ann.GetData(ls_ann)
il_ann = long(ls_ann)

if il_ann < 2000 then
	MessageBox('Mensaje','Debe seleccionar el a?o para el que desea generar el archivo.')
	Return
end if

ls_periodo_informado = string(ii_mes_seleccionado)+string(il_ann)
ls_periodo_informado = fill('0',6 - len(ls_periodo_informado )) + ls_periodo_informado 

SELECT para_pagos_con_espacios INTO :ls_con_espacios  
FROM baaparam  
WHERE ( para_g_financiero = :str.g_financiero ) AND ( para_empresa = :str.empresa )   ;

if sqlca.sqlcode = -1 then
	ls_mg = sqlca.sqlerrtext
	rollback;
	messagebox('Error',ls_mg)
end if

dw_1.Retrieve(str.g_financiero,str.empresa)
dw_1.SetItem(1,'periodo_informado',(string(ii_mes_seleccionado,'00')+string(il_ann,'0000')))
ls_nombre_empresa_origen = dw_1.GetitemString(1,'empr_razon_social')

SELECT empr_ficha,empr_rollo,empr_imagen,empr_dijito_verificador  
INTO :li_ficha,:li_rollo,:li_imagen,:ls_dv_empresa FROM dgmempre  
WHERE ( empr_g_financiero = :str.g_financiero ) AND ( empr_empresa = :str.empresa )   ;
if sqlca.sqlcode = -1 then
	ls_mg = sqlca.sqlerrtext
	rollback;
	messagebox('Error',ls_mg)
end if

ls_ficha = trim(string(li_ficha))
ls_rollo = trim(string(li_rollo))
ls_imagen = trim(string(li_imagen))

ls_ruc_union = ls_ficha+ls_rollo+ls_imagen 
is_nombre_archivo = 'PAT'+ls_periodo_informado +ls_ruc_union
ls_ruta_archivo = is_ruta_grabar+is_nombre_archivo+'.txt'
ll_cantidad_pagos_total = 0
ll_registros = dw_3.Retrieve(str.g_financiero,str.empresa,ii_mes_seleccionado,il_ann)

for i = 1 to dw_3.rowcount()
	yield()
	str.frame.setmicrohelp('Procesando '+string(i)+' de '+string(dw_3.rowcount()))
	ls_concepto_pago = left(dw_3.getitemstring(i,'bampgoter_bamp_concepto_pago'),2)
	ls_ruc = trim(dw_3.getitemstring(i,'bampgoter_bamp_ruc'))
	ls_digito = dw_3.getitemstring(i,'bampgoter_bamp_digito')	
	if isnull(ls_digito) then ls_digito = '00'
	ls_tipo_persona = dw_3.getitemstring(i,'tipo_persona1')
	ls_nombre_beneficiario = dw_3.getitemstring(i,'a_nombre_de')
	ldec_monto = dw_3.getitemnumber(i,'monto_factura')
	
	ldec_monto = truncate(ldec_monto,0) //Para que no acumule los decimales	5/4/2001
	
	ls_numero_factura = dw_3.getitemstring(i,'numero_factura')
	ldt_fecha_factura = dw_3.getitemdatetime(i,'fecha_factura')
	ldt_fecha_orden = dw_3.getitemdatetime(i,'fecha_orden')
	ldec_monto_agrup = dw_3.getitemnumber(i,'monto_agrupado')
	ldec_itbm_agrup = dw_3.getitemnumber(i,'itbm_agrupado')
	
//	ldec_monto_agrup = truncate(ldec_monto_agrup,0) //Para que no acumule los decimales 5/4/2001
	
	li_cantidad_registros = dw_3.getitemnumber(i,'cantidad_registros')

	li_rowdw_4 = dw_4.insertrow(0)
	
	dw_4.setitem(li_rowdw_4,'bapa_g_financiero',str.g_financiero)
	dw_4.setitem(li_rowdw_4,'bapa_empresa',str.empresa)
	dw_4.setitem(li_rowdw_4,'bapa_secuencia',li_rowdw_4)
	dw_4.setitem(li_rowdw_4,'bapa_concepto_pago',ls_concepto_pago)
	dw_4.setitem(li_rowdw_4,'bapa_ruc',ls_ruc)
	dw_4.setitem(li_rowdw_4,'bapa_digito_verificador',ls_digito)
	dw_4.setitem(li_rowdw_4,'bapa_tipo_persona',ls_tipo_persona)
	dw_4.setitem(li_rowdw_4,'bapa_a_nombre_de',ls_nombre_beneficiario)
	dw_4.setitem(li_rowdw_4,'bapa_monto_factura',ldec_monto)
	dw_4.setitem(li_rowdw_4,'bapa_numero_factura',ls_numero_factura)
	dw_4.setitem(li_rowdw_4,'bapa_fecha_factura',ldt_fecha_factura)
	dw_4.setitem(li_rowdw_4,'bapa_fecha_orden',ldt_fecha_orden)
	dw_4.setitem(li_rowdw_4,'bapa_monto_agrupado',ldec_monto_agrup)
	dw_4.setitem(li_rowdw_4,'bapa_itbm',ldec_itbm_agrup)
	dw_4.setitem(li_rowdw_4,'bapa_cantidad_registros',integer(li_cantidad_registros))

next

if dw_4.update() = -1 then
	Rollback;
	MessageBox('Mensaje','NO se pudo guardar la informaci?n en bapagos.')
	return
else
	Commit;
end if

ll_registros = dw_4.Retrieve(str.g_financiero,str.empresa)

if ll_registros = 0 then
	MessageBox('Mensaje','No hay registros para generar el archivo para el mes seleccionado.  Verifique.')
	Rollback;
	Return
end if

//Verifica si el archivo ya existe.
if FileExists(ls_ruta_archivo) = true then
	if messagebox('Mensaje','El archivo '+ls_ruta_archivo+' ya existe.  Desea reemplazarlo.',question!,yesno!,1) = 2 then return
	if FileDelete(ls_ruta_archivo) = false then return
end if
/////////////////////////////////////////////////////////////////////////////
// Suma la cantidad de total de registros tipo 2 y suma los montos de pago //
// de todos los registros tipo 2 que ser?na reportados.                    //
/////////////////////////////////////////////////////////////////////////////
for li = 1 to ll_registros
	yield()
	str.frame.setmicrohelp('Procesando '+string(i)+' de '+string(ll_registros))
	ls_concepto_pago = left(dw_4.getitemstring(li,'bapa_concepto_pago'),2)
	ls_digito = dw_4.getitemstring(li,'bapa_digito_verificador')
	ls_digito = Fill('0',2 - len(ls_digito))+ls_digito
	ls_ruc = dw_4.getitemstring(li,'bapa_ruc')
	
	ls_ruc = fill(' ',20 - len(ls_ruc)) + ls_ruc
	ls_tipo_persona = dw_4.getitemstring(li,'bapa_tipo_persona')
	if isnull(ls_tipo_persona) then
		ls_tipo_persona = '1'
	end if
	ls_nombre_beneficiario = dw_4.getitemstring(li,'bapa_a_nombre_de')
	if len(ls_nombre_beneficiario) < 21 then
		ls_nombre_beneficiario = ls_nombre_beneficiario + fill(' ',60 - len(ls_nombre_beneficiario))
	end if
	ldec_monto = dw_4.getitemnumber(li,'bapa_monto_agrupado')
	ldec_itbm = dw_4.getitemnumber(li,'bapa_itbm')
	
//	ldec_monto = truncate(ldec_monto,0) //Para que no acumule los decimales 5/4/2001
	
	li_cantidad_registros = dw_4.getitemnumber(li,'bapa_cantidad_registros')
	
	if li_cantidad_registros > 1 then
		ls_numero_fact = dw_4.getitemstring(li,'bapa_numero_factura')
		ls_numero_fact = ls_numero_fact + fill(' ',20 - len(ls_numero_fact))
		ldt_fecha_factura = dw_4.getitemdatetime(li,'bapa_fecha_factura')
		if isnull(ldt_fecha_factura) then
			ls_fecha_factura = fill(' ',8)
		else
			ls_fecha_factura = string(date(ldt_fecha_factura))
			li_largo_fecha_factura = len(ls_fecha_factura)
			for li_2 = 1 to li_largo_fecha_factura
				li_2 = pos(ls_fecha_factura,'/',li_2)
				if li_2 = 0 then exit
				ls_fecha_factura = Replace(ls_fecha_factura,li_2,1,'')
				li_largo_fecha_factura = len(ls_fecha_factura)
			next			
		end if
	else
		ls_numero_fact = trim(dw_4.getitemstring(li,'bapa_numero_factura'))
		ls_numero_fact = fill(' ',20 - len(ls_numero_fact))+ls_numero_fact
		ldt_fecha_factura = dw_4.getitemdatetime(li,'bapa_fecha_factura')
		if isnull(ldt_fecha_factura) then
			ls_fecha_factura = fill(' ',8)
		else
			ls_fecha_factura = string(date(ldt_fecha_factura))
			li_largo_fecha_factura = len(ls_fecha_factura)
			for li_2 = 1 to li_largo_fecha_factura
				li_2 = pos(ls_fecha_factura,'/',li_2)
				if li_2 = 0 then exit
				ls_fecha_factura = Replace(ls_fecha_factura,li_2,1,'')
				li_largo_fecha_factura = len(ls_fecha_factura)
			next			
		end if
	end if
	
	ls_monto = string(ldec_monto)
//	li_pos = pos(ls_monto,'.',1)
//	ls_monto = mid(ls_monto,1,li_pos - 1)
	ls_monto = Fill(' ',13 - len(ls_monto))+ ls_monto

	ls_itbm = string(ldec_itbm)
//	li_pos = pos(ls_itbm,'.',1)
//	ls_itbm = mid(ls_itbm,1,li_pos - 1)
	ls_itbm = Fill(' ',13 - len(ls_itbm))+ ls_itbm

	if ls_concepto_pago = '6' then
		ldec_monto_concep_10 += ldec_monto
		ldec_itbm_concep_10 += ldec_itbm
	else
		if ldec_monto < 50 or ls_concepto_pago = '7' then
			ldec_monto_concep_11 += ldec_monto
			ldec_itbm_concep_11 += ldec_itbm
		else
			ll_cantidad_pagos_total += 1
		end if
	end if
	
	ldec_total += ldec_monto
	
next

if ldec_monto_concep_10 > 0 then
	ll_cantidad_pagos_total += 1
end if

if ldec_monto_concep_11 > 0 then
	ll_cantidad_pagos_total += 1
end if

ls_monto_total = string(ldec_total)
li_pos = pos(ls_monto_total,'.',1)
ls_monto_total = mid(ls_monto_total,1,li_pos - 1)
ls_monto_total = Fill(' ',20 - len(ls_monto_total))+ ls_monto_total

ls_cantidad_pagos_total = fill(' ',10 - len(string(ll_cantidad_pagos_total)))+string(ll_cantidad_pagos_total)

ls_nombre_empresa_origen = trim(ls_nombre_empresa_origen) + fill(' ', 60 - len(trim(ls_nombre_empresa_origen)))
dw_1.Setitem(1,'empr_razon_social',trim(ls_nombre_empresa_origen))
dw_1.SetItem(1,'total_registros',trim(ls_cantidad_pagos_total))
dw_1.SetItem(1,'monto_total',trim(ls_monto_total))

if dw_1.SaveAs(ls_ruta_archivo,text!,false) <> 1 then
	MessageBox('Mensaje','Hubo un error al guardar el archivo.'+'~n'+&
	'Tal vez la ruta especificada no es la correcta.  Verifique.')
	Return
end if

li_FileNum = FileOpen(ls_ruta_archivo, LineMode!, Write!, LockWrite! )

if li_FileNum = -1 then
	messagebox('Mensaje','Hubo un error al generar el archivo.')
	return
end if
//***************************************************************************
//**
//***************************************************************************
ldec_monto_concep_10 = 0; ldec_monto_concep_11 = 0; ll_cantidad_reg_c11 = 0

for li = 1 to ll_registros
	yield()
	str.frame.setmicrohelp('Procesando '+string(i)+' de '+string(ll_registros))
	
	ls_concepto_pago = left(dw_4.getitemstring(li,'bapa_concepto_pago'),2)
	ls_digito = dw_4.getitemstring(li,'bapa_digito_verificador')
	if isnull(ls_digito) then ls_digito = ''
	ls_digito = Fill('0',2 - len(ls_digito))+ls_digito
	ls_ruc = dw_4.getitemstring(li,'bapa_ruc')
				
	ls_ruc = fill(' ',20 - len(ls_ruc)) + ls_ruc
	ls_tipo_persona = dw_4.getitemstring(li,'bapa_tipo_persona')
	if isnull(ls_tipo_persona) then
		ls_tipo_persona = '1'
	end if
	ls_nombre_beneficiario = dw_4.getitemstring(li,'bapa_a_nombre_de')
	ls_nombre_beneficiario = ls_nombre_beneficiario + fill(' ',60 - len(ls_nombre_beneficiario))
	if isnull(ls_nombre_beneficiario) then ls_nombre_beneficiario = ''
	ldec_monto = dw_4.getitemnumber(li,'bapa_monto_agrupado')
//	ldec_monto = truncate(ldec_monto,0) //Para que no acumule los decimales 5/4/2001
	
	ldec_itbm = dw_4.getitemnumber(li,'bapa_itbm')
	
	li_cantidad_registros = dw_4.getitemnumber(li,'bapa_cantidad_registros')
	
	if li_cantidad_registros > 1 then
		ls_numero_fact = trim(dw_4.getitemstring(li,'bapa_numero_factura'))
		ls_numero_fact = fill(' ',20 - len(ls_numero_fact))+ls_numero_fact
		if isnull(ls_numero_fact) then ls_numero_fact = ''
		ldt_fecha_factura = dw_4.getitemdatetime(li,'bapa_fecha_factura')
		if isnull(ldt_fecha_factura) then
			ls_fecha_factura = fill(' ',8)
		else
			ls_fecha_factura = string(date(ldt_fecha_factura))
			if isnull(ls_fecha_factura) then ls_fecha_factura = ''
			li_largo_fecha_factura = len(ls_fecha_factura)
			for li_2 = 1 to li_largo_fecha_factura
				li_2 = pos(ls_fecha_factura,'/',li_2)
				if li_2 = 0 then exit
				ls_fecha_factura = Replace(ls_fecha_factura,li_2,1,'')
				li_largo_fecha_factura = len(ls_fecha_factura)
			next			
		end if
	else
		ls_numero_fact = trim(dw_4.getitemstring(li,'bapa_numero_factura'))
		ls_numero_fact = fill(' ',20 - len(ls_numero_fact))+ls_numero_fact
		if isnull(ls_numero_fact) then ls_numero_fact = ''
		ldt_fecha_factura = dw_4.getitemdatetime(li,'bapa_fecha_factura')
		if isnull(ldt_fecha_factura) then
			ls_fecha_factura = fill(' ',8)
		else
			ls_fecha_factura = string(date(ldt_fecha_factura))
			li_largo_fecha_factura = len(ls_fecha_factura)
			for li_2 = 1 to li_largo_fecha_factura
				li_2 = pos(ls_fecha_factura,'/',li_2)
				if li_2 = 0 then exit
				ls_fecha_factura = Replace(ls_fecha_factura,li_2,1,'')
				li_largo_fecha_factura = len(ls_fecha_factura)
			next			
		end if
	end if
	
	ls_monto = string(ldec_monto)
	//li_pos = pos(ls_monto,'.',1)
	//ls_monto = mid(ls_monto,1,li_pos - 1)
	ls_monto = Fill(' ',13 - len(ls_monto))+ ls_monto
	if isnull(ls_monto) then ls_monto = ''
	
	ls_itbm = string(ldec_itbm)
	//li_pos = pos(ls_itbm,'.',1)
	//ls_itbm = mid(ls_itbm,1,li_pos - 1)
	ls_itbm = Fill(' ',13 - len(ls_itbm))+ ls_itbm
	if isnull(ls_itbm) then ls_itbm = ''
	
	if ls_concepto_pago = '6' then
		ldec_monto_concep_10 += ldec_monto
		ldec_itbm_concep_10 += ldec_itbm
	else
		if ldec_monto < 50 or ls_concepto_pago = '7' then
			ldec_monto_concep_11 += ldec_monto
			ll_cantidad_reg_c11 += 1
			ls_concepto_pago_c11 = ls_concepto_pago
			ls_ruc_c11 = ls_ruc
			ls_digito_c11 = ls_digito
			ls_tipo_persona_c11 = ls_tipo_persona
			ls_nombre_beneficiario_c11 = ls_nombre_beneficiario
			ls_monto_c11 = ls_monto
			ls_itbm_c11 = ls_itbm
			ls_numero_fact_c11 = ls_numero_fact
			ls_fecha_factura_c11 = ls_fecha_factura
			
			if ls_con_espacios = 'S' then
			else
				ls_ruc = trim(ls_ruc)
				ls_tipo_persona = trim(ls_tipo_persona)
				ls_nombre_beneficiario = trim(ls_nombre_beneficiario)
				ls_monto = trim(ls_monto)
				ls_itbm = trim(ls_itbm)
				ls_numero_fact = trim(ls_numero_fact)
				ls_fecha_factura = trim(ls_fecha_factura)
			end if
	//		Antes del cambio		
	//		ls_cadena_c11 = '2'+"~t"+'20'+"~t"+ls_concepto_pago+"~t"+ls_ruc+"~t"+ls_digito+"~t"+ls_tipo_persona+"~t"+&
	//		ls_nombre_beneficiario+"~t"+ls_monto+"~t"+ls_numero_fact+"~t"+ls_fecha_factura
			
			ls_cadena_c11 = ls_tipo_persona+"~t"+ls_ruc+"~t"+ls_digito+"~t"+ls_nombre_beneficiario+"~t"+ls_numero_fact+"~t"+ls_fecha_factura+"~t"+&
			ls_concepto_pago+"~t"+'2'+"~t"+ls_monto+"~t"+ls_itbm
		else
			ll_row = dw_2.insertrow(0)
			
			dw_2.setitem(ll_row,'tipo_registro','2')
			dw_2.setitem(ll_row,'clase_informacion','20')
			dw_2.setitem(ll_row,'concepto_pago',ls_concepto_pago)
			dw_2.setitem(ll_row,'ruc',ls_ruc)
			dw_2.setitem(ll_row,'digito_verificador',ls_digito)
			dw_2.setitem(ll_row,'tipo_persona',ls_tipo_persona)
			dw_2.setitem(ll_row,'nombre_beneficiario',ls_nombre_beneficiario)
			dw_2.setitem(ll_row,'monto',ls_monto)
			dw_2.setitem(ll_row,'numero_factura',ls_numero_fact)
			dw_2.setitem(ll_row,'fecha_factura',ls_fecha_factura)		
			dw_2.setitem(ll_row,'itbms_pagado',ls_itbm)
			
			ll_row5 = dw_5.insertrow(0)

			dw_5.setitem(ll_row5,'concepto',ls_concepto_pago)
			dw_5.setitem(ll_row5,'ruc',ls_ruc)
			dw_5.setitem(ll_row5,'dv',ls_digito)
			dw_5.setitem(ll_row5,'tp',ls_tipo_persona)
			dw_5.setitem(ll_row5,'nombre',ls_nombre_beneficiario)
			dw_5.setitem(ll_row5,'monto',ls_monto)
			dw_5.setitem(ll_row5,'factura',ls_numero_fact)
			dw_5.setitem(ll_row5,'fecha',ls_fecha_factura)		
			dw_5.setitem(ll_row5,'periodo',ls_periodo_informado)
			dw_5.setitem(ll_row5,'ruc_empresa',ls_ruc_union)
			dw_5.setitem(ll_row5,'dv_empresa',ls_dv_empresa)
			dw_5.setitem(ll_row5,'nombre_empresa',ls_nombre_empresa_origen)
			dw_5.setitem(ll_row5,'monto_total',trim(ls_monto_total))
			dw_5.setitem(ll_row5,'cantidad_pagos',ls_cantidad_pagos_total)
			if ls_con_espacios = 'S' then
			else
				ls_ruc = trim(ls_ruc)
				ls_tipo_persona = trim(ls_tipo_persona)
				ls_nombre_beneficiario = trim(ls_nombre_beneficiario)
				ls_monto = trim(ls_monto)
				ls_itbm	= trim(ls_itbm)
				ls_numero_fact = trim(ls_numero_fact)
				ls_fecha_factura = trim(ls_fecha_factura)
			end if	
	
//			ls_cadena = '2'+"~t"+'20'+"~t"+ls_concepto_pago+"~t"+ls_ruc+"~t"+ls_digito+"~t"+ls_tipo_persona+"~t"+&
//			ls_nombre_beneficiario+"~t"+ls_monto+"~t"+ls_numero_fact+"~t"+ls_fecha_factura
	
			ls_cadena = ls_tipo_persona+"~t"+ls_ruc+"~t"+ls_digito+"~t"+ls_nombre_beneficiario+"~t"+ls_numero_fact+"~t"+ls_fecha_factura+"~t"+&
			ls_concepto_pago+"~t"+'2'+"~t"+ls_monto+"~t"+ls_itbm
	
			filewrite(li_FileNum,ls_cadena)
		end if
	end if
	
	ldec_total += ldec_monto
	
next

if ldec_monto_concep_10 > 0 then	//*************NO DEBE ENTRAR EN ESTA SECCION, YA NO HAY CONCEPTO 10
	ls_concepto_pago = '6'
	
	if cbx_rellena_concepto10.checked then
		ls_ruc = '0'
		ls_digito = '00'	
		ls_tipo_persona = '0'	
		ls_numero_fact = '0'
		ls_fecha_factura = '0'		
	else
		ls_ruc = fill('0',20)
		ls_digito = '00'	
		ls_tipo_persona = '0'	
		ls_numero_fact = fill('0',20)
		ls_fecha_factura = fill('0',8)		
	end if	
	
	ls_nombre_beneficiario = 'PAGOS AL EXTERIOR'+fill(' ',60 - len('PAGOS AL EXTERIOR'))
	ls_monto = string(ldec_monto_concep_10)
	//li_pos = pos(ls_monto,'.',1)
	//ls_monto = mid(ls_monto,1,li_pos - 1)
	ls_monto = Fill(' ',13 - len(ls_monto))+ ls_monto
	
	ls_itbm = string(ldec_itbm_concep_10)
	ls_itbm = Fill(' ',13 - len(ls_itbm))+ ls_itbm

	ll_row = dw_2.insertrow(0)
	
	dw_2.setitem(ll_row,'tipo_registro','2')
	dw_2.setitem(ll_row,'clase_informacion','20')
	dw_2.setitem(ll_row,'concepto_pago',ls_concepto_pago)
	dw_2.setitem(ll_row,'ruc',ls_ruc)
	dw_2.setitem(ll_row,'digito_verificador',ls_digito)
	dw_2.setitem(ll_row,'tipo_persona',ls_tipo_persona)
	dw_2.setitem(ll_row,'nombre_beneficiario',ls_nombre_beneficiario)
	dw_2.setitem(ll_row,'monto',ls_monto)
	dw_2.setitem(ll_row,'numero_factura',ls_numero_fact)
	dw_2.setitem(ll_row,'fecha_factura',ls_fecha_factura)			
	dw_2.setitem(ll_row,'itbms_pagado',ls_itbm)
	
	ll_row5 = dw_5.insertrow(0)

	dw_5.setitem(ll_row5,'concepto',ls_concepto_pago)
	dw_5.setitem(ll_row5,'ruc',ls_ruc)
	dw_5.setitem(ll_row5,'dv',ls_digito)
	dw_5.setitem(ll_row5,'tp',ls_tipo_persona)
	dw_5.setitem(ll_row5,'nombre',ls_nombre_beneficiario)
	dw_5.setitem(ll_row5,'monto',ls_monto)
	dw_5.setitem(ll_row5,'factura',ls_numero_fact)
	dw_5.setitem(ll_row5,'fecha',ls_fecha_factura)	
	dw_5.setitem(ll_row5,'periodo',ls_periodo_informado)
	dw_5.setitem(ll_row5,'ruc_empresa',ls_ruc_union)
	dw_5.setitem(ll_row5,'dv_empresa',ls_dv_empresa)
	dw_5.setitem(ll_row5,'nombre_empresa',ls_nombre_empresa_origen)
	dw_5.setitem(ll_row5,'monto_total',trim(ls_monto_total))
	dw_5.setitem(ll_row5,'cantidad_pagos',ls_cantidad_pagos_total)	
	if ls_con_espacios = 'S' then
	else
		ls_ruc = trim(ls_ruc)
		ls_tipo_persona = trim(ls_tipo_persona)
		ls_nombre_beneficiario = trim(ls_nombre_beneficiario)
		ls_monto = trim(ls_monto)
		ls_itbm = trim(ls_itbm)
		ls_numero_fact = trim(ls_numero_fact)
	end if	
	
//	ls_cadena = '2'+"~t"+'20'+"~t"+ls_concepto_pago+"~t"+ls_ruc+"~t"+ls_digito+"~t"+ls_tipo_persona+"~t"+&
//	ls_nombre_beneficiario+"~t"+ls_monto+"~t"+ls_numero_fact+"~t"+ls_fecha_factura
	ls_cadena = ls_tipo_persona+"~t"+ls_ruc+"~t"+ls_digito+"~t"+ls_nombre_beneficiario+"~t"+ls_numero_fact+"~t"+ls_fecha_factura+"~t"+&
	ls_concepto_pago+"~t"+'2'+"~t"+ls_monto+"~t"+ls_itbm

	if not isnull(ls_cadena) then
		filewrite(li_FileNum,ls_cadena)
	end if	
	
end if

if ldec_monto_concep_11 > 0 then
	ls_concepto_pago = '7'
	
	if cbx_rellena_concepto11.checked then
		ls_ruc = '0'
		ls_digito = '00'	
		ls_tipo_persona = '0'	
		ls_numero_fact = '0'
		ls_fecha_factura = '0'		
	else
		ls_ruc = fill('0',20)
		ls_digito = '00'	
		ls_tipo_persona = '0'	
		ls_numero_fact = fill('0',20)
		ls_fecha_factura = fill('0',8)		
	end if		
	
	ls_nombre_beneficiario = 'PAGOS CONSOLIDADOS'+fill(' ',60 - len('PAGOS CONSOLIDADOS'))
	ls_monto = string(ldec_monto_concep_11)
	//li_pos = pos(ls_monto,'.',1)
	//ls_monto = mid(ls_monto,1,li_pos - 1)
	ls_monto = Fill(' ',13 - len(ls_monto))+ ls_monto
	
	ls_itbm = string(ldec_itbm_concep_11)
	ls_itbm = Fill(' ',13 - len(ls_itbm))+ ls_itbm
		
	ll_row = dw_2.insertrow(0)
	
	dw_2.setitem(ll_row,'tipo_registro','2')
	dw_2.setitem(ll_row,'clase_informacion','20')
	dw_2.setitem(ll_row,'concepto_pago',ls_concepto_pago)
	dw_2.setitem(ll_row,'ruc',ls_ruc)
	dw_2.setitem(ll_row,'digito_verificador',ls_digito)
	dw_2.setitem(ll_row,'tipo_persona',ls_tipo_persona)
	dw_2.setitem(ll_row,'nombre_beneficiario',ls_nombre_beneficiario)
	dw_2.setitem(ll_row,'monto',ls_monto)
	dw_2.setitem(ll_row,'numero_factura',ls_numero_fact)
	dw_2.setitem(ll_row,'fecha_factura',ls_fecha_factura)				
	dw_2.setitem(ll_row,'itbms_pagado',ls_itbm)
	
	ll_row5 = dw_5.insertrow(0)

	dw_5.setitem(ll_row5,'concepto',ls_concepto_pago)
	dw_5.setitem(ll_row5,'ruc',ls_ruc)
	dw_5.setitem(ll_row5,'dv',ls_digito)
	dw_5.setitem(ll_row5,'tp',ls_tipo_persona)
	dw_5.setitem(ll_row5,'nombre',ls_nombre_beneficiario)
	dw_5.setitem(ll_row5,'monto',ls_monto)
	dw_5.setitem(ll_row5,'factura',ls_numero_fact)
	dw_5.setitem(ll_row5,'fecha',ls_fecha_factura)
	dw_5.setitem(ll_row5,'periodo',ls_periodo_informado)
	dw_5.setitem(ll_row5,'ruc_empresa',ls_ruc_union)
	dw_5.setitem(ll_row5,'dv_empresa',ls_dv_empresa)
	dw_5.setitem(ll_row5,'nombre_empresa',ls_nombre_empresa_origen)
	dw_5.setitem(ll_row5,'monto_total',trim(ls_monto_total))
	dw_5.setitem(ll_row5,'cantidad_pagos',ls_cantidad_pagos_total)

	if ls_con_espacios = 'S' then
	else
		ls_ruc = trim(ls_ruc)
		ls_tipo_persona = trim(ls_tipo_persona)
		ls_nombre_beneficiario = trim(ls_nombre_beneficiario)
		ls_monto = trim(ls_monto)
		ls_itbm = trim(ls_itbm)
		ls_numero_fact = trim(ls_numero_fact)

	end if
		
	IF ls_concepto_pago = '7' OR ls_concepto_pago = '6' THEN
		ls_fecha_factura = '0'
	END IF		

	//ls_cadena = '2'+"~t"+'20'+"~t"+ls_concepto_pago+"~t"+ls_ruc+"~t"+ls_digito+"~t"+ls_tipo_persona+"~t"+&
	//ls_nombre_beneficiario+"~t"+ls_monto+"~t"+ls_numero_fact+"~t"+ls_fecha_factura
		ls_cadena = ls_tipo_persona+"~t"+ls_ruc+"~t"+ls_digito+"~t"+ls_nombre_beneficiario+"~t"+ls_numero_fact+"~t"+ls_fecha_factura+"~t"+&
		ls_concepto_pago+"~t"+'2'+"~t"+ls_monto+"~t"+ls_itbm

	if not isnull(ls_cadena) then
		filewrite(li_FileNum,ls_cadena)
	end if
	
end if

DELETE FROM bapagos  
WHERE ( bapa_g_financiero = :str.g_financiero ) AND ( bapa_empresa = :str.empresa );

IF SQLCA.SQLCode = -1 THEN 
	ls_mg = SQLCA.SQLErrText
	Rollback;
	MessageBox("Error",ls_mg)
END IF

commit;
FileClose(li_FileNum)
messagebox('Mensaje','Generaci?n finalizada.')
end event

event ue_imprimir;OpenWithParm(w_dw_print_options, dw_5)
If Message.DoubleParm = -1 Then Return
dw_5.Print(True)

end event

on w_ba_genera_pago_a_tercero.create
int iCurrent
call super::create
if this.MenuName = "m_fa_rep" then this.MenuID = create m_fa_rep
this.cbx_rellena_concepto11=create cbx_rellena_concepto11
this.cbx_rellena_concepto10=create cbx_rellena_concepto10
this.dw_5=create dw_5
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.em_ann=create em_ann
this.st_5=create st_5
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_meses=create ddlb_meses
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_rellena_concepto11
this.Control[iCurrent+2]=this.cbx_rellena_concepto10
this.Control[iCurrent+3]=this.dw_5
this.Control[iCurrent+4]=this.dw_4
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.em_ann
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.ddlb_meses
this.Control[iCurrent+13]=this.cb_1
end on

on w_ba_genera_pago_a_tercero.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_rellena_concepto11)
destroy(this.cbx_rellena_concepto10)
destroy(this.dw_5)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.em_ann)
destroy(this.st_5)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_meses)
destroy(this.cb_1)
end on

event open;call super::open;x = 25; y = 25

SELECT para_ruta_pago_tercero INTO :is_ruta_grabar FROM baaparam  
WHERE ( para_g_financiero = :str.g_financiero ) AND ( para_empresa = :str.empresa );

dw_1.SetTransObject(SQLCA)
dw_2.SetTransObject(SQLCA)
dw_3.SetTransObject(SQLCA)
dw_4.SetTransObject(SQLCA)
dw_5.SetTransObject(SQLCA)
dw_3.visible = false
dw_4.visible = false
dw_5.visible = false

DELETE FROM bapagos  
WHERE ( bapa_g_financiero = :str.g_financiero ) AND ( bapa_empresa = :str.empresa );

ii_mes_seleccionado = month(date(gf_fecha_serv()))
il_ann = year(date(gf_fecha_serv()))

ddlb_meses.SelectItem (ii_mes_seleccionado)
em_ann.text = string(il_ann)

end event

event ue_pre_aceptar;call super::ue_pre_aceptar;triggerevent('ue_aceptar')
end event

event ue_aceptar;call super::ue_aceptar;//string ls_ruta_archivo
//
//if MessageBox('Mensaje','Est? seguro de generar el archivo.',question!,yesno!,2) = 2 then return
//
//if dw_2.rowcount() < 1 then
//	MessageBox('MessageBox','No hay registros para generar el archivo.')
//	return
//end if
//
//if isnull(is_ruta_grabar) then
//	messagebox('Mensaje','Debe capturar la ruta en la que desea copiar el archivo.  Verifique en los par?metros generales.')
//	return
//end if
//
//ls_ruta_archivo = is_ruta_grabar+is_nombre_archivo+'.txt'
//
//if FileExists(ls_ruta_archivo) = true then
//	if messagebox('Mensaje','El archivo '+ls_ruta_archivo+' ya existe.  Desea reemplazarlo.',question!,yesno!,1) = 2 then return
//	if FileDelete(ls_ruta_archivo) = false then return
//end if
//
//if dw_2.SaveAs(ls_ruta_archivo,text!,false) <> 1 then
//	MessageBox('Mensaje','Hubo un error al guardar el archivo.'+'~n'+&
//	'Tal vez la ruta especificada no es la correcta.  Verifique.')
//	Return
//end if
//
//messagebox('Mensaje','El archivo ya fue guardado.')
//
end event

event resize;call super::resize;dw_2.width = newwidth - 100
//dw_2.height= newheight - 500

end event

type cbx_rellena_concepto11 from checkbox within w_ba_genera_pago_a_tercero
integer x = 1513
integer y = 120
integer width = 1317
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Rellena campos de concepto 11"
boolean checked = true
end type

type cbx_rellena_concepto10 from checkbox within w_ba_genera_pago_a_tercero
integer x = 1513
integer y = 40
integer width = 1317
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Rellena campos de concepto 10"
boolean checked = true
end type

type dw_5 from datawindow within w_ba_genera_pago_a_tercero
integer x = 3209
integer y = 16
integer width = 114
integer height = 196
integer taborder = 30
string title = "none"
string dataobject = "dw_rep_pagos_sin_ceros"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_4 from datawindow within w_ba_genera_pago_a_tercero
integer x = 3086
integer y = 16
integer width = 114
integer height = 196
integer taborder = 40
string title = "none"
string dataobject = "dw_ba_bapagos"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_ba_genera_pago_a_tercero
integer x = 3333
integer y = 16
integer width = 114
integer height = 196
integer taborder = 30
string title = "none"
string dataobject = "dw_ba_datos_terceros"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_ba_genera_pago_a_tercero
string tag = "dw_ba_pagos_terceros_final"
integer x = 32
integer y = 744
integer width = 4658
integer height = 944
integer taborder = 60
string title = "none"
string dataobject = "dw_pagos_terceros_nuevo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_ann from editmask within w_ba_genera_pago_a_tercero
integer x = 978
integer y = 48
integer width = 393
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####"
boolean spin = true
string displaydata = "~t/"
double increment = 1
string minmax = "1999~~"
end type

type st_5 from statictext within w_ba_genera_pago_a_tercero
integer x = 823
integer y = 60
integer width = 197
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_ba_genera_pago_a_tercero
integer x = 18
integer y = 68
integer width = 155
integer height = 56
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mes:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_ba_genera_pago_a_tercero
integer x = 32
integer y = 648
integer width = 3401
integer height = 92
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "   Datos de beneficiarios"
boolean focusrectangle = false
end type

type st_1 from statictext within w_ba_genera_pago_a_tercero
integer x = 32
integer y = 240
integer width = 3401
integer height = 92
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "   Datos del informante"
boolean focusrectangle = false
end type

type ddlb_meses from dropdownlistbox within w_ba_genera_pago_a_tercero
integer x = 183
integer y = 48
integer width = 576
integer height = 424
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
boolean sorted = false
boolean vscrollbar = true
integer limit = 3
string item[] = {"Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;ii_mes_seleccionado = index
end event

type dw_11 from datawindow within w_ba_genera_pago_a_tercero
integer x = 32
integer y = 348
integer width = 3401
integer height = 240
integer taborder = 50
string title = "none"
string dataobject = "dw_ba_datos_informante"
boolean hscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_ba_genera_pago_a_tercero
boolean visible = false
end type

type dw_1 from w_fa_padre`dw_1 within w_ba_genera_pago_a_tercero
integer x = 46
integer y = 344
integer width = 4635
integer height = 296
string dataobject = "dw_ba_datos_informante"
end type

event dw_1::ue_microayuda;//override

end event

type st_ayuda from w_fa_padre`st_ayuda within w_ba_genera_pago_a_tercero
end type

type cb_1 from commandbutton within w_ba_genera_pago_a_tercero
integer x = 3712
integer y = 44
integer width = 466
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar Reporte"
end type

event clicked;parent.triggerevent('ue_genera_pago')
end event

