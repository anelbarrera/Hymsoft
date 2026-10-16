forward
global type w_mant_clientes from w_grampa_tab
end type
type dw_5 from datawindow within tabpage_1
end type
type pb_pdf from picturebutton within tabpage_1
end type
type dw_4 from datawindow within tabpage_2
end type
type cb_2 from commandbutton within tabpage_2
end type
type cb_1 from commandbutton within tabpage_2
end type
type pb_1 from picturebutton within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type pb_mala from picturebutton within tabpage_2
end type
type st_texto_cuenta_mala from statictext within tabpage_2
end type
type st_1 from statictext within w_mant_clientes
end type
type pb_top from picturebutton within w_mant_clientes
end type
type pb_back from picturebutton within w_mant_clientes
end type
type pb_next from picturebutton within w_mant_clientes
end type
type pb_bottom from picturebutton within w_mant_clientes
end type
end forward

global type w_mant_clientes from w_grampa_tab
integer width = 2542
integer height = 2092
string title = "Mantenimiento de Clientes"
boolean controlmenu = false
long backcolor = 12639424
windowanimationstyle openanimation = bottomslide!
windowanimationstyle closeanimation = fadeanimation!
st_1 st_1
pb_top pb_top
pb_back pb_back
pb_next pb_next
pb_bottom pb_bottom
end type
global w_mant_clientes w_mant_clientes

type variables
datawindow idw_1, idw_2, idw_3, idw_5
datawindowchild idwc_region, idwc_tipo, idwc_provincia, idwc_distrito, idwc_corregimiento
window iw_window
integer il_tab_activo
boolean ib_cerrar
string is_user, is_cuenta
str_rangofecha istr_rangfech, lstr_rangfech
end variables

forward prototypes
public function boolean wf_asigna_antig ()
public function boolean wf_antiguedad ()
public function boolean wf_actualiza_antiguedad (datetime adt_desde, datetime adt_hasta, long al_tercero)
public subroutine wf_setear_user (string as_user)
public function boolean wf_cambiar_limite ()
public subroutine wf_actualiza_antiguedad (string idioma)
public function boolean wf_grabar_cliente (datawindow adw_1, long fila)
end prototypes

public function boolean wf_asigna_antig ();string ls_error

  DELETE FROM ccatpan  
   WHERE ( ccatpan.tpan_g_financiero = :str.g_financiero ) AND  
         ( ccatpan.tpan_empresa = :str.empresa ) AND  
         ( ccatpan.tpan_maquina = :str.maquina )   ;
	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje('Aviso','Error al eliminar ccatpan',ls_error)
		return false
	end if
	
	/* Inserta los nuevos valores */ 
  INSERT INTO ccatpan  
         ( tpan_g_financiero,tpan_empresa,tpan_tercero,tpan_saldo_anterior,
           tpan_col1,tpan_col2, tpan_col3,tpan_col4,tpan_col5,tpan_col6,   
           tpan_col7,tpan_col8,  tpan_col9, tpan_col10,tpan_col11,tpan_col12, 
           tpan_col13,tpan_col21,tpan_col1_t,tpan_col2_t,tpan_col3_t,   
           tpan_col4_t, tpan_col5_t,tpan_col6_t,tpan_col7_t,tpan_col8_t,   
           tpan_col9_t,tpan_col10_t,tpan_col11_t,tpan_col12_t,tpan_col13_t,
           tpan_col21_t,tpan_maquina)   
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
	return false
else	
	commit ; 
	//mensaje('','Inserto en CCATPAN','')
	
end if

return true
end function

public function boolean wf_antiguedad ();long ll_tercero
datetime ld_tiempo1, ld_tiempo2, ldt_fecha
date		ldt_fecha_desde, ldt_fecha_hasta
ldt_fecha = gf_fecha_serv()
ldt_fecha_hasta = date(ldt_fecha)
ldt_fecha_desde = relativedate(date(gf_fecha_serv()), - 365)
ld_tiempo1 = Datetime(ldt_fecha_desde,00:00:00)
ld_tiempo2 = Datetime(ldt_fecha_hasta,00:00:00)
str.frame.setmicrohelp('Configurando la Antiguedad')
ll_tercero = idw_1.getitemnumber(1,'terc_tercero')
wf_actualiza_antiguedad(ld_tiempo1, ld_tiempo2, ll_tercero)
str.frame.setmicrohelp('Asignando Valores al Formato')
wf_asigna_antig()			
tab_1.tabpage_2.dw_4.retrieve(str.g_financiero, str.empresa, ll_tercero, str.maquina)
return true
end function

public function boolean wf_actualiza_antiguedad (datetime adt_desde, datetime adt_hasta, long al_tercero);
Integer  li_registros, li_i, li_empresa, li_grupofin, li_emp, li_dberror, &
         li_tipo, li_socio, li_audit
decimal  ld_x, ld_y, ld_monto
string   ls_db_err,ls_where_select, ls_error,ls_error_proc
long 		ll_tercero,ll_i,ll_proximo
Datetime ld_tiempo1, ld_tiempo2

DELETE FROM ccatempa
WHERE ( ccatempa.tmpa_g_financiero 	= :str.g_financiero 	) AND  
      ( ccatempa.tmpa_empresa 		= :str.empresa 		) and
		( ccatempa.tmpa_usuario_maquina = :str.maquina 		) ;
if sqlca.sqlcode = -1 then
	messagebox('error','error al elimianr registros desde ccatempa')
end if

//datastore	lds_tercero_empresa, lds_tercero_gf,lds_cliente, lds_tercero_pais
Datawindowchild ldwc_sub_tran, ldwc_pais, ldwc_region

ld_tiempo1 = adt_desde
ld_tiempo2 = adt_hasta

ll_tercero = al_tercero
				
if ll_tercero = 99999 then
	gf_antiguedad_x_cliente_elbros(ld_tiempo2, ll_tercero,'E',ld_tiempo1)
else
	gf_antiguedad_x_cliente(ld_tiempo2, ll_tercero,'E',ld_tiempo1)
end if

return true
end function

public subroutine wf_setear_user (string as_user);//Asigno el Usuario a la Variable de Instancia
is_user = as_user
end subroutine

public function boolean wf_cambiar_limite ();//Solicita la clave para cambiar el limite del credito

OpenWithParm(w_clave_autorizada, this)

If is_user = "*" then
	idw_2.setitem(1,'cambiar_limite',0)
else
	idw_2.setitem(1,'cambiar_limite',1)
end if

idw_2.accepttext()
idw_2.setcolumn('ccmclien_clie_limite_credito')

return true

end function

public subroutine wf_actualiza_antiguedad (string idioma);Integer  li_registros, li_i, li_empresa, li_grupofin, li_emp, li_dberror, &
         li_tipo, li_socio, li_audit
decimal  ld_x, ld_y, ld_monto
string   ls_db_err,ls_where_select, ls_error
long 		ll_tercero
Datetime ld_tiempo1, ld_tiempo2
Datastore lds_cliente, lds_tercero_empresa, lds_tercero_gf, lds_tercero_pais

DELETE FROM ccatempa
WHERE ( ccatempa.tmpa_g_financiero 	= :str.g_financiero 	) AND  
      ( ccatempa.tmpa_empresa 		= :str.empresa 		) and
		( ccatempa.tmpa_usuario_maquina = :str.maquina 		) ;
if sqlca.sqlcode = -1 then
	messagebox('error','error al elimianr registros desde ccatempa')
end if

DELETE FROM cchestado  
WHERE ( cchestado.est_g_financiero =:str.g_financiero  ) AND  
		( cchestado.est_empresa =:str.empresa  ) AND  
		( cchestado.est_usuario_maquina =:str.maquina  )   ;
if sqlca.sqlcode = -1 then
	mensaje('Error','Error eliminando de cchestado','')
end if

//datastore	lds_tercero_empresa, lds_tercero_gf,lds_cliente, lds_tercero_pais
Datawindowchild ldwc_sub_tran, ldwc_pais, ldwc_region

lds_cliente 			= create ds_dg_import_file
lds_tercero_empresa 	= create ds_dg_import_file
lds_tercero_gf 		= create ds_dg_import_file
lds_tercero_pais	 	= create ds_dg_import_file


