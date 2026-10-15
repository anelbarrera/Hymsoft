forward
global type w_rotacion_del_inventario from w_fa_padre_reportes
end type
type em_desde from editmask within w_rotacion_del_inventario
end type
type em_hasta from editmask within w_rotacion_del_inventario
end type
type st_1 from statictext within w_rotacion_del_inventario
end type
type st_2 from statictext within w_rotacion_del_inventario
end type
type calendario from picture within w_rotacion_del_inventario
end type
type calendario2 from picture within w_rotacion_del_inventario
end type
type uo_1 from u_ddcalen within w_rotacion_del_inventario
end type
type uo_2 from u_ddcalen within w_rotacion_del_inventario
end type
type dw_2 from datawindow within w_rotacion_del_inventario
end type
type dw_3 from datawindow within w_rotacion_del_inventario
end type
type rb_1 from radiobutton within w_rotacion_del_inventario
end type
type rb_2 from radiobutton within w_rotacion_del_inventario
end type
type hpb_barra from hprogressbar within w_rotacion_del_inventario
end type
type cbx_cubrio_costo from checkbox within w_rotacion_del_inventario
end type
type cb_2 from commandbutton within w_rotacion_del_inventario
end type
type dw_6 from datawindow within w_rotacion_del_inventario
end type
type dw_7 from datawindow within w_rotacion_del_inventario
end type
type dw_8 from datawindow within w_rotacion_del_inventario
end type
type dw_9 from datawindow within w_rotacion_del_inventario
end type
type dw_12 from datawindow within w_rotacion_del_inventario
end type
type dw_13 from datawindow within w_rotacion_del_inventario
end type
type cb_1 from commandbutton within w_rotacion_del_inventario
end type
type cb_salir from commandbutton within w_rotacion_del_inventario
end type
end forward

global type w_rotacion_del_inventario from w_fa_padre_reportes
integer width = 6194
integer height = 2428
string title = "Reporte de Rotacion del Inventario"
long backcolor = 12639424
string icon = "\harr98\Art\MINUS.ico"
windowanimationstyle openanimation = noanimation!
windowanimationstyle closeanimation = noanimation!
event ue_saveas ( )
em_desde em_desde
em_hasta em_hasta
st_1 st_1
st_2 st_2
calendario calendario
calendario2 calendario2
uo_1 uo_1
uo_2 uo_2
dw_2 dw_2
dw_3 dw_3
rb_1 rb_1
rb_2 rb_2
hpb_barra hpb_barra
cbx_cubrio_costo cbx_cubrio_costo
cb_2 cb_2
dw_6 dw_6
dw_7 dw_7
dw_8 dw_8
dw_9 dw_9
dw_12 dw_12
dw_13 dw_13
cb_1 cb_1
cb_salir cb_salir
end type
global w_rotacion_del_inventario w_rotacion_del_inventario

type variables
datawindowchild idwc_tipo, idwc_sexo, idwc_material, idwc_marca, idwc_definicion, idwc_prov, idwc_descrip
string is_cadena, is_marcas[], is_sort1, is_campo1


end variables

forward prototypes
public function boolean wf_calcula_promedio (string as_producto, ref decimal ld_promedio, ref decimal ld_margen)
public subroutine wf_ocultar_dws (integer ai_dw)
public subroutine wf_cargar_marcas ()
end prototypes

event ue_saveas();string ls_path, ls_title
integer li_respuesta

ls_title = "Reporte de Inventario por Fecha"

li_respuesta = gf_mensaje('','Yes = Salvar a Excel, No = Otro Formato o Cancelar',4,1,'Q')
choose case li_respuesta
	case 1
		ls_path = nv_f.of_browseforfolder("Guardar Excel en ..",true)
		If Len(Trim(ls_path)) > 0 then		
			uf_save_dw_as_excel(dw_1,ls_path+'\'+ls_title+'.xls')
		End If

	case 2
		dw.saveas()
end choose

end event

public function boolean wf_calcula_promedio (string as_producto, ref decimal ld_promedio, ref decimal ld_margen);
SELECT convert(numeric(8,2), sum(dmov_precio_original  * dmov_cantidad)  / sum(dmov_cantidad)),
		 convert(numeric(12,6), sum(prod_costo_fob  * dmov_cantidad)  / sum(dmov_precio_original * dmov_cantidad))
into :ld_promedio, :ld_margen
 FROM indmovim, inmprodu
WHERE ( indmovim.dmov_g_financiero = inmprodu.prod_g_financiero ) AND
		( indmovim.dmov_empresa = inmprodu.prod_empresa ) AND
		( indmovim.dmov_producto = inmprodu.prod_producto ) AND
		( indmovim.dmov_g_financiero = :str.g_financiero ) AND  
		( indmovim.dmov_empresa = :str.empresa ) AND  
		( indmovim.dmov_aplicacion = 'FA') AND
		( indmovim.dmov_producto = :as_producto ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al buscar promedio '+ sqlca.sqlerrtext,1,1,'E')
			return false
		end if

return true
end function

public subroutine wf_ocultar_dws (integer ai_dw);	if ai_dw <> 6 then
		dw_6.visible = false
	end if
	if ai_dw <> 7 then
		dw_7.visible = false
		wf_cargar_marcas()
	end if
	if ai_dw <> 8 then
		dw_8.visible = false
	end if
	if ai_dw <> 9 then
		dw_9.visible = false
	end if
	if ai_dw <> 12 then
		dw_12.visible = false
	end if
	if ai_dw <> 13 then
		dw_13.visible = false
	end if



end subroutine

public subroutine wf_cargar_marcas ();integer i,j
string   ls_marca, ls_m[]

is_marcas[] = ls_m[]

for i = 1 to dw_7.rowcount()
	if dw_7.getitemnumber(i,'li_check') = 1 then
		j ++
		ls_marca = dw_7.getitemstring(i,'amar_num_marca')
		is_marcas[j] = ls_marca
	end if
next
end subroutine

on w_rotacion_del_inventario.create
int iCurrent
call super::create
this.em_desde=create em_desde
this.em_hasta=create em_hasta
this.st_1=create st_1
this.st_2=create st_2
this.calendario=create calendario
this.calendario2=create calendario2
this.uo_1=create uo_1
this.uo_2=create uo_2
this.dw_2=create dw_2
this.dw_3=create dw_3
this.rb_1=create rb_1
this.rb_2=create rb_2
this.hpb_barra=create hpb_barra
this.cbx_cubrio_costo=create cbx_cubrio_costo
this.cb_2=create cb_2
this.dw_6=create dw_6
this.dw_7=create dw_7
this.dw_8=create dw_8
this.dw_9=create dw_9
this.dw_12=create dw_12
this.dw_13=create dw_13
this.cb_1=create cb_1
this.cb_salir=create cb_salir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_desde
this.Control[iCurrent+2]=this.em_hasta
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.calendario
this.Control[iCurrent+6]=this.calendario2
this.Control[iCurrent+7]=this.uo_1
this.Control[iCurrent+8]=this.uo_2
this.Control[iCurrent+9]=this.dw_2
this.Control[iCurrent+10]=this.dw_3
this.Control[iCurrent+11]=this.rb_1
this.Control[iCurrent+12]=this.rb_2
this.Control[iCurrent+13]=this.hpb_barra
this.Control[iCurrent+14]=this.cbx_cubrio_costo
this.Control[iCurrent+15]=this.cb_2
this.Control[iCurrent+16]=this.dw_6
this.Control[iCurrent+17]=this.dw_7
this.Control[iCurrent+18]=this.dw_8
this.Control[iCurrent+19]=this.dw_9
this.Control[iCurrent+20]=this.dw_12
this.Control[iCurrent+21]=this.dw_13
this.Control[iCurrent+22]=this.cb_1
this.Control[iCurrent+23]=this.cb_salir
end on

on w_rotacion_del_inventario.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_desde)
destroy(this.em_hasta)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.calendario)
destroy(this.calendario2)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.hpb_barra)
destroy(this.cbx_cubrio_costo)
destroy(this.cb_2)
destroy(this.dw_6)
destroy(this.dw_7)
destroy(this.dw_8)
destroy(this.dw_9)
destroy(this.dw_12)
destroy(this.dw_13)
destroy(this.cb_1)
destroy(this.cb_salir)
end on

event ue_post_open;/* dw corresponde al datawindows que se desea imprimir, por tanto
   si desea asignarle otro nombre haga lo siguiente 
	dw = otro_nombre */
dw = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()

Datawindowchild ldwc_vendedores
dw_2.settransobject(sqlca)
em_hasta.text = string(date(gf_fecha_serv()))
em_desde.text = string(relativedate(date(gf_fecha_serv()), - 365))
em_desde.setfocus()
dw_6.settransobject(sqlca)
dw_6.retrieve(str.g_financiero, str.empresa)
dw_6.insertrow(1)

//is_syntax_7 = dw_7.getsqlselect()
dw_7.settransobject(sqlca)
dw_7.retrieve(str.g_financiero, str.empresa)
dw_7.insertrow(1)

