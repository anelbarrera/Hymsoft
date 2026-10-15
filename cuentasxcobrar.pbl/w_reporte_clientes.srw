//objectcomments Reportes de Clientes
forward
global type w_reporte_clientes from w_fa_padre_reportes
end type
type st_1 from statictext within w_reporte_clientes
end type
type dw_3 from uos_in_datawindow_utility within w_reporte_clientes
end type
type gb_4 from gb_1 within w_reporte_clientes
end type
type em_ann from editmask within w_reporte_clientes
end type
type dw_2 from datawindow within w_reporte_clientes
end type
type dw_4 from datawindow within w_reporte_clientes
end type
type dw_5 from datawindow within w_reporte_clientes
end type
type em_cliente from editmask within w_reporte_clientes
end type
type st_cliente from statictext within w_reporte_clientes
end type
type cb_buscar from commandbutton within w_reporte_clientes
end type
end forward

global type w_reporte_clientes from w_fa_padre_reportes
integer x = 5
integer y = 20
integer width = 5001
integer height = 2692
string title = "Reportes de Saldos de Clientes"
long backcolor = 12639424
windowanimationstyle openanimation = leftroll!
windowanimationstyle closeanimation = leftslide!
event ue_buscar ( )
st_1 st_1
dw_3 dw_3
gb_4 gb_4
em_ann em_ann
dw_2 dw_2
dw_4 dw_4
dw_5 dw_5
em_cliente em_cliente
st_cliente st_cliente
cb_buscar cb_buscar
end type
global w_reporte_clientes w_reporte_clientes

type variables
string  is_tipo,is_pedido, is_cadena
integer ii_ann, ii_child_row
Long    il_proveedor
boolean ib_filtrar = false

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

on w_reporte_clientes.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_3=create dw_3
this.gb_4=create gb_4
this.em_ann=create em_ann
this.dw_2=create dw_2
this.dw_4=create dw_4
this.dw_5=create dw_5
this.em_cliente=create em_cliente
this.st_cliente=create st_cliente
this.cb_buscar=create cb_buscar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.gb_4
this.Control[iCurrent+4]=this.em_ann
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.dw_4
this.Control[iCurrent+7]=this.dw_5
this.Control[iCurrent+8]=this.em_cliente
this.Control[iCurrent+9]=this.st_cliente
this.Control[iCurrent+10]=this.cb_buscar
end on

on w_reporte_clientes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.dw_3)
destroy(this.gb_4)
destroy(this.em_ann)
destroy(this.dw_2)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.em_cliente)
destroy(this.st_cliente)
destroy(this.cb_buscar)
end on

event ue_post_open;// Override

string ls_vienede, ls_where, ls_division
long	 ll_recup



dw_1.settransobject(sqlca)
dw = dw_3 
dw_3.settransobject(sqlca)

dw_2.settransobject(sqlca)
dw_2.InsertRow(1)

datawindowchild ldwc_tipo
dw_5.settransobject(sqlca)
dw_5.getchild('tipo',ldwc_tipo)
ldwc_tipo.settransobject(sqlca)
ldwc_tipo.retrieve(str.g_financiero, str.empresa)
ldwc_tipo.insertrow(1)
ldwc_tipo.setitem(1,'tpcli_codigo',99)
ldwc_tipo.setitem(1,'tpcli_descripcion','VER TODOS')

dw_5.InsertRow(1)

dw_4.settransobject(sqlca)
dw_4.InsertRow(1)

dw_1.InsertRow(1)
dw_1.setfocus()

dw_4.setitem(1,'mes',month(date(gf_fecha_serv())))
dw_4.setitem(1,'ann',year(date(gf_fecha_serv())))
end event

event resize;//Override No borrar no tocar
long ll_dw_ancho,ll_dw_alto
ll_dw_ancho = newwidth - 30
ll_dw_alto  = newheight - 245

