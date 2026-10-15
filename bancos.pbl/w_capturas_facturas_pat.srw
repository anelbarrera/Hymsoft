forward
global type w_capturas_facturas_pat from window
end type
type dw_1 from datawindow within w_capturas_facturas_pat
end type
end forward

global type w_capturas_facturas_pat from window
integer width = 2939
integer height = 1180
boolean titlebar = true
string title = "Captura de Facturas"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
windowanimationstyle openanimation = centeranimation!
windowanimationstyle closeanimation = centeranimation!
event ue_adicionar ( )
event ue_aceptar ( )
event ue_eliminar ( )
dw_1 dw_1
end type
global w_capturas_facturas_pat w_capturas_facturas_pat

type variables
string is_tran, is_stran, is_cuenta_bancaria, is_documento, is_aplicacion
integer ii_ann, ii_banco
decimal{2} id_monto
datetime idt_fecha_transaccion

end variables

event ue_adicionar();dw_1.scrolltorow(dw_1.insertrow(0))
dw_1.setitem(dw_1.getrow(),'bamp_g_financiero',str.g_financiero)
dw_1.setitem(dw_1.getrow(),'bamp_empresa',str.empresa)
dw_1.setitem(dw_1.getrow(),'bamp_transaccion',is_tran)
dw_1.setitem(dw_1.getrow(),'bamp_sub_trans',is_stran)
dw_1.setitem(dw_1.getrow(),'bamp_banco',ii_banco)
dw_1.setitem(dw_1.getrow(),'bamp_no_cuenta',is_cuenta_bancaria)
dw_1.setitem(dw_1.getrow(),'bamp_no_documento',is_documento)
dw_1.setitem(dw_1.getrow(),'bamp_ano',ii_ann)
dw_1.setitem(dw_1.getrow(),'bamp_aplicacion',is_aplicacion)
dw_1.SetItem(dw_1.getrow(),'bamp_numero_factura',is_documento)
dw_1.SetItem(dw_1.getrow(),'bamp_fecha_factura',idt_fecha_transaccion)
dw_1.SetItem(dw_1.getrow(),'bamp_monto_factura',id_monto)	
dw_1.SetItem(dw_1.getrow(),'bamp_fecha_transaccion',idt_fecha_transaccion)
dw_1.setcolumn('bamp_ruc')
dw_1.setfocus()


end event

event ue_aceptar();decimal{2} ldec_monto_factura, ldec_monto
datetime ldt_fecha_reg
string ls_concepto, ls_ruc, ls_dig_verif, ls_tipo_persona, ls_mensaje
integer li
ldt_fecha_reg = gf_fecha_serv()
ldec_monto = id_monto
sqlca.autocommit = false
dw_1.accepttext()
		ldec_monto_factura = 0
		for li = 1 to dw_1.rowcount()
			ls_concepto = dw_1.getitemstring(li,'bamp_concepto_pago')
			if isnull(ls_concepto) or trim(ls_concepto) = '' then
				messagebox('Mensaje','El concepto no puede estar en blanco. Verifique.')
				Rollback;
				sqlca.autocommit = true;				
				return
			end if						
			dw_1.setitem(li,'bamp_fecha_reg', ldt_fecha_reg)
			dw_1.SetItem(li,'bamp_secuencia',li)
			
			CHOOSE CASE ls_concepto
			CASE '10','11','00'
			CASE ELSE
				ls_ruc = dw_1.getitemstring(li,'bamp_ruc')
				ls_dig_verif = dw_1.getitemstring(li,'bamp_digito')
				ls_tipo_persona = dw_1.getitemstring(li,'bamp_tipo_persona')
				if (isnull(ls_ruc) or trim(ls_ruc) = '') or &
				(isnull(ls_dig_verif) or trim(ls_dig_verif) = '') or &
				(isnull(ls_tipo_persona) or trim(ls_tipo_persona) = '') then
					if isnull(ls_ruc) or trim(ls_ruc) = '' then
						ls_mensaje = 'R.U.C.'
					elseif isnull(ls_dig_verif) or trim(ls_dig_verif) = '' then
						ls_mensaje = 'Dígito verificador'
					elseif isnull(ls_tipo_persona) or trim(ls_tipo_persona) = '' then
						ls_mensaje = 'Tipo de persona'
					end if
					messagebox('Mensaje','El campo '+ls_mensaje+' no puede ser nulo.')
					sqlca.autocommit = true;
					return
				end if				
			END CHOOSE
			ldec_monto_factura += dw_1.getitemdecimal(li,'bamp_monto_factura')
		next
		if ldec_monto_factura <> ldec_monto and dw_1.rowcount() > 0 then
			messagebox('Mensaje','El monto total de las facturas no es igual al monto de la transaccion.  Verifique.')
			Rollback;
			sqlca.autocommit = true;
			return
		end if		


