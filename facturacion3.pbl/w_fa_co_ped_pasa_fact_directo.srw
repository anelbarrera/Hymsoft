//objectcomments Ventana de PAse de Pedido a Factura
forward
global type w_fa_co_ped_pasa_fact_directo from w_fa_padre_reportes
end type
type gb_3 from groupbox within w_fa_co_ped_pasa_fact_directo
end type
type rb_1 from radiobutton within w_fa_co_ped_pasa_fact_directo
end type
type rb_2 from radiobutton within w_fa_co_ped_pasa_fact_directo
end type
type dw_2 from datawindow within w_fa_co_ped_pasa_fact_directo
end type
type rb_4 from radiobutton within w_fa_co_ped_pasa_fact_directo
end type
type rb_5 from radiobutton within w_fa_co_ped_pasa_fact_directo
end type
type rb_6 from radiobutton within w_fa_co_ped_pasa_fact_directo
end type
type pb_1 from picturebutton within w_fa_co_ped_pasa_fact_directo
end type
type em_1 from editmask within w_fa_co_ped_pasa_fact_directo
end type
type em_2 from editmask within w_fa_co_ped_pasa_fact_directo
end type
type st_2 from statictext within w_fa_co_ped_pasa_fact_directo
end type
type st_3 from statictext within w_fa_co_ped_pasa_fact_directo
end type
type pb_2 from picturebutton within w_fa_co_ped_pasa_fact_directo
end type
type dw_5 from datawindow within w_fa_co_ped_pasa_fact_directo
end type
type rb_7 from radiobutton within w_fa_co_ped_pasa_fact_directo
end type
type gb_2 from groupbox within w_fa_co_ped_pasa_fact_directo
end type
type rb_3 from radiobutton within w_fa_co_ped_pasa_fact_directo
end type
type cb_1 from commandbutton within w_fa_co_ped_pasa_fact_directo
end type
type cb_2 from commandbutton within w_fa_co_ped_pasa_fact_directo
end type
type cb_pedi_sala from commandbutton within w_fa_co_ped_pasa_fact_directo
end type
type sle_pedido from singlelineedit within w_fa_co_ped_pasa_fact_directo
end type
type st_1 from statictext within w_fa_co_ped_pasa_fact_directo
end type
end forward

global type w_fa_co_ped_pasa_fact_directo from w_fa_padre_reportes
integer x = 503
integer y = 400
integer width = 2921
integer height = 1528
string title = " Pase de Pedidos Reservados a Facturas"
string menuname = ""
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 77107328
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
dw_5 dw_5
rb_7 rb_7
gb_2 gb_2
rb_3 rb_3
cb_1 cb_1
cb_2 cb_2
cb_pedi_sala cb_pedi_sala
sle_pedido sle_pedido
st_1 st_1
end type
global w_fa_co_ped_pasa_fact_directo w_fa_co_ped_pasa_fact_directo

type variables
Datawindow idw_cual
Datawindowchild idw_child_uni , idch_cliente
integer ii_clicked, ii_cont = 0, ii_cualevent = 1, ii_ultgetrow, &
            ii_escpri = 1
long il_LastClickedRow, il_arrayrows[], il_cantidad
Double id_fraccion

boolean ib_action_on_buttonup, ib_tipoclicked = false, ib_flag = false
string is_user

//str_desglose	istr_parm
uo_ds_desglose	iuo_desglose, iuo_desg_a_pasar
end variables

forward prototypes
public subroutine wf_fecha ()
public subroutine wf_nofecha ()
public subroutine wf_botones ()
public subroutine wf_setear_user (string as_user)
public function string wf_verificar (string ls_original)
public subroutine wf_ds_retrieve ()
public function string wf_armar_sql (string ls_vienede)
public subroutine wf_efectuar_pase ()
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

public subroutine wf_efectuar_pase ();long    ll_ann, ll_linea, ll_ann_encabezado, ll_ann_det, ll_fraccion, ll_bulto_ini, ll_bulto_fin, ll_index,&
		  ll_bultos, ll_linea_det, ll_ultima_linea, ll_ultimo_index
integer li_existe, i, li_pais, li_i, li_ann_car, li_pedido_vta_diaria,li_vendedor
string  ls_pedido, ls_tipo, ls_pedido_encabezado, ls_pedido_det, ls_error, ls_uni_venta,&
		  ls_uni_prod, ls_codigo_item, ls_descrip, ls_uni_peso, ls_bodega, ls_ubicacion, ls_usuario,&
		  ls_supervisor, ls_pedi_car,ls_pedi,ls_destino, ls_origen
