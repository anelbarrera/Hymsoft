//objectcomments Reporte por Proveedores
forward
global type w_parametros_salidas from w_fa_padre_reportes
end type
type st_1 from statictext within w_parametros_salidas
end type
type dw_3 from uos_in_datawindow_utility within w_parametros_salidas
end type
type gb_4 from gb_1 within w_parametros_salidas
end type
type em_ann from editmask within w_parametros_salidas
end type
type dw_2 from datawindow within w_parametros_salidas
end type
type dw_4 from datawindow within w_parametros_salidas
end type
end forward

global type w_parametros_salidas from w_fa_padre_reportes
integer x = 5
integer y = 20
integer width = 5001
integer height = 2556
string title = "Parámetros de Facturación"
string menuname = ""
boolean controlmenu = false
long backcolor = 12639424
event ue_buscar ( )
st_1 st_1
dw_3 dw_3
gb_4 gb_4
em_ann em_ann
dw_2 dw_2
dw_4 dw_4
end type
global w_parametros_salidas w_parametros_salidas

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

on w_parametros_salidas.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_3=create dw_3
this.gb_4=create gb_4
this.em_ann=create em_ann
this.dw_2=create dw_2
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.gb_4
this.Control[iCurrent+4]=this.em_ann
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.dw_4
end on

on w_parametros_salidas.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_3)
destroy(this.gb_4)
destroy(this.em_ann)
destroy(this.dw_2)
destroy(this.dw_4)
end on

event ue_post_open;// Override

string ls_vienede, ls_where, ls_division
long	 ll_recup



dw_1.settransobject(sqlca)
dw = dw_3 
dw_3.settransobject(sqlca)

dw_4.settransobject(sqlca) 
dw_4.InsertRow(1)

dw_1.InsertRow(1)
dw_1.setfocus()


end event

event resize;//Override No borrar no tocar
long ll_dw_ancho,ll_dw_alto
ll_dw_ancho = newwidth - 30
ll_dw_alto  = newheight - 245

dw_3.Resize(ll_dw_ancho - 40, ll_dw_alto - 255)
dw_2.height = ll_dw_alto - 255
gb_4.Resize(dw_3.width+70, dw_3.height+70)
gb_1.width = gb_4.width
st_nom_ventana.y = newheight - (st_nom_ventana.height + 10)

end event

event key;//Override

end event

event open;call super::open;//this.width = str.frame.WorkSpaceWidth() - 35
//this.height= str.frame.WorkSpaceHeight() - 210
//this.y = 0
//this.x = 805
//dw_5.visible = false
//cbx_1.checked = true
gf_center_win(this)
w_hs_frame.Post Event ue_evaluar_panel_acciones()
end event

event close;call super::close;w_hs_frame.Post Event ue_evaluar_panel_acciones()
end event

event closequery;call super::closequery;setredraw(false)
end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_parametros_salidas
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_parametros_salidas
boolean visible = false
integer x = 41
integer y = 1752
integer width = 919
integer height = 64
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_parametros_salidas
event ue_down pbm_dwnkey
event ue_entercol ( )
boolean visible = false
integer x = 27
integer y = 44
integer width = 4864
integer height = 304
integer taborder = 130
string dataobject = "dw_external_salidas"
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
string ls_ventana, ls_division
datetime ldt_fecha
datawindowchild ldwc_clientes

