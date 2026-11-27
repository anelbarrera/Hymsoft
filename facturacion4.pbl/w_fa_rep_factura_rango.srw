//objectcomments  
forward
global type w_fa_rep_factura_rango from w_fa_rep_rango_fecha
end type
type ddlb_fuente from dropdownlistbox within w_fa_rep_factura_rango
end type
type st_3 from statictext within w_fa_rep_factura_rango
end type
type st_4 from statictext within w_fa_rep_factura_rango
end type
type ddlb_1 from dropdownlistbox within w_fa_rep_factura_rango
end type
type cbx_por_tipo from checkbox within w_fa_rep_factura_rango
end type
end forward

global type w_fa_rep_factura_rango from w_fa_rep_rango_fecha
integer width = 2075
integer height = 760
string title = "(FA) Reporte de Facturas en $US Dollars"
string menuname = "m_hs"
boolean controlmenu = false
boolean minbox = false
ddlb_fuente ddlb_fuente
st_3 st_3
st_4 st_4
ddlb_1 ddlb_1
cbx_por_tipo cbx_por_tipo
end type
global w_fa_rep_factura_rango w_fa_rep_factura_rango

type variables
str_rangofecha lstr_rangfech

end variables

event open;call super::open;String ls_dato

IF Trim(Message.StringParm) <> "" THEN
	This.Tag = Trim(Message.StringParm)
END IF
//If IsValid(m_fa_principal) then 
//	m_fa_principal.m_edicin.enabled = false
//	this.settoolbar(1,False)
//else
//	this.changemenu(m_fa_principal)
//	m_fa_principal.m_edicin.enabled = false
//	this.settoolbar(1,False)
//end if
st_nom_inf.text = "Informe de Facturas en $US Dollars "

end event

event ue_vistaprevia;call super::ue_vistaprevia;//lstr_rangfech.opcion
If isDate(em_1.text) then
	If isDate(em_2.text) then
		If date(em_1.text) <= date(em_2.text) then
	
		  lstr_rangfech.fecha1 = date(em_1.text)
		  lstr_rangfech.fecha2 = date(em_2.text)
		  
		  lstr_rangfech.opcion = left(ddlb_1.text,1)
		  if cbx_por_tipo.checked then
			  lstr_rangfech.tipo_reporte = 1 
		  end if
	
		  OpenSheetWithParm(w_fa_rep_valor_facturas,lstr_rangfech,this,1,Layered!)
//		  if not isvalid(m_fa_principal) then
//			this.changemenu(m_fa_principal)
//		  end if
//		  m_fa_principal.m_edicin.enabled = false
		  this.settoolbar(1,False)
		 
	   Else
		  Mensaje("Aviso","El Rango de Fecha es Inválido","Cerciórese de que el Rango de fecha DESDE no sea Mayor que el Rango de fecha HASTA")
	   End If
	
	Else
		Mensaje("Aviso","La fecha HASTA es Inválida","Cerciórese de que la fecha esté en el formato Válido: DIA/MES/AÑO")
	End If
Else
	Mensaje("Aviso","La fecha DESDE es Inválida","Cerciórese de que la fecha esté en el formato Válido: DIA/MES/AÑO")
End IF	


//copiarlo identico solo cambiar la ventana y el menu

end event

on w_fa_rep_factura_rango.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.ddlb_fuente=create ddlb_fuente
this.st_3=create st_3
this.st_4=create st_4
this.ddlb_1=create ddlb_1
this.cbx_por_tipo=create cbx_por_tipo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_fuente
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.ddlb_1
this.Control[iCurrent+5]=this.cbx_por_tipo
end on

on w_fa_rep_factura_rango.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddlb_fuente)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.ddlb_1)
destroy(this.cbx_por_tipo)
end on

event ue_post_open;//Override
/* dw corresponde al datawindows que se desea imprimir, por tanto
   si desea asignarle otro nombre haga lo siguiente 
	dw = otro_nombre */
