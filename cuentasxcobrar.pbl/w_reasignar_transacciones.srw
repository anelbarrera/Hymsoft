//objectcomments Consulta e Impresion del Movimiento del Metal por Cliente
forward
global type w_reasignar_transacciones from w_fa_padre_reportes
end type
type st_sel_marca from statictext within w_reasignar_transacciones
end type
type cb_consultar from commandbutton within w_reasignar_transacciones
end type
type cb_2 from commandbutton within w_reasignar_transacciones
end type
type dw_2 from datawindow within w_reasignar_transacciones
end type
type em_saldo from editmask within w_reasignar_transacciones
end type
type st_1 from statictext within w_reasignar_transacciones
end type
type cb_1 from commandbutton within w_reasignar_transacciones
end type
type dw_3 from datawindow within w_reasignar_transacciones
end type
type dw_4 from datawindow within w_reasignar_transacciones
end type
type dw_5 from datawindow within w_reasignar_transacciones
end type
type dw_6 from datawindow within w_reasignar_transacciones
end type
type st_2 from statictext within w_reasignar_transacciones
end type
type em_saldo2 from editmask within w_reasignar_transacciones
end type
type st_3 from statictext within w_reasignar_transacciones
end type
type em_balance from editmask within w_reasignar_transacciones
end type
type dw_7 from datawindow within w_reasignar_transacciones
end type
type st_4 from statictext within w_reasignar_transacciones
end type
type cb_3 from commandbutton within w_reasignar_transacciones
end type
end forward

global type w_reasignar_transacciones from w_fa_padre_reportes
integer x = 0
integer y = 0
integer width = 6089
integer height = 2104
string title = "Transferencia de Transacciones de Clientes"
string menuname = ""
boolean resizable = false
long backcolor = 12639424
windowanimationstyle openanimation = rightslide!
windowanimationstyle closeanimation = rightslide!
st_sel_marca st_sel_marca
cb_consultar cb_consultar
cb_2 cb_2
dw_2 dw_2
em_saldo em_saldo
st_1 st_1
cb_1 cb_1
dw_3 dw_3
dw_4 dw_4
dw_5 dw_5
dw_6 dw_6
st_2 st_2
em_saldo2 em_saldo2
st_3 st_3
em_balance em_balance
dw_7 dw_7
st_4 st_4
cb_3 cb_3
end type
global w_reasignar_transacciones w_reasignar_transacciones

type variables
datawindowchild idwc_cliente, idwc_producto, idwc_cliente2

end variables

forward prototypes
public function boolean wf_recupera_pagos (integer al_fila)
end prototypes

public function boolean wf_recupera_pagos (integer al_fila);string ls_doc, ls_ref, ls_tran, ls_stran, ls_find, ls_doc_ori, ls_ref_ori, ls_app_ori, ls_tran_ori, ls_stran_ori
integer li_ann, i, li_encontro, li_ann_ori
long ll_cliente
datetime ldt_inicio, ldt_fin
decimal{2} ld_saldo_actual, ld_saldo, ld_balance
li_ann = dw_2.getitemnumber(al_fila,'movi_anno')
ls_doc = dw_2.getitemstring(al_fila,'movi_documento')
ls_ref = dw_2.getitemstring(al_fila,'movi_referencia')
ls_tran = dw_2.getitemstring(al_fila,'movi_tipo_transaccion')
ls_stran = dw_2.getitemstring(al_fila,'movi_sub_transaccion')

ll_cliente  = dw_1.getitemnumber(1,'cliente')
if ll_cliente = 0 or isnull(ll_cliente) then 
	gf_mensaje('','Debe seleccionar un cliente, Verifique !!!',1,1,'E')
	return false
end if
ldt_inicio  = dw_1.getitemdatetime(1,'fecha1')
ldt_fin	   = dw_1.getitemdatetime(1,'fecha2')

if dw_3.retrieve(str.g_financiero, str.empresa, ll_cliente, ldt_inicio, ldt_fin) > 0 then
	ld_saldo_actual = double(em_saldo.text)
	ld_saldo = dw_3.getitemnumber(1,'saldo_total')
	ld_balance = ld_saldo_actual - ld_saldo
	em_balance.text = string(ld_balance)
else
	em_balance.text = string(0.00)
end if


if dw_6.retrieve(str.g_financiero, str.empresa, ls_tran, ls_stran, ls_doc, ls_ref, li_ann) > 0 then
	dw_3.SelectRow(0, false)
	for i = 1 to dw_3.rowcount()
		dw_3.setitem(i,'aplicado',0)
	next
	for i = 1 to dw_6.rowcount()
		ls_doc_ori = dw_6.getitemstring(i,'refa_documento_ori')
		ls_ref_ori = dw_6.getitemstring(i,'refa_referencia_ori')
		ls_app_ori = dw_6.getitemstring(i,'refa_aplicacion_ori')		
		ls_tran_ori = dw_6.getitemstring(i,'refa_tipo_transaccion_ori')		
		ls_stran_ori = dw_6.getitemstring(i,'refa_sub_transaccion_ori')		
		li_ann_ori = dw_6.getitemnumber(i,'refa_ann_ori')	
		ls_find = 'movi_documento = "'+ls_doc_ori+'" and movi_referencia = "'+ls_ref_ori+'" and movi_tipo_transaccion = "'+ls_tran_ori+'" and movi_sub_transaccion = "'+ls_stran_ori+'" and movi_aplicacion = "'+ls_app_ori+'" and movi_anno = '+string(li_ann_ori)
		li_encontro = dw_3.find(ls_find,1,dw_3.rowcount())
		if li_encontro > 0 then
			dw_3.SelectRow(li_encontro, true)
			dw_3.setitem(li_encontro,'aplicado',1)
		end if
	next
