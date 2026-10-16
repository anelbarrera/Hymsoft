//objectcomments Ventana de Rango de fecha para los informes de cobro (Mod hg)
forward
global type w_ventas_resumen from w_cc_padre_rango_fecha
end type
type cbx_1 from checkbox within w_ventas_resumen
end type
type cbx_diario from checkbox within w_ventas_resumen
end type
type cbx_mensual from checkbox within w_ventas_resumen
end type
type calendario from picture within w_ventas_resumen
end type
type calendario2 from picture within w_ventas_resumen
end type
type uo_1 from u_ddcalen within w_ventas_resumen
end type
type uo_2 from u_ddcalen within w_ventas_resumen
end type
end forward

global type w_ventas_resumen from w_cc_padre_rango_fecha
integer width = 1925
integer height = 656
string title = "Reporte de Tarjetas Visa"
boolean controlmenu = false
long backcolor = 12639424
string icon = "AppIcon!"
windowanimationstyle openanimation = bottomroll!
windowanimationstyle closeanimation = bottomslide!
cbx_1 cbx_1
cbx_diario cbx_diario
cbx_mensual cbx_mensual
calendario calendario
calendario2 calendario2
uo_1 uo_1
uo_2 uo_2
end type
global w_ventas_resumen w_ventas_resumen

type variables
DatawindowChild idch_notercero
integer ii_dia, ii_mes, ii_ann
end variables

event ue_vistaprevia;String   ls_wherem, ls_transaccion
Long 		ll_filas

str_rangofecha lstr_rangfech

If isDate(em_1.text) then
	If isDate(em_2.text) then
		If date(em_1.text) <= date(em_2.text) Then
			lstr_rangfech.fecha1 = date(em_1.text)
			lstr_rangfech.fecha2 = date(em_2.text)
			lstr_rangfech.cliente = idch_notercero.GetItemNumber(idch_notercero.Getrow(),"terc_tercero")			
			lstr_rangfech.movimiento = ls_transaccion
			
			OpenSheetWithParm(w_reporte_visas_imp,lstr_rangfech,this,1,Layered!)
			
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

on w_ventas_resumen.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.cbx_diario=create cbx_diario
this.cbx_mensual=create cbx_mensual
this.calendario=create calendario
this.calendario2=create calendario2
this.uo_1=create uo_1
this.uo_2=create uo_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.cbx_diario
this.Control[iCurrent+3]=this.cbx_mensual
this.Control[iCurrent+4]=this.calendario
this.Control[iCurrent+5]=this.calendario2
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.uo_2
end on

on w_ventas_resumen.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.cbx_diario)
destroy(this.cbx_mensual)
destroy(this.calendario)
destroy(this.calendario2)
destroy(this.uo_1)
destroy(this.uo_2)
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

event ue_post_open;//override

Date 		ldt_fecha_ini,ldt_fecha_fin
Integer	li_anio,li_mes

ldt_fecha_ini = Date(gf_fecha_serv())
ii_ann = year(ldt_fecha_ini)
ii_mes  = month(ldt_fecha_ini)
ii_dia  = day(ldt_fecha_ini)

gf_fecha_ini_fecha_fin(ii_mes,ii_ann,ldt_fecha_ini,ldt_fecha_fin)

//em_1.text = string(ldt_fecha_ini)
//em_2.text = String(ldt_fecha_fin)

	em_1.text = string(ii_dia)+ "/" +string(ii_mes)+ "/" +string(ii_ann)
	em_2.text = string(ii_dia)+ "/" +string(ii_mes)+ "/" +string(ii_ann)




end event

type st_nom_ventana from w_cc_padre_rango_fecha`st_nom_ventana within w_ventas_resumen
boolean visible = false
integer x = 23
integer y = 528
end type

type dw_1 from w_cc_padre_rango_fecha`dw_1 within w_ventas_resumen
integer x = 87
integer y = 624
integer width = 517
integer height = 88
integer taborder = 0
end type

type p_1 from w_cc_padre_rango_fecha`p_1 within w_ventas_resumen
boolean visible = false
integer y = 52
integer width = 73
integer height = 48
end type

type em_2 from w_cc_padre_rango_fecha`em_2 within w_ventas_resumen
integer x = 1221
integer y = 228
integer width = 448
alignment alignment = center!
end type

