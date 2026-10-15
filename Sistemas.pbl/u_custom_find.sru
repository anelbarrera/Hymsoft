forward
global type u_custom_find from userobject
end type
type dw_3 from datawindow within u_custom_find
end type
type dw_2 from datawindow within u_custom_find
end type
type sle_1 from u_sle_find_filter within u_custom_find
end type
type dw_1 from datawindow within u_custom_find
end type
end forward

global type u_custom_find from userobject
integer width = 2112
integer height = 1140
long backcolor = 79416533
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
event syscolorchange pbm_syscolorchange
event ue_find pbm_custom01
event ue_restaurar pbm_custom02
event ue_aceptar pbm_custom03
event ue_cancelar pbm_custom04
event ue_limpiar pbm_custom05
event ue_change_title ( string as_column )
dw_3 dw_3
dw_2 dw_2
sle_1 sle_1
dw_1 dw_1
end type
global u_custom_find u_custom_find

type prototypes

end prototypes

type variables
String      is_boton, is_campo, is_row, is_syntax_rtn
Long       il_active_title
Boolean  ib_dw, ib_init=true
str_dynamic_find  istr_df, istr_df_visible
end variables

forward prototypes
public subroutine uf_button_style (readonly character ac_style, readonly string as_campo)
public subroutine uf_modify ()
public subroutine uf_carga_str (readonly str_dynamic_find a_str_df)
public subroutine uf_set_column ()
public subroutine uf_create_datawindow ()
public subroutine uf_create_sql ()
public subroutine wf_get_text (long row)
end prototypes

event syscolorchange;il_active_title = gf_get_syscolor(2)

dw_1.SetRedraw(False)
uf_modify()
dw_1.SetRedraw(True)
end event

event ue_find;String	ls_campo, ls_type_col, ls_filtro


ls_campo 	= istr_df_visible.texto_campo[integer(is_campo), 1]
ls_type_col = dw_1.Describe(ls_campo + ".ColType")

CHOOSE CASE Upper(Left(ls_type_col, 3))
	CASE "CHA"
		ls_filtro = "Upper(Left(" + ls_campo + ", " + String(Len(sle_1.Text)) + ")) = '" + Upper(sle_1.Text) + "'"
	CASE "DAT"
		ls_filtro = "Upper(Left(String(" + ls_campo + "), " + String(Len(sle_1.Text)) + ")) = '" + Upper(sle_1.Text) + "'"
	CASE "DEC", "NUM", "LON", "INT", "REA", "ULO"
		ls_filtro = "Upper(Left(String(" + ls_campo + "), " + String(Len(sle_1.Text)) + ")) = '" + Upper(sle_1.Text) + "'"
	CASE "TIM"
		ls_filtro = "Upper(Left(String(" + ls_campo + "), " + String(Len(sle_1.Text)) + ")) = '" + Upper(sle_1.Text) + "'"
		
END CHOOSE

dw_1.SetFilter(ls_filtro)
dw_1.Filter()
end event

event ue_restaurar;dw_1.SetFilter("")
dw_1.Filter()
end event

event ue_aceptar;Integer li_i, li_secuencia
Long 	  ll_row
String  ls_type_col, ls_syntax

ll_row = dw_1.GetSelectedRow(0)

If ll_row < 1 Then ll_row = dw_1.GetRow()
If ll_row < 1 Then Return


FOR li_i = 1 TO 12
	
//	If	(IsNull(istr_df.texto_campo[li_i, 3]) And &
//		IsNull(istr_df.texto_campo[li_i, 4])) Then 
//		Exit
//	Else
//		If	Len(Trim(istr_df.texto_campo[li_i, 3])) < 1 Then
//			Continue
//		End If	
//	End If	
//
	If	IsNull(istr_df.texto_campo[li_i, 3]) Then
		If IsNull(istr_df.texto_campo[li_i, 4]) Then
			Exit
		Else
			Continue
		End If
	Else
		If	Len(Trim(istr_df.texto_campo[li_i, 3])) < 1 Then
			Continue
		End If	
	End If	
	
	li_secuencia++
	
	If li_secuencia > 1 Then is_syntax_rtn += " And "
	
	is_syntax_rtn += istr_df.texto_campo[li_i, 3]	
	ls_type_col 	= dw_1.Describe(istr_df.texto_campo[li_i, 1] + ".ColType")
	

	CHOOSE CASE Upper(Left(ls_type_col, 3))
		CASE "CHA"
			ls_syntax = " = '" + dw_1.GetItemString(ll_row, istr_df.texto_campo[li_i, 1]) + "' "