datetime ldt_fecha_serv, ldt_fecha
double	ld_pasada, ld_cantidad, ld_cubicaje, ld_peso, ld_precio_ma, ld_precio_me, ld_costo_fob,&
			ld_costo_cif, ld_precio, ld_monto_total, ld_por_descuento, ld_monto_final, ld_precio_original, &
			ld_costo_total
decimal	ld_precio_descuento, ld_descuento_ncr
boolean lb_entro
sqlca.autocommit = false

ldt_fecha_serv = gf_fecha_serv()

dw_1.setfilter("incluir = 1")
dw_1.filter()

if dw_1.rowcount() = 0 then
	gf_mensaje("","Debe seleccionar un pedido a pasar...",1,1,"E")
	dw_1.setfilter('')
	dw_1.filter()
	sqlca.autocommit = true
	return
end if

ll_ann    = w_fa_fondo.str_para.ano
//Si se desea pasar a factura con el mismo numero del pedido
if w_fa_fondo.str_para.pasar_mismo_numero = 1 then //Param tex = El Mismo #
	ls_pedido     = dw_1.getitemstring(1,"fatpedid_pedi_no_pedido")
	ls_tipo	 = dw_1.getitemstring(1,"fatpedid_pedi_tipo")
	sle_pedido.text = ls_pedido
	gf_fa_busqueda_secfad(sle_pedido.text, ls_tipo)
else
	ls_pedido = sle_pedido.text
end if	

if ls_pedido = '' then
	gf_mensaje("","Debe asignar el numero del pedido...",1,1,"E")
	dw_1.setfilter('')
	dw_1.filter()
	sqlca.autocommit = true
	return
end if

//Recorre los pedidos seleccionados, para identificar si alguno es de ventas diarias
for li_i = 1 to dw_1.rowcount()
	if dw_1.getitemnumber(li_i,'pedi_pedido_vta_diaria') = 1 then
		li_pedido_vta_diaria = 1
		exit //para que salga del ciclo
	end if
next

ls_tipo	 				= dw_1.getitemstring(1,"fatpedid_pedi_tipo")
ls_pedido_encabezado = dw_1.getitemstring(1,"fatpedid_pedi_no_pedido")
ll_ann_encabezado    = dw_1.getitemNumber(1,"fatpedid_pedi_ann")

  SELECT count(*)  
    INTO :li_existe  
    FROM fatdiari  
   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
         ( fatdiari.fact_empresa = :str.empresa ) AND  
         ( fatdiari.fact_tipo = :ls_tipo ) AND  
         ( fatdiari.fact_no_pedido = :ls_pedido ) AND  
         ( fatdiari.fact_ann = :ll_ann ); 
		if sqlca.sqlcode = -1 then
			mensaje('Aviso','Error al Validar Existencia en Fatdiari',sqlca.sqlerrtext)
			dw_1.setfilter('')
			dw_1.filter()			
			sqlca.autocommit = true
			return
		end if

	if li_existe > 0 then
		mensaje('Aviso','El numero del Pedido ya existe..','')
		if w_fa_fondo.str_para.pasar_mismo_numero = 1 then 		
			if gf_mensaje('','Desea Utilizar el # que Proporciono el Sistema ?',2,1,'Q') = 2 then
				dw_1.setfilter('')				
				dw_1.filter()		
				sqlca.autocommit = true		
				return				
			end if
			//SI YA EXISTIA, TOMA EL NUMERO INCREMENTADO DEL SLE_PEDIDO
			ls_pedido = sle_pedido.text			
		else			
			dw_1.setfilter('')
			dw_1.filter()		
			sqlca.autocommit = true				
			return
		end if
	end if

if gf_mensaje('',' ¿ Está Seguro de Ejecutar el Pase ?',2,1,'E') = 2 then	
	dw_1.setfilter('')
	dw_1.filter()	
	sqlca.autocommit = true	
	return
end if

