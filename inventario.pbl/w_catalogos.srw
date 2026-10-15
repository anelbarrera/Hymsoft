forward
global type w_catalogos from w_fa_padre_reportes
end type
type em_desde from editmask within w_catalogos
end type
type em_hasta from editmask within w_catalogos
end type
type st_1 from statictext within w_catalogos
end type
type st_2 from statictext within w_catalogos
end type
type cb_1 from commandbutton within w_catalogos
end type
type cb_salir from commandbutton within w_catalogos
end type
type calendario from picture within w_catalogos
end type
type calendario2 from picture within w_catalogos
end type
type uo_1 from u_ddcalen within w_catalogos
end type
type uo_2 from u_ddcalen within w_catalogos
end type
type phl_foto from picturehyperlink within w_catalogos
end type
type shl_1 from statichyperlink within w_catalogos
end type
type dw_3 from datawindow within w_catalogos
end type
type dw_5 from datawindow within w_catalogos
end type
type rb_1 from radiobutton within w_catalogos
end type
type rb_2 from radiobutton within w_catalogos
end type
type cbx_1 from checkbox within w_catalogos
end type
type pb_1 from picturebutton within w_catalogos
end type
type st_3 from statictext within w_catalogos
end type
type cbx_back from checkbox within w_catalogos
end type
type hpb_barra from hprogressbar within w_catalogos
end type
type cbx_cubrio_costo from checkbox within w_catalogos
end type
type cb_2 from commandbutton within w_catalogos
end type
type dw_7 from datawindow within w_catalogos
end type
type dw_9 from datawindow within w_catalogos
end type
type dw_10 from datawindow within w_catalogos
end type
type dw_11 from datawindow within w_catalogos
end type
type dw_12 from datawindow within w_catalogos
end type
type dw_13 from datawindow within w_catalogos
end type
type cb_3 from commandbutton within w_catalogos
end type
type dw_14 from datawindow within w_catalogos
end type
type dw_15 from datawindow within w_catalogos
end type
type cbx_ambas from checkbox within w_catalogos
end type
type dw_16 from datawindow within w_catalogos
end type
type cb_4 from commandbutton within w_catalogos
end type
type cb_back from commandbutton within w_catalogos
end type
type cbx_recalcula_cantidad from checkbox within w_catalogos
end type
type cbx_ocultar_costo from checkbox within w_catalogos
end type
type cbx_imprimir_b from checkbox within w_catalogos
end type
type cbx_ver_proveedor from checkbox within w_catalogos
end type
type cb_5 from commandbutton within w_catalogos
end type
type dw_19 from datawindow within w_catalogos
end type
type dw_20 from datawindow within w_catalogos
end type
type dw_21 from datawindow within w_catalogos
end type
type dw_22 from datawindow within w_catalogos
end type
type cb_6 from commandbutton within w_catalogos
end type
type cbx_ver_costo_leo from checkbox within w_catalogos
end type
type dw_8 from datawindow within w_catalogos
end type
type cbx_2 from checkbox within w_catalogos
end type
type p_1 from picture within w_catalogos
end type
type cb_7 from commandbutton within w_catalogos
end type
type p_2 from picture within w_catalogos
end type
type cb_8 from commandbutton within w_catalogos
end type
type sle_1 from singlelineedit within w_catalogos
end type
type cbx_3 from checkbox within w_catalogos
end type
type sle_nombre from singlelineedit within w_catalogos
end type
end forward

global type w_catalogos from w_fa_padre_reportes
integer width = 6679
integer height = 2872
string title = "Generacion de Catalogos"
windowanimationstyle openanimation = noanimation!
windowanimationstyle closeanimation = noanimation!
event ue_saveas ( )
em_desde em_desde
em_hasta em_hasta
st_1 st_1
st_2 st_2
cb_1 cb_1
cb_salir cb_salir
calendario calendario
calendario2 calendario2
uo_1 uo_1
uo_2 uo_2
phl_foto phl_foto
shl_1 shl_1
dw_3 dw_3
dw_5 dw_5
rb_1 rb_1
rb_2 rb_2
cbx_1 cbx_1
pb_1 pb_1
st_3 st_3
cbx_back cbx_back
hpb_barra hpb_barra
cbx_cubrio_costo cbx_cubrio_costo
cb_2 cb_2
dw_7 dw_7
dw_9 dw_9
dw_10 dw_10
dw_11 dw_11
dw_12 dw_12
dw_13 dw_13
cb_3 cb_3
dw_14 dw_14
dw_15 dw_15
cbx_ambas cbx_ambas
dw_16 dw_16
cb_4 cb_4
cb_back cb_back
cbx_recalcula_cantidad cbx_recalcula_cantidad
cbx_ocultar_costo cbx_ocultar_costo
cbx_imprimir_b cbx_imprimir_b
cbx_ver_proveedor cbx_ver_proveedor
cb_5 cb_5
dw_19 dw_19
dw_20 dw_20
dw_21 dw_21
dw_22 dw_22
cb_6 cb_6
cbx_ver_costo_leo cbx_ver_costo_leo
dw_8 dw_8
cbx_2 cbx_2
p_1 p_1
cb_7 cb_7
p_2 p_2
cb_8 cb_8
sle_1 sle_1
cbx_3 cbx_3
sle_nombre sle_nombre
end type
global w_catalogos w_catalogos

type variables
datawindowchild idwc_tipo, idwc_sexo, idwc_material, idwc_marca, idwc_definicion, idwc_prov, idwc_descrip, idwc_entradas
string is_filtro, is_cadena, is_marcas[], is_producto, is_cadena_paises, is_cadena_clientes, is_bodega_ubica = ' '
str_rangofecha lstr_rangfech, lstr_rangfech_grupo, lstr_rangfech_marca, lstr_rangfech_subgrupo, lstr_rangfech_code_mat , lstr_rangfech_margen, lstr_rangfech_disponible, lstr_rangfech_pattern, lstr_rangfech_oc, lstr_rangfech_accesories, lstr_rangfech_nulos, lstr_rangfech_material, lstr_rangfech_producto, lstr_rangfech_item, lstr_rangfech_fecha, lstr_rangfech_sexo, lstr_rangfech_definicion, lstr_rangfech_proveedor, &
					lstr_rangfech_pais, lstr_rangfech_cliente, lstr_rangfech_body, lstr_rangfech_body2
integer ii_paises[], ii_ann
long il_clientes[]
boolean ib_init


end variables

forward prototypes
public function boolean wf_calcula_promedio (string as_producto, ref decimal ld_promedio, ref decimal ld_margen)
public subroutine wf_ocultar_dws (integer ai_dw)
public subroutine wf_cargar_marcas ()
public function boolean wf_asigna_codigos_alternos (string as_cod_prod, string as_codigo_secundario, integer i)
public function boolean wf_filtra_marca ()
public function boolean wf_filtra_code_mat ()
public subroutine wf_actualiza_reserva_existencia (string as_producto)
public function boolean wf_filtrar_body2 ()
public function boolean wf_filtra_grupo ()
public function long wf_crear_pdf ()
end prototypes

event ue_saveas();string ls_path, ls_title
integer li_respuesta

ls_title = "Reporte de Inventario por Fecha"

