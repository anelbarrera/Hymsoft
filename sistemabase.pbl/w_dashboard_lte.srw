//objectcomments  
forward
global type w_dashboard_lte from window
end type
type wb_menu from webbrowser within w_dashboard_lte
end type
type p_topbar from statictext within w_dashboard_lte
end type
type cb_toggle from commandbutton within w_dashboard_lte
end type
type st_app_title from statictext within w_dashboard_lte
end type
end forward

global type w_dashboard_lte from window
integer width = 4201
integer height = 2600
boolean titlebar = true
string title = "SISTEMA INTEGRADO HymSoft V 2.0"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 16053497
string icon = "AppIcon!"
boolean center = true
event ue_toggle_sidebar ( )
event of_logout ( )
wb_menu wb_menu
p_topbar p_topbar
cb_toggle cb_toggle
st_app_title st_app_title
end type
global w_dashboard_lte w_dashboard_lte

type variables
uo_base_module iuo_active_module
boolean ib_collapsed = false
end variables

forward prototypes
public function integer of_load_module (string as_uo_name)
public subroutine of_populate_menu ()
public subroutine of_update_user_ui ()
public subroutine of_logout ()
public subroutine of_login ()
public subroutine of_set_menu_theme (string as_theme_name)
end prototypes

public function integer of_load_module (string as_uo_name);uo_base_module luo_new
long ll_content_x, ll_content_y, ll_content_w, ll_content_h

// 1. Validar si el módulo actual permite cerrarse (p. ej. cambios pendientes sin guardar)
if IsValid(iuo_active_module) then
    if not iuo_active_module.of_can_close() then 
        return -1
    end if
    // Cerrar y destruir la instancia previa de la memoria
    CloseUserObject(iuo_active_module)
end if

// 2. Calcular coordenadas y dimensiones relativas al WebBrowser (wb_menu) y Topbar (p_topbar)
ll_content_x = wb_menu.X + wb_menu.Width
ll_content_y = p_topbar.Y + p_topbar.Height
ll_content_w = this.WorkSpaceWidth() - ll_content_x
ll_content_h = this.WorkSpaceHeight() - ll_content_y

// Evitar dimensiones negativas durante inicializaciones o redimensionamientos rápidos
if ll_content_w < 100 then ll_content_w = 100
if ll_content_h < 100 then ll_content_h = 100

// 3. Crear dinámicamente la instancia del UserObject
if OpenUserObject(luo_new, as_uo_name, ll_content_x, ll_content_y) = 1 then
    iuo_active_module = luo_new
    
    // Ajustar al tamaño completo del área de trabajo
    iuo_active_module.Resize(ll_content_w, ll_content_h)
    iuo_active_module.BringToTop = true
    
    // Disparar evento de inicialización del módulo hijo
    iuo_active_module.event ue_init("")
    
    return 1
else
    MessageBox("Error de Navegación", "No fue posible instanciar el módulo: " + as_uo_name, StopSign!)
    return -1
end if
end function

public subroutine of_populate_menu ();//long ll_r
//dw_menu.SetRedraw(false)
//dw_menu.Reset()

//// Opción 1: Dashboard
//ll_r = dw_menu.InsertRow(0)
//dw_menu.SetItem(ll_r, "item_id", "M1")
//dw_menu.SetItem(ll_r, "parent_id", "")
//dw_menu.SetItem(ll_r, "tipo", "ITEM")
//dw_menu.SetItem(ll_r, "titulo", "Panel Dashboard")
//dw_menu.SetItem(ll_r, "modulo_uo", "uo_dashboard_home")

//// Opción 2: Ventas (Grupo Acordeón)
//ll_r = dw_menu.InsertRow(0)
//dw_menu.SetItem(ll_r, "item_id", "M2")
//dw_menu.SetItem(ll_r, "parent_id", "")
//dw_menu.SetItem(ll_r, "tipo", "MENU")
//dw_menu.SetItem(ll_r, "titulo", "Módulo Ventas")
//dw_menu.SetItem(ll_r, "expanded", 1)

//// Opción 2.1: Hijo Facturación
//ll_r = dw_menu.InsertRow(0)
//dw_menu.SetItem(ll_r, "item_id", "M2_1")
//dw_menu.SetItem(ll_r, "parent_id", "M2")
//dw_menu.SetItem(ll_r, "tipo", "ITEM")
//dw_menu.SetItem(ll_r, "titulo", "Facturas")
//dw_menu.SetItem(ll_r, "modulo_uo", "uo_dashboard_home")

