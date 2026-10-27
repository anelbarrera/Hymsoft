forward
global type w_hs_frame from w_grampa_frame
end type
type rbb_1 from ribbonbar within w_hs_frame
end type
end forward

global type w_hs_frame from w_grampa_frame
string title = "Sistema Integrado"
string menuname = "m_hs"
windowdockstate windowdockstate = windowdockstatetabbedwindow!
boolean tabbedview = true
boolean maximizealltabbedsheets = true
event ue_quitar_menu ( )
event ue_evaluar_panel_acciones ( )
event ue_salir ( )
event ue_appmenu_clicked ( long itemhandle )
event ue_sheet_closed ( )
rbb_1 rbb_1
end type
global w_hs_frame w_hs_frame

type prototypes
Function Boolean SetMenu(LongPtr hWnd, LongPtr hMenu) Library "user32.dll"
Function Boolean DrawMenuBar(LongPtr hWnd) Library "user32.dll"
FUNCTION ulong GetWindowLongW (ulong hWnd, int nIndex) LIBRARY "user32.dll"
FUNCTION ulong SetWindowLongW (ulong hWnd, int nIndex, ulong dwNewLong) LIBRARY "user32.dll"
FUNCTION boolean LockWindowUpdate(ulong hWndLock) LIBRARY "user32.dll"
end prototypes

type variables
boolean lb_primera_entrada = true
String is_app_path
uo_configuracion_regional uo_regional
Date idt_fecha_contabilidad
str_fa_param str_para
str_tr_param str_param
end variables

forward prototypes
public function integer wf_set_panel_visible (string as_tag, boolean ab_visible)
public subroutine wf_set_panel (boolean ab_val)
public function integer wf_set_button_visible (string as_tag, boolean ab_visible)
public subroutine wf_configurar_panel_acciones (boolean ab_nuevo, boolean ab_guardar, boolean ab_eliminar, boolean ab_imprimir, boolean ab_exportar)
public function integer wf_set_category_visible (string as_tag, boolean ab_visible)
end prototypes

event ue_quitar_menu();// Desvincular el menú de Windows de la ventana MDI
//SetMenu(Handle(this), 0)

// Forzar a Windows a redibujar el marco sin el espacio del menú
DrawMenuBar(Handle(this))

// Forzar reajuste de la RibbonBar y el área MDI
this.TriggerEvent(Resize!)
end event

event ue_evaluar_panel_acciones();//Window lw_sheet
// mdi_1.SetRedraw(False)
//// Obtener la ventana activa actual dentro del Frame MDI
//lw_sheet = this.GetActiveSheet()

//If IsValid(lw_sheet) Then
//    this.wf_set_panel( True)
//Else
    
//    this.wf_set_panel( false)
//End If

//mdi_1.SetRedraw(True)
// Evento de usuario: w_hs_frame.ue_evaluar_panel_acciones()
Window lw_sheet
RibbonCategoryItem lr_cat

lw_sheet = this.GetActiveSheet()

If IsValid(lw_sheet) Then
    // 1. Mostrar la pestaña de acciones
    this.wf_set_category_visible("CAT_ACCIONES", True)
    
    // 2. Seleccionar automáticamente la pestaña "Acciones" para que quede activa
    If rbb_1.GetItemByTag("CAT_ACCIONES", lr_cat) = 1 Then
        rbb_1.SetActiveCategory(lr_cat.ItemHandle)
    End If
Else
    // Al no haber ventanas abiertas, ocultar la pestaña
    this.wf_set_category_visible("CAT_ACCIONES", False)
End If

// Forzar repintado del área cliente MDI
mdi_1.SetRedraw(False)
mdi_1.SetRedraw(True)
end event

event ue_salir();// Evento ue_salir() en w_hs_frame - SIN ARGUMENTOS

 close (This)
end event

event ue_sheet_closed();// Evento ue_sheet_closed() en w_hs_frame
Window lw_active

