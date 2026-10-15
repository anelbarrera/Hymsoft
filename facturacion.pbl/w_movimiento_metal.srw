//objectcomments Consulta e Impresion del Movimiento del Metal por Cliente
forward
global type w_movimiento_metal from w_fa_padre_reportes
end type
type st_sel_marca from statictext within w_movimiento_metal
end type
type cb_consultar from commandbutton within w_movimiento_metal
end type
type cb_2 from commandbutton within w_movimiento_metal
end type
type dw_2 from datawindow within w_movimiento_metal
end type
type uo_1 from u_ddcalen within w_movimiento_metal
end type
type uo_2 from u_ddcalen within w_movimiento_metal
end type
end forward

global type w_movimiento_metal from w_fa_padre_reportes
integer x = 0
integer y = 0
integer width = 3671
integer height = 1600
string title = "Consulta de Ventas por Producto"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 12639424
string icon = "AppIcon!"
windowanimationstyle openanimation = bottomroll!
windowanimationstyle closeanimation = bottomslide!
st_sel_marca st_sel_marca
cb_consultar cb_consultar
cb_2 cb_2
dw_2 dw_2
uo_1 uo_1
uo_2 uo_2
end type
global w_movimiento_metal w_movimiento_metal

type variables
datawindowchild idwc_cliente, idwc_producto

end variables

on w_movimiento_metal.create
int iCurrent
call super::create
this.st_sel_marca=create st_sel_marca
this.cb_consultar=create cb_consultar
this.cb_2=create cb_2
this.dw_2=create dw_2
this.uo_1=create uo_1
this.uo_2=create uo_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_sel_marca
this.Control[iCurrent+2]=this.cb_consultar
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.uo_2
end on

on w_movimiento_metal.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_sel_marca)
destroy(this.cb_consultar)
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.uo_1)
destroy(this.uo_2)
end on

event ue_post_open;//Override
datetime ldt_inicio, ldt_fin
//override

dw_1.settransobject(sqlca)

dw_1.getchild('cliente',idwc_cliente)
dw_1.getchild('producto',idwc_producto)
idwc_cliente.settransobject(sqlca)
if idwc_cliente.retrieve(str.g_financiero, str.empresa) = 0 then idwc_cliente.insertrow(0)
ldt_fin 		= datetime(date(gf_fecha_serv()))
ldt_inicio  = datetime(relativedate(date(gf_fecha_serv()), - 365))
dw_2.settransobject(sqlca)
dw_1.insertrow(1)
dw_1.setitem(1,'fecha1',ldt_inicio)
dw_1.setitem(1,'fecha2',ldt_fin)
dw_2.object.datawindow.print.preview = 'yes'		
end event

event resize;//Override
this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 278
dw_2.height = this.height - 478

this.SetRedraw(true)

end event

event open;//Override

this.y = 0
this.x = 805
this.width = 3660

dw = dw_2
dw_impresion = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()

This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)

str.frame.SetRedraw ( True )

This.Icon = str.icono
this.postevent("ue_post_open")

end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_movimiento_metal
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_movimiento_metal
boolean visible = false
integer x = 32
integer y = 1384
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_movimiento_metal
integer x = 27
integer y = 28
integer width = 3474
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
accepttext()
date 	ld_date,ld_ini_date, ld_hoy

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

ls_column = dwo.name

if ls_column = 'cctmovim_movi_a_nombre' then
	str_cc_formatos str_formato1		
	str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	str_formato1.tercero = dw_1.getitemNumber(1,"cctmovim_movi_tercero")
	OpenSheetwithparm(w_mant_clientes,str_formato1,parent,2, Original!)
elseif dwo.name='calendario' then
	ld_ini_date=date(dw_1.GetItemDateTime(dw_1.getrow(),"fecha1"))
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
	ld_ini_date=date(dw_1.GetItemDateTime(dw_1.getrow(),"fecha2"))
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

event dw_1::buttonclicked;call super::buttonclicked;//busqueda
long ll_codigo
integer li_encontro	
String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error
integer li_c, li_b
long    ll_lter

Datawindow        dww
str_dg_dynamic_find	lstr_df

if dwo.name = 'b_cliente' then
	
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
							"(dgmterce.terc_tercero = ccmclien.clie_tercero) "  							
		
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	If len (ls_find) = 0 Then Return
		
		
	ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo1,"'"," ")
	ls_codigo1 = Trim(ls_codigo1)

	dw_1.setitem(1,'cliente',long(ls_codigo1))
	dw_1.accepttext()
	dw_1.setitem(1,'cuenta', idwc_cliente.getitemstring(idwc_cliente.getrow(),'clie_ref_anterior'))
	dw_1.setcolumn('cliente')

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

