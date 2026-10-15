//objectcomments Reporte de Transacciones de cuentas por cobrar
forward
global type w_asignar_privilegios_de_acceso from w_cc_padre_reporte
end type
type cb_1 from commandbutton within w_asignar_privilegios_de_acceso
end type
type cb_2 from commandbutton within w_asignar_privilegios_de_acceso
end type
end forward

global type w_asignar_privilegios_de_acceso from w_cc_padre_reporte
integer width = 4457
integer height = 2552
string title = "Privilegios de Acceso al Sistema"
string menuname = "m_cc_principal_listados"
boolean resizable = true
windowtype windowtype = main!
long backcolor = 12639424
windowanimationstyle openanimation = leftslide!
windowanimationstyle closeanimation = centeranimation!
cb_1 cb_1
cb_2 cb_2
end type
global w_asignar_privilegios_de_acceso w_asignar_privilegios_de_acceso

type variables
str_rangofecha lstr_rangfech
end variables

on w_asignar_privilegios_de_acceso.create
int iCurrent
call super::create
if this.MenuName = "m_cc_principal_listados" then this.MenuID = create m_cc_principal_listados
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
end on

on w_asignar_privilegios_de_acceso.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.cb_2)
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
integer li_grupo
string ls_empresa, ls_grupo, ls_tran, ls_usuario
integer li_opcion11,  li_opcion12,   li_opcion13,  li_opcion14,  li_opcion15,  li_opcion16,  li_opcion17,   li_opcion18,   li_opcion19,   li_opcion110,   li_opcion21,   &
       li_opcion22,   li_opcion23,   li_opcion24,   li_opcion25,   li_opcion26,   li_opcion27,   li_opcion28,   li_opcion29,   li_opcion210,   li_opcion31,   li_opcion32,   li_opcion33,   &
	  li_opcion34,   li_opcion35,   li_opcion36,   li_opcion37,   li_opcion38,   li_opcion39,   li_opcion310,   li_opcion311,   li_opcion312,   li_opcion313,   li_opcion314,   li_opcion315,   li_opcion41,   &
       li_opcion42,  li_opcion43,   li_opcion44,   li_opcion45,   li_opcion46,   li_opcion47,   li_opcion48,   li_opcion49,   li_opcion410,   li_opcion411,   li_opcion412,   li_opcion413,   li_opcion414,   &
       li_opcion415,   li_opcion416,   li_opcion417,   li_opcion418,   li_opcion419,   li_opcion420,   li_opcion51  

ls_empresa = gf_dg_nombre_empresa()

//lstr_rangfech = message.powerObjectParm

dw.SettransObject(sqlca)

ls_usuario = message.StringParm

dw_1.retrieve(str.g_financiero, str.empresa, ls_usuario)

this.title = 'Privilegios de Acceso al Sistema  - Usuario '+ls_usuario

