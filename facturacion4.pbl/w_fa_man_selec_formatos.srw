//objectcomments  
forward
global type w_fa_man_selec_formatos from w_fa_padre
end type
type gb_2 from groupbox within w_fa_man_selec_formatos
end type
type gb_1 from groupbox within w_fa_man_selec_formatos
end type
type cb_aceptar from commandbutton within w_fa_man_selec_formatos
end type
type cb_cancelar from commandbutton within w_fa_man_selec_formatos
end type
type st_1 from statictext within w_fa_man_selec_formatos
end type
type st_2 from statictext within w_fa_man_selec_formatos
end type
end forward

global type w_fa_man_selec_formatos from w_fa_padre
integer width = 2661
integer height = 924
string title = " Mantenimiento de Formatos "
string menuname = "m_hs"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
long backcolor = 79741120
toolbaralignment toolbaralignment = floating!
gb_2 gb_2
gb_1 gb_1
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
st_1 st_1
st_2 st_2
end type
global w_fa_man_selec_formatos w_fa_man_selec_formatos

type variables
datawindowchild dwc_formato
Long il_old_row
str_fa_carg_ped str_pedi


end variables

forward prototypes
public subroutine wf_insertar ()
public subroutine wf_aceptar ()
end prototypes

public subroutine wf_insertar ();dw_1.scrolltorow(dw_1.insertrow(0))
dw_1.setcolumn(1)
dw_1.setItem(dw_1.getrow(),"forma_tipo_formato",str_pedi.tipo_formato)
dw_1.SetItem(dw_1.getRow(),"forma_formato",str_pedi.cod_formato)

end subroutine

public subroutine wf_aceptar ();//cargar estructura con el formato y datawindow
Boolean lb_selecciono
integer li_pos , li_fila, li_variable

If dw_1.Rowcount() = 1 Then
	dw_1.SetFocus()
	str_pedi.cod_formato   = dw_1.GetItemString(1,"forma_formato") 
	str_pedi.datawindow    = dw_1.GetItemString(1,"forma_datawindow")
	lb_selecciono = True
	this.hide()
Else
	If dw_1.IsSelected(dw_1.GetRow()) = TRUE Then
		li_fila = dw_1.GetRow()
		str_pedi.cod_formato   = dw_1.GetItemString(li_fila,"forma_formato") 
		str_pedi.datawindow    = dw_1.GetItemString(li_fila,"forma_datawindow") 
		lb_selecciono = True
	Else
		mensaje("Atención ","No hay registro seleccionado, selecciónelo ...","")
		lb_selecciono = False
		Return
	End If
End If


If lb_selecciono Then
	CHOOSE CASE str_pedi.tipo_formato
//		CASE 'PIK'	//Picking List
//			OpenSheetWithParm(w_fa_rep_imp_picking_list, str_pedi, str.frame, 9, Layered!)	
//		CASE 'PAK'	//Packing List Gerencial
//		   OpenSheetWithParm(w_fa_rep_imp_picking_geren, str_pedi, str.frame,9,Layered!)
		CASE 'LEM'	// Lista de Empaques			
			//Scrip que asigna el datawindow de listas de empaques de facturas
			li_pos = pos(str_pedi.datawindow,"_pedi_")
		   str_pedi.datawindow2	= left(str_pedi.datawindow,li_pos)+"fact_"+mid(str_pedi.datawindow,li_pos + 6)

//			If w_fa_fondo.str_para.lista_emp_especial = 1 then
//				OpenSheetWithParm(w_fa_man_packing_list_x,str_pedi, str.frame,9, Original!)
//			else
//				if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 then
//					OpenSheetWithParm(w_fa_man_packing_list_ac,str_pedi, str.frame,9, Layered!)
//				else
					OpenSheetWithParm(w_fa_man_packing_list,str_pedi, str.frame,9, Layered!)
//				end if
//			end if
			
