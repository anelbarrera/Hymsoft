forward
global type w_mant_proveedores from w_grampa_tab
end type
type dw_5 from datawindow within tabpage_1
end type
type dw_4 from datawindow within tabpage_2
end type
type cb_2 from commandbutton within tabpage_2
end type
type pb_1 from picturebutton within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type st_1 from statictext within w_mant_proveedores
end type
type pb_top from picturebutton within w_mant_proveedores
end type
type pb_back from picturebutton within w_mant_proveedores
end type
type pb_next from picturebutton within w_mant_proveedores
end type
type pb_bottom from picturebutton within w_mant_proveedores
end type
end forward

global type w_mant_proveedores from w_grampa_tab
integer width = 2542
integer height = 1900
string title = "Mantenimiento de Proveedores"
boolean controlmenu = false
long backcolor = 12639424
st_1 st_1
pb_top pb_top
pb_back pb_back
pb_next pb_next
pb_bottom pb_bottom
end type
global w_mant_proveedores w_mant_proveedores

type variables
datawindow idw_1, idw_2, idw_3, idw_5
datawindowchild idwc_region, idwc_tipo
window iw_window
integer il_tab_activo
boolean ib_cerrar
string is_user, is_cuenta
end variables

forward prototypes
public subroutine wf_setear_user (string as_user)
public function boolean wf_cambiar_limite ()
public function boolean wf_asigna_antig ()
public function boolean wf_actualiza_antiguedad (datetime adt_desde, datetime adt_hasta, long al_tercero)
public function boolean wf_antiguedad ()
public function boolean wf_grabar_cliente (datawindow adw_1, long fila)
end prototypes

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

public function boolean wf_asigna_antig ();string ls_error

  DELETE FROM cpatpan  
   WHERE ( cpatpan.tpan_g_financiero = :str.g_financiero ) AND  
         ( cpatpan.tpan_empresa = :str.empresa ) AND  
         ( cpatpan.tpan_maquina = :str.maquina )   ;
	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje('Aviso','Error al eliminar cpatpan',ls_error)
		return false
	end if
	
	/* Inserta los nuevos valores */ 
  INSERT INTO cpatpan  
         ( tpan_g_financiero,tpan_empresa,tpan_tercero,tpan_saldo_anterior,
           tpan_col1,tpan_col2, tpan_col3,tpan_col4,tpan_col5,tpan_col6,   
           tpan_col7,tpan_col8,  tpan_col9, tpan_col10,tpan_col11,tpan_col12, 
           tpan_col13,tpan_col21,tpan_col1_t,tpan_col2_t,tpan_col3_t,   
           tpan_col4_t, tpan_col5_t,tpan_col6_t,tpan_col7_t,tpan_col8_t,   
           tpan_col9_t,tpan_col10_t,tpan_col11_t,tpan_col12_t,tpan_col13_t,
           tpan_col21_t,tpan_maquina)   
  SELECT cpatempa.tmpa_g_financiero,   
         cpatempa.tmpa_empresa,   
         cpatempa.tmpa_tercero,
			max( case cpatempa.tmpa_orden when 21 then cpatempa.tmpa_saldo_anterior  else cpatempa.tmpa_saldo_anterior end ),
			sum( case cpatempa.tmpa_orden when 1 then cpatempa.tmpa_monto else 0 end ),   
			sum( case cpatempa.tmpa_orden when 2 then cpatempa.tmpa_monto else 0 end ),   
			sum( case cpatempa.tmpa_orden when 3 then cpatempa.tmpa_monto else 0 end ),   
			sum( case cpatempa.tmpa_orden when 4 then cpatempa.tmpa_monto else 0 end ),   
			sum( case cpatempa.tmpa_orden when 5 then cpatempa.tmpa_monto else 0 end ),   
			sum( case cpatempa.tmpa_orden when 6 then cpatempa.tmpa_monto else 0 end ),   
			sum( case cpatempa.tmpa_orden when 7 then cpatempa.tmpa_monto else 0 end ),   
			sum( case cpatempa.tmpa_orden when 8 then cpatempa.tmpa_monto else 0 end ),   
			sum( case cpatempa.tmpa_orden when 9 then cpatempa.tmpa_monto else 0 end ),   
			sum( case cpatempa.tmpa_orden when 10 then cpatempa.tmpa_monto else 0 end ),  
			sum( case cpatempa.tmpa_orden when 11 then cpatempa.tmpa_monto else 0 end ),  
			sum( case cpatempa.tmpa_orden when 12 then cpatempa.tmpa_monto else 0 end ),  
			sum( case cpatempa.tmpa_orden when 13 then cpatempa.tmpa_monto else 0 end ),  
			sum( case cpatempa.tmpa_orden when 21 then cpatempa.tmpa_monto else 0 end ),   
         max( case cpatempa.tmpa_orden when 1 then cpatempa.tmpa_descantig  else '' end ),
         max( case cpatempa.tmpa_orden when 2 then cpatempa.tmpa_descantig  else '' end ),
         max( case cpatempa.tmpa_orden when 3 then cpatempa.tmpa_descantig  else '' end ),
         max( case cpatempa.tmpa_orden when 4 then cpatempa.tmpa_descantig  else '' end ),
         max( case cpatempa.tmpa_orden when 5 then cpatempa.tmpa_descantig  else '' end ),
         max( case cpatempa.tmpa_orden when 6 then cpatempa.tmpa_descantig  else '' end ),
         max( case cpatempa.tmpa_orden when 7 then cpatempa.tmpa_descantig  else '' end ),
         max( case cpatempa.tmpa_orden when 8 then cpatempa.tmpa_descantig  else '' end ),
         max( case cpatempa.tmpa_orden when 9 then cpatempa.tmpa_descantig  else '' end ),
         max( case cpatempa.tmpa_orden when 10 then cpatempa.tmpa_descantig  else '' end ),
         max( case cpatempa.tmpa_orden when 11 then cpatempa.tmpa_descantig  else '' end ),
         max( case cpatempa.tmpa_orden when 12 then cpatempa.tmpa_descantig  else '' end ),
         max( case cpatempa.tmpa_orden when 13 then cpatempa.tmpa_descantig  else '' end ),
         max( case cpatempa.tmpa_orden when 21 then cpatempa.tmpa_descantig  else '' end ),
			max(cpatempa.tmpa_maquina) FROM cpatempa 
