//objectcomments  
forward
global type w_fa_change_key_pedido from w_fa_padre
end type
type gb_anio from groupbox within w_fa_change_key_pedido
end type
type cb_1 from commandbutton within w_fa_change_key_pedido
end type
type cb_2 from commandbutton within w_fa_change_key_pedido
end type
type cbx_tipo_fac from checkbox within w_fa_change_key_pedido
end type
type cbx_anio from checkbox within w_fa_change_key_pedido
end type
type rb_factura from radiobutton within w_fa_change_key_pedido
end type
type rb_pedido from radiobutton within w_fa_change_key_pedido
end type
type st_1 from statictext within w_fa_change_key_pedido
end type
type sle_anio from singlelineedit within w_fa_change_key_pedido
end type
type dw_2 from datawindow within w_fa_change_key_pedido
end type
type cbx_pedido from checkbox within w_fa_change_key_pedido
end type
type sle_new_no_pedido from singlelineedit within w_fa_change_key_pedido
end type
type st_2 from statictext within w_fa_change_key_pedido
end type
type st_3 from statictext within w_fa_change_key_pedido
end type
type sle_anio_dw from singlelineedit within w_fa_change_key_pedido
end type
type cbx_cuenta from checkbox within w_fa_change_key_pedido
end type
type dw_3 from datawindow within w_fa_change_key_pedido
end type
end forward

global type w_fa_change_key_pedido from w_fa_padre
integer width = 1765
integer height = 904
string title = "(FA) Cambiar el año de un Pedido"
string menuname = "m_hs"
boolean controlmenu = false
boolean maxbox = false
long backcolor = 79741120
event ue_enter pbm_dwndragenter
gb_anio gb_anio
cb_1 cb_1
cb_2 cb_2
cbx_tipo_fac cbx_tipo_fac
cbx_anio cbx_anio
rb_factura rb_factura
rb_pedido rb_pedido
st_1 st_1
sle_anio sle_anio
dw_2 dw_2
cbx_pedido cbx_pedido
sle_new_no_pedido sle_new_no_pedido
st_2 st_2
st_3 st_3
sle_anio_dw sle_anio_dw
cbx_cuenta cbx_cuenta
dw_3 dw_3
end type
global w_fa_change_key_pedido w_fa_change_key_pedido

type variables
// Para el filtro de la unidad
datawindowchild idwc_tipo, dwc_fac_pedi, idwc_cliente
String is_ped_sel, is_fact_sel, is_tipo_repl,is_tipo_sel, is_pedido_repl
Integer ii_ann_sel, ii_ann_repl
end variables

forward prototypes
public subroutine wf_botones ()
public subroutine wf_selec_datawindow ()
end prototypes

public subroutine wf_botones ();//// Deshabilita la opcion de insertar del menu 

//   /*Insertar*/
//	m_fa_padre.m_edicin.m_insertar.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_insertar.visible=false
	
//	/*Filtrar*/
//	m_fa_padre.m_edicin.m_filtrar.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_filtrar.visible=false
	
//	/*Sortear*/
//	m_fa_padre.m_edicin.m_sortear.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_sortear.visible=false
	
//  /*Imprimir*/
//   m_fa_padre.m_archivo.m_imprimir.toolbaritemvisible=false
//	m_fa_padre.m_archivo.m_imprimir.visible=false

	
	
//	/*Eliminar*/
////	m_fa_padre.m_edicin.m_eliminar.toolbaritemvisible=false
////	
	
////	/*Adicionar*/
////	m_fa_padre.m_edicin.m_adicionar.toolbaritemvisible=false
////	
	
////	/*Primer Reg*/
////	m_fa_padre.m_edicin.m_primerregistro.toolbaritemvisible=false
////	
	
////	/*Ultimo Reg*/
////	m_fa_padre.m_edicin.m_ultimoregistro.toolbaritemvisible=false
////	
	
	
////	/*Sig Reg*/
////	m_fa_padre.m_edicin.m_siguienteregistro.toolbaritemvisible=false
////	
	
////	/*Reg Ant*/
////	m_fa_padre.m_edicin.m_registroanterior.toolbaritemvisible=false
////	
	
////	

  


end subroutine

public subroutine wf_selec_datawindow ();integer li_ann
If rb_factura.checked = true then
//	dw_2.DataObject = 'dw_change_factura'
Else
	dw_2.DataObject = 'dw_change_pedido_ped'
End If
li_ann = integer(sle_anio_dw.text)

