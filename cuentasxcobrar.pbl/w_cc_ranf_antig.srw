//objectcomments Ventana de los rangos de la fecha de antiguedad
forward
global type w_cc_ranf_antig from w_cc_padre_rango_fecha
end type
type gb_10 from groupbox within w_cc_ranf_antig
end type
type cbx_1 from checkbox within w_cc_ranf_antig
end type
type gb_8 from groupbox within w_cc_ranf_antig
end type
type dw_3 from datawindow within w_cc_ranf_antig
end type
type pb_3 from picturebutton within w_cc_ranf_antig
end type
type pb_4 from picturebutton within w_cc_ranf_antig
end type
type gb_9 from groupbox within w_cc_ranf_antig
end type
type rb_3 from radiobutton within w_cc_ranf_antig
end type
type rb_4 from radiobutton within w_cc_ranf_antig
end type
type rb_5 from radiobutton within w_cc_ranf_antig
end type
type rb_6 from radiobutton within w_cc_ranf_antig
end type
type rb_7 from radiobutton within w_cc_ranf_antig
end type
type dw_4 from datawindow within w_cc_ranf_antig
end type
type cbx_2 from checkbox within w_cc_ranf_antig
end type
type dw_2 from datawindow within w_cc_ranf_antig
end type
type dw_5 from datawindow within w_cc_ranf_antig
end type
type st_9 from statictext within w_cc_ranf_antig
end type
type rb_8 from radiobutton within w_cc_ranf_antig
end type
type rb_9 from radiobutton within w_cc_ranf_antig
end type
type dw_6 from datawindow within w_cc_ranf_antig
end type
type dw_7 from datawindow within w_cc_ranf_antig
end type
type cbx_3 from checkbox within w_cc_ranf_antig
end type
type cb_2 from commandbutton within w_cc_ranf_antig
end type
type calendario2 from picture within w_cc_ranf_antig
end type
type uo_2 from u_ddcalen within w_cc_ranf_antig
end type
type hpb_barra from hprogressbar within w_cc_ranf_antig
end type
type st_100 from statictext within w_cc_ranf_antig
end type
type ddlb_tipo from dropdownlistbox within w_cc_ranf_antig
end type
type st_3 from statictext within w_cc_ranf_antig
end type
type gb_2 from groupbox within w_cc_ranf_antig
end type
end forward

global type w_cc_ranf_antig from w_cc_padre_rango_fecha
integer width = 2039
integer height = 1044
string title = "Antigüedad de Saldos"
long backcolor = 12639424
string icon = "AppIcon!"
windowanimationstyle openanimation = leftroll!
windowanimationstyle closeanimation = leftslide!
gb_10 gb_10
cbx_1 cbx_1
gb_8 gb_8
dw_3 dw_3
pb_3 pb_3
pb_4 pb_4
gb_9 gb_9
rb_3 rb_3
rb_4 rb_4
rb_5 rb_5
rb_6 rb_6
rb_7 rb_7
dw_4 dw_4
cbx_2 cbx_2
dw_2 dw_2
dw_5 dw_5
st_9 st_9
rb_8 rb_8
rb_9 rb_9
dw_6 dw_6
dw_7 dw_7
cbx_3 cbx_3
cb_2 cb_2
calendario2 calendario2
uo_2 uo_2
hpb_barra hpb_barra
st_100 st_100
ddlb_tipo ddlb_tipo
st_3 st_3
gb_2 gb_2
end type
global w_cc_ranf_antig w_cc_ranf_antig

type variables
datastore ids_cliente
DatawindowChild   idch_notercero,  idch_notercero1
DatawindowChild    idch_desdecliente,  idch_hastacliente,&
                   idch_tipclien,  idch_tipsocio, idch_tipauditor

string    is_data, ls_codigo, is_busqueda, is_tip_busca, is_balance,is_pais_region='N',&
          is_proy_anam
long li_cliente

str_rangofecha str_rangfech

end variables

forward prototypes
public subroutine wf_asignar_antig ()
end prototypes

public subroutine wf_asignar_antig ();string ls_error
integer li_count
/* convierte una antiguedad Vertical en Horizontal */
/* Elimina los Valores Actuales */ 

//messagebox('str.maquina','1'+str.maquina+'1'+string(li_count))
  DELETE FROM ccatpan  
   WHERE ( ccatpan.tpan_g_financiero = :str.g_financiero ) AND  
         ( ccatpan.tpan_empresa = :str.empresa ) AND  
         ( ccatpan.tpan_maquina = :str.maquina )   ;
         
if sqlca.sqlcode = -1 then
	ls_error = sqlca.sqlerrtext
	rollback;
	mensaje('Aviso','Error al eliminar ccatpan',ls_error)
	return
else	
	commit ; 
end if
		

/* Inserta los nuevos valores */ 
  INSERT INTO ccatpan  
         ( tpan_g_financiero,   
           tpan_empresa,   
           tpan_tercero,
			  tpan_saldo_anterior,
           tpan_col1,   
           tpan_col2,   
           tpan_col3,   
           tpan_col4,   
           tpan_col5,   
           tpan_col6,   
           tpan_col7,   
           tpan_col8,   
           tpan_col9,   
           tpan_col10,
			  tpan_col11,
			  tpan_col12,
			  tpan_col13,
			  tpan_col14,
			  tpan_col15,
			  tpan_col16,
           tpan_col21,   
           tpan_col1_t,   
           tpan_col2_t,   
           tpan_col3_t,   
           tpan_col4_t,   
           tpan_col5_t,   
           tpan_col6_t,   
           tpan_col7_t,   
           tpan_col8_t,   
           tpan_col9_t,   
           tpan_col10_t,   
           tpan_col11_t,  
		  tpan_col12_t,  
		  tpan_col13_t,  
		  tpan_col14_t,  
		  tpan_col15_t,  
		  tpan_col16_t,  		  
		  tpan_col21_t,
		  tpan_maquina)   
  SELECT ccatempa.tmpa_g_financiero,   
         ccatempa.tmpa_empresa,   
         ccatempa.tmpa_tercero,
			max( case ccatempa.tmpa_orden when 21 then ccatempa.tmpa_saldo_anterior  else ccatempa.tmpa_saldo_anterior end ),
			sum( case ccatempa.tmpa_orden when 1 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 2 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 3 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 4 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 5 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 6 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 7 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 8 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 9 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 10 then ccatempa.tmpa_monto else 0 end ), 
			sum( case ccatempa.tmpa_orden when 11 then ccatempa.tmpa_monto else 0 end ), 
			sum( case ccatempa.tmpa_orden when 12 then ccatempa.tmpa_monto else 0 end ), 
			sum( case ccatempa.tmpa_orden when 13 then ccatempa.tmpa_monto else 0 end ), 
			sum( case ccatempa.tmpa_orden when 14 then ccatempa.tmpa_monto else 0 end ), 
			sum( case ccatempa.tmpa_orden when 15 then ccatempa.tmpa_monto else 0 end ), 
			sum( case ccatempa.tmpa_orden when 16 then ccatempa.tmpa_monto else 0 end ), 
			sum( case ccatempa.tmpa_orden when 21 then ccatempa.tmpa_monto else 0 end ),   
         max( case ccatempa.tmpa_orden when 1 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 2 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 3 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 4 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 5 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 6 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 7 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 8 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 9 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 10 then ccatempa.tmpa_descantig  else '' end ),
			max( case ccatempa.tmpa_orden when 11 then ccatempa.tmpa_descantig  else '' end ),
			max( case ccatempa.tmpa_orden when 12 then ccatempa.tmpa_descantig  else '' end ),
			max( case ccatempa.tmpa_orden when 13 then ccatempa.tmpa_descantig  else '' end ),
			max( case ccatempa.tmpa_orden when 14 then ccatempa.tmpa_descantig  else '' end ),
			max( case ccatempa.tmpa_orden when 15 then ccatempa.tmpa_descantig  else '' end ),
			max( case ccatempa.tmpa_orden when 16 then ccatempa.tmpa_descantig  else '' end ),			
         max( case ccatempa.tmpa_orden when 21 then ccatempa.tmpa_descantig  else '' end ),
			max(ccatempa.tmpa_usuario_maquina) FROM ccatempa 
WHERE ( ccatempa.tmpa_g_financiero = :str.g_financiero ) AND  
      ( ccatempa.tmpa_empresa = :str.empresa ) and
		( ccatempa.tmpa_usuario_maquina = :str.maquina) 
GROUP BY ccatempa.tmpa_g_financiero,   
         ccatempa.tmpa_empresa,   
         ccatempa.tmpa_tercero ;
if sqlca.sqlcode = -1 then
	ls_error = sqlca.sqlerrtext
	rollback;
	mensaje('Aviso ','Error al insertar en ccatpan',ls_error)
	return
else	
	commit ; 
	//mensaje('','Inserto en CCATPAN','')
end if


end subroutine

event ue_vistaprevia;long		ll_cliente, ll_i, ll_flag, ll_pais1, ll_pais2, ll_proximo
string	ls_filtro
datetime	ld_fecha
integer	li_swt, li_primer, li_reg, li_tipclien
string	ls_error

// Controla saldo débito/crédito
dw_5.accepttext()
is_balance = dw_5.getitemstring(1,'dw_cc_ext_balance') //naturaleza en pantalla db/cr/ambos
str_rangfech.filtro_balance = is_balance
sqlca.autocommit = true
dw_3.accepttext()
li_primer = 1

// Controla ceros en el reporte
if cbx_2.checked then
	str_rangfech.ceros = 'S'
else
	str_rangfech.ceros = 'N'
end if

//Selecciona el Tipo de antiguedad
str_rangfech.tipo_antiguedad = 1
if ddlb_tipo.text = 'BANCOS' then str_rangfech.tipo_antiguedad = 2

//
//Agregado por Irving Aguilar
if cbx_3.checked = true then 
	str_rangfech.aliasempresa = true 