if dw_1.update() = -1 then
	gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
end if

sqlca.autocommit = true
end event

event ue_eliminar();integer li_fila
li_fila = dw_1.getrow()

if gf_mensaje('','Esta Seguro de Eliminar ?',2,1,'E') = 2 then return

if dw_1.rowcount() > 0 then
	dw_1.deleterow(li_fila)
	if dw_1.update() = -1 then
		gf_mensaje('','Error al Eliminar '+sqlca.sqlerrtext,1,1,'E')
	end if
end if
end event

on w_capturas_facturas_pat.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_capturas_facturas_pat.destroy
destroy(this.dw_1)
end on

event open;sqlca.autocommit = true
dw_1.settransobject(sqlca)
datawindowchild ldwc_concepto

str_transaccion_facturas lstr_facturas
lstr_facturas = message.powerobjectparm

dw_1.getchild('bamp_concepto_pago', ldwc_concepto)
ldwc_concepto.settransobject(sqlca)
ldwc_concepto.retrieve()

is_tran =	lstr_facturas.transaccion 
is_stran =	lstr_facturas.subtransaccion
ii_banco = 	lstr_facturas.banco
is_cuenta_bancaria =	lstr_facturas.cuenta
is_documento =	lstr_facturas.documento
ii_ann = 	lstr_facturas.ann
is_aplicacion = lstr_facturas.aplicacion
id_monto = lstr_facturas.monto
idt_fecha_transaccion = lstr_facturas.fecha

if dw_1.retrieve(str.g_financiero, str.empresa, is_tran, is_stran, ii_banco, is_cuenta_bancaria, is_documento, ii_ann) = 0 then
	this.triggerevent('ue_adicionar')
end if
	
end event

type dw_1 from datawindow within w_capturas_facturas_pat
integer x = 32
integer y = 36
integer width = 2843
integer height = 1016
integer taborder = 10
string title = "none"
string dataobject = "dw_ba_captura_facturas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;choose case dwo.name 
	case 'b_cerrar'
		close(parent)
	case 'b_adicionar'
		parent.triggerevent('ue_adicionar')
	case 'b_guardar'
		parent.triggerevent('ue_aceptar')
	case 'b_eliminar'
		parent.triggerevent('ue_eliminar')
	case 'p_buscar'
		String ls_syntax, ls_syntax2,ls_identificacion,ls_nombre_tercero,ls_tipo_persona,ls_dv
		long ll_tercero
		str_dg_dynamic_find lstr_df
		datawindow dw
		
		lstr_df.texto_campo[1, 1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo[1, 2] = "Nombre"
		lstr_df.texto_campo[1, 4] = "V"
		lstr_df.texto_campo[2, 1] = "dgmterce.terc_tercero"
		lstr_df.texto_campo[2, 2] = "Cód. Tercero"
		lstr_df.texto_campo[2, 3] = "dgmterce.terc_tercero"
		lstr_df.texto_campo[2, 4] = "V"
		lstr_df.texto_campo[3, 1] = "dgmterce.terc_identificacion"
		lstr_df.texto_campo[3, 2] = "R.U.C."
		lstr_df.texto_campo[3, 4] = "V"
		lstr_df.texto_campo[4, 1] = "dgmterce.terc_digito_verificador"
		lstr_df.texto_campo[4, 2] = "Díg. Verificador"
		lstr_df.texto_campo[4, 4] = "V"
		lstr_df.tabla				  = "dgmterce"
		
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		
		ls_syntax = Message.StringParm
		ls_syntax2 = Mid (ls_syntax,(Pos(ls_syntax,"="))+1,len(ls_syntax) - (Pos(ls_syntax,"=")))
		
		ll_tercero = long(ls_syntax2)
		
		If Len(Trim(ls_syntax)) > 0 Then 
			SELECT terc_identificacion, dgmterce.terc_descripcion,terc_tipo_persona,terc_digito_verificador
			INTO :ls_identificacion, :ls_nombre_tercero, :ls_tipo_persona, :ls_dv
			FROM dgmterce WHERE terc_tercero = :ll_tercero;
			
//			if ls_tipo_persona = 'J' then
//				ls_tipo_persona = '2'
//			elseif ls_tipo_persona = 'N' then
//				ls_tipo_persona = '1'
//			else
//				ls_tipo_persona = '1'
//			end if		
			
			SetItem(row,'bamp_ruc',ls_identificacion)
			SetItem(row,'bamp_tercero',ll_tercero)
			SetItem(row,'bamp_digito',ls_dv)
			SetItem(row,'bamp_tipo_persona',ls_tipo_persona)
			SetItem(row,'bamp_a_nombre_de',ls_nombre_tercero)
		end if
end choose
end event

event itemfocuschanged;this.selecttext(1,100)
end event

