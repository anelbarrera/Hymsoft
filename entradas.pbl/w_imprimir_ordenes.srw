//objectcomments Consulta de Facturas
forward
global type w_imprimir_ordenes from w_fa_padre_reportes
end type
type dw_2 from datawindow within w_imprimir_ordenes
end type
type st_1 from statictext within w_imprimir_ordenes
end type
type cb_1 from commandbutton within w_imprimir_ordenes
end type
type dw_3 from uos_in_datawindow_utility within w_imprimir_ordenes
end type
type gb_4 from gb_1 within w_imprimir_ordenes
end type
type em_ann from editmask within w_imprimir_ordenes
end type
type st_2 from statictext within w_imprimir_ordenes
end type
type st_5 from statictext within w_imprimir_ordenes
end type
type dw_6 from datawindow within w_imprimir_ordenes
end type
end forward

global type w_imprimir_ordenes from w_fa_padre_reportes
integer x = 5
integer y = 20
integer width = 3758
integer height = 2556
string title = "Impresion de Ordenes de Compra"
event ue_buscar ( )
dw_2 dw_2
st_1 st_1
cb_1 cb_1
dw_3 dw_3
gb_4 gb_4
em_ann em_ann
st_2 st_2
st_5 st_5
dw_6 dw_6
end type
global w_imprimir_ordenes w_imprimir_ordenes

type variables
string  is_tipo,is_pedido
integer ii_ann, ii_child_row

datawindowchild idw_child
end variables

forward prototypes
public subroutine wf_fecha ()
public subroutine wf_nofecha ()
public subroutine wf_insertar_cargos (long al_filas)
public function string wf_verificar (string ls_original)
public function string wf_armar_sql ()
public subroutine wf_control_de_totales (long al_rowcount)
end prototypes

public subroutine wf_fecha ();//dw_2.visible = false
//em_1.visible = True
//em_1.text = string(today())
//em_2.visible = True
//em_2.text = string(today())
//pb_1.visible = True
//st_2.visible = True
//st_3.visible = True
//em_1.setfocus()
//
end subroutine

public subroutine wf_nofecha ();//dw_2.visible = true
//em_1.visible = false
//em_2.visible = false
//pb_1.visible = false
//st_2.visible = false
//st_3.visible = false
//dw_2.setfocus()
//dw_2.SetColumn("Texto")
//
end subroutine

public subroutine wf_insertar_cargos (long al_filas);
end subroutine

public function string wf_verificar (string ls_original);//Se verifican las opciones de parámetros y se filtra
string ls_where
  
  if w_fa_fondo.str_para.mostrar <> 0 then  //mostrar un Año específico

	CHOOSE CASE w_fa_fondo.str_para.desde	//Si es desde el año en adelante o el año exclusivo.
		CASE 0

		 ls_where = ls_original + " where &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+" ) and &
					 (fatdiari.fact_ann = "+string(w_fa_fondo.str_para.mostrar)+" ) AND &
 					 ( fatdiari.fact_no_pedido not like '%NC%' )"	
		CASE 1
		 ls_where = ls_original + " where  &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+" ) and &
					 (fatdiari.fact_ann >= "+string(w_fa_fondo.str_para.mostrar)+" ) AND &
 					 ( fatdiari.fact_no_pedido not like '%NC%' )"		
	END CHOOSE			
	
  else
		 ls_where = ls_original + " where  &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+" ) AND &
 					 ( fatdiari.fact_no_pedido not like '%NC%' )"	
  end if
return(ls_where)
end function

public function string wf_armar_sql ();// Función que arma el Sql de el DataWindow, y dependiendo de donde se llama, factura o consultas
// Filtra segun parámetros iniciales o no
string ls_where, ls_original

ls_original = idw_child.GetsqlSelect()

ls_where = wf_verificar(ls_original)

return(ls_where)
end function

public subroutine wf_control_de_totales (long al_rowcount);
end subroutine

on w_imprimir_ordenes.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_3=create dw_3
this.gb_4=create gb_4
this.em_ann=create em_ann
this.st_2=create st_2
this.st_5=create st_5
this.dw_6=create dw_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.gb_4
this.Control[iCurrent+6]=this.em_ann
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.dw_6
end on

on w_imprimir_ordenes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.gb_4)
destroy(this.em_ann)
destroy(this.st_2)
destroy(this.st_5)
destroy(this.dw_6)
end on

event ue_post_open;// Override

string ls_vienede, ls_where
long	 ll_recup



dw_1.settransobject(sqlca)
dw = dw_3 
dw_3.settransobject(sqlca)

em_ann.text = string(year(date(gf_fecha_serv())))
 
