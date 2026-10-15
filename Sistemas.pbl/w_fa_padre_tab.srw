//objectcomments Ventana Padre con Tabs para el sistema de Facturacion
forward
global type w_fa_padre_tab from w_grampa_tab
end type
type gb_1 from groupbox within tabpage_1
end type
type st_gb from statictext within w_fa_padre_tab
end type
type pb_up from u_pb_editar within w_fa_padre_tab
end type
type pb_down from u_pb_editar within w_fa_padre_tab
end type
type st_help from statictext within w_fa_padre_tab
end type
end forward

global type w_fa_padre_tab from w_grampa_tab
integer width = 2565
integer height = 1508
string icon = "\harr98\Art\MINUS.ico"
event ue_libera ( )
event ue_deslibera ( )
event ue_pasar ( )
event ue_armar ( )
event ue_copiarpro ( )
event ue_copiarped ( )
event ue_copiarfac ( )
event ue_pasaped ( )
event ue_pasafac ( )
event ue_armaped ( )
event ue_armafac ( )
event ue_pasaaped ( )
event ue_pasaafact ( )
event ue_foto ( boolean ab_opccheck )
event ue_config_cant ( )
event ue_microhelp pbm_nchittest
event ue_vista ( )
event ue_save_as ( )
event ue_restaurar ( )
event ue_cambiar_formato ( )
st_gb st_gb
pb_up pb_up
pb_down pb_down
st_help st_help
end type
global w_fa_padre_tab w_fa_padre_tab

type variables
/* Var. Utilizadas en FACTURA, PROFORMA, PEDIDO */
/* DataStore del Desglose*/
uo_ds_desglose      iuo_desglose
boolean		ib_modify

/* Líneas del Detalle */
integer	ii_lineas_borradas[]

// Ultima columna donde se posiciono el mousepointer
string	is_last_column
integer	is_last_row

// Columna de Orden
String	is_orden

PRIVATE string	is_objeto = ''
end variables

forward prototypes
public subroutine wf_idioma (readonly integer li_tope)
public subroutine wf_foto_desglose (integer ai_si[], integer ai_no[], string as_campo)
public function long wf_generar_linea (string as_campo)
public subroutine wf_sort_dw (character ac_sort)
public subroutine wf_init (string as_campo)
public subroutine wf_prod_desg (ref integer ai_desg[], string as_campo, string as_campo2, string as_bodega, string as_ubic)
public subroutine wf_setfoto_desglose (long al_linea, string as_campo, string as_bodega, string as_ubic)
end prototypes

event ue_copiarpro;//Open(w_fa_co_proformas)


end event

event ue_copiarped;//Open(w_fa_co_pedidos)

end event

event ue_microhelp;st_Help.Text	 = ''
If st_help.Visible Then st_Help.Visible = False

end event

event ue_save_as;//Guardar en un Archivo
idw_proximo.saveas()
end event

public subroutine wf_idioma (readonly integer li_tope);/*Función que pone o no los campos en ingles*/
//Daniel Vergara 27/10/1998

Integer li_col
Datawindow ldw1
String ls_col 

If w_fa_fondo.str_para.ingles = "N" Then 
	
ldw1 = tab_1.tabpage_1.dw_1

FOR li_col = 1 TO li_tope
	
	ls_col = "t" + string(li_col)

   ldw1.Modify(ls_col + ".Visible=0")

	
NEXT

End If
end subroutine

public subroutine wf_foto_desglose (integer ai_si[], integer ai_no[], string as_campo);/******************************************************************************************
 *																														*
 * Function: wf_foto_desglose																					*
 *																														*
 * Purpose: 	Rutina que "setea" la foto en el campo de Desglose en el DW del Detalle.	*
 *			Dependiendo si el producto es tipo DESGLOSE, y si posee un desglose Asociado 		*
 *			varía la foto.																							*
 *			Para los productos de tipo SERIE y STANDARD no existe imagen relacionada.			* 
 *																														*
 *	Scope: ventana																									*
 *																														*
 *	Arguments: ai_si 		{Productos con Desglose Asociado}											*
 *				  ai_no		{Productos sin Desglose Asociado}											*
 *				  as_campo	{Campo que contiene Número de Línea, utilizado para el Find}		*
 *																														*
 *	Returns: nada 																									*
 *																														*
 * Created:	8 / Abril / 1999																					*
 ******************************************************************************************/
 
