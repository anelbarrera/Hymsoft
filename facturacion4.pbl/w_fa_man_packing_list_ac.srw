//objectcomments Listas de Empaque
forward
global type w_fa_man_packing_list_ac from w_fa_padre_tab
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
type dw_5 from datawindow within tabpage_2
end type
type gb_2 from groupbox within tabpage_2
end type
type dw_6 from datawindow within tabpage_2
end type
type dw_7 from datawindow within tabpage_2
end type
type cb_pasar from commandbutton within tabpage_2
end type
type cbx_precio_monto from checkbox within tabpage_3
end type
type gb_3 from groupbox within tabpage_3
end type
type dw_8 from datawindow within tabpage_3
end type
type st_1 from statictext within w_fa_man_packing_list_ac
end type
type cb_1 from commandbutton within w_fa_man_packing_list_ac
end type
type st_microhelp from statictext within w_fa_man_packing_list_ac
end type
type ole_2 from olecustomcontrol within w_fa_man_packing_list_ac
end type
end forward

global type w_fa_man_packing_list_ac from w_fa_padre_tab
integer width = 3090
integer height = 1952
string title = "Mantenimiento de las Listas de Empaque"
string menuname = "m_fa_principal"
event ue_busqueda ( )
event ue_post_aceptar ( )
st_1 st_1
cb_1 cb_1
st_microhelp st_microhelp
ole_2 ole_2
end type
global w_fa_man_packing_list_ac w_fa_man_packing_list_ac

type variables
/*Fuente del Packing, FA o PE*/
string is_fuente, is_pedido, is_empaque, is_cliente, &
         is_empa_det, is_unidad_cubicaje, is_col, is_cod_prod, &
         is_campo_asignada, is_tipo, is_win9598_winnt, is_prod_buscar
Long    il_ann, il_ann_empa, il_ann_det, il_canti, il_fraccion
Integer ii_linea = 0, ii_por_linea
Boolean ib_cambio = false, ib_adicionar = false, &
              ib_modificado = false, ib_desde_ayuda = false
DatawindowChild dwc_recolec, dwc_empa, dwc_despa,&
                            dwc_jefes, dwc_autoriza
str_fa_cubicaje            str_cubicaje
str_fa_pedi_empaque  		str_empaque
str_fa_desglose            str_desglose 

str_fa_carg_ped str_pedi

u_external_function   iu_externa


end variables

forward prototypes
public subroutine wf_botones ()
public function string wf_buscar_secuencia ()
public function string wf_extraer_pedido (string ls_syntax)
public function long wf_extraer_ano_empa (string ls_syntax)
public function string wf_extraer_no_empaque (string ls_syntax)
public function integer wf_actualizar_secuencia ()
public function string wf_extraer_cliente (string ls_syntax)
public subroutine wf_modificar_barra ()
public function string wf_extraer_cliente_new (string ls_syntax)
public function integer wf_valida_cambios ()
public function string wf_extraer_pedido_old (string ls_syntax)
public subroutine wf_setear_descripciones (long al_rows)
public subroutine wf_setear_cubic (double ad_largo, double ad_alto, double ad_ancho, double ad_cubicaje, string as_unidad_comp)
public subroutine wf_convert_uni (string as_med, long al_fracciones, ref long al_cantidad, ref long al_fraccion)
public subroutine wf_setear_lineas_y_cantidades (datawindow adw_dw2)
public function long wf_convert_min (string as_med, long al_cantidad, long al_fraccion)
public function integer wf_reestaurar_cant_eliminadas (datawindow adw_dw1, long al_linea)
public subroutine wf_setea_grupo_empresa (integer ai_fila, datawindow adw_object, string as_tabla)
public subroutine wf_sube_o_baja (string as_direccion)
public subroutine wf_setear_cod_prod (string as_codigo, integer ai_linea)
public subroutine wf_habilita_tabs (string as_habilita)
public function integer wf_convierte_a_unidades (datawindow adw_dw, integer ai_row, string as_unidad, long al_asignada, long al_disponible)
public subroutine wf_setea_dw_disponibles ()
public subroutine wf_scroll_a_disponibles (datawindow aldw_5, string as_producto, long al_linea)
public function integer wf_convierte_a_unidades_desglose (datawindow adw_dw, integer ai_row, string as_unidad, long al_cantidad, long al_asignada, long al_disponible)
public function string wf_titulo_desglose (datawindow adw_dw1, long al_row)
public subroutine wf_setea_campo_desglose (datawindow adw_dw1, datawindow adw_dw6, integer ai_linea_original, integer ai_linea_setear)
public function integer wf_salvar_desglose (datawindow adw_dw4)
public function integer wf_salvar_asignadas (datawindow adw_dw3, long al_linea, string as_unidad)
public function boolean wf_selec_printer (datawindow adw)
public function integer wf_valida_desglose (long al_linea)
public subroutine wf_recalcula_cubicaje (string ass_producto, long al_total, ref double ad_peso, ref double ad_cubicaje)
public subroutine wf_imprime_vendedor ()
public function long wf_extraer_ann (string ls_syntax)
public function string wf_extraer_pormayor (string ls_syntax)
public function long wf_extraer_bultos (string as_syntax)
public subroutine wf_pasar_todos ()
public subroutine wf_recuperar_packing ()
public function integer wf_validar_cantidad (datawindow adw_dw1, integer al_linea, string as_vienede)
public subroutine wf_setear_iniciales (datawindow ldw_1)
public subroutine wf_declara_child (datawindow ldw_1)
public function string wf_asigna_ultima_busqueda ()
public subroutine wf_asigna_busqueda (string as_codigo, integer ai_por_linea)
public function integer wf_blanquea_registro (datawindow adw_dw2, long al_row)
public subroutine wf_avance (long al_avance, long al_total)
end prototypes

event ue_busqueda;//Scrip para buscar los pedidos o las Facturas
tab_1.tabpage_1.dw_1.Triggerevent("ue_busqueda")
end event

event ue_post_aceptar;sqlca.autocommit = true
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

public function string wf_extraer_pedido (string ls_syntax);//Extrae el Numero de Pedido de la Cadena
//Llamada desde: ue_adicionar
string  ls_pedido
Integer li_pos, li_pos2

	li_pos    = Pos(ls_syntax, "'", 1)
	li_pos2   = Pos(ls_syntax, "'",li_pos + 1)
	ls_pedido = Mid(ls_syntax,li_pos + 1, li_pos2 - li_pos - 1) 

return ls_pedido
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

public subroutine wf_convert_uni (string as_med, long al_fracciones, ref long al_cantidad, ref long al_fraccion);/*Esta Función Convierte de Unidad Minima a la Unidad que se Quiere*/
//Llamada desde: ue_postitem, retrieveend del dw2

long ll_ucom, ll_mconvera,ll_frac
double ld_total
 
/*Extrae la Unidad comun "Pedo/Unidades/etc "*/
ll_ucom = gf_medi_prod(as_med)


/*Retorna el Factor de Converción a unidades minimas*/
ll_mconvera = gf_unidad_venta(as_med, ll_ucom)


If ll_mconvera <= 0 Then ll_mconvera = 1

ld_total = ( al_fracciones / ll_mconvera) 

ll_frac = (Mod(al_fracciones, ll_mconvera))
////messagebox("1",ld_frac)
//ld_frac = ld_frac*ld_mconvera
//messagebox("2",ld_frac)
//If ld_frac > ld_mconvera Then ld_frac = ld_frac /100

al_cantidad = Long(ld_total)
al_fraccion = ll_frac
end subroutine

public subroutine wf_setear_lineas_y_cantidades (datawindow adw_dw2);//Se Setea el numero de linea a los Registros del Detalle
//Llamada desde ue_aceptar, wf_blanquea_registro, ue_eliminar
integer i, li_filas
long	  ll_cantidad, ll_fraccion, ll_cant_total
string  ls_unidad

li_filas = adw_dw2.Rowcount()

for i = 1 to li_filas
	if adw_dw2.GetitemString(i,"empa_codigo_producto") = '' or isnull(adw_dw2.GetitemString(i,"empa_codigo_producto")) &
		or adw_dw2.Getitemnumber(i,"validado") = 0 then
		adw_dw2.Deleterow(i)
		i -- 					//Como elimine la fila, se decrementa el total y el indice
		li_filas --
	else
		//adw_dw2.Setitem(i,"empa_linea",i)				//Setea el numero de linea, no aplica
		adw_dw2.Setitem(i,"index",i)						//Setea el numero del indice
		ll_cantidad 	= adw_dw2.GetitemNumber(i,"empa_canti")
		ll_fraccion 	= adw_dw2.GetitemNumber(i,"empa_fraccion")	
		ls_unidad		= adw_dw2.GetItemString(i,"empa_unidad")
		ll_cant_total  = wf_convert_min(ls_unidad,ll_cantidad,ll_fraccion)
		adw_dw2.SetItem(i,"empa_cantidad",ll_cant_total)
	end if
next
end subroutine

public function long wf_convert_min (string as_med, long al_cantidad, long al_fraccion);/*Esta función recibe la cantidad y fracción y retorna todo convertido a fracción*/
//Llamada desde: retrieveend del DW 4, wf_validar_cantidad()

Long ll_ucom, ll_mconvera, ll_total

/*Extrae la Unidad comun "Pedo/Unidades/etc "*/
ll_ucom = gf_medi_prod(as_med)

/*Retorna el Factor de Converción a unidades minimas*/
ll_mconvera = gf_unidad_venta(as_med, ll_ucom)

If ll_mconvera <= 0 Then ll_mconvera = 1

ll_total = (al_cantidad * ll_mconvera) + al_fraccion

Return (ll_total)
end function

public function integer wf_reestaurar_cant_eliminadas (datawindow adw_dw1, long al_linea);//Funciòn que Reestaura Cantidad Que se Introdujo que se esta eliminando
//Llamada desde: ue_eliminar, 

Long        ll_cantidad, ll_fraccion, ll_total, ll_disponible, ll_asignada
Integer     li_linea, li_row
String		ls_producto, ls_unidad, ls_expresion
DataWindow  ldw_4
ldw_4			= tab_1.tabpage_1.dw_4

	ll_cantidad	 		=  adw_dw1.GetItemNumber(al_linea, "empa_canti")
	ll_fraccion	 		=	adw_dw1.GetItemNumber(al_linea, "empa_fraccion")
	ls_unidad    		=  adw_dw1.Getitemstring(al_linea, "empa_unidad")
	ll_total				=  wf_convert_min(ls_unidad,ll_cantidad, ll_fraccion)
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
	
		ll_disponible = ldw_4.Getitemnumber(li_row, "cant_disponible")
		ll_asignada	  = ldw_4.Getitemnumber(li_row, is_campo_asignada)		
					
		ldw_4.Setitem(li_row, "cant_disponible", ll_disponible + ll_total)
		ldw_4.Setitem(li_row, is_campo_asignada, ll_asignada - ll_total)

		//Distribuye lo disponible y lo asignado en Cantidad y Fraccion
		wf_convierte_a_unidades(ldw_4,li_row,ls_unidad,ll_asignada - ll_total,ll_disponible + ll_total)
									
	else
		gf_mensaje("","No Pudo Reestaurar la Cantidad Eliminada, Verifique.",1,1,"E")
		return -1
	end if
	
return 1
end function

public subroutine wf_setea_grupo_empresa (integer ai_fila, datawindow adw_object, string as_tabla);//Se Setea el grupo y empresa a la tabla que se envió como parametro

adw_object.SetItem(ai_fila,as_tabla+"_g_financiero", str.g_financiero) 
adw_object.SetItem(ai_fila,as_tabla+"_empresa", str.empresa) 
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

public subroutine wf_setear_cod_prod (string as_codigo, integer ai_linea); Datawindow		   ldw_2
 dwobject         dwo
 ldw_2 = tab_1.tabpage_2.dw_2
 
 ib_desde_ayuda = true
 ii_linea		 = ai_linea
 is_cod_prod	 = as_codigo
 is_col		    = "empa_codigo_producto"
 
 if as_codigo <> '' and not isnull(as_codigo) then
	 ldw_2.Setitem(ldw_2.Getrow(),"empa_codigo_producto",as_codigo)
	 ldw_2.trigger event itemchanged(ldw_2.getrow(),dwo,as_codigo)
 end if
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

