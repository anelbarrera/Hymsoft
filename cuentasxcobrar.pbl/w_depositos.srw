forward
global type w_depositos from w_fa_padre
end type
type dw_2 from datawindow within w_depositos
end type
type cb_3 from commandbutton within w_depositos
end type
type dw_3 from datawindow within w_depositos
end type
type uo_1 from u_ddcalen within w_depositos
end type
type dw_4 from datawindow within w_depositos
end type
type cb_5 from commandbutton within w_depositos
end type
end forward

global type w_depositos from w_fa_padre
integer width = 4059
integer height = 2584
string title = "Captura de Slips de Depósitos"
string menuname = "m_fa_principal"
long backcolor = 8421376
dw_2 dw_2
cb_3 cb_3
dw_3 dw_3
uo_1 uo_1
dw_4 dw_4
cb_5 cb_5
end type
global w_depositos w_depositos

type variables
datawindowchild idwc_clientes, idwc_tran, idwc_stran, idwc_cuentas
string is_tran, is_stran, is_tran_automatica, is_cuenta, is_documento
integer ii_ann, ii_banco
end variables

forward prototypes
public function string wf_secuencia_tran ()
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

return ls_sec
end function

on w_depositos.create
int iCurrent
call super::create
if this.MenuName = "m_fa_principal" then this.MenuID = create m_fa_principal
this.dw_2=create dw_2
this.cb_3=create cb_3
this.dw_3=create dw_3
this.uo_1=create uo_1
this.dw_4=create dw_4
this.cb_5=create cb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.dw_4
this.Control[iCurrent+6]=this.cb_5
end on

on w_depositos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.cb_3)
destroy(this.dw_3)
destroy(this.uo_1)
destroy(this.dw_4)
destroy(this.cb_5)
end on

event ue_post_open;//override
str_secuencia_doc lstr_sec
string ls_documento
integer li_ann
datawindowchild ldwc_cobrador
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)

dw_1.getchild('btdi_no_cuenta', idwc_cuentas)
idwc_cuentas.settransobject(sqlca)
if idwc_cuentas.retrieve(str.g_financiero, str.empresa) = 0 then
	gf_mensaje('','Debe registrar las Cuentas Bancarias',1,1,'E')
	idwc_cuentas.insertrow(1)
end if

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
	dw_1.setitem(1,'btdi_fecha_tran', date(gf_fecha_serv()))
	dw_1.setitem(1,'btdi_g_financiero',str.g_financiero)
	dw_1.setitem(1,'btdi_empresa',str.empresa)
	dw_1.setitem(1,'btdi_aplicacion','CC')
	dw_1.setitem(1,'btdi_aplica_origen','CC')	
	dw_1.setitem(1,'btdi_estado','I')	
	dw_1.setitem(1,'btdi_tipo_transaccion','SD')
	dw_1.setitem(1,'btdi_sub_transaccion','0')
	dw_1.setitem(1,'btdi_ann', ii_ann)
	dw_1.setitem(1,'btdi_id_usuario_registra', str.usuario)
	if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
		gf_mensaje('','No Existen Pagos por Depositar',1,1,'E')
	end if
	dw_1.setcolumn('btdi_banco')	
end if

dw_1.setitemstatus(1,0,primary!,NotModified!) 
end event

event ue_aceptar;//override
long ll_update, ll_doc
integer li_ann, i, li_ann_recibo
window lw_ventana
string ls_titulo, ls_doc, ls_recibo, ls_tran, ls_subtran, ls_referencia, ls_error
decimal{2} ldec_saldo, ld_monto, ld_efectivo, ld_cheque, ld_tarjeta, ld_depositado

//lw_ventana = this.getactivesheet()
//ls_titulo = lw_ventana.title

dw_1.accepttext()
li_ann = dw_1.getitemNumber(dw_1.getrow(), 'btdi_ann')
ls_doc = dw_1.getitemstring(dw_1.getrow(), 'btdi_documento')
if ls_doc = '' or isnull(ls_doc) then
	gf_mensaje('','Debe digitar el documento antes de guardar, Verifique !!!',1,1,'E')
	dw_1.setcolumn('btdi_documento')
	return
