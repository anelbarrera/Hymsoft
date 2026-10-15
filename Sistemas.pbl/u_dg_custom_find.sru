//objectcomments UO para la Busqueda Dinamica
forward
global type u_dg_custom_find from userobject
end type
type dw_3 from datawindow within u_dg_custom_find
end type
type dw_2 from datawindow within u_dg_custom_find
end type
type sle_1 from u_sle_find_filter within u_dg_custom_find
end type
type dw_1 from datawindow within u_dg_custom_find
end type
end forward

global type u_dg_custom_find from userobject
integer width = 3209
integer height = 2032
long backcolor = 12639424
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
event ue_buscar_todos ( )
dw_3 dw_3
dw_2 dw_2
sle_1 sle_1
dw_1 dw_1
end type
global u_dg_custom_find u_dg_custom_find

type prototypes

end prototypes

type variables
String      is_boton, is_campo, is_row, is_syntax_rtn, is_texto
Long       il_active_title
Boolean  ib_dw, ib_init=true, ib_back = false
str_dg_dynamic_find  istr_df, istr_df_visible


end variables

forward prototypes
public subroutine uf_create_datawindow ()
public subroutine uf_create_sql ()
public subroutine uf_carga_str (readonly str_dg_dynamic_find a_str_df)
public subroutine uf_button_style (readonly character ac_style, readonly string as_campo)
public subroutine wf_get_text (long row)
public subroutine uf_set_column ()
public subroutine uf_modify ()
end prototypes

event syscolorchange;il_active_title = gf_get_syscolor(2)

dw_1.SetRedraw(False)
uf_modify()
dw_1.SetRedraw(True)
end event

event ue_find;String	ls_campo, ls_type_col, ls_filtro

//if dw_1.rowcount() > 0 then
	ls_campo 	= istr_df_visible.texto_campo[integer(is_campo), 1]
//end if
ls_type_col = dw_1.Describe(ls_campo + ".ColType")

CHOOSE CASE Upper(Left(ls_type_col, 3))
	CASE "CHA"

		if dw_2.getitemnumber(1,'buscar_todos') = 1 then 			
			ls_filtro = "Upper(" + ls_campo + ") like '%" + Upper(sle_1.Text) + "%'"
		elseif dw_2.getitemnumber(1,'buscar_todos') = 5 then 			
			ls_filtro = "Upper(" + ls_campo + ") like '%" + Upper(sle_1.Text) + "'"
		else 
			ls_filtro = "Upper(Left(" + ls_campo + ", " + String(Len(sle_1.Text)) + ")) = '" + Upper(sle_1.Text) + "'"
		end if
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
String  ls_type_col

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
			is_syntax_rtn += " = '" + dw_1.GetItemString(ll_row, istr_df.texto_campo[li_i, 1]) + "' "
		CASE "DAT"
			is_syntax_rtn += " = DateTime('" + String(DateTime(dw_1.GetItemDateTime(ll_row, istr_df.texto_campo[li_i, 1]))) + "') "
		CASE "DEC", "NUM", "LON", "INT", "REA", "ULO"
			is_syntax_rtn += " = " + String(dw_1.GetItemNumber(ll_row, istr_df.texto_campo[li_i, 1])) + " "
		CASE "TIM"
			is_syntax_rtn += " = Time('" + String(dw_1.GetItemTime(ll_row, istr_df.texto_campo[li_i, 1])) + "') "
	END CHOOSE
	
NEXT
end event

event ue_limpiar;integer row
String ls_dw_style
This.TriggerEvent("ue_restaurar")
sle_1.Text = ""
for row = dw_3.rowcount()  to  1 step -1
uf_button_style("", String(row))

ls_dw_style = istr_df_visible.texto_campo[row,1] + ".x=1 "

dw_1.Modify(ls_dw_style)

this.Trigger Event ue_change_title(istr_df_visible.texto_campo[row,2])
next
sle_1.setfocus()
end event

event ue_buscar_todos;
if dw_2.getitemnumber(1,'buscar_todos') = 1 then 
	dw_2.setitem(1,'buscar_todos',0)

else 
	dw_2.setitem(1,'buscar_todos',1)

end if 


end event

public subroutine uf_create_datawindow ();String 	ls_dw_syntax, ls_err, ls_mask, ls_dbname
long		ll_rows
Integer  li_campos , li_campo

