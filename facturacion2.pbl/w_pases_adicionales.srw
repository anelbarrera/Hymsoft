//objectcomments Ventana de PAse de Pedido a Factura
forward
global type w_pases_adicionales from w_fa_padre_reportes
end type
type gb_3 from groupbox within w_pases_adicionales
end type
type rb_1 from radiobutton within w_pases_adicionales
end type
type rb_2 from radiobutton within w_pases_adicionales
end type
type dw_2 from datawindow within w_pases_adicionales
end type
type rb_4 from radiobutton within w_pases_adicionales
end type
type rb_5 from radiobutton within w_pases_adicionales
end type
type rb_6 from radiobutton within w_pases_adicionales
end type
type pb_1 from picturebutton within w_pases_adicionales
end type
type em_1 from editmask within w_pases_adicionales
end type
type em_2 from editmask within w_pases_adicionales
end type
type st_2 from statictext within w_pases_adicionales
end type
type st_3 from statictext within w_pases_adicionales
end type
type pb_2 from picturebutton within w_pases_adicionales
end type
type rb_7 from radiobutton within w_pases_adicionales
end type
type gb_2 from groupbox within w_pases_adicionales
end type
type rb_3 from radiobutton within w_pases_adicionales
end type
type cb_1 from commandbutton within w_pases_adicionales
end type
type cb_2 from commandbutton within w_pases_adicionales
end type
type cb_pedi_sala from commandbutton within w_pases_adicionales
end type
type sle_pedido from singlelineedit within w_pases_adicionales
end type
type st_1 from statictext within w_pases_adicionales
end type
type ddlb_1 from dropdownlistbox within w_pases_adicionales
end type
type st_4 from statictext within w_pases_adicionales
end type
type dw_3 from datawindow within w_pases_adicionales
end type
type cbx_pendiente from checkbox within w_pases_adicionales
end type
type st_5 from statictext within w_pases_adicionales
end type
type em_ann from editmask within w_pases_adicionales
end type
type st_6 from statictext within w_pases_adicionales
end type
type em_ann_pedidos from editmask within w_pases_adicionales
end type
end forward

global type w_pases_adicionales from w_fa_padre_reportes
integer x = 503
integer y = 400
integer width = 2921
integer height = 1528
string title = "Pases Adicionales"
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 12639424
event ue_pasarow ( )
event ue_pase ( )
gb_3 gb_3
rb_1 rb_1
rb_2 rb_2
dw_2 dw_2
rb_4 rb_4
rb_5 rb_5
rb_6 rb_6
pb_1 pb_1
em_1 em_1
em_2 em_2
st_2 st_2
st_3 st_3
pb_2 pb_2
rb_7 rb_7
gb_2 gb_2
rb_3 rb_3
cb_1 cb_1
cb_2 cb_2
cb_pedi_sala cb_pedi_sala
sle_pedido sle_pedido
st_1 st_1
ddlb_1 ddlb_1
st_4 st_4
dw_3 dw_3
cbx_pendiente cbx_pendiente
st_5 st_5
em_ann em_ann
st_6 st_6
em_ann_pedidos em_ann_pedidos
end type
global w_pases_adicionales w_pases_adicionales

type variables
Datawindow idw_cual
Datawindowchild idw_child_uni , idch_cliente, pedido
integer ii_clicked, ii_cont = 0, ii_cualevent = 1, ii_ultgetrow, &
            ii_escpri = 1, ii_bandera, ii_ann, ii_ann_pedidos
long il_LastClickedRow, il_arrayrows[], il_cantidad
Double id_fraccion

boolean ib_action_on_buttonup, ib_tipoclicked = false, ib_flag = false
string is_user

//str_desglose	istr_parm
uo_ds_desglose	iuo_desglose, iuo_desg_a_pasar
integer   ii_index
end variables

forward prototypes
public subroutine wf_fecha ()
public subroutine wf_nofecha ()
public subroutine wf_botones ()
public subroutine wf_ds_retrieve ()
public subroutine wf_setear_user (string as_user)
public function string wf_verificar (string ls_original)
public subroutine wf_pase_proforma_proforma_pend ()
public subroutine wf_pase_proforma_proforma ()
public subroutine wf_pase_proforma_pedido ()
public subroutine wf_pase_listaempaque_factura ()
public function string wf_armar_sql (string ls_vienede)
public subroutine wf_efectuar_pase ()
public subroutine wf_pase_lista_empaque_factura_telas ()
public subroutine wf_pase_factura_factura ()
public subroutine wf_pase_pedido_factura ()
public subroutine wf_pase_pedido_pedido ()
public subroutine wf_pase_pedido_pedido_pend ()
end prototypes

event ue_pasarow;//integer li_i, li_rows
//long ll_c, ll_anno, ll_linea, ll_i
//string ls_pedid,ls_cod_item
//
//CHOOSE CASE idw_cual
//	CASE dw_1
//				dw_3.RowsMove(1,dw_3.RowCount(),Primary!,dw_4,1000,Primary!)
//				iuo_desglose.RowsCopy (1, iuo_desglose.RowCount() , Primary!, iuo_desg_a_pasar, &
//						  					  iuo_desg_a_pasar.RowCount() + 1, Primary!)
//				dw_4.Object.c_cant_pas.protect = 0
//				dw_4.Object.c_cant_frac.protect = 0	
//				If dw_4.rowcount() > 0 then 
//					pb_2.enabled = true
//					//wf_ds_retrieve ()		// Desglose
//				End If
//				
//	CASE dw_3
//				For li_i = 1 to dw_3.RowCount()
//					If dw_3.IsSelected(li_i) then
//						wf_pasa_desglose (li_i, 'A')
//						idw_cual.RowsMove(li_i,li_i,Primary!,dw_4,1000,Primary!)
//					End IF		
//				Next
//
//				dw_4.Object.c_cant_pas.protect = 0
//				dw_4.Object.c_cant_frac.protect = 0
//				If dw_4.rowcount() > 0 then 
//					pb_2.enabled = true
//					//wf_ds_retrieve ()		// Desglose
//				End If
//	CASE dw_4
//				li_rows = dw_1.RowCount()
//				For ll_c = 1 to dw_4.RowCount()
//					
//					If dw_4.IsSelected(ll_c) Then
//					wf_pasa_desglose (ll_c, 'B')
//
//					ls_pedid = dw_4.getItemString(ll_c,"fadpedid_dped_no_pedido")
//					ll_anno = dw_4.getItemNumber(ll_c,"fadpedid_dped_ann")
//						
//					For li_i = 1 to li_rows
//						
//					If dw_1.IsSelected(li_i) Then
//						If dw_1.Getitemstring(li_i,"fatpedid_pedi_no_pedido") = ls_pedid AND &
//							dw_1.Getitemnumber(li_i,"fatpedid_pedi_ann") = ll_anno Then
//							dw_4.RowsDiscard(ll_c,ll_c,Primary!)
//							dw_3.Setredraw(false)
//							dw_3.Retrieve(str.g_financiero,str.empresa,ls_pedid,ll_anno)
//							wf_cant_apasar()
//							dw_3.Setredraw(true)
//						Else
//							dw_4.RowsDiscard(ll_c,ll_c,Primary!)
//						End IF
//					End If
//					Next
//					End If
//				Next		
//END CHOOSE
end event

event ue_pase;wf_efectuar_pase()

end event

public subroutine wf_fecha ();dw_2.visible = false
em_1.visible = True
em_1.text = string(gf_fecha_serv())
em_2.visible = True
em_2.text = string(today())
pb_1.visible = True
st_2.visible = True
st_3.visible = True
em_1.setfocus()

end subroutine

public subroutine wf_nofecha ();dw_2.visible = True
em_1.visible = false
em_2.visible = false
pb_1.visible = false
st_2.visible = false
st_3.visible = false
dw_2.setfocus()
dw_2.SetColumn("texto")
end subroutine

public subroutine wf_botones ();// Deshabilita algunas Opciones del Menú 

   /*Insertar*/
	m_fa_principal.m_edicin.m_insertar.toolbaritemvisible=false
	m_fa_principal.m_edicin.m_insertar.visible=false
	
	/*Adicionar*/
	m_fa_principal.m_edicin.m_adicionar.toolbaritemvisible=false
	m_fa_principal.m_edicin.m_adicionar.visible=false
	
	/*Filtrar*/
	m_fa_principal.m_edicin.m_filtrar.toolbaritemvisible=false
	m_fa_principal.m_edicin.m_filtrar.visible=false
	
	/*Sortear*/
	m_fa_principal.m_edicin.m_sortear.toolbaritemvisible=false
	m_fa_principal.m_edicin.m_sortear.visible=false
	
	/*Primer Reg*/
	m_fa_principal.m_edicin.m_primerregistro.toolbaritemvisible=false
	m_fa_principal.m_edicin.m_primerregistro.visible=false
	
	/*Ultimo Reg*/
	m_fa_principal.m_edicin.m_ultimoregistro.toolbaritemvisible=false
	m_fa_principal.m_edicin.m_ultimoregistro.visible=false
	
	/*Sig Reg*/
	m_fa_principal.m_edicin.m_siguienteregistro.toolbaritemvisible=false
	m_fa_principal.m_edicin.m_siguienteregistro.visible=false
	

  /*Reg Ant*/
	m_fa_principal.m_edicin.m_registroanterior.toolbaritemvisible=false
	m_fa_principal.m_edicin.m_registroanterior.visible=false

  /*Imprimir*/
   m_fa_principal.m_archivo.m_imprimir.toolbaritemvisible=false
	m_fa_principal.m_archivo.m_imprimir.visible=false
	
	/*Eliminar*/
	m_fa_principal.m_edicin.m_eliminar.toolbaritemvisible=false
	m_fa_principal.m_edicin.m_eliminar.visible=false

end subroutine

public subroutine wf_ds_retrieve ();//Double	ld_cantidad
//Integer	li_ann, li_i, li_fila 
//Long		ll_row, ll_pos, ll_max, ll_cantidad
//String	ls_pedido, ls_unidad
//
//
//
//ll_row    = dw_1.GetRow()
//ls_pedido = dw_1.GetItemString (ll_row, 'fatpedid_pedi_no_pedido')
//li_ann	 = dw_1.GetItemNumber (ll_row, 'fatpedid_pedi_ann')
//
//iuo_desglose.Retrieve (str.empresa, str.empresa, ls_pedido, li_ann)
//
///********************************************************************************* 
//	Convirtiendo cantidad en Entero|Fracción
// *********************************************************************************/
//// Colocando la unidad de venta en el DataStore de Desglose
//ll_max = iuo_desglose.RowCount() + 1
//For li_i = 1 To dw_3.RowCount ()
//	li_fila	 = dw_3.GetItemNumber (li_i, "fadpedid_dped_linea")
//	ls_unidad = dw_3.GetItemString (li_i, "fadpedid_dped_unidad_venta")
//	ll_pos 	 = iuo_desglose.Find ('dcpe_linea = ' + string (li_fila), 1, ll_max)
//	Do While (ll_pos > 0)
//		iuo_desglose.SetItem (ll_pos, 'unidad_venta', ls_unidad)
//		ll_pos ++
//		ll_pos 	 = iuo_desglose.Find ('dcpe_linea = ' + string (li_fila), ll_pos, ll_max)
////MessageBox ('RETRIEVE'+string (ll_pos) + ' '+string (li_i),string(iuo_desglose.RowCount()))
//	Loop
//Next
//
//// Entero|Fracción
//For li_i = 1 To iuo_desglose.RowCount()
//	ls_unidad 	= iuo_desglose.GetItemString (li_i, 'unidad_venta')
//	ld_cantidad = iuo_desglose.GetItemNumber (li_i, 'dcpe_cantidad')
////	wf_convert_cant (ls_unidad, ld_cantidad, li_i)
////	gf_conv_cantidad (ll_cantidad, ld_cantidad, 'A', ls_unidad)
//	gf_fa_convert_cant (ll_cantidad, ld_cantidad, 'A', ls_unidad)
//	iuo_desglose.SetItem (li_i, 'cantidad', long (ll_cantidad))
//	iuo_desglose.SetItem (li_i, 'fraccion', long (ld_cantidad))
//Next
//
end subroutine

public subroutine wf_setear_user (string as_user);//se asigna el usuario desde la ventana de clave con Dynamic
is_user = as_user
end subroutine

public function string wf_verificar (string ls_original);//Funcion que verifica los parámetros y arma el SQL
string ls_where

  if w_fa_fondo.str_para.mostrar <> 0 then  //mostrar un Año específico

	CHOOSE CASE w_fa_fondo.str_para.desde	//Si es desde el año en adelante o el año exclusivo.

		CASE 0

		 ls_where = ls_original + " and  &
					 ( fatprofo.prof_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatprofo.prof_empresa = "+string(str.empresa)+" ) and &
					 (fatprofo.prof_ann = "+string(w_fa_fondo.str_para.mostrar)+")"
		CASE 1
		 ls_where = ls_original + " and  &
					 ( fatprofo.prof_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatprofo.prof_empresa = "+string(str.empresa)+" ) and &
					 (fatprofo.prof_ann >= "+string(w_fa_fondo.str_para.mostrar)+")"			
	END CHOOSE			
	
  else
		 ls_where = ls_original + " and  &
					 ( fatprofo.prof_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatprofo.prof_empresa = "+string(str.empresa)+" )"
  end if

  return(ls_where)
end function

public subroutine wf_pase_proforma_proforma_pend ();long    ll_ann, ll_linea, ll_ann_encabezado, ll_ann_det, ll_fraccion, ll_bulto_ini, ll_bulto_fin, ll_index,&
		  ll_bultos, ll_linea_det, ll_ultima_linea, ll_ultimo_index, ll_cantidad
integer li_existe, i, li_pais, li_sqlcode
string  ls_pedido, ls_tipo, ls_pedido_encabezado, ls_pedido_det, ls_error, ls_uni_venta,&
		  ls_uni_prod, ls_codigo_item, ls_descrip, ls_uni_peso, ls_bodega, ls_ubicacion, ls_usuario,&
		  ls_supervisor		  
datetime ldt_fecha_serv, ldt_fecha, ld_fecha_reg 
Decimal	ld_pasada, ld_cantidad, ld_cubicaje, ld_peso, ld_precio_ma, ld_precio_me, ld_costo_fob,&
			ld_costo_cif, ld_precio, ld_monto_total, ld_por_descuento, ld_monto_final, ld_precio_original,&
			ld_costo_total

long		ll_validado, ll_vendedor,ll_pedido_vta_detal, ll_ann_orden_compra, ll_ann_transito, ll_ann_esc
integer  ll_linea_transito, ll_linea_orden 
string   ls_promocion, ls_reserva_origen, ls_num_orden_compra, ls_num_transito, ls_prod_serv
			
			
sqlca.autocommit = false

ldt_fecha_serv = gf_fecha_serv()

dw_1.setfilter("incluir = 1")
dw_1.filter()

if dw_1.rowcount() = 0 then
	mensaje("Aviso","Debe seleccionar " + st_1.text + " a pasar...","No se puede hacer ningun pase si no se ha seleccionado un documento...Verifique")
	dw_1.setfilter('')
	dw_1.filter()
	return
end if

ll_ann    = w_fa_fondo.str_para.ano
dw_3.accepttext()
ls_pedido = trim(dw_3.getitemstring(1,'pedido'))
if ls_pedido = '' or len(ls_pedido) < 1 or isnull(ls_pedido) then
	mensaje("Aviso","Debe asignar el número de Proforma " ,"")
	dw_1.setfilter('')
	dw_1.filter()
	return
end if

if ii_index = 1 then// Proforma a  Proforma
	ll_ultima_linea = 0
	ll_ultimo_index = 0
	if gf_mensaje('',' ¿ Está Seguro de Ejecutar el Pase ?',2,1,'E') = 2 then	
		dw_1.setfilter('')
		dw_1.filter()		
		return
	end if
	/*INSERTANDO EL DETALLE DE EL O LOS PEDIDOS*/
      ll_ann_esc = pedido.getitemnumber(pedido.getrow(),'anno') 
		  SELECT max(fadprofo.dpro_index),   
	            max(fadprofo.dpro_linea)  
		    INTO :ll_ultimo_index,   
      		   :ll_ultima_linea  
		    FROM fadprofo  
		   WHERE ( fadprofo.dpro_g_financiero = :str.g_financiero ) AND  
      		   ( fadprofo.dpro_empresa =  :str.empresa) AND  
		         ( fadprofo.dpro_ann = :ll_ann_esc ) AND  
      		   ( fadprofo.dpro_no_proforma = :ls_pedido )   ;
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al Seleccionar Proforma Origen',ls_error)					
					return
				end if	
	 if isnull(ll_ultima_linea) then ll_ultima_linea = 0 //if simple
	   
	 //Recorre todas las proformas seleccionadas
	 for i = 1 to dw_1.rowcount()
   	  ls_pedido_det = dw_1.getitemString(i,"fatpedid_pedi_no_pedido")	
		  ll_ann_det	  = dw_1.getitemnumber(i,'fatprofo_prof_ann')
		  
			DECLARE cur_proforma CURSOR FOR  
				 SELECT fadprofo.dpro_codigo_item,   
						 fadprofo.dpro_descripcion_alterna,   
						 fadprofo.dpro_cubucaje,   
						 fadprofo.dpro_peso,   
						 fadprofo.dpro_unidad_peso,   
						 fadprofo.dpro_unidad_producto,   
						 fadprofo.dpro_precio_mayor,   
						 fadprofo.dpro_precio_menor,   
						 fadprofo.dpro_bodega,   
						 fadprofo.dpro_costo_fob,   
						 fadprofo.dpro_costo_cif,   
						 fadprofo.dpro_precio_unidad_producto,   
						 fadprofo.dpro_unidad_venta,   
						 fadprofo.dpro_cantidad,   
						 fadprofo.dpro_fraccion,   
						 fadprofo.dpro_monto_total,   
						 fadprofo.dpro_por_descuento,   
						 fadprofo.dpro_monto_final,   
						 fadprofo.dpro_usuario,   
						 fadprofo.dpro_supervisor,   
						 fadprofo.dpro_bultos,   
						 fadprofo.dpro_ubicacion,   
						 fadprofo.dpro_bulto_inicio,   
						 fadprofo.dpro_bulto_fin,   
						 fadprofo.dpro_precio_original ,
						 fadprofo.dpro_linea,
						 fadprofo.dpro_index,
						 fadprofo.dpro_producto_servicio,
						 (fadprofo.dpro_cantidad * inamedid.medi_cantidad + fadprofo.dpro_fraccion) - dpro_pasada pasada,
						 (fadprofo.dpro_cantidad * fadprofo.dpro_costo_cif) + ((fadprofo.dpro_costo_cif / inamedid.medi_cantidad ) * fadprofo.dpro_fraccion)
					From 	fadprofo,
							inamedid
					Where  fadprofo.dpro_g_financiero = :str.g_financiero and
							 fadprofo.dpro_empresa      = :str.empresa and
							 fadprofo.dpro_no_proforma	 = :ls_pedido_det and					 
							 fadprofo.dpro_ann			 = :ll_ann_det and
							 fadprofo.dpro_cantidad * inamedid.medi_cantidad + fadprofo.dpro_fraccion > dpro_pasada and
							 fadprofo.dpro_unidad_venta = inamedid.medi_medida 
				ORDER BY  fadprofo.dpro_index ASC  ;						
		
		
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al declarar el cursor',ls_error)					
					return
				end if								
								
				open cur_proforma;
					if sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrtext
						rollback;
						mensaje('Aviso','Error al abrir el cursor',ls_error)	
						return
					end if			

				fetch cur_proforma into :ls_codigo_item, :ls_descrip, :ld_cubicaje, :ld_peso, :ls_uni_peso,&
									  :ls_uni_prod, :ld_precio_ma, :ld_precio_me, :ls_bodega, :ld_costo_fob,&
									  :ld_costo_cif, :ld_precio, :ls_uni_venta, :ld_cantidad, :ll_fraccion,&
									  :ld_monto_total, :ld_por_descuento, :ld_monto_final, :ls_usuario, :ls_supervisor,&
									  :ll_bultos, :ls_ubicacion, :ll_bulto_ini, :ll_bulto_fin, :ld_precio_original,&
									  :ll_linea, :ll_index,:ls_prod_serv,:ld_pasada, :ld_costo_total;
						
						li_sqlcode = sqlca.sqlcode
						
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							close cur_proforma;				
							rollback;
							mensaje('Aviso','Error en el Fetch del cursor',ls_error)	
							return
						end if					
						ll_linea_det = ll_linea
						//Para tomar la linea del detalle, y actualizar la cantidad pasada
						
						//Para convertir lo pendiente por pasar en la unidad de venta
						gf_fa_convertuni_new(ls_uni_venta, ld_pasada, ll_cantidad, ll_fraccion)
				do while li_sqlcode = 0		
	    		     ll_ultima_linea ++
					  ll_ultimo_index ++
								  INSERT INTO fadprofo  
										( dpro_g_financiero,   
										  dpro_empresa,   
										  dpro_no_proforma,   
										  dpro_ann,   
										  dpro_linea,   
										  dpro_producto_servicio,   
										  dpro_codigo_item,   
										  dpro_descripcion_alterna,   
										  dpro_cubucaje,   
										  dpro_peso,   
										  dpro_unidad_peso,   
										  dpro_unidad_producto,   
										  dpro_precio_mayor,   
										  dpro_precio_menor,   
										  dpro_bodega,   
										  dpro_costo_fob,   
										  dpro_costo_cif,   
										  dpro_precio_unidad_producto,   
										  dpro_unidad_venta,   
										  dpro_cantidad,   
										  dpro_fraccion,   
										  dpro_monto_total,   
										  dpro_por_descuento,   
										  dpro_monto_final,   
										  dpro_usuario,   
										  dpro_supervisor,   
										  dpro_bultos,   
										  dpro_ubicacion,   
										  dpro_pasada,   
										  dpro_index,   
										  dpro_bulto_inicio,   
										  dpro_bulto_fin,   
										  dpro_precio_original,
										  dpro_costo_total)  
								  VALUES (:str.g_financiero,   
											 :str.empresa,   
											 :ls_pedido,
											 :ll_ann,
											 :ll_ultima_linea,  
											 :ls_prod_serv,
											 :ls_codigo_item,
											 :ls_descrip,
											 :ld_cubicaje,
											 :ld_peso,
											 :ls_uni_peso,
											 :ls_uni_prod,
											 :ld_precio_ma,
											 :ld_precio_me,
											 :ls_bodega,
											 :ld_costo_fob,
											 :ld_costo_cif,
											 :ld_precio,
											 :ls_uni_venta,
											 :ll_cantidad,
											 :ll_fraccion,
											 :ld_monto_total,
											 :ld_por_descuento,
											 :ld_monto_final,
											 :ls_usuario,
											 :ls_supervisor,
											 :ll_bultos,
											 :ls_ubicacion,
											 0,
											 :ll_ultimo_index,
											 :ll_bulto_ini,
											 :ll_bulto_fin,
											 :ld_precio_original,
											 :ld_costo_total);						  
				 
							  if sqlca.sqlcode = -1 then
								  ls_error = sqlca.sqlerrtext
									rollback;
									close cur_proforma;					
									mensaje('Aviso','Error al Insertar el Detalle en FadProfo',ls_error)					
									return
							  end if															
				
				//UPDATE DE LAS CANTIDADES PASADAS, EN PEDIDOS
				  UPDATE fadprofo  
			     SET dpro_pasada = dpro_pasada + :ld_pasada  
				  WHERE  ( fadprofo.dpro_g_financiero = :str.g_financiero ) AND  
		   		      ( fadprofo.dpro_empresa =  :str.empresa) AND  
			      	   ( fadprofo.dpro_no_proforma = :ls_pedido_det ) AND  
         				( fadprofo.dpro_ann =:ll_ann_det  )   AND
							( fadprofo.dpro_linea = :ll_linea_det) ;

						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_proforma;
							mensaje('Aviso','Error al actualizar la cantidad pasada',ls_error)	
							return
						end if																																

		fetch cur_proforma into :ls_codigo_item, :ls_descrip, :ld_cubicaje, :ld_peso, :ls_uni_peso,&
									  :ls_uni_prod, :ld_precio_ma, :ld_precio_me, :ls_bodega, :ld_costo_fob,&
									  :ld_costo_cif, :ld_precio, :ls_uni_venta, :ld_cantidad, :ll_fraccion,&
									  :ld_monto_total, :ld_por_descuento, :ld_monto_final, :ls_usuario, :ls_supervisor,&
									  :ll_bultos, :ls_ubicacion, :ll_bulto_ini, :ll_bulto_fin, :ld_precio_original,&
									  :ll_linea, :ll_index, :ls_prod_serv,:ld_pasada, :ld_costo_total ;
					  if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_proforma;
							mensaje('Aviso','Error en el Fetch del cursor',ls_error)	
							return
						end if								
					 
					   li_sqlcode = sqlca.sqlcode										
						
						//Para convertir lo pendiente por pasar en la unidad de venta
						gf_fa_convertuni_new(ls_uni_venta, ld_pasada, ll_cantidad, ll_fraccion)
						
						ll_linea_det = ll_linea
						//Para tomar la linea del detalle, y actualizar la cantidad pasada												
		loop
		/*CIERRA EL CURSOR*/
		close cur_proforma;
	
		/*UPDATE DEL ESTADO DEL PEDIDO A PASADO Y DE LAS CANTIDADES PASADAS*/
		
			  UPDATE fatprofo  
		     SET prof_estado = 'P'  
			   WHERE ( fatprofo.prof_g_financiero = :str.g_financiero ) AND  
         			( fatprofo.prof_empresa =  :str.empresa) AND  
			         ( fatprofo.prof_no_proforma = :ls_pedido_det ) AND  
         			( fatprofo.prof_ann =  :ll_ann_det)   ;
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_proforma;
							mensaje('Aviso','Error al actualizar la proforma  pasada',ls_error)
							return
						end if								

	
	Next //Del Ciclo for de los pedidos a pasar