/*  SELECT usuarios_accesos.priv_opcion11,   
         usuarios_accesos.priv_opcion12,   
         usuarios_accesos.priv_opcion13,   
         usuarios_accesos.priv_opcion14,   
         usuarios_accesos.priv_opcion15,   
         usuarios_accesos.priv_opcion16,   
         usuarios_accesos.priv_opcion17,   
         usuarios_accesos.priv_opcion18,   
         usuarios_accesos.priv_opcion19,   
         usuarios_accesos.priv_opcion110,   
         usuarios_accesos.priv_opcion21,   
         usuarios_accesos.priv_opcion22,   
         usuarios_accesos.priv_opcion23,   
         usuarios_accesos.priv_opcion24,   
         usuarios_accesos.priv_opcion25,   
         usuarios_accesos.priv_opcion26,   
         usuarios_accesos.priv_opcion27,   
         usuarios_accesos.priv_opcion28,   
         usuarios_accesos.priv_opcion29,   
         usuarios_accesos.priv_opcion210,   
         usuarios_accesos.priv_opcion31,   
         usuarios_accesos.priv_opcion32,   
         usuarios_accesos.priv_opcion33,   
         usuarios_accesos.priv_opcion34,   
         usuarios_accesos.priv_opcion35,   
         usuarios_accesos.priv_opcion36,   
         usuarios_accesos.priv_opcion37,   
         usuarios_accesos.priv_opcion38,   
         usuarios_accesos.priv_opcion39,   
         usuarios_accesos.priv_opcion310,   
         usuarios_accesos.priv_opcion311,   
         usuarios_accesos.priv_opcion312,   
         usuarios_accesos.priv_opcion313,   
         usuarios_accesos.priv_opcion314,   
         usuarios_accesos.priv_opcion315,   
         usuarios_accesos.priv_opcion41,   
         usuarios_accesos.priv_opcion42,   
         usuarios_accesos.priv_opcion43,   
         usuarios_accesos.priv_opcion44,   
         usuarios_accesos.priv_opcion45,   
         usuarios_accesos.priv_opcion46,   
         usuarios_accesos.priv_opcion47,   
         usuarios_accesos.priv_opcion48,   
         usuarios_accesos.priv_opcion49,   
         usuarios_accesos.priv_opcion410,   
         usuarios_accesos.priv_opcion411,   
         usuarios_accesos.priv_opcion412,   
         usuarios_accesos.priv_opcion413,   
         usuarios_accesos.priv_opcion414,   
         usuarios_accesos.priv_opcion415,   
         usuarios_accesos.priv_opcion416,   
         usuarios_accesos.priv_opcion417,   
         usuarios_accesos.priv_opcion418,   
         usuarios_accesos.priv_opcion419,   
         usuarios_accesos.priv_opcion420,   
         usuarios_accesos.priv_opcion51  
    INTO :li_opcion11,   
         :li_opcion12,   
         :li_opcion13,   
         :li_opcion14,   
         :li_opcion15,   
         :li_opcion16,   
         :li_opcion17,   
         :li_opcion18,   
         :li_opcion19,   
         :li_opcion110,   
         :li_opcion21,   
         :li_opcion22,   
         :li_opcion23,   
         :li_opcion24,   
         :li_opcion25,   
         :li_opcion26,   
         :li_opcion27,   
         :li_opcion28,   
         :li_opcion29,   
         :li_opcion210,   
         :li_opcion31,   
         :li_opcion32,   
         :li_opcion33,   
         :li_opcion34,   
         :li_opcion35,   
         :li_opcion36,   
         :li_opcion37,   
         :li_opcion38,   
         :li_opcion39,   
         :li_opcion310,   
         :li_opcion311,   
         :li_opcion312,   
         :li_opcion313,   
         :li_opcion314,   
         :li_opcion315,   
         :li_opcion41,   
         :li_opcion42,   
         :li_opcion43,   
         :li_opcion44,   
         :li_opcion45,   
         :li_opcion46,   
         :li_opcion47,   
         :li_opcion48,   
         :li_opcion49,   
         :li_opcion410,   
         :li_opcion411,   
         :li_opcion412,   
         :li_opcion413,   
         :li_opcion414,   
         :li_opcion415,   
         :li_opcion416,   
         :li_opcion417,   
         :li_opcion418,   
         :li_opcion419,   
         :li_opcion420,   
         :li_opcion51  
    FROM usuarios_accesos  
   WHERE ( usuarios_accesos.priv_g_financiero = :str.g_financiero ) AND  
         ( usuarios_accesos.priv_empresa = :str.empresa ) AND  
         ( usuarios_accesos.priv_usuario = :ls_usuario )   ;
	if sqlca.sqlcode = -1 then 
		gf_mensaje('','Error al buscar accesos '+ sqlca.sqlerrtext,1,1,'E')
	end if
	
*/	
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

event open;call super::open;this.y = 0
this.x = 805
end event

type st_ayuda from w_cc_padre_reporte`st_ayuda within w_asignar_privilegios_de_acceso
end type

type st_nom_ventana from w_cc_padre_reporte`st_nom_ventana within w_asignar_privilegios_de_acceso
boolean visible = false
integer y = 1380
end type

type dw_1 from w_cc_padre_reporte`dw_1 within w_asignar_privilegios_de_acceso
integer x = 27
integer y = 56
integer width = 4361
integer height = 2252
string dataobject = "dw_privilegios_de_usuarios"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
boolean hsplitscroll = false
boolean livescroll = false
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
if ls_column = "b_cerrar" then
	close(parent)	
end if
end event

event dw_1::ue_microayuda;//override
//Para cuando pasa por encima del objeto
//Override

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

type gb_1 from w_cc_padre_reporte`gb_1 within w_asignar_privilegios_de_acceso
integer y = 4
integer width = 4398
integer height = 2316
long backcolor = 12639424
end type

type cb_1 from commandbutton within w_asignar_privilegios_de_acceso
integer x = 37
integer y = 2148
integer width = 466
integer height = 76
integer taborder = 11
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Todos los Accesos"
end type