dw_1.SetRedraw(False)

dw_1.Reset()

ls_dw_syntax = SQLCA.SyntaxFromSQL(istr_df.sql, "style(type=grid) datawindow(color = 79416533) ",ls_err)
//DataWindow(color=???long)

//messagebox("DW Syntax", ls_dw_syntax)

If Len(ls_err) > 0 Then 
	dw_1.SetRedraw(True)	
	gf_mensaje("Error", ls_err, 1,1,"E")
	Return
End If

dw_1.Create(ls_dw_syntax,ls_err)

If Len(ls_err) > 0 Then 
	dw_1.SetRedraw(True)	
	gf_mensaje("Error", ls_err, 1,1,"E")
	Return
End If

uf_modify()

dw_1.SetTransObject(SQLCA)

li_campos = Integer(dw_1.Describe("DataWindow.Column.Count"))

//FOR li_campo=1 TO li_campos
//	ls_dbname = dw_1.Describe("#" + string(li_campo) + ".dbname")
//	
//	If Pos(ls_dbname,"mg_cuenta") > 0 Then
//		ls_mask = gf_dg_mascara_de_cuentas()
//		
//		dw_1.Modify(dw_1.Describe("#" + string(li_campo) + ".name") + ".editmask.mask='" + &
//						ls_mask + "'")
//	End If
//NEXT

ll_rows = dw_1.Retrieve()

commit;
//messagebox("Recuperó ",ll_rows)

dw_1.SetSort("#1 A")
dw_1.Sort()

If ib_init Then
	uf_set_column()
	ib_init = False
End If

sle_1.text = istr_df.filtrar

if istr_df.posicionarse = 'S' then
	dw_1.ScrolltoRow(1)
else	
	dw_1.SetRow(1)
end if

dw_1.Modify("DataWindow.Color='79416533'")

dw_1.SetRedraw(True)

end subroutine

public subroutine uf_create_sql ();Integer	li_i


istr_df.sql = "SELECT " //DISTINCT "

FOR li_i = 1 TO 12
	If Len(Trim(istr_df.texto_campo[li_i,1])) < 1 Then Exit
	
	If li_i > 1 Then istr_df.sql += ", "
	
	istr_df.sql += istr_df.texto_campo[li_i,1]
	
	gf_replace(istr_df.texto_campo[li_i, 1], '.', '_')
	
NEXT

istr_df.sql = istr_df.sql + " from " + istr_df.tabla + " " + istr_df.tabla_where

//messagebox("", istr_df.sql)

//istr_df.sql = Lower(istr_df.sql)

end subroutine

public subroutine uf_carga_str (readonly str_dg_dynamic_find a_str_df);//llamado desde ue_init en la ventana de busqueda
istr_df = a_str_df

uf_create_sql()

uf_create_datawindow()
end subroutine

public subroutine uf_button_style (readonly character ac_style, readonly string as_campo);Integer	li_row


If ib_dw Then	
	dw_2.Object.aceptar.border='6'
	dw_2.Object.cancelar.border='6'
	dw_2.Object.limpiar.border='6'
	dw_2.Object.buscar_todos.border='6'
	dw_2.Object.aceptar.color='0'
	dw_2.Object.cancelar.color='0'
	dw_2.Object.limpiar.color='0'
	dw_2.Object.buscar_todos.color='0'	
	
	dw_2.Modify(as_campo + ".Color=" + String(il_active_title))
		
	CHOOSE CASE ac_style
	CASE "U" //up
		dw_2.Modify(as_campo + ".Border='5'")
	CASE "D" //down
		dw_2.Modify(as_campo + ".Border='6'")
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

public subroutine wf_get_text (long row);String	ls_coltype, ls_colname

if dw_1.rowcount() = 0 then return
//gf_mensaje('','getext',1,1,'')
if ib_back then
	this.triggerevent('ue_find')
	return
end if

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

public subroutine uf_set_column ();Integer	li_i, li_secuencia