/*Add by HGN 21/09/2001 SETEA TOTALES AL ENCABEZADO*/
  SELECT sum(fadprofo.dpro_bultos),   
         sum(fadprofo.dpro_cubucaje),   
         sum(fadprofo.dpro_peso),   
         sum(fadprofo.dpro_monto_total),   
         sum(fadprofo.dpro_monto_final),   
         sum(fadprofo.dpro_costo_total)  
	INTO 	:ll_bultos,
			:ld_cubicaje,
			:ld_peso,
			:ld_monto_total,
			:ld_monto_final,
			:ld_costo_total
    FROM fadprofo  
   WHERE ( fadprofo.dpro_g_financiero = :str.g_financiero ) AND  
         ( fadprofo.dpro_empresa = :str.empresa ) AND  
         ( fadprofo.dpro_ann = :ll_ann ) AND  
         ( fadprofo.dpro_no_proforma = :ls_pedido )   ;

			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				close cur_proforma;
				mensaje('Aviso','Error al totalizar totales del encabezado fatprofo',ls_error)
				return
			end if								

			  UPDATE fatprofo
			  		 SET prof_bultos_total 	= :ll_bultos,   
						prof_cubicaje_total 	= :ld_cubicaje,   
						prof_peso_total 		= :ld_peso,   
						prof_monto_total 		= :ld_monto_total,   
						prof_monto_final 		= :ld_monto_final,   
						prof_costos_total 	= :ld_costo_total
			   WHERE ( fatprofo.prof_g_financiero = :str.g_financiero ) AND  
         			( fatprofo.prof_empresa =  :str.empresa) AND  
			         ( fatprofo.prof_no_proforma = :ls_pedido ) AND  
         			( fatprofo.prof_ann =  :ll_ann)   ;
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_proforma;
							mensaje('Aviso','Error al actualizar el encabezado de la proforma',ls_error)
							return
						end if								

	close cur_proforma; //cierra el cursor
	commit;
	gf_mensaje('','Pase efectuado Satisfactoriamente',1,1,"E")
	dw_1.setfilter('')
	dw_1.filter()
	sqlca.autocommit = true
end if //del ii_index = 1 de proforma a proforma
end subroutine

public subroutine wf_pase_proforma_proforma ();long    ll_ann, ll_linea, ll_ann_encabezado, ll_ann_det, ll_fraccion, ll_bulto_ini, ll_bulto_fin, ll_index,&
		  ll_bultos, ll_linea_det, ll_ultima_linea, ll_ultimo_index
integer li_existe, i, li_pais, li_sqlcode
string  ls_pedido, ls_tipo, ls_pedido_encabezado, ls_pedido_det, ls_error, ls_uni_venta,&
		  ls_uni_prod, ls_codigo_item, ls_descrip, ls_uni_peso, ls_bodega, ls_ubicacion, ls_usuario,&
		  ls_supervisor		  
datetime ldt_fecha_serv, ldt_fecha, ld_fecha_reg 
Decimal	ld_pasada, ld_cantidad, ld_cubicaje, ld_peso, ld_precio_ma, ld_precio_me, ld_costo_fob,&
			ld_costo_cif, ld_precio, ld_monto_total, ld_por_descuento, ld_monto_final, ld_precio_original,&
			ld_costo_total, ld_cubicaje_metros, ld_peso_neto, ld_bultos_original

long		ll_validado, ll_vendedor,ll_pedido_vta_detal, ll_ann_orden_compra, ll_ann_transito, ll_ann_esc
integer  ll_linea_transito, ll_linea_orden 
string   ls_promocion, ls_reserva_origen, ls_num_orden_compra, ls_num_transito, ls_prod_serv, ls_comentario, ls_modelo
			
			
sqlca.autocommit = false

ldt_fecha_serv = gf_fecha_serv()

dw_1.setfilter("incluir = 1")
dw_1.filter()

if dw_1.rowcount() = 0 then
	mensaje("Aviso","Debe seleccionar " + st_1.text + " a pasar...","No se puede hacer ningun pase si no se ha seleccionado un documento...Verifique")
	dw_1.setfilter('')
	dw_1.filter()
	return
end if

ll_ann    = ii_ann
dw_3.accepttext()
ls_pedido = trim(dw_3.getitemstring(1,'pedido'))
if ls_pedido = '' or len(ls_pedido) < 1 or isnull(ls_pedido) then
	mensaje("Aviso","Debe asignar el número de Proforma " ,"")
	dw_1.setfilter('')
	dw_1.filter()
	return
end if

//

	
if ii_index = 1 then// Proforma a  Proforma
	ll_ultima_linea = 0
	ll_ultimo_index = 0
	if gf_mensaje('',' ¿ Está Seguro de Ejecutar el Pase ?',2,1,'E') = 2 then	
		dw_1.setfilter('')
		dw_1.filter()		
		return
	end if
	/*INSERTANDO EL DETALLE DE EL O LOS PEDIDOS*/
      ll_ann_esc = ii_ann  //pedido.getitemnumber(pedido.getrow(),'anno') 
		  SELECT max(fadprofo.dpro_index),   
	            max(fadprofo.dpro_linea)  
		    INTO :ll_ultimo_index,   
      		   :ll_ultima_linea  
		    FROM fadprofo  
		   WHERE ( fadprofo.dpro_g_financiero = :str.g_financiero ) AND  
      		   ( fadprofo.dpro_empresa =  :str.empresa) AND  
		         ( fadprofo.dpro_ann = :ll_ann_esc ) AND  
      		   ( fadprofo.dpro_no_proforma = :ls_pedido )   ;
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al Seleccionar Proforma Origen',ls_error)					
					return
				end if	
	 if isnull(ll_ultima_linea) then ll_ultima_linea = 0 //if simple
	   
	 for i = 1 to dw_1.rowcount()
   	  ls_pedido_det = dw_1.getitemString(i,"fatpedid_pedi_no_pedido")	
		  ll_ann_det	  = dw_1.getitemnumber(i,'fatprofo_prof_ann')
		  
			DECLARE cur_proforma CURSOR FOR  
				 SELECT fadprofo.dpro_codigo_item,   
						 fadprofo.dpro_descripcion_alterna,   
						 fadprofo.dpro_cubucaje,   
						 fadprofo.dpro_peso,   
						 fadprofo.dpro_unidad_peso,   
						 fadprofo.dpro_unidad_producto,   
						 fadprofo.dpro_precio_mayor,   
						 fadprofo.dpro_precio_menor,   
						 fadprofo.dpro_bodega,   
						 fadprofo.dpro_costo_fob,   
						 fadprofo.dpro_costo_cif,   
						 fadprofo.dpro_precio_unidad_producto,   
						 fadprofo.dpro_unidad_venta,   
						 fadprofo.dpro_cantidad,   
						 fadprofo.dpro_fraccion,   
						 fadprofo.dpro_monto_total,   
						 fadprofo.dpro_por_descuento,   
						 fadprofo.dpro_monto_final,   
						 fadprofo.dpro_usuario,   
						 fadprofo.dpro_supervisor,   
						 fadprofo.dpro_bultos,   
						 fadprofo.dpro_ubicacion,   
						 fadprofo.dpro_bulto_inicio,   
						 fadprofo.dpro_bulto_fin,   
						 fadprofo.dpro_precio_original ,
						 fadprofo.dpro_linea,
						 fadprofo.dpro_index,
						 fadprofo.dpro_producto_servicio,
						 (fadprofo.dpro_cantidad * inamedid.medi_cantidad + fadprofo.dpro_fraccion) - dpro_pasada pasada,
						 (fadprofo.dpro_cantidad * fadprofo.dpro_costo_cif) + ((fadprofo.dpro_costo_cif / inamedid.medi_cantidad ) * fadprofo.dpro_fraccion),
						 dpro_cubicaje_metros,
						 dpro_peso_neto,
						 dpro_comentario,
						 dpro_bultos_original,
						 dpro_modelo
					From 	fadprofo,
							inamedid
					Where  fadprofo.dpro_g_financiero = :str.g_financiero and
							 fadprofo.dpro_empresa      = :str.empresa and
							 fadprofo.dpro_no_proforma	 = :ls_pedido_det and					 
							 fadprofo.dpro_ann			 = :ll_ann_det and
							 fadprofo.dpro_unidad_venta = inamedid.medi_medida
				ORDER BY  fadprofo.dpro_index ASC  ;								
		
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al declarar el cursor',ls_error)					
					return
				end if								
								
				open cur_proforma;
					if sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrtext
						rollback;
						mensaje('Aviso','Error al abrir el cursor',ls_error)	
						return
					end if			

		
				fetch cur_proforma into :ls_codigo_item, :ls_descrip, :ld_cubicaje, :ld_peso, :ls_uni_peso,&
									  :ls_uni_prod, :ld_precio_ma, :ld_precio_me, :ls_bodega, :ld_costo_fob,&
									  :ld_costo_cif, :ld_precio, :ls_uni_venta, :ld_cantidad, :ll_fraccion,&
									  :ld_monto_total, :ld_por_descuento, :ld_monto_final, :ls_usuario, :ls_supervisor,&
									  :ll_bultos, :ls_ubicacion, :ll_bulto_ini, :ll_bulto_fin, :ld_precio_original,&
									  :ll_linea, :ll_index,:ls_prod_serv,:ld_pasada, :ld_costo_total, :ld_cubicaje_metros, :ld_peso_neto, &
									  :ls_comentario, :ld_bultos_original, :ls_modelo;
		
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							close cur_proforma;				
							rollback;
							mensaje('Aviso','Error en el Fetch del cursor',ls_error)	
							return
						end if					
						ll_linea_det = ll_linea
						//Para tomar la linea del detalle, y actualizar la cantidad pasada
		
				do while sqlca.sqlcode = 0		
	    		     ll_ultima_linea ++
					  ll_ultimo_index ++
								  INSERT INTO fadprofo  
										( dpro_g_financiero,   
										  dpro_empresa,   
										  dpro_no_proforma,   
										  dpro_ann,   
										  dpro_linea,   
										  dpro_producto_servicio,   
										  dpro_codigo_item,   
										  dpro_descripcion_alterna,   
										  dpro_cubucaje,   
										  dpro_peso,   
										  dpro_unidad_peso,   
										  dpro_unidad_producto,   
										  dpro_precio_mayor,   
										  dpro_precio_menor,   
										  dpro_bodega,   
										  dpro_costo_fob,   
										  dpro_costo_cif,   
										  dpro_precio_unidad_producto,   
										  dpro_unidad_venta,   
										  dpro_cantidad,   
										  dpro_fraccion,   
										  dpro_monto_total,   
										  dpro_por_descuento,   
										  dpro_monto_final,   
										  dpro_usuario,   
										  dpro_supervisor,   
										  dpro_bultos,   
										  dpro_ubicacion,   
										  dpro_pasada,   
										  dpro_index,   
										  dpro_bulto_inicio,   
										  dpro_bulto_fin,   
										  dpro_precio_original,
										  dpro_costo_total,
								 		  dpro_cubicaje_metros,
										  dpro_peso_neto,
										  dpro_comentario,
										  dpro_bultos_original,
										  dpro_modelo  )  
								  VALUES (:str.g_financiero,   
											 :str.empresa,   
											 :ls_pedido,
											 :ll_ann,
											 :ll_ultima_linea,  
											 :ls_prod_serv,
											 :ls_codigo_item,
											 :ls_descrip,
											 :ld_cubicaje,
											 :ld_peso,
											 :ls_uni_peso,
											 :ls_uni_prod,
											 :ld_precio_ma,
											 :ld_precio_me,
											 :ls_bodega,
											 :ld_costo_fob,
											 :ld_costo_cif,
											 :ld_precio,
											 :ls_uni_venta,
											 :ld_cantidad,
											 :ll_fraccion,
											 :ld_monto_total,
											 :ld_por_descuento,
											 :ld_monto_final,
											 :ls_usuario,
											 :ls_supervisor,
											 :ll_bultos,
											 :ls_ubicacion,
											 0,
											 :ll_ultimo_index,
											 :ll_bulto_ini,
											 :ll_bulto_fin,
											 :ld_precio_original,
											 :ld_costo_total,
											 :ld_cubicaje_metros, 
											 :ld_peso_neto, 
									  		 :ls_comentario, 
											 :ld_bultos_original, 
											 :ls_modelo);						  
				 
							  if sqlca.sqlcode = -1 then
								  ls_error = sqlca.sqlerrtext
									rollback;
									close cur_proforma;					
									mensaje('Aviso','Error al Insertar el Detalle en FadProfo',ls_error)					
									return
							  end if					
				
				
				
				//UPDATE DE LAS CANTIDADES PASADAS, EN PEDIDOS
				  UPDATE fadprofo  
			     SET dpro_pasada = dpro_pasada + :ld_pasada  
				  WHERE  ( fadprofo.dpro_g_financiero = :str.g_financiero ) AND  
		   		      ( fadprofo.dpro_empresa =  :str.empresa) AND  
			      	   ( fadprofo.dpro_no_proforma = :ls_pedido_det ) AND  
         				( fadprofo.dpro_ann =:ll_ann_det  )   AND
							( fadprofo.dpro_linea = :ll_linea_det) ;

						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_proforma;
							mensaje('Aviso','Error al actualizar la cantidad pasada',ls_error)	
							return
						end if
						
		fetch cur_proforma into :ls_codigo_item, :ls_descrip, :ld_cubicaje, :ld_peso, :ls_uni_peso,&
									  :ls_uni_prod, :ld_precio_ma, :ld_precio_me, :ls_bodega, :ld_costo_fob,&
									  :ld_costo_cif, :ld_precio, :ls_uni_venta, :ld_cantidad, :ll_fraccion,&
									  :ld_monto_total, :ld_por_descuento, :ld_monto_final, :ls_usuario, :ls_supervisor,&
									  :ll_bultos, :ls_ubicacion, :ll_bulto_ini, :ll_bulto_fin, :ld_precio_original,&
									  :ll_linea, :ll_index, :ls_prod_serv,:ld_pasada, :ld_costo_total , :ld_cubicaje_metros, :ld_peso_neto, &
									  :ls_comentario, :ld_bultos_original, :ls_modelo;
					  if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_proforma;
							mensaje('Aviso','Error en el Fetch del cursor',ls_error)	
							return
						end if								
						
						ll_linea_det = ll_linea
						//Para tomar la linea del detalle, y actualizar la cantidad pasada												
		loop
		
		/*CIERRA EL CURSOR*/
		
		close cur_proforma;
	
		/*UPDATE DEL ESTADO DEL PEDIDO A PASADO Y DE LAS CANTIDADES PASADAS Y TOTALES*/
			  UPDATE fatprofo
			  		 SET prof_estado = 'P'
			   WHERE ( fatprofo.prof_g_financiero = :str.g_financiero ) AND  
         			( fatprofo.prof_empresa =  :str.empresa) AND  
			         ( fatprofo.prof_no_proforma = :ls_pedido_det ) AND  
         			( fatprofo.prof_ann =  :ll_ann_det)   ;
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_proforma;
							mensaje('Aviso','Error al actualizar la proforma  pasada',ls_error)
							return
						end if								

	
	Next //Del Ciclo for de los pedidos a pasar

  SELECT sum(fadprofo.dpro_bultos),   
         sum(fadprofo.dpro_cubucaje),   
         sum(fadprofo.dpro_peso),   
         sum(fadprofo.dpro_monto_total),   
         sum(fadprofo.dpro_monto_final),   
         sum(fadprofo.dpro_costo_total)  
	INTO 	:ll_bultos,
			:ld_cubicaje,
			:ld_peso,
			:ld_monto_total,
			:ld_monto_final,
			:ld_costo_total
    FROM fadprofo  
   WHERE ( fadprofo.dpro_g_financiero = :str.g_financiero ) AND  
         ( fadprofo.dpro_empresa = :str.empresa ) AND  
         ( fadprofo.dpro_ann = :ll_ann ) AND  
         ( fadprofo.dpro_no_proforma = :ls_pedido )   ;

			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				close cur_proforma;
				mensaje('Aviso','Error al totalizar totales del encabezado fatprofo',ls_error)
				return
			end if								

			  UPDATE fatprofo
			  		 SET prof_bultos_total 	= :ll_bultos,   
						prof_cubicaje_total 	= :ld_cubicaje,   
						prof_peso_total 		= :ld_peso,   
						prof_monto_total 		= :ld_monto_total,   
						prof_monto_final 		= :ld_monto_final,   
						prof_costos_total 	= :ld_costo_total
			   WHERE ( fatprofo.prof_g_financiero = :str.g_financiero ) AND  
         			( fatprofo.prof_empresa =  :str.empresa) AND  
			         ( fatprofo.prof_no_proforma = :ls_pedido ) AND  
         			( fatprofo.prof_ann =  :ll_ann)   ;
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_proforma;
							mensaje('Aviso','Error al actualizar el encabezado de la proforma',ls_error)
							return
						end if								

	close cur_proforma; //cierra el cursor
	commit;
	gf_mensaje('','Pase efectuado Satisfactoriamente',1,1,"E")
	dw_1.setfilter('')
	dw_1.filter()
	sqlca.autocommit = true
end if //del ii_index = 1 de proforma a proforma
end subroutine

public subroutine wf_pase_proforma_pedido ();long    ll_ann, ll_linea, ll_ann_encabezado, ll_ann_det, ll_fraccion, ll_bulto_ini, ll_bulto_fin, ll_index,&
		  ll_bultos, ll_linea_det, ll_ultima_linea, ll_ultimo_index, ll_convert, llt_bultos
integer li_existe, i, li_pais
string  ls_pedido, ls_tipo, ls_pedido_encabezado, ls_pedido_det, ls_error, ls_uni_venta,&
		  ls_uni_prod, ls_codigo_item, ls_descrip, ls_uni_peso, ls_bodega, ls_ubicacion, ls_usuario,&
		  ls_supervisor		  
datetime ldt_fecha_serv, ldt_fecha, ld_fecha_reg 

decimal	ld_cubicaje, ld_peso, ld_precio_ma, ld_precio_me, ld_costo_fob,&
			ld_costo_cif, ld_precio, ld_monto_total, ld_por_descuento, ld_monto_final, ld_precio_original,&
			ld_costo_total, ld_precio_minimo, ld_monto_tot_pas
decimal  ld_pasada, ld_cantidad, ld_cantidad_total
decimal 	ldt_cubicaje, ldt_peso, ldt_monto_total, ldt_monto_final, ldt_costo_total

long		ll_validado, ll_vendedor,ll_pedido_vta_detal, ll_ann_orden_compra, ll_ann_transito, ll_ann_esc
integer  ll_linea_transito, ll_linea_orden 
string   ls_promocion, ls_reserva_origen, ls_num_orden_compra, ls_num_transito
			
			
sqlca.autocommit = false

ldt_fecha_serv = gf_fecha_serv()

dw_1.setfilter("incluir = 1")
dw_1.filter()

if dw_1.rowcount() = 0 then
	mensaje("Aviso","Debe seleccionar " + st_1.text + " a pasar...","No se puede hacer ningun pase si no se ha seleccionado un documento...Verifique")
	dw_1.setfilter('')
	dw_1.filter()
	return
end if

ll_ann    = w_fa_fondo.str_para.ano
dw_3.accepttext()
ls_pedido = trim(dw_3.getitemstring(1,'pedido'))
if ls_pedido = '' or len(ls_pedido) < 1 or isnull(ls_pedido) then
	mensaje("Aviso","Debe asignar el número de Pedido","")
	dw_1.setfilter('')
	dw_1.filter()

	return
end if

