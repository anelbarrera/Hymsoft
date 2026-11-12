//objectcomments  
forward
global type w_fa_man_packing_list_x from w_fa_padre_tab
end type
type ole_1 from olecontrol within tabpage_1
end type
type dw_4 from datawindow within tabpage_1
end type
type ole_3 from olecontrol within tabpage_1
end type
type ole_5 from olecontrol within tabpage_1
end type
type ole_4 from olecontrol within tabpage_1
end type
type gb_2 from groupbox within tabpage_2
end type
type dw_6 from datawindow within tabpage_2
end type
type dw_7 from datawindow within tabpage_2
end type
type cb_2 from commandbutton within tabpage_2
end type
type dw_5 from datawindow within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type st_3 from statictext within tabpage_2
end type
type st_4 from statictext within tabpage_2
end type
type gb_3 from groupbox within tabpage_3
end type
type cbx_imprime_monto from checkbox within tabpage_3
end type
type dw_8 from datawindow within tabpage_3
end type
type st_1 from statictext within w_fa_man_packing_list_x
end type
type cb_1 from commandbutton within w_fa_man_packing_list_x
end type
type st_microhelp from statictext within w_fa_man_packing_list_x
end type
type ole_2 from olecustomcontrol within w_fa_man_packing_list_x
end type
end forward

global type w_fa_man_packing_list_x from w_fa_padre_tab
integer width = 2839
integer height = 1864
string title = "Mantenimiento de las Listas de Empaque"
string menuname = "m_fa_principal"
boolean maxbox = false
boolean resizable = false
event ue_busqueda ( )
st_1 st_1
cb_1 cb_1
st_microhelp st_microhelp
ole_2 ole_2
end type
global w_fa_man_packing_list_x w_fa_man_packing_list_x

type variables
/*Fuente del Packing, FA o PE*/
string is_fuente, is_pedido, is_empaque, is_cliente,is_viene_de, &
         is_empa_det, is_unidad_cubicaje, is_col, is_cod_prod, &
         is_campo_asignada, is_tipo, is_win9598_winnt, is_producto,&
			is_ultima_, is_orden_
			
Long    il_ann, il_ann_empa, il_ann_det,  il_fraccion
Integer ii_linea = 0, il_row
Decimal	il_canti,id_canti
Boolean ib_cambio = false, ib_adicionar = false, &
              ib_modificado = false, ib_desde_ayuda = false
DatawindowChild dwc_recolec, dwc_empa, dwc_despa,&
                            dwc_jefes, dwc_autoriza
str_fa_cubicaje            str_cubicaje
str_fa_pedi_empaque  str_empaque
str_fa_desglose   str_desglose 
str_fa_detalles   str_datos

str_fa_carg_ped str_pedi

u_external_function   iu_externa


end variables

forward prototypes
public subroutine wf_botones ()
public function string wf_extraer_pedido (string ls_syntax)
public function long wf_extraer_ann (string ls_syntax)
public function long wf_extraer_ano_empa (string ls_syntax)
public function string wf_extraer_no_empaque (string ls_syntax)
public function integer wf_actualizar_secuencia ()
public function string wf_extraer_cliente (string ls_syntax)
public subroutine wf_modificar_barra ()
public subroutine wf_declara_child (datawindow ldw_1)
public function string wf_extraer_cliente_new (string ls_syntax)
public function integer wf_valida_cambios ()
public function string wf_extraer_pedido_old (string ls_syntax)
public subroutine wf_setear_descripciones (long al_rows)
public subroutine wf_sube_o_baja (string as_direccion)
public subroutine wf_habilita_tabs (string as_habilita)
public function integer wf_valida_desglose (long al_linea)
public function string wf_titulo_desglose (datawindow adw_dw1, long al_row)
public function string wf_extraer_pormayor (string ls_syntax)
public function integer wf_salvar_desglose (datawindow adw_dw4)
public subroutine wf_setea_campo_desglose (datawindow adw_dw1, datawindow adw_dw6, integer ai_linea_original, integer ai_linea_setear)
public subroutine wf_desglose_packing ()
public subroutine wf_setea_grupo_empresa (integer ai_fila, datawindow adw_object, string as_tabla)
public function string wf_buscar_secuencia ()
public subroutine wf_scroll_a_disponibles (datawindow aldw_5, string as_producto, long al_linea)
public function boolean wf_selec_printer (datawindow adw)
public subroutine wf_avance (long al_avance, long al_total)
public subroutine wf_eliminar_detalle (long ai_linea, long ai_getrow, ref boolean ab_borro)
public function integer wf_reestaurar_cant_eliminadas (datawindow adw_dw1, long al_linea)
public function long wf_convert_min (string as_med, decimal al_cantidad, long al_fraccion)
public function integer wf_blanquea_registro (datawindow adw_dw2, long al_row)
public subroutine wf_setea_dw_disponibles ()
public subroutine wf_convert_uni (string as_med, decimal al_fracciones, ref decimal al_cantidad, ref long al_fraccion)
public function integer wf_convierte_a_unidades (datawindow adw_dw, integer ai_row, string as_unidad, decimal al_asignada, decimal al_disponible)
public subroutine wf_disponible ()
public subroutine wf_setear_lineas_y_cantidades (datawindow adw_dw2)
public subroutine wf_setear_status (decimal ad_emtel_cantidad, decimal ad_fade_cantidad, integer ai_linea_ref, integer ai_getrow_dw_2, integer ai_linea_original, integer ai_getrow_dw_6, ref decimal ad_asignadas)
public subroutine wf_setear_cod_prod (string as_codigo, integer ai_linea, decimal ad_cantidad)
public subroutine wf_recalcula_cubicaje (string ass_producto, decimal asl_total, ref decimal asl_peso, ref decimal asl_cubicaje)
public subroutine wf_salvar_detalle (long ai_linea, long ai_getrow, ref boolean ab_borro, decimal ad_cant_original)
public function integer wf_validar_cantidad (datawindow adw_dw1, integer al_linea, string as_vienede)
public subroutine wf_recuperar_packing ()
public subroutine wf_setear_iniciales (datawindow ldw_1)
public subroutine wf_pasar_todos ()
public subroutine wf_setear_cubic (double ad_largo, double ad_alto, double ad_ancho, double ad_cubicaje, string as_unidad_comp)
public subroutine wf_buscar_total_asignadas (integer ai_linea_referencia, integer ai_linea_original, ref decimal ad_aisgnadas, ref decimal ad_asinado_linea, long ai_sqlcode)
public subroutine wf_imprime_vendedor ()
end prototypes

event ue_busqueda;//Scrip para buscar los pedidos o las Facturas
tab_1.tabpage_1.dw_1.Triggerevent("ue_busqueda")
end event

public subroutine wf_botones ();//Para Habilitar o Deshabilitar Botones
//Llamada desde: ue_postopen, selectionchanged del Tabpage

/*Busqueda*/
m_fa_principal.m_edicin.m_busqueda.toolbaritemvisible=true
m_fa_principal.m_edicin.m_busqueda.visible=true
m_fa_principal.m_edicin.m_busqueda.enabled=true

/*Ordenado*/
m_fa_principal.m_edicin.m_sortear.toolbaritemvisible=false
m_fa_principal.m_edicin.m_sortear.visible=false

/*Insertado*/
m_fa_principal.m_edicin.m_insertar.toolbaritemvisible=false
m_fa_principal.m_edicin.m_insertar.visible=false

/*Filtrado*/
m_fa_principal.m_edicin.m_filtrar.toolbaritemvisible=false
m_fa_principal.m_edicin.m_filtrar.visible=false

/*Primer Reg*/
m_fa_principal.m_edicin.m_primerregistro.toolbaritemvisible=false
m_fa_principal.m_edicin.m_primerregistro.visible=false

/*Ultimo Reg*/
m_fa_principal.m_edicin.m_ultimoregistro.toolbaritemvisible=false
m_fa_principal.m_edicin.m_ultimoregistro.visible=false

/*Sig Reg*/
m_fa_principal.m_edicin.m_siguienteregistro.toolbaritemvisible=false
m_fa_principal.m_edicin.m_siguienteregistro.visible=false

/*Reg Ant*/
m_fa_principal.m_edicin.m_registroanterior.toolbaritemvisible=false
m_fa_principal.m_edicin.m_registroanterior.visible=false

end subroutine

public function string wf_extraer_pedido (string ls_syntax);//Extrae el Numero de Pedido de la Cadena
//Llamada desde: ue_adicionar
string  ls_pedido
Integer li_pos, li_pos2

	li_pos    = Pos(ls_syntax, "'", 1)
	li_pos2   = Pos(ls_syntax, "'",li_pos + 1)
	ls_pedido = Mid(ls_syntax,li_pos + 1, li_pos2 - li_pos - 1) 

return ls_pedido
end function

public function long wf_extraer_ann (string ls_syntax);//Llamada desde: ue_adicionar, ue_busqueda

//Extrae el Año de la Cadena
long ll_ann
	
	ll_ann = long(Right(ls_syntax, 5))

return ll_ann
end function

public function long wf_extraer_ano_empa (string ls_syntax);//Extrae el Año de la Lista de Empaque, de la Cadena
//Llamada desde: ue_busqueda

Integer  li_pos
long     ll_ann_empa

	li_pos 		= pos(ls_syntax,"fatempaq_enca_ann = ",1)
	ll_ann_empa = integer ( mid(ls_syntax,li_pos + 20, 4 ) )
return ll_ann_empa
end function

public function string wf_extraer_no_empaque (string ls_syntax);//Llamada desde: ue_busqueda
//Extrae el Numero de Lista de Empaque
string  ls_empaque
Integer li_pos, li_pos2

	li_pos     = Pos(ls_syntax, "fatempaq_enca_lista_empaque = '", 1)
	li_pos2    = Pos(ls_syntax, "'",li_pos + 31)
	ls_empaque = Mid(ls_syntax,li_pos + 31, li_pos2 - (li_pos + 31))
	
return ls_empaque

end function

public function integer wf_actualizar_secuencia ();//Actualiza la Secuencia de Parametros
//Llamada desde: ue_aceptar

  UPDATE faaparam  
     SET fara_secuencia_packing = :is_empaque
   WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
         ( faaparam.fara_empresa = :str.empresa )   ;
			
	if sqlca.sqlcode = -1 then
		gf_mensaje("","Error al Actualizar la Secuencia "+sqlca.sqlerrtext,1,1,"E")
		return -1
	end if

return 1
end function

public function string wf_extraer_cliente (string ls_syntax);//Extrae el Codigo y nombre del cliente y Concatenar
//Llamada desde: ue_adicionar, ue_busqueda

string  ls_cliente, ls_tempo
integer li_pos, li_pos2

	li_pos     = Pos(ls_syntax, "dgmterce_terc_descripcion = '", 1)
	li_pos2    = Pos(ls_syntax, "'",li_pos + 29)
	ls_cliente = Mid(ls_syntax,li_pos + 29, li_pos2 - (li_pos + 29))		
	
	li_pos     = Pos(ls_syntax, "dgmterce_terc_tercero = ", 1)
	li_pos2	  = Pos(ls_syntax, "And fatpedid_pedi_ann",li_pos + 24)
	ls_tempo   = mid(ls_syntax, li_pos + 24, li_pos2 - (li_pos + 24))

//	messagebox("Cliente",ls_tempo +"  "+ls_cliente)

return ls_tempo+"  "+ls_cliente
end function

public subroutine wf_modificar_barra ();//Verifica los Estatus de la Lista de Empaque y Setea la barra
//Llamada desde : wf_recuperar_packing , ue_postitem, ue_aceptar

string  ls_recolectado, ls_empacado, ls_despachado
long    ll_row
integer li_cont = 1
datawindow ldw_1

ldw_1  = tab_1.tabpage_1.dw_1
ll_row = ldw_1.Getrow()

ls_recolectado = ldw_1.Getitemstring(ll_row,"enca_recolectado")
ls_empacado		= ldw_1.Getitemstring(ll_row,"enca_empacado")
ls_despachado	= ldw_1.Getitemstring(ll_row,"enca_despachado")

if ls_recolectado = "S" then
	li_cont ++
	if ls_empacado = "S" then
		li_cont ++
		if ls_despachado = "S"	then
			li_cont ++
		end if
	end if
end if

wf_avance(li_cont,4) //Marca el Avance en la Barra de Progreso
end subroutine

public subroutine wf_declara_child (datawindow ldw_1);//Llamada desde: ue_postopen

long ll_recupero
//Declaracion de los Child
ldw_1.Getchild("enca_recolector",dwc_recolec)
ldw_1.Getchild("enca_empacador",dwc_empa)
ldw_1.Getchild("enca_despachador",dwc_despa)
ldw_1.Getchild("enca_supervisor",dwc_jefes)
ldw_1.Getchild("enca_autorizado_por",dwc_autoriza)

dwc_recolec.Settransobject(sqlca)
dwc_empa.Settransobject(sqlca)
dwc_despa.Settransobject(sqlca)
dwc_jefes.Settransobject(sqlca)
dwc_autoriza.Settransobject(sqlca)

SELECT count(*)  
 INTO :ll_recupero  
 FROM faempbod  
WHERE ( faempbod.faem_g_financiero = :str.g_financiero ) AND  
		( faempbod.faem_empresa = :str.empresa )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje("","Error al Recuperar los Usuarios",1,1,"E")
		return
	end if

if ll_recupero > 0 then
	dwc_recolec.Retrieve(str.g_financiero, str.empresa)
	dwc_empa.Retrieve(str.g_financiero, str.empresa)
	dwc_despa.Retrieve(str.g_financiero, str.empresa)	
	dwc_jefes.Retrieve(str.g_financiero, str.empresa)		
	dwc_autoriza.Retrieve(str.g_financiero, str.empresa)		
else
	gf_mensaje("","Debe Crear los Usuarios de Bodega, Antes de Continuar.",1,1,"E")
	dwc_recolec.Insertrow(0)
	dwc_empa.Insertrow(0)
	dwc_despa.Insertrow(0)	
	dwc_jefes.Insertrow(0)	
	dwc_autoriza.Insertrow(0)
end if

end subroutine

public function string wf_extraer_cliente_new (string ls_syntax);//Extrae el Codigo y nombre del cliente y Concatenar, Se llama cuando es adicion de una lista
//Llamada desde: ue_busqueda

string  ls_cliente, ls_tempo
integer li_pos, li_pos2

	li_pos     = Pos(ls_syntax, "dgmterce_terc_descripcion = '", 1)
	li_pos2    = Pos(ls_syntax, "'",li_pos + 29)
	ls_cliente = Mid(ls_syntax,li_pos + 29, li_pos2 - (li_pos + 29))		
	
	li_pos     = Pos(ls_syntax, "dgmterce_terc_tercero = ", 1)
	li_pos2    = Pos(ls_syntax, "And ", li_pos + 24)
	ls_tempo   = mid(ls_syntax, li_pos + 24,li_pos2 - (li_pos + 24))
	
//	messagebox("Cliente",ls_tempo +"  "+ls_cliente)
	
return ls_tempo+"  "+ls_cliente
end function

public function integer wf_valida_cambios ();//Override
//Llamada desde: ue_adicionar, ue_busqueda

integer  li_resultado
datawindow ldw_1, ldw_2
ldw_1 = tab_1.tabpage_1.dw_1
ldw_1 = tab_1.tabpage_2.dw_2

dwitemstatus  ls_estatus1, ls_estatus2

If ib_cambio then	
	li_resultado = gf_mensaje("","Desea Salvar La Lista de Empaque Actual ?",4,1,"E")
	choose case li_resultado
		case 1
			this.TriggerEvent("ue_aceptar")
		case 3
			return 1
	end choose	
	ib_cambio = false  //Seteo False a la variable de cambio
end if

return 0
end function

public function string wf_extraer_pedido_old (string ls_syntax);//Extrae el Año del Pedido, de la Cadena
//Llamada desde: ue_busqueda

Integer  li_pos, li_pos2
String   ls_pedido

	li_pos 		= pos(ls_syntax,"_no_pedido = '",1)
	li_pos2		= pos(ls_syntax,"'",li_pos + 14)
	ls_pedido   = ( mid(ls_syntax,li_pos + 14, li_pos2  - (li_pos + 14) ) )
	
//	messagebox("pedido",ls_pedido)
return ls_pedido
end function

public subroutine wf_setear_descripciones (long al_rows);//integer 		i
//String  		ls_producto, ls_descrip, ls_expresion
//long	  		ll_row_total, ll_row
//DataWindow	ldw_2, ldw_4 
//
//ldw_2 = tab_1.tabpage_2.dw_2
//ldw_4 = tab_1.tabpage_1.dw_4
//
//ll_row_total = ldw_4.Rowcount()
//
//For i = 1 to al_rows
//	
//	ls_producto  = ldw_2.GetItemString(i,"empa_codigo_producto")
//	ls_expresion = "codigo_item = '"+trim(ls_producto)+"'"
//	messagebox("Producto a Buscar y expresion ",ls_producto+"  "+ls_expresion)
//	
//	long row
//	string cod
//	cod = ldw_4.GetitemString(1,"codigo_item")
//	messagebox("Codigo del ldw_4",cod)
//	messagebox("Total de lineas ",ll_row_total)
//	
//	
////ldw_4.Rowcount()
//	ll_row		= ldw_4.Find(ls_expresion ,1,ll_row_total)
//	
//	messagebox("Encontrado en : ",ll_row)
//
//	if ll_row > 0 then				
//		ls_descrip	= ldw_4.GetItemString(ll_row,"prod_descripcion")
//		ldw_2.SetItem(i,"descrip",ls_descrip)
//	End if
//	
//Next
end subroutine

public subroutine wf_sube_o_baja (string as_direccion);Long			ll_selected, ll_old_idx, ll_new_idx
Datawindow	ldw_2

ldw_2 	   = tab_1.tabpage_2.dw_2
ldw_2.SetRedraw(False)

ll_selected = ldw_2.Getrow()

IF as_direccion = 'S' THEN						// Arriba
	If ll_selected > 1 Then						// Si es la primera línea no puede subir más
		ll_old_idx = ldw_2.GetItemNumber(ll_selected, "index")
		ll_new_idx = ldw_2.GetItemNumber(ll_selected - 1, "index")
		
		ldw_2.SetItem(ll_selected, "index", ll_new_idx)
		ldw_2.SetItem(ll_selected - 1, "index", ll_old_idx)

		ldw_2.Sort()
		ldw_2.Scrolltorow(ll_selected - 1)		
	End If
ELSEIF as_direccion = 'B' THEN					// Abajo
	If ll_selected < ldw_2.RowCount() Then	// Si es la última línea no puede bajar más	
		ll_old_idx = ldw_2.GetItemNumber(ll_selected, "index")
		ll_new_idx = ldw_2.GetItemNumber(ll_selected + 1, "index")
		
		ldw_2.SetItem(ll_selected, "index", ll_new_idx)
		ldw_2.SetItem(ll_selected + 1, "index", ll_old_idx)		

		ldw_2.Sort()
		ldw_2.Scrolltorow(ll_selected + 1)
	End If
END IF

ldw_2.SetRedraw(True)
end subroutine

public subroutine wf_habilita_tabs (string as_habilita);//Habilita o Deshabilita los Tabs, dependiendo del parámetro enviado
//Llamada desde ue_postopen, ue_aceptar, ue_adicionar, wf_recuperar_packing()

if as_habilita = 'S' then
	tab_1.tabpage_2.enabled = true
	tab_1.tabpage_3.enabled = true		
else
	tab_1.tabpage_2.enabled = false
	tab_1.tabpage_3.enabled = false
end if
end subroutine

public function integer wf_valida_desglose (long al_linea);integer li_recupero

if is_fuente = 'FA' then

  SELECT count(*)  
    INTO :li_recupero  
    FROM fadesgfa  
   WHERE ( fadesgfa.desg_g_financiero = :str.g_financiero ) AND  
         ( fadesgfa.desg_empresa = :str.empresa ) AND  
         ( fadesgfa.desg_tipo = :is_tipo ) AND  
         ( fadesgfa.desg_no_pedido = :is_pedido ) AND  
         ( fadesgfa.desg_anno = :il_ann ) AND  
         ( fadesgfa.desg_linea = :al_linea )   ;
			
//   WHERE ( fadcandi.dcdi_g_financiero = :str.g_financiero ) AND  
//         ( fadcandi.dcdi_empresa = :str.empresa ) AND  
//         ( fadcandi.dcdi_tipo = :is_tipo ) AND  
//         ( fadcandi.dcdi_no_pedido = :is_pedido ) AND  
//         ( fadcandi.dcdi_linea = :al_linea ) AND  
//         ( fadcandi.dcdi_anno = :il_ann )   ;

	if sqlca.sqlcode = -1 then
		gf_mensaje("","Error al Validar Existencia de desglose (FA) "+sqlca.sqlerrtext,1,1,"E")
	end if
	
else	
	
	SELECT count(*)  
    INTO :li_recupero  
    FROM fadesgpe  
   WHERE ( fadesgpe.desg_g_financiero = :str.g_financiero ) AND  
         ( fadesgpe.desg_empresa = :str.empresa ) AND  
         ( fadesgpe.desg_no_pedido = :is_pedido ) AND  
         ( fadesgpe.desg_anno = :il_ann ) AND  
         ( fadesgpe.desg_linea = :al_linea )   ;
			
//   WHERE ( fadcanpe.dcpe_g_financiero = :str.g_financiero ) AND  
//         ( fadcanpe.dcpe_empresa = :str.empresa ) AND  
//         ( fadcanpe.dcpe_no_pedido = :is_pedido ) AND  
//         ( fadcanpe.dcpe_anno =:il_ann  ) AND  
//         ( fadcanpe.dcpe_linea =:al_linea  )   ;

	if sqlca.sqlcode = -1 then
		gf_mensaje("","Error al Validar Existencia de desglose (PE) "+sqlca.sqlerrtext,1,1,"E")
	end if
end if

if li_recupero > 0 then
	return 1
else
	return 0
end if
end function

public function string wf_titulo_desglose (datawindow adw_dw1, long al_row);//Concatena el titulo que aparecerá en la ventana de desglose de productos
//Llamada desde Doubleclicked del dw2

string 	ls_titulo, ls_producto, ls_bodega, ls_ubicacion

ls_producto		=	adw_dw1.getitemstring(al_row,"empa_codigo_producto")
ls_bodega		=	adw_dw1.getitemstring(al_row,"empa_bodega")
ls_ubicacion	=	adw_dw1.getitemstring(al_row,"empa_ubicacion")

ls_titulo		=	"Producto "+ls_producto+" Bodega "+ls_bodega+" Ubicacion "+ls_ubicacion

return ls_titulo
end function

public function string wf_extraer_pormayor (string ls_syntax);//Extrae el tipo de la factura, de la Cadena
//Llamada desde: ue_adicionar, ue_busqueda

Integer  li_pormayor, li_pos, li_pos2
String	ls_tipo
	li_pos 		= pos(ls_syntax,"_tipo = '",1)
	li_pos2		= pos(ls_syntax,"'",li_pos + 9)
	ls_tipo =  mid(ls_syntax,li_pos + 9, li_pos2 - (li_pos + 9) )

return ls_tipo
end function

public function integer wf_salvar_desglose (datawindow adw_dw4);//Datawindow ldw_7
//long		ll_row, ll_cantidad, ll_filas
//string	ls_expresion, ls_cod_color, ls_cod_tama, ls_cod_largo, ls_cod_grupo
//integer  i, li_resultado
//
//ldw_7 	= tab_1.tabpage_2.dw_7
//
//ll_filas = adw_dw4.Rowcount()
//
//for i = 1 to ll_filas
//	
//	 ll_cantidad  = adw_dw4.Getitemnumber(i,"fade_cantidad")
//	 ls_cod_color = adw_dw4.Getitemstring(i,"fade_color")
//	 ls_cod_tama  = adw_dw4.Getitemstring(i,"fade_tama")
//	 ls_cod_largo = adw_dw4.Getitemstring(i,"fade_tamb")
//	 ls_cod_grupo = adw_dw4.Getitemstring(i,"fade_grupo_tam")
//	
//	 ls_expresion = "fade_linea = "+string(str_desglose.linea)+" and fade_color = '"+ls_cod_color+"' and fade_tama = '"+ls_cod_tama+"' and "+ &
//	                "fade_tamb = '"+ls_cod_largo+"' and fade_grupo_tam = '"+ls_cod_grupo+"'"
//	 
//	 ll_row = ldw_7.Find(ls_expresion, 1, ldw_7.Rowcount())
//	 
//	 if ll_row > 0 then
//		if ll_cantidad = 0 then
//			ldw_7.deleterow(ll_row)
//			ll_filas --
//			i --
//		else
//			ldw_7.Setitem(ll_row,"fade_cantidad",ll_cantidad)
//		end if
//	 else
//		if ll_cantidad > 0 then
//			 adw_dw4.RowsCopy(i, i, Primary!, ldw_7, 10000, Primary!)
//		end if
//	 end if
//next
//
//li_resultado = ldw_7.Update()
//
return 0
end function

public subroutine wf_setea_campo_desglose (datawindow adw_dw1, datawindow adw_dw6, integer ai_linea_original, integer ai_linea_setear);//string ls_expresion
//long   ll_row
//
//	ls_expresion = "linea = "+string(ai_linea_original)
//	ll_row	= adw_dw6.Find(ls_expresion,1,adw_dw6.Rowcount())
//	if ll_row > 0 then
//		adw_dw1.Setitem(ai_linea_setear,"desglose",1)
//	end if
//
end subroutine