// Como se ejecutó con POST, GetActiveSheet() ya devuelve la ventana que quedó al frente
lw_active = This.GetActiveSheet()
//Messagebox('','exito')
If Not IsValid(lw_active) Then
	This.SetRedraw(False)
	 wf_set_panel_visible("PAN_ACCIONES_CAT1", False)
	 wf_set_panel_visible("PAN_ACCIONES_CAT2", False)
	 wf_set_panel_visible("PAN_ACCIONES_CAT3", False)
	 wf_set_panel_visible("PAN_ACCIONES_CAT5", False)
	 wf_set_panel_visible("PAN_ACCIONES_CAT6", False)
	 wf_set_panel_visible("PAN_ACCIONES_DOC", False)
	 
	 This.SetRedraw(True)
End If
end event

public function integer wf_set_panel_visible (string as_tag, boolean ab_visible);// Función de Ventana: wf_set_panel_visible(string as_tag, boolean ab_visible)
// Retorna: 1 = Éxito, -1 = Error o Tag no encontrado

RibbonPanelItem lr_panel

// 1. Obtener una copia del panel directamente por su Tag (busca en toda la barra)
If rbb_1.GetItemByTag(as_tag, lr_panel) = 1 Then
    
    // 2. Modificar la visibilidad (True o False)
    lr_panel.Visible = ab_visible
    
    // 3. Aplicar el cambio a la RibbonBar usando SetItem
    Return rbb_1.SetItem(lr_panel)
End If

Return -1 // No se encontró ningún panel con ese Tag
end function

public subroutine wf_set_panel (boolean ab_val);wf_set_panel_visible("PAN_ACCIONES_CAT1", ab_val)
wf_set_panel_visible("PAN_ACCIONES_CAT2", ab_val)
wf_set_panel_visible("PAN_ACCIONES_CAT3", ab_val)
wf_set_panel_visible("PAN_ACCIONES_CAT4", ab_val)
wf_set_panel_visible("PAN_ACCIONES_CAT5", ab_val)
wf_set_panel_visible("PAN_ACCIONES_CAT6", ab_val)
wf_set_panel_visible("PAN_ACCIONES_DOC", ab_val)

end subroutine

public function integer wf_set_button_visible (string as_tag, boolean ab_visible); 
RibbonLargeButtonItem lr_large
RibbonSmallButtonItem lr_small
Integer li_rtn

 
If rbb_1.GetItemByTag(as_tag, lr_large) = 1 Then
    lr_large.Visible = ab_visible
    li_rtn = rbb_1.SetItem(lr_large)
    rbb_1.SetRedraw(True)
    Return li_rtn
End If

 
If rbb_1.GetItemByTag(as_tag, lr_small) = 1 Then
    lr_small.Visible = ab_visible
    li_rtn = rbb_1.SetItem(lr_small)
    rbb_1.SetRedraw(True)
    Return li_rtn
End If


Return -1
end function

public subroutine wf_configurar_panel_acciones (boolean ab_nuevo, boolean ab_guardar, boolean ab_eliminar, boolean ab_imprimir, boolean ab_exportar); 
//rbb_1.SetRedraw(False)


//this.wf_set_button_visible("BTN_ACC_GUARDAR",  ab_guardar)

//this.wf_set_button_visible("BTN_ACC_IMPRIMIR", ab_imprimir)
//this.wf_set_button_visible("BTN_ACC_EXPORTAR", ab_exportar)

//rbb_1.SetRedraw(True)

