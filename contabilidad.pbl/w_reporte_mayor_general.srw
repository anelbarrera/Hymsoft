//objectcomments Consulta de transacciones de clientes Vista Previa
forward
global type w_reporte_mayor_general from w_fa_padre_reportes
end type
type dw_2 from datawindow within w_reporte_mayor_general
end type
type cb_consultar from commandbutton within w_reporte_mayor_general
end type
type cb_2 from commandbutton within w_reporte_mayor_general
end type
type uo_1 from u_ddcalen within w_reporte_mayor_general
end type
type uo_2 from u_ddcalen within w_reporte_mayor_general
end type
type cbx_ver_monto from checkbox within w_reporte_mayor_general
end type
type dw_3 from datawindow within w_reporte_mayor_general
end type
type st_1 from statictext within w_reporte_mayor_general
end type
type st_2 from statictext within w_reporte_mayor_general
end type
type dw_4 from datawindow within w_reporte_mayor_general
end type
end forward

global type w_reporte_mayor_general from w_fa_padre_reportes
integer width = 4457
integer height = 2680
string title = "Mayor General de Transacciones"
<<<<<<< HEAD
=======
string menuname = "m_hs"
boolean controlmenu = false
>>>>>>> feature/Inventario
boolean minbox = false
boolean maxbox = false
long backcolor = 12639424
dw_2 dw_2
cb_consultar cb_consultar
cb_2 cb_2
uo_1 uo_1
uo_2 uo_2
cbx_ver_monto cbx_ver_monto
dw_3 dw_3
st_1 st_1
st_2 st_2
dw_4 dw_4
end type
global w_reporte_mayor_general w_reporte_mayor_general

type variables
str_fa_ventafact str_informe
datawindowchild idwc_cuenta
integer ii_banco
string is_cuenta, is_cuenta_itbm, is_user

end variables

forward prototypes
public function string wf_buscar_cuenta_contable ()
public subroutine wf_setear_user (string as_user)
end prototypes

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

dw_2.setitem(dw_2.getrow(),'cuenta',ls_codigo1)
dw_2.setitem(dw_2.getrow(),'codigo',ls_codigo1)
dw_2.accepttext()

dw_2.setcolumn('cuenta')


return ls_codigo1
end function

public subroutine wf_setear_user (string as_user);is_user = as_user
end subroutine

on w_reporte_mayor_general.create
int iCurrent
call super::create
<<<<<<< HEAD
=======
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_hs" then this.MenuID = create m_hs
>>>>>>> feature/Inventario
this.dw_2=create dw_2
this.cb_consultar=create cb_consultar
this.cb_2=create cb_2
this.uo_1=create uo_1
this.uo_2=create uo_2
this.cbx_ver_monto=create cbx_ver_monto
this.dw_3=create dw_3
this.st_1=create st_1
this.st_2=create st_2
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_consultar
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.uo_2
this.Control[iCurrent+6]=this.cbx_ver_monto
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.dw_4
end on

on w_reporte_mayor_general.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.cb_consultar)
destroy(this.cb_2)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.cbx_ver_monto)
destroy(this.dw_3)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_4)
end on

event ue_post_open;//override
string  ls_dinero, ls_tran, ls_documento, ls_stran, ls_ref, ls_cuenta, ls_masca
Integer li_ann, li_banco
datetime ldt_desde, ldt_hasta
datawindowchild ldwc_child

ldt_desde = datetime(relativedate(date(gf_fecha_serv()), - 30),00:00:00)
ldt_hasta = datetime(date(gf_fecha_serv()),23:59:59)
dw_3.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_2.getchild('cuenta', idwc_cuenta)
idwc_cuenta.settransobject(sqlca)
idwc_cuenta.retrieve(str.g_financiero, str.empresa)
dw_2.insertrow(1)
dw_2.setitem(1,'fecha1',ldt_desde)
dw_2.setitem(1,'fecha2',ldt_hasta)
dw_2.setfocus()
dw_2.setcolumn('codigo')
str_cc_formatos lstr_sec
lstr_sec = Message.PowerObjectParm

