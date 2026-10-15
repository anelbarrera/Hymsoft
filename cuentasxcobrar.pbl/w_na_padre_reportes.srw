//objectcomments Ventana padre para los Reportes de Facturación
forward
global type w_na_padre_reportes from w_grampa_reportes
end type
end forward

global type w_na_padre_reportes from w_grampa_reportes
integer width = 2560
integer height = 1260
string menuname = "m_na_listado"
event ue_zoom_down ( )
event ue_zoom_up ( )
event ue_regla ( )
event ue_save_as ( )
end type
global w_na_padre_reportes w_na_padre_reportes

type variables
datawindow dw_impresion
end variables

forward prototypes
public subroutine wf_zoom (integer li_zoom)
end prototypes

event ue_zoom_down;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Zoom the display area of the datawindow down
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//lm_menu = this.menuid
//
//// Initialize li_factor to zero
//li_factor = 0
//
//if lm_menu.m_edicin.m_zoom1.m_20%.checked then 
string		ls_factor
integer		li_factor
m_na_rep		lm_menu

//Para que no mande error
if not isvalid(dw_impresion) then return

// get the current zoom
ls_factor = dw_impresion.Object.DataWindow.print.preview.zoom
li_factor = integer (ls_factor)

// only zoom down if magnification is greater than 20%
if li_factor >=40 and li_factor <= 100 then
	li_factor = li_factor - 20
else
	// if magnification is currently 200%, zoom down to 100%
	if li_factor = 200 then
		li_factor = 100
	end if
end if

// set the new zoom level
dw_impresion.Object.DataWindow.print.preview.zoom = li_factor


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Check/uncheck the zoom menu items
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
lm_menu = this.menuid

lm_menu.m_ventanas.m_zoom.m_20%.checked = false
lm_menu.m_ventanas.m_zoom.m_40%.checked = false
lm_menu.m_ventanas.m_zoom.m_60%.checked = false
lm_menu.m_ventanas.m_zoom.m_80%.checked = false
lm_menu.m_ventanas.m_zoom.m_100%.checked = false
lm_menu.m_ventanas.m_zoom.m_200%.checked = false

choose case li_factor

	case 20
		lm_menu.m_ventanas.m_zoom.m_20%.checked = true

	case 40
		lm_menu.m_ventanas.m_zoom.m_40%.checked = true

	case 60
		lm_menu.m_ventanas.m_zoom.m_60%.checked = true

	case 80
		lm_menu.m_ventanas.m_zoom.m_80%.checked = true

	case 100
		lm_menu.m_ventanas.m_zoom.m_100%.checked = true

	case 200
		lm_menu.m_ventanas.m_zoom.m_200%.checked = true

end choose

end event

event ue_zoom_up;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Zoom the display area of the datawindow down
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

string		ls_factor
integer		li_factor
m_na_rep		lm_menu

//Para que no mande error
if not isvalid(dw_impresion) then return


// get the current zoom
ls_factor = dw_impresion.Object.DataWindow.print.preview.zoom
li_factor = Integer (ls_factor)

// zoom up by a factor of 20% if current magnification is between 20% - 80%
if li_factor >=20 and li_factor <=80 then
	li_factor = li_factor + 20
else
	// if magnification is currently 100%, zoom to 200%
	if li_factor = 100 then
		li_factor = 200
	end if
end if

// set the new zoom level
dw_impresion.Object.DataWindow.print.preview.zoom = li_factor

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Check/uncheck the zoom menu items
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
lm_menu = this.menuid

lm_menu.m_ventanas.m_zoom.m_20%.checked = false
lm_menu.m_ventanas.m_zoom.m_40%.checked = false
lm_menu.m_ventanas.m_zoom.m_60%.checked = false
lm_menu.m_ventanas.m_zoom.m_80%.checked = false
lm_menu.m_ventanas.m_zoom.m_100%.checked = false
lm_menu.m_ventanas.m_zoom.m_200%.checked = false

choose case li_factor
	case 20
		lm_menu.m_ventanas.m_zoom.m_20%.checked = true
	case 40
		lm_menu.m_ventanas.m_zoom.m_40%.checked = true
	case 60
		lm_menu.m_ventanas.m_zoom.m_60%.checked = true
	case 80
		lm_menu.m_ventanas.m_zoom.m_80%.checked = true
	case 100
		lm_menu.m_ventanas.m_zoom.m_100%.checked = true
	case 200
		lm_menu.m_ventanas.m_zoom.m_200%.checked = true
end choose

end event

event ue_regla;//Si el DW de impresion tiene un datawindow asignado

//Para que no mande error
if not isvalid(dw_impresion) then return