li_respuesta = gf_mensaje('','Yes = Salvar a Excel, No = Otro Formato o Cancelar',4,1,'Q')
choose case li_respuesta
	case 1
		ls_path = nv_f.of_browseforfolder("Guardar Excel en ..",true)
		If Len(Trim(ls_path)) > 0 then		
			uf_save_dw_as_excel(dw_1,ls_path+'\'+ls_title+'.xls')
		End If

	case 2
		dw.saveas()
end choose

end event

public function boolean wf_calcula_promedio (string as_producto, ref decimal ld_promedio, ref decimal ld_margen);
SELECT convert(numeric(8,2), sum(dmov_precio_original  * dmov_cantidad)  / sum(dmov_cantidad)),
		 convert(numeric(12,6), sum(prod_costo_fob  * dmov_cantidad)  / sum(dmov_precio_original * dmov_cantidad))
into :ld_promedio, :ld_margen
 FROM indmovim, inmprodu
WHERE ( indmovim.dmov_g_financiero = inmprodu.prod_g_financiero ) AND
		( indmovim.dmov_empresa = inmprodu.prod_empresa ) AND
		( indmovim.dmov_producto = inmprodu.prod_producto ) AND
		( indmovim.dmov_g_financiero = :str.g_financiero ) AND  
		( indmovim.dmov_empresa = :str.empresa ) AND  
		( indmovim.dmov_aplicacion = 'FA') AND
		( indmovim.dmov_producto = :as_producto ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al buscar promedio '+ sqlca.sqlerrtext,1,1,'E')
			return false
		end if

return true
end function

public subroutine wf_ocultar_dws (integer ai_dw);	if ai_dw <> 7 then
		dw_7.visible = false
		wf_cargar_marcas()
	end if
	if ai_dw <> 8 then
		dw_8.visible = false
	end if
	if ai_dw <> 9 then
		dw_9.visible = false
	end if
	if ai_dw <> 10 then
		dw_10.visible = false
	end if
	if ai_dw <> 11 then
		dw_11.visible = false
	end if
	if ai_dw <> 12 then
		dw_12.visible = false
	end if
	if ai_dw <> 13 then
		dw_13.visible = false
	end if
	if ai_dw <> 19 then
		dw_19.visible = false
	end if
	if ai_dw <> 20 then
		dw_20.visible = false
	end if
	if ai_dw <> 21 then
		dw_21.visible = false
	end if
	if ai_dw <> 22 then
		dw_22.visible = false
	end if



end subroutine

public subroutine wf_cargar_marcas ();integer i,j
string   ls_marca, ls_m[]

is_marcas[] = ls_m[]

for i = 1 to dw_7.rowcount()
	if dw_7.getitemnumber(i,'li_check') = 1 then
		j ++
		ls_marca = dw_7.getitemstring(i,'amar_num_marca')
		is_marcas[j] = ls_marca
	end if
next
end subroutine

public function boolean wf_asigna_codigos_alternos (string as_cod_prod, string as_codigo_secundario, integer i);string ls_secundario, ls_taman, ls_descrip_tam, ls_item2
Integer li_valido, li_temp
		
		dw_14.setitem(i,'secundario1','')									
		dw_14.setitem(i,'taman1','')		
		dw_14.setitem(i,'secundario2','')									
		dw_14.setitem(i,'taman2','')		
		dw_14.setitem(i,'secundario3','')									
		dw_14.setitem(i,'taman3','')				
		dw_14.setitem(i,'secundario4','')									
		dw_14.setitem(i,'taman4','')		
		ls_item2 = dw_14.getitemstring(i,'inmprodu_prod_item_secundario')
		
		//Declara el cursor para agrupar las tallas de los otros productos
		 DECLARE secundarios_cur CURSOR FOR
		  SELECT inmprodu.prod_producto, prod_cod_clase_tam        
		  FROM inmprodu  
		WHERE ( ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
				( inmprodu.prod_empresa = :str.empresa ) AND  
				( inmprodu.prod_producto_dos = :as_codigo_secundario  ) AND  
				( inmprodu.prod_producto <> :as_cod_prod ) )    ;
	
				if sqlca.sqlcode = -1 then
					gf_mensaje("Aviso","Error al declarar cursor " + sqlca.sqlerrtext,1,1,"E")
				end if
	
				open secundarios_cur ;
				
				if sqlca.sqlcode = -1 then
					gf_mensaje("Aviso","Error al Abrir cursor " + sqlca.sqlerrtext,1,1,"E")
				end if
				
				fetch secundarios_cur into :ls_secundario, :ls_taman ;
				
				do while sqlca.sqlcode = 0 					

						//Busca el tamaño del producto alterno y lo asigna
						  SELECT cratallas.talla_descripcion  
						 INTO :ls_descrip_tam  
						 FROM cratallas  
						WHERE ( cratallas.talla_g_financiero = :str.g_financiero ) AND  
								( cratallas.talla_empresa = :str.empresa ) AND  
								( cratallas.talla_codigo = :ls_taman )  ;
							if sqlca.sqlcode = -1 then
								gf_mensaje("Aviso","Error al seleccionar el tamano "+sqlca.sqlerrtext,1,1,"E")
							end if
														
									if dw_14.getitemstring(i,'secundario1')  = '' then
										dw_14.setitem(i,'secundario1',ls_secundario)									
										dw_14.setitem(i,'taman1',ls_descrip_tam)		
									elseif dw_14.getitemstring(i,'secundario2')  = '' then
										dw_14.setitem(i,'secundario2',ls_secundario)									
										dw_14.setitem(i,'taman2',ls_descrip_tam)		
									 elseif dw_14.getitemstring(i,'secundario3')  = '' then
										dw_14.setitem(i,'secundario3',ls_secundario)									
										dw_14.setitem(i,'taman3',ls_descrip_tam)											
									elseif dw_14.getitemstring(i,'secundario4')  = '' then
										dw_14.setitem(i,'secundario4',ls_secundario)									
										dw_14.setitem(i,'taman4',ls_descrip_tam)		
									end if
							
					fetch secundarios_cur into :ls_secundario, :ls_taman ;
					
				loop
				close secundarios_cur;
				
return true
end function

public function boolean wf_filtra_marca ();integer li_marcar, i, j, li_incluir, value
long ll_disponible
string ls_descrip_position_print, ls_producto, docname, named, ls_descrip_cod_mat, ls_descrip_marca, ls_descrip_modelo, ls_descrip_pattern, ls_descrip, ls_descripcion, ls_null[], ls_temp, ls_descrip_proveedor, ls_descrip_margen, ls_descrip_oc, ls_descrip_accesories, ls_descrip_material, ls_descrip_productos, ls_descrip_item, ls_descrip_fechas, ls_descrip_sexo, ls_descrip_definicion, ls_descrip_disponible

		this.setredraw(false)
		j = 0
		dw_1.setsort('cramarca_amar_nombre_marca')
		dw_1.sort()
		ls_temp = lstr_rangfech_marca.descripciones
		if len(ls_temp) = 0 or isnull(ls_temp) then lstr_rangfech_marca = lstr_rangfech_nulos
		
		ls_temp = dw_1.getitemString(1,'cramarca_amar_nombre_marca')
		if isnull(ls_temp) then ls_temp = ''		
		if upperbound(lstr_rangfech_marca.descripcion[]) = 0 then 
			for i = 1 to dw_1.rowcount()
				ls_descripcion = dw_1.getitemString(i,'cramarca_amar_nombre_marca')
				if ls_descripcion <> ls_temp then
					j ++
					lstr_rangfech_marca.descripcion[j] = ls_temp
					ls_temp = ls_descripcion
				end if
			next
			if j > 0 then
				j ++
				lstr_rangfech_marca.descripcion[j] = ls_temp
			end if
		end if
		dw_1.setsort('prod_producto')
		dw_1.sort()
		this.setredraw(true)
		if j = 0 and upperbound(lstr_rangfech_marca.descripcion) = 0 then return false
		openwithparm(w_filtrar_rep_exist_marca, lstr_rangfech_marca) //,w_frame,2,Original!)
		lstr_rangfech_marca = message.powerobjectparm
		if not isvalid(lstr_rangfech_marca) then return false
		ls_descrip_marca = lstr_rangfech_marca.descripciones
				
		ll_disponible = dw_3.getitemnumber(1,'disponible')
		li_incluir 		 = dw_3.getitemnumber(1,'incluir')
		is_cadena 	 = ls_descrip_marca
		//Verifica si ha filtrado los Position Print
		if len(lstr_rangfech_grupo.descripciones) > 0 then
			ls_descrip_position_print = lstr_rangfech_grupo.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_position_print
			else
				is_cadena = ls_descrip_position_print
			end if
		end if		
		string ls_descrip_body, ls_descrip_body2
		//Verifica si ha filtrado los Bodies
		if len(lstr_rangfech_body.descripciones) > 0 then
			ls_descrip_body = lstr_rangfech_body.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body
			else
				is_cadena = ls_descrip_body
			end if
		end if		
		
		//Verifica si ha filtrado los Bodies 2
		if len(lstr_rangfech_body2.descripciones) > 0 then
			ls_descrip_body2 = lstr_rangfech_body2.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body2
			else
				is_cadena = ls_descrip_body
			end if
		end if		

		//Verifica si ha filtrado los proveedores
		if len(lstr_rangfech_proveedor.descripciones) > 0 then
			ls_descrip_proveedor = lstr_rangfech_proveedor.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_proveedor
			else
				is_cadena = ls_descrip_proveedor
			end if
		end if
		//Verifica si ha filtrado los Pattern
		if len(lstr_rangfech_pattern.descripciones) > 0 then
			ls_descrip_pattern = lstr_rangfech_pattern.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_pattern
			else
				is_cadena = ls_descrip_pattern
			end if
		end if
		//Verifica si ha filtrado los Modelos
		if len(lstr_rangfech_subgrupo.descripciones) > 0 then
			ls_descrip_modelo = lstr_rangfech_subgrupo.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_modelo
			else
				is_cadena = ls_descrip_modelo
			end if
		end if		
		//Verifica si ha filtrado las FECHAS
		if len(lstr_rangfech_fecha.descripciones) > 0 then
			ls_descrip_fechas = lstr_rangfech_fecha.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_fechas
			else
				is_cadena = ls_descrip_fechas
			end if
		end if
		//Verifica si ha filtrado las Ocs
		if len(lstr_rangfech_oc.descripciones) > 0 then
			ls_descrip_oc = lstr_rangfech_oc.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_oc
			else
				is_cadena = ls_descrip_oc
			end if
		end if
		//Verifica si ha filtrado los productos
		if len(lstr_rangfech_producto.descripciones) > 0 then
			ls_descrip_productos = lstr_rangfech_producto.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_productos
			else
				is_cadena = ls_descrip_productos
			end if
		end if	
		//Verifica si ha filtrado los ITEMS
		if len(lstr_rangfech_item.descripciones) > 0 then
			ls_descrip_item = lstr_rangfech_item.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_item
			else
				is_cadena = ls_descrip_item
			end if
		end if	

		//Verifica si ha filtrado en descripciones
		if len(lstr_rangfech.descripciones) > 0 then
			ls_descrip = lstr_rangfech.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip
			else
				is_cadena = ls_descrip
			end if
		end if
		//Verifica si ha filtrado Materiales
		if len(lstr_rangfech_material.descripciones) > 0 then
			ls_descrip_material = lstr_rangfech_material.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_material
			else
				is_cadena = ls_descrip_material
			end if
		end if

		//Verifica si ha filtrado los margenes
		if len(lstr_rangfech_margen.descripciones) > 0 then
			ls_descrip_margen = lstr_rangfech_margen.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_margen
			else
				is_cadena = ls_descrip_margen
			end if
		end if
		//Verifica si ha filtrado los Accesorios
		if len(lstr_rangfech_accesories.descripciones) > 0 then
			ls_descrip_accesories = lstr_rangfech_accesories.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_accesories
			else
				is_cadena = ls_descrip_accesories
			end if
		end if
		//Verifica si ha filtrado las Definiciones
		if len(lstr_rangfech_definicion.descripciones) > 0 then
			ls_descrip_definicion = lstr_rangfech_definicion.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_definicion
			else
				is_cadena = ls_descrip_definicion
			end if
		end if

		if ll_disponible = 0 then
			if len(is_cadena) > 0 then
				if li_incluir = 1 then
				//	is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
				else
					is_cadena = is_cadena + " and dentero = "+string(ll_disponible)
				end if
			else
				if li_incluir = 1 then
					is_cadena =  "dentero >= "+string(ll_disponible)
				else
					is_cadena =  "dentero = "+string(ll_disponible)
				end if
			end if
		else
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
			else
				is_cadena =  "dentero >= "+string(ll_disponible)
			end if
		end if 
		
		if cbx_cubrio_costo.checked then
			if len(is_cadena) > 0 then
				is_cadena  = is_cadena + ' and total_vendido > total_entrada'
			end if
		end if

		if is_cadena <> '' and not isnull(is_cadena) then
			dw_1.setfilter(is_cadena)
		else
			dw_1.setfilter('')
		end if
		dw_1.filter()

return true
end function

public function boolean wf_filtra_code_mat ();integer li_marcar, i, j, li_incluir, value
long ll_disponible
string ls_descrip_body, ls_descrip_body2, ls_descrip_position_print, ls_producto, docname, named, ls_descrip_cod_mat, ls_descrip_marca, ls_descrip_modelo, ls_descrip_pattern, ls_descrip, ls_descripcion, ls_null[], ls_temp, ls_descrip_proveedor, ls_descrip_margen, ls_descrip_oc, ls_descrip_accesories, ls_descrip_material, ls_descrip_productos, ls_descrip_item, ls_descrip_fechas, ls_descrip_sexo, ls_descrip_definicion, ls_descrip_disponible

		dw_1.setredraw(false)
		j = 0
		dw_1.setsort('cramaterial_mat_cod_material')
		dw_1.sort()
		ls_temp = lstr_rangfech_code_mat.descripciones
		if len(ls_temp) = 0 or isnull(ls_temp) then lstr_rangfech_code_mat = lstr_rangfech_nulos
		
		ls_temp = dw_1.getitemString(1,'cramaterial_mat_cod_material')
		if isnull(ls_temp) then ls_temp = ''		
		if upperbound(lstr_rangfech_code_mat.descripcion[]) = 0 then 
			for i = 1 to dw_1.rowcount()
				ls_descripcion = dw_1.getitemString(i,'cramaterial_mat_cod_material')
				if ls_descripcion <> ls_temp then
					j ++
					lstr_rangfech_code_mat.descripcion[j] = ls_temp
					ls_temp = ls_descripcion
				end if
			next
			if j > 0 then
				j ++
				lstr_rangfech_code_mat.descripcion[j] = ls_temp
			end if
		end if
		dw_1.setsort('prod_producto')
		dw_1.sort()
		dw_1.setredraw(true)
		if j = 0 and upperbound(lstr_rangfech_code_mat.descripcion) = 0 then return false
	//	openwithparm(w_filtrar_rep_exist_cod_mat, lstr_rangfech_code_mat) //,w_frame,2,Original!)
		lstr_rangfech_code_mat = message.powerobjectparm
		if not isvalid(lstr_rangfech_code_mat) then return false
		ls_descrip_cod_mat = lstr_rangfech_code_mat.descripciones
				
		ll_disponible = dw_3.getitemnumber(1,'disponible')
		li_incluir 		 = dw_3.getitemnumber(1,'incluir')
		is_cadena 	 = ls_descrip_cod_mat
		//Verifica si ha filtrado los Position Print
		//Verifica si ha filtrado los Bodies
		if len(lstr_rangfech_body.descripciones) > 0 then
			ls_descrip_body = lstr_rangfech_body.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body
			else
				is_cadena = ls_descrip_body
			end if
		end if		
		
		//Verifica si ha filtrado los Bodies 2
		if len(lstr_rangfech_body2.descripciones) > 0 then
			ls_descrip_body2 = lstr_rangfech_body2.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body2
			else
				is_cadena = ls_descrip_body
			end if
		end if		
		//Verifica si ha filtrado los ITEMS
		if len(lstr_rangfech_item.descripciones) > 0 then
			ls_descrip_item = lstr_rangfech_item.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_item
			else
				is_cadena = ls_descrip_item
			end if
		end if	

		//Verifica si ha filtrado los proveedores
		if len(lstr_rangfech_proveedor.descripciones) > 0 then
			ls_descrip_proveedor = lstr_rangfech_proveedor.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_proveedor
			else
				is_cadena = ls_descrip_proveedor
			end if
		end if
		//Verifica si ha filtrado las marcas
		if len(lstr_rangfech_marca.descripciones) > 0 then
			ls_descrip_marca = lstr_rangfech_marca.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_marca
			else
				is_cadena = ls_descrip_marca
			end if
		end if		
		//Verifica si ha filtrado los Pattern
		if len(lstr_rangfech_pattern.descripciones) > 0 then
			ls_descrip_pattern = lstr_rangfech_pattern.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_pattern
			else
				is_cadena = ls_descrip_pattern
			end if
		end if
		//Verifica si ha filtrado las FECHAS
		if len(lstr_rangfech_fecha.descripciones) > 0 then
			ls_descrip_fechas = lstr_rangfech_fecha.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_fechas
			else
				is_cadena = ls_descrip_fechas
			end if
		end if
		//Verifica si ha filtrado las Ocs
		if len(lstr_rangfech_oc.descripciones) > 0 then
			ls_descrip_oc = lstr_rangfech_oc.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_oc
			else
				is_cadena = ls_descrip_oc
			end if
		end if
		//Verifica si ha filtrado los productos
		if len(lstr_rangfech_producto.descripciones) > 0 then
			ls_descrip_productos = lstr_rangfech_producto.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_productos
			else
				is_cadena = ls_descrip_productos
			end if
		end if	

		//Verifica si ha filtrado en descripciones
		if len(lstr_rangfech.descripciones) > 0 then
			ls_descrip = lstr_rangfech.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip
			else
				is_cadena = ls_descrip
			end if
		end if
		//Verifica si ha filtrado Materiales
		if len(lstr_rangfech_material.descripciones) > 0 then
			ls_descrip_material = lstr_rangfech_material.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_material
			else
				is_cadena = ls_descrip_material
			end if
		end if

		//Verifica si ha filtrado los margenes
		if len(lstr_rangfech_margen.descripciones) > 0 then
			ls_descrip_margen = lstr_rangfech_margen.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_margen
			else
				is_cadena = ls_descrip_margen
			end if
		end if
		//Verifica si ha filtrado los Accesorios
		if len(lstr_rangfech_accesories.descripciones) > 0 then
			ls_descrip_accesories = lstr_rangfech_accesories.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_accesories
			else
				is_cadena = ls_descrip_accesories
			end if
		end if
		//Verifica si ha filtrado las Definiciones
		if len(lstr_rangfech_definicion.descripciones) > 0 then
			ls_descrip_definicion = lstr_rangfech_definicion.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_definicion
			else
				is_cadena = ls_descrip_definicion
			end if
		end if

		if ll_disponible = 0 then
			if len(is_cadena) > 0 then
				if li_incluir = 1 then
				//	is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
				else
					is_cadena = is_cadena + " and dentero = "+string(ll_disponible)
				end if
			else
				if li_incluir = 1 then
					is_cadena =  "dentero >= "+string(ll_disponible)
				else
					is_cadena =  "dentero = "+string(ll_disponible)
				end if
			end if
		else
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
			else
				is_cadena =  "dentero >= "+string(ll_disponible)
			end if
		end if 
		
		if cbx_cubrio_costo.checked then
			if len(is_cadena) > 0 then
				is_cadena  = is_cadena + ' and total_vendido > total_entrada'
			end if
		end if

		if is_cadena <> '' and not isnull(is_cadena) then
			dw_1.setfilter(is_cadena)
		else
			dw_1.setfilter('')
		end if
		dw_1.filter()

return true
end function

public subroutine wf_actualiza_reserva_existencia (string as_producto);string ls_producto, ls_error
ls_producto = as_producto
yield()
sqlca.autocommit = true

		/*Actualiza los reservados del producto, procedentes de pedidos*/
		  UPDATE inmprodu  
		  SET prod_existencia_total = 
isnull(		  (
select   sum((case intmovim.tmov_tipo when 'D' then 1 else - 1 end ) * round((((indmovim.dmov_cantidad * inamedid.medi_cantidad ) + indmovim.dmov_cant1)),2))
    FROM indmovim,
         intmovim,
         inamedid
   WHERE ( intmovim.tmov_g_financiero = indmovim.dmov_g_financiero ) and
         ( intmovim.tmov_empresa = indmovim.dmov_empresa ) and
         ( intmovim.tmov_aplicacion = indmovim.dmov_aplicacion ) and
         ( intmovim.tmov_tipo_transaccion = indmovim.dmov_tipo_transaccion ) and
         ( intmovim.tmov_secuencia = indmovim.dmov_secuencia ) and
         ( intmovim.tmov_anual = indmovim.dmov_anual ) and
         ( intmovim.tmov_concepto = indmovim.dmov_concepto ) and

         ( inamedid.medi_medida = indmovim.dmov_unidad_medida ) and

         ( indmovim.dmov_g_financiero = inmprodu.prod_g_financiero ) and
         ( indmovim.dmov_empresa = inmprodu.prod_empresa ) and
         ( indmovim.dmov_producto = inmprodu.prod_producto )	  		  
		  ),0)
		WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
				( inmprodu.prod_empresa = :str.empresa )  and
				( inmprodu.prod_producto = :ls_producto );
		
			  if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso","Error al Actualizar las Existencias de los Productos ",ls_error)
				sqlca.autocommit = true
				return 
			  end if
		
		yield()
		
		/*Actualiza los reservados del producto, procedentes de factura*/
	//Sql que actualiza las cantidades existentes por bodega
	 
//		str.frame.setmicrohelp("Actualizando Existencias del Producto en Bodega "+ls_producto+".............por favor Espere "+string( i )+' de '+string(ll_total))
		
		/*Para actualizar las cantidades pasadas con la cantidad total del Registro, si la cantidad
		 pasada es mayor a la total*/
	  UPDATE inmbodeg  
		  SET mbod_cantidad = 
isnull(		  (
select 	sum((case intmovim.tmov_tipo when 'D' then 1 else - 1 end ) * round((((indmovim.dmov_cantidad * inamedid.medi_cantidad ) + indmovim.dmov_cant1)),2))
    FROM indmovim,
         intmovim,
         inamedid
   WHERE ( intmovim.tmov_g_financiero = indmovim.dmov_g_financiero ) and
         ( intmovim.tmov_empresa = indmovim.dmov_empresa ) and
         ( intmovim.tmov_aplicacion = indmovim.dmov_aplicacion ) and
         ( intmovim.tmov_tipo_transaccion = indmovim.dmov_tipo_transaccion ) and
         ( intmovim.tmov_secuencia = indmovim.dmov_secuencia ) and
         ( intmovim.tmov_anual = indmovim.dmov_anual ) and
         ( intmovim.tmov_concepto = indmovim.dmov_concepto ) and
         ( inamedid.medi_medida = indmovim.dmov_unidad_medida ) and
         ( inmbodeg.mbod_g_financiero = indmovim.dmov_g_financiero ) AND  
			( inmbodeg.mbod_empresa = indmovim.dmov_empresa ) AND  
			( inmbodeg.mbod_bodega = indmovim.dmov_bodega ) AND  
			( inmbodeg.mbod_ubicacion = indmovim.dmov_ubicacion ) AND  
			( inmbodeg.mbod_producto = indmovim.dmov_producto ) 
	  ),0)
		WHERE ( inmbodeg.mbod_g_financiero = :str.g_financiero ) AND
				( inmbodeg.mbod_empresa = :str.empresa )  AND
					( inmbodeg.mbod_producto = :ls_producto ) ;
					
			  if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso","Error al Actualizar las Cantidades en bodega",ls_error)
				sqlca.autocommit = true
				return 
			  end if			
	yield()

	
/*Actualiza los reservados del producto, procedentes de pedidos*/
		 UPDATE inmprodu  
     SET prod_reserva_total = 
			ISNULL( ( 
 			  SELECT sum(fadpedid.dped_cantidad * inamedid.medi_cantidad + 
                  fadpedid.dped_fraccion - dped_pasada) 
			  FROM fadpedid,inamedid, fatpedid
			  WHERE ( fadpedid.dped_g_financiero = fatpedid.pedi_g_financiero  ) and  
         		  ( fadpedid.dped_empresa = fatpedid.pedi_empresa ) and  
					  ( fadpedid.dped_no_pedido = fatpedid.pedi_no_pedido ) and  
			        ( fadpedid.dped_ann = fatpedid.pedi_ann ) and		        
			  		  ( fatpedid.pedi_estado <> 'P') and					
			  		  ( fadpedid.dped_unidad_venta = inamedid.medi_medida ) and
			        ( fadpedid.dped_g_financiero = inmprodu.prod_g_financiero  ) and  
         		  ( fadpedid.dped_empresa = inmprodu.prod_empresa ) and  
			        ( fadpedid.dped_codigo_item = inmprodu.prod_producto) and
					  ( fadpedid.dped_pasada <= fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion ) and					  
			        ( fadpedid.dped_reserva_origen = 'E')),0) + 
			isnull( (
			  SELECT  sum(faddiari.facd_cantidad * inamedid.medi_cantidad + 
			  			 faddiari.facd_cantidad_fraccion ) 
		     FROM faddiari,
       			 inamedid,
			       fatdiari
			  WHERE ( faddiari.facd_unidad_venta = inamedid.medi_medida ) and
					  ( faddiari.facd_g_financiero = inmprodu.prod_g_financiero  ) and  
			        ( faddiari.facd_empresa = inmprodu.prod_empresa ) and  
					  ( faddiari.facd_codigo_item = inmprodu.prod_producto) and
		           ( fatdiari.fact_g_financiero = faddiari.facd_g_financiero ) and
	              ( fatdiari.fact_empresa = faddiari.facd_empresa ) and
			        ( fatdiari.fact_tipo = faddiari.facd_tipo ) and
	              ( fatdiari.fact_no_pedido = faddiari.facd_no_pedido ) and
			        ( fatdiari.fact_ann = faddiari.facd_ann ) and
			        ( fatdiari.fact_no_pedido not like '%NC%') AND
			        ( fatdiari.fact_estado = 'A' or 
					    ( fatdiari.fact_estado = 'I' and fatdiari.fact_act_inventario = 0 )))
          ,0)					  
    FROM inmprodu
   WHERE ( inmprodu.prod_g_financiero = :str.g_financiero) and
			( inmprodu.prod_empresa = :str.empresa) and
			( inmprodu.prod_producto = :ls_producto );

			  if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso","Error al Actualizar las Reservas de Productos ",ls_error)
				sqlca.autocommit = true
				return 
			  end if
		
		/*Para actualizar las cantidades pasadas con la cantidad total del Registro, si la cantidad
		 pasada es mayor a la total*/
		  UPDATE fadpedid  
			  SET dped_pasada = fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion  
			 FROM fadpedid,   
					inamedid  
			WHERE ( fadpedid.dped_pasada > fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion ) AND  
					( fadpedid.dped_unidad_venta = inamedid.medi_medida ) AND
					( fadpedid.dped_g_financiero = :str.g_financiero ) AND
					( fadpedid.dped_empresa = :str.empresa ) AND
					( fadpedid.dped_codigo_item = :ls_producto );
					
			  if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso","Error al Actualizar las Cantidades Pasadas",ls_error)
				sqlca.autocommit = true
				return 
			  end if
		
		/*Actualiza los reservados por bodega, procedentes de factura*/
	//	str.frame.setmicrohelp("Actualizando Bodega "+ls_producto+".............por favor Espere "+string( i )+' de '+string(ll_total))

		UPDATE inmbodeg
     SET mbod_reserva =
			ISNULL( ( 
 			  SELECT sum(fadpedid.dped_cantidad * inamedid.medi_cantidad + 
                  fadpedid.dped_fraccion - dped_pasada) 
			  FROM fadpedid,inamedid, fatpedid
			  WHERE ( fadpedid.dped_g_financiero = fatpedid.pedi_g_financiero  ) and  
         		  ( fadpedid.dped_empresa = fatpedid.pedi_empresa ) and  
					  ( fadpedid.dped_no_pedido = fatpedid.pedi_no_pedido ) and  
			        ( fadpedid.dped_ann = fatpedid.pedi_ann ) and		        
			  		  ( fatpedid.pedi_estado <> 'P') and
			  		  ( fadpedid.dped_unidad_venta = inamedid.medi_medida ) and
			        ( fadpedid.dped_g_financiero = inmbodeg.mbod_g_financiero  ) and  
         		  ( fadpedid.dped_empresa = inmbodeg.mbod_empresa ) and  
			        ( fadpedid.dped_codigo_item = inmbodeg.mbod_producto) and
        			  ( fadpedid.dped_bodega = inmbodeg.mbod_bodega ) AND  
			        ( fadpedid.dped_ubicacion  = inmbodeg.mbod_ubicacion ) AND  			  			  
					  ( fadpedid.dped_pasada <= fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion ) and	
			        ( fadpedid.dped_reserva_origen = 'E')),0) + 
			isnull( (
			  SELECT  sum(faddiari.facd_cantidad * inamedid.medi_cantidad + 
			  			 faddiari.facd_cantidad_fraccion ) 
		     FROM faddiari,
       			 inamedid,
			       fatdiari
			  WHERE ( faddiari.facd_unidad_venta = inamedid.medi_medida ) and
					  ( faddiari.facd_g_financiero = inmbodeg.mbod_g_financiero  ) and  
			        ( faddiari.facd_empresa = inmbodeg.mbod_empresa ) and  
					  ( faddiari.facd_codigo_item = inmbodeg.mbod_producto) and
        			  ( faddiari.facd_bodega = inmbodeg.mbod_bodega ) AND  
			        ( faddiari.facd_ubicacion  = inmbodeg.mbod_ubicacion ) AND  			  
		           ( fatdiari.fact_g_financiero = faddiari.facd_g_financiero ) and
	              ( fatdiari.fact_empresa = faddiari.facd_empresa ) and
			        ( fatdiari.fact_tipo = faddiari.facd_tipo ) and
	              ( fatdiari.fact_no_pedido = faddiari.facd_no_pedido ) and
			        ( fatdiari.fact_ann = faddiari.facd_ann ) and
			        ( fatdiari.fact_no_pedido not like '%NC%') AND
			        ( fatdiari.fact_estado = 'A' or 
					  ( fatdiari.fact_estado = 'I' and fatdiari.fact_act_inventario = 0 )))
          ,0)					  
    FROM inmbodeg
   WHERE ( inmbodeg.mbod_g_financiero = :str.g_financiero) and
			( inmbodeg.mbod_empresa = :str.empresa) and
			( inmbodeg.mbod_producto = :ls_producto );

			  if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso","Error al Actualizar las Reservas de productos por bodega ",ls_error)
				sqlca.autocommit = true
				return 
			  end if

end subroutine

public function boolean wf_filtrar_body2 ();integer li_marcar, i, j, li_incluir, value
long ll_disponible
string ls_descrip_body, ls_descrip_position_print, ls_producto, docname, named, ls_descrip_cod_mat, ls_descrip_marca, ls_descrip_modelo, ls_descrip_pattern, ls_descrip, ls_descripcion, ls_null[], ls_temp, ls_descrip_proveedor, ls_descrip_margen, ls_descrip_oc, ls_descrip_accesories, ls_descrip_material, ls_descrip_productos, ls_descrip_item, ls_descrip_fechas, ls_descrip_sexo, ls_descrip_definicion, ls_descrip_disponible

		this.setredraw(false)
		j = 0
		dw_1.setsort('prod_body2')
		dw_1.sort()
		ls_temp = lstr_rangfech_body2.descripciones
		if len(ls_temp) = 0 or isnull(ls_temp) then lstr_rangfech_body2 = lstr_rangfech_nulos
		
		ls_temp = dw_1.getitemString(1,'prod_body2')
		if isnull(ls_temp) then ls_temp = ''		
		if upperbound(lstr_rangfech_body2.descripcion[]) = 0 then 
			for i = 1 to dw_1.rowcount()
				ls_descripcion = dw_1.getitemString(i,'prod_body2')
				if ls_descripcion <> ls_temp then
					j ++
					lstr_rangfech_body2.descripcion[j] = ls_temp
					ls_temp = ls_descripcion
				end if
			next
			if j > 0 then
				j ++
				lstr_rangfech_body2.descripcion[j] = ls_temp
			end if
		end if
		dw_1.setsort('prod_producto')
		dw_1.sort()
		this.setredraw(true)
		if j = 0 and upperbound(lstr_rangfech_body2.descripcion) = 0 then return false
		//openwithparm(w_filtrar_rep_exist_body2, lstr_rangfech_body2) //,w_frame,2,Original!)
		lstr_rangfech_body2 = message.powerobjectparm
		if not isvalid(lstr_rangfech_body2) then return false
		ls_descrip_marca = lstr_rangfech_body2.descripciones
				
		ll_disponible = dw_3.getitemnumber(1,'disponible')
		li_incluir 		 = dw_3.getitemnumber(1,'incluir')
		is_cadena 	 = ls_descrip_marca

		//Verifica si ha filtrado los Bodies
		if len(lstr_rangfech_body.descripciones) > 0 then
			ls_descrip_body = lstr_rangfech_body.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body
			else
				is_cadena = ls_descrip_body
			end if
		end if		
		
		//Verifica si ha filtrado los Position Print
		//Verifica si ha filtrado los ITEMS
		if len(lstr_rangfech_item.descripciones) > 0 then
			ls_descrip_item = lstr_rangfech_item.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_item
			else
				is_cadena = ls_descrip_item
			end if
		end if	
		//Verifica si ha filtrado los proveedores
		if len(lstr_rangfech_proveedor.descripciones) > 0 then
			ls_descrip_proveedor = lstr_rangfech_proveedor.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_proveedor
			else
				is_cadena = ls_descrip_proveedor
			end if
		end if
		//Verifica si ha filtrado los Pattern
		if len(lstr_rangfech_pattern.descripciones) > 0 then
			ls_descrip_pattern = lstr_rangfech_pattern.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_pattern
			else
				is_cadena = ls_descrip_pattern
			end if
		end if
		//Verifica si ha filtrado los Modelos
		//Verifica si ha filtrado las FECHAS
		if len(lstr_rangfech_fecha.descripciones) > 0 then
			ls_descrip_fechas = lstr_rangfech_fecha.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_fechas
			else
				is_cadena = ls_descrip_fechas
			end if
		end if
		//Verifica si ha filtrado las Ocs
		if len(lstr_rangfech_oc.descripciones) > 0 then
			ls_descrip_oc = lstr_rangfech_oc.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_oc
			else
				is_cadena = ls_descrip_oc
			end if
		end if
		//Verifica si ha filtrado los productos
		if len(lstr_rangfech_producto.descripciones) > 0 then
			ls_descrip_productos = lstr_rangfech_producto.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_productos
			else
				is_cadena = ls_descrip_productos
			end if
		end if	

		//Verifica si ha filtrado en descripciones
		if len(lstr_rangfech.descripciones) > 0 then
			ls_descrip = lstr_rangfech.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip
			else
				is_cadena = ls_descrip
			end if
		end if
		//Verifica si ha filtrado Materiales
		if len(lstr_rangfech_material.descripciones) > 0 then
			ls_descrip_material = lstr_rangfech_material.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_material
			else
				is_cadena = ls_descrip_material
			end if
		end if

		//Verifica si ha filtrado los margenes
		if len(lstr_rangfech_margen.descripciones) > 0 then
			ls_descrip_margen = lstr_rangfech_margen.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_margen
			else
				is_cadena = ls_descrip_margen
			end if
		end if
		//Verifica si ha filtrado los Accesorios
		if len(lstr_rangfech_accesories.descripciones) > 0 then
			ls_descrip_accesories = lstr_rangfech_accesories.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_accesories
			else
				is_cadena = ls_descrip_accesories
			end if
		end if
		//Verifica si ha filtrado las Definiciones
		if len(lstr_rangfech_definicion.descripciones) > 0 then
			ls_descrip_definicion = lstr_rangfech_definicion.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_definicion
			else
				is_cadena = ls_descrip_definicion
			end if
		end if

		if ll_disponible = 0 then
			if len(is_cadena) > 0 then
				if li_incluir = 1 then
				//	is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
				else
					is_cadena = is_cadena + " and dentero = "+string(ll_disponible)
				end if
			else
				if li_incluir = 1 then
					is_cadena =  "dentero >= "+string(ll_disponible)
				else
					is_cadena =  "dentero = "+string(ll_disponible)
				end if
			end if
		else
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
			else
				is_cadena =  "dentero >= "+string(ll_disponible)
			end if
		end if 
		
		if cbx_cubrio_costo.checked then
			if len(is_cadena) > 0 then
				is_cadena  = is_cadena + ' and total_vendido > total_entrada'
			end if
		end if

		if is_cadena <> '' and not isnull(is_cadena) then
			dw_1.setfilter(is_cadena)
		else
			dw_1.setfilter('')
		end if
		dw_1.filter()

return true
end function

public function boolean wf_filtra_grupo ();integer li_marcar, i, j, li_incluir, value
long ll_disponible
string ls_descrip_position_print, ls_producto, docname, named, ls_descrip_cod_mat, ls_descrip_marca, ls_descrip_modelo, ls_descrip_pattern, ls_descrip, ls_descripcion, ls_null[], ls_temp, ls_descrip_proveedor, ls_descrip_margen, ls_descrip_oc, ls_descrip_accesories, ls_descrip_material, ls_descrip_productos, ls_descrip_item, ls_descrip_fechas, ls_descrip_sexo, ls_descrip_definicion, ls_descrip_disponible
string ls_descrip_body, ls_descrip_body2
//date( prod_entrada_fecha) = date('30/07/2014')
		this.setredraw(false)
		j = 0
		dw_1.setsort('prod_pattern')
		dw_1.sort()
		ls_temp = lstr_rangfech_pattern.descripciones
		if len(ls_temp) = 0 or isnull(ls_temp) then lstr_rangfech_pattern = lstr_rangfech_nulos
		
		ls_temp = dw_1.getitemString(1,'prod_pattern')
		if isnull(ls_temp) then ls_temp = ''		
		if upperbound(lstr_rangfech_pattern.descripcion[]) = 0 then 
			for i = 1 to dw_1.rowcount()
				ls_descripcion = dw_1.getitemString(i,'prod_pattern')
				if ls_descripcion <> ls_temp then
					j ++
					lstr_rangfech_pattern.descripcion[j] = ls_temp
					ls_temp = ls_descripcion
				end if
			next
			if j > 0 then
				j ++
				lstr_rangfech_pattern.descripcion[j] = ls_temp
			end if
		end if
		dw_1.setsort('prod_producto')
		dw_1.sort()
		this.setredraw(true)
		if j = 0 and upperbound(lstr_rangfech_grupo.descripcion) = 0 then return false
		//openwithparm(w_filtrar_rep_exist_pattern, lstr_rangfech_pattern) //,w_frame,2,Original!)
		lstr_rangfech_grupo = message.powerobjectparm
		if not isvalid(lstr_rangfech_grupo) then return false
		ls_descrip_pattern = lstr_rangfech_grupo.descripciones
				
		ll_disponible = dw_3.getitemnumber(1,'disponible')
		li_incluir = dw_3.getitemnumber(1,'incluir')
		is_cadena = ls_descrip_pattern
		//Verifica si ha filtrado los Position Print
		if len(lstr_rangfech_subgrupo.descripciones) > 0 then
			ls_descrip_position_print = lstr_rangfech_subgrupo.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_position_print
			else
				is_cadena = ls_descrip_position_print
			end if
		end if		

		//Verifica si ha filtrado los proveedores
		if len(lstr_rangfech_proveedor.descripciones) > 0 then
			ls_descrip_proveedor = lstr_rangfech_proveedor.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_proveedor
			else
				is_cadena = ls_descrip_proveedor
			end if
		end if
				//Verifica si ha filtrado los Bodies
		if len(lstr_rangfech_body.descripciones) > 0 then
			ls_descrip_body = lstr_rangfech_body.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body
			else
				is_cadena = ls_descrip_body
			end if
		end if		
		//Verifica si ha filtrado los ITEMS
		if len(lstr_rangfech_item.descripciones) > 0 then
			ls_descrip_item = lstr_rangfech_item.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_item
			else
				is_cadena = ls_descrip_item
			end if
		end if	

		//Verifica si ha filtrado los Bodies 2
		if len(lstr_rangfech_body2.descripciones) > 0 then
			ls_descrip_body2 = lstr_rangfech_body2.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body2
			else
				is_cadena = ls_descrip_body
			end if
		end if		

		//Verifica si ha filtrado las marcas
		if len(lstr_rangfech_marca.descripciones) > 0 then
			ls_descrip_marca = lstr_rangfech_marca.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_marca
			else
				is_cadena = ls_descrip_marca
			end if
		end if				
		//Verifica si ha filtrado los Codigos de Material
		if len(lstr_rangfech_code_mat.descripciones) > 0 then
			ls_descrip_cod_mat = lstr_rangfech_code_mat.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_cod_mat
			else
				is_cadena = ls_descrip_cod_mat
			end if
		end if
		//Verifica si ha filtrado las FECHAS
		if len(lstr_rangfech_fecha.descripciones) > 0 then
			ls_descrip_fechas = lstr_rangfech_fecha.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_fechas
			else
				is_cadena = ls_descrip_fechas
			end if
		end if
		//Verifica si ha filtrado las Ocs
		if len(lstr_rangfech_oc.descripciones) > 0 then
			ls_descrip_oc = lstr_rangfech_oc.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_oc
			else
				is_cadena = ls_descrip_oc
			end if
		end if
		//Verifica si ha filtrado los productos
		if len(lstr_rangfech_producto.descripciones) > 0 then
			ls_descrip_productos = lstr_rangfech_producto.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_productos
			else
				is_cadena = ls_descrip_productos
			end if
		end if	

		//Verifica si ha filtrado en descripciones
		if len(lstr_rangfech.descripciones) > 0 then
			ls_descrip = lstr_rangfech.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip
			else
				is_cadena = ls_descrip
			end if
		end if
		//Verifica si ha filtrado Materiales
		if len(lstr_rangfech_material.descripciones) > 0 then
			ls_descrip_material = lstr_rangfech_material.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_material
			else
				is_cadena = ls_descrip_material
			end if
		end if

		//Verifica si ha filtrado los margenes
		if len(lstr_rangfech_margen.descripciones) > 0 then
			ls_descrip_margen = lstr_rangfech_margen.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_margen
			else
				is_cadena = ls_descrip_margen
			end if
		end if
		//Verifica si ha filtrado los Accesorios
		if len(lstr_rangfech_accesories.descripciones) > 0 then
			ls_descrip_accesories = lstr_rangfech_accesories.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_accesories
			else
				is_cadena = ls_descrip_accesories
			end if
		end if
		//Verifica si ha filtrado las Definiciones
		if len(lstr_rangfech_definicion.descripciones) > 0 then
			ls_descrip_definicion = lstr_rangfech_definicion.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_definicion
			else
				is_cadena = ls_descrip_definicion
			end if
		end if

		if ll_disponible = 0 then
			if len(is_cadena) > 0 then
				if li_incluir = 1 then
				//	is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
				else
					is_cadena = is_cadena + " and dentero = "+string(ll_disponible)
				end if
			else
				if li_incluir = 1 then
					is_cadena =  "dentero >= "+string(ll_disponible)
				else
					is_cadena =  "dentero = "+string(ll_disponible)
				end if
			end if
		else
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
			else
				is_cadena =  "dentero >= "+string(ll_disponible)
			end if
		end if 
		
		if cbx_cubrio_costo.checked then
			if len(is_cadena) > 0 then
				is_cadena  = is_cadena + ' and total_vendido > total_entrada'
			end if
		end if

		if is_cadena <> '' and not isnull(is_cadena) then
			dw_1.setfilter(is_cadena)
		else
			dw_1.setfilter('')
		end if
		dw_1.filter()
return true
end function

public function long wf_crear_pdf ();PDFDocument lpdf_doc, lpdf_doc1
String ls_path
long ll_return
Integer li_result
lpdf_doc = create PDFDocument
lpdf_doc1 = create PDFDocument
		
		if dw_5.rowcount() < 1 then
			gf_mensaje('','No hay Informacion para Generar el PDF, Verifique !!!',1,1,'E')
			return -1
		end if
		ls_path = "C:\"
		li_result = GetFolder( "Seleccionar Carpeta Destino", ls_path )

		If Len(Trim(ls_path)) > 0 then			
			 dw_5.Modify ("DataWindow.Export.PDF.Method = NativePDF! ")
			 dw_5.modify("DataWindow.Export.PDF.NativePDF.PDFStandard =1")
			 ll_return =  lpdf_doc.importdatawindow(dw_5)
 			 lpdf_doc.CompressionLevel = 9
			 ll_return = lpdf_doc.save(ls_path+"\Catalogo.pdf")
			 destroy lpdf_doc
			 gf_mensaje('','Documento Generado',1,1,'E')
		end if
		if not rb_2.checked then dw_5.visible = false
			
return ll_return
end function

on w_catalogos.create
int iCurrent
call super::create
this.em_desde=create em_desde
this.em_hasta=create em_hasta
this.st_1=create st_1
this.st_2=create st_2
this.cb_1=create cb_1
this.cb_salir=create cb_salir
this.calendario=create calendario
this.calendario2=create calendario2
this.uo_1=create uo_1
this.uo_2=create uo_2
this.phl_foto=create phl_foto
this.shl_1=create shl_1
this.dw_3=create dw_3
this.dw_5=create dw_5
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cbx_1=create cbx_1
this.pb_1=create pb_1
this.st_3=create st_3
this.cbx_back=create cbx_back
this.hpb_barra=create hpb_barra
this.cbx_cubrio_costo=create cbx_cubrio_costo
this.cb_2=create cb_2
this.dw_7=create dw_7
this.dw_9=create dw_9
this.dw_10=create dw_10
this.dw_11=create dw_11
this.dw_12=create dw_12
this.dw_13=create dw_13
this.cb_3=create cb_3
this.dw_14=create dw_14
this.dw_15=create dw_15
this.cbx_ambas=create cbx_ambas
this.dw_16=create dw_16
this.cb_4=create cb_4
this.cb_back=create cb_back
this.cbx_recalcula_cantidad=create cbx_recalcula_cantidad
this.cbx_ocultar_costo=create cbx_ocultar_costo
this.cbx_imprimir_b=create cbx_imprimir_b
this.cbx_ver_proveedor=create cbx_ver_proveedor
this.cb_5=create cb_5
this.dw_19=create dw_19
this.dw_20=create dw_20
this.dw_21=create dw_21
this.dw_22=create dw_22
this.cb_6=create cb_6
this.cbx_ver_costo_leo=create cbx_ver_costo_leo
this.dw_8=create dw_8
this.cbx_2=create cbx_2
this.p_1=create p_1
this.cb_7=create cb_7
this.p_2=create p_2
this.cb_8=create cb_8
this.sle_1=create sle_1
this.cbx_3=create cbx_3
this.sle_nombre=create sle_nombre
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_desde
this.Control[iCurrent+2]=this.em_hasta
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_salir
this.Control[iCurrent+7]=this.calendario
this.Control[iCurrent+8]=this.calendario2
this.Control[iCurrent+9]=this.uo_1
this.Control[iCurrent+10]=this.uo_2
this.Control[iCurrent+11]=this.phl_foto
this.Control[iCurrent+12]=this.shl_1
this.Control[iCurrent+13]=this.dw_3
this.Control[iCurrent+14]=this.dw_5
this.Control[iCurrent+15]=this.rb_1
this.Control[iCurrent+16]=this.rb_2
this.Control[iCurrent+17]=this.cbx_1
this.Control[iCurrent+18]=this.pb_1
this.Control[iCurrent+19]=this.st_3
this.Control[iCurrent+20]=this.cbx_back
this.Control[iCurrent+21]=this.hpb_barra
this.Control[iCurrent+22]=this.cbx_cubrio_costo
this.Control[iCurrent+23]=this.cb_2
this.Control[iCurrent+24]=this.dw_7
this.Control[iCurrent+25]=this.dw_9
this.Control[iCurrent+26]=this.dw_10
this.Control[iCurrent+27]=this.dw_11
this.Control[iCurrent+28]=this.dw_12
this.Control[iCurrent+29]=this.dw_13
this.Control[iCurrent+30]=this.cb_3
this.Control[iCurrent+31]=this.dw_14
this.Control[iCurrent+32]=this.dw_15
this.Control[iCurrent+33]=this.cbx_ambas
this.Control[iCurrent+34]=this.dw_16
this.Control[iCurrent+35]=this.cb_4
this.Control[iCurrent+36]=this.cb_back
this.Control[iCurrent+37]=this.cbx_recalcula_cantidad
this.Control[iCurrent+38]=this.cbx_ocultar_costo
this.Control[iCurrent+39]=this.cbx_imprimir_b
this.Control[iCurrent+40]=this.cbx_ver_proveedor
this.Control[iCurrent+41]=this.cb_5
this.Control[iCurrent+42]=this.dw_19
this.Control[iCurrent+43]=this.dw_20
this.Control[iCurrent+44]=this.dw_21
this.Control[iCurrent+45]=this.dw_22
this.Control[iCurrent+46]=this.cb_6
this.Control[iCurrent+47]=this.cbx_ver_costo_leo
this.Control[iCurrent+48]=this.dw_8
this.Control[iCurrent+49]=this.cbx_2
this.Control[iCurrent+50]=this.p_1
this.Control[iCurrent+51]=this.cb_7
this.Control[iCurrent+52]=this.p_2
this.Control[iCurrent+53]=this.cb_8
this.Control[iCurrent+54]=this.sle_1
this.Control[iCurrent+55]=this.cbx_3
this.Control[iCurrent+56]=this.sle_nombre
end on

on w_catalogos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_desde)
destroy(this.em_hasta)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.cb_salir)
destroy(this.calendario)
destroy(this.calendario2)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.phl_foto)
destroy(this.shl_1)
destroy(this.dw_3)
destroy(this.dw_5)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cbx_1)
destroy(this.pb_1)
destroy(this.st_3)
destroy(this.cbx_back)
destroy(this.hpb_barra)
destroy(this.cbx_cubrio_costo)
destroy(this.cb_2)
destroy(this.dw_7)
destroy(this.dw_9)
destroy(this.dw_10)
destroy(this.dw_11)
destroy(this.dw_12)
destroy(this.dw_13)
destroy(this.cb_3)
destroy(this.dw_14)
destroy(this.dw_15)
destroy(this.cbx_ambas)
destroy(this.dw_16)
destroy(this.cb_4)
destroy(this.cb_back)
destroy(this.cbx_recalcula_cantidad)
destroy(this.cbx_ocultar_costo)
destroy(this.cbx_imprimir_b)
destroy(this.cbx_ver_proveedor)
destroy(this.cb_5)
destroy(this.dw_19)
destroy(this.dw_20)
destroy(this.dw_21)
destroy(this.dw_22)
destroy(this.cb_6)
destroy(this.cbx_ver_costo_leo)
destroy(this.dw_8)
destroy(this.cbx_2)
destroy(this.p_1)
destroy(this.cb_7)
destroy(this.p_2)
destroy(this.cb_8)
destroy(this.sle_1)
destroy(this.cbx_3)
destroy(this.sle_nombre)
end on

event ue_post_open;/* dw corresponde al datawindows que se desea imprimir, por tanto
   si desea asignarle otro nombre haga lo siguiente 
	dw = otro_nombre */
//if str.empresa = 9 then 
//	dw_1.dataobject = 'dw_rep_inventario_x_fecha_sportoni'
//else
//	dw_1.dataobject = 'dw_rep_inventario_x_fecha'
//end if
	
dw = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()

Datawindowchild ldwc_vendedores
em_hasta.text = string(date(gf_fecha_serv()))
em_desde.text = string(relativedate(date(gf_fecha_serv()), - 365))
em_desde.setfocus()

//is_syntax_7 = dw_7.getsqlselect()
dw_7.settransobject(sqlca)
dw_7.retrieve(str.g_financiero, str.empresa)
dw_7.insertrow(1)
dw_16.settransobject(sqlca)

dw_8.settransobject(sqlca)
dw_8.retrieve(str.g_financiero, str.empresa)
dw_8.insertrow(1)

dw_21.settransobject(sqlca)
dw_21.retrieve(str.g_financiero, str.empresa)
dw_21.insertrow(1)

dw_9.settransobject(sqlca)
dw_9.retrieve(str.g_financiero, str.empresa)
dw_9.insertrow(1)

dw_10.settransobject(sqlca)
dw_10.retrieve(str.g_financiero, str.empresa)
dw_10.insertrow(1)

dw_11.settransobject(sqlca)
dw_11.retrieve(str.g_financiero, str.empresa)
dw_11.insertrow(1)

dw_12.settransobject(sqlca)
dw_12.retrieve(str.g_financiero, str.empresa)
dw_12.insertrow(1)

dw_13.settransobject(sqlca)
dw_13.retrieve()
dw_13.insertrow(1)

dw_19.settransobject(sqlca)
dw_19.retrieve(str.g_financiero, str.empresa)
dw_19.insertrow(1)

dw_20.settransobject(sqlca)
dw_20.retrieve(str.g_financiero, str.empresa)
dw_20.insertrow(1)


dw_22.settransobject(sqlca)
dw_22.retrieve(str.g_financiero, str.empresa)
dw_22.insertrow(1)

dw_3.settransobject(sqlca)

//dw_3.getchild('proveedor_tercero', idwc_prov)
//dw_3.getchild('marca', idwc_marca)
//dw_3.getchild('sexo', idwc_sexo)

//dw_3.getchild('tipo', idwc_tipo)
//dw_3.getchild('material', idwc_material)
//dw_3.getchild('definicion', idwc_definicion)
//dw_3.getchild('descripcion', idwc_descrip)

//idwc_sexo.settransobject(sqlca)
//idwc_tipo.settransobject(sqlca)
//idwc_material.settransobject(sqlca)
//idwc_marca.settransobject(sqlca)
//idwc_definicion.settransobject(sqlca)
//idwc_prov.settransobject(sqlca)
//idwc_descrip.settransobject(sqlca)

yield()
//idwc_sexo.retrieve(str.g_financiero, str.empresa)
//idwc_tipo.retrieve(str.g_financiero, str.empresa)
//idwc_material.retrieve(str.g_financiero, str.empresa)
//idwc_marca.retrieve(str.g_financiero, str.empresa)
//idwc_definicion.retrieve(str.g_financiero, str.empresa)
//idwc_prov.retrieve(str.g_financiero, str.empresa)
//idwc_descrip.retrieve(str.g_financiero, str.empresa)
//idwc_tipo.insertrow(1)
//idwc_tipo.setitem(1,'amar_num_marca', '1516')
//idwc_tipo.setitem(1,'amar_nombre_marca', 'BABY LOONEY TUNES Y LOONEY TUNES')

//idwc_tipo.insertrow(1)
//idwc_sexo.insertrow(1)
//idwc_material.insertrow(1)
//idwc_marca.insertrow(1)
//idwc_definicion.insertrow(1)
//idwc_prov.insertrow(1)
//idwc_descrip.insertrow(1)
ii_ann = year(date(gf_fecha_serv()))
dw_3.getchild('entrada', idwc_entradas)
idwc_entradas.settransobject(sqlca);
idwc_entradas.retrieve(str.g_financiero, str.empresa, ii_ann)
idwc_entradas.insertrow(1)

dw_3.insertrow(1)
dw_3.setitem(1, "disponible", 0)
dw_3.setitem(1, "ann", ii_ann )

dw_14.settransobject(sqlca)
dw_15.settransobject(sqlca)

if str.empresa = 1 then
	dw_5.dataobject = 'catalogo_inventario_total_4_por_pagina'
else
	dw_5.dataobject = 'catalogo_inventario_total_4_por_pagina_tm'
end if

dw_1.sharedata(dw_5)


//cb_1.triggerevent('clicked')
end event

event resize;call super::resize;//OVERRIDE
this.SetRedraw(false)
dw_1.width  = this.width  - 2300
dw_1.height = this.height - 580
dw_5.width  = this.width  - 150
dw_5.height = this.height - 580
gb_1.width  = this.width  - 125
gb_1.height = this.height - 470


phl_foto.x = dw_1.width + 60
shl_1.x = dw_1.width  + 60

pb_1.x =  dw_1.width + 80
st_3.x = dw_1.width   + 200

cbx_back.x = dw_1.width   + 150
cbx_1.x = dw_1.width + 150
cbx_ambas.x = dw_1.width + 150
cbx_ocultar_costo.x = dw_1.width + 150
cb_4.x = dw_1.width + 150
cb_5.x = dw_1.width + 150
cb_back.x = dw_1.width + 900
st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180
this.SetRedraw(true)
end event

event ue_print;
//	dw_5.object.desde.expression = "'"+em_desde.text+"'"
//	dw_5.object.hasta.expression = "'"+em_hasta.text+"'"
//	dw_5.object.usuario.expression = "'" + str.usuario + "'"
//	if cbx_ocultar_costo.checked then
//		dw_5.modify('inmprodu_prod_costo_fob.visible=false')
//		dw_5.modify('prod_precio_promedio.visible=false')
//		dw_5.modify('inmprodu_prod_costo_fob_t.visible=false')
//		dw_5.modify('prod_precio_promedio_t.visible=false')	
//		dw_5.modify('l_4.visible=false')
//		dw_5.modify('l_10.visible=false')	
//		dw_5.modify('inmprodu_prod_descripcion_t.x=1563')
//	else
//		dw_5.modify('inmprodu_prod_costo_fob.visible=true')
//		dw_5.modify('prod_precio_promedio.visible=true')	
//		dw_5.modify('inmprodu_prod_costo_fob_t.visible=true')
//		dw_5.modify('prod_precio_promedio_t.visible=true')	
//		dw_5.modify('l_4.visible=true')
//		dw_5.modify('l_10.visible=true')
//		dw_5.modify('inmprodu_prod_descripcion_t.x=1349')
//	end if
//		dw_5.Modify("DataWindow.Zoom='80'")

