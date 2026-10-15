//objectcomments Ventana de Impresión del listado de los Pedidos Reservados pendientes de Factura
forward
global type w_in_rep_entradas from w_fa_padre_reportes
end type
type dw_2 from datawindow within w_in_rep_entradas
end type
type dw_3 from datawindow within w_in_rep_entradas
end type
type cb_1 from commandbutton within w_in_rep_entradas
end type
end forward

global type w_in_rep_entradas from w_fa_padre_reportes
integer width = 3035
integer height = 2164
string title = "Reporte de Entrada"
boolean minbox = false
boolean maxbox = false
dw_2 dw_2
dw_3 dw_3
cb_1 cb_1
end type
global w_in_rep_entradas w_in_rep_entradas

type variables
str_rangofecha lstr_rangfech
end variables

on w_in_rep_entradas.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.cb_1
end on

on w_in_rep_entradas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cb_1)
end on

event open;call super::open;long ll_secuencia
integer li_ann
string ls_concepto, ls_empresa
str_in_entradas lstr_entrada

lstr_entrada = message.powerobjectparm

ll_secuencia = lstr_entrada.secuencia
li_ann	=	lstr_entrada.ann
ls_concepto = lstr_entrada.concepto

if dw_1.retrieve(str.g_financiero, str.empresa, ll_secuencia, li_ann, ls_concepto) > 0 then
	ls_empresa  = gf_dg_nombre_empresa()
	dw_1.object.nom_empresa.expression = "'" + ls_empresa +"'"
end if
end event

event resize;//Override
this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 278

dw_2.width = dw_1.width
dw_2.height = dw_1.height

dw_3.width = dw_1.width
dw_3.height = dw_1.height

gb_1.width  = this.width  - 63
gb_1.height = this.height - 220


st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180
this.SetRedraw(true)
end event

event activate;call super::activate;Integer li_tp
Long 	  ll_rtn

if not isvalid(m_fa_rep) then 
	this.changemenu(m_fa_rep)
end if

end event

event ue_post_open;//Override
/* dw corresponde al datawindows que se desea imprimir, por tanto
   si desea asignarle otro nombre haga lo siguiente 
	dw = otro_nombre */
dw = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()


dw_impresion = dw_1
if isvalid(dw) then
	if dw.object.datawindow.print.preview="no" then &
		dw.object.datawindow.print.preview="yes"
end if
//

//Para ocultar las opciones de consultas, cuando es Elbros
if pos(Upper(str.empr_acceso_especial),'ELBROS,') > 0 then gf_fa_cambiar_titulos(this.menuid)

end event

event key;//Override
//Para cerrar la ventana al dar escape
if Key = KeyEscape! and not dw_2.visible and not dw_3.visible then 	//Si el dw del detalle esta oculto
	this.Postevent("close")
elseif dw_2.visible and getfocus() <> dw_1 then	//Si el dw del detalle esta visible, lo oculta
	dw_2.visible = false
elseif dw_3.visible and getfocus() <> dw_1 then	//Si el dw del detalle esta visible, lo oculta
	dw_3.visible = false
end if


end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_in_rep_entradas
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_in_rep_entradas
boolean visible = false
integer x = 37
integer y = 1288
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_in_rep_entradas
integer y = 44
integer width = 2789
integer height = 1216
string dataobject = "dw_lis_in_entrada_real"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_syntax
datetime ld_fecha_ini, ld_fecha_fin

ld_fecha_ini = DateTime(lstr_rangfech.fecha1,Time("00:00:00"))
ld_fecha_fin = DateTime(lstr_rangfech.fecha2,Time("23:59:59"))
//messagebox(string(ld_fecha_ini),string(ld_fecha_fin))
ls_syntax = sqlsyntax
if dw_1.DataObject = "dw_fa_rep_pcking_pend_fact_tempo" then
	if lstr_rangfech.tipo_accion = 'S' then
		ls_syntax = ls_syntax + " AND (vi_pediapasar.pedi_fecha_creacion >= '"+string(ld_fecha_ini,'mm/dd/yyyy hh:mm:ss')+"' ) and (vi_pediapasar.pedi_fecha_creacion <= '"+string(ld_fecha_fin,'mm/dd/yyyy hh:mm:ss')+"') "		
	else
		ls_syntax = ls_syntax + " AND (vi_pediapasar.pedi_fecha >= '"+string(ld_fecha_ini,'mm/dd/yyyy hh:mm:ss')+"') and (vi_pediapasar.pedi_fecha <= '"+string(ld_fecha_fin,'mm/dd/yyyy hh:mm:ss')+"') "	
	end if	
	dw_1.setsqlpreview(ls_syntax)
