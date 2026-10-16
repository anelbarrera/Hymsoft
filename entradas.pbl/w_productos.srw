//objectcomments Ventana del Mantenimiento de Productos
forward
global type w_productos from w_fa_padre
end type
type dw_2 from datawindow within w_productos
end type
type dw_3 from datawindow within w_productos
end type
type pb_1 from picturebutton within w_productos
end type
type st_1 from statictext within w_productos
end type
type dw_4 from datawindow within w_productos
end type
type dw_5 from datawindow within w_productos
end type
type pb_2 from picturebutton within w_productos
end type
type em_ann1 from editmask within w_productos
end type
type em_ann2 from editmask within w_productos
end type
type st_2 from statictext within w_productos
end type
type st_3 from statictext within w_productos
end type
type cb_pasar from commandbutton within w_productos
end type
type dw_6 from datawindow within w_productos
end type
type cb_ubicaciones from commandbutton within w_productos
end type
type pb_3 from picturebutton within w_productos
end type
type dw_7 from datawindow within w_productos
end type
type lb_1 from listbox within w_productos
end type
type lb_2 from listbox within w_productos
end type
type dw_9 from datawindow within w_productos
end type
end forward

global type w_productos from w_fa_padre
integer width = 4823
integer height = 2228
string title = "Mantenimiento de Productos"
boolean controlmenu = false
windowstate windowstate = maximized!
long backcolor = 12639424
string icon = "AppIcon!"
windowanimationstyle openanimation = bottomroll!
windowanimationstyle closeanimation = bottomslide!
dw_2 dw_2
dw_3 dw_3
pb_1 pb_1
st_1 st_1
dw_4 dw_4
dw_5 dw_5
pb_2 pb_2
em_ann1 em_ann1
em_ann2 em_ann2
st_2 st_2
st_3 st_3
cb_pasar cb_pasar
dw_6 dw_6
cb_ubicaciones cb_ubicaciones
pb_3 pb_3
dw_7 dw_7
lb_1 lb_1
lb_2 lb_2
dw_9 dw_9
end type
global w_productos w_productos

type prototypes
Function long ShellExecute( long hwnd,  string lpOperation, string lpFile, string lpParameters,  string lpDirectory,  integer nShowCmd ) Library "shell32.dll"   alias for "ShellExecuteW"
end prototypes

type variables
string  is_tipo,is_pedido, is_cadena_costo, is_foto, is_foto_catalogo
integer ii_ann, ii_child_row, ii_detalla_brillantes, ii_letra_por_default, ii_copiar_referencia, ii_descripcion_fija
Long    il_proveedor


datawindowchild idw_child, idwc_grupo, idwc_region, idwc_empresas, idwc_nivel1, idwc_nivel2,&
 idwc_nivel3, idwc_nivel4, idwc_nivel5, idwc_descripciones, idwc_sexo,idwc_desc_item,idwc_tallas
end variables

forward prototypes
public function boolean wf_child_productos ()
public function boolean wf_busca_productos ()
public subroutine wf_setear_producto (string as_producto)
public subroutine wf_oculta_botones (boolean ab_flag)
end prototypes

public function boolean wf_child_productos ();//override
String	ls_expresion
Integer	li_pos
datawindowchild ldwc_division, ldwc_subg, ldwc_clase, ldwc_arancel, ldwc_clase_prod, ldwc_tipo, &
					 ldwc_espec, ldwc_proveedor, ldwc_condicion, ldwc_color, ldwc_tama, ldwc_marca, &
					 ldwc_provee, ldwc_brillantes,ldwc_materiales
dw = dw_1

sqlca.autocommit= true

dw_1.settransobject(sqlca)

dw_1.getchild('prod_division', ldwc_division)
ldwc_division.settransobject(sqlca)
ldwc_division.retrieve(str.g_financiero, str.empresa)
ldwc_division.insertrow(1)

dw_1.getchild('prod_grupo', idwc_grupo)
idwc_grupo.settransobject(sqlca)
idwc_grupo.retrieve(str.g_financiero, str.empresa)
idwc_grupo.insertrow(1)

dw_1.getchild('prod_marca', ldwc_marca)
ldwc_marca.settransobject(sqlca)
ldwc_marca.retrieve(str.g_financiero, str.empresa)
ldwc_marca.insertrow(1)

dw_1.getchild('prod_arancel', ldwc_arancel)
ldwc_arancel.settransobject(sqlca)
ldwc_arancel.retrieve(str.g_financiero, str.empresa)
ldwc_arancel.insertrow(1)

dw_1.getchild('prod_compuesto', ldwc_espec)
ldwc_espec.settransobject(sqlca)
ldwc_espec.retrieve(str.g_financiero, str.empresa)
ldwc_espec.insertrow(1)

dw_1.getchild('prod_color', ldwc_color)
ldwc_color.settransobject(sqlca)
ldwc_color.retrieve(str.g_financiero, str.empresa)
ldwc_color.insertrow(1)

dw_1.getchild('prod_cod_clase_tam', idwc_tallas)
idwc_tallas.settransobject(sqlca)
idwc_tallas.retrieve(str.g_financiero, str.empresa)
idwc_tallas.insertrow(1)

dw_1.getchild('prod_tercero', ldwc_provee)
ldwc_provee.settransobject(sqlca)
ldwc_provee.retrieve(str.g_financiero, str.empresa)
ldwc_provee.insertrow(1)

dw_1.getchild('prod_cod_brillante1', ldwc_brillantes)
ldwc_brillantes.settransobject(sqlca)
ldwc_brillantes.retrieve(str.g_financiero, str.empresa)
ldwc_brillantes.insertrow(1)

dw_1.getchild('prod_cod_brillante2', ldwc_brillantes)
ldwc_brillantes.settransobject(sqlca)
ldwc_brillantes.retrieve(str.g_financiero, str.empresa)
ldwc_brillantes.insertrow(1)

dw_1.getchild('prod_cod_brillante3', ldwc_brillantes)
ldwc_brillantes.settransobject(sqlca)
ldwc_brillantes.retrieve(str.g_financiero, str.empresa)
ldwc_brillantes.insertrow(1)

dw_1.getchild('prod_cod_brillante4', ldwc_brillantes)
ldwc_brillantes.settransobject(sqlca)
ldwc_brillantes.retrieve(str.g_financiero, str.empresa)
ldwc_brillantes.insertrow(1)

dw_1.getchild('prod_nivel1',idwc_nivel1)
dw_1.getchild('prod_nivel2',idwc_nivel2)
dw_1.getchild('prod_nivel3',idwc_nivel3)
dw_1.getchild('prod_nivel4',idwc_nivel4)
dw_1.getchild('prod_nivel5',idwc_nivel5)
idwc_nivel1.settransobject(sqlca)
idwc_nivel2.settransobject(sqlca)
idwc_nivel3.settransobject(sqlca)
idwc_nivel4.settransobject(sqlca)
idwc_nivel5.settransobject(sqlca)
idwc_nivel1.retrieve(str.g_financiero, str.empresa)
idwc_nivel2.retrieve(str.g_financiero, str.empresa)
idwc_nivel3.retrieve(str.g_financiero, str.empresa)
idwc_nivel4.retrieve(str.g_financiero, str.empresa)
idwc_nivel5.retrieve(str.g_financiero, str.empresa)


dw_1.GetChild('inmprodu_prod_sexo',idwc_sexo)
idwc_sexo.settransobject(sqlca)
idwc_sexo.retrieve(str.g_financiero, str.empresa)
idwc_sexo.insertrow(0)



dw_1.GetChild('inmprodu_prod_desc_item',idwc_desc_item)
idwc_desc_item.settransobject(sqlca)
if idwc_desc_item.retrieve(str.g_financiero, str.empresa) = 0 then
	idwc_desc_item.insertrow(1)
	gf_mensaje('','Debe crear las descripciones de productos, Verifique !!!',1,1,'E')
end if


dw_1.GetChild('inmprodu_prod_material',ldwc_materiales)
ldwc_materiales.settransobject(sqlca)
if ldwc_materiales.retrieve(str.g_financiero, str.empresa) = 0 then
	ldwc_materiales.insertrow(1)
	gf_mensaje('','Debe crear los materiales de productos, Verifique !!!',1,1,'E')
end if
return true
end function

public function boolean wf_busca_productos ();//Busqueda del producto
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
dw_1.setitem(dw_1.getrow(),'prod_producto',ls_codigo)
dw_1.accepttext()
//dw_3.trigger event itemchanged(dw_3.getrow(), dwobject, ls_codigo)
end function

public subroutine wf_setear_producto (string as_producto);integer ll_encontro

dw_1.setitem(dw_1.getrow(),'prod_producto',as_producto)
dw_1.setcolumn('prod_producto')

ll_encontro = dw_2.find("prod_producto = '"+as_producto+"'", 1, dw_2.rowcount())
if ll_encontro > 0 then
	dw_2.scrolltorow(ll_encontro)
end if
dw_1.accepttext()
dw_1.trigger event itemchanged(dw_1.getrow(), dw_1.object, as_producto)

//w_buscar_producto_mantener_abierta.uo_1.postevent('ue_cancelar')

end subroutine

public subroutine wf_oculta_botones (boolean ab_flag);dw_1.Object.b_eliminar_producto.visible = ab_flag
dw_1.Object.b_cerrar_producto.visible = ab_flag
dw_1.Object.b_grabar_producto.visible = ab_flag
dw_1.Object.b_adicionar_producto.visible = ab_flag
end subroutine

on w_productos.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_3=create dw_3
this.pb_1=create pb_1
this.st_1=create st_1
this.dw_4=create dw_4
this.dw_5=create dw_5
this.pb_2=create pb_2
this.em_ann1=create em_ann1
this.em_ann2=create em_ann2
this.st_2=create st_2
this.st_3=create st_3
this.cb_pasar=create cb_pasar
this.dw_6=create dw_6
this.cb_ubicaciones=create cb_ubicaciones
this.pb_3=create pb_3
this.dw_7=create dw_7
this.lb_1=create lb_1
this.lb_2=create lb_2
this.dw_9=create dw_9
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.dw_4
this.Control[iCurrent+6]=this.dw_5
this.Control[iCurrent+7]=this.pb_2
this.Control[iCurrent+8]=this.em_ann1
this.Control[iCurrent+9]=this.em_ann2
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.cb_pasar
this.Control[iCurrent+13]=this.dw_6
this.Control[iCurrent+14]=this.cb_ubicaciones
this.Control[iCurrent+15]=this.pb_3
this.Control[iCurrent+16]=this.dw_7
this.Control[iCurrent+17]=this.lb_1
this.Control[iCurrent+18]=this.lb_2
this.Control[iCurrent+19]=this.dw_9
end on

on w_productos.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.pb_2)
destroy(this.em_ann1)
destroy(this.em_ann2)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_pasar)
destroy(this.dw_6)
destroy(this.cb_ubicaciones)
destroy(this.pb_3)
destroy(this.dw_7)
destroy(this.lb_1)
destroy(this.lb_2)
destroy(this.dw_9)
end on

event open;//override

// Forzar a la ventana hija a restaurar la ruta de las imágenes
 
SetCurrentDirectory(str.path)

wf_oculta_botones(false)
integer li_existe
string ls_path
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_5.settransobject(sqlca)
dw_2.retrieve(str.g_financiero, str.empresa)

wf_child_productos()

	select para_clave_costos, inaparam.para_foto_dir  ,  inaparam.para_foto_dir_catalogo , isnull(para_descripciones_fijas,0)   //Clave de Costos
		into : is_cadena_costo, :is_foto  , :is_foto_catalogo, :ii_descripcion_fija
		from inaparam
		where (para_g_financiero =: str.g_financiero) and
				(para_empresa =: str.empresa);
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al buscar clave '+sqlca.sqlerrtext,1,1,'E')
		end if

if ii_descripcion_fija = 1 then
	dw_1.getchild('prod_descripcion',idwc_descripciones)
	idwc_descripciones.settransobject(sqlca)
	idwc_descripciones.retrieve(str.g_financiero, str.empresa)
else
	dw_1.Modify("prod_descripcion.Edit.Case=Upper")
end if

dw_1.insertrow(1)
dw_1.setitem(1,'prod_g_financiero', str.g_financiero)
dw_1.setitem(1,'prod_empresa', str.empresa)
dw_1.setcolumn("prod_producto")