lds_cliente.dataobject = 'dw_cc_inf_terceros_rango_1_nom'
//****************

lds_cliente.settransobject(sqlca)

istr_rangfech =  lstr_rangfech
ld_tiempo1 = Datetime(istr_rangfech.fecha1,00:00:00)
ld_tiempo2 = Datetime(istr_rangfech.fecha2,00:00:00)

//lstr_rangfech.tip_cliente = il_tip_cliente

CHOOSE CASE istr_rangfech.opcion
	CASE 'P' //Por Cliente 
			
		//**filtra el dw por tipo de cliente
		if lstr_rangfech.tip_cliente = 'P' then
			if not isnull(istr_rangfech.tipo_cliesp) then li_tipo = 1
			if not isnull(istr_rangfech.tipo_socio)  then li_socio = 1
			if not isnull(istr_rangfech.tipo_auditor) then li_audit = 1
		
			if li_tipo = 1 then
				lds_cliente.setfilter("ccmclien_clie_clasificacion="+string(lstr_rangfech.tipo_cliesp))
				lds_cliente.filter()
			elseif li_socio = 1 then
				lds_cliente.setfilter("clie_socio="+string(lstr_rangfech.tipo_socio))
				lds_cliente.filter()
			elseif li_audit = 1 then
				lds_cliente.setfilter("clie_auditor="+string(lstr_rangfech.tipo_auditor))
				lds_cliente.filter()
			end if
						
		elseif lstr_rangfech.tip_cliente = 'T' then
			lds_cliente.Setfilter('')
			lds_cliente.filter()
		end if
      //***

			lds_cliente.retrieve(str.g_financiero,str.empresa,istr_rangfech.nombre1,istr_rangfech.nombre2)
			li_registros = lds_cliente.rowcount()
			
			ls_where_select="( terc_descripcion + convert(char(5),dgmterce.terc_tercero) between '"+lstr_rangfech.nombre1+"' and '"+lstr_rangfech.nombre2+"' )"
		
		for li_i = 1 to li_registros 
			//ole_1.object.value 	= (li_i/lds_cliente.rowcount()) * 100		
			//valida que el cliente sea visible, si no tiene permisos, que se devuelva
				ll_tercero 				= lds_cliente.getitemnumber(li_i,"ccmclien_clie_tercero")										
				gf_antiguedad_x_cliente(ld_tiempo2, ll_tercero,idioma,ld_tiempo1)
				istr_rangfech.tipo_antig = 'N'
		next
		//ole_1.visible = false

END CHOOSE

//ole_1.visible = false

IF ISVALID(lds_cliente)  THEN
	DESTROY lds_cliente
END IF
commit using sqlca;
return;
end subroutine

public function boolean wf_grabar_cliente (datawindow adw_1, long fila);long ll_pais, ll_tercero, ll_encontro
decimal{2} ld_cargo_mora, ld_limite_credito, ld_limite_anterior
integer li_morosidad, li_vendedor, li_exento
string ls_cuenta, ls_estado, ls_detalle, ls_foto, ls_cuenta_oficial, ls_pasaporte
string ls_contacto, ls_cargo, ls_observacion, ls_telefono, ls_codigo, ls_ruc, ls_tipo_persona, ls_digito	, ls_cuenta_relacionada, ls_cuenta_relacionada2	
integer li_pais, li_existe, li_tipo
datetime ldt_fecha

		
		fila = 1
		
		if adw_1.getitemnumber(fila,'dgmterce_terc_region') = 0 or isnull(adw_1.getitemnumber(fila,'dgmterce_terc_region')) then
			gf_mensaje('','Asigne la region a la que pertenece el cliente',1,1,'E')
			adw_1.setcolumn('dgmterce_terc_region')
			return false
		end if
		
		if adw_1.getitemnumber(fila,'dgmterce_terc_pais') = 0 or isnull(adw_1.getitemnumber(fila,'dgmterce_terc_pais')) then
			gf_mensaje('','Asigne el pais al que pertenece el cliente',1,1,'E')
			adw_1.setcolumn('dgmterce_terc_pais')			
			return false
		end if
		
		if adw_1.getitemstring(fila,'clie_ref_anterior') = '' or isnull(adw_1.getitemString(fila,'clie_ref_anterior')) then
			gf_mensaje('','Asigne la cuenta del cliente',1,1,'E')
			adw_1.setcolumn('clie_ref_anterior')
			return false
		end if

		if adw_1.getitemNumber(fila,'clie_clasificacion') = 0 or isnull(adw_1.getitemNumber(fila,'clie_clasificacion')) then
			gf_mensaje('','Asigne el Tipo de Cliente',1,1,'E')
			adw_1.setcolumn('clie_clasificacion')
			return false
		end if

		ls_cuenta	= adw_1.getitemstring(fila,'ccmclien_clie_mg_cuenta')				
		if trim(ls_cuenta) = '' or isnull(ls_cuenta) then
			gf_mensaje('','Asigne la cuenta contable del Cliente',1,1,'E')
			tab_1.selectedtab = 2
			tab_1.tabpage_2.dw_2.setcolumn('ccmclien_clie_mg_cuenta')
			return false
		end if

		
		ld_limite_anterior = adw_1.getitemnumber(fila,'ccmclien_clie_limite_credito', Primary!, true)			
		
		sqlca.autocommit = false
		
		if adw_1.update() = -1 then
		  if sqlca.sqlcode = -1 then
			 gf_mensaje('','Error al Actualizar clientes dw_1 '+sqlca.sqlerrtext,1,1,'E')
			 rollback ;
			 sqlca.autocommit = true
			 return false
		  end if
		else

			ls_contacto = adw_1.getitemstring(fila, 'clie_contacto')
			ls_cargo		= adw_1.getitemstring(fila, 'clie_contacto_cargo')
			ls_telefono	= adw_1.getitemstring(fila, 'clie_contacto_telefono')
			ls_codigo	= adw_1.getitemstring(fila, 'clie_ref_anterior')
			ls_observacion = adw_1.getitemstring(fila, 'clie_comentario')
			li_tipo		= adw_1.getitemnumber(fila, 'clie_clasificacion')
			ll_tercero	= adw_1.getitemnumber(fila,'terc_tercero')
			ls_ruc		= adw_1.getitemstring(fila, 'dgmterce_terc_identificacion')
			li_morosidad= adw_1.getitemnumber(fila,'ccmclien_clie_limite_morosidad')
			li_vendedor = adw_1.getitemnumber(fila,'ccmclien_clie_vendedor')
			ld_limite_credito  = adw_1.getitemnumber(fila,'ccmclien_clie_limite_credito')
			ls_estado	= adw_1.getitemstring(fila,'ccmclien_clie_estado')
			ld_cargo_mora=adw_1.getitemnumber(fila,'ccmclien_clie_cargo_morocidad')			
			ls_foto		= adw_1.getitemstring(fila,'clie_foto_pasaporte')			
			ls_cuenta_oficial = adw_1.getitemstring(fila, 'clie_cuenta_oficial')
			ls_pasaporte		= adw_1.getitemstring(fila, 'clie_pasaporte')
			ls_cuenta_relacionada = adw_1.getitemstring(fila, 'clie_cuenta_relacionada')
			ls_cuenta_relacionada2 = adw_1.getitemstring(fila, 'clie_cuenta_relacionada2')
			li_exento	 = adw_1.getitemnumber(fila,'clie_exento_itbm')
			
		  SELECT count(1)  
			 INTO :li_existe  
			 FROM ccmclien  
			WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
					( ccmclien.clie_empresa = :str.empresa ) AND  
					( ccmclien.clie_tercero = :ll_tercero ) ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al validar cliente '+sqlca.sqlerrtext,1,1,'E')
				end if				
			if li_existe = 0 or isnull(li_existe) then //Si no existe, crea el proveedor
		
			  INSERT INTO ccmclien  
					( clie_g_financiero,   
					  clie_empresa,   
					  clie_tercero,   
					  clie_mg_cuenta,   
					  clie_ref_anterior,   
					  clie_limite_credito,   
					  clie_ruc_tercero,   
					  clie_contacto,   
					  clie_contacto_cargo,   
					  clie_contacto_telefono,    
					  clie_comentario,   
					  clie_estado,   
					  clie_clasificacion,
					  clie_tipo_desc,
					  clie_limite_morosidad,
					  clie_cargo_morocidad,
					  clie_vendedor,
					  clie_foto_pasaporte,
					  clie_cuenta_oficial,
					  clie_pasaporte,
					  clie_cuenta_relacionada,
					  clie_cuenta_relacionada2,
					  clie_exento_itbm)  
		  VALUES ( :str.g_financiero,   
					  :str.empresa,   
					  :ll_tercero,   
					  :ls_cuenta,   
					  :ls_codigo,   
					  :ld_limite_credito,   
					  :ls_ruc,   
					  :ls_contacto,   
					  :ls_cargo,   
					  :ls_telefono,   
					  :ls_observacion,   
					  :ls_estado,   
					  :li_tipo,
					  'N',
					  :li_morosidad,
					  :ld_cargo_mora,
					  :li_vendedor,
					  :ls_foto,
					  :ls_cuenta_oficial,
					  :ls_pasaporte,
					  :ls_cuenta_relacionada,
					  :ls_cuenta_relacionada2,
					  :li_exento)  ;
			  
				  if sqlca.sqlcode = -1 then
					 gf_mensaje('','Error al Insertar proveedor '+sqlca.sqlerrtext,1,1,'E')
					 rollback ;
					 sqlca.autocommit = true
					 return false
				  end if
			
			else //Si ya existe, actualiza los datos
							
				update ccmclien  
					set clie_ref_anterior = :ls_codigo,   
						  clie_ruc_tercero = :ls_ruc,    
						  clie_contacto = :ls_contacto,   
						  clie_contacto_cargo = :ls_cargo,      
						  clie_contacto_telefono = :ls_telefono,   
						  clie_comentario = :ls_observacion,
						  clie_clasificacion = :li_tipo,
						  clie_mg_cuenta		= :ls_cuenta,
						  clie_limite_credito = :ld_limite_credito,
						  clie_estado			= :ls_estado,
						  clie_limite_morosidad = :li_morosidad,
						  clie_cargo_morocidad = :ld_cargo_mora,
						  clie_vendedor	= :li_vendedor,
						  clie_foto_pasaporte = :ls_foto,
						  clie_cuenta_oficial = :ls_cuenta_oficial,
						  clie_pasaporte = :ls_pasaporte,
						  clie_cuenta_relacionada = :ls_cuenta_relacionada,
  						  clie_cuenta_relacionada2 = :ls_cuenta_relacionada2,
						  clie_exento_itbm = :li_exento
				  where clie_g_financiero = :str.g_financiero and
						  clie_empresa		= :str.empresa and
						  clie_tercero		= :ll_tercero ;
				  if sqlca.sqlcode = -1 then
					 gf_mensaje('','Error al Actualizar cliente '+sqlca.sqlerrtext,1,1,'E')
					 rollback ;
					 sqlca.autocommit = true
					 return false
				  end if
				
			end if
			
			//Recupera el dw de busqueda
			idw_5.retrieve(str.g_financiero, str.empresa)
			ll_encontro = idw_5.find("terc_tercero = "+string(ll_tercero), 1, idw_5.rowcount())
			if ll_encontro > 0 then
				idw_5.scrolltorow(ll_encontro)
			end if
			
			//Si se cambio el limite de Credito, crea la Nota
			if idw_1.getitemnumber(1, 'cambiar_limite') = 1 then				
				
					ldt_fecha  = gf_fecha_serv()
					ls_detalle = 'Cambio del Limite de Credito: de '+string(ld_limite_anterior,'$##,##0.00')+ ' a '+string(ld_limite_credito, '$##,##0.00')
					
					  INSERT INTO notas_clientes  
						( nota_g_financiero,   
						  nota_empresa,   
						  nota_tercero,   
						  nota_detalle,   
						  nota_fecha,   
						  nota_usuario )  
					  VALUES ( :str.g_financiero,   
								  :str.empresa,   
								  :ll_tercero,   
								  :ls_detalle,     
								  :ldt_fecha,   
								  :str.usuario )  ;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al registrar las notas '+sqlca.sqlerrtext,1,1,'E')
						end if
						
						idw_1.setitem(1,'cambiar_limite',0)
						idw_1.accepttext()
			end if
			
		
		end if //del update del dw_1

		commit;
		
		sqlca.autocommit = true

