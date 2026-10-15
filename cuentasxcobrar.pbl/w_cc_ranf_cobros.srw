//objectcomments Ventana de Rango de fecha para los informes de cobro (Mod hg)
forward
global type w_cc_ranf_cobros from w_cc_padre_rango_fecha
end type
type cbx_1 from checkbox within w_cc_ranf_cobros
end type
type dw_2 from datawindow within w_cc_ranf_cobros
end type
type st_3 from statictext within w_cc_ranf_cobros
end type
type cbx_vendedor from checkbox within w_cc_ranf_cobros
end type
type calendario from picture within w_cc_ranf_cobros
end type
type calendario2 from picture within w_cc_ranf_cobros
end type
type uo_1 from u_ddcalen within w_cc_ranf_cobros
end type
type uo_2 from u_ddcalen within w_cc_ranf_cobros
end type
type dw_3 from datawindow within w_cc_ranf_cobros
end type
type cbx_todas from checkbox within w_cc_ranf_cobros
end type
type st_4 from statictext within w_cc_ranf_cobros
end type
type dw_4 from datawindow within w_cc_ranf_cobros
end type
type ddlb_tipo from dropdownlistbox within w_cc_ranf_cobros
end type
type st_valor from statictext within w_cc_ranf_cobros
end type
type cbx_balance_prueba from checkbox within w_cc_ranf_cobros
end type
type cbx_movimiento from checkbox within w_cc_ranf_cobros
end type
type cbx_pais from checkbox within w_cc_ranf_cobros
end type
type cbx_resumido from checkbox within w_cc_ranf_cobros
end type
end forward

global type w_cc_ranf_cobros from w_cc_padre_rango_fecha
integer width = 2171
integer height = 1144
string title = "Informe de Transacciones de Clientes"
long backcolor = 12639424
string icon = "AppIcon!"
windowanimationstyle openanimation = toproll!
windowanimationstyle closeanimation = topslide!
cbx_1 cbx_1
dw_2 dw_2
st_3 st_3
cbx_vendedor cbx_vendedor
calendario calendario
calendario2 calendario2
uo_1 uo_1
uo_2 uo_2
dw_3 dw_3
cbx_todas cbx_todas
st_4 st_4
dw_4 dw_4
ddlb_tipo ddlb_tipo
st_valor st_valor
cbx_balance_prueba cbx_balance_prueba
cbx_movimiento cbx_movimiento
cbx_pais cbx_pais
cbx_resumido cbx_resumido
end type
global w_cc_ranf_cobros w_cc_ranf_cobros

type variables
DatawindowChild idch_notercero, idwc_clientes
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
			if cbx_todas.checked then
				lstr_rangfech.tipo_reporte = 1 //Todas las transacciones
			else
				lstr_rangfech.tipo_reporte = 0 //Por transaccion
			end if
			lstr_rangfech.cliente = dw_3.GetItemNumber(1,"cliente")			
			ls_transaccion = dw_2.getitemstring(1,'transaccion')
			lstr_rangfech.movimiento = ls_transaccion
			if cbx_vendedor.checked then lstr_rangfech.opcion = 'V'			
			if cbx_balance_prueba.checked then lstr_rangfech.opcion = 'B'
			if cbx_pais.checked then 
				lstr_rangfech.opcion = 'P'
				if cbx_resumido.checked then
					lstr_rangfech.resumido = 1
				end if
			end if
			if cbx_movimiento.checked then 
				lstr_rangfech.opcion = 'M'
				lstr_rangfech.tipo_reporte = 1
			end if
			
			lstr_rangfech.tipo_cliesp = dw_4.getitemnumber(1,'tipo_cliente')
			
			lstr_rangfech.opcion_reporte =ddlb_tipo.text
	
			OpenSheetWithParm(w_reporte_transacciones_cc,lstr_rangfech,this,1,Layered!)
			
			if not isvalid(m_cc_principal) then changemenu(m_cc_principal)
			m_cc_principal.m_edicin.enabled = false
			this.settoolbar(1,False)
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