/*INSERTANDO EL ENCABEZADO DEL PEDIDO*/
	 INSERT INTO fatdiari  
			( fact_g_financiero,   
			  fact_empresa,   
			  fact_tipo,   
			  fact_no_pedido,   
			  fact_ann,   
			  fact_no_factura,   
			  fact_cliente,   
			  fact_ruc_cliente,   
			  fact_condicion_pago,   
			  fact_tipo_venta,   
			  fact_tipo_movimiento,   
			  fact_no_traspaso,   
			  fact_fecha,   
			  fact_fecha_creacion,   
			  fact_fecha_modificacion,   
			  fact_dias_pago,   
			  fact_fecha_fin_plazo,   
			  fact_fecha_cancelado,   
			  fact_consignado,   
			  fact_a_nombre,   
			  fact_a_nombre_direccion,   
			  fact_despachado,   
			  fact_via,   
			  fact_con_emb_no,   
			  fact_marca,   
			  fact_bultos_total,   
			  fact_cubicaje_total,   
			  fact_peso_total,   
			  fact_unidad_peso,   
			  fact_gastos_total,   
			  fact_monto_fact_total,   
			  fact_descuento_subt_deta,   
			  fact_por_descuento,   
			  fact_supervisor,   
			  fact_monto_final,   
			  fact_comentario,   
			  fact_estado ,  
			  fact_act_cliente,   
			  fact_act_inventario,   
			  fact_act_conta,   
			  fact_cerrada,   
			  fact_referencia_fac,   
			  fact_monto_abonado,   
			  fact_fecha_act_conta,
			  fact_pedido_original,
			  fact_autorizacion,
			  fact_viene_de_pedido,			  
			  fact_actualizo_cargos,
			  fact_actualizo_vendedor,
			  fact_factura_de_bodega,
			  fact_cuatro_decimales,
			  fact_usuario,
			  fact_precio_a_utilizar,
			  fact_costos_total,
			  fact_viene_de_ventas_diarias,
			  fact_guia,
			  fact_destino, 
	         fact_ncr_descuento,   
	         fact_descuento_ncr,
			fact_origen_venta) 
	SELECT  :str.g_financiero,   
           :str.empresa,   
           :ls_tipo,   
           :ls_pedido,   
           :ll_ann,   
			  '0',
           fatpedid.pedi_cliente,   
           fatpedid.pedi_ruc_cliente,   
           fatpedid.pedi_condicion_pago,   
           fatpedid.pedi_tipo_venta,   
           fatpedid.pedi_tipo_movimiento,   
           fatpedid.pedi_no_traspaso,   
           fatpedid.pedi_fecha,   
           fatpedid.pedi_fecha_creacion,   
           fatpedid.pedi_fecha_modificacion,   
           fatpedid.pedi_dias_pago,   
			  isnull(fatpedid.pedi_fecha_fin_plazo,:ldt_fecha_serv),
			  null,			  
           fatpedid.pedi_consignado,   
           fatpedid.pedi_a_nombre,   
           fatpedid.pedi_a_nombre_direccion,   
           fatpedid.pedi_despachado,   
           fatpedid.pedi_via,   
           fatpedid.pedi_con_emb_no,   
           fatpedid.pedi_marca,   
           fatpedid.pedi_bultos_total,   
           fatpedid.pedi_cubicaje_total,   
           fatpedid.pedi_peso_total,   
           fatpedid.pedi_unidad_peso,   
           fatpedid.pedi_gastos_total,   
           fatpedid.pedi_monto_total,   
           fatpedid.pedi_descu_subt_deta,   
           fatpedid.pedi_por_descuento,   
           fatpedid.pedi_supervisor,   
           fatpedid.pedi_monto_final,   
           fatpedid.pedi_comentario,   
           'A',   
			  0,
			  0,
			  0,
			  0,
			  '',
			  0,
			  null,
			  :ls_pedido_encabezado,
			  fatpedid.pedi_autorizacion,
			  1 , //para que no reserve en el insert en la factura, ya que en pedidos reservo
			  'S',
			  'S',
			  fatpedid.pedi_factura_de_bodega,
			  fatpedid.pedi_cuatro_decimales,
			  :str.usuario,
			  fatpedid.pedi_precio_a_utilizar,
			  fatpedid.pedi_costos_total,
			  :li_pedido_vta_diaria,
			  fatpedid.pedi_guia,
			  fatpedid.pedi_destino,
	         fatpedid.pedi_ncr_descuento,   
	         fatpedid.pedi_descuento_ncr,
			fatpedid.pedi_origen_venta	
           from  fatpedid
			 where fatpedid.pedi_g_financiero = :str.g_financiero and
			 		 fatpedid.pedi_empresa		 = :str.empresa and
					 fatpedid.pedi_no_pedido	 = :ls_pedido_encabezado and
					 fatpedid.pedi_ann			 = :ll_ann_encabezado ;
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al Insertar el Encabezado en Fatdiari',ls_error)					
					sqlca.autocommit = true					
					return
				end if

/*INSERTANDO EL ENCABEZADO DEL PEDIDO*/

