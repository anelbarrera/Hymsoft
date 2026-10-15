forward
global type w_transacciones_cxp from w_fa_padre
end type
type dw_2 from datawindow within w_transacciones_cxp
end type
type cb_1 from commandbutton within w_transacciones_cxp
end type
type cb_2 from commandbutton within w_transacciones_cxp
end type
type cb_3 from commandbutton within w_transacciones_cxp
end type
type pb_1 from picturebutton within w_transacciones_cxp
end type
type st_1 from statictext within w_transacciones_cxp
end type
type dw_3 from datawindow within w_transacciones_cxp
end type
type dw_4 from datawindow within w_transacciones_cxp
end type
type dw_5 from datawindow within w_transacciones_cxp
end type
type dw_6 from datawindow within w_transacciones_cxp
end type
type uo_1 from u_ddcalen within w_transacciones_cxp
end type
type uo_2 from u_ddcalen within w_transacciones_cxp
end type
type dw_7 from datawindow within w_transacciones_cxp
end type
end forward

global type w_transacciones_cxp from w_fa_padre
integer width = 4507
integer height = 2552
string title = "Captura de Transacciones de Proveedores"
string menuname = "m_hs"
boolean controlmenu = false
long backcolor = 8421376
dw_2 dw_2
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
pb_1 pb_1
st_1 st_1
dw_3 dw_3
dw_4 dw_4
dw_5 dw_5
dw_6 dw_6
uo_1 uo_1
uo_2 uo_2
dw_7 dw_7
end type
global w_transacciones_cxp w_transacciones_cxp

type variables
datawindowchild idwc_clientes, idwc_tran, idwc_stran, idwc_plan, idwc_barco, idwc_proveedor_multiple
string is_tran, is_stran, is_tran_automatica, is_cta_barco, is_doc_anterior, is_ref_anterior, is_cuenta_itbm
integer ii_ann, ii_ann_anterior, ii_cont_doc, ii_historico, ii_paga_itbms, ii_imprimir_al_grabar
long il_tercero_anterior
string is_arreglo[26]					 

end variables

forward prototypes
public function string wf_secuencia_tran ()
public function string wf_buscar_cuenta_contable ()
public function long wf_buscar_proveedor ()
public function long wf_buscar_cliente ()
public function string wf_transito (string as_transito)
public function string wf_buscar_transito ()
public function string wf_busca_class ()
public function boolean wf_registra_asiento ()
public function boolean wf_restaurar_saldos ()
public function boolean wf_aplica_pagos ()
public function boolean wf_elimina_auxiliares ()
public function boolean wf_guarda_facturas_pagadas ()
public function boolean wf_elimina_detalle ()
public subroutine wf_calcula_itbm (ref decimal ad_monto)
end prototypes

public function string wf_secuencia_tran ();string ls_sec
long ll_max
integer li_existe, li_ann

li_ann = dw_1.getitemnumber(1,'movi_anno')

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
		from cptmovim
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

return ls_sec
end function

public function string wf_buscar_cuenta_contable ();String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error
integer li_c, li_b
long    ll_lter, ll_encontro
		
	str_dg_dynamic_find	lstr_df

	lstr_df.texto_campo [2,1] = "dgmplanc.mg_cuenta" //"dgmterce.terc_identificacion"
	lstr_df.texto_campo [2,2] = "Cuenta"
	lstr_df.texto_campo [2,3] = "mg_cuenta"
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '300'
	lstr_df.texto_campo [1,1] = "dgmplanc.mg_descripcion"
	lstr_df.texto_campo [1,2] = "Descripción"
	lstr_df.texto_campo [1,3] = ""
	lstr_df.texto_campo [1,4] = 'V'
	lstr_df.texto_campo [1,5] = '1000'		
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

lstr_df.texto_campo [3,1] = "ntransito.tran_visita"
lstr_df.texto_campo [3,2] = "Viaje"
lstr_df.texto_campo [3,3] = ""
lstr_df.texto_campo [3,4] = 'V'
lstr_df.texto_campo [3,5] = '250'

lstr_df.texto_campo [4,1] = "convert(char, ntransito.tran_fecha_llegada) tran_fecha_llegada"
lstr_df.texto_campo [4,2] = "Llegada"
lstr_df.texto_campo [4,3] = ""
lstr_df.texto_campo [4,4] = 'V'
lstr_df.texto_campo [4,5] = '345'

lstr_df.texto_campo [5,1] = "nmpuerto.mpuert_nombre"
lstr_df.texto_campo [5,2] = "Visita"
lstr_df.texto_campo [5,3] = ""
lstr_df.texto_campo [5,4] = 'V'

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

public function boolean wf_registra_asiento ();integer li_existe
string ls_documento, ls_referencia, ls_descrip, ls_nombre, ls_comentario
decimal{2} ld_monto
datetime ldt_fecha, ldt_fecha_creacion

ls_documento = dw_1.getitemstring(1,'movi_documento')
ls_referencia= dw_1.getitemstring(1,'movi_referencia')
ls_comentario = dw_1.getitemstring(1,'movi_comentario')

if ii_historico = 1 then	
	return true
end if

if (is_doc_anterior <> ls_documento and len(is_doc_anterior) > 0 ) or ( is_ref_anterior <> ls_referencia and len(is_ref_anterior) > 0 ) or ( ii_ann <> ii_ann_anterior and ii_ann_anterior > 0 ) then
  
  dw_4.reset()
  dw_3.RowsCopy(1, dw_3.RowCount(), Primary!, dw_4, 1, Primary!)
  dw_3.reset()
  dw_4.RowsCopy(1, dw_4.RowCount(), Primary!, dw_3, 1, Primary!)
	
  DELETE FROM coddiari  
   WHERE ( coddiari.ddia_g_financiero = :str.g_financiero ) AND  
         ( coddiari.ddia_empresa = :str.empresa ) AND  
         ( coddiari.ddia_aplicacion_mg = 'CP' ) AND  
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
         ( cotdiari.diar_aplicacion_mg = 'CP' ) AND  
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
ld_monto		 = dw_1.getitemnumber(1,'movi_monto_final')
ldt_fecha_creacion = gf_fecha_serv()
ls_descrip	 = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_descripcion')
ls_nombre	 = dw_1.getitemstring(1,'movi_a_nombre')

  SELECT count(1)  
    INTO :li_existe  
    FROM cotdiari  
   WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
         ( cotdiari.diar_empresa = :str.empresa ) AND  
         ( cotdiari.diar_aplicacion_mg = 'CP' ) AND  
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
           'CP',   
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
				( cotdiari.diar_aplicacion_mg = 'CP' ) AND  
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

public function boolean wf_restaurar_saldos ();string ls_app_ori, ls_tran_ori, ls_stran_ori, ls_doc_ori, ls_ref_ori
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
		  SET movi_saldo = movi_saldo + :ld_monto  ,
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

public function boolean wf_aplica_pagos ();decimal{2} ld_monto, ld_saldo
integer i
boolean lb_no_asignar

ld_monto = dw_1.getitemnumber(1,'movi_monto')

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

public function boolean wf_elimina_auxiliares ();string ls_documento, ls_referencia, ls_tipo, ls_transito, ls_err
integer i, li_ann

for i = 1 to dw_3.deletedcount()
	ls_tipo = dw_3.getitemstring(i,'tipo', delete!, true)
	choose case ls_tipo
		case 'B'
			ls_transito = dw_3.getitemstring(i,'ddia_transito',delete!, true)
			ls_documento= dw_3.getitemstring(i,'ddia_no_documento',delete!, true)
			ls_referencia= dw_3.getitemstring(i,'ddia_no_referencia',delete!, true)
			li_ann		 = dw_3.getitemNumber(i,'ddia_ann',delete!, true)
	
			DELETE FROM banadpagar  
			WHERE ( banadpagar.dpaga_g_financiero = :str.g_financiero ) AND  
					( banadpagar.dpaga_empresa = :str.empresa ) AND  
					( banadpagar.dpaga_transito = :ls_transito ) AND  
					( banadpagar.dpaga_documento_original = :ls_documento ) AND  
					( banadpagar.dpaga_agno = :li_ann ) AND  
					( banadpagar.dpaga_aplicacion = 'CP' ) AND  
					( banadpagar.dpaga_transaccion = :is_tran ) AND  
					( banadpagar.dpaga_subtransaccion = :is_stran )	;
					 
			if sqlca.sqlcode = -1 then
				ls_err = sqlca.sqlerrtext
				Rollback;
				sqlca.autocommit = true
				Messagebox('Error al Eliminar Transaccion de Barcos',ls_err)
				Return false
			end if
	
	
			DELETE FROM banatpagar  
			WHERE ( banatpagar.tpaga_g_financiero = :str.g_financiero ) AND  
					( banatpagar.tpaga_empresa = :str.empresa ) AND  
					( banatpagar.tpaga_transito = :ls_transito ) AND  
					( banatpagar.tpaga_documento_original = :ls_documento ) AND  
					( banatpagar.tpaga_agno = :li_ann ) AND  
					( banatpagar.tpaga_aplicacion = 'CP' ) AND  
					( banatpagar.tpaga_transaccion = :is_tran ) AND  
					( banatpagar.tpaga_subtransaccion = :is_stran )	;
					 
			if sqlca.sqlcode = -1 then
				ls_err = sqlca.sqlerrtext
				Rollback;
				sqlca.autocommit = true
				Messagebox('Error al Eliminar Transaccion de Barcos',ls_err)
				Return false
			end if
				
	end choose
next


