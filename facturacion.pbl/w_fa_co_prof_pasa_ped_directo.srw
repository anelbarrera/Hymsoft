//objectcomments Ventana de PAse de Pedido a Factura
forward
global type w_fa_co_prof_pasa_ped_directo from w_fa_padre_reportes
end type
type gb_3 from groupbox within w_fa_co_prof_pasa_ped_directo
end type
type rb_1 from radiobutton within w_fa_co_prof_pasa_ped_directo
end type
type rb_2 from radiobutton within w_fa_co_prof_pasa_ped_directo
end type
type dw_2 from datawindow within w_fa_co_prof_pasa_ped_directo
end type
type rb_4 from radiobutton within w_fa_co_prof_pasa_ped_directo
end type
type rb_5 from radiobutton within w_fa_co_prof_pasa_ped_directo
end type
type rb_6 from radiobutton within w_fa_co_prof_pasa_ped_directo
end type
type pb_1 from picturebutton within w_fa_co_prof_pasa_ped_directo
end type
type em_1 from editmask within w_fa_co_prof_pasa_ped_directo
end type
type em_2 from editmask within w_fa_co_prof_pasa_ped_directo
end type
type st_2 from statictext within w_fa_co_prof_pasa_ped_directo
end type
type st_3 from statictext within w_fa_co_prof_pasa_ped_directo
end type
type pb_2 from picturebutton within w_fa_co_prof_pasa_ped_directo
end type
type dw_5 from datawindow within w_fa_co_prof_pasa_ped_directo
end type
type rb_7 from radiobutton within w_fa_co_prof_pasa_ped_directo
end type
type gb_2 from groupbox within w_fa_co_prof_pasa_ped_directo
end type
type rb_3 from radiobutton within w_fa_co_prof_pasa_ped_directo
end type
type cb_1 from commandbutton within w_fa_co_prof_pasa_ped_directo
end type
type cb_2 from commandbutton within w_fa_co_prof_pasa_ped_directo
end type
type cb_pedi_sala from commandbutton within w_fa_co_prof_pasa_ped_directo
end type
type sle_pedido from singlelineedit within w_fa_co_prof_pasa_ped_directo
end type
type st_1 from statictext within w_fa_co_prof_pasa_ped_directo
end type
end forward

global type w_fa_co_prof_pasa_ped_directo from w_fa_padre_reportes
integer x = 503
integer y = 400
integer width = 2921
integer height = 1528
string title = "(FA) Pase de Proformas a Pedidos"
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
global w_fa_co_prof_pasa_ped_directo w_fa_co_prof_pasa_ped_directo

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
public function boolean wf_calcula_disponible (string as_producto, ref long al_disponible, long al_pedido)
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
		  ll_bultos, ll_linea_det, ll_ultima_linea, ll_ultimo_index,ll_cargo, ll_convert, ll_disponible, ll_cant_a_pasar
integer li_existe, i, li_pais, li_vendedor
string  ls_proforma, ls_tipo, ls_proforma_encabezado, ls_proforma_det, ls_error, ls_uni_venta,&
		  ls_uni_prod, ls_codigo_item, ls_descrip, ls_uni_peso, ls_bodega, ls_ubicacion, ls_usuario,&
		  ls_supervisor,ls_errtext		  , ls_origen
datetime ldt_fecha_serv, ldt_fecha
double	ld_pasada, ld_cantidad, ld_cubicaje, ld_peso, ld_precio_ma, ld_precio_me, ld_costo_fob,&
			ld_costo_cif, ld_precio, ld_monto_total, ld_por_descuento, ld_monto_final, ld_precio_original, &
			ld_monto, ld_costo_total
			
sqlca.autocommit = false

ldt_fecha_serv = gf_fecha_serv()

dw_1.setfilter("incluir = 1")
dw_1.filter()

if dw_1.rowcount() = 0 then
	gf_mensaje("","Debe seleccionar una proforma a pasar...",1,1,"E")
	dw_1.setfilter('')
	dw_1.filter()
	sqlca.autocommit = true
	return
end if

ll_ann    = Long(Year(Date(gf_fecha_serv())))
//Si se desea pasar a pedidos con el mismo numero de la proforma
//if w_fa_fondo.str_para.pasar_mismo_numero = 1 then 
//	ls_proforma     = dw_1.getitemstring(1,"fatprofo_prof_no_proforma")	
//	gf_fa_busqueda_sec(sle_pedido.text, ls_proforma)
//else
	ls_proforma = sle_pedido.text