FOR li_i=1 TO 12
	If IsNull(istr_df.texto_campo[li_i,3]) Or &
		IsNull(istr_df.texto_campo[li_i,4]) Or &
		Upper(istr_df.texto_campo[li_i, 4]) <> "V" Then Continue

	If Len(Trim(istr_df.texto_campo[li_i,1])) < 1 Then Exit
	
	dw_3.SetItem(dw_3.InsertRow(0),"col_radio",istr_df.texto_campo[li_i,2])
	
	li_secuencia++
	istr_df_visible.texto_campo[li_secuencia,1] = istr_df.texto_campo[li_i,1] 
	istr_df_visible.texto_campo[li_secuencia,2] = istr_df.texto_campo[li_i,2] 
NEXT

end subroutine

public subroutine uf_modify ();String  ls_column_name, ls_dw_style, ls_resultado, ls_exp,ls_coltype
Integer li_columns, li_i, li_height, li_height_max
Boolean lb_height


li_columns = Integer(dw_1.Describe("DataWindow.Column.Count"))

ls_dw_style = ls_dw_style + "DataWindow.Color=" + String(RGB(192,192,192)) + " "
	
FOR li_i = 1 TO li_columns
	ls_column_name = dw_1.Describe("#" + string(li_i) + ".Name")
	/*Change made by HGN, 23/05/2002*/	
	ls_coltype = dw_1.Describe(ls_column_name + ".ColType")

	If ( Lower(Left(ls_coltype, 7)) = 'decimal' or Lower(Left(ls_coltype, 6)) = 'number') and & 
		(istr_df.texto_campo[li_i, 2] <> "Peso" and istr_df.texto_campo[li_i, 2] <> "Cubicaje" and istr_df.texto_campo[li_i, 2] <> "Año" and &
		istr_df.texto_campo[li_i, 2] <> "Tercero" and istr_df.texto_campo[li_i, 2] <> "No. Cliente" and istr_df.texto_campo[li_i, 2] <> "Secuencia")  Then
		
		ls_dw_style = ls_dw_style + ls_column_name + ".format='#,###.00'"
		ls_dw_style = ls_dw_style + ls_column_name + ".editmask.mask='#,###.00'"
	end if
	/**/	
	ls_dw_style = ls_dw_style + ls_column_name + ".Border='5' "
	ls_dw_style = ls_dw_style + ls_column_name + ".background.Mode=0 "
	ls_dw_style = ls_dw_style + ls_column_name + ".background.color='16777215' "
	if left(ls_column_name,9) <> 'compute_0' then 
	ls_dw_style = ls_dw_style + ls_column_name + "_t.Border='6' "
	ls_dw_style = ls_dw_style + ls_column_name + "_t.Color=" + String(il_active_title) + " "
	ls_dw_style = ls_dw_style + ls_column_name + "_t.Font.Weight=700 "
	ls_dw_style = ls_dw_style + ls_column_name + "_t.Text='" + istr_df.texto_campo[li_i, 2] + "' "
	ls_dw_style = ls_dw_style + ls_column_name + ".TabSequence=0 "
	end if
	If	IsNull(istr_df.texto_campo[li_i, 4]) Or &
		Upper(istr_df.texto_campo[li_i, 4]) <> "V" Then
		ls_dw_style = ls_dw_style + ls_column_name + "_t.Visible=0 "
		ls_dw_style = ls_dw_style + ls_column_name + ".Visible=0 "
	End If
	
	istr_df.texto_campo[li_i,1] = ls_column_name

	If	not IsNull(istr_df.texto_campo[li_i, 5]) and istr_df.texto_campo[li_i, 5] <> "" and Upper(istr_df.texto_campo[li_i, 4]) = "V" Then
		ls_dw_style = ls_dw_style + ls_column_name + ".width="+istr_df.texto_campo[li_i, 5]+" "
	End If

//Era para cambiar el estilo del edit por ddlb, quedo inconcluso
//	If	not IsNull(istr_df.texto_campo[li_i, 6]) and istr_df.texto_campo[li_i, 6] <> "" and Upper(istr_df.texto_campo[li_i, 4]) = "V" Then
//		ls_dw_style = ls_dw_style + ls_column_name + ".edit.name='"+istr_df.texto_campo[li_i, 6]+" "
//		//"' ddlb.limit=0 ddlb.allowedit=no ddlb.case=any ddlb.useasborder=yes "
//		edit.name="TIPO_INFORME" ddlb.limit=0 ddlb.allowedit=no ddlb.case=any ddlb.useasborder=yes
//	End If