ls_documento = dw_1.getitemstring(1,'movi_documento')
ls_referencia= dw_1.getitemstring(1,'movi_referencia')

if is_doc_anterior <> ls_documento or is_ref_anterior <> ls_referencia or ii_ann <> ii_ann_anterior then
  
  DELETE FROM coddiari  
   WHERE ( coddiari.ddia_g_financiero = :str.g_financiero ) AND  
         ( coddiari.ddia_empresa = :str.empresa ) AND  
         ( coddiari.ddia_aplicacion_mg = 'CP' ) AND  
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

end if

return true
end function

public function boolean wf_guarda_facturas_pagadas ();Integer i, li_ann, li_ann_fac
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
if il_tercero_anterior <> ll_cliente and il_tercero_anterior <> 0 then
	wf_restaurar_saldos()
//elseif il_tercero_anterior <> 0 then
	//Aumentar el saldo por el valor original y rebajar el valor aplicado por el valor original cuando se modifica
	
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
	
	ld_monto_aplicado = dw_5.getitemnumber(i,'movi_monto_aplicado')
	dw_5.setitem(i,'movi_monto_aplicado', ld_monto_aplicado + ld_monto_aplica)

	if ld_monto_aplica = 0 then continue
	ld_saldo 		 = dw_5.getitemnumber(i,'movi_saldo')	
	ld_saldo 		 = ld_saldo - ld_monto_aplica
	if ld_saldo < 0 then ld_saldo = 0
	dw_5.setitem(i,'movi_saldo',ld_saldo)
//	dw_5.setitem(i,'movi_monto_aplicado',ld_)
	
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

public function boolean wf_elimina_detalle ();integer li_existe, i
string ls_documento, ls_referencia, ls_descrip, ls_nombre, ls_transito, ls_aplicacion = 'CP', ls_tipo
decimal{2} ld_monto
datetime ldt_fecha, ldt_fecha_creacion

if dw_7.retrieve(str.g_financiero, str.empresa, 'CP' , is_tran, is_doc_anterior, is_ref_anterior, ii_ann_anterior , '1') > 0 then

	for i = 1 to dw_7.rowcount()

	  ls_tipo = dw_7.getitemstring(i,'tipo')

	  if ls_tipo = 'B' then

			ls_transito = dw_7.getitemstring(i,'ddia_transito')

			DELETE FROM banadpagar  
			WHERE ( banadpagar.dpaga_g_financiero = :str.g_financiero ) AND  
					( banadpagar.dpaga_empresa = :str.empresa ) AND  
					( banadpagar.dpaga_transito = :ls_transito ) AND 
					(( banadpagar.dpaga_documento = :is_doc_anterior ) or
					( banadpagar.dpaga_documento like :is_doc_anterior + '-%') ) AND  
					( banadpagar.dpaga_agno = :ii_ann_anterior ) AND  
					( banadpagar.dpaga_aplicacion = :ls_aplicacion ) AND  
					( banadpagar.dpaga_transaccion = :is_tran ) AND  
					( banadpagar.dpaga_subtransaccion = :is_stran )	;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Eliminar Detalle del Barco '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				return false
			end if
					
			DELETE FROM banatpagar  
			WHERE ( banatpagar.tpaga_g_financiero = :str.g_financiero ) AND  
					( banatpagar.tpaga_empresa = :str.empresa ) AND  
					( banatpagar.tpaga_transito = :ls_transito ) AND  
					(( banatpagar.tpaga_documento = :is_doc_anterior ) or  
					( banatpagar.tpaga_documento like :is_doc_anterior + '-%')) AND  
					( banatpagar.tpaga_agno = :ii_ann_anterior ) AND  
					( banatpagar.tpaga_aplicacion = :ls_aplicacion ) AND  
					( banatpagar.tpaga_transaccion = :is_tran ) AND  
					( banatpagar.tpaga_subtransaccion = :is_stran )	;
	
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Eliminar Encabezado del Barco '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				return false
			end if
		end if //del tipo = 'B' Barco
	next

end if

return true
end function

public subroutine wf_calcula_itbm (ref decimal ad_monto);decimal{2} ld_valor = 0//, ld_monto
if isnull(ii_paga_itbms) then ii_paga_itbms = 0
//ld_monto = dw_1.getitemnumber(1,'movi_monto')
if ii_paga_itbms = 0 then
	if dw_1.rowcount() > 0 then
		dw_1.setitem(1,'movi_itbm',0)
		dw_1.setitem(1,'movi_monto_final',ad_monto)
	end if
else
	if dw_1.rowcount() > 0 then
		ld_valor   = round(ad_monto * str.valor_itbm,2)
		dw_1.setitem(1,'movi_itbm',ld_valor)
		dw_1.setitem(1,'movi_monto_final',ad_monto + ld_valor)
		ad_monto = ad_monto + ld_valor
		if dw_3.rowcount() = 1 then
			dw_3.insertrow(2)
			dw_3.setitem(2,'ddia_fecha', date(gf_fecha_serv()))
			dw_3.setitem(2,'ddia_g_financiero',str.g_financiero)
			dw_3.setitem(2,'ddia_empresa',str.empresa)
			dw_3.setitem(2,'ddia_aplicacion_mg','CP')
	//		dw_3.setitem(2,'ddia_ann', ii_ann) //year(date(gf_fecha_serv())))
			dw_3.setitem(2,'ddia_id', str.usuario)
			dw_3.setitem(2,'ddia_tipo_transaccion', is_tran)
			dw_3.setitem(2,'ddia_sub_trans', is_stran)
			dw_3.setitem(2,'naturaleza','D')	
			dw_3.setitem(2,'ddia_linea',2)
			dw_3.setitem(2,'tipo','I')
			dw_3.setitem(2,'ddia_ann',ii_ann)
			dw_3.setitem(2,'ddia_no_documento',dw_1.getitemstring(1,'movi_documento'))
			dw_3.setitem(2,'ddia_no_referencia',dw_1.getitemstring(1,'movi_referencia'))			
	
			dw_3.insertrow(3)
			dw_3.setitem(3,'ddia_fecha', date(gf_fecha_serv()))
			dw_3.setitem(3,'ddia_g_financiero',str.g_financiero)
			dw_3.setitem(3,'ddia_empresa',str.empresa)
			dw_3.setitem(3,'ddia_aplicacion_mg','CP')
	//		dw_3.setitem(3,'ddia_ann', ii_ann) //year(date(gf_fecha_serv())))
			dw_3.setitem(3,'ddia_id', str.usuario)
			dw_3.setitem(3,'ddia_tipo_transaccion', is_tran)
			dw_3.setitem(3,'ddia_sub_trans', is_stran)
			dw_3.setitem(3,'naturaleza','D')	
			dw_3.setitem(3,'ddia_linea',3)
			dw_3.setitem(3,'tipo','I')
			dw_3.setitem(3,'ddia_ann',ii_ann)
			dw_3.setitem(3,'ddia_no_documento',dw_1.getitemstring(1,'movi_documento'))
			dw_3.setitem(3,'ddia_no_referencia',dw_1.getitemstring(1,'movi_referencia'))			
	
		end if
		dw_3.setitem(2,'monto_debito', ld_valor)
		dw_3.setitem(2,'naturaleza','D')
		dw_3.setitem(2,'ddia_mg_cuenta',is_cuenta_itbm)
		dw_3.setitem(2,'cuenta',is_cuenta_itbm)
	end if			
end if


end subroutine

on w_transacciones_cxp.create
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
this.dw_5=create dw_5
this.dw_6=create dw_6
this.uo_1=create uo_1
this.uo_2=create uo_2
this.dw_7=create dw_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.dw_4
this.Control[iCurrent+9]=this.dw_5
this.Control[iCurrent+10]=this.dw_6
this.Control[iCurrent+11]=this.uo_1
this.Control[iCurrent+12]=this.uo_2
this.Control[iCurrent+13]=this.dw_7
end on

on w_transacciones_cxp.destroy
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
destroy(this.dw_5)
destroy(this.dw_6)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.dw_7)
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
dw_7.settransobject(sqlca)

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

dw_1.getchild('movi_tipo_transaccion', idwc_tran)
idwc_tran.settransobject(sqlca)
idwc_tran.retrieve(str.g_financiero, str.empresa)

dw_1.getchild('movi_sub_transaccion', idwc_stran)
idwc_stran.settransobject(sqlca)
idwc_stran.retrieve(str.g_financiero, str.empresa)

dw_7.getchild('ddia_mg_cuenta', idwc_plan)
idwc_plan.settransobject(sqlca)
idwc_plan.retrieve(str.g_financiero, str.empresa)
idwc_plan.insertrow(1)

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
	dw_1.setitem(1,'movi_aplicacion','CP')
	dw_1.setitem(1,'movi_anno', ii_ann)
	dw_1.setitem(1,'movi_usuario', str.usuario)
	dw_1.setitem(1,'movi_historico', 0)
end if

ii_historico = 0

dw_1.Modify("calendario.Filename='"+str.path+"Art\ddfec.bmp'")
dw_1.Modify("calendario2.Filename='"+str.path+"Art\ddfec.bmp'")

dw_1.setitemstatus(1,0,primary!,NotModified!) 
end event

event ue_aceptar;//override
long ll_update, ll_doc, ll_tercero
integer li_ann, i
window lw_ventana
datetime ldt_fecha_tran
string ls_titulo, ls_doc, ls_tipo, ls_cuenta, ls_multiple, ls_referencia, ls_comentario, ls_naturaleza, ls_nombre, ls_ruc_tercero, ls_dv
decimal{2} ldec_saldo, ld_monto, ld_monto_final, ld_itbm
 