else 
	str_rangfech.aliasempresa = false  
end if 
//Fin de agregado
//

// Tipo de Cliente
if rb_6.checked then
	str_rangfech.tip_cliente = 'T'//todos
elseif rb_7.checked then
	str_rangfech.tip_cliente = 'P'	// Por tipo
	str_rangfech.tipo_cliesp = dw_4.getitemnumber(1,'tipo_cliente')
elseif rb_8.checked then
	str_rangfech.tip_cliente = 'P'	// Por tipo
	str_rangfech.tipo_socio = dw_6.getitemnumber(1,'tipo_socio')
elseif rb_9.checked then
	str_rangfech.tip_cliente = 'P'	// Por tipo
	str_rangfech.tipo_auditor = dw_7.getitemnumber(1,'tipo_auditor')	
end if

///////////////////////////////////////////////////////////////////

SELECT count(*)
INTO :li_reg
FROM ccaantig
WHERE ccan_g_financiero = :str.g_financiero AND
		ccan_empresa = :str.empresa AND
		ccan_codigo = :str_rangfech.tipo_antiguedad ;
if sqlca.sqlcode = -1 then
	ls_error = sqlca.sqlerrtext
	rollback;
	mensaje('Error','No se pudo recuperar la antigüedad.',ls_error)
	destroy ids_cliente
	return
end if

if isnull(li_reg) then li_reg = 0

if li_reg < 4 then
	str_rangfech.print_op = 'P'	// Vertical
elseif li_reg >=4 then
	str_rangfech.print_op = 'L'	// Horizontal
end if

//con saldo y sin saldo
if cbx_1.checked then
	li_swt = 1
else
	li_swt = 0
end if

// Valor para filtrar el tipo de cliente
if str_rangfech.tip_cliente <> 'T' then
	if dw_4.rowcount() > 0 and rb_7.checked then
		li_tipclien = dw_4.getitemNumber(1,'tipo_cliente')
	elseif dw_6.rowcount() > 0 and rb_8.checked then
		li_tipclien = dw_6.getitemNumber(1,'tipo_socio')
	elseif dw_7.rowcount() > 0 and rb_9.checked then
		li_tipclien = dw_7.getitemNumber(1,'tipo_auditor')
	end if
end if

ids_cliente = create Datastore
ids_cliente.dataobject = "dw_pr_cc_tercero_antig"
ids_cliente.SetTransObject(sqlca)
ids_cliente.retrieve(str.g_financiero,str.empresa)

str_rangfech.op_vende = is_data

CHOOSE CASE is_data
	CASE 'C'	// Por cliente 
		// Valida por búsqueda y toma los valores
		if rb_3.checked then	
			str_rangfech.nombre1 = dw_2.GetItemString(dw_2.Getrow(),"desdecliente")
			str_rangfech.nombre2 = dw_2.GetItemString(dw_2.Getrow(),"hastacliente")
			
			if str_rangfech.nombre2 < str_rangfech.nombre1 then
				messagebox('Atención','El Cliente Final es Menor al Inicial!')
				destroy ids_cliente
				return
			end if
		elseif rb_4.checked then
			str_rangfech.desdeclienteref = dw_2.GetItemString(dw_2.Getrow(),"desdecliente")
			str_rangfech.hastaclienteref = dw_2.GetItemString(dw_2.Getrow(),"hastacliente")
			if str_rangfech.hastaclienteref < str_rangfech.desdeclienteref then
				messagebox('AVISO', 'El Cliente Final es Menor al Inicial!')
				destroy ids_cliente
				return
			end if
		elseif rb_5.checked then	
			str_rangfech.ruccli1 = dw_2.GetItemString(dw_2.Getrow(),"desdecliente")
			str_rangfech.ruccli2 = dw_2.GetItemString(dw_2.Getrow(),"hastacliente")
			if str_rangfech.ruccli2 < str_rangfech.ruccli1 then
				messagebox('AVISO', 'El Cliente Final es Menor al Inicial!')
				destroy ids_cliente
				return
			end if
		end if
		
		// Tipo de búsqueda 
		if rb_3.checked then//busqueda ordenada alfabeticamente
			//Validacion por tipo de filtro
			if rb_7.checked then//boton de filtro por tipo cliente
					
				ls_filtro = "terc_descripcion + string(terc_tercero) >= '"+string(str_rangfech.nombre1) + "' and terc_descripcion + string(terc_tercero) <= '" + string(str_rangfech.nombre2)+&
				"' and ccmclien_clie_clasificacion ="+string(li_tipclien)
			elseif rb_8.checked then//boton de filtro por socio
				ls_filtro = "terc_descripcion + string(terc_tercero) >=  '"+string(str_rangfech.nombre1) + "' and terc_descripcion + string(terc_tercero) <= '" + string(str_rangfech.nombre2)+&
				"' and ccmclien_clie_socio ="+string(li_tipclien)
			elseif rb_8.checked then//boton de filtro por auditor
				ls_filtro = "terc_descripcion + string(terc_tercero) >=  '"+string(str_rangfech.nombre1) + "' and terc_descripcion + string(terc_tercero) <= '" + string(str_rangfech.nombre2)+&
				"' and ccmclien_clie_auditor ="+string(li_tipclien)
			else
				ls_filtro = "terc_descripcion + string(terc_tercero) >=  '"+str_rangfech.nombre1 + "' and terc_descripcion + string(terc_tercero) <= '" + str_rangfech.nombre2+ "'"			
			end if

		elseif rb_4.checked then//busqueda ordenada por cliente
			if rb_7.checked then//boton de filtro por tipo cliente
				ls_filtro = "terc_descripcion + string(terc_tercero) >=  '"+string(str_rangfech.nombre1) + "' and terc_descripcion + string(terc_tercero) <= '" + string(str_rangfech.nombre2)+&
			 "' and ccmclien_clie_clasificacion ="+string(li_tipclien)
			elseif rb_8.checked then//boton de filtro por socio
				ls_filtro = "terc_descripcion + string(terc_tercero) >=  '"+string(str_rangfech.nombre1) + "' and terc_descripcion + string(terc_tercero) <= '" + string(str_rangfech.nombre2)+&
			 "' and ccmclien_clie_socio ="+string(li_tipclien)
			elseif rb_9.checked then//boton de filtro por auditor
				ls_filtro = "terc_descripcion + string(terc_tercero) >=  '"+string(str_rangfech.nombre1) + "' and terc_descripcion + string(terc_tercero) <= '" + string(str_rangfech.nombre2)+&
			 "' and ccmclien_clie_auditor ="+string(li_tipclien)
			else
				ls_filtro = "terc_descripcion + string(terc_tercero) >=  '"+string(str_rangfech.nombre1) + "' and terc_descripcion + string(terc_tercero) <= '" + string(str_rangfech.nombre2)+ "'"			
			end if
										
		elseif rb_5.checked then//busqueda ordenada por ruc
			if rb_7.checked then//boton de filtro por tipo cliente
				ls_filtro = "terc_descripcion + string(dgmterce.terc_tercero) >=  '"+string(str_rangfech.nombre1) + "' and terc_descripcion + string(terc_tercero) <= '" + string(str_rangfech.nombre2)+&
			 "and ccmclien_clie_clasificacion ="+string(li_tipclien)
			elseif rb_8.checked then//boton de filtro por socio
				ls_filtro = "terc_descripcion + string(dgmterce.terc_tercero) >=  '"+string(str_rangfech.nombre1) + "' and terc_descripcion + string(terc_tercero) <= '" + string(str_rangfech.nombre2)+&
			 "and ccmclien_clie_socio ="+string(li_tipclien)
			elseif rb_9.checked then//boton de filtro por auditor
				ls_filtro = "terc_descripcion + string(dgmterce.terc_tercero) >=  '"+string(str_rangfech.nombre1) + "' and terc_descripcion + string(terc_tercero) <= '" + string(str_rangfech.nombre2)+&
			 "and ccmclien_clie_auditor ="+string(li_tipclien)
			else
				ls_filtro = "terc_descripcion + string(terc_tercero) >=  '"+string(str_rangfech.nombre1) + "' and terc_descripcion + string(terc_tercero) <= '" + string(str_rangfech.nombre2)+ "'"			
			end if
		end if
		
		// Si no se define rango, se asume el tipo
		if (isnull(str_rangfech.nombre1) and isnull(str_rangfech.nombre2)) or &
			(isnull(str_rangfech.desdeclienteref) and isnull(str_rangfech.hastaclienteref)) or &
			(isnull(str_rangfech.ruccli1) and isnull(str_rangfech.ruccli2)) then
			if not isnull(li_tipclien) then//and str_rangfech.tip_cliente <> 'T'then
				if rb_7.checked then
					ls_filtro = "ccmclien_clie_clasificacion ="+string(li_tipclien)
				elseif rb_8.checked then
					ls_filtro = "ccmclien_clie_socio ="+string(li_tipclien)
				elseif rb_9.checked then
					ls_filtro = "ccmclien_clie_auditor ="+string(li_tipclien)
				end if
			
			end if
		end if