dw_7.insertrow(1)

//this.y = 0
//this.x = 0

//  SELECT isnull(dgmempre.empr_detallar_brillantes  ,0)
//    INTO :ii_detalla_brillantes  
//    FROM dgmempre  
//   WHERE ( dgmempre.empr_g_financiero = :str.g_financiero ) AND  
//         ( dgmempre.empr_empresa = :str.empresa )   ;
//	if sqlca.sqlcode = -1 then
//		gf_mensaje('','Error al Validar campo de Brillantes '+sqlca.sqlerrtext,1,1,'E')
//	end if
//ii_detalla_brillantes = 1

//if ii_detalla_brillantes = 1 then
//	this.height = 2136
//	dw_1.height = 1996
//	pb_1.visible = true
//	st_1.visible = true
//else
//	this.height = 1800
//	dw_1.height = 1656
//	pb_1.visible = false
//	st_1.visible = false
//end if

  SELECT count(*)  
    INTO :li_existe  
    FROM dgmempre,   
         inaparam  
   WHERE ( inaparam.para_g_financiero = dgmempre.empr_g_financiero ) and  
         ( inaparam.para_empresa = dgmempre.empr_empresa ) and  
         ( ( dgmempre.empr_g_financiero = :str.g_financiero ) AND  
         ( dgmempre.empr_empresa = :str.empresa ) AND  
         ( dgmempre.empr_empresa <> 1 ) )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al Validar Existencia de Empresa 2 '+sqlca.sqlerrtext,1,1,'E')
	end if

if li_existe > 0 then
	cb_pasar.visible = true
	dw_6.getchild('empresa', idwc_empresas)
	idwc_empresas.settransobject(sqlca)
	idwc_empresas.retrieve(str.g_financiero, str.empresa)
	dw_6.insertrow(1)
	dw_6.setitem(1,'empresa',idwc_empresas.getitemnumber(1,'empr_empresa'))
end if

  SELECT isnull(usua_letras_por_default,1)
    INTO :ii_letra_por_default  
    FROM usuarios  
   WHERE usuarios.usua_id = :str.usuario   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al buscar parametro '+sqlca.sqlerrtext,1,1,'E')
	end if

	dw_1.setitem(1,'ver_en_letras',ii_letra_por_default)



//pb_2.picturename = str.path+'\Art\graph.png'
//dw_1.modify("b_top.FileName = '"+str.path+"\Art\WZTOP.BMP"+"'")
//dw_1.modify("b_back.FileName = '"+str.path+"\Art\WZBACK.BMP"+"'")
//dw_1.modify("b_next.FileName = '"+str.path+"\Art\WZNEXT.BMP"+"'")
//dw_1.modify("b_bottom.FileName = '"+str.path+"\Art\WZEND.BMP"+"'")

em_ann1.text = string(year(relativedate(date(gf_fecha_serv()), -3650 )))
em_ann2.text = string(year(date(gf_fecha_serv())))

if  is_foto = '' or isnull(is_foto) then 
	 is_foto = str.path
end if
ls_path = is_foto+'\*.jpg'	//Se hace con la finalidad de que al buscar los productos, 
									//se ubique en la ruta seleccionada en parametros, ruta para las fotos
lb_1.DirList(ls_path, 2)   //2 es archivos ocultos, para que no encuentre muchos
	
if  is_foto_catalogo = '' or isnull(is_foto_catalogo) then 
	 is_foto_catalogo = str.path
end if
ls_path = is_foto_catalogo+'\*.jpg'	//Se hace con la finalidad de que al buscar los productos, 
									//se ubique en la ruta seleccionada en parametros, ruta para las fotos
lb_2.DirList(ls_path, 2)   //2 es archivos ocultos, para que no encuentre muchos


string ls_producto
str_kardex  str_opcion

str_opcion = message.powerobjectparm

if isvalid(str_opcion) then		
	ls_producto = str_opcion.kproducto
	dw_1.setitem(1,'prod_producto',ls_producto)
	dw_1.setcolumn('prod_producto')
	dw_1.setfocus()
	dw_1.triggerevent('itemchanged')
end if
//w_hs_frame.Post Event ue_evaluar_panel_acciones()
end event

event resize;//override
end event

event close;call super::close;Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
 
end event

event closequery;call super::closequery;constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)

This.SetRedraw(false)
end event

event ue_aceptar;call super::ue_aceptar;String ls_contenido,ls_material,ls_producto,ls_nivel3,ls_nivel2,ls_nivel1,ls_prod
Long ll_encontro
Boolean lb_blanquear_costos

ls_contenido = dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_sexo')
		if ls_contenido = '' or isnull(ls_contenido) then
			gf_mensaje('','Debe Asignar el Sexo del Producto, Verifique !!!',1,1,'E')
			dw_1.setcolumn('inmprodu_prod_sexo')
			return
		end if
		ls_material = dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_material')
		if ls_material = '' or isnull(ls_material) then
			gf_mensaje('','Debe Asignar el Material del Producto, Verifique !!!',1,1,'E')
			dw_1.setcolumn('inmprodu_prod_material')
			return
		end if
		if dw_1.getitemstring(1,'prod_producto') = '' or isnull(dw_1.getitemstring(1,'prod_producto')) then 
			gf_mensaje('','Debe asignar el codigo del producto para grabar, verifique !!!',1,1,'E')
			dw_1.setcolumn('prod_producto')
			return 
		end if
		if dw_1.getitemstring(1,'prod_descripcion') = '' or isnull(dw_1.getitemstring(1,'prod_descripcion')) then 
			gf_mensaje('','Debe asignar la descripcion del producto para grabar, verifique !!!',1,1,'E')
			dw_1.setcolumn('prod_descripcion')
			return 
		end if		
		if dw_1.getitemstring(1,'prod_division') = '' or isnull(dw_1.getitemstring(1,'prod_division')) then 
			gf_mensaje('','Debe asignar la Division del producto para grabar, verifique !!!',1,1,'E')
			dw_1.setcolumn('prod_division')
			return 
		end if				
		if dw_1.getitemstring(1,'prod_grupo') = '' or isnull(dw_1.getitemstring(1,'prod_grupo')) then 
			gf_mensaje('','Debe asignar el Grupo del producto para grabar, verifique !!!',1,1,'E')
			dw_1.setcolumn('prod_grupo')
			return 
		end if				
		if dw_1.getitemstring(1,'prod_arancel') = '' or isnull(dw_1.getitemstring(1,'prod_arancel')) then 
			gf_mensaje('','Debe asignar el Arancel del producto para grabar, verifique !!!',1,1,'E')
			dw_1.setcolumn('prod_arancel')
			return 
		end if				
		if dw_1.getitemstring(1,'prod_marca') = '' or isnull(dw_1.getitemstring(1,'prod_marca')) then 
			gf_mensaje('','Debe asignar la Marca del producto para grabar, verifique !!!',1,1,'E')
			dw_1.setcolumn('prod_marca')
			return 
		end if				
		if dw_1.getitemstring(1,'prod_color') = '' or isnull(dw_1.getitemstring(1,'prod_color')) then 
			gf_mensaje('','Debe asignar el Color del producto para grabar, verifique !!!',1,1,'E')
			dw_1.setcolumn('prod_color')
			return 
		end if	

		if dw_1.getitemstring(1,'prod_cod_clase_tam') = '' or isnull(dw_1.getitemstring(1,'prod_cod_clase_tam')) then 
			gf_mensaje('','Debe asignar el Tamaño del producto para grabar, verifique !!!',1,1,'E')
			dw_1.setcolumn('prod_cod_clase_tam')
			return 
		end if				
		if dw_1.getitemstring(1,'prod_compuesto') = '' or isnull(dw_1.getitemstring(1,'prod_compuesto')) then 
			gf_mensaje('','Debe asignar la Composicion del producto para grabar, verifique !!!',1,1,'E')
			dw_1.setcolumn('prod_compuesto')
			return 
		end if				
		
		if dw_1.getitemnumber(1,'prod_pais') = 0 or isnull(dw_1.getitemNumber(1,'prod_pais')) then 
			gf_mensaje('','Debe asignar el Pais del producto para grabar, verifique !!!',1,1,'E')
			dw_1.setcolumn('prod_pais')
			return 
		end if				
		
		if dw_1.getitemstring(1,'prod_medida') = '' or isnull(dw_1.getitemstring(1,'prod_medida')) then 
			gf_mensaje('','Debe asignar la Medida del producto para grabar, verifique !!!',1,1,'E')
			dw_1.setcolumn('prod_medida')
			return 
		end if				
		if dw_1.getitemnumber(1,'prod_empaque') = 0 or isnull(dw_1.getitemNumber(1,'prod_empaque')) then 
			gf_mensaje('','Debe asignar el Empaque del producto para grabar, verifique !!!',1,1,'E')
			dw_1.setcolumn('prod_empaque')
			return 
		end if			
		if dw_1.getitemstring(1,'prod_empaque_um') = '' or isnull(dw_1.getitemstring(1,'prod_empaque_um')) then 
			gf_mensaje('','Debe asignar la Medida del Empaque del producto para grabar, verifique !!!',1,1,'E')
			dw_1.setcolumn('prod_empaque_um')
			return 
		end if						
		
		if str.empresa  = 1 and pos(str.empr_acceso_especial, 'GOLD,') > 0 then
			if dw_1.getitemstring(1,'prod_producto_dos') = '' or isnull(dw_1.getitemstring(1,'prod_producto_dos')) then 
				gf_mensaje('','Debe asignar la Referencia Alterna para grabar, verifique !!!',1,1,'E')
				dw_1.setcolumn('prod_producto_dos')
				return 
			end if		
		end if
		//Para que blanquee los costos y la reserva, cuando se copia un producto
		lb_blanquear_costos = false		
		if dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = New! or dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = NewModified! then 	
				lb_blanquear_costos = true
		end if
		dw_1.Accepttext()
		if dw_1.update() = -1 then
			gf_mensaje('','Error al actualizar los productos '+sqlca.sqlerrtext,1,1,'E')
			rollback;
		else
			if lb_blanquear_costos then
				ls_prod = dw_1.getitemstring(1,'prod_producto')
				  UPDATE inmprodu  
			  SET    
					prod_ultima_entrada_doc = '',   
					prod_ultima_entrada_can = 0,   
					prod_reserva_total = 0,   
					prod_entrada_fecha = null,   
					prod_salida_fecha = null,   
					prod_ultima_salida_doc = '',   
					prod_costo_ult_entrada = 0,   
					//prod_costo_promedio = 0,   
					prod_existencia1 = 0,   
					prod_existencia2 = 0,   
					prod_existencia3 = 0,   
					prod_existencia4 = 0,   
					prod_existencia5 = 0,   
					prod_existencia6 = 0,   
					prod_existencia7 = 0,   
					prod_reserva1 = 0,
					prod_reserva2 = 0,
					prod_reserva3 = 0,
					prod_reserva4 = 0,
					prod_reserva5 = 0,
					prod_reserva6 = 0,
					prod_reserva7 = 0															
			WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
					( inmprodu.prod_empresa = :str.empresa ) AND  
					( inmprodu.prod_producto = :ls_prod )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Blanquear datos del producto Copy '+sqlca.sqlerrtext,1,1,'E')
						rollback;
						return
					end if
					
					ls_nivel1 = dw_1.getitemstring(1,'prod_nivel1')
					ls_nivel2 = dw_1.getitemstring(1,'prod_nivel2')
					ls_nivel3 = dw_1.getitemstring(1,'prod_nivel3')
					
			end if
			commit;
			ls_producto = dw_1.getitemstring(1,'prod_producto')
			dw_1.retrieve(str.g_financiero, str.empresa,ls_producto)
			if dw_1.rowcount() > 0 then
				dw_1.setitem(1,'copiar',ii_copiar_referencia)
			end if
			dw_2.retrieve(str.g_financiero, str.empresa)
			ll_encontro = dw_2.find("prod_producto = '"+ls_producto+"'", 1, dw_2.rowcount())
			if ll_encontro > 0 then
				dw_2.scrolltorow(ll_encontro)
			end if
		end if
end event

