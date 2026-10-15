//objectcomments  
forward
global type w_frame_outlook from window
end type
type mdi_1 from mdiclient within w_frame_outlook
end type
type mdirbb_1 from ribbonbar within w_frame_outlook
end type
type mditbb_1 from tabbedbar within w_frame_outlook
end type
type wb_menu from webbrowser within w_frame_outlook
end type
type uo_split from u_vsplitter within w_frame_outlook
end type
end forward

global type w_frame_outlook from window
integer width = 4498
integer height = 2876
boolean titlebar = true
string title = "Aplicacion Moderna PB 2025 - Estilo Outlook"
string menuname = "m_hs"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
event ue_splitter_moved ( long al_new_x )
mdi_1 mdi_1
mdirbb_1 mdirbb_1
mditbb_1 mditbb_1
wb_menu wb_menu
uo_split uo_split
end type
global w_frame_outlook w_frame_outlook

type variables
Long il_active_cat = 0
Long il_last_hover_row = 0
Long il_selected_row = 0
end variables

forward prototypes
public function integer of_add_item (long al_tipo, long al_cat_id, long al_orden, string as_titulo, string as_ventana, string as_icono)
public function integer of_load_menu ()
public function integer of_toggle_category (long al_cat_id)
public function integer of_open_sheet (string as_ventana, string as_titulo)
end prototypes

event ue_splitter_moved(long al_new_x);
Long ll_split_w, ll_frame_w, ll_frame_h

//This.SetRedraw(False)

//ll_split_w = uo_split.Width
ll_frame_w = This.WorkSpaceWidth()
ll_frame_h = This.WorkSpaceHeight()

//// 1. Redimensionar el Menú Outlook (ocupa desde 0 hasta al_new_x)
//If IsValid(dw_menu) Then
//	dw_menu.Move(0, 0)
//	dw_menu.Resize(al_new_x, ll_frame_h)
//End If

//// 2. Ubicar el Splitter
//uo_split.Move(al_new_x, 0)
//uo_split.Resize(ll_split_w, ll_frame_h)

//// 3. Ajustar el area MDI de las hojas (mdi_1) al espacio restante
//If IsValid(mdi_1) Then
//	mdi_1.Move(al_new_x + ll_split_w, 0)
//	mdi_1.Resize(ll_frame_w - (al_new_x + ll_split_w), ll_frame_h)
//End If

//This.SetRedraw(True)
// Dentro de ue_splitter_moved:
If IsValid(wb_menu) Then
    wb_menu.Move(0, 0)
    wb_menu.Resize(al_new_x, ll_frame_h)
End If
end event

public function integer of_add_item (long al_tipo, long al_cat_id, long al_orden, string as_titulo, string as_ventana, string as_icono);//Long ll_row

//ll_row = dw_menu.InsertRow(0)
//dw_menu.SetItem(ll_row, "tipo", al_tipo)
//dw_menu.SetItem(ll_row, "cat_id", al_cat_id)
//dw_menu.SetItem(ll_row, "orden", al_orden)
//dw_menu.SetItem(ll_row, "titulo", as_titulo)
//dw_menu.SetItem(ll_row, "ventana", as_ventana)
//dw_menu.SetItem(ll_row, "icono", as_icono)
//dw_menu.SetItem(ll_row, "is_hover", 0)
//dw_menu.SetItem(ll_row, "is_selected", 0)
//dw_menu.SetItem(ll_row, "is_expanded", 0)

Return 1
end function

public function integer of_load_menu ();//dw_menu.SetRedraw(False)
//dw_menu.Reset()

//// =========================================================================
//// 1. GENERACIÓN DE FACTURAS Y ENTRADAS (Cat 1)
//// =========================================================================
//of_add_item(1, 1, 0,  "Generación de Facturas y Entradas", "")
//of_add_item(2, 1, 1,  "Captura", "w_captura")
//of_add_item(2, 1, 2,  "Orden de Factura Directa", "w_fac_directa")
//of_add_item(2, 1, 3,  "Registro de Transacciones", "w_reg_transacciones")
//of_add_item(2, 1, 4,  "Entrada de Mercancía", "w_entrada_mercancia")
//of_add_item(2, 1, 5,  "Cargos por Morosidad", "w_cargos_morosidad")
//of_add_item(2, 1, 6,  "Captura de Pedidos", "w_pedidos")
//of_add_item(2, 1, 7,  "Cotizaciones", "w_cotizaciones")
//of_add_item(2, 1, 8,  "Orden de Compra", "w_orden_compra")
//of_add_item(2, 1, 9,  "Factura Proveedor-Transito", "w_fac_prov_transito")
//of_add_item(2, 1, 10, "Proformas - Productos Inexistentes", "w_proformas_inex")

