//objectcomments Consulta de Facturas
forward
global type w_fa_co_facturas_cab_det_99 from w_fa_padre_reportes
end type
type dw_2 from datawindow within w_fa_co_facturas_cab_det_99
end type
type st_1 from statictext within w_fa_co_facturas_cab_det_99
end type
type dw_4 from datawindow within w_fa_co_facturas_cab_det_99
end type
type st_4 from statictext within w_fa_co_facturas_cab_det_99
end type
type cbx_1 from checkbox within w_fa_co_facturas_cab_det_99
end type
type dw_6 from datawindow within w_fa_co_facturas_cab_det_99
end type
type cb_1 from commandbutton within w_fa_co_facturas_cab_det_99
end type
type dw_3 from uos_in_datawindow_utility within w_fa_co_facturas_cab_det_99
end type
type gb_4 from gb_1 within w_fa_co_facturas_cab_det_99
end type
type dw_5 from datawindow within w_fa_co_facturas_cab_det_99
end type
type cb_2 from commandbutton within w_fa_co_facturas_cab_det_99
end type
end forward

global type w_fa_co_facturas_cab_det_99 from w_fa_padre_reportes
integer x = 5
integer y = 20
integer width = 3621
integer height = 1920
string title = "Consulta de Facturas con Detalle"
string menuname = ""
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event ue_buscar ( )
dw_2 dw_2
st_1 st_1
dw_4 dw_4
st_4 st_4
cbx_1 cbx_1
dw_6 dw_6
cb_1 cb_1
dw_3 dw_3
gb_4 gb_4
dw_5 dw_5
cb_2 cb_2
end type
global w_fa_co_facturas_cab_det_99 w_fa_co_facturas_cab_det_99

type variables
string  is_tipo,is_pedido
integer ii_ann, ii_child_row

datawindowchild idw_child
end variables

forward prototypes
public subroutine wf_fecha ()
public subroutine wf_nofecha ()
public subroutine wf_imprime_vendedor ()
public subroutine wf_insertar_cargos (long al_filas)
public function string wf_verificar (string ls_original)
public subroutine wf_control_de_totales (long al_rowcount)
public function string wf_armar_sql ()
end prototypes

event ue_buscar;string  ls_factura, ls_syntax
integer li_pos, li_pos2
str_dg_dynamic_find lstr_df


lstr_df.texto_campo[1, 1] = "fatdiari.fact_a_nombre"
lstr_df.texto_campo[1, 2] = "A Nombre"
lstr_df.texto_campo[1, 3] = ""
lstr_df.texto_campo[1, 4] = "V"
lstr_df.texto_campo[1, 5] = "700"

lstr_df.texto_campo[2, 1] = "fatdiari.fact_no_pedido"
lstr_df.texto_campo[2, 2] = "Pedido"
lstr_df.texto_campo[2, 3] = "fatdiari.fact_no_pedido"
lstr_df.texto_campo[2, 4] = "V"

lstr_df.texto_campo[3, 1] = "fatdiari.fact_no_factura"
lstr_df.texto_campo[3, 2] = "Factura"
lstr_df.texto_campo[3, 3] = "fact_no_factura"
lstr_df.texto_campo[3, 4] = "V"

lstr_df.texto_campo[4, 1] = "fatdiari.fact_fecha"
lstr_df.texto_campo[4, 2] = "Fecha"
lstr_df.texto_campo[4, 3] = ""
lstr_df.texto_campo[4, 4] = "V"
lstr_df.texto_campo[4, 5] = "270"

lstr_df.texto_campo[5, 1] = "fatdiari.fact_ann"
lstr_df.texto_campo[5, 2] = "Año"
lstr_df.texto_campo[5, 3] = ""
lstr_df.texto_campo[5, 4] = "V"

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

OpenWithParm(w_dg_a_custom_find, lstr_df)

ls_syntax = message.stringparm
if ls_syntax = '' then return

String ls_pedido, ls_chil_string
Long ll_find
li_pos = pos(ls_syntax,"'")
li_pos2 = pos(ls_syntax,"'",li_pos + 1)

ls_factura = mid(ls_syntax,li_pos+1, li_pos2 - li_pos - 1)

ls_syntax = mid(ls_syntax,li_pos2 - li_pos + 1,len(ls_syntax))

li_pos = pos(ls_syntax,"'")
li_pos2 = pos(ls_syntax,"'",li_pos + 1)
ls_pedido = mid(ls_syntax,li_pos+1, li_pos2 - li_pos - 1)

dw_4.setitem(1,'fact_no_pedido',ls_factura)