dw_8.settransobject(sqlca)
dw_8.retrieve(str.g_financiero, str.empresa)
dw_8.insertrow(1)

dw_9.settransobject(sqlca)
dw_9.retrieve(str.g_financiero, str.empresa)
dw_9.insertrow(1)


dw_12.settransobject(sqlca)
dw_12.retrieve(str.g_financiero, str.empresa)
dw_12.insertrow(1)

dw_13.settransobject(sqlca)
dw_13.retrieve()
dw_13.insertrow(1)

dw_3.settransobject(sqlca)

//dw_3.getchild('proveedor_tercero', idwc_prov)
//dw_3.getchild('division', idwc_division)
//dw_3.getchild('grupo', idwc_grupo)

//dw_3.getchild('tipo', idwc_tipo)
//dw_3.getchild('material', idwc_material)
//dw_3.getchild('definicion', idwc_definicion)
//dw_3.getchild('descripcion', idwc_descrip)

//idwc_division.settransobject(sqlca)
//idwc_grupo.settransobject(sqlca)
//idwc_material.settransobject(sqlca)
//idwc_marca.settransobject(sqlca)
//idwc_definicion.settransobject(sqlca)
//idwc_prov.settransobject(sqlca)
//idwc_descrip.settransobject(sqlca)
dw_1.Object.datawindow.print.preview = true
yield()
//idwc_division.retrieve(str.g_financiero, str.empresa)
//idwc_grupo.retrieve(str.g_financiero, str.empresa)
//idwc_material.retrieve(str.g_financiero, str.empresa)
//idwc_marca.retrieve(str.g_financiero, str.empresa)
//idwc_definicion.retrieve(str.g_financiero, str.empresa)
//idwc_prov.retrieve(str.g_financiero, str.empresa)
//idwc_descrip.retrieve(str.g_financiero, str.empresa)
//idwc_tipo.insertrow(1)
//idwc_tipo.setitem(1,'amar_num_marca', '1516')
//idwc_tipo.setitem(1,'amar_nombre_marca', 'BABY LOONEY TUNES Y LOONEY TUNES')

//idwc_division.insertrow(1)
//idwc_grupo.insertrow(1)
//idwc_material.insertrow(1)
//idwc_marca.insertrow(1)
//idwc_definicion.insertrow(1)
//idwc_prov.insertrow(1)
//idwc_descrip.insertrow(1)

dw_3.insertrow(1)
dw_3.setitem(1, "disponible", 1)


end event

event resize;call super::resize;//OVERRIDE
this.SetRedraw(false)
dw_1.width  = this.width  - 100
dw_1.height = this.height - 600
gb_1.width  = this.width  - 125
gb_1.height = this.height - 170

st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180
this.SetRedraw(true)
end event

event ue_print;OpenWithParm(w_dw_print_options, dw_1)
If Message.DoubleParm = -1 Then Return
//dw_1.Modify("DataWindow.Zoom='80'")
dw_1.Print(True)
end event

event ue_save_as;//
//dw_1.saveas()

string ls_path, ls_title
integer li_respuesta