public subroutine wf_desglose_packing ();///*Modify by Hgn used by desglose, called from itenchanged*/
//
//Integer		li_def,li_existe_detalle,li_getrow
//String		ls_producto,ls_prod, ls_error
//Long			ld_cant
//Double		ld_precio
//Boolean		ab_borro = false
//DataWindow	ldw_2,ldw_1
//
//ldw_2 = tab_1.tabpage_2.dw_2
//ldw_1 = tab_1.tabpage_1.dw_1
//
///****************************************************************************************** 
// *	Se Abre la ventana de Desglose																			*
// ******************************************************************************************/
////If dwo.name = "dped_cantidad" Or dwo.name = "dped_fraccion" Then
//If This.GetColumnName() = "facd_cantidad" Or This.GetColumnName() = "facd_cantidad_fraccion" Then
//	AcceptText ()
//
//	ldw_2 = tab_1.tabpage_2.dw_2
//	// Verificando si el Producto está definido como SERIE, DESGLOSE o STANDARD
//	//is_producto = ldw_2.GetItemString (ldw_2.GetRow (), "facd_codigo_item")
//
////	If	is_viene_de ='itemchange' then
////	else
//		il_fraccion = ldw_2.getItemNumber(ldw_2.GetRow (),"facd_cantidad_fraccion")
//		il_canti = ldw_2.getItemNumber(ldw_2.GetRow (),"facd_cantidad")
////	end if
//
//	is_viene_de =''
//	//Valida la definición del producto
//  	li_def = gf_fa_definicion_prod (is_producto)
//	
//	If li_def = -1 then return
//
//	// Acciones
//	CHOOSE CASE li_def
//		CASE 0 		// Desglose
//			
//			// The construction began in november 25, 1999 at 2:00 p.m.
//
//			ldw_1.AcceptText()
//			ldw_2.AcceptText()
//			ld_cant   =  ldw_2.GetItemNumber(ldw_2.GetRow(),"facd_cantidad")
//			ls_prod   =  ldw_2.GetItemString(ldw_2.GetRow(),"facd_codigo_item")
//			ld_precio  =  ldw_2.GetItemDecimal(ldw_2.GetRow(),"facd_precio_unidad_producto")
//			If ls_prod  = "" Or &
//				ld_precio = 0.00 Then
//				MessageBox('-----Aviso-----','Verifique existen Datos Nulos',Information!)
//				Return
//			Else	
//			
//			//---------------------****--------------------//
//				SELECT prod_medida,
//						 prod_color,
//						 prod_cod_clase_tam,
//						 prod_descripcion
//				INTO   :str_datos.medida,
//						 :str_datos.cod_color,
//						 :str_datos.cod_clase_tam,
//						 :str_datos.titulo
//				FROM   inmprodu
//				WHERE  (prod_g_financiero =: str.g_financiero) AND
//						 (prod_empresa =: str.empresa) AND
//						 (prod_producto =: is_producto);
//					
//				//---------------------****--------------------//			
//				str_datos.tipo_transaccion = is_tipo
//				str_datos.no_pedido 	= ldw_1.GetItemString(ldw_1.GetRow(),"fact_no_pedido")
//				str_datos.fecha 		= ldw_1.GetItemDateTime(ldw_1.GetRow(),"fact_fecha")
//				str_datos.renglon 	= ldw_2.GetItemNumber(ldw_2.GetRow(), "facd_linea")
//				li_getrow	= ldw_2.GetRow()
//				str_datos.unid_medida 	= ldw_2.GetItemString(ldw_2.GetRow(), "facd_unidad_venta")
//				str_datos.producto 		= is_producto
//
//				str_datos.bodega		= ldw_2.GetItemString(ldw_2.GetRow(), "facd_bodega")
//				str_datos.anio  		= ldw_2.GetItemNumber(ldw_2.GetRow(),"facd_ann")
//				str_datos.ubicacion  = ldw_2.GetItemString(ldw_2.GetRow(),"facd_ubicacion")
//				str_datos.cantidad_max 	= 0
//				str_datos.fraccion_max 	= 0
//				str_datos.tipo_transaccion	= ldw_1.GetItemString(1, "fact_tipo")
//
//				str_datos.titulo = 'Desglose del producto '+str_datos.producto+', bodega '+str_datos.bodega+', ubicación '+str_datos.ubicacion+' ,cod_clase '+str_datos.cod_clase_tam+', Unid Vta '+str_datos.unid_medida
//				str_datos.viene_de = 'factura'
//				ldw_2.SetItem(li_getrow,"facd_cantidad",il_cantidad)
//				ldw_2.SetItem(li_getrow,"facd_cantidad_fraccion",il_fraccion)
//
////				wf_guardar_informacion()
//				
//				If ib_aceptar = True Then
//					str.frame.Setredraw(true)
//				
//					ldw_2.visible = false
//					tab_1.tabpage_2.dw_4.visible = false
//					tab_1.tabpage_2.dw_5.visible = false
//	
//					OpenWithParm(w_fa_ma_desglose,str_datos)
//	
//					ldw_2.visible = true
//					tab_1.tabpage_2.dw_4.visible = true
//					tab_1.tabpage_2.dw_5.visible = true
//
//					str_datos = message.PowerObjectParm
//
//					ldw_2.AcceptText ()
//					ldw_2.SetItem(li_getrow,"facd_cantidad",str_datos.cantidad_max)
//					ldw_2.SetItem(li_getrow,"facd_cantidad_fraccion",str_datos.fraccion_max)
//
////					wf_salvar_detalle(str_datos.renglon, li_getrow, ab_borro)
//
//					ldw_2.ScrollToRow(li_getrow)
//					ldw_2.SetFocus()
//				else
//					ldw_2.SetItem(li_getrow,"facd_cantidad",il_cantidad)
//					ldw_2.SetItem(li_getrow,"facd_cantidad_fraccion",il_fraccion)
//				End If
//			End If
//		CASE 1		// Standard
//		CASE 2		// Serie
//	END CHOOSE
//
//End If
end subroutine

public subroutine wf_setea_grupo_empresa (integer ai_fila, datawindow adw_object, string as_tabla);//Se Setea el grupo y empresa a la tabla que se envió como parametro

adw_object.SetItem(ai_fila,as_tabla+"_g_financiero", str.g_financiero) 
adw_object.SetItem(ai_fila,as_tabla+"_empresa", str.empresa) 
end subroutine

public function string wf_buscar_secuencia ();//Busca la Secuencia y la retorna, para ser Asignada
//Llamada desde: wf_setear_iniciales

string ls_lista = '0',  ls_tempo
long   ll_secuencia, ll_recupero

  SELECT faaparam.fara_secuencia_packing  
    INTO :ls_lista  
    FROM faaparam  
   WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
         ( faaparam.fara_empresa = :str.empresa )   ;
			
	if sqlca.sqlcode = -1 then
		gf_mensaje("","Error al Recuperar la Secuencia de Parametros"+sqlca.sqlerrtext,1,1,"E")
	end if
	
	if ls_lista = "" or isnull(ls_lista) then ls_lista = "0"
	
	ls_lista = string(long(ls_lista)+1)
	
	  SELECT count(*)  
	   INTO :ll_recupero  
   	FROM fatempaq  
	   WHERE ( fatempaq.enca_g_financiero = :str.g_financiero ) AND  
   	      ( fatempaq.enca_empresa = :str.empresa ) AND  
      	   ( fatempaq.enca_lista_empaque = :ls_lista ) AND  
         	( fatempaq.enca_ann = :w_fa_fondo.str_para.ano )   ;
	
		if sqlca.sqlcode = -1 then
			gf_mensaje("","Error al Verificar la Secuencia"+sqlca.sqlerrtext,1,1,"E")
		end if
	
	if ll_recupero > 0 then //Si ya encontro la secuencia, selecciona la máxima
		
		  SELECT max(convert(numeric(5,0),fatempaq.enca_lista_empaque))  
			 INTO :ll_secuencia  
			 FROM fatempaq  
			WHERE ( fatempaq.enca_g_financiero = :str.g_financiero ) AND  
					( fatempaq.enca_empresa = :str.empresa ) AND  
					( fatempaq.enca_ann = :w_fa_fondo.str_para.ano )   ;
			
			if sqlca.sqlcode = -1 then
				gf_mensaje("","Error al Verificar la Secuencia"+sqlca.sqlerrtext,1,1,"E")
			end if

			ls_lista = string(ll_secuencia + 1)
		
	end if

return ls_lista
end function

public subroutine wf_scroll_a_disponibles (datawindow aldw_5, string as_producto, long al_linea);//Dirige el cursor del dw5 al producto actual
//Lamada desde: rowfocuschanged del dw2, ue_postitem

string  ls_expresion
Long    ll_row
Integer li_resultado

if is_fuente = 'PE' then
	ls_expresion = "codigo_item = '"+as_producto+"' and dped_linea = "+string(al_linea)
else
	ls_expresion = "codigo_item = '"+as_producto+"' and facd_linea = "+string(al_linea)
end if

ll_row = aldw_5.Find(ls_expresion,1,aldw_5.Rowcount())

if ll_row > 0 then
	aldw_5.Scrolltorow(ll_row)
else
	gf_mensaje("","No Pudo Encontrar el Producto Actual",1,1,"E")
end if

end subroutine

public function boolean wf_selec_printer (datawindow adw);//**************Función creada por HGN el 01/03/2000********************//

	// Script para identificar el ambiente o el sistema operativo en uso //
	Boolean	lb_acepto
		// abrir ventana de seleccion de modelo de impresora  
	
		OpenwithParm(w_fa_co_selec_modelo_print,str_pedi)
			
		str_pedi = message.PowerObjectParm

		if isvalid(str_pedi) and Not IsNull(str_pedi)  then 
			
			if str_pedi.aceptar = false then 
				return false
			end If
			if Isnull(str_pedi.largo_doc) or str_pedi.largo_doc = 0 or &
				Isnull(str_pedi.ancho_doc) or str_pedi.ancho_doc = 0 then 
				mensaje("Atención ","Debe asignarle los parámetros de largo y ancho del documento ,"+&
				"debe ir a parámetros, Modelos de Impresoras (Factura) y agregar la impresora"+&
				"que va a utilizar y el largo y ancho del documento... gracias !!!","")
				return false
			end If
			If is_win9598_winnt='win9598' then
				gf_dg_tamano_pagina(str_pedi.largo_doc,str_pedi.ancho_doc,adw)
			end If
			
			Return true
		else
			Return false
	end If
//*****************************************************/

end function

public subroutine wf_avance (long al_avance, long al_total);//Marca el Avance en la barra
//Llamada desde: ue_adicionar, wf_modificar_barra()

ole_2.Object.Value = (al_avance / al_total) * 100
end subroutine

public subroutine wf_eliminar_detalle (long ai_linea, long ai_getrow, ref boolean ab_borro);/*Added by Hgn, used by desglose, called from wf_salvar_detalle()*/

// Funcion que elimina el detalle asociado de un registro del detalle de la lista de empaque
String	ls_error
Decimal	ld_cant_total
Integer	li_anio
DataWindow	ldw_2,ldw_1,ldw_6

ldw_6 = tab_1.tabpage_2.dw_6
ldw_2 = tab_1.tabpage_2.dw_2
ldw_1 = tab_1.tabpage_1.dw_1
ldw_2.AcceptText()

str_desglose.empaque = ldw_1.getItemString(1,"enca_lista_empaque")
str_desglose.ann_empa = ldw_1.getItemNumber(1,"enca_ann")

DataStore	ds_delete_desgloce

ds_delete_desgloce = Create datastore

ds_delete_desgloce.DataObject="dw_ma_fa_desglose_packing_lin"
ds_delete_desgloce.SetTransObject(SQLCA)

// Verificación o busqueda del detalle
//DataStore que contiene el detalle reservado por el renglón
ds_delete_desgloce.retrieve(str.g_financiero,str.empresa, & 
				  str_desglose.empaque,str_desglose.ann_empa, ai_linea)
ab_borro = false

If ds_delete_desgloce.rowcount() = 0 then 
	Destroy ds_delete_desgloce	
	ab_borro = true
	return
end if


//Eliminando registro de tabla de desglose pedido
  DELETE FROM fademtel  
   WHERE ( fademtel.fade_g_financiero = :str.g_financiero ) AND  
         ( fademtel.fade_empresa = :str.empresa ) AND  
         ( fademtel.fade_lista_empaque = :str_desglose.empaque ) AND  
         ( fademtel.fade_ann = :str_desglose.ann_empa ) AND  
         ( fademtel.fade_linea_refer = :ai_linea );

if sqlca.sqlcode = -1 then
	ls_error = sqlca.sqlerrtext
	ab_borro = false
	rollback;
	mensaje("Atención ","Error al Eliminar registro del detalle de la lista emp << fademtel >>",ls_error)
	Destroy ds_delete_desgloce
	return
end if
ab_borro = true

Destroy ds_delete_desgloce
end subroutine

public function integer wf_reestaurar_cant_eliminadas (datawindow adw_dw1, long al_linea);//Funciòn que Reestaura Cantidad Que se Introdujo que se esta eliminando
//Llamada desde: ue_eliminar, 

Decimal     ld_cantidad, ll_fraccion, ld_total, ld_disponible, ld_asignada
Integer     li_linea, li_row
String		ls_producto, ls_unidad, ls_expresion
DataWindow  ldw_4
ldw_4			= tab_1.tabpage_1.dw_4

	ld_cantidad	 		=  adw_dw1.GetItemNumber(al_linea, "empa_canti")
	ll_fraccion	 		=	adw_dw1.GetItemNumber(al_linea, "empa_fraccion")
	ls_unidad    		=  adw_dw1.Getitemstring(al_linea, "empa_unidad")
//	ld_total				=  wf_convert_min(ls_unidad,ld_cantidad, ll_fraccion)
	ld_total				=  ld_cantidad
	ls_producto  		=  adw_dw1.Getitemstring(al_linea, "empa_codigo_producto")
	if ls_producto = '' or isnull(ls_producto) then
		return 1
	end if
	li_linea		 		=  adw_dw1.GetitemNumber(al_linea, "empa_linea_original")
	if is_fuente = 'PE' then
		ls_expresion 		=  "codigo_item = '"+ls_producto+"' and dped_linea = "+string(li_linea)
	else
		ls_expresion 		=  "codigo_item = '"+ls_producto+"' and facd_linea = "+string(li_linea)
	end if
	li_row		 		=  ldw_4.Find(ls_expresion,1,ldw_4.Rowcount())
	
	if li_row > 0 then  //Si encuentra el Articulo en el dw4 Pedido
	
		ld_disponible = ldw_4.Getitemnumber(li_row, "cant_disponible")
		ld_asignada	  = ldw_4.Getitemnumber(li_row, is_campo_asignada)		
					
		ldw_4.Setitem(li_row, "cant_disponible", ld_disponible + ld_total)
		ldw_4.Setitem(li_row, is_campo_asignada, ld_asignada - ld_total)

		//Distribuye lo disponible y lo asignado en Cantidad y Fraccion
		wf_convierte_a_unidades(ldw_4,li_row,ls_unidad,ld_asignada - ld_total,ld_disponible + ld_total)
									
	else
		gf_mensaje("","No Pudo Reestaurar la Cantidad Eliminada, Verifique.",1,1,"E")
		return -1
	end if
	
return 1
end function

public function long wf_convert_min (string as_med, decimal al_cantidad, long al_fraccion);/*Esta función recibe la cantidad y fracción y retorna todo convertido a fracción*/
//Llamada desde: retrieveend del DW 4, wf_validar_cantidad()

Decimal ld_ucom, ld_mconvera, ld_unidmin

/*Extrae la Unidad comun "Pedo/Unidades/etc "*/
ld_ucom = gf_fa_medi_prod(as_med)

/*Retorna el Factor de Converción a unidades minimas*/
ld_mconvera = gf_fa_unidad_venta(as_med, ld_ucom)

If ld_mconvera <= 0 Then ld_mconvera = 1

ld_unidmin = round((al_cantidad * ld_mconvera),2) //+ al_fraccion

Return (ld_unidmin)
end function

public function integer wf_blanquea_registro (datawindow adw_dw2, long al_row);//Blanquea el Registro Del Detalle
integer		li_resultado = 2, li_linea
Long			ll_fraccion, ll_row
String		ls_unidad, ls_producto, ls_expresion
Decimal		ld_cantidad, ld_total, ld_disponible, ld_asignada
Datawindow	ldw_4
ldw_4			=	tab_1.tabpage_1.dw_4

if adw_dw2.GetitemNumber(al_row,"validado") = 1 then
	
	li_resultado = gf_mensaje("","El Registro Modificado, Será Eliminado, Está Seguro ?",2,2,"E")
	
	if li_resultado = 1 then
		
		//Extrae la Cantidad que tenia asociada, y la reestaura en dw4
		ls_unidad	= adw_dw2.GetitemString(al_row,"empa_unidad")		
		ld_cantidad = adw_dw2.GetitemNumber(al_row,"empa_canti")		
		ld_total		= ld_cantidad
		li_linea		= adw_dw2.GetitemNumber(al_row,"empa_linea_original")
		ls_producto = adw_dw2.GetitemString(al_row,"empa_codigo_producto")		
		
		//Find al dw_4 para reestaurar la cantidad
		//is_cod_prod es cargado en el itemfocuschanged y en wf_setear_cod_prod, 
		//siempre y cuando exista en DW4 Pedidos
		if is_fuente = 'PE' then
			ls_expresion= "codigo_item = '"+is_cod_prod+"' and dped_linea = "+string(li_linea)
		else
			ls_expresion= "codigo_item = '"+is_cod_prod+"' and facd_linea = "+string(li_linea)
		end if
	
		ll_row = ldw_4.Find(ls_expresion,1,ldw_4.Rowcount())

		if ll_row > 0 then
			ld_disponible = ldw_4.Getitemnumber(ll_row, "cant_disponible")
			ld_asignada	  = ldw_4.Getitemnumber(ll_row, is_campo_asignada)		
			ldw_4.Setitem(ll_row, "cant_disponible", ld_disponible + ld_total)
			ldw_4.Setitem(ll_row, is_campo_asignada, ld_asignada - ld_total)
			
			//Distribuye lo disponible y lo asignado en Cantidad y Fraccion
			wf_convierte_a_unidades(ldw_4,ll_row,ls_unidad,ld_asignada - ld_total,ld_disponible + ld_total)							
			
		else
			gf_mensaje("","No se Pudo Encontrar el Articulo, para Reestaurar la Cantidad.",1,1,"E")
		end if
		
		adw_dw2.SetItem(al_row,"empa_bodega","")
		adw_dw2.SetItem(al_row,"empa_ubicacion","")
		adw_dw2.SetItem(al_row,"empa_cubicaje",0)
		adw_dw2.SetItem(al_row,"empa_peso",0)				
		adw_dw2.SetItem(al_row,"empa_unidad_peso","")
		adw_dw2.SetItem(al_row,"prod_descripcion","")
		adw_dw2.SetItem(al_row,"empa_unidad","")
		adw_dw2.SetItem(al_row,"empa_canti",0)
		adw_dw2.SetItem(al_row,"empa_fraccion",0)
		adw_dw2.SetItem(al_row,"empa_linea_original",0)			
		
		/////////////////////////Eliminacion
			idw_proximo.deleterow(al_row)		
			
			wf_setear_lineas_y_cantidades(adw_dw2)  //Para setear lineas
			
			if idw_proximo.Update() <> -1 then
				commit ;								
			else
				rollback ;
				gf_mensaje("","Error al Actualizar Eliminación "+sqlca.sqlerrtext,1,1,"E")
			
				//Si adicionó, que setee la barra en 0 %
				ole_2.object.value = 0
						
			end if
			
			this.Triggerevent("ue_adicionar")
		/////////////////////////
		
	else
		//Reestaurar el Codigo Original
		adw_dw2.SetItem(al_row,"empa_codigo_producto",is_cod_prod) //is_cod_prod es cargada
																				  //en el itemfocuschanged del producto
	end if
	
end if		

return li_resultado
end function

public subroutine wf_setea_dw_disponibles ();//Setea el DW de Cantidades Disponibles 
//Llamado desde: wf_recupera_packing(), retrieveend del dw4
Integer   li_resultado=0

Datawindow ldw_4, ldw_5, ldw_6
ldw_4		= tab_1.tabpage_1.dw_4
ldw_5	   = tab_1.tabpage_2.dw_5
ldw_6		= tab_1.tabpage_2.dw_6

if is_fuente = 'PE' then //PEDIDOS
	ldw_5.Dataobject = "dw_ma_fa_pedi_cantidades_packing_tel"
	ldw_5.Settransobject(sqlca)	
	
	ldw_6.Dataobject = "dw_ma_fa_cant_pedi_packing_disp_esp_det"
	ldw_6.Settransobject(sqlca)
//	ldw_5.Retrieve(str.g_financiero, str.empresa, is_pedido, il_ann)
		
else							 //FACTURAS
	ldw_5.Dataobject = "dw_ma_fa_fact_cantidades_packing_tel"
	ldw_5.Settransobject(sqlca)
//	ldw_5.Retrieve(str.g_financiero, str.empresa, is_pedido, il_ann, is_tipo)

	ldw_6.Dataobject = "dw_ma_fa_cant_fact_packing_disp_esp_det"
	ldw_6.Settransobject(sqlca)	

end if

if isvalid(ldw_5) and isvalid(ldw_4) then
	ldw_5.object.data = ldw_4.Object.data
end if


end subroutine

public subroutine wf_convert_uni (string as_med, decimal al_fracciones, ref decimal al_cantidad, ref long al_fraccion);/*Esta Función Convierte de Unidad Minima a la Unidad que se Quiere*/
//Llamada desde: ue_postitem, retrieveend del dw2

Decimal ld_total,ld_ucom, ld_mconvera,ld_frac

 
/*Extrae la Unidad comun "Pedo/Unidades/etc "*/
ld_ucom = gf_medi_prod(as_med)


/*Retorna el Factor de Converción a unidades minimas*/
ld_mconvera = gf_unidad_venta(as_med, ld_ucom)


If ld_mconvera <= 0 Then ld_mconvera = 1

ld_total = ( al_fracciones / ld_mconvera) 

al_cantidad = ld_total
al_fraccion = 0
end subroutine

public function integer wf_convierte_a_unidades (datawindow adw_dw, integer ai_row, string as_unidad, decimal al_asignada, decimal al_disponible);//Para mostrar lo Asignado y lo disponible en Cantidad Fraccion
//Llamado desde: ue_postitem, wf_blanquea_registro(), wf_validar_cantidad(),
//wf_reestaurar_cant_eliminadas(), retrieveend del DW4

Datawindow	ldw_4, ldw_5
Decimal  ld_cant_asig=0,  ld_cant_disp=0
Long		ll_frac_disp=0, ll_frac_asig=0
ldw_4 = tab_1.tabpage_1.dw_4
ldw_5 = tab_1.tabpage_2.dw_5

wf_convert_uni(as_unidad,al_asignada,ld_cant_asig, ll_frac_asig) //Conv. lo Asignado a unidades y pzas

adw_dw.Setitem(ai_row,"cant_asig",ld_cant_asig)	

wf_convert_uni(as_unidad,al_disponible,ld_cant_disp, ll_frac_asig) //Conv. lo disponible a unidades y pzas
adw_dw.Setitem(ai_row,"cant_disp",ld_cant_disp)	


if isvalid(ldw_5) and isvalid(ldw_4) then
	ldw_4.sharedata(ldw_5)
else
	gf_mensaje("","Error en el Data, wf_convierte a unidades()",1,1,"E")
end if
return 1
end function

public subroutine wf_disponible ();Decimal ld_reserva, ld_asig_dped, ld_canti_total, ld_cant_edit


end subroutine

public subroutine wf_setear_lineas_y_cantidades (datawindow adw_dw2);//Se Setea el numero de linea a los Registros del Detalle
//Llamada desde ue_aceptar, wf_blanquea_registro, ue_eliminar
integer i, li_filas
decimal	  ld_cantidad, ll_fraccion, ld_cant_total
string  ls_unidad

li_filas = adw_dw2.Rowcount()

for i = 1 to li_filas
	if adw_dw2.GetitemString(i,"empa_codigo_producto") = '' or isnull(adw_dw2.GetitemString(i,"empa_codigo_producto")) &
		or adw_dw2.Getitemnumber(i,"validado") = 0 then
		adw_dw2.Deleterow(i)
		i -- 					//Como elimine la fila, se decrementa el total y el indice
		li_filas --
	else
		adw_dw2.Setitem(i,"index",i)	//Setea el numero del indice
//		ld_cantidad 	= adw_dw2.GetitemNumber(i,"empa_canti")
		adw_dw2.SetItem(i,"empa_cantidad",adw_dw2.GetitemNumber(i,"empa_canti"))
	end if
next
end subroutine

public subroutine wf_setear_status (decimal ad_emtel_cantidad, decimal ad_fade_cantidad, integer ai_linea_ref, integer ai_getrow_dw_2, integer ai_linea_original, integer ai_getrow_dw_6, ref decimal ad_asignadas);Decimal	ld_cant_capturada
Datawindow ldw_2
ldw_2 = tab_1.tabpage_2.dw_2

ld_cant_capturada = ldw_2.GetItemNumber(ai_getrow_dw_2,"empa_canti")

If IsNull(ld_cant_capturada) then ld_cant_capturada =0
												// disponible