return true
end function

on w_mant_clientes.create
int iCurrent
call super::create
this.st_1=create st_1
this.pb_top=create pb_top
this.pb_back=create pb_back
this.pb_next=create pb_next
this.pb_bottom=create pb_bottom
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.pb_top
this.Control[iCurrent+3]=this.pb_back
this.Control[iCurrent+4]=this.pb_next
this.Control[iCurrent+5]=this.pb_bottom
end on

on w_mant_clientes.destroy
call super::destroy
destroy(this.st_1)
destroy(this.pb_top)
destroy(this.pb_back)
destroy(this.pb_next)
destroy(this.pb_bottom)
end on

event ue_post_open;call super::ue_post_open;str_cc_formatos  lstr_formato
long ll_tercero, ll_encontro, ll_codigo
integer li_existe
string ls_codigo
datawindowchild ldwc_dias, ldwc_vendedores, ldwc_cuentas

iw_window = this

idw_1 = tab_1.tabpage_1.dw_1
idw_2 = tab_1.tabpage_2.dw_2
idw_3 = tab_1.tabpage_3.dw_3
idw_5 = tab_1.tabpage_1.dw_5
idw_1.settransobject(sqlca)
idw_2.settransobject(sqlca)
idw_3.settransobject(sqlca)
tab_1.tabpage_2.dw_4.settransobject(sqlca)
idw_5.settransobject(sqlca)
idw_5.retrieve(str.g_financiero, str.empresa)

idw_1.getchild('dgmterce_terc_region', idwc_region)
idwc_region.settransobject(sqlca)
idwc_region.insertrow(1)
idw_1.getchild('clie_clasificacion',idwc_tipo)
idwc_tipo.settransobject(sqlca)
idwc_tipo.retrieve(str.g_financiero, str.empresa)
idwc_tipo.insertrow(0)
idw_1.insertrow(1)

idw_1.getchild('terc_provincia',idwc_provincia)
idwc_provincia.settransobject(sqlca)
idwc_provincia.retrieve()
idwc_provincia.insertrow(1)
idw_1.getchild('terc_distrito',idwc_distrito)
idwc_distrito.settransobject(sqlca)
idwc_distrito.retrieve()
idwc_distrito.insertrow(1)
idw_1.getchild('terc_corregimiento',idwc_corregimiento)
idwc_corregimiento.settransobject(sqlca)
idwc_corregimiento.retrieve(str.g_financiero, str.empresa)
idwc_corregimiento.insertrow(1)

lstr_formato = Message.PowerObjectParm

if isvalid(lstr_formato) then
	ll_tercero = lstr_formato.tercero
end if

idw_1.setfocus()

  SELECT dgmempre.empr_cuenta_cxc_default  
    INTO :is_cuenta  
    FROM dgmempre  
   WHERE ( dgmempre.empr_g_financiero = :str.g_financiero ) AND  
         ( dgmempre.empr_empresa = :str.empresa )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al seleccionar cuenta cxc '+sqlca.sqlerrtext,1,1,'E')
		close(this)
	end if

if ll_tercero > 0 then	
	idw_1.setcolumn('terc_tercero')	
	idw_1.setitem(1,'terc_tercero',ll_tercero)
	if idw_1.retrieve(str.g_financiero, str.empresa, ll_tercero) > 0 then
		idwc_region.Retrieve (idw_1.getitemnumber(1,'dgmterce_terc_pais'))					
		ll_encontro = idw_5.find("terc_tercero = "+string(ll_tercero), 1, idw_5.rowcount())
		if ll_encontro > 0 then
			idw_5.scrolltorow(ll_encontro)
		end if			
	end if
else
	select max(terc_tercero) into :ll_tercero
	from dgmterce where terc_tercero <> 99999 ;
//	where terc_tipo = 1;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al seleccionar tercero',1,1,'E')
	end if	
	idw_1.setitem(1,'terc_tercero',ll_tercero + 1)		