else
	dw_6.reset()
	dw_3.SelectRow(0, false)
	for i = 1 to dw_3.rowcount()
		dw_3.setitem(i,'aplicado',0)
	next	
	ls_find = 'movi_saldo > 0'
	li_encontro = dw_3.find(ls_find,1,dw_3.rowcount())
	if li_encontro > 0 then
		dw_3.scrolltorow(li_encontro)
	end if

	
end if


return true
end function

on w_reasignar_transacciones.create
int iCurrent
call super::create
this.st_sel_marca=create st_sel_marca
this.cb_consultar=create cb_consultar
this.cb_2=create cb_2
this.dw_2=create dw_2
this.em_saldo=create em_saldo
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_3=create dw_3
this.dw_4=create dw_4
this.dw_5=create dw_5
this.dw_6=create dw_6
this.st_2=create st_2
this.em_saldo2=create em_saldo2
this.st_3=create st_3
this.em_balance=create em_balance
this.dw_7=create dw_7
this.st_4=create st_4
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_sel_marca
this.Control[iCurrent+2]=this.cb_consultar
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.em_saldo
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.dw_4
this.Control[iCurrent+10]=this.dw_5
this.Control[iCurrent+11]=this.dw_6
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.em_saldo2
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.em_balance
this.Control[iCurrent+16]=this.dw_7
this.Control[iCurrent+17]=this.st_4
this.Control[iCurrent+18]=this.cb_3
end on

on w_reasignar_transacciones.destroy
call super::destroy
destroy(this.st_sel_marca)
destroy(this.cb_consultar)
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.em_saldo)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.dw_6)
destroy(this.st_2)
destroy(this.em_saldo2)
destroy(this.st_3)
destroy(this.em_balance)
destroy(this.dw_7)
destroy(this.st_4)
destroy(this.cb_3)
end on

event ue_post_open;//Override
datetime ldt_inicio, ldt_fin
//override

dw_1.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_6.settransobject(sqlca)

dw_1.getchild('cliente',idwc_cliente)
dw_1.getchild('producto',idwc_producto)
idwc_cliente.settransobject(sqlca)
if idwc_cliente.retrieve(str.g_financiero, str.empresa) = 0 then idwc_cliente.insertrow(0)
ldt_fin 		= datetime(date(gf_fecha_serv()))
ldt_inicio  = datetime(relativedate(date(gf_fecha_serv()), - 1800))
dw_2.settransobject(sqlca)
dw_1.insertrow(1)
dw_1.setitem(1,'fecha1',ldt_inicio)
dw_1.setitem(1,'fecha2',ldt_fin)
dw_4.insertrow(1)
dw_5.insertrow(1)
dw_7.getchild('cliente',idwc_cliente2)
idwc_cliente2.settransobject(sqlca)
if idwc_cliente2.retrieve(str.g_financiero, str.empresa) = 0 then idwc_cliente2.insertrow(0)

dw_7.insertrow(1)
dw_2.SetRowFocusIndicator(Hand!)
//dw_2.object.datawindow.print.preview = 'yes'		
end event

event resize;//Override
this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 278
dw_2.height = this.height - 478
dw_3.height = this.height - 478
dw_6.height = this.height - 478
dw_4.y = this.height - 270
dw_5.y = this.height - 270
em_saldo2.y = this.height - 465
st_2.y = this.height - 570
em_balance.y = this.height - 265
st_3.y = this.height - 370
this.SetRedraw(true)

end event

event open;//Override

//this.y = 0
//this.x = 805
//this.width = 3660

dw = dw_1
dw_impresion = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()

//This.SetToolbar(1,true,AlignatTop!)
//This.SetToolbarPos(1,1,50,false)

str.frame.SetRedraw ( True )

This.Icon = str.icono
this.postevent("ue_post_open")

end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_reasignar_transacciones
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_reasignar_transacciones
boolean visible = false
integer x = 32
integer y = 1384
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_reasignar_transacciones
integer x = 27
integer y = 28
integer width = 3387
integer height = 144
string dataobject = "dw_external_movimiento_metal"
boolean border = false
boolean livescroll = false
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

Integer li_pos, li_x, li_y,li_largo
String ls_objeto, ls_col