public function integer wf_convierte_a_unidades (datawindow adw_dw, integer ai_row, string as_unidad, long al_asignada, long al_disponible);//Para mostrar lo Asignado y lo disponible en Cantidad Fraccion
//Llamado desde: ue_postitem, wf_blanquea_registro(), wf_validar_cantidad(),
//wf_reestaurar_cant_eliminadas(), retrieveend del DW4
//

Datawindow	ldw_4, ldw_5
Long  ll_cant_asig=0, ll_frac_asig=0, ll_cant_disp=0, ll_frac_disp=0
ldw_4 = tab_1.tabpage_1.dw_4
ldw_5 = tab_1.tabpage_2.dw_5

	wf_convert_uni(as_unidad,al_asignada,ll_cant_asig, ll_frac_asig) //Conv. lo Asignado
	adw_dw.Setitem(ai_row,"cant_asig",ll_cant_asig)	
	adw_dw.Setitem(ai_row,"frac_asig",ll_frac_asig)	
	wf_convert_uni(as_unidad,al_disponible,ll_cant_disp, ll_frac_disp)//Conv. lo Disponible
	adw_dw.Setitem(ai_row,"cant_disp",ll_cant_disp)	
	adw_dw.Setitem(ai_row,"frac_disp",ll_frac_disp)			

	if isvalid(ldw_5) and isvalid(ldw_4) then
//		ldw_5.object.data = ldw_4.Object.data no se dirigía de nuevo
		ldw_4.sharedata(ldw_5)
	else
		gf_mensaje("","Error en el Data, wf_convierte a unidades()",1,1,"E")
	end if
return 1
end function

public subroutine wf_setea_dw_disponibles ();//Setea el DW de Cantidades Disponibles 
//Llamado desde: wf_recupera_packing(), retrieveend del dw4
Integer   li_resultado=0

Datawindow ldw_4, ldw_5, ldw_6
ldw_4		= tab_1.tabpage_1.dw_4
ldw_5	   = tab_1.tabpage_2.dw_5
ldw_6		= tab_1.tabpage_2.dw_6

if is_fuente = 'PE' then //PEDIDOS
	ldw_5.Dataobject = "dw_ma_fa_pedi_cantidades_packing"
	ldw_5.Settransobject(sqlca)	
	
	ldw_6.Dataobject = "dw_ma_fa_pedi_desglose_packing"
	ldw_6.Settransobject(sqlca)
		
else							 //FACTURAS
	ldw_5.Dataobject = "dw_ma_fa_fact_cantidades_packing"
	ldw_5.Settransobject(sqlca)

	ldw_6.Dataobject = "dw_ma_fa_fact_desglose_packing"
	ldw_6.Settransobject(sqlca)	

end if

if isvalid(ldw_5) and isvalid(ldw_4) then
	ldw_5.object.data = ldw_4.Object.data
end if
end subroutine

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

//messagebox("Scroll to --> ",string(ll_row) +" de "+string(aldw_5.rowcount()))

if ll_row > 0 then
	li_resultado = aldw_5.Scrolltorow(ll_row)
else
	gf_mensaje("","No Pudo Encontrar el Producto Actual",1,1,"E")
end if

end subroutine

public function integer wf_convierte_a_unidades_desglose (datawindow adw_dw, integer ai_row, string as_unidad, long al_cantidad, long al_asignada, long al_disponible);//Para mostrar lo Asignado y lo disponible en Cantidad Fraccion
//Llamado desde: retrieveend del DW6

Long  ll_cant_asig=0, ll_frac_asig=0, ll_cant_disp=0, ll_frac_disp=0
	
	wf_convert_uni(as_unidad,al_cantidad,ll_cant_asig, ll_frac_asig) //Conv. la Cantidad
	adw_dw.Setitem(ai_row,"cant_canti",ll_cant_asig)	
	adw_dw.Setitem(ai_row,"frac_canti",ll_frac_asig)	
	wf_convert_uni(as_unidad,al_asignada,ll_cant_asig, ll_frac_asig) //Conv. lo Asignado
	adw_dw.Setitem(ai_row,"cant_asig",ll_cant_asig)	
	adw_dw.Setitem(ai_row,"frac_asig",ll_frac_asig)	
	wf_convert_uni(as_unidad,al_disponible,ll_cant_disp, ll_frac_disp)//Conv. lo Disponible
	adw_dw.Setitem(ai_row,"cant_disp",ll_cant_disp)	
	adw_dw.Setitem(ai_row,"frac_disp",ll_frac_disp)			

return 1
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

public subroutine wf_setea_campo_desglose (datawindow adw_dw1, datawindow adw_dw6, integer ai_linea_original, integer ai_linea_setear);string ls_expresion
long   ll_row

	ls_expresion = "linea = "+string(ai_linea_original)
	ll_row	= adw_dw6.Find(ls_expresion,1,adw_dw6.Rowcount())
	if ll_row > 0 then
		adw_dw1.Setitem(ai_linea_setear,"desglose",1)
	end if

end subroutine

public function integer wf_salvar_desglose (datawindow adw_dw4);Datawindow ldw_7
long		ll_row, ll_cantidad, ll_filas
string	ls_expresion, ls_cod_color, ls_cod_tama, ls_cod_largo, ls_cod_grupo
integer  i, li_resultado

ldw_7 	= tab_1.tabpage_2.dw_7

ll_filas = adw_dw4.Rowcount()

for i = 1 to ll_filas
	
	 ll_cantidad  = adw_dw4.Getitemnumber(i,"fade_cantidad")
	 ls_cod_color = adw_dw4.Getitemstring(i,"fade_color")
	 ls_cod_tama  = adw_dw4.Getitemstring(i,"fade_tama")
	 ls_cod_largo = adw_dw4.Getitemstring(i,"fade_tamb")
	 ls_cod_grupo = adw_dw4.Getitemstring(i,"fade_grupo_tam")
	
	 ls_expresion = "fade_linea = "+string(str_desglose.linea)+" and fade_color = '"+ls_cod_color+"' and fade_tama = '"+ls_cod_tama+"' and "+ &
	                "fade_tamb = '"+ls_cod_largo+"' and fade_grupo_tam = '"+ls_cod_grupo+"'"
	 
	 ll_row = ldw_7.Find(ls_expresion, 1, ldw_7.Rowcount())
	 
	 if ll_row > 0 then
		if ll_cantidad = 0 then
			ldw_7.deleterow(ll_row)
			ll_filas --
			i --
		else
			ldw_7.Setitem(ll_row,"fade_cantidad",ll_cantidad)
		end if
	 else
		if ll_cantidad > 0 then
			 adw_dw4.RowsCopy(i, i, Primary!, ldw_7, 10000, Primary!)
		end if
	 end if
next

li_resultado = ldw_7.Update()

return li_resultado
end function

public function integer wf_salvar_asignadas (datawindow adw_dw3, long al_linea, string as_unidad);Datawindow ldw_6
long		ll_row, ll_cantidad, ll_lineas, ll_row_actual, ll_asignadas, ll_disponible
string	ls_expresion, ls_cod_color, ls_cod_tama, ls_cod_largo, ls_cod_grupo, ls_unidad
integer  i, li_resultado

ldw_6 	 = tab_1.tabpage_2.dw_6

ll_lineas = adw_dw3.Rowcount()

for i = 1 to ll_lineas - 1 //Para que no valide el ultimo registro que es el blanco
 
 	ll_row_actual= adw_dw3.Getitemnumber(i,"linea")
 
 	if ll_row_actual <> al_linea then continue  //Si no es la linea actual, que no haga nada
 
   ll_asignadas = adw_dw3.Getitemnumber(i,"asignada")
	ll_disponible = adw_dw3.Getitemnumber(i,"cant_disponible")
	ls_cod_color = adw_dw3.Getitemstring(i,"cod_color")
	ls_cod_tama  = adw_dw3.Getitemstring(i,"cod_tama")
	ls_cod_largo = adw_dw3.Getitemstring(i,"cod_largo")
	ls_cod_grupo = adw_dw3.Getitemstring(i,"cod_grupo_tam")
	
	ls_expresion = "cod_color = '"+ls_cod_color+"' and cod_tama = '"+ls_cod_tama+"' and "+ &
	               "cod_largo = '"+ls_cod_largo+"' and cod_grupo_tam = '"+ls_cod_grupo+"'"
	
	ll_row = ldw_6.Find(ls_expresion, 1, ldw_6.Rowcount())
		 
	  if ll_row > 0 then
//		 messagebox("Seteando ",ll_cantidad)

		 ldw_6.Setitem(ll_row,"asignada",ll_asignadas)
		 ldw_6.Setitem(ll_row,"cant_disponible",ll_disponible)
		 
		 ll_cantidad = ldw_6.Getitemnumber(ll_row,"cantidad")
		 
		 //Función que convierte lo asignado y disponible en cantidades y fracciones
	  	 wf_convierte_a_unidades_desglose(ldw_6,ll_row,as_unidad,ll_cantidad,ll_asignadas,ll_disponible)
			
	  else
		 gf_mensaje("","No se Pudo Setear lo Asignado",1,1,"E")
	  end if

next

li_resultado = 1  	//ldw_6.Update()

return li_resultado
end function

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
			gf_dg_tamano_pagina(str_pedi.largo_doc,str_pedi.ancho_doc,adw)
			Return true
		else
			Return false
	end If
//*****************************************************/

end function

public function integer wf_valida_desglose (long al_linea);integer li_recupero

if is_fuente = 'FA' then

//  SELECT count(*)  
//    INTO :li_recupero  
//    FROM fadcandi  
//   WHERE ( fadcandi.dcdi_g_financiero = :str.g_financiero ) AND  
//         ( fadcandi.dcdi_empresa = :str.empresa ) AND  
//         ( fadcandi.dcdi_tipo = :is_tipo ) AND  
//         ( fadcandi.dcdi_no_pedido = :is_pedido ) AND  
//         ( fadcandi.dcdi_linea = :al_linea ) AND  
//         ( fadcandi.dcdi_anno = :il_ann )   ;
  SELECT count(*)   
    INTO :li_recupero   
    FROM fadesgfa  
   WHERE ( fadesgfa.desg_g_financiero = :str.g_financiero ) AND  
         ( fadesgfa.desg_empresa = :str.empresa ) AND  
         ( fadesgfa.desg_tipo = :is_tipo ) AND  
         ( fadesgfa.desg_no_pedido = :is_pedido ) AND  
         ( fadesgfa.desg_linea = :al_linea ) AND  
         ( fadesgfa.desg_anno = :il_ann )   ;

	
	if sqlca.sqlcode = -1 then
		gf_mensaje("","Error al Validar Existencia de desglose (FA) "+sqlca.sqlerrtext,1,1,"E")
	end if
	
else	
	
//	SELECT count(*)  
//    INTO :li_recupero  
//    FROM fadcanpe  
//   WHERE ( fadcanpe.dcpe_g_financiero = :str.g_financiero ) AND  
//         ( fadcanpe.dcpe_empresa = :str.empresa ) AND  
//         ( fadcanpe.dcpe_no_pedido = :is_pedido ) AND  
//         ( fadcanpe.dcpe_anno =:il_ann  ) AND  
//         ( fadcanpe.dcpe_linea =:al_linea  )   ;
  SELECT count(*)   
    INTO :li_recupero   
    FROM fadesgpe  
   WHERE ( fadesgpe.desg_g_financiero = :str.g_financiero ) AND  
         ( fadesgpe.desg_empresa = :str.empresa ) AND  
         ( fadesgpe.desg_no_pedido = :is_pedido ) AND  
         ( fadesgpe.desg_linea = :al_linea ) AND  
         ( fadesgpe.desg_anno = :il_ann )   ;
			
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

public subroutine wf_recalcula_cubicaje (string ass_producto, long al_total, ref double ad_peso, ref double ad_cubicaje);string  ls_unidad_empaque
integer li_empaque
long	  ll_conver, ll_ucon

