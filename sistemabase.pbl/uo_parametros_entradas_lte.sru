//objectcomments  
forward
global type uo_parametros_entradas_lte from uo_base_module
end type
type r_card_bg from rectangle within uo_parametros_entradas_lte
end type
type r_header_bar from rectangle within uo_parametros_entradas_lte
end type
type st_titulo from statictext within uo_parametros_entradas_lte
end type
type st_badge_count from statictext within uo_parametros_entradas_lte
end type
type sle_buscar from singlelineedit within uo_parametros_entradas_lte
end type
type cb_nuevo from commandbutton within uo_parametros_entradas_lte
end type
type cb_guardar from commandbutton within uo_parametros_entradas_lte
end type
type cb_eliminar from commandbutton within uo_parametros_entradas_lte
end type
type cb_refrescar from commandbutton within uo_parametros_entradas_lte
end type
type r_footer_bar from rectangle within uo_parametros_entradas_lte
end type
type st_footer_info from statictext within uo_parametros_entradas_lte
end type
type tab_catalogos from tab within uo_parametros_entradas_lte
end type
type tabpage_aranceles from userobject within tab_catalogos
end type
type tabpage_aranceles from userobject within tab_catalogos
end type
type tabpage_marcas from userobject within tab_catalogos
end type
type tabpage_marcas from userobject within tab_catalogos
end type
type tabpage_color from userobject within tab_catalogos
end type
type tabpage_color from userobject within tab_catalogos
end type
type tabpage_tamano from userobject within tab_catalogos
end type
type tabpage_tamano from userobject within tab_catalogos
end type
type tabpage_compuestos from userobject within tab_catalogos
end type
type tabpage_compuestos from userobject within tab_catalogos
end type
type tabpage_organizacion from userobject within tab_catalogos
end type
type tabpage_organizacion from userobject within tab_catalogos
end type
type tabpage_paises_puertos from userobject within tab_catalogos
end type
type tabpage_paises_puertos from userobject within tab_catalogos
end type
type tabpage_periodos_reporte from userobject within tab_catalogos
end type
type tabpage_periodos_reporte from userobject within tab_catalogos
end type
type tabpage_cuentas_entradas from userobject within tab_catalogos
end type
type tabpage_cuentas_entradas from userobject within tab_catalogos
end type
type tabpage_gastos_entradas from userobject within tab_catalogos
end type
type tabpage_gastos_entradas from userobject within tab_catalogos
end type
type tabpage_descripciones from userobject within tab_catalogos
end type
type tabpage_descripciones from userobject within tab_catalogos
end type
type tabpage_materiales_composicion from userobject within tab_catalogos
end type
type tabpage_materiales_composicion from userobject within tab_catalogos
end type
type tabpage_sexo_items from userobject within tab_catalogos
end type
type tabpage_sexo_items from userobject within tab_catalogos
end type
type tab_catalogos from tab within uo_parametros_entradas_lte
tabpage_aranceles tabpage_aranceles
tabpage_marcas tabpage_marcas
tabpage_color tabpage_color
tabpage_tamano tabpage_tamano
tabpage_compuestos tabpage_compuestos
tabpage_organizacion tabpage_organizacion
tabpage_paises_puertos tabpage_paises_puertos
tabpage_periodos_reporte tabpage_periodos_reporte
tabpage_cuentas_entradas tabpage_cuentas_entradas
tabpage_gastos_entradas tabpage_gastos_entradas
tabpage_descripciones tabpage_descripciones
tabpage_materiales_composicion tabpage_materiales_composicion
tabpage_sexo_items tabpage_sexo_items
end type
end forward

global type uo_parametros_entradas_lte from uo_base_module
integer width = 4549
integer height = 2700
event resize pbm_size
event ue_guardar ( )
event ue_nuevo ( )
event ue_eliminar ( )
event ue_refrescar ( )
r_card_bg r_card_bg
r_header_bar r_header_bar
st_titulo st_titulo
st_badge_count st_badge_count
sle_buscar sle_buscar
cb_nuevo cb_nuevo
cb_guardar cb_guardar
cb_eliminar cb_eliminar
cb_refrescar cb_refrescar
r_footer_bar r_footer_bar
st_footer_info st_footer_info
tab_catalogos tab_catalogos
end type
global uo_parametros_entradas_lte uo_parametros_entradas_lte

forward prototypes
public subroutine of_init (string as_params)
public function boolean of_can_close ()
end prototypes

event resize;long ll_pad = 25
long ll_card_x, ll_card_y, ll_card_w, ll_card_h
long ll_hdr_h = 115
long ll_ftr_h = 65
long ll_btn_w = 270
long ll_btn_h = 78
long ll_btn_y
long ll_gap = 12
long ll_search_w = 580