/*INSERTANDO LOS CARGOS DEL PEDIDO, SOLO SI SELECCIONO UN PEDIDO*/
if dw_1.rowcount() = 1 then
	  INSERT INTO fadcargo  
         ( dcar_g_financiero,   
           dcar_empresa,   
           dcar_tipo,   
           dcar_no_pedido,   
           dcar_ann,   
           dcar_codigo,   
           dcar_monto )  
     SELECT :str.g_financiero,   
            :str.empresa,   
            :ls_tipo,   
            :ls_pedido,   				
            :ll_ann,   
            fadpecar.peca_codigo_cargo,   
            fadpecar.peca_monto  
       FROM fadpecar  
      WHERE ( fadpecar.peca_g_financiero = :str.g_financiero  ) AND  
            ( fadpecar.peca_empresa = :str.empresa  ) AND  
            ( fadpecar.peca_no_pedido = :ls_pedido_encabezado ) AND  
            ( fadpecar.peca_ann = :ll_ann_encabezado )   ;
				
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al Insertar los cargos',ls_error)					
					sqlca.autocommit = true
					return
				end if

end if //Del rowcount() = 1

/* Para cuando se deben pasar mas de un pedidos con cargos */
if dw_1.rowcount() > 1 then
	  for li_i = 1 to dw_1.rowcount()
		if dw_1.getitemstring(li_i,"cargos") = 'SI' then 
			ls_pedi_car = dw_1.getitemstring(li_i,"fatpedid_pedi_no_pedido")
			li_ann_car  = dw_1.getitemNumber(li_i,"fatpedid_pedi_ann")
			li_i = dw_1.rowcount() + 1 
		end if
	  next
	  if li_ann_car > 0 then 
	  INSERT INTO fadcargo  
         ( dcar_g_financiero,   
           dcar_empresa,   
           dcar_tipo,   
           dcar_no_pedido,   
           dcar_ann,   
           dcar_codigo,   
           dcar_monto )  
     SELECT :str.g_financiero,   
            :str.empresa,   
            :ls_tipo,   
            :ls_pedido,   				
            :ll_ann,   
            fadpecar.peca_codigo_cargo,   
            fadpecar.peca_monto  
       FROM fadpecar  
      WHERE ( fadpecar.peca_g_financiero = :str.g_financiero  ) AND  
            ( fadpecar.peca_empresa = :str.empresa  ) AND  
            ( fadpecar.peca_no_pedido = :ls_pedi_car ) AND  
            ( fadpecar.peca_ann = :li_ann_car )   ;
				
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al Insertar los cargos',ls_error)					
					sqlca.autocommit = true
					return
				end if
		end if

end if //Del rowcount() = 2 para cargos de pedidos





/*INSERTANDO LOS VENDEDORES DEL PEDIDO*/				
	 INSERT INTO fadvenfa  
		( vfac_g_financiero,   
		  vfac_empresa,   
		  vfac_tipo,   
		  vfac_no_pedido,   
		  vfac_ann,   
		  vfac_vendedor )  
  SELECT :str.g_financiero,   
			:str.empresa,   
			:ls_tipo,   
			:ls_pedido,   
			:ll_ann,   
			fadvenpe.vped_vendedor  
	 FROM fadvenpe  
	WHERE ( fadvenpe.vped_g_financiero = :str.g_financiero ) AND  
			( fadvenpe.vped_empresa = :str.empresa ) AND  
			( fadvenpe.vped_no_pedido = :ls_pedido_encabezado ) AND  
			( fadvenpe.vped_ann = :ll_ann_encabezado )    ;

		If sqlca.sqlcode = -1 then
			ls_error =sqlca.sqlerrtext
			rollback using sqlca;
			mensaje("Atención ","Error al Insertar los Vendedores "+ls_error,"")
			sqlca.autocommit = true
		  return
		end if

/*INSERTANDO EL DETALLE DE EL O LOS PEDIDOS*/
lb_entro = false

