//objectcomments Ventana Padre de primer nivel (NO TOCAR)
forward
global type w_in_padre from w_granpa
end type
type dw_2 from datawindow within w_in_padre
end type
type gb_ventana from groupbox within w_in_padre
end type
end forward

shared variables

end variables

global type w_in_padre from w_granpa
integer width = 1600
integer height = 1096
event ue_zoom ( )
event ue_zoom_up ( )
event ue_zoom_down ( )
event ue_save_as ( )
event ue_buscar ( )
event ue_zoom_dw_down ( )
event ue_vista ( )
dw_2 dw_2
gb_ventana gb_ventana
end type
global w_in_padre w_in_padre

type variables
integer ii_ww,ii_wh
String         is_sqlpreview
boolean ib_aceptar

end variables

forward prototypes
public subroutine centrar_dw ()
end prototypes

event ue_zoom;call super::ue_zoom;/* zoom the display size of the report to the size specifield on the menu*/

int li_factor
m_in_reportes  lm_menu

lm_menu = this.menuid

//Initialize li_factor to zero
li_factor = 0

if lm_menu.m_edicion.m_zoom1.m_20%.checked then
	li_factor = 20
elseif lm_menu.m_edicion.m_zoom1.m_40%.checked then
	li_factor = 40
elseif lm_menu.m_edicion.m_zoom1.m_60%.checked then
	li_factor = 60
elseif lm_menu.m_edicion.m_zoom1.m_80%.checked then
	li_factor = 80
elseif lm_menu.m_edicion.m_zoom1.m_100%1.checked then
	li_factor = 100
elseif lm_menu.m_edicion.m_zoom1.m_200%1.checked then
	li_factor = 200
end if

if li_factor > 0 then
	dw.object.datawindow.print.preview.zoom = li_factor
end if
end event

event ue_zoom_up;call super::ue_zoom_up;		////Zoom the display area of the datawindow down//

string ls_factor
integer li_factor
m_in_reportes  lm_menu

//get the current zoom//

ls_factor = dw.object.datawindow.print.preview.zoom
li_factor = integer (ls_factor)

//only zoom down if magnification is greater than 20%//

if li_factor >= 20 and li_factor <= 80 then
	li_factor = li_factor +20
else
	//if magnification is currently 200%, zoom down to 100%
	if li_factor = 100 then
		li_factor = 200
	end if
end if

//set the new zoom level//

dw.object.datawindow.print.preview.zoom = li_factor

//check/uncheck the zoom menu items//
lm_menu = this.menuid

lm_menu.m_edicion.m_zoom1.m_20%.checked = false
lm_menu.m_edicion.m_zoom1.m_40%.checked = false
lm_menu.m_edicion.m_zoom1.m_60%.checked = false
lm_menu.m_edicion.m_zoom1.m_80%.checked = false
lm_menu.m_edicion.m_zoom1.m_100%1.checked = false
lm_menu.m_edicion.m_zoom1.m_200%1.checked = false

choose case li_factor
	case 20
		lm_menu.m_edicion.m_zoom1.m_20%.checked = true
	case 40
		lm_menu.m_edicion.m_zoom1.m_40%.checked = true
	case 60
		lm_menu.m_edicion.m_zoom1.m_60%.checked = true
	case 80
		lm_menu.m_edicion.m_zoom1.m_80%.checked = true
	case 100
		lm_menu.m_edicion.m_zoom1.m_100%1.checked = true
	case 200
		lm_menu.m_edicion.m_zoom1.m_200%1.checked = true
end choose
		
end event

event ue_zoom_down;//Zoom the display area of the datawindow down//

string ls_factor
integer li_factor
m_in_reportes  lm_menu

//get the current zoom//

ls_factor = dw.object.datawindow.print.preview.zoom
li_factor = integer (ls_factor)

//only zoom down if magnification is greater than 20%//

if li_factor >= 40 and li_factor <= 100 then
	li_factor = li_factor -20
else
	//if magnification is currently 200%, zoom down to 100%
	if li_factor = 200 then
		li_factor = 100
	end if
end if

//set the new zoom level//

dw.object.datawindow.print.preview.zoom = li_factor

//check/uncheck the zoom menu items//
lm_menu = this.menuid

lm_menu.m_edicion.m_zoom1.m_20%.checked = false
lm_menu.m_edicion.m_zoom1.m_40%.checked = false
lm_menu.m_edicion.m_zoom1.m_60%.checked = false
lm_menu.m_edicion.m_zoom1.m_80%.checked = false
lm_menu.m_edicion.m_zoom1.m_100%1.checked = false
lm_menu.m_edicion.m_zoom1.m_200%1.checked = false

