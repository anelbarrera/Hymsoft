//objectcomments Reportes de Proveedores
forward
global type w_reporte_proveedores from w_fa_padre_reportes
end type
type st_1 from statictext within w_reporte_proveedores
end type
type dw_3 from uos_in_datawindow_utility within w_reporte_proveedores
end type
type gb_4 from gb_1 within w_reporte_proveedores
end type
type em_ann from editmask within w_reporte_proveedores
end type
type st_proveedor from statictext within w_reporte_proveedores
end type
type cb_buscar from commandbutton within w_reporte_proveedores
end type
type em_proveedor from editmask within w_reporte_proveedores
end type
type dw_2 from datawindow within w_reporte_proveedores
end type
end forward

global type w_reporte_proveedores from w_fa_padre_reportes
integer x = 5
integer y = 20
integer width = 5001
integer height = 2692
string title = "Reportes de Saldos de Proveedores"
long backcolor = 12639424
windowanimationstyle closeanimation = bottomroll!
event ue_buscar ( )
st_1 st_1
dw_3 dw_3
gb_4 gb_4
em_ann em_ann
st_proveedor st_proveedor
cb_buscar cb_buscar
em_proveedor em_proveedor
dw_2 dw_2
end type
global w_reporte_proveedores w_reporte_proveedores

type variables
string  is_tipo,is_pedido
integer ii_ann, ii_child_row
Long    il_proveedor

datawindowchild idw_child, idwc_grupo, idwc_region, idwc_tipo, idwc_cliente
end variables

forward prototypes
public subroutine wf_fecha ()
public subroutine wf_nofecha ()
public subroutine wf_insertar_cargos (long al_filas)
public function string wf_verificar (string ls_original)
public function string wf_armar_sql ()
public subroutine wf_control_de_totales (long al_rowcount)
public subroutine wf_normaliza_opcion1 (integer ai_opcion, string as_campo, datawindow ad_dw)
public function boolean wf_child_productos ()
end prototypes

public subroutine wf_fecha ();//dw_2.visible = false
//em_1.visible = True
//em_1.text = string(today())
//em_2.visible = True
//em_2.text = string(today())
//pb_1.visible = True
//st_2.visible = True
//st_3.visible = True
//em_1.setfocus()
//
end subroutine

public subroutine wf_nofecha ();//dw_2.visible = true
//em_1.visible = false
//em_2.visible = false
//pb_1.visible = false
//st_2.visible = false
//st_3.visible = false
//dw_2.setfocus()
//dw_2.SetColumn("Texto")
//
end subroutine

public subroutine wf_insertar_cargos (long al_filas);
end subroutine

public function string wf_verificar (string ls_original);//Se verifican las opciones de parámetros y se filtra
string ls_where
  
  if w_fa_fondo.str_para.mostrar <> 0 then  //mostrar un Año específico

	CHOOSE CASE w_fa_fondo.str_para.desde	//Si es desde el año en adelante o el año exclusivo.
		CASE 0

		 ls_where = ls_original + " where &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+" ) and &
					 (fatdiari.fact_ann = "+string(w_fa_fondo.str_para.mostrar)+" ) AND &
 					 ( fatdiari.fact_no_pedido not like '%NC%' )"	
		CASE 1
		 ls_where = ls_original + " where  &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+" ) and &
					 (fatdiari.fact_ann >= "+string(w_fa_fondo.str_para.mostrar)+" ) AND &
 					 ( fatdiari.fact_no_pedido not like '%NC%' )"		
	END CHOOSE			
	
  else
		 ls_where = ls_original + " where  &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+" ) AND &
 					 ( fatdiari.fact_no_pedido not like '%NC%' )"	
  end if
return(ls_where)
end function

public function string wf_armar_sql ();// Función que arma el Sql de el DataWindow, y dependiendo de donde se llama, factura o consultas
// Filtra segun parámetros iniciales o no
string ls_where, ls_original

ls_original = idw_child.GetsqlSelect()

