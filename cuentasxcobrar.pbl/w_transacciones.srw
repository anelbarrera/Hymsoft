forward
global type w_transacciones from w_fa_padre
end type
type dw_2 from datawindow within w_transacciones
end type
type cb_1 from commandbutton within w_transacciones
end type
type cb_2 from commandbutton within w_transacciones
end type
type cb_3 from commandbutton within w_transacciones
end type
type pb_1 from picturebutton within w_transacciones
end type
type st_1 from statictext within w_transacciones
end type
type uo_1 from u_ddcalen within w_transacciones
end type
type dw_3 from datawindow within w_transacciones
end type
type dw_4 from datawindow within w_transacciones
end type
type dw_5 from datawindow within w_transacciones
end type
type dw_6 from datawindow within w_transacciones
end type
type uo_2 from u_ddcalen within w_transacciones
end type
end forward

global type w_transacciones from w_fa_padre
integer width = 4453
integer height = 2668
string title = "Captura de Transacciones de Clientes"
string menuname = "m_hs"
boolean controlmenu = false
long backcolor = 8421376
windowanimationstyle openanimation = leftroll!
windowanimationstyle closeanimation = leftslide!
dw_2 dw_2
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
pb_1 pb_1
st_1 st_1
uo_1 uo_1
dw_3 dw_3
dw_4 dw_4
dw_5 dw_5
dw_6 dw_6
uo_2 uo_2
end type
global w_transacciones w_transacciones

type variables
datawindowchild idwc_clientes, idwc_tran, idwc_stran, idwc_plan
string is_tran, is_stran, is_tran_automatica, is_historica, is_doc_anterior, is_ref_anterior, is_user
integer ii_ann, ii_ann_anterior, ii_cont_doc, ii_contador = 0, ii_repite_transaccion, ii_imprimir_al_grabar = 0
str_rangofecha istr_rangfech, lstr_rangfech
boolean ib_adicionar = false, ib_no_insertar = true
long il_tercero_anterior
end variables

forward prototypes
public function string wf_secuencia_tran ()
public function string wf_busca_cuenta_contable ()
public function long wf_buscar_cliente ()
public function boolean wf_restaura_saldos ()
public function boolean wf_asigna_cuenta (string as_tran)
public subroutine wf_actualiza_antiguedad (string idioma)
public function boolean wf_asigna_pagos ()
public function boolean wf_registra_asiento ()
public function boolean wf_guarda_facturas_pagadas ()
public subroutine wf_setear_user (string as_user)
end prototypes

public function string wf_secuencia_tran ();string ls_sec
long ll_max
integer li_existe, li_ann

li_ann = dw_1.getitemnumber(1,'movi_anno')

if is_tran <> 'ND' and  is_tran <> 'NC' then //Si la secuencia es por transaccion

		select max(convert(numeric(8),mser_secuencia))
		into :ll_max
		from dgmserie
		where mser_g_financiero = :str.g_financiero and
				mser_empresa		= :str.empresa and
				mser_tipo_transaccion = :is_tran ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al seleccionar secuencia '+sqlca.sqlerrtext,1,1,'E')
					return ''
				end if
				
		
			DO WHILE true
				ll_max = ll_max + 1		
				ls_sec = string(ll_max)
				
				select count(*) into :li_existe
				from cctmovim
				where movi_g_financiero = :str.g_financiero and
						movi_empresa		= :str.empresa and
						movi_tipo_transaccion = :is_tran and
		//				movi_sub_transaccion = :is_stran and
						movi_documento 	=  :ls_sec and
						movi_anno			=  :li_ann ;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al validar existencia '+sqlca.sqlerrtext,1,1,'E')
							return ''
						end if
										
			if li_existe = 0 then
				exit
			end if
	LOOP
	
else //Si la secuencia es por sub transaccion
	if str.nd_por_subtransaccion = 1 then
		select max(convert(numeric(8),subs_secuencia))
		into :ll_max
		from dgmsubse
		where subs_g_financiero = :str.g_financiero and
				subs_empresa		= :str.empresa and
				subs_transaccion = :is_tran and
				subs_sub_trans = :is_stran ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al seleccionar secuencia '+sqlca.sqlerrtext,1,1,'E')
					return ''
				end if
				
			DO WHILE true
				ll_max = ll_max + 1		
				ls_sec = string(ll_max)
				
				select count(*) into :li_existe
				from cctmovim
				where movi_g_financiero = :str.g_financiero and
						movi_empresa		= :str.empresa and
						movi_tipo_transaccion = :is_tran and
						movi_sub_transaccion = :is_stran and
						movi_documento 	=  :ls_sec and
						movi_anno			=  :li_ann ;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al validar existencia '+sqlca.sqlerrtext,1,1,'E')
							return ''
						end if
												
					if li_existe = 0 then
						exit
					end if
			LOOP
		
	    else //Si la secuencia es por transaccion no por sub trannsaccion
			
			select max(convert(numeric(8),mser_secuencia))
			into :ll_max
			from dgmserie
			where mser_g_financiero = :str.g_financiero and
					mser_empresa		= :str.empresa and
					mser_tipo_transaccion = :is_tran ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al seleccionar secuencia '+sqlca.sqlerrtext,1,1,'E')
						return ''
					end if
					
			
				DO WHILE true
					ll_max = ll_max + 1		
					ls_sec = string(ll_max)
					
					select count(*) into :li_existe
					from cctmovim
					where movi_g_financiero = :str.g_financiero and
							movi_empresa		= :str.empresa and
							movi_tipo_transaccion = :is_tran and
			//				movi_sub_transaccion = :is_stran and
							movi_documento 	=  :ls_sec and
							movi_anno			=  :li_ann ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al validar existencia '+sqlca.sqlerrtext,1,1,'E')
								return ''
							end if
											
				if li_existe = 0 then
					exit
				end if
			LOOP
					
		end if //si es por subtransaccion la secuencia	
end if
return ls_sec
end function

public function string wf_busca_cuenta_contable ();String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error
integer li_c, li_b
long    ll_lter, ll_encontro
		
	str_dg_dynamic_find	lstr_df

	lstr_df.texto_campo [1,1] = "dgmplanc.mg_cuenta" //"dgmterce.terc_identificacion"
	lstr_df.texto_campo [1,2] = "Cuenta"
	lstr_df.texto_campo [1,3] = "mg_cuenta"
	lstr_df.texto_campo [1,4] = 'V'
	lstr_df.texto_campo [1,5] = '300'
	lstr_df.texto_campo [2,1] = "dgmplanc.mg_descripcion"
	lstr_df.texto_campo [2,2] = "Descripción"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '1000'		
	lstr_df.texto_campo [3,1] = "case when dgmplanc.mg_tipo_cuenta = 'R' then 'RESUMEN' else 'DETALLE' end mg_tipo_cuenta"
	lstr_df.texto_campo [3,2] = "Tipo"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [3,5] = '250'
	
	lstr_df.tabla = " dgmplanc "
	
	
	lstr_df.tabla_where = &
				"WHERE (dgmplanc.mg_g_financiero = " + string(str.g_financiero) + " and " +&
						 "dgmplanc.mg_empresa = " + string(str.empresa) + ") and " +&
						 "(dgmplanc.mg_tipo_cuenta = 'D') and " +&
						 "(dgmplanc.mg_estado = 1 )"
	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm


If len (ls_find) = 0 Then Return ''
			
ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo1,"'"," ")
ls_codigo1 = Trim(ls_codigo1)

dw_3.setitem(dw_3.getrow(),'cuenta',ls_codigo1)
dw_3.setitem(dw_3.getrow(),'ddia_mg_cuenta',ls_codigo1)
dw_3.accepttext()

dw_3.setcolumn('cuenta')


return ls_codigo1
end function

public function long wf_buscar_cliente ();string ls_codigo1, ls_find
		
		str_dg_dynamic_find	lstr_df
	
		lstr_df.texto_campo [1,1] = "ccmclien.clie_ref_anterior" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [1,2] = "Cuenta"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '450'
		lstr_df.texto_campo [2,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [2,2] = "Descripción"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '700'		
		lstr_df.texto_campo [3,1] = "dgmterce.terc_tercero"
		lstr_df.texto_campo [3,2] = "Código Tercero"
		lstr_df.texto_campo [3,3] = "terc_tercero"
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [4,1] = "dgapais.pais_descripcion"
		lstr_df.texto_campo [4,2] = "País"
		lstr_df.texto_campo [4,3] = ""
		lstr_df.texto_campo [4,4] = 'V'
		lstr_df.texto_campo [4,5] = '550'
		
		lstr_df.tabla = " dgmterce, dgapais, ccmclien "
		
		
		lstr_df.tabla_where = &
					"WHERE ( dgmterce.terc_pais *= dgapais.pais_pais ) and  " +&				
							 "(ccmclien.clie_g_financiero = " + string(str.g_financiero) + " and " +&
							 "ccmclien.clie_empresa = " + string(str.empresa) + ") 	and " +&
							 "ccmclien.clie_estado = 'A' and " + & 
							"(dgmterce.terc_tercero = ccmclien.clie_tercero)"
		
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	If len (ls_find) = 0 Then Return 0
		
		
	ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo1,"'"," ")
	ls_codigo1 = Trim(ls_codigo1)

	dw_3.setitem(dw_3.getrow(),'ddia_tercero',long(ls_codigo1))
	dw_3.accepttext()
	
	dw_3.setcolumn('ddia_tercero')

return long(ls_codigo1)

end function

public function boolean wf_restaura_saldos ();string ls_app_ori, ls_tran_ori, ls_stran_ori, ls_doc_ori, ls_ref_ori
long ll_tercero
integer li_ann_ori
decimal{2} ld_monto

//declaracion del cursor de los saldos
 DECLARE cur_pagados CURSOR FOR  
  SELECT ccdrefac.refa_aplicacion_ori,   
         ccdrefac.refa_tipo_transaccion_ori,   
         ccdrefac.refa_sub_transaccion_ori,   
         ccdrefac.refa_documento_ori,   
         ccdrefac.refa_referencia_ori,   
         ccdrefac.refa_ann_ori,   
         ccdrefac.refa_monto_pagado,   
         ccdrefac.refa_tercero  
    FROM ccdrefac  
   WHERE ( ccdrefac.refa_g_financiero = :str.g_financiero ) AND  
         ( ccdrefac.refa_empresa = :str.empresa ) AND  
         ( ccdrefac.refa_tipo_transaccion = :is_tran ) AND  
         ( ccdrefac.refa_sub_transaccion = :is_stran ) AND  
         ( ccdrefac.refa_documento = :is_doc_anterior ) AND  
         ( ccdrefac.refa_referencia = :is_ref_anterior ) AND  
         ( ccdrefac.refa_ann = :ii_ann_anterior )  ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al declarar cursor '+sqlca.sqlerrtext,1,1,'E')
		rollback;
		return false
	end if
	
	open cur_pagados;
	
	fetch cur_pagados into :ls_app_ori, :ls_tran_ori, :ls_stran_ori, :ls_doc_ori, :ls_ref_ori, :li_ann_ori, :ld_monto, :ll_tercero ;
	
	do while sqlca.sqlcode = 0
		
		UPDATE cctmovim  
		  SET movi_saldo = movi_saldo + :ld_monto  
		WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
				( cctmovim.movi_empresa = :str.empresa ) AND  
				( cctmovim.movi_aplicacion = :ls_app_ori ) AND  
				( cctmovim.movi_tipo_transaccion = :ls_tran_ori ) AND  
				( cctmovim.movi_sub_transaccion = :ls_stran_ori ) AND  
				( cctmovim.movi_documento = :ls_doc_ori ) AND  
				( cctmovim.movi_referencia = :ls_ref_ori ) AND  
				( cctmovim.movi_anno = :li_ann_ori )     ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al atualizar documentos aplicados '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return false
			end if
			
		fetch cur_pagados into :ls_app_ori, :ls_tran_ori, :ls_stran_ori, :ls_doc_ori, :ls_ref_ori, :li_ann_ori, :ld_monto, :ll_tercero ;		
	loop

	close cur_pagados;
				
		//Elimina los documentos aplicados
		 DELETE FROM ccdrefac  
			WHERE ( ccdrefac.refa_g_financiero = :str.g_financiero ) AND  
					( ccdrefac.refa_empresa = :str.empresa ) AND  
					( ccdrefac.refa_tipo_transaccion = :is_tran ) AND  
					( ccdrefac.refa_sub_transaccion = :is_stran ) AND  
					( ccdrefac.refa_documento = :is_doc_anterior ) AND  
					( ccdrefac.refa_referencia = :is_ref_anterior ) AND  
					( ccdrefac.refa_ann = :ii_ann_anterior )  ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al eliminar documentos aplicados '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return false
			end if
			
return true
end function

public function boolean wf_asigna_cuenta (string as_tran);string ls_cuenta, ls_naturaleza

		ls_naturaleza = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_movimiento')		

		  SELECT isnull(dgmserdr.serd_mgcuenta  ,'')
			 INTO :ls_cuenta  
			 FROM dgmserdr  
			WHERE ( dgmserdr.serd_g_financiero = :str.g_financiero ) AND  
					( dgmserdr.serd_empresa = :str.empresa ) AND  
					( dgmserdr.serd_transaccion = :as_tran ) AND  
					( dgmserdr.serd_sub_trans = :is_stran ) AND  
					( dgmserdr.serd_aplicacion = 'CC' ) ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al buscar cuenta '+sqlca.sqlerrtext,1,1,'E')
					return false
				end if
		
			if ls_cuenta = '' then
				gf_mensaje('','Debe asignar la cuenta a la transaccion. Verifique !!!',1,1,'E')
				return false
			end if
					
			dw_3.setitem(1,'ddia_mg_cuenta',ls_cuenta)
			dw_3.setitem(1,'cuenta',ls_cuenta)
			if ls_naturaleza = 'D' then
				dw_3.setitem(1,'naturaleza','C')
			else
				dw_3.setitem(1,'naturaleza','D')			
			end if

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

public function boolean wf_asigna_pagos ();decimal{2} ld_monto, ld_saldo
integer i
boolean lb_no_asignar
ld_monto = dw_1.getitemnumber(1,'total_final')

		//Asigna el pago a los movimientos debitos
		for i = 1 to dw_5.rowcount()
			dw_5.setitem(i,'monto_aplica',0)
			ld_saldo = dw_5.getitemnumber(i,'movi_saldo')
			if ld_saldo >= ld_monto and not lb_no_asignar then
				dw_5.setitem(i,'monto_aplica',ld_monto)
				dw_5.setitem(i,'aplicar',1)
				ld_monto = ld_monto - ld_saldo
				lb_no_asignar = true
			else
				ld_monto = ld_monto - ld_saldo
				if ld_monto > 0 then
					dw_5.setitem(i,'monto_aplica',ld_saldo)
					dw_5.setitem(i,'aplicar',1)
				end if
			end if			
		next
