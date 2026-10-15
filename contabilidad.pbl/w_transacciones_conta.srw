forward
global type w_transacciones_conta from w_fa_padre
end type
type dw_2 from datawindow within w_transacciones_conta
end type
type cb_1 from commandbutton within w_transacciones_conta
end type
type cb_2 from commandbutton within w_transacciones_conta
end type
type cb_3 from commandbutton within w_transacciones_conta
end type
type pb_1 from picturebutton within w_transacciones_conta
end type
type st_1 from statictext within w_transacciones_conta
end type
type dw_3 from datawindow within w_transacciones_conta
end type
type dw_4 from datawindow within w_transacciones_conta
end type
type uo_1 from u_ddcalen within w_transacciones_conta
end type
end forward

global type w_transacciones_conta from w_fa_padre
integer width = 4946
integer height = 2388
string title = "Captura de Comprobantes"
string menuname = "m_hs"
boolean controlmenu = false
long backcolor = 8421376
windowanimationstyle openanimation = bottomslide!
windowanimationstyle closeanimation = bottomslide!
dw_2 dw_2
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
pb_1 pb_1
st_1 st_1
dw_3 dw_3
dw_4 dw_4
uo_1 uo_1
end type
global w_transacciones_conta w_transacciones_conta

type variables
datawindowchild idwc_clientes, idwc_tran, idwc_stran, idwc_plan, idwc_barco
string is_tran, is_stran, is_tran_automatica, is_cta_barco, is_doc_anterior, is_ref_anterior
integer ii_ann, ii_ann_anterior, ii_cont_doc, ii_historico
string is_arreglo[26]					 

end variables

forward prototypes
public function string wf_buscar_cuenta_contable ()
public function long wf_buscar_proveedor ()
public function long wf_buscar_cliente ()
public function string wf_transito (string as_transito)
public function string wf_buscar_transito ()
public function string wf_busca_class ()
public function boolean wf_registra_asiento ()
public function string wf_secuencia_tran ()
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

public function boolean wf_registra_asiento ();integer li_existe
string ls_documento, ls_referencia, ls_descrip, ls_nombre
decimal{2} ld_monto
datetime ldt_fecha, ldt_fecha_creacion

ls_documento = dw_1.getitemstring(1,'diar_no_documento')
ls_referencia= dw_1.getitemstring(1,'diar_no_referencia')