ls_objeto = This.GetObjectAtPointer()
li_pos = pos  (ls_objeto,"~t")
ls_col = left (ls_objeto, li_pos - 1)

//li_x	 = str.frame.GetActiveSheet ().PointerX () 
//li_largo = len("Haga click para ordenar por la Columna de " + this.describe(ls_col+".text"))*28


//li_y	 = str.frame.GetActiveSheet ().PointerY () - 200

// Dependiendo de la Columna el Mensaje de Ayuda varía
CHOOSE CASE ls_col
	CASE 'cctmovim_movi_a_nombre'
		this.Modify("cctmovim_movi_a_nombre.Font.Underline='1'")
		this.Modify("cctmovim_movi_a_nombre.Color='7536640'")

	CASE ELSE
		this.Modify("cctmovim_movi_a_nombre.Font.Underline='0'")
		this.Modify("cctmovim_movi_a_nombre.Color='0'")

END CHOOSE
end event

event dw_1::clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto, ls_column
integer li_pos 

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

ls_column = dwo.name

if ls_column = 'cctmovim_movi_a_nombre' then
	str_cc_formatos str_formato1		
	str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	str_formato1.tercero = dw_1.getitemNumber(1,"cctmovim_movi_tercero")
	OpenSheetwithparm(w_mant_clientes,str_formato1,parent,2, Original!)
	
end if
end event

event dw_1::buttonclicked;call super::buttonclicked;//busqueda
long ll_codigo
integer li_encontro	
String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error
integer li_c, li_b
long    ll_lter
decimal{2} ld_saldo

Datawindow        dww
str_dg_dynamic_find	lstr_df

if dwo.name = 'b_cliente' then
	
		lstr_df.texto_campo [2,1] = "ccmclien.clie_ref_anterior" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [2,2] = "Cuenta"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '450'
		lstr_df.texto_campo [1,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [1,2] = "Descripción"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '700'		
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
					"WHERE ( dgmterce.terc_pais = dgapais.pais_pais ) and  " +&				
							 "(ccmclien.clie_g_financiero = " + string(str.g_financiero) + " and " +&
							 "ccmclien.clie_empresa = " + string(str.empresa) + ") 	and " +&
							"(dgmterce.terc_tercero = ccmclien.clie_tercero) "  							
		
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	If len (ls_find) = 0 Then Return
		
		
	ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo1,"'"," ")
	ls_codigo1 = Trim(ls_codigo1)

	dw_1.setitem(1,'cliente',long(ls_codigo1))
	dw_1.accepttext()
	li_encontro = idwc_cliente.find('terc_tercero = '+ls_codigo1,1,idwc_cliente.rowcount())
	if li_encontro > 0 then idwc_cliente.scrolltorow(li_encontro)
	dw_1.setitem(1,'cuenta', idwc_cliente.getitemstring(idwc_cliente.getrow(),'clie_ref_anterior'))
	dw_1.setcolumn('cliente')
	ld_saldo = gf_saldo_anterior_new( long(ls_codigo1), gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)		
	if isnull(ld_saldo) then ld_saldo = 0.00
	em_saldo.text = string(ld_saldo)	
	em_saldo2.text = string(ld_saldo)	
	
	cb_consultar.triggerevent('clicked')
	
elseif dwo.name = 'b_producto' then

	lstr_df.texto_campo [1,1] = "inmprodu.prod_producto"
	lstr_df.texto_campo [1,2] = "Referencia"
	lstr_df.texto_campo [1,3] = "prod_producto"
	lstr_df.texto_campo [1,4] = 'V'
//	lstr_df.texto_campo [1,5] = '280'	
	lstr_df.texto_campo [2,1] = "inmprodu.prod_descripcion"
	lstr_df.texto_campo [2,2] = "Descripcion"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '770'
	lstr_df.tabla = " inmprodu "
		
	lstr_df.tabla_where = &
				"WHERE (inmprodu.prod_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(inmprodu.prod_empresa = " + string(str.empresa) + ") "	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm
	
	If len (ls_find) = 0 Then Return
		
	ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo1,"'"," ")
	ls_codigo1 = Trim(ls_codigo1)
	this.setitem(this.getrow(),'item',ls_codigo1)
	this.setitem(this.getrow(),'producto',ls_codigo1)	
	this.accepttext()

end if
end event

event dw_1::itemchanged;call super::itemchanged;accepttext()
string ls_cuenta
long   ll_tercero, ll_encontro
decimal{2} ld_saldo
choose case this.getcolumnname()
	case 'cliente'
		ls_cuenta = idwc_cliente.getitemstring(idwc_cliente.getrow(),'clie_ref_anterior')
		this.setitem(row,'cuenta',ls_cuenta)
		ld_saldo = gf_saldo_anterior_new( long(data), gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)		
		if isnull(ld_saldo) then ld_saldo = 0.00
		em_saldo.text = string(ld_saldo)	
		em_saldo2.text = string(ld_saldo)
	case 'cuenta'
		ll_encontro = idwc_cliente.find("clie_ref_anterior = '"+data+"'",1,idwc_cliente.rowcount())
		if ll_encontro > 0 then
			ll_tercero = idwc_cliente.getitemnumber(ll_encontro,'terc_tercero')
			this.setitem(1,'cliente',ll_tercero)
		else
			this.setitem(1,'cliente',0)
		end if
	
		ld_saldo = gf_saldo_anterior_new( ll_tercero, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)		
		if isnull(ld_saldo) then ld_saldo = 0.00
		em_saldo.text = string(ld_saldo)	
		em_saldo2.text = string(ld_saldo)
	case 'item'
		this.setitem(1,'producto',data)
	case 'producto'
		this.setitem(1,'item',data)