//

	
if ii_index = 2 then// Proforma a  Pedido
	ll_ultima_linea = 0
	ll_ultimo_index = 0
	if gf_mensaje('',' ¿ Está Seguro de Ejecutar el Pase ?',2,1,'E') = 2 then	
		dw_1.setfilter('')
		dw_1.filter()		
		return
	end if
	/*INSERTANDO EL DETALLE DE EL O LOS PEDIDOS*/
      ll_ann_esc = pedido.getitemnumber(pedido.getrow(),'anno') 
	   SELECT max(fadpedid.dped_linea),
	          max(fadpedid.dped_index)
		INTO  :ll_ultima_linea,
		      :ll_ultimo_index
	    FROM fadpedid
		 Where fadpedid.dped_g_financiero = :str.g_financiero and
				 fadpedid.dped_empresa      = :str.empresa and
				 fadpedid.dped_no_pedido	 = :ls_pedido and					 
				 fadpedid.dped_ann			 = :ll_ann_esc;
		
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al Seleccionar Pedido Origen',ls_error)					
					return
				end if	
	if isnull(ll_ultima_linea) then ll_ultima_linea = 0
	   
	 for i = 1 to dw_1.rowcount()
   	  ls_pedido_det = dw_1.getitemString(i,"fatpedid_pedi_no_pedido")	
		  ll_ann_det	  = dw_1.getitemnumber(i,'fatprofo_prof_ann')
		
	 	DECLARE cur_pedidos1 CURSOR FOR  
		    SELECT fadprofo.dpro_codigo_item,   
			       fadprofo.dpro_descripcion_alterna,   
         		 fadprofo.dpro_cubucaje,   
                fadprofo.dpro_peso,   
                fadprofo.dpro_unidad_peso,   
                fadprofo.dpro_unidad_producto,   
                fadprofo.dpro_precio_mayor,   
                fadprofo.dpro_precio_menor,   
                fadprofo.dpro_bodega,   
					 fadprofo.dpro_costo_fob,   
                fadprofo.dpro_costo_cif,   
                fadprofo.dpro_precio_unidad_producto,   
                fadprofo.dpro_unidad_venta,   
                fadprofo.dpro_cantidad,   
                fadprofo.dpro_fraccion,   
                fadprofo.dpro_monto_total,   
                fadprofo.dpro_por_descuento,   
                fadprofo.dpro_monto_final,   
                fadprofo.dpro_usuario,   
                fadprofo.dpro_supervisor,   
                fadprofo.dpro_bultos,   
                fadprofo.dpro_ubicacion,   
                fadprofo.dpro_bulto_inicio,   
                fadprofo.dpro_bulto_fin,   
                fadprofo.dpro_precio_original ,
					 fadprofo.dpro_linea,
					 fadprofo.dpro_index,
			       (fadprofo.dpro_cantidad * inamedid.medi_cantidad + fadprofo.dpro_fraccion) - fadprofo.dpro_pasada pasada,
			       (fadprofo.dpro_cantidad * inamedid.medi_cantidad + fadprofo.dpro_fraccion)	cantidad_total,				 
					 (fadprofo.dpro_cantidad * fadprofo.dpro_costo_cif) + ((fadprofo.dpro_costo_cif / inamedid.medi_cantidad ) * fadprofo.dpro_fraccion)
   			From 	fadprofo,
			         inamedid
			   Where  fadprofo.dpro_g_financiero = :str.g_financiero and
				 		 fadprofo.dpro_empresa      = :str.empresa and
						 fadprofo.dpro_no_proforma	 = :ls_pedido_det and					 
						 fadprofo.dpro_ann			 = :ll_ann_det and
					 	 fadprofo.dpro_unidad_venta = inamedid.medi_medida
			ORDER BY  fadprofo.dpro_index ASC  ;		
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al declarar el cursor',ls_error)					
					return
				end if	
				open cur_pedidos1;
					if sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrtext
						rollback;
						mensaje('Aviso','Error al abrir el cursor',ls_error)	
						return
					end if			

		
				fetch cur_pedidos1 into :ls_codigo_item, :ls_descrip, :ld_cubicaje, :ld_peso, :ls_uni_peso,&
									  :ls_uni_prod, :ld_precio_ma, :ld_precio_me, :ls_bodega, :ld_costo_fob,&
									  :ld_costo_cif, :ld_precio, :ls_uni_venta, :ld_cantidad, :ll_fraccion,&
									  :ld_monto_total, :ld_por_descuento, :ld_monto_final, :ls_usuario, :ls_supervisor,&
									  :ll_bultos, :ls_ubicacion, :ll_bulto_ini, :ll_bulto_fin, :ld_precio_original,&
									  :ll_linea, :ll_index, :ld_pasada, :ld_cantidad_total, :ld_costo_total;
		
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							close cur_pedidos1;				
							rollback;
							mensaje('Aviso','Error en el Fetch del cursor',ls_error)	
							return
						end if					
						ll_linea_det = ll_linea
						//Para tomar la linea del detalle, y actualizar la cantidad pasada					
		
		do while sqlca.sqlcode = 0		
			
				//ENTRA A RECALCULAR TOTALES SOLO SI LA CANTIDAD DISPONIBLE ES DIFERENTE A LA CANTIDAD TOTAL
				if ld_pasada <> ld_cantidad_total then			
					//Transforma lo disponible por pasar en cantidad - fraccion	
					gf_fa_convertuni_new_dec(ls_uni_venta,ld_pasada,ld_cantidad,ll_fraccion)						
					ld_cantidad = truncate(ld_cantidad,0)
		
					//********************************************/*********************
					//SI LA CANTIDAD CAMBIA, SE CALCULA EL MONTO FINAL Y TOTAL
					  ll_convert 		 = gf_unidad_venta(ls_uni_venta,gf_medi_prod(ls_uni_prod))
					  ld_precio_minimo = ld_precio / ll_convert					  					  
					  ld_por_descuento = 0	//Para descartar si tiene descuento en el detalle	  
					  //Calcula el monto total de la linea de detalle							
					  ld_monto_tot_pas = round(ld_precio_minimo * ld_pasada ,2)
					  ld_monto_total 	 =  ld_monto_tot_pas
					  ld_monto_final 	 =  ld_monto_total 
					  //Calcula el Costo total de la linea de detalle						 
					  
					//***********************************************************************
				end if //si es <> la cantidad total con la disponible por pasar
					
	        ll_ultima_linea ++
			  ll_ultimo_index ++
			  
		 INSERT INTO fadpedid  
		         ( dped_g_financiero,   
      	     dped_empresa,   
         	  dped_no_pedido,   
	           dped_ann,   
   	        dped_linea,   
      	     dped_producto_servicio,   
	           dped_codigo_item,   
   	        dped_descripcion_alterna,   
      	     dped_cubicaje,  
				  dped_peso,   
				  dped_unidad_peso,   
				  dped_unidad_producto,   
				  dped_precio_mayor,   
				  dped_precio_menor,   
				  dped_bodega,   
				  dped_costo_fob,   
				  dped_costo_cif,   
				  dped_precio_unidad_producto,   
				  dped_unidad_venta,   
				  dped_cantidad,   
				  dped_fraccion,   
				  dped_monto_total,   
				  dped_por_descuento,   
				  dped_monto_final,   
				  dped_usuario,   
				  dped_supervisor,   
				  dped_bultos,   
				  dped_ubicacion,   
				  dped_pasada,   
				  dped_cant_asignada,   
				  dped_index,
				  dped_bulto_inicio,   
				  dped_bulto_fin,   
				  dped_precio_original,
				  dped_costo_total)  
	  VALUES (:str.g_financiero,   
				 :str.empresa,   
				 :ls_pedido,
				 :ll_ann,
				 :ll_ultima_linea,  
				 'P',
				 :ls_codigo_item,
				 :ls_descrip,
				 :ld_cubicaje,
				 :ld_peso,
				 :ls_uni_peso,
				 :ls_uni_prod,
				 :ld_precio_ma,
				 :ld_precio_me,
				 :ls_bodega,
				 :ld_costo_fob,
				 :ld_costo_cif,
				 :ld_precio,
				 :ls_uni_venta,
				 :ld_cantidad,
				 :ll_fraccion,
				 :ld_monto_total,
				 :ld_por_descuento,
				 :ld_monto_final,
				 :ls_usuario,
				 :ls_supervisor,
				 :ll_bultos,
				 :ls_ubicacion,
				 0,
				 0,
				 :ll_ultimo_index,
				 :ll_bulto_ini,
				 :ll_bulto_fin,
				 :ld_precio_original,
				 :ld_costo_total);						  
				 
			  if sqlca.sqlcode = -1 then
				  ls_error = sqlca.sqlerrtext
					rollback;
					close cur_pedidos1;					
					mensaje('Aviso','Error al Insertar el Detalle en FadPedi',ls_error)					
					return
				end if					
				
				//UPDATE DE LAS CANTIDADES PASADAS, EN PEDIDOS
				  UPDATE fadprofo  
			     SET dpro_pasada = dpro_pasada + :ld_pasada
				  WHERE  ( fadprofo.dpro_g_financiero = :str.g_financiero ) AND  
		   		      ( fadprofo.dpro_empresa =  :str.empresa) AND  
			      	   ( fadprofo.dpro_no_proforma = :ls_pedido_det ) AND  
         				( fadprofo.dpro_ann =:ll_ann_det  )   AND
							( fadprofo.dpro_linea = :ll_linea_det) ;

						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_pedidos1;
							mensaje('Aviso','Error al actualizar la cantidad pasada',ls_error)	
							return
						end if																																

		fetch cur_pedidos1 into :ls_codigo_item, :ls_descrip, :ld_cubicaje, :ld_peso, :ls_uni_peso,&
									  :ls_uni_prod, :ld_precio_ma, :ld_precio_me, :ls_bodega, :ld_costo_fob,&
									  :ld_costo_cif, :ld_precio, :ls_uni_venta, :ld_cantidad, :ll_fraccion,&
									  :ld_monto_total, :ld_por_descuento, :ld_monto_final, :ls_usuario, :ls_supervisor,&
									  :ll_bultos, :ls_ubicacion, :ll_bulto_ini, :ll_bulto_fin, :ld_precio_original,&
									  :ll_linea, :ll_index, :ld_pasada, :ld_cantidad_total, :ld_costo_total;
					  if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_pedidos1;
							mensaje('Aviso','Error en el Fetch del cursor',ls_error)	
							return
						end if								
						
						ll_linea_det = ll_linea
						//Para tomar la linea del detalle, y actualizar la cantidad pasada												
		loop
		/*CIERRA EL CURSOR*/
		close cur_pedidos1;
	
		/*UPDATE DEL ESTADO DEL PEDIDO A PASADO Y DE LAS CANTIDADES PASADAS*/
		
			  UPDATE fatprofo  
		     SET prof_estado = 'P'  
			   WHERE ( fatprofo.prof_g_financiero = :str.g_financiero ) AND  
         			( fatprofo.prof_empresa =  :str.empresa) AND  
			         ( fatprofo.prof_no_proforma = :ls_pedido_det ) AND  
         			( fatprofo.prof_ann =  :ll_ann_det)   ;
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_pedidos1;
							mensaje('Aviso','Error al actualizar el pedido a pasado',ls_error)
							return
						end if								

	
	Next //Del Ciclo for de los pedidos a pasar

/*Add by HGN 24/09/2001 Calcula totales y los setea en encabezado destino*/
  SELECT sum(fadpedid.dped_bultos),   
         sum(fadpedid.dped_cubicaje),   
         sum(fadpedid.dped_peso),   
         sum(fadpedid.dped_monto_total),   
         sum(fadpedid.dped_monto_final),   
         sum(fadpedid.dped_costo_total)  
    INTO  :ll_bultos,   
			 :ld_cubicaje,
			 :ld_peso,
			 :ld_monto_total,
			 :ld_monto_final,
			 :ld_costo_total
    FROM fadpedid  
	WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
			( fadpedid.dped_empresa = :str.empresa ) AND  
			( fadpedid.dped_no_pedido = :ls_pedido ) AND  
			( fadpedid.dped_ann = :ll_ann ) ;

			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje('Aviso','Error al calcular totales para el encabezado fadpedid',ls_error)
				close cur_pedidos1;
				return
			end if

	UPDATE fatpedid  
     SET pedi_bultos_total 	= :ll_bultos,   
         pedi_cubicaje_total 	= :ld_cubicaje,   
         pedi_peso_total 		= :ld_peso,   
         pedi_monto_total 		= :ld_monto_total,   
         pedi_monto_final 		= :ld_monto_final,   
         pedi_costos_total 		= :ld_costo_total  
   WHERE ( fatpedid.pedi_g_financiero 	= :str.g_financiero ) AND  
         ( fatpedid.pedi_empresa 		= :str.empresa ) AND  
         ( fatpedid.pedi_no_pedido 		= :ls_pedido ) AND  
         ( fatpedid.pedi_ann 				= :ll_ann ) ;

			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				close cur_pedidos1;
				mensaje('Aviso','Error al actualizar totales del encabezado fatpedid',ls_error)
				return
			end if
/**/
	close cur_pedidos1; //cierra el cursor
	commit;
	gf_mensaje('','Pase efectuado Satisfactoriamente',1,1,"E")
	dw_1.setfilter('')
	dw_1.filter()
	sqlca.autocommit = true
end if	
end subroutine

public subroutine wf_pase_listaempaque_factura ();//
long    ll_ann, ll_linea, ll_ann_encabezado, ll_ann_det, ll_fraccion, ll_bulto_ini, ll_bulto_fin, ll_index,&
		  ll_bultos, ll_linea_det, ll_ultima_linea, ll_ultimo_index, ll_convert
integer li_existe, i, li_pais
string  ls_pedido, ls_tipo, ls_pedido_encabezado, ls_pedido_det, ls_error, ls_uni_venta,&
		  ls_uni_prod, ls_codigo_item, ls_descrip, ls_uni_peso, ls_bodega, ls_ubicacion, ls_usuario,&
		  ls_supervisor		  
datetime ldt_fecha_serv, ldt_fecha, ld_fecha_reg 
double	ld_pasada, ld_cantidad, ld_cubicaje, ld_peso, ld_precio_ma, ld_precio_me, ld_costo_fob,&
			ld_costo_cif, ld_precio, ld_monto_total, ld_por_descuento, ld_monto_final, ld_precio_original, ld_precio_uni,&
			ld_monto_fin = 0.00, ld_precio2
			
long		ll_validado, ll_vendedor,ll_pedido_vta_detal, ll_ann_orden_compra, ll_ann_transito, ll_ann_esc, ll_ano_emp, ll_linea_original
integer  ll_linea_transito, ll_linea_orden 
string   ls_promocion, ls_reserva_origen, ls_num_orden_compra, ls_num_transito, ls_lista_emp, ls_descuento
long     ll_cant_frac
decimal   ll_cant_pastot = 0.00,	ll_cant_ent = 0.00, ld_monto_tot_pas = 0.00, ld_monto_tot = 0.00,&
			 ld_costo_total
			
sqlca.autocommit = false

ldt_fecha_serv = gf_fecha_serv()

dw_1.setfilter("incluir = 1")
dw_1.filter()

if dw_1.rowcount() = 0 then
	mensaje("Aviso","Debe seleccionar " + st_1.text + " a pasar...","No se puede hacer ningun pase si no se ha seleccionado un documento...Verifique")
	dw_1.setfilter('')
	dw_1.filter()
	return
end if

ll_ann    = w_fa_fondo.str_para.ano
dw_3.accepttext()
ls_pedido = trim(dw_3.getitemstring(1,'pedido'))
ls_tipo	 = pedido.getitemstring(pedido.getrow(),'fact_tipo')
if ls_pedido = '' or len(ls_pedido) < 1 or isnull(ls_pedido) then
	mensaje("Aviso","Debe asignar el número de Factura" ,"")
	dw_1.setfilter('')
	dw_1.filter()
	return
end if

if ii_index = 6 then// Lista de Empaque a  Factura
	if gf_mensaje('',' ¿ Está Seguro de Ejecutar el Pase ?',2,1,'E') = 2 then	
		dw_1.setfilter('')
		dw_1.filter()				
		return
	end if
	
	ll_ann_esc = pedido.getitemnumber(pedido.getrow(),'anno') 
	
	  SELECT max(faddiari.facd_linea),   
	         max(faddiari.facd_index) 
   	INTO  :ll_ultima_linea,
		      :ll_ultimo_index
		 FROM faddiari  
   	WHERE ( faddiari.facd_g_financiero = :str.g_financiero  ) AND  
      	   ( faddiari.facd_empresa = :str.empresa) AND  
				( faddiari.facd_tipo		= :ls_tipo) AND
         	( faddiari.facd_ann =     :ll_ann_esc) AND  
	         ( faddiari.facd_no_pedido = :ls_pedido )   ;
			if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al Seleccionar Factura Origen',ls_error)					
					return
				end if	
				if isnull(ll_ultima_linea) then ll_ultima_linea = 0
 
//Actualiza el Encabezado de la Factura para que no reserve nuevamente

 		UPDATE fatdiari
		 SET  fact_viene_de_pedido = 1
		 FROM fatdiari  
		WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
				( fatdiari.fact_empresa = :str.empresa) AND  
				( fatdiari.fact_no_pedido = :ls_pedido) AND  
				( fatdiari.fact_tipo	= : ls_tipo ) AND
				( fatdiari.fact_ann = :ll_ann_esc)   ;

				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al Actualizar el Encabezado de la Factura',ls_error)					
					return
				end if	

	  
	/*INSERTANDO EL DETALLE DE EL O LOS PEDIDOS*/
	for i = 1 to dw_1.rowcount()
		 ls_pedido_det = dw_1.getitemString(i,"lista_empaque")	//trae el # del Pedido
		 ll_ann_det	  = dw_1.getitemnumber(i,'fatpedid_pedi_ann')
		 ls_lista_emp = dw_1.getitemString(i,'fatpedid_pedi_no_pedido') //Trae el # de la Lista de Empaque
		 ls_descuento = dw_1.getitemstring(i, 'fatpedid_pedi_descu_subt_deta')
		 ll_ano_emp = dw_1.getitemnumber(i,'anno')
		 ld_cantidad = 0.00
		 DECLARE cur_pedidos CURSOR FOR  
	    SELECT     fadpedid.dped_codigo_item,   
						fadpedid.dped_descripcion_alterna,   
			         fadempaq.empa_cubicaje,   
			         fadempaq.empa_peso,   
						fadpedid.dped_unidad_peso,   
						fadpedid.dped_unidad_producto,   
						fadpedid.dped_precio_mayor,   
						fadpedid.dped_precio_menor,   
						fadpedid.dped_bodega,   
						fadpedid.dped_costo_fob,   
						fadpedid.dped_costo_cif,   
						fadpedid.dped_precio_unidad_producto,   
						fadpedid.dped_unidad_venta,   
	      			fadempaq.empa_cantidad,   
						fadpedid.dped_fraccion,   
						fadpedid.dped_monto_total,   
						fadpedid.dped_por_descuento,  
						fadpedid.dped_monto_final,   
						fadpedid.dped_usuario,   
						fadpedid.dped_supervisor,   
						fadempaq.empa_bultos,   
						fadpedid.dped_ubicacion,   
						fadempaq.empa_bulto_inicio,   
			         fadempaq.empa_bulto_fin,   
						fadpedid.dped_precio_original,   
						fadempaq.empa_linea,   
						fadempaq.empa_index,
						fadempaq.empa_cantidad pasada,
			         fadempaq.empa_linea_original,						
   				   (fadempaq.empa_cantidad * fadpedid.dped_costo_cif) + ((fadpedid.dped_costo_cif / inamedid.medi_cantidad ) * fadpedid.dped_fraccion)
			    FROM fadempaq,   
			         fadpedid,   
         			fatempaq,
						inamedid
			   WHERE ( fatempaq.enca_g_financiero = fadempaq.empa_g_financiero ) and  
         			( fatempaq.enca_empresa = fadempaq.empa_empresa ) and  
			         ( fatempaq.enca_lista_empaque = fadempaq.empa_lista_empaque ) and  
			         ( fatempaq.enca_ann = fadempaq.empa_ann ) and  
			         ( fatempaq.enca_g_financiero = fadpedid.dped_g_financiero ) and  
			         ( fatempaq.enca_empresa = fadpedid.dped_empresa ) and  
			         ( fatempaq.enca_no_pedido = fadpedid.dped_no_pedido ) and  
			         ( fatempaq.enca_ann_pedido = fadpedid.dped_ann ) and  
			         ( fadpedid.dped_linea = fadempaq.empa_linea_original ) and  
						( fadpedid.dped_unidad_venta = inamedid.medi_medida ) and
			         ( ( fadempaq.empa_g_financiero = :str.g_financiero ) AND  
			         ( fadempaq.empa_empresa = :str.empresa ) AND  
			         ( fadempaq.empa_lista_empaque = :ls_lista_emp ) AND  
			         ( fadempaq.empa_ann =  :ll_ano_emp ) )   
				ORDER BY fadempaq.empa_index ASC  ;		
					if sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrtext
						rollback;
						mensaje('Aviso','Error al declarar el cursor',ls_error)					
						return
					end if	
				
				open cur_pedidos;
					if sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrtext
						rollback;
						mensaje('Aviso','Error al abrir el cursor',ls_error)	
						return
					end if			

		
				fetch cur_pedidos into :ls_codigo_item, :ls_descrip, :ld_cubicaje, :ld_peso, :ls_uni_peso,&
									  :ls_uni_prod, :ld_precio_ma, :ld_precio_me, :ls_bodega, :ld_costo_fob,&
									  :ld_costo_cif, :ld_precio, :ls_uni_venta, :ld_cantidad, :ll_fraccion,&
									  :ld_monto_total, :ld_por_descuento, :ld_monto_final, :ls_usuario, :ls_supervisor,&
									  :ll_bultos, :ls_ubicacion, :ll_bulto_ini, :ll_bulto_fin, :ld_precio_original,&
									  :ll_linea, :ll_index, :ld_pasada , :ll_linea_original,:ld_costo_total;
		
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				close cur_pedidos;				
				rollback;
				mensaje('Aviso','Error en el Fetch del cursor',ls_error)	
				return
			end if       						
		
	 do while sqlca.sqlcode = 0		
		
			//Para tomar la linea del detalle, y actualizar la cantidad pasada
			ll_linea_det = ll_linea_original
			ld_monto_tot  = 0.00
			ll_convert   = gf_unidad_venta(ls_uni_venta,gf_medi_prod(ls_uni_prod))
   		if ll_convert = 0 or isnull(ll_convert) then
		   	 ll_convert = 1
			end if
			
			ld_precio_uni    = ld_precio / ll_convert
			ld_monto_tot_pas = round(ld_precio_uni * ld_cantidad,2)  //LD_CANTIDAD YA ESTA EN UNIDADES
			ld_monto_tot 	  = ld_monto_tot_pas
			ld_precio2		  = ld_precio_original / ll_convert
			ld_monto_tot_pas = round(ld_precio2 * ld_cantidad,2)
			ld_monto_fin 	  = ld_monto_tot_pas

//Lo que esta en comentario estaba antes, ahora calcula el monto final en base al precio
//del producto			
//		   if ls_descuento = 'D' then
//		     ld_monto_fin =  ld_monto_tot - (ld_monto_tot * (ld_por_descuento/100))
//		   else
//			  ld_monto_fin     = ld_monto_tot			  
//			end if  
			
		//Se pone para que cuando se seleccionan mas de un registro a pasar, modifique la linea
		//y el orden
			ll_ultima_linea ++
			ll_ultimo_index ++
			ll_cant_pastot = ld_cantidad
			ll_cant_frac = 0.00
			ll_cant_ent = 0.00	
			gf_fa_convertuni_new_dec(ls_uni_venta,ll_cant_pastot,ll_cant_ent,ll_cant_frac)
			ll_cant_ent = truncate(ll_cant_ent,0)
			
			INSERT INTO faddiari  
					( facd_g_financiero,   
					  facd_empresa,   
					  facd_tipo,   
					  facd_no_pedido,   
					  facd_pedido_original,   
					  facd_linea,   
					  facd_ann,   
					  facd_producto_servicio,   
					  facd_codigo_item,   
					  facd_descripcion_alterna,   
					  facd_cubicaje,   
					  facd_peso,   
					  facd_unidad_peso,   
					  facd_unidad_producto,   
					  facd_precio_mayor,   
					  facd_precio_menor,   
					  facd_bodega,   
					  facd_costo_fob,   
					  facd_costo_cif,   
					  facd_precio_unidad_producto,   
					  facd_unidad_venta,   
					  facd_cantidad,   
					  facd_cantidad_fraccion,   
					  facd_monto_total,   
					  facd_por_descuento,   
					  facd_monto_final,   
					  facd_usuario,   
					  facd_supervisor,   
					  facd_bultos,   
					  facd_ubicacion,   
					  facd_cant_devuelta,   
					  facd_linea_articulo_dev,
					  facd_index,
					  facd_viene_de_pedido,
					  facd_bulto_inicio,
					  facd_bulto_fin,
					  facd_precio_original,
					  facd_costo_total)
				VALUES (:str.g_financiero,   
						  :str.empresa,   
						  :ls_tipo,
						  :ls_pedido,
						  :ls_pedido_det,
						  :ll_ultima_linea,  
						  :ll_ann,   
						  'P',
						  :ls_codigo_item,
						  :ls_descrip,
						  :ld_cubicaje,
						  :ld_peso,
						  :ls_uni_peso,
						  :ls_uni_prod,
						  :ld_precio_ma,
						  :ld_precio_me,
						  :ls_bodega,
						  :ld_costo_fob,
						  :ld_costo_cif,
						  :ld_precio,
						  :ls_uni_venta,
						  :ll_cant_ent,
						  :ll_cant_frac,
						  :ld_monto_tot,
						  :ld_por_descuento,
						  :ld_monto_fin,
						  :ls_usuario,
						  :ls_supervisor,
						  :ll_bultos,
						  :ls_ubicacion,
						  0,
						  0,
						  :ll_ultimo_index,
						  1,
						  :ll_bulto_ini,
						  :ll_bulto_fin,
						  :ld_precio_original,
						  :ld_costo_total) ;						  
						  
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					close cur_pedidos;					
					mensaje('Aviso','Error al Insertar el Detalle en Faddiari',ls_error)					
					return
				end if					
			
					
						//UPDATE DE LAS CANTIDADES PASADAS, EN PEDIDOS
						  UPDATE fadpedid  
							  SET dped_pasada = (dped_pasada + :ld_pasada) 
							WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
									( fadpedid.dped_empresa = :str.empresa ) AND  
									( fadpedid.dped_no_pedido = :ls_pedido_det ) AND  
									( fadpedid.dped_ann = :ll_ann_det ) AND  
									( fadpedid.dped_linea = :ll_linea_det ) and
									( fadpedid.dped_codigo_item = :ls_codigo_item)  ;
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_pedidos;
							mensaje('Aviso','Error al actualizar la cantidad pasada',ls_error)	
							return
						end if	
						
		fetch cur_pedidos into :ls_codigo_item, :ls_descrip, :ld_cubicaje, :ld_peso, :ls_uni_peso,&
									  :ls_uni_prod, :ld_precio_ma, :ld_precio_me, :ls_bodega, :ld_costo_fob,&
									  :ld_costo_cif, :ld_precio, :ls_uni_venta, :ld_cantidad, :ll_fraccion,&
									  :ld_monto_total, :ld_por_descuento, :ld_monto_final, :ls_usuario, :ls_supervisor,&
									  :ll_bultos, :ls_ubicacion, :ll_bulto_ini, :ll_bulto_fin, :ld_precio_original,&
									  :ll_linea, :ll_index, :ld_pasada , :ll_linea_original,:ld_costo_total;
		
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_pedidos;
							mensaje('Aviso','Error en el Fetch del cursor',ls_error)	
							return
						end if								
						
						ll_linea_det = ll_linea
		loop
	

		/*CIERRA EL CURSOR*/
		close cur_pedidos;
		/*UPDATE DEL ESTADO DEL PEDIDO A PASADO Y DE LAS CANTIDADES PASADAS*/
		
		//		ACTUALIZAR A PASADO EL PEDIDO, SI Y SOLO SI EL PEDIDO FUE PASADO EN SU TOTALIDAD	
		SELECT Count(*) 
		 INTO :li_existe
		 FROM fadpedid,
					fatpedid
			WHERE ( fatpedid.pedi_g_financiero = fadpedid.dped_g_financiero ) and
					( fatpedid.pedi_empresa = fadpedid.dped_empresa ) and
					( fatpedid.pedi_no_pedido = fadpedid.dped_no_pedido ) and
					( fatpedid.pedi_ann = fadpedid.dped_ann ) and
					( fatpedid.pedi_g_financiero = :str.g_financiero) AND
					( fatpedid.pedi_empresa = :str.empresa ) and
					( fatpedid.pedi_no_pedido = :ls_pedido_det ) and
					( fatpedid.pedi_ann = :ll_ann_det ) and
						fadpedid.dped_pasada <  (fadpedid.dped_fraccion + fadpedid.dped_cantidad * (SELECT inamedid.medi_cantidad
			FROM    inamedid
			WHERE inamedid.medi_medida = fadpedid.dped_unidad_venta)) ;
				If sqlca.sqlcode = -1 then
					ls_error =sqlca.sqlerrtext
					rollback using sqlca;
					mensaje("Error ","Error al verificar lo pasado "+ls_error,"")
					return
				End If
		
			If li_existe = 0 then
				  UPDATE fatpedid  
					  SET pedi_estado = "P"  
					WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
							( fatpedid.pedi_empresa 	= :str.empresa ) AND  
							( fatpedid.pedi_no_pedido 	= :ls_pedido_det ) AND  
							( fatpedid.pedi_ann = :ll_ann_det )   ;
			
					If sqlca.sqlcode = -1 then
						ls_error =sqlca.sqlerrtext
						rollback using sqlca;
						mensaje("Error ","Error al marcar estado del pedido Pasado "+ls_error,"")
						return
					End If
					
					
			End If //del existe = 0


			UPDATE fatempaq
			  SET enca_pasado = "S"   
			WHERE ( fatempaq.enca_g_financiero = :str.g_financiero ) AND  
					( fatempaq.enca_empresa = :str.empresa ) AND  
					( fatempaq.enca_no_pedido = :ls_pedido_det ) AND  
					( fatempaq.enca_ann_pedido = :ll_ann_det ) AND
					( fatempaq.enca_lista_empaque = :ls_lista_emp) AND
					( fatempaq.enca_ann =  :ll_ano_emp) ;
		
				If sqlca.sqlcode = -1 then
					ls_error =sqlca.sqlerrtext
					rollback using sqlca;
					mensaje("Error ","Error al marcar estado de la Lista de Empaque como Pasada "+ls_error,"")
					return
				End If

	
	
	Next //Del Ciclo for de los pedidos a pasar

	//Actualiza el Encabezado de la Factura para que Reserve al modificar en factura

 		UPDATE fatdiari
		 SET  fact_viene_de_pedido = 0
		 FROM fatdiari  
		WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
				( fatdiari.fact_empresa = :str.empresa) AND  
				( fatdiari.fact_no_pedido = :ls_pedido) AND  
				( fatdiari.fact_tipo	= : ls_tipo ) AND
				( fatdiari.fact_ann = :ll_ann_esc)   ;

				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al Actualizar el Encabezado de la Factura',ls_error)					
					return
				end if	
