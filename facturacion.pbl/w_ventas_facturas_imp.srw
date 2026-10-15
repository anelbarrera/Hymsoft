//objectcomments Ventana de Impresión del Reporte de Ventas x Factura
forward
global type w_ventas_facturas_imp from w_fa_padre_reportes
end type
type ddlb_1 from dropdownlistbox within w_ventas_facturas_imp
end type
type st_sel_marca from statictext within w_ventas_facturas_imp
end type
type cbx_agrupar from checkbox within w_ventas_facturas_imp
end type
type st_1 from statictext within w_ventas_facturas_imp
end type
type ddlb_tipos from dropdownlistbox within w_ventas_facturas_imp
end type
type dw_2 from datawindow within w_ventas_facturas_imp
end type
type st_vendedor from statictext within w_ventas_facturas_imp
end type
type dw_3 from datawindow within w_ventas_facturas_imp
end type
end forward

global type w_ventas_facturas_imp from w_fa_padre_reportes
integer width = 4896
integer height = 2448
string title = "Ventas por Facturas"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 12639424
ddlb_1 ddlb_1
st_sel_marca st_sel_marca
cbx_agrupar cbx_agrupar
st_1 st_1
ddlb_tipos ddlb_tipos
dw_2 dw_2
st_vendedor st_vendedor
dw_3 dw_3
end type
global w_ventas_facturas_imp w_ventas_facturas_imp

type variables
str_fa_ventafact str_informe
datawindowchild idwc_vendedores
end variables

on w_ventas_facturas_imp.create
int iCurrent
call super::create
this.ddlb_1=create ddlb_1
this.st_sel_marca=create st_sel_marca
this.cbx_agrupar=create cbx_agrupar
this.st_1=create st_1
this.ddlb_tipos=create ddlb_tipos
this.dw_2=create dw_2
this.st_vendedor=create st_vendedor
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_1
this.Control[iCurrent+2]=this.st_sel_marca
this.Control[iCurrent+3]=this.cbx_agrupar
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.ddlb_tipos
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.st_vendedor
this.Control[iCurrent+8]=this.dw_3
end on

on w_ventas_facturas_imp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddlb_1)
destroy(this.st_sel_marca)
destroy(this.cbx_agrupar)
destroy(this.st_1)
destroy(this.ddlb_tipos)
destroy(this.dw_2)
destroy(this.st_vendedor)
destroy(this.dw_3)
end on

event resize;//Override
this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 328
gb_1.width  = this.width  - 63
gb_1.height = this.height - 270
cbx_agrupar.y = this.height - 180

st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180

ddlb_1.y = this.height - 200
ddlb_1.X = (this.width - 70) - ddlb_1.width 

st_sel_marca.y = this.height - 200
st_sel_marca.X = (this.width - 70) - ddlb_1.width - st_sel_marca.width -100

this.SetRedraw(true)

end event

event ue_post_open;//Override
string ls_empre, ls_ordenar
integer i, li_ann
string ls_pedido
decimal{2} ld_gramos, ld_piezas

This.SetRedraw(False)
/*Sòlo aplica para Newport y sus afiliadas*/

ls_empre = gf_dg_nombre_empresa()

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
st_nom_ventana.text = this.classname()


str_informe = Message.PowerObjectParm


	If str_informe.tipo_factura = 'Ventas' then //Consulta Ventas sin costos
		Choose Case str_informe.tipo
			
			Case "DETALLADO"
					dw_1.DataObject = "dw_fa_rep_ventas_fac_sin_costo"
			Case "RESUMIDO"	
					dw_1.DataObject = "dw_fa_rep_ventas_fac_res_sin_costo"