event clicked;dw_1.setitem(1,'priv_opcion11',1)
dw_1.setitem(1,'priv_opcion12',1)
dw_1.setitem(1,'priv_opcion13',1)
dw_1.setitem(1,'priv_opcion14',1)
dw_1.setitem(1,'priv_opcion15',1)
dw_1.setitem(1,'priv_opcion16',1)
dw_1.setitem(1,'priv_opcion17',1)
dw_1.setitem(1,'priv_opcion18',1)
dw_1.setitem(1,'priv_opcion19',1)
dw_1.setitem(1,'priv_opcion110',1)
dw_1.setitem(1,'priv_opcion111',1)
dw_1.setitem(1,'priv_opcion21',1)
dw_1.setitem(1,'priv_opcion22',1)
dw_1.setitem(1,'priv_opcion23',1)
dw_1.setitem(1,'priv_opcion24',1)
dw_1.setitem(1,'priv_opcion25',1)
dw_1.setitem(1,'priv_opcion26',1)
dw_1.setitem(1,'priv_opcion27',1)
dw_1.setitem(1,'priv_opcion28',1)
dw_1.setitem(1,'priv_opcion29',1)
dw_1.setitem(1,'priv_opcion210',1)
dw_1.setitem(1,'priv_opcion211',1)
dw_1.setitem(1,'priv_opcion212',1)
dw_1.setitem(1,'priv_opcion213',1)

dw_1.setitem(1,'priv_opcion31',1)
dw_1.setitem(1,'priv_opcion32',1)
dw_1.setitem(1,'priv_opcion33',1)
dw_1.setitem(1,'priv_opcion34',1)
dw_1.setitem(1,'priv_opcion35',1)
dw_1.setitem(1,'priv_opcion36',1)
dw_1.setitem(1,'priv_opcion37',1)
dw_1.setitem(1,'priv_opcion38',1)
dw_1.setitem(1,'priv_opcion39',1)
dw_1.setitem(1,'priv_opcion310',1)
dw_1.setitem(1,'priv_opcion311',1)
dw_1.setitem(1,'priv_opcion312',1)
dw_1.setitem(1,'priv_opcion313',1)
dw_1.setitem(1,'priv_opcion314',1)
dw_1.setitem(1,'priv_opcion315',1)
dw_1.setitem(1,'priv_opcion41',1)
dw_1.setitem(1,'priv_opcion42',1)
dw_1.setitem(1,'priv_opcion43',1)
dw_1.setitem(1,'priv_opcion44',1)
dw_1.setitem(1,'priv_opcion45',1)
dw_1.setitem(1,'priv_opcion46',1)
dw_1.setitem(1,'priv_opcion47',1)
dw_1.setitem(1,'priv_opcion48',1)
dw_1.setitem(1,'priv_opcion49',1)
dw_1.setitem(1,'priv_opcion410',1)
dw_1.setitem(1,'priv_opcion411',1)
dw_1.setitem(1,'priv_opcion412',1)
dw_1.setitem(1,'priv_opcion51',1)
dw_1.setitem(1,'priv_opcion52',1)
dw_1.setitem(1,'priv_opcion53',1)
dw_1.setitem(1,'priv_opcion54',1)
dw_1.setitem(1,'priv_opcion55',1)
dw_1.setitem(1,'priv_opcion56',1)
dw_1.setitem(1,'priv_opcion57',1)
dw_1.setitem(1,'priv_opcion58',1)
dw_1.setitem(1,'priv_opcion59',1)
dw_1.setitem(1,'priv_opcion510',1)
dw_1.setitem(1,'priv_opcion511',1)
dw_1.setitem(1,'priv_opcion512',1)
dw_1.setitem(1,'priv_opcion513',1)
dw_1.setitem(1,'priv_opcion514',1)
dw_1.setitem(1,'priv_opcion515',1)
dw_1.setitem(1,'priv_opcion61',1)
dw_1.setitem(1,'priv_opcion62',1)
dw_1.setitem(1,'priv_opcion63',1)
dw_1.setitem(1,'priv_opcion64',1)
dw_1.setitem(1,'priv_opcion65',1)
dw_1.setitem(1,'priv_opcion66',1)
dw_1.setitem(1,'priv_opcion67',1)
dw_1.setitem(1,'priv_opcion68',1)
dw_1.setitem(1,'priv_opcion69',1)
dw_1.setitem(1,'priv_opcion610',1)
end event

type cb_2 from commandbutton within w_asignar_privilegios_de_acceso
integer x = 37
integer y = 2228
integer width = 466
integer height = 76
integer taborder = 21
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Quitar Accesos"
end type