parent.SetRedraw ( false )
dw_2.visible = false
dw_3.width = 2000
choose case dwo.name 

	case 'o1_opcion1'
		dw_3.dataobject = 'dw_tipos'
		dw_3.title =	'Tipos de Clientes'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
			dw_3.insertrow(1)
		end if
	case 'o1_opcion2'
		dw_3.dataobject = 'dw_vendedores'
		dw_3.title =	'Vendedores'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
			dw_3.insertrow(1)
			dw_3.setitem(1,'vend_g_financiero',str.g_financiero)
			dw_3.setitem(1,'vend_empresa',str.empresa)
		end if
	case 'o1_opcion3'
		dw_3.dataobject = 'dw_cargos'
		dw_3.title =	'Definicion de Cargos'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
			dw_3.insertrow(1)
			dw_3.setitem(1,'carg_g_financiero',str.g_financiero)
			dw_3.setitem(1,'carg_empresa',str.empresa)			
		end if		
	case 'o2_opcion1'
		dw_3.width = 2400
		dw_3.dataobject = 'dw_saldos_iniciales'
		dw_3.title =	'Saldos Iniciales de los Clientes'		
		dw_3.settransobject(sqlca)
		dw_3.getchild('movi_tercero', idwc_cliente)
		idwc_cliente.settransobject(sqlca)
		idwc_cliente.retrieve(str.g_financiero, str.empresa)
		idwc_cliente.insertrow(1)		
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
		  SELECT ccmparam.para_fecha_ini_apli  
			 INTO :ldt_fecha  
			 FROM ccmparam  
			WHERE ( ccmparam.para_g_financiero = :str.g_financiero ) AND  
					( ccmparam.para_empresa = :str.empresa )   ;

			dw_3.insertrow(1)			
			dw_3.setitem(1,'ccmparam_para_fecha_ini_apli',ldt_fecha)
			dw_3.setitem(1,'movi_g_financiero',str.g_financiero)
			dw_3.setitem(1,'movi_empresa',str.empresa)			
			dw_3.setitem(1,'movi_aplicacion','CC')
			dw_3.setitem(1,'movi_tipo_transaccion','ND')
			dw_3.setitem(1,'movi_sub_transaccion','8')			
			dw_3.setitem(1,'movi_naturaleza','D')			
			dw_3.setitem(1,'movi_fecha_tran', dw_3.getitemdatetime(1,'ccmparam_para_fecha_ini_apli'))
			dw_3.setitem(1,'movi_anno',year(date(dw_3.getitemdatetime(1,'ccmparam_para_fecha_ini_apli'))))			
			dw_3.setitem(1,'movi_usuario',str.usuario)			
			dw_3.setitem(1,'movi_estado','IM')			
		end if				

	case 'o2_opcion3'

	case	'o3_opcion2'

	case	'o3_opcion4'
	
	case	'o3_opcion1'

	case	'o3_opcion3'	
				
end choose

dw_3.setfocus()
dw_3.visible = true		
		
parent.SetRedraw ( True )


//	case 'o1_opcion1'
//		dw_3.dataobject = 'dw_clientes'
//		dw_3.title =	'Mantenimiento de Clientes'
//		dw_3.settransobject(sqlca)
//		dw_3.settransobject(sqlca)
//		dw_3.getchild('dgmterce_terc_region', idwc_region)
//		idwc_region.settransobject(sqlca)
//		idwc_region.insertrow(1)
//		dw_3.getchild('clie_clasificacion',idwc_tipo)
//		idwc_tipo.settransobject(sqlca)
//		idwc_tipo.retrieve(str.g_financiero, str.empresa)
//		idwc_tipo.insertrow(0)
//		dw_3.insertrow(1)
//		select max(terc_tercero) into :ll_tercero
//		from dgmterce ;
//		if sqlca.sqlcode = -1 then
//			gf_mensaje('','Error al seleccionar tercero',1,1,'E')
//		end if
//		dw_3.setitem(1,'dgmterce_terc_tercero',ll_tercero + 1)		
//		dw_3.setfocus()
//		dw_3.width = 3300
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_parametros_salidas
integer x = 0
integer y = 0
integer width = 4928
integer height = 356
integer taborder = 0
long backcolor = 12639424
end type

type st_1 from statictext within w_parametros_salidas
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

type dw_3 from uos_in_datawindow_utility within w_parametros_salidas
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

event rowfocuschanged;call super::rowfocuschanged;string ls_division
long ll_pais
if this.rowcount() = 0 then return
if currentrow = 0 then return

st_1.text = 'Fila '+string(currentrow)+' de '+string(this.rowcount())

//this.selectrow(0,false)
//this.selectrow(currentrow,true)

choose case this.getcolumnname()		
	case 'adiv_codigo_div', 'adiv_nombre_div'
		ls_division = this.getitemstring(currentrow,'adiv_codigo_div')
		if ls_division = '' or isnull(ls_division) then
			return
		end if
		dw_2.retrieve(str.g_financiero, str.empresa, ls_division)
		
	case	'pais_pais','pais_descripcion'
		ll_pais = this.getitemnumber(currentrow,'pais_pais')
		if ll_pais = 0 or isnull(ll_pais) then
			return
		end if
		dw_2.retrieve(ll_pais)
				
end choose
end event

event clicked;call super::clicked;integer i
datawindowchild ldwc_proveedor
string ls_division
long ll_pais, ll_tercero
THIS.ACCEPTTEXT()
dw_2.ACCEPTTEXT()

