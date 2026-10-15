//objectcomments Consulta de Facturas
forward
global type w_facturas_actualizadas from w_fa_padre_reportes
end type
type dw_2 from datawindow within w_facturas_actualizadas
end type
type dw_3 from uos_in_datawindow_utility within w_facturas_actualizadas
end type
type dw_4 from datawindow within w_facturas_actualizadas
end type
type st_4 from statictext within w_facturas_actualizadas
end type
type dw_5 from datawindow within w_facturas_actualizadas
end type
type cbx_1 from checkbox within w_facturas_actualizadas
end type
type dw_6 from datawindow within w_facturas_actualizadas
end type
type em_ann from editmask within w_facturas_actualizadas
end type
type st_2 from statictext within w_facturas_actualizadas
end type
type cbx_2 from checkbox within w_facturas_actualizadas
end type
type cb_1 from commandbutton within w_facturas_actualizadas
end type
type cbx_catalogo from checkbox within w_facturas_actualizadas
end type
type dw_7 from datawindow within w_facturas_actualizadas
end type
type cb_2 from commandbutton within w_facturas_actualizadas
end type
type cb_3 from commandbutton within w_facturas_actualizadas
end type
type em_costo from editmask within w_facturas_actualizadas
end type
type dw_8 from datawindow within w_facturas_actualizadas
end type
type cb_4 from commandbutton within w_facturas_actualizadas
end type
type gb_4 from gb_1 within w_facturas_actualizadas
end type
end forward

global type w_facturas_actualizadas from w_fa_padre_reportes
integer x = 5
integer y = 20
integer width = 5787
integer height = 2828
string title = "Consulta de Facturas Actualizadas"
long backcolor = 12639424
event ue_buscar ( )
dw_2 dw_2
dw_3 dw_3
dw_4 dw_4
st_4 st_4
dw_5 dw_5
cbx_1 cbx_1
dw_6 dw_6
em_ann em_ann
st_2 st_2
cbx_2 cbx_2
cb_1 cb_1
cbx_catalogo cbx_catalogo
dw_7 dw_7
cb_2 cb_2
cb_3 cb_3
em_costo em_costo
dw_8 dw_8
cb_4 cb_4
gb_4 gb_4
end type
global w_facturas_actualizadas w_facturas_actualizadas

type variables
string  is_tipo,is_pedido
integer ii_ann
n_cst_sys gnv_sys
n_cst_winsrv_shell32	nv_f3
datawindowchild idw_child
end variables

forward prototypes
public subroutine wf_fecha ()
public subroutine wf_nofecha ()
public subroutine wf_imprime_vendedor ()
public subroutine wf_insertar_cargos (long al_filas)
public subroutine wf_control_de_totales (long al_rowcount)
public function string wf_armar_sql ()
public function string wf_verificar (string ls_original)
public function long wf_crear_pdf (ref string as_archivo, string as_factura)
public function integer wf_send_mail (string as_archivo, string as_tag, string as_titulo, string as_correo)
end prototypes

event ue_buscar;string  ls_factura, ls_syntax
integer li_pos, li_pos2
str_dg_dynamic_find lstr_df

//dw = tab_1.tabpage_gnrles.dw_generales

lstr_df.texto_campo[1, 1] = "fatdiari.fact_a_nombre"
lstr_df.texto_campo[1, 2] = "A Nombre"
lstr_df.texto_campo[1, 3] = ""
lstr_df.texto_campo[1, 4] = "V"
lstr_df.texto_campo[1, 5] = "700"

lstr_df.texto_campo[2, 1] = "fatdiari.fact_no_pedido"
lstr_df.texto_campo[2, 2] = "Pedido"
//lstr_df.texto_campo[2, 3] = "prod_descripcion"
lstr_df.texto_campo[2, 3] = ""
lstr_df.texto_campo[2, 4] = "V"
//lstr_df.texto_campo[2, 5] = "600"

lstr_df.texto_campo[3, 1] = "fatdiari.fact_no_factura"
lstr_df.texto_campo[3, 2] = "Factura"
////lstr_df.texto_campo[3, 3] = "~tdd/mm/yyyy~tprod_ultima_actualizacion"
lstr_df.texto_campo[3, 3] = "fact_no_factura"
//lstr_df.texto_campo[3, 3] = ""
lstr_df.texto_campo[3, 4] = "V"
//lstr_df.texto_campo[3, 5] = "150"

lstr_df.texto_campo[4, 1] = "fatdiari.fact_fecha"
lstr_df.texto_campo[4, 2] = "Fecha"
lstr_df.texto_campo[4, 3] = ""
//lstr_df.texto_campo[4, 3] = ""
lstr_df.texto_campo[4, 4] = "V"
lstr_df.texto_campo[4, 5] = "270"

lstr_df.texto_campo[5, 1] = "fatdiari.fact_ann"
lstr_df.texto_campo[5, 2] = "Año"
lstr_df.texto_campo[5, 3] = ""
//lstr_df.texto_campo[4, 3] = ""
lstr_df.texto_campo[5, 4] = "V"
//
lstr_df.tabla = " fatdiari "
if w_fa_fondo.str_para.mostrar <> 0 then  //mostrar un Año específico
	CHOOSE CASE w_fa_fondo.str_para.desde
		CASE 0
		lstr_df.tabla_where = &
		"WHERE ( ( fatdiari.fact_g_financiero = " + String(str.g_financiero) + " ) AND " +&
				"( fatdiari.fact_empresa  = " +String(str.empresa) + " ) AND "+&
				"( fatdiari.fact_ann = "+string(w_fa_fondo.str_para.mostrar)+") and ( fatdiari.fact_no_pedido not like '%NC%' ) )"
		CASE 1
		lstr_df.tabla_where = &
		"WHERE ( ( fatdiari.fact_g_financiero = " + String(str.g_financiero) + " ) AND " +&
				"( fatdiari.fact_empresa  = " +String(str.empresa) + " ) AND "+&
				"( fatdiari.fact_ann >= "+string(w_fa_fondo.str_para.mostrar)+") and ( fatdiari.fact_no_pedido not like '%NC%' ) )"			
	END CHOOSE
else //Si selecciono mostrar todas, solo filtra por grupo y empresa
	lstr_df.tabla_where = &
		"WHERE ( ( fatdiari.fact_g_financiero = " + String(str.g_financiero) + " ) AND " +&
				"( fatdiari.fact_empresa  = " +String(str.empresa) + " ) AND ( fatdiari.fact_no_pedido not like '%NC%' ) ) "
end if				
				// And " +&
//				"( inmbodeg.mbod_cantidad <> 0 ) and " +&
//				"( inmprodu.prod_status   = 1 ) AND "+&
//				"( upper(inmbodeg.mbod_producto) like '"+upper(as_producto)+"%' ) AND "+&
//				"(SubString(inmprodu.prod_owner,"+String(ii_flag)+",1) = '1')"

OpenWithParm(w_dg_a_custom_find, lstr_df)

ls_syntax = message.stringparm
if ls_syntax = '' then return
li_pos = pos(ls_syntax,"'")
li_pos2 = pos(ls_syntax,"'",li_pos + 1)
ls_factura = mid(ls_syntax,li_pos+1, li_pos2 - li_pos - 1)

dw_4.setitem(1,'fact_no_pedido',ls_factura)
dw_4.accepttext()
dw_4.triggerevent('itemchanged')
end event

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

public subroutine wf_imprime_vendedor ();integer li_hay, li_codigo, i=0
string  ls_nombre, ls_resultado, ls_nombre_imp, ls_cod_imp

datawindow ldw_5

ldw_5 = dw_5
		
		 DECLARE cur_vende CURSOR FOR
		  SELECT fadvenfa.vfac_vendedor,   
					famvende.vend_nombre+' '+famvende.vend_apellido nombre  
			 FROM fadvenfa,   
					famvende  
			WHERE ( famvende.vend_g_financiero = fadvenfa.vfac_g_financiero ) and  
					( famvende.vend_empresa = fadvenfa.vfac_empresa ) and  
					( famvende.vend_vendedor = fadvenfa.vfac_vendedor ) and  
					( ( fadvenfa.vfac_g_financiero = :str.g_financiero ) AND  
					( fadvenfa.vfac_empresa = :str.empresa ) AND  
					( fadvenfa.vfac_tipo = :is_tipo ) AND  
					( fadvenfa.vfac_no_pedido = :is_pedido ) AND  
					( fadvenfa.vfac_ann = :ii_ann ) ) ;			 
	
 OPEN cur_vende;
 
 if sqlca.sqlcode = -1 then
	mensaje("Aviso","Error al Abrir el Cursor",sqlca.sqlerrtext)
 end if
 
 FETCH cur_vende INTO :li_codigo,:ls_nombre;
 
 IF SQLCA.SQLCODE = -1 THEN	
	MESSAGEBOX("ERROR","ERROR AL SELECCIONAR LOS VENDEDORES "+SQLCA.SQLERRTEXT)
	CLOSE cur_vende;
	RETURN
 END IF	
 
 DO WHILE SQLCA.SQLCODE = 0
	 if i > 0 then //Si no es la primera vez ni la ultima, separa el codigo
	 	ls_nombre_imp += ' / '
		ls_cod_imp	+= ' / '		
	 end if	 
	 ls_nombre_imp += ls_nombre 	     //Concatena los codigos y nombres
	 ls_cod_imp		+= string(li_codigo)	 
	 i ++	 //Incrementa la i
	 FETCH cur_vende INTO :li_codigo,:ls_nombre;	 
 loop
 
 ls_resultado = ldw_5.modify("cod_vendedor.text='"+ls_cod_imp+"'")
 ls_resultado = ldw_5.modify("nom_vendedor.text='"+ls_nombre_imp+"'")			
	 
 CLOSE cur_vende;