//// =========================================================================
//// 2. REPORTES (Cat 2)
//// =========================================================================
//of_add_item(1, 2, 0,  "Reportes", "")
//of_add_item(2, 2, 1,  "Antigüedad de Saldos", "w_rep_antiguedad_saldos")
//of_add_item(2, 2, 2,  "Ventas", "w_rep_ventas")
//of_add_item(2, 2, 3,  "Informe de Inventarios", "w_rep_inventarios")
//of_add_item(2, 2, 4,  "Informe de Entradas", "w_rep_entradas")
//of_add_item(2, 2, 5,  "Saldos de Clientes", "w_rep_saldos_cli")
//of_add_item(2, 2, 6,  "Transacciones de Clientes", "w_rep_trans_cli")
//of_add_item(2, 2, 7,  "Informe de Transferencias", "w_rep_transferencias")
//of_add_item(2, 2, 8,  "Informe de Ajustes", "w_rep_ajustes")
//of_add_item(2, 2, 9,  "Informe de Ordenes", "w_rep_ordenes")
//of_add_item(2, 2, 10, "Rotación del Inventario", "w_rep_rotacion_inv")
//of_add_item(2, 2, 11, "Antigüedad de Inventario", "w_rep_antiguedad_inv")
//of_add_item(2, 2, 12, "Informe de Movimiento", "w_rep_movimientos")
//of_add_item(2, 2, 13, "Sugerido de Compras", "w_rep_sugerido_compras")
//of_add_item(2, 2, 14, "Productos Más Vendidos", "w_rep_prod_mas_vendidos")
//of_add_item(2, 2, 15, "Catálogos", "w_rep_catalogos")

//// =========================================================================
//// 3. CAPTURA DE TRANSACCIONES (Cat 3)
//// =========================================================================
//of_add_item(1, 3, 0, "Captura de Transacciones", "")
//of_add_item(2, 3, 1, "Ajustes de Inventarios", "w_tra_ajustes_inv")
//of_add_item(2, 3, 2, "Proveedores", "w_tra_proveedores")
//of_add_item(2, 3, 3, "Comprobantes de Diarios", "w_tra_diarios")
//of_add_item(2, 3, 4, "Caja", "w_tra_caja")
//of_add_item(2, 3, 5, "Bancarias", "w_tra_bancarias")
//of_add_item(2, 3, 6, "Ajustes de Caja", "w_tra_ajustes_caja")
//of_add_item(2, 3, 7, "Transferencia-Bodega", "w_tra_transf_bodega")
//of_add_item(2, 3, 8, "Depósitos Bancarios", "w_tra_depositos_bancarios")

//// =========================================================================
//// 4. CONSULTA DE MOVIMIENTOS (Cat 4)
//// =========================================================================
//of_add_item(1, 4, 0,  "Consulta de Movimientos", "")
//of_add_item(2, 4, 1,  "Productos", "w_con_productos")
//of_add_item(2, 4, 2,  "Kardex", "w_con_kardex")
//of_add_item(2, 4, 3,  "Historial de Ventas Cliente", "w_con_hist_ventas_cli")
//of_add_item(2, 4, 4,  "Estado de Cuentas - Clientes", "w_con_est_cta_cli")
//of_add_item(2, 4, 5,  "Facturas", "w_con_facturas")
//of_add_item(2, 4, 6,  "Transacciones de Clientes", "w_con_trans_cli")
//of_add_item(2, 4, 7,  "Reservados por Referencia", "w_con_reservados_ref")
//of_add_item(2, 4, 8,  "Estado Cuenta - Proveedores", "w_con_est_cta_prov")
//of_add_item(2, 4, 9,  "Transacciones Proveedores", "w_con_trans_prov")
//of_add_item(2, 4, 10, "Conciliación Bancaria", "w_con_conciliacion")
//of_add_item(2, 4, 11, "Comprobantes de Diarios", "w_con_diarios")
//of_add_item(2, 4, 12, "Saldos Bancarios", "w_con_saldos_bancarios")