//end if	
	
if ls_proforma = '' then
	gf_mensaje("","Debe asignar el numero de la proforma...",1,1,"E")
	dw_1.setfilter('')
	dw_1.filter()		
	sqlca.autocommit = true	
	return
end if
ls_tipo	 = dw_1.getitemstring(1,"fatprofo_prof_tipo")
ls_proforma_encabezado = dw_1.getitemstring(1,"fatprofo_prof_no_proforma")
ll_ann_encabezado    = dw_1.getitemNumber(1,"fatprofo_prof_ann")

  SELECT count(*)  
    INTO :li_existe  
    FROM fatpedid  
   WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
         ( fatpedid.pedi_empresa = :str.empresa ) AND  
 //        ( fatpedid.pedi_tipo = :ls_tipo ) AND  
         ( fatpedid.pedi_no_pedido = :ls_proforma ) AND  
         ( fatpedid.pedi_ann = :ll_ann )   ;
		if sqlca.sqlcode = -1 then
			mensaje('Aviso','Error al Validar Existencia en fatpedid',sqlca.sqlerrtext)
			dw_1.setfilter('')
			dw_1.filter()		
			sqlca.autocommit = true			
			return
		end if

	if li_existe > 0 then
		mensaje('Aviso','El numero del pedido ya existe..','')
		if w_fa_fondo.str_para.pasar_mismo_numero = 1 then 		
			if gf_mensaje('','Desea Utilizar el # que Proporciono el Sistema ?',2,1,'Q') = 2 then
				dw_1.setfilter('')				
				dw_1.filter()		
				sqlca.autocommit = true		
				return				
			end if
			//SI YA EXISTIA, TOMA EL NUMERO INCREMENTADO DEL SLE_PEDIDO
			ls_proforma = sle_pedido.text			
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
	 INSERT INTO fatpedid  
			( pedi_g_financiero,   
			  pedi_empresa,   
			  pedi_tipo,   
			  pedi_no_pedido,   
			  pedi_ann,   
			  pedi_cliente,   
			  pedi_ruc_cliente,   
			  pedi_condicion_pago,   
			  pedi_tipo_venta,   
			  pedi_tipo_movimiento,   
			  pedi_no_traspaso,   
			  pedi_fecha,   
			  pedi_fecha_creacion,   
			  pedi_fecha_modificacion,   
			  pedi_dias_pago,   
			  pedi_fecha_fin_plazo,   
			  pedi_consignado,   
			  pedi_a_nombre,   
			  pedi_a_nombre_direccion,   
			  pedi_despachado,   
			  pedi_via,   
			  pedi_con_emb_no,   
			  pedi_marca,   
			  pedi_bultos_total,   
			  pedi_cubicaje_total,   
			  pedi_peso_total,   
			  pedi_unidad_peso,   
			  pedi_gastos_total,   
			  pedi_monto_total,   
			  pedi_descu_subt_deta,   
			  pedi_por_descuento,   
			  pedi_supervisor,   
			  pedi_monto_final,   
			  pedi_comentario,   
			  pedi_estado ,  
			  pedi_autorizacion,
			  pedi_actualizo_cargos,
			  pedi_actualizo_vendedor,
			  pedi_factura_de_bodega,
			  pedi_cuatro_decimales,
			  pedi_usuario,
			  pedi_precio_a_utilizar,
			  pedi_costos_total,
			  pedi_origen_venta)
	SELECT  :str.g_financiero,   
           :str.empresa,   
           :ls_tipo,   
           :ls_proforma,   
           :ll_ann,   
           fatprofo.prof_cliente,   
           fatprofo.prof_ruc_cliente,   
           fatprofo.prof_condicion_pago,   
           fatprofo.prof_tipo_venta,   
           fatprofo.prof_tipo_movimiento,   
           fatprofo.prof_no_traspaso,   
           fatprofo.prof_fecha,   
           fatprofo.prof_fecha_creacion,   
           fatprofo.prof_fecha_modificacion,   
           fatprofo.prof_dias_pago,   
			  isnull(fatprofo.prof_fecha_fin_plazo,:ldt_fecha_serv),
           fatprofo.prof_consignado,   
           fatprofo.prof_a_nombre,   
           fatprofo.prof_a_nombre_direccion,   
           fatprofo.prof_despachado,   
           fatprofo.prof_via,   
           fatprofo.prof_con_emb_no,   
           fatprofo.prof_marca,   
           fatprofo.prof_bultos_total,   
           fatprofo.prof_cubicaje_total,   
           fatprofo.prof_peso_total,   
           fatprofo.prof_unidad_peso,   
           fatprofo.prof_gastos_total,   
           fatprofo.prof_monto_total,   
           fatprofo.prof_descu_subt_deta,   
           fatprofo.prof_por_descuento,   
           fatprofo.prof_supervisor,   
           fatprofo.prof_monto_final,   
           fatprofo.prof_comentario,   
           'A',   
			  fatprofo.prof_autorizacion,
			  'S',
			  'S',
			  fatprofo.prof_factura_de_bodega,
			  fatprofo.prof_cuatro_decimales,
			  fatprofo.prof_usuario,
			  fatprofo.prof_precio_a_utilizar,
			  fatprofo.prof_costos_total,
			  prof_origen_venta
           from  fatprofo
			 where fatprofo.prof_g_financiero = :str.g_financiero and
			 		 fatprofo.prof_empresa		 = :str.empresa and
					 fatprofo.prof_no_proforma	 = :ls_proforma_encabezado and
					 fatprofo.prof_ann			 = :ll_ann_encabezado ;
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al Insertar el Encabezado en fatpedid',ls_error)					
					sqlca.autocommit = true					
					return
				end if

