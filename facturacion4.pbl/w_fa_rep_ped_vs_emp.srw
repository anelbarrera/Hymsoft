//objectcomments Ventana para comparar los pedidos vs los empaques
forward
global type w_fa_rep_ped_vs_emp from w_fa_padre
end type
type cb_1 from commandbutton within w_fa_rep_ped_vs_emp
end type
type cbx_3 from checkbox within w_fa_rep_ped_vs_emp
end type
type dw_2 from datawindow within w_fa_rep_ped_vs_emp
end type
type cbx_1 from checkbox within w_fa_rep_ped_vs_emp
end type
type cbx_2 from checkbox within w_fa_rep_ped_vs_emp
end type
type gb_1 from groupbox within w_fa_rep_ped_vs_emp
end type
type cbx_5 from checkbox within w_fa_rep_ped_vs_emp
end type
type cbx_4 from checkbox within w_fa_rep_ped_vs_emp
end type
type st_4 from statictext within w_fa_rep_ped_vs_emp
end type
type st_1 from statictext within w_fa_rep_ped_vs_emp
end type
type cbx_6 from checkbox within w_fa_rep_ped_vs_emp
end type
type cbx_7 from checkbox within w_fa_rep_ped_vs_emp
end type
type st_2 from statictext within w_fa_rep_ped_vs_emp
end type
type st_3 from statictext within w_fa_rep_ped_vs_emp
end type
type st_5 from statictext within w_fa_rep_ped_vs_emp
end type
type st_6 from statictext within w_fa_rep_ped_vs_emp
end type
type st_7 from statictext within w_fa_rep_ped_vs_emp
end type
type cbx_8 from checkbox within w_fa_rep_ped_vs_emp
end type
end forward

global type w_fa_rep_ped_vs_emp from w_fa_padre
integer x = 480
integer y = 364
integer width = 2848
integer height = 1380
string title = "(FA) Vista de verificación de los Pedidos vs Lista de Empaque"
boolean controlmenu = false
boolean maxbox = false
boolean resizable = false
long backcolor = 78682240
event ue_vistaprevia ( )
cb_1 cb_1
cbx_3 cbx_3
dw_2 dw_2
cbx_1 cbx_1
cbx_2 cbx_2
gb_1 gb_1
cbx_5 cbx_5
cbx_4 cbx_4
st_4 st_4
st_1 st_1
cbx_6 cbx_6
cbx_7 cbx_7
st_2 st_2
st_3 st_3
st_5 st_5
st_6 st_6
st_7 st_7
cbx_8 cbx_8
end type
global w_fa_rep_ped_vs_emp w_fa_rep_ped_vs_emp

type variables
boolean ib_flag = true, ib_asig = true
string is_cod_ped, is_cod_empq, is_tipo
long il_anno, il_rep = 1

end variables

event ue_vistaprevia;string ls_pedido

str_fa_pedfac_vs_imp lstr_pedfac


If dw.RowCount() < 1 OR dw_2.RowCount() < 1 then return


is_cod_empq = dw_2.GetItemString(dw_2.GetRow(),"fatempaq_enca_lista_empaque")


//messagebox("AVISO","Proceda a escoger la lista de empaque para comparla con el pedido " +&	
//	""+ls_num_ped+"",Information!)
//	ls_pedido = ls_num_ped+"/"+string(ll_anno)+"/"+string(li_pormy)
//	OpenWithParm(w_fa_man_selecempaq,ls_pedido)
//messagebox("",ls_emp_anno)
If is_cod_empq= "" OR IsNull(is_cod_empq) then
	ib_flag = false
	return
Else
		
	If cbx_4.checked = true OR cbx_5.checked = true OR cbx_8.checked then
//		messagebox("",is_cod_ped+"/"+string(il_anno)+"/"+string(is_tipo)+"/"+is_cod_empq)
		lstr_pedfac.codigo = is_cod_ped
		lstr_pedfac.anno = il_anno
		lstr_pedfac.tipo = is_tipo
		lstr_pedfac.codempaq = is_cod_empq
		
		lstr_pedfac.por_tipo = ib_flag
		
		lstr_pedfac.asignado = ib_asig
		
		lstr_pedfac.reportes = il_rep
		
		OpenSheetWithParm(w_fa_rep_imp_pedid_vs_emp,lstr_pedfac,this,8,Layered!)
		
	End If
End If



end event

on w_fa_rep_ped_vs_emp.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cbx_3=create cbx_3
this.dw_2=create dw_2
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.gb_1=create gb_1
this.cbx_5=create cbx_5
this.cbx_4=create cbx_4
this.st_4=create st_4
this.st_1=create st_1
this.cbx_6=create cbx_6
this.cbx_7=create cbx_7
this.st_2=create st_2
this.st_3=create st_3
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.cbx_8=create cbx_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cbx_3
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cbx_1
this.Control[iCurrent+5]=this.cbx_2
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.cbx_5
this.Control[iCurrent+8]=this.cbx_4
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.cbx_6
this.Control[iCurrent+12]=this.cbx_7
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.st_5
this.Control[iCurrent+16]=this.st_6
this.Control[iCurrent+17]=this.st_7
this.Control[iCurrent+18]=this.cbx_8
end on