//			messagebox('antes',ids_cliente.rowcount())
	
		ids_cliente.setfilter(ls_filtro)
		ids_cliente.filter()	//**
		
		//mensaje('despues del filtro',ls_filtro,string(ids_cliente.rowcount()))
		
	CASE 'P', 'A'	
			str_rangfech.desdecliente = dw_2.GetItemNumber(dw_2.Getrow(),"desdepais")
			str_rangfech.hastacliente = dw_2.GetItemNumber(dw_2.Getrow(),"hastapais")
					
			if str_rangfech.hastacliente < str_rangfech.desdecliente then
				messagebox('Atención','El País Final es Menor al Inicial!')
				destroy ids_cliente
				return
			end if
			
			if rb_7.checked then
				ls_filtro = "dgmterce_terc_pais >= "+string(str_rangfech.desdecliente) + "  and dgmterce_terc_pais <=  " + string(str_rangfech.hastacliente)+&
				"and ccmclien_clie_clasificacion ="+string(li_tipclien)
			elseif rb_8.checked then
				ls_filtro = "dgmterce_terc_pais >= "+string(str_rangfech.desdecliente) + "  and dgmterce_terc_pais <=  " + string(str_rangfech.hastacliente)+&
				"and ccmclien_clie_socio ="+string(li_tipclien)
			elseif rb_9.checked then
				ls_filtro = "dgmterce_terc_pais >= "+string(str_rangfech.desdecliente) + "  and dgmterce_terc_pais <=  " + string(str_rangfech.hastacliente)+&
				"and ccmclien_clie_auditor ="+string(li_tipclien)
			else
				ls_filtro = "dgmterce_terc_pais >= "+string(str_rangfech.desdecliente) + "  and dgmterce_terc_pais <=  " + string(str_rangfech.hastacliente)
			end if
			
				//Si no se define rango, se asume el tipo
			if isnull(str_rangfech.desdecliente) and isnull(str_rangfech.hastacliente) then
			   if not isnull(li_tipclien) then
					if rb_7.checked then
						ls_filtro = "ccmclien_clie_clasificacion =" +string(li_tipclien)
					elseif rb_8.checked then
						ls_filtro = "ccmclien_clie_socio =" +string(li_tipclien)
					elseif rb_9.checked then
						ls_filtro = "ccmclien_clie_auditor =" +string(li_tipclien)
					end if
				end if
			end if
		
			ids_cliente.setfilter(ls_filtro)
			ids_cliente.filter()
			
	CASE 'R', 'E'	// Por Región y Resumido por País-Región (Gianni Araúz: 28/12/2000).
		 idch_desdecliente.accepttext()
		ll_pais1 = idch_desdecliente.getitemnumber(idch_desdecliente.getrow(), 'pais_pais')
		ll_pais2 = idch_hastacliente.getitemnumber(idch_desdecliente.getrow(), 'pais_pais')
//		str_rangfech.desdecliente = dw_2.GetItemNumber(dw_2.Getrow(),"desderegion")
//		str_rangfech.hastacliente = dw_2.GetItemNumber(dw_2.Getrow(),"hastaregion")
		str_rangfech.desdecliente  = idch_desdecliente.getitemnumber(idch_desdecliente.getrow(), 'dgaregio_regi_codigo_region')
		str_rangfech.hastacliente  = idch_hastacliente.getitemnumber(idch_hastacliente.getrow(), 'dgaregio_regi_codigo_region')
	
		if str_rangfech.hastacliente < str_rangfech.desdecliente then
			messagebox('Atención','El País Final es Menor al Inicial!')
			destroy ids_cliente
			return
		end if
		
		if rb_7.checked then
			ls_filtro = "dgmterce_terc_region >=  "+string(str_rangfech.desdecliente) + "  and dgmterce_terc_region <= " + string(str_rangfech.hastacliente) &
						+ "  and dgmterce_terc_pais >= "+string(ll_pais1) + "  and dgmterce_terc_pais <= " + string(ll_pais2) +&
			" and ccmclien_clie_clasificacion ="+string(li_tipclien)			
		elseif rb_8.checked then
			ls_filtro = "dgmterce_terc_region >=  "+string(str_rangfech.desdecliente) + "  and dgmterce_terc_region <= " + string(str_rangfech.hastacliente) &
						+ "  and dgmterce_terc_pais >= "+string(ll_pais1) + "  and dgmterce_terc_pais <= " + string(ll_pais2) +&
			" and ccmclien_clie_socio ="+string(li_tipclien)			
		elseif rb_9.checked then
			ls_filtro = "dgmterce_terc_region >=  "+string(str_rangfech.desdecliente) + "  and dgmterce_terc_region <= " + string(str_rangfech.hastacliente) &
						+ "  and dgmterce_terc_pais >= "+string(ll_pais1) + "  and dgmterce_terc_pais <= " + string(ll_pais2) +&
			" and ccmclien_clie_auditor ="+string(li_tipclien)			
		else
			ls_filtro = "dgmterce_terc_region >=  "+string(str_rangfech.desdecliente) + "  and dgmterce_terc_region <= " + string(str_rangfech.hastacliente) &
						+ "  and dgmterce_terc_pais >= "+string(ll_pais1) + "  and dgmterce_terc_pais <= " + string(ll_pais2) 
		end if
			
		//Si no se define rango, se asume el tipo
		if isnull(str_rangfech.desdecliente) and isnull(str_rangfech.hastacliente) then
			if not isnull(li_tipclien) then
				if rb_7.checked then
					ls_filtro = "ccmclien_clie_clasificacion =" +string(li_tipclien)
				elseif rb_8.checked then
					ls_filtro = "ccmclien_clie_socio =" +string(li_tipclien)
				elseif rb_9.checked then
					ls_filtro = "ccmclien_clie_auditor =" +string(li_tipclien)
				end if
			end if
		end if

		ids_cliente.setfilter(ls_filtro)
		ids_cliente.filter()
		
	CASE 'V'//Por Vendedor
			str_rangfech.desdecliente = dw_2.GetItemNumber(dw_2.Getrow(),"desdevendedor")
			str_rangfech.hastacliente = dw_2.GetItemNumber(dw_2.Getrow(),"hastavendedor")
		
			if str_rangfech.hastacliente < str_rangfech.desdecliente then
				messagebox('Atención', 'El Vendedor Final es Menor al Inicial!')
				destroy ids_cliente
				return
			end if
			
			if rb_7.checked then
				ls_filtro = "ccmclien_clie_vendedor >=  "+string(str_rangfech.desdecliente) +&
				" and ccmclien_clie_vendedor <= " + string(str_rangfech.hastacliente)+&
				" and ccmclien_clie_clasificacion ="+string(li_tipclien)
			elseif rb_8.checked then
				ls_filtro = "ccmclien_clie_vendedor >=  "+string(str_rangfech.desdecliente) +&
				" and ccmclien_clie_vendedor <= " + string(str_rangfech.hastacliente)+&
				" and ccmclien_clie_socio ="+string(li_tipclien)
			elseif rb_9.checked then
				ls_filtro = "ccmclien_clie_vendedor >=  "+string(str_rangfech.desdecliente) +&
				" and ccmclien_clie_vendedor <= " + string(str_rangfech.hastacliente)+&
				" and ccmclien_clie_auditor ="+string(li_tipclien)
			else
				ls_filtro = "ccmclien_clie_vendedor >=  "+string(str_rangfech.desdecliente) + "  and ccmclien_clie_vendedor <= " + string(str_rangfech.hastacliente)
			end if
			
			//Si no se define rango, se asume el tipo
			if isnull(str_rangfech.desdecliente) and isnull(str_rangfech.hastacliente) then
			   if not isnull(li_tipclien) then
					if rb_7.checked then
						ls_filtro = "ccmclien_clie_clasificacion =" +string(li_tipclien)
					elseif rb_8.checked then
						ls_filtro = "ccmclien_clie_socio =" +string(li_tipclien)
					elseif rb_9.checked then
						ls_filtro = "ccmclien_clie_auditor =" +string(li_tipclien)
					end if
				end if
			end if
			
			ids_cliente.setfilter(ls_filtro)
			ids_cliente.filter()
END CHOOSE

str.frame.setmicrohelp('Por favor espere......')

ld_fecha = datetime(date(em_2.text),Time(23,59,59))
str_rangfech.fecha2 = date(ld_fecha)

//ole_1.visible = true

Delete From ccatempa
where tmpa_g_financiero = :str.g_financiero and
		tmpa_empresa		= :str.empresa and
		tmpa_usuario_maquina = :str.maquina;

if sqlca.sqlcode = -1  then
	mensaje('Error', 'No se Pudo Eliminar en CCATEMPA',sqlca.sqlerrtext)
	destroy ids_cliente
	return
end if		
//
str.frame.setmicrohelp('Eliminando Temporales ......')
/* Envío de Clientes Seleccionados  5 / Dic /2000*/

datastore dw_clientes_s
dw_clientes_s = create ds_dg_import_file
dw_clientes_s.dataobject = 'dw_cc_cctcancl'
dw_clientes_s.settransobject(sqlca)

delete from cctcancl where ancl_maquina = : str.maquina ; 

if ids_cliente.RowCount() > 0 then
	For ll_i = 1 to ids_cliente.RowCount()
		//messagebox('ids_cliente.RowCount()',ids_cliente.RowCount())
	ll_proximo = dw_clientes_s.insertrow(0)
	dw_clientes_s.setitem(ll_proximo,"ancl_g_financiero", str.g_financiero)
	dw_clientes_s.setitem(ll_proximo,"ancl_empresa", str.empresa)
	dw_clientes_s.setitem(ll_proximo,"ancl_maquina", str.maquina)
	dw_clientes_s.setitem(ll_proximo,"ancl_tercero", ids_cliente.GetitemNumber(ll_i,"terc_tercero"))
	dw_clientes_s.setitem(ll_proximo,"ancl_descripcion_ter", ids_cliente.GetitemString(ll_i,"terc_descripcion"))
	Next
end if
	//messagebox('dw_clientes_s.RowCount()',dw_clientes_s.RowCount())
if dw_clientes_s.update() = -1 then
	mensaje('Error','Error al actualizar dw_clientes','')
else
// Validación
//	commit;
end if

//mensaje(string(dw_clientes_s.rowcount()),string(ids_cliente.rowcount()),'')
gf_cc_calcula_antiguedad_sql_antig(date(ld_fecha),is_balance,li_swt, str_rangfech.tipo_antiguedad)
str.frame.SetMicroHelp(" Asignar Antiguedad a Clientes ")
wf_asignar_antig()
str.frame.SetMicroHelp(" Hymsoft")

