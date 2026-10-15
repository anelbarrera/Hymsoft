//objectcomments Reporte de Transacciones de cuentas por cobrar
forward
global type w_resumen_ventas_prod from w_cc_padre_reporte
end type
type dw_2 from datawindow within w_resumen_ventas_prod
end type
type dw_3 from datawindow within w_resumen_ventas_prod
end type
end forward

global type w_resumen_ventas_prod from w_cc_padre_reporte
integer width = 3570
integer height = 1632
string title = "Reporte Resumido de Ventas por Articulos"
string menuname = "m_fa_rep"
boolean resizable = true
windowtype windowtype = main!
long backcolor = 12639424
dw_2 dw_2
dw_3 dw_3
end type
global w_resumen_ventas_prod w_resumen_ventas_prod

type variables
str_fa_ventafact str_informe
end variables

on w_resumen_ventas_prod.create
int iCurrent
call super::create
if this.MenuName = "m_fa_rep" then this.MenuID = create m_fa_rep
this.dw_2=create dw_2
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
end on

on w_resumen_ventas_prod.destroy
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
integer li_grupo, i, li_ann, li_encontro, li_tipo_medida	, li_kilates
string ls_empresa, ls_grupo, ls_pedido, ls_item, ls_find
decimal{2} ld_cargos, ld_valor, ld_recargos, ld_promedio, ld_24k, ld_18k, ld_10k, ld_cerradas, ld_final, ld_total, ld_gastos
decimal{6} ldc_cantidad , ldc_promedio_costo

ls_empresa = gf_dg_nombre_empresa()

str_informe = message.powerObjectParm

if str_informe.tipo = 'RESUMIDO' then
	dw_1.dataobject = 'dw_ventas_productos_resumido'
else
	dw_1.dataobject = 'dw_ventas_productos_detallados'
end if

dw.SettransObject(sqlca)
dw_2.SettransObject(sqlca)
dw_3.SettransObject(sqlca)
ld_fecha1 = datetime(str_informe.fecha_inicio)
ld_fecha2 = datetime(str_informe.fecha_final)
dw.Object.datawindow.print.preview = true
if dw.retrieve(str.g_financiero,str.empresa, ld_fecha1,ld_fecha2) > 0 then

 if str_informe.tipo = 'RESUMIDO' then

	  SELECT isnull(sum( case prod_kilates when 24 then facd_cantidad else 0 end ),0) ,   
				isnull(sum( case prod_kilates when 18 then facd_cantidad else 0 end ),0) ,   
				isnull(sum( case prod_kilates when 10 then facd_cantidad else 0 end ),0)    
		 into :ld_24k, :ld_18k, :ld_10k
		 FROM faddiari,   
				fatdiari,   
				inmprodu  
		WHERE ( fatdiari.fact_g_financiero = faddiari.facd_g_financiero ) and  
				( fatdiari.fact_empresa = faddiari.facd_empresa ) and  
				( fatdiari.fact_tipo = faddiari.facd_tipo ) and  
				( fatdiari.fact_no_pedido = faddiari.facd_no_pedido ) and  
				( fatdiari.fact_ann = faddiari.facd_ann ) and  
				( faddiari.facd_g_financiero = inmprodu.prod_g_financiero ) and  
				( faddiari.facd_empresa = inmprodu.prod_empresa ) and  
				( faddiari.facd_codigo_item = inmprodu.prod_producto ) and  
				( ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
				( fatdiari.fact_empresa = :str.empresa ) AND  
				( fatdiari.fact_excluir_de_reporte = 0 ) AND
				( fatdiari.fact_cierre_de_metal = 1 ) AND  
				( fatdiari.fact_fecha >= :ld_fecha1 ) AND  
				( fatdiari.fact_fecha <= :ld_fecha2 ) AND  
				( fatdiari.fact_estado = 'I' ) AND  
				( inmprodu.prod_kilates <> 0 ) ) ;
	
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al sumarizar Kilates '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
	
			dw_1.setitem(1,'k24',ld_24k)	
			dw_1.setitem(1,'k18',ld_18k)
			dw_1.setitem(1,'k10',ld_10k)
			
			  SELECT isnull( sum(cantidad_onza),0)  
				 INTO :ld_cerradas  
				 FROM fixing  
				WHERE ( fixing.grupo = :str.g_financiero ) AND  
						( fixing.empresa = :str.empresa ) AND  
						( fixing.fecha >= :ld_fecha1 ) AND  
						( fixing.fecha <= :ld_fecha2 )   ;	
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al sumarizar Onzas Cerradas '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
			
			dw_1.setitem(1,'cerradas',ld_cerradas)	
		
			//Promedio de Costo
 			DECLARE cur CURSOR FOR   
			  SELECT fixing.kilates,   
			              sum(fixing.valor) / sum(fixing.total_gramos)
				 FROM fixing  
				WHERE ( fixing.grupo = :str.g_financiero ) AND  
						( fixing.empresa = :str.empresa ) AND  
						( fixing.fecha >= :ld_fecha1 ) AND  
						( fixing.fecha <= :ld_fecha2 )
				group by kilates;    
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al buscar costo promedio '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
			
			open cur;
			
			fetch cur into :li_kilates, :ldc_promedio_costo;
			
			do while sqlca.sqlcode = 0	
				li_encontro = dw_1.find("facd_codigo_item like '%"+string(li_kilates)+"%'",1,dw_1.rowcount())
				if li_encontro > 0 then
					dw_1.setitem(li_encontro,'promedio_costo', ldc_promedio_costo)
				end if
				
				fetch cur into :li_kilates, :ldc_promedio_costo;
				
			loop	
			
			close cur;
			
			//Metal Pendiente para poner en el recargo
			  SELECT  isnull(sum( fact_monto_final ),0),   
					isnull(sum(fact_monto_fact_total) ,0),
					isnull(sum( fact_gastos_total),0)  
					into : ld_final, :ld_total, :ld_gastos
				 FROM    fatdiari
				WHERE  ( ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
						( fatdiari.fact_empresa = :str.empresa ) AND  
						( fatdiari.fact_metal_pendiente = 1 ) AND  
						( fact_factura_cierre = 0 ) and
						( fatdiari.fact_fecha >= :ld_fecha1 ) AND  
						( fatdiari.fact_fecha <= :ld_fecha2 ) AND  
						( fatdiari.fact_estado = 'I' )) ;
						
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al buscar costo valor de recargo '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
			
			dw_1.setitem(1,'valor_recargo',ld_final)
						
	end if //Del Resumido
		
