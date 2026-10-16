//objectcomments Reporte de Transacciones de cuentas por cobrar
forward
global type w_reporte_transacciones_cp from w_cc_padre_reporte
end type
end forward

global type w_reporte_transacciones_cp from w_cc_padre_reporte
string tag = "m_cc_principal_listados"
integer width = 3570
integer height = 1556
string title = "Informe de Pagos"
boolean controlmenu = false
boolean resizable = true
windowtype windowtype = main!
long backcolor = 12639424
end type
global w_reporte_transacciones_cp w_reporte_transacciones_cp

type variables
str_rangofecha lstr_rangfech
end variables

on w_reporte_transacciones_cp.create
call super::create
end on

on w_reporte_transacciones_cp.destroy
call super::destroy
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
string ls_empresa, ls_grupo, ls_tran

ls_empresa = gf_dg_nombre_empresa()

lstr_rangfech = message.powerObjectParm

select max(mser_descripcion) into :ls_tran from dgmserie where 
mser_g_financiero = : str.g_financiero and mser_empresa = : str.empresa and mser_tipo_transaccion = :lstr_rangfech.movimiento ;
if sqlca.sqlcode = -1 then
	gf_mensaje('','Error al seleccionar descripcion de la transaccion',1,1,'E')
end if

ld_fecha1 = datetime(lstr_rangfech.fecha1)
ld_fecha2 = datetime(lstr_rangfech.fecha2)

if lstr_rangfech.tipo_reporte = 0 then //Por transacciones
	this.title = 'INFORME DE ' + ls_tran
	if lstr_rangfech.movimiento = 'FF' then
		dw_1.dataobject = 'dw_reporte_de_tran_cxp_fac'
	else
		dw_1.dataobject = 'dw_reporte_de_tran_cxp'
	end if
	dw.SettransObject(sqlca)
	dw.retrieve(str.g_financiero,str.empresa, ld_fecha1, ld_fecha2, lstr_rangfech.movimiento, ls_tran)		
else												//Todas las Transacciones
	 if lstr_rangfech.opcion_reporte = 'BALANCE' then
	 	this.title = 'Balance de Prueba - Proveedores'
		dw_1.dataobject = 'dw_balance_prueba_cxp'
	 else
		this.title = 'INFORME DE TRANSACCIONES DE PROVEEDORES'
		dw_1.dataobject = 'dw_reporte_de_tran_cxp_todas'
	 end if
	dw.SettransObject(sqlca)
	dw.retrieve(str.g_financiero,str.empresa, ld_fecha1, ld_fecha2)		
end if
dw.Object.datawindow.print.preview = true

//dw.object.grupo.expression = "'"+ls_grupo+"'"
dw.object.empresanom.expression = "'"+ls_empresa+"'"
dw.object.rango_fecha.expression = "'"+"Desde el " +gf_fecha_palabras(lstr_rangfech.fecha1)+" al "+gf_fecha_palabras(lstr_rangfech.fecha2)+"'"

//dw.object.rango_fecha.expression = "'"+gf_fecha_palabras(lstr_rangfech.fecha1)+"'"

end event

event ue_zoom_down;//Zoom the display area of the datawindow down//

string ls_factor
integer li_factor
m_fa_rep  lm_menu

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