//					dw_1.modify("t_cargo.text='Cargos'")
			Case "SOLA"	
					dw_1.DataObject = "dw_fa_rep_ventas_fac_sola_sin_costo"
		End Choose
	else
		Choose Case str_informe.tipo
			
			Case "DETALLADO"
				if str.empresa = 1 and pos(str.empr_acceso_especial, 'GOLD,') > 0 then
					If dw_1.DataObject <> "dw_fa_rep_ventas_fac_new_abajo" Then	
						dw_1.DataObject = "dw_fa_rep_ventas_fac_new_abajo"
					End If
				else
					If dw_1.DataObject <> "dw_fa_rep_ventas_fac_new" Then	
						dw_1.DataObject = "dw_fa_rep_ventas_fac_new"
						//dw_1.object.datawindow.zoom = 80
					End If				
				end if
			Case "RESUMIDO"	

				if str_informe.cod_vendedor = 999 then //Si solicito el tipo de informe por vendedor
					If dw_1.DataObject <> "dw_reporte_facturas_x_vendedor_resumido" Then	
						dw_1.DataObject = "dw_reporte_facturas_x_vendedor_resumido"	
					End If										
					dw_3.getchild('vendedor',idwc_vendedores)
					idwc_vendedores.settransobject(sqlca)
					idwc_vendedores.retrieve(str.g_financiero, str.empresa)
					idwc_vendedores.insertrow(1)
					dw_3.insertrow(1)
					dw_3.visible = true
					st_vendedor.visible = true
				Elseif str_informe.cod_vendedor = 888 then //Si solicito el tipo de informe por vendedor
					If dw_1.DataObject <> "dw_facturas_resumidas_hpsa_pais" Then	
						dw_1.DataObject = "dw_facturas_resumidas_hpsa_pais"	
					End If				
				Elseif str_informe.cod_vendedor = 777 then //Si solicito el tipo de informe por vendedor
					If dw_1.DataObject <> "dw_facturas_resumidas_itbm" Then	
						dw_1.DataObject = "dw_facturas_resumidas_itbm"	
					End If									
				else
					If str.empresa = 1 and pos(str.empr_acceso_especial, 'GOLD,') > 0 then //pos(upper(str.nombre_empresa),'GOLD') > 0 Then 
						If dw_1.DataObject <> "dw_facturas_resumidas" Then	
							dw_1.DataObject = "dw_facturas_resumidas"
						End If
					elseif pos(str.empr_acceso_especial, 'HPSA') > 0 then 
						If dw_1.DataObject <> "dw_facturas_resumidas_hpsa" Then	
							dw_1.DataObject  = "dw_facturas_resumidas_hpsa"	
						End If		
					else
						If dw_1.DataObject <> "dw_fa_rep_ventas_fac_res_new" Then	
							dw_1.DataObject = "dw_fa_rep_ventas_fac_res_new"	
						End If					
					end if
				end if
				if pos(lower(ls_empre),"mylin") > 0  then
					dw_1.modify("t_cargo.text='I.T.B.M'")
				else
//					dw_1.modify("t_cargo.text='Cargos'")
				end if		
				
			Case "ESPECIAL"	
				If dw_1.DataObject <> "dw_fa_rep_ventas_fac_res_especial" Then	
					dw_1.DataObject = "dw_fa_rep_ventas_fac_res_especial"	
				End If					
				
			Case "SOLA"	
				If pos(upper(str.nombre_empresa),'AFISA') > 0 Then 
					If dw_1.DataObject <> "dw_fa_rep_ventas_fac_sola_newaf" Then	
						dw_1.DataObject = "dw_fa_rep_ventas_fac_sola_newaf"
					End If	
				else
					If dw_1.DataObject <> "dw_fa_rep_ventas_fac_sola_new" Then	
						dw_1.DataObject = "dw_fa_rep_ventas_fac_sola_new"
					End If
				end if
		End Choose
	End if

dw_1.settransobject(sqlca)

 
//	 If w_fa_fondo.str_para.utiliza_decimales = 1 Then			
		
//		If dw_1.Describe("dec.x") <> "?" And dw_1.Describe("dec.x") <> "!" Then
//		 dw_1.object.dec.expression = "'"+ "1" + "'"
//		End If			 
		
//	 End If	
	 
//*******************************************************************************************

if w_reportes_ventas.dw_1.rowcount() > 0 then
	dw_1.Object.Data = w_reportes_ventas.dw_1.Object.Data
end if

dw_1.GroupCalc()		

if dw_1.dataobject = 'dw_fa_rep_ventas_fac_res_new' or dw_1.dataobject = 'dw_facturas_resumidas_hpsa' or dw_1.dataobject = 'dw_facturas_resumidas_hpsa_pais'  then

	for i = 1 to dw_1.rowcount()
		ls_pedido = dw_1.getitemstring(i,'fact_no_pedido')
		li_ann	 = dw_1.getitemnumber(i,'fact_ann')
		
		  SELECT	sum( case when facd_cantidad < 0 and facd_rebajar = 0 then 0 else  case when medi_tipo_medida = 10 then 0 else facd_cantidad end end ) cantidad,   
					sum( case when facd_cantidad < 0 and facd_rebajar = 0 then 0 else  case when medi_tipo_medida <> 10 then 0 else facd_cantidad end end ) cantidad_pz 
			into :ld_gramos, :ld_piezas
			 FROM faddiari,   
					inamedid,
					inmprodu
			WHERE ( faddiari.facd_g_financiero = inmprodu.prod_g_financiero ) AND
					( faddiari.facd_empresa = inmprodu.prod_empresa ) AND
					( faddiari.facd_codigo_item = inmprodu.prod_producto ) AND
					( faddiari.facd_unidad_venta = inamedid.medi_medida ) and  
					( ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
					( faddiari.facd_empresa = :str.empresa ) AND  
					( faddiari.facd_no_pedido = :ls_pedido ) AND  
					( faddiari.facd_ann = :li_ann ) )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Buscar Cantidades '+sqlca.sqlerrtext,1,1,'E')
					return
				end if
		
		dw_1.setitem(i,'gramos', ld_gramos)
		dw_1.setitem(i,'piezas', ld_piezas)	
	next