DataWindow	ldw_2
Integer		li_i, li_pos
String		ls_path_si, ls_path_no

ls_path_si = str.path + 'art\desglose_s.bmp'
ls_path_no = str.path + 'art\desglose_n.bmp'

ldw_2 = tab_1.tabpage_2.dw_2
// Seteando todos en ""
For li_i = 1 To ldw_2.RowCount ()
	If li_pos > 0 Then ldw_2.SetItem (li_pos, 'desglose', '')
NExt 

// Seteando la imagen para los que son tipo DESGLOSE pero no tienen DESGLOSE asociado
For li_i = 1 To UpperBound(ai_no)
	li_pos = ldw_2.Find (as_campo + '=' + string (ai_no[li_i]), 1, ldw_2.RowCount ())
	If li_pos > 0 Then ldw_2.SetItem (li_pos, 'desglose', ls_path_no)
Next 

// Seteando la imagen para los que poseen DESGLOSE asociado
For li_i = 1 To UpperBound(ai_si)
	li_pos = ldw_2.Find (as_campo + '=' + string (ai_si[li_i]), 1, ldw_2.RowCount ())
	If li_pos > 0 Then ldw_2.SetItem (li_pos, 'desglose', ls_path_si)
Next 

// Cambiando el STATUS del Renglón a NOT MODIFIED
For li_i  = 1 To ldw_2.RowCount ()
//	 ldw_2.SetItemStatus(li_i, 0, Primary!, NotModified!)
Next 
end subroutine

public function long wf_generar_linea (string as_campo);/******************************************************************************************
 *																														*
 * Function: wf_generar_linea																					*
 *																														*
 * Purpose: 	Genera el número de Línea.  El nuevo número será en 1 mayor al más alto.	* 
 *																														*
 *	Scope: ventana																									*
 *																														*
 *	Arguments: as_campo	{Campo que contiene Número de Línea}										*
 *																														*
 *	Returns: Long	{Número de Línea} 																		*
 *																														*
 * Created:	9 / Abril / 1999																					*
 ******************************************************************************************/
 
DataWindow		ldw_2
Long				ll_i, ll_max, ll_seq, ll_linea

ldw_2 	= tab_1.tabpage_2.dw_2
ll_max	= ldw_2.RowCount ()
ll_seq	= 0
For ll_i = 1 To ll_max
	ll_linea = ldw_2.GetItemNumber (ll_i, as_campo)
	If ll_linea > ll_seq Then ll_seq = ll_linea
Next

Return (ll_seq + 1)
end function

public subroutine wf_sort_dw (character ac_sort);// Ordena el DW de Detalle
//

DataWindow		ldw_2
Long				ll_selected, ll_old_idx, ll_new_idx, ll_new_pos

ldw_2 		= tab_1.tabpage_2.dw_2
//ll_selected = ldw_2.GetSelectedRow (0)
ll_selected	= ldw_2.GetRow()

If ll_selected < 1 Then Return
If len (is_orden ) = 0 Then Return
If ldw_2.RowCount () > 0 And ll_selected = 0 Then ll_selected = 1

If ac_sort = 'U' Then			// Arriba
	If ll_selected > 1 Then		// Si es la Primera línea no se puede subir más
		ll_old_idx = ldw_2.GetItemNumber (ll_selected, is_orden)
		ll_new_idx = ldw_2.GetItemNumber (ll_selected - 1, is_orden)
//messagebox (string(ll_new_idx),string(ll_old_idx))		 
		If NOT (ll_old_idx > 0)  Or NOT (ll_new_idx > 0) Then Return
		If IsNull (ldw_2.Object.Data [ll_selected, 1]) Or &
			IsNull (ldw_2.Object.Data [ll_selected - 1, 1]) Then Return
		
		ldw_2.SetItem (ll_selected, is_orden, ll_new_idx)
		ldw_2.SetItem (ll_selected - 1, is_orden, ll_old_idx)
