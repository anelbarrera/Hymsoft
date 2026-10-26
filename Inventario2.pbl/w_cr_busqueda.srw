//objectcomments  
forward
global type w_cr_busqueda from w_dg_a_custom_find
end type
type cbx_1 from checkbox within w_cr_busqueda
end type
end forward

global type w_cr_busqueda from w_dg_a_custom_find
integer height = 1332
event ue_down pbm_dwnkey
cbx_1 cbx_1
end type
global w_cr_busqueda w_cr_busqueda

type variables
String       is_select
integer ii_estado = 0
end variables

forward prototypes
public subroutine recuperar_str_d ()
public subroutine recuperar_str_dg_d ()
end prototypes

event ue_down;Messagebox('','')
end event

public subroutine recuperar_str_d ();str_dynamic_find		lstr_arg
lstr_arg = Message.PowerObjectParm
istr_df.sql 			= lstr_arg.sql
istr_df.texto_campo	= lstr_arg.texto_campo
istr_df.tabla 			= lstr_arg.tabla
istr_df.tabla_where  = lstr_arg.tabla_where
end subroutine

public subroutine recuperar_str_dg_d ();str_dg_dynamic_find		lstr_arg
lstr_arg = Message.PowerObjectParm
istr_df.sql 			= lstr_arg.sql
istr_df.texto_campo	= lstr_arg.texto_campo
istr_df.tabla 			= lstr_arg.tabla
istr_df.tabla_where  = lstr_arg.tabla_where
end subroutine

on w_cr_busqueda.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
end on

on w_cr_busqueda.destroy
call super::destroy
destroy(this.cbx_1)
end on

event ue_init;call super::ue_init;/***************************************************************************************
 *																													*
 *		Colocando Formato a las Columnas																	*
 *		Se utiliza el campo 3 (istr_df.texto_campo [i,3]) para almacenar el FORMATO		*
 *		El caracter ~t delimita el formato																* 
 ***************************************************************************************/

Integer		li_i, li_col, li_ast, li_fin
String		ls_format, ls_syntax

li_col	 = integer (uo_1.dw_1.Object.DataWindow.Column.Count)
For  li_i = 1 TO li_col
	li_ast = Pos (istr_df.texto_campo [li_i,3], "~t") 
	If li_ast > 0 Then

		// Obteniendo el Formato
		li_fin 	 = Pos (istr_df.texto_campo [li_i,3], "~t", li_ast + 1)
		ls_format = Mid (istr_df.texto_campo [li_i,3], li_ast + 2, li_fin - (li_ast + 2))

		// Modificando el Formato del Campo
		uo_1.dw_1.Modify ("#" + string(li_i) + ".format = '" + ls_format + "'")

	End If
Next


/***************************************************************************************  
 *		Haciendo visible el CheckBox de TODOS sólo cuando existe un ~n en 					*
 *		istr_df.texto_campo [1,3]																			*
 *		Además de Inicializar las variables de instancia											*
 ***************************************************************************************/
If Left (istr_df.texto_campo [1,3], 1) = "~n" Then 
	cbx_1.Visible = True

	// Obteniendo sentencia SELECT
	ls_syntax = lower (uo_1.dw_1.Describe ("DataWindow.Syntax"))
	li_i		 = Pos (ls_syntax , "retrieve=") + 10
	li_fin	 = Pos (ls_syntax, '"', li_i + 2)
	ls_syntax = Mid (ls_syntax, li_i, li_fin - li_i)
	is_select = ls_syntax
	
	// Si no hay datos a recuperar es necesario desplegar todas las referencias
	If uo_1.dw_1.RowCount () = 0 Then 
		cbx_1.Checked 	= TRUE
		cbx_1.TriggerEvent (clicked!)
		cbx_1.Enabled 	= FALSE
	End If
End If

// Haciendo Invisible a campos con texto_campo = 'I'
For  li_i = 1 TO li_col
	If (istr_df.texto_campo [li_i,4] = "I") Then
		uo_1.dw_1.Modify ("#" + string(li_i) + ".width 	 = '0' ")
		uo_1.dw_1.Modify ("#" + string(li_i) + ".visible =  0 ")
	End If