//dw_3.Resize(ll_dw_ancho - 40, ll_dw_alto - 255)
dw_3.height = ll_dw_alto - 255
gb_4.Resize(dw_3.width+270, dw_3.height+70)
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

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_reporte_clientes
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_reporte_clientes
boolean visible = false
integer x = 41
integer y = 1752
integer width = 919
integer height = 64
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_reporte_clientes
event ue_down pbm_dwnkey
event ue_entercol ( )
boolean visible = false
integer x = 27
integer y = 44
integer width = 4864
integer height = 304
integer taborder = 130
string dataobject = "dw_external_saldos_clientes"
boolean livescroll = false
borderstyle borderstyle = styleraised!
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
return

Integer li_pos, li_x, li_y,li_largo
String ls_objeto, ls_col

ls_objeto = This.GetObjectAtPointer()
li_pos = pos  (ls_objeto,"~t")
ls_col = left (ls_objeto, li_pos - 1)


// Dependiendo de la Columna el Mensaje de Ayuda varía
CHOOSE CASE ls_col
	CASE 'o1_titulo', 'o1_opcion1', 'o1_opcion2', 'o1_opcion3'
		wf_normaliza_opcion1(1, ls_col, dw_1)
//--------------------------------------------------------
	CASE 'o2_titulo', 'o2_opcion1', 'o2_opcion2', 'o2_opcion3'
		wf_normaliza_opcion1(2, ls_col, dw_1)
//--------------------------------------------------------		
	CASE 'o3_titulo', 'o3_opcion1', 'o3_opcion2', 'o3_opcion3', 'o3_opcion4'
		wf_normaliza_opcion1(3, ls_col, dw_1)
	CASE ELSE
		wf_normaliza_opcion1(0, ls_col, dw_1)

END CHOOSE
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;string	ls_tipo, ls_pedido
integer	li_anio

if this.rowcount() = 0 then return
if currentrow = 0 then return

st_1.text = 'Fila '+string(currentrow)+' de '+string(this.rowcount())

this.selectrow(0,false)
this.selectrow(currentrow,true)
if dw_3.retrieve(str.g_financiero,str.empresa,ls_pedido,li_anio) = 0 then return

end event

event dw_1::clicked;long ll_codigo, ll_pais, ll_tercero
integer li_encontro
string ls_ventana, ls_division, ls_empresa, ls_titulo
datetime ldt_fecha
datawindowchild ldwc_clientes

parent.SetRedraw ( false )