end choose

cb_consultar.triggerevent('clicked')
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_reasignar_transacciones
boolean visible = false
integer x = 27
integer y = 192
integer width = 73
integer height = 48
long backcolor = 12639424
end type

type st_sel_marca from statictext within w_reasignar_transacciones
boolean visible = false
integer x = 1541
integer y = 1408
integer width = 640
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleccione la Marca"
boolean focusrectangle = false
end type

type cb_consultar from commandbutton within w_reasignar_transacciones
integer x = 2473
integer y = 188
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

event clicked;string ls_producto, ls_empresa, ls_titulo
datetime ldt_inicio, ldt_fin
long	ll_cliente
Decimal{2} ld_valor1, ld_valor2, ld_total, ld_total_gramos, ld_corriente, ld_corriente_gramos, ld_saldo, ld_saldo_actual, ld_balance
dw_1.accepttext()
ll_cliente  = dw_1.getitemnumber(1,'cliente')
if ll_cliente = 0 or isnull(ll_cliente) then 
	gf_mensaje('','Debe seleccionar un cliente, Verifique !!!',1,1,'E')
	return
end if

ldt_inicio  = dw_1.getitemdatetime(1,'fecha1')
ldt_fin	   = dw_1.getitemdatetime(1,'fecha2')

dw_6.reset()

if dw_3.retrieve(str.g_financiero, str.empresa, ll_cliente, ldt_inicio, ldt_fin) > 0 then
	ld_saldo_actual = double(em_saldo.text)
	ld_saldo = dw_3.getitemnumber(1,'saldo_total')
	ld_balance = ld_saldo_actual - ld_saldo
	em_balance.text = string(ld_balance)
else
	em_balance.text = string(0.00)
end if

if dw_2.retrieve(str.g_financiero, str.empresa, ll_cliente, ldt_inicio, ldt_fin) > 0 then
	dw_2.scrolltorow(1)
	wf_recupera_pagos(1)

end if
end event

type cb_2 from commandbutton within w_reasignar_transacciones
integer x = 2889
integer y = 188
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

type dw_2 from datawindow within w_reasignar_transacciones
integer x = 18
integer y = 420
integer width = 2098
integer height = 1568
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "TRANSACCIONES"
string dataobject = "dw_transacciones_a_transferir"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto, ls_column
integer li_pos 

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if right(ls_objeto,2)='_t' then

	ls_objeto = left(ls_objeto,len(ls_objeto)-2)
	
	if ls_objeto = is_ultima_ or is_ultima_ = "" then	//Si es la misma columna 
																	// o si es la primera vez
		if is_orden_  = "" or is_orden_ = "D" then
			is_orden_ = 'A'		
			this.SetSort(ls_objeto+" A")	//Ordena Ascendente
			this.sort()		
		else
			is_orden_ = 'D'					
			this.SetSort(ls_objeto+" D")	//Ordena Descendente
			this.sort()				
		end if	
		is_ultima_ = ls_objeto		
	else				
			is_orden_ = 'A'
			this.SetSort(ls_objeto+" A")
			this.sort()
			is_ultima_ = ls_objeto
	end if

end if
ls_column = dwo.name


if ls_column = 'fact_no_factura' then

	if row = 0 then return
	
	str_secuencia_doc lstr_sec
	lstr_sec.ano = dw_2.getitemNumber(row,"fact_ann")
	lstr_sec.sec_manual = dw_2.getitemstring(row,"fact_no_factura")

	opensheetwithparm(w_facturas_actualizadas,lstr_sec,str.frame,2,layered!)

elseif ls_column = 'cliente' then
	if dw_2.rowcount() > 0 then
		str_cc_formatos str_formato2		
		str_formato2.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
		str_formato2.tercero = dw_2.getitemNumber(1,"fact_cliente")
		Opensheetwithparm(w_estadocuenta,str_formato2,str.frame,2,original!)
	end if
elseif ls_column = 'cuenta' then
	if dw_2.rowcount() > 0 then	
		str_cc_formatos str_formato3		
		str_formato3.tercero = dw_2.getitemnumber(1,'fact_cliente')
		OpenSheetwithparm(w_mant_clientes,str_formato3,parent,2, Original!)	
	end if
end if
end event

event rowfocuschanged;if currentrow = 0 then return

wf_recupera_pagos(currentrow)


end event

