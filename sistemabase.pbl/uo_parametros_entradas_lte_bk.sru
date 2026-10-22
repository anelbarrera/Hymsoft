//objectcomments  
forward
global type uo_parametros_entradas_lte_bk from uo_base_module
end type
type st_titulo from statictext within uo_parametros_entradas_lte_bk
end type
type cb_nuevo from commandbutton within uo_parametros_entradas_lte_bk
end type
type cb_guardar from commandbutton within uo_parametros_entradas_lte_bk
end type
type cb_eliminar from commandbutton within uo_parametros_entradas_lte_bk
end type
type cb_refrescar from commandbutton within uo_parametros_entradas_lte_bk
end type
type tab_catalogos from tab within uo_parametros_entradas_lte_bk
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
type tab_catalogos from tab within uo_parametros_entradas_lte_bk
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

global type uo_parametros_entradas_lte_bk from uo_base_module
integer width = 4549
integer height = 2700
event resize pbm_size
event ue_guardar ( )
event ue_nuevo ( )
event ue_eliminar ( )
event ue_refrescar ( )
st_titulo st_titulo
cb_nuevo cb_nuevo
cb_guardar cb_guardar
cb_eliminar cb_eliminar
cb_refrescar cb_refrescar
tab_catalogos tab_catalogos
end type
global uo_parametros_entradas_lte_bk uo_parametros_entradas_lte_bk

forward prototypes
public subroutine of_init (string as_params)
public function boolean of_can_close ()
end prototypes

event resize;long ll_btn_w = 310
long ll_gap = 20
long ll_right_margin = 40

// 1. Título alineado a la izquierda
st_titulo.Move(40, 25)

// 2. Barra de acciones alineada a la derecha
cb_refrescar.Move(newwidth - ll_right_margin - ll_btn_w, 20)
cb_eliminar.Move(cb_refrescar.X - ll_gap - ll_btn_w, 20)
cb_guardar.Move(cb_eliminar.X - ll_gap - ll_btn_w, 20)
cb_nuevo.Move(cb_guardar.X - ll_gap - ll_btn_w, 20)

// 3. Tab expandido en el área restante
if newwidth > 80 and newheight > 160 then
    tab_catalogos.Move(30, 130)
    tab_catalogos.Resize(newwidth - 60, newheight - 150)
end if
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
// Sobrescritura de la rutina de uo_base_module
// Disparada dinámicamente al invocarse con of_load_module
this.post event ue_refrescar()
end subroutine

public function boolean of_can_close ();
// Valida si existen modificaciones pendientes antes de permitir
// que w_dashboard cierre o reemplace este módulo.
// Retornar 'false' cancela la navegación; 'true' la autoriza.
return true
end function

on uo_parametros_entradas_lte_bk.create
int iCurrent
call super::create
this.st_titulo=create st_titulo
this.cb_nuevo=create cb_nuevo
this.cb_guardar=create cb_guardar
this.cb_eliminar=create cb_eliminar
this.cb_refrescar=create cb_refrescar
this.tab_catalogos=create tab_catalogos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_titulo
this.Control[iCurrent+2]=this.cb_nuevo
this.Control[iCurrent+3]=this.cb_guardar
this.Control[iCurrent+4]=this.cb_eliminar
this.Control[iCurrent+5]=this.cb_refrescar
this.Control[iCurrent+6]=this.tab_catalogos
end on

on uo_parametros_entradas_lte_bk.destroy
call super::destroy
destroy(this.st_titulo)
destroy(this.cb_nuevo)
destroy(this.cb_guardar)
destroy(this.cb_eliminar)
destroy(this.cb_refrescar)
destroy(this.tab_catalogos)
end on

type st_titulo from statictext within uo_parametros_entradas_lte_bk
integer x = 41
integer y = 24
integer width = 1399
integer height = 80
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 3355443
long backcolor = 536870912
string text = "Paramétros de Inventario"
boolean focusrectangle = false
end type

type cb_nuevo from commandbutton within uo_parametros_entradas_lte_bk
integer x = 3200
integer y = 20
integer width = 311
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "+ Nuevo"
end type

event clicked;parent.TriggerEvent("ue_nuevo")
end event

type cb_guardar from commandbutton within uo_parametros_entradas_lte_bk
integer x = 3529
integer y = 20
integer width = 311
integer height = 92
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

type cb_eliminar from commandbutton within uo_parametros_entradas_lte_bk
integer x = 3858
integer y = 20
integer width = 311
integer height = 92
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

type cb_refrescar from commandbutton within uo_parametros_entradas_lte_bk
integer x = 4192
integer y = 20
integer width = 311
integer height = 92
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

type tab_catalogos from tab within uo_parametros_entradas_lte_bk
integer x = 32
integer y = 132
integer width = 4489
integer height = 2540
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 16053497
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
integer width = 4453
integer height = 2316
long backcolor = 16777215
string text = "Aranceles"
long tabtextcolor = 3355443
string picturename = "ComputePage1!"
end type

type tabpage_marcas from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4453
integer height = 2316
long backcolor = 16777215
string text = "Marcas"
long tabtextcolor = 3355443
end type

type tabpage_color from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4453
integer height = 2316
long backcolor = 16777215
string text = "Color"
long tabtextcolor = 3355443
end type

type tabpage_tamano from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4453
integer height = 2316
long backcolor = 16777215
string text = "Tamaño"
long tabtextcolor = 3355443
end type

type tabpage_compuestos from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4453
integer height = 2316
long backcolor = 16777215
string text = "Compuestos"
long tabtextcolor = 3355443
end type

type tabpage_organizacion from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4453
integer height = 2316
long backcolor = 16777215
string text = "Organización"
long tabtextcolor = 3355443
end type

type tabpage_paises_puertos from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4453
integer height = 2316
long backcolor = 16777215
string text = "Paises y Puertos"
long tabtextcolor = 3355443
end type

type tabpage_periodos_reporte from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4453
integer height = 2316
long backcolor = 16777215
string text = "Períodos del Reporte"
long tabtextcolor = 3355443
end type

type tabpage_cuentas_entradas from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4453
integer height = 2316
long backcolor = 16777215
string text = "Cuentas de Entradas"
long tabtextcolor = 3355443
end type

type tabpage_gastos_entradas from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4453
integer height = 2316
long backcolor = 16777215
string text = "Gastos de Entradas"
long tabtextcolor = 3355443
end type

type tabpage_descripciones from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4453
integer height = 2316
long backcolor = 16777215
string text = "Descripciones"
long tabtextcolor = 3355443
end type

type tabpage_materiales_composicion from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4453
integer height = 2316
long backcolor = 16777215
string text = "Materiales y Composición"
long tabtextcolor = 3355443
end type

type tabpage_sexo_items from userobject within tab_catalogos
integer x = 18
integer y = 208
integer width = 4453
integer height = 2316
long backcolor = 16777215
string text = "Sexo de Items"
long tabtextcolor = 3355443
end type

