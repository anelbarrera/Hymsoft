forward
global type w_tz_co_busca_factura_cliente from w_fa_padre
end type
type st_4 from statictext within w_tz_co_busca_factura_cliente
end type
type st_2 from statictext within w_tz_co_busca_factura_cliente
end type
type st_5 from statictext within w_tz_co_busca_factura_cliente
end type
type cb_aceptar from commandbutton within w_tz_co_busca_factura_cliente
end type
type dw_4 from datawindow within w_tz_co_busca_factura_cliente
end type
type cb_cancelar from commandbutton within w_tz_co_busca_factura_cliente
end type
end forward

global type w_tz_co_busca_factura_cliente from w_fa_padre
integer x = 1271
integer y = 160
integer width = 2821
integer height = 1164
string title = "Seleccione de Facturas"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
toolbaralignment toolbaralignment = floating!
event ue_help ( )
st_4 st_4
st_2 st_2
st_5 st_5
cb_aceptar cb_aceptar
dw_4 dw_4
cb_cancelar cb_cancelar
end type
global w_tz_co_busca_factura_cliente w_tz_co_busca_factura_cliente

type variables
//Variable para asignar el nombre de la Empresa al DW
string is_unian, is_ultima_tz, is_orden_tz
Integer id_selec, ii_contador,id_fraccion,id_cantidad
window iw_pedidos

//Variable tipo Estructura

str_tz_documentos str_tz_doctos

Datawindowchild dwc_tipo_fact, dwc_pedido, dwc_cliente
end variables

forward prototypes
public subroutine wf_botones ()
public subroutine centrar_w ()
end prototypes

event ue_help;//wf_buscar_factura()

end event

public subroutine wf_botones ();//Deshabilitar botones no necesarios.
   m_fa_padre.m_archivo.m_vistapreliminar.toolbaritemvisible=false
   m_fa_padre.m_edicin.m_sortear.toolbaritemvisible=false
	m_fa_padre.m_edicin.m_filtrar.toolbaritemvisible=false


end subroutine

public subroutine centrar_w ();//
end subroutine

on w_tz_co_busca_factura_cliente.create
int iCurrent
call super::create
this.st_4=create st_4
this.st_2=create st_2
this.st_5=create st_5
this.cb_aceptar=create cb_aceptar
this.dw_4=create dw_4
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_4
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.cb_aceptar
this.Control[iCurrent+5]=this.dw_4
this.Control[iCurrent+6]=this.cb_cancelar
end on

on w_tz_co_busca_factura_cliente.destroy
call super::destroy
destroy(this.st_4)
destroy(this.st_2)
destroy(this.st_5)
destroy(this.cb_aceptar)
destroy(this.dw_4)
destroy(this.cb_cancelar)
end on

event ue_post_open;//Override
this.y = 1
str_tz_doctos = Message.PowerObjectParm
	
dw_1.GetChild('cliente', dwc_cliente)

dwc_cliente.Settransobject(sqlca);

If dwc_cliente.Retrieve(str.g_financiero, str.empresa) < 1 Then  dwc_cliente.Insertrow(0)
dwc_cliente.Scrolltorow(1)

dw_1.insertrow(0)
dw_4.Settransobject(sqlca);
dw_4.insertrow(0)
dw_1.SetFocus()

if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 then
	dw_4.object.fact_ruc_cliente_t.text ='No Cliente'
END IF

end event

event resize;//Override

end event

event key;call super::key;if key = keyF1! then
	this.Postevent("ue_help")
end if
end event

event open;///***************************/
gf_center_win(This)

if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 then
	DW_1.Modify("cliente.DDDW.Name=dw_tz_co_cliente_con_factura_ac")
end if
dw = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()


This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)
str.frame.SetRedraw ( True )
This.Icon = str.icono
this.postevent("ue_post_open")
end event

event close;if isvalid(this) then
	CloseWithReturn(this,str_tz_doctos)
End If

end event

event closequery;//Override
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_tz_co_busca_factura_cliente
boolean visible = false
integer x = 73
integer y = 940
integer width = 969
end type