////	li_height = Long(dw_1.Describe(ls_column_name + "_t.Height"))

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

ls_resultado = dw_1.Modify(ls_dw_style)

if ls_resultado <> "" then
	gf_mensaje("Aviso","Error al Preparar la Información de Ayuda "+ls_resultado,1,1,'E')
end if

//Scrip Adicional
dw_1.Modify("DataWindow.Footer.Height='50'")	//Abre el footer
//crea el compute
ls_dw_style   = "create compute(band=footer color='0' alignment='0' border='0' height.autosize=No moveable=1 resizeable=0 x='0' y='0' height='56' width='805' name=com tag='' expression='' font.face='Arial' font.height='-8' font.weight='700' font.family='2' font.pitch='2' font.charset='0'font.italic='0' font.strikethrough='0' font.underline='0' background.mode='2' background.color='553648127')"
ls_resultado  = dw_1.Modify(ls_dw_style)
if ls_resultado <> "" then
	gf_mensaje("Aviso","Error al Preparar la Información de Ayuda "+ls_resultado,1,1,'E')
end if
//modifica el compute
ls_exp = 'string(getrow())+~' de ~'+string(rowcount())'
dw_1.object.com.expression = ls_exp
dw_1.object.com.x = 0

end subroutine

on u_dg_custom_find.create
this.dw_3=create dw_3
this.dw_2=create dw_2
this.sle_1=create sle_1
this.dw_1=create dw_1
this.Control[]={this.dw_3,&
this.dw_2,&
this.sle_1,&
this.dw_1}
end on

on u_dg_custom_find.destroy
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.sle_1)
destroy(this.dw_1)
end on

event constructor;il_active_title = gf_get_syscolor(2)


end event

type dw_3 from datawindow within u_dg_custom_find
event micro pbm_nchittest
event ue_down pbm_dwnkey
integer x = 2574
integer y = 160
integer width = 594
integer height = 1656
string dataobject = "dw_dg_dynamic_column_extern"
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

event ue_down;if keydown(KeyF1!) then 
	messagebox('',this.rowcount())
end if
end event

event clicked;String ls_dw_style

If row < 1 Then Return 

uf_button_style("", String(row))

ls_dw_style = istr_df_visible.texto_campo[row,1] + ".x=1 "

dw_1.Modify(ls_dw_style)

Parent.Trigger Event ue_change_title(istr_df_visible.texto_campo[row,2])
end event

type dw_2 from datawindow within u_dg_custom_find
event micro pbm_nchittest
event lbuttondown pbm_lbuttondown
event lbuttonup pbm_lbuttonup
event ue_escape pbm_dwescape
integer x = 526
integer y = 1864
integer width = 1079
integer height = 152
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
uf_button_style("U",ls_boton)

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

type sle_1 from u_sle_find_filter within u_dg_custom_find
integer x = 32
integer y = 36
integer width = 3141
integer taborder = 10
integer textsize = -10
fontcharset fontcharset = ansi!
long backcolor = 1090519039
end type

event we_keydown;ib_back = false
IF KeyDown (keyback!) THEN
		is_texto = this.text
		ib_back = true
elseIF keydown(KeyControl!) and KeyDown (keyF4!) THEN
	if dw_2.getitemnumber(1,'buscar_todos') = 1 then 
		dw_2.setitem(1,'buscar_todos',0)
	else 
		dw_2.setitem(1,'buscar_todos',1)
	end if 
elseIF keydown(KeyControl!) and KeyDown (keyF5!) THEN
		dw_2.setitem(1,'buscar_todos',5)
elseIF  KeyDown (keyF1!) or keydown(keyf2!) or  KeyDown (keyF3!) or keydown(keyf4!) & 
    or  KeyDown (keyF5!) or keydown(keyf6!) or  KeyDown (keyF7!) or keydown(keyf8!) &
	 or  KeyDown (keyF9!) or keydown(keyf10!) or  KeyDown (keyF11!) or keydown(keyf12!)  then 
	 if dw_2.rowcount() < 1 then return 
integer row	
String ls_dw_style
if keydown(keyf1!) then row = 1 
if keydown(keyf2!) then row = 2 
if keydown(keyf3!) then row = 3 
if keydown(keyf4!) then row = 4 
if keydown(keyf5!) then row = 5 
if keydown(keyf6!) then row = 6 
if keydown(keyf7!) then row = 7 
if keydown(keyf8!) then row = 8 
if keydown(keyf9!) then row = 9
if keydown(keyf10!) then row = 10 
if keydown(keyf11!) then row = 11
if keydown(keyf12!) then row = 12