dw_3.width = 2000
choose case dwo.name 
	case 'o1_opcion1'
		dw_3.dataobject =  'dw_saldos_clientes_generales'
		dw_3.title =	'Clientes Generales'
		dw_3.settransobject(sqlca)
		dw_3.insertrow(1)
		dw_3.setfocus()
		dw_3.width = 3800
		dw_3.retrieve(str.g_financiero, str.empresa)
		ls_titulo = "Clientes Generales al " +string(date(gf_fecha_serv()))		
		dw_3.setfilter('saldo_aldia > 1 or  saldo_aldia < -1')
		ib_filtrar = true
		dw_4.visible = true
	case 'o1_opcion2'
		dw_3.dataobject =  'dw_saldos_clientes_globales'
		dw_3.title =	'Saldos de Clientes'
		dw_3.settransobject(sqlca)
		dw_3.insertrow(1)
		dw_3.setfocus()
		dw_3.width = 3800
		dw_3.retrieve(str.g_financiero, str.empresa)
		ls_titulo = "Saldos al " +string(date(gf_fecha_serv()))
		dw_3.setfilter('saldo_aldia > 1 or  saldo_aldia < -1')
		ib_filtrar  = true
		dw_4.visible = true
	case 'o1_opcion3'
		dw_3.dataobject = 'dw_saldos_clientes_cuentas_malas'
		dw_3.title =	'Cuentas Malas'
		dw_3.settransobject(sqlca)
		dw_3.insertrow(1)
		dw_3.setfocus()
		dw_3.width = 3800
		dw_3.retrieve(str.g_financiero, str.empresa)
		ls_titulo = "Cuentas Malas al " +string(date(gf_fecha_serv()))
		dw_4.visible = false
		ib_filtrar = false
	case 'o2_opcion1'
		dw_3.dataobject = 'dw_limites_credito_clientes'
		dw_3.title =	'Limites de Credito'
		dw_3.settransobject(sqlca)
		dw_3.insertrow(1)
		dw_3.setfocus()
		dw_3.width = 3800
		dw_3.retrieve(str.g_financiero, str.empresa)
		ls_titulo = "Limites de Credito al " +string(date(gf_fecha_serv()))
		dw_4.visible = false
		ib_filtrar = false
	case 'o2_opcion2'
		dw_3.dataobject = 'dw_saldos_clientes_adelantos'
		dw_3.title =	'Adelantos de Clientes'
		dw_3.settransobject(sqlca)
		dw_3.insertrow(1)
		dw_3.setfocus()
		dw_3.width = 3800
		dw_3.retrieve(str.g_financiero, str.empresa)
		ls_titulo = "Adelantos de Clientes al " +string(date(gf_fecha_serv()))
		dw_4.visible = true
		ib_filtrar = false
	case 'o2_opcion3'
		dw_3.dataobject = 'dw_saldos_metal_pendiente'
		dw_3.title =	'Saldos de Metal Pendiente'
		dw_3.settransobject(sqlca)
		dw_3.insertrow(1)
		dw_3.setfocus()
		dw_3.width = 3800
		dw_3.retrieve(str.g_financiero, str.empresa)
		ls_titulo = "Clientes Metal Pendiente al " +string(date(gf_fecha_serv()))
		dw_4.visible = false
		ib_filtrar = false
	case	'o3_opcion2'

	case	'o3_opcion4'
	
	case	'o3_opcion1'

	case	'o3_opcion3'	
				
end choose

dw_3.filter()
dw_3.setfocus()

ls_empresa = gf_dg_nombre_empresa()

dw.object.empresanom.expression = "'"+ls_empresa+"'"
dw.Object.datawindow.print.preview = true
dw.object.titulo_fecha.expression = "'"+ls_titulo+"'"
dw_3.visible = true
		
parent.SetRedraw ( True )

end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_reporte_clientes
boolean visible = false
integer x = 0
integer y = 0
integer width = 4928
integer height = 356
integer taborder = 0
end type

type st_1 from statictext within w_reporte_clientes
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

type dw_3 from uos_in_datawindow_utility within w_reporte_clientes
event ue_sobre pbm_nchittest
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

event ue_sobre;//override
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
	CASE 'dgmterce_terc_descripcion'
		this.Modify("dgmterce_terc_descripcion.Font.Underline='1'")
		this.Modify("dgmterce_terc_descripcion.Color='7536640'")
	CASE 'fact_a_nombre'
		this.Modify("fact_a_nombre.Font.Underline='1'")
		this.Modify("fact_a_nombre.Color='7536640'")
	CASE 'fact_ruc_cliente'
		this.Modify("fact_ruc_cliente.Font.Underline='1'")
		this.Modify("fact_ruc_cliente.Color='7536640'")

	CASE ELSE
		this.Modify("dgmterce_terc_descripcion.Font.Underline='0'")
		this.Modify("dgmterce_terc_descripcion.Color='0'")
		this.Modify("fact_a_nombre.Font.Underline='0'")
		this.Modify("fact_a_nombre.Color='0'")
		this.Modify("fact_ruc_cliente.Font.Underline='0'")
		this.Modify("fact_ruc_cliente.Color='0'")

END CHOOSE
end event

event rowfocuschanged;call super::rowfocuschanged;string ls_division
long ll_pais
if this.rowcount() = 0 then return
if currentrow = 0 then return

st_1.text = 'Fila '+string(currentrow)+' de '+string(this.rowcount())