/*INSERTANDO LOS CARGOS DE LA PROFORMA, SOLO SI SELECCIONO UNA PROFORMA*/

/**/if dw_1.rowcount() = 1 then
	  INSERT INTO fadpecar  
				(peca_g_financiero,   
				peca_empresa,   
				peca_no_pedido,   
				peca_ann,   
				peca_codigo_cargo,   
				peca_monto )  
     SELECT :str.g_financiero,   
            :str.empresa,   
            :ls_proforma,   				
            :ll_ann,   
            fadproca.prca_codigo_cargo,   
            fadproca.prca_monto  
       FROM fadproca  
      WHERE ( fadproca.prca_g_financiero = :str.g_financiero  ) AND  
            ( fadproca.prca_empresa = :str.empresa  ) AND  
            ( fadproca.prca_no_proforma = :ls_proforma_encabezado ) AND  
            ( fadproca.prca_ann = :ll_ann_encabezado )   ;
				
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al Insertar los cargos',ls_error)					
					return
				end if

end if/**/

// Isertando los vendedores
/**/if dw_1.rowcount() = 1 then
		INSERT INTO fadvenpe
				(vped_g_financiero,   
				vped_empresa,   
				vped_no_pedido,
				vped_ann,   
				vped_tipo,
				vped_vendedor)  
     SELECT :str.g_financiero,   
            :str.empresa,   
            :ls_proforma,   				
            :ll_ann,   
            fadvenpr.vpro_tipo,
				fadvenpr.vpro_vendedor
 			FROM fadvenpr
			WHERE ( fadvenpr.vpro_g_financiero = :str.g_financiero ) AND
					( fadvenpr.vpro_empresa = :str.empresa ) AND
					( fadvenpr.vpro_no_proforma = :ls_proforma_encabezado ) AND
					( fadvenpr.vpro_ann = :ll_ann_encabezado );
				
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					mensaje('Aviso','Error al Insertar el vendedor',ls_error)					
					return
				end if

end if/**/


/*INSERTANDO EL DETALLE DE LAS PROFORMAS*/