dw_6.settransobject(sqlca)
dw_6.InsertRow(0)
dw_6.setfocus()

end event

event resize;//Override No borrar no tocar
long ll_dw_ancho,ll_dw_alto
ll_dw_ancho = newwidth - 30
ll_dw_alto  = newheight - 245

dw_3.Resize(ll_dw_ancho - 40, ll_dw_alto - 255)
gb_4.Resize(dw_3.width+70, dw_3.height+70)
gb_1.width = gb_4.width
st_nom_ventana.y = newheight - (st_nom_ventana.height + 10)

end event

event key;//Override
end event

event open;call super::open;//this.width = str.frame.WorkSpaceWidth() - 35
//this.height= str.frame.WorkSpaceHeight() - 210
this.y = 0
this.x = 805
//dw_5.visible = false
//cbx_1.checked = true
end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_imprimir_ordenes
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_imprimir_ordenes
boolean visible = false
integer x = 41
integer y = 1752
integer width = 919
integer height = 64
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_imprimir_ordenes
event ue_down pbm_dwnkey
event ue_entercol ( )
boolean visible = false
integer x = 64
integer y = 164
integer width = 73
integer height = 48
integer taborder = 130
boolean enabled = false
string dataobject = "dw_encabezado_lista_empaque"
boolean border = false
boolean livescroll = false
end type

event dw_1::ue_down;// Si el Usuario Dio Enter

if key = Keyenter! Then
	This.Postevent("ue_entercol")
	return(2)
End If

end event

event dw_1::ue_entercol;String	ls_ped, ls_retorna, ls_tipo_fac
integer	li_pormayor, li_an

ls_ped = GetitemString(This.Getrow() ,"fatdiari_fact_no_pedido")		//No de pedido
ls_tipo_fac = GetitemString(This.Getrow() ,"fatdiari_fact_tipo")		//No de pedido
li_an = Getitemnumber(This.Getrow(),"fatdiari_fact_ann") //Por mayor o menor

ls_retorna = ls_ped+"="+ls_tipo_fac+"_"+string(li_an)	//Retorna el valor concatenado del pedido+"="+pormayor

CloseWithReturn(parent,ls_retorna)

end event

event dw_1::doubleclicked;call super::doubleclicked;this.triggerevent("ue_entercol")

end event

event dw_1::ue_microayuda;//OVERRIDE
// Evento que muestra una pequeña Ayuda dependiendo en que columna se encuentre el mouse

Integer li_pos, li_x, li_y
String ls_objeto, ls_col

ls_objeto = This.GetObjectAtPointer()
li_pos = pos  (ls_objeto,"~t")
ls_col = left (ls_objeto, li_pos - 1)


li_x	 = str.frame.GetActiveSheet ().PointerX () //- 900
li_y	 = str.frame.GetActiveSheet ().PointerY () //- 200

// Dependiendo de la Columna el Mensaje de Ayuda varía
//CHOOSE CASE right(ls_col,2)
//	CASE '_t'
//		messagebox("!","Invisible")
//		If st_ayuda.Visible Then Return
//		st_ayuda.Move (li_x, li_y)
//		st_ayuda.Text 	= "Haga click para ordenar por la Columna de " + this.describe(ls_col+".text")
//		st_ayuda.Width 	= Len (st_ayuda.Text) * 28
//		st_ayuda.Visible = TRUE	
//	CASE ELSE
//	st_ayuda.Visible = FALSE
//END CHOOSE

end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;string	ls_tipo, ls_pedido
integer	li_anio

if this.rowcount() = 0 then return
if currentrow = 0 then return

st_1.text = 'Fila '+string(currentrow)+' de '+string(this.rowcount())

this.selectrow(0,false)
this.selectrow(currentrow,true)
if dw_3.retrieve(str.g_financiero,str.empresa,ls_pedido,li_anio) = 0 then return

end event

event dw_1::clicked;// Script que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
// en la misma columna.

string	ls_objeto
integer	li_pos

if this.rowcount() = 0 then
	st_1.text = 'Fila 0 de 0'
	return
end if
	
if row = 0 then
	st_1.text = 'Fila 0 de '+string(this.rowcount())
	return
end if

st_1.text = 'Fila '+string(row)+' de '+string(this.rowcount())

ls_objeto = This.GetObjectAtPointer()

li_pos = Pos(ls_objeto, "~t")
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