IF ad_emtel_cantidad >= ld_cant_capturada and ld_cant_capturada > 0 	THEN
	ldw_2.SetItem(ai_getrow_dw_2,"empa_status",'T')  //Trabajado
ELSEIF ad_emtel_cantidad > 0 THEN
	ldw_2.SetItem(ai_getrow_dw_2,"empa_status",'E')	 //En Proceso
ELSE
	ldw_2.SetItem(ai_getrow_dw_2,"empa_status",'R')	 //Reservado
END IF


end subroutine

public subroutine wf_setear_cod_prod (string as_codigo, integer ai_linea, decimal ad_cantidad); Datawindow		   ldw_2
 dwobject         dwo
 ldw_2 = tab_1.tabpage_2.dw_2
 
 ib_desde_ayuda = true
 ii_linea		 = ai_linea
 is_cod_prod	 = as_codigo
 is_col		    = "empa_codigo_producto"
//ld_disponible 
 if as_codigo <> '' and not isnull(as_codigo) then
	 ldw_2.Setitem(ldw_2.Getrow(),"empa_codigo_producto",as_codigo)
	 ldw_2.Setitem(ldw_2.Getrow(),"empa_cantidad",ad_cantidad)
	 ldw_2.Setitem(ldw_2.Getrow(),"empa_canti",ad_cantidad)
	 ldw_2.trigger event itemchanged(ldw_2.getrow(),dwo,as_codigo)
 end if
end subroutine

public subroutine wf_recalcula_cubicaje (string ass_producto, decimal asl_total, ref decimal asl_peso, ref decimal asl_cubicaje);Return

datawindow ldw_2
ldw_2 = tab_1.tabpage_2.dw_2
asl_peso = 0 
asl_cubicaje = 0

  SELECT inmprodu.prod_peso,   
         inmprodu.prod_cubicaje  
    INTO :asl_peso,   
         :asl_cubicaje  
    FROM inmprodu  
   WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
         ( inmprodu.prod_empresa = :str.empresa ) AND  
         ( inmprodu.prod_producto = :ass_producto  )   ;
			
If sqlca.sqlcode = -1 then
	messagebox("ERROR","Error al obtener el cubicaje del maestro de producto")
	return
End If

asl_peso = round(asl_peso * asl_total,2)
asl_cubicaje = round(asl_cubicaje * asl_total,2)
//messagebox('asl_total',string(asl_total)+' peso'+string(asl_peso)+' cubicaje'+string(asl_cubicaje))
ldw_2.SetItem(ldw_2.GetRow(),"empa_cubicaje",asl_cubicaje)
ldw_2.SetItem(ldw_2.GetRow(),"empa_peso",asl_peso)




end subroutine

public subroutine wf_salvar_detalle (long ai_linea, long ai_getrow, ref boolean ab_borro, decimal ad_cant_original);/*Added by Hgn, used by desglose rollos de tela, called from doubleclicked*/

Datawindow ldw_2,ldw_6,ldw_1,ldw_4,ldw_5
Integer	li_salvo
String	ls_codigo_producto
ldw_2 = tab_1.tabpage_2.dw_2
ldw_6 = tab_1.tabpage_2.dw_6
ldw_4 = tab_1.tabpage_1.dw_4
ldw_2.AcceptText()
ldw_6.AcceptText()

ldw_2.ScrollTorow(ldw_2.RowCount())
ls_codigo_producto = ldw_2.Getitemstring(ldw_2.RowCount(),"empa_codigo_producto") 
if trim(ls_codigo_producto) = '' or isnull(ls_codigo_producto) then
	ldw_2.Deleterow(ldw_2.RowCount())
end if

//If  pos(upper(str.nombre_empresa),'VISION') > 0  Then	

//Textiles
//  cant_desglosada  	 >= cantidad asignada x la linea 
IF str_desglose.cantidad >= ad_cant_original and ad_cant_original > 0 	THEN
	ldw_2.SetItem(ai_getrow,"empa_status",'T')  //Trabajado
ELSEIF str_desglose.cantidad > 0 THEN
	ldw_2.SetItem(ai_getrow,"empa_status",'E')	 //En Proceso
ELSE
	ldw_2.SetItem(ai_getrow,"empa_status",'R')	 //Reservado
END IF

li_salvo = ldw_2.update()

if li_salvo = 1  then

	 commit using sqlca;
	if is_fuente = 'PE' then
		ldw_6.Retrieve(str.g_financiero, str.empresa, is_pedido, il_ann)
		ldw_4.Retrieve(str.g_financiero, str.empresa, is_pedido, il_ann)
	else
		ldw_6.Retrieve(str.g_financiero, str.empresa,is_pedido,il_ann,is_tipo)
		ldw_4.Retrieve(str.g_financiero, str.empresa, is_pedido, il_ann, is_tipo)
	end if

  /* Refresca los datos del datawindows cuando la Actualizacion fue correcta */
  ldw_2.setredraw(false)
  
  /* Recupera los datos para actualizar los valores cambiados en la tabla*/
  ldw_2.retrieve(str.g_financiero,str.empresa,str_desglose.empaque,str_desglose.ann_empa)
  
  ldw_2.setredraw(true)	
else
	rollback using sqlca;
	// borrar detalle de este renglón
	mensaje("Atención","¡Error al Actualizar el renglón actual ,se borrará detalle capturado del mismo",sqlca.sqlerrtext)
	wf_eliminar_detalle(ai_linea,ai_getrow,ab_borro)
end if

end subroutine

public function integer wf_validar_cantidad (datawindow adw_dw1, integer al_linea, string as_vienede);//Funciòn que valida la Cantidad Que se Introdujo y Setea la Cantidad que Queda Disponible
//Llamada desde: ue_postitem, 

Decimal    {2} ld_cantidad,  ld_cant_uniminmas, ld_disponible, ld_asignada, ld_cant_anterior_minimas, ld_peso,ld_cubicaje
Decimal ld_cant_total_fademp, ld_conversion, ld_cant_asig

Integer     li_linea, li_row
String		ls_producto, ls_unidad, ls_expresion
Long			ll_fraccion, ll_frac_asig
DataWindow  ldw_4

ldw_4			= tab_1.tabpage_1.dw_4

	ld_cantidad	 		=  adw_dw1.GetItemNumber(al_linea, "empa_canti")

	ls_unidad    		=  adw_dw1.Getitemstring(al_linea, "empa_unidad")

	ld_cant_uniminmas =  wf_convert_min(ls_unidad,ld_cantidad, 0)	//Cantidad editada en unidades minimas
	ld_cant_anterior_minimas 	=  wf_convert_min(ls_unidad,id_canti, 0) //Cargadas en el Itemfocuschanged

	/*Valida si el status está trabajado*/	
	If adw_dw1.GetItemString(al_linea,"empa_status") ='T' then //Trabajado
		// Cantidad editada < cantidad anterior
		
		if ld_cant_uniminmas < ld_cant_anterior_minimas then
			messagebox('Atención ','Este registro ya está trabajado, si desea disminuir la cantidad, primero debe corregir el detalle de los rollos ...!!')
			adw_dw1.Setitem(al_linea,"empa_canti",id_canti) // cantidad anterior
			return -1
		end if
	end if
	/**/
	
	if ld_cant_uniminmas = 0 then 
		gf_mensaje("","La Cantidad está en 0, al Salvar El Registro Será Eliminado",1,1,"E")
		adw_dw1.SetItem(al_linea,"validado",0)	//Para saber que el Articulo está incorrecto	
	else
		adw_dw1.SetItem(al_linea,"validado",1)	//Para saber que el Articulo está correcto
	end if
	
	ls_producto  		=  adw_dw1.Getitemstring(al_linea, "empa_codigo_producto")
	
	if (ls_producto = '' or IsNull(ls_producto)) then 
		messagebox('Atención ','El código de producto no puede ser nulo....')
		return -1
	end if
	
	li_linea		 		=  adw_dw1.GetitemNumber(al_linea, "empa_linea_original")
	if is_fuente = 'PE' then
		ls_expresion 		=  "codigo_item = '"+ls_producto+"' and dped_linea = "+string(li_linea)
	else
		ls_expresion 		=  "codigo_item = '"+ls_producto+"' and facd_linea = "+string(li_linea)
	end if

	//Busca en el DW4
	li_row	=  ldw_4.Find(ls_expresion,1,ldw_4.Rowcount())
	
	if li_row > 0 then  //Si encuentra el Articulo en el dw4 Pedido
		ld_disponible = ldw_4.Getitemnumber(li_row, "cant_disponible")
		ld_asignada	  = ldw_4.Getitemnumber(li_row, is_campo_asignada)	

		If isNull(ld_disponible) then ld_disponible = 0
		If isNull(ld_asignada) then ld_asignada = 0

		ld_conversion = adw_dw1.GetItemNumber(al_linea,'medi_cantidad')
		If isNull(ld_conversion) then ld_conversion = 0

		/**********/
		ld_disponible = ld_disponible + ld_cant_anterior_minimas

		ld_asignada   = ld_asignada   - ld_cant_anterior_minimas
		/*******/	
		
		if ld_disponible >= ld_cant_uniminmas then	

			ld_disponible = ld_disponible - ld_cant_uniminmas

			ld_asignada   = ld_asignada   + ld_cant_uniminmas

////			ldw_4.Setitem(li_row, "cant_disponible", ld_disponible )
////			ldw_4.Setitem(li_row, is_campo_asignada, ld_asignada)
		
			adw_dw1.Setitem(al_linea,"empa_cantidad",ld_cantidad) // cantidad igual a lo que queda disponible

			//Setea cant_asig y cant_disp
			wf_convierte_a_unidades(ldw_4,li_row,ls_unidad,ld_asignada ,ld_disponible )				
			
			wf_recalcula_cubicaje(ls_producto,ld_cantidad,ld_peso,ld_cubicaje)
			
		else

			if as_vienede = "CANTI" then
				If ld_disponible > 0 then	 
					
					IF adw_dw1.GetitemNumber(al_linea,"fadempaq_f5") = 1 then
						ld_cantidad = round(ld_disponible/ld_conversion,2)

						adw_dw1.Setitem(al_linea,"empa_cantidad",ld_cantidad) // cantidad igual a lo que queda disponible
						adw_dw1.Setitem(al_linea,"empa_canti",ld_cantidad) // cantidad igual a lo que queda disponible

						ld_cant_uniminmas =  ld_disponible
						ld_asignada  = ld_asignada + ld_cant_uniminmas
						
						// Se setea todo lo disponible a la cantidad, este se hace 0 y lo asignado = total reservado
////						ldw_4.Setitem(li_row, "cant_disponible", 0)

						//Setea cant_asig y cant_disp
						wf_convierte_a_unidades(ldw_4,li_row,ls_unidad,ld_asignada ,0)				
/////////			ldw_4.Setitem(li_row, is_campo_asignada, ld_asignada)
						
						wf_recalcula_cubicaje(ls_producto,ld_cantidad,ld_peso,ld_cubicaje)
						
					else
						gf_mensaje("","La Cantidad, Ha Sobrepasado lo Disponible",1,1,"E")
						/** SI REGISTRO SE CREO POR F5 QUE NO SETEE CANTIDAD **/
						adw_dw1.Setitem(al_linea,"empa_canti",id_canti) // cantidad anterior
						is_viene_de =''
						return -1			
					end if
					
				end if
			end if	
		end if
		is_viene_de =''
	else
		gf_mensaje("","No Pudo Rebajar la Cantidad Disponible, Verifique.",1,1,"E")
		return -1
	end if
	is_viene_de =''
return 1

end function

public subroutine wf_recuperar_packing ();//Recupera algun packing existente, asigna de donde viene o la fuente del packing
//Llamada desde: ue_busqueda

datawindow ldw_1
integer li_recupero

ldw_1 = tab_1.Tabpage_1.dw_1

li_recupero = ldw_1.Retrieve(str.g_financiero, str.empresa, is_empaque, il_ann_empa)

if li_recupero < 1 then
	gf_mensaje("","No se Pudo Recuperar la Lista de Empaque, Verifique.",1,1,"E")
	//is_pedido = '': Para que se inicialice solo con la lista de empaque siguiente y el año.
	is_pedido = '' 	
	wf_setear_iniciales(ldw_1)
else
	//Habilita los Tabs
	wf_habilita_tabs('S')	
	
	ldw_1.SetItem(ldw_1.Getrow(),"cliente",is_cliente)	
	ldw_1.SetItemStatus(ldw_1.Getrow(),0,Primary!,Notmodified!)	
	wf_modificar_barra()
end if

end subroutine

public subroutine wf_setear_iniciales (datawindow ldw_1);//Setea los Valores Iniciales del DW
//Llamada desde: wf_recupera_packing, ue_post_open, ue_adicionar

String	ls_lista, ls_autorizo
Long		ll_row

//Setea la Secuencia de la Lista de Empaque
ls_lista = wf_buscar_secuencia()

is_empaque = ls_lista

ldw_1.Setitem(ldw_1.Getrow(),"enca_lista_empaque",ls_lista)

//Seteo el Año de la Lista de Empaque
ldw_1.Setitem(ldw_1.Getrow(),"enca_ann",w_fa_fondo.str_para.ano)

//Setea el Grupo y Empresa
gf_setea_grupo_empresa(ldw_1,"enca")

if is_pedido = '' or isnull(is_pedido) then

	//Pone el Estatus a NotModified
	ldw_1.SetItemStatus(ldw_1.Getrow(),0,Primary!, Notmodified!)
	
else  //Setea los Datos del Pedido a Aplicar Packing

	ldw_1.Setitem(ldw_1.Getrow(),"enca_fuente",is_fuente)					//La Fuente , De donde Viene
	ldw_1.Setitem(ldw_1.Getrow(),"enca_no_pedido",is_pedido)				//Numero de Pedido
	ldw_1.Setitem(ldw_1.Getrow(),"enca_ann_pedido",il_ann)				//Año
	ldw_1.Setitem(ldw_1.Getrow(),"enca_tipo",is_tipo)				//Si es al Por mayor o no
	ldw_1.Setitem(ldw_1.Getrow(),"enca_fecha_inicio",gf_fecha_serv())	//La Fecha de Inicio
	ldw_1.Setitem(ldw_1.Getrow(),"cliente",is_cliente)						//Cliente
	
	ib_cambio =	true
	
	/*    Datos de Pedido */
	
	if is_fuente = 'PE' then

		  SELECT fatpedid.pedi_autorizacion  
		    INTO :ls_autorizo  
		    FROM fatpedid  
		   WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
		         ( fatpedid.pedi_empresa = :str.empresa ) AND  
		         ( fatpedid.pedi_tipo = :is_tipo ) AND  
		         ( fatpedid.pedi_no_pedido = :is_pedido ) AND  
		         ( fatpedid.pedi_ann = :il_ann )   ;
			
			if sqlca.sqlcode = -1 then
				mensaje("Aviso","Error al Seleccionar la Autorización del Pedido ",sqlca.sqlerrtext)
			end if
		
	else  //De Facturas

		  SELECT fatdiari.fact_autorizacion  
			 INTO :ls_autorizo  
			 FROM fatdiari  
			WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
					( fatdiari.fact_empresa = :str.empresa ) AND  
					( fatdiari.fact_tipo = :is_tipo ) AND  
					( fatdiari.fact_no_pedido = :is_pedido ) AND  
					( fatdiari.fact_ann = :il_ann )  ;

			if sqlca.sqlcode = -1 then
				mensaje("Aviso","Error al Seleccionar la Autorización del Pedido (Facturas)",sqlca.sqlerrtext)
			end if
					
	end if
	
		ldw_1.Setitem(ldw_1.Getrow(),"enca_autorizado_por",ls_autorizo)	
			
end if
end subroutine

public subroutine wf_pasar_todos ();//llamado desde el boton Pasar Todos
String  ls_prod, ls_bodega, ls_ubicacion, ls_uni_peso, ls_descrip, ls_unidad, data,ls_empaque
Integer i, li_linea_ori,li_anio,li_lin_ref
long	  ll_row_2,  row,ll_disponible = 0, ll_cantidad,ll_fraccion,li_sqlcode,li_linea_original, ll_row_4
Decimal ld_disponible = 0, ld_cantidad,ld_fraccion,ld_asignada_total,ld_cant_deglosada,ld_asigna_linea
decimal  ld_cubicaje, ld_peso

datawindow ldw_4, ldw_5, ldw_2, ldw_6
dwobject         dwo

ldw_2 = tab_1.tabpage_2.dw_2
ldw_4 = tab_1.tabpage_1.dw_4
ldw_5 = tab_1.tabpage_2.dw_5
ldw_6 = tab_1.tabpage_2.dw_6

ls_prod = ldw_2.Getitemstring(ldw_2.rowcount(),"empa_codigo_producto")

If Not IsNull(ls_prod) or len(trim(ls_prod))>0 then
	ib_adicionar = true
	this.triggerevent('ue_adicionar')
	ldw_2.scrolltorow(ldw_2.rowcount())
	ld_asignada_total = 0
end if
ll_row_2 = ldw_2.rowcount()

for ll_row_4 = 1 to ldw_4.rowcount()
		
		ld_disponible = ldw_4.GetitemNumber(ll_row_4 ,"cant_disponible") 
		ls_prod 		  = ldw_4.GetitemString(ll_row_4 ,"codigo_item")

		if str_empaque.fuente = 'PE' then 
			li_linea_original		  = ldw_4.GetitemNumber(ll_row_4 ,"dped_linea")
		else
			li_linea_original		  = ldw_4.GetitemNumber(ll_row_4 ,"facd_linea")
		end if
		 
		 ib_desde_ayuda = false
		 ii_linea		 = li_linea_original
		 is_cod_prod	 = ls_prod
		 is_col		    = "empa_codigo_producto"
		 
		 if ls_prod <> '' and not isnull(ls_prod) then
			 
				  if is_fuente = 'PE' Then	//Si la fuente es de pedidos
						//Setear los Datos del Articulo								
						ls_bodega    = ldw_4.GetitemString(ll_row_4,"dped_bodega")
						ls_ubicacion = ldw_4.GetitemString(ll_row_4,"dped_ubicacion")
						ld_cubicaje	 = ldw_4.GetitemNumber(ll_row_4,"dped_cubicaje")
						ld_peso		 = ldw_4.GetitemNumber(ll_row_4,"dped_peso")
						
						ls_uni_peso  = ldw_4.GetitemString(ll_row_4,"dped_unidad_peso")
						ls_descrip	 =	ldw_4.GetitemString(ll_row_4,"prod_descripcion")
						ls_unidad	 = ldw_4.GetitemString(ll_row_4,"dped_unidad_venta")				
						li_linea_ori = ldw_4.GetitemNumber(ll_row_4,"dped_linea")
						ld_disponible= ldw_4.GetitemNumber(ll_row_4,"cant_disponible")									
					
						ld_cantidad  = ldw_4.GetitemNumber(ll_row_4,"dped_cantidad")
						
						//Seteo 0 a lo disponible, ya que estoy asignando todo por default,
						//Al Modificar la Cantidad, alimienta lo disponible y rebaja lo asignado

						//	ldw_4.SetItem(ll_row_4,"cant_disponible",0)

						//Recupera cantidad total asignada y del renglon actual						
						wf_buscar_total_asignadas(ll_row_4,li_linea_ori , ld_asignada_total , ld_asigna_linea,li_sqlcode)
						
						If li_sqlcode = -1 then
							return
						end if

						If IsNull(ld_cantidad) then ld_cantidad =0						
						If IsNull(ld_asignada_total) then ld_asignada_total =0						
						If IsNull(ld_asigna_linea) then ld_asigna_linea =0						
			
						// Disponible   total reserva- 
						ld_disponible = ld_cantidad - ld_asignada_total 
						If IsNull(ld_disponible) then ld_disponible =0						
					
					///   ldw_4.SetItem(ll_row_4,"dped_cant_asignada", ld_asignada_total)
				///		ldw_4.SetItem(ll_row_4,"cant_disponible",ld_disponible)

						//Función que convierte lo asignado y disponible en cantidades y fracciones
						wf_convierte_a_unidades(ldw_4,ll_row_4,ls_unidad,ld_asignada_total,0)

						If ld_asignada_total < ld_cantidad then
							ll_row_2 = ldw_2.rowcount()
							ldw_2.Setitem(ll_row_2,"empa_codigo_producto",ls_prod)
							ldw_2.SetItem(ll_row_2,"empa_bodega",ls_bodega)
							ldw_2.SetItem(ll_row_2,"empa_ubicacion",ls_ubicacion)
							ldw_2.SetItem(ll_row_2,"empa_cubicaje",ld_cubicaje)				
							ldw_2.SetItem(ll_row_2,"empa_peso",ld_peso)								
							ldw_2.SetItem(ll_row_2,"empa_unidad_peso",ls_uni_peso)
							ldw_2.SetItem(ll_row_2,"prod_descripcion",ls_descrip)
							ldw_2.SetItem(ll_row_2,"empa_unidad",ls_unidad)

							ldw_2.SetItem(ll_row_2,"empa_canti",ld_disponible)
							ldw_2.SetItem(ll_row_2,"empa_cantidad",ld_disponible)
							ldw_2.SetItem(ll_row_2,"empa_linea_original",li_linea_ori)				
							ldw_2.SetItem(ll_row_2,"validado",1)	//Para saber que el Articulo está correcto
							ldw_2.SetColumn(4)
						end if
						
					else
						//Setear los Datos del Articulo							
						ls_bodega    = ldw_4.GetitemString(ll_row_4,"facd_bodega")
						ls_ubicacion = ldw_4.GetitemString(ll_row_4,"facd_ubicacion")
						ld_cubicaje	 = ldw_4.GetitemNumber(ll_row_4,"facd_cubicaje")
						ld_peso		 = ldw_4.GetitemNumber(ll_row_4,"facd_peso")
						ls_uni_peso  = ldw_4.GetitemString(ll_row_4,"facd_unidad_peso")
						ls_descrip	 =	ldw_4.GetitemString(ll_row_4,"prod_descripcion")
						ls_unidad	 = ldw_4.GetitemString(ll_row_4,"facd_unidad_venta")				
						li_linea_ori = ldw_4.GetitemNumber(ll_row_4,"facd_linea")
						ld_disponible= ldw_4.GetitemNumber(ll_row_4,"cant_disponible")
						ld_cantidad  = ldw_4.GetitemNumber(ll_row_4,"facd_cantidad")

							//Seteo 0 a lo disponible, ya que estoy asignando todo por default,
						//Al Modificar la Cantidad, alimienta lo disponible y rebaja lo asignado
			////			ldw_4.SetItem(ll_row_4,"cant_disponible",0)
						
						//Recupera cantidad total asignada y del renglon actual						
						wf_buscar_total_asignadas(li_linea_ori, ll_row_4 , ld_asignada_total , ld_asigna_linea,li_sqlcode)
						
						If li_sqlcode = -1 then
							return
						end if
						If IsNull(ld_cantidad) then ld_cantidad =0						
						If IsNull(ld_asignada_total) then ld_asignada_total =0						
						If IsNull(ld_asigna_linea) then ld_asigna_linea =0						
			
						// Disponible   total reserva- 
						ld_disponible = ld_cantidad - ld_asignada_total
						If IsNull(ld_disponible) then ld_disponible =0						
					
			///		   ldw_4.SetItem(ll_row_4,"facd_cant_asignada", ld_asignada_total)
			///			ldw_4.SetItem(ll_row_4,"cant_disponible",ld_disponible)

						//Función que convierte lo asignado y disponible en cantidades y fracciones
						wf_convierte_a_unidades(ldw_4,ll_row_4,ls_unidad,ld_cantidad - ld_disponible, 0)

						If ld_asignada_total < ld_cantidad then
							ll_row_2 = ldw_2.rowcount()
							ldw_2.Setitem(ll_row_2,"empa_codigo_producto",ls_prod)
							ldw_2.SetItem(ll_row_2,"empa_bodega",ls_bodega)
							ldw_2.SetItem(ll_row_2,"empa_ubicacion",ls_ubicacion)
							ldw_2.SetItem(ll_row_2,"empa_cubicaje",ld_cubicaje)				
							ldw_2.SetItem(ll_row_2,"empa_peso",ld_peso)								
							ldw_2.SetItem(ll_row_2,"empa_unidad_peso",ls_uni_peso)
							ldw_2.SetItem(ll_row_2,"prod_descripcion",ls_descrip)
							ldw_2.SetItem(ll_row_2,"empa_unidad",ls_unidad)
							
							ldw_2.SetItem(ll_row_2,"empa_canti",ld_disponible)
							ldw_2.SetItem(ll_row_2,"empa_cantidad",ld_disponible)
							ldw_2.SetItem(ll_row_2,"empa_linea_original",li_linea_ori)
							ldw_2.SetItem(ll_row_2,"validado",1)	//Para saber que el Articulo está correcto
							ldw_2.SetColumn(4)

						end if
					end if	
		 end if

		ib_adicionar = true
		
		this.triggerevent('ue_adicionar')
		
		ldw_2.scrolltorow(ldw_2.rowcount())

		ld_asignada_total = 0
next

end subroutine

public subroutine wf_setear_cubic (double ad_largo, double ad_alto, double ad_ancho, double ad_cubicaje, string as_unidad_comp);// Función en Donde se Setean los Valores del Cubicaje, Desglozado
// Llamado Desde: Ventana de Cubicaje (w_fa_man_cubic_packing)

datawindow ldw_2
ldw_2 = tab_1.tabpage_2.dw_2

