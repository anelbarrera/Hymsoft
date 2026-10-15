//objectcomments User Object Standard (DATASTORE) utilizado por Ventanas que utilizan Desglose
forward
global type uo_ds_desglose from datastore
end type
end forward

global type uo_ds_desglose from datastore
end type
global uo_ds_desglose uo_ds_desglose

forward prototypes
public subroutine of_eliminar (string as_filtro)
public subroutine of_init (readonly string as_dataobject)
public subroutine of_getstatus (ref integer ai_lineas[], string as_campo)
public function boolean of_tienedesglose (integer ai_renglon, string as_campo)
public function boolean of_validar_cant (string as_filtro, decimal ad_cantidad)
end prototypes

public subroutine of_eliminar (string as_filtro);/******************************************************************************************
 *																														*
 * Function: of_eliminar																						*
 *																														*
 * Purpose: 	Se encarga de eliminar las líneas del Desglose y conservar la integridad	*
 *			de la Data no eliminada.																			*
 *																														*
 *	Scope: objeto																									*
 *																														*
 *	Arguments: as_filtro 	{Filtro para Eliminar}														*
 *																														*
 *	Returns: nada 																									*
 *																														*
 * Created:	1 / Abril / 1999																					*
 *																														*
 ******************************************************************************************/

Integer	li_pos, li_rtn, li_newren
Long		ll_fila, ll_fila2
String	ls_linea

//If Not (Len (as_filtro) > 0) Then Return

// Borrando el Desglose
If RowCount () > 0 And Len (as_filtro) > 0 Then
	SetFilter(as_filtro)
	Filter()

// Borrando los Registros Asociados al Renglón que se va eliminar
	If Rowcount() > 0 Then
		Do
			li_rtn = DeleteRow(0)
		Loop While (RowCount () > 0 AND li_rtn = 1)
		If li_rtn = -1 Then Mensaje("Error", "Ha ocurrido un error al tratar de el" +&
			"iminar el Detalle de la Cantidad del renglón No. " + string (ll_fila), "")
	End If
	
	SetFilter ("")
	Filter ()
	
// Borrando los Registros del Buffer de Borrado
// Para evitar que se produzca un error de 'ROWS CHANGED BETWEEN UPDATE AND RETRIEVE'
	RowsDiscard (1, DeletedCount(), Delete!)


// Reorganizando el Desglose
// Todo Desglose de un Renglón mayor al borrado debe ser reacomodado, debido a que
// el Número de Renglón está dado por la Posición (GetRow)
//	ll_fila2 = 0
//	Do
//		ll_fila2++
//		// Cambiando el Filtro
//		gf_replace_cadena (as_filtro, '=', '>')
//		
//		// Obteniendo el nombre del Campo del Filtro
//		li_pos 	= Pos (as_filtro, ' ')
//		ls_linea = Mid (as_filtro, 1 , li_pos)
//	
//		// Acomodando las Líneas del Desglose	
//		ll_fila2 = Find (as_filtro, ll_fila2, RowCount())
//		If ll_fila2 > 0 Then 
//			li_newren = GetItemNumber (ll_fila2, ls_linea) - 1
//			SetItem (ll_fila2, ls_linea, li_newren)
//		End If
//	Loop While (ll_fila2 > 0)
End If
end subroutine

public subroutine of_init (readonly string as_dataobject);/******************************************************************************************
 *																														*
 * Function: of_init																								*
 *																														*
 * Purpose: 	Inicialización del DS																		*
 *																														*
 *	Scope: objeto																									*
 *																														*
 *	Arguments: No tiene																							*
 *																														*
 *	Returns: nada 																									*
 *																														*
 * Created:	1 / Abril / 1999																					*
 *																														*
 *	Last Modified:	6 / Abril / 1999																			*
 ******************************************************************************************/

DataObject = as_dataobject
SetTransObject(Sqlca)

// Deshabilitando los DDDW para que no pida los argumentos
Modify ("#2.Edit.FocusRectangle = yes")
Modify ("#3.Edit.FocusRectangle = yes")
Modify ("#4.Edit.FocusRectangle = yes")