if newwidth < 800 or newheight < 500 then return

ll_card_x = ll_pad
ll_card_y = ll_pad
ll_card_w = newwidth - (ll_pad * 2)
ll_card_h = newheight - (ll_pad * 2)
ll_btn_y  = ll_card_y + 18

// 1. Marco exterior de Tarjeta AdminLTE
r_card_bg.Move(ll_card_x, ll_card_y)
r_card_bg.Resize(ll_card_w, ll_card_h)

// 2. Cabecera de la Tarjeta
r_header_bar.Move(ll_card_x, ll_card_y)
r_header_bar.Resize(ll_card_w, ll_hdr_h)

st_titulo.Move(ll_card_x + 30, ll_card_y + 24)
st_titulo.Resize(620, 65)

st_badge_count.Move(st_titulo.X + st_titulo.Width + 10, ll_card_y + 24)
//st_badge_count.Resize(340, 58)

// Botones de acción alineados a la derecha
cb_refrescar.Move(ll_card_x + ll_card_w - 25 - ll_btn_w, ll_btn_y)
cb_refrescar.Resize(ll_btn_w, ll_btn_h)

cb_eliminar.Move(cb_refrescar.X - ll_gap - ll_btn_w, ll_btn_y)
cb_eliminar.Resize(ll_btn_w, ll_btn_h)

cb_guardar.Move(cb_eliminar.X - ll_gap - ll_btn_w, ll_btn_y)
cb_guardar.Resize(ll_btn_w, ll_btn_h)

cb_nuevo.Move(cb_guardar.X - ll_gap - ll_btn_w, ll_btn_y)
cb_nuevo.Resize(ll_btn_w, ll_btn_h)

// Buscador en tiempo real justo antes de los botones
sle_buscar.Move(cb_nuevo.X - ll_gap - ll_search_w, ll_btn_y)
sle_buscar.Resize(ll_search_w, ll_btn_h)

// 3. Footer inferior de auditoría
r_footer_bar.Move(ll_card_x, ll_card_y + ll_card_h - ll_ftr_h)
r_footer_bar.Resize(ll_card_w, ll_ftr_h)

st_footer_info.Move(ll_card_x + 25, r_footer_bar.Y + 14)
st_footer_info.Resize(ll_card_w - 50, 42)

// 4. Tab Control (Cuerpo central de la Tarjeta)
tab_catalogos.Move(ll_card_x + 8, ll_card_y + ll_hdr_h + 8)
tab_catalogos.Resize(ll_card_w - 16, ll_card_h - ll_hdr_h - ll_ftr_h - 16)
end event

event ue_guardar;
// Lógica para guardar la pestaña activa
end event

event ue_nuevo;
// Lógica para insertar registro en la pestaña activa
end event

event ue_eliminar;
// Lógica para eliminar registro en la pestaña activa
end event

event ue_refrescar;
// Lógica para recargar la pestaña activa
end event

public subroutine of_init (string as_params);
// Inicialización del módulo
this.post event ue_refrescar()
end subroutine

public function boolean of_can_close ();
// Validar si existen modificaciones pendientes antes de cerrar
return true
end function

on uo_parametros_entradas_lte.create
int iCurrent
call super::create
this.r_card_bg=create r_card_bg
this.r_header_bar=create r_header_bar
this.st_titulo=create st_titulo
this.st_badge_count=create st_badge_count
this.sle_buscar=create sle_buscar
this.cb_nuevo=create cb_nuevo
this.cb_guardar=create cb_guardar
this.cb_eliminar=create cb_eliminar
this.cb_refrescar=create cb_refrescar
this.r_footer_bar=create r_footer_bar
this.st_footer_info=create st_footer_info
this.tab_catalogos=create tab_catalogos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.r_card_bg
this.Control[iCurrent+2]=this.r_header_bar
this.Control[iCurrent+3]=this.st_titulo
this.Control[iCurrent+4]=this.st_badge_count
this.Control[iCurrent+5]=this.sle_buscar
this.Control[iCurrent+6]=this.cb_nuevo
this.Control[iCurrent+7]=this.cb_guardar
this.Control[iCurrent+8]=this.cb_eliminar
this.Control[iCurrent+9]=this.cb_refrescar
this.Control[iCurrent+10]=this.r_footer_bar
this.Control[iCurrent+11]=this.st_footer_info
this.Control[iCurrent+12]=this.tab_catalogos
end on

on uo_parametros_entradas_lte.destroy
call super::destroy
destroy(this.r_card_bg)
destroy(this.r_header_bar)
destroy(this.st_titulo)
destroy(this.st_badge_count)
destroy(this.sle_buscar)
destroy(this.cb_nuevo)
destroy(this.cb_guardar)
destroy(this.cb_eliminar)
destroy(this.cb_refrescar)
destroy(this.r_footer_bar)
destroy(this.st_footer_info)
destroy(this.tab_catalogos)
end on