ldw_2.SetItem(ldw_2.Getrow(),"empa_largo",ad_largo)
ldw_2.SetItem(ldw_2.Getrow(),"empa_alto",ad_alto)
ldw_2.SetItem(ldw_2.Getrow(),"empa_ancho",ad_ancho)
ldw_2.SetItem(ldw_2.Getrow(),"empa_cubicaje",ad_cubicaje)
ldw_2.SetItem(ldw_2.Getrow(),"empa_uni_cubic_compuesto",as_unidad_comp)
end subroutine

public subroutine wf_buscar_total_asignadas (integer ai_linea_referencia, integer ai_linea_original, ref decimal ad_aisgnadas, ref decimal ad_asinado_linea, long ai_sqlcode);Decimal	ld_cant_lin_empa_actual
Datawindow ldw_2,ldw_6
String	ls_pedido,ls_fuente,ls_error,ls_tipo
Integer	li_anio

ldw_2 = tab_1.tabpage_2.dw_2
ldw_6 = tab_1.tabpage_2.dw_6

ls_pedido = tab_1.tabpage_1.dw_1.GetItemString(1,"enca_no_pedido")
li_anio = tab_1.tabpage_1.dw_1.GetItemNumber(1,"enca_ann_pedido")
ls_fuente = tab_1.tabpage_1.dw_1.GetItemString(1,"enca_fuente")
ls_tipo = tab_1.tabpage_1.dw_1.GetItemString(1,"enca_tipo")

//Obtiene el total asignado de la línea del pedido en todas las listas
//de empaque que se originaron en él

If is_fuente ='PE' THEN
  SELECT sum(IsNull( fadempaq.empa_cantidad,0) )
    INTO :ad_aisgnadas
    FROM fadempaq,   
         fatempaq,fadpedid  
   WHERE ( fatempaq.enca_g_financiero = fadempaq.empa_g_financiero ) and  
         ( fatempaq.enca_empresa = fadempaq.empa_empresa ) and  
         ( fatempaq.enca_lista_empaque = fadempaq.empa_lista_empaque ) and  
         ( fatempaq.enca_ann = fadempaq.empa_ann ) and
			
 			( fatempaq.enca_g_financiero = fadpedid.dped_g_financiero ) and  
         ( fatempaq.enca_empresa = fadpedid.dped_empresa ) and
			
         ( fadpedid.dped_no_pedido = fatempaq.enca_no_pedido ) and  
         ( fadpedid.dped_ann = fatempaq.enca_ann_pedido ) and  
         ( fadpedid.dped_linea = fadempaq.empa_linea_original ) and   

         ( ( fatempaq.enca_g_financiero = :str.g_financiero ) AND  
         ( fatempaq.enca_empresa = :str.empresa ) AND  
         ( fatempaq.enca_no_pedido = :ls_pedido) AND  
         ( fatempaq.enca_ann_pedido = :li_anio ) AND
			( fadempaq.empa_linea_original= :ai_linea_original) and  
         ( fatempaq.enca_fuente = 'PE') )  ; 
ELSE
  SELECT sum( IsNull( fadempaq.empa_cantidad ,0) )
    INTO :ad_aisgnadas
    FROM faddiari,   
         fadempaq,   
         fatempaq
   WHERE ( fatempaq.enca_g_financiero = fadempaq.empa_g_financiero ) and  
         ( fatempaq.enca_empresa = fadempaq.empa_empresa ) and  
         ( fatempaq.enca_lista_empaque = fadempaq.empa_lista_empaque ) and  
         ( fatempaq.enca_ann = fadempaq.empa_ann ) and
			
         ( fatempaq.enca_g_financiero = faddiari.facd_g_financiero ) and  
         ( fatempaq.enca_empresa = faddiari.facd_empresa ) and  
			
			( faddiari.facd_tipo = fatempaq.enca_tipo ) and  

         ( faddiari.facd_no_pedido = fatempaq.enca_no_pedido ) and  
         ( faddiari.facd_ann = fatempaq.enca_ann_pedido ) and  
         ( faddiari.facd_linea = fadempaq.empa_linea_original ) and  
			
			( ( fatempaq.enca_g_financiero = :str.g_financiero ) AND  
         ( fatempaq.enca_empresa = :str.empresa) AND  
         ( fatempaq.enca_tipo = :ls_tipo ) AND  
         ( fatempaq.enca_no_pedido = :ls_pedido) AND  
         ( fatempaq.enca_ann_pedido = :li_anio ) AND  
         ( fadempaq.empa_linea_original = :ai_linea_original ) and
         ( fatempaq.enca_fuente = 'FA') )  ; 

END IF


ai_sqlcode = SQLCA.sqlcode
If IsNull(ad_aisgnadas) then ad_aisgnadas =0

If SQLCA.sqlcode = -1 then
	ad_aisgnadas = 0
	ls_error = sqlca.sqlerrText
	mensaje("Atención","Error al leer el yardaje asignado (fadempaq) ",ls_error)
	return 
end if			

/****************************************************************/
//Obtiene la cantidad del renglón actual del dw_2 que está grabado

If is_fuente ='PE' THEN
  SELECT sum(IsNull( fadempaq.empa_cantidad,0) )
    INTO :ad_asinado_linea
    FROM fadempaq,   
         fatempaq,fadpedid  
   WHERE ( fatempaq.enca_g_financiero = fadempaq.empa_g_financiero ) and  
         ( fatempaq.enca_empresa = fadempaq.empa_empresa ) and  
         ( fatempaq.enca_lista_empaque = fadempaq.empa_lista_empaque ) and  
         ( fatempaq.enca_ann = fadempaq.empa_ann ) and
			
 			( fatempaq.enca_g_financiero = fadpedid.dped_g_financiero ) and  
         ( fatempaq.enca_empresa = fadpedid.dped_empresa ) and
			
         ( fadpedid.dped_no_pedido = fatempaq.enca_no_pedido ) and  
         ( fadpedid.dped_ann = fatempaq.enca_ann_pedido ) and  
         ( fadpedid.dped_linea = fadempaq.empa_linea_original ) and   

         ( ( fatempaq.enca_g_financiero = :str.g_financiero ) AND  
         ( fatempaq.enca_empresa = :str.empresa ) AND  
         ( fatempaq.enca_no_pedido = :ls_pedido) AND  
         ( fatempaq.enca_ann_pedido = :li_anio ) AND
			( fadempaq.empa_linea_original= :ai_linea_original) and  
			( fadempaq.empa_linea = :ai_linea_referencia) and  
         ( fatempaq.enca_fuente = 'PE') )  ; 

/*
  SELECT sum(IsNull( fademtel.fade_cantidad,0) )  
    INTO :ad_asinado_linea
    FROM fadempaq,   
         fademtel,   
         fatempaq,   
         fadpedid  
   WHERE ( fademtel.fade_g_financiero = fadempaq.empa_g_financiero ) and  
         ( fademtel.fade_empresa = fadempaq.empa_empresa ) and  
         ( fademtel.fade_lista_empaque = fadempaq.empa_lista_empaque ) and  
         ( fademtel.fade_ann = fadempaq.empa_ann ) and  
         ( fademtel.fade_linea_refer = fadempaq.empa_linea ) and  

         ( fatempaq.enca_g_financiero = fadempaq.empa_g_financiero ) and  
         ( fatempaq.enca_empresa = fadempaq.empa_empresa ) and  
         ( fatempaq.enca_lista_empaque = fadempaq.empa_lista_empaque ) and  
         ( fatempaq.enca_ann = fadempaq.empa_ann ) and  

         ( fatempaq.enca_g_financiero = fadpedid.dped_g_financiero ) and  
         ( fatempaq.enca_empresa = fadpedid.dped_empresa ) and  
         ( fatempaq.enca_no_pedido = fadpedid.dped_no_pedido ) and  
         ( fatempaq.enca_ann_pedido = fadpedid.dped_ann ) and  
         ( fadempaq.empa_linea_original = fadpedid.dped_linea ) and   

         ( ( fatempaq.enca_g_financiero = :str.g_financiero ) AND  
         ( fatempaq.enca_empresa = :str.empresa ) AND  
         ( fatempaq.enca_no_pedido = :ls_pedido) AND  
         ( fatempaq.enca_ann_pedido = :li_anio ) AND
			( fadempaq.empa_linea_original= :ai_linea_original) and  
			( fadempaq.empa_linea = :ai_linea_referencia) and  
         ( fatempaq.enca_fuente = 'PE') )  ; */

ELSE
  SELECT sum( IsNull( fadempaq.empa_cantidad ,0) )
    INTO :ad_asinado_linea
    FROM faddiari,   
         fadempaq,   
         fatempaq  

 WHERE   ( fatempaq.enca_g_financiero = fadempaq.empa_g_financiero ) and  
         ( fatempaq.enca_empresa = fadempaq.empa_empresa ) and  
         ( fatempaq.enca_lista_empaque = fadempaq.empa_lista_empaque ) and  
         ( fatempaq.enca_ann = fadempaq.empa_ann ) and  

			
         ( fatempaq.enca_g_financiero = faddiari.facd_g_financiero ) and  
         ( fatempaq.enca_empresa = faddiari.facd_empresa ) and  
			
			( faddiari.facd_tipo = fatempaq.enca_tipo ) and  

         ( faddiari.facd_no_pedido = fatempaq.enca_no_pedido ) and  
         ( faddiari.facd_ann = fatempaq.enca_ann_pedido ) and  
         ( faddiari.facd_linea = fadempaq.empa_linea_original ) and  
			
			( ( fatempaq.enca_g_financiero = :str.g_financiero ) AND  
         ( fatempaq.enca_empresa = :str.empresa) AND  
         ( fatempaq.enca_tipo = :ls_tipo ) AND  
         ( fatempaq.enca_no_pedido = :ls_pedido) AND  
         ( fatempaq.enca_ann_pedido = :li_anio ) AND  
         ( fadempaq.empa_linea_original = :ai_linea_original ) and
			( fadempaq.empa_linea = :ai_linea_referencia) and  
         ( fatempaq.enca_fuente = 'FA') )  ; 

/*  SELECT sum(IsNull( fademtel.fade_cantidad,0) )  
    INTO :ad_asinado_linea
    FROM faddiari,   
         fadempaq,   
         fademtel,   
         fatempaq
   WHERE ( fademtel.fade_g_financiero = fadempaq.empa_g_financiero ) and  
         ( fademtel.fade_empresa = fadempaq.empa_empresa ) and  
         ( fademtel.fade_lista_empaque = fadempaq.empa_lista_empaque ) and  
         ( fademtel.fade_ann = fadempaq.empa_ann ) and  
         ( fademtel.fade_linea_refer = fadempaq.empa_linea ) and  
			
    		( fatempaq.enca_g_financiero = fadempaq.empa_g_financiero ) and  
         ( fatempaq.enca_empresa = fadempaq.empa_empresa ) and  
         ( fatempaq.enca_lista_empaque = fadempaq.empa_lista_empaque ) and  
         ( fatempaq.enca_ann = fadempaq.empa_ann ) and
			
         ( fatempaq.enca_g_financiero = faddiari.facd_g_financiero ) and  
         ( fatempaq.enca_empresa = faddiari.facd_empresa ) and
			( fatempaq.enca_tipo = faddiari.facd_tipo) and  
         ( fatempaq.enca_no_pedido = faddiari.facd_no_pedido  ) and  
         ( fatempaq.enca_ann_pedido = faddiari.facd_ann ) and  
         ( fadempaq.empa_linea_original = faddiari.facd_linea ) and
			
			( ( fatempaq.enca_g_financiero = :str.g_financiero ) AND  
         ( fatempaq.enca_empresa = :str.empresa) AND  
         ( fatempaq.enca_tipo = :ls_tipo ) AND  
         ( fatempaq.enca_no_pedido = :ls_pedido) AND  
         ( fatempaq.enca_ann_pedido = :li_anio ) AND  
         ( fadempaq.empa_linea_original = :ai_linea_original ) and
			( fadempaq.empa_linea = :ai_linea_referencia) AND
         ( fatempaq.enca_fuente = 'FA') )  ; */

END IF

ai_sqlcode = SQLCA.sqlcode
If IsNull(ad_asinado_linea) then ad_asinado_linea =0

If SQLCA.sqlcode = -1 then
	ad_asinado_linea = 0
	ls_error = sqlca.sqlerrText
	mensaje("Atención","Error al leer el yardaje salvado (fadempaq) ",ls_error)
	return 
end if			

end subroutine

public subroutine wf_imprime_vendedor ();integer li_hay, li_codigo, i=0
string  ls_nombre, ls_resultado, ls_nombre_imp, ls_cod_imp, ls_dataobject

datawindow ldw_1

ldw_1 = tab_1.tabpage_3.dw_3

ls_dataobject = tab_1.tabpage_3.dw_3.dataobject

if pos(ls_dataobject,"_pedi_",1) > 0 then  //Para cuando es pedido
		
		 DECLARE cur_vende_pe CURSOR FOR
		  SELECT fadvenpe.vped_vendedor,   
					famvende.vend_nombre+' '+famvende.vend_apellido nombre  
			 FROM fadvenpe,   
					famvende	// (index PK_FAMVENDE)   
			WHERE ( famvende.vend_g_financiero = fadvenpe.vped_g_financiero ) and  
					( famvende.vend_empresa = fadvenpe.vped_empresa ) and  
					( famvende.vend_vendedor = fadvenpe.vped_vendedor ) and  
					( ( fadvenpe.vped_g_financiero = :str.g_financiero ) AND  
					( fadvenpe.vped_empresa = :str.empresa ) AND  
					( fadvenpe.vped_no_pedido = :is_pedido ) AND  
					( fadvenpe.vped_ann = :il_ann ) ) ;			
					
		 OPEN cur_vende_pe;
		 
		 if sqlca.sqlcode = -1 then
			mensaje("Aviso","Error al Abrir el Cursor",sqlca.sqlerrtext)
			CLOSE cur_vende_pe;
			RETURN
		 end if
		 
		 FETCH cur_vende_pe INTO :li_codigo,:ls_nombre;
		 
		 IF SQLCA.SQLCODE = -1 THEN	
			MESSAGEBOX("ERROR","ERROR AL SELECCIONAR LOS VENDEDORES "+SQLCA.SQLERRTEXT)
			CLOSE cur_vende_pe;
			RETURN
		 END IF	
		 
		 DO WHILE SQLCA.SQLCODE = 0
			 if i > 0 then //Si no es la primera vez ni la ultima, separa el codigo
				ls_nombre_imp += ' / '
				ls_cod_imp	+= ' / '		
			 end if	 
			 ls_nombre_imp += ls_nombre 	     //Concatena los codigos y nombres
			 ls_cod_imp		+= string(li_codigo)	 
			 i ++	 //Incrementa la i
			 FETCH cur_vende_pe INTO :li_codigo,:ls_nombre;	 
		 loop
		 
		 ls_resultado = ldw_1.modify("cod_vendedor.text='"+ls_cod_imp+"'")
		 ls_resultado = ldw_1.modify("nom_vendedor.text='"+ls_nombre_imp+"'")			
			 
		 CLOSE cur_vende_pe;
							
	
else		//Para cuando es factura
	
		 DECLARE cur_vende CURSOR FOR
		  SELECT fadvenfa.vfac_vendedor,   
					famvende.vend_nombre+' '+famvende.vend_apellido nombre  
			 FROM fadvenfa,   
					famvende  //(index PK_FAMVENDE)
			WHERE ( famvende.vend_g_financiero = fadvenfa.vfac_g_financiero ) and  
					( famvende.vend_empresa = fadvenfa.vfac_empresa ) and  
					( famvende.vend_vendedor = fadvenfa.vfac_vendedor ) and  
					( ( fadvenfa.vfac_g_financiero = :str.g_financiero ) AND  
					( fadvenfa.vfac_empresa = :str.empresa ) AND  
					( fadvenfa.vfac_tipo = :is_tipo ) AND  
					( fadvenfa.vfac_no_pedido = :is_pedido ) AND  
					( fadvenfa.vfac_ann = :il_ann ) ) ;			 

		 OPEN cur_vende;
		 
		 if sqlca.sqlcode = -1 then
			mensaje("Aviso","Error al Abrir el Cursor",sqlca.sqlerrtext)
			CLOSE cur_vende;
			RETURN
		 end if
		 
		 FETCH cur_vende INTO :li_codigo,:ls_nombre;
		 
		 IF SQLCA.SQLCODE = -1 THEN	
			MESSAGEBOX("ERROR","ERROR AL SELECCIONAR LOS VENDEDORES "+SQLCA.SQLERRTEXT)
			CLOSE cur_vende;
			RETURN
		 END IF	
		 
		 DO WHILE SQLCA.SQLCODE = 0
			 if i > 0 then //Si no es la primera vez ni la ultima, separa el codigo
				ls_nombre_imp += ' / '
				ls_cod_imp	+= ' / '		
			 end if	 
			 ls_nombre_imp += ls_nombre 	     //Concatena los codigos y nombres
			 ls_cod_imp		+= string(li_codigo)	 
			 i ++	 //Incrementa la i
			 FETCH cur_vende INTO :li_codigo,:ls_nombre;	 
		 loop
		 
		 ls_resultado = ldw_1.modify("cod_vendedor.text='"+ls_cod_imp+"'")
		 ls_resultado = ldw_1.modify("nom_vendedor.text='"+ls_nombre_imp+"'")			
			 
		 CLOSE cur_vende;
		 
 end if	//del pos
end subroutine

on w_fa_man_packing_list_x.create
int iCurrent
call super::create
if this.MenuName = "m_fa_principal" then this.MenuID = create m_fa_principal
this.st_1=create st_1
this.cb_1=create cb_1
this.st_microhelp=create st_microhelp
this.ole_2=create ole_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_microhelp
this.Control[iCurrent+4]=this.ole_2
end on

on w_fa_man_packing_list_x.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.st_microhelp)
destroy(this.ole_2)
end on

event ue_post_open;call super::ue_post_open;String 	 ls_lista
Environment env

DataWindow ldw_1
ldw_1 = Tab_1.tabpage_1.DW_1

ldw_1.SetTransObject(SQLCA);
Tab_1.tabpage_2.DW_2.SetTransObject(SQLCA);
Tab_1.tabpage_3.DW_3.SetTransObject(SQLCA);
Tab_1.tabpage_2.DW_7.SetTransObject(SQLCA);
//Datawindow de trabajo para recuperar detalle del packing list de Textiles

If  pos(upper(str.nombre_empresa),'VISION TEX') > 0  Then	
	Tab_1.tabpage_3.DW_8.DataObject = 'dw_ma_fa_imp_pedi_pack_vision'
else
	Tab_1.tabpage_3.DW_8.DataObject = 'dw_ma_fa_imp_pedi_pack_textiles'
end if

Tab_1.tabpage_3.DW_8.SetTransObject(SQLCA);

f_create_external_func_uo(iu_externa)	

str_empaque.viene_de_ventana=THIS.CLASSNAME()

/*Verifica el sistema operativo */

CHOOSE CASE env.OSType
	case windows!
		is_win9598_winnt='win9598'
	case WindowsNT!
		is_win9598_winnt='winnt'
END CHOOSE

//Declara los Child de los Usuarios y Supervisor
wf_declara_child(ldw_1)

//Deshabilita los Tabs
wf_habilita_tabs('N')

//Inserta una Linea
ldw_1.Scrolltorow(ldw_1.InsertRow(0))

ldw_1.Setfocus()

//Mueve el Cubicaje de la Estructura, Utilizado Por Default
is_unidad_cubicaje = w_fa_fondo.str_para.unidad_cubicaje

//Setea los Valores Iniciales de la lista de empaque
wf_setear_iniciales(ldw_1)

ii_vandera = 1 

idw_proximo = ldw_1

//Setea el Nombre de la Ventana
st_1.text = this.classname()

//Se habilitan y Deshabilitan Opciones de Menu
wf_botones()
str_empaque.viene_de = 'w_fa_man_packing_list_x'
//Habilita la Barra
ole_2.Show()

end event

event open;call super::open;//Centrea la Ventana
//gf_center_win(this)
this.y = 1
this.x = 1
str_pedi = message.PowerObjectParm

end event

event key;call super::key;long ll_tab

If keyDown(Keycontrol!) and keyDown(KeyShift!) Then
		ll_tab = tab_1.SelectedTab
		choose case ll_tab
			case	1
				tab_1.SelectedTab = 2
			case  2
				tab_1.SelectedTab = 3
			case  3
				tab_1.SelectedTab = 1
		end choose		
END IF

end event

event ue_adicionar;//OVERRIDE
//Scrip para buscar los pedidos o las Facturas
//Llamado desde: ue_aceptar, ue_eliminar y desde el menu

String				ls_syntax, ls_empaque, ls_pedido, ls_expresion
long					ll_row_final,ll_row
Integer				li_recupero, li_resp,li_linea=0,li_max=0
DataWindow			ldw_1, ldw_2, ldw_4

ldw_1 = tab_1.tabpage_1.dw_1
ldw_2 = tab_1.tabpage_2.dw_2
ldw_4 = tab_1.tabpage_1.dw_4

str_dg_dynamic_find	lstr_df