elseif dw_1.DataObject = "dw_fa_rep_pedidos_registrados" then
	if lstr_rangfech.tipo_accion = 'S' then
		ls_syntax = ls_syntax + " AND (fatpedid.pedi_fecha_creacion >= '"+string(ld_fecha_ini,'mm/dd/yyyy hh:mm:ss')+"' ) and (fatpedid.pedi_fecha_creacion <= '"+string(ld_fecha_fin,'mm/dd/yyyy hh:mm:ss')+"') "		
	else
		ls_syntax = ls_syntax + " AND (fatpedid.pedi_fecha >= '"+string(ld_fecha_ini,'mm/dd/yyyy hh:mm:ss')+"') and (fatpedid.pedi_fecha <= '"+string(ld_fecha_fin,'mm/dd/yyyy hh:mm:ss')+"') "	
	end if	
	dw_1.setsqlpreview(ls_syntax)	
end if
end event

event dw_1::doubleclicked;call super::doubleclicked;string ls_pedido,ls_factura
integer li_ann

if lstr_rangfech.opcion = 'Pedido' then
	ls_pedido = dw.getitemstring(dw.getrow(),'vi_pediapasar_pedi_no_pedido')
	li_ann	 = dw.getitemnumber(dw.getrow(),'vi_pediapasar_pedi_ann')
	dw_2.visible = true
	dw_2.title = 'Pedido '+ls_pedido+' - '+string(li_ann)
	dw_2.retrieve(str.g_financiero, str.empresa, ls_pedido, li_ann)
	dw_2.setfocus()
elseif lstr_rangfech.opcion = 'Ambos' then
	ls_pedido = dw.getitemstring(dw.getrow(),'no_pedido')
	li_ann	 = dw.getitemnumber(dw.getrow(),'ann')	
	if right(ls_pedido,1) = 'F' then	//Si es de facturas, retorna
		ls_factura = dw.getitemstring(dw.getrow(),'factura')
		dw_3.visible = true
	     ls_pedido = mid(ls_pedido,1,len(ls_pedido)-1)		
		dw_3.title = 'Factura '+ls_factura +' Pedido '+ls_pedido+' - '+string(li_ann)
         dw_3.retrieve(str.g_financiero, str.empresa, ls_pedido, li_ann)
		dw_3.setfocus()
	else		
		dw_2.visible = true
		dw_2.title = 'Pedido '+ls_pedido+' - '+string(li_ann)
		dw_2.retrieve(str.g_financiero, str.empresa, ls_pedido, li_ann)
		dw_2.setfocus()
	end if

else	//Por factura
ls_pedido = dw.getitemstring(dw.getrow(),'vi_factuapasar_fact_no_pedido')
	li_ann	 = dw.getitemnumber(dw.getrow(),'vi_factuapasar_fact_ann')		
	ls_factura = dw.getitemstring(dw.getrow(),'vi_factuapasar_fact_no_factura')
	dw_3.visible = true
	dw_3.title = 'Factura '+ls_factura +' Pedido '+ls_pedido+' - '+string(li_ann)
	dw_3.retrieve(str.g_financiero, str.empresa, ls_pedido, li_ann)
	dw_3.setfocus()
end if

end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_in_rep_entradas
integer y = 4
integer width = 2821
integer height = 1268
end type

type dw_2 from datawindow within w_in_rep_entradas
event ue_escape pbm_dwescape
event ue_microayuda pbm_nchittest
boolean visible = false
integer x = 59
integer y = 52
integer width = 2725
integer height = 1448
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string dataobject = "dw_ma_fa_detalle_pedido"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean vscrollbar = true
string icon = "\harr98\Art\MINUS.ico"
boolean livescroll = true
end type

event ue_escape;this.visible = false
end event

event ue_microayuda;/*
	Evento que muestra una pequeña Ayuda dependiendo en que columna se encuentre el mouse
*/

Integer li_pos, li_x, li_y
String ls_objeto, ls_col

ls_objeto = This.GetObjectAtPointer()
li_pos = pos  (ls_objeto,"~t")
ls_col = left (ls_objeto, li_pos - 1)


li_x	 = str.frame.GetActiveSheet ().PointerX () //- 900
li_y	 = str.frame.GetActiveSheet ().PointerY () - 200

//messagebox("Apunta a :",ls_col)

// Dependiendo de la Columna el Mensaje de Ayuda varía
CHOOSE CASE right(ls_col,2)
	CASE '_t'
//		messagebox("!","Invisible")
		If st_ayuda.Visible Then Return
		st_ayuda.Move (li_x, li_y)
		st_ayuda.Text 	= "Haga click para ordenar por la Columna de " + this.describe(ls_col+".text")
		st_ayuda.Width 	= Len (st_ayuda.Text) * 28
		st_ayuda.Visible = TRUE	
	CASE ELSE
	st_ayuda.Visible = FALSE