type r_card_bg from rectangle within uo_parametros_entradas_lte
long linecolor = 14540254
integer linethickness = 1
long fillcolor = 16777215
integer x = 23
integer y = 24
integer width = 4498
integer height = 2652
end type

type r_header_bar from rectangle within uo_parametros_entradas_lte
long linecolor = 14540254
integer linethickness = 1
long fillcolor = 16316664
integer x = 23
integer y = 24
integer width = 4498
integer height = 116
end type

type st_titulo from statictext within uo_parametros_entradas_lte
integer x = 55
integer y = 48
integer width = 622
integer height = 64
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 3355443
long backcolor = 16316664
string text = "Parametros:"
boolean focusrectangle = false
end type

type st_badge_count from statictext within uo_parametros_entradas_lte
integer x = 686
integer y = 48
integer width = 773
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16777215
long backcolor = 13421568
string text = "Aranceles"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_buscar from singlelineedit within uo_parametros_entradas_lte
integer x = 1682
integer y = 44
integer width = 581
integer height = 80
integer taborder = 15
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 3355443
borderstyle borderstyle = stylelowered!
end type

type cb_nuevo from commandbutton within uo_parametros_entradas_lte
integer x = 2281
integer y = 44
integer width = 270
integer height = 80
integer taborder = 20
integer textsize = -9
integer weight = 600
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "+ Nuevo"
end type

event clicked;parent.TriggerEvent("ue_nuevo")
end event

type cb_guardar from commandbutton within uo_parametros_entradas_lte
integer x = 2560
integer y = 44
integer width = 270
integer height = 80
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Guardar"
end type

event clicked;parent.TriggerEvent("ue_guardar")
end event

type cb_eliminar from commandbutton within uo_parametros_entradas_lte
integer x = 2843
integer y = 44
integer width = 270
integer height = 80
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Eliminar"
end type

event clicked;parent.TriggerEvent("ue_eliminar")
end event

type cb_refrescar from commandbutton within uo_parametros_entradas_lte
integer x = 3127
integer y = 44
integer width = 270
integer height = 80
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Recargar"
end type

event clicked;parent.TriggerEvent("ue_refrescar")
end event

type r_footer_bar from rectangle within uo_parametros_entradas_lte
long linecolor = 14540254
integer linethickness = 1
long fillcolor = 16316664
integer x = 23
integer y = 2612
integer width = 4498
integer height = 64
end type

type st_footer_info from statictext within uo_parametros_entradas_lte
integer x = 50
integer y = 2624
integer width = 2002
integer height = 44
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 7368816
long backcolor = 16316664
string text = "Catálogo activo: Aranceles | Administre los parámetros del inventario."
boolean focusrectangle = false
end type

type tab_catalogos from tab within uo_parametros_entradas_lte
integer x = 32
integer y = 148
integer width = 4485
integer height = 2456
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 16777215
boolean multiline = true
boolean raggedright = true
boolean createondemand = true
tabpage_aranceles tabpage_aranceles
tabpage_marcas tabpage_marcas
tabpage_color tabpage_color
tabpage_tamano tabpage_tamano
tabpage_compuestos tabpage_compuestos
tabpage_organizacion tabpage_organizacion
tabpage_paises_puertos tabpage_paises_puertos
tabpage_periodos_reporte tabpage_periodos_reporte
tabpage_cuentas_entradas tabpage_cuentas_entradas
tabpage_gastos_entradas tabpage_gastos_entradas
tabpage_descripciones tabpage_descripciones
tabpage_materiales_composicion tabpage_materiales_composicion
tabpage_sexo_items tabpage_sexo_items
end type

event selectionchanged;string ls_nombre
ls_nombre = this.Control[newindex].Text
st_badge_count.Text = ls_nombre
st_footer_info.Text = "Catálogo activo: " + ls_nombre + " | Utilice la barra superior para buscar o modificar registros."
sle_buscar.Text = ""
end event