datawindow ldw_2
ldw_2 = tab_1.tabpage_2.dw_2
ad_peso = 0 
ad_cubicaje = 0

  SELECT inmprodu.prod_peso,   
         inmprodu.prod_cubicaje,   
         inmprodu.prod_empaque * inamedid.medi_cantidad  
    INTO :ad_peso,   
         :ad_cubicaje,   
         :ll_conver  
    FROM inmprodu,   
         inamedid  
   WHERE ( inmprodu.prod_empaque_um = inamedid.medi_medida ) and  
         ( ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
         ( inmprodu.prod_empresa = :str.empresa ) AND  
         ( inmprodu.prod_producto = :ass_producto ) )   ;

//  SELECT inmprodu.prod_peso,   
//         inmprodu.prod_cubicaje  
//    INTO :asl_peso,   
//         :asl_cubicaje
//    FROM inmprodu  
//   WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
//         ( inmprodu.prod_empresa = :str.empresa ) AND  
//         ( inmprodu.prod_producto = :ass_producto  )   ;
			
If sqlca.sqlcode = -1 then
	messagebox("ERROR","Error al obtener el cubicaje del maestro de producto")
	return
End If

ad_peso = (ad_peso / ll_conver) * al_total
ad_cubicaje = (ad_cubicaje / ll_conver) * al_total

//Asigna los nuevos valores del peso y cubicaje
ldw_2.SetItem(ldw_2.GetRow(),"empa_cubicaje",ad_cubicaje)
ldw_2.SetItem(ldw_2.GetRow(),"empa_peso",ad_peso)

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
					famvende  
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
					famvende  
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

public function long wf_extraer_ann (string ls_syntax);//Llamada desde: ue_adicionar, ue_busqueda

//Extrae el Año de la Cadena
long ll_ann
	
	ll_ann = long(Right(ls_syntax, 5))

return ll_ann
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

public function long wf_extraer_bultos (string as_syntax);//Extrae la cantidad total de bultos de la factura o pedido, de la Cadena
//Llamada desde: ue_adicionar

Integer  li_pos, li_pos2
long     ll_bultos_total
	li_pos 		    = pos(as_syntax,"_bultos_total = ",1)
	li_pos2			 = pos(as_syntax," ",li_pos + 16)
	ll_bultos_total = long(mid(as_syntax,li_pos + 16, li_pos2 - (li_pos + 16) ))

return ll_bultos_total
end function

public subroutine wf_pasar_todos ();//llamado desde el boton Pasar Todos

String  ls_prod, ls_bodega, ls_ubicacion, ls_uni_peso, ls_descrip, ls_unidad, data
Integer li_linea, i, li_linea_ori
long	  ll_disponible = 0, ll_row2, ll_cantidad, ll_fraccion, ll_asignada, row, ll_bultos, &
		  ll_ultimo_bulto = 0
double  ld_cubicaje, ld_peso
boolean lb_incrementar = false
datawindow ldw_4, ldw_5, ldw_2, ldw_6
dwobject         dwo

ldw_2 = tab_1.tabpage_2.dw_2
ldw_4 = tab_1.tabpage_1.dw_4
ldw_5 = tab_1.tabpage_2.dw_5
ldw_6 = tab_1.tabpage_2.dw_6

for i = 1 to ldw_4.rowcount()
		
		ll_disponible = ldw_4.GetitemNumber(i ,"cant_disponible") 
		
		ls_prod 		  = ldw_4.GetitemString(i ,"codigo_item")
		 
		if str_empaque.fuente = 'PE' then 
			li_linea		  = ldw_4.GetitemNumber(i ,"dped_linea")
		else
			li_linea		  = ldw_4.GetitemNumber(i ,"facd_linea")
		end if
	
		 //row = i
		 //ll_row2 = i
		 
		 ib_desde_ayuda = false
		 ii_linea		 = li_linea
		 is_cod_prod	 = ls_prod
		 is_col		    = "empa_codigo_producto"
		 
		 if ls_prod <> '' and not isnull(ls_prod) then			 
				  
				  //No se va a dar, ya que el mismo dw ya esta filtrado por bod+ubic <> transito
				  if ll_row2 > ldw_2.getrow() or lb_incrementar then
					ll_row2 ++
				  else
			 	  	ll_row2 = ldw_2.getrow()
				  end if
					
					row = ldw_2.getrow()
					
				  if is_fuente = 'PE' Then	//Si la fuente es de pedidos
						//PARA IR RECUPERANDO LOS BULTOS E IR ASIGNANDO EL INICIAL Y EL FINAL ESTIMADO
						ll_bultos 	 = ldw_4.getitemnumber(ll_row2,"dped_bultos")
						//Setear los Datos del Articulo								
						ls_bodega    = ldw_4.GetitemString(ll_row2,"dped_bodega")
						ls_ubicacion = ldw_4.GetitemString(ll_row2,"dped_ubicacion")						
						ld_cubicaje	 = ldw_4.GetitemNumber(ll_row2,"dped_cubicaje")
						ld_peso		 = ldw_4.GetitemNumber(ll_row2,"dped_peso")
						ls_uni_peso  = ldw_4.GetitemString(ll_row2,"dped_unidad_peso")
						ls_descrip	 =	ldw_4.GetitemString(ll_row2,"prod_descripcion")
						ls_unidad	 = ldw_4.GetitemString(ll_row2,"dped_unidad_venta")				
						li_linea_ori = ldw_4.GetitemNumber(ll_row2,"dped_linea")
						ll_disponible= ldw_4.GetitemNumber(ll_row2,"cant_disponible")
						//Seteo 0 a lo disponible, ya que estoy asignando todo por default,
						//Al Modificar la Cantidad, alimienta lo disponible y rebaja lo asignado
						ldw_4.SetItem(ll_row2,"cant_disponible",0)
						ll_asignada = ldw_4.GetitemNumber(ll_row2,"dped_cant_asignada")
						ldw_4.SetItem(ll_row2,"dped_cant_asignada",ll_asignada + ll_disponible)
						
						//Función que asigna la cantidad disponible, a su correspondiente cantidad y fraccion
						//ll_cantidad y ll_fraccion	se cargan por referencia, en la funcion
						wf_convert_uni(ls_unidad, ll_disponible, ll_cantidad, ll_fraccion)								
						
						//Función que convierte lo asignado y disponible en cantidades y fracciones
						wf_convierte_a_unidades(ldw_4,ll_row2,ls_unidad,ll_asignada + ll_disponible,0)
						
						//Si el Articulo, no tiene cant. disponible, que no permita,
						//Hacerle la Lista de Empaque a dicho producto
						if ll_cantidad + ll_fraccion = 0 then
							lb_incrementar = true //Para que tome los datos de la siguiente linea
							continue
						end if
						
						ldw_2.SetItem(row,"empa_bodega",ls_bodega)
						ldw_2.SetItem(row,"empa_ubicacion",ls_ubicacion)
						ldw_2.SetItem(row,"empa_cubicaje",ld_cubicaje)				
						ldw_2.SetItem(row,"empa_peso",ld_peso)								
						ldw_2.SetItem(row,"empa_unidad_peso",ls_uni_peso)
						ldw_2.SetItem(row,"prod_descripcion",ls_descrip)
						ldw_2.SetItem(row,"empa_unidad",ls_unidad)
						ldw_2.SetItem(row,"empa_canti",ll_cantidad)
						ldw_2.SetItem(row,"empa_fraccion",ll_fraccion)
						ldw_2.SetItem(row,"empa_linea_original",li_linea_ori)				
						
						ldw_2.SetItem(row,"validado",1)	//Para saber que el Articulo está correcto
						
						ldw_2.SetColumn('empa_cubicaje')
						
					else
						//Si viene de Facturación
						//PARA IR RECUPERANDO LOS BULTOS E IR ASIGNANDO EL INICIAL Y EL FINAL ESTIMADO
						ll_bultos 	 = ldw_4.getitemnumber(ll_row2,"facd_bultos")						
						//Setear los Datos del Articulo							
						ls_bodega    = ldw_4.GetitemString(ll_row2,"facd_bodega")
						ls_ubicacion = ldw_4.GetitemString(ll_row2,"facd_ubicacion")						
						ld_cubicaje	 = ldw_4.GetitemNumber(ll_row2,"facd_cubicaje")
						ld_peso		 = ldw_4.GetitemNumber(ll_row2,"facd_peso")
						ls_uni_peso  = ldw_4.GetitemString(ll_row2,"facd_unidad_peso")
						ls_descrip	 =	ldw_4.GetitemString(ll_row2,"prod_descripcion")
						ls_unidad	 = ldw_4.GetitemString(ll_row2,"facd_unidad_venta")				
						li_linea_ori = ldw_4.GetitemNumber(ll_row2,"facd_linea")
						ll_disponible= ldw_4.GetitemNumber(ll_row2,"cant_disponible")									
						//Seteo 0 a lo disponible, ya que estoy asignando todo por default,
						//Al Modificar la Cantidad, alimienta lo disponible y rebaja lo asignado
						ldw_4.SetItem(ll_row2,"cant_disponible",0)
						ll_asignada = ldw_4.GetitemNumber(ll_row2,"facd_cant_asignada")				
						ldw_4.SetItem(ll_row2,"facd_cant_asignada",ll_asignada + ll_disponible)
						
						//Función que asigna la cantidad disponible, a su correspondiente cantidad y fraccion
						//ll_cantidad y ll_fraccion	se cargan por referencia, en la funcion
						wf_convert_uni(ls_unidad, ll_disponible, ll_cantidad, ll_fraccion)
		
						//Función que convierte lo asignado y disponible en cantidades y fracciones
						wf_convierte_a_unidades(ldw_4,ll_row2,ls_unidad, ll_asignada + ll_disponible,0)

						//Si el Articulo, no tiene cant. disponible, que no permita,
						//Hacerle la Lista de Empaque a dicho producto
						if ll_cantidad + ll_fraccion = 0 then
							lb_incrementar = true //Para que tome los datos de la siguiente linea
							continue
						end if						
						
						ldw_2.SetItem(row,"empa_bodega",ls_bodega)
						ldw_2.SetItem(row,"empa_ubicacion",ls_ubicacion)
						ldw_2.SetItem(row,"empa_cubicaje",ld_cubicaje)				
						ldw_2.SetItem(row,"empa_peso",ld_peso)								
						ldw_2.SetItem(row,"empa_unidad_peso",ls_uni_peso)
						ldw_2.SetItem(row,"prod_descripcion",ls_descrip)
						ldw_2.SetItem(row,"empa_unidad",ls_unidad)
						ldw_2.SetItem(row,"empa_canti",ll_cantidad)
						ldw_2.SetItem(row,"empa_fraccion",ll_fraccion)
						ldw_2.SetItem(row,"empa_linea_original",li_linea_ori)
						
						ldw_2.SetItem(row,"validado",1)	//Para saber que el Articulo está correcto
						
						ldw_2.SetColumn('empa_cubicaje')
						
					end if	
					
					//Asigna el Codigo del Producto
					ldw_2.Setitem(row,"empa_codigo_producto",ls_prod)

					//ASIGNA LOS BULTOS INICIO Y FINAL A LOS CAMPOS CORRESPONDIENTES
					if ll_bultos <> 0 and not isnull(ll_bultos) then
						ldw_2.Setitem(row,"empa_bultos",ll_bultos)												
						ldw_2.Setitem(row,"empa_bulto_inicio",ll_ultimo_bulto + 1)						
						ldw_2.Setitem(row,"empa_bulto_fin",ll_ultimo_bulto + ll_bultos)
						ll_ultimo_bulto += ll_bultos 
					end if					 
					 
				//Dirige el cursor al producto actual
				//	wf_scroll_a_disponibles(ldw_5, ls_prod , li_linea_ori)
					
					//Para setear 1 o 0 al campo que identifica si la linea tiene desglose o no
					wf_setea_campo_desglose(ldw_2,ldw_6,li_linea_ori,row)
					
					//Para recalcular el Cubicaje y Peso de la Linea
					If ll_asignada > 0 then
						wf_recalcula_cubicaje(ls_prod,ll_disponible,ld_cubicaje, ld_peso)
					End If
		
	   end if //Del ls_prod <> '' and not isnull(ls_prod)
		
		ib_adicionar = true
		
		this.triggerevent('ue_adicionar')
		
		ldw_2.scrolltorow(ldw_2.rowcount())

next