end if
//dw.object.grupo.expression = "'"+ls_grupo+"'"
dw.object.empresanom.expression = "'"+ls_empresa+"'"
dw.object.rango_fecha.expression = "'"+"Desde el " +gf_fecha_palabras(str_informe.fecha_inicio)+" al "+gf_fecha_palabras(str_informe.fecha_final)+"'"

if str_informe.tipo = 'RESUMIDO' then
	
	if dw_3.retrieve(str.g_financiero,str.empresa, ld_fecha1, ld_fecha2) > 0 then
		ldc_cantidad = dw_3.getitemnumber(1,'cantidad_gramos')
		ld_valor	 	 = dw_3.getitemnumber(1,'valor_producto')
		if ldc_cantidad > 0 then
			ld_promedio  = ld_valor / ldc_cantidad	
		else
			ld_promedio = 0
		end if
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
		ld_gastos = dw_2.getitemnumber(1,'total')
		if isnull(ld_gastos) then ld_gastos = 0
		dw_1.setitem(1,'gastos',ld_gastos)
		
		//RETORNA, OBSOLETO
		return
		
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
					if ls_item <> 'venta_varia' then
						ld_valor = dw_1.getitemnumber(li_encontro,'valor_producto')
						ld_valor = ld_valor + ld_cargos
					//	dw_1.setitem(li_encontro,'valor_producto',ld_valor)
					end if
				end if
		next
	end if
	
end if

dw = dw_1
end event

event ue_zoom_down;//Zoom the display area of the datawindow down//

string ls_factor
integer li_factor
m_fa_rep  lm_menu

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

lm_menu.m_ventanas.m_zoom.m_20%.checked = false
lm_menu.m_ventanas.m_zoom.m_40%.checked = false
lm_menu.m_ventanas.m_zoom.m_60%.checked = false
lm_menu.m_ventanas.m_zoom.m_80%.checked = false
lm_menu.m_ventanas.m_zoom.m_100%.checked = false
lm_menu.m_ventanas.m_zoom.m_200%.checked = false