return true
end function

public function boolean wf_registra_asiento ();integer li_existe
string ls_documento, ls_referencia, ls_descrip, ls_nombre, ls_comentario
decimal{2} ld_monto
datetime ldt_fecha, ldt_fecha_creacion

ls_documento = dw_1.getitemstring(1,'movi_documento')
ls_referencia = dw_1.getitemstring(1,'movi_referencia')
ls_comentario = dw_1.getitemstring(1,'movi_comments')

if is_historica = 'S' then	
	return true
end if

if (is_doc_anterior <> ls_documento or is_ref_anterior <> ls_referencia or ii_ann <> ii_ann_anterior) and (ii_ann_anterior <> 0 or is_doc_anterior <> '' or is_ref_anterior <> '' ) then
  
  dw_4.reset()
  dw_3.RowsCopy(1, dw_3.RowCount(), Primary!, dw_4, 1, Primary!)
  dw_3.reset()
  dw_4.RowsCopy(1, dw_4.RowCount(), Primary!, dw_3, 1, Primary!)
	
  DELETE FROM coddiari  
   WHERE ( coddiari.ddia_g_financiero = :str.g_financiero ) AND  
         ( coddiari.ddia_empresa = :str.empresa ) AND  
         ( coddiari.ddia_aplicacion_mg = 'CC' ) AND  
         ( coddiari.ddia_tipo_transaccion = :is_tran ) AND  
         ( coddiari.ddia_sub_trans = :is_stran ) AND  
         ( coddiari.ddia_no_documento = :is_doc_anterior ) AND  
         ( coddiari.ddia_no_referencia = :is_ref_anterior ) AND  
         ( coddiari.ddia_ann = :ii_ann_anterior ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Eliminar Encabezado del Asiento '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return false
		end if


  DELETE FROM cotdiari  
   WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
         ( cotdiari.diar_empresa = :str.empresa ) AND  
         ( cotdiari.diar_aplicacion_mg = 'CC' ) AND  
         ( cotdiari.diar_tipo_transaccion = :is_tran ) AND  
         ( cotdiari.diar_sub_trans = :is_stran ) AND  
         ( cotdiari.diar_no_documento = :is_doc_anterior ) AND  
         ( cotdiari.diar_no_referencia = :is_ref_anterior ) AND  
         ( cotdiari.diar_ann = :ii_ann_anterior ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Eliminar Encabezado del Asiento '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return false
		end if

end if // de la eliminacion, si la llave es diferente
ldt_fecha	 = dw_1.getitemdatetime(1,'movi_fecha_tran')
ld_monto		 = dw_1.getitemnumber(1,'movi_monto')
ldt_fecha_creacion = gf_fecha_serv()
ls_descrip	 = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_descripcion')
ls_nombre	 = dw_1.getitemstring(1,'movi_a_nombre')

  SELECT count(*)  
    INTO :li_existe  
    FROM cotdiari  
   WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
         ( cotdiari.diar_empresa = :str.empresa ) AND  
         ( cotdiari.diar_aplicacion_mg = 'CC' ) AND  
         ( cotdiari.diar_tipo_transaccion = :is_tran ) AND  
         ( cotdiari.diar_sub_trans = :is_stran ) AND  
         ( cotdiari.diar_no_documento = :ls_documento ) AND  
         ( cotdiari.diar_no_referencia = :ls_referencia ) AND  
         ( cotdiari.diar_ann = :ii_ann )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Validar Existencia '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return false
		end if

	if li_existe = 0 then

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
           diar_impreso,
			  diar_comentario)  
  VALUES ( :str.g_financiero,   
           :str.empresa,   
           'CC',   
           :is_tran,   
           :is_stran,   
           :ls_documento,   
           :ls_referencia,   
           '1',   
           :ii_ann,   
           :ldt_fecha,   
           :ls_descrip,   
           :str.usuario,   
           getdate(),   
           'I',   
           :ld_monto,   
           1,   
           0,   
           'N',   
           'N',   
           null,   
           null,   
           :ls_nombre,   
           'N',
			  :ls_comentario)  ;
			  if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Insertar En Contabilidad '+sqlca.sqlerrtext,1,1,'E')
					rollback;
					return false
			  end if
		
	else  // si ya existe se hace update
		
		  UPDATE cotdiari  
		  SET diar_fecha_transaccion = :ldt_fecha,   
				diar_descripcion = :ls_descrip,   
				diar_id = :str.usuario,   
				diar_monto = :ld_monto,   
				diar_nombre = :ls_nombre ,
				diar_comentario = :ls_comentario
		WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
				( cotdiari.diar_empresa = :str.empresa ) AND  
				( cotdiari.diar_aplicacion_mg = 'CC' ) AND  
				( cotdiari.diar_tipo_transaccion = :is_tran ) AND  
				( cotdiari.diar_sub_trans = :is_stran ) AND  
				( cotdiari.diar_no_documento = :ls_documento ) AND  
				( cotdiari.diar_no_referencia = :ls_referencia ) AND  
				( cotdiari.diar_ann = :ii_ann ) ;
			  if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
					rollback;
					return false
			  end if
		
	end if
		

return true
end function

public function boolean wf_guarda_facturas_pagadas ();Integer i, li_ann, li_ann_fac, li_aplicar
long ll_cliente
string ls_factura, ls_referencia_fac , ls_tran_fac, ls_stran_fac, ls_app_fac, ls_documento, ls_referencia
decimal{2} ld_monto_aplica, ld_saldo, ld_monto_aplicado
datetime ldt_fecha_recibo, ldt_fecha_factura

ls_documento  = dw_1.getitemstring(1,'movi_documento')
ls_referencia = dw_1.getitemstring(1,'movi_referencia')
li_ann		  = dw_1.getitemnumber(1,'movi_anno')
ldt_fecha_recibo = dw_1.getitemdatetime(1,'movi_fecha_tran')
ll_cliente 	  = dw_1.getitemnumber(1,'movi_tercero')

//si se cambio el cliente, restaura los saldos anteriores y luego inserta los nuevos, 
if il_tercero_anterior <> ll_cliente  and il_tercero_anterior <> 0 then
	wf_restaura_saldos()
else
//Elimina los documentos aplicados
  DELETE FROM ccdrefac  
	WHERE ( ccdrefac.refa_g_financiero = :str.g_financiero ) AND  
			( ccdrefac.refa_empresa = :str.empresa ) AND  
			( ccdrefac.refa_tipo_transaccion = :is_tran ) AND  
			( ccdrefac.refa_sub_transaccion = :is_stran ) AND  
			( ccdrefac.refa_documento = :is_doc_anterior ) AND  
			( ccdrefac.refa_referencia = :is_ref_anterior ) AND  
			( ccdrefac.refa_ann = :ii_ann_anterior )  ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al eliminar documentos aplicados '+sqlca.sqlerrtext,1,1,'E')
		rollback;
		sqlca.autocommit = true
		return false
	end if

end if

for i = 1 to dw_5.rowcount()
	ls_factura = dw_5.getitemstring(i,'movi_documento')
	ls_referencia_fac = dw_5.getitemstring(i,'movi_referencia')
	li_ann_fac = dw_5.getitemnumber(i,'movi_anno')
	ls_tran_fac = dw_5.getitemstring(i,'movi_tipo_transaccion')
	ls_stran_fac = dw_5.getitemstring(i,'movi_sub_transaccion')	
	ls_app_fac = dw_5.getitemstring(i,'movi_aplicacion')
	ldt_fecha_factura = dw_5.getitemdatetime(i,'movi_fecha_tran')
	ld_monto_aplica = dw_5.getitemnumber(i,'monto_aplica')	
	
	ld_monto_aplicado = dw_5.getitemnumber(i,'movi_monto_aplicado')
	dw_5.setitem(i,'movi_monto_aplicado', ld_monto_aplicado + ld_monto_aplica)
	
	if ld_monto_aplica = 0 then continue
	li_aplicar	= dw_5.getitemnumber(i,'aplicar')
	if li_aplicar = 0 then continue

	ld_saldo 		 = dw_5.getitemnumber(i,'movi_saldo')	
	ld_saldo 		 = ld_saldo - ld_monto_aplica
	if ld_saldo < 0 then ld_saldo = 0
	dw_5.setitem(i,'movi_saldo',ld_saldo)
	
	  INSERT INTO ccdrefac  
         ( refa_g_financiero,   
           refa_empresa,   
           refa_tipo_transaccion,   
           refa_sub_transaccion,   
           refa_documento,   
           refa_referencia,   
           refa_ann,   
           refa_aplicacion_ori,   
           refa_tipo_transaccion_ori,   
           refa_sub_transaccion_ori,   
           refa_documento_ori,   
           refa_referencia_ori,   
           refa_ann_ori,   
           refa_monto_pagado,   
           refa_tercero,   
           refa_linea,   
           refa_fecha_recibo,   
           refa_fecha_factura,   
           refa_usuario )  
  VALUES ( :str.g_financiero,   
           :str.empresa,   
           :is_tran,   
           :is_stran,   
           :ls_documento,   
           :ls_referencia,   
           :li_ann,   
           :ls_app_fac,   
           :ls_tran_fac,   
           :ls_stran_fac,   
           :ls_factura,   
           :ls_referencia_fac,   
           :li_ann_fac,   
           :ld_monto_aplica,   
           :ll_cliente,   
           :i,   
           :ldt_fecha_recibo,   
           :ldt_fecha_factura,   
           :str.usuario )  ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al guardar facturas '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				return false
			end if
	
next

if dw_5.update() = -1 then
	gf_mensaje('','Error al guardar saldos '+sqlca.sqlerrtext,1,1,'E')
	rollback;
	return false
end if

return true
end function

public subroutine wf_setear_user (string as_user);//Asigno el Usuario a la Variable de Instancia
is_user = as_user
end subroutine

on w_transacciones.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.dw_2=create dw_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.pb_1=create pb_1
this.st_1=create st_1
this.uo_1=create uo_1
this.dw_3=create dw_3
this.dw_4=create dw_4
this.dw_5=create dw_5
this.dw_6=create dw_6
this.uo_2=create uo_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.uo_1
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.dw_4
this.Control[iCurrent+10]=this.dw_5
this.Control[iCurrent+11]=this.dw_6
this.Control[iCurrent+12]=this.uo_2
end on

on w_transacciones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.uo_1)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.dw_6)
destroy(this.uo_2)
end on

event ue_post_open;//override
str_secuencia_doc lstr_sec
string ls_documento, ls_masca
integer li_ann
datawindowchild ldwc_cobrador
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_5.settransobject(sqlca)
dw_6.settransobject(sqlca)

  SELECT isnull(dgmempre.empr_imprimir_al_grabar  ,0)
    INTO :ii_imprimir_al_grabar  
    FROM dgmempre  
   WHERE ( dgmempre.empr_g_financiero = :str.g_financiero ) AND  
         ( dgmempre.empr_empresa = :str.empresa )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error en Empresa '+sqlca.sqlerrtext,1,1,'E')
	end if

dw_1.getchild('movi_ruc_tercero', idwc_clientes)
idwc_clientes.settransobject(sqlca)
if idwc_clientes.retrieve(str.g_financiero, str.empresa) = 0 then
	idwc_clientes.insertrow(1)
end if

dw_1.getchild('movi_cobrador', ldwc_cobrador)
ldwc_cobrador.settransobject(sqlca)
ldwc_cobrador.retrieve(str.g_financiero, str.empresa)
ldwc_cobrador.insertrow(1)

dw_1.getchild('movi_tipo_transaccion', idwc_tran)
idwc_tran.settransobject(sqlca)
idwc_tran.retrieve(str.g_financiero, str.empresa)

dw_1.getchild('movi_sub_transaccion', idwc_stran)
idwc_stran.settransobject(sqlca)
idwc_stran.retrieve(str.g_financiero, str.empresa)

dw_3.getchild('ddia_mg_cuenta', idwc_plan)
idwc_plan.settransobject(sqlca)
idwc_plan.retrieve(str.g_financiero, str.empresa)
idwc_plan.insertrow(1)

ls_masca = gf_mascara()
dw_3.MODIFY("cuenta.editmask.mask='"+ls_masca+"'") //mascara para el compute de la cuenta
idwc_plan.MODIFY("mg_cuenta.editmask.mask='"+ls_masca+"'") //cuenta que se graba en el detalle contable

lstr_sec = Message.PowerObjectParm
if isvalid(lstr_sec) then 
	ls_documento = lstr_sec.sec_manual
	li_ann	 = lstr_sec.ano
	is_tran	 = lstr_sec.tran
	is_stran	 = lstr_sec.subtran
end if

dw_1.insertrow(1)

if ls_documento <> '' and not isnull(ls_documento) then
	dw_1.setitem(1,'movi_tipo_transaccion',is_tran)
	is_tran_automatica = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_sec_auto')
	if is_tran_automatica = 'S' then
		dw_1.Modify("movi_documento.Edit.DisplayOnly=Yes")
	else
		dw_1.Modify("movi_documento.Edit.DisplayOnly=No")
	end if
	dw_1.setitem(1,'movi_sub_transaccion',is_stran)
	dw_1.setitem(1,'movi_anno',li_ann)	
	ii_ann = li_ann
	dw_1.setitem(1,'movi_documento',ls_documento)
	dw_1.setcolumn('movi_documento')
	dw_1.accepttext()
	dw_1.trigger event itemchanged(1, dw_1.object, ls_documento)	
else
	ii_ann = year(date(gf_fecha_serv()))
	dw_1.setitem(1,'movi_fecha_tran', date(gf_fecha_serv()))
	dw_1.setitem(1,'movi_anno',year(date(gf_fecha_serv())))	
	dw_1.setitem(1,'movi_g_financiero',str.g_financiero)
	dw_1.setitem(1,'movi_empresa',str.empresa)
	dw_1.setitem(1,'movi_aplicacion','CC')
	dw_1.setitem(1,'movi_anno', ii_ann)
	dw_1.setitem(1,'movi_usuario', str.usuario)
end if

is_historica = 'N'

if str.contabiliza = 0 then
	is_historica = 'S'
	dw_1.setitem(1,'movi_historica','S')
	dw_1.modify('movi_historica.visible = false')
	dw_3.visible = false
end if

dw_1.Modify("calendario.Filename='"+str.path+"Art\ddfec.bmp'")