//PARA QUE EL DW DEL DETALLE TOME EL FOCO
ldw_2.setfocus()
//Para que se posicione en el Primer Registro
if ldw_2.rowcount() > 1 then ldw_2.scrolltorow(1)
//Se posiciona en el bulto inicio
ldw_2.SetColumn('empa_bulto_inicio')				
//close(parent)
end subroutine

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

public function integer wf_validar_cantidad (datawindow adw_dw1, integer al_linea, string as_vienede);//Funciòn que valida la Cantidad Que se Introdujo y Setea la Cantidad que Queda Disponible
//Llamada desde: ue_postitem, 

Long        ll_cantidad, ll_fraccion, ll_total, ll_disponible, ll_asignada, ll_cant_anterior
Integer     li_linea, li_row
String		ls_producto, ls_unidad, ls_expresion
DataWindow  ldw_4
ldw_4			= tab_1.tabpage_1.dw_4
double		ld_peso,ld_cubicaje
	ll_cantidad	 		=  adw_dw1.GetItemNumber(al_linea, "empa_canti")
	ll_fraccion	 		=	adw_dw1.GetItemNumber(al_linea, "empa_fraccion")
	ls_unidad    		=  adw_dw1.Getitemstring(al_linea, "empa_unidad")
	ll_total				=  wf_convert_min(ls_unidad,ll_cantidad, ll_fraccion)

	if ll_total = 0 or isnull(ll_total) then 
		gf_mensaje("","La Cantidad está en 0, al Salvar El Registro Será Eliminado",1,1,"E")
		adw_dw1.SetItem(al_linea,"validado",0)	//Para saber que el Articulo está incorrecto	
	else
		adw_dw1.SetItem(al_linea,"validado",1)	//Para saber que el Articulo está correcto
	end if
	
	ll_cant_anterior 	=  wf_convert_min(ls_unidad,il_canti, il_fraccion) //Cargadas en el Itemfocuschanged
	ls_producto  		=  adw_dw1.Getitemstring(al_linea, "empa_codigo_producto")
	li_linea		 		=  adw_dw1.GetitemNumber(al_linea, "empa_linea_original")
	if is_fuente = 'PE' then
		ls_expresion 		=  "codigo_item = '"+ls_producto+"' and dped_linea = "+string(li_linea)
	else
		ls_expresion 		=  "codigo_item = '"+ls_producto+"' and facd_linea = "+string(li_linea)
	end if
	//Busca en el DW4
	li_row		 		=  ldw_4.Find(ls_expresion,1,ldw_4.Rowcount())
	
	if li_row > 0 then  //Si encuentra el Articulo en el dw4 Pedido
	
		ll_disponible = ldw_4.Getitemnumber(li_row, "cant_disponible")
		ll_asignada	  = ldw_4.Getitemnumber(li_row, is_campo_asignada)		
		
		if ll_disponible + ll_cant_anterior >= ll_total then
			
			ldw_4.Setitem(li_row, "cant_disponible", ll_disponible + ll_cant_anterior - ll_total)
			ldw_4.Setitem(li_row, is_campo_asignada, ll_asignada - ll_cant_anterior + ll_total)
			//Distribuye lo disponible y lo asignado en Cantidad y Fraccion
			wf_convierte_a_unidades(ldw_4,li_row,ls_unidad,ll_asignada - ll_cant_anterior + ll_total,ll_disponible + ll_cant_anterior - ll_total)
			
			wf_recalcula_cubicaje(ls_producto,ll_total,ld_peso,ld_cubicaje)
			
		else
			gf_mensaje("","La Cantidad, Ha Sobrepasado lo Disponible",1,1,"E")
			
			if as_vienede = "CANTI" then
				adw_dw1.Setitem(al_linea,"empa_canti",0)
				//Se actualizan lo disponible y lo asignado sumando lo de la Fraccion
				ldw_4.Setitem(li_row, "cant_disponible", ll_disponible + ll_cant_anterior - ll_fraccion)
				ldw_4.Setitem(li_row, is_campo_asignada, ll_asignada - ll_cant_anterior + ll_fraccion)
				//Distribuye lo disponible y lo asignado en Cantidad y Fraccion
				wf_convierte_a_unidades(ldw_4,li_row,ls_unidad,ll_asignada - ll_cant_anterior + ll_fraccion,ll_disponible + ll_cant_anterior - ll_fraccion)
			else
				adw_dw1.Setitem(al_linea,"empa_fraccion",0)
				//Se actualizan lo disponible y lo asignado sumando lo de la Cantidad
				ll_total				=  wf_convert_min(ls_unidad,ll_cantidad, 0)
				ldw_4.Setitem(li_row, "cant_disponible", ll_disponible + ll_cant_anterior - ll_total)
				ldw_4.Setitem(li_row, is_campo_asignada, ll_asignada - ll_cant_anterior + ll_total)
				//Distribuye lo disponible y lo asignado en Cantidad y Fraccion
				wf_convierte_a_unidades(ldw_4,li_row,ls_unidad,ll_asignada - ll_cant_anterior + ll_total,ll_disponible + ll_cant_anterior - ll_total)
			end if	
			
			return -1			
			
		end if
	else
		gf_mensaje("","No Pudo Rebajar la Cantidad Disponible, Verifique.",1,1,"E")
		return -1
	end if
	
return 1
end function

public subroutine wf_setear_iniciales (datawindow ldw_1);//Setea los Valores Iniciales del DW
//Llamada desde: wf_recupera_packing, ue_post_open, ue_adicionar

String ls_lista, ls_autorizo

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
	
	/* Datos de Pedido */
	
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
		( faempbod.faem_empresa = :str.empresa )  and
		(( faempbod.faem_cargo = 'A') or ( faempbod.faem_cargo = 'S') );
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

public function string wf_asigna_ultima_busqueda ();//Función en la que se asigna dinamicamente la ultima busqueda a la ventana de busqueda
return is_prod_buscar
end function

public subroutine wf_asigna_busqueda (string as_codigo, integer ai_por_linea);//Funcion llamada desde ventana de busqueda, para asignar los valores
is_prod_buscar = as_codigo
ii_por_linea	= ai_por_linea
end subroutine

public function integer wf_blanquea_registro (datawindow adw_dw2, long al_row);//Blanquea el Registro Del Detalle
integer		li_resultado = 2, li_linea
Long			ll_cantidad, ll_fraccion, ll_total, ll_row, ll_disponible, ll_asignada
String		ls_unidad, ls_producto, ls_expresion
Datawindow	ldw_4
ldw_4			=	tab_1.tabpage_1.dw_4

if adw_dw2.GetitemNumber(al_row,"validado") = 1 then
	
	li_resultado = gf_mensaje("","El Registro Modificado, Será Eliminado, Está Seguro ?",2,2,"E")
	
	if li_resultado = 1 then
		
		//Extrae la Cantidad que tenia asociada, y la reestaura en dw4
		ls_unidad	= adw_dw2.GetitemString(al_row,"empa_unidad")		
		ll_cantidad = adw_dw2.GetitemNumber(al_row,"empa_canti")		
		ll_fraccion = adw_dw2.GetitemNumber(al_row,"empa_fraccion")				
		ll_total		= wf_convert_min(ls_unidad, ll_cantidad, ll_fraccion)
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
			ll_disponible = ldw_4.Getitemnumber(ll_row, "cant_disponible")
			ll_asignada	  = ldw_4.Getitemnumber(ll_row, is_campo_asignada)		
			ldw_4.Setitem(ll_row, "cant_disponible", ll_disponible + ll_total)
			ldw_4.Setitem(ll_row, is_campo_asignada, ll_asignada - ll_total)
			
			//Distribuye lo disponible y lo asignado en Cantidad y Fraccion
			wf_convierte_a_unidades(ldw_4,ll_row,ls_unidad,ll_asignada - ll_total,ll_disponible + ll_total)							
			
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
			//	ole_2.object.value = 0
						
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

public subroutine wf_avance (long al_avance, long al_total);//Marca el Avance en la barra
//Llamada desde: ue_adicionar, wf_modificar_barra()

//**ole_2.Object.Value = (al_avance / al_total) * 100
end subroutine

on w_fa_man_packing_list_ac.create
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

on w_fa_man_packing_list_ac.destroy
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

if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 then
	Tab_1.tabpage_1.DW_1.dataobject='dw_ma_fa_enca_packing_acisa'
	tab_1.tabpage_2.dw_2.dataobject='dw_ma_fa_deta_packing_acisa'
else
	Tab_1.tabpage_1.DW_1.dataobject='dw_ma_fa_enca_packing'
	tab_1.tabpage_2.dw_2.dataobject='dw_ma_fa_deta_packing'
end if

str_empaque.viene_de_ventana=this.className()


ldw_1 = Tab_1.tabpage_1.DW_1

ldw_1.SetTransObject(SQLCA);
Tab_1.tabpage_2.DW_2.SetTransObject(SQLCA);
Tab_1.tabpage_3.DW_3.SetTransObject(SQLCA);
Tab_1.tabpage_2.DW_7.SetTransObject(SQLCA);
//Datawindow de trabajo para recuperar detalle del packing list de Textiles
Tab_1.tabpage_3.DW_8.SetTransObject(SQLCA);

f_create_external_func_uo(iu_externa)	
//
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

//Habilita la Barra
//**ole_2.Show()

end event

event open;call super::open;//Centrea la Ventana
//gf_center_win(this)
//this.y = 5
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

String				ls_syntax, ls_empaque, ls_pedido
long					ll_row_final, ll_row, ll_bultos_total
Integer				li_recupero, li_resp
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
		li_resp = gf_mensaje("","La Lista de Empaque se Generara de Pedidos ?",4,1,"Q") 
		
		if li_resp = 3 then
			is_pedido = ''	
			wf_setear_iniciales(ldw_1)
			iw_this.Setredraw(true)			
			return
		end if

		if li_resp = 1 then
				is_fuente = 'PE'
				is_campo_asignada			  = "dped_cant_asignada"				
				ldw_4.DataObject = "dw_ma_fa_pedi_packing"	//DW de PEDIDOS
//NO TOCAR EL ORDEN DE LOS CAMPOS, NI LOS NOMBRES; YA QUE SE UTILIZAN PARA EXTRAER LOS CODIGOS

				lstr_df.texto_campo[1, 1] = "fatpedid.pedi_no_pedido"
				lstr_df.texto_campo[1, 2] = "No. Pedido"
				lstr_df.texto_campo[1, 3] = "fatpedid.pedi_no_pedido"
				lstr_df.texto_campo[1, 4] = "V"
				lstr_df.texto_campo[2, 1] = "dgmterce.terc_descripcion"
				lstr_df.texto_campo[2, 2] = "Descripcion"
				lstr_df.texto_campo[2, 3] = "dgmterce_terc_descripcion"
				lstr_df.texto_campo[2, 4] = "V"		
				lstr_df.texto_campo[2, 5] = "500"				
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
				lstr_df.texto_campo[7, 1] = "fatpedid.pedi_bultos_total"
				lstr_df.texto_campo[7, 2] = ""
				lstr_df.texto_campo[7, 3] = "fatpedid_pedi_bultos_total"
				lstr_df.texto_campo[7, 4] = "I"																
				lstr_df.texto_campo[8, 1] = "fatpedid.pedi_ann"
				lstr_df.texto_campo[8, 2] = "Año"
				lstr_df.texto_campo[8, 3] = "fatpedid_pedi_ann"
				lstr_df.texto_campo[8, 4] = "V"								
				lstr_df.tabla				  = "  dgmterce, fatpedid"
				lstr_df.tabla_where		  = "  WHERE ( fatpedid.pedi_g_financiero = "+string(str.g_financiero)+" ) AND  "+&
												    " ( fatpedid.pedi_empresa = "+string(str.empresa)+" ) AND "+&
													 " ( fatpedid.pedi_cliente = dgmterce.terc_tercero ) And "+ &
													 "	( fatpedid.pedi_autorizacion is not null ) And "+ &
													 " ( fatpedid.pedi_autorizacion <> '' )"

		else
			
				is_fuente = 'FA'
				is_campo_asignada			  = "facd_cant_asignada"				
				ldw_4.DataObject 			  = "dw_ma_fa_fact_packing" //DW de FACTURA
