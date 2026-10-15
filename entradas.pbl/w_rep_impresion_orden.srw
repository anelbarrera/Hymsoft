//objectcomments Ventana de Impresión del Reporte de Ventas x Factura
forward
global type w_rep_impresion_orden from w_fa_padre_reportes
end type
end forward

global type w_rep_impresion_orden from w_fa_padre_reportes
integer width = 3063
integer height = 1676
string title = "(FA) Informe de Fotos por Proforma / Pedido"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
end type
global w_rep_impresion_orden w_rep_impresion_orden

type variables
Boolean	ib_cerrar
end variables

forward prototypes
public subroutine wf_valida_ingles ()
end prototypes

public subroutine wf_valida_ingles ();
end subroutine

on w_rep_impresion_orden.create
call super::create
end on

on w_rep_impresion_orden.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event resize;//Override
this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 278
gb_1.width  = this.width  - 63
gb_1.height = this.height - 220


st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180


this.SetRedraw(true)

end event

event ue_post_open;//override
String	ls_expresion
Integer	li_pos

dw = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()

dw_1.settransobject(sqlca)

//dw_1.object.hora.expression = "'"+ls_expresion+"'"
//
dw_1.object.datawindow.print.preview = True
dw_1.object.datawindow.print.preview.zoom = 100

This.SetRedraw(True)
end event

event timer;call super::timer;if ib_cerrar then
	//this.postevent("close")
end if
end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_rep_impresion_orden
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_rep_impresion_orden
boolean visible = false
integer x = 32
integer y = 1384
integer width = 1010
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_rep_impresion_orden
integer x = 41
integer y = 40
integer width = 2935
integer height = 1308
string dataobject = "dw_fa_rep_ventas_fac"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type gb_1 from w_fa_padre_reportes`gb_1 within w_rep_impresion_orden
integer x = 27
integer y = 0
integer width = 2967
integer height = 1364
end type