if idw_proximo = ldw_1 then  //Si es el DW_1

		if wf_valida_cambios() = 1 then Return  //Si devuelve 1 es por que dio CANCELAR
		
		iw_this.Setredraw(false)
		
		//Deshabilita los Tabs
		wf_habilita_tabs('N')
		
		ldw_1.Reset()
		
		ldw_1.scrolltorow(ldw_1.insertrow(0))
		
		ldw_1.setcolumn(1)

		/*Segmento exclusivo para Vision Tex*/
		If pos(Upper(str.nombre_empresa),'VISION TEX') > 0 then
			wf_modificar_barra()		
			ldw_1.Setitem(1,"enca_recolectado",'S')
			ldw_1.Setitem(1,"enca_fecha_recolectado",gf_fecha_serv())			
			
			wf_modificar_barra()				
			ldw_1.Setitem(1,"enca_empacado",'S')		
			ldw_1.Setitem(1,"enca_fecha_empacado",gf_fecha_serv())		
			
			wf_modificar_barra()			
			ldw_1.Setitem(1,"enca_despachado",'S')
			ldw_1.Setitem(1,"enca_fecha_despachado",gf_fecha_serv())
		
			ls_expresion = "faem_nombre='Wilmar'"
			ll_row = dwc_autoriza.Find(ls_expresion,1,dwc_autoriza.rowcount())
		
			if ll_row > 0 then
				dwc_autoriza.scrolltorow(ll_row)	/*J-A*/
			else
				dwc_autoriza.scrolltorow(1)	/*J-A*/
			end if
			ldw_1.SetItem(1,'enca_autorizado_por',dwc_autoriza.GetItemString(dwc_autoriza.getrow(),'faem_bod_usuario'))
	
			ll_row = dwc_jefes.Find(ls_expresion,1,dwc_jefes.rowcount())
			if ll_row > 0 then
				dwc_jefes.scrolltorow(ll_row)	/*J-A*/
			else
				dwc_jefes.scrolltorow(1)	/*J-A*/
			end if
			ldw_1.SetItem(1,'enca_supervisor',dwc_jefes.GetItemString(dwc_jefes.getrow(),'faem_bod_usuario'))
	
			ll_row = dwc_recolec.Find(ls_expresion,1,dwc_recolec.rowcount())
			if ll_row > 0 then
				dwc_recolec.scrolltorow(ll_row)	/*J-A*/
			else
				dwc_recolec.scrolltorow(1)	/*J-A*/
			end if
			ldw_1.SetItem(1,'enca_recolector',dwc_recolec.GetItemString(dwc_recolec.getrow(),'faem_bod_usuario'))
	
			ll_row = dwc_empa.Find(ls_expresion,1,dwc_empa.rowcount())
			if ll_row > 0 then
				dwc_empa.scrolltorow(ll_row)	/*J-A*/
			else
				dwc_empa.scrolltorow(1)	/*J-A*/
			end if
			ldw_1.SetItem(1,'enca_empacador',dwc_empa.GetItemString(dwc_empa.getrow(),'faem_bod_usuario'))
	
			ll_row = dwc_despa.Find(ls_expresion,1,dwc_despa.rowcount())
			if ll_row > 0 then
				dwc_despa.scrolltorow(ll_row)	/*J-A*/
			else
				dwc_despa.scrolltorow(1)	/*J-A*/
			end if
			ldw_1.SetItem(1,'enca_despachador',dwc_despa.GetItemString(dwc_despa.getrow(),'faem_bod_usuario'))
		end if
		/**************************************/

		li_resp = gf_mensaje("","La Lista de Empaque se Generara de Pedidos ?",4,1,"Q") 
		
		if li_resp = 3 then
			is_pedido = ''	
			wf_setear_iniciales(ldw_1)
			iw_this.Setredraw(true)			
			return
		end if

		if li_resp = 1 then
				is_fuente = 'PE'
				is_campo_asignada	= "dped_cant_asignada"				
				ldw_4.DataObject = "dw_ma_fa_pedi_packing_tel"	//DW de PEDIDOS
				//NO TOCAR EL ORDEN DE LOS CAMPOS, NI LOS NOMBRES; 
				//YA QUE SE UTILIZAN PARA EXTRAER LOS CODIGOS

				lstr_df.texto_campo[1, 1] = "fatpedid.pedi_no_pedido"
				lstr_df.texto_campo[1, 2] = "No. Pedido"
				lstr_df.texto_campo[1, 3] = "fatpedid.pedi_no_pedido"
				lstr_df.texto_campo[1, 4] = "V"
				lstr_df.texto_campo[2, 1] = "dgmterce.terc_descripcion"
				lstr_df.texto_campo[2, 2] = "Descripcion"
				lstr_df.texto_campo[2, 3] = "dgmterce_terc_descripcion"
				lstr_df.texto_campo[2, 4] = "V"		
				lstr_df.texto_campo[3, 1] = "dgmterce.terc_tercero"
				lstr_df.texto_campo[3, 2] = "Codigo"
				lstr_df.texto_campo[3, 3] = "dgmterce_terc_tercero"
				lstr_df.texto_campo[3, 4] = "V"
				lstr_df.texto_campo[4, 1] = "fatpedid.pedi_fecha"
				lstr_df.texto_campo[4, 2] = "Fecha"
				lstr_df.texto_campo[4, 3] = "fatpedid_pedi_fecha"
				lstr_df.texto_campo[4, 4] = "V"
				lstr_df.texto_campo[5, 1] = "fatpedid.pedi_a_nombre"
				lstr_df.texto_campo[5, 2] = "A Nombre"
				lstr_df.texto_campo[5, 3] = "fatpedid_pedi_a_nombre"
				lstr_df.texto_campo[5, 4] = "V"
				lstr_df.texto_campo[6, 1] = "fatpedid.pedi_tipo"
				lstr_df.texto_campo[6, 2] = "Por Mayor"
				lstr_df.texto_campo[6, 3] = "fatpedid_pedi_tipo"
				lstr_df.texto_campo[6, 4] = "I"												
				lstr_df.texto_campo[7, 1] = "fatpedid.pedi_ann"
				lstr_df.texto_campo[7, 2] = "Año"
				lstr_df.texto_campo[7, 3] = "fatpedid_pedi_ann"
				lstr_df.texto_campo[7, 4] = "V"								
				lstr_df.tabla				  = "  dgmterce, fatpedid"
				lstr_df.tabla_where		  = "  WHERE ( fatpedid.pedi_g_financiero = "+string(str.g_financiero)+" ) AND  "+&
												    " ( fatpedid.pedi_empresa = "+string(str.empresa)+" ) AND "+&
													 " ( fatpedid.pedi_cliente = dgmterce.terc_tercero ) And "+ &
													 "	( fatpedid.pedi_autorizacion is not null ) And "+ &
													 " ( fatpedid.pedi_autorizacion <> '' )"

		else
			
				is_fuente = 'FA'
				is_campo_asignada			  = "facd_cant_asignada"				
				ldw_4.DataObject 			  = "dw_ma_fa_fact_packing_tel" //DW de FACTURA
				//NO TOCAR EL ORDEN DE LOS CAMPOS, NI LOS NOMBRES; 
				//YA QUE SE UTILIZAN PARA EXTRAER LOS CODIGOS

				lstr_df.texto_campo[1, 1] = "fatdiari.fact_no_pedido"
				lstr_df.texto_campo[1, 2] = "No. Pedido"
				lstr_df.texto_campo[1, 3] = "fatdiari_fact_no_pedido"
				lstr_df.texto_campo[1, 4] = "V"
				lstr_df.texto_campo[2, 1] = "dgmterce.terc_descripcion"
				lstr_df.texto_campo[2, 2] = "Nombre"
				lstr_df.texto_campo[2, 3] = "dgmterce_terc_descripcion"
				lstr_df.texto_campo[2, 4] = "V"
				lstr_df.texto_campo[3, 1] = "dgmterce.terc_tercero"
				lstr_df.texto_campo[3, 2] = "Identificacion"
				lstr_df.texto_campo[3, 3] = "dgmterce_terc_tercero"
				lstr_df.texto_campo[3, 4] = "V"
				lstr_df.texto_campo[4, 1] = "fatdiari.fact_fecha"
				lstr_df.texto_campo[4, 2] = "Fecha"
				lstr_df.texto_campo[4, 3] = "fatdiari_fact_fecha"
				lstr_df.texto_campo[4, 4] = "V"
				lstr_df.texto_campo[5, 1] = "fatdiari.fact_a_nombre"
				lstr_df.texto_campo[5, 2] = "A Nombre"
				lstr_df.texto_campo[5, 3] = "fatdiari_fact_a_nombre"
				lstr_df.texto_campo[5, 4] = "V"
				lstr_df.texto_campo[6, 1] = "fatdiari.fact_tipo"
				lstr_df.texto_campo[6, 2] = "Por Mayor"
				lstr_df.texto_campo[6, 3] = "fatdiari_fact_tipo"
				lstr_df.texto_campo[6, 4] = "I"																
				lstr_df.texto_campo[7, 1] = "fatdiari.fact_ann"
				lstr_df.texto_campo[7, 2] = "Año"
				lstr_df.texto_campo[7, 3] = "fatdiari_fact_ann"
				lstr_df.texto_campo[7, 4] = "V"				
				lstr_df.tabla				  = " fatdiari , dgmterce "
				lstr_df.tabla_where		  = " WHERE ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) and "+ &
													 " ( fatdiari.fact_empresa = "+string(str.empresa)+" ) and "+ &
													 " ( fatdiari.fact_cliente = dgmterce.terc_tercero ) and "+ &
													 "	( fatdiari.fact_no_pedido not like '%NC%' ) and "+&
													 " ( fatdiari.fact_autorizacion <> '') and "+&
													 " ( fatdiari.fact_autorizacion is not null)"
													 				
		End if				
		
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		
		ls_syntax = Message.StringParm
		
		If Len(Trim(ls_syntax)) > 0 Then  //Si Selecciono Algun registro				
			//Extrae el # de Pedido de la Cadena ls_syntax
			is_pedido 	   = wf_extraer_pedido(ls_syntax)
			il_ann	 	   = wf_extraer_ann(ls_syntax)
			il_ann_empa    = w_fa_fondo.str_para.ano		//Es el año de Parametros
			is_tipo 	      = wf_extraer_pormayor(ls_syntax)
			is_cliente	   = wf_extraer_cliente_new(ls_syntax)

			
			//Recupera los Artículos del Pedido o Factura, a la Que se le Hará Lista de Empaque
			if is_fuente = 'PE' then
				ldw_4.Settransobject(sqlca)
				if ldw_4.Retrieve(str.g_financiero, str.empresa, is_pedido, il_ann) = 0 then
					gf_mensaje("","Este Pedido NO se Pudo Recuperar, Verifique..!",1,1,"E")
					is_pedido	 = ''		//Para que no setee los datos del encabezado en wf_setear_iniciales()					
				end if
			else
				ldw_4.Settransobject(sqlca)
				if ldw_4.Retrieve(str.g_financiero, str.empresa, is_pedido, il_ann, is_tipo) = 0 then
					gf_mensaje("","Este Pedido en Facturas NO se Pudo Recuperar, Verifique..!",1,1,"E")
					is_pedido	 = ''		//Para que no setee los datos del encabezado en wf_setear_iniciales()
				end if
			end if
		Else	//Si dió Cancelar en la Busqueda.
			is_pedido	 = ''			
		End if	
		
		//Si adicionó, que setee la barra en 0 %
		ole_2.object.value = 0
		
		//Verifica si ya existe una lista de empaque para el pedido seleccionado
		
		  SELECT count(*)  
			 INTO :li_recupero  
			 FROM fatempaq  
			WHERE ( fatempaq.enca_g_financiero = :str.g_financiero ) AND  
					( fatempaq.enca_empresa = :str.empresa ) AND  
					( fatempaq.enca_fuente = :is_fuente ) AND  
					( fatempaq.enca_no_pedido = :is_pedido ) AND  
					( fatempaq.enca_tipo = :is_tipo ) AND  
					( fatempaq.enca_ann_pedido = :il_ann ) ;
					
			if sqlca.sqlcode = -1 then
				gf_mensaje("","Error al Validar Existencia de la Lista de Empaque "+sqlca.sqlerrtext,1,1,"E")
				iw_this.Setredraw(true)						
				return
			end if
		
		if li_recupero > 0 then
			if gf_mensaje("","Ya Existe una o mas) Listas de Empaque para Este Pedido, Desea Continuar con la creación de La Lista de Empque ?",2,2,"E")  = 2 then
				is_pedido = ''
				messagebox('Atención ','Si desea buscar una existente proceda a dar un click en los Binoculares y búsquela por No. de Pedido')
			end if
			
			if pos(Upper(str.empr_acceso_especial),'TEXTILESINT,') > 0  then
				
				If is_pedido ='' then return
				
				Integer	li_autor_packing, li_ok
				
				  SELECT fatpedid.pedi_autor_packing  
					 INTO :li_autor_packing  
					 FROM fatpedid  
					WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
							( fatpedid.pedi_empresa = :str.empresa ) AND  
							( fatpedid.pedi_no_pedido = :is_pedido ) AND  
							( fatpedid.pedi_ann = :il_ann )   ;

					if sqlca.sqlcode = -1 then
						gf_mensaje("","Error al Validar la Autorización para crear mas de una Lista de Empaque "+sqlca.sqlerrtext,1,1,"E")
						iw_this.Setredraw(true)						
						return
					end if
					
					If isNull(li_autor_packing) then li_autor_packing =0
					li_ok = 0
					
					CHOOSE CASE li_autor_packing	//Si li_autor_packing > 0, Esta autorizado
						CASE 1
							if li_recupero < 2 then li_ok = 1	//recupero menos de 1 lista de empaque
						CASE 2
							if li_recupero < 3 then li_ok = 1	//recupero menos de 2 lista de empaque
	
						CASE 3
							if li_recupero < 4 then li_ok = 1
						CASE ELSE
							li_ok = 0
					END CHOOSE
					
					if li_ok= 0 then 
						messagebox('Atención ','Se requiere de una autorización de sus Superiores para poder hacer otra Lista de Empaque de este Pedido, Contáctelo y solicite la autorización')
						iw_this.Setredraw(true)		
						return
					end if
			end if

		end if
		
		wf_setear_iniciales(ldw_1)
		
		iw_this.Setredraw(true)		

Elseif idw_proximo = ldw_2 then   //Si es el DW_2
 
   If ldw_2.Rowcount() > 0 then
		
		if not ib_adicionar then
			ldw_2.Scrolltorow(ldw_2.Rowcount())
		end if
		
		if ldw_2.GetItemNumber(ldw_2.Rowcount(),"validado") = 0 then Return //Si el Ultimo Producto esta OK

	End if		

		This.Setredraw(false)

		if ib_adicionar then
			ldw_2.insertrow(0)							//INSERTA LA LINEA DEL DETALLE y NO HACE SCROLL
		else
			ldw_2.scrolltorow(ldw_2.insertrow(0))	//INSERTA LA LINEA DEL DETALLE y VA AL FINAL
		end if
		
		ib_adicionar = false
		
		for ll_row = 1 to ldw_2.rowcount()
			li_linea = ldw_2.GetItemNumber(ll_row,"empa_linea")
			If li_linea > li_max then
				li_max = li_linea
			end if
		Next
		li_max ++
		If IsNull(li_max) then li_max = 1
		
		ll_row_final= ldw_2.rowcount()
		
		//Setea la unidad del cubicaje
		ldw_2.SetItem(ll_row_final,"empa_unidad_cubicaje",is_unidad_cubicaje)
		
		//Setea el status de nuevo del registro (no se ha desglosado)
		// Modify by HGN 24/10/2000
		ldw_2.SetItem(ll_row_final,"empa_status",'R')								
		ldw_2.Setitem(ll_row_final,"empa_linea",li_max)
		
		//Setea la Llave Primaria del Detalle del Empaque
		wf_setea_grupo_empresa(ll_row_final, ldw_2, "empa")		//Setea el Grupo y empresa
		
		//Setea Numero de Lista y Año
		ldw_2.SetItem(ll_row_final,"empa_lista_empaque",is_empaque)
		ldw_2.SetItem(ll_row_final,"empa_ann",il_ann_empa)
		
		//Setea el Numero del Indice
		ldw_2.SetItem(ll_row_final,"index",li_max)
		
		ldw_2.SetItem(ll_row_final,"empa_bulto_inicio",0)
		ldw_2.SetItem(ll_row_final,"empa_bulto_fin",0)
		
		idw_proximo.SetColumn(1)
		
		This.Setredraw(true)
	
End if //del idw_proximo = ldw_1
end event

event ue_aceptar;////Override
This.Setredraw(false)

long 			 ll_update, ll_update2
string 		 ls_codigo_producto
DwItemStatus ls_estatus
Datawindow   ldw_1, ldw_2

ldw_1 = tab_1.tabpage_1.dw_1
ldw_2 = tab_1.tabpage_2.dw_2

ls_estatus = ldw_1.GetitemStatus(ldw_1.Getrow(),0,Primary!)

If ldw_1.getItemNumber(1,"enca_pase_fact") = 1 or ldw_1.getItemString(1,"enca_pasado") = 'S' then
	messagebox('Atención','Esta lista de Empaque no puede ser modificada porque ya fue pasada a factura')
	If ldw_1.getItemString(1,"enca_pasado") <> 'S' then
		messagebox('Atención','Debe hacer una nueva lista de empaque para terminar el Pedido Gracias....!!')
	end if
	This.Setredraw(true)
	Return
end if
// FALTA LA ACTUALIZACIÓN DEL DESGLOSE

//Acepta el texto actual
ldw_1.Accepttext()
ldw_2.Accepttext()

/*Guarda el Detalle*/

if ldw_2.RowCount() > 0 then	
	ls_codigo_producto = ldw_2.Getitemstring(ldw_2.Rowcount(),"empa_codigo_producto") 
	if trim(ls_codigo_producto) = '' or isnull(ls_codigo_producto) then
		ldw_2.Deleterow(ldw_2.Rowcount())
	end if
End if	

	ll_update2 =ldw_2.update()			//DETALLE
	
	if ll_update2 = -1  then
		This.Setredraw(true)
		rollback using sqlca;
		messagebox("Atención","¡Error al Actualizar !")
		return
	end if


/*Guarda el Encabezado*/

	ll_update =ldw_1.update()		//ENCABEZADO
	if ll_update = 1 then	
		if ls_estatus = NewModified! then
			if wf_actualizar_secuencia() = -1 then
				rollback using sqlca;
				This.Setredraw(true)				
				return
			end if
		end if
	
		wf_modificar_barra() 	//Marca el Avance en la Barra de Progreso	al 20 %
	
		commit using sqlca;
		ib_cambio = false

		if is_fuente = 'PE' then
			tab_1.tabpage_2.dw_6.Retrieve(str.g_financiero, str.empresa, is_pedido, il_ann)
			tab_1.tabpage_1.dw_4.Retrieve(str.g_financiero, str.empresa, is_pedido, il_ann)
		else
			tab_1.tabpage_2.dw_6.Retrieve(str.g_financiero, str.empresa,is_pedido,il_ann,is_tipo)
			tab_1.tabpage_1.dw_4.Retrieve(str.g_financiero, str.empresa, is_pedido, il_ann, is_tipo)
		end if

		wf_habilita_tabs("S")  //Habilita los tabs
		
		messagebox("Atención","¡Actualización Exitosa !")
	elseif ll_update = -1 then
		rollback using sqlca;
		messagebox("Atención","¡Error al Actualizar !")		
	end if


if idw_proximo = ldw_2 then	//Si se encuentra en el Tabpage 2 (dw_2), adiciona una linea
	ib_adicionar = true			//Para que no se valla al final, cuando inserta
	This.TriggerEvent("ue_adicionar")	
end if

This.Setredraw(true)
end event

event closequery;//Override
integer  li_resultado
datawindow ldw_1, ldw_2
ldw_1 = tab_1.tabpage_1.dw_1
ldw_1 = tab_1.tabpage_2.dw_2

dwitemstatus  ls_estatus1, ls_estatus2

If ib_cambio then	
	
	li_resultado = gf_mensaje("","Desea Salvar La Lista de Empaque Actual ?",4,1,"E")
	
	choose case li_resultado
		case 1
			this.TriggerEvent("ue_aceptar")
		case 3
			return 1
	end choose
	
	ib_cambio = false
	
end if
end event

event ue_eliminar;//OVERRIDE

This.Setredraw(false)
string  ls_codigo_producto
integer li_respuesta,li_linea
Boolean ab_borro

If tab_1.tabpage_1.dw_1.getItemNumber(1,"enca_pase_fact") = 1 or tab_1.tabpage_1.dw_1.getItemString(1,"enca_pasado") = 'S' then
	messagebox('Atención','Esta lista de Empaque no puede ser Eliminada porque ya fue pasada a factura')
	If tab_1.tabpage_1.dw_1.getItemString(1,"enca_pasado") <> 'S' then
		messagebox('Atención','Debe hacer una nueva lista de empaque para terminar el Pedido Gracias....!!')
	end if
	Return
end if

li_respuesta = gf_mensaje("","Esta Seguro de Querer Eliminar este Registro ? "+"~n ~n"+"Los Datos Serán Grabados Automáticamente ", 2, 2 , "E") 
	
if li_respuesta = 2 then 
	this.Setredraw(true)		
	Return
end if


if idw_proximo.rowcount() > 0 then
	
  //Reestaura las cantidades eliminadas del detalle, al dw4
  if idw_proximo = tab_1.tabpage_2.dw_2 then
	
		// Elimina el detalle de los rollos en fademtel
		li_linea = idw_proximo.GetItemNumber(idw_proximo.getRow(),"empa_linea")
		wf_eliminar_detalle(li_linea,idw_proximo.Getrow(),ab_borro)
		
		If ab_borro = false then
			gf_mensaje("","No se Pudo borrar el detalle de los capturado, ...!!",1,1,"E")
			this.Setredraw(true)				
			return
		end if
		
		if wf_reestaurar_cant_eliminadas(idw_proximo, idw_proximo.getrow()) = -1 then
			gf_mensaje("","No se Pudo Reestaurar la Cantidad Asignada, Verifique ...!!",1,1,"E")
			this.Setredraw(true)				
			return
		end if
  end if
	
	if idw_proximo = tab_1.tabpage_2.dw_2 and idw_proximo.Getrow() <> idw_proximo.Rowcount() then
		ib_adicionar = true				//Para que no se valla al final, cuando inserta
	end if
	
	
	idw_proximo.deleterow(idw_proximo.getrow())		
	
	if idw_proximo = tab_1.tabpage_2.dw_2 then
	 
		
		if idw_proximo.RowCount() > 0 then	
		  //Recibe el Codigo del Producto
	 	  ls_codigo_producto = idw_proximo.Getitemstring(idw_proximo.Rowcount(),"empa_codigo_producto") 	  
			if trim(ls_codigo_producto) = '' or isnull(ls_codigo_producto) then
				idw_proximo.Deleterow(idw_proximo.Rowcount())
			end if
		End if	
		//Setea el numero de linea a los registros del detalle y las cantidades asignadas
		wf_setear_lineas_y_cantidades(idw_proximo)		
				
	End if	


	if idw_proximo.Update() <> -1 then
		commit ;								
	else
		rollback ;
		gf_mensaje("","Error al Actualizar Eliminación "+sqlca.sqlerrtext,1,1,"E")
	
		//Si adicionó, que setee la barra en 0 %
		ole_2.object.value = 0
		This.Setredraw(true)
		return
	end if
	
else 
	messagebox("Atención","No hay registros para borrar!")	
end if

this.Triggerevent("ue_adicionar")

if tab_1.tabpage_2.dw_2 = idw_proximo and tab_1.tabpage_2.dw_2.rowcount() = 1 then
	tab_1.tabpage_2.cb_2.visible = true //Para que pueda pasar todos los articulos
end if

This.Setredraw(true)
end event

event timer;st_microhelp.visible = false
str.frame.Setmicrohelp("")
end event

event ue_print;If right(tab_1.Tabpage_3.dw_3.DataObject,12) = 'textiles_det' then
	openwithParm(w_dw_Print_options,tab_1.Tabpage_3.dw_8)
else
	openwithParm(w_dw_Print_options,tab_1.Tabpage_3.dw_3)
end if
If Message.DoubleParm = -1 Then Return
//**************Segmento agregado por HGN 28/03/2000********************//
		
//	If is_win9598_winnt='win9598' then
//		// Función para seleccionar la impresora
//		If wf_selec_printer(tab_1.Tabpage_3.dw_3) = false then
//			messagebox("","Selección de impresora Cancelada")
//			this.triggerevent("close")
//			return 
//		end If
//	end if
//**********************************************************************//
tab_1.Tabpage_3.dw_3.object.empresanom.expression = "'"+gf_dg_nombre_empresa()+"'"
If right(tab_1.Tabpage_3.dw_3.DataObject,11) = 'textilesdet' or &
	right(tab_1.Tabpage_3.dw_3.DataObject,9) = 'visiondet' then
	If  pos(upper(str.nombre_empresa),'TEXTILES') > 0  Then	
		tab_1.Tabpage_3.dw_3.SetSort("fadempaq_empa_bulto_fin A")
		tab_1.Tabpage_3.dw_3.Sort()
	end if
	tab_1.Tabpage_3.dw_8.Print(True)
else
	tab_1.Tabpage_3.dw_3.Print(True)
end if

end event

event resize;call super::resize;Long ll_dw_ancho,ll_dw_alto
st_1.y = newheight - (st_1.height + 10)

//tab_1.tabpage_3.cbx_imprime_monto.y = st_1.y 
end event

type tab_1 from w_fa_padre_tab`tab_1 within w_fa_man_packing_list_x
integer x = 9
integer y = 0
integer width = 2811
integer height = 1600
integer taborder = 0
integer textsize = -8
fontcharset fontcharset = ansi!
boolean boldselectedtext = true
end type

event tab_1::selectionchanged;// OverRide

string		ls_win, ls_nomemp
Datawindow	ldw_3

ldw_3 = tab_1.tabpage_3.dw_3

if not isvalid(m_fa_principal) then
	iw_this.changemenu(m_fa_principal)
	wf_botones()
end if

// Opción de mostrar foto de Producto

	If (newindex = 2 And tab_1.tabpage_2.dw_2.Rowcount() > 0) Then
		m_fa_principal.m_edicin.m_verfoto.enabled = True
	Else
		m_fa_principal.m_edicin.m_verfoto.enabled = False
	End If

ii_nex_tab = newindex

choose case newindex
	case 1		//DW DEL ENCABEZADO DEL PACKING
		idw_proximo = tab_1.tabpage_1.dw_1
		m_fa_principal.m_edicin.m_busqueda.enabled=true //Habilita el boton de busqueda		
	case 2		//DW DEL DETALLE DEL PACKING				
		idw_proximo = tab_1.tabpage_2.dw_2
		m_fa_principal.m_edicin.m_busqueda.enabled=false //Deshabilita el boton de busqueda
		
		if idw_proximo.Rowcount() > 0 then
			//Preguntar por los estatus y los codigos, para recuperar o no
			is_empa_det = idw_proximo.Getitemstring(1,"empa_lista_empaque")
			il_ann_det  = idw_proximo.GetitemNumber(1,"empa_ann")
			
			//Si el detalle es distinto que el encabezado
			if is_empaque+string(il_ann_empa) <> is_empa_det+string(il_ann_det) then
				if idw_proximo.Retrieve(str.g_financiero, str.empresa, is_empaque,il_ann_empa) < 1 then
					//Si no recupero nada, que adicione una linea en el detalle
					iw_this.TriggerEvent("ue_adicionar")
					tab_1.tabpage_2.cb_2.visible = true //Para que pueda pasar todos los articulos
				end if
			end if
			
		else
			if idw_proximo.Deletedcount() < 1 then
				if idw_proximo.Retrieve(str.g_financiero, str.empresa, is_empaque,il_ann_empa ) < 1 then
					//Si no recupero nada, que adicione una linea en el detalle
					iw_this.TriggerEvent("ue_adicionar")
					tab_1.tabpage_2.cb_2.visible = true //Para que pueda pasar todos los articulos					
				end if
			end if
		end if

		idw_proximo.Setfocus()
		idw_proximo.SetColumn(1)
		
	case 3	
		m_fa_principal.m_edicin.m_busqueda.enabled=false //Deshabilita el boton de busqueda
		if is_fuente = 'PE' then
		 if ldw_3.dataobject = '' or isnull(ldw_3.dataobject) or ldw_3.dataobject <> "dw_ma_fa_imp_pedi_pack" then
			if str_pedi.datawindow = '' or isnull(str_pedi.datawindow) then		
				ldw_3.DataObject = "dw_ma_fa_imp_pedi_pack"
			else
				str_pedi.datawindow = trim(str_pedi.datawindow)				
				ldw_3.DataObject = str_pedi.datawindow
			end if	
		 end if	
 	  else 
		 if ldw_3.dataobject = '' or isnull(ldw_3.dataobject) or ldw_3.dataobject <> "dw_ma_fa_imp_fact_pack" then
			if str_pedi.datawindow2 = '' or isnull(str_pedi.datawindow2) then		
				ldw_3.DataObject = "dw_ma_fa_imp_fact_pack"
			else
				str_pedi.datawindow2 = trim(str_pedi.datawindow2)				
				ldw_3.DataObject = trim(str_pedi.datawindow2)
			end if	
		 end if	
			
	  end if		

		ldw_3.settransobject(sqlca)
		
		If w_fa_fondo.str_para.lista_emp_especial = 1 then
			tab_1.tabpage_3.dw_8.Reset()
			tab_1.tabpage_3.dw_8.x =tab_1.tabpage_3.dw_3.x
			tab_1.tabpage_3.dw_8.y =tab_1.tabpage_3.dw_3.y
			tab_1.tabpage_3.dw_8.height =tab_1.tabpage_3.dw_3.height
			tab_1.tabpage_3.dw_8.width =tab_1.tabpage_3.dw_3.width
			
			ldw_3.visible = false
			tab_1.tabpage_3.dw_8.visible = true
			/*Hace visible checkbox para mostrar o no el precio y monto*/
			tab_1.tabpage_3.cbx_imprime_monto.visible = true
			tab_1.tabpage_3.cbx_imprime_monto.checked = true
			tab_1.tabpage_3.cbx_imprime_monto.Triggerevent("clicked")
		else
			ldw_3.visible = true
			tab_1.tabpage_3.dw_8.visible = false
			tab_1.tabpage_3.cbx_imprime_monto.checked = false
			/*Hace invisible checkbox para mostrar o no el precio y monto*/
			tab_1.tabpage_3.cbx_imprime_monto.visible = false
		end if
		
		ldw_3.Retrieve(str.g_financiero,str.empresa,is_pedido,il_ann,is_empaque)
		ls_nomemp = gf_dg_nombre_empresa()
		ldw_3.object.empresanom.expression = "'"+ls_nomemp+"'"

		//* Script para la asignacion del tamaño de página ....
		Integer	li_largo,li_ancho
		li_largo = 5000	// largo
		li_ancho = 2375	// ancho
	
		If is_win9598_winnt='win9598' then
			gf_dg_tamano_pagina(li_largo,li_ancho,ldw_3)
		end If
		
		ldw_3.modify("datawindow.print.preview = 'yes'")
		ldw_3.modify('datawindow.print.preview.zoom = 100')
		
end choose

end event

type tabpage_1 from w_fa_padre_tab`tabpage_1 within tab_1
integer width = 2775
integer height = 1472
string text = "Empaque"
string picturename = "Custom088!"
long picturemaskcolor = 79741120
ole_1 ole_1
dw_4 dw_4
ole_3 ole_3
ole_5 ole_5
ole_4 ole_4
end type