event clicked;dw_1.setitem(1,'priv_opcion11',0)
dw_1.setitem(1,'priv_opcion12',0)
dw_1.setitem(1,'priv_opcion13',0)
dw_1.setitem(1,'priv_opcion14',0)
dw_1.setitem(1,'priv_opcion15',0)
dw_1.setitem(1,'priv_opcion16',0)
dw_1.setitem(1,'priv_opcion17',0)
dw_1.setitem(1,'priv_opcion18',0)
dw_1.setitem(1,'priv_opcion19',0)
dw_1.setitem(1,'priv_opcion110',0)
dw_1.setitem(1,'priv_opcion111',0)
dw_1.setitem(1,'priv_opcion21',0)
dw_1.setitem(1,'priv_opcion22',0)
dw_1.setitem(1,'priv_opcion23',0)
dw_1.setitem(1,'priv_opcion24',0)
dw_1.setitem(1,'priv_opcion25',0)
dw_1.setitem(1,'priv_opcion26',0)
dw_1.setitem(1,'priv_opcion27',0)
dw_1.setitem(1,'priv_opcion28',0)
dw_1.setitem(1,'priv_opcion29',0)
dw_1.setitem(1,'priv_opcion210',0)
dw_1.setitem(1,'priv_opcion211',0)
dw_1.setitem(1,'priv_opcion212',0)
dw_1.setitem(1,'priv_opcion213',0)


dw_1.setitem(1,'priv_opcion31',0)
dw_1.setitem(1,'priv_opcion32',0)
dw_1.setitem(1,'priv_opcion33',0)
dw_1.setitem(1,'priv_opcion34',0)
dw_1.setitem(1,'priv_opcion35',0)
dw_1.setitem(1,'priv_opcion36',0)
dw_1.setitem(1,'priv_opcion37',0)
dw_1.setitem(1,'priv_opcion38',0)
dw_1.setitem(1,'priv_opcion39',0)
dw_1.setitem(1,'priv_opcion310',0)
dw_1.setitem(1,'priv_opcion311',0)
dw_1.setitem(1,'priv_opcion312',0)
dw_1.setitem(1,'priv_opcion313',0)
dw_1.setitem(1,'priv_opcion314',0)
dw_1.setitem(1,'priv_opcion315',0)
dw_1.setitem(1,'priv_opcion41',0)
dw_1.setitem(1,'priv_opcion42',0)
dw_1.setitem(1,'priv_opcion43',0)
dw_1.setitem(1,'priv_opcion44',0)
dw_1.setitem(1,'priv_opcion45',0)
dw_1.setitem(1,'priv_opcion46',0)
dw_1.setitem(1,'priv_opcion47',0)
dw_1.setitem(1,'priv_opcion48',0)
dw_1.setitem(1,'priv_opcion49',0)
dw_1.setitem(1,'priv_opcion410',0)
dw_1.setitem(1,'priv_opcion411',0)
dw_1.setitem(1,'priv_opcion412',0)
dw_1.setitem(1,'priv_opcion51',0)
dw_1.setitem(1,'priv_opcion52',0)
dw_1.setitem(1,'priv_opcion53',0)
dw_1.setitem(1,'priv_opcion54',0)
dw_1.setitem(1,'priv_opcion55',0)
dw_1.setitem(1,'priv_opcion56',0)
dw_1.setitem(1,'priv_opcion57',0)
dw_1.setitem(1,'priv_opcion58',0)
dw_1.setitem(1,'priv_opcion59',0)
dw_1.setitem(1,'priv_opcion510',0)
dw_1.setitem(1,'priv_opcion511',0)
dw_1.setitem(1,'priv_opcion512',0)
dw_1.setitem(1,'priv_opcion513',0)
dw_1.setitem(1,'priv_opcion514',0)
dw_1.setitem(1,'priv_opcion515',0)
dw_1.setitem(1,'priv_opcion61',0)
dw_1.setitem(1,'priv_opcion62',0)
dw_1.setitem(1,'priv_opcion63',0)
dw_1.setitem(1,'priv_opcion64',0)
dw_1.setitem(1,'priv_opcion65',0)
dw_1.setitem(1,'priv_opcion66',0)
dw_1.setitem(1,'priv_opcion67',0)
dw_1.setitem(1,'priv_opcion68',0)
dw_1.setitem(1,'priv_opcion69',0)
dw_1.setitem(1,'priv_opcion610',0)
end event