on w_cc_ranf_cobros.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.dw_2=create dw_2
this.st_3=create st_3
this.cbx_vendedor=create cbx_vendedor
this.calendario=create calendario
this.calendario2=create calendario2
this.uo_1=create uo_1
this.uo_2=create uo_2
this.dw_3=create dw_3
this.cbx_todas=create cbx_todas
this.st_4=create st_4
this.dw_4=create dw_4
this.ddlb_tipo=create ddlb_tipo
this.st_valor=create st_valor
this.cbx_balance_prueba=create cbx_balance_prueba
this.cbx_movimiento=create cbx_movimiento
this.cbx_pais=create cbx_pais
this.cbx_resumido=create cbx_resumido
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.cbx_vendedor
this.Control[iCurrent+5]=this.calendario
this.Control[iCurrent+6]=this.calendario2
this.Control[iCurrent+7]=this.uo_1
this.Control[iCurrent+8]=this.uo_2
this.Control[iCurrent+9]=this.dw_3
this.Control[iCurrent+10]=this.cbx_todas
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.dw_4
this.Control[iCurrent+13]=this.ddlb_tipo
this.Control[iCurrent+14]=this.st_valor
this.Control[iCurrent+15]=this.cbx_balance_prueba
this.Control[iCurrent+16]=this.cbx_movimiento
this.Control[iCurrent+17]=this.cbx_pais
this.Control[iCurrent+18]=this.cbx_resumido
end on

on w_cc_ranf_cobros.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.dw_2)
destroy(this.st_3)
destroy(this.cbx_vendedor)
destroy(this.calendario)
destroy(this.calendario2)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.dw_3)
destroy(this.cbx_todas)
destroy(this.st_4)
destroy(this.dw_4)
destroy(this.ddlb_tipo)
destroy(this.st_valor)
destroy(this.cbx_balance_prueba)
destroy(this.cbx_movimiento)
destroy(this.cbx_pais)
destroy(this.cbx_resumido)
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


//li_mes = w_cc_fondo.str_para.mes
//li_ano = w_cc_fondo.str_para.ano

em_1.text = string(01)+ "/" +string(li_mes)+ "/" +string(li_ano - 1)
em_2.text =  string(gf_last_day(li_mes,li_ano))+ "/" +string(li_mes)+ "/" +string(li_ano)



end event

event ue_post_open;call super::ue_post_open;datawindowchild ldwc_trans, ldwc_tipo
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_2.getchild('transaccion', ldwc_trans)
ldwc_trans.settransobject(sqlca)
ldwc_trans.retrieve(str.g_financiero, str.empresa)
dw_2.insertrow(1)
dw_2.setitem(1,'transaccion','RC')

dw_4.getchild('tipo_cliente',ldwc_tipo)
ldwc_tipo.settransobject(sqlca)
ldwc_tipo.retrieve(str.g_financiero, str.empresa)
ldwc_tipo.insertrow(1)
ldwc_tipo.setitem(1,'tpcli_codigo',99)
ldwc_tipo.setitem(1,'tpcli_descripcion','VER TODOS')
dw_4.insertrow(1)

dw_3.getchild('cliente', idwc_clientes)
idwc_clientes.settransobject(sqlca)
idwc_clientes.retrieve(str.g_financiero, str.empresa)
dw_3.insertrow(1)

dw_3.setfocus()

this.SetRedraw ( True )
end event

type st_nom_ventana from w_cc_padre_rango_fecha`st_nom_ventana within w_cc_ranf_cobros
boolean visible = false
integer x = 23
integer y = 528
end type

type dw_1 from w_cc_padre_rango_fecha`dw_1 within w_cc_ranf_cobros
integer x = 87
integer y = 624
integer width = 517
integer height = 88
integer taborder = 0
end type

type p_1 from w_cc_padre_rango_fecha`p_1 within w_cc_ranf_cobros
boolean visible = false
integer y = 52
integer width = 73
integer height = 48
end type

type em_2 from w_cc_padre_rango_fecha`em_2 within w_cc_ranf_cobros
integer x = 1234
integer y = 124
integer width = 448
alignment alignment = center!
end type