/**/
/*Add by HGN may 02/2002*/

	  SELECT sum(faddiari.facd_cubicaje),   
				sum(faddiari.facd_peso),   
				sum(faddiari.facd_monto_total),   
				sum(faddiari.facd_monto_final),   
				sum(faddiari.facd_bultos),   
				sum(faddiari.facd_costo_total)  
			INTO :ld_cubicaje,
				  :ld_peso,
				  :ld_monto_total,
				  :ld_monto_final,
				  :ll_bultos,
				  :ld_costo_total
		 FROM faddiari  
		WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
				( faddiari.facd_empresa = :str.empresa ) AND  
				( faddiari.facd_tipo = :ls_tipo ) AND  
				( faddiari.facd_no_pedido = :ls_pedido ) AND  
				( faddiari.facd_ann = :ll_ann ) ;

				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					close cur_pedidos; 
					mensaje('Aviso','Error al acumular totales para el encabezado faddiari',ls_error)
					return
				end if
		ld_cubicaje = round(ld_cubicaje,4)
		ld_cubicaje = round(ld_cubicaje,4)
		ld_peso = round(ld_peso,2)
		ld_monto_total = round(ld_monto_total,2)
		ld_monto_final = round(ld_monto_final,2)
		ld_costo_total = round(ld_costo_total,2)
		
	  UPDATE fatdiari  
		  SET fact_bultos_total 	= :ll_bultos,   
				fact_cubicaje_total 	= :ld_cubicaje,   
				fact_peso_total 		= :ld_peso,   
				fact_monto_fact_total = :ld_monto_total,   
				fact_monto_final 		= :ld_monto_final,   
				fact_costos_total 	= :ld_costo_total  
		WHERE ( fatdiari.fact_g_financiero 	= :str.g_financiero ) AND  
				( fatdiari.fact_empresa 		= :str.empresa ) AND  
				( fatdiari.fact_tipo 			= :ls_tipo ) AND  
				( fatdiari.fact_no_pedido 		= :ls_pedido ) AND  
				( fatdiari.fact_ann 				= :ll_ann) ;

				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					close cur_pedidos; 
					mensaje('Aviso','Error al actualizar totales del encabezado fatdiari',ls_error)
					return
				end if
/*Fin modify HGN 02/02/2002*/

	close cur_pedidos; //cierra el cursor
	commit;
	gf_mensaje('','Pase efectuado Satisfactoriamente',1,1,"E")
	dw_1.setfilter('')
	dw_1.filter()
	sqlca.autocommit = true
end if	

end subroutine

public function string wf_armar_sql (string ls_vienede);// Función que arma el Sql de el DataWindow, y dependiendo de donde se llama, profura o consultas
// Filtra segun parámetros iniciales o no

string ls_where, ls_original

ls_original = dw_1.GetsqlSelect()

if ls_vienede = "Proforma" then

   ls_where = wf_verificar(ls_original)
	
else		//Si es llamado de consultas
	
	if w_fa_fondo.str_para.afecta_consulta = 1 then		//Si los parámetros afectan consulta
	
	   ls_where = wf_verificar(ls_original)		
		
	else
		
		 ls_where = ls_original + " and  &
					 ( fatprofo.prof_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatprofo.prof_empresa = "+string(str.empresa)+" )"						 
	end if				 
end if


return(ls_where)
end function

public subroutine wf_efectuar_pase ();string ls_valor
long li_pos3
ls_valor = dw_3.getitemstring(dw_3.getrow(), 'pedido')
if len (ls_valor) < 1 then
	mensaje('Aviso', 'El número del ' + st_1.text+ ' no puede estar en Blanco','Por favor Coloque el Número de ' + st_1.text + ' Para Continuar')
	return
end if

if ii_index = 1 then       // Proforma a Proforma
	if cbx_pendiente.checked then
		wf_pase_proforma_proforma_pend()
	else
		wf_pase_proforma_proforma()
	end if
elseif ii_index = 2 then   // Factura a Factura
	wf_pase_factura_factura()
end if	
		
dw_1.retrieve(str.g_financiero, str.empresa, year(date(gf_fecha_serv())))
end subroutine

public subroutine wf_pase_lista_empaque_factura_telas ();
long    ll_ann, ll_ann_encabezado, ll_ann_det, ll_fraccion, ll_bulto_ini, ll_bulto_fin, ll_index,&
		  ll_bultos, ll_linea_det, ll_ultima_linea, ll_ultimo_index,&
		  ll_validado, ll_vendedor,ll_pedido_vta_detal, ll_ann_orden_compra, ll_ann_transito, ll_ann_esc,  ll_linea_original,&
		  ll_ann_emp, ll_cant_frac, ll_cant_pastot = 0,	ll_cant_ent = 0, ll_linea_emp

integer li_existe, i, li_pais, li_definicion , ll_linea_transito, ll_linea_orden , li_tex, li_linea_emp

string   ls_promocion, ls_reserva_origen, ls_num_orden_compra, ls_num_transito, ls_pedido_det, ls_descuento
string  ls_pedido, ls_tipo, ls_pedido_encabezado, ls_lista_empaque, ls_error, ls_uni_venta,&
		  ls_uni_prod, ls_codigo_item, ls_descrip, ls_uni_peso, ls_bodega, ls_ubicacion, ls_usuario,&
		  ls_supervisor, ls_status
		  
datetime ldt_fecha_serv, ldt_fecha, ld_fecha_reg

decimal	ld_pasada, ld_cantidad, ld_cubicaje, ld_peso, ld_precio_ma, ld_precio_me, ld_costo_fob,&
			ld_costo_cif, ld_precio, ld_monto_total, ld_por_descuento, ld_monto_final, ld_precio_original, ld_precio_uni,&
			ld_monto_fin = 0.00, ld_precio2, ld_pasado_demas = 0, &
			ld_cant_pastot = 0.00,	ld_cant_ent = 0.00, ld_monto_tot_pas = 0.00, ld_monto_tot = 0.00,&
			ld_costo_total, ld_convert, ld_cant_trabajada, ld_reservada_uni, ld_reservada,ld_cant_pas_min
				
sqlca.autocommit = false

ldt_fecha_serv = gf_fecha_serv()

dw_1.setfilter("incluir = 1")
dw_1.filter()

if dw_1.rowcount() = 0 then
	mensaje("Aviso","Debe seleccionar " + st_1.text + " a pasar...","No se puede hacer ningun pase si no se ha seleccionado un documento...Verifique")
	dw_1.setfilter('')
	dw_1.filter()
	return
end if

ll_ann    = w_fa_fondo.str_para.ano
dw_3.accepttext()
ls_pedido = trim(dw_3.getitemstring(1,'pedido'))
ls_tipo	 = pedido.getitemstring(pedido.getrow(),'fact_tipo')
if ls_pedido = '' or len(ls_pedido) < 1 or isnull(ls_pedido) then
	mensaje("Aviso","Debe asignar el número de Factura" ,"")
	dw_1.setfilter('')
	dw_1.filter()
	return
end if

if ii_index = 6 then// Lista de Empaque a  Factura
	if gf_mensaje('',' ¿ Está Seguro de Ejecutar el Pase ?',2,1,'E') = 2 then	
		dw_1.setfilter('')
		dw_1.filter()				
		return
	end if
	
	ll_ann_esc = pedido.getitemnumber(pedido.getrow(),'anno') 
	
	  SELECT max(faddiari.facd_linea),   
	         max(faddiari.facd_index) 
   	INTO  :ll_ultima_linea,
		      :ll_ultimo_index
		 FROM faddiari  
   	WHERE ( faddiari.facd_g_financiero = :str.g_financiero  ) AND  
      	   ( faddiari.facd_empresa = :str.empresa) AND  
				( faddiari.facd_tipo		= :ls_tipo) AND
         	( faddiari.facd_ann =     :ll_ann_esc) AND  
	         ( faddiari.facd_no_pedido = :ls_pedido )   ;
			if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al Seleccionar Factura Origen',ls_error)					
					return
				end if	
				if isnull(ll_ultima_linea) then ll_ultima_linea = 0

 		UPDATE fatdiari
		 SET  fact_viene_de_pedido = 1
		 FROM fatdiari  
		WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
				( fatdiari.fact_empresa = :str.empresa) AND  
				( fatdiari.fact_no_pedido = :ls_pedido) AND  
				( fatdiari.fact_tipo	= : ls_tipo ) AND
				( fatdiari.fact_ann = :ll_ann_esc)   ;

				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al stear 1 a fact_viene_de_pedido',ls_error)					
					return
				end if	
 
	/*INSERTANDO EL DETALLE DE EL O LOS PEDIDOS*/
	for i = 1 to dw_1.rowcount()
		 ls_pedido_det = dw_1.getitemString(i,"lista_empaque")	//En realidad es el pedido
		 ll_ann_det	  = dw_1.getitemnumber(i,'fatpedid_pedi_ann')
		 ls_lista_empaque= dw_1.getitemString(i,'fatpedid_pedi_no_pedido') //Es la L. Emp.
		 ls_descuento = dw_1.getitemstring(i, 'fatpedid_pedi_descu_subt_deta')
		 ll_ann_emp = dw_1.getitemnumber(i,'anno')
		 ld_cantidad = 0.00

			//ld_reservada	
			 DECLARE cur_pedidos CURSOR FOR  
			 SELECT     fadpedid.dped_codigo_item,   
							fadpedid.dped_descripcion_alterna,   
							fadempaq.empa_cubicaje,   
							fadempaq.empa_peso,   
							fadpedid.dped_unidad_peso,   
							fadpedid.dped_unidad_producto,   
							fadpedid.dped_precio_mayor,   
							fadpedid.dped_precio_menor,   
							fadpedid.dped_bodega,   
							fadpedid.dped_costo_fob,   
							fadpedid.dped_costo_cif,   
							fadpedid.dped_precio_unidad_producto,   
							fadpedid.dped_unidad_venta,
							fadpedid.dped_cantidad,
							fadempaq.empa_cantidad,   
							fadpedid.dped_fraccion,   
							fadpedid.dped_monto_total,   
							fadpedid.dped_por_descuento,  
							fadpedid.dped_monto_final,   
							fadpedid.dped_usuario,   
							fadpedid.dped_supervisor,   
							fadempaq.empa_bultos,   
							fadpedid.dped_ubicacion,   
							fadempaq.empa_bulto_inicio,   
							fadempaq.empa_bulto_fin,   
							fadpedid.dped_precio_original,   
							fadempaq.empa_linea,   
							fadempaq.empa_index,
							fadpedid.dped_pasada,
							fadempaq.empa_linea_original,						
							(fadempaq.empa_cantidad * fadpedid.dped_costo_cif) + ((fadpedid.dped_costo_cif / inamedid.medi_cantidad ) * fadpedid.dped_fraccion)
					 FROM fadempaq,   
							fadpedid,   
							fatempaq,
							inamedid
					WHERE ( fatempaq.enca_g_financiero = fadempaq.empa_g_financiero ) and  
							( fatempaq.enca_empresa = fadempaq.empa_empresa ) and  
							( fatempaq.enca_lista_empaque = fadempaq.empa_lista_empaque ) and  
							( fatempaq.enca_ann = fadempaq.empa_ann ) and  
							( fatempaq.enca_g_financiero = fadpedid.dped_g_financiero ) and  
							( fatempaq.enca_empresa = fadpedid.dped_empresa ) and  
							( fatempaq.enca_no_pedido = fadpedid.dped_no_pedido ) and  
							( fatempaq.enca_ann_pedido = fadpedid.dped_ann ) and  
							( fadpedid.dped_linea = fadempaq.empa_linea_original ) and  
							( fadpedid.dped_unidad_venta = inamedid.medi_medida ) and
							( ( fadempaq.empa_g_financiero = :str.g_financiero ) AND  
							( fadempaq.empa_empresa = :str.empresa ) AND  
							( fadempaq.empa_lista_empaque = :ls_lista_empaque ) AND  
							( fadempaq.empa_ann =  :ll_ann_emp ) )   
					ORDER BY fadempaq.empa_index ASC  ;		
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							mensaje('Aviso','Error al declarar el cursor',ls_error)					
							return
						end if	
				
				
				open cur_pedidos;
					if sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrtext
						rollback;
						mensaje('Aviso','Error al abrir el cursor',ls_error)	
						return
					end if			

		
				fetch cur_pedidos into :ls_codigo_item, :ls_descrip, :ld_cubicaje, :ld_peso, :ls_uni_peso,&
									  :ls_uni_prod, :ld_precio_ma, :ld_precio_me, :ls_bodega, :ld_costo_fob,&
									  :ld_costo_cif, :ld_precio, :ls_uni_venta, :ld_reservada,:ld_cantidad, :ll_fraccion,&
									  :ld_monto_total, :ld_por_descuento, :ld_monto_final, :ls_usuario, :ls_supervisor,&
									  :ll_bultos, :ls_ubicacion, :ll_bulto_ini, :ll_bulto_fin, :ld_precio_original,&
									  :ll_linea_emp, :ll_index, :ld_pasada , :ll_linea_original,:ld_costo_total;
		
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				close cur_pedidos;				
				rollback;
				mensaje('Aviso','Error en el Fetch del cursor',ls_error)	
				return
			end if       						

			/*VALIDACION PARA QUE CUANDO SE TRATE DE TEXTILES SOLO PASE LO TRABAJADO*/
		   /*Sólo aplica para Textileras */

			if pos(Upper(str.empr_acceso_especial),'TEXTINT,') > 0 OR & 
				pos(Upper(str.empr_acceso_especial),'VISTEX,') > 0 then 
				li_tex =1
			END IF
		
	 do while sqlca.sqlcode = 0		

			//Para tomar la linea del detalle, y actualizar la cantidad pasada
			ll_linea_det = ll_linea_original
			ld_monto_tot  = 0.00
			ld_convert   = gf_unidad_venta(ls_uni_venta,gf_medi_prod(ls_uni_prod))
   		
			if ld_convert = 0 or isnull(ld_convert) then
		   	 ld_convert = 1
			end if
			
		  /*************************************************/
		
			if li_tex =1 THEN	//TEXTILERAS

				  SELECT sum( fademtel.fade_cantidad )
				  INTO :ld_cant_trabajada
					 FROM fademtel  
					WHERE ( fademtel.fade_g_financiero = :str.g_financiero ) AND  
							( fademtel.fade_empresa = :str.empresa ) AND  
							( fademtel.fade_lista_empaque = :ls_lista_empaque ) AND  
							( fademtel.fade_ann = :ll_ann_emp ) AND  
							( fademtel.fade_linea_refer = :ll_linea_emp) ;

						If sqlca.sqlcode = -1  then
							ls_error =sqlca.sqlerrtext
							rollback using sqlca;
							mensaje("Error al leer el desglose de los rollos",ls_error,"")
							return
						End If
						
						IF IsNull(ld_cant_trabajada) then ld_cant_trabajada = 0
						
						//ld_cantidad = cantidad del detalle de fadempaq			
						IF IsNull(ld_cantidad) then ld_cantidad = 0 
						
						If ld_cantidad > ld_cant_trabajada and ld_cant_trabajada > 0 then ls_status ='E'  /*En proceso*/
						If ld_cant_trabajada = ld_cantidad and ld_cant_trabajada > 0 then ls_status ='T'  /*Trabajada*/

						If ld_cant_trabajada = 0 then ls_status ='R' /*Sólo reservado*/
						
						ld_cantidad = ld_cant_trabajada
						
						ld_costo_total = 	round(ld_cantidad*ld_costo_cif,2)			
						
						/**/
					  UPDATE fadempaq  
						  SET empa_status = :ls_status,
						  		empa_cantidad =:ld_cantidad
						WHERE ( fadempaq.empa_g_financiero = :str.g_financiero ) AND  
								( fadempaq.empa_empresa = :str.empresa ) AND  
								( fadempaq.empa_lista_empaque = :ls_lista_empaque ) AND  
								( fadempaq.empa_ann = :ll_ann_emp) AND  
								( fadempaq.empa_linea = :ll_linea_emp )  ;

						If sqlca.sqlcode = -1  then
							ls_error =sqlca.sqlerrtext
							rollback using sqlca;
							mensaje("Error al leer el Status de proceso de la lista de empaque",ls_error,"")
							return
						End If
			END IF
			
			/*Si no se ha trabajado nada que continue con próximo registro
			  para que no inserte registros en blanco*/

			if ld_cantidad > 0 then
			
				ld_precio_uni    = ld_precio / ld_convert
				ld_monto_tot_pas = round(ld_precio * ld_cantidad,2)  //LD_CANTIDAD YA ESTA EN UNIDADES
				ld_monto_tot 	  = ld_monto_tot_pas
				ld_precio2		  = round(ld_precio_original / ld_convert,2)
				ld_monto_tot_pas = round(ld_precio_original * ld_cantidad,2)
				ld_monto_fin 	  = ld_monto_tot_pas
				
			//Se pone para que cuando se seleccionan mas de un registro a pasar, modifique la linea
			//y el orden
				ll_ultima_linea ++
				ll_ultimo_index ++
				ld_cant_pastot = ld_cantidad
				ll_cant_frac = 0.00
				ld_cant_ent = ld_cantidad
	
					 SELECT inmprodu.prod_definicion  
						 INTO :li_definicion  
						 FROM inmprodu  
						WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
								( inmprodu.prod_empresa = :str.empresa ) AND  
								( inmprodu.prod_producto = :ls_codigo_item )   ;
	
								If sqlca.sqlcode = -1  then
									ls_error =sqlca.sqlerrtext
									rollback using sqlca;
									mensaje("Error al leer definicion del producto",ls_error,"")
									return
								End If

					If w_fa_fondo.str_para.utiliza_decimales <> 1 then
//						ll_cant_ent = long(ld_cant_ent)
//						gf_fa_convertmin_new(ll_cant_pastot,ls_uni_venta,ll_cant_ent,ll_cant_frac)
//						 ld_cant_pastot = ll_cant_pastot
//						 ld_cant_ent = ll_cant_ent
						ld_cant_pastot = ld_cant_ent
				  		gf_fa_convertmin_new_deci(ld_cant_pastot,ls_uni_venta,ld_cant_ent,ll_cant_frac)
						ll_cant_frac = 0
				  		gf_fa_convertmin_new_deci(ld_reservada_uni,ls_uni_venta,ld_reservada,ll_cant_frac)

					else
						ld_cant_pastot = ld_cant_ent
				  		gf_fa_convertmin_new_deci(ld_cant_pastot,ls_uni_venta,ld_cant_ent,ll_cant_frac)
						ll_cant_frac = 0
				  		gf_fa_convertmin_new_deci(ld_reservada_uni,ls_uni_venta,ld_reservada,ll_cant_frac)
					end if
