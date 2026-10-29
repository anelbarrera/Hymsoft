//objectcomments Ventana de pases de confirmaciones a Pedidos
forward
global type w_cz_pases_confirmacion from w_fa_padre
end type
type gb_4 from groupbox within w_cz_pases_confirmacion
end type
type gb_2 from groupbox within w_cz_pases_confirmacion
end type
type gb_1 from groupbox within w_cz_pases_confirmacion
end type
type st_1 from statictext within w_cz_pases_confirmacion
end type
type pb_1 from picturebutton within w_cz_pases_confirmacion
end type
type dw_3 from datawindow within w_cz_pases_confirmacion
end type
type gb_3 from groupbox within w_cz_pases_confirmacion
end type
type pb_2 from picturebutton within w_cz_pases_confirmacion
end type
type pb_3 from picturebutton within w_cz_pases_confirmacion
end type
type dw_5 from datawindow within w_cz_pases_confirmacion
end type
type dw_6 from datawindow within w_cz_pases_confirmacion
end type
type dw_2 from datawindow within w_cz_pases_confirmacion
end type
type cb_1 from commandbutton within w_cz_pases_confirmacion
end type
type cb_2 from commandbutton within w_cz_pases_confirmacion
end type
type dw_4 from datawindow within w_cz_pases_confirmacion
end type
type dw_7 from uos_in_datawindow_utility within w_cz_pases_confirmacion
end type
type st_2 from statictext within w_cz_pases_confirmacion
end type
type st_3 from statictext within w_cz_pases_confirmacion
end type
type dw_8 from datawindow within w_cz_pases_confirmacion
end type
end forward

global type w_cz_pases_confirmacion from w_fa_padre
boolean visible = true
integer x = 503
integer y = 400
integer width = 3643
integer height = 1740
string title = "(CR) Pase de Confirmación a Tránsitos"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event ue_seleccion ( )
event ue_facturar ( )
gb_4 gb_4
gb_2 gb_2
gb_1 gb_1
st_1 st_1
pb_1 pb_1
dw_3 dw_3
gb_3 gb_3
pb_2 pb_2
pb_3 pb_3
dw_5 dw_5
dw_6 dw_6
dw_2 dw_2
cb_1 cb_1
cb_2 cb_2
dw_4 dw_4
dw_7 dw_7
st_2 st_2
st_3 st_3
dw_8 dw_8
end type
global w_cz_pases_confirmacion w_cz_pases_confirmacion

type variables
datawindowchild idwchild,idwchild2,idwchild3,idwchild4
Datawindowchild  idch_cliente
DataWindow idw_cual
integer ii_clicked, ii_ultgetrow
long  il_cantidad
str_detalles	str_datos
string		is_tipo

str_pase_fact	lstr_pase
end variables

forward prototypes
public subroutine wf_efectuar_factura ()
end prototypes

event ue_seleccion;integer  li_i, li_rows,li_rows2, li_fila, li_year[]
long 		ll_c, ll_anno, ll_linea, ll_i
string   ls_pedid,ls_cod_item, ls_num_conf[]
string	ls_orden
long 		ll_row,ll_ano

CHOOSE CASE idw_cual
	CASE dw_1
		dw_2.RowsMove(1,dw_2.RowCount(),Primary!,dw_3,dw_3.rowcount()+1,Primary!)
//		if is_tipo <> 'S' then // Prueba
		if is_tipo = 'D' then
			dw_5.reset()
			for li_fila = 1 to dw_3.RowCount()
				ls_num_conf[li_fila] = dw_3.object.dcof_num_conf_oc[li_fila]
				li_year[li_fila] = dw_3.object.dcof_anno_oc[li_fila]
			next
			
			if dw_5.retrieve(str.g_financiero,str.empresa,ls_num_conf[],li_year[]) < 1 then
				messagebox('Atención','No se encontraron los registros del desglose.',Exclamation!)
				return
			end if
		end if
	CASE dw_2
		For li_i = 1 to dw_2.RowCount()
			If dw_2.IsSelected(li_i) then
				dw_2.RowsMove(li_i,li_i,Primary!,dw_3,1,Primary!)
			End If
		Next
		
		if is_tipo <> 'S' then
			dw_5.reset()
			for li_fila = 1 to dw_3.RowCount()
				ls_num_conf[li_fila] = dw_3.object.dcof_num_conf_oc[li_fila]
				li_year[li_fila] = dw_3.object.dcof_anno_oc[li_fila]
			next
			
			if dw_5.retrieve(str.g_financiero,str.empresa,ls_num_conf[],li_year[]) < 1 then
				messagebox('Atención','No se encontraron los registros del desglose.',Exclamation!)
				return
			end if
		end if

	CASE dw_3
			For ll_c = 1 to dw_3.RowCount()
				dw_3.Setredraw(false)
				If dw_3.IsSelected(ll_c) Then
					dw_3.RowsMove(ll_c,ll_c,Primary!,dw_2,1,Primary!)
				End If
				dw_3.Setredraw(true)
			Next		
END CHOOSE

end event

event ue_facturar();wf_efectuar_factura()

end event

public subroutine wf_efectuar_factura ();String			ls_codigo,ls_unidad,ls_item,ls_tipo_compra,ls_clase_comp,ls_tipo_pago, ls_errtext
String			ls_tipo_oc,ls_tipo_costo,ls_rep_prov,ls_observacion,ls_forma_pago,ls_error=''
String			ls_cod_item,ls_descripcion,ls_no_orden,ls_numero_oc,ls_sec_fac,ls_num_carta,ls_contenedor
String			ls_numero,ls_secuencia,ls_viaje,ls_color,ls_board, ls_find,ls_bodega,ls_ubicacion
Long				li_provee,ll_pasado,ll_cont,ll_ordenado,ll_cant_pendiente,ll_secuencia_oc,ll_facturado, ll_cant_facturada, ll_cant_total
Long				ll_secuencia_tran,ll_pendiente,ll_anterior, ll_filas, ll_find=1, ld_ult_pase,ll_fraccion
Long				ll_conver,ll_ucon
Integer			li_anno,li_i,li_anio,li_linea,li_tipo_compra,li_c,li_status
Integer			li_largo_codigo_oc,li_linea1, li_flag2, li_siguiente ,li_anno_tr, li_total, li_bultos, li_ann_conf, li_cantidad_minima = 10
integer li_conteo = 0 
DateTime			ldt_fecha_serv
dec{2}			ld_costos, ld_valor, ld_precio,ld_precio1,ld_precio2,ld_precio3,ld_cantidad,ld_cant_ordenada,ld_total, ld_costo, ld_precio_original
dec{4}			ld_peso
dec{0}			ld_cant1


ldt_fecha_serv	= gf_fecha_serv()

