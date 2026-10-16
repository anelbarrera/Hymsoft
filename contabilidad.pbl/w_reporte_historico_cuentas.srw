//objectcomments Consulta de transacciones de clientes Vista Previa
forward
global type w_reporte_historico_cuentas from w_fa_padre_reportes
end type
type dw_2 from datawindow within w_reporte_historico_cuentas
end type
type cb_consultar from commandbutton within w_reporte_historico_cuentas
end type
type cb_2 from commandbutton within w_reporte_historico_cuentas
end type
type uo_1 from u_ddcalen within w_reporte_historico_cuentas
end type
type uo_2 from u_ddcalen within w_reporte_historico_cuentas
end type
end forward

global type w_reporte_historico_cuentas from w_fa_padre_reportes
integer width = 4398
integer height = 2680
string title = "Reporte Historico de Transacciones por Cuenta"
string menuname = "m_hs"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
long backcolor = 12639424
windowanimationstyle openanimation = leftroll!
windowanimationstyle closeanimation = leftslide!
dw_2 dw_2
cb_consultar cb_consultar
cb_2 cb_2
uo_1 uo_1
uo_2 uo_2
end type
global w_reporte_historico_cuentas w_reporte_historico_cuentas

type variables
str_fa_ventafact str_informe
datawindowchild idwc_cuenta, idwc_cuenta2
integer ii_banco
string is_cuenta, is_cuenta2, is_masca

end variables

forward prototypes
public function string wf_buscar_cuenta_contable ()
public function string wf_buscar_cuenta_contable2 ()
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
	lstr_df.texto_campo [1,5] = '1800'		
	lstr_df.texto_campo [3,1] = "case when dgmplanc.mg_tipo_cuenta = 'R' then 'RESUMEN' else 'DETALLE' end mg_tipo_cuenta"
	lstr_df.texto_campo [3,2] = "Tipo"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'I'
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

public function string wf_buscar_cuenta_contable2 ();String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error
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
	lstr_df.texto_campo [1,5] = '1800'		
	lstr_df.texto_campo [3,1] = "case when dgmplanc.mg_tipo_cuenta = 'R' then 'RESUMEN' else 'DETALLE' end mg_tipo_cuenta"
	lstr_df.texto_campo [3,2] = "Tipo"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'I'
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

dw_2.setitem(dw_2.getrow(),'cuenta2',ls_codigo1)
dw_2.setitem(dw_2.getrow(),'codigo2',ls_codigo1)
dw_2.accepttext()

dw_2.setcolumn('cuenta2')


return ls_codigo1
end function

on w_reporte_historico_cuentas.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.dw_2=create dw_2
this.cb_consultar=create cb_consultar
this.cb_2=create cb_2
this.uo_1=create uo_1
this.uo_2=create uo_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_consultar
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.uo_2
end on

on w_reporte_historico_cuentas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.cb_consultar)
destroy(this.cb_2)
destroy(this.uo_1)
destroy(this.uo_2)
end on

event ue_post_open;//override
string  ls_dinero, ls_tran, ls_documento, ls_stran, ls_ref, ls_cuenta, ls_masca
Integer li_ann, li_banco
datetime ldt_desde, ldt_hasta

ldt_desde = datetime(relativedate(date(gf_fecha_serv()), - 30),00:00:00)
ldt_hasta = datetime(date(gf_fecha_serv()),23:59:59)

dw_2.settransobject(sqlca)
dw_2.getchild('cuenta', idwc_cuenta)
idwc_cuenta.settransobject(sqlca)
idwc_cuenta.retrieve(str.g_financiero, str.empresa)
dw_2.getchild('cuenta2', idwc_cuenta2)
idwc_cuenta2.settransobject(sqlca)
idwc_cuenta2.retrieve(str.g_financiero, str.empresa)
dw_2.insertrow(1)

dw_2.setitem(1,'fecha1',ldt_desde)
dw_2.setitem(1,'fecha2',ldt_hasta)
dw_2.setfocus()
dw_2.setcolumn('codigo')
str_cc_formatos lstr_sec
lstr_sec = Message.PowerObjectParm

ls_masca = gf_mascara()
is_masca = ls_masca
dw_2.MODIFY("codigo.editmask.mask='"+ls_masca+"'") //mascara para el compute de la cuenta
dw_2.MODIFY("codigo2.editmask.mask='"+ls_masca+"'")