//NO TOCAR EL ORDEN DE LOS CAMPOS, NI LOS NOMBRES; YA QUE SE UTILIZAN PARA EXTRAER LOS CODIGOS

				lstr_df.texto_campo[1, 1] = "fatdiari.fact_no_pedido"
				lstr_df.texto_campo[1, 2] = "No. Pedido"
				lstr_df.texto_campo[1, 3] = "fatdiari_fact_no_pedido"
				lstr_df.texto_campo[1, 4] = "V"
				lstr_df.texto_campo[2, 1] = "dgmterce.terc_descripcion"
				lstr_df.texto_campo[2, 2] = "Nombre"
				lstr_df.texto_campo[2, 3] = "dgmterce_terc_descripcion"
				lstr_df.texto_campo[2, 4] = "V"
				lstr_df.texto_campo[2, 5] = "500"				
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
				lstr_df.texto_campo[7, 1] = "fatdiari.fact_bultos_total"
				lstr_df.texto_campo[7, 2] = ""
				lstr_df.texto_campo[7, 3] = "fatdiari_fact_bultos_total"
				lstr_df.texto_campo[7, 4] = "I"												
				lstr_df.texto_campo[8, 1] = "fatdiari.fact_ann"
				lstr_df.texto_campo[8, 2] = "Año"
				lstr_df.texto_campo[8, 3] = "fatdiari_fact_ann"
				lstr_df.texto_campo[8, 4] = "V"				
				lstr_df.tabla				  = " fatdiari , dgmterce "
				lstr_df.tabla_where		  = " WHERE ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) and "+ &
													 " ( fatdiari.fact_empresa = "+string(str.empresa)+" ) and "+ &
													 " ( fatdiari.fact_cliente = dgmterce.terc_tercero ) and "+ &
													 "	( fatdiari.fact_no_pedido not like '%NC%' ) and "+&
													 " ( fatdiari.fact_autorizacion <> '') and "+&
													 " ( fatdiari.fact_autorizacion is not null)"
													 				
				//lstr_df.tabla_where		  = " "				 
		//		messagebox("Where",lstr_df.tabla_where)		
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
			ll_bultos_total= wf_extraer_bultos(ls_syntax)
//			
			//Recupera los Artículos del Pedido o Factura, a la Que se le Hará Lista de Empaque
			if is_fuente = 'PE' then
				ldw_4.Settransobject(sqlca)
				if ldw_4.Retrieve(str.g_financiero, str.empresa, is_pedido, il_ann, w_fa_fondo.str_para.bodega_en_transito, w_fa_fondo.str_para.ubicacion_en_transito) = 0 then
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
//		ole_2.object.value = 0
		
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
			if gf_mensaje("","Ya Existe una Lista de Empaque para Este Pedido, Desea Continuar ",2,2,"E")  = 2 then
				is_pedido = ''
			end if
		end if
		
		ldw_1.Setitem(ldw_1.getrow(),'enca_bultos_total',ll_bultos_total)
		
		//Asigna los datos iniciales del Encabezado de la Lista de Empaque
		wf_setear_iniciales(ldw_1)
		
//		Messagebox("Syntax devuelta", ls_syntax)
		
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
		
		ll_row_final = ldw_2.Rowcount()
		
		//Setea la unidad del cubicaje
		ldw_2.SetItem(ll_row_final,"empa_unidad_cubicaje",is_unidad_cubicaje)
		
		//Setea la Llave Primaria del Detalle del Empaque
		wf_setea_grupo_empresa(ll_row_final, ldw_2, "empa")		//Setea el Grupo y empresa
		
		//Setea Numero de Lista y Año
		ldw_2.SetItem(ll_row_final,"empa_lista_empaque",is_empaque)
		ldw_2.SetItem(ll_row_final,"empa_ann",il_ann_empa)
		
		//Setea el Numero del Indice
		ldw_2.SetItem(ll_row_final,"index",ll_row_final)

		//Setea el numero de linea
		ll_row = gf_buscar_ultima_linea(ldw_2, ll_row_final, "empa_linea")
		ldw_2.Setitem(ll_row_final,"empa_linea",ll_row)				
		
		if ldw_2.Rowcount() = 1 then  //Si es la linea # 1, setear bulto del uno al uno
			ldw_2.SetItem(ll_row_final,"empa_bulto_inicio",1)
			ldw_2.SetItem(ll_row_final,"empa_bulto_fin",1)
		else									//Setea lo Seteado, Anteriormente
			ldw_2.SetItem(ll_row_final,"empa_bulto_inicio",ldw_2.GetItemNumber(ll_row_final - 1,"empa_bulto_inicio"))
			ldw_2.SetItem(ll_row_final,"empa_bulto_fin",ldw_2.GetItemNumber(ll_row_final - 1,"empa_bulto_fin"))
		end if
		
		idw_proximo.SetColumn(1)
		
		This.Setredraw(true)
	
End if //del idw_proximo = ldw_1
end event

event ue_aceptar;//Override
This.Setredraw(false)

long 			 ll_update, ll_update2
string 		 ls_codigo_producto
DwItemStatus ls_estatus
Datawindow   ldw_1, ldw_2

ldw_1 = tab_1.tabpage_1.dw_1
ldw_2 = tab_1.tabpage_2.dw_2

ls_estatus = ldw_1.GetitemStatus(ldw_1.Getrow(),0,Primary!)

// FALTA LA ACTUALIZACIÓN DEL DESGLOSE

//Acepta el texto actual
ldw_1.Accepttext()
ldw_2.Accepttext()

if tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(),'enca_pasado') = 'S' then
	gf_mensaje('','No Puede Modificar una Lista de Empaque que paso a Factura !!',1,1,'E')
	This.Setredraw(true)	
	return 
end if

sqlca.autocommit = false

this.postevent('ue_post_aceptar')

/*Guarda el Detalle*/

if ldw_2.RowCount() > 0 then	
	ls_codigo_producto = ldw_2.Getitemstring(ldw_2.Rowcount(),"empa_codigo_producto") 
	if trim(ls_codigo_producto) = '' or isnull(ls_codigo_producto) then
		ldw_2.Deleterow(ldw_2.Rowcount())
	end if
End if	
	//Setea el numero de linea a los registros del detalle
	wf_setear_lineas_y_cantidades(ldw_2)
		
	ll_update2 =ldw_2.update()			//DETALLE
	
	if ll_update2 = -1  then
		This.Setredraw(true)
		return
		rollback using sqlca;
		messagebox("Atención","¡Error al Actualizar !")
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

		ldw_1.Retrieve(str.g_financiero, str.empresa, is_empaque, il_ann_empa)	
		ldw_1.SetItem(ldw_1.Getrow(),"cliente",is_cliente)	

		wf_habilita_tabs("S")  //Habilita los tabs
		
		messagebox("Atención","¡Actualización Exitosa !")
	else
		rollback using sqlca;
		messagebox("Atención","¡Error al Actualizar !")		
	end if


/***************************************/	

if idw_proximo = ldw_2 then	//Si se encuentra en el Tabpage 2 (dw_2), adiciona una linea
	ib_adicionar = true			//Para que no se valla al final, cuando inserta
	This.TriggerEvent("ue_adicionar")	
end if

This.Setredraw(true)
end event

event closequery;// Override
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
integer li_respuesta

li_respuesta = gf_mensaje("","Esta Seguro de Querer Eliminar este Registro ? "+"~n ~n"+"Los Datos Serán Grabados Automáticamente ", 2, 2 , "E") 
	
if li_respuesta = 2 then 
	this.Setredraw(true)		
	Return
end if


if idw_proximo.rowcount() > 0 then
	
  //Reestaura las cantidades eliminadas del detalle, al dw4
  if idw_proximo = tab_1.tabpage_2.dw_2 then
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
	//**	ole_2.object.value = 0
		This.Setredraw(true)
		return
	end if
	
else 
	messagebox("Atención","No hay registros para borrar!")	
end if

this.Triggerevent("ue_adicionar")

if tab_1.tabpage_2.dw_2 = idw_proximo and tab_1.tabpage_2.dw_2.rowcount() = 1 then
	tab_1.tabpage_2.cb_pasar.visible = true //Para que pueda pasar todos los articulos
end if

This.Setredraw(true)
end event

event timer;st_microhelp.visible = false
str.frame.Setmicrohelp("")
end event

event ue_print;If w_fa_fondo.str_para.lista_emp_especial = 1 then
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
If w_fa_fondo.str_para.lista_emp_especial = 1 then
	tab_1.Tabpage_3.dw_8.Print(True)
else
	tab_1.Tabpage_3.dw_3.Print(True)
end if

end event

event resize;call super::resize;this.setredraw(false)
//Alto de los objetos
tab_1.tabpage_3.dw_3.height = newheight - 260
tab_1.tabpage_3.gb_3.height = newheight - 195
tab_1.tabpage_2.gb_2.height = newheight - 195
tab_1.height= newheight - 65
tab_1.tabpage_2.dw_2.height = newheight - 380
tab_1.tabpage_2.dw_5.y = newheight - 340
//Ancho de los Objetos
tab_1.tabpage_3.dw_3.width  = newwidth - 100
tab_1.tabpage_3.gb_3.width  = newwidth - 70
tab_1.tabpage_2.gb_2.width  = newwidth - 80
tab_1.width = newwidth - 30
//Nombre de la Ventana
st_1.y = newheight - 55
//boton de pasar
tab_1.tabpage_2.cb_pasar.y = newheight - 300
this.setredraw(true)
end event

type tab_1 from w_fa_padre_tab`tab_1 within w_fa_man_packing_list_ac
integer x = 9
integer y = 0
integer width = 3031
integer height = 1656
integer taborder = 0
integer textsize = -8
fontcharset fontcharset = ansi!
boolean italic = true
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
					tab_1.tabpage_2.cb_pasar.visible = true //Para que pueda pasar todos los articulos
				end if
			end if
			
		else
			if idw_proximo.Deletedcount() < 1 then
				if idw_proximo.Retrieve(str.g_financiero, str.empresa, is_empaque,il_ann_empa ) < 1 then
					//Si no recupero nada, que adicione una linea en el detalle
					iw_this.TriggerEvent("ue_adicionar")
					tab_1.tabpage_2.cb_pasar.visible = true //Para que pueda pasar todos los articulos					
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
			ldw_3.visible = false
			tab_1.tabpage_3.dw_8.visible = true
			/*Hace visible checkbox para mostrar o no el precio y monto*/
			tab_1.tabpage_3.cbx_precio_monto.visible = true
			tab_1.tabpage_3.cbx_precio_monto.checked = true
			tab_1.tabpage_3.cbx_precio_monto.Triggerevent("clicked")
		else
			ldw_3.visible = true
			tab_1.tabpage_3.dw_8.visible = false
			tab_1.tabpage_3.cbx_precio_monto.checked = false
			/*Hace invisible checkbox para mostrar o no el precio y monto*/
			tab_1.tabpage_3.cbx_precio_monto.visible = false
		end if
	

		ldw_3.Retrieve(str.g_financiero,str.empresa,is_pedido,il_ann,is_empaque)
		ls_nomemp = str.nombre_empresa
//		ldw_3.modify("empresanom.expression = '"+ls_nomemp+"'")
		ldw_3.object.empresanom.expression = "'"+ls_nomemp+"'"

		//* Script para la asignacion del tamaño de página ....
		Integer	li_largo,li_ancho
		li_largo = 3000	// largo
		li_ancho = 2375	// ancho
	
		If is_win9598_winnt='win9598' then
			gf_dg_tamano_pagina(li_largo,li_ancho,ldw_3)
		end If
		
		if ldw_3.describe("datawindow.print.preview") = 'no' then
			//		ldw_3.object.datawindow.print.preview = 'yes'
			ldw_3.modify("datawindow.print.preview = 'yes'")
			//		ldw_3.object.datawindow.print.preview.zoom =100
			ldw_3.modify('datawindow.print.preview.zoom = 100')
		end if
	
end choose
end event

type tabpage_1 from w_fa_padre_tab`tabpage_1 within tab_1
integer width = 2994
integer height = 1528
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
integer x = 18
integer y = 40
integer width = 2871
integer height = 1460
string dataobject = "dw_ma_fa_enca_packing_acisa"
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
	lstr_df.texto_campo[1, 5] = "500"
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
	lstr_df.texto_campo[1, 5] = "500"	
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