//	  SELECT max(convert(numeric(15), clie_ref_anterior))
//		 INTO :ll_codigo  
//		 FROM ccmclien  
//		WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
//				( ccmclien.clie_empresa = :str.empresa ) and 
//				( clie_ref_anterior <> '99999') and ( clie_ref_anterior <> 'DIARIO') and ( clie_ref_anterior <> 'D') and ( clie_ref_anterior <> 'P') and ( clie_ref_anterior not like 'OM%');
//		if sqlca.sqlcode = -1 then
//			gf_mensaje('','Error al seleccionar cliente '+sqlca.sqlerrtext,1,1,'E')
//		end if
//	ll_codigo ++
//	li_existe = 1
//	do while li_existe > 0
//			ls_codigo = string(ll_codigo)
//			//verifica que no exista
//			select count(*) into :li_existe
//			from ccmclien 
//			where clie_ref_anterior = :ls_codigo and
//					clie_g_financiero = :str.g_financiero and
//					clie_empresa		= :str.empresa ;					
//			if sqlca.sqlcode = -1 then
//				gf_mensaje('','Error al validar cliente '+sqlca.sqlerrtext,1,1,'E')
//			end if	
//			if li_existe > 0 then
//				ll_codigo ++
//			end if
//	loop		
//	
//	idw_1.setitem(1,'clie_ref_anterior',ls_codigo)		
	idw_1.setitem(1,'ccmclien_clie_mg_cuenta',is_cuenta)		
end if //Si no fue llamado desde otra ventana

idw_2.getchild('ccmclien_clie_limite_morosidad', ldwc_dias)
idw_2.getchild('ccmclien_clie_vendedor', ldwc_vendedores)  
idw_2.getchild('ccmclien_clie_mg_cuenta', ldwc_cuentas)  
ldwc_cuentas.settransobject(sqlca)
ldwc_vendedores.settransobject(sqlca)
ldwc_vendedores.retrieve(str.g_financiero, str.empresa)
ldwc_vendedores.insertrow(1)
ldwc_dias.settransobject(sqlca)
ldwc_dias.retrieve(str.g_financiero, str.empresa)
ldwc_cuentas.retrieve(str.g_financiero, str.empresa)
idw_1.setitemstatus(1,0,primary!,NotModified!) 
idw_2.setitemstatus(1,0,primary!,NotModified!) 
idw_1.sharedata(idw_2)
 
This.visible = true
end event

event ue_adicionar;//override
long ll_tercero, ll_codigo
integer li_existe 
string ls_codigo
idw_1.reset()
idw_1.insertrow(1)
idw_1.setcolumn('terc_tercero')
select max(terc_tercero) into :ll_tercero
from dgmterce where terc_tercero <> 99999;
if sqlca.sqlcode = -1 then
	gf_mensaje('','Error al seleccionar tercero '+sqlca.sqlerrtext,1,1,'E')
end if

	ll_tercero ++
	li_existe = 1
	do while li_existe > 0
			//verifica que no exista
			select count(*) into :li_existe
			from dgmterce 
			where terc_tercero = :ll_tercero ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al validar tercero '+sqlca.sqlerrtext,1,1,'E')
			end if	
			if li_existe > 0 then
				ll_tercero ++
			end if
	loop

idw_1.setitem(1,'terc_tercero',ll_tercero)
idw_1.setcolumn('dgmterce_terc_descripcion')

//	  SELECT max(convert(numeric(15), clie_ref_anterior))
//		 INTO :ll_codigo  
//		 FROM ccmclien  
//		WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
//				( ccmclien.clie_empresa = :str.empresa ) and 
//				( clie_ref_anterior <> '99999') and ( clie_ref_anterior <> 'DIARIO') and ( clie_ref_anterior <> 'D') and ( clie_ref_anterior <> 'P') and ( clie_ref_anterior not like 'OM%');
//		if sqlca.sqlcode = -1 then
//			gf_mensaje('','Error al seleccionar cliente '+sqlca.sqlerrtext,1,1,'E')
//		end if
//	ll_codigo ++
//	li_existe = 1
//	do while li_existe > 0
//			ls_codigo = string(ll_codigo)
//			//verifica que no exista
//			select count(*) into :li_existe
//			from ccmclien 
//			where clie_ref_anterior = :ls_codigo and
//					clie_g_financiero = :str.g_financiero and
//					clie_empresa		= :str.empresa ;					
//			if sqlca.sqlcode = -1 then
//				gf_mensaje('','Error al validar cliente '+sqlca.sqlerrtext,1,1,'E')
//			end if	
//			if li_existe > 0 then
//				ll_codigo ++
//			end if
//	loop		
//	
//	idw_1.setitem(1,'clie_ref_anterior',ls_codigo)		
//
	idw_1.setitem(1,'ccmclien_clie_mg_cuenta',is_cuenta)		
end event

event ue_aceptar;//override
wf_grabar_cliente(tab_1.tabpage_1.dw_1, 1)			

end event

event close;call super::close;Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
 
end event

event ue_siguiente_reg;//siguiente registro
long ll_tercero
string ls_descrip
if idw_1.getrow() = 0 then return
ls_descrip = idw_1.getitemString(1,'dgmterce_terc_descripcion')
if ls_descrip  = '' or isnull(ls_descrip) then
	idw_5.scrolltorow(1)
else
	idw_5.scrollnextrow()
end if
ll_tercero = idw_5.getitemNumber(idw_5.getrow(),'terc_tercero')
idw_1.setitem(1,'terc_tercero',ll_tercero)
idw_1.accepttext()
idw_1.setcolumn('terc_tercero')
idw_1.trigger event itemchanged(1,idw_1.object,string(ll_tercero))

if il_tab_activo = 2 then
	wf_antiguedad()
end if

end event

event ue_reg_anterior;//override
//siguiente registro
long ll_tercero
idw_5.scrollpriorrow()
ll_tercero = idw_5.getitemNumber(idw_5.getrow(),'terc_tercero')
idw_1.setitem(1,'terc_tercero',ll_tercero)
idw_1.accepttext()
idw_1.setcolumn('terc_tercero')
idw_1.trigger event itemchanged(1,idw_1.object,string(ll_tercero))

if il_tab_activo = 2 then
	wf_antiguedad()
end if

end event

event ue_ultimo_reg;//override
//siguiente registro
long ll_tercero

idw_5.scrolltorow(idw_5.rowcount())
ll_tercero = idw_5.getitemNumber(idw_5.getrow(),'terc_tercero')
idw_1.setitem(1,'terc_tercero',ll_tercero)
idw_1.accepttext()
idw_1.setcolumn('terc_tercero')
idw_1.trigger event itemchanged(1,idw_1.object,string(ll_tercero))

if il_tab_activo = 2 then
	wf_antiguedad()
end if

end event

event ue_primer_reg;//override
//siguiente registro
long ll_tercero

idw_5.scrolltorow(1)
ll_tercero = idw_5.getitemNumber(idw_5.getrow(),'terc_tercero')
idw_1.setitem(1,'terc_tercero',ll_tercero)
idw_1.accepttext()
idw_1.setcolumn('terc_tercero')
idw_1.trigger event itemchanged(1,idw_1.object,string(ll_tercero))

if il_tab_activo = 2 then
	wf_antiguedad()
end if

end event

event closequery;//override
this.SetRedraw ( false )
this.triggerevent("ue_valida_todo")
constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)

end event

event ue_valida_todo;//override

integer li_cont
Boolean lb_r


FOR li_cont = 1 TO 1
	
	lb_r = w_valida_yguar(li_cont,li_cont)

	
NEXT














end event

event open;//This.SetToolbar(1,true,AlignatTop!)
//This.SetToolbarPos(1,1,50,false)
//this.SetRedraw ( true )

//this.y = 0
//this.x = 805
//This.Icon = str.icono
//gf_acelerador()
THIS.postevent("UE_POST_OPEN")
//w_hs_frame.Post Event ue_evaluar_panel_acciones()
end event

event ue_print;call super::ue_print;	OpenSheet(w_impresion_clientes, str.frame,2,Original!)		
end event