ls_where = wf_verificar(ls_original)

return(ls_where)
end function

public subroutine wf_control_de_totales (long al_rowcount);
end subroutine

public subroutine wf_normaliza_opcion1 (integer ai_opcion, string as_campo, datawindow ad_dw);integer i, li_final = 3
string  ls_rectangulo, ls_cadena

for i = 1 to li_final
	ls_rectangulo = "r_"+string(i)
	if ai_opcion = i then	//Pantalla Principal
		//Pone el rectangulo visible
		ad_dw.Modify(ls_rectangulo+".Visible='1'")
		//Cambia el fondo a blanco				
		ad_dw.Modify("fondo"+string(i)+".Background.Color='"+string(w_fa_fondo.istr_colores.fondo_cursor)+"'")//'16777215'") //
		//Para el campo de titulo
		if as_campo = "o"+string(i)+"_titulo" then
			ad_dw.Modify("o"+string(i)+"_titulo.Font.Underline='1'")			
			//<0 - None, 1- Shadow, 2 - Box, 3 - Resize, 4 - Underline, 5 - 3D Lowered, 6 - 3D Raised>'")
		else
			ad_dw.Modify("o"+string(i)+"_titulo.Font.Underline='0'")						
		end if
		//Para el campo de opcion 1
		if as_campo = "o"+string(i)+"_opcion1" then
			ad_dw.Modify("o"+string(i)+"_opcion1.Font.Underline='1'")								
			ad_dw.Modify("o"+string(i)+"_opcion1.Border='6'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion1.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_principal)+"'")//'8388608'")//Azul intenso							
			else
				ad_dw.Modify("o"+string(i)+"_opcion1.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_lateral)+"'")//'16777215'")	//Color blanco							
			end if
		else
			ad_dw.Modify("o"+string(i)+"_opcion1.Font.Underline='0'")
			ad_dw.Modify("o"+string(i)+"_opcion1.Border='0'")
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion1.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'") //'16724224'")				
			else
				ad_dw.Modify("o"+string(i)+"_opcion1.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//'16777215'")	//Color blanco				
			end if
		end if
		//Para el campo de opcion 2
		if as_campo = "o"+string(i)+"_opcion2" then
			ad_dw.Modify("o"+string(i)+"_opcion2.Font.Underline='1'")			
			ad_dw.Modify("o"+string(i)+"_opcion2.Border='6'")			
			if ad_dw = dw_3 then			
				ad_dw.Modify("o"+string(i)+"_opcion2.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_principal)+"'")//'8388608'")
			else
				ad_dw.Modify("o"+string(i)+"_opcion2.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_lateral)+"'")//'16777215'")	//Color blanco
			end if
		else
			ad_dw.Modify("o"+string(i)+"_opcion2.Font.Underline='0'")			
			ad_dw.Modify("o"+string(i)+"_opcion2.Border='0'")
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion2.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'") //'16724224'")				
			else
				ad_dw.Modify("o"+string(i)+"_opcion2.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//'16777215'")	//Color blanco
			end if
		end if
		//Para el campo de opcion 3
		if as_campo = "o"+string(i)+"_opcion3" then
			ad_dw.Modify("o"+string(i)+"_opcion3.Font.Underline='1'")			
			ad_dw.Modify("o"+string(i)+"_opcion3.Border='6'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion3.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_principal)+"'")//'8388608'")								
			else
				ad_dw.Modify("o"+string(i)+"_opcion3.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_lateral)+"'")//'16777215'")	//Color blanco
			end if
		else
			ad_dw.Modify("o"+string(i)+"_opcion3.Font.Underline='0'")			
			ad_dw.Modify("o"+string(i)+"_opcion3.Border='0'")			
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion3.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")// '16724224'")	
			else
				ad_dw.Modify("o"+string(i)+"_opcion3.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//'16777215'")	//Color blanco
			end if
		end if		
		//Para el campo de opcion 4
		if as_campo = "o"+string(i)+"_opcion4" then
			ad_dw.Modify("o"+string(i)+"_opcion4.Font.Underline='1'")			
			ad_dw.Modify("o"+string(i)+"_opcion4.Border='6'")						
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion4.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_principal)+"'")//'8388608'")								
			else
				ad_dw.Modify("o"+string(i)+"_opcion4.Color='"+string(w_fa_fondo.istr_colores.letra_seleccion_lateral)+"'")//'16777215'")	//Color blanco
			end if
		else
			ad_dw.Modify("o"+string(i)+"_opcion4.Font.Underline='0'")			
			ad_dw.Modify("o"+string(i)+"_opcion4.Border='0'")						
			if ad_dw = dw_3 then
				ad_dw.Modify("o"+string(i)+"_opcion4.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")// '16724224'")	
			else
				ad_dw.Modify("o"+string(i)+"_opcion4.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//'16777215'")	//Color blanco
			end if
		end if		
		
		//Para el campo de la imagen
		if as_campo = "imagen"+string(i) then
			ad_dw.Modify("imagen"+string(i)+".Border='6'")		
		else
			ad_dw.Modify("imagen"+string(i)+".Border='0'")		
		end if		
	else
		ad_dw.Modify("o"+string(i)+"_titulo.Font.Underline='0'")			
		ad_dw.Modify(ls_rectangulo+".Pen.Color='"+string(w_fa_fondo.istr_colores.borde_cursor)+"'")		//rectangulo
		ad_dw.Modify("o"+string(i)+"_opcion1.Font.Underline='0'")	
		ad_dw.Modify("o"+string(i)+"_opcion2.Font.Underline='0'")		
		ad_dw.Modify("o"+string(i)+"_opcion3.Font.Underline='0'")		
		ad_dw.Modify("o"+string(i)+"_opcion4.Font.Underline='0'")		
		ad_dw.Modify("o"+string(i)+"_opcion1.Border='0'")					
		ad_dw.Modify("o"+string(i)+"_opcion2.Border='0'")
		ad_dw.Modify("o"+string(i)+"_opcion3.Border='0'")
		ad_dw.Modify("o"+string(i)+"_opcion4.Border='0'")		
		if ad_dw = dw_3 then
			ad_dw.Modify("o"+string(i)+"_titulo.Color='"+string(w_fa_fondo.istr_colores.titulo_opciones)+"'") //color del titulo
			ad_dw.Modify("o"+string(i)+"_opcion1.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")//'16724224'")	//Azul intenso
			ad_dw.Modify("o"+string(i)+"_opcion2.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")//=Letras de las opciones
			ad_dw.Modify("o"+string(i)+"_opcion3.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")//=
			ad_dw.Modify("o"+string(i)+"_opcion4.Color='"+string(w_fa_fondo.istr_colores.letras_opciones)+"'")//=			
			ad_dw.Modify("fondo"+string(i)+".Background.Color='"+string(w_fa_fondo.istr_colores.fondo_principal)+"'")//'15400938'") //verde claro				
		else
			ad_dw.Modify("o"+string(i)+"_titulo.Color='"+string(w_fa_fondo.istr_colores.titulo_opciones_lateral)+"'") //color del titulo
			ad_dw.Modify("o"+string(i)+"_opcion1.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//'16776960'")		//Aqua
			ad_dw.Modify("o"+string(i)+"_opcion2.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//=	
			ad_dw.Modify("o"+string(i)+"_opcion3.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//=			
			ad_dw.Modify("o"+string(i)+"_opcion4.Color='"+string(w_fa_fondo.istr_colores.letras_opciones_lateral)+"'")//=						
			ad_dw.Modify("DataWindow.Color='"+string(w_fa_fondo.istr_colores.fondo_lateral)+"'")//'15400938'") //												
		end if
		ad_dw.Modify("imagen"+string(i)+".Border='0'")		
		if ad_dw.describe(ls_rectangulo+".visible") = '1' then
			ad_dw.Modify(ls_rectangulo+".Visible=0")
		end if

	end if
next
end subroutine

public function boolean wf_child_productos ();//override
String	ls_expresion
Integer	li_pos
datawindowchild ldwc_division, ldwc_subg, ldwc_clase, ldwc_arancel, ldwc_clase_prod, ldwc_tipo, &
					 ldwc_espec, ldwc_proveedor, ldwc_condicion, ldwc_color, ldwc_tama, ldwc_marca
dw = dw_3

sqlca.autocommit= true

dw_3.settransobject(sqlca)

dw_3.getchild('prod_division', ldwc_division)
ldwc_division.settransobject(sqlca)
ldwc_division.retrieve(str.g_financiero, str.empresa)
ldwc_division.insertrow(1)

dw_3.getchild('prod_grupo', idwc_grupo)
idwc_grupo.settransobject(sqlca)
idwc_grupo.retrieve(str.g_financiero, str.empresa)
idwc_grupo.insertrow(1)

dw_3.getchild('prod_marca', ldwc_marca)
ldwc_marca.settransobject(sqlca)
ldwc_marca.retrieve(str.g_financiero, str.empresa)
ldwc_marca.insertrow(1)

dw_3.getchild('prod_arancel', ldwc_arancel)
ldwc_arancel.settransobject(sqlca)
ldwc_arancel.retrieve(str.g_financiero, str.empresa)
ldwc_arancel.insertrow(1)

dw_3.getchild('prod_compuesto', ldwc_espec)
ldwc_espec.settransobject(sqlca)
ldwc_espec.retrieve(str.g_financiero, str.empresa)
ldwc_espec.insertrow(1)

dw_3.getchild('prod_color', ldwc_color)
ldwc_color.settransobject(sqlca)
ldwc_color.retrieve(str.g_financiero, str.empresa)
ldwc_color.insertrow(1)


dw_3.getchild('prod_cod_clase_tam', ldwc_tama)
ldwc_tama.settransobject(sqlca)
ldwc_tama.retrieve(str.g_financiero, str.empresa)
ldwc_tama.insertrow(1)

This.SetRedraw(True)

return true
end function

on w_reporte_proveedores.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_3=create dw_3
this.gb_4=create gb_4
this.em_ann=create em_ann
this.st_proveedor=create st_proveedor
this.cb_buscar=create cb_buscar
this.em_proveedor=create em_proveedor
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.gb_4
this.Control[iCurrent+4]=this.em_ann
this.Control[iCurrent+5]=this.st_proveedor
this.Control[iCurrent+6]=this.cb_buscar
this.Control[iCurrent+7]=this.em_proveedor
this.Control[iCurrent+8]=this.dw_2
end on

on w_reporte_proveedores.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.dw_3)
destroy(this.gb_4)
destroy(this.em_ann)
destroy(this.st_proveedor)
destroy(this.cb_buscar)
destroy(this.em_proveedor)
destroy(this.dw_2)
end on

event ue_post_open;// Override

string ls_vienede, ls_where, ls_division
long	 ll_recup
integer li_ann, li_mes, li_dia

dw_1.settransobject(sqlca)
dw = dw_3 
dw_2.settransobject(sqlca)
dw_2.InsertRow(1)
li_mes = month(date(gf_fecha_serv()))
li_ann	 = year(date(gf_fecha_serv()))
dw_2.setitem(1,'mes',li_mes)
dw_2.setitem(1,'ann',li_ann)
li_dia = gf_last_day(li_mes, li_ann)
dw_2.setitem(1,'dia',li_dia)

dw_3.settransobject(sqlca)
dw_1.InsertRow(1)
dw_1.setfocus()


end event

event resize;//Override No borrar no tocar
long ll_dw_ancho,ll_dw_alto
ll_dw_ancho = newwidth - 30
ll_dw_alto  = newheight - 245

dw_3.Resize(ll_dw_ancho - 40, ll_dw_alto - 255)
gb_4.Resize(dw_3.width+70, dw_3.height+70)
gb_1.width = gb_4.width
st_nom_ventana.y = newheight - (st_nom_ventana.height + 10)

end event

event key;//Override

end event

event open;call super::open;//this.width = str.frame.WorkSpaceWidth() - 35
//this.height= str.frame.WorkSpaceHeight() - 210
this.y = 0
this.x = 805
//dw_5.visible = false
//cbx_1.checked = true
end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_reporte_proveedores
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_reporte_proveedores
boolean visible = false
integer x = 41
integer y = 1752
integer width = 919
integer height = 64
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_reporte_proveedores
event ue_down pbm_dwnkey
event ue_entercol ( )
integer x = 27
integer y = 44
integer width = 4864
integer height = 304
integer taborder = 130
string dataobject = "dw_external_saldos_proveedores"
boolean border = false
boolean livescroll = false
end type

event dw_1::ue_down;// Si el Usuario Dio Enter

if key = Keyenter! Then
	This.Postevent("ue_entercol")
	return(2)
End If

end event

event dw_1::doubleclicked;call super::doubleclicked;this.triggerevent("ue_entercol")

end event

event dw_1::ue_microayuda;//Para cuando pasa por encima del objeto
//Override
end event

event dw_1::clicked;long ll_codigo, ll_pais, ll_tercero
integer li_encontro
string ls_ventana, ls_division, ls_empresa, ls_titulo
datetime ldt_fecha
time lt_minutos
boolean lb_entro = false
datawindowchild ldwc_clientes

em_proveedor.visible = false
st_proveedor.visible = false
cb_buscar.visible = false

parent.SetRedraw ( false )

//dw_3.width = 2000
dw_2.visible = false
choose case dwo.name 
	case 'o1_opcion1'
		dw_3.dataobject =  'dw_saldos_proveedores_generales'
		dw_3.title =	'Proveedores Generales'
		dw_3.settransobject(sqlca)
		dw_3.insertrow(1)
		dw_3.setfocus()
		dw_3.width = 3800
		dw_3.retrieve(str.g_financiero, str.empresa)
		ls_titulo = "PROVEEDORES GENERALES AL " +string(date(gf_fecha_serv()))		
		lb_entro = true
		dw_2.visible = true		
	case 'o1_opcion2'
		dw_3.dataobject =  'dw_saldos_proveedores_pendientes'
		dw_3.title =	'Saldos de Proveedores - Documentos Pendientes'
		dw_3.settransobject(sqlca)
		dw_3.insertrow(1)
		dw_3.setfocus()
		dw_3.width = 3800
		lt_minutos = time('23:59:59')
		ldt_fecha = datetime(date(gf_fecha_serv()),lt_minutos)
		dw_3.retrieve(str.g_financiero, str.empresa, ldt_fecha)
		ls_titulo = "Saldo de Proveedores al " +string(date(gf_fecha_serv()))
		lb_entro = true				
		em_proveedor.text = ''
		em_proveedor.visible = true
		st_proveedor.visible = true
		cb_buscar.visible = true		
		dw_2.visible = true		
	case 'o1_opcion3'
		lb_entro = false
		OpenSheet(w_reasignar_saldos_cxp,parent,2, Layered!)

end choose

if lb_entro then
	dw_3.setfocus()
	ls_empresa = gf_dg_nombre_empresa()
	dw.object.empresanom.expression = "'"+ls_empresa+"'"
	dw.Object.datawindow.print.preview = true
	dw.object.titulo_fecha.expression = "'"+ls_titulo+"'"
	dw_3.visible = true		
end if

parent.SetRedraw ( True )

end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_reporte_proveedores
integer x = 0
integer y = 0
integer width = 4928
integer height = 356
integer taborder = 0
long backcolor = 12639424
end type

type st_1 from statictext within w_reporte_proveedores
boolean visible = false
integer x = 2693
integer y = 1744
integer width = 530
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fila 0 de 0"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_3 from uos_in_datawindow_utility within w_reporte_proveedores
boolean visible = false
integer x = 18
integer y = 420
integer width = 3570
integer height = 1844
integer taborder = 30
boolean titlebar = true
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
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
ls_column = dwo.name

if ls_column = 'dgmterce_terc_descripcion' then
	datetime ldt_fecha_saldos
	ll_tercero = dw_3.getitemnumber(row,'terc_tercero')
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
	
	str_rangofecha str_formato1		
	str_formato1.codigo = ll_tercero
	str_formato1.fecha1  = fecha
	str_formato1.fecha2  = fecha1
	Opensheetwithparm(w_estadocuenta_imp_cxp,str_formato1,str.frame,2,layered!)
	
elseif ls_column = 'fact_a_nombre' then
	str_cc_formatos str_formato2		
	str_formato2.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	str_formato2.tercero = dw_3.getitemNumber(row,"fact_cliente")
	Opensheetwithparm(w_estadocuenta,str_formato2,str.frame,2,original!)
elseif ls_column = 'cpmprove_prov_cod_proveedor' then
	str_cc_formatos str_formato3		
	str_formato3.tercero = dw_3.getitemnumber(row,'terc_tercero')
	OpenSheetwithparm(w_mant_proveedores,str_formato3,parent,2, Original!)	
end if
end event

event doubleclicked;call super::doubleclicked;string	ls_nomfile, ls_path, ls_filter
integer	li_rtn

if dwo.name = 'prod_foto_dir' then
	
	ls_filter = "Achivos de Fotos (*.jpg),*.jpg," +&
					"Archivos de Fotos (*.gif),*.gif," +&
					"Archivos de Fotos(*.bmp),*.bmp"
	
	li_rtn = GetFileOpenName("Asignar Foto ",ls_path,ls_nomfile,"jpg",ls_filter)
	
	if li_rtn = 1 then
		this.SetItem(this.Getrow(),"prod_foto_dir",ls_path)
	end if
	
end if
end event

event itemchanged;call super::itemchanged;String ls_codigo, ls_nulo, ls_columna
long 	 ll_fila, ll_tercero, ll_pais
integer li_existe

this.accepttext()
Setnull(ls_nulo)
ls_columna = this.getcolumnname()
choose case ls_columna 
	case	"prod_division"
		//Se blanquean las columnas dependientes
		This.SetItem(row,"prod_grupo",ls_nulo)
	CASE "prod_grupo"	
		//Se setea el Arancel por Default del Grupo Seleccionado
		IF Not (IsNull (data)) Then
			ll_fila = idwc_grupo.Find("#1 = '" + data + "'", 1, idwc_grupo.Rowcount())
			ls_nulo = idwc_grupo.GetItemString(ll_fila, "agru_arancel_default")
			
			IF Not(IsNull(ls_nulo)) Then This.SetItem(row, "prod_arancel", ls_nulo)

		End If
	case "dgmterce_terc_pais"
		idwc_region.Retrieve (long (data))

	case "dgmterce_terc_tercero"
		ll_tercero = long(data)
		
		  SELECT count(*)
			 INTO :li_existe  
			 FROM ccmclien  
			WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
					( ccmclien.clie_empresa = :str.empresa ) AND  
					( ccmclien.clie_tercero = :ll_tercero ) ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al validar cliente '+sqlca.sqlerrtext,1,1,'E')
					return
				end if
		
			if li_existe = 0 or isnull(li_existe) then
				this.reset()
				this.insertrow(1)
				this.setitem(1,'dgmterce_terc_tercero',ll_tercero)
			//	this.setcolumn('dgmterce_terc_descripcion')				
			else
				if this.retrieve(str.g_financiero, str.empresa, ll_tercero) > 0 then
					ll_pais = this.getitemnumber(1,'dgmterce_terc_pais')
					idwc_region.Retrieve (ll_pais)					
				end if
			end if
	case 'movi_documento'
		this.setitem(row,'movi_referencia',data)
	case 'movi_tercero'
		this.setitem(row,'movi_ruc_tercero',idwc_cliente.getitemstring(idwc_cliente.getrow(),'clie_ruc_tercero'))		

end choose
end event

event itemfocuschanged;call super::itemfocuschanged;string ls_filtro
integer li_rtn
this.accepttext()

CHOOSE CASE dwo.name
	CASE "prod_grupo"
	//Se filtran los grupo por la división seleccionada
	ls_filtro = This.GetItemString(row,"prod_division")
	idwc_grupo.SetFilter("agru_codigo_div = '" + ls_filtro + "'")	
	li_rtn = idwc_grupo.Filter()
	
end choose

end event

event ue_enter;//override

string		ls_colum
long			ll_cont, ll_num_max_col, ll_tab_order, ll_tab_order_next
boolean		lb_exist_nextcol
window		lw_window

lw_window = str.frame.getactivesheet()

lb_exist_nextcol = true

if IsValid(this) then
	if this.AcceptText() < 0 then
		return 1
	end if
	lb_exist_nextcol = false
	ls_colum = GetColumnName()
	ll_num_max_col = long(this.object.datawindow.column.count)
	ll_tab_order = long(this.Describe(ls_colum + ".TabSequence"))
	for ll_cont = 1 to ll_num_max_col
		ls_colum = this.Describe("#" + string(ll_cont) + ".Name")
		ll_tab_order_next = long(this.Describe(ls_colum + ".TabSequence"))
		if ll_tab_order_next = ll_tab_order + 10 then
			lb_exist_nextcol = true
			ll_cont = ll_num_max_col
		end if
	next
end if

//if not lb_exist_nextcol then
//	if not ib_no_insertar then
//		if this.getrow() = this.rowcount() then
//			if messagebox('Información','¿Desea Insertar otro Registro?',Information!,Yesno!,1) = 1 then
////				if ib_adicionar then
//					parent.triggerevent('ue_adicionar')
////				else
////					this.InsertRow(0)
////				end if
//			else
//				return 1
//			end if
//		else
//			Send(Handle(this),256,9,long(0,0))
//		end if
//	else
//		Send(Handle(this),256,9,long(0,0))
//	end if
//else
//	Send(Handle(this),256,9,long(0,0))
//end if
//
return 1

end event

event sqlpreview;call super::sqlpreview;String ls_syntax

ls_syntax = sqlsyntax
end event

event rowfocuschanged;call super::rowfocuschanged;string ls_division
long ll_pais

integer li_rtn
this.accepttext()

//CHOOSE CASE dwo.name
if this.rowcount() = 0 then return
if currentrow = 0 then return

st_1.text = 'Fila '+string(currentrow)+' de '+string(this.rowcount())
end event

type gb_4 from gb_1 within w_reporte_proveedores
integer y = 384
integer width = 3616
integer height = 1908
integer taborder = 140
end type

type em_ann from editmask within w_reporte_proveedores
boolean visible = false
integer x = 1970
integer y = 56
integer width = 201
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###0"
end type

type st_proveedor from statictext within w_reporte_proveedores
boolean visible = false
integer x = 3863
integer y = 528
integer width = 347
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 553648127
string text = "Proveedor"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_buscar from commandbutton within w_reporte_proveedores
boolean visible = false
integer x = 4169
integer y = 596
integer width = 219
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Buscar"
end type

event clicked;	String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error
	integer li_c, li_b
	long    ll_lter, ll_encontro
		
		str_dg_dynamic_find	lstr_df
	
		lstr_df.texto_campo [2,1] = "cpmprove.prov_cod_proveedor" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [2,2] = "Cuenta"
		lstr_df.texto_campo [2,3] = "clie_ref_anterior"
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '450'
		lstr_df.texto_campo [1,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [1,2] = "Descripción"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '700'		
		lstr_df.texto_campo [3,1] = "dgmterce.terc_tercero"
		lstr_df.texto_campo [3,2] = "Código Tercero"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'I'
		lstr_df.texto_campo [4,1] = "dgapais.pais_descripcion"
		lstr_df.texto_campo [4,2] = "País"
		lstr_df.texto_campo [4,3] = ""
		lstr_df.texto_campo [4,4] = 'V'
		lstr_df.texto_campo [4,5] = '550'
		
		lstr_df.tabla = " dgmterce, dgapais, cpmprove "
		
		
		lstr_df.tabla_where = &
					"WHERE ( dgmterce.terc_pais *= dgapais.pais_pais ) and  " +&				
							 "(cpmprove.prov_g_financiero = " + string(str.g_financiero) + " and " +&
							 "cpmprove.prov_empresa = " + string(str.empresa) + ") 	and " +&
							"(dgmterce.terc_tercero = cpmprove.prov_tercero)"
		
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	If len (ls_find) = 0 Then Return
		
		
	ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo1,"'"," ")
	ls_codigo1 = Trim(ls_codigo1)
	em_proveedor.text = ls_codigo1
	em_proveedor.triggerevent('modified')
//	idw_1.setitem(1,'terc_tercero',long(ls_codigo1))
end event

type em_proveedor from editmask within w_reporte_proveedores
boolean visible = false
integer x = 3918
integer y = 596
integer width = 233
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

event modified;string ls_filtro, ls_codigo

ls_codigo = this.text

if ls_codigo = '' or isnull(ls_codigo) then
	ls_filtro = "saldo_aldia > 0"
else
	ls_filtro = "saldo_aldia > 0 and cpmprove_prov_cod_proveedor = '"+ls_codigo+"'"
end if

dw_3.setfilter(ls_filtro)
dw_3.filter()
dw_3.groupcalc()
end event

type dw_2 from datawindow within w_reporte_proveedores
boolean visible = false
integer x = 3913
integer y = 764
integer width = 910
integer height = 436
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_mes_ann"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;this.accepttext()
integer li_dia, li_ann,li_mes
choose case dwo.name
	case 'mes','ann'
		li_mes = this.getitemnumber(1,'mes')
		li_ann = this.getitemnumber(1,'ann')
		li_dia = gf_last_day(li_mes, li_ann)
		this.setitem(1,'dia',li_dia)
end choose
end event

event buttonclicked;integer li_ann, li_mes, i, li_dia
string ls_titulo
long ll_tercero
datetime ldt_fecha
decimal{2} ld_saldo
this.accepttext()

li_mes = this.getitemnumber(1,'mes')
li_ann = this.getitemnumber(1,'ann')
li_dia	= this.getitemnumber(1,'dia')
ldt_fecha = datetime(date(string(li_dia)+'/'+string(li_mes)+'/'+string(li_ann)), time('23:59:59'))

SetPointer(HourGlass!) //Reloj de arena

dw_3.setfilter('')
dw_3.filter()

if dw_3.dataobject = 'dw_saldos_proveedores_pendientes' then 
	dw_3.retrieve(str.g_financiero, str.empresa, ldt_fecha)
end if

for i = 1 to dw_3.rowcount()
	yield()
	str.frame.setmicrohelp('Recalculando Saldos '+string(i)+' de '+string(dw_3.rowcount()))
	ll_tercero = dw_3.getitemnumber(i,'terc_tercero')
	ld_saldo = gf_cp_saldo_anterior( ll_tercero, ldt_fecha	)		
	dw_3.setitem(i,'saldo_aldia',ld_saldo)
next

ls_titulo = "Saldos de Proveedores al " +string(date(ldt_fecha))

dw_3.object.titulo_fecha.expression = "'"+ls_titulo+"'"

dw_3.setfilter('saldo_aldia <> 0')
dw_3.filter()

SetPointer(Arrow!)
str.frame.setmicrohelp('Listo')
end event

