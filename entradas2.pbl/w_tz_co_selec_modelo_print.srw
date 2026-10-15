forward
global type w_tz_co_selec_modelo_print from w_fa_padre
end type
type cb_aceptar from commandbutton within w_tz_co_selec_modelo_print
end type
type st_1 from statictext within w_tz_co_selec_modelo_print
end type
type cb_cancelar from commandbutton within w_tz_co_selec_modelo_print
end type
type st_2 from statictext within w_tz_co_selec_modelo_print
end type
type sle_nom_ventana from singlelineedit within w_tz_co_selec_modelo_print
end type
end forward

global type w_tz_co_selec_modelo_print from w_fa_padre
integer width = 1829
integer height = 684
string title = "(TZ) Ventana de Selección de Modelo de Impresora para Movimiento Comercial"
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
sle_nom_ventana sle_nom_ventana
end type
global w_tz_co_selec_modelo_print w_tz_co_selec_modelo_print

type variables
str_tz_documentos str_tz_doctos
Long il_old_row
//String is_orden_ , is_ultima_
end variables

forward prototypes
public subroutine wf_aceptar ()
end prototypes

public subroutine wf_aceptar ();If dw_1.Rowcount() = 1 Then
	str_tz_doctos.largo_doc = dw_1.GetItemNumber(1,"primod_largo_doc") 
	str_tz_doctos.ancho_doc = dw_1.GetItemNumber(1,"primod_ancho_doc")
	str_tz_doctos.aceptar = true
	this.triggerevent("Close")
	return
Else
	If dw_1.IsSelected(dw_1.GetRow()) = TRUE Then
		//cargar estructura con los documentos
		str_tz_doctos.largo_doc = dw_1.GetItemNumber(dw_1.GetRow(),"primod_largo_doc") 
		str_tz_doctos.ancho_doc = dw_1.GetItemNumber(dw_1.GetRow(),"primod_ancho_doc")
		str_tz_doctos.aceptar = true
		this.triggerevent("Close")
	Else
		mensaje("Atención ","No hay registro seleccionado, selecciónelo ...","")
		Return
	End If
End If

end subroutine

on w_tz_co_selec_modelo_print.create
int iCurrent
call super::create
this.cb_aceptar=create cb_aceptar
this.st_1=create st_1
this.cb_cancelar=create cb_cancelar
this.st_2=create st_2
this.sle_nom_ventana=create sle_nom_ventana
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_aceptar
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_cancelar
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.sle_nom_ventana
end on

on w_tz_co_selec_modelo_print.destroy
call super::destroy
destroy(this.cb_aceptar)
destroy(this.st_1)
destroy(this.cb_cancelar)
destroy(this.st_2)
destroy(this.sle_nom_ventana)
end on

event ue_post_open;/*carga los data windows */
sle_nom_ventana.text = this.classname()
this.y = 600
dw_1.settransObject(SQLCA)
If dw_1.retrieve() < 1 Then
	mensaje("Atención","No existen impresoras definidas para documentos de movimiento comercial","")
	close(This)
	Return
End If
///********
If dw_1.rowcount() = 1 Then
	dw_1.setcolumn(1)
	dw_1.setfocus()
	dw_1.enabled = true
	wf_aceptar()
	close(This)
	Return
End if
//********
dw_1.setcolumn(1)
dw_1.setfocus()
dw_1.enabled = true

end event

event open;call super::open;
//centrar_w()
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

end event

event closequery;//Override
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_tz_co_selec_modelo_print
boolean visible = false
integer x = 41
integer y = 1092
integer height = 76
end type

type dw_1 from w_fa_padre`dw_1 within w_tz_co_selec_modelo_print
event ue_post_change ( )
event ue_post_clicked ( )
event ue_set_column ( )
event ue_adicionar ( )
event ue_valida_existen ( )
event key pbm_keydown
integer x = 32
integer y = 44
integer width = 1755
integer height = 444
integer taborder = 10
string dataobject = "dw_ca_tz_selec_modelo_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_1::key;//long ll_i
//
//If keyDown(KeyEnd!) and keyDown(KeyShift!) Then
//	FOR ll_i = il_old_row TO this.RowCount()
//		this.SelectRow(ll_i,true)
//	NEXT
//ElseIf keyDown(KeyHome!) and keyDown(KeyShift!) Then
//	FOR ll_i = il_old_row TO 1 STEP -1
//		this.SelectRow(ll_i,true)
//	NEXT
//ElseIf keyDown(KeyUpArrow!) and keyDown(KeyShift!) Then	 
//	this.SelectRow(This.GetRow() - 1,true)
//ElseIf keyDown(KeyDownArrow!) and keyDown(KeyShift!) Then	
//	this.SelectRow(This.GetRow() + 1,true)
//ElseIf keyDown(KeyUpArrow!)then
//	this.SelectRow(0,false)
//	this.SelectRow(This.GetRow() - 1, true)
//ElseIf keyDown(KeyDownArrow!)then
//	this.SelectRow(0,false)
//	this.SelectRow(This.GetRow() + 1, true)
//End If

end event

event dw_1::clicked;dw=this
//validaciones de las teclas

//If keyDown(keyControl!) Then  
//	If IsSelected(row) Then
//		this.SelectRow(row,false)
//	Else
//		this.SelectRow(row,true)
//	End if
//ElseIf keyDown(KeyShift!) Then
//	FOR ll_i = il_old_row TO row
//		this.SelectRow(ll_i,true)
//	NEXT
//Else
If keyDown(KeyLeftButton!) Then
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
//wf_valida_menu()

end event

event dw_1::doubleclicked;cb_aceptar.Postevent("clicked")
end event

type st_ayuda from w_fa_padre`st_ayuda within w_tz_co_selec_modelo_print
end type

type cb_aceptar from commandbutton within w_tz_co_selec_modelo_print
integer x = 1179
integer y = 508
integer width = 265
integer height = 72
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

event clicked;//If dw_1.IsSelected(dw_1.GetRow()) = TRUE Then
//	//cargar estructura con los documentos
//	str_tz_doctos.largo_doc = dw_1.GetItemNumber(dw_1.GetRow(),"primod_largo_doc") 
//	str_tz_doctos.ancho_doc = dw_1.GetItemNumber(dw_1.GetRow(),"primod_ancho_doc")
//	str_tz_doctos.aceptar = true
//	Parent.triggerevent("Close")
//Else
//	mensaje("Atención ","No hay registro seleccionado, selecciónelo ...","")
//	Return
//End If
//
wf_aceptar()
end event

type st_1 from statictext within w_tz_co_selec_modelo_print
integer x = 1170
integer y = 500
integer width = 279
integer height = 84
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

type cb_cancelar from commandbutton within w_tz_co_selec_modelo_print
integer x = 1472
integer y = 508
integer width = 265
integer height = 72
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;str_tz_doctos.aceptar = false
Parent.triggerevent("Close")

end event

type st_2 from statictext within w_tz_co_selec_modelo_print
integer x = 1463
integer y = 500
integer width = 279
integer height = 84
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

type sle_nom_ventana from singlelineedit within w_tz_co_selec_modelo_print
integer x = 46
integer y = 516
integer width = 727
integer height = 64
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean border = false
boolean autohscroll = false
end type