choose case li_factor
	case 20
		lm_menu.m_edicion.m_zoom1.m_20%.checked = true
	case 40
		lm_menu.m_edicion.m_zoom1.m_40%.checked = true
	case 60
		lm_menu.m_edicion.m_zoom1.m_60%.checked = true
	case 80
		lm_menu.m_edicion.m_zoom1.m_80%.checked = true
	case 100
		lm_menu.m_edicion.m_zoom1.m_100%1.checked = true
	case 200
		lm_menu.m_edicion.m_zoom1.m_200%1.checked = true
end choose

end event

event ue_save_as;call super::ue_save_as;dw.SaveAs()
end event

event ue_buscar;Integer				li_i, li_col, li_count
String 				ls_dwsyntax, ls_find
str_dynamic_find	lstr_df


If ib_aceptar Then &
	MessageBox ("Atención Sr. " + str.nombre + " " + str.apellido, "Las modificaciones "+&
		     		"no guardadas no se reflejaran en la búsqueda.")


ls_dwsyntax = is_sqlpreview//dw.GetSQLSelect ()

//mensaje	  ("dw_syntax", ls_dwsyntax, "")
//messagebox ("dw_syntax","SELECT>"+gf_cr_dwsyntax (ls_dwsyntax, "select") + '~n' +&
//								"FROM>"+gf_cr_dwsyntax (ls_dwsyntax, "from")   + '~n' +&
//								"WHERE>"+gf_cr_dwsyntax (ls_dwsyntax, "where")  + '~n')
//								

li_count = integer (dw.Object.DataWindow.Column.Count)

Do while li_count > 0
	li_count --
	li_col ++
	If dw.Describe ("#" + string (li_col) + ".Tag") = '?' Then Continue
	li_i ++
	lstr_df.texto_campo [li_i, 1] = dw.Describe ("#" + string (li_col) + ".dbName")
	lstr_df.texto_campo [li_i, 2] = dw.Describe ("#" + string (li_col) + ".Tag")
	lstr_df.texto_campo [li_i, 3] = dw.Describe ("#" + string (li_col) + ".Name")
	lstr_df.texto_campo [li_i, 4] = 'V'
Loop


// No existen campos para la búsqueda
If UpperBound (lstr_df.texto_campo) = 0 Then Return

lstr_df.tabla = ' ' + gf_cr_dwsyntax (ls_dwsyntax, "from")
ls_dwsyntax   = gf_cr_dwsyntax (ls_dwsyntax, "where")

// No hay WHERE
If Len (ls_dwsyntax) > 0 Then 
	ls_dwsyntax = ' WHERE ' + ls_dwsyntax
Else
	ls_dwsyntax = ''
End If
lstr_df.tabla_where = ls_dwsyntax 

OpenWithParm(w_cr_busqueda, lstr_df)
ls_find = Message.StringParm

dw.ScrollToRow (dw.Find (ls_find, 1, dw.RowCount()))
dw.SelectRow(0,False)
dw.SelectRow(dw.GetRow(),True)
end event

event ue_zoom_dw_down;//dw.object.datawindow.zoom = 85
//OpenWithParm(w_in_zoom, dw)

end event

event ue_vista;if dw.object.datawindow.print.preview="no" then
   dw.object.datawindow.print.preview="yes"
else 
	dw.object.datawindow.print.preview="no"
end if
end event

public subroutine centrar_dw ();//integer li_posicion_x,li_posicion_y
//li_posicion_x=this.width/2  - dw_1.width/2 
//li_posicion_y=this.height/2 - dw_1.height/2 
//if 0  > li_posicion_x then
//	li_posicion_x = 1
//	this.HScrollBar = TRUE
//else
//	this.HScrollBar = False
//end if
//if 0  > li_posicion_y then
//	li_posicion_y = 1
//	this.VScrollBar = TRUE
//else
//	this.VScrollBar = False
//end if
//dw_1.x=li_posicion_x
//dw_1.y=li_posicion_y

if this.classname() = 'w_in_login' or  this.classname() = 'w_in_login_nt' then
	return 
end if
integer li_posicion_x,li_posicion_y
li_posicion_x=str.frame.width/2  -20 - this.width/2 
li_posicion_y=str.frame.height/2 -100 - this.height/2 
if 0  > li_posicion_x then
	li_posicion_x = 1
	this.HScrollBar = TRUE