//			If IsNull(ls_syntax) Then ls_syntax = " = '' "
			is_syntax_rtn += ls_syntax
		CASE "DAT"
			ls_syntax = " = DateTime('" + String(DateTime(dw_1.GetItemDateTime(ll_row, istr_df.texto_campo[li_i, 1]))) + "') "
//			If IsNull(ls_syntax) Then ls_syntax = " = '' "
			is_syntax_rtn += ls_syntax
		CASE "DEC", "NUM", "LON", "INT", "REA", "ULO"
			ls_syntax = " = " + String(dw_1.GetItemNumber(ll_row, istr_df.texto_campo[li_i, 1])) + " "
//			If IsNull(ls_syntax) Then ls_syntax = " = '' "
			is_syntax_rtn += ls_syntax
		CASE "TIM"
			ls_syntax = " = Time('" + String(dw_1.GetItemTime(ll_row, istr_df.texto_campo[li_i, 1])) + "') "
//			If IsNull(ls_syntax) Then ls_syntax = " = '' "
			is_syntax_rtn += ls_syntax
	END CHOOSE
//	messagebox("u_custom_find:ue_aceptar", is_syntax_rtn )
NEXT
end event

event ue_limpiar;This.TriggerEvent("ue_restaurar")
sle_1.Text = ""
end event

public subroutine uf_button_style (readonly character ac_style, readonly string as_campo);Integer	li_row


If ib_dw Then	
	dw_2.Object.aceptar.border='0'
	dw_2.Object.cancelar.border='0'
	dw_2.Object.limpiar.border='0'
	dw_2.Object.aceptar.color='0'
	dw_2.Object.cancelar.color='0'
	dw_2.Object.limpiar.color='0'
	
	dw_2.Modify(as_campo + ".Color=" + String(il_active_title))
		
	CHOOSE CASE ac_style
	CASE "U" //up
		dw_2.Modify(as_campo + ".Border='6'")
	CASE "D" //down
		dw_2.Modify(as_campo + ".Border='5'")
	END CHOOSE
Else
	If IsNumber(is_campo) Then
		li_row = Integer(is_campo)	
		dw_3.SetItem(li_row, "flag", '0')
	End If
	
	li_row = Integer(as_campo)
	dw_3.SetItem(li_row, "flag", '1')
	
	is_campo = as_campo
End If
end subroutine

public subroutine uf_modify ();String  ls_column_name, ls_dw_style
Integer li_columns, li_i, li_height, li_height_max
Boolean lb_height


li_columns = Integer(dw_1.Describe("DataWindow.Column.Count"))

ls_dw_style = ls_dw_style + "DataWindow.Color=" + String(RGB(192,192,192)) + " "
	
FOR li_i = 1 TO li_columns
	ls_column_name = dw_1.Describe("#" + string(li_i) + ".Name")
	ls_dw_style = ls_dw_style + ls_column_name + "_t.Border='6' "
	ls_dw_style = ls_dw_style + ls_column_name + ".Border='5' "
	ls_dw_style = ls_dw_style + ls_column_name + ".background.Mode=0 "
	ls_dw_style = ls_dw_style + ls_column_name + ".background.color='16777215' "
	ls_dw_style = ls_dw_style + ls_column_name + "_t.Color=" + String(il_active_title) + " "
	ls_dw_style = ls_dw_style + ls_column_name + "_t.Font.Weight=700 "
	ls_dw_style = ls_dw_style + ls_column_name + "_t.Text='" + istr_df.texto_campo[li_i, 2] + "' "
	ls_dw_style = ls_dw_style + ls_column_name + ".TabSequence=0 "
	
	If	IsNull(istr_df.texto_campo[li_i, 4]) Or &
		Upper(istr_df.texto_campo[li_i, 4]) <> "V" Then
		ls_dw_style = ls_dw_style + ls_column_name + "_t.Visible=0 "
		ls_dw_style = ls_dw_style + ls_column_name + ".Visible=0 "
	End If
	
	istr_df.texto_campo[li_i, 1] = ls_column_name
	
//	li_height = Long(dw_1.Describe(ls_column_name + "_t.Height"))

//	If li_height_max < li_height Then
//		li_height_max = li_height
//		If Not lb_height Then lb_height = True
//	End If	
		
NEXT


//If lb_height Then
//	FOR li_i = 1 TO li_columns
//		ls_column_name = dw_1.Describe("#" + string(li_i) + ".Name")
//		ls_dw_style = ls_dw_style + ls_column_name + "_t.Height='" + String(li_height_max) + "' "	
//	NEXT	
//End If

dw_1.Modify(ls_dw_style)
end subroutine