Next

// No existe registros sobre los cuales realizar la búsqueda
If uo_1.dw_1.RowCount () = 0 Then
	messagebox("Atención","¡NO EXISTEN REGISTROS PARA REALIZAR LA BÚSQUEDA!")
	CloseWithReturn(This,'')
End If

//mensaje('',uo_1.dw_1.Describe('DataWindow.Syntax'),'')
//mensaje('Gianni Probando',uo_1.dw_1.GetSQLSelect(),'')

end event

event open;// Override

/*******************************************************************************************
*	System Name:	HARR2000
*								Sistema HARR2000
********************************************************************************************
*	
*	PROPOSITO:
*	 Recibir la estructura que se manda como parametro y validar que se encuentre
*	 correctamente con los datos necesarios
*	
*	OBJETO:						TIPO						NOMBRE						EVENTO
*									----						------						------
*								  Ventana			  	w_a_custom_find				open
*	
*	PARAMETROS:				 RECIBIDOS									ENVIADO
*								 ---------									-------
*							 	  istr_df									xxxxxxxx
*
*	FUNCIONES UTILIZADAS:		NOMBRE					ARGUMENTO			RETORNO		PASADA POR
*										------					---------			-------		----------
*										gf_center_win			ventana			 	xxxxxx			  V
*
*	
*	AUTOR:				Jair & Herick
*	------
*	DÍA DE CREACIÓN:	05 de Marzo de 1999
*	----------------
********************************************************************************************
*	Modificaciones:
*	---------------
*	
*	
*	Fecha de la Modificación		Modificado por el Programador			Referencia
*	------------------------		-----------------------------			----------
*	
*	
********************************************************************************************
*					DERECHO DE AUTOR (c) 1998	HARR Computer and SoftWare, S.A.									 
*******************************************************************************************/

//messagebox(string(str.frame.width), str.frame.height)
il_ancho =  this.width
il_alto = this.height
//this.Height =  str.frame.height - 100
//this.Width  = str.frame.width - 100

if classname(Message.PowerObjectParm) = 'str_dynamic_find' then
	recuperar_str_d()
else 
	recuperar_str_dg_d()
end if 

gf_center_win(this)

if this.y < 0 then 
	this.y = 0	
	this.Height =  str.frame.height - 150	
end if 

If IsNull(istr_df) Or Not IsValid(istr_df) Then
	CloseWithReturn(This, "")
	Return
End If

This.PostEvent("ue_init")



end event

event resize;call super::resize;cbx_1.y  = newHeight - 150
end event

type cb_max from w_dg_a_custom_find`cb_max within w_cr_busqueda
end type

type uo_1 from w_dg_a_custom_find`uo_1 within w_cr_busqueda
integer height = 1156
long backcolor = 78162112
end type

event uo_1::ue_aceptar;//Override
Integer li_i, li_secuencia, li_col, li_ast

/***************************************************************************************
 * Elimando la Cadena de Formato del Arreglo															*	
 ***************************************************************************************/
li_col	 = integer (uo_1.dw_1.Object.DataWindow.Column.Count)
For  li_i = 1 TO li_col
	li_ast = Pos (istr_df.texto_campo [li_i,3], "~t") 
	If li_ast > 0 Then
		li_ast 	 = Pos (istr_df.texto_campo [li_i,3], "~t", li_ast + 1)
		istr_df.texto_campo [li_i,3] = Mid (istr_df.texto_campo [li_i,3], li_ast + 1)
	End If
Next

call super::ue_aceptar