type dw_1 from w_fa_padre`dw_1 within w_tz_co_busca_factura_cliente
event ue_positemchanged ( string as_columna,  long row,  string data )
integer x = 713
integer y = 40
integer width = 1390
integer height = 96
string dataobject = "dw_tz_co_facturas_cliente"
end type

event dw_1::ue_positemchanged;Long	ll_cliente
String	ls_cliente
datawindowchild ldwc
getchild('cliente',ldwc)
ldwc.settransobject(sqlca)
ll_cliente = ldwc.GetItemNumber(ldwc.getrow(),'terc_tercero')
dw_4.Retrieve(str.g_financiero, str.empresa,ll_cliente) 
dw_4.ScrollTorow(dw_4.rowcount())

end event

event dw_1::ue_escape;//Override
end event

event dw_1::itemchanged;this.post event ue_positemchanged(dw_1.Getcolumnname(),row,data)

//Long	ll_cliente
//String	ls_cliente
//datawindowchild ldwc
//getchild('cliente',ldwc)
//ldwc.settransobject(sqlca)
//ll_cliente = ldwc.GetItemNumber(ldwc.getrow(),'terc_tercero')
//dw_4.Retrieve(str.g_financiero, str.empresa,ll_cliente) 
//
end event

event dw_1::clicked;call super::clicked;//str_pedi.cliente = dwc_cliente.GetItemNumber(dwc_cliente.GetRow(),"terc_tercero")
//dw_4.Retrieve(str.g_financiero, str.empresa,w_tz_fondo.str_param.anio,str_pedi.cliente) 

end event

type st_ayuda from w_fa_padre`st_ayuda within w_tz_co_busca_factura_cliente
end type

type st_4 from statictext within w_tz_co_busca_factura_cliente
integer x = 302
integer y = 44
integer width = 389
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "CLIENTE:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_tz_co_busca_factura_cliente
integer x = 430
integer y = 1536
integer width = 882
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = " dw_3 (dw_ca_fa_det_sal_facturas)"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_tz_co_busca_factura_cliente
integer x = 1966
integer y = 1532
integer width = 882
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "dw_2 ( dw_ca_fa_facturas_arancel)"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_aceptar from commandbutton within w_tz_co_busca_factura_cliente
integer x = 2062
integer y = 944
integer width = 274
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;Long ll_filas,ll_row
String	ls_filtro
If dw_4.rowcount() = 0 then Return
str_tz_doctos.pedido = ''
str_tz_doctos.documento = ''
ll_row =0
For ll_filas = 1 to dw_4.rowcount()
	If dw_4.GetItemString(ll_filas,"fact_incluir") ='S' then
		ll_row ++
		str_tz_doctos.dw_object.InsertRow(0)
		
		str_tz_doctos.dw_object.SetItem(ll_row,'fact_no_pedido',dw_4.GetItemString(ll_filas,"fact_no_pedido"))
		str_tz_doctos.dw_object.SetItem(ll_row,'fact_no_factura',dw_4.GetItemString(ll_filas,"fact_no_factura"))
		str_tz_doctos.dw_object.SetItem(ll_row,'fact_ann',dw_4.GetItemNumber(ll_filas,"fact_ann"))
		str_tz_doctos.dw_object.SetItem(ll_row,'fact_tipo',dw_4.GetItemString(ll_filas,"fact_tipo"))

		str_tz_doctos.pedido    +=' '+ dw_4.GetItemString(ll_filas,"fact_no_pedido") 
		str_tz_doctos.documento +=' '+ dw_4.GetItemString(ll_filas,"fact_no_factura")
		str_tz_doctos.anio = dw_4.GetItemNumber(ll_filas,"fact_ann")
		str_tz_doctos.tipo = dw_4.GetItemString(ll_filas,"fact_tipo")

	end if
next


If ll_row > 0 then
	ls_filtro = "fact_incluir= 'S'"
	dw_4.SetFilter(ls_filtro)
	dw_4.Filter( )
	str_tz_doctos.viene_de_buscar = 1
	Parent.triggerevent("Close")
