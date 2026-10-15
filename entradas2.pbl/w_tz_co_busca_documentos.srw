//objectcomments Ventana para la búsqueda de Facturas de Proveedor y/o Secuencias de Inventario
forward
global type w_tz_co_busca_documentos from w_fa_padre
end type
type cb_aceptar from commandbutton within w_tz_co_busca_documentos
end type
type st_1 from statictext within w_tz_co_busca_documentos
end type
type cb_cancelar from commandbutton within w_tz_co_busca_documentos
end type
type st_2 from statictext within w_tz_co_busca_documentos
end type
end forward

global type w_tz_co_busca_documentos from w_fa_padre
integer width = 2848
integer height = 1280
string title = "Entradas al Inventario"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
toolbaralignment toolbaralignment = floating!
cb_aceptar cb_aceptar
st_1 st_1
cb_cancelar cb_cancelar
st_2 st_2
end type
global w_tz_co_busca_documentos w_tz_co_busca_documentos

type variables
str_tz_documentos str_tz_doctos
Long il_old_row
//String is_orden_, is_ultima_
end variables

on w_tz_co_busca_documentos.create
int iCurrent
call super::create
this.cb_aceptar=create cb_aceptar
this.st_1=create st_1
this.cb_cancelar=create cb_cancelar
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_aceptar
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_cancelar
this.Control[iCurrent+4]=this.st_2
end on

on w_tz_co_busca_documentos.destroy
call super::destroy
destroy(this.cb_aceptar)
destroy(this.st_1)
destroy(this.cb_cancelar)
destroy(this.st_2)
end on

event ue_post_open;/*carga los data windows */

datawindowchild dwc_proveedor
dw_1.settransObject(SQLCA)
If dw_1.retrieve(str.g_financiero,str.empresa) < 1 Then
	mensaje("Atención","No existen documentos para este año","")
	close(This)
	Return
End If

dw_1.GetChild ("tmov_terceros",dwc_proveedor)
dwc_proveedor.SetTransObject(SQLCA);

dw_1.SetTransObject(SQLCA);
If dwc_proveedor.retrieve() < 1 Then dwc_proveedor.InsertRow(0)

dw_1.Sort()

dw_1.ScrollToRow(dw_1.Rowcount())
// Para que se posicione en el campo de numero de pedido
dw_1.setcolumn(1)
dw_1.setfocus()
dw_1.enabled = true

end event

event open;call super::open;
end event

event resize;//Override
st_nom_ventana.y = newheight - (st_nom_ventana.height + 10)
dw_1.Resize(newwidth - 120, newheight - 185)
dw_1.x = 60
dw_1.Y = 50

cb_aceptar.y = newheight - (cb_aceptar.height + 10)
cb_aceptar.x = dw_1.x + dw_1.Width - (cb_aceptar.Width + 10 )
st_1.y = cb_aceptar.y -10
st_1.x = dw_1.x + dw_1.Width - (st_1.Width )

cb_cancelar.y = newheight - (cb_cancelar.height + 10)
cb_cancelar.x = dw_1.x + dw_1.Width - (cb_cancelar.Width + cb_aceptar.Width +50)
st_2.y = cb_cancelar.y -10
st_2.x = dw_1.x + dw_1.Width - (st_2.Width + st_1.Width + 30 )

//gb_1.Width = newwidth - 75
//gb_1.Height = newheight - 120



end event

event close;if isvalid(this) then
	CloseWithReturn(this,str_tz_doctos)
End If
//if isvalid(this) then close(this)
end event

event closequery;//Override
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_tz_co_busca_documentos
boolean visible = false
integer x = 41
integer y = 1092
integer height = 72
end type