dw_5.accepttext()

If dw_3.Rowcount() < 1  then
	messagebox("AVISO",'No existen Confirmaciones para efectuar el "Pase" a Tránsito',Exclamation!)
	rollback;
	return
End If

Openwithparm(w_cz_selec_confirmacion,'')

If Message.StringParm <> 'Cancelar' then
	SELECT isnull(mpar_largo_codigo_oc,0),
			isnull(mpar_secuencia_fact,0),
			isnull(mpar_secuencia_transito,0)
	INTO :li_largo_codigo_oc,
			:ll_secuencia_oc,
			:ll_secuencia_tran
	FROM crmparam
	WHERE ( mpar_g_financiero = :str.g_financiero ) AND
			( mpar_empresa = :str.empresa );
	
	If sqlca.sqlcode = -1 then
		ls_error =sqlca.sqlerrtext
		rollback;
		messagebox("Error","No se obtuvieron los parámetros! "+ls_error,Exclamation!)
		return
	elseif sqlca.sqlcode = 100 then
		rollback;
		messagebox("Atención","Error en la obtención de los parámetros!",Exclamation!)
		return
	End If
	
	ls_sec_fac = 'FA'+fill('0',li_largo_codigo_oc - len(string(ll_secuencia_oc)))+string(ll_secuencia_oc)
	ls_no_orden = Message.StringParm
	ls_numero_oc = lstr_pase.orden
	
	ls_secuencia = string(ll_secuencia_tran)

	OpenWithParm(w_cz_sec_confirmacion,lstr_pase)
	
	lstr_pase = message.PowerObjectParm
	if lstr_pase.orden = 'Cancelar' then
		rollback;
		messagebox("AVISO",'El Proceso de "Pase" ha sido Cancelado',Exclamation!)
		return
	end if

	setpointer(Hourglass!)

	li_anio   		= dw_1.getitemnumber(dw_1.getrow(),"tcof_anno_oc")
	
	// Actualizar lo pasado y lo facturado
	For ll_cont = 1 to dw_3.Rowcount()
		ls_numero   		= dw_3.Getitemstring(ll_cont,"dcof_num_conf_oc")
		ls_codigo			= dw_3.Getitemstring(ll_cont,"dcof_producto")
		ls_unidad 			= dw_3.GetitemString(ll_cont,"dcof_unidad")
		ll_ordenado			= dw_3.GetitemNumber(ll_cont,"dcof_cantidad_total")
		ll_pendiente      = dw_3.GetitemNumber(ll_cont,"dcof_cant_pendiente")
		ll_pasado 			= dw_3.GetitemNumber(ll_cont,"pasado")
		ll_fraccion			= dw_3.GetitemNumber(ll_cont,"fraccion")
		li_linea1         = dw_3.GetitemNumber(ll_cont,"dcof_num_ren_confi")
		ld_precio1			= dw_3.GetitemNumber(ll_cont,"dcof_precio1")
		ld_precio2			= dw_3.GetitemNumber(ll_cont,"dcof_precio2")
		ld_precio3			= dw_3.GetitemNumber(ll_cont,"dcof_precio3")
		ld_cant1				= dw_3.GetitemNumber(ll_cont,"dcof_cant1")
		li_ann_conf			= dw_3.GetitemNumber(ll_cont,"dcof_anno_oc")
		ll_cant_facturada = dw_3.GetitemNumber(ll_cont,"dcof_cant_facturada")
		
		
		If ll_pasado = 0  then
			Mensaje("AVISO","La Cantidad  no puede estar en Cero (0)",&
					  "Verifique en el Código de Item "+ls_item+"")
			dw_3.SelectRow(0,false)
			dw_3.SelectRow(ll_cont,true)
			setpointer(Arrow!)
			return
		Else
			//Seccion nueva para que elimine el remanente si lo pendiente es menor o igual a 10 Docenas
			if ll_ordenado - ll_cant_facturada - ll_pasado <= li_cantidad_minima then
				Update crdconfi
				Set dcof_cant_facturada 		= dcof_cantidad_total,
					 dcof_cant1_facturada 	= dcof_cant1,
					 dcof_cant_pendiente 	= 0,
					 dcof_cant1_pendiente 	= 0,
					 dcof_cantidad_recibida  = isnull(dcof_cantidad_recibida,0) + :ll_pasado,
					 dcof_cant1_recibida		= isnull(dcof_cant1_recibida,0) + :ll_fraccion,
					 dcof_fecha_ultima_act = getdate()
				Where  dcof_g_financiero 	= :str.g_financiero and
						 dcof_empresa 			= :str.empresa and
						 dcof_num_conf_oc    = :ls_numero and
						 dcof_num_ren_confi  = :li_linea1 and 
						 dcof_anno_oc = :li_ann_conf ;
			else
				Update crdconfi
				Set dcof_cant_facturada 	= isnull(dcof_cant_facturada,0) + :ll_pasado,
					 dcof_cant_pendiente 	= :ll_ordenado - isnull(dcof_cant_facturada,0) - :ll_pasado,
					 dcof_cant1_facturada 	= isnull(dcof_cant1_facturada,0) + :ll_fraccion,
					 dcof_cant1_pendiente 	= :ld_cant1 - isnull(dcof_cant1_facturada,0) - :ll_fraccion,
					 dcof_cantidad_recibida  = isnull(dcof_cantidad_recibida,0) + :ll_pasado,
					 dcof_cant1_recibida		= isnull(dcof_cant1_recibida,0) + :ll_fraccion,
					 dcof_fecha_ultima_act = getdate()
				Where  dcof_g_financiero 	= :str.g_financiero and
						 dcof_empresa 			= :str.empresa and
						 dcof_num_conf_oc    = :ls_numero and
						 dcof_num_ren_confi  = :li_linea1 and 
						 dcof_anno_oc = :li_ann_conf ;
			end if			
			
			If sqlca.sqlcode = -1 then
				ls_error =sqlca.sqlerrtext
				rollback;
				messagebox("Error","Error al Actualizar en Detalle de Confirmaciones! "+ls_error,Exclamation!)
				setpointer(Arrow!)
				return
			elseif sqlca.sqlcode = 100 then
				rollback;
				messagebox("Atención","Error al Actualizar en Detalle de Confirmaciones!",Exclamation!)
			End If
		End If
	Next
	
	For li_i = 1 to dw_1.RowCount()
		If dw_1.GetItemString(li_i,"tcof_num_conf_oc") = ls_no_orden then
			ii_ultgetrow = li_i
		End If
	Next	
	ls_codigo 		= dw_1.getitemstring(ii_ultgetrow,"tcof_num_conf_oc")
	ls_viaje       = dw_1.getitemstring(ii_ultgetrow,"tcof_codigo_viaje")
	ls_num_carta	= dw_1.getitemstring(ii_ultgetrow,"tcof_num_carta_credito")
	li_anno   		= dw_1.getitemnumber(ii_ultgetrow,"tcof_anno_oc")
	ls_tipo_compra	= dw_1.getitemstring(ii_ultgetrow,"tcof_tipo_compra")
	ls_clase_comp  = dw_1.getitemstring(ii_ultgetrow,"tcof_clase_compra")
	ls_tipo_pago   = dw_1.getitemstring(ii_ultgetrow,"tcof_cod_tipo_pago")
	li_provee      = dw_1.getitemnumber(ii_ultgetrow,"tcof_num_prove")
	ls_tipo_oc     = dw_1.getitemstring(ii_ultgetrow,"tcof_tipo_conf")
	li_status		= dw_1.getitemnumber(ii_ultgetrow,"tcof_estatus_conf_oc")
	ls_tipo_costo  = dw_1.getitemstring(ii_ultgetrow,"tcof_tipo_costo")
	ls_rep_prov    = dw_1.getitemstring(ii_ultgetrow,"tcof_representante_prov")
	ls_observacion = dw_1.getitemstring(ii_ultgetrow,"tcof_comentario_add")
	ls_forma_pago  = dw_1.getitemstring(ii_ultgetrow,"tcof_cod_forma_pago")
	ls_contenedor  = dw_1.getitemstring(ii_ultgetrow,"tcof_contenedor")
	