//If Pos(ls_tag, "BTN_ACCION_GRABAR") > 0 Then
//    this.wf_set_button_visible("BTN_ACC_GUARDAR",  ab_guardar)
//ElseIf Pos(ls_tag, "BTN_ACCION_INSERTAR") > 0 Then
//    this.wf_set_button_visible("BTN_ACC_NUEVO",    ab_nuevo)
//ElseIf Pos(ls_tag, "BTN_ACCION_ELIMINAR") > 0 Then
//    this.wf_set_button_visible("BTN_ACC_ELIMINAR", ab_eliminar)
//ElseIf Pos(ls_tag, "BTN_ACCION_GUARDAR_COMO") > 0 Then 
//    lw_activa.TriggerEvent("ue_save_as") 
//ElseIf Pos(ls_tag, "BTN_ACCION_VISTA_PRELIMINAR") > 0 Then 
//    lw_activa.TriggerEvent("ue_vista") 
//ElseIf Pos(ls_tag, "BTN_ACCION_IMPRIMIR") > 0 Then 
//    lw_activa.TriggerEvent("ue_imprimir") 
//ElseIf Pos(ls_tag, "BTN_ACCION_CERRAR") > 0 Then 
//    close(lw_activa)
//End If
end subroutine

public function integer wf_set_category_visible (string as_tag, boolean ab_visible);// Función de Ventana: wf_set_category_visible(string as_tag, boolean ab_visible)
// Retorna: 1 = Modificado exitosamente, -1 = Error o Tag no encontrado

RibbonCategoryItem lr_cat

// 1. Obtener la categoría por su Tag (ej. "CAT_ACCIONES")
If rbb_1.GetItemByTag(as_tag, lr_cat) = 1 Then
    // 2. Modificar visibilidad
    lr_cat.Visible = ab_visible
    
    // 3. Aplicar el cambio a la RibbonBar
    Return rbb_1.SetItem(lr_cat)
End If

Return -1
end function

on w_hs_frame.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.rbb_1=create rbb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rbb_1
end on

on w_hs_frame.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rbb_1)
end on

event open;call super::open;Integer li_rc,li_ann,li_mes
String ls_retorno, ls_dir

ls_dir = Space(512)
GetCurrentDirectory(512, ls_dir)
is_app_path = Trim(ls_dir)

uo_regional = create uo_configuracion_regional 

uo_regional.of_getvalores()
uo_regional.of_setvalores()

if lb_primera_entrada then
	//open(w_acceso)
	open(w_login_modern)
	ls_retorno = message.stringparm
	if ls_retorno <> 'OK' then
		halt close
	end if
	lb_primera_entrada = false
end if

 


li_rc = rbb_1.ImportFromXMLFile("ribbon_sistema.xml")
If li_rc <> 1 Then
    MessageBox("Error", "Fallo al inicializar la RibbonBar. Código: " + String(li_rc), StopSign!)
End If
// Ocultar la categoría unificada de acciones al iniciar la aplicación
this.wf_set_category_visible("CAT_ACCIONES", False)

//selecciona el nombre de la empresa
  SELECT dgmempre.empr_razon_social  , empr_acceso_especial, empr_valor_fixing, isnull(empr_clave_estados_de_cuenta,''), empr_bodegas_definidas, isnull(empr_bodega1,''), isnull(empr_bodega2,''), isnull(empr_bodega3,''), isnull(empr_bodega4,''), isnull(empr_bodega5,''), isnull(empr_bodega6,''), isnull(empr_bodega7,'')
    INTO :str.nombre_empresa , :str.empr_acceso_especial, :str.valor_fixing, :str.clave_estado_de_cuenta, :str.bodegas_definidas, :str.bodega1, :str.bodega2, :str.bodega3, :str.bodega4, :str.bodega5, :str.bodega6, :str.bodega7
    FROM dgmempre  
   WHERE ( dgmempre.empr_g_financiero = :str.g_financiero ) AND  
         ( dgmempre.empr_empresa = :str.empresa ) ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al seleccionar el nombre de la empresa '+sqlca.sqlerrtext,1,1,'E')
			end if
//sle_1.text = str.nombre_empresa + ' - HYMSOFT V 2.0'
str.frame.title = str.nombre_empresa	+ ' SISTEMA INTEGRADO HymSoft V 2.0'	
 
wf_set_panel(false)

this.Post Event ue_quitar_menu()
end event

event resize;call super::resize;// Evento Resize de w_frame
If sizetype = 1 Then Return

// 1. RibbonBar pegada arriba al ancho total
rbb_1.Move(0, 0)
rbb_1.Width = this.WorkSpaceWidth()