else
	this.HScrollBar = False
end if
if 0  > li_posicion_y then
	li_posicion_y = 1
	this.VScrollBar = TRUE
else
	this.VScrollBar = False
end if
this.x=li_posicion_x 

// this.y=li_posicion_y

end subroutine

on w_in_padre.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.gb_ventana=create gb_ventana
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.gb_ventana
end on

on w_in_padre.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.gb_ventana)
end on

event ue_imprimir;integer Net

Net = MessageBox("Confirmación", "Desea Imprimir",  &
		Exclamation!, OKCancel!, 2)
IF Net = 1 THEN 
  // Process OK.
	//dw_2.settransobject(sqlca)
   //dw_2.retrieve(str.g_financiero,str.empresa)
	
	OpenWithParm(w_dw_print_options, dw)

	If Message.DoubleParm = -1 Then Return
   SetPointer(Hourglass!)
   dw.print(true)
ELSE
 // Process CANCEL.
END IF
end event

event ue_hay_data;if dw_1.rowcount() = 0 then
	gf_acelerador()
	this.postevent("ue_insertar")
end if

end event

event ue_post_open;call super::ue_post_open;dw.settransobject(sqlca)
this.visible=true

end event

event open;GarbageCollect( ) 

str.frame.setredraw(false)
// gf_center_win(This)
//gf_acelerador()
dw = dw_1

This.Icon = str.icono


this.visible = false
dw=dw_1

this.visible=false
THIS.SetToolbar(1, true, alignattop!)
THIS.SetToolbarPos(1, 1, 50, false)
this.y=1
str.frame.setredraw(true)

ib_aceptar = false

this.postevent("ue_post_open")
end event