/*CAMBIO TEMPORAL PARA PRUEBA PASE COMPRA AÑO 2002 TRA, FACT PASE 2003*/
/*EL AÑO DEL TRANSITO LO TRAE DEL ENCABEZADO DEL MISMO*/
/**/	li_anno_tr = lstr_pase.anno
//	lstr_pase.anno = li_anno_tr //era li_anno
	
	select count(*) 
	into :li_conteo 
	from crtordco
		where toco_g_financiero  = :str.g_financiero and 
				toco_empresa = :str.empresa and 
				toco_codigo_oc = :lstr_pase.orden  and 
				toco_anno_oc  = :li_anno_tr and   //era li_anno 
				toco_num_suplemento = ' ' ; 
//				toco_anio_orden_c  = :li_anno and  //año de la orden de compra

	If sqlca.sqlcode <> 0 then
		ls_error = sqlca.sqlerrtext
		rollback;
		messagebox("Atención - El proceso continuara ","Error al Insertar el Encabezado de Tránsitos. "+ls_error,Exclamation!)
	Else
		if isnull(li_conteo) then li_conteo = 0 
	end if
		
	ld_total = dw_3.getitemnumber(1,'compute_2')	

if li_conteo = 0 then 
	
	INSERT INTO crtordco
		(toco_g_financiero,
		toco_empresa,
		toco_codigo_oc,
		toco_anno_oc,   
		toco_tipo_oc,
		toco_num_prove,   
		toco_cod_tipo_pago,
		toco_fecha_oc,
		toco_fecha_entrega,
		toco_estatus_oc,   
		toco_representante_empresa,
		toco_tipo_costo,
		toco_tipo_compra,			 
		toco_clase_compra,
		toco_forma_pago,
		toco_observacion,
		toco_num_carta_credito,
		toco_num_suplemento,
		toco_pedido,
		toco_codigo_viaje,
		toco_contenedor,
		toco_monto_total_orden,toco_anio_orden_c,
		toco_usuario)
	VALUES (:str.g_financiero, 
		:str.empresa,  
		:lstr_pase.orden,
		:li_anno_tr,  // era li_anno
		:ls_tipo_oc,
		:li_provee,   
		:ls_tipo_pago,
		:ldt_fecha_serv,   
		:ldt_fecha_serv,   
		:li_status,
		:ls_rep_prov,
		:ls_tipo_costo ,
		'00003',
		:ls_clase_comp,
		:ls_forma_pago ,  		  
		:ls_observacion,
		:ls_num_carta,
		' ',
		:ls_codigo,
		:ls_viaje,
		:ls_contenedor,
		:ld_total,:li_anno,
		:str.usuario);
else 
		select max(doco_num_renglon_oc) 
		INTO   :li_siguiente
		from   crdordco
      where  doco_g_financiero =  :str.g_financiero and
				 doco_empresa 		 =  :str.empresa and
				 doco_codigo_oc    =  :lstr_pase.orden and 
				 doco_anno_oc		 =	 :li_anno_tr and // era li_anno
				 doco_num_suplemento= ' ' ;