//		CASE 'LEE'	
//			//Scrip que asigna el datawindow de listas de empaques especiales 
//			li_pos = pos(str_pedi.datawindow,"_pedi_")
//		   str_pedi.datawindow2	= left(str_pedi.datawindow,li_pos)+"fact_"+mid(str_pedi.datawindow,li_pos + 6)
//			str_pedi.datawindow2	=	trim(str_pedi.datawindow2)
		
//			If str_pedi.vienede = 'FA' then
//				str_pedi.datawindow	=	str_pedi.datawindow2
//			end if
			
//		   OpenSheetWithParm(w_fa_rep_imp_lista_empaque_especial, str_pedi, str.frame,9,Original!) 			
			
//		CASE 'PED'	// Pedidos 
//			/* Modificada por HGN EL 23/03/01*/
//			If str_pedi.reporte_o_para ='CAPPESO' then
//				OpenSheetWithParm(w_fa_man_pedido_cb,str_pedi,str.frame, 9,Original! )
//				if isvalid(w_fa_man_pedido_cb) then
//					w_fa_man_pedido_cb.Dynamic wf_asigna_estructura_ped(str_pedi)
//				end if
//			else
//				OpenSheetWithParm(w_fa_man_pedido,str_pedi,str.frame, 9,Original! )
//				if isvalid(w_fa_man_pedido) then
//					w_fa_man_pedido.Dynamic wf_asigna_estructura(str_pedi)
//				end if
//			end if
		
//		CASE 'FAC'	// Factura
//			w_fa_fondo.str_para.dw_imp1 = str_pedi.datawindow
//			if isvalid(w_fa_man_factura) then
//				w_fa_man_factura.Dynamic wf_asigna_estructura(str_pedi)
//			end if			
//		CASE 'DEV'	// Devoluciones
//			/* Modificado por HGN 30/01/2002  */			
//			If w_fa_fondo.str_para.utiliza_decimales = 1 then
//				OpenSheetWithParm(w_fa_man_devolucion_cb,str_pedi, str.frame,9, Original!)
//			else
//				OpenSheetWithParm(w_fa_man_devolucion,str_pedi, str.frame,9, Original!)
//			end If
			
//		CASE 'PRO'	// Proformas
//		/* Modificado por HGN 23/03/01  */			
//			If str_pedi.reporte_o_para ='CAPPESO' then
//				OpenSheetWithParm(w_fa_man_proformas_cb,str_pedi,str.frame, 9,Original! )
//			else
//				OpenSheetWithParm(w_fa_man_proformas,str_pedi,str.frame, 9,Original! )
//				if isvalid(w_fa_man_proformas) then
//					w_fa_man_proformas.Dynamic wf_asigna_estructura(str_pedi)
//				end if
//			end if
			
//		CASE 'TRA'
//			OpenSheetWithParm(w_fa_rep_facturas_resumidas, str_pedi, str.frame,9,Original!)
	END CHOOSE
	close(this)
end If
return

end subroutine

on w_fa_man_selec_formatos.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.gb_2=create gb_2
this.gb_1=create gb_1
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.cb_aceptar
this.Control[iCurrent+4]=this.cb_cancelar
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
end on

on w_fa_man_selec_formatos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
destroy(this.st_1)
destroy(this.st_2)
end on

event ue_pre_aceptar;this.postevent("ue_aceptar")
yield()
end event

event ue_post_open;//Override
Integer li_hay,li_max
String	ls_forma
is_nombre = This.ClassName()
this.y = 600

gf_win_used_by_user(is_nombre, true)

st_nom_ventana.text = is_nombre

dw_1.settransObject(SQLCA)
//	str_pedi.reporte_o_para ='CAPPESO'
ls_forma = '(FA) Mantenimiento de Formatos de'
If str_pedi.reporte_o_para ='REP' Then ls_forma ='(FA) Selección de Formatos de Reporte'
If str_pedi.reporte_o_para ='CAP' or str_pedi.reporte_o_para ='CAPPESO' Then ls_forma ='(FA) Selección de Formatos de Reporte'

