forward
global type w_filtrar_rep_exist_marca from window
end type
type cbx_1 from checkbox within w_filtrar_rep_exist_marca
end type
type dw_1 from datawindow within w_filtrar_rep_exist_marca
end type
type cb_2 from commandbutton within w_filtrar_rep_exist_marca
end type
type cb_1 from commandbutton within w_filtrar_rep_exist_marca
end type
end forward

global type w_filtrar_rep_exist_marca from window
integer width = 1792
integer height = 1332
boolean titlebar = true
string title = "Especificar Filtro"
windowtype windowtype = response!
long backcolor = 15793151
string icon = "AppIcon!"
boolean center = true
windowanimationstyle openanimation = centeranimation!
windowanimationstyle closeanimation = centeranimation!
cbx_1 cbx_1
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
end type
global w_filtrar_rep_exist_marca w_filtrar_rep_exist_marca

type variables
str_rangofecha lstr_rangfech
string is_descrip[]
end variables

on w_filtrar_rep_exist_marca.create
this.cbx_1=create cbx_1
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.cbx_1,&
this.dw_1,&
this.cb_2,&
this.cb_1}
end on

on w_filtrar_rep_exist_marca.destroy
destroy(this.cbx_1)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;lstr_rangfech = message.powerobjectparm
string ls_descripciones, ls_oc, ls_descrip, ls_sexo
integer i, li_fila
sqlca.autocommit = true

dw_1.settransobject(sqlca)
for i = 1 to upperbound(lstr_rangfech.descripcion)
	ls_descripciones = lstr_rangfech.descripcion[i]
	dw_1.insertrow(i)
	dw_1.setitem(i,'descripciones', ls_descripciones)
next

for i = 1 to upperbound(lstr_rangfech.descrip)
	ls_descrip = lstr_rangfech.descrip[i]
	li_fila = dw_1.find('descripciones = "'+ls_descrip+'"',1,dw_1.rowcount())
	if li_fila > 0 then
		dw_1.setitem(li_fila,'filtrar',1)
	end if
next
if upperbound(lstr_rangfech.descrip) > 0 then
	cbx_1.checked = true
	cbx_1.text = 'Desmarcar Todas'
else
	cbx_1.checked = false
	cbx_1.text = 'Marcar Todas'	
end if

dw_1.setfocus()
end event

type cbx_1 from checkbox within w_filtrar_rep_exist_marca
integer x = 46
integer width = 622
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Desmarcar"
end type

event clicked;integer li_marcar, i
if this.checked then
	cbx_1.text = 'Desmarcar Todas'
	li_marcar = 1
else
	cbx_1.text = 'Marcar Todas'	
	li_marcar = 0
end if

for i = 1 to dw_1.rowcount()
	dw_1.setitem(i,'filtrar',li_marcar)
next
end event

type dw_1 from datawindow within w_filtrar_rep_exist_marca
integer x = 32
integer y = 80
integer width = 1728
integer height = 1008
integer taborder = 10
string dataobject = "dw_external_filtrar"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_filtrar_rep_exist_marca
integer x = 398
integer y = 1112
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Filtrar"
end type

event clicked;integer i, j
string ls_descrip, ls_nulo[]
j = 0
lstr_rangfech.descrip[] = ls_nulo[]

for i = 1 to dw_1.rowcount()
	if dw_1.getitemnumber(i,'filtrar') = 1 then
		j ++
		lstr_rangfech.descrip[j] = dw_1.getitemstring(i,'descripciones')
		
		if j = 1 then
			ls_descrip = '(( cramarca_amar_nombre_marca = "' +dw_1.getitemstring(i,'descripciones')+'" ) '
		else
			ls_descrip = ls_descrip + ' or (cramarca_amar_nombre_marca = "' +dw_1.getitemstring(i,'descripciones')+'") '
		end if
	end if
next
if len(ls_descrip) > 0 then ls_descrip = ls_descrip + ')'
lstr_rangfech.descripciones = ls_descrip
closewithreturn(w_filtrar_rep_exist_marca,lstr_rangfech)
end event

type cb_1 from commandbutton within w_filtrar_rep_exist_marca
integer x = 910
integer y = 1116
integer width = 384
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
end type

event clicked;closewithreturn(w_filtrar_rep_exist_marca,lstr_rangfech)
end event

