//objectcomments Reporte por Proveedores
forward
global type w_parametros_entradas from w_fa_padre_reportes
end type
type st_1 from statictext within w_parametros_entradas
end type
type dw_3 from uos_in_datawindow_utility within w_parametros_entradas
end type
type gb_4 from gb_1 within w_parametros_entradas
end type
type em_ann from editmask within w_parametros_entradas
end type
type dw_2 from datawindow within w_parametros_entradas
end type
type dw_4 from datawindow within w_parametros_entradas
end type
type dw_5 from datawindow within w_parametros_entradas
end type
type dw_6 from datawindow within w_parametros_entradas
end type
end forward

global type w_parametros_entradas from w_fa_padre_reportes
integer x = 5
integer y = 20
integer width = 5175
integer height = 2556
string title = "Parámetros de Entrada de Mercancía"
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
dw_5 dw_5
dw_6 dw_6
end type
global w_parametros_entradas w_parametros_entradas

type variables
string  is_tipo,is_pedido
integer ii_ann, ii_child_row
Long    il_proveedor

datawindowchild idw_child, idwc_grupo, idwc_region, idwc_cliente
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
public function boolean wf_busca_producto ()
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
					 ldwc_espec, ldwc_proveedor, ldwc_condicion, ldwc_color, ldwc_tama, ldwc_marca, ldwc_provee
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

dw_3.getchild('prod_tercero', ldwc_provee)
ldwc_provee.settransobject(sqlca)
ldwc_provee.retrieve('P')
ldwc_provee.insertrow(1)


This.SetRedraw(True)

return true
end function

public function boolean wf_busca_producto ();//Busqueda del producto
//
String  ls_find,ls_codigo
integer li_c, li_b
long    ll_lter
string  ls_lter,ls_des

Datawindow        dww
str_dg_dynamic_find	lstr_df

	lstr_df.texto_campo [1,1] = "inmprodu.prod_producto"
	lstr_df.texto_campo [1,2] = "Referencia"
	lstr_df.texto_campo [1,3] = "prod_producto"
	lstr_df.texto_campo [1,4] = 'V'
//	lstr_df.texto_campo [1,5] = '280'	
	lstr_df.texto_campo [2,1] = "inmprodu.prod_descripcion"
	lstr_df.texto_campo [2,2] = "Descripcion"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '770'
//	lstr_df.texto_campo [3,1] = "orden.enca_fecha"
//	lstr_df.texto_campo [3,2] = "Fecha"
//	lstr_df.texto_campo [3,3] = ""
//	lstr_df.texto_campo [3,4] = 'V'
//	lstr_df.texto_campo [3,5] = '285'
	lstr_df.tabla = " inmprodu "
		
	lstr_df.tabla_where = &
				"WHERE (inmprodu.prod_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(inmprodu.prod_empresa = " + string(str.empresa) + ") "	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm



If len (ls_find) = 0 Then Return false
	
ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)
dw_3.setitem(dw_3.getrow(),'prod_producto',ls_codigo)
dw_3.accepttext()
//dw_3.trigger event itemchanged(dw_3.getrow(), dwobject, ls_codigo)
end function

on w_parametros_entradas.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_3=create dw_3
this.gb_4=create gb_4
this.em_ann=create em_ann
this.dw_2=create dw_2
this.dw_4=create dw_4
this.dw_5=create dw_5
this.dw_6=create dw_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.gb_4
this.Control[iCurrent+4]=this.em_ann
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.dw_4
this.Control[iCurrent+7]=this.dw_5
this.Control[iCurrent+8]=this.dw_6
end on

on w_parametros_entradas.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_3)
destroy(this.gb_4)
destroy(this.em_ann)
destroy(this.dw_2)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.dw_6)
end on

event ue_post_open;// Override

string ls_vienede, ls_where, ls_division
long	 ll_recup



dw_1.settransobject(sqlca)
dw = dw_3 
dw_3.settransobject(sqlca)

dw_5.settransobject(sqlca)
dw_5.InsertRow(1)
 
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
gf_center_win(This)
//w_hs_frame.Post Event ue_evaluar_panel_acciones()
end event

event close;call super::close;
Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
 
end event