end if	
	If sqlca.sqlcode <> 0 then
		ls_error = sqlca.sqlerrtext
		rollback;
		messagebox("Atención","Error al Insertar el Encabezado de Tránsitos. "+ls_error,Exclamation!)
		setpointer(Arrow!)
		return
	Else
		
		If li_siguiente < 0  or isnull(li_siguiente) then
			li_siguiente = 0
		end if
		
		SELECT mpar_bodega,
				 mpar_ubicacion
		INTO  :ls_bodega,
				:ls_ubicacion
		FROM crmparam
		WHERE ( mpar_g_financiero = :str.g_financiero ) AND
				( mpar_empresa = :str.empresa );
		
		li_total = dw_3.rowcount()
		
		For li_i = 1 to dw_3.RowCount()
			// Validación para que los renglones del detalle coincidan con los del desglose
			ls_codigo 	= dw_3.GetItemString(li_i,"dcof_num_conf_oc")
			li_anio 		= dw_3.GetItemNumber(li_i,"dcof_anno_oc")
			li_linea 	= dw_3.GetItemNumber(li_i,"dcof_num_ren_confi")
			ls_cod_item = dw_3.object.dcof_producto[li_i]
			ls_board 	= dw_3.GetitemString(li_i,"dcof_board")
			if isnull(ls_board) then ls_board = ' '
			ls_color		= dw_3.GetitemString(li_i,"dcof_color")
			li_ann_conf = dw_3.GetItemNumber(li_i,"dcof_anno_oc")
			ld_precio_original = dw_3.GetItemNumber(li_i,"dcof_precio_original")
			if isnull(ld_precio_original) then ld_precio_original = 0
			
			str.frame.setmicrohelp('Procesando el Producto '+ls_cod_item+' registro '+string(li_i)+' de '+string(li_total))
						
			ls_tipo_oc 				= dw_3.getitemstring(li_i,"dcof_tipo_confirmacion")
			li_tipo_compra 			= dw_3.GetItemNumber(li_i,"dcof_tipo_compra")
			ls_descripcion 			= dw_3.GetItemString(li_i,"dcof_descripcion")
			ls_unidad  				= dw_3.GetItemString(li_i,"dcof_unidad")			
			ld_precio 				= dw_3.GetItemNumber(li_i,"dcof_precio_u") 
			ll_cant_facturada 		= dw_3.GetitemNumber(li_i,"dcof_cant_facturada")
			ll_cant_total				= dw_3.GetItemNumber(li_i,"dcof_cantidad_total")			
			
			ld_cantidad  	   		= dw_3.GetItemNumber(li_i,"pasado")
			if isnull(dw_3.GetitemNumber(li_i,"dcof_cant_pendiente")) or dw_3.GetitemNumber(li_i,"dcof_cant_pendiente") = 0 then
				ld_cant_ordenada  = dw_3.GetItemNumber(li_i,"dcof_cantidad_total")
			else
				ld_cant_ordenada  = dw_3.GetitemNumber(li_i,"dcof_cant_pendiente")
			end if
			
			//Si el remanente es menor a 10, que ponga en la cantidad total la misma cantidad facturada para que no aparezca
			if ll_cant_total - ll_cant_facturada - ld_cantidad <= li_cantidad_minima then ld_cant_ordenada = ld_cantidad
			
			li_provee            		= dw_1.getitemnumber(ii_ultgetrow,"tcof_num_prove")
			ld_precio1				= dw_3.GetitemNumber(li_i,"dcof_precio1") 
			ld_precio2				= dw_3.GetitemNumber(li_i,"dcof_precio2") 
			ld_precio3				= dw_3.GetitemNumber(li_i,"dcof_precio3") 
			ld_cant1					= dw_3.GetitemNumber(li_i,"fraccion")
			ld_peso					= dw_3.GetitemNumber(li_i,"crdconfi_dcof_peso_bruto")
			li_bultos					= dw_3.GetitemNumber(li_i,"crdconfi_dcof_bultos")			
			
			INSERT INTO crdordco
				(doco_g_financiero,
				doco_empresa,
				doco_codigo_oc,
				doco_anno_oc,
				doco_num_renglon_oc, 
				doco_tipo_compra,
				doco_id_referencia,   
				doco_descripcion_ref,
				doco_unidad,   
				doco_precio_unitario,   
				doco_cantidad_total,
				doco_estatus,
				doco_impreso,
				doco_tipo_oc,
				doco_cant_facturada,
				doco_num_suplemento,
				doco_cantidad_actual,			//Cantidad Original Pedida o La Cantidad Pendiente, por si se despacho parcial
				doco_precio_actual,
				doco_color,
				doco_board,
				doco_cant1,
				doco_precio1,
				doco_precio2,
				doco_precio3,
				doco_pedido_conf,
				doco_linea_conf,
				doco_peso,
				doco_bultos,
				doco_ann_conf,
				doco_precio_original)
			VALUES (:str.g_financiero,
				:str.empresa, 
				:lstr_pase.orden,
				:li_anno_tr, //era li_anno
				:li_i  + :li_siguiente,
				:li_tipo_compra,
				:ls_cod_item,
				:ls_descripcion,   
				:ls_unidad,   
				:ld_precio,   
				:ld_cantidad,
				14,
				0,
				:ls_tipo_oc,
				0,
				' ',
				:ld_cant_ordenada,
				:ld_precio,
				:ls_color,
				:ls_board,
				:ld_cant1,
				:ld_precio1,
				:ld_precio2,
				:ld_precio3,
				:ls_codigo,
				:li_linea,
				:ld_peso,
				:li_bultos,
				:li_ann_conf,
				:ld_precio_original) ;
			
			If sqlca.sqlcode <> 0 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Error","No se Insertó el Detalle del Tránsito. ",ls_error)
				setpointer(Arrow!)
				return
			End If
			/*Extrae el Tipo de medida "Peso/Unidades/volumen/etc "*/
			ll_ucon = gf_medi_prod(ls_unidad)			
			//busca la cantidad equivalente a la unidad de medida			
			ll_conver = gf_unidad_venta(ls_unidad,ll_ucon)
			ld_cantidad = ld_cantidad * ll_conver + ld_cant1  /*poner + fraccion cuando se incluya la misma*/
		
			UPDATE inmprodu  
			SET 	prod_cant_confirma = prod_cant_confirma - :ld_cantidad,
					prod_ubicacion = ''
			WHERE	inmprodu.prod_g_financiero = :str.g_financiero and
					inmprodu.prod_empresa = :str.empresa and
					inmprodu.prod_producto = :ls_cod_item;
			
			If sqlca.sqlcode = -1 then
				ls_error =sqlca.sqlerrtext
				rollback;
				messagebox("Error","Error al Actualizar en Inmprodu la cantidad en Confirmación! "+ls_error,Exclamation!)
				setpointer(Arrow!)
				return
			elseif sqlca.sqlcode = 100 then
				rollback;
				messagebox("Atención","Error al Actualizar en Inmprodu de Confirmaciones!",Exclamation!)
			End If
			
			UPDATE inmbodeg  
			SET 	mbod_cant_confirma = mbod_cant_confirma - :ld_cantidad
			WHERE	inmbodeg.mbod_g_financiero = :str.g_financiero and
					inmbodeg.mbod_empresa = :str.empresa and
					inmbodeg.mbod_producto = :ls_cod_item and
					inmbodeg.mbod_bodega =: ls_bodega and
					inmbodeg.mbod_ubicacion =: ls_ubicacion ;			
			If sqlca.sqlcode = -1 then
				ls_error =sqlca.sqlerrtext
				rollback;
				messagebox("Error","Error al Actualizar en Inmprodu la cantidad en Confirmación! "+ls_error,Exclamation!)
				setpointer(Arrow!)
				return
			elseif sqlca.sqlcode = 100 then
				rollback;
				messagebox("Atención","Error al Actualizar en Inmprodu de Confirmaciones!",Exclamation!)
			End If			
	
			//Actualización de Bodegas a Fadpedid 
			//Ver en que momento cambia de reserva origen T o C a E
		  UPDATE fadpedid
			  SET	dped_reserva_origen = 'T',
			  		dped_num_transito = :lstr_pase.orden,
					dped_ann_transito = :li_anno_tr, //era li_anno
					dped_linea_transito = :li_i  + :li_siguiente
			WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
					( fadpedid.dped_empresa = :str.empresa ) AND  
					( fadpedid.dped_num_orden_compra = :ls_codigo ) AND  
					( fadpedid.dped_ann_orden_compra = :li_anio ) AND  
					( fadpedid.dped_reserva_origen = 'C' );
		
				if sqlca.sqlcode <> 0 then
					if sqlca.sqlcode = -1 then ls_errtext = ' Descripción del error: '+sqlca.sqlerrtext
					rollback;
					messagebox('Error','No se actualizó en Pedidos la Bodega/Ubicación del producto: '+ls_cod_item+ls_errtext+'.',Exclamation!)
					sqlca.autocommit = true				
					setpointer(Arrow!)
					return
				end if				
				/***************************/				
				gf_actualiza_transitos(ls_cod_item)
	
		Next
		str.frame.setmicrohelp('Pase Exitoso')
	End If
	
	
	if dw_5.update() = 1 then
		if dw_6.update() = 1 then
						
		  SELECT round(sum(( doco_cantidad_total + (isnull(doco_cant1,0) / inamedid.medi_cantidad ))  * doco_precio_unitario ),2)
			 INTO :ld_valor  
			 FROM crdordco,   
					inamedid  
			WHERE ( crdordco.doco_unidad = inamedid.medi_medida ) and  
					( ( crdordco.doco_g_financiero = :str.g_financiero ) AND  
					( crdordco.doco_empresa = :str.empresa ) AND  
					( crdordco.doco_codigo_oc = :lstr_pase.orden ) AND  
					( crdordco.doco_anno_oc = :li_anno_tr ) )   ;
				if sqlca.sqlcode <> 0 then
					if sqlca.sqlcode = -1 then ls_errtext = ' Descripción del error: '+sqlca.sqlerrtext
					rollback;
					messagebox('Error','Error al recuperar  totales: '+ls_errtext+'.',Exclamation!)
					sqlca.autocommit = true				
					setpointer(Arrow!)
					return
				end if				
			
				  UPDATE crtordco  
					  SET toco_monto_total_orden = :ld_valor  
					WHERE ( crtordco.toco_g_financiero = :str.g_financiero ) AND  
							( crtordco.toco_empresa = :str.empresa ) AND  
							( crtordco.toco_codigo_oc = :lstr_pase.orden ) AND  
							( crtordco.toco_anno_oc = :li_anno_tr )   ;
				if sqlca.sqlcode <> 0 then
					if sqlca.sqlcode = -1 then ls_errtext = ' Descripción del error: '+sqlca.sqlerrtext
					rollback;
					messagebox('Error','Error al guardar totales: '+ls_errtext+'.',Exclamation!)
					sqlca.autocommit = true				
					setpointer(Arrow!)
					return
				end if						
			
			commit;
			
			messagebox("Atención","El Pase Finalizó con Éxito",Information!)
		   
			UPDATE crtconfi  
	     	 SET 	 tcof_estado = 'S'  
			WHERE ( tcof_g_financiero = :str.g_financiero ) AND
					( tcof_empresa = :str.empresa ) AND
					( tcof_num_conf_oc = :ls_codigo ) and
					( tcof_anno_oc=:li_anno);
					
				closewithreturn(this,lstr_pase)
		else
			rollback;
			messagebox('Error','¡No se actualizó la información!',Exclamation!)
			setpointer(Arrow!)
			return
		end if
	else
		rollback;
		messagebox('Error','¡No se actualizó la información!',Exclamation!)
		setpointer(Arrow!)
		return
	end if