dw_1.setitemstatus(1,0,primary!,NotModified!) 
end event

event ue_aceptar;//override
long ll_update, ll_doc
integer li_ann, i
window lw_ventana
string ls_titulo, ls_doc
decimal{2} ldec_saldo, ld_monto
datetime ldt_fecha_tran, ldt_fecha_cierre
//lw_ventana = this.getactivesheet()
//ls_titulo = lw_ventana.title

dw_1.accepttext()
li_ann = dw_1.getitemNumber(dw_1.getrow(), 'movi_anno')
if li_ann = 0 or isnull(li_ann) then
	gf_mensaje('','Verifique el Año de la transacción !!!!',1,1,'E')
	dw_1.setcolumn('movi_anno')
	return
end if

ls_doc = dw_1.getitemstring(dw_1.getrow(), 'movi_documento')
if ls_doc = '' or isnull(ls_doc) then
	gf_mensaje('','Debe digitar el documento antes de guardar, Verifique !!!',1,1,'E')
	dw_1.setcolumn('movi_documento')
	return
end if

if dw_1.getitemstring(dw_1.getrow(), 'movi_referencia') = '' or isnull(dw_1.getitemstring(dw_1.getrow(),'movi_referencia')) then
	gf_mensaje('','Debe digitar la referencia antes de guardar, Verifique !!!',1,1,'E')
	dw_1.setcolumn('movi_referencia')
	return
end if

if dw_1.getitemNumber(dw_1.getrow(), 'movi_tercero') = 0 or isnull(dw_1.getitemNumber(dw_1.getrow(),'movi_tercero')) then
	gf_mensaje('','Debe asignar un cliente antes de guardar, Verifique !!!',1,1,'E')
	dw_1.setcolumn('movi_tercero')
	return
end if

if is_tran = 'RC' or is_tran + is_stran = 'ND0' then
	ld_monto = dw_1.getitemnumber(1,'total_final')
	dw_1.setitem(1,'movi_monto',ld_monto)
	dw_1.accepttext()
end if

if dw_1.getitemstring(1,'movi_naturaleza') = 'D' then
	ld_monto = dw_1.getitemnumber(1,'movi_monto')
	dw_1.setitem(1,'movi_saldo',ld_monto)
end if

//if is_tran = 'RC' or is_tran+is_stran = 'ND0' then
//	if dw_1.getitemNumber(dw_1.getrow(), 'total_final') = 0 or isnull(dw_1.getitemNumber(dw_1.getrow(),'total_final')) then
//		gf_mensaje('','Debe asignar el valor de la transaccion antes de guardar, Verifique !!!',1,1,'E')
//		dw_1.setcolumn('movi_efectivo')
//		return
//	end if
//else
//	if dw_1.getitemNumber(dw_1.getrow(), 'movi_monto') = 0 or isnull(dw_1.getitemNumber(dw_1.getrow(),'movi_monto')) then
//		gf_mensaje('','Debe asignar el valor de la transaccion antes de guardar, Verifique !!!',1,1,'E')
//		dw_1.setcolumn('movi_monto')
//		return
//	end if
//end if

//valida q este en balance
if dw_3.rowcount() > 0 and is_historica = 'N'  then
	if dw_3.getitemnumber(1,'balance') <> 0 then
		gf_mensaje('','Debe Balancear la Transaccion para Guardar, Verifique !!!',1,1,'E')
		return
	end if
	if dw_3.getitemnumber(1,'monto_debito') + dw_3.getitemnumber(1,'monto_credito') = 0 then
		gf_mensaje('','Existen Valores en 0 en el Detalle Contable, Verifique !!!',1,1,'E')
		return
	end if
end if


//Valida que no pueda registrar transacciones de fechas inferiores al ultimo cierre de caja
ldt_fecha_tran = dw_1.getitemdatetime(1,'movi_fecha_tran')

if not gf_valida_fecha_conta(ldt_fecha_tran) then
	return
end if

  SELECT max(caja_fecha_cierre)  
    INTO :ldt_fecha_cierre  
    FROM cajamenuda  
   WHERE ( cajamenuda.caja_g_financiero = :str.g_financiero ) AND  
         ( cajamenuda.caja_empresa = :str.empresa ) AND  
         ( cajamenuda.caja_cerrada = 1 ) ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al seleccionar cierre '+sqlca.sqlerrtext,1,1,'E')
				return
			end if

if ldt_fecha_tran <= ldt_fecha_cierre and (is_tran = 'RC' or is_tran + is_stran = 'ND0') then
	gf_mensaje('','Ya realizo el cierre de caja, verifique la fecha de la transaccion',1,1,'E')	
	dw_1.setcolumn('movi_fecha_tran')
	return
end if

ll_update=dw_1.update()

if ll_update = 1  then
		
	//guarda el asiento contable
	if is_historica = 'N' and not wf_registra_asiento() then
		rollback ;
		sqlca.autocommit = true
		return
	else
		//Guarda las facturas pagadas, si es un Recibo
		if dw_5.visible then
			if not wf_guarda_facturas_pagadas() then
				rollback ;
				sqlca.autocommit = true
				return
			end if
		end if
		if is_historica = 'N' then		
			for i = 1 to dw_3.rowcount()
				dw_3.setitem(i,'ddia_linea',i)
				if dw_3.getitemstring(i,'naturaleza') = 'D' then
					dw_3.setitem(i,'ddia_monto',dw_3.getitemnumber(i,'monto_debito'))
				else
					dw_3.setitem(i,'ddia_monto',dw_3.getitemnumber(i,'monto_credito'))
				end if
				dw_3.setitem(i,'ddia_no_documento',dw_1.getitemstring(1,'movi_documento'))
				dw_3.setitem(i,'ddia_no_referencia',dw_1.getitemstring(1,'movi_referencia'))
				dw_3.setitem(i,'ddia_ann',ii_ann)								
				dw_3.setitem(i,'ddia_banco_cuenta','1')
			next
			
			if dw_3.update() = -1 then
				gf_mensaje('','Error al guardar detalle contable '+sqlca.sqlerrtext,1,1,'E')
				rollback ;
				sqlca.autocommit = true
				return
			end if
		end if //del is_historica
	end if
	
	commit using sqlca;
	
	ldec_saldo = gf_saldo_anterior_new( dw_1.getitemnumber(1,'movi_tercero'), gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)
	dw_1.setitem(1,'saldo',ldec_saldo)				
		//Si la secuencia es automatica, graba en la tabla de transacciones
		is_tran_automatica = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_sec_auto')
		if is_tran_automatica = 'S' then
			
			ll_doc = long(dw_1.getitemstring(1,'movi_documento'))
			
			if dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = New! or 	dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = NewModified! then 	
				
				if str.nd_por_subtransaccion = 0 then
				
					update dgmserie
					set mser_secuencia = :ll_doc
					where mser_g_financiero = :str.g_financiero and
							mser_empresa		= :str.empresa	and
							mser_tipo_transaccion = :is_tran ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al guardar secuencia '+sqlca.sqlerrtext,1,1,'E')
							end if
						
				else
					update dgmsubse
					set subs_secuencia = :ll_doc
					where subs_g_financiero = :str.g_financiero and
							subs_empresa		= :str.empresa	and
							subs_transaccion = :is_tran and
							subs_sub_trans = :is_stran; 
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al guardar secuencia '+sqlca.sqlerrtext,1,1,'E')
							end if				
				end if
			end if					
		end if			
		if dw_1.getitemstring(1,'movi_impreso') = 'N' or isnull(dw_1.getitemstring(1,'movi_impreso')) then
			if ii_imprimir_al_grabar = 1 then
				this.triggerevent('ue_print')
			end if
		end if
		this.triggerevent('ue_adicionar')
		
		//asigna cuentas
		if is_historica = 'N' then
			wf_asigna_cuenta(is_tran)			
		end if //del historico
		
		commit ;
//	gf_mensaje("Atención","¡Actualización Exitosa !",1,1,'E')
else
	rollback using sqlca;
	gf_mensaje("Atención","¡Error al Actualizar ! " + sqlca.sqlerrtext,1,1,'E')
end if

end event

event ue_adicionar;//override
string ls_tran, ls_subt, ls_naturaleza, ls_doc, ls_cliente, ls_nombre, ls_comments
integer li_ann, li_cobrador
datetime ldt_fecha, ldt_fecha_actual, ldt_fecha_consultada
decimal{2} ld_monto, ldec_saldo
long ll_tercero
if dw_1.rowcount() > 0 then
	
	if ii_repite_transaccion = 1 then
		ldt_fecha     = dw_1.getitemdatetime(1,'movi_fecha_tran')
		li_ann 		= dw_1.getitemnumber(1,'movi_anno')
		ll_tercero    = dw_1.getitemnumber(1,'movi_tercero')
		ls_cliente    = dw_1.getitemstring(1,'movi_ruc_tercero')
		ls_nombre  = dw_1.getitemstring(1,'movi_a_nombre')
		ld_monto    = dw_1.getitemnumber(1,'movi_monto')
		ls_comments = dw_1.getitemstring(1,'movi_comments')
		li_cobrador  = dw_1.getitemnumber(1,'movi_cobrador')
	end if

	ldt_fecha_consultada = dw_1.getitemdatetime(1,'movi_fecha_tran')	

end if

ldt_fecha_actual = datetime(date(gf_fecha_serv()),00:00:00)
	
if year(date(ldt_fecha_consultada)) <> year(date(ldt_fecha_actual)) then
	if abs(year(date(ldt_fecha_consultada)) - year(date(ldt_fecha_actual))) = 1	 then //Si esta adicionando en el año anterior
		if gf_mensaje('','Desea Adicionar Transacción en el año '+string(year(date(ldt_fecha_consultada)))+' ?',2,1,'Q') = 1 then
			if gf_valida_fecha_conta(ldt_fecha_consultada) then			
				ldt_fecha_actual = ldt_fecha_consultada
			end if				
		end if
	end if
end if

dw_1.reset()		
dw_1.insertrow(1)
dw_1.setitem(1,'movi_fecha_tran', ldt_fecha_actual)
dw_1.setitem(1,'movi_g_financiero',str.g_financiero)
dw_1.setitem(1,'movi_empresa',str.empresa)
dw_1.setitem(1,'movi_aplicacion','CC')
dw_1.setitem(1,'movi_anno', year(date(ldt_fecha_actual)))
ii_ann = year(date(ldt_fecha_actual))
dw_1.setitem(1,'movi_usuario', str.usuario)
dw_1.setitem(1,'movi_tipo_transaccion', is_tran)
dw_1.setitem(1,'movi_sub_transaccion', is_stran)
ls_naturaleza = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_movimiento')
dw_1.setitem(1,'movi_naturaleza',ls_naturaleza)			
if ls_naturaleza = 'D' then dw_1.setitem(1,'movi_fecha_vence', relativedate(date(ldt_fecha_actual),30))	

//facturas aplicadas
if is_tran = 'RC' then
	dw_5.dataobject = 'dw_documentos_por_aplicar'
	dw_5.settransobject(sqlca)
	dw_1.setitem(1,'movi_comments','INGRESO A CAJA')
	dw_1.setitem(1,'movi_comentario','INGRESO A CAJA')
end if
dw_5.reset()

if ii_repite_transaccion = 1 then
	ldt_fecha_actual = ldt_fecha
	ii_ann = li_ann
	dw_1.setitem(1,'movi_fecha_tran', ldt_fecha)
	dw_1.setitem(1,'movi_anno',li_ann)
	dw_1.setitem(1,'movi_tercero',ll_tercero)
	dw_1.setitem(1,'movi_ruc_tercero',ls_cliente)
	dw_1.setitem(1,'movi_a_nombre',ls_nombre)
	dw_1.setitem(1,'movi_monto',ld_monto)
	dw_1.setitem(1,'movi_comments',ls_comments )	
	dw_1.setitem(1,'movi_cobrador',li_cobrador)
	
	ldec_saldo = gf_saldo_anterior_new( ll_tercero, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)
	dw_1.setitem(1,'saldo',ldec_saldo)
	if dw_5.visible then
		dw_5.retrieve(str.g_financiero, str.empresa, ll_tercero)
	end if	
	
end if


il_tercero_anterior = 0
is_doc_anterior = ''
is_ref_anterior = ''
ii_ann_anterior = 0
ii_contador = 0

//adiciona en dw contable
if is_historica = 'S' then 
	dw_1.setitem(1,'movi_historica',is_historica)
else	
	dw_3.reset()
	dw_3.insertrow(1)
	dw_3.setitem(1,'ddia_fecha', date(ldt_fecha_actual))
	dw_3.setitem(1,'ddia_g_financiero',str.g_financiero)
	dw_3.setitem(1,'ddia_empresa',str.empresa)
	dw_3.setitem(1,'ddia_aplicacion_mg','CC')
	dw_3.setitem(1,'ddia_ann', ii_ann)
	dw_3.setitem(1,'ddia_id', str.usuario)
	dw_3.setitem(1,'ddia_tipo_transaccion', is_tran)
	dw_3.setitem(1,'ddia_sub_trans', is_stran)
	dw_3.setitem(1,'naturaleza',ls_naturaleza)	
	dw_3.setitem(1,'ddia_linea',1)
	dw_3.setitem(1,'tipo','C')

	//asigna cuentas
	if is_tran <> '' and is_stran <> '' then
		wf_asigna_cuenta(is_tran)			
	end if
end if

is_tran_automatica = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_sec_auto')
if is_tran_automatica = 'S' then
	dw_1.Modify("movi_documento.Edit.DisplayOnly=Yes")			
	ls_doc = wf_secuencia_tran()			
	dw_1.setitem(1,'movi_documento', ls_doc)
	dw_1.setitem(1,'movi_referencia', ls_doc)	
else
	dw_1.Modify("movi_documento.Edit.DisplayOnly=No")
	dw_1.setitem(1,'movi_documento','')
end if		

is_tran_automatica = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_sec_auto')
if is_tran_automatica = 'S' then
	dw_1.setcolumn('movi_ruc_tercero')
else
	dw_1.setcolumn('movi_documento')
end if
if ii_repite_transaccion = 1 and is_tran = 'RC' then
	dw_1.setcolumn('movi_efectivo')
end if
dw_1.setfocus()
dw_1.Modify("movi_comments.Edit.DisplayOnly=No")
end event

event resize;//override
dw_1.Resize(This.Width - 270, This.Height - 430)
pb_1.y = newheight - 170
st_1.y = newheight - 150
cb_3.y = newheight - 150
dw_3.width = This.Width - 270

end event