event ue_adicionar;call super::ue_adicionar;	string ls_prod,ls_barra
	if dw_1.getitemnumber(1,'copiar')= 1 then 	
		setnull(ls_prod)
		setnull(ls_barra)	
		dw_1.RowsCopy(1,1, Primary!, dw_3, 1, Primary!)
		dw_3.setitem(1,"prod_producto",ls_prod)	
		dw_3.setitem(1,"prod_barra",ls_barra)	
		dw_3.setitem(1,"prod_existencia_total",0)	
		dw_3.setitem(1,"prod_foto_dir",'')
		dw_3.setitem(1,"prod_foto_catalogo",'')			
		dw_3.setitem(1,"prod_foto_editada",'')			
		dw_1.reset()
		dw_3.RowsCopy(1,1, Primary!, dw_1 , 1, Primary!)				
	else		
		dw_1.reset()
		dw_1.scrolltorow(dw_1.insertrow(0))
		dw_1.setitem(dw_1.getrow(),'prod_g_financiero', str.g_financiero)
		dw_1.setitem(dw_1.getrow(),'prod_empresa', str.empresa)				
	end if
	dw_1.setitem(1,'ver_en_letras',ii_letra_por_default)
end event

event ue_eliminar;call super::ue_eliminar;String ls_producto
Integer li_conteo


ls_producto = dw_1.getitemstring(1,'prod_producto')
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
				
		dw_1.deleterow(dw_1.getrow())
		if dw_1.update() = -1 then
			gf_mensaje('','Error al eliminar los productos '+sqlca.sqlerrtext,1,1,'E')
		end if		
		dw_1.reset()
		dw_1.scrolltorow(dw_1.insertrow(0))
		dw_1.setitem(dw_1.getrow(),'prod_g_financiero', str.g_financiero)
		dw_1.setitem(dw_1.getrow(),'prod_empresa', str.empresa)
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_productos
boolean visible = false
integer y = 0
integer width = 73
end type