dw_2.GetChild ("pedi_no_pedido",dwc_fac_pedi)
dw_2.settransobject(sqlca)
dwc_fac_pedi.Settransobject(SQLCA);
dwc_fac_pedi.retrieve(str.g_financiero,str.empresa, li_ann)
dw_2.InsertRow(0)

end subroutine

on w_fa_change_key_pedido.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.gb_anio=create gb_anio
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cbx_tipo_fac=create cbx_tipo_fac
this.cbx_anio=create cbx_anio
this.rb_factura=create rb_factura
this.rb_pedido=create rb_pedido
this.st_1=create st_1
this.sle_anio=create sle_anio
this.dw_2=create dw_2
this.cbx_pedido=create cbx_pedido
this.sle_new_no_pedido=create sle_new_no_pedido
this.st_2=create st_2
this.st_3=create st_3
this.sle_anio_dw=create sle_anio_dw
this.cbx_cuenta=create cbx_cuenta
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_anio
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cbx_tipo_fac
this.Control[iCurrent+5]=this.cbx_anio
this.Control[iCurrent+6]=this.rb_factura
this.Control[iCurrent+7]=this.rb_pedido
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.sle_anio
this.Control[iCurrent+10]=this.dw_2
this.Control[iCurrent+11]=this.cbx_pedido
this.Control[iCurrent+12]=this.sle_new_no_pedido
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.sle_anio_dw
this.Control[iCurrent+16]=this.cbx_cuenta
this.Control[iCurrent+17]=this.dw_3
end on

on w_fa_change_key_pedido.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_anio)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cbx_tipo_fac)
destroy(this.cbx_anio)
destroy(this.rb_factura)
destroy(this.rb_pedido)
destroy(this.st_1)
destroy(this.sle_anio)
destroy(this.dw_2)
destroy(this.cbx_pedido)
destroy(this.sle_new_no_pedido)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.sle_anio_dw)
destroy(this.cbx_cuenta)
destroy(this.dw_3)
end on

event ue_post_open;call super::ue_post_open;//dch_bodega.retrieve(str.g_financiero, str.empresa)

dw_1.settransobject(sqlca)
//DW_1.GetChild ("fact_tipo",idwc_tipo)
//idwc_tipo.Settransobject(SQLCA);
//
//Recupera los tipos de Facturas Activas

//if idwc_tipo.retrieve(str.g_financiero, str.empresa, "FA") = 0 then
//	mensaje("Aviso","Sr. Usuario, Debe definir los tipos de Facturas en Datos Generales","En (DG), Entre en Parámetros / "+&
//			 +"Parámetros Iniciales / Transacciones / Asociar las Sub-transacciones a Facturación.")
//	idwc_tipo.insertrow(0)
//	this.Postevent("close")
//end if

dw_1.InsertRow(0)
dw_1.SetFocus()
is_ped_sel=''
is_fact_sel=''
sle_anio.text = string(year(date(gf_fecha_serv())))
sle_anio_dw.text = string(year(date(gf_fecha_serv())) - 1)
wf_selec_datawindow()

dw_3.GetChild ("cliente",idwc_cliente)
idwc_cliente.Settransobject(SQLCA);
idwc_cliente.retrieve(str.g_financiero, str.empresa)
idwc_cliente.insertrow(1)

dw_3.InsertRow(0)



end event

event show;
wf_botones()

end event

event closequery;constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)

This.SetRedraw(false)
end event

event open;call super::open;//dw_1.enabled = false
dw_3.visible = false
//sle_anio.enabled = false
//sle_anio.visible = false
//sle_new_no_pedido.enabled = false
//sle_new_no_pedido.visible = false
end event

event resize;//Override
end event

event close;//close(This)
Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
 
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_change_key_pedido
boolean visible = false
integer y = 616
integer width = 681
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_change_key_pedido
event ue_filtra_unidad ( )
boolean visible = false
integer x = 599
integer y = 348
integer width = 617
integer height = 84
boolean enabled = false
end type

event dw_1::getfocus;dw = dw_1


end event

event dw_1::rbuttondown;//
end event

event dw_1::itemchanged;call super::itemchanged;is_tipo_repl = data
end event