event open;//override
/* Se establece un tamaño especifico para todas las ventanas 
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

//if isnull(m_fa_rep) then ChangeMenu(m_fa_rep) 
//m_cc_principal.m_archivo.m_guardar.ToolbarItemVisible= false
//
//m_cc_principal.m_edicin.m_registroanterior.ToolbarItemVisible= false                                   
//m_cc_principal.m_edicin.m_siguienteregistro.ToolbarItemVisible= false
//m_cc_principal.m_edicin.m_primerregistro.ToolbarItemVisible= false
//m_cc_principal.m_edicin.m_ultimoregistro.ToolbarItemVisible= false

This.Icon = str.icono
this.postevent("ue_post_open")
end event

event ue_zoom_up;////Zoom the display area of the datawindow down//

string ls_factor
integer li_factor
m_Fa_rep  lm_menu

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

type st_ayuda from w_cc_padre_reporte`st_ayuda within w_reporte_transacciones_cp
end type

type st_nom_ventana from w_cc_padre_reporte`st_nom_ventana within w_reporte_transacciones_cp
boolean visible = false
integer y = 1380
end type

type dw_1 from w_cc_padre_reporte`dw_1 within w_reporte_transacciones_cp
integer x = 27
integer y = 56
integer width = 3465
string dataobject = "dw_reporte_de_tran_cxp"
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
long ll_tercero
date fecha, fecha1

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if right(ls_objeto,2)='_t' then

	ls_objeto = left(ls_objeto,len(ls_objeto)-2)
	
	if ls_objeto = is_ultima or is_ultima = "" then	//Si es la misma columna 
																	// o si es la primera vez
		if is_orden  = "" or is_orden = "D" then
			is_orden = 'A'		
			this.SetSort(ls_objeto+" A")	//Ordena Ascendente
			this.sort()		
		else
			is_orden = 'D'					
			this.SetSort(ls_objeto+" D")	//Ordena Descendente
			this.sort()				
		end if	
		is_ultima = ls_objeto		
	else				
			is_orden = 'A'
			this.SetSort(ls_objeto+" A")
			this.sort()
			is_ultima = ls_objeto
	end if

end if
ls_column = dwo.name
if ls_column = "movi_documento" then
	
	if row = 0 then return
	
	str_secuencia_doc lstr_sec
	lstr_sec.ano = dw_1.getitemNumber(row,"movi_anno")
	lstr_sec.sec_manual = dw_1.getitemstring(row,"movi_documento")
	lstr_sec.tran	= dw_1.getitemstring(row,"movi_tipo_transaccion")
	lstr_sec.subtran	= dw_1.getitemstring(row,"movi_sub_transaccion")	
	lstr_sec.referencia	 = dw_1.getitemstring(row,"movi_referencia")
//	if this.getitemstring(row,'movi_aplicacion') = 'BA' then
//		gf_mensaje('','Transaccion de Bancos',1,1,'E')
//	else
		opensheetwithparm(w_consulta_transacciones_cxp, lstr_sec,str.frame,2,original!)
//	end if
	
elseif ls_column = 'dgmterce_terc_descripcion' then
	str_rangofecha str_formato1		
   str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	
	datetime ldt_fecha_saldos
	ll_tercero = dw_1.getitemnumber(row,'cptmovim_movi_tercero')
	fecha	= relativedate(date(gf_fecha_serv()), - 365)
//	fecha = date('01/01/'+string(year(date(gf_fecha_serv()))))
	fecha1 = date(gf_fecha_serv())
	
  SELECT cpmparam.para_fecha_inicio  
    INTO :ldt_fecha_saldos  
    FROM cpmparam  
   WHERE ( cpmparam.para_g_financiero = :str.g_financiero ) AND  
         ( cpmparam.para_empresa = :str.empresa )  ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al buscar fecha '+sqlca.sqlerrtext,1,1,'E')
			return
		end if
	
	if fecha < date(ldt_fecha_saldos) then
		fecha = relativedate(date(ldt_fecha_saldos), 1)
	end if
		
	str_formato1.codigo = ll_tercero
	str_formato1.fecha1  = fecha
	str_formato1.fecha2  = fecha1
	
	Opensheetwithparm(w_estadocuenta_imp_cxp,str_formato1,str.frame,2,Layered!)
	
end if
end event

event dw_1::ue_microayuda;//override
//Para cuando pasa por encima del objeto
//Override
end event

type gb_1 from w_cc_padre_reporte`gb_1 within w_reporte_transacciones_cp
integer y = 4
integer width = 3515
integer height = 1348
long backcolor = 12639424
end type