type em_saldo from editmask within w_reasignar_transacciones
integer x = 3872
integer y = 52
integer width = 338
integer height = 80
integer taborder = 11
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean border = false
alignment alignment = right!
boolean displayonly = true
string mask = "##,##0.00"
end type

type st_1 from statictext within w_reasignar_transacciones
integer x = 3451
integer y = 60
integer width = 402
integer height = 60
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "SALDO:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_reasignar_transacciones
boolean visible = false
integer x = 2400
integer y = 192
integer width = 498
integer height = 104
integer taborder = 11
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Liberar Pagos"
end type

event clicked;long ll_cliente
string ls_error
datetime ldt_inicio, ldt_fin
dw_1.accepttext()
ll_cliente  = dw_1.getitemnumber(1,'cliente')

if ll_cliente = 0 or isnull(ll_cliente) then 
	gf_mensaje('','Debe seleccionar un cliente, Verifique !!!',1,1,'E')
	return
end if

if gf_mensaje('','Seguro de Liberar los Pagos ?',2,1,'E') = 2 then return

ldt_inicio  = dw_1.getitemdatetime(1,'fecha1')
ldt_fin	   = dw_1.getitemdatetime(1,'fecha2')

update cctmovim
  set  cctmovim.movi_cant_depositada = 0,
        cctmovim.movi_saldo  = cctmovim.movi_monto,
	    cctmovim.movi_monto_aplicado = 0
    FROM cctmovim  
   WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
	         ( cctmovim.movi_empresa = :str.empresa ) AND  
   		    ( cctmovim.movi_tercero = :ll_cliente ) and
			( cctmovim.movi_fecha_tran >= :ldt_inicio ) and
			( cctmovim.movi_fecha_tran <= :ldt_fin ) and
			( cctmovim.movi_tipo_transaccion <> 'RC' and cctmovim.movi_tipo_transaccion <> 'RM');
if sqlca.sqldbcode = -1 then
	ls_error = sqlca.sqlerrtext
	Rollback;
	mensaje("Error","Ha ocurrido un error al cambiar cant depositada y saldo a documentos distintos a recibos",ls_error)
end if

//Elimina los registros aplicados en ccdrefac para el cliente especifico
  DELETE FROM ccdrefac  
  WHERE ( ccdrefac.refa_g_financiero = :str.g_financiero ) AND  
        ( ccdrefac.refa_empresa = :str.empresa) AND  
        ( ccdrefac.refa_tercero = :ll_cliente) AND
	   ( ccdrefac.refa_fecha_recibo >= :ldt_inicio ) AND 
	   ( ccdrefac.refa_fecha_recibo <= :ldt_fin );	
	if sqlca.sqldbcode = -1 then
		ls_error = sqlca.sqlerrtext
		Rollback;
		mensaje("Error","Ha ocurrido un error al recuperar el tipo de búsqueda",ls_error)
	end if
	
	gf_mensaje('','Proceso Exitoso',1,1,'E')
	
	cb_consultar.triggerevent('clicked')
end event