end subroutine

public subroutine wf_insertar_cargos (long al_filas);//
integer li_orden, i
long	  ll_linea_fotter
double  ld_monto
string  ls_cargo
datawindow ldw_3, ldw_6
ldw_3		  = dw_3
ldw_6		  = dw_6

ll_linea_fotter = ldw_3.rowcount()

for i = 1 to al_filas
	 ld_monto	  = ldw_6.getitemnumber(i,"dcar_monto")		
	 li_orden	  = ldw_6.getitemnumber(i,"carg_orden")		

	 if isnull(li_orden) then 
		li_orden = 0	 
		ls_cargo = "carg_7"
	 else	
		ls_cargo = "carg_"+string(li_orden)
	 end if
	
	
	if ldw_3.Describe(ls_cargo+".x") <> "?" and ldw_3.Describe(ls_cargo+".x") <> "!" then 	 
			 choose case li_orden
				case 1
					ldw_3.object.carg_1.expression = string(ld_monto)
				case 2	
					ldw_3.object.carg_2.expression = string(ld_monto)
				case 3
					ldw_3.object.carg_3.expression = string(ld_monto)
				case 4
					ldw_3.object.carg_4.expression = string(ld_monto)			
				case 5
					ldw_3.object.carg_5.expression = string(ld_monto)
				case 6
					ldw_3.object.carg_6.expression = string(ld_monto)
				case else	
					ldw_3.object.carg_7.expression = string(ld_monto)
			end choose
	end if
next

end subroutine

public subroutine wf_control_de_totales (long al_rowcount);//Inserta las lineas de los cargos al final de la Factura
integer 	  li_recorrido, li_linea, li_linea_tot, li_linea_de_totales
double	  ld_monto, ld_total, ld_cargos
string	  ls_descrip , ls_descuento_deta
datawindow ldw_3, ldw_6
ldw_3		  = dw_5
ldw_6		  = dw_6
ldw_3.SetReDraw(True)
//Para guardar la última línea del detalle de la factura
li_linea_de_totales = ldw_3.Rowcount()

//Si se determino que no aparecierán los cargos desglosados, retorna
//if w_fa_fondo.str_para.detalle_de_cargos = 0 or isnull(w_fa_fondo.str_para.detalle_de_cargos) then
//	li_linea_de_totales = 0	
//end if

if li_linea_de_totales <= 0 then
	ldw_3.SetReDraw(True)
	return
end if

ls_descuento_deta = ldw_3.getitemString(1,"fact_descuento_subt_deta")
//ld_cargos			= ldw_3.getitemnumber(1,"fact_gastos_total")

/*Verifica si los cargos + las lineas del detalle caben en una pagina*/
//if ldw_3.Rowcount() + al_rowcount+ 7 > 24 then
//	//Linea del subtotal
//	li_linea_de_totales = 24
//	ldw_3.setitem(24,"linea_subt",1)
//	ldw_3.insertrow(25)
//	ldw_3.insertrow(26)
//	ldw_3.insertrow(27)
//	ldw_3.insertrow(28)
//	ldw_3.insertrow(29)
//	ldw_3.insertrow(30)
//	ldw_3.insertrow(31)
////	ldw_3.insertrow(32)	
//else
//	//Linea del subtotal
//	ldw_3.setitem(li_linea_de_totales,"linea_subt",1)	
//end if

//Para guardar la última línea del detalle de la factura


li_linea_tot = ldw_3.Rowcount()
ldw_3.setitem(li_linea_tot,"linea_subt",1)
li_linea     = ldw_3.insertrow(0)

ldw_3.setitem(li_linea,"grupo",1)
ldw_3.setitem(li_linea,"car_descripcion","SUBTOTAL NETO:")	

if ls_descuento_deta = 'D' and ldw_3.Describe("imprime_desc.x") <> "?" and ldw_3.Describe("imprime_desc.x") <> "!" then 
				//Si aplica descuento al detalle, asigna el total menos
				//los cargos al subtotal, si tiene el compute llamado imprime_desc en el dw de impresion
	ldw_3.setitem(li_linea,"facd_monto_final",ldw_3.GetitemNumber(li_linea_de_totales,"fact_monto_final") - ldw_3.GetitemNumber(li_linea_de_totales,"fact_gastos_total"))
else
	ldw_3.setitem(li_linea,"facd_monto_final",ldw_3.GetitemNumber(li_linea_de_totales,"fact_monto_fact_total"))
end if
//Encabezado, despues de la linea de subtotales
ldw_3.setitem(li_linea,"fact_no_pedido",ldw_3.GetitemString(li_linea_de_totales,"fact_no_pedido"))
ldw_3.setitem(li_linea,"fact_fecha",ldw_3.GetitemDatetime(li_linea_de_totales,"fact_fecha"))
ldw_3.setitem(li_linea,"fact_no_factura",ldw_3.GetitemString(li_linea_de_totales,"fact_no_factura"))
ldw_3.setitem(li_linea,"terc_identificacion",ldw_3.GetitemString(li_linea_de_totales,"terc_identificacion"))
ldw_3.setitem(li_linea,"fact_a_nombre",ldw_3.GetitemString(li_linea_de_totales,"fact_a_nombre"))
ldw_3.setitem(li_linea,"pais_descripcion",ldw_3.GetitemString(li_linea_de_totales,"pais_descripcion"))
ldw_3.setitem(li_linea,"fact_a_nombre_direccion",ldw_3.GetitemString(li_linea_de_totales,"fact_a_nombre_direccion"))
ldw_3.setitem(li_linea,"fact_consignado",ldw_3.GetitemString(li_linea_de_totales,"fact_consignado"))
ldw_3.setitem(li_linea,"fact_condicion_pago",ldw_3.GetitemString(li_linea_de_totales,"fact_condicion_pago"))
ldw_3.setitem(li_linea,"peri_descripcion",ldw_3.GetitemString(li_linea_de_totales,"peri_descripcion"))
ldw_3.setitem(li_linea,"fact_tipo_movimiento",ldw_3.GetitemString(li_linea_de_totales,"fact_tipo_movimiento"))
ldw_3.setitem(li_linea,"fact_no_traspaso",ldw_3.GetitemNumber(li_linea_de_totales,"fact_no_traspaso"))
ldw_3.setitem(li_linea,"fact_factura_de_bodega",ldw_3.GetitemString(li_linea_de_totales,"fact_factura_de_bodega"))
ldw_3.setitem(li_linea,"fact_comentario",ldw_3.GetitemString(li_linea_de_totales,"fact_comentario"))
ldw_3.setitem(li_linea,"fact_marca",ldw_3.GetitemString(li_linea_de_totales,"fact_marca"))
ldw_3.setitem(li_linea,"fact_monto_fact_total",ldw_3.GetitemNumber(li_linea_de_totales,"fact_monto_fact_total"))
ldw_3.setitem(li_linea,"fact_monto_final",ldw_3.GetitemNumber(li_linea_de_totales,"fact_monto_final"))



//Para que los cargos siempre salgan al final, cuando se ordena
ldw_3.setitem(li_linea,"facd_index",9997)
//ldw_3.setitem(li_linea,"facd_codigo_item","ZZZZZZZZZZZZZZZZZ")
//ldw_3.setitem(li_linea,"facd_descripcion_alterna","ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ")
//Para que no mande error si no está el campo de bulto inicio en el datawindow de impresion
//if ldw_3.Describe("facd_bulto_inicio.x") <> "?" and ldw_3.Describe("facd_bulto_inicio.x") <> "!" then 	 
	
	ldw_3.setitem(li_linea,"facd_bulto_inicio",9999997)	
	ldw_3.setitem(li_linea,"facd_bulto_fin",9999997)		
//end if
 
for li_recorrido = 1 to al_rowcount
 
	 ld_monto	  = ldw_6.getitemnumber(li_recorrido,"dcar_monto")
	 ls_descrip	  = ldw_6.getitemString(li_recorrido,"carg_descripcion")
	 li_linea     = ldw_3.insertrow(0)
	 
	 //Cuando se controle que los cargos aparezcan en una sola pagina, se puede quitar este
	 //codigo de aqui
	 //**********************************************************************************//
	 