Else
	rollback;
	messagebox('Atención','Proceso Interrumpido. No se actualizó la información!',Exclamation!)
	setpointer(Arrow!)
	Return
	dw_2.Reset()
	dw_3.Reset()
End If

end subroutine

on w_cz_pases_confirmacion.create
int iCurrent
call super::create
this.gb_4=create gb_4
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_1=create st_1
this.pb_1=create pb_1
this.dw_3=create dw_3
this.gb_3=create gb_3
this.pb_2=create pb_2
this.pb_3=create pb_3
this.dw_5=create dw_5
this.dw_6=create dw_6
this.dw_2=create dw_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_4=create dw_4
this.dw_7=create dw_7
this.st_2=create st_2
this.st_3=create st_3
this.dw_8=create dw_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.dw_3
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.pb_2
this.Control[iCurrent+9]=this.pb_3
this.Control[iCurrent+10]=this.dw_5
this.Control[iCurrent+11]=this.dw_6
this.Control[iCurrent+12]=this.dw_2
this.Control[iCurrent+13]=this.cb_1
this.Control[iCurrent+14]=this.cb_2
this.Control[iCurrent+15]=this.dw_4
this.Control[iCurrent+16]=this.dw_7
this.Control[iCurrent+17]=this.st_2
this.Control[iCurrent+18]=this.st_3
this.Control[iCurrent+19]=this.dw_8
end on

on w_cz_pases_confirmacion.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.pb_1)
destroy(this.dw_3)
destroy(this.gb_3)
destroy(this.pb_2)
destroy(this.pb_3)
destroy(this.dw_5)
destroy(this.dw_6)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_4)
destroy(this.dw_7)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_8)
end on

event ue_post_open;// Override//
string	ls_mascara
int ll_are[] = {1}

lstr_pase= Message.PowerObjectParm

is_tipo = gf_tipo_inventario()

if mid(is_tipo,1,5) = 'Error' then
	mensaje('Error','No se recuperó el Tipo de Inventario.','Descripción del '+is_tipo)
	close(this)
	return
end if

if isnull(is_tipo) or trim(is_tipo) = '' then
	messagebox('Atención','No se ha definido el tipo de Inventario. Usted no podrá continuar.',StopSign!)
	close(this)
	return
end if

if is_tipo <> 'S' then dw_3.Object.pasado.Edit.DisplayOnly = 'yes'

dw_1.SetTransObject(sqlca)
dw_2.SetTransObject(sqlca)
dw_4.SetTransObject(sqlca)
dw_5.SetTransObject(sqlca)
dw_6.SetTransObject(sqlca)
dw_8.SetTransObject(sqlca)

dw_8.insertrow(1)

dw_1.getchild('tcof_cod_tipo_pago',idwchild2)
idwchild2.SetTransObject(sqlca)
if idwchild2.Retrieve(str.g_financiero,str.empresa) = 0 then
	idwchild2.InsertRow(0)
end if

dw_2.getchild('dcof_tipo_compra',idwchild3)
idwchild3.SetTransObject(sqlca)
if idwchild3.Retrieve(ll_are) = 0 then
	idwchild3.InsertRow(0)
end if

dw_4.Getchild("proveedor",idwchild4)
idwchild4.settransobject(sqlca)
if idwchild4.Retrieve(str.g_financiero,str.empresa) = 0 then
	dw_4.insertrow(0)
end if

dw_4.setfocus()

// Para asignarle la cantidad de decimales que se utilizarán - 19/02/2001.
ls_mascara = gf_cr_mascara_dec()
dw_2.modify("dcof_precio_u.editmask.mask='"+ls_mascara+"'")
dw_2.object.formato.expression = "'"+ls_mascara+"'"

dw_3.modify("dcof_precio_u.editmask.mask='"+ls_mascara+"'")
dw_3.object.formato.expression = "'"+ls_mascara+"'"