WHERE ( cpatempa.tmpa_g_financiero = :str.g_financiero ) AND  
      ( cpatempa.tmpa_empresa = :str.empresa ) and
		( cpatempa.tmpa_maquina = :str.maquina)
GROUP BY cpatempa.tmpa_g_financiero,   
         cpatempa.tmpa_empresa,   
         cpatempa.tmpa_tercero ;
if sqlca.sqlcode = -1 then
	ls_error = sqlca.sqlerrtext
	rollback;
	mensaje('Aviso ','Error al insertar en cpatpan',ls_error)
	return false
else	
	commit ; 
	//mensaje('','Inserto en cpaTPAN','')
	
end if

return true
end function

public function boolean wf_actualiza_antiguedad (datetime adt_desde, datetime adt_hasta, long al_tercero);
Integer  li_registros, li_i, li_empresa, li_grupofin, li_emp, li_dberror, &
         li_tipo, li_socio, li_audit
decimal  ld_x, ld_y, ld_monto
string   ls_db_err,ls_where_select, ls_error,ls_error_proc
long 		ll_tercero,ll_i,ll_proximo
Datetime ld_tiempo1, ld_tiempo2

DELETE FROM cpatempa
WHERE ( cpatempa.tmpa_g_financiero 	= :str.g_financiero 	) AND  
      ( cpatempa.tmpa_empresa 		= :str.empresa 		) and
		( cpatempa.tmpa_maquina = :str.maquina 		) ;
if sqlca.sqlcode = -1 then
	messagebox('error','error al elimianr registros desde ccatempa')
end if

//datastore	lds_tercero_empresa, lds_tercero_gf,lds_cliente, lds_tercero_pais
Datawindowchild ldwc_sub_tran, ldwc_pais, ldwc_region

ld_tiempo1 = adt_desde
ld_tiempo2 = adt_hasta

ll_tercero = al_tercero
				
gf_cp_antiguedad_x_proveedor_prueba(datetime(ld_tiempo2),ll_tercero)

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
if tab_1.tabpage_2.dw_4.retrieve(str.g_financiero, str.empresa, ll_tercero, str.maquina) = 0 then
	tab_1.tabpage_2.dw_4.insertrow(1)