//dw_menu.SetRedraw(true)
end subroutine

public subroutine of_update_user_ui ();// ============================================================================
// Función: of_update_user_ui()
// Propósito: Sincronizar el estado del usuario logueado en la Topbar de PB 
//            y en el menú HTML (WebBrowser) de AdminLTE.
// ============================================================================
string ls_user, ls_role, ls_logged, ls_js

// 1. Obtener valores de la sesión actual (o valores por defecto si no hay sesión)
if gstr_session.is_logged then
    ls_user   = gstr_session.user_name
    ls_role   = gstr_session.user_role
    ls_logged = "true"
else
    ls_user   = "Usuario Invitado"
    ls_role   = "Sin sesión"
    ls_logged = "false"
end if

// 2. Actualizar el control de texto en la Topbar de PowerBuilder (si existe)
if IsValid(st_app_title) then
    // Opcional: mostrar usuario en el Topbar o en st_user_display
    // st_user_display.Text = "👤 " + ls_user + " (" + ls_role + ")"
end if

// 3. Inyectar los datos en el WebBrowser ejecutando la función JS del HTML
if IsValid(wb_menu) then
    // Escapar comillas simples por seguridad
//    ls_user = uf_replace_all(ls_user, "'", "\'")
//    ls_role = uf_replace_all(ls_role, "'", "\'")
    
 ls_js = "if (typeof setSessionData === 'function') { setSessionData('" + ls_user + "', '" + ls_role + "', " + ls_logged + "); }"
wb_menu.EvaluateJavascriptSync(ls_js)
            
    wb_menu.EvaluateJavascriptSync(ls_js)
end if
end subroutine

public subroutine of_logout ();// ============================================================================
// Función: of_logout()
// Propósito: Valida guardado pendiente, destruye el módulo activo,
//            limpia las credenciales y redirige a la pantalla de login.
// ============================================================================

// 1. Confirmación de usuario (botón "No" por defecto)
if MessageBox("Cerrar Sesión", "¿Está seguro de que desea salir del sistema?", Question!, YesNo!, 2) = 2 then
    return 
end if

// 2. Validar si el módulo abierto permite cerrarse (p. ej. cambios sin guardar)
if IsValid(iuo_active_module) then
    if not iuo_active_module.of_can_close() then
        return 
    end if
    // Destruir el objeto de memoria
    CloseUserObject(iuo_active_module)
end if

// 3. Limpiar variables de sesión en memoria
gstr_session.user_id   = ""
gstr_session.user_name = ""
gstr_session.user_role = ""
gstr_session.is_logged = false

// 4. Reabrir pantalla de Login y cerrar el Dashboard
Open(w_login_modern)
Close(this)

return 
end subroutine

public subroutine of_login ();//
end subroutine

public subroutine of_set_menu_theme (string as_theme_name);// ============================================================================
// Función: of_set_menu_theme(string as_theme_name)
// Parámetros admitidos: 
//   - "theme-dark-primary"  (Oscuro original)
//   - "theme-navy"          (Azul corporativo)
//   - "theme-light"         (Claro moderno)
//   - "theme-dark-emerald"  (Esmeralda transaccional)
//   - "theme-oled"          (Negro profundo)
// ============================================================================
string ls_js

if not IsValid(wb_menu) then return

ls_js = "if (typeof applyTheme === 'function') { applyTheme('" + as_theme_name + "'); }"
wb_menu.EvaluateJavascriptSync(ls_js)
end subroutine

on w_dashboard_lte.create
this.wb_menu=create wb_menu
this.p_topbar=create p_topbar
this.cb_toggle=create cb_toggle
this.st_app_title=create st_app_title
this.Control[]={this.wb_menu,&
this.p_topbar,&
this.cb_toggle,&
this.st_app_title}
end on

on w_dashboard_lte.destroy
destroy(this.wb_menu)
destroy(this.p_topbar)
destroy(this.cb_toggle)
destroy(this.st_app_title)
end on

event open;string ls_html_path
This.setredraw(false)
 if wb_menu.Width <= 100 then
    wb_menu.Width = 1000 // Ancho normal AdminLTE en PBUs (~250px)
end if
 
this.event resize(0, this.WorkSpaceWidth(), this.WorkSpaceHeight())
ls_html_path = GetCurrentDirectory() + "\assets\menu_adminlte.html"