for i = 1 to dw_1.rowcount()
	ls_proforma_det = dw_1.getitemString(i,"fatprofo_prof_no_proforma")	
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
					fadprofo.dpro_precio_original,   
					fadprofo.dpro_linea,   
					fadprofo.dpro_index,
					fadprofo.dpro_cantidad * inamedid.medi_cantidad + fadprofo.dpro_fraccion pasada ,
					fadprofo.dpro_costo_total,
					fadprofo.dpro_vendedor
			 FROM fadprofo, 
			 		inamedid
			 Where fadprofo.dpro_g_financiero = :str.g_financiero and
					 fadprofo.dpro_empresa      = :str.empresa and
					 fadprofo.dpro_no_proforma	 = :ls_proforma_det and					 
					 fadprofo.dpro_ann			 = :ll_ann_det and 					
					 (fadprofo.dpro_unidad_venta = inamedid.medi_medida ) and
					 fadprofo.dpro_pasada 		  < fadprofo.dpro_cantidad * inamedid.medi_cantidad + fadprofo.dpro_fraccion
		ORDER BY fadprofo.dpro_linea ASC  ;		
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
									  :ll_linea, :ll_index, :ld_pasada , :ld_costo_total, :li_vendedor;
		
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				close cur_proforma;				
				rollback;
				mensaje('Aviso','Error en el Fetch del cursor',ls_error)	
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
		
		ll_convert = gf_unidad_venta(ls_uni_venta,gf_medi_prod(ls_uni_prod))
		if ll_convert = 0 then ll_convert = 1
		ll_cant_a_pasar = ld_cantidad * ll_convert + ll_fraccion
		//calcula la disponibilidad a la fecha
		wf_calcula_disponible(ls_codigo_item, ll_disponible, ll_cant_a_pasar)
		
			  INSERT INTO fadpedid  
					( dped_g_financiero,   
					  dped_empresa,   
					  dped_no_pedido,   
					  dped_linea,   
					  dped_ann,   
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
					  dped_index,
					  dped_bulto_inicio,
					  dped_bulto_fin,
					  dped_precio_original,
					  dped_costo_total,
					  dped_disponible,
					  dped_vendedor)
				VALUES (:str.g_financiero,   
						  :str.empresa,   
						  :ls_proforma,
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
						  :ll_ultimo_index,
						  :ll_bulto_ini,
						  :ll_bulto_fin,
						  :ld_precio_original,
						  :ld_costo_total,
						  :ll_disponible,
						  :li_vendedor) ;						  
						  
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					close cur_proforma;					
					mensaje('Aviso','Error al Insertar el Detalle en fadpedid',ls_error)					
					return
				end if					
			
						//UPDATE DE LAS CANTIDADES PASADAS, EN S
						  UPDATE fadprofo  
							  SET dpro_pasada = :ld_pasada  
							WHERE ( fadprofo.dpro_g_financiero = :str.g_financiero ) AND  
									( fadprofo.dpro_empresa = :str.empresa ) AND  
									( fadprofo.dpro_no_proforma = :ls_proforma_det ) AND  
									( fadprofo.dpro_ann = :ll_ann_det ) AND  
									( fadprofo.dpro_linea = :ll_linea_det ) ;
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_proforma;
							mensaje('Aviso','Error al actualizar la cantidad pasada',ls_error)	
							sqlca.autocommit = true							
							return
						end if																																
			
			
		fetch cur_proforma into :ls_codigo_item, :ls_descrip, :ld_cubicaje, :ld_peso, :ls_uni_peso,&
									  :ls_uni_prod, :ld_precio_ma, :ld_precio_me, :ls_bodega, :ld_costo_fob,&
									  :ld_costo_cif, :ld_precio, :ls_uni_venta, :ld_cantidad, :ll_fraccion,&
									  :ld_monto_total, :ld_por_descuento, :ld_monto_final, :ls_usuario, :ls_supervisor,&
									  :ll_bultos, :ls_ubicacion, :ll_bulto_ini, :ll_bulto_fin, :ld_precio_original,&
									  :ll_linea, :ll_index, :ld_pasada, :ld_costo_total, :li_vendedor ;
		
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_proforma;
							mensaje('Aviso','Error en el Fetch del cursor',ls_error)	
							sqlca.autocommit = true							
							return
						end if								
						
						ll_linea_det = ll_linea
						//Para tomar la linea del detalle, y actualizar la cantidad pasada												
		loop
	
	/*CIERRA EL CURSOR*/
	close cur_proforma;
	
	/*UPDATE DEL ESTADO DE LA PROFORMA A PASADA Y DE LAS CANTIDADES PASADAS*/
		  UPDATE fatprofo  
			  SET prof_estado = 'P'  
			WHERE ( fatprofo.prof_g_financiero = :str.g_financiero ) AND  
					( fatprofo.prof_empresa = :str.empresa ) AND  
					( fatprofo.prof_no_proforma = :ls_proforma_det ) AND  
					( fatprofo.prof_ann = :ll_ann_det )   ;
					
						if sqlca.sqlcode = -1 then
							ls_error = sqlca.sqlerrtext
							rollback;
							close cur_proforma;
							mensaje('Aviso','Error al actualizar la proforma a pasado',ls_error)
							sqlca.autocommit = true							
							return
						end if								

	