on w_fa_rep_ped_vs_emp.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cbx_3)
destroy(this.dw_2)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.gb_1)
destroy(this.cbx_5)
destroy(this.cbx_4)
destroy(this.st_4)
destroy(this.st_1)
destroy(this.cbx_6)
destroy(this.cbx_7)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.cbx_8)
end on

event ue_post_open;call super::ue_post_open;

dw_2.SetTransObject(sqlca)
dw.retrieve(str.g_financiero,str.empresa)
//dw.SetFilter("fatpedid_pedi_estado <> 'P'")
//dw.Filter()
end event

event resize;gf_center_win(this)


end event

event closequery;constant int SW_HIDE = 0
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

event open;call super::open;IF Trim(Message.StringParm) <> "" THEN
	This.Tag = Trim(Message.StringParm)
END IF

end event

event activate;call super::activate;gnv_seg.of_aplicar_acciones_ventana(w_hs_frame.rbb_1, this.tag)
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_rep_ped_vs_emp
boolean visible = false
integer x = 27
integer y = 1228
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_rep_ped_vs_emp
integer x = 59
integer y = 148
integer width = 2117
integer height = 476
integer taborder = 10
string dataobject = "dw_ma_fa_enca_pedi_emp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_1::doubleclicked;this.TriggerEvent("ue_entercol")
end event

event dw_1::ue_entercol;string ls_num_ped, ls_pedido, ls_emp_anno
integer li_pormy
long ll_anno

If dw.RowCount() < 1 then return

If ib_flag = true then
		is_cod_ped = dw.getItemString(dw.GetRow(),"fatpedid_pedi_no_pedido")
		il_anno = dw.getItemNumber(dw.GetRow(),"fatpedid_pedi_ann")
		is_tipo =  dw.getItemString(dw.GetRow(),"fatpedid_pedi_tipo")
		
		dw_2.Retrieve(str.g_financiero,str.empresa,is_cod_ped,il_anno,is_tipo,"PE")
		
		If dw_2.RowCount() < 1 then 
			cb_1.enabled = false
		Else
			cb_1.enabled = true
		End If
		If cbx_4.Checked = false And cbx_5.Checked = false And cbx_8.Checked = false Then
			cb_1.enabled = false
		Else
			cb_1.enabled = true
		End If
Else
		is_cod_ped = dw.getItemString(dw.GetRow(),"fatdiari_fact_no_pedido")
		il_anno = dw.getItemNumber(dw.GetRow(),"fatdiari_fact_ann")
		is_tipo =  dw.getItemString(dw.GetRow(),"fatdiari_fact_tipo")
		
		dw_2.Retrieve(str.g_financiero,str.empresa,is_cod_ped,il_anno,is_tipo,"FA")
		
		If dw_2.RowCount() < 1 then 
			cb_1.enabled = false
		Else
			cb_1.enabled = true
		End If
End If
end event

event dw_1::clicked;this.TriggerEvent("ue_entercol")
end event

event dw_1::itemchanged;call super::itemchanged;this.TriggerEvent("ue_entercol")
end event

event dw_1::rowfocuschanged;this.TriggerEvent("ue_entercol")
end event

event dw_1::ue_tabfinal;//
end event

event dw_1::ue_microayuda;//Override
end event