type dw_1 from w_fa_padre`dw_1 within w_productos
event ue_enter pbm_dwnprocessenter
event ue_enter2 pbm_dwnprocessenter
integer x = 0
integer y = 0
integer width = 4704
integer height = 2092
string dataobject = "dw_producto"
boolean border = true
end type

event dw_1::ue_enter2;Send(Handle(this),256,9,Long(0,0)) 
return 1 
end event

event dw_1::buttonclicked;call super::buttonclicked;string ls_producto
if dw_2.rowcount() = 0 then return	
choose case dwo.name
	case 'b_buscar'
		this.triggerevent('ue_helpcol')
	case 'b_top'
		
		dw_2.scrolltorow(1)		
		ls_producto = dw_2.getitemstring(dw_2.getrow(),'prod_producto')
		dw_1.setitem(1,'prod_producto',ls_producto)
		dw_1.setcolumn('prod_producto')
		dw_1.trigger event itemchanged(1,dw_1.object,ls_producto)			
		
	case 'b_back'		
		dw_2.scrollpriorrow()		
		ls_producto = dw_2.getitemstring(dw_2.getrow(),'prod_producto')
		dw_1.setitem(1,'prod_producto',ls_producto)
		dw_1.setcolumn('prod_producto')
		dw_1.trigger event itemchanged(1,dw_1.object,ls_producto)			
		
	case 'b_next'
		if row = 0 then return
		ls_producto = this.getitemstring(1,'prod_producto')
		if ls_producto = '' or isnull(ls_producto) then
			dw_2.scrolltorow(1)
		else
			dw_2.scrollnextrow()		
		end if
		ls_producto = dw_2.getitemstring(dw_2.getrow(),'prod_producto')
		dw_1.setitem(1,'prod_producto',ls_producto)
		dw_1.setcolumn('prod_producto')
		dw_1.trigger event itemchanged(1,dw_1.object,ls_producto)			
		
	case 'b_bottom'		
		dw_2.scrolltorow(dw_2.rowcount())
		ls_producto = dw_2.getitemstring(dw_2.getrow(),'prod_producto')
		dw_1.setitem(1,'prod_producto',ls_producto)
		dw_1.setcolumn('prod_producto')
		dw_1.trigger event itemchanged(1,dw_1.object,ls_producto)			
end choose


end event

event dw_1::clicked;//override
integer i, li_conteo, li_rtn
boolean	lb_blanquear_costos = false
datawindowchild ldwc_proveedor
string ls_division, ls_producto, ls_filtro, ls_foto, ls_grupo, ls_color, ls_tama, ls_espec, &
		 ls_descrip, ls_nivel1, ls_nivel2, ls_nivel3,ls_contenido,ls_material
long ll_pais, ll_tercero, ll_row, ll_encontro
THIS.ACCEPTTEXT()
dw_2.ACCEPTTEXT()

choose case dwo.name 
	case 'armar_descripcion'
		ls_division = this.getitemstring(1,'prod_division')
		ls_grupo = this.getitemstring(1,'prod_grupo')
		ls_color = this.getitemstring(1,'prod_color')
		ls_tama = this.getitemstring(1,'prod_cod_clase_tam')
		ls_espec = this.getitemstring(1,'prod_compuesto')
		  SELECT max(agru_descripcion_grupo)  INTO :ls_grupo  FROM cragrupo  WHERE ( cragrupo.agru_g_financiero = :str.g_financiero ) AND  ( cragrupo.agru_empresa = :str.empresa ) AND  
			         ( cragrupo.agru_codigo_div = :ls_division ) AND  ( cragrupo.agru_codigo_grupo = :ls_grupo )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Buscar Grupo '+sqlca.sqlerrtext,1,1,'E')
					end if
		   SELECT max(acol_nombre_color)  INTO :ls_color  FROM cracolor  WHERE ( cracolor.acol_g_financiero = :str.g_financiero ) AND  ( cracolor.acol_empresa = :str.empresa ) AND  ( cracolor.acol_num_color = :ls_color )   ;			
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Buscar Color '+sqlca.sqlerrtext,1,1,'E')
					end if
		SELECT max(acta_descripcion)  INTO :ls_tama  FROM cracltam  WHERE ( cracltam.acta_g_financiero = :str.g_financiero ) AND  ( cracltam.acta_empresa = :str.empresa ) AND  ( cracltam.acta_cod_clase_tam = :ls_tama )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Buscar Tamaño '+sqlca.sqlerrtext,1,1,'E')
					end if
		 SELECT max(aesp_descripcion_espec)  INTO :ls_espec  FROM craespec  WHERE ( craespec.aesp_g_financiero = :str.g_financiero ) AND  ( craespec.aesp_empresa = :str.empresa ) AND  ( craespec.aesp_num_especificacion = :ls_espec )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Buscar Compuesto '+sqlca.sqlerrtext,1,1,'E')
					end if
		ls_descrip = ls_grupo+' '+ls_tama+' '+ls_color+' '+ls_espec
		this.setitem(1,'prod_descripcion',ls_descrip)
	case 'prod_foto_dir'
			if this.rowcount() = 0 then return
			ls_foto = this.getitemstring(1, "prod_foto_dir")
			if isvalid(w_imagen) then
				close(w_imagen)		
			end if
			openwithparm(w_imagen, ls_foto)
	case 'prod_foto_catalogo'
			if this.rowcount() = 0 then return
			ls_foto = this.getitemstring(1, "prod_foto_catalogo")
			if isvalid(w_imagen) then
				close(w_imagen)		
			end if
			openwithparm(w_imagen, ls_foto)
	case 'reserva', 'reserva_t'
			str_fa_formato lstr_datawindow
			lstr_datawindow.datawindow = "dw_fa_rep_reserva_existencia_new"
			ls_producto = dw_1.getitemstring(1,"prod_producto")
			lstr_datawindow.producto = ls_producto
			
			OpenSheetWithParm(w_disponibles,lstr_datawindow, str.frame,2, Original!)
	CASE "prod_grupo"
		//Se filtran los grupo por la división seleccionada
		ls_filtro = This.GetItemString(row,"prod_division")
		idwc_grupo.SetFilter("agru_codigo_div = '" + ls_filtro + "'")	
		li_rtn = idwc_grupo.Filter()	
		
	case 'b_kardex'
		Window lw_child_v				
		str_kardex  str_opcion
		
			str_opcion.opcion_menu = 'MCP'
			str_opcion.opcion_ventana    = 'P'
			str_opcion.dwpantalla     = 'dw_in_mcp_prod_kard_1'
			if str.contabiliza = 0 then
				str_opcion.dwreporte      = 'dw_in_mcp_prod_kard_2'
			else
				str_opcion.dwreporte      = 'dw_in_mcp_prod_kard_2_arriba'
			end if

			str_opcion.titulo_ventana = 'Movimiento del Producto (Kardex)'
			
			if this.rowcount() > 0 then
				ls_producto = this.getitemstring(this.getrow(),'prod_producto')				
			end if
			
			str_opcion.kproducto=ls_producto		
			
			window lw_win, lw_first
			lw_first = str.frame.GetFirstSheet()	
			lw_win = str.frame.GetNextSheet(lw_first)
				do while isvalid(lw_win)
					if lw_win.classname()  = "w_in_movi_prod_kardex" then
						//gf_mensaje('','Esta abierta  Dirigirse a DMC',1,1,'E')
						lw_win.BringToTop = TRUE
						w_in_movi_prod_kardex.wf_asignar(str_opcion.kproducto)
						return
					end if
					lw_win = str.frame.GetNextSheet(lw_win)					
				loop	
		
			OpenSheetWithParm(w_in_movi_prod_kardex,str_opcion,str.frame,2,Original!)		
		
			
	case 'b_adicionar_producto'
			if this.getitemnumber(1,'copiar')= 1 then 
				string ls_prod,ls_barra
				setnull(ls_prod)
				setnull(ls_barra)	
				this.RowsCopy(1,1, Primary!, dw_3, 1, Primary!)
				dw_3.setitem(1,"prod_producto",ls_prod)	
				dw_3.setitem(1,"prod_barra",ls_barra)	
				dw_3.setitem(1,"prod_existencia_total",0)	
				dw_3.setitem(1,"prod_foto_dir",'')
				dw_3.setitem(1,"prod_foto_catalogo",'')			
				dw_3.setitem(1,"prod_foto_editada",'')
			
				this.reset()
				dw_3.RowsCopy(1,1, Primary!, this , 1, Primary!)
				
			else		
				this.reset()
				this.scrolltorow(this.insertrow(0))
				this.setitem(this.getrow(),'prod_g_financiero', str.g_financiero)
				this.setitem(this.getrow(),'prod_empresa', str.empresa)
				
			end if
			dw_1.setitem(1,'ver_en_letras',ii_letra_por_default)
	case 'b_grabar_producto'
			ls_contenido = this.getitemstring(this.getrow(),'inmprodu_prod_sexo')
		if ls_contenido = '' or isnull(ls_contenido) then
			gf_mensaje('','Debe Asignar el Sexo del Producto, Verifique !!!',1,1,'E')
			this.setcolumn('inmprodu_prod_sexo')
			return
		end if
		ls_material = this.getitemstring(this.getrow(),'inmprodu_prod_material')
		if ls_material = '' or isnull(ls_material) then
			gf_mensaje('','Debe Asignar el Material del Producto, Verifique !!!',1,1,'E')
			this.setcolumn('inmprodu_prod_material')
			return
		end if
		if this.getitemstring(1,'prod_producto') = '' or isnull(this.getitemstring(1,'prod_producto')) then 
			gf_mensaje('','Debe asignar el codigo del producto para grabar, verifique !!!',1,1,'E')
			this.setcolumn('prod_producto')
			return 2
		end if
		if this.getitemstring(1,'prod_descripcion') = '' or isnull(this.getitemstring(1,'prod_descripcion')) then 
			gf_mensaje('','Debe asignar la descripcion del producto para grabar, verifique !!!',1,1,'E')
			this.setcolumn('prod_descripcion')
			return 2
		end if		
		if this.getitemstring(1,'prod_division') = '' or isnull(this.getitemstring(1,'prod_division')) then 
			gf_mensaje('','Debe asignar la Division del producto para grabar, verifique !!!',1,1,'E')
			this.setcolumn('prod_division')
			return 2
		end if				
		if this.getitemstring(1,'prod_grupo') = '' or isnull(this.getitemstring(1,'prod_grupo')) then 
			gf_mensaje('','Debe asignar el Grupo del producto para grabar, verifique !!!',1,1,'E')
			this.setcolumn('prod_grupo')
			return 2
		end if				
		if this.getitemstring(1,'prod_arancel') = '' or isnull(this.getitemstring(1,'prod_arancel')) then 
			gf_mensaje('','Debe asignar el Arancel del producto para grabar, verifique !!!',1,1,'E')
			this.setcolumn('prod_arancel')
			return 2
		end if				
		if this.getitemstring(1,'prod_marca') = '' or isnull(this.getitemstring(1,'prod_marca')) then 
			gf_mensaje('','Debe asignar la Marca del producto para grabar, verifique !!!',1,1,'E')
			this.setcolumn('prod_marca')
			return 2
		end if				
		if this.getitemstring(1,'prod_color') = '' or isnull(this.getitemstring(1,'prod_color')) then 
			gf_mensaje('','Debe asignar el Color del producto para grabar, verifique !!!',1,1,'E')
			this.setcolumn('prod_color')
			return 2
		end if	
//		if this.getitemstring(1,'prod_nivel1') = '' or isnull(this.getitemstring(1,'prod_nivel1')) then 
//			gf_mensaje('','Debe asignar el Nivel 1 del producto para grabar, verifique !!!',1,1,'E')
//			this.setcolumn('prod_nivel1')
//			return 2
//		end if	
//		if this.getitemstring(1,'prod_nivel2') = '' or isnull(this.getitemstring(1,'prod_nivel2')) then 
//			gf_mensaje('','Debe asignar el Nivel 2 del producto para grabar, verifique !!!',1,1,'E')
//			this.setcolumn('prod_nivel2')
//			return 2
//		end if	
//		if this.getitemstring(1,'prod_nivel3') = '' or isnull(this.getitemstring(1,'prod_nivel3')) then 
//			gf_mensaje('','Debe asignar el Nivel 3 del producto para grabar, verifique !!!',1,1,'E')
//			this.setcolumn('prod_nivel3')
//			return 2
//		end if	
//		if this.getitemstring(1,'prod_nivel4') = '' or isnull(this.getitemstring(1,'prod_nivel4')) then 
//			gf_mensaje('','Debe asignar el Nivel 4 del producto para grabar, verifique !!!',1,1,'E')
//			this.setcolumn('prod_nivel4')
//			return 2
//		end if	
		if this.getitemstring(1,'prod_cod_clase_tam') = '' or isnull(this.getitemstring(1,'prod_cod_clase_tam')) then 
			gf_mensaje('','Debe asignar el Tamaño del producto para grabar, verifique !!!',1,1,'E')
			this.setcolumn('prod_cod_clase_tam')
			return 2
		end if				
		if this.getitemstring(1,'prod_compuesto') = '' or isnull(this.getitemstring(1,'prod_compuesto')) then 
			gf_mensaje('','Debe asignar la Composicion del producto para grabar, verifique !!!',1,1,'E')
			this.setcolumn('prod_compuesto')
			return 2
		end if				
		
		if this.getitemnumber(1,'prod_pais') = 0 or isnull(this.getitemNumber(1,'prod_pais')) then 
			gf_mensaje('','Debe asignar el Pais del producto para grabar, verifique !!!',1,1,'E')
			this.setcolumn('prod_pais')
			return 2
		end if				
		
		if this.getitemstring(1,'prod_medida') = '' or isnull(this.getitemstring(1,'prod_medida')) then 
			gf_mensaje('','Debe asignar la Medida del producto para grabar, verifique !!!',1,1,'E')
			this.setcolumn('prod_medida')
			return 2
		end if				
		if this.getitemnumber(1,'prod_empaque') = 0 or isnull(this.getitemNumber(1,'prod_empaque')) then 
			gf_mensaje('','Debe asignar el Empaque del producto para grabar, verifique !!!',1,1,'E')
			this.setcolumn('prod_empaque')
			return 2
		end if			
		if this.getitemstring(1,'prod_empaque_um') = '' or isnull(this.getitemstring(1,'prod_empaque_um')) then 
			gf_mensaje('','Debe asignar la Medida del Empaque del producto para grabar, verifique !!!',1,1,'E')
			this.setcolumn('prod_empaque_um')
			return 2
		end if						
		
		if str.empresa  = 1 and pos(str.empr_acceso_especial, 'GOLD,') > 0 then
			if this.getitemstring(1,'prod_producto_dos') = '' or isnull(this.getitemstring(1,'prod_producto_dos')) then 
				gf_mensaje('','Debe asignar la Referencia Alterna para grabar, verifique !!!',1,1,'E')
				this.setcolumn('prod_producto_dos')
				return 2
			end if		
		end if
		//Para que blanquee los costos y la reserva, cuando se copia un producto
		lb_blanquear_costos = false		
		if dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = New! or dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = NewModified! then 	
				lb_blanquear_costos = true
		end if
		
		if this.update() = -1 then
			gf_mensaje('','Error al actualizar los productos '+sqlca.sqlerrtext,1,1,'E')
			rollback;
		else
			if lb_blanquear_costos then
				ls_prod = this.getitemstring(1,'prod_producto')
				  UPDATE inmprodu  
			  SET //prod_costo_fob = 0,   	//			//COMENTADO POR AHORA MIENTRAS EL PARALELO
					//prod_otros_gastos = 0,   
					//prod_costo_cif = 0,   
					//prod_costou_local = 0,   
					//prod_costo_unitario = 0,   
					prod_ultima_entrada_doc = '',   
					prod_ultima_entrada_can = 0,   
					prod_reserva_total = 0,   
					prod_entrada_fecha = null,   
					prod_salida_fecha = null,   
					prod_ultima_salida_doc = '',   
					prod_costo_ult_entrada = 0,   
					//prod_costo_promedio = 0,   
					prod_existencia1 = 0,   
					prod_existencia2 = 0,   
					prod_existencia3 = 0,   
					prod_existencia4 = 0,   
					prod_existencia5 = 0,   
					prod_existencia6 = 0,   
					prod_existencia7 = 0,   
					prod_reserva1 = 0,
					prod_reserva2 = 0,
					prod_reserva3 = 0,
					prod_reserva4 = 0,
					prod_reserva5 = 0,
					prod_reserva6 = 0,
					prod_reserva7 = 0															
			WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
					( inmprodu.prod_empresa = :str.empresa ) AND  
					( inmprodu.prod_producto = :ls_prod )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Blanquear datos del producto Copy '+sqlca.sqlerrtext,1,1,'E')
						rollback;
						return
					end if
					
					ls_nivel1 = dw_1.getitemstring(1,'prod_nivel1')
					ls_nivel2 = dw_1.getitemstring(1,'prod_nivel2')
					ls_nivel3 = dw_1.getitemstring(1,'prod_nivel3')
					
			end if
			commit;
			ls_producto = this.getitemstring(1,'prod_producto')
			dw_1.retrieve(str.g_financiero, str.empresa,ls_producto)
			if dw_1.rowcount() > 0 then
				dw_1.setitem(1,'copiar',ii_copiar_referencia)
			end if
			dw_2.retrieve(str.g_financiero, str.empresa)
			ll_encontro = dw_2.find("prod_producto = '"+ls_producto+"'", 1, dw_2.rowcount())
			if ll_encontro > 0 then
				dw_2.scrolltorow(ll_encontro)
			end if
		end if		
	case 'b_cerrar_producto'
		if this.getitemstring(1,'prod_producto') = '' or isnull(this.getitemstring(1,'prod_producto')) then 
			Parent.SetRedraw(false)
			close(Parent)
		else
			if this.update() = -1 then
				gf_mensaje('','Error al actualizar los productos '+sqlca.sqlerrtext,1,1,'E')
			end if	
			Parent.SetRedraw(false)
			close(Parent)
		end if
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
		
	case else
		
		//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
		//en la misma columna.
		
		string ls_objeto
		integer li_pos 
		
		ls_objeto = This.GetObjectAtPointer()
		
		li_pos 	 =  Pos(ls_objeto, "~t")
		ls_objeto = Left(ls_objeto, li_pos - 1)
		
		string	ls_nomfile, ls_path, ls_filter
		
		if ls_objeto = 't_foto' then
			
			ls_filter = "Achivos de Fotos (*.jpg),*.jpg," +&
							"Achivos de Fotos (*.jpeg),*.jpeg," +&
							"Archivos de Fotos (*.gif),*.gif," +&
							"Archivos de Fotos (*.png),*.png," +&							
							"Archivos de Fotos(*.bmp),*.bmp"
			
			li_rtn = GetFileOpenName("Asignar Foto ",ls_path,ls_nomfile,"jpg",ls_filter)
			
			if li_rtn = 1 then
				this.SetItem(this.Getrow(),"prod_foto_dir",ls_path)
			end if
		elseif ls_objeto = 't_foto_catalogo' then
			
			ls_filter = "Achivos de Fotos (*.jpg),*.jpg," +&
							"Achivos de Fotos (*.jpeg),*.jpeg," +&
							"Archivos de Fotos (*.gif),*.gif," +&
							"Archivos de Fotos (*.png),*.png," +&							
							"Archivos de Fotos(*.bmp),*.bmp"
			
			li_rtn = GetFileOpenName("Asignar Foto ",ls_path,ls_nomfile,"jpg",ls_filter)
			
			if li_rtn = 1 then
				this.SetItem(this.Getrow(),"prod_foto_catalogo",ls_path)
			end if
			
		end if
		
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

event dw_1::doubleclicked;call super::doubleclicked;string	ls_nomfile, ls_path, ls_filter, ls_producto
integer	li_rtn

if dwo.name = 'prod_foto_dir' then
	
	ls_filter = "Achivos de Fotos (*.jpg),*.jpg," +&
					"Archivos de Fotos (*.gif),*.gif," +&
					"Archivos de Fotos(*.bmp),*.bmp"
	
	li_rtn = GetFileOpenName("Asignar Foto ",ls_path,ls_nomfile,"jpg",ls_filter)
	
	if li_rtn = 1 then
		this.SetItem(this.Getrow(),"prod_foto_dir",ls_path)
	end if

elseif dwo.name = 'prod_producto_t' then
	ls_producto = this.getitemstring(1,'prod_producto')
	
	  SELECT inmprodu.prod_producto  
		 INTO :ls_producto  
		 FROM inmprodu  
		WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
				( inmprodu.prod_empresa = :str.empresa ) AND  
				( inmprodu.prod_producto = :ls_producto )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Buscar Producto '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
	
	if ls_producto <> '' and not isnull(ls_producto) then
		dw_7.visible = true
		dw_7.setfocus()
	end if

end if
end event

event dw_1::itemchanged;//override
String ls_codigo, ls_nulo, ls_filtro, ls_costo, ls_foto, ls_barra, ls_error, ls_barra_anterior,&
		 ls_marca, ls_division, ls_nivel2,ls_sexo,ls_define
long 	 ll_fila, ll_tercero, ll_pais
integer li_existe, li_rtn , ll_empaque, li_ann1, li_ann2, li_encontro, li_cnt,li_pos
datetime ldt_desde, ldt_hasta
decimal{2}  ld_ancho, ld_largo, ld_alto
decimal{3}  ld_total, ld_metros_cub, ld_temp
decimal{4} ld_cubicaje, ld_peso, ld_costo
boolean lb_entro
this.accepttext()
Setnull(ls_nulo)

//data = this.getitemstring(this.getrow(), 'prod_producto')
ll_empaque = this.getitemnumber(this.getrow(),"prod_empaque")
if ll_empaque = 0 or isnull(ll_empaque) then ll_empaque = 1

choose case this.getcolumnname() 
	case 'copiar'
		ii_copiar_referencia = integer(data)
	case "prod_descripcion"
		
		ls_nivel2 = trim(mid(data,1,pos(data,' ')))
		if ls_nivel2 = '' or isnull(ls_nivel2) then ls_nivel2 = data
		dw_1.setitem(1,'prod_nivel2',ls_nivel2)
		
		ls_codigo = this.getitemstring(this.getrow(), 'prod_producto')		
		if len(ls_codigo) = 0 or isnull(ls_codigo) then 			
			return
		end if
		
		
	case	"prod_division"
		//Se blanquean las columnas dependientes
		This.SetItem(row,"prod_grupo",ls_nulo)
		
		  SELECT cradivis.adiv_nombre_catalogo  
			 INTO :ls_division  
			 FROM cradivis  
			WHERE ( cradivis.adiv_g_financiero = :str.g_financiero ) AND  
					( cradivis.adiv_empresa = :str.empresa ) AND  
					( cradivis.adiv_codigo_div = :data)   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Buscar Nivel de Division '+sqlca.sqlerrtext,1,1,'E')
				end if
		
		dw_1.setitem(1,'prod_nivel1',ls_division)
		
		ls_codigo = this.getitemstring(this.getrow(), 'prod_producto')
		
		if len(ls_codigo) = 0 or isnull(ls_codigo) then 			
			return
		end if
		
	case "prod_cod_clase_tam"
		
		  SELECT cracltam.acta_descripcion  
			 INTO :ls_division  
			 FROM cracltam  
			WHERE ( cracltam.acta_g_financiero = :str.g_financiero ) AND  
					( cracltam.acta_empresa = :str.empresa ) AND  
					( cracltam.acta_cod_clase_tam = :data )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Buscar Nivel de Division '+sqlca.sqlerrtext,1,1,'E')
				end if
		
		dw_1.setitem(1,'prod_nivel4',ls_division)
		
		ls_codigo = this.getitemstring(this.getrow(), 'prod_producto')
		
		if len(ls_codigo) = 0 or isnull(ls_codigo) then 			
			return
		end if
		
	case "prod_marca"
		  SELECT cramarca.amar_nombre_marca  
		    INTO :ls_marca 	
			 FROM cramarca  
			WHERE ( cramarca.amar_g_financiero = :str.g_financiero ) AND  
					  ( cramarca.amar_empresa = :str.empresa ) AND  
					  ( cramarca.amar_num_marca = :data )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Buscar Marca '+sqlca.sqlerrtext,1,1,'E')
				end if
		dw_1.setitem(1,'prod_nivel3',ls_marca)
		
		ls_codigo = this.getitemstring(this.getrow(), 'prod_producto')		
		if len(ls_codigo) = 0 or isnull(ls_codigo) then 			
			return
		end if
	case "prod_barra"
		
		ls_barra = this.getitemstring(this.getrow(), 'prod_barra')
		ls_barra_anterior = this.getitemstring(this.getrow(), 'prod_barra', primary!, true)
		
		Select count(*)
		Into   :li_cnt
		From   inmprodu
		Where  prod_g_financiero = :str.g_financiero And 
				 prod_empresa      = :str.empresa      And
				 prod_barra        = :ls_barra;

			If SQLCA.SQLCode = -1 Then
				ls_error = SQLCA.SQLErrText
				Rollback;
				Messagebox('Aviso',ls_error,Information!)
				Return 
			Else					
			
				If li_cnt > 0 Then
					messagebox('Aviso','El Código de Barra Ya Existe.', Information!)
					dw.setfocus()
					This.setitem(1,'prod_barra', '')
					Return 2
				End If				
				
			End If	
		
	case 'prod_producto_dos'	

		data = this.getitemstring(this.getrow(), 'prod_producto_dos')
		
		if this.getitemnumber(1,'copiar') = 1 then
			select count(*), max(prod_producto) into :li_existe, :ls_codigo from inmprodu where prod_g_financiero = :str.g_financiero and prod_empresa = :str.empresa and
																				 prod_producto_dos = :data ;
			if li_existe = 1 then
				this.retrieve(str.g_financiero, str.empresa, ls_codigo)
			end if
		else		
			  SELECT max(inmprodu.prod_producto) , count(*) 
				 INTO :ls_codigo  , :li_existe
				 FROM inmprodu  
				WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
						( inmprodu.prod_empresa = :str.empresa ) AND  
						( inmprodu.prod_producto_dos = :data )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Buscar codigo '+sqlca.sqlerrtext,1,1,'E')
					end if
					if li_existe > 0 then

						if this.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
							this.insertrow(1)
							this.setitem(1,'prod_g_financiero',str.g_financiero)
							this.setitem(1,'prod_empresa',str.empresa)
							this.setitem(1,'prod_producto_dos',data)
							this.setcolumn('prod_producto')
						else
							ls_foto = this.getitemstring(1,'prod_foto_dir')
							if ls_foto = '' or isnull(ls_foto) then
								this.setitem(1,'prod_foto_dir',is_foto+data+'.jpg')
							end if							
							ls_foto = this.getitemstring(1,'prod_foto_catalogo')
							if ls_foto = '' or isnull(ls_foto) then
								this.setitem(1,'prod_foto_catalogo',is_foto_catalogo+data+'.jpg')
							end if														
						end if
					end if
		end if
		dw_1.setitem(1,'ver_en_letras',ii_letra_por_default)
		ld_costo = this.getitemnumber(1,'prod_costo_fob')
		ls_costo = gf_clave_costos_sin_select(ld_costo, is_cadena_costo)
		this.setitem(1,'costo_fob',ls_costo)
		ld_costo = this.getitemnumber(1,'prod_costo_cif')
		ls_costo = gf_clave_costos_sin_select(ld_costo, is_cadena_costo)
		this.setitem(1,'costo_cif',ls_costo)
		ld_costo = this.getitemnumber(1,'prod_costo_promedio')
		ls_costo = gf_clave_costos_sin_select(ld_costo, is_cadena_costo)
		this.setitem(1,'costo_promedio',ls_costo)
		
		ls_filtro = This.GetItemString(row,"prod_division")
		if isnull(ls_filtro) then ls_filtro = ''
		idwc_grupo.SetFilter("agru_codigo_div = '" + ls_filtro + "'")	
		li_rtn = idwc_grupo.Filter()	

		li_encontro = dw_2.find('prod_producto = "'+ls_codigo+'"',1,dw_2.rowcount())
		if li_encontro > 0 then dw_2.scrolltorow(li_encontro)

		if dw_5.visible then
			li_ann1 = integer(em_ann1.text)
			li_ann2 = integer(em_ann2.text)
			ldt_desde = datetime( date('01/01/'+string(li_ann1)) ,time('00:00:00'))
			ldt_hasta = datetime( date('31/12/'+string(li_ann2)) ,time('23:59:59'))
			dw_5.retrieve(str.g_financiero, str.empresa, ls_codigo, ldt_desde, ldt_hasta)
		end if
		
	case  "prod_producto"

		data = this.getitemstring(this.getrow(), 'prod_producto')
		
		if this.getitemnumber(1,'copiar') = 1 then
			select count(*) into :li_existe from inmprodu where prod_g_financiero = :str.g_financiero and prod_empresa = :str.empresa and
																				 prod_producto = :data ;
			if li_existe = 1 then
				this.retrieve(str.g_financiero, str.empresa, data)
			end if
			
			ls_foto = this.getitemstring(1,'prod_foto_dir')
			if ls_foto = '' or isnull(ls_foto) then
				this.setitem(1,'prod_foto_dir',is_foto+data+'.jpg')				
			end if
			ls_foto = this.getitemstring(1,'prod_foto_catalogo')
			if ls_foto = '' or isnull(ls_foto) then
				this.setitem(1,'prod_foto_catalogo',is_foto_catalogo+data+'.jpg')		
			end if						
			
		else		
			if this.retrieve(str.g_financiero, str.empresa, data) = 0 then
				this.insertrow(1)
				this.setitem(1,'prod_g_financiero',str.g_financiero)
				this.setitem(1,'prod_empresa',str.empresa)
				this.setitem(1,'prod_producto',data)
				this.setcolumn('prod_producto')
				this.setitem(1,'prod_foto_dir',is_foto+data+'.jpg')
				this.setitem(1,'prod_foto_catalogo',is_foto_catalogo+data+'.jpg')					
			else			
				
				lb_entro = false
				ls_foto = this.getitemstring(1,'prod_foto_dir')
				if ls_foto = '' or isnull(ls_foto) then
					this.setitem(1,'prod_foto_dir',is_foto+data+'.jpg')
					lb_entro = true
				end if
				ls_foto = this.getitemstring(1,'prod_foto_catalogo')
				if ls_foto = '' or isnull(ls_foto) then
					this.setitem(1,'prod_foto_catalogo',is_foto_catalogo+data+'.jpg')
					lb_entro = true
				end if		
				if lb_entro then
					if this.update() = -1 then
						gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
					end if
				end if
			end if
			
		end if
		
		dw_1.setitem(1,'ver_en_letras',ii_letra_por_default)
		ld_costo = this.getitemnumber(1,'prod_costo_fob')
		ls_costo = gf_clave_costos_sin_select(ld_costo, is_cadena_costo)
		this.setitem(1,'costo_fob',ls_costo)
		ld_costo = this.getitemnumber(1,'prod_costo_cif')
		ls_costo = gf_clave_costos_sin_select(ld_costo, is_cadena_costo)
		this.setitem(1,'costo_cif',ls_costo)
		ld_costo = this.getitemnumber(1,'prod_costo_promedio')
		ls_costo = gf_clave_costos_sin_select(ld_costo, is_cadena_costo)
		this.setitem(1,'costo_promedio',ls_costo)
		
		
		ls_filtro = This.GetItemString(row,"prod_division")
		if isnull(ls_filtro) then ls_filtro = ''
		idwc_grupo.SetFilter("agru_codigo_div = '" + ls_filtro + "'")	
		li_rtn = idwc_grupo.Filter()	
		
		li_encontro = dw_2.find('prod_producto = "'+data+'"',1,dw_2.rowcount())
		if li_encontro > 0 then dw_2.scrolltorow(li_encontro)
		
		if dw_5.visible then
			li_ann1 = integer(em_ann1.text)
			li_ann2 = integer(em_ann2.text)
			ldt_desde = datetime( date('01/01/'+string(li_ann1)) ,time('00:00:00'))
			ldt_hasta = datetime( date('31/12/'+string(li_ann2)) ,time('23:59:59'))
			dw_5.retrieve(str.g_financiero, str.empresa, data, ldt_desde, ldt_hasta)
		end if		
					
		
	CASE "prod_grupo"	
		//Se setea el Arancel por Default del Grupo Seleccionado
		data = this.getitemstring(this.getrow(), 'prod_producto')
		IF Not (IsNull (data)) Then
			ll_fila = idwc_grupo.Find("#1 = '" + data + "'", 1, idwc_grupo.Rowcount())
			if ll_fila <> 0 then &
			ls_nulo = idwc_grupo.GetItemString(ll_fila, "agru_arancel_default")
			
			IF Not(IsNull(ls_nulo)) Then This.SetItem(row, "prod_arancel", ls_nulo)

		End If		

case "prod_ancho", "prod_alto", "prod_largo"
		ld_ancho = this.getitemnumber(this.getrow(),"prod_ancho")
		ld_alto  = this.getitemnumber(this.getrow(),"prod_alto")
		ld_largo = this.getitemnumber(this.getrow(),"prod_largo")		
		ld_temp = ld_ancho * ld_alto * ld_largo
		if pos(upper(str.empr_acceso_especial),'HPSA') > 0 then
			ld_total = ld_temp * 0.000035				//Si es PUNJABI utiliza .000035
		else
			ld_total = ld_temp * 0.000035315						//0.000035315 se utiliza en  http://www.metric-conversions.org/es/volumen/centimetros-cubicos-a-pies-cubicos.htm?val=10000
		end if
		ld_metros_cub = ld_temp / 1000000					//tenia .00003536
		this.setitem(this.getrow(),"prod_cubicaje",ld_total)
		this.setitem(this.getrow(),'cubicaje', ld_total * ll_empaque )
		this.setitem(this.getrow(),"prod_metros_cubicos",ld_metros_cub)		
	case "cubicaje"		
		ld_cubicaje = this.getitemnumber(this.getrow(),"cubicaje")
		ld_cubicaje = round(ld_cubicaje / ll_empaque,4)
		this.setitem(1,"prod_cubicaje",ld_cubicaje)
		ld_temp = ld_cubicaje / 35.315
		this.setitem(1,"prod_metros_cubicos",ld_temp)	  					
	case "prod_cubicaje"
		ld_cubicaje = this.getitemnumber(this.getrow(),"prod_cubicaje")		
		this.setitem(this.getrow(),"cubicaje",round(ld_cubicaje * ll_empaque,4))	  	
		ld_temp = ld_cubicaje / 35.315
		this.setitem(this.getrow(),"prod_metros_cubicos",ld_temp)	  			
	case "prod_peso"
		ld_peso = this.getitemnumber(1,"prod_peso")
		this.setitem(1,"peso",round(ld_peso * ll_empaque,4))	  	
	case "peso"		
		ld_peso = this.getitemnumber(1,"peso")
		this.setitem(1,"prod_peso",round(ld_peso / ll_empaque,4))	  		
	case 'prod_empaque'
		ld_cubicaje = this.getitemnumber(1,"cubicaje")
		ld_cubicaje = round(ld_cubicaje / ll_empaque,4)
		this.setitem(1,"prod_cubicaje",ld_cubicaje)	  
		ld_temp = ld_cubicaje / 35.315
		this.setitem(1,"prod_metros_cubicos",ld_temp)	  
		ld_peso = this.getitemnumber(1,"peso")
		this.setitem(1,"prod_peso",round(ld_peso / ll_empaque,4))
	Case 'inmprodu_prod_material'
		This.SetItem(row,'inmprodu_prod_mat_descripcion',data)
end choose

end event

event dw_1::ue_down;//override
CHOOSE CASE key
		
	CASE KeyF1! 
	
		This.Postevent("ue_helpcol")
	case KeyF3!
		if ii_letra_por_default = 1 then
			ii_letra_por_default = 0
		else
			ii_letra_por_default = 1
		end if
		dw_1.setitem(1,'ver_en_letras',ii_letra_por_default)
end choose
end event

event dw_1::ue_helpcol;//Busqueda del producto
//
String  ls_find,ls_codigo
integer li_c, li_b, li_especial
long    ll_lter, ll_encontro
string  ls_lter,ls_des

Datawindow        dww
str_dg_dynamic_find	lstr_df

  SELECT isnull(usuarios.usua_especial,0)  
    INTO :li_especial  
    FROM usuarios  
   WHERE usuarios.usua_id = :str.usuario   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al buscar autorizado '+sqlca.sqlerrtext,1,1,'E')
	end if

	lstr_df.texto_campo [1,1] = "inmprodu.prod_producto_dos"
	lstr_df.texto_campo [1,2] = "Modelo"
	lstr_df.texto_campo [1,3] = ""
	lstr_df.texto_campo [1,4] = 'V'
//	lstr_df.texto_campo [1,5] = '770'
	lstr_df.texto_campo [2,1] = "inmprodu.prod_producto"
	lstr_df.texto_campo [2,2] = "Referencia"
	lstr_df.texto_campo [2,3] = "prod_producto"
	lstr_df.texto_campo [2,4] = 'V'
//	lstr_df.texto_campo [2,5] = '280'	
	lstr_df.texto_campo [3,1] = "inmprodu.prod_descripcion"
	lstr_df.texto_campo [3,2] = "Descripcion"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [3,5] = '1070'
	
	lstr_df.texto_campo [4,1] = "datediff(month, prod_entrada_fecha, getdate()) mes"
	lstr_df.texto_campo [4,2] = "M"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '100'
	
	lstr_df.texto_campo [5,1] = "convert(numeric(12,2),inmprodu.prod_existencia_total / medi_cantidad) prod_existencia_total"
	lstr_df.texto_campo [5,2] = "Exist."
	lstr_df.texto_campo [5,3] = ""
	lstr_df.texto_campo [5,4] = 'V'
	lstr_df.texto_campo [5,5] = '270'

	lstr_df.texto_campo [6,1] = "convert(numeric(12,2),inmprodu.prod_reserva_total / medi_cantidad) prod_reserva_total"
	lstr_df.texto_campo [6,2] = "Reserva"
	lstr_df.texto_campo [6,3] = ""
	lstr_df.texto_campo [6,4] = 'V'
	lstr_df.texto_campo [6,5] = '270'

	lstr_df.texto_campo [7,1] = "convert(numeric(12,2),(inmprodu.prod_existencia_total  - inmprodu.prod_reserva_total) / medi_cantidad) disponible"
	lstr_df.texto_campo [7,2] = "Dispo."
	lstr_df.texto_campo [7,3] = ""
	lstr_df.texto_campo [7,4] = 'V'
	lstr_df.texto_campo [7,5] = '270'

	lstr_df.texto_campo [8,1] = "convert(numeric(10), inmprodu.prod_empaque) prod_empaque"
	lstr_df.texto_campo [8,2] = "Empaque"
	lstr_df.texto_campo [8,3] = ""
	lstr_df.texto_campo [8,4] = 'V'
	lstr_df.texto_campo [8,5] = '270'
	
	lstr_df.texto_campo [9,1] = "inmprodu.prod_medida"
	lstr_df.texto_campo [9,2] = "Uni."
	lstr_df.texto_campo [9,3] = ""
	lstr_df.texto_campo [9,4] = 'V'
	lstr_df.texto_campo [9,5] = '120'

	if li_especial = 1 then
		lstr_df.texto_campo [10,1] = "inmprodu.prod_costo_fob"
		lstr_df.texto_campo [10,2] = "Info"
		lstr_df.texto_campo [10,3] = ""
		lstr_df.texto_campo [10,4] = 'V'
		lstr_df.texto_campo [10,5] = '230'
	
		lstr_df.texto_campo [11,1] = "cradivis.adiv_nombre_div"
		lstr_df.texto_campo [11,2] = "Division"
		lstr_df.texto_campo [11,3] = ""
		lstr_df.texto_campo [11,4] = 'V'
		lstr_df.texto_campo [11,5] = '870'
		
//		lstr_df.texto_campo [12,1] = "cragrupo.agru_descripcion_grupo"
//		lstr_df.texto_campo [12,2] = "Grupo"
//		lstr_df.texto_campo [12,3] = ""
//		lstr_df.texto_campo [12,4] = 'V'
//		lstr_df.texto_campo [12,5] = '870'
		
		lstr_df.texto_campo [12,1] = "inmprodu.prod_barra"
		lstr_df.texto_campo [12,2] = "Codigo Barra"
		lstr_df.texto_campo [12,3] = ""
		lstr_df.texto_campo [12,4] = 'V'
		lstr_df.texto_campo [12,5] = '400'
	else
		lstr_df.texto_campo [10,1] = "cradivis.adiv_nombre_div"
		lstr_df.texto_campo [10,2] = "Division"
		lstr_df.texto_campo [10,3] = ""
		lstr_df.texto_campo [10,4] = 'V'
		lstr_df.texto_campo [10,5] = '870'
		
		lstr_df.texto_campo [11,1] = "cragrupo.agru_descripcion_grupo"
		lstr_df.texto_campo [11,2] = "Grupo"
		lstr_df.texto_campo [11,3] = ""
		lstr_df.texto_campo [11,4] = 'V'
		lstr_df.texto_campo [11,5] = '870'		
		
		lstr_df.texto_campo [12,1] = "inmprodu.prod_barra"
		lstr_df.texto_campo [12,2] = "Codigo Barra"
		lstr_df.texto_campo [12,3] = ""
		lstr_df.texto_campo [12,4] = 'V'
		lstr_df.texto_campo [12,5] = '400'
		
	end if

	lstr_df.tabla = " inmprodu, cradivis, cragrupo, inamedid "
		
	lstr_df.tabla_where = &
		"WHERE ( inmprodu.prod_g_financiero = cragrupo.agru_g_financiero ) and  " +&
         "( inmprodu.prod_empresa = cragrupo.agru_empresa  ) and  " +&
         "( inmprodu.prod_division = cragrupo.agru_codigo_div ) and " +&  
         "( inmprodu.prod_grupo = cragrupo.agru_codigo_grupo  ) and " +&  			
         "( inmprodu.prod_g_financiero = cradivis.adiv_g_financiero ) and " +& 
         "( inmprodu.prod_empresa = cradivis.adiv_empresa ) and  " +&
         "( inmprodu.prod_division = cradivis.adiv_codigo_div ) and " +&  
         "( inmprodu.prod_medida = inamedid.medi_medida ) and " +&  			
		"(inmprodu.prod_g_financiero = " + string(str.g_financiero) + ") and " +&
		"(inmprodu.prod_empresa = " + string(str.empresa) + ") "	 
						 
//	OpenSheetWithParm(w_buscar_producto_mantener_abierta, lstr_df, parent, 2, Original!)
 
OpenWithParm(w_buscar_producto_mantener_abierta, lstr_df)
//	OpenSheet(w_productos_sin_movimiento, aw_parent,2, Layered!) 
	ls_find = Message.StringParm


If len (ls_find) = 0 Then Return
	
//ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
//gf_replace_cadena(ls_codigo,"'"," ")
//ls_codigo = Trim(ls_codigo)
//this.setitem(this.getrow(),'prod_producto',ls_codigo)
//this.setcolumn('prod_producto')

//ll_encontro = dw_2.find("prod_producto = '"+ls_codigo+"'", 1, dw_2.rowcount())
//if ll_encontro > 0 then
//	dw_2.scrolltorow(ll_encontro)
//end if
//this.accepttext()
//this.trigger event itemchanged(this.getrow(), object, ls_codigo)
wf_setear_producto(ls_find)

end event

event dw_1::ue_microayuda;//override
end event

event dw_1::itemfocuschanged;//override
string ls_filtro
integer li_rtn

accepttext()

CHOOSE CASE dwo.name
	CASE "prod_grupo"
	//Se filtran los grupo por la división seleccionada
	ls_filtro = This.GetItemString(row,"prod_division")
	idwc_grupo.SetFilter("agru_codigo_div = '" + ls_filtro + "'")	
	li_rtn = idwc_grupo.Filter()
end choose
end event

event dw_1::ue_tabfinal;//override

end event

type st_ayuda from w_fa_padre`st_ayuda within w_productos
end type

