forward
global type w_subir_saldos_clientes from window
end type
type cb_1 from commandbutton within w_subir_saldos_clientes
end type
type dw_2 from datawindow within w_subir_saldos_clientes
end type
type dw_1 from datawindow within w_subir_saldos_clientes
end type
end forward

global type w_subir_saldos_clientes from window
integer width = 3227
integer height = 2012
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
end type
global w_subir_saldos_clientes w_subir_saldos_clientes

on w_subir_saldos_clientes.create
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_2,&
this.dw_1}
end on

on w_subir_saldos_clientes.destroy
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_1.retrieve(str.g_financiero, str.empresa)
end event

type cb_1 from commandbutton within w_subir_saldos_clientes
integer x = 1125
integer y = 1668
integer width = 402
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pasar"
end type

event clicked;integer i
decimal{2} ld_monto
string ls_naturaleza, ls_cuenta, ls_ref
date ldt_fecha = date('12/31/2008')
long ll_tercero

for i = 1 to dw_1.rowcount()
	dw_1.scrolltorow(i)

	ls_cuenta = dw_1.getitemString(i,'ccmclien_clie_ref_anterior')
	ll_tercero= dw_1.getitemnumber(i,'dgmterce_terc_tercero')
	
	if dw_2.retrieve(ls_cuenta) = 0 then continue	
	
	ld_monto = dw_2.getitemnumber(1, 'balance')
	if isnull(ld_monto) then ld_monto = 0 
	
	if ld_monto < 0 then
		ls_naturaleza = 'C'
	else
		ls_naturaleza = 'D'
	end if
	
	ld_monto = abs(ld_monto)
	
	if ld_monto <> 0 then
//		ls_cuenta = dw_2.getitemstring(1, 'codigo')	
//		ll_tercero= dw_2.getitemnumber(1,'tercero')		
		ls_ref = string(i)
		
		  INSERT INTO cctmovim  
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
           movi_usuario,   
           movi_estado,   
           movi_fecha_anul,   
           movi_usuario_anul,   
           movi_cant_postfechada,   
           movi_cant_depositada,   
           movi_fecha_vence,   
           movi_fecha_cancelado,   
           movi_cajero,   
           movi_ano_cierre_caja,   
           movi_sec_cierre_caja,   
           movi_cobrador,   
           movi_comentario,   
           movi_c_costo,   
           movi_afiliada,   
           movi_cant_remanente,   
           movi_cierre_mensual,   
           movi_estado_pase_conta,   
           movi_transac_rever,   
           movi_subtran_rever,   
           movi_doc_reversado,   
           movi_deposito,   
           movi_cant_depo_ante,   
           movi_saldo,   
           movi_empresa_origen,   
           movi_documento_origen,   
           movi_tran_contado)  
  VALUES ( :str.g_financiero,   
           :str.empresa,   
           'CC',   
           'ND',   
           '8',   
           'INICIAL',   
           2008,   
           :ls_ref,   
           :ll_tercero,   
           :ls_cuenta,   
           :ls_naturaleza,   
           :ld_monto,   
           :ldt_fecha,   
           'SA',   
           'IM',   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           'SALDO INICIAL',   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           :ld_monto,   
           null,   
           null,   
           'N')  ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('',sqlca.sqlerrtext,1,1,'E')
					rollback;
					return
				end if
		
	end if
	
next
commit;
gf_mensaje('','Creacion Exitosa',1,1,'E')

end event

type dw_2 from datawindow within w_subir_saldos_clientes
integer x = 1330
integer y = 52
integer width = 1696
integer height = 1544
integer taborder = 10
string title = "none"
string dataobject = "dw_saldos_iniciales_pasar_arriba"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_subir_saldos_clientes
integer x = 114
integer y = 64
integer width = 1161
integer height = 1472
integer taborder = 10
string title = "none"
string dataobject = "dw_subir_saldos_iniciales"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