li_respuesta = gf_mensaje('','Yes = Salvar a Excel, No = Otro Formato o Cancelar',4,1,'Q')
choose case li_respuesta
	case 1
		ls_path = nv_f.of_browseforfolder("Guardar Excel en ..",true)
		If Len(Trim(ls_path)) > 0 then		
			uf_save_dw_as_excel(dw,ls_path+'\'+ls_title+'.xls')
		End If

	case 2
		dw.saveas()
end choose

end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_rotacion_del_inventario
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_rotacion_del_inventario
boolean visible = false
integer x = 41
integer y = 2116
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_rotacion_del_inventario
integer y = 272
integer width = 6066
integer height = 1804
string dataobject = "dw_rotacion_del_inventario"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

event dw_1::ue_microayuda;////override

end event

event dw_1::clicked;call super::clicked;//dw=tab_1.tabpage_1.dw_1
//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto
integer li_pos 

wf_ocultar_dws(0)

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

//override
string ls_column
ls_column = dwo.name
if ls_column = "inmprodu_prod_producto" then
	
	if row = 0 then return
	
		Window lw_child_v				
		string ls_producto
		str_kardex  str_opcion
		
			str_opcion.opcion_menu = 'MCP'
			str_opcion.opcion_ventana    = 'P'
			str_opcion.dwpantalla     = 'dw_in_mcp_prod_kard_1'
			str_opcion.dwreporte      = 'dw_in_mcp_prod_kard_2'
			str_opcion.titulo_ventana = 'Movimientos de Productos (Kardex)'
			
			if dw_1.rowcount() > 0 then
				ls_producto = dw_1.getitemstring(row,'inmprodu_prod_producto')				
			end if
			
			str_opcion.kproducto=ls_producto
		
			OpenSheetWithParm(lw_child_v,str_opcion,"w_in_movi_prod_kardex",str.frame,2,Original!)		
	
end if
end event

event dw_1::retrieveend;call super::retrieveend;//long ll_count, ll_existencia_total, ll_disponible, ll_step, ll_entrada
//string ls_cod_prod, ls_error
//integer li_filas
//decimal ld_reserva_total, ld_medida
//datetime ldt_fecha
//
//if this.rowcount() > 0 then
//
//li_filas = rowcount
//hpb_barra.SetRange ( 0, li_filas )		
//hpb_barra.MaxPosition = li_filas
//hpb_barra.Position = 0
//ll_step = 1 //00 / li_filas
//hpb_barra.SetStep = ll_step
//hpb_barra.offsetpos(1)
//hpb_barra.visible = true
//
//DWObject dwo_producto, dwo_medida, dwo_existencia, dwo_fecha_entrada
//dwo_producto = this.object.prod_producto
//dwo_medida = this.object.inamedid_medi_cantidad
//dwo_existencia = this.object.inmprodu_prod_existencia_total
//dwo_fecha_entrada = this.object.inmprodu_prod_entrada_fecha
//
//	for ll_count = 1 to this.rowcount()
//	
//		if ll_count > this.rowcount() then exit
//		
//		hpb_barra.StepIt ( )
//			
//		ls_cod_prod = dwo_producto.primary[ll_count] //this.getitemstring(ll_count, 'prod_producto')
//
//		yield()
//
//		//Busca la reserva
//		 DECLARE sp_reserva PROCEDURE FOR fa_reservados_totaldos  
//				@g_financiero = :str.g_financiero,   
//				@empresa = :str.empresa,   
//				@codigo_producto = :ls_cod_prod ;
//
//			if sqlca.sqlcode = -1 then
//				mensaje("Aviso","Error al declarar el cursor",sqlca.sqlerrtext)
//				return
//			end if
//			
//			execute sp_reserva;												
//			// set.
//			DO WHILE SQLCA.sqlcode = 0							
//			// Fetch the next row from the first result set.						
//				FETCH sp_reserva INTO :ld_reserva_total;
//			LOOP
//			
//			if sqlca.sqlcode = -1 then
//				ls_error = sqlca.sqlerrtext
//				gf_mensaje("Aviso","Error al buscar la reserva",1,1,'E')
//				return
//			end if
//
//			close sp_reserva;
//
//			if isnull(ld_reserva_total) then ld_reserva_total = 0
//			if ll_count > this.rowcount() then exit			
//			ld_medida = dwo_medida.primary[ll_count] //this.getitemdecimal(ll_count, "inamedid_medi_cantidad")
//			
//			if ld_reserva_total > 0 then ld_reserva_total = ld_reserva_total / ld_medida
//			
//			ll_existencia_total = dwo_existencia.primary[ll_count] / ld_medida //this.getitemnumber(ll_count, 'inmprodu_prod_existencia_total') / ld_medida
//
//			ll_disponible = (ll_existencia_total - ld_reserva_total )
//		
//			this.setitem(ll_count, "dentero", ll_disponible)
//
//			ldt_fecha = dwo_fecha_entrada.primary[ll_count] //this.getitemdatetime(ll_count,'inmprodu_prod_entrada_fecha')
//
//			//cantidad de la entrada
//			SELECT  isnull(sum(dmov_cantidad) ,0)
//				into :ll_entrada
//				 FROM indmovim,   
//						intmovim  
//				WHERE ( intmovim.tmov_g_financiero = indmovim.dmov_g_financiero ) and  
//						( intmovim.tmov_empresa = indmovim.dmov_empresa ) and  
//						( intmovim.tmov_aplicacion = indmovim.dmov_aplicacion ) and  
//						( intmovim.tmov_tipo_transaccion = indmovim.dmov_tipo_transaccion ) and  
//						( intmovim.tmov_secuencia = indmovim.dmov_secuencia ) and  
//						( intmovim.tmov_concepto = indmovim.dmov_concepto ) and  
//						( intmovim.tmov_anual = indmovim.dmov_anual ) and  
//						( ( indmovim.dmov_g_financiero = :str.g_financiero ) AND  
//						( indmovim.dmov_empresa = :str.empresa ) AND  
//						( indmovim.dmov_aplicacion = 'IN' ) AND  
//						( indmovim.dmov_tipo_transaccion = 'EN' ) AND  
//						( indmovim.dmov_producto = :ls_cod_prod ) AND  
//						( intmovim.tmov_fecha = :ldt_fecha ) );
//					if sqlca.sqlcode = -1 then
//						gf_mensaje('','Error al buscar cantidad '+sqlca.sqlerrtext ,1,1,'E')
//						return
//					end if
//			if ll_entrada > 0 then
//				this.setitem(ll_count,'prod_ultima_entrada_can',ll_entrada)
//			end if
//			
//				decimal{2} ld_monto_vendido = 0, ld_cantidad_vendida = 0, ld_monto_vendido_ped, ld_cantidad_vendida_ped, ld_monto_vendido_fac, ld_cantidad_vendida_fac, &
//				   ld_costo_ped, ld_precio_ped, ld_costo_fac, ld_precio_fac, ld_costo_inv, ld_precio_inv, ld_promedio, ld_margen
//				string ls_prod
//				
//					SELECT isnull(convert(numeric(8,2), sum(dmov_precio_original  * dmov_cantidad)),0),
//							 isnull(convert(numeric(8,2), sum(dmov_cantidad)),0),
//							 isnull(convert(numeric(12,6), sum(prod_costo_fob  * dmov_cantidad)),0),  
//							 isnull(sum(dmov_precio_original * dmov_cantidad),0)				 
//					into :ld_monto_vendido, :ld_cantidad_vendida, :ld_costo_inv, :ld_precio_inv
//					 FROM intmovim, indmovim, inmprodu
//					WHERE ( indmovim.dmov_g_financiero = intmovim.tmov_g_financiero ) and  
//							( indmovim.dmov_empresa = intmovim.tmov_empresa ) and  
//							( indmovim.dmov_aplicacion = intmovim.tmov_aplicacion ) and  
//							( indmovim.dmov_tipo_transaccion = intmovim.tmov_tipo_transaccion ) and  
//							( indmovim.dmov_concepto = intmovim.tmov_concepto ) and  
//							( indmovim.dmov_secuencia = intmovim.tmov_secuencia ) and  
//							( indmovim.dmov_anual = intmovim.tmov_anual ) and
//							( indmovim.dmov_g_financiero = inmprodu.prod_g_financiero ) AND
//							( indmovim.dmov_empresa = inmprodu.prod_empresa ) AND
//							( indmovim.dmov_producto = inmprodu.prod_producto ) AND
//							( indmovim.dmov_g_financiero = :str.g_financiero ) AND  
//							( indmovim.dmov_empresa = :str.empresa ) AND  
//							( indmovim.dmov_tipo_transaccion in ('SA','FA')) AND
//							( indmovim.dmov_producto = :ls_cod_prod ) ;
//							if sqlca.sqlcode = -1 then
//								gf_mensaje('','Error al buscar promedio '+ sqlca.sqlerrtext,1,1,'E')
//							end if
//			
//			
//						SELECT isnull(convert(numeric(8,2), sum(dped_precio_original  * dped_cantidad)),0),
//									isnull(convert(numeric(8,2), sum(dped_cantidad)),0),
//									 isnull(convert(numeric(12,6), sum(prod_costo_fob  * dped_cantidad)),0),
//									 isnull(sum(dped_precio_original * dped_cantidad),0)
//						into :ld_monto_vendido_ped, :ld_cantidad_vendida_ped, :ld_costo_ped, :ld_precio_ped
//						 FROM fadpedid, inmprodu
//						WHERE  ( fadpedid.dped_g_financiero = inmprodu.prod_g_financiero ) AND
//								( fadpedid.dped_empresa = inmprodu.prod_empresa ) AND
//								( fadpedid.dped_codigo_item = inmprodu.prod_producto ) AND
//								( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
//								( fadpedid.dped_empresa = :str.empresa ) AND  
//								( fadpedid.dped_pasada = 0) AND
//								( fadpedid.dped_codigo_item = :ls_cod_prod ) ;
//								if sqlca.sqlcode = -1 then
//									gf_mensaje('','Error al buscar promedio '+ sqlca.sqlerrtext,1,1,'E')
//								end if
//				
//						SELECT isnull(convert(numeric(8,2), sum(facd_precio_original  * facd_cantidad)),0),
//								 isnull(convert(numeric(8,2), sum(facd_cantidad)),0),
//								 isnull(convert(numeric(12,6), sum(prod_costo_fob  * facd_cantidad)),0),
//								 isnull(sum(facd_precio_original * facd_cantidad),0)
//						into :ld_monto_vendido_fac, :ld_cantidad_vendida_fac, :ld_costo_fac, :ld_precio_fac
//						 FROM faddiari, fatdiari, inmprodu
//						WHERE  ( faddiari.facd_g_financiero = inmprodu.prod_g_financiero ) AND
//									( faddiari.facd_empresa = inmprodu.prod_empresa ) AND
//									( faddiari.facd_codigo_item = inmprodu.prod_producto ) AND
//									 ( faddiari.facd_g_financiero = fatdiari.fact_g_financiero ) and  
//									( faddiari.facd_empresa = fatdiari.fact_empresa ) and  
//									( faddiari.facd_tipo = fatdiari.fact_tipo ) and  
//									( faddiari.facd_no_pedido = fatdiari.fact_no_pedido ) and  
//									( faddiari.facd_ann = fatdiari.fact_ann ) and  
//									( fatdiari.fact_estado = 'A' ) and
//									( faddiari.facd_g_financiero = :str.g_financiero ) AND  
//									( faddiari.facd_empresa = :str.empresa ) AND  
//									( faddiari.facd_codigo_item = :ls_cod_prod ) ;
//									if sqlca.sqlcode = -1 then
//										gf_mensaje('','Error al buscar promedio '+ sqlca.sqlerrtext,1,1,'E')
//									end if
//				
//					if  (ld_cantidad_vendida + ld_cantidad_vendida_ped + ld_cantidad_vendida_fac) > 0 then
//						ld_promedio = (ld_monto_vendido + ld_monto_vendido_ped + ld_monto_vendido_fac) / (ld_cantidad_vendida + ld_cantidad_vendida_ped + ld_cantidad_vendida_fac)
//					end if
//					
//					if (ld_precio_ped + ld_precio_fac + ld_precio_inv) > 0 then
//						ld_margen   =  round((1 -  ((ld_costo_ped + ld_costo_fac + ld_costo_inv)  / (ld_precio_ped + ld_precio_fac + ld_precio_inv ))) * 100,2)
//					end if
//					
//					this.setitem(ll_count,'precio_promedio',ld_promedio)
//					this.setitem(ll_count,'margen_promedio',ld_margen)
//	next
//	
//	hpb_barra.visible = false
//end if
//
end event

event dw_1::sqlpreview;call super::sqlpreview;string ls_comprador, ls_cadena_comprador, ls_cadena_definicion, ls_definicion,  ls_cadena_material, ls_material, ls_descrip, ls_code,ls_cadena_descrip , ls_marca, ls_syntax, ls_cadena_marca = '', ls_sexo, ls_cadena_sexo, ls_cadena_tercero, ls_tipo, ls_cadena_tipo
integer i
long ll_tercero
ls_syntax = sqlsyntax
is_campo1 = ''
for i = 2 to dw_6.rowcount()
	if dw_6.getitemnumber(i,'li_check') = 1 then
		ls_sexo = dw_6.getitemstring(i,'adiv_codigo_div')
		if ls_cadena_sexo = '' then
			ls_cadena_sexo = ls_cadena_sexo + ' and ( prod_division = "'+ls_sexo+'"'
		else
			ls_cadena_sexo = ls_cadena_sexo + ' or prod_division = "'+ls_sexo+'"'			
		end if
	end if
next
if ls_cadena_sexo <> '' then 
	ls_cadena_sexo = ls_cadena_sexo + ') '
	is_campo1 = 'cradivis_adiv_nombre_div'	
end if
ls_syntax = ls_syntax + ls_cadena_sexo

for i = 2 to dw_7.rowcount()
	if dw_7.getitemnumber(i,'li_check') = 1 then
		ls_marca = dw_7.getitemstring(i,'amar_num_marca')
		if ls_cadena_marca = '' then
			ls_cadena_marca = ls_cadena_marca + ' and ( prod_marca = "'+ls_marca+'"'
		else
			ls_cadena_marca = ls_cadena_marca + ' or prod_marca = "'+ls_marca+'"'			
		end if
	end if
next

if ls_cadena_marca <> '' then 
	ls_cadena_marca = ls_cadena_marca + ') '
	is_campo1 = 'cramarca_amar_nombre_marca'	
end if
ls_syntax = ls_syntax + ls_cadena_marca

for i = 2 to dw_8.rowcount()
	if dw_8.getitemnumber(i,'li_check') = 1 then
		ll_tercero = dw_8.getitemnumber(i,'terc_tercero')
		if ls_cadena_tercero = '' then
			ls_cadena_tercero = ls_cadena_tercero + ' and ( prod_tercero = '+string(ll_tercero)
		else
			ls_cadena_tercero = ls_cadena_tercero + ' or prod_tercero = '+string(ll_tercero)
		end if
	end if
next
if ls_cadena_tercero <> '' then 
	ls_cadena_tercero = ls_cadena_tercero + ') '
	is_campo1 = 'terc_descripcion'
end if
ls_syntax = ls_syntax + ls_cadena_tercero

for i = 1 to dw_9.rowcount()
	if dw_9.getitemnumber(i,'li_check') = 1 then
		ls_tipo = dw_9.getitemstring(i,'agru_codigo_grupo')
		if isnull(ls_tipo) then continue
		if ls_cadena_tipo = '' then
			ls_cadena_tipo = ls_cadena_tipo + ' and ( prod_grupo = "'+ls_tipo+'"'
		else
			ls_cadena_tipo = ls_cadena_tipo + ' or prod_grupo = "'+ls_tipo+'"'			
		end if
	end if
next
if ls_cadena_tipo <> '' then 
	ls_cadena_tipo = ls_cadena_tipo + ') '
	is_campo1 = 'cragrupo_agru_descripcion_grupo'
end if
ls_syntax = ls_syntax + ls_cadena_tipo

this.setsqlpreview(ls_syntax)
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_rotacion_del_inventario
boolean visible = false
integer y = 268
integer width = 4402
integer height = 1840
end type

type em_desde from editmask within w_rotacion_del_inventario
boolean visible = false
integer x = 306
integer y = 16
integer width = 347
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type em_hasta from editmask within w_rotacion_del_inventario
boolean visible = false
integer x = 306
integer y = 108
integer width = 343
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_1 from statictext within w_rotacion_del_inventario
boolean visible = false
integer x = 27
integer y = 28
integer width = 256
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Desde: "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_rotacion_del_inventario
boolean visible = false
integer x = 27
integer y = 120
integer width = 256
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Hasta: "
alignment alignment = right!
boolean focusrectangle = false
end type

type calendario from picture within w_rotacion_del_inventario
boolean visible = false
integer x = 654
integer y = 16
integer width = 69
integer height = 80
boolean bringtotop = true
string pointer = "HyperLink!"
string picturename = "\Harr2000\Art\ddfec.bmp"
boolean focusrectangle = false
end type

event clicked;date 	ld_date,ld_ini_date, ld_hoy
//parent.height = 1144
	
	ld_ini_date=date(em_desde.text)
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

end event

type calendario2 from picture within w_rotacion_del_inventario
boolean visible = false
integer x = 654
integer y = 108
integer width = 69
integer height = 80
boolean bringtotop = true
string pointer = "HyperLink!"
string picturename = "\Harr2000\Art\ddfec.bmp"
boolean focusrectangle = false
end type

event clicked;date 	ld_date,ld_ini_date, ld_hoy
//parent.height = 1144
	
	ld_ini_date=date(em_hasta.text)
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

end event

type uo_1 from u_ddcalen within w_rotacion_del_inventario
boolean visible = false
integer y = 128
integer taborder = 30
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;em_desde.text = string(uo_1.return_sel_date())

if uo_1.allow_close then
	this.visible=false
	em_desde.SetFocus()
end if


end event

on uo_1.destroy
call u_ddcalen::destroy
end on

type uo_2 from u_ddcalen within w_rotacion_del_inventario
boolean visible = false
integer x = 658
integer y = 128
integer taborder = 40
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;em_hasta.text = string(uo_2.return_sel_date())

if uo_2.allow_close then
	this.visible=false
	em_hasta.SetFocus()
end if


end event

on uo_2.destroy
call u_ddcalen::destroy
end on

type dw_2 from datawindow within w_rotacion_del_inventario
boolean visible = false
integer x = 2021
integer y = 8
integer width = 3538
integer height = 2396
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Factura del Proveedor"
string dataobject = "dw_detalle_transito"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean vscrollbar = true
boolean resizable = true
string icon = "AppIcon!"
boolean livescroll = true
end type

type dw_3 from datawindow within w_rotacion_del_inventario
integer x = 64
integer y = 36
integer width = 2958
integer height = 220
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_division_grupo_marca"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//Aplica filtros
accepttext()
string ls_sexo, ls_tipo, ls_texto, ls_campo, ls_foto, ls_material, ls_len, ls_columna, ls_marca, ls_definicion
string ls_sexo_cadena, ls_cod_sex, ls_prov, ls_descrip_cadena, ls_descrip, ls_descrip_temp, ls_comprador
boolean lb_entro
long ll_disponible, ll_count, ll_cuenta, ll_tercero
integer li_bandera = 0, li_check, li_incluir, li_bandera2 = 0
ls_texto = data

if isnull(ls_texto) then ls_texto = ''

ls_columna  = this.getcolumnname()

li_incluir = dw_3.getitemnumber(1,'incluir')

is_cadena = ''

choose case ls_columna
//	li_bandera2 = 1
	//Fin de Descripciones
	
	case 'disponible'
		ll_disponible = long(data)
	case 'incluir'
		li_incluir = long(data)
end choose

ll_disponible = dw_3.getitemnumber(1,'disponible')

	
	if ll_tercero > 0 then
		if lb_entro then
			is_cadena = is_cadena + ' and prod_tercero = '+string(ll_tercero)
		else
			is_cadena = 'prod_tercero  = '+string(ll_tercero)
		end if
		lb_entro = true
	end if
	
	if len(ls_marca) > 0 then
		if lb_entro then
			if ls_marca = '00' then
				is_cadena = is_cadena + " and (upper(inmprodu_prod_marca)  <> '642' and upper(inmprodu_prod_marca)  <> '16' and upper(inmprodu_prod_marca)  <> '15')"
			else
				is_cadena = is_cadena + ' and upper(inmprodu_prod_marca)  = "'+upper(ls_marca)+'"'
			end if
		else
			if ls_marca = '00' then
				is_cadena = is_cadena + " (upper(inmprodu_prod_marca)  <> '642' and upper(inmprodu_prod_marca)  <> '16' and upper(inmprodu_prod_marca)  <> '15')"
			else
				is_cadena = is_cadena + ' upper(inmprodu_prod_marca)  = "'+upper(ls_marca)+'"'
			end if
		end if
		lb_entro = true
	end if

if ll_disponible = 0 then
	if len(is_cadena) > 0 then
		if li_incluir = 1 then
			is_cadena = is_cadena + " and disponible >= "+string(ll_disponible)
		else
			is_cadena = is_cadena + " and disponible = "+string(ll_disponible)
		end if
	else
		if li_incluir = 1 then
			is_cadena =  "disponible >= "+string(ll_disponible)
		else
			is_cadena =  "disponible = "+string(ll_disponible)
		end if
	end if
else
	if len(is_cadena) > 0 then
		is_cadena = is_cadena + " and disponible >= "+string(ll_disponible)
	else
		is_cadena =  "disponible >= "+string(ll_disponible)
	end if
end if 


//messagebox('', is_cadena)

dw_1.setfilter(is_cadena)
dw_1.filter()
dw_1.groupcalc()
end event

event editchanged;string ls_texto, ls_cadena
integer li_encontro

choose case dwo.name
	case 'division'
		ls_texto = data
		ls_cadena = 'left(upper(adiv_nombre_div) ,'+ string(len(ls_texto))+ ') = "'+upper(ls_texto)+'"'		
		li_encontro = dw_6.find(ls_cadena,1,dw_6.rowcount())
		if li_encontro > 0 then
			dw_6.scrolltorow(li_encontro)
		end if
	case 'marca'
		ls_texto = data
		ls_cadena = 'left(upper(amar_nombre_marca) ,'+ string(len(ls_texto))+ ') = "'+upper(ls_texto)+'"'		
		li_encontro = dw_7.find(ls_cadena,1,dw_7.rowcount())
		if li_encontro > 0 then
			dw_7.scrolltorow(li_encontro)
		end if
	case 'proveedor_tercero'
		ls_texto = data
		ls_cadena = 'left(upper(terc_descripcion) ,'+ string(len(ls_texto))+ ') = "'+upper(ls_texto)+'"'		
		li_encontro = dw_8.find(ls_cadena,1,dw_8.rowcount())
		if li_encontro > 0 then
			dw_8.scrolltorow(li_encontro)
		end if		
	case 'grupo'
		ls_texto = data
		ls_cadena = 'left(upper(agru_descripcion_grupo) ,'+ string(len(ls_texto))+ ') = "'+upper(ls_texto)+'"'		
		li_encontro = dw_9.find(ls_cadena,1,dw_9.rowcount())
		if li_encontro > 0 then
			dw_9.scrolltorow(li_encontro)
		end if			
end choose

//return 2
end event

event clicked;
string ls_filtro, ls_1[], ls_marca, ls_marca_nombre, ls_syntax, ls_sexo_cadena, ls_cod_sex, ls_prov, ls_descrip_cadena, ls_descrip, ls_descrip_temp, ls_comprador, ls_columna, ls_cadena_sexo, ls_sexo
boolean lb_entro
string ls_sexos
long ll_disponible, ll_count, ll_cuenta, ll_tercero
integer li_rtn, li_bandera = 0, li_check, li_incluir, li_bandera2 = 0, i, j
this.accepttext()
//ls_texto = data

//if isnull(ls_texto) then ls_texto = ''

ls_columna  = dwo.name //this.getcolumnname()

is_cadena = ''

choose case ls_columna
	case 'division', 'p_division'
		wf_ocultar_dws(6)
		
		if dw_6.visible then
			dw_6.visible = false
		else
			dw_6.visible = true	
		end if
		if ls_columna = 'p_division' then
			dw_6.setcolumn(1)
			dw_6.setfocus()
		end if
	case 'marca', 'p_marca'
		wf_ocultar_dws(7)
		if dw_7.visible then
			dw_7.visible = false
		else
			dw_7.visible = true	
		end if
		if ls_columna = 'p_marca' then
			dw_7.setcolumn(1)
			dw_7.setfocus()
		end if		
	case 'proveedor_tercero', 'p_proveedor'
		wf_ocultar_dws(8)
		if dw_8.visible then
			dw_8.visible = false
		else
			dw_8.visible = true	
		end if
		if ls_columna = 'p_proveedor' then
			dw_8.setcolumn(1)
			dw_8.setfocus()
		end if		
	case 'grupo', 'p_grupo'
		wf_ocultar_dws(9)
		//Se filtran los grupo por la división seleccionada
		ls_filtro = dw_6.GetItemString(dw_6.getrow(),"adiv_codigo_div")
		dw_9.SetFilter("agru_codigo_div = '" + ls_filtro + "'")	
		li_rtn = dw_9.Filter()

		if dw_9.visible then
			dw_9.visible = false
		else
			dw_9.visible = true	
		end if
		if ls_columna = 'p_grupo' then
			dw_9.setcolumn(1)
			dw_9.setfocus()
		end if		
	case 'definicion', 'p_definicion'
			wf_ocultar_dws(12)
			if dw_12.visible then
				dw_12.visible = false
			else
				dw_12.visible = true	
			end if
			if ls_columna = 'p_definicion' then
				dw_12.setcolumn(1)
				dw_12.setfocus()
			end if				
	case 'comprador', 'p_comprador'
			wf_ocultar_dws(13)
			if dw_13.visible then
				dw_13.visible = false
			else
				dw_13.visible = true	
			end if
			if ls_columna = 'p_comprador' then
				dw_13.setcolumn(1)
				dw_13.setfocus()
			end if							
end choose
end event

event buttonclicked;choose case dwo.name
	case 'p_division'
		if dw_6.visible then
			dw_6.visible = false
		else
			dw_6.visible = true
		end if
	case 'p_marca'
		if dw_7.visible then
			dw_7.visible = false
		else
			dw_7.visible = true
		end if		
	case 'p_proveedor'
		if dw_8.visible then
			dw_8.visible = false
		else
			dw_8.visible = true
		end if				
	case 'p_grupo'
		if dw_9.visible then
			dw_9.visible = false
		else
			dw_9.visible = true
		end if						
	case 'p_definicion'
		if dw_12.visible then
			dw_12.visible = false
		else
			dw_12.visible = true
		end if								
	case 'p_comprador'
		if dw_13.visible then
			dw_13.visible = false
		else
			dw_13.visible = true
		end if								
end choose
end event

type rb_1 from radiobutton within w_rotacion_del_inventario
boolean visible = false
integer x = 4919
integer y = 36
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Consulta"
boolean checked = true
end type

event clicked;//if this.checked = true then
//	dw_1.visible = true
//	dw_5.visible = false
//end if
end event

type rb_2 from radiobutton within w_rotacion_del_inventario
boolean visible = false
integer x = 4919
integer y = 104
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Impresión"
end type

event clicked;//date ldt_desde, ldt_hasta
//
//if this.checked = true then
//	dw_5.visible = true
//	dw_1.visible = false
//	
//	ldt_desde = date(em_desde.text)
//	ldt_hasta = date(em_hasta.text)
//
//	dw_5.setitem(1, "desde", string(ldt_desde))
//	dw_5.setitem(1, "hasta", string(ldt_hasta))
//
//	dw_5.Modify("DataWindow.Zoom='80'")
//
//end if
end event

type hpb_barra from hprogressbar within w_rotacion_del_inventario
boolean visible = false
integer x = 347
integer y = 692
integer width = 3227
integer height = 84
boolean bringtotop = true
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

type cbx_cubrio_costo from checkbox within w_rotacion_del_inventario
boolean visible = false
integer x = 4914
integer y = 200
integer width = 786
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ref. que Cubrieron su Costo"
end type

event clicked;integer i, li_filas
datetime ldt_fecha_entrada
string ls_producto
decimal{2} ld_costo, ld_total_entrada, ld_total_vendido
long ll_entrada, ll_step

if this.checked then
	li_filas = dw_1.rowcount()
	hpb_barra.SetRange ( 0, li_filas )		
	hpb_barra.MaxPosition = li_filas
	hpb_barra.Position = 0
	ll_step = 1 //00 / li_filas
	hpb_barra.SetStep = ll_step
	hpb_barra.offsetpos(1)
	hpb_barra.visible = true

	if dw_1.Describe("ver.x") <> "?" and dw_1.Describe("ver.x") <> "!" then &
	dw_1.object.ver.expression = "'" + string(1) + "'"
	dw_1.object.cramaterial_mat_compo.width = '873'
	dw_1.object.cramaterial_mat_compo_t.width = '873'
	
	for i = 1 to li_filas
		yield()
		hpb_barra.StepIt()
				
		ld_costo = dw_1.getitemnumber(i,'inmprodu_prod_costo_fob')
		ll_entrada = dw_1.getitemnumber(i,'prod_ultima_entrada_can')
		ld_total_entrada = ld_costo * ll_entrada
		dw_1.setitem(i,'total_entrada',ld_total_entrada)
		ls_producto =  dw_1.getitemstring(i,'prod_producto')
		ldt_fecha_entrada = dw_1.getitemdatetime(i,'inmprodu_prod_entrada_fecha')
		
		SELECT isnull(sum(faddiari.facd_monto_final),0)
			into :ld_total_vendido
			 FROM faddiari,   
					fatdiari  
			WHERE ( fatdiari.fact_g_financiero = faddiari.facd_g_financiero ) and  
					( fatdiari.fact_empresa = faddiari.facd_empresa ) and  
					( fatdiari.fact_tipo = faddiari.facd_tipo ) and  
					( fatdiari.fact_no_pedido = faddiari.facd_no_pedido ) and  
					( fatdiari.fact_ann = faddiari.facd_ann ) and  
					( ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
					( faddiari.facd_empresa = :str.empresa ) AND  
					( faddiari.facd_codigo_item = :ls_producto ) AND  
					( fatdiari.fact_fecha >= :ldt_fecha_entrada ) )    ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al buscar monto vendido '+ sqlca.sqlerrtext,1,1,'E')
					end if
		dw_1.setitem(i,'total_vendido',ld_total_vendido)	
		
	next
	dw_1.setfilter(is_cadena +' and total_vendido > total_entrada')
else
	dw_1.object.cramaterial_mat_compo.width = '1321'
	dw_1.object.cramaterial_mat_compo_t.width = '1321'
	if dw_1.Describe("ver.x") <> "?" and dw_1.Describe("ver.x") <> "!" then &
	dw_1.object.ver.expression = "'" + string(0) + "'"
	dw_1.setfilter(is_cadena)
end if
hpb_barra.visible = false
dw_1.filter()
dw_1.groupcalc()
end event

type cb_2 from commandbutton within w_rotacion_del_inventario
integer x = 3077
integer y = 172
integer width = 407
integer height = 88
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Limpiar Filtro"
end type

event clicked;integer li_entero, i
dw_3.accepttext()
li_entero = dw_3.getitemnumber(1,'disponible')
dw_3.reset()
dw_3.insertrow(0)
dw_3.setitem(1, "disponible", li_entero)
is_cadena = "disponible >= "+string(li_entero)
dw_1.setfilter( is_cadena)
dw_1.filter()

for i = 1 to dw_6.rowcount()
	dw_6.setitem(i,'li_check',0)
next
for i = 1 to dw_7.rowcount()
	dw_7.setitem(i,'li_check',0)
next
for i = 1 to dw_8.rowcount()
	dw_8.setitem(i,'li_check',0)
next
for i = 1 to dw_9.rowcount()
	dw_9.setitem(i,'li_check',0)
next
for i = 1 to dw_12.rowcount()
	dw_12.setitem(i,'li_check',0)
next
for i = 1 to dw_13.rowcount()
	dw_13.setitem(i,'li_check',0)
next

end event

type dw_6 from datawindow within w_rotacion_del_inventario
event ue_post_item ( )
boolean visible = false
integer x = 306
integer y = 116
integer width = 882
integer height = 1040
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "dw_division_check"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_post_item();integer i, li_check
string ls_sexo, ls_cadena_sexo
if this.getcolumnname() = 'li_check' then
	if this.getrow() = 1 then
		li_check = this.getitemnumber(1,'li_check')
		for i = 1 to this.rowcount()
			this.setitem(i,'li_check',li_check)
		next
		if li_check = 0 then
			dw_3.setitem(1,'division','')			
		else
			dw_3.setitem(1,'division',this.getitemstring(2,'adiv_nombre_div')+'...')
		end if
		return
	else
		if this.getitemnumber(this.getrow(),'li_check') = 1 then
			ls_sexo = dw_3.getitemstring(1,'division')
			if ls_sexo = '' or isnull(ls_sexo) then
				dw_3.setitem(1,'division',this.getitemstring(this.getrow(),'adiv_nombre_div'))
			else
				if right(ls_sexo,3) <> '...' then
					dw_3.setitem(1,'division',ls_sexo + '...')
				end if
			end if
		else
			ls_sexo = dw_3.getitemstring(1,'division')
			if right(ls_sexo,3) = '...' then
				for i = 1 to dw_6.rowcount()
					li_check = this.getitemnumber(i,'li_check')
					if li_check = 1 then
						ls_sexo = this.getitemstring(i,'adiv_nombre_div')
						if ls_cadena_sexo = '' then
							ls_cadena_sexo = ls_sexo
						else
							ls_cadena_sexo = ls_cadena_sexo + '...'
							exit
						end if
					end if
				next
				dw_3.setitem(1,'division',ls_cadena_sexo)
			else
				dw_3.setitem(1,'division','')
			end if
		end if

	end if
end if
end event

event buttonclicked;dw_6.visible = false
end event

event clicked;integer li_check, i
string ls_text, ls_campo
this.accepttext()

dw_7.visible = false
dw_8.visible = false
dw_9.visible = false

if row = 0 then return

if dwo.name = 'adiv_nombre_div' then
	li_check = this.getitemnumber(row,'li_check')
	if li_check = 0 then
		this.setitem(row,'li_check',1)
		if dw_3.getitemstring(1,'division') = '' or isnull(dw_3.getitemstring(1,'division')) then
			dw_3.setitem(1,'division',this.getitemstring(row,'adiv_nombre_div'))
		end if
	else
		this.setitem(row,'li_check',0)
		dw_3.setitem(1,'division','')
	end if
else
//	ls_text = this.getitemstring(row,'adiv_nombre_div')
//	if isnull(ls_text) then
//		for i = 1 to this.rowcount()
//			this.setitem(i,'li_check',0)
//			dw_3.setitem(1,'division','')
//		next
//		dw_7.accepttext()
//		return 2
//	end if
end if

end event

event itemchanged;this.accepttext()
this.postevent('ue_post_item')
end event

type dw_7 from datawindow within w_rotacion_del_inventario
event ue_post_item ( )
boolean visible = false
integer x = 1513
integer y = 112
integer width = 896
integer height = 1032
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_marca_check"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_post_item();integer i, li_check
string ls_marca, ls_cadena_marca
if this.getcolumnname() = 'li_check' then
	if this.getrow() = 1 then
		//this.setitem(1,'li_check',0)
		//dw_3.setitem(1,'marca','')			
		//return
		li_check = this.getitemnumber(1,'li_check')
		for i = 1 to this.rowcount()
			this.setitem(i,'li_check',li_check)
		next
		if li_check = 0 then
			dw_3.setitem(1,'marca','')			
		else
			dw_3.setitem(1,'marca',this.getitemstring(2,'amar_nombre_marca')+'...')
		end if
		return
	else
		if this.getitemnumber(this.getrow(),'li_check') = 1 then
			ls_marca = dw_3.getitemstring(1,'marca')
			if ls_marca = '' or isnull(ls_marca) then
				dw_3.setitem(1,'marca',this.getitemstring(this.getrow(),'amar_nombre_marca'))
			else
				if right(ls_marca,3) <> '...' then
					dw_3.setitem(1,'marca',ls_marca + '...')
				end if
			end if
		else
			ls_marca = dw_3.getitemstring(1,'marca')
			if right(ls_marca,3) = '...' then
				for i = 1 to dw_7.rowcount()
					li_check = this.getitemnumber(i,'li_check')
					if li_check = 1 then
						ls_marca = this.getitemstring(i,'amar_nombre_marca')
						if ls_cadena_marca = '' then
							ls_cadena_marca = ls_marca
						else
							ls_cadena_marca = ls_cadena_marca + '...'
							exit
						end if
					end if
				next
				dw_3.setitem(1,'marca',ls_cadena_marca)
			else
				dw_3.setitem(1,'marca','')
			end if
		end if

	end if
end if
end event

event itemchanged;this.accepttext()
this.postevent('ue_post_item')
end event

event buttonclicked;dw_7.visible = false
end event

event clicked;integer li_check, i
string ls_text, ls_campo
this.accepttext()
dw_6.visible = false
dw_8.visible = false

if row = 0 then return

if dwo.name = 'amar_nombre_marca' then
	li_check = this.getitemnumber(row,'li_check')
	if li_check = 0 then
		this.setitem(row,'li_check',1)
		if dw_3.getitemstring(1,'marca') = '' or isnull(dw_3.getitemstring(1,'marca')) then
			dw_3.setitem(1,'marca',this.getitemstring(row,'amar_nombre_marca'))
		end if
	else
		this.setitem(row,'li_check',0)
		dw_3.setitem(1,'marca','')
	end if
else
//	ls_text = this.getitemstring(row,'amar_nombre_marca')
//	if isnull(ls_text) then
//		for i = 1 to this.rowcount()
//			this.setitem(i,'li_check',0)
//			dw_3.setitem(1,'marca','')
//		next
//		dw_7.accepttext()
//		return 2
//	end if
end if
end event

type dw_8 from datawindow within w_rotacion_del_inventario
event ue_post_item ( )
boolean visible = false
integer x = 1518
integer y = 200
integer width = 887
integer height = 1040
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_proveedores_check"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_post_item();integer i, li_check
string ls_proveedor, ls_cadena_proveedor
if this.getcolumnname() = 'li_check' then
	if this.getrow() = 1 then
		li_check = this.getitemnumber(1,'li_check')
		for i = 1 to this.rowcount()
			this.setitem(i,'li_check',li_check)
		next
		if li_check = 0 then
			dw_3.setitem(1,'proveedor_tercero','')			
		else
			dw_3.setitem(1,'proveedor_tercero',this.getitemstring(2,'terc_descripcion')+'...')
		end if
		return
	else
		if this.getitemnumber(this.getrow(),'li_check') = 1 then
			ls_proveedor = dw_3.getitemstring(1,'proveedor_tercero')
			if ls_proveedor = '' or isnull(ls_proveedor) then
				dw_3.setitem(1,'proveedor_tercero',this.getitemstring(this.getrow(),'terc_descripcion'))
			else
				if right(ls_proveedor,3) <> '...' then
					dw_3.setitem(1,'proveedor_tercero',ls_proveedor + '...')
				end if
			end if
		else
			ls_proveedor = dw_3.getitemstring(1,'proveedor_tercero')
			if right(ls_proveedor,3) = '...' then
				for i = 1 to dw_8.rowcount()
					li_check = this.getitemnumber(i,'li_check')
					if li_check = 1 then
						ls_proveedor = this.getitemstring(i,'terc_descripcion')
						if ls_cadena_proveedor = '' then
							ls_cadena_proveedor = ls_proveedor
						else
							ls_cadena_proveedor = ls_cadena_proveedor + '...'
							exit
						end if
					end if
				next
				dw_3.setitem(1,'proveedor_tercero',ls_cadena_proveedor)
			else
				dw_3.setitem(1,'proveedor_tercero','')
			end if
		end if

	end if
end if
end event

event clicked;integer li_check, i
string ls_text, ls_campo

dw_6.visible = false
dw_7.visible = false

this.accepttext()

if row = 0 then return

if dwo.name = 'terc_descripcion' then
	li_check = this.getitemnumber(row,'li_check')
	if li_check = 0 then
		this.setitem(row,'li_check',1)
		if dw_3.getitemstring(1,'proveedor_tercero') = '' or isnull(dw_3.getitemstring(1,'proveedor_tercero')) then
			dw_3.setitem(1,'proveedor_tercero',this.getitemstring(row,'terc_descripcion'))
		end if
	else
		this.setitem(row,'li_check',0)
		dw_3.setitem(1,'proveedor_tercero','')
	end if
else
//	ls_text = this.getitemstring(row,'terc_descripcion')
//	if isnull(ls_text) then
//		for i = 1 to this.rowcount()
//			this.setitem(i,'li_check',0)
//			dw_3.setitem(1,'proveedor_tercero','')
//		next
//		dw_7.accepttext()
//		return 2
//	end if
end if
end event

event itemchanged;this.accepttext()
this.postevent('ue_post_item')
end event

event buttonclicked;dw_8.visible = false
end event

type dw_9 from datawindow within w_rotacion_del_inventario
event ue_post_item ( )
boolean visible = false
integer x = 311
integer y = 204
integer width = 873
integer height = 1096
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_grupos_check"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_post_item();integer i, li_check
string ls_tipo, ls_cadena_tipo
if this.getcolumnname() = 'li_check' then
		if this.getitemnumber(this.getrow(),'li_check') = 1 then
			ls_tipo = dw_3.getitemstring(1,'grupo')
			if ls_tipo = '' or isnull(ls_tipo) then
				dw_3.setitem(1,'grupo',this.getitemstring(this.getrow(),'agru_descripcion_grupo'))
			else
				if right(ls_tipo,3) <> '...' then
					dw_3.setitem(1,'grupo',ls_tipo + '...')
				end if
			end if
		else
			ls_tipo = dw_3.getitemstring(1,'grupo')
			if right(ls_tipo,3) = '...' then
				for i = 1 to dw_9.rowcount()
					li_check = this.getitemnumber(i,'li_check')
					if li_check = 1 then
						ls_tipo = this.getitemstring(i,'agru_descripcion_grupo')
						if ls_cadena_tipo = '' then
							ls_cadena_tipo = ls_tipo
						else
							ls_cadena_tipo = ls_cadena_tipo + '...'
							exit
						end if
					end if
				next
				dw_3.setitem(1,'grupo',ls_cadena_tipo)
			else
				dw_3.setitem(1,'grupo','')
			end if
		end if
end if
end event

event buttonclicked;dw_9.visible = false

end event

event clicked;integer li_rtn, li_check, i
string ls_text, ls_campo, ls_filtro

this.accepttext()

dw_7.visible = false
dw_8.visible = false
dw_6.visible = false

if this.rowcount() = 0 then return

if dwo.name = 'agru_descripcion_grupo' then
	li_check = this.getitemnumber(row,'li_check')
	if li_check = 0 then
		this.setitem(row,'li_check',1)
		if dw_3.getitemstring(1,'grupo') = '' or isnull(dw_3.getitemstring(1,'grupo')) then
			dw_3.setitem(1,'grupo',this.getitemstring(row,'agru_descripcion_grupo'))
		end if
	else
		this.setitem(row,'li_check',0)
		dw_3.setitem(1,'grupo','')
	end if
else
//	ls_text = this.getitemstring(row,'agru_descripcion_grupo')
//	if isnull(ls_text) then
//		for i = 1 to this.rowcount()
//			this.setitem(i,'li_check',0)
//			dw_3.setitem(1,'grupo','')
//		next
//		dw_9.accepttext()
//		return 2
//	end if
end if

end event

event itemchanged;this.accepttext()
this.postevent('ue_post_item')
end event

type dw_12 from datawindow within w_rotacion_del_inventario
event ue_post_item ( )
boolean visible = false
integer x = 3570
integer y = 184
integer width = 873
integer height = 956
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "dw_definicion_check"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_post_item();integer i, li_check
string ls_descrip, ls_cadena_descrip
if this.getcolumnname() = 'li_check' then
	if this.getrow() = 1 then
		this.setitem(1,'li_check',0)
		dw_3.setitem(1,'definicion','')			
		return
	else
		if this.getitemnumber(this.getrow(),'li_check') = 1 then
			ls_descrip = dw_3.getitemstring(1,'definicion')
			if ls_descrip = '' or isnull(ls_descrip) then
				dw_3.setitem(1,'definicion',this.getitemstring(this.getrow(),'defp_descripcion'))
			else
				if right(ls_descrip,3) <> '...' then
					dw_3.setitem(1,'definicion',ls_descrip + '...')
				end if
			end if
		else
			ls_descrip = dw_3.getitemstring(1,'definicion')
			if right(ls_descrip,3) = '...' then
				for i = 1 to dw_12.rowcount()
					li_check = this.getitemnumber(i,'li_check')
					if li_check = 1 then
						ls_descrip = this.getitemstring(i,'defp_descripcion')
						if ls_cadena_descrip = '' then
							ls_cadena_descrip = ls_descrip
						else
							ls_cadena_descrip = ls_cadena_descrip + '...'
							exit
						end if
					end if
				next
				dw_3.setitem(1,'definicion',ls_cadena_descrip)
			else
				dw_3.setitem(1,'definicion','')
			end if
		end if

	end if
end if
end event

event itemchanged;this.accepttext()

this.postevent('ue_post_item')
end event

event buttonclicked;dw_12.visible = false
end event

event clicked;integer li_check, i
string ls_text, ls_campo
this.accepttext()

dw_7.visible = false
dw_8.visible = false
dw_9.visible = false

if row = 0 then return

if dwo.name = 'defp_descripcion' then
	li_check = this.getitemnumber(row,'li_check')
	if li_check = 0 then
		this.setitem(row,'li_check',1)
		if dw_3.getitemstring(1,'definicion') = '' or isnull(dw_3.getitemstring(1,'definicion')) then
			dw_3.setitem(1,'definicion',this.getitemstring(row,'defp_descripcion'))
		end if
	else
		this.setitem(row,'li_check',0)
		dw_3.setitem(1,'definicion','')
	end if
else
	ls_text = this.getitemstring(row,'defp_descripcion')
	if isnull(ls_text) then
		for i = 1 to this.rowcount()
			this.setitem(i,'li_check',0)
			dw_3.setitem(1,'definicion','')
		next
		dw_12.accepttext()
		return 2
	end if
end if

end event

type dw_13 from datawindow within w_rotacion_del_inventario
event ue_post_item ( )
boolean visible = false
integer x = 3570
integer y = 268
integer width = 873
integer height = 844
integer taborder = 21
boolean bringtotop = true
string title = "none"
string dataobject = "dw_compradores_check"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_post_item();integer i, li_check
string ls_descrip, ls_cadena_descrip
if this.getcolumnname() = 'li_check' then
	if this.getrow() = 1 then
		this.setitem(1,'li_check',0)
		dw_3.setitem(1,'comprador','')			
		return
	else
		if this.getitemnumber(this.getrow(),'li_check') = 1 then
			ls_descrip = dw_3.getitemstring(1,'comprador')
			if ls_descrip = '' or isnull(ls_descrip) then
				dw_3.setitem(1,'comprador',this.getitemstring(this.getrow(),'nombre'))
			else
				if right(ls_descrip,3) <> '...' then
					dw_3.setitem(1,'comprador',ls_descrip + '...')
				end if
			end if
		else
			ls_descrip = dw_3.getitemstring(1,'comprador')
			if right(ls_descrip,3) = '...' then
				for i = 1 to dw_13.rowcount()
					li_check = this.getitemnumber(i,'li_check')
					if li_check = 1 then
						ls_descrip = this.getitemstring(i,'nombre')
						if ls_cadena_descrip = '' then
							ls_cadena_descrip = ls_descrip
						else
							ls_cadena_descrip = ls_cadena_descrip + '...'
							exit
						end if
					end if
				next
				dw_3.setitem(1,'comprador',ls_cadena_descrip)
			else
				dw_3.setitem(1,'comprador','')
			end if
		end if

	end if
end if
end event

event itemchanged;this.accepttext()

this.postevent('ue_post_item')
end event

event clicked;integer li_check, i
string ls_text, ls_campo
this.accepttext()

dw_7.visible = false
dw_8.visible = false
dw_9.visible = false

if row = 0 then return

if dwo.name = 'nombre' then
	li_check = this.getitemnumber(row,'li_check')
	if li_check = 0 then
		this.setitem(row,'li_check',1)
		if dw_3.getitemstring(1,'comprador') = '' or isnull(dw_3.getitemstring(1,'comprador')) then
			dw_3.setitem(1,'definicion',this.getitemstring(row,'nombre'))
		end if
	else
		this.setitem(row,'li_check',0)
		dw_3.setitem(1,'comprador','')
	end if
else
	ls_text = this.getitemstring(row,'nombre')
	if isnull(ls_text) then
		for i = 1 to this.rowcount()
			this.setitem(i,'li_check',0)
			dw_3.setitem(1,'comprador','')
		next
		dw_13.accepttext()
		return 2
	end if
end if

end event

event buttonclicked;dw_13.visible = false
end event

type cb_1 from commandbutton within w_rotacion_del_inventario
integer x = 3090
integer y = 48
integer width = 361
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;date ldt_desde, ldt_hasta
integer i, li_entero
string ls_producto, ls_cadena, ls_cadena_where, ls_fecha_periodo, ls_sql
decimal{2} ld_promedio, ld_margen
date		ld_fecha, ld_fechaum

ldt_desde = date(em_desde.text)
ldt_hasta = date(em_hasta.text)
dw_3.accepttext()
wf_ocultar_dws(0)
dw_1.settransobject(sqlca)
SetPointer(HourGlass!)
yield()


	ld_fecha   = date(gf_fecha_serv())
	ld_fechaum = relativedate(ld_fecha,1)

		/* Procedimiento especial para recuperar por trimestre informacion  de ventas */
		sqlca.autocommit =  true 
		string sql_execute
		integer  li_mes, li_mesann, li_mes_real,li_ann_real
		long ll_meses [12,2]
		date     ld_fechas
		
		ld_fechas = date(gf_fecha_serv())
		li_mes_real = month(ld_fechas)
		li_ann_real = year(ld_fechas)
		 
		for li_mes = 12  to 1 step  -1
			 ll_meses[li_mes,1] = li_ann_real * 100 + li_mes_real
			 ll_meses[li_mes,2] =  li_mes_real
			 li_mes_real =  	 li_mes_real - 1 
			 if li_mes_real < 1 then 
				li_ann_real = li_ann_real - 1 
				li_mes_real = 12 
			 end if 
		next 
		
		
		delete from inhprome where inhprome.prom_maquina =  'IRI'+ :str.maquina  ; 
		
		sql_execute = "  INSERT INTO inhprome  " + &
		"         ( prom_g_financiero,     " + &
		"           prom_empresa,     " + &
		"          prom_maquina,     " + &
		"           prom_producto,     " + &
		"           prom_fecha,     " + &
		"           prom_bodega,     " + &
		"           prom_ubicacion,        " + &
		"           prom_trim_i,     " + &
		"           prom_trim_ii,     " + &
		"           prom_trim_iii,     " + &
		"           prom_trim_vi )    " + &
		"  SELECT    indmovim.dmov_g_financiero,     " + &
		"                 indmovim.dmov_empresa,     " + &
		"   'IRI"  + str.maquina + "', " + & 
		"         indmovim.dmov_producto, " + & 
		" getdate(),'','', " + & 
		"         sum (case  when datepart(yy,intmovim.tmov_fecha) * 100 + datepart(mm,intmovim.tmov_fecha) >=  " + string (ll_meses[1,1]) + " and datepart(yy,intmovim.tmov_fecha) * 100 + datepart(mm,intmovim.tmov_fecha)  <= " + string (ll_meses[3,1]) + "  then ( indmovim.dmov_cantidad *  inamedid.medi_cantidad ) +  indmovim.dmov_cant1  else 0 end),   " + &
		"         sum(case  when datepart(yy,intmovim.tmov_fecha) * 100 + datepart(mm,intmovim.tmov_fecha) >=  " + string (ll_meses[4,1]) + "  and datepart(yy,intmovim.tmov_fecha) * 100 + datepart(mm,intmovim.tmov_fecha)  <= " + string (ll_meses[6,1]) + "  then ( indmovim.dmov_cantidad *  inamedid.medi_cantidad ) +  indmovim.dmov_cant1 else 0 end),   " + &
		"         sum(case  when datepart(yy,intmovim.tmov_fecha) * 100 + datepart(mm,intmovim.tmov_fecha) >=  " + string (ll_meses[7,1]) + "  and datepart(yy,intmovim.tmov_fecha) * 100 + datepart(mm,intmovim.tmov_fecha)  <= " + string (ll_meses[9,1]) + "  then ( indmovim.dmov_cantidad *  inamedid.medi_cantidad ) +  indmovim.dmov_cant1 else 0 end),   " + &
		"         sum(case  when datepart(yy,intmovim.tmov_fecha) * 100 + datepart(mm,intmovim.tmov_fecha) >=  " + string (ll_meses[10,1]) + "  and datepart(yy,intmovim.tmov_fecha) * 100 + datepart(mm,intmovim.tmov_fecha)  <= " + string (ll_meses[12,1]) + "  then ( indmovim.dmov_cantidad *  inamedid.medi_cantidad ) +  indmovim.dmov_cant1  else 0 end) " + &
		"    FROM intmovim,   " + &
		"        indmovim,  " + &
		"         inamedid  , inmprodu " + &
		"   WHERE ( indmovim.dmov_g_financiero = intmovim.tmov_g_financiero ) and  " + &
		"        ( indmovim.dmov_empresa = intmovim.tmov_empresa ) and  " + &
		"         ( indmovim.dmov_aplicacion = intmovim.tmov_aplicacion ) and  " + &
		"         ( indmovim.dmov_tipo_transaccion = intmovim.tmov_tipo_transaccion ) and  " + &
		 "        ( indmovim.dmov_secuencia = intmovim.tmov_secuencia ) and  " + &
		 "        ( indmovim.dmov_anual = intmovim.tmov_anual ) and  " + &
		 "        ( indmovim.dmov_concepto = intmovim.tmov_concepto ) and  " + &
		 "        ( inamedid.medi_medida = indmovim.dmov_unidad_medida ) and  " + & 
		"		( indmovim.dmov_g_financiero = inmprodu.prod_g_financiero ) and " + &  
		"         ( indmovim.dmov_empresa = inmprodu.prod_empresa ) and  " + &
		"        ( indmovim.dmov_producto  = inmprodu.prod_producto ) and  " + &
		"         ( ( intmovim.tmov_g_financiero = "+string(str.g_financiero)+ " ) AND " + &  
		"         ( intmovim.tmov_empresa = "+string(str.empresa)+" ) AND " + &
		"         ( intmovim.tmov_tipo_transaccion in ('SA','FA') ) AND  " + &
		"         ( datepart(yy,intmovim.tmov_fecha) * 100 + datepart(mm,intmovim.tmov_fecha)  >= " + string (ll_meses[1,1]) + " ) AND  " + &
		"         ( datepart(yy,intmovim.tmov_fecha) * 100 + datepart(mm,intmovim.tmov_fecha)  <=  "+ string (ll_meses[12,1]) + " ) )  " 
		
		
		sql_execute = sql_execute + ls_cadena + '  ' + &
		" GROUP BY indmovim.dmov_g_financiero,   "+ &
		"        indmovim.dmov_empresa,   "+ &
		"         indmovim.dmov_producto  "+ &
		" ORDER BY indmovim.dmov_g_financiero asc,   "+ &
		"         indmovim.dmov_empresa asc ,   "+ &
		"        indmovim.dmov_producto   asc  "

		
		execute immediate :sql_execute ; 
		
		ls_fecha_periodo = left(gf_dg_mes(ll_meses[1,2]),3)+'-'+left(gf_dg_mes(ll_meses[3,2]),3)
		ls_fecha_periodo = ls_fecha_periodo + left(gf_dg_mes(ll_meses[4,2]),3)+'-'+left(gf_dg_mes(ll_meses[6,2]),3)
		ls_fecha_periodo =  ls_fecha_periodo + left(gf_dg_mes(ll_meses[7,2]),3)+'-'+left(gf_dg_mes(ll_meses[9,2]),3)
		ls_fecha_periodo =  ls_fecha_periodo + left(gf_dg_mes(ll_meses[10,2]),3)+'-'+left(gf_dg_mes(ll_meses[12,2]),3)
			
		ls_cadena_where = " AND ("+"inmprodu.prod_g_financiero = " + string(str.g_financiero)+") AND "  &
											+ "(inmprodu.prod_empresa = " + string(str.empresa) + ")  and " & 
											+ "(inhprome.prom_maquina = 'IRI" +(str.maquina) + "')  " & 
											+ ls_cadena

	dw_1.object.meses_4.expression = "'"+mid(ls_fecha_periodo,1,7)+"'"
	dw_1.object.meses_3.expression = "'"+mid(ls_fecha_periodo,8,7)+"'"
	dw_1.object.meses_2.expression = "'"+mid(ls_fecha_periodo,15,7)+"'"
	dw_1.object.meses_1.expression = "'"+mid(ls_fecha_periodo,22,7)+"'"

	If dw_1.describe("nom_empresa.x") <> "?" And dw_1.describe("nom_empresa.x") <> "!" Then	
		dw_1.object.nom_empresa.expression = "'" + str.nombre_empresa +"'"					
	end if

	ls_sql = dw_1.GetSqlSelect()

	ls_sql = ls_sql + ls_cadena_where

	dw_1.SetSqlSelect(ls_sql)

	if dw_1.retrieve() > 0 then
		//Asigna el grupo 1
		if is_campo1 <> '' and not isnull(is_campo1) then
	 	    //dw_1.Modify("cf_group1.expression='cramarca_amar_nombre_marca' ")
		    dw_1.Modify("cf_group1.expression='"+is_campo1+"' ")
		    dw_1.setsort(is_campo1+', inmprodu_prod_descripcion')
		    dw_1.Modify ("DataWindow.Header.1.Height = 108") 
		    dw_1.Modify ("DataWindow.Trailer.1.Height = 96") 
		else
		    dw_1.Modify ("DataWindow.Header.1.Height = 0") 
		    dw_1.Modify ("DataWindow.Trailer.1.Height = 0")
			dw_1.setsort('inmprodu_prod_descripcion') 
		end if
		li_mes = month(date(gf_fecha_serv()))
		dw_1.object.mes_servidor.expression = string(li_mes)
		dw_1.object.DataWindow.zoom = 98		
	end if

li_entero = dw_3.getitemnumber(1,'disponible')
if li_entero = 0 then
	is_cadena = "disponible <= "+string(li_entero)
	if dw_3.getitemnumber(1,'incluir') = 1 then
		is_cadena = ''
	end if
else
	is_cadena = "disponible >= "+string(li_entero)
end if
dw_1.setfilter( is_cadena)
dw_1.filter()
dw_1.sort()
dw_1.groupcalc()

SetPointer(Arrow!)
dw_1.setfocus()


end event

type cb_salir from commandbutton within w_rotacion_del_inventario
integer x = 3506
integer y = 44
integer width = 325
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;close(parent)
end event