type dw_3 from datawindow within w_reasignar_transacciones
boolean visible = false
integer x = 3017
integer y = 308
integer width = 2107
integer height = 1636
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "FACTURAS"
string dataobject = "dw_transacciones_aplicadas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event itemchanged;string ls_doc, ls_ref, ls_tran, ls_stran, ls_find, ls_app, ls_doc_ori, ls_ref_ori, ls_app_ori, ls_tran_ori, ls_stran_ori, ls_descrip_subtran
integer li_aplicado, li_ann, i, li_encontro, li_ann_ori
decimal{2} ld_monto, ld_saldo, ld_aplicado, ld_saldo_actual, ld_balance, ld_aplicado_total, ld_monto_a_aplicar
long ll_tercero
datetime ldt_fecha_recibo, ldt_fecha_factura
this.accepttext()
choose case dwo.name
	case 'aplicado'
		li_aplicado = integer(data)
		li_ann_ori = this.getitemnumber(row,'movi_anno')
		ls_doc_ori = this.getitemstring(row,'movi_documento')
		ls_ref_ori = this.getitemstring(row,'movi_referencia')
		ls_tran_ori = this.getitemstring(row,'movi_tipo_transaccion')
		ls_stran_ori = this.getitemstring(row,'movi_sub_transaccion')		
		ls_app_ori = this.getitemstring(row,'movi_aplicacion')		
		ldt_fecha_factura = this.getitemdatetime(row,'movi_fecha_tran')
		ll_tercero = this.getitemnumber(row,'movi_tercero')
		ld_saldo = this.getitemnumber(row,'movi_saldo')
		ld_aplicado = this.getitemnumber(row,'movi_monto_aplicado')
		if dw_6.rowcount() > 0 then
			ld_aplicado_total = dw_6.getitemnumber(1,'total_aplicado')
		else
			ld_aplicado_total = ld_aplicado
		end if		
		if li_aplicado = 1 then
			if ld_saldo = 0 then
				gf_mensaje('','Factura Aplicada Totalmente, Verifique !!!',1,1,'E')
				return 2
			end if
			ld_monto = dw_2.getitemnumber(dw_2.getrow(),'movi_monto')		
			if ld_monto = ld_aplicado_total and dw_6.rowcount() > 0 then
				gf_mensaje('','Pago Aplicado, Verifique !!!',1,1,'E')
				return 2
			end if
			if dw_6.rowcount() = 0 and ld_saldo <= ld_monto then
				ld_monto_a_aplicar = ld_saldo
			else
				if ld_saldo <=  ld_monto - ld_aplicado_total then
					ld_monto_a_aplicar = ld_saldo
				elseif dw_6.rowcount() = 0 and ld_saldo >= ld_monto then
					ld_monto_a_aplicar = ld_monto
				else
					ld_monto_a_aplicar = ld_monto - ld_aplicado_total
				end if
			end if
			
			  SELECT isnull(dgmsubse.subs_descripcion,'')  
				 INTO :ls_descrip_subtran  
				 FROM dgmsubse  
				WHERE ( dgmsubse.subs_g_financiero = :str.g_financiero ) AND  
						( dgmsubse.subs_empresa = :str.empresa ) AND  
						( dgmsubse.subs_transaccion = :ls_tran_ori ) AND  
						( dgmsubse.subs_sub_trans = :ls_stran_ori )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Buscr Sub Transaccion '+sqlca.sqlerrtext,1,1,'E')
					end if

			li_ann = dw_2.getitemnumber(dw_2.getrow(),'movi_anno')
			ls_doc = dw_2.getitemstring(dw_2.getrow(),'movi_documento')
			ls_ref = dw_2.getitemstring(dw_2.getrow(),'movi_referencia')
			ls_tran = dw_2.getitemstring(dw_2.getrow(),'movi_tipo_transaccion')
			ls_stran = dw_2.getitemstring(dw_2.getrow(),'movi_sub_transaccion')		
		    ldt_fecha_recibo = dw_2.getitemdatetime(dw_2.getrow(),'movi_fecha_tran')
			dw_6.scrolltorow(dw_6.insertrow(0))
			i = dw_6.getrow()
			dw_6.setitem(i,'refa_documento',ls_doc)
			dw_6.setitem(i,'refa_referencia',ls_ref)
			dw_6.setitem(i,'refa_tipo_transaccion',ls_tran)
			dw_6.setitem(i,'refa_sub_transaccion',ls_stran)
			dw_6.setitem(i,'refa_ann',li_ann)
			dw_6.setitem(i,'refa_fecha_recibo',ldt_fecha_recibo)
			dw_6.setitem(i,'refa_documento_ori',ls_doc_ori)
			dw_6.setitem(i,'refa_referencia_ori',ls_ref_ori)
			dw_6.setitem(i,'refa_tipo_transaccion_ori',ls_tran_ori)
			dw_6.setitem(i,'refa_sub_transaccion_ori',ls_stran_ori)
			dw_6.setitem(i,'dgmsubse_subs_descripcion',ls_descrip_subtran)
			dw_6.setitem(i,'refa_aplicacion_ori',ls_app_ori)
			dw_6.setitem(i,'refa_ann_ori',li_ann_ori)
			dw_6.setitem(i,'refa_fecha_factura',ldt_fecha_factura)	
			dw_6.setitem(i,'refa_tercero',ll_tercero)
			dw_6.setitem(i,'refa_g_financiero',str.g_financiero)
			dw_6.setitem(i,'refa_empresa',str.empresa)
			dw_6.setitem(i,'refa_usuario',str.usuario)
			dw_6.setitem(i,'refa_linea',i)			

			if ld_saldo <= ld_monto_a_aplicar and ld_aplicado = 0 then
				dw_6.setitem(i,'refa_monto_pagado',ld_saldo)
				this.setitem(row,'movi_saldo',0)
				this.setitem(row,'movi_monto_aplicado',ld_saldo)
			else
				dw_6.setitem(i,'refa_monto_pagado',ld_monto_a_aplicar)
				this.setitem(row,'movi_saldo',ld_saldo - ld_monto_a_aplicar )
				this.setitem(row,'movi_monto_aplicado',ld_aplicado + ld_monto_a_aplicar)
			end if
		else //Si desmarca le transaccion
			ls_find = 'refa_documento_ori = "'+ls_doc_ori+'" and refa_referencia_ori = "'+ls_ref_ori+'" and refa_tipo_transaccion_ori = "'+ls_tran_ori+'" and refa_sub_transaccion_ori = "'+ls_stran_ori+'" and refa_aplicacion_ori = "'+ls_app_ori+'" and refa_ann_ori = '+string(li_ann_ori)
			li_encontro = dw_6.find(ls_find,1,dw_6.rowcount())			
			if li_encontro > 0 then
				ld_monto = dw_6.getitemnumber(li_encontro,'refa_monto_pagado', primary!, true)
				this.setitem(row,'movi_monto_aplicado',ld_aplicado - ld_monto)
				this.setitem(row,'movi_saldo',ld_saldo + ld_monto)
				dw_6.deleterow(li_encontro)
			else
				
			end if
		end if
		ld_saldo_actual = double(em_saldo.text)
		ld_saldo = dw_3.getitemnumber(1,'saldo_total')
		ld_balance = ld_saldo_actual - ld_saldo
		em_balance.text = string(ld_balance)