//Encabezado

	ldw_3.setitem(li_linea,"fact_no_pedido",ldw_3.GetitemString(li_linea_de_totales,"fact_no_pedido"))
	ldw_3.setitem(li_linea,"fact_fecha",ldw_3.GetitemDatetime(li_linea_de_totales,"fact_fecha"))
	ldw_3.setitem(li_linea,"fact_no_factura",ldw_3.GetitemString(li_linea_de_totales,"fact_no_factura"))
	ldw_3.setitem(li_linea,"terc_identificacion",ldw_3.GetitemString(li_linea_de_totales,"terc_identificacion"))
	ldw_3.setitem(li_linea,"fact_a_nombre",ldw_3.GetitemString(li_linea_de_totales,"fact_a_nombre"))
	ldw_3.setitem(li_linea,"pais_descripcion",ldw_3.GetitemString(li_linea_de_totales,"pais_descripcion"))
	ldw_3.setitem(li_linea,"fact_a_nombre_direccion",ldw_3.GetitemString(li_linea_de_totales,"fact_a_nombre_direccion"))
	ldw_3.setitem(li_linea,"fact_consignado",ldw_3.GetitemString(li_linea_de_totales,"fact_consignado"))
	ldw_3.setitem(li_linea,"fact_condicion_pago",ldw_3.GetitemString(li_linea_de_totales,"fact_condicion_pago"))
	ldw_3.setitem(li_linea,"peri_descripcion",ldw_3.GetitemString(li_linea_de_totales,"peri_descripcion"))
	ldw_3.setitem(li_linea,"fact_tipo_movimiento",ldw_3.GetitemString(li_linea_de_totales,"fact_tipo_movimiento"))
	ldw_3.setitem(li_linea,"fact_no_traspaso",ldw_3.GetitemNumber(li_linea_de_totales,"fact_no_traspaso"))
	ldw_3.setitem(li_linea,"fact_factura_de_bodega",ldw_3.GetitemString(li_linea_de_totales,"fact_factura_de_bodega"))
	ldw_3.setitem(li_linea,"fact_comentario",ldw_3.GetitemString(li_linea_de_totales,"fact_comentario"))
	ldw_3.setitem(li_linea,"fact_marca",ldw_3.GetitemString(li_linea_de_totales,"fact_marca"))
	ldw_3.setitem(li_linea,"fact_monto_fact_total",ldw_3.GetitemNumber(li_linea_de_totales,"fact_monto_fact_total"))
	ldw_3.setitem(li_linea,"fact_monto_final",ldw_3.GetitemNumber(li_linea_de_totales,"fact_monto_final"))

	//Para que los cargos siempre salgan al final, cuando se ordena
	ldw_3.setitem(li_linea,"facd_index",9998)	
//	ldw_3.setitem(li_linea,"facd_codigo_item","ZZZZZZZZZZZZZZZZZZZ")
//	ldw_3.setitem(li_linea,"facd_descripcion_alterna","ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ")
	//Para que no mande error si no está el campo de bulto inicio en el datawindow de impresion
//	if ldw_3.Describe("facd_bulto_inicio.x") <> "?" and ldw_3.Describe("facd_bulto_inicio.x") <> "!" then
		ldw_3.setitem(li_linea,"facd_bulto_inicio",9999998)	
		ldw_3.setitem(li_linea,"facd_bulto_fin",9999998)		
//	end if	 
	 
 //**********************************************************************************// 
	 
	 ldw_3.setitem(li_linea,"facd_monto_final",ld_monto)	
	 ldw_3.setitem(li_linea,"car_descripcion",trim(ls_descrip)+":")	
	 ldw_3.setitem(li_linea,"grupo",1)	
	 ldw_3.setitem(li_linea,"linea_subt",0)	
	 ld_total     += ld_monto //Acumula el total
	 
next

////Para insertar la linea de total de los cargos
////li_linea     = ldw_3.insertrow(0)
////ldw_3.setitem(li_linea,"facd_monto_final",ld_total)	
////ldw_3.setitem(li_linea,"car_descripcion","TOTAL DE GASTOS:")	
////ldw_3.setitem(li_linea,"grupo",1)	
	 
//Setea los datos del fotter a la ultima linea
ldw_3.setitem(li_linea,"fact_monto_fact_total",ldw_3.GetitemNumber(li_linea_de_totales,"fact_monto_fact_total"))
ldw_3.setitem(li_linea,"fact_gastos_total",ldw_3.GetitemNumber(li_linea_de_totales,"fact_gastos_total"))
ldw_3.setitem(li_linea,"fact_monto_final",ldw_3.GetitemNumber(li_linea_de_totales,"fact_monto_final"))
ldw_3.setitem(li_linea,"fact_cubicaje_total",ldw_3.GetitemNumber(li_linea_de_totales,"fact_cubicaje_total"))
ldw_3.setitem(li_linea,"fact_peso_total",ldw_3.GetitemNumber(li_linea_de_totales,"fact_peso_total"))
ldw_3.setitem(li_linea,"fact_bultos_total",ldw_3.GetitemNumber(li_linea_de_totales,"fact_bultos_total"))
ldw_3.setitem(li_linea,"fact_unidad_peso",ldw_3.GetitemString(li_linea_de_totales,"fact_unidad_peso"))
ldw_3.setitem(li_linea,"facd_usuario",ldw_3.GetitemString(li_linea_de_totales,"facd_usuario"))
ldw_3.setitem(li_linea,"fact_despachado",ldw_3.GetitemString(li_linea_de_totales,"fact_despachado"))
ldw_3.setitem(li_linea,"fact_comentario",ldw_3.GetitemString(li_linea_de_totales,"fact_comentario"))
ldw_3.setitem(li_linea,"fara_jurada",ldw_3.GetitemString(li_linea_de_totales,"fara_jurada"))
ldw_3.setitem(li_linea,"fara_jurada_dos",ldw_3.GetitemString(li_linea_de_totales,"fara_jurada_dos"))
ldw_3.setitem(li_linea,"fara_logo",ldw_3.GetitemString(li_linea_de_totales,"fara_logo"))
ldw_3.setitem(li_linea,"fara_logo_f",ldw_3.GetitemString(li_linea_de_totales,"fara_logo_f"))

//Para que los cargos siempre salgan al final, cuando se ordena
ldw_3.setitem(li_linea,"facd_index",9999)	
//ldw_3.setitem(li_linea,"facd_codigo_item","ZZZZZZZZZZZZZZZZZZZZ")
//ldw_3.setitem(li_linea,"facd_descripcion_alterna","ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ")
//Para que no mande error si no está el campo de bulto inicio en el datawindow de impresion
//if ldw_3.Describe("facd_bulto_inicio.x") <> "?" and ldw_3.Describe("facd_bulto_inicio.x") <> "!" then 	 
	ldw_3.setitem(li_linea,"facd_bulto_inicio",9999999)	
	ldw_3.setitem(li_linea,"facd_bulto_fin",9999999)		
//end if

ldw_3.groupcalc ()
	 
//Encabezado
//ldw_3.setitem(li_linea,"fact_no_pedido",ldw_3.GetitemString(li_linea_de_totales,"fact_no_pedido"))
//ldw_3.setitem(li_linea,"fact_fecha",ldw_3.GetitemDatetime(li_linea_de_totales,"fact_fecha"))
//ldw_3.setitem(li_linea,"fact_no_factura",ldw_3.GetitemString(li_linea_de_totales,"fact_no_factura"))
//ldw_3.setitem(li_linea,"terc_identificacion",ldw_3.GetitemString(li_linea_de_totales,"terc_identificacion"))
//ldw_3.setitem(li_linea,"fact_a_nombre",ldw_3.GetitemString(li_linea_de_totales,"fact_a_nombre"))
//ldw_3.setitem(li_linea,"pais_descripcion",ldw_3.GetitemString(li_linea_de_totales,"pais_descripcion"))
//ldw_3.setitem(li_linea,"fact_a_nombre_direccion",ldw_3.GetitemString(li_linea_de_totales,"fact_a_nombre_direccion"))
//ldw_3.setitem(li_linea,"fact_consignado",ldw_3.GetitemString(li_linea_de_totales,"fact_consignado"))
//ldw_3.setitem(li_linea,"fact_condicion_pago",ldw_3.GetitemString(li_linea_de_totales,"fact_condicion_pago"))
//ldw_3.setitem(li_linea,"peri_descripcion",ldw_3.GetitemString(li_linea_de_totales,"peri_descripcion"))
//ldw_3.setitem(li_linea,"fact_tipo_movimiento",ldw_3.GetitemString(li_linea_de_totales,"fact_tipo_movimiento"))
//ldw_3.setitem(li_linea,"fact_no_traspaso",ldw_3.GetitemNumber(li_linea_de_totales,"fact_no_traspaso"))
//ldw_3.setitem(li_linea,"fact_factura_de_bodega",ldw_3.GetitemString(li_linea_de_totales,"fact_factura_de_bodega"))
//ldw_3.setitem(li_linea,"fact_comentario",ldw_3.GetitemString(li_linea_de_totales,"fact_comentario"))