end if

if dw_1.getitemstring(dw_1.getrow(), 'btdi_no_cuenta') = '' or isnull(dw_1.getitemstring(dw_1.getrow(),'btdi_no_cuenta')) then
	gf_mensaje('','Debe digitar la Cuenta Bancaria antes de guardar, Verifique !!!',1,1,'E')
	dw_1.setcolumn('btdi_no_cuenta')
	return
end if

if dw_1.getitemNumber(dw_1.getrow(), 'btdi_banco') = 0 or isnull(dw_1.getitemNumber(dw_1.getrow(),'btdi_banco')) then
	gf_mensaje('','Debe asignar el Banco donde se Depositará, Verifique !!!',1,1,'E')
	dw_1.setcolumn('btdi_banco')
	return
end if

if dw_3.rowcount() = 0 then
	ld_monto = 0
else
	ld_monto = dw_3.getitemnumber(1,'total_final')
end if
dw_1.setitem(1,'btdi_monto',ld_monto)
dw_1.accepttext()

sqlca.autocommit = false

ll_update=dw_3.update()

if ll_update = 1  then
	for i = 1 to dw_3.rowcount()		
		ls_recibo 		= dw_3.getitemstring(i,'deta_no_recibo')
		li_ann_recibo  = dw_3.getitemnumber(i,'deta_recib_anno')
		ls_tran			= dw_3.getitemstring(i,'deta_tipo_recibo')
		ls_subtran		= dw_3.getitemstring(i,'deta_subtipo_recibo')
		ls_referencia  = dw_3.getitemString(i,'deta_referencia_recibo')
		ld_efectivo		= dw_3.getitemnumber(i,'deta_efectivo')
		ld_cheque		= dw_3.getitemnumber(i,'deta_cheque')
		ld_tarjeta		= dw_3.getitemnumber(i,'deta_tarjeta')
		ld_depositado	= ld_efectivo + ld_cheque + ld_tarjeta	
		
		  UPDATE cctmovim  
			  SET movi_efectivo_dep = movi_efectivo_dep + :ld_efectivo,   
					movi_cheque_dep = movi_cheque_dep + :ld_cheque,   
					movi_tarjeta_dep = movi_tarjeta_dep + :ld_tarjeta ,
					movi_cant_depositada = movi_cant_depositada + :ld_depositado
			WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
					( cctmovim.movi_empresa = :str.empresa ) AND  
					( cctmovim.movi_aplicacion = 'CC' ) AND  
					( cctmovim.movi_tipo_transaccion = :ls_tran ) AND  
					( cctmovim.movi_sub_transaccion = :ls_subtran ) AND  
					( cctmovim.movi_documento = :ls_recibo ) AND  
					( cctmovim.movi_anno = :li_ann_recibo ) AND  
					( cctmovim.movi_referencia = :ls_referencia )  ;
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback using sqlca;
					gf_mensaje('','Error al actualizar la cantidad depositada '+ls_error,1,1,'E')
				end if
		
	next
	
	if dw_3.update() = 1 then				
		commit using sqlca;
		dw_3.retrieve(str.g_financiero, str.empresa)
	else
		ls_error = sqlca.sqlerrtext
		rollback using sqlca;
		gf_mensaje("Atención","¡Error al Actualizar ! " + ls_error,1,1,'E')		
	end if