end choose



//		ls_doc_ori = dw_6.getitemstring(i,'refa_documento_ori')
//		ls_ref_ori = dw_6.getitemstring(i,'refa_referencia_ori')
//		ls_app_ori = dw_6.getitemstring(i,'refa_aplicacion_ori')		
//		ls_tran_ori = dw_6.getitemstring(i,'refa_tipo_transaccion_ori')		
//		ls_stran_ori = dw_6.getitemstring(i,'refa_sub_transaccion_ori')		
//		li_ann_ori = dw_6.getitemnumber(i,'refa_ann_ori')	

end event

type dw_4 from datawindow within w_reasignar_transacciones
integer x = 59
integer y = 1848
integer width = 626
integer height = 84
integer taborder = 21
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_doc"
boolean border = false
boolean livescroll = true
end type

event editchanged;string ls_cadena, ls_doc

ls_doc = data
if len(ls_doc) > 0 then
	ls_cadena = 'left(upper(movi_documento),'+ string(len(ls_doc))+ ') = "'+upper(ls_doc)+'"'
else
	ls_cadena = ''
end if
dw_2.setfilter(ls_cadena)
dw_2.filter()
end event

type dw_5 from datawindow within w_reasignar_transacciones
boolean visible = false
integer x = 3058
integer y = 1844
integer width = 626
integer height = 84
integer taborder = 31
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_doc"
boolean border = false
boolean livescroll = true
end type

event editchanged;string ls_cadena, ls_doc

ls_doc = data
if len(ls_doc) > 0 then
	ls_cadena = 'left(upper(movi_documento),'+ string(len(ls_doc))+ ') = "'+upper(ls_doc)+'"'
else
	ls_cadena = ''
end if
dw_3.setfilter(ls_cadena)
dw_3.filter()
end event

type dw_6 from datawindow within w_reasignar_transacciones
boolean visible = false
integer x = 1705
integer y = 308
integer width = 1253
integer height = 1636
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "APLICADO"
string dataobject = "dw_documentos_aplicados_por_pago"
boolean vscrollbar = true
boolean livescroll = true
end type

event buttonclicked;if dwo.name = 'b_grabar' then
	if dw_6.update() = -1 then
		gf_mensaje('','Error al Grabar '+sqlca.sqlerrtext,1,1,'E')
	else
		if dw_3.update() = -1 then
			gf_mensaje('','Error al Grabar Movimientos '+sqlca.sqlerrtext,1,1,'E')
		end if
	end if
end if
end event

type st_2 from statictext within w_reasignar_transacciones
boolean visible = false
integer x = 5184
integer y = 1584
integer width = 402
integer height = 60
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "SALDO"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_saldo2 from editmask within w_reasignar_transacciones
boolean visible = false
integer x = 5193
integer y = 1668
integer width = 398
integer height = 76
integer taborder = 21
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean border = false
alignment alignment = right!
boolean displayonly = true
string mask = "##,##0.00"
end type

type st_3 from statictext within w_reasignar_transacciones
boolean visible = false
integer x = 5184
integer y = 1772
integer width = 402
integer height = 60
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "BALANCE"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_balance from editmask within w_reasignar_transacciones
boolean visible = false
integer x = 5193
integer y = 1860
integer width = 398
integer height = 76
integer taborder = 31
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean border = false
alignment alignment = right!
boolean displayonly = true
string mask = "##,##0.00"
end type

type dw_7 from datawindow within w_reasignar_transacciones
integer x = 41
integer y = 268
integer width = 1979
integer height = 104
integer taborder = 21
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_movimiento_metal"
boolean border = false
boolean livescroll = true
end type

event clicked;//busqueda
long ll_codigo
integer li_encontro	
String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error
integer li_c, li_b
long    ll_lter
decimal{2} ld_saldo

Datawindow        dww
str_dg_dynamic_find	lstr_df

if dwo.name = 'b_cliente' then
	
		lstr_df.texto_campo [2,1] = "ccmclien.clie_ref_anterior" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [2,2] = "Cuenta"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '450'
		lstr_df.texto_campo [1,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [1,2] = "Descripción"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '700'		
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
					"WHERE ( dgmterce.terc_pais = dgapais.pais_pais ) and  " +&				
							 "(ccmclien.clie_g_financiero = " + string(str.g_financiero) + " and " +&
							 "ccmclien.clie_empresa = " + string(str.empresa) + ") 	and " +&
							"(dgmterce.terc_tercero = ccmclien.clie_tercero) "  							
		
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	If len (ls_find) = 0 Then Return
		
		
	ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo1,"'"," ")
	ls_codigo1 = Trim(ls_codigo1)

	dw_7.setitem(1,'cliente',long(ls_codigo1))
	dw_7.accepttext()
	li_encontro = idwc_cliente2.find('terc_tercero = '+ls_codigo1,1,idwc_cliente2.rowcount())
	if li_encontro > 0 then idwc_cliente2.scrolltorow(li_encontro)	
	dw_7.setitem(1,'cuenta', idwc_cliente2.getitemstring(idwc_cliente2.getrow(),'clie_ref_anterior'))
	dw_7.setcolumn('cliente')
	