on tabpage_1.create
this.ole_1=create ole_1
this.dw_4=create dw_4
this.ole_3=create ole_3
this.ole_5=create ole_5
this.ole_4=create ole_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_1
this.Control[iCurrent+2]=this.dw_4
this.Control[iCurrent+3]=this.ole_3
this.Control[iCurrent+4]=this.ole_5
this.Control[iCurrent+5]=this.ole_4
end on

on tabpage_1.destroy
call super::destroy
destroy(this.ole_1)
destroy(this.dw_4)
destroy(this.ole_3)
destroy(this.ole_5)
destroy(this.ole_4)
end on

type dw_1 from w_fa_padre_tab`dw_1 within tabpage_1
event ue_busqueda ( )
event ue_keydown pbm_dwnkey
event ue_postitem ( long row,  dwobject dwo,  string data )
event ue_microhelp pbm_nchittest
integer x = 23
integer y = 60
integer width = 1865
integer height = 1408
string dataobject = "dw_ma_fa_enca_packing"
boolean hscrollbar = true
end type

event dw_1::ue_busqueda;//Scrip para buscar los pedidos o las Facturas
Integer 				li_resp
String				ls_syntax
//str_dg_dynamic_find	lstr_df
Datawindow 	ldw_4, ldw_3, ldw_6, ldw_7


ldw_4 = tab_1.tabpage_1.dw_4
ldw_3 = tab_1.tabpage_3.dw_3
ldw_6	= tab_1.tabpage_2.dw_6
ldw_7 = tab_1.tabpage_2.dw_7


if wf_valida_cambios() = 1 then return

//NO TOCAR EL ORDEN DE LOS CAMPOS, NI LOS NOMBRES; YA QUE SE UTILIZAN PARA EXTRAER LOS CODIGOS
str_dg_dynamic_find	lstr_df

li_resp = gf_mensaje("","La Lista de Empaque Se Originó de PEDIDOS ?",4,1,"E")

if li_resp = 3 then return  //Si dio cancelar, que retorne

if li_resp = 1 then			//Si Viene de Pedidos

	is_fuente = "PE"
	is_campo_asignada			  = "dped_cant_asignada"
	lstr_df.texto_campo[1, 1] = "dgmterce.terc_descripcion"
	lstr_df.texto_campo[1, 2] = "Nombre"
	lstr_df.texto_campo[1, 3] = "dgmterce_terc_descripcion"
	lstr_df.texto_campo[1, 4] = "V"
	lstr_df.texto_campo[2, 1] = "fatempaq.enca_lista_empaque"
	lstr_df.texto_campo[2, 2] = "Lista Empaque"
	lstr_df.texto_campo[2, 3] = "fatempaq_enca_lista_empaque"
	lstr_df.texto_campo[2, 4] = "V"
	lstr_df.texto_campo[3, 1] = "fatempaq.enca_ann"
	lstr_df.texto_campo[3, 2] = "Año"
	lstr_df.texto_campo[3, 3] = "fatempaq_enca_ann"
	lstr_df.texto_campo[3, 4] = "V"
	lstr_df.texto_campo[4, 1] = "fatpedid.pedi_no_pedido"
	lstr_df.texto_campo[4, 2] = "No. Pedido"
	lstr_df.texto_campo[4, 3] = "fatpedid_pedi_no_pedido"
	lstr_df.texto_campo[4, 4] = "V"
	lstr_df.texto_campo[5, 1] = "dgmterce.terc_tercero"
	lstr_df.texto_campo[5, 2] = "Codigo"
	lstr_df.texto_campo[5, 3] = "dgmterce_terc_tercero"
	lstr_df.texto_campo[5, 4] = "V"
	lstr_df.texto_campo[6, 1] = "fatpedid.pedi_ann"
	lstr_df.texto_campo[6, 2] = "Año del Pedido"
	lstr_df.texto_campo[6, 3] = "fatpedid_pedi_ann"
	lstr_df.texto_campo[6, 4] = "I"
	lstr_df.tabla			= " fatempaq, fatpedid, dgmterce "
	lstr_df.tabla_where	= " WHERE ( fatempaq.enca_g_financiero = fatpedid.pedi_g_financiero ) and " + & 
								  "  ( fatempaq.enca_empresa = fatpedid.pedi_empresa ) and  " + & 
								  "  ( fatempaq.enca_no_pedido = fatpedid.pedi_no_pedido ) and  " + & 
								  "  ( fatempaq.enca_ann_pedido = fatpedid.pedi_ann ) and  " + & 
								  "  ( fatempaq.enca_fuente = '"+is_fuente+"' ) and  " + &								  
								  "  ( dgmterce.terc_tercero = fatpedid.pedi_cliente ) and  " + & 
								  "  ( fatempaq.enca_g_financiero = "+string(str.g_financiero)+" ) and "+&
								  "  ( fatempaq.enca_empresa = "+string(str.empresa)+" ) "
Else   //Si Viene de Facturas.
	
	is_fuente = "FA"
	is_campo_asignada			  = "facd_cant_asignada"
	lstr_df.texto_campo[1, 1] = "dgmterce.terc_descripcion"
	lstr_df.texto_campo[1, 2] = "Nombre"
	lstr_df.texto_campo[1, 3] = "dgmterce_terc_descripcion"
	lstr_df.texto_campo[1, 4] = "V"
	lstr_df.texto_campo[2, 1] = "fatempaq.enca_lista_empaque"
	lstr_df.texto_campo[2, 2] = "Lista Empaque"
	lstr_df.texto_campo[2, 3] = "fatempaq_enca_lista_empaque"
	lstr_df.texto_campo[2, 4] = "V"
	lstr_df.texto_campo[3, 1] = "fatempaq.enca_ann"
	lstr_df.texto_campo[3, 2] = "Año"
	lstr_df.texto_campo[3, 3] = "fatempaq_enca_ann"
	lstr_df.texto_campo[3, 4] = "V"
	lstr_df.texto_campo[4, 1] = "fatdiari.fact_no_pedido"
	lstr_df.texto_campo[4, 2] = "No. Pedido"
	lstr_df.texto_campo[4, 3] = "fatdiari_fact_no_pedido"
	lstr_df.texto_campo[4, 4] = "V"
	lstr_df.texto_campo[5, 1] = "dgmterce.terc_tercero"
	lstr_df.texto_campo[5, 2] = "Codigo"
	lstr_df.texto_campo[5, 3] = "dgmterce_terc_tercero"
	lstr_df.texto_campo[5, 4] = "V"
	lstr_df.texto_campo[6, 1] = "fatdiari.fact_tipo"
	lstr_df.texto_campo[6, 2] = "Por Tipo"
	lstr_df.texto_campo[6, 3] = "fatdiari_fact_tipo"
	lstr_df.texto_campo[6, 4] = "I"
	lstr_df.texto_campo[7, 1] = "fatdiari.fact_ann"
	lstr_df.texto_campo[7, 2] = "Año del Pedido"
	lstr_df.texto_campo[7, 3] = "fatdiari_fact_ann"
	lstr_df.texto_campo[7, 4] = "I"
	lstr_df.tabla			= " fatempaq, fatdiari, dgmterce "
	lstr_df.tabla_where	= " WHERE ( fatempaq.enca_g_financiero = fatdiari.fact_g_financiero ) and " + & 
								  "  ( fatempaq.enca_empresa = fatdiari.fact_empresa ) and  " + & 
								  "  ( fatempaq.enca_no_pedido = fatdiari.fact_no_pedido ) and  " + & 
								  "  ( fatempaq.enca_ann_pedido = fatdiari.fact_ann ) and  " + & 
								  "  ( fatempaq.enca_tipo = fatdiari.fact_tipo ) and " + &
								  "  ( fatempaq.enca_fuente = '"+is_fuente+"' ) and  " + &								  								  
								  "  ( dgmterce.terc_tercero = fatdiari.fact_cliente ) and  " + & 
								  "  ( fatempaq.enca_g_financiero = "+string(str.g_financiero)+" ) and "+&
								  "  ( fatempaq.enca_empresa = "+string(str.empresa)+" ) "
End if

OpenWithParm(w_dg_a_custom_find, lstr_df)

ls_syntax = Message.StringParm

	If Len(Trim(ls_syntax)) > 0 Then  //Si Selecciono Algun registro

			//Extrae el # de Pedido, Año y si es al por mayor o no de la Cadena ls_syntax
			is_empaque 	 = wf_extraer_no_empaque(ls_syntax)
			il_ann_empa	 = wf_extraer_ano_empa(ls_syntax)			
			is_cliente	 = wf_extraer_cliente(ls_syntax)
			
			wf_recuperar_packing()	// Recuperar la Informacion del Packing
			
			is_pedido	 	  = wf_extraer_pedido_old(ls_syntax)
			il_ann		 	  = wf_extraer_ann(ls_syntax)		
					
			ldw_7.retrieve(str.g_financiero, str.empresa, is_empaque, il_ann_empa)
		

			if is_fuente = 'PE' then
				If w_fa_fondo.str_para.lista_emp_especial = 1 then
					ldw_6.dataobject = "dw_ma_fa_cant_pedi_packing_disp_esp_det"
				else
					ldw_6.dataobject = "dw_ma_fa_pedi_desglose_packing_x"
				end if
				
				ldw_6.Settransobject(sqlca)														
				ldw_4.Dataobject = "dw_ma_fa_pedi_packing_tel"	// the same
				ldw_4.Settransobject(sqlca);
				ldw_4.Retrieve(str.g_financiero, str.empresa, is_pedido, il_ann)
				ldw_3.DataObject = str_pedi.datawindow
				ldw_3.SetTransObject(sqlca)
			else
				is_tipo = wf_extraer_pormayor(ls_syntax)	//Extrae el tipo de Factura			
				If w_fa_fondo.str_para.lista_emp_especial = 0 then
					ldw_6.dataobject = "dw_ma_fa_fact_desglose_packing_x"  //Ready
				else                   
					ldw_6.dataobject = "dw_ma_fa_cant_fact_packing_disp_esp_det"
				end if

				ldw_6.Settransobject(sqlca)				
				ldw_4.Dataobject = "dw_ma_fa_fact_packing_tel"
				ldw_4.Settransobject(sqlca)
				ldw_4.Retrieve(str.g_financiero, str.empresa, is_pedido, il_ann, is_tipo)
				ldw_3.DataObject = str_pedi.datawindow2
				ldw_3.SetTransObject(sqlca)			
			end if

			ib_cambio = false		// No se han hecho cambios, solo está recuperando
	
			
	End if
		
end event

event dw_1::ue_keydown;//Llama al Evento de la Ventana Principal
//iw_this.Trigger Event key(key, keyflags)
iw_this.TriggerEvent("key")
end event

event dw_1::ue_postitem;string   ls_col
datetime ldt_fecha

ls_col = This.Getcolumnname()

ib_cambio = true

setnull(ldt_fecha)

choose case ls_col
	case "enca_recolectado"
		wf_modificar_barra()		
		if data = 'N' then
			this.Setitem(row,"enca_fecha_recolectado",ldt_fecha)
		else
			this.Setitem(row,"enca_fecha_recolectado",gf_fecha_serv())			
		end if
	case "enca_empacado"	
		wf_modificar_barra()				
		if data = 'N' then
			this.Setitem(row,"enca_fecha_empacado",ldt_fecha)
		else		
			this.Setitem(row,"enca_fecha_empacado",gf_fecha_serv())		
		end if
	case "enca_despachado"
		wf_modificar_barra()			
		if data = 'N' then
			this.Setitem(row,"enca_fecha_despachado",ldt_fecha)
		else		
			this.Setitem(row,"enca_fecha_despachado",gf_fecha_serv())		
		end if
end choose
end event

event dw_1::ue_microhelp;//Override
// Ayuda en el Microhelp

String	ls_objeto, ls_row

ls_objeto = GetObjectAtPointer ()
ls_row	 = Right (ls_objeto, Len (ls_objeto) - Pos (ls_objeto, '~t') + 1)
ls_objeto = Left (ls_objeto, Pos (ls_objeto, '~t') - 1)

is_last_row = integer (ls_row)
//str.frame.Setmicrohelp("Antes de comparar, columna y objeto "+is_last_column +"  "+ls_objeto)
If is_last_column = ls_objeto Then 
//	str.frame.Setmicrohelp("Entro al return, columna y objeto "+is_last_column +"  "+ls_objeto)
//	st_microhelp.Visible = FALSE	
	Return
end if

is_last_column = lower (ls_objeto)

integer	li_x, li_y

li_x	 = str.frame.GetActiveSheet ().PointerX () 
li_y	 = str.frame.GetActiveSheet ().PointerY ()

choose case is_last_column 
	case "sube"
//		If st_microhelp.Visible Then Return
//		st_microhelp.Move (li_x - 1700, li_y  + 30)
//		st_microhelp.Text 	= "Haga click para Subir el Registro o pulse << Shift+Flecha Arriba >>"
//		st_microhelp.Width 	= Len (st_microhelp.Text) * 28
//		st_microhelp.Visible = TRUE
//
//	case "baja"
//		If st_microhelp.Visible Then Return
//		st_microhelp.Move (li_x - 1700, li_y  + 30)
//		st_microhelp.Text 	= "Haga click para Bajar el Registro o pulse << Shift+Flecha Abajo >>"
//		st_microhelp.Width 	= Len (st_microhelp.Text) * 28
//		st_microhelp.Visible = TRUE
//		
//	case	"empa_cubicaje"	
//		If st_microhelp.Visible Then Return
//		st_microhelp.Move (li_x , li_y)
//		st_microhelp.Text 	= "Dar Doble Click o F3 para Desglozar Cubicaje."
//		st_microhelp.Width 	= Len (st_microhelp.Text) * 28
//		st_microhelp.Visible = TRUE
//		
//	case	"empa_codigo_producto"
//		If st_microhelp.Visible Then Return
//		st_microhelp.Move (li_x, li_y)
//		st_microhelp.Text 	= "Dar Doble Click o F3 para Buscar Productos"
//		st_microhelp.Width 	= Len (st_microhelp.Text) * 28
//		st_microhelp.Visible = TRUE
//
	case else
		st_microhelp.Visible = FALSE
		
end choose

//timer(18)
end event

event dw_1::itemfocuschanged;gf_micro_ayuda(this)
end event

event dw_1::itemchanged;this.Post event ue_postitem(row, dwo, data)
end event

event dw_1::editchanged;ib_cambio = true
end event

type gb_1 from w_fa_padre_tab`gb_1 within tabpage_1
integer x = 9
integer y = 0
integer width = 2761
integer height = 1472
end type

type tabpage_2 from w_fa_padre_tab`tabpage_2 within tab_1
integer width = 2775
integer height = 1472
string text = "Detalle"
string picturename = "EditObject!"
long picturemaskcolor = 79741120
gb_2 gb_2
dw_6 dw_6
dw_7 dw_7
cb_2 cb_2
dw_5 dw_5
st_2 st_2
st_3 st_3
st_4 st_4
end type

on tabpage_2.create
this.gb_2=create gb_2
this.dw_6=create dw_6
this.dw_7=create dw_7
this.cb_2=create cb_2
this.dw_5=create dw_5
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.dw_6
this.Control[iCurrent+3]=this.dw_7
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.dw_5
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_4
end on

on tabpage_2.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.dw_6)
destroy(this.dw_7)
destroy(this.cb_2)
destroy(this.dw_5)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
end on

type dw_2 from w_fa_padre_tab`dw_2 within tabpage_2
event ue_keydown pbm_dwnkey
event ue_enter pbm_dwnprocessenter
event type long ue_postitem ( long row,  dwobject dwo,  string data )
integer x = 18
integer y = 44
integer width = 2734
integer height = 1140
string dataobject = "dw_ma_fa_deta_packing_tel"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = false
end type

event dw_2::ue_keydown;//Llama al Evento de la Ventana Principal
dwobject dwo //Solo para rellenar los Argumentos
Datawindow ldw_2

Long	ll_row, ll_inserto, ll_row1,ll_rowcount
Integer	li_linea, li_max = 1, li_column
String	ls_producto
ldw_2 = tab_1.tabpage_2.dw_2
ll_row = ldw_2.GetRow()

If keyDown(Keycontrol!) and keyDown(KeyShift!) Then
	iw_this.TriggerEvent("key")
Else
	choose case key
		case Keyf3!
			choose case this.Getcolumnname() 
				case "empa_codigo_producto" 					
					this.trigger event doubleclicked(1,1,this.Getrow(),dwo)	//Abre la ventana de productos
				case "empa_cubicaje"					
					this.trigger event doubleclicked(1,1,this.Getrow(),dwo)	//Abre la ventana del Cubicaje
				case "empa_canti"	
					this.trigger event doubleclicked(1,1,this.Getrow(),dwo)	//Abre la ventana del desglose					
				case "empa_fraccion"	
					this.trigger event doubleclicked(1,1,this.Getrow(),dwo)	//Abre la ventana del desglose
			end choose

		case Keyf5!
			//	

			/*Valida si el status está trabajado para impedir que se copie registro de este*/	
			If ldw_2.GetItemString(ll_row,"empa_status") ='T' then //Trabajado
				messagebox('Atención ','Este registro ya está trabajo, no puede hacer copias de él ...!!')
				return
			end if
			
			if ll_row > 0   then
				ls_producto = ldw_2.GetItemstring(ll_row,'empa_codigo_producto')
				if IsNull(ls_producto) then ls_producto =''

				If ls_producto <> '' then
					ll_inserto=ldw_2.RowsCopy(ll_row,ll_row, primary!, ldw_2, 1, primary!)
					If ll_inserto > 0 then
				
						ldw_2.SetItem(1,'empa_cubicaje',0)
						ldw_2.SetItem(1,'empa_peso',0)
						ldw_2.SetItem(1,'empa_canti',0)
						ldw_2.SetItem(1,'empa_fraccion',0)
						ldw_2.SetItem(1,'empa_cantidad',0)
						ldw_2.SetItem(1,'empa_status','R')
						ldw_2.SetItem(1,"validado",1)	//Para saber que el Articulo está correcto
						
						// Identitica registro creado por F5 para que no setee
						// la cantidad del registro padre 
						ldw_2.SetItem(1,'fadempaq_f5',1)


						for ll_row1 = 1 to ldw_2.rowcount()
							li_linea = ldw_2.GetItemNumber(ll_row1,"empa_linea")
							If li_linea > li_max then
								li_max = li_linea
							end if
						Next
						li_max ++
						If IsNull(li_max) then li_max = 1
						
						ldw_2.SetItem(1,'empa_linea',li_max)
						ldw_2.SetItem(1,"index",li_max)
						
						ldw_2.ScrollTorow(1)
					end if
					
				end if
			end if
		case Keyf6!
			str_desglose.empaque	   =  tab_1.tabpage_1.dw_1.GetItemString(1,'enca_lista_empaque')
		   str_desglose.ann_empa   =  tab_1.tabpage_1.dw_1.GetItemNumber(1,'enca_ann')
			str_desglose.vienede    = tab_1.tabpage_1.dw_1.GetItemString(1,'enca_fuente')
		   str_desglose.devuelve='0'
			
			
			If str_desglose.vienede ='PE' then
				OpenWithParm(w_fa_man_libera_reserva_pend_cb,str_desglose)
	
				str_desglose = message.PowerObjectParm
		
				if str_desglose.devuelve='1' then	//Si es 1 significa que actualizó
					this.Retrieve(str.g_financiero, str.empresa, str_desglose.empaque,str_desglose.ann_empa) 
				end if
			END IF
		case  Keyenter!

	end choose
	
	If keyDown(KeyUpArrow!) and this.Getcolumnname() = "empa_codigo_producto" then
		This.Accepttext()
		if ib_modificado then
			this.Post event ue_postitem(this.Getrow(),dwo,this.getitemstring(this.getrow(),"empa_codigo_producto"))
			ib_modificado = false
		end if	
	ElseIf	keyDown(KeyDownArrow!) and This.Getrow() = this.Rowcount() then //Si esta en la ultima linea, adiciona
			iw_this.Triggerevent("ue_adicionar")
	End if

	If Keydown(KeyShift!) and keyDown(KeyUpArrow!) then //Teclas para desplazar el registro hacia arriba
		wf_sube_o_baja("S")
		ib_cambio = true
		return 2
	Elseif Keydown(KeyShift!) and keyDown(KeyDownArrow!) then //Teclas para desplazar el registro hacia abajo
		wf_sube_o_baja("B")			
		ib_cambio = true		
		return 2
	End if	
	
End If


end event

event dw_2::ue_enter;//Al dar Enter, que avance
integer	li_columna = 1

li_columna = this.Getcolumn()
is_col = This.GetColumnName()		//Selecciona la columna, que será utilizada en el postitem
											 
if li_columna = 7 then				//Si esta en la Cantidad y da enter, va al bulto inicial
	if this.getrow() = this.rowcount() then
		iw_this.triggerevent("ue_adicionar")
	else
		This.scrolltorow(this.getrow() + 1)
	end if
	This.SetColumn(1)					 
else
	This.SetColumn(li_columna + 1) //Va a la Siguiente Columna
end if

return 2  //NO QUITAR, Para que no siga al ROWFOCUSCHANGED por default
end event

event dw_2::ue_postitem;DataWindow  ldw_4, ldw_5, ldw_6
string 		ls_col = '', ls_expresion, ls_bodega, ls_ubicacion, ls_uni_peso, ls_descrip,&
				ls_unidad
long   		ll_row = 0, ll_row2 = 1, ll_total,  ll_fraccion
decimal		ld_cubicaje, ld_peso
integer		li_linea_ori, li_resultado, li_sqlcode
Decimal		ld_cantidad, ld_asigna_linea, ld_disponible, ld_asignada

ldw_4    = tab_1.tabpage_1.dw_4
ldw_5    = tab_1.tabpage_2.dw_5
ldw_6		= tab_1.tabpage_2.dw_6

ll_total = ldw_4.RowCount()

choose case is_col  //is col se carga en el ue_enter, en el editchanged y en wf_setear_cod_prod()
		
	case	"empa_codigo_producto"
	//compute_2	
