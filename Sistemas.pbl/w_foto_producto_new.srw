forward
global type w_foto_producto_new from window
end type
type cb_foto from commandbutton within w_foto_producto_new
end type
type wb_1 from webbrowser within w_foto_producto_new
end type
end forward

global type w_foto_producto_new from window
integer width = 3168
integer height = 1320
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_foto cb_foto
wb_1 wb_1
end type
global w_foto_producto_new w_foto_producto_new

type variables
String is_temp_html
end variables

forward prototypes
public function string wf_replace_all (string as_source, string as_find, string as_replace)
public function string wf_file_to_base64 (string as_path)
public function string wf_get_temp_dir ()
end prototypes

public function string wf_replace_all (string as_source, string as_find, string as_replace);// wf_replace_all (as_source, as_find, as_replace) returns string
long ll_pos
ll_pos = Pos(as_source, as_find)

DO WHILE ll_pos > 0
    as_source = Replace(as_source, ll_pos, Len(as_find), as_replace)
    ll_pos = Pos(as_source, as_find, ll_pos + Len(as_replace))
LOOP

RETURN as_source
end function

public function string wf_file_to_base64 (string as_path);// Función: wf_file_to_base64(string as_path) returns string
blob lblb_data
string ls_base64
CoderObject lnv_coder

// 1. Leer el archivo binario a memoria
integer li_file, li_read
long ll_len
li_file = FileOpen(as_path, StreamMode!, Read!, Shared!, Replace!)
IF li_file < 1 THEN RETURN ""

FileReadEx(li_file, lblb_data)
FileClose(li_file)

// 2. Codificar a Base64 usando CoderObject nativo de PB
lnv_coder = CREATE CoderObject
ls_base64 = lnv_coder.Base64Encode(lblb_data)
DESTROY lnv_coder

RETURN ls_base64
end function

public function string wf_get_temp_dir ();// Función: wf_get_temp_dir() returns string
string ls_temp_dir
ulong lul_len, lul_ret

// Reservar espacio suficiente en el buffer (MAX_PATH = 260 caracteres)
ls_temp_dir = Space(260)
lul_len = 260

lul_ret = GetTempPathW(lul_len, ls_temp_dir)

IF lul_ret > 0 THEN
    ls_temp_dir = Trim(ls_temp_dir)
    // Asegurar que termine en barra invertida
    IF Right(ls_temp_dir, 1) <> "\" THEN ls_temp_dir += "\"
    RETURN ls_temp_dir
ELSE
    // Fallback estándar en caso de fallo de la API
    RETURN "C:\Temp\"
END IF
end function

on w_foto_producto_new.create
this.cb_foto=create cb_foto
this.wb_1=create wb_1
this.Control[]={this.cb_foto,&
this.wb_1}
end on

on w_foto_producto_new.destroy
destroy(this.cb_foto)
destroy(this.wb_1)
end on

event open;
wb_1.ContextMenu = True
end event

event resize;// Evento Resize de w_foto_producto_new
// newwidth y newheight son argumentos nativos del evento

//wb_1.Width  = newwidth  - (wb_1.X * 2)
//wb_1.Height = newheight - wb_1.Y - 40 // Margen inferior opcional
end event

event close;// 1. Liberar el archivo en el motor Chromium
IF IsValid(wb_1) THEN
    wb_1.Navigate("about:blank")
END IF

// 2. Eliminar el archivo temporal si existe
IF Len(Trim(is_temp_html)) > 0 THEN
    IF FileExists(is_temp_html) THEN
        FileDelete(is_temp_html)
    END IF
END IF
end event

type cb_foto from commandbutton within w_foto_producto_new
integer x = 1422
integer y = 12
integer width = 402
integer height = 104
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;string ls_path, ls_url_img, ls_html, ls_temp_dir
integer li_file

ls_path = "C:\Sistemas\fotos\1.jpg"

// 1. Validar que la foto exista físicamente
IF NOT FileExists(ls_path) THEN
    MessageBox("Error", "No existe el archivo de imagen:~r~n" + ls_path, StopSign!)
    RETURN
END IF