Next //Del Ciclo for de los PROFORMAS a pasar


close cur_proforma; //cierra el cursor

  UPDATE faaparam  
     SET fara_ult_pedido = :ls_proforma 
   WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
         ( faaparam.fara_empresa = :str.empresa );
			
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje('Aviso','Error al actualizar la secuencia del pedido en parámetros',ls_error)
			sqlca.autocommit = true			
			return
		end if								

commit;

gf_mensaje('','Pase Efectuado Satisfactoriamente',1,1,"E")
dw_1.setfilter('')
dw_1.filter()
dw_5.triggerevent('itemchanged')

sle_pedido.text = string(long(ls_proforma) + 1) 

sqlca.autocommit = true

end subroutine

public function boolean wf_calcula_disponible (string as_producto, ref long al_disponible, long al_pedido);long ll_disponible, ll_existencia, ll_reserva

  SELECT isnull(inmprodu.prod_existencia_total  ,0)
    INTO :ll_existencia  
    FROM inmprodu  
   WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
         ( inmprodu.prod_empresa = :str.empresa ) AND  
         ( inmprodu.prod_producto = :as_producto )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al buscar existencias '+ sqlca.sqlerrtext,1,1,'E')
	end if

		declare sp_reserva procedure for fa_reservados_totaldos
		@g_financiero = :str.g_financiero ,
		@empresa = :str.empresa,
		@codigo_producto = :as_producto;
		
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al declarar cursor '+sqlca.sqlerrtext,1,1,'E')
			return false
		end if
		
		execute sp_reserva ;
		
		do while sqlca.sqlcode = 0
			fetch sp_reserva into :ll_reserva ;
		loop
		
		close sp_reserva ;
	
		if isnull(ll_reserva) then ll_reserva = 0	

		al_disponible = ll_existencia - ll_reserva - al_pedido

return true
end function

on w_fa_co_prof_pasa_ped_directo.create
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

on w_fa_co_prof_pasa_ped_directo.destroy
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

event ue_post_open;
string ls_vienede , ls_where,ls_medact, ls_pedido
long   ll_recupero

this.y = 1
this.x =1
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
	
//	dw_4.GetChild("fadpedid_dped_unidad_venta", idw_child_uni)
	idw_child_uni.setTransObject(sqlca)
	idw_child_uni.Retrieve()
//	dw_4.SetTransObject(sqlca)
	
	dw_5.Accepttext()
	dw_5.GetChild("notercero",idch_cliente)
	idch_cliente.SetTransObject(Sqlca)
	
//	dw_6.SetTransObject(Sqlca)
//	dw_6.InsertRow(0)
	
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
		idch_cliente.Retrieve(str.g_financiero,str.empresa)
	End If
	dw_5.SetTransObject(Sqlca)
	dw_5.ScrollToRow(dw_5.InsertRow(0))
	dw_5.SetFocus()
	
	pb_2.PictureName = str.path +"\art\pasar_rp.bmp"
	pb_2.Enabled = false
	str.frame.SetMicroHelp ("Seleccione una Linea y Precione la Tecla Enter para Cargar la Información" )
//End If


////Asigna el Pedido Disponible en la Secuencia
//  SELECT faaparam.fara_ult_pedido  
//    INTO :ls_pedido  
//    FROM faaparam  
//   WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
//         ( faaparam.fara_empresa = :str.empresa )   ;
//		if sqlca.sqlcode = -1 then
//			mensaje("Información (ue_post_open)","Error al Seleccionar el ultimo pedido",sqlca.sqlerrtext)
//			return 
//		end if					
//
//ls_pedido  = string(long(ls_pedido) + 1)

gf_fa_busqueda_sec(sle_pedido.text, '0')
//if w_fa_fondo.str_para.pasar_mismo_numero = 0 then sle_pedido.text = ls_pedido 
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

event close;//Override
Destroy iuo_desglose
Destroy iuo_desg_a_pasar

  
Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
 
end event

event resize;//OVERRIDE


end event

event closequery;call super::closequery;constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)