pb_3.picturename = str.path+"\ART\pasar_rp.bmp"


end event

event open;//OverRide
gf_center_win(This)
gf_acelerador()
dw = dw_1

This.Icon = str.icono

THIS.SetToolbar(1, true, alignattop!)
THIS.SetToolbarPos(1, 1, 50, false)
this.y = 280
this.x = 120

this.postevent("ue_post_open")

end event

event ue_aceptar;// OverRide

end event

event close;call super::close;if trim(lstr_pase.orden) = '' or isnull(lstr_pase.orden) then
	setnull(lstr_pase.orden)
	Closewithreturn(this, lstr_pase)
end if
end event

event resize;//Override
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_cz_pases_confirmacion
integer y = 1560
string text = "w_cr_pases_confirmación"
end type

type dw_1 from w_fa_padre`dw_1 within w_cz_pases_confirmacion
integer x = 146
integer y = 120
integer width = 2743
integer height = 316
string dataobject = "dw_co_cz_confi_pasar1"
boolean vscrollbar = true
boolean border = true
boolean livescroll = true
end type

event dw_1::clicked;String	ls_orden , ls_producto
decimal{2} ld_costos
Integer	li_ano, i
dw_1.accepttext()

If this.RowCount() < 1 Or Row = 0 then return

this.SelectRow(0,false)
this.SelectRow(row,true)
pb_1.text = "Pasar Todos"
ls_orden = dw_1.GetitemString(row ,"tcof_num_conf_oc")
li_ano = dw_1.GetitemNumber(row ,"tcof_anno_oc")
this.SetRedraw(False)

if dw_2.Retrieve(str.g_financiero,str.empresa,ls_orden,li_ano) > 0 then

end if
this.SetRedraw(True)

idw_cual = this
pb_2.enabled = false

end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;//Recupera los datos del detalle haciendo referencia al encabezado

String	ls_orden
Integer	li_ano, li_rows

this.SelectRow(0,false)
this.SelectRow(currentrow,true)

li_rows = this.RowCount()

If this.RowCount() < 1 Or currentrow = 0 then return

If currentrow = this.GetRow() Then
	ls_orden = GetitemString(currentrow ,"tcof_num_conf_oc")
	li_ano = GetitemNumber(currentrow ,"tcof_anno_oc")
	parent.SetRedraw(False)
	dw_2.Retrieve(str.g_financiero,str.empresa,ls_orden,li_ano)
	parent.SetRedraw(true)
End IF

end event

type gb_4 from groupbox within w_cz_pases_confirmacion
integer x = 3058
integer y = 1200
integer width = 283
integer height = 220
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
long backcolor = 67108864
string text = "Actualizar"
end type

type gb_2 from groupbox within w_cz_pases_confirmacion
integer x = 9
integer y = 448
integer width = 2985
integer height = 496
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Detalle "
end type

type gb_1 from groupbox within w_cz_pases_confirmacion
integer x = 123
integer y = 72
integer width = 2775
integer height = 376
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Encabezado"
end type

type st_1 from statictext within w_cz_pases_confirmacion
integer x = 101
integer y = 8
integer width = 311
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean enabled = false
string text = "Proveedor:"
alignment alignment = right!
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_cz_pases_confirmacion
integer x = 3026
integer y = 608
integer width = 361
integer height = 108
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
string text = "&Pasar Todos"
end type

event clicked;parent.Triggerevent("ue_seleccion")

end event

type dw_3 from datawindow within w_cz_pases_confirmacion
event ue_enter pbm_dwnprocessenter
integer x = 23
integer y = 1016
integer width = 2962
integer height = 424
integer taborder = 100
string dataobject = "dw_co_cz_confipasar"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event ue_enter;send(handle(this),256,9,long(0,0))
return 1
end event

event clicked;string	ls_parte_si
long		ll_cantidad=0, ld_fraccion
integer	li_fila

idw_cual = this
dw_1.accepttext()

pb_2.Text = "Retornar"
pb_2.enabled = true

this.SelectRow(0,false)
this.SelectRow(row,true)

// Gianni Araúz y Mayté Aparicio (02/05/2000)
// Abrir la ventana de desglose para el pase

if row < 1 then return

if dwo.name = 'pasado' then
//if is_tipo = 'S' then return // Humberto
if is_tipo <> 'D' then return // Humberto
	this.object.desglose[row] = 'S'
	li_fila = row
	str_datos.opcion = 'PEA'
	str_datos.parte = this.GetItemString(row,'dcof_board')
	if len(trim(str_datos.parte)) > 0 then ls_parte_si += ' / '
	str_datos.cod_color = this.GetItemString(row,'dcof_color')
	str_datos.medida = this.GetItemString(row,'dcof_unidad')
	str_datos.concepto = this.GetItemString(row,'dcof_num_conf_oc')
	str_datos.fecha = dw_1.GetItemDateTime(dw_1.getrow(),'tcof_fecha_conf_oc')
	str_datos.anio = dw_1.GetItemNumber(dw_1.getrow(),'tcof_anno_oc')
	str_datos.renglon = this.GetItemNumber(row,'dcof_num_ren_confi')
	str_datos.fila = li_fila
	str_datos.cantidad_max = this.GetItemNumber(row,'dcof_cantidad_total')
	ld_fraccion = this.GetItemNumber(row,'dcof_cant1')
	if isnull(ld_fraccion) then ld_fraccion = 0
	str_datos.fraccion_max = ld_fraccion
	str_datos.unid_medida = str_datos.medida
	str_datos.producto = this.GetItemString(row,'dcof_producto')

	select medi_cantidad
	into :str_datos.med_cant
	from inamedid
	where medi_medida = :str_datos.medida;
	
	if sqlca.sqlcode = -1 then
		messagebox('Error','Descripción del error: '+sqlca.sqlerrtext)
		return
	elseif sqlca.sqlcode = 100 then
		messagebox('Atención','No se recuperó la unidad de medida en cantidad.',Exclamation!)
		return
	end if
	
	if isnull(str_datos.med_cant) or str_datos.med_cant = 0 then
		messagebox('Atención','No se ha definido la unidad de medida en cantidad.',Exclamation!)
		return
	end if
	//openwithparm(w_cr_man_desglose,str_datos)
	
	ll_cantidad = message.doubleparm
	
	if ll_cantidad > 0 then
		this.SetItem(li_fila,'pasado',ll_cantidad)
		this.SetItem(li_fila,'fpasado',ld_fraccion)
		this.setfocus()
	end if
end if

end event

event itemchanged;long		ll_row,ll_ordenado,ll_totvenpas,ll_pasado, ll_cantidad
string	ls_nomcolumna,ls_uni, ls_producto
decimal {4} ld_cantidad_total_empaque, ld_peso
integer  li_bultos
str_in_parte str_parte

ll_row = this.Rowcount()
ls_nomcolumna = dwo.name

If ll_row < 0 then return

Choose Case  ls_nomcolumna
	Case "dcof_cantidad_total"
		il_cantidad = long(trim(data))
	case "pasado"
		
		ls_producto = this.getitemstring(row, 'dcof_producto')
		
		SELECT prod_producto,
				prod_medida,
				prod_peso,
				prod_cubicaje,
				prod_status,
				prod_board,
				prod_color,
				prod_cod_clase_tam,
				prod_descripcion,
	             a.medi_cantidad,
				prod_empaque,
				b.medi_cantidad
		INTO  :str_parte.producto,
				:str_parte.medida,
				:str_parte.peso,
				:str_parte.cubicaje,
				:str_parte.status,
				:str_parte.parte,
				:str_parte.color,
				:str_parte.cod_clase_tam,
				:str_parte.descripcion,
				:str_parte.cant_unidad,
				:str_parte.empaque,
				:str_parte.cant_unidad_empaque
		FROM inmprodu, 
			  inamedid a,
			  inamedid b
		WHERE (prod_medida = a.medi_medida) AND
				(prod_empaque_um = b.medi_medida) AND
				(prod_g_financiero =:str.g_financiero) AND
				(prod_empresa = :str.empresa) AND
				(prod_producto = :ls_producto) ;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error # '+string(sqlca.sqldbcode),'No se recuperaron los datos de los '+&
			'de los productos. Descripción del error: '+sqlca.sqlerrtext+'.')
			return
		elseif sqlca.sqlcode = 100 then
			messagebox('Atención','Este producto no existe '+ls_producto+ '  '+sqlca.sqlerrtext,Exclamation!)
			return 1
		end if

		ll_cantidad = long(data)		
		ld_cantidad_total_empaque = (str_parte.empaque * str_parte.cant_unidad_empaque)
		if ld_cantidad_total_empaque = 0 then ld_cantidad_total_empaque = 1
		li_bultos = ( ll_cantidad * str_parte.cant_unidad ) / ld_cantidad_total_empaque
		ld_peso = str_parte.peso * li_bultos
		setitem(row,'crdconfi_dcof_bultos',li_bultos)
		setitem(row,'crdconfi_dcof_peso_neto',ld_peso)
		setitem(row,'crdconfi_dcof_peso_bruto',ld_peso)
		
End Choose

ls_uni       = This.GetitemString(row,"dcof_unidad")
ll_ordenado  = This.GetitemNumber(row,"dcof_cantidad_total")
ll_pasado    = This.GetitemNumber(row,"pasado")
ll_totvenpas = ll_ordenado - ll_pasado

end event

type gb_3 from groupbox within w_cz_pases_confirmacion
integer x = 9
integer y = 956
integer width = 2985
integer height = 496
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Pase "
end type

type pb_2 from picturebutton within w_cz_pases_confirmacion
integer x = 3026
integer y = 984
integer width = 361
integer height = 108
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
string text = "&Retornar"
end type

event clicked;parent.Triggerevent("ue_seleccion")
end event

type pb_3 from picturebutton within w_cz_pases_confirmacion
integer x = 3099
integer y = 1260
integer width = 192
integer height = 136
integer taborder = 150
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\Harr2000\ART\pasar_rp.bmp"
end type

event clicked;integer		li_fila, li_anio, li_renglon, li_flag, li_year[]
string		ls_numconf, ls_producto, ls_board, ls_color, ls_find, ls_num_conf[],	ls_proceso,ls_error
long			ll_filas, ll_find, ll_cantpend

if dw_3.rowcount() = 0 then return
	SELECT crmparam.mpar_tipo_proceso_compra  
	INTO :ls_proceso  
	FROM crmparam  
	WHERE ( crmparam.mpar_g_financiero = :str.g_financiero ) AND  
			( crmparam.mpar_empresa = :str.empresa )   ;
	
	If not sqlca.sqlcode = 0 then
		ls_error = sqlca.sqlerrtext
		rollback;
		messagebox("Error","Verifique el proceso de Compras. "+ls_error)
		return
	End If

	if ls_proceso = 'CO' then
		lstr_pase.orden  = w_cz_ma_transito.is_numero_oc
	else
		//lstr_pase.orden  = w_cz_ma_transito_natmendez.is_numero_oc
	end if

// Proceso para validar el aumento o disminución de la Cantidad de Pase o Pendiente

dw_3.accepttext()

//if is_tipo <> 'S' then //Prueba
if is_tipo = 'D' then
	for li_fila = 1 to dw_3.rowcount()
		if dw_3.object.desglose[li_fila] = 'N' then
			ls_numconf = dw_3.getitemstring(li_fila,'dcof_num_conf_oc')
			li_anio = dw_3.getitemnumber(li_fila,'dcof_anno_oc')
			li_renglon = dw_3.getitemnumber(li_fila,'dcof_num_ren_confi')
			ls_producto = dw_3.getitemstring(li_fila,'dcof_producto')
			ls_board = dw_3.getitemstring(li_fila,'dcof_board')
			if isnull(ls_board) then ls_board = ' '
			ls_color = dw_3.getitemstring(li_fila,'dcof_color')
			
			ls_find = 'dcoc_g_financiero = '+string(str.g_financiero)+' and dcoc_empresa = '+&
						string(str.empresa)+" and dcoc_num_conf_oc = '"+ls_numconf+"' and "+&
						'dcoc_anno_oc = '+string(li_anio)+' and dcoc_renglon = '+string(li_renglon)+&
						" and dcoc_producto = '"+ls_producto+"' and dcoc_board = '"+ls_board+"'"+&
						" and dcoc_color = '"+ls_color+"'"
			
			li_flag = 0
			ll_find = 1
			ll_filas = dw_5.Rowcount()
			ll_find = dw_5.find(ls_find,ll_find,ll_filas)
			
			do while ll_find > 0
				li_flag = 1
				ll_cantpend = dw_5.getitemnumber(ll_find,'dcoc_cant_pendiente')
				dw_5.setitem(ll_find,'dcoc_cant_pase',ll_cantpend)
				dw_5.setitem(ll_find,'dcoc_cant_pendiente',0)
				dw_5.setitem(ll_find,'dcoc_ultimo_pase',ll_cantpend)
				ll_find++
				if ll_find > ll_filas then exit
				ll_find = dw_5.find(ls_find,ll_find,ll_filas)
			loop
			
			if li_flag = 0 then
				rollback;
				messagebox('Atención','No se asignaron correctamente las Cantidades del Desglose.',Exclamation!)
				return
			end if
			
			if ll_find < 0 then
				rollback;
				messagebox('Atención','No se encontraron las Cantidades del Desglose.',Exclamation!)
				return
			end if
		end if
	next
end if

parent.TriggerEvent("ue_facturar")

end event

type dw_5 from datawindow within w_cz_pases_confirmacion
boolean visible = false
integer x = 1513
integer y = 1408
integer width = 146
integer height = 116
integer taborder = 120
boolean bringtotop = true
string dataobject = "dw_cr_pase_confirm_desgl"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_6 from datawindow within w_cz_pases_confirmacion
boolean visible = false
integer x = 1298
integer y = 1408
integer width = 146
integer height = 116
integer taborder = 130
boolean bringtotop = true
string dataobject = "dw_cr_pase_transito_desgl"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_cz_pases_confirmacion
integer x = 23
integer y = 504
integer width = 2949
integer height = 424
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_co_cz_detpasar_confi"
boolean vscrollbar = true
boolean border = false
end type

event clicked;idw_cual = this
pb_1.Text = "Pasar"
pb_2.enabled = false

If row = 0 then Return
this.SelectRow(0,FALSE)
this.SelectRow(row,TRUE)

end event

event retrieveend;String  	ls_item, ls_orden, ls_codigo, ls_filtro
long  	ll_anno,ll_linea, ll_unimin, ll_c,ll_i
Integer 	li_rows
Double 	ld_cant_frac
decimal{2} ld_costos

setpointer(hourglass!)

for ll_i = 1 to rowcount
	ld_costos = dw_2.getitemnumber(ll_i,'prod_costos')
	if isnull(ld_costos) then ld_costos = 0
	if ld_costos > 0 then
		dw_2.setitem(ll_i,'dcof_precio_original',dw_2.getitemnumber(ll_i,'dcof_precio_u'))
		dw_2.setitem(ll_i,'dcof_precio_u',ld_costos)
	end if	
next

li_rows = dw_3.RowCount()

If dw_2.RowCount() > 0 then
	li_rows = this.RowCount()
	
	For ll_c = 1 to dw_3.RowCount()
		ls_orden  = dw_3.getItemString(ll_c,"dcof_num_conf_oc")
		ll_anno   = dw_3.getItemNumber(ll_c,"dcof_anno_oc")
		ll_linea  = dw_3.getItemNumber(ll_c,"dcof_num_ren_confi")
		ls_codigo = dw_3.getItemString(ll_c,"dcof_producto")
		
		For ll_i = 1 to li_rows			
			
			If dw_2.Getitemstring(ll_i,"dcof_producto") = ls_codigo AND &
				dw_2.Getitemnumber(ll_i,"dcof_num_ren_confi") = ll_linea AND &
				dw_2.Getitemnumber(ll_i,"dcof_anno_oc") = ll_anno AND &
				dw_2.GetitemString(ll_i,"dcof_num_conf_oc") = ls_orden Then
				dw_2.Deleterow(ll_i)
				ll_i = ll_i - 1
				li_rows = this.RowCount()
				ls_filtro = 'dcof_num_ren_confi = ' + string (ll_linea) + ' And dcof_anno_oc = ' +&
								 string (ll_anno) + ' And dcof_num_conf_oc = "' + ls_orden + '"'
				dw_2.SetFilter (ls_filtro)
				dw_2.Filter ()
	
				Do While dw_2.RowCount() > 0
					dw_2.DeleteRow(0)
				Loop
				dw_2.SetFilter ('')
				dw_2.Filter ()
			End IF
		Next
	Next
End If
setpointer(arrow!)

end event

type cb_1 from commandbutton within w_cz_pases_confirmacion
boolean visible = false
integer x = 2190
integer y = 1420
integer width = 302
integer height = 88
integer taborder = 140
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Mostrar"
end type

event clicked;dw_5.x = 59
dw_5.y = 576
dw_5.width = 2007
dw_5.height = 948

dw_5.visible = true
dw_5.bringtotop = true

end event

type cb_2 from commandbutton within w_cz_pases_confirmacion
boolean visible = false
integer x = 2505
integer y = 1420
integer width = 302
integer height = 88
integer taborder = 150
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Ocultar"
end type

event clicked;dw_5.visible = false

end event

type dw_4 from datawindow within w_cz_pases_confirmacion
integer x = 421
integer width = 1038
integer height = 80
integer taborder = 20
string dataobject = "dw_co_extproveedor"
boolean border = false
boolean livescroll = true
end type

event itemchanged;long		ll_provee
int		li_fila, li_year[]
string	ls_numconf[]

ll_provee = long(data)

dw_2.Reset()
dw_3.Reset()

If dw_1.Retrieve(str.g_financiero,str.empresa,ll_provee) > 0 Then
	pb_3.picturename = str.path+"\ART\pasar_rp.bmp"
	pb_3.enabled = true
end if

end event

type dw_7 from uos_in_datawindow_utility within w_cz_pases_confirmacion
integer x = 1897
integer width = 498
integer height = 80
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_cr_filtro_pases_conf"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event editchanged;call super::editchanged;if trim(data) <> '' then
	dw_2.setfilter("dcof_producto like '"+data+"%'")
	dw_2.filter()
else
	dw_2.setfilter('')
	dw_2.filter()
end if

end event

type st_2 from statictext within w_cz_pases_confirmacion
integer x = 1477
integer y = 4
integer width = 407
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
string text = "Filtrar Producto:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_cz_pases_confirmacion
integer x = 2427
integer y = 16
integer width = 361
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
string text = "Confirmación:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_8 from datawindow within w_cz_pases_confirmacion
integer x = 2802
integer y = 8
integer width = 736
integer height = 80
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_co_cz_confirmacion"
boolean border = false
boolean livescroll = true
end type

event editchanged;if trim(data) <> '' then
	dw_1.setfilter("tcof_num_conf_oc like '"+upper(data)+"%'")
	dw_1.filter()
else
	dw_1.setfilter('')
	dw_1.filter()
end if
end event

event itemchanged;//string	ls_orden,ls_filtro
//
//ls_orden = this.GetitemString(row,"tcof_num_conf_oc") 
//
//ls_filtro = "tcof_num_conf_oc = '" + ls_orden + "'"
//
//dw_1.SetFilter (ls_filtro)
//dw_1.Filter ()
string	ls_filtro

if not isnull(data) and trim(data) <> '' then
	ls_filtro = "upper(tcof_num_conf_oc) like '"+upper(data)+"%'"
	
	dw_1.SetFilter(ls_filtro)
	dw_1.Filter()
else
	dw_1.SetFilter('')
	dw_1.Filter()
end if
end event

type st_ayuda from w_fa_padre`st_ayuda within w_cz_pases_confirmacion
end type

