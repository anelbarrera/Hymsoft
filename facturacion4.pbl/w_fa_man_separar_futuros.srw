//objectcomments Para Poner como pasado un pedido
forward
global type w_fa_man_separar_futuros from w_fa_padre
end type
type gb_anio from groupbox within w_fa_man_separar_futuros
end type
type cb_1 from commandbutton within w_fa_man_separar_futuros
end type
type cb_2 from commandbutton within w_fa_man_separar_futuros
end type
type st_1 from statictext within w_fa_man_separar_futuros
end type
type st_2 from statictext within w_fa_man_separar_futuros
end type
type em_pedido from editmask within w_fa_man_separar_futuros
end type
end forward

global type w_fa_man_separar_futuros from w_fa_padre
integer width = 1403
integer height = 816
string title = " Separar Futuros"
string menuname = "m_hs"
boolean controlmenu = false
long backcolor = 79741120
event ue_enter pbm_dwndragenter
gb_anio gb_anio
cb_1 cb_1
cb_2 cb_2
st_1 st_1
st_2 st_2
em_pedido em_pedido
end type
global w_fa_man_separar_futuros w_fa_man_separar_futuros

type variables
// Para el filtro de la unidad
datawindowchild idwc_tipo, dwc_fac_pedi
String is_ped_sel, is_fact_sel, is_tipo_repl,is_tipo_sel, is_pedido_repl, is_user
Integer ii_ann_sel, ii_ann_repl
end variables

forward prototypes
public subroutine wf_setear_user (string as_user)
public subroutine wf_botones ()
public subroutine wf_actualiza_reservados ()
end prototypes

public subroutine wf_setear_user (string as_user);//se asigna el usuario desde la ventana de clave con Dynamic
is_user = as_user
end subroutine

public subroutine wf_botones ();//// Deshabilita la opcion de insertar del menu 

//   /*Insertar*/
//	m_fa_padre.m_edicin.m_insertar.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_insertar.visible=false
	
//	/*Filtrar*/
//	m_fa_padre.m_edicin.m_filtrar.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_filtrar.visible=false
	
//	/*Sortear*/
//	m_fa_padre.m_edicin.m_sortear.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_sortear.visible=false
	
//  /*Imprimir*/
//   m_fa_padre.m_archivo.m_imprimir.toolbaritemvisible=false
//	m_fa_padre.m_archivo.m_imprimir.visible=false

	
	
//	/*Eliminar*/
////	m_fa_padre.m_edicin.m_eliminar.toolbaritemvisible=false
////	
	
////	/*Adicionar*/
////	m_fa_padre.m_edicin.m_adicionar.toolbaritemvisible=false
////	
	
////	/*Primer Reg*/
////	m_fa_padre.m_edicin.m_primerregistro.toolbaritemvisible=false
////	
	
////	/*Ultimo Reg*/
////	m_fa_padre.m_edicin.m_ultimoregistro.toolbaritemvisible=false
////	
	
	
////	/*Sig Reg*/
////	m_fa_padre.m_edicin.m_siguienteregistro.toolbaritemvisible=false
////	
	
////	/*Reg Ant*/
////	m_fa_padre.m_edicin.m_registroanterior.toolbaritemvisible=false
////	
	
////	

  


end subroutine

public subroutine wf_actualiza_reservados ();string ls_error

//mensaje("Atención","Sr. Usuario, procure que al Ejecutar este Proceso, ningún usuario esté utilizando los Archivos de Facturación o Inventario, ya que se puede Bloquear la Base de datos e Incurrir en la Perdida de Datos.","")

//if gf_mensaje("","¿ Está seguro de Actualizar los Productos Reservados ? ",2,1,"E") = 1 then

// str.frame.setmicrohelp("Inicializando los Productos Reservados.............por favor Espere")

 sqlca.autocommit = false
  
//str.frame.setmicrohelp("Actualizando los Productos Reservados.............por favor Espere")

/*Actualiza los reservados del producto, procedentes de pedidos*/
  UPDATE inmprodu  
     SET prod_reserva_total = vi_reserva.reservado  
    FROM inmprodu,   
         vi_reserva  
   WHERE ( inmprodu.prod_g_financiero = vi_reserva.dped_g_financiero ) AND  
         ( inmprodu.prod_empresa = vi_reserva.dped_empresa ) AND  
         ( inmprodu.prod_producto = vi_reserva.dped_codigo_item )   ;
	  if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje("Aviso","Error al Actualizar las Reservas de los Productos ",ls_error)
		sqlca.autocommit = true
		return
	  end if