//messagebox(" Where ",lstr_df.tabla_where)

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
				ldw_6.dataobject = "dw_ma_fa_pedi_desglose_packing"
				ldw_6.Settransobject(sqlca)														
				ldw_4.Dataobject = "dw_ma_fa_pedi_packing"
				ldw_4.Settransobject(sqlca)
				ldw_4.Retrieve(str.g_financiero, str.empresa, is_pedido, il_ann, w_fa_fondo.str_para.bodega_en_transito, w_fa_fondo.str_para.ubicacion_en_transito)
				ldw_3.DataObject = str_pedi.datawindow
				ldw_3.SetTransObject(sqlca)
			else
				is_tipo = wf_extraer_pormayor(ls_syntax)	//Extrae el tipo de Factura			
				ldw_6.dataobject = "dw_ma_fa_fact_desglose_packing"
				ldw_6.Settransobject(sqlca)				
				ldw_4.Dataobject = "dw_ma_fa_fact_packing"
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
Integer li_column
Long 	ll_row
Datawindow ldw_1

ldw_1 =  tab_1.tabpage_1.dw_1
ll_row = ldw_1.GetRow()

If  key = Keyenter!  Then
			
	li_column = ldw_1.getcolumn()+1
	
	if ldw_1.GetColumnName() = "enca_observacion" Then	
		li_column = 1
	end if
	ldw_1.setcolumn(li_column)
	ldw_1.setfocus()	
	return 2
End if




//iw_this.TriggerEvent("key")
end event

event dw_1::ue_postitem;string   ls_col
datetime ldt_fecha

if tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(),'enca_pasado') = 'S' then
	gf_mensaje('','No Puede Modificar una Lista de Empaque que paso a Factura !!',1,1,'E')
	return
end if

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
integer width = 2907
integer height = 1520
end type

type tabpage_2 from w_fa_padre_tab`tabpage_2 within tab_1
integer width = 2994
integer height = 1528
string text = "Detalle"
string picturename = "EditObject!"
long picturemaskcolor = 79741120
dw_5 dw_5
gb_2 gb_2
dw_6 dw_6
dw_7 dw_7
cb_pasar cb_pasar
end type

on tabpage_2.create
this.dw_5=create dw_5
this.gb_2=create gb_2
this.dw_6=create dw_6
this.dw_7=create dw_7
this.cb_pasar=create cb_pasar
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_5
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.dw_6
this.Control[iCurrent+4]=this.dw_7
this.Control[iCurrent+5]=this.cb_pasar
end on

on tabpage_2.destroy
call super::destroy
destroy(this.dw_5)
destroy(this.gb_2)
destroy(this.dw_6)
destroy(this.dw_7)
destroy(this.cb_pasar)
end on

type dw_2 from w_fa_padre_tab`dw_2 within tabpage_2
event ue_keydown pbm_dwnkey
event ue_enter pbm_dwnprocessenter
event type long ue_postitem ( long row,  dwobject dwo,  string data )
integer x = 18
integer y = 48
integer width = 2967
integer height = 1140
string dataobject = "dw_ma_fa_deta_packing_acisa"
boolean vscrollbar = true
end type

event dw_2::ue_keydown;//Llama al Evento de la Ventana Principal
long ll_encontro, ll_fila
string ls_expresion

dwobject dwo //Solo para rellenar los Argumentos

If keyDown(Keycontrol!) and keyDown(KeyShift!) Then
	iw_this.TriggerEvent("key")
elseif (keydown(keyControl!) and keydown(KeyI!)) or (keydown(keyControl!) and keydown(KeyG!)) then
	if (keydown(keyControl!) and keydown(KeyI!)) then
		openwithparm(w_fa_man_busqueda,iw_this)
	end if
	
	if is_prod_buscar <> '' then
		if ii_por_linea = 1 then
			//Buscar la linea
			ls_expresion = "index = "+is_prod_buscar
		else //Por referencia
			ls_expresion = "empa_codigo_producto = '"+is_prod_buscar+"'"
		end if
		ll_fila = this.getrow() + 1
		if ll_fila >= this.rowcount() then return
		ll_encontro = this.find(ls_expresion, ll_fila ,this.rowcount())
		if ll_encontro > 0 then
			this.scrolltorow(ll_encontro)
		else
			ls_expresion = "empa_codigo_producto like '"+is_prod_buscar+"%'"
			ll_encontro = this.find(ls_expresion, ll_fila ,this.rowcount())
			if ll_encontro > 0 then
				this.scrolltorow(ll_encontro)
			else
				gf_mensaje("","Articulo no Encontrado",1,1,"E")
			end if
		end if
	end if
	
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
											 
if li_columna = 8 then				//Si esta en la Cantidad y da enter, va al bulto inicial
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
long   		ll_row = 0, ll_row2 = 1, ll_total, ll_cantidad, ll_fraccion, ll_disponible, ll_asignada
Double		ld_cubicaje, ld_peso
integer		li_linea_ori, li_resultado

ldw_4    = tab_1.tabpage_1.dw_4
ldw_5    = tab_1.tabpage_2.dw_5
ldw_6		= tab_1.tabpage_2.dw_6

ll_total = ldw_4.RowCount()


if tab_1.tabpage_1.dw_1.getitemstring(tab_1.tabpage_1.dw_1.getrow(),'enca_pasado') = 'S' then
	gf_mensaje('','No Puede Modificar una Lista de Empaque que paso a Factura !!',1,1,'E')
	return 2
end if

//messagebox("Post Itemchanged","Entro columnna "+is_col+" data "+data)

choose case is_col  //is col se carga en el ue_enter, en el editchanged y en wf_setear_cod_prod()
		
	case	"empa_codigo_producto"
		
		ls_expresion = "codigo_item = '"+data+"'"+" and cant_disponible > 0 "

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
						this.Setcolumn('empa_codigo_producto')
						this.trigger event doubleclicked(1,1,this.getrow(),dwob)
						
						return 2
						
					end if
				
				 end if
				 
			 else	 							
				//Busca el registro segun la linea encontrada en La Ayuda de Articulos
				if is_fuente = 'PE' then
				  ls_expresion = "dped_linea = "+string(ii_linea)+" and cant_disponible > 0 "	
				else
				  ls_expresion = "facd_linea = "+string(ii_linea)+" and cant_disponible > 0 "
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
					This.Setcolumn("empa_codigo_producto")
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
				ll_disponible= ldw_4.GetitemNumber(ll_row2,"cant_disponible")									
				//Seteo 0 a lo disponible, ya que estoy asignando todo por default,
				//Al Modificar la Cantidad, alimienta lo disponible y rebaja lo asignado
				ldw_4.SetItem(ll_row2,"cant_disponible",0)
				ll_asignada = ldw_4.GetitemNumber(ll_row2,"dped_cant_asignada")
				ldw_4.SetItem(ll_row2,"dped_cant_asignada",ll_asignada + ll_disponible)
				
			   //Función que asigna la cantidad disponible, a su correspondiente cantidad y fraccion
				//ll_cantidad y ll_fraccion	se cargan por referencia, en la funcion
				wf_convert_uni(ls_unidad, ll_disponible, ll_cantidad, ll_fraccion)								
				
				//Función que convierte lo asignado y disponible en cantidades y fracciones
			   wf_convierte_a_unidades(ldw_4,ll_row2,ls_unidad,ll_asignada + ll_disponible,0)
	
				
				This.SetItem(row,"empa_bodega",ls_bodega)
				This.SetItem(row,"empa_ubicacion",ls_ubicacion)
				This.SetItem(row,"empa_cubicaje",ld_cubicaje)				
				This.SetItem(row,"empa_peso",ld_peso)								
				This.SetItem(row,"empa_unidad_peso",ls_uni_peso)
				This.SetItem(row,"prod_descripcion",ls_descrip)
				This.SetItem(row,"empa_unidad",ls_unidad)
				This.SetItem(row,"empa_canti",ll_cantidad)
				This.SetItem(row,"empa_fraccion",ll_fraccion)
				This.SetItem(row,"empa_linea_original",li_linea_ori)				
				
				This.SetItem(row,"validado",1)	//Para saber que el Articulo está correcto
				
				This.SetColumn("empa_cubicaje")
				
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
				ll_disponible= ldw_4.GetitemNumber(ll_row2,"cant_disponible")									
				//Seteo 0 a lo disponible, ya que estoy asignando todo por default,
				//Al Modificar la Cantidad, alimienta lo disponible y rebaja lo asignado
				ldw_4.SetItem(ll_row2,"cant_disponible",0)
				ll_asignada = ldw_4.GetitemNumber(ll_row2,"facd_cant_asignada")				
				ldw_4.SetItem(ll_row2,"facd_cant_asignada",ll_asignada + ll_disponible)
				
			   //Función que asigna la cantidad disponible, a su correspondiente cantidad y fraccion
				//ll_cantidad y ll_fraccion	se cargan por referencia, en la funcion
				wf_convert_uni(ls_unidad, ll_disponible, ll_cantidad, ll_fraccion)

				//Función que convierte lo asignado y disponible en cantidades y fracciones
			   wf_convierte_a_unidades(ldw_4,ll_row2,ls_unidad, ll_asignada + ll_disponible,0)
				
				This.SetItem(row,"empa_bodega",ls_bodega)
				This.SetItem(row,"empa_ubicacion",ls_ubicacion)
				This.SetItem(row,"empa_cubicaje",ld_cubicaje)				
				This.SetItem(row,"empa_peso",ld_peso)								
				This.SetItem(row,"empa_unidad_peso",ls_uni_peso)
				This.SetItem(row,"prod_descripcion",ls_descrip)
				This.SetItem(row,"empa_unidad",ls_unidad)
				This.SetItem(row,"empa_canti",ll_cantidad)
				This.SetItem(row,"empa_fraccion",ll_fraccion)
				This.SetItem(row,"empa_linea_original",li_linea_ori)
				
				This.SetItem(row,"validado",1)	//Para saber que el Articulo está correcto
				
				This.SetColumn('empa_cubicaje')				
				
			end if	

			//Dirige el cursor al producto actual
			wf_scroll_a_disponibles(ldw_5, data , li_linea_ori)
			
			//Para setear 1 o 0 al campo que identifica si la linea tiene desglose o no
			wf_setea_campo_desglose(this,ldw_6,li_linea_ori,row)
			
			//Para recalcular el Cubicaje y Peso de la Linea
			If ll_asignada > 0 then
				wf_recalcula_cubicaje(data,ll_disponible,ld_cubicaje, ld_peso)
			End If
			
		else
			
			gf_mensaje("","Éste Artículo no Existe o Ya Fue Asignado en su Totalidad, Verifique ..?",1,1,"E")
			This.SetItem(row,"empa_codigo_producto","")	//Blanqueo el codigo									
			if wf_blanquea_registro(This,row) = 1 then //Si Estaba OK y se modifico, lo blanquea
				This.SetItem(row,"validado",0)	//Para saber que el Articulo está incorrecto		
				This.SetItem(row,"desglose",0)
			end if			
			This.Setcolumn('empa_codigo_producto')
			return 2
			
		end if

		//Para que no pueda pasar todos los articulos del detalle		
		if row >= 1 then	
			tab_1.tabpage_2.cb_pasar.visible = false 
		end if		
   /******************  Cuando Cambia la Cantidad Que se Està Asignando ***********/
	
	case	"empa_canti"
			il_fraccion  = this.GetitemNumber(row,"empa_fraccion")		
			li_resultado = wf_validar_cantidad(This, row, "CANTI")
			if li_resultado = -1 then 
				this.Setcolumn('empa_canti')
				return 2	
			end if			

	case	"empa_fraccion"	
			il_canti    = this.GetitemNumber(row,"empa_canti")
			li_resultado = wf_validar_cantidad(This, row, "FRAC")			
			if li_resultado = -1 then 
				this.Setcolumn('empa_fraccion')
				return 2			
			end if
			
end choose

return 0
end event

event dw_2::itemfocuschanged;String 		ls_producto
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
		il_canti    = this.GetitemNumber(row,"empa_canti")
//		messagebox("A setear Cantidades ",string(il_canti) + "  " + string(il_fraccion))			
	case	"empa_fraccion"
		il_fraccion = this.GetitemNumber(row,"empa_fraccion")	
end Choose
end event