if isdate(em_2.text) then
//	this.setredraw(false)	
	opensheetwithparm(w_inf_cc_antiguedad,str_rangfech,this,1,layered!)
//	m_cc_principal.m_edicin.enabled = false
	this.settoolbar(1,false)
else
	messagebox('Atención','El Rango de Fecha es Inválido. Cerciórese de que el Rango de fecha DESDE no sea Mayor que el Rango de fecha HASTA.',exclamation!)
end if

//ole_1.visible = false
destroy ids_cliente

end event

on w_cc_ranf_antig.create
int iCurrent
call super::create
this.gb_10=create gb_10
this.cbx_1=create cbx_1
this.gb_8=create gb_8
this.dw_3=create dw_3
this.pb_3=create pb_3
this.pb_4=create pb_4
this.gb_9=create gb_9
this.rb_3=create rb_3
this.rb_4=create rb_4
this.rb_5=create rb_5
this.rb_6=create rb_6
this.rb_7=create rb_7
this.dw_4=create dw_4
this.cbx_2=create cbx_2
this.dw_2=create dw_2
this.dw_5=create dw_5
this.st_9=create st_9
this.rb_8=create rb_8
this.rb_9=create rb_9
this.dw_6=create dw_6
this.dw_7=create dw_7
this.cbx_3=create cbx_3
this.cb_2=create cb_2
this.calendario2=create calendario2
this.uo_2=create uo_2
this.hpb_barra=create hpb_barra
this.st_100=create st_100
this.ddlb_tipo=create ddlb_tipo
this.st_3=create st_3
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_10
this.Control[iCurrent+2]=this.cbx_1
this.Control[iCurrent+3]=this.gb_8
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.pb_3
this.Control[iCurrent+6]=this.pb_4
this.Control[iCurrent+7]=this.gb_9
this.Control[iCurrent+8]=this.rb_3
this.Control[iCurrent+9]=this.rb_4
this.Control[iCurrent+10]=this.rb_5
this.Control[iCurrent+11]=this.rb_6
this.Control[iCurrent+12]=this.rb_7
this.Control[iCurrent+13]=this.dw_4
this.Control[iCurrent+14]=this.cbx_2
this.Control[iCurrent+15]=this.dw_2
this.Control[iCurrent+16]=this.dw_5
this.Control[iCurrent+17]=this.st_9
this.Control[iCurrent+18]=this.rb_8
this.Control[iCurrent+19]=this.rb_9
this.Control[iCurrent+20]=this.dw_6
this.Control[iCurrent+21]=this.dw_7
this.Control[iCurrent+22]=this.cbx_3
this.Control[iCurrent+23]=this.cb_2
this.Control[iCurrent+24]=this.calendario2
this.Control[iCurrent+25]=this.uo_2
this.Control[iCurrent+26]=this.hpb_barra
this.Control[iCurrent+27]=this.st_100
this.Control[iCurrent+28]=this.ddlb_tipo
this.Control[iCurrent+29]=this.st_3
this.Control[iCurrent+30]=this.gb_2
end on

on w_cc_ranf_antig.destroy
call super::destroy
destroy(this.gb_10)
destroy(this.cbx_1)
destroy(this.gb_8)
destroy(this.dw_3)
destroy(this.pb_3)
destroy(this.pb_4)
destroy(this.gb_9)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.rb_6)
destroy(this.rb_7)
destroy(this.dw_4)
destroy(this.cbx_2)
destroy(this.dw_2)
destroy(this.dw_5)
destroy(this.st_9)
destroy(this.rb_8)
destroy(this.rb_9)
destroy(this.dw_6)
destroy(this.dw_7)
destroy(this.cbx_3)
destroy(this.cb_2)
destroy(this.calendario2)
destroy(this.uo_2)
destroy(this.hpb_barra)
destroy(this.st_100)
destroy(this.ddlb_tipo)
destroy(this.st_3)
destroy(this.gb_2)
end on

event open;//Override
sqlca.autocommit = true
integer li_mes, li_ano
this.y = 0
this.x = 805

//gf_center_win(This)
//gf_acelerador()
dw = dw_1

This.Icon = str.icono

this.postevent("ue_post_open")


This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)
str.frame.SetRedraw ( True )

p_1.PictureName = "" + str.path +"\Art\Day.bmp "

pb_2.Bringtotop = true

//li_mes = w_fa_fondo.str_para.mes
//li_ano = w_fa_fondo.str_para.ano

  SELECT ccmparam.para_mes,   
         ccmparam.para_ano  
    INTO :li_mes,   
         :li_ano  
    FROM ccmparam  
   WHERE ( ccmparam.para_g_financiero = :str.g_financiero ) AND  
         ( ccmparam.para_empresa = :str.empresa ) ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al seleccionar periodo ' + sqlca.sqlerrtext,1,1,'E')
			end if

em_1.text = string(01)+ "/" +string(li_mes)+ "/" +string(li_ano)
em_2.text =  string(gf_last_day(li_mes,li_ano))+ "/" +string(li_mes)+ "/" +string(li_ano)




//-------
integer li_row
string  ls_error

str_rangfech = Message.PowerObjectParm


SELECT para_tipo_busqueda,isnull(ccmparam.para_cambio_pais_region,'N'),
isnull(ccmparam.para_proy_anam,'N')
INTO :is_tip_busca,:is_pais_region,:is_proy_anam
FROM ccmparam
WHERE ( para_g_financiero = :str.g_financiero ) AND
		( para_empresa = :str.empresa );

if sqlca.sqldbcode = -1 then
	ls_error = sqlca.sqlerrtext
	rollback;
	mensaje("Error","Ha ocurrido un error al recuperar el tipo de búsqueda",ls_error)
end if

if is_pais_region = 'S' then
	if is_proy_anam = 'S' then
		dw_3.dataobject = 'dw_cc_externo_antiguedad_anam'
	else
		dw_3.dataobject = 'dw_cc_externo_antiguedad_colegio'
	end if
else
	dw_3.dataobject = 'dw_cc_externo_antiguedad'
end if

if isnull(is_tip_busca) then is_tip_busca = 'S'

li_row = dw_3.insertRow(1)
dw_3.setitem(li_row, 'op_estado', 'T')
dw_3.accepttext()

dw_5.settransobject(sqlca)
dw_5.insertrow(0)
dw_5.setitem(1,'dw_cc_ext_balance','A')

is_data = 'T'
pb_3.enabled = false
pb_4.enabled = false
dw_3.insertRow(1)//Datawindow externo de opciones

//Datawindows por tipo
dw_4.GetChild("tipo_cliente",idch_tipclien)
idch_tipclien.SetTransObject(Sqlca)
idch_tipclien.Retrieve(str.g_financiero,str.empresa)
If idch_tipclien.rowcount() < 1 then idch_tipclien.InsertRow(0)

dw_4.settransobject(Sqlca)
dw_4.Insertrow(0)
dw_4.enabled = false

dw_6.GetChild("tipo_socio",idch_tipsocio)
idch_tipsocio.SetTransObject(Sqlca)
idch_tipsocio.Retrieve(str.g_financiero,str.empresa)
If idch_tipsocio.rowcount() < 1 then
	idch_tipsocio.InsertRow(0)
End If

dw_7.GetChild("tipo_auditor",idch_tipauditor)
idch_tipauditor.SetTransObject(Sqlca)
idch_tipauditor.Retrieve(str.g_financiero,str.empresa)
If idch_tipauditor.rowcount() < 1 then idch_tipauditor.InsertRow(0)

////--Datawindows externos por tipo
dw_4.settransobject(Sqlca)
dw_4.Insertrow(0)
dw_4.enabled = false

dw_6.settransobject(Sqlca)
dw_6.Insertrow(0)
dw_6.enabled = false

dw_7.settransobject(Sqlca)
dw_7.Insertrow(0)
dw_7.enabled = false

//------------------------

if dw_3.getitemstring(1,'op_estado') = 'P' then
	pb_3.enabled = true
	pb_4.enabled = true
else
	pb_3.enabled = false
	pb_4.enabled = false
end if

is_data = 'P'


dw_2.Dataobject = 'dw_cc_rango_cliente_nombre'
dw_2.Accepttext()

dw_3.PostEvent("clicked")
rb_3.PostEvent("clicked")

dw_2.ScrollToRow(dw_2.InsertRow(0))//DropDow de Clientes
dw_2.SetFocus()
dw_4.enabled = false

em_2.text = string(date(gf_fecha_serv()))

ddlb_tipo.text = 'OFICINA'
end event

event key;call super::key;
if key = keyenter! then
	if getfocus().typeof() = commandbutton! then getfocus().triggerevent(clicked!)
end if


if key = keyenter! then
	if getfocus().typeof() = picturebutton! then getfocus().triggerevent(clicked!)
end if

end event

event ue_post_open;call super::ue_post_open;em_2.text = string(date(gf_fecha_serv()))
string ls_sql

//ls_sql = 'dump tran HPSA with no_log'
//EXECUTE IMMEDIATE :ls_sql USING SQLCA;

this.SetRedraw ( True )
end event

type st_nom_ventana from w_cc_padre_rango_fecha`st_nom_ventana within w_cc_ranf_antig
boolean visible = false
integer x = 73
integer y = 1276
integer width = 91
integer height = 60
end type

type dw_1 from w_cc_padre_rango_fecha`dw_1 within w_cc_ranf_antig
integer x = 2697
integer y = 664
integer width = 279
integer taborder = 150
end type

type p_1 from w_cc_padre_rango_fecha`p_1 within w_cc_ranf_antig
boolean visible = false
integer x = 293
integer y = 1408
integer width = 73
integer height = 40
end type

type em_2 from w_cc_padre_rango_fecha`em_2 within w_cc_ranf_antig
integer x = 407
integer y = 468
integer width = 434
integer taborder = 120
end type

event em_2::losefocus;//
end event