//// =========================================================================
//// 5. SISTEMA Y MANTENIMIENTO (Cat 5)
//// =========================================================================
//of_add_item(1, 5, 0,  "Sistema y Mantenimiento", "")
//of_add_item(2, 5, 1,  "Parámetros", "w_sis_parametros")
//of_add_item(2, 5, 2,  "Clientes", "w_sis_clientes")
//of_add_item(2, 5, 3,  "Productos", "w_sis_productos")
//of_add_item(2, 5, 4,  "Proveedores", "w_sis_proveedores")
//of_add_item(2, 5, 5,  "Parámetros Generales", "w_sis_param_gral")
//of_add_item(2, 5, 6,  "Plan de Cuentas", "w_sis_plan_cuentas")
//of_add_item(2, 5, 7,  "Parámetros de Inventario", "w_sis_param_inv")
//of_add_item(2, 5, 8,  "Parámetros de Ventas", "w_sis_param_ventas")
//of_add_item(2, 5, 9,  "Adicionar Usuarios", "w_sis_usuarios")
//of_add_item(2, 5, 10, "Directorio", "w_sis_directorio")
//of_add_item(2, 5, 11, "Asignar Fotos", "w_sis_asignar_fotos")

//// =========================================================================
//// 6. CONTABILIDAD (Cat 6)
//// =========================================================================
//of_add_item(1, 6, 0,  "Contabilidad", "")
//of_add_item(2, 6, 1,  "Transacciones Bancarias", "w_cnt_trans_bancarias")
//of_add_item(2, 6, 2,  "Morosidad a Proveedores", "w_cnt_morosidad_prov")
//of_add_item(2, 6, 3,  "Saldos de Proveedores", "w_cnt_saldos_prov")
//of_add_item(2, 6, 4,  "Transacciones Proveedores", "w_cnt_trans_prov")
//of_add_item(2, 6, 5,  "Histórico de Cuentas", "w_cnt_hist_cuentas")
//of_add_item(2, 6, 6,  "Balances de Prueba", "w_cnt_balance_prueba")
//of_add_item(2, 6, 7,  "Tarjeta Visa", "w_cnt_tarjeta_visa")
//of_add_item(2, 6, 8,  "Auxiliares de Cuentas", "w_cnt_aux_cuentas")
//of_add_item(2, 6, 9,  "Estados F.", "w_cnt_estados_financieros")
//of_add_item(2, 6, 10, "Mayor General", "w_cnt_mayor_general")

//dw_menu.Sort()

//// Iniciar mostrando la primera categoría expandida
//This.of_toggle_category(1)

//dw_menu.SetRedraw(True)
//Return 1

// 1. FACTURACIÓN
of_add_item(1, 1, 0,  "Generación de Facturas y Entradas", "", "🧾")
of_add_item(2, 1, 1,  "Captura", "w_captura", "📄")
of_add_item(2, 1, 2,  "Orden de Factura Directa", "w_fac_directa", "📝")
of_add_item(2, 1, 3,  "Registro de Transacciones", "w_reg_transacciones", "💳")
of_add_item(2, 1, 4,  "Entrada de Mercancía", "w_entrada_mercancia", "📦")
of_add_item(2, 1, 5,  "Cargos por Morosidad", "w_cargos_morosidad", "⚠️️")
of_add_item(2, 1, 6,  "Captura de Pedidos", "w_pedidos", "🛒")
of_add_item(2, 1, 7,  "Cotizaciones", "w_cotizaciones", "📋")
of_add_item(2, 1, 8,  "Orden de Compra", "w_orden_compra", "📑")
of_add_item(2, 1, 9,  "Factura Proveedor-Transito", "w_fac_prov_transito", "🚚")
of_add_item(2, 1, 10, "Proformas - Inexistentes", "w_proformas_inex", "📑")

// 2. REPORTES
of_add_item(1, 2, 0,  "Reportes", "", "📊")
of_add_item(2, 2, 1,  "Antigüedad de Saldos", "w_rep_antiguedad_saldos", "📉")
of_add_item(2, 2, 2,  "Ventas", "w_rep_ventas", "📈")
of_add_item(2, 2, 3,  "Informe de Inventarios", "w_rep_inventarios", "📋")
// ... agrega los iconos al resto de categorías (⚙️ para Mantenimiento, 🏛️ para Contabilidad, etc.)
return 1
end function

public function integer of_toggle_category (long al_cat_id);//// Función of_toggle_category(al_cat_id)
//Long ll_i

//dw_menu.SetRedraw(False)

//// Actualizar indicador de expandido en todas las cabeceras
//For ll_i = 1 To dw_menu.RowCount()
//    If dw_menu.GetItemNumber(ll_i, "tipo") = 1 Then
//        If dw_menu.GetItemNumber(ll_i, "cat_id") = al_cat_id And il_active_cat <> al_cat_id Then
//            dw_menu.SetItem(ll_i, "is_expanded", 1)
//        Else
//            dw_menu.SetItem(ll_i, "is_expanded", 0)
//        End If
//    End If
//Next