event dw_2::doubleclicked;if Row <= 0 then return

string 	ls_col
long		ll_recupero

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
		
		OpenWithParm(w_fa_co_productos_packing,str_empaque)		
		
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
		str_desglose.linea		=	this.getitemnumber(row,"empa_linea")
		str_desglose.linea_ori	=	this.getitemnumber(row,"empa_linea_original")		
		str_desglose.data			=	0		//Para que recupere con retrieve
		str_desglose.titulo		=  wf_titulo_desglose(this, row)
		str_desglose.vienede		=  is_fuente
		str_desglose.empaque		=	is_empaque
		str_desglose.ann_empa	=  il_ann_empa		

		if wf_valida_desglose(str_desglose.linea_ori) =  1 then	//Entra Si el articulo tiene desglose
			OpenWithParm(w_fa_man_desglose_x, str_desglose)
		end if
		
	case	"empa_fraccion"
		
		str_desglose.pedido		=	is_pedido
		str_desglose.ann			=	il_ann
		if is_fuente	=	"FA" then
			str_desglose.tipo	=	is_tipo
		end if
		str_desglose.linea		=	this.getitemnumber(row,"empa_linea")
		str_desglose.linea_ori	=	this.getitemnumber(row,"empa_linea_original")		
		str_desglose.data			=	0		//Para que recupere con retrieve
		str_desglose.titulo		=  wf_titulo_desglose(this, row)
		str_desglose.vienede		=  is_fuente
		str_desglose.empaque		=	is_empaque
		str_desglose.ann_empa	=  il_ann_empa
		
		if wf_valida_desglose(str_desglose.linea_ori) =  1 then	//Entra Si el articulo tiene desglose
			OpenWithParm(w_fa_man_desglose_x, str_desglose)
		end if

end choose
end event

event dw_2::itemchanged;//Se dispara el Post del Itemchanged
this.accepttext()
ib_cambio = true
this.post event ue_postitem(row, dwo, data)
end event

event dw_2::retrieveend;//Setear las Cantidades y Fracciones, Dependiendo de la cantidad de la linea
integer 		i, li_linea
string      ls_unidad, ls_expresion
long			ll_cantidad = 0, ll_fraccion = 0, ll_cant_total, ll_row
Datawindow  ldw_6

ldw_6 = tab_1.tabpage_2.dw_6


for i = 1 to rowcount
	
	ll_cant_total 	= this.GetitemNumber(i,"empa_cantidad")
	ls_unidad		= this.GetItemString(i,"empa_unidad")
	wf_convert_uni(ls_unidad,ll_cant_total,ll_cantidad,ll_fraccion)
	this.Setitem(i,"empa_canti",ll_cantidad)
	this.Setitem(i,"empa_fraccion",ll_fraccion)
	this.Setitem(i,"validado",1)
	
	li_linea = this.Getitemnumber(i,"empa_linea_original")
	
	//Para setear 1 o 0 al campo que identifica si la linea tiene desglose o no
	wf_setea_campo_desglose(this,ldw_6,li_linea,i)
		
Next
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

//messagebox("botton clicked","Entro "+ls_columna)

if actionreturncode = 0 then
	choose case ls_columna
		case "sube"
			wf_sube_o_baja("S")
		case "baja"
			wf_sube_o_baja("B")			
	end choose
end if

end event

event dw_2::clicked;string  ls_objeto
integer li_pos
st_microhelp.visible = false

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if ls_objeto = 'empa_bulto_inicio_t' then
	this.setsort('empa_bulto_inicio A index A')
	this.sort()
end if
end event

event dw_2::rowfocuschanged;//Override
if currentrow < 1 then return

string ls_producto
Long	 ll_linea
Datawindow ldw_5
ldw_5 = tab_1.tabpage_2.dw_5


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
integer width = 2994
integer height = 1528
string text = "Preview"
string picturename = "Preview!"
cbx_precio_monto cbx_precio_monto
gb_3 gb_3
dw_8 dw_8
end type

on tabpage_3.create
this.cbx_precio_monto=create cbx_precio_monto
this.gb_3=create gb_3
this.dw_8=create dw_8
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_precio_monto
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.dw_8
end on

on tabpage_3.destroy
call super::destroy
destroy(this.cbx_precio_monto)
destroy(this.gb_3)
destroy(this.dw_8)
end on

type dw_3 from w_fa_padre_tab`dw_3 within tabpage_3
event ue_keydown pbm_dwnkey
string tag = "dw_ma_fa_imp_pedi_pack"
integer x = 14
integer y = 48
integer width = 2953
integer height = 1356
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_3::ue_keydown;//Llama al Evento de la Ventana Principal
iw_this.TriggerEvent("key")
end event

event dw_3::retrieveend;
Long 		ll_i, ll_cant_asig, ll_cant_uni, ll_cant_noasig, ll_cant_asignada, ld_cant_frac,ll_row
String 	ls_uni_venta, ls_aprobado, ls_recolecta, ls_nombre, ls_apellido,ls_nombre_rec,&
			ls_apellido_rec, ls_cod_base, ls_colum_color, ls_colum_cantidad,ls_color, ls_expression
Decimal	ld_cantidad, ld_cub_grupo, ld_peso,ldt_peso,ldt_cub_grupo,ldt_yardas, ld_precio,ld_monto
Integer	li_color, li_piezas,li_columna = 1,li_pos

DataWindow ldw_3,ldw_8

ldw_3 = tab_1.Tabpage_3.dw_3

ldw_8 = tab_1.Tabpage_3.dw_8

ls_cod_base =''

If rowcount < 1 then return

For ll_i = 1 to rowcount
	ll_cant_asig = ldw_3.GetItemNumber(ll_i,"asigna")
		If is_fuente = "PE" or w_fa_fondo.str_para.lista_emp_especial = 1  Then
			ls_uni_venta =	ldw_3.GetItemString(ll_i,"fadpedid_dped_unidad_venta")
		Else
			ls_uni_venta =	ldw_3.GetItemString(ll_i,"faddiari_facd_unidad_venta")
		End If
		
	gf_fa_convertuni2(ls_uni_venta,ll_cant_asig,ll_cant_uni,ld_cant_frac)	

	ldw_3.SetItem(ll_i,"asignado",string(ll_cant_uni)+"."+string(ld_cant_frac))
	
	ll_cant_noasig = ldw_3.GetItemNumber(ll_i,"noasigna")
	ll_cant_uni = 0
	ld_cant_frac = 0
	gf_fa_convertuni2(ls_uni_venta, ll_cant_noasig,ll_cant_uni,ld_cant_frac)

	ldw_3.SetItem(ll_i,"noasignado",string(ll_cant_uni)+"."+string(ld_cant_frac))

	ll_cant_asignada = ldw_3.GetItemNumber(ll_i,"fadempaq_empa_cantidad")
	ll_cant_uni = 0
	ld_cant_frac = 0
	gf_fa_convertuni2(ls_uni_venta,ll_cant_asignada,ll_cant_uni,ld_cant_frac)
		
	ldw_3.SetItem(ll_i,"cantidad",string(ll_cant_uni)+"."+string(ld_cant_frac))

	/*Programación especial para packing de textiles*/

	If w_fa_fondo.str_para.lista_emp_especial = 1 and ll_i = 1 then
		ldw_8.Reset()
		ll_row = ldw_8.InsertRow(0)
		ldw_3.visible = false
		ldw_8.visible = true
		ls_cod_base = ''
	end if

	If w_fa_fondo.str_para.lista_emp_especial = 1 then

		ldw_3.SetItem(ll_i,"fadempaq_empa_cantidad",ll_cant_uni)
		ld_cantidad = ldw_3.GetItemNumber(ll_i,"fadempaq_empa_cantidad")
		If IsNull(ld_cantidad) then ld_cantidad =0

		ld_cub_grupo = ldw_3.GetItemNumber(ll_i,"fadempaq_empa_cubicaje")
		If IsNull(ld_cub_grupo) then ld_cub_grupo =0
		ld_peso		 = ldw_3.GetItemNumber(ll_i,"fadempaq_empa_peso")

		If ls_cod_base <> ldw_3.GetItemString(ll_i,"fadpedid_dped_codigo_item")  then
			
			If ls_cod_base <>''  then

			// Inserta Totales por grupo
				ldw_8.SetItem(ll_row,"empa_cubicaje",ldt_cub_grupo)
				ldw_8.SetItem(ll_row,"fadempaq_empa_peso",ldt_peso)
				
				ldw_8.SetItem(ll_row,"piezas",li_piezas)
				ldw_8.SetItem(ll_row,"yardas",ldt_yardas)
				ld_monto = round(ld_precio*ldt_yardas,2)
				ldw_8.SetItem(ll_row,"monto",ld_monto)
				li_piezas = 0
				ldt_yardas= 0
				ldt_cub_grupo =0
				ldt_peso  = 0
				
				// Inserta nueva línea de detalle después de insertar totales
				ll_row = ldw_8.InsertRow(0)
				li_columna = 1
			end if

			//Acumula totales por grupo
			If IsNull(ld_peso) then ld_peso =0
			ldt_peso 		+= ld_peso
			ldt_cub_grupo  += ld_cub_grupo
			li_piezas ++
			ldt_yardas     +=ld_cantidad

			// Toma el nuevo codigo de grupo
			ls_cod_base = ldw_3.GetItemString(ll_i,"fadpedid_dped_codigo_item")
			
			/*Toma los dos ultimos caracteres despues del '-' del producto*/
			ls_color    = string(ldw_3.GetItemNumber(ll_i,"color"))
			/*Concatena los nombres de las columnas*/
//			ls_colum_color    = 'col_'+trim(string(li_columna))
			ls_colum_cantidad = 'cant_'+trim(string(li_columna))
			
			/*Setea el color y yardaje del bulto */
//			ldw_8.SetItem(ll_row,ls_colum_color,ls_color)
			ldw_8.SetItem(ll_row,ls_colum_cantidad,ld_cantidad)

			ldw_8.SetItem(ll_row,"fadpedid_dped_descripcion_alterna",ldw_3.GetItemString(ll_i,"fadpedid_dped_descripcion_alterna"))
			ldw_8.SetItem(ll_row,"fadpedid_dped_codigo_item",ldw_3.GetItemString(ll_i,"fadpedid_dped_codigo_item"))
			ldw_8.SetItem(ll_row,"precio",ldw_3.GetItemNumber(ll_i,"precio_unidad_producto"))
			ld_precio =ldw_8.GetItemNumber(ll_row,"precio")
			ldw_8.SetItem(ll_row,"fatpedid_pedi_a_nombre",ldw_3.GetItemString(ll_i,"fatpedid_pedi_a_nombre"))
			ldw_8.SetItem(ll_row,"dgmterce_terc_direccion",ldw_3.GetItemString(ll_i,"dgmterce_terc_direccion"))
			ldw_8.SetItem(ll_row,"fatpedid_pedi_consignado",ldw_3.GetItemString(ll_i,"fatpedid_pedi_consignado"))
			ldw_8.SetItem(ll_row,"fatpedid_pedi_no_pedido",ldw_3.GetItemString(ll_i,"fatpedid_pedi_no_pedido"))
			ldw_8.SetItem(ll_row,"fatempaq_enca_recolector",ldw_3.GetItemString(ll_i,"fatempaq_enca_recolector"))
			ldw_8.SetItem(ll_row,"fatempaq_enca_supervisor",ldw_3.GetItemString(ll_i,"fatempaq_enca_supervisor"))
			
			ldw_8.SetItem(ll_row,"fadempaq_empa_bulto_inicio",ldw_3.GetItemNumber(ll_i,"fadempaq_empa_bulto_inicio"))
			ldw_8.SetItem(ll_row,"fadempaq_empa_bulto_fin",ldw_3.GetItemNumber(ll_i,"fadempaq_empa_bulto_fin"))

			ldw_8.SetItem(ll_row,"pedi_marca",ldw_3.GetItemString(ll_i,"pedi_marca"))
			ldw_8.SetItem(ll_row,"lista_empaque",ldw_3.GetItemString(ll_i,"lista_empaque"))
			ldw_8.SetItem(ll_row,"fatempaq_enca_ann",ldw_3.GetItemNumber(ll_i,"fatempaq_enca_ann"))
			
		else
			li_columna ++

			/*Toma los dos ultimos caracteres despues del '-' del producto*/
			ls_color    = string(ldw_3.GetItemNumber(ll_i,"color"))

			/*Concatena los nombres de las columnas*/
//			ls_colum_color    = 'col_'+trim(string(li_columna))
			ls_colum_cantidad = 'cant_'+trim(string(li_columna))

			ldw_8.SetItem(ll_row,"fadpedid_dped_descripcion_alterna",ldw_3.GetItemString(ll_i,"fadpedid_dped_descripcion_alterna"))
			ldw_8.SetItem(ll_row,"fadpedid_dped_codigo_item",ldw_3.GetItemString(ll_i,"fadpedid_dped_codigo_item"))
			ldw_8.SetItem(ll_row,"precio",ldw_3.GetItemNumber(ll_i,"precio_unidad_producto"))

			ldw_8.SetItem(ll_row,"pedi_marca",ldw_3.GetItemString(ll_i,"pedi_marca"))
			ldw_8.SetItem(ll_row,"lista_empaque",ldw_3.GetItemString(ll_i,"lista_empaque"))
			ldw_8.SetItem(ll_row,"fatempaq_enca_ann",ldw_3.GetItemNumber(ll_i,"fatempaq_enca_ann"))

			ldw_8.SetItem(ll_row,"fadempaq_empa_bulto_fin",ldw_3.GetItemNumber(ll_i,"fadempaq_empa_bulto_fin"))

			ld_precio =ldw_8.GetItemNumber(ll_row,"precio")
			//Acumula totales por grupo
			If IsNull(ld_peso) then ld_peso =0
			ldt_peso 		+= ld_peso
			ldt_cub_grupo  += ld_cub_grupo
			li_piezas ++
			ldt_yardas     += ld_cantidad
			/*Setea el color y yardaje del bulto */
//			ldw_8.SetItem(ll_row,ls_colum_color,ls_color)
			ldw_8.SetItem(ll_row,ls_colum_cantidad,ld_cantidad)

			If li_columna = 15 then
				// Es un producto con 9 ó más rollos o piezas, por lo que debe agregar otro 
				// acumula totales e inserta otra linea del mismo producto
				ls_cod_base ='99'
				li_columna = 1
			end if

		end if
		
	end if
Next

If w_fa_fondo.str_para.lista_emp_especial = 1 then

	// Inserta Totales por grupo
		ldw_8.SetItem(ll_row,"empa_cubicaje",ldt_cub_grupo)
		ldw_8.SetItem(ll_row,"fadempaq_empa_peso",ldt_peso)
		
		ldw_8.SetItem(ll_row,"piezas",li_piezas)
		ldw_8.SetItem(ll_row,"yardas",ldt_yardas)
		ld_monto = round(ld_precio*ldt_yardas,2)
		ldw_8.SetItem(ll_row,"monto",ld_monto)

		dw_8.object.data_window.expression = "'"+ dw_8.dataObject +"'"
		
		ls_expression = string(date(gf_fecha_serv())) 
		dw_8.object.fecha.expression = "'"+ls_expression+"'"
		
		ls_expression = string(Time(gf_fecha_serv()))
		dw_8.object.hora.expression = "'"+ls_expression+"'"

		ls_expression = gf_dg_nombre_empresa()
		ldw_8.object.empresanom.expression = "'"+ls_expression+"'"

		//* Script para la asignacion del tamaño de página ....
		Integer	li_largo,li_ancho
		li_largo = 3600	// largo
		li_ancho = 2375	// ancho
	
		If is_win9598_winnt='win9598' then
			gf_dg_tamano_pagina(li_largo,li_ancho,ldw_3)
		end If
	
	ldw_8.object.datawindow.print.preview = 'yes'
	ldw_8.object.datawindow.print.preview.zoom =100
	else//string(gf_fecha_serv(), "dd/mm/yyyy hh:mm AM/PM")
	ldw_3 = tab_1.Tabpage_3.dw_3
	ls_expression = 'FECHA '+string(date(gf_fecha_serv())) 
	ldw_3.object.fecha.expression = "'"+ls_expression+"'"

	ls_expression = string(gf_fecha_serv(), "dd/mm/yyyy hh:mm AM/PM")
	li_pos = Pos(ls_expression," ")

	ls_expression ='HORA  '+Right(ls_expression, Len(ls_expression) - li_pos)		
	
	ldw_3.object.hora.expression = "'"+ls_expression+"'"

end if		

//Para Imprimir el codigo o el nombre de los vendedores
wf_imprime_vendedor()

end event

type st_gb from w_fa_padre_tab`st_gb within w_fa_man_packing_list_ac
end type