if dw_impresion.DataObject <> "" then

	if dw_impresion.object.datawindow.print.preview.rulers = 'yes' then
		dw_impresion.object.datawindow.print.preview.rulers = 'no'
	else
		dw_impresion.object.datawindow.print.preview.rulers = 'yes'
	end if	

end if
end event

event ue_save_as;//
dw.saveas()
end event

public subroutine wf_zoom (integer li_zoom);//messagebox("","")
end subroutine

on w_na_padre_reportes.create
call super::create
if this.MenuName = "m_na_listado" then this.MenuID = create m_na_listado
end on

on w_na_padre_reportes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;/***************************/
//gf_center_win(This)
gf_acelerador()
/**************************/

dw = dw_1
dw_impresion = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()

//Configurar los Accesos
//mf_accesos(this.menuid, this)

This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)
str.frame.SetRedraw ( True )


end event

event ue_zoom;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Zoom the display size of the report to the size specified on the menu.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int			li_factor
m_na_rep		lm_menu

lm_menu = this.menuid

// Initialize li_factor to zero
li_factor = 0

//Para que no mande error
if not isvalid(dw_impresion) then return


if lm_menu.m_ventanas.m_zoom.m_20%.checked then 	
	li_factor = 20
elseif lm_menu.m_ventanas.m_zoom.m_40%.checked then
	li_factor = 40
elseif lm_menu.m_ventanas.m_zoom.m_60%.checked then
	li_factor = 60
elseif lm_menu.m_ventanas.m_zoom.m_80%.checked then
	li_factor = 80
elseif lm_menu.m_ventanas.m_zoom.m_100%.checked then
	li_factor = 100
elseif lm_menu.m_ventanas.m_zoom.m_200%.checked then
	li_factor = 200
end if

if li_factor > 0 Then
dw_impresion.Object.DataWindow.print.preview.zoom = li_factor
end if
end event

event ue_reg_anterior;dw.scrollpriorpage()
end event

event ue_siguiente_reg;dw.scrollnextpage()
end event

event ue_post_open;call super::ue_post_open;//Deshabilita el boton de impresión, hasta que recupere
//if isvalid(m_fa_padre) then m_fa_padre.m_archivo.m_imprimir.enabled = false

dw_impresion = dw
if isvalid(dw) then
		if dw.object.datawindow.print.preview="no" then &
										dw.object.datawindow.print.preview="yes"
end if

/*Alínea el nombre de la empresa a la izquierda o al centro*/

/*String ls_nomcia_centrar_m_izq = 'IZQUIERDO'

If dw_1.Describe("empresa.x") <> "?" And dw.Describe("empresa.x") <> "!" Then
	If pos(upper(str.nombre_empresa),'AFISA') > 0 Then ls_nomcia_centrar_m_izq = 'CENTRAR'

	If ls_nomcia_centrar_m_izq = 'CENTRAR' then
		dw_1.modify("empresa.alignment='2'")	// centro
	else
		dw_1.modify("empresa.alignment='0'")	// izquierda
	end if
end if
*/

end event

event key;if Key = KeyEscape! then
	this.postevent("close")
end if
end event

event resize;//OVERRIDE
this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 278
gb_1.width  = this.width  - 63
gb_1.height = this.height - 220


st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180
this.SetRedraw(true)


end event

event close;if isvalid(this) then close(this)
end event

event ue_sort;call super::ue_sort;dw.groupCalc()
end event

type st_ayuda from w_grampa_reportes`st_ayuda within w_na_padre_reportes
end type

type st_nom_ventana from w_grampa_reportes`st_nom_ventana within w_na_padre_reportes
boolean visible = false
integer x = 50
integer y = 992
long backcolor = 79416533
end type

type dw_1 from w_grampa_reportes`dw_1 within w_na_padre_reportes
event ue_escape pbm_dwescape
integer x = 50
integer y = 56
integer width = 2386
integer height = 876
end type

event dw_1::ue_escape;//close(Parent)
end event

event dw_1::rbuttondown;call super::rbuttondown;//m_rep.M_edicin.PopMenu(parent.PointerX( ), parent.PointerY( ))
end event

event dw_1::retrieveend;//Deshabilita el boton de imprimir si no ha recuperado
//if rowcount > 0 then
//	if isvalid(m_fa_padre) then
//	   m_fa_padre.m_archivo.m_imprimir.enabled = true
//	end if	
//else
//	if isvalid(m_fa_padre) then
//		m_fa_padre.m_archivo.m_imprimir.enabled = false
//	end if	
//end if


end event

type gb_1 from w_grampa_reportes`gb_1 within w_na_padre_reportes
integer x = 37
integer y = 12
integer width = 2423
integer height = 944
fontcharset fontcharset = ansi!
long backcolor = 79416533
end type