//		//Si la secuencia es automatica, graba en la tabla de transacciones
//		is_tran_automatica = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_sec_auto')
//		if is_tran_automatica = 'S' then
//			
//			ll_doc = long(dw_1.getitemstring(1,'movi_documento'))
//			update dgmserie
//			set mser_secuencia = :ll_doc
//			where mser_g_financiero = :str.g_financiero and
//					mser_empresa		= :str.empresa	and
//					mser_tipo_transaccion = :is_tran ;
//					if sqlca.sqlcode = -1 then
//						gf_mensaje('','Error al guardar secuencia '+sqlca.sqlerrtext,1,1,'E')
//					end if
//		end if			
//		if dw_1.getitemstring(1,'movi_impreso') = 'N' or isnull(dw_1.getitemstring(1,'movi_impreso')) then
//			this.triggerevent('ue_print')
//			update cctmovim set movi_impreso = 'S'
//			where movi_g_financiero = :str.g_financiero and
//					movi_empresa		= :str.empresa	and
//					movi_aplicacion	= 'CC' and
//					movi_tipo_transaccion = :is_tran and
//					movi_sub_transaccion	 = :is_stran and
//					movi_documento			 = :ls_doc and
//					movi_anno				 = :li_ann ;
//					if sqlca.sqlcode = -1 then
//						gf_mensaje('','Error al actualizar el estado de impreso '+sqlca.sqlerrtext,1,1,'E')
//						rollback;
//					end if
//					dw_1.setitem(1,'movi_impreso','S')
//		end if
//		commit ;
//	gf_mensaje("Atención","¡Actualización Exitosa !",1,1,'E')
else
	ls_error = sqlca.sqlerrtext
	rollback using sqlca;
	gf_mensaje("Atención","¡Error al Actualizar ! " + ls_error,1,1,'E')
end if

sqlca.autocommit = true
end event

event ue_adicionar;//override
string ls_tran, ls_subt, ls_naturaleza, ls_doc
if dw_1.rowcount() > 0 then
//	ls_tran = dw_1.getitemstring(1,'movi_tipo_transaccion')
//	ls_subt = dw_1.getitemstring(1,'movi_sub_transaccion')
//	dw_4.reset()
	dw_1.reset()	
end if

dw_1.insertrow(1)
dw_1.setitem(1,'btdi_fecha_tran', date(gf_fecha_serv()))
dw_1.setitem(1,'btdi_g_financiero',str.g_financiero)
dw_1.setitem(1,'btdi_empresa',str.empresa)
dw_1.setitem(1,'btdi_aplicacion','CC')
dw_1.setitem(1,'btdi_aplica_origen','CC')
dw_1.setitem(1,'btdi_estado','I')
dw_1.setitem(1,'btdi_tipo_transaccion','SD')
dw_1.setitem(1,'btdi_sub_transaccion','0')
dw_1.setitem(1,'btdi_ann', ii_ann)
dw_1.setitem(1,'btdi_id_usuario_registra', str.usuario)
//is_tran_automatica = idwc_tran.getitemstring(idwc_tran.getrow(),'mser_sec_auto')
if is_tran_automatica = 'S' then
	dw_1.Modify("btdi_documento.Edit.DisplayOnly=Yes")			
	ls_doc = wf_secuencia_tran()			
	dw_1.setitem(1,'btdi_documento', ls_doc)
else
	dw_1.Modify("btdi_documento.Edit.DisplayOnly=No")
	dw_1.setitem(1,'btdi_documento','')
end if		
dw_1.setcolumn('btdi_documento')
dw_1.setfocus()
end event

event resize;//override
cb_3.y = newheight - 200

end event

event ue_print;//override
string  ls_dinero, ls_tran, ls_doc, ls_cta
Integer li_ann, li_banco

dw_2.settransobject(sqlca)

ls_doc  = dw_1.getitemstring(1,'btdi_documento')
li_ann  = dw_1.getitemnumber(1,'btdi_ann')
ls_doc  = dw_1.getitemstring(1,'btdi_no_cuenta')
li_banco  = dw_1.getitemNumber(1,'btdi_banco')

if dw_2.retrieve(str.g_financiero, str.empresa, li_banco, ls_cta, ls_doc, li_ann) > 0 then
	ls_dinero =  gf_numerlet(dw_1.getitemnumber(1,'movi_monto'),1)
	if dw_2.describe("numero_letra.x") <> "!" and dw_2.describe("numero_letra.x") <> "?"then				
		dw_2.object.numero_letra.expression = "'"+ls_dinero+"'"
	end if
	dw_2.Modify("DataWindow.Print.Preview=true")	
