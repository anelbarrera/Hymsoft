forward
global type w_transacciones_banco from w_fa_padre
end type
type dw_2 from datawindow within w_transacciones_banco
end type
type cb_1 from commandbutton within w_transacciones_banco
end type
type cb_2 from commandbutton within w_transacciones_banco
end type
type cb_3 from commandbutton within w_transacciones_banco
end type
type pb_1 from picturebutton within w_transacciones_banco
end type
type st_1 from statictext within w_transacciones_banco
end type
type dw_3 from datawindow within w_transacciones_banco
end type
type dw_4 from datawindow within w_transacciones_banco
end type
type cb_4 from commandbutton within w_transacciones_banco
end type
type uo_1 from u_ddcalen within w_transacciones_banco
end type
type cb_5 from commandbutton within w_transacciones_banco
end type
type dw_5 from datawindow within w_transacciones_banco
end type
type dw_6 from datawindow within w_transacciones_banco
end type
type uo_2 from u_ddcalen within w_transacciones_banco
end type
type cb_6 from commandbutton within w_transacciones_banco
end type
end forward

global type w_transacciones_banco from w_fa_padre
integer width = 4946
integer height = 2532
string title = "Captura de Transacciones de Bancos"
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
dw_3 dw_3
dw_4 dw_4
cb_4 cb_4
uo_1 uo_1
cb_5 cb_5
dw_5 dw_5
dw_6 dw_6
uo_2 uo_2
cb_6 cb_6
end type
global w_transacciones_banco w_transacciones_banco

type variables
datawindowchild idwc_clientes, idwc_provee , idwc_tran, idwc_stran, idwc_plan, idwc_cuentas_bancarias, idwc_bancos
string is_tran, is_stran, is_tran_automatica, is_cta_barco, is_doc_anterior, is_ref_anterior, is_cuenta_bancaria, is_aplica, is_aplica_anterior
integer ii_ann, ii_ann_anterior, ii_cont_doc, ii_banco, ii_cuenta_id, ii_historico, ii_imprimir_al_grabar, ii_secuencia_global
string is_arreglo[26], is_datawindow					 
long il_tercero, il_tercero_anterior
str_rangofecha istr_rangfech, lstr_rangfech
end variables

forward prototypes
public function string wf_buscar_cuenta_contable ()
public function long wf_buscar_proveedor ()
public function long wf_buscar_cliente ()
public function string wf_transito (string as_transito)
public function string wf_buscar_transito ()
public function string wf_busca_class ()
public function boolean wf_inserta_barco (integer ai_fila)
public function string wf_secuencia_tran ()
public function boolean wf_asigna_ruc_dv (long al_codigo1)
public function boolean wf_inserta_proveedor_cliente ()
public subroutine wf_actualiza_antiguedad (string idioma)
public function boolean wf_aplica_pagos ()
public function boolean wf_guarda_facturas_pagadas ()
public function boolean wf_restaura_saldos ()
public function boolean wf_registra_asiento ()
public function boolean wf_elimina_proveedor_cliente ()
end prototypes

public function string wf_buscar_cuenta_contable ();String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error
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

public function long wf_buscar_proveedor ();string ls_codigo1, ls_find
		
		str_dg_dynamic_find	lstr_df
	
		lstr_df.texto_campo [1,1] = "cpmprove.prov_cod_proveedor" //"dgmterce.terc_identificacion"
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
		
		lstr_df.tabla = " dgmterce, dgapais, cpmprove "
		
		
		lstr_df.tabla_where = &
					"WHERE ( dgmterce.terc_pais *= dgapais.pais_pais ) and  " +&				
							 "(cpmprove.prov_g_financiero = " + string(str.g_financiero) + " and " +&
							 "cpmprove.prov_empresa = " + string(str.empresa) + ") 	and " +&
							 "cpmprove.prov_estado = 'A' and " + & 
							"(dgmterce.terc_tercero = cpmprove.prov_tercero)"
		
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

public function string wf_transito (string as_transito);integer li_mes_salida, li_mes_llegada
long ll_found
String ls_find,ls_codigo, ls_nombre, ls_sin, ls_nave, ls_puerto, ls_visita, ls_llegada, ls_salida, ls_transito, ls_ann, ls_busq, ls_fecha, data
decimal ldec_saldo_c, ldec_saldo_o
datetime ldt_llegada, ldt_salida
data = as_transito

	if len(data) = 1 then
		ls_transito = '000' + data
	elseif len(data) = 2 then
		ls_transito = '00' + data
	elseif len(data) = 3 then
		ls_transito = '0' + data
	else
		ls_transito = data
	end if

	ls_ann = string(year(date(gf_fecha_serv())))

	ls_transito = "%" + ls_transito + "-" + ls_ann + "%"

		SELECT isnull(ntransito.tran_transito, '')	 
		 INTO :ls_busq  
		 FROM ntransito  
		WHERE ( ntransito.tran_g_financiero = :str.g_financiero ) AND  
				( ntransito.tran_empresa = :str.empresa ) AND
				( ntransito.tran_transito like :ls_transito ) and
				( ntransito.tran_estado <> 'C' ) ;
			if sqlca.sqlcode = -1 then
				mensaje('ERROR', 'Error al Consultar registros en ntransito.', sqlca.sqlerrtext)
				return ''
			end if

	if ls_busq = '' then
		mensaje('Atención', 'Tránsito no existe... Verifique !!!.', '')
		dw_3.setitem(dw_3.getrow(), 'ddia_transito', '' )
		return ''
	else
		dw_3.setitem(dw_3.getrow(), 'ddia_transito', ls_busq )		
			//Busca el nombre del barco
//		  SELECT nnave.nav_nombre  
//			 INTO :ls_nave  
//			 FROM nnave,   
//					ntransito  
//			WHERE ( ntransito.tran_barco = nnave.nav_sin ) and  
//					( ( ntransito.tran_g_financiero = :str.g_financiero ) AND  
//					( ntransito.tran_empresa = :str.empresa ) AND  
//					( ntransito.tran_transito = :ls_busq ) )   ;
//					
//					if sqlca.sqlcode = -1 then
//						mensaje('Atención','Error al Seleccionar el Nombre del Barco', sqlca.sqlerrtext)
//						return ''
//					end if				
	end if
	
	ls_codigo = ls_busq
	
	return ls_codigo
end function

public function string wf_buscar_transito ();long ll_found, ll_charterer, ll_owner
integer li_mes_llegada, li_mes_salida
String ls_find,ls_codigo, ls_nombre, ls_sin, ls_nave, ls_puerto, ls_visita, ls_llegada, ls_salida, ls_fecha
decimal ldec_saldo_c, ldec_saldo_o
datetime ldt_llegada, ldt_salida

str_dg_dynamic_find	lstr_df

lstr_df.texto_campo [1,1] = "ntransito.tran_transito"
lstr_df.texto_campo [1,2] = "Transito"
lstr_df.texto_campo [1,3] = "nav_sin"
lstr_df.texto_campo [1,4] = 'V'
lstr_df.texto_campo [1,5] = '400'

lstr_df.texto_campo [2,1] = "nnave.nav_nombre"
lstr_df.texto_campo [2,2] = "Barco / Nave"
lstr_df.texto_campo [2,3] = ""
lstr_df.texto_campo [2,4] = 'V'
lstr_df.texto_campo [2,5] = '600'

lstr_df.texto_campo [3,1] = "convert(char, ntransito.tran_fecha_llegada) tran_fecha_llegada"
lstr_df.texto_campo [3,2] = "Llegada"
lstr_df.texto_campo [3,3] = ""
lstr_df.texto_campo [3,4] = 'V'
lstr_df.texto_campo [3,5] = '345'

lstr_df.texto_campo [4,1] = "nmpuerto.mpuert_nombre"
lstr_df.texto_campo [4,2] = "Visita"
lstr_df.texto_campo [4,3] = ""
lstr_df.texto_campo [4,4] = 'V'

lstr_df.tabla = "ntransito, nnave, nmpuerto"

lstr_df.tabla_where = &
			"WHERE (ntransito.tran_g_financiero = " + string(str.g_financiero) + " and " +&
					 "ntransito.tran_empresa = " + string(str.empresa) + ") and " +&
					 "(ntransito.tran_barco = nnave.nav_sin ) and " +&
					 "(ntransito.tran_puerto *= nmpuerto.mpuert_puerto) and " +&
					 "(ntransito.tran_estado <> 'C') " +&
					 " order by substring(ntransito.tran_transito,9,4) desc,ntransito.tran_transito desc"

OpenWithParm(w_dg_a_custom_find, lstr_df)
ls_find = Message.StringParm

ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)

if ls_codigo = '' or isnull(ls_codigo) then return ''

return ls_codigo

//wf_recupera_informacion(ls_codigo)
end function

public function string wf_busca_class ();string ls_codigo, ls_find

str_dg_dynamic_find	lstr_df

lstr_df.texto_campo [2,1] = "ncargos.carg_cargo"
lstr_df.texto_campo [2,2] = "Código"
lstr_df.texto_campo [2,3] = "carg_cargo"
lstr_df.texto_campo [2,4] = 'V'

lstr_df.texto_campo [1,1] = "ncargos.carg_descripcion"
lstr_df.texto_campo [1,2] = "Cargo"
lstr_df.texto_campo [1,3] = ""
lstr_df.texto_campo [1,4] = 'V'
lstr_df.texto_campo [1,5] = '1200'

lstr_df.tabla = "ncargos"

lstr_df.tabla_where = &
			"WHERE (( ncargos.carg_visible <> 1 ) or" +&
					 "( ncargos.carg_visible = null))"

OpenWithParm(w_dg_a_custom_find, lstr_df)
ls_find = Message.StringParm

ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)

if ls_codigo = '' or isnull(ls_codigo) then return ''

dw_3.setitem(dw_3.getrow(), 'ddia_class', ls_codigo)

return ls_codigo
end function

public function boolean wf_inserta_barco (integer ai_fila);// Este evento graba o modifica el detalle de la transacción.
integer li_x1,li_anno,li_naviera,li_existe,li_fila,li_contador,li_cont_2
string ls_cta_mg1,ls_docum,ls_refe,ls_aplicacion,ls_cuenta,ls_naturaleza,ls_err,ls_movimiento
string ls_transito,ls_cargo,ls_cargado_a,ls_docum_2,ls_tipo_deposito,ls_desc_cargo
long ll_tercero,ll_err,ll_proveedor
datetime ldt_fecha_actual,ldt_fecha_tran
decimal ld_monto

datawindow dw1

dw1 = dw_1

ls_docum         = dw1.getitemstring(dw1.getrow(),'movi_documento')
ls_refe          = dw1.getitemstring(dw1.getrow(),'movi_referencia')
ldt_fecha_tran   = dw1.getitemdatetime(dw1.getrow(),'movi_fecha_tran')
li_anno          = year(date(ldt_fecha_tran))
ls_aplicacion    = 'CP'//dw1.getitemstring(dw1.getrow(),'carp_aplicacion')
ll_proveedor     = dw1.getitemnumber(dw1.getrow(), 'movi_tercero')
ldt_fecha_actual = gf_fecha_serv()

ls_cargo = dw_3.getitemstring(ai_fila,"ddia_class")
ls_naturaleza = dw_3.getitemstring(ai_fila,"naturaleza")
if ls_naturaleza = 'D' then
	ld_monto = dw_3.getitemdecimal(ai_fila,"monto_debito")
else
	ld_monto = dw_3.getitemdecimal(ai_fila,"monto_credito")
end if
ls_cargado_a = dw_3.getitemstring(ai_fila,"ddia_cargado_a")
ls_transito = dw_3.getitemstring(ai_fila,"ddia_transito")
ls_tipo_deposito = dw_3.getitemstring(ai_fila,"tipo")
ls_cuenta = dw_3.getitemstring(ai_fila,"cuenta")

SELECT dgmserie.mser_movimiento  
  INTO :ls_movimiento 
  FROM dgmserie  
 WHERE ( dgmserie.mser_g_financiero = :str.g_financiero ) AND  
		 ( dgmserie.mser_empresa = :str.empresa ) AND  
		 ( dgmserie.mser_tipo_transaccion = :is_tran )   ;
		 
if sqlca.sqlcode = -1 then
	ls_err = sqlca.sqlerrtext
	Rollback;
	sqlca.autocommit = true
	Messagebox('Error al seleccionar la naturaleza',ls_err)
	Return false
end if

SELECT ncargos.carg_descripcion  
  INTO :ls_desc_cargo  
  FROM ncargos  
 WHERE ncargos.carg_cargo = :ls_cargo   ;

if sqlca.sqlcode = -1 then
	ls_err = sqlca.sqlerrtext
	Rollback;
	sqlca.autocommit = true
	Messagebox('Error al seleccionar la naturaleza',ls_err)
	Return false
end if
	
IF ls_movimiento <> ls_naturaleza THEN
	if ls_movimiento = 'C' then 
		ls_movimiento = 'D'
	else
		ls_movimiento = 'C'
	end if	
END IF

SELECT count(*)  
 INTO :li_existe
 FROM banatpagar  
WHERE ( banatpagar.tpaga_g_financiero = :str.g_financiero ) AND  
		( banatpagar.tpaga_empresa = :str.empresa ) AND  
		( banatpagar.tpaga_transito = :ls_transito ) AND  
		( banatpagar.tpaga_documento = :ls_docum ) AND  
		( banatpagar.tpaga_agno = :li_anno ) AND  
		( banatpagar.tpaga_aplicacion = :ls_aplicacion ) AND  
		( banatpagar.tpaga_transaccion = :is_tran ) AND  
		( banatpagar.tpaga_subtransaccion = :is_stran )	;
		 
if sqlca.sqlcode = -1 then
	ls_err = sqlca.sqlerrtext
	Rollback;
	sqlca.autocommit = true
	Messagebox('Error al seleccionar la naturaleza',ls_err)
	Return false
end if

IF li_existe = 0 THEN	
	
	INSERT INTO banatpagar  
			( tpaga_g_financiero,tpaga_empresa,tpaga_transito,tpaga_banco,tpaga_cuenta_bancaria,
			  tpaga_documento,tpaga_agno,tpaga_aplicacion,tpaga_transaccion,tpaga_subtransaccion,   
			  tpaga_monto_total,tpaga_usuario,tpaga_fecha,tpaga_referencia,tpaga_naturaleza,
			  tpaga_indicador_flete,tpaga_fecha_registro,tpaga_proveedor)
	VALUES ( :str.g_financiero,:str.empresa,:ls_transito,null,null,
			  :ls_docum,:li_anno,:ls_aplicacion,:is_tran,:is_stran,   
			  :ld_monto,:str.usuario,:ldt_fecha_tran,:ls_refe,:ls_movimiento,
			  'T',:ldt_fecha_actual,:ll_proveedor)  ;
	if sqlca.sqlcode = -1 then
		ls_err = sqlca.sqlerrtext
		Rollback;
		sqlca.autocommit = true
		mensaje("Atención ","¡Error al Insertar Encabezado del Barco !", ls_err)
		return false
	end if		
	
	INSERT INTO banadpagar  
			( dpaga_g_financiero,dpaga_empresa,dpaga_transito,dpaga_banco,dpaga_cuenta_bancaria,
			  dpaga_documento,dpaga_agno,dpaga_aplicacion,dpaga_transaccion,dpaga_subtransaccion,   
			  dpaga_cargo,dpaga_linea,dpaga_monto,dpaga_fecha,dpaga_no_cuenta,dpaga_cargado_a,   
			  dpaga_referencia,dpaga_proveedor,dpaga_descripcion_cargo)  
  VALUES ( :str.g_financiero,:str.empresa,:ls_transito,null,null,
			  :ls_docum,:li_anno,:ls_aplicacion,:is_tran,:is_stran,    
			  :ls_cargo,:ai_fila,:ld_monto,:ldt_fecha_tran,0,:ls_cargado_a,   
			  :ls_refe,:ll_proveedor,:ls_desc_cargo)  ;
		  
	if sqlca.sqlcode = -1 then
		ls_err = sqlca.sqlerrtext
		Rollback;
		sqlca.autocommit = true
		mensaje("informacion","Error al Insertar!",ls_err )
		return false
	end if
	
ELSE	// existe > 0
	ii_cont_doc ++
	ls_docum_2 = ls_docum + '-' + is_arreglo[ii_cont_doc]		
		
	INSERT INTO banatpagar  
			( tpaga_g_financiero,tpaga_empresa,tpaga_transito,tpaga_banco,tpaga_cuenta_bancaria,
			  tpaga_documento,tpaga_agno,tpaga_aplicacion,tpaga_transaccion,tpaga_subtransaccion,   
			  tpaga_monto_total,tpaga_usuario,tpaga_fecha,tpaga_referencia,tpaga_naturaleza,
			  tpaga_indicador_flete,tpaga_fecha_registro,tpaga_proveedor,tpaga_documento_original)
  VALUES ( :str.g_financiero,:str.empresa,:ls_transito,null,null,
			  :ls_docum_2,:li_anno,:ls_aplicacion,:is_tran,:is_stran,   
			  :ld_monto,:str.usuario,:ldt_fecha_tran,:ls_refe,:ls_movimiento,
			  null,:ldt_fecha_actual,:ll_proveedor,:ls_docum)  ;
	 if sqlca.sqlcode = -1 then
		ls_err = sqlca.sqlerrtext
		Rollback;
		sqlca.autocommit = true
		mensaje("Atención ","¡Error al Insertar Encabezado!", ls_err)
		return false
	end if
		
	INSERT INTO banadpagar  
			( dpaga_g_financiero,dpaga_empresa,dpaga_transito,dpaga_banco,dpaga_cuenta_bancaria,
			  dpaga_documento,dpaga_agno,dpaga_aplicacion,dpaga_transaccion,dpaga_subtransaccion,   
			  dpaga_cargo,dpaga_linea,dpaga_monto,dpaga_fecha,dpaga_no_cuenta,dpaga_cargado_a,   
			  dpaga_referencia,dpaga_proveedor,dpaga_documento_original,dpaga_descripcion_cargo)  
  VALUES ( :str.g_financiero,:str.empresa,:ls_transito,null,null,
			  :ls_docum_2,:li_anno,:ls_aplicacion,:is_tran,:is_stran,    
			  :ls_cargo,:ai_fila,:ld_monto,:ldt_fecha_tran,0,:ls_cargado_a,   
			  :ls_refe,:ll_proveedor,:ls_docum,:ls_desc_cargo)  ;
		  
	if sqlca.sqlcode = -1 then
		ls_err = sqlca.sqlerrtext
		Rollback;
		sqlca.autocommit = true
		mensaje("informacion","Error al Insertar Detalle!",ls_err )
		return false
	end if		
END IF 	// existe 

return true
end function

public function string wf_secuencia_tran ();string ls_sec
long ll_max
integer li_existe, li_ann

li_ann = dw_1.getitemnumber(1,'btdi_ann')

	select isnull(max(case :is_tran when 'CH' then cuen_secuencia when 'DE' then cuen_secuencia_dep when 'NB' then cuen_secuencia_nd when 'CB' then cuen_secuencia_nc when 'TD' then cuen_secuencia_trd when 'TC' then cuen_secuencia_trc end) ,0)
	into :ll_max
	from bamcuent
	where cuen_g_financiero = :str.g_financiero and
			cuen_empresa		= :str.empresa and
			cuen_banco  = :ii_banco and
			cuen_no_cuenta = :is_cuenta_bancaria ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al seleccionar secuencia '+sqlca.sqlerrtext,1,1,'E')
		return ''
	end if