type pb_up from w_fa_padre_tab`pb_up within w_fa_man_packing_list_ac
integer taborder = 30
end type

type pb_down from w_fa_padre_tab`pb_down within w_fa_man_packing_list_ac
integer taborder = 10
end type

type st_help from w_fa_padre_tab`st_help within w_fa_man_packing_list_ac
end type

type ole_1 from olecontrol within tabpage_1
boolean visible = false
integer x = 2546
integer y = 68
integer width = 251
integer height = 1136
integer taborder = 12
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_fa_man_packing_list_ac.win"
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
omlinkupdateoptions linkupdateoptions = linkupdatemanual!
end type

type dw_4 from datawindow within tabpage_1
boolean visible = false
integer x = 87
integer y = 676
integer width = 2437
integer height = 584
integer taborder = 12
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;//Cuando Recupero, Seteo la Cantidad Disponible al DW
Integer  i, li_resultado
long		ll_cantidad, ll_fraccion, ll_asignadas, ll_disponible, ll_cant_total, &
			ll_cant_asig=0, ll_frac_asig=0, ll_cant_disp=0, ll_frac_disp=0
String	ls_unidad
Datawindow ldw_6
ldw_6 = tab_1.tabpage_2.dw_6

if rowcount < 1 then return

//Setea el Datawindow de Cantidades Disponibles
wf_setea_dw_disponibles()

for i = 1 to rowcount
	if is_fuente     =    'PE' then
		ll_cantidad	  =	 this.GetitemNumber(i,"dped_cantidad")
		ll_fraccion   =	 this.GetitemNumber(i,"dped_fraccion")
		ll_asignadas  =  	 this.GetitemNumber(i,"dped_cant_asignada")
		ls_unidad	  =    This.GetitemString(i,"dped_unidad_venta")
		
		if isnull(ll_cantidad) then ll_cantidad = 0
		if isnull(ll_fraccion) then ll_fraccion = 0
		if isnull(ll_asignadas) then ll_asignadas = 0	
		
		ll_cant_total =    wf_convert_min(ls_unidad,ll_cantidad,ll_fraccion)
		ll_disponible =    ll_cant_total - ll_asignadas
		
		This.Setitem(i,"cant_disponible",ll_disponible)	
	
	else
		ll_cantidad	  =	 this.GetitemNumber(i,"facd_cantidad")
		ll_fraccion   =	 this.GetitemNumber(i,"facd_cantidad_fraccion")
		ll_asignadas  =  	 this.GetitemNumber(i,"facd_cant_asignada")
		ls_unidad	  =    This.GetitemString(i,"facd_unidad_venta")
		
		if isnull(ll_cantidad) then ll_cantidad = 0
		if isnull(ll_fraccion) then ll_fraccion = 0
		if isnull(ll_asignadas) then ll_asignadas = 0	
		
		ll_cant_total =    wf_convert_min(ls_unidad,ll_cantidad,ll_fraccion)
		ll_disponible =    ll_cant_total - ll_asignadas
		This.Setitem(i,"cant_disponible",ll_disponible)							
		
	end if
	
	//Función que convierte lo asignado y disponible en cantidades y fracciones
   wf_convierte_a_unidades(This,i,ls_unidad,ll_asignadas,ll_disponible)
	
Next

//Recupera el DW del Desgloce, que esta oculto en el detalle
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
integer x = 101
integer y = 712
integer width = 137
integer height = 120
integer taborder = 14
boolean bringtotop = true
boolean border = false
boolean focusrectangle = false
string binarykey = "w_fa_man_packing_list_ac.win"
integer binaryindex = 1
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
omlinkupdateoptions linkupdateoptions = linkupdatemanual!
end type

type ole_5 from olecontrol within tabpage_1
integer x = 101
integer y = 884
integer width = 146
integer height = 124
integer taborder = 24
boolean bringtotop = true
boolean border = false
boolean focusrectangle = false
string binarykey = "w_fa_man_packing_list_ac.win"
integer binaryindex = 2
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
omlinkupdateoptions linkupdateoptions = linkupdatemanual!
end type

type ole_4 from olecontrol within tabpage_1
integer x = 101
integer y = 1060
integer width = 142
integer height = 124
integer taborder = 14
boolean bringtotop = true
boolean border = false
boolean focusrectangle = false
string binarykey = "w_fa_man_packing_list_ac.win"
integer binaryindex = 3
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
omlinkupdateoptions linkupdateoptions = linkupdatemanual!
end type

type dw_5 from datawindow within tabpage_2
integer x = 23
integer y = 1196
integer width = 1979
integer height = 116
integer taborder = 24
string dataobject = "dw_ma_fa_pedi_cantidades_packing"
boolean border = false
boolean livescroll = true
end type

type gb_2 from groupbox within tabpage_2
integer x = 9
integer width = 2990
integer height = 1328
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
integer x = 32
integer y = 756
integer width = 2528
integer height = 380
integer taborder = 34
boolean bringtotop = true
string dataobject = "dw_ma_fa_pedi_desglose_packing"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;//Cuando Recupero, Seteo la Cantidad Disponible al DW
Integer  i
long		ll_cantidad, ll_asignadas, ll_disponible, ll_row, ll_linea
			
String	ls_unidad
Datawindow ldw_5
ldw_5 = tab_1.tabpage_2.dw_5

if rowcount < 1 then return

//wf_setear_

for i = 1 to rowcount
				
		ll_cantidad	  =	 this.GetitemNumber(i,"cantidad")
		ll_asignadas  =  	 this.GetitemNumber(i,"asignada")
		ll_linea		  =    this.GetItemNumber(i,"linea")		
		
		ls_unidad  	  =    this.GetitemString(i,"unidad")

		if isnull(ll_cantidad) then ll_cantidad = 0
		if isnull(ll_asignadas) then ll_asignadas = 0	
		
//		ll_asignadas = ll_cantidad - ll_asignadas		//Para que Pase solo lo que se asignará
	
		ll_disponible = ll_cantidad - ll_asignadas
		
//		This.Setitem(i,"cant_disponible",0)
		This.Setitem(i,"cant_disponible",ll_disponible)
		
		This.Setitem(i,"asignada",ll_asignadas)
		
		//Función que convierte lo asignado y disponible en cantidades y fracciones
	  	 wf_convierte_a_unidades_desglose(This,i,ls_unidad,ll_cantidad,ll_asignadas,ll_disponible)
			
Next
end event

type dw_7 from datawindow within tabpage_2
boolean visible = false
integer x = 27
integer y = 388
integer width = 2551
integer height = 336
integer taborder = 14
boolean bringtotop = true
string dataobject = "dw_ma_fa_desglose_packing"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_pasar from commandbutton within tabpage_2
boolean visible = false
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

type cbx_precio_monto from checkbox within tabpage_3
integer x = 1353
integer y = 1256
integer width = 654
integer height = 72
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

event clicked;
If tab_1.tabpage_3.cbx_precio_monto.checked = true then
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

type gb_3 from groupbox within tabpage_3
integer width = 2990
integer height = 1424
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

type dw_8 from datawindow within tabpage_3
boolean visible = false
integer x = 23
integer y = 56
integer width = 2546
integer height = 1348
integer taborder = 14
string title = "none"
string dataobject = "dw_ma_fa_imp_pedi_pack_textiles"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_fa_man_packing_list_ac
integer x = 27
integer y = 1660
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

type cb_1 from commandbutton within w_fa_man_packing_list_ac
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

type st_microhelp from statictext within w_fa_man_packing_list_ac
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

type ole_2 from olecustomcontrol within w_fa_man_packing_list_ac
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
integer x = 1225
integer y = 8
integer width = 1211
integer height = 88
integer taborder = 11
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_fa_man_packing_list_ac.win"
integer binaryindex = 4
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