/**/
			//	messagebox('cant pasar uni',ld_cant_pastot)
				
				INSERT INTO faddiari  
						( facd_g_financiero,   
						  facd_empresa,   
						  facd_tipo,   
						  facd_no_pedido,   
						  facd_pedido_original,   
						  facd_linea,   
						  facd_ann,   
						  facd_producto_servicio,   
						  facd_codigo_item,   
						  facd_descripcion_alterna,   
						  facd_cubicaje,   
						  facd_peso,   
						  facd_unidad_peso,   
						  facd_unidad_producto,   
						  facd_precio_mayor,   
						  facd_precio_menor,   
						  facd_bodega,   
						  facd_costo_fob,   
						  facd_costo_cif,   
						  facd_precio_unidad_producto,   
						  facd_unidad_venta,   
						  facd_cantidad,   
						  facd_cantidad_fraccion,   
						  facd_monto_total,   
						  facd_por_descuento,   
						  facd_monto_final,   
						  facd_usuario,   
						  facd_supervisor,   
						  facd_bultos,   
						  facd_ubicacion,   
						  facd_cant_devuelta,   
						  facd_linea_articulo_dev,
						  facd_index,
						  facd_viene_de_pedido,
						  facd_bulto_inicio,
						  facd_bulto_fin,
						  facd_precio_original,
						  facd_costo_total)
					VALUES (:str.g_financiero,   
							  :str.empresa,   
							  :ls_tipo,
							  :ls_pedido,
							  :ls_pedido_det,	/****/
							  :ll_ultima_linea,  
							  :ll_ann,   
							  'P',
							  :ls_codigo_item,
							  :ls_descrip,
							  :ld_cubicaje,
							  :ld_peso,
							  :ls_uni_peso,
							  :ls_uni_prod,
							  :ld_precio_ma,
							  :ld_precio_me,
							  :ls_bodega,
							  :ld_costo_fob,
							  :ld_costo_cif,
							  :ld_precio,
							  :ls_uni_venta,
							  :ld_cant_ent,
							  :ll_cant_frac,
							  :ld_monto_tot,
							  :ld_por_descuento,
							  :ld_monto_fin,
							  :ls_usuario,
							  :ls_supervisor,
							  :ll_bultos,
							  :ls_ubicacion,
							  0,
							  0,
							  :ll_ultimo_index,
							  1,
							  :ll_bulto_ini,
							  :ll_bulto_fin,
							  :ld_precio_original,
							  :ld_costo_total) ;						  
							  
					if sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrtext
						rollback;
						close cur_pedidos;					
						mensaje('Aviso','Error al Insertar el Detalle en Faddiari',ls_error)					
						return
					end if					

					ld_pasado_demas = 0	//Se usa para determinar cuando se paso más
												//de lo reservado
					if ld_pasada+ld_cant_pastot > ld_reservada_uni then
						ld_pasado_demas = ld_pasada + ld_cant_pastot - ld_reservada_uni
						gf_fa_convertuni_new_deci(ls_uni_venta,ld_pasado_demas,ld_pasado_demas,ll_cant_frac)
					end if
					
					
					IF li_tex = 1 then
						// Esto es para cuando el yardaje_pasado+yardaje_a_pasar está en un rango 
						// de (80% y 100%) lo cual significa que este registro ya no se va despachar
						// más porque si se agrega otro rollo de tela se pasa del total reservado
						if pos(Upper(str.empr_acceso_especial),'TEXTINT,') > 0 then
							if ld_pasada+ld_cant_pastot>= ld_reservada_uni*(0.80) and &
							   ld_pasada+ld_cant_pastot<= ld_reservada_uni then 
								
								/*Cantidad pasada de menos del producto*/
								ld_pasado_demas = (ld_cant_pastot + ld_pasada) - ld_reservada_uni
								gf_fa_convertuni_new_deci(ls_uni_venta,ld_pasado_demas,ld_pasado_demas,ll_cant_frac)
								ld_cant_pastot = ld_reservada_uni - ld_pasada
								
							end if
							
						else
							//Porcentaje de tolerancia de + ó - autorizada por la gerencia
						if ld_pasada+ld_cant_pastot>= ld_reservada_uni*(0.85) and &
							   ld_pasada+ld_cant_pastot<= ld_reservada_uni then 
								/*Cantidad pasada de menos del producto*/
								ld_pasado_demas = (ld_cant_pastot + ld_pasada) - ld_reservada_uni
								gf_fa_convertuni_new_deci(ls_uni_venta,ld_pasado_demas,ld_pasado_demas,ll_cant_frac)
								ld_cant_pastot = ld_reservada_uni - ld_pasada
							end if
						end if
					end if

							//UPDATE DE LAS CANTIDADES PASADAS, EN PEDIDOS
							
						//ld_pasado_demas = round(ld_pasado_demas,6)
						
							  UPDATE fadpedid  
								  SET dped_pasada 	= (dped_pasada + :ld_cant_pastot)
								WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
										( fadpedid.dped_empresa = :str.empresa ) AND  
										( fadpedid.dped_no_pedido = :ls_pedido_det ) AND  
										( fadpedid.dped_ann = :ll_ann_det ) AND  
										( fadpedid.dped_linea = :ll_linea_det ) and
										( fadpedid.dped_codigo_item = :ls_codigo_item)  ;
							if sqlca.sqlcode = -1 then
								ls_error = sqlca.sqlerrtext
								rollback;
								close cur_pedidos;
								mensaje('Aviso','Error al actualizar la cantidad pasada',ls_error)	
								return
							end if
							
						
				end if	//Fin validación cantidad =0
						
		fetch cur_pedidos into :ls_codigo_item, :ls_descrip, :ld_cubicaje, :ld_peso, :ls_uni_peso,&
									  :ls_uni_prod, :ld_precio_ma, :ld_precio_me, :ls_bodega, :ld_costo_fob,&
									  :ld_costo_cif, :ld_precio, :ls_uni_venta, :ld_reservada, :ld_cantidad, :ll_fraccion,&
									  :ld_monto_total, :ld_por_descuento, :ld_monto_final, :ls_usuario, :ls_supervisor,&
									  :ll_bultos, :ls_ubicacion, :ll_bulto_ini, :ll_bulto_fin, :ld_precio_original,&
									  :ll_linea_emp, :ll_index, :ld_pasada , :ll_linea_original,:ld_costo_total;
		
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					close cur_pedidos;
					mensaje('Aviso','Error en el Fetch del cursor',ls_error)	
					return
				end if								
				
				ll_linea_det = ll_linea_emp
		loop
	

		/*CIERRA EL CURSOR*/
		close cur_pedidos;
		/*UPDATE DEL ESTADO DEL PEDIDO A PASADO Y DE LAS CANTIDADES PASADAS*/
		
		//		ACTUALIZAR A PASADO EL PEDIDO, SI Y SOLO SI EL PEDIDO FUE PASADO EN SU TOTALIDAD	
		
		If li_tex = 1 then // TEXTILERAS ***********************************************
		
			SELECT Count(*) 
			 INTO :li_existe
				 FROM fadempaq,   
						fatempaq,   
						fadpedid  
				WHERE ( fatempaq.enca_g_financiero = fadempaq.empa_g_financiero ) and  
						( fatempaq.enca_empresa = fadempaq.empa_empresa ) and  
						( fatempaq.enca_lista_empaque = fadempaq.empa_lista_empaque ) and  
						( fatempaq.enca_ann = fadempaq.empa_ann ) and
						( fatempaq.enca_g_financiero = fadpedid.dped_g_financiero ) and  
						( fatempaq.enca_empresa = fadpedid.dped_empresa ) and  
						( fatempaq.enca_no_pedido = fadpedid.dped_no_pedido ) and  
						( fatempaq.enca_ann_pedido = fadpedid.dped_ann ) and  
						( fadempaq.empa_linea_original = fadpedid.dped_linea ) and  
						( fatempaq.enca_g_financiero = :str.g_financiero ) AND  
						( fatempaq.enca_empresa = :str.empresa ) AND  
						( fatempaq.enca_lista_empaque = :ls_lista_empaque ) AND  
						( fatempaq.enca_ann = :ll_ann_emp ) and 
						 fadpedid.dped_pasada <  (fadpedid.dped_fraccion + fadpedid.dped_cantidad * (SELECT inamedid.medi_cantidad
				FROM    inamedid
				WHERE inamedid.medi_medida = fadpedid.dped_unidad_venta)) ;
	
	
			/*Marca la lista de empaque como que ya fue pasada a factura una vez 
			  para que no se pueda volver a pasar si no que se haga otra lista de empaque*/		
				  UPDATE fatempaq
			  SET enca_pase_fact = 1   
			WHERE ( fatempaq.enca_g_financiero = :str.g_financiero ) AND  
					( fatempaq.enca_empresa = :str.empresa ) AND  
					( fatempaq.enca_no_pedido = :ls_pedido_det ) AND  
					( fatempaq.enca_ann_pedido = :ll_ann_det ) AND
					( fatempaq.enca_lista_empaque = :ls_lista_empaque) AND
					( fatempaq.enca_ann =  :ll_ann_emp) ;
		
				If sqlca.sqlcode = -1 then
					ls_error =sqlca.sqlerrtext
					rollback using sqlca;
					mensaje("Error ","Error al marcar Lista de Empaque como Pasada por primera vez"+ls_error,"")
					return
				End If
		
		else
		
			SELECT Count(*) 
			 INTO :li_existe
			 FROM fadpedid,
						fatpedid
				WHERE ( fatpedid.pedi_g_financiero = fadpedid.dped_g_financiero ) and
						( fatpedid.pedi_empresa = fadpedid.dped_empresa ) and
						( fatpedid.pedi_no_pedido = fadpedid.dped_no_pedido ) and
						( fatpedid.pedi_ann = fadpedid.dped_ann ) and
						( fatpedid.pedi_g_financiero = :str.g_financiero) AND
						( fatpedid.pedi_empresa = :str.empresa ) and
						( fatpedid.pedi_no_pedido = :ls_pedido_det ) and
						( fatpedid.pedi_ann = :ll_ann_det ) and
							fadpedid.dped_pasada <  (fadpedid.dped_fraccion + fadpedid.dped_cantidad * (SELECT inamedid.medi_cantidad
				FROM    inamedid
				WHERE inamedid.medi_medida = fadpedid.dped_unidad_venta)) ;
				
					If sqlca.sqlcode = -1 then
						ls_error =sqlca.sqlerrtext
						rollback using sqlca;
						mensaje("Error ","Error al verificar lo pasado "+ls_error,"")
						return
					End If

			END IF	// fIN VALIDACION TEXTILERAS

			UPDATE fatempaq
			  SET enca_pasado = "S"   
			WHERE ( fatempaq.enca_g_financiero = :str.g_financiero ) AND  
					( fatempaq.enca_empresa = :str.empresa ) AND  
					( fatempaq.enca_no_pedido = :ls_pedido_det ) AND  
					( fatempaq.enca_ann_pedido = :ll_ann_det ) AND
					( fatempaq.enca_lista_empaque = :ls_lista_empaque) AND
					( fatempaq.enca_ann =  :ll_ann_emp) ;
		
				If sqlca.sqlcode = -1 then
					ls_error =sqlca.sqlerrtext
					rollback using sqlca;
					mensaje("Error ","Error al marcar estado de la Lista de Empaque como Pasada "+ls_error,"")
					return
				End If

				If li_existe = 0 then
					  UPDATE fatpedid  
						  SET pedi_estado = "P"  
						WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
								( fatpedid.pedi_empresa 	= :str.empresa ) AND  
								( fatpedid.pedi_no_pedido 	= :ls_pedido_det ) AND  
								( fatpedid.pedi_ann = :ll_ann_det )   ;
				
						If sqlca.sqlcode = -1 then
							ls_error =sqlca.sqlerrtext
							rollback using sqlca;
							mensaje("Error ","Error al marcar estado del pedido Pasado "+ls_error,"")
							return
						End If
						
				End If //del existe = 0
	
	
	Next //Del Ciclo for de los pedidos a pasar

	//Actualiza el Encabezado de la Factura para que Reserve al modificar en factura

 		UPDATE fatdiari
		 SET  fact_viene_de_pedido = 0
		 FROM fatdiari  
		WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
				( fatdiari.fact_empresa = :str.empresa) AND  
				( fatdiari.fact_no_pedido = :ls_pedido) AND  
				( fatdiari.fact_tipo	= : ls_tipo ) AND
				( fatdiari.fact_ann = :ll_ann_esc)   ;

				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al Actualizar el Encabezado de la Factura',ls_error)					
					return
				end if	

/*Add by HGN september 24/2001*/

	  SELECT sum(faddiari.facd_cubicaje),   
				sum(faddiari.facd_peso),   
				sum(faddiari.facd_monto_total),   
				sum(faddiari.facd_monto_final),   
				sum(faddiari.facd_bultos),   
				sum(faddiari.facd_costo_total)  
			INTO :ld_cubicaje,
				  :ld_peso,
				  :ld_monto_total,
				  :ld_monto_final,
				  :ll_bultos,
				  :ld_costo_total
		 FROM faddiari  
		WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
				( faddiari.facd_empresa = :str.empresa ) AND  
				( faddiari.facd_tipo = :ls_tipo ) AND  
				( faddiari.facd_no_pedido = :ls_pedido ) AND  
				( faddiari.facd_ann = :ll_ann ) ;

				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					close cur_pedidos; 
					mensaje('Aviso','Error al acumular totales para el encabezado faddiari',ls_error)
					return
				end if
		ld_cubicaje = round(ld_cubicaje,4)
		ld_cubicaje = round(ld_cubicaje,4)
		ld_peso = round(ld_peso,2)
		ld_monto_total = round(ld_monto_total,2)
		ld_monto_final = round(ld_monto_final,2)
		ld_costo_total = round(ld_costo_total,2)
		
	  UPDATE fatdiari  
		  SET fact_bultos_total 	= :ll_bultos,   
				fact_cubicaje_total 	= :ld_cubicaje,   
				fact_peso_total 		= :ld_peso,   
				fact_monto_fact_total = :ld_monto_total,   
				fact_monto_final 		= :ld_monto_final,   
				fact_costos_total 	= :ld_costo_total  
		WHERE ( fatdiari.fact_g_financiero 	= :str.g_financiero ) AND  
				( fatdiari.fact_empresa 		= :str.empresa ) AND  
				( fatdiari.fact_tipo 			= :ls_tipo ) AND  
				( fatdiari.fact_no_pedido 		= :ls_pedido ) AND  
				( fatdiari.fact_ann 				= :ll_ann) ;

				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					close cur_pedidos; 
					mensaje('Aviso','Error al actualizar totales del encabezado fatdiari',ls_error)
					return
				end if
/**/

	close cur_pedidos; //cierra el cursor
	commit;
	gf_mensaje('','Pase efectuado Satisfactoriamente',1,1,"E")
	dw_1.setfilter('')
	dw_1.filter()
	sqlca.autocommit = true
end if	

end subroutine

public subroutine wf_pase_factura_factura ();long    ll_ann, ll_linea, ll_ann_encabezado, ll_ann_det, ll_fraccion, ll_bulto_ini, ll_bulto_fin, ll_index,&
		  ll_bultos, ll_linea_det, ll_ultima_linea, ll_ultimo_index
integer li_existe, i, li_pais
string  ls_pedido, ls_tipo, ls_pedido_encabezado, ls_pedido_det, ls_error, ls_uni_venta,&
		  ls_uni_prod, ls_codigo_item, ls_descrip, ls_uni_peso, ls_bodega, ls_ubicacion, ls_usuario,&
		  ls_supervisor		  , ls_codigo
datetime ldt_fecha_serv, ldt_fecha, ld_fecha_reg , ldt_fecha_reg
decimal	ld_pasada, ld_cantidad, ld_cubicaje, ld_peso, ld_precio_ma, ld_precio_me, ld_costo_fob,&
			ld_costo_cif, ld_precio, ld_monto_total, ld_por_descuento, ld_monto_final, ld_precio_original, &
			ld_costo_total,ld_precio_descuento
			
long		ll_validado, ll_vendedor,ll_pedido_vta_detal, ll_ann_orden_compra, ll_ann_transito, ll_ann_esc, ll_pais
integer  ll_linea_transito, ll_linea_orden 
string   ls_promocion, ls_reserva_origen, ls_num_orden_compra, ls_num_transito, ls_ped_orig, ls_actualizado, ls_producto_servicio
double   ld_cant_devuelta, ld_cant_asig
long     ll_linea_art, li_valido, li_anno, li_viene_pedido
			
ldt_fecha_serv = gf_fecha_serv()

dw_1.setfilter("incluir = 1")
dw_1.filter()

if dw_1.rowcount() = 0 then
	mensaje("Aviso","Debe seleccionar " + st_1.text + " a pasar...","No se puede hacer ningun pase si no se ha seleccionado un documento...Verifique")
	dw_1.setfilter('')
	dw_1.filter()
	return
end if

ll_ann    = year(date(gf_fecha_serv()))
dw_3.accepttext()
ls_pedido = trim(dw_3.getitemstring(1,'pedido'))
if ls_pedido = '' or len(ls_pedido) < 1 or isnull(ls_pedido) then
	mensaje("Aviso","Debe asignar el número de Factura" ,  '' )
	dw_1.setfilter('')
	dw_1.filter()
	return
end if

if ii_index = 2 then// Factura a  Factura
	if gf_mensaje('',' ¿ Está Seguro de Ejecutar el Pase ?',2,1,'E') = 2 then	
		dw_1.setfilter('')
		dw_1.filter()				
		return
	end if
	ll_ann_esc = pedido.getitemnumber(pedido.getrow(),'anno') 
	
	  SELECT max(faddiari.facd_linea),   
	         max(faddiari.facd_index) 
   	INTO  :ll_ultima_linea,
		      :ll_ultimo_index
		 FROM faddiari  
   	WHERE ( faddiari.facd_g_financiero = :str.g_financiero  ) AND  
      	   ( faddiari.facd_empresa =  :str.empresa) AND  
         	( faddiari.facd_ann =  :ll_ann_esc) AND  
	         ( faddiari.facd_no_pedido = :ls_pedido )   ;

			if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al Seleccionar Pedido Origen',ls_error)			
					sqlca.autocommit = true
					return
				end if	
				
	if isnull(ll_ultima_linea) then ll_ultima_linea = 0

	sqlca.autocommit = false

	/*INSERTANDO EL DETALLE DE EL O LOS PEDIDOS*/
	for i = 1 to dw_1.rowcount()
		 ls_pedido_det = dw_1.getitemString(i,"fatpedid_pedi_no_pedido")	
		 ll_ann_det	  = dw_1.getitemnumber(i,'fatdiari_fact_ann')
	      ls_tipo      =  dw_1.getitemstring(i,'fatdiari_fact_tipo')

	 	DECLARE cur_factura CURSOR FOR  		 
		   SELECT faddiari.facd_tipo,   
         		 faddiari.facd_pedido_original,   
		          faddiari.facd_codigo_item,   
			       faddiari.facd_descripcion_alterna,   
		          faddiari.facd_cubicaje,   
                faddiari.facd_peso,   
                faddiari.facd_unidad_peso,   
                faddiari.facd_unidad_producto,   
                faddiari.facd_precio_mayor,   
                faddiari.facd_precio_menor,   
                faddiari.facd_bodega,   
       			 faddiari.facd_costo_fob,   
		          faddiari.facd_costo_cif,   
		          faddiari.facd_precio_unidad_producto,   
       		    faddiari.facd_unidad_venta,   
		         faddiari.facd_cantidad,   
      		   faddiari.facd_cantidad_fraccion,   
         		faddiari.facd_monto_total,   
         		faddiari.facd_por_descuento,   
		         faddiari.facd_monto_final,   
      		   faddiari.facd_fecha_reg,   
		         faddiari.facd_usuario,   
      		   faddiari.facd_supervisor,   
		         faddiari.facd_bultos,   
      		   faddiari.facd_pais,   
		         faddiari.facd_ubicacion,   
      		   faddiari.facd_cant_devuelta,   
		         faddiari.facd_linea_articulo_dev,   
      		   faddiari.facd_cant_asignada,   
		         faddiari.facd_validado,   
      		   faddiari.facd_viene_de_pedido,   
		         faddiari.facd_bulto_inicio,   
      		   faddiari.facd_bulto_fin,   
		         faddiari.facd_precio_original,   
      		   faddiari.facd_costo_total,   
		         faddiari.facd_producto_servicio,   
      		   faddiari.facd_ann,  
					faddiari.facd_linea,facd_precio_descuento,
				   (faddiari.facd_cantidad * faddiari.facd_costo_cif) + ((faddiari.facd_costo_cif / inamedid.medi_cantidad ) * faddiari.facd_cantidad_fraccion)
		   FROM faddiari,inamedid  
		   WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
      		   ( faddiari.facd_empresa = :str.empresa ) AND  
		         ( faddiari.facd_no_pedido = :ls_pedido_det ) AND  
      		   ( faddiari.facd_ann = :ll_ann_det ) and 
					( faddiari.facd_unidad_venta = inamedid.medi_medida )
		ORDER BY   faddiari.facd_index ASC  ;				
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje('Aviso','Error al declarar el cursor del detalle de facturas ',ls_error)					
				sqlca.autocommit = true				
				return
			end if	
			open cur_factura;
		
					if sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrtext
						rollback;
						mensaje('Aviso','Error al abrir el cursor',ls_error)	
						sqlca.autocommit = true
						return
					end if			

		
				fetch cur_factura into :ls_tipo, :ls_ped_orig, :ls_codigo_item,:ls_descrip,:ld_cubicaje,&   
         			:ld_peso, :ls_uni_peso, :ls_uni_prod, :ld_precio_ma, :ld_precio_me,&   
         			:ls_bodega, :ld_costo_fob, :ld_costo_cif, :ld_precio,:ls_uni_venta,& 
		     			:ld_cantidad, :ll_fraccion,:ld_monto_total,:ld_por_descuento, :ld_monto_final,&   
      			   :ldt_fecha_reg, :ls_usuario,:ls_supervisor,:ll_bultos,:ll_pais,:ls_ubicacion,&   
			         :ld_cant_devuelta, :ll_linea_art,:ld_cant_asig,:li_valido,:li_viene_pedido,:ll_bulto_ini,&   
			         :ll_bulto_fin,:ld_precio_original,:ld_costo_total,:ls_producto_servicio,:li_anno, :ld_precio_descuento,:ll_linea,&
						:ld_costo_total; 
		
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				close cur_factura;				
				rollback;
				mensaje('Aviso','Error en el Fetch del cursor',ls_error)	
				sqlca.autocommit = true			
				return
			end if					
		
			//Para tomar la linea del detalle, y actualizar la cantidad pasada
			ll_linea_det = ll_linea
			
	 do while sqlca.sqlcode = 0		
		
		//Se pone para que cuando se seleccionan mas de un registro a pasar, modifique la linea
		//y el orden
		
			ll_ultima_linea ++
			ll_ultimo_index ++
			
			ld_costo_total = truncate(round(ld_costo_total,2),2)
			ld_precio_descuento = truncate(round(ld_precio_descuento,2),2)

			  INSERT INTO faddiari  
					( facd_g_financiero,   
					  facd_empresa,   
					  facd_tipo,   
					  facd_no_pedido,   
					  facd_pedido_original,   
					  facd_linea,   
					  facd_ann,   
					  facd_producto_servicio,   
					  facd_codigo_item,   
					  facd_descripcion_alterna,   
					  facd_cubicaje,   
					  facd_peso,   
					  facd_unidad_peso,   
					  facd_unidad_producto,   
					  facd_precio_mayor,   
					  facd_precio_menor,   
					  facd_bodega,   
					  facd_costo_fob,   
					  facd_costo_cif,   
					  facd_precio_unidad_producto,   
					  facd_unidad_venta,   
					  facd_cantidad,   
					  facd_cantidad_fraccion,   
					  facd_monto_total,   
					  facd_por_descuento,   
					  facd_monto_final,   
					  facd_usuario,   
					  facd_supervisor,   
					  facd_bultos,   
					  facd_ubicacion,   
					  facd_cant_devuelta,   
					  facd_linea_articulo_dev,
					  facd_index,
					  facd_viene_de_pedido,
					  facd_bulto_inicio,
					  facd_bulto_fin,
					  facd_precio_original,
					  facd_costo_total,
					  facd_precio_descuento)
				VALUES (:str.g_financiero,   
						  :str.empresa,   
						  :ls_tipo,
						  :ls_pedido,
						  :ls_pedido_det,
						  :ll_ultima_linea,  
						  :ll_ann_esc,   
						  'P',
						  :ls_codigo_item,
						  :ls_descrip,
						  :ld_cubicaje,
						  :ld_peso,
						  :ls_uni_peso,
						  :ls_uni_prod,
						  :ld_precio_ma,
						  :ld_precio_me,
						  :ls_bodega,
						  :ld_costo_fob,
						  :ld_costo_cif,
						  :ld_precio,
						  :ls_uni_venta,
						  :ld_cantidad,
						  :ll_fraccion,
						  :ld_monto_total,
						  :ld_por_descuento,
						  :ld_monto_final,
						  :ls_usuario,
						  :ls_supervisor,
						  :ll_bultos,
						  :ls_ubicacion,
						  0,
						  0,
						  :ll_ultimo_index,
						  0,
						  :ll_bulto_ini,
						  :ll_bulto_fin,
						  :ld_precio_original,
	  					  :ld_costo_total,
						  :ld_precio_descuento);
						  
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					close cur_factura;					
					mensaje('Aviso','Error al Insertar el Detalle en Faddiari',ls_error)	
					sqlca.autocommit = true
					return
				end if					
			
					
				fetch cur_factura into :ls_tipo, :ls_ped_orig, :ls_codigo_item,:ls_descrip,:ld_cubicaje,&   
         			:ld_peso, :ls_uni_peso, :ls_uni_prod, :ld_precio_ma, :ld_precio_me,&   
         			:ls_bodega, :ld_costo_fob, :ld_costo_cif, :ld_precio,:ls_uni_venta,& 
		     			:ld_cantidad, :ll_fraccion,:ld_monto_total,:ld_por_descuento, :ld_monto_final,&   
      			   :ldt_fecha_reg, :ls_usuario,:ls_supervisor,:ll_bultos,:ll_pais,:ls_ubicacion,&   
			         :ld_cant_devuelta, :ll_linea_art,:ld_cant_asig,:li_valido,:li_viene_pedido,:ll_bulto_ini,&   
			         :ll_bulto_fin,:ld_precio_original,:ld_costo_total ,:ls_producto_servicio,:li_anno, :ll_linea,&
						:ld_costo_total,:ld_precio_descuento; 
		
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_factura;
							mensaje('Aviso','Error en el Fetch del cursor',ls_error)	
							sqlca.autocommit = true
							return
						end if								
						
						ll_linea_det = ll_linea
						//Para tomar la linea del detalle, y actualizar la cantidad pasada												
		loop
	
		/*CIERRA EL CURSOR*/
		close cur_factura;
		
		update fatdiari
		set fact_estado = 'P'
		where fact_g_financiero = :str.g_financiero and
				 fact_empresa = :str.empresa and
				 fact_no_pedido = :ls_pedido_det and
				 fact_ann = :ll_ann_det;
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					close cur_factura;
					mensaje('Aviso','Error al Cambiar el Estado',ls_error)	
					sqlca.autocommit = true
					return
				end if									
		
			DECLARE cur_factura_pasada CURSOR FOR  		 
			   	SELECT  faddiari.facd_codigo_item
				   FROM faddiari  
				WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
						( faddiari.facd_empresa = :str.empresa ) AND  
						( faddiari.facd_no_pedido = :ls_pedido_det ) AND  
						( faddiari.facd_ann = :ll_ann_det ); 
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							mensaje('Aviso','Error al declarar el cursor de pasadas ',ls_error)					
							sqlca.autocommit = true				
							return
						end if					
				open cur_factura_pasada ;
				fetch cur_factura_pasada into :ls_codigo ;
				do while sqlca.sqlcode = 0
					gf_actualiza_reserva_producto(ls_codigo)					
					fetch cur_factura_pasada into :ls_codigo ;
				loop
				close cur_factura_pasada ;
				str.frame.setmicrohelp('Hymsoft.')
				commit ;  //PARA QUE NO MANDE Procedure has not been executed or has no results
	Next //Del Ciclo for de los pedidos a pasar