//this.selectrow(0,false)
//this.selectrow(currentrow,true)


end event

event clicked;call super::clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto, ls_column
integer li_pos 

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
	str_cc_formatos str_formato1		
	str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	str_formato1.tercero = dw_3.getitemNumber(row,"terc_tercero")
	Opensheetwithparm(w_estadocuenta,str_formato1,str.frame,2,original!)
elseif ls_column = 'fact_a_nombre' then
	str_cc_formatos str_formato2		
	str_formato2.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	str_formato2.tercero = dw_3.getitemNumber(row,"fact_cliente")
	Opensheetwithparm(w_estadocuenta,str_formato2,str.frame,2,original!)
elseif ls_column = 'fact_ruc_cliente' then
	str_cc_formatos str_formato3		
	str_formato3.tercero = dw_3.getitemnumber(row,'fact_cliente')
	OpenSheetwithparm(w_mant_clientes,str_formato3,parent,2, Original!)	
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

type gb_4 from gb_1 within w_reporte_clientes
boolean visible = true
integer y = 384
integer width = 3771
integer height = 1908
integer taborder = 140
long backcolor = 12639424
end type

type em_ann from editmask within w_reporte_clientes
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

type dw_2 from datawindow within w_reporte_clientes
integer x = 27
integer y = 44
integer width = 4864
integer height = 304
integer taborder = 150
string title = "none"
string dataobject = "dw_external_saldos_clientes"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;long ll_codigo, ll_pais, ll_tercero
integer li_encontro
string ls_ventana, ls_division, ls_empresa, ls_titulo
datetime ldt_fecha
time lt_minutos
boolean lb_entro
datawindowchild ldwc_clientes

parent.SetRedraw ( false )

em_cliente.visible = false
st_cliente.visible = false
cb_buscar.visible = false
		
dw_3.width = 2000
choose case dwo.name 
	case 'o1_opcion1'
		dw_3.dataobject =  'dw_saldos_clientes_generales'
		dw_3.title =	'Clientes Generales'
		dw_3.settransobject(sqlca)
		dw_3.insertrow(1)
		dw_3.setfocus()
		dw_3.width = 3800
		dw_3.retrieve(str.g_financiero, str.empresa)
		ls_titulo = "Clientes Generales al " +string(date(gf_fecha_serv()))		
		dw_4.visible = true
		lb_entro = true
		is_cadena = '(saldo_aldia > 1 or  saldo_aldia < -1)'
		dw_3.setfilter(is_cadena)
		dw_3.filter()
	case 'o1_opcion2'
		dw_3.dataobject =  'dw_saldos_clientes_globales'
		dw_3.title =	'Saldos de Clientes'
		dw_3.settransobject(sqlca)
		dw_3.insertrow(1)
		dw_3.setfocus()
		dw_3.width = 3800
		dw_3.retrieve(str.g_financiero, str.empresa)
		ls_titulo = "Saldo al " +string(date(gf_fecha_serv()))
		dw_4.visible = true
		lb_entro = true
		is_cadena = '(saldo_aldia > 1 or  saldo_aldia < -1)'
		dw_3.setfilter(is_cadena)
		dw_3.filter()		
	case 'o1_opcion3'
		dw_3.dataobject =  'dw_saldos_clientes_pendientes'
//		dw_2.dataobject =  'dw_saldos_clientes_pendientes_xls'
		dw_3.title =	'Saldos de Clientes - Pendientes'
		dw_3.settransobject(sqlca)
//		dw_2.settransobject(sqlca)
		dw_3.insertrow(1)
		dw_3.setfocus()
		dw_3.width = 3800
		lt_minutos = time('23:59:59')
		ldt_fecha = datetime(date(gf_fecha_serv()),lt_minutos)
		dw_3.retrieve(str.g_financiero, str.empresa, ldt_fecha)