//Encabezado de la Pagina
//ldw_3.setitem(31,"fact_no_pedido",ldw_3.GetitemString(li_linea_de_totales,"fact_no_pedido"))
//ldw_3.setitem(31,"fact_fecha",ldw_3.GetitemDatetime(li_linea_de_totales,"fact_fecha"))
//ldw_3.setitem(31,"fact_no_factura",ldw_3.GetitemString(li_linea_de_totales,"fact_no_factura"))
//ldw_3.setitem(31,"terc_identificacion",ldw_3.GetitemString(li_linea_de_totales,"terc_identificacion"))
//ldw_3.setitem(31,"fact_a_nombre",ldw_3.GetitemString(li_linea_de_totales,"fact_a_nombre"))
//ldw_3.setitem(31,"pais_descripcion",ldw_3.GetitemString(li_linea_de_totales,"pais_descripcion"))
//ldw_3.setitem(31,"fact_a_nombre_direccion",ldw_3.GetitemString(li_linea_de_totales,"fact_a_nombre_direccion"))
//ldw_3.setitem(31,"fact_consignado",ldw_3.GetitemString(li_linea_de_totales,"fact_consignado"))
//ldw_3.setitem(31,"fact_condicion_pago",ldw_3.GetitemString(li_linea_de_totales,"fact_condicion_pago"))
//ldw_3.setitem(31,"peri_descripcion",ldw_3.GetitemString(li_linea_de_totales,"peri_descripcion"))
//ldw_3.setitem(31,"fact_tipo_movimiento",ldw_3.GetitemString(li_linea_de_totales,"fact_tipo_movimiento"))
//ldw_3.setitem(31,"fact_no_traspaso",ldw_3.GetitemNumber(li_linea_de_totales,"fact_no_traspaso"))
//ldw_3.setitem(31,"fact_factura_de_bodega",ldw_3.GetitemString(li_linea_de_totales,"fact_factura_de_bodega"))
//ldw_3.setitem(31,"fact_comentario",ldw_3.GetitemString(li_linea_de_totales,"fact_comentario"))


end subroutine

public function string wf_armar_sql ();// Función que arma el Sql de el DataWindow, y dependiendo de donde se llama, factura o consultas
// Filtra segun parámetros iniciales o no
string ls_where, ls_original

ls_original = idw_child.GetsqlSelect()

ls_where = wf_verificar(ls_original)

return(ls_where)
end function

public function string wf_verificar (string ls_original);//Se verifican las opciones de parámetros y se filtra
string ls_where
 
 
 
  
//  if  w_fa_fondo.str_para.mostrar <> 0 then  //mostrar un Año específico

//	CHOOSE CASE w_fa_fondo.str_para.desde	//Si es desde el año en adelante o el año exclusivo.
//		CASE 0

//		 ls_where = ls_original + " where &
//					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
//					 ( fatdiari.fact_empresa = "+string(str.empresa)+" ) and &
//					 (fatdiari.fact_ann = "+string(w_fa_fondo.str_para.mostrar)+" ) AND &
// 					 ( fatdiari.fact_no_pedido not like '%NC%' )"	
//		CASE 1
//		 ls_where = ls_original + " where  &
//					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
//					 ( fatdiari.fact_empresa = "+string(str.empresa)+" ) and &
//					 (fatdiari.fact_ann >= "+string(w_fa_fondo.str_para.mostrar)+" ) AND &
// 					 ( fatdiari.fact_no_pedido not like '%NC%' )"		
//	END CHOOSE			
	
//  else
		 ls_where = ls_original + " where  &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+" ) AND &
 					 ( fatdiari.fact_no_pedido not like '%NC%' )"	
  //end if
  
  if pos(gf_dg_nombre_empresa(),'ELBROS') > 0 then
	  ls_where = ls_where + " and (fatdiari.fact_no_factura <> '0' )"
  end if	
  
return(ls_where)
end function

public function long wf_crear_pdf (ref string as_archivo, string as_factura);PDFDocument lpdf_doc, lpdf_doc1
String ls_path
long ll_return
Integer li_result, li_FileNum
lpdf_doc = create PDFDocument
lpdf_doc1 = create PDFDocument
		
		if dw_5.rowcount() < 1 then
			gf_mensaje('','No hay Informacion para Generar el PDF, Verifique !!!',1,1,'E')
			return -1
		end if
		ls_path = "C:\Sistemas\Documentos"
 		as_archivo = ls_path+"\Factura_"+as_factura+".pdf"
		if not	cbx_2.checked then
			If Len(Trim(ls_path)) > 0 then			
				 dw_5.Modify ("DataWindow.Export.PDF.Method = NativePDF! ")
				 dw_5.modify("DataWindow.Export.PDF.NativePDF.PDFStandard =1")
				 ll_return =  lpdf_doc.importdatawindow(dw_5)
				 lpdf_doc.CompressionLevel = 9	
				 ll_return = lpdf_doc.save(as_archivo)
				 destroy lpdf_doc
			end if
		else
				ls_path = "C:\Sistemas\Comprobantes\"
				as_archivo = ls_path+"\Factura_"+as_factura+".pdf"
				PrintSetPrinter ("Bullzip PDF Printer")
				dw_5.Object.DataWindow.Printer = "Bullzip PDF Printer" // "Sybase DataWindow PS" //"Adobe DataWindow PS"
				dw_5.Object.DataWindow.Export.PDF.Method = Distill!
				dw_5.Object.DataWindow.Export.PDF.Distill.CustomPostScript="Yes"
				dw_5.Modify("datawindow.Export.PDF.Method = '1'")
				dw_5.print()		
				FileDelete(as_archivo)
				sleep(15)
				li_FileNum = FileCopy ("C:\Sistemas\Comprobantes\comprobante.pdf" , as_archivo, TRUE)		
				if li_FileNum <> 1 then
					gf_mensaje('','Error '+string(li_fileNum),1,1,'E')
				end if
		end if
return ll_return
end function

public function integer wf_send_mail (string as_archivo, string as_tag, string as_titulo, string as_correo);
//Variables Locales a ser usadas 
Integer	   li_Smtp_Puerto, i
Integer      li_max 
Integer      li_rc
Integer      li_idx
String 	   ls_Nombre_Archivo, ls_Remitente_Email, ls_Remitente_Usuario, ls_Remitente_contraseña, ls_Smtp_Servidor, ls_ToArray[], ls_tag
String 	   ls_Smtp_Tipo_Conexion, ls_Smtp_Puerto, ls_Destinatario_Email, ls_Destinatario_Nombre, ls_Asunto, ls_Mensaje, &
			   ls_Destinatario_Copia_Email, ls_Destinatario_Copia_Nombre, ls_Destinatario_Copia_Oculta_Email, ls_Destinatario_Copia_Oculta_Nombre
Boolean     lb_Return

// Creacion SmtpClient
SMTPClient lnv_SMTPClient
lnv_SMTPClient =  create SMTPClient

ls_tag = as_tag		//  ls_tag

//smtp-mail.outlook.com     Hotmail
//smtp.gmail.com                Gmail