//lw_ventana = this.getactivesheet()
//ls_titulo = lw_ventana.title

dw_1.accepttext()
dw_3.accepttext()
li_ann = ii_ann
dw_1.setitem(1,'movi_anno',ii_ann)
ls_doc = dw_1.getitemstring(dw_1.getrow(), 'movi_documento')
ls_multiple = dw_1.getitemstring(dw_1.getrow(), 'movi_multiple')

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

if dw_1.getitemNumber(dw_1.getrow(), 'movi_monto') = 0 or isnull(dw_1.getitemNumber(dw_1.getrow(),'movi_monto')) then
	gf_mensaje('','Debe asignar el valor de la transaccion antes de guardar, Verifique !!!',1,1,'E')
	dw_1.setcolumn('movi_monto')
	return
end if


//Valida que no pueda registrar transacciones de fechas inferiores al ultimo cierre de caja
ldt_fecha_tran = dw_1.getitemdatetime(1,'movi_fecha_tran')
if not gf_valida_fecha_conta(ldt_fecha_tran) then
	return
end if

//valida q este en balance
if ii_historico = 0 then
	if dw_3.getitemnumber(1,'balance') <> 0 then
		gf_mensaje('','Debe Balancear la Transaccion para Guardar, Verifique !!!',1,1,'E')
		return
	end if
		
	for i = 1 to dw_3.rowcount()
		ls_cuenta = dw_3.getitemstring(i,'ddia_mg_cuenta')
		if ls_cuenta = '' or isnull(ls_cuenta) then
			gf_mensaje('','Debe Asignar la Cuenta Contable, Verifique !!!',1,1,'E')
			dw_3.scrolltorow(i)
			dw_3.setfocus()
			dw_3.setcolumn('ddia_mg_cuenta')
			return
		end if
	next
end if

ld_monto = dw_1.getitemnumber(1,'movi_monto')

if is_tran <> 'FF' then //Si no son facturas, se asigna el monto al monto final
	dw_1.setitem(1,'movi_monto_final',ld_monto)
else
	ld_itbm = dw_1.getitemnumber(1,'movi_itbm')
	if isnull(ld_itbm) then ld_itbm = 0
	dw_1.setitem(1,'movi_monto_final',ld_monto + ld_itbm)
end if

if dw_1.getitemstring(1,'movi_naturaleza') = 'C' then
	dw_1.setitem(1,'movi_saldo',ld_monto + ld_itbm)
end if

sqlca.autocommit = false


ll_update=dw_1.update()

if ll_update = 1  then

	//elimina si se hicieron modificaciones
	if ii_historico = 0 and not wf_elimina_auxiliares() then			
		rollback;
		sqlca.autocommit = true
		return
	end if

	//guarda el asiento contable
	if ii_historico = 0 and not wf_registra_asiento() then
		rollback ;
		sqlca.autocommit = true
		return
	elseif ii_historico = 0 and not wf_elimina_detalle() then
		rollback ;
		sqlca.autocommit = true
		return
	else //Si el Asiento se Registro Correctamente
		
		//Guarda las facturas pagadas, si es un Pago al Proveedor o una N/CR
		if dw_5.visible then
			if not wf_guarda_facturas_pagadas() then
				rollback ;
				sqlca.autocommit = true
				return
			end if
		end if

		
		if ii_historico = 0 then					
			ls_comentario = dw_1.getitemstring(1,'movi_comentario')
			for i = 1 to dw_3.rowcount()
					dw_3.setitem(i,'ddia_linea',i)
					if dw_3.getitemstring(i,'naturaleza') = 'D' then
						dw_3.setitem(i,'ddia_monto',dw_3.getitemnumber(i,'monto_debito'))
					else
						dw_3.setitem(i,'ddia_monto',dw_3.getitemnumber(i,'monto_credito'))
					end if
					dw_3.setitem(i,'ddia_no_documento',dw_1.getitemstring(1,'movi_documento'))
					dw_3.setitem(i,'ddia_no_referencia',dw_1.getitemstring(1,'movi_referencia'))
					dw_3.setitem(i,'ddia_banco_cuenta','1')
					dw_3.setitem(i,'ddia_ann',ii_ann)			
					//Si es Transaccion Multiple, inserta en el auxiliar
					if ls_multiple = 'S' and i > 1 then 					
						ll_tercero = dw_3.getitemnumber(i,'ddia_tercero')
						if ll_tercero > 0 then
							ls_naturaleza = dw_3.getitemstring(i,'naturaleza')							
							ld_monto = dw_3.getitemnumber(i,'ddia_monto')
							ls_referencia = string(ll_tercero)+'/'+string(i)
							
							SELECT dgmterce.terc_descripcion,   
								         dgmterce.terc_identificacion,   
								         dgmterce.terc_digito_verificador  
								    INTO :ls_nombre,   
								         :ls_ruc_tercero,   
								         :ls_dv  
								    FROM dgmterce  
								   WHERE dgmterce.terc_tercero = :ll_tercero   ;
									if sqlca.sqlcode = -1 then
										gf_mensaje('','Error al buscar valores '+sqlca.sqlerrtext,1,1,'Q')
									end if
							
							  INSERT INTO cptmovim  
				         ( movi_g_financiero,   
				           movi_empresa,   
				           movi_aplicacion,   
				           movi_tipo_transaccion,   
				           movi_sub_transaccion,   
				           movi_documento,   
				           movi_anno,   
				           movi_referencia,   
				           movi_tercero,   
				           movi_ruc_tercero,   
				           movi_naturaleza,   
				           movi_monto,   
				           movi_fecha_tran,   
				           movi_fecha_reg,   
				           movi_usuario,   
				           movi_estado,   
				           movi_fecha_anul,   
				           movi_usuario_anul,   
				           movi_fecha_vence,   
				           movi_fecha_cancelado,   
				           movi_comentario,   
				           movi_c_costo,   
				           movi_afiliada,   
				           movi_saldo,   
				           movi_valor_grabado,   
				           movi_valor_nograbado,   
				           movi_descuento,   
				           movi_itbm,   
				           movi_fecha_ordcompra,   
				           movi_num_ordcompra,   
				           movi_nombre_contado,   
				           movi_digito_verificador,   
				           movi_cheque_manual,   
				           movi_no_liqinterna,   
				           movi_no_liqaduana,   
				           movi_no_cheque,   
				           movi_fecha_cheque,   
				           movi_cierre_mensual,   
				           movi_pase_conta,   
				           movi_transac_rever,   
				           movi_subtran_rever,   
				           movi_orden_pago,   
				           movi_doc_reversado,   
				           movi_num_pagare,   
				           movi_multiple,   
				           movi_concepto_pago,   
				           movi_cargo_autom,   
				           movi_cuenta_bancaria,   
				           movi_doc_origen,   
				           movi_moneda,   
				           movi_cambio,   
				           movi_tipo_cargo,   
				           movi_estado_historica,   
				           movi_a_nombre,   
				           movi_impreso,   
				           movi_historico,   
				           movi_monto_aplicado,   
				           movi_paga_itbm,   
				           movi_monto_final)  
				  VALUES ( :str.g_financiero,   
				           :str.empresa,   
				           'CP',   
				           :is_tran,   
				           :is_stran,   
				           :ls_doc,   
				           :ii_ann,   
				           :ls_referencia,   
				           :ll_tercero,   
				           :ls_ruc_tercero,   
				           :ls_naturaleza,   
				           :ld_monto,   
				           :ldt_fecha_tran,   
				           getdate(),   
				           :str.usuario,   
				           'IM',   
				           null,   
				           null,   
				           null,   
				           null,   
				           :ls_comentario,   
				           null,   
				           null,   
				           :ld_monto,   
				           null,   
				           null,   
				           null,   
				           0,   
				           null,   
				           null,   
				           null,   
				           :ls_dv,   
				           null,   
				           null,   
				           null,   
				           null,   
				           null,   
				           'N',   
				           'N',   
				           null,   
				           null,   
				           null,   
				           null,   
				           null,   
				           'S',   
				           null,   
				           null,   
				           null,   
				           null,   
				           null,   
				           null,   
				           null,   
				           null,   
				           :ls_nombre,   
				           'S',   
				           0,   
				           0,   
				           null,   
				           :ld_monto )  ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al Insertar Tran Multiple '+sqlca.sqlerrtext,1,1,'E')
								return
							end if
						end if
					end if
			next
			if dw_3.update() = -1 then
				gf_mensaje('','Error al guardar detalle contable '+sqlca.sqlerrtext,1,1,'E')
				rollback ;
				sqlca.autocommit = true
				return
			end if
		end if //Del ii_historico = 0
	end if //del not wf_registra_asientos()
	
	commit using sqlca;
		
	ldec_saldo = gf_saldo_anterior_new( dw_1.getitemnumber(1,'movi_tercero'), gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)
	dw_1.setitem(1,'saldo',ldec_saldo)				
		//Si la secuencia es automatica, graba en la tabla de transacciones
		is_tran_automatica = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_sec_auto')
		if is_tran_automatica = 'S' then
			
			ll_doc = long(dw_1.getitemstring(1,'movi_documento'))
			
			if dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = New! or 	dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = NewModified! then 	
					update dgmserie
					set mser_secuencia = :ll_doc
					where mser_g_financiero = :str.g_financiero and
							mser_empresa		= :str.empresa	and
							mser_tipo_transaccion = :is_tran ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al guardar secuencia '+sqlca.sqlerrtext,1,1,'E')
							end if
			end if
		end if			
		if dw_1.getitemstring(1,'movi_impreso') = 'N' or isnull(dw_1.getitemstring(1,'movi_impreso')) then
			if ii_imprimir_al_grabar = 1 then
				this.triggerevent('ue_print')
				update cptmovim set movi_impreso = 'S'
				where movi_g_financiero = :str.g_financiero and
						movi_empresa		= :str.empresa	and
						movi_aplicacion	= 'CP' and
						movi_tipo_transaccion = :is_tran and
						movi_sub_transaccion	 = :is_stran and
						movi_documento			 = :ls_doc and
						movi_anno				 = :li_ann ;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al actualizar el estado de impreso '+sqlca.sqlerrtext,1,1,'E')
							rollback;
						end if
						dw_1.setitem(1,'movi_impreso','S')
			end if
		end if
		sqlca.autocommit = true
		this.triggerevent('ue_adicionar')
		commit ;