//		dw_2.retrieve(str.g_financiero, str.empresa)
		ls_titulo = "Saldo de Clientes al " +string(date(gf_fecha_serv()))
		lb_entro = true
		em_cliente.visible = true
		em_cliente.text = ''
		st_cliente.visible = true
		cb_buscar.visible = true
		//dw_3.sharedata(dw_2)
//		dw = dw_2
		dw_4.visible = true
		ib_filtrar = true
		is_cadena = '(saldo_aldia > 0)'
		dw_3.setfilter(is_cadena)
		dw_3.filter()				
	case 'o2_opcion1'
		dw_3.dataobject = 'dw_saldos_clientes_cuentas_malas'
		dw_3.title =	'Cuentas Malas'
		dw_3.settransobject(sqlca)
		dw_3.insertrow(1)
		dw_3.setfocus()
		dw_3.width = 3800
		dw_3.retrieve(str.g_financiero, str.empresa)
		is_cadena =  'saldo_aldia > 0'
		dw_3.setfilter(is_cadena)
		dw_3.filter()				
		ls_titulo = "Cuentas Malas al " +string(date(gf_fecha_serv()))
		dw_4.visible = false
		lb_entro = true
	case 'o2_opcion2'
		dw_3.dataobject = 'dw_limites_credito_clientes'
		dw_3.title =	'Limites de Credito'
		dw_3.settransobject(sqlca)
		dw_3.insertrow(1)
		dw_3.setfocus()
		dw_3.width = 3800
		dw_3.retrieve(str.g_financiero, str.empresa)
		is_cadena =  'saldo_aldia > 0'
		dw_3.setfilter(is_cadena)
		dw_3.filter()						
		is_cadena = ''
		ls_titulo = "Limites de Credito al " +string(date(gf_fecha_serv()))
		dw_4.visible = false
		lb_entro = true
	case 'o2_opcion2'
		dw_3.dataobject = 'dw_saldos_clientes_adelantos'
		dw_3.title =	'Adelantos de Clientes'
		dw_3.settransobject(sqlca)
		dw_3.insertrow(1)
		dw_3.setfocus()
		dw_3.width = 3800
		dw_3.retrieve(str.g_financiero, str.empresa)
		is_cadena =  'saldo_aldia < -1'
		dw_3.setfilter(is_cadena)
		dw_3.filter()		
		ls_titulo = "Adelantos de Clientes al " +string(date(gf_fecha_serv()))
		dw_4.visible = true
		lb_entro = true
	case 'o2_opcion3'
		dw_3.dataobject = 'dw_saldos_clientes_adelantos'
		dw_3.title =	'Adelantos de Clientes'
		dw_3.settransobject(sqlca)
		dw_3.insertrow(1)
		dw_3.setfocus()
		dw_3.width = 3800
		dw_3.retrieve(str.g_financiero, str.empresa)
		ls_titulo = "Adelantos de Clientes al " +string(date(gf_fecha_serv()))
		lb_entro = true	
		dw_4.visible = true
		ib_filtrar = false
		is_cadena =  'saldo_aldia < 0'
		dw_3.setfilter(is_cadena)
		dw_3.filter()		
	case 'o3_opcion1'
		dw_3.visible = false
		lb_entro = false
		ib_filtrar = false
		OpenSheet(w_reasignar_saldos_cxc,parent,2, Layered!)
	case 'o3_opcion2'
		dw_3.visible = false
		lb_entro = false
		ib_filtrar = false
		OpenSheet(w_reasignar_transacciones,parent,2, Layered!)
		
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

type dw_4 from datawindow within w_reporte_clientes
boolean visible = false
integer x = 3954
integer y = 716
integer width = 864
integer height = 428
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_mes_ann"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;this.accepttext()
end event

event buttonclicked;integer li_ann, li_mes, i
string ls_titulo
long ll_tercero
datetime ldt_fecha
decimal{2} ld_saldo
this.accepttext()

li_mes = this.getitemnumber(1,'mes')
li_ann = this.getitemnumber(1,'ann')

