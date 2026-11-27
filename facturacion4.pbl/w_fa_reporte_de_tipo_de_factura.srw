//objectcomments  
forward
global type w_fa_reporte_de_tipo_de_factura from window
end type
type st_2 from statictext within w_fa_reporte_de_tipo_de_factura
end type
type st_1 from statictext within w_fa_reporte_de_tipo_de_factura
end type
type cb_1 from commandbutton within w_fa_reporte_de_tipo_de_factura
end type
type em_final from editmask within w_fa_reporte_de_tipo_de_factura
end type
type em_inicio from editmask within w_fa_reporte_de_tipo_de_factura
end type
type dw_1 from datawindow within w_fa_reporte_de_tipo_de_factura
end type
end forward

global type w_fa_reporte_de_tipo_de_factura from window
integer x = 5
integer y = 4
integer width = 2953
integer height = 1652
boolean titlebar = true
string title = "(FA) Reportes de Tipo de Facturas"
string menuname = "m_hs"
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "L:\Harr2000\ART\factura.ico"
boolean clientedge = true
event ue_print ( )
event ue_regla ( )
event ue_vista ( )
event ue_primer_reg ( )
event ue_reg_anterior ( )
event ue_siguiente_reg ( )
event ue_ultimo_reg ( )
event ue_filter ( )
event ue_sort ( )
event ue_save_as ( )
event ue_imprimir ( )
st_2 st_2
st_1 st_1
cb_1 cb_1
em_final em_final
em_inicio em_inicio
dw_1 dw_1
end type
global w_fa_reporte_de_tipo_de_factura w_fa_reporte_de_tipo_de_factura

type variables
datawindow dw_impresion, dw

string is_ultima_ = '', is_orden_ = ''


end variables

event ue_print();OpenWithParm(w_dw_print_options, dw_1)
If Message.DoubleParm = -1 Then Return
dw_1.Print(True)
end event

event ue_regla();//Si el DW de impresion tiene un datawindow asignado
IF Not isvalid(dw_1) Then Return //Para que no mande error

If dw_1.DataObject <> "" then
	if dw_1.object.datawindow.print.preview.rulers = 'yes' then
		dw_1.object.datawindow.print.preview.rulers = 'no'
	else
		dw_1.object.datawindow.print.preview.rulers = 'yes'
	end if	
End If

end event

event ue_vista();if dw_1.object.datawindow.print.preview="no" then
   dw_1.object.datawindow.print.preview="yes"
else 
	dw_1.object.datawindow.print.preview="no"
end if
end event

event ue_primer_reg();dw_1.scrolltorow(1)
end event

event ue_reg_anterior();dw_1.scrollpriorpage()
end event

event ue_siguiente_reg();dw_1.scrollnextpage()
end event

event ue_ultimo_reg();dw_1.scrolltorow(dw_1.rowcount())
end event

event ue_filter();String var
SetNull(var)

dw_1.SetFilter(var) // Open The Filter Window
dw_1.filter() // Execute the filter expresion definida to the user
dw_1.groupcalc() //Para reorganizar los grupos
end event

event ue_sort();string ls_var
setnull(ls_var)


dw_1.SetSort (ls_var)
dw_1.sort()
//Para reorganizar los grupos
dw_1.groupcalc()
end event

event ue_save_as();dw.saveas()
end event

event ue_imprimir();This.triggerevent('ue_print')
end event

on w_fa_reporte_de_tipo_de_factura.create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.em_final=create em_final
this.em_inicio=create em_inicio
this.dw_1=create dw_1
this.Control[]={this.st_2,&
this.st_1,&
this.cb_1,&
this.em_final,&
this.em_inicio,&
this.dw_1}
end on

on w_fa_reporte_de_tipo_de_factura.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.em_final)
destroy(this.em_inicio)
destroy(this.dw_1)
end on

event open;IF Trim(Message.StringParm) <> "" THEN
	This.Tag = Trim(Message.StringParm)
END IF

dw_1.settransobject(sqlca)
//dw_1.retrieve(1,1,)
//
dw_1.insertrow(1)

em_inicio.text = string (date("01/" + "01" + '/' + string(year(date(gf_fecha_serv())))))
em_final.text = string (date(gf_fecha_serv()))

//dw_1.Modify("DataWindow.Print.Preview=No")
//dw_1.Modify("DataWindow.Print.Preview.Rulers=No")
//

dw = dw_1
dw_impresion = dw_1

dw_impresion = dw
if isvalid(dw) then
		if dw.object.datawindow.print.preview="no" then &
										dw.object.datawindow.print.preview="yes"
end if

This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)
str.frame.SetRedraw ( True )

end event

event resize;//this.SetRedraw(false)

//dw_1.width  = this.width  - 99
//dw_1.height = this.height - 278

dw_1.width  = newwidth - 200
dw_1.height = newheight - 200

//this.SetRedraw(true)

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

event activate;gnv_seg.of_aplicar_acciones_ventana(w_hs_frame.rbb_1, this.tag)
end event

type st_2 from statictext within w_fa_reporte_de_tipo_de_factura
integer x = 777
integer y = 76
integer width = 320
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Final"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_fa_reporte_de_tipo_de_factura
integer x = 50
integer y = 76
integer width = 329
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Inicial"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_fa_reporte_de_tipo_de_factura
integer x = 1495
integer y = 60
integer width = 347
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;date ld_inicio, ld_final

ld_inicio = date(em_inicio.text)
ld_final = date(em_final.text)

dw_1.retrieve(str.g_financiero,str.empresa,ld_inicio, ld_final)
end event

type em_final from editmask within w_fa_reporte_de_tipo_de_factura
integer x = 1102
integer y = 68
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type em_inicio from editmask within w_fa_reporte_de_tipo_de_factura
integer x = 393
integer y = 68
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type dw_1 from datawindow within w_fa_reporte_de_tipo_de_factura
integer x = 23
integer y = 212
integer width = 2825
integer height = 1196
integer taborder = 10
string title = "none"
string dataobject = "dw_informe_facturas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto
integer li_pos 


this.Setredraw(false)

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
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
	
	//Para recalcular los grupos
	this.groupcalc()

end if

this.Setredraw(true)
end event