else
	gf_mensaje('','Transaccion no Registrada, Verifique!!!',1,1,'E')
	return
end if
dw_2.visible = true

OpenWithParm(w_dw_print_options, dw_2)

If Message.DoubleParm = -1 Then Return
dw_2.Print(True)

end event

event ue_eliminar;//override
this.setredraw(false)
if dw_1.rowcount() > 0 then
	if gf_mensaje('','Esta seguro de eliminar la transaccion ??',2,1,'E') = 2 then 
		this.setredraw(true)
		return		
	end if
	dw_1.deleterow(dw.getrow())
	if dw_1.update() = 1 then
		this.triggerevent('ue_adicionar')
	end if
else 
	messagebox("Atención","No hay registros para borrar!")
end if
this.setredraw(true)
end event

event open;call super::open;this.y = 0
this.x = 805

end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_depositos
boolean visible = false
integer width = 73
integer height = 36
string text = ""
end type

type dw_1 from w_fa_padre`dw_1 within w_depositos
integer x = 18
integer y = 16
integer width = 3831
integer height = 372
string dataobject = "dw_depositos_encab"
end type

event dw_1::itemchanged;call super::itemchanged;this.accepttext()
string ls_tran, ls_doc, ls_subt, ls_naturaleza
integer li_ann
decimal{2} ldec_saldo

choose case this.getcolumnname()
	case 'btdi_ano'
		ii_ann = this.getitemnumber(1,'btdi_ano')
	case 'btdi_banco'		
		ii_banco = integer(data)
		idwc_cuentas.setfilter("cuen_banco = "+string(ii_banco))
		idwc_cuentas.filter()		
		parent.triggerevent('ue_adicionar')
		if idwc_cuentas.rowcount() > 0 then
			is_cuenta = idwc_cuentas.getitemstring(1,'cuen_no_cuenta')
			dw_1.setitem(1,'btdi_no_cuenta',is_cuenta)
		end if	
		dw_1.setitem(1,'btdi_banco',ii_banco)
		this.setcolumn('btdi_documento')		
		
	case 'btdi_documento'
		integer li_existe
		ls_doc 	 = this.getitemstring(1,'btdi_documento')
		is_documento = ls_doc
		li_ann 	 = this.getitemNumber(1,'btdi_ann')//year(date(gf_fecha_serv()))
		ii_banco  = this.getitemNumber(1,'btdi_banco')
		is_cuenta = this.getitemString(1,'btdi_no_cuenta')
		if	this.retrieve(str.g_financiero, str.empresa, ii_banco, is_cuenta, ls_doc, li_ann) = 0 then
			parent.triggerevent('ue_adicionar')
			this.setitem(1,'btdi_documento',ls_doc)
			this.setitem(1,'btdi_tipo_transaccion','SD')
			this.setitem(1,'btdi_sub_transaccion','0')
			this.setitem(1,'btdi_banco',ii_banco)
			this.setitem(1,'btdi_no_cuenta',is_cuenta)
			this.setcolumn('btdi_documento')
		else
//			dw_4.retrieve(str.g_financiero, str.empresa, ii_banco, is_cuenta, ls_doc, li_ann)		
			this.setcolumn('btdi_documento')
		end if

end choose
end event

event dw_1::buttonclicked;call super::buttonclicked;	String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error, ls_tran, ls_codigo
	integer li_c, li_b
	long    ll_lter
	Datawindow        dww
	str_dg_dynamic_find	lstr_df

if dwo.name = 'b_buscar' then
		//Busqueda del producto
	//	
	ls_tran = 'SD'
	
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
		lstr_df.texto_campo [2,5] = '770'
		lstr_df.texto_campo [3,1] = "cctmovim.movi_fecha_tran"
		lstr_df.texto_campo [3,2] = "Fecha"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [3,5] = '285'
		lstr_df.tabla = " cctmovim "
			
		lstr_df.tabla_where = &
					"WHERE (cctmovim.movi_g_financiero = " + string(str.g_financiero) + ") and " +&
							 "(cctmovim.movi_empresa = " + string(str.empresa) + ") and " +&
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
		lstr_df.texto_campo [2,5] = '770'
		lstr_df.texto_campo [3,1] = "cctmovim.movi_fecha_tran"
		lstr_df.texto_campo [3,2] = "Fecha"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [3,5] = '285'
		lstr_df.tabla = " cctmovim "
			
		lstr_df.tabla_where = &
					"WHERE (cctmovim.movi_g_financiero = " + string(str.g_financiero) + ") and " +&
							 "(cctmovim.movi_empresa = " + string(str.empresa) + ") and " +&
							 "(cctmovim.movi_anno = " + string(li_ann) + ") and " +&
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
	
elseif this.getcolumnname() = 'movi_tercero' then
			
		lstr_df.texto_campo [1,1] = "ccmclien.clie_ref_anterior" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [1,2] = "Codigo"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '350'
		lstr_df.texto_campo [2,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [2,2] = "Descripción"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '700'		
		lstr_df.texto_campo [3,1] = "dgmterce.terc_tercero"
		lstr_df.texto_campo [3,2] = "Secuencial"
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
							"(dgmterce.terc_tercero = ccmclien.clie_tercero)"
		
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	If len (ls_find) = 0 Then Return
		
		
	ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo1,"'"," ")
	ls_codigo1 = Trim(ls_codigo1)

	dw_1.setitem(1,'movi_tercero',long(ls_codigo1))
	dw_1.accepttext()
	dw_1.setcolumn('movi_tercero')
	dw_1.trigger event itemchanged(1,object,ls_codigo1)
	
end if
end event

event dw_1::clicked;call super::clicked;date 	ld_date,ld_ini_date, ld_hoy
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
end choose
end event

type st_ayuda from w_fa_padre`st_ayuda within w_depositos
end type