ls_chil_string = "fatdiari.fact_no_pedido+fatdiari.fact_no_pedido="+"'"+ls_pedido+ls_factura+"'"

ll_find = idw_child.Find(ls_chil_string,1,idw_child.rowcount())

If ll_find > 0 then idw_child.scrolltorow(ll_find)

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

public function string wf_verificar (string ls_original);//Se verifican las opciones de parámetros y se filtra
string ls_where
  
//  if w_fa_fondo.str_para.mostrar <> 0 then  //mostrar un Año específico

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
//  end if
return(ls_where)
end function

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
	ldw_3.setitem(li_linea,"facd_bulto_inicio",9999997)	
	ldw_3.setitem(li_linea,"facd_bulto_fin",9999997)		
 
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
		ldw_3.setitem(li_linea,"facd_bulto_inicio",9999998)	
		ldw_3.setitem(li_linea,"facd_bulto_fin",9999998)		
	 
 //**********************************************************************************// 
	 
	 ldw_3.setitem(li_linea,"facd_monto_final",ld_monto)	
	 ldw_3.setitem(li_linea,"car_descripcion",trim(ls_descrip)+":")	
	 ldw_3.setitem(li_linea,"grupo",1)	
	 ldw_3.setitem(li_linea,"linea_subt",0)	
	 ld_total     += ld_monto //Acumula el total
	 
next

	 
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
	ldw_3.setitem(li_linea,"facd_bulto_inicio",9999999)	
	ldw_3.setitem(li_linea,"facd_bulto_fin",9999999)		

ldw_3.groupcalc ()
	 

end subroutine

public function string wf_armar_sql ();// Función que arma el Sql de el DataWindow, y dependiendo de donde se llama, factura o consultas
// Filtra segun parámetros iniciales o no
string ls_where, ls_original

ls_original = idw_child.GetsqlSelect()

ls_where = wf_verificar(ls_original)

return(ls_where)
end function

on w_fa_co_facturas_cab_det_99.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.st_1=create st_1
this.dw_4=create dw_4
this.st_4=create st_4
this.cbx_1=create cbx_1
this.dw_6=create dw_6
this.cb_1=create cb_1
this.dw_3=create dw_3
this.gb_4=create gb_4
this.dw_5=create dw_5
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_4
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.cbx_1
this.Control[iCurrent+6]=this.dw_6
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.gb_4
this.Control[iCurrent+10]=this.dw_5
this.Control[iCurrent+11]=this.cb_2
end on

on w_fa_co_facturas_cab_det_99.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.dw_4)
destroy(this.st_4)
destroy(this.cbx_1)
destroy(this.dw_6)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.gb_4)
destroy(this.dw_5)
destroy(this.cb_2)
end on

event ue_post_open;// Override

string ls_vienede, ls_where
long	 ll_recup

/* dw corresponde al datawindows que se desea imprimir, por tanto
   si desea asignarle otro nombre haga lo siguiente 
	dw = otro_nombre */

//if w_fa_fondo.str_para.utiliza_decimales = 1 then
//	dw_3.dataobject = "dw_co_fa_facturas_cab_det_det_999" //dw_co_fa_consulta_factura
//	dw_5.dataobject = "dw_ma_fa_imp_textiles3" //dw_co_fa_consulta_factura ?? No lo encuentro

//else
//   if w_fa_fondo.str_para.mostrar_producto_dos = 0 then
//		dw_3.dataobject = "dw_co_fa_facturas_cab_det_det_99" //dw_co_fa_consulta_factura
//		dw_5.dataobject = "dw_ma_fa_imp_tempo2" //dw_co_fa_consulta_factura

//		if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 then
//			dw_5.dataobject = "dw_ma_fa_imp_consulta_deta_acisa" 
//		end if

//	else
//		dw_3.dataobject = "dw_co_fa_facturas_cab_det_99_electro" //dw_co_fa_consulta_factura

//		if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 then
//			dw_5.dataobject = "dw_ma_fa_imp_consulta_deta_acisa" 
//		else
//			dw_5.dataobject = "dw_ma_fa_imp_tempo2_electro" //dw_co_fa_consulta_factura
//		end if
//	end if
//end if

dw = dw_1 
dw.settransobject(sqlca)
dw.object.datawindow.readonly = 'yes'

dw_3.settransobject(sqlca)
dw_4.getchild("fact_no_pedido",idw_child)
idw_child.settransobject(sqlca)

st_nom_ventana.text = this.classname()

ls_where 	= wf_armar_sql()