if dw_5.visible then
	dw_5.Modify("DataWindow.Zoom='100'")
	OpenWithParm(w_dw_print_options, dw_5)
	If Message.DoubleParm = -1 Then Return
	dw_5.Print(True)
else
	dw_1.Modify("DataWindow.Zoom='90'")
	OpenWithParm(w_dw_print_options, dw_1)
	If Message.DoubleParm = -1 Then 
		dw_1.Modify("DataWindow.Zoom='100'")
		Return
	end if
	dw_1.Print(True)
	dw_5.Modify("DataWindow.Zoom='100'")
end if
end event

event ue_save_as;//
//dw_1.saveas()

string ls_path, ls_title
integer li_respuesta

li_respuesta = gf_mensaje('','Yes = Salvar a Excel, No = Otro Formato o Cancelar',4,1,'Q')
choose case li_respuesta
	case 1
		ls_path = nv_f.of_browseforfolder("Guardar Excel en ..",true)
		If Len(Trim(ls_path)) > 0 then		
			uf_save_dw_as_excel(dw,ls_path+'\'+ls_title+'.xls')
		End If

	case 2
		dw.saveas()
end choose

end event

event open;call super::open;sqlca.autocommit = true

end event

event ue_filter;call super::ue_filter;dw_1.groupcalc()
end event

event ue_sort;call super::ue_sort;dw_1.groupcalc()

end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_catalogos
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_catalogos
boolean visible = false
integer x = 41
integer y = 2116
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_catalogos
integer y = 372
integer width = 4375
integer height = 1816
string dataobject = "dw_rep_inventario_x_fecha"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::ue_microayuda;////override
//Integer li_pos, li_x, li_y,li_largo
//String ls_objeto, ls_col
//
//return
//
//ls_objeto = This.GetObjectAtPointer()
//li_pos = pos  (ls_objeto,"~t")
//ls_col = left (ls_objeto, li_pos - 1)
//
//// Dependiendo de la Columna el Mensaje de Ayuda varía
//CHOOSE CASE ls_col
//	case 'inmprodu_prod_descripcion'
//		this.Modify("inmprodu_prod_descripcion.Font.Underline='1'")
//	case 'indmovim_dmov_producto'
//		this.Modify("indmovim_dmov_producto.Font.Underline='1'")
//	case	'inmprodu_prod_producto_dos'
//		this.Modify("inmprodu_prod_producto_dos.Font.Underline='1'")
//	case else
//		this.Modify("inmprodu_prod_descripcion.Font.Underline='0'")		
//		this.Modify("indmovim_dmov_producto.Font.Underline='0'")
//		this.Modify("inmprodu_prod_producto_dos.Font.Underline='0'")
//end choose


end event

event dw_1::clicked;call super::clicked;//dw=tab_1.tabpage_1.dw_1
//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto
integer li_pos 

wf_ocultar_dws(0)

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
	return
end if


this.accepttext()
string ls_col, ls_prod = '', ls_oc, ls_foto, ls_producto
		
	if ls_objeto = 'prod_producto' then
//
//			str_kardex  str_opcion
//		
		ls_producto = this.getitemstring(row,'prod_producto')				
//			
//			str_opcion.kproducto=ls_producto
//
//			window lw_win, lw_first
//			lw_first = w_frame.GetFirstSheet()				
//			lw_win = w_frame.GetNextSheet(lw_first)
//				do while isvalid(lw_win)
//					if lw_win.classname()  = "w_dmc" then
//						//gf_mensaje('','Esta abierta  Dirigirse a DMC',1,1,'E')
//						lw_win.BringToTop = TRUE
//						w_dmc.wf_asignar(str_opcion.kproducto)
//						return
//					end if
//					lw_win = w_frame.GetNextSheet(lw_win)					
//				loop
//			
			if isvalid(w_fa_co_consulta_existencia) then
					if w_fa_co_consulta_existencia.dw_1.Retrieve(str.g_financiero,str.empresa,ls_producto, is_bodega_ubica ) > 0 then
						w_fa_co_consulta_existencia.dw_6.retrieve(str.g_financiero, str.empresa, ls_producto)
					end if
					w_fa_co_consulta_existencia.BringToTop = true
			else
				OpenSheetWithParm(w_fa_co_consulta_existencia, ls_producto, "w_fa_co_consulta_existencia", str.frame, 0, Layered!)			
			end if
		end if
//		
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;if currentrow > 0 then
	phl_foto.picturename = dw_1.getitemstring(currentrow, 'prod_foto_dir')
end if
end event

event dw_1::sqlpreview;call super::sqlpreview;string ls_cadena_pattern, ls_pattern, ls_position_print, ls_cadena_position_print, ls_comprador, ls_cadena_comprador, ls_cadena_definicion, ls_definicion,  ls_cadena_material, ls_material, ls_descrip, ls_code,ls_cadena_descrip , ls_marca, ls_syntax, ls_cadena_marca = '', ls_sexo, ls_cadena_sexo, ls_cadena_tercero, ls_tipo, ls_cadena_tipo, ls_cadena_nivel3, ls_cadena_nivel4, ls_cadena_nivel2, ls_cadena_nivel5
integer i, j
long ll_tercero, ll_pais, ll_tipo
ls_syntax = sqlsyntax

if dw_3.getitemnumber(1,'por_entrada') = 1 then return

for i = 2 to dw_7.rowcount()
	if dw_7.getitemnumber(i,'li_check') = 1 then
		ls_marca = dw_7.getitemstring(i,'amar_num_marca')
		if ls_cadena_marca = '' then
			ls_cadena_marca = ls_cadena_marca + ' and ( prod_marca = "'+ls_marca+'"'
		else
			ls_cadena_marca = ls_cadena_marca + ' or prod_marca = "'+ls_marca+'"'			
		end if
	end if
next
if ls_cadena_marca <> '' then ls_cadena_marca = ls_cadena_marca + ') '
ls_syntax = ls_syntax + ls_cadena_marca

for i = 2 to dw_8.rowcount()
	if dw_8.getitemnumber(i,'li_check') = 1 then
		ls_marca = dw_8.getitemstring(i,'prod_nivel3')
		if ls_cadena_nivel3 = '' then
			ls_cadena_nivel3 = ls_cadena_nivel3 + ' and ( prod_nivel3 = "'+ls_marca+'"'
		else
			ls_cadena_nivel3 = ls_cadena_nivel3 + ' or prod_nivel3 = "'+ls_marca+'"'			
		end if
	end if
next
if ls_cadena_nivel3 <> '' then ls_cadena_nivel3 = ls_cadena_nivel3 + ') '
ls_syntax = ls_syntax + ls_cadena_nivel3

for i = 2 to dw_21.rowcount()
	if dw_21.getitemnumber(i,'li_check') = 1 then
		ls_marca = dw_21.getitemstring(i,'prod_nivel4')
		if ls_cadena_nivel4 = '' then
			ls_cadena_nivel4 = ls_cadena_nivel4 + ' and ( prod_nivel4 = "'+ls_marca+'"'
		else
			ls_cadena_nivel4 = ls_cadena_nivel4 + ' or prod_nivel4 = "'+ls_marca+'"'			
		end if
	end if
next
if ls_cadena_nivel4 <> '' then ls_cadena_nivel4 = ls_cadena_nivel4 + ') '
ls_syntax = ls_syntax + ls_cadena_nivel4


for i = 2 to dw_9.rowcount()
	if dw_9.getitemnumber(i,'li_check') = 1 then
		ls_marca = dw_9.getitemstring(i,'prod_nivel5')
		if ls_cadena_nivel5 = '' then
			ls_cadena_nivel5 = ls_cadena_nivel5 + ' and ( prod_nivel5 = "'+ls_marca+'"'
		else
			ls_cadena_nivel5 = ls_cadena_nivel5 + ' or prod_nivel5 = "'+ls_marca+'"'			
		end if
	end if
next
if ls_cadena_nivel5 <> '' then ls_cadena_nivel5 = ls_cadena_nivel5 + ') '
ls_syntax = ls_syntax + ls_cadena_nivel5


for i = 1 to dw_10.rowcount()
	if dw_10.getitemnumber(i,'li_check') = 1 then
		ls_descrip = dw_10.getitemstring(i,'deta_desc_eng')
		if ls_cadena_descrip = '' then
			ls_cadena_descrip = ls_cadena_descrip + ' and ( cradetalle.deta_desc_eng = "'+ls_descrip+'"'
		else
			ls_cadena_descrip = ls_cadena_descrip + ' or cradetalle.deta_desc_eng = "'+ls_descrip+'"'			
		end if	
	end if
next
if ls_cadena_descrip <> '' then ls_cadena_descrip = ls_cadena_descrip + ') '
ls_syntax = ls_syntax + ls_cadena_descrip

for i = 1 to dw_11.rowcount()
	if dw_11.getitemnumber(i,'li_check') = 1 then
		ls_material = dw_11.getitemstring(i,'prod_nivel1')
		if ls_cadena_material = '' then
			ls_cadena_material = ls_cadena_material + ' and ( prod_nivel1 = "'+ls_material+'"'
		else
			ls_cadena_material = ls_cadena_material + ' or prod_nivel1 = "'+ls_material+'"'			
		end if	
	end if
next
if ls_cadena_material <> '' then ls_cadena_material = ls_cadena_material + ') '
ls_syntax = ls_syntax + ls_cadena_material

for i = 1 to dw_12.rowcount()
	if dw_12.getitemnumber(i,'li_check') = 1 then
		ls_definicion= dw_12.getitemstring(i,'prod_nivel2')
		if ls_cadena_nivel2 = '' then
			ls_cadena_nivel2 = ls_cadena_nivel2 + ' and ( inmprodu.prod_nivel2 = "'+ls_definicion+'"'
		else
			ls_cadena_nivel2 = ls_cadena_nivel2 + ' or inmprodu.prod_nivel2 = "'+ls_definicion+'"'			
		end if	
	end if
next
if ls_cadena_nivel2 <> '' then ls_cadena_nivel2 = ls_cadena_nivel2 + ') '
ls_syntax = ls_syntax + ls_cadena_nivel2

for i = 1 to dw_13.rowcount()
	if dw_13.getitemnumber(i,'li_check') = 1 then
		ls_comprador= dw_13.getitemstring(i,'usua_id')
		if ls_cadena_comprador = '' then
			ls_cadena_comprador = ls_cadena_comprador + ' and ( inmprodu.prod_comprador = "'+ls_comprador+'"'
		else
			ls_cadena_comprador = ls_cadena_comprador + ' or  inmprodu.prod_comprador = "'+ls_comprador+'"'			
		end if	
	end if
next
if ls_cadena_comprador <> '' then ls_cadena_comprador = ls_cadena_comprador + ') '
ls_syntax = ls_syntax + ls_cadena_comprador

for i = 1 to dw_19.rowcount()
	if dw_19.getitemnumber(i,'li_check') = 1 then
		ls_pattern = dw_19.getitemstring(i,'prod_pattern')
		if ls_cadena_pattern = '' then
			if ls_pattern = '' then
				ls_cadena_pattern = ls_cadena_pattern + ' and ( inmprodu.prod_pattern = "'+ls_pattern+'" or  inmprodu.prod_pattern = NULL '
			else
				ls_cadena_pattern = ls_cadena_pattern + ' and ( inmprodu.prod_pattern = "'+ls_pattern+'"'
			end if
		else
			ls_cadena_pattern = ls_cadena_pattern + ' or  inmprodu.prod_pattern = "'+ls_pattern+'"'			
		end if	
	end if
next
if ls_cadena_pattern <> '' then ls_cadena_pattern = ls_cadena_pattern + ') '
ls_syntax = ls_syntax + ls_cadena_pattern

for i = 1 to dw_20.rowcount()
	if dw_20.getitemnumber(i,'li_check') = 1 then
		ls_position_print = dw_20.getitemstring(i,'prod_position_print')
		if ls_cadena_position_print = '' then
			ls_cadena_position_print = ls_cadena_position_print + ' and ( inmprodu.prod_position_print = "'+ls_position_print+'"'
		else
			ls_cadena_position_print = ls_cadena_position_print + ' or  inmprodu.prod_position_print = "'+ls_position_print+'"'			
		end if	
	end if
next
if ls_cadena_position_print <> '' then ls_cadena_position_print = ls_cadena_position_print + ') '
ls_syntax = ls_syntax + ls_cadena_position_print


is_cadena_clientes = ""
for i = 1 to dw_22.rowcount()
	if dw_22.getitemnumber(i,'li_check') = 1 then
		ll_tercero = dw_22.getitemNumber(i,'terc_tercero')
		if is_cadena_clientes = "" then
			is_cadena_clientes = is_cadena_clientes +"'"+ string(ll_tercero)+"'"
		else
			is_cadena_clientes = is_cadena_clientes + ", '"+string(ll_tercero)+"'"	
		end if	
	j ++
	il_clientes[j] = ll_tercero
	end if
next


this.setsqlpreview(ls_syntax)

//		if is_cadena_paises = "" then
//			is_cadena_paises = is_cadena_paises +"'"+ string(ll_pais)+"'"
//		else
//			is_cadena_paises = is_cadena_paises + ", '"+string(ll_pais)+"'"	
//		end if	
//
end event

event dw_1::buttonclicked;call super::buttonclicked;integer li_marcar, i, j, li_incluir, value
long ll_disponible
string ls_descrip_position_print, ls_producto, docname, named, ls_descrip_cod_mat, ls_descrip_marca, ls_descrip_modelo, ls_descrip_pattern, ls_descrip, ls_descripcion, ls_null[], ls_temp, ls_descrip_proveedor, ls_descrip_margen, ls_descrip_oc, ls_descrip_accesories, ls_descrip_material, ls_descrip_productos, ls_descrip_item, ls_descrip_fechas, ls_descrip_sexo, ls_descrip_definicion, ls_descrip_disponible
string ls_descrip_body, ls_descrip_body2
//date( prod_entrada_fecha) = date('30/07/2014')

if dwo.name = 'b_marcar' then
	if this.rowcount() = 0 then return
	li_marcar = this.getitemnumber(1,'incluir')
	if li_marcar = 1 then
		li_marcar = 0
	else
		li_marcar = 1
	end if
	for i = 1 to this.rowcount()
		this.setitem(i,'incluir',li_marcar)
	next
elseif dwo.name = 'b_importar' then
//Filtra el Position Print
//MARCA DEL PRODUCTO	
elseif dwo.name ='b_marca' then
	wf_filtra_marca()		
//////////////////////////////Codigo material
elseif dwo.name = 'b_code_mat' then
	wf_filtra_code_mat()	
//////////////////////////////Modelo
//////////////////////////////Modelo
elseif dwo.name = 'b_disponible' then
		parent.setredraw(false)
		j = 0
		dw_1.setsort('dentero')
		dw_1.sort()
		ls_temp = lstr_rangfech_disponible.descripciones
		if len(ls_temp) = 0 or isnull(ls_temp) then lstr_rangfech_disponible = lstr_rangfech_nulos
		
		ls_temp = string(dw_1.getitemNumber(1,'dentero'))
		if isnull(ls_temp) then ls_temp = ''		
		if upperbound(lstr_rangfech_disponible.descripcion[]) = 0 then 
			for i = 1 to dw_1.rowcount()
				ls_descripcion = string(dw_1.getitemNumber(i,'dentero'))
				if ls_descripcion <> ls_temp then
					j ++
					lstr_rangfech_disponible.descripcion[j] = ls_temp
					ls_temp = ls_descripcion
				end if
			next
			if j > 0 then
				j ++
				lstr_rangfech_disponible.descripcion[j] = ls_temp
			end if
		end if
		dw_1.setsort('prod_producto')
		dw_1.sort()
		parent.setredraw(true)
		if j = 0 and upperbound(lstr_rangfech_disponible.descripcion) = 0 then return
		//openwithparm(w_filtrar_rep_exist_disponible, lstr_rangfech_disponible) //,w_frame,2,Original!)
		lstr_rangfech_disponible = message.powerobjectparm
		if not isvalid(lstr_rangfech_disponible) then return
		ls_descrip_disponible = lstr_rangfech_disponible.descripciones
				
		ll_disponible = dw_3.getitemnumber(1,'disponible')
		li_incluir = dw_3.getitemnumber(1,'incluir')
		is_cadena = ls_descrip_disponible
		//Verifica si ha filtrado los ITEMS
		if len(lstr_rangfech_item.descripciones) > 0 then
			ls_descrip_item = lstr_rangfech_item.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_item
			else
				is_cadena = ls_descrip_item
			end if
		end if			
		//Verifica si ha filtrado los Bodies
		if len(lstr_rangfech_body.descripciones) > 0 then
			ls_descrip_body = lstr_rangfech_body.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body
			else
				is_cadena = ls_descrip_body
			end if
		end if		
		
		//Verifica si ha filtrado los Bodies 2
		if len(lstr_rangfech_body2.descripciones) > 0 then
			ls_descrip_body2 = lstr_rangfech_body2.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body2
			else
				is_cadena = ls_descrip_body
			end if
		end if		

		//Verifica si ha filtrado los proveedores
		if len(lstr_rangfech_proveedor.descripciones) > 0 then
			ls_descrip_proveedor = lstr_rangfech_proveedor.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_proveedor
			else
				is_cadena = ls_descrip_proveedor
			end if
		end if
		//Verifica si ha filtrado las marcas
		if len(lstr_rangfech_marca.descripciones) > 0 then
			ls_descrip_marca = lstr_rangfech_marca.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_marca
			else
				is_cadena = ls_descrip_marca
			end if
		end if				
		//Verifica si ha filtrado los Codigos de Material
		if len(lstr_rangfech_code_mat.descripciones) > 0 then
			ls_descrip_cod_mat = lstr_rangfech_code_mat.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_cod_mat
			else
				is_cadena = ls_descrip_cod_mat
			end if
		end if
		//Verifica si ha filtrado los Modelos

		//Verifica si ha filtrado los Pattern
		if len(lstr_rangfech_pattern.descripciones) > 0 then
			ls_descrip_pattern = lstr_rangfech_pattern.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_pattern
			else
				is_cadena = ls_descrip_pattern
			end if
		end if
		//Verifica si ha filtrado las FECHAS
		if len(lstr_rangfech_fecha.descripciones) > 0 then
			ls_descrip_fechas = lstr_rangfech_fecha.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_fechas
			else
				is_cadena = ls_descrip_fechas
			end if
		end if
		//Verifica si ha filtrado las Ocs
		if len(lstr_rangfech_oc.descripciones) > 0 then
			ls_descrip_oc = lstr_rangfech_oc.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_oc
			else
				is_cadena = ls_descrip_oc
			end if
		end if
		//Verifica si ha filtrado los productos
		if len(lstr_rangfech_producto.descripciones) > 0 then
			ls_descrip_productos = lstr_rangfech_producto.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_productos
			else
				is_cadena = ls_descrip_productos
			end if
		end if	

		//Verifica si ha filtrado en descripciones
		if len(lstr_rangfech.descripciones) > 0 then
			ls_descrip = lstr_rangfech.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip
			else
				is_cadena = ls_descrip
			end if
		end if
		//Verifica si ha filtrado Materiales
		if len(lstr_rangfech_material.descripciones) > 0 then
			ls_descrip_material = lstr_rangfech_material.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_material
			else
				is_cadena = ls_descrip_material
			end if
		end if

		//Verifica si ha filtrado los margenes
		if len(lstr_rangfech_margen.descripciones) > 0 then
			ls_descrip_margen = lstr_rangfech_margen.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_margen
			else
				is_cadena = ls_descrip_margen
			end if
		end if
		//Verifica si ha filtrado los Accesorios
		if len(lstr_rangfech_accesories.descripciones) > 0 then
			ls_descrip_accesories = lstr_rangfech_accesories.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_accesories
			else
				is_cadena = ls_descrip_accesories
			end if
		end if
		//Verifica si ha filtrado las Definiciones
		if len(lstr_rangfech_definicion.descripciones) > 0 then
			ls_descrip_definicion = lstr_rangfech_definicion.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_definicion
			else
				is_cadena = ls_descrip_definicion
			end if
		end if

		if ll_disponible = 0 then
			if len(is_cadena) > 0 then
				if li_incluir = 1 then
				//	is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
				else
					is_cadena = is_cadena + " and dentero = "+string(ll_disponible)
				end if
			else
				if li_incluir = 1 then
					is_cadena =  "dentero >= "+string(ll_disponible)
				else
					is_cadena =  "dentero = "+string(ll_disponible)
				end if
			end if
		else
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
			else
				is_cadena =  "dentero >= "+string(ll_disponible)
			end if
		end if 
		
		if cbx_cubrio_costo.checked then
			if len(is_cadena) > 0 then
				is_cadena  = is_cadena + ' and total_vendido > total_entrada'
			end if
		end if

		if is_cadena <> '' and not isnull(is_cadena) then
			this.setfilter(is_cadena)
		else
			this.setfilter('')
		end if
		this.filter()
	
	
//DISPONIBLE/////////////////////////////////////////////////////////////////////////////////////////////////////////7
elseif dwo.name = 'b_proveedor' then
		parent.setredraw(false)
		j = 0
		dw_1.setsort('mfr_name')
		dw_1.sort()
		ls_temp = lstr_rangfech_proveedor.descripciones
		if len(ls_temp) = 0 or isnull(ls_temp) then lstr_rangfech_proveedor = lstr_rangfech_nulos
		
		ls_temp = dw_1.getitemstring(1,'mfr_name')
		if isnull(ls_temp) then ls_temp = ''		
		if upperbound(lstr_rangfech_proveedor.descripcion[]) = 0 then 
			for i = 1 to dw_1.rowcount()
				ls_descripcion = dw_1.getitemString(i,'mfr_name')
				if ls_descripcion <> ls_temp then
					j ++
					lstr_rangfech_proveedor.descripcion[j] = ls_temp
					ls_temp = ls_descripcion
				end if
			next
			if j > 0 then
				j ++
				lstr_rangfech_proveedor.descripcion[j] = ls_temp
			end if
		end if
		dw_1.setsort('prod_producto')
		dw_1.sort()
		parent.setredraw(true)
		if j = 0 and upperbound(lstr_rangfech_proveedor.descripcion) = 0 then return
//		openwithparm(w_filtrar_rep_proveedor, lstr_rangfech_proveedor) //,w_frame,2,Original!)
		lstr_rangfech_proveedor = message.powerobjectparm
		if not isvalid(lstr_rangfech_proveedor) then return
		ls_descrip_proveedor = lstr_rangfech_proveedor.descripciones
		
		ll_disponible = dw_3.getitemnumber(1,'disponible')
		li_incluir = dw_3.getitemnumber(1,'incluir')
		is_cadena = ls_descrip_proveedor
		//Verifica si ha filtrado los Bodies
		if len(lstr_rangfech_body.descripciones) > 0 then
			ls_descrip_body = lstr_rangfech_body.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body
			else
				is_cadena = ls_descrip_body
			end if
		end if		
		//Verifica si ha filtrado los ITEMS
		if len(lstr_rangfech_item.descripciones) > 0 then
			ls_descrip_item = lstr_rangfech_item.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_item
			else
				is_cadena = ls_descrip_item
			end if
		end if	
		
		//Verifica si ha filtrado los Bodies 2
		if len(lstr_rangfech_body2.descripciones) > 0 then
			ls_descrip_body2 = lstr_rangfech_body2.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body2
			else
				is_cadena = ls_descrip_body
			end if
		end if		

		//Verifica si ha filtrado las FECHAS
		if len(lstr_rangfech_fecha.descripciones) > 0 then
			ls_descrip_fechas = lstr_rangfech_fecha.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_fechas
			else
				is_cadena = ls_descrip_fechas
			end if
		end if	
		//Verifica si ha filtrado las marcas
		if len(lstr_rangfech_marca.descripciones) > 0 then
			ls_descrip_marca = lstr_rangfech_marca.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_marca
			else
				is_cadena = ls_descrip_marca
			end if
		end if				
		//Verifica si ha filtrado los Codigos de Material
		if len(lstr_rangfech_code_mat.descripciones) > 0 then
			ls_descrip_cod_mat = lstr_rangfech_code_mat.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_cod_mat
			else
				is_cadena = ls_descrip_cod_mat
			end if
		end if	
		//Verifica si ha filtrado los Pattern
		if len(lstr_rangfech_pattern.descripciones) > 0 then
			ls_descrip_pattern = lstr_rangfech_pattern.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_pattern
			else
				is_cadena = ls_descrip_pattern
			end if
		end if
		//Verifica si ha filtrado los Disponibles
		if len(lstr_rangfech_disponible.descripciones) > 0 then
			ls_descrip_disponible = lstr_rangfech_disponible.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_disponible
			else
				is_cadena = ls_descrip_disponible
			end if
		end if
		//Verifica si ha filtrado las Ocs
		if len(lstr_rangfech_oc.descripciones) > 0 then
			ls_descrip_oc = lstr_rangfech_oc.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_oc
			else
				is_cadena = ls_descrip_oc
			end if
		end if
		//Verifica si ha filtrado los productos
		if len(lstr_rangfech_producto.descripciones) > 0 then
			ls_descrip_productos = lstr_rangfech_producto.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_productos
			else
				is_cadena = ls_descrip_productos
			end if
		end if	

		//Verifica si ha filtrado en descripciones
		if len(lstr_rangfech.descripciones) > 0 then
			ls_descrip = lstr_rangfech.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip
			else
				is_cadena = ls_descrip
			end if
		end if
		//Verifica si ha filtrado Materiales
		if len(lstr_rangfech_material.descripciones) > 0 then
			ls_descrip_material = lstr_rangfech_material.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_material
			else
				is_cadena = ls_descrip_material
			end if
		end if

		//Verifica si ha filtrado los margenes
		if len(lstr_rangfech_margen.descripciones) > 0 then
			ls_descrip_margen = lstr_rangfech_margen.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_margen
			else
				is_cadena = ls_descrip_margen
			end if
		end if
		//Verifica si ha filtrado los Accesorios
		if len(lstr_rangfech_accesories.descripciones) > 0 then
			ls_descrip_accesories = lstr_rangfech_accesories.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_accesories
			else
				is_cadena = ls_descrip_accesories
			end if
		end if
		//Verifica si ha filtrado las Definiciones
		if len(lstr_rangfech_definicion.descripciones) > 0 then
			ls_descrip_definicion = lstr_rangfech_definicion.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_definicion
			else
				is_cadena = ls_descrip_definicion
			end if
		end if

		if ll_disponible = 0 then
			if len(is_cadena) > 0 then
				if li_incluir = 1 then
				//	is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
				else
					is_cadena = is_cadena + " and dentero = "+string(ll_disponible)
				end if
			else
				if li_incluir = 1 then
					is_cadena =  "dentero >= "+string(ll_disponible)
				else
					is_cadena =  "dentero = "+string(ll_disponible)
				end if
			end if
		else
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
			else
				is_cadena =  "dentero >= "+string(ll_disponible)
			end if
		end if 
		
		if cbx_cubrio_costo.checked then
			if len(is_cadena) > 0 then
				is_cadena  = is_cadena + ' and total_vendido > total_entrada'
			end if
		end if

		if is_cadena <> '' and not isnull(is_cadena) then
			this.setfilter(is_cadena)
		else
			this.setfilter('')
		end if
		this.filter()
elseif dwo.name = 'b_sexo' then
		parent.setredraw(false)
		j = 0
		dw_1.setsort('crasexo_sex_desc_eng')
		dw_1.sort()
		ls_temp = lstr_rangfech_sexo.descripciones
		if len(ls_temp) = 0 or isnull(ls_temp) then lstr_rangfech_sexo = lstr_rangfech_nulos
		
		ls_temp = dw_1.getitemstring(1,'crasexo_sex_desc_eng')
		if isnull(ls_temp) then ls_temp = ''		
		if upperbound(lstr_rangfech_sexo.descripcion[]) = 0 then 
			for i = 1 to dw_1.rowcount()
				ls_descripcion = dw_1.getitemString(i,'crasexo_sex_desc_eng')
				if ls_descripcion <> ls_temp then
					j ++
					lstr_rangfech_sexo.descripcion[j] = ls_temp
					ls_temp = ls_descripcion
				end if
			next
			if j > 0 then
				j ++
				lstr_rangfech_sexo.descripcion[j] = ls_temp
			end if
		end if
		dw_1.setsort('prod_producto')
		dw_1.sort()
		parent.setredraw(true)
		if j = 0 and upperbound(lstr_rangfech_sexo.descripcion) = 0 then return
		//openwithparm(w_filtrar_rep_sexo, lstr_rangfech_sexo) //,w_frame,2,Original!)
		lstr_rangfech_sexo = message.powerobjectparm
		if not isvalid(lstr_rangfech_sexo) then return
		ls_descrip_sexo = lstr_rangfech_sexo.descripciones
		
		ll_disponible = dw_3.getitemnumber(1,'disponible')
		li_incluir = dw_3.getitemnumber(1,'incluir')
		is_cadena = ls_descrip_sexo
		//Verifica si ha filtrado las FECHAS
		if len(lstr_rangfech_fecha.descripciones) > 0 then
			ls_descrip_fechas = lstr_rangfech_fecha.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_fechas
			else
				is_cadena = ls_descrip_fechas
			end if
		end if
		//Verifica si ha filtrado los Position Print
		//Verifica si ha filtrado los Bodies
		if len(lstr_rangfech_body.descripciones) > 0 then
			ls_descrip_body = lstr_rangfech_body.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body
			else
				is_cadena = ls_descrip_body
			end if
		end if		
		
		//Verifica si ha filtrado los Bodies 2
		if len(lstr_rangfech_body2.descripciones) > 0 then
			ls_descrip_body2 = lstr_rangfech_body2.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body2
			else
				is_cadena = ls_descrip_body
			end if
		end if		

		//Verifica si ha filtrado los Pattern
		if len(lstr_rangfech_pattern.descripciones) > 0 then
			ls_descrip_pattern = lstr_rangfech_pattern.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_pattern
			else
				is_cadena = ls_descrip_pattern
			end if
		end if
		//Verifica si ha filtrado las marcas
		if len(lstr_rangfech_marca.descripciones) > 0 then
			ls_descrip_marca = lstr_rangfech_marca.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_marca
			else
				is_cadena = ls_descrip_marca
			end if
		end if				
		//Verifica si ha filtrado los Codigos de Material
		if len(lstr_rangfech_code_mat.descripciones) > 0 then
			ls_descrip_cod_mat = lstr_rangfech_code_mat.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_cod_mat
			else
				is_cadena = ls_descrip_cod_mat
			end if
		end if
		//Verifica si ha filtrado los Modelos
		//Verifica si ha filtrado los Disponibles
		if len(lstr_rangfech_disponible.descripciones) > 0 then
			ls_descrip_disponible = lstr_rangfech_disponible.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_disponible
			else
				is_cadena = ls_descrip_disponible
			end if
		end if
		//Verifica si ha filtrado las Ocs
		if len(lstr_rangfech_oc.descripciones) > 0 then
			ls_descrip_oc = lstr_rangfech_oc.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_oc
			else
				is_cadena = ls_descrip_oc
			end if
		end if
		//Verifica si ha filtrado los proveedores
		if len(lstr_rangfech_proveedor.descripciones) > 0 then
			ls_descrip_proveedor = lstr_rangfech_proveedor.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_proveedor
			else
				is_cadena = ls_descrip_proveedor
			end if
		end if
		//Verifica si ha filtrado los productos
		if len(lstr_rangfech_producto.descripciones) > 0 then
			ls_descrip_productos = lstr_rangfech_producto.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_productos
			else
				is_cadena = ls_descrip_productos
			end if
		end if	

		//Verifica si ha filtrado en descripciones
		if len(lstr_rangfech.descripciones) > 0 then
			ls_descrip = lstr_rangfech.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip
			else
				is_cadena = ls_descrip
			end if
		end if
		//Verifica si ha filtrado Materiales
		if len(lstr_rangfech_material.descripciones) > 0 then
			ls_descrip_material = lstr_rangfech_material.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_material
			else
				is_cadena = ls_descrip_material
			end if
		end if
		//Verifica si ha filtrado los ITEMS
		if len(lstr_rangfech_item.descripciones) > 0 then
			ls_descrip_item = lstr_rangfech_item.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_item
			else
				is_cadena = ls_descrip_item
			end if
		end if	

		//Verifica si ha filtrado los margenes
		if len(lstr_rangfech_margen.descripciones) > 0 then
			ls_descrip_margen = lstr_rangfech_margen.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_margen
			else
				is_cadena = ls_descrip_margen
			end if
		end if
		//Verifica si ha filtrado los Accesorios
		if len(lstr_rangfech_accesories.descripciones) > 0 then
			ls_descrip_accesories = lstr_rangfech_accesories.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_accesories
			else
				is_cadena = ls_descrip_accesories
			end if
		end if
		//Verifica si ha filtrado las Definiciones
		if len(lstr_rangfech_definicion.descripciones) > 0 then
			ls_descrip_definicion = lstr_rangfech_definicion.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_definicion
			else
				is_cadena = ls_descrip_definicion
			end if
		end if

		if ll_disponible = 0 then
			if len(is_cadena) > 0 then
				if li_incluir = 1 then
				//	is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
				else
					is_cadena = is_cadena + " and dentero = "+string(ll_disponible)
				end if
			else
				if li_incluir = 1 then
					is_cadena =  "dentero >= "+string(ll_disponible)
				else
					is_cadena =  "dentero = "+string(ll_disponible)
				end if
			end if
		else
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
			else
				is_cadena =  "dentero >= "+string(ll_disponible)
			end if
		end if 
		
		if cbx_cubrio_costo.checked then
			if len(is_cadena) > 0 then
				is_cadena  = is_cadena + ' and total_vendido > total_entrada'
			end if
		end if

		if is_cadena <> '' and not isnull(is_cadena) then
			this.setfilter(is_cadena)
		else
			this.setfilter('')
		end if
		this.filter()	
elseif dwo.name = 'b_definicion' then
		parent.setredraw(false)
		j = 0
		dw_1.setsort('cradefineprod_defp_descripcion')
		dw_1.sort()
		ls_temp = lstr_rangfech_definicion.descripciones
		if len(ls_temp) = 0 or isnull(ls_temp) then lstr_rangfech_definicion = lstr_rangfech_nulos
		
		ls_temp = dw_1.getitemstring(1,'cradefineprod_defp_descripcion')
		if isnull(ls_temp) then ls_temp = ''
		if upperbound(lstr_rangfech_definicion.descripcion[]) = 0 then 
			for i = 1 to dw_1.rowcount()
				ls_descripcion = dw_1.getitemString(i,'cradefineprod_defp_descripcion')
				if ls_descripcion <> ls_temp then
					j ++
					lstr_rangfech_definicion.descripcion[j] = ls_temp
					ls_temp = ls_descripcion
				end if
			next
			if j > 0 then
				j ++
				lstr_rangfech_definicion.descripcion[j] = ls_temp
			end if
		end if
		dw_1.setsort('prod_producto')
		dw_1.sort()
		parent.setredraw(true)
		if j = 0 and upperbound(lstr_rangfech_definicion.descripcion) = 0 then return
		//openwithparm(w_filtrar_rep_definicion, lstr_rangfech_definicion) //,w_frame,2,Original!)
		lstr_rangfech_definicion = message.powerobjectparm
		if not isvalid(lstr_rangfech_definicion) then return
		ls_descrip_definicion = lstr_rangfech_definicion.descripciones
		
		ll_disponible = dw_3.getitemnumber(1,'disponible')
		li_incluir = dw_3.getitemnumber(1,'incluir')
		is_cadena = ls_descrip_definicion
		//Verifica si ha filtrado las FECHAS
		if len(lstr_rangfech_fecha.descripciones) > 0 then
			ls_descrip_fechas = lstr_rangfech_fecha.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_fechas
			else
				is_cadena = ls_descrip_fechas
			end if
		end if
		//Verifica si ha filtrado los Position Print
		//Verifica si ha filtrado los Bodies
		if len(lstr_rangfech_body.descripciones) > 0 then
			ls_descrip_body = lstr_rangfech_body.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body
			else
				is_cadena = ls_descrip_body
			end if
		end if		
		
		//Verifica si ha filtrado los Bodies 2
		if len(lstr_rangfech_body2.descripciones) > 0 then
			ls_descrip_body2 = lstr_rangfech_body2.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body2
			else
				is_cadena = ls_descrip_body
			end if
		end if		

		//Verifica si ha filtrado las marcas
		if len(lstr_rangfech_marca.descripciones) > 0 then
			ls_descrip_marca = lstr_rangfech_marca.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_marca
			else
				is_cadena = ls_descrip_marca
			end if
		end if				
		//Verifica si ha filtrado los Codigos de Material
		if len(lstr_rangfech_code_mat.descripciones) > 0 then
			ls_descrip_cod_mat = lstr_rangfech_code_mat.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_cod_mat
			else
				is_cadena = ls_descrip_cod_mat
			end if
		end if
		//Verifica si ha filtrado las Ocs
		if len(lstr_rangfech_oc.descripciones) > 0 then
			ls_descrip_oc = lstr_rangfech_oc.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_oc
			else
				is_cadena = ls_descrip_oc
			end if
		end if
		//Verifica si ha filtrado los Disponibles
		if len(lstr_rangfech_disponible.descripciones) > 0 then
			ls_descrip_disponible = lstr_rangfech_disponible.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_disponible
			else
				is_cadena = ls_descrip_disponible
			end if
		end if
		//Verifica si ha filtrado los Pattern
		if len(lstr_rangfech_pattern.descripciones) > 0 then
			ls_descrip_pattern = lstr_rangfech_pattern.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_pattern
			else
				is_cadena = ls_descrip_pattern
			end if
		end if	
		//Verifica si ha filtrado los Modelos
		//Verifica si ha filtrado los productos
		if len(lstr_rangfech_producto.descripciones) > 0 then
			ls_descrip_productos = lstr_rangfech_producto.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_productos
			else
				is_cadena = ls_descrip_productos
			end if
		end if	
		//Verifica si ha filtrado los proveedores
		if len(lstr_rangfech_proveedor.descripciones) > 0 then
			ls_descrip_proveedor = lstr_rangfech_proveedor.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_proveedor
			else
				is_cadena = ls_descrip_proveedor
			end if
		end if
		//Verifica si ha filtrado los ITEMS
		if len(lstr_rangfech_item.descripciones) > 0 then
			ls_descrip_item = lstr_rangfech_item.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_item
			else
				is_cadena = ls_descrip_item
			end if
		end if	
		//Verifica si ha filtrado en descripciones
		if len(lstr_rangfech.descripciones) > 0 then
			ls_descrip = lstr_rangfech.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip
			else
				is_cadena = ls_descrip
			end if
		end if
		//Verifica si ha filtrado Materiales
		if len(lstr_rangfech_material.descripciones) > 0 then
			ls_descrip_material = lstr_rangfech_material.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_material
			else
				is_cadena = ls_descrip_material
			end if
		end if
		//Verifica si ha filtrado los Sexos
		if len(lstr_rangfech_sexo.descripciones) > 0 then
			ls_descrip_sexo = lstr_rangfech_sexo.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_sexo
			else
				is_cadena = ls_descrip_sexo
			end if
		end if		
		//Verifica si ha filtrado los margenes
		if len(lstr_rangfech_margen.descripciones) > 0 then
			ls_descrip_margen = lstr_rangfech_margen.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_margen
			else
				is_cadena = ls_descrip_margen
			end if
		end if
		//Verifica si ha filtrado los Accesorios
		if len(lstr_rangfech_accesories.descripciones) > 0 then
			ls_descrip_accesories = lstr_rangfech_accesories.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_accesories
			else
				is_cadena = ls_descrip_accesories
			end if
		end if

		if ll_disponible = 0 then
			if len(is_cadena) > 0 then
				if li_incluir = 1 then
				//	is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
				else
					is_cadena = is_cadena + " and dentero = "+string(ll_disponible)
				end if
			else
				if li_incluir = 1 then
					is_cadena =  "dentero >= "+string(ll_disponible)
				else
					is_cadena =  "dentero = "+string(ll_disponible)
				end if
			end if
		else
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
			else
				is_cadena =  "dentero >= "+string(ll_disponible)
			end if
		end if 
		
		if cbx_cubrio_costo.checked then
			if len(is_cadena) > 0 then
				is_cadena  = is_cadena + ' and total_vendido > total_entrada'
			end if
		end if

		if is_cadena <> '' and not isnull(is_cadena) then
			this.setfilter(is_cadena)
		else
			this.setfilter('')
		end if
		this.filter()	

elseif dwo.name = 'b_accesories' then
		parent.setredraw(false)
		j = 0
		dw_1.setsort('prod_accesories')
		dw_1.sort()
		ls_temp = lstr_rangfech_accesories.descripciones
		if len(ls_temp) = 0 or isnull(ls_temp) then lstr_rangfech_accesories = lstr_rangfech_nulos
		
		ls_temp = dw_1.getitemstring(1,'prod_accesories')
		if isnull(ls_temp) then ls_temp = ''
		if upperbound(lstr_rangfech_accesories.descripcion[]) = 0 then 
			for i = 1 to dw_1.rowcount()
				ls_descripcion = dw_1.getitemString(i,'prod_accesories')
				if isnull(ls_descripcion) then ls_descripcion = ''
				if ls_descripcion <> ls_temp then
					j ++
					lstr_rangfech_accesories.descripcion[j] = ls_temp
					ls_temp = ls_descripcion
				end if
			next
			if j > 0 then
				j ++
				lstr_rangfech_accesories.descripcion[j] = ls_temp
			end if
		end if
		dw_1.setsort('prod_producto')
		dw_1.sort()
		parent.setredraw(true)
		if j = 0 and upperbound(lstr_rangfech_accesories.descripcion) = 0 then return
		//openwithparm(w_filtrar_rep_accesories, lstr_rangfech_accesories) //,w_frame,2,Original!)
		lstr_rangfech_accesories = message.powerobjectparm
		if not isvalid(lstr_rangfech_accesories) then return
		ls_descrip_accesories = lstr_rangfech_accesories.descripciones
		ll_disponible = dw_3.getitemnumber(1,'disponible')
		li_incluir = dw_3.getitemnumber(1,'incluir')
		is_cadena = ls_descrip_accesories
		//Verifica si ha filtrado las FECHAS
		if len(lstr_rangfech_fecha.descripciones) > 0 then
			ls_descrip_fechas = lstr_rangfech_fecha.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_fechas
			else
				is_cadena = ls_descrip_fechas
			end if
		end if
		//Verifica si ha filtrado los Position Print
		//Verifica si ha filtrado los Bodies
		if len(lstr_rangfech_body.descripciones) > 0 then
			ls_descrip_body = lstr_rangfech_body.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body
			else
				is_cadena = ls_descrip_body
			end if
		end if		
		
		//Verifica si ha filtrado los Bodies 2
		if len(lstr_rangfech_body2.descripciones) > 0 then
			ls_descrip_body2 = lstr_rangfech_body2.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body2
			else
				is_cadena = ls_descrip_body
			end if
		end if		

		//Verifica si ha filtrado las marcas
		if len(lstr_rangfech_marca.descripciones) > 0 then
			ls_descrip_marca = lstr_rangfech_marca.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_marca
			else
				is_cadena = ls_descrip_marca
			end if
		end if				
		//Verifica si ha filtrado los Sexos
		if len(lstr_rangfech_sexo.descripciones) > 0 then
			ls_descrip_sexo = lstr_rangfech_sexo.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_sexo
			else
				is_cadena = ls_descrip_sexo
			end if
		end if	
		//Verifica si ha filtrado los Codigos de Material
		if len(lstr_rangfech_code_mat.descripciones) > 0 then
			ls_descrip_cod_mat = lstr_rangfech_code_mat.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_cod_mat
			else
				is_cadena = ls_descrip_cod_mat
			end if
		end if	
		//Verifica si ha filtrado los Pattern
		if len(lstr_rangfech_pattern.descripciones) > 0 then
			ls_descrip_pattern = lstr_rangfech_pattern.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_pattern
			else
				is_cadena = ls_descrip_pattern
			end if
		end if
		//Verifica si ha filtrado los Modelos
		if len(lstr_rangfech.descripciones) > 0 then
			ls_descrip = lstr_rangfech.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip
			else
				is_cadena = ls_descrip
			end if
		end if
		//Verifica si ha filtrado los ITEMS
		if len(lstr_rangfech_item.descripciones) > 0 then
			ls_descrip_item = lstr_rangfech_item.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_item
			else
				is_cadena = ls_descrip_item
			end if
		end if	
		//Verifica si ha filtrado los Disponibles
		if len(lstr_rangfech_disponible.descripciones) > 0 then
			ls_descrip_disponible = lstr_rangfech_disponible.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_disponible
			else
				is_cadena = ls_descrip_disponible
			end if
		end if		
		//Verifica si ha filtrado los productos
		if len(lstr_rangfech_producto.descripciones) > 0 then
			ls_descrip_productos = lstr_rangfech_producto.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_productos
			else
				is_cadena = ls_descrip_productos
			end if
		end if	
		//Verifica si ha filtrado los proveedores
		if len(lstr_rangfech_proveedor.descripciones) > 0 then
			ls_descrip_proveedor = lstr_rangfech_proveedor.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_proveedor
			else
				is_cadena = ls_descrip_proveedor
			end if
		end if
		//Verifica si ha filtrado Materiales
		if len(lstr_rangfech_material.descripciones) > 0 then
			ls_descrip_material = lstr_rangfech_material.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_material
			else
				is_cadena = ls_descrip_material
			end if
		end if
	
		//Verifica si ha filtrado los margenes
		if len(lstr_rangfech_margen.descripciones) > 0 then
			ls_descrip_margen = lstr_rangfech_margen.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_margen
			else
				is_cadena = ls_descrip_margen
			end if
		end if
		//Verifica si ha filtrado las Ocs
		if len(lstr_rangfech_oc.descripciones) > 0 then
			ls_descrip_oc = lstr_rangfech_oc.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_oc
			else
				is_cadena = ls_descrip_oc
			end if
		end if
		//Verifica si ha filtrado las Definiciones
		if len(lstr_rangfech_definicion.descripciones) > 0 then
			ls_descrip_definicion = lstr_rangfech_definicion.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_definicion
			else
				is_cadena = ls_descrip_definicion
			end if
		end if

		if ll_disponible = 0 then
			if len(is_cadena) > 0 then
				if li_incluir = 1 then
				//	is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
				else
					is_cadena = is_cadena + " and dentero = "+string(ll_disponible)
				end if
			else
				if li_incluir = 1 then
					is_cadena =  "dentero >= "+string(ll_disponible)
				else
					is_cadena =  "dentero = "+string(ll_disponible)
				end if
			end if
		else
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
			else
				is_cadena =  "dentero >= "+string(ll_disponible)
			end if
		end if 
		
		if cbx_cubrio_costo.checked then
			if len(is_cadena) > 0 then
				is_cadena  = is_cadena + ' and total_vendido > total_entrada'
			end if
		end if

		if is_cadena <> '' and not isnull(is_cadena) then
			this.setfilter(is_cadena)
		else
			this.setfilter('')
		end if
		this.filter()	
elseif dwo.name = 'b_fecha' then
		parent.setredraw(false)
		j = 0
		dw_1.setsort('prod_entrada_fecha')
		dw_1.sort()
		ls_temp = lstr_rangfech_fecha.descripciones
		if len(ls_temp) = 0 or isnull(ls_temp) then lstr_rangfech_fecha = lstr_rangfech_nulos
		
		ls_temp = string(date(dw_1.getitemdatetime(1,'prod_entrada_fecha')))
		if isnull(ls_temp) then ls_temp = ''
		if upperbound(lstr_rangfech_fecha.descripcion[]) = 0 then 
			for i = 1 to dw_1.rowcount()
				ls_descripcion = string(date(dw_1.getitemdatetime(i,'prod_entrada_fecha')))
				if ls_descripcion <> ls_temp then
					j ++
					lstr_rangfech_fecha.descripcion[j] = ls_temp
					ls_temp = ls_descripcion
				end if
			next
			if j > 0 then
				j ++
				lstr_rangfech_fecha.descripcion[j] = ls_temp
			end if
		end if
		dw_1.setsort('prod_producto')
		dw_1.sort()
		parent.setredraw(true)
		if j = 0 and upperbound(lstr_rangfech_fecha.descripcion) = 0 then return
		//openwithparm(w_filtrar_rep_fechas, lstr_rangfech_fecha) //,w_frame,2,Original!)
		lstr_rangfech_fecha = message.powerobjectparm
		if not isvalid(lstr_rangfech_fecha) then return
		ls_descrip_fechas = lstr_rangfech_fecha.descripciones
		
		ll_disponible = dw_3.getitemnumber(1,'disponible')
		li_incluir = dw_3.getitemnumber(1,'incluir')
		is_cadena = ls_descrip_fechas
		
		//Verifica si ha filtrado las Ocs
		if len(lstr_rangfech_oc.descripciones) > 0 then
			ls_descrip_oc = lstr_rangfech_oc.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_oc
			else
				is_cadena = ls_descrip_oc
			end if
		end if

		//Verifica si ha filtrado las marcas
		if len(lstr_rangfech_marca.descripciones) > 0 then
			ls_descrip_marca = lstr_rangfech_marca.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_marca
			else
				is_cadena = ls_descrip_marca
			end if
		end if				
		//Verifica si ha filtrado los Codigos de Material
		if len(lstr_rangfech_code_mat.descripciones) > 0 then
			ls_descrip_cod_mat = lstr_rangfech_code_mat.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_cod_mat
			else
				is_cadena = ls_descrip_cod_mat
			end if
		end if
		//Verifica si ha filtrado los Bodies
		if len(lstr_rangfech_body.descripciones) > 0 then
			ls_descrip_body = lstr_rangfech_body.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body
			else
				is_cadena = ls_descrip_body
			end if
		end if		
		
		//Verifica si ha filtrado los Bodies 2
		if len(lstr_rangfech_body2.descripciones) > 0 then
			ls_descrip_body2 = lstr_rangfech_body2.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body2
			else
				is_cadena = ls_descrip_body
			end if
		end if		

		//Verifica si ha filtrado los Sexos
		if len(lstr_rangfech_sexo.descripciones) > 0 then
			ls_descrip_sexo = lstr_rangfech_sexo.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_sexo
			else
				is_cadena = ls_descrip_sexo
			end if
		end if
		//Verifica si ha filtrado los Pattern
		if len(lstr_rangfech_pattern.descripciones) > 0 then
			ls_descrip_pattern = lstr_rangfech_pattern.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_pattern
			else
				is_cadena = ls_descrip_pattern
			end if
		end if
		//Verifica si ha filtrado los Disponibles
		if len(lstr_rangfech_disponible.descripciones) > 0 then
			ls_descrip_disponible = lstr_rangfech_disponible.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_disponible
			else
				is_cadena = ls_descrip_disponible
			end if
		end if		
		//Verifica si ha filtrado los ITEMS
		if len(lstr_rangfech_item.descripciones) > 0 then
			ls_descrip_item = lstr_rangfech_item.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_item
			else
				is_cadena = ls_descrip_item
			end if
		end if	
		//Verifica si ha filtrado los proveedores
		if len(lstr_rangfech_proveedor.descripciones) > 0 then
			ls_descrip_proveedor = lstr_rangfech_proveedor.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_proveedor
			else
				is_cadena = ls_descrip_proveedor
			end if
		end if
		//Verifica si ha filtrado los productos
		if len(lstr_rangfech_producto.descripciones) > 0 then
			ls_descrip_productos = lstr_rangfech_producto.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_productos
			else
				is_cadena = ls_descrip_productos
			end if
		end if	

		//Verifica si ha filtrado en descripciones
		if len(lstr_rangfech.descripciones) > 0 then
			ls_descrip = lstr_rangfech.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip
			else
				is_cadena = ls_descrip
			end if
		end if
		//Verifica si ha filtrado Materiales
		if len(lstr_rangfech_material.descripciones) > 0 then
			ls_descrip_material = lstr_rangfech_material.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_material
			else
				is_cadena = ls_descrip_material
			end if
		end if
		//Verifica si ha filtrado los ITEMS
		if len(lstr_rangfech_item.descripciones) > 0 then
			ls_descrip_item = lstr_rangfech_item.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_item
			else
				is_cadena = ls_descrip_item
			end if
		end if	

		//Verifica si ha filtrado los margenes
		if len(lstr_rangfech_margen.descripciones) > 0 then
			ls_descrip_margen = lstr_rangfech_margen.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_margen
			else
				is_cadena = ls_descrip_margen
			end if
		end if
		//Verifica si ha filtrado los Accesorios
		if len(lstr_rangfech_accesories.descripciones) > 0 then
			ls_descrip_accesories = lstr_rangfech_accesories.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_accesories
			else
				is_cadena = ls_descrip_accesories
			end if
		end if
		//Verifica si ha filtrado las Definiciones
		if len(lstr_rangfech_definicion.descripciones) > 0 then
			ls_descrip_definicion = lstr_rangfech_definicion.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_definicion
			else
				is_cadena = ls_descrip_definicion
			end if
		end if

		if ll_disponible = 0 then
			if len(is_cadena) > 0 then
				if li_incluir = 1 then
					// is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
				else
					is_cadena = is_cadena + " and dentero = "+string(ll_disponible)
				end if
			else
				if li_incluir = 1 then
					is_cadena =  "dentero >= "+string(ll_disponible)
				else
					is_cadena =  "dentero = "+string(ll_disponible)
				end if
			end if
		else
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
			else
				is_cadena =  "dentero >= "+string(ll_disponible)
			end if
		end if 
		
		if cbx_cubrio_costo.checked then
			if len(is_cadena) > 0 then
				is_cadena  = is_cadena + ' and total_vendido > total_entrada'
			end if
		end if

		if is_cadena <> '' and not isnull(is_cadena) then
			this.setfilter(is_cadena)
		else
			this.setfilter('')
		end if
		this.filter()	
elseif dwo.name = 'b_item' then
		parent.setredraw(false)
		j = 0
		dw_1.setsort('prod_producto_dos')
		dw_1.sort()
		ls_temp = lstr_rangfech_item.descripciones
		if len(ls_temp) = 0 or isnull(ls_temp) then lstr_rangfech_item = lstr_rangfech_nulos

		ls_temp = dw_1.getitemstring(1,'prod_producto_dos')
		if isnull(ls_temp) then ls_temp = ''
		if upperbound(lstr_rangfech_item.descripcion[]) = 0 then 
			for i = 1 to dw_1.rowcount()
				ls_descripcion = dw_1.getitemString(i,'prod_producto_dos')
				if ls_descripcion <> ls_temp then
					j ++
					lstr_rangfech_item.descripcion[j] = ls_temp
					ls_temp = ls_descripcion
				end if
			next
			if j > 0 then
				j ++
				lstr_rangfech_item.descripcion[j] = ls_temp
			end if
		end if
		dw_1.setsort('prod_producto')
		dw_1.sort()
		parent.setredraw(true)
		if j = 0 and upperbound(lstr_rangfech_item.descripcion) = 0 then return
		//openwithparm(w_filtrar_rep_items, lstr_rangfech_item) //,w_frame,2,Original!)
		lstr_rangfech_item = message.powerobjectparm
		if not isvalid(lstr_rangfech_item) then return
		ls_descrip_item = lstr_rangfech_item.descripciones
		
		ll_disponible = dw_3.getitemnumber(1,'disponible')
		li_incluir = dw_3.getitemnumber(1,'incluir')
		is_cadena = ls_descrip_item
		//Verifica si ha filtrado las FECHAS
		if len(lstr_rangfech_fecha.descripciones) > 0 then
			ls_descrip_fechas = lstr_rangfech_fecha.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_fechas
			else
				is_cadena = ls_descrip_fechas
			end if
		end if

		//Verifica si ha filtrado las marcas
		if len(lstr_rangfech_marca.descripciones) > 0 then
			ls_descrip_marca = lstr_rangfech_marca.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_marca
			else
				is_cadena = ls_descrip_marca
			end if
		end if				
		//Verifica si ha filtrado los Codigos de Material
		if len(lstr_rangfech_code_mat.descripciones) > 0 then
			ls_descrip_cod_mat = lstr_rangfech_code_mat.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_cod_mat
			else
				is_cadena = ls_descrip_cod_mat
			end if
		end if	
				//Verifica si ha filtrado los Bodies
		if len(lstr_rangfech_body.descripciones) > 0 then
			ls_descrip_body = lstr_rangfech_body.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body
			else
				is_cadena = ls_descrip_body
			end if
		end if		
		
		//Verifica si ha filtrado los Bodies 2
		if len(lstr_rangfech_body2.descripciones) > 0 then
			ls_descrip_body2 = lstr_rangfech_body2.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body2
			else
				is_cadena = ls_descrip_body
			end if
		end if		

		//Verifica si ha filtrado los Sexos
		if len(lstr_rangfech_sexo.descripciones) > 0 then
			ls_descrip_sexo = lstr_rangfech_sexo.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_sexo
			else
				is_cadena = ls_descrip_sexo
			end if
		end if		
		//Verifica si ha filtrado los Pattern
		if len(lstr_rangfech_pattern.descripciones) > 0 then
			ls_descrip_pattern = lstr_rangfech_pattern.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_pattern
			else
				is_cadena = ls_descrip_pattern
			end if
		end if
		//Verifica si ha filtrado las Ocs
		if len(lstr_rangfech_oc.descripciones) > 0 then
			ls_descrip_oc = lstr_rangfech_oc.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_oc
			else
				is_cadena = ls_descrip_oc
			end if
		end if
		//Verifica si ha filtrado los Disponibles
		if len(lstr_rangfech_disponible.descripciones) > 0 then
			ls_descrip_disponible = lstr_rangfech_disponible.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_disponible
			else
				is_cadena = ls_descrip_disponible
			end if
		end if
		//Verifica si ha filtrado los productos
		if len(lstr_rangfech_producto.descripciones) > 0 then
			ls_descrip_productos = lstr_rangfech_producto.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_productos
			else
				is_cadena = ls_descrip_productos
			end if
		end if	
		//Verifica si ha filtrado los proveedores
		if len(lstr_rangfech_proveedor.descripciones) > 0 then
			ls_descrip_proveedor = lstr_rangfech_proveedor.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_proveedor
			else
				is_cadena = ls_descrip_proveedor
			end if
		end if

		//Verifica si ha filtrado en descripciones
		if len(lstr_rangfech.descripciones) > 0 then
			ls_descrip = lstr_rangfech.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip
			else
				is_cadena = ls_descrip
			end if
		end if
		//Verifica si ha filtrado Materiales
		if len(lstr_rangfech_material.descripciones) > 0 then
			ls_descrip_material = lstr_rangfech_material.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_material
			else
				is_cadena = ls_descrip_material
			end if
		end if

		//Verifica si ha filtrado los margenes
		if len(lstr_rangfech_margen.descripciones) > 0 then
			ls_descrip_margen = lstr_rangfech_margen.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_margen
			else
				is_cadena = ls_descrip_margen
			end if
		end if
		//Verifica si ha filtrado los Accesorios
		if len(lstr_rangfech_accesories.descripciones) > 0 then
			ls_descrip_accesories = lstr_rangfech_accesories.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_accesories
			else
				is_cadena = ls_descrip_accesories
			end if
		end if
		//Verifica si ha filtrado las Definiciones
		if len(lstr_rangfech_definicion.descripciones) > 0 then
			ls_descrip_definicion = lstr_rangfech_definicion.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_definicion
			else
				is_cadena = ls_descrip_definicion
			end if
		end if

		if ll_disponible = 0 then
			if len(is_cadena) > 0 then
				if li_incluir = 1 then
				//	is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
				else
					is_cadena = is_cadena + " and dentero = "+string(ll_disponible)
				end if
			else
				if li_incluir = 1 then
					is_cadena =  "dentero >= "+string(ll_disponible)
				else
					is_cadena =  "dentero = "+string(ll_disponible)
				end if
			end if
		else
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
			else
				is_cadena =  "dentero >= "+string(ll_disponible)
			end if
		end if 
		
		if cbx_cubrio_costo.checked then
			if len(is_cadena) > 0 then
				is_cadena  = is_cadena + ' and total_vendido > total_entrada'
			end if
		end if

		if is_cadena <> '' and not isnull(is_cadena) then
			this.setfilter(is_cadena)
		else
			this.setfilter('')
		end if
		this.filter()	
elseif dwo.name = 'b_prod' then
		parent.setredraw(false)
		j = 0
		dw_1.setsort('prod_producto')
		dw_1.sort()
		ls_temp = lstr_rangfech_producto.descripciones
		if len(ls_temp) = 0 or isnull(ls_temp) then lstr_rangfech_producto = lstr_rangfech_nulos
		
		ls_temp = dw_1.getitemstring(1,'prod_producto')
		if isnull(ls_temp) then ls_temp = ''
		if upperbound(lstr_rangfech_producto.descripcion[]) = 0 then 
			for i = 1 to dw_1.rowcount()
				ls_descripcion = dw_1.getitemString(i,'prod_producto')
				if ls_descripcion <> ls_temp then
					j ++
					lstr_rangfech_producto.descripcion[j] = ls_temp
					ls_temp = ls_descripcion
				end if
			next
			if j > 0 then
				j ++
				lstr_rangfech_producto.descripcion[j] = ls_temp
			end if
		end if
		dw_1.setsort('prod_producto')
		dw_1.sort()
		parent.setredraw(true)
		if j = 0 and upperbound(lstr_rangfech_producto.descripcion) = 0 then return
		openwithparm(w_filtrar_rep_referencias, lstr_rangfech_producto) //,w_frame,2,Original!)
		lstr_rangfech_producto = message.powerobjectparm
		if not isvalid(lstr_rangfech_producto) then return
		ls_descrip_oc = lstr_rangfech_producto.descripciones
		ll_disponible = dw_3.getitemnumber(1,'disponible')
		li_incluir = dw_3.getitemnumber(1,'incluir')
		is_cadena = ls_descrip_oc

		//Verifica si ha filtrado las FECHAS
		if len(lstr_rangfech_fecha.descripciones) > 0 then
			ls_descrip_fechas = lstr_rangfech_fecha.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_fechas
			else
				is_cadena = ls_descrip_fechas
			end if
		end if	
		//Verifica si ha filtrado las marcas
		if len(lstr_rangfech_marca.descripciones) > 0 then
			ls_descrip_marca = lstr_rangfech_marca.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_marca
			else
				is_cadena = ls_descrip_marca
			end if
		end if				
		//Verifica si ha filtrado los Disponibles
		if len(lstr_rangfech_disponible.descripciones) > 0 then
			ls_descrip_disponible = lstr_rangfech_disponible.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_disponible
			else
				is_cadena = ls_descrip_disponible
			end if
		end if
		//Verifica si ha filtrado los Pattern
		if len(lstr_rangfech_pattern.descripciones) > 0 then
			ls_descrip_pattern = lstr_rangfech_pattern.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_pattern
			else
				is_cadena = ls_descrip_pattern
			end if
		end if
		//Verifica si ha filtrado las Ocs
		if len(lstr_rangfech_oc.descripciones) > 0 then
			ls_descrip_oc = lstr_rangfech_oc.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_oc
			else
				is_cadena = ls_descrip_oc
			end if
		end if
		//Verifica si ha filtrado los ITEMS
		if len(lstr_rangfech_item.descripciones) > 0 then
			ls_descrip_item = lstr_rangfech_item.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_item
			else
				is_cadena = ls_descrip_item
			end if
		end if		
		//Verifica si ha filtrado los proveedores
		if len(lstr_rangfech_proveedor.descripciones) > 0 then
			ls_descrip_proveedor = lstr_rangfech_proveedor.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_proveedor
			else
				is_cadena = ls_descrip_proveedor
			end if
		end if
	
		//Verifica si ha filtrado en descripciones
		if len(lstr_rangfech.descripciones) > 0 then
			ls_descrip = lstr_rangfech.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip
			else
				is_cadena = ls_descrip
			end if
		end if
		//Verifica si ha filtrado Materiales
		if len(lstr_rangfech_material.descripciones) > 0 then
			ls_descrip_material = lstr_rangfech_material.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_material
			else
				is_cadena = ls_descrip_material
			end if
		end if

		//Verifica si ha filtrado los margenes
		if len(lstr_rangfech_margen.descripciones) > 0 then
			ls_descrip_margen = lstr_rangfech_margen.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_margen
			else
				is_cadena = ls_descrip_margen
			end if
		end if
		//Verifica si ha filtrado los Accesorios
		if len(lstr_rangfech_accesories.descripciones) > 0 then
			ls_descrip_accesories = lstr_rangfech_accesories.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_accesories
			else
				is_cadena = ls_descrip_accesories
			end if
		end if
		//Verifica si ha filtrado las Definiciones
		if len(lstr_rangfech_definicion.descripciones) > 0 then
			ls_descrip_definicion = lstr_rangfech_definicion.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_definicion
			else
				is_cadena = ls_descrip_definicion
			end if
		end if

		if ll_disponible = 0 then
			if len(is_cadena) > 0 then
				if li_incluir = 1 then
				//	is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
				else
					is_cadena = is_cadena + " and dentero = "+string(ll_disponible)
				end if
			else
				if li_incluir = 1 then
					is_cadena =  "dentero >= "+string(ll_disponible)
				else
					is_cadena =  "dentero = "+string(ll_disponible)
				end if
			end if
		else
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
			else
				is_cadena =  "dentero >= "+string(ll_disponible)
			end if
		end if 
		
		if cbx_cubrio_costo.checked then
			if len(is_cadena) > 0 then
				is_cadena  = is_cadena + ' and total_vendido > total_entrada'
			end if
		end if

		if is_cadena <> '' and not isnull(is_cadena) then
			this.setfilter(is_cadena)
		else
			this.setfilter('')
		end if
		this.filter()	
elseif dwo.name = 'b_oc' then
		parent.setredraw(false)
		j = 0
		dw_1.setsort('prod_orden_compra')
		dw_1.sort()
		ls_temp = lstr_rangfech_oc.descripciones
		if len(ls_temp) = 0 or isnull(ls_temp) then lstr_rangfech_oc = lstr_rangfech_nulos
		
		ls_temp = dw_1.getitemstring(1,'prod_orden_compra')
		if isnull(ls_temp) then ls_temp = ''
		if upperbound(lstr_rangfech_oc.descripcion[]) = 0 then 
			for i = 1 to dw_1.rowcount()
				ls_descripcion = dw_1.getitemString(i,'prod_orden_compra')
				if ls_descripcion <> ls_temp then
					j ++
					lstr_rangfech_oc.descripcion[j] = ls_temp
					ls_temp = ls_descripcion
				end if
			next
			if j > 0 then
				j ++
				lstr_rangfech_oc.descripcion[j] = ls_temp
			end if
		end if
		dw_1.setsort('prod_producto')
		dw_1.sort()
		parent.setredraw(true)
		if j = 0 and upperbound(lstr_rangfech_oc.descripcion) = 0 then return
		//openwithparm(w_filtrar_rep_ocs, lstr_rangfech_oc) //,w_frame,2,Original!)
		lstr_rangfech_oc = message.powerobjectparm
		if not isvalid(lstr_rangfech_oc) then return
		ls_descrip_oc = lstr_rangfech_oc.descripciones
		ll_disponible = dw_3.getitemnumber(1,'disponible')
		li_incluir = dw_3.getitemnumber(1,'incluir')
		is_cadena = ls_descrip_oc
		//Verifica si ha filtrado los Position Print

		//Verifica si ha filtrado las FECHAS
		if len(lstr_rangfech_fecha.descripciones) > 0 then
			ls_descrip_fechas = lstr_rangfech_fecha.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_fechas
			else
				is_cadena = ls_descrip_fechas
			end if
		end if		
		//Verifica si ha filtrado los Sexos
		if len(lstr_rangfech_sexo.descripciones) > 0 then
			ls_descrip_sexo = lstr_rangfech_sexo.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_sexo
			else
				is_cadena = ls_descrip_sexo
			end if
		end if		
				//Verifica si ha filtrado los Bodies
		if len(lstr_rangfech_body.descripciones) > 0 then
			ls_descrip_body = lstr_rangfech_body.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body
			else
				is_cadena = ls_descrip_body
			end if
		end if		
		
		//Verifica si ha filtrado los Bodies 2
		if len(lstr_rangfech_body2.descripciones) > 0 then
			ls_descrip_body2 = lstr_rangfech_body2.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body2
			else
				is_cadena = ls_descrip_body
			end if
		end if		

		//Verifica si ha filtrado las marcas
		if len(lstr_rangfech_marca.descripciones) > 0 then
			ls_descrip_marca = lstr_rangfech_marca.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_marca
			else
				is_cadena = ls_descrip_marca
			end if
		end if				
		//Verifica si ha filtrado los Codigos de Material
		if len(lstr_rangfech_code_mat.descripciones) > 0 then
			ls_descrip_cod_mat = lstr_rangfech_code_mat.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_cod_mat
			else
				is_cadena = ls_descrip_cod_mat
			end if
		end if	
		//Verifica si ha filtrado los Pattern
		if len(lstr_rangfech_pattern.descripciones) > 0 then
			ls_descrip_pattern = lstr_rangfech_pattern.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_pattern
			else
				is_cadena = ls_descrip_pattern
			end if
		end if
		//Verifica si ha filtrado los productos
		if len(lstr_rangfech_producto.descripciones) > 0 then
			ls_descrip_productos = lstr_rangfech_producto.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_productos
			else
				is_cadena = ls_descrip_productos
			end if
		end if	
		//Verifica si ha filtrado los Disponibles
		if len(lstr_rangfech_disponible.descripciones) > 0 then
			ls_descrip_disponible = lstr_rangfech_disponible.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_disponible
			else
				is_cadena = ls_descrip_disponible
			end if
		end if		
		//Verifica si ha filtrado los ITEMS
		if len(lstr_rangfech_item.descripciones) > 0 then
			ls_descrip_item = lstr_rangfech_item.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_item
			else
				is_cadena = ls_descrip_item
			end if
		end if	
		//Verifica si ha filtrado los proveedores
		if len(lstr_rangfech_proveedor.descripciones) > 0 then
			ls_descrip_proveedor = lstr_rangfech_proveedor.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_proveedor
			else
				is_cadena = ls_descrip_proveedor
			end if
		end if
		//Verifica si ha filtrado en descripciones
		if len(lstr_rangfech.descripciones) > 0 then
			ls_descrip = lstr_rangfech.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip
			else
				is_cadena = ls_descrip
			end if
		end if
		//Verifica si ha filtrado Materiales
		if len(lstr_rangfech_material.descripciones) > 0 then
			ls_descrip_material = lstr_rangfech_material.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_material
			else
				is_cadena = ls_descrip_material
			end if
		end if

		//Verifica si ha filtrado los margenes
		if len(lstr_rangfech_margen.descripciones) > 0 then
			ls_descrip_margen = lstr_rangfech_margen.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_margen
			else
				is_cadena = ls_descrip_margen
			end if
		end if
		//Verifica si ha filtrado los Accesorios
		if len(lstr_rangfech_accesories.descripciones) > 0 then
			ls_descrip_accesories = lstr_rangfech_accesories.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_accesories
			else
				is_cadena = ls_descrip_accesories
			end if
		end if
		//Verifica si ha filtrado las Definiciones
		if len(lstr_rangfech_definicion.descripciones) > 0 then
			ls_descrip_definicion = lstr_rangfech_definicion.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_definicion
			else
				is_cadena = ls_descrip_definicion
			end if
		end if

		if ll_disponible = 0 then
			if len(is_cadena) > 0 then
				if li_incluir = 1 then
				//	is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
				else
					is_cadena = is_cadena + " and dentero = "+string(ll_disponible)
				end if
			else
				if li_incluir = 1 then
					is_cadena =  "dentero >= "+string(ll_disponible)
				else
					is_cadena =  "dentero = "+string(ll_disponible)
				end if
			end if
		else
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
			else
				is_cadena =  "dentero >= "+string(ll_disponible)
			end if
		end if 
		
		if cbx_cubrio_costo.checked then
			if len(is_cadena) > 0 then
				is_cadena  = is_cadena + ' and total_vendido > total_entrada'
			end if
		end if

		if is_cadena <> '' and not isnull(is_cadena) then
			this.setfilter(is_cadena)
		else
			this.setfilter('')
		end if
		this.filter()	
elseif dwo.name = 'b_material' then
		parent.setredraw(false)
		j = 0
		dw_1.setsort('mat_descripcion')
		dw_1.sort()
		ls_temp = lstr_rangfech_material.descripciones
		if len(ls_temp) = 0 or isnull(ls_temp) then lstr_rangfech_material = lstr_rangfech_nulos
		
		ls_temp = dw_1.getitemstring(1,'mat_descripcion')
		if isnull(ls_temp) then ls_temp = ''
		if upperbound(lstr_rangfech_material.descripcion[]) = 0 then 
			for i = 1 to dw_1.rowcount()
				ls_descripcion = dw_1.getitemString(i,'mat_descripcion')
				if ls_descripcion <> ls_temp then
					j ++
					lstr_rangfech_material.descripcion[j] = ls_temp
					ls_temp = ls_descripcion
				end if
			next
			if j > 0 then
				j ++
				lstr_rangfech_material.descripcion[j] = ls_temp
			end if
		end if
		dw_1.setsort('prod_producto')
		dw_1.sort()
		parent.setredraw(true)
		if j = 0 and upperbound(lstr_rangfech_material.descripcion) = 0 then return
		//openwithparm(w_filtrar_rep_material, lstr_rangfech_material) //,w_frame,2,Original!)
		lstr_rangfech_material = message.powerobjectparm
		if not isvalid(lstr_rangfech_material) then return
		ls_descrip_material = lstr_rangfech_material.descripciones
		ll_disponible = dw_3.getitemnumber(1,'disponible')
		li_incluir = dw_3.getitemnumber(1,'incluir')
		is_cadena = ls_descrip_material

		//Verifica si ha filtrado las FECHAS
		if len(lstr_rangfech_fecha.descripciones) > 0 then
			ls_descrip_fechas = lstr_rangfech_fecha.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_fechas
			else
				is_cadena = ls_descrip_fechas
			end if
		end if		
				//Verifica si ha filtrado los Bodies
		if len(lstr_rangfech_body.descripciones) > 0 then
			ls_descrip_body = lstr_rangfech_body.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body
			else
				is_cadena = ls_descrip_body
			end if
		end if		
		
		//Verifica si ha filtrado los Bodies 2
		if len(lstr_rangfech_body2.descripciones) > 0 then
			ls_descrip_body2 = lstr_rangfech_body2.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body2
			else
				is_cadena = ls_descrip_body
			end if
		end if		

		//Verifica si ha filtrado las marcas
		if len(lstr_rangfech_marca.descripciones) > 0 then
			ls_descrip_marca = lstr_rangfech_marca.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_marca
			else
				is_cadena = ls_descrip_marca
			end if
		end if				
		//Verifica si ha filtrado los Sexos
		if len(lstr_rangfech_sexo.descripciones) > 0 then
			ls_descrip_sexo = lstr_rangfech_sexo.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_sexo
			else
				is_cadena = ls_descrip_sexo
			end if
		end if		
		//Verifica si ha filtrado los Pattern
		if len(lstr_rangfech_pattern.descripciones) > 0 then
			ls_descrip_pattern = lstr_rangfech_pattern.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_pattern
			else
				is_cadena = ls_descrip_pattern
			end if
		end if
		//Verifica si ha filtrado los Codigos de Material
		if len(lstr_rangfech_code_mat.descripciones) > 0 then
			ls_descrip_cod_mat = lstr_rangfech_code_mat.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_cod_mat
			else
				is_cadena = ls_descrip_cod_mat
			end if
		end if		
		//Verifica si ha filtrado los Disponibles
		if len(lstr_rangfech_disponible.descripciones) > 0 then
			ls_descrip_disponible = lstr_rangfech_disponible.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_disponible
			else
				is_cadena = ls_descrip_disponible
			end if
		end if		
		//Verifica si ha filtrado los productos
		if len(lstr_rangfech_producto.descripciones) > 0 then
			ls_descrip_productos = lstr_rangfech_producto.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_productos
			else
				is_cadena = ls_descrip_productos
			end if
		end if	
		//Verifica si ha filtrado los ITEMS
		if len(lstr_rangfech_item.descripciones) > 0 then
			ls_descrip_item = lstr_rangfech_item.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_item
			else
				is_cadena = ls_descrip_item
			end if
		end if	
		//Verifica si ha filtrado en descripciones
		if len(lstr_rangfech.descripciones) > 0 then
			ls_descrip = lstr_rangfech.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip
			else
				is_cadena = ls_descrip
			end if
		end if
		//Verifica si ha filtrado las Ocs
		if len(lstr_rangfech_margen.descripciones) > 0 then
			ls_descrip_margen = lstr_rangfech_margen.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_margen
			else
				is_cadena = ls_descrip_margen
			end if
		end if
		//Verifica si ha filtrado las Ocs
		if len(lstr_rangfech_oc.descripciones) > 0 then
			ls_descrip_oc = lstr_rangfech_oc.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_oc
			else
				is_cadena = ls_descrip_oc
			end if
		end if
		//Verifica si ha filtrado los proveedores
		if len(lstr_rangfech_proveedor.descripciones) > 0 then
			ls_descrip_proveedor = lstr_rangfech_proveedor.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_proveedor
			else
				is_cadena = ls_descrip_proveedor
			end if
		end if
		//Verifica si ha filtrado los Accesorios
		if len(lstr_rangfech_accesories.descripciones) > 0 then
			ls_descrip_accesories = lstr_rangfech_accesories.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_accesories
			else
				is_cadena = ls_descrip_accesories
			end if
		end if
		//Verifica si ha filtrado las Definiciones
		if len(lstr_rangfech_definicion.descripciones) > 0 then
			ls_descrip_definicion = lstr_rangfech_definicion.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_definicion
			else
				is_cadena = ls_descrip_definicion
			end if
		end if

		if ll_disponible = 0 then
			if len(is_cadena) > 0 then
				if li_incluir = 1 then
				//	is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
				else
					is_cadena = is_cadena + " and dentero = "+string(ll_disponible)
				end if
			else
				if li_incluir = 1 then
					is_cadena =  "dentero >= "+string(ll_disponible)
				else
					is_cadena =  "dentero = "+string(ll_disponible)
				end if
			end if
		else
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
			else
				is_cadena =  "dentero >= "+string(ll_disponible)
			end if
		end if 
		
		if cbx_cubrio_costo.checked then
			if len(is_cadena) > 0 then
				is_cadena  = is_cadena + ' and total_vendido > total_entrada'
			end if
		end if

		if is_cadena <> '' and not isnull(is_cadena) then
			this.setfilter(is_cadena)
		else
			this.setfilter('')
		end if
		this.filter()	
elseif dwo.name = 'b_margen' then
		parent.setredraw(false)
		j = 0
		dw_1.setsort('prod_margen_promedio')
		dw_1.sort()
		ls_temp = lstr_rangfech_margen.descripciones
		if len(ls_temp) = 0 or isnull(ls_temp) then lstr_rangfech_margen = lstr_rangfech_nulos
		ls_temp = string(dw_1.getitemnumber(1,'prod_margen_promedio'))
		if isnull(ls_temp) then ls_temp = ''
		if upperbound(lstr_rangfech_margen.descripcion[]) = 0 then 
			for i = 1 to dw_1.rowcount()
				ls_descripcion = string(dw_1.getitemnumber(i,'prod_margen_promedio'))
				if ls_descripcion <> ls_temp then
					j ++
					lstr_rangfech_margen.descripcion[j] = ls_temp
					ls_temp = ls_descripcion
				end if
			next
			if j > 0 then
				j ++
				lstr_rangfech_margen.descripcion[j] = ls_temp
			end if
		end if
		dw_1.setsort('prod_producto')
		dw_1.sort()
		parent.setredraw(true)
		if j = 0 and upperbound(lstr_rangfech_margen.descripcion) = 0 then return
		//openwithparm(w_filtrar_rep_exist_margen, lstr_rangfech_margen) //,w_frame,2,Original!)
		lstr_rangfech_margen = message.powerobjectparm
		if not isvalid(lstr_rangfech_margen) then return
		ls_descrip_margen = lstr_rangfech_margen.descripciones
		ll_disponible = dw_3.getitemnumber(1,'disponible')
		li_incluir = dw_3.getitemnumber(1,'incluir')
		is_cadena = ls_descrip_margen
		//Verifica si ha filtrado las FECHAS
		if len(lstr_rangfech_fecha.descripciones) > 0 then
			ls_descrip_fechas = lstr_rangfech_fecha.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_fechas
			else
				is_cadena = ls_descrip_fechas
			end if
		end if		
		//Verifica si ha filtrado los Bodies
		if len(lstr_rangfech_body.descripciones) > 0 then
			ls_descrip_body = lstr_rangfech_body.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body
			else
				is_cadena = ls_descrip_body
			end if
		end if		
		
		//Verifica si ha filtrado los Bodies 2
		if len(lstr_rangfech_body2.descripciones) > 0 then
			ls_descrip_body2 = lstr_rangfech_body2.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body2
			else
				is_cadena = ls_descrip_body
			end if
		end if		

		//Verifica si ha filtrado en descripciones
		if len(lstr_rangfech.descripciones) > 0 then
			ls_descrip = lstr_rangfech.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip
			else
				is_cadena = ls_descrip
			end if
		end if
		//Verifica si ha filtrado los Codigos de Material
		if len(lstr_rangfech_code_mat.descripciones) > 0 then
			ls_descrip_cod_mat = lstr_rangfech_code_mat.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_cod_mat
			else
				is_cadena = ls_descrip_cod_mat
			end if
		end if		
		//Verifica si ha filtrado los Sexos
		if len(lstr_rangfech_sexo.descripciones) > 0 then
			ls_descrip_sexo = lstr_rangfech_sexo.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_sexo
			else
				is_cadena = ls_descrip_sexo
			end if
		end if						
		//Verifica si ha filtrado los Pattern
		if len(lstr_rangfech_pattern.descripciones) > 0 then
			ls_descrip_pattern = lstr_rangfech_pattern.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_pattern
			else
				is_cadena = ls_descrip_pattern
			end if
		end if
		//Verifica si ha filtrado los productos
		if len(lstr_rangfech_producto.descripciones) > 0 then
			ls_descrip_productos = lstr_rangfech_producto.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_productos
			else
				is_cadena = ls_descrip_productos
			end if
		end if	
				//Verifica si ha filtrado los Disponibles
		if len(lstr_rangfech_disponible.descripciones) > 0 then
			ls_descrip_disponible = lstr_rangfech_disponible.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_disponible
			else
				is_cadena = ls_descrip_disponible
			end if
		end if
		//Verifica si ha filtrado las marcas
		if len(lstr_rangfech_marca.descripciones) > 0 then
			ls_descrip_marca = lstr_rangfech_marca.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_marca
			else
				is_cadena = ls_descrip_marca
			end if
		end if				
		//Verifica si ha filtrado los ITEMS
		if len(lstr_rangfech_item.descripciones) > 0 then
			ls_descrip_item = lstr_rangfech_item.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_item
			else
				is_cadena = ls_descrip_item
			end if
		end if	
		//Verifica si ha filtrado los proveedores
		if len(lstr_rangfech_proveedor.descripciones) > 0 then
			ls_descrip_proveedor = lstr_rangfech_proveedor.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_proveedor
			else
				is_cadena = ls_descrip_proveedor
			end if
		end if
		//Verifica si ha filtrado Materiales
		if len(lstr_rangfech_material.descripciones) > 0 then
			ls_descrip_material = lstr_rangfech_material.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_material
			else
				is_cadena = ls_descrip_material
			end if
		end if
		//Verifica si ha filtrado las Ocs
		if len(lstr_rangfech_oc.descripciones) > 0 then
			ls_descrip_oc = lstr_rangfech_oc.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_oc
			else
				is_cadena = ls_descrip_oc
			end if
		end if
		//Verifica si ha filtrado los Accesorios
		if len(lstr_rangfech_accesories.descripciones) > 0 then
			ls_descrip_accesories = lstr_rangfech_accesories.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_accesories
			else
				is_cadena = ls_descrip_accesories
			end if
		end if
		//Verifica si ha filtrado las Definiciones
		if len(lstr_rangfech_definicion.descripciones) > 0 then
			ls_descrip_definicion = lstr_rangfech_definicion.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_definicion
			else
				is_cadena = ls_descrip_definicion
			end if
		end if

		if ll_disponible = 0 then
			if len(is_cadena) > 0 then
				if li_incluir = 1 then
			//		is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
				else
					is_cadena = is_cadena + " and dentero = "+string(ll_disponible)
				end if
			else
				if li_incluir = 1 then
					is_cadena =  "dentero >= "+string(ll_disponible)
				else
					is_cadena =  "dentero = "+string(ll_disponible)
				end if
			end if
		else
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
			else
				is_cadena =  "dentero >= "+string(ll_disponible)
			end if
		end if 
		
		if cbx_cubrio_costo.checked then
			if len(is_cadena) > 0 then
				is_cadena  = is_cadena + ' and total_vendido > total_entrada'
			end if
		end if

		if is_cadena <> '' and not isnull(is_cadena) then
			this.setfilter(is_cadena)
		else
			this.setfilter('')
		end if
		this.filter()	
elseif dwo.name = 'b_filter' then
		parent.setredraw(false)
		j = 0
		dw_1.setsort('cradetalle_deta_desc_eng')
		dw_1.sort()
		ls_temp = lstr_rangfech.descripciones
		if len(ls_temp) = 0 or isnull(ls_temp) then lstr_rangfech = lstr_rangfech_nulos
		ls_temp = dw_1.getitemstring(1,'cradetalle_deta_desc_eng')
		if isnull(ls_temp) then ls_temp = ''
		if upperbound(lstr_rangfech.descripcion[]) = 0 then 
			for i = 1 to dw_1.rowcount()
				ls_descripcion = dw_1.getitemstring(i,'cradetalle_deta_desc_eng')
				if ls_descripcion <> ls_temp then
					j ++
					lstr_rangfech.descripcion[j] = ls_temp
					ls_temp = ls_descripcion
				end if
			next
			if j > 0 then
				j ++
				lstr_rangfech.descripcion[j] = ls_temp
			end if
		end if
		dw_1.setsort('prod_producto')
		dw_1.sort()
		parent.setredraw(true)
		if j = 0 and upperbound(lstr_rangfech.descripcion) = 0 then return
		//openwithparm(w_filtrar_rep_exist, lstr_rangfech) //,w_frame,2,Original!)
		lstr_rangfech = message.powerobjectparm
		if not isvalid(lstr_rangfech) then return
		ls_descrip = lstr_rangfech.descripciones

		ll_disponible = dw_3.getitemnumber(1,'disponible')
		li_incluir = dw_3.getitemnumber(1,'incluir')
		is_cadena = ls_descrip
		//Verifica si ha filtrado los Position Print

		//Verifica si ha filtrado las FECHAS
		if len(lstr_rangfech_fecha.descripciones) > 0 then
			ls_descrip_fechas = lstr_rangfech_fecha.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_fechas
			else
				is_cadena = ls_descrip_fechas
			end if
		end if
		//Verifica si ha filtrado los Sexos
		if len(lstr_rangfech_sexo.descripciones) > 0 then
			ls_descrip_sexo = lstr_rangfech_sexo.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_sexo
			else
				is_cadena = ls_descrip_sexo
			end if
		end if			
				//Verifica si ha filtrado los Bodies
		if len(lstr_rangfech_body.descripciones) > 0 then
			ls_descrip_body = lstr_rangfech_body.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body
			else
				is_cadena = ls_descrip_body
			end if
		end if		
		
		//Verifica si ha filtrado los Bodies 2
		if len(lstr_rangfech_body2.descripciones) > 0 then
			ls_descrip_body2 = lstr_rangfech_body2.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_body2
			else
				is_cadena = ls_descrip_body
			end if
		end if		

		//Verifica si ha filtrado los Codigos de Material
		if len(lstr_rangfech_code_mat.descripciones) > 0 then
			ls_descrip_cod_mat = lstr_rangfech_code_mat.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_cod_mat
			else
				is_cadena = ls_descrip_cod_mat
			end if
		end if		
		//Verifica si ha filtrado las marcas
		if len(lstr_rangfech_marca.descripciones) > 0 then
			ls_descrip_marca = lstr_rangfech_marca.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_marca
			else
				is_cadena = ls_descrip_marca
			end if
		end if				
		//Verifica si ha filtrado los Pattern
		if len(lstr_rangfech_pattern.descripciones) > 0 then
			ls_descrip_pattern = lstr_rangfech_pattern.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_pattern
			else
				is_cadena = ls_descrip_pattern
			end if
		end if
		//Verifica si ha filtrado los proveedores
		if len(lstr_rangfech_proveedor.descripciones) > 0 then
			ls_descrip_proveedor = lstr_rangfech_proveedor.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_proveedor
			else
				is_cadena = ls_descrip_proveedor
			end if
		end if
		//Verifica si ha filtrado los Disponibles
		if len(lstr_rangfech_disponible.descripciones) > 0 then
			ls_descrip_disponible = lstr_rangfech_disponible.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_disponible
			else
				is_cadena = ls_descrip_disponible
			end if
		end if		
		//Verifica si ha filtrado los margenes
		if len(lstr_rangfech_margen.descripciones) > 0 then
			ls_descrip_margen = lstr_rangfech_margen.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_margen
			else
				is_cadena = ls_descrip_margen
			end if
		end if
		//Verifica si ha filtrado los productos
		if len(lstr_rangfech_producto.descripciones) > 0 then
			ls_descrip_productos = lstr_rangfech_producto.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_productos
			else
				is_cadena = ls_descrip_productos
			end if
		end if	
		//Verifica si ha filtrado los ITEMS
		if len(lstr_rangfech_item.descripciones) > 0 then
			ls_descrip_item = lstr_rangfech_item.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_item
			else
				is_cadena = ls_descrip_item
			end if
		end if	
		//Verifica si ha filtrado las Ocs
		if len(lstr_rangfech_oc.descripciones) > 0 then
			ls_descrip_oc = lstr_rangfech_oc.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_oc
			else
				is_cadena = ls_descrip_oc
			end if
		end if
		//Verifica si ha filtrado Materiales
		if len(lstr_rangfech_material.descripciones) > 0 then
			ls_descrip_material = lstr_rangfech_material.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_material
			else
				is_cadena = ls_descrip_material
			end if
		end if
		//Verifica si ha filtrado los Accesorios
		if len(lstr_rangfech_accesories.descripciones) > 0 then
			ls_descrip_accesories = lstr_rangfech_accesories.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_accesories
			else
				is_cadena = ls_descrip_accesories
			end if
		end if
		//Verifica si ha filtrado las Definiciones
		if len(lstr_rangfech_definicion.descripciones) > 0 then
			ls_descrip_definicion = lstr_rangfech_definicion.descripciones
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + ' and ' + ls_descrip_definicion
			else
				is_cadena = ls_descrip_definicion
			end if
		end if

		if ll_disponible = 0 then
			if len(is_cadena) > 0 then
				if li_incluir = 1 then
				//	is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
				else
					is_cadena = is_cadena + " and dentero = "+string(ll_disponible)
				end if
			else
				if li_incluir = 1 then
					is_cadena =  "dentero >= "+string(ll_disponible)
				else
					is_cadena =  "dentero = "+string(ll_disponible)
				end if
			end if
		else
			if len(is_cadena) > 0 then
				is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
			else
				is_cadena =  "dentero >= "+string(ll_disponible)
			end if
		end if 
		
		if cbx_cubrio_costo.checked then
			if len(is_cadena) > 0 then
				is_cadena  = is_cadena + ' and total_vendido > total_entrada'
			end if
		end if

		if is_cadena <> '' and not isnull(is_cadena) then
			this.setfilter(is_cadena)
		else
			this.setfilter('')
		end if
		this.filter()
end if

end event

event dw_1::doubleclicked;call super::doubleclicked;string ls_producto, ls_error

choose case dwo.name
	case 'rentero', 'dentero'

		ls_producto = this.getitemstring(row,'prod_producto')
		wf_actualiza_reserva_existencia(ls_producto)

end choose

end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_catalogos
integer y = 452
integer width = 4402
integer height = 1732
end type

type em_desde from editmask within w_catalogos
integer x = 306
integer y = 16
integer width = 347
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type em_hasta from editmask within w_catalogos
integer x = 306
integer y = 108
integer width = 343
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_1 from statictext within w_catalogos
integer x = 27
integer y = 28
integer width = 256
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Desde: "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_catalogos
integer x = 27
integer y = 120
integer width = 256
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Hasta: "
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_catalogos
integer x = 750
integer y = 12
integer width = 311
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;date ldt_desde, ldt_hasta
long i, li_entero, li_null[],  ll_total
string ls_producto, ls_null[], ls_precio1, ls_precio2
decimal{2} ld_promedio, ld_margen, ld_precio1, ld_precio2
ldt_desde = date(em_desde.text)
ldt_hasta = date(em_hasta.text)
dw_3.accepttext()
wf_ocultar_dws(0)
dw_1.settransobject(sqlca)
SetPointer(HourGlass!)
yield()
ii_paises = li_null
lstr_rangfech 				= lstr_rangfech_nulos
lstr_rangfech_margen    = lstr_rangfech_nulos
lstr_rangfech_oc 			= lstr_rangfech_nulos
lstr_rangfech_accesories = lstr_rangfech_nulos
lstr_rangfech_material    = lstr_rangfech_nulos
lstr_rangfech_producto   = lstr_rangfech_nulos
lstr_rangfech_item			= lstr_rangfech_nulos
lstr_rangfech_fecha		= lstr_rangfech_nulos
lstr_rangfech_sexo		= lstr_rangfech_nulos
lstr_rangfech_definicion	= lstr_rangfech_nulos
lstr_rangfech_proveedor = lstr_rangfech_nulos
lstr_rangfech_disponible = lstr_rangfech_nulos
lstr_rangfech_pattern     = lstr_rangfech_nulos
lstr_rangfech_subgrupo     = lstr_rangfech_nulos
lstr_rangfech_marca     = lstr_rangfech_nulos
lstr_rangfech_grupo     = lstr_rangfech_nulos

dw_1.setfilter('')
dw_1.filter()
if dw_1.retrieve(str.g_financiero, str.empresa, ldt_desde, ldt_hasta) > 0 then
	phl_foto.picturename = dw_1.getitemstring(1, 'prod_foto_dir')
	dw_1.sharedata(dw_5)
//	dw_5.Object.datawindow.print.preview = true
//	dw_1.sharedata(dw_17)
//	dw_17.Object.datawindow.print.preview = true
	
else
	dw_1.insertrow(1)
end if

li_entero = dw_3.getitemnumber(1,'disponible')

//dw_3.reset()
//dw_3.insertrow(0)
//dw_3.setitem(1, "disponible", li_entero)
if li_entero = 0 then
	is_cadena = "dentero <= "+string(li_entero)
	if dw_3.getitemnumber(1,'incluir') = 1 then
		is_cadena = ''
	end if
else
	is_cadena = "dentero >= "+string(li_entero)
end if
dw_1.setfilter( is_cadena)
dw_1.filter()

dw_5.setitem(1, "desde", string(ldt_desde))
dw_5.setitem(1, "hasta", string(ldt_hasta))

cbx_1.checked = false
dw_1.modify('letras_t.visible=false')
dw_1.modify('letras.visible=false')

dw_5.modify('letras_t.visible=false')
dw_5.modify('letras.visible=false')

SetPointer(Arrow!)
dw_1.setfocus()
//dw_1.Object.datawindow.print.preview = true
str.frame.setmicrohelp('Consulta Gerencial')


end event

type cb_salir from commandbutton within w_catalogos
integer x = 750
integer y = 108
integer width = 311
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;close(parent)
end event

type calendario from picture within w_catalogos
integer x = 654
integer y = 16
integer width = 69
integer height = 80
boolean bringtotop = true
string pointer = "HyperLink!"
string picturename = "\Sistemas\Hymsoft\Art\ddfec.bmp"
boolean focusrectangle = false
end type

event clicked;date 	ld_date,ld_ini_date, ld_hoy
//parent.height = 1144
	
	ld_ini_date=date(em_desde.text)
	if year(ld_ini_date) = 1900 then
		ld_ini_date = ld_hoy
	end if
	if uo_1.visible=false then
		uo_1.wf_set_value(ld_ini_date)
		uo_1.visible=true
		uo_1.allow_close=false
		uo_1.inicializar()
		uo_1.TriggerEvent('ue_abrir')
	end if

end event

type calendario2 from picture within w_catalogos
integer x = 654
integer y = 108
integer width = 69
integer height = 80
boolean bringtotop = true
string pointer = "HyperLink!"
string picturename = "\Sistemas\Hymsoft\Art\ddfec.bmp"
boolean focusrectangle = false
end type

event clicked;date 	ld_date,ld_ini_date, ld_hoy
//parent.height = 1144
	
	ld_ini_date=date(em_hasta.text)
	if year(ld_ini_date) = 1900 then
		ld_ini_date = ld_hoy
	end if
	if uo_2.visible=false then
		uo_2.wf_set_value(ld_ini_date)
		uo_2.visible=true
		uo_2.allow_close=false
		uo_2.inicializar()
		uo_2.TriggerEvent('ue_abrir')
	end if

end event

type uo_1 from u_ddcalen within w_catalogos
boolean visible = false
integer y = 128
integer taborder = 30
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;em_desde.text = string(uo_1.return_sel_date())

if uo_1.allow_close then
	this.visible=false
	em_desde.SetFocus()
end if


end event

on uo_1.destroy
call u_ddcalen::destroy
end on

type uo_2 from u_ddcalen within w_catalogos
boolean visible = false
integer x = 658
integer y = 128
integer taborder = 40
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;em_hasta.text = string(uo_2.return_sel_date())

if uo_2.allow_close then
	this.visible=false
	em_hasta.SetFocus()
end if


end event

on uo_2.destroy
call u_ddcalen::destroy
end on

type phl_foto from picturehyperlink within w_catalogos
integer x = 4581
integer y = 452
integer width = 2062
integer height = 1536
boolean bringtotop = true
string pointer = "HyperLink!"
boolean focusrectangle = false
end type

event clicked;//string ls_foto, ls_producto
//	if dw_1.rowcount() = 0 then return
//
//	ls_foto = dw_1.getitemstring(dw_1.getrow(), "prod_foto_dir")
//	ls_producto = dw_1.getitemstring(dw_1.getrow(), "prod_producto")
//		
//	if fileexists(ls_foto) then
//		if isvalid(w_imagen) then
//			close(w_imagen)		
//		end if
//		openwithparm(w_imagen, ls_producto)
//	end if
end event

type shl_1 from statichyperlink within w_catalogos
integer x = 4453
integer y = 384
integer width = 1495
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 67108864
string text = "Foto del Producto ......"
boolean focusrectangle = false
end type

event clicked;string ls_foto, ls_producto
	if dw_1.rowcount() = 0 then return

	ls_foto = dw_1.getitemstring(dw_1.getrow(), "prod_foto_dir")
	ls_producto = dw_1.getitemstring(dw_1.getrow(), "prod_producto")

	if fileexists(ls_foto) then
	//	if isvalid(w_imagen) then
	//		close(w_imagen)		
	//	end if
		//openwithparm(w_imagen, ls_producto)
	end if
end event

type dw_3 from datawindow within w_catalogos
integer x = 1097
integer width = 3785
integer height = 352
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_exist_por_fechas"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//Aplica filtros
this.accepttext()
string ls_sexo, ls_tipo, ls_texto, ls_campo, ls_foto, ls_material, ls_len, ls_columna, ls_marca, ls_definicion
string ls_sexo_cadena, ls_cod_sex, ls_prov, ls_descrip_cadena, ls_descrip, ls_descrip_temp, ls_comprador
boolean lb_entro, lb_recuperar = false, lb_solo_fotos
long ll_disponible, ll_count, ll_cuenta, ll_tercero, i, ll_total, ll_entrada
decimal{2} ld_porc, ld_costo_cif, ld_precio
integer li_bandera = 0, li_check, li_incluir, li_bandera2 = 0, li_ann
ls_texto = data

if isnull(ls_texto) then ls_texto = ''

ls_columna  = this.getcolumnname()

li_incluir = dw_3.getitemnumber(1,'incluir')
is_cadena = ''

choose case ls_columna
	case 'entrada'
		li_ann 	  = this.getitemnumber(1,'ann')
		ll_entrada = this.getitemnumber(1,'entrada')
		dw_1.retrieve(str.g_financiero, str.empresa,ll_entrada,li_ann)
		
	case 'por_entrada'
		if data = '0' then
			dw_1.dataobject = 'dw_rep_inventario_x_fecha'
			if cbx_3.checked then
				dw_5.dataobject = 'catalogo_inventario_total_4_foto_grande'
			else
				dw_5.dataobject = 'catalogo_inventario_total_4_por_pagina'	
			end if
		else
			dw_1.dataobject = 'dw_rep_inventario_x_entrada'
		end if
		dw_1.settransobject(sqlca)
		dw_5.settransobject(sqlca)
		dw_1.sharedata(dw_5)
	case 'disponible'
		ll_disponible = long(data)
	case 'ann'
		ii_ann = integer(data)
		idwc_entradas.retrieve(str.g_financiero, str.empresa, ii_ann)
	case 'incluir'
		li_incluir = long(data)
	case 'porc'

	ld_porc		 = dw_3.getitemnumber(1,'porc')
	for i = 1 to dw_1.rowcount()
		if ld_porc > 0 then
			ld_costo_cif =  dw_1.getitemnumber(i,'inmprodu_prod_costo_cif')
			ld_precio = ld_costo_cif + (ld_costo_cif * (ld_porc / 100) )
			dw_1.setitem(i,'precio_numero',ld_precio)
			dw_1.setitem(i,'precio_numero2',ld_precio)
		end if
		if lb_solo_fotos then
			
		end if
	next
	
	case 'solo_fotos'	
		if data = '1' then
			lb_solo_fotos = true
		else
			lb_solo_fotos = false
		end if
			ll_total = dw_1.rowcount()
			for i = 1 to ll_total
				if lb_solo_fotos then
					ls_foto = dw_1.getitemstring(i,'prod_foto_dir')
					if ls_foto = '' or isnull(ls_foto) then
						dw_1.deleterow(i)
						ll_total --
						i --
					end if
				end if
			next
end choose

ll_disponible = dw_3.getitemnumber(1,'disponible')

if ll_disponible = 0 then
	if li_incluir = 1 then
		is_cadena =  "dentero >= "+string(ll_disponible)
	else
		is_cadena =  "dentero = "+string(ll_disponible)
	end if
	lb_recuperar = true
else
	if len(is_cadena) > 0 then
		is_cadena = is_cadena + " and dentero >= "+string(ll_disponible)
	else
		is_cadena =  "dentero >= "+string(ll_disponible)
	end if
end if 

if cbx_cubrio_costo.checked then
	if len(is_cadena) > 0 then
		is_cadena  = is_cadena + ' and total_vendido > total_entrada'
	end if
end if

//messagebox('', is_cadena)

dw_1.setfilter(is_cadena)
dw_1.filter()

if lb_recuperar then
//	cb_1.triggerevent('clicked')
end if

if dw_1.rowcount() > 0 then
	ls_foto = dw_1.getitemstring(1,'prod_foto_dir')
else
	ls_foto = ''
end if
phl_foto.picturename= ls_foto

end event

event editchanged;string ls_texto, ls_cadena
integer li_encontro

choose case dwo.name
	case 'marca'
		ls_texto = data
		ls_cadena = 'left(upper(amar_nombre_marca) ,'+ string(len(ls_texto))+ ') = "'+upper(ls_texto)+'"'		
		li_encontro = dw_7.find(ls_cadena,1,dw_7.rowcount())
		if li_encontro > 0 then
			dw_7.scrolltorow(li_encontro)
		end if
	case 'nivel3'
		ls_texto = data
		ls_cadena = 'left(upper(prod_nivel3) ,'+ string(len(ls_texto))+ ') = "'+upper(ls_texto)+'"'		
		li_encontro = dw_8.find(ls_cadena,1,dw_8.rowcount())
		if li_encontro > 0 then
			dw_8.scrolltorow(li_encontro)
		end if		
	case 'tipo'
		ls_texto = data
		ls_cadena = 'left(upper(tprod_desc_ing) ,'+ string(len(ls_texto))+ ') = "'+upper(ls_texto)+'"'		
		li_encontro = dw_9.find(ls_cadena,1,dw_9.rowcount())
		if li_encontro > 0 then
			dw_9.scrolltorow(li_encontro)
		end if				
	case 'nivel3'
		ls_texto = data
		ls_cadena = 'left(upper(prod_nivel4) ,'+ string(len(ls_texto))+ ') = "'+upper(ls_texto)+'"'		
		li_encontro = dw_8.find(ls_cadena,1,dw_8.rowcount())
		if li_encontro > 0 then
			dw_8.scrolltorow(li_encontro)
		end if					
	case 'nivel1'
		ls_texto = data
		ls_cadena = 'left(upper(prod_nivel1) ,'+ string(len(ls_texto))+ ') = "'+upper(ls_texto)+'"'		
		li_encontro = dw_11.find(ls_cadena,1,dw_11.rowcount())
		if li_encontro > 0 then
			dw_11.scrolltorow(li_encontro)
		end if					
	case 'material_code'
		ls_texto = data
		ls_cadena = 'left(upper(mat_cod_material) ,'+ string(len(ls_texto))+ ') = "'+upper(ls_texto)+'"'		
		li_encontro = dw_11.find(ls_cadena,1,dw_11.rowcount())
		if li_encontro > 0 then
			dw_11.scrolltorow(li_encontro)
		end if							
	case 'nivel2'
		ls_texto = data
		ls_cadena = 'left(upper(prod_nivel2) ,'+ string(len(ls_texto))+ ') = "'+upper(ls_texto)+'"'		
		li_encontro = dw_12.find(ls_cadena,1,dw_12.rowcount())
		if li_encontro > 0 then
			dw_12.scrolltorow(li_encontro)
		end if							
	case 'comprador'
		ls_texto = data
		ls_cadena = 'left(upper(nombre) ,'+ string(len(ls_texto))+ ') = "'+upper(ls_texto)+'"'		
		li_encontro = dw_13.find(ls_cadena,1,dw_13.rowcount())
		if li_encontro > 0 then
			dw_13.scrolltorow(li_encontro)
		end if							
	case 'nivel4'
		ls_texto = data
		ls_cadena = 'left(upper(prod_nivel4) ,'+ string(len(ls_texto))+ ') = "'+upper(ls_texto)+'"'		
		li_encontro = dw_21.find(ls_cadena,1,dw_21.rowcount())
		if li_encontro > 0 then
			dw_21.scrolltorow(li_encontro)
		end if							
	case 'cliente'
		ls_texto = data
		ls_cadena = 'left(upper(terc_descripcion) ,'+ string(len(ls_texto))+ ') = "'+upper(ls_texto)+'"'		
		li_encontro = dw_22.find(ls_cadena,1,dw_22.rowcount())
		if li_encontro > 0 then
			dw_22.scrolltorow(li_encontro)
		end if							

		
end choose

//return 2
end event

event clicked;string  ls_1[], ls_marca, ls_marca_nombre, ls_syntax, ls_sexo_cadena, ls_cod_sex, ls_prov, ls_descrip_cadena, ls_descrip, ls_descrip_temp, ls_comprador, ls_columna, ls_cadena_sexo, ls_sexo
boolean lb_entro
string ls_sexos
long ll_disponible, ll_count, ll_cuenta, ll_tercero
integer li_bandera = 0, li_check, li_incluir, li_bandera2 = 0, i, j
this.accepttext()
//ls_texto = data

//if isnull(ls_texto) then ls_texto = ''

ls_columna  = dwo.name //this.getcolumnname()

is_cadena = ''

choose case ls_columna
	case 'marca', 'p_marca'
		wf_ocultar_dws(7)

		//dw_7.retrieve(str.g_financiero, str.empresa)
		
		if dw_7.visible then
			dw_7.visible = false
		else
			dw_7.visible = true	
		end if
		if ls_columna = 'p_marca' then
			dw_3.setcolumn('marca')
			dw_3.setfocus()
		end if		
	case 'nivel1', 'p_nivel1'
			wf_ocultar_dws(11)
			if dw_11.visible then
				dw_11.visible = false
			else
				dw_11.visible = true	
			end if
			if ls_columna = 'p_nivel1' then
				dw_11.setcolumn(1)
				dw_11.setfocus()
			end if		
	case 'nivel2', 'p_nivel2'
			wf_ocultar_dws(12)
			if dw_12.visible then
				dw_12.visible = false
			else
				dw_12.visible = true	
			end if
			if ls_columna = 'p_nivel2' then
				dw_12.setcolumn(1)
				dw_12.setfocus()
			end if				
	case 'nivel3', 'p_nivel3'
		wf_ocultar_dws(8)
		if dw_8.visible then
			dw_8.visible = false
		else
			dw_8.visible = true	
		end if
		if ls_columna = 'p_nivel3' then
			dw_8.setcolumn(1)
			dw_8.setfocus()
		end if		
	case 'nivel4', 'p_nivel4'
		wf_ocultar_dws(21)
		if dw_21.visible then
			dw_21.visible = false
		else
			dw_21.visible = true	
		end if
		if ls_columna = 'p_nivel4' then
			dw_21.setcolumn(1)
			dw_21.setfocus()
		end if		
	case 'nivel5', 'p_nivel5'
		wf_ocultar_dws(9)
		if dw_9.visible then
			dw_9.visible = false
		else
			dw_9.visible = true	
		end if
		if ls_columna = 'p_nivel5' then
			dw_9.setcolumn(1)
			dw_9.setfocus()
		end if		

	case 'comprador', 'p_comprador'
			wf_ocultar_dws(13)
			if dw_13.visible then
				dw_13.visible = false
			else
				dw_13.visible = true	
			end if
			if ls_columna = 'p_comprador' then
				dw_13.setcolumn(1)
				dw_13.setfocus()
			end if						
	case 'tipo', 'p_tipo'
		wf_ocultar_dws(9)
		if dw_9.visible then
			dw_9.visible = false
		else
			dw_9.visible = true	
		end if
		if ls_columna = 'p_tipo' then
			dw_9.setcolumn(1)
			dw_9.setfocus()
		end if					
	case 'pattern', 'p_pattern'
		wf_ocultar_dws(19)
		if dw_19.visible then
			dw_19.visible = false
		else
			dw_19.visible = true	
		end if
		if ls_columna = 'p_pattern' then
			dw_19.setcolumn(1)
			dw_19.setfocus()
		end if		
	case 'position_print', 'p_pprint'
		wf_ocultar_dws(20)
		if dw_20.visible then
			dw_20.visible = false
		else
			dw_20.visible = true	
		end if
		if ls_columna = 'p_pprint' then
			dw_20.setcolumn(1)
			dw_20.setfocus()
		end if		
	case 'cliente', 'p_cliente'
		wf_ocultar_dws(22)
		if dw_22.visible then
			dw_22.visible = false
		else
			dw_22.visible = true	
		end if
		if ls_columna = 'p_cliente' then
			dw_22.setcolumn(1)
			dw_22.setfocus()
		end if		
		
end choose
end event

event itemfocuschanged;this.selecttext(1,100)
end event

type dw_5 from datawindow within w_catalogos
boolean visible = false
integer x = 50
integer y = 364
integer width = 4375
integer height = 1748
integer taborder = 11
boolean bringtotop = true
string dataobject = "catalogo_inventario_total_4_por_pagina"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;this.settransobject(sqlca)
end event

type rb_1 from radiobutton within w_catalogos
integer x = 4919
integer y = 4
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Consulta"
boolean checked = true
end type

event clicked;if this.checked  then
//	if isnull(is_filtro) then is_filtro = ''
	if isnull(is_cadena) then is_cadena = ''
	dw_1.setfilter(is_cadena)
	dw_1.filter()
	dw_1.visible = true
	dw_5.visible = false
end if
end event

type rb_2 from radiobutton within w_catalogos
integer x = 4919
integer y = 72
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Impresión"
end type

event clicked;date ldt_desde, ldt_hasta
string ls_precio1, ls_precio2, ls_costos, ls_precio3
long i, ll_total
integer  li_ver_precio, li_ver_cantidad, li_ver_precios
decimal{2} ld_porc, ld_costo_cif, ld_precio, ld_precio1, ld_precio2, ld_precio3
if this.checked then
	li_ver_cantidad = dw_3.getitemnumber(1,'ver_cantidad')
	li_ver_precios = dw_3.getitemnumber(1,'ver_precio')
	ld_porc		 = dw_3.getitemnumber(1,'porc')
	
	
	if li_ver_precios = 1 then
		li_ver_precio = dw_3.getitemnumber(1,'precio')
	end if
//	is_filtro = dw_1.Describe("Filter")
	if len(is_cadena) > 0 then
		dw_1.setfilter(is_cadena + ' and incluir = 1')
	else
		dw_1.setfilter('incluir = 1')
	end if
	dw_1.filter()
	ll_total = dw_1.rowcount()
	for i = 1 to ll_total
		dw_1.setitem(i,'ver_precio',li_ver_precio)
		dw_1.setitem(i,'ver_cantidad',li_ver_cantidad)		
		ld_costo_cif =  dw_1.getitemnumber(i,'inmprodu_prod_costo_cif')
		
		if dw_3.getitemnumber(1,'precio_en_clave') = 1 and li_ver_precios = 1 then		
				str.frame.setmicrohelp('Registro '+string(i)+' de '+string(ll_total))
				ld_precio1 = dw_1.getitemnumber(i,'precio_numero')
				ld_precio2 = dw_1.getitemnumber(i,'precio_numero2')
				ld_precio3 = dw_1.getitemnumber(i,'precio_numero3')
				if ld_precio1 > 0 then 
					ls_precio1 = gf_clave_precios(dec(ld_precio1) )
				else
					ls_precio1 = ''
				end if
				if ld_precio2 > 0 then
					ls_precio2 = gf_clave_precios(dec(ld_precio2) )
				else
					ls_precio2 = ''
				end if
				if ld_precio3 > 0 then
					ls_precio3 = gf_clave_precios(dec(ld_precio3) )
				else
					ls_precio3 = ''
				end if
				dw_1.setitem(i,'precio1',ls_precio1)
				dw_1.setitem(i,'precio2',ls_precio2)			
				dw_1.setitem(i,'precio3',ls_precio3)			
				dw_1.setitem(i,'ver_precio',0)						
				ls_costos = gf_clave_costos(dec(ld_costo_cif))
				dw_1.setitem(i,'costo',ls_costos)			
		else
				dw_1.setitem(i,'precio1','')
				dw_1.setitem(i,'precio2','')			
				dw_1.setitem(i,'precio3','')		
		end if
	
		if ld_porc > 0 then			
			ld_precio = ld_costo_cif + (ld_costo_cif * (ld_porc / 100) )
			dw_1.setitem(i,'precio_numero',ld_precio)
			dw_1.setitem(i,'precio_numero2',ld_precio)
			dw_1.setitem(i,'precio_numero3',ld_precio)
		end if
	next
	str.frame.setmicrohelp('Hymsoft')
	dw_5.visible = true
	dw_1.visible = false
	
	ldt_desde = date(em_desde.text)
	ldt_hasta = date(em_hasta.text)

	dw_5.setitem(1, "desde", string(ldt_desde))
	dw_5.setitem(1, "hasta", string(ldt_hasta))

	dw_5.object.datawindow.print.preview = 'yes'
	dw_5.object.datawindow.print.preview.zoom = 100

//	dw_5.Modify("DataWindow.Zoom='80'")

end if
end event

type cbx_1 from checkbox within w_catalogos
boolean visible = false
integer x = 4475
integer y = 2140
integer width = 713
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mostrar Precio de Venta"
end type

event clicked;long ll_count
decimal ldc_precio_venta
integer li_num_cv, li_cont
string ls_clave


if this.checked = true then
	
	if  cbx_ver_proveedor.checked then
		dw_1.modify("prod_proveedor.X='11781'")
		dw_1.modify("prod_proveedor_t.X='11781'")
		dw_1.modify("mfr_name.X='11968'")
		dw_1.modify("mfr_name_t.X='11968'")
		dw_1.modify("b_proveedor.X='12567'")
	end if
	
	dw_1.modify('letras_t.visible=true')
	dw_1.modify('letras.visible=true')
	
	dw_5.modify('letras_t.visible=true')
	dw_5.modify('letras.visible=true')
	
		for ll_count = 0 to dw_1.rowcount()
		
		yield()
		
		w_fa_frame.setmicrohelp("Registro " + string(ll_count) + " de " + string(dw_1.rowcount() ) )
		
		ldc_precio_venta = dw_1.getitemdecimal(ll_count, "precio_venta")
		
		choose case ldc_precio_venta 
		case 0 to 15.99,36 to 45.99,66 to 75.99
			li_num_cv=1
		case 16 to 25.99,46 to 55.99,76 to 86
			li_num_cv=2
		case 26 to 35.99,56 to 65.99,is > 86
			li_num_cv=3
		end choose
		li_cont=1
		
		declare cr_clave cursor for
		 select claco_codigo
		 from inaclaco
		 where claco_g_financiero = :str.g_financiero and
				 claco_empresa = :str.empresa 
		order by claco_codigo;
		open cr_clave;
		fetch cr_clave into :ls_clave;
		do while li_cont <> li_num_cv
		
		li_cont++
		fetch cr_clave into :ls_clave;
		loop
		close cr_clave;
				
	next

	
else
		dw_1.modify("prod_proveedor.X='11410'")
		dw_1.modify("prod_proveedor_t.X='11410'")
		dw_1.modify("mfr_name.X='11602'")
		dw_1.modify("mfr_name_t.X='11602'")	
		dw_1.modify("b_proveedor.X='12197'")	

	dw_1.modify('letras_t.visible=false')
	dw_1.modify('letras.visible=false')
	
	dw_5.modify('letras_t.visible=false')
	dw_5.modify('letras.visible=false')
end if



end event

type pb_1 from picturebutton within w_catalogos
integer x = 4443
integer y = 1944
integer width = 110
integer height = 96
integer taborder = 11
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "SaveAs!"
alignment htextalign = left!
end type

event clicked;string ls_directorio, ls_imagen, ls_nombre, ls_imagen_back, ls_sexo, ls_temp, ls_descrip
integer li_file, i, li_pos
boolean lb_entro = false

ls_directorio = nv_f.of_browseforfolder("Guardar Imagen ...",true)

if ls_directorio <> '' then
	for i = 1 to dw_1.rowcount()
		if dw_1.getitemnumber(i,'incluir') = 1 then
					ls_imagen = dw_1.getitemstring(i, 'prod_foto_dir')
//					ls_imagen_back = mid(ls_imagen,1,len(ls_imagen) - 4)+'B.jpg'
//					ls_sexo = dw_1.getitemstring(i,'crasexo_sex_desc_eng')		
//					ls_descrip = dw_1.getitemstring(i,'cradetalle_deta_desc_eng')
//					li_pos = 1
//					do while li_pos > 0
//						li_pos = pos(ls_descrip,'/',li_pos)
//						if li_pos > 0 then
//							ls_descrip = replace(ls_descrip,li_pos,1,' ')
//							li_pos ++
//						end if
//					loop
					if ls_imagen <> '' then
						ls_nombre = dw_1.getitemstring(i, 'prod_producto')
						//	if len(ls_directorio) = 3 then
								li_file = filecopy(ls_imagen, ls_directorio + ls_nombre + '.jpg', true)
								
//							else
//								li_file = filecopy(ls_imagen, ls_directorio + '\'+ ls_nombre + '.jpg', true)
//								if cbx_back.checked and fileexists(ls_imagen_back) then
//									li_file = filecopy(ls_imagen_back, ls_directorio + '\'+ ls_nombre + 'B.jpg', true)
//								end if
//							end if				
							lb_entro = true
					end if //imgen <> ''
				end if	
	next
		if lb_entro then
			messagebox("Atención", "Copia Ejecutada Satisfactoriamente", Information!)
		else
//			ls_imagen = dw_1.getitemstring(dw_1.getrow(), 'prod_foto_dir')
//			ls_imagen_back = mid(ls_imagen,1,len(ls_imagen) - 4)+'B.jpg'
//			if ls_imagen <> '' then
//				ls_nombre = dw_1.getitemstring(dw_1.getrow(), 'prod_producto')
//					if len(ls_directorio) = 3 then
//						li_file = filecopy(ls_imagen, ls_directorio + ls_nombre + '.jpg', true)
//						if cbx_back.checked and fileexists(ls_imagen_back) then
//							li_file = filecopy(ls_imagen_back, ls_directorio + ls_nombre + 'B.jpg', true)
//						end if
//					else
//						li_file = filecopy(ls_imagen, ls_directorio + '\'+ ls_nombre + '.jpg', true)
//						if cbx_back.checked and fileexists(ls_imagen_back) then
//							li_file = filecopy(ls_imagen_back, ls_directorio + '\'+ ls_nombre + 'B.jpg', true)
//						end if
//					end if
					
//					if li_file = 1 then
//						messagebox("Atención", "Se salvo la imagen con exito.", Information!)
//					else
//						messagebox("ERROR!", "Error al salvar la imagen.", StopSign!)
//					end if					
//			end if //imgen <> ''
		end if
	
end if //del directorio


end event

type st_3 from statictext within w_catalogos
integer x = 4571
integer y = 1960
integer width = 434
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Guardar Imagen"
boolean focusrectangle = false
end type

type cbx_back from checkbox within w_catalogos
boolean visible = false
integer x = 4475
integer y = 2052
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Back"
end type

type hpb_barra from hprogressbar within w_catalogos
boolean visible = false
integer x = 347
integer y = 692
integer width = 3227
integer height = 84
boolean bringtotop = true
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

type cbx_cubrio_costo from checkbox within w_catalogos
boolean visible = false
integer x = 4919
integer y = 184
integer width = 786
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ref. que Cubrieron su Costo"
end type

event clicked;integer i, li_filas
datetime ldt_fecha_entrada
string ls_producto
decimal{2} ld_costo, ld_total_entrada, ld_total_vendido
long ll_entrada, ll_step

if this.checked then
	li_filas = dw_1.rowcount()
//	hpb_barra.SetRange ( 0, li_filas )		
//	hpb_barra.MaxPosition = li_filas
//	hpb_barra.Position = 0
//	ll_step = 1 //00 / li_filas
//	hpb_barra.SetStep = ll_step
//	hpb_barra.offsetpos(1)
//	hpb_barra.visible = true

	if dw_1.Describe("ver.x") <> "?" and dw_1.Describe("ver.x") <> "!" then &
	dw_1.object.ver.expression = "'" + string(1) + "'"
	dw_1.object.cramaterial_mat_compo.width = '873'
	dw_1.object.cramaterial_mat_compo_t.width = '873'
	
//	for i = 1 to li_filas
//		yield()
//		hpb_barra.StepIt()
//		w_frame.setmicrohelp("Caculando Ventas, Registro " + string(i) + " de " + string(li_filas) )
//				
//		ld_costo = dw_1.getitemnumber(i,'inmprodu_prod_costo_fob')
//		ll_entrada = dw_1.getitemnumber(i,'prod_ultima_entrada_can')
//		ld_total_entrada = ld_costo * ll_entrada
//		dw_1.setitem(i,'total_entrada',ld_total_entrada)
//		ls_producto =  dw_1.getitemstring(i,'prod_producto')
//		ldt_fecha_entrada = dw_1.getitemdatetime(i,'inmprodu_prod_entrada_fecha')
//		
//		SELECT isnull(sum(faddiari.facd_monto_final),0)
//			into :ld_total_vendido
//			 FROM faddiari,   
//					fatdiari  
//			WHERE ( fatdiari.fact_g_financiero = faddiari.facd_g_financiero ) and  
//					( fatdiari.fact_empresa = faddiari.facd_empresa ) and  
//					( fatdiari.fact_tipo = faddiari.facd_tipo ) and  
//					( fatdiari.fact_no_pedido = faddiari.facd_no_pedido ) and  
//					( fatdiari.fact_ann = faddiari.facd_ann ) and  
//					( ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
//					( faddiari.facd_empresa = :str.empresa ) AND  
//					( faddiari.facd_codigo_item = :ls_producto ) AND  
//					( fatdiari.fact_fecha >= :ldt_fecha_entrada ) )    ;
//					if sqlca.sqlcode = -1 then
//						gf_mensaje('','Error al buscar monto vendido '+ sqlca.sqlerrtext,1,1,'E')
//					end if
//		dw_1.setitem(i,'total_vendido',ld_total_vendido)	
//		
//	next
	dw_1.setfilter(is_cadena +' and total_vendido > total_entrada')
else
	dw_1.object.cramaterial_mat_compo.width = '1321'
	dw_1.object.cramaterial_mat_compo_t.width = '1321'
	if dw_1.Describe("ver.x") <> "?" and dw_1.Describe("ver.x") <> "!" then &
	dw_1.object.ver.expression = "'" + string(0) + "'"
	dw_1.setfilter(is_cadena)
end if
w_fa_frame.setmicrohelp("Listo" )
//hpb_barra.visible = false
dw_1.filter()
dw_1.groupcalc()
end event

type cb_2 from commandbutton within w_catalogos
integer x = 4443
integer y = 184
integer width = 407
integer height = 88
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Limpiar Filtro"
end type

event clicked;integer li_entero, i
dw_3.accepttext()
li_entero = dw_3.getitemnumber(1,'disponible')
dw_3.reset()
dw_3.insertrow(0)
dw_3.setitem(1, "disponible", li_entero)
is_cadena = "dentero>= "+string(li_entero)
dw_1.setfilter( is_cadena)
dw_1.filter()

string ls_producto, ls_null[]
lstr_rangfech 				= lstr_rangfech_nulos
lstr_rangfech_margen    = lstr_rangfech_nulos
lstr_rangfech_oc 			= lstr_rangfech_nulos
lstr_rangfech_accesories = lstr_rangfech_nulos
lstr_rangfech_material    = lstr_rangfech_nulos
lstr_rangfech_producto   = lstr_rangfech_nulos
lstr_rangfech_item			= lstr_rangfech_nulos
lstr_rangfech_fecha		= lstr_rangfech_nulos
lstr_rangfech_sexo		= lstr_rangfech_nulos
lstr_rangfech_definicion	= lstr_rangfech_nulos
lstr_rangfech_proveedor = lstr_rangfech_nulos

for i = 1 to dw_7.rowcount()
	dw_7.setitem(i,'li_check',0)
next
for i = 1 to dw_8.rowcount()
	dw_8.setitem(i,'li_check',0)
next
for i = 1 to dw_9.rowcount()
	dw_9.setitem(i,'li_check',0)
next
for i = 1 to dw_10.rowcount()
	dw_10.setitem(i,'li_check',0)
next
for i = 1 to dw_11.rowcount()
	dw_11.setitem(i,'li_check',0)
next
for i = 1 to dw_12.rowcount()
	dw_12.setitem(i,'li_check',0)
next
for i = 1 to dw_13.rowcount()
	dw_13.setitem(i,'li_check',0)
next

end event

type dw_7 from datawindow within w_catalogos
event ue_post_item ( )
boolean visible = false
integer x = 1321
integer y = 84
integer width = 905
integer height = 1296
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_marca_check"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_post_item();integer i, li_check
string ls_marca, ls_cadena_marca
if this.getcolumnname() = 'li_check' then
	if this.getrow() = 1 then
		li_check = this.getitemnumber(1,'li_check')
		for i = 1 to this.rowcount()
			this.setitem(i,'li_check',li_check)
		next
		if li_check = 0 then
			dw_3.setitem(1,'marca','')			
		else
			dw_3.setitem(1,'marca',this.getitemstring(2,'amar_nombre_marca')+'...')
		end if
		return
	else
		if this.getitemnumber(this.getrow(),'li_check') = 1 then
			ls_marca = dw_3.getitemstring(1,'marca')
			if ls_marca = '' or isnull(ls_marca) then
				dw_3.setitem(1,'marca',this.getitemstring(this.getrow(),'amar_nombre_marca'))
			else
				if right(ls_marca,3) <> '...' then
					dw_3.setitem(1,'marca',ls_marca + '...')
				end if
			end if
		else
			ls_marca = dw_3.getitemstring(1,'marca')
			if right(ls_marca,3) = '...' then
				for i = 2 to dw_7.rowcount()
					li_check = this.getitemnumber(i,'li_check')
					if li_check = 1 then
						ls_marca = this.getitemstring(i,'amar_nombre_marca')
						if ls_cadena_marca = '' then
							ls_cadena_marca = ls_marca
						else
							ls_cadena_marca = ls_cadena_marca + '...'
							exit
						end if
					end if
				next
				dw_3.setitem(1,'marca',ls_cadena_marca)
			else
				dw_3.setitem(1,'marca','')
			end if
		end if

	end if
end if
end event

event itemchanged;this.accepttext()
this.postevent('ue_post_item')
end event

event buttonclicked;dw_7.visible = false
end event

event clicked;integer li_check, i
string ls_text, ls_campo
dw_7.accepttext()
dw_8.visible = false
dw_19.visible = false
dw_20.visible = false
dw_21.visible = false

if row = 0 then return

if dwo.name = 'amar_nombre_marca' then
	li_check = this.getitemnumber(row,'li_check')
	if li_check = 0 then
		this.setitem(row,'li_check',1)
		if dw_3.getitemstring(1,'marca') = '' or isnull(dw_3.getitemstring(1,'marca')) then
			dw_3.setitem(1,'marca',this.getitemstring(row,'amar_nombre_marca'))
		end if
	else
		this.setitem(row,'li_check',0)
		dw_3.setitem(1,'marca','')
	end if
else
//	ls_text = this.getitemstring(row,'amar_nombre_marca')
//	if isnull(ls_text) then
//		li_check = 0
//		for i = 1 to this.rowcount()
//			this.setitem(i,'li_check',li_check)
//			dw_3.setitem(1,'marca','')
//		next
//		dw_7.accepttext()
//		return 2
//	end if
end if
end event

type dw_9 from datawindow within w_catalogos
event ue_post_item ( )
boolean visible = false
integer x = 2487
integer y = 260
integer width = 923
integer height = 1096
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_nivel5_check"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_post_item();integer i, li_check
string ls_marca, ls_cadena_marca
if this.getcolumnname() = 'li_check' then
	if this.getrow() = 1 then
		li_check = this.getitemnumber(1,'li_check')
		for i = 1 to this.rowcount()
			this.setitem(i,'li_check',li_check)
		next
		if li_check = 0 then
			dw_3.setitem(1,'nivel5','')			
		else
			dw_3.setitem(1,'nivel5',this.getitemstring(2,'prod_nivel5')+'...')
		end if
		return
	else
		if this.getitemnumber(this.getrow(),'li_check') = 1 then
			ls_marca = dw_3.getitemstring(1,'nivel5')
			if ls_marca = '' or isnull(ls_marca) then
				dw_3.setitem(1,'nivel5',this.getitemstring(this.getrow(),'prod_nivel5'))
			else
				if right(ls_marca,3) <> '...' then
					dw_3.setitem(1,'nivel5',ls_marca + '...')
				end if
			end if
		else
			ls_marca = dw_3.getitemstring(1,'nivel5')
			if right(ls_marca,3) = '...' then
				for i = 2 to dw_9.rowcount()
					li_check = this.getitemnumber(i,'li_check')
					if li_check = 1 then
						ls_marca = this.getitemstring(i,'prod_nivel5')
						if ls_cadena_marca = '' then
							ls_cadena_marca = ls_marca
						else
							ls_cadena_marca = ls_cadena_marca + '...'
							exit
						end if
					end if
				next
				dw_3.setitem(1,'nivel5',ls_cadena_marca)
			else
				dw_3.setitem(1,'nivel5','')
			end if
		end if

	end if
end if


end event

event buttonclicked;dw_9.visible = false

end event

event clicked;integer li_check, i
string ls_text, ls_campo
this.accepttext()

dw_7.visible = false
dw_8.visible = false
dw_20.visible = false
dw_21.visible = false
dw_12.visible = false
dw_11.visible = false

if row = 0 then return

string ls_marca, ls_cadena_marca
if this.getcolumnname() = 'li_check' then
	if this.getrow() = 1 then
		li_check = this.getitemnumber(1,'li_check')
		for i = 1 to this.rowcount()
			this.setitem(i,'li_check',li_check)
		next
		if li_check = 0 then
			dw_3.setitem(1,'nivel5','')			
		else
			dw_3.setitem(1,'nivel5',this.getitemstring(2,'prod_nivel5')+'...')
		end if
		return
	else
		if this.getitemnumber(this.getrow(),'li_check') = 1 then
			ls_marca = dw_3.getitemstring(1,'nivel5')
			if ls_marca = '' or isnull(ls_marca) then
				dw_3.setitem(1,'nivel5',this.getitemstring(this.getrow(),'prod_nivel5'))
			else
				if right(ls_marca,3) <> '...' then
					dw_3.setitem(1,'nivel5',ls_marca + '...')
				end if
			end if
		else
			ls_marca = dw_3.getitemstring(1,'nivel5')
			if right(ls_marca,3) = '...' then
				for i = 2 to dw_9.rowcount()
					li_check = this.getitemnumber(i,'li_check')
					if li_check = 1 then
						ls_marca = this.getitemstring(i,'prod_nivel5')
						if ls_cadena_marca = '' then
							ls_cadena_marca = ls_marca
						else
							ls_cadena_marca = ls_cadena_marca + '...'
							exit
						end if
					end if
				next
				dw_3.setitem(1,'nivel5',ls_cadena_marca)
			else
				dw_3.setitem(1,'nivel5','')
			end if
		end if

	end if
end if
end event

event itemchanged;this.accepttext()
this.postevent('ue_post_item')
end event

type dw_10 from datawindow within w_catalogos
event ue_post_item ( )
boolean visible = false
integer x = 1454
integer y = 268
integer width = 1431
integer height = 1452
integer taborder = 11
boolean bringtotop = true
string title = "none"
string dataobject = "dw_descripciones_check"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_post_item();integer i, li_check
string ls_descrip, ls_cadena_descrip
if this.getcolumnname() = 'li_check' then
	if this.getrow() = 1 then
		this.setitem(1,'li_check',0)
		dw_3.setitem(1,'descripcion','')			
		return
	else
		if this.getitemnumber(this.getrow(),'li_check') = 1 then
			ls_descrip = dw_3.getitemstring(1,'descripcion')
			if ls_descrip = '' or isnull(ls_descrip) then
				dw_3.setitem(1,'descripcion',this.getitemstring(this.getrow(),'deta_desc_eng'))
			else
				if right(ls_descrip,3) <> '...' then
					dw_3.setitem(1,'descripcion',ls_descrip + '...')
				end if
			end if
		else
			ls_descrip = dw_3.getitemstring(1,'descripcion')
			if right(ls_descrip,3) = '...' then
				for i = 1 to dw_10.rowcount()
					li_check = this.getitemnumber(i,'li_check')
					if li_check = 1 then
						ls_descrip = this.getitemstring(i,'deta_desc_eng')
						if ls_cadena_descrip = '' then
							ls_cadena_descrip = ls_descrip
						else
							ls_cadena_descrip = ls_cadena_descrip + '...'
							exit
						end if
					end if
				next
				dw_3.setitem(1,'descripcion',ls_cadena_descrip)
			else
				dw_3.setitem(1,'descripcion','')
			end if
		end if

	end if
end if
end event

event itemchanged;this.accepttext()

this.postevent('ue_post_item')
end event

event buttonclicked;dw_10.visible = false
end event

event clicked;integer li_check, i
string ls_text, ls_campo
this.accepttext()

dw_7.visible = false
dw_8.visible = false
dw_9.visible = false

if row = 0 then return

if dwo.name = 'deta_desc_eng' then
	li_check = this.getitemnumber(row,'li_check')
	if li_check = 0 then
		this.setitem(row,'li_check',1)
		if dw_3.getitemstring(1,'descripcion') = '' or isnull(dw_3.getitemstring(1,'descripcion')) then
			dw_3.setitem(1,'descripcion',this.getitemstring(row,'deta_desc_eng'))
		end if
	else
		this.setitem(row,'li_check',0)
		dw_3.setitem(1,'descripcion','')
	end if
else
	ls_text = this.getitemstring(row,'deta_desc_eng')
	if isnull(ls_text) then
		for i = 1 to this.rowcount()
			this.setitem(i,'li_check',0)
			dw_3.setitem(1,'descripcion','')
		next
		dw_10.accepttext()
		return 2
	end if
end if

end event

type dw_11 from datawindow within w_catalogos
event ue_post_item ( )
boolean visible = false
integer x = 1321
integer y = 172
integer width = 901
integer height = 1536
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "dw_nivel1_check"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_post_item();integer i, li_check
string ls_marca, ls_cadena_marca
if this.getcolumnname() = 'li_check' then
	if this.getrow() = 1 then
		li_check = this.getitemnumber(1,'li_check')
		for i = 1 to this.rowcount()
			this.setitem(i,'li_check',li_check)
		next
		if li_check = 0 then
			dw_3.setitem(1,'nivel1','')			
		else
			dw_3.setitem(1,'nivel1',this.getitemstring(2,'prod_nivel1')+'...')
		end if
		return
	else
		if this.getitemnumber(this.getrow(),'li_check') = 1 then
			ls_marca = dw_3.getitemstring(1,'nivel1')
			if ls_marca = '' or isnull(ls_marca) then
				dw_3.setitem(1,'nivel1',this.getitemstring(this.getrow(),'prod_nivel1'))
			else
				if right(ls_marca,3) <> '...' then
					dw_3.setitem(1,'nivel1',ls_marca + '...')
				end if
			end if
		else
			ls_marca = dw_3.getitemstring(1,'nivel1')
			if right(ls_marca,3) = '...' then
				for i = 2 to dw_11.rowcount()
					li_check = this.getitemnumber(i,'li_check')
					if li_check = 1 then
						ls_marca = this.getitemstring(i,'prod_nivel1')
						if ls_cadena_marca = '' then
							ls_cadena_marca = ls_marca
						else
							ls_cadena_marca = ls_cadena_marca + '...'
							exit
						end if
					end if
				next
				dw_3.setitem(1,'nivel1',ls_cadena_marca)
			else
				dw_3.setitem(1,'nivel1','')
			end if
		end if

	end if
end if


end event

event itemchanged;this.accepttext()

this.postevent('ue_post_item')
end event

event clicked;integer li_check, i
string ls_text, ls_campo
this.accepttext()

dw_7.visible = false
dw_8.visible = false
dw_9.visible = false
dw_12.visible = false
dw_21.visible = false

if row = 0 then return

string ls_marca, ls_cadena_marca
if this.getcolumnname() = 'li_check' then
	if this.getrow() = 1 then
		li_check = this.getitemnumber(1,'li_check')
		for i = 1 to this.rowcount()
			this.setitem(i,'li_check',li_check)
		next
		if li_check = 0 then
			dw_3.setitem(1,'nivel1','')			
		else
			dw_3.setitem(1,'nivel1',this.getitemstring(2,'prod_nivel1')+'...')
		end if
		return
	else
		if this.getitemnumber(this.getrow(),'li_check') = 1 then
			ls_marca = dw_3.getitemstring(1,'nivel1')
			if ls_marca = '' or isnull(ls_marca) then
				dw_3.setitem(1,'nivel1',this.getitemstring(this.getrow(),'prod_nivel1'))
			else
				if right(ls_marca,3) <> '...' then
					dw_3.setitem(1,'nivel1',ls_marca + '...')
				end if
			end if
		else
			ls_marca = dw_3.getitemstring(1,'nivel1')
			if right(ls_marca,3) = '...' then
				for i = 2 to dw_7.rowcount()
					li_check = this.getitemnumber(i,'li_check')
					if li_check = 1 then
						ls_marca = this.getitemstring(i,'prod_nivel1')
						if ls_cadena_marca = '' then
							ls_cadena_marca = ls_marca
						else
							ls_cadena_marca = ls_cadena_marca + '...'
							exit
						end if
					end if
				next
				dw_3.setitem(1,'nivel1',ls_cadena_marca)
			else
				dw_3.setitem(1,'nivel1','')
			end if
		end if

	end if
end if
end event

event buttonclicked;dw_11.visible = false
end event

type dw_12 from datawindow within w_catalogos
event ue_post_item ( )
boolean visible = false
integer x = 1321
integer y = 260
integer width = 942
integer height = 1408
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "dw_nivel2_check"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_post_item();integer i, li_check
string ls_marca, ls_cadena_marca
if this.getcolumnname() = 'li_check' then
	if this.getrow() = 1 then
		li_check = this.getitemnumber(1,'li_check')
		for i = 1 to this.rowcount()
			this.setitem(i,'li_check',li_check)
		next
		if li_check = 0 then
			dw_3.setitem(1,'nivel2','')			
		else
			dw_3.setitem(1,'nivel2',this.getitemstring(2,'prod_nivel2')+'...')
		end if
		return
	else
		if this.getitemnumber(this.getrow(),'li_check') = 1 then
			ls_marca = dw_3.getitemstring(1,'nivel2')
			if ls_marca = '' or isnull(ls_marca) then
				dw_3.setitem(1,'nivel2',this.getitemstring(this.getrow(),'prod_nivel2'))
			else
				if right(ls_marca,3) <> '...' then
					dw_3.setitem(1,'nivel2',ls_marca + '...')
				end if
			end if
		else
			ls_marca = dw_3.getitemstring(1,'nivel2')
			if right(ls_marca,3) = '...' then
				for i = 2 to dw_12.rowcount()
					li_check = this.getitemnumber(i,'li_check')
					if li_check = 1 then
						ls_marca = this.getitemstring(i,'prod_nivel2')
						if ls_cadena_marca = '' then
							ls_cadena_marca = ls_marca
						else
							ls_cadena_marca = ls_cadena_marca + '...'
							exit
						end if
					end if
				next
				dw_3.setitem(1,'nivel2',ls_cadena_marca)
			else
				dw_3.setitem(1,'nivel2','')
			end if
		end if

	end if
end if


end event

event itemchanged;this.accepttext()

this.postevent('ue_post_item')
end event

event buttonclicked;dw_12.visible = false
end event

event clicked;integer li_check, i
string ls_text, ls_campo
this.accepttext()

dw_7.visible = false
dw_8.visible = false
dw_9.visible = false
dw_11.visible = false
dw_21.visible = false

if row = 0 then return

string ls_marca, ls_cadena_marca
if this.getcolumnname() = 'li_check' then
	if this.getrow() = 1 then
		li_check = this.getitemnumber(1,'li_check')
		for i = 1 to this.rowcount()
			this.setitem(i,'li_check',li_check)
		next
		if li_check = 0 then
			dw_3.setitem(1,'nivel2','')			
		else
			dw_3.setitem(1,'nivel2',this.getitemstring(2,'prod_nivel2')+'...')
		end if
		return
	else
		if this.getitemnumber(this.getrow(),'li_check') = 1 then
			ls_marca = dw_3.getitemstring(1,'nivel2')
			if ls_marca = '' or isnull(ls_marca) then
				dw_3.setitem(1,'nivel2',this.getitemstring(this.getrow(),'prod_nivel2'))
			else
				if right(ls_marca,3) <> '...' then
					dw_3.setitem(1,'nivel2',ls_marca + '...')
				end if
			end if
		else
			ls_marca = dw_3.getitemstring(1,'nivel2')
			if right(ls_marca,3) = '...' then
				for i = 2 to dw_7.rowcount()
					li_check = this.getitemnumber(i,'li_check')
					if li_check = 1 then
						ls_marca = this.getitemstring(i,'prod_nivel2')
						if ls_cadena_marca = '' then
							ls_cadena_marca = ls_marca
						else
							ls_cadena_marca = ls_cadena_marca + '...'
							exit
						end if
					end if
				next
				dw_3.setitem(1,'nivel2',ls_cadena_marca)
			else
				dw_3.setitem(1,'nivel2','')
			end if
		end if

	end if
end if
end event

type dw_13 from datawindow within w_catalogos
event ue_post_item ( )
boolean visible = false
integer x = 3570
integer y = 268
integer width = 873
integer height = 844
integer taborder = 21
boolean bringtotop = true
string title = "none"
string dataobject = "dw_compradores_check"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_post_item();integer i, li_check
string ls_descrip, ls_cadena_descrip
if this.getcolumnname() = 'li_check' then
	if this.getrow() = 1 then
		this.setitem(1,'li_check',0)
		dw_3.setitem(1,'comprador','')			
		return
	else
		if this.getitemnumber(this.getrow(),'li_check') = 1 then
			ls_descrip = dw_3.getitemstring(1,'comprador')
			if ls_descrip = '' or isnull(ls_descrip) then
				dw_3.setitem(1,'comprador',this.getitemstring(this.getrow(),'nombre'))
			else
				if right(ls_descrip,3) <> '...' then
					dw_3.setitem(1,'comprador',ls_descrip + '...')
				end if
			end if
		else
			ls_descrip = dw_3.getitemstring(1,'comprador')
			if right(ls_descrip,3) = '...' then
				for i = 1 to dw_13.rowcount()
					li_check = this.getitemnumber(i,'li_check')
					if li_check = 1 then
						ls_descrip = this.getitemstring(i,'nombre')
						if ls_cadena_descrip = '' then
							ls_cadena_descrip = ls_descrip
						else
							ls_cadena_descrip = ls_cadena_descrip + '...'
							exit
						end if
					end if
				next
				dw_3.setitem(1,'comprador',ls_cadena_descrip)
			else
				dw_3.setitem(1,'comprador','')
			end if
		end if

	end if
end if
end event

event itemchanged;this.accepttext()

this.postevent('ue_post_item')
end event

event clicked;integer li_check, i
string ls_text, ls_campo
this.accepttext()

dw_7.visible = false
dw_8.visible = false
dw_9.visible = false

if row = 0 then return

if dwo.name = 'nombre' then
	li_check = this.getitemnumber(row,'li_check')
	if li_check = 0 then
		this.setitem(row,'li_check',1)
		if dw_3.getitemstring(1,'comprador') = '' or isnull(dw_3.getitemstring(1,'comprador')) then
			dw_3.setitem(1,'definicion',this.getitemstring(row,'nombre'))
		end if
	else
		this.setitem(row,'li_check',0)
		dw_3.setitem(1,'comprador','')
	end if
else
	ls_text = this.getitemstring(row,'nombre')
	if isnull(ls_text) then
		for i = 1 to this.rowcount()
			this.setitem(i,'li_check',0)
			dw_3.setitem(1,'comprador','')
		next
		dw_13.accepttext()
		return 2
	end if
end if

end event

event buttonclicked;dw_13.visible = false
end event

type cb_3 from commandbutton within w_catalogos
boolean visible = false
integer x = 5431
integer y = 40
integer width = 343
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Kardex"
end type

event clicked;DateTime dt_fecha1,dt_fecha2,dt_anterior,dt_posterior
date fecha_final, fecha_inicial
Time     tiempo1 = 00:00:00, tiempo2 = 23:59:59

dw_14.object.datawindow.print.preview = 'yes'		

/////////////////////////////////////////////////////////////
fecha_final   = Date(gf_fecha_serv())
fecha_inicial = Date('01/01/1999')
dt_fecha1    =  DateTime (fecha_inicial,tiempo1)
dt_fecha2    =  DateTime (fecha_final,tiempo2)
dt_anterior  =  DateTime (date("01/01/1980"),tiempo1)
dt_posterior =  DateTime (relativedate(fecha_inicial,-1),tiempo2)
//////////////recuperamos los datos//////////////////////////
dw_14.Retrieve(str.g_financiero,str.empresa,dt_fecha1,dt_fecha2)
dw_14.object.id.expression = "'"+ str.usuario +"'"

end event

type dw_14 from datawindow within w_catalogos
boolean visible = false
integer x = 46
integer y = 728
integer width = 4475
integer height = 1960
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "Kardex"
string dataobject = "dw_kardex_multiple"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "AppIcon!"
boolean livescroll = true
end type

event sqlpreview;string ls_syntax, ls_cadena_prod, ls_prod
integer i

ls_syntax = sqlsyntax
ls_cadena_prod = ''
for i = 1 to dw_1.rowcount()
	yield()
	w_fa_frame.setmicrohelp("Buscando Kardex de Items " + string(i) + " de " + string(dw_1.rowcount() ) )
	if dw_1.getitemnumber(i,'incluir') = 1 then
		ls_prod = dw_1.getitemstring(i,'prod_producto')
		if ls_cadena_prod = '' then
			ls_cadena_prod = ls_cadena_prod + ' and ( prod_producto = "'+ls_prod+'"'
		else
			ls_cadena_prod = ls_cadena_prod + ' or prod_producto = "'+ls_prod+'"'			
		end if
	end if
next
if ls_cadena_prod <> '' then 
	ls_cadena_prod = ls_cadena_prod + ') '
else
	ls_cadena_prod = ls_cadena_prod + ' and ( prod_producto = "----") '
end if
ls_syntax = ls_syntax + ls_cadena_prod
this.setsqlpreview(ls_syntax)
this.visible = true
end event

event retrieveend;decimal ld_reserva_total, ld_total, ld_conversion, ld_disponible, ld_exis_total, ld_exis_frac_total , ld_fraccion, ld_disponible_fraccion 
string ls_prod, ls_medida, ls_codigo_secundario
integer i
decimal{2} ld_precio_c, ldec_costo_cif, ld_costo, ld_promedio, ld_margen
string ls_temp
decimal{2} ld_monto_vendido = 0, ld_cantidad_vendida = 0, ld_monto_vendido_ped, ld_cantidad_vendida_ped, ld_monto_vendido_fac, ld_cantidad_vendida_fac, &
				   ld_costo_ped, ld_precio_ped, ld_costo_fac, ld_precio_fac, ld_costo_inv, ld_precio_inv, ld_total_nc, ld_porc_nc
ls_temp = ''
for i = 1 to rowcount
		if this.rowcount() > 0 then		
			ld_exis_total 	   = truncate(this.getitemnumber(i,"total1") ,0)
			ld_exis_frac_total = truncate(this.getitemnumber(i,"total2") ,0)
		else
			ld_exis_total = 0
			ld_exis_frac_total = 0
			return
		end if	
		
	 //Recupera la reserva total y la asigna
	    ld_reserva_total = 0
		ls_prod = this.getitemstring(i,'dmov_producto')
		ls_medida = this.getitemstring(i,'dmov_unidad_medida')
		if ls_prod <> ls_temp then
			dw_15.retrieve(str.g_financiero, str.empresa, ls_prod)
		end if
		
		if dw_15.rowcount() > 0 then
			ld_reserva_total = dw_15.getitemnumber(1,'reserva_total')
			if isnull(ld_reserva_total) then ld_reserva_total = 0
			ld_conversion	  = gf_unidad_venta(ls_medida, 10)
			if ld_reserva_total > 0 then
				ld_total			  = truncate( ld_reserva_total / ld_conversion, 0)
			else
				ld_total = 0
			end if
			this.setitem(i,"reserva",ld_total)
			ld_disponible 		=  ld_exis_total - ld_total
			this.setitem(i,"disponible",ld_disponible)
			
			ld_fraccion = truncate(((ld_reserva_total / ld_conversion) - truncate( ld_reserva_total / ld_conversion ,0 )) * ld_conversion,0)
			if isnull(ld_fraccion) then ld_fraccion = 0
			if ld_fraccion > 0 then
				this.setitem(i,"reserva_fraccion",ld_fraccion)			
			else
				this.setitem(i,"reserva_fraccion",0)	
			end if
			
			ld_disponible_fraccion = ld_exis_frac_total - ld_fraccion
			if ld_disponible_fraccion > 0 then
				this.setitem(i,"disponible_fraccion",ld_disponible_fraccion)			
			else
				this.setitem(i,"disponible_fraccion",0)
			end if			
		else
			this.setitem(i,"reserva",0)
			this.setitem(i,"reserva_fraccion",0)
			this.setitem(i,"disponible",ld_exis_total)
			if ld_exis_frac_total > 0 then 
				this.setitem(i,"disponible_fraccion",ld_exis_frac_total)
			else
				this.setitem(i,"disponible_fraccion",0)
			end if
		end if	

		if ls_prod <> ls_temp then
			 DECLARE cur_en CURSOR FOR  
			  SELECT isnull(dmov_costo_fob ,0) 
			 FROM indmovim,   
					intmovim  
			WHERE ( intmovim.tmov_g_financiero = indmovim.dmov_g_financiero ) and  
					( intmovim.tmov_empresa = indmovim.dmov_empresa ) and  
					( intmovim.tmov_aplicacion = indmovim.dmov_aplicacion ) and  
					( intmovim.tmov_tipo_transaccion = indmovim.dmov_tipo_transaccion ) and  
					( intmovim.tmov_secuencia = indmovim.dmov_secuencia ) and  
					( intmovim.tmov_anual = indmovim.dmov_anual ) and  
					( intmovim.tmov_concepto = indmovim.dmov_concepto ) and  
					( ( indmovim.dmov_g_financiero = :str.g_financiero ) AND  
					( indmovim.dmov_empresa = :str.empresa ) AND  
					( indmovim.dmov_aplicacion = 'IN' ) AND  
					( indmovim.dmov_tipo_transaccion = 'EN' ) AND  
					( indmovim.dmov_producto = :ls_prod ) )   ORDER BY intmovim.tmov_fecha Desc  ;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al buscar costo '+sqlca.sqlerrtext,1,1,'E')
						end if
	
			open cur_en;
			fetch cur_en into :ld_costo;
			close cur_en;		
			
			//Valor del descuento por nota de credito
		  SELECT isnull(max(notascr_detalle.total),0), isnull(max(notascr_detalle.porciento),0)
			  into :ld_total_nc, :ld_porc_nc
			 FROM notascr_detalle,   
					notascr_encab
			WHERE ( notascr_encab.g_financiero = notascr_detalle.g_financiero ) and  
					( notascr_encab.empresa = notascr_detalle.empresa ) and  
					( notascr_encab.documento = notascr_detalle.documento ) and  
					( notascr_encab.ann = notascr_detalle.ann ) and  
					( ( notascr_detalle.g_financiero = :str.g_financiero ) AND  
					( notascr_detalle.empresa = :str.empresa ) AND  
					( notascr_detalle.item = :ls_prod ) )    ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al buscar Descuento  '+ sqlca.sqlerrtext,1,1,'E')
					end if
			
			ls_codigo_secundario = this.getitemstring(i,'inmprodu_prod_producto_dos')
			if ls_codigo_secundario <> '' and not isnull(ls_codigo_secundario) then
				wf_asigna_codigos_alternos(ls_prod, ls_codigo_secundario,i)
			end if
			
		end if
		this.setitem(i,'costo_entrada', ld_costo)			
		
		if ld_total_nc > 0 then
			this.setitem(i,'descuento',string(ld_total_nc,'#,##0.00'))
			this.setitem(i,'porc_descuento',string(ld_porc_nc,'#,##0.##')+'%')				
		else
			this.setitem(i,'descuento','')
			this.setitem(i,'porc_descuento','')
		end if

		
		/**/
		if ls_temp <> ls_prod then
		
			SELECT isnull(convert(numeric(8,2), sum(dmov_precio_original  * dmov_cantidad)),0),
					 isnull(convert(numeric(8,2), sum(dmov_cantidad)),0),
					 isnull(convert(numeric(12,6), sum(prod_costo_fob  * dmov_cantidad)),0),  
					 isnull(sum(dmov_precio_original * dmov_cantidad),0)				 
			into :ld_monto_vendido, :ld_cantidad_vendida, :ld_costo_inv, :ld_precio_inv
			 FROM intmovim, indmovim, inmprodu
			WHERE ( indmovim.dmov_g_financiero = intmovim.tmov_g_financiero ) and  
					( indmovim.dmov_empresa = intmovim.tmov_empresa ) and  
					( indmovim.dmov_aplicacion = intmovim.tmov_aplicacion ) and  
					( indmovim.dmov_tipo_transaccion = intmovim.tmov_tipo_transaccion ) and  
					( indmovim.dmov_concepto = intmovim.tmov_concepto ) and  
					( indmovim.dmov_secuencia = intmovim.tmov_secuencia ) and  
					( indmovim.dmov_anual = intmovim.tmov_anual ) and
					( indmovim.dmov_g_financiero = inmprodu.prod_g_financiero ) AND
					( indmovim.dmov_empresa = inmprodu.prod_empresa ) AND
					( indmovim.dmov_producto = inmprodu.prod_producto ) AND
					( indmovim.dmov_g_financiero = :str.g_financiero ) AND  
					( indmovim.dmov_empresa = :str.empresa ) AND  
					( indmovim.dmov_tipo_transaccion in ('SA','FA')) AND
					( indmovim.dmov_producto = :ls_prod ) ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al buscar promedio '+ sqlca.sqlerrtext,1,1,'E')
					end if
	
	
				SELECT isnull(convert(numeric(8,2), sum(dped_precio_original  * dped_cantidad)),0),
							isnull(convert(numeric(8,2), sum(dped_cantidad)),0),
							 isnull(convert(numeric(12,6), sum(prod_costo_fob  * dped_cantidad)),0),
							 isnull(sum(dped_precio_original * dped_cantidad),0)
				into :ld_monto_vendido_ped, :ld_cantidad_vendida_ped, :ld_costo_ped, :ld_precio_ped
				 FROM fadpedid, inmprodu
				WHERE  ( fadpedid.dped_g_financiero = inmprodu.prod_g_financiero ) AND
						( fadpedid.dped_empresa = inmprodu.prod_empresa ) AND
						( fadpedid.dped_codigo_item = inmprodu.prod_producto ) AND
						( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
						( fadpedid.dped_empresa = :str.empresa ) AND  
						( fadpedid.dped_pasada = 0) AND
						( fadpedid.dped_codigo_item = :ls_prod ) ;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al buscar promedio '+ sqlca.sqlerrtext,1,1,'E')
						end if
		
				SELECT isnull(convert(numeric(8,2), sum(facd_precio_original  * facd_cantidad)),0),
						 isnull(convert(numeric(8,2), sum(facd_cantidad)),0),
						 isnull(convert(numeric(12,6), sum(prod_costo_fob  * facd_cantidad)),0),
						 isnull(sum(facd_precio_original * facd_cantidad),0)
				into :ld_monto_vendido_fac, :ld_cantidad_vendida_fac, :ld_costo_fac, :ld_precio_fac
				 FROM faddiari, fatdiari, inmprodu
				WHERE  ( faddiari.facd_g_financiero = inmprodu.prod_g_financiero ) AND
							( faddiari.facd_empresa = inmprodu.prod_empresa ) AND
							( faddiari.facd_codigo_item = inmprodu.prod_producto ) AND
							 ( faddiari.facd_g_financiero = fatdiari.fact_g_financiero ) and  
							( faddiari.facd_empresa = fatdiari.fact_empresa ) and  
							( faddiari.facd_tipo = fatdiari.fact_tipo ) and  
							( faddiari.facd_no_pedido = fatdiari.fact_no_pedido ) and  
							( faddiari.facd_ann = fatdiari.fact_ann ) and  
							( fatdiari.fact_estado = 'A' ) and
							( faddiari.facd_g_financiero = :str.g_financiero ) AND  
							( faddiari.facd_empresa = :str.empresa ) AND  
							( faddiari.facd_codigo_item = :ls_prod ) ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al buscar promedio '+ sqlca.sqlerrtext,1,1,'E')
							end if
		
			if  (ld_cantidad_vendida + ld_cantidad_vendida_ped + ld_cantidad_vendida_fac) > 0 then
				ld_promedio = (ld_monto_vendido + ld_monto_vendido_ped + ld_monto_vendido_fac) / (ld_cantidad_vendida + ld_cantidad_vendida_ped + ld_cantidad_vendida_fac)
			else
				ld_promedio = 0.00
			end if
			
			if (ld_precio_ped + ld_precio_fac + ld_precio_inv) > 0 then
				ld_margen   =  round((1 -  ((ld_costo_ped + ld_costo_fac + ld_costo_inv)  / (ld_precio_ped + ld_precio_fac + ld_precio_inv ))) * 100,2)
			else
				ld_margen = 0
			end if
		
		//PARA QUE VALIDE CUANDO ES DIFERENTE EL PRODUCTO
		ls_temp = ls_prod		
			
	end if	
		//string(round((1 - ( tot_costos_venta) /  tot_precios_venta ) * 100,2))+"%"
	//Busca el valor del margen y lo asigna al encabezado
	this.setitem(i,'margen_promedio', string(ld_margen)+'%')
	//Asigna el Precio Promedio
	this.setitem(i,'precio_promedio',ld_promedio)			

next
end event

type dw_15 from datawindow within w_catalogos
boolean visible = false
integer x = 5102
integer y = 400
integer width = 686
integer height = 400
integer taborder = 11
boolean bringtotop = true
string title = "none"
string dataobject = "dw_fa_rep_reservados"
boolean livescroll = true
end type

type cbx_ambas from checkbox within w_catalogos
boolean visible = false
integer x = 4475
integer y = 2236
integer width = 713
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mostrar Ambas Fotos"
end type

event clicked;if cbx_ambas.checked then
	dw_16.modify('prod_foto_back.visible=true')
	dw_16.modify('prod_foto_dir.visible=true')
	dw_16.modify('prod_foto_dir.x=151')
	dw_16.modify('prod_foto_back.x=151')
	dw_16.modify('prod_foto_dir.y=120')
	dw_16.modify('prod_foto_back.y=1840')
	dw_16.modify('prod_foto_dir.width=1920')
	dw_16.modify('prod_foto_back.width=1920')
	dw_16.modify('prod_foto_dir.height=1648')
	dw_16.modify('prod_foto_back.height=1648')
	
else
	dw_16.modify('prod_foto_dir.x=151')
	dw_16.modify('prod_foto_back.x=151')
	dw_16.modify('prod_foto_dir.y=120')
	dw_16.modify('prod_foto_back.y=120')
	dw_16.modify('prod_foto_dir.width=2875')
	dw_16.modify('prod_foto_back.width=2875')
	dw_16.modify('prod_foto_dir.height=2828')
	dw_16.modify('prod_foto_back.height=2828')
	if cb_back.text = 'Back' then
		dw_16.modify('prod_foto_back.visible=false')
		dw_16.modify('prod_foto_dir.visible=true')
	else
		dw_16.modify('prod_foto_dir.visible=false')
		dw_16.modify('prod_foto_back.visible=true')
	end if
end if
end event

type dw_16 from datawindow within w_catalogos
boolean visible = false
integer x = 462
integer y = 436
integer width = 3433
integer height = 2048
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Fotos del Producto"
string dataobject = "dw_impresion_fotos_por_grupo"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean vscrollbar = true
string icon = "EAServerProfile!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_catalogos
boolean visible = false
integer x = 4480
integer y = 2328
integer width = 978
integer height = 100
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Imprimir Grupo"
end type

event clicked;	integer i, j
	string ls_producto, ls_productos[]
	j = 0
	setpointer(hourglass!)
	for i = 1 to dw_1.rowcount()
		yield()
		if dw_1.getitemnumber(i,'incluir') = 1 then
			j ++
			ls_producto = dw_1.getitemstring(i,'prod_producto')
			ls_productos[j] = ls_producto
		end if
	next
	if upperbound(ls_productos) = 0 then
		gf_mensaje('','Debe Seleccionar el Producto a Imprimir, Verifique !!!',1,1,'E')
		return
	end if
	setpointer(Arrow!)
	if dw_16.retrieve(str.g_financiero, str.empresa, ls_productos) = 0 then return
	dw_16.Object.datawindow.print.preview = true
	dw_16.visible = true
	OpenWithParm(w_dw_print_options, dw_16)
	If Message.DoubleParm = -1 Then Return
	//dw_16.Modify("DataWindow.Zoom='80'")
	dw_16.Print(True)

end event

type cb_back from commandbutton within w_catalogos
boolean visible = false
integer x = 5198
integer y = 2212
integer width = 343
integer height = 100
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Back"
end type

event clicked;if cb_back.text = 'Back' then
	cb_back.text = 'Foto'
	dw_16.modify('prod_foto_back.visible=true')
	dw_16.modify('prod_foto_dir.visible=false')
else
	cb_back.text = 'Back'
	dw_16.modify('prod_foto_dir.visible=true')
	dw_16.modify('prod_foto_back.visible=false')
end if

end event

type cbx_recalcula_cantidad from checkbox within w_catalogos
boolean visible = false
integer x = 5751
integer y = 96
integer width = 786
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Rec. Cantidades"
end type

type cbx_ocultar_costo from checkbox within w_catalogos
boolean visible = false
integer x = 4475
integer y = 2452
integer width = 887
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ocultar Costo y Precio Promedio"
end type

type cbx_imprimir_b from checkbox within w_catalogos
boolean visible = false
integer x = 5751
integer y = 8
integer width = 590
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Imprimir Reporte B"
end type

event clicked;if this.checked then
	dw_5.dataobject = 'dw_inf_inventario_x_fecha_b'
else
	dw_5.dataobject = 'dw_inf_inventario_x_fecha'
	cbx_ver_costo_leo.checked = false
end if
dw_5.settransobject(sqlca)
dw_1.sharedata(dw_5)
if cbx_ver_costo_leo.checked and this.checked then
	dw_5.object.costo_l.visible = 1
	dw_5.object.prod_costo_fob.visible = 0
else
//	dw_5.object.costo_l.visible = 0
//	dw_5.object.prod_costo_fob.visible = 1
	
end if
end event

type cbx_ver_proveedor from checkbox within w_catalogos
boolean visible = false
integer x = 5751
integer y = 180
integer width = 590
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ver Proveedor"
end type

event clicked;//prod_proveedor
if this.checked then
	if not cbx_1.checked then
		dw_1.modify("prod_proveedor.X='11410'")
		dw_1.modify("prod_proveedor_t.X='11410'")
		dw_1.modify("mfr_name.X='11602'")
		dw_1.modify("mfr_name_t.X='11602'")	
		dw_1.modify("b_proveedor.X='12197'")	
	else
//		dw_1.modify("prod_proveedor.X='10811'")
//		dw_1.modify("prod_proveedor_t.X='10811'")
//		dw_1.modify("mfr_name.X='11003'")
//		dw_1.modify("mfr_name_t.X='11003'")	
//		dw_1.modify("b_proveedor.X='11602'")	

		dw_1.modify("prod_proveedor.X='11781'")
		dw_1.modify("prod_proveedor_t.X='11781'")
		dw_1.modify("mfr_name.X='11968'")
		dw_1.modify("mfr_name_t.X='11968'")
		dw_1.modify("b_proveedor.X='12567'")
		
	end if
	dw_1.modify('prod_proveedor.visible=true')
	dw_1.modify('prod_proveedor_t.visible=true')
	dw_1.modify('mfr_name.visible=true')
	dw_1.modify('mfr_name_t.visible=true')	
	dw_1.modify('b_proveedor.visible=true')	
else
	dw_1.modify('prod_proveedor.visible=false')
	dw_1.modify('prod_proveedor_t.visible=false')
	dw_1.modify('mfr_name.visible=false')
	dw_1.modify('mfr_name_t.visible=false')	
	dw_1.modify('b_proveedor.visible=false')		
	dw_1.modify("prod_proveedor.X='10249'")
	dw_1.modify("prod_proveedor_t.X='10249'")
	dw_1.modify("mfr_name.X='10437'")
	dw_1.modify("mfr_name_t.X='10437'")			
end if
end event

type cb_5 from commandbutton within w_catalogos
boolean visible = false
integer x = 4480
integer y = 2560
integer width = 978
integer height = 100
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Imprimir Seleccion"
end type

event clicked;	dw_1.setfilter('incluir = 1')
	dw_1.filter()
	if dw_1.rowcount() = 0 then
		gf_mensaje('','Debe Seleccionar Los Registros a Imprimir',1,1,'E')
		dw_1.setfilter('')
		dw_1.filter()
		return
	end if
	dw_5.Modify("DataWindow.Zoom='80'")
	OpenWithParm(w_dw_print_options, dw_5)
	If Message.DoubleParm = -1 Then Return
	//dw_16.Modify("DataWindow.Zoom='80'")
	dw_5.Print(True)
	dw_1.setfilter('')
	dw_1.filter()
end event

type dw_19 from datawindow within w_catalogos
event ue_post_item ( )
boolean visible = false
integer x = 3570
integer y = 348
integer width = 891
integer height = 1040
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "dw_pattern_check"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_post_item();integer i, li_check
string ls_tipo, ls_cadena_tipo
if this.getcolumnname() = 'li_check' then
	if this.getrow() = 1 then
		this.setitem(1,'li_check',0)
		dw_3.setitem(1,'pattern','')			
		return
	else
		if this.getitemnumber(this.getrow(),'li_check') = 1 then
			ls_tipo = dw_3.getitemstring(1,'pattern')
			if ls_tipo = '' or isnull(ls_tipo) then
				dw_3.setitem(1,'pattern',this.getitemstring(this.getrow(),'prod_pattern'))
			else
				if right(ls_tipo,3) <> '...' then
					dw_3.setitem(1,'pattern',ls_tipo + '...')
				end if
			end if
		else
			ls_tipo = dw_3.getitemstring(1,'pattern')
			if right(ls_tipo,3) = '...' then
				for i = 1 to dw_19.rowcount()
					li_check = this.getitemnumber(i,'li_check')
					if li_check = 1 then
						ls_tipo = this.getitemstring(i,'prod_pattern')
						if ls_cadena_tipo = '' then
							ls_cadena_tipo = ls_tipo
						else
							ls_cadena_tipo = ls_cadena_tipo + '...'
							exit
						end if
					end if
				next
				dw_3.setitem(1,'pattern',ls_cadena_tipo)
			else
				dw_3.setitem(1,'pattern','')
			end if
		end if

	end if
end if
end event

event buttonclicked;dw_19.visible = false
end event

event clicked;integer li_check, i
string ls_text, ls_campo
this.accepttext()

dw_7.visible = false
dw_8.visible = false
dw_9.visible = false
dw_20.visible = false
dw_21.visible = false
dw_22.visible = false

if row = 0 then return

if dwo.name = 'prod_pattern' then
	li_check = this.getitemnumber(row,'li_check')
	if li_check = 0 then
		this.setitem(row,'li_check',1)
		if dw_3.getitemstring(1,'pattern') = '' or isnull(dw_3.getitemstring(1,'pattern')) then
			dw_3.setitem(1,'pattern',this.getitemstring(row,'prod_pattern'))
		end if
	else
		this.setitem(row,'li_check',0)
		dw_3.setitem(1,'pattern','')
	end if
else
	ls_text = this.getitemstring(row,'prod_pattern')
	if isnull(ls_text) then
		for i = 1 to this.rowcount()
			this.setitem(i,'li_check',0)
			dw_3.setitem(1,'pattern','')
		next
		dw_19.accepttext()
		return 2
	end if
end if

end event

event itemchanged;this.accepttext()
this.postevent('ue_post_item')
end event

type dw_20 from datawindow within w_catalogos
event ue_post_item ( )
boolean visible = false
integer x = 2478
integer y = 512
integer width = 786
integer height = 876
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "dw_position_print_check"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_post_item();integer i, li_check
string ls_tipo, ls_cadena_tipo
if this.getcolumnname() = 'li_check' then
	if this.getrow() = 1 then
		this.setitem(1,'li_check',0)
		dw_3.setitem(1,'position_print','')			
		return
	else
		if this.getitemnumber(this.getrow(),'li_check') = 1 then
			ls_tipo = dw_3.getitemstring(1,'position_print')
			if ls_tipo = '' or isnull(ls_tipo) then
				dw_3.setitem(1,'position_print',this.getitemstring(this.getrow(),'prod_position_print'))
			else
				if right(ls_tipo,3) <> '...' then
					dw_3.setitem(1,'position_print',ls_tipo + '...')
				end if
			end if
		else
			ls_tipo = dw_3.getitemstring(1,'position_print')
			if right(ls_tipo,3) = '...' then
				for i = 1 to dw_20.rowcount()
					li_check = this.getitemnumber(i,'li_check')
					if li_check = 1 then
						ls_tipo = this.getitemstring(i,'prod_position_print')
						if ls_cadena_tipo = '' then
							ls_cadena_tipo = ls_tipo
						else
							ls_cadena_tipo = ls_cadena_tipo + '...'
							exit
						end if
					end if
				next
				dw_3.setitem(1,'position_print',ls_cadena_tipo)
			else
				dw_3.setitem(1,'position_print','')
			end if
		end if

	end if
end if
end event

event buttonclicked;dw_20.visible = false
end event

event clicked;integer li_check, i
string ls_text, ls_campo
this.accepttext()

dw_7.visible = false
dw_8.visible = false
dw_9.visible = false
dw_19.visible = false

if row = 0 then return

if dwo.name = 'prod_position_print' then
	li_check = this.getitemnumber(row,'li_check')
	if li_check = 0 then
		this.setitem(row,'li_check',1)
		if dw_3.getitemstring(1,'position_print') = '' or isnull(dw_3.getitemstring(1,'position_print')) then
			dw_3.setitem(1,'position_print',this.getitemstring(row,'prod_position_print'))
		end if
	else
		this.setitem(row,'li_check',0)
		dw_3.setitem(1,'position_print','')
	end if
else
	ls_text = this.getitemstring(row,'prod_position_print')
	if isnull(ls_text) then
		for i = 1 to this.rowcount()
			this.setitem(i,'li_check',0)
			dw_3.setitem(1,'position_print','')
		next
		dw_20.accepttext()
		return 2
	end if
end if

end event

event itemchanged;this.accepttext()
this.postevent('ue_post_item')
end event

type dw_21 from datawindow within w_catalogos
event ue_post_item ( )
boolean visible = false
integer x = 2482
integer y = 184
integer width = 937
integer height = 1560
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "dw_nivel4_check"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_post_item();integer i, li_check
string ls_marca, ls_cadena_marca
if this.getcolumnname() = 'li_check' then
	if this.getrow() = 1 then
		li_check = this.getitemnumber(1,'li_check')
		for i = 1 to this.rowcount()
			this.setitem(i,'li_check',li_check)
		next
		if li_check = 0 then
			dw_3.setitem(1,'nivel4','')			
		else
			dw_3.setitem(1,'nivel4',this.getitemstring(2,'prod_nivel4')+'...')
		end if
		return
	else
		if this.getitemnumber(this.getrow(),'li_check') = 1 then
			ls_marca = dw_3.getitemstring(1,'nivel4')
			if ls_marca = '' or isnull(ls_marca) then
				dw_3.setitem(1,'nivel4',this.getitemstring(this.getrow(),'prod_nivel4'))
			else
				if right(ls_marca,3) <> '...' then
					dw_3.setitem(1,'nivel4',ls_marca + '...')
				end if
			end if
		else
			ls_marca = dw_3.getitemstring(1,'nivel4')
			if right(ls_marca,3) = '...' then
				for i = 2 to dw_21.rowcount()
					li_check = this.getitemnumber(i,'li_check')
					if li_check = 1 then
						ls_marca = this.getitemstring(i,'prod_nivel4')
						if ls_cadena_marca = '' then
							ls_cadena_marca = ls_marca
						else
							ls_cadena_marca = ls_cadena_marca + '...'
							exit
						end if
					end if
				next
				dw_3.setitem(1,'nivel4',ls_cadena_marca)
			else
				dw_3.setitem(1,'nivel4','')
			end if
		end if

	end if
end if


end event

event buttonclicked;dw_21.visible = false
end event

event clicked;integer li_check, i
string ls_text, ls_campo
this.accepttext()

dw_7.visible = false
dw_8.visible = false
dw_9.visible = false
dw_20.visible = false
dw_12.visible = false
dw_11.visible = false

if row = 0 then return

string ls_marca, ls_cadena_marca
if this.getcolumnname() = 'li_check' then
	if this.getrow() = 1 then
		li_check = this.getitemnumber(1,'li_check')
		for i = 1 to this.rowcount()
			this.setitem(i,'li_check',li_check)
		next
		if li_check = 0 then
			dw_3.setitem(1,'nivel4','')			
		else
			dw_3.setitem(1,'nivel4',this.getitemstring(2,'prod_nivel4')+'...')
		end if
		return
	else
		if this.getitemnumber(this.getrow(),'li_check') = 1 then
			ls_marca = dw_3.getitemstring(1,'nivel4')
			if ls_marca = '' or isnull(ls_marca) then
				dw_3.setitem(1,'nivel4',this.getitemstring(this.getrow(),'prod_nivel4'))
			else
				if right(ls_marca,3) <> '...' then
					dw_3.setitem(1,'nivel4',ls_marca + '...')
				end if
			end if
		else
			ls_marca = dw_3.getitemstring(1,'nivel4')
			if right(ls_marca,3) = '...' then
				for i = 2 to dw_21.rowcount()
					li_check = this.getitemnumber(i,'li_check')
					if li_check = 1 then
						ls_marca = this.getitemstring(i,'prod_nivel4')
						if ls_cadena_marca = '' then
							ls_cadena_marca = ls_marca
						else
							ls_cadena_marca = ls_cadena_marca + '...'
							exit
						end if
					end if
				next
				dw_3.setitem(1,'nivel4',ls_cadena_marca)
			else
				dw_3.setitem(1,'nivel4','')
			end if
		end if

	end if
end if
end event

event itemchanged;this.accepttext()
this.postevent('ue_post_item')
end event

type dw_22 from datawindow within w_catalogos
event ue_post_item ( )
boolean visible = false
integer x = 2871
integer y = 436
integer width = 1006
integer height = 1040
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "dw_cliente_check"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_post_item();integer i, li_check
string ls_tipo, ls_cadena_tipo
if this.getcolumnname() = 'li_check' then
	if this.getrow() = 1 then
		this.setitem(1,'li_check',0)
		dw_3.setitem(1,'cliente','')			
		return
	else
		if this.getitemnumber(this.getrow(),'li_check') = 1 then
			ls_tipo = dw_3.getitemstring(1,'cliente')
			if ls_tipo = '' or isnull(ls_tipo) then
				dw_3.setitem(1,'cliente',this.getitemstring(this.getrow(),'terc_descripcion'))
			else
				if right(ls_tipo,3) <> '...' then
					dw_3.setitem(1,'cliente',ls_tipo + '...')
				end if
			end if
		else
			ls_tipo = dw_3.getitemstring(1,'cliente')
			if right(ls_tipo,3) = '...' then
				for i = 1 to dw_22.rowcount()
					li_check = this.getitemnumber(i,'li_check')
					if li_check = 1 then
						ls_tipo = this.getitemstring(i,'terc_descripcion')
						if ls_cadena_tipo = '' then
							ls_cadena_tipo = ls_tipo
						else
							ls_cadena_tipo = ls_cadena_tipo + '...'
							exit
						end if
					end if
				next
				dw_3.setitem(1,'cliente',ls_cadena_tipo)
			else
				dw_3.setitem(1,'cliente','')
			end if
		end if

	end if
end if
end event

event buttonclicked;dw_22.visible = false
end event

event clicked;integer li_check, i
string ls_text, ls_campo
this.accepttext()

dw_7.visible = false
dw_8.visible = false
dw_9.visible = false
dw_20.visible = false
dw_21.visible = false
dw_19.visible = false

if row = 0 then return

if dwo.name = 'terc_descripcion' then
	li_check = this.getitemnumber(row,'li_check')
	if li_check = 0 then
		this.setitem(row,'li_check',1)
		if dw_3.getitemstring(1,'cliente') = '' or isnull(dw_3.getitemstring(1,'cliente')) then
			dw_3.setitem(1,'cliente',this.getitemstring(row,'terc_descripcion'))
		end if
	else
		this.setitem(row,'li_check',0)
		dw_3.setitem(1,'cliente','')
	end if
else
	ls_text = this.getitemstring(row,'terc_descripcion')
	if isnull(ls_text) then
		for i = 1 to this.rowcount()
			this.setitem(i,'li_check',0)
			dw_3.setitem(1,'cliente','')
		next
		dw_22.accepttext()
		return 2
	end if
end if

end event

event itemchanged;this.accepttext()
this.postevent('ue_post_item')
end event

type cb_6 from commandbutton within w_catalogos
boolean visible = false
integer x = 4928
integer y = 328
integer width = 128
integer height = 80
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "RM"
end type

event clicked;if gf_mensaje('','Esta Seguro de Recalcular el Margen y Precio Promedio ?',2,1,'E') = 2 then return

long i
string ls_producto

for i = 1 to dw_1.rowcount()
	yield()
	w_fa_frame.setmicrohelp('Procesando Registro '+string(i)+' de '+string(dw_1.rowcount()))
//	if dw_1.getitemNumber(i,'incluir') = 1 then
		ls_producto = dw_1.getitemstring(i,'prod_producto')
		
		DECLARE  sp_procedure PROCEDURE FOR sp_actualiza_margen_y_precio
		@g_financiero = :str.g_financiero,
		@empresa = :str.empresa,
		@producto = :ls_producto;

		EXECUTE sp_procedure; //
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Ejecutar Procedimiento '+sqlca.sqlerrtext,1,1,'E')
			return
		end if
		close sp_procedure ;		
//	end if
next

gf_mensaje('','Fin de la Actualizacion ',1,1,'E')

end event

type cbx_ver_costo_leo from checkbox within w_catalogos
boolean visible = false
integer x = 6373
integer y = 12
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ver CL"
end type

event clicked;if cbx_ver_costo_leo.checked and cbx_imprimir_b.checked then
	dw_5.object.prod_costo_fob.visible = 0
	dw_5.object.costo_l.visible = 1
	dw_5.object.total.visible = 0
	dw_5.object.total_l.visible = 1
	dw_5.object.final.visible = 0
	dw_5.object.final_l.visible = 1
	dw_5.object.tot_entrada.visible = 0
	dw_5.object.tot_entrada_l.visible = 1
	
elseif cbx_imprimir_b.checked then
	dw_5.object.costo_l.visible = 0
	dw_5.object.prod_costo_fob.visible = 1
	dw_5.object.total.visible = 1
	dw_5.object.total_l.visible = 0
	dw_5.object.final.visible = 1
	dw_5.object.final_l.visible = 0
	dw_5.object.tot_entrada.visible = 1
	dw_5.object.tot_entrada_l.visible = 0
	
end if
end event

type dw_8 from datawindow within w_catalogos
event ue_post_item ( )
boolean visible = false
integer x = 2487
integer y = 84
integer width = 928
integer height = 1588
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_nivel3_check"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_post_item();integer i, li_check
string ls_marca, ls_cadena_marca
if this.getcolumnname() = 'li_check' then
	if this.getrow() = 1 then
		li_check = this.getitemnumber(1,'li_check')
		for i = 1 to this.rowcount()
			this.setitem(i,'li_check',li_check)
		next
		if li_check = 0 then
			dw_3.setitem(1,'nivel3','')			
		else
			dw_3.setitem(1,'nivel3',this.getitemstring(2,'prod_nivel3')+'...')
		end if
		return
	else
		if this.getitemnumber(this.getrow(),'li_check') = 1 then
			ls_marca = dw_3.getitemstring(1,'nivel3')
			if ls_marca = '' or isnull(ls_marca) then
				dw_3.setitem(1,'nivel3',this.getitemstring(this.getrow(),'prod_nivel3'))
			else
				if right(ls_marca,3) <> '...' then
					dw_3.setitem(1,'nivel3',ls_marca + '...')
				end if
			end if
		else
			ls_marca = dw_3.getitemstring(1,'nivel3')
			if right(ls_marca,3) = '...' then
				for i = 2 to dw_11.rowcount()
					li_check = this.getitemnumber(i,'li_check')
					if li_check = 1 then
						ls_marca = this.getitemstring(i,'prod_nivel3')
						if ls_cadena_marca = '' then
							ls_cadena_marca = ls_marca
						else
							ls_cadena_marca = ls_cadena_marca + '...'
							exit
						end if
					end if
				next
				dw_3.setitem(1,'nivel3',ls_cadena_marca)
			else
				dw_3.setitem(1,'nivel3','')
			end if
		end if

	end if
end if


end event

event clicked;integer li_check, i, li_valor
string ls_text, ls_campo, ls_proveedor

dw_7.visible = false
dw_19.visible = false
dw_20.visible = false
dw_10.visible = false
dw_9.visible = false
dw_21.visible = false

string ls_marca, ls_cadena_marca
if this.getcolumnname() = 'li_check' then
	if this.getrow() = 1 then
		li_check = this.getitemnumber(1,'li_check')
		for i = 1 to this.rowcount()
			this.setitem(i,'li_check',li_check)
		next
		if li_check = 0 then
			dw_3.setitem(1,'nivel3','')			
		else
			dw_3.setitem(1,'nivel3',this.getitemstring(2,'prod_nivel3')+'...')
		end if
		return
	else
		if this.getitemnumber(this.getrow(),'li_check') = 1 then
			ls_marca = dw_3.getitemstring(1,'nivel3')
			if ls_marca = '' or isnull(ls_marca) then
				dw_3.setitem(1,'nivel3',this.getitemstring(this.getrow(),'prod_nivel3'))
			else
				if right(ls_marca,3) <> '...' then
					dw_3.setitem(1,'nivel3',ls_marca + '...')
				end if
			end if
		else
			ls_marca = dw_3.getitemstring(1,'nivel3')
			if right(ls_marca,3) = '...' then
				for i = 2 to dw_7.rowcount()
					li_check = this.getitemnumber(i,'li_check')
					if li_check = 1 then
						ls_marca = this.getitemstring(i,'prod_nivel3')
						if ls_cadena_marca = '' then
							ls_cadena_marca = ls_marca
						else
							ls_cadena_marca = ls_cadena_marca + '...'
							exit
						end if
					end if
				next
				dw_3.setitem(1,'nivel3',ls_cadena_marca)
			else
				dw_3.setitem(1,'nivel3','')
			end if
		end if

	end if
end if
end event

event itemchanged;this.accepttext()
this.postevent('ue_post_item')
end event

event buttonclicked;dw_8.visible = false
end event

type cbx_2 from checkbox within w_catalogos
integer x = 4923
integer y = 140
integer width = 507
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ver 12 por página"
end type

event clicked;if this.checked then
	dw_5.dataobject = 'catalogo_inventario_total_9_por_paginas'
else
	dw_5.dataobject = 'catalogo_inventario_total_4_por_pagina'	
end if
cbx_3.checked = false
rb_2.checked = true
rb_1.checked = false

dw_5.settransobject(sqlca)
dw_1.sharedata(dw_5)

date ldt_desde, ldt_hasta
integer i, li_ver_precio, li_ver_cantidad
decimal{2} ld_porc, ld_costo_cif, ld_precio

	li_ver_cantidad = dw_3.getitemnumber(1,'ver_cantidad')
	li_ver_precio = dw_3.getitemnumber(1,'ver_precio')
	ld_porc		 = dw_3.getitemnumber(1,'porc')
	if li_ver_precio = 1 then
		li_ver_precio = dw_3.getitemnumber(1,'precio')
	end if
	for i = 1 to dw_1.rowcount()
		dw_1.setitem(i,'ver_precio',li_ver_precio)
		dw_1.setitem(i,'ver_cantidad',li_ver_cantidad)
		if ld_porc > 0 then
			ld_costo_cif =  dw_1.getitemnumber(i,'inmprodu_prod_costo_cif')
			ld_precio = ld_costo_cif + (ld_costo_cif * (ld_porc / 100) )
			dw_1.setitem(i,'precio_numero',ld_precio)
			dw_1.setitem(i,'precio_numero2',ld_precio)
		end if
	next
	dw_5.visible = true
	dw_1.visible = false
	
	ldt_desde = date(em_desde.text)
	ldt_hasta = date(em_hasta.text)

	dw_5.setitem(1, "desde", string(ldt_desde))
	dw_5.setitem(1, "hasta", string(ldt_hasta))

	dw_5.object.datawindow.print.preview = 'yes'
	dw_5.object.datawindow.print.preview.zoom = 100


end event

type p_1 from picture within w_catalogos
integer x = 5435
integer y = 56
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "C:\Sistemas\Hymsoft\Art\CreatePDF.png"
boolean focusrectangle = false
end type

event clicked;cb_7.triggerevent('clicked')
end event

type cb_7 from commandbutton within w_catalogos
integer x = 5522
integer y = 52
integer width = 370
integer height = 76
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crear PDF!"
end type

event clicked;//wf_crear_pdf()
OLEObject ole_object 
Integer li_rc , li_Ret
String ls_ruta , ls_raiz
integer li_result, li_FileNum
string ls_path, ls_archivo2, ls_nombre

ls_path = "C:\Sistemas\Comprobantes"
	//	li_result = GetFolder( "Seleccionar Carpeta Destino", ls_path )
		ls_nombre = sle_nombre.text
		ls_archivo2= ls_path+"\"+ls_nombre+".pdf"
				PrintSetPrinter ("Bullzip PDF Printer")
				dw_5.Object.DataWindow.Printer = "Bullzip PDF Printer" // "Sybase DataWindow PS" //"Adobe DataWindow PS"
				dw_5.Object.DataWindow.Export.PDF.Method = Distill!
				dw_5.Object.DataWindow.Export.PDF.Distill.CustomPostScript="Yes"
				dw_5.Modify("datawindow.Export.PDF.Method = '1'")
				dw_5.print()		

		sleep(10)
		
ls_raiz = 'C:\Sistemas\Comprobantes\comprobante.pdf'
li_FileNum = FileCopy (ls_raiz , ls_archivo2, TRUE)
if li_Filenum <> 1 then
	gf_mensaje('','Error al Copiar ...'+string(li_Filenum),1,1,'E')
	return
end if
filedelete("C:\Sistemas\Comprobantes\comprobante.pdf")

if fileexists(ls_archivo2) then
	
else
	//ls_ruta = " C:\Sistemas\Documentos\hymsoft.pdf" 
	gf_mensaje('','Pdf no Existe, Verifique !!!',1,1,'E')
	return
end if

ls_archivo2 = ""+ls_archivo2

openwithparm(w_web_browser,ls_archivo2)

//ole_pdf.object.src = ls_archivo2
//ole_pdf.object.setPageMode ("none")
//ole_pdf.object.setShowToolbar (False)
//ole_pdf.object.setShowScrollbars (True)
//ole_pdf.object.setView ("Fit")

//ole_object = CREATE OleObject 
//li_rc = ole_object.ConnectToNewObject( "WScript.Shell" ) 
//
//IF li_rc<>0 THEN 
//DESTROY ole_object 
//MessageBox("Error", "No puede conectarse a Acrobat ") 
//RETURN 
//END IF 
//
//ole_object.run("AcroRd32"+ls_archivo2) //, Maximized!) 
//
//			
end event

type p_2 from picture within w_catalogos
integer x = 5440
integer y = 136
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "C:\Sistemas\Hymsoft\Art\send-email.png"
boolean focusrectangle = false
end type

event clicked;cb_7.triggerevent('clicked')
end event

type cb_8 from commandbutton within w_catalogos
integer x = 5522
integer y = 128
integer width = 370
integer height = 80
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Enviar Mail"
end type

event clicked;wf_crear_pdf()
end event

type sle_1 from singlelineedit within w_catalogos
integer x = 5902
integer y = 132
integer width = 603
integer height = 80
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "E-mail"
textcase textcase = lower!
borderstyle borderstyle = stylelowered!
end type

type cbx_3 from checkbox within w_catalogos
integer x = 4923
integer y = 212
integer width = 539
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ver Solo Foto"
end type

event clicked;if this.checked then
	dw_5.dataobject = 'catalogo_inventario_total_4_foto_grande'
else
	dw_5.dataobject = 'catalogo_inventario_total_4_por_pagina'	
end if
cbx_2.checked = false
rb_2.checked = true
rb_1.checked = false

dw_5.settransobject(sqlca)
dw_1.sharedata(dw_5)

date ldt_desde, ldt_hasta
integer i, li_ver_precio, li_ver_cantidad
decimal{2} ld_porc, ld_costo_cif, ld_precio

	li_ver_cantidad = dw_3.getitemnumber(1,'ver_cantidad')
	li_ver_precio = dw_3.getitemnumber(1,'ver_precio')
	ld_porc		 = dw_3.getitemnumber(1,'porc')
	if li_ver_precio = 1 then
		li_ver_precio = dw_3.getitemnumber(1,'precio')
	end if
	for i = 1 to dw_1.rowcount()
		dw_1.setitem(i,'ver_precio',li_ver_precio)
		dw_1.setitem(i,'ver_cantidad',li_ver_cantidad)
		if ld_porc > 0 then
			ld_costo_cif =  dw_1.getitemnumber(i,'inmprodu_prod_costo_cif')
			ld_precio = ld_costo_cif + (ld_costo_cif * (ld_porc / 100) )
			dw_1.setitem(i,'precio_numero',ld_precio)
			dw_1.setitem(i,'precio_numero2',ld_precio)
		end if
	next
	dw_5.visible = true
	dw_1.visible = false
	
	ldt_desde = date(em_desde.text)
	ldt_hasta = date(em_hasta.text)

	dw_5.setitem(1, "desde", string(ldt_desde))
	dw_5.setitem(1, "hasta", string(ldt_hasta))

	dw_5.object.datawindow.print.preview = 'yes'
	dw_5.object.datawindow.print.preview.zoom = 100


end event

type sle_nombre from singlelineedit within w_catalogos
integer x = 5902
integer y = 56
integer width = 603
integer height = 80
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Catalogo"
borderstyle borderstyle = stylelowered!
end type