type st_ayuda from w_fa_padre`st_ayuda within w_fa_change_key_pedido
end type

type gb_anio from groupbox within w_fa_change_key_pedido
integer x = 27
integer width = 1641
integer height = 564
integer taborder = 20
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
end type

type cb_1 from commandbutton within w_fa_change_key_pedido
integer x = 727
integer y = 596
integer width = 265
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;String ls_no_pedido,ls_no_factura, ls_tipo_fac, ls_cuenta, ls_nombre, ls_sqlerrtext
Long ll_cliente
Integer li_anio
Boolean	lb_validado,lb_salvo
lb_validado = true
lb_salvo = false

//If dwc_fac_pedi.GetItemString(dwc_fac_pedi.Getrow(),"fatdiari_fact_estado") ='I' then
//	mensaje("Atención","Esta factura ya fue impresa y por lo tanto no puede ser modificada....!!","")
//	lb_validado = false
//	return
//end if

//If rb_factura.checked = true then
////	is_fact_sel = data
//	If is_fact_sel ='' or IsNull(is_fact_sel) or Long(is_fact_sel) <= 0 Then
//		mensaje("Atención","Debe editar un Número de factura válido","")
//		dw_2.SetColumn(1)
//		dw_2.SetFocus()
//		lb_validado = false
//		Return
//	end If
//Else
////	is_ped_sel = data
//	If is_ped_sel ='' or IsNull(is_ped_sel) Then
//		mensaje("Atención","Debe editar un Número de Pedido válido","")
//		dw_2.SetColumn(1)
//		dw_2.SetFocus()
//		lb_validado = false
//		Return
//	end If
//End If
//
//If cbx_tipo_fac.checked = true then
//	if is_tipo_repl='' or IsNull(is_tipo_repl) then
//		mensaje("Atención ","Debe seleccionar el tipo de factura deseado","")
//		dw_1.SetColumn(1)
//		dw_1.SetFocus()
//		lb_validado = false
//		return
//	end If
//else
//	is_tipo_repl =''
//end If
//If cbx_anio.checked = true then
		
	If trim(sle_anio.text) ='' or IsNull(sle_anio.text) or integer((sle_anio.text)) <= 1990 then
		mensaje("Atención ","Debe Editar el año por el que reemplazará el año del documento","")
		cbx_anio.SetFocus()
		lb_validado = false
		return
	end if
//else
//	sle_anio.text ='0'
//end If
//
ii_ann_repl = integer(sle_anio.text)
//
//If cbx_pedido.checked = true then
//		
//	If trim(sle_new_no_pedido.text) ='' or IsNull(sle_new_no_pedido.text)  then
//		mensaje("Atención ","Debe Editar un nuevo Número de Pedido que sea Válido","")
//		cbx_pedido.SetFocus()
//		lb_validado = false
//		return
//	end if
//else
//	sle_new_no_pedido.text =''
//end If

//is_pedido_repl = sle_new_no_pedido.text
//


If lb_validado = true then
	if gf_mensaje("","Está Seguro de Proceder con el Cambio",2,1,"E") = 2 then return
	if cbx_cuenta.checked then
		ll_cliente = dw_3.getitemnumber(1,'cliente')
			  SELECT dgmterce.terc_identificacion  , terc_descripcion
				 INTO :ls_cuenta  , :ls_nombre
				 FROM dgmterce  
				WHERE dgmterce.terc_tercero = :ll_cliente   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Buscar cuenta '+sqlca.sqlerrtext,1,1,'E')
				return
			end if

		       UPDATE fatpedid  
				 set pedi_cliente = :ll_cliente,
				 	  pedi_ruc_cliente = :ls_cuenta,
					  pedi_a_nombre = :ls_nombre
				WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
						( fatpedid.pedi_empresa = :str.empresa ) AND  					
						( fatpedid.pedi_ann = :ii_ann_sel ) AND  
						( fatpedid.pedi_no_pedido = :is_ped_sel )   ;						
				if sqlca.sqlcode = -1 then
					ls_sqlerrtext = sqlca.sqlerrtext
					rollback;
					lb_salvo=false
					mensaje("Información","Error al Actualizar Cuenta en fatiari ",ls_sqlerrtext)
					return
				end if	
				
				commit;
				
				gf_mensaje('','Actualizacion Exitosa !!!',1,1,'E')
	else
		gf_fa_cambiar_anio_pedido(is_ped_sel, is_fact_sel, is_tipo_sel, ii_ann_sel ,is_tipo_repl, ii_ann_repl,is_pedido_repl,lb_salvo)
		If lb_salvo = true then
			li_anio = integer(sle_anio_dw.text)
			dwc_fac_pedi.retrieve(str.g_financiero,str.empresa, li_anio)
		End If
	end if
else
	mensaje("","Los parámetros requeridos no han sido especificados adecuadamente","")
	return
End If

end event

type cb_2 from commandbutton within w_fa_change_key_pedido
integer x = 1038
integer y = 600
integer width = 265
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;close(parent)
end event

type cbx_tipo_fac from checkbox within w_fa_change_key_pedido
boolean visible = false
integer x = 146
integer y = 340
integer width = 448
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
string text = " Tipo Factura"
end type

event clicked;If cbx_tipo_fac.checked = true then
	dw_1.enabled = true
	dw_1.visible = true
else
	dw_1.enabled = false
	dw_1.visible = false
end If
is_tipo_repl=''
end event

type cbx_anio from checkbox within w_fa_change_key_pedido
boolean visible = false
integer x = 174
integer y = 328
integer width = 215
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
string text = "  Año"
end type

event clicked;If cbx_anio.checked = true then
	sle_anio.enabled = true
	sle_anio.visible = true
else
	sle_anio.enabled = false
	sle_anio.visible = false
end If
sle_anio.text =''
ii_ann_repl =0

end event

type rb_factura from radiobutton within w_fa_change_key_pedido
boolean visible = false
integer x = 142
integer y = 156
integer width = 334
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
string text = "  Factura"
end type

event clicked;is_ped_sel=''
is_fact_sel=''
wf_selec_datawindow()


end event

type rb_pedido from radiobutton within w_fa_change_key_pedido
boolean visible = false
integer x = 165
integer y = 208
integer width = 338
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
string text = "  Pedido"
boolean checked = true
boolean automatic = false
end type

event clicked;//is_ped_sel=''
//is_fact_sel=''
//
//wf_selec_datawindow()
//
end event

type st_1 from statictext within w_fa_change_key_pedido
integer x = 695
integer y = 112
integer width = 389
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
string text = "No. Documento"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_anio from singlelineedit within w_fa_change_key_pedido
integer x = 599
integer y = 320
integer width = 274
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;ii_ann_repl = integer(sle_anio.text)
end event

type dw_2 from datawindow within w_fa_change_key_pedido
integer x = 599
integer y = 208
integer width = 617
integer height = 88
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_change_pedido_ped"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;//If rb_factura.checked = true then
//	is_ped_sel  = dwc_fac_pedi.GetItemString(dwc_fac_pedi.GetRow(),"fact_no_pedido")
//	is_fact_sel = data
//Else
	is_ped_sel = data
	is_fact_sel =dwc_fac_pedi.GetItemString(dwc_fac_pedi.GetRow(),"pedi_no_pedido")
//End If

//is_tipo_sel = dwc_fac_pedi.GetItemString(dwc_fac_pedi.GetRow(),"fact_tipo")
ii_ann_sel  = dwc_fac_pedi.GetItemNumber(dwc_fac_pedi.GetRow(),"pedi_ann")

end event

type cbx_pedido from checkbox within w_fa_change_key_pedido
boolean visible = false
integer x = 142
integer y = 552
integer width = 379
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
string text = "No. Pedido"
boolean righttoleft = true
end type

event clicked;If cbx_pedido.checked = true then
	sle_new_no_pedido.enabled = true
	sle_new_no_pedido.visible = true
else
	sle_new_no_pedido.enabled = false
	sle_new_no_pedido.visible = false
end If
sle_new_no_pedido.text =''
is_pedido_repl =''
end event

type sle_new_no_pedido from singlelineedit within w_fa_change_key_pedido
boolean visible = false
integer x = 603
integer y = 552
integer width = 343
integer height = 72
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;is_pedido_repl = sle_new_no_pedido.text
end event

type st_2 from statictext within w_fa_change_key_pedido
integer x = 411
integer y = 328
integer width = 146
integer height = 56
boolean bringtotop = true
integer textsize = -8
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

type st_3 from statictext within w_fa_change_key_pedido
integer x = 329
integer y = 224
integer width = 238
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pedido:"
boolean focusrectangle = false
end type

type sle_anio_dw from singlelineedit within w_fa_change_key_pedido
integer x = 1230
integer y = 208
integer width = 251
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;integer li_ann
li_ann = integer(sle_anio_dw.text)
dwc_fac_pedi.retrieve(str.g_financiero,str.empresa, li_ann)

end event

type cbx_cuenta from checkbox within w_fa_change_key_pedido
integer x = 123
integer y = 440
integer width = 448
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Cuenta Cliente"
end type

event clicked;if this.checked then
	dw_3.visible = true
else
	dw_3.visible = false
end if
end event

type dw_3 from datawindow within w_fa_change_key_pedido
integer x = 599
integer y = 428
integer width = 891
integer height = 96
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_external_cliente_cc"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