dw = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()
ddlb_1.text= 'IMPRESAS'
ddlb_fuente.text ='Factura'
end event

event close;Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
end event

event closequery;call super::closequery;constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)

This.SetRedraw(false)
end event

event activate;call super::activate;gnv_seg.of_aplicar_acciones_ventana(w_hs_frame.rbb_1, this.tag)
end event

type st_nom_ventana from w_fa_rep_rango_fecha`st_nom_ventana within w_fa_rep_factura_rango
boolean visible = false
integer y = 532
integer width = 1038
end type

type st_ayuda from w_fa_rep_rango_fecha`st_ayuda within w_fa_rep_factura_rango
end type

type dw_1 from w_fa_rep_rango_fecha`dw_1 within w_fa_rep_factura_rango
integer y = 32
integer taborder = 70
end type

type gb_1 from w_fa_rep_rango_fecha`gb_1 within w_fa_rep_factura_rango
integer x = 50
integer width = 1559
integer height = 196
integer taborder = 80
string text = "  Rango de Fecha "
end type

type st_1 from w_fa_rep_rango_fecha`st_1 within w_fa_rep_factura_rango
integer x = 91
integer y = 332
integer width = 197
fontcharset fontcharset = ansi!
string text = "Desde :  "
end type

type em_1 from w_fa_rep_rango_fecha`em_1 within w_fa_rep_factura_rango
integer x = 297
integer width = 384
end type

type st_2 from w_fa_rep_rango_fecha`st_2 within w_fa_rep_factura_rango
integer x = 873
integer y = 332
integer width = 165
boolean enabled = true
end type

type em_2 from w_fa_rep_rango_fecha`em_2 within w_fa_rep_factura_rango
integer x = 1047
end type

type st_nom_inf from w_fa_rep_rango_fecha`st_nom_inf within w_fa_rep_factura_rango
integer x = 315
integer y = 28
integer width = 1659
integer height = 176
integer textsize = -14
end type

type cb_1 from w_fa_rep_rango_fecha`cb_1 within w_fa_rep_factura_rango
integer x = 1632
integer y = 316
end type

event cb_1::clicked;call super::clicked;//dispara vista previa
end event

type p_1 from w_fa_rep_rango_fecha`p_1 within w_fa_rep_factura_rango
integer y = 24
end type

type pb_1 from w_fa_rep_rango_fecha`pb_1 within w_fa_rep_factura_rango
integer x = 690
integer taborder = 60
end type

type pb_2 from w_fa_rep_rango_fecha`pb_2 within w_fa_rep_factura_rango
integer x = 1435
integer taborder = 40
end type

type st_7 from w_fa_rep_rango_fecha`st_7 within w_fa_rep_factura_rango
end type

type ddlb_fuente from dropdownlistbox within w_fa_rep_factura_rango
boolean visible = false
integer x = 1065
integer y = 504
integer width = 448
integer height = 256
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"Factura","Pedido"}
borderstyle borderstyle = stylelowered!
end type

event modified;choose case ddlb_fuente.text 
	case 'Factura'
		lstr_rangfech.opcion = ddlb_fuente.text
	case 'Pedido'
		lstr_rangfech.opcion = ddlb_fuente.text
end choose

end event

event getfocus;ddlb_fuente.text = 'Factura'
lstr_rangfech.opcion = ddlb_fuente.text

end event

type st_3 from statictext within w_fa_rep_factura_rango
boolean visible = false
integer x = 480
integer y = 512
integer width = 526
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
string text = "Fuente de Búsqueda"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_fa_rep_factura_rango
integer x = 1102
integer y = 452
integer width = 247
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
string text = "Facturas:"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_fa_rep_factura_rango
integer x = 1349
integer y = 448
integer width = 407
integer height = 228
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"ACTIVAS","IMPRESAS"}
borderstyle borderstyle = stylelowered!
end type

type cbx_por_tipo from checkbox within w_fa_rep_factura_rango
integer x = 41
integer y = 448
integer width = 960
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Agrupado por Tipo de Movimiento"
end type