event closequery;call super::closequery;This.setredraw(false)
constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)
end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_parametros_entradas
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_parametros_entradas
boolean visible = false
integer x = 41
integer y = 1752
integer width = 919
integer height = 64
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_parametros_entradas
event ue_down pbm_dwnkey
event ue_entercol ( )
boolean visible = false
integer x = 27
integer y = 44
integer width = 4864
integer height = 304
integer taborder = 130
string dataobject = "dw_external_entradas"
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
string ls_ventana, ls_division
datetime ldt_fecha
parent.SetRedraw ( false )
dw_2.visible = false
dw_3.width = 2000
choose case dwo.name 
	case 'o1_opcion1'
		dw_3.dataobject = 'dw_aranceles'
		dw_3.title =	'Aranceles de Productos'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve() = 0 then
			dw_3.insertrow(1)
		end if
	case 'o1_opcion2'
		dw_3.dataobject = 'dw_marcas'
		dw_3.title =	'Marcas de Productos'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
			dw_3.insertrow(1)
		end if
	case 'o1_opcion3'
		dw_3.dataobject = 'dw_colores'
		dw_3.title =	'Colores'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
			dw_3.insertrow(1)
		end if
	case 'o2_opcion1'
		dw_3.dataobject = 'dw_tamanos'
		dw_3.title =	'Definicion de Tamaños'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
			dw_3.insertrow(1)
		end if		
	case 'o2_opcion2'
		dw_3.dataobject = 'dw_compuestos'
		dw_3.title =	'Composición de los Productos'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
			dw_3.insertrow(1)
		end if				
	case 'o2_opcion3'
		dw_3.dataobject = 'dw_organizacion'
		dw_3.title =	'Division o Departamento'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
			dw_3.insertrow(1)
		end if						
		dw_3.width = 2000
		dw_2.dataobject = 'dw_grupos'
		dw_2.title =	'Grupos o Secciones'
		dw_2.settransobject(sqlca)
		dw_2.visible = true		
		if dw_3.rowcount() > 0 then
			ls_division = dw_3.getitemstring(1,'adiv_codigo_div')
			dw_2.retrieve(str.g_financiero, str.empresa, ls_division)
		end if
	case	'o3_opcion1'
		dw_3.dataobject = 'dw_paises'
		dw_3.title =	'Configuracion de Paises'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve() = 0 then
			dw_3.insertrow(1)
		end if	
		dw_3.width = 1800		
		dw_2.dataobject = 'dw_puertos'
		dw_2.title =	'Puertos Destinos / Origenes'
		dw_2.settransobject(sqlca)
		dw_2.visible = true		
		if dw_3.rowcount() > 0 then
			ll_pais = dw_3.getitemnumber(1,'pais_pais')
			dw_2.retrieve(ll_pais)
		end if		
	case 'o3_opcion3'
		dw_3.width = 2400
		dw_3.dataobject = 'dw_saldos_iniciales_cp'
		dw_3.title =	'Saldos Iniciales de los Proveedores'		
		dw_3.settransobject(sqlca)
		dw_3.getchild('movi_tercero', idwc_cliente)
		idwc_cliente.settransobject(sqlca)
		idwc_cliente.retrieve(str.g_financiero, str.empresa)
		idwc_cliente.insertrow(1)		
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
		  SELECT cpmparam.para_fecha_inicio  
			 INTO :ldt_fecha  
			 FROM cpmparam  
			WHERE ( cpmparam.para_g_financiero = :str.g_financiero ) AND  
					( cpmparam.para_empresa = :str.empresa )   ;

			dw_3.insertrow(1)			
			dw_3.setitem(1,'cpmparam_para_fecha_inicio',ldt_fecha)
			dw_3.setitem(1,'movi_g_financiero',str.g_financiero)
			dw_3.setitem(1,'movi_empresa',str.empresa)			
			dw_3.setitem(1,'movi_aplicacion','CP')
			dw_3.setitem(1,'movi_tipo_transaccion','NC')
			dw_3.setitem(1,'movi_sub_transaccion','9')			
			dw_3.setitem(1,'movi_naturaleza','C')			
			dw_3.setitem(1,'movi_fecha_tran', dw_3.getitemdatetime(1,'cpmparam_para_fecha_inicio'))
			dw_3.setitem(1,'movi_anno',year(date(dw_3.getitemdatetime(1,'cpmparam_para_fecha_inicio'))))			
			dw_3.setitem(1,'movi_usuario',str.usuario)			
			dw_3.setitem(1,'movi_estado','IM')			
		end if						
//	case	'o3_opcion4'
//		dw_3.dataobject = 'dw_producto'
//		dw_3.title =	'Mantenimiento de los Productos'
//		dw_3.settransobject(sqlca)
//		dw_4.settransobject(sqlca)
//		dw_4.retrieve(str.g_financiero, str.empresa)
//		wf_child_productos()
////		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
//			dw_3.insertrow(1)
//			dw_3.setitem(1,'prod_g_financiero', str.g_financiero)
//			dw_3.setitem(1,'prod_empresa', str.empresa)
//			dw_3.setcolumn("prod_producto")
////		end if				
//		dw_3.width = 3300
////	case	'o3_opcion1'
//		dw_3.dataobject = 'dw_proveedores'
//		dw_3.title =	'Mantenimiento de los Proveedores'
//		dw_3.settransobject(sqlca)
//		dw_3.getchild('dgmterce_terc_region', idwc_region)
//		idwc_region.settransobject(sqlca)
//		idwc_region.insertrow(1)
//		dw_3.insertrow(1)
//		select max(terc_tercero) into :ll_tercero
//		from dgmterce ;
//		if sqlca.sqlcode = -1 then
//			gf_mensaje('','Error al seleccionar tercero',1,1,'E')
//		end if
//		dw_3.setitem(1,'dgmterce_terc_tercero',ll_tercero + 1)		
//		dw_3.setfocus()
//		dw_3.width = 3300
	case	'o3_opcion2'
		dw_3.dataobject = 'dw_transportistas'
		dw_3.title =	'Mantenimiento de los Transportistas'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve() = 0 then
			dw_3.insertrow(1)
		end if
		dw_3.setfocus()
		dw_3.width = 3300
				