CHOOSE CASE str_pedi.tipo_formato
	CASE 'PAK'
		ls_forma +=' Packing'
	CASE 'PIK'
		ls_forma +=' Picking List'
	CASE 'LEM'
		ls_forma +=' Lista de Empaque'
	CASE 'LEE'	
		ls_forma +=' Lista de Empaque Especial (Cliente)'		
	CASE 'PRO'
		ls_forma +=' Proformas'
	CASE 'PEDPESO'
		ls_forma +=' Proformas tipo Peso'
	CASE 'PED'
		ls_forma +=' Pedidos'
	CASE 'PEDPESO'
		ls_forma +=' Pedidos tipo Peso'
	CASE 'FAC'
		ls_forma +=' Factura'
	CASE 'DEV'
		ls_forma +=' Devolución'
	CASE 'TRA'
		ls_forma +=' Factura tipo Tráfico'
END CHOOSE

This.Title = ls_forma

CHOOSE CASE str_pedi.reporte_o_para
	CASE 'REP','CAP','CAPPESO'
//		gf_fa_set_tab_zero(dw)
//		gf_fa_hide_item()
	CASE 'PARA'
		cb_aceptar.visible = false
		cb_aceptar.enabled = false
		st_1.visible=false
		st_1.enabled = false
		cb_cancelar.visible = false
		cb_cancelar.enabled = false
		st_2.visible=false
		st_2.enabled = false
END CHOOSE

if dw_1.retrieve(str_pedi.tipo_formato,str_pedi.cod_formato) < 1 then
	If str_pedi.reporte_o_para ='PARA' Then
		this.triggerevent("ue_adicionar")
	else
		mensaje("Atención","No se ha configurado el formato de "+ls_forma+' , por favor contacte al soporte técnico o al programador que lo atiende',"")
		close(This)
		return
	end If
Else
	If dw_1.rowcount() = 1 and (str_pedi.reporte_o_para ='REP' &	
	   or str_pedi.reporte_o_para ='CAP' or str_pedi.reporte_o_para ='CAPPESO') Then
		dw_1.setcolumn(1)
		dw_1.setfocus()
		dw_1.enabled = true
		wf_aceptar()
		close(This)
		Return
	End if
end if

dw_1.ScrollTorow(1)
dw_1.SelectRow(1, true)
dw_1.enabled = true
dw_1.setcolumn(1)
dw_1.setfocus()

end event

event open;call super::open;dw_1.x = 75
dw_1.y = 75
//centrar_w()
//m_fa_principal.m_edicin.m_busqueda.Visible = True
//m_fa_principal.m_edicin.m_busqueda.ToolBarItemVisible = True


str_pedi = Message.PowerObjectParm

end event

event ue_adicionar;integer	li_sec_pais
long 		ll_rows
Boolean	lb_existe
dwItemStatus ls_status

// Detecta si la fila del dw es nueva
lb_existe = False
For ll_rows = 1 to dw_1.rowcount()
	
	ls_status = dw_1.getitemStatus(ll_rows,"forma_formato",primary!)

	if ls_status = dataModified! or ls_status = NewModified! then
		lb_existe = True
	End If
Next

If lb_existe = True Then
	mensaje("Atención ","Debe Salvar antes de agregar otro Ok..!! ","")
	Return
End If

dw_1.scrolltorow(dw_1.insertrow(0))
dw_1.SetItem(dw_1.getRow(),"forma_tipo_formato",str_pedi.tipo_formato)
dw_1.SetItem(dw_1.getRow(),"forma_formato",str_pedi.cod_formato)

dw_1.setcolumn(1)

end event

event ue_aceptar;// Eliminia lineas en blanco
integer recorrido,li_linea
long ll_update
datawindow ldw_2
li_linea=0

FOR recorrido = 1 TO dw_1.rowcount()
	if len(trim(dw_1.getItemString(recorrido,"forma_tipo_formato"))) >0 Then
		li_linea = li_linea + 1
	else
		dw_1.deleterow(recorrido)
		recorrido = recorrido - 1
	end if	
NEXT

If dw_1.Rowcount() < 1 Then
	this.triggerevent("ue_adicionar")
	mensaje("Atención ",'No hay nada que salvar',"")
	Return