type tab_1 from w_grampa_tab`tab_1 within w_mant_clientes
string tag = "xx"
integer x = 23
integer y = 20
integer width = 2409
integer height = 1952
long backcolor = 12639424
boolean fixedwidth = true
boolean powertips = true
boolean boldselectedtext = true
end type

event tab_1::selectionchanged;call super::selectionchanged;
choose case newindex
	case 1
		il_tab_activo = newindex
//		idw_1.setfocus()
	case 2
		il_tab_activo = newindex		
//		idw_2.setfocus()
		wf_antiguedad()
	case 3
		il_tab_activo = newindex		
//		idw_3.setfocus()
end choose
end event

on tab_1.create
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
call super::destroy
end on

type tabpage_1 from w_grampa_tab`tabpage_1 within tab_1
integer width = 2373
integer height = 1824
long backcolor = 12639424
string pointer = "HyperLink!"
string text = "Generales"
long tabbackcolor = 67108864
string picturename = "Custom039!"
long picturemaskcolor = 553648127
string powertiptext = "Datos Generales del Cliente"
dw_5 dw_5
pb_pdf pb_pdf
end type

on tabpage_1.create
this.dw_5=create dw_5
this.pb_pdf=create pb_pdf
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_5
this.Control[iCurrent+2]=this.pb_pdf
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_5)
destroy(this.pb_pdf)
end on