public subroutine uf_carga_str (readonly str_dynamic_find a_str_df);istr_df = a_str_df

uf_create_sql()

uf_create_datawindow()
end subroutine

public subroutine uf_set_column ();Integer	li_i, li_secuencia


FOR li_i=1 TO 12
	If IsNull(istr_df.texto_campo[li_i, 3]) Or &
		IsNull(istr_df.texto_campo[li_i, 4]) Or &
		Upper(istr_df.texto_campo[li_i, 4]) <> "V" Then Continue

	If Len(Trim(istr_df.texto_campo[li_i, 1])) < 1 Then Exit
	
	dw_3.SetItem(dw_3.InsertRow(0), "col_radio", istr_df.texto_campo[li_i, 2])
	
	li_secuencia++
	istr_df_visible.texto_campo[li_secuencia,1] = istr_df.texto_campo[li_i, 1] 
	istr_df_visible.texto_campo[li_secuencia,2] = istr_df.texto_campo[li_i, 2] 
NEXT
end subroutine

public subroutine uf_create_datawindow ();String 	ls_dw_syntax, ls_err, ls_dbname, ls_mask
Integer	li_campo, li_campos


dw_1.SetRedraw(False)

dw_1.Reset()

ls_dw_syntax = SQLCA.SyntaxFromSQL(istr_df.sql, "style(type=grid)", ls_err)

//messagebox("", ls_dw_syntax)


If Len(ls_err) > 0 Then 
	dw_1.SetRedraw(True)	
	mensaje("Error", ls_err, "")
	Return
End If

dw_1.Create(ls_dw_syntax, ls_err)

If Len(ls_err) > 0 Then 
	dw_1.SetRedraw(True)	
	mensaje("Error", ls_err, "")
	Return
End If

uf_modify()



dw_1.SetTransObject(SQLCA)

li_campos = Integer(dw_1.Describe("DataWindow.Column.Count"))

FOR li_campo=1 TO li_campos
	ls_dbname = dw_1.Describe("#" + string(li_campo) + ".dbname")
	
	If Pos(ls_dbname, "mg_cuenta") > 0 Then
		ls_mask = gf_co_mascara_de_cuentas()
		
		dw_1.Modify(dw_1.Describe("#" + string(li_campo) + ".name") + ".editmask.mask='" + &
						ls_mask + "'")
	End If
NEXT

dw_1.Retrieve()

dw_1.SetSort("#1 A")
dw_1.Sort()

If ib_init Then
	uf_set_column()
	ib_init = False
End If

dw_1.SetRow(1)

dw_1.SetRedraw(True)
end subroutine

public subroutine uf_create_sql ();Integer	li_i


istr_df.sql = "SELECT DISTINCT "

FOR li_i = 1 TO 12
	If Len(Trim(istr_df.texto_campo[li_i, 1])) < 1 Then Exit
	
	If li_i > 1 Then istr_df.sql += ", "
	
	istr_df.sql += istr_df.texto_campo[li_i, 1]
	
	gf_replace(istr_df.texto_campo[li_i, 1], '.', '_')	
NEXT

istr_df.sql = istr_df.sql + " from " + istr_df.tabla + " " + istr_df.tabla_where

//messagebox("", istr_df.sql)

istr_df.sql = Lower(istr_df.sql)
end subroutine

public subroutine wf_get_text (long row);String	ls_coltype, ls_colname


ls_colname = dw_1.Describe("#" + is_campo + ".Name")
ls_coltype = dw_1.Describe(ls_colname + ".ColType")

If Lower(Left(ls_coltype, 4)) = 'char' Then
	ls_coltype = 'char'
ElseIf Lower(Left(ls_coltype, 7)) = 'decimal' Then
	ls_coltype = 'decimal'
End If
//messagebox(ls_colname, ls_coltype)
CHOOSE CASE Lower(ls_coltype)
	CASE 'char'
		sle_1.text = dw_1.GetItemString(row, ls_colname)
	CASE 'date'
		sle_1.text = String(dw_1.GetItemDate(row, ls_colname))
	CASE 'datetime'
		sle_1.text = String(dw_1.GetItemDateTime(row, ls_colname))
	CASE 'decimal', 'number', 'int', 'long', 'real', 'ulong'
		sle_1.text = String(dw_1.GetItemNumber(row, ls_colname))
	CASE 'time'
		sle_1.text = String(dw_1.GetItemTime(row, ls_colname))
END CHOOSE

end subroutine

on u_custom_find.create
this.dw_3=create dw_3
this.dw_2=create dw_2
this.sle_1=create sle_1
this.dw_1=create dw_1
this.Control[]={this.dw_3,&
this.dw_2,&
this.sle_1,&
this.dw_1}
end on

