//objectcomments Seleccionar cual es la proforma para el pase de pedido
forward
global type w_fa_selecprofor from w_fa_padre
end type
type gb_1 from groupbox within w_fa_selecprofor
end type
type cb_1 from commandbutton within w_fa_selecprofor
end type
type st_1 from statictext within w_fa_selecprofor
end type
type cb_2 from commandbutton within w_fa_selecprofor
end type
end forward

global type w_fa_selecprofor from w_fa_padre
integer width = 2016
integer height = 904
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 77107328
gb_1 gb_1
cb_1 cb_1
st_1 st_1
cb_2 cb_2
end type
global w_fa_selecprofor w_fa_selecprofor

type variables
integer ii_row
end variables

on w_fa_selecprofor.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.cb_1=create cb_1
this.st_1=create st_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_2
end on

on w_fa_selecprofor.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.cb_2)
end on

event ue_post_open;call super::ue_post_open;string ls_no_proforma, ls_no_prof
integer li_cont, li_cuenta = 0

For li_cont = 1 to w_fa_co_prof_pasa_ped.dw_4.RowCount() 
	 ls_no_proforma = w_fa_co_prof_pasa_ped.dw_4.GetItemString(li_cont,"dpro_no_proforma")
	If ls_no_proforma <> ls_no_prof then
	  	DO
			li_cuenta++
			ls_no_prof = w_fa_co_prof_pasa_ped.dw_1.GetItemString(li_cuenta,"fatprofo_prof_no_proforma")
			If ls_no_proforma = ls_no_prof Then
				w_fa_co_prof_pasa_ped.dw_1.RowsCopy(li_cuenta,li_cuenta,Primary!,dw,1,Primary!)
			End If
		LOOP UNTIL (ls_no_proforma = ls_no_prof) Or (li_cuenta =  w_fa_co_prof_pasa_ped.dw_1.RowCount())
			li_cuenta = 0
	End If
Next
ii_row = 1
dw.SelectRow(0,FALSE)
dw.SelectRow(ii_row,TRUE)

end event

event ue_aceptar;string ls_return
If dw.RowCount() < 1 then
	return
Else
	ls_return = dw.GetItemString(ii_row,"fatprofo_prof_no_proforma")
	If ls_return = '' or isnull(ls_return) Then 
		Mensaje("ERROR","No se pudo tomar el codigo de la proforma intente nuevamente","")
		return
	End If
	closewithReturn(this,ls_return)
End If
end event

event closequery;//Override
end event

event ue_adicionar;//Override
end event

event close;//Override

end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_selecprofor
integer x = 9
integer y = 740
long backcolor = 77107328
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_selecprofor
integer x = 82
integer y = 228
integer width = 1851
integer height = 408
integer taborder = 20
string dataobject = "dw_co_fa_proapasar"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_1::clicked;ii_row = row

this.SelectRow(0,FALSE)
this.SelectRow(row,TRUE)



end event

type st_ayuda from w_fa_padre`st_ayuda within w_fa_selecprofor
end type

type gb_1 from groupbox within w_fa_selecprofor
integer x = 46
integer y = 152
integer width = 1925
integer height = 516
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 77107328
string text = "Seleccione una Proforma"
end type

type cb_1 from commandbutton within w_fa_selecprofor
integer x = 1216
integer y = 688
integer width = 320
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;parent.TriggerEvent("ue_aceptar")
end event

type st_1 from statictext within w_fa_selecprofor
integer x = 475
integer y = 28
integer width = 1088
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 77107328
boolean enabled = false
string text = "SELECCION DE LA  PROFORMA "
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_fa_selecprofor
integer x = 1618
integer y = 688
integer width = 320
integer height = 100
integer taborder = 12
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;closewithReturn(parent,0)
end event

