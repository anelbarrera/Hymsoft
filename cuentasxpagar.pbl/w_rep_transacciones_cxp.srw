//objectcomments Ventana de Rango de fecha para los informes de cobro (Mod hg)
forward
global type w_rep_transacciones_cxp from w_cc_padre_rango_fecha
end type
type cbx_1 from checkbox within w_rep_transacciones_cxp
end type
type dw_2 from datawindow within w_rep_transacciones_cxp
end type
type st_3 from statictext within w_rep_transacciones_cxp
end type
type calendario from picture within w_rep_transacciones_cxp
end type
type calendario2 from picture within w_rep_transacciones_cxp
end type
type uo_1 from u_ddcalen within w_rep_transacciones_cxp
end type
type uo_2 from u_ddcalen within w_rep_transacciones_cxp
end type
type cbx_todas from checkbox within w_rep_transacciones_cxp
end type
type cbx_balance from checkbox within w_rep_transacciones_cxp
end type
end forward

global type w_rep_transacciones_cxp from w_cc_padre_rango_fecha
integer width = 2121
integer height = 640
string title = "Informe de Transacciones de Cuentas por Pagar"
long backcolor = 12639424
cbx_1 cbx_1
dw_2 dw_2
st_3 st_3
calendario calendario
calendario2 calendario2
uo_1 uo_1
uo_2 uo_2
cbx_todas cbx_todas
cbx_balance cbx_balance
end type
global w_rep_transacciones_cxp w_rep_transacciones_cxp

type variables
DatawindowChild idch_notercero
end variables

event ue_vistaprevia;String   ls_wherem, ls_transaccion
Long 		ll_filas

str_rangofecha lstr_rangfech

if cbx_1.checked = true then
	lstr_rangfech.tipo_accion = 'S'
else
	lstr_rangfech.tipo_accion = 'N'
end if

If isDate(em_1.text) then
	If isDate(em_2.text) then
		If date(em_1.text) <= date(em_2.text) Then
			lstr_rangfech.fecha1 = date(em_1.text)
			lstr_rangfech.fecha2 = date(em_2.text)
			lstr_rangfech.cliente = idch_notercero.GetItemNumber(idch_notercero.Getrow(),"terc_tercero")			
			ls_transaccion = dw_2.getitemstring(1,'transaccion')
			lstr_rangfech.movimiento = ls_transaccion	
			if cbx_balance.checked then lstr_rangfech.opcion_reporte = 'BALANCE'
			
			if cbx_todas.checked then
				lstr_rangfech.tipo_reporte = 1 //Todas las transacciones
			else
				lstr_rangfech.tipo_reporte = 0 //Por transaccion
			end if			
			OpenSheetWithParm(w_reporte_transacciones_cp,lstr_rangfech,this,1,Layered!)
			
//			if not isvalid(m_cc_principal) then changemenu(m_cc_principal)
//			m_cc_principal.m_edicin.enabled = false
//			this.settoolbar(1,False)
		Else
			gf_Mensaje("Aviso","La fecha DESDE es Invalida, Verifique de que la fecha no es mayor que la fecha HASTA",1,1,'E')
		End If
		
	Else
		gf_Mensaje("Aviso","La fecha HASTA es Invalida, Verifique de que la fecha esta en el formato valido DIA/MES/AÑO",1,1,'E')
	End If
Else
	gf_Mensaje("Aviso","La fecha DESDE es Invalida, Verifique de que la fecha esta en el formato valido DIA/MES/AÑO",1,1,'E')
End IF	


end event

on w_rep_transacciones_cxp.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.dw_2=create dw_2
this.st_3=create st_3
this.calendario=create calendario
this.calendario2=create calendario2
this.uo_1=create uo_1
this.uo_2=create uo_2
this.cbx_todas=create cbx_todas
this.cbx_balance=create cbx_balance
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.calendario
this.Control[iCurrent+5]=this.calendario2
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.uo_2
this.Control[iCurrent+8]=this.cbx_todas
this.Control[iCurrent+9]=this.cbx_balance
end on