//	gf_mensaje("Atención","¡Actualización Exitosa !",1,1,'E')
else
	rollback using sqlca;
	gf_mensaje("Atención","¡Error al Actualizar ! " + sqlca.sqlerrtext,1,1,'E')
end if

sqlca.autocommit = true
end event

event ue_adicionar;//override
string ls_tran, ls_subt, ls_naturaleza, ls_doc, ls_masca
if dw_1.rowcount() > 0 then
	dw_1.reset()	
end if

dw_1.insertrow(1)
dw_1.setitem(1,'movi_fecha_tran', date(gf_fecha_serv()))
dw_1.setitem(1,'movi_g_financiero',str.g_financiero)
dw_1.setitem(1,'movi_empresa',str.empresa)
dw_1.setitem(1,'movi_aplicacion','CP')
dw_1.setitem(1,'movi_anno', ii_ann )
if ii_ann <> year(date(gf_fecha_serv())) then
	if pos(upper(str.empr_acceso_especial),'HPSA') = 0 then
		if gf_mensaje('','El año es Distinto al Actual, Desea Capturar en Años Anteriores ?',2,1,'E') = 2 then
			ii_ann = year(date(gf_fecha_serv()))
		end if
	end if
	dw_1.setitem(1,'movi_anno', ii_ann )
else
	dw_1.setitem(1,'movi_anno', ii_ann )
end if
dw_1.setitem(1,'movi_usuario', str.usuario)
dw_1.setitem(1,'movi_tipo_transaccion', is_tran)
dw_1.setitem(1,'movi_sub_transaccion', is_stran)
ls_naturaleza = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_movimiento')
dw_1.setitem(1,'movi_naturaleza',ls_naturaleza)	
dw_1.setitem(1,'movi_historico',ii_historico)	
if ls_naturaleza = 'C' then dw_1.setitem(1,'movi_fecha_vence', relativedate(date(gf_fecha_serv()),30))	

il_tercero_anterior = 0
is_doc_anterior = ''
is_ref_anterior = ''
ii_ann_anterior = 0
//facturas aplicadas
dw_5.reset()

dw_3.dataobject = 'dw_detalle_contable'
dw_3.getchild('ddia_mg_cuenta', idwc_plan)
idwc_plan.settransobject(sqlca)
idwc_plan.retrieve(str.g_financiero, str.empresa)
idwc_plan.insertrow(1)
ls_masca = gf_mascara()
dw_3.MODIFY("cuenta.editmask.mask='"+ls_masca+"'") //mascara para el compute de la cuenta
idwc_plan.MODIFY("mg_cuenta.editmask.mask='"+ls_masca+"'") //cuenta que se graba en el detalle contable
dw_3.settransobject(sqlca)

//adiciona en dw contable
if ii_historico = 0 then
	dw_3.reset()
	dw_3.insertrow(1)
	dw_3.setitem(1,'ddia_fecha', date(gf_fecha_serv()))
	dw_3.setitem(1,'ddia_g_financiero',str.g_financiero)
	dw_3.setitem(1,'ddia_empresa',str.empresa)
	dw_3.setitem(1,'ddia_aplicacion_mg','CP')
	dw_3.setitem(1,'ddia_ann', ii_ann)
	dw_3.setitem(1,'ddia_id', str.usuario)
	dw_3.setitem(1,'ddia_tipo_transaccion', is_tran)
	dw_3.setitem(1,'ddia_sub_trans', is_stran)
	dw_3.setitem(1,'naturaleza',ls_naturaleza)	
	dw_3.setitem(1,'ddia_linea',1)
	dw_3.setitem(1,'tipo','P')
end if
//
is_tran_automatica = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_sec_auto')
if is_tran_automatica = 'S' then
	dw_1.Modify("movi_documento.Edit.DisplayOnly=Yes")			
	ls_doc = wf_secuencia_tran()			
	dw_1.setitem(1,'movi_documento', ls_doc)
else
	dw_1.Modify("movi_documento.Edit.DisplayOnly=No")
	dw_1.setitem(1,'movi_documento','')
end if		

if is_tran = 'PA' or is_tran = 'NP' then
	dw_5.dataobject = 'dw_documentos_por_aplicar_cp'
	dw_5.settransobject(sqlca)
end if

dw_1.setcolumn('movi_documento')
dw_1.setfocus()
dw_1.Modify("movi_comentario.Edit.DisplayOnly=No")
end event

event resize;//override
dw_1.Resize(This.Width - 270, This.Height - 430)
dw_3.width = This.Width - 270
pb_1.y = newheight - 200
st_1.y = newheight - 180
cb_3.y = newheight - 200

end event

event ue_print;//override
string  ls_dinero, ls_tran, ls_doc, ls_masca, ls_referencia
Integer li_ann

ls_tran = dw_1.getitemstring(1,'movi_tipo_transaccion')
if ii_historico = 1 then
	dw_2.dataobject = 'dw_imprimir_cxp_historico'
else
	dw_2.dataobject = 'dw_imprimir_cxp'
end if

dw_2.settransobject(sqlca)

ls_doc  = dw_1.getitemstring(1,'movi_documento')
li_ann  = dw_1.getitemnumber(1,'movi_anno')
ls_referencia = dw_1.getitemstring(1,'movi_referencia')

if dw_2.retrieve(str.g_financiero, str.empresa, ls_tran, ls_doc, li_ann, ls_referencia) > 0 then
	ls_dinero =  upper(gf_numerlet(dw_1.getitemnumber(1,'movi_monto_final'),1))
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
dw_2.visible = true

OpenWithParm(w_dw_print_options, dw_2)
dw_2.visible = false
If Message.DoubleParm = -1 Then Return
dw_2.Print(True)

end event

event ue_eliminar;//override
integer i
string ls_tipo, ls_err, ls_referencia, ls_error, ls_multiple
long ll_tercero