end choose

dw_3.setfocus()
dw_3.visible = true		
		
parent.SetRedraw ( True )

end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_parametros_entradas
integer x = 0
integer y = 0
integer width = 4928
integer height = 356
integer taborder = 0
long backcolor = 12639424
end type

type st_1 from statictext within w_parametros_entradas
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

type dw_3 from uos_in_datawindow_utility within w_parametros_entradas
event ue_helpcol ( )
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

event ue_helpcol();//Busqueda del producto
//
String  ls_find,ls_codigo
integer li_c, li_b
long    ll_lter, ll_encontro
string  ls_lter,ls_des

Datawindow        dww
str_dg_dynamic_find	lstr_df

	lstr_df.texto_campo [1,1] = "inmprodu.prod_producto"
	lstr_df.texto_campo [1,2] = "Referencia"
	lstr_df.texto_campo [1,3] = "prod_producto"
	lstr_df.texto_campo [1,4] = 'V'
//	lstr_df.texto_campo [1,5] = '280'	
	lstr_df.texto_campo [2,1] = "inmprodu.prod_descripcion"
	lstr_df.texto_campo [2,2] = "Descripcion"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '770'
//	lstr_df.texto_campo [3,1] = "orden.enca_fecha"
//	lstr_df.texto_campo [3,2] = "Fecha"
//	lstr_df.texto_campo [3,3] = ""
//	lstr_df.texto_campo [3,4] = 'V'
//	lstr_df.texto_campo [3,5] = '285'
	lstr_df.tabla = " inmprodu "
		
	lstr_df.tabla_where = &
				"WHERE (inmprodu.prod_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(inmprodu.prod_empresa = " + string(str.empresa) + ") "	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm



If len (ls_find) = 0 Then Return
	
ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)
this.setitem(this.getrow(),'prod_producto',ls_codigo)
//para ubicar el puntero en la posicion del producto buscado
ll_encontro = dw_4.find("prod_producto = '"+ls_codigo+"'", 1, dw_4.rowcount())
if ll_encontro > 0 then
	dw_4.scrolltorow(ll_encontro)
end if
this.accepttext()
this.trigger event itemchanged(this.getrow(), object, ls_codigo)
end event

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

event clicked;call super::clicked;integer i, li_conteo,ll_max
datawindowchild ldwc_proveedor
string ls_division, ls_producto,ls_sexo
long ll_pais, ll_tercero, ll_row, ll_encontro 
str_secuencia_doc lstr_sex
THIS.ACCEPTTEXT()
dw_2.ACCEPTTEXT()