//		ls_expresion = "codigo_item = '"+data+"'"+" and cant_disponible > 0 "
		ls_expresion = "codigo_item = '"+data+"'"+" and compute_2 > 0 "

		ll_row	= ldw_4.Find(ls_expresion, ll_row2, ll_total)
		
		if ll_row > 0 then
			
			ll_row2  = ll_row
			
			 if not ib_desde_ayuda then  //Para saber si el articulo, fue seleccionado desde la ayuda			 
				 								  //Se carga em wf_setear_cod_prod() desde ayuda
				 if ll_row2 <> ll_total then
				
					ll_row	= ldw_4.Find(ls_expresion,ll_row2 + 1,ll_total)
			
					if ll_row > 0 then
						////////Abrir ventana de busqueda, filtrado por argumento o producto
						gf_mensaje("","Existen más de un Registro para Dicho Artículo, Seleccione Uno.",1,1,"E")
						dwobject dwob		
						this.Setcolumn(3)
						return 2
						
					end if
				
				 end if
				 
			 else	 							
				//Busca el registro segun la linea encontrada en La Ayuda de Articulos
				if is_fuente = 'PE' then
				  ls_expresion = "dped_linea = "+string(ii_linea)+" and compute_2 > 0 "	
				else
				  ls_expresion = "facd_linea = "+string(ii_linea)+" and compute_2 > 0 "
				end if
				
				ll_row	= ldw_4.Find(ls_expresion, ll_row2, ll_total)
				
				if ll_row > 0 then

				 	ll_row2 = ll_row			// PARA QUE BUSQUE EL ARTICULO DE LA LINEA SELECCIONADA EN AYUDA
				
	 			 	ib_desde_ayuda = false  // SE CARGAN EN WF_SETEAR_COD_PROD()
					  
				else
					//Si no encontro el articulo seleccionado de la ayuda
					gf_mensaje("","Éste Artículo no Existe o Ya Fué Asignado en su Totalidad, Verifique ..?",1,1,"E")
					This.SetItem(row,"empa_codigo_producto","")	//Blanqueo el codigo									
					if wf_blanquea_registro(This,row) = 1 then //Si Estaba OK y se modifico, lo blanquea
						This.SetItem(row,"validado",0)	//Para saber que el Articulo está incorrecto		
						This.SetItem(row,"desglose",0)
					end if			
					This.Setcolumn(3)
					return 2					
								
				end if
					
			 end if

		  if is_fuente = 'PE' Then	//Si la fuente es de pedidos
				//Setear los Datos del Articulo								
				ls_bodega    = ldw_4.GetitemString(ll_row2,"dped_bodega")
				ls_ubicacion = ldw_4.GetitemString(ll_row2,"dped_ubicacion")
				ld_cubicaje	 = ldw_4.GetitemNumber(ll_row2,"dped_cubicaje")
				ld_peso		 = ldw_4.GetitemNumber(ll_row2,"dped_peso")
				ls_uni_peso  = ldw_4.GetitemString(ll_row2,"dped_unidad_peso")
				ls_descrip	 =	ldw_4.GetitemString(ll_row2,"prod_descripcion")
				ls_unidad	 = ldw_4.GetitemString(ll_row2,"dped_unidad_venta")				
				li_linea_ori = ldw_4.GetitemNumber(ll_row2,"dped_linea")
				ld_disponible= ldw_4.GetitemNumber(ll_row2,"compute_2")									

				//Seteo 0 a lo disponible, ya que estoy asignando todo por default,
				//Al Modificar la Cantidad, alimienta lo disponible y rebaja lo asignado

				ldw_4.SetItem(ll_row2,"cant_disponible",0)
				ld_asignada = ldw_4.GetitemNumber(ll_row2,"dped_cant_asignada")
				ldw_4.SetItem(ll_row2,"dped_cant_asignada",ld_asignada + ld_disponible)

				ld_cantidad = This.GetItemNumber(row,"empa_canti")
				
				//Función que convierte lo asignado y disponible en cantidades y fracciones
			   wf_convierte_a_unidades(ldw_4,ll_row2,ls_unidad,ld_asignada + ld_disponible,0)
				
				This.SetItem(row,"empa_bodega",ls_bodega)
				This.SetItem(row,"empa_ubicacion",ls_ubicacion)
				This.SetItem(row,"empa_cubicaje",ld_cubicaje)				
				This.SetItem(row,"empa_peso",ld_peso)								
				This.SetItem(row,"empa_unidad_peso",ls_uni_peso)
				This.SetItem(row,"prod_descripcion",ls_descrip)
				This.SetItem(row,"empa_unidad",ls_unidad)
				
				This.SetItem(row,"empa_canti",ld_cantidad)
				This.SetItem(row,"empa_cantidad",ld_cantidad)
				This.SetItem(row,"empa_linea_original",li_linea_ori)				
				
				This.SetItem(row,"validado",1)	//Para saber que el Articulo está correcto
				
				This.SetColumn(4)
				
			else
				//Setear los Datos del Articulo							
				ls_bodega    = ldw_4.GetitemString(ll_row2,"facd_bodega")
				ls_ubicacion = ldw_4.GetitemString(ll_row2,"facd_ubicacion")
				ld_cubicaje	 = ldw_4.GetitemNumber(ll_row2,"facd_cubicaje")
				ld_peso		 = ldw_4.GetitemNumber(ll_row2,"facd_peso")
				ls_uni_peso  = ldw_4.GetitemString(ll_row2,"facd_unidad_peso")
				ls_descrip	 =	ldw_4.GetitemString(ll_row2,"prod_descripcion")
				ls_unidad	 = ldw_4.GetitemString(ll_row2,"facd_unidad_venta")				
				li_linea_ori = ldw_4.GetitemNumber(ll_row2,"facd_linea")
				ld_disponible= ldw_4.GetitemNumber(ll_row2,"compute_2")									
				//Seteo 0 a lo disponible, ya que estoy asignando todo por default,
				//Al Modificar la Cantidad, alimienta lo disponible y rebaja lo asignado
				ldw_4.SetItem(ll_row2,"cant_disponible",0)
				ld_asignada = ldw_4.GetitemNumber(ll_row2,"facd_cant_asignada")				
				ldw_4.SetItem(ll_row2,"facd_cant_asignada",ld_asignada + ld_disponible)

				ld_cantidad = This.GetItemNumber(row,"empa_canti")
				
			
				//Función que convierte lo asignado y disponible en cantidades y fracciones
			   wf_convierte_a_unidades(ldw_4,ll_row2,ls_unidad, ld_asignada + ld_disponible,0)
				
				This.SetItem(row,"empa_bodega",ls_bodega)
				This.SetItem(row,"empa_ubicacion",ls_ubicacion)
				This.SetItem(row,"empa_cubicaje",ld_cubicaje)				
				This.SetItem(row,"empa_peso",ld_peso)								
				This.SetItem(row,"empa_unidad_peso",ls_uni_peso)
				This.SetItem(row,"prod_descripcion",ls_descrip)
				This.SetItem(row,"empa_unidad",ls_unidad)

				This.SetItem(row,"empa_canti",ld_cantidad)
				This.SetItem(row,"empa_cantidad",ld_cantidad)
				This.SetItem(row,"empa_linea_original",li_linea_ori)
				
				This.SetItem(row,"validado",1)	//Para saber que el Articulo está correcto
				
				This.SetColumn(4)				
				
			end if	

			//Dirige el cursor al producto actual
			wf_scroll_a_disponibles(ldw_5, data , li_linea_ori)
			
		else
			
			gf_mensaje("","Éste Artículo no Existe o Ya Fué Asignado en su Totalidad, Verifique ..?",1,1,"E")
			This.SetItem(row,"empa_codigo_producto","")	//Blanqueo el codigo									
			if wf_blanquea_registro(This,row) = 1 then //Si Estaba OK y se modifico, lo blanquea
				This.SetItem(row,"validado",0)	//Para saber que el Articulo está incorrecto		
				This.SetItem(row,"desglose",0)
			end if			
			This.Setcolumn(3)
			return 2
			
		end if
		
		//Para que no pueda pasar todos los articulos del detalle		
		if row >= 1 then	
			tab_1.tabpage_2.cb_2.visible = false 
		end if		
	case	"empa_canti"
			is_viene_de ='POSTITEM'
			li_resultado = wf_validar_cantidad(This, row, "CANTI")
			if li_resultado = -1 then 
				this.Setcolumn(6)
				return 2	
			end if			

end choose

return 0
end event

event dw_2::itemfocuschanged;
String 		ls_producto
Long			ll_row
Datawindow  ldw_4
ldw_4 		= tab_1.tabpage_1.dw_4

gf_micro_ayuda(this)
Choose case This.Getcolumnname() 
	case	"empa_codigo_producto" 
	
		ls_producto = This.GetitemString(row,"empa_codigo_producto")
		ll_row = ldw_4.Find("codigo_item = '"+ls_producto+"'",1,ldw_4.Rowcount())	
		if ll_row > 0 then
			is_cod_prod = ls_producto
		end if
		
	case	"empa_canti"
//		id_canti    = this.GetitemNumber(row,"empa_canti")

	case	"empa_fraccion"
		il_fraccion = this.GetitemNumber(row,"empa_fraccion")	
end Choose
end event

event dw_2::doubleclicked;if Row <= 0 then return

string 	ls_col,ls_codigo_producto
long		ll_recupero,ll_row
Integer	li_getrow, li_resultado, li_resp
Boolean	ab_borro,lb_salvo =true
Decimal  ld_cant_original
dwItemStatus l_status
Datawindow	ldw_6,ldw_4,ldw_1

ldw_6 = tab_1.tabpage_2.dw_6
ldw_4 = tab_1.tabpage_1.dw_4
ldw_1 = tab_1.tabpage_1.dw_1

ls_col = this.Getcolumnname()

choose case ls_col
		
	case "empa_codigo_producto"
		str_empaque.fuente	= tab_1.tabpage_1.dw_1.Getitemstring(tab_1.tabpage_1.dw_1.Getrow(),"enca_fuente")
		str_empaque.titulo   = "Productos del Pedido "+is_pedido+"/"+string(il_ann)+" del Cliente "+is_cliente
		//Que envíe el codigo a filtrar, si el articulo no se ha validado
		if this.GetitemNumber(row,"validado") = 1 then
			str_empaque.producto = ""
			str_empaque.devuelve = false
		else
			str_empaque.producto = this.gettext() // this.Getitemstring(row,"empa_codigo_producto")
			str_empaque.devuelve = true			
		end if
		
		OpenWithParm(w_fa_co_productos_packing_cb,str_empaque)		
		
	case "empa_cubicaje"
		
		str_cubicaje.largo   	 = This.GetItemNumber(This.Getrow(),"empa_largo")
		str_cubicaje.alto    	 = This.GetItemNumber(This.Getrow(),"empa_alto")
		str_cubicaje.ancho		 = This.GetItemNumber(This.Getrow(),"empa_ancho")			
		str_cubicaje.cubicaje	 = This.GetItemNumber(This.Getrow(),"empa_cubicaje")
		str_cubicaje.unidad_cub  = This.GetItemString(This.Getrow(),"empa_unidad_cubicaje")
		str_cubicaje.unidad_comp = This.GetItemString(This.Getrow(),"empa_uni_cubic_compuesto")

		OpenWithParm(w_fa_man_cubic_packing,str_cubicaje)

	case	"empa_canti"
		
		str_desglose.pedido		=	is_pedido
		str_desglose.ann			=	il_ann
		
		if is_fuente	=	"FA" then
			str_desglose.tipo	=	is_tipo		
		end if
		
		str_desglose.linea_ori	=	this.getitemnumber(row,"empa_linea_original")		
		str_desglose.data			=	0		//Para que recupere con retrieve
		str_desglose.titulo		=  wf_titulo_desglose(this, row)+' Lin. '+string(row)
		str_desglose.vienede		=  is_fuente
		str_desglose.producto   =  this.getitemString(row,"empa_codigo_producto")
		
		li_getrow  = row
		
		str_desglose.empaque		=	tab_1.tabpage_1.dw_1.GetItemString(1,'enca_lista_empaque')
		str_desglose.ann_empa   =  tab_1.tabpage_1.dw_1.GetItemNumber(1,'enca_ann')

		is_empaque = str_desglose.empaque

		str_desglose.linea		=	this.getitemnumber(row,"empa_linea")

		str_desglose.cantidad	=	this.getitemnumber(row,"empa_canti")
		
		// Guardo la cantidad original
		ld_cant_original = str_desglose.cantidad
		/**/
		lb_salvo =true
		
		l_status = this.GetItemStatus(this.getrow(),"empa_canti",Primary!) 

		/* Valida si lista de empaque fue pasada a factura */
		If ldw_1.getItemNumber(ldw_1.Getrow(),"enca_pase_fact") = 1 or ldw_1.getItemString(ldw_1.Getrow(),"enca_pasado") = 'S' then
			messagebox('Atención','Esta lista de Empaque no puede ser modificada porque ya fue pasada a factura')
			If ldw_1.getItemString(ldw_1.Getrow(),"enca_pasado") <> 'S' then
				messagebox('Atención','Debe hacer una nueva lista de empaque para terminar el Pedido Gracias....!!')
			end if
			lb_salvo = false
		end if
		
		If l_status =DataModified! or l_status = NewModified! then
			//Esta sólo en prueba 
			is_viene_de ='DOUBLECLICK'
			
			id_canti = ld_cant_original
			
			wf_validar_cantidad(This, li_getrow, "CANTI")

			/**/
			this.ScrollTorow(this.RowCount())
			ls_codigo_producto = this.Getitemstring(this.RowCount(),"empa_codigo_producto") 
			if trim(ls_codigo_producto) = '' or isnull(ls_codigo_producto) then
				this.Deleterow(this.RowCount())
			end if

			/* Valida si lista de empaque fue pasada a factura */
			If ldw_1.getItemNumber(ldw_1.Getrow(),"enca_pase_fact") = 1 or ldw_1.getItemString(ldw_1.Getrow(),"enca_pasado") = 'S' then
				messagebox('Atención','Esta lista de Empaque no puede ser modificada porque ya fue pasada a factura')
				If ldw_1.getItemString(ldw_1.Getrow(),"enca_pasado") <> 'S' then
					messagebox('Atención','Debe hacer una nueva lista de empaque para terminar el Pedido Gracias....!!')
				end if
				lb_salvo = false
			else
				if this.update() = 1  then
					commit using sqlca;
					ll_row = ldw_4.Getrow()
					if is_fuente = 'PE' then
						ldw_6.Retrieve(str.g_financiero, str.empresa, is_pedido, il_ann)
						ldw_4.Retrieve(str.g_financiero, str.empresa, is_pedido, il_ann)
					else
						ldw_6.Retrieve(str.g_financiero, str.empresa,is_pedido,il_ann,is_tipo)
						ldw_4.Retrieve(str.g_financiero, str.empresa, is_pedido, il_ann, is_tipo)
					end if
					
					ldw_4.scrollTorow(ll_row)
					tab_1.tabpage_2.dw_5.scrollTorow(ll_row)
					
				  /* Refresca los datos del datawindows cuando la Actualizacion fue correcta */
				  this.setredraw(false)
				  
				  /* Recupera los datos para actualizar los valores cambiados en la tabla*/
				  this.retrieve(str.g_financiero,str.empresa,str_desglose.empaque,str_desglose.ann_empa)
				  this.scrollTorow(li_getrow)
				  
				  this.setredraw(true)	
				else
					lb_salvo = false
					rollback using sqlca;
					mensaje("Atención ","Error al actualizar registro actual (fadempaq)","")
				end if
			End if
		end if
		
		/* Si la cantidad es nueva o ha sido modificada que salve */
		If lb_salvo = true then
			If  pos(upper(str.nombre_empresa),'VISION TEX') > 0  Then	
				OpenWithParm(w_fa_man_desglose_pack_vision, str_desglose)
			ELSE
				OpenWithParm(w_fa_man_desglose_pack_textiles, str_desglose)
			End if
			
			str_desglose = message.PowerObjectParm
			
			If str_desglose.cambio = true then
				
				This.AcceptText ()
				/*Si la cantidad capturada es >= a la original que salve
			  la nueva cantdad */
				if ld_cant_original <= str_desglose.cantidad then
					This.SetItem(li_getrow,"empa_cantidad",str_desglose.cantidad)
					This.SetItem(li_getrow,"empa_canti",str_desglose.cantidad)
				else
					If  pos(upper(str.nombre_empresa),'VISION TEX') > 0  Then	
						if ld_cant_original > str_desglose.cantidad and str_desglose.cantidad > 0 then
							//Validar si se desea setear lo desglosado en detalle de la linea fadempaq
							li_resp = gf_mensaje("","La cantidad Desglosada es menor a la Asignada para este renglón, ¿ Desea reasignarla... ?",4,1,"E")
							
							if li_resp = 1 then // Reasignar
								This.SetItem(li_getrow,"empa_cantidad",str_desglose.cantidad)
								This.SetItem(li_getrow,"empa_canti",str_desglose.cantidad)
							end if
						end if
					END IF
				end if
				
				wf_salvar_detalle(str_desglose.linea, li_getrow, ab_borro,ld_cant_original)
				
				This.ScrollToRow(li_getrow)
				This.SetFocus()
			End if
		End if
end choose

end event

event dw_2::itemchanged;
//Se dispara el Post del Itemchanged
ib_cambio = true
choose case is_col  
		
	case	"empa_canti"
			id_canti    = this.GetitemNumber(row,"empa_canti")
			il_row = row
end choose
this.post event ue_postitem(row, dwo, data)
end event

event dw_2::retrieveend;//Setear las Cantidades y Fracciones, Dependiendo de la cantidad de la linea
integer 		i, li_linea_original,li_lin_ref,li_anio,li_count
string      ls_unidad, ls_expresion,ls_empaque,ls_prod
Decimal		ld_cantidad = 0, ll_fraccion = 0, ld_cant_total
Long			ll_row
Decimal	ld_cant_deglosada,ld_cant_salvada_reg_actual,ld_total_asignada_pedido
Datawindow  ldw_6

datastore ds_detalle_captado
ds_detalle_captado = create datastore
ds_detalle_captado.DataObject=  'dw_ma_fa_desglose_packing_lin'
ds_detalle_captado.Settransobject(sqlca)	

ls_empaque = tab_1.tabpage_1.dw_1.GetItemString(1,"enca_lista_empaque")
li_anio = tab_1.tabpage_1.dw_1.GetItemNumber(1,"enca_ann")

ldw_6 = tab_1.tabpage_2.dw_6

for i = 1 to rowcount
	
	ld_cant_salvada_reg_actual 	= this.GetitemNumber(i,"empa_cantidad")
	ls_unidad		= this.GetItemString(i,"empa_unidad")
	ls_prod = this.GetItemString(i,'empa_codigo_producto')

	If (IsNull(ld_cant_salvada_reg_actual) or ld_cant_salvada_reg_actual = 0) or ((IsNull(ls_prod) or ls_prod = '')) then continue

	this.Setitem(i,"empa_canti",ld_cant_salvada_reg_actual)
	this.Setitem(i,"validado",1)
	
	li_linea_original = this.Getitemnumber(i,"empa_linea_original")
	
	li_lin_ref = this.GetItemNumber(i,"empa_linea")
		
	ls_expresion = "linea = "+string(li_linea_original)

	ll_row = ldw_6.Find(ls_expresion,1,ldw_6.Rowcount())
	If ll_row > 0 then
		ld_total_asignada_pedido  = ldw_6.Getitemnumber(ll_row,"asignada")
	else
		ld_total_asignada_pedido = 0
		messagebox("Atención ","No se encontró la línea del pedido (dw_6) "+' '+string(li_linea_original))

	end if	
		 
	If IsNull(ld_total_asignada_pedido) then ld_total_asignada_pedido =0
	
	//Recupera del detalle de los rollos	
	li_count = ds_detalle_captado.retrieve(str.g_financiero,str.empresa,ls_empaque,li_anio,li_lin_ref)

	ld_cant_deglosada = 0
	IF li_count > 0 then
		//Total del yardaje   
	   ld_cant_deglosada = ds_detalle_captado.GetItemNumber(1,"cant_total")
	end if
	/*									total asignada     			cant salvada	  				total desglosado
	Asignadas= 						en el pedido 				-  reg actual    				 	+ del renglón */
	
	ld_total_asignada_pedido = ld_total_asignada_pedido - ld_cant_salvada_reg_actual + ld_cant_deglosada
		
	wf_setear_status(ld_cant_deglosada,ld_cant_salvada_reg_actual,li_lin_ref,i,li_linea_original,ll_row,ld_total_asignada_pedido)
		
Next
Destroy ds_detalle_captado

end event

event dw_2::editchanged;//Asigna El Nombre de la Columnna

is_col = this.Getcolumnname()
if this.Getcolumnname() = 'empa_codigo_producto' then
	ib_modificado = true		//Para que cuando doy << uparrow >>, no se dispare el ue_postitem
									//a menos que se halla modificado el codigo del producto
end if

end event

event dw_2::ue_microhelp;//Override
// Ayuda en el Microhelp

String	ls_objeto, ls_row

ls_objeto = GetObjectAtPointer ()
ls_row	 = Right (ls_objeto, Len (ls_objeto) - Pos (ls_objeto, '~t') + 1)
ls_objeto = Left (ls_objeto, Pos (ls_objeto, '~t') - 1)

is_last_row = integer (ls_row)

If is_last_column = ls_objeto Then Return

is_last_column = lower (ls_objeto)

integer	li_x, li_y

li_x	 = str.frame.GetActiveSheet ().PointerX () 
li_y	 = str.frame.GetActiveSheet ().PointerY ()

choose case is_last_column 
	case "sube"
		If st_microhelp.Visible Then Return
		st_microhelp.Move (li_x - 1700, li_y  + 30)
		st_microhelp.Text 	= "Haga click para Subir el Registro o pulse << Shift+Flecha Arriba >>"
		st_microhelp.Width 	= Len (st_microhelp.Text) * 28
		st_microhelp.Visible = TRUE

	case "baja"
		If st_microhelp.Visible Then Return
		st_microhelp.Move (li_x - 1700, li_y  + 30)
		st_microhelp.Text 	= "Haga click para Bajar el Registro o pulse << Shift+Flecha Abajo >>"
		st_microhelp.Width 	= Len (st_microhelp.Text) * 28
		st_microhelp.Visible = TRUE
		
	case	"empa_cubicaje"	
		If st_microhelp.Visible Then Return
		st_microhelp.Move (li_x , li_y)
		st_microhelp.Text 	= "Dar Doble Click o F3 para Desglozar Cubicaje."
		st_microhelp.Width 	= Len (st_microhelp.Text) * 28
		st_microhelp.Visible = TRUE
		
	case	"empa_codigo_producto"
		If st_microhelp.Visible Then Return
		st_microhelp.Move (li_x, li_y)
		st_microhelp.Text 	= "Dar Doble Click o F3 para Buscar Productos"
		st_microhelp.Width 	= Len (st_microhelp.Text) * 28
		st_microhelp.Visible = TRUE
	case	"empa_canti"	
		If st_microhelp.Visible Then Return
		st_microhelp.Move (li_x - 1500, li_y)
		st_microhelp.Text 	= "Dar Doble Click o F3 para Desglozar Cantidades."
		st_microhelp.Width 	= Len (st_microhelp.Text) * 28
		st_microhelp.Visible = TRUE
	case else
		st_microhelp.Visible = FALSE
		
end choose

timer(2)
end event

event dw_2::buttonclicked;// Ayuda en el Microhelp

String	ls_objeto, ls_columna

ls_objeto     = GetObjectAtPointer ()

ls_objeto     = Left (ls_objeto, Pos (ls_objeto, '~t') - 1)

If ls_columna = ls_objeto Then Return

ls_columna    = lower (ls_objeto)

if actionreturncode = 0 then
	choose case ls_columna
		case "sube"
			wf_sube_o_baja("S")
		case "baja"
			wf_sube_o_baja("B")			
	end choose
end if

end event

event dw_2::clicked;st_microhelp.visible = false
//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto
integer li_pos 

this.Setredraw(false)

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

this.Setredraw(true)
end event

event dw_2::rowfocuschanged;//Override

if currentrow < 1 then return

string ls_producto
Long	 ll_linea
Datawindow ldw_5,ldw_4
ldw_5 = tab_1.tabpage_2.dw_5
ldw_4 = tab_1.tabpage_1.dw_4

ls_producto = This.Getitemstring(currentrow,"empa_codigo_producto")
ll_linea		= This.GetitemNumber(currentrow,"empa_linea_original")

if ls_producto = '' or isnull(ls_producto) then 
	ldw_5.Scrolltorow(ldw_5.insertrow(0))
	return 2
end if

//Dirige el cursor al producto actual

wf_scroll_a_disponibles(ldw_5, ls_producto, ll_linea)

//Recupera el dw6 del desgloce por linea de detalle
//wf_recupera_desgloce(ll_linea)
end event

type tabpage_3 from w_fa_padre_tab`tabpage_3 within tab_1
integer width = 2775
integer height = 1472
string text = "Preview"
string picturename = "Preview!"
gb_3 gb_3
cbx_imprime_monto cbx_imprime_monto
dw_8 dw_8
end type

on tabpage_3.create
this.gb_3=create gb_3
this.cbx_imprime_monto=create cbx_imprime_monto
this.dw_8=create dw_8
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.cbx_imprime_monto
this.Control[iCurrent+3]=this.dw_8
end on

on tabpage_3.destroy
call super::destroy
destroy(this.gb_3)
destroy(this.cbx_imprime_monto)
destroy(this.dw_8)
end on

type dw_3 from w_fa_padre_tab`dw_3 within tabpage_3
event ue_keydown pbm_dwnkey
string tag = "dw_ma_fa_imp_pedi_pack"
integer x = 5
integer y = 44
integer width = 2752
integer height = 1324
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_3::ue_keydown;//Llama al Evento de la Ventana Principal
iw_this.TriggerEvent("key")
end event

event dw_3::retrieveend;
Decimal	ld_cant_asig, ld_cant_uni, ld_cant_noasig, ld_cant_asignada
Long		ld_cant_frac,ll_row, ll_i, ll_bultos

String 	ls_uni_venta, ls_aprobado, ls_recolecta, ls_nombre, ls_apellido,ls_nombre_rec,&
			ls_apellido_rec, ls_cod_base, ls_colum_color, ls_colum_cantidad,ls_color,&
			ls_expression,ls_lin_ref, ls_unidad_ant, ls_cod_base_1, ls_pais, ls_region
Decimal	ld_cantidad, ld_cub_grupo, ld_peso,ldt_peso,ldt_cub_grupo,ldt_yardas, ld_precio,ld_monto
Integer	li_color, li_piezas,li_columna = 1 ,ll_linea,ll_linea_1, li_rollos,li_pais, li_region

DataWindow ldw_3,ldw_8

ldw_3 = tab_1.Tabpage_3.dw_3