/*Add by HGN september 24/2001*/

	  SELECT sum(faddiari.facd_cubicaje),   
				sum(faddiari.facd_peso),   
				sum(faddiari.facd_monto_total),   
				sum(faddiari.facd_monto_final),   
				sum(faddiari.facd_bultos),   
				sum(faddiari.facd_costo_total)  
			INTO :ld_cubicaje,
				  :ld_peso,
				  :ld_monto_total,
				  :ld_monto_final,
				  :ll_bultos,
				  :ld_costo_total
		 FROM faddiari  
		WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
				( faddiari.facd_empresa = :str.empresa ) AND  
				( faddiari.facd_tipo = :ls_tipo ) AND  
				( faddiari.facd_no_pedido = :ls_pedido ) AND  
				( faddiari.facd_ann = :ll_ann_esc ) ;

				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					close cur_factura; 
					mensaje('Aviso','Error al acumular totales para el encabezado faddiari',ls_error)
					sqlca.autocommit = true
					return
				end if
		ld_cubicaje = round(ld_cubicaje,4)
		ld_peso 		= round(ld_peso,4)

	  UPDATE fatdiari  
		  SET fact_bultos_total 	= :ll_bultos,   
				fact_cubicaje_total 	= :ld_cubicaje,   
				fact_peso_total 		= :ld_peso,   
				fact_monto_fact_total = :ld_monto_total,   
				fact_monto_final 		= :ld_monto_final,   
				fact_costos_total 	= :ld_costo_total  
		WHERE ( fatdiari.fact_g_financiero 	= :str.g_financiero ) AND  
				( fatdiari.fact_empresa 		= :str.empresa ) AND  
				( fatdiari.fact_tipo 			= :ls_tipo ) AND  
				( fatdiari.fact_no_pedido 		= :ls_pedido ) AND  
				( fatdiari.fact_ann 				= :ll_ann_esc) ;

				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					close cur_factura; 
					mensaje('Aviso','Error al actualizar totales del encabezado fatdiari',ls_error)
					sqlca.autocommit = true
					return
				end if
/**/
	close cur_factura; //cierra el cursor
	commit;
	gf_mensaje('','Pase efectuado Satisfactoriamente',1,1,"E")
	dw_1.setfilter('')
	dw_1.filter()

	sqlca.autocommit = true
end if	


end subroutine

public subroutine wf_pase_pedido_factura ();long    ll_ann, ll_linea, ll_ann_encabezado, ll_ann_det, ll_fraccion, ll_bulto_ini, ll_bulto_fin, ll_index,&
		  ll_bultos, ll_linea_det, ll_ultima_linea, ll_ultimo_index, ll_convert
integer li_existe, i, li_pais
string  ls_pedido, ls_tipo, ls_pedido_encabezado, ls_pedido_det, ls_error, ls_uni_venta,&
		  ls_uni_prod, ls_codigo_item, ls_descrip, ls_uni_peso, ls_bodega, ls_ubicacion, ls_usuario,&
		  ls_supervisor, ls_decu_subt_det
datetime ldt_fecha_serv, ldt_fecha, ld_fecha_reg 
decimal	ld_cubicaje, ld_peso, ld_precio_ma, ld_precio_me, ld_costo_fob,&
			ld_costo_cif, ld_precio, ld_monto_total, ld_por_descuento, ld_monto_final, ld_precio_original,&
			ld_costo_total, ld_monto_tot_pas, ld_precio_minimo ,ld_precio_descuento
decimal	ld_cantidad, ld_pasada, ld_cantidad_total			
long		ll_validado, ll_vendedor,ll_pedido_vta_detal, ll_ann_orden_compra, ll_ann_transito, ll_ann_esc
integer  ll_linea_transito, ll_linea_orden , li_viene_de_pedido
string   ls_promocion, ls_reserva_origen, ls_num_orden_compra, ls_num_transito, ls_restaurado_por
			
			
sqlca.autocommit = false

ldt_fecha_serv = gf_fecha_serv()

dw_1.setfilter("incluir = 1")
dw_1.filter()

if dw_1.rowcount() = 0 then
	mensaje("Aviso","Debe seleccionar " + st_1.text + " a pasar...","No se puede hacer ningun pase si no se ha seleccionado un documento...Verifique")
	dw_1.setfilter('')
	dw_1.filter()
	return
end if

ll_ann    = w_fa_fondo.str_para.ano
dw_3.accepttext()
ls_pedido = trim(dw_3.getitemstring(1,'pedido'))
ls_tipo	 = pedido.getitemstring(pedido.getrow(),'fact_tipo')
if ls_pedido = '' or len(ls_pedido) < 1 or isnull(ls_pedido) then
	mensaje("Aviso","Debe asignar el número de Factura" ,"")
	dw_1.setfilter('')
	dw_1.filter()
	return
end if

if ii_index = 4 then// Pedido a  Factura
	if gf_mensaje('',' ¿ Está Seguro de Ejecutar el Pase ?',2,1,'E') = 2 then	
		dw_1.setfilter('')
		dw_1.filter()		
		return
	end if
	
	ll_ann_esc = pedido.getitemnumber(pedido.getrow(),'anno') 
	
	  SELECT max(faddiari.facd_linea),   
	         max(faddiari.facd_index) 
   	INTO  :ll_ultima_linea,
		      :ll_ultimo_index
		 FROM faddiari  
   	WHERE ( faddiari.facd_empresa = :str.g_financiero  ) AND  
      	   ( faddiari.facd_empresa = :str.empresa) AND  
         	( faddiari.facd_ann =     :ll_ann_esc) AND  
				( faddiari.facd_tipo =	  :ls_tipo) AND
	         ( faddiari.facd_no_pedido = :ls_pedido )   ;
			if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al Seleccionar Pedido Origen',ls_error)					
					return
				end if	
				if isnull(ll_ultima_linea) then ll_ultima_linea = 0
 
// 			SELECT fatdiari.fact_tipo  
//		    INTO :ls_tipo  
//		    FROM fatdiari  
//		   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
//      		   ( fatdiari.fact_empresa = :str.empresa) AND  
//		         ( fatdiari.fact_no_pedido = :ls_pedido) AND  
//	   		   ( fatdiari.fact_ann = :ll_ann_esc)   ;
//					if sqlca.sqlcode = -1 then
//						ls_error = sqlca.sqlerrtext
//						rollback;
//						mensaje('Aviso','Error al Seleccionar Pedido Origen',ls_error)					
//						return
//					end if	
//					if isnull(ls_tipo) then ls_tipo = '0'

	  
	/*INSERTANDO EL DETALLE DE EL O LOS PEDIDOS*/
	for i = 1 to dw_1.rowcount()
		 ls_pedido_det = dw_1.getitemString(i,"fatpedid_pedi_no_pedido")	
		 ll_ann_det	  = dw_1.getitemnumber(i,'fatpedid_pedi_ann')

		/*PARA SELECCIONAR DEL ENCABEZADO DE PEDIDOS, SI EL MISMO FUE RESTAURADO O NO*/
		   SELECT isnull(fatpedid.pedi_restaurado_por,'')  
			 INTO :ls_restaurado_por  
			 FROM fatpedid  
			WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
					( fatpedid.pedi_empresa = :str.empresa ) AND  
					( fatpedid.pedi_no_pedido = :ls_pedido_det ) AND  
					( fatpedid.pedi_ann = :ll_ann_det )   ;
		 		if sqlca.sqlcode = -1 then
					mensaje('Aviso','Error al Seleccionar el Restaurado por ..',sqlca.sqlerrtext)	
			 	end if
				 //Si fue restaurado el pedido, entonces debe reservar nuevamente cuando se 
				 //inserte en faddiari
				if trim(ls_restaurado_por) = '' then
					li_viene_de_pedido = 1 //no fue restaurado, No reserva nuevamente
				else
					li_viene_de_pedido = 0 //Fue restaurado,	Reserva nuevamente
				end if
		/********************/				 
		 
	 	DECLARE cur_pedidos CURSOR FOR  
			  SELECT fadpedid.dped_codigo_item,   
						fadpedid.dped_descripcion_alterna,   
						fadpedid.dped_cubicaje,   
						fadpedid.dped_peso, 
						fadpedid.dped_unidad_peso,   
						fadpedid.dped_unidad_producto,   
						fadpedid.dped_precio_mayor,   
						fadpedid.dped_precio_menor,   
						fadpedid.dped_bodega,   
						fadpedid.dped_costo_fob,   
						fadpedid.dped_costo_cif,   
						fadpedid.dped_precio_unidad_producto,   
						fadpedid.dped_unidad_venta,   
						fadpedid.dped_cantidad,   
						fadpedid.dped_fraccion,   
						fadpedid.dped_monto_total,   
						fadpedid.dped_por_descuento,   
						fadpedid.dped_monto_final,   
						fadpedid.dped_usuario,   
						fadpedid.dped_supervisor,   
						fadpedid.dped_bultos,   
						fadpedid.dped_ubicacion,   
						fadpedid.dped_bulto_inicio,   
						fadpedid.dped_bulto_fin,   
						fadpedid.dped_precio_original,   
						fadpedid.dped_linea,   
						fadpedid.dped_index,
						(fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion) - fadpedid.dped_pasada pasada,
						(fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion) ld_cantidad_total ,dped_precio_descuento,						
					   (fadpedid.dped_cantidad * fadpedid.dped_costo_cif) + ((fadpedid.dped_costo_cif / inamedid.medi_cantidad ) * fadpedid.dped_fraccion)
				 FROM fadpedid, 
				 		inamedid
				 Where fadpedid.dped_g_financiero = :str.g_financiero and
						 fadpedid.dped_empresa      = :str.empresa and
						 fadpedid.dped_no_pedido	 = :ls_pedido_det and					 
						 fadpedid.dped_ann			 = :ll_ann_det and
					 	(fadpedid.dped_unidad_venta = inamedid.medi_medida )
			ORDER BY fadpedid.dped_index ASC  ;		
					if sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrtext
						rollback;
						mensaje('Aviso','Error al declarar el cursor',ls_error)					
						return
					end if	
				open cur_pedidos;
		
					if sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrtext
						rollback;
						mensaje('Aviso','Error al abrir el cursor',ls_error)	
						return
					end if			

		
				fetch cur_pedidos into :ls_codigo_item, :ls_descrip, :ld_cubicaje, :ld_peso, :ls_uni_peso,&
									  :ls_uni_prod, :ld_precio_ma, :ld_precio_me, :ls_bodega, :ld_costo_fob,&
									  :ld_costo_cif, :ld_precio, :ls_uni_venta, :ld_cantidad, :ll_fraccion,&
									  :ld_monto_total, :ld_por_descuento, :ld_monto_final, :ls_usuario, :ls_supervisor,&
									  :ll_bultos, :ls_ubicacion, :ll_bulto_ini, :ll_bulto_fin, :ld_precio_original,&
									  :ll_linea, :ll_index, :ld_pasada, :ld_cantidad_total, :ld_precio_descuento,:ld_costo_total ;
		
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				close cur_pedidos;				
				rollback;
				mensaje('Aviso','Error en el Fetch del cursor',ls_error)	
				return
			end if					
		
			//Para tomar la linea del detalle, y actualizar la cantidad pasada
			ll_linea_det = ll_linea
			
	 do while sqlca.sqlcode = 0		
		
		//Se pone para que cuando se seleccionan mas de un registro a pasar, modifique la linea
		//y el orden
			ll_ultima_linea ++
			ll_ultimo_index ++
			
			//ENTRA A RECALCULAR TOTALES SOLO SI LA CANTIDAD DISPONIBLE ES DIFERENTE A LA CANTIDAD TOTAL
			if ld_pasada <> ld_cantidad_total then			
					//Transforma lo disponible por pasar en cantidad - fraccion	
					gf_fa_convertuni_new_dec(ls_uni_venta,ld_pasada,ld_cantidad,ll_fraccion)						
					ld_cantidad = truncate(ld_cantidad,0)
		
					//********************************************/*********************
					//SI LA CANTIDAD CAMBIA, SE CALCULA EL MONTO FINAL Y TOTAL
					  ll_convert 		 = gf_unidad_venta(ls_uni_venta,gf_medi_prod(ls_uni_prod))
					  ld_precio_minimo = ld_precio / ll_convert					  					  
					  ld_por_descuento = 0	//Para descartar si tiene descuento en el detalle	  
					  //Calcula el monto total de la linea de detalle							
					  ld_monto_tot_pas = round(ld_precio_minimo * ld_pasada ,2)
					  ld_monto_total 	 =  ld_monto_tot_pas
					  ld_monto_final 	 =  ld_monto_total 
					  //Calcula el Costo total de la linea de detalle						 
					  
					//***********************************************************************
				end if //si es <> la cantidad total con la disponible por pasar
				
				ld_costo_total = truncate(round(ld_costo_total,2),2)
				ld_precio_descuento = truncate(round(ld_precio_descuento,2),2)
				
			INSERT INTO faddiari  
					( facd_g_financiero,   
					  facd_empresa,   
					  facd_tipo,   
					  facd_no_pedido,   
					  facd_pedido_original,   
					  facd_linea,   
					  facd_ann,   
					  facd_producto_servicio,   
					  facd_codigo_item,   
					  facd_descripcion_alterna,   
					  facd_cubicaje,   
					  facd_peso,   
					  facd_unidad_peso,   
					  facd_unidad_producto,   
					  facd_precio_mayor,   
					  facd_precio_menor,   
					  facd_bodega,   
					  facd_costo_fob,   
					  facd_costo_cif,   
					  facd_precio_unidad_producto,   
					  facd_unidad_venta,   
					  facd_cantidad,   
					  facd_cantidad_fraccion,   
					  facd_monto_total,   
					  facd_por_descuento,   
					  facd_monto_final,   
					  facd_usuario,   
					  facd_supervisor,   
					  facd_bultos,   
					  facd_ubicacion,   
					  facd_cant_devuelta,   
					  facd_linea_articulo_dev,
					  facd_index,
					  facd_viene_de_pedido,
					  facd_bulto_inicio,
					  facd_bulto_fin,
					  facd_precio_original,
					  facd_costo_total,facd_precio_descuento)
				VALUES (:str.g_financiero,   
						  :str.empresa,   
						  :ls_tipo,
						  :ls_pedido,
						  :ls_pedido_det,
						  :ll_ultima_linea,  
						  :ll_ann,   
						  'P',
						  :ls_codigo_item,
						  :ls_descrip,
						  :ld_cubicaje,
						  :ld_peso,
						  :ls_uni_peso,
						  :ls_uni_prod,
						  :ld_precio_ma,
						  :ld_precio_me,
						  :ls_bodega,
						  :ld_costo_fob,
						  :ld_costo_cif,
						  :ld_precio,
						  :ls_uni_venta,
						  :ld_cantidad,
						  :ll_fraccion,
						  :ld_monto_total,
						  :ld_por_descuento,
						  :ld_monto_final,
						  :ls_usuario,
						  :ls_supervisor,
						  :ll_bultos,
						  :ls_ubicacion,
						  0,
						  0,
						  :ll_ultimo_index,
						  :li_viene_de_pedido,
						  :ll_bulto_ini,
						  :ll_bulto_fin,
						  :ld_precio_original,
						  :ld_costo_total,
						  :ld_precio_descuento) ;						  
						  
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					close cur_pedidos;					
					mensaje('Aviso','Error al Insertar el Detalle en Faddiari',ls_error)					
					return
				end if					
			
					//UPDATE DE LAS CANTIDADES PASADAS, EN PEDIDOS
					  UPDATE fadpedid  
						  SET dped_pasada = dped_pasada + :ld_pasada  
						WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
								( fadpedid.dped_empresa = :str.empresa ) AND  
								( fadpedid.dped_no_pedido = :ls_pedido_det ) AND  
								( fadpedid.dped_ann = :ll_ann_det ) AND  
								( fadpedid.dped_linea = :ll_linea_det ) ;
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_pedidos;
							mensaje('Aviso','Error al actualizar la cantidad pasada',ls_error)	
							return
						end if																																
			
			
		fetch cur_pedidos into :ls_codigo_item, :ls_descrip, :ld_cubicaje, :ld_peso, :ls_uni_peso,&
									  :ls_uni_prod, :ld_precio_ma, :ld_precio_me, :ls_bodega, :ld_costo_fob,&
									  :ld_costo_cif, :ld_precio, :ls_uni_venta, :ld_cantidad, :ll_fraccion,&
									  :ld_monto_total, :ld_por_descuento, :ld_monto_final, :ls_usuario, :ls_supervisor,&
									  :ll_bultos, :ls_ubicacion, :ll_bulto_ini, :ll_bulto_fin, :ld_precio_original,&
									  :ll_linea, :ll_index, :ld_pasada , :ld_cantidad_total,:ld_precio_descuento ,:ld_costo_total;
		
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					close cur_pedidos;
					mensaje('Aviso','Error en el Fetch del cursor',ls_error)	
					return
				end if								
						
				ll_linea_det = ll_linea
				//Para tomar la linea del detalle, y actualizar la cantidad pasada												
		loop
	

		/*CIERRA EL CURSOR*/
		close cur_pedidos;
	
		/*UPDATE DEL ESTADO DEL PEDIDO A PASADO Y DE LAS CANTIDADES PASADAS*/
		  UPDATE fatpedid  
			  SET pedi_estado = 'P'  
			WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
					( fatpedid.pedi_empresa = :str.empresa ) AND  
					( fatpedid.pedi_no_pedido = :ls_pedido_det ) AND  
					( fatpedid.pedi_ann = :ll_ann_det )   ;
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_pedidos;
							mensaje('Aviso','Error al actualizar el pedido a pasado',ls_error)
							return
						end if
						
	
	Next //Del Ciclo for de los pedidos a pasar

/*Add by HGN september 24/2001*/

	  SELECT sum(faddiari.facd_cubicaje),   
				sum(faddiari.facd_peso),   
				sum(faddiari.facd_monto_total),   
				sum(faddiari.facd_monto_final),   
				sum(faddiari.facd_bultos),   
				sum(faddiari.facd_costo_total)  
			INTO :ld_cubicaje,
				  :ld_peso,
				  :ld_monto_total,
				  :ld_monto_final,
				  :ll_bultos,
				  :ld_costo_total
		 FROM faddiari  
		WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
				( faddiari.facd_empresa = :str.empresa ) AND  
				( faddiari.facd_tipo = :ls_tipo ) AND  
				( faddiari.facd_no_pedido = :ls_pedido ) AND  
				( faddiari.facd_ann = :ll_ann ) ;

				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					close cur_pedidos;
					mensaje('Aviso','Error al acumular totales para el encabezado faddiari',ls_error)
					return
				end if
		
		ld_cubicaje = round(ld_cubicaje,4)
		ld_peso 		= round(ld_peso,4)
		
	  UPDATE fatdiari  
		  SET fact_bultos_total 	= :ll_bultos,   
				fact_cubicaje_total 	= :ld_cubicaje,   
				fact_peso_total 		= :ld_peso,   
				fact_monto_fact_total = :ld_monto_total,   
				fact_monto_final 		= :ld_monto_final,   
				fact_costos_total 	= :ld_costo_total  
		WHERE ( fatdiari.fact_g_financiero 	= :str.g_financiero ) AND  
				( fatdiari.fact_empresa 		= :str.empresa ) AND  
				( fatdiari.fact_tipo 			= :ls_tipo ) AND  
				( fatdiari.fact_no_pedido 		= :ls_pedido ) AND  
				( fatdiari.fact_ann 				= :ll_ann) ;

				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					close cur_pedidos;
					mensaje('Aviso','Error al actualizar totales del encabezado fatdiari',ls_error)
					return
				end if
/**/
	close cur_pedidos; //cierra el cursor
	commit;
	gf_mensaje('','Pase efectuado Satisfactoriamente',1,1,"E")
	dw_1.setfilter('')
	dw_1.filter()
	sqlca.autocommit = true
	
end if	
end subroutine

public subroutine wf_pase_pedido_pedido ();long    ll_ann, ll_linea, ll_ann_encabezado, ll_ann_det, ll_fraccion, ll_bulto_ini, ll_bulto_fin, ll_index,&
		  ll_bultos, ll_linea_det, ll_ultima_linea, ll_ultimo_index
integer li_existe, i, li_pais
string  ls_pedido, ls_tipo, ls_pedido_encabezado, ls_pedido_det, ls_error, ls_uni_venta,&
		  ls_uni_prod, ls_codigo_item, ls_descrip, ls_uni_peso, ls_bodega, ls_ubicacion, ls_usuario,&
		  ls_supervisor		  
datetime ldt_fecha_serv, ldt_fecha, ld_fecha_reg 
Decimal	ld_pasada, ld_cantidad, ld_cubicaje, ld_peso, ld_precio_ma, ld_precio_me, ld_costo_fob,&
			ld_costo_cif, ld_precio, ld_monto_total, ld_por_descuento, ld_monto_final, ld_precio_original,&
			ld_costo_total,ld_precio_descuento
			
long		ll_validado, ll_vendedor,ll_pedido_vta_detal, ll_ann_orden_compra, ll_ann_transito, ll_ann_esc
integer  ll_linea_transito, ll_linea_orden 
string   ls_promocion, ls_reserva_origen, ls_num_orden_compra, ls_num_transito
			
			
sqlca.autocommit = false

ldt_fecha_serv = gf_fecha_serv()

dw_1.setfilter("incluir = 1")
dw_1.filter()

if dw_1.rowcount() = 0 then
	mensaje("Aviso","Debe seleccionar " + st_1.text + " a pasar...","No se puede hacer ningun pase si no se ha seleccionado un documento...Verifique")
	dw_1.setfilter('')
	dw_1.filter()
	return
end if

ll_ann    = w_fa_fondo.str_para.ano
dw_3.accepttext()
ls_pedido = trim(dw_3.getitemstring(1,'pedido'))
if ls_pedido = '' or len(ls_pedido) < 1 or  isnull(ls_pedido) then
	mensaje("Aviso","Debe asignar el número de Pedido " ,"")
	dw_1.setfilter('')
	dw_1.filter()
	return
end if

if ii_index = 3 then// Pedido a  Pedido
	ll_ultima_linea = 0
	ll_ultimo_index = 0
	if gf_mensaje('',' ¿ Está Seguro de Ejecutar el Pase ?',2,1,'E') = 2 then	
		dw_1.setfilter('')
		dw_1.filter()		
		return
	end if
	/*INSERTANDO EL DETALLE DE EL O LOS PEDIDOS*/
      ll_ann_esc = pedido.getitemnumber(pedido.getrow(),'anno') 
		
	   SELECT max(fadpedid.dped_linea),
	          max(fadpedid.dped_index)
		INTO  :ll_ultima_linea,
		      :ll_ultimo_index
	    FROM fadpedid
		 Where fadpedid.dped_g_financiero = :str.g_financiero and
				 fadpedid.dped_empresa      = :str.empresa and
				 fadpedid.dped_no_pedido	 = :ls_pedido and					 
				 fadpedid.dped_ann			 = :ll_ann_esc;
		
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al Seleccionar Pedido Origen',ls_error)					
					return
				end if	
	if isnull(ll_ultima_linea) then ll_ultima_linea = 0

//Viene de pedido = 1 para que no reserve nuevamente

  UPDATE fatpedid  
	  SET pedi_viene_de_pedido =  1 
	WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
			( fatpedid.pedi_empresa = :str.empresa ) AND  
			( fatpedid.pedi_no_pedido = :ls_pedido ) AND  
			( fatpedid.pedi_ann = :ll_ann_esc )   ;
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al actualizar el pedido a 1 en viene de pedido',ls_error)
					return
				end if									   