// 2. mdi_1 (contenedor de sheets) pegado inmediatamente bajo la RibbonBar
mdi_1.X = 0
mdi_1.Y = rbb_1.Height
mdi_1.Width = This.WorkSpaceWidth()
mdi_1.Resize(this.WorkSpaceWidth(), this.WorkSpaceHeight() - rbb_1.Height)

end event

event closequery;call super::closequery; 
Integer li_resp

li_resp = MessageBox("Confirmación - HymSoft", &
                     "¿Está seguro de que desea salir de la aplicación?", &
                     Question!, &
                     YesNo!, &
                     2)

If li_resp = 2 Then
    Return 1
Else
    Return 0
End If
end event

type rbb_1 from ribbonbar within w_hs_frame
event ue_ribbon_click ( long al_handle )
event ue_appmenu_click ( long itemhandle,  long index,  long subindex )
integer width = 1431
integer height = 476
long backcolor = 15132390
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

event ue_ribbon_click(long al_handle);// Evento de usuario en w_frame: ue_ribbon_click(long al_handle)
RibbonLargeButtonItem lrbb_large
RibbonSmallButtonItem lrbb_small
 
window lw_activa
String ls_tag
str_fa_formato lstr_datawindow	

lw_activa = Parent.GetActiveSheet()

SetCurrentDirectory(is_app_path)

 
If rbb_1.GetLargeButton(al_handle, lrbb_large) = 1 Then
    ls_tag = lrbb_large.Tag
ElseIf rbb_1.GetSmallButton(al_handle, lrbb_small) = 1 Then
    ls_tag = lrbb_small.Tag
End If

// Bloquea el repintado de la ventana principal
// 1. Bloquear a nivel de sistema operativo todo el frame
LockWindowUpdate(Handle(Parent)) // o Handle(w_frame)
 Parent.PostEvent('ue_evaluar_panel_acciones')