on tab_catalogos.create
this.tabpage_aranceles=create tabpage_aranceles
this.tabpage_marcas=create tabpage_marcas
this.tabpage_color=create tabpage_color
this.tabpage_tamano=create tabpage_tamano
this.tabpage_compuestos=create tabpage_compuestos
this.tabpage_organizacion=create tabpage_organizacion
this.tabpage_paises_puertos=create tabpage_paises_puertos
this.tabpage_periodos_reporte=create tabpage_periodos_reporte
this.tabpage_cuentas_entradas=create tabpage_cuentas_entradas
this.tabpage_gastos_entradas=create tabpage_gastos_entradas
this.tabpage_descripciones=create tabpage_descripciones
this.tabpage_materiales_composicion=create tabpage_materiales_composicion
this.tabpage_sexo_items=create tabpage_sexo_items
this.Control[]={this.tabpage_aranceles,&
this.tabpage_marcas,&
this.tabpage_color,&
this.tabpage_tamano,&
this.tabpage_compuestos,&
this.tabpage_organizacion,&
this.tabpage_paises_puertos,&
this.tabpage_periodos_reporte,&
this.tabpage_cuentas_entradas,&
this.tabpage_gastos_entradas,&
this.tabpage_descripciones,&
this.tabpage_materiales_composicion,&
this.tabpage_sexo_items}
end on

on tab_catalogos.destroy
destroy(this.tabpage_aranceles)
destroy(this.tabpage_marcas)
destroy(this.tabpage_color)
destroy(this.tabpage_tamano)
destroy(this.tabpage_compuestos)
destroy(this.tabpage_organizacion)
destroy(this.tabpage_paises_puertos)
destroy(this.tabpage_periodos_reporte)
destroy(this.tabpage_cuentas_entradas)
destroy(this.tabpage_gastos_entradas)
destroy(this.tabpage_descripciones)
destroy(this.tabpage_materiales_composicion)
destroy(this.tabpage_sexo_items)
end on

type tabpage_aranceles from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4448
integer height = 2232
long backcolor = 16777215
string text = "Aranceles"
long tabtextcolor = 3355443
string picturename = ".\art\ico_aranceles.svg"
long picturemaskcolor = 536870912
end type

type tabpage_marcas from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4448
integer height = 2232
long backcolor = 16777215
string text = "Marcas"
long tabtextcolor = 3355443
string picturename = ".\art\ico_marcas.svg"
long picturemaskcolor = 536870912
end type

type tabpage_color from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4448
integer height = 2232
long backcolor = 16777215
string text = "Color"
long tabtextcolor = 3355443
string picturename = ".\art\ico_color.svg"
long picturemaskcolor = 536870912
end type

type tabpage_tamano from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4448
integer height = 2232
long backcolor = 16777215
string text = "Tamaño"
long tabtextcolor = 3355443
string picturename = ".\art\ico_tamano.svg"
long picturemaskcolor = 536870912
end type

type tabpage_compuestos from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4448
integer height = 2232
long backcolor = 16777215
string text = "Compuestos"
long tabtextcolor = 3355443
string picturename = ".\art\ico_compuestos.svg"
long picturemaskcolor = 536870912
end type

type tabpage_organizacion from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4448
integer height = 2232
long backcolor = 16777215
string text = "Organización"
long tabtextcolor = 3355443
string picturename = ".\art\ico_organizacion.svg"
long picturemaskcolor = 536870912
end type

type tabpage_paises_puertos from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4448
integer height = 2232
long backcolor = 16777215
string text = "Paises y Puertos"
long tabtextcolor = 3355443
string picturename = ".\art\ico_puertos.svg"
long picturemaskcolor = 536870912
end type

type tabpage_periodos_reporte from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4448
integer height = 2232
long backcolor = 16777215
string text = "Períodos del Reporte"
long tabtextcolor = 3355443
string picturename = ".\art\ico_calendario.svg"
long picturemaskcolor = 536870912
end type

type tabpage_cuentas_entradas from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4448
integer height = 2232
long backcolor = 16777215
string text = "Cuentas de Entradas"
long tabtextcolor = 3355443
string picturename = ".\art\ico_cuentas.svg"
long picturemaskcolor = 536870912
end type

type tabpage_gastos_entradas from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4448
integer height = 2232
long backcolor = 16777215
string text = "Gastos de Entradas"
long tabtextcolor = 3355443
string picturename = ".\art\ico_gastos.svg"
long picturemaskcolor = 536870912
end type

type tabpage_descripciones from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4448
integer height = 2232
long backcolor = 16777215
string text = "Descripciones"
long tabtextcolor = 3355443
string picturename = ".\art\ico_descripcion.svg"
long picturemaskcolor = 536870912
end type

type tabpage_materiales_composicion from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4448
integer height = 2232
long backcolor = 16777215
string text = "Materiales y Composición"
long tabtextcolor = 3355443
string picturename = ".\art\ico_materiales.svg"
long picturemaskcolor = 536870912
end type

type tabpage_sexo_items from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4448
integer height = 2232
long backcolor = 16777215
string text = "Sexo de Items"
long tabtextcolor = 3355443
string picturename = ".\art\ico_sexo.svg"
long picturemaskcolor = 536870912
end type

