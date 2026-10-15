//objectcomments Reporte de Transacciones de cuentas por cobrar
forward
global type w_resumen_ventas_prod_piezas from w_cc_padre_reporte
end type
type dw_2 from datawindow within w_resumen_ventas_prod_piezas
end type
type dw_3 from datawindow within w_resumen_ventas_prod_piezas
end type
end forward

global type w_resumen_ventas_prod_piezas from w_cc_padre_reporte
integer width = 3570
integer height = 1632
string title = "Reporte Detallado de Ventas Varias"
string menuname = "m_cc_principal_listados"
boolean resizable = true
windowtype windowtype = main!
long backcolor = 12639424
dw_2 dw_2
dw_3 dw_3
end type
global w_resumen_ventas_prod_piezas w_resumen_ventas_prod_piezas

type variables
str_fa_ventafact str_informe
end variables

on w_resumen_ventas_prod_piezas.create
int iCurrent
call super::create
if this.MenuName = "m_cc_principal_listados" then this.MenuID = create m_cc_principal_listados
this.dw_2=create dw_2
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
end on

on w_resumen_ventas_prod_piezas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_3)
end on

event resize;//Override
this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 278
gb_1.width  = this.width  - 60
gb_1.height = this.height - 200


st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180
this.SetRedraw(true)
end event

event ue_reg_anterior;//Override
dw.ScrollPriorPage( )
end event

event ue_siguiente_reg;call super::ue_siguiente_reg;//Override
dw.scrollNextpage()
end event

event ue_post_open;call super::ue_post_open;datetime ld_fecha1, ld_fecha2
integer li_grupo, i, li_ann, li_encontro, li_tipo_medida
string ls_empresa, ls_grupo, ls_pedido, ls_item, ls_find
decimal{2} ld_cargos, ld_valor, ld_recargos, ld_promedio
decimal{6} ldc_cantidad 

ls_empresa = gf_dg_nombre_empresa()

str_informe = message.powerObjectParm

if str_informe.tipo = 'RESUMIDO' then
	dw_1.dataobject = 'dw_ventas_productos_resumido'
else
	dw_1.dataobject = 'dw_ventas_productos_detallados_piezas'
end if

dw.SettransObject(sqlca)
dw_2.SettransObject(sqlca)
dw_3.SettransObject(sqlca)
ld_fecha1 = datetime(str_informe.fecha_inicio)
ld_fecha2 = datetime(str_informe.fecha_final)
dw.Object.datawindow.print.preview = true
dw.retrieve(str.g_financiero,str.empresa, ld_fecha1,ld_fecha2)

//dw.object.grupo.expression = "'"+ls_grupo+"'"
dw.object.empresanom.expression = "'"+ls_empresa+"'"
dw.object.rango_fecha.expression = "'"+"Desde el " +gf_fecha_palabras(str_informe.fecha_inicio)+" al "+gf_fecha_palabras(str_informe.fecha_final)+"'"