end if
return true
end function

public function boolean wf_grabar_cliente (datawindow adw_1, long fila);long ll_pais, ll_tercero, ll_encontro
decimal{2} ld_cargo_mora, ld_limite_credito, ld_limite_anterior
integer li_morosidad, li_vendedor, li_existe
string ls_cuenta, ls_estado, ls_detalle, ls_foto, ls_tipo
string ls_contacto, ls_cargo, ls_observacion, ls_telefono, ls_codigo, ls_ruc, ls_tipo_persona, ls_digito		
integer li_pais, li_tipo
datetime ldt_fecha

		
		fila = 1
		
		if adw_1.getitemnumber(fila,'dgmterce_terc_region') = 0 or isnull(adw_1.getitemnumber(fila,'dgmterce_terc_region')) then
			gf_mensaje('','Asigne la region a la que pertenece el proveedor',1,1,'E')
			adw_1.setcolumn('dgmterce_terc_region')
			return false
		end if
		
		if adw_1.getitemnumber(fila,'dgmterce_terc_pais') = 0 or isnull(adw_1.getitemnumber(fila,'dgmterce_terc_pais')) then
			gf_mensaje('','Asigne el pais al que pertenece el proveedor',1,1,'E')
			adw_1.setcolumn('dgmterce_terc_pais')			
			return false
		end if
		
		if adw_1.getitemstring(fila,'prov_cod_proveedor') = '' or isnull(adw_1.getitemString(fila,'prov_cod_proveedor')) then
			gf_mensaje('','Asigne la cuenta del proveedor',1,1,'E')
			adw_1.setcolumn('prov_cod_proveedor')
			return false
		end if
		
		ls_cuenta	= adw_1.getitemstring(fila, 'cpmprove_prov_mg_cuenta')					
		if trim(ls_cuenta) = '' or isnull(ls_cuenta) then
			gf_mensaje('','Asigne la cuenta contable del proveedor',1,1,'E')
			tab_1.selectedtab = 2
			tab_1.tabpage_2.dw_2.setcolumn('cpmprove_prov_mg_cuenta')
			return false
		end if
		
		sqlca.autocommit = false
		
		if adw_1.update() = -1 then
		  if sqlca.sqlcode = -1 then
			 gf_mensaje('','Error al Actualizar clientes dw_1 '+sqlca.sqlerrtext,1,1,'E')
			 rollback ;
			 sqlca.autocommit = true
			 return false
		  end if
		else

			ls_contacto = adw_1.getitemstring(fila, 'prov_contacto')
			ls_cargo		= adw_1.getitemstring(fila, 'prov_contacto_cargo')
			ls_telefono	= adw_1.getitemstring(fila, 'prov_contacto_telefono')
			ls_codigo	= adw_1.getitemstring(fila, 'prov_cod_proveedor')
			ls_observacion = adw_1.getitemstring(fila, 'prov_comentario')
			ll_tercero	= adw_1.getitemnumber(fila,'terc_tercero')
			ls_ruc		= adw_1.getitemstring(fila, 'dgmterce_terc_identificacion')
			li_pais		= adw_1.getitemnumber(fila, 'dgmterce_terc_pais')
			ls_tipo_persona = adw_1.getitemstring(fila, 'dgmterce_terc_tipo_persona')
			ls_digito	= adw_1.getitemstring(fila, 'dgmterce_terc_digito_verificador')
			ls_tipo		= adw_1.getitemstring(fila, 'prov_clasificacion')
		  SELECT count(*)
			 INTO :li_existe  
			 FROM cpmprove  
			WHERE ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
					( cpmprove.prov_empresa = :str.empresa ) AND  
					( cpmprove.prov_tercero = :ll_tercero ) ;

				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al validar proveedor '+sqlca.sqlerrtext,1,1,'E')
				end if				
			if li_existe = 0 or isnull(li_existe) then //Si no existe, crea el proveedor
		
			  INSERT INTO cpmprove  
					( prov_g_financiero,   
					  prov_empresa,   
					  prov_tercero,   
					  prov_mg_cuenta,   
					  prov_cod_proveedor,   
					  prov_limite_credito,   
					  prov_ruc_tercero,   
					  prov_contacto,   
					  prov_contacto_cargo,   
					  prov_contacto_telefono,   
					  prov_clasificacion,   
					  prov_comentario,   
					  prov_estado,   
					  prov_pais,   
					  prov_contrato_s_n,   
					  prov_digito_verificador,   
					  prov_tipo_persona)  
		  VALUES ( :str.g_financiero,   
					  :str.empresa,   
					  :ll_tercero,   
					  :ls_cuenta,   
					  :ls_codigo,   
					  999999,   
					  :ls_ruc,   
					  :ls_contacto,   
					  :ls_cargo,   
					  :ls_telefono,   
					  :ls_tipo,   
					  :ls_observacion,   
					  'A',   
					  :li_pais,    
					  0,   
					  :ls_digito,   
					  :ls_tipo_persona)  ;
			  
				  if sqlca.sqlcode = -1 then
					 gf_mensaje('','Error al Insertar proveedor '+sqlca.sqlerrtext,1,1,'E')
					 rollback ;
					 sqlca.autocommit = true
					 return	false
				  end if
			
			else //Si ya existe, actualiza los datos
							
				update cpmprove  
					set prov_cod_proveedor = :ls_codigo,   
						  prov_ruc_tercero = :ls_ruc,    
						  prov_contacto = :ls_contacto,   
						  prov_contacto_cargo = :ls_cargo,      
						  prov_contacto_telefono = :ls_telefono,   
						  prov_comentario = :ls_observacion,   
						  prov_pais	= :li_pais,    
						  prov_contrato_s_n = 0,   
						  prov_digito_verificador =  :ls_digito,
						  prov_tipo_persona = :ls_tipo_persona,
						  prov_clasificacion = :ls_tipo,
						  prov_mg_cuenta = :ls_cuenta
				  where prov_g_financiero = :str.g_financiero and
						  prov_empresa		= :str.empresa and
						  prov_tercero		= :ll_tercero ;
				  if sqlca.sqlcode = -1 then
					 gf_mensaje('','Error al Actualizar proveedor '+sqlca.sqlerrtext,1,1,'E')
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
		
		end if //del update del dw_1

		commit;
		
		sqlca.autocommit = true