// Setear el archivo log
	lnv_SMTPClient.LogFile("mail.log")

	SetPointer ( HourGlass! )
	
	//Reset SMTPClient Message
	lnv_SMTPClient.message.reset()

	// Los Datos del Remitente
	ls_Remitente_Email = ProfileString('config.ini', ls_tag, "SendEmail", "")
	lnv_SMTPClient.Message.SetSender(ls_Remitente_Email)
		
	// Los Datos de la conexion del Email Remitente
	ls_Remitente_Usuario = ProfileString('config.ini', ls_tag, "UserID", "")
	ls_Remitente_Contraseña = ProfileString('config.ini', ls_tag, "Password", "")
	IF ls_Remitente_Usuario <> ''  AND ls_Remitente_Contraseña <> '' THEN
		lnv_SMTPClient.Username =ls_Remitente_Usuario
		lnv_SMTPClient.password = ls_Remitente_Contraseña
	END IF

	// Los Datos del servidor
	ls_Smtp_Servidor = ProfileString('config.ini', ls_tag, "Server", "")
	lnv_SMTPClient.Host = ls_Smtp_Servidor
	
	// Los Datos del Puerto del Servidor
	ls_Smtp_Puerto = ProfileString('config.ini', ls_tag, "Port", "")
	IF IsNumber ( ls_Smtp_Puerto ) THEN
		li_Smtp_Puerto = Integer ( ls_Smtp_Puerto )
		lnv_SMTPClient.Port = li_Smtp_Puerto
	END IF

	// Los Datos del Destinatario
	ls_Destinatario_Email = ProfileString('config.ini', ls_tag, "FromEmail", "")	
	if len(ls_Destinatario_Email) > 0 and len(as_correo) > 0  then
		ls_Destinatario_Email = as_correo+', '+ls_Destinatario_Email
	else
		ls_Destinatario_Email = as_correo
	end if
	ls_Destinatario_Nombre = ProfileString('config.ini', ls_tag, "FromName", "")		
	ls_Destinatario_Email = gnv_sys.of_ReplaceAll(ls_Destinatario_Email,' ', '',False)
	ls_Destinatario_Email = gnv_sys.of_ReplaceAll(ls_Destinatario_Email,',', ';',False)
	gnv_sys.of_StringToArray(ls_Destinatario_Email,';', ls_ToArray[])
	For i = 1 To UpperBound(ls_ToArray[])
		lnv_SMTPClient.message.AddRecipient(ls_ToArray[i])
	Next 
	
	//IF ls_Destinatario_Email <> '' THEN
	//	lnv_SMTPClient.Message.AddRecipient(ls_Destinatario_Email ,ls_Destinatario_Nombre)
     //END IF
	  
	// Los Datos del Destinatario en Copia
	ls_Destinatario_Copia_Email = ProfileString('config.ini', ls_tag, "CopiaEmail", "")	
	ls_Destinatario_Copia_Nombre = ProfileString('config.ini', ls_tag, "CopiaName", "")	
	IF ls_Destinatario_Copia_Email <> '' THEN
		lnv_SMTPClient.Message.addcc(ls_Destinatario_Copia_Email,  ls_Destinatario_Copia_Nombre)
	END IF
	 
	 // Los Datos del Destinatario en Copia Oculta
	ls_Destinatario_Copia_Oculta_Email = ProfileString('config.ini', ls_tag, "CopiaOcultaEmail", "")	
	ls_Destinatario_Copia_Oculta_Nombre = ProfileString('config.ini', ls_tag, "CopiaOcultaName", "")	
	IF ls_Destinatario_Copia_Oculta_Email <> '' THEN
		lnv_SMTPClient.Message.addbcc(ls_Destinatario_Copia_Oculta_Email,  ls_Destinatario_Copia_Oculta_Nombre)
	END IF
	
	// Asunto del E-Mail
	ls_Asunto = ProfileString('config.ini', ls_tag, "Subject", "")		 
  	lnv_SMTPClient.Message.Subject = ls_Asunto + ' ' + as_titulo
	
	//Prioridad Alta
	lnv_SMTPClient.Message.priority = 2  
	
	//Cuerpo del Email
	ls_Mensaje = ProfileString('config.ini', ls_tag, "Body", "")		
	lnv_SMTPClient.Message.HtmlBody = ls_Mensaje

	lnv_SMTPClient.Message.AddAttachment( as_Archivo )
	
	li_rc = lnv_SMTPClient.Send()
	
	IF li_rc = 1 THEN
		 Messagebox('Atencion','Mail Enviado')
	ELSE
		 Messagebox('Atencion' ,'Email Error Enviando. Return ' + String(li_rc) + '.', StopSign!)
	END IF
	
	DESTROY lnv_SMTPClient

return li_rc
end function

on w_facturas_actualizadas.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.st_4=create st_4
this.dw_5=create dw_5
this.cbx_1=create cbx_1
this.dw_6=create dw_6
this.em_ann=create em_ann
this.st_2=create st_2
this.cbx_2=create cbx_2
this.cb_1=create cb_1
this.cbx_catalogo=create cbx_catalogo
this.dw_7=create dw_7
this.cb_2=create cb_2
this.cb_3=create cb_3
this.em_costo=create em_costo
this.dw_8=create dw_8
this.cb_4=create cb_4
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.dw_4
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.dw_5
this.Control[iCurrent+6]=this.cbx_1
this.Control[iCurrent+7]=this.dw_6
this.Control[iCurrent+8]=this.em_ann
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.cbx_2
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.cbx_catalogo
this.Control[iCurrent+13]=this.dw_7
this.Control[iCurrent+14]=this.cb_2
this.Control[iCurrent+15]=this.cb_3
this.Control[iCurrent+16]=this.em_costo
this.Control[iCurrent+17]=this.dw_8
this.Control[iCurrent+18]=this.cb_4
this.Control[iCurrent+19]=this.gb_4
end on

on w_facturas_actualizadas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.st_4)
destroy(this.dw_5)
destroy(this.cbx_1)
destroy(this.dw_6)
destroy(this.em_ann)
destroy(this.st_2)
destroy(this.cbx_2)
destroy(this.cb_1)
destroy(this.cbx_catalogo)
destroy(this.dw_7)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.em_costo)
destroy(this.dw_8)
destroy(this.cb_4)
destroy(this.gb_4)
end on

event ue_post_open;// Override
str_secuencia_doc lstr_sec
string ls_vienede, ls_where, ls_pedido, ls_dw
integer li_ann
long	 ll_recup
gnv_sys = Create n_cst_sys

//Para ocultar las opciones de consultas, cuando es Elbros
//if pos(gf_dg_nombre_empresa(),'ELBROS') > 0 then gf_fa_cambiar_titulos(this.menuid)

/* dw corresponde al datawindows que se desea imprimir, por tanto
   si desea asignarle otro nombre haga lo siguiente 
	dw = otro_nombre */

  SELECT isnull(max(forma_datawindow),'')  
    INTO :ls_dw  
    FROM faaforma  
   WHERE ( faaforma.forma_g_financiero = :str.g_financiero ) AND  
         ( faaforma.forma_empresa = :str.empresa ) AND  
         ( faaforma.forma_tipo_formato = 'FAC' )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al Seleccionar formato '+sqlca.sqlerrtext,1,1,'E')
	end if
	
if ls_dw = '' then ls_dw = 'dw_imprimir_factura'

dw_5.dataobject = ls_dw


dw_3.dataobject = "dw_co_fa_facturas_cab_det_det_99" //dw_co_fa_consulta_factura
//	dw_5.dataobject = "dw_imprimir_factura_gold" //dw_co_fa_consulta_factura


//Para inicializar el año
em_ann.text = string(year(date(gf_fecha_serv())))

dw = dw_1 
dw.settransobject(sqlca)
//dw.object.datawindow.readonly = 'yes'

dw_3.settransobject(sqlca)
dw_4.getchild("fact_no_pedido",idw_child)
idw_child.settransobject(sqlca)

st_nom_ventana.text = this.classname()

ls_where 	= wf_armar_sql()

idw_child.SetSQLSelect(ls_where)		//Setea el SQL al Child de Facturas

idw_child.retrieve()

idw_child.setfilter('fact_ann = '+em_ann.text)
idw_child.filter()

dw_4.settransobject(sqlca)
dw_4.InsertRow(0)
dw_4.setfocus()

dw_5.settransobject(sqlca)
dw_6.settransobject(sqlca)

datawindowchild ldwc_vendedor
dw_5.getchild('fadvenfa_vfac_vendedor', ldwc_vendedor)
ldwc_vendedor.settransobject(sqlca)
ldwc_vendedor.retrieve(str.g_financiero, str.empresa)

//facd_codigo_item

str.frame.SetMicroHelp ("Seleccione una Línea y Presione la Tecla Enter para Cargar la Información")

lstr_sec = Message.PowerObjectParm
if isvalid(lstr_sec) then 
	ls_pedido = lstr_sec.sec_manual
	li_ann	 = lstr_sec.ano
end if
if ls_pedido <> "" then
	
	if em_ann.text <> string(li_ann) then	
		em_ann.text = string(li_ann)
		idw_child.setfilter('fact_ann = '+em_ann.text)
		idw_child.filter()
	end if
	
	dw_4.setitem(1,"fact_no_pedido",ls_pedido)
	dw_4.accepttext()
	dw_4.trigger event itemchanged(1, dw.object, ls_pedido)	
end if


end event

event resize;//Override No borrar no tocar
dw_5.Width = newwidth - 30
dw_5.Height = newheight - 295
st_nom_ventana.y = newheight - (st_nom_ventana.height + 10)

end event

event key;//Override
end event

event open;call super::open;dw_5.visible = true
cbx_1.checked = true
dw_7.settransobject(sqlca)
dw = dw_5
dw_8.insertrow(1)
end event

event ue_imprimir;//override
dw = dw_5
OpenWithParm(w_dw_print_options, dw)
If Message.DoubleParm = -1 Then Return
dw.Print(True)

end event

event ue_print;//override
dw = dw_5
OpenWithParm(w_dw_print_options, dw)
If Message.DoubleParm = -1 Then Return
dw.Print(True)

end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_facturas_actualizadas
integer x = 1879
integer y = 1492
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_facturas_actualizadas
boolean visible = false
integer x = 41
integer y = 1752
integer width = 919
integer height = 64
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_facturas_actualizadas
event ue_down pbm_dwnkey
event ue_entercol ( )
integer x = 64
integer y = 268
integer width = 3474
integer height = 180
integer taborder = 130
string dataobject = "dw_co_fa_facturas_cab_det_99"
boolean border = false
boolean livescroll = false
end type