type dw_2 from datawindow within w_productos
boolean visible = false
integer x = 73
integer y = 372
integer width = 434
integer height = 768
integer taborder = 11
boolean bringtotop = true
string title = "none"
string dataobject = "dw_find_productos"
boolean border = false
boolean livescroll = true
end type

type dw_3 from datawindow within w_productos
boolean visible = false
integer x = 14
integer y = 712
integer width = 265
integer height = 328
integer taborder = 21
boolean bringtotop = true
string title = "none"
string dataobject = "dw_producto"
boolean border = false
boolean livescroll = true
end type

type pb_1 from picturebutton within w_productos
boolean visible = false
integer x = 1390
integer y = 1876
integer width = 110
integer height = 96
integer taborder = 31
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "Print!"
alignment htextalign = left!
end type

event clicked;string ls_descripcion, ls_item, ls_barra
Decimal ld_precio
integer li_cantidad, i
long ll_archivo
if gf_mensaje("","Se procedera a imprimir la etiqueta del producto, esta seguro ?",2,1,"E") = 1 then

	filedelete("C:\Sistemas\codigo_barra.txt")
	dw_2.accepttext()
	SetPointer(HourGlass!)

		ls_item = dw_1.getitemstring(1,'prod_producto')
		if isnull(ls_item) or ls_item = '' then return
		li_cantidad = 1
		
		  SELECT inmprodu.prod_descripcion,   
					inmprodu.prod_precio1,
					inmprodu.prod_cod_alternativo
			 INTO :ls_descripcion,   
					:ld_precio,
					:ls_barra
			 FROM inmprodu  
			WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
					( inmprodu.prod_empresa = :str.empresa ) AND  
					( inmprodu.prod_producto = :ls_item )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al buscar producto '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
		
		gf_imprime_barras_union(ls_item, ls_descripcion, li_cantidad, ld_precio, ls_barra, 0)
		
		ll_archivo = FileOpen ("c:\Sistemas\codigo_barra.txt" , LineMode!  , Write!  , LockWrite!  , Append!  )
		filewrite(ll_archivo,'^XZ')						
		fileclose(ll_archivo)			
		
