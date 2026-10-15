forward
global type w_cc_selec_formatos from w_fa_padre
end type
type gb_1 from groupbox within w_cc_selec_formatos
end type
type gb_2 from groupbox within w_cc_selec_formatos
end type
type cb_aceptar from commandbutton within w_cc_selec_formatos
end type
type cb_cancelar from commandbutton within w_cc_selec_formatos
end type
type st_1 from statictext within w_cc_selec_formatos
end type
type st_2 from statictext within w_cc_selec_formatos
end type
end forward

global type w_cc_selec_formatos from w_fa_padre
integer width = 2624
integer height = 804
string title = "(CC) Mantenimiento de Formatos "
boolean minbox = false
windowtype windowtype = response!
toolbaralignment toolbaralignment = floating!
gb_1 gb_1
gb_2 gb_2
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
st_1 st_1
st_2 st_2
end type
global w_cc_selec_formatos w_cc_selec_formatos

type variables
datawindowchild dwc_formato
Long il_old_row
str_cc_formatos str_formato


end variables

forward prototypes
public subroutine wf_insertar ()
public subroutine wf_aceptar ()
end prototypes

public subroutine wf_insertar ();dw_1.scrolltorow(dw_1.insertrow(0))
dw_1.setcolumn(1)
dw_1.setItem(dw_1.getrow(),"forma_tipo_formato",str_formato.tipo_formato)
dw_1.SetItem(dw_1.getRow(),"forma_formato",str_formato.cod_formato)

end subroutine

public subroutine wf_aceptar ();//cargar estructura con el formato y datawindow
Boolean lb_selecciono
str_formato.aceptar = false

If dw_1.Rowcount() = 1 Then
	dw_1.SetFocus()
	str_formato.cod_formato   = dw_1.GetItemString(1,"forma_formato") 
	str_formato.datawindow    = dw_1.GetItemString(1,"forma_datawindow")
	str_formato.aceptar = true
	this.triggerevent("Close")
Else
	If dw_1.IsSelected(dw_1.GetRow()) = TRUE Then
		str_formato.cod_formato   = dw_1.GetItemString(dw_1.GetRow(),"forma_formato") 
		str_formato.datawindow    = dw_1.GetItemString(dw_1.GetRow(),"forma_datawindow") 
		str_formato.aceptar = true
		this.triggerevent("Close")
	Else
		mensaje("Atención ","No hay registro seleccionado, selecciónelo ...","")
	End If
End If

end subroutine

on w_cc_selec_formatos.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.gb_2=create gb_2
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.cb_aceptar
this.Control[iCurrent+4]=this.cb_cancelar
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
end on

on w_cc_selec_formatos.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
destroy(this.st_1)
destroy(this.st_2)
end on

event ue_post_open;//Override
Integer li_hay,li_max
String	ls_forma
is_nombre = This.ClassName()


gf_win_used_by_user(is_nombre, true)

st_nom_ventana.text = is_nombre

dw_1.settransObject(SQLCA)

ls_forma = '(CC) Seleccion de Formatos de'

CHOOSE CASE str_formato.tipo_formato
	CASE 'REC'
		ls_forma +=' Recibos'
	CASE 'NDR'
		ls_forma +=' Notas de Débito'
	CASE 'NCR'
		ls_forma +=' Notas de Crédito'
	CASE 'FAC'
		ls_forma +=' Facturas'
	CASE 'EST'
		ls_forma +=' Estado de Cuenta'
		
END CHOOSE

This.Title = ls_forma
gf_dg_set_tab_zero(dw)

if dw_1.retrieve(str.g_financiero, str.empresa,str_formato.tipo_formato,str_formato.cod_formato) < 1 then
	mensaje("Atención ","No se ha configurado el formato para este documento, por favor contacte al personal de soperte técnico o su programador.. gracias","")
	return
Else
	If dw_1.rowcount() = 1 and (str_formato.reporte_o_para ='REP' &
	   or str_formato.reporte_o_para ='CAP') Then
		dw_1.setcolumn(1)
		dw_1.setfocus()
		dw_1.enabled = true
		wf_aceptar()
		close(This)
		Return
	End if
end if

dw_1.setcolumn(1)
dw_1.setfocus()
dw_1.ScrollTorow(1)
dw_1.SelectRow(1, true)
dw_1.enabled = true

end event

event open;sqlca.autocommit = true
gf_center_win(This)
gf_acelerador()
dw = dw_1