event ue_eliminar;long respuesta
if dw.accepttext() = 1 then
	if  dw.rowcount() > 0 then
		respuesta = messagebox("Atención (Confirme el Siguiente Paso)", &
		"El registro en "+this.title+ " va ha ser borrado!...~n ~t Esta Seguro de Hacerlo &
ahora?",question!,YesNo!) 
		choose case respuesta 
			case 1 
				dw.deleterow(dw.getrow())				
			case 2
				return 
		end choose
	else 
		messagebox("Atención","No hay registros para borrar!")
	end if
end if

end event

event ue_aceptar;long ll_update
window lw_ventana
string ls_titulo



ll_update=dw.update()
if ll_update = 1  then
	commit using sqlca;
	mensaje("Aviso"," ¡ Actualización Exitosa ! ","")
else
	rollback using sqlca;
	mensaje("Aviso","¡ Error al Actualizar !","")
end if
gf_in_enabled_save(str.frame.GetActiveSheet().MenuName, False)



end event

event ue_print;this.triggerevent("ue_imprimir")
end event

event closequery;long respuesta
if ib_aceptar = true then
if dw.accepttext() = 1 then
	if dw.modifiedcount() > 0 or dw.deletedcount() > 0 then
		respuesta = MessageBox("Atención -- " + str.nombre + " " + str.apellido, &
										"No se han Salvado los Cambios." + &
										"~n~n ¿Desea Salvar Ahora?", Question!, YesNoCancel!) 
		choose case respuesta 
			case 1 				
				this.triggerevent("ue_pre_aceptar")
			case 2
				
		   case 3
				return 1
		end choose
	end if
end if
end if

gf_win_used_by_user(is_nombre, false)
end event

event ue_pre_eliminar;gf_in_enabled_save(str.frame.GetActiveSheet().MenuName,True)
this.postevent("ue_eliminar")
end event

type st_nom_ventana from w_granpa`st_nom_ventana within w_in_padre
integer x = 32
integer y = 808
end type

type dw_1 from w_granpa`dw_1 within w_in_padre
event ue_enter pbm_dwnprocessenter
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
event ue_mousemove pbm_mousemove
integer x = 123
integer y = 116
integer width = 1289
integer taborder = 10
boolean hscrollbar = true
end type

event dw_1::ue_enter;call super::ue_enter;send(handle(this),256,9,long(0,0))
return 1
end event

event dw_1::constructor;call super::constructor;//dw_1.x=ii_ww/2 - dw_1.width/2 
//dw_1.y=ii_wh/2 - dw_1.height/2 

end event

event dw_1::rbuttondown;call super::rbuttondown;m_in_padre.m_edicion.PopMenu(parent.PointerX( ), parent.PointerY( ))
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;/* Marca la linea selecionada con un color azul */
//dw.selectrow(0,false)
//dw.selectrow(getrow(),true)
//
end event

event dw_1::clicked;call super::clicked;dw=this

//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
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

event dw_1::itemchanged;call super::itemchanged;ib_aceptar = true
gf_in_enabled_save(str.frame.GetActiveSheet().MenuName, True)
end event

event dw_1::sqlpreview;If sqltype = PreviewSelect! Then is_sqlpreview = sqlsyntax
end event

event dw_1::ue_down;call super::ue_down;// Gianni Araúz (11/10/1999)
// Este script hace que aparezca el nombre del DataWindow Object y el nombre de la
// columna cuando se presionan las teclas "Control" y "N".


string		 ls_clase, ls_dw='', ls_columna='', ls_columna1=''
	
if keydown(keycontrol!) and keydown(keyN!) then
	ls_dw = this.DataObject
	Clipboard(ls_dw)
	ls_columna = GetColumnName()
	ls_columna1 = describe('#'+string(GetColumn())+'.dbname')
	if isnull(ls_columna) or trim(ls_columna) = '' then return
	if isnull(ls_columna1) or trim(ls_columna1) = '' then return
	if trim(ls_columna) = trim(ls_columna1) then
		MessageBox('NOMBRE DEL DATAWINDOW: '+ls_dw,'NOMBRE DE LA COLUMNA: '+ls_columna,&
			Information!)
	else
		MessageBox('NOMBRE DEL DATAWINDOW: '+ls_dw,'NOMBRE DE LA COLUMNA: '+ls_columna+&
					'~nNOMBRE EN LA BASE DE DATOS: '+ls_columna1)
	end if
end if

// Modificado por Gianni Araúz (30/05/2000)
// Para el caso de los reportes, sólo debe mostrar el nombre del DataWindow

if keydown(keycontrol!) and keydown(keyM!) then
	ls_dw = this.DataObject
	if isnull(ls_dw) or trim(ls_dw) = '' then return
	MessageBox('Usuario: '+str.usuario,'NOMBRE DEL DATAWINDOW: '+ls_dw,Information!)
end if

end event

type dw_2 from datawindow within w_in_padre
event ue_enter pbm_dwnprocessenter
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
event ue_mousemove pbm_mousemove
event ue_down pbm_dwnkey
boolean visible = false
integer x = 41
integer y = 76
integer width = 119
integer height = 108
integer taborder = 20
boolean bringtotop = true
boolean livescroll = true
end type

event ue_enter;send(handle(this),256,9,long(0,0))
return 1
end event

event ue_down;// Gianni Araúz (11/10/1999)
// Este script hace que aparezca el nombre del DataWindow Object y el nombre de la
// columna cuando se presionan las teclas "Control" y "N".


string		 ls_clase, ls_dw='', ls_columna='', ls_columna1=''
	
if keydown(keycontrol!) and keydown(keyN!) then
	ls_dw = this.DataObject
	Clipboard(ls_dw)
	ls_columna = GetColumnName()
	ls_columna1 = describe('#'+string(GetColumn())+'.dbname')
	if isnull(ls_columna) or trim(ls_columna) = '' then return
	if isnull(ls_columna1) or trim(ls_columna1) = '' then return
	if trim(ls_columna) = trim(ls_columna1) then
		MessageBox('NOMBRE DEL DATAWINDOW: '+ls_dw,'NOMBRE DE LA COLUMNA: '+ls_columna,&
			Information!)
	else
		MessageBox('NOMBRE DEL DATAWINDOW: '+ls_dw,'NOMBRE DE LA COLUMNA: '+ls_columna+&
					'~nNOMBRE EN LA BASE DE DATOS: '+ls_columna1)
	end if
end if

// Modificado por Gianni Araúz (30/05/2000)
// Para el caso de los reportes, sólo debe mostrar el nombre del DataWindow

if keydown(keycontrol!) and keydown(keyM!) then
	ls_dw = this.DataObject
	if isnull(ls_dw) or trim(ls_dw) = '' then return
	MessageBox('Usuario: '+str.usuario,'NOMBRE DEL DATAWINDOW: '+ls_dw,Information!)
end if

end event

event rowfocuschanged;///* Marca la linea selecionada con un color azul */
//dw.selectrow(0,false)
//dw.selectrow(getrow(),true)
end event

event itemchanged;ib_aceptar = true
gf_in_enabled_save(str.frame.GetActiveSheet().MenuName, True)
end event

type gb_ventana from groupbox within w_in_padre
integer x = 14
integer y = 772
integer width = 859
integer height = 116
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