Integer        li_return_code
 string     ls_null
 long       ll_null

SetNull(ls_null)
SetNull(ll_null)

li_return_code = ShellExecute(ll_null, "print", "C:\Sistemas\codigo_barra.txt", ls_null, ls_null, 0)

SetPointer(Arrow!)

PrintSetPrinter (str.printer1)

end if


end event

type st_1 from statictext within w_productos
boolean visible = false
integer x = 1193
integer y = 1988
integer width = 498
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
string text = "Imprimir Etiqueta"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_4 from datawindow within w_productos
boolean visible = false
integer x = 165
integer y = 164
integer width = 2848
integer height = 868
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Etiqueta del Producto"
string dataobject = "dw_impresion_etiquetas_producto"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "AppIcon!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;integer i, li_total
decimal{2} ld_costo
string ls_costo

li_total = rowcount
for i = 1 to li_total
	ld_costo = this.getitemnumber(i,'inmprodu_prod_costo_cif')
	ls_costo = gf_clave_costos(ld_costo)		
	this.setitem(i,'costo',ls_costo)
next
end event

type dw_5 from datawindow within w_productos
boolean visible = false
integer x = 302
integer y = 332
integer width = 2898
integer height = 1236
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "Promedio de Ventas"
string dataobject = "dw_composite_ventas_producto"
boolean controlmenu = true
boolean maxbox = true
boolean resizable = true
string icon = "AppIcon!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_2 from picturebutton within w_productos
integer x = 1102
integer y = 1768
integer width = 169
integer height = 144
integer taborder = 31
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string picturename = "\Sistemas\Hymsoft\Art\graph.png"
alignment htextalign = left!
string powertiptext = "Ver Ventas Anuales ..."
end type