if isvalid(lstr_sec) then 
	ls_cuenta = lstr_sec.cuenta
	ldt_desde = lstr_sec.fecha1
	ldt_hasta = lstr_sec.fecha2	
	dw_2.setitem(1,'codigo', ls_cuenta)
	dw_2.setitem(1,'cuenta', ls_cuenta)
	dw_2.setitem(1,'fecha1',ldt_desde)
	dw_2.setitem(1,'fecha2',ldt_hasta)
	dw_2.accepttext()
end if

if ls_cuenta <> '' and not isnull(ls_cuenta) then
	dw_1.settransobject(sqlca)	
	cb_consultar.triggerevent('clicked')
//	if dw_1.retrieve(str.g_financiero, str.empresa, li_banco, ls_cuenta, ldt_desde, ldt_hasta) = 0 then
//		gf_mensaje('','Transaccion no Registrada, Verifique!!!',1,1,'E')
//		return
//	end if		
end if

idwc_cuenta.MODIFY("mg_cuenta.editmask.mask='"+ls_masca+"'") //cuenta que se graba en el detalle contable
idwc_cuenta2.MODIFY("mg_cuenta.editmask.mask='"+ls_masca+"'") 
dw_1.MODIFY("ddia_mg_cuenta.editmask.mask='"+ls_masca+"'") //cuenta que se graba en el detalle contable

//Para setear el nombre de la Cia. al DW de impresion.
If dw_1.Describe("nom_empresa.x") <> "?" And dw_1.Describe("nom_empresa.x") <> "!" Then
//	dw_1.object.nom_empresa.expression = "'"+ gf_dg_nombre_empresa() +"'"
End If	
//
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

event ue_save_as;call super::ue_save_as;if str.maquina = 'PBM-INT-MIA' then
	Run("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")
end if
end event

event close;Window lw_frame

lw_frame = ParentWindow()

If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_sheet_closed")
 End If
 Close(this)
end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_reporte_historico_cuentas
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_reporte_historico_cuentas
boolean visible = false
integer x = 32
integer y = 1384
integer width = 55
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_reporte_historico_cuentas
integer x = 41
integer y = 200
integer width = 4297
integer height = 2256
string dataobject = "dw_reporte_historico_cuenta"
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

event dw_1::ue_microayuda;//override
//Para cuando pasa por encima del objeto
//Override

end event

event dw_1::clicked;call super::clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto, ls_column
integer li_pos 

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

ls_column = dwo.name

if ls_column = 'diar_no_documento' or ls_column = 'cotdiari_diar_no_referencia' then
	if row = 0 then return
	
	str_secuencia_doc lstr_sec
	lstr_sec.ano = dw_1.getitemNumber(row,"cotdiari_diar_ann")
	lstr_sec.sec_manual = dw_1.getitemstring(row,"diar_no_documento")
	lstr_sec.referencia = dw_1.getitemstring(row,"cotdiari_diar_no_referencia")
	lstr_sec.tran	= dw_1.getitemstring(row,"cotdiari_diar_tipo_transaccion")
	lstr_sec.subtran	= dw_1.getitemstring(row,"cotdiari_diar_sub_trans")	
	lstr_sec.aplicacion = dw_1.getitemstring(row,"coddiari_ddia_aplicacion_mg")	
	lstr_sec.banco_cuenta = dw_1.getitemstring(row,"cotdiari_diar_banco_cuenta")	
	opensheetwithparm(w_consulta_transacciones_conta, lstr_sec,str.frame,2,original!)
	
end if
end event

event dw_1::retrieveend;call super::retrieveend;string ls_cuenta, ls_tran, ls_documento, ls_fecha_text, ls_naturaleza_cuenta, ls_descrip_cuenta, ls_cuenta_temp, ls_cuenta2
integer li_ann 
long ll_registros, i, ll_total, li_encontro
datetime ldt_desde, ldt_hasta
date ldt_fecha_anterior
decimal{2} ld_saldo_anterior
dw_2.accepttext()
if rowcount = 0 then return
if dw_2.getitemnumber(1,'rango') = 0 then return

ldt_desde = datetime(date(dw_2.getitemdatetime(1,'fecha1')),00:00:00)
ldt_fecha_anterior = RelativeDate(date(ldt_desde), -1)
ll_total = dw_1.rowcount()
		