dw_1.getchild('ddia_mg_cuenta_1', ldwc_child)
ldwc_child.settransobject(sqlca)
ldwc_child.retrieve(str.g_financiero, str.empresa)

dw_4.getchild('modulo', ldwc_child)
ldwc_child.settransobject(sqlca)
ldwc_child.retrieve(str.g_financiero, str.empresa)
ldwc_child.insertrow(1)
dw_4.insertrow(1)

dw_3.getchild('transaccion', ldwc_child)
ldwc_child.settransobject(sqlca)
ldwc_child.retrieve(str.g_financiero, str.empresa)
ldwc_child.insertrow(1)
dw_3.insertrow(1)

ls_masca = gf_mascara()
dw_1.MODIFY("ddia_mg_cuenta.editmask.mask='"+ls_masca+"'") //cuenta que se graba en el detalle contable

//Para setear el nombre de la Cia. al DW de impresion.
If dw_1.Describe("nom_empresa.x") <> "?" And dw_1.Describe("nom_empresa.x") <> "!" Then
//	dw_1.object.nom_empresa.expression = "'"+ gf_dg_nombre_empresa() +"'"
End If	

//dw_1.object.datawindow.print.preview = True
//dw_1.object.datawindow.print.preview.zoom = 100
end event

event resize;//Override
//this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 378

//this.SetRedraw(true)
end event

event open;call super::open;//str_informe = Message.PowerObjectParm
this.y = 0
this.x = 805
//this.width  = 2680// this.width - 99
this.height = this.height - 90
string ls_mes = ''
gf_mes_de_proceso(ls_mes)
this.title = this.title + ls_mes 
end event

<<<<<<< HEAD
=======
event close;Window lw_frame

lw_frame = ParentWindow()

If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_sheet_closed")
 End If
 Close(this)
end event