choose case dwo.name 
	case 'b_grabar', 'b_cerrar'
		choose case this.dataobject
			case 'dw_productos'
				for i = 1 to this.rowcount()
					this.setitem(i,'prod_g_financiero', str.g_financiero)
					this.setitem(i,'prod_empresa', str.empresa)
				next
			case 'dw_tipos'
				for i = 1 to this.rowcount()
					if this.getitemnumber(i,'tpcli_codigo') = 0 or isnull(this.getitemnumber(i,'tpcli_codigo')) then
						this.deleterow(i)
						i --
					else
						this.setitem(i,'tpcli_g_financiero', str.g_financiero)
						this.setitem(i,'tpcli_empresa', str.empresa)
					end if
				next
			case 'dw_colores'
				for i = 1 to this.rowcount()
					if this.getitemstring(i,'acol_num_color') = '' or isnull(this.getitemstring(i,'acol_num_color')) then
						this.deleterow(i)
						i --
					else
						this.setitem(i,'acol_g_financiero', str.g_financiero)
						this.setitem(i,'acol_empresa', str.empresa)
					end if
				next				
			case 'dw_tamanos'
				for i = 1 to this.rowcount()
					if this.getitemstring(i,'acta_cod_clase_tam') = '' or isnull(this.getitemstring(i,'acta_cod_clase_tam')) then
						this.deleterow(i)
						i --
					else
						this.setitem(i,'acta_g_financiero', str.g_financiero)
						this.setitem(i,'acta_empresa', str.empresa)
					end if
				next					
			case 'dw_compuestos'				
				for i = 1 to this.rowcount()
					if this.getitemstring(i,'aesp_num_especificacion') = '' or isnull(this.getitemstring(i,'aesp_num_especificacion')) then
						this.deleterow(i)
						i --
					else
						this.setitem(i,'aesp_g_financiero', str.g_financiero)
						this.setitem(i,'aesp_empresa', str.empresa)
					end if
				next									
			end choose
		if this.update() = -1 then
			gf_mensaje('','Error al actualizar '+sqlca.sqlerrtext,1,1,'E')
		end if
		if dwo.name = 'b_cerrar' then
			this.visible = false
		end if
	case 'b_adicionar_cargos'
			dw_3.scrolltorow(dw_3.insertrow(0))
			dw_3.setitem(dw_3.getrow(),'carg_g_financiero',str.g_financiero)
			dw_3.setitem(dw_3.getrow(),'carg_empresa',str.empresa)		
	case 'b_adicionar_saldos'
			dw_3.scrolltorow(dw_3.insertrow(0))
			dw_3.setitem(dw_3.getrow(),'movi_g_financiero',str.g_financiero)
			dw_3.setitem(dw_3.getrow(),'movi_empresa',str.empresa)			
			dw_3.setitem(dw_3.getrow(),'movi_aplicacion','CC')
			dw_3.setitem(dw_3.getrow(),'movi_tipo_transaccion','ND')
			dw_3.setitem(dw_3.getrow(),'movi_sub_transaccion','8')			
			dw_3.setitem(dw_3.getrow(),'movi_naturaleza','D')			
			dw_3.setitem(dw_3.getrow(),'movi_fecha_tran', dw_3.getitemdatetime(1,'ccmparam_para_fecha_ini_apli'))
			dw_3.setitem(dw_3.getrow(),'movi_anno',year(date(dw_3.getitemdatetime(1,'ccmparam_para_fecha_ini_apli'))))
			dw_3.setitem(dw_3.getrow(),'movi_usuario',str.usuario)
			dw_3.setitem(dw_3.getrow(),'movi_estado','IM')
			dw_3.setcolumn('movi_documento')
	case 'b_adicionar_vendedor'
			dw_3.scrolltorow(dw_3.insertrow(0))
			dw_3.setitem(dw_3.getrow(),'vend_g_financiero',str.g_financiero)
			dw_3.setitem(dw_3.getrow(),'vend_empresa',str.empresa)
	case 'b_eliminar_organizacion'
		if this.dataobject = 'dw_divisiones' then
			if gf_mensaje('','Esta seguro de eliminar la division y sus grupos ?',2,1,'E') = 2 then return		
			for i = 1 to dw_2.rowcount()
				dw_2.deleterow(i)
				i --
			next
			this.deleterow(this.getrow())
			if dw_2.update() = -1 then
				gf_mensaje('','Error al actualizar grupos '+sqlca.sqlerrtext,1,1,'E')
			elseif dw_3.update() = -1 then
				gf_mensaje('','Error al actualizar divisiones '+sqlca.sqlerrtext,1,1,'E')
			end if
			if dw_3.rowcount() > 0 then
				ls_division = dw_3.getitemstring(dw_3.getrow(),'adiv_codigo_div')
				dw_2.retrieve(str.g_financiero, str.empresa, ls_division)
			end if
		elseif this.dataobject = 'dw_paises' then
			if gf_mensaje('','Esta seguro de eliminar el país y sus puertos ?',2,1,'E') = 2 then return		
			for i = 1 to dw_2.rowcount()
				dw_2.deleterow(i)
				i --
			next
			this.deleterow(this.getrow())
			if dw_2.update() = -1 then
				gf_mensaje('','Error al actualizar puertos '+sqlca.sqlerrtext,1,1,'E')
			elseif dw_3.update() = -1 then
				gf_mensaje('','Error al actualizar paises '+sqlca.sqlerrtext,1,1,'E')
			end if
			if dw_3.rowcount() > 0 then
				ll_pais = dw_3.getitemnumber(dw_3.getrow(),'pais_pais')
				dw_2.retrieve(ll_pais)
			end if

		end if
	case 'b_adicionar_divisiones'
		dw_2.reset()
		this.scrolltorow(this.insertrow(0))
		
	case 'b_cerrar_organizacion', 'b_grabar_organizacion'
		if this.dataobject = 'dw_divisiones' then
			for i = 1 to this.rowcount()
				if this.getitemstring(i,'adiv_codigo_div') = '' or isnull(this.getitemstring(i,'adiv_codigo_div')) then
					this.deleterow(i)
					i --
				else
					this.setitem(i,'adiv_g_financiero', str.g_financiero)
					this.setitem(i,'adiv_empresa', str.empresa)
				end if
			next				
			for i = 1 to dw_2.rowcount()
				if dw_2.getitemstring(i,'agru_codigo_grupo') = '' or isnull(dw_2.getitemstring(i,'agru_codigo_grupo')) then
					dw_2.deleterow(i)
					i --
				end if
			next				
			
			if this.update() = -1 then
				gf_mensaje('','Error al actualizar divisiones '+sqlca.sqlerrtext,1,1,'E')
			elseif dw_2.update() = -1 then
				gf_mensaje('','Error al actualizar grupos '+sqlca.sqlerrtext,1,1,'E')
			end if
			if dwo.name = 'b_cerrar_organizacion' then
				this.visible = false		
				dw_2.visible = false		
			end if
		elseif this.dataobject = 'dw_paises' then
			for i = 1 to this.rowcount()
				if this.getitemnumber(i,'pais_pais') = 0 or isnull(this.getitemnumber(i,'pais_pais')) then
					this.deleterow(i)
					i --
				end if
			next				
			for i = 1 to dw_2.rowcount()
				if dw_2.getitemnumber(i,'puer_pais') = 0 or isnull(dw_2.getitemnumber(i,'puer_pais')) then
					dw_2.deleterow(i)
					i --
				end if
			next				
			
			if this.update() = -1 then
				gf_mensaje('','Error al actualizar paises '+sqlca.sqlerrtext,1,1,'E')
			elseif dw_2.update() = -1 then
				gf_mensaje('','Error al actualizar puertos '+sqlca.sqlerrtext,1,1,'E')
			end if
			if dwo.name = 'b_cerrar_organizacion' then
				this.visible = false		
				dw_2.visible = false		
			end if			
		end if
	case 'adiv_codigo_div', 'adiv_nombre_div'
		ls_division = this.getitemstring(row,'adiv_codigo_div')
		if ls_division = '' or isnull(ls_division) then
			return
		end if
		dw_2.retrieve(str.g_financiero, str.empresa, ls_division)
		
	case	'pais_pais','pais_descripcion'
		ll_pais = this.getitemnumber(row,'pais_pais')
		if ll_pais = 0 or isnull(ll_pais) then
			return
		end if
		dw_2.retrieve(ll_pais)
	case 'b_adicionar_producto'
		this.scrolltorow(this.insertrow(0))
		this.setitem(this.getrow(),'prod_g_financiero', str.g_financiero)
		this.setitem(this.getrow(),'prod_empresa', str.empresa)
	case 'b_grabar_producto'
		if this.update() = -1 then
			gf_mensaje('','Error al actualizar los productos '+sqlca.sqlerrtext,1,1,'E')
		end if		
	case 'b_cerrar_producto'
		if this.update() = -1 then
			gf_mensaje('','Error al actualizar los productos '+sqlca.sqlerrtext,1,1,'E')
		end if		
		this.visible = false
	case 'b_eliminar_producto'
		this.deleterow(this.getrow())
		if this.update() = -1 then
			gf_mensaje('','Error al eliminar los productos '+sqlca.sqlerrtext,1,1,'E')
		end if		
	case	'b_adicionar_cli'
		this.reset()
		this.insertrow(1)
		this.setcolumn('dgmterce_terc_tercero')
		select max(terc_tercero) into :ll_tercero
		from dgmterce ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al seleccionar tercero',1,1,'E')
		end if
		this.setitem(1,'dgmterce_terc_tercero',ll_tercero + 1)
	case 'b_eliminar_cli'
		
		string ls_error
		if gf_mensaje('','Esta Seguro de Eliminar el Cliente ?',2,1,'E') = 1 then
			sqlca.autocommit = false
			ll_tercero = this.getitemnumber(this.getrow(), 'dgmterce_terc_tercero')
			  DELETE FROM ccmclien  
				WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
						( ccmclien.clie_empresa = :str.empresa ) AND  
						( ccmclien.clie_tercero = :ll_tercero )   ;
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					gf_mensaje('','Error al Eliminar Cliente '+ls_error,1,1,'E')				
					sqlca.autocommit = true
					return
				end if
			
			this.deleterow(this.getrow())			
			if this.update() = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				gf_mensaje('','Error al Elimiar Cliente '+ls_error,1,1,'E')				
				sqlca.autocommit = true
				return
			else
				commit;
			end if
			sqlca.autocommit = true			
			this.insertrow(1)
			select max(terc_tercero) into :ll_tercero
			from dgmterce ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al seleccionar tercero',1,1,'E')
			end if
			this.setitem(1,'dgmterce_terc_tercero',ll_tercero + 1)					

		end if
	case 'b_cerrar_cli'
		this.visible = false
	case	'b_grabar_cli'
		string ls_contacto, ls_cargo, ls_observacion, ls_telefono, ls_codigo, ls_ruc, ls_tipo_persona, ls_digito		
		integer li_pais, li_existe, li_tipo
		
		sqlca.autocommit = false
		
		if this.update() = -1 then
		  if sqlca.sqlcode = -1 then
			 gf_mensaje('','Error al Actualizar clientes dw_1 '+sqlca.sqlerrtext,1,1,'E')
			 rollback ;
			 sqlca.autocommit = true
			 return
		  end if
		else
			row = 1
			ls_contacto = this.getitemstring(row, 'clie_contacto')
			ls_cargo		= this.getitemstring(row, 'clie_contacto_cargo')
			ls_telefono	= this.getitemstring(row, 'clie_contacto_telefono')
			ls_codigo	= this.getitemstring(row, 'clie_ref_anterior')
			ls_observacion = this.getitemstring(row, 'clie_comentario')
			li_tipo		= this.getitemnumber(row, 'clie_clasificacion')
			ll_tercero	= this.getitemnumber(row,'dgmterce_terc_tercero')
			ls_ruc		= this.getitemstring(row, 'dgmterce_terc_identificacion')
		
		  SELECT count(*)  
			 INTO :li_existe  
			 FROM ccmclien  
			WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
					( ccmclien.clie_empresa = :str.empresa ) AND  
					( ccmclien.clie_tercero = :ll_tercero ) ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al validar cliente '+sqlca.sqlerrtext,1,1,'E')
				end if				
			if li_existe = 0 or isnull(li_existe) then //Si no existe, crea el proveedor
		
			  INSERT INTO ccmclien  
					( clie_g_financiero,   
					  clie_empresa,   
					  clie_tercero,   
					  clie_mg_cuenta,   
					  clie_ref_anterior,   
					  clie_limite_credito,   
					  clie_ruc_tercero,   
					  clie_contacto,   
					  clie_contacto_cargo,   
					  clie_contacto_telefono,    
					  clie_comentario,   
					  clie_estado,   
					  clie_clasificacion,
					  clie_tipo_desc)  
		  VALUES ( :str.g_financiero,   
					  :str.empresa,   
					  :ll_tercero,   
					  ' ',   
					  :ls_codigo,   
					  999999,   
					  :ls_ruc,   
					  :ls_contacto,   
					  :ls_cargo,   
					  :ls_telefono,   
					  :ls_observacion,   
					  'A',   
					  :li_tipo,
					  'N')  ;
			  
				  if sqlca.sqlcode = -1 then
					 gf_mensaje('','Error al Insertar proveedor '+sqlca.sqlerrtext,1,1,'E')
					 rollback ;
					 sqlca.autocommit = true
					 return					 
				  end if
			
			else //Si ya existe, actualiza los datos
							
				update ccmclien  
					set clie_ref_anterior = :ls_codigo,   
						  clie_ruc_tercero = :ls_ruc,    
						  clie_contacto = :ls_contacto,   
						  clie_contacto_cargo = :ls_cargo,      
						  clie_contacto_telefono = :ls_telefono,   
						  clie_comentario = :ls_observacion,
						  clie_clasificacion = :li_tipo
				  where clie_g_financiero = :str.g_financiero and
						  clie_empresa		= :str.empresa and
						  clie_tercero		= :ll_tercero ;
				  if sqlca.sqlcode = -1 then
					 gf_mensaje('','Error al Actualizar cliente '+sqlca.sqlerrtext,1,1,'E')
					 rollback ;
					 sqlca.autocommit = true
					 return
				  end if
				
			end if
		
		end if //del update del dw_1

		commit;
		
		sqlca.autocommit = true
	case	'b_cliente'
			String  ls_find,ls_codigo1,ls_lter,ls_des
			integer li_c, li_b
			long    ll_lter
			
			Datawindow        dww
			str_dg_dynamic_find	lstr_df
			
				lstr_df.texto_campo [1,1] = "ccmclien.clie_ruc_tercero" //"dgmterce.terc_identificacion"
				lstr_df.texto_campo [1,2] = "RUC"
				lstr_df.texto_campo [1,3] = ""
				lstr_df.texto_campo [1,4] = 'V'
				lstr_df.texto_campo [1,5] = '450'
				lstr_df.texto_campo [2,1] = "dgmterce.terc_descripcion"
				lstr_df.texto_campo [2,2] = "Descripción"
				lstr_df.texto_campo [2,3] = ""
				lstr_df.texto_campo [2,4] = 'V'
				lstr_df.texto_campo [2,5] = '700'		
				lstr_df.texto_campo [3,1] = "dgmterce.terc_tercero"
				lstr_df.texto_campo [3,2] = "Código Tercero"
				lstr_df.texto_campo [3,3] = "terc_tercero"
				lstr_df.texto_campo [3,4] = 'V'
				lstr_df.texto_campo [4,1] = "dgapais.pais_descripcion"
				lstr_df.texto_campo [4,2] = "País"
				lstr_df.texto_campo [4,3] = ""
				lstr_df.texto_campo [4,4] = 'V'
				lstr_df.texto_campo [4,5] = '550'
				
				lstr_df.tabla = " dgmterce, dgapais, ccmclien "
				
				
				lstr_df.tabla_where = &
							"WHERE ( dgmterce.terc_pais *= dgapais.pais_pais ) and  " +&				
									 "(ccmclien.clie_g_financiero = " + string(str.g_financiero) + " and " +&
									 "ccmclien.clie_empresa = " + string(str.empresa) + ") 	and " +&
									"(dgmterce.terc_tercero = ccmclien.clie_tercero)"
				
				OpenWithParm(w_dg_a_custom_find, lstr_df)
				ls_find = Message.StringParm
			
			
			If len (ls_find) = 0 Then Return
				
				
			ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
			gf_replace_cadena(ls_codigo1,"'"," ")
			ls_codigo1 = Trim(ls_codigo1)
		
			dw_3.setitem(dw_3.getrow(),'dgmterce_terc_tercero',long(ls_codigo1))
			dw_3.accepttext()
			dw_3.setcolumn('dgmterce_terc_tercero')
			dw_3.trigger event itemchanged(dw_3.getrow(),object,ls_codigo1)
		
	case else
		
		//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
		//en la misma columna.
		
		string ls_objeto
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

		
end choose

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