end if
end event

event itemchanged;accepttext()
string ls_cuenta
long   ll_tercero, ll_encontro
decimal{2} ld_saldo
choose case this.getcolumnname()
	case 'cliente'
		ls_cuenta = idwc_cliente2.getitemstring(idwc_cliente2.getrow(),'clie_ref_anterior')
		this.setitem(row,'cuenta',ls_cuenta)
		ld_saldo = gf_saldo_anterior_new( long(data), gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)		
		if isnull(ld_saldo) then ld_saldo = 0.00
		em_saldo.text = string(ld_saldo)	
		em_saldo2.text = string(ld_saldo)
	case 'cuenta'
		ll_encontro = idwc_cliente2.find("clie_ref_anterior = '"+data+"'",1,idwc_cliente2.rowcount())
		if ll_encontro > 0 then
			ll_tercero = idwc_cliente2.getitemnumber(ll_encontro,'terc_tercero')
			this.setitem(1,'cliente',ll_tercero)
		else
			this.setitem(1,'cliente',0)
		end if
	
		ld_saldo = gf_saldo_anterior_new( ll_tercero, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)		
		if isnull(ld_saldo) then ld_saldo = 0.00
		em_saldo.text = string(ld_saldo)	
		em_saldo2.text = string(ld_saldo)
end choose

end event

type st_4 from statictext within w_reasignar_transacciones
integer x = 558
integer y = 188
integer width = 759
integer height = 80
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "CUENTA DESTINO"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_reasignar_transacciones
integer x = 2619
integer y = 756
integer width = 1266
integer height = 200
integer taborder = 21
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "TRANSFERIR TRANSACCIONES"
end type

event clicked;dw_2.accepttext()
integer i, li_ann
long ll_cliente, ll_cliente2
string ls_documento, ls_referencia, ls_aplicacion, ls_tran, ls_stran, ls_cuenta, ls_cuenta2

if gf_mensaje('','Esta Seguro de Transferir las Transacciones ?',2,1,'Q') = 2 then return

dw_2.setfilter('incluir = 1')
dw_2.filter()

if dw_2.rowcount() = 0 then
	dw_2.setfilter('')
	dw_2.filter()	
	gf_mensaje('','Debe Seleccionar las Transacciones a Pasar, Verifique !!!',1,1,'E')
	return
end if

ls_cuenta = dw_1.getitemstring(1,'cuenta')
ll_cliente  = dw_1.getitemnumber(1,'cliente')

ls_cuenta2 = dw_7.getitemstring(1,'cuenta')
ll_cliente2  = dw_7.getitemnumber(1,'cliente')

for i = 1 to dw_2.rowcount()
	ls_aplicacion  = dw_2.getitemstring(i,'movi_aplicacion')
	ls_documento = dw_2.getitemstring(i,'movi_documento')	
	ls_referencia  = dw_2.getitemstring(i,'movi_referencia')
	ls_tran 		= dw_2.getitemstring(i,'movi_tipo_transaccion')
	ls_stran 		= dw_2.getitemstring(i,'movi_sub_transaccion')
	li_ann			= dw_2.getitemnumber(i,'movi_anno')
	
	  UPDATE cctmovim  
		  SET movi_tercero = :ll_cliente2,   
				movi_ruc_tercero = :ls_cuenta2  
		WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
				( cctmovim.movi_empresa = :str.empresa ) AND  
				( cctmovim.movi_aplicacion = :ls_aplicacion ) AND  
				( cctmovim.movi_tipo_transaccion = :ls_tran ) AND  
				( cctmovim.movi_sub_transaccion = :ls_stran ) AND  
				( cctmovim.movi_documento = :ls_documento ) AND  
				( cctmovim.movi_anno = :li_ann ) AND  
				( cctmovim.movi_referencia = :ls_referencia )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return
		end if
		
		if ls_aplicacion  = 'FA' then
			  UPDATE fatdiari  
			  SET fact_cliente = :ll_cliente2,   
					fact_ruc_cliente = :ls_cuenta2  
			WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
					( fatdiari.fact_empresa = :str.empresa ) AND  
					( fatdiari.fact_no_pedido = :ls_referencia ) AND  
					( fatdiari.fact_ann = :li_ann ) AND  
					( fatdiari.fact_no_factura = :ls_documento )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Actualizar en Facturacion '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				return
			end if
		end if	
next

commit;
gf_mensaje('','Transferencia Exitosa',1,1,'E')

dw_2.setfilter('')
dw_2.filter()	
cb_consultar.triggerevent('clicked')
end event