for i = 1 to dw_1.rowcount()
	ls_pedido_det = dw_1.getitemString(i,"fatpedid_pedi_no_pedido")	
	ll_ann_det	  = dw_1.getitemnumber(i,'fatpedid_pedi_ann')
	
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
					case fadpedid.dped_precio_original when null then fadpedid.dped_precio_unidad_producto when 0 then fadpedid.dped_precio_unidad_producto else fadpedid.dped_precio_original end,   
					fadpedid.dped_linea,   
					fadpedid.dped_index,
					fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion pasada ,
					fadpedid.dped_costo_total,dped_precio_descuento,dped_descuento_ncr,
					fadpedid.dped_vendedor
			 FROM fadpedid, 
			 		inamedid
			 Where fadpedid.dped_g_financiero = :str.g_financiero and
					 fadpedid.dped_empresa      = :str.empresa and
					 fadpedid.dped_no_pedido	 = :ls_pedido_det and					 
					 fadpedid.dped_ann			 = :ll_ann_det and
					 (fadpedid.dped_unidad_venta = inamedid.medi_medida ) and
					 fadpedid.dped_pasada 		  < fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion
		ORDER BY fadpedid.dped_linea ASC  ;		
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al declarar el cursor',ls_error)					
					sqlca.autocommit = true
					return
				end if	
		 
		open cur_pedidos;
		
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje('Aviso','Error al abrir el cursor',ls_error)	
				sqlca.autocommit = true
				return
			end if			

		
		fetch cur_pedidos into :ls_codigo_item, :ls_descrip, :ld_cubicaje, :ld_peso, :ls_uni_peso,&
									  :ls_uni_prod, :ld_precio_ma, :ld_precio_me, :ls_bodega, :ld_costo_fob,&
									  :ld_costo_cif, :ld_precio, :ls_uni_venta, :ld_cantidad, :ll_fraccion,&
									  :ld_monto_total, :ld_por_descuento, :ld_monto_final, :ls_usuario, :ls_supervisor,&
									  :ll_bultos, :ls_ubicacion, :ll_bulto_ini, :ll_bulto_fin, :ld_precio_original,&
									  :ll_linea, :ll_index, :ld_pasada , :ld_costo_total,:ld_precio_descuento,:ld_descuento_ncr, :li_vendedor;
		
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				close cur_pedidos;				
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
		if i > 1 then
			ll_ultima_linea ++
			ll_ultimo_index ++
		else
			ll_ultima_linea = ll_linea
			ll_ultimo_index = ll_index
		end if

		  if isnull(ld_cubicaje) then ld_cubicaje = 0
		  if isnull(ld_peso) then ld_peso = 0
		  if ld_cubicaje = 0 and not lb_entro then
				gf_mensaje('','Existen Referencias sin Cubicaje Asignado, Verifique !!!',1,1,'E')
				lb_entro = true
		  end if
		  if ld_peso = 0 and not lb_entro then
				gf_mensaje('','Existen Referencias sin Peso Asignado, Verifique !!!',1,1,'E')
				lb_entro = true
		  end if
		
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
					  facd_precio_descuento,
					  facd_descuento_ncr,
					  facd_vendedor)
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
						  1, //ya no se toma en cuenta en el trigger
						  :ll_bulto_ini,
						  :ll_bulto_fin,
						  :ld_precio_original,
						  :ld_costo_total,
						  :ld_precio_descuento,
						  :ld_descuento_ncr,
						  :li_vendedor) ;						  
						  
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					close cur_pedidos;					
					mensaje('Aviso','Error al Insertar el Detalle en Faddiari',ls_error)					
					sqlca.autocommit = true
					return
				end if					
			
						//UPDATE DE LAS CANTIDADES PASADAS, EN PEDIDOS
						  UPDATE fadpedid  
							  SET dped_pasada = :ld_pasada  
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
							sqlca.autocommit = true
							return
						end if																																
			
			
		fetch cur_pedidos into :ls_codigo_item, :ls_descrip, :ld_cubicaje, :ld_peso, :ls_uni_peso,&
									  :ls_uni_prod, :ld_precio_ma, :ld_precio_me, :ls_bodega, :ld_costo_fob,&
									  :ld_costo_cif, :ld_precio, :ls_uni_venta, :ld_cantidad, :ll_fraccion,&
									  :ld_monto_total, :ld_por_descuento, :ld_monto_final, :ls_usuario, :ls_supervisor,&
									  :ll_bultos, :ls_ubicacion, :ll_bulto_ini, :ll_bulto_fin, :ld_precio_original,&
									  :ll_linea, :ll_index, :ld_pasada , :ld_costo_total,:ld_precio_descuento,:ld_descuento_ncr,:li_vendedor;
		
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_pedidos;
							mensaje('Aviso','Error en el Fetch del cursor',ls_error)	
							sqlca.autocommit = true
							return
						end if								
						
						ll_linea_det = ll_linea
						//Para tomar la linea del detalle, y actualizar la cantidad pasada												
		loop  //Del ciclo del Cursor
	

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
							sqlca.autocommit = true
							return
						end if								

	
Next //Del Ciclo for de los pedidos a pasar

close cur_pedidos; //cierra el cursor

/*CALCULA TOTALES*/
/*SEGMENTO AGREGADO POR HGN/22/11/02*/
long   ll_tot_bultos
Decimal  ld_tot_peso, ld_tot_cubicaje,ld_tot_montotot,ld_fact_costo_total

SELECT sum(faddiari.facd_bultos),   
	 	 sum(faddiari.facd_peso),   
		 sum(faddiari.facd_cubicaje),   
		 sum(faddiari.facd_monto_total),   
 		 sum(faddiari.facd_costo_total),  
 		 sum(faddiari.facd_descuento_ncr) 
 INTO :ll_tot_bultos,   
		:ld_tot_peso,   
		:ld_tot_cubicaje,
		:ld_tot_montotot,
		:ld_fact_costo_total,
		:ld_descuento_ncr
 FROM faddiari  
WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
		( faddiari.facd_empresa 	= :str.empresa ) AND  
		( faddiari.facd_no_pedido	=  :ls_pedido  ) AND  
		( faddiari.facd_tipo			= :ls_tipo ) AND
		( faddiari.facd_ann = :ll_ann ) ;

	If sqlca.sqlcode = -1 then
		ls_error =sqlca.sqlerrtext
		rollback using sqlca;
		mensaje("Ateción","Error al actualizar los totales en faddiari "+ls_error,"")
		return
	End If

if IsNull(ld_descuento_ncr) then ld_descuento_ncr=0
If IsNull(ld_tot_montotot) then 	ld_tot_montotot = 0

//Actualiza el encabezado del pedido en las facturas para que rebaje e inserte en la reserva correctamente
		
  UPDATE fatdiari  
     SET fact_peso_total 		= :ld_tot_peso,   
         fact_cubicaje_total 	= :ld_tot_cubicaje,   
         fact_bultos_total 	= :ll_tot_bultos,   
         fact_monto_fact_total =:ld_tot_montotot,   
			fact_descuento_ncr	= :ld_descuento_ncr,
			fact_viene_de_pedido = 0 //Para que cuando entre en factura de productos, rebaje y reserve normalmente
   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
         ( fatdiari.fact_empresa 	= :str.empresa ) AND
         ( fatdiari.fact_no_pedido 	= :ls_pedido ) AND  
			( fatdiari.fact_tipo			= :ls_tipo ) AND
         ( fatdiari.fact_ann 			= :ll_ann ) ;

			If sqlca.sqlcode <> 0 then
				ls_error =sqlca.sqlerrtext
				rollback using sqlca;
			  	mensaje("Error","Error al actualizar viene de pedido de la factura "+ls_error,"")
				sqlca.autocommit = true  
			  	return
			End If
			
/*FIN SEGMENTO DEL 22/11/02 BY HGN*/

//Actualiza el encabezado del pedido en las facturas para que rebaje e inserte en la reserva correctamente
/*
  UPDATE fatdiari  
     SET fact_viene_de_pedido = 0 //Para que cuando entre en factura de productos, rebaje y reserve normalmente
   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
         ( fatdiari.fact_empresa 	= :str.empresa ) AND
         ( fatdiari.fact_no_pedido 	= :ls_pedido ) AND  
			( fatdiari.fact_tipo			= :ls_tipo ) AND
         ( fatdiari.fact_ann 			= :ll_ann ) ;

			If sqlca.sqlcode <> 0 then
				ls_error =sqlca.sqlerrtext
				rollback using sqlca;
			  	mensaje("Error","Error al actualizar viene de pedido de la factura "+ls_error,"")
				sqlca.autocommit = true  
			  	return
			End If
*/			

commit;

gf_mensaje('','Pase efectuado Satisfactoriamente',1,1,"E")
sle_pedido.text = '0'
dw_1.setfilter('')
dw_1.filter()
dw_5.triggerevent('itemchanged')

sqlca.autocommit = true


end subroutine

on w_fa_co_ped_pasa_fact_directo.create
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
this.dw_5=create dw_5
this.rb_7=create rb_7
this.gb_2=create gb_2
this.rb_3=create rb_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_pedi_sala=create cb_pedi_sala
this.sle_pedido=create sle_pedido
this.st_1=create st_1
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
this.Control[iCurrent+14]=this.dw_5
this.Control[iCurrent+15]=this.rb_7
this.Control[iCurrent+16]=this.gb_2
this.Control[iCurrent+17]=this.rb_3
this.Control[iCurrent+18]=this.cb_1
this.Control[iCurrent+19]=this.cb_2
this.Control[iCurrent+20]=this.cb_pedi_sala
this.Control[iCurrent+21]=this.sle_pedido
this.Control[iCurrent+22]=this.st_1
end on

on w_fa_co_ped_pasa_fact_directo.destroy
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
destroy(this.dw_5)
destroy(this.rb_7)
destroy(this.gb_2)
destroy(this.rb_3)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_pedi_sala)
destroy(this.sle_pedido)
destroy(this.st_1)
end on

event ue_post_open;//Override/*Jorge Herrera*///Fecha: 24/2/99
string ls_vienede, ls_where,ls_medact, ls_pedido
long ll_recupero