choose case ii_secuencia_global
	case 1
			select isnull(max(case :is_tran when 'CH' then cuen_secuencia when 'DE' then cuen_secuencia_dep when 'NB' then cuen_secuencia_nd when 'CB' then cuen_secuencia_nc when 'TD' then cuen_secuencia_trd when 'TC' then cuen_secuencia_trc end) ,0)
					into :ll_max
					from bamcuent
					where cuen_g_financiero = :str.g_financiero and
							cuen_empresa		= :str.empresa;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al seleccionar secuencia '+sqlca.sqlerrtext,1,1,'E')
							return ''
						end if
		
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al seleccionar secuencia '+sqlca.sqlerrtext,1,1,'E')
					return ''
				end if
				
		
			DO WHILE true
				ll_max = ll_max + 1		
				ls_sec = string(ll_max)
				
				select count(*) into :li_existe
				from batdiari
				where btdi_g_financiero = :str.g_financiero and
						btdi_empresa		= :str.empresa and
						btdi_tipo_transaccion = :is_tran and
		//				btdi_sub_transaccion = :is_stran and
		//				btdi_banco			=  :ii_banco and
		//				btdi_no_cuenta		=  :is_cuenta_bancaria and
						btdi_documento 	=  :ls_sec and
						btdi_ann			=  :li_ann ;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al validar existencia '+sqlca.sqlerrtext,1,1,'E')
							return ''
						end if
												
					if li_existe = 0 then
						exit
					end if
			LOOP

	case 0	
				select isnull(max(case :is_tran when 'CH' then cuen_secuencia when 'DE' then cuen_secuencia_dep when 'NB' then cuen_secuencia_nd when 'CB' then cuen_secuencia_nc when 'TD' then cuen_secuencia_trd when 'TC' then cuen_secuencia_trc end) ,0)
					into :ll_max
					from bamcuent
					where cuen_g_financiero = :str.g_financiero and
							cuen_empresa		= :str.empresa and
							cuen_banco  = :ii_banco and
							cuen_no_cuenta = :is_cuenta_bancaria ;	
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al seleccionar secuencia '+sqlca.sqlerrtext,1,1,'E')
							return ''
						end if
			
	
		DO WHILE true
			ll_max = ll_max + 1		
			ls_sec = string(ll_max)
			
			select count(*) into :li_existe
			from batdiari
			where btdi_g_financiero = :str.g_financiero and
					btdi_empresa		= :str.empresa and
					btdi_tipo_transaccion = :is_tran and
					btdi_banco			=  :ii_banco and
					btdi_no_cuenta		=  :is_cuenta_bancaria and
					btdi_documento 	=  :ls_sec and
					btdi_ann			=  :li_ann ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al validar existencia '+sqlca.sqlerrtext,1,1,'E')
						return ''
					end if
											
				if li_existe = 0 then
					exit
				end if
		LOOP

end choose

return ls_sec
end function

public function boolean wf_asigna_ruc_dv (long al_codigo1);string ls_dv, ls_ruc, ls_descripcion

			  SELECT dgmterce.terc_identificacion,   
						dgmterce.terc_descripcion,   
						dgmterce.terc_digito_verificador  
				 INTO :ls_ruc,   
						:ls_descripcion,   
						:ls_dv  
				 FROM dgmterce  
				WHERE dgmterce.terc_tercero = :al_codigo1   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al buscar datos '+sqlca.sqlerrtext,1,1,'E')
					return false
				elseif sqlca.sqlcode = 100 then
					return false
				end if
			dw_1.setitem(1,'btdi_a_nombre',ls_descripcion)
			dw_1.setitem(1,'btdi_ruc',ls_ruc)
			dw_1.setitem(1,'btdi_digito_verificador',ls_dv)

return true
end function

public function boolean wf_inserta_proveedor_cliente ();integer li_existe, li_cont
string ls_documento, ls_referencia, ls_descrip, ls_nombre, ls_iden, ls_mg , ls_comentario, ls_comentario_detalle, &
		 ls_naturaleza, ls_tran, ls_stran, ls_cuenta, ls_referencia_banco
decimal{2} ld_monto
datetime ldt_fecha, ldt_fecha_creacion

ls_documento = dw_1.getitemstring(1,'btdi_documento')
ls_referencia_banco = dw_1.getitemstring(1,'btdi_referencia')
ls_iden = string(ii_banco)+'-'+string(ii_cuenta_id)
ldt_fecha = dw_1.getitemdatetime(1,'btdi_fecha_tran')
ldt_fecha_creacion = gf_fecha_serv()
ls_cuenta = dw_1.getitemstring(1,'btdi_cuenta')
ls_nombre = dw_1.getitemstring(1,'btdi_a_nombre')
if ii_historico = 1 then  // SI ES UNA TRANSACCION HISTORICA
	ls_naturaleza = dw_1.getitemstring(1,'btdi_naturaleza')
	if ls_naturaleza = 'C' then	//Si es Cheque u otra transaccion CR de Bancos
		if is_aplica = 'CP' then
			ls_tran = 'PA'
			ls_stran = 'PA'
		elseif is_aplica = 'CC' then
			ls_tran = 'ND'
			ls_stran = '1'					
		else
			return true
		end if
		ls_naturaleza = 'D'		
	else
		if is_aplica = 'CP' then
			ls_tran = 'NE'
			ls_stran = 'NE'
		elseif is_aplica = 'CC' then
			ls_tran = 'NC'
			ls_stran = '0'		
		else
			return true
		end if
		ls_naturaleza = 'C'
	end if
	ld_monto = dw_1.getitemnumber(1,'btdi_monto')
else
	ls_naturaleza = dw_3.getitemstring(2,'naturaleza')
	if ls_naturaleza = 'D' then
		ld_monto = dw_3.getitemnumber(2,'monto_debito')
		if is_aplica = 'CP' then
			ls_tran = 'PA'
			ls_stran = 'PA'
		else
			ls_tran = 'ND'
			ls_stran = '1'		
		end if
	elseif ls_naturaleza = 'C' then
		ld_monto = dw_3.getitemnumber(2,'monto_credito')
		if is_aplica = 'CP' then
			ls_tran = 'NE'
			ls_stran = 'NE'
		else
			ls_tran = 'NC'
			ls_stran = '0'		
		end if
	else
		ld_monto = 0
		IF ld_monto = 0.00 or isnull(ld_monto) THEN
			rollback;
			sqlca.autocommit = true;
			messagebox('Atención','El monto esta en 0, Verifique')
			return false
		END IF
	
	end if
end if // del historico = 1

ls_comentario_detalle = dw_3.getitemstring(2,"ddia_comentario_detalle")
IF not isnull(ls_comentario_detalle) and ls_comentario_detalle <> "" THEN
	ls_comentario = ls_comentario_detalle
ELSE
	ls_comentario = dw_1.getitemstring(1,"btdi_comentario")
END IF

if is_aplica = 'CP' then //si afecta a un proveedor, es pago por default
		ls_referencia = string(ii_cuenta_id) + '-' + string(il_tercero)

		SELECT count(*)
		  INTO :li_cont
		  FROM cptmovim  
		 WHERE ( cptmovim.movi_g_financiero = :str.g_financiero ) AND  
				 ( cptmovim.movi_empresa = :str.empresa ) AND  
				 ( cptmovim.movi_aplicacion = 'BA' ) AND  
				 ( cptmovim.movi_tipo_transaccion = :ls_tran ) AND  
				 ( cptmovim.movi_sub_transaccion = :ls_stran ) AND  
				 ( cptmovim.movi_documento = :ls_documento ) AND  
				 ( cptmovim.movi_anno = :ii_ann ) AND  
				 ( cptmovim.movi_referencia = :ls_referencia )   ;		
		if sqlca.sqlcode = -1 then
			ls_mg = sqlca.sqlerrtext
			rollback;
			sqlca.autocommit = true;				
			messagebox('Error',ls_mg)
			return false
		end if
		
		IF li_cont = 0 THEN
			INSERT INTO cptmovim (movi_g_financiero,movi_empresa,movi_aplicacion,
					movi_tipo_transaccion,movi_sub_transaccion,movi_documento,movi_referencia,
					movi_anno,movi_tercero,movi_ruc_tercero,movi_naturaleza,movi_monto,
					movi_fecha_tran,movi_fecha_reg,movi_usuario,movi_estado,
					movi_cierre_mensual,movi_pase_conta,movi_comentario, movi_a_nombre,movi_historico, movi_monto_final, movi_referencia_banco, movi_monto_aplicado, movi_paga_itbm)
			VALUES (:str.g_financiero,:str.empresa,'BA',:ls_tran,
					:ls_stran,:ls_documento,:ls_referencia,:ii_ann,:il_tercero,
					:ls_cuenta,:ls_naturaleza,:ld_monto,:ldt_fecha,:ldt_fecha_creacion,
					:str.usuario,'IM','N','S',:ls_comentario, :ls_nombre,1, :ld_monto, :ls_referencia_banco, 0, 0);
		else 
			update cptmovim
			set 	movi_monto = :ld_monto,
					movi_fecha_tran = :ldt_fecha,
					movi_comentario = :ls_comentario,
					movi_referencia_banco = :ls_referencia_banco
			where movi_g_financiero = :str.g_financiero and
					movi_empresa		= :str.empresa and
					movi_aplicacion	= 'BA'	and
					movi_tipo_transaccion = :ls_tran and
					movi_sub_transaccion	 = :ls_stran and
					movi_documento			 = :ls_documento and
					movi_referencia		 = :ls_referencia and
					movi_anno				 = :ii_ann ;			
		end if 
			
			if sqlca.sqlcode = -1 then
				ls_mg = sqlca.sqlerrtext
				rollback;
				sqlca.autocommit = true;
				mensaje('Error','Ocurrió un error al actualizar proveedor.',ls_mg)
				return false 
			end if
elseif is_aplica = 'CC' then
		ls_referencia = string(ii_cuenta_id) + "-" + string(il_tercero)
		SELECT count(*)
		  INTO :li_cont
		  FROM cctmovim  
		 WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
				 ( cctmovim.movi_empresa = :str.empresa ) AND  
				 ( cctmovim.movi_aplicacion = 'BA' ) AND  
				 ( cctmovim.movi_tipo_transaccion = :ls_tran ) AND  
				 ( cctmovim.movi_sub_transaccion = :ls_stran ) AND  
				 ( cctmovim.movi_documento = :ls_documento ) AND  
				 ( cctmovim.movi_anno = :ii_ann ) AND  
				 ( cctmovim.movi_referencia = :ls_referencia )   ;
				 
		if sqlca.sqlcode = -1 then
			ls_mg = sqlca.sqlerrtext
			rollback;
			sqlca.autocommit = true;								
			messagebox('Error',ls_mg)
			return false
		end if	
		
		IF li_cont = 0 THEN
			INSERT INTO cctmovim (movi_g_financiero,movi_empresa,movi_aplicacion,
				movi_tipo_transaccion,movi_sub_transaccion,movi_documento,movi_anno,
				movi_tercero,movi_ruc_tercero,movi_naturaleza,movi_monto,
				movi_fecha_tran,movi_fecha_reg,movi_usuario,movi_estado,
				movi_cierre_mensual,movi_estado_pase_conta,movi_referencia,movi_tran_contado,
				movi_saldo,movi_comentario,movi_transaccion_origen, movi_a_nombre, movi_historica)
			VALUES (:str.g_financiero,:str.empresa,'BA',:ls_tran,
				:ls_stran,:ls_documento,:ii_ann,:il_tercero,
				:ls_cuenta,:ls_naturaleza,:ld_monto,:ldt_fecha,
				:ldt_fecha_creacion,:str.usuario,'IM','N','S',:ls_referencia,'N',
				:ld_monto,:ls_comentario,'CH', :ls_nombre,'S');
		else 
			update cctmovim
			set 	movi_monto = :ld_monto,
					movi_fecha_tran = :ldt_fecha,
					movi_comentario = :ls_comentario
			where movi_g_financiero = :str.g_financiero and
					movi_empresa		= :str.empresa and
					movi_aplicacion	= 'BA'	and
					movi_tipo_transaccion = :ls_tran and
					movi_sub_transaccion	 = :ls_stran and
					movi_documento			 = :ls_documento and
					movi_referencia		 = :ls_referencia and
					movi_anno				 = :ii_ann ;			
		end if 
		
			if sqlca.sqlcode = -1 then
				ls_mg = sqlca.sqlerrtext
				rollback;
				sqlca.autocommit = true;
				mensaje('Error','Ocurrió un error al actualizar Cliente.',ls_mg)
				return false
			end if
	
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

public function boolean wf_aplica_pagos ();decimal{2} ld_monto, ld_saldo
integer i
boolean lb_no_asignar

ld_monto = dw_1.getitemnumber(1,'btdi_monto')

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

public function boolean wf_guarda_facturas_pagadas ();Integer i, li_ann, li_ann_fac
long ll_cliente
string ls_factura, ls_referencia_fac , ls_tran_fac, ls_stran_fac, ls_app_fac, ls_documento, ls_referencia
decimal{2} ld_monto_aplica, ld_saldo
datetime ldt_fecha_recibo, ldt_fecha_factura

ls_documento  = dw_1.getitemstring(1,'btdi_documento')
ls_referencia = dw_1.getitemstring(1,'btdi_referencia')
li_ann		  = dw_1.getitemnumber(1,'btdi_ann')
ldt_fecha_recibo = dw_1.getitemdatetime(1,'btdi_fecha_tran')
ll_cliente 	  = dw_1.getitemnumber(1,'btdi_tercero')

//si se cambio el cliente, restaura los saldos anteriores y luego inserta los nuevos, 
if il_tercero_anterior <> ll_cliente and il_tercero_anterior <> 0 then
	wf_restaura_saldos()
else
//Elimina los documentos aplicados
 DELETE FROM cpdrefac  
   WHERE ( cpdrefac.refa_g_financiero = :str.g_financiero ) AND  
         ( cpdrefac.refa_empresa = :str.empresa ) AND  
         ( cpdrefac.refa_tipo_transaccion = :is_tran ) AND  
         ( cpdrefac.refa_sub_transaccion = :is_stran ) AND  
         ( cpdrefac.refa_documento = :is_doc_anterior ) AND  
         ( cpdrefac.refa_referencia = :is_ref_anterior ) AND  
         ( cpdrefac.refa_ann = :ii_ann_anterior )  ;
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
	if ld_monto_aplica = 0 then continue
	ld_saldo 		 = dw_5.getitemnumber(i,'movi_saldo')	
	ld_saldo 		 = ld_saldo - ld_monto_aplica
	dw_5.setitem(i,'movi_saldo',ld_saldo)
	
	  INSERT INTO cpdrefac  
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

public function boolean wf_restaura_saldos ();string ls_app_ori, ls_tran_ori, ls_stran_ori, ls_doc_ori, ls_ref_ori
long ll_tercero
integer li_ann_ori
decimal{2} ld_monto

//declaracion del cursor de los saldos
 DECLARE cur_pagados CURSOR FOR  
  SELECT cpdrefac.refa_aplicacion_ori,   
         cpdrefac.refa_tipo_transaccion_ori,   
         cpdrefac.refa_sub_transaccion_ori,   
         cpdrefac.refa_documento_ori,   
         cpdrefac.refa_referencia_ori,   
         cpdrefac.refa_ann_ori,   
         cpdrefac.refa_monto_pagado,   
         cpdrefac.refa_tercero  
    FROM cpdrefac  
   WHERE ( cpdrefac.refa_g_financiero = :str.g_financiero ) AND  
         ( cpdrefac.refa_empresa = :str.empresa ) AND  
         ( cpdrefac.refa_tipo_transaccion = :is_tran ) AND  
         ( cpdrefac.refa_sub_transaccion = :is_stran ) AND  
         ( cpdrefac.refa_documento = :is_doc_anterior ) AND  
         ( cpdrefac.refa_referencia = :is_ref_anterior ) AND  
         ( cpdrefac.refa_ann = :ii_ann_anterior )  ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al declarar cursor '+sqlca.sqlerrtext,1,1,'E')
		rollback;
		return false
	end if
	
	open cur_pagados;
	
	fetch cur_pagados into :ls_app_ori, :ls_tran_ori, :ls_stran_ori, :ls_doc_ori, :ls_ref_ori, :li_ann_ori, :ld_monto, :ll_tercero ;
	
	do while sqlca.sqlcode = 0
		
		UPDATE cptmovim  
		  SET movi_saldo = movi_saldo + :ld_monto ,
		  		movi_monto_aplicado = movi_monto_aplicado - :ld_monto
		WHERE ( cptmovim.movi_g_financiero = :str.g_financiero ) AND  
				( cptmovim.movi_empresa = :str.empresa ) AND  
				( cptmovim.movi_aplicacion = :ls_app_ori ) AND  
				( cptmovim.movi_tipo_transaccion = :ls_tran_ori ) AND  
				( cptmovim.movi_sub_transaccion = :ls_stran_ori ) AND  
				( cptmovim.movi_documento = :ls_doc_ori ) AND  
				( cptmovim.movi_referencia = :ls_ref_ori ) AND  
				( cptmovim.movi_anno = :li_ann_ori )     ;
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
		 DELETE FROM cpdrefac  
			WHERE ( cpdrefac.refa_g_financiero = :str.g_financiero ) AND  
					( cpdrefac.refa_empresa = :str.empresa ) AND  
					( cpdrefac.refa_tipo_transaccion = :is_tran ) AND  
					( cpdrefac.refa_sub_transaccion = :is_stran ) AND  
					( cpdrefac.refa_documento = :is_doc_anterior ) AND  
					( cpdrefac.refa_referencia = :is_ref_anterior ) AND  
					( cpdrefac.refa_ann = :ii_ann_anterior )  ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al eliminar documentos aplicados '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return false
			end if
			
return true
end function

public function boolean wf_registra_asiento ();integer li_existe
string ls_documento, ls_referencia, ls_descrip, ls_nombre, ls_iden, ls_iden_cc_cp, ls_tran, ls_stran, ls_mg, ls_naturaleza, ls_comentario
decimal{2} ld_monto
datetime ldt_fecha, ldt_fecha_creacion

ls_documento = dw_1.getitemstring(1,'btdi_documento')
ls_referencia= dw_1.getitemstring(1,'btdi_referencia')
ls_iden = string(ii_banco)+'-'+string(ii_cuenta_id)
if ii_historico = 1 then	
	return true
end if

//SI ES UNA ANULACION
ls_nombre	 = dw_1.getitemstring(1,'btdi_a_nombre')
if dw_3.getitemnumber(1,'balance') = 0 and dw_3.rowcount() = 1 and pos(ls_nombre, 'ANULA') > 0 then
	return true	
end if