if is_doc_anterior <> ls_documento or is_ref_anterior <> ls_referencia or ii_ann <> ii_ann_anterior then
  
  if is_doc_anterior = '' or is_ref_anterior = '' or ii_ann_anterior = 0 then return true
  
  dw_4.reset()
  dw_3.RowsCopy(1, dw_3.RowCount(), Primary!, dw_4, 1, Primary!)
  dw_3.reset()
  dw_4.RowsCopy(1, dw_4.RowCount(), Primary!, dw_3, 1, Primary!)
	
  DELETE FROM coddiari  
   WHERE ( coddiari.ddia_g_financiero = :str.g_financiero ) AND  
         ( coddiari.ddia_empresa = :str.empresa ) AND  
         ( coddiari.ddia_aplicacion_mg = 'CO' ) AND  
         ( coddiari.ddia_tipo_transaccion = :is_tran ) AND  
         ( coddiari.ddia_sub_trans = :is_stran ) AND  
         ( coddiari.ddia_no_documento = :is_doc_anterior ) AND  
         ( coddiari.ddia_no_referencia = :is_ref_anterior ) AND  
         ( coddiari.ddia_ann = :ii_ann_anterior ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Eliminar Detalle del Asiento '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return false
		end if


end if // de la eliminacion, si la llave es diferente		

return true
end function

public function string wf_secuencia_tran ();string ls_sec
long ll_max
integer li_existe, li_ann

li_ann = dw_1.getitemnumber(1,'diar_ann')

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
		from cotdiari
		where diar_g_financiero = :str.g_financiero and
				diar_empresa		= :str.empresa and
				diar_tipo_transaccion = :is_tran and
//				diar_sub_trans = :is_stran and
				diar_no_documento 	=  :ls_sec and
				diar_ann			=  :li_ann ;
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

on w_transacciones_conta.create
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
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.dw_4
this.Control[iCurrent+9]=this.uo_1
end on

on w_transacciones_conta.destroy
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
destroy(this.uo_1)
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

dw_1.getchild('diar_tipo_transaccion', idwc_tran)
idwc_tran.settransobject(sqlca)
idwc_tran.retrieve(str.g_financiero, str.empresa)

dw_1.getchild('diar_sub_trans', idwc_stran)
idwc_stran.settransobject(sqlca)
idwc_stran.retrieve(str.g_financiero, str.empresa)

dw_3.getchild('ddia_mg_cuenta', idwc_plan)
idwc_plan.settransobject(sqlca)
idwc_plan.retrieve(str.g_financiero, str.empresa)
idwc_plan.insertrow(1)

dw_3.getchild('ddia_transito_1', idwc_barco)
idwc_barco.settransobject(sqlca)
if idwc_barco.retrieve(str.g_financiero, str.empresa) = 0 then
	idwc_barco.insertrow(1)
end if

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
	dw_1.setitem(1,'diar_tipo_transaccion',is_tran)
	is_tran_automatica = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_sec_auto')
	if is_tran_automatica = 'S' then
		dw_1.Modify("diar_no_documento.Edit.DisplayOnly=Yes")
	else
		dw_1.Modify("diar_no_documento.Edit.DisplayOnly=No")
	end if
	dw_1.setitem(1,'diar_sub_trans',is_stran)
	dw_1.setitem(1,'diar_ann',li_ann)	
	ii_ann = li_ann
	dw_1.setitem(1,'diar_no_documento',ls_documento)
	dw_1.setcolumn('diar_no_documento')
	dw_1.accepttext()
	dw_1.trigger event itemchanged(1, dw_1.object, ls_documento)	
else
	ii_ann = year(date(gf_fecha_serv()))
	dw_1.setitem(1,'diar_fecha_transaccion', date(gf_fecha_serv()))
	dw_1.setitem(1,'diar_ann',year(date(gf_fecha_serv())))	
	dw_1.setitem(1,'diar_g_financiero',str.g_financiero)
	dw_1.setitem(1,'diar_empresa',str.empresa)
	dw_1.setitem(1,'diar_aplicacion_mg','CO')
	dw_1.setitem(1,'diar_ann', ii_ann)
	dw_1.setitem(1,'diar_id', str.usuario)
end if

ii_historico = 0

is_arreglo[1] = 'A'; is_arreglo[2] = 'B'; is_arreglo[3] = 'C'; is_arreglo[4] = 'D'; is_arreglo[5] = 'E'
is_arreglo[6] = 'F'; is_arreglo[7] = 'G'; is_arreglo[8] = 'H'; is_arreglo[9] = 'I'; is_arreglo[10] = 'J'
is_arreglo[11] = 'K'; is_arreglo[12] = 'L'; is_arreglo[13] = 'M'; is_arreglo[14] = 'N'; is_arreglo[15] = 'O'
is_arreglo[16] = 'P'; is_arreglo[17] = 'Q'; is_arreglo[18] = 'R'; is_arreglo[19] = 'S'; is_arreglo[20] = 'T'
is_arreglo[21] = 'U'; is_arreglo[22] = 'V'; is_arreglo[23] = 'W'; is_arreglo[24] = 'X'; is_arreglo[25] = 'Y'
is_arreglo[26] = 'Z'

dw_1.Modify("calendario.Filename='"+str.path+"Art\ddfec.bmp'")

dw_1.setitemstatus(1,0,primary!,NotModified!) 
end event

event ue_aceptar;//override
long ll_update, ll_doc
integer li_ann, i
window lw_ventana
string ls_titulo, ls_doc, ls_tipo, ls_ref, ls_cuenta, ls_descrip
decimal{2} ldec_saldo, ld_monto, ld_monto_detalle
datetime ldt_fecha_tran

//lw_ventana = this.getactivesheet()
//ls_titulo = lw_ventana.title
ls_descrip	 = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_descripcion')
dw_1.setitem(1,'diar_descripcion',ls_descrip)

dw_1.accepttext()
dw_3.accepttext()
li_ann = ii_ann
dw_1.setitem(1,'diar_ann',ii_ann)
ls_doc = dw_1.getitemstring(dw_1.getrow(), 'diar_no_documento')
if ls_doc = '' or isnull(ls_doc) then
	gf_mensaje('','Debe digitar el documento antes de guardar, Verifique !!!',1,1,'E')
	dw_1.setcolumn('diar_no_documento')
	return
end if
ls_ref = dw_1.getitemstring(dw_1.getrow(), 'diar_no_referencia')
if ls_ref = '' or isnull(ls_ref) then
	gf_mensaje('','Debe digitar la referencia antes de guardar, Verifique !!!',1,1,'E')
	dw_1.setcolumn('diar_no_referencia')
	return
end if

if dw_1.getitemNumber(dw_1.getrow(), 'diar_monto') = 0 or isnull(dw_1.getitemNumber(dw_1.getrow(),'diar_monto')) then
	gf_mensaje('','Debe asignar el valor de la transaccion antes de guardar, Verifique !!!',1,1,'E')
	dw_1.setcolumn('diar_monto')
	return
end if

//valida q este en balance
if dw_3.getitemnumber(1,'balance') <> 0 then
	gf_mensaje('','Debe Balancear la Transaccion para Guardar, Verifique !!!',1,1,'E')
	return
end if

if dw_3.getitemnumber(1,'monto_debito') + dw_3.getitemnumber(1,'monto_credito') = 0 then
	gf_mensaje('','Existen Valores en 0 en el Detalle Contable, Verifique !!!',1,1,'E')
	return
end if

ld_monto = dw_1.getitemnumber(dw_1.getrow(), 'diar_monto')
ld_monto_detalle = dw_3.getitemnumber(1, 'debito1')
if ld_monto <> ld_monto_detalle then
	gf_mensaje('','El Valor del Encabezado es Diferente al Detalle Contable, Verifique !!!',1,1,'E')
	dw_1.setcolumn('diar_monto')
	dw_1.setfocus()
	return
end if

//valida fecha contable
ldt_fecha_tran = dw_1.getitemdatetime(1,'diar_fecha_transaccion')
if not gf_valida_fecha_conta(ldt_fecha_tran) then
	return
end if


sqlca.autocommit = false

if not wf_registra_asiento() then
	rollback ;
	sqlca.autocommit = true
	return
end if

ll_update=dw_1.update()

if ll_update = 1  then
	
	//Activar si da bateria
//  DELETE FROM coddiari  
//   WHERE ( coddiari.ddia_g_financiero = :str.g_financiero ) AND  
//         ( coddiari.ddia_empresa = :str.empresa ) AND  
//         ( coddiari.ddia_aplicacion_mg = 'CO' ) AND  
//         ( coddiari.ddia_tipo_transaccion = :ls_tran ) AND  
//         ( coddiari.ddia_sub_trans = :is_stran ) AND  
//         ( coddiari.ddia_no_documento = :is_doc_anterior ) AND  
//         ( coddiari.ddia_no_referencia = :is_ref_anterior ) AND  
//         ( coddiari.ddia_ann = :ii_ann_anterior ) ;
//		if sqlca.sqlcode = -1 then
//			gf_mensaje('','Error al Eliminar Encabezado del Asiento '+sqlca.sqlerrtext,1,1,'E')
//			rollback;
//		end if
	
	//guarda el asiento contable
			for i = 1 to dw_3.rowcount()
				dw_3.setitem(i,'ddia_linea',i)
				if dw_3.getitemstring(i,'naturaleza') = 'D' then
					dw_3.setitem(i,'ddia_monto',dw_3.getitemnumber(i,'monto_debito'))
				else
					dw_3.setitem(i,'ddia_monto',dw_3.getitemnumber(i,'monto_credito'))
				end if
				dw_3.setitem(i,'ddia_no_documento',dw_1.getitemstring(1,'diar_no_documento'))
				dw_3.setitem(i,'ddia_no_referencia',dw_1.getitemstring(1,'diar_no_referencia'))
				dw_3.setitem(i,'ddia_ann',ii_ann)								
				ls_cuenta = dw_3.getitemstring(i,'ddia_mg_cuenta')
				if isnull(ls_cuenta) or ls_cuenta = '' then
					gf_mensaje('','Debe asignar una cuenta valida, verfique !!!',1,1,'E')
					rollback ;
					sqlca.autocommit = true
					dw_3.setfocus()
					dw_3.scrolltorow(i)
					dw_3.setcolumn('ddia_mg_cuenta')
					return					
				end if
			next
			
			if dw_3.update() = -1 then
				gf_mensaje('','Error al guardar detalle contable '+sqlca.sqlerrtext,1,1,'E')
				rollback ;
				sqlca.autocommit = true
				return
			end if
	
	commit using sqlca;

		//Si la secuencia es automatica, graba en la tabla de transacciones
		is_tran_automatica = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_sec_auto')
		if is_tran_automatica = 'S' then			
			ll_doc = long(dw_1.getitemstring(1,'diar_no_documento'))			
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
		if dw_1.getitemstring(1,'diar_impreso') = 'N' or isnull(dw_1.getitemstring(1,'diar_impreso')) then
			this.triggerevent('ue_print')
			update cotdiari set diar_impreso = 'S'
			where diar_g_financiero = :str.g_financiero and
					diar_empresa		= :str.empresa	and
					diar_aplicacion_mg	= 'CO' and
					diar_tipo_transaccion = :is_tran and
					diar_sub_trans			 = :is_stran and
					diar_no_documento	 = :ls_doc and
					diar_no_referencia	 = :ls_ref and
					diar_ann					 = :li_ann ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al actualizar el estado de impreso '+sqlca.sqlerrtext,1,1,'E')
						rollback;
					end if
					dw_1.setitem(1,'diar_impreso','S')
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
string ls_tran, ls_subt, ls_naturaleza, ls_doc
datetime ldt_fecha_actual, ldt_fecha_consultada

ldt_fecha_actual = datetime(date(gf_fecha_serv()),00:00:00)
ldt_fecha_consultada = dw_1.getitemdatetime(1,'diar_fecha_transaccion')

if year(date(ldt_fecha_consultada)) <> year(date(ldt_fecha_actual)) then
	if abs(year(date(ldt_fecha_consultada)) - year(date(ldt_fecha_actual))) = 1	 then //Si esta adicionando en el año anterior
		if gf_mensaje('','Desea Adicionar Transacción en el año '+string(year(date(ldt_fecha_consultada)))+' ?',2,1,'Q') = 1 then
			if gf_valida_fecha_conta(ldt_fecha_consultada) then			
				ldt_fecha_actual = ldt_fecha_consultada
			end if				
		end if
	end if
end if

if dw_1.rowcount() > 0 then
	dw_1.reset()	
end if
is_doc_anterior = ''
is_ref_anterior = ''
ii_ann_anterior = 0

dw_1.insertrow(1)
dw_1.setitem(1,'diar_fecha_transaccion', date(ldt_fecha_actual))
dw_1.setitem(1,'diar_g_financiero',str.g_financiero)
dw_1.setitem(1,'diar_empresa',str.empresa)
dw_1.setitem(1,'diar_aplicacion_mg','CO')
dw_1.setitem(1,'diar_ann', year(date(ldt_fecha_actual)))
ii_ann = year(date(ldt_fecha_actual))
dw_1.setitem(1,'diar_id', str.usuario)
dw_1.setitem(1,'diar_tipo_transaccion', is_tran)
dw_1.setitem(1,'diar_sub_trans', is_stran)
ls_naturaleza = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_movimiento')
//dw_1.setitem(1,'movi_naturaleza',ls_naturaleza)	
//dw_1.setitem(1,'movi_historico',ii_historico)
//adiciona en dw contable
	dw_3.reset()
	dw_3.insertrow(1)
	dw_3.setitem(1,'ddia_fecha', date(gf_fecha_serv()))
	dw_3.setitem(1,'ddia_g_financiero',str.g_financiero)
	dw_3.setitem(1,'ddia_empresa',str.empresa)
	dw_3.setitem(1,'ddia_aplicacion_mg','CO')
	dw_3.setitem(1,'ddia_ann', ii_ann)
	dw_3.setitem(1,'ddia_id', str.usuario)
	dw_3.setitem(1,'ddia_tipo_transaccion', is_tran)
	dw_3.setitem(1,'ddia_sub_trans', is_stran)
	dw_3.setitem(1,'naturaleza',ls_naturaleza)	
	dw_3.setitem(1,'ddia_linea',1)
	dw_3.setitem(1,'tipo','I')
//
is_tran_automatica = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_sec_auto')
if is_tran_automatica = 'S' then
	dw_1.Modify("diar_no_documento.Edit.DisplayOnly=Yes")			
	ls_doc = wf_secuencia_tran()			
	dw_1.setitem(1,'diar_no_documento', ls_doc)
else
	dw_1.Modify("diar_no_documento.Edit.DisplayOnly=No")
	dw_1.setitem(1,'diar_no_documento','')
end if		
dw_1.setcolumn('diar_no_documento')
dw_1.setfocus()
//dw_1.Modify("movi_comentario.Edit.DisplayOnly=No")
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

ls_tran = dw_1.getitemstring(1,'diar_tipo_transaccion')

dw_2.settransobject(sqlca)

ls_doc  = dw_1.getitemstring(1,'diar_no_documento')
ls_referencia  = dw_1.getitemstring(1,'diar_no_referencia')
li_ann  = dw_1.getitemnumber(1,'diar_ann')

if dw_2.retrieve(str.g_financiero, str.empresa,ls_tran, ls_doc, li_ann, 'CO', ls_referencia) > 0 then
	ls_dinero =  upper(gf_numerlet(dw_1.getitemnumber(1,'diar_monto'),1))
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
datetime ldt_fecha_tran
string ls_tran
this.setredraw(false)
if dw_1.rowcount() > 0 then
	
	ls_tran = is_tran
	
	//valida fecha contable
	ldt_fecha_tran = dw_1.getitemdatetime(1,'diar_fecha_transaccion')
	if not gf_valida_fecha_conta(ldt_fecha_tran) then
		sqlca.autocommit = true
		this.setredraw(true)
		return
	end if

	
	if gf_mensaje('','Esta seguro de eliminar toda la transaccion ??',2,1,'E') = 2 then 
		this.setredraw(true)
		return		
	end if

	//dw_1.deleterow(dw_1.getrow())
	//if dw_1.update() = 1 then
		
  DELETE FROM coddiari  
   WHERE ( coddiari.ddia_g_financiero = :str.g_financiero ) AND  
         ( coddiari.ddia_empresa = :str.empresa ) AND  
         ( coddiari.ddia_aplicacion_mg = 'CO' ) AND  
         ( coddiari.ddia_tipo_transaccion = :ls_tran ) AND  
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
         ( cotdiari.diar_aplicacion_mg = 'CO' ) AND  
         ( cotdiari.diar_tipo_transaccion = :ls_tran ) AND  
         ( cotdiari.diar_sub_trans = :is_stran ) AND  
         ( cotdiari.diar_no_documento = :is_doc_anterior ) AND  
         ( cotdiari.diar_no_referencia = :is_ref_anterior ) AND  
         ( cotdiari.diar_ann = :ii_ann_anterior ) ;
		if sqlca.sqlcode = -1 then

			gf_mensaje('','Error al Eliminar Encabezado del Asiento '+sqlca.sqlerrtext,1,1,'E')
			rollback;
		end if
	
		commit;
		
		this.triggerevent('ue_adicionar')
	//end if
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

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_transacciones_conta
boolean visible = false
integer width = 73
integer height = 36
string text = ""
end type

type dw_1 from w_fa_padre`dw_1 within w_transacciones_conta
integer width = 4722
integer height = 936
string dataobject = "dw_transacciones_conta"
end type

event dw_1::itemchanged;call super::itemchanged;this.accepttext()
string ls_tran, ls_doc, ls_subt, ls_naturaleza, ls_cuenta, ls_proveedor, ls_referencia
integer li_ann, li_existe, i, li_ann_anterior
long    ll_tercero
decimal{2} ldec_saldo, ld_tarjeta, ld_porcentaje, ld_monto
datetime ldt_fecha_tran, ldt_fecha_anterior

choose case this.getcolumnname()
	case 'diar_ann'
		ii_ann = this.getitemnumber(1,'diar_ann')
	case 'diar_fecha_transaccion'
		
		ldt_fecha_tran 	 = this.getitemdatetime(this.getrow(),'diar_fecha_transaccion')		
		ldt_fecha_anterior = this.getitemdatetime(this.getrow(),'diar_fecha_transaccion', Primary!, True)		
		li_ann_anterior = dw_1.getitemnumber(1,'diar_ann')
		
		if not gf_valida_fecha_conta(ldt_fecha_anterior) then		
			if ldt_fecha_anterior = ldt_fecha_tran then
				dw_1.setitem(1,'diar_fecha_transaccion', date(gf_fecha_serv()))
			else
				dw_1.setitem(1,'diar_fecha_transaccion', ldt_fecha_anterior)
			end if
			dw_1.setcolumn('diar_fecha_transaccion')
			return 2
		end if

		if not gf_valida_fecha_conta(ldt_fecha_tran) then			
			if ldt_fecha_anterior = ldt_fecha_tran then
				dw_1.setitem(1,'diar_fecha_transaccion', date(gf_fecha_serv()))
			else
				dw_1.setitem(1,'diar_fecha_transaccion', ldt_fecha_anterior)
			end if
			dw_1.setcolumn('diar_fecha_transaccion')
			return 2
		end if				

		if not gf_valida_fecha_futura(ldt_fecha_tran) then			
			if ldt_fecha_tran = ldt_fecha_anterior then
				dw_1.setitem(1,'diar_fecha_transaccion', date(gf_fecha_serv()))				
			else
				dw_1.setitem(1,'diar_fecha_transaccion', ldt_fecha_anterior)
			end if
			dw_1.setcolumn('diar_fecha_transaccion')
			return 2
		end if
		
		ii_ann = year(date(this.getitemdatetime(this.getrow(),'diar_fecha_transaccion')))
		//Si los anios son diferentes asigna el anio
		if ii_ann <> li_ann_anterior then
			dw_1.setitem(1,'diar_ann',ii_ann)
		end if
	case 'diar_tipo_transaccion'		
		ls_tran = data
		is_tran = ls_tran
		idwc_stran.setfilter("dgmsubse_subs_transaccion = '"+ls_tran+"'")
		idwc_stran.filter()		
		this.setitem(1,'diar_tipo_transaccion',ls_tran)
		if idwc_stran.rowcount() > 0 then
			is_stran = idwc_stran.getitemstring(1,'dgmsubse_subs_sub_trans')
			dw_1.setitem(1,'diar_sub_trans',is_stran)
		end if	
		parent.triggerevent('ue_adicionar')
		ls_naturaleza = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_movimiento')
		is_tran_automatica = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_sec_auto')
		if is_tran_automatica = 'S' then
			dw_1.Modify("diar_no_documento.Edit.DisplayOnly=Yes")			
			ls_doc = wf_secuencia_tran()			
			dw_1.setitem(1,'diar_no_documento', ls_doc)
		else
			dw_1.Modify("diar_no_documento.Edit.DisplayOnly=No")
			dw_1.setitem(1,'diar_no_documento','')
		end if		
//		this.setitem(1,'movi_naturaleza',ls_naturaleza)
		this.setcolumn('diar_no_documento')		
	case 'diar_sub_trans'
		is_stran = data
		parent.triggerevent('ue_adicionar')
		ls_naturaleza = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_movimiento')
		is_tran_automatica = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_sec_auto')
		if is_tran_automatica = 'S' then
			dw_1.Modify("diar_no_documento.Edit.DisplayOnly=Yes")			
			ls_doc = wf_secuencia_tran()			
			dw_1.setitem(1,'diar_no_documento', ls_doc)
		else
			dw_1.Modify("diar_no_documento.Edit.DisplayOnly=No")
			dw_1.setitem(1,'diar_no_documento','')
		end if		
		this.setcolumn('diar_no_documento')		
		
	case 'diar_monto'
		this.setcolumn('diar_descripcion')
	case 'diar_no_documento'
		ls_doc = this.getitemstring(1,'diar_no_documento')
		ls_referencia = this.getitemstring(1,'diar_no_referencia')
		li_ann =  this.getitemNumber(1,'diar_ann')//year(date(gf_fecha_serv()))
		ls_tran = this.getitemstring(1,'diar_tipo_transaccion')
		ls_subt = this.getitemstring(1,'diar_sub_trans')			
		if	this.retrieve(str.g_financiero, str.empresa, ls_tran, ls_doc, li_ann, ls_referencia ) = 0 then
			parent.triggerevent('ue_adicionar')
			this.setitem(1,'diar_no_documento',ls_doc)
			this.setitem(1,'diar_tipo_transaccion',ls_tran)
			this.setitem(1,'diar_sub_trans',ls_subt)
			ls_naturaleza = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_movimiento')
//			this.setitem(1,'movi_naturaleza',ls_naturaleza)		
			this.setitem(1,'diar_no_referencia',ls_doc)		
			this.setcolumn('diar_no_documento')
			dw_3.setitem(1,'ddia_no_documento', ls_doc)
			dw_3.setitem(1,'ddia_no_referencia', ls_doc)
		else
			ii_ann_anterior = this.getitemnumber(1,'diar_ann')
			is_doc_anterior = this.getitemstring(1,'diar_no_documento')
			is_ref_anterior = this.getitemstring(1,'diar_no_referencia')
			ls_referencia = this.getitemstring(1,'diar_no_referencia')
			ii_ann 		  = this.getitemnumber(1,'diar_ann')

			if dw_3.retrieve(str.g_financiero, str.empresa, 'CO' , ls_tran, ls_doc, ls_referencia, ii_ann , '1') = 0 then

					dw_3.insertrow(1)
					dw_3.setitem(1,'ddia_fecha', date(gf_fecha_serv()))
					dw_3.setitem(1,'ddia_g_financiero',str.g_financiero)
					dw_3.setitem(1,'ddia_empresa',str.empresa)
					dw_3.setitem(1,'ddia_aplicacion_mg','CO')
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
			
			this.setcolumn('diar_no_documento')
		end if
	case	'diar_no_referencia'
		dw_3.setitem(1,'ddia_no_referencia', data)

end choose
end event

event dw_1::buttonclicked;call super::buttonclicked;	String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error, ls_tran, ls_codigo, ls_referencia, ls_sub_tran, ls_doc, ls_stran
	integer li_c, li_b, li_ann
	long    ll_lter
	Datawindow        dww
	str_dg_dynamic_find	lstr_df

if dwo.name = 'b_buscar' then
		//Busqueda del producto
	//	
	ls_tran = this.getitemstring(1,'diar_tipo_transaccion')
	ls_stran = this.getitemstring(1,'diar_sub_trans')
	
	if ls_tran = '' or isnull(ls_tran) then
		gf_mensaje('','Seleccione una Transaccion para buscar Documentos',1,1,'E')
		return
	end if
	
		lstr_df.texto_campo [2,1] = "cotdiari.diar_no_referencia"
		lstr_df.texto_campo [2,2] = "Referencia"
		lstr_df.texto_campo [2,3] = "diar_no_referencia"
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [1,1] = "cotdiari.diar_no_documento"
		lstr_df.texto_campo [1,2] = "Documento"
		lstr_df.texto_campo [1,3] = "diar_no_documento"
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '280'	
		lstr_df.texto_campo [3,1] = "cotdiari.diar_nombre"
		lstr_df.texto_campo [3,2] = "A Nombre de"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [3,5] = '770'
		lstr_df.texto_campo [4,1] = "cotdiari.diar_fecha_transaccion"
		lstr_df.texto_campo [4,2] = "Fecha"
		lstr_df.texto_campo [4,3] = ""
		lstr_df.texto_campo [4,4] = 'V'
		lstr_df.texto_campo [4,5] = '370'
		lstr_df.texto_campo [5,1] = "cotdiari.diar_monto"
		lstr_df.texto_campo [5,2] = "Valor"
		lstr_df.texto_campo [5,3] = ""
		lstr_df.texto_campo [5,4] = 'V'
		lstr_df.texto_campo [5,5] = '400'
		lstr_df.texto_campo [6,1] = "cotdiari.diar_descripcion"
		lstr_df.texto_campo [6,2] = "Detalle"
		lstr_df.texto_campo [6,3] = ""
		lstr_df.texto_campo [6,4] = 'V'
		
		lstr_df.tabla = " cotdiari "
			
		lstr_df.tabla_where = &
					"WHERE (cotdiari.diar_g_financiero = " + string(str.g_financiero) + ") and " +&
							 "(cotdiari.diar_empresa = " + string(str.empresa) + ") and " +&
							 "(cotdiari.diar_aplicacion_mg = 'CO') and " +& 	
							 "(cotdiari.diar_ann = "+string(ii_ann)+") and " +&
							 "(cotdiari.diar_tipo_transaccion = '"+ls_tran+"') and "+&							 
							 "(cotdiari.diar_sub_trans = '"+ls_stran+"')"
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	
	If len (ls_find) = 0 Then Return
		
	ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	
	ls_referencia =  String(Right ( ls_codigo, Len (ls_codigo) - Pos (ls_codigo, "=") ))
	gf_replace_cadena(ls_referencia,"'"," ")
	ls_referencia = Trim(ls_referencia)
	this.setitem(1,'diar_no_referencia',ls_referencia)
	
	ls_doc = mid(ls_codigo,1, pos(ls_codigo, 'And ')-1)
	gf_replace_cadena(ls_doc,"'"," ")
	ls_doc = Trim(ls_doc)
	this.setitem(1,'diar_no_documento',ls_doc)
	
	this.setcolumn('diar_no_documento')
	this.accepttext()
	this.trigger event itemchanged(1, object, ls_doc)
	
elseif dwo.name = 'b_buscar_cliente' then
			
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
integer li_retorno
li_retorno = this.SelectText( 1, 99) 

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

if this.getcolumnname() = 'diar_no_documento' then
		//Busqueda del producto
	//	
	ls_tran = this.getitemstring(1,'diar_tipo_transaccion')
	
	if ls_tran = '' or isnull(ls_tran) then
		gf_mensaje('','Seleccione una Transaccion para buscar Documentos',1,1,'E')
		return
	end if
	
	
		lstr_df.texto_campo [1,1] = "cotdiari.diar_no_documento"
		lstr_df.texto_campo [1,2] = "Documento"
		lstr_df.texto_campo [1,3] = "diar_no_documento"
		lstr_df.texto_campo [1,4] = 'V'
	//	lstr_df.texto_campo [1,5] = '280'	
		lstr_df.texto_campo [2,1] = "cotdiari.diar_nombre"
		lstr_df.texto_campo [2,2] = "A Nombre de"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '770'
		lstr_df.texto_campo [3,1] = "cotdiari.diar_fecha_transaccion"
		lstr_df.texto_campo [3,2] = "Fecha"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [3,5] = '285'
		lstr_df.tabla = " cotdiari "
			
		lstr_df.tabla_where = &
					"WHERE (cotdiari.diar_g_financiero = " + string(str.g_financiero) + ") and " +&
							 "(cotdiari.diar_empresa = " + string(str.empresa) + ") and " +&
							 "(cotdiari.diar_aplicacion_mg = 'CO') and " +& 
							 "(cotdiari.diar_tipo_transaccion = '"+ls_tran+"')"
							 
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	If len (ls_find) = 0 Then Return
		
	ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo,"'"," ")
	ls_codigo = Trim(ls_codigo)
	this.setitem(1,'diar_no_documento',ls_codigo)
	this.setcolumn('diar_no_documento')
	this.accepttext()
	this.trigger event itemchanged(1, object, ls_codigo)
	
elseif this.getcolumnname() = 'movi_ruc_tercero' then
			
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
	ld_ini_date=date(dw_1.GetItemDateTime(dw_1.getrow(),"diar_fecha_transaccion"))
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
end if
end event

type st_ayuda from w_fa_padre`st_ayuda within w_transacciones_conta
end type

type dw_2 from datawindow within w_transacciones_conta
boolean visible = false
integer x = 87
integer y = 12
integer width = 3598
integer height = 2136
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Imprimir Comprobante"
string dataobject = "dw_imprimir_conta_2ocean"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "AppIcon!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_transacciones_conta
boolean visible = false
integer x = 2743
integer y = 508
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

type cb_2 from commandbutton within w_transacciones_conta
boolean visible = false
integer x = 2743
integer y = 624
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

type cb_3 from commandbutton within w_transacciones_conta
boolean visible = false
integer x = 96
integer y = 2044
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
boolean enabled = false
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
	ld_monto = dw_1.getitemnumber(1,'movi_monto')
	ls_comentario = 'TRANSACCION ANULADA, VALOR '+string(ld_monto,'$ ###,##0.00')+ ' - ' +dw_1.getitemstring(1, 'movi_comentario')
	ldt_fecha = gf_fecha_serv()
	
	update cctmovim
	set   cctmovim.movi_monto = 0,   
         cctmovim.movi_estado = 'AN',   
         cctmovim.movi_comentario = :ls_comentario,
			cctmovim.movi_fecha_anul = :ldt_fecha,
			cctmovim.movi_usuario_anul = :str.usuario
   WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
         ( cctmovim.movi_empresa = :str.empresa ) AND  
         ( cctmovim.movi_aplicacion = 'CP' ) AND  
         ( cctmovim.movi_tipo_transaccion = :is_tran ) AND  
         ( cctmovim.movi_documento = :ls_documento ) AND  
         ( cctmovim.movi_anno = :ii_ann ) AND  
         ( cctmovim.movi_tipo_transaccion+cctmovim.movi_sub_transaccion <> 'NC9' );
			
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

type pb_1 from picturebutton within w_transacciones_conta
boolean visible = false
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

type st_1 from statictext within w_transacciones_conta
boolean visible = false
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

type dw_3 from datawindow within w_transacciones_conta
event ue_helpcol pbm_dwnkey
integer x = 87
integer y = 1000
integer width = 4722
integer height = 924
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

THIS.ACCEPTTEXT()

choose case dwo.name
	case	'b_adicionar'
//		this.reset()
		this.scrolltorow(this.insertrow(0))
		dw_3.setitem(dw_3.getrow(),'ddia_fecha', date(gf_fecha_serv()))
		dw_3.setitem(dw_3.getrow(),'ddia_g_financiero',str.g_financiero)
		dw_3.setitem(dw_3.getrow(),'ddia_empresa',str.empresa)
		dw_3.setitem(dw_3.getrow(),'ddia_aplicacion_mg','CO')
//		dw_3.setitem(dw_3.getrow(),'ddia_ann', ii_ann) //year(date(gf_fecha_serv())))
		dw_3.setitem(dw_3.getrow(),'ddia_id', str.usuario)
		dw_3.setitem(dw_3.getrow(),'ddia_tipo_transaccion', is_tran)
		dw_3.setitem(dw_3.getrow(),'ddia_sub_trans', is_stran)
		dw_3.setitem(dw_3.getrow(),'naturaleza','D')	
		dw_3.setitem(dw_3.getrow(),'ddia_linea',dw_3.getrow())
		dw_3.setitem(dw_3.getrow(),'tipo','I')
		dw_3.setitem(dw_3.getrow(),'ddia_ann',ii_ann)
		dw_3.setitem(dw_3.getrow(),'ddia_no_documento',dw_1.getitemstring(1,'diar_no_documento'))
		dw_3.setitem(dw_3.getrow(),'ddia_no_referencia',dw_1.getitemstring(1,'diar_no_referencia'))
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

type dw_4 from datawindow within w_transacciones_conta
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

type uo_1 from u_ddcalen within w_transacciones_conta
boolean visible = false
integer x = 1472
integer y = 332
integer taborder = 11
boolean bringtotop = true
end type

on uo_1.destroy
call u_ddcalen::destroy
end on

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;datetime ldt_fecha_tran, ldt_fecha_anterior
integer li_ann_anterior
dw_1.SetItem ( dw_1.getrow(), 'diar_fecha_transaccion', uo_1.return_sel_date() )

if uo_1.allow_close then
	this.visible=false
	dw_1.SetFocus()
	
	dw_1.accepttext()	
	ldt_fecha_tran 	 = dw_1.getitemdatetime(dw_1.getrow(),'diar_fecha_transaccion')		
	ldt_fecha_anterior = dw_1.getitemdatetime(dw_1.getrow(),'diar_fecha_transaccion', Primary!, True)		
	li_ann_anterior = dw_1.getitemnumber(1,'diar_ann')
	
	if not gf_valida_fecha_conta(ldt_fecha_anterior) then		
		if ldt_fecha_anterior = ldt_fecha_tran then
			dw_1.setitem(1,'diar_fecha_transaccion', date(gf_fecha_serv()))
		else
			dw_1.setitem(1,'diar_fecha_transaccion', ldt_fecha_anterior)
		end if
		dw_1.setcolumn('diar_fecha_transaccion')
		return
	end if

	if not gf_valida_fecha_conta(ldt_fecha_tran) then			
		if ldt_fecha_anterior = ldt_fecha_tran then
			dw_1.setitem(1,'diar_fecha_transaccion', date(gf_fecha_serv()))
		else
			dw_1.setitem(1,'diar_fecha_transaccion', ldt_fecha_anterior)
		end if
		dw_1.setcolumn('diar_fecha_transaccion')
		return
	end if				
	
	if not gf_valida_fecha_futura(ldt_fecha_tran) then			
			if ldt_fecha_tran = ldt_fecha_anterior then
				dw_1.setitem(1,'diar_fecha_transaccion', date(gf_fecha_serv()))				
			else
				dw_1.setitem(1,'diar_fecha_transaccion', ldt_fecha_anterior)
			end if
			dw_1.setcolumn('diar_fecha_transaccion')
		end if
		
		ii_ann = year(date(dw_1.getitemdatetime(dw_1.getrow(),'diar_fecha_transaccion')))
		//Si los anios son diferentes asigna el anio
		if ii_ann <> li_ann_anterior then
			dw_1.setitem(1,'diar_ann',ii_ann)
		end if
	
end if


end event

