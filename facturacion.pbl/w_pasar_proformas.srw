//objectcomments Consulta de transacciones de clientes Vista Previa
forward
global type w_pasar_proformas from w_fa_padre_reportes
end type
type st_sel_marca from statictext within w_pasar_proformas
end type
type ddlb_1 from dropdownlistbox within w_pasar_proformas
end type
type cb_consultar from commandbutton within w_pasar_proformas
end type
type cb_2 from commandbutton within w_pasar_proformas
end type
type dw_2 from datawindow within w_pasar_proformas
end type
type uo_1 from u_ddcalen within w_pasar_proformas
end type
type uo_2 from u_ddcalen within w_pasar_proformas
end type
type dw_3 from datawindow within w_pasar_proformas
end type
end forward

global type w_pasar_proformas from w_fa_padre_reportes
integer width = 3977
integer height = 2048
string title = "Pase de Proformas"
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 15793151
boolean center = true
windowanimationstyle openanimation = centeranimation!
windowanimationstyle closeanimation = centeranimation!
st_sel_marca st_sel_marca
ddlb_1 ddlb_1
cb_consultar cb_consultar
cb_2 cb_2
dw_2 dw_2
uo_1 uo_1
uo_2 uo_2
dw_3 dw_3
end type
global w_pasar_proformas w_pasar_proformas

type variables
datawindowchild idwc_cliente, idwc_producto
boolean ib_pasar
str_pase_proforma istr_proformas

end variables

on w_pasar_proformas.create
int iCurrent
call super::create
this.st_sel_marca=create st_sel_marca
this.ddlb_1=create ddlb_1
this.cb_consultar=create cb_consultar
this.cb_2=create cb_2
this.dw_2=create dw_2
this.uo_1=create uo_1
this.uo_2=create uo_2
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_sel_marca
this.Control[iCurrent+2]=this.ddlb_1
this.Control[iCurrent+3]=this.cb_consultar
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.uo_2
this.Control[iCurrent+8]=this.dw_3
end on

on w_pasar_proformas.destroy
call super::destroy
destroy(this.st_sel_marca)
destroy(this.ddlb_1)
destroy(this.cb_consultar)
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.dw_3)
end on

event ue_post_open;//Override

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_3.insertrow(1)
dw_1.retrieve(str.g_financiero, str.empresa)

istr_proformas = message.powerobjectparm
	





end event

event resize;//Override
this.SetRedraw(false)
//dw_1.width  = this.width  - 99
//dw_1.height = this.height - 278

st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180

ddlb_1.y = this.height - 200
ddlb_1.X = (this.width - 70) - ddlb_1.width 

st_sel_marca.y = this.height - 200
st_sel_marca.X = (this.width - 70) - ddlb_1.width - st_sel_marca.width -100

this.SetRedraw(true)

end event

event open;//Override

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

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_pasar_proformas
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_pasar_proformas
boolean visible = false
integer x = 32
integer y = 1384
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_pasar_proformas
integer x = 27
integer y = 112
integer width = 2857
integer height = 424
string dataobject = "dw_pasar_proforma"
boolean vscrollbar = true
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
//if w_fa_fondo.str_aplica_links.habilita_links = 1	then
//	ls_pointer = dw_1.GetObjectAtPointer()
//	li_fila = integer(trim(mid(ls_pointer,7)))
//	if pos(ls_pointer,'numero') > 0 then 
//		str_rangofecha_opcion.opcion = 'Kardex'
//		str_rangofecha_opcion.orden = dw_1.getitemstring(li_fila,'fact_no_factura')
//		if w_fa_fondo.str_aplica_links.factura_activa_fa = 'A' then
//			OpenSheetWithParm(lw_child,str_rangofecha_opcion,"w_fa_co_facturas_cab_det_99_e",str.frame,11,Original!)
//		end if
//	else
//		if pos(ls_pointer,'nomcli') > 0 then 
//			str_rangofecha_opcion.opcion = 'Kardex'
//			str_rangofecha_opcion.cliente = dw_1.getitemnumber(li_fila,'terc_tercero')
////			ldt_fecha1 = dw_1.getitemdatetime(li_fila,'fact_fecha')
//			str_rangofecha_opcion.fecha1 = date('01/01/1990')
//			if w_fa_fondo.str_aplica_links.cxc_activa_cc = 'A' then
//				OpenSheetWithParm(lw_child,str_rangofecha_opcion,"w_fa_co_mov_cliente_saldo",str.frame,11,Original!)
//			end if
//		end if
//	end if
//end if 