End If

ll_update=dw_1.update()

if ll_update = 1  then
	commit using sqlca;
	dwc_formato.retrieve(str_pedi.tipo_formato)
else
	rollback using sqlca;
	messagebox("Atención","¡Error al Actualizar !")
end if
//if not isvalid(m_fa_principal) then
//	changemenu(m_fa_principal)
//end if

m_fa_principal.m_archivo.m_guardar.enabled = false
end event

event resize;//Override
long ll_dw_ancho,ll_dw_alto
//st_nom_ventana.y = newheight - (st_nom_ventana.height + 10)
//
//ll_dw_ancho = newwidth - 150
//ll_dw_alto  = newheight - 200
//
//dw_1.Resize(ll_dw_ancho, ll_dw_alto)
//cb_aceptar.y = newheight - (cb_aceptar.height + 5)
//cb_aceptar.x = dw_1.x + dw_1.Width - (cb_aceptar.Width + 10 )
//st_1.y = cb_aceptar.y -10
//st_1.x = dw_1.x + dw_1.Width - (st_1.Width )
//
//cb_cancelar.y = newheight - (cb_cancelar.height + 5)
//cb_cancelar.x = dw_1.x + dw_1.Width - (cb_cancelar.Width + cb_aceptar.Width +50)
//st_2.y = cb_cancelar.y -10
//st_2.x = dw_1.x + dw_1.Width - (st_2.Width + st_1.Width + 30 )
//
//gb_1.x = dw_1.x - 40
//gb_1.y = dw_1.y - 60
//gb_1.Width  = ll_dw_ancho + 80
//gb_1.Height = ll_dw_alto  + 80
//dw_1.enabled = false


end event

event close;close(This)

end event

event ue_insertar;// Override
this.postevent("ue_adicionar")

end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_man_selec_formatos
boolean visible = false
integer x = 59
integer y = 620
integer width = 1303
integer height = 72
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_man_selec_formatos
event ue_post_change ( )
event ue_post_clicked ( )
event ue_set_column ( )
event ue_adicionar ( )
event ue_valida_existen ( )
event key pbm_keydown
integer x = 37
integer y = 44
integer width = 2514
integer height = 476
integer taborder = 0
string dataobject = "dw_ca_fa_selec_formatos"
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

event dw_1::clicked;//override
dw=this
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
//messagebox('', dw_1.GetItemString(row,"forma_datawindow") )
end event

event dw_1::editchanged;
//wf_valida_menu()
m_fa_principal.m_archivo.m_guardar.enabled = True

end event

event dw_1::ue_down;call super::ue_down;Integer li_column,li_row

li_row = getrow()

If  li_row = dw.rowcount() Then
	If key = Keyenter! or keydown(KeyTab!) Then
		
		li_column = dw_1.getcolumn() + 1
		
		if li_column > 3 then
			li_column = 1
			If li_row = dw.rowcount() and str_pedi.reporte_o_para ='PARA' then
				Parent.triggerevent("ue_adicionar")
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

event dw_1::doubleclicked;If str_pedi.reporte_o_para ='PARA' then Return
cb_aceptar.Postevent("clicked")
end event

type st_ayuda from w_fa_padre`st_ayuda within w_fa_man_selec_formatos
end type

type gb_2 from groupbox within w_fa_man_selec_formatos
integer x = 14
integer width = 2587
integer height = 564
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within w_fa_man_selec_formatos
boolean visible = false
integer x = 46
integer y = 572
integer width = 1349
integer height = 128
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type cb_aceptar from commandbutton within w_fa_man_selec_formatos
integer x = 1952
integer y = 592
integer width = 265
integer height = 108
integer taborder = 10
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

type cb_cancelar from commandbutton within w_fa_man_selec_formatos
integer x = 2240
integer y = 592
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

event clicked;Parent.triggerevent("Close")

end event

type st_1 from statictext within w_fa_man_selec_formatos
integer x = 1943
integer y = 584
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

type st_2 from statictext within w_fa_man_selec_formatos
integer x = 2231
integer y = 584
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