choose case li_factor
	case 20
		lm_menu.m_ventanas.m_zoom.m_20%.checked = true
	case 40
		lm_menu.m_ventanas.m_zoom.m_40%.checked = true
	case 60
		lm_menu.m_ventanas.m_zoom.m_60%.checked = true
	case 80
		lm_menu.m_ventanas.m_zoom.m_80%.checked = true
	case 100
		lm_menu.m_ventanas.m_zoom.m_100%.checked = true
	case 200
		lm_menu.m_ventanas.m_zoom.m_200%.checked = true
end choose

end event

event open;//override
/* Se establece un tamaño especifico para todas las ventanas 
   heredadas de este padre */
//integer i ,ii
sqlca.autocommit = true

This.Icon = str.icono
this.postevent("ue_post_open")

this.y=1
this.x=1
//this.width=3000
//this.height=1557
//

THIS.SetToolbar(1, true, alignattop!)
THIS.SetToolbarPos(1, 1, 50, false)


end event

event ue_vista;////override
//string ls_
dw = dw_1
//ls_ = upper(dw_1.Describe("DataWindow.Print.Preview"))
//if 	upper(dw_1.Describe("DataWindow.Print.Preview")) ="NO" then
////   dw.object.datawindow.print.preview="yes"
//	dw_1.Modify("DataWindow.Print.Preview='true'")
//else 
//	dw_1.Modify("DataWindow.Print.Preview=false")
////	dw.object.datawindow.print.preview="no"
//end if
//
////dw.Object.datawindow.print.preview.rulers = 'yes'
////dw.Object.datawindow.print.preview.zoom = 50

if dw_1.object.datawindow.print.preview="no" then
   dw_1.object.datawindow.print.preview="yes"
else 
	dw_1.object.datawindow.print.preview="no"
end if
end event

event ue_zoom_up;//override
////Zoom the display area of the datawindow down//

string ls_factor
integer li_factor
m_fa_rep  lm_menu

//get the current zoom//

ls_factor = dw.object.datawindow.print.preview.zoom
li_factor = integer (ls_factor)

//only zoom down if magnification is greater than 20%//

if li_factor >= 20 and li_factor <= 80 then
	li_factor = li_factor +20
else
	//if magnification is currently 200%, zoom down to 100%
	if li_factor = 100 then
		li_factor = 200
	end if
end if

//set the new zoom level//

dw.object.datawindow.print.preview.zoom = li_factor

//check/uncheck the zoom menu items//
lm_menu = this.menuid

lm_menu.m_ventanas.m_zoom.m_20%.checked = false
lm_menu.m_ventanas.m_zoom.m_40%.checked = false
lm_menu.m_ventanas.m_zoom.m_60%.checked = false
lm_menu.m_ventanas.m_zoom.m_80%.checked = false
lm_menu.m_ventanas.m_zoom.m_100%.checked = false
lm_menu.m_ventanas.m_zoom.m_200%.checked = false

choose case li_factor
	case 20
		lm_menu.m_ventanas.m_zoom.m_20%.checked = true
	case 40
		lm_menu.m_ventanas.m_zoom.m_40%.checked = true
	case 60
		lm_menu.m_ventanas.m_zoom.m_60%.checked = true
	case 80
		lm_menu.m_ventanas.m_zoom.m_80%.checked = true
	case 100
		lm_menu.m_ventanas.m_zoom.m_100%.checked = true
	case 200
		lm_menu.m_ventanas.m_zoom.m_200%.checked = true
end choose
		
end event

type st_ayuda from w_cc_padre_reporte`st_ayuda within w_resumen_ventas_prod
end type

type st_nom_ventana from w_cc_padre_reporte`st_nom_ventana within w_resumen_ventas_prod
boolean visible = false
integer y = 1380
end type

type dw_1 from w_cc_padre_reporte`dw_1 within w_resumen_ventas_prod
integer x = 27
integer y = 56
integer width = 3465
string dataobject = "dw_ventas_productos_resumido"
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
			   str_informe.tipo   = 'DETALLADO'
				OpenSheetWithParm(w_resumen_ventas_prod_piezas,str_informe,Parent,2,Layered!)  
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

event dw_1::retrieveend;call super::retrieveend;integer i
string ls_producto

//for i = 1 to rowcount
	
//next

end event

type gb_1 from w_cc_padre_reporte`gb_1 within w_resumen_ventas_prod
integer y = 4
integer width = 3515
integer height = 1348
long backcolor = 12639424
end type

type dw_2 from datawindow within w_resumen_ventas_prod
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

type dw_3 from datawindow within w_resumen_ventas_prod
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