type gb_4 from gb_1 within w_parametros_salidas
integer y = 384
integer width = 3616
integer height = 1908
integer taborder = 140
end type

type em_ann from editmask within w_parametros_salidas
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

type dw_2 from datawindow within w_parametros_salidas
boolean visible = false
integer x = 1806
integer y = 420
integer width = 1819
integer height = 1840
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Grupos o Secciones"
boolean controlmenu = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;integer i
datawindowchild ldwc_proveedor
string ls_division
long ll_pais

if dw_2.dataobject = 'dw_grupos' then
	choose case dwo.name 
		case 'b_adicionar_grupo'	//adiciona grupos
			this.scrolltorow( this.insertrow(0))
			ls_division = dw_3.getitemstring(dw_3.getrow(),'adiv_codigo_div')
			if ls_division = '' or isnull(ls_division) then
				return
			end if
			this.setitem(this.getrow(),'agru_codigo_div',ls_division)
			this.setitem(this.getrow(),'agru_g_financiero', str.g_financiero)
			this.setitem(this.getrow(),'agru_empresa', str.empresa)		
		case 'b_cerrar_grupo', 'b_grabar_grupo'
			for i = 1 to dw_3.rowcount()
				if dw_3.getitemstring(i,'adiv_codigo_div') = '' or isnull(dw_3.getitemstring(i,'adiv_codigo_div')) then
					dw_3.deleterow(i)
					i --
				else
					dw_3.setitem(i,'adiv_g_financiero', str.g_financiero)
					dw_3.setitem(i,'adiv_empresa', str.empresa)
				end if
			next				
			for i = 1 to dw_2.rowcount()
				if dw_2.getitemstring(i,'agru_codigo_grupo') = '' or isnull(dw_2.getitemstring(i,'agru_codigo_grupo')) then
					dw_2.deleterow(i)
					i --
				end if
			next				
			
			if dw_3.update() = -1 then
				gf_mensaje('','Error al actualizar divisiones '+sqlca.sqlerrtext,1,1,'E')
			elseif dw_2.update() = -1 then
				gf_mensaje('','Error al actualizar grupos '+sqlca.sqlerrtext,1,1,'E')
			end if
			if dwo.name = 'b_cerrar_grupo' then
				dw_3.visible = false		
				dw_2.visible = false		
			end if
		case	'b_eliminar_grupo'
			if dw_2.getrow() > 0 then
				dw_2.deleterow(dw_2.getrow())
				if dw_2.update() = -1 then
					gf_mensaje('','Error al actualizar grupos '+sqlca.sqlerrtext,1,1,'E')
				end if	
			end if
	
	end choose