type st_ayuda from w_fa_padre`st_ayuda within w_fa_rep_ped_vs_emp
end type

type cb_1 from commandbutton within w_fa_rep_ped_vs_emp
integer x = 2336
integer y = 1068
integer width = 384
integer height = 96
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar"
boolean default = true
end type

event clicked;parent.TriggerEvent("ue_vistaprevia")
end event

type cbx_3 from checkbox within w_fa_rep_ped_vs_emp
integer x = 2290
integer y = 320
integer width = 462
integer height = 64
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 78682240
string text = "Mostrar Todos"
end type

event clicked;If cbx_3.Checked = true then
	dw.SetFilter("")
	dw.filter()
Else
	If ib_flag Then
		dw.SetFilter("fatpedid_pedi_estado <> 'P'")
		dw.Filter()
	Else
		dw.SetFilter("fatdiari_fact_estado <> 'A'")
		dw.Filter()
	End If
end If
end event

type dw_2 from datawindow within w_fa_rep_ped_vs_emp
integer x = 59
integer y = 708
integer width = 2117
integer height = 476
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ma_fa_pedvsempag"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_1 from checkbox within w_fa_rep_ped_vs_emp
integer x = 2290
integer y = 136
integer width = 384
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 78682240
string text = "Por Pedido"
boolean checked = true
boolean righttoleft = true
end type

event clicked;parent.SetRedraw(false)

If cbx_1.Checked = TRUE then
	ib_flag = true
	cbx_2.checked = false
	st_7.text = "Pedidos Reservados"
	dw.dataObject = "dw_ma_fa_enca_pedi_emp"
	dw.SetTransObject(sqlca)
	dw.retrieve(str.g_financiero,str.empresa)
	If dw.RowCount() < 1 then
		dw_2.reset()
	End If
	If cbx_3.Checked = true then 
		cbx_3.Postevent("clicked")
	Else
		dw.SetFilter("fatpedid_pedi_estado <> 'P'")
		dw.Filter()
	End If
End If
parent.SetRedraw(true)
end event

type cbx_2 from checkbox within w_fa_rep_ped_vs_emp
integer x = 2290
integer y = 216
integer width = 402
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 78682240
string text = "Por Factura"
boolean righttoleft = true
end type

event clicked;parent.SetRedraw(false)
If cbx_2.Checked = TRUE then
	ib_flag = false
	cbx_1.Checked = false
	st_7.text = "Facturas"
	
	dw.dataobject = "dw_ma_fa_factvs_emp"
	dw.SetTransObject(sqlca)
	dw.retrieve(str.g_financiero,str.empresa)
	
	If dw.RowCount() < 1 then
		dw_2.reset()
	End If
	If cbx_3.Checked = true then 
		cbx_3.Postevent("clicked")
	Else
		dw.SetFilter("fatdiari_fact_estado = 'A'")
		dw.Filter()
	End If
	
	
	
End If
parent.SetRedraw(true)
end event

type gb_1 from groupbox within w_fa_rep_ped_vs_emp
integer x = 27
integer y = 12
integer width = 2181
integer height = 1204
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
end type

type cbx_5 from checkbox within w_fa_rep_ped_vs_emp
integer x = 2290
integer y = 884
integer width = 334
integer height = 60
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 78682240
string text = "Detallado"
boolean righttoleft = true
end type

event clicked;If cbx_5.Checked = TRUE then
	il_rep = 2
	cb_1.enabled = true
	cbx_4.Checked = false
	cbx_8.Checked = false
End If
end event

type cbx_4 from checkbox within w_fa_rep_ped_vs_emp
integer x = 2290
integer y = 804
integer width = 357
integer height = 76
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 78682240
string text = "Resumido"
boolean checked = true
boolean righttoleft = true
end type

event clicked;If cbx_4.Checked = TRUE then
	il_rep = 1
	cb_1.enabled = true
	cbx_5.Checked = false
	cbx_8.Checked = false
End If
end event

type st_4 from statictext within w_fa_rep_ped_vs_emp
integer x = 2258
integer y = 708
integer width = 521
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
string text = "Tipos de Reporte"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_1 from statictext within w_fa_rep_ped_vs_emp
integer x = 2258
integer y = 424
integer width = 521
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
string text = "Los Productos"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cbx_6 from checkbox within w_fa_rep_ped_vs_emp
integer x = 2290
integer y = 520
integer width = 357
integer height = 76
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 78682240
string text = "Todos"
boolean checked = true
end type

event clicked;
If cbx_6.Checked = TRUE then
	ib_asig = true
	cbx_7.Checked = false
End If
end event

type cbx_7 from checkbox within w_fa_rep_ped_vs_emp
integer x = 2290
integer y = 608
integer width = 434
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 78682240
string text = "No asignados"
end type

event clicked;If cbx_7.Checked = TRUE then
	ib_asig = false
	cbx_6.Checked = false
End If
end event

type st_2 from statictext within w_fa_rep_ped_vs_emp
integer x = 2327
integer y = 1060
integer width = 402
integer height = 108
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_3 from statictext within w_fa_rep_ped_vs_emp
integer x = 2249
integer y = 36
integer width = 539
integer height = 1176
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 78682240
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_5 from statictext within w_fa_rep_ped_vs_emp
integer x = 2258
integer y = 44
integer width = 521
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
string text = "Tipo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_6 from statictext within w_fa_rep_ped_vs_emp
integer x = 59
integer y = 628
integer width = 2117
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
string text = "Seleccione una Lista de Empaque"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_7 from statictext within w_fa_rep_ped_vs_emp
integer x = 59
integer y = 72
integer width = 2117
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
string text = "Pedidos Reservados"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cbx_8 from checkbox within w_fa_rep_ped_vs_emp
integer x = 2290
integer y = 952
integer width = 398
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
string text = "Desglosado"
boolean righttoleft = true
end type

event clicked;If cbx_8.Checked = TRUE then
	il_rep = 3
	cb_1.enabled = true
	cbx_4.Checked = false
	cbx_5.Checked = false
End If
end event