event dw_1::ue_down;// Si el Usuario Dio Enter

if key = Keyenter! Then
	This.Postevent("ue_entercol")
	return(2)
End If

end event

event dw_1::ue_entercol;String	ls_ped, ls_retorna, ls_tipo_fac
integer	li_pormayor, li_an

ls_ped = GetitemString(This.Getrow() ,"fatdiari_fact_no_pedido")		//No de pedido
ls_tipo_fac = GetitemString(This.Getrow() ,"fatdiari_fact_tipo")		//No de pedido
li_an = Getitemnumber(This.Getrow(),"fatdiari_fact_ann") //Por mayor o menor

ls_retorna = ls_ped+"="+ls_tipo_fac+"_"+string(li_an)	//Retorna el valor concatenado del pedido+"="+pormayor

CloseWithReturn(parent,ls_retorna)

end event

event dw_1::doubleclicked;call super::doubleclicked;this.triggerevent("ue_entercol")

end event

event dw_1::ue_microayuda;//OVERRIDE
// Evento que muestra una pequeña Ayuda dependiendo en que columna se encuentre el mouse

Integer li_pos, li_x, li_y
String ls_objeto, ls_col

ls_objeto = This.GetObjectAtPointer()
li_pos = pos  (ls_objeto,"~t")
ls_col = left (ls_objeto, li_pos - 1)


li_x	 = str.frame.GetActiveSheet ().PointerX () //- 900
li_y	 = str.frame.GetActiveSheet ().PointerY () //- 200

// Dependiendo de la Columna el Mensaje de Ayuda varía
CHOOSE CASE right(ls_col,2)
	CASE '_t'
//		messagebox("!","Invisible")
		If st_ayuda.Visible Then Return
		st_ayuda.Move (li_x, li_y)
		st_ayuda.Text 	= "Haga click para ordenar por la Columna de " + this.describe(ls_col+".text")
		st_ayuda.Width 	= Len (st_ayuda.Text) * 28
		st_ayuda.Visible = TRUE	
	CASE ELSE
	st_ayuda.Visible = FALSE
END CHOOSE

end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;string	ls_tipo, ls_pedido
integer	li_anio

if this.rowcount() = 0 then return
if currentrow = 0 then return

ls_tipo = this.getitemstring(currentrow,'fatdiari_fact_tipo')
ls_pedido = this.getitemstring(currentrow,'fatdiari_fact_no_pedido')
li_anio = this.getitemnumber(currentrow,'fatdiari_fact_ann')

this.selectrow(0,false)
this.selectrow(currentrow,true)
if dw_3.retrieve(str.g_financiero,str.empresa,ls_tipo,ls_pedido,li_anio) = 0 then return

end event

event dw_1::clicked;// Script que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
// en la misma columna.

string	ls_objeto
integer	li_pos


ls_objeto = This.GetObjectAtPointer()

li_pos = Pos(ls_objeto, "~t")
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

end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_facturas_actualizadas
boolean visible = false
integer x = 0
integer y = 0
integer width = 3657
integer height = 352
integer taborder = 0
long backcolor = 12639424
end type

type dw_2 from datawindow within w_facturas_actualizadas
event editchanged pbm_dwnchanging
boolean visible = false
integer x = 2382
integer y = 1496
integer width = 119
integer height = 68
integer taborder = 110
boolean bringtotop = true
string dataobject = "dw_texto_cab_det"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event editchanged;//// Última modificación: Gianni Araúz (28/09/2000)
//
//
//string	ls_formato, ls_setting, ls_estado
//date		ld_fecfin
//

////if dw_1.rowcount() = 0 then return
//
//if not rb_6.checked then
//	if trim(data) <> '' and not isnull(data) then
//		if match(data,"%") = true then return
//		
//		if rb_6.checked and trim(em_1.text) = '' then return
//		
//		// Permite Modificar el estado Con la Finalidad de que Funcione el Filtrado
//		ls_setting = dw_1.Describe("DataWindow.Retrieve.AsNeeded")
//		
//		if ls_setting = "yes" then dw_1.Modify("DataWindow.Retrieve.AsNeeded=No")	
//		
//		if rb_1.Checked = True then /*Cliente*/
//			ls_formato =  "String(dgmterce_terc_descripcion) like '"+data+"%'"
//		
//		elseif rb_2.Checked = True then /*Ruc*/
//			ls_formato =  "fatdiari_fact_ruc_cliente like '"+data+"%'"
//			
//		elseif rb_3.Checked = True then /*A Nombre*/
//			ls_formato =  "fatdiari_fact_a_nombre like '"+data+"%'"
//			
//		elseif rb_5.Checked = True then /*Estado*/
//			ls_formato =  "fatdiari_fact_estado like '"+data+"%'"
//			
//		elseif rb_6.Checked = True then /*Fecha*/
//			
//		elseif rb_7.Checked = True then /*Vendedor*/
//			ls_formato =  "nombre like '"+data+"%'"
//			
//		else /*pedido*/
//			if data = "N" then
//				ls_formato =  "String(fatdiari_fact_no_pedido)" + "like '"+data+"%'"
//			else	
//			  ls_formato =  "String(fatdiari_fact_no_pedido)" + "like '"+data+"%'"
//			end if
//		end if
//		
//		if ls_formato <> '' then
//			dw_1.SetFilter(ls_formato)
//			dw_1.Filter()
//		end if
//	else
//		dw_1.setfilter('')
//		dw_1.filter()
//	end if
//else
//	ld_fecfin = relativedate(date(em_2.text),1)
//	ls_formato = " fatdiari_fact_fecha >= date('"+em_1.text+"') And " + & 
//					"fatdiari_fact_fecha < date('"+string(ld_fecfin,'dd/mm/yyyy')+"')"
//	
//	if ls_formato <> '' then
//		dw_1.SetFilter(ls_formato)
//		dw_1.Filter()
//	end if
//end if
//
end event

type dw_3 from uos_in_datawindow_utility within w_facturas_actualizadas
integer x = 18
integer y = 508
integer width = 3598
integer height = 2144
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_co_fa_facturas_cab_det_det_99"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event rowfocuschanged;call super::rowfocuschanged;if this.rowcount() = 0 then return
if currentrow = 0 then return


this.selectrow(0,false)
this.selectrow(currentrow,true)

end event

type dw_4 from datawindow within w_facturas_actualizadas
event ue_down pbm_dwnkey
integer x = 1024
integer y = 48
integer width = 603
integer height = 88
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dw_change_factura_99"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_down;if keydown(keyEnd!) then
	dw_5.setfocus()
elseif keydown(KeyF1!) then
	parent.triggerevent('ue_buscar')
end if

end event

event itemchanged;string	ls_pedido,ls_tipo , ls_factura, ls_factura_ped, ls_correo
long		ll_ann, ll_tercero
datawindowchild idw
decimal{2} ldec_gastos
dw_4.accepttext()

//<>
If dw_4.GetColumnName() = "fact_no_pedido" Then 
	dw_4.getchild("fact_no_pedido",idw)
	idw.settransobject(sqlca)
	if idw.rowcount() > 0 then
		ls_pedido = idw.getitemstring(idw.getrow(),"fact_no_pedido") 
		ls_tipo = idw.getitemstring(idw.getrow(),"fact_tipo") 
		ll_ann = idw.getitemnumber(idw.getrow(),"fact_ann") 
		ls_factura =  idw.getitemstring(idw.getrow(),"fact_no_factura")
		ldec_gastos = idw.getitemnumber(idw.getrow(),"fact_gastos_total") 
	end if
	
	ls_factura_ped =  dw_4.getitemstring(1,"fact_no_pedido")

   if ls_factura <> ls_factura_ped then 
		if gf_mensaje('Factura no Registrada en el Sistema','Desea Revisar la más proxima ('+ls_factura+')',2,1,'E') = 2 then 
			return
		end if
	end if

   is_pedido = ls_pedido
	ii_ann = ll_ann
	is_tipo = ls_tipo
	
	dw_5.object.datawindow.print.preview = 'yes'		

	if dw_1.retrieve(str.g_financiero,str.empresa,ls_tipo,ls_pedido,ll_ann) > 0 then		
		if dw_3.retrieve(str.g_financiero,str.empresa,ls_tipo,ls_pedido,ll_ann) > 0 then
			if dw_5.retrieve(str.g_financiero,str.empresa,ls_pedido,ll_ann,ls_tipo) > 0 then
				if dw_6.retrieve(str.g_financiero,str.empresa,ls_pedido,ll_ann,ls_tipo) > 0 then
					/* */
				end if						
				
				ll_tercero = dw_5.getitemnumber(1,'fact_cliente')	
				
				  SELECT isnull(dgmterce.terc_email  ,'')
					 INTO :ls_correo  
					 FROM dgmterce  
					WHERE dgmterce.terc_tercero = :ll_tercero   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Buscar Correo '+sqlca.sqlerrtext,1,1,'E')
					end if
					if len(ls_correo) > 0 then
						dw_8.setitem(1,'correo',ls_correo)
					end if
				
				dw_5.setfocus()				
			else
				messagebox("Atención","No se recupero registros en la Vista Previa")
			end if
		else
			messagebox("Atención","No se recupero el registro en fatdiari")
		end if
	else
			messagebox("Atención","No se recupero el registro en faddiari")
	end if