type dw_2 from datawindow within w_depositos
boolean visible = false
integer x = 87
integer y = 12
integer width = 3232
integer height = 1388
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Impresion del Recibo"
string dataobject = "dw_imprimir_deposito"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "AppIcon!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_depositos
integer x = 18
integer y = 2236
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
string text = "Anular Depósito"
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
         ( cctmovim.movi_aplicacion = 'CC' ) AND  
         ( cctmovim.movi_tipo_transaccion = :is_tran ) AND  
         ( cctmovim.movi_documento = :ls_documento ) AND  
         ( cctmovim.movi_anno = :ii_ann ) AND  
         ( cctmovim.movi_tipo_transaccion+cctmovim.movi_sub_transaccion <> 'ND8' );
			
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

type dw_3 from datawindow within w_depositos
integer x = 18
integer y = 384
integer width = 3831
integer height = 1360
integer taborder = 11
boolean bringtotop = true
string title = "none"
string dataobject = "dw_por_depositar"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//integer li_seleccionar, li_ann_recibo
//string ls_recibo, ls_tran, ls_subtran, ls_a_nombre, ls_referencia
//long ll_cliente
//decimal{2} ld_efectivo, ld_cheque, ld_tarjeta, ld_pendiente
//
//if this.getcolumnname() = 'seleccionarxxxx' then
//	
//	if is_documento = '' or isnull(is_documento) then
//		this.setitem(this.getrow(),'seleccionar',0)
//		gf_mensaje('','Asigne el Documento antes de proceder a depositar',1,1,'E')
//		return 2
//	end if
//	
//	li_seleccionar = integer(data)
//	ls_recibo 		= dw_3.getitemstring(dw_3.getrow(),'movi_documento')
//	li_ann_recibo  = dw_3.getitemnumber(dw_3.getrow(),'movi_anno')
//	ls_tran			= dw_3.getitemstring(dw_3.getrow(),'movi_tipo_transaccion')
//	ls_subtran		= dw_3.getitemstring(dw_3.getrow(),'movi_sub_transaccion')
//	ls_a_nombre		= dw_3.getitemstring(dw_3.getrow(),'movi_a_nombre')
//	ll_cliente		= dw_3.getitemnumber(dw_3.getrow(),'movi_tercero')
//	ls_referencia  = dw_3.getitemString(dw_3.getrow(),'movi_referencia')
//	ld_efectivo		= dw_3.getitemnumber(dw_3.getrow(),'efectivo_x_dep')
//	ld_cheque		= dw_3.getitemnumber(dw_3.getrow(),'cheque_x_dep')
//	ld_tarjeta		= dw_3.getitemnumber(dw_3.getrow(),'tarjeta_x_dep')
//	ld_pendiente	= ld_efectivo + ld_cheque + ld_tarjeta	
//	
//	if li_seleccionar = 1 then
//		dw_4.scrolltorow(dw_4.insertrow(0))
//		dw_4.setitem(dw_4.getrow(),'deta_g_financiero', str.g_financiero)
//		dw_4.setitem(dw_4.getrow(),'deta_empresa', str.empresa)		
//		dw_4.setitem(dw_4.getrow(),'deta_anno', ii_ann)
//		dw_4.setitem(dw_4.getrow(),'deta_documento', is_documento)		
//		dw_4.setitem(dw_4.getrow(),'deta_tipo_transaccion', 'SD')
//		dw_4.setitem(dw_4.getrow(),'deta_sub_transaccion', '0')
//		dw_4.setitem(dw_4.getrow(),'deta_banco', ii_banco)
//		dw_4.setitem(dw_4.getrow(),'deta_cuenta', is_cuenta)		
//		dw_4.setitem(dw_4.getrow(),'deta_no_recibo', ls_recibo)		
//		dw_4.setitem(dw_4.getrow(),'deta_recib_anno', li_ann_recibo)		
//		dw_4.setitem(dw_4.getrow(),'deta_tipo_recibo', ls_tran)		
//		dw_4.setitem(dw_4.getrow(),'deta_subtipo_recibo', ls_subtran)				
//		dw_4.setitem(dw_4.getrow(),'deta_monto', ld_pendiente)				
//		dw_4.setitem(dw_4.getrow(),'deta_efectivo', ld_efectivo)		
//		dw_4.setitem(dw_4.getrow(),'deta_cheque', ld_cheque)		
//		dw_4.setitem(dw_4.getrow(),'deta_tarjeta', ld_tarjeta)				
//		dw_4.setitem(dw_4.getrow(),'deta_referencia_recibo', ls_referencia)				
//		dw_4.setitem(dw_4.getrow(),'deta_tercero', ll_cliente)		
//		dw_4.setitem(dw_4.getrow(),'deta_a_nombre', ls_a_nombre)				
//	else
//		
//	end if
//	
//end if
//
end event