choose case dwo.name 
	case 'b_kardex'
		Window lw_child_v				
		str_kardex  str_opcion
		
			str_opcion.opcion_menu = 'MCP'
			str_opcion.opcion_ventana    = 'P'
			str_opcion.dwpantalla     = 'dw_in_mcp_prod_kard_1'
			str_opcion.dwreporte      = 'dw_in_mcp_prod_kard_2'
			str_opcion.titulo_ventana = 'Movimiento del Producto (Kardex)'
			
			if this.rowcount() > 0 then
				ls_producto = this.getitemstring(this.getrow(),'prod_producto')				
			end if
			
			str_opcion.kproducto=ls_producto
		
			OpenSheetWithParm(lw_child_v,str_opcion,"w_in_movi_prod_kardex",str.frame,2,Original!)		
			
	case 'b_grabar', 'b_cerrar'
		choose case this.dataobject
			case 'dw_marcas'
				for i = 1 to this.rowcount()
					if this.getitemstring(i,'amar_num_marca') = '' or isnull(this.getitemstring(i,'amar_num_marca')) then
						this.deleterow(i)
						i --
					else
						this.setitem(i,'amar_g_financiero', str.g_financiero)
						this.setitem(i,'amar_empresa', str.empresa)
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
				
			case 'dw_periodo_reporte'
								
			end choose
		if this.update() = -1 then
			gf_mensaje('','Error al actualizar '+sqlca.sqlerrtext,1,1,'E')
		end if
		if dwo.name = 'b_cerrar' then
			this.visible = false
		end if
						
	case 'b_eliminar_organizacion'
		if this.dataobject = 'dw_organizacion' then
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
	case 'b_adicionar_desc'
			dw_3.scrolltorow(dw_3.insertrow(0))
			dw_3.setitem(dw_3.getrow(),'desc_g_financiero',str.g_financiero)
			dw_3.setitem(dw_3.getrow(),'desc_empresa',str.empresa)			
	case 'b_adicionar_saldos'
			dw_3.scrolltorow(dw_3.insertrow(0))
			dw_3.setitem(dw_3.getrow(),'movi_g_financiero',str.g_financiero)
			dw_3.setitem(dw_3.getrow(),'movi_empresa',str.empresa)			
			dw_3.setitem(dw_3.getrow(),'movi_aplicacion','CP')
			dw_3.setitem(dw_3.getrow(),'movi_tipo_transaccion','NC')
			dw_3.setitem(dw_3.getrow(),'movi_sub_transaccion','9')			
			dw_3.setitem(dw_3.getrow(),'movi_naturaleza','C')			
			dw_3.setitem(dw_3.getrow(),'movi_fecha_tran', dw_3.getitemdatetime(1,'cpmparam_para_fecha_inicio'))
			dw_3.setitem(dw_3.getrow(),'movi_anno',year(date(dw_3.getitemdatetime(1,'cpmparam_para_fecha_inicio'))))
			dw_3.setitem(dw_3.getrow(),'movi_usuario',str.usuario)
			dw_3.setitem(dw_3.getrow(),'movi_estado','IM')
			dw_3.setcolumn('movi_documento')
		
	case 'b_cerrar_organizacion', 'b_grabar_organizacion'
		if this.dataobject = 'dw_organizacion' then
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
		this.reset()
		this.scrolltorow(this.insertrow(0))
		this.setitem(this.getrow(),'prod_g_financiero', str.g_financiero)
		this.setitem(this.getrow(),'prod_empresa', str.empresa)
	case 'b_grabar_producto'
		if this.getitemstring(1,'prod_producto') = '' or isnull(this.getitemstring(1,'prod_producto')) then 
			gf_mensaje('','Debe asignar el codigo del producto para grabar, verifique !!!',1,1,'E')
			return 2
		end if
		if this.getitemstring(1,'prod_descripcion') = '' or isnull(this.getitemstring(1,'prod_descripcion')) then 
			gf_mensaje('','Debe asignar la descripcion del producto para grabar, verifique !!!',1,1,'E')
			return 2
		end if		

		if this.update() = -1 then
			gf_mensaje('','Error al actualizar los productos '+sqlca.sqlerrtext,1,1,'E')
		else
			commit;
			ls_producto = this.getitemstring(1,'prod_producto')
			dw_4.retrieve(str.g_financiero, str.empresa)
			ll_encontro = dw_4.find("prod_producto = '"+ls_producto+"'", 1, dw_4.rowcount())
			if ll_encontro > 0 then
				dw_4.scrolltorow(ll_encontro)
			end if
		end if		
	case 'b_cerrar_producto'
		if this.getitemstring(1,'prod_producto') = '' or isnull(this.getitemstring(1,'prod_producto')) then 
			this.visible = false
			return
		end if			

		if this.update() = -1 then
			gf_mensaje('','Error al actualizar los productos '+sqlca.sqlerrtext,1,1,'E')
		end if		
		this.visible = false
	case 'b_eliminar_producto'
		ls_producto = this.getitemstring(1,'prod_producto')
		if ls_producto = '' or isnull(ls_producto) then return 		
		
		select count(*)
		into :li_conteo
		from indmovim
		where dmov_g_financiero = :str.g_financiero and
				dmov_empresa		= :str.empresa and
				dmov_producto		= :ls_producto ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al verificar existencia '+sqlca.sqlerrtext,1,1,'E')
				end if
		
		if li_conteo > 0 then
			gf_mensaje('','No se puede eliminar un producto que tiene movimientos, verifique el kardex !!!',1,1,'E')
			return
		end if
		
		if gf_mensaje('','Esta seguro de eliminar el producto ?',2,1,'E') = 2 then return
				
		this.deleterow(this.getrow())
		if this.update() = -1 then
			gf_mensaje('','Error al eliminar los productos '+sqlca.sqlerrtext,1,1,'E')
		end if		
		this.reset()
		this.scrolltorow(this.insertrow(0))
		this.setitem(this.getrow(),'prod_g_financiero', str.g_financiero)
		this.setitem(this.getrow(),'prod_empresa', str.empresa)		
	case	'b_adicionar_prov'
		this.reset()
		this.insertrow(1)
		this.setcolumn('dgmterce_terc_tercero')
		select max(terc_tercero) into :ll_tercero
		from dgmterce ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al seleccionar tercero',1,1,'E')
		end if
		this.setitem(1,'dgmterce_terc_tercero',ll_tercero + 1)		
	case 'b_eliminar_prov'
		
		string ls_error
		if gf_mensaje('','Esta Seguro de Eliminar el Proveedor ?',2,1,'E') = 1 then
			sqlca.autocommit = false
			ll_tercero = this.getitemnumber(this.getrow(), 'dgmterce_terc_tercero')
			  DELETE FROM cpmprove  
				WHERE ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
						( cpmprove.prov_empresa = :str.empresa ) AND  
						( cpmprove.prov_tercero = :ll_tercero )   ;
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					gf_mensaje('','Error al Elimiar proveedores cpmprovee '+ls_error,1,1,'E')				
					sqlca.autocommit = true
					return
				end if
			
			this.deleterow(this.getrow())			
			if this.update() = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				gf_mensaje('','Error al Elimiar proveedores '+ls_error,1,1,'E')				
				sqlca.autocommit = true
				return
			else
				commit;
			end if
			sqlca.autocommit = true			
			this.insertrow(1)
			this.setcolumn('dgmterce_terc_tercero')			
		end if
	case 'b_cerrar_prov'
		this.visible = false
	case	'b_grabar_prov'
		string ls_contacto, ls_cargo, ls_observacion, ls_telefono, ls_codigo, ls_ruc, ls_tipo_persona, ls_digito		
		integer li_pais, li_existe
		
		sqlca.autocommit = false
		
		if this.update() = -1 then
		  if sqlca.sqlcode = -1 then
			 gf_mensaje('','Error al Actualizar proveedor dw_1 '+sqlca.sqlerrtext,1,1,'E')
			 rollback ;
			 sqlca.autocommit = true
			 return
		  end if
		else
			row = 1
			ls_contacto = this.getitemstring(row, 'prov_contacto')
			ls_cargo		= this.getitemstring(row, 'prov_contacto_cargo')
			ls_telefono	= this.getitemstring(row, 'prov_contacto_telefono')
			ls_codigo	= this.getitemstring(row, 'prov_cod_proveedor')
			ls_observacion = this.getitemstring(row, 'prov_comentario')
			ll_tercero	= this.getitemnumber(row,'dgmterce_terc_tercero')
			ls_ruc		= this.getitemstring(row, 'dgmterce_terc_identificacion')
			li_pais		= this.getitemnumber(row, 'dgmterce_terc_pais')
			ls_tipo_persona = this.getitemstring(row, 'dgmterce_terc_tipo_persona')
			ls_digito	= this.getitemstring(row, 'dgmterce_terc_digito_verificador')
		
		  SELECT count(*)  
			 INTO :li_existe  
			 FROM cpmprove  
			WHERE ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
					( cpmprove.prov_empresa = :str.empresa ) AND  
					( cpmprove.prov_tercero = :ll_tercero ) ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al validar proveedores '+sqlca.sqlerrtext,1,1,'E')
				end if				
			if li_existe = 0 or isnull(li_existe) then //Si no existe, crea el proveedor
		
			  INSERT INTO cpmprove  
					( prov_g_financiero,   
					  prov_empresa,   
					  prov_tercero,   
					  prov_mg_cuenta,   
					  prov_cod_proveedor,   
					  prov_limite_credito,   
					  prov_ruc_tercero,   
					  prov_contacto,   
					  prov_contacto_cargo,   
					  prov_contacto_telefono,   
					  prov_clasificacion,   
					  prov_comentario,   
					  prov_estado,   
					  prov_pais,   
					  prov_contrato_s_n,   
					  prov_digito_verificador,   
					  prov_tipo_persona)  
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
					  '1',   
					  :ls_observacion,   
					  'A',   
					  :li_pais,    
					  0,   
					  :ls_digito,   
					  :ls_tipo_persona )  ;
			  
				  if sqlca.sqlcode = -1 then
					 gf_mensaje('','Error al Insertar proveedor '+sqlca.sqlerrtext,1,1,'E')
					 rollback ;
					 sqlca.autocommit = true
					 return					 
				  end if
			
			else //Si ya existe, actualiza los datos
							
				update cpmprove  
					set prov_cod_proveedor = :ls_codigo,   
						  prov_ruc_tercero = :ls_ruc,    
						  prov_contacto = :ls_contacto,   
						  prov_contacto_cargo = :ls_cargo,      
						  prov_contacto_telefono = :ls_telefono,   
						  prov_comentario = :ls_observacion,   
						  prov_pais	= :li_pais,    
						  prov_contrato_s_n = 0,   
						  prov_digito_verificador =  :ls_digito,
						  prov_tipo_persona = :ls_tipo_persona
				  where prov_g_financiero = :str.g_financiero and
						  prov_empresa		= :str.empresa and
						  prov_tercero		= :ll_tercero ;
				  if sqlca.sqlcode = -1 then
					 gf_mensaje('','Error al Actualizar proveedor '+sqlca.sqlerrtext,1,1,'E')
					 rollback ;
					 sqlca.autocommit = true
					 return
				  end if
				
			end if
		
		end if //del update del dw_1

		commit;
		
		sqlca.autocommit = true
	case 'b_adicionar_material'
		this.scrolltorow(dw.insertrow(0))
		this.setcolumn('mat_descripcion')
		this.setitem(this.getrow(),'mat_g_financiero', str.g_financiero)
		this.setitem(this.getrow(),'mat_empresa', str.empresa)

