//objectcomments Padre para los reportes del sistema de inventarios
forward
global type w_in_padre_reportes from w_grampa_reportes
end type
type gb_ventana from groupbox within w_in_padre_reportes
end type
type gb_2 from groupbox within w_in_padre_reportes
end type
type str_dw from structure within w_in_padre_reportes
end type
end forward

type str_dw from structure
	datawindow		dw
end type

global type w_in_padre_reportes from w_grampa_reportes
integer x = 0
integer y = 0
integer width = 2917
integer height = 1644
string title = ""
string menuname = "m_in_reportes"
long backcolor = 12632256
event ue_zoom_up ( )
event ue_zoom_down ( )
event ue_save_as ( )
event ue_zoom_dw_down ( )
gb_ventana gb_ventana
gb_2 gb_2
end type
global w_in_padre_reportes w_in_padre_reportes

type variables
datawindow str_dw

end variables

forward prototypes
public function string wf_nombre_dw (readonly datawindow dw_p)
public subroutine wf_centrar (readonly integer yes)
end prototypes

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

event ue_zoom_down;//messagebox('Zoom','DDd')
//dw.object.datawindow.print.preview.enable = false 
//dw.object.datawindow.zoom = 50
//
//messagebox('Zoom','DDd')

//Zoom the display area of the datawindow down//

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

event ue_zoom_dw_down;
//dw.object.datawindow.print.preview.enable = false 
//dw.object.datawindow.zoom = 50

//OpenWithParm(w_in_zoom, dw)

end event

public function string wf_nombre_dw (readonly datawindow dw_p);return(dw_p.dataobject)

end function

public subroutine wf_centrar (readonly integer yes);/* funcion para centrar las ventanas de reportes en el sistema */
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
if yes = 1 then this.y=li_posicion_y
/* fin de la funcion wf_centrar */

end subroutine

on w_in_padre_reportes.create
int iCurrent
call super::create
if this.MenuName = "m_in_reportes" then this.MenuID = create m_in_reportes
this.gb_ventana=create gb_ventana
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_ventana
this.Control[iCurrent+2]=this.gb_2
end on

on w_in_padre_reportes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_ventana)
destroy(this.gb_2)
end on

event activate;//m_in_padre.mf_in_activa_reporte(true)
wf_centrar(0)



end event

event open;call super::open;/* Se establece un tamaño especifico para todas las ventanas 
   heredadas de este padre */
integer i ,ii

this.width=2917
this.height=1645  


THIS.SetToolbar(1, true, alignattop!)
THIS.SetToolbarPos(1, 1, 50, false)
this.y=1

end event

event resize;//st_nom_ventana.y = newheight - (st_nom_ventana.height + 10)
//dw_1.Resize(newwidth - 150, newheight - 200)
//gb_1.Width = newwidth - 75
//gb_1.Height = newheight - 120
end event

event rbuttondown;call super::rbuttondown;messagebox('x',string(this.x))
messagebox('y',string(this.y))
messagebox('w',string(this.width))
messagebox('h',string(this.height))
end event

event ue_zoom;/* zoom the display size of the report to the size specifield on the menu*/

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

event ue_sort;call super::ue_sort;dw_1.groupcalc()
end event

type st_ayuda from w_grampa_reportes`st_ayuda within w_in_padre_reportes
end type

type st_nom_ventana from w_grampa_reportes`st_nom_ventana within w_in_padre_reportes
integer x = 27
integer y = 1364
end type

type dw_1 from w_grampa_reportes`dw_1 within w_in_padre_reportes
event ue_down pbm_dwnkey
integer x = 23
integer y = 44
integer width = 2811
integer height = 1264
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

event dw_1::ue_down;// Gianni Araúz (11/10/1999)
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

event dw_1::constructor;call super::constructor;/* Activa las opciones de print preview y reglas de la hoja de impresion
   en el dw_1 de las ventanas que se herreden de este padre */
	dw=this
dw.object.datawindow.print.preview ="yes"
dw.object.datawindow.print.preview.zoom =100
//dw.object.datawindow.print.preview.rulers ="yes"
end event

type gb_1 from w_grampa_reportes`gb_1 within w_in_padre_reportes
boolean visible = false
integer x = 251
integer y = 404
integer width = 96
integer height = 132
integer taborder = 30
integer textsize = -10
integer weight = 400
borderstyle borderstyle = styleraised!
end type

type gb_ventana from groupbox within w_in_padre_reportes
integer x = 18
integer y = 1324
integer width = 1271
integer height = 104
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_in_padre_reportes
integer x = 9
integer width = 2843
integer height = 1324
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