this.y = 1
this.x =1
	iuo_desglose = Create uo_ds_desglose
	iuo_desglose.Dynamic of_init ("dw_co_fa_pedpasfac_desg")

	iuo_desg_a_pasar = Create uo_ds_desglose
	iuo_desg_a_pasar.Dynamic of_init ("dw_co_fa_pedpasfac_desg")
	
	DataWindowChild child_produc

	if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 then
		DW_1.dataobject='dw_co_fa_pedapasar_directo_acisa' 
		DW_5.Modify("notercero.DDDW.Name=dw_pr_fa_pedidos_x_pasar_acisa")
	END IF
	
	dw_1.SetTransObject(Sqlca)
	
	dw_2.SetTransObject(SQLCA)
	Dw_2.InsertRow(0)
	dw_2.setfocus()
	dw_2.SetColumn("texto")
	
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
	
	dw_5.Accepttext()
	dw_5.GetChild("notercero",idch_cliente)
	
	idch_cliente.SetTransObject(Sqlca)
	
	If ll_recupero < 1 then
		idch_cliente.InsertRow(0)
	Else
		if idch_cliente.Retrieve(str.g_financiero,str.empresa) < 1 then idch_cliente.insertrow(0)
	End If


	dw_5.SetTransObject(Sqlca)
	
	dw_5.ScrollToRow(dw_5.InsertRow(0))
	dw_5.SetFocus()

	
	pb_2.PictureName = str.path +"\art\pasar_rp.bmp"
	pb_2.Enabled = false
	str.frame.SetMicroHelp ("Seleccione una Linea y Precione la Tecla Enter para Cargar la Información" )

//If w_fa_fondo.str_para.tiene_vta_detal = 1 then
//	cb_pedi_sala.visible = true
//else
	cb_pedi_sala.visible = false
//end if

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
//Si se desea pasar a pedidos con el mismo numero de la proforma
//if w_fa_fondo.str_para.pasar_mismo_numero = 1 then 
//	sle_pedido.text = '0' 
//else
	sle_pedido.text = ls_pedido 	
//end if


end event

event open;//Override
//OpenWithParm(w_fa_man_clave_pedido, this)
//
//If is_user = "*" then
//	close(this)
//	Return
//END IF

st_nom_ventana.text = this.classname()
this.triggerevent("ue_post_open")


end event

event close; ////Override


Window lw_frame

Destroy iuo_desglose
Destroy iuo_desg_a_pasar

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
 
end event

event resize;//OVERRIDE


end event

event closequery;constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)

This.SetRedraw(false)
end event

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_co_ped_pasa_fact_directo
boolean visible = false
integer x = 14
integer y = 1356
long backcolor = 74481808
end type

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_co_ped_pasa_fact_directo
integer x = 1431
integer y = 1060
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_co_ped_pasa_fact_directo
event ue_down pbm_dwnkey
event ue_post ( )
integer x = 59
integer y = 120
integer width = 2802
integer height = 904
integer taborder = 140
string dataobject = "dw_co_fa_pedapasar_directo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_co_ped_pasa_fact_directo
integer x = 23
integer y = 24
integer width = 2862
integer height = 1020
integer taborder = 0
long textcolor = 8388608
long backcolor = 74481808
string text = "Encabezado"
end type

type gb_3 from groupbox within w_fa_co_ped_pasa_fact_directo
integer x = 2414
integer y = 1096
integer width = 480
integer height = 300
integer taborder = 200
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 74481808
string text = "Ejecutar el Pase"
end type

type rb_1 from radiobutton within w_fa_co_ped_pasa_fact_directo
event clicked pbm_bnclicked
boolean visible = false
integer x = 1175
integer y = 1184
integer width = 320
integer height = 76
integer taborder = 30
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

type rb_2 from radiobutton within w_fa_co_ped_pasa_fact_directo
event clicked pbm_bnclicked
boolean visible = false
integer x = 1257
integer y = 1180
integer width = 219
integer height = 76
integer taborder = 40
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

type dw_2 from datawindow within w_fa_co_ped_pasa_fact_directo
event editchanged pbm_dwnchanging
integer x = 1445
integer y = 1232
integer width = 827
integer height = 84
integer taborder = 120
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


// Permite Modificar el estado Con la Finalidad de que Funcione el Filtrado
      ls_setting = dw_1.Describe("DataWindow.Retrieve.AsNeeded")
       If ls_setting = "yes" Then 
           dw_1.Modify("DataWindow.Retrieve.AsNeeded=No")	
       End If	

 

IF rb_1.Checked = True THEN /*Cliente*/
	Formato =  "String("  + "dgmterce_terc_descripcion)"  + "like "   + "'" + data +"%" + "'"

ELSEIF rb_2.Checked = True THEN /*Ruc*/
	
	Formato =  "fatpedid_pedi_ruc_cliente like " +"'"+data+"%"+"'"
ELSEIF rb_3.Checked = True THEN /*A Nombre*/
	Formato =  "fatpedid_pedi_a_nombre like " +"'"+data+"%"+"'"
	
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