type dw_1 from w_grampa_tab`dw_1 within tabpage_1
event ue_down pbm_dwnkey
integer x = 0
integer y = 44
integer width = 2373
integer height = 1764
string dataobject = "dw_generales_clientes"
boolean border = false
end type

event dw_1::ue_down;if keydown(Keyescape!) then
	iw_window.postevent('close')
end if
end event

event dw_1::buttonclicked;call super::buttonclicked;	String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error
	integer li_c, li_b
	long    ll_lter, ll_encontro
	str_dg_dynamic_find	lstr_df
	
	choose case dwo.name
			
		case	'b_cliente', 'b_cuenta'		
		
		lstr_df.texto_campo [2,1] = "ccmclien.clie_ref_anterior" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [2,2] = "Cuenta"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '450'
		lstr_df.texto_campo [1,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [1,2] = "Descripción"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '700'		
		lstr_df.texto_campo [3,1] = "dgmterce.terc_tercero"
		lstr_df.texto_campo [3,2] = "Tercero"
		lstr_df.texto_campo [3,3] = "terc_tercero"
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [4,1] = "dgapais.pais_descripcion"
		lstr_df.texto_campo [4,2] = "País"
		lstr_df.texto_campo [4,3] = ""
		lstr_df.texto_campo [4,4] = 'V'
		lstr_df.texto_campo [4,5] = '550'
		
		lstr_df.tabla = " dgmterce, dgapais, ccmclien "
		
		
		lstr_df.tabla_where = &
					"WHERE ( dgmterce.terc_pais = dgapais.pais_pais ) and  " +&				
							 "(ccmclien.clie_g_financiero = " + string(str.g_financiero) + " and " +&
							 "ccmclien.clie_empresa = " + string(str.empresa) + ") 	and " +&
							"(dgmterce.terc_tercero = ccmclien.clie_tercero)"
		
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
		If len (ls_find) = 0 Then Return
			
			
		ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
		gf_replace_cadena(ls_codigo1,"'"," ")
		ls_codigo1 = Trim(ls_codigo1)
	
		idw_1.setitem(1,'terc_tercero',long(ls_codigo1))
		idw_1.accepttext()
		ll_encontro = dw_5.find("terc_tercero = "+ls_codigo1, 1, dw_5.rowcount())
		if ll_encontro > 0 then
			dw_5.scrolltorow(ll_encontro)
		end if	
		
		idw_1.setcolumn('terc_tercero')
		idw_1.trigger event itemchanged(1,object,ls_codigo1)
	
	case 'b_relacionada', 'b_relacionada2'
		lstr_df.texto_campo [1,1] = "ccmclien.clie_ref_anterior" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [1,2] = "Cuenta"
		lstr_df.texto_campo [1,3] = "clie_ref_anterior"
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '450'
		lstr_df.texto_campo [2,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [2,2] = "Descripción"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '700'		
		lstr_df.texto_campo [3,1] = "dgmterce.terc_tercero"
		lstr_df.texto_campo [3,2] = "Código Tercero"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [4,1] = "dgapais.pais_descripcion"
		lstr_df.texto_campo [4,2] = "País"
		lstr_df.texto_campo [4,3] = ""
		lstr_df.texto_campo [4,4] = 'V'
		lstr_df.texto_campo [4,5] = '550'
		
		lstr_df.tabla = " dgmterce, dgapais, ccmclien "
		
		
		lstr_df.tabla_where = &
					"WHERE ( dgmterce.terc_pais = dgapais.pais_pais ) and  " +&				
							 "(ccmclien.clie_g_financiero = " + string(str.g_financiero) + " and " +&
							 "ccmclien.clie_empresa = " + string(str.empresa) + ") 	and " +&
							"(dgmterce.terc_tercero = ccmclien.clie_tercero)"
		
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
		If len (ls_find) = 0 Then Return
			
			
		ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
		gf_replace_cadena(ls_codigo1,"'"," ")
		ls_codigo1 = Trim(ls_codigo1)
	
		if dwo.name = 'b_relacionada' then
			idw_1.setitem(1,'clie_cuenta_relacionada',ls_codigo1)
		else
			idw_1.setitem(1,'clie_cuenta_relacionada2',ls_codigo1)
		end if
		idw_1.accepttext()
			
end choose
end event

event dw_1::itemchanged;call super::itemchanged;long ll_tercero, ll_pais
integer li_existe, li_provincia, li_distrito
string ls_cuenta, ls_telefono, ls_cod_pais
idw_1.accepttext()
//datawindowsstatus ldws_estado
choose case this.getcolumnname()
	case 'terc_provincia'
		str.frame.setredraw(false)		
		this.setitem(1,'terc_distrito',0)
		this.setitem(1,'terc_corregimiento',0)		
		idw_1.accepttext()		
		str.frame.setredraw(true)		
	case 'terc_distrito'
		str.frame.setredraw(false)				
		this.setitem(1,'terc_corregimiento',0)
		idw_1.accepttext()		
		str.frame.setredraw(true)			
	case 'terc_telefono1'
		ls_telefono = data
		if pos(ls_telefono,'-') = 0 then
			gf_mensaje('','El Formato del Teléfono no es Válido, Verifique !!!. Debe ser ###-#### o ####-####',1,1,'E')
			this.setcolumn('terc_telefono1')
			return 2
		end if
	case 'terc_telefono2'
		ls_telefono = data
		if pos(ls_telefono,'-') = 0 then
			gf_mensaje('','El Formato del Teléfono no es Válido, Verifique !!!. Debe ser ###-#### o ####-####',1,1,'E')
			this.setcolumn('terc_telefono2')
			return 2
		end if		
		
	case "terc_tercero"		
		str.frame.setredraw(false)	
		ll_tercero = long(data)
		  SELECT count(*)
			 INTO :li_existe  
			 FROM ccmclien  
			WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
					( ccmclien.clie_empresa = :str.empresa ) AND  
					( ccmclien.clie_tercero = :ll_tercero ) ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al validar cliente '+sqlca.sqlerrtext,1,1,'E')
					return
				end if
		
			if li_existe = 0 or isnull(li_existe) then
				this.reset()
				this.insertrow(1)
				this.setitem(1,'terc_tercero',ll_tercero)
			//	this.setcolumn('dgmterce_terc_descripcion')				
			else
				if this.retrieve(str.g_financiero, str.empresa, ll_tercero) > 0 then
					ll_pais = this.getitemnumber(1,'dgmterce_terc_pais')
					idwc_region.Retrieve (ll_pais)
					//Si es cuenta mala, permite habilitarlo, de lo contrario lo permite pasar a cuenta mala
					if this.getitemnumber(1,'ccmclien_clie_cuenta_mala') = 1 then
						tab_1.tabpage_2.st_texto_cuenta_mala.text = 'Habilitar Cuenta'
						tab_1.tabpage_2.pb_mala.picturename = str.path+'\Art\dba_acept.bmp'
					else
						tab_1.tabpage_2.st_texto_cuenta_mala.text = 'Pasar a Cuentas Malas'
						tab_1.tabpage_2.pb_mala.picturename = str.path+'\Art\dba_cancel.bmp'						
					end if
				end if
			end if
			
			li_provincia = this.getitemnumber(1,'terc_provincia')
			if not isnull(li_provincia) then
				idwc_distrito.setfilter('codprovincia = '+string(li_provincia))
				idwc_distrito.filter()
	//			idwc_distrito.scrolltorow(li_encontro)
				li_distrito = this.getitemnumber(1,'terc_distrito')
				if not isnull(li_distrito) then
					idwc_corregimiento.setfilter('codprovincia = '+string(li_provincia)+ ' and coddistrito = '+string(li_distrito))
					idwc_corregimiento.filter()						
				end if
			end if			
		
			this.setitem(1,'cambiar_limite',0)
			this.setitemstatus(1,0,primary!,NotModified!) 			
			str.frame.setredraw(true)	
		case "clie_ref_anterior"			
			
			ls_cuenta = data
			
			  SELECT max(clie_tercero)
				 INTO :ll_tercero
				 FROM ccmclien  
				WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
						( ccmclien.clie_empresa = :str.empresa ) AND  
						( ccmclien.clie_ref_anterior = :ls_cuenta ) ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al validar cliente '+sqlca.sqlerrtext,1,1,'E')
						return
					end if
			
				if ll_tercero = 0 or isnull(ll_tercero) then
					//valida que el codigo del tercero no exista, para permitir la captura
					ll_tercero = this.getitemnumber(row,'terc_tercero')
					  SELECT count(*)
						 INTO :li_existe
						 FROM ccmclien  
						WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
								( ccmclien.clie_empresa = :str.empresa ) AND  
								( ccmclien.clie_tercero = :ll_tercero ) ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al validar cliente '+sqlca.sqlerrtext,1,1,'E')
								return
							end if
					//si existe, crea un nuevo registro para captar		
					if li_existe > 0 then															
						this.reset()
						this.insertrow(1)
						this.setcolumn('terc_tercero')
						select max(terc_tercero) into :ll_tercero
						from dgmterce 
						where terc_tipo = 1;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al seleccionar tercero',1,1,'E')
						end if
						this.setitem(1,'terc_tercero',ll_tercero + 1)
						this.setitem(1,'clie_ref_anterior',ls_cuenta)
						this.setcolumn('dgmterce_terc_descripcion')					
					end if
				else
					if idw_1.GetItemStatus(idw_1.getrow(),0,primary! ) = New! or &
						idw_1.GetItemStatus(idw_1.getrow(),0,primary! ) = NewModified! then
					//	gf_mensaje('','Cuenta ya existe, Verifique !!!',2,1,'E')
					//	idw_1.setitem(idw_1.getrow(), 'clie_ref_anterior', '')						
					//	return 2	
					end if
					
					if this.retrieve(str.g_financiero, str.empresa, ll_tercero) > 0 then
						ll_pais = this.getitemnumber(1,'dgmterce_terc_pais')
						idwc_region.Retrieve (ll_pais)					
					end if
					
				end if		
				li_provincia = this.getitemnumber(1,'terc_provincia')
				if not isnull(li_provincia) then
					idwc_distrito.setfilter('codprovincia = '+string(li_provincia))
					idwc_distrito.filter()
					li_distrito = this.getitemnumber(1,'terc_distrito')
					if not isnull(li_distrito) then
						idwc_corregimiento.setfilter('codprovincia = '+string(li_provincia)+ ' and coddistrito = '+string(li_distrito))
						idwc_corregimiento.filter()
					end if
				end if
							
				this.setitem(1,'cambiar_limite',0)				
				this.setitemstatus(1,0,primary!,NotModified!) 				
		case "dgmterce_terc_pais"
			ll_pais = long (data)
			idwc_region.Retrieve (ll_pais)
			idw_1.setitem(1,'dgmterce_terc_region',0)
			
			  SELECT isnull(dgapais.pais_fe_codigo ,'') 
				 INTO :ls_cod_pais  
				 FROM dgapais  
				WHERE dgapais.pais_pais = :ll_pais   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Buscar Codigo de Pais '+sqlca.sqlerrtext,1,1,'E')
			end if
			idw_1.setitem(1,'cod_pais',ls_cod_pais)			
	end choose
end event

event dw_1::clicked;call super::clicked;long ll_pais, ll_tercero, ll_encontro, ll_codigo
decimal{2} ld_cargo_mora, ld_limite_credito
integer li_morosidad, li_vendedor, li_contador, li_rtn, li_existe
string ls_cuenta, ls_estado, ls_path,ls_nomfile,ls_filter, ls_codigo

THIS.ACCEPTTEXT()

choose case dwo.name
	case	'b_adicionar_cli'
		this.reset()
		this.insertrow(1)
		this.setcolumn('terc_tercero')
		select max(terc_tercero) into :ll_tercero
		from dgmterce where terc_tercero <> 99999 ;
//		where terc_tipo = 1;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al seleccionar tercero '+sqlca.sqlerrtext,1,1,'E')
		end if
		this.setitem(1,'terc_tercero',ll_tercero + 1)
		this.setcolumn('dgmterce_terc_descripcion')
		
		
//	  SELECT max(convert(numeric(15), clie_ref_anterior))
//		 INTO :ll_codigo  
//		 FROM ccmclien  
//		WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
//				( ccmclien.clie_empresa = :str.empresa ) and 
//				( clie_ref_anterior <> '99999') and ( clie_ref_anterior <> 'DIARIO') and ( clie_ref_anterior <> 'D') and ( clie_ref_anterior <> 'P') and ( clie_ref_anterior not like 'OM%');
//		if sqlca.sqlcode = -1 then
//			gf_mensaje('','Error al seleccionar cliente '+sqlca.sqlerrtext,1,1,'E')
//		end if
//	ll_codigo ++
//	li_existe = 1
//	do while li_existe > 0
//			ls_codigo = string(ll_codigo)
//			//verifica que no exista
//			select count(*) into :li_existe
//			from ccmclien 
//			where clie_ref_anterior = :ls_codigo and
//					clie_g_financiero = :str.g_financiero and
//					clie_empresa		= :str.empresa ;					
//			if sqlca.sqlcode = -1 then
//				gf_mensaje('','Error al validar cliente '+sqlca.sqlerrtext,1,1,'E')
//			end if	
//			if li_existe > 0 then
//				ll_codigo ++
//			end if
//	loop		
//	
//	idw_1.setitem(1,'clie_ref_anterior',ls_codigo)		
	idw_1.setitem(1,'ccmclien_clie_mg_cuenta',is_cuenta)		
		
	case 'b_eliminar_cli'
		
		string ls_error
		ll_tercero = this.getitemnumber(this.getrow(), 'terc_tercero')		
		
		select count(*) into :li_contador
		from cctmovim
		where movi_g_financiero = :str.g_financiero and
				movi_empresa		= :str.empresa and
				movi_tercero		= :ll_tercero ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al validar existencia '+sqlca.sqlerrtext,1,1,'E')
				end if
		if li_contador > 0 then
			gf_mensaje('','El Cliente tiene movimientos registrados, no se puede eliminar, Verifique !!!',1,1,'E')
			return
		end if
		
		if gf_mensaje('','Esta Seguro de Eliminar el Cliente ?',2,1,'E') = 1 then
			sqlca.autocommit = false

			  DELETE FROM ccmclien  
				WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
						( ccmclien.clie_empresa = :str.empresa ) AND  
						( ccmclien.clie_tercero = :ll_tercero )   ;
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					gf_mensaje('','Error al Eliminar Cliente '+ls_error,1,1,'E')				
					sqlca.autocommit = true
					return
				end if
			
			this.deleterow(this.getrow())			
			if this.update() = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				gf_mensaje('','Error al Elimiar Cliente '+ls_error,1,1,'E')				
				sqlca.autocommit = true
				return
			else
				commit;
			end if
			sqlca.autocommit = true			
			this.insertrow(1)
			select max(terc_tercero) into :ll_tercero
			from dgmterce 
			where terc_tipo = 1;
			
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al seleccionar tercero',1,1,'E')
			end if
			this.setitem(1,'terc_tercero',ll_tercero + 1)					

		end if
	case 'b_cerrar_cli'
		iw_window.triggerevent('close')
	case	'b_grabar_cli'
		wf_grabar_cliente(this, row)			
	case 'clie_foto_pasaporte'
			
		ls_path = this.getitemstring(this.getrow(),'clie_foto_pasaporte')
		openwithparm(w_foto_cliente, ls_path) 
		ls_path = message.stringparm
		this.SetItem(this.Getrow(),"clie_foto_pasaporte",ls_path)

end choose
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;this.selecttext(1,100)

this.accepttext()
integer li_provincia, li_distrito
choose case dwo.name
	case 'terc_distrito'
		li_provincia = this.getitemnumber(1,'terc_provincia')
		idwc_distrito.setfilter('codprovincia = '+string(li_provincia))
		idwc_distrito.filter()
	case 'terc_corregimiento'
		li_provincia = this.getitemnumber(1,'terc_provincia')
		li_distrito = this.getitemnumber(1,'terc_distrito')
		idwc_corregimiento.setfilter('codprovincia = '+string(li_provincia)+ ' and coddistrito = '+string(li_distrito))
		idwc_corregimiento.filter()
		
end choose
end event

type tabpage_2 from w_grampa_tab`tabpage_2 within tab_1
integer width = 2373
integer height = 1824
long backcolor = 12639424
string pointer = "HyperLink!"
string text = "Financiera"
long tabbackcolor = 12632256
string picturename = "Cursor!"
string powertiptext = "Datos Financiero"
dw_4 dw_4
cb_2 cb_2
cb_1 cb_1
pb_1 pb_1
st_2 st_2
pb_mala pb_mala
st_texto_cuenta_mala st_texto_cuenta_mala
end type