Choose Case ls_tag	 
	Case 'Close'
		Parent.triggerevent('ue_salir')
	Case 'BTN_CAPTURA'
				SetPointer(HourGlass!)		
		
		if str.imprime_fiscal = 1 then	//Facturacion de Pesos, decimales en la cantidad
			OpenSheetWithparm(w_facturacion_fiscal,0,Parent,0, Original!)			
		else					
			Opensheet(w_facturacion, Parent, 0, Layered! ) 
			w_facturacion.WindowState = Maximized!
		end if
		SetPointer(Arrow!)
	Case 'BTN_COTIZACIONES'
		wf_set_panel_visible("PAN_ACCIONES_CAT1", True)
		if str.imprime_fiscal = 1 or pos(upper(str.empr_acceso_especial),'CITY') > 0 then
			OpenSheet(w_captura_proformas_fiscal,Parent,0,Original!)
		else
			OpenSheet(w_captura_proformas,Parent,0,Original!)
		end if
	Case 'BTN_PEDIDOS'
		wf_set_panel_visible("PAN_ACCIONES_CAT1", True)
		OpenSheet(w_captura_pedidos,Parent,0,Original!)
	Case 'BTN_PROFORMAS'
		wf_set_panel_visible("PAN_ACCIONES_CAT1", True)
		OpenSheet(w_captura_proformas_productos_no_creados,Parent,0, Original!)
	Case 'BTN_ENTRADA_MERCANCIA'
		wf_set_panel_visible("PAN_ACCIONES_CAT1", True)
		if str.contabiliza = 0 then
			OpenSheet(w_entrada,Parent,0, Original!)
		else
			OpenSheet(w_entrada_arriba,Parent,0, Original!)
		end if
	Case 'BTN_ORDEN_COMPRA'	
		wf_set_panel_visible("PAN_ACCIONES_CAT1", True)
		OpenSheet(w_orden_compra,Parent,0, Original!)
	Case 'BTN_FACT_PROV_TRANS'
		wf_set_panel_visible("PAN_ACCIONES_CAT1", True)
		//OpenSheet(w_transito,Parent,0, Original!)
		OpenSheet(w_cz_ma_transito,Parent,0, Original!)
	Case 'BTN_TRANSACCIONES'
		wf_set_panel_visible("PAN_ACCIONES_CAT1", True)
		OpenSheet(w_transacciones,Parent,0, Original!)
	Case 'BTN_CARGOS_MORA'
		wf_set_panel_visible("PAN_ACCIONES_CAT1", True)
		OpenSheet(w_generar_cargos_por_mora,Parent,0, Original!)	
	Case 'BTN_AJUSTES_INV'
		wf_set_panel_visible("PAN_ACCIONES_CAT2", True)
		if str.contabiliza = 0 then
			OpenSheet(w_ajustes,Parent,0, Original!)
		else
			OpenSheet(w_ajustes_costeando,Parent,0, Original!)
		end if
	Case 'BTN_NCR'
		wf_set_panel_visible("PAN_ACCIONES_CAT2", True)
		OpenSheet(w_captura_notas_credito,Parent,0, Original!)	
	Case 'BTN_CAJA'
		wf_set_panel_visible("PAN_ACCIONES_CAT2", True)
		 OpenSheet(w_caja_menuda_transito,Parent,0, Original!)
	Case 'BTN_AJUSTE_CAJA'
		wf_set_panel_visible("PAN_ACCIONES_CAT2", True)
		 OpenSheet(w_ajustes_caja,Parent,0, Original!)
	Case 'BTN_BANCARIAS'
		wf_set_panel_visible("PAN_ACCIONES_CAT2", True)
		 	OpenSheet(w_transacciones_banco,Parent,0, Original!)
	Case 'BTN_DEPOSITOS_BANCARIOS'
		wf_set_panel_visible("PAN_ACCIONES_CAT2", True)
			OpenSheet(w_captura_depositos,Parent,0, Original!)	
	Case 'BTN_COMP_DIARIOS'
		wf_set_panel_visible("PAN_ACCIONES_CAT2", True)
			OpenSheet(w_transacciones_conta,Parent,0, Original!)
	Case 'BTN_TRANS_PROVEEDORES'
		wf_set_panel_visible("PAN_ACCIONES_CAT2", True)
		OpenSheet(w_transacciones_cxp,Parent,0, Original!)
	Case 'BTN_CONS_PRODUCTOS'
    		window				lw_child
		lstr_datawindow.datawindow = "dw_co_fa_consulta_existencias_elbros" //dw_co_fa_consulta_factura
		OpenSheetWithParm(lw_child, lstr_datawindow,'w_fa_co_consulta_existencia', Parent,0,Original!)	
	Case 'BTN_CONS_KARDEX'
				Window lw_child_v				
		str_kardex  str_opcion
		
			str_opcion.opcion_menu = 'MCP'
			str_opcion.opcion_ventana    = 'P'
			str_opcion.dwpantalla     = 'dw_in_mcp_prod_kard_1'
			if str.contabiliza = 0 then
				str_opcion.dwreporte      = 'dw_in_mcp_prod_kard_2'
			else
				str_opcion.dwreporte      = 'dw_in_mcp_prod_kard_2_arriba'
			end if
			str_opcion.titulo_ventana = 'Movimientos de Productos (Kardex) '
			str_opcion.kproducto=''
			
			if isvalid(w_in_movi_prod_kardex) then
				w_in_movi_prod_kardex.bringtotop = true
				w_in_movi_prod_kardex.setredraw(true)
			else
				OpenSheetWithParm(w_in_movi_prod_kardex,str_opcion,Parent,0,Original!)		
			end if