elseif dw_2.dataobject = 'dw_puertos' then
	choose case dwo.name 
		case 'b_adicionar_grupo'	//adiciona grupos
			this.scrolltorow( this.insertrow(0))
			ll_pais = dw_3.getitemnumber(dw_3.getrow(),'pais_pais')
			if isnull(ll_pais) then
				return
			end if
			this.setitem(this.getrow(),'puer_pais', ll_pais)
		case 'b_cerrar_grupo', 'b_grabar_grupo'
			for i = 1 to dw_3.rowcount()
				if  isnull(dw_3.getitemnumber(i,'pais_pais')) then
					dw_3.deleterow(i)
					i --
				end if
			next				
			for i = 1 to dw_2.rowcount()
				if isnull(dw_2.getitemnumber(i,'puer_codigo_puerto')) then
					dw_2.deleterow(i)
					i --
				end if
			next				
			
			if dw_3.update() = -1 then
				gf_mensaje('','Error al actualizar paises '+sqlca.sqlerrtext,1,1,'E')
			elseif dw_2.update() = -1 then
				gf_mensaje('','Error al actualizar puertos '+sqlca.sqlerrtext,1,1,'E')
			end if
			if dwo.name = 'b_cerrar_grupo' then
				dw_3.visible = false		
				dw_2.visible = false		
			end if
		case	'b_eliminar_grupo'
			if dw_2.getrow() > 0 then
				dw_2.deleterow(dw_2.getrow())
				if dw_2.update() = -1 then
					gf_mensaje('','Error al actualizar puertos '+sqlca.sqlerrtext,1,1,'E')
				end if	
			end if
	
	end choose	