type st_2 from w_cc_padre_rango_fecha`st_2 within w_cc_ranf_antig
integer x = 87
integer y = 472
integer width = 311
long textcolor = 15793151
long backcolor = 8421376
string text = "Hasta el :"
alignment alignment = right!
end type

type em_1 from w_cc_padre_rango_fecha`em_1 within w_cc_ranf_antig
boolean visible = false
integer x = 50
integer y = 1248
integer taborder = 60
end type

type st_1 from w_cc_padre_rango_fecha`st_1 within w_cc_ranf_antig
boolean visible = false
integer x = 1161
integer y = 1248
end type

type gb_1 from w_cc_padre_rango_fecha`gb_1 within w_cc_ranf_antig
boolean visible = false
integer x = 55
integer y = 1396
integer width = 1559
integer height = 380
string text = "Antiguedad Hasta"
end type

type st_7 from w_cc_padre_rango_fecha`st_7 within w_cc_ranf_antig
boolean visible = false
integer x = 1015
integer y = 1432
integer width = 402
end type

type cb_1 from w_cc_padre_rango_fecha`cb_1 within w_cc_ranf_antig
integer x = 997
integer y = 436
integer width = 443
integer height = 120
integer taborder = 140
integer textsize = -12
string pointer = "HyperLink!"
string text = "Procesar"
boolean default = false
end type

type pb_1 from w_cc_padre_rango_fecha`pb_1 within w_cc_ranf_antig
end type

type pb_2 from w_cc_padre_rango_fecha`pb_2 within w_cc_ranf_antig
end type

type gb_10 from groupbox within w_cc_ranf_antig
boolean visible = false
integer x = 398
integer y = 1268
integer width = 603
integer height = 488
integer taborder = 200
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
end type

type cbx_1 from checkbox within w_cc_ranf_antig
boolean visible = false
integer x = 2784
integer y = 548
integer width = 704
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Clientes sin Movimiento  "
end type

type gb_8 from groupbox within w_cc_ranf_antig
boolean visible = false
integer x = 2729
integer y = 740
integer width = 1211
integer height = 220
integer taborder = 130
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_3 from datawindow within w_cc_ranf_antig
event ue_postclick ( )
integer x = 114
integer y = 36
integer width = 507
integer height = 248
integer taborder = 80
boolean bringtotop = true
string dataobject = "dw_cc_externo_antiguedad"
boolean border = false
boolean livescroll = true
end type

event ue_postclick();string ls_null
setnull(ls_null)

is_data = this.getitemstring(this.getrow(),'op_estado')
pb_3.enabled = false
pb_4.enabled = false

dw_2.enabled = true

choose case is_data
	case 'C'//Por cliente 
		rb_3.enabled = true
		rb_4.enabled = true
		rb_5.enabled = true 
		rb_7.enabled = true
		rb_8.enabled = true
		rb_9.enabled = true
		rb_8.enabled = true
		rb_9.enabled = true
//		cbx_3.enabled = true
//		cbx_4.enabled = true
//		cbx_5.enabled = true
		
		if rb_3.checked = true then// is_tip_busca = 'S' then
			//dw_2.DataObject = 'dw_cc_rango_cliente_nombre'//codigo de cliente
			rb_3.TriggerEvent('clicked')
		elseif rb_4.checked = true then
			dw_2.DataObject = 'dw_cc_rango_cliente_referencia'
		elseif rb_5.checked = true then
			dw_2.DataObject = 'dw_cc_rango_cliente_ruc'
		else
			dw_2.DataObject = 'dw_cc_rango_cliente'
		end if

		if pos(Upper(str.empr_acceso_especial),'CORPINSA,') > 0 then
			dw_2.modify("desdecliente.dddw.name = 'dw_dd_cc_tercero_rango_al'")
			dw_2.modify("desdecliente.dddw.displaycolumn = 'union_item'")
			dw_2.modify("desdecliente.dddw.datacolumn = 'union_item'")

			dw_2.modify("hastacliente.dddw.name = 'dw_dd_cc_tercero_rango_al'")
			dw_2.modify("hastacliente.dddw.displaycolumn = 'union_item'")
			dw_2.modify("hastacliente.dddw.datacolumn = 'union_item'")
			
			dw_2.GetChild("desdecliente",idch_notercero)

			idch_notercero.SetTransObject(Sqlca)
			idch_notercero.Retrieve(str.g_financiero,str.empresa)
			
			If idch_notercero.rowcount() < 1 then
			idch_notercero.InsertRow(0)
			End If
			
			dw_2.GetChild("hastacliente",idch_notercero1)
			idch_notercero1.SetTransObject(Sqlca)
			idch_notercero1.Retrieve(str.g_financiero,str.empresa)
			If idch_notercero1.rowcount() < 1 then
			idch_notercero1.InsertRow(0)
			End If
			
		end if

		pb_3.enabled = true
		pb_4.enabled = true
		
		dw_2.Accepttext()
		dw_2.GetChild("desdecliente",idch_desdecliente)
		dw_2.GetChild("hastacliente",idch_hastacliente)
		
		idch_desdecliente.SetTransObject(Sqlca)
		idch_hastacliente.SetTransObject(Sqlca)
		
		If idch_desdecliente.Retrieve(str.g_financiero,str.empresa) < 1 Then idch_desdecliente.Insertrow(0)
		If idch_hastacliente.Retrieve(str.g_financiero,str.empresa) < 1 Then idch_hastacliente.Insertrow(0)
		
		dw_2.ScrollToRow(dw_2.InsertRow(0))
		dw_2.SetFocus()		
		
	case 'P'	// Por País
		rb_3.enabled = false
		rb_4.enabled = false
		rb_5.enabled = false
  		rb_7.enabled = true
 		rb_8.enabled = true
		rb_9.enabled = true
//		cbx_3.enabled = false
//		cbx_4.enabled = false
//		cbx_5.enabled = false

//		if is_pais_region = 'S' then
//			dw_2.DataObject = 'dw_cc_rango_pais_colegio'
//		else
			dw_2.DataObject = 'dw_cc_rango_pais'
//		end if
		dw_2.Accepttext()
		dw_2.GetChild("desdepais",idch_desdecliente)
		dw_2.GetChild("hastapais",idch_hastacliente)
		
		idch_desdecliente.SetTransObject(Sqlca)
		idch_hastacliente.SetTransObject(Sqlca)
		
		If idch_desdecliente.Retrieve() < 1 Then idch_desdecliente.Insertrow(0)
		If idch_hastacliente.Retrieve() < 1 Then idch_hastacliente.Insertrow(0)
		
		dw_2.ScrollToRow(dw_2.InsertRow(0))
		dw_2.SetFocus()
		
	case 'R'	// Por Región
		rb_3.enabled = false
		rb_4.enabled = false
		rb_5.enabled = false
		rb_7.enabled = true
		rb_8.enabled = true
		rb_9.enabled = true
//		cbx_3.enabled = false
//		cbx_4.enabled = false
//		cbx_5.enabled = false
		if is_pais_region = 'S' then
			dw_2.DataObject = 'dw_cc_rango_pais_region_colegio'
		else
			dw_2.DataObject = 'dw_cc_rango_pais_region'
		end if
		dw_2.Accepttext()
		dw_2.GetChild("desderegion",idch_desdecliente)
		dw_2.GetChild("hastaregion",idch_hastacliente)
		
		idch_desdecliente.SetTransObject(Sqlca)
		idch_hastacliente.SetTransObject(Sqlca)
		
		If idch_desdecliente.Retrieve(str.g_financiero) < 1 Then idch_desdecliente.Insertrow(0)
		If idch_hastacliente.Retrieve(str.g_financiero) < 1 Then idch_hastacliente.Insertrow(0)
		
		dw_2.ScrollToRow(dw_2.InsertRow(0))
		dw_2.SetFocus()		
  		
	case 'V'//Por Vendedor
		rb_3.enabled = false
		rb_4.enabled = false
		rb_5.enabled = false
		rb_7.enabled = true
		rb_8.enabled = true
		rb_9.enabled = true
//		cbx_3.enabled = false
//		cbx_4.enabled = false
//		cbx_5.enabled = false

		dw_2.DataObject = 'dw_cc_rango_vendedor'
		
		dw_2.Accepttext()
		dw_2.GetChild("desdevendedor",idch_desdecliente)
		dw_2.GetChild("hastavendedor",idch_hastacliente)
		
		idch_desdecliente.SetTransObject(Sqlca)
		idch_hastacliente.SetTransObject(Sqlca)
		
		If idch_desdecliente.Retrieve(str.g_financiero, str.empresa) < 1 Then idch_desdecliente.Insertrow(0)
		If idch_hastacliente.Retrieve(str.g_financiero, str.empresa) < 1 Then idch_hastacliente.Insertrow(0)
		
		dw_2.ScrollToRow(dw_2.InsertRow(0))
		dw_2.SetFocus()		
		
	case 'T'//Todos
		rb_6.checked = true
		rb_3.enabled = false
		rb_4.enabled = false
		rb_5.enabled = false
		rb_7.enabled = false
		rb_8.enabled = false
		rb_9.enabled = false