for i = 1 to ll_total
	   yield()
		str.frame.setmicrohelp('Procesando Registro '+string(i)+' de '+string(ll_total))
		ls_cuenta = dw_1.getitemstring(i,'ddia_mg_cuenta')
		ls_naturaleza_cuenta = dw_1.getitemstring(i,'mg_naturaleza')
		if ls_cuenta <> ls_cuenta_temp then		
			ls_cuenta_temp = ls_cuenta
			ld_saldo_anterior = gf_saldo_anterior_co(ls_cuenta, ldt_desde)	
			if ld_saldo_anterior <> 0 then
				dw_1.RowsCopy(i, i, Primary!, dw_1, i, Primary!)
				ll_total ++
				if ls_naturaleza_cuenta = 'D' then
					if ld_saldo_anterior > 0 then
						dw_1.setitem(i,'coddiari_ddia_naturaleza','D')
					else
						dw_1.setitem(i,'coddiari_ddia_naturaleza','C')						
					end if
				else
					if ld_saldo_anterior > 0 then
						dw_1.setitem(i,'coddiari_ddia_naturaleza','D')
					else
						dw_1.setitem(i,'coddiari_ddia_naturaleza','C')						
					end if			
				end if
				dw_1.setitem(i,'coddiari_ddia_monto',abs(ld_saldo_anterior))					
				dw_1.setitem(i,'saldo_ini',abs(ld_saldo_anterior))
				dw_1.setitem(i,'cotdiari_diar_nombre','SALDO ANTERIOR')
				dw_1.setitem(i,'cotdiari_diar_descripcion','Balance')
				dw_1.setitem(i,'diar_no_documento','')
				dw_1.setitem(i,'cotdiari_diar_no_referencia','')		
				dw_1.setitem(i,'diar_fecha_transaccion',ldt_fecha_anterior)
			end if
		end if //Del ls_cuenta <> ls_cuenta_temp
next

ls_cuenta = dw_2.getitemstring(1,'cuenta')
ls_cuenta2 = dw_2.getitemstring(1,'cuenta2')

 DECLARE cur_cuentas CURSOR FOR  
  SELECT dgmplanc.mg_cuenta,   
         dgmplanc.mg_descripcion,   
         dgmplanc.mg_naturaleza  
    FROM dgmplanc  
   WHERE ( dgmplanc.mg_g_financiero = 1 ) AND  
         ( dgmplanc.mg_empresa = 1 ) AND  
         ( dgmplanc.mg_estado = 1 ) AND  
         ( dgmplanc.mg_tipo_cuenta = 'D' ) AND  
			( substring(dgmplanc.mg_cuenta,1,20) >= substring(:ls_cuenta,1,20) ) AND  
         ( substring(dgmplanc.mg_cuenta,1,20) <= substring(:ls_cuenta2,1,20) ) ;  
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al Declarar Cursor '+sqlca.sqlerrtext,1,1,'E')
	end if
	
	open cur_cuentas;
	
	fetch cur_cuentas into :ls_cuenta, :ls_descrip_cuenta, :ls_naturaleza_cuenta ; 

	do while sqlca.sqlcode = 0

	li_encontro = dw_1.find('ddia_mg_cuenta = "'+ls_cuenta+'"', 1, dw_1.rowcount())
	if li_encontro = 0 then
		ld_saldo_anterior = gf_saldo_anterior_co(ls_cuenta, ldt_desde)	
		if ld_saldo_anterior <> 0 then
			dw_1.insertrow(1)
			if ls_naturaleza_cuenta = 'D' then
				if ld_saldo_anterior > 0 then
					dw_1.setitem(1,'coddiari_ddia_naturaleza','D')
				else
					dw_1.setitem(1,'coddiari_ddia_naturaleza','C')						
				end if
			else
				if ld_saldo_anterior > 0 then
					dw_1.setitem(1,'coddiari_ddia_naturaleza','D')
				else
					dw_1.setitem(1,'coddiari_ddia_naturaleza','C')						
				end if			
			end if		
			dw_1.setitem(1,'coddiari_ddia_monto',abs(ld_saldo_anterior))
			dw_1.setitem(1,'saldo_ini',abs(ld_saldo_anterior))
			dw_1.setitem(1,'cotdiari_diar_nombre','SALDO ANTERIOR')
			dw_1.setitem(1,'cotdiari_diar_descripcion','Balance')
			dw_1.setitem(1,'diar_no_documento','')
			dw_1.setitem(1,'diar_fecha_transaccion',ldt_fecha_anterior)
			dw_1.setitem(1,'ddia_mg_cuenta',ls_cuenta )
			dw_1.setitem(1,'dgmplanc_mg_descripcion',ls_descrip_cuenta )		
		end if
	end if
	fetch cur_cuentas into :ls_cuenta, :ls_descrip_cuenta, :ls_naturaleza_cuenta ; 
