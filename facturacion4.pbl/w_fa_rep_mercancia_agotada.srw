//objectcomments Ventana donde se establece la Fecha hasta la cual se desea obtener el informe de los pedidos pendientes de facturar
forward
global type w_fa_rep_mercancia_agotada from w_fa_rep_rango_fecha
end type
type ddlb_fuente from dropdownlistbox within w_fa_rep_mercancia_agotada
end type
end forward

global type w_fa_rep_mercancia_agotada from w_fa_rep_rango_fecha
integer width = 2075
integer height = 864
string title = "Informe de Mercancia Agotada"
string menuname = "m_hs"
boolean controlmenu = false
boolean minbox = false
ddlb_fuente ddlb_fuente
end type
global w_fa_rep_mercancia_agotada w_fa_rep_mercancia_agotada

type variables
str_rangofecha lstr_rangfech

end variables

event open;call super::open;String ls_dato
date ldt_fecha_ser
//If IsValid(m_fa_principal) then 
//	m_fa_principal.m_edicin.enabled = false
//	this.settoolbar(1,False)
//else
//	this.changemenu(m_fa_principal)
//	m_fa_principal.m_edicin.enabled = false
//	this.settoolbar(1,False)
//end if

ldt_fecha_ser = date(gf_fecha_serv())
em_2.text = string(ldt_fecha_ser)
em_1.text = em_2.text 

st_nom_inf.text = "Informe de Mercancia Agotada"

end event

event ue_vistaprevia;call super::ue_vistaprevia;//lstr_rangfech.opcion
If isDate(em_1.text) then
	If isDate(em_2.text) then
		If date(em_1.text) <= date(em_2.text) then
	
		  lstr_rangfech.fecha1 = date(em_1.text)
		  lstr_rangfech.fecha2 = date(em_2.text)

	
		  OpenSheetWithParm(w_fa_rep_imp_mercancia_agotada,lstr_rangfech,this,1,Layered!)
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

on w_fa_rep_mercancia_agotada.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.ddlb_fuente=create ddlb_fuente
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_fuente
end on

on w_fa_rep_mercancia_agotada.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddlb_fuente)
end on

event ue_post_open;//Override
/* dw corresponde al datawindows que se desea imprimir, por tanto
   si desea asignarle otro nombre haga lo siguiente 
	dw = otro_nombre */
dw = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()
ddlb_fuente.text ='Factura'
end event

event closequery;call super::closequery;constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)

This.SetRedraw(false)
end event

event close;Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
end event

type st_nom_ventana from w_fa_rep_rango_fecha`st_nom_ventana within w_fa_rep_mercancia_agotada
boolean visible = false
integer x = 50
integer y = 620
integer width = 1038
end type

type st_ayuda from w_fa_rep_rango_fecha`st_ayuda within w_fa_rep_mercancia_agotada
end type

type dw_1 from w_fa_rep_rango_fecha`dw_1 within w_fa_rep_mercancia_agotada
integer y = 32
integer taborder = 60
end type

type gb_1 from w_fa_rep_rango_fecha`gb_1 within w_fa_rep_mercancia_agotada
integer x = 50
integer y = 276
integer width = 1559
integer height = 196
integer taborder = 70
string text = "  Rango de Fecha"
end type

type st_1 from w_fa_rep_rango_fecha`st_1 within w_fa_rep_mercancia_agotada
integer x = 91
integer y = 364
integer width = 197
fontcharset fontcharset = ansi!
string text = "Desde :  "
end type

type em_1 from w_fa_rep_rango_fecha`em_1 within w_fa_rep_mercancia_agotada
integer x = 297
integer y = 356
integer width = 384
end type

type st_2 from w_fa_rep_rango_fecha`st_2 within w_fa_rep_mercancia_agotada
integer x = 873
integer y = 364
integer width = 165
boolean enabled = true
end type

type em_2 from w_fa_rep_rango_fecha`em_2 within w_fa_rep_mercancia_agotada
integer x = 1047
integer y = 356
end type

type st_nom_inf from w_fa_rep_rango_fecha`st_nom_inf within w_fa_rep_mercancia_agotada
integer x = 288
integer y = 28
integer width = 1659
end type

type cb_1 from w_fa_rep_rango_fecha`cb_1 within w_fa_rep_mercancia_agotada
integer x = 1632
integer y = 348
end type

event cb_1::clicked;call super::clicked;//dispara vista previa
end event

type p_1 from w_fa_rep_rango_fecha`p_1 within w_fa_rep_mercancia_agotada
integer y = 24
end type

type pb_1 from w_fa_rep_rango_fecha`pb_1 within w_fa_rep_mercancia_agotada
integer x = 690
integer y = 352
integer taborder = 50
end type

type pb_2 from w_fa_rep_rango_fecha`pb_2 within w_fa_rep_mercancia_agotada
integer x = 1435
integer y = 352
integer taborder = 40
end type

type st_7 from w_fa_rep_rango_fecha`st_7 within w_fa_rep_mercancia_agotada
end type

type ddlb_fuente from dropdownlistbox within w_fa_rep_mercancia_agotada
boolean visible = false
integer x = 1106
integer y = 736
integer width = 448
integer height = 300
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Factura","Pedido","Ambos"}
borderstyle borderstyle = stylelowered!
end type

event modified;//choose case ddlb_fuente.text 
//	case 'Factura'
//		lstr_rangfech.opcion = ddlb_fuente.text
//	case 'Pedido'
//		lstr_rangfech.opcion = ddlb_fuente.text
//end choose

lstr_rangfech.opcion = ddlb_fuente.text
end event

event getfocus;ddlb_fuente.text = 'Factura'
lstr_rangfech.opcion = ddlb_fuente.text

end event

