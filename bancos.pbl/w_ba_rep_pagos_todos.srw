//objectcomments  
forward
global type w_ba_rep_pagos_todos from w_fa_padre
end type
type rb_tercero from radiobutton within w_ba_rep_pagos_todos
end type
type rb_concepto_pago from radiobutton within w_ba_rep_pagos_todos
end type
type dw_cc_inf_antigc1 from commandbutton within w_ba_rep_pagos_todos
end type
type st_2 from statictext within w_ba_rep_pagos_todos
end type
type st_1 from statictext within w_ba_rep_pagos_todos
end type
type em_1 from editmask within w_ba_rep_pagos_todos
end type
type ddlb_meses from dropdownlistbox within w_ba_rep_pagos_todos
end type
type gb_1 from groupbox within w_ba_rep_pagos_todos
end type
end forward

global type w_ba_rep_pagos_todos from w_fa_padre
integer width = 3497
integer height = 1992
string title = "Listado de pagos a terceros (Pagos reportados y no reportados)"
string menuname = "m_fa_rep"
event ue_imprimir ( )
event ue_busca ( )
rb_tercero rb_tercero
rb_concepto_pago rb_concepto_pago
dw_cc_inf_antigc1 dw_cc_inf_antigc1
st_2 st_2
st_1 st_1
em_1 em_1
ddlb_meses ddlb_meses
gb_1 gb_1
end type
global w_ba_rep_pagos_todos w_ba_rep_pagos_todos

type variables
integer ii_mes_seleccionado
long il_ann
end variables

event ue_imprimir;
OpenWithParm(w_dw_print_options, dw_1)
If Message.DoubleParm = -1 Then Return
dw_1.Print(True)
end event

event ue_busca();string ls_ann

em_1.GetData(ls_ann)
ls_ann = em_1.text

il_ann = long(ls_ann)

if il_ann < 2000 then
	MessageBox('Mensaje','Debe seleccionar el año para el que desea generar el archivo.')
	Return
end if

if rb_concepto_pago.checked then
	dw_1.dataobject = 'dw_ba_rep_pagos_todos'
elseif rb_tercero.checked then
	dw_1.dataobject = 'dw_ba_rep_pagos_todos_x_terce'
end if
dw_1.settransobject(sqlca)
if dw_1.retrieve(str.g_financiero,str.empresa,ii_mes_seleccionado,il_ann) = 0 then
	messagebox('Mensaje','No se recuperaron registros.')
else
	dw_1.Object.DataWindow.Print.Preview = 'Yes'
end if	

end event

on w_ba_rep_pagos_todos.create
int iCurrent
call super::create
if this.MenuName = "m_fa_rep" then this.MenuID = create m_fa_rep
this.rb_tercero=create rb_tercero
this.rb_concepto_pago=create rb_concepto_pago
this.dw_cc_inf_antigc1=create dw_cc_inf_antigc1
this.st_2=create st_2
this.st_1=create st_1
this.em_1=create em_1
this.ddlb_meses=create ddlb_meses
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_tercero
this.Control[iCurrent+2]=this.rb_concepto_pago
this.Control[iCurrent+3]=this.dw_cc_inf_antigc1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.em_1
this.Control[iCurrent+7]=this.ddlb_meses
this.Control[iCurrent+8]=this.gb_1
end on

on w_ba_rep_pagos_todos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_tercero)
destroy(this.rb_concepto_pago)
destroy(this.dw_cc_inf_antigc1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.ddlb_meses)
destroy(this.gb_1)
end on

event ue_buscar;call super::ue_buscar;string ls_ann

em_1.GetData(ls_ann)
ls_ann = em_1.text

il_ann = long(ls_ann)

if il_ann < 2000 then
	MessageBox('Mensaje','Debe seleccionar el año para el que desea generar el archivo.')
	Return
end if

if rb_concepto_pago.checked then
	//dw_1.dataobject = 'dw_ba_rep_pagos_todos'
elseif rb_tercero.checked then
	//dw_1.dataobject = 'dw_ba_rep_pagos_todos_x_terce'
end if
//dw_1.settransobject(sqlca)
//if //dw_1.retrieve(str.g_financiero,str.empresa,ii_mes_seleccionado,il_ann) = 0 then
	messagebox('Mensaje','No se recuperaron registros.')
//else
	//dw_1.Object.DataWindow.Print.Preview = 'Yes'
//end if	

end event

event open;call super::open;dw_1.settransobject(SQLCA)

ii_mes_seleccionado = month(date(gf_fecha_serv()))
il_ann = year(date(gf_fecha_serv()))

ddlb_meses.SelectItem (ii_mes_seleccionado)
em_1.text = string(il_ann)
this.y = 1
this.x = 1
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_ba_rep_pagos_todos
boolean visible = false
end type

type dw_1 from w_fa_padre`dw_1 within w_ba_rep_pagos_todos
integer x = 59
integer y = 224
integer width = 3365
integer height = 1548
string dataobject = "dw_ba_rep_pagos_todos"
end type

event dw_1::ue_microayuda;//override
end event

type st_ayuda from w_fa_padre`st_ayuda within w_ba_rep_pagos_todos
end type

type rb_tercero from radiobutton within w_ba_rep_pagos_todos
integer x = 2382
integer y = 84
integer width = 343
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tercero"
end type

event clicked;if checked then
	dw_1.reset()
end if
end event

type rb_concepto_pago from radiobutton within w_ba_rep_pagos_todos
integer x = 1563
integer y = 84
integer width = 571
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Concepto de pago"
boolean checked = true
end type

event clicked;if checked then
	dw_1.reset()
end if
end event

type dw_cc_inf_antigc1 from commandbutton within w_ba_rep_pagos_todos
integer x = 2898
integer y = 60
integer width = 389
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Generar"
boolean default = true
end type

event clicked;parent.triggerevent('ue_busca')
end event

type st_2 from statictext within w_ba_rep_pagos_todos
integer x = 791
integer y = 84
integer width = 151
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_ba_rep_pagos_todos
integer x = 41
integer y = 84
integer width = 155
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mes:"
boolean focusrectangle = false
end type

type em_1 from editmask within w_ba_rep_pagos_todos
integer x = 955
integer y = 64
integer width = 338
integer height = 104
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####"
boolean spin = true
double increment = 1
string minmax = "1999~~"
end type

type ddlb_meses from dropdownlistbox within w_ba_rep_pagos_todos
integer x = 215
integer y = 64
integer width = 539
integer height = 580
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;ii_mes_seleccionado = index
end event

type gb_1 from groupbox within w_ba_rep_pagos_todos
integer x = 1403
integer y = 20
integer width = 1376
integer height = 160
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Aprupar por"
end type