//		  SELECT max(convert(numeric(5), cramaterial.mat_cod_material))  
//			 INTO :ll_max  
//			 FROM cramaterial  
//			WHERE ( cramaterial.mat_g_financiero = :str.g_financiero ) AND  
//					( cramaterial.mat_empresa = :str.empresa ) and (convert(numeric(5), cramaterial.mat_cod_material) < 999)  ;
//			if sqlca.sqlcode = -1 then
//				gf_mensaje('','Error al buscar secuencia '+sqlca.sqlerrtext,1,1,'E')
//			end if

//			ll_max ++
			
//			this.setitem(this.getrow(),'mat_cod_material',string(ll_max))
		Case 'b_grabar_material'
			if this.update() = -1 then
			gf_mensaje('','Error al actualizar los Materiales '+sqlca.sqlerrtext,1,1,'E')
		end if
//		this.retrieve(str.g_financiero, str.empresa, this.getitemstring(1,'prod_producto'))
		Case 'b_cerrar_material','b_cerrar_sexos'
				this.visible = false
		case 'b_eliminar_material','b_eliminar_sexos'
				this.deleterow(row)
		case 'b_adicionar_sexos'
			dw.scrolltorow(dw.insertrow(0))
			dw.setcolumn('sex_codigo')
			this.setitem(this.getrow(),'sex_g_financiero', str.g_financiero)
			this.setitem(this.getrow(),'sex_empresa', str.empresa)	
		case 'b_grabar_sexos'
			if this.update() = -1 then
				gf_mensaje('','Error al actualizar los sexos '+sqlca.sqlerrtext,1,1,'E')
			end if
		case 'b_tallas'
			ls_sexo = this.getitemstring(row,'sex_codigo')
			lstr_sex.categoria = ls_sexo
	    	lstr_sex.descripcion = this.getitemstring(row,'sex_desc_eng')
			this.scrolltorow(row)
			opensheetwithparm(w_tallas_x_sexo, lstr_sex, str.frame ,12, original!)		
		case 'b_marca'
			ls_sexo = this.getitemstring(row,'sex_codigo')
			lstr_sex.categoria = ls_sexo
	    	lstr_sex.descripcion = this.getitemstring(row,'sex_desc_eng')
			this.scrolltorow(row)
			opensheetwithparm(w_marcas_x_sexo, lstr_sex, str.frame ,12, original!)
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