type st_2 from w_cc_padre_rango_fecha`st_2 within w_ventas_resumen
integer x = 951
integer y = 228
integer width = 256
long textcolor = 15793151
long backcolor = 8421376
end type

type em_1 from w_cc_padre_rango_fecha`em_1 within w_ventas_resumen
integer x = 347
integer y = 228
integer width = 462
alignment alignment = center!
end type

event modified;//override

end event

type st_1 from w_cc_padre_rango_fecha`st_1 within w_ventas_resumen
integer x = 78
integer y = 228
integer width = 261
integer height = 80
long textcolor = 15793151
long backcolor = 8421376
string text = " Desde : "
alignment alignment = right!
end type

type gb_1 from w_cc_padre_rango_fecha`gb_1 within w_ventas_resumen
integer x = 27
integer y = 12
integer width = 1819
integer height = 508
long backcolor = 12639424
string text = "Rango fechas"
end type

type st_7 from w_cc_padre_rango_fecha`st_7 within w_ventas_resumen
integer x = 750
integer y = 392
end type

type cb_1 from w_cc_padre_rango_fecha`cb_1 within w_ventas_resumen
integer x = 759
integer y = 400
end type

type pb_1 from w_cc_padre_rango_fecha`pb_1 within w_ventas_resumen
integer x = 37
integer y = 380
end type

type pb_2 from w_cc_padre_rango_fecha`pb_2 within w_ventas_resumen
integer x = 133
integer y = 380
end type

type cbx_1 from checkbox within w_ventas_resumen
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

type cbx_diario from checkbox within w_ventas_resumen
integer x = 507
integer y = 100
integer width = 462
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
string text = "Diario"
boolean checked = true
end type

event clicked;if this.checked then
	cbx_mensual.checked = false
	em_1.text = string(ii_dia)+ "/" +string(ii_mes)+ "/" +string(ii_ann)
	em_2.text = string(ii_dia)+ "/" +string(ii_mes)+ "/" +string(ii_ann)
else
	cbx_mensual.checked = true
	em_1.text = string(01)+ "/" +string(ii_mes)+ "/" +string(ii_ann)
	em_2.text =  string(gf_last_day(ii_mes,ii_ann))+ "/" +string(ii_mes)+ "/" +string(ii_ann)	
end if
end event

type cbx_mensual from checkbox within w_ventas_resumen
integer x = 1001
integer y = 100
integer width = 462
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
string text = "Mensual"
end type

event clicked;if this.checked then
	cbx_diario.checked = false
	em_1.text = string(01)+ "/" +string(ii_mes)+ "/" +string(ii_ann)
	em_2.text =  string(gf_last_day(ii_mes,ii_ann))+ "/" +string(ii_mes)+ "/" +string(ii_ann)	
else
	cbx_diario.checked = true
	em_1.text = string(ii_dia)+ "/" +string(ii_mes)+ "/" +string(ii_ann)
	em_2.text = string(ii_dia)+ "/" +string(ii_mes)+ "/" +string(ii_ann)
end if
end event

type calendario from picture within w_ventas_resumen
integer x = 805
integer y = 228
integer width = 69
integer height = 80
boolean bringtotop = true
boolean originalsize = true
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

type calendario2 from picture within w_ventas_resumen
integer x = 1673
integer y = 228
integer width = 69
integer height = 80
boolean bringtotop = true
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

type uo_1 from u_ddcalen within w_ventas_resumen
boolean visible = false
integer x = 151
integer y = 312
integer taborder = 50
boolean bringtotop = true
end type

on uo_1.destroy
call u_ddcalen::destroy
end on

event ue_clicked;call super::ue_clicked;em_1.text = string(uo_1.return_sel_date())

if uo_1.allow_close then
	this.visible=false
	em_1.SetFocus()
	parent.height = 656
end if


end event

event destructor;call super::destructor;call u_ddcalen::destroy
end event

type uo_2 from u_ddcalen within w_ventas_resumen
boolean visible = false
integer x = 1019
integer y = 312
integer taborder = 60
boolean bringtotop = true
end type

on uo_2.destroy
call u_ddcalen::destroy
end on

event ue_clicked;call super::ue_clicked;em_2.text = string(uo_2.return_sel_date())

if uo_2.allow_close then
	this.visible=false
	em_2.SetFocus()
	parent.height = 656
end if


end event

event destructor;call super::destructor;call u_ddcalen::destroy
end event