on w_rep_transacciones_cxp.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.dw_2)
destroy(this.st_3)
destroy(this.calendario)
destroy(this.calendario2)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.cbx_todas)
destroy(this.cbx_balance)
end on

event open;//Override
sqlca.autocommit = true
integer li_mes, li_ano

//gf_center_win(This)
gf_acelerador()
dw = dw_1

This.Icon = str.icono

this.postevent("ue_post_open")


This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)
str.frame.SetRedraw ( True )

//li_mes = w_cc_fondo.str_para.mes
//li_ano = w_cc_fondo.str_para.ano

em_1.text = string(01)+ "/" +string(li_mes)+ "/" +string(li_ano - 1)
em_2.text =  string(gf_last_day(li_mes,li_ano))+ "/" +string(li_mes)+ "/" +string(li_ano)


this.y = 0
this.x = 805

end event

event ue_post_open;call super::ue_post_open;datawindowchild ldwc_trans
dw_2.settransobject(sqlca)
dw_2.getchild('transaccion', ldwc_trans)
ldwc_trans.settransobject(sqlca)
ldwc_trans.retrieve(str.g_financiero, str.empresa)
dw_2.insertrow(1)
dw_2.setitem(1,'transaccion','PA')

end event

event close;Window lw_frame

lw_frame = ParentWindow()

If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_sheet_closed")
 End If
 Close(this)
end event

type st_nom_ventana from w_cc_padre_rango_fecha`st_nom_ventana within w_rep_transacciones_cxp
boolean visible = false
integer x = 23
integer y = 528
end type

type dw_1 from w_cc_padre_rango_fecha`dw_1 within w_rep_transacciones_cxp
integer x = 87
integer y = 624
integer width = 517
integer height = 88
integer taborder = 0
end type

type p_1 from w_cc_padre_rango_fecha`p_1 within w_rep_transacciones_cxp
boolean visible = false
integer y = 52
integer width = 73
integer height = 48
end type

type em_2 from w_cc_padre_rango_fecha`em_2 within w_rep_transacciones_cxp
integer x = 1234
integer y = 124
integer width = 448
alignment alignment = center!
end type

type st_2 from w_cc_padre_rango_fecha`st_2 within w_rep_transacciones_cxp
integer x = 965
integer width = 256
long textcolor = 15793151
long backcolor = 8421376
end type

type em_1 from w_cc_padre_rango_fecha`em_1 within w_rep_transacciones_cxp
integer x = 357
integer y = 124
integer width = 462
alignment alignment = center!
end type

event modified;//override

end event

type st_1 from w_cc_padre_rango_fecha`st_1 within w_rep_transacciones_cxp
integer x = 87
integer width = 261
integer height = 80
long textcolor = 15793151
long backcolor = 8421376
string text = " Desde : "
alignment alignment = right!
end type

type gb_1 from w_cc_padre_rango_fecha`gb_1 within w_rep_transacciones_cxp
integer x = 27
integer y = 12
integer width = 2062
integer height = 508
long backcolor = 12639424
string text = "Rango fechas"
end type

type st_7 from w_cc_padre_rango_fecha`st_7 within w_rep_transacciones_cxp
integer x = 882
integer y = 392
end type

type cb_1 from w_cc_padre_rango_fecha`cb_1 within w_rep_transacciones_cxp
integer x = 891
integer y = 400
string pointer = "HyperLink!"
end type

type pb_1 from w_cc_padre_rango_fecha`pb_1 within w_rep_transacciones_cxp
integer x = 37
integer y = 380
end type

type pb_2 from w_cc_padre_rango_fecha`pb_2 within w_rep_transacciones_cxp
integer x = 133
integer y = 380
end type