//Override
//Integer li_i, li_secuencia, li_col, li_ast
//Long 	  ll_row
//String  ls_type_col
//
//ll_row = dw_1.GetSelectedRow(0)
//
//If ll_row < 1 Then ll_row = dw_1.GetRow()
//If ll_row < 1 Then Return
//
//
///***************************************************************************************
// * Elimando la Cadena de Formato del Arreglo															*	
// ***************************************************************************************/
//li_col	 = integer (uo_1.dw_1.Object.DataWindow.Column.Count)
//For  li_i = 1 TO li_col
//	li_ast = Pos (istr_df.texto_campo [li_i,3], "~t") 
//	If li_ast > 0 Then
//		li_ast 	 = Pos (istr_df.texto_campo [li_i,3], "~t", li_ast + 1)
//		istr_df.texto_campo [li_i,3] = Mid (istr_df.texto_campo [li_i,3], li_ast + 2)
//	End If
//Next
//
//
///***************************************************************************************
// *			Evento: ue_aceptar (Continuación)															*
// ***************************************************************************************/
//
//FOR li_i = 1 TO 12
//	
//	If	(IsNull(istr_df.texto_campo[li_i, 3]) And &
//		IsNull(istr_df.texto_campo[li_i, 4])) Then 
//		Exit
//	Else
//		If	Len(Trim(istr_df.texto_campo[li_i, 3])) < 1 Then
//			Continue
//		End If	
//	End If	
//	
//	li_secuencia++
//	
//	If li_secuencia > 1 Then is_syntax_rtn += " And "
//	
//	is_syntax_rtn += istr_df.texto_campo[li_i, 3]	
//	ls_type_col 	= dw_1.Describe(istr_df.texto_campo[li_i, 1] + ".ColType")
//
//	CHOOSE CASE Upper(Left(ls_type_col, 3))
//		CASE "CHA"
//			is_syntax_rtn += " = '" + dw_1.GetItemString(ll_row, istr_df.texto_campo[li_i, 1]) + "' "
//		CASE "DAT"
//			is_syntax_rtn += " = DateTime('" + String(DateTime(dw_1.GetItemDateTime(ll_row, istr_df.texto_campo[li_i, 1]))) + "') "
//		CASE "DEC", "NUM", "LON", "INT", "REA", "ULO"
//			is_syntax_rtn += " = " + String(dw_1.GetItemNumber(ll_row, istr_df.texto_campo[li_i, 1])) + " "
//		CASE "TIM"
//			is_syntax_rtn += " = Time('" + String(dw_1.GetItemTime(ll_row, istr_df.texto_campo[li_i, 1])) + "') "
//	END CHOOSE
//	
//NEXT
//
//CloseWithReturn(Parent, is_syntax_rtn)
end event

type cbx_1 from checkbox within w_cr_busqueda
boolean visible = false
integer x = 23
integer y = 1168
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Todos"
borderstyle borderstyle = stylelowered!
end type

event clicked;/***************************************************************************************
 *			Cambia la sintaxis del DW para recuperar Todas las Referencias o las rel.		*
 *			con determinado Proveedor																		*
 ***************************************************************************************/

String	ls_select

ls_select += "SELECT inmprodu.prod_producto, "+&  
	         		  "inmprodu.prod_descripcion, "+&  
			           "inmprodu.prod_costo_fob, "+&  
         			  "inamedid.medi_descripcion, "+&   
						  "cracltam.acta_descripcion, "+&
         			  "inmprodu.prod_color, "+&
						  "cracolor.acol_nombre_color "+&
	    		  " FROM cracltam, "+&  
			           "inamedid, "+&  
						  "cracolor, "+&
         			  "inmprodu  "+&
  		  		 " WHERE ( inmprodu.prod_medida = inamedid.medi_medida ) and "+& 
 		      	     "( cracltam.acta_g_financiero = inmprodu.prod_g_financiero ) and "+& 
         			  "( cracltam.acta_empresa = inmprodu.prod_empresa ) and "+& 
         			  "( cracltam.acta_cod_clase_tam = inmprodu.prod_cod_clase_tam ) and "+& 
			           "( ( inmprodu.prod_g_financiero = " + string (str.g_financiero) + " ) AND "+& 
			           "( inmprodu.prod_empresa = " + string (str.empresa) + " ) ) And "+&
						  "( inmprodu.prod_color   = cracolor.acol_num_color) And "+&
						  "( substring (prod_owner, 2, 2) = '1' )"

If Checked Then
	uo_1.dw_1.SetSQLSelect (ls_select)
Else 
	uo_1.dw_1.SetSQLSelect (is_select)
End If 

uo_1.dw_1.Retrieve ()
end event