event clicked;integer li_ann1, li_ann2
datetime ldt_desde, ldt_hasta
string ls_producto

ls_producto = dw_1.getitemstring(1,'prod_producto')
li_ann1 = integer(em_ann1.text)
li_ann2 = integer(em_ann2.text)

ldt_desde = datetime( date('01/01/'+string(li_ann1)) ,time('00:00:00'))
ldt_hasta = datetime( date('31/12/'+string(li_ann2)) ,time('23:59:59'))

if dw_5.retrieve(str.g_financiero, str.empresa, ls_producto, ldt_desde, ldt_hasta) > 0 then
	dw_5.visible = true
end if

end event

type em_ann1 from editmask within w_productos
integer x = 869
integer y = 1772
integer width = 224
integer height = 64
integer taborder = 41
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean border = false
alignment alignment = center!
string mask = "###0"
boolean spin = true
double increment = 1
string minmax = "2000~~4000"
end type

type em_ann2 from editmask within w_productos
integer x = 869
integer y = 1844
integer width = 224
integer height = 64
integer taborder = 51
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean border = false
alignment alignment = center!
string mask = "###0"
boolean spin = true
double increment = 1
string minmax = "2000~~4000"
end type

type st_2 from statictext within w_productos
integer x = 718
integer y = 1780
integer width = 151
integer height = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Desde:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_productos
integer x = 722
integer y = 1844
integer width = 151
integer height = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Hasta:"
boolean focusrectangle = false
end type

type cb_pasar from commandbutton within w_productos
boolean visible = false
integer x = 197
integer y = 1864
integer width = 494
integer height = 84
integer taborder = 61
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "PASAR PRODUCTOS"
end type

event clicked;integer li_empresa, li_cant_prod
if idwc_empresas.rowcount() > 1 then
	dw_6.visible = true
	dw_6.setfocus()	
else
	li_empresa = dw_6.getitemnumber(1,'empresa')
//	li_cant_prod=gf_pasar_otra_empresa(str.g_financiero,li_empresa,str.g_financiero,str.empresa)
	messagebox('Pase Exitoso de Productos !!!','Se Actualizaron: '+string(li_cant_prod))
end if


end event

type dw_6 from datawindow within w_productos
boolean visible = false
integer x = 1106
integer y = 428
integer width = 846
integer height = 480
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "Pasar Productos..."
string dataobject = "dw_external_empresa_origen"
boolean controlmenu = true
boolean border = false
string icon = "DataPipeline!"
boolean livescroll = true
end type

event buttonclicked;integer li_empresa, li_cant_prod
	li_empresa = dw_6.getitemnumber(1,'empresa')
	li_cant_prod=gf_pasar_otra_empresa(str.g_financiero,li_empresa,str.g_financiero,str.empresa)
	messagebox('Pase Exitoso de Productos !!!','Se Actualizaron: '+string(li_cant_prod))
	this.visible = false

end event

type cb_ubicaciones from commandbutton within w_productos
integer x = 2647
integer y = 604
integer width = 343
integer height = 84
integer taborder = 31
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "UBICACIONES"
boolean flatstyle = true
end type

event clicked;//Abrir la ventana de ubicaciones
opensheet(w_ubicaciones, str.frame, 2, Original!)
end event

type pb_3 from picturebutton within w_productos
integer x = 59
integer y = 1856
integer width = 110
integer height = 96
integer taborder = 41
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean flatstyle = true
boolean originalsize = true
string picturename = "Import5!"
alignment htextalign = left!
string powertiptext = "Importar Productos ...."
end type

event clicked;opensheet(w_importar_datos_usuarios, str.frame, 2, Layered!)
end event

type dw_7 from datawindow within w_productos
boolean visible = false
integer x = 512
integer y = 84
integer width = 690
integer height = 388
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Cambiar Codigo"
string dataobject = "dw_cambio_de_codigo_producto"
boolean controlmenu = true
boolean border = false
string icon = "DataPipeline!"
boolean livescroll = true
end type

event buttonclicked;//Reemplaza Codigo
string ls_producto, ls_producto_new, ls_foto, ls_foto_catalogo, ls_foto_editada
integer li_existe
dw_7.accepttext()
ls_producto = dw_1.getitemstring(1,'prod_producto')
ls_producto_new = this.getitemstring(1,'producto')
if len(ls_producto_new) = 0 then return

  SELECT count(*)  
    INTO :li_existe  
    FROM inmprodu  
   WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
         ( inmprodu.prod_empresa = :str.empresa ) AND  
         ( inmprodu.prod_producto = :ls_producto_new )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al Contar '+sqlca.sqlerrtext,1,1,'E')
		return
	end if

if li_existe >= 1 then
	gf_mensaje('','Código ya Existe, Verifique !!!',1,1,'E')
	return
end if

if gf_mensaje('','Esta Seguro de Cambiar el Codigo ?',2,1,'Q') = 2 then return

sqlca.autocommit=false

string	ls_errtext, ls_dbcode
integer	li_tiene_fa, li_tiene_pv