// Si existe el archivo, navegar hacia él
if FileExists(ls_html_path) then
    wb_menu.Navigate(ls_html_path)
else
    // Si estás ejecutando en prueba o ruta fija:
    wb_menu.Navigate("file:///C:/fuentes/assets/menu_adminlte.html")
end if


// Cargar la vista inicial por defecto
this.post of_load_module("uo_dashboard_home")
this.post of_update_user_ui()

 This.setredraw(True)
 This.of_set_menu_theme("theme-navy")
end event

event resize;// ============================================================================
// Evento: resize(unsignedlong sizetype, integer newwidth, integer newheight)
// ============================================================================
long ll_top_h
long ll_menu_w

// 1. Altura del Topbar
if IsValid(p_topbar) then
    ll_top_h = p_topbar.Height
else
    ll_top_h = 140 // PBUs de reserva si no existe
end if

// 2. Ancho del menú (forzar mínimo si viene en 0)
ll_menu_w = wb_menu.Width
if ll_menu_w <= 100 then
    ll_menu_w = 1000
    wb_menu.Width = ll_menu_w
end if

// 3. Posicionar Topbar
if IsValid(p_topbar) then
    p_topbar.Move(0, 0)
    p_topbar.Resize(newwidth, ll_top_h)
end if

// 4. Posicionar wb_menu pegado a la izquierda bajo la Topbar
wb_menu.Move(0, ll_top_h)
wb_menu.Resize(ll_menu_w, newheight - ll_top_h)
wb_menu.BringToTop = true

// 5. El módulo activo empieza a la DERECHA del menú (ll_menu_w)
if IsValid(iuo_active_module) then
    iuo_active_module.Move(ll_menu_w, ll_top_h)
    iuo_active_module.Resize(newwidth - ll_menu_w, newheight - ll_top_h)
end if
end event

event timer;Timer(0)  

if not this.Visible then
    this.SetRedraw(true)
    this.Visible = true
    this.BringToTop = true
end if
end event

type wb_menu from webbrowser within w_dashboard_lte
integer y = 152
integer width = 1335
integer height = 400
end type

event navigationstart;// Evento: navigationstart(string url) en wb_menu
string ls_prefix = "pbaction://"
string ls_uo_name

if Pos(uri, ls_prefix) = 1 then
    // 1. Extraer el nombre del módulo UserObject
    ls_uo_name = Mid(uri, Len(ls_prefix) + 1)
    
    // 2. Cargar el módulo en el contenedor central
    parent.of_load_module(ls_uo_name)
    
    // 3. Bloquear la navegación web interna (return 1 cancela la acción)
    return 
end if

return 
end event

event navigationcompleted; 
parent.of_update_user_ui()
this.BringToTop = true
if not IsValid(iuo_active_module) then
    parent.of_load_module("uo_dashboard_home")
end if
 
end event

event webmessagereceived;// Evento: webmessagereceived(string uri, string webmessage)
// (Nota: el parámetro puede llamarse 'webmessage' o 'msg' según la firma visible en la barra superior)

string ls_action
ls_action = lower(trim(webmessage))

choose case ls_action
    case "logout"
        parent.post of_logout()
        
    case "login"
       parent.post of_login()
        
    case "user_profile"
       parent.of_load_module("uo_user_profile")
        
    case else
        // Es un módulo normal (ej. "uo_dashboard_home", "uo_ventas_facturas")
        parent.of_load_module(webmessage)
end choose
end event

event navigationerror;MessageBox("Error WebBrowser", "Fallo al cargar URL: " + failedurl)
end event

type p_topbar from statictext within w_dashboard_lte
integer width = 4000
integer height = 132
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 16777215
boolean focusrectangle = false
end type

type cb_toggle from commandbutton within w_dashboard_lte
integer x = 32
integer y = 24
integer width = 119
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "≡"
end type

event clicked;// Evento Clicked de cb_toggle
if ib_collapsed then
    wb_menu.Width = 900 // Ancho expandido
    ib_collapsed = false
else
    wb_menu.Width = 180 // Modo colapsado compacto
    ib_collapsed = true
end if

parent.event resize(0, parent.WorkSpaceWidth(), parent.WorkSpaceHeight())
end event

type st_app_title from statictext within w_dashboard_lte
integer x = 178
integer y = 32
integer width = 1102
integer height = 76
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 3553844
long backcolor = 16777215
string text = "AdminLTE Core | PB 2025"
boolean focusrectangle = false
end type