this.setredraw(false)
if dw_1.rowcount() > 0 then
	if gf_mensaje('','Esta seguro de eliminar la transaccion ??',2,1,'E') = 2 then 
		this.setredraw(true)
		return		
	end if
	
	ls_multiple = dw_1.getitemstring(1,'movi_multiple')
	
	dw_1.deleterow(dw.getrow())
	if dw_1.update() = 1 then

		if is_tran = 'PA' or is_tran = 'NP' then
			if not wf_restaurar_saldos() then
				rollback;
				return				
			end if
		end if

	//Verificar y eliminar	
	if ls_multiple = 'S' then
		for i = 2 to dw_3.rowcount()
			 ll_tercero = dw_3.getitemnumber(i,'ddia_tercero')
			 if ll_tercero > 0 then
				  ls_referencia = string(ll_tercero)+'/'+string(i)
					DELETE FROM cptmovim  
				   WHERE ( cptmovim.movi_g_financiero = :str.g_financiero ) AND  
				         ( cptmovim.movi_empresa = :str.empresa ) AND  
				         ( cptmovim.movi_aplicacion = 'CP' ) AND  
				         ( cptmovim.movi_tipo_transaccion = :is_tran ) AND  
				         ( cptmovim.movi_sub_transaccion = :is_stran ) AND  
				         ( cptmovim.movi_documento = :is_doc_anterior ) AND  
				         ( cptmovim.movi_anno = :ii_ann_anterior ) AND  
				         ( cptmovim.movi_referencia = :ls_referencia )   ;
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							gf_mensaje('','Error al Eliminar Multiple '+ls_error,1,1,'E')
						end if						
			 end if				
		next
	end if
		
  DELETE FROM coddiari  
   WHERE ( coddiari.ddia_g_financiero = :str.g_financiero ) AND  
         ( coddiari.ddia_empresa = :str.empresa ) AND  
         ( coddiari.ddia_aplicacion_mg = 'CP' ) AND  
         ( coddiari.ddia_tipo_transaccion = :is_tran ) AND  
         ( coddiari.ddia_sub_trans = :is_stran ) AND  
         ( coddiari.ddia_no_documento = :is_doc_anterior ) AND  
         ( coddiari.ddia_no_referencia = :is_ref_anterior ) AND  
         ( coddiari.ddia_ann = :ii_ann_anterior ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Eliminar Encabezado del Asiento '+sqlca.sqlerrtext,1,1,'E')
			rollback;
		end if

  DELETE FROM cotdiari  
   WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
         ( cotdiari.diar_empresa = :str.empresa ) AND  
         ( cotdiari.diar_aplicacion_mg = 'CP' ) AND  
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
	end if
else 
	messagebox("Atención","No hay registros para borrar!")
end if
this.setredraw(true)
end event

event open;call super::open;dw = dw_2

end event

event close;call super::close;Window lw_frame

lw_frame = ParentWindow()

If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_sheet_closed")
 End If
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_transacciones_cxp
boolean visible = false
integer width = 73
integer height = 36
string text = ""
end type

type dw_1 from w_fa_padre`dw_1 within w_transacciones_cxp
integer width = 4334
integer height = 1416
string dataobject = "dw_transacciones_cxp"
end type

event dw_1::itemchanged;call super::itemchanged;this.accepttext()
string  ls_multiple, ls_tran, ls_doc, ls_subt, ls_naturaleza, ls_cuenta, ls_proveedor, ls_referencia, ls_aplicacion, ls_stran, ls_documento, ls_find, ls_masca
integer li_ann, li_existe, i, li_registro, li_ann_anterior, li_total
long    ll_tercero
decimal{2} ldec_saldo, ld_tarjeta, ld_porcentaje, ld_monto, ld_saldo, ld_monto_aplicado
datetime ldt_fecha_tran, ldt_fecha_anterior
	
choose case this.getcolumnname()
	case 'movi_multiple'
		ls_multiple =  data  //this.getitemstring(1,'movi_multiple')
		if ls_multiple = 'S' then
			//Elimina el detalle anterior
			if dw_3.rowcount() > 1 then
				li_total = dw_3.rowcount()
				for i = 1 to li_total
					dw_3.deleterow(1)					
				next
				if dw_3.update() = -1 then
					gf_mensaje('','Error al Eliminar detalle '+sqlca.sqlerrtext,1,1,'E')
					return
				end if
			end if			
			dw_3.dataobject = 'dw_detalle_contable_multiple'
			dw_4.dataobject = 'dw_detalle_contable_multiple'
			dw_3.getchild('ddia_tercero',idwc_proveedor_multiple)
			idwc_proveedor_multiple.settransobject(sqlca)
			idwc_proveedor_multiple.retrieve(str.g_financiero, str.empresa)
			idwc_proveedor_multiple.insertrow(1)
		else
			dw_3.dataobject = 'dw_detalle_contable'
			dw_4.dataobject = 'dw_detalle_contable'
		end if
		dw_3.getchild('ddia_mg_cuenta', idwc_plan)
		idwc_plan.settransobject(sqlca)
		idwc_plan.retrieve(str.g_financiero, str.empresa)
		idwc_plan.insertrow(1)
		ls_masca = gf_mascara()
		dw_3.MODIFY("cuenta.editmask.mask='"+ls_masca+"'") //mascara para el compute de la cuenta
		idwc_plan.MODIFY("mg_cuenta.editmask.mask='"+ls_masca+"'") //cuenta que se graba en el detalle contable
		dw_3.settransobject(sqlca)
		dw_4.settransobject(sqlca)
		ls_naturaleza = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_movimiento')
		dw_3.insertrow(1)
		dw_3.setitem(1,'ddia_fecha', date(gf_fecha_serv()))
		dw_3.setitem(1,'ddia_g_financiero',str.g_financiero)
		dw_3.setitem(1,'ddia_empresa',str.empresa)
		dw_3.setitem(1,'ddia_aplicacion_mg','CP')
		dw_3.setitem(1,'ddia_ann', ii_ann)
		dw_3.setitem(1,'ddia_id', str.usuario)
		dw_3.setitem(1,'ddia_tipo_transaccion', is_tran)
		dw_3.setitem(1,'ddia_sub_trans', is_stran)
		dw_3.setitem(1,'naturaleza',ls_naturaleza)	
		dw_3.setitem(1,'ddia_linea',1)
		dw_3.setitem(1,'tipo','P')
		
		ll_tercero = dw_1.getitemnumber(1,'movi_tercero')
		if ll_tercero > 0  then
			ld_monto = dw_1.getitemnumber(1,'movi_monto')
			  SELECT max(prov_mg_cuenta), max(prov_cod_proveedor)  
				 INTO  :ls_cuenta, :ls_proveedor
				 FROM cpmprove  
				WHERE ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
						( cpmprove.prov_empresa = :str.empresa ) AND  
						( cpmprove.prov_tercero = :ll_tercero ) ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Buscar Cuenta Proveedor '+sqlca.sqlerrtext,1,1,'E')
					end if			
			dw_3.setitem(1,'ddia_mg_cuenta',ls_cuenta)
			dw_3.setitem(1,'cuenta',ls_cuenta)
			dw_3.setitem(1,'ddia_tercero',ll_tercero)
			dw_3.setitem(1,'ddia_codigo_cte_prov',ls_proveedor)
		end if		
		dw_3.setitem(1,'ddia_banco_cuenta','1')
		if ls_naturaleza = 'D' then
			dw_3.setitem(1,'naturaleza','D')
			dw_3.setitem(1,'monto_debito',ld_monto)
		else
			dw_3.setitem(1,'naturaleza','C')			
			dw_3.setitem(1,'monto_credito',ld_monto)			
		end if							
				
	case 'movi_anno'
		ii_ann = this.getitemnumber(1,'movi_anno')
	//	parent.triggerevent('ue_adicionar')
		if year(date(this.getitemdatetime(1,'movi_fecha_tran'))) <> ii_ann then
			gf_mensaje('','Verifique el año es diferente al de la fecha',1,1,'E')
			this.setcolumn('movi_anno')
			return
		end if
	case 'movi_fecha_tran'
		ldt_fecha_tran 	 = this.getitemdatetime(this.getrow(),'movi_fecha_tran')		
		ldt_fecha_anterior = this.getitemdatetime(this.getrow(),'movi_fecha_tran', Primary!, True)		
		li_ann_anterior = dw_1.getitemnumber(1,'movi_anno')
				
		if not gf_valida_fecha_conta(ldt_fecha_anterior) then		
			if ldt_fecha_anterior = ldt_fecha_tran then
				dw_1.setitem(1,'movi_fecha_tran', date(gf_fecha_serv()))
			else
				dw_1.setitem(1,'movi_fecha_tran', ldt_fecha_anterior)
			end if
			dw_1.setcolumn('movi_fecha_tran')
			return 2
		end if

		if not gf_valida_fecha_conta(ldt_fecha_tran) then			
			if ldt_fecha_anterior = ldt_fecha_tran then
				dw_1.setitem(1,'movi_fecha_tran', date(gf_fecha_serv()))
			else
				dw_1.setitem(1,'movi_fecha_tran', ldt_fecha_anterior)
			end if
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

		ii_ann = year(date(this.getitemdatetime(this.getrow(),'movi_fecha_tran')))
		//Si los anios son diferentes asigna el anio
		if ii_ann <> li_ann_anterior then
			dw_1.setitem(1,'movi_anno',ii_ann)
		end if		
		
	case 'movi_tipo_transaccion'		
		ls_tran = data
		if ls_tran = 'PA' or ls_tran = 'NP' then
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
			is_stran = idwc_stran.getitemstring(1,'dgmsubse_subs_sub_trans')
			dw_1.setitem(1,'movi_sub_transaccion',is_stran)
		end if	
		
		parent.triggerevent('ue_adicionar')
		
		ls_naturaleza = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_movimiento')
		if ls_naturaleza = 'C' then dw_1.setitem(1,'movi_fecha_vence', relativedate(date(gf_fecha_serv()),30))	

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
		if ls_naturaleza = 'D' then
			dw_3.setitem(1,'naturaleza','D')
		else
			dw_3.setitem(1,'naturaleza','C')			
		end if					
		this.setcolumn('movi_documento')		
	case 'movi_sub_transaccion'
		is_stran = data
		this.setcolumn('movi_documento')		
	case 'movi_ruc_tercero'						
		this.setitem(1,'movi_a_nombre',idwc_clientes.getitemstring(idwc_clientes.getrow(),'terc_descripcion'))
		ls_naturaleza = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_movimiento')
		ll_tercero = idwc_clientes.getitemNumber(idwc_clientes.getrow(), 'terc_tercero')
		this.setitem(1,'movi_tercero', ll_tercero )						

		  SELECT count(*), max(prov_mg_cuenta), max(prov_cod_proveedor)  
			 INTO :li_existe, :ls_cuenta, :ls_proveedor
			 FROM cpmprove  
			WHERE ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
					( cpmprove.prov_empresa = :str.empresa ) AND  
					( cpmprove.prov_cod_proveedor = :data ) ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Buscar Cuenta Proveedor '+sqlca.sqlerrtext,1,1,'E')
				end if
					
			if li_existe = 0 or isnull(li_existe) then
				gf_mensaje('','Proveedor no existe. Verifique !!!',1,1,'E')
				this.setitem(1,'movi_ruc_tercero','')
				this.setcolumn('movi_ruc_tercero')
				return 2
			end if				
		
	   if dw_5.visible then
			dw_5.retrieve(str.g_financiero, str.empresa, ll_tercero)
		end if	

		//asigna el codigo de cuenta, tercero y codigo
		if ii_historico = 0 then
			if dw_3.rowcount() = 0 then dw_3.insertrow(1)
			dw_3.setitem(1,'ddia_mg_cuenta',ls_cuenta)
			dw_3.setitem(1,'cuenta',ls_cuenta)
			dw_3.setitem(1,'ddia_tercero',ll_tercero)
			dw_3.setitem(1,'ddia_codigo_cte_prov',ls_proveedor)
			dw_3.setitem(1,'ddia_banco_cuenta','1')
			if ls_naturaleza = 'D' then
				dw_3.setitem(1,'naturaleza','D')
			else
				dw_3.setitem(1,'naturaleza','C')			
			end if					
		end if
		
//		this.setitem(1,'movi_ruc_tercero',idwc_clientes.getitemstring(idwc_clientes.getrow(),'clie_ref_anterior'))		
		ldec_saldo = gf_saldo_cxp( ll_tercero, gf_fecha_serv())
		this.setitem(1,'saldo',ldec_saldo)
	case 'movi_paga_itbm'
		ii_paga_itbms =  integer(data) //this.getitemnumber(1,'fact_paga_itbm')
		ld_monto = dw_1.getitemnumber(1,'movi_monto')
		wf_calcula_itbm(ld_monto)	
		if ii_historico = 0 then
			ls_naturaleza = this.getitemstring(1,'movi_naturaleza')
			if ls_naturaleza = 'D' then
				dw_3.setitem(1,'monto_debito',ld_monto)
				if dw_3.rowcount() = 2 then
					dw_3.setitem(2,'monto_credito',ld_monto)
				end if
			else
				dw_3.setitem(1,'monto_credito',ld_monto)
				if dw_3.rowcount() = 2 then
					if ii_paga_itbms = 0 then
						dw_3.setitem(2,'monto_debito',ld_monto)
					end if
				elseif dw_3.rowcount() = 3 then
					dw_3.setitem(3,'monto_debito',dw_1.getitemnumber(1,'movi_monto'))
				end if				
			end if					
		end if
		
		//Asigna el pago a los movimientos debitos
		wf_aplica_pagos()
		
	case 'movi_monto'
		ld_monto = double(data)
		wf_calcula_itbm(ld_monto)			
		if ii_historico = 0 then
			ls_naturaleza = this.getitemstring(1,'movi_naturaleza')
			if ls_naturaleza = 'D' then
				dw_3.setitem(1,'monto_debito',ld_monto)
				if dw_3.rowcount() = 2 then
					dw_3.setitem(2,'monto_credito',ld_monto)
				end if
			else
				dw_3.setitem(1,'monto_credito',ld_monto)
				if dw_3.rowcount() = 2 then
					if ii_paga_itbms = 0 then
						dw_3.setitem(2,'monto_debito',ld_monto)
					end if
				elseif dw_3.rowcount() = 3 then
					dw_3.setitem(3,'monto_debito',dw_1.getitemnumber(1,'movi_monto'))
				end if				
			end if					
		end if
		ld_monto = dw_1.getitemnumber(1,'movi_monto')
		
		//Asigna el pago a los movimientos debitos
		wf_aplica_pagos()
		this.setcolumn('movi_comentario')		
	case 'movi_historico'
		ii_historico = integer(data)
		if ii_historico = 1 then
			dw_3.visible = false
		else
			dw_3.visible = true
		end if
	case 'movi_documento'
		
		ls_doc = this.getitemstring(1,'movi_documento')
		li_ann =  this.getitemNumber(1,'movi_anno')//year(date(gf_fecha_serv()))
		ls_tran = this.getitemstring(1,'movi_tipo_transaccion')
		ls_subt = this.getitemstring(1,'movi_sub_transaccion')			
		ls_referencia = this.getitemstring(1,'movi_referencia')
		if	this.retrieve(str.g_financiero, str.empresa, ls_tran, ls_doc, li_ann, ls_referencia ) = 0 then
			parent.triggerevent('ue_adicionar')
			this.setitem(1,'movi_documento',ls_doc)
			this.setitem(1,'movi_tipo_transaccion',ls_tran)
			this.setitem(1,'movi_sub_transaccion',ls_subt)
			ls_naturaleza = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_movimiento')
			this.setitem(1,'movi_naturaleza',ls_naturaleza)		
			this.setitem(1,'movi_referencia',left(ls_doc,8))		
			this.setitem(1,'movi_historico', ii_historico)	
			this.setcolumn('movi_documento')
			if ii_historico = 0 then
				dw_3.setitem(1,'ddia_no_documento', ls_doc)
				dw_3.setitem(1,'ddia_no_referencia', left(ls_doc,8))
			end if
		else
			ii_ann_anterior = this.getitemnumber(1,'movi_anno')
			is_doc_anterior = this.getitemstring(1,'movi_documento')
			is_ref_anterior = this.getitemstring(1,'movi_referencia')
			ls_multiple = this.getitemstring(1,'movi_multiple')
			if ls_multiple = 'S' then
				dw_3.dataobject = 'dw_detalle_contable_multiple'
				dw_3.getchild('ddia_tercero',idwc_proveedor_multiple)
				idwc_proveedor_multiple.settransobject(sqlca)
				idwc_proveedor_multiple.retrieve(str.g_financiero, str.empresa)
				idwc_proveedor_multiple.insertrow(1)
			else
				dw_3.dataobject = 'dw_detalle_contable'
			end if
			dw_3.getchild('ddia_mg_cuenta', idwc_plan)
			idwc_plan.settransobject(sqlca)
			idwc_plan.retrieve(str.g_financiero, str.empresa)
			idwc_plan.insertrow(1)
			ls_masca = gf_mascara()
			dw_3.MODIFY("cuenta.editmask.mask='"+ls_masca+"'") //mascara para el compute de la cuenta
			idwc_plan.MODIFY("mg_cuenta.editmask.mask='"+ls_masca+"'") //cuenta que se graba en el detalle contable
			dw_3.settransobject(sqlca)
				
			ldec_saldo = gf_saldo_cxp( this.getitemnumber(1,'movi_tercero'), gf_fecha_serv())
			this.setitem(1,'saldo',ldec_saldo)			
//			this.setitem(1,'movi_referencia',ls_doc)		
			ls_referencia = this.getitemstring(1,'movi_referencia')
			ii_ann 		  = this.getitemnumber(1,'movi_anno')
			ii_historico  = this.getitemnumber(1,'movi_historico')
			//Si es historico, oculta el datawindow del detalle contable
			ll_tercero 	  = this.getitemnumber(1,'movi_tercero')
			il_tercero_anterior = ll_tercero
	         ii_paga_itbms = dw_1.getitemnumber(1, 'movi_paga_itbm')
	
			if ii_historico = 0 then
				dw_3.visible = true
				if dw_3.retrieve(str.g_financiero, str.empresa, 'CP' , ls_tran, ls_doc, ls_referencia, ii_ann, '1' ) = 0 then
					dw_3.insertrow(1)
					dw_3.setitem(1,'ddia_fecha', date(gf_fecha_serv()))
					dw_3.setitem(1,'ddia_g_financiero',str.g_financiero)
					dw_3.setitem(1,'ddia_empresa',str.empresa)
					dw_3.setitem(1,'ddia_aplicacion_mg','CP')
					dw_3.setitem(1,'ddia_ann', ii_ann)
					dw_3.setitem(1,'ddia_id', str.usuario)
					dw_3.setitem(1,'ddia_tipo_transaccion', is_tran)
					dw_3.setitem(1,'ddia_sub_trans', is_stran)
					dw_3.setitem(1,'ddia_banco_cuenta','1')					
					ls_naturaleza = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_movimiento')
					dw_3.setitem(1,'naturaleza',ls_naturaleza)	
					dw_3.setitem(1,'ddia_linea',1)
					dw_3.setitem(1,'tipo','P')					
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
			else
				dw_3.visible = false
			end if //Si es historica

		end if
			
			//Si es PAGO DEL PROVEEDOR O NOTA DE CREDITO
			if is_tran = 'PA' or is_tran = 'NP' then
				//documentos aplicados
				if	dw_6.retrieve(str.g_financiero, str.empresa, ls_tran, is_stran, ls_doc, ls_referencia, ii_ann, ll_tercero) > 0 then
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
								dw_5.setitem(li_registro,'aplicar',1)
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
					dw_5.dataobject = 'dw_documentos_por_aplicar_cp' //DW de solo lo pendiente
					dw_5.settransobject(sqlca)
					//documentos Debitos del Cliente
					dw_5.retrieve(str.g_financiero, str.empresa, ll_tercero)
				end if // del retreive del dw_5, documentos del cliente
			end if
			
			//this.setcolumn('movi_documento')

	case	'movi_referencia'
		if ii_historico = 0 then
			dw_3.setitem(1,'ddia_no_referencia', data)
		end if
end choose
end event

event dw_1::buttonclicked;call super::buttonclicked;	String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error, ls_tran, ls_codigo, ls_codigo2
	integer li_c, li_b
	long    ll_lter
	Datawindow        dww
	str_dg_dynamic_find	lstr_df
	str_transaccion_facturas lstr_facturas
	
if dwo.name = 'b_facturas' then

	lstr_facturas.transaccion = is_tran
	lstr_facturas.subtransaccion = is_stran
	lstr_facturas.banco = 10
	lstr_facturas.cuenta = '10'
	lstr_facturas.documento = is_doc_anterior
	lstr_facturas.ann = ii_ann_anterior
	lstr_facturas.aplicacion = 'CP'
	lstr_facturas.monto = dw_1.getitemnumber(1,'movi_monto_final')
	lstr_facturas.fecha = dw_1.getitemdatetime(1,'movi_fecha_tran')
	
	openwithparm(w_capturas_facturas_pat, lstr_facturas)
elseif dwo.name = 'b_buscar' then
		//Busqueda del producto
	//	
	ls_tran = this.getitemstring(1,'movi_tipo_transaccion')
	
	if ls_tran = '' or isnull(ls_tran) then
		gf_mensaje('','Seleccione una Transaccion para buscar Documentos',1,1,'E')
		return
	end if
	
	
		lstr_df.texto_campo [1,1] = "cptmovim.movi_documento"
		lstr_df.texto_campo [1,2] = "Documento"
		lstr_df.texto_campo [1,3] = "movi_documento"
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '390'	
		lstr_df.texto_campo [2,1] = "cptmovim.movi_a_nombre"
		lstr_df.texto_campo [2,2] = "A Nombre de"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '870'
		lstr_df.texto_campo [3,1] = "cptmovim.movi_fecha_tran"
		lstr_df.texto_campo [3,2] = "Fecha"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [3,5] = '300'
		lstr_df.texto_campo [4,1] = "cptmovim.movi_referencia"
		lstr_df.texto_campo [4,2] = "Referencia"
		lstr_df.texto_campo [4,3] = "movi_referencia"
		lstr_df.texto_campo [4,4] = 'V'		
		lstr_df.texto_campo [5,1] = "cptmovim.movi_monto_final"
		lstr_df.texto_campo [5,2] = "Monto"
		lstr_df.texto_campo [5,3] = ""
		lstr_df.texto_campo [5,4] = 'V'
		lstr_df.texto_campo [5,5] = '300'
		
		lstr_df.tabla = " cptmovim "
			
		lstr_df.tabla_where = &
					"WHERE (cptmovim.movi_g_financiero = " + string(str.g_financiero) + ") and " +&
							 "(cptmovim.movi_empresa = " + string(str.empresa) + ") and " +&
							 "(cptmovim.movi_tipo_transaccion = '"+ls_tran+"') and " +&
 							 "(cptmovim.movi_anno = "+string(ii_ann)+") and ( movi_aplicacion = 'CP' ) and " +&
							 "(cptmovim.movi_tipo_transaccion + movi_sub_transaccion <> 'NC9') "
							 
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	
	If len (ls_find) = 0 Then Return
		
	ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	ls_codigo2 =  mid(ls_codigo,1,pos(ls_codigo,' And'))
	gf_replace_cadena(ls_codigo2,"'"," ")
	ls_codigo2 = Trim(ls_codigo2)
	this.setitem(1,'movi_documento',ls_codigo2)

	ls_codigo =  String(Right ( ls_codigo, Len (ls_codigo) - Pos (ls_codigo, "=") ))
	gf_replace_cadena(ls_codigo,"'"," ")
	ls_codigo = Trim(ls_codigo)
	this.setitem(1,'movi_referencia',ls_codigo)
	
	this.setcolumn('movi_documento')
	this.accepttext()
	this.trigger event itemchanged(1, object, ls_codigo2)
	
elseif dwo.name = 'b_buscar_cliente' then
			
		lstr_df.texto_campo [2,1] = "cpmprove.prov_cod_proveedor" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [2,2] = "Cuenta"
		lstr_df.texto_campo [2,3] = "prov_cod_proveedor"
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '350'
		lstr_df.texto_campo [1,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [1,2] = "Descripción"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '700'		
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
	integer li_c, li_b
	long    ll_lter
	Datawindow        dww
	str_dg_dynamic_find	lstr_df

if this.getcolumnname() = 'movi_documento' then
		//Busqueda del producto
	//	
	ls_tran = this.getitemstring(1,'movi_tipo_transaccion')
	
	if ls_tran = '' or isnull(ls_tran) then
		gf_mensaje('','Seleccione una Transaccion para buscar Documentos',1,1,'E')
		return
	end if
	
	
		lstr_df.texto_campo [1,1] = "cptmovim.movi_documento"
		lstr_df.texto_campo [1,2] = "Documento"
		lstr_df.texto_campo [1,3] = "movi_documento"
		lstr_df.texto_campo [1,4] = 'V'
	//	lstr_df.texto_campo [1,5] = '280'	
		lstr_df.texto_campo [2,1] = "cptmovim.movi_a_nombre"
		lstr_df.texto_campo [2,2] = "A Nombre de"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '770'
		lstr_df.texto_campo [3,1] = "cptmovim.movi_fecha_tran"
		lstr_df.texto_campo [3,2] = "Fecha"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [3,5] = '285'
		lstr_df.tabla = " cptmovim "
			
		lstr_df.tabla_where = &
					"WHERE (cptmovim.movi_g_financiero = " + string(str.g_financiero) + ") and " +&
							 "(cptmovim.movi_empresa = " + string(str.empresa) + ") and " +&
							 "(cptmovim.movi_tipo_transaccion = '"+ls_tran+"') and " +&
							 "(cptmovim.movi_tipo_transaccion + movi_sub_transaccion <> 'NC9') "
							 
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
			
		lstr_df.texto_campo [2,1] = "cpmprove.prov_cod_proveedor" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [2,2] = "Cuenta"
		lstr_df.texto_campo [2,3] = "prov_cod_proveedor"
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '350'
		lstr_df.texto_campo [1,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [1,2] = "Descripción"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '700'		
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

	dw_1.setitem(1,'movi_ruc_tercero',ls_codigo1)
	dw_1.accepttext()
	dw_1.setcolumn('movi_ruc_tercero')
	dw_1.trigger event itemchanged(1,object,ls_codigo1)
	
end if
end event

event dw_1::ue_tabfinal;//override
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

type st_ayuda from w_fa_padre`st_ayuda within w_transacciones_cxp
end type

type dw_2 from datawindow within w_transacciones_cxp
boolean visible = false
integer x = 87
integer y = 12
integer width = 3232
integer height = 1388
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Imprimir Comprobante"
string dataobject = "dw_imprimir_cxp"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "AppIcon!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_transacciones_cxp
integer x = 2743
integer y = 540
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

event clicked;long ll_tercero
date fecha, fecha1
	ll_tercero = dw_1.getitemnumber(1,'movi_tercero')
	fecha	= relativedate(date(gf_fecha_serv()), - 365)
//	fecha = date('01/01/'+string(year(date(gf_fecha_serv()))))
	fecha1 = date(gf_fecha_serv())
		
	str_rangofecha str_formato1		
	str_formato1.codigo = ll_tercero
	str_formato1.fecha1  = fecha
	str_formato1.fecha2  = fecha1
	Opensheetwithparm(w_estadocuenta_imp_cxp,str_formato1,str.frame,2,layered!)
end event

type cb_2 from commandbutton within w_transacciones_cxp
integer x = 2743
integer y = 656
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
	OpenSheetwithparm(w_mant_proveedores,str_formato1,parent,2, Original!)
end event

type cb_3 from commandbutton within w_transacciones_cxp
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

event clicked;string ls_documento, ls_comentario
decimal {2} ld_monto
datetime ldt_fecha

ls_documento = dw_1.getitemstring(1,'movi_documento')
if ls_documento = '' or isnull(ls_documento) then return

if dw_1.getitemstring(1,'movi_estado') = 'AN' then 
	gf_mensaje('','La transaccion ya fue anulada, verifique !!!',1,1,'E')
	return
end if

if gf_mensaje('','Esta seguro de Anular la Transacción ?',2,1,'Q') = 1 then
	ld_monto = dw_1.getitemnumber(1,'movi_monto_final')
	ls_comentario = 'TRANSACCION ANULADA, VALOR '+string(ld_monto,'$ ###,##0.00')+ ' - ' +dw_1.getitemstring(1, 'movi_comentario')
	ldt_fecha = gf_fecha_serv()
	
	update cptmovim
	set   cptmovim.movi_monto = 0, cptmovim.movi_itbm = 0, cptmovim.movi_monto_final = 0,  
         cptmovim.movi_estado = 'AN',   
         cptmovim.movi_comentario = :ls_comentario,
			cptmovim.movi_fecha_anul = :ldt_fecha,
			cptmovim.movi_usuario_anul = :str.usuario
   WHERE ( cptmovim.movi_g_financiero = :str.g_financiero ) AND  
         ( cptmovim.movi_empresa = :str.empresa ) AND  
         ( cptmovim.movi_aplicacion = 'CP' ) AND  
         ( cptmovim.movi_tipo_transaccion = :is_tran ) AND  
         ( cptmovim.movi_documento = :ls_documento ) AND  
         ( cptmovim.movi_anno = :ii_ann ) AND  
         ( cptmovim.movi_tipo_transaccion+cptmovim.movi_sub_transaccion <> 'NC9' );
			
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Anular la transaccion '+sqlca.sqlerrtext,1,1,'E')			
			rollback ;
		end if
		commit ;
		dw_1.setfocus()
		dw_1.setcolumn('movi_documento')
		dw_1.triggerevent('itemchanged')
end if
end event

type pb_1 from picturebutton within w_transacciones_cxp
integer x = 3067
integer y = 784
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
ll_tercero = dw_1.getitemnumber(1,'movi_tercero')
str_cc_formatos str_formato2		
str_formato2.tercero = ll_tercero
if ll_tercero > 0 then
	Opensheetwithparm(w_notas,str_formato2,str.frame,2,original!)
end if

end event

type st_1 from statictext within w_transacciones_cxp
integer x = 2775
integer y = 788
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

type dw_3 from datawindow within w_transacciones_cxp
event ue_helpcol pbm_dwnkey
event ue_enter pbm_dwnprocessenter
integer x = 87
integer y = 1472
integer width = 4334
integer height = 656
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

event ue_enter;Send(Handle(this),256,9,Long(0,0)) 
return 1 
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
		dw_3.setitem(dw_3.getrow(),'ddia_aplicacion_mg','CP')
//		dw_3.setitem(dw_3.getrow(),'ddia_ann', ii_ann) //year(date(gf_fecha_serv())))
		dw_3.setitem(dw_3.getrow(),'ddia_id', str.usuario)
		dw_3.setitem(dw_3.getrow(),'ddia_tipo_transaccion', is_tran)
		dw_3.setitem(dw_3.getrow(),'ddia_sub_trans', is_stran)
		dw_3.setitem(dw_3.getrow(),'naturaleza','D')	
		dw_3.setitem(dw_3.getrow(),'ddia_linea',dw_3.getrow())
		dw_3.setitem(dw_3.getrow(),'tipo','I')
		dw_3.setitem(dw_3.getrow(),'ddia_ann',ii_ann)
		dw_3.setitem(dw_3.getrow(),'ddia_no_documento',dw_1.getitemstring(1,'movi_documento'))
		dw_3.setitem(dw_3.getrow(),'ddia_no_referencia',dw_1.getitemstring(1,'movi_referencia'))
		this.setcolumn('tipo')
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
long ll_class, ll_tercero, ll_pos
ls_columna = this.getcolumnname()

choose case ls_columna
	case 'monto_debito'
			this.setitem(row,'monto_credito',0)
			this.setitem(row,'naturaleza','D')
			if double(data) < 0 then
				gf_mensaje('','No se permiten valores en negativo, Verifique !!!',1,1,'E')
				this.setcolumn('monto_debito')
				this.setitem(row,'monto_debito', abs(double(data)))
				return 2
			end if						
	case 'monto_credito'
			this.setitem(row,'monto_debito',0)
			this.setitem(row,'naturaleza','C')		
			if double(data) < 0 then
				gf_mensaje('','No se permiten valores en negativo, Verifique !!!',1,1,'E')
				this.setcolumn('monto_credito')
				this.setitem(row,'monto_credito', abs(double(data)))
				return 2
			end if						
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
		ls_transito = this.getitemstring(this.getrow(),'ddia_transito')
		this.setitem(row,'ddia_cargado_a','C')
		if len(ls_transito) < 12 then
			ls_transito = wf_transito(ls_transito)	
			this.setitem(row,'ddia_transito',ls_transito)			
			this.setitem(row,'cuenta',is_cta_barco)
			this.setitem(row,'ddia_mg_cuenta',is_cta_barco)			
			accepttext() 
			return 2
		end if
		this.setitem(row,'cuenta',is_cta_barco)
		this.setitem(row,'ddia_mg_cuenta',is_cta_barco)			
		
		this.setcolumn('ddia_class')
		
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
		
	case 'ddia_tercero'
		ll_tercero = long(data)
		    SELECT cpmprove.prov_mg_cuenta  
				 INTO :ls_cuenta 
				 FROM cpmprove  
				WHERE ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
						( cpmprove.prov_empresa = :str.empresa ) AND  
						( cpmprove.prov_tercero = :ll_tercero )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al buscar codigo '+sqlca.sqlerrtext,1,1,'E')	
				elseif sqlca.sqlcode = 100 then
					gf_mensaje('','Proveedor no existe, Verifique !!!',1,1,'E')
					this.setitem(this.getrow(),'ddia_tercero',0)
					this.setitem(this.getrow(),'cuenta','')
					this.setitem(this.getrow(),'ddia_mg_cuenta','')
				else
					this.setitem(this.getrow(),'cuenta',ls_cuenta)
					this.setitem(this.getrow(),'ddia_mg_cuenta',ls_cuenta)
				end if				
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
	case 'ddia_transito'
		ls_transito = wf_buscar_transito()
		this.setitem(row,'ddia_transito',ls_transito)
		dw_3.trigger event itemchanged(dw_3.getrow(),object,ls_transito)	
	case 'ddia_class'
		ls_class = wf_busca_class()
		this.setitem(row,'ddia_class',ls_class)
		dw_3.trigger event itemchanged(dw_3.getrow(),object,ls_class)			
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

type dw_4 from datawindow within w_transacciones_cxp
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

type dw_5 from datawindow within w_transacciones_cxp
boolean visible = false
integer x = 142
integer y = 964
integer width = 2665
integer height = 488
integer taborder = 41
boolean bringtotop = true
string title = "none"
string dataobject = "dw_documentos_por_aplicar_cp"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;string ls_objeto
integer li_pos
this.accepttext()
dw_1.accepttext()
ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

//if ls_objeto = "aplicar_t" then
//	
////	if row = 0 then return
//	
//		//Asigna el pago a los movimientos debitos
//		wf_asigna_pagos()
//	
if ls_objeto = 'aplicar' then
		integer li_aplicar
		decimal{2} ld_monto, ld_saldo, ld_total_aplicado
		boolean lb_no_asignar = false
		ld_monto = dw_1.getitemnumber(1,'movi_monto')
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

event doubleclicked;//string ls_documento, ls_referencia, ls_tipo, ls_aplicacion, ls_liberado
//integer li_ann
//long ll_tercero
//
//if gf_mensaje('','Esta Seguro de Liberar el Documento ?',2,1,'Q') = 2 then return 
//
//ls_documento = this.getitemstring(row, 'movi_documento')
//ls_referencia  = this.getitemstring(row, 'movi_referencia')
//ls_tipo  = this.getitemstring(row, 'movi_tipo_transaccion')
//ls_aplicacion  = this.getitemstring(row, 'movi_aplicacion')
//li_ann   = this.getitemnumber(row, 'movi_anno')
//ll_tercero = dw_1.getitemnumber(1,'movi_tercero')
//
//ls_liberado = str.usuario +' '+string(gf_fecha_serv())
//
//  UPDATE cptmovim  
//     SET  movi_saldo = 0,   
//	  	    movi_monto_aplicado = movi_monto_final,
//	  	    movi_liberado_por = :ls_liberado
//   WHERE ( cptmovim.movi_g_financiero = :str.g_financiero ) AND  
//         ( cptmovim.movi_empresa = :str.empresa ) AND  
//         ( cptmovim.movi_aplicacion = :ls_aplicacion ) AND  
//         ( cptmovim.movi_tipo_transaccion = :ls_tipo ) AND  
//         ( cptmovim.movi_documento = :ls_documento ) AND  
//         ( cptmovim.movi_anno = :li_ann )   ;
//	if sqlca.sqlcode = -1 then
//		gf_mensaje('','Error al actualizar saldos '+sqlca.sqlerrtext,1,1,'E')
//		return
//	end if
//
//	dw_5.retrieve(str.g_financiero, str.empresa, ll_tercero)
end event

event itemchanged;decimal{2} ld_monto_aplica, ld_monto, ld_monto_total, ld_saldo, ld_pendiente

accepttext()

choose case this.getcolumnname()
	case 'monto_aplica'
		ld_monto 		 = dw_1.getitemnumber(1,'movi_monto')		//monto del recibo
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

type dw_6 from datawindow within w_transacciones_cxp
boolean visible = false
integer x = 2880
integer y = 1044
integer width = 1499
integer height = 364
integer taborder = 61
boolean bringtotop = true
string title = "none"
string dataobject = "dw_documentos_aplicados_rep_cp"
boolean border = false
boolean livescroll = true
end type

type uo_1 from u_ddcalen within w_transacciones_cxp
boolean visible = false
integer x = 1440
integer y = 332
integer taborder = 11
boolean bringtotop = true
end type

on uo_1.destroy
call u_ddcalen::destroy
end on

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;dw_1.SetItem ( dw_1.getrow(), 'movi_fecha_tran', uo_1.return_sel_date() )

if uo_1.allow_close then
	this.visible=false
	dw_1.SetFocus()

		datetime ldt_fecha_tran 	, ldt_fecha_anterior
		integer li_ann_anterior 
		
		dw_1.accepttext()
		ldt_fecha_tran 	 = dw_1.getitemdatetime(dw_1.getrow(),'movi_fecha_tran')		
		ldt_fecha_anterior = dw_1.getitemdatetime(dw_1.getrow(),'movi_fecha_tran', Primary!, True)		
		li_ann_anterior = dw_1.getitemnumber(1,'movi_anno')
				
		if not gf_valida_fecha_conta(ldt_fecha_anterior) then		
			if ldt_fecha_anterior = ldt_fecha_tran then
				dw_1.setitem(1,'movi_fecha_tran', date(gf_fecha_serv()))
			else
				dw_1.setitem(1,'movi_fecha_tran', ldt_fecha_anterior)
			end if
			dw_1.setcolumn('movi_fecha_tran')
			return
		end if

		if not gf_valida_fecha_conta(ldt_fecha_tran) then			
			if ldt_fecha_anterior = ldt_fecha_tran then
				dw_1.setitem(1,'movi_fecha_tran', date(gf_fecha_serv()))
			else
				dw_1.setitem(1,'movi_fecha_tran', ldt_fecha_anterior)
			end if
			dw_1.setcolumn('movi_fecha_tran')
			return
		end if				

		ii_ann = year(date(dw_1.getitemdatetime(dw_1.getrow(),'movi_fecha_tran')))
		//Si los anios son diferentes asigna el anio
		if ii_ann <> li_ann_anterior then
			dw_1.setitem(1,'movi_anno',ii_ann)
		end if		
end if		
end event

type uo_2 from u_ddcalen within w_transacciones_cxp
boolean visible = false
integer x = 2894
integer y = 332
integer taborder = 21
boolean bringtotop = true
end type

on uo_2.destroy
call u_ddcalen::destroy
end on

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;dw_1.SetItem ( dw_1.getrow(), 'movi_fecha_vence', uo_2.return_sel_date() )

if uo_2.allow_close then
	this.visible=false
	dw_1.SetFocus()
end if


end event

type dw_7 from datawindow within w_transacciones_cxp
boolean visible = false
integer x = 3781
integer y = 1492
integer width = 571
integer height = 600
integer taborder = 51
boolean bringtotop = true
string title = "none"
string dataobject = "dw_detalle_contable"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

