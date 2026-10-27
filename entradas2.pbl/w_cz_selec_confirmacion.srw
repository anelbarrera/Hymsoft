//objectcomments Ventana para selección de encabezado de Confirma ciones para pedido
forward
global type w_cz_selec_confirmacion from w_fa_padre
end type
type gb_1 from groupbox within w_cz_selec_confirmacion
end type
type st_1 from statictext within w_cz_selec_confirmacion
end type
type cb_1 from commandbutton within w_cz_selec_confirmacion
end type
type cb_2 from commandbutton within w_cz_selec_confirmacion
end type
end forward

global type w_cz_selec_confirmacion from w_fa_padre
integer x = 55
integer y = 128
integer width = 2139
integer height = 752
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event ue_syscommand pbm_syscommand
gb_1 gb_1
st_1 st_1
cb_1 cb_1
cb_2 cb_2
end type
global w_cz_selec_confirmacion w_cz_selec_confirmacion

type variables
integer ii_row
end variables

event ue_syscommand;if commandtype = 61536 then
	if messagebox('Información','¿Desea cerrar la ventana?',Question!,YesNo!,2) = 1 then
		rollback;
		closewithreturn(this,'Cancelar')
	else
		return 1
	end if
end if

end event

on w_cz_selec_confirmacion.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
end on

on w_cz_selec_confirmacion.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event ue_aceptar;If w_cz_selec_confirmacion.dw.RowCount() < 1 then
	return
Else
	CloseWithReturn(this,w_cz_selec_confirmacion.dw.GetItemString(ii_row ,"tcof_num_conf_oc"))
End If

end event

event closequery;// Override

end event

event ue_adicionar;// Override

end event

event ue_post_open;// OverRide

string	ls_no_orden, ls_no_factura
integer	li_cont, li_cuenta = 0, li_lineas

is_nombre = This.ClassName()

dw.settransobject(sqlca)

st_nom_ventana.text = is_nombre

this.postevent('ue_hay_data')

this.visible=true

if this.MenuName = "m_cr_principal" Then m_cr_principal.archivo.m_cerrar.toolbaritemvisible = False

li_lineas = w_cz_pases_confirmacion.dw_3.RowCount()

For li_cont = 1 to li_lineas
	ls_no_orden = w_cz_pases_confirmacion.dw_3.GetItemString(li_cont,"dcof_num_conf_oc")

	If ls_no_orden <> ls_no_factura then
		DO
			li_cuenta++
			ls_no_factura = w_cz_pases_confirmacion.dw_1.GetItemString(li_cuenta,"tcof_num_conf_oc")
			If ls_no_orden = ls_no_factura Then
				if w_cz_pases_confirmacion.dw_1.RowsCopy(li_cuenta,li_cuenta,Primary!,w_cz_selec_confirmacion.dw,1000,Primary!) = -1 then &
				messagebox('Verificar','Error al seleccionar el encabezado de la orden.',exclamation!)
			End If
		LOOP UNTIL ls_no_orden = ls_no_factura or li_cuenta = w_cz_pases_confirmacion.dw_1.RowCount()
		li_cuenta = 0
	End If
Next

ii_row = 1
w_cz_selec_confirmacion.dw.SelectRow(0,false)
w_cz_selec_confirmacion.dw.SelectRow(ii_row,true)
st_1.text = 'SELECCIÓN DE '+upper(w_cr_fondo.is_conf)
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_cz_selec_confirmacion
end type

type dw_1 from w_fa_padre`dw_1 within w_cz_selec_confirmacion
integer x = 32
integer y = 244
integer width = 2066
integer height = 276
string dataobject = "dw_co_cz_seleconf"
boolean hscrollbar = false
end type

event dw_1::clicked;//Override
ii_row = row

//this.SelectRow(0,false)
//this.SelectRow(row,true)

end event

event dw_1::dberror;// OverRide

end event

//type gb_ventana from w_fa_padre`gb_ventana within w_cz_selec_confirmacion
//integer taborder = 40
//end type

//type st_micro from w_fa_padre`st_micro within w_cz_selec_confirmacion
//end type

type gb_1 from groupbox within w_cz_selec_confirmacion
integer x = 9
integer y = 180
integer width = 2107
integer height = 372
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleccione un encabezado "
borderstyle borderstyle = styleraised!
end type

type st_1 from statictext within w_cz_selec_confirmacion
integer x = 581
integer y = 32
integer width = 951
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "SELECCIÓN DE DOCUMENTOS"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_cz_selec_confirmacion
integer x = 1513
integer y = 564
integer width = 283
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Aceptar"
end type

event clicked;parent.TriggerEvent("ue_aceptar")

end event

type cb_2 from commandbutton within w_cz_selec_confirmacion
integer x = 1797
integer y = 564
integer width = 283
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancelar"
end type

event clicked;if messagebox('Información','¿Desea cerrar la ventana?',Question!,YesNo!,2) = 1 then
	rollback;
	closewithreturn(parent,'Cancelar')
else
	return
end if

end event