idw_child.SetSQLSelect(ls_where)		//Setea el SQL al Child de Facturas

idw_child.retrieve()

 
dw_4.settransobject(sqlca)
dw_4.InsertRow(0)
dw_4.setfocus()


dw_5.settransobject(sqlca)
dw_6.settransobject(sqlca)

str.frame.SetMicroHelp ("Seleccione una Línea y Presione la Tecla Enter para Cargar la Información")



end event

event resize;//Override No borrar no tocar
long ll_dw_ancho,ll_dw_alto
ll_dw_ancho = newwidth - 30
ll_dw_alto  = newheight - 245

dw_5.Resize(ll_dw_ancho+30, ll_dw_alto)
dw_3.Resize(ll_dw_ancho - 40, ll_dw_alto - 255)
gb_4.Resize(dw_3.width+70, dw_3.height+70)
gb_1.width = gb_4.width
st_nom_ventana.y = newheight - (st_nom_ventana.height + 10)

end event

event key;//Override
end event

event open;call super::open;this.width = str.frame.WorkSpaceWidth() - 35
this.height= str.frame.WorkSpaceHeight() - 210
this.x = 0
this.y = 0
dw_5.visible = true
cbx_1.checked = true
end event

event ue_imprimir;OpenWithParm(w_dw_print_options, dw_5)
If Message.DoubleParm = -1 Then Return
dw_5.Print(True)

end event

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_co_facturas_cab_det_99
integer x = 41
integer y = 1752
integer width = 919
integer height = 64
end type

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_co_facturas_cab_det_99
integer x = 1879
integer y = 1492
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_co_facturas_cab_det_99
event ue_down pbm_dwnkey
event ue_entercol ( )
integer x = 64
integer y = 164
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

st_1.text = 'Fila '+string(currentrow)+' de '+string(this.rowcount())

this.selectrow(0,false)
this.selectrow(currentrow,true)
if dw_3.retrieve(str.g_financiero,str.empresa,ls_tipo,ls_pedido,li_anio) = 0 then return

end event

event dw_1::clicked;// Script que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
// en la misma columna.

string	ls_objeto
integer	li_pos

if this.rowcount() = 0 then
	st_1.text = 'Fila 0 de 0'
	return
end if
	
if row = 0 then
	st_1.text = 'Fila 0 de '+string(this.rowcount())
	return
end if

st_1.text = 'Fila '+string(row)+' de '+string(this.rowcount())

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

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_co_facturas_cab_det_99
integer x = 0
integer y = 0
integer width = 3579
integer height = 352
integer taborder = 0
end type

type dw_2 from datawindow within w_fa_co_facturas_cab_det_99
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

type st_1 from statictext within w_fa_co_facturas_cab_det_99
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

type dw_4 from datawindow within w_fa_co_facturas_cab_det_99
event ue_down pbm_dwnkey
integer x = 690
integer y = 52
integer width = 603
integer height = 88
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dw_change_factura_99_campo"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_down;if keydown(keyEnd!) then
	dw_5.setfocus()
elseif keydown(KeyF1!) then
	parent.triggerevent('ue_buscar')
end if

end event

event itemchanged;string	ls_pedido,ls_tipo ,ls_factura
long		ll_ann
datawindowchild idw

dw_4.accepttext()