on tabpage_2.create
this.dw_4=create dw_4
this.cb_2=create cb_2
this.cb_1=create cb_1
this.pb_1=create pb_1
this.st_2=create st_2
this.pb_mala=create pb_mala
this.st_texto_cuenta_mala=create st_texto_cuenta_mala
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.pb_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.pb_mala
this.Control[iCurrent+7]=this.st_texto_cuenta_mala
end on

on tabpage_2.destroy
call super::destroy
destroy(this.dw_4)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.pb_mala)
destroy(this.st_texto_cuenta_mala)
end on

type dw_2 from w_grampa_tab`dw_2 within tabpage_2
event ue_down pbm_dwnkey
integer x = 41
integer y = 48
integer width = 2331
integer height = 1496
string dataobject = "dw_financiera_clientes"
end type

event dw_2::ue_down;if keydown(Keyescape!) then
	iw_window.postevent('close')
end if
end event

event dw_2::clicked;call super::clicked;
THIS.ACCEPTTEXT()

choose case dwo.name
	case 'b_cerrar_cli'
		iw_window.triggerevent('close')
	case	'b_grabar_cli'
		wf_grabar_cliente(this, row)		
	case  'b_cambiar_limite'
		wf_cambiar_limite()
end choose
end event

event dw_2::itemchanged;call super::itemchanged;this.accepttext()
long ll_tercero
string ls_detalle
datetime ldt_fecha
if this.getcolumnname() = 'ccmclien_clie_estado' then
	if data = 'I' then
		if dw_4.getitemnumber(1,'tpan_col21') <> 0 then
			this.setitem(row,'ccmclien_clie_estado','A')
			gf_mensaje('','No puede inactivar un cliente que tiene saldo, verifique !!!',1,1,'E')
			return 2
		end if			
		if gf_mensaje('','Esta seguro de INACTIVAR el cliente ?',2,2,'E') = 2 then return 2		
		ls_detalle = 'Se Inactivo el Cliente'		
	else
		ls_detalle = 'Se Activo el Cliente'
	end if
	
	ll_tercero = idw_1.getitemnumber(1,'terc_tercero')
	ldt_fecha  = gf_fecha_serv()
	
	  INSERT INTO notas_clientes  
		( nota_g_financiero,   
		  nota_empresa,   
		  nota_tercero,   
		  nota_detalle,   
		  nota_fecha,   
		  nota_usuario )  
	  VALUES ( :str.g_financiero,   
				  :str.empresa,   
				  :ll_tercero,   
				  :ls_detalle,     
				  :ldt_fecha,   
				  :str.usuario )  ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al registrar las notas '+sqlca.sqlerrtext,1,1,'E')
		end if
		
		wf_grabar_cliente(this, row)		
		
	commit ;
end if
end event

event dw_2::doubleclicked;call super::doubleclicked;if dwo.name = 'ccmclien_clie_limite_credito' then
	wf_cambiar_limite()
end if
end event

type tabpage_3 from w_grampa_tab`tabpage_3 within tab_1
boolean visible = false
integer width = 2373
integer height = 1824
boolean enabled = false
long backcolor = 12639424
string pointer = "HyperLink!"
string text = "Seguridad"
long tabbackcolor = 12632256
string picturename = "CreateIndex!"
string powertiptext = "Decisiones Administrativas"
end type