event itemchanged;call super::itemchanged;String ls_codigo, ls_nulo
long 	 ll_fila, ll_tercero, ll_pais
integer li_existe

this.accepttext()
Setnull(ls_nulo)

choose case this.getcolumnname() 
	case  "prod_producto"
		str.frame.setredraw(false)
		data = this.getitemstring(this.getrow(), 'prod_producto')
		if this.retrieve(str.g_financiero, str.empresa, data) = 0 then
			this.insertrow(1)
			this.setitem(1,'prod_g_financiero',str.g_financiero)
			this.setitem(1,'prod_empresa',str.empresa)
			this.setitem(1,'prod_producto',data)
			this.setcolumn('prod_producto')
		end if
		str.frame.setredraw(true)		
	case	"prod_division"
		//Se blanquean las columnas dependientes
		This.SetItem(row,"prod_grupo",ls_nulo)
	CASE "prod_grupo"	
		//Se setea el Arancel por Default del Grupo Seleccionado
		data = this.getitemstring(this.getrow(), 'prod_producto')
		IF Not (IsNull (data)) Then
			ll_fila = idwc_grupo.Find("#1 = '" + data + "'", 1, idwc_grupo.Rowcount())
			if ll_fila <> 0 then &
			ls_nulo = idwc_grupo.GetItemString(ll_fila, "agru_arancel_default")
			
			IF Not(IsNull(ls_nulo)) Then This.SetItem(row, "prod_arancel", ls_nulo)

		End If
	case "dgmterce_terc_pais"
		//if this.dataobject <> 'dw_producto' then return
		//data = this.getitemstring(this.getrow(), 'prod_producto')
		idwc_region.Retrieve (long (data))

	case "dgmterce_terc_tercero"
		
		data = this.getitemstring(this.getrow(), 'prod_producto')		
		ll_tercero = long(data)
		
		  SELECT count(*)
			 INTO :li_existe  
			 FROM cpmprove  
			WHERE ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
					( cpmprove.prov_empresa = :str.empresa ) AND  
					( cpmprove.prov_tercero = :ll_tercero ) ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al validar proveedor '+sqlca.sqlerrtext,1,1,'E')
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
		case 'movi_tercero'
			ll_tercero = long(data)
			SELECT prov_cod_proveedor
			 INTO :ls_codigo
			 FROM cpmprove  
			WHERE ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
					( cpmprove.prov_empresa = :str.empresa ) AND  
					( cpmprove.prov_tercero = :ll_tercero ) ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al validar proveedor '+sqlca.sqlerrtext,1,1,'E')
					return
				end if
			this.setitem(this.getrow(),'movi_ruc_tercero',ls_codigo)
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

if not lb_exist_nextcol then
	if not ib_no_insertar then
		if this.getrow() = this.rowcount() then
			if messagebox('Información','¿Desea Insertar otro Registro?',Information!,Yesno!,1) = 1 then
				if ib_adicionar then
					lw_window.triggerevent('ue_adicionar')
				else
					this.InsertRow(0)
				end if
			else
				return 1
			end if
		else
			Send(Handle(this),256,9,long(0,0))
		end if
	else
		Send(Handle(this),256,9,long(0,0))
	end if
else
	Send(Handle(this),256,9,long(0,0))
end if

return 1

end event

event ue_dwnkey;//override
CHOOSE CASE key
		
	CASE KeyF1! 

			if this.dataobject = 'dw_producto' then
				This.Postevent("ue_helpcol")
			end if
end choose
end event

event buttonclicked;call super::buttonclicked;string ls_producto