If dw_4.GetColumnName() = "fact_no_pedido" Then 
	ls_factura = dw_4.getItemString(1,'fact_no_pedido')
	dw_5.reset()
	
	if len(ls_factura) <=15 then	/*Es factura editada*/
		string ls_chil_string
		Long	ll_find
		Integer	li_pos, li_pos2
		
		if ls_factura ='0' then
			messagebox('Atención ','Para recuperar un documento con factura No. 0 (cero) debe seleccionar de la lista o buscarlo con F1 ...!!')
			return
		end if
		ls_factura = trim(ls_factura)+' '
		li_pos = pos(ls_factura," ",1)
		ls_factura = mid(ls_factura,1, li_pos -1)
		
		ls_chil_string = "fatdiari.fact_no_factura="+"'"+ls_factura+"'"
		
		ll_find = idw_child.Find(ls_chil_string,1,idw_child.rowcount())
		
		If ll_find > 0 then 
			idw_child.scrolltorow(ll_find)
		else
			dw_5.reset()
			messagebox('Atención ','Factura no Existe ....!!')
			return
		end if
	end if

	/**/
	idw_child.scrolltorow(idw_child.getrow())
	
	ii_child_row = idw_child.getrow()  /*Recuperar en el botón*/

	ls_pedido	= idw_child.getitemstring(ii_child_row,'fact_no_pedido')
	ls_tipo 		= idw_child.getitemstring(ii_child_row,"fact_tipo") 
	ll_ann 		= idw_child.getitemnumber(ii_child_row,"fact_ann") 
	ls_factura  = idw_child.getitemstring(ii_child_row,'fact_no_factura')
   is_pedido 	= ls_pedido
	ii_ann 		= ll_ann
	is_tipo 		= ls_tipo

	dw_5.object.datawindow.print.preview = 'yes'		

	if dw_1.retrieve(str.g_financiero,str.empresa,ls_tipo,ls_pedido,ll_ann) > 0 then		
		if dw_3.retrieve(str.g_financiero,str.empresa,ls_tipo,ls_pedido,ll_ann) > 0 then
			if dw_5.retrieve(str.g_financiero,str.empresa,ls_pedido,ll_ann,ls_tipo) > 0 then
				if dw_6.retrieve(str.g_financiero,str.empresa,ls_pedido,ll_ann,ls_tipo) > 0 then
					/* */
				end if						
				dw_5.setfocus()				
			else
				messagebox("Atención","No se recupero registros en la Vista Previa")
			end if
		else
			messagebox("Atención","Factura no tine detalle")
		end if
	else
			messagebox("Atención","Factura no Existe, Verifique")
	end if
end if


if dw_1.rowcount() > 0 then 
	dw_4.setitem(dw_4.getrow(),'fact_no_pedido',dw_1.getitemstring(1,'fatdiari_fact_no_factura') )

	DW_4.ACCEPTTEXT()
end if

end event

type st_4 from statictext within w_fa_co_facturas_cab_det_99
integer x = 64
integer y = 64
integer width = 603
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Número de Factura:"
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_fa_co_facturas_cab_det_99
integer x = 1362
integer y = 64
integer width = 411
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Vista Previa"
boolean lefttext = true
end type

event clicked;if cbx_1.checked = true then
  dw_5.visible = true
else
	dw_5.visible = false
end if
end event

type dw_6 from datawindow within w_fa_co_facturas_cab_det_99
boolean visible = false
integer x = 2075
integer y = 200
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

end event

type cb_1 from commandbutton within w_fa_co_facturas_cab_det_99
integer x = 1851
integer y = 52
integer width = 402
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recuperar"
end type

event clicked;string	ls_pedido,ls_tipo 
long		ll_ann


dw_4.accepttext()
	
	If ii_child_row <=0 then return
	
	idw_child.scrolltorow(ii_child_row)

	
	ls_pedido	= idw_child.getitemstring(idw_child.getrow(),'fact_no_pedido')

	ls_tipo = idw_child.getitemstring(idw_child.getrow(),"fact_tipo") 
	ll_ann = idw_child.getitemnumber(idw_child.getrow(),"fact_ann") 
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
				dw_5.setfocus()				
			else
				messagebox("Atención","No se recupero registros en la Vista Previa")
				dw_5.reset()
			end if
		else
			messagebox("Atención","No se recupero el registro en faddiari")
			dw_5.reset()
		end if
	else
			messagebox("Atención","No se recupero el registro en fatdiari")
			dw_5.reset()
	end if

if dw_1.rowcount() > 0 then 
	dw_4.setitem(dw_4.getrow(),'fact_no_pedido',dw_1.getitemstring(1,'fatdiari_fact_no_factura') )
	DW_4.ACCEPTTEXT()
end if 


end event

type dw_3 from uos_in_datawindow_utility within w_fa_co_facturas_cab_det_99
integer x = 18
integer y = 404
integer width = 3543
integer height = 1288
integer taborder = 30
string dataobject = "dw_co_fa_facturas_cab_det_det_99"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event rowfocuschanged;call super::rowfocuschanged;if this.rowcount() = 0 then return
if currentrow = 0 then return

st_1.text = 'Fila '+string(currentrow)+' de '+string(this.rowcount())

this.selectrow(0,false)
this.selectrow(currentrow,true)

end event

event clicked;call super::clicked;if this.rowcount() = 0 then
	st_1.text = 'Fila 0 de 0'
	return
end if
	
if row = 0 then
	st_1.text = 'Fila 0 de '+string(this.rowcount())
	return
end if

st_1.text = 'Fila '+string(row)+' de '+string(this.rowcount())

end event

event doubleclicked;call super::doubleclicked;string         ls_pointer
datetime       ldt_fecha1
window		   lw_child
str_rangofecha	str_rangofecha_opcion
str_fa_bus_var str_busqueda