//		ll_new_pos = ll_selected - 1
	End If

ElseIf ac_sort = 'D' Then		// Abajo
	If ll_selected < ldw_2.RowCount () Then	// Si es la última línea no se puede bajar más
		ll_old_idx = ldw_2.GetItemNumber (ll_selected, is_orden)
		ll_new_idx = ldw_2.GetItemNumber (ll_selected + 1, is_orden)
//messagebox (string(ll_new_idx),string(ll_old_idx))			
		If NOT (ll_old_idx > 0)  Or NOT (ll_new_idx > 0) Then Return
		If IsNull (ldw_2.Object.Data [ll_selected, 1]) Or &
			IsNull (ldw_2.Object.Data [ll_selected + 1, 1]) Then Return
		
		ldw_2.SetItem (ll_selected, is_orden, ll_new_idx)
		ldw_2.SetItem (ll_selected + 1, is_orden, ll_old_idx)
//		ll_new_pos = ll_selected + 1
	End If
End If

ldw_2.SetRedraw (False)
ldw_2.Sort ()
//ldw_2.ScrollToRow (ldw_2.GetSelectedRow (0))
ldw_2.SetRow (ll_new_idx)
ldw_2.SetRedraw (True)


//gf_cr_enabled_save (MenuName, False)
end subroutine

public subroutine wf_init (string as_campo);// Inicialización
//
DataWindow	ldw_2

ldw_2	= tab_1.tabpage_2.dw_2

is_orden = as_campo
ldw_2.SetRedraw (False)
ldw_2.SetSort (as_campo + ' A')
ldw_2.Sort ()
ldw_2.SetRedraw (True)

end subroutine

public subroutine wf_prod_desg (ref integer ai_desg[], string as_campo, string as_campo2, string as_bodega, string as_ubic);/******************************************************************************************
 *																														*
 * Function: wf_prod_desg																						*
 *																														*
 * Purpose: 	Carga un arreglo con aquellas líneas con producto definición DESGLOSE.		* 	
 *																														*
 *	Scope: ventana																									*
 *																														*
 *	Arguments: as_campo 	{Campo que contiene Número de Línea}										*
 *				  as_campo2 {Campo que contiene la DEFINICIÓN del Producto}							*
 *				  as_bodega {Nombre del campo que almacena la bodega}									*
 *				  as_ubic	{Nombre del campo que almacena la ubicación}								*
 *																														*
 *	Returns: nada 																									*
 *																														*
 * Created:	8 / Abril / 1999																					*
 *																														*
 * Última Modificación:	29 / mayo / 1999																	*
 ******************************************************************************************/

 Integer			li_i, li_max, li_ubound 
 Boolean			lb_definicion
 String			ls_id_item, ls_bodega, ls_ubic
 DataWindow 	ldw_2
 
 ldw_2  		= tab_1.tabpage_2.dw_2
 li_max 		= ldw_2.RowCount()
 li_ubound 	= UpperBound (ai_desg) + 1
 For li_i = 1 To li_max
	ls_id_item = ldw_2.GetItemString (li_i, as_campo2)
	ls_bodega  = ldw_2.GetItemString (li_i, as_bodega)
	ls_ubic    = ldw_2.GetItemString (li_i, as_ubic)

//  SELECT inmprodu.prod_definicion  
//    INTO :li_definicion  
//    FROM inmprodu  
//   WHERE inmprodu.prod_producto = :ls_id_item   ;

	lb_definicion = gf_fa_tiene_desglose (ls_bodega, ls_ubic, ls_id_item)
	
	// Insertando en el Arreglo aquellas Líneas con definición DESGLOSE
	 If lb_definicion Then 
		ai_desg [li_ubound] = ldw_2.GetItemNumber (li_i, as_campo)
		li_ubound++
	 End If
 Next
end subroutine