This.Icon = str.icono

//--------
This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)

sqlca.AutoCommit = true

//m_fa_principal.disable()

str_formato = Message.PowerObjectParm
this.postevent("ue_post_open")

end event

event resize;//Override
long ll_dw_ancho,ll_dw_alto
st_nom_ventana.y = newheight - (st_nom_ventana.height + 10)

ll_dw_ancho = newwidth - 150
ll_dw_alto  = newheight - 200

dw_1.Resize(ll_dw_ancho, ll_dw_alto)
cb_aceptar.y = newheight - (cb_aceptar.height + 5)
cb_aceptar.x = dw_1.x + dw_1.Width - (cb_aceptar.Width + 10 )
st_1.y = cb_aceptar.y -10
st_1.x = dw_1.x + dw_1.Width - (st_1.Width )

cb_cancelar.y = newheight - (cb_cancelar.height + 5)
cb_cancelar.x = dw_1.x + dw_1.Width - (cb_cancelar.Width + cb_aceptar.Width +50)
st_2.y = cb_cancelar.y -10
st_2.x = dw_1.x + dw_1.Width - (st_2.Width + st_1.Width + 30 )

gb_1.x = dw_1.x - 40
gb_1.y = dw_1.y - 60
gb_1.Width  = ll_dw_ancho + 80
gb_1.Height = ll_dw_alto  + 80
dw_1.enabled = false


end event

event close;if isvalid(this) then
	CloseWithReturn(this,str_formato)
End If

end event

event closequery;//
end event

event activate;call super::activate;this.x = 500
this.y = 700
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_cc_selec_formatos
integer x = 64
integer y = 504
integer height = 72
end type

type dw_1 from w_fa_padre`dw_1 within w_cc_selec_formatos
event ue_post_change ( )
event ue_post_clicked ( )
event ue_set_column ( )
event ue_adicionar ( )
event ue_valida_existen ( )
event key pbm_keydown
integer x = 50
integer y = 56
integer width = 2478
integer height = 416
integer taborder = 0
string dataobject = "dw_ca_cc_selec_formatos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_1::ue_set_column;//Devuelve el cursor para que se edite un codigo valido
dw.setcolumn("forma_formato")
			
end event

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
//
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

end event

event dw_1::editchanged;
//wf_valida_menu()
//m_cc_principal.m_archivo.m_guardar.enabled = True

end event

event dw_1::ue_down;call super::ue_down;Integer li_column,li_row

li_row = getrow()

If  li_row = dw.rowcount() Then
	If key = Keyenter! or keydown(KeyTab!) Then
		
		li_column = dw_1.getcolumn() + 1
		
		if li_column > 3 then
			li_column = 1
			If li_row = dw.rowcount() Then
				//Parent.triggerevent("ue_adicionar")
			Else
				dw_1.ScrollToRow(li_row+1)
			End If
		end if
		dw_1.setcolumn(li_column)
		dw_1.setfocus()	

	end if
Else	
//or key = KeyTab!
	If key = Keyenter!   Then
		li_column = dw_1.getcolumn() + 1
		if li_column > 3 then
			li_row = dw_1.getrow() + 1

			li_column = 1
			dw_1.ScrollToRow(li_row )
		End If
		dw_1.setcolumn(li_column)
		dw_1.setfocus()	
		return 2
	End If
end if

end event

event dw_1::getfocus;dw=this
end event

event dw_1::doubleclicked;If str_formato.reporte_o_para ='PARA' then Return
cb_aceptar.Postevent("clicked")
end event

type st_ayuda from w_fa_padre`st_ayuda within w_cc_selec_formatos
end type

type gb_1 from groupbox within w_cc_selec_formatos
integer x = 50
integer y = 460
integer width = 809
integer height = 128
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_cc_selec_formatos
boolean visible = false
integer x = 41
integer width = 1778
integer height = 948
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type cb_aceptar from commandbutton within w_cc_selec_formatos
integer x = 1975
integer y = 492
integer width = 265
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;wf_aceptar()
end event

type cb_cancelar from commandbutton within w_cc_selec_formatos
integer x = 2263
integer y = 492
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
string text = "Cancelar"
end type

event clicked;str_formato.aceptar = false
Parent.triggerevent("Close")

end event

type st_1 from statictext within w_cc_selec_formatos
integer x = 1966
integer y = 484
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

type st_2 from statictext within w_cc_selec_formatos
integer x = 2254
integer y = 484
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