if str_informe.tipo = 'RESUMIDO' then
	
	if dw_3.retrieve(str.g_financiero,str.empresa, ld_fecha1, ld_fecha2) > 0 then
		ldc_cantidad = dw_3.getitemnumber(1,'cantidad_gramos')
		ld_valor	 	 = dw_3.getitemnumber(1,'valor_producto')
		ld_promedio  = ld_valor / ldc_cantidad	
		ld_recargos	 = dw_3.getitemnumber(1,'valor_recargo')			
		dw_1.insertrow(0)
		dw_1.setitem(dw_1.rowcount(),'facd_codigo_item','venta_varia')
		dw_1.setitem(dw_1.rowcount(),'prod_descripcion','VENTAS VARIAS')
		dw_1.setitem(dw_1.rowcount(),'cantidad_gramos',ldc_cantidad)
		dw_1.setitem(dw_1.rowcount(),'valor_producto',ld_valor)
		dw_1.setitem(dw_1.rowcount(),'valor_recargo',ld_recargos)
		dw_1.groupcalc()
	end if
	
	if dw_2.retrieve(str.g_financiero,str.empresa, ld_fecha1, ld_fecha2) > 0 then
		for i = 1 to dw_2.rowcount()
			li_ann 	 = dw_2.getitemnumber(i,'fact_ann')						
			ls_pedido = dw_2.getitemString(i,'fact_no_pedido')						
			ld_cargos = dw_2.getitemnumber(i,'fact_gastos_total')						
			
			  declare items cursor for
			   SELECT faddiari.facd_codigo_item, inamedid.medi_tipo_medida
				 FROM faddiari,   
						fatdiari,
						inamedid
				WHERE ( fatdiari.fact_g_financiero = faddiari.facd_g_financiero ) and  
						( fatdiari.fact_empresa = faddiari.facd_empresa ) and  
						( fatdiari.fact_tipo = faddiari.facd_tipo ) and  
						( fatdiari.fact_no_pedido = faddiari.facd_no_pedido ) and  
						( fatdiari.fact_ann = faddiari.facd_ann ) and  
						( faddiari.facd_unidad_venta = inamedid.medi_medida ) and
						( ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
						( faddiari.facd_empresa = :str.empresa ) AND  
						( fatdiari.fact_fecha >= :ld_fecha1 ) AND  
						( fatdiari.fact_fecha <= :ld_fecha2 ) AND  
						( fatdiari.fact_cierre_de_metal = 1 ) AND  
						( fatdiari.fact_estado = 'I' ))  order by
						faddiari.facd_codigo_item desc ;						
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al seleccionar item '+sqlca.sqlerrtext,1,1,'E')
					end if
				
				open items ;
				 if sqlca.sqlcode = -1 then
					 mensaje("Aviso","Error al Abrir el Cursor",sqlca.sqlerrtext)
				 end if

				fetch items into :ls_item, :li_tipo_medida ;
				
				close items;
				
				if li_tipo_medida <> 5 then ls_item = 'venta_varia'
				
				ls_find 		= 'facd_codigo_item = "'+ls_item+'"'
				li_encontro = dw_1.find(ls_find,1,dw_1.rowcount())
				if li_encontro > 0 then
					ld_valor = dw_1.getitemnumber(li_encontro,'valor_producto')
					ld_valor = ld_valor + ld_cargos
					dw_1.setitem(li_encontro,'valor_producto',ld_valor)
				end if
		next
	end if
	
end if
end event

event ue_zoom_down;call super::ue_zoom_down;//Zoom the display area of the datawindow down//

string ls_factor
integer li_factor
m_cc_principal_listados  lm_menu

//get the current zoom//

ls_factor = dw.object.datawindow.print.preview.zoom
li_factor = integer (ls_factor)

//only zoom down if magnification is greater than 20%//

if li_factor >= 40 and li_factor <= 100 then
	li_factor = li_factor -20
else
	//if magnification is currently 200%, zoom down to 100%
	if li_factor = 200 then
		li_factor = 100
	end if
end if

//set the new zoom level//

dw.object.datawindow.print.preview.zoom = li_factor

//check/uncheck the zoom menu items//
lm_menu = this.menuid

lm_menu.m_ventana.m_zoom.m_20%.checked = false
lm_menu.m_ventana.m_zoom.m_40%.checked = false
lm_menu.m_ventana.m_zoom.m_60%.checked = false
lm_menu.m_ventana.m_zoom.m_80%.checked = false
lm_menu.m_ventana.m_zoom.m_100%.checked = false
lm_menu.m_ventana.m_zoom.m_200%.checked = false

choose case li_factor
	case 20
		lm_menu.m_ventana.m_zoom.m_20%.checked = true
	case 40
		lm_menu.m_ventana.m_zoom.m_40%.checked = true
	case 60
		lm_menu.m_ventana.m_zoom.m_60%.checked = true
	case 80
		lm_menu.m_ventana.m_zoom.m_80%.checked = true
	case 100
		lm_menu.m_ventana.m_zoom.m_100%.checked = true
	case 200
		lm_menu.m_ventana.m_zoom.m_200%.checked = true
end choose

end event

type st_ayuda from w_cc_padre_reporte`st_ayuda within w_resumen_ventas_prod_piezas
end type

type st_nom_ventana from w_cc_padre_reporte`st_nom_ventana within w_resumen_ventas_prod_piezas
boolean visible = false
integer y = 1380
end type