if dw_3.dataobject = 'dw_producto' then	
	
	choose case dwo.name
		case 'b_top'
			dw_4.scrolltorow(1)		
			ls_producto = dw_4.getitemstring(dw_4.getrow(),'prod_producto')
			dw_3.setitem(1,'prod_producto',ls_producto)
			dw_3.setcolumn('prod_producto')
			dw_3.trigger event itemchanged(1,dw_3.object,ls_producto)			
			
		case 'b_back'		
			dw_4.scrollpriorrow()		
			ls_producto = dw_4.getitemstring(dw_4.getrow(),'prod_producto')
			dw_3.setitem(1,'prod_producto',ls_producto)
			dw_3.setcolumn('prod_producto')
			dw_3.trigger event itemchanged(1,dw_3.object,ls_producto)			
			
		case 'b_next'
			if row = 0 then return
			ls_producto = this.getitemstring(1,'prod_producto')
			if ls_producto = '' or isnull(ls_producto) then
				dw_4.scrolltorow(1)
			else
				dw_4.scrollnextrow()		
			end if
			ls_producto = dw_4.getitemstring(dw_4.getrow(),'prod_producto')
			dw_3.setitem(1,'prod_producto',ls_producto)
			dw_3.setcolumn('prod_producto')
			dw_3.trigger event itemchanged(1,dw_3.object,ls_producto)			
			
		case 'b_bottom'		
			dw_4.scrolltorow(dw_4.rowcount())
			ls_producto = dw_4.getitemstring(dw_4.getrow(),'prod_producto')
			dw_3.setitem(1,'prod_producto',ls_producto)
			dw_3.setcolumn('prod_producto')
			dw_3.trigger event itemchanged(1,dw_3.object,ls_producto)			
	end choose

end if
end event

type gb_4 from gb_1 within w_parametros_entradas
integer y = 384
integer width = 3616
integer height = 1908
integer taborder = 140
end type

type em_ann from editmask within w_parametros_entradas
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

type dw_2 from datawindow within w_parametros_entradas
boolean visible = false
integer x = 2002
integer y = 420
integer width = 2487
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

event buttonclicked;long ll_codigo
string ls_codigo, ls_find
choose case dwo.name
	case 'b_buscar'
		
		str_dg_dynamic_find	lstr_df
	
		lstr_df.texto_campo [2,1] = "feproductos.codproducto" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [2,2] = "Codigo"
		lstr_df.texto_campo [2,3] = "codproducto"
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '450'
		lstr_df.texto_campo [1,1] = "feproductos.nomproducto"
		lstr_df.texto_campo [1,2] = "Descripción"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '1000'		
		
		lstr_df.tabla = " feproductos "
		
		
		lstr_df.tabla_where = &
					"WHERE ( feproductos.tipo = 'D' ) "				
		
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	If len (ls_find) = 0 Then Return
		
		
	ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo,"'"," ")
	ls_codigo = Trim(ls_codigo)
	ll_codigo = long(ls_codigo)
	this.setitem(row,'agru_tipo_producto',ll_codigo)

end choose

end event

type dw_4 from datawindow within w_parametros_entradas
boolean visible = false
integer x = 59
integer y = 892
integer width = 357
integer height = 500
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_find_productos"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_5 from datawindow within w_parametros_entradas
integer x = 27
integer y = 44
integer width = 5083
integer height = 304
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_entradas"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;long ll_codigo, ll_pais, ll_tercero
integer li_encontro
string ls_ventana, ls_division, ls_masca
datetime ldt_fecha
datawindowchild ldwc_child