end if

//Para setear el nombre de la Cia. al DW de impresion.
If dw_1.Describe("empresa.x") <> "?" And dw_1.Describe("empresa.x") <> "!" Then
	dw_1.object.empresa.expression = "'"+ ls_empre +"'"
End If	


//Setea el Nombre de la Ventana
st_nom_ventana.text = This.Classname()

If str_informe.tipo <> "SOLA" Then
	dw_1.object.fechas.expression = "'" +"Facturas Desde "+ str_informe.fecha1 +" Hasta "+ str_informe.fecha2 +"'"	 
End If
//
String	ls_expresion
Integer	li_pos
//Setea fecha
ls_expresion = string(date(gf_fecha_serv()))
dw_1.object.fecha.expression = "'"+ls_expresion+"'"
//Setea hora
ls_expresion = string(gf_fecha_serv(), "dd/mm/yyyy hh:mm AM/PM")
li_pos = Pos(ls_expresion," ")

ls_expresion =Right(ls_expresion, Len(ls_expresion) - li_pos)		
	
dw_1.object.hora.expression = "'"+ls_expresion+"'"
//

ddlb_tipos.text = '  TODOS'

dw_1.object.datawindow.print.preview = True
dw_1.object.datawindow.print.preview.zoom = 100

This.SetRedraw(True)
end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_ventas_facturas_imp
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_ventas_facturas_imp
boolean visible = false
integer x = 32
integer y = 1384
integer width = 73
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_ventas_facturas_imp
integer x = 41
integer y = 128
integer width = 2935
integer height = 1220
string dataobject = "dw_fa_rep_ventas_fac_res_new"
richtexttoolbaractivation richtexttoolbaractivation = richtexttoolbaractivationalways!
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::sqlpreview;/*
//str_informe.ls_where
iF str_informe.tipo ='DETALLADO' then
   if w_fa_fondo.str_para.mostrar_producto_dos = 0 then
		dw_1.retrieve(str.g_financiero,str.empresa)
	end if
else*/
sqlsyntax += str_informe.ls_where
This.SetSqlPreview(sqlsyntax)

end event

event dw_1::doubleclicked;call super::doubleclicked;string         ls_pointer
long           li_fila
datetime       ldt_fecha1
window		   lw_child
str_rangofecha	str_rangofecha_opcion
//str_fa_bus_var str_busqueda

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
	CASE 't_reserva'
		this.Modify("t_reserva.Font.Underline='1'")
		this.Modify("t_reserva.Color='16711680'")
	CASE 'fact_no_factura'
		this.Modify("fact_no_factura.Font.Underline='1'")
		this.Modify("fact_no_factura.Color='7536640'")
	CASE 'nomcli'
		this.Modify("nomcli.Font.Underline='1'")
		this.Modify("nomcli.Color='7536640'")

	CASE ELSE
//		this.Modify("t_reserva.Font.Underline='0'")
//		this.Modify("t_reserva.Color='0'")
		this.Modify("fact_no_factura.Font.Underline='0'")
		this.Modify("fact_no_factura.Color='0'")
		this.Modify("nomcli.Font.Underline='0'")
		this.Modify("nomcli.Color='0'")

END CHOOSE
end event

event dw_1::clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
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

if row = 0 then return
str_secuencia_doc lstr_sec

if ls_column = "fact_no_factura" then
	
	lstr_sec.ano = dw_1.getitemNumber(row,"fact_ann")
	lstr_sec.sec_manual = dw_1.getitemstring(row,"fact_no_factura")
	if pos(lstr_sec.sec_manual, 'NC-') > 0 then return
//	lstr_sec.tran	= dw_1.getitemstring(row,"movi_tipo_transaccion")
//	lstr_sec.subtran	= dw_1.getitemstring(row,"movi_sub_transaccion")	
	opensheetwithparm(w_facturas_actualizadas,lstr_sec,str.frame,9,layered!)
	
elseif ls_column = 'nomcli' then
	str_cc_formatos str_formato1		
	str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	str_formato1.tercero = dw_1.getitemNumber(row,"fact_cliente")
	Opensheetwithparm(w_estadocuenta,str_formato1,str.frame,9,original!)