public subroutine wf_setfoto_desglose (long al_linea, string as_campo, string as_bodega, string as_ubic);/******************************************************************************************
 *																														*
 * Function: wf_setfoto_desglose																				*
 *																														*
 * Purpose: 	Rutina que "setea" la foto en el campo de Desglose en el DW del Detalle 	*
 *			de una línea en particular.  																		*
 *			Dependiendo si el producto es tipo DESGLOSE, y si posee un desglose Asociado 		*
 *			varía la foto.																							*
 *			Para los productos de tipo SERIE y STANDARD no existe imagen relacionada.			* 
 *																														*
 *	Scope: ventana																									*
 *																														*
 *	Arguments: al_linea 	{Número de Línea}																	*
 *				  as_campo	{Nombre del campo que contiene el Código del Item}						*
 *																														*
 *	Returns: nada 																									*
 *																														*
 * Created:	9 / Abril / 1999																					*
 ******************************************************************************************/

  DataWindow	ldw_2
  Boolean		lb_definicion
  String 		ls_path, ls_id_item, ls_bodega, ls_ubic

  ldw_2 		 = tab_1.tabpage_2.dw_2
  ls_id_item = ldw_2.GetItemString (ldw_2.GetRow(), as_campo)
  ls_bodega	 = ldw_2.GetItemString (ldw_2.GetRow(), as_bodega)
  ls_ubic	 = ldw_2.GetItemString (ldw_2.GetRow(), as_ubic)

//  lb_definicion = gf_fa_definicion_prod (ls_id_item)
  
  lb_definicion = gf_fa_tiene_desglose (ls_bodega, ls_ubic, ls_id_item)
  
//  SELECT inmprodu.prod_definicion  
//    INTO :li_definicion  
//    FROM inmprodu  
//   WHERE inmprodu.prod_producto = :ls_id_item;

 If lb_definicion Then
	ls_path 	 = str.path + 'art\desglose_n.bmp'
 Else
	ls_path 	 = ''
 End If

 ldw_2.SetItem (ldw_2.GetRow (), 'desglose', ls_path)
//ldw_2.SetItemStatus(ldw_2.GetRow (), 0, Primary!, NotModified!)


end subroutine

on w_fa_padre_tab.create
int iCurrent
call super::create
this.st_gb=create st_gb
this.pb_up=create pb_up
this.pb_down=create pb_down
this.st_help=create st_help
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_gb
this.Control[iCurrent+2]=this.pb_up
this.Control[iCurrent+3]=this.pb_down
this.Control[iCurrent+4]=this.st_help
end on

on w_fa_padre_tab.destroy
call super::destroy
destroy(this.st_gb)
destroy(this.pb_up)
destroy(this.pb_down)
destroy(this.st_help)
end on

event open;call super::open;String ls_win

iw_this = This
This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)

m_fa_principal.m_edicin.m_insertar.visible = false
m_fa_principal.m_edicin.m_filtrar.visible = false

//Opciones de mostrar fotos para las opciones de Proforma, Pedidos y Factura
ls_win = This.ClassName()
//Messagebox("Open","win "+ls_win)

//str.frame.SetRedraw ( True )


end event

event ue_post_open;call super::ue_post_open;gf_fa_pro_servi()

//Configurar los Accesos

mf_accesos(this.menuid, this)
end event

event key;if Key = KeyEscape! then
	this.postevent("close")
elseif Keyflags = 2 then	
end if


end event

event close;//Ventana de Foto debe cerrarse junto con su padre

end event

event activate;//If IsValid(iw_foto) Then iw_foto.Show()
end event

event deactivate;//If IsValid(iw_foto) Then iw_foto.Hide()
end event

event ue_adicionar;call super::ue_adicionar;//DataWindow			ldw_2
//Integer				li_row
//
//// Actualizando el campo de Orden
//If Tab_1.SelectedTab = 2 Then
//	ldw_2  = tab_1.tabpage_2.dw_2
//	li_row = ldw_2.GetRow()
//	If len (is_orden) = 0 Then Return
//	ldw_2.SetItem (li_row, is_orden, li_row)
//End If
end event

event timer;st_help.Visible = False
st_help.Text 	 = ''

end event

event ue_pre_aceptar;call super::ue_pre_aceptar;sqlca.autocommit = true

end event