return true
end function

on w_mant_proveedores.create
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

on w_mant_proveedores.destroy
call super::destroy
destroy(this.st_1)
destroy(this.pb_top)
destroy(this.pb_back)
destroy(this.pb_next)
destroy(this.pb_bottom)
end on

event ue_post_open;call super::ue_post_open;str_cc_formatos  lstr_formato
long ll_tercero, ll_encontro, ll_codigo
string ls_codigo
integer li_existe
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
idw_1.getchild('prov_clasificacion',idwc_tipo)
idwc_tipo.settransobject(sqlca)
idwc_tipo.retrieve(str.g_financiero, str.empresa)
idwc_tipo.insertrow(0)
idw_1.insertrow(1)


lstr_formato = Message.PowerObjectParm

if isvalid(lstr_formato) then
	ll_tercero = lstr_formato.tercero
end if

idw_1.setfocus()

SELECT dgmempre.empr_cuenta_cxp_default  
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
	from dgmterce 
	where terc_tercero <> 99999 ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al seleccionar tercero',1,1,'E')
	end if	
	
	li_existe = 1
	ll_tercero ++
	
	do while li_existe > 0
			//verifica que no exista
			select count(*) into :li_existe
			from dgmterce 
			where terc_tercero = :ll_tercero ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al validar tercero',1,1,'E')
			end if	
			if li_existe > 0 then
				ll_tercero ++
			end if
	loop
	
	//Busca el proveedor
	
	  SELECT max(convert(numeric(8), prov_cod_proveedor))
		 INTO :ll_codigo  
		 FROM cpmprove  
		WHERE ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
				( cpmprove.prov_empresa = :str.empresa ) ;
		if sqlca.sqlcode = -1 then
			//gf_mensaje('','Error al seleccionar proveedor',1,1,'E')
		end if
		
	ll_codigo ++
	li_existe = 1
	do while li_existe > 0
			ls_codigo = string(ll_codigo)
			//verifica que no exista
			select count(*) into :li_existe
			from cpmprove 
			where prov_cod_proveedor = :ls_codigo and
					prov_g_financiero = :str.g_financiero and
					prov_empresa		= :str.empresa ;					
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al validar proveedores',1,1,'E')
			end if	
			if li_existe > 0 then
				ll_codigo ++
			end if
	loop			
	idw_1.setitem(1,'prov_cod_proveedor',ls_codigo)				
	idw_1.setitem(1,'terc_tercero',ll_tercero)	
	idw_1.setitem(1,'cpmprove_prov_mg_cuenta',is_cuenta)		