choose case this.getcolumnname()
	case 'cliente'
		ls_cuenta = idwc_cliente.getitemstring(idwc_cliente.getrow(),'clie_ref_anterior')
		this.setitem(row,'cuenta',ls_cuenta)
		
	case 'cuenta'
		ll_encontro = idwc_cliente.find("clie_ref_anterior = '"+data+"'",1,idwc_cliente.rowcount())
		if ll_encontro > 0 then
			ll_tercero = idwc_cliente.getitemnumber(ll_encontro,'terc_tercero')
			this.setitem(1,'cliente',ll_tercero)
		else
			this.setitem(1,'cliente',0)
		end if
	case 'item'
		this.setitem(1,'producto',data)
	case 'producto'
		this.setitem(1,'item',data)
end choose
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_movimiento_metal
boolean visible = false
integer x = 27
integer y = 192
integer width = 73
integer height = 48
long backcolor = 12639424
end type

type st_sel_marca from statictext within w_movimiento_metal
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

type cb_consultar from commandbutton within w_movimiento_metal
integer x = 1230
integer y = 192
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
Decimal{2} ld_valor1, ld_valor2, ld_total, ld_total_gramos, ld_corriente, ld_corriente_gramos
dw_1.accepttext()
ll_cliente  = dw_1.getitemnumber(1,'cliente')
if ll_cliente = 0 or isnull(ll_cliente) then 
	gf_mensaje('','Debe seleccionar un cliente, Verifique !!!',1,1,'E')
	return
end if

ldt_inicio  = dw_1.getitemdatetime(1,'fecha1')
ldt_fin	   = dw_1.getitemdatetime(1,'fecha2')

if dw_2.retrieve(str.g_financiero, str.empresa, ll_cliente, ldt_inicio, ldt_fin) > 0 then
	ls_empresa = gf_dg_nombre_empresa()
	ls_titulo = 'Movimiento de Metal desde el '+string(ldt_inicio, 'dd/MMM/yyyy')+' hasta el '+string(ldt_fin, 'dd/MMM/yyyy')
	dw_2.object.empresanom.expression = "'"+ls_empresa+"'"
	dw_2.object.titulo_fecha.expression = "'"+ls_titulo+"'"
end if


end event

type cb_2 from commandbutton within w_movimiento_metal
integer x = 1687
integer y = 192
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

type dw_2 from datawindow within w_movimiento_metal
event ue_microhelp pbm_nchittest
integer x = 32
integer y = 312
integer width = 3611
integer height = 1112
integer taborder = 11
boolean bringtotop = true
string title = "none"
string dataobject = "dw_reporte_movimiento_metal"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_microhelp;//override
//Para cuando pasa por encima del objeto
//Override
return

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
	CASE 'fact_no_factura'
		this.Modify("fact_no_factura.Font.Underline='1'")
		this.Modify("fact_no_factura.Color='7536640'")
	CASE 'cliente'
		this.Modify("cliente.Font.Underline='1'")
		this.Modify("cliente.Color='7536640'")
	CASE 'cuenta'
		this.Modify("cuenta.Font.Underline='1'")
		this.Modify("cuenta.Color='7536640'")

	CASE ELSE
		this.Modify("fact_no_factura.Font.Underline='0'")
		this.Modify("fact_no_factura.Color='0'")
		this.Modify("cliente.Font.Underline='0'")
		this.Modify("cliente.Color='0'")
		this.Modify("cuenta.Font.Underline='0'")
		this.Modify("cuenta.Color='0'")

END CHOOSE
end event

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

type uo_1 from u_ddcalen within w_movimiento_metal
boolean visible = false
integer x = 1970
integer y = 128
integer taborder = 31
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;dw_1.SetItem ( dw_1.getrow(), 'fecha1', uo_1.return_sel_date() )

if uo_1.allow_close then
	this.visible=false
	dw_1.SetFocus()
end if


end event

on uo_1.destroy
call u_ddcalen::destroy
end on

type uo_2 from u_ddcalen within w_movimiento_metal
boolean visible = false
integer x = 2679
integer y = 128
integer taborder = 41
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;dw_1.SetItem ( dw_1.getrow(), 'fecha2', uo_2.return_sel_date() )

if uo_2.allow_close then
	this.visible=false
	dw_1.SetFocus()
end if


end event

on uo_2.destroy
call u_ddcalen::destroy
end on