dw_2.visible = false
dw_3.width = 2000
dw_3.height = 1844
dw_6.visible = false
choose case dwo.name 
	case 'o4_opcion2'
		dw_3.dataobject = 'dw_descripciones'
		dw_3.title =	'Descripciones'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
			dw_3.insertrow(1)
		end if						
		dw_3.width = 2300
	case 'o1_opcion1'
		dw_3.dataobject = 'dw_aranceles'
		dw_3.title =	'Aranceles de Productos'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve() = 0 then
			dw_3.insertrow(1)
		end if
	case 'o1_opcion2'
		dw_3.dataobject = 'dw_marcas'
		dw_3.title =	'Marcas de Productos'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
			dw_3.insertrow(1)
		end if
	case 'o1_opcion3'
		dw_3.dataobject = 'dw_colores'
		dw_3.title =	'Colores'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
			dw_3.insertrow(1)
		end if
	case 'o2_opcion1'
		dw_3.dataobject = 'dw_tamanos'
		dw_3.title =	'Definicion de Tamaños'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
			dw_3.insertrow(1)
		end if		
	case 'o2_opcion2'
		dw_3.dataobject = 'dw_compuestos'
		dw_3.title =	'Composición de los Productos'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
			dw_3.insertrow(1)
		end if				
	case 'o2_opcion3'
		dw_3.dataobject = 'dw_organizacion'
		dw_3.title =	'Division o Departamento'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
			dw_3.insertrow(1)
		end if						
		dw_3.width = 2000
		dw_2.dataobject = 'dw_grupos'
		dw_2.title =	'Grupos o Secciones'
		dw_2.settransobject(sqlca)
		dw_2.visible = true		
		if dw_3.rowcount() > 0 then
			ls_division = dw_3.getitemstring(1,'adiv_codigo_div')
			dw_2.retrieve(str.g_financiero, str.empresa, ls_division)
		end if
	case	'o3_opcion1'
		dw_3.dataobject = 'dw_paises'
		dw_3.title =	'Configuracion de Paises'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve() = 0 then
			dw_3.insertrow(1)
		end if	
		dw_3.width = 1800		
		dw_2.dataobject = 'dw_puertos'
		dw_2.title =	'Puertos Destinos / Origenes'
		dw_2.settransobject(sqlca)
		dw_2.visible = true		
		if dw_3.rowcount() > 0 then
			ll_pais = dw_3.getitemnumber(1,'pais_pais')
			dw_2.retrieve(ll_pais)
		end if		
	case 'o3_opcion3'
		dw_3.dataobject = 'dw_periodo_reporte'
		dw_3.title =	'Periodos del Inventario Sin Movimiento'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve() = 0 then
			dw_3.insertrow(1)
		end if				
	case 'o3_opcion4'
		dw_3.height = 1048
		dw_3.dataobject = 'dw_cuentas_entradas'
		dw_3.title =	'Cuentas de Costos por Tipo de Entrada de Mercancia'
		
		dw_6.settransobject(sqlca)
		dw_6.getchild('para_cuenta_descuento', ldwc_child)
		ldwc_child.settransobject(sqlca)
		ldwc_child.retrieve(str.g_financiero, str.empresa)
		ls_masca = gf_mascara()
		ldwc_child.MODIFY("para_cuenta_descuento.editmask.mask='"+ls_masca+"'")
		dw_6.retrieve(str.g_financiero, str.empresa)
		dw_6.visible = true
		
		dw_3.settransobject(sqlca)
		dw_3.getchild('serd_mgcuenta', ldwc_child)
		ldwc_child.settransobject(sqlca)
		ldwc_child.retrieve(str.g_financiero, str.empresa)
		ldwc_child.insertrow(1)
		ldwc_child.setitem(1,'mg_cuenta','')
		ls_masca = gf_mascara()
		ldwc_child.MODIFY("mg_cuenta.editmask.mask='"+ls_masca+"'") //cuenta que se graba en el detalle contable

		if dw_3.retrieve(str.g_financiero, str.empresa, 'IN', 'EN') = 0 then
			dw_3.insertrow(1)
			gf_mensaje('','Debe configurar las Transacciones para las Entradas, Verifique !!!',1,1,'E')
		end if				
	case 'o4_opcion1_1'
		opensheet(w_mant_gastos, str.frame)
	case 'o3_opcion5'
		dw_3.width = 2400
		dw_3.dataobject = 'dw_saldos_iniciales_cp'
		dw_3.title =	'Saldos Iniciales de los Proveedores'		
		dw_3.settransobject(sqlca)
		dw_3.getchild('movi_tercero', idwc_cliente)
		idwc_cliente.settransobject(sqlca)
		idwc_cliente.retrieve(str.g_financiero, str.empresa)
		idwc_cliente.insertrow(1)		
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
		  SELECT cpmparam.para_fecha_inicio  
			 INTO :ldt_fecha  
			 FROM cpmparam  
			WHERE ( cpmparam.para_g_financiero = :str.g_financiero ) AND  
					( cpmparam.para_empresa = :str.empresa )   ;

			dw_3.insertrow(1)			
			dw_3.setitem(1,'cpmparam_para_fecha_inicio',ldt_fecha)
			dw_3.setitem(1,'movi_g_financiero',str.g_financiero)
			dw_3.setitem(1,'movi_empresa',str.empresa)			
			dw_3.setitem(1,'movi_aplicacion','CP')
			dw_3.setitem(1,'movi_tipo_transaccion','NC')
			dw_3.setitem(1,'movi_sub_transaccion','9')			
			dw_3.setitem(1,'movi_naturaleza','C')			
			dw_3.setitem(1,'movi_fecha_tran', dw_3.getitemdatetime(1,'cpmparam_para_fecha_inicio'))
			dw_3.setitem(1,'movi_anno',year(date(dw_3.getitemdatetime(1,'cpmparam_para_fecha_inicio'))))			
			dw_3.setitem(1,'movi_usuario',str.usuario)			
			dw_3.setitem(1,'movi_estado','IM')			
		end if
	case 'o5_opcion1'
		dw_3.dataobject = 'dw_materiales_compo'
		dw_3.title =	'Materiales y Composición'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
			dw_3.insertrow(1)
		end if						
		dw_3.width = 3350
	case 'o5_opcion2'
		dw_3.dataobject = 'dw_sexos'
		dw_3.title =	'Sexos de Items'
		dw_3.settransobject(sqlca)
		if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
			dw_3.insertrow(1)
		end if						
		dw_3.width = 3500
		
end choose

dw_3.setfocus()
dw_3.visible = true		
		

end event

type dw_6 from datawindow within w_parametros_entradas
integer x = 23
integer y = 1556
integer width = 1998
integer height = 556
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "Cuenta de Descuento en Compras"
string dataobject = "dw_cuenta_descuento_compras"
boolean controlmenu = true
string icon = "Asterisk!"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