type uo_1 from u_ddcalen within w_depositos
boolean visible = false
integer x = 219
integer y = 176
integer taborder = 31
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;dw_1.SetItem ( dw_1.getrow(), 'btdi_fecha_tran', uo_1.return_sel_date() )

if uo_1.allow_close then
	this.visible=false
	dw_1.SetFocus()
end if
end event

on uo_1.destroy
call u_ddcalen::destroy
end on

type dw_4 from datawindow within w_depositos
integer x = 18
integer y = 1744
integer width = 3831
integer height = 464
integer taborder = 21
boolean bringtotop = true
string title = "none"
string dataobject = "dw_detalle_contable"
boolean border = false
boolean livescroll = true
end type

type cb_5 from commandbutton within w_depositos
integer x = 2798
integer y = 48
integer width = 517
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
string text = "Reporte de Trans."
end type

event clicked;str_cc_formatos str_formato1		
str_formato1.tercero = dw_1.getitemnumber(1,'btdi_tercero')
str_formato1.cuenta_banco = dw_1.getitemString(1,'btdi_no_cuenta')
str_formato1.banco = dw_1.getitemnumber(1,'btdi_banco')
OpenSheetwithparm(w_reporte_transacciones_bco,str_formato1,w_fa_fondo ,2, Layered!)

end event