/*Actualiza los reservados del producto, procedentes de factura*/
  UPDATE inmprodu  
     SET prod_reserva_total = prod_reserva_total + vi_reserva_fac.reservado
    FROM inmprodu,   
         vi_reserva_fac  
   WHERE ( inmprodu.prod_g_financiero = vi_reserva_fac.facd_g_financiero ) AND  
         ( inmprodu.prod_empresa = vi_reserva_fac.facd_empresa ) AND  
         ( inmprodu.prod_producto = vi_reserva_fac.facd_codigo_item )   ;
			
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
         ( fadpedid.dped_unidad_venta = inamedid.medi_medida )  and
			( fadpedid.dped_g_financiero = :str.g_financiero ) and
			( fadpedid.dped_empresa	= :str.empresa );
			
	  if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje("Aviso","Error al Actualizar las Cantidades Pasadas",ls_error)
		sqlca.autocommit = true
		return
	  end if

/*Actualiza los reservados por bodega, procedentes de factura*/
// str.frame.setmicrohelp("Actualizando los Productos Reservados por Bodega.............por favor Espere")

  UPDATE inmbodeg  
     SET mbod_reserva = vi_reserva_fac_bodega.reservado
    FROM inmbodeg,   
         vi_reserva_fac_bodega  
   WHERE ( inmbodeg.mbod_g_financiero = vi_reserva_fac_bodega.facd_g_financiero ) AND  
         ( inmbodeg.mbod_empresa = vi_reserva_fac_bodega.facd_empresa ) AND  
         ( inmbodeg.mbod_bodega = vi_reserva_fac_bodega.facd_bodega ) AND  
         ( inmbodeg.mbod_ubicacion = vi_reserva_fac_bodega.facd_ubicacion ) AND  
         ( inmbodeg.mbod_producto = vi_reserva_fac_bodega.facd_codigo_item )   ;
			
	  if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje("Aviso","Error al Actualizar las Reservas de productos por bodega ",ls_error)
		sqlca.autocommit = true
		return
	  end if
			

/*Actualiza los reservados por bodega, procedentes de pedidos*/
  UPDATE inmbodeg  
     SET mbod_reserva = mbod_reserva  +  vi_reserva_ped_bodega.reservado
    FROM inmbodeg,   
         vi_reserva_ped_bodega  
   WHERE ( inmbodeg.mbod_g_financiero = vi_reserva_ped_bodega.dped_g_financiero ) AND  
         ( inmbodeg.mbod_empresa = vi_reserva_ped_bodega.dped_empresa ) AND  
         ( inmbodeg.mbod_bodega = vi_reserva_ped_bodega.dped_bodega ) AND  
         ( inmbodeg.mbod_ubicacion = vi_reserva_ped_bodega.dped_ubicacion ) AND  
         ( inmbodeg.mbod_producto = vi_reserva_ped_bodega.dped_codigo_item )   ;
	  if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje("Aviso","Error al Actualizar las Reservas de productos por bodega ",ls_error)
		sqlca.autocommit = true
		return
	  end if
	
	
	//Si no manda error , guarda en la base de datos
	
	commit;

	sqlca.autocommit = true	
	
//	gf_mensaje("","Actualización Exitosa de los Reservados",1,1,"E")
	
//end if //Del messagebox Aceptar o Cancelar
end subroutine

on w_fa_man_separar_futuros.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.gb_anio=create gb_anio
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_1=create st_1
this.st_2=create st_2
this.em_pedido=create em_pedido
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_anio
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.em_pedido
end on

on w_fa_man_separar_futuros.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_anio)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_pedido)
end on

event ue_post_open;//Override
string	ls_filtro
is_nombre = This.ClassName()

st_nom_ventana.text = is_nombre

//OpenWithParm(w_fa_man_clave_pedido, this)

//If is_user = "*" then
//	close(this)
//else	

//sle_ann.text = string(year(date(gf_fecha_serv())))
		
