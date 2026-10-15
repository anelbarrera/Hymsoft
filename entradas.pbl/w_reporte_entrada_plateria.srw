//objectcomments Reporte de Transacciones de cuentas por cobrar
forward
global type w_reporte_entrada_plateria from w_cc_padre_reporte
end type
end forward

global type w_reporte_entrada_plateria from w_cc_padre_reporte
integer width = 3570
integer height = 1632
string title = "Reporte de Entrada de Plateria"
string menuname = "m_cc_principal_listados"
boolean resizable = true
windowtype windowtype = main!
long backcolor = 12639424
end type
global w_reporte_entrada_plateria w_reporte_entrada_plateria

type variables
str_rangofecha lstr_rangfech
end variables

on w_reporte_entrada_plateria.create
call super::create
if this.MenuName = "m_cc_principal_listados" then this.MenuID = create m_cc_principal_listados
end on

on w_reporte_entrada_plateria.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event resize;//Override
this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 278
gb_1.width  = this.width  - 60
gb_1.height = this.height - 200


st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180
this.SetRedraw(true)
end event

event ue_reg_anterior;//Override
dw.ScrollPriorPage( )
end event

event ue_siguiente_reg;call super::ue_siguiente_reg;//Override
dw.scrollNextpage()
end event

event ue_post_open;call super::ue_post_open;datetime ld_fecha1, ld_fecha2
integer li_grupo, li_ann
string ls_empresa, ls_grupo, ls_tran

ls_empresa = gf_dg_nombre_empresa()

lstr_rangfech = message.powerObjectParm

dw.SettransObject(sqlca)
ld_fecha1 = datetime(lstr_rangfech.fecha1)
ld_fecha2 = datetime(lstr_rangfech.fecha2)
li_ann = lstr_rangfech.ano

dw.Object.datawindow.print.preview = true

dw.retrieve(str.g_financiero,str.empresa, li_ann ) // ld_fecha1, ld_fecha2)

//dw.object.grupo.expression = "'"+ls_grupo+"'"
dw.object.empresanom.expression = "'"+ls_empresa+"'"
dw.object.titulo_fecha.expression = "'"+"Año " +string(li_ann)+"'"

//dw.object.titulo_fecha.expression = "'"+"Desde el " +gf_fecha_palabras(lstr_rangfech.fecha1)+" al "+gf_fecha_palabras(lstr_rangfech.fecha2)+"'"
//dw.object.rango_fecha.expression = "'"+gf_fecha_palabras(lstr_rangfech.fecha1)+"'"

end event

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

type st_ayuda from w_cc_padre_reporte`st_ayuda within w_reporte_entrada_plateria
end type

type st_nom_ventana from w_cc_padre_reporte`st_nom_ventana within w_reporte_entrada_plateria
boolean visible = false
integer y = 1380
end type

type dw_1 from w_cc_padre_reporte`dw_1 within w_reporte_entrada_plateria
integer x = 27
integer y = 56
integer width = 3465
string dataobject = "dw_reporte_entrada_plateria"
boolean hscrollbar = false
boolean hsplitscroll = false
end type

event dw_1::sqlpreview;sqlsyntax += lstr_rangfech.cadena

This.SetSqlPreview(sqlsyntax)
end event

event dw_1::clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto, ls_column
integer li_pos 

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

ls_column = dwo.name
if ls_column = "contrato" then
	
	if row = 0 then return
	
	str_secuencia_doc lstr_sec
	lstr_sec.sec_manual = dw_1.getitemstring(row,"contrato")
	opensheetwithparm(w_fixing, lstr_sec,str.frame,2,original!)
	
end if
end event

event dw_1::ue_microayuda;//override
//Para cuando pasa por encima del objeto
//Override
return

Integer li_pos, li_x, li_y,li_largo
String ls_objeto, ls_col

ls_objeto = This.GetObjectAtPointer()
li_pos = pos  (ls_objeto,"~t")
ls_col = left (ls_objeto, li_pos - 1)

//li_x	 = str.frame.GetActiveSheet ().PointerX () 
//li_largo = len("Haga click para ordenar por la Columna de " + this.describe(ls_col+".text"))*28


//li_y	 = str.frame.GetActiveSheet ().PointerY () - 200

// Dependiendo de la Columna el Mensaje de Ayuda varía
CHOOSE CASE ls_col
	CASE 'contrato'
		this.Modify("contrato.Font.Underline='1'")
		this.Modify("contrato.Color='7536640'")
	CASE ELSE
		this.Modify("contrato.Font.Underline='0'")
		this.Modify("contrato.Color='0'")
END CHOOSE
end event

type gb_1 from w_cc_padre_reporte`gb_1 within w_reporte_entrada_plateria
integer y = 4
integer width = 3515
integer height = 1348
long backcolor = 12639424
end type