type tab_1 from w_grampa_tab`tab_1 within w_fa_padre_tab
event ue_microhelp pbm_nchittest
integer x = 256
integer y = 68
integer width = 2222
integer height = 1248
integer taborder = 10
end type

event tab_1::ue_microhelp;is_objeto 	 = ''
st_Help.Text = ''
If st_help.Visible Then st_Help.Visible = False

end event

event tab_1::selectionchanged;call super::selectionchanged;//Post Event ue_post_selectionchanged (newindex)

String ls_win

//Opcion de mostrar foto de producto habilitandola para Proforma, Pedidos y Factura
//ls_win = str.frame.GetActiveSheet().ClassName()
ls_win = Parent.ClassName()
if not isvalid(m_fa_principal) then
	parent.changemenu(m_fa_principal)
end if
yield()
//Messagebox("Selectionchanged" + string (tab_1.tabpage_2.dw_2.Rowcount()),"Win "+ls_win+" Index "+string(newindex))
If (ls_win = "w_fa_man_proformas") Or (ls_win = "w_fa_man_pedidos") Or (ls_win = "w_fa_man_pedido") &
	Or ls_win =  "w_fa_man_factura" Or ls_win =  "w_fa_man_proforma" Then
	If (newindex = 2 And tab_1.tabpage_2.dw_2.Rowcount() > 0) Then
	//	m_fa_principal.m_edicin.m_verfoto.enabled = True

			
		st_gb.Show ()
		pb_up.Show ()
		pb_down.Show ()
	Else
		m_fa_principal.m_edicin.m_verfoto.enabled = False

		st_gb.Hide ()
		pb_up.Hide ()
		pb_down.Hide ()
	End If
End If

end event

type tabpage_1 from w_grampa_tab`tabpage_1 within tab_1
integer width = 2185
integer height = 1120
long picturemaskcolor = 553648127
gb_1 gb_1
end type

on tabpage_1.create
this.gb_1=create gb_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
end on

on tabpage_1.destroy
call super::destroy
destroy(this.gb_1)
end on

type dw_1 from w_grampa_tab`dw_1 within tabpage_1
integer x = 64
integer y = 128
integer width = 1769
integer height = 512
boolean border = false
end type

event dw_1::rowfocuschanging;// Verificando que el DESGLOSE no ha cambiado antes de pasar de fila
//Integer 	li_resp
//
//If IsValid (iuo_desglose) Then 
//		If iuo_desglose.ModifiedCount () > 0 Or UpperBound(ii_lineas_borradas) > 0 Or &
//		iuo_desglose.DeletedCount () > 0 Then
//
//		li_resp = MessageBox ("Aviso!", "Se han realizado cambios en la Información. "   +&
//									 "~n¿Desea salvar?  De lo contrario se perderán las mismas" ,&
//									 exclamation!, YesNo!)
//		If li_resp = 1 Then str.frame.GetActiveSheet().TriggerEvent ("ue_aceptar")
//	End If
//End If

end event

type tabpage_2 from w_grampa_tab`tabpage_2 within tab_1
integer width = 2185
integer height = 1120
long picturemaskcolor = 553648127
end type