event ue_print;//override
string  ls_dinero, ls_tran, ls_doc, ls_masca, ls_referencia
Integer li_ann, li_filas

ls_tran = dw_1.getitemstring(1,'movi_tipo_transaccion')
if ls_tran = 'RC' then
	if is_historica = 'S' then
		dw_2.dataobject = 'dw_imprimir_recibo_historico'
	else
		dw_2.dataobject = 'dw_imprimir_recibo'
	end if
else
	if is_historica = 'S' then
		dw_2.dataobject = 'dw_imprimir_transacciones_historica'
		if pos(str.empr_acceso_especial,'GOLD2') > 0 then
			dw_2.dataobject = 'dw_imprimir_transacciones_gold'
		end if
	else
		dw_2.dataobject = 'dw_imprimir_transacciones'
		if pos(str.empr_acceso_especial,'UNION') > 0 then
			dw_2.dataobject = 'dw_imprimir_transacciones_union'
		end if		
	end if
end if
dw_2.settransobject(sqlca)

ls_doc  = dw_1.getitemstring(1,'movi_documento')
ls_referencia  = dw_1.getitemstring(1,'movi_referencia')
li_ann  = dw_1.getitemnumber(1,'movi_anno')

if ls_tran = 'RC' then
	li_filas = dw_2.retrieve(str.g_financiero, str.empresa, ls_tran, ls_doc, li_ann, 'CC')
else
	li_filas = dw_2.retrieve(str.g_financiero, str.empresa, ls_tran, ls_doc, li_ann, 'CC', is_stran)
end if

if li_filas > 0 then
	ls_dinero =  upper(gf_numerlet(dw_1.getitemnumber(1,'movi_monto'),1))
	if dw_2.describe("numero_letra.x") <> "!" and dw_2.describe("numero_letra.x") <> "?"then				
		dw_2.object.numero_letra.expression = "'"+ls_dinero+"'"
	end if
	ls_masca = gf_mascara()
   dw_2.MODIFY("ddia_mg_cuenta.editmask.mask='"+ls_masca+"'") //mascara para el compute de la cuenta
	dw_2.Modify("DataWindow.Print.Preview=true")	
else
	gf_mensaje('','Transaccion no Registrada, Verifique!!!',1,1,'E')
	return
end if

PrintSetPrinter (str.printer1)

if str.contabiliza = 1 then
	dw_2.visible = true
	OpenWithParm(w_dw_print_options, dw_2)
	dw_2.visible = false
	If Message.DoubleParm = -1 Then Return
end if

dw_2.Print(True)

update cctmovim set movi_impreso = 'S', cctmovim.movi_cierre_mensual = 'S'
where movi_g_financiero = :str.g_financiero and
		movi_empresa		= :str.empresa	and
		movi_aplicacion	= 'CC' and
		movi_tipo_transaccion = :is_tran and
		movi_sub_transaccion	 = :is_stran and
		movi_documento			 = :ls_doc and
		movi_referencia       = :ls_referencia and
		movi_anno				 = :li_ann ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al actualizar el estado de impreso '+sqlca.sqlerrtext,1,1,'E')
			rollback;
		end if

dw_1.setitem(1,'movi_impreso','S')
dw_1.setitem(1,'movi_cierre_mensual','S')

end event

event ue_eliminar;//override
datetime ldt_fecha_tran, ldt_fecha_cierre
this.setredraw(false)
if dw_1.rowcount() > 0 then
	
	//valida fecha contable
	ldt_fecha_tran = dw_1.getitemdatetime(1,'movi_fecha_tran')
	if not gf_valida_fecha_conta(ldt_fecha_tran) then
		this.setredraw(true)
		return
	end if

	
	if gf_mensaje('','Esta seguro de eliminar la transaccion ??',2,1,'E') = 2 then 
		this.setredraw(true)
		return		
	end if
	

  SELECT max(caja_fecha_cierre)  
    INTO :ldt_fecha_cierre  
    FROM cajamenuda  
   WHERE ( cajamenuda.caja_g_financiero = :str.g_financiero ) AND  
         ( cajamenuda.caja_empresa = :str.empresa ) AND  
         ( cajamenuda.caja_cerrada = 1 ) ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al seleccionar cierre '+sqlca.sqlerrtext,1,1,'E')
				return
			end if

if ldt_fecha_tran <= ldt_fecha_cierre and (is_tran = 'RC' or is_tran + is_stran = 'ND0') then
	gf_mensaje('','Ya realizo el cierre de caja, verifique la fecha de la transaccion',1,1,'E')	
	dw_1.setcolumn('movi_fecha_tran')
	return