ldw_8 = tab_1.Tabpage_3.dw_8

ls_cod_base =''

If rowcount < 1 then return

For ll_i = 1 to rowcount
	ld_cant_asig = ldw_3.GetItemNumber(ll_i,"asigna")
		If is_fuente = "PE" or w_fa_fondo.str_para.lista_emp_especial = 1  Then
			ls_uni_venta =	ldw_3.GetItemString(ll_i,"fadpedid_dped_unidad_venta")
		Else
			ls_uni_venta =	ldw_3.GetItemString(ll_i,"faddiari_facd_unidad_venta")
		End If
		
	ldw_3.SetItem(ll_i,"asignado",string(ld_cant_uni)+"."+string(ld_cant_frac))
	
	ld_cant_noasig = ldw_3.GetItemNumber(ll_i,"noasigna")
	ld_cant_uni = 0
	ld_cant_frac = 0
	
	ldw_3.SetItem(ll_i,"noasignado",string(ld_cant_uni)+"."+string(ld_cant_frac))

	ld_cant_asignada = ldw_3.GetItemNumber(ll_i,"fadempaq_empa_cantidad")
	ld_cant_uni = 0
	ld_cant_frac = 0

	ldw_3.SetItem(ll_i,"cantidad",string(ld_cant_uni)+"."+string(ld_cant_frac))

	/*Programación especial para packing de textiles*/

	If w_fa_fondo.str_para.lista_emp_especial = 1 then
		If ll_i = 1 then
			ls_unidad_ant = ''
			ldw_8.Reset()
			ll_row = ldw_8.InsertRow(0)
			ldw_3.visible = false
			ldw_8.visible = true
			ls_cod_base = ''
			ls_cod_base_1 = ldw_3.GetItemString(ll_i,"fadpedid_dped_codigo_item")
			ls_cod_base_1 = ls_cod_base+string(ldw_3.GetItemNumber(ll_i,"linea_refer"))
			// Cantidad de piezas por renglon en la impresion
			If  pos(upper(str.nombre_empresa),'VISION') > 0  Then	
				li_rollos = 10
			end if
			
			If  pos(upper(str.nombre_empresa),'TEXTILES') > 0  Then	
				li_rollos = 15
			end if
			li_pais = ldw_3.GetItemNumber(ll_i,"terc_pais")
			li_region = ldw_3.GetItemNumber(ll_i,"terc_region")
			/**/
			  SELECT dgapais.pais_descripcion  
				 INTO :ls_pais  
				 FROM dgapais  
				WHERE dgapais.pais_pais = :li_pais   ;
				
				if not isNull(ls_pais) and ls_pais <> '' then
					
				  SELECT dgaregio.regi_descripcion  
					 INTO :ls_region  
					 FROM dgaregio  
					WHERE ( dgaregio.regi_pais = :li_pais ) AND  
							( dgaregio.regi_codigo_region = :li_region )   ;
			
				end if
			/**/
			If IsNull(ls_pais) then ls_pais =''
			If IsNull(ls_region) then ls_region =''

/**/		ldw_8.setItem(ll_row,"fadempaq_empa_linea",ldw_3.GetItemNumber(ll_i,"fadempaq_empa_linea"))
/**/		ldw_8.setItem(ll_row,"fademtel_fade_linea",ldw_3.GetItemNumber(ll_i,"fademtel_fade_linea"))
		end if

		ldw_3.SetItem(ll_i,"fadempaq_empa_cantidad",ld_cant_asignada) // arturo
		ld_cantidad = ldw_3.GetItemNumber(ll_i,"fadempaq_empa_cantidad")
		If IsNull(ld_cantidad) then ld_cantidad =0

		/* Línea del detalle de fadempaq */
		ls_lin_ref = string(ldw_3.GetItemNumber(ll_i,"linea_refer"))
		
		If ls_cod_base <> ldw_3.GetItemString(ll_i,"fadpedid_dped_codigo_item")+string(ls_lin_ref)  then

			ld_peso		 = ldw_3.GetItemNumber(ll_i,"fadempaq_empa_peso")
			If IsNull(ld_peso) then ld_peso =0

			ld_cub_grupo = ldw_3.GetItemNumber(ll_i,"fadempaq_empa_cubicaje")
			If IsNull(ld_cub_grupo) then ld_cub_grupo =0
			
			If ls_cod_base <>''  then

			// Inserta Totales por grupo // Commented by HGN 02/02/2000
				ldw_8.SetItem(ll_row,"piezas",li_piezas)
				ldw_8.SetItem(ll_row,"yardas",ldt_yardas)
				ld_monto = round(ld_precio*ldt_yardas,2)
				ldw_8.SetItem(ll_row,"monto",ld_monto)
				ldw_8.SetItem(ll_row,"empa_unidad",ls_unidad_ant)

				li_piezas = 0
				ldt_yardas= 0
				
				// Inserta nueva línea de detalle después de insertar totales
				ll_row = ldw_8.InsertRow(0)
				li_columna = 1
			end if
		
			//Acumula totales por grupo
			li_piezas ++
			ldt_yardas     +=ld_cantidad

			// Toma el nuevo codigo de grupo
			ls_cod_base = ldw_3.GetItemString(ll_i,"fadpedid_dped_codigo_item")
			ls_cod_base = ls_cod_base+string(ldw_3.GetItemNumber(ll_i,"linea_refer"))

			If ls_cod_base_1 <>  ls_cod_base THEN
				ldw_8.SetItem(ll_row,"empa_cubicaje",ld_cub_grupo)
				ldw_8.SetItem(ll_row,"fadempaq_empa_peso",ld_peso)
				ldw_8.SetItem(ll_row,"fadempaq_empa_bulto_inicio",ldw_3.GetItemNumber(ll_i,"fadempaq_empa_bulto_inicio"))
				ldw_8.SetItem(ll_row,"fadempaq_empa_bulto_fin",ldw_3.GetItemNumber(ll_i,"fadempaq_empa_bulto_fin"))
				ldw_8.SetItem(ll_row,"empa_bultos",ldw_3.GetItemNumber(ll_i,"empa_bultos"))
				ldw_8.SetItem(ll_row,"fatpedid_visible",1)
			else
				ldw_8.SetItem(ll_row,"fadempaq_empa_bulto_inicio",ldw_3.GetItemNumber(ll_i,"fadempaq_empa_bulto_inicio"))
				ldw_8.SetItem(ll_row,"fadempaq_empa_bulto_fin",ldw_3.GetItemNumber(ll_i,"fadempaq_empa_bulto_fin"))
				ldw_8.SetItem(ll_row,"fatpedid_visible",0)
				ldw_8.SetItem(ll_row,"fatpedid_orden",1)
			end if
			
			/*Toma los dos ultimos caracteres despues del '-' del producto*/
			ls_color    = string(ldw_3.GetItemNumber(ll_i,"color"))
			/*Concatena los nombres de las columnas*/
//			ls_colum_color    = 'col_'+trim(string(li_columna))
			
			if IsNull(li_columna) or li_columna = 0 then li_columna = 1
			
			ls_colum_cantidad = 'cant_'+trim(string(li_columna))
			
			/*Setea el color y yardaje del bulto */
//			ldw_8.SetItem(ll_row,ls_colum_color,ls_color)
			ldw_8.SetItem(ll_row,ls_colum_cantidad,ld_cantidad)

			ldw_8.SetItem(ll_row,"pais_region",ls_pais+', '+ls_region)

			ldw_8.SetItem(ll_row,"fadpedid_dped_descripcion_alterna",ldw_3.GetItemString(ll_i,"fadpedid_dped_descripcion_alterna"))
			ldw_8.SetItem(ll_row,"fadpedid_dped_codigo_item",ldw_3.GetItemString(ll_i,"fadpedid_dped_codigo_item"))

/**/		ldw_8.setItem(ll_row,"fadempaq_empa_linea",ldw_3.GetItemNumber(ll_i,"fadempaq_empa_linea"))
/**/		ldw_8.setItem(ll_row,"fademtel_fade_linea",ldw_3.GetItemNumber(ll_i,"fademtel_fade_linea"))
			
			ldw_8.SetItem(ll_row,"precio",ldw_3.GetItemNumber(ll_i,"precio_unidad_producto"))
			ld_precio =ldw_8.GetItemNumber(ll_row,"precio")
			ldw_8.SetItem(ll_row,"fatpedid_pedi_a_nombre",ldw_3.GetItemString(ll_i,"fatpedid_pedi_a_nombre"))
			ldw_8.SetItem(ll_row,"dgmterce_terc_direccion",ldw_3.GetItemString(ll_i,"dgmterce_terc_direccion"))
			ldw_8.SetItem(ll_row,"fatpedid_pedi_consignado",ldw_3.GetItemString(ll_i,"fatpedid_pedi_consignado"))
			ldw_8.SetItem(ll_row,"fatpedid_pedi_no_pedido",ldw_3.GetItemString(ll_i,"fatpedid_pedi_no_pedido"))
			ldw_8.SetItem(ll_row,"fatempaq_enca_recolector",ldw_3.GetItemString(ll_i,"fatempaq_enca_recolector"))
			ldw_8.SetItem(ll_row,"fatempaq_enca_supervisor",ldw_3.GetItemString(ll_i,"fatempaq_enca_supervisor"))
			
			ldw_8.SetItem(ll_row,"pedi_marca",ldw_3.GetItemString(ll_i,"pedi_marca"))
			ldw_8.SetItem(ll_row,"lista_empaque",ldw_3.GetItemString(ll_i,"lista_empaque"))
			ldw_8.SetItem(ll_row,"fatempaq_enca_ann",ldw_3.GetItemNumber(ll_i,"fatempaq_enca_ann"))
			ldw_8.SetItem(ll_row,"faaparam_fara_logo",ldw_3.GetItemString(ll_i,"faaparam_fara_logo"))

		else
			li_columna ++

			/*Toma los dos ultimos caracteres despues del '-' del producto*/
			ls_color    = string(ldw_3.GetItemNumber(ll_i,"color"))

			/*Concatena los nombres de las columnas*/
//			ls_colum_color    = 'col_'+trim(string(li_columna))
			ls_colum_cantidad = 'cant_'+trim(string(li_columna))

			ldw_8.SetItem(ll_row,"pais_region",ls_pais+', '+ls_region)

			ldw_8.SetItem(ll_row,"fadpedid_dped_descripcion_alterna",ldw_3.GetItemString(ll_i,"fadpedid_dped_descripcion_alterna"))
			ldw_8.SetItem(ll_row,"fadpedid_dped_codigo_item",ldw_3.GetItemString(ll_i,"fadpedid_dped_codigo_item"))

/**/		ldw_8.setItem(ll_row,"fadempaq_empa_linea",ldw_3.GetItemNumber(ll_i,"fadempaq_empa_linea"))
/**/		ldw_8.setItem(ll_row,"fademtel_fade_linea",ldw_3.GetItemNumber(ll_i,"fademtel_fade_linea"))

			ldw_8.SetItem(ll_row,"precio",ldw_3.GetItemNumber(ll_i,"precio_unidad_producto"))

			ldw_8.SetItem(ll_row,"pedi_marca",ldw_3.GetItemString(ll_i,"pedi_marca"))
			ldw_8.SetItem(ll_row,"lista_empaque",ldw_3.GetItemString(ll_i,"lista_empaque"))
			ldw_8.SetItem(ll_row,"fatempaq_enca_ann",ldw_3.GetItemNumber(ll_i,"fatempaq_enca_ann"))
			ldw_8.SetItem(ll_row,"faaparam_fara_logo",ldw_3.GetItemString(ll_i,"faaparam_fara_logo"))

			ld_precio =ldw_8.GetItemNumber(ll_row,"precio")

			//Acumula totales por grupo
			If IsNull(ld_peso) then ld_peso =0
			li_piezas ++
			ldt_yardas     += ld_cantidad

			/*Setea el color y yardaje del bulto */
//			ldw_8.SetItem(ll_row,ls_colum_color,ls_color)

			ldw_8.SetItem(ll_row,ls_colum_cantidad,ld_cantidad)

			If li_columna = li_rollos then
				// Es un producto con 15 ó más rollos o piezas, por lo que debe agregar otro 
				// acumula totales e inserta otra linea del mismo producto
				ls_cod_base ='99'
				li_columna = 1
			end if

		end if
		
		/*Retiene registro anterior para detectar, cuándo ocurre el cambio
		de producto y línea de referencia*/
		ls_unidad_ant = ls_uni_venta

		ls_cod_base_1 = ldw_3.GetItemString(ll_i,"fadpedid_dped_codigo_item")
		ls_cod_base_1 = ls_cod_base_1+string(ldw_3.GetItemNumber(ll_i,"linea_refer"))
		
	end if
Next

If w_fa_fondo.str_para.lista_emp_especial = 1 then

	// Inserta Totales por grupo

		ldw_8.SetItem(ll_row,"piezas",li_piezas)
		ldw_8.SetItem(ll_row,"yardas",ldt_yardas)
		ld_monto = round(ld_precio*ldt_yardas,2)
		ldw_8.SetItem(ll_row,"monto",ld_monto)
		ldw_8.SetItem(ll_row,"empa_unidad",ls_uni_venta)

		dw_8.object.data_window.expression = "'"+ dw_8.dataObject +"'"
		
		ls_expression = string(date(gf_fecha_serv())) 
		dw_8.object.fecha.expression = "'"+ls_expression+"'"
		
		ls_expression = string(Time(gf_fecha_serv()))
		dw_8.object.hora.expression = "'"+ls_expression+"'"

		ls_expression = gf_dg_nombre_empresa()
		ldw_8.object.empresanom.expression = "'"+ls_expression+"'"

		//* Script para la asignacion del tamaño de página ....
		Integer	li_largo,li_ancho
		li_largo = 5000	// largo
		li_ancho = 2375	// ancho
	
		If is_win9598_winnt='win9598' then
			gf_dg_tamano_pagina(li_largo,li_ancho,ldw_3)
		end If
	
	ldw_8.object.datawindow.print.preview = 'yes'
	ldw_8.object.datawindow.print.preview.zoom =100

	If  pos(upper(str.nombre_empresa),'TEXTILES') > 0  Then	
		ldw_8.SetSort("fadempaq_empa_bulto_fin A, fatpedid_orden A")
	else
		ldw_8.SetSort("fadempaq_empa_bulto_inicio A ,fadempaq_empa_bulto_fin A, fatpedid_orden A fadempaq_empa_linea A,fademtel_fade_linea A")
	end if
	ldw_8.Sort()
end if		

//Para Imprimir el codigo o el nombre de los vendedores
wf_imprime_vendedor()

end event

event dw_3::retrievestart;call super::retrievestart;DataWindow ldw_3,ldw_8

ldw_3 = tab_1.Tabpage_3.dw_3

ldw_8 = tab_1.Tabpage_3.dw_8

If right(ldw_3.DataObject,12) = 'textiles_det' then
	ldw_3.Visible = false
	ldw_8.visible = true
end if

end event

type st_gb from w_fa_padre_tab`st_gb within w_fa_man_packing_list_x
end type

type pb_up from w_fa_padre_tab`pb_up within w_fa_man_packing_list_x
integer taborder = 30
end type

type pb_down from w_fa_padre_tab`pb_down within w_fa_man_packing_list_x
integer taborder = 10
end type

type st_help from w_fa_padre_tab`st_help within w_fa_man_packing_list_x
integer x = 206
integer y = 1468
end type

type ole_1 from olecontrol within tabpage_1
integer x = 1934
integer y = 44
integer width = 823
integer height = 1396
integer taborder = 12
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_fa_man_packing_list_x.win"
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
omlinkupdateoptions linkupdateoptions = linkupdatemanual!
end type

type dw_4 from datawindow within tabpage_1
boolean visible = false
integer x = 5
integer y = 1340
integer width = 2437
integer height = 132
integer taborder = 12
boolean bringtotop = true
string dataobject = "dw_ma_fa_pedi_packing_tel"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;//Cuando Recupero, Seteo la Cantidad Disponible al DW
Integer  i, li_resultado
Decimal	ld_cantidad, ll_fraccion, ld_asignadas, ld_disponible, ld_cant_total

String	ls_unidad
Datawindow ldw_6,ldw_5
ldw_6 = tab_1.tabpage_2.dw_6
ldw_5 = tab_1.tabpage_2.dw_5

if rowcount < 1 then return

//Setea el Datawindow de Cantidades Disponibles
wf_setea_dw_disponibles()

for i = 1 to rowcount
	if is_fuente     =    'PE' then
		ld_cantidad	  =	 this.GetitemNumber(i,"dped_cantidad")
		ll_fraccion   =	 this.GetitemNumber(i,"dped_fraccion")
		ld_asignadas  =  	 this.GetitemNumber(i,"dped_cant_asignada")
		ls_unidad	  =    This.GetitemString(i,"dped_unidad_venta")
		
		if isnull(ld_cantidad) then ld_cantidad = 0
		if isnull(ll_fraccion) then ll_fraccion = 0
		if isnull(ld_asignadas) then ld_asignadas = 0	
		
		ld_cant_total =    wf_convert_min(ls_unidad,ld_cantidad,ll_fraccion)
//		ld_cant_total =    ld_cantidad

		ld_disponible =    ld_cant_total - ld_asignadas
		
		This.Setitem(i,"cant_disponible",ld_disponible)	
	
	else
		ld_cantidad	  =	 this.GetitemNumber(i,"facd_cantidad")
		ll_fraccion   =	 this.GetitemNumber(i,"facd_cantidad_fraccion")
		ld_asignadas  =  	 this.GetitemNumber(i,"facd_cant_asignada")
		ls_unidad	  =    This.GetitemString(i,"facd_unidad_venta")
		
		if isnull(ld_cantidad) then ld_cantidad = 0
		if isnull(ll_fraccion) then ll_fraccion = 0
		if isnull(ld_asignadas) then ld_asignadas = 0	
		
		ld_cant_total =    wf_convert_min(ls_unidad,ld_cantidad,ll_fraccion)
//		ld_cant_total =    ld_cantidad
		ld_disponible =    ld_cant_total - ld_asignadas
		This.Setitem(i,"cant_disponible",ld_disponible)							
		
	end if
	
	//Función que convierte lo asignado y disponible en cantidades y fracciones
   wf_convierte_a_unidades(This,i,ls_unidad,ld_asignadas,ld_disponible)
	
Next

//Recupera el DW la cantidad, asignado y cacula lo disponible del pedido

if is_fuente = 'PE' then
	li_resultado = ldw_6.Retrieve(str.g_financiero, str.empresa, is_pedido, il_ann)
else
	li_resultado = ldw_6.Retrieve(str.g_financiero, str.empresa,is_pedido,il_ann,is_tipo)
end if

if li_resultado < 1 then
	str.frame.Setmicrohelp("El Pedido No Tiene Artículos con Desglose.")
	timer(5)
end if


end event

type ole_3 from olecontrol within tabpage_1
integer x = 87
integer y = 612
integer width = 137
integer height = 120
integer taborder = 14
boolean bringtotop = true
boolean border = false
boolean focusrectangle = false
string binarykey = "w_fa_man_packing_list_x.win"
integer binaryindex = 1
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
omlinkupdateoptions linkupdateoptions = linkupdatemanual!
end type

type ole_5 from olecontrol within tabpage_1
integer x = 78
integer y = 784
integer width = 146
integer height = 124
integer taborder = 24
boolean bringtotop = true
boolean border = false
boolean focusrectangle = false
string binarykey = "w_fa_man_packing_list_x.win"
integer binaryindex = 2
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
omlinkupdateoptions linkupdateoptions = linkupdatemanual!
end type

type ole_4 from olecontrol within tabpage_1
integer x = 82
integer y = 960
integer width = 142
integer height = 128
integer taborder = 14
boolean bringtotop = true
boolean border = false
boolean focusrectangle = false
string binarykey = "w_fa_man_packing_list_x.win"
integer binaryindex = 3
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
omlinkupdateoptions linkupdateoptions = linkupdatemanual!
end type

type gb_2 from groupbox within tabpage_2
integer x = 9
integer width = 2761
integer height = 1464
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79416533
end type

type dw_6 from datawindow within tabpage_2
boolean visible = false
integer x = 23
integer y = 988
integer width = 1979
integer height = 128
integer taborder = 34
boolean bringtotop = true
string dataobject = "dw_ma_fa_cant_pedi_packing_disp_esp_det"
boolean border = false
borderstyle borderstyle = stylelowered!
end type

event retrieveend;////Cuando Recupero, Seteo la Cantidad Disponible al DW
//Integer  i
//long		ll_cantidad, ll_asignadas, ll_disponible, ll_row, ll_linea
//			
//String	ls_unidad
//Datawindow ldw_5
//ldw_5 = tab_1.tabpage_2.dw_5
//
//if rowcount < 1 then return
//
//for i = 1 to rowcount
//				
//		ll_cantidad	  =	 this.GetitemNumber(i,"cantidad")
//		ll_asignadas  =  	 this.GetitemNumber(i,"asignada")
//		ll_linea		  =    this.GetItemNumber(i,"linea")		
//		
//		ls_unidad  	  =    this.GetitemString(i,"unidad")
//
//		if isnull(ll_cantidad) then ll_cantidad = 0
//		if isnull(ll_asignadas) then ll_asignadas = 0	
//		
////		ll_asignadas = ll_cantidad - ll_asignadas		//Para que Pase solo lo que se asignará
//	
//		ll_disponible = ll_cantidad - ll_asignadas
//		
////		This.Setitem(i,"cant_disponible",0)
//		This.Setitem(i,"cant_disponible",ll_disponible)
//		
//		This.Setitem(i,"asignada",ll_asignadas)
//		
//		//Función que convierte lo asignado y disponible en cantidades y fracciones
//	  	 wf_convierte_a_unidades_desglose(This,i,ls_unidad,ll_cantidad,ll_asignadas,ll_disponible)
//			
//Next
end event

type dw_7 from datawindow within tabpage_2
boolean visible = false
integer x = 32
integer y = 388
integer width = 2610
integer height = 336
integer taborder = 14
boolean bringtotop = true
string dataobject = "dw_ma_fa_desglose_packing_tel"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within tabpage_2
integer x = 2117
integer y = 1216
integer width = 384
integer height = 84
integer taborder = 34
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pasar Todos"
end type

event clicked;str_empaque.fuente	= tab_1.tabpage_1.dw_1.Getitemstring(tab_1.tabpage_1.dw_1.Getrow(),"enca_fuente")
wf_pasar_todos()
this.visible = false
end event

type dw_5 from datawindow within tabpage_2
integer x = 23
integer y = 1184
integer width = 1979
integer height = 108
integer taborder = 24
boolean bringtotop = true
string dataobject = "dw_ma_fa_pedi_cantidades_packing_tel"
boolean border = false
end type

type st_2 from statictext within tabpage_2
integer x = 46
integer y = 1312
integer width = 1097
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79416533
string text = "|| F3 = Ventanas de prod, cubicaje ||"
boolean focusrectangle = false
end type

type st_3 from statictext within tabpage_2
integer x = 983
integer y = 1320
integer width = 1646
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79416533
string text = "F6 = Liberar / Reservar    ||    F5 = Copia el registro actual                ||"
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_2
integer x = 41
integer y = 1384
integer width = 2601
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79416533
string text = "|| => Down = Add  || => Up en producto = acepta  ||  Shif  => Up = Reg. Arriba  ||  Shif => Down = Reg Abajo  ||"
boolean focusrectangle = false
end type

type gb_3 from groupbox within tabpage_3
integer width = 2775
integer height = 1392
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79416533
end type

type cbx_imprime_monto from checkbox within tabpage_3
integer x = 1893
integer y = 1396
integer width = 681
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "¿ Imprime precio y monto ?"
borderstyle borderstyle = stylelowered!
end type

event clicked;If tab_1.tabpage_3.cbx_imprime_monto.checked = true then
	tab_1.tabpage_3.dw_8.modify("precio.visible='1'")
	tab_1.tabpage_3.dw_8.modify("monto.visible='1'")
	tab_1.tabpage_3.dw_8.modify("tmonto.visible='1'")
//	<DW Control Name>.Modify("<Columnname>.Visible='<0 - False, 1 - True>'")
else
	tab_1.tabpage_3.dw_8.modify("precio.visible='0'")
	tab_1.tabpage_3.dw_8.modify("monto.visible='0'")
	tab_1.tabpage_3.dw_8.modify("tmonto.visible='0'")
end if
end event

type dw_8 from datawindow within tabpage_3
boolean visible = false
integer x = 14
integer y = 48
integer width = 2670
integer height = 1180
integer taborder = 12
string title = "none"
string dataobject = "dw_ma_fa_imp_pedi_pack_textiles"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;string ls_objeto
integer li_pos 

this.Setredraw(false)

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

this.Setredraw(true)
end event

type st_1 from statictext within w_fa_man_packing_list_x
integer x = 55
integer y = 1628
integer width = 1102
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_fa_man_packing_list_x
boolean visible = false
integer x = 1993
integer y = 1412
integer width = 535
integer height = 128
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Halt    Close"
end type

event clicked;halt close
end event

type st_microhelp from statictext within w_fa_man_packing_list_x
boolean visible = false
integer x = 2053
integer y = 1484
integer width = 507
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15793151
boolean enabled = false
string text = "microhelp"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type ole_2 from olecustomcontrol within w_fa_man_packing_list_x
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
integer x = 1051
integer y = 12
integer width = 1673
integer height = 96
integer taborder = 12
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_fa_man_packing_list_x.win"
integer binaryindex = 4
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