type dw_2 from w_grampa_tab`dw_2 within tabpage_2
event ue_microhelp pbm_nchittest
event ue_asignar ( long row,  dwobject dwo,  string data )
integer x = 384
integer y = 144
integer height = 620
boolean border = false
end type

event dw_2::ue_microhelp;// Ayuda en el Microhelp

String	ls_objeto, ls_row

ls_objeto = GetObjectAtPointer ()
ls_row	 = Right (ls_objeto, Len (ls_objeto) - Pos (ls_objeto, '~t') + 1)
ls_objeto = Left (ls_objeto, Pos (ls_objeto, '~t') - 1)

is_last_row = integer (ls_row)
If is_last_column = ls_objeto Then Return

is_last_column = lower (ls_objeto)

end event

event dw_2::ue_asignar;//messagebox (data, '')
CHOOSE CASE Left (dwo.ColType, 3)
	CASE 'str', 'cha'
		Object.Data [long (row), long (dwo.id)] = data

	CASE 'num', 'lon', 'int'
		Object.Data [long (row), long (dwo.id)] = long (data)
		
	CASE 'dec'
		Object.Data [long (row), long (dwo.id)] = dec (data)
END CHOOSE

end event

event dw_2::rowfocuschanged;String ls_win
Boolean lb_rtn
Long ll_filas

//Opcion de mostrar foto de producto habilitandola para Proforma, Pedidos y Factura
ls_win = iw_this.ClassName()

//SelectRow (0, False)
//SelectRow (currentrow, True)

if not isvalid(m_fa_principal) then
	iw_this.changemenu(m_fa_principal)
end if

If (ls_win = "w_fa_man_proformas") Or (ls_win = "w_fa_man_pedidos") &
	Or ls_win =  "w_fa_man_factura" Then
	lb_rtn = m_fa_principal.m_edicin.m_verfoto.enabled
	ll_filas = tab_1.tabpage_2.dw_2.Rowcount()

	If (ll_filas > 0) And (Not(lb_rtn)) Then
		m_fa_principal.m_edicin.m_verfoto.enabled = True
		st_gb.Show ()
		pb_up.Show ()
		pb_down.Show ()
	ElseIf ll_filas = 0 Then
		m_fa_principal.m_edicin.m_verfoto.enabled = False
	End If
End If

end event

type tabpage_3 from w_grampa_tab`tabpage_3 within tab_1
integer width = 2185
integer height = 1120
long picturemaskcolor = 553648127
end type

type dw_3 from w_grampa_tab`dw_3 within tabpage_3
integer x = 475
integer y = 144
integer width = 1015
integer height = 608
boolean border = false
end type

type gb_1 from groupbox within tabpage_1
integer x = 14
integer y = 48
integer width = 2103
integer height = 608
integer taborder = 1
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79416533
end type

type st_gb from statictext within w_fa_padre_tab
boolean visible = false
integer y = 1304
integer width = 215
integer height = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type pb_up from u_pb_editar within w_fa_padre_tab
string tag = "Subir"
boolean visible = false
integer x = 105
integer y = 1312
integer height = 88
integer taborder = 20
boolean bringtotop = true
string picturename = "ar_up.bmp"
string disabledname = "ar_up.bmp"
end type

event clicked;call super::clicked;wf_sort_dw ('U')
end event

event constructor;call super::constructor;fu_set_microhelp ("Sube el Registro de Detalle Seleccionado")
end event

event ue_nchittest;call super::ue_nchittest;// Ayuda
String		ls_ayuda

ls_ayuda = ' Sube el Registro de Detalle'

If is_objeto = 'UP' Then Return
If NOT st_help.Visible Then
	st_help.Text 	 = ls_ayuda
	st_help.Width	 = Len (st_help.Text) * 26
	st_help.x		 = This.x - (st_help.Width + 25)
	st_help.y		 = This.y + 10
	st_help.Visible = True
	is_objeto = 'UP'
	timer (2)
Else
	Return
End If
end event

type pb_down from u_pb_editar within w_fa_padre_tab
string tag = "Bajar"
boolean visible = false
integer x = 14
integer y = 1312
integer width = 91
integer height = 88
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string picturename = "ar_down.bmp"
string disabledname = "ar_down.bmp"
end type

event clicked;call super::clicked;wf_sort_dw ('D')
end event

event constructor;call super::constructor;fu_set_microhelp ("Baja el Registro de Detalle Seleccionado")
end event

event ue_nchittest;call super::ue_nchittest;// Ayuda
String	ls_ayuda

ls_ayuda = ' Baja el Registro de Detalle'

If is_objeto = 'DOWN' Then Return
If NOT st_help.Visible Then
	st_help.Text 	 = ls_ayuda
	st_help.Width	 = Len (st_help.Text) * 26
	st_help.x		 = This.x - (st_help.Width + 25)
	st_help.y		 = This.y + 10
	st_help.Visible = True
	is_objeto = 'DOWN'
	timer (2)
Else
	Return
End If
end event

type st_help from statictext within w_fa_padre_tab
boolean visible = false
integer x = 347
integer y = 1324
integer width = 773
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15793151
boolean enabled = false
string text = "none"
boolean border = true
boolean focusrectangle = false
end type