type dw_3 from w_grampa_tab`dw_3 within tabpage_3
end type

type dw_5 from datawindow within tabpage_1
boolean visible = false
integer x = 9
integer y = 696
integer width = 494
integer height = 604
integer taborder = 24
boolean bringtotop = true
string title = "none"
string dataobject = "dw_buscar_cliente"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_pdf from picturebutton within tabpage_1
integer x = 2030
integer y = 1416
integer width = 128
integer height = 112
integer taborder = 44
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "PictureButton!"
alignment htextalign = left!
boolean map3dcolors = true
string powertiptext = "Ver PDF ..."
end type

event clicked;		OLEObject ole_object 
		Integer li_rc 
		String ls_ruta 
		
		dw_1.accepttext()
		ls_ruta = idw_1.getitemstring(idw_1.getrow(),'clie_foto_pasaporte') // 'P:\'+idw_25.getitemstring(1,'oc')+'.PDF'
		if fileexists(ls_ruta) then
			
		else
			//ls_ruta = " C:\Sistemas\Documentos\hymsoft.pdf" 
			gf_mensaje('','Pdf no Existe, Verifique !!!',1,1,'E')
			return
		end if
		
		ls_ruta = " "+ls_ruta
		
		ole_object = CREATE OleObject 
		li_rc = ole_object.ConnectToNewObject( "WScript.Shell" ) 
		
		IF li_rc<>0 THEN 
		DESTROY ole_object 
		MessageBox("Error", "No puede conectarse a Acrobat ") 
		RETURN 
		END IF 
		
		ole_object.run("AcroRd32"+ls_ruta) //, Maximized!) 
end event

type dw_4 from datawindow within tabpage_2
integer x = 1458
integer y = 412
integer width = 782
integer height = 764
integer taborder = 14
boolean bringtotop = true
string title = "none"
string dataobject = "dw_antiguedad"
boolean livescroll = true
end type

type cb_2 from commandbutton within tabpage_2
integer x = 503
integer y = 848
integer width = 667
integer height = 128
integer taborder = 24
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Estado de Cuenta"
end type

event clicked;string ls_error
		str_cc_formatos str_formato1		
		str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
		str_formato1.tercero = idw_1.getitemNumber(1,"terc_tercero")
		date ldt_fecha
		ldt_fecha = date(gf_fecha_Serv())
		lstr_rangfech.fecha1 = date('01/01/'+string(year(ldt_fecha) - 1 ))
		lstr_rangfech.fecha2 = ldt_fecha
	
		//Elimina las tablas temporales 
	  DELETE FROM ccatpan  
		WHERE ( ccatpan.tpan_g_financiero = :str.g_financiero ) AND  
				( ccatpan.tpan_empresa = :str.empresa ) AND  
				( ccatpan.tpan_maquina = :str.maquina )   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje('Aviso','Error al eliminar ccatpan',ls_error)
			return
		end if
			
		DELETE FROM ccatempa
		WHERE ( ccatempa.tmpa_g_financiero 	= :str.g_financiero 	) AND  
				( ccatempa.tmpa_empresa 		= :str.empresa 		) and
				( ccatempa.tmpa_usuario_maquina = :str.maquina 		) ;
		if sqlca.sqlcode = -1 then
			messagebox('error','error al elimianr registros desde ccatempa')
		end if
		
		  DELETE FROM ccatemaf
			WHERE ( tmaf_g_financiero = :str.g_financiero ) AND  
					( tmaf_empresa = :str.empresa ) AND  
					( tmaf_usuario_maquina = :str.maquina )   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje('Aviso','Error al eliminar ccatemaf',ls_error)
			return
		end if
		
		DELETE FROM cchestado  
		WHERE ( cchestado.est_g_financiero =:str.g_financiero  ) AND  
				( cchestado.est_empresa =:str.empresa  ) AND  
				( cchestado.est_usuario_maquina =:str.maquina  )   ;
		if sqlca.sqlcode = -1 then
			mensaje('Error','Error eliminando de cchestado','')
		end if
	
		lstr_rangfech.opcion = 'P'
		lstr_rangfech.mensaje = "P"
		lstr_rangfech.cadena = "N"
		lstr_rangfech.tipo_orden = 'C'//ruc
		lstr_rangfech.tipo_accion = '1'  //solo con movimientos
		lstr_rangfech.idioma = 'E' // en espanol
		lstr_rangfech.tip_cliente = 'T'//todos
		lstr_rangfech.preimpreso = 'N'//preimpresos
		lstr_rangfech.tipo_fecha  = '2'  
		lstr_rangfech.piepag      = '2'  
		lstr_rangfech.tipocliente = 'N'
		lstr_rangfech.tipo_orden = 'A'
		lstr_rangfech.nombre1 = idw_1.GetItemstring(1,"dgmterce_terc_descripcion")+string(str_formato1.tercero)
		lstr_rangfech.nombre2 = idw_1.GetItemstring(1,"dgmterce_terc_descripcion")+string(str_formato1.tercero)
		string ls_ruc
		  SELECT ccmclien.clie_ruc_tercero  
		 INTO :ls_ruc  
		 FROM ccmclien,   
				dgmterce  
		WHERE ( ccmclien.clie_tercero = dgmterce.terc_tercero ) and  
				( ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
				( ccmclien.clie_empresa = :str.empresa ) AND  
				( ccmclien.clie_tercero = :str_formato1.tercero ) )   ;
	
		
		lstr_rangfech.desdeclienteref = ls_ruc//str_formato1.tercero
		lstr_rangfech.hastaclienteref = ls_ruc//str_formato1.tercero
							
		if not isnull(lstr_rangfech.fecha1) and not isnull(lstr_rangfech.fecha2) or &
				lstr_rangfech.fecha1 <> date('00/00/0000') and lstr_rangfech.fecha2 <> date('00/00/0000')then
				commit using sqlca;
				wf_actualiza_antiguedad('E')
				OpenSheetWithParm(w_estadocuenta_imp,lstr_rangfech,str.frame,2, layered!)			
		end if	
	
end event

type cb_1 from commandbutton within tabpage_2
integer x = 507
integer y = 996
integer width = 663
integer height = 128
integer taborder = 24
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Análisis de Compras"
end type

event clicked;	str_cc_formatos str_formato1		
	str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	str_formato1.tercero = idw_1.getitemNumber(1,"terc_tercero")
	Opensheetwithparm(w_analisis_de_compras,str_formato1,str.frame,2,original!)
end event

type pb_1 from picturebutton within tabpage_2
integer x = 2171
integer y = 1380
integer width = 178
integer height = 152
integer taborder = 34
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "C:\sistemas\hymsoft\Art\NOTE04.BMP"
alignment htextalign = left!
end type

event clicked;long ll_tercero
ll_tercero = idw_1.getitemnumber(1,'terc_tercero')
str_cc_formatos str_formato2		
str_formato2.tercero = ll_tercero
if ll_tercero > 0 then
	Opensheetwithparm(w_notas,str_formato2,str.frame,2,original!)
end if

end event

type st_2 from statictext within tabpage_2
integer x = 1911
integer y = 1400
integer width = 242
integer height = 124
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Notas del Cliente"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_mala from picturebutton within tabpage_2
integer x = 119
integer y = 1212
integer width = 133
integer height = 112
integer taborder = 34
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "C:\sistemas\hymsoft\Art\dba_cancel.bmp"
alignment htextalign = left!
end type

event clicked;long ll_tercero
integer li_cuenta_mala = 1
datetime ldt_fecha
string ls_detalle, ls_mensaje

ls_mensaje = 'Esta seguro de pasar el Cliente a Cuentas Malas?'
ls_detalle = 'Cliente Pasado a Cuentas Malas'
	
if idw_1.getitemnumber(1,'ccmclien_clie_cuenta_mala') = 1 then
	gf_mensaje('','El Cliente ya pertenece a las Cuentas Malas, Verifique !!!',1,1,'E')
	ls_mensaje = 'Desea Habilitar el Cliente de Cuentas Malas ?'
	ls_detalle = 'Cliente Activado de Cuentas Malas'
	li_cuenta_mala = 0
end if

if gf_mensaje('',ls_mensaje,2,2,'E') = 2 then return 2		

OpenWithParm(w_clave_autorizada, iw_window)

If is_user <> "*" then
	
	ll_tercero = idw_1.getitemnumber(idw_1.getrow(),'terc_tercero')
	
	UPDATE ccmclien  
     SET clie_cuenta_mala = :li_cuenta_mala  
   WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
         ( ccmclien.clie_empresa = :str.empresa ) AND  
         ( ccmclien.clie_tercero = :ll_tercero );
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al actualizar a cuentas malas '+sqlca.sqlerrtext,1,1,'E')
		end if
	
	idw_1.setitem(1,'ccmclien_clie_cuenta_mala',li_cuenta_mala)
	
	if li_cuenta_mala = 1 then
		tab_1.tabpage_2.st_texto_cuenta_mala.text = 'Habilitar Cuenta'
		tab_1.tabpage_2.pb_mala.picturename = str.path+'\Art\dba_acept.bmp'
	else
		tab_1.tabpage_2.st_texto_cuenta_mala.text = 'Pasar a Cuentas Malas'
		tab_1.tabpage_2.pb_mala.picturename = str.path+'\Art\dba_cancel.bmp'						
	end if
	
	
	ldt_fecha  = gf_fecha_serv()
	
	  INSERT INTO notas_clientes  
		( nota_g_financiero,   
		  nota_empresa,   
		  nota_tercero,   
		  nota_detalle,   
		  nota_fecha,   
		  nota_usuario )  
	  VALUES ( :str.g_financiero,   
				  :str.empresa,   
				  :ll_tercero,   
				  :ls_detalle,     
				  :ldt_fecha,   
				  :str.usuario )  ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al registrar las notas '+sqlca.sqlerrtext,1,1,'E')
		end if
	
end if
end event

type st_texto_cuenta_mala from statictext within tabpage_2
integer x = 261
integer y = 1208
integer width = 393
integer height = 128
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Pasar a Cuentas Malas"
boolean focusrectangle = false
end type

type st_1 from statictext within w_mant_clientes
integer x = 846
integer y = 1524
integer width = 654
integer height = 144
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 553648127
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type pb_top from picturebutton within w_mant_clientes
integer x = 891
integer y = 1544
integer width = 119
integer height = 104
integer taborder = 44
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Sistemas\Hymsoft\Art\WZTOP.BMP"
alignment htextalign = left!
end type

event clicked;iw_window.triggerevent('ue_primer_reg')
end event

type pb_back from picturebutton within w_mant_clientes
integer x = 1038
integer y = 1544
integer width = 119
integer height = 104
integer taborder = 44
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Sistemas\Hymsoft\Art\WZBACK.BMP"
alignment htextalign = left!
end type

event clicked;iw_window.triggerevent('ue_reg_anterior')
end event

type pb_next from picturebutton within w_mant_clientes
integer x = 1189
integer y = 1544
integer width = 119
integer height = 104
integer taborder = 44
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Sistemas\Hymsoft\Art\WZNEXT.BMP"
alignment htextalign = left!
end type

event clicked;iw_window.triggerevent('ue_siguiente_reg')
end event

type pb_bottom from picturebutton within w_mant_clientes
integer x = 1335
integer y = 1544
integer width = 128
integer height = 112
integer taborder = 34
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Sistemas\Hymsoft\Art\WZEND.BMP"
alignment htextalign = left!
end type

event clicked;iw_window.triggerevent('ue_ultimo_reg')
end event