end if

   //Elimina registro	
	dw_1.deleterow(dw_1.getrow())
	if dw_1.update() = 1 then
		
		if is_tran = 'RC' then
			if not wf_restaura_saldos() then
				rollback;
				return				
			end if
		end if
		
		  DELETE FROM coddiari  
   WHERE ( coddiari.ddia_g_financiero = :str.g_financiero ) AND  
         ( coddiari.ddia_empresa = :str.empresa ) AND  
         ( coddiari.ddia_aplicacion_mg = 'CC' ) AND  
         ( coddiari.ddia_tipo_transaccion = :is_tran ) AND  
         ( coddiari.ddia_sub_trans = :is_stran ) AND  
         ( coddiari.ddia_no_documento = :is_doc_anterior ) AND  
         ( coddiari.ddia_no_referencia = :is_ref_anterior ) AND  
         ( coddiari.ddia_ann = :ii_ann_anterior ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Eliminar Encabezado del Asiento '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return
		end if

  DELETE FROM cotdiari  
   WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
         ( cotdiari.diar_empresa = :str.empresa ) AND  
         ( cotdiari.diar_aplicacion_mg = 'CC' ) AND  
         ( cotdiari.diar_tipo_transaccion = :is_tran ) AND  
         ( cotdiari.diar_sub_trans = :is_stran ) AND  
         ( cotdiari.diar_no_documento = :is_doc_anterior ) AND  
         ( cotdiari.diar_no_referencia = :is_ref_anterior ) AND  
         ( cotdiari.diar_ann = :ii_ann_anterior ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Eliminar Encabezado del Asiento '+sqlca.sqlerrtext,1,1,'E')
			rollback;
		end if
		this.triggerevent('ue_adicionar')
		
		//asigna cuentas
		if is_historica = 'N' then
			wf_asigna_cuenta(is_tran)			
		end if //del historico
		
	end if
else 
	messagebox("Atención","No hay registros para borrar!")
end if
this.setredraw(true)
end event

event open;call super::open;
dw = dw_2
end event

event close;call super::close;Window lw_frame

lw_frame = ParentWindow()

If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_sheet_closed")
 End If
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_transacciones
boolean visible = false
integer width = 73
integer height = 36
string text = ""
end type

type dw_1 from w_fa_padre`dw_1 within w_transacciones
event ue_enter pbm_dwnprocessenter
integer x = 82
integer y = 60
integer width = 4270
integer height = 1564
string dataobject = "dw_transacciones"
end type

event dw_1::ue_enter;//string ls_columna
//
//ls_columna = this.getcolumnname()
//
//this.accepttext()
//	if this.getcolumnname() = 'movi_comments' then	
//		parent.triggerevent('ue_aceptar')
//	elseif this.getcolumnname() = 'movi_tipo_transaccion' then	
//		this.setcolumn('movi_sub_transaccion')	
//	elseif this.getcolumnname() = 'movi_sub_transaccion' then	
//		this.setcolumn('movi_documento')			
//	elseif this.getcolumnname() = 'movi_documento' then	
//		this.setcolumn('movi_fecha_tran')		
//	elseif this.getcolumnname() = 'movi_fecha_tran' then	
//		this.setcolumn('movi_referencia')		
//	elseif this.getcolumnname() = 'movi_referencia' then	
//		this.setcolumn('movi_ruc_tercero')		
//	elseif this.getcolumnname() = 'movi_ruc_tercero' then	
//		this.setcolumn('movi_a_nombre')		
//	elseif this.getcolumnname() = 'movi_a_nombre' then	
//		this.setcolumn('movi_monto')		
//	elseif this.getcolumnname() = 'movi_monto' then	
//		this.setcolumn('movi_comments')				
//	end if
//
//return 2

////override
//
string		ls_colum
long			ll_cont, ll_num_max_col, ll_tab_order, ll_tab_order_next
boolean		lb_exist_nextcol
window		lw_window

lw_window = str.frame.getactivesheet()

lb_exist_nextcol = true

if IsValid(this) then
	if this.AcceptText() < 0 then
		return 1
	end if
	lb_exist_nextcol = false
	ls_colum = GetColumnName()
	
	if ls_colum = 'movi_comments' then
		ii_contador ++
		if ii_contador > 2 then 
	//		parent.triggerevent('ue_aceptar')
			ii_contador = 0
		end if
		return
	end if
	
	ll_num_max_col = long(this.object.datawindow.column.count)
	ll_tab_order = long(this.Describe(ls_colum + ".TabSequence"))
	for ll_cont = 1 to ll_num_max_col
		ls_colum = this.Describe("#" + string(ll_cont) + ".Name")
		ll_tab_order_next = long(this.Describe(ls_colum + ".TabSequence"))
		if ll_tab_order_next = ll_tab_order + 10 then
			lb_exist_nextcol = true
			ll_cont = ll_num_max_col
		end if
	next
end if

if not lb_exist_nextcol then
	if not ib_no_insertar then
		if this.getrow() = this.rowcount() then
//			if messagebox('Información','¿Desea Insertar otro Registro?',Information!,Yesno!,1) = 1 then
//				if ib_adicionar then
//					lw_window.triggerevent('ue_adicionar')
//				else
//					this.InsertRow(0)
//				end if
//			else
//				return 1
//			end if
		else
			Send(Handle(this),256,9,long(0,0))
		end if
	else
		Send(Handle(this),256,9,long(0,0))
	end if
else
	Send(Handle(this),256,9,long(0,0))
end if

return 1

end event

event dw_1::itemchanged;call super::itemchanged;this.accepttext()
string ls_tran, ls_doc, ls_subt, ls_naturaleza, ls_cuenta, ls_ruc, ls_referencia, ls_find, ls_aplicacion, ls_stran, ls_documento
integer li_ann, li_existe, i, li_registro, li_filas, li_ann_anterior
long    ll_tercero
decimal{2} ldec_saldo, ld_tarjeta, ld_porcentaje, ld_monto, ld_monto_aplicado
decimal{2} ld_saldo
boolean lb_no_asignar
datetime ldt_fecha_tran, ldt_fecha_anterior

choose case this.getcolumnname()
	case 'movi_fecha_tran'
		ldt_fecha_tran 	 = this.getitemdatetime(this.getrow(),'movi_fecha_tran')		
		ldt_fecha_anterior = this.getitemdatetime(this.getrow(),'movi_fecha_tran', Primary!, True)		
		ii_ann = year(date(this.getitemdatetime(this.getrow(),'movi_fecha_tran')))
		li_ann_anterior = dw_1.getitemnumber(1,'movi_anno')
		
		if not gf_valida_fecha_conta(ldt_fecha_anterior) then			
			dw_1.setitem(1,'movi_fecha_tran', ldt_fecha_anterior)
			dw_1.setcolumn('movi_fecha_tran')
			return 2
		end if

		if not gf_valida_fecha_conta(ldt_fecha_tran) then			
			dw_1.setitem(1,'movi_fecha_tran', ldt_fecha_anterior)
			dw_1.setcolumn('movi_fecha_tran')
			return 2
		end if

		if not gf_valida_fecha_futura(ldt_fecha_tran) then			
			if ldt_fecha_tran = ldt_fecha_anterior then
				dw_1.setitem(1,'movi_fecha_tran', date(gf_fecha_serv()))				
			else
				dw_1.setitem(1,'movi_fecha_tran', ldt_fecha_anterior)
			end if
			dw_1.setcolumn('movi_fecha_tran')
			return 2
		end if
		
		//Si los anios son diferentes asigna el anio
		if ii_ann <> li_ann_anterior then
			dw_1.setitem(1,'movi_anno',ii_ann)
		end if
		
	case 'movi_anno'
		ii_ann = this.getitemnumber(1,'movi_anno')
		if year(date(this.getitemdatetime(1,'movi_fecha_tran'))) <> ii_ann then
			gf_mensaje('','Verifique el año es diferente al de la fecha',1,1,'E')
			this.setcolumn('movi_anno')
			return
		end if
	case 'movi_tipo_transaccion'		
		ls_tran = data
		if ls_tran = 'RC' then
			dw_5.visible = true
		else
			dw_5.visible = false
		end if
		dw_5.reset()
		is_tran = ls_tran
		idwc_stran.setfilter("dgmsubse_subs_transaccion = '"+ls_tran+"'")
		idwc_stran.filter()		
		this.setitem(1,'movi_tipo_transaccion',ls_tran)
		if idwc_stran.rowcount() > 0 then
			if str.contabiliza = 0 and is_tran = 'ND' then
				if str.usuario = 'FPC' or str.usuario = 'JF' then 
					is_stran = idwc_stran.getitemstring(1,'dgmsubse_subs_sub_trans')
				else
					if idwc_stran.rowcount() > 1 then
						is_stran = idwc_stran.getitemstring(1,'dgmsubse_subs_sub_trans')
					else
						is_stran = idwc_stran.getitemstring(2,'dgmsubse_subs_sub_trans')
					end if
				end if
			else
					is_stran = idwc_stran.getitemstring(1,'dgmsubse_subs_sub_trans')
			end if
			dw_1.setitem(1,'movi_sub_transaccion',is_stran)
			dw_3.setitem(1,'ddia_sub_trans',is_stran)
		end if	

		parent.triggerevent('ue_adicionar')
		
		ii_repite_transaccion = idwc_tran.getitemNumber(idwc_tran.getrow(),'mser_repite_transaccion')		
		ls_naturaleza = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_movimiento')		
		is_tran_automatica = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_sec_auto')
		if is_tran_automatica = 'S' then
			dw_1.Modify("movi_documento.Edit.DisplayOnly=Yes")			
			ls_doc = wf_secuencia_tran()			
			dw_1.setitem(1,'movi_documento', ls_doc)
		else
			dw_1.Modify("movi_documento.Edit.DisplayOnly=No")
			dw_1.setitem(1,'movi_documento','')
		end if		
		this.setitem(1,'movi_naturaleza',ls_naturaleza)
		if ls_naturaleza = 'D' then dw_1.setitem(1,'movi_fecha_vence', relativedate(date(gf_fecha_serv()),30))			
		if ls_tran = 'RC' then
			this.setitem(1,'movi_comments','INGRESO A CAJA')
			this.setitem(1,'movi_comentario','INGRESO A CAJA')
			//parent.height = 1970
		else
			this.setitem(1,'movi_comments','')			
			//parent.height = 1608			
		end if
		
		//asigna cuentas
		if is_historica = 'N' then
			wf_asigna_cuenta(ls_tran)			
		end if //del historico
		
		this.setcolumn('movi_documento')		
	case 'movi_sub_transaccion'
		is_stran = data
		this.setitem(1,'movi_efectivo',0)
		this.setitem(1,'movi_cheque',0)		
		this.setitem(1,'movi_tarjeta',0)		
		this.setitem(1,'movi_transferencia',0)		
		this.setcolumn('movi_documento')
		ls_naturaleza = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_movimiento')				
		
		if str.nd_por_subtransaccion = 1 then parent.triggerevent('ue_adicionar')
		
		//asigna cuentas
		if is_historica = 'N' then
			
		  SELECT isnull(dgmserdr.serd_mgcuenta  ,'')
			 INTO :ls_cuenta  
			 FROM dgmserdr  
			WHERE ( dgmserdr.serd_g_financiero = :str.g_financiero ) AND  
					( dgmserdr.serd_empresa = :str.empresa ) AND  
					( dgmserdr.serd_transaccion = :is_tran ) AND  
					( dgmserdr.serd_sub_trans = :is_stran ) AND  
					( dgmserdr.serd_aplicacion = 'CC' ) ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al buscar cuenta '+sqlca.sqlerrtext,1,1,'E')
					return 2
				end if
		
			if ls_cuenta = '' then
				gf_mensaje('','Debe asignar la cuenta a la transaccion. Verifique !!!',1,1,'E')
				return 2
			end if
			if ls_naturaleza = 'D' then
				dw_3.setitem(1,'naturaleza','C')
			else
				dw_3.setitem(1,'naturaleza','D')			
			end if					
			dw_3.setitem(1,'ddia_mg_cuenta',ls_cuenta)
			dw_3.setitem(1,'cuenta',ls_cuenta)
			dw_3.setitem(1,'ddia_sub_trans',is_stran)
		end if
	case 'movi_historica'
		is_historica = data
		if is_historica = 'S' then
			dw_3.visible = false
		else
			dw_3.visible = true
		end if		
	case 'movi_ruc_tercero'	
		
		ls_ruc = data
		  SELECT count(*) , max(clie_mg_cuenta)  
			 INTO :li_existe, :ls_cuenta  
			 FROM ccmclien  
			WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
					( ccmclien.clie_empresa = :str.empresa ) AND  
					( ccmclien.clie_ref_anterior = :ls_ruc ) AND
					( ccmclien.clie_estado = 'A') ; // and (clie_cuenta_mala = 0 ) ;
			if li_existe = 0 or isnull(li_existe) then
				gf_mensaje('','Cliente no existe. Verifique !!!',1,1,'E')
				this.setitem(1,'movi_ruc_tercero','')
				this.setcolumn('movi_ruc_tercero')
				return 2
			end if		
		
		this.setitem(1,'movi_a_nombre',idwc_clientes.getitemstring(idwc_clientes.getrow(),'terc_descripcion'))
		ll_tercero = idwc_clientes.getitemNumber(idwc_clientes.getrow(), 'terc_tercero')
		this.setitem(1,'movi_tercero', ll_tercero )						
//		this.setitem(1,'movi_ruc_tercero',idwc_clientes.getitemstring(idwc_clientes.getrow(),'clie_ref_anterior'))		
		ldec_saldo = gf_saldo_anterior_new( ll_tercero, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)
		this.setitem(1,'saldo',ldec_saldo)
		if dw_5.visible then
			dw_5.retrieve(str.g_financiero, str.empresa, ll_tercero)
		end if	
		if dw_3.rowcount() = 1 then
			dw_3.scrolltorow(dw_3.insertrow(0))
			dw_3.setitem(dw_3.getrow(),'ddia_fecha', date(gf_fecha_serv()))
			dw_3.setitem(dw_3.getrow(),'ddia_g_financiero',str.g_financiero)
			dw_3.setitem(dw_3.getrow(),'ddia_empresa',str.empresa)
			dw_3.setitem(dw_3.getrow(),'ddia_aplicacion_mg','CC')
			dw_3.setitem(dw_3.getrow(),'ddia_id', str.usuario)
			dw_3.setitem(dw_3.getrow(),'ddia_tipo_transaccion', is_tran)
			dw_3.setitem(dw_3.getrow(),'ddia_sub_trans', is_stran)
			if this.getitemstring(1,'movi_naturaleza') = 'D' then
				dw_3.setitem(dw_3.getrow(),'naturaleza','D')	
			else
				dw_3.setitem(dw_3.getrow(),'naturaleza','C')	
			end if
			dw_3.setitem(dw_3.getrow(),'ddia_linea',dw_3.getrow())
			dw_3.setitem(dw_3.getrow(),'ddia_ann',ii_ann)
			dw_3.setitem(dw_3.getrow(),'ddia_no_documento',dw_1.getitemstring(1,'movi_documento'))
			dw_3.setitem(dw_3.getrow(),'ddia_no_referencia',dw_1.getitemstring(1,'movi_referencia'))
		end if				
		//asigna el codigo de cuenta, tercero y codigo
		dw_3.setitem(2,'ddia_mg_cuenta',ls_cuenta)
		dw_3.setitem(2,'cuenta',ls_cuenta)
		dw_3.setitem(2,'ddia_tercero',ll_tercero)
		dw_3.setitem(2,'ddia_codigo_cte_prov',ls_ruc)
			
	case 'movi_documento'
		
		ls_doc = this.getitemstring(1,'movi_documento')
		li_ann =  this.getitemNumber(1,'movi_anno')//year(date(gf_fecha_serv()))
		ls_tran = this.getitemstring(1,'movi_tipo_transaccion')
		ls_subt = this.getitemstring(1,'movi_sub_transaccion')			
//		if ls_tran = 'RC' then
//			li_filas = this.retrieve(str.g_financiero, str.empresa, ls_tran, ls_doc, li_ann)
//		else
			li_filas = this.retrieve(str.g_financiero, str.empresa, ls_tran, ls_doc, li_ann, ls_subt)
//		end if
		
		if	li_filas = 0 then
			parent.triggerevent('ue_adicionar')
			this.setitem(1,'movi_documento',ls_doc)
			this.setitem(1,'movi_tipo_transaccion',ls_tran)
			this.setitem(1,'movi_sub_transaccion',ls_subt)
			ls_naturaleza = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_movimiento')
			this.setitem(1,'movi_naturaleza',ls_naturaleza)		
			this.setitem(1,'movi_referencia',ls_doc)		
			this.setcolumn('movi_documento')
			if ls_tran = 'RC' then
				this.setitem(1,'movi_comments','INGRESO A CAJA')
			//	this.Modify("movi_comentario.Height='248'")
			//	this.Modify("movi_comentario.Y='1573'")				
				//if( movi_tipo_transaccion = 'RC', 1573, 59)				
			else
				this.setitem(1,'movi_comments','')			
			//	this.Modify("movi_comentario.Height='3104'")				
			//	this.Modify("movi_comentario.Y='59'")				
			end if			
			if is_historica = 'N' then
				dw_3.setitem(1,'ddia_no_documento', ls_doc)
				dw_3.setitem(1,'ddia_no_referencia', ls_doc)
				dw_3.setitem(1,'ddia_fecha', date(gf_fecha_serv()))
				dw_3.setitem(1,'ddia_g_financiero',str.g_financiero)
				dw_3.setitem(1,'ddia_empresa',str.empresa)
				dw_3.setitem(1,'ddia_aplicacion_mg','CC')
				dw_3.setitem(1,'ddia_ann', ii_ann)
				dw_3.setitem(1,'ddia_id', str.usuario)
				dw_3.setitem(1,'ddia_tipo_transaccion', is_tran)
				dw_3.setitem(1,'ddia_sub_trans', is_stran)
				if ls_naturaleza = 'D' then
					dw_3.setitem(1,'naturaleza','C')	
				else
					dw_3.setitem(1,'naturaleza','D')					
				end if
				dw_3.setitem(1,'ddia_linea',1)
				dw_3.setitem(1,'tipo','C')
			  SELECT isnull(dgmserdr.serd_mgcuenta  ,'')
				 INTO :ls_cuenta  
				 FROM dgmserdr  
				WHERE ( dgmserdr.serd_g_financiero = :str.g_financiero ) AND  
						( dgmserdr.serd_empresa = :str.empresa ) AND  
						( dgmserdr.serd_transaccion = :is_tran ) AND  
						( dgmserdr.serd_sub_trans = :is_stran ) AND  
						( dgmserdr.serd_aplicacion = 'CC' ) ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al buscar cuenta '+sqlca.sqlerrtext,1,1,'E')
						return 2
					end if
			
				if ls_cuenta = '' then
					gf_mensaje('','Debe asignar la cuenta a la transaccion. Verifique !!!',1,1,'E')
					return 
				end if
						
				dw_3.setitem(1,'ddia_mg_cuenta',ls_cuenta)
				dw_3.setitem(1,'cuenta',ls_cuenta)
			end if////del is historica
		else
			ii_ann_anterior = this.getitemnumber(1,'movi_anno')
			is_doc_anterior = this.getitemstring(1,'movi_documento')
			is_ref_anterior = this.getitemstring(1,'movi_referencia')
			il_tercero_anterior = this.getitemnumber(1,'movi_tercero')
			ll_tercero		 = this.getitemnumber(1,'movi_tercero')
			ldec_saldo = gf_saldo_anterior_new( this.getitemnumber(1,'movi_tercero'), gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)
			this.setitem(1,'saldo',ldec_saldo)			
			ls_referencia = this.getitemstring(1,'movi_referencia')
			ii_ann 		  = this.getitemnumber(1,'movi_anno')
			is_historica  = this.getitemstring(1,'movi_historica')
			if isnull(is_historica) then is_historica = 'N'
			this.setcolumn('movi_documento')
			if is_historica = 'N' then
				dw_3.visible = true
				if dw_3.retrieve(str.g_financiero, str.empresa, 'CC' , ls_tran, ls_doc, ls_referencia, ii_ann , '1') = 0 then
					dw_3.insertrow(1)
					dw_3.setitem(1,'ddia_fecha', date(gf_fecha_serv()))
					dw_3.setitem(1,'ddia_g_financiero',str.g_financiero)
					dw_3.setitem(1,'ddia_empresa',str.empresa)
					dw_3.setitem(1,'ddia_aplicacion_mg','CC')
					dw_3.setitem(1,'ddia_ann', ii_ann)
					dw_3.setitem(1,'ddia_id', str.usuario)
					dw_3.setitem(1,'ddia_tipo_transaccion', is_tran)
					dw_3.setitem(1,'ddia_sub_trans', is_stran)
					ls_naturaleza = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_movimiento')
					dw_3.setitem(1,'naturaleza',ls_naturaleza)	
					dw_3.setitem(1,'ddia_linea',1)
					dw_3.setitem(1,'tipo','C')					
					dw_3.setitem(1,'ddia_no_documento', ls_doc)
					dw_3.setitem(1,'ddia_no_referencia', ls_referencia)
					//asigna cuentas
					wf_asigna_cuenta(is_tran)			
				else //si recupera el detalle contable y reasigna los montos y asigna la cuenta
					for i = 1 to dw_3.rowcount()
						if dw_3.getitemstring(i,'naturaleza') = 'C' then
							dw_3.setitem(i,'monto_credito',dw_3.getitemnumber(i,'ddia_monto'))
						else
							dw_3.setitem(i,'monto_debito',dw_3.getitemnumber(i,'ddia_monto'))
						end if
						dw_3.setitem(i,'cuenta',dw_3.getitemstring(i,'ddia_mg_cuenta'))
					next
				end if
			else
				dw_3.visible = false
			end if						
			//Si es RECIBO DE PAGOS o INGRESOS
			if is_tran = 'RC' or is_tran = 'NC' then
				//documentos aplicados
				if	dw_6.retrieve(str.g_financiero, str.empresa, ls_tran, is_stran, ls_doc, ls_referencia, li_ann) > 0 then
					dw_5.dataobject = 'dw_documentos_por_aplicar_todos' //DW de todos los debitos para modificacion
					dw_5.settransobject(sqlca)
					//documentos Debitos del Cliente
					if	dw_5.retrieve(str.g_financiero, str.empresa, ll_tercero) > 0 then	
						for i = 1 to dw_6.rowcount()
							ld_monto 	  = dw_6.getitemnumber(i,'ccdrefac_refa_monto_pagado')
							ls_aplicacion = dw_6.getitemstring(i,'refa_aplicacion_ori')
							ls_tran       = dw_6.getitemstring(i,'refa_tipo_transaccion_ori')
							ls_stran		  = dw_6.getitemstring(i,'refa_sub_transaccion_ori')
							ls_documento  = dw_6.getitemstring(i,'refa_documento_ori')
							ls_referencia = dw_6.getitemstring(i,'refa_referencia_ori')
							li_ann		  = dw_6.getitemNumber(i,'refa_ann_ori')
							
							ls_find = "movi_aplicacion = '"+ls_aplicacion+"' and movi_tipo_transaccion = '"+ls_tran+"' and movi_sub_transaccion = '"+ls_stran+"' and movi_documento = '"+ls_documento+"' and movi_referencia = '"+ls_referencia+"' and movi_anno = "+string(li_ann)
							li_registro = dw_5.find(ls_find, 1, dw_5.rowcount())
							if li_registro > 0 then //Si encontro el documento, asigna el valor
								dw_5.setitem(li_registro,'monto_aplica',ld_monto)
								ld_saldo = dw_5.getitemnumber(li_registro,'movi_saldo')
								dw_5.setitem(li_registro,'movi_saldo',ld_saldo + ld_monto)			
								ld_monto_aplicado = dw_5.getitemnumber(li_registro,'movi_monto_aplicado')
								dw_5.setitem(li_registro,'movi_monto_aplicado',ld_monto_aplicado - ld_monto)				
							end if
						next
						dw_5.setfilter('movi_saldo <> 0')
						dw_5.filter()
					end if // del dw_5.retrieve(Saldo de Cliente)
				else //Si no tenia documentos aplicados
					dw_5.dataobject = 'dw_documentos_por_aplicar' //DW de solo lo pendiente
					dw_5.settransobject(sqlca)
					//documentos Debitos del Cliente
					dw_5.retrieve(str.g_financiero, str.empresa, ll_tercero)
				end if // del retreive del dw_5, documentos del cliente
			end if //si la tran es RC
		end if
	case	'movi_tarjeta'
		ld_tarjeta = double(data)
		ld_porcentaje = this.getitemnumber(1, 'movi_porcentaje_visa')
		if ld_porcentaje = 0 then
			ld_porcentaje = 0.00
		end if
		this.setitem(1,'movi_porcentaje_visa',ld_porcentaje)
		this.setitem(1,'movi_comision',round(ld_tarjeta * (ld_porcentaje / 100),2))
			ld_monto = this.getitemnumber(1,'total_final')
			choose case this.getitemstring(1,'movi_naturaleza')				
			case 'C'
				dw_3.setitem(1,'monto_debito',ld_monto)
				if dw_3.rowcount() > 1 then
					dw_3.setitem(2,'monto_credito',ld_monto)
				end if
			case 'D'
				dw_3.setitem(1,'monto_credito',ld_monto)				
				if dw_3.rowcount() > 1 then
					dw_3.setitem(2,'monto_debito',ld_monto)
				end if
			end choose

		//Asigna el pago a los movimientos debitos
		wf_asigna_pagos()
		
	case	'movi_porcentaje_visa'
		ld_tarjeta = this.getitemnumber(1,'movi_tarjeta')
		ld_porcentaje = double(data)
		this.setitem(1,'movi_comision',round(ld_tarjeta * (ld_porcentaje / 100),2))
			ld_monto = this.getitemnumber(1,'total_final')
			choose case this.getitemstring(1,'movi_naturaleza')				
			case 'C'
				dw_3.setitem(1,'monto_debito',ld_monto)
				if dw_3.rowcount() > 1 then
					dw_3.setitem(2,'monto_credito',ld_monto)
				end if
			case 'D'
				dw_3.setitem(1,'monto_credito',ld_monto)				
				if dw_3.rowcount() > 1 then
					dw_3.setitem(2,'monto_debito',ld_monto)
				end if
			end choose
		//Asigna el pago a los movimientos debitos
		wf_asigna_pagos()
		
	case 'movi_monto'
		if is_tran = 'RC' then
			ld_monto = this.getitemnumber(1,'total_final')
		else
			ld_monto = this.getitemnumber(1,'movi_monto')
		end if
		
		if is_historica = 'N' then
			choose case this.getitemstring(1,'movi_naturaleza')				
				case 'C'
					dw_3.setitem(1,'monto_debito',ld_monto)
					if dw_3.rowcount() > 1 then
						dw_3.setitem(2,'monto_credito',ld_monto)
					end if
				case 'D'
					dw_3.setitem(1,'monto_credito',ld_monto)				
					if dw_3.rowcount() > 1 then
						dw_3.setitem(2,'monto_debito',ld_monto)
					end if
			end choose
		end if
		//aplica_montos		
		wf_asigna_pagos()
//		return 2
//		this.setcolumn('movi_comments')
	case	'movi_referencia'
//		if ii_historico = 0 then
			for i = 1 to dw_3.rowcount()
				dw_3.setitem(i,'ddia_no_referencia', data)
			next
//		end if
	case 'movi_efectivo', 'movi_cheque','movi_tarjeta', 'movi_transferencia','movi_vuelto', 'movi_comision'
		if is_tran = 'RC' or is_tran+is_stran = 'ND0' or is_tran+is_stran = 'ND1' then
			ld_monto = this.getitemnumber(1,'total_final')
			choose case this.getitemstring(1,'movi_naturaleza')				
			case 'C'
				dw_3.setitem(1,'monto_debito',ld_monto)
				if dw_3.rowcount() > 1 then
					dw_3.setitem(2,'monto_credito',ld_monto)
				end if
			case 'D'
				dw_3.setitem(1,'monto_credito',ld_monto)				
				if dw_3.rowcount() > 1 then
					dw_3.setitem(2,'monto_debito',ld_monto)
				end if
			end choose
		end if
		//Asigna el pago a los movimientos debitos
		wf_asigna_pagos()
		
//		this.setcolumn('movi_comments')
end choose
end event

event dw_1::buttonclicked;call super::buttonclicked;	String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error, ls_tran, ls_stran, ls_codigo
	integer li_c, li_b
	long    ll_lter
	Datawindow        dww
	str_dg_dynamic_find	lstr_df

if dwo.name = 'b_modificar' then
	OpenWithParm(w_clave_autorizada, parent)

	If is_user <> "*" then
		dw_1.setitem(1,'movi_cierre_mensual','N')
	end if
	
	dw_1.accepttext()

elseif dwo.name = 'b_buscar' then
		//Busqueda del producto
	//	
	is_tran = this.getitemstring(1,'movi_tipo_transaccion')
	is_stran = this.getitemstring(1,'movi_sub_transaccion')
	
	if is_tran = '' or isnull(is_tran) then
		gf_mensaje('','Seleccione una Transaccion para buscar Documentos',1,1,'E')
		return
	end if
	
	
		lstr_df.texto_campo [1,1] = "cctmovim.movi_documento"
		lstr_df.texto_campo [1,2] = "Documento"
		lstr_df.texto_campo [1,3] = "movi_documento"
		lstr_df.texto_campo [1,4] = 'V'
	//	lstr_df.texto_campo [1,5] = '280'	
		lstr_df.texto_campo [2,1] = "cctmovim.movi_a_nombre"
		lstr_df.texto_campo [2,2] = "A Nombre de"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '770'
		lstr_df.texto_campo [3,1] = "cctmovim.movi_fecha_tran"
		lstr_df.texto_campo [3,2] = "Fecha"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [3,5] = '285'
		lstr_df.texto_campo [4,1] = "cctmovim.movi_referencia"
		lstr_df.texto_campo [4,2] = "Referencia"
		lstr_df.texto_campo [4,3] = ""
		lstr_df.texto_campo [4,4] = 'V'		
		lstr_df.texto_campo [5,1] = "cctmovim.movi_monto"
		lstr_df.texto_campo [5,2] = "Valor"
		lstr_df.texto_campo [5,3] = ""
		lstr_df.texto_campo [5,4] = 'V'		
		lstr_df.texto_campo [6,1] = "cctmovim.movi_ruc_tercero"
		lstr_df.texto_campo [6,2] = "Cuenta"
		lstr_df.texto_campo [6,3] = ""
		lstr_df.texto_campo [6,4] = 'V'		
		lstr_df.texto_campo [7,1] = "cctmovim.movi_comments"
		lstr_df.texto_campo [7,2] = "Detalle"
		lstr_df.texto_campo [7,3] = ""
		lstr_df.texto_campo [7,4] = 'V'				
		lstr_df.texto_campo [7,5] = '1150'
		
		lstr_df.tabla = " cctmovim "
			
		lstr_df.tabla_where = &
					"WHERE (cctmovim.movi_g_financiero = " + string(str.g_financiero) + ") and " +&
							 "(cctmovim.movi_empresa = " + string(str.empresa) + ") and " +&
							 "(cctmovim.movi_aplicacion = 'CC') and " +&							
							 "(cctmovim.movi_anno = "+string(ii_ann)+") and " +&			
							 "(cctmovim.movi_tipo_transaccion = '"+is_tran+"') and " +&			
							 "(cctmovim.movi_sub_transaccion = '"+is_stran+"') and " +&							 
							 "(cctmovim.movi_tipo_transaccion + movi_sub_transaccion <> 'ND8') "

		//					 "(cctmovim.movi_tipo_transaccion = '"+ls_tran+"') and " +&
							 
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	
	If len (ls_find) = 0 Then Return
		
	ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo,"'"," ")
	ls_codigo = Trim(ls_codigo)
	this.setitem(1,'movi_documento',ls_codigo)
	this.setcolumn('movi_documento')
	this.accepttext()
	this.trigger event itemchanged(1, object, ls_codigo)
	
elseif dwo.name = 'b_buscar_cliente' then
			
		lstr_df.texto_campo [2,1] = "ccmclien.clie_ref_anterior" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [2,2] = "Cuenta"
		lstr_df.texto_campo [2,3] = "clie_ref_anterior"
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '350'
		lstr_df.texto_campo [1,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [1,2] = "Nombre del Cliente"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '700'		
		lstr_df.texto_campo [3,1] = "dgmterce.terc_tercero"
		lstr_df.texto_campo [3,2] = "Tercero"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'I'
		lstr_df.texto_campo [4,1] = "dgapais.pais_descripcion"
		lstr_df.texto_campo [4,2] = "País"
		lstr_df.texto_campo [4,3] = ""
		lstr_df.texto_campo [4,4] = 'V'
		lstr_df.texto_campo [4,5] = '550'
		lstr_df.texto_campo [5,1] = "dgaregio.regi_descripcion"
		lstr_df.texto_campo [5,2] = "Ciudad"
		lstr_df.texto_campo [5,3] = ""
		lstr_df.texto_campo [5,4] = 'V'
		lstr_df.texto_campo [5,5] = '550'
		
		lstr_df.tabla = " dgmterce, dgapais, ccmclien, dgaregio "
		
		
		lstr_df.tabla_where = &
					"WHERE ( dgmterce.terc_pais = dgapais.pais_pais ) and  " +&				
		 					 "( dgmterce.terc_pais = dgaregio.regi_pais ) and  " +&				
  		 					 "( dgmterce.terc_region = dgaregio.regi_codigo_region ) and  " +&				
							 "(ccmclien.clie_g_financiero = " + string(str.g_financiero) + " and " +&
							 "ccmclien.clie_empresa = " + string(str.empresa) + ") 	and " +&
							"(dgmterce.terc_tercero = ccmclien.clie_tercero) and " +&
					      "(ccmclien.clie_estado = 'A' ) AND  " +&
					      "(ccmclien.clie_cuenta_mala <> 1 ) "  							
		
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	If len (ls_find) = 0 Then Return
		
		
	ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo1,"'"," ")
	ls_codigo1 = Trim(ls_codigo1)

	dw_1.setitem(1,'movi_ruc_tercero',ls_codigo1)
	dw_1.accepttext()
	dw_1.setcolumn('movi_ruc_tercero')
	dw_1.trigger event itemchanged(1,object,ls_codigo1)
	
end if
end event

event dw_1::itemfocuschanged;//override
this.accepttext()
string ls_tran, ls_doc
integer li_ann

//choose case this.getcolumnname()
//	case 'movi_tipo_transaccion'
//		ls_tran = this.getitemstring(1,'movi_tipo_transaccion')
//		idwc_stran.setfilter("dgmsubse_subs_transaccion = '"+ls_tran+"'")
//		idwc_stran.filter()
//		this.setitem(1,'movi_sub_transaccion','')
//end choose
end event

event dw_1::ue_microayuda;//override
end event

event dw_1::ue_helpcol;call super::ue_helpcol;	String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error, ls_tran, ls_codigo
	integer li_c, li_b, li_ann
	long    ll_lter
	Datawindow        dww
	str_dg_dynamic_find	lstr_df

if this.getcolumnname() = 'movi_documento' then
		//Busqueda del producto
	//	
	ls_tran = this.getitemstring(1,'movi_tipo_transaccion')
	li_ann = this.getitemnumber(1,'movi_anno')
	
	if ls_tran = '' or isnull(ls_tran) then
		gf_mensaje('','Seleccione una Transaccion para buscar Documentos',1,1,'E')
		return
	end if
	
	
		lstr_df.texto_campo [1,1] = "cctmovim.movi_documento"
		lstr_df.texto_campo [1,2] = "Documento"
		lstr_df.texto_campo [1,3] = "movi_documento"
		lstr_df.texto_campo [1,4] = 'V'
	//	lstr_df.texto_campo [1,5] = '280'	
		lstr_df.texto_campo [2,1] = "cctmovim.movi_a_nombre"
		lstr_df.texto_campo [2,2] = "A Nombre de"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '700'
		lstr_df.texto_campo [3,1] = "cctmovim.movi_fecha_tran"
		lstr_df.texto_campo [3,2] = "Fecha"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [3,5] = '285'
		lstr_df.texto_campo [4,1] = "cctmovim.movi_referencia"
		lstr_df.texto_campo [4,2] = "Referencia"
		lstr_df.texto_campo [4,3] = ""
		lstr_df.texto_campo [4,4] = 'V'		
		lstr_df.texto_campo [5,1] = "cctmovim.movi_monto"
		lstr_df.texto_campo [5,2] = "Valor"
		lstr_df.texto_campo [5,3] = ""
		lstr_df.texto_campo [5,4] = 'V'
		
		lstr_df.tabla = " cctmovim "
			
		lstr_df.tabla_where = &
					"WHERE (cctmovim.movi_g_financiero = " + string(str.g_financiero) + ") and " +&
							 "(cctmovim.movi_empresa = " + string(str.empresa) + ") and " +&
							 "(cctmovim.movi_anno = " + string(li_ann) + ") and " +&
							 "(cctmovim.movi_aplicacion = 'CC') and " +&							 
							 "(cctmovim.movi_tipo_transaccion = '"+ls_tran+"') and " +&
							 "(cctmovim.movi_tipo_transaccion + movi_sub_transaccion <> 'ND8') "
							 
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	
	If len (ls_find) = 0 Then Return
		
	ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo,"'"," ")
	ls_codigo = Trim(ls_codigo)
	this.setitem(1,'movi_documento',ls_codigo)
	this.setcolumn('movi_documento')
	this.accepttext()
	this.trigger event itemchanged(1, object, ls_codigo)
	
elseif this.getcolumnname() = 'movi_ruc_tercero' then
			
		lstr_df.texto_campo [2,1] = "ccmclien.clie_ref_anterior" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [2,2] = "Cuenta"
		lstr_df.texto_campo [2,3] = "clie_ref_anterior"
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '350'
		lstr_df.texto_campo [1,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [1,2] = "Nombre del Cliente"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '700'		
		lstr_df.texto_campo [3,1] = "dgmterce.terc_tercero"
		lstr_df.texto_campo [3,2] = "Tercero"
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

	dw_1.setitem(1,'movi_ruc_tercero',ls_codigo1)
	dw_1.accepttext()
	dw_1.setcolumn('movi_ruc_tercero')
	dw_1.trigger event itemchanged(1,object,ls_codigo1)
	
end if
end event

event dw_1::clicked;call super::clicked;integer li_pos, li_ann
date 	ld_date,ld_ini_date, ld_hoy
accepttext()

ld_hoy = date(gf_fecha_serv())

if dwo.name='calendario' then
	ld_ini_date=date(dw_1.GetItemDateTime(dw_1.getrow(),"movi_fecha_tran"))
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
elseif dwo.name='calendario2' then	
	ld_ini_date=date(dw_1.GetItemDateTime(dw_1.getrow(),"movi_fecha_vence"))
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
end if
end event

event dw_1::ue_tabfinal;//override
end event

event dw_1::ue_down;//override
end event

type st_ayuda from w_fa_padre`st_ayuda within w_transacciones
end type

type dw_2 from datawindow within w_transacciones
boolean visible = false
integer x = 87
integer y = 12
integer width = 3232
integer height = 1388
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Impresion del Recibo"
string dataobject = "dw_imprimir_recibo"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "AppIcon!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_transacciones
integer x = 2743
integer y = 444
integer width = 507
integer height = 104
integer taborder = 11
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Estado de Cuenta"
end type

event clicked;string ls_error, ls_nombre

		str_cc_formatos str_formato1		
		str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
		str_formato1.tercero = dw_1.getitemNumber(1,"movi_tercero")
		if str_formato1.tercero = 0 or isnull(str_formato1.tercero) then return
		date ldt_fecha
		ldt_fecha = date(gf_fecha_Serv())
		lstr_rangfech.fecha1 = date(relativedate(date(gf_fecha_serv()), - 120)) //date('01/01/'+string(year(ldt_fecha) - 1 ))
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
		  SELECT terc_descripcion  
			 INTO :ls_nombre
			 FROM dgmterce  
			WHERE ( dgmterce.terc_tercero = :str_formato1.tercero ) ;

		lstr_rangfech.nombre1 = ls_nombre+string(str_formato1.tercero)
		lstr_rangfech.nombre2 = ls_nombre+string(str_formato1.tercero)
		string ls_ruc
		ls_ruc = dw_1.getitemstring(1,'movi_ruc_tercero')
		lstr_rangfech.desdeclienteref = ls_ruc//str_formato1.tercero
		lstr_rangfech.hastaclienteref = ls_ruc//str_formato1.tercero
							
		if not isnull(lstr_rangfech.fecha1) and not isnull(lstr_rangfech.fecha2) or &
				lstr_rangfech.fecha1 <> date('00/00/0000') and lstr_rangfech.fecha2 <> date('00/00/0000')then
				commit using sqlca;
				wf_actualiza_antiguedad('E')
				OpenSheetWithParm(w_estadocuenta_imp,lstr_rangfech,str.frame,2, layered!)			
		end if	

end event

type cb_2 from commandbutton within w_transacciones
integer x = 2743
integer y = 556
integer width = 507
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
string text = "Mantenimiento"
end type

event clicked;	str_cc_formatos str_formato1		
	str_formato1.tercero = dw_1.getitemnumber(1,'movi_tercero')
	OpenSheetwithparm(w_mant_clientes,str_formato1,parent,2, Original!)
end event

type cb_3 from commandbutton within w_transacciones
integer x = 91
integer y = 2300
integer width = 603
integer height = 104
integer taborder = 31
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Anular Transacción"
end type

event clicked;string ls_documento, ls_comentario
decimal {2} ld_monto
datetime ldt_fecha_tran, ldt_fecha

ldt_fecha_tran 	 = dw_1.getitemdatetime(dw_1.getrow(),'movi_fecha_tran')		
if not gf_valida_fecha_conta(ldt_fecha_tran) then			
	return
end if

ls_documento = dw_1.getitemstring(1,'movi_documento')
if ls_documento = '' or isnull(ls_documento) then return

if dw_1.getitemstring(1,'movi_estado') = 'AN' then 
	gf_mensaje('','La transaccion ya fue anulada, verifique !!!',1,1,'E')
	return
end if

if gf_mensaje('','Esta seguro de Anular la Transacción ?',2,1,'Q') = 1 then
	ld_monto = dw_1.getitemnumber(1,'movi_monto')
	ls_comentario = 'TRANSACCION ANULADA, VALOR '+string(ld_monto,'$ ###,##0.00')+ ' - ' +dw_1.getitemstring(1, 'movi_comentario')
	ldt_fecha = gf_fecha_serv()
	
	update cctmovim
	set   cctmovim.movi_monto = 0,   
         cctmovim.movi_estado = 'AN',   
         cctmovim.movi_comments = :ls_comentario,
			cctmovim.movi_fecha_anul = :ldt_fecha,
			cctmovim.movi_usuario_anul = :str.usuario
   WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
         ( cctmovim.movi_empresa = :str.empresa ) AND  
         ( cctmovim.movi_aplicacion = 'CC' ) AND  
         ( cctmovim.movi_tipo_transaccion = :is_tran ) AND  
         ( cctmovim.movi_documento = :ls_documento ) AND  
         ( cctmovim.movi_anno = :ii_ann ) AND  
         ( cctmovim.movi_tipo_transaccion+cctmovim.movi_sub_transaccion <> 'ND8' );
			
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Anular la transaccion '+sqlca.sqlerrtext,1,1,'E')			
			rollback ;
		end if
		
  DELETE FROM coddiari  
	WHERE ( coddiari.ddia_g_financiero = :str.g_financiero ) AND  
			( coddiari.ddia_empresa = :str.empresa ) AND  
			( coddiari.ddia_aplicacion_mg = 'CC' ) AND  
			( coddiari.ddia_tipo_transaccion = :is_tran ) AND  
			( coddiari.ddia_sub_trans		  = :is_stran ) AND
			( coddiari.ddia_sub_trans = :is_stran ) AND  
			( coddiari.ddia_no_documento = :is_doc_anterior ) AND  
			( coddiari.ddia_no_referencia = :is_ref_anterior ) AND  
			( coddiari.ddia_ann = :ii_ann_anterior ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Eliminar Detalle del Asiento '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return
		end if

		  	UPDATE cotdiari  
			  set  diar_monto = 0,
			  	    diar_descripcion = :ls_comentario,
					diar_nombre = 'ANULADO - '+diar_nombre
			WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
					( cotdiari.diar_empresa = :str.empresa ) AND  
					( cotdiari.diar_aplicacion_mg = 'CC' ) AND  
					( cotdiari.diar_tipo_transaccion = :is_tran ) AND  
					( cotdiari.diar_sub_trans = :is_stran ) AND
					( cotdiari.diar_sub_trans = :is_stran ) AND  
					( cotdiari.diar_no_documento = :is_doc_anterior ) AND  
					( cotdiari.diar_no_referencia = :is_ref_anterior ) AND  
					( cotdiari.diar_ann = :ii_ann_anterior ) ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Eliminar Encabezado del Asiento '+sqlca.sqlerrtext,1,1,'E')
					rollback;
				end if
		
		commit ;
		dw_1.setfocus()
		dw_1.setcolumn('movi_documento')
		dw_1.triggerevent('itemchanged')
end if
end event

type pb_1 from picturebutton within w_transacciones
integer x = 3584
integer y = 468
integer width = 169
integer height = 148
integer taborder = 31
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string picturename = "C:\Sistemas\HYMSOFT\Art\NOTE04.BMP"
alignment htextalign = left!
end type

event clicked;long ll_tercero
ll_tercero = dw_1.getitemnumber(1,'movi_tercero')
str_cc_formatos str_formato2		
str_formato2.tercero = ll_tercero
if ll_tercero > 0 then
	Opensheetwithparm(w_notas,str_formato2,str.frame,2,original!)
end if

end event

type st_1 from statictext within w_transacciones
integer x = 3305
integer y = 472
integer width = 274
integer height = 144
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
string text = "Notas del Cliente"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_1 from u_ddcalen within w_transacciones
boolean visible = false
integer x = 1467
integer y = 332
integer taborder = 11
boolean bringtotop = true
end type

on uo_1.destroy
call u_ddcalen::destroy
end on

event ue_clicked;call super::ue_clicked;datetime ldt_fecha_tran, ldt_fecha_anterior
integer li_ann_anterior
dw_1.SetItem ( dw_1.getrow(), 'movi_fecha_tran', uo_1.return_sel_date() )

if uo_1.allow_close then
	this.visible=false
	dw_1.SetFocus()
	
	ldt_fecha_tran 	 = dw_1.getitemdatetime(dw_1.getrow(),'movi_fecha_tran')		
	ldt_fecha_anterior = dw_1.getitemdatetime(dw_1.getrow(),'movi_fecha_tran', Primary!, True)		
	ii_ann = year(date(dw_1.getitemdatetime(dw_1.getrow(),'movi_fecha_tran')))
	li_ann_anterior = dw_1.getitemnumber(1,'movi_anno')
		
	if not gf_valida_fecha_conta(ldt_fecha_anterior) then			
		dw_1.setitem(1,'movi_fecha_tran', ldt_fecha_anterior)
		dw_1.setcolumn('movi_fecha_tran')
		return
	end if

	if not gf_valida_fecha_conta(ldt_fecha_tran) then			
		dw_1.setitem(1,'movi_fecha_tran', ldt_fecha_anterior)
		dw_1.setcolumn('movi_fecha_tran')
		return
	end if

	if not gf_valida_fecha_futura(ldt_fecha_tran) then			
		if ldt_fecha_tran = ldt_fecha_anterior then
			dw_1.setitem(1,'movi_fecha_tran', date(gf_fecha_serv()))				
		else
			dw_1.setitem(1,'movi_fecha_tran', ldt_fecha_anterior)
		end if
		dw_1.setcolumn('movi_fecha_tran')
		return
	end if

	//Si los anios son diferentes asigna el anio
	if ii_ann <> li_ann_anterior then
		dw_1.setitem(1,'movi_anno',ii_ann)
	end if
end if


end event

event destructor;call super::destructor;call u_ddcalen::destroy
end event

type dw_3 from datawindow within w_transacciones
event ue_helpcol pbm_dwnkey
integer x = 82
integer y = 1624
integer width = 3227
integer height = 604
integer taborder = 41
boolean bringtotop = true
string title = "none"
string dataobject = "dw_detalle_contable"
boolean border = false
boolean livescroll = true
end type

event ue_helpcol;// Toma la Tecla que el usuario presione
string ls_columna, ls_codigo_cta
CHOOSE CASE key
		
	CASE KeyF1! 
		ls_columna = this.getcolumnname()
		choose case ls_columna
			
			case 'cuenta', 'ddia_mg_cuenta'				
				ls_codigo_cta = wf_busca_cuenta_contable()				
				dw_3.trigger event itemchanged(dw_3.getrow(),object,ls_codigo_cta)							
			case 'ddia_transito', 'ddia_class', 'ddia_codigo_cte_prov'
				dw_3.trigger event doubleclicked(1,1,dw_3.getrow(),object)				
		end choose
		
	CASE	  Keyenter! 
		
//	  This.Triggerevent("ue_entercol")
	  
END CHOOSE
end event

event clicked;long ll_pais, ll_tercero, ll_encontro, ll_codigo
decimal{2} ld_cargo_mora, ld_limite_credito
integer li_morosidad, li_vendedor, li_contador, li_rtn, li_existe
string ls_cuenta, ls_estado, ls_path,ls_nomfile,ls_filter, ls_codigo

THIS.ACCEPTTEXT()

choose case dwo.name
	case	'b_adicionar'
//		this.reset()
		this.scrolltorow(this.insertrow(0))
		dw_3.setitem(dw_3.getrow(),'ddia_fecha', date(gf_fecha_serv()))
		dw_3.setitem(dw_3.getrow(),'ddia_g_financiero',str.g_financiero)
		dw_3.setitem(dw_3.getrow(),'ddia_empresa',str.empresa)
		dw_3.setitem(dw_3.getrow(),'ddia_aplicacion_mg','CC')
//		dw_3.setitem(dw_3.getrow(),'ddia_ann', ii_ann) //year(date(gf_fecha_serv())))
		dw_3.setitem(dw_3.getrow(),'ddia_id', str.usuario)
		dw_3.setitem(dw_3.getrow(),'ddia_tipo_transaccion', is_tran)
		dw_3.setitem(dw_3.getrow(),'ddia_sub_trans', is_stran)
		if dw_1.getitemstring(1,'movi_naturaleza')  = 'D' then
			dw_3.setitem(dw_3.getrow(),'naturaleza','C')		
		else
			dw_3.setitem(dw_3.getrow(),'naturaleza','D')	
		end if
		dw_3.setitem(dw_3.getrow(),'ddia_linea',dw_3.getrow())
		dw_3.setitem(dw_3.getrow(),'tipo','C')
		dw_3.setitem(dw_3.getrow(),'ddia_ann',ii_ann)
		dw_3.setitem(dw_3.getrow(),'ddia_no_documento',dw_1.getitemstring(1,'movi_documento'))
		dw_3.setitem(dw_3.getrow(),'ddia_no_referencia',dw_1.getitemstring(1,'movi_referencia'))
		this.setcolumn('cuenta')
	case 'b_eliminar'		
			if this.getrow() > 1 then this.deleterow(this.getrow())			
	case 'b_cerrar'
		parent.triggerevent('close')
	case	'b_grabar'	
		parent.triggerevent('ue_aceptar')
end choose
end event

event itemchanged;accepttext()
string ls_columna, ls_cuenta, ls_transito, ls_descrip, ls_cargado_a
integer li_encontro
string ls_class, ls_1, ls_2, ls_3
long ll_class
long ll_tercero, ll_pos
ls_columna = this.getcolumnname()

choose case ls_columna
	case 'monto_debito'
			this.setitem(row,'monto_credito',0)
			this.setitem(row,'naturaleza','D')
	case 'monto_credito'
			this.setitem(row,'monto_debito',0)
			this.setitem(row,'naturaleza','C')		
	case 'cuenta'
		ls_cuenta = this.getitemstring(this.getrow(),'cuenta')
		ls_cuenta = left( ls_cuenta + fill("0",20) ,20)
		li_encontro = idwc_plan.find("mg_cuenta = '"+ls_cuenta+"'",1,idwc_plan.rowcount())
		if li_encontro > 0 then
			this.setitem(this.getrow(),'ddia_mg_cuenta',ls_cuenta)
		else
			gf_mensaje('','Cuenta no Existe, Verifique !!!',1,1,'E')
			this.setitem(this.getrow(),'cuenta','')
			this.setitem(this.getrow(),'ddia_mg_cuenta','')
			return 2
		end if
	case 'ddia_mg_cuenta'
		ls_cuenta = this.getitemstring(this.getrow(),'ddia_mg_cuenta')
		ls_cuenta = left( ls_cuenta + fill("0",20) ,20)
		this.setitem(this.getrow(),'cuenta',ls_cuenta)	
	case	'ddia_transito'
//		ls_transito = this.getitemstring(this.getrow(),'ddia_transito')
//		this.setitem(row,'ddia_cargado_a','C')
//		if len(ls_transito) < 13 then
//			ls_transito = wf_transito(ls_transito)	
//			this.setitem(row,'ddia_transito',ls_transito)			
//			this.setitem(row,'cuenta',is_cta_barco)
//			this.setitem(row,'ddia_mg_cuenta',is_cta_barco)			
//			accepttext() 
//			return 2
//		end if
	case	'ddia_class'

		if len(data) < 10 then
			
			ls_class = data
		
			ls_1 = mid(ls_class,1, pos(ls_class, '-') -1)
		
			if len(ls_1) = 1 then
				ls_1 = '00' + ls_1
			elseif len(ls_1) = 2 then
				ls_1 = '0' + ls_1
			elseif len(ls_1) = 3 then
				ls_1 = ls_1
			elseif len(ls_1) = 0 then	//Si al digitar el codigo, no asignaron ningun guion
				ls_1 = ls_class
			end if
		
		//------------------------
			if pos(ls_class, '-') > 0 then
				ls_2 = mid(ls_class, pos(ls_class, '-') + 1)
			end if
		
			ll_pos = pos(ls_2, '-')
			
			if ll_pos = 0 then
				ls_2 = ls_2
				
				if len(ls_2) = 0 then
					ls_2 = '0000'
				elseif len(ls_2) = 1 then
					ls_2 = '000' + ls_2
				elseif len(ls_2) = 2 then
					ls_2 = '00' + ls_2
				elseif len(ls_2) = 3 then
					ls_2 = '0' + ls_2
				elseif len(ls_2) = 4 then
					ls_2 = ls_2
				end if
				
				ls_3 = '000'
			else
				ls_3 = mid(ls_2, pos(ls_2, '-') + 1)
		
				if len(ls_3) = 1 then
					ls_3 = '00' + ls_3
				elseif len(ls_2) = 2 then
					ls_3 = '0' + ls_3
				elseif len(ls_3) = 3 then
					ls_3 = ls_3
				end if
		
				ls_2 = mid(ls_2, 1, pos(ls_2, '-') - 1)
		
				if len(ls_2) = 1 then
					ls_2 = '000' + ls_2
				elseif len(ls_2) = 2 then
					ls_2 = '00' + ls_2
				elseif len(ls_2) = 3 then
					ls_2 = '0' + ls_2
				elseif len(ls_2) = 4 then
					ls_2 = ls_2
				end if
		
			end if
		
			if isnull(ls_3) then ls_3 = '000'
		
			ls_class = ls_1 + ls_2 + ls_3
		
//		  SELECT count(*)  
//			 INTO :ll_class  
//			 FROM ncargos  
//			WHERE ( ncargos.carg_cargo = :ls_class )   AND
//					( ncargos.carg_visible <> 1 or ncargos.carg_visible = null )	;
//					  
//			if sqlca.sqlcode = -1 then
//				mensaje('ERROR', 'Error al Consultar registros en CARGOS', sqlca.sqlerrtext )
//				this.setitem(this.getrow(), 'ddia_class', '')
////				this.setitem(this.getrow(), 'dpaga_descripcion_cargo', '')
//				return 2
//			end if
//		
			if ll_class = 0 then
				mensaje('Atención', 'Este Código de Cargo no existe... Revise.', '')
				return 2
			end if
		
//		  SELECT ncargos.carg_descripcion,
//					ncargos.carg_cargado_a
//			 INTO :ls_descrip,
//					:ls_cargado_a
//			 FROM ncargos  
//			WHERE ( ncargos.carg_cargo = :ls_class )  AND 
//					( ncargos.carg_visible <> 1 or ncargos.carg_visible = null )	;
//					
//			if sqlca.sqlcode = -1 then
//				mensaje("Atención", "Error al Seleccionar Registros en NACARGOS.", "")
//				return
//			end if
//		
//			this.setitem(this.getrow(), 'dpaga_descripcion_cargo', ls_descrip)
			this.setitem(this.getrow(), 'ddia_cargado_a', ls_cargado_a)
			this.setcolumn('monto_debito')
			this.setitem(this.getrow(), 'ddia_class', ls_class)
			return 2
			
		end if //del data < 10
		
	case	'ddia_codigo_cte_prov'
		ls_cuenta = this.getitemString(this.getrow(),'ddia_codigo_cte_prov')
		choose case dw_3.getitemstring(dw_3.getrow(),'tipo')
			case	'C'
				SELECT ccmclien.clie_tercero, ccmclien.clie_mg_cuenta  
				 INTO :ll_tercero , :ls_cuenta 
				 FROM ccmclien  
				WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
						( ccmclien.clie_empresa = :str.empresa ) AND  
						( ccmclien.clie_ref_anterior = :ls_cuenta )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al buscar codigo '+sqlca.sqlerrtext,1,1,'E')	
				elseif sqlca.sqlcode = 100 then
					gf_mensaje('','Cliente no existe, Verifique !!!',1,1,'E')
					this.setitem(this.getrow(),'ddia_tercero',0)
					this.setitem(this.getrow(),'cuenta','')
					this.setitem(this.getrow(),'ddia_mg_cuenta','')
				else
					this.setitem(this.getrow(),'ddia_tercero',ll_tercero)
					this.setitem(this.getrow(),'cuenta',ls_cuenta)
					this.setitem(this.getrow(),'ddia_mg_cuenta',ls_cuenta)
				end if
				
			case  'P'
				SELECT cpmprove.prov_tercero, cpmprove.prov_mg_cuenta  
				 INTO :ll_tercero , :ls_cuenta 
				 FROM cpmprove  
				WHERE ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
						( cpmprove.prov_empresa = :str.empresa ) AND  
						( cpmprove.prov_cod_proveedor = :ls_cuenta )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al buscar codigo '+sqlca.sqlerrtext,1,1,'E')	
				elseif sqlca.sqlcode = 100 then
					gf_mensaje('','Proveedor no existe, Verifique !!!',1,1,'E')
					this.setitem(this.getrow(),'ddia_tercero',0)
					this.setitem(this.getrow(),'cuenta','')
					this.setitem(this.getrow(),'ddia_mg_cuenta','')
				else
					this.setitem(this.getrow(),'ddia_tercero',ll_tercero)
					this.setitem(this.getrow(),'cuenta',ls_cuenta)
					this.setitem(this.getrow(),'ddia_mg_cuenta',ls_cuenta)
				end if				
		end choose
		
		this.setcolumn('monto_debito')
		
end choose


end event

event doubleclicked;string ls_columna, ls_codigo_cta, ls_cuenta, ls_transito, ls_class
long ll_tercero
ls_columna = this.getcolumnname()
choose case ls_columna
	
	case 'cuenta', 'ddia_mg_cuenta'				
		ls_codigo_cta = wf_busca_cuenta_contable()				
		dw_3.trigger event itemchanged(dw_3.getrow(),object,ls_codigo_cta)
	case 'ddia_transito'
//		ls_transito = wf_buscar_transito()
		this.setitem(row,'ddia_transito',ls_transito)
		dw_3.trigger event itemchanged(dw_3.getrow(),object,ls_transito)	
	case 'ddia_class'
//		ls_class = wf_busca_class()
		this.setitem(row,'ddia_class',ls_class)
		dw_3.trigger event itemchanged(dw_3.getrow(),object,ls_class)			
	case 'ddia_codigo_cte_prov'
		choose case this.getitemstring(this.getrow(),'tipo')
			case 'P' //Si es proveedor
//				ll_tercero = wf_buscar_proveedor()
				ls_codigo_cta = string(ll_tercero)
				SELECT cpmprove.prov_cod_proveedor  
				 INTO :ls_cuenta  
				 FROM cpmprove  
				WHERE ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
						( cpmprove.prov_empresa = :str.empresa ) AND  
						( cpmprove.prov_tercero = :ll_tercero )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al buscar codigo '+sqlca.sqlerrtext,1,1,'E')	
				end if
				this.setitem(this.getrow(),'ddia_codigo_cte_prov',ls_cuenta)
							
				dw_3.trigger event itemchanged(dw_3.getrow(),object,ls_codigo_cta)				
					
			case 'C' //Si es para clientes
				ll_tercero = wf_buscar_cliente()
				ls_codigo_cta = string(ll_tercero)
				SELECT ccmclien.clie_ref_anterior  
				 INTO :ls_cuenta  
				 FROM ccmclien
				WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
						( ccmclien.clie_empresa = :str.empresa ) AND  
						( ccmclien.clie_tercero = :ll_tercero )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al buscar codigo '+sqlca.sqlerrtext,1,1,'E')	
				end if
				this.setitem(this.getrow(),'ddia_codigo_cte_prov',ls_cuenta)
							
				dw_3.trigger event itemchanged(dw_3.getrow(),object,ls_codigo_cta)				
				
		end choose
	case	'ddia_transito'
		
end choose

end event

event itemfocuschanged;integer li_retorno
li_retorno = this.SelectText( 1, 99) 

end event

type dw_4 from datawindow within w_transacciones
boolean visible = false
integer x = 3835
integer y = 1760
integer width = 462
integer height = 408
integer taborder = 51
boolean bringtotop = true
string title = "none"
string dataobject = "dw_detalle_contable"
boolean border = false
boolean livescroll = true
end type

type dw_5 from datawindow within w_transacciones
boolean visible = false
integer x = 1221
integer y = 960
integer width = 2619
integer height = 648
integer taborder = 31
boolean bringtotop = true
boolean titlebar = true
string title = "Aplicar Pago"
string dataobject = "dw_documentos_por_aplicar"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event itemchanged;decimal{2} ld_monto_aplica, ld_monto, ld_monto_total, ld_saldo, ld_pendiente

accepttext()

choose case this.getcolumnname()
	case 'monto_aplica'
		ld_monto 		 = dw_1.getitemnumber(1,'total_final')		//monto del recibo
		ld_monto_total  = this.getitemnumber(1,'total_aplicado') //total aplicado
		ld_pendiente    = ld_monto - ld_monto_total					//es lo pendiente por aplicar
		ld_monto_aplica = this.getitemnumber(row,'monto_aplica') //monto aplicado de la linea
		ld_saldo			 = this.getitemnumber(row,'movi_saldo')	//saldo por aplicar
		if ld_pendiente < 0 then
			gf_mensaje('','Ha superado el monto del Pago, verifique !!!',1,1,'E')
			if ld_monto_aplica - abs(ld_pendiente) > ld_saldo then //si el monto excedente es mayor que el saldo, asigna el saldo
				this.setitem(row,'monto_aplica',ld_saldo)	
			else
				this.setitem(row,'monto_aplica',ld_monto_aplica - abs(ld_pendiente))	
			end if
			return 2
		end if
		
		if ld_monto_aplica > ld_saldo then
			gf_mensaje('','Monto aplicado es superior al Saldo, Verifique !!!',1,1,'E')
			if ld_pendiente + ld_monto_aplica >= ld_saldo then
				this.setitem(row,'monto_aplica',ld_saldo)	
			else
				this.setitem(row,'monto_aplica',ld_pendiente)	
			end if
			this.setcolumn('monto_aplica')
			return 2
		end if
			
			if ld_pendiente > 0 then
//				if ld_monto_aplica > ld_pendiente
			else
				
			end if
//			this.setitem(row,'monto_aplica',ld_saldo)
			this.setcolumn('monto_aplica')
//			return 2
//		end if
		
end choose


end event

event clicked;string ls_objeto
integer li_pos
this.accepttext()
ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if ls_objeto = "aplicar_t" then
	
//	if row = 0 then return
	
		//Asigna el pago a los movimientos debitos
		wf_asigna_pagos()
	
elseif ls_objeto = 'aplicar' then
		integer li_aplicar
		decimal{2} ld_monto, ld_saldo, ld_total_aplicado
		boolean lb_no_asignar = false
		if is_tran = 'RC' then
			ld_monto = dw_1.getitemnumber(1,'total_final')
		else
			ld_monto = dw_1.getitemnumber(1,'movi_monto')
		end if
		ld_total_aplicado		= dw_5.getitemnumber(1,'total_aplicado')
		li_aplicar = dw_5.getitemnumber(row,'aplicar')
		
		if li_aplicar = 0 then
			ld_monto = ld_monto - ld_saldo - ld_total_aplicado
			ld_saldo = dw_5.getitemnumber(row,'movi_saldo')
			if ld_saldo >= ld_monto and not lb_no_asignar then
				dw_5.setitem(row,'monto_aplica',ld_monto)
				lb_no_asignar = true
			else
				if ld_monto > 0 then
					dw_5.setitem(row,'monto_aplica',ld_saldo)
				end if
			end if			
		//Si esta desmarcando	
		else
			dw_5.setitem(row,'monto_aplica',0)
		end if
end if




//decimal{2} ld_monto_aplica, ld_monto, ld_monto_total, ld_saldo, ld_pendiente
//
//accepttext()
//
//choose case this.getcolumnname()
//	case 'monto_aplica'
//		ld_monto 		 = dw_1.getitemnumber(1,'movi_monto')
//		ld_monto_total  = this.getitemnumber(1,'total_aplicado')
//		ld_pendiente    = ld_monto - ld_monto_total
//		ld_monto_aplica = this.getitemnumber(row,'monto_aplica')
//		ld_saldo			 = this.getitemnumber(row,'movi_saldo')
//		
//		if ld_monto_aplica = 0 then
////			this.setitem(row,'monto_aplica',ld_saldo)
//		end if
//		
//		if ld_pendiente < 0 then
////			gf_mensaje('','Ha superado el monto del Pago, verifique !!!',1,1,'E')
////			this.setitem(row,'monto_aplica',ld_monto_aplica - abs(ld_pendiente))	
//			return 2
//		end if
//		
//		if ld_monto_aplica > ld_saldo then
////			gf_mensaje('','Monto aplicado es superior al Saldo, Verifique !!!',1,1,'E')
////			this.setitem(row,'monto_aplica',ld_saldo)
////			this.setcolumn('monto_aplica')
////			return 2
//		end if
//		
//end choose
//
//
end event

type dw_6 from datawindow within w_transacciones
boolean visible = false
integer x = 2400
integer y = 896
integer width = 1947
integer height = 704
integer taborder = 31
boolean bringtotop = true
string title = "none"
string dataobject = "dw_documentos_aplicados_rep"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type uo_2 from u_ddcalen within w_transacciones
boolean visible = false
integer x = 2857
integer y = 332
integer taborder = 21
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;dw_1.SetItem ( dw_1.getrow(), 'movi_fecha_vence', uo_2.return_sel_date() )

if uo_2.allow_close then
	this.visible=false
	dw_1.SetFocus()
end if


end event

on uo_2.destroy
call u_ddcalen::destroy
end on