//			OpenSheetWithParm(lw_child_v,str_opcion,"w_in_movi_prod_kardex",str.frame,2,Original!)	
	Case 'BTN_CONS_RESERVADOS_REF'
		lstr_datawindow.datawindow = "dw_fa_rep_reserva_existencia_new"
		OpenSheetWithParm(w_disponibles,lstr_datawindow, Parent,0, Original!)
	Case 'BTN_CONS_FACTURAS'
		w_facturas_actualizadas	lw_
		opensheet(lw_,Parent,0,Original!)
    Case "BTN_CONS_HIST_VENTAS_CLI"
    opensheet(w_historial_cliente,Parent,0,Original!)	

    Case "BTN_CONS_EST_CTA_CLI"
       	SetPointer(HourGlass!)
		str_cc_formatos str_formato1
		str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
		Opensheetwithparm(w_estadocuenta,str_formato1,Parent,0,original!)

    Case "BTN_CONS_TX_CLI"
      	w_consulta_transacciones	lw_2
		opensheet(lw_2,Parent,0,Original!)		
	Case "BTN_CONS_EST_CTA_PROV"
		str_cc_rangofecha str_formato2
		Opensheetwithparm(w_estado_cta_cxp,str_formato2,Parent,0,original!)		
	Case "BTN_CONS_TX_PROV"
		w_consulta_transacciones_cxp	lw_3
		opensheet(lw_3,Parent,0,Original!)	
	Case 'BTN_CONS_CONCIL_BANCARIA'
		OpenSheet(w_conciliacion_bancaria,Parent,0, Original!)
  
    Case "BTN_MANT_CLIENTES"		 
        OpenSheet(w_mant_clientes, Parent, 0, Original!)
    Case "BTN_MANT_PRODUCTOS"        
		  str_kardex  str_opciones
			OpenSheetwithparm(w_productos,str_opciones,Parent,0, Original!)

    Case "BTN_MANT_PROVEEDORES"
      OpenSheet(w_mant_proveedores,Parent,0, Original!)
	Case "BTN_MANT_PARAM_INV"
			Parent.setredraw(false)
		OpenSheet(w_parametros_entradas,Parent,0, Original!)
	Case "BTN_MANT_PLAN_CTAS"
		OpenSheet(w_plan_de_cuentas,Parent,0, Original!)
	Case "BTN_MANT_DIRECTORIO"
		OpenSheet(w_directorio_telefonico,Parent,0, Layered!)
	Case "BTN_MANT_FOTOS"
		OpenSheet(w_fa_co_fotos_asig,Parent,0, Original!)
	Case "BTN_MANT_PARAM"
		OpenSheet(w_colores,Parent,0, Original!)
	Case 'BTN_MANT_PARAM_GEN'
		OpenSheet(w_parametros_generales,Parent,0, Original!)
	Case 'BTN_MANT_PARAM_VTA'
		OpenSheet(w_parametros_salidas,Parent,0, Original!)
	Case 'BTN_MANT_USUARIOS'
			OpenSheet(w_usuarios,Parent,0, Original!)
	Case 'BTN_REP_VENTAS'
		OpenSheet(w_reportes_ventas,Parent,0, Original!)
	Case 'BTN_REP_TOP_PROD'
		OpenSheet(w_reporte_mas_vendidos, Parent,0, Original!) 
	Case 'BTN_REP_SALDOS_CLI'
		OpenSheet(w_reporte_clientes,Parent,0, Original!)
	Case 'BTN_REP_TX_CLI'
			OpenSheet(w_cc_ranf_cobros,Parent,0,Original!)
	Case 'BTN_REP_ANT_SALDOS'					
		str_rangofecha lstr_rangfech		
		opensheetWithParm(w_cc_ranf_antig,lstr_rangfech,Parent,0,Original!)	
	Case 'BTN_REP_INVENTARIOS'		
		OpenSheet(w_reporte_inventario,Parent,0, Layered!)
	Case 'BTN_REP_ROT_INV'
		OpenSheet(w_rotacion_del_inventario, Parent,0, Layered!) 
	Case 'BTN_REP_ANT_INV'
		OpenSheet(w_reporte_antiguedad_inventario, Parent,0, Layered!) 
	Case 'BTN_REP_MOVIMIENTOS'
		OpenSheet(w_productos_sin_movimiento, Parent,0, Layered!) 
	Case 'BTN_REP_CATALOGOS'
		OpenSheet(w_catalogos, Parent,0, Layered!) 
	Case 'BTN_REP_SUGERIDO_COMP'
		OpenSheet(w_sugerido_de_compras, Parent,0, Layered!) 
	Case 'BTN_REP_ORDENES'
			OpenSheet(w_reporte_ordenes, Parent,0, Original!) 
	Case 'BTN_REP_ENTRADAS'
		OpenSheet(w_reporte_entradas, Parent,0, Original!) //Entrada de Trafico
	Case 'BTN_REP_TRANSFERENCIAS'
		OpenSheet(w_reporte_transferencias, Parent,0, Original!) 
	Case 'BTN_REP_AJUSTES'
		OpenSheet(w_reporte_ajustes, Parent,0, Original!) 
	Case 'BTN_CONT_MAYOR_GRAL'
		wf_set_panel_visible("PAN_ACCIONES_CAT5", True)
		OpenSheet(w_reporte_mayor_general,Parent,0, Original!)
	Case 'BTN_CONT_BALANCE_PRUEBA'
		wf_set_panel_visible("PAN_ACCIONES_CAT5", True)
		OpenSheet(w_reporte_balance_de_prueba,Parent,0, Layered!)
	Case 'BTN_CONT_AUX_CUENTAS'
		wf_set_panel_visible("PAN_ACCIONES_CAT5", True)		
		OpenSheet(w_reporte_auxiliares,Parent,0, Original!)
	Case 'BTN_CONT_ESTADOS_FIN'
		wf_set_panel_visible("PAN_ACCIONES_CAT5", True)
		OpenSheet(w_reporte_estados_financieros,Parent,0, Layered!)
	Case 'BTN_CONT_HIST_CUENTAS'
		wf_set_panel_visible("PAN_ACCIONES_CAT5", True)
		OpenSheet(w_reporte_historico_cuentas,Parent,0, Original!)
	Case 'BTN_CONT_TX_BANCARIAS'
		wf_set_panel_visible("PAN_ACCIONES_CAT5", True)
		str_cc_formatos lstr_sec
		w_reporte_transacciones_bco 	lw_4
		Opensheet(lw_4,Parent,0,Original!)	
	Case 'BTN_CONT_TARJETA_VISA'
		wf_set_panel_visible("PAN_ACCIONES_CAT5", True)
		OpenSheet(w_ventas_resumen,Parent,0,Original!)
	Case 'BTN_CONT_MORA_PROV'
		wf_set_panel_visible("PAN_ACCIONES_CAT5", True)
		OpenSheet(w_antiguedad_cxp,Parent,0, Original!) //w_movimiento_metal
	Case 'BTN_CONT_SALDOS_PROV'
		wf_set_panel_visible("PAN_ACCIONES_CAT5", True)
		OpenSheet(w_reporte_proveedores,Parent,0, Original!)
	Case 'BTN_CONT_TX_PROV'
		wf_set_panel_visible("PAN_ACCIONES_CAT5", True)
		OpenSheet(w_rep_transacciones_cxp,Parent,0, Original!)
	Case "BTN_CONS_ARANCELES"
		 
		parent.Post Dynamic wf_set_panel_visible("PAN_ACCIONES_CAT3", False)
	 
		Window lw_aranceles
		str_kardex  str_opcion_arancel
		str_opcion_arancel.opcion_menu = 'CAR'
		str_opcion_arancel.titulo_ventana = '(IN) Consulta de Arancel  '
		str_opcion_arancel.dwinforme_1 = 'in_dw_cod_arancel'
		str_opcion_arancel.dwinforme_2 = 'in_dw_lis_cod_arancel'
		Parent.SetRedraw(false)
		OpenSheetWithParm(lw_aranceles,str_opcion_arancel,"w_in_cod_trans_gen",Parent,11,original!)
		Parent.SetRedraw(TRUE)
	Case "BTN_ACCION_INSERTAR"
        lw_activa = parent.GetActiveSheet()
        If IsValid(lw_activa) Then lw_activa.DYNAMIC TriggerEvent("ue_adicionar")

    Case "BTN_ACCION_GRABAR"
        lw_activa = parent.GetActiveSheet()
        If IsValid(lw_activa) Then lw_activa.DYNAMIC TriggerEvent("ue_aceptar")

    Case "BTN_ACCION_ELIMINAR"
        lw_activa = parent.GetActiveSheet()
        If IsValid(lw_activa) Then lw_activa.DYNAMIC TriggerEvent("ue_eliminar")

    Case "BTN_ACCION_IMPRIMIR"
        lw_activa = parent.GetActiveSheet()
        If IsValid(lw_activa) Then lw_activa.DYNAMIC TriggerEvent("ue_imprimir")

    Case "BTN_ACCION_GUARDAR_COMO"
        lw_activa = parent.GetActiveSheet()
        If IsValid(lw_activa) Then lw_activa.DYNAMIC TriggerEvent("ue_guardar_como")

    Case "BTN_ACCION_VISTA_PRELIMINAR"
        lw_activa = parent.GetActiveSheet()
        If IsValid(lw_activa) Then lw_activa.DYNAMIC TriggerEvent("ue_vista")

    Case "BTN_ACCION_CERRAR"
        lw_activa = parent.GetActiveSheet()
        If IsValid(lw_activa) Then Close(lw_activa)