end if

if ldec_gastos = 0 or isnull(ldec_gastos) then
	if dw_5.Describe("ver_cargos.x") <> "?" and dw_5.Describe("ver_cargos.x") <> "!" then &
		dw_5.object.ver_cargos.expression = "'" + string(1) + "'"
	dw_5.Modify("dw_1.visible = false") 		
else
	if dw_5.Describe("ver_cargos.x") <> "?" and dw_5.Describe("ver_cargos.x") <> "!" then &
		dw_5.object.ver_cargos.expression = "'" + string(0) + "'"
	dw_5.Modify("dw_1.visible = true") 
	str.subtotal = 'SUB TOTAL FOB:'
	str.total = 'TOTAL USD:'
end if

end event

type st_4 from statictext within w_facturas_actualizadas
integer x = 603
integer y = 60
integer width = 393
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Batang"
long textcolor = 33554432
long backcolor = 12639424
string text = "Factura #:"
boolean focusrectangle = false
end type

type dw_5 from datawindow within w_facturas_actualizadas
event ue_down pbm_dwnkey
event ue_microayuda pbm_nchittest
integer y = 264
integer width = 3648
integer height = 2352
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ma_fa_imp_union_logo"
boolean vscrollbar = true
boolean border = false
end type

event ue_down;if keydown(keyhome!) then
	dw_4.setfocus()
elseif keydown(Keyescape!) then
	parent.postevent('close')
elseif keydown(KeyF1!) then
	parent.triggerevent('ue_buscar')
end if

end event

event ue_microayuda;//override
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
	CASE 'fact_ruc_cliente'
		this.Modify("fact_ruc_cliente.Font.Underline='1'")
		this.Modify("fact_ruc_cliente.Color='16711680'")
	CASE 'facd_codigo_item'
		this.Modify("facd_codigo_item.Font.Underline='1'")
		this.Modify("facd_codigo_item.Color='7536640'")
	CASE 'fact_a_nombre'
		this.Modify("fact_a_nombre.Font.Underline='1'")
		this.Modify("fact_a_nombre.Color='7536640'")
	CASE ELSE
		this.Modify("fact_ruc_cliente.Font.Underline='0'")
		this.Modify("fact_ruc_cliente.Color='0'")
		this.Modify("facd_codigo_item.Font.Underline='0'")
		this.Modify("facd_codigo_item.Color='0'")
		this.Modify("fact_a_nombre.Font.Underline='0'")
		this.Modify("fact_a_nombre.Color='0'")
END CHOOSE
end event

event retrieveend;string	ls_empre,ls_numero_palabra, ls_saldo
decimal{2}  ld_final, ld_saldo

integer i , li_fraccion
String  ls_bultos
long    ll_bultos, ll_ultimo_bulto = 0, ll_tercero
double  ld_cantidad, ld_cantidad_total

if rowcount = 0 then return

//Ciclo en el que se asignan los rangos de los bultos 1/1, 2/8, 8/8, etc.
for i = 1 to rowcount
	ll_bultos = this.getitemnumber(i,"facd_bultos")
	if ll_bultos <> 0 and not isnull(ll_bultos) then
		ls_bultos = string(ll_ultimo_bulto + 1)+"/"+string(ll_ultimo_bulto + ll_bultos)
		ll_ultimo_bulto += ll_bultos
	end if
	this.setitem(i,"bultos",ls_bultos)
	
//Para el total de Docenas (Elbros), se Asume que todas las cantidades enteras son docenas
////y que las fracciones son piezas, si y solo si encuentra el compute tot_docenas
	if this.Describe("tot_docenas.x") <> "?" and dw.Describe("tot_docenas.x") <> "!" then
		ld_cantidad 		= this.getitemnumber(i,'facd_cantidad')
		li_fraccion 		= this.getitemnumber(i,'facd_cantidad_fraccion')
		ld_cantidad_total += ld_cantidad * 12 + li_fraccion
	end if
	
next

//Asigna el total de docenas solo para los dw que tienen el compute tot_docenas
if this.Describe("tot_docenas.x") <> "?" and dw.Describe("tot_docenas.x") <> "!" then
	ld_cantidad = round(ld_cantidad_total / 12,0)
	li_fraccion = mod(ld_cantidad_total,12)
	if li_fraccion > 0 then
		this.object.tot_docenas.expression = "'"+string(ld_cantidad)+" / "+string(li_fraccion)+"'"
	else
		this.object.tot_docenas.expression = "'"+string(ld_cantidad)+"'"
	end if
end if

////Funcion que busca y asigna los  vendedores involucrados en la factura
//
//// arturo de aqui hacia abajo
wf_imprime_vendedor()

//Para setear el nombre de la compañía al datawindow de impresión. Si existe
if dw_5.Describe("nom_empresa.x") <> "?" and dw_5.Describe("nom_empresa.x") <> "!" then
	ls_empre = gf_dg_nombre_empresa() 
	dw_5.object.nom_empresa.expression = "'"+ls_empre+"'"
end if	

	//Asigna el total final al compute de numero palabra
	ld_final = dw_5.getitemnumber(dw_5.rowcount(),"tot_fin")
	ls_numero_palabra = " *** "+upper(gf_numerlet( round(ld_final,2)  ,1))+" ***"
	//if simple
	if dw_5.Describe("num_palabra.x") <> "?" and dw_5.Describe("num_palabra.x") <> "!" then &
		dw_5.object.num_palabra.expression = "'" + ls_numero_palabra + "'"
		
	ll_tercero = dw_5.getitemnumber(1,'fact_cliente')
	ld_saldo = gf_saldo_anterior_new( ll_tercero, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)
	ls_saldo = string(ld_saldo, '$ ##,##0.00')
	if dw_5.Describe("saldo.x") <> "?" and dw_5.Describe("saldo.x") <> "!" then &
		dw_5.object.saldo.expression = "'" + ls_saldo + "'"

//
//////Verifica que si el campo de 4 decimales está activado, ponga el format a 4 en la impresion
//
////if tab_1.tabpage_1.dw_1.getitemNumber(tab_1.tabpage_1.dw_1.getrow(),"fact_cuatro_decimales") = 1 then
////	tab_1.tabpage_3.dw_3.object.facd_precio_unidad_producto.edit.format='###,##0.0000'
////	tab_1.tabpage_3.dw_3.object.facd_precio_unidad_producto.format='###,##0.0000'
////else 
////	tab_1.tabpage_3.dw_3.object.facd_precio_unidad_producto.edit.format='###,##0.00'	
////	tab_1.tabpage_3.dw_3.object.facd_precio_unidad_producto.format='###,##0.00'	
////end if	
end event

event clicked;string ls_column
ls_column = dwo.name
if ls_column = "facd_codigo_item" then
	
	if row = 0 then return
	
		Window lw_child_v				
		string ls_producto
		str_kardex  str_opcion
		
			str_opcion.opcion_menu = 'MCP'
			str_opcion.opcion_ventana    = 'P'
			str_opcion.dwpantalla     = 'dw_in_mcp_prod_kard_1'
			str_opcion.dwreporte      = 'dw_in_mcp_prod_kard_2'
			str_opcion.titulo_ventana = 'Movimientos de Productos (Kardex)'
			
			if dw_1.rowcount() > 0 then
				ls_producto = dw_5.getitemstring(dw_5.getrow(),'facd_codigo_item')				
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
		
elseif ls_column = 'fact_ruc_cliente' then
	str_cc_formatos str_formato1		
	str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	str_formato1.tercero = dw_5.getitemNumber(1,"fact_cliente")
	OpenSheetwithparm(w_mant_clientes,str_formato1,parent,2, Original!)

elseif ls_column = 'fact_a_nombre' then
	str_cc_formatos str_formato2		
	str_formato2.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	str_formato2.tercero = dw_5.getitemNumber(1,"fact_cliente")
	Opensheetwithparm(w_estadocuenta,str_formato2,str.frame,2,original!)
end if
end event

type cbx_1 from checkbox within w_facturas_actualizadas
integer x = 1769
integer y = 52
integer width = 581
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Batang"
long backcolor = 12639424
string text = "Vista Preliminar"
boolean lefttext = true
end type

event clicked;if cbx_1.checked = true then
  dw_5.visible = true
else
	dw_5.visible = false
end if
end event

type dw_6 from datawindow within w_facturas_actualizadas
boolean visible = false
integer x = 2359
integer y = 188
integer width = 1088
integer height = 672
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_ma_fa_carfactura"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;////Función que controla los totales de las lineas de detalle
wf_control_de_totales(rowcount)