// 2. Formatear la ruta de la imagen con protocolo file:///
ls_url_img = "file:///" + wf_replace_all(ls_path, "\", "/")
ls_url_img = wf_replace_all(ls_url_img, " ", "%20")

// 3. Plantilla HTML interactiva con Pan, Zoom y Rotación
ls_html = "<!DOCTYPE html>" + &
          "<html><head><meta charset='utf-8'>" + &
          "<style>" + &
          "  * { box-sizing: border-box; }" + &
          "  html, body { margin:0; padding:0; width:100vw; height:100vh; overflow:hidden; background-color:#1e1e1e; font-family:Segoe UI, sans-serif; user-select:none; }" + &
          "  #viewer { width:100%; height:100%; display:flex; justify-content:center; align-items:center; cursor:grab; }" + &
          "  #viewer:active { cursor:grabbing; }" + &
          "  #target-img { max-width:92%; max-height:92%; object-fit:contain; pointer-events:none; transform-origin:center center; transition:transform 0.05s ease-out; }" + &
          "  .toolbar { position:fixed; bottom:14px; left:50%; transform:translateX(-50%); display:flex; gap:6px; background:rgba(0,0,0,0.65); padding:6px 12px; border-radius:20px; backdrop-filter:blur(6px); z-index:99; }" + &
          "  .btn { background:#2d2d2d; color:#ffffff; border:1px solid #444; padding:6px 12px; border-radius:14px; cursor:pointer; font-size:12px; font-weight:600; outline:none; transition:0.2s; }" + &
          "  .btn:hover { background:#0078d4; border-color:#0078d4; }" + &
          "</style></head><body>" + &
          "  <div id='viewer'><img id='target-img' src='" + ls_url_img + "' alt='Foto' /></div>" + &
          "  <div class='toolbar'>" + &
          "    <button class='btn' onclick='rot(-90)'>↺ -90°</button>" + &
          "    <button class='btn' onclick='rot(90)'>↻ +90°</button>" + &
          "    <button class='btn' onclick='zoom(0.2)'>+ Zoom</button>" + &
          "    <button class='btn' onclick='zoom(-0.2)'>- Zoom</button>" + &
          "    <button class='btn' onclick='rst()'>1:1 Restablecer</button>" + &
          "  </div>" + &
          "  <script>" + &
          "    let s = 1, x = 0, y = 0, r = 0, drag = false, sx = 0, sy = 0;" + &
          "    const img = document.getElementById('target-img');" + &
          "    const v = document.getElementById('viewer');" + &
          "    function render() { img.style.transform = `translate(${x}px, ${y}px) rotate(${r}deg) scale(${s})`; }" + &
          "    function zoom(d) { s = Math.min(Math.max(0.2, s + d), 8); render(); }" + &
          "    function rot(d) { r = (r + d) % 360; render(); }" + &
          "    function rst() { s = 1; x = 0; y = 0; r = 0; render(); }" + &
          "    v.addEventListener('wheel', e => { e.preventDefault(); zoom(e.deltaY < 0 ? 0.15 : -0.15); }, { passive:false });" + &
          "    v.addEventListener('mousedown', e => { if(e.button === 0) { drag = true; sx = e.clientX - x; sy = e.clientY - y; } });" + &
          "    window.addEventListener('mousemove', e => { if(drag) { x = e.clientX - sx; y = e.clientY - sy; render(); } });" + &
          "    window.addEventListener('mouseup', () => drag = false);" + &
          "    window.addEventListener('keydown', e => {" + &
          "      if(e.key === 'r' || e.key === 'R') rot(90);" + &
          "      if(e.key === 'Escape') rst();" + &
          "    });" + &
          "  </script></body></html>"

// 4. Ruta del archivo temporal único
ls_temp_dir  = wf_get_temp_dir()
is_temp_html = ls_temp_dir + "viewer_prod_" + String(Cpu()) + ".html"

// 5. Grabar el archivo en disco
FileDelete(is_temp_html)
li_file = FileOpen(is_temp_html, LineMode!, Write!, Shared!, Replace!, EncodingUTF8!)
IF li_file > 0 THEN
    FileWrite(li_file, ls_html)
    FileClose(li_file)
ELSE
    MessageBox("Error", "No se pudo escribir el archivo HTML en la carpeta temporal.", StopSign!)
    RETURN
END IF

// 6. Navegar al archivo local generado
wb_1.Navigate("file:///" + wf_replace_all(is_temp_html, "\", "/"))
end event

type wb_1 from webbrowser within w_foto_producto_new
integer y = 120
integer width = 1701
integer height = 1044
end type

event navigationerror;// Evento: navigationerror (long errorcode, string errortext, string uri)
string ls_mensaje

ls_mensaje = "Fallo en la navegación del WebBrowser:~r~n~r~n" + &
             "URI: " + failedurl + "~r~n" + &
             "Código de error: " + String(errorcode) + "~r~n" + &
             "Descripción: " + errortext

MessageBox("Error de Navegación", ls_mensaje, StopSign!)
end event