//		Ciclo para insertar los detalle de los pedidos
		
	 for i = 1 to dw_1.rowcount()
   	  ls_pedido_det = dw_1.getitemString(i,"fatpedid_pedi_no_pedido")	
		  ll_ann_det	  = dw_1.getitemnumber(i,'fatpedid_pedi_ann')
		
	 	DECLARE cur_pedidos1 CURSOR FOR  
			  SELECT fadpedid.dped_codigo_item,   
						fadpedid.dped_descripcion_alterna,   
						fadpedid.dped_cubicaje,   
						fadpedid.dped_peso, 
						fadpedid.dped_unidad_peso,   
						fadpedid.dped_unidad_producto,   
						fadpedid.dped_precio_mayor,   
						fadpedid.dped_precio_menor,   
						fadpedid.dped_bodega,   
						fadpedid.dped_costo_fob,   
						fadpedid.dped_costo_cif,   
						fadpedid.dped_precio_unidad_producto,   
						fadpedid.dped_unidad_venta,   
						fadpedid.dped_cantidad,   
						fadpedid.dped_fraccion,   
						fadpedid.dped_monto_total,   
						fadpedid.dped_por_descuento,   
						fadpedid.dped_monto_final,   
						fadpedid.dped_usuario,   
						fadpedid.dped_supervisor,   
						fadpedid.dped_bultos,   
						fadpedid.dped_ubicacion,   
						fadpedid.dped_bulto_inicio,   
						fadpedid.dped_bulto_fin,   
						fadpedid.dped_precio_original,   
						fadpedid.dped_linea,   
						fadpedid.dped_index,
						fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion pasada,
						fadpedid.dped_validado,   
		            fadpedid.dped_vendedor,   
			         fadpedid.dped_pedido_vta_detal,   
			         fadpedid.dped_promocion, 
					   fadpedid.dped_reserva_origen, 
       			   fadpedid.dped_num_orden_compra,   
                  fadpedid.dped_ann_orden_compra,   
                  fadpedid.dped_num_transito,   
                  fadpedid.dped_ann_transito,   
                  fadpedid.dped_linea_orden,   
                  fadpedid.dped_linea_transito,dped_precio_descuento,
					   (fadpedid.dped_cantidad * fadpedid.dped_costo_cif) + ((fadpedid.dped_costo_cif / inamedid.medi_cantidad ) * fadpedid.dped_fraccion)
				 FROM fadpedid, 
				 		inamedid
				 Where fadpedid.dped_g_financiero = :str.g_financiero and
						 fadpedid.dped_empresa      = :str.empresa and
						 fadpedid.dped_no_pedido	 = :ls_pedido_det and					 
						 fadpedid.dped_ann			 = :ll_ann_det and
					 	(fadpedid.dped_unidad_venta = inamedid.medi_medida )
			ORDER BY fadpedid.dped_index ASC  ;		
					if sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrtext
						rollback;
						mensaje('Aviso','Error al declarar el cursor',ls_error)					
						return
					end if	
				open cur_pedidos1;
		
					if sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrtext
						rollback;
						mensaje('Aviso','Error al abrir el cursor',ls_error)	
						return
					end if			

		
				fetch cur_pedidos1 into :ls_codigo_item, :ls_descrip, :ld_cubicaje, :ld_peso, :ls_uni_peso,&
									  :ls_uni_prod, :ld_precio_ma, :ld_precio_me, :ls_bodega, :ld_costo_fob,&
									  :ld_costo_cif, :ld_precio, :ls_uni_venta, :ld_cantidad, :ll_fraccion,&
									  :ld_monto_total, :ld_por_descuento, :ld_monto_final, :ls_usuario, :ls_supervisor,&
									  :ll_bultos, :ls_ubicacion, :ll_bulto_ini, :ll_bulto_fin, :ld_precio_original,&
									  :ll_linea, :ll_index, :ld_pasada, :ll_validado, :ll_vendedor, :ll_pedido_vta_detal,&   
			                    :ls_promocion,:ls_reserva_origen, :ls_num_orden_compra,:ll_ann_orden_compra,&   
                             :ls_num_transito,:ll_ann_transito,:ll_linea_orden, :ll_linea_transito, :ld_precio_descuento,:ld_costo_total ;
		
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				close cur_pedidos1;				
				rollback;
				mensaje('Aviso','Error en el Fetch del cursor',ls_error)	
				return
			end if					
		ll_linea_det = ll_linea
			//Para tomar la linea del detalle, y actualizar la cantidad pasada
	 do while sqlca.sqlcode = 0		
        ll_ultima_linea ++
		  ll_ultimo_index ++
		  
 		  ld_costo_total = truncate(round(ld_costo_total,2),2)
		  ld_precio_descuento = truncate(round(ld_precio_descuento,2),2)
		  
	 INSERT INTO fadpedid  
         ( dped_g_financiero,   
           dped_empresa,   
           dped_no_pedido,   
           dped_ann,   
           dped_linea,   
           dped_producto_servicio,   
           dped_codigo_item,   
           dped_descripcion_alterna,   
           dped_cubicaje,   
           dped_peso,   
           dped_unidad_peso,   
           dped_unidad_producto,   
           dped_precio_mayor,   
           dped_precio_menor,   
           dped_bodega,   
           dped_costo_fob,   
           dped_costo_cif,   
           dped_precio_unidad_producto,   
           dped_unidad_venta,   
           dped_cantidad,   
           dped_fraccion,   
           dped_monto_total,   
           dped_por_descuento,   
           dped_monto_final,   
           dped_usuario,   
           dped_supervisor,   
           dped_bultos,   
           dped_ubicacion,   
           dped_pasada,   
           dped_cant_asignada,   
           dped_index,
			  dped_validado,   
           dped_vendedor,   
           dped_pedido_vta_detal,   
           dped_promocion,  
			  dped_bulto_inicio,   
           dped_bulto_fin,   
           dped_precio_original, 
			  dped_reserva_origen, 
			  dped_num_orden_compra,   
           dped_ann_orden_compra,   
           dped_num_transito,   
           dped_ann_transito,   
           dped_linea_orden,   
           dped_linea_transito,
			  dped_costo_total,
			  dped_viene_de_pedido,dped_precio_descuento)  
  VALUES (:str.g_financiero,   
			 :str.empresa,   
			 :ls_pedido,
		    :ll_ann,
			 :ll_ultima_linea,  
			 'P',
			 :ls_codigo_item,
			 :ls_descrip,
			 :ld_cubicaje,
			 :ld_peso,
			 :ls_uni_peso,
			 :ls_uni_prod,
			 :ld_precio_ma,
			 :ld_precio_me,
			 :ls_bodega,
			 :ld_costo_fob,
			 :ld_costo_cif,
			 :ld_precio,
			 :ls_uni_venta,
			 :ld_cantidad,
			 :ll_fraccion,
			 :ld_monto_total,
			 :ld_por_descuento,
			 :ld_monto_final,
			 :ls_usuario,
			 :ls_supervisor,
			 :ll_bultos,
			 :ls_ubicacion,
			 0,
			 0,
			 :ll_ultimo_index,
			 :ll_validado,
			 :ll_vendedor,
			 :ll_pedido_vta_detal,
			 :ls_promocion,
			 :ll_bulto_ini,
			 :ll_bulto_fin,
			 :ld_precio_original,
			 :ls_reserva_origen,
			 :ls_num_orden_compra,
			 :ll_ann_orden_compra,
			 :ls_num_transito,
			 :ll_ann_transito,
			 :ll_linea_orden, 
			 :ll_linea_transito,
			 :ld_costo_total,
			 1,
			 :ld_precio_descuento);						  
			 
			  if sqlca.sqlcode = -1 then
				  ls_error = sqlca.sqlerrtext
					rollback;
					close cur_pedidos1;					
					mensaje('Aviso','Error al Insertar el Detalle en FadPedi',ls_error)					
					return
				end if					
				//UPDATE DE LAS CANTIDADES PASADAS, EN PEDIDOS
			  UPDATE fadpedid  
				  SET dped_pasada = dped_pasada + :ld_pasada  
				WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
						( fadpedid.dped_empresa = :str.empresa ) AND  
						( fadpedid.dped_no_pedido = :ls_pedido_det ) AND  
						( fadpedid.dped_ann = :ll_ann_det ) AND  
						( fadpedid.dped_linea = :ll_linea_det ) ;
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_pedidos1;
							mensaje('Aviso','Error al actualizar la cantidad pasada',ls_error)	
							return
						end if																																
			
			
		fetch cur_pedidos1 into :ls_codigo_item, :ls_descrip, :ld_cubicaje, :ld_peso, :ls_uni_peso,&
									  :ls_uni_prod, :ld_precio_ma, :ld_precio_me, :ls_bodega, :ld_costo_fob,&
									  :ld_costo_cif, :ld_precio, :ls_uni_venta, :ld_cantidad, :ll_fraccion,&
									  :ld_monto_total, :ld_por_descuento, :ld_monto_final, :ls_usuario, :ls_supervisor,&
									  :ll_bultos, :ls_ubicacion, :ll_bulto_ini, :ll_bulto_fin, :ld_precio_original,&
									  :ll_linea, :ll_index, :ld_pasada ,:ll_validado, :ll_vendedor, :ll_pedido_vta_detal,&   
			                    :ls_promocion,:ls_reserva_origen, :ls_num_orden_compra,:ll_ann_orden_compra,&   
                             :ls_num_transito,:ll_ann_transito,:ll_linea_orden, :ll_linea_transito, :ld_precio_descuento,:ld_costo_total  ;		

						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_pedidos1;
							mensaje('Aviso','Error en el Fetch del cursor',ls_error)	
							return
						end if								
						
						ll_linea_det = ll_linea
						//Para tomar la linea del detalle, y actualizar la cantidad pasada												
		loop
		/*CIERRA EL CURSOR*/
		close cur_pedidos1;
	
		/*UPDATE DEL ESTADO DEL PEDIDO A PASADO Y DE LAS CANTIDADES PASADAS*/
		  UPDATE fatpedid  
			  SET pedi_estado = 'P'  
			WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
					( fatpedid.pedi_empresa = :str.empresa ) AND  
					( fatpedid.pedi_no_pedido = :ls_pedido_det ) AND  
					( fatpedid.pedi_ann = :ll_ann_det )   ;
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_pedidos1;
							mensaje('Aviso','Error al actualizar el pedido a pasado',ls_error)
							return
						end if								

	
	Next //Del Ciclo for de los pedidos a pasar

//Actualiza el campo de viene de pedido en el encabezado del pedido destino, para que pueda 
//reservar y liberar

  UPDATE fatpedid  
	  SET pedi_viene_de_pedido =  0 
	WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
			( fatpedid.pedi_empresa = :str.empresa ) AND  
			( fatpedid.pedi_no_pedido = :ls_pedido ) AND  
			( fatpedid.pedi_ann = :ll_ann_esc )   ;
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					close cur_pedidos1;
					mensaje('Aviso','Error al actualizar el pedido a 0 en viene de pedido',ls_error)
					return
				end if								

/*Add by HGN 24/09/2001 Calcula totales y los setea en encabezado destino*/
  SELECT sum(fadpedid.dped_bultos),   
         sum(fadpedid.dped_cubicaje),   
         sum(fadpedid.dped_peso),   
         sum(fadpedid.dped_monto_total),   
         sum(fadpedid.dped_monto_final),   
         sum(fadpedid.dped_costo_total)  
    INTO  :ll_bultos,   
			 :ld_cubicaje,
			 :ld_peso,
			 :ld_monto_total,
			 :ld_monto_final,
			 :ld_costo_total
    FROM fadpedid  
	WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
			( fadpedid.dped_empresa = :str.empresa ) AND  
			( fadpedid.dped_no_pedido = :ls_pedido ) AND  
			( fadpedid.dped_ann = :ll_ann ) ;

			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje('Aviso','Error al calcular totales para el encabezado fadpedid',ls_error)
				close cur_pedidos1;
				return
			end if
			
	ld_cubicaje = round(ld_cubicaje,4)		
	ld_cubicaje = round(ld_peso,4)
	
	UPDATE fatpedid  
     SET pedi_bultos_total 	= :ll_bultos,   
         pedi_cubicaje_total 	= :ld_cubicaje,   
         pedi_peso_total 		= :ld_peso,   
         pedi_monto_total 		= :ld_monto_total,   
         pedi_monto_final 		= :ld_monto_final,   
         pedi_costos_total 		= :ld_costo_total  
   WHERE ( fatpedid.pedi_g_financiero 	= :str.g_financiero ) AND  
         ( fatpedid.pedi_empresa 		= :str.empresa ) AND  
         ( fatpedid.pedi_no_pedido 		= :ls_pedido ) AND  
         ( fatpedid.pedi_ann 				= :ll_ann ) ;

			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				close cur_pedidos1;
				mensaje('Aviso','Error al actualizar totales del encabezado fatpedid',ls_error)
				return
			end if
/**/
	close cur_pedidos1; //cierra el cursor
	commit;
	gf_mensaje('','Pase efectuado Satisfactoriamente',1,1,"E")
	dw_1.setfilter('')
	dw_1.filter()
	sqlca.autocommit = true
end if	
end subroutine

public subroutine wf_pase_pedido_pedido_pend ();long    ll_ann, ll_linea, ll_ann_encabezado, ll_ann_det, ll_fraccion, ll_bulto_ini, ll_bulto_fin, ll_index,&
		  ll_bultos, ll_linea_det, ll_ultima_linea, ll_ultimo_index, ll_cantidad
integer li_existe, i, li_pais, li_sqlcode
string  ls_pedido, ls_tipo, ls_pedido_encabezado, ls_pedido_det, ls_error, ls_uni_venta,&
		  ls_uni_prod, ls_codigo_item, ls_descrip, ls_uni_peso, ls_bodega, ls_ubicacion, ls_usuario,&
		  ls_supervisor		  
datetime ldt_fecha_serv, ldt_fecha, ld_fecha_reg 
double	ld_a_pasar, ld_pasada, ld_cantidad, ld_cubicaje, ld_peso, ld_precio_ma, ld_precio_me, ld_costo_fob,&
			ld_costo_cif, ld_precio, ld_monto_total, ld_por_descuento, ld_monto_final, ld_precio_original,&
			ld_costo_total
			
long		ll_validado, ll_vendedor,ll_pedido_vta_detal, ll_ann_orden_compra, ll_ann_transito, ll_ann_esc
integer  ll_linea_transito, ll_linea_orden 
string   ls_promocion, ls_reserva_origen, ls_num_orden_compra, ls_num_transito
decimal	ld_precio_descuento			
			
sqlca.autocommit = false

ldt_fecha_serv = gf_fecha_serv()

dw_1.setfilter("incluir = 1")
dw_1.filter()

if dw_1.rowcount() = 0 then
	mensaje("Aviso","Debe seleccionar " + st_1.text + " a pasar...","No se puede hacer ningun pase si no se ha seleccionado un documento...Verifique")
	dw_1.setfilter('')
	dw_1.filter()
	return
end if

ll_ann    = 	w_fa_fondo.str_para.ano
dw_3.accepttext()
ls_pedido = trim(dw_3.getitemstring(1,'pedido'))
if ls_pedido = '' or len(ls_pedido) < 1 or  isnull(ls_pedido) then
	mensaje("Aviso","Debe asignar el número de Pedido " ,"")
	dw_1.setfilter('')
	dw_1.filter()
	return
end if

if ii_index = 3 then// Pedido a  Pedido
	ll_ultima_linea = 0
	ll_ultimo_index = 0
	if gf_mensaje('',' ¿ Está Seguro de Ejecutar el Pase ?',2,1,'E') = 2 then	
		dw_1.setfilter('')
		dw_1.filter()		
		return
	end if
	/*INSERTANDO EL DETALLE DE EL O LOS PEDIDOS*/
      ll_ann_esc = pedido.getitemnumber(pedido.getrow(),'anno') 
		
	   SELECT max(fadpedid.dped_linea),
	          max(fadpedid.dped_index)
		INTO  :ll_ultima_linea,
		      :ll_ultimo_index
	    FROM fadpedid
		 Where fadpedid.dped_g_financiero = :str.g_financiero and
				 fadpedid.dped_empresa      = :str.empresa and
				 fadpedid.dped_no_pedido	 = :ls_pedido and					 
				 fadpedid.dped_ann			 = :ll_ann_esc;
		
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al Seleccionar Pedido Origen',ls_error)					
					return
				end if	
	if isnull(ll_ultima_linea) then ll_ultima_linea = 0
	if isnull(ll_ultimo_index) then ll_ultimo_index = 0	
	   
//Viene de pedido = 1 para que no reserve nuevamente

  UPDATE fatpedid  
	  SET pedi_viene_de_pedido =  1 
	WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
			( fatpedid.pedi_empresa = :str.empresa ) AND  
			( fatpedid.pedi_no_pedido = :ls_pedido ) AND  
			( fatpedid.pedi_ann = :ll_ann_esc )   ;
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al actualizar el pedido a 1 en viene de pedido',ls_error)
					return
				end if									   
//		Ciclo para insertar los detalle de los pedidos		
		
	 for i = 1 to dw_1.rowcount()
   	  ls_pedido_det = dw_1.getitemString(i,"fatpedid_pedi_no_pedido")	
		  ll_ann_det	  = dw_1.getitemnumber(i,'fatpedid_pedi_ann')
		
	 	DECLARE cur_pedidos1 CURSOR FOR  
			  SELECT fadpedid.dped_codigo_item,   
						fadpedid.dped_descripcion_alterna,   
						fadpedid.dped_cubicaje,   
						fadpedid.dped_peso, 
						fadpedid.dped_unidad_peso,   
						fadpedid.dped_unidad_producto,   
						fadpedid.dped_precio_mayor,   
						fadpedid.dped_precio_menor,   
						fadpedid.dped_bodega,   
						fadpedid.dped_costo_fob,   
						fadpedid.dped_costo_cif,   
						fadpedid.dped_precio_unidad_producto,   
						fadpedid.dped_unidad_venta,   
						fadpedid.dped_cantidad,   
						fadpedid.dped_fraccion,   
						fadpedid.dped_monto_total,   
						fadpedid.dped_por_descuento,   
						fadpedid.dped_monto_final,   
						fadpedid.dped_usuario,   
						fadpedid.dped_supervisor,   
						fadpedid.dped_bultos,   
						fadpedid.dped_ubicacion,   
						fadpedid.dped_bulto_inicio,   
						fadpedid.dped_bulto_fin,   
						fadpedid.dped_precio_original,   
						fadpedid.dped_linea,   
						fadpedid.dped_index,
						fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion a_pasar,
						fadpedid.dped_validado,   
		            fadpedid.dped_vendedor,   
			         fadpedid.dped_pedido_vta_detal,   
			         fadpedid.dped_promocion, 
					   fadpedid.dped_reserva_origen, 
       			   fadpedid.dped_num_orden_compra,   
                  fadpedid.dped_ann_orden_compra,   
                  fadpedid.dped_num_transito,   
                  fadpedid.dped_ann_transito,   
                  fadpedid.dped_linea_orden,   
                  fadpedid.dped_linea_transito,
					   (fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion) - dped_pasada pasada,dped_precio_descuento,						
					   (fadpedid.dped_cantidad * fadpedid.dped_costo_cif) + ((fadpedid.dped_costo_cif / inamedid.medi_cantidad ) * fadpedid.dped_fraccion)
				 FROM fadpedid, 
				 		inamedid
				 Where fadpedid.dped_g_financiero = :str.g_financiero and
						 fadpedid.dped_empresa      = :str.empresa and
						 fadpedid.dped_no_pedido	 = :ls_pedido_det and					 
						 fadpedid.dped_ann			 = :ll_ann_det and
						 fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion > dped_pasada and						 
					 	(fadpedid.dped_unidad_venta = inamedid.medi_medida )
			ORDER BY fadpedid.dped_index ASC  ;		
					if sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrtext
						rollback;
						mensaje('Aviso','Error al declarar el cursor',ls_error)					
						return
					end if	
				open cur_pedidos1;
		
					if sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrtext
						rollback;
						mensaje('Aviso','Error al abrir el cursor',ls_error)	
						return
					end if			

		
				fetch cur_pedidos1 into :ls_codigo_item, :ls_descrip, :ld_cubicaje, :ld_peso, :ls_uni_peso,&
									  :ls_uni_prod, :ld_precio_ma, :ld_precio_me, :ls_bodega, :ld_costo_fob,&
									  :ld_costo_cif, :ld_precio, :ls_uni_venta, :ll_cantidad, :ll_fraccion,&
									  :ld_monto_total, :ld_por_descuento, :ld_monto_final, :ls_usuario, :ls_supervisor,&
									  :ll_bultos, :ls_ubicacion, :ll_bulto_ini, :ll_bulto_fin, :ld_precio_original,&
									  :ll_linea, :ll_index, :ld_a_pasar, :ll_validado, :ll_vendedor, :ll_pedido_vta_detal,&   
			                    :ls_promocion,:ls_reserva_origen, :ls_num_orden_compra,:ll_ann_orden_compra,&   
                             :ls_num_transito,:ll_ann_transito,:ll_linea_orden, :ll_linea_transito, :ld_pasada, :ld_precio_descuento,:ld_costo_total ;
		
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				close cur_pedidos1;				
				rollback;
				mensaje('Aviso','Error en el Fetch del cursor',ls_error)	
				return
			end if	

		   li_sqlcode = sqlca.sqlcode										
			
			ll_linea_det = ll_linea
			//Para tomar la linea del detalle, y actualizar la cantidad pasada
			
		//Para convertir lo pendiente por pasar en la unidad de venta
		gf_fa_convertuni_new(ls_uni_venta, ld_pasada, ll_cantidad, ll_fraccion)			
			
	 do while li_sqlcode = 0		
        ll_ultima_linea ++
		  ll_ultimo_index ++
		  
			ld_costo_total = truncate(round(ld_costo_total,2),2)
			ld_precio_descuento = truncate(round(ld_precio_descuento,2),2)
		  
	 INSERT INTO fadpedid  
         ( dped_g_financiero,   
           dped_empresa,   
           dped_no_pedido,   
           dped_ann,   
           dped_linea,   
           dped_producto_servicio,   
           dped_codigo_item,   
           dped_descripcion_alterna,   
           dped_cubicaje,   
           dped_peso,   
           dped_unidad_peso,   
           dped_unidad_producto,   
           dped_precio_mayor,   
           dped_precio_menor,   
           dped_bodega,   
           dped_costo_fob,   
           dped_costo_cif,   
           dped_precio_unidad_producto,   
           dped_unidad_venta,   
           dped_cantidad,   
           dped_fraccion,   
           dped_monto_total,   
           dped_por_descuento,   
           dped_monto_final,   
           dped_usuario,   
           dped_supervisor,   
           dped_bultos,   
           dped_ubicacion,   
           dped_pasada,   
           dped_cant_asignada,   
           dped_index,
			  dped_validado,   
           dped_vendedor,   
           dped_pedido_vta_detal,   
           dped_promocion,  
			  dped_bulto_inicio,   
           dped_bulto_fin,   
           dped_precio_original, 
			  dped_reserva_origen, 
			  dped_num_orden_compra,   
           dped_ann_orden_compra,   
           dped_num_transito,   
           dped_ann_transito,   
           dped_linea_orden,   
           dped_linea_transito,
			  dped_costo_total,
			  dped_viene_de_pedido,dped_precio_descuento)  
  VALUES (:str.g_financiero,   
			 :str.empresa,   
			 :ls_pedido,
		    :ll_ann,
			 :ll_ultima_linea,  
			 'P',
			 :ls_codigo_item,
			 :ls_descrip,
			 :ld_cubicaje,
			 :ld_peso,
			 :ls_uni_peso,
			 :ls_uni_prod,
			 :ld_precio_ma,
			 :ld_precio_me,
			 :ls_bodega,
			 :ld_costo_fob,
			 :ld_costo_cif,
			 :ld_precio,
			 :ls_uni_venta,
			 :ll_cantidad,
			 :ll_fraccion,
			 :ld_monto_total,
			 :ld_por_descuento,
			 :ld_monto_final,
			 :ls_usuario,
			 :ls_supervisor,
			 :ll_bultos,
			 :ls_ubicacion,
			 0,
			 0,
			 :ll_ultimo_index,
			 :ll_validado,
			 :ll_vendedor,
			 :ll_pedido_vta_detal,
			 :ls_promocion,
			 :ll_bulto_ini,
			 :ll_bulto_fin,
			 :ld_precio_original,
			 :ls_reserva_origen,
			 :ls_num_orden_compra,
			 :ll_ann_orden_compra,
			 :ls_num_transito,
			 :ll_ann_transito,
			 :ll_linea_orden, 
			 :ll_linea_transito,
			 :ld_costo_total,
			 1, //1 para que no reserve nuevamente, YA NO SE USA EN EL TRIGGER
			 :ld_precio_descuento);						  
			 
			  if sqlca.sqlcode = -1 then
				  ls_error = sqlca.sqlerrtext
					rollback;
					close cur_pedidos1;					
					mensaje('Aviso','Error al Insertar el Detalle en FadPedi',ls_error)					
					return
				end if					
				//UPDATE DE LAS CANTIDADES PASADAS, EN PEDIDOS
			  UPDATE fadpedid  
				  SET dped_pasada = dped_pasada + :ld_pasada  
				WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
						( fadpedid.dped_empresa = :str.empresa ) AND  
						( fadpedid.dped_no_pedido = :ls_pedido_det ) AND  
						( fadpedid.dped_ann = :ll_ann_det ) AND  
						( fadpedid.dped_linea = :ll_linea_det ) ;
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_pedidos1;
							mensaje('Aviso','Error al actualizar la cantidad pasada',ls_error)	
							return
						end if																																
			
			
		fetch cur_pedidos1 into :ls_codigo_item, :ls_descrip, :ld_cubicaje, :ld_peso, :ls_uni_peso,&
									  :ls_uni_prod, :ld_precio_ma, :ld_precio_me, :ls_bodega, :ld_costo_fob,&
									  :ld_costo_cif, :ld_precio, :ls_uni_venta, :ll_cantidad, :ll_fraccion,&
									  :ld_monto_total, :ld_por_descuento, :ld_monto_final, :ls_usuario, :ls_supervisor,&
									  :ll_bultos, :ls_ubicacion, :ll_bulto_ini, :ll_bulto_fin, :ld_precio_original,&
									  :ll_linea, :ll_index, :ld_a_pasar,:ll_validado, :ll_vendedor, :ll_pedido_vta_detal,&   
			                    :ls_promocion,:ls_reserva_origen, :ls_num_orden_compra,:ll_ann_orden_compra,&   
                             :ls_num_transito,:ll_ann_transito,:ll_linea_orden, :ll_linea_transito, :ld_pasada, :ld_costo_total,:ld_precio_descuento   ;		

						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_pedidos1;
							mensaje('Aviso','Error en el Fetch del cursor',ls_error)	
							return
						end if	
						
					   li_sqlcode = sqlca.sqlcode																

						//Para convertir lo pendiente por pasar en la unidad de venta
						gf_fa_convertuni_new(ls_uni_venta, ld_pasada, ll_cantidad, ll_fraccion)
						
						ll_linea_det = ll_linea
						//Para tomar la linea del detalle, y actualizar la cantidad pasada												
		loop
		/*CIERRA EL CURSOR*/
		close cur_pedidos1;
	
		/*UPDATE DEL ESTADO DEL PEDIDO A PASADO Y DE LAS CANTIDADES PASADAS*/
		  UPDATE fatpedid  
			  SET pedi_estado = 'P'  
			WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
					( fatpedid.pedi_empresa = :str.empresa ) AND  
					( fatpedid.pedi_no_pedido = :ls_pedido_det ) AND  
					( fatpedid.pedi_ann = :ll_ann_det )   ;
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_pedidos1;
							mensaje('Aviso','Error al actualizar el pedido a pasado',ls_error)
							return
						end if								

	
	Next //Del Ciclo for de los pedidos a pasar