dw_1.settransobject(sqlca)
dw_1.GetChild ("pedi_no_pedido",dwc_fac_pedi)
dwc_fac_pedi.Settransobject(SQLCA)
dwc_fac_pedi.retrieve(str.g_financiero,str.empresa)
dw_1.SetFocus()

end event

event show;
wf_botones()

end event

event closequery;constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)

This.SetRedraw(false)
end event

event resize;//Override
end event

event close;close(This)
Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
 
end event

event open;//gf_center_win(This)
//gf_acelerador()
dw = dw_1

This.Icon = str.icono

this.postevent("ue_post_open")

end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_man_separar_futuros
boolean visible = false
integer x = 37
integer y = 436
integer width = 709
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_man_separar_futuros
event ue_filtra_unidad ( )
integer x = 366
integer y = 160
integer width = 599
integer height = 88
string dataobject = "dw_ma_fa_pedido_a_separar"
boolean livescroll = true
end type

event dw_1::getfocus;dw = dw_1


end event

event dw_1::rbuttondown;//
end event

event dw_1::itemchanged;is_tipo_repl = data
long ll_pedido
string ls_pedido
integer li_existe, li_ann

li_ann = year(date(gf_fecha_serv()))

  SELECT faaparam.fara_ult_pedido  
    INTO :ls_pedido  
    FROM faaparam  
   WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
         ( faaparam.fara_empresa = :str.empresa )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al Buscar Secuencia '+sqlca.sqlerrtext,1,1,'E')
		return
	end if
	
	li_existe = 1
	do while li_existe > 0
		ll_pedido = long(ls_pedido) + 1
		ls_pedido = string(ll_pedido)
		
		  SELECT count(*)  
			 INTO :li_existe  
			 FROM fatpedid  
			WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
					( fatpedid.pedi_empresa = :str.empresa )  AND
					( fatpedid.pedi_no_pedido = :ls_pedido )  AND
					( fatpedid.pedi_ann = :li_ann )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Buscar Existencia '+sqlca.sqlerrtext,1,1,'E')
					return
				end if
			if li_existe = 0 then
				exit
			end if
		
	loop
	
	em_pedido.text = ls_pedido
	
end event

event dw_1::ue_down;//
end event

event dw_1::ue_entercol;//
end event

event dw_1::ue_escape;//
end event

event dw_1::ue_tabfinal;//
end event

event dw_1::itemfocuschanged;//
end event

event dw_1::clicked;//
end event

event dw_1::ue_microayuda;//Override
end event