//	dw_3.Object.dmov_secuencia.Pointer = 'Cross!'

end event

event dw_1::ue_microayuda;//override
end event

event dw_1::clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.
accepttext()
date 	ld_date,ld_ini_date, ld_hoy
string ls_objeto, ls_column
integer li_pos 

ls_objeto = This.GetObjectAtPointer()
ld_hoy = date(gf_fecha_Serv())
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
integer i, k, li_pasar

choose case dwo.name
	case 'pasar'
		li_pasar = integer(data)
		for i = 1 to this.rowcount()
			if i <> row then
				this.setitem(i,'pasar',0)
			else
				for k = 1 to dw_2.rowcount()
					dw_2.setitem(k,'pasar',li_pasar)
				next
			end if
		next
end choose
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;string ls_prof
integer li_ann

if ib_pasar then return

if currentrow = 0 then
	dw_2.reset()
	return
end if

li_ann = this.getitemnumber(currentrow, 'prof_ann')
ls_prof = this.getitemstring(currentrow,'prof_no_proforma')

dw_2.retrieve(str.g_financiero, str.empresa, ls_prof, li_ann)
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_pasar_proformas
boolean visible = false
integer x = 27
integer y = 192
integer width = 73
integer height = 48
long backcolor = 12639424
end type

type st_sel_marca from statictext within w_pasar_proformas
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