type rb_4 from radiobutton within w_fa_co_ped_pasa_fact_directo
integer x = 169
integer y = 1244
integer width = 251
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 74481808
string text = "Pedido"
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()

end event

type rb_5 from radiobutton within w_fa_co_ped_pasa_fact_directo
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

type rb_6 from radiobutton within w_fa_co_ped_pasa_fact_directo
boolean visible = false
integer x = 1111
integer y = 1248
integer width = 247
integer height = 76
integer taborder = 60
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

type pb_1 from picturebutton within w_fa_co_ped_pasa_fact_directo
event clicked pbm_bnclicked
boolean visible = false
integer x = 2249
integer y = 1232
integer width = 101
integer height = 88
integer taborder = 130
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

type em_1 from editmask within w_fa_co_ped_pasa_fact_directo
boolean visible = false
integer x = 1586
integer y = 1232
integer width = 283
integer height = 84
integer taborder = 100
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

type em_2 from editmask within w_fa_co_ped_pasa_fact_directo
boolean visible = false
integer x = 1957
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

type st_2 from statictext within w_fa_co_ped_pasa_fact_directo
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

type st_3 from statictext within w_fa_co_ped_pasa_fact_directo
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

type pb_2 from picturebutton within w_fa_co_ped_pasa_fact_directo
integer x = 2542
integer y = 1164
integer width = 233
integer height = 208
integer taborder = 240
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\harr2000\art\pasar_rp.bmp"
vtextalign vtextalign = multiline!
end type

event clicked;//ue_pase, llama a su vez a wf_efectuar_pase()
//sqlca.autocommit = false
parent.TriggerEvent("ue_pase")
sqlca.autocommit = true
end event

type dw_5 from datawindow within w_fa_co_ped_pasa_fact_directo
event ue_key pbm_dwnkey
integer x = 46
integer y = 8
integer width = 1262
integer height = 96
integer taborder = 150
boolean bringtotop = true
string dataobject = "dw_dd_fa_clientes_pedidos"
boolean border = false
boolean livescroll = true
end type

event ue_key;long ll_clien

If Key = KeyF1! then
	  Open(w_fa_co_clien)
				ll_clien = Message.Doubleparm
				
				If IsNull(ll_clien) Then 
					Return
				Else
					This.SetItem(1,"notercero",ll_clien)			
				End If	
End IF
end event

event itemchanged;/*Jorge Herrera*/
//24/2/99

long ll_cliente

ll_cliente = idch_cliente.GetItemnumber(idch_cliente.GetRow(),"terc_tercero")

If dw_1.Retrieve(str.g_financiero,str.empresa,ll_cliente) < 1 then
	
	// Inicializando DataStore
	iuo_desg_a_pasar.Reset ()
	iuo_desglose.Reset ()
Else
	
	pb_2.PictureName = str.path +"\art\pasar_rp.bmp"
	pb_2.enabled = true
End IF
end event

type rb_7 from radiobutton within w_fa_co_ped_pasa_fact_directo
boolean visible = false
integer x = 942
integer y = 1248
integer width = 215
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

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()

end event

type gb_2 from groupbox within w_fa_co_ped_pasa_fact_directo
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
long backcolor = 79741120
string text = "Busquedas"
end type

type rb_3 from radiobutton within w_fa_co_ped_pasa_fact_directo
event clicked pbm_bnclicked
integer x = 667
integer y = 1244
integer width = 411
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 77107328
string text = "A Nombre de "
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()

end event

type cb_1 from commandbutton within w_fa_co_ped_pasa_fact_directo
boolean visible = false
integer x = 1682
integer y = 1348
integer width = 247
integer height = 68
integer taborder = 80
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

type cb_2 from commandbutton within w_fa_co_ped_pasa_fact_directo
boolean visible = false
integer x = 2181
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

event clicked;MessageBox ('DATA',iuo_desglose.Describe ('DataWindow.Data'))
end event

type cb_pedi_sala from commandbutton within w_fa_co_ped_pasa_fact_directo
boolean visible = false
integer x = 1920
integer y = 1064
integer width = 462
integer height = 108
integer taborder = 150
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ped. Sala Venta"
end type

event clicked;Opensheet(w_fa_co_pedidos_sala_vta,str.frame,9,Original!)

end event

type sle_pedido from singlelineedit within w_fa_co_ped_pasa_fact_directo
integer x = 343
integer y = 1080
integer width = 279
integer height = 68
integer taborder = 160
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

type st_1 from statictext within w_fa_co_ped_pasa_fact_directo
integer x = 96
integer y = 1088
integer width = 238
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
string text = "Pedido:"
alignment alignment = right!
boolean focusrectangle = false
end type