on u_custom_find.destroy
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.sle_1)
destroy(this.dw_1)
end on

event constructor;il_active_title = gf_get_syscolor(2)
end event

type dw_3 from datawindow within u_custom_find
event micro pbm_nchittest
integer x = 1490
integer y = 28
integer width = 585
integer height = 1092
string dataobject = "dw_dynamic_column_extern"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event micro;String	ls_row
Integer  li_pos, li_row


ib_dw = False

ls_row = This.GetObjectAtPointer()

li_pos = Pos(ls_row, "~t")

ls_row = Mid(ls_row, li_pos + 1)

If ls_row = is_row Then Return

If IsNumber(is_row) Then
	li_row = Integer(is_row)	
	This.SetItem(li_row, "flag_2", '0')
End If

li_row = Integer(ls_row)	
This.SetItem(li_row, "flag_2", '1')

//This.Modify("col_radio.Color='0~tIf(flag_2='0',0," + String(il_active_title) + ")'")

is_row = ls_row
end event

event clicked;String ls_dw_style

If row < 1 Then Return 

uf_button_style("", String(row))

ls_dw_style = istr_df_visible.texto_campo[row,1] + ".x=1 "

dw_1.Modify(ls_dw_style)
Parent.Trigger Event ue_change_title(istr_df_visible.texto_campo[row,2])
end event

type dw_2 from datawindow within u_custom_find
event micro pbm_nchittest
event lbuttondown pbm_lbuttondown
event lbuttonup pbm_lbuttonup
integer x = 37
integer y = 948
integer width = 1431
integer height = 168
integer taborder = 30
string dataobject = "dw_dg_find_extern"
boolean border = false
boolean livescroll = true
end type

event micro;String	ls_boton
Integer  li_pos


ls_boton = This.GetObjectAtPointer()

li_pos = Pos(ls_boton, "~t")

ls_boton = Left(ls_boton, li_pos -1)

If ls_boton = is_boton Then Return

ib_dw = True
uf_button_style("U", ls_boton)

is_boton = ls_boton
end event

event lbuttondown;uf_button_style("D", is_boton)
end event

event lbuttonup;uf_button_style("U", is_boton)
end event

event clicked;String	ls_boton
Integer  li_pos


ls_boton = This.GetObjectAtPointer()

li_pos = Pos(ls_boton, "~t")

ls_boton = Left(ls_boton, li_pos -1)

Parent.TriggerEvent("ue_" + ls_boton)
end event

type sle_1 from u_sle_find_filter within u_custom_find
integer x = 37
integer y = 32
integer width = 1431
integer height = 84
integer taborder = 10
integer textsize = -10
fontcharset fontcharset = ansi!
end type

type dw_1 from datawindow within u_custom_find
event ue_post_retrieveend ( long rowcount )
integer x = 37
integer y = 144
integer width = 1431
integer height = 776
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_post_retrieveend;Integer li_i
ib_dw = False

li_i = 1

If rowcount > 0 Then
	If IsNull(istr_df.texto_campo[li_i, 3]) Or &
		IsNull(istr_df.texto_campo[li_i, 4]) Or &
		Upper(istr_df.texto_campo[li_i, 4]) <> "V" Then
		
		For li_i = 2 To 12
			 If Upper(istr_df.texto_campo[li_i,4]) = "V" Then Exit
		Next
		
	End If

	dw_3.Trigger Event clicked(1,1,1,dw_3.Object)
End If
	

end event

event retrieveend;This.Post Event ue_post_retrieveend(rowcount)

end event

event clicked;String  ls_objeto, ls_sort, ls_column, ls_coltype
Integer li_pos

If row < 1 Then	
	ls_objeto = This.GetObjectAtPointer()
	li_pos 	 = Pos(ls_objeto, "~t")
	ls_column = Left(ls_objeto, li_pos - 3)
	
	If Mid(ls_objeto, li_pos - 2, 2) = "_t" Then
		ls_sort = Right(This.Describe("DataWindow.Table.Sort"), 1)

		If ls_sort = "A" Then
			This.SetSort(ls_column + " D")
		Else
			This.SetSort(ls_column + " A")		
		End If
		This.Sort()
	End If
	
	Return
Else
	This.SelectRow(0, False)
	This.SelectRow(row, True)
	
	wf_get_text(row)
End If	
end event

event rowfocuschanged;If currentrow < 1 Then Return

This.SelectRow(0, False)
This.SelectRow(currentrow, True)

wf_get_text(currentrow)
end event