//		cbx_3.enabled = false
//		cbx_4.enabled = false
//		cbx_5.enabled = false
		
		dw_4.reset()
		dw_4.insertrow(0)
		dw_4.enabled = false
		
		dw_2.reset()
		dw_2.ScrollToRow(dw_2.InsertRow(0))
		dw_2.enabled = false
		
	// Gianni Araúz (28/12/2000). Habilitar y deshabiliar las opciones necesarios cuando el
	// reporte es el de Resumido por País.
	case 'A'	// Resumido por por País
		rb_3.enabled = false
		rb_4.enabled = false
		rb_5.enabled = false
		rb_6.enabled = true
		rb_6.checked = true
  		rb_7.enabled = false
 		rb_8.enabled = false
		rb_9.enabled = false
	
		if is_pais_region = 'S' then
			dw_2.DataObject = 'dw_cc_rango_pais_colegio'
		else
			dw_2.DataObject = 'dw_cc_rango_pais'
		end if
		
		dw_2.Accepttext()
		dw_2.GetChild("desdepais",idch_desdecliente)
		dw_2.GetChild("hastapais",idch_hastacliente)
		
		idch_desdecliente.SetTransObject(Sqlca)
		idch_hastacliente.SetTransObject(Sqlca)
		
		If idch_desdecliente.Retrieve() < 1 Then idch_desdecliente.Insertrow(0)
		If idch_hastacliente.Retrieve() < 1 Then idch_hastacliente.Insertrow(0)
		
		dw_2.ScrollToRow(dw_2.InsertRow(0))
		dw_2.SetFocus()
		
	// Gianni Araúz (28/12/2000). Habilitar y deshabiliar las opciones necesarios cuando el
	// reporte es el de Resumido por País-Región.
	case 'E'	// Resumido por Región
		rb_3.enabled = false
		rb_4.enabled = false
		rb_5.enabled = false

		rb_6.enabled = true
		rb_6.checked = true
		rb_7.enabled = false
		rb_8.enabled = false
		rb_9.enabled = false
//		cbx_3.enabled = false
//		cbx_4.enabled = false
//		cbx_5.enabled = false
		if is_pais_region = 'S' then
			dw_2.DataObject = 'dw_cc_rango_pais_region_colegio'
		else
			dw_2.DataObject = 'dw_cc_rango_pais_region'
		end if
		dw_2.Accepttext()
		dw_2.GetChild("desderegion",idch_desdecliente)
		dw_2.GetChild("hastaregion",idch_hastacliente)
		
		idch_desdecliente.SetTransObject(Sqlca)
		idch_hastacliente.SetTransObject(Sqlca)
		
		If idch_desdecliente.Retrieve(str.g_financiero) < 1 Then idch_desdecliente.Insertrow(0)
		If idch_hastacliente.Retrieve(str.g_financiero) < 1 Then idch_hastacliente.Insertrow(0)
		
		dw_2.ScrollToRow(dw_2.InsertRow(0))
		dw_2.SetFocus()		
end choose

end event

event clicked;this.AcceptText()
this.postevent("ue_postclick")

end event

type pb_3 from picturebutton within w_cc_ranf_antig
boolean visible = false
integer x = 1143
integer y = 1252
integer width = 137
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\harr2000\art\buscar_vinocular.bmp"
string disabledname = "\harr2000\art\buscar_vinocular.bmp"
alignment htextalign = right!
end type

event clicked;integer li_reg
long    ll_tercero
String  ls_find,ls_fac1,ls_fac2, ls_ruc, ls_ref_ant, ls_descripcion
str_dg_dynamic_find	lstr_df