//Actualiza el campo de viene de pedido en el encabezado del pedido destino, para que pueda 
//reservar y liberar

  UPDATE fatpedid  
	  SET pedi_viene_de_pedido =  0 
	WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
			( fatpedid.pedi_empresa = :str.empresa ) AND  
			( fatpedid.pedi_no_pedido = :ls_pedido ) AND  
			( fatpedid.pedi_ann = :ll_ann_esc )   ;
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					close cur_pedidos1;
					mensaje('Aviso','Error al actualizar el pedido a 0 en viene de pedido',ls_error)
					return
				end if								
/*Add by HGN 24/09/2001 Calcula totales y los setea en encabezado destino*/
  SELECT sum(fadpedid.dped_bultos),   
         sum(fadpedid.dped_cubicaje),   
         sum(fadpedid.dped_peso),   
         sum(fadpedid.dped_monto_total),   
         sum(fadpedid.dped_monto_final),   
         sum(fadpedid.dped_costo_total)  
    INTO  :ll_bultos,   
			 :ld_cubicaje,
			 :ld_peso,
			 :ld_monto_total,
			 :ld_monto_final,
			 :ld_costo_total
    FROM fadpedid  
	WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
			( fadpedid.dped_empresa = :str.empresa ) AND  
			( fadpedid.dped_no_pedido = :ls_pedido ) AND  
			( fadpedid.dped_ann = :ll_ann ) ;

			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				close cur_pedidos1;
				mensaje('Aviso','Error al calcular totales para el encabezado fadpedid',ls_error)
				return
			end if
			
	UPDATE fatpedid  
     SET pedi_bultos_total 	= :ll_bultos,   
         pedi_cubicaje_total 	= :ld_cubicaje,   
         pedi_peso_total 		= :ld_peso,   
         pedi_monto_total 		= :ld_monto_total,   
         pedi_monto_final 		= :ld_monto_final,   
         pedi_costos_total 		= :ld_costo_total  
   WHERE ( fatpedid.pedi_g_financiero 	= :str.g_financiero ) AND  
         ( fatpedid.pedi_empresa 		= :str.empresa ) AND  
         ( fatpedid.pedi_no_pedido 		= :ls_pedido ) AND  
         ( fatpedid.pedi_ann 				= :ll_ann ) ;

			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				close cur_pedidos1;
				mensaje('Aviso','Error al actualizar totales del encabezado fatpedid',ls_error)
				return
			end if
/**/

	close cur_pedidos1; //cierra el cursor
	commit;
	gf_mensaje('','Pase efectuado Satisfactoriamente',1,1,"E")
	dw_1.setfilter('')
	dw_1.filter()
	sqlca.autocommit = true
end if	//del index = 3

end subroutine

on w_pases_adicionales.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.rb_1=create rb_1
this.rb_2=create rb_2
this.dw_2=create dw_2
this.rb_4=create rb_4
this.rb_5=create rb_5
this.rb_6=create rb_6
this.pb_1=create pb_1
this.em_1=create em_1
this.em_2=create em_2
this.st_2=create st_2
this.st_3=create st_3
this.pb_2=create pb_2
this.rb_7=create rb_7
this.gb_2=create gb_2
this.rb_3=create rb_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_pedi_sala=create cb_pedi_sala
this.sle_pedido=create sle_pedido
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.st_4=create st_4
this.dw_3=create dw_3
this.cbx_pendiente=create cbx_pendiente
this.st_5=create st_5
this.em_ann=create em_ann
this.st_6=create st_6
this.em_ann_pedidos=create em_ann_pedidos
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.rb_4
this.Control[iCurrent+6]=this.rb_5
this.Control[iCurrent+7]=this.rb_6
this.Control[iCurrent+8]=this.pb_1
this.Control[iCurrent+9]=this.em_1
this.Control[iCurrent+10]=this.em_2
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.pb_2
this.Control[iCurrent+14]=this.rb_7
this.Control[iCurrent+15]=this.gb_2
this.Control[iCurrent+16]=this.rb_3
this.Control[iCurrent+17]=this.cb_1
this.Control[iCurrent+18]=this.cb_2
this.Control[iCurrent+19]=this.cb_pedi_sala
this.Control[iCurrent+20]=this.sle_pedido
this.Control[iCurrent+21]=this.st_1
this.Control[iCurrent+22]=this.ddlb_1
this.Control[iCurrent+23]=this.st_4
this.Control[iCurrent+24]=this.dw_3
this.Control[iCurrent+25]=this.cbx_pendiente
this.Control[iCurrent+26]=this.st_5
this.Control[iCurrent+27]=this.em_ann
this.Control[iCurrent+28]=this.st_6
this.Control[iCurrent+29]=this.em_ann_pedidos
end on

on w_pases_adicionales.destroy
call super::destroy
destroy(this.gb_3)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.dw_2)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.rb_6)
destroy(this.pb_1)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.pb_2)
destroy(this.rb_7)
destroy(this.gb_2)
destroy(this.rb_3)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_pedi_sala)
destroy(this.sle_pedido)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.st_4)
destroy(this.dw_3)
destroy(this.cbx_pendiente)
destroy(this.st_5)
destroy(this.em_ann)
destroy(this.st_6)
destroy(this.em_ann_pedidos)
end on

event ue_post_open;//Override
string ls_vienede, ls_where,ls_medact, ls_pedido
long ll_recupero
ii_bandera = 0
iuo_desglose = Create uo_ds_desglose
iuo_desglose.Dynamic of_init ("dw_co_fa_pedpasfac_desg")
iuo_desg_a_pasar = Create uo_ds_desglose
iuo_desg_a_pasar.Dynamic of_init ("dw_co_fa_pedpasfac_desg")
	
	DataWindowChild child_produc
	
	dw_1.SetTransObject(Sqlca)
	
	dw_2.SetTransObject(SQLCA)
	Dw_2.InsertRow(0)
	dw_2.setfocus()
	dw_2.SetColumn("texto")

	dw_3.insertrow(0)
	dw_3.getchild('pedido', pedido)
	pedido.settransobject(sqlca)
	if pedido.retrieve(str.g_financiero, str.empresa, w_fa_fondo.str_para.ano ) = 0 then pedido.insertrow(0)
	
//	dw_4.GetChild("fadpedid_dped_unidad_venta", idw_child_uni)
	idw_child_uni.setTransObject(sqlca)
	idw_child_uni.Retrieve()

	  SELECT Count (*)  
		 INTO :ll_recupero  
		 FROM ccmclien  
		WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
				( ccmclien.clie_empresa = :str.empresa )  ;
				
		if sqlca.sqlcode = -1 then
			mensaje("Información (ue_post_open)","Error al Seleccionar el conteo en ccmclien",sqlca.sqlerrtext)
			return 
		end if					
	
	If ll_recupero < 1 then
		idch_cliente.InsertRow(0)
	Else
		idch_cliente.Retrieve(str.g_financiero,str.empresa,w_fa_fondo.str_para.ano)
	End If
	
	pb_2.PictureName = str.path +"\art\ejecuta_pase.png"
	pb_2.Enabled = true
	str.frame.SetMicroHelp ("Seleccione una Linea y Precione la Tecla Enter para Cargar la Información" )

If w_fa_fondo.str_para.tiene_vta_detal = 1 then
	cb_pedi_sala.visible = false
else
	cb_pedi_sala.visible = false
end if

//Asigna el Pedido Disponible en la Secuencia
  SELECT faaparam.fara_ult_pedido  
    INTO :ls_pedido  
    FROM faaparam  
   WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
         ( faaparam.fara_empresa = :str.empresa )   ;
		if sqlca.sqlcode = -1 then
			mensaje("Información (ue_post_open)","Error al Seleccionar el ultimo pedido",sqlca.sqlerrtext)
			return 
		end if					

ls_pedido  = string(long(ls_pedido) + 1)

sle_pedido.text = ls_pedido 
dw_3.setitem(1,'pedido', ls_pedido)
ii_ann = year(date(gf_fecha_serv()))
em_ann.text = string(ii_ann)
em_ann_pedidos.text = string(ii_ann_pedidos)

end event

event open;//Override
//OpenWithParm(w_fa_man_clave_pedido, this)

//If is_user = "*" then
//	close(this)
//	Return
//END IF
this.y = 0
this.x = 805

st_nom_ventana.text = this.classname()
//gf_center_win(This)

this.triggerevent("ue_post_open")


end event

event close;//Override
Destroy iuo_desglose
Destroy iuo_desg_a_pasar

if isvalid(this) then close(this)
end event

event resize;//OVERRIDE


end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_pases_adicionales
integer x = 1431
integer y = 1060
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_pases_adicionales
boolean visible = false
integer x = 14
integer y = 1356
long backcolor = 74481808
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_pases_adicionales
event ue_down pbm_dwnkey
event ue_post ( )
integer x = 64
integer y = 220
integer width = 2802
integer height = 688
integer taborder = 150
string dataobject = "dw_pase_proforma_proforma"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

event dw_1::ue_down;call super::ue_down;//Si el Usuario Dio Enter

//If key = KeyUpArrow! Or Key = KeyDownArrow! Then 
//
//	This.Postevent("r")
//	return(2)
//	
//ElseIf key = KeyUpArrow! Then
//This.ScrollPriorRow ( ) 
//
//ElseIf key = KeyDownArrow! Then
//This.ScrollNextRow ( ) 	
	
//End If	



end event

event dw_1::doubleclicked;call super::doubleclicked;//This.Postevent("ue_entercol")
end event

event dw_1::rowfocuschanged;////Recupera los datos del detalle haciendo referencia al encabezado
////JORGE HERRERA 11/03/1998
//String ls_prof
//Integer li_ano, li_rows
//
//this.SelectRow(0,FALSE)
//this.SelectRow(currentrow,TRUE)
//
//li_rows = this.RowCount()
//If this.RowCount() < 1 Or currentrow = 0 then return
//If currentrow = this.GetRow() Then
//	ls_prof = GetitemString(currentrow ,"fatpedid_pedi_no_pedido")
//	li_ano =  GetitemNumber(currentrow ,"fatpedid_pedi_ann")
//	parent.SetRedraw(False)
//	dw_3.Retrieve(str.g_financiero,str.empresa,ls_prof,li_ano)
//	wf_cant_apasar()
//	parent.SetRedraw(true)
//End IF
//
//
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_pases_adicionales
integer x = 18
integer y = 160
integer width = 2862
integer height = 780
integer taborder = 0
long textcolor = 8388608
long backcolor = 12639424
string text = "Encabezado"
end type

type gb_3 from groupbox within w_pases_adicionales
integer x = 2441
integer y = 1096
integer width = 416
integer height = 300
integer taborder = 190
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "PASAR"
end type

type rb_1 from radiobutton within w_pases_adicionales
event clicked pbm_bnclicked
boolean visible = false
integer x = 1175
integer y = 1184
integer width = 320
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Cliente"
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()

end event

type rb_2 from radiobutton within w_pases_adicionales
event clicked pbm_bnclicked
boolean visible = false
integer x = 1257
integer y = 1180
integer width = 219
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "R.U.C."
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()

end event

type dw_2 from datawindow within w_pases_adicionales
event editchanged pbm_dwnchanging
integer x = 1445
integer y = 1232
integer width = 832
integer height = 96
integer taborder = 130
boolean bringtotop = true
string dataobject = "dw_texto"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event editchanged;String ls_letra,formato,ls_setting,ls_estado
This.accepttext()
ls_letra =This.getitemstring(1,1) 



If Match (data, "%") = True Then Return
If ls_letra = "Texto" Then Return


IF rb_1.Checked = True THEN /*Cliente*/
	Formato =  "String("  + "dgmterce_terc_descripcion)"  + "like "   + "'" + data +"%" + "'"

ELSEIF rb_2.Checked = True THEN /*Ruc*/
	
	Formato =  "fatprofo_prof_ruc_cliente like " +"'"+data+"%"+"'"
ELSEIF rb_3.Checked = True THEN /*A Nombre*/
	Formato =  "fatprofo_prof_a_nombre like " +"'"+data+"%"+"'"
	
ELSEIF rb_4.Checked = True THEN /*Pedido*/
	Formato =  "fatpedid_pedi_no_pedido like " +"'"+data+"%"+"'"

ELSEIF rb_5.Checked = True THEN /*Estado*/
		
	Formato =  "fatpedid_pedi_estado  like " +"'"+data+"%"+"'"

ELSEIF rb_6.Checked = True THEN /*Fecha*/
	Formato =  " date(fatpedid_pedi_fecha) Between " + &
	                  "Date(" + "'" + em_1.text + "'" + ")" + " And " + & 
					"Date("+ "'" +em_2.text +"'"+")"

ELSEIF rb_7.Checked = True THEN /*Vendedor*/
	Formato =  "fatpedid_pedi_a_nombre like " +"'"+data+"%"+"'"


ELSE /*Proforma*/
	Formato =  "String("  + "fatpedid_pedi_no_pedido)"  + "like "  +"'"+data+"%"+"'"
END IF

If Formato <> "" Then
	dw_1.SetFilter(Formato)
	dw_1.Filter()

End If
end event

type rb_4 from radiobutton within w_pases_adicionales
integer x = 146
integer y = 1244
integer width = 315
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Pedido"
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()

end event

type rb_5 from radiobutton within w_pases_adicionales
boolean visible = false
integer x = 59
integer y = 1244
integer width = 247
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 74481808
string text = "Estado"
boolean checked = true
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()
end event

type rb_6 from radiobutton within w_pases_adicionales
boolean visible = false
integer x = 1111
integer y = 1248
integer width = 247
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 74481808
string text = "Fecha"
boolean lefttext = true
end type

event clicked;wf_fecha()
end event

type pb_1 from picturebutton within w_pases_adicionales
event clicked pbm_bnclicked
boolean visible = false
integer x = 2249
integer y = 1232
integer width = 101
integer height = 88
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "\art\blind.bmp"
end type

event clicked;If em_1.text <> "" And em_2.text <> "" Then
	dw_2.Triggerevent("editchanged")
else
	Messagebox("Alto","Es Requerida Una fecha para Realizar la Busqueda",StopSign!)
End If	
end event

type em_1 from editmask within w_pases_adicionales
boolean visible = false
integer x = 1586
integer y = 1232
integer width = 283
integer height = 84
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
string displaydata = "~b"
end type

type em_2 from editmask within w_pases_adicionales
boolean visible = false
integer x = 1957
integer y = 1232
integer width = 283
integer height = 84
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
string displaydata = "~b"
end type

type st_2 from statictext within w_pases_adicionales
boolean visible = false
integer x = 1422
integer y = 1232
integer width = 160
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 77107328
boolean enabled = false
string text = "Entre"
alignment alignment = center!
long bordercolor = 77107328
boolean focusrectangle = false
end type

type st_3 from statictext within w_pases_adicionales
boolean visible = false
integer x = 1870
integer y = 1232
integer width = 87
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 77107328
boolean enabled = false
string text = "y"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_pases_adicionales
integer x = 2523
integer y = 1156
integer width = 256
integer height = 224
integer taborder = 200
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Sistemas\Hymsoft\Art\ejecuta_pase.png"
vtextalign vtextalign = multiline!
string powertiptext = "Ejecuta el Pase ..."
end type

event clicked;//ue_pase, llama a su vez a wf_efectuar_pase()
//sqlca.autocommit = false
parent.TriggerEvent("ue_pase")
sqlca.autocommit = true
end event

type rb_7 from radiobutton within w_pases_adicionales
boolean visible = false
integer x = 942
integer y = 1248
integer width = 215
integer height = 76
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 74481808
string text = "Fecha"
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()

end event

type gb_2 from groupbox within w_pases_adicionales
integer x = 18
integer y = 1176
integer width = 2363
integer height = 168
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "Busquedas"
end type

type rb_3 from radiobutton within w_pases_adicionales
event clicked pbm_bnclicked
integer x = 667
integer y = 1244
integer width = 411
integer height = 76
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "A Nombre de "
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()

end event

type cb_1 from commandbutton within w_pases_adicionales
boolean visible = false
integer x = 1682
integer y = 1348
integer width = 247
integer height = 68
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;MessageBox ('DATA',iuo_desg_a_pasar.Describe ('DataWindow.Data'))
end event

type cb_2 from commandbutton within w_pases_adicionales
boolean visible = false
integer x = 2181
integer y = 1348
integer width = 247
integer height = 68
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;MessageBox ('DATA',iuo_desglose.Describe ('DataWindow.Data'))
end event

type cb_pedi_sala from commandbutton within w_pases_adicionales
boolean visible = false
integer x = 1920
integer y = 1064
integer width = 462
integer height = 108
integer taborder = 160
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ped. Sala Venta"
end type

event clicked;
//Opensheet(w_fa_co_pedidos_sala_vta,str.frame,9,Original!)

end event

type sle_pedido from singlelineedit within w_pases_adicionales
boolean visible = false
integer x = 773
integer y = 972
integer width = 366
integer height = 68
integer taborder = 170
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_pases_adicionales
integer x = 37
integer y = 956
integer width = 283
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "Proforma:"
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_pases_adicionales
integer x = 302
integer y = 16
integer width = 1010
integer height = 472
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
boolean autohscroll = true
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Proforma a Proforma","Factura a Factura"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;cbx_pendiente.visible = FALSE
ii_index = index
CHOOSE case index 
	case 1 //proforma a proforma
		dw_1.dataobject = 'dw_pase_proforma_proforma'
		st_1.text = 'Proforma:'
		rb_4.text = 'Proforma:'
		dw_3.dataobject = 'dw_fa_ext_profo'
		cb_pedi_sala.visible = false
		cbx_pendiente.visible = true		
	case 2// factura a factura	
		dw_1.dataobject = 'dw_fa_factura_factura'
		dw_3.dataobject = 'dw_fa_ext_factura'
		st_1.text = 'Factura:'
		rb_4.text = 'Factura'
		cb_pedi_sala.visible = false
		
END CHOOSE		
dw_1.settransobject(sqlca)
dw_1.retrieve(str.g_financiero, str.empresa)
dw_3.insertrow(0)

dw_3.getchild('pedido', pedido)

pedido.settransobject(sqlca)
if pedido.retrieve(str.g_financiero, str.empresa, ii_ann ) = 0 then pedido.insertrow(0)
end event

type st_4 from statictext within w_pases_adicionales
integer x = 27
integer y = 24
integer width = 256
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "Pase de :"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_pases_adicionales
event ue_down pbm_dwnkey
integer x = 343
integer y = 948
integer width = 457
integer height = 100
integer taborder = 180
boolean bringtotop = true
string title = "none"
string dataobject = "dw_fa_ext_profo"
boolean border = false
boolean livescroll = true
end type

event ue_down;//Si el Usuario Dio Enter

If key = KeyUpArrow! Or Key = KeyDownArrow! Then 

	This.Postevent("r")
	return(2)
	
ElseIf key = KeyUpArrow! Then
 This.ScrollPriorRow ( ) 

ElseIf key = KeyDownArrow! Then
 This.ScrollNextRow ( ) 	
elseif key = KeyEnter! then
	pb_2.setfocus()	
End If	



end event

event itemchanged;this.accepttext()
ii_bandera = 1
end event

event editchanged;string ls_valor, formato, ls_letra, ls_setting,ls_estado
long li_pos3
This.accepttext()
ls_letra =data

If Match (data, "%") = True Then Return
If len(ls_letra) = 0 Then Return

Formato =  "String("  + "no_pedido)"  + "like "  +"'"+data+"%"+"'"
pedido.setfilter(formato)
pedido.filter()
IF pedido.rowcount() > 0 THEN
   
else
	pedido.setfilter("")
	pedido.filter()
	if pedido.retrieve(str.g_financiero, str.empresa, w_fa_fondo.str_para.ano ) = 0 then pedido.insertrow(0)
	messagebox('Aviso', 'Este número de '+st_1.text+' No existe...Verifique')
	this.setitem(1,1,'')
	return
end if	

end event

event losefocus;string ls_valor, formato, ls_letra, ls_setting,ls_estado
long li_pos3
This.accepttext()
ls_letra = dw_3.getitemstring(1,'pedido')
Formato =  "String("  + "no_pedido)"  + "like "  +"'"+ls_letra+"'"
pedido.setfilter(formato)
pedido.filter()
IF pedido.rowcount() > 0 THEN
   
else
	pedido.setfilter("")
	pedido.filter()
	if pedido.retrieve(str.g_financiero, str.empresa, w_fa_fondo.str_para.ano ) = 0 then pedido.insertrow(0)
	messagebox('Aviso', 'Este número de '+st_1.text+' No existe...Verifique')
	this.setitem(1,1,'')
	return
end if	

end event

type cbx_pendiente from checkbox within w_pases_adicionales
boolean visible = false
integer x = 1481
integer y = 968
integer width = 855
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Pasar solamente lo pendiente"
end type

type st_5 from statictext within w_pases_adicionales
integer x = 841
integer y = 956
integer width = 165
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "Año: "
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_ann from editmask within w_pases_adicionales
integer x = 1029
integer y = 952
integer width = 270
integer height = 92
integer taborder = 190
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###0"
boolean spin = true
double increment = 1
end type

event modified;ii_ann = integer(em_ann.text)
pedido.retrieve(str.g_financiero, str.empresa, ii_ann)
end event

type st_6 from statictext within w_pases_adicionales
boolean visible = false
integer x = 1449
integer y = 28
integer width = 165
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "Año: "
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_ann_pedidos from editmask within w_pases_adicionales
boolean visible = false
integer x = 1632
integer y = 16
integer width = 270
integer height = 92
integer taborder = 200
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###0"
boolean spin = true
double increment = 1
end type

event modified;ii_ann_pedidos = integer(em_ann_pedidos.text)
pedido.retrieve(str.g_financiero, str.empresa, ii_ann)
end event