//If pos(upper(str.nombre_empresa),'ELECTROVISION') > 0 Then 
if w_fa_fondo.str_aplica_links.habilita_links = 1	then
	ls_pointer = dw_3.GetObjectAtPointer()
	if pos(ls_pointer,'facd_codigo_item') > 0 then 
		str_rangofecha_opcion.opcion = 'Kardex'
		str_rangofecha_opcion.tipo_informe = '(IN) Movimientos/Costos/Precios de Productos (Kardex) '
		str_rangofecha_opcion.orden = dw_3.getitemstring(dw_3.getrow(),'facd_codigo_item')
		if w_fa_fondo.str_aplica_links.inventario_activa_in = 'A' then
			OpenSheetWithParm(lw_child,str_rangofecha_opcion,"w_fa_movi_prod_kardex",str.frame,11,Original!)
		end if
	end if
end if

//	dw_3.Object.dmov_secuencia.Pointer = 'Cross!'

end event

type gb_4 from gb_1 within w_fa_co_facturas_cab_det_99
integer y = 352
integer width = 3584
integer height = 1364
integer taborder = 140
end type

type dw_5 from datawindow within w_fa_co_facturas_cab_det_99
event ue_down pbm_dwnkey
integer x = 5
integer y = 164
integer width = 3538
integer height = 1528
integer taborder = 20
string title = "none"
string dataobject = "dw_ma_fa_imp_tempo2"
boolean hscrollbar = true
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

event retrieveend;string	ls_empre,ls_numero_palabra
decimal  ld_final

integer i , li_fraccion
String  ls_bultos
long    ll_bultos, ll_ultimo_bulto = 0
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


end event

event doubleclicked;string         ls_pointer
datetime       ldt_fecha1
long           li_fila
window		   lw_child
str_rangofecha	str_rangofecha_opcion
str_fa_bus_var str_busqueda

//If pos(upper(str.nombre_empresa),'ELECTROVISION') > 0 Then 
if w_fa_fondo.str_aplica_links.habilita_links = 1	then
	ls_pointer = dw_5.GetObjectAtPointer()
	if pos(ls_pointer,'codigo') > 0 then 
		li_fila = integer(trim(mid(ls_pointer,7)))
	else
		if pos(ls_pointer,'fact_no_factura') > 0  then 
			li_fila = integer(trim(mid(ls_pointer,16)))
		else
			if pos(ls_pointer,'num_factura') > 0  then 
				li_fila = integer(trim(mid(ls_pointer,12)))
         end if			
		end if
	end if
	if pos(ls_pointer,'codigo') > 0 then 
		str_rangofecha_opcion.opcion = 'Kardex'
		str_rangofecha_opcion.tipo_informe = '(IN) Movimientos/Costos/Precios de Productos (Kardex) '
		str_rangofecha_opcion.orden = dw_5.getitemstring(li_fila,'facd_codigo_item')
		if w_fa_fondo.str_aplica_links.inventario_activa_in = 'A' then
			OpenSheetWithParm(lw_child,str_rangofecha_opcion,"w_fa_movi_prod_kardex",str.frame,11,Original!)
		end if
	else
		if pos(ls_pointer,'fact_no_factura') > 0  then 
			str_rangofecha_opcion.opcion = 'Kardex'
			str_rangofecha_opcion.ano = dw_5.getitemnumber(li_fila,'fact_ann')
			str_rangofecha_opcion.orden = dw_5.getitemstring(li_fila,'fact_no_factura')
			OpenSheetWithParm(lw_child,str_rangofecha_opcion,"w_fa_rep_ventas_fac_imp_new",str.frame,11,Original!)
		else
			if pos(ls_pointer,'num_factura') > 0  then 
				str_rangofecha_opcion.opcion = 'Kardex'
				str_rangofecha_opcion.ano = dw_5.getitemnumber(li_fila,'fact_ann')
				str_rangofecha_opcion.orden = dw_5.getitemstring(li_fila,'fact_no_factura')
				OpenSheetWithParm(lw_child,str_rangofecha_opcion,"w_fa_rep_ventas_fac_imp_new",str.frame,11,Original!)
			end if
		end if
	end if
end if

//	dw_3.Object.dmov_secuencia.Pointer = 'Cross!'

end event

type cb_2 from commandbutton within w_fa_co_facturas_cab_det_99
integer x = 2309
integer y = 52
integer width = 402
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir"
end type

event clicked;OpenWithParm(w_dw_print_options, dw_5)
If Message.DoubleParm = -1 Then Return
dw_5.Print(True)

end event