elseif ls_column = 'porc_venta' then
	lstr_sec.ano = dw_1.getitemNumber(row,"fact_ann")
	lstr_sec.sec_manual = dw_1.getitemstring(row,"fact_no_factura")
	if dw_2.retrieve(str.g_financiero, str.empresa, lstr_sec.sec_manual, lstr_sec.ano) > 0 then
		dw_2.visible = true
		dw_2.setfocus()
	end if
	dw_2.object.datawindow.print.preview = True
	dw_2.object.datawindow.print.preview.zoom = 100
end if
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_ventas_facturas_imp
integer x = 27
integer y = 76
integer width = 2967
integer height = 1288
long backcolor = 12639424
end type

type ddlb_1 from dropdownlistbox within w_ventas_facturas_imp
boolean visible = false
integer x = 2240
integer y = 1388
integer width = 754
integer height = 244
integer taborder = 41
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

type st_sel_marca from statictext within w_ventas_facturas_imp
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

type cbx_agrupar from checkbox within w_ventas_facturas_imp
integer x = 41
integer y = 1360
integer width = 658
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Agrupar por cliente"
end type

event clicked;string ls_empre
if dw_1.dataobject <> 'dw_factura_agrupado_por_cliente' then
	dw_1.dataobject = 'dw_factura_agrupado_por_cliente'
	dw_1.settransobject(sqlca)
	dw_1.retrieve(str.g_financiero, str.empresa) 
	//Para setear el nombre de la Cia. al DW de impresion.
	ls_empre = gf_dg_nombre_empresa()
	If str_informe.tipo <> "SOLA" Then
		dw_1.object.fechas.expression = "'" +"Facturas Desde "+ str_informe.fecha1 +" Hasta "+ str_informe.fecha2 +"'"	 
	End If
	
	String	ls_expresion
	Integer	li_pos
	//Setea fecha
	ls_expresion = string(date(gf_fecha_serv()))
	dw_1.object.fecha.expression = "'"+ls_expresion+"'"
	//Setea hora
	ls_expresion = string(gf_fecha_serv(), "dd/mm/yyyy hh:mm AM/PM")
	li_pos = Pos(ls_expresion," ")

	ls_expresion ='Hora '+Right(ls_expresion, Len(ls_expresion) - li_pos)		
	
	dw_1.object.hora.expression = "'"+ls_expresion+"'"

	dw_1.object.datawindow.print.preview = True
	dw_1.object.datawindow.print.preview.zoom = 100

	If dw_1.Describe("empresa.x") <> "?" And dw_1.Describe("empresa.x") <> "!" Then
		dw_1.object.empresa.expression = "'"+ ls_empre +"'"
	End If	
	
end if
end event

type st_1 from statictext within w_ventas_facturas_imp
integer x = 1248
integer y = 24
integer width = 457
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Tipo de Factura:"
boolean focusrectangle = false
end type

type ddlb_tipos from dropdownlistbox within w_ventas_facturas_imp
integer x = 1701
integer y = 12
integer width = 608
integer height = 600
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
boolean sorted = false
string item[] = {"  TODOS","LIQUIDACION","OTROS","SALIDAS","TRASPASOS","DESPACHO DIRECTO"}
end type

event selectionchanged;choose case index
	case 1
		dw_1.setfilter('')
	case 2
		dw_1.setfilter('fatdiari_fact_tipo_movimiento = "L"')		
	case 3
		dw_1.setfilter('fatdiari_fact_tipo_movimiento = "O"')		
	case 4
		dw_1.setfilter('fatdiari_fact_tipo_movimiento = "S"')		
	case 5
		dw_1.setfilter('fatdiari_fact_tipo_movimiento = "T"')		
	case 6
		dw_1.setfilter('fatdiari_fact_tipo_movimiento = "D"')		
		
end choose

dw_1.filter()
dw_1.groupcalc()
end event

type dw_2 from datawindow within w_ventas_facturas_imp
boolean visible = false
integer x = 160
integer y = 336
integer width = 4727
integer height = 1928
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Factura Detallada"
string dataobject = "dw_factura_ganancia_unica"
boolean controlmenu = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
string icon = "AppIcon!"
boolean livescroll = true
end type

type st_vendedor from statictext within w_ventas_facturas_imp
boolean visible = false
integer x = 2450
integer y = 24
integer width = 315
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Vendedor:"
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_ventas_facturas_imp
boolean visible = false
integer x = 2816
integer y = 4
integer width = 800
integer height = 96
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_vendedor"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;this.accepttext()
string ls_filter

if integer(data) >= 0 then
	ls_filter = 'vfac_vendedor = '+string(data)
else
	ls_filter = ''
end if
dw_1.setfilter(ls_filter)
dw_1.filter()
dw_1.groupcalc()
end event