if pos(Upper(str.empr_acceso_especial),'CORPINSA,') > 0 then
		lstr_df.texto_campo [1,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [1,2] = "Descripción"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '650'

		lstr_df.texto_campo [2,1] = "almproyecto.mproy_descripcion"
		lstr_df.texto_campo [2,2] = "Proyecto"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '600'

		lstr_df.texto_campo [3,1] = "clie_ref_anterior"
		lstr_df.texto_campo [3,2] = "Cód. Anterior"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'

		lstr_df.texto_campo [4,1] = "terc_tercero"
		lstr_df.texto_campo [4,2] = "Código"
		lstr_df.texto_campo [4,3] = "terc_tercero"
		lstr_df.texto_campo [4,4] = 'V'

		lstr_df.texto_campo [5,1] = "clie_ruc_tercero"
		lstr_df.texto_campo [5,2] = "RUC Cliente"
		lstr_df.texto_campo [5,3] = ""
		lstr_df.texto_campo [5,4] = 'V'

		lstr_df.tabla = " ccmclien, dgmterce, almproyecto  "
		lstr_df.tabla_where = + &
		"WHERE ( terc_tercero = clie_tercero ) and  " +&
		"( clie_g_financiero = " + string(str.g_financiero) + ") and " + &
		"( clie_empresa = " + string(str.empresa)+") AND "+ &
		"( ccmclien.clie_estado in ('A', 'AC') ) AND"+ & 
		"( ccmclien.clie_mg_cuenta <> NULL ) and " +&
		"(ccmclien.clie_proyecto *= almproyecto.mproy_proyecto)"  
else
		lstr_df.texto_campo [1,1] = "clie_ruc_tercero"
		lstr_df.texto_campo [1,2] = "RUC Cliente"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		
		lstr_df.texto_campo [2,1] = "terc_descripcion"
		lstr_df.texto_campo [2,2] = "Descripción"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		
		lstr_df.texto_campo [3,1] = "clie_ref_anterior"
		lstr_df.texto_campo [3,2] = "Cód. Cliente"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		
		lstr_df.texto_campo [4,1] = "terc_tercero"
		lstr_df.texto_campo [4,2] = "Tercero"
		lstr_df.texto_campo [4,3] = "terc_tercero"
		lstr_df.texto_campo [4,4] = 'V'
		
		lstr_df.tabla = " ccmclien, dgmterce "
		lstr_df.tabla_where = + &
		"WHERE ( terc_tercero = clie_tercero ) and  " +&
		"( clie_g_financiero = " + string(str.g_financiero) + ") and " + &
		"( clie_empresa = " + string(str.empresa)+") AND "+ &
		"( ccmclien.clie_estado in ('A', 'AC') ) AND"+ & 
		"( ccmclien.clie_mg_cuenta <> NULL ) "   
end if

OpenWithParm(w_dg_a_custom_find, lstr_df)
ls_find = Message.StringParm
idch_notercero.retrieve(str.g_financiero, str.empresa)

If idch_notercero.rowcount() < 1 then
	idch_notercero.InsertRow(0)
End If

If len (ls_find) 	= 0 Then Return

li_reg 				= idch_notercero.Find( ls_find, 1, idch_notercero.rowcount())

//li_reg 				= idch_desdecliente.Find( ls_find, 1, idch_desdecliente.rowcount()	 )

if idch_notercero.rowcount() > 0 then
	ll_tercero	 		= idch_notercero.getitemnumber(li_reg,'terc_tercero'					 ) 
	ls_ref_ant			= idch_notercero.getitemstring(li_reg,'ccmclien_clie_ref_anterior' ) 
	ls_ruc            = idch_notercero.getitemstring(li_reg,'ccmclien_clie_ruc_tercero' ) 
	ls_descripcion    = idch_notercero.getitemstring(li_reg,'terc_descripcion' ) 
end if
idch_notercero.ScrollToRow (li_reg)

if rb_3.checked = true then
	dw_2.setitem(dw_2.getrow(),'desdecliente', ls_descripcion+string(ll_tercero))
	dw_2.setitem(dw_2.getrow(),'hastacliente', ls_descripcion+string(ll_tercero))
elseif rb_4.checked = true then
	dw_2.setitem(dw_2.getrow(),'desdecliente', ls_ref_ant	)
	dw_2.setitem(dw_2.getrow(),'hastacliente', ls_ref_ant	)
elseif rb_5.checked = true then
	dw_2.setitem(dw_2.getrow(),'desdecliente', ls_ruc)
	dw_2.setitem(dw_2.getrow(),'hastacliente', ls_ruc)
end if
dw_2.accepttext()

end event

type pb_4 from picturebutton within w_cc_ranf_antig
boolean visible = false
integer x = 1147
integer y = 1372
integer width = 137
integer height = 100
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\harr2000\art\buscar_vinocular.bmp"
string disabledname = "\harr2000\art\buscar_vinocular.bmp"
alignment htextalign = right!
end type

event clicked;integer li_reg
long    ll_tercero
String  ls_find,ls_fac1,ls_fac2, ls_ruc, ls_ref_ant, ls_descripcion
str_dg_dynamic_find	lstr_df

if pos(Upper(str.empr_acceso_especial),'CORPINSA,') > 0 then
		lstr_df.texto_campo [1,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [1,2] = "Descripción"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '650'

		lstr_df.texto_campo [2,1] = "almproyecto.mproy_descripcion"
		lstr_df.texto_campo [2,2] = "Proyecto"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '600'

		lstr_df.texto_campo [3,1] = "clie_ref_anterior"
		lstr_df.texto_campo [3,2] = "Cód. Anterior"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'

		lstr_df.texto_campo [4,1] = "terc_tercero"
		lstr_df.texto_campo [4,2] = "Código"
		lstr_df.texto_campo [4,3] = "terc_tercero"
		lstr_df.texto_campo [4,4] = 'V'

		lstr_df.texto_campo [5,1] = "clie_ruc_tercero"
		lstr_df.texto_campo [5,2] = "RUC Cliente"
		lstr_df.texto_campo [5,3] = ""
		lstr_df.texto_campo [5,4] = 'V'

		lstr_df.tabla = " ccmclien, dgmterce, almproyecto  "
		lstr_df.tabla_where = + &
		"WHERE ( terc_tercero = clie_tercero ) and  " +&
		"( clie_g_financiero = " + string(str.g_financiero) + ") and " + &
		"( clie_empresa = " + string(str.empresa)+") AND "+ &
		"( ccmclien.clie_estado in ('A', 'AC') ) AND"+ & 
		"( ccmclien.clie_mg_cuenta <> NULL ) and " +&
		"(ccmclien.clie_proyecto *= almproyecto.mproy_proyecto)"  
else
		lstr_df.texto_campo [1,1] = "clie_ruc_tercero"
		lstr_df.texto_campo [1,2] = "RUC Cliente"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		
		lstr_df.texto_campo [2,1] = "terc_descripcion"
		lstr_df.texto_campo [2,2] = "Descripción"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		
		lstr_df.texto_campo [3,1] = "clie_ref_anterior"
		lstr_df.texto_campo [3,2] = "Cód. Cliente"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		
		lstr_df.texto_campo [4,1] = "terc_tercero"
		lstr_df.texto_campo [4,2] = "Tercero"
		lstr_df.texto_campo [4,3] = "terc_tercero"
		lstr_df.texto_campo [4,4] = 'V'
		
		lstr_df.tabla = " ccmclien, dgmterce "
		lstr_df.tabla_where = + &
		"WHERE ( terc_tercero = clie_tercero ) and  " +&
		"( clie_g_financiero = " + string(str.g_financiero) + ") and " + &
		"( clie_empresa = " + string(str.empresa)+") AND "+ &
		"( ccmclien.clie_estado in ('A', 'AC') ) AND"+ & 
		"( ccmclien.clie_mg_cuenta <> NULL ) "   
end if

		  
OpenWithParm(w_dg_a_custom_find, lstr_df)
ls_find = Message.StringParm
idch_notercero.retrieve(str.g_financiero, str.empresa)
If idch_notercero.rowcount() < 1 then
	idch_notercero.InsertRow(0)
End If


If len (ls_find) 	= 0 Then Return

li_reg 				= idch_notercero.Find( ls_find, 1, idch_notercero.rowcount())
if idch_notercero.rowcount() > 0 then
	ll_tercero	 		= idch_notercero.getitemnumber(li_reg,'terc_tercero'					 ) 
	ls_ref_ant			= idch_notercero.getitemstring(li_reg,'ccmclien_clie_ref_anterior' ) 
	ls_ruc            = idch_notercero.getitemstring(li_reg,'ccmclien_clie_ruc_tercero' ) 
	ls_descripcion    = idch_notercero.getitemstring(li_reg,'terc_descripcion' ) 
end if
idch_notercero.ScrollToRow (li_reg)

if rb_3.checked = true then
	
	dw_2.setitem(dw_2.getrow(),'hastacliente', ls_descripcion+string(ll_tercero))
elseif rb_4.checked = true then
	
	dw_2.setitem(dw_2.getrow(),'hastacliente', ls_ref_ant	)
elseif rb_5.checked = true then
	
	dw_2.setitem(dw_2.getrow(),'hastacliente', ls_ruc)
end if
dw_2.accepttext()

end event

type gb_9 from groupbox within w_cc_ranf_antig
boolean visible = false
integer x = 2747
integer y = 492
integer width = 1211
integer height = 212
integer taborder = 190
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type rb_3 from radiobutton within w_cc_ranf_antig
boolean visible = false
integer x = 448
integer y = 1236
integer width = 485
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = " Alfabéticamente"
boolean checked = true
end type

event clicked;integer  li_tipo
cb_1.Default= false

dw_2.Dataobject = 'dw_cc_rango_cliente_nombre'

if pos(Upper(str.empr_acceso_especial),'CORPINSA,') > 0 then
	dw_2.modify("desdecliente.dddw.name = 'dw_dd_cc_tercero_rango_al'")
	dw_2.modify("desdecliente.dddw.displaycolumn = 'union_item'")
	dw_2.modify("desdecliente.dddw.datacolumn = 'union_item'")

	dw_2.modify("hastacliente.dddw.name = 'dw_dd_cc_tercero_rango_al'")
	dw_2.modify("hastacliente.dddw.displaycolumn = 'union_item'")
	dw_2.modify("hastacliente.dddw.datacolumn = 'union_item'")
end if

dw_2.Accepttext()
dw_2.GetChild("desdecliente",idch_notercero)
idch_notercero.SetTransObject(Sqlca)
idch_notercero.Retrieve(str.g_financiero,str.empresa)
If idch_notercero.rowcount() < 1 then
	idch_notercero.InsertRow(0)
End If

dw_2.GetChild("hastacliente",idch_notercero1)
idch_notercero1.SetTransObject(Sqlca)
idch_notercero1.Retrieve(str.g_financiero,str.empresa)
If idch_notercero1.rowcount() < 1 then
	idch_notercero1.InsertRow(0)
End If

//dw_3.insertRow(1)//Datawindow externo de opciones
dw_2.ScrollToRow(dw_2.InsertRow(0))//DropDow de Clientes
dw_2.SetFocus()

if dw_4.rowcount() > 0 then
	li_tipo = dw_4.getitemnumber(1,'tipo_cliente')

	if not isnull(li_tipo) then
		idch_notercero.Setfilter("clie_clasificacion ="+ string(li_tipo))
		idch_notercero.Filter()
		idch_notercero1.Setfilter("clie_clasificacion ="+ string(li_tipo))
		idch_notercero1.Filter()
	end if
end if

idch_notercero.Setsort('cliente A')
idch_notercero.sort()
idch_notercero1.Setsort('cliente A')
idch_notercero1.sort()


end event

type rb_4 from radiobutton within w_cc_ranf_antig
boolean visible = false
integer x = 439
integer y = 1448
integer width = 539
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Por Nº de Cliente"
end type

event clicked;integer  li_tipo
cb_1.Default= false

dw_2.Dataobject = 'dw_cc_rango_cliente_referencia'
if pos(Upper(str.empr_acceso_especial),'CORPINSA,') > 0 then
	dw_2.modify("desdecliente.dddw.name = 'dw_dd_cc_tercero_rango_al'")
	dw_2.modify("desdecliente.dddw.displaycolumn = 'union_item'")
	dw_2.modify("desdecliente.dddw.datacolumn = 'ccmclien_clie_ref_anterior'")

	dw_2.modify("hastacliente.dddw.name = 'dw_dd_cc_tercero_rango_al'")
	dw_2.modify("hastacliente.dddw.displaycolumn = 'union_item'")
	dw_2.modify("hastacliente.dddw.datacolumn = 'ccmclien_clie_ref_anterior'")
end if

dw_2.Accepttext()
dw_2.GetChild("desdecliente",idch_notercero)
idch_notercero.SetTransObject(Sqlca)
idch_notercero.Retrieve(str.g_financiero,str.empresa)

If idch_notercero.rowcount() < 1 then
	idch_notercero.InsertRow(0)
End If

dw_2.GetChild("hastacliente",idch_notercero1)
idch_notercero1.SetTransObject(Sqlca)
idch_notercero1.Retrieve(str.g_financiero,str.empresa)
If idch_notercero1.rowcount() < 1 then
	idch_notercero1.InsertRow(0)
End If

//dw_3.insertRow(1)//Datawindow externo de opciones
dw_2.ScrollToRow(dw_2.InsertRow(0))//DropDow de Clientes
dw_2.SetFocus()

if dw_4.rowcount() > 0 then
	li_tipo = dw_4.getitemnumber(1,'tipo_cliente')
	if not isnull(li_tipo) then
		idch_notercero.Setfilter("clie_clasificacion ="+ string(li_tipo))
		idch_notercero.Filter()
		idch_notercero1.Setfilter("clie_clasificacion ="+ string(li_tipo))
		idch_notercero1.Filter()
	end if
end if

idch_notercero.Setsort('ccmclien_clie_ref_anterior A')
idch_notercero.sort()
idch_notercero1.Setsort('ccmclien_clie_ref_anterior A')
idch_notercero1.sort()











end event

type rb_5 from radiobutton within w_cc_ranf_antig
boolean visible = false
integer x = 439
integer y = 1248
integer width = 535
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Por RUC del Cliente  "
end type

event clicked;integer li_tipo
cb_1.Default= false

dw_2.Dataobject = 'dw_cc_rango_cliente_ruc'

if pos(Upper(str.empr_acceso_especial),'CORPINSA,') > 0 then
	dw_2.modify("desdecliente.dddw.name = 'dw_dd_cc_tercero_rango_al'")
	dw_2.modify("desdecliente.dddw.displaycolumn = 'union_item'")
	dw_2.modify("desdecliente.dddw.datacolumn = 'ccmclien_clie_ruc_tercero'")

	dw_2.modify("hastacliente.dddw.name = 'dw_dd_cc_tercero_rango_al'")
	dw_2.modify("hastacliente.dddw.displaycolumn = 'union_item'")
	dw_2.modify("hastacliente.dddw.datacolumn = 'ccmclien_clie_ruc_tercero'")
end if

dw_2.Accepttext()
dw_2.GetChild("desdecliente",idch_notercero)
idch_notercero.SetTransObject(Sqlca)
idch_notercero.Retrieve(str.g_financiero,str.empresa)
If idch_notercero.rowcount() < 1 then
	idch_notercero.InsertRow(0)
End If

dw_2.GetChild("hastacliente",idch_notercero1)
idch_notercero1.SetTransObject(Sqlca)
idch_notercero1.Retrieve(str.g_financiero,str.empresa)
If idch_notercero1.rowcount() < 1 then
	idch_notercero1.InsertRow(0)
End If


//dw_3.insertRow(1)//Datawindow externo de opciones
dw_2.ScrollToRow(dw_2.InsertRow(0))//DropDow de Clientes
dw_2.SetFocus()

if dw_4.rowcount() > 0 then
	li_tipo = dw_4.getitemnumber(1,'tipo_cliente')
	if not isnull(li_tipo) then
		idch_notercero.Setfilter("clie_clasificacion ="+ string(li_tipo))
		idch_notercero.Filter()
		idch_notercero1.Setfilter("clie_clasificacion ="+ string(li_tipo))
		idch_notercero1.Filter()
	end if
end if

idch_notercero.Setsort('ccmclien_clie_ruc_tercero A')
idch_notercero.sort()
idch_notercero1.Setsort('ccmclien_clie_ruc_tercero A')
idch_notercero1.sort()
end event

type rb_6 from radiobutton within w_cc_ranf_antig
boolean visible = false
integer x = 2359
integer y = 1420
integer width = 238
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Todos"
boolean checked = true
end type

event clicked;dw_4.reset()
dw_4.insertrow(0)
dw_4.enabled = false
		
idch_desdecliente.Setfilter("")
idch_desdecliente.Filter()
idch_hastacliente.Setfilter("")
idch_hastacliente.Filter()

idch_desdecliente.Setsort('cliente A')
idch_desdecliente.sort()
idch_hastacliente.Setsort('cliente A')
idch_hastacliente.sort()
end event

type rb_7 from radiobutton within w_cc_ranf_antig
boolean visible = false
integer x = 2359
integer y = 1504
integer width = 192
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo"
end type

event clicked;dw_4.enabled = true
//dw_2.reset()
//dw_2.insertRow(0)
end event

type dw_4 from datawindow within w_cc_ranf_antig
boolean visible = false
integer x = 2615
integer y = 1492
integer width = 777
integer height = 80
integer taborder = 90
boolean bringtotop = true
string dataobject = "dw_cc_ext_tipo_cliente"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;integer  li_data, li_null
li_data = integer(data)
setnull(li_null)

dw_6.setitem(1,'tipo_socio',li_null)
dw_7.setitem(1,'tipo_auditor',li_null)

if dw_3.getitemstring(1,'op_estado') = 'C' then
	dw_3.TriggerEvent('ue_postclick')

	idch_desdecliente.Setfilter("clie_clasificacion ="+ string(li_data))
	idch_desdecliente.Filter()
	idch_hastacliente.Setfilter("clie_clasificacion ="+ string(li_data))
	idch_hastacliente.Filter()
end if







end event

type cbx_2 from checkbox within w_cc_ranf_antig
boolean visible = false
integer x = 2784
integer y = 612
integer width = 576
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Mostrar Ceros"
boolean checked = true
end type

type dw_2 from datawindow within w_cc_ranf_antig
event ue_enter pbm_dwnkey
integer x = 768
integer y = 76
integer width = 1070
integer height = 200
integer taborder = 180
string dataobject = "dw_cc_rango_cliente"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_enter;//string  ls_nom_columna
//long    ll_num_max_col, ll_tab_order
//integer li_cuenta
//
//ls_nom_columna = GetColumnName()
//ll_num_max_col = long(this.object.datawindow.column.count)
//ll_tab_order = long(this.Describe(ls_nom_columna + ".TabSequence"))
//
////messagebox("",ls_nom_columna+', '+string(ll_num_max_col)+', '+string(ll_tab_order))
//for li_cuenta = 1 to  ll_num_max_col 
//	if ll_tab_order = 10 then 
//		this.setcolumn(2)
//	elseif ll_tab_order = 20 then 
//		cb_1.Setfocus()
//		cb_1.Default = true
//	end if
//	ll_tab_order = long(this.Describe(ls_nom_columna + ".TabSequence"))
//	
//next
end event

event itemchanged;accepttext()

string ls_codigo_ant
datawindowchild dwch_cliente, dwch_cliente1


CHOOSE CASE dwo.name
	CASE 'desdecliente'
		
		this.getchild('desdecliente', dwch_cliente)
		if is_busqueda = 'S' then
			ls_codigo_ant = dwch_cliente.getitemstring(dwch_cliente.getrow(),'ccmclien_clie_ref_anterior')
	   else
			ls_codigo_ant = dwch_cliente.getitemstring(dwch_cliente.getrow(),'ccmclien_clie_ruc_tercero')
		end if


		this.setitem(this.getrow(),'desdecliente', data )		
		this.setitem(this.getrow(),'hastacliente', data )		
		
	CASE 'hastacliente'
		this.getchild('hastacliente', dwch_cliente)
		if is_busqueda = 'S' then
			ls_codigo_ant = dwch_cliente.getitemstring(dwch_cliente.getrow(),'ccmclien_clie_ref_anterior')
	   else
			ls_codigo_ant = dwch_cliente.getitemstring(dwch_cliente.getrow(),'ccmclien_clie_ruc_tercero')
		end if

		
	CASE 'desdeempre'
		this.getchild('desdeempre', dwch_cliente)
		ls_codigo_ant = string(dwch_cliente.getitemnumber(dwch_cliente.getrow(),'empr_empresa'))
	   
		this.setitem(this.getrow(),'hastaempre', long(data) )

	CASE 'desdegrupo'
		this.getchild('desdegrupo', dwch_cliente)
		
		ls_codigo_ant = string(dwch_cliente.getitemnumber(dwch_cliente.getrow(),'grup_g_financiero'))
	   this.setitem(this.getrow(),'hastagrupo', long(data) )

   CASE 'desdepais'
		this.getchild('desdepais', dwch_cliente)
		
		ls_codigo_ant = string(dwch_cliente.getitemnumber(dwch_cliente.getrow(),'pais_pais'))
	   this.setitem(this.getrow(),'hastapais', long(data) )
	CASE 'desderegion'
		
		this.getchild('desderegion', dwch_cliente)
		dwch_cliente.accepttext()
		ls_codigo_ant = string(dwch_cliente.getitemnumber(dwch_cliente.getrow(),'dgaregio_regi_codigo_region'))
	 //  messagebox('',ls_codigo_ant)
		this.setitem(this.getrow(),'desderegion', long(ls_codigo_ant) )	
		this.setitem(this.getrow(),'hastaregion', long(ls_codigo_ant) )	
		
//em_3.postevent('modified')
END CHOOSE

end event

event constructor;dw_2.ScrollToRow(dw_2.InsertRow(0))
dw_2.SetFocus()
this.enabled = false
end event

type dw_5 from datawindow within w_cc_ranf_antig
integer x = 489
integer y = 336
integer width = 571
integer height = 92
integer taborder = 140
boolean bringtotop = true
string title = "none"
string dataobject = "dw_cc_ext_balance"
boolean border = false
boolean livescroll = true
end type

type st_9 from statictext within w_cc_ranf_antig
integer x = 69
integer y = 352
integer width = 421
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Mostrar Saldo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_8 from radiobutton within w_cc_ranf_antig
boolean visible = false
integer x = 2359
integer y = 1608
integer width = 238
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Socio"
end type

event clicked;dw_6.enabled = true
end event

type rb_9 from radiobutton within w_cc_ranf_antig
boolean visible = false
integer x = 2359
integer y = 1696
integer width = 256
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Auditor"
end type

event clicked;dw_7.enabled = true
end event

type dw_6 from datawindow within w_cc_ranf_antig
boolean visible = false
integer x = 2615
integer y = 1584
integer width = 777
integer height = 80
integer taborder = 210
boolean bringtotop = true
string title = "none"
string dataobject = "dw_cc_ext_socio"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;integer  li_data, li_null
li_data = integer(data)
setnull(li_null)

dw_4.setitem(1,'tipo_cliente',li_null)
dw_7.setitem(1,'tipo_auditor',li_null)

if dw_3.getitemstring(1,'op_estado') = 'C' then
	dw_3.TriggerEvent('ue_postclick')

	idch_desdecliente.Setfilter("clie_socio ="+ string(li_data))
	idch_desdecliente.Filter()
	idch_hastacliente.Setfilter("clie_socio ="+ string(li_data))
	idch_hastacliente.Filter()
end if
end event

type dw_7 from datawindow within w_cc_ranf_antig
boolean visible = false
integer x = 2615
integer y = 1676
integer width = 777
integer height = 80
integer taborder = 220
boolean bringtotop = true
string title = "none"
string dataobject = "dw_cc_ext_auditor"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;integer  li_data, li_null
li_data = integer(data)
setnull(li_null)

dw_4.setitem(1,'tipo_cliente',li_null)
dw_6.setitem(1,'tipo_socio',li_null)

if dw_3.getitemstring(1,'op_estado') = 'C' then
	dw_3.TriggerEvent('ue_postclick')

	idch_desdecliente.Setfilter("clie_auditor ="+ string(li_data))
	idch_desdecliente.Filter()
	idch_hastacliente.Setfilter("clie_auditor ="+ string(li_data))
	idch_hastacliente.Filter()
end if
end event

type cbx_3 from checkbox within w_cc_ranf_antig
boolean visible = false
integer x = 3301
integer y = 612
integer width = 576
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Alias"
boolean checked = true
end type

type cb_2 from commandbutton within w_cc_ranf_antig
integer x = 1486
integer y = 436
integer width = 425
integer height = 116
integer taborder = 150
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Cerrar"
end type

event clicked;close(parent)
end event

type calendario2 from picture within w_cc_ranf_antig
integer x = 841
integer y = 468
integer width = 69
integer height = 84
boolean bringtotop = true
string picturename = "C:\Sistemas\Hymsoft\Art\ddfec.bmp"
boolean focusrectangle = false
end type

event clicked;date 	ld_date,ld_ini_date, ld_hoy
parent.height = 1300

	ld_ini_date=date(em_2.text)
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

end event

type uo_2 from u_ddcalen within w_cc_ranf_antig
boolean visible = false
integer x = 187
integer y = 568
integer taborder = 70
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;em_2.text = string(uo_2.return_sel_date())

if uo_2.allow_close then
	this.visible=false
	em_2.SetFocus()
	parent.height = 765
end if


end event

on uo_2.destroy
call u_ddcalen::destroy
end on

type hpb_barra from hprogressbar within w_cc_ranf_antig
boolean visible = false
integer x = 64
integer y = 772
integer width = 1641
integer height = 88
boolean bringtotop = true
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

type st_100 from statictext within w_cc_ranf_antig
boolean visible = false
integer x = 1710
integer y = 780
integer width = 283
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type ddlb_tipo from dropdownlistbox within w_cc_ranf_antig
integer x = 704
integer y = 608
integer width = 617
integer height = 480
integer taborder = 200
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string item[] = {"OFICINA","BANCOS"}
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_cc_ranf_antig
integer x = 91
integer y = 620
integer width = 576
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 8421376
string text = "Tipo Antiguedad:"
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_cc_ranf_antig
integer x = 718
integer y = 20
integer width = 1161
integer height = 292
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 8421376
string text = "Seleccione el Rango"
end type