ldt_fecha = datetime(date(string(gf_last_day(li_mes, li_ann))+'/'+string(li_mes)+'/'+string(li_ann)), time('00:00:00'))

SetPointer(HourGlass!) //Reloj de arena

dw_3.setfilter('')
dw_3.filter()

for i = 1 to dw_3.rowcount()
	yield()
	str.frame.setmicrohelp('Recalculando Saldos '+string(i)+' de '+string(dw_3.rowcount()))
	ll_tercero = dw_3.getitemnumber(i,'terc_tercero')
	ld_saldo = gf_saldo_anterior_new( ll_tercero, ldt_fecha, str.g_financiero, str.empresa, 99999999	)		
	dw_3.setitem(i,'saldo_aldia',ld_saldo)
next

ls_titulo = "Saldos al " +string(date(ldt_fecha))

if dw_3.dataobject = 'dw_saldos_clientes_adelantos' then 
	dw_3.setfilter('saldo_aldia < -1')
else
	dw_3.setfilter('saldo_aldia > 1 or  saldo_aldia < -1')
end if
dw_3.filter()

dw_3.object.titulo_fecha.expression = "'"+ls_titulo+"'"

SetPointer(Arrow!)

str.frame.setmicrohelp('Listo')
end event

type dw_5 from datawindow within w_reporte_clientes
integer x = 3493
integer y = 212
integer width = 1143
integer height = 108
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_tipo"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_filter, ls_cadena
integer li_tipo


if dw_3.dataobject = 'dw_saldos_metal_pendiente' then return

li_tipo = integer(data)

if li_tipo = 99 then
	ls_filter = 'clie_clasificacion <> 4 and '+is_cadena
else
	ls_filter = 'clie_clasificacion = '+string(li_tipo) +' and ' + is_cadena
end if

dw_3.setfilter(ls_filter)
dw_3.filter()
dw_3.groupcalc()
end event

type em_cliente from editmask within w_reporte_clientes
boolean visible = false
integer x = 4014
integer y = 580
integer width = 297
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

event modified;string ls_filtro, ls_codigo

ls_codigo = this.text

if ls_codigo = '' or isnull(ls_codigo) then
	ls_filtro = "saldo_aldia > 0"
else
	ls_filtro = "saldo_aldia > 0 and ccmclien_clie_ref_anterior = '"+ls_codigo+"'"
end if

dw_3.setfilter(ls_filtro)
dw_3.filter()
dw_3.groupcalc()
end event

type st_cliente from statictext within w_reporte_clientes
boolean visible = false
integer x = 4041
integer y = 516
integer width = 224
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
string text = "CLIENTE"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_buscar from commandbutton within w_reporte_clientes
boolean visible = false
integer x = 4334
integer y = 580
integer width = 242
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Buscar"
end type

event clicked;	String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error
	integer li_c, li_b
	long    ll_lter, ll_encontro
		
		str_dg_dynamic_find	lstr_df
	
		lstr_df.texto_campo [2,1] = "ccmclien.clie_ref_anterior" //"dgmterce.terc_identificacion"
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
		
		lstr_df.tabla = " dgmterce, dgapais, ccmclien "
		
		
		lstr_df.tabla_where = &
					"WHERE ( dgmterce.terc_pais = dgapais.pais_pais ) and  " +&				
							 "(ccmclien.clie_g_financiero = " + string(str.g_financiero) + " and " +&
							 "ccmclien.clie_empresa = " + string(str.empresa) + ") 	and " +&
							"(dgmterce.terc_tercero = ccmclien.clie_tercero)"
		
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	If len (ls_find) = 0 Then Return
		
		
	ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo1,"'"," ")
	ls_codigo1 = Trim(ls_codigo1)
	em_cliente.text = ls_codigo1
	em_cliente.triggerevent('modified')
//	idw_1.setitem(1,'terc_tercero',long(ls_codigo1))
end event