End Choose

//Acciones
//If Pos(ls_tag, "BTN_ACCION_GRABAR") > 0 Then
//    lw_activa.TriggerEvent("ue_aceptar")
//ElseIf Pos(ls_tag, "BTN_ACCION_INSERTAR") > 0 Then
//    lw_activa.TriggerEvent("ue_adicionar")
//ElseIf Pos(ls_tag, "BTN_ACCION_ELIMINAR") > 0 Then
//    lw_activa.TriggerEvent("ue_eliminar")
//ElseIf Pos(ls_tag, "BTN_ACCION_GUARDAR_COMO") > 0 Then 
//    lw_activa.TriggerEvent("ue_save_as") 
//ElseIf Pos(ls_tag, "BTN_ACCION_VISTA_PRELIMINAR") > 0 Then 
//    lw_activa.TriggerEvent("ue_vista") 
//ElseIf Pos(ls_tag, "BTN_ACCION_IMPRIMIR") > 0 Then 
//    lw_activa.TriggerEvent("ue_imprimir") 
//ElseIf Pos(ls_tag, "BTN_ACCION_CERRAR") > 0 Then 
//    close(lw_activa)
//End If
LockWindowUpdate(0)
end event

event ue_appmenu_click(long itemhandle, long index, long subindex);// Evento ue_appmenu_click(long itemhandle, long index, long subindex) en w_hs_frame
RibbonApplicationButtonItem lr_appbtn
RibbonApplicationMenu lr_appmenu
RibbonMenuItem lr_item
Long ll_rc

// 1. Obtener la referencia al ApplicationButton y a su Menu
ll_rc = rbb_1.GetApplicationButton(lr_appbtn)
If ll_rc <> 1 Then Return

ll_rc = lr_appbtn.GetMenu(lr_appmenu)
If ll_rc <> 1 Then Return

// 2. Extraer el item presionado según el índice recibido
If subindex = 0 Then
    ll_rc = lr_appmenu.GetMasterItem(index, lr_item)
Else
    // Si proviene de un submenú (ej. Cerrar Sesión dentro de Cuenta)
    ll_rc = lr_appmenu.GetMasterItem(index, subindex, lr_item)
End If

If ll_rc <> 1 Then Return

// 3. Evaluar el Tag
Choose Case Lower(Trim(lr_item.Tag))
    Case "signout"
        MessageBox("HymSoft", "Cerrar sesión de usuario")

    Case "options"
       // OpenSheet(w_opciones, This, 0, Original!)

    Case "about app"
        //Open(w_acerca_de)
	Case "close"
		Parent.postevent('ue_salir')
End Choose
end event