type cbx_1 from checkbox within w_rep_transacciones_cxp
boolean visible = false
integer x = 32
integer y = 108
integer width = 87
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Incluir Facturas Contado"
end type

type dw_2 from datawindow within w_rep_transacciones_cxp
integer x = 677
integer y = 252
integer width = 1097
integer height = 92
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_transaccion_cxp"
boolean border = false
boolean livescroll = true
end type

type st_3 from statictext within w_rep_transacciones_cxp
integer x = 174
integer y = 248
integer width = 485
integer height = 88
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 8421376
string text = "Transacción: "
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type calendario from picture within w_rep_transacciones_cxp
integer x = 814
integer y = 124
integer width = 69
integer height = 80
boolean bringtotop = true
string pointer = "HyperLink!"
string picturename = "C:\Sistemas\Hymsoft\Art\ddfec.bmp"
boolean focusrectangle = false
end type

event clicked;date 	ld_date,ld_ini_date, ld_hoy
parent.height = 1144
	
	ld_ini_date=date(em_1.text)
	if year(ld_ini_date) = 1900 then
		ld_ini_date = ld_hoy
	end if
	if uo_1.visible=false then
		uo_1.wf_set_value(ld_ini_date)
		uo_1.visible=true
		uo_1.allow_close=false
		uo_1.inicializar()
		uo_1.TriggerEvent('ue_abrir')
	end if

end event

type calendario2 from picture within w_rep_transacciones_cxp
integer x = 1682
integer y = 124
integer width = 69
integer height = 80
boolean bringtotop = true
string pointer = "HyperLink!"
string picturename = "C:\Sistemas\Hymsoft\Art\ddfec.bmp"
boolean focusrectangle = false
end type

event clicked;date 	ld_date,ld_ini_date, ld_hoy
parent.height = 1144
	
	ld_ini_date=date(em_2.text)
	if year(ld_ini_date) = 1900 then
		ld_ini_date = ld_hoy
	end if
	if uo_2.visible=false then
		uo_2.wf_set_value(ld_ini_date)
		uo_2.visible=true
		uo_2.allow_close=false
		uo_2.inicializar()
		uo_2.TriggerEvent('ue_abrir')
	end if

end event

type uo_1 from u_ddcalen within w_rep_transacciones_cxp
boolean visible = false
integer x = 160
integer y = 208
integer taborder = 60
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;em_1.text = string(uo_1.return_sel_date())

if uo_1.allow_close then
	this.visible=false
	em_1.SetFocus()
	parent.height = 640
end if


end event

on uo_1.destroy
call u_ddcalen::destroy
end on

type uo_2 from u_ddcalen within w_rep_transacciones_cxp
boolean visible = false
integer x = 1029
integer y = 204
integer taborder = 70
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;em_2.text = string(uo_2.return_sel_date())

if uo_2.allow_close then
	this.visible=false
	em_2.SetFocus()
	parent.height = 640
end if


end event

on uo_2.destroy
call u_ddcalen::destroy
end on

type cbx_todas from checkbox within w_rep_transacciones_cxp
integer x = 1797
integer y = 268
integer width = 270
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "Todas"
end type

event clicked;if this.checked then
	dw_2.Modify("transaccion.Background.Color='10790052'")
	dw_2.enabled = false
	dw_2.Modify("transaccion.Color='10790052'")
else
	dw_2.Modify("transaccion.Background.Color='16777215'")
	dw_2.enabled = true	
	dw_2.Modify("transaccion.Color='5701632'")
end if

end event

type cbx_balance from checkbox within w_rep_transacciones_cxp
integer x = 59
integer y = 388
integer width = 603
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Balance de Pruebas"
end type

event clicked;if this.checked then
	cbx_todas.checked = true
	dw_2.enabled = false
	dw_2.Modify("transaccion.Background.Color='10790052'")	
else
	cbx_todas.checked = false	
	dw_2.enabled = true	
	dw_2.Modify("transaccion.Background.Color='16777215'")
end if
end event