else
	mensaje("Atención ","No hay ninguna factura seleccionada, selecciónela para proceder, dé click en el campo incluir a cada factura que desee incluir","")
	dw_4.Reset( )
	Return
end if

end event

type dw_4 from datawindow within w_tz_co_busca_factura_cliente
event ue_microayuda pbm_nchittest
integer x = 69
integer y = 160
integer width = 2734
integer height = 756
integer taborder = 20
string dataobject = "dw_tz_co_facturas_por_cliente"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_microayuda;/*
	Evento que muestra una pequeña Ayuda dependiendo en que columna se encuentre el mouse
*/

Integer li_pos, li_x, li_y
String ls_objeto, ls_col

ls_objeto = This.GetObjectAtPointer()
li_pos = pos  (ls_objeto,"~t")
ls_col = left (ls_objeto, li_pos - 1)


li_x	 = w_tz_co_busca_factura_cliente.PointerX () //- 900
li_y	 = w_tz_co_busca_factura_cliente.PointerY () //- 200

//messagebox("Apunta a :",ls_col)

// Dependiendo de la Columna el Mensaje de Ayuda varía
//CHOOSE CASE right(ls_col,2)
//	CASE '_t'
////		messagebox("!","Invisible")
//		If st_ayuda.Visible Then Return
//		st_ayuda.Move (li_x, li_y)
//		st_ayuda.Text 	= "Haga click para ordenar por la Columna de " + this.describe(ls_col+".text")
//		st_ayuda.Width 	= Len (st_ayuda.Text) * 28
//		st_ayuda.Visible = TRUE	
//	CASE ELSE
//	st_ayuda.Visible = FALSE
//END CHOOSE
//
//Integer li_pos, li_x, li_y,li_largo
//String ls_objeto, ls_col
//
//ls_objeto = This.GetObjectAtPointer()
//li_pos = pos  (ls_objeto,"~t")
//ls_col = left (ls_objeto, li_pos - 1)
//
//li_x	 = str.frame.GetActiveSheet ().PointerX () 
//li_largo = len("Haga click para ordenar por la Columna de " + this.describe(ls_col+".text"))*28
//
//If li_x +li_largo >(li_w_ancho +100) then
//	li_x = (li_w_ancho +100) - li_largo
//end if
//
//li_y	 = str.frame.GetActiveSheet ().PointerY () - 200
//
//// Dependiendo de la Columna el Mensaje de Ayuda varía
//CHOOSE CASE right(ls_col,2)
//	CASE '_t'
//		If st_ayuda.Visible Then Return
//		st_ayuda.Move (li_x, li_y)
//		st_ayuda.Text 	= "Haga click para ordenar por la Columna de " + this.describe(ls_col+".text")
//		st_ayuda.Width 	= Len (st_ayuda.Text) * 28
//		st_ayuda.Visible = TRUE	
//	CASE ELSE
//	st_ayuda.Visible = FALSE
//END CHOOSE
end event

event clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto
integer li_pos 

this.Setredraw(false)

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if right(ls_objeto,2)='_t' then

	ls_objeto = left(ls_objeto,len(ls_objeto)-2)
	
	if ls_objeto = is_ultima_tz or is_ultima_tz = "" then	//Si es la misma columna 
																	// o si es la primera vez
		if is_orden_tz  = "" or is_orden_tz = "D" then
			is_orden_tz = 'A'		
			this.SetSort(ls_objeto+" A")	//Ordena Ascendente
			this.sort()		
		else
			is_orden_tz = 'D'					
			this.SetSort(ls_objeto+" D")	//Ordena Descendente
			this.sort()				
		end if	
		is_ultima_tz = ls_objeto		
	else				
			is_orden_tz = 'A'
			this.SetSort(ls_objeto+" A")
			this.sort()
			is_ultima_tz = ls_objeto
	end if

end if

this.Setredraw(true)
end event

type cb_cancelar from commandbutton within w_tz_co_busca_factura_cliente
integer x = 2395
integer y = 944
integer width = 274
integer height = 92
integer taborder = 30
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