//If il_active_cat = al_cat_id Then
//    il_active_cat = 0
//    dw_menu.SetFilter("tipo = 1")
//Else
//    il_active_cat = al_cat_id
//    dw_menu.SetFilter("tipo = 1 or (tipo = 2 and cat_id = " + String(al_cat_id) + ")")
//End If

//dw_menu.Filter()
//dw_menu.Sort()
//dw_menu.SetRedraw(True)

Return 1
end function

public function integer of_open_sheet (string as_ventana, string as_titulo);Window lw_sheet
Integer li_rc

If Len(Trim(as_ventana)) = 0 Then Return 0

// Intenta abrir la ventana dinámicamente como hoja MDI
li_rc = OpenSheet(lw_sheet, as_ventana, This, 0, Layered!)

If li_rc <> 1 Then
	// Mensaje descriptivo en caso de que la ventana esté en construcción
	MessageBox("Módulo en Desarrollo", "Accediendo a: " + as_titulo + "~r~nVentana: [" + as_ventana + "]")
End If

Return 1
end function

on w_frame_outlook.create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.mdi_1=create mdi_1
this.mditbb_1=create mditbb_1
this.mdirbb_1=create mdirbb_1
this.wb_menu=create wb_menu
this.uo_split=create uo_split
this.Control[]={this.mdi_1,&
this.mditbb_1,&
this.mdirbb_1,&
this.wb_menu,&
this.uo_split}
end on

on w_frame_outlook.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.mdirbb_1)
destroy(this.mditbb_1)
destroy(this.wb_menu)
destroy(this.uo_split)
end on

event open;
//Long ll_initial_x


//dw_menu.DataObject = "d_menu_outlook"
//// 1. Inicializar splitter: limites entre 800 y 2800 PBUs
//uo_split.of_Init(This, 800, 2800, "AppPB2025")

//// 2. Restaurar posicion anterior guardada en Registry o usar valor por defecto
//ll_initial_x = uo_split.of_Restore_Position()

//// 3. Acomodar la pantalla inicialmente
//This.Event ue_splitter_moved(ll_initial_x)

//This.of_load_menu()

String ls_html_path

// 1. Inicializar el Splitter
uo_split.of_Init(This, 800, 2800, "AppPB2025")
This.Event ue_splitter_moved(uo_split.of_Restore_Position())

// 2. Ruta absoluta del archivo HTML
ls_html_path = GetCurrentDirectory() + "\menu.html"

// 3. Navegar en el WebBrowser
wb_menu.Navigate("file:///" + ls_html_path)
end event

event resize;
//Long ll_split_pos, ll_split_w

//If IsValid(uo_split) Then
//	ll_split_pos = uo_split.X
//	ll_split_w   = uo_split.Width
	
//	// Ajustar menú y splitter a la nueva altura
//	dw_menu.Resize(ll_split_pos, newheight)
//	uo_split.Resize(ll_split_w, newheight)
	
//	// Acomodar mdi_1
//	If IsValid(mdi_1) Then
//		mdi_1.Move(ll_split_pos + ll_split_w, 0)
//		mdi_1.Resize(newwidth - (ll_split_pos + ll_split_w), newheight)
//	End If
//End If
end event

type mdi_1 from mdiclient within w_frame_outlook
end type

type mditbb_1 from tabbedbar within w_frame_outlook
int X=0
int Y=0
int Width=0
int Height=104
end type

type mdirbb_1 from ribbonbar within w_frame_outlook
int X=0
int Y=0
int Width=0
int Height=596
end type

type uo_split from u_vsplitter within w_frame_outlook
integer x = 1102
integer taborder = 20
end type

on uo_split.destroy
call u_vsplitter::destroy
end on

type wb_menu from webbrowser within w_frame_outlook
integer x = 37
integer y = 16
integer width = 1102
integer height = 1184
end type

event addresschange;// Evento AddressChange(string newaddress) de wb_menu
Long ll_pos_hash, ll_pos_amp
String ls_window

ll_pos_hash = Pos(newurl, "#")
If ll_pos_hash > 0 Then
    // Extraer el nombre de la ventana antes del parámetro de tiempo (&t=)
    ll_pos_amp = Pos(newurl, "&", ll_pos_hash)
    If ll_pos_amp > 0 Then
        ls_window = Mid(newurl, ll_pos_hash + 1, ll_pos_amp - (ll_pos_hash + 1))
    Else
        ls_window = Mid(newurl, ll_pos_hash + 1)
    End If
    
    // Llamar a la función que abre la ventana en mdi_1
    Parent.of_open_sheet(ls_window, "")
End If
end event

