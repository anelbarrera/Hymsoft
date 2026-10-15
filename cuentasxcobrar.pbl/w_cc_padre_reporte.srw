//objectcomments Ventana padre de reportes de cuentas por cobrar
forward
global type w_cc_padre_reporte from w_grampa_reportes
end type
end forward

global type w_cc_padre_reporte from w_grampa_reportes
integer x = 0
integer y = 0
integer width = 3282
integer height = 1524
boolean resizable = false
windowtype windowtype = response!
event ue_zoom_down ( )
event ue_zoom_up ( )
event ue_save_as ( )
end type
global w_cc_padre_reporte w_cc_padre_reporte

type variables
String is_ultima, is_orden
n_cst_winsrv_shell32	nv_f
end variables

event ue_zoom_down;call super::ue_zoom_down;//Zoom the display area of the datawindow down//

string ls_factor
integer li_factor
m_cc_principal_listados  lm_menu

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

lm_menu.m_ventana.m_zoom.m_20%.checked = false
lm_menu.m_ventana.m_zoom.m_40%.checked = false
lm_menu.m_ventana.m_zoom.m_60%.checked = false
lm_menu.m_ventana.m_zoom.m_80%.checked = false
lm_menu.m_ventana.m_zoom.m_100%.checked = false
lm_menu.m_ventana.m_zoom.m_200%.checked = false

choose case li_factor
	case 20
		lm_menu.m_ventana.m_zoom.m_20%.checked = true
	case 40
		lm_menu.m_ventana.m_zoom.m_40%.checked = true
	case 60
		lm_menu.m_ventana.m_zoom.m_60%.checked = true
	case 80
		lm_menu.m_ventana.m_zoom.m_80%.checked = true
	case 100
		lm_menu.m_ventana.m_zoom.m_100%.checked = true
	case 200
		lm_menu.m_ventana.m_zoom.m_200%.checked = true
end choose

end event

event ue_zoom_up;call super::ue_zoom_up;////Zoom the display area of the datawindow down//

string ls_factor
integer li_factor
m_cc_principal_listados  lm_menu

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

lm_menu.m_ventana.m_zoom.m_20%.checked = false
lm_menu.m_ventana.m_zoom.m_40%.checked = false
lm_menu.m_ventana.m_zoom.m_60%.checked = false
lm_menu.m_ventana.m_zoom.m_80%.checked = false
lm_menu.m_ventana.m_zoom.m_100%.checked = false
lm_menu.m_ventana.m_zoom.m_200%.checked = false

choose case li_factor
	case 20
		lm_menu.m_ventana.m_zoom.m_20%.checked = true
	case 40
		lm_menu.m_ventana.m_zoom.m_40%.checked = true
	case 60
		lm_menu.m_ventana.m_zoom.m_60%.checked = true
	case 80
		lm_menu.m_ventana.m_zoom.m_80%.checked = true
	case 100
		lm_menu.m_ventana.m_zoom.m_100%.checked = true
	case 200
		lm_menu.m_ventana.m_zoom.m_200%.checked = true
end choose
		
end event

event ue_save_as();integer li_respuesta
string ls_path
//ls_title = this.title

li_respuesta = gf_mensaje('','Yes = Salvar a Excel, No = Otro Formato o Cancelar',4,1,'Q')
choose case li_respuesta
	case 1
		ls_path = nv_f.of_browseforfolder("Guardar Excel en ..",true)
		If Len(Trim(ls_path)) > 0 then		
			uf_save_dw_as_excel(dw,ls_path+'\'+this.title+'.xls')
		End If
	case 2
		dw.saveas()
end choose

end event

on w_cc_padre_reporte.create
call super::create
end on

on w_cc_padre_reporte.destroy
call super::destroy
end on

event open;call super::open;/* Se establece un tamaño especifico para todas las ventanas 
   heredadas de este padre */
//integer i ,ii
sqlca.autocommit = true
this.y=1
this.x=1
//this.width=3000
//this.height=1557
//

THIS.SetToolbar(1, true, alignattop!)
THIS.SetToolbarPos(1, 1, 50, false)

if isnull(m_cc_principal) then ChangeMenu(m_cc_principal) 
m_cc_principal.m_archivo.m_guardar.ToolbarItemVisible= false

m_cc_principal.m_edicin.m_registroanterior.ToolbarItemVisible= false                                   
m_cc_principal.m_edicin.m_siguienteregistro.ToolbarItemVisible= false
m_cc_principal.m_edicin.m_primerregistro.ToolbarItemVisible= false
m_cc_principal.m_edicin.m_ultimoregistro.ToolbarItemVisible= false
end event

event rbuttondown;//messagebox('x',string(this.x))
//messagebox('y',string(this.y))
//messagebox('w',string(this.width))
//messagebox('h',string(this.height))

end event

event resize;call super::resize;//gf_in_centrar_dw(this,dw,gb_2,gb_ventana,st_nom_ventana)
end event

event ue_zoom;call super::ue_zoom;///* zoom the display size of the report to the size specifield on the menu*/
//
//int li_factor
//m_cc_principal_listados  lm_menu
//
//lm_menu = this.menuid
//
////Initialize li_factor to zero
//li_factor = 0
//
//if lm_menu.m_ventana.m_zoom.m_20%.checked then
//	li_factor = 20
//elseif lm_menu.m_ventana.m_zoom.m_40%.checked then
//	li_factor = 40
//elseif lm_menu.m_ventana.m_zoom.m_60%.checked then
//	li_factor = 60
//elseif lm_menu.m_ventana.m_zoom.m_80%.checked then
//	li_factor = 80
//elseif lm_menu.m_ventana.m_zoom.m_100%.checked then
//	li_factor = 100
//elseif lm_menu.m_ventana.m_zoom.m_200%.checked then
//	li_factor = 200
//end if
//
//if li_factor > 0 then dw.object.datawindow.print.preview.zoom = li_factor

opensheetwithParm(w_zoom,dw_1,this,1,Original!)

end event

event ue_vista;call super::ue_vista;dw.Object.datawindow.print.preview.rulers = 'yes'

dw.Object.datawindow.print.preview.zoom = 50


end event

event key;If Key = keyEscape! then
	this.postevent("close")
End if
end event

event ue_filter;call super::ue_filter;//OpenWithParm(w_cc_filtrar,dw_1)
dw_1.groupcalc ()
end event

event close;close(this)

end event

event ue_sort;call super::ue_sort;dw_1.groupcalc ()
end event

type st_ayuda from w_grampa_reportes`st_ayuda within w_cc_padre_reporte
end type

type st_nom_ventana from w_grampa_reportes`st_nom_ventana within w_cc_padre_reporte
integer x = 27
integer y = 1352
fontcharset fontcharset = ansi!
long backcolor = 78682240
end type

type dw_1 from w_grampa_reportes`dw_1 within w_cc_padre_reporte
integer x = 23
integer y = 32
integer width = 3205
integer height = 1264
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type gb_1 from w_grampa_reportes`gb_1 within w_cc_padre_reporte
integer x = 5
integer y = 0
integer width = 3250
integer height = 1312
fontcharset fontcharset = ansi!
long backcolor = 78682240
end type