end subroutine

public subroutine of_getstatus (ref integer ai_lineas[], string as_campo);/******************************************************************************************
 *																														*
 * Function: of_getstatus																						*
 *																														*
 * Purpose: 	Carga en un arreglo aquellas lineas que poseen desglose							*
 *																														*
 *	Scope: objeto																									*
 *																														*
 *	Arguments: ai_lineas[]		{Utilizada como Retorno, almacena las líneas del Detalle 	*
 *										 Desglose asociado}														*
 *				  as_campo			{Nombre del Campo que almacena la línea}							*
 *																														*
 *	Returns: nada 																									*
 *																														*
 * Created:	5 / Abril / 1999																					*
 *																														*
 ******************************************************************************************/


Integer	li_linea
Long 		ll_max2, ll_row, ll_ubound


SetSort (as_campo + '  A')
Sort ()

ll_max2 	 = RowCount()
//ll_ubound = UpperBound(ai_lineas) + 1
If ll_max2 > 0 Then ai_lineas [1] = GetItemNumber (1, as_campo)
For ll_row = 1 To ll_max2
	li_linea = GetItemNumber (ll_row, as_campo)

	// Comparando si la línea existe en el Arreglo
	ll_ubound = UpperBound(ai_lineas)
	If ai_lineas [ll_ubound] <> li_linea Then 
		ll_ubound ++
		ai_lineas [ll_ubound] = li_linea
	End If
Next
end subroutine

public function boolean of_tienedesglose (integer ai_renglon, string as_campo);/******************************************************************************************
 *																														*
 * Function: of_tienedesglose																						*
 *																														*
 * Purpose: 	Verificar si una linea especifica posee desglose									*
 *																														*
 *	Scope: objeto																									*
 *																														*
 *	Arguments: ai_renglon		{Número de la Línea a verificar}										*
 *				  as_campo			{Nombre del Campo que almacena la línea}							*
 *																														*
 *	Returns: Boolean				{TRUE	- Posee Desglose		FALSE - No tiene Desglose}			*
 *																														*
 * Created:	8 / Abril / 1999																					*
 *																														*
 ******************************************************************************************/


Integer li_lineas[], li_i, li_max

of_getstatus (li_lineas, as_campo)

li_max = UpperBound (li_lineas)
For li_i = 1 To li_max
	If ai_renglon = li_lineas [li_i] Then Return True
Next

Return False
end function

public function boolean of_validar_cant (string as_filtro, decimal ad_cantidad);/******************************************************************************************
 *																														*
 * Function: of_validar_cant																					*
 *																														*
 * Purpose: 	Se encarga de verificar si la cantidad que se introduce en el DETALLE		*
 *			no es menor a la cantidad asignada en el DESGLOSE											*
 *																														*
 *	Scope: objeto																									*
 *																														*
 *	Arguments: as_filtro 	{Filtro para Eliminar}														*
 *				  ad_cantidad	{Cantidad a verificar}														*
 *																														*
 *	Returns: boolean		{TRUE  - Cantidad Válida														*
 * 							 FALSE - La cantidad es menor a la asignada en el DESGLOSE}			*
 *																														*
 * Created:	10 / Abril / 1999																					*
 *																														*
 ******************************************************************************************/

Integer	li_i, li_max
Decimal	ld_cant_desg

SetFilter (as_filtro)
Filter ()

// Calculando la cantidad en el Desglose
li_max = RowCount ()
For li_i = 1 To li_max
	ld_cant_desg += GetItemNumber (li_i,5)
Next

If ad_cantidad >= ld_cant_desg Then
	Return True
Else
	Return False
End If
end function

event dberror;Mensaje ("Error No. " + string (sqldbcode), "Ha ocurrido un error en el DataStore. " +&
			"Verifique con su proveedor si el error persiste.", sqlerrtext + "~r~n")
end event

on uo_ds_desglose.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on uo_ds_desglose.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

event constructor;//SetTransObject (Sqlca)
end event