ls_foto = is_foto+ls_producto_new+'.jpg'
ls_foto_catalogo = is_foto_catalogo+ls_producto_new+'.jpg'
ls_foto_editada = 'Z:\Editadas\'+ls_producto_new+'.jpg'

  INSERT INTO inmprodu  
         ( prod_g_financiero,   
           prod_empresa,   
           prod_producto,   
           prod_owner,   
           prod_producto_dos,   
           prod_cod_alternativo,   
           prod_barra,   
           prod_descripcion,   
           prod_descripcion_dos,   
           prod_division,   
           prod_grupo,   
           prod_sub_grupo,   
           prod_clase,   
           prod_num_producto,   
           prod_num_tipo,   
           prod_compuesto,   
           prod_marca,   
           prod_codigo_modelo,   
           prod_medida,   
           prod_color,   
           prod_cod_clase_tam,   
           prod_fecha_creacion,   
           prod_ultima_actualizacion,   
           prod_costo_fob,   
           prod_flete,   
           prod_seguros,   
           prod_otros_gastos,   
           prod_costo_cif,   
           prod_precio_venta_unidad,   
           prod_impuesto,   
           prod_arancel,   
           prod_status,   
           prod_estatus_ref,   
           prod_foto_dir,   
           prod_desc_local,   
           prod_desc_exterior,   
           prod_costou_local,   
           prod_itbm_local,   
           prod_definicion,   
           prod_peso,   
           prod_peso_descripcion,   
           prod_empaque,   
           prod_empaque_descripcion,   
           prod_cubicaje,   
           prod_unidad_cub,   
           prod_id_usuario,   
           prod_pais,   
           prod_base1,   
           prod_base2,   
           prod_tipo_base,   
           prod_porc_apli,   
           prod_costo_unitario,   
           prod_ultima_entrada_doc,   
           prod_ultima_entrada_can,   
           prod_precio1,   
           prod_precio2,   
           prod_precio3,   
           prod_precio4,   
           prod_precio5,   
           prod_punto_maximo,   
           prod_punto_minimo,   
           prod_cant_a_pedir,   
           prod_comision,   
           prod_descuento_maximo,   
           prod_descuento_siono,   
           prod_existencia_total,   
           prod_reserva_total,   
           prod_entrada_fecha,   
           prod_salida_fecha,   
           prod_ultima_salida_doc,   
           prod_observacion,   
           prod_cant_transito,   
           prod_reserva_trans,   
           prod_empaque_um,   
           prod_peso_unidad_medida,   
           prod_fecha_agotado,   
           prod_board,   
           prod_precio_venta_minimo,   
           prod_porcentaje_regalias,   
           prod_contrato_regalias,   
           prod_unidad_venta,   
           prod_clave_costo,   
           prod_por_precio1,   
           prod_por_precio2,   
           prod_por_precio3,   
           prod_por_precio4,   
           prod_por_precio5,   
           prod_costo_ult_entrada,   
           prod_costo_por,   
           prod_mg_cuenta,   
           prod_concepto,   
           prod_temporada,   
           prod_empaque_caja,   
           prod_reserva_conf,   
           prod_cant_confirma,   
           prod_gramaje,   
           prod_yarda_bulto,   
           prod_tercero,   
           prod_emp_um_prov,   
           prod_empaque_prov,   
           prod_empaque_desc_prov,   
           prod_ultima_entrada_sec,   
           prod_primera_entrada,   
           prod_clasificacion,   
           prod_codigo_laboratorio,   
           prod_codigo_presentacion,   
           prod_precio_minimo,   
           prod_id_modi_minimo,   
           prod_orden_compra,   
           prod_licencia,   
           prod_descontinuado,   
           prod_color_spaniol,   
           prod_ubicacion_bodega_le,   
           prod_incluir_en_analisis,   
           prod_valor_minimo_sin_recargo,   
           prod_descuento,   
           prod_kilates,   
           prod_producto_referencia,   
           prod_costo_promedio,   
           prod_cod_brillante1,   
           prod_cod_brillante2,   
           prod_cod_brillante3,   
           prod_cod_brillante4,   
           prod_peso_brillante1,   
           prod_peso_brillante2,   
           prod_peso_brillante3,   
           prod_peso_brillante4,   
           prod_peso_neto,   
           prod_alto,   
           prod_ancho,   
           prod_largo,   
           prod_cantidad_limite,   
           prod_existencia1,   
           prod_existencia2,   
           prod_existencia3,   
           prod_existencia4,   
           prod_existencia5,   
           prod_existencia6,   
           prod_existencia7,   
           prod_reserva1,   
           prod_reserva2,   
           prod_reserva3,   
           prod_reserva4,   
           prod_reserva5,   
           prod_reserva6,   
           prod_reserva7,   
           prod_metros_cubicos,   
           prod_excluir_de_sugerido,   
           prod_cantidad_oc,   
           prod_costo_oc,
			  prod_arancel_anterior,   
           prod_sku,   
           prod_nivel1,   
           prod_nivel2,   
           prod_nivel3,   
           prod_nivel4,   
           prod_nivel5,   
           prod_foto_catalogo,   
           prod_tamano,   
           prod_lote,   
           prod_fecha_produccion,   
           prod_foto_editada,   
           prod_fecha_subida,   
           prod_documento_entrada,   
           prod_contrato)  
     SELECT inmprodu.prod_g_financiero,   
            inmprodu.prod_empresa,   
            :ls_producto_new,   
            inmprodu.prod_owner,   
            inmprodu.prod_producto_dos,   
            inmprodu.prod_cod_alternativo,   
            inmprodu.prod_barra,   
            inmprodu.prod_descripcion,   
            inmprodu.prod_descripcion_dos,   
            inmprodu.prod_division,   
            inmprodu.prod_grupo,   
            inmprodu.prod_sub_grupo,   
            inmprodu.prod_clase,   
            inmprodu.prod_num_producto,   
            inmprodu.prod_num_tipo,   
            inmprodu.prod_compuesto,   
            inmprodu.prod_marca,   
            inmprodu.prod_codigo_modelo,   
            inmprodu.prod_medida,   
            inmprodu.prod_color,   
            inmprodu.prod_cod_clase_tam,   
            inmprodu.prod_fecha_creacion,   
            inmprodu.prod_ultima_actualizacion,   
            inmprodu.prod_costo_fob,   
            inmprodu.prod_flete,   
            inmprodu.prod_seguros,   
            inmprodu.prod_otros_gastos,   
            inmprodu.prod_costo_cif,   
            inmprodu.prod_precio_venta_unidad,   
            inmprodu.prod_impuesto,   
            inmprodu.prod_arancel,   
            inmprodu.prod_status,   
            inmprodu.prod_estatus_ref,   
            :ls_foto,   
            inmprodu.prod_desc_local,   
            inmprodu.prod_desc_exterior,   
            inmprodu.prod_costou_local,   
            inmprodu.prod_itbm_local,   
            inmprodu.prod_definicion,   
            inmprodu.prod_peso,   
            inmprodu.prod_peso_descripcion,   
            inmprodu.prod_empaque,   
            inmprodu.prod_empaque_descripcion,   
            inmprodu.prod_cubicaje,   
            inmprodu.prod_unidad_cub,   
            inmprodu.prod_id_usuario,   
            inmprodu.prod_pais,   
            inmprodu.prod_base1,   
            inmprodu.prod_base2,   
            inmprodu.prod_tipo_base,   
            inmprodu.prod_porc_apli,   
            inmprodu.prod_costo_unitario,   
            inmprodu.prod_ultima_entrada_doc,   
            inmprodu.prod_ultima_entrada_can,   
            inmprodu.prod_precio1,   
            inmprodu.prod_precio2,   
            inmprodu.prod_precio3,   
            inmprodu.prod_precio4,   
            inmprodu.prod_precio5,   
            inmprodu.prod_punto_maximo,   
            inmprodu.prod_punto_minimo,   
            inmprodu.prod_cant_a_pedir,   
            inmprodu.prod_comision,   
            inmprodu.prod_descuento_maximo,   
            inmprodu.prod_descuento_siono,   
            inmprodu.prod_existencia_total,   
            inmprodu.prod_reserva_total,   
            inmprodu.prod_entrada_fecha,   
            inmprodu.prod_salida_fecha,   
            inmprodu.prod_ultima_salida_doc,   
            inmprodu.prod_observacion,   
            inmprodu.prod_cant_transito,   
            inmprodu.prod_reserva_trans,   
            inmprodu.prod_empaque_um,   
            inmprodu.prod_peso_unidad_medida,   
            inmprodu.prod_fecha_agotado,   
            inmprodu.prod_board,   
            inmprodu.prod_precio_venta_minimo,   
            inmprodu.prod_porcentaje_regalias,   
            inmprodu.prod_contrato_regalias,   
            inmprodu.prod_unidad_venta,   
            inmprodu.prod_clave_costo,   
            inmprodu.prod_por_precio1,   
            inmprodu.prod_por_precio2,   
            inmprodu.prod_por_precio3,   
            inmprodu.prod_por_precio4,   
            inmprodu.prod_por_precio5,   
            inmprodu.prod_costo_ult_entrada,   
            inmprodu.prod_costo_por,   
            inmprodu.prod_mg_cuenta,   
            inmprodu.prod_concepto,   
            inmprodu.prod_temporada,   
            inmprodu.prod_empaque_caja,   
            inmprodu.prod_reserva_conf,   
            inmprodu.prod_cant_confirma,   
            inmprodu.prod_gramaje,   
            inmprodu.prod_yarda_bulto,   
            inmprodu.prod_tercero,   
            inmprodu.prod_emp_um_prov,   
            inmprodu.prod_empaque_prov,   
            inmprodu.prod_empaque_desc_prov,   
            inmprodu.prod_ultima_entrada_sec,   
            inmprodu.prod_primera_entrada,   
            inmprodu.prod_clasificacion,   
            inmprodu.prod_codigo_laboratorio,   
            inmprodu.prod_codigo_presentacion,   
            inmprodu.prod_precio_minimo,   
            inmprodu.prod_id_modi_minimo,   
            inmprodu.prod_orden_compra,   
            inmprodu.prod_licencia,   
            inmprodu.prod_descontinuado,   
            inmprodu.prod_color_spaniol,   
            inmprodu.prod_ubicacion_bodega_le,   
            inmprodu.prod_incluir_en_analisis,   
            inmprodu.prod_valor_minimo_sin_recargo,   
            inmprodu.prod_descuento,   
            inmprodu.prod_kilates,   
            inmprodu.prod_producto_referencia,   
            inmprodu.prod_costo_promedio,   
            inmprodu.prod_cod_brillante1,   
            inmprodu.prod_cod_brillante2,   
            inmprodu.prod_cod_brillante3,   
            inmprodu.prod_cod_brillante4,   
            inmprodu.prod_peso_brillante1,   
            inmprodu.prod_peso_brillante2,   
            inmprodu.prod_peso_brillante3,   
            inmprodu.prod_peso_brillante4,   
            inmprodu.prod_peso_neto,   
            inmprodu.prod_alto,   
            inmprodu.prod_ancho,   
            inmprodu.prod_largo,   
            inmprodu.prod_cantidad_limite,   
            inmprodu.prod_existencia1,   
            inmprodu.prod_existencia2,   
            inmprodu.prod_existencia3,   
            inmprodu.prod_existencia4,   
            inmprodu.prod_existencia5,   
            inmprodu.prod_existencia6,   
            inmprodu.prod_existencia7,   
            inmprodu.prod_reserva1,   
            inmprodu.prod_reserva2,   
            inmprodu.prod_reserva3,   
            inmprodu.prod_reserva4,   
            inmprodu.prod_reserva5,   
            inmprodu.prod_reserva6,   
            inmprodu.prod_reserva7,   
            inmprodu.prod_metros_cubicos,   
            inmprodu.prod_excluir_de_sugerido,   
            inmprodu.prod_cantidad_oc,   
            inmprodu.prod_costo_oc,
				inmprodu.prod_arancel_anterior,   
            inmprodu.prod_sku,   
            inmprodu.prod_nivel1,   
            inmprodu.prod_nivel2,   
            inmprodu.prod_nivel3,   
            inmprodu.prod_nivel4,   
            inmprodu.prod_nivel5,   
            :ls_foto_catalogo,   
            inmprodu.prod_tamano,   
            inmprodu.prod_lote,   
            inmprodu.prod_fecha_produccion,   
            :ls_foto_editada,   
            inmprodu.prod_fecha_subida,   
            inmprodu.prod_documento_entrada,   
            inmprodu.prod_contrato  
       FROM inmprodu  
      WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
            ( inmprodu.prod_empresa = :str.empresa ) AND  
            ( inmprodu.prod_producto = :ls_producto )   ;				
if sqlca.sqlcode <> 0 then
	ls_errtext = sqlca.sqlerrtext
	ls_dbcode = string(sqlca.sqlcode)
	rollback;
	messagebox('Error # 1 '+ls_dbcode,'No se actualizó la información del producto. '+ls_errtext+'.',Exclamation!)
	return
end if
	
/*UPDATE DE FADDIARI Y FADPEDID*/

	UPDATE faddiari
	SET facd_codigo_item = :ls_producto_new 
	WHERE (facd_g_financiero = :str.g_financiero ) AND
			(facd_empresa = :str.empresa ) AND
			(facd_codigo_item = :ls_producto );
	
	if sqlca.sqlcode <> 0 then
		ls_errtext = sqlca.sqlerrtext
		ls_dbcode = string(sqlca.sqlcode)
		rollback;
		messagebox('Error # 2'+ls_dbcode,'No se actualizó la información detallada del producto. '+ls_errtext+'.',Exclamation!)
		return
	end if
	
	UPDATE fadpedid
	SET dped_codigo_item = :ls_producto_new 
	WHERE (dped_g_financiero = :str.g_financiero ) AND
			(dped_empresa = :str.empresa ) AND
			(dped_codigo_item = :ls_producto );
	
	if sqlca.sqlcode <> 0 then
		ls_errtext = sqlca.sqlerrtext
		ls_dbcode = string(sqlca.sqlcode)
		rollback;
		messagebox('Error # 3'+ls_dbcode,'No se actualizó la información detallada del producto. '+ls_errtext+'.',Exclamation!)
		return
	end if
	
	
	UPDATE fadempaq
	SET empa_codigo_producto = :ls_producto_new 
	WHERE (empa_g_financiero = :str.g_financiero ) AND
			(empa_empresa = :str.empresa ) AND
			(empa_codigo_producto = :ls_producto );
	
	if sqlca.sqlcode <> 0 then
		ls_errtext = sqlca.sqlerrtext
		ls_dbcode = string(sqlca.sqlcode)
		rollback;
		messagebox('Error # 4'+ls_dbcode,'No se actualizó la información detallada del producto. '+ls_errtext+'.',Exclamation!)
		return
	end if
	
	

UPDATE orden_detalle
SET deta_referencia = :ls_producto_new 
WHERE (deta_g_financiero = :str.g_financiero ) AND
		(deta_empresa = :str.empresa ) AND
		(deta_referencia = :ls_producto );

if sqlca.sqlcode <> 0 then
	ls_errtext = sqlca.sqlerrtext
	ls_dbcode = string(sqlca.sqlcode)
	rollback;
	messagebox('Error # 5'+ls_dbcode,'No se actualizó la información detallada del producto. '+ls_errtext+'.',Exclamation!)
	return
end if

UPDATE crdconfi
SET dcof_producto= :ls_producto_new 
WHERE (dcof_g_financiero = :str.g_financiero ) AND
		(dcof_empresa = :str.empresa ) AND
		(dcof_producto = :ls_producto );

if sqlca.sqlcode <> 0 then
	ls_errtext = sqlca.sqlerrtext
	ls_dbcode = string(sqlca.sqlcode)
	rollback;
	messagebox('Error # 6'+ls_dbcode,'No se actualizó la información detallada del producto. '+ls_errtext+'.',Exclamation!)
	return
End If
UPDATE crdordco
SET doco_id_referencia= :ls_producto_new 
WHERE (doco_g_financiero = :str.g_financiero ) AND
		(doco_empresa = :str.empresa ) AND
		(doco_id_referencia = :ls_producto );

if sqlca.sqlcode <> 0 then
	ls_errtext = sqlca.sqlerrtext
	ls_dbcode = string(sqlca.sqlcode)
	rollback;
	messagebox('Error # 7'+ls_dbcode,'No se actualizó la información detallada del producto. '+ls_errtext+'.',Exclamation!)
	return
end if
UPDATE indguia
SET dguia_producto= :ls_producto_new 
WHERE (dguia_g_financiero = :str.g_financiero ) AND
		(dguia_empresa = :str.empresa ) AND
		(dguia_producto = :ls_producto );

if sqlca.sqlcode <> 0 then
	ls_errtext = sqlca.sqlerrtext
	ls_dbcode = string(sqlca.sqlcode)
	rollback;
	messagebox('Error # 8'+ls_dbcode,'No se actualizó la información detallada del producto. '+ls_errtext+'.',Exclamation!)
	return
end if

delete FROM inmprodu
WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND
		( inmprodu.prod_empresa = :str.empresa ) AND
		( inmprodu.prod_producto = :ls_producto );

if sqlca.sqlcode <> 0 then
	ls_errtext = sqlca.sqlerrtext
	ls_dbcode = string(sqlca.sqlcode)
	rollback;
	messagebox('Error # 9'+ls_dbcode,'No se actualizó la información modificada de los productos. '+ls_errtext+'.',Exclamation!)
	return
end if

commit;
sqlca.autocommit=true
dw_7.visible = false
dw_7.setitem(1,'producto','')
dw_1.setitem(1,'prod_producto',ls_producto_new)
dw_1.setfocus()
dw_1.setcolumn('prod_producto')
dw_1.triggerevent('itemchanged')
messagebox('Proceso Terminado','Cambio de Codigo Exitoso')




end event

type lb_1 from listbox within w_productos
boolean visible = false
integer x = 3241
integer y = 988
integer width = 480
integer height = 376
integer taborder = 31
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type lb_2 from listbox within w_productos
boolean visible = false
integer x = 3744
integer y = 992
integer width = 480
integer height = 376
integer taborder = 41
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type dw_9 from datawindow within w_productos
boolean visible = false
integer x = 4375
integer y = 988
integer width = 133
integer height = 92
integer taborder = 31
boolean bringtotop = true
string title = "none"
string dataobject = "dw_estructura_producto"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