>>>>>>> feature/Inventario
type st_ayuda from w_fa_padre_reportes`st_ayuda within w_reporte_mayor_general
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_reporte_mayor_general
boolean visible = false
integer x = 32
integer y = 1384
integer width = 55
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_reporte_mayor_general
integer x = 41
integer y = 200
integer width = 4119
integer height = 2256
string dataobject = "dw_reporte_mayor_general"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::doubleclicked;call super::doubleclicked;string         ls_pointer
long           li_fila
datetime       ldt_fecha1
window		   lw_child
str_rangofecha	str_rangofecha_opcion
str_fa_bus_var str_busqueda

//If pos(upper(str.nombre_empresa),'ELECTROVISION') > 0 Then 
if w_fa_fondo.str_aplica_links.habilita_links = 1	then
	ls_pointer = dw_1.GetObjectAtPointer()
	li_fila = integer(trim(mid(ls_pointer,7)))
	if pos(ls_pointer,'numero') > 0 then 
		str_rangofecha_opcion.opcion = 'Kardex'
		str_rangofecha_opcion.orden = dw_1.getitemstring(li_fila,'fact_no_factura')
		if w_fa_fondo.str_aplica_links.factura_activa_fa = 'A' then
			OpenSheetWithParm(lw_child,str_rangofecha_opcion,"w_fa_co_facturas_cab_det_99_e",str.frame,11,Original!)
		end if
	else
		if pos(ls_pointer,'nomcli') > 0 then 
			str_rangofecha_opcion.opcion = 'Kardex'
			str_rangofecha_opcion.cliente = dw_1.getitemnumber(li_fila,'terc_tercero')
//			ldt_fecha1 = dw_1.getitemdatetime(li_fila,'fact_fecha')
			str_rangofecha_opcion.fecha1 = date('01/01/1990')
			if w_fa_fondo.str_aplica_links.cxc_activa_cc = 'A' then
				OpenSheetWithParm(lw_child,str_rangofecha_opcion,"w_fa_co_mov_cliente_saldo",str.frame,11,Original!)
			end if
		end if
	end if
end if 

//	dw_3.Object.dmov_secuencia.Pointer = 'Cross!'

end event

event dw_1::ue_microayuda;////override
////Para cuando pasa por encima del objeto
////Override

end event

event dw_1::clicked;call super::clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto, ls_column, ls_documento, ls_referencia, ls_tran, ls_stran, ls_banco_cuenta, ls_aplicacion, ls_cuenta
integer li_pos , li_ann, li_linea
String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error
integer li_c, li_b
long    ll_lter, ll_encontro
		
	str_dg_dynamic_find	lstr_df
ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

ls_column = dwo.name

if ls_column = 'diar_no_documento' then
	if row = 0 then return
	
	str_secuencia_doc lstr_sec
	lstr_sec.ano = dw_1.getitemNumber(row,"cotdiari_diar_ann")
	lstr_sec.sec_manual = dw_1.getitemstring(row,"diar_no_documento")
	lstr_sec.tran	= dw_1.getitemstring(row,"cotdiari_diar_tipo_transaccion")
	lstr_sec.subtran	= dw_1.getitemstring(row,"cotdiari_diar_sub_trans")	
	lstr_sec.aplicacion = dw_1.getitemstring(row,"coddiari_ddia_aplicacion_mg")	
	lstr_sec.banco_cuenta = dw_1.getitemstring(row,"cotdiari_diar_banco_cuenta")	
	opensheetwithparm(w_consulta_transacciones_conta, lstr_sec,str.frame,2,original!)
elseif ls_column = 'b_cambiar' then 
	//if gf_mensaje('','Esta Seguro de Cambiar la Cuenta ?',2,1,'Q') = 2 then return
	
	OpenWithParm(w_clave_autorizada, w_reporte_mayor_general)
	If is_user = "*" then return

	
	li_ann = dw_1.getitemNumber(row,"cotdiari_diar_ann")
	ls_documento = dw_1.getitemstring(row,"diar_no_documento")
	ls_referencia = dw_1.getitemstring(row,"cotdiari_diar_no_referencia")
	ls_tran	= dw_1.getitemstring(row,"cotdiari_diar_tipo_transaccion")
	ls_stran	= dw_1.getitemstring(row,"cotdiari_diar_sub_trans")	
	ls_aplicacion  = dw_1.getitemstring(row,"coddiari_ddia_aplicacion_mg")	
	ls_banco_cuenta = dw_1.getitemstring(row,"cotdiari_diar_banco_cuenta")	
	li_linea = dw_1.getitemNumber(row,"coddiari_ddia_linea")
	ls_cuenta = dw_1.getitemstring(row,"ddia_mg_cuenta")	
	

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
				
				
				If len (ls_find) = 0 Then Return
							
				ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
				gf_replace_cadena(ls_codigo1,"'"," ")
				ls_codigo1 = Trim(ls_codigo1)

		if gf_mensaje('','Esta Seguro de Cambiar la Cuenta '+ls_cuenta+' Por la Cuenta '+ls_codigo1+' ?',2,1,'Q') = 2 then return
			
			  UPDATE coddiari  
			     SET ddia_mg_cuenta = :ls_codigo1,
				  			ddia_usuario_cambio_cuenta = :is_user,
							ddia_fecha_cambio_cuenta = getdate()
			   WHERE ( coddiari.ddia_g_financiero = :str.g_financiero ) AND  
			         ( coddiari.ddia_empresa = :str.empresa ) AND  
			         ( coddiari.ddia_aplicacion_mg = :ls_aplicacion ) AND  
			         ( coddiari.ddia_tipo_transaccion = :ls_tran ) AND  
			         ( coddiari.ddia_sub_trans = :ls_stran ) AND  
			         ( coddiari.ddia_no_documento = :ls_documento ) AND  
			         ( coddiari.ddia_no_referencia = :ls_referencia ) AND  
			         ( coddiari.ddia_banco_cuenta = :ls_banco_cuenta ) AND  
			         ( coddiari.ddia_ann = :li_ann ) AND  
			         ( coddiari.ddia_linea = :li_linea ) AND  
			         ( coddiari.ddia_mg_cuenta = :ls_cuenta )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Cambiar Cuenta '+sqlca.sqlerrtext,1,1,'Q')
						rollback;
						return
					end if
					
					commit;
					
					cb_consultar.triggerevent('clicked')
					
end if
end event

event dw_1::retrieveend;call super::retrieveend;//string ls_cuenta, ls_documento, ls_referencia, ls_aplicacion, ls_transaccion, ls_sub_transaccion
//integer i, li_ann
//decimal{2} ld_monto
//ls_cuenta = dw_2.getitemstring(1,'codigo')
//if ls_cuenta = '' then return
//if ls_cuenta = is_cuenta_itbm and cbx_ver_monto.checked then
//	for i = 1 to rowcount
//		ld_monto = 0.00
//		ls_documento = this.getitemstring(i, 'diar_no_documento')
//		li_ann	= this.getitemnumber(i,'cotdiari_diar_ann')		
//		ls_referencia  = this.getitemstring(i, 'diar_no_referencia')		
//		ls_aplicacion   = this.getitemstring(i,'coddiari_ddia_aplicacion_mg')
//		ls_transaccion = this.getitemstring(i,'cotdiari_diar_tipo_transaccion')
//		ls_sub_transaccion = this.getitemstring(i,'cotdiari_diar_sub_trans')
//		choose case ls_aplicacion
//			case 'CP'
//				  SELECT isnull(cptmovim.movi_monto  ,0)
//					 INTO :ld_monto  
//					 FROM cptmovim  
//					WHERE ( cptmovim.movi_g_financiero = :str.g_financiero ) AND  
//							( cptmovim.movi_empresa = :str.empresa ) AND  
//							( cptmovim.movi_aplicacion = 'CP' ) AND  
//							( cptmovim.movi_tipo_transaccion = :ls_transaccion ) AND  
//							( cptmovim.movi_sub_transaccion = :ls_sub_transaccion ) AND  
//							( cptmovim.movi_documento = :ls_documento ) AND  
//							( cptmovim.movi_anno = :li_ann ) AND  
//							( cptmovim.movi_referencia = :ls_referencia )   ;
//							if sqlca.sqlcode = -1 then
//								gf_mensaje('','Error al Buscar Monto CXP '+sqlca.sqlerrtext,1,1,'E')
//							end if
//				
//			case 'FA'
//					  SELECT fatdiari.fact_monto_final  
//						 INTO :ld_monto  
//						 FROM fatdiari  
//						WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
//								( fatdiari.fact_empresa = :str.empresa ) AND  
//								( fatdiari.fact_tipo = :ls_sub_transaccion ) AND  
//								( fatdiari.fact_no_pedido = :ls_referencia ) AND  
//								( fatdiari.fact_ann = :li_ann ) AND  
//								( fatdiari.fact_no_factura = :ls_documento )   ;
//							if sqlca.sqlcode = -1 then
//								gf_mensaje('','Error al Buscar Monto FA '+sqlca.sqlerrtext,1,1,'E')
//							end if
//		end choose
//		this.setitem(i,'valor_total',ld_monto)
//	next
//end if
//
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_reporte_mayor_general
boolean visible = false
integer x = 27
integer y = 192
integer width = 2967
integer height = 1364
long backcolor = 12639424
end type

type dw_2 from datawindow within w_reporte_mayor_general
event ue_down pbm_dwnkey
integer x = 50
integer y = 72
integer width = 1481
integer height = 120
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_reporte_cuentas"
boolean border = false
boolean livescroll = true
end type

event ue_down;// Toma la Tecla que el usuario presione
string ls_columna, ls_codigo_cta
CHOOSE CASE key
		
	CASE KeyF1! 
		ls_columna = this.getcolumnname()
		choose case ls_columna
			
			case 'cuenta', 'codigo'				
				ls_codigo_cta = wf_buscar_cuenta_contable()				
				dw_2.trigger event itemchanged(dw_2.getrow(),object,ls_codigo_cta)							
		end choose
		
	CASE	  Keyenter! 
		
//	  This.Triggerevent("ue_entercol")
	  
END CHOOSE
end event

event itemchanged;string ls_nulo, ls_cuenta, ls_masca
integer li_encontro
setnull(ls_nulo)
accepttext()
choose case this.getcolumnname()
	case 'codigo'
		ls_cuenta = this.getitemstring(this.getrow(),'codigo')
		ls_cuenta = left( ls_cuenta + fill("0",20) ,20)
		li_encontro = idwc_cuenta.find("mg_cuenta = '"+ls_cuenta+"'",1,idwc_cuenta.rowcount())
		if li_encontro > 0 then
			this.setitem(this.getrow(),'cuenta',ls_cuenta)
			idwc_cuenta.scrolltorow(li_encontro)
			if ls_cuenta = is_cuenta_itbm then
				cbx_ver_monto.visible = true
			else
				cbx_ver_monto.visible = false
				if cbx_ver_monto.checked then
					cbx_ver_monto.checked = false
					dw_1.dataobject = 'dw_reporte_historico_cuenta'
					dw_1.settransobject(sqlca)
					ls_masca = gf_mascara()
					dw_1.MODIFY("ddia_mg_cuenta.editmask.mask='"+ls_masca+"'") //mascara para el compute de la cuenta
				end if
			end if
		else
			gf_mensaje('','Cuenta no Existe, Verifique !!!',1,1,'E')
			this.setitem(this.getrow(),'codigo','')
			this.setitem(this.getrow(),'cuenta','')
			return 2
		end if
		cb_consultar.triggerevent('clicked')
	case 'cuenta'
		ls_cuenta = this.getitemstring(this.getrow(),'cuenta')
		ls_cuenta = left( ls_cuenta + fill("0",20) ,20)
		this.setitem(this.getrow(),'codigo',ls_cuenta)	
		if ls_cuenta = is_cuenta_itbm then
			cbx_ver_monto.visible = true
		else
			cbx_ver_monto.visible = false
			if cbx_ver_monto.checked then
				cbx_ver_monto.checked = false
				dw_1.dataobject = 'dw_reporte_historico_cuenta'
				dw_1.settransobject(sqlca)
				ls_masca = gf_mascara()
				dw_1.MODIFY("ddia_mg_cuenta.editmask.mask='"+ls_masca+"'") //mascara para el compute de la cuenta
			end if
		end if
		
		cb_consultar.triggerevent('clicked')		
	case 'fecha1'
		this.setcolumn('fecha2')
end choose
end event

event clicked;date 	ld_date,ld_ini_date, ld_hoy
ld_hoy = date(gf_fecha_serv())
accepttext()

CHOOSE CASE dwo.name
	case 'calendario'
		ld_ini_date=date(this.GetItemDateTime(this.getrow(),"fecha1"))
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
	case 'calendario1'
		ld_ini_date=date(this.GetItemDateTime(this.getrow(),"fecha2"))
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

end choose
end event

type cb_consultar from commandbutton within w_reporte_mayor_general
integer x = 3483
integer y = 72
integer width = 343
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;string ls_dinero, ls_tran, ls_documento, ls_fecha_text, ls_naturaleza_cuenta, ls_descrip_cuenta
integer li_ann
datetime ldt_desde, ldt_hasta
date ldt_fecha_anterior
decimal{2} ld_saldo_anterior
dw_2.accepttext()

ldt_desde = datetime(date(dw_2.getitemdatetime(1,'fecha1')),00:00:00)
ldt_hasta = datetime(date(dw_2.getitemdatetime(1,'fecha2')),23:59:59)
//ii_banco = dw_2.getitemnumber(1,'banco')
//is_cuenta = dw_2.getitemstring(1,'cuenta')
//ls_naturaleza_cuenta = idwc_cuenta.getitemstring(idwc_cuenta.getrow(),'mg_naturaleza')
//ls_descrip_cuenta    = idwc_cuenta.getitemstring(idwc_cuenta.getrow(),'mg_descripcion')

if dw_1.retrieve(str.g_financiero, str.empresa, ldt_desde, ldt_hasta) > 0 then
//	ld_saldo_anterior = gf_saldo_anterior_co(is_cuenta, ldt_desde)	
//	if ld_saldo_anterior <> 0 then
//		dw_1.RowsCopy(1, 1, Primary!, dw_1, 1, Primary!)
//		ldt_fecha_anterior = RelativeDate(date(ldt_desde), -1)
//		if ls_naturaleza_cuenta = 'D' then
//			if ld_saldo_anterior > 0 then
//				dw_1.setitem(1,'coddiari_ddia_naturaleza','D')
//			else
//				dw_1.setitem(1,'coddiari_ddia_naturaleza','C')						
//			end if
//		else
//			if ld_saldo_anterior > 0 then
//				dw_1.setitem(1,'coddiari_ddia_naturaleza','D')
//			else
//				dw_1.setitem(1,'coddiari_ddia_naturaleza','C')						
//			end if			
//		end if
//		dw_1.setitem(1,'coddiari_ddia_monto',abs(ld_saldo_anterior))					
//		dw_1.setitem(1,'saldo_ini',abs(ld_saldo_anterior))
//		dw_1.setitem(1,'cotdiari_diar_nombre','SALDO ANTERIOR')
//		dw_1.setitem(1,'cotdiari_diar_descripcion','Balance')
//		dw_1.setitem(1,'diar_no_documento','')
//		dw_1.setitem(1,'coddiari_ddia_aplicacion_mg','')
//		dw_1.setitem(1,'diar_fecha_transaccion',ldt_fecha_anterior)
//		if cbx_ver_monto.checked then
//			dw_1.setitem(1,'diar_monto',0)
//		end if
//	end if
//else
//	
//	ld_saldo_anterior = gf_saldo_anterior_co(is_cuenta, ldt_desde)	
//	if ld_saldo_anterior <> 0 then
//		dw_1.insertrow(1)
//		ldt_fecha_anterior = RelativeDate(date(ldt_desde), -1)
//		if ls_naturaleza_cuenta = 'D' then
//			if ld_saldo_anterior > 0 then
//				dw_1.setitem(1,'coddiari_ddia_naturaleza','D')
//			else
//				dw_1.setitem(1,'coddiari_ddia_naturaleza','C')						
//			end if
//		else
//			if ld_saldo_anterior > 0 then
//				dw_1.setitem(1,'coddiari_ddia_naturaleza','D')
//			else
//				dw_1.setitem(1,'coddiari_ddia_naturaleza','C')						
//			end if			
//		end if		
//		dw_1.setitem(1,'coddiari_ddia_monto',abs(ld_saldo_anterior))
//		dw_1.setitem(1,'saldo_ini',abs(ld_saldo_anterior))
//		dw_1.setitem(1,'cotdiari_diar_nombre','SALDO ANTERIOR')
//		dw_1.setitem(1,'cotdiari_diar_descripcion','Balance')
//		dw_1.setitem(1,'diar_no_documento','')
//		dw_1.setitem(1,'coddiari_ddia_aplicacion_mg','')		
//		dw_1.setitem(1,'diar_fecha_transaccion',ldt_fecha_anterior)
//		dw_1.setitem(1,'ddia_mg_cuenta',is_cuenta )
//		dw_1.setitem(1,'dgmplanc_mg_descripcion',ls_descrip_cuenta )		
//	else	
//		gf_mensaje('','No Hay Movimientos para el Periodo Solicitado, Verifique!!!',1,1,'E')
//		return
//	end if
end if		


String	ls_expresion
Integer	li_pos
//Setea fecha
ls_expresion = string(date(gf_fecha_serv()))
dw_1.object.fecha.expression = "'"+ls_expresion+"'"
//Setea hora
ls_expresion = string(gf_fecha_serv(), "dd/mm/yyyy hh:mm AM/PM")
li_pos = Pos(ls_expresion," ")

ls_expresion = Right(ls_expresion, Len(ls_expresion) - li_pos)		
	
dw_1.object.hora.expression = "'"+ls_expresion+"'"
//titulo
ls_fecha_text = 'Desde '+gf_fecha_palabras_datetime(ldt_desde)+'  Hasta '+gf_fecha_palabras_datetime(ldt_hasta)
dw_1.object.titulo.expression = "'"+ls_fecha_text+"'"
dw_1.object.nom_empresa.expression = "'"+str.nombre_empresa+"'"

If dw_1.Describe("ruc.x") <> "?" And dw_1.Describe("ruc.x") <> "!" Then
	dw_1.object.ruc.expression = "'"+ str.ruc+ ' D.V. '+str.dv +"'"	
End If	

dw_1.groupcalc()
dw_1.object.datawindow.print.preview = True
dw_1.object.datawindow.print.preview.zoom = 100
dw_1.setfocus()
end event

type cb_2 from commandbutton within w_reporte_mayor_general
integer x = 3863
integer y = 72
integer width = 343
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
end type

event clicked;parent.triggerevent('close')
end event

type uo_1 from u_ddcalen within w_reporte_mayor_general
boolean visible = false
integer x = 50
integer y = 164
integer taborder = 40
boolean bringtotop = true
end type

on uo_1.destroy
call u_ddcalen::destroy
end on

event ue_clicked;call super::ue_clicked;dw_2.SetItem ( dw_2.getrow(), 'fecha1', uo_1.return_sel_date() )

if uo_1.allow_close then
	this.visible=false
	dw_2.SetFocus()
end if
end event

event destructor;call super::destructor;call u_ddcalen::destroy
end event

type uo_2 from u_ddcalen within w_reporte_mayor_general
boolean visible = false
integer x = 741
integer y = 160
integer taborder = 50
boolean bringtotop = true
end type

on uo_2.destroy
call u_ddcalen::destroy
end on

event ue_clicked;call super::ue_clicked;dw_2.SetItem ( dw_2.getrow(), 'fecha2', uo_2.return_sel_date() )

if uo_2.allow_close then
	this.visible=false
	dw_2.SetFocus()
end if
end event

event destructor;call super::destructor;call u_ddcalen::destroy
end event

type cbx_ver_monto from checkbox within w_reporte_mayor_general
boolean visible = false
integer x = 2432
integer y = 124
integer width = 599
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Ver Monto del ITBM"
end type

event clicked;string ls_masca
if this.checked then
	dw_1.dataobject = 'dw_reporte_historico_cuenta_itbm'
else
	dw_1.dataobject = 'dw_reporte_historico_cuenta'
end if
dw_1.settransobject(sqlca)
ls_masca = gf_mascara()
dw_1.MODIFY("ddia_mg_cuenta.editmask.mask='"+ls_masca+"'") //mascara para el compute de la cuenta

end event

type dw_3 from datawindow within w_reporte_mayor_general
integer x = 1527
integer y = 84
integer width = 1106
integer height = 96
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_transaccion_conta"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_transaccion

this.accepttext()

ls_transaccion = data
if isnull(ls_transaccion) then ls_transaccion = ''
if ls_transaccion = '' then
	dw_1.setfilter('')
else
	dw_1.setfilter('cotdiari_diar_tipo_transaccion = "' + ls_transaccion+'"')
end if

dw_1.filter()
end event

type st_1 from statictext within w_reporte_mayor_general
integer x = 1797
integer y = 16
integer width = 512
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 553648127
string text = "Transaccion"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_reporte_mayor_general
integer x = 2793
integer y = 20
integer width = 512
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 553648127
string text = "Modulo"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_4 from datawindow within w_reporte_mayor_general
integer x = 2711
integer y = 84
integer width = 713
integer height = 88
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_modulo"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_transaccion

this.accepttext()

ls_transaccion = data
if isnull(ls_transaccion) then ls_transaccion = ''
if ls_transaccion = '' then
	dw_1.setfilter('')
else
	dw_1.setfilter('coddiari_ddia_aplicacion_mg = "' + ls_transaccion+'"')
end if

dw_1.filter()
end event