type dw_1 from w_fa_padre`dw_1 within w_tz_co_busca_documentos
event ue_post_change ( )
event ue_post_clicked ( )
event ue_set_column ( )
event ue_adicionar ( )
event ue_valida_existen ( )
event key pbm_keydown
integer x = 27
integer width = 2757
integer height = 992
integer taborder = 10
string dataobject = "dw_ca_tz_busca_documentos"
boolean vscrollbar = true
boolean border = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_1::key;long ll_i

If keyDown(KeyEnd!) and keyDown(KeyShift!) Then
	FOR ll_i = il_old_row TO this.RowCount()
		this.SelectRow(ll_i,true)
	NEXT
ElseIf keyDown(KeyHome!) and keyDown(KeyShift!) Then
	FOR ll_i = il_old_row TO 1 STEP -1
		this.SelectRow(ll_i,true)
	NEXT
ElseIf keyDown(KeyUpArrow!) and keyDown(KeyShift!) Then	 
	this.SelectRow(This.GetRow() - 1,true)
ElseIf keyDown(KeyDownArrow!) and keyDown(KeyShift!) Then	
	this.SelectRow(This.GetRow() + 1,true)
ElseIf keyDown(KeyUpArrow!)then
	this.SelectRow(0,false)
	this.SelectRow(This.GetRow() - 1, true)
ElseIf keyDown(KeyDownArrow!)then
	this.SelectRow(0,false)
	this.SelectRow(This.GetRow() + 1, true)
End If

end event

event dw_1::clicked;dw=this
//validaciones de las teclas
long ll_i

If keyDown(keyControl!) Then  
	If IsSelected(row) Then
		this.SelectRow(row,false)
	Else
		this.SelectRow(row,true)
	End if
ElseIf keyDown(KeyShift!) Then
	FOR ll_i = il_old_row TO row
		this.SelectRow(ll_i,true)
	NEXT
ElseIf keyDown(KeyLeftButton!) Then
	this.SelectRow(0,false)
	this.SelectRow(row,true)
End If
il_old_row = row
//***************  ***************  ***************//
//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto
integer li_pos 

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if right(ls_objeto,2)='_t' then

	ls_objeto = left(ls_objeto,len(ls_objeto)-2)
	
	if ls_objeto = is_ultima_ or is_ultima_ = "" then	//Si es la misma columna 
																	// o si es la primera vez
		if is_orden_  = "" or is_orden_ = "D" then
			is_orden_ = 'A'		
			this.SetSort(ls_objeto+" A")	//Ordena Ascendente
			this.sort()		
		else
			is_orden_ = 'D'					
			this.SetSort(ls_objeto+" D")	//Ordena Descendente
			this.sort()				
		end if	
		is_ultima_ = ls_objeto		
	else				
			is_orden_ = 'A'
			this.SetSort(ls_objeto+" A")
			this.sort()
			is_ultima_ = ls_objeto
	end if

end if
end event

event dw_1::editchanged;
wf_valida_menu()

end event

event dw_1::doubleclicked;cb_aceptar.Postevent("clicked")
end event

type st_ayuda from w_fa_padre`st_ayuda within w_tz_co_busca_documentos
end type

type cb_aceptar from commandbutton within w_tz_co_busca_documentos
integer x = 2222
integer y = 1076
integer width = 265
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;If dw_1.IsSelected(dw_1.GetRow()) = TRUE Then
	//cargar estructura con los documentos
	//tmov_concepto  
	str_tz_doctos.sec_inventario = dw_1.GetItemNumber(dw_1.GetRow(),"tmov_secuencia") 
	str_tz_doctos.documento = dw_1.GetItemString(dw_1.GetRow(),"tmov_documento")
	str_tz_doctos.anio = dw_1.GetItemNumber(dw_1.GetRow(),"tmov_anual")
	str_tz_doctos.tipo = dw_1.GetItemString(dw_1.GetRow(),"tmov_concepto")
	str_tz_doctos.viene_de_buscar = 1

	Parent.triggerevent("Close")
Else
	mensaje("Atención ","No hay registro seleccionado, selecciónelo ...","")
	Return
End If


end event

type st_1 from statictext within w_tz_co_busca_documentos
integer x = 2213
integer y = 1068
integer width = 279
integer height = 120
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_cancelar from commandbutton within w_tz_co_busca_documentos
integer x = 2514
integer y = 1072
integer width = 265
integer height = 108
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;str_tz_doctos.viene_de_buscar = 0
Parent.triggerevent("Close")

end event

type st_2 from statictext within w_tz_co_busca_documentos
integer x = 2505
integer y = 1068
integer width = 279
integer height = 120
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