type st_2 from w_cc_padre_rango_fecha`st_2 within w_cc_ranf_cobros
integer x = 965
integer width = 256
long textcolor = 15793151
long backcolor = 8421376
end type

type em_1 from w_cc_padre_rango_fecha`em_1 within w_cc_ranf_cobros
integer x = 357
integer y = 124
integer width = 462
alignment alignment = center!
end type

event modified;//override

end event

type st_1 from w_cc_padre_rango_fecha`st_1 within w_cc_ranf_cobros
integer x = 87
integer width = 261
integer height = 80
long textcolor = 15793151
long backcolor = 8421376
string text = " Desde : "
alignment alignment = right!
end type

type gb_1 from w_cc_padre_rango_fecha`gb_1 within w_cc_ranf_cobros
integer x = 27
integer y = 12
integer width = 2089
integer height = 1020
long backcolor = 12639424
string text = "Rango fechas"
end type

type st_7 from w_cc_padre_rango_fecha`st_7 within w_cc_ranf_cobros
integer x = 878
integer y = 688
end type

type cb_1 from w_cc_padre_rango_fecha`cb_1 within w_cc_ranf_cobros
integer x = 887
integer y = 696
string pointer = "HyperLink!"
boolean default = false
end type

type pb_1 from w_cc_padre_rango_fecha`pb_1 within w_cc_ranf_cobros
integer x = 37
integer y = 380
end type

type pb_2 from w_cc_padre_rango_fecha`pb_2 within w_cc_ranf_cobros
integer x = 133
integer y = 380
end type

type cbx_1 from checkbox within w_cc_ranf_cobros
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

type dw_2 from datawindow within w_cc_ranf_cobros
integer x = 677
integer y = 252
integer width = 1097
integer height = 92
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_transaccion"
boolean border = false
boolean livescroll = true
end type

event itemchanged;accepttext()
if data <> 'RC' then
	cbx_vendedor.checked = false
	cbx_vendedor.visible = false
	ddlb_tipo.visible = false
	st_valor.visible = false	
else
	cbx_vendedor.visible = true	
	ddlb_tipo.visible = true
	st_valor.visible = true
end if
end event

type st_3 from statictext within w_cc_ranf_cobros
integer x = 165
integer y = 256
integer width = 485
integer height = 84
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

type cbx_vendedor from checkbox within w_cc_ranf_cobros
integer x = 119
integer y = 644
integer width = 498
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Por Vendedor"
end type

event clicked;if this.checked then
	cbx_balance_prueba.checked = false
	cbx_pais.checked = false
	cbx_movimiento.checked = false
	dw_2.enabled = false
	cbx_todas.checked = false	
	dw_2.Modify("transaccion.Background.Color='10790052'")	
else
	dw_2.enabled = true	
	dw_2.Modify("transaccion.Background.Color='16777215'")
end if
end event

type calendario from picture within w_cc_ranf_cobros
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
//parent.height = 1144
	
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

type calendario2 from picture within w_cc_ranf_cobros
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
//parent.height = 1144
	
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

type uo_1 from u_ddcalen within w_cc_ranf_cobros
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
	//parent.height = 1000
end if


end event

on uo_1.destroy
call u_ddcalen::destroy
end on

type uo_2 from u_ddcalen within w_cc_ranf_cobros
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
	//parent.height = 1000
end if


end event

on uo_2.destroy
call u_ddcalen::destroy
end on

type dw_3 from datawindow within w_cc_ranf_cobros
integer x = 137
integer y = 368
integer width = 1691
integer height = 104
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_clientes"
boolean border = false
boolean livescroll = true
end type

event itemchanged;this.accepttext()
string ls_columna, ls_cuenta, ls_transito, ls_descrip, ls_cargado_a
integer li_encontro
long ll_tercero, ll_pos
ls_columna = this.getcolumnname()