loop

close cur_cuentas;

dw_1.sort()
dw_1.groupcalc()
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_reporte_historico_cuentas
boolean visible = false
integer x = 27
integer y = 192
integer width = 2967
integer height = 1364
long backcolor = 12639424
end type

type dw_2 from datawindow within w_reporte_historico_cuentas
event ue_down pbm_dwnkey
integer x = 55
integer y = 4
integer width = 3547
integer height = 196
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_reporte_cuentas_rango"
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
			case 'cuenta2', 'codigo2'				
				ls_codigo_cta = wf_buscar_cuenta_contable2()				
				dw_2.trigger event itemchanged(dw_2.getrow(),object,ls_codigo_cta)											
		end choose
		
	CASE	  Keyenter! 
		
//	  This.Triggerevent("ue_entercol")
	  
END CHOOSE
end event

event itemchanged;string ls_nulo, ls_cuenta
integer li_encontro
setnull(ls_nulo)
accepttext()
choose case this.getcolumnname()
	case 'rango'
		if data = '1' then
			dw_1.dataobject = 'dw_reporte_historico_cuenta_rango'
		else
			dw_1.dataobject = 'dw_reporte_historico_cuenta'			
		end if
		dw_1.settransobject(sqlca)
		dw_1.MODIFY("ddia_mg_cuenta.editmask.mask='"+is_masca+"'")
	case 'codigo'
		ls_cuenta = this.getitemstring(this.getrow(),'codigo')
		ls_cuenta = left( ls_cuenta + fill("0",20) ,20)
		li_encontro = idwc_cuenta.find("mg_cuenta = '"+ls_cuenta+"'",1,idwc_cuenta.rowcount())
		if li_encontro > 0 then
			this.setitem(this.getrow(),'cuenta',ls_cuenta)
			idwc_cuenta.scrolltorow(li_encontro)
		else
			gf_mensaje('','Cuenta no Existe, Verifique !!!',1,1,'E')
			this.setitem(this.getrow(),'codigo','')
			this.setitem(this.getrow(),'cuenta','')
			return 2
		end if
		this.accepttext()
		if dw_2.getitemnumber(1,'rango') = 0 then cb_consultar.triggerevent('clicked')
	case 'codigo2'
		ls_cuenta = this.getitemstring(this.getrow(),'codigo2')
		ls_cuenta = left( ls_cuenta + fill("0",20) ,20)
		li_encontro = idwc_cuenta.find("mg_cuenta = '"+ls_cuenta+"'",1,idwc_cuenta.rowcount())
		if li_encontro > 0 then
			this.setitem(this.getrow(),'cuenta2',ls_cuenta)
			idwc_cuenta.scrolltorow(li_encontro)
		else
			gf_mensaje('','Cuenta no Existe, Verifique !!!',1,1,'E')
			this.setitem(this.getrow(),'codigo2','')
			this.setitem(this.getrow(),'cuenta2','')
			return 2
		end if
		this.accepttext()
		if dw_2.getitemnumber(1,'rango') = 0 then cb_consultar.triggerevent('clicked')		
	case 'cuenta'
		ls_cuenta = this.getitemstring(this.getrow(),'cuenta')
		ls_cuenta = left( ls_cuenta + fill("0",20) ,20)
		this.setitem(this.getrow(),'codigo',ls_cuenta)	
		cb_consultar.triggerevent('clicked')		
	case 'cuenta2'
		ls_cuenta = this.getitemstring(this.getrow(),'cuenta2')
		ls_cuenta = left( ls_cuenta + fill("0",20) ,20)
		this.setitem(this.getrow(),'codigo2',ls_cuenta)	
		is_cuenta2 = ls_cuenta
		cb_consultar.triggerevent('clicked')		
	case 'fecha1'
		this.setcolumn('fecha2')
end choose