////if w_fa_fondo.str_para.tipos_de_empaques = 1 then
//	wf_insertar_cargos(rowcount)
////end if
//
end event

type em_ann from editmask within w_facturas_actualizadas
integer x = 197
integer y = 36
integer width = 279
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###0"
boolean spin = true
double increment = 1
string minmax = "2000~~5000"
end type

event modified;//Para filtrar el child
idw_child.setfilter('fact_ann = '+em_ann.text)
idw_child.filter()
end event

type st_2 from statictext within w_facturas_actualizadas
integer x = 46
integer y = 60
integer width = 142
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Batang"
long textcolor = 33554432
long backcolor = 12639424
string text = "Año:"
boolean focusrectangle = false
end type

type cbx_2 from checkbox within w_facturas_actualizadas
integer x = 2487
integer y = 52
integer width = 517
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long textcolor = 33554432
long backcolor = 553648127
string text = "Factura Con Foto"
boolean lefttext = true
end type

event clicked;if this.checked then
	if str.empresa = 10 then
		dw_5.dataobject = 'dw_ma_fa_imp_texmundo_logo_foto'	
	else
		dw_5.dataobject = 'dw_ma_fa_imp_union_logo_foto'	
	end if
else
	if str.empresa = 10 then
		dw_5.dataobject = 'dw_ma_fa_imp_texmundo_logo'	
	else
		dw_5.dataobject = 'dw_ma_fa_imp_union_logo'
	end if
end if
dw_5.settransobject(sqlca)
dw_4.setfocus()
dw_4.setcolumn('fact_no_pedido')
dw_4.triggerevent('itemchanged')
end event

type cb_1 from commandbutton within w_facturas_actualizadas
integer x = 3141
integer y = 32
integer width = 402
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Copiar Fotos"
end type

event clicked;
integer i, li_FileNum, li_ann
string ls_foto, ls_producto, ls_path, ls_destino, ls_pedido, ls_foto_catalogo

ls_path = nv_f3.of_browseforfolder("Ruta de las Fotos ....",true)

if ls_path = '' or isnull(ls_path) then return

ls_pedido = idw_child.getitemstring(idw_child.getrow(),'fact_no_pedido')
li_ann = integer(em_ann.text)

 DECLARE cur_productos CURSOR FOR  
  SELECT faddiari.facd_codigo_item,   
         inmprodu.prod_foto_dir,
		inmprodu.prod_foto_catalogo
    FROM faddiari,   
         inmprodu  
   WHERE ( inmprodu.prod_g_financiero = faddiari.facd_g_financiero ) and  
         ( inmprodu.prod_empresa = faddiari.facd_empresa ) and  
         ( inmprodu.prod_producto = faddiari.facd_codigo_item ) and  
         ( ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
         ( faddiari.facd_empresa = :str.empresa ) AND  
         ( faddiari.facd_no_pedido = :ls_pedido ) AND  
         ( faddiari.facd_ann = :li_ann ) )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Declarar Cursor '+sqlca.sqlerrtext,1,1,'E')
			return
		end if
		
		open cur_productos;
		
		fetch cur_productos into :ls_producto, :ls_foto, :ls_foto_catalogo;
		
		do while sqlca.sqlcode = 0
			yield()
			ls_destino = ls_path + '\'+ls_producto+'.jpg'
			if cbx_catalogo.checked then
				li_FileNum = CopyFile (ls_foto_catalogo , ls_destino, 0)
			else
				li_FileNum = CopyFile (ls_foto , ls_destino, 0)
			end if
				if li_Filenum <> 1 then
					gf_mensaje('','Error al Copiar ...'+string(li_Filenum)+ ' Producto '+ls_producto,1,1,'E')
				end if
			fetch cur_productos into :ls_producto, :ls_foto, :ls_foto_catalogo;
		loop
		
		close cur_productos;
		
		gf_mensaje('','Copia Exitosa...',1,1,'E')
end event

type cbx_catalogo from checkbox within w_facturas_actualizadas
integer x = 3575
integer y = 48
integer width = 727
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Copiar Fotos de Catálogo"
end type

type gb_4 from gb_1 within w_facturas_actualizadas
boolean visible = true
integer y = 456
integer width = 3653
integer height = 2224
integer taborder = 140
long backcolor = 79416533
end type

type dw_7 from datawindow within w_facturas_actualizadas
boolean visible = false
integer x = 3680
integer y = 612
integer width = 2181
integer height = 624
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "aa_actualizar_costos_facturas"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_facturas_actualizadas
boolean visible = false
integer x = 3749
integer y = 348
integer width = 402
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recuperar"
end type

event clicked;string ls_factura
integer li_ann
decimal{2} ld_costos

li_ann = integer(em_ann.text)
ls_factura = dw_4.getitemstring(1,'fact_no_pedido')

if dw_7.retrieve(str.g_financiero, str.empresa, ls_factura, li_ann) > 0 then
	  SELECT fatdiari.fact_costos_total  
    INTO :ld_costos  
    FROM fatdiari  
   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
         ( fatdiari.fact_empresa = :str.empresa ) AND  
         ( fatdiari.fact_no_factura = :ls_factura ) AND  
         ( fatdiari.fact_ann = :li_ann )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Buscar Costos '+sqlca.sqlerrtext,1,1,'E')
		end if
		em_costo.text = string(ld_costos)
	
end if
end event

type cb_3 from commandbutton within w_facturas_actualizadas
boolean visible = false
integer x = 4233
integer y = 356
integer width = 402
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event clicked;string ls_factura
integer li_ann
decimal{2} ld_monto
li_ann = integer(em_ann.text)
ls_factura = dw_4.getitemstring(1,'fact_no_pedido')

ld_monto = double(em_costo.text)

  UPDATE coddiari  
     SET ddia_monto = :ld_monto  
   WHERE ( coddiari.ddia_g_financiero = :str.g_financiero ) AND  
         ( coddiari.ddia_empresa = :str.empresa ) AND  
         ( coddiari.ddia_aplicacion_mg = 'FA' ) AND  
         ( coddiari.ddia_tipo_transaccion = 'CV' ) AND  
         ( coddiari.ddia_sub_trans = 'CV' ) AND  
         ( coddiari.ddia_no_documento = :ls_factura ) AND  
         ( coddiari.ddia_ann = :li_ann )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al actualizar monto '+sqlca.sqlerrtext,1,1,'E')
			return
		end if
		
  UPDATE cotdiari  
     SET diar_monto = :ld_monto  
   WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
         ( cotdiari.diar_empresa = :str.empresa ) AND  
         ( cotdiari.diar_aplicacion_mg = 'FA' ) AND  
         ( cotdiari.diar_tipo_transaccion = 'CV' ) AND  
         ( cotdiari.diar_sub_trans = 'CV' ) AND  
         ( cotdiari.diar_no_documento = :ls_factura ) AND  
         ( cotdiari.diar_ann = :li_ann )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al actualizar monto encabezado '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return
		end if
		
commit;

end event

type em_costo from editmask within w_facturas_actualizadas
boolean visible = false
integer x = 3954
integer y = 472
integer width = 402
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
string text = "0.00"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
end type

type dw_8 from datawindow within w_facturas_actualizadas
integer x = 27
integer y = 148
integer width = 1248
integer height = 104
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_correos"
boolean border = false
boolean livescroll = true
end type

type cb_4 from commandbutton within w_facturas_actualizadas
integer x = 1294
integer y = 148
integer width = 343
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Enviar"
end type

event clicked;integer i, li_return
long ll_tercero
string  ls_foto, ls_path, ls_archivo, ls_tag, ls_nombre, ls_fecha, ls_correo, ls_pedido, ls_factura
dw_8.accepttext()
	ls_tag = 'Factura'
	ls_nombre = dw_5.getitemstring(1,'fact_a_nombre')
	ls_fecha = string(dw_5.getitemdatetime(1,'fact_fecha'),'dd/MMM/yyyy')
	ls_correo = dw_8.getitemstring(1,'correo')
	ls_factura = dw_5.getitemstring(1,'fact_no_factura')
	ll_tercero = dw_5.getitemnumber(1,'fact_cliente')
	if len(ls_correo) = 0 or pos(ls_correo,'@') = 0 then
		gf_mensaje('','Se Requiere un Correo Valido, Verifique !!!',1,1,'E')
		return
	end if
	
	wf_crear_pdf(ls_archivo, ls_factura)		
	li_return = wf_send_mail(ls_archivo, ls_tag, ' '+ls_factura+ ' - '+ls_nombre + ' del ' +ls_fecha, ls_correo)	
	
//	if li_return = 1 then
//		  UPDATE dgmterce  
//		  SET terc_email = :ls_correo  
//		WHERE dgmterce.terc_tercero = :ll_tercero   ;
//		if sqlca.sqlcode = -1 then
//			gf_mensaje('','Error al Guardar Correo '+sqlca.sqlerrtext,1,1,'E')
//		end if
//	end if
end event