type gb_1 from w_fa_padre_reportes`gb_1 within w_imprimir_ordenes
integer x = 0
integer y = 0
integer width = 3579
integer height = 200
integer taborder = 0
end type

type dw_2 from datawindow within w_imprimir_ordenes
event editchanged pbm_dwnchanging
boolean visible = false
integer x = 2382
integer y = 1496
integer width = 119
integer height = 68
integer taborder = 110
boolean bringtotop = true
string dataobject = "dw_texto_cab_det"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_imprimir_ordenes
boolean visible = false
integer x = 2693
integer y = 1744
integer width = 530
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fila 0 de 0"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_imprimir_ordenes
integer x = 2267
integer y = 56
integer width = 402
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recuperar"
end type

event clicked;string	ls_pedido,ls_tipo ,ls_lista_empaque
long		ll_ann

	ll_ann = 	  long(em_ann.text)
	ls_pedido	= dw_6.getitemstring(1,'pedido')

   is_pedido = ls_pedido
	ii_ann = ll_ann
	
	dw_3.object.datawindow.print.preview = 'yes'		

		if dw_3.retrieve(str.g_financiero,str.empresa,ls_pedido,ll_ann) = 0 then
			messagebox("Atención","No se recupero la Orden de Compra")
			dw_3.reset()
		end if


end event

type dw_3 from uos_in_datawindow_utility within w_imprimir_ordenes
integer x = 18
integer y = 260
integer width = 3570
integer height = 2004
integer taborder = 30
string dataobject = "dw_impresion_orden"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event rowfocuschanged;call super::rowfocuschanged;if this.rowcount() = 0 then return
if currentrow = 0 then return

st_1.text = 'Fila '+string(currentrow)+' de '+string(this.rowcount())

this.selectrow(0,false)
this.selectrow(currentrow,true)

end event

event clicked;call super::clicked;if this.rowcount() = 0 then
	st_1.text = 'Fila 0 de 0'
	return
end if
	
if row = 0 then
	st_1.text = 'Fila 0 de '+string(this.rowcount())
	return
end if

st_1.text = 'Fila '+string(row)+' de '+string(this.rowcount())

end event

event doubleclicked;call super::doubleclicked;string         ls_pointer
datetime       ldt_fecha1
window		   lw_child
str_rangofecha	str_rangofecha_opcion
//str_fa_bus_var str_busqueda

//If pos(upper(str.nombre_empresa),'ELECTROVISION') > 0 Then 
//if w_fa_fondo.str_aplica_links.habilita_links = 1	then
//	ls_pointer = dw_3.GetObjectAtPointer()
//	if pos(ls_pointer,'facd_codigo_item') > 0 then 
//		str_rangofecha_opcion.opcion = 'Kardex'
//		str_rangofecha_opcion.tipo_informe = '(IN) Movimientos/Costos/Precios de Productos (Kardex) '
//		str_rangofecha_opcion.orden = dw_3.getitemstring(dw_3.getrow(),'facd_codigo_item')
//		if w_fa_fondo.str_aplica_links.inventario_activa_in = 'A' then
//			OpenSheetWithParm(lw_child,str_rangofecha_opcion,"w_fa_movi_prod_kardex",str.frame,11,Original!)
//		end if
//	end if
//end if
//
//	dw_3.Object.dmov_secuencia.Pointer = 'Cross!'

end event

type gb_4 from gb_1 within w_imprimir_ordenes
integer y = 220
integer width = 3616
integer height = 2072
integer taborder = 140
end type

type em_ann from editmask within w_imprimir_ordenes
integer x = 1970
integer y = 56
integer width = 201
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###0"
end type

type st_2 from statictext within w_imprimir_ordenes
integer x = 1792
integer y = 68
integer width = 178
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Año:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_imprimir_ordenes
integer x = 750
integer y = 68
integer width = 603
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Orden de Compra:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_6 from datawindow within w_imprimir_ordenes
event ue_down pbm_dwnkey
integer x = 1362
integer y = 44
integer width = 402
integer height = 104
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_pedido"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_down;if keydown(keyEnd!) then
	dw_3.setfocus()
elseif keydown(KeyF1!) then
//	parent.triggerevent('ue_buscar')
end if

end event

event itemchanged;string	ls_pedido,ls_tipo ,ls_lista_empaque
long		ll_ann
datawindowchild idw

this.accepttext()

	ls_pedido = dw_6.getItemString(1,'pedido')
	dw_3.reset()
	
	/**/
   is_pedido 	= ls_pedido
	ll_ann = long(em_ann.text)
	
	dw_3.object.datawindow.print.preview = 'yes'		

		if dw_3.retrieve(str.g_financiero,str.empresa,ls_pedido,ll_ann) = 0 then
			messagebox("Atención","Orden de Compra no existe o no tiene detalle")
		end if
end event