//string ls_nulo, ls_cuenta
//integer li_encontro
//setnull(ls_nulo)
//accepttext()
//choose case this.getcolumnname()
//	case 'rango'
//		if data = '1' then
//			dw_1.dataobject = 'dw_reporte_historico_cuenta_rango'
//		else
//			dw_1.dataobject = 'dw_reporte_historico_cuenta'			
//		end if
//		dw_1.settransobject(sqlca)
//		dw_1.MODIFY("ddia_mg_cuenta.editmask.mask='"+is_masca+"'")
//	case 'codigo'
//		ls_cuenta = this.getitemstring(this.getrow(),'codigo')
//		ls_cuenta = left( ls_cuenta + fill("0",20) ,20)
//		li_encontro = idwc_cuenta.find("mg_cuenta = '"+ls_cuenta+"'",1,idwc_cuenta.rowcount())
//		if li_encontro > 0 then
//			this.setitem(this.getrow(),'cuenta',ls_cuenta)
//			idwc_cuenta.scrolltorow(li_encontro)
//		else
//			gf_mensaje('','Cuenta no Existe, Verifique !!!',1,1,'E')
//			this.setitem(this.getrow(),'codigo','')
//			this.setitem(this.getrow(),'cuenta','')
//			return 2
//		end if
//		this.accepttext()
//		if dw_2.getitemnumber(1,'rango') = 0 then cb_consultar.triggerevent('clicked')
//	case 'codigo2'
//		ls_cuenta = this.getitemstring(this.getrow(),'codigo2')
//		ls_cuenta = left( ls_cuenta + fill("0",20) ,20)
//		li_encontro = idwc_cuenta.find("mg_cuenta = '"+ls_cuenta+"'",1,idwc_cuenta.rowcount())
//		if li_encontro > 0 then
//			this.setitem(this.getrow(),'cuenta2',ls_cuenta)
//			idwc_cuenta.scrolltorow(li_encontro)
//		else
//			gf_mensaje('','Cuenta no Existe, Verifique !!!',1,1,'E')
//			this.setitem(this.getrow(),'codigo2','')
//			this.setitem(this.getrow(),'cuenta2','')
//			return 2
//		end if
//		this.accepttext()
//		if dw_2.getitemnumber(1,'rango') = 0 then cb_consultar.triggerevent('clicked')		
//	case 'cuenta'
//		ls_cuenta = this.getitemstring(this.getrow(),'cuenta')
//		ls_cuenta = left( ls_cuenta + fill("0",20) ,20)
//		this.setitem(this.getrow(),'codigo',ls_cuenta)	
//		cb_consultar.triggerevent('clicked')		
//	case 'cuenta2'
//		ls_cuenta = this.getitemstring(this.getrow(),'cuenta2')
//		ls_cuenta = left( ls_cuenta + fill("0",20) ,20)
//		this.setitem(this.getrow(),'codigo2',ls_cuenta)	
//		is_cuenta2 = ls_cuenta
//		cb_consultar.triggerevent('clicked')		
//	case 'fecha1'
//		this.setcolumn('fecha2')
//end choose
end event

event clicked;string ls_codigo_cta
date 	ld_date,ld_ini_date, ld_hoy
ld_hoy = date(gf_fecha_serv())
accepttext()

CHOOSE CASE dwo.name
	case 'p_cuenta1'
		ls_codigo_cta = wf_buscar_cuenta_contable()				
		dw_2.trigger event itemchanged(dw_2.getrow(),object,ls_codigo_cta)							
	case 'p_cuenta2'
		ls_codigo_cta = wf_buscar_cuenta_contable2()				
		dw_2.trigger event itemchanged(dw_2.getrow(),object,ls_codigo_cta)							
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

type cb_consultar from commandbutton within w_reporte_historico_cuentas
integer x = 3630
integer y = 36
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
long ll_registros
datetime ldt_desde, ldt_hasta
date ldt_fecha_anterior
decimal{2} ld_saldo_anterior
dw_2.accepttext()

ldt_desde = datetime(date(dw_2.getitemdatetime(1,'fecha1')),00:00:00)
ldt_hasta = datetime(date(dw_2.getitemdatetime(1,'fecha2')),23:59:59)
//ii_banco = dw_2.getitemnumber(1,'banco')
is_cuenta   = dw_2.getitemstring(1,'cuenta')
is_cuenta2 = dw_2.getitemstring(1,'cuenta2')
ls_naturaleza_cuenta = idwc_cuenta.getitemstring(idwc_cuenta.getrow(),'mg_naturaleza')
ls_descrip_cuenta    = idwc_cuenta.getitemstring(idwc_cuenta.getrow(),'mg_descripcion')
if dw_2.getitemnumber(1,'rango') = 0 then
	ll_registros = dw_1.retrieve(str.g_financiero, str.empresa, is_cuenta, ldt_desde, ldt_hasta)