choose case ls_columna
	case 'cuenta'
		ls_cuenta = this.getitemstring(this.getrow(),'cuenta')
		li_encontro = idwc_clientes.find("clie_ref_anterior = '"+ls_cuenta+"'",1,idwc_clientes.rowcount())
		if li_encontro > 0 then
			ll_tercero = idwc_clientes.getitemNumber(li_encontro,'terc_tercero')
			this.setitem(this.getrow(),'cliente',ll_tercero)
			cb_1.triggerevent('clicked')
		else
			gf_mensaje('','Cuenta no Existe, Verifique !!!',1,1,'E')
			this.setitem(this.getrow(),'cuenta','')
			this.setitem(this.getrow(),'cliente',0)
			return 2
		end if
	case 'cliente'
		ll_tercero = this.getitemNumber(this.getrow(),'cliente')
		ls_cuenta = idwc_clientes.getitemstring(idwc_clientes.getrow(),'clie_ref_anterior')
		this.setitem(this.getrow(),'cuenta',ls_cuenta)	
		cb_1.triggerevent('clicked')
end choose
end event

type cbx_todas from checkbox within w_cc_ranf_cobros
integer x = 1801
integer y = 256
integer width = 274
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long textcolor = 8388608
long backcolor = 12639424
string text = "Todas"
end type

event clicked;if this.checked then
	dw_2.Modify("transaccion.Background.Color='10790052'")
	dw_2.enabled = false
else
	dw_2.Modify("transaccion.Background.Color='16777215'")
	dw_2.enabled = true	
end if

end event

type st_4 from statictext within w_cc_ranf_cobros
integer x = 165
integer y = 500
integer width = 485
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 8421376
string text = "Tipo de Cliente: "
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_4 from datawindow within w_cc_ranf_cobros
integer x = 686
integer y = 508
integer width = 731
integer height = 72
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_tipo_clientes"
boolean border = false
boolean livescroll = true
end type

type ddlb_tipo from dropdownlistbox within w_cc_ranf_cobros
integer x = 1440
integer y = 508
integer width = 649
integer height = 408
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"EFECTIVO","CHEQUE","TARJETA","TRANSFERENCIA","TODOS"}
borderstyle borderstyle = stylelowered!
end type

type st_valor from statictext within w_cc_ranf_cobros
integer x = 1541
integer y = 456
integer width = 402
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "Valor en ?"
alignment alignment = center!
boolean focusrectangle = false
end type

type cbx_balance_prueba from checkbox within w_cc_ranf_cobros
integer x = 119
integer y = 740
integer width = 571
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Balance de Prueba"
end type

event clicked;if this.checked then
	cbx_movimiento.checked = false
	cbx_todas.checked = true
	cbx_pais.checked = false
	dw_2.enabled = false
	dw_2.Modify("transaccion.Background.Color='10790052'")	
else
	cbx_todas.checked = false	
	dw_2.enabled = true	
	dw_2.Modify("transaccion.Background.Color='16777215'")
end if
end event

type cbx_movimiento from checkbox within w_cc_ranf_cobros
integer x = 119
integer y = 836
integer width = 594
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Movimiento General"
end type

event clicked;if this.checked then
	cbx_balance_prueba.checked = false
	cbx_pais.checked = false
	cbx_vendedor.checked = false
	cbx_todas.checked = true
	dw_2.enabled = false
	dw_2.Modify("transaccion.Background.Color='10790052'")	
else
	cbx_todas.checked = false	
	dw_2.enabled = true	
	dw_2.Modify("transaccion.Background.Color='16777215'")
end if
end event

type cbx_pais from checkbox within w_cc_ranf_cobros
integer x = 119
integer y = 932
integer width = 512
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Por Pais"
end type

event clicked;if this.checked then
	cbx_balance_prueba.checked = false
	cbx_vendedor.checked = false
	cbx_movimiento.checked = false
	//dw_2.enabled = false
	cbx_todas.checked = false	
	dw_2.Modify("transaccion.Background.Color='10790052'")	
	cbx_resumido.visible = true
else
	//dw_2.enabled = true	
	dw_2.Modify("transaccion.Background.Color='16777215'")
	cbx_resumido.visible = false
end if
end event

type cbx_resumido from checkbox within w_cc_ranf_cobros
boolean visible = false
integer x = 649
integer y = 932
integer width = 498
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Resumido"
end type