if is_doc_anterior <> ls_documento or is_ref_anterior <> ls_referencia or ii_ann <> ii_ann_anterior or is_aplica <> is_aplica_anterior or il_tercero <> il_tercero_anterior then
	//elimina el asiento en el proveedor o en el cliente
	ls_naturaleza = dw_3.getitemstring(2,'naturaleza')
	ls_iden_cc_cp = string(ii_cuenta_id) + '-' + string(il_tercero_anterior)
	if is_aplica = 'CP' or is_aplica_anterior = 'CP' then
		if ls_naturaleza = 'D' then
			ls_tran = 'PA'		//Pago del proveedor
			ls_stran = 'PA'
		elseif ls_naturaleza = 'C' then
			ls_tran = 'NE'		//Nota de Debito del proveedor
			ls_stran = 'NE'
		end if
		
		delete FROM cptmovim  
		 WHERE ( cptmovim.movi_g_financiero = :str.g_financiero ) AND  
				 ( cptmovim.movi_empresa = :str.empresa ) AND  
				 ( cptmovim.movi_aplicacion = 'BA' ) AND  
				 ( cptmovim.movi_tipo_transaccion = :ls_tran ) AND  
				 ( cptmovim.movi_sub_transaccion = :ls_stran ) AND  
				 ( cptmovim.movi_documento = :is_doc_anterior ) AND  
				 ( cptmovim.movi_anno = :ii_ann_anterior ) AND  
				 ( cptmovim.movi_referencia = :ls_iden_cc_cp )   ;
		
		if sqlca.sqlcode = -1 then
			ls_mg = sqlca.sqlerrtext
			rollback;
			sqlca.autocommit = true;				
			messagebox('Error',ls_mg)
			return false
		end if
	elseif is_aplica = 'CC' or is_aplica_anterior = 'CC' then
		if ls_naturaleza = 'D' then
			ls_tran = 'ND'
			ls_stran = '1'
		elseif ls_naturaleza = 'C' then
			ls_tran = 'NC'
			ls_stran = '0'
		end if
		
		delete
		  FROM cctmovim  
		 WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
				 ( cctmovim.movi_empresa = :str.empresa ) AND  
				 ( cctmovim.movi_aplicacion = 'BA' ) AND  
				 ( cctmovim.movi_tipo_transaccion = :ls_tran ) AND  
				 ( cctmovim.movi_sub_transaccion = :ls_stran ) AND  
				 ( cctmovim.movi_documento = :is_doc_anterior ) AND  
				 ( cctmovim.movi_anno = :ii_ann_anterior ) AND  
				 ( cctmovim.movi_referencia = :ls_iden_cc_cp )   ;
		
		if sqlca.sqlcode = -1 then
			ls_mg = sqlca.sqlerrtext
			rollback;
			sqlca.autocommit = true;				
			messagebox('Error',ls_mg)
			return false
		end if		
	end if
  
  //copia el detalle contable y luego elimina el anterior y luego elimina el encabezado
  dw_4.reset()
  dw_3.RowsCopy(1, dw_3.RowCount(), Primary!, dw_4, 1, Primary!)
  dw_3.reset()
  dw_4.RowsCopy(1, dw_4.RowCount(), Primary!, dw_3, 1, Primary!)
	
  DELETE FROM coddiari  
   WHERE ( coddiari.ddia_g_financiero = :str.g_financiero ) AND  
         ( coddiari.ddia_empresa = :str.empresa ) AND  
         ( coddiari.ddia_aplicacion_mg = 'BA' ) AND  
         ( coddiari.ddia_tipo_transaccion = :is_tran ) AND  
         ( coddiari.ddia_sub_trans = :is_stran ) AND  
         ( coddiari.ddia_no_documento = :is_doc_anterior ) AND  
         ( coddiari.ddia_no_referencia = :is_ref_anterior ) AND  
			( coddiari.ddia_banco_cuenta = :ls_iden ) and
         ( coddiari.ddia_ann = :ii_ann_anterior ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Eliminar Encabezado del Asiento '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return false
		end if


  DELETE FROM cotdiari  
   WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
         ( cotdiari.diar_empresa = :str.empresa ) AND  
         ( cotdiari.diar_aplicacion_mg = 'BA' ) AND  
         ( cotdiari.diar_tipo_transaccion = :is_tran ) AND  
         ( cotdiari.diar_sub_trans = :is_stran ) AND  
         ( cotdiari.diar_no_documento = :is_doc_anterior ) AND  
         ( cotdiari.diar_no_referencia = :is_ref_anterior ) AND  
			( cotdiari.diar_banco_cuenta = :ls_iden ) AND
         ( cotdiari.diar_ann = :ii_ann_anterior ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Eliminar Encabezado del Asiento '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return false
		end if

end if // de la eliminacion, si la llave es diferente

ldt_fecha	 = dw_1.getitemdatetime(1,'btdi_fecha_tran')
ld_monto		 = dw_1.getitemnumber(1,'btdi_monto')
ldt_fecha_creacion = gf_fecha_serv()
ls_descrip	 = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_descripcion')
ls_comentario = dw_1.getitemstring(1,'btdi_comentario2')

  SELECT count(*)  
    INTO :li_existe  
    FROM cotdiari  
   WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
         ( cotdiari.diar_empresa = :str.empresa ) AND  
         ( cotdiari.diar_aplicacion_mg = 'BA' ) AND  
         ( cotdiari.diar_tipo_transaccion = :is_tran ) AND  
         ( cotdiari.diar_sub_trans = :is_stran ) AND  
         ( cotdiari.diar_no_documento = :ls_documento ) AND  
         ( cotdiari.diar_no_referencia = :ls_referencia ) AND  
			( cotdiari.diar_banco_cuenta = :ls_iden ) AND
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
           'BA',   
           :is_tran,   
           :is_stran,   
           :ls_documento,   
           :ls_referencia,   
           :ls_iden,   
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
				gf_mensaje('','Error al Insertar '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				return false
		  end if
		
	else  // si ya existe se hace update
		
		  UPDATE cotdiari  
		  SET diar_fecha_transaccion = :ldt_fecha,   
				diar_descripcion = :ls_descrip,   
				diar_id = :str.usuario,   
				diar_monto = :ld_monto,   
				diar_nombre = :ls_nombre,
				diar_comentario = :ls_comentario
		WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
				( cotdiari.diar_empresa = :str.empresa ) AND  
				( cotdiari.diar_aplicacion_mg = 'BA' ) AND  
				( cotdiari.diar_tipo_transaccion = :is_tran ) AND  
				( cotdiari.diar_sub_trans = :is_stran ) AND  
				( cotdiari.diar_no_documento = :ls_documento ) AND  
				( cotdiari.diar_no_referencia = :ls_referencia ) AND  
				( cotdiari.diar_banco_cuenta  = :ls_iden ) AND
				( cotdiari.diar_ann = :ii_ann ) ;
			  if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
					rollback;
					return false
			  end if
		
	end if
		

return true
end function

public function boolean wf_elimina_proveedor_cliente ();integer li_existe, li_cont
string ls_documento, ls_referencia, ls_descrip, ls_nombre, ls_iden, ls_mg , ls_comentario, ls_comentario_detalle, &
		 ls_naturaleza, ls_tran, ls_stran, ls_cuenta, ls_referencia_banco, ls_aplica
decimal{2} ld_monto
datetime ldt_fecha, ldt_fecha_creacion

ls_documento = dw_1.getitemstring(1,'btdi_documento')
ls_referencia_banco = dw_1.getitemstring(1,'btdi_referencia')
ls_iden = string(ii_banco)+'-'+string(ii_cuenta_id)
ls_cuenta = dw_1.getitemstring(1,'btdi_cuenta')
ls_aplica = dw_1.getitemstring(1,'btdi_aplica_origen', Primary!, true)
if ii_historico = 1 then  // SI ES UNA TRANSACCION HISTORICA
	ls_naturaleza = dw_1.getitemstring(1,'btdi_naturaleza')
	if ls_naturaleza = 'C' then	//Si es Cheque u otra transaccion CR de Bancos
		if ls_aplica = 'CP' then
			ls_tran = 'PA'
			ls_stran = 'PA'
		elseif ls_aplica = 'CC' then
			ls_tran = 'ND'
			ls_stran = '1'					
		else
			return true
		end if
		ls_naturaleza = 'D'		
	else
		if ls_aplica = 'CP' then
			ls_tran = 'NE'
			ls_stran = 'NE'
		elseif ls_aplica = 'CC' then
			ls_tran = 'NC'
			ls_stran = '0'		
		else
			return true
		end if
		ls_naturaleza = 'C'
	end if
else
	ls_naturaleza = dw_3.getitemstring(2,'naturaleza')
	if ls_naturaleza = 'D' then
		ld_monto = dw_3.getitemnumber(2,'monto_debito')
		if ls_aplica = 'CP' then
			ls_tran = 'PA'
			ls_stran = 'PA'
		else
			ls_tran = 'ND'
			ls_stran = '1'		
		end if
	elseif ls_naturaleza = 'C' then
		if ls_aplica = 'CP' then
			ls_tran = 'NE'
			ls_stran = 'NE'
		else
			ls_tran = 'NC'
			ls_stran = '0'		
		end if
	
	end if
end if // del historico = 1

if ls_aplica = 'CP' then //si afecta a un proveedor, es pago por default
		ls_referencia = string(ii_cuenta_id) + '-' + string(il_tercero)

		delete	  FROM cptmovim  
		 WHERE ( cptmovim.movi_g_financiero = :str.g_financiero ) AND  
				 ( cptmovim.movi_empresa = :str.empresa ) AND  
				 ( cptmovim.movi_aplicacion = 'BA' ) AND  
				 ( cptmovim.movi_tipo_transaccion = :ls_tran ) AND  
				 ( cptmovim.movi_sub_transaccion = :ls_stran ) AND  
				 ( cptmovim.movi_documento = :ls_documento ) AND  
				 ( cptmovim.movi_anno = :ii_ann ) AND  
				 ( cptmovim.movi_referencia = :ls_referencia )   ;		
		if sqlca.sqlcode = -1 then
			ls_mg = sqlca.sqlerrtext
			rollback;
			sqlca.autocommit = true;				
			messagebox('Error al Eliminar de CXP ',ls_mg)
			return false
		end if
			
elseif ls_aplica = 'CC' then
		ls_referencia = string(ii_cuenta_id) + "-" + string(il_tercero)
		Delete FROM cctmovim  
		 WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
				 ( cctmovim.movi_empresa = :str.empresa ) AND  
				 ( cctmovim.movi_aplicacion = 'BA' ) AND  
				 ( cctmovim.movi_tipo_transaccion = :ls_tran ) AND  
				 ( cctmovim.movi_sub_transaccion = :ls_stran ) AND  
				 ( cctmovim.movi_documento = :ls_documento ) AND  
				 ( cctmovim.movi_anno = :ii_ann ) AND  
				 ( cctmovim.movi_referencia = :ls_referencia )   ;
				 
		if sqlca.sqlcode = -1 then
			ls_mg = sqlca.sqlerrtext
			rollback;
			sqlca.autocommit = true;								
			messagebox('Error al Eliminar de CXC ',ls_mg)
			return false
		end if	
		
	end if		
	
return true
end function

on w_transacciones_banco.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.dw_2=create dw_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.pb_1=create pb_1
this.st_1=create st_1
this.dw_3=create dw_3
this.dw_4=create dw_4
this.cb_4=create cb_4
this.uo_1=create uo_1
this.cb_5=create cb_5
this.dw_5=create dw_5
this.dw_6=create dw_6
this.uo_2=create uo_2
this.cb_6=create cb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.dw_4
this.Control[iCurrent+9]=this.cb_4
this.Control[iCurrent+10]=this.uo_1
this.Control[iCurrent+11]=this.cb_5
this.Control[iCurrent+12]=this.dw_5
this.Control[iCurrent+13]=this.dw_6
this.Control[iCurrent+14]=this.uo_2
this.Control[iCurrent+15]=this.cb_6
end on

on w_transacciones_banco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.cb_4)
destroy(this.uo_1)
destroy(this.cb_5)
destroy(this.dw_5)
destroy(this.dw_6)
destroy(this.uo_2)
destroy(this.cb_6)
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

  SELECT isnull(dgmempre.empr_imprimir_al_grabar  ,0), isnull(empr_secuencia_global_bancos,0)
    INTO :ii_imprimir_al_grabar  , :ii_secuencia_global
    FROM dgmempre  
   WHERE ( dgmempre.empr_g_financiero = :str.g_financiero ) AND  
         ( dgmempre.empr_empresa = :str.empresa )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error en Empresa '+sqlca.sqlerrtext,1,1,'E')
	end if

dw_1.getchild('cuenta_cli', idwc_clientes)
idwc_clientes.settransobject(sqlca)
if idwc_clientes.retrieve(str.g_financiero, str.empresa) = 0 then
	idwc_clientes.insertrow(1)
end if

	if pos(str.empr_acceso_especial,'HPSA') > 0 and false then
		ii_historico = 1
		dw_3.visible = false
	else
		ii_historico = 0
		dw_3.visible = true
	end if
	
dw_1.getchild('cuenta_pro', idwc_provee)
idwc_provee.settransobject(sqlca)
if idwc_provee.retrieve(str.g_financiero, str.empresa) = 0 then
	idwc_provee.insertrow(1)
end if

dw_1.getchild('btdi_tipo_transaccion', idwc_tran)
idwc_tran.settransobject(sqlca)
idwc_tran.retrieve(str.g_financiero, str.empresa)

dw_1.getchild('btdi_sub_transaccion', idwc_stran)
idwc_stran.settransobject(sqlca)
idwc_stran.retrieve(str.g_financiero, str.empresa)

dw_1.getchild('btdi_banco', idwc_bancos)
idwc_bancos.settransobject(sqlca)
if idwc_bancos.retrieve(str.g_financiero, str.empresa) = 0  then
	gf_mensaje('','Debe crear las Cuentas Bancarias, Verifique !!',1,1,'E')
	this.postevent('close')
end if

dw_1.getchild('btdi_no_cuenta', idwc_cuentas_bancarias)
idwc_cuentas_bancarias.settransobject(sqlca)
if idwc_cuentas_bancarias.retrieve(str.g_financiero, str.empresa) = 0  then
	gf_mensaje('','Debe crear las Cuentas Bancarias, Verifique !!',1,1,'E')
	this.postevent('close')
end if


dw_3.getchild('ddia_mg_cuenta', idwc_plan)
idwc_plan.settransobject(sqlca)
if idwc_plan.retrieve(str.g_financiero, str.empresa) = 0 then
	gf_mensaje('','Crear el Plan de Cuentas, Verifique !!',1,1,'E')
	this.postevent('close')
end if
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
	dw_1.setitem(1,'btdi_tipo_transaccion',is_tran)
//	is_tran_automatica = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_sec_auto')
	if is_tran_automatica = 'S' then
		dw_1.Modify("btdi_documento.Edit.DisplayOnly=Yes")
	else
		dw_1.Modify("btdi_documento.Edit.DisplayOnly=No")
	end if
	dw_1.setitem(1,'btdi_sub_transaccion',is_stran)
	dw_1.setitem(1,'btdi_ann',li_ann)	
	ii_ann = li_ann
	dw_1.setitem(1,'btdi_documento',ls_documento)
	dw_1.setcolumn('btdi_documento')
	dw_1.accepttext()
	dw_1.trigger event itemchanged(1, dw_1.object, ls_documento)	
else
	ii_ann = year(date(gf_fecha_serv()))
	dw_1.setitem(1,'btdi_fecha_tran', date(gf_fecha_serv()))
	dw_1.setitem(1,'btdi_fecha_habilita_deposito', RelativeDate(date(gf_fecha_serv()),3))	
	dw_1.setitem(1,'btdi_ann',year(date(gf_fecha_serv())))	
	dw_1.setitem(1,'btdi_g_financiero',str.g_financiero)
	dw_1.setitem(1,'btdi_empresa',str.empresa)
	dw_1.setitem(1,'btdi_aplicacion','BA')
	dw_1.setitem(1,'btdi_ann', ii_ann)
	dw_1.setitem(1,'btdi_id_usuario_registra', str.usuario)
	if pos(str.empr_acceso_especial,'HPSA') > 0 and false then
		dw_1.setitem(1,'btdi_historico', ii_historico)
	end if
end if


is_arreglo[1] = 'A'; is_arreglo[2] = 'B'; is_arreglo[3] = 'C'; is_arreglo[4] = 'D'; is_arreglo[5] = 'E'
is_arreglo[6] = 'F'; is_arreglo[7] = 'G'; is_arreglo[8] = 'H'; is_arreglo[9] = 'I'; is_arreglo[10] = 'J'
is_arreglo[11] = 'K'; is_arreglo[12] = 'L'; is_arreglo[13] = 'M'; is_arreglo[14] = 'N'; is_arreglo[15] = 'O'
is_arreglo[16] = 'P'; is_arreglo[17] = 'Q'; is_arreglo[18] = 'R'; is_arreglo[19] = 'S'; is_arreglo[20] = 'T'
is_arreglo[21] = 'U'; is_arreglo[22] = 'V'; is_arreglo[23] = 'W'; is_arreglo[24] = 'X'; is_arreglo[25] = 'Y'
is_arreglo[26] = 'Z'

dw_1.Modify("calendario.Filename='"+str.path+"Art\ddfec.bmp'")

dw_1.setitemstatus(1,0,primary!,NotModified!) 
str.frame.setredraw(true)
end event

event ue_aceptar;//override
long ll_update, ll_doc, ll_tercero
integer li_ann, i
window lw_ventana
string ls_titulo, ls_doc, ls_tipo, ls_referencia, ls_aplica, ls_cuenta, ls_ruc, ls_dv, ls_nombre, ls_comentario2
decimal{2} ldec_saldo, ld_monto
datetime ldt_fecha_tran

//lw_ventana = this.getactivesheet()
//ls_titulo = lw_ventana.title

dw_1.accepttext()
dw_3.accepttext()
li_ann = ii_ann
dw_1.setitem(1,'btdi_ann',ii_ann)
ls_doc = dw_1.getitemstring(dw_1.getrow(), 'btdi_documento')
if ls_doc = '' or isnull(ls_doc) then
	gf_mensaje('','Debe digitar el documento antes de guardar, Verifique !!!',1,1,'E')
	 
	dw_1.setcolumn('btdi_documento')
	return
end if

if dw_1.getitemstring(dw_1.getrow(), 'btdi_referencia') = '' or isnull(dw_1.getitemstring(dw_1.getrow(),'btdi_referencia')) then
	gf_mensaje('','Debe digitar la referencia antes de guardar, Verifique !!!',1,1,'E')
	dw_1.setcolumn('btdi_referencia')
	return
end if

if dw_1.getitemNumber(dw_1.getrow(), 'btdi_tercero') = 0 or isnull(dw_1.getitemNumber(dw_1.getrow(),'btdi_tercero')) then
	if dw_1.getitemstring(1,'btdi_aplica_origen') <> 'BA' then
		gf_mensaje('','Debe asignar un Cliente o Proveedor antes de guardar, Verifique !!!',1,1,'E')
		dw_1.setcolumn('btdi_tercero')
		return
	else
		ls_ruc = dw_1.getitemstring(dw_1.getrow(), 'btdi_ruc')
		ls_dv  = dw_1.getitemstring(dw_1.getrow(), 'btdi_digito_verificador')
		ls_nombre = dw_1.getitemstring(dw_1.getrow(), 'btdi_a_nombre')
		if isnull(ls_nombre) then ls_nombre = ''
		if is_tran = 'CH' then
			if trim(ls_nombre) = '' then //
				gf_mensaje('','Debe asignar el Nombre del Beneficiario antes de guardar, Verifique !!!',1,1,'E')
				return				
			else
				//BUSCA POR EL NOMBRE DEL BENEFICIARIO, SI LO ENCUENTRA LE ASIGNA EL NUMERO DEL TERCERO, RUC Y EL DVIRIFICADOR				
				  SELECT isnull(max(dgmterce.terc_tercero),0),   
							isnull(max(dgmterce.terc_identificacion),''),   
							isnull(max(dgmterce.terc_digito_verificador),'')  
					 INTO :ll_tercero,   
							:ls_ruc,   
							:ls_dv  
					 FROM dgmterce  
					WHERE dgmterce.terc_descripcion = :ls_nombre   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al seleccionar tercero '+sqlca.sqlerrtext,1,1,'E')
				end if
				
				if ll_tercero <> 0 then
						dw_1.setitem(1,'btdi_tercero',ll_tercero)
						dw_1.setitem(1,'btdi_ruc',ls_ruc)
						dw_1.setitem(1,'btdi_digito_verificador',ls_dv)
				 //SI NO ENCONTRO EL TERCERO POR EL NOMBRE TAMPOCO Y SI NO ES ANULACION
				elseif dw_1.getitemNumber(dw_1.getrow(), 'btdi_monto') <> 0 and not isnull(dw_1.getitemNumber(dw_1.getrow(),'btdi_monto')) then					
						select max(terc_tercero) into :ll_tercero
						from dgmterce where terc_tercero <> 99999;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al seleccionar tercero',1,1,'E')
						end if
						ll_tercero ++
						
						dw_1.setitem(1,'btdi_tercero',ll_tercero)
						
						//Inserta tercero
						 INSERT INTO dgmterce  
							( terc_tercero,   
							  terc_identificacion,   
							  terc_descripcion,      
							  terc_tipo_persona,   
							  terc_direccion,   
							  terc_pais,   
							  terc_actividad,   
							  terc_clasificacion,   
							  terc_sub_clasificacion,   
							  terc_clave_tercero,   
							  terc_tipo,   
							  terc_tipoa,   
							  terc_tipop,   
							  terc_region,   
							  terc_digito_verificador)  
						VALUES ( :ll_tercero,   
							  :ls_ruc,   
							  :ls_nombre,   
							  'J',   
							  'PANAMA, PANAMA',   
							  1,   
							  null,   
							  null,   
							  null,   
							  null,   
							  0,   
							  0,   
							  1,   
							  1,     
							  :ls_dv)  ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al Crear Tercero '+sqlca.sqlerrtext,1,1,'E')
								return
							end if
					end if //DEL LL_TERCERO <> 0, no lo encontro por el nombre y lo crea
				end if //DEL nombre = ''
		end if	//De tran = 'CHEQUE'
	end if //Si el destino es BANCO
end if //Del tercero = 0

if is_tran = 'RC' then
	ld_monto = dw_1.getitemnumber(1,'total_final')
	dw_1.setitem(1,'btdi_monto',ld_monto)
	dw_1.accepttext()
end if

if dw_1.getitemNumber(dw_1.getrow(), 'btdi_monto') = 0 or isnull(dw_1.getitemNumber(dw_1.getrow(),'btdi_monto')) then
	if pos(ls_nombre,'ANULA') = 0 then
		gf_mensaje('','Debe asignar el valor de la transaccion antes de guardar, Verifique !!!',1,1,'E')
		dw_1.setcolumn('btdi_monto')
		dw_1.setfocus()
		return
	else
		dw_1.setitem(1,'btdi_estado','X') //Anulado
	end if
end if

//valida fecha contable
ldt_fecha_tran = dw_1.getitemdatetime(1,'btdi_fecha_tran')
if not gf_valida_fecha_conta(ldt_fecha_tran) then
	return
end if


//valida que exista la cuenta contable
if ii_historico = 0 then
	
	//valida q este en balance
	if dw_3.getitemnumber(1,'balance') <> 0 then
		gf_mensaje('','Debe Balancear la Transaccion para Guardar, Verifique !!!',1,1,'E')
		return
	end if

	for i = 1 to dw_3.rowcount()
		ls_cuenta = dw_3.getitemstring(i,'ddia_mg_cuenta')
		if ls_cuenta = '' or isnull(ls_cuenta) then
			gf_mensaje('','Asigne la Cuenta Contable para Guardar',1,1,'E')
			dw_3.scrolltorow(i)
			dw_3.setfocus()
			dw_3.setcolumn('cuenta')
			return
		end if
	next
end if

//Asigna el comentario
ls_comentario2 = mid(dw_1.getitemstring(1,'btdi_comentario2'),1,250)
dw_1.setitem(1,'btdi_comentario',ls_comentario2)
sqlca.autocommit = false

ll_update=dw_1.update()

if ll_update = 1  then

	//guarda el asiento contable
	if ii_historico = 0 and not wf_registra_asiento() then
		rollback ;
		sqlca.autocommit = true
		return
	else
		//Guarda las facturas pagadas, si es un Pago al Proveedor
		if dw_5.visible then
			if not wf_guarda_facturas_pagadas() then
				rollback ;
				sqlca.autocommit = true
				return
			end if
		end if
		
		//Preguntar si es Punjabi que entre aqui 
			if not wf_inserta_proveedor_cliente() then
				rollback ;
				sqlca.autocommit = true
				return
			end if
		//////////////////////////////////////////////777	
		
		if ii_historico = 0 then
			//Funcion que inserta en cliente o proveedor, si no es una anulacion
			if dw_3.getitemnumber(1,'balance') = 0 and dw_3.rowcount() > 1  then

				if pos(ls_nombre, 'ANULA') = 0 then
					if not wf_inserta_proveedor_cliente() then
						rollback ;
						sqlca.autocommit = true
						return
					end if
				end if

				for i = 1 to dw_3.rowcount()
					dw_3.setitem(i,'ddia_linea',i)
					
					if dw_3.getitemstring(i,'naturaleza') = 'D' then
						ld_monto = dw_3.getitemnumber(i,'monto_debito')
					elseif dw_3.getitemstring(i,'naturaleza') = 'C' then
						ld_monto = dw_3.getitemnumber(i,'monto_credito')
					else
						ld_monto = 0
					end if
					
					IF ld_monto <> 0.00 and not isnull(ld_monto) THEN
						
						dw_3.setitem(i,'ddia_monto',ld_monto)				
						dw_3.setitem(i,'ddia_no_documento',dw_1.getitemstring(1,'btdi_documento'))
						dw_3.setitem(i,'ddia_no_referencia',dw_1.getitemstring(1,'btdi_referencia'))
						dw_3.setitem(i,'ddia_banco_cuenta',string(ii_banco)+'-'+string(ii_cuenta_id))
						dw_3.setitem(i,'ddia_ann',ii_ann)
						
						ls_tipo = dw_3.getitemstring(i,'tipo')
						choose case ls_tipo
							case 'P'
								
							case 'B'
						//		wf_inserta_barco(i)
							case 'C'
							case 'I'
						end choose
					else
						dw_3.deleterow(i)
						i --
					end if				
				next
			
				if dw_3.update() = -1 then
					gf_mensaje('','Error al guardar detalle contable '+sqlca.sqlerrtext,1,1,'E')
					rollback ;
					sqlca.autocommit = true
					return
				end if
			end if
		end if // del ii_historico = 0
	end if //del registro asiento correctamente
	
	commit using sqlca;
		
	ldec_saldo = gf_saldo_anterior_new( dw_1.getitemnumber(1,'btdi_tercero'), gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)
	dw_1.setitem(1,'saldo',ldec_saldo)				
		//Si la secuencia es automatica, graba en la tabla de transacciones
//		is_tran_automatica = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_sec_auto')
		if is_tran_automatica = 'S' then
			
			ll_doc = long(dw_1.getitemstring(1,'btdi_documento'))
			choose case is_tran
				case 'DE'	//Depositos	
					  UPDATE bamcuent  
						  SET cuen_secuencia_dep = :ll_doc  
						WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
								( bamcuent.cuen_empresa = :str.empresa ) AND  
								( bamcuent.cuen_banco = :ii_banco ) AND  
								( bamcuent.cuen_no_cuenta = :is_cuenta_bancaria )   ;
							
				case 'CH' //Cheques
						UPDATE bamcuent  
						  SET cuen_secuencia = :ll_doc  
						WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
								( bamcuent.cuen_empresa = :str.empresa ) AND  
								( bamcuent.cuen_banco = :ii_banco ) AND  
								( bamcuent.cuen_no_cuenta = :is_cuenta_bancaria )   ;
				CASE	'NR' //Notas de debitos
						UPDATE bamcuent  
						  SET cuen_secuencia_nd = :ll_doc  
						WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
								( bamcuent.cuen_empresa = :str.empresa ) AND  
								( bamcuent.cuen_banco = :ii_banco ) AND  
								( bamcuent.cuen_no_cuenta = :is_cuenta_bancaria )   ;
				CASE	'CB' //Notas de creditos
						UPDATE bamcuent  
						  SET cuen_secuencia_nc = :ll_doc  
						WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
								( bamcuent.cuen_empresa = :str.empresa ) AND  
								( bamcuent.cuen_banco = :ii_banco ) AND  
								( bamcuent.cuen_no_cuenta = :is_cuenta_bancaria )   ;
				CASE	'TC' //transferencia credito
						UPDATE bamcuent  
						  SET cuen_secuencia_trc = :ll_doc  
						WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
								( bamcuent.cuen_empresa = :str.empresa ) AND  
								( bamcuent.cuen_banco = :ii_banco ) AND  
								( bamcuent.cuen_no_cuenta = :is_cuenta_bancaria )   ;
				CASE	'TD' //transferencia debito
						UPDATE bamcuent  
						  SET cuen_secuencia_trd = :ll_doc  
						WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
								( bamcuent.cuen_empresa = :str.empresa ) AND  
								( bamcuent.cuen_banco = :ii_banco ) AND  
								( bamcuent.cuen_no_cuenta = :is_cuenta_bancaria )   ;
																
			end choose
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al guardar secuencia '+sqlca.sqlerrtext,1,1,'E')
			end if
		end if
		sqlca.autocommit = true
		
		if dw_1.getitemstring(1,'btdi_impreso') = 'N' or isnull(dw_1.getitemstring(1,'btdi_impreso')) then
			if is_tran = 'CH' or is_stran = 'NA' then
				this.triggerevent('ue_print')
			else
				if ii_imprimir_al_grabar = 1 then
					this.triggerevent('ue_print')
				end if
			end if
		end if

		commit ;
		this.triggerevent('ue_adicionar')
//	gf_mensaje("Atención","¡Actualización Exitosa !",1,1,'E')
else
	rollback using sqlca;
	gf_mensaje("Atención","¡Error al Actualizar ! " + sqlca.sqlerrtext,1,1,'E')
end if

sqlca.autocommit = true
end event

event ue_adicionar;//override
string ls_tran, ls_subt, ls_naturaleza, ls_doc, ls_cuenta, ls_nulo
datetime ldt_fecha_consultada, ldt_fecha_actual
if dw_1.rowcount() > 0 then
	ldt_fecha_consultada = dw_1.getitemdatetime(1,'btdi_fecha_tran')		
end if

sqlca.autocommit = true
setnull(ls_nulo)

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
dw_1.setitem(1,'btdi_g_financiero',str.g_financiero)
dw_1.setitem(1,'btdi_empresa',str.empresa)
dw_1.setitem(1,'btdi_fecha_tran', ldt_fecha_actual)
ii_ann = year(date(ldt_fecha_actual))
dw_1.setitem(1,'btdi_fecha_habilita_deposito', RelativeDate(date(ldt_fecha_actual),3))	
dw_1.setitem(1,'btdi_aplicacion','BA')
dw_1.setitem(1,'btdi_ann', ii_ann)
dw_1.setitem(1,'btdi_id_usuario_registra', str.usuario)
dw_1.setitem(1,'btdi_tipo_transaccion', is_tran)
dw_1.setitem(1,'btdi_sub_transaccion', is_stran)
if ii_banco = 0 then
	dw_1.setitem(1,'btdi_banco', ls_nulo)
else
	dw_1.setitem(1,'btdi_banco', ii_banco)
end if
dw_1.setitem(1,'btdi_no_cuenta', is_cuenta_bancaria)
ls_naturaleza = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_movimiento')
dw_1.setitem(1,'btdi_naturaleza',ls_naturaleza)
//limpia variables
il_tercero = 0; il_tercero_anterior = 0
is_aplica = 'BA'; is_aplica_anterior = ''
ii_ann_anterior = 0
is_doc_anterior = ''
is_ref_anterior = ''

//facturas aplicadas
dw_5.reset()

if ii_historico = 1 then 
	dw_1.setitem(1,'btdi_historico',ii_historico)
else
	//adiciona en dw contable
	dw_3.reset()
	dw_3.insertrow(1)
	dw_3.setitem(1,'ddia_fecha', date(ldt_fecha_actual))
	dw_3.setitem(1,'ddia_g_financiero',str.g_financiero)
	dw_3.setitem(1,'ddia_empresa',str.empresa)
	dw_3.setitem(1,'ddia_aplicacion_mg','BA')
	dw_3.setitem(1,'ddia_ann', ii_ann)
	dw_3.setitem(1,'ddia_id', str.usuario)
	dw_3.setitem(1,'ddia_tipo_transaccion', is_tran)
	dw_3.setitem(1,'ddia_sub_trans', is_stran)
	dw_3.setitem(1,'naturaleza',ls_naturaleza)	
	dw_3.setitem(1,'ddia_linea',1)
	//asigna cuenta bancaria
	SELECT bamcuent.cuen_mg_cuenta, bamcuent.cuen_id  
	 INTO :ls_cuenta , :ii_cuenta_id 
	 FROM bamcuent  
	WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
			( bamcuent.cuen_empresa = :str.empresa ) AND  
			( bamcuent.cuen_banco = :ii_banco ) AND  
			( bamcuent.cuen_no_cuenta = :is_cuenta_bancaria )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al seleccionar cuenta '+sqlca.sqlerrtext,1,1,'E')
		return
	end if
	dw_3.setitem(1,'ddia_mg_cuenta',ls_cuenta)
	dw_3.setitem(1,'cuenta',ls_cuenta)
	dw_3.setitem(1,'ddia_banco_cuenta',string(ii_banco)+'-'+string(ii_cuenta_id))
	
	//dw_3.setitem(1,'tipo','P')
end if //Del historico = 0, lleva asiento contable

//is_tran_automatica = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_sec_auto')
if is_tran_automatica = 'S' then
	dw_1.Modify("btdi_documento.Edit.DisplayOnly=Yes")			
	ls_doc = wf_secuencia_tran()			
	dw_1.setitem(1,'btdi_documento', ls_doc)
	dw_1.setitem(1,'btdi_referencia', ls_doc)
else
	dw_1.Modify("btdi_documento.Edit.DisplayOnly=No")
	dw_1.setitem(1,'btdi_documento','')
end if		


if is_tran = 'CH' then
	dw_5.dataobject = 'dw_documentos_por_aplicar_cp'
	dw_5.settransobject(sqlca)
end if

dw_1.setcolumn('btdi_documento')
dw_1.setfocus()
dw_1.Modify("btdi_comentario.Edit.DisplayOnly=No")
end event

event resize;//override
dw_1.Resize(This.Width - 270, This.Height - 330)
//dw_3.width = This.Width - 270
//pb_1.y = newheight - 200
//st_1.y = newheight - 180
cb_3.y = newheight - 120

end event

event ue_print;//override
string  ls_dinero, ls_tran, ls_doc, ls_ref, ls_masca, ls_nombre
Integer li_ann

if ii_historico = 1 then
	dw_2.dataobject = 'dw_imprimir_banco_historico'
	if pos(str.empr_acceso_especial,'HPSA') > 0 then
		if is_tran = 'CH' and is_datawindow <> '' then
			dw_2.dataobject =  is_datawindow+'_historico'  //'cheque_aliado_hpsa_historico' 
		end if
	end if
else
	if is_tran = 'CH' and is_datawindow <> '' then
		dw_2.dataobject = is_datawindow
	else	
		if is_tran = 'NB' then
			dw_2.dataobject = 'dw_imprimir_comprobante'
		else
			dw_2.dataobject = 'dw_imprimir_banco'
		end if
	end if
end if

dw_2.settransobject(sqlca)

ls_doc  = dw_1.getitemstring(1,'btdi_documento')
ls_ref  = dw_1.getitemstring(1,'btdi_referencia')
li_ann  = dw_1.getitemnumber(1,'btdi_ann')

if dw_2.retrieve(str.g_financiero, str.empresa, is_tran, is_stran, ii_banco, is_cuenta_bancaria, ls_doc, li_ann) > 0 then
	ls_dinero =  gf_numerlet(dw_1.getitemnumber(1,'btdi_monto'),1)
	if dw_2.describe("numero_letra.x") <> "!" and dw_2.describe("numero_letra.x") <> "?"then				
		dw_2.object.numero_letra.expression = "'"+upper(ls_dinero)+"'"
	end if
	ls_masca = gf_mascara()
   dw_2.MODIFY("ddia_mg_cuenta.editmask.mask='"+ls_masca+"'") //mascara para el compute de la cuenta

	dw_2.Modify("DataWindow.Print.Preview=true")	
	dw_2.Modify("DataWindow.Print.Preview.Rulers=Yes")
else
	ls_nombre = dw_1.getitemstring(dw_1.getrow(), 'btdi_a_nombre')
	if pos(ls_nombre,'ANULA') = 0 then
		gf_mensaje('','Transaccion no Registrada, Verifique!!!',1,1,'E')
		return
	end if
end if
dw_2.visible = true

OpenWithParm(w_dw_print_options, dw_2)
If Message.DoubleParm = -1 Then Return
dw_2.Print(True)
dw_2.visible = false
update batdiari set btdi_impreso = 'S'
where btdi_g_financiero = :str.g_financiero and
		btdi_empresa		= :str.empresa	and
		btdi_aplicacion	= 'BA' and
		btdi_banco			= :ii_banco and
		btdi_no_cuenta = :is_cuenta_bancaria and
		btdi_tipo_transaccion = :is_tran and
		btdi_sub_transaccion	 = :is_stran and
		btdi_documento			 = :ls_doc and
		btdi_referencia		 = :ls_ref and
		btdi_ann				    = :li_ann ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al actualizar el estado de impreso '+sqlca.sqlerrtext,1,1,'E')
			rollback;
		end if
dw_1.setitem(1,'btdi_impreso','S')

commit;
end event

event ue_eliminar;//override
integer li_existe
string ls_documento, ls_referencia, ls_tran, ls_stran, ls_naturaleza, ls_iden_cc_cp, ls_mg , ls_iden
datetime ldt_fecha_tran
this.setredraw(false)
sqlca.autocommit = false
if dw_1.rowcount() > 0 then

	//valida fecha contable
	ldt_fecha_tran = dw_1.getitemdatetime(1,'btdi_fecha_tran')
	if not gf_valida_fecha_conta(ldt_fecha_tran) then
		sqlca.autocommit = true
		this.setredraw(true)
		return
	end if	
	
	if is_tran = 'CH' then
		if dw_1.getitemstring(1,'btdi_impreso') = 'S' then
			gf_mensaje('','El cheque fue impreso, proceda a Anularlo',1,1,'E')
			sqlca.autocommit = true
			this.setredraw(true)
			return
		end if
		if not wf_restaura_saldos() then
			rollback;
			sqlca.autocommit = true
			this.setredraw(true)			
			return				
		end if
	end if
	
	if gf_mensaje('','Esta seguro de eliminar la transaccion ?',2,1,'E') = 2 then 
		this.setredraw(true)
		sqlca.autocommit = true
		return		
	end if
		
		ls_documento = dw_1.getitemstring(1,'btdi_documento')
		ls_referencia = dw_1.getitemstring(1,'btdi_referencia')
		
		select count(*)
		into :li_existe
		from batdiari
		where btdi_g_financiero = :str.g_financiero and
				btdi_empresa		= :str.empresa and
				btdi_tipo_transaccion = :is_tran and
				btdi_sub_transaccion  = :is_stran and
				btdi_banco		= :ii_banco and
				btdi_no_cuenta = :is_cuenta_bancaria and
				btdi_documento	= :ls_documento and
				btdi_referencia = :ls_referencia and
				btdi_ann			 = :ii_ann;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al validar documento '+sqlca.sqlerrtext,1,1,'E')
					sqlca.autocommit = true
					this.setredraw(true)					
					return
				end if
		
		if li_existe = 0 then
			sqlca.autocommit = true
			this.setredraw(true)			
			return
		end if

	if dw_3.rowcount() >= 2 then	
		ls_naturaleza = dw_3.getitemstring(2,'naturaleza')
		ls_iden_cc_cp = string(ii_cuenta_id) + '-' + string(il_tercero_anterior)
		if is_aplica_anterior = 'CP' then
			if ls_naturaleza = 'D' then
				ls_tran = 'PA'
				ls_stran = 'PA'
			elseif ls_naturaleza = 'C' then
				ls_tran = 'NE'
				ls_stran = 'NE'
			end if
			
			delete FROM cptmovim  
			 WHERE ( cptmovim.movi_g_financiero = :str.g_financiero ) AND  
					 ( cptmovim.movi_empresa = :str.empresa ) AND  
					 ( cptmovim.movi_aplicacion = 'BA' ) AND  
					 ( cptmovim.movi_tipo_transaccion = :ls_tran ) AND  
					 ( cptmovim.movi_sub_transaccion = :ls_stran ) AND  
					 ( cptmovim.movi_documento = :is_doc_anterior ) AND  
					 ( cptmovim.movi_anno = :ii_ann_anterior ) AND  
					 ( cptmovim.movi_referencia = :ls_iden_cc_cp )   ;
			
			if sqlca.sqlcode = -1 then
				ls_mg = sqlca.sqlerrtext
				rollback;
			     this.setredraw(true)
			    sqlca.autocommit = true;				
				messagebox('Error',ls_mg)
				return
			end if
		elseif is_aplica_anterior = 'CC' then
			if ls_naturaleza = 'D' then
				ls_tran = 'ND'
				ls_stran = '1'
			elseif ls_naturaleza = 'C' then
				ls_tran = 'NC'
				ls_stran = '0'
			end if
			
			delete
			  FROM cctmovim  
			 WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
					 ( cctmovim.movi_empresa = :str.empresa ) AND  
					 ( cctmovim.movi_aplicacion = 'BA' ) AND  
					 ( cctmovim.movi_tipo_transaccion = :ls_tran ) AND  
					 ( cctmovim.movi_sub_transaccion = :ls_stran ) AND  
					 ( cctmovim.movi_documento = :is_doc_anterior ) AND  
					 ( cctmovim.movi_anno = :ii_ann_anterior ) AND  
					 ( cctmovim.movi_referencia = :ls_iden_cc_cp )   ;
			
			if sqlca.sqlcode = -1 then
				ls_mg = sqlca.sqlerrtext
				rollback;
				sqlca.autocommit = true;				
				this.setredraw(true)
				messagebox('Error',ls_mg)
				return
			end if		
		end if
	end if // del dw_3.rowcount() >= 2  
	
	
	//Elimina del dw
	dw_1.deleterow(dw_1.getrow())
	if dw_1.update() = 1 then

		if is_tran = 'CH' then
			if not wf_restaura_saldos() then
				rollback;
				sqlca.autocommit = true
				this.setredraw(true)
				return				
			end if
		end if

	  ls_iden = string(ii_banco)+'-'+string(ii_cuenta_id)		
		
	  DELETE FROM coddiari  
   	WHERE ( coddiari.ddia_g_financiero = :str.g_financiero ) AND  
      	   ( coddiari.ddia_empresa = :str.empresa ) AND  
         	( coddiari.ddia_aplicacion_mg = 'BA' ) AND  
         	( coddiari.ddia_tipo_transaccion = :is_tran ) AND  
         	( coddiari.ddia_sub_trans = :is_stran ) AND  
         	( coddiari.ddia_no_documento = :is_doc_anterior ) AND  
         	( coddiari.ddia_no_referencia = :is_ref_anterior ) AND  
				( coddiari.ddia_banco_cuenta = :ls_iden ) AND
         	( coddiari.ddia_ann = :ii_ann_anterior ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Eliminar Encabezado del Asiento '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			sqlca.autocommit = true
			this.setredraw(true)			
		end if

	  DELETE FROM cotdiari  
		WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
				( cotdiari.diar_empresa = :str.empresa ) AND  
				( cotdiari.diar_aplicacion_mg = 'BA' ) AND  
				( cotdiari.diar_tipo_transaccion = :is_tran ) AND  
				( cotdiari.diar_sub_trans = :is_stran ) AND  
				( cotdiari.diar_no_documento = :is_doc_anterior ) AND  
				( cotdiari.diar_no_referencia = :is_ref_anterior ) AND  
				( cotdiari.diar_banco_cuenta = :ls_iden ) AND
				( cotdiari.diar_ann = :ii_ann_anterior ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Eliminar Encabezado del Asiento '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			sqlca.autocommit = true
			this.setredraw(true)			
		end if

		  DELETE FROM bampgoter  
		   WHERE ( bampgoter.bamp_g_financiero = :str.g_financiero ) AND  
		         ( bampgoter.bamp_empresa = :str.empresa ) AND  
		         ( bampgoter.bamp_transaccion = :is_tran ) AND  
		         ( bampgoter.bamp_sub_trans = :is_stran ) AND  
		         ( bampgoter.bamp_banco = :ii_banco ) AND  
		         ( bampgoter.bamp_no_cuenta = :is_cuenta_bancaria ) AND  
		         ( bampgoter.bamp_no_documento = :is_doc_anterior ) AND  
		         ( bampgoter.bamp_ano = :ii_ann_anterior ) AND  
		         ( bampgoter.bamp_aplicacion = 'BA' );
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Eliminar Encabezado bampgoter '+sqlca.sqlerrtext,1,1,'E')
					rollback;
					sqlca.autocommit = true
					this.setredraw(true)			
				end if

		commit;	
		this.triggerevent('ue_adicionar')
		
	end if
else 
	messagebox("Atención","No hay registros para borrar!")
end if
this.setredraw(true)
end event

event open;call super::open;sqlca.autocommit = true
this.y = 0
this.x = 0 //805
dw = dw_2
end event

event close;call super::close;Window lw_frame

lw_frame = ParentWindow()

If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_sheet_closed")
 End If
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_transacciones_banco
boolean visible = false
integer width = 73
integer height = 36
string text = ""
end type

type dw_1 from w_fa_padre`dw_1 within w_transacciones_banco
integer x = 78
integer width = 4722
integer height = 1484
string dataobject = "dw_transacciones_banco"
end type

event dw_1::itemchanged;call super::itemchanged;this.accepttext()
string ls_tran, ls_doc, ls_subt, ls_naturaleza, ls_cuenta, ls_nulo, ls_proveedor, ls_referencia, ls_cta, ls_aplicacion, &
		 ls_stran, ls_documento, ls_find
integer li_ann, li_existe, i, li_registro, li_ann_anterior
long    ll_tercero, ll_null
decimal{2} ldec_saldo, ld_tarjeta, ld_porcentaje, ld_monto, ld_saldo, ld_monto_aplicado
datetime ldt_fecha_tran, ldt_fecha_anterior
setnull(ls_nulo)
setnull(ll_null)
choose case this.getcolumnname()
	case 'btdi_historico'
		ii_historico = integer(data)
		if ii_historico = 1 then
			dw_3.visible = false
		else
			//Cuenta # 1, la del banco
			ls_naturaleza = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_movimiento')
			ld_monto		  = dw_1.getitemnumber(1,'btdi_monto')
			//adiciona en dw contable
			dw_3.reset()
			dw_3.insertrow(1)
			dw_3.setitem(1,'ddia_fecha', date(gf_fecha_serv()))
			dw_3.setitem(1,'ddia_g_financiero',str.g_financiero)
			dw_3.setitem(1,'ddia_empresa',str.empresa)
			dw_3.setitem(1,'ddia_aplicacion_mg','BA')
			dw_3.setitem(1,'ddia_ann', ii_ann)
			dw_3.setitem(1,'ddia_id', str.usuario)
			dw_3.setitem(1,'ddia_tipo_transaccion', is_tran)
			dw_3.setitem(1,'ddia_sub_trans', is_stran)
			dw_3.setitem(1,'naturaleza',ls_naturaleza)	
			dw_3.setitem(1,'ddia_linea',1)
			dw_3.setitem(1,'ddia_monto',ld_monto)
			dw_3.setitem(1,'monto_credito',ld_monto)							
			//asigna cuenta bancaria
			SELECT bamcuent.cuen_mg_cuenta, bamcuent.cuen_id  
			 INTO :ls_cuenta , :ii_cuenta_id 
			 FROM bamcuent  
			WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
					( bamcuent.cuen_empresa = :str.empresa ) AND  
					( bamcuent.cuen_banco = :ii_banco ) AND  
					( bamcuent.cuen_no_cuenta = :is_cuenta_bancaria )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al seleccionar cuenta '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
			dw_3.setitem(1,'ddia_mg_cuenta',ls_cuenta)
			dw_3.setitem(1,'cuenta',ls_cuenta)
			dw_3.setitem(1,'ddia_banco_cuenta',string(ii_banco)+'-'+string(ii_cuenta_id))

			//Cuenta numero 2			
			if dw_3.rowcount() = 1 then
				dw_3.scrolltorow(dw_3.insertrow(0))
				dw_3.setitem(dw_3.getrow(),'ddia_fecha', date(gf_fecha_serv()))
				dw_3.setitem(dw_3.getrow(),'ddia_g_financiero',str.g_financiero)
				dw_3.setitem(dw_3.getrow(),'ddia_empresa',str.empresa)
				dw_3.setitem(dw_3.getrow(),'ddia_aplicacion_mg','BA')
				dw_3.setitem(dw_3.getrow(),'ddia_id', str.usuario)
				dw_3.setitem(dw_3.getrow(),'ddia_tipo_transaccion', is_tran)
				dw_3.setitem(dw_3.getrow(),'ddia_sub_trans', is_stran)
				dw_3.setitem(dw_3.getrow(),'naturaleza','D')	
				dw_3.setitem(dw_3.getrow(),'ddia_linea',dw_3.getrow())
				dw_3.setitem(dw_3.getrow(),'ddia_ann',ii_ann)
				dw_3.setitem(dw_3.getrow(),'ddia_no_documento',dw_1.getitemstring(1,'btdi_documento'))
				dw_3.setitem(dw_3.getrow(),'ddia_no_referencia',dw_1.getitemstring(1,'btdi_referencia'))
				dw_3.setitem(dw_3.getrow(),'ddia_monto',ld_monto)
				dw_3.setitem(dw_3.getrow(),'monto_debito',ld_monto)				
			end if				
			
			if this.getitemstring(1,'btdi_aplica_origen') = 'CP' then
				ls_cta = this.getitemstring(1,'cuenta_pro')
		
				  SELECT count(*), max(prov_mg_cuenta), max(prov_cod_proveedor)  
					 INTO :li_existe, :ls_cuenta, :ls_proveedor
					 FROM cpmprove  
					WHERE ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
							( cpmprove.prov_empresa = :str.empresa ) AND  
							( cpmprove.prov_cod_proveedor = :ls_cta ) ;
							
					//asigna el codigo de cuenta, tercero y codigo
					dw_3.setitem(2,'ddia_mg_cuenta',ls_cuenta)
					dw_3.setitem(2,'cuenta',ls_cuenta)
					dw_3.setitem(2,'ddia_tercero',ll_tercero)
					dw_3.setitem(2,'ddia_codigo_cte_prov',ls_proveedor)
			end if
	
			dw_3.visible = true
			
		end if
	case 'btdi_banco'
		ii_banco = this.getitemnumber(this.getrow(),'btdi_banco')
			//asigna cuenta bancaria
		  SELECT count(*)
			 INTO :li_registro
			 FROM bamcuent  
			WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
					( bamcuent.cuen_empresa = :str.empresa ) AND  
					( bamcuent.cuen_banco = :ii_banco ) ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al seleccionar cuenta '+sqlca.sqlerrtext,1,1,'E')
				return 2
			end if
			if li_registro = 1 then
				//is_cuenta_bancaria = idwc_cuentas_bancarias.getitemstring(1,'cuen_no_cuenta')
				  SELECT bamcuent.cuen_no_cuenta
				 INTO :is_cuenta_bancaria
				 FROM bamcuent  
				WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
						( bamcuent.cuen_empresa = :str.empresa ) AND  
						( bamcuent.cuen_banco = :ii_banco ) ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al seleccionar cuenta '+sqlca.sqlerrtext,1,1,'E')
					return 2
				end if
				this.setitem(1,'btdi_no_cuenta',is_cuenta_bancaria)
				this.accepttext()
			//asigna cuenta bancaria
			  SELECT bamcuent.cuen_mg_cuenta , cuen_id, isnull(cuen_datawindow,'') , isnull(case :is_tran when 'CH' then cuen_sec_auto when 'DE' then cuen_sec_auto_dep when 'NB' then cuen_sec_auto_nd when 'CB' then cuen_sec_auto_nc when 'TD' then cuen_sec_auto_trd when 'TC' then cuen_sec_auto_trc end ,'N')
				 INTO :ls_cuenta, :ii_cuenta_id , :is_datawindow , :is_tran_automatica
				 FROM bamcuent  
				WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
						( bamcuent.cuen_empresa = :str.empresa ) AND  
						( bamcuent.cuen_banco = :ii_banco ) AND  
						( bamcuent.cuen_no_cuenta = :is_cuenta_bancaria )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al seleccionar cuenta '+sqlca.sqlerrtext,1,1,'E')
					return 2
				end if
				
			if is_tran_automatica = 'S' then
				dw_1.Modify("btdi_documento.Edit.DisplayOnly=Yes")			
				ls_doc = wf_secuencia_tran()			
				dw_1.setitem(1,'btdi_documento', ls_doc)
			else
				dw_1.Modify("btdi_documento.Edit.DisplayOnly=No")
				dw_1.setitem(1,'btdi_documento','')
			end if		
				
			dw_3.setitem(1,'ddia_mg_cuenta',ls_cuenta)
			dw_3.setitem(1,'cuenta',ls_cuenta)
			dw_1.setcolumn('btdi_documento')			
		else
			this.setitem(this.getrow(),'btdi_no_cuenta',ls_nulo)
			this.setcolumn('btdi_no_cuenta')
		end if
	case 'btdi_no_cuenta'
		is_cuenta_bancaria = this.getitemstring(this.getrow(),'btdi_no_cuenta')
	
		//asigna cuenta bancaria
		  SELECT bamcuent.cuen_mg_cuenta , cuen_id, isnull(cuen_datawindow,'') , isnull(case :is_tran when 'CH' then cuen_sec_auto when 'DE' then cuen_sec_auto_dep when 'NB' then cuen_sec_auto_nd when 'CB' then cuen_sec_auto_nc when 'TD' then cuen_sec_auto_trd when 'TC' then cuen_sec_auto_trc end ,'N')
			 INTO :ls_cuenta, :ii_cuenta_id , :is_datawindow , :is_tran_automatica
			 FROM bamcuent  
			WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
					( bamcuent.cuen_empresa = :str.empresa ) AND  
					( bamcuent.cuen_banco = :ii_banco ) AND  
					( bamcuent.cuen_no_cuenta = :is_cuenta_bancaria )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al seleccionar cuenta '+sqlca.sqlerrtext,1,1,'E')
				return 2
			end if
			
		if is_tran_automatica = 'S' then
			dw_1.Modify("btdi_documento.Edit.DisplayOnly=Yes")			
			ls_doc = wf_secuencia_tran()			
			dw_1.setitem(1,'btdi_documento', ls_doc)
		else
			dw_1.Modify("btdi_documento.Edit.DisplayOnly=No")
			dw_1.setitem(1,'btdi_documento','')
		end if		
			
			dw_3.setitem(1,'ddia_mg_cuenta',ls_cuenta)
			dw_3.setitem(1,'cuenta',ls_cuenta)
		dw_1.setcolumn('btdi_documento')
	case 'btdi_ann'
		ii_ann = this.getitemnumber(1,'btdi_ann')
		if is_tran_automatica = 'S' then
			dw_1.Modify("btdi_documento.Edit.DisplayOnly=Yes")			
			ls_doc = wf_secuencia_tran()			
			dw_1.setitem(1,'btdi_documento', ls_doc)
		else
			dw_1.Modify("btdi_documento.Edit.DisplayOnly=No")
			dw_1.setitem(1,'btdi_documento','')
		end if				
	case 'btdi_fecha_tran'
		ldt_fecha_tran 	 = this.getitemdatetime(this.getrow(),'btdi_fecha_tran')		
		ldt_fecha_anterior = this.getitemdatetime(this.getrow(),'btdi_fecha_tran', Primary!, True)		
		ii_ann = year(date(this.getitemdatetime(this.getrow(),'btdi_fecha_tran')))
		li_ann_anterior = dw_1.getitemnumber(1,'btdi_ann')
	
		dw_1.setitem(1,'btdi_fecha_habilita_deposito', RelativeDate(date(ldt_fecha_tran),3))	
		
		if not gf_valida_fecha_conta(ldt_fecha_anterior) then			
			dw_1.setitem(1,'btdi_fecha_tran', ldt_fecha_anterior)
			dw_1.setcolumn('btdi_fecha_tran')
			return 2
		end if

		if not gf_valida_fecha_conta(ldt_fecha_tran) then			
			dw_1.setitem(1,'btdi_fecha_tran', ldt_fecha_anterior)
			dw_1.setcolumn('btdi_fecha_tran')
			return 2
		end if  
		
		if not gf_valida_fecha_futura(ldt_fecha_tran) then			
			if ldt_fecha_tran = ldt_fecha_anterior then
				dw_1.setitem(1,'btdi_fecha_tran', date(gf_fecha_serv()))				
			else
				dw_1.setitem(1,'btdi_fecha_tran', ldt_fecha_anterior)
			end if
			dw_1.setcolumn('btdi_fecha_tran')
			return 2
		end if
		
		if not gf_valida_fecha_bancos(ldt_fecha_anterior, is_cuenta_bancaria, ii_banco) then			
			dw_1.setitem(1,'btdi_fecha_tran', ldt_fecha_anterior)
			dw_1.setcolumn('btdi_fecha_tran')
			return 2
		end if

		if not gf_valida_fecha_bancos(ldt_fecha_tran, is_cuenta_bancaria, ii_banco) then			
			dw_1.setitem(1,'btdi_fecha_tran', ldt_fecha_anterior)
			dw_1.setcolumn('btdi_fecha_tran')
			return 2
		end if
		
		//Si los anios son diferentes asigna el anio
		if ii_ann <> li_ann_anterior then
			dw_1.setitem(1,'btdi_ann',ii_ann)
		end if
	
	case 'btdi_tipo_transaccion'		
		ls_tran = data
		
		if ls_tran = 'CH' then
			if this.getitemstring(row,'btdi_aplica_origen') = 'CP' then
				dw_5.visible = true
			end if
		else
			dw_5.visible = false
		end if
		dw_5.reset()
		
		is_tran = ls_tran
		idwc_stran.setfilter("dgmsubse_subs_transaccion = '"+ls_tran+"'")
		idwc_stran.filter()		
		parent.triggerevent('ue_adicionar')
		this.setitem(1,'btdi_tipo_transaccion',ls_tran)
		if idwc_stran.rowcount() > 0 then
			is_stran = idwc_stran.getitemstring(idwc_stran.getrow(),'dgmsubse_subs_sub_trans') //  1
			dw_1.setitem(1,'btdi_sub_transaccion',is_stran)
			dw_3.setitem(1,'ddia_sub_trans',is_stran)
		end if	
		
		ls_naturaleza = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_movimiento')
//		is_tran_automatica = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_sec_auto')

		this.setitem(1,'btdi_naturaleza',ls_naturaleza)
	
		this.setcolumn('btdi_banco')		
		
		if ii_banco > 0 and len(is_cuenta_bancaria) > 0 then
		//asigna cuenta bancaria
		  SELECT bamcuent.cuen_mg_cuenta , cuen_id, isnull(cuen_datawindow,'') , isnull(case :is_tran when 'CH' then cuen_sec_auto when 'DE' then cuen_sec_auto_dep when 'NB' then cuen_sec_auto_nd when 'CB' then cuen_sec_auto_nc when 'TD' then cuen_sec_auto_trd when 'TC' then cuen_sec_auto_trc end ,'N')
			 INTO :ls_cuenta, :ii_cuenta_id , :is_datawindow , :is_tran_automatica
			 FROM bamcuent  
			WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
					( bamcuent.cuen_empresa = :str.empresa ) AND  
					( bamcuent.cuen_banco = :ii_banco ) AND  
					( bamcuent.cuen_no_cuenta = :is_cuenta_bancaria )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al seleccionar cuenta '+sqlca.sqlerrtext,1,1,'E')
				return 2
			end if
			
			if is_tran_automatica = 'S' then
				dw_1.Modify("btdi_documento.Edit.DisplayOnly=Yes")			
				ls_doc = wf_secuencia_tran()			
				dw_1.setitem(1,'btdi_documento', ls_doc)
			else
				dw_1.Modify("btdi_documento.Edit.DisplayOnly=No")
				dw_1.setitem(1,'btdi_documento','')
			end if		
				
			dw_3.setitem(1,'ddia_mg_cuenta',ls_cuenta)
			dw_3.setitem(1,'cuenta',ls_cuenta)
			dw_1.setcolumn('btdi_documento')
		end if

	case 'btdi_sub_transaccion'
		is_stran = data
		dw_1.setitem(1,'btdi_sub_transaccion',is_stran)
		if dw_3.rowcount() > 0 then dw_3.setitem(1,'ddia_sub_trans',is_stran)
		this.setcolumn('btdi_banco')		
	case 'cuenta', 'cuenta_cli', 'cuenta_pro'
		choose case this.getitemstring(row,'btdi_aplica_origen')
			case 'CP'
				ls_cta = this.getitemstring(1,'cuenta_pro')
				this.setitem(1,'btdi_cuenta',ls_cta)
				this.setitem(1,'btdi_a_nombre',idwc_provee.getitemstring(idwc_provee.getrow(),'terc_descripcion'))
				ll_tercero = idwc_provee.getitemNumber(idwc_provee.getrow(), 'terc_tercero')
				il_tercero = ll_tercero
				this.setitem(1,'btdi_tercero', ll_tercero )						
				//asigna el ruc y el dv del tercero
				wf_asigna_ruc_dv(ll_tercero)
		
				  SELECT count(*), max(prov_mg_cuenta), max(prov_cod_proveedor)  
					 INTO :li_existe, :ls_cuenta, :ls_proveedor
					 FROM cpmprove  
					WHERE ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
							( cpmprove.prov_empresa = :str.empresa ) AND  
							( cpmprove.prov_cod_proveedor = :ls_cta ) ;
					if li_existe = 0 or isnull(li_existe) then
						gf_mensaje('','Proveedor no existe. Verifique !!!',1,1,'E')
						this.setitem(1,'btdi_cuenta','')
						this.setitem(1,'cuenta_pro','')
						this.setitem(1,'btdi_tercero',0)					
						dw_1.setitem(1,'btdi_a_nombre','')												
						this.setcolumn('cuenta_pro')
						il_tercero = 0
						return 2
					end if				
				if dw_3.rowcount() = 1 then
					dw_3.scrolltorow(dw_3.insertrow(0))
					dw_3.setitem(dw_3.getrow(),'ddia_fecha', date(gf_fecha_serv()))
					dw_3.setitem(dw_3.getrow(),'ddia_g_financiero',str.g_financiero)
					dw_3.setitem(dw_3.getrow(),'ddia_empresa',str.empresa)
					dw_3.setitem(dw_3.getrow(),'ddia_aplicacion_mg','BA')
					dw_3.setitem(dw_3.getrow(),'ddia_id', str.usuario)
					dw_3.setitem(dw_3.getrow(),'ddia_tipo_transaccion', is_tran)
					dw_3.setitem(dw_3.getrow(),'ddia_sub_trans', is_stran)
					dw_3.setitem(dw_3.getrow(),'naturaleza','D')	
					dw_3.setitem(dw_3.getrow(),'ddia_linea',dw_3.getrow())
					dw_3.setitem(dw_3.getrow(),'ddia_ann',ii_ann)
					dw_3.setitem(dw_3.getrow(),'ddia_no_documento',dw_1.getitemstring(1,'btdi_documento'))
					dw_3.setitem(dw_3.getrow(),'ddia_no_referencia',dw_1.getitemstring(1,'btdi_referencia'))
				end if				
				//asigna el codigo de cuenta, tercero y codigo
				dw_3.setitem(2,'ddia_mg_cuenta',ls_cuenta)
				dw_3.setitem(2,'cuenta',ls_cuenta)
				dw_3.setitem(2,'ddia_tercero',ll_tercero)
				dw_3.setitem(2,'ddia_codigo_cte_prov',ls_proveedor)
						
				ldec_saldo = gf_saldo_cxp( ll_tercero, gf_fecha_serv())
				this.setitem(1,'saldo',ldec_saldo)
				
				//Recupera las transacciones pendientes de pago
				if dw_5.visible then
					dw_5.retrieve(str.g_financiero, str.empresa, ll_tercero)
				end if	
				
			case 'CC'
				ls_cta = this.getitemstring(1,'cuenta_cli')
				this.setitem(1,'btdi_cuenta',ls_cta)
				this.setitem(1,'btdi_a_nombre',idwc_clientes.getitemstring(idwc_clientes.getrow(),'terc_descripcion'))
				ll_tercero = idwc_clientes.getitemNumber(idwc_clientes.getrow(), 'terc_tercero')
				il_tercero = ll_tercero
				this.setitem(1,'btdi_tercero', ll_tercero )						
				//asigna el ruc y el dv del tercero
				wf_asigna_ruc_dv(ll_tercero)
		
				  SELECT count(*), max(clie_mg_cuenta)  
					 INTO :li_existe, :ls_cuenta
					 FROM ccmclien  
					WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
							( ccmclien.clie_empresa = :str.empresa ) AND  
							( ccmclien.clie_ref_anterior = :ls_cta ) AND
							( ccmclien.clie_estado = 'A');
					if li_existe = 0 or isnull(li_existe) then
						gf_mensaje('','Cliente no existe. Verifique !!!',1,1,'E')
						this.setitem(1,'cuenta_cli','')
						this.setitem(1,'btdi_cuenta','')
						this.setitem(1,'btdi_tercero',0)
						dw_1.setitem(1,'btdi_a_nombre','')						
						this.setcolumn('cuenta_cli')
						il_tercero = 0
						return 2
					end if				
				if dw_3.rowcount() = 1 then
					dw_3.scrolltorow(dw_3.insertrow(0))
					dw_3.setitem(dw_3.getrow(),'ddia_fecha', date(gf_fecha_serv()))
					dw_3.setitem(dw_3.getrow(),'ddia_g_financiero',str.g_financiero)
					dw_3.setitem(dw_3.getrow(),'ddia_empresa',str.empresa)
					dw_3.setitem(dw_3.getrow(),'ddia_aplicacion_mg','BA')
					dw_3.setitem(dw_3.getrow(),'ddia_id', str.usuario)
					dw_3.setitem(dw_3.getrow(),'ddia_tipo_transaccion', is_tran)
					dw_3.setitem(dw_3.getrow(),'ddia_sub_trans', is_stran)
					dw_3.setitem(dw_3.getrow(),'naturaleza','D')	
					dw_3.setitem(dw_3.getrow(),'ddia_linea',dw_3.getrow())
					dw_3.setitem(dw_3.getrow(),'ddia_ann',ii_ann)
					dw_3.setitem(dw_3.getrow(),'ddia_no_documento',dw_1.getitemstring(1,'btdi_documento'))
					dw_3.setitem(dw_3.getrow(),'ddia_no_referencia',dw_1.getitemstring(1,'btdi_referencia'))
				end if				
				//asigna el codigo de cuenta, tercero y codigo
				dw_3.setitem(2,'ddia_mg_cuenta',ls_cuenta)
				dw_3.setitem(2,'cuenta',ls_cuenta)
				dw_3.setitem(2,'ddia_tercero',ll_tercero)
				dw_3.setitem(2,'ddia_codigo_cte_prov',ls_cta)
						
				ldec_saldo = gf_saldo_anterior_new( ll_tercero, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)
				this.setitem(1,'saldo',ldec_saldo)
			case 'BA'
				ll_tercero  = long(this.getitemstring(1,'cuenta'))
				il_tercero  = ll_tercero
				dw_1.setcolumn('btdi_a_nombre')

				//asigna el ruc y el dv del tercero
				if not wf_asigna_ruc_dv(ll_tercero) then
					dw_1.setitem(1,'btdi_tercero',0)
					dw_1.setitem(1,'btdi_cuenta',ls_nulo)					
					dw_1.setitem(1,'cuenta',ls_nulo)
					dw_1.setitem(1,'btdi_a_nombre','')
					this.accepttext()
					dw_1.setcolumn('cuenta')
					RETURN 2
				else
					dw_1.setitem(1,'btdi_tercero',ll_tercero)
					this.setitem(1,'btdi_cuenta',string(ll_tercero))	
					dw_1.accepttext()					
				end if
				
				if is_tran = 'DE' then				
					if dw_3.rowcount() = 1 then
						dw_3.scrolltorow(dw_3.insertrow(0))
						dw_3.setitem(dw_3.getrow(),'ddia_fecha', date(gf_fecha_serv()))
						dw_3.setitem(dw_3.getrow(),'ddia_g_financiero',str.g_financiero)
						dw_3.setitem(dw_3.getrow(),'ddia_empresa',str.empresa)
						dw_3.setitem(dw_3.getrow(),'ddia_aplicacion_mg','BA')
						dw_3.setitem(dw_3.getrow(),'ddia_id', str.usuario)
						dw_3.setitem(dw_3.getrow(),'ddia_tipo_transaccion', is_tran)
						dw_3.setitem(dw_3.getrow(),'ddia_sub_trans', is_stran)
						dw_3.setitem(dw_3.getrow(),'naturaleza','C')	
						dw_3.setitem(dw_3.getrow(),'ddia_linea',dw_3.getrow())
						dw_3.setitem(dw_3.getrow(),'ddia_ann',ii_ann)
						dw_3.setitem(dw_3.getrow(),'ddia_no_documento',dw_1.getitemstring(1,'btdi_documento'))
						dw_3.setitem(dw_3.getrow(),'ddia_no_referencia',dw_1.getitemstring(1,'btdi_referencia'))
					end if
					
					  SELECT dgmserdr.serd_mgcuenta  
						 INTO :ls_cuenta  
						 FROM dgmserdr  
						WHERE ( dgmserdr.serd_g_financiero = :str.g_financiero ) AND  
								( dgmserdr.serd_empresa = :str.empresa ) AND  
								( dgmserdr.serd_transaccion = :is_tran ) AND  
								( dgmserdr.serd_sub_trans = :is_stran ) AND  
								( dgmserdr.serd_aplicacion = 'BA' ) ;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al buscar cuenta '+sqlca.sqlerrtext,1,1,'E')
							return
						end if
					//asigna el codigo de cuenta, tercero y codigo
					dw_3.setitem(2,'ddia_mg_cuenta',ls_cuenta)
					dw_3.setitem(2,'cuenta',ls_cuenta)
				end if				
		end choose
	case 'btdi_monto'
		ld_monto = double(data) 
		choose case dw_1.getitemstring(1,'btdi_naturaleza')
			case 'D'
				ls_naturaleza = 'C'
			case 'C'
				ls_naturaleza = 'D'
		end choose

		//adiciona la segunda linea del detalle contable
		if dw_3.rowcount() = 1 then
			dw_3.scrolltorow(dw_3.insertrow(0))
			dw_3.setitem(dw_3.getrow(),'ddia_fecha', date(gf_fecha_serv()))
			dw_3.setitem(dw_3.getrow(),'ddia_g_financiero',str.g_financiero)
			dw_3.setitem(dw_3.getrow(),'ddia_empresa',str.empresa)
			dw_3.setitem(dw_3.getrow(),'ddia_aplicacion_mg','BA')
			dw_3.setitem(dw_3.getrow(),'ddia_id', str.usuario)
			dw_3.setitem(dw_3.getrow(),'ddia_tipo_transaccion', is_tran)
			dw_3.setitem(dw_3.getrow(),'ddia_sub_trans', is_stran)
			dw_3.setitem(dw_3.getrow(),'naturaleza',ls_naturaleza)	
			dw_3.setitem(dw_3.getrow(),'ddia_linea',dw_3.getrow())
			dw_3.setitem(dw_3.getrow(),'ddia_ann',ii_ann)
			dw_3.setitem(dw_3.getrow(),'ddia_no_documento',dw_1.getitemstring(1,'btdi_documento'))
			dw_3.setitem(dw_3.getrow(),'ddia_no_referencia',dw_1.getitemstring(1,'btdi_referencia'))
		end if		
		
		choose case dw_1.getitemstring(1,'btdi_naturaleza')
			case 'D'
				dw_3.setitem(1,'monto_debito',ld_monto)		
				dw_3.setitem(2,'monto_credito',ld_monto)		
				dw_3.setitem(2,'naturaleza','C')				
			case 'C'
				dw_3.setitem(1,'monto_credito',ld_monto)		
				dw_3.setitem(2,'monto_debito',ld_monto)		
				dw_3.setitem(2,'naturaleza','D')
		end choose
		
				if is_tran = 'DE' then
					  SELECT dgmserdr.serd_mgcuenta  
						 INTO :ls_cuenta  
						 FROM dgmserdr  
						WHERE ( dgmserdr.serd_g_financiero = :str.g_financiero ) AND  
								( dgmserdr.serd_empresa = :str.empresa ) AND  
								( dgmserdr.serd_transaccion = :is_tran ) AND  
								( dgmserdr.serd_sub_trans = :is_stran ) AND  
								( dgmserdr.serd_aplicacion = 'BA' ) ;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al buscar cuenta '+sqlca.sqlerrtext,1,1,'E')
							return
						end if
					//asigna el codigo de cuenta, tercero y codigo
					dw_3.setitem(2,'ddia_mg_cuenta',ls_cuenta)
					dw_3.setitem(2,'cuenta',ls_cuenta)
				end if		
		//Asigna el pago a los movimientos debitos
		wf_aplica_pagos()
		
		this.setcolumn('btdi_comentario')	
	case 'btdi_documento'
		
		ls_doc = this.getitemstring(1,'btdi_documento')
		li_ann =  this.getitemNumber(1,'btdi_ann')//year(date(gf_fecha_serv()))
		ls_tran = this.getitemstring(1,'btdi_tipo_transaccion')
		ls_subt = this.getitemstring(1,'btdi_sub_transaccion')			
		is_stran = ls_subt
		ls_referencia = this.getitemstring(1,'btdi_referencia')	
		if	this.retrieve(str.g_financiero, str.empresa, ls_tran, ls_doc, li_ann, ii_banco, is_cuenta_bancaria, ls_referencia) = 0 then
			parent.triggerevent('ue_adicionar')
			this.setitem(1,'btdi_documento',ls_doc)
			this.setitem(1,'btdi_tipo_transaccion',ls_tran)
			this.setitem(1,'btdi_sub_transaccion',ls_subt)
			this.setitem(1,'btdi_banco',ii_banco)
			this.setitem(1,'btdi_no_cuenta',is_cuenta_bancaria)
			ls_naturaleza = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_movimiento')
			this.setitem(1,'btdi_naturaleza',ls_naturaleza)		
			this.setitem(1,'btdi_referencia',ls_doc)		
			this.setcolumn('btdi_documento')
			dw_3.setitem(1,'ddia_no_documento', ls_doc)
			dw_3.setitem(1,'ddia_no_referencia', ls_doc)
		else
			ii_ann_anterior = this.getitemnumber(1,'btdi_ann')
			is_doc_anterior = this.getitemstring(1,'btdi_documento')
			is_ref_anterior = this.getitemstring(1,'btdi_referencia')
			ll_tercero = this.getitemnumber(1,'btdi_tercero')
			il_tercero = ll_tercero
			il_tercero_anterior = ll_tercero
			is_aplica = this.getitemstring(1,'btdi_aplica_origen')
			is_aplica_anterior  = is_aplica
			ii_historico = this.getitemnumber(1,'btdi_historico')
			if ii_historico = 1 then
				dw_3.visible = false
			else
				dw_3.visible = true
			end if
			choose case this.getitemstring(1,'btdi_aplica_origen')
				case 'BA'
					this.setitem(1,'cuenta',this.getitemstring(1,'btdi_cuenta'))
				case 'CP'
					this.setitem(1,'cuenta_pro',this.getitemstring(1,'btdi_cuenta'))
					ldec_saldo = gf_saldo_cxp( this.getitemnumber(1,'btdi_tercero'), gf_fecha_serv())
					this.setitem(1,'saldo',ldec_saldo)								
				case 'CC'
					this.setitem(1,'cuenta_cli',this.getitemstring(1,'btdi_cuenta'))
					ldec_saldo = gf_saldo_anterior_new( this.getitemnumber(1,'btdi_tercero'), gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)
					this.setitem(1,'saldo',ldec_saldo)			
					
			end choose
				
			ls_referencia = this.getitemstring(1,'btdi_referencia')
			ii_ann 		  = this.getitemnumber(1,'btdi_ann')
			if dw_3.retrieve(str.g_financiero, str.empresa, 'BA' , ls_tran, ls_doc, ls_referencia, ii_ann, string(ii_banco)+'-'+string(ii_cuenta_id) ) = 0 then
				dw_3.setitem(1,'ddia_no_documento', ls_doc)
				dw_3.setitem(1,'ddia_no_referencia', ls_referencia)
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
			this.setcolumn('btdi_documento')
		
		end if //del retrieve > 0
		
			//PAGOS APLICADOS
			//Si es CHEQUE A PROVEEDORES
			if is_tran = 'CH' and this.getitemstring(1,'btdi_aplica_origen') = 'CP' then
				dw_5.visible = true
				//documentos aplicados
				if	dw_6.retrieve(str.g_financiero, str.empresa, ls_tran, is_stran, ls_doc, ls_referencia, ii_ann, il_tercero) > 0 then
					dw_5.dataobject = 'dw_documentos_por_aplicar_todos_cp' //DW de todos los debitos para modificacion
					dw_5.settransobject(sqlca)
					//documentos Debitos del Cliente
					if	dw_5.retrieve(str.g_financiero, str.empresa, ll_tercero) > 0 then	
						for i = 1 to dw_6.rowcount()
							ld_monto 	  = dw_6.getitemnumber(i,'cpdrefac_refa_monto_pagado')
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
								dw_5.setitem(li_registro,'aplicar',1)	
							end if
						next
						dw_5.setfilter('movi_saldo <> 0')
						dw_5.filter()
						if li_registro > 0 and li_registro <= dw_5.rowcount() then dw_5.scrolltorow(li_registro)
					end if // del dw_5.retrieve(Saldo de Cliente)
				else //Si no tenia documentos aplicados
					dw_5.dataobject = 'dw_documentos_por_aplicar_cp' //DW de solo lo pendiente
					dw_5.settransobject(sqlca)
					//documentos Debitos del Cliente
					dw_5.retrieve(str.g_financiero, str.empresa, ll_tercero)
				end if // del retreive del dw_5, documentos del cliente
			elseif this.getitemstring(1,'btdi_aplica_origen') = 'BA' then
				dw_5.visible = false				
			end if
		
	case	'btdi_referencia'
		dw_3.setitem(1,'ddia_no_referencia', data)
	case  'btdi_aplica_origen'
		this.setitem(1,'cuenta','')
		this.setitem(1,'cuenta_pro','')
		this.setitem(1,'cuenta_cli','')
		this.setitem(1,'btdi_cuenta','')
		this.setitem(1,'btdi_tercero',0)		
		this.setitem(1,'btdi_tercero',ls_nulo)
		this.setitem(1,'btdi_a_nombre','')
		this.setitem(1,'saldo',0)
		dw_5.visible = false	
		choose case this.getitemstring(1,'btdi_aplica_origen')
			case 'BA'
				this.setcolumn('cuenta')
				//asigna el codigo de cuenta, tercero y codigo
				if dw_3.rowcount() > 1 then
					dw_3.setitem(2,'ddia_mg_cuenta','')
					dw_3.setitem(2,'cuenta','')
					dw_3.setitem(2,'ddia_tercero',0)
					dw_3.setitem(2,'ddia_codigo_cte_prov','')						
				end if				
			case 'CP'
				this.setcolumn('cuenta_pro')
				dw_5.visible = true
			case 'CC'
				this.setcolumn('cuenta_cli')
		end choose
		is_aplica = this.getitemstring(1,'btdi_aplica_origen')
		this.accepttext()
end choose
end event

event dw_1::buttonclicked;call super::buttonclicked;	String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error, ls_tran, ls_codigo, ls_dv, ls_ruc, ls_descripcion, ls_codigo2
	integer li_c, li_b
	long    ll_lter, ll_codigo1
	str_transaccion_facturas lstr_facturas
	Datawindow        dww
	str_dg_dynamic_find	lstr_df
	
if dwo.name = 'b_facturas' then

	lstr_facturas.transaccion = is_tran
	lstr_facturas.subtransaccion = is_stran
	lstr_facturas.banco = ii_banco
	lstr_facturas.cuenta = is_cuenta_bancaria
	lstr_facturas.documento = is_doc_anterior
	lstr_facturas.ann = ii_ann_anterior
	lstr_facturas.aplicacion = 'BA'
	lstr_facturas.monto = dw_1.getitemnumber(1,'btdi_monto')
	lstr_facturas.fecha = dw_1.getitemdatetime(1,'btdi_fecha_tran')
	
	openwithparm(w_capturas_facturas_pat, lstr_facturas)

Elseif dwo.name = 'b_buscar' then
		//Busqueda del producto
	//	
	ls_tran = this.getitemstring(1,'btdi_tipo_transaccion')
	
	if ls_tran = '' or isnull(ls_tran) then
		gf_mensaje('','Seleccione una Transaccion para buscar Documentos',1,1,'E')
		return
	end if
	
	
		lstr_df.texto_campo [1,1] = "batdiari.btdi_documento"
		lstr_df.texto_campo [1,2] = "Documento"
		lstr_df.texto_campo [1,3] = "btdi_documento"
		lstr_df.texto_campo [1,4] = 'V'
	//	lstr_df.texto_campo [1,5] = '280'	
		lstr_df.texto_campo [2,1] = "batdiari.btdi_a_nombre_de"
		lstr_df.texto_campo [2,2] = "A Nombre de"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '770'
		lstr_df.texto_campo [3,1] = "batdiari.btdi_fecha_tran"
		lstr_df.texto_campo [3,2] = "Fecha"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [3,5] = '295'
		lstr_df.texto_campo [4,1] = "batdiari.btdi_referencia"
		lstr_df.texto_campo [4,2] = "Referencia"
		lstr_df.texto_campo [4,3] = "btdi_referencia"
		lstr_df.texto_campo [4,4] = 'V'
		lstr_df.texto_campo [4,5] = '285'
		lstr_df.texto_campo [5,1] = "case batdiari.btdi_historico when 1 then 'SI' else 'NO' end btdi_historico "
		lstr_df.texto_campo [5,2] = "Historico ?"
		lstr_df.texto_campo [5,3] = ""
		lstr_df.texto_campo [5,4] = 'V'
//		lstr_df.texto_campo [5,5] = ''
		lstr_df.texto_campo [5,1] = "batdiari.btdi_monto"
		lstr_df.texto_campo [5,2] = "Valor"
		lstr_df.texto_campo [5,3] = ""
		lstr_df.texto_campo [5,4] = 'V'
		
		lstr_df.tabla = " batdiari "
			
		lstr_df.tabla_where = &
					"WHERE (batdiari.btdi_g_financiero = " + string(str.g_financiero) + ") and " +&
							 "(batdiari.btdi_empresa = " + string(str.empresa) + ") and " +&
							 "(batdiari.btdi_tipo_transaccion = '"+ls_tran+"') and " +&
							 "(batdiari.btdi_banco = "+string(ii_banco)+") and " +&
							 "(batdiari.btdi_ann = "+string(ii_ann)+") and " +&
							 "(batdiari.btdi_no_cuenta = '"+is_cuenta_bancaria+"') and " +&
							 "(batdiari.btdi_tipo_transaccion + btdi_sub_transaccion <> 'SISI') "
							 
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	
	If len (ls_find) = 0 Then Return
	ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	ls_codigo2 =  mid(ls_codigo,1,pos(ls_codigo,' And'))
	gf_replace_cadena(ls_codigo2,"'"," ")
	ls_codigo2 = Trim(ls_codigo2)
	this.setitem(1,'btdi_documento',ls_codigo2)

	ls_codigo =  String(Right ( ls_codigo, Len (ls_codigo) - Pos (ls_codigo, "=") ))
	gf_replace_cadena(ls_codigo,"'"," ")
	ls_codigo = Trim(ls_codigo)
	this.setitem(1,'btdi_referencia',ls_codigo)

	this.setcolumn('btdi_documento')
	this.accepttext()
	this.trigger event itemchanged(1, object, ls_codigo)
	
elseif dwo.name = 'b_buscar_cliente' then
	choose case this.getitemstring(row,'btdi_aplica_origen')
		case "BA"
			lstr_df.texto_campo [1,1] = "dgmterce.terc_descripcion"
			lstr_df.texto_campo [1,2] = "Descripción"
			lstr_df.texto_campo [1,3] = ""
			lstr_df.texto_campo [1,4] = 'V'
			lstr_df.texto_campo [1,5] = '700'		
			lstr_df.texto_campo [2,1] = "dgmterce.terc_tercero"
			lstr_df.texto_campo [2,2] = "Secuencial"
			lstr_df.texto_campo [2,3] = "terc_tercero"
			lstr_df.texto_campo [2,4] = 'V'
			lstr_df.texto_campo [3,1] = "dgmterce.terc_identificacion"
			lstr_df.texto_campo [3,2] = "R.U.C"
			lstr_df.texto_campo [3,3] = ""
			lstr_df.texto_campo [3,4] = 'V'
			
			lstr_df.tabla = " dgmterce "
			
			
			lstr_df.tabla_where = " "
			
			OpenWithParm(w_dg_a_custom_find, lstr_df)
			ls_find = Message.StringParm
		
		
			If len (ls_find) = 0 Then Return
				
				
			ll_codigo1 =  long(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))

			dw_1.setitem(1,'btdi_tercero',ll_codigo1)
			dw_1.accepttext()
			dw_1.setcolumn('btdi_a_nombre')
			
			wf_asigna_ruc_dv(ll_codigo1)
			
		case "CP"
			lstr_df.texto_campo [1,1] = "cpmprove.prov_cod_proveedor" //"dgmterce.terc_identificacion"
			lstr_df.texto_campo [1,2] = "Cuenta"
			lstr_df.texto_campo [1,3] = "prov_cod_proveedor"
			lstr_df.texto_campo [1,4] = 'V'
			lstr_df.texto_campo [1,5] = '350'
			lstr_df.texto_campo [2,1] = "dgmterce.terc_descripcion"
			lstr_df.texto_campo [2,2] = "Descripción"
			lstr_df.texto_campo [2,3] = ""
			lstr_df.texto_campo [2,4] = 'V'
			lstr_df.texto_campo [2,5] = '700'		
			lstr_df.texto_campo [3,1] = "dgmterce.terc_tercero"
			lstr_df.texto_campo [3,2] = "Secuencial"
			lstr_df.texto_campo [3,3] = ""
			lstr_df.texto_campo [3,4] = 'V'
			
			lstr_df.tabla = " dgmterce, cpmprove "
			
			
			lstr_df.tabla_where = &
						"WHERE (cpmprove.prov_g_financiero = " + string(str.g_financiero) + " and " +&
								 "cpmprove.prov_empresa = " + string(str.empresa) + ") 	and " +&
								"(dgmterce.terc_tercero = cpmprove.prov_tercero) and " +&
								"(cpmprove.prov_estado = 'A' ) "
			
			OpenWithParm(w_dg_a_custom_find, lstr_df)
			ls_find = Message.StringParm
		
		
		If len (ls_find) = 0 Then Return
			
			
		ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
		gf_replace_cadena(ls_codigo1,"'"," ")
		ls_codigo1 = Trim(ls_codigo1)
	
		dw_1.setitem(1,'cuenta_pro',ls_codigo1)
		dw_1.accepttext()
		dw_1.setcolumn('cuenta_pro')
		dw_1.trigger event itemchanged(1,object,ls_codigo1)
		
	case 'CC'
		lstr_df.texto_campo [1,1] = "ccmclien.clie_ref_anterior" //"dgmterce.terc_identificacion"
			lstr_df.texto_campo [1,2] = "Cuenta"
			lstr_df.texto_campo [1,3] = "clie_ref_anterior"
			lstr_df.texto_campo [1,4] = 'V'
			lstr_df.texto_campo [1,5] = '350'
			lstr_df.texto_campo [2,1] = "dgmterce.terc_descripcion"
			lstr_df.texto_campo [2,2] = "Descripción"
			lstr_df.texto_campo [2,3] = ""
			lstr_df.texto_campo [2,4] = 'V'
			lstr_df.texto_campo [2,5] = '700'		
			lstr_df.texto_campo [3,1] = "dgmterce.terc_tercero"
			lstr_df.texto_campo [3,2] = "Secuencial"
			lstr_df.texto_campo [3,3] = ""
			lstr_df.texto_campo [3,4] = 'V'
			
			lstr_df.tabla = " dgmterce, ccmclien "
			
			
			lstr_df.tabla_where = &
						"WHERE (ccmclien.clie_g_financiero = " + string(str.g_financiero) + " and " +&
								 "ccmclien.clie_empresa = " + string(str.empresa) + ") 	and " +&
								"(dgmterce.terc_tercero = ccmclien.clie_tercero) and " +&
								"(ccmclien.clie_estado = 'A' ) "
			
			OpenWithParm(w_dg_a_custom_find, lstr_df)
			ls_find = Message.StringParm
		
		
			If len (ls_find) = 0 Then Return
				
				
			ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
			gf_replace_cadena(ls_codigo1,"'"," ")
			ls_codigo1 = Trim(ls_codigo1)
		
			
			dw_1.setitem(1,'cuenta_cli',ls_codigo1)
			dw_1.accepttext()
			dw_1.setcolumn('cuenta_cli')
			dw_1.trigger event itemchanged(1,object,ls_codigo1)
			
	end choose
end if
end event

event dw_1::itemfocuschanged;//override
string ls_filtro
integer li_rtn

accepttext()

CHOOSE CASE dwo.name
	CASE "btdi_no_cuenta"
	//Se filtran los grupo por la división seleccionada
	ls_filtro = string(This.GetItemNumber(row,"btdi_banco"))
	idwc_cuentas_bancarias.SetFilter("cuen_banco = " + ls_filtro )	
	li_rtn = idwc_cuentas_bancarias.Filter()
end choose
end event

event dw_1::ue_microayuda;//override
end event

event dw_1::ue_helpcol;call super::ue_helpcol;	String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error, ls_tran, ls_codigo, ls_ruc, ls_dv, ls_descripcion, ls_codigo2
	integer li_c, li_b
	long    ll_lter, ll_codigo1
	Datawindow        dww
	str_dg_dynamic_find	lstr_df

if this.getcolumnname() = 'btdi_documento' then
		//Busqueda del producto
	ls_tran = this.getitemstring(1,'btdi_tipo_transaccion')
	
	if ls_tran = '' or isnull(ls_tran) then
		gf_mensaje('','Seleccione una Transaccion para buscar Documentos',1,1,'E')
		return
	end if
	
	
		lstr_df.texto_campo [1,1] = "batdiari.btdi_documento"
		lstr_df.texto_campo [1,2] = "Documento"
		lstr_df.texto_campo [1,3] = "btdi_documento"
		lstr_df.texto_campo [1,4] = 'V'
	//	lstr_df.texto_campo [1,5] = '280'	
		lstr_df.texto_campo [2,1] = "batdiari.btdi_a_nombre_de"
		lstr_df.texto_campo [2,2] = "A Nombre de"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '770'
		lstr_df.texto_campo [3,1] = "batdiari.btdi_fecha_tran"
		lstr_df.texto_campo [3,2] = "Fecha"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [3,5] = '295'
		lstr_df.texto_campo [4,1] = "batdiari.btdi_referencia"
		lstr_df.texto_campo [4,2] = "Referencia"
		lstr_df.texto_campo [4,3] = "btdi_referencia"
		lstr_df.texto_campo [4,4] = 'V'
		lstr_df.texto_campo [4,5] = '285'
		lstr_df.texto_campo [5,1] = "case batdiari.btdi_historico when 1 then 'SI' else 'NO' end btdi_historico "
		lstr_df.texto_campo [5,2] = "Historico ?"
		lstr_df.texto_campo [5,3] = ""
		lstr_df.texto_campo [5,4] = 'V'
//		lstr_df.texto_campo [5,5] = ''
		lstr_df.texto_campo [5,1] = "batdiari.btdi_monto"
		lstr_df.texto_campo [5,2] = "Valor"
		lstr_df.texto_campo [5,3] = ""
		lstr_df.texto_campo [5,4] = 'V'
		
		lstr_df.tabla = " batdiari "
			
		lstr_df.tabla_where = &
					"WHERE (batdiari.btdi_g_financiero = " + string(str.g_financiero) + ") and " +&
							 "(batdiari.btdi_empresa = " + string(str.empresa) + ") and " +&
							 "(batdiari.btdi_tipo_transaccion = '"+ls_tran+"') and " +&
							 "(batdiari.btdi_banco = "+string(ii_banco)+") and " +&
							 "(batdiari.btdi_ann = "+string(ii_ann)+") and " +&
							 "(batdiari.btdi_no_cuenta = '"+is_cuenta_bancaria+"') and " +&
							 "(batdiari.btdi_tipo_transaccion + btdi_sub_transaccion <> 'SISI') "
							 
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	
	If len (ls_find) = 0 Then Return
	ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	ls_codigo2 =  mid(ls_codigo,1,pos(ls_codigo,' And'))
	gf_replace_cadena(ls_codigo2,"'"," ")
	ls_codigo2 = Trim(ls_codigo2)
	this.setitem(1,'btdi_documento',ls_codigo2)

	ls_codigo =  String(Right ( ls_codigo, Len (ls_codigo) - Pos (ls_codigo, "=") ))
	gf_replace_cadena(ls_codigo,"'"," ")
	ls_codigo = Trim(ls_codigo)
	this.setitem(1,'btdi_referencia',ls_codigo)

	this.setcolumn('btdi_documento')
	this.accepttext()
	this.trigger event itemchanged(1, object, ls_codigo)
	
elseif this.getcolumnname() = 'btdi_cuenta' then
	choose case this.getitemstring(1,'btdi_aplica_origen')
		case 'CP'
			lstr_df.texto_campo [1,1] = "cpmprove.prov_cod_proveedor" //"dgmterce.terc_identificacion"
			lstr_df.texto_campo [1,2] = "Cuenta"
			lstr_df.texto_campo [1,3] = "prov_cod_proveedor"
			lstr_df.texto_campo [1,4] = 'V'
			lstr_df.texto_campo [1,5] = '350'
			lstr_df.texto_campo [2,1] = "dgmterce.terc_descripcion"
			lstr_df.texto_campo [2,2] = "Descripción"
			lstr_df.texto_campo [2,3] = ""
			lstr_df.texto_campo [2,4] = 'V'
			lstr_df.texto_campo [2,5] = '700'		
			lstr_df.texto_campo [3,1] = "dgmterce.terc_tercero"
			lstr_df.texto_campo [3,2] = "Secuencial"
			lstr_df.texto_campo [3,3] = ""
			lstr_df.texto_campo [3,4] = 'V'
			
			lstr_df.tabla = " dgmterce, cpmprove "
			
			
			lstr_df.tabla_where = &
						"WHERE (cpmprove.prov_g_financiero = " + string(str.g_financiero) + " and " +&
								 "cpmprove.prov_empresa = " + string(str.empresa) + ") 	and " +&
								"(dgmterce.terc_tercero = cpmprove.prov_tercero) and " +&
								"(cpmprove.prov_estado = 'A' ) "
			
			OpenWithParm(w_dg_a_custom_find, lstr_df)
			ls_find = Message.StringParm
		
		
			If len (ls_find) = 0 Then Return
				
				
			ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
			gf_replace_cadena(ls_codigo1,"'"," ")
			ls_codigo1 = Trim(ls_codigo1)
			
			
			dw_1.setitem(1,'btdi_cuenta',ls_codigo1)
			dw_1.accepttext()
			dw_1.setcolumn('btdi_cuenta')
			dw_1.trigger event itemchanged(1,object,ls_codigo1)
		
		
		case 'CC'
			lstr_df.texto_campo [1,1] = "ccmclien.clie_ref_anterior" //"dgmterce.terc_identificacion"
			lstr_df.texto_campo [1,2] = "Cuenta"
			lstr_df.texto_campo [1,3] = "clie_ref_anterior"
			lstr_df.texto_campo [1,4] = 'V'
			lstr_df.texto_campo [1,5] = '350'
			lstr_df.texto_campo [2,1] = "dgmterce.terc_descripcion"
			lstr_df.texto_campo [2,2] = "Descripción"
			lstr_df.texto_campo [2,3] = ""
			lstr_df.texto_campo [2,4] = 'V'
			lstr_df.texto_campo [2,5] = '700'		
			lstr_df.texto_campo [3,1] = "dgmterce.terc_tercero"
			lstr_df.texto_campo [3,2] = "Secuencial"
			lstr_df.texto_campo [3,3] = ""
			lstr_df.texto_campo [3,4] = 'V'
			
			lstr_df.tabla = " dgmterce, ccmclien "
			
			
			lstr_df.tabla_where = &
						"WHERE (ccmclien.clie_g_financiero = " + string(str.g_financiero) + " and " +&
								 "ccmclien.clie_empresa = " + string(str.empresa) + ") 	and " +&
								"(dgmterce.terc_tercero = ccmclien.clie_tercero) and " +&
								"(ccmclien.clie_estado = 'A' ) "
			
			OpenWithParm(w_dg_a_custom_find, lstr_df)
			ls_find = Message.StringParm
		
		
			If len (ls_find) = 0 Then Return
				
				
			ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
			gf_replace_cadena(ls_codigo1,"'"," ")
			ls_codigo1 = Trim(ls_codigo1)
		
			
			dw_1.setitem(1,'btdi_cuenta',ls_codigo1)
			dw_1.accepttext()
			dw_1.setcolumn('btdi_cuenta')
			dw_1.trigger event itemchanged(1,object,ls_codigo1)
		
	
		case 'BA'
			lstr_df.texto_campo [1,1] = "dgmterce.terc_descripcion"
			lstr_df.texto_campo [1,2] = "Descripción"
			lstr_df.texto_campo [1,3] = ""
			lstr_df.texto_campo [1,4] = 'V'
			lstr_df.texto_campo [1,5] = '700'		
			lstr_df.texto_campo [2,1] = "dgmterce.terc_tercero"
			lstr_df.texto_campo [2,2] = "Secuencial"
			lstr_df.texto_campo [2,3] = "terc_tercero"
			lstr_df.texto_campo [2,4] = 'V'
			lstr_df.texto_campo [3,1] = "dgmterce.terc_identificacion"
			lstr_df.texto_campo [3,2] = "R.U.C"
			lstr_df.texto_campo [3,3] = ""
			lstr_df.texto_campo [3,4] = 'V'
			
			lstr_df.tabla = " dgmterce "
			
			
			lstr_df.tabla_where = " "
			
			OpenWithParm(w_dg_a_custom_find, lstr_df)
			ls_find = Message.StringParm
		
		
			If len (ls_find) = 0 Then Return
				
				
			ll_codigo1 =  long(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	//		gf_replace_cadena(ls_codigo1,"'"," ")
	//		ls_codigo1 = Trim(ls_codigo1)
		
			dw_1.setitem(1,'btdi_tercero',ll_codigo1)
			dw_1.accepttext()
			dw_1.setcolumn('btdi_a_nombre')

			//asigna el ruc y el dv del tercero
			wf_asigna_ruc_dv(ll_codigo1)
		
	end choose	
		
end if
end event

event dw_1::ue_tabfinal;//override
end event

event dw_1::clicked;call super::clicked;//override
string ls_filtro
integer li_rtn
date 	ld_date,ld_ini_date, ld_hoy
ld_hoy = date(gf_fecha_serv())
accepttext()

CHOOSE CASE dwo.name
	case 'calendario'
		ld_ini_date=date(this.GetItemDateTime(this.getrow(),"btdi_fecha_tran"))
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
	case 'calendario2'
		ld_ini_date=date(this.GetItemDateTime(this.getrow(),"btdi_fecha_habilita_deposito"))
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

	CASE "btdi_no_cuenta"
	//Se filtran los grupo por la división seleccionada
	ls_filtro = string(This.GetItemNumber(row,"btdi_banco"))
	idwc_cuentas_bancarias.SetFilter("cuen_banco = " + ls_filtro )	
	li_rtn = idwc_cuentas_bancarias.Filter()
end choose
end event

type st_ayuda from w_fa_padre`st_ayuda within w_transacciones_banco
end type

type dw_2 from datawindow within w_transacciones_banco
boolean visible = false
integer x = 87
integer y = 12
integer width = 3785
integer height = 2188
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Imprimir Comprobante"
string dataobject = "dw_imprimir_banco"
boolean controlmenu = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "AppIcon!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_transacciones_banco
integer x = 3310
integer y = 600
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
long ll_tercero
date fecha, fecha1
	ll_tercero = dw_1.getitemnumber(1,'btdi_tercero')
	fecha	= relativedate(date(gf_fecha_serv()), - 120)
//	fecha = date('01/01/'+string(year(date(gf_fecha_serv()))))
	fecha1 = date(gf_fecha_serv())
		
	choose case dw_1.getitemstring(1,'btdi_aplica_origen')
		case 'CP'				
			str_rangofecha str_formato1		
			str_formato1.codigo = ll_tercero
			str_formato1.fecha1  = fecha
			str_formato1.fecha2  = fecha1
			Opensheetwithparm(w_estadocuenta_imp_cxp,str_formato1,str.frame,2,layered!)
		case	'CC'
	
				str_cc_formatos str_formato2		
				str_formato2.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
				str_formato2.tercero = dw_1.getitemNumber(1,"btdi_tercero")
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
					WHERE ( dgmterce.terc_tercero = :str_formato2.tercero ) ;
		
				lstr_rangfech.nombre1 = ls_nombre+string(str_formato2.tercero)
				lstr_rangfech.nombre2 = ls_nombre+string(str_formato2.tercero)
				string ls_ruc
				ls_ruc = dw_1.getitemstring(1,'btdi_cuenta')
				lstr_rangfech.desdeclienteref = ls_ruc//str_formato2.tercero
				lstr_rangfech.hastaclienteref = ls_ruc//str_formato2.tercero
									
				if not isnull(lstr_rangfech.fecha1) and not isnull(lstr_rangfech.fecha2) or &
						lstr_rangfech.fecha1 <> date('00/00/0000') and lstr_rangfech.fecha2 <> date('00/00/0000')then
						commit using sqlca;
						wf_actualiza_antiguedad('E')
						OpenSheetWithParm(w_estadocuenta_imp,lstr_rangfech,str.frame,2, layered!)			
				end if	

end choose
end event

type cb_2 from commandbutton within w_transacciones_banco
integer x = 3310
integer y = 720
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

event clicked;str_cc_formatos str_formato1		
choose case dw_1.getitemstring(1,'btdi_aplica_origen')
	case 'CP'		
		str_formato1.tercero = dw_1.getitemnumber(1,'btdi_tercero')
		OpenSheetwithparm(w_mant_proveedores,str_formato1,parent,2, Original!)
	case 'CC'
		str_formato1.tercero = dw_1.getitemnumber(1,'btdi_tercero')
		OpenSheetwithparm(w_mant_clientes,str_formato1,parent,2, Original!)
end choose
end event

type cb_3 from commandbutton within w_transacciones_banco
integer x = 96
integer y = 2200
integer width = 603
integer height = 100
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

event clicked;string ls_documento, ls_comentario, ls_iden, ls_iden_cc_cp, ls_tran, ls_stran, ls_mg, ls_naturaleza, ls_nombre, ls_detalle
decimal {2} ld_monto
datetime ldt_fecha, ldt_fecha_tran
dw_1.accepttext()
dw_3.accepttext()

ls_documento = dw_1.getitemstring(1,'btdi_documento')
ls_nombre	 = dw_1.getitemstring(1,'btdi_a_nombre')
if isnull(ls_nombre) then ls_nombre = ''
if ls_documento = '' or isnull(ls_documento) then return

ldt_fecha_tran 	 = dw_1.getitemdatetime(dw_1.getrow(),'btdi_fecha_tran')		
if not gf_valida_fecha_conta(ldt_fecha_tran) then			
	return
end if


if dw_1.getitemstring(1,'btdi_estado') = 'X' then 
	gf_mensaje('','La transaccion ya fue anulada, verifique !!!',1,1,'E')
	return
end if

if dw_1.getitemstring(1,'btdi_impreso') = 'N' then
	gf_mensaje('','La transaccion no ha sido impresa, puede proceder a eliminarla, verifique !!!',1,1,'E')
	return
end if

if gf_mensaje('','Esta seguro de Anular la Transacción ?',2,1,'Q') = 1 then
	ld_monto = dw_1.getitemnumber(1,'btdi_monto')
	ls_detalle = dw_1.getitemstring(1, 'btdi_comentario')
	if isnull(ls_detalle) then ls_detalle = ''
	ls_comentario = 'ANULADO, VALOR '+string(ld_monto,'$ ###,##0.00')+ ' - ' +ls_detalle
	ls_comentario = mid(ls_comentario,1,250)
	ls_nombre	  = 'ANULADO - '+ls_nombre
	ldt_fecha = gf_fecha_serv()

sqlca.autocommit = false

if ii_historico	= 0 then
	
	ls_naturaleza = dw_3.getitemstring(2,'naturaleza')
	ls_iden_cc_cp = string(ii_cuenta_id) + '-' + string(il_tercero_anterior)
	if is_aplica = 'CP' or is_aplica_anterior = 'CP' then
		if ls_naturaleza = 'D' then
			ls_tran = 'PA'		//Pago del proveedor
			ls_stran = 'PA'
			
		if not wf_restaura_saldos() then
			rollback;
			sqlca.autocommit = true
			gf_mensaje('','Error al Anular Verifique !!',1,1,'E')			
			return				
		end if
			
		elseif ls_naturaleza = 'C' then
			ls_tran = 'NE'		//Nota de Debito del proveedor
			ls_stran = 'NE'
		end if
		
		delete FROM cptmovim  
		 WHERE ( cptmovim.movi_g_financiero = :str.g_financiero ) AND  
				 ( cptmovim.movi_empresa = :str.empresa ) AND  
				 ( cptmovim.movi_aplicacion = 'BA' ) AND  
				 ( cptmovim.movi_tipo_transaccion = :ls_tran ) AND  
				 ( cptmovim.movi_sub_transaccion = :ls_stran ) AND  
				 ( cptmovim.movi_documento = :is_doc_anterior ) AND  
				 ( cptmovim.movi_anno = :ii_ann_anterior ) AND  
				 ( cptmovim.movi_referencia = :ls_iden_cc_cp )   ;
		
		if sqlca.sqlcode = -1 then
			ls_mg = sqlca.sqlerrtext
			rollback;
			sqlca.autocommit = true;				
			messagebox('Error',ls_mg)
			return 
		end if
	elseif is_aplica = 'CC' or is_aplica_anterior = 'CC' then
		if ls_naturaleza = 'D' then
			ls_tran = 'ND'
			ls_stran = '1'
		elseif ls_naturaleza = 'C' then
			ls_tran = 'NC'
			ls_stran = '0'
		end if
		
		delete
		  FROM cctmovim  
		 WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
				 ( cctmovim.movi_empresa = :str.empresa ) AND  
				 ( cctmovim.movi_aplicacion = 'BA' ) AND  
				 ( cctmovim.movi_tipo_transaccion = :ls_tran ) AND  
				 ( cctmovim.movi_sub_transaccion = :ls_stran ) AND  
				 ( cctmovim.movi_documento = :is_doc_anterior ) AND  
				 ( cctmovim.movi_anno = :ii_ann_anterior ) AND  
				 ( cctmovim.movi_referencia = :ls_iden_cc_cp )   ;
		
		if sqlca.sqlcode = -1 then
			ls_mg = sqlca.sqlerrtext
			rollback;
			sqlca.autocommit = true;				
			messagebox('Error',ls_mg)
			return 
		end if		
	end if
	
	ls_iden = string(ii_banco)+'-'+string(ii_cuenta_id)
	
	//Elimina el Asiento Contable
	 DELETE FROM coddiari  
   WHERE ( coddiari.ddia_g_financiero = :str.g_financiero ) AND  
         ( coddiari.ddia_empresa = :str.empresa ) AND  
         ( coddiari.ddia_aplicacion_mg = 'BA' ) AND  
         ( coddiari.ddia_tipo_transaccion = :is_tran ) AND  
         ( coddiari.ddia_sub_trans = :is_stran ) AND  
         ( coddiari.ddia_no_documento = :is_doc_anterior ) AND  
         ( coddiari.ddia_no_referencia = :is_ref_anterior ) AND  
			( coddiari.ddia_banco_cuenta = :ls_iden ) and
         ( coddiari.ddia_ann = :ii_ann_anterior ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Eliminar Encabezado del Asiento '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			sqlca.autocommit = true
			return
		end if
		
  update cotdiari
  	set diar_monto = 0.00,
	     diar_descripcion = :ls_comentario,
		 diar_nombre =  :ls_nombre,
		 diar_estado = 'X'
   WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
         ( cotdiari.diar_empresa = :str.empresa ) AND  
         ( cotdiari.diar_aplicacion_mg = 'BA' ) AND  
         ( cotdiari.diar_tipo_transaccion = :is_tran ) AND  
         ( cotdiari.diar_sub_trans = :is_stran ) AND  
         ( cotdiari.diar_no_documento = :is_doc_anterior ) AND  
         ( cotdiari.diar_no_referencia = :is_ref_anterior ) AND  
			( cotdiari.diar_banco_cuenta = :ls_iden ) AND
         ( cotdiari.diar_ann = :ii_ann_anterior ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Eliminar Encabezado del Asiento '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			sqlca.autocommit = true			
			return
		end if

end if

	//Anula la transaccion de Bancos
	update batdiari
	set   batdiari.btdi_monto = 0,   
         batdiari.btdi_estado = 'X',   
         batdiari.btdi_comentario = :ls_comentario,
			batdiari.btdi_fecha_anula = :ldt_fecha,
			batdiari.btdi_id_usuario_anula = :str.usuario,
			batdiari.btdi_a_nombre_de = :ls_nombre
   WHERE ( batdiari.btdi_g_financiero = :str.g_financiero ) AND  
	         ( batdiari.btdi_empresa = :str.empresa ) AND  
			( batdiari.btdi_banco = :ii_banco ) AND
			( batdiari.btdi_no_cuenta = :is_cuenta_bancaria ) AND
   		    ( batdiari.btdi_aplicacion = 'BA' ) AND  
             ( batdiari.btdi_tipo_transaccion = :is_tran ) AND  
		    ( batdiari.btdi_sub_transaccion = :is_stran ) AND  
			( batdiari.btdi_documento = :is_doc_anterior ) AND  
         	( batdiari.btdi_ann = :ii_ann_anterior ) AND
			( batdiari.btdi_referencia = :is_ref_anterior);
			
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Anular la transaccion '+sqlca.sqlerrtext,1,1,'E')			
			sqlca.autocommit = true
			rollback ;
		end if
		commit ;
		dw_1.setfocus()
		dw_1.setcolumn('btdi_documento')
		dw_1.triggerevent('itemchanged')
end if
end event

type pb_1 from picturebutton within w_transacciones_banco
integer x = 3616
integer y = 1108
integer width = 178
integer height = 152
integer taborder = 31
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "C:\Sistemas\HYMSOFT\Art\NOTE04.BMP"
alignment htextalign = left!
end type

event clicked;long ll_tercero
ll_tercero = dw_1.getitemnumber(1,'btdi_tercero')
str_cc_formatos str_formato2		
str_formato2.tercero = ll_tercero
if ll_tercero > 0 then
	Opensheetwithparm(w_notas,str_formato2,str.frame,2,original!)
end if

end event

type st_1 from statictext within w_transacciones_banco
integer x = 3323
integer y = 1112
integer width = 288
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
string text = "Notas Proveedor"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_transacciones_banco
event ue_helpcol pbm_dwnkey
integer x = 78
integer y = 1504
integer width = 3419
integer height = 684
integer taborder = 41
boolean bringtotop = true
string title = "none"
string dataobject = "dw_detalle_contable"
boolean vscrollbar = true
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
				ls_codigo_cta = wf_buscar_cuenta_contable()				
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
dw_1.accepttext()
THIS.ACCEPTTEXT()

choose case dwo.name
	case	'b_adicionar'
		this.scrolltorow(this.insertrow(0))
		dw_3.setitem(dw_3.getrow(),'ddia_fecha', date(gf_fecha_serv()))
		dw_3.setitem(dw_3.getrow(),'ddia_g_financiero',str.g_financiero)
		dw_3.setitem(dw_3.getrow(),'ddia_empresa',str.empresa)
		dw_3.setitem(dw_3.getrow(),'ddia_aplicacion_mg','BA')
		dw_3.setitem(dw_3.getrow(),'ddia_id', str.usuario)
		dw_3.setitem(dw_3.getrow(),'ddia_tipo_transaccion', is_tran)
		dw_3.setitem(dw_3.getrow(),'ddia_sub_trans', is_stran)
		dw_3.setitem(dw_3.getrow(),'naturaleza','D')	
		dw_3.setitem(dw_3.getrow(),'ddia_linea',dw_3.getrow())
		dw_3.setitem(dw_3.getrow(),'ddia_ann',ii_ann)
		dw_3.setitem(dw_3.getrow(),'ddia_no_documento',dw_1.getitemstring(1,'btdi_documento'))
		dw_3.setitem(dw_3.getrow(),'ddia_no_referencia',dw_1.getitemstring(1,'btdi_referencia'))
		dw_3.setitem(dw_3.getrow(),'ddia_banco_cuenta',string(ii_banco)+'-'+string(ii_cuenta_id))
		this.setcolumn('cuenta')
	case 'b_eliminar'		
			if this.getrow() > 2 then this.deleterow(this.getrow())			
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
decimal{2} ld_balance
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
		ld_balance = abs(this.getitemnumber(1,'balance'))
		if this.getitemstring(this.getrow(),'naturaleza') = 'D' then
			this.setcolumn('monto_debito')
			if this.getitemnumber(this.getrow(),'monto_debito') = 0 then 
				this.setitem(this.getrow(),'monto_debito',ld_balance)
				this.accepttext()
			end if
		else
			this.setcolumn('monto_credito')			
			if this.getitemnumber(this.getrow(),'monto_credito') = 0 then 
				this.setitem(this.getrow(),'monto_credito',ld_balance)			
				this.accepttext()
			end if
		end if
		
	case 'ddia_mg_cuenta'
		ls_cuenta = this.getitemstring(this.getrow(),'ddia_mg_cuenta')
		ls_cuenta = left( ls_cuenta + fill("0",20) ,20)
		this.setitem(this.getrow(),'cuenta',ls_cuenta)	
		if this.getitemstring(this.getrow(),'naturaleza') = 'D' then
			this.setcolumn('monto_debito')
			if this.getitemnumber(this.getrow(),'monto_debito') = 0 then 
				this.setitem(this.getrow(),'monto_debito',ld_balance)
				this.accepttext()
			end if
		else
			this.setcolumn('monto_credito')			
			if this.getitemnumber(this.getrow(),'monto_credito') = 0 then 
				this.setitem(this.getrow(),'monto_credito',ld_balance)			
				this.accepttext()
			end if
		end if
	case	'ddia_transito'
		ls_transito = this.getitemstring(this.getrow(),'ddia_transito')
		this.setitem(row,'ddia_cargado_a','C')
		if len(ls_transito) < 13 then
			ls_transito = wf_transito(ls_transito)	
			this.setitem(row,'ddia_transito',ls_transito)			
			this.setitem(row,'cuenta',is_cta_barco)
			this.setitem(row,'ddia_mg_cuenta',is_cta_barco)			
			accepttext() 
			return 2
		end if
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
		
		  SELECT count(*)  
			 INTO :ll_class  
			 FROM ncargos  
			WHERE ( ncargos.carg_cargo = :ls_class )   AND
					( ncargos.carg_visible <> 1 or ncargos.carg_visible = null )	;
					  
			if sqlca.sqlcode = -1 then
				mensaje('ERROR', 'Error al Consultar registros en CARGOS', sqlca.sqlerrtext )
				this.setitem(this.getrow(), 'ddia_class', '')
//				this.setitem(this.getrow(), 'dpaga_descripcion_cargo', '')
				return 2
			end if
		
			if ll_class = 0 then
				mensaje('Atención', 'Este Código de Cargo no existe... Revise.', '')
				return 2
			end if
		
		  SELECT ncargos.carg_descripcion,
					ncargos.carg_cargado_a
			 INTO :ls_descrip,
					:ls_cargado_a
			 FROM ncargos  
			WHERE ( ncargos.carg_cargo = :ls_class )  AND 
					( ncargos.carg_visible <> 1 or ncargos.carg_visible = null )	;
					
			if sqlca.sqlcode = -1 then
				mensaje("Atención", "Error al Seleccionar Registros en NACARGOS.", "")
				return
			end if
		
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
		ls_codigo_cta = wf_buscar_cuenta_contable()				
		dw_3.trigger event itemchanged(dw_3.getrow(),object,ls_codigo_cta)
	case 'ddia_codigo_cte_prov'
		choose case this.getitemstring(this.getrow(),'tipo')
			case 'P' //Si es proveedor
				ll_tercero = wf_buscar_proveedor()
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

type dw_4 from datawindow within w_transacciones_banco
boolean visible = false
integer x = 3854
integer y = 976
integer width = 827
integer height = 188
integer taborder = 51
boolean bringtotop = true
string title = "none"
string dataobject = "dw_detalle_contable"
boolean border = false
boolean livescroll = true
end type

type cb_4 from commandbutton within w_transacciones_banco
boolean visible = false
integer x = 3410
integer y = 348
integer width = 402
integer height = 104
integer taborder = 11
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;
	dw_1.Modify("btdi_cuenta.dddw.Name=dw_dd_clientes_cta")
	dw_1.Modify("btdi_cuenta.dddw.DataColumn=clie_ref_anterior")
	dw_1.Modify("btdi_cuenta.dddw.DisplayColumn=clie_ref_anterior")
	dw_1.Modify("btdi_cuenta.dddw.Limit=15")
	dw_1.Modify("btdi_cuenta.dddw.PercentWidth=450")
	dw_1.Modify("btdi_cuenta.dddw.allowedit=yes")
	dw_1.Modify("btdi_cuenta.dddw.Case='upper'")
	dw_1.Modify("btdi_cuenta.dddw.autohscroll=yes")
	dw_1.Modify("btdi_cuenta.dddw.useasborder=yes")
	dw_1.Modify("btdi_cuenta.dddw.hscrollbar=no")
	dw_1.Modify("btdi_cuenta.dddw.hsplitscroll=no")
	dw_1.Modify("btdi_cuenta.dddw.imemode=0")
	dw_1.Modify("btdi_cuenta.dddw.nilisnull=no")
	dw_1.Modify("btdi_cuenta.dddw.lines=5")
	dw_1.Modify("btdi_cuenta.dddw.required=no")
	dw_1.Modify("btdi_cuenta.dddw.showlist=no")
	dw_1.Modify("btdi_cuenta.dddw.vscrollbar=yes") 
	dw_1.Modify("btdi_cuenta.dddw.alwaysshowarrow=yes")
	
	dw_1.getchild('btdi_cuenta', idwc_clientes)
idwc_clientes.settransobject(sqlca)
if idwc_clientes.retrieve(str.g_financiero, str.empresa) = 0 then
	idwc_clientes.insertrow(1)
end if


end event

type uo_1 from u_ddcalen within w_transacciones_banco
boolean visible = false
integer x = 1422
integer y = 444
integer taborder = 21
boolean bringtotop = true
end type

on uo_1.destroy
call u_ddcalen::destroy
end on

event ue_clicked;call super::ue_clicked;datetime ldt_fecha_tran, ldt_fecha_anterior
integer li_ann_anterior 
dw_1.SetItem ( dw_1.getrow(), 'btdi_fecha_tran', uo_1.return_sel_date() )

if uo_1.allow_close then
	this.visible=false
	dw_1.SetFocus()
	
		ldt_fecha_tran 	 = dw_1.getitemdatetime(dw_1.getrow(),'btdi_fecha_tran')		
		ldt_fecha_anterior = dw_1.getitemdatetime(dw_1.getrow(),'btdi_fecha_tran', Primary!, True)		

		if not gf_valida_fecha_conta(ldt_fecha_anterior) then			
			dw_1.setitem(1,'btdi_fecha_tran', ldt_fecha_anterior)
			dw_1.setcolumn('btdi_fecha_tran')
			return
		end if

		if not gf_valida_fecha_conta(ldt_fecha_tran) then			
			dw_1.setitem(1,'btdi_fecha_tran', ldt_fecha_anterior)
			dw_1.setcolumn('btdi_fecha_tran')
			return
		end if
		
		if not gf_valida_fecha_futura(ldt_fecha_tran) then			
			if ldt_fecha_tran = ldt_fecha_anterior then
				dw_1.setitem(1,'btdi_fecha_tran', date(gf_fecha_serv()))				
			else
				dw_1.setitem(1,'btdi_fecha_tran', ldt_fecha_anterior)
			end if
			dw_1.setcolumn('btdi_fecha_tran')
			return
		end if
		
		//Valida fecha de conciliacion bancaria
		if not gf_valida_fecha_bancos(ldt_fecha_anterior, is_cuenta_bancaria, ii_banco) then			
			dw_1.setitem(1,'btdi_fecha_tran', ldt_fecha_anterior)
			dw_1.setcolumn('btdi_fecha_tran')
			return
		end if
	
		if not gf_valida_fecha_bancos(ldt_fecha_tran, is_cuenta_bancaria, ii_banco) then			
			dw_1.setitem(1,'btdi_fecha_tran', ldt_fecha_anterior)
			dw_1.setcolumn('btdi_fecha_tran')
			return
		end if

	ii_ann = year(date(dw_1.getitemdatetime(dw_1.getrow(),'btdi_fecha_tran')))
	dw_1.setitem(1,'btdi_fecha_habilita_deposito', RelativeDate(date(dw_1.getitemdatetime(dw_1.getrow(),'btdi_fecha_tran')),3))	
	
		//Si los anios son diferentes asigna el anio
		li_ann_anterior = dw_1.getitemnumber(1,'btdi_ann')		
		if ii_ann <> li_ann_anterior then
			dw_1.setitem(1,'btdi_ann',ii_ann)
		end if
	
end if
end event

event destructor;call super::destructor;call u_ddcalen::destroy
end event

type cb_5 from commandbutton within w_transacciones_banco
integer x = 3305
integer y = 840
integer width = 517
integer height = 104
integer taborder = 31
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Reporte de Trans."
end type

event clicked;str_cc_formatos str_formato1		
str_formato1.tercero = dw_1.getitemnumber(1,'btdi_tercero')
str_formato1.cuenta_banco = is_cuenta_bancaria
str_formato1.banco = ii_banco
OpenSheetwithparm(w_reporte_transacciones_bco,str_formato1,w_fa_fondo ,2, Layered!)

end event

type dw_5 from datawindow within w_transacciones_banco
boolean visible = false
integer x = 133
integer y = 1076
integer width = 2597
integer height = 424
integer taborder = 21
boolean bringtotop = true
string title = "none"
string dataobject = "dw_documentos_por_aplicar_cp"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string ls_objeto
integer li_pos
ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if ls_objeto = "aplicar_t" then
	
//	if row = 0 then return
	
		//Asigna el pago a los movimientos debitos
		wf_aplica_pagos()
	
end if

end event

event itemchanged;decimal{2} ld_total_aplicado, ld_monto_aplica, ld_monto, ld_monto_total, ld_saldo, ld_pendiente, ld_aplicado
integer li_aplicar
boolean lb_no_asignar = false

accepttext()

choose case this.getcolumnname()
	case 'monto_aplica'
		ld_monto 		 = dw_1.getitemnumber(1,'btdi_monto')		//monto del recibo
		ld_monto_total  = this.getitemnumber(1,'total_aplicado') //total aplicado
		ld_pendiente    = ld_monto - ld_monto_total					//es lo pendiente por aplicar
		ld_monto_aplica = this.getitemnumber(row,'monto_aplica') //monto aplicado de la linea
		ld_saldo			 = this.getitemnumber(row,'movi_saldo')	//saldo por aplicar
		ld_aplicado		 = this.getitemnumber(row,'movi_monto_aplicado') //total del monto aplicado de la linea
		
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
	case 'aplicar'
		
		ld_monto = dw_1.getitemnumber(1,'btdi_monto')
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

end choose


end event

type dw_6 from datawindow within w_transacciones_banco
boolean visible = false
integer x = 2885
integer y = 1264
integer width = 1454
integer height = 220
integer taborder = 41
boolean bringtotop = true
string title = "none"
string dataobject = "dw_documentos_aplicados_rep_cp"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_2 from u_ddcalen within w_transacciones_banco
boolean visible = false
integer x = 3099
integer y = 448
integer taborder = 31
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;dw_1.SetItem ( dw_1.getrow(), 'btdi_fecha_habilita_deposito', uo_2.return_sel_date() )

if uo_2.allow_close then
	this.visible=false
	dw_1.SetFocus()
end if
end event

on uo_2.destroy
call u_ddcalen::destroy
end on

type cb_6 from commandbutton within w_transacciones_banco
integer x = 3264
integer y = 960
integer width = 590
integer height = 104
integer taborder = 41
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Reporte de Compras"
end type

event clicked;Opensheet(w_ba_rep_pagos_todos,str.frame,2,layered!)
end event