else
	if is_cuenta2 = '' or isnull(is_cuenta2) then return
	ll_registros = dw_1.retrieve(str.g_financiero, str.empresa, is_cuenta, is_cuenta2, ldt_desde, ldt_hasta)
end if

if ll_registros > 0 and dw_2.getitemnumber(1,'rango') = 0 then
	ld_saldo_anterior = gf_saldo_anterior_co(is_cuenta, ldt_desde)	
	if ld_saldo_anterior <> 0 then
		dw_1.RowsCopy(1, 1, Primary!, dw_1, 1, Primary!)
		ldt_fecha_anterior = RelativeDate(date(ldt_desde), -1)
		if ls_naturaleza_cuenta = 'D' then
			if ld_saldo_anterior > 0 then
				dw_1.setitem(1,'coddiari_ddia_naturaleza','D')
			else
				dw_1.setitem(1,'coddiari_ddia_naturaleza','C')						
			end if
		else
			if ld_saldo_anterior > 0 then
				dw_1.setitem(1,'coddiari_ddia_naturaleza','D')
			else
				dw_1.setitem(1,'coddiari_ddia_naturaleza','C')						
			end if			
		end if
		dw_1.setitem(1,'coddiari_ddia_monto',abs(ld_saldo_anterior))					
		dw_1.setitem(1,'saldo_ini',abs(ld_saldo_anterior))
		dw_1.setitem(1,'cotdiari_diar_nombre','SALDO ANTERIOR')
		dw_1.setitem(1,'cotdiari_diar_descripcion','Balance')
		dw_1.setitem(1,'diar_no_documento','')
		dw_1.setitem(1,'cotdiari_diar_no_referencia','')		
		dw_1.setitem(1,'diar_fecha_transaccion',ldt_fecha_anterior)
	end if
elseif dw_2.getitemnumber(1,'rango') = 0 then
	
	ld_saldo_anterior = gf_saldo_anterior_co(is_cuenta, ldt_desde)	
	if ld_saldo_anterior <> 0 then
		dw_1.insertrow(1)
		ldt_fecha_anterior = RelativeDate(date(ldt_desde), -1)
		if ls_naturaleza_cuenta = 'D' then
			if ld_saldo_anterior > 0 then
				dw_1.setitem(1,'coddiari_ddia_naturaleza','D')
			else
				dw_1.setitem(1,'coddiari_ddia_naturaleza','C')						
			end if
		else
			if ld_saldo_anterior > 0 then
				dw_1.setitem(1,'coddiari_ddia_naturaleza','D')
			else
				dw_1.setitem(1,'coddiari_ddia_naturaleza','C')						
			end if			
		end if		
		dw_1.setitem(1,'coddiari_ddia_monto',abs(ld_saldo_anterior))
		dw_1.setitem(1,'saldo_ini',abs(ld_saldo_anterior))
		dw_1.setitem(1,'cotdiari_diar_nombre','SALDO ANTERIOR')
		dw_1.setitem(1,'cotdiari_diar_descripcion','Balance')
		dw_1.setitem(1,'diar_no_documento','')
		dw_1.setitem(1,'diar_fecha_transaccion',ldt_fecha_anterior)
		dw_1.setitem(1,'ddia_mg_cuenta',is_cuenta )
		dw_1.setitem(1,'dgmplanc_mg_descripcion',ls_descrip_cuenta )		
	else	
		gf_mensaje('','No Hay Movimientos para el Periodo Solicitado, Verifique!!!',1,1,'E')
		return
	end if
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

dw_1.object.datawindow.print.preview = True
dw_1.object.datawindow.print.preview.zoom = 100
dw_1.setfocus()
end event

type cb_2 from commandbutton within w_reporte_historico_cuentas
integer x = 4009
integer y = 36
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

type uo_1 from u_ddcalen within w_reporte_historico_cuentas
boolean visible = false
integer x = 50
integer y = 124
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

type uo_2 from u_ddcalen within w_reporte_historico_cuentas
boolean visible = false
integer x = 754
integer y = 120
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