end if
end event

type dw_4 from datawindow within w_parametros_salidas
integer x = 27
integer y = 44
integer width = 4864
integer height = 304
integer taborder = 140
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_salidas"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;long ll_codigo, ll_pais, ll_tercero
integer li_encontro
string ls_ventana, ls_division
datetime ldt_fecha
datawindowchild ldwc_clientes

parent.SetRedraw ( false )
dw_2.visible = false
dw_3.width = 2000
choose case dwo.name 

	case 'o1_opcion1'
		dw_3.dataobject = 'dw_tipos'
		dw_3.title =	'Tipos de Clientes'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
			dw_3.insertrow(1)
		end if
	case 'o1_opcion2'
		dw_3.dataobject = 'dw_vendedores'
		dw_3.title =	'Vendedores'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
			dw_3.insertrow(1)
			dw_3.setitem(1,'vend_g_financiero',str.g_financiero)
			dw_3.setitem(1,'vend_empresa',str.empresa)
		end if
	case 'o1_opcion3'
		dw_3.width = 2500
		dw_3.dataobject = 'dw_cargos'
		dw_3.title =	'Definicion de Cargos'
		dw_3.settransobject(sqlca)
		dw_3.getchild('carg_cuenta', idwc_cliente)
		idwc_cliente.settransobject(sqlca)
		idwc_cliente.retrieve(str.g_financiero, str.empresa)		
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
			dw_3.insertrow(1)
			dw_3.setitem(1,'carg_g_financiero',str.g_financiero)
			dw_3.setitem(1,'carg_empresa',str.empresa)			
		end if		
	case 'o2_opcion1'
		dw_3.width = 2400
		dw_3.dataobject = 'dw_saldos_iniciales'
		dw_3.title =	'Saldos Iniciales de los Clientes'		
		dw_3.settransobject(sqlca)
		dw_3.getchild('movi_tercero', idwc_cliente)
		idwc_cliente.settransobject(sqlca)
		idwc_cliente.retrieve(str.g_financiero, str.empresa)
		idwc_cliente.insertrow(1)		
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
		  SELECT ccmparam.para_fecha_ini_apli  
			 INTO :ldt_fecha  
			 FROM ccmparam  
			WHERE ( ccmparam.para_g_financiero = :str.g_financiero ) AND  
					( ccmparam.para_empresa = :str.empresa )   ;

			dw_3.insertrow(1)			
			dw_3.setitem(1,'ccmparam_para_fecha_ini_apli',ldt_fecha)
			dw_3.setitem(1,'movi_g_financiero',str.g_financiero)
			dw_3.setitem(1,'movi_empresa',str.empresa)			
			dw_3.setitem(1,'movi_aplicacion','CC')
			dw_3.setitem(1,'movi_tipo_transaccion','ND')
			dw_3.setitem(1,'movi_sub_transaccion','8')			
			dw_3.setitem(1,'movi_naturaleza','D')			
			dw_3.setitem(1,'movi_fecha_tran', dw_3.getitemdatetime(1,'ccmparam_para_fecha_ini_apli'))
			dw_3.setitem(1,'movi_anno',year(date(dw_3.getitemdatetime(1,'ccmparam_para_fecha_ini_apli'))))			
			dw_3.setitem(1,'movi_usuario',str.usuario)			
			dw_3.setitem(1,'movi_estado','IM')			
		end if				

	case 'o2_opcion3'

	case	'o3_opcion2'

	case	'o3_opcion4'
	
	case	'o3_opcion1'

	case	'o3_opcion3'	
				
end choose

dw_3.setfocus()
dw_3.visible = true		
		
parent.SetRedraw ( True )


//	case 'o1_opcion1'
//		dw_3.dataobject = 'dw_clientes'
//		dw_3.title =	'Mantenimiento de Clientes'
//		dw_3.settransobject(sqlca)
//		dw_3.settransobject(sqlca)
//		dw_3.getchild('dgmterce_terc_region', idwc_region)
//		idwc_region.settransobject(sqlca)
//		idwc_region.insertrow(1)
//		dw_3.getchild('clie_clasificacion',idwc_tipo)
//		idwc_tipo.settransobject(sqlca)
//		idwc_tipo.retrieve(str.g_financiero, str.empresa)
//		idwc_tipo.insertrow(0)
//		dw_3.insertrow(1)
//		select max(terc_tercero) into :ll_tercero
//		from dgmterce ;
//		if sqlca.sqlcode = -1 then
//			gf_mensaje('','Error al seleccionar tercero',1,1,'E')
//		end if
//		dw_3.setitem(1,'dgmterce_terc_tercero',ll_tercero + 1)		
//		dw_3.setfocus()
//		dw_3.width = 3300
end event