type dw_1 from w_cc_padre_reporte`dw_1 within w_resumen_ventas_prod_piezas
integer x = 27
integer y = 56
integer width = 3465
string dataobject = "dw_ventas_productos_detallados_piezas"
boolean hscrollbar = false
boolean hsplitscroll = false
end type

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

if ls_column = "fact_no_factura" then
	
	str_secuencia_doc lstr_sec
	lstr_sec.ano = dw_1.getitemNumber(row,"fact_ann")
	lstr_sec.sec_manual = dw_1.getitemstring(row,"fact_no_factura")
//	lstr_sec.tran	= dw_1.getitemstring(row,"movi_tipo_transaccion")
//	lstr_sec.subtran	= dw_1.getitemstring(row,"movi_sub_transaccion")	
	opensheetwithparm(w_facturas_actualizadas,lstr_sec,str.frame,9,layered!)
	
elseif ls_column = 'fact_a_nombre' then
	str_cc_formatos str_formato1		
	str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	str_formato1.tercero = dw_1.getitemNumber(row,"fact_cliente")
	Opensheetwithparm(w_estadocuenta,str_formato1,str.frame,9,original!)
elseif ls_column = 'facd_descripcion_alterna' or ls_column = 'prod_descripcion'	then
		Window lw_child_v				
		string ls_producto
		str_kardex  str_opcion
		
			str_opcion.opcion_menu = 'MCP'
			str_opcion.opcion_ventana    = 'P'
			str_opcion.dwpantalla     = 'dw_in_mcp_prod_kard_1'
			str_opcion.dwreporte      = 'dw_in_mcp_prod_kard_2'
			str_opcion.titulo_ventana = 'Movimientos de Productos (Kardex)'
			
			if dw_1.rowcount() > 0 then
				ls_producto = dw_1.getitemstring(row,'facd_codigo_item')				
			end if
			
			if ls_producto = 'venta_varia' then 
				
			else
				str_opcion.kproducto=ls_producto	
				OpenSheetWithParm(lw_child_v,str_opcion,"w_in_movi_prod_kardex",str.frame,2,Original!)
			end if
			
end if
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
	CASE 'fact_no_factura'
		this.Modify("fact_no_factura.Font.Underline='1'")
		this.Modify("fact_no_factura.Color='7536640'")
	CASE 'fact_a_nombre'
		this.Modify("fact_a_nombre.Font.Underline='1'")
		this.Modify("fact_a_nombre.Color='7536640'")
	CASE 'facd_descripcion_alterna'
		this.Modify("facd_descripcion_alterna.Font.Underline='1'")
		this.Modify("facd_descripcion_alterna.Color='7536640'")		
	CASE 'prod_descripcion'
		this.Modify("prod_descripcion.Font.Underline='1'")
		this.Modify("prod_descripcion.Color='7536640'")				
	CASE ELSE
		this.Modify("fact_no_factura.Font.Underline='0'")
		this.Modify("fact_no_factura.Color='0'")
		this.Modify("fact_a_nombre.Font.Underline='0'")
		this.Modify("fact_a_nombre.Color='0'")
		this.Modify("facd_descripcion_alterna.Font.Underline='0'")
		this.Modify("facd_descripcion_alterna.Color='0'")		
		this.Modify("prod_descripcion.Font.Underline='0'")
		this.Modify("prod_descripcion.Color='0'")						

END CHOOSE
end event

type gb_1 from w_cc_padre_reporte`gb_1 within w_resumen_ventas_prod_piezas
integer y = 4
integer width = 3515
integer height = 1348
long backcolor = 12639424
end type

type dw_2 from datawindow within w_resumen_ventas_prod_piezas
boolean visible = false
integer x = 832
integer y = 1104
integer width = 782
integer height = 768
integer taborder = 11
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ventas_cargos_resumido"
boolean livescroll = true
end type

type dw_3 from datawindow within w_resumen_ventas_prod_piezas
boolean visible = false
integer x = 187
integer y = 376
integer width = 434
integer height = 768
integer taborder = 11
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ventas_productos_piezas_resumido"
boolean livescroll = true
end type