This.SetRedraw(false)
end event

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_co_prof_pasa_ped_directo
boolean visible = false
integer x = 14
integer y = 1356
long backcolor = 74481808
end type

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_co_prof_pasa_ped_directo
integer x = 1431
integer y = 1060
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_co_prof_pasa_ped_directo
event ue_down pbm_dwnkey
event ue_post ( )
integer x = 59
integer y = 120
integer width = 2802
integer height = 904
integer taborder = 140
string dataobject = "dw_co_fa_profo_apasar_directo"
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

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_co_prof_pasa_ped_directo
integer x = 23
integer y = 24
integer width = 2862
integer height = 1020
integer taborder = 0
long textcolor = 8388608
long backcolor = 74481808
string text = "Encabezado"
end type

type gb_3 from groupbox within w_fa_co_prof_pasa_ped_directo
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

type rb_1 from radiobutton within w_fa_co_prof_pasa_ped_directo
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

type rb_2 from radiobutton within w_fa_co_prof_pasa_ped_directo
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

type dw_2 from datawindow within w_fa_co_prof_pasa_ped_directo
event editchanged pbm_dwnchanging
integer x = 1445
integer y = 1232
integer width = 827
integer height = 84
integer taborder = 120
boolean bringtotop = true
string dataobject = "dw_texto_profo"
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
	
	Formato =  "fatprofo_prof_ruc_cliente like " +"'"+data+"%"+"'"
ELSEIF rb_3.Checked = True THEN /*A Nombre*/
	Formato =  "fatprofo_prof_a_nombre like " +"'"+data+"%"+"'"
	
ELSEIF rb_4.Checked = True THEN /*Pedido*/
	Formato =  "fatprofo_prof_no_proforma like " +"'"+data+"%"+"'"

ELSEIF rb_5.Checked = True THEN /*Estado*/
		
	Formato =  "fatprofo_prof_estado  like " +"'"+data+"%"+"'"

ELSEIF rb_6.Checked = True THEN /*Fecha*/
	Formato =  " date(fatprofo_prof_fecha) Between " + &
	                  "Date(" + "'" + em_1.text + "'" + ")" + " And " + & 
					"Date("+ "'" +em_2.text +"'"+")"

ELSEIF rb_7.Checked = True THEN /*Vendedor*/
	Formato =  "fatprofo_prof_a_nombre like " +"'"+data+"%"+"'"


ELSE /*Proforma*/
	Formato =  "String("  + "fatprofo_prof_no_proforma)"  + "like "  +"'"+data+"%"+"'"
END IF

If Formato <> "" Then
	dw_1.SetFilter(Formato)
	dw_1.Filter()

End If
end event

type rb_4 from radiobutton within w_fa_co_prof_pasa_ped_directo
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

type rb_5 from radiobutton within w_fa_co_prof_pasa_ped_directo
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

type rb_6 from radiobutton within w_fa_co_prof_pasa_ped_directo
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

type pb_1 from picturebutton within w_fa_co_prof_pasa_ped_directo
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

type em_1 from editmask within w_fa_co_prof_pasa_ped_directo
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

type em_2 from editmask within w_fa_co_prof_pasa_ped_directo
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

type st_2 from statictext within w_fa_co_prof_pasa_ped_directo
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

type st_3 from statictext within w_fa_co_prof_pasa_ped_directo
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

type pb_2 from picturebutton within w_fa_co_prof_pasa_ped_directo
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

type dw_5 from datawindow within w_fa_co_prof_pasa_ped_directo
event ue_key pbm_dwnkey
integer x = 46
integer y = 8
integer width = 1262
integer height = 96
integer taborder = 150
boolean bringtotop = true
string dataobject = "dw_dd_fa_clientes_proforma"
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

type rb_7 from radiobutton within w_fa_co_prof_pasa_ped_directo
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

type gb_2 from groupbox within w_fa_co_prof_pasa_ped_directo
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

type rb_3 from radiobutton within w_fa_co_prof_pasa_ped_directo
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

type cb_1 from commandbutton within w_fa_co_prof_pasa_ped_directo
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

type cb_2 from commandbutton within w_fa_co_prof_pasa_ped_directo
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

type cb_pedi_sala from commandbutton within w_fa_co_prof_pasa_ped_directo
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

type sle_pedido from singlelineedit within w_fa_co_prof_pasa_ped_directo
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

type st_1 from statictext within w_fa_co_prof_pasa_ped_directo
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