type st_ayuda from w_fa_padre`st_ayuda within w_fa_man_separar_futuros
end type

type gb_anio from groupbox within w_fa_man_separar_futuros
integer x = 27
integer width = 1321
integer height = 468
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
end type

type cb_1 from commandbutton within w_fa_man_separar_futuros
integer x = 722
integer y = 504
integer width = 279
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
boolean default = true
end type

event clicked;String ls_no_pedido,ls_no_factura, ls_tipo_fac, ls_error, ls_restaurado_por, ls_sqlerrtext, ls_pedido_nuevo
Integer li_linea, i = 0, li_existe
long ll_anio, ll_dias_pago
Boolean	lb_validado,lb_salvo
lb_validado = true
lb_salvo = false
date		ldt_fecha, ldt_fecha_servidor
datetime ldt_fecha_fin_plazo

if gf_mensaje("","¿Está Seguro de Separar las Referencias Futuras del Pedido Seleccionado?",2,1,"E") = 1 then
	
	ls_no_pedido = dwc_fac_pedi.GetItemString   (dwc_fac_pedi.Getrow(),"pedi_no_pedido")
	ll_anio		  = dwc_fac_pedi.GetItemNumber(dwc_fac_pedi.Getrow(),"pedi_ann")
	
	ls_pedido_nuevo = em_pedido.text
	
//	ldt_fecha = date(gf_fecha_serv())
//	ls_restaurado_por = str.usuario+"-"+string(ldt_fecha)
	
 ldt_fecha_servidor = date(gf_fecha_serv())
	
  sqlca.autocommit = false

	 DECLARE futuros CURSOR FOR  
	  SELECT fadpedid.dped_linea  
		 FROM fadpedid  
		WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
				( fadpedid.dped_empresa = :str.empresa ) AND  
				( fadpedid.dped_no_pedido = :ls_no_pedido ) AND  
				( fadpedid.dped_ann = :ll_anio ) AND  
				( fadpedid.dped_reserva_origen <> 'E' )  ;

	 if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al Declarar el cursor ",ls_error)
			sqlca.autocommit = true
			return		 
	 end if
	 
	 open futuros ;
	 
	 fetch futuros into :li_linea ;
	 
//	 messagebox(string(sqlca.sqlcode),sqlca.sqlerrtext)
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al recuperar linea",ls_error)
			sqlca.autocommit = true
			return
		end if					

	do while sqlca.sqlcode = 0
		i ++	//para guardar como numero de linea
	//Creacion del encabezado y copia de las lineas
	//validar que no exista el pedido
		if i = 1 then //si es la primera linea
			
			select isnull(count(*) ,0)
			into :li_existe
			from fatpedid
			where ( fatpedid.pedi_g_financiero = :str.g_financiero ) and
					( fatpedid.pedi_empresa = :str.empresa ) AND  
					 ( fatpedid.pedi_ann = :ll_anio ) AND 
					( fatpedid.pedi_no_pedido = :ls_pedido_nuevo ) ;
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso","Error al Validar existencia",ls_error)
				sqlca.autocommit = true
				return
			end if
	
			if li_existe = 0 then //Si no esta creado el encabezado
			
				  select pedi_dias_pago
				  into :ll_dias_pago
				  from fatpedid
				  WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
						  ( fatpedid.pedi_empresa = :str.empresa ) AND  
						  ( fatpedid.pedi_ann = :ll_anio ) AND  
						  ( fatpedid.pedi_no_pedido = :ls_no_pedido )   ;
					
						if sqlca.sqlcode = -1 then
							ls_sqlerrtext = sqlca.sqlerrtext
							rollback;
							lb_salvo=false
							mensaje("Información","Error al Insertar registro en fatiari",ls_sqlerrtext)
							return
						else
							if sqlca.sqlcode = 0 then
								ldt_fecha_fin_plazo = gf_recupera_dias(ll_dias_pago,date(ldt_fecha_servidor))
							end if
						end if			
			
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
					  pedi_estado,   
					  pedi_autorizacion,   
					  pedi_actualizo_cargos,   
					  pedi_actualizo_vendedor,   
					  pedi_factura_de_bodega,   
					  pedi_fecha_fin_plazo,   
					  pedi_pasado_a_empresa,   
					  pedi_pedido_vta_diaria,   
					  pedi_restaurado_por,   
					  pedi_cuatro_decimales,   
					  pedi_usuario,   
					  pedi_precio_a_utilizar,   
					  pedi_costos_total,
					  pedi_viene_de_pedido)  
			  SELECT fatpedid.pedi_g_financiero,   
						fatpedid.pedi_empresa,   
						fatpedid.pedi_tipo,   
						:ls_pedido_nuevo,   
						:ll_anio,   
						fatpedid.pedi_cliente,   
						fatpedid.pedi_ruc_cliente,   
						fatpedid.pedi_condicion_pago,   
						fatpedid.pedi_tipo_venta,   
						fatpedid.pedi_tipo_movimiento,   
						fatpedid.pedi_no_traspaso,   
						:ldt_fecha_servidor,   
						:ldt_fecha_servidor,
						fatpedid.pedi_fecha_modificacion,   
						fatpedid.pedi_dias_pago,   
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
						0,   
						fatpedid.pedi_monto_total,   
						fatpedid.pedi_descu_subt_deta,   
						fatpedid.pedi_por_descuento,   
						fatpedid.pedi_supervisor,   
						fatpedid.pedi_monto_final,   
						fatpedid.pedi_comentario,   
						'A',   
						fatpedid.pedi_autorizacion,   
						fatpedid.pedi_actualizo_cargos,   
						fatpedid.pedi_actualizo_vendedor,   
						fatpedid.pedi_factura_de_bodega,   
						:ldt_fecha_fin_plazo,   
						fatpedid.pedi_pasado_a_empresa,   
						fatpedid.pedi_pedido_vta_diaria,   
						fatpedid.pedi_restaurado_por,   
						fatpedid.pedi_cuatro_decimales,   
						fatpedid.pedi_usuario,   
						fatpedid.pedi_precio_a_utilizar,   
						fatpedid.pedi_costos_total,
						0
				 FROM fatpedid  
				 WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
						 ( fatpedid.pedi_empresa = :str.empresa ) AND  
						 ( fatpedid.pedi_ann = :ll_anio ) AND  
						 ( fatpedid.pedi_no_pedido = :ls_no_pedido )   ;
		
				if sqlca.sqlcode = -1 then
					ls_sqlerrtext = sqlca.sqlerrtext
					rollback;
					lb_salvo=false
					mensaje("Información","Error al actualizar registro en fatpedid",ls_sqlerrtext)
					return
				end if			
					
				//************************************************
			  INSERT INTO fadvenpe  
						( vped_g_financiero,   
						  vped_empresa,   
						  vped_tipo,   
						  vped_no_pedido,   
						  vped_ann,   
						  vped_vendedor )  
				  SELECT fadvenpe.vped_g_financiero,   
							fadvenpe.vped_empresa,   
						   fadvenpe.vped_tipo,   
							:ls_pedido_nuevo,   
							:ll_anio,   
							fadvenpe.vped_vendedor  
					 FROM fadvenpe  
					 WHERE ( fadvenpe.vped_g_financiero = :str.g_financiero ) AND  
							 ( fadvenpe.vped_empresa = :str.empresa ) AND  
							 ( fadvenpe.vped_ann = :ll_anio ) AND  
							 ( fadvenpe.vped_no_pedido = :ls_no_pedido )   ;
		
					if sqlca.sqlcode = -1 then
						ls_sqlerrtext = sqlca.sqlerrtext
						rollback;
						lb_salvo=false
						mensaje("Información","Error al actualizar registro en fadvenpe",ls_sqlerrtext)
						return
					end if			
				//************************************************
	
					
			end if //De la creacion del encabezado
					
		end if //del i = 1
	//Insert de la linea
	//************************************************
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
				  dped_fecha_reg,   
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
				  dped_costo_total )  
		  SELECT fadpedid.dped_g_financiero,   
					fadpedid.dped_empresa,   
					:ls_pedido_nuevo,   
					:ll_anio,   
					:i,   
					fadpedid.dped_producto_servicio,   
					fadpedid.dped_codigo_item,   
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
					fadpedid.dped_fecha_reg,   
					fadpedid.dped_usuario,   
					fadpedid.dped_supervisor,   
					fadpedid.dped_bultos,   
					fadpedid.dped_ubicacion,   
					0,   
					0,   
					fadpedid.dped_index,   
					fadpedid.dped_validado,   
					fadpedid.dped_vendedor,   
					fadpedid.dped_pedido_vta_detal,   
					fadpedid.dped_promocion,   
					fadpedid.dped_bulto_inicio,   
					fadpedid.dped_bulto_fin,   
					fadpedid.dped_precio_original,   
					fadpedid.dped_reserva_origen,   
					fadpedid.dped_num_orden_compra,   
					fadpedid.dped_ann_orden_compra,   
					fadpedid.dped_num_transito,   
					fadpedid.dped_ann_transito,   
					fadpedid.dped_linea_orden,   
					fadpedid.dped_linea_transito,   
					fadpedid.dped_costo_total  
			 FROM fadpedid  
  		    WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
			    	 ( fadpedid.dped_empresa = :str.empresa ) AND  
				    ( fadpedid.dped_ann = :ll_anio ) AND  
				    ( fadpedid.dped_no_pedido = :ls_no_pedido ) AND
					 ( fadpedid.dped_linea	= :li_linea );

			if sqlca.sqlcode = -1 then
				ls_sqlerrtext = sqlca.sqlerrtext
				rollback;
				lb_salvo=false
				mensaje("Información","Error al actualizar registro en fadpedid",ls_sqlerrtext)
				return
			end if				
	
	/////////////////////////////////
	  Delete from fadpedid  
		  from fadpedid
		WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
				( fadpedid.dped_empresa = :str.empresa ) AND  
				( fadpedid.dped_no_pedido = :ls_no_pedido ) AND  
				( fadpedid.dped_ann = :ll_anio ) AND
				( fadpedid.dped_linea = :li_linea );
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al Eliminar la linea",ls_error)
			sqlca.autocommit = true
			return
		end if
	
	 fetch futuros into :li_linea ;
	 
//	 messagebox(string(sqlca.sqlcode),sqlca.sqlerrtext)
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al recuperar linea",ls_error)
			sqlca.autocommit = true
			return
		end if					
	
	loop

	close futuros ;
//messagebox(string(str.g_financiero)+string(str.empresa),ls_no_pedido+'-'+string( ll_anio)	)
	
	commit;
	
	sqlca.autocommit = true

	if i > 0 then 
		
		//actualiza totales del pedido, el nuevo y el anterior
		  UPDATE fatpedid
		  SET pedi_cubicaje_total = (	select sum( fadpedid.dped_cubicaje) 
												 FROM fadpedid 							
										WHERE ( fatpedid.pedi_g_financiero = fadpedid.dped_g_financiero ) and 
												( fatpedid.pedi_empresa = fadpedid.dped_empresa ) and 
												( fatpedid.pedi_no_pedido = fadpedid.dped_no_pedido ) and 
												( fatpedid.pedi_ann = fadpedid.dped_ann ) ),
		  		pedi_peso_total = (	select sum( fadpedid.dped_peso) 
												 FROM fadpedid 							
										WHERE ( fatpedid.pedi_g_financiero = fadpedid.dped_g_financiero ) and 
												( fatpedid.pedi_empresa = fadpedid.dped_empresa ) and 
												( fatpedid.pedi_no_pedido = fadpedid.dped_no_pedido ) and 
												( fatpedid.pedi_ann = fadpedid.dped_ann ) ),		 		 
		  		pedi_costos_total = (	select sum( fadpedid.dped_costo_total) 
												 FROM fadpedid 							
										WHERE ( fatpedid.pedi_g_financiero = fadpedid.dped_g_financiero ) and 
												( fatpedid.pedi_empresa = fadpedid.dped_empresa ) and 
												( fatpedid.pedi_no_pedido = fadpedid.dped_no_pedido ) and 
												( fatpedid.pedi_ann = fadpedid.dped_ann ) ),		 		 												
  				pedi_monto_total = (	select sum( fadpedid.dped_monto_total) 
												 FROM fadpedid 							
										WHERE ( fatpedid.pedi_g_financiero = fadpedid.dped_g_financiero ) and 
												( fatpedid.pedi_empresa = fadpedid.dped_empresa ) and 
												( fatpedid.pedi_no_pedido = fadpedid.dped_no_pedido ) and 
												( fatpedid.pedi_ann = fadpedid.dped_ann ) ),
		  		pedi_monto_final = pedi_gastos_total + (	select sum( fadpedid.dped_monto_final) 
												 FROM fadpedid 							
										WHERE ( fatpedid.pedi_g_financiero = fadpedid.dped_g_financiero ) and 
												( fatpedid.pedi_empresa = fadpedid.dped_empresa ) and 
												( fatpedid.pedi_no_pedido = fadpedid.dped_no_pedido ) and 
												( fatpedid.pedi_ann = fadpedid.dped_ann ) ),
		  		pedi_bultos_total = (	select sum( fadpedid.dped_bultos) 
												 FROM fadpedid 							
										WHERE ( fatpedid.pedi_g_financiero = fadpedid.dped_g_financiero ) and 
												( fatpedid.pedi_empresa = fadpedid.dped_empresa ) and 
												( fatpedid.pedi_no_pedido = fadpedid.dped_no_pedido ) and 
												( fatpedid.pedi_ann = fadpedid.dped_ann ) )		 		 																								
		FROM fatpedid
		where	( ( fatpedid.pedi_g_financiero= :str.g_financiero ) AND  
				( fatpedid.pedi_empresa 		= :str.empresa ) AND  
				( fatpedid.pedi_no_pedido 		= :ls_no_pedido ) AND  
				( fatpedid.pedi_ann 				= :ll_anio )  ) ;		
				
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al actualizar el Peso y Cubicaje en el Encabezado del Pedido",ls_error)
			sqlca.autocommit = true
			return
		end if

		//actualiza el pedido nuevo
		//actualiza totales del pedido, el nuevo y el anterior
		  UPDATE fatpedid
		  SET pedi_cubicaje_total = (	select sum( fadpedid.dped_cubicaje) 
												 FROM fadpedid 							
										WHERE ( fatpedid.pedi_g_financiero = fadpedid.dped_g_financiero ) and 
												( fatpedid.pedi_empresa = fadpedid.dped_empresa ) and 
												( fatpedid.pedi_no_pedido = fadpedid.dped_no_pedido ) and 
												( fatpedid.pedi_ann = fadpedid.dped_ann ) ),
		  		pedi_peso_total = (	select sum( fadpedid.dped_peso) 
												 FROM fadpedid 							
										WHERE ( fatpedid.pedi_g_financiero = fadpedid.dped_g_financiero ) and 
												( fatpedid.pedi_empresa = fadpedid.dped_empresa ) and 
												( fatpedid.pedi_no_pedido = fadpedid.dped_no_pedido ) and 
												( fatpedid.pedi_ann = fadpedid.dped_ann ) ),		 		 
		  		pedi_costos_total = (	select sum( fadpedid.dped_costo_total) 
												 FROM fadpedid 							
										WHERE ( fatpedid.pedi_g_financiero = fadpedid.dped_g_financiero ) and 
												( fatpedid.pedi_empresa = fadpedid.dped_empresa ) and 
												( fatpedid.pedi_no_pedido = fadpedid.dped_no_pedido ) and 
												( fatpedid.pedi_ann = fadpedid.dped_ann ) ),		 		 												
  				pedi_monto_total = (	select sum( fadpedid.dped_monto_total) 
												 FROM fadpedid 							
										WHERE ( fatpedid.pedi_g_financiero = fadpedid.dped_g_financiero ) and 
												( fatpedid.pedi_empresa = fadpedid.dped_empresa ) and 
												( fatpedid.pedi_no_pedido = fadpedid.dped_no_pedido ) and 
												( fatpedid.pedi_ann = fadpedid.dped_ann ) ),
		  		pedi_monto_final = pedi_gastos_total + (	select sum( fadpedid.dped_monto_final) 
												 FROM fadpedid 							
										WHERE ( fatpedid.pedi_g_financiero = fadpedid.dped_g_financiero ) and 
												( fatpedid.pedi_empresa = fadpedid.dped_empresa ) and 
												( fatpedid.pedi_no_pedido = fadpedid.dped_no_pedido ) and 
												( fatpedid.pedi_ann = fadpedid.dped_ann ) ),
		  		pedi_bultos_total = (	select sum( fadpedid.dped_bultos) 
												 FROM fadpedid 							
										WHERE ( fatpedid.pedi_g_financiero = fadpedid.dped_g_financiero ) and 
												( fatpedid.pedi_empresa = fadpedid.dped_empresa ) and 
												( fatpedid.pedi_no_pedido = fadpedid.dped_no_pedido ) and 
												( fatpedid.pedi_ann = fadpedid.dped_ann ) )		 		 												
		FROM fatpedid
		where	( ( fatpedid.pedi_g_financiero= :str.g_financiero ) AND  
				( fatpedid.pedi_empresa 		= :str.empresa ) AND  
				( fatpedid.pedi_no_pedido 		= :ls_pedido_nuevo ) AND  
				( fatpedid.pedi_ann 				= :ll_anio )  ) ;		
				
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al actualizar el Peso, Cubicaje, Costos y Montos en el Encabezado del Pedido",ls_error)
			sqlca.autocommit = true
			return
		end if		
		
		  update faaparam
		  set faaparam.fara_ult_pedido  = :ls_pedido_nuevo
			WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
					( faaparam.fara_empresa = :str.empresa )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Buscar Secuencia '+sqlca.sqlerrtext,1,1,'E')
				return
			end if

		
		gf_mensaje("","Separación Exitosa",1,1,"E")
	end if
	//dwc_fac_pedi.retrieve(str.g_financiero,str.empresa) //comentado para que no se demore en recuperar nuevamente
	dw_1.reset()
	dw_1.InsertRow(1)	
	em_pedido.text = ''
end if
end event

type cb_2 from commandbutton within w_fa_man_separar_futuros
integer x = 1051
integer y = 504
integer width = 265
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;close(parent)
end event

type st_1 from statictext within w_fa_man_separar_futuros
integer x = 123
integer y = 72
integer width = 1093
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
string text = "No. del Pedido a Separar"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_fa_man_separar_futuros
integer x = 50
integer y = 284
integer width = 503
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "No. Pedido Nuevo:"
boolean focusrectangle = false
end type

type em_pedido from editmask within w_fa_man_separar_futuros
integer x = 544
integer y = 268
integer width = 357
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!!!!!!!"
end type