type ddlb_1 from dropdownlistbox within w_pasar_proformas
boolean visible = false
integer x = 2240
integer y = 1388
integer width = 754
integer height = 244
integer taborder = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
boolean vscrollbar = true
string item[] = {"NATURAL EXCHANGE","PUNTOCOM","TODAS"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String	ls_filtro
ls_filtro = 'PC'

if index = 1 then	//NATURAL
	dw_1.setFilter("fact_ruc_cliente not like '" +ls_filtro+ "%'")
	dw_1.filter()
	dw_1.groupcalc()
elseIf index = 2 then //PUNTO COM
	dw_1.setFilter( "fact_ruc_cliente like '" +ls_filtro+ "%'")
	dw_1.filter()
	dw_1.groupcalc()
elseIf index = 3 then //TOTAL
	ls_filtro = 'XX'
	dw_1.setFilter( "fact_ruc_cliente not like '" +ls_filtro+ "%'")
	dw_1.filter()
	dw_1.groupcalc()
end if

end event

type cb_consultar from commandbutton within w_pasar_proformas
integer x = 2953
integer y = 112
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
string text = "Pasar"
end type

event clicked;str_pase_proforma lstr_proformas
integer i
ib_pasar = true
istr_proformas = lstr_proformas

dw_1.accepttext()
dw_2.accepttext()

dw_1.setfilter('pasar = 1')
dw_2.setfilter('pasar = 1')
dw_1.filter()
dw_2.filter()
if dw_1.rowcount() = 0 then 
	gf_mensaje('','Debe seleccionar una proforma, Verifique !!!',1,1,'E')
	dw_1.setfilter('')
	dw_2.setfilter('')
	dw_1.filter()
	dw_2.filter()
	return
end if
if dw_2.rowcount() = 0 then 
	gf_mensaje('','Debe seleccionar las referencias a pasar, Verifique !!!',1,1,'E')
	dw_1.setfilter('')
	dw_2.setfilter('')
	dw_1.filter()
	dw_2.filter()
	return
end if

istr_proformas.proforma = dw_1.getitemstring(1,'prof_no_proforma')
istr_proformas.ann		= dw_1.getitemNumber(1,'prof_ann')

for i = 1 to dw_2.rowcount()
	istr_proformas.referencia[i] = dw_2.getitemstring(i, 'dpro_codigo_item')
	istr_proformas.cantidad[i] = dw_2.getitemNumber(i, 'por_pasar')
	istr_proformas.fraccion[i] = dw_2.getitemNumber(i, 'por_pasar_fraccion')	
	istr_proformas.linea[i] = dw_2.getitemNumber(i, 'dpro_linea')	
next

if isvalid(w_captura_pedidos) then
	w_captura_pedidos. dynamic wf_pasar_estructura_prof( istr_proformas )
else
	if  str.imprime_fiscal = 0 then
		w_facturacion. dynamic wf_pasar_estructura_prof( istr_proformas )
	else
		w_facturacion_fiscal. dynamic wf_pasar_estructura_prof( istr_proformas )
	end if
end if

close(parent)

//dw_1.setfilter('')
//dw_2.setfilter('')
//dw_1.filter()
//dw_2.filter()
//dw_1.retrieve(str.g_financiero, str.empresa)
end event

type cb_2 from commandbutton within w_pasar_proformas
integer x = 3323
integer y = 112
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

type dw_2 from datawindow within w_pasar_proformas
integer x = 23
integer y = 572
integer width = 3351
integer height = 1356
integer taborder = 11
boolean bringtotop = true
string title = "none"
string dataobject = "dw_pasar_proforma_detalle"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;string ls_objeto
integer i, li_pasar, li_fraccion
long ll_cantidad

if this.rowcount() = 0 then return

ls_objeto = dwo.name

choose case ls_objeto
	case 't_ok'
		li_pasar = this.getitemnumber(1,'pasar')		
		if li_pasar = 1 then
			li_pasar = 0
			ll_cantidad = 0
			li_fraccion = 0
		else
			li_pasar = 1
		end if
		for i = 1 to this.rowcount()
			this.setitem(i,'pasar',li_pasar)
			if li_pasar = 1 then
				ll_cantidad = dw_2.getitemnumber(i,'pendiente')
				li_fraccion  = dw_2.getitemnumber(i,'pendiente_fraccion')				
			end if
			dw_2.setitem(i,'por_pasar', ll_cantidad)
			dw_2.setitem(i,'por_pasar_fraccion',li_fraccion)
		next
end choose
end event

event itemchanged;this.accepttext()

choose case dwo.name
	case 'pasar'
		if data = '1' then
			this.setitem(row,'por_pasar',this.getitemnumber(row,'pendiente'))
			this.setitem(row,'por_pasar_fraccion',this.getitemnumber(row,'pendiente_fraccion'))						
		else
			this.setitem(row,'por_pasar',0)
			this.setitem(row,'por_pasar_fraccion',0)			
		end if
end choose
end event

type uo_1 from u_ddcalen within w_pasar_proformas
boolean visible = false
integer x = 1966
integer y = 128
integer taborder = 21
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

type uo_2 from u_ddcalen within w_pasar_proformas
boolean visible = false
integer x = 2693
integer y = 128
integer taborder = 31
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

type dw_3 from datawindow within w_pasar_proformas
integer x = 137
integer y = 44
integer width = 1390
integer height = 80
integer taborder = 20
string title = "none"
string dataobject = "dw_external_pase_proforma"
boolean border = false
boolean livescroll = true
end type

event editchanged;string ls_texto, ls_cadena
accepttext()
ls_texto = data
if isnull(ls_texto) then ls_texto = ''

choose case dwo.name
	case 'proforma'
		if len(ls_texto) > 0 then
			ls_cadena = 'left(upper(prof_no_proforma) ,'+ string(len(ls_texto))+ ') = "'+upper(ls_texto)+'"'
		else
			ls_cadena = ''
		end if
	case 'nombre'
		if len(ls_texto) > 0 then
			ls_cadena = 'upper(prof_a_nombre) like "%'+upper(ls_texto)+'%"'
		else
			ls_cadena = ''
		end if
end choose

dw_1.setfilter(ls_cadena)
dw_1.filter()
end event