END CHOOSE

//Integer li_pos, li_x, li_y,li_largo
//String ls_objeto, ls_col
//
//ls_objeto = This.GetObjectAtPointer()
//li_pos = pos  (ls_objeto,"~t")
//ls_col = left (ls_objeto, li_pos - 1)
//
//li_x	 = str.frame.GetActiveSheet ().PointerX () 
//li_largo = len("Haga click para ordenar por la Columna de " + this.describe(ls_col+".text"))*28
//
//If li_x +li_largo >(li_w_ancho +100) then
//	li_x = (li_w_ancho +100) - li_largo
//end if
//
//li_y	 = str.frame.GetActiveSheet ().PointerY () - 200
//
//// Dependiendo de la Columna el Mensaje de Ayuda varía
//CHOOSE CASE right(ls_col,2)
//	CASE '_t'
//		If st_ayuda.Visible Then Return
//		st_ayuda.Move (li_x, li_y)
//		st_ayuda.Text 	= "Haga click para ordenar por la Columna de " + this.describe(ls_col+".text")
//		st_ayuda.Width 	= Len (st_ayuda.Text) * 28
//		st_ayuda.Visible = TRUE	
//	CASE ELSE
//	st_ayuda.Visible = FALSE
//END CHOOSE
end event

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

end if

this.Setredraw(true)
end event

type dw_3 from datawindow within w_in_rep_entradas
event ue_microayuda pbm_nchittest
event ue_escape pbm_dwescape
boolean visible = false
integer x = 73
integer y = 60
integer width = 2670
integer height = 1420
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "dw_ma_fa_detalle_factura"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean vscrollbar = true
boolean resizable = true
string icon = "AppIcon!"
boolean livescroll = true
end type

event ue_microayuda;/*
	Evento que muestra una pequeña Ayuda dependiendo en que columna se encuentre el mouse
*/

Integer li_pos, li_x, li_y
String ls_objeto, ls_col

ls_objeto = This.GetObjectAtPointer()
li_pos = pos  (ls_objeto,"~t")
ls_col = left (ls_objeto, li_pos - 1)


li_x	 = str.frame.GetActiveSheet ().PointerX () //- 900
li_y	 = str.frame.GetActiveSheet ().PointerY () - 200

//messagebox("Apunta a :",ls_col)

// Dependiendo de la Columna el Mensaje de Ayuda varía
CHOOSE CASE right(ls_col,2)
	CASE '_t'
//		messagebox("!","Invisible")
		If st_ayuda.Visible Then Return
		st_ayuda.Move (li_x, li_y)
		st_ayuda.Text 	= "Haga click para ordenar por la Columna de " + this.describe(ls_col+".text")
		st_ayuda.Width 	= Len (st_ayuda.Text) * 28
		st_ayuda.Visible = TRUE	
	CASE ELSE
	st_ayuda.Visible = FALSE
END CHOOSE

//Integer li_pos, li_x, li_y,li_largo
//String ls_objeto, ls_col
//
//ls_objeto = This.GetObjectAtPointer()
//li_pos = pos  (ls_objeto,"~t")
//ls_col = left (ls_objeto, li_pos - 1)
//
//li_x	 = str.frame.GetActiveSheet ().PointerX () 
//li_largo = len("Haga click para ordenar por la Columna de " + this.describe(ls_col+".text"))*28
//
//If li_x +li_largo >(li_w_ancho +100) then
//	li_x = (li_w_ancho +100) - li_largo
//end if
//
//li_y	 = str.frame.GetActiveSheet ().PointerY () - 200
//
//// Dependiendo de la Columna el Mensaje de Ayuda varía
//CHOOSE CASE right(ls_col,2)
//	CASE '_t'
//		If st_ayuda.Visible Then Return
//		st_ayuda.Move (li_x, li_y)
//		st_ayuda.Text 	= "Haga click para ordenar por la Columna de " + this.describe(ls_col+".text")
//		st_ayuda.Width 	= Len (st_ayuda.Text) * 28
//		st_ayuda.Visible = TRUE	
//	CASE ELSE
//	st_ayuda.Visible = FALSE
//END CHOOSE
end event

event ue_escape;this.visible = false
end event

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

end if

this.Setredraw(true)
end event

type cb_1 from commandbutton within w_in_rep_entradas
boolean visible = false
integer x = 2414
integer y = 1736
integer width = 457
integer height = 104
integer taborder = 31
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir"
end type

event clicked;OpenWithParm(w_dw_print_options, dw_1)
If Message.DoubleParm = -1 Then Return
dw_1.Print(True)
end event