end if

//idw_2.getchild('ccmclien_clie_limite_morosidad', ldwc_dias)
idw_2.getchild('cpmprove_prov_mg_cuenta', ldwc_cuentas)  
ldwc_cuentas.settransobject(sqlca)
ldwc_dias.settransobject(sqlca)
ldwc_dias.retrieve(str.g_financiero, str.empresa)
ldwc_cuentas.retrieve(str.g_financiero, str.empresa)
idw_1.setitemstatus(1,0,primary!,NotModified!) 
idw_2.setitemstatus(1,0,primary!,NotModified!) 
idw_1.sharedata(idw_2)
end event

event ue_adicionar;//override
long ll_tercero, ll_codigo
integer li_existe
string ls_codigo
idw_1.reset()
idw_1.insertrow(1)
idw_1.setcolumn('terc_tercero')
select max(terc_tercero) into :ll_tercero
from dgmterce ;
//where terc_tipop = 1;
if sqlca.sqlcode = -1 then
	gf_mensaje('','Error al seleccionar tercero',1,1,'E')
end if
	
	ll_tercero ++
	li_existe = 1
	do while li_existe > 0
			//verifica que no exista
			select count(*) into :li_existe
			from dgmterce 
			where terc_tercero = :ll_tercero ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al validar tercero',1,1,'E')
			end if	
			if li_existe > 0 then
				ll_tercero ++
			end if
	loop
	
	  SELECT max(convert(numeric(8), prov_cod_proveedor))
		 INTO :ll_codigo  
		 FROM cpmprove  
		WHERE ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
				( cpmprove.prov_empresa = :str.empresa ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al seleccionar proveedor',1,1,'E')
		end if
	ll_codigo ++
	li_existe = 1
	do while li_existe > 0
			ls_codigo = string(ll_codigo)
			//verifica que no exista
			select count(*) into :li_existe
			from cpmprove 
			where prov_cod_proveedor = :ls_codigo and
					prov_g_financiero = :str.g_financiero and
					prov_empresa		= :str.empresa ;					
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al validar proveedores',1,1,'E')
			end if	
			if li_existe > 0 then
				ll_codigo ++
			end if
	loop		

	
idw_1.setitem(1,'terc_tercero',ll_tercero)		
idw_1.setitem(1,'prov_cod_proveedor',ls_codigo)		
idw_1.setcolumn('dgmterce_terc_descripcion')
end event

event ue_aceptar;//override
wf_grabar_cliente(tab_1.tabpage_1.dw_1, 1)			

end event

event close;call super::close;
w_hs_frame.Post Event ue_evaluar_panel_acciones()
This.SetRedraw(false)
close(this)
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
this.triggerevent("ue_valida_todo")
end event

event ue_valida_todo;//override

integer li_cont
Boolean lb_r


FOR li_cont = 1 TO 1
	
	lb_r = w_valida_yguar(li_cont,li_cont)

	
NEXT














end event

event open;call super::open;//this.y = 0
//this.x = 805

w_hs_frame.Post Event ue_evaluar_panel_acciones()
 
end event

event ue_print;call super::ue_print;	OpenSheet(w_impresion_proveedores,str.frame,2,Original!)		
end event

event ue_eliminar;//Override
	long ll_tercero, li_contador
	string ls_error
		ll_tercero = idw_1.getitemnumber(idw_1.getrow(), 'terc_tercero')		
		
		select count(*) into :li_contador
		from cptmovim
		where movi_g_financiero = :str.g_financiero and
				movi_empresa		= :str.empresa and
				movi_tercero		= :ll_tercero ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al validar existencia '+sqlca.sqlerrtext,1,1,'E')
				end if
		if li_contador > 0 then
			gf_mensaje('','El Proveedor tiene movimientos registrados, no se puede eliminar, Verifique !!!',1,1,'E')
			return
		end if
		
		if gf_mensaje('','Esta Seguro de Eliminar el Proveedor ?',2,1,'E') = 1 then
			sqlca.autocommit = false

			  DELETE FROM cpmprove
				WHERE ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
						( cpmprove.prov_empresa = :str.empresa ) AND  
						( cpmprove.prov_tercero = :ll_tercero )   ;
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					gf_mensaje('','Error al Eliminar Proveedor '+ls_error,1,1,'E')				
					sqlca.autocommit = true
					return
				end if
			
			idw_1.deleterow(idw_1.getrow())			
			if idw_1.update() = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				gf_mensaje('','Error al Elimiar Proveedor '+ls_error,1,1,'E')				
				sqlca.autocommit = true
				return
			else
				commit;
			end if
			sqlca.autocommit = true			
			idw_1.insertrow(1)
			select max(terc_tercero) into :ll_tercero
			from dgmterce 
			where terc_tipop = 1;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al seleccionar tercero',1,1,'E')
			end if
			idw_1.setitem(1,'terc_tercero',ll_tercero + 1)					

		end if

end event

type tab_1 from w_grampa_tab`tab_1 within w_mant_proveedores
integer x = 23
integer y = 24
integer width = 2409
integer height = 1704
long backcolor = 12639424
boolean fixedwidth = true
boolean powertips = true
boolean boldselectedtext = true
boolean pictureonright = true
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
integer height = 1576
long backcolor = 12639424
string pointer = "HyperLink!"
string text = "Generales"
long tabbackcolor = 12632256
string picturename = "Custom039!"
long picturemaskcolor = 553648127
string powertiptext = "Datos Generales del Cliente"
dw_5 dw_5
end type

on tabpage_1.create
this.dw_5=create dw_5
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_5
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_5)
end on

type dw_1 from w_grampa_tab`dw_1 within tabpage_1
event ue_down pbm_dwnkey
integer x = 0
integer y = 44
integer width = 2377
integer height = 1528
string dataobject = "dw_mant_proveedores"
boolean border = false
end type

event dw_1::ue_down;if keydown(Keyescape!) then
	iw_window.postevent('close')
end if
end event

event dw_1::buttonclicked;call super::buttonclicked;	String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error
	integer li_c, li_b
	long    ll_lter, ll_encontro
	
	choose case dwo.name
			
		case	'b_cliente', 'b_cuenta'		
		
		str_dg_dynamic_find	lstr_df
	
		lstr_df.texto_campo [2,1] = "cpmprove.prov_cod_proveedor" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [2,2] = "Cuenta"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '450'
		lstr_df.texto_campo [1,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [1,2] = "Descripción"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '700'		
		lstr_df.texto_campo [4,1] = "dgmterce.terc_tercero"
		lstr_df.texto_campo [4,2] = "Código Tercero"
		lstr_df.texto_campo [4,3] = "terc_tercero"
		lstr_df.texto_campo [4,4] = 'V'
		lstr_df.texto_campo [3,1] = "dgapais.pais_descripcion"
		lstr_df.texto_campo [3,2] = "País"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [3,5] = '550'
		
		lstr_df.tabla = " dgmterce, dgapais, cpmprove "
		
		
		lstr_df.tabla_where = &
					"WHERE ( dgmterce.terc_pais = dgapais.pais_pais ) and  " +&				
							 "(cpmprove.prov_g_financiero = " + string(str.g_financiero) + " and " +&
							 "cpmprove.prov_empresa = " + string(str.empresa) + ") 	and " +&
							"(dgmterce.terc_tercero = cpmprove.prov_tercero)"
		
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
	
end choose
end event

event dw_1::itemchanged;call super::itemchanged;long ll_tercero, ll_pais
integer li_existe
string ls_cuenta
idw_1.accepttext()
//datawindowsstatus ldws_estado
choose case this.getcolumnname()
	case "terc_tercero"
		
//		w_valida_yguar(1,1)
		
		ll_tercero = long(data)
		  SELECT count(*)
			 INTO :li_existe  
			 FROM cpmprove  
			WHERE ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
					( cpmprove.prov_empresa = :str.empresa ) AND  
					( cpmprove.prov_tercero = :ll_tercero ) ;
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
				end if
			end if
//			this.setitem(1,'cambiar_limite',0)
			this.setitemstatus(1,0,primary!,NotModified!) 			
			
		case "prov_cod_proveedor"			
			
			ls_cuenta = data
			
			  SELECT count(*)
				 INTO :ll_tercero
				 FROM cpmprove  
				WHERE ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
						( cpmprove.prov_empresa = :str.empresa ) AND  
						( cpmprove.prov_cod_proveedor = :ls_cuenta ) ;
						
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al validar proveedor '+sqlca.sqlerrtext,1,1,'E')
						return
					end if
			
				if ll_tercero = 0 or isnull(ll_tercero) then
					//valida que el codigo del tercero no exista, para permitir la captura
					ll_tercero = this.getitemnumber(row,'terc_tercero')
					  SELECT count(*)
						 INTO :li_existe
						 FROM cpmprove  
						WHERE ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
								( cpmprove.prov_empresa = :str.empresa ) AND  
								( cpmprove.prov_tercero = :ll_tercero ) ;

							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al validar proveedor '+sqlca.sqlerrtext,1,1,'E')
								return
							end if
					//si existe, crea un nuevo registro para captar		
					if li_existe > 0 then															
						this.reset()
						this.insertrow(1)
						this.setcolumn('terc_tercero')
						select max(terc_tercero) into :ll_tercero
						from dgmterce
						where terc_tipop = 1;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al seleccionar tercero',1,1,'E')
						end if
						this.setitem(1,'terc_tercero',ll_tercero + 1)
						this.setitem(1,'prov_cod_proveedor',ls_cuenta)
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
//				this.setitem(1,'cambiar_limite',0)				
				this.setitemstatus(1,0,primary!,NotModified!) 				
		case "dgmterce_terc_pais"
			idwc_region.Retrieve (long (data))
			idw_1.setitem(1,'dgmterce_terc_region',0)
			
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
		from dgmterce 
		where terc_tipop = 1;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al seleccionar tercero',1,1,'E')
		end if
		ll_tercero ++
		li_existe = 1
		do while li_existe > 0
				//verifica que no exista
				select count(*) into :li_existe
				from dgmterce 
				where terc_tercero = :ll_tercero ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al validar tercero',1,1,'E')
				end if	
				if li_existe > 0 then
					ll_tercero ++
				end if
		loop
		
	  SELECT max(convert(numeric(8), prov_cod_proveedor))
		 INTO :ll_codigo  
		 FROM cpmprove  
		WHERE ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
				( cpmprove.prov_empresa = :str.empresa ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al seleccionar proveedor',1,1,'E')
		end if
	ll_codigo ++
	li_existe = 1
	do while li_existe > 0
			ls_codigo = string(ll_codigo)
			//verifica que no exista
			select count(*) into :li_existe
			from cpmprove 
			where prov_cod_proveedor = :ls_codigo and
					prov_g_financiero = :str.g_financiero and
					prov_empresa		= :str.empresa ;					
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al validar proveedores',1,1,'E')
			end if	
			if li_existe > 0 then
				ll_codigo ++
			end if
	loop		
	
		this.setitem(1,'prov_cod_proveedor',ls_codigo)						
		this.setitem(1,'terc_tercero',ll_tercero)		
		this.setcolumn('dgmterce_terc_descripcion')
		this.setitem(1,'cpmprove_prov_mg_cuenta',is_cuenta)		
			
	case 'b_eliminar_cli'
		
		string ls_error
		ll_tercero = this.getitemnumber(this.getrow(), 'terc_tercero')		
		
		select count(*) into :li_contador
		from cptmovim
		where movi_g_financiero = :str.g_financiero and
				movi_empresa		= :str.empresa and
				movi_tercero		= :ll_tercero ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al validar existencia '+sqlca.sqlerrtext,1,1,'E')
				end if
		if li_contador > 0 then
			gf_mensaje('','El Proveedor tiene movimientos registrados, no se puede eliminar, Verifique !!!',1,1,'E')
			return
		end if
		
		if gf_mensaje('','Esta Seguro de Eliminar el Proveedor ?',2,1,'E') = 1 then
			sqlca.autocommit = false

			  DELETE FROM cpmprove
				WHERE ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
						( cpmprove.prov_empresa = :str.empresa ) AND  
						( cpmprove.prov_tercero = :ll_tercero )   ;
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					gf_mensaje('','Error al Eliminar Proveedor '+ls_error,1,1,'E')				
					sqlca.autocommit = true
					return
				end if
			
			this.deleterow(this.getrow())			
			if this.update() = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				gf_mensaje('','Error al Elimiar Proveedor '+ls_error,1,1,'E')				
				sqlca.autocommit = true
				return
			else
				commit;
			end if
			sqlca.autocommit = true			
			this.insertrow(1)
			select max(terc_tercero) into :ll_tercero
			from dgmterce 
			where terc_tipop = 1;
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

type tabpage_2 from w_grampa_tab`tabpage_2 within tab_1
integer width = 2373
integer height = 1576
long backcolor = 12639424
string pointer = "HyperLink!"
string text = "Financiera"
long tabbackcolor = 12632256
string picturename = "Cursor!"
string powertiptext = "Datos Financiero"
dw_4 dw_4
cb_2 cb_2
pb_1 pb_1
st_2 st_2
end type

on tabpage_2.create
this.dw_4=create dw_4
this.cb_2=create cb_2
this.pb_1=create pb_1
this.st_2=create st_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.st_2
end on

on tabpage_2.destroy
call super::destroy
destroy(this.dw_4)
destroy(this.cb_2)
destroy(this.pb_1)
destroy(this.st_2)
end on

type dw_2 from w_grampa_tab`dw_2 within tabpage_2
event ue_down pbm_dwnkey
integer x = 41
integer y = 48
integer width = 2331
integer height = 1496
string dataobject = "dw_financiera_proveedores"
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
integer height = 1576
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
string dataobject = "dw_buscar_proveedor"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_4 from datawindow within tabpage_2
integer x = 1458
integer y = 344
integer width = 782
integer height = 764
integer taborder = 14
boolean bringtotop = true
string title = "none"
string dataobject = "dw_antiguedad_cxp"
boolean livescroll = true
end type

type cb_2 from commandbutton within tabpage_2
integer x = 503
integer y = 816
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

event clicked;long ll_tercero
date fecha, fecha1

	fecha	= relativedate(date(gf_fecha_serv()), - 365)
//	fecha = date('01/01/'+string(year(date(gf_fecha_serv()))))
	fecha1 = date(gf_fecha_serv())
			
	str_rangofecha str_formato1		
	str_formato1.codigo = idw_1.getitemNumber(1,"terc_tercero")
	str_formato1.fecha1  = fecha
	str_formato1.fecha2  = fecha1	
	Opensheetwithparm(w_estadocuenta_imp_cxp,str_formato1,str.frame,2,layered!)
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
integer x = 1879
integer y = 1400
integer width = 279
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
string text = "Notas del Proveedor"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_mant_proveedores
integer x = 846
integer y = 1328
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
long backcolor = 12639424
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type pb_top from picturebutton within w_mant_proveedores
integer x = 891
integer y = 1348
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
string picturename = "C:\sistemas\hymsoft\art\WZTOP.BMP"
alignment htextalign = left!
end type

event clicked;iw_window.triggerevent('ue_primer_reg')
end event

type pb_back from picturebutton within w_mant_proveedores
integer x = 1038
integer y = 1348
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
string picturename = "C:\sistemas\hymsoft\Art\WZBACK.BMP"
alignment htextalign = left!
end type

event clicked;iw_window.triggerevent('ue_reg_anterior')
end event

type pb_next from picturebutton within w_mant_proveedores
integer x = 1189
integer y = 1348
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
string picturename = "C:\sistemas\hymsoft\Art\WZNEXT.BMP"
alignment htextalign = left!
end type

event clicked;iw_window.triggerevent('ue_siguiente_reg')
end event

type pb_bottom from picturebutton within w_mant_proveedores
integer x = 1335
integer y = 1348
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
string picturename = "C:\sistemas\hymsoft\Art\WZEND.BMP"
alignment htextalign = left!
end type

event clicked;iw_window.triggerevent('ue_ultimo_reg')
end event