if row > dw_3.rowcount() then row =  1

uf_button_style("", String(row))

ls_dw_style = istr_df_visible.texto_campo[row,1] + ".x=1 "

dw_1.Modify(ls_dw_style)

Parent.Trigger Event ue_change_title(istr_df_visible.texto_campo[row,2])
elseif keydown(keyControl!) and keydown(KeyP!) then 
	parent.dw_1.setfocus()
end if
end event

event we_nchittest;//override
end event

type dw_1 from datawindow within u_dg_custom_find
event ue_post_retrieveend ( long rowcount )
event ue_escape pbm_dwescape
event ue_enter pbm_dwnprocessenter
event ue_down pbm_dwnkey
integer x = 37
integer y = 144
integer width = 2496
integer height = 1668
integer taborder = 20
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_post_retrieveend(long rowcount);Integer li_i
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


/*  */

integer li_columns
string		ls_column_name, ls_dw_propiedades, ls_resultado
li_columns = Integer(dw_1.Describe("DataWindow.Column.Count"))

FOR li_i = 1 TO li_columns
//		str.frame.Setmicrohelp("Procesando la Configuración de la Columna "+string(li_columns))		
		ls_column_name = dw_1.Describe("#" + string(li_i) + ".Name")  //RECUPERA EL NOMBRE DE LA COLUMNA
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.height='70' "
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.y='2' "
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".height='70' "
NEXT

dw_1.Modify("DataWindow.Header.Height='75'")

ls_resultado= dw_1.Modify(ls_dw_propiedades) 
/*  */

end event

event ue_enter;//Dispara el Evento Aceptar
Parent.TriggerEvent("ue_aceptar")

end event

event ue_down;IF keydown(KeyControl!) and KeyDown (keyF4!) THEN
	if dw_2.getitemnumber(1,'buscar_todos') = 1 then 
		dw_2.setitem(1,'buscar_todos',0)
	else 
		dw_2.setitem(1,'buscar_todos',1)
	end if 
elseif keydown(KeyControl!) and KeyDown (keyF5!) THEN
		dw_2.setitem(1,'buscar_todos',5)
elseIF  KeyDown (keyF1!) or keydown(keyf2!) or  KeyDown (keyF3!) or keydown(keyf4!) & 
    or  KeyDown (keyF5!) or keydown(keyf6!) or  KeyDown (keyF7!) or keydown(keyf8!) &
	 or  KeyDown (keyF9!) or keydown(keyf10!) or  KeyDown (keyF11!) or keydown(keyf12!)  then 
	 if dw_2.rowcount() < 1 then return 
integer row	
String ls_dw_style
if keydown(keyf1!) then row = 1 
if keydown(keyf2!) then row = 2 
if keydown(keyf3!) then row = 3 
if keydown(keyf4!) then row = 4 
if keydown(keyf5!) then row = 5 
if keydown(keyf6!) then row = 6 
if keydown(keyf7!) then row = 7 
if keydown(keyf8!) then row = 8 
if keydown(keyf9!) then row = 9
if keydown(keyf10!) then row = 10 
if keydown(keyf11!) then row = 11
if keydown(keyf12!) then row = 12

if row > dw_3.rowcount() then row =  1

uf_button_style("", String(row))

ls_dw_style = istr_df_visible.texto_campo[row,1] + ".x=1 "

dw_1.Modify(ls_dw_style)

Parent.Trigger Event ue_change_title(istr_df_visible.texto_campo[row,2])
elseif keydown(keyControl!) and keydown(KeyP!) then 
	parent.sle_1.setfocus()
elseif keydown(keyControl!) and keydown(KeyHome!) then 
	this.selectrow(1,true)	
	this.scrolltorow(1)
elseif keydown(keyControl!) and keydown(KeyEnd!) then 
	this.selectrow(this.rowcount(),true)	
	this.scrolltorow(this.rowcount())	
end if
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

event doubleclicked;//Dispara el Evento Aceptar
Parent.TriggerEvent("ue_aceptar")

end event

