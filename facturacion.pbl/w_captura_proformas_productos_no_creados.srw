//objectcomments Ventana para la Captura de Cotizaciones
forward
global type w_captura_proformas_productos_no_creados from w_fa_padre
end type
type dw_2 from datawindow within w_captura_proformas_productos_no_creados
end type
type dw_3 from datawindow within w_captura_proformas_productos_no_creados
end type
type cb_1 from commandbutton within w_captura_proformas_productos_no_creados
end type
type cb_2 from commandbutton within w_captura_proformas_productos_no_creados
end type
type dw_6 from datawindow within w_captura_proformas_productos_no_creados
end type
type st_1 from statictext within w_captura_proformas_productos_no_creados
end type
type dw_7 from datawindow within w_captura_proformas_productos_no_creados
end type
type dw_4 from datawindow within w_captura_proformas_productos_no_creados
end type
type dw_5 from datawindow within w_captura_proformas_productos_no_creados
end type
type pb_2 from picturebutton within w_captura_proformas_productos_no_creados
end type
type st_2 from statictext within w_captura_proformas_productos_no_creados
end type
type pb_3 from picturebutton within w_captura_proformas_productos_no_creados
end type
type st_3 from statictext within w_captura_proformas_productos_no_creados
end type
type cb_3 from commandbutton within w_captura_proformas_productos_no_creados
end type
type dw_9 from datawindow within w_captura_proformas_productos_no_creados
end type
type uo_1 from u_ddcalen within w_captura_proformas_productos_no_creados
end type
type dw_10 from datawindow within w_captura_proformas_productos_no_creados
end type
type dw_11 from datawindow within w_captura_proformas_productos_no_creados
end type
type pb_prefactura from picturebutton within w_captura_proformas_productos_no_creados
end type
type dw_8 from datawindow within w_captura_proformas_productos_no_creados
end type
end forward

global type w_captura_proformas_productos_no_creados from w_fa_padre
integer x = 0
integer y = 0
integer width = 4224
integer height = 2800
string title = "Captura de Cotizaciones Productos no Existentes"
string menuname = "m_hs"
boolean controlmenu = false
long backcolor = 82899184
windowanimationstyle openanimation = rightslide!
windowanimationstyle closeanimation = leftslide!
event ue_syscommand pbm_syscommand
event ue_aceptar_por_linea ( )
dw_2 dw_2
dw_3 dw_3
cb_1 cb_1
cb_2 cb_2
dw_6 dw_6
st_1 st_1
dw_7 dw_7
dw_4 dw_4
dw_5 dw_5
pb_2 pb_2
st_2 st_2
pb_3 pb_3
st_3 st_3
cb_3 cb_3
dw_9 dw_9
uo_1 uo_1
dw_10 dw_10
dw_11 dw_11
pb_prefactura pb_prefactura
dw_8 dw_8
end type
global w_captura_proformas_productos_no_creados w_captura_proformas_productos_no_creados

type variables
integer ii_ann, datawindow, il_row, ii_cantidad_unidad, ii_cantidad_empaque, ii_vendedor, ii_acepta_descuento
String  is_entrada, is_unidad_empaque, is_secuencia, is_actualiza, is_tipo, is_unidad, is_descrip, is_item, is_user, &
		  is_cta_ingreso_local, is_cta_ingreso_exterior, is_cta_inventarios, is_cta_costos_local, is_cta_costos_exterior, &
		  is_b1, is_b2, is_b3, is_b4, is_b5, is_b6, is_b7, is_modelo, is_foto
date	  idt_desde, idt_hasta
long    il_tiempo, il_segundos, il_secuencia, il_empaque, il_tercero
decimal{4} id_peso, id_cubicaje
decimal{8} id_precio, id_precio_prod, id_costo_cif, id_costo_fob
decimal{2} idec_gastos, id_credito_adicional, id_porc_descuento, id_porc_maximo, id_costo_total, idec_descuento, id_ultimo_precio, id_ultima_cantidad
datawindowchild idwc_cliente, idwc_tipo, idwc_vendedores, idwc_dias, idwc_formatos
integer ii_metal_pendiente
Integer MODE_ANSI = 1
Integer Handler, ii_bodegas_definidas, ii_opcion_captura
str_foto_cantidad_precio istr_foto_cantidad_precio
end variables

forward prototypes
public function boolean wf_recupera ()
public function boolean wf_orden_nueva ()
public function boolean wf_imprime_vendedor ()
public function boolean wf_asigna_vendedor ()
public subroutine wf_cargos (double ld_cargos)
public subroutine wf_setear_user (string as_user)
public function boolean wf_valida_limite_credito ()
public function boolean wf_setear_user_credito (string as_user, double ad_monto, string as_nota)
public function boolean wf_setear_user_venta (string as_user, double ad_monto, string as_nota)
public function boolean wf_anula_movimiento ()
public function boolean wf_asigna_pre_factura (string as_pre_factura, integer ai_ann_pre_factura)
public function boolean wf_carga_producto (ref string as_codigo, ref string ls_descripcion, ref string as_modelo)
end prototypes

event ue_syscommand;call super::ue_syscommand;if commandtype = 61536 then
	close(this)
end if
end event

public function boolean wf_recupera ();long ll_fila, ll_recuperados

str.frame.setmicrohelp('Espere mientras se recuperan los registros...')

ll_fila = dw_1.getrow()

ll_recuperados = dw_1.retrieve(str.g_financiero, str.empresa, idt_desde, idt_hasta)
if ll_recuperados > ll_fila then
	dw_1.scrolltorow(ll_fila)
end if

il_segundos = 0

str.frame.setmicrohelp('Captura de Cotizaciones')

return true
end function

public function boolean wf_orden_nueva ();long ll_max
integer li_ann

//li_ann = year(date(gf_fecha_serv()))

select max(convert(numeric(10), prof_no_proforma ))
into	:ll_max
from fatprofo2
where prof_g_financiero = :str.g_financiero and
		prof_empresa		= :str.empresa and
		prof_ann				= :ii_ann ;
	if sqlca.sqlcode = -1  then
		gf_mensaje('','Error al Buscar Secuencia '+sqlca.sqlerrtext,1,1,'E')		
		return false
	end if
	
	if isnull(ll_max) then ll_max = 0
	
	ll_max ++
	
	dw_1.setitem(1,'prof_no_proforma',string(ll_max))
	
	is_secuencia = string(ll_max)	
return true
end function

public function boolean wf_imprime_vendedor ();integer li_hay, li_codigo, i=0
string  ls_nombre, ls_resultado, ls_nombre_imp, ls_cod_imp

datawindow ldw_3

ldw_3 = dw_4
		
		 DECLARE cur_vende CURSOR FOR
		  SELECT fadvenpr.vpro_vendedor,   
					famvende.vend_nombre+' '+famvende.vend_apellido nombre  
			 FROM fadvenpr,   
					famvende  
			WHERE ( famvende.vend_g_financiero = fadvenpr.vpro_g_financiero ) and  
					( famvende.vend_empresa = fadvenpr.vpro_empresa ) and  
					( famvende.vend_vendedor = fadvenpr.vpro_vendedor ) and  
					( ( fadvenpr.vpro_g_financiero = :str.g_financiero ) AND  
					( fadvenpr.vpro_empresa = :str.empresa ) AND  
					( fadvenpr.vpro_no_proforma = :is_secuencia ) AND  
					( fadvenpr.vpro_ann = :ii_ann ) ) ;			 
	
 OPEN cur_vende;
 
 if sqlca.sqlcode = -1 then
	mensaje("Aviso","Error al Abrir el Cursor",sqlca.sqlerrtext)
 end if
 
 FETCH cur_vende INTO :li_codigo,:ls_nombre;
 
 IF SQLCA.SQLCODE = -1 THEN	
	MESSAGEBOX("ERROR","ERROR AL SELECCIONAR LOS VENDEDORES "+SQLCA.SQLERRTEXT)
	CLOSE cur_vende;
	RETURN false
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
 
 ls_resultado = ldw_3.modify("cod_vendedor.text='"+ls_cod_imp+"'")
 ls_resultado = ldw_3.modify("nom_vendedor.text='"+ls_nombre_imp+"'")			
	 
 CLOSE cur_vende;
 
 return true
end function

public function boolean wf_asigna_vendedor ();integer li_existe

ii_vendedor = dw_1.getitemnumber(dw_1.getrow(), 'vendedor')

if ii_vendedor = 0 or isnull(ii_vendedor) then
	delete from fadvenpr
	where vpro_g_financiero = :str.g_financiero and
		vpro_empresa		= :str.empresa and
		vpro_no_proforma		= :is_secuencia and
		vpro_ann				= :ii_ann ;
		
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Eliminar vendedor '+sqlca.sqlerrtext,1,1,'E')
			return false
		end if		
		return true
end if

select count(*)
into :li_existe
from fadvenpr
where vpro_g_financiero = :str.g_financiero and
		vpro_empresa		= :str.empresa and
		vpro_no_proforma		= :is_secuencia and
		vpro_ann				= :ii_ann ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al validar vendedor '+sqlca.sqlerrtext,1,1,'E')
		end if		
		
if li_existe = 0 then
	
	  INSERT INTO fadvenpr  
         ( vpro_g_financiero,   
           vpro_empresa,   
           vpro_no_proforma,   
		  vpro_tipo,
           vpro_ann,   
           vpro_vendedor )  
	  VALUES ( :str.g_financiero,   
				  :str.empresa,   
				  :is_secuencia,
				  '0',
				  :ii_ann,   
				  :ii_vendedor )  ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al insertar vendedor '+sqlca.sqlerrtext,1,1,'E')
			rollback ;
		end if
	
else
		
	  UPDATE fadvenpr  
		  SET vpro_vendedor = :ii_vendedor  
		WHERE ( fadvenpr.vpro_g_financiero = :str.g_financiero ) AND  
				( fadvenpr.vpro_empresa = :str.empresa ) AND  
				( fadvenpr.vpro_no_proforma = :is_secuencia ) AND  
				( fadvenpr.vpro_ann = :ii_ann )  ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al validar vendedor '+sqlca.sqlerrtext,1,1,'E')
				rollback ;
			end if
	
end if

commit ;

return true
end function

public subroutine wf_cargos (double ld_cargos);double ld_cargos_act
datawindow ldw_1

ldw_1 = dw_1
 
ld_cargos_act = ldw_1.getitemnumber(ldw_1.getrow(),"prof_gastos_total")	// Cargos actuales
if isnull(ld_cargos_act) then ld_cargos_act = 0

If ld_cargos_act <> ld_cargos then
	ldw_1.setitem(ldw_1.getrow(),"prof_gastos_total",ld_cargos)
	dw_2.object.cargos.expression = "'"+string(ld_cargos,'#,##0.00')+"'"
//	wf_recalcula()
	idec_gastos = ld_cargos
	this.postevent('ue_aceptar')
End if
end subroutine

public subroutine wf_setear_user (string as_user);//Asigno el Usuario a la Variable de Instancia
is_user = as_user
end subroutine

public function boolean wf_valida_limite_credito ();if gf_mensaje('','El Cliente Excedió su Límite de Crédito, Desea autorizar la venta ? !!!',2,2,'E') = 2 then
	
	if gf_mensaje('','El Cliente Excedió su Límite de Crédito, Desea Aumentar el Límite de Crédito ? !!!',2,2,'E') = 2 then	
		return false
	else
		OpenWithParm(w_clave_autorizada_credito, this)
	
		If is_user = "*" then
			return false
		end if
		
	end if
else
	
	OpenWithParm(w_clave_autorizada_venta, this)

	If is_user = "*" then
		return false
	end if

end if

return true
end function

public function boolean wf_setear_user_credito (string as_user, double ad_monto, string as_nota);long ll_cliente
datetime ldt_fecha
string ls_detalle
decimal{2} ld_limite_credito

is_user = as_user
id_credito_adicional = ad_monto
ll_cliente = dw_1.getitemnumber(1,'prof_cliente')
ld_limite_credito = dw_1.getitemNumber(1,'limite')

if is_user = '*' then	
	return false
end if

	UPDATE ccmclien  
	  SET clie_limite_credito = clie_limite_credito + :ad_monto  
	WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
			( ccmclien.clie_empresa = :str.empresa ) AND  
			( ccmclien.clie_tercero = :ll_cliente ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al actualizar el credito del cliente '+sqlca.sqlerrtext,1,1,'E')
			rollback;
		end if
					
		ldt_fecha  = gf_fecha_serv()
		ls_detalle = 'Cambio del Limite de Credito: de '+string(ld_limite_credito,'$#,##0.00')+ ' a '+string(round(ld_limite_credito + ad_monto,2), '$#,##0.00') + ' - '+as_nota

		  INSERT INTO notas_clientes  
			( nota_g_financiero,   
			  nota_empresa,   
			  nota_tercero,   
			  nota_detalle,   
			  nota_fecha,   
			  nota_usuario )  
		  VALUES ( :str.g_financiero,   
					  :str.empresa,   
					  :ll_cliente,   
					  :ls_detalle,     
					  :ldt_fecha,   
					  :str.usuario )  ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al registrar las notas '+sqlca.sqlerrtext,1,1,'E')
				rollback;
			end if
		//Para actualizar el limite que esta en el child
		idwc_cliente.retrieve(str.g_financiero, str.empresa) 
		dw_1.setitem(1,'limite', ld_limite_credito + ad_monto)
		
return true
end function

public function boolean wf_setear_user_venta (string as_user, double ad_monto, string as_nota);long ll_cliente
datetime ldt_fecha
string ls_detalle
decimal{2} ld_limite_credito

is_user = as_user
id_credito_adicional = ad_monto
ll_cliente = dw_1.getitemnumber(1,'prof_cliente')
ld_limite_credito = dw_1.getitemNumber(1,'limite')

if is_user = '*' then	
	return false
end if

//	UPDATE ccmclien  
//	  SET clie_limite_credito = clie_limite_credito + :ad_monto  
//	WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
//			( ccmclien.clie_empresa = :str.empresa ) AND  
//			( ccmclien.clie_tercero = :ll_cliente ) ;
//		if sqlca.sqlcode = -1 then
//			gf_mensaje('','Error al actualizar el credito del cliente '+sqlca.sqlerrtext,1,1,'E')
//			rollback;
//		end if
					
		ldt_fecha  = gf_fecha_serv()
		ls_detalle = 'Autorizo venta por encima del limite: de '+string(ld_limite_credito,'$#,##0.00')+ ' a '+string(round(ld_limite_credito + ad_monto,2), '$#,##0.00') + ' - '+as_nota

		  INSERT INTO notas_clientes  
			( nota_g_financiero,   
			  nota_empresa,   
			  nota_tercero,   
			  nota_detalle,   
			  nota_fecha,   
			  nota_usuario )  
		  VALUES ( :str.g_financiero,   
					  :str.empresa,   
					  :ll_cliente,   
					  :ls_detalle,     
					  :ldt_fecha,   
					  :str.usuario )  ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al registrar las notas '+sqlca.sqlerrtext,1,1,'E')
				rollback;
			end if
		//Para actualizar el limite que esta en el child
		idwc_cliente.retrieve(str.g_financiero, str.empresa) 
		dw_1.setitem(1,'limite', ld_limite_credito + ad_monto)
		
return true
end function

public function boolean wf_anula_movimiento ();//Setea a anulado el movimiento tanto en inventario como en clientes
string ls_factura, ls_comentario, ls_monto, ls_error, ls_transac
long li_factura

ls_factura	=	dw_1.getitemstring(dw_1.getrow(),"prof_no_factura")
ls_monto	   =	string(dw_1.getitemNumber(dw_1.getrow(),"prof_monto_final"))
li_factura	=  long(ls_factura)  
//Poner un parametro, para manejar las facturas contados
if dw_1.Getitemstring(dw_1.Getrow(),"prof_condicion_pago") = "CO" then
	//Si en parametros se especificó que a las facturas contado no se le hacen recibos en CXC,
	//En Facturacion se debe crear una transaccion automática que rebaje el saldo del cliente
	ls_transac = "FC" 	
else
	ls_transac = "FA"   //Y LAS C.O.D. ??????
end if

//Setea a anulado el detalle de actualizaciones en inventario
str.frame.Setmicrohelp("Anulando el Detalle de Actualizaciones...")
  delete from indmovim
   WHERE ( indmovim.dmov_g_financiero = :str.g_financiero ) AND  
         ( indmovim.dmov_empresa = :str.empresa ) AND  
         ( indmovim.dmov_aplicacion = 'FA' ) AND  
         ( indmovim.dmov_tipo_transaccion = "SA" ) AND  
         ( indmovim.dmov_secuencia = :li_factura ) AND
			( indmovim.dmov_anual	=	:ii_ann);

		if sqlca.sqlerrtext <> "" then
			ls_error = sqlca.sqlerrtext
			rollback;
			messagebox("ATENCION SR. USUARIO  ",ls_error+"  "+string(sqlca.sqlcode),Exclamation!)				
			return false
		end if

//Setea a anulad el detalle de los gastos en inventario
  str.frame.Setmicrohelp("Anulando el Detalle de Gastos...")
  delete from indgasto  
   WHERE ( indgasto.gast_g_financiero = :str.g_financiero ) AND  
         ( indgasto.gast_empresa = :str.empresa ) AND  
         ( indgasto.gast_aplicacion = 'FA' ) AND  
         ( indgasto.gast_transaccion = "SA" ) AND  
         ( indgasto.gast_secuencia = :li_factura ) AND  
         ( indgasto.gast_ann = :ii_ann )   ;

		if sqlca.sqlerrtext <> "" then
			ls_error = sqlca.sqlerrtext
			rollback;			
			messagebox("AENCION SR. USUARIO  ",ls_error+"  "+string(sqlca.sqlcode))
			return false
		end if


//Setea a anulado el encabezado de actualizaciones en inventario
str.frame.Setmicrohelp("Anulando el Encabezado de Actualizaciones...")
  delete from intmovim  
   WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
         ( intmovim.tmov_empresa = :str.empresa ) AND  
         ( intmovim.tmov_aplicacion = 'FA' ) AND  
         ( intmovim.tmov_tipo_transaccion = "SA" ) AND  
         ( intmovim.tmov_secuencia = :li_factura ) AND
			( intmovim.tmov_anual	=	:ii_ann) ;
			
		if sqlca.sqlerrtext <> "" then
			ls_error = sqlca.sqlerrtext
			rollback;			
			messagebox("AENCION SR. USUARIO ",ls_error+"  "+string(sqlca.sqlcode))
			return false
		end if

//Setea a anulado el registro de Transacciones en Cuentas por Cobrar
str.frame.Setmicrohelp("Anulando el Movimiento del Cliente...")
	select movi_comentario
		into :ls_comentario
		from cctmovim
   WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
         ( cctmovim.movi_empresa = :str.empresa ) AND  
         ( cctmovim.movi_aplicacion = 'FA' ) AND  
         ( cctmovim.movi_tipo_transaccion = :ls_transac ) AND  
         ( cctmovim.movi_documento = :ls_factura ) AND
			( cctmovim.movi_anno	=	:ii_ann);
		if sqlca.sqlerrtext <> "" then
			ls_error = sqlca.sqlerrtext
			rollback;			
			messagebox("ATENCION SR. USUARIO ",ls_error+"  "+string(sqlca.sqlcode))
			return false
		end if
	
	ls_comentario =+ ' Por: '+ls_monto

  UPDATE cctmovim  
     SET movi_estado = 'AN',
	  		movi_fecha_anul = getdate(),
			movi_usuario_anul = :str.usuario,
			movi_comentario = :ls_comentario,
			movi_monto = 0
   WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
         ( cctmovim.movi_empresa = :str.empresa ) AND  
         ( cctmovim.movi_aplicacion = 'FA' ) AND  
         ( cctmovim.movi_tipo_transaccion = :ls_transac ) AND  
         ( cctmovim.movi_documento = :ls_factura ) AND
			( cctmovim.movi_anno	=	:ii_ann);
			
		if sqlca.sqlerrtext <> "" then
			ls_error = sqlca.sqlerrtext
			rollback;			
			messagebox("ATENCION SR. USUARIO ",ls_error+"  "+string(sqlca.sqlcode))
			return false
		end if

	  DELETE FROM coddiari  
		WHERE ( coddiari.ddia_g_financiero = :str.g_financiero ) AND  
				( coddiari.ddia_empresa = :str.empresa ) AND  
				( coddiari.ddia_aplicacion_mg = 'FA' ) AND  
				( coddiari.ddia_no_documento = :ls_factura ) AND  
				( coddiari.ddia_ann = :ii_ann )   ;
		if sqlca.sqlerrtext <> "" then
			ls_error = sqlca.sqlerrtext
			rollback;			
			messagebox("ATENCION SR. USUARIO ",ls_error+"  "+string(sqlca.sqlcode))
			return false
		end if

	  DELETE FROM cotdiari  
		WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
				( cotdiari.diar_empresa = :str.empresa ) AND  
				( cotdiari.diar_aplicacion_mg = 'FA' ) AND  
				( cotdiari.diar_no_documento = :ls_factura ) AND  
				( cotdiari.diar_ann = :ii_ann )   ;
		if sqlca.sqlerrtext <> "" then
			ls_error = sqlca.sqlerrtext
			rollback;			
			messagebox("ATENCION SR. USUARIO ",ls_error+"  "+string(sqlca.sqlcode))
			return false
		end if


str.frame.Setmicrohelp("")

return true
end function

public function boolean wf_asigna_pre_factura (string as_pre_factura, integer ai_ann_pre_factura);string ls_cuenta, ls_condicion, ls_tipo, ls_movimiento, ls_consignado, ls_a_nombre, ls_direccion, ls_despachado, &
		ls_comentario, ls_pasaporte, ls_linea_aerea, ls_producto, ls_descripcion, ls_unidad, ls_bodega, ls_ubicacion, ls_unidad_venta, ls_item
datetime ldt_fecha_despacho, ldt_fecha
decimal{2} ld_gastos, ld_monto, ld_monto_final , ld_costo_fob, ld_costo_cif, ld_cantidad, ld_precio_original, ld_costo_total, ld_precio_unidad_producto, ld_precio_recargo, ld_rec_especial		
integer li_dias, li_vendedor, li_tipo, li_linea, li_index, li_fraccion, li_bultos
long ll_cliente
  
  SELECT faprefactura.prof_cliente,   
         faprefactura.prof_ruc_cliente,   
         faprefactura.prof_condicion_pago,   
         faprefactura.prof_tipo_venta,   
         faprefactura.prof_tipo_movimiento,   
         faprefactura.prof_dias_pago,   
         faprefactura.prof_consignado,   
         faprefactura.prof_a_nombre,   
         faprefactura.prof_a_nombre_direccion,   
         faprefactura.prof_despachado,   
         faprefactura.prof_gastos_total,   
         faprefactura.prof_monto_prof_total,   
         faprefactura.prof_monto_final,   
         faprefactura.prof_comentario,   
         faprefactura.prof_fecha_despacho,   
         faprefactura.prof_pasaporte,   
         faprefactura.prof_linea_aerea,   
         faprefactura.prof_vendedor  ,
		faprefactura	.prof_recargo_especial
    INTO :ll_cliente,   
         :ls_cuenta,   
         :ls_condicion,   
         :li_tipo,   
         :ls_movimiento,   
         :li_dias,   
         :ls_consignado,   
         :ls_a_nombre,   
         :ls_direccion,   
         :ls_despachado,   
         :ld_gastos,   
         :ld_monto,   
         :ld_monto_final,   
         :ls_comentario,   
         :ldt_fecha_despacho,   
         :ls_pasaporte,   
         :ls_linea_aerea,   
         :li_vendedor ,
		:ld_rec_especial	
    FROM faprefactura  
   WHERE ( faprefactura.prof_g_financiero = :str.g_financiero ) AND  
         ( faprefactura.prof_empresa = :str.empresa ) AND  
         ( faprefactura.prof_no_proforma = :as_pre_factura ) AND  
         ( faprefactura.prof_ann = :ai_ann_pre_factura )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Seleccionar el Encabezado '+sqlca.sqlerrtext,1,1,'E')
			return false
		end if
		
		// Crea un nuevo registro
		dw_1.reset()
		dw_2.object.cargos.expression = "'"+string(0.00,'#,##0.00')+"'"	//Para blanquear los cargos
		dw_2.reset()
		dw_7.reset()
		dw_7.insertrow(1)
//		dw_8.reset()
//		dw_8.insertrow(1)
		dw_7.bringtotop = true
//		dw_8.bringtotop = true	
		dw_1.insertrow(1)
		//Pone invisible el insertar	
		dw_1.setitem(1,'prof_g_financiero',str.g_financiero)
		dw_1.setitem(1,'prof_empresa',str.empresa)
		dw_1.setitem(1,'prof_ann',ii_ann)
		dw_1.setitem(1,'prof_fecha',date(gf_fecha_serv()))
		dw_1.setitem(1,'prof_fecha_despacho',ldt_fecha_despacho)	
		dw_1.setitem(1,'prof_tipo_venta',li_tipo) //exterior
		dw_1.setitem(1,'prof_estado','A')
		dw_1.setitem(1,'prof_usuario',str.usuario)	
		dw_1.setitem(1,'prof_metal_pendiente',ii_metal_pendiente)	
		if ii_metal_pendiente = 1 then
			dw_1.setitem(1,'prof_cierre_de_metal',0)	
			dw_1.setitem(1,'prof_excluir_de_reporte',1)	
		end if
		is_tipo = idwc_tipo.getitemstring(1,'dgmsubse_subs_sub_trans')
		dw_1.setitem(1,'prof_tipo', is_tipo)
		dw_1.setfocus()
		dw_1.setcolumn('prof_ruc_cliente')
		idec_gastos = 0
		wf_orden_nueva()
		
		dw_1.setitem(1,'prof_no_proforma',is_secuencia)
		dw_1.setitem(1,'prof_ann',ii_ann)	
		dw_1.setitem(1,'prof_pre_factura',as_pre_factura)
		dw_1.setitem(1,'prof_ann_pre_factura',ai_ann_pre_factura)
		dw_1.setitem(1,'prof_cliente',ll_cliente)
		dw_1.setitem(1,'prof_ruc_cliente',ls_cuenta)
		dw_1.setitem(1,'prof_condicion_pago',ls_condicion)
		dw_1.setitem(1,'prof_tipo_movimiento',ls_movimiento)
		dw_1.setitem(1,'prof_dias_pago',li_dias)
		dw_1.setitem(1,'prof_consignado',ls_consignado)
		dw_1.setitem(1,'prof_a_nombre',ls_a_nombre)
		dw_1.setitem(1,'prof_a_nombre_direccion',ls_direccion)
		dw_1.setitem(1,'prof_despachado',ls_despachado)
		dw_1.setitem(1,'prof_gastos_total',ld_gastos)
		dw_1.setitem(1,'prof_monto_prof_total',ld_monto)
		dw_1.setitem(1,'prof_monto_final',ld_monto_final)
		dw_1.setitem(1,'prof_comentario',ls_comentario)
		dw_1.setitem(1,'prof_pasaporte',ls_pasaporte)
		dw_1.setitem(1,'prof_linea_aerea',ls_linea_aerea)
		dw_1.setitem(1,'vendedor',li_vendedor)
		dw_1.setitem(1,'prof_recargo_especial',ld_rec_especial)
		
		 DECLARE cur_detalle CURSOR FOR  
		  SELECT faprefacturad.dpro_linea,   
					faprefacturad.dpro_codigo_item,   
					faprefacturad.dpro_descripcion_alterna,   
					faprefacturad.dpro_unidad_producto,   
			   		faprefacturad.dpro_bodega,   
					faprefacturad.dpro_costo_fob,   
					faprefacturad.dpro_costo_cif,   
					faprefacturad.dpro_precio_unidad_producto,   
					faprefacturad.dpro_unidad_venta,   
					faprefacturad.dpro_cantidad,   
					faprefacturad.dpro_cantidad_fraccion,   
					faprefacturad.dpro_monto_total,   
					faprefacturad.dpro_monto_final,   
					faprefacturad.dpro_bultos,   
					faprefacturad.dpro_ubicacion,   
					faprefacturad.dpro_index,   
					faprefacturad.dpro_precio_original,   
					faprefacturad.dpro_costo_total,
					faprefacturad.dpro_precio_recargo
			 FROM faprefacturad  
			WHERE ( faprefacturad.dpro_g_financiero = :str.g_financiero ) AND  
					( faprefacturad.dpro_empresa = :str.empresa ) AND  
					( faprefacturad.dpro_no_proforma = :as_pre_factura ) AND  
					( faprefacturad.dpro_ann = :ai_ann_pre_factura )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Declarar el Cursor '+sqlca.sqlerrtext,1,1,'E')
						return false
					end if
				
		open cur_detalle ;
		
		fetch cur_detalle into :li_linea, :ls_producto, :ls_descripcion, :ls_unidad, :ls_bodega, :ld_costo_fob, :ld_costo_cif, :ld_precio_unidad_producto, &
									:ls_unidad_venta, :ld_cantidad, :li_fraccion, :ld_monto, :ld_monto_final, :li_bultos, :ls_ubicacion, :li_index, :ld_precio_original, :ld_costo_total, :ld_precio_recargo;
		do while sqlca.sqlcode = 0
				
			dw_2.scrolltorow(dw_2.insertrow(0))
			dw_2.setitem(dw_2.getrow(),'dpro_g_financiero',str.g_financiero)
			dw_2.setitem(dw_2.getrow(),'dpro_empresa',str.empresa)
			dw_2.setitem(dw_2.getrow(),'dpro_usuario',str.usuario)
			dw_2.setitem(dw_2.getrow(),'dpro_codigo_item',ls_producto)
			dw_2.setitem(dw_2.getrow(),'dpro_descripcion_alterna',ls_descripcion)
			dw_2.setitem(dw_2.getrow(),'dpro_unidad_venta',ls_unidad)			
			dw_2.setitem(dw_2.getrow(),'dpro_unidad_producto',ls_unidad)		
			dw_2.setitem(dw_2.getrow(),'dpro_costo_cif', ld_costo_cif)			
			dw_2.setitem(dw_2.getrow(),'dpro_costo_cif', ld_costo_fob)
			dw_2.setitem(dw_2.getrow(),'dpro_unidad_venta', ls_unidad_venta)
			dw_2.setitem(dw_2.getrow(),'dpro_costo_cif', ld_costo_cif)
			dw_2.setitem(dw_2.getrow(),'dpro_metal_pendiente',ii_metal_pendiente)				
			dw_2.setitem(dw_2.getrow(),'dpro_linea', li_linea)
			dw_2.setitem(dw_2.getrow(),'dpro_index', li_index)	
			dw_2.setitem(dw_2.getrow(),'dpro_bodega', ls_bodega)
			dw_2.setitem(dw_2.getrow(),'dpro_ubicacion', ls_ubicacion)			
			dw_2.setitem(dw_2.getrow(),'dpro_costo_total', ld_costo_total)
			dw_2.setitem(dw_2.getrow(),'dpro_bultos', li_bultos)			
			dw_2.setitem(dw_2.getrow(),'dpro_cantidad_fraccion', li_fraccion)
			dw_2.setitem(dw_2.getrow(),'dpro_cantidad', ld_cantidad)
			
			if ii_metal_pendiente = 1 then
				dw_2.setitem(dw_2.getrow(),'dpro_precio_original', 0)			
				dw_2.setitem(dw_2.getrow(),'dpro_precio_recargo', ld_precio_recargo)			
				dw_2.setitem(dw_2.getrow(),'dpro_precio_unidad_producto', ld_precio_recargo)			
				dw_2.setitem(dw_2.getrow(),'dpro_monto_total', ld_precio_recargo * ld_cantidad)
				dw_2.setitem(dw_2.getrow(),'dpro_monto_final', ld_precio_recargo * ld_cantidad)							
				if ld_precio_recargo * ld_cantidad = 0 then
					dw_2.deleterow(dw_2.getrow())
				end if
			else
				dw_2.setitem(dw_2.getrow(),'dpro_precio_original', ld_precio_original)			
				dw_2.setitem(dw_2.getrow(),'dpro_precio_recargo', ld_precio_recargo)			
				dw_2.setitem(dw_2.getrow(),'dpro_precio_unidad_producto', ld_precio_unidad_producto)
				dw_2.setitem(dw_2.getrow(),'dpro_monto_total', ld_monto)
				dw_2.setitem(dw_2.getrow(),'dpro_monto_final', ld_monto_final)							
			end if
			
			ls_item = ls_producto
			
			fetch cur_detalle into :li_linea, :ls_producto, :ls_descripcion, :ls_unidad, :ls_bodega, :ld_costo_fob, :ld_costo_cif, :ld_precio_unidad_producto, &
							:ls_unidad_venta, :ld_cantidad, :li_fraccion, :ld_monto, :ld_monto_final, :li_bultos, :ls_ubicacion, :li_index, :ld_precio_original, :ld_costo_total, :ld_precio_recargo;				
		loop
		
		close cur_detalle;

		dw_7.retrieve(str.g_financiero, str.empresa, ls_item)
//	    dw_8.retrieve(str.g_financiero, str.empresa, is_secuencia, ii_ann )
return true
end function

public function boolean wf_carga_producto (ref string as_codigo, ref string ls_descripcion, ref string as_modelo);if as_modelo = '' then
	if isnull(as_codigo) then return false
	  SELECT inmprodu.prod_descripcion,   
				inmprodu.prod_empaque,     
				inamedid_a.medi_cantidad,   
				inamedid_b.medi_cantidad,
				inmprodu.prod_peso,
				inmprodu.prod_cubicaje,
				inmprodu.prod_precio1,
				inmprodu.prod_medida,
				inmprodu.prod_costo_promedio,
				inmprodu.prod_descuento_siono,
				inmprodu.prod_descuento,
				inmprodu.prod_descuento_maximo,
				inmprodu.prod_costo_fob,
				inmprodu.prod_producto_dos,
				inmprodu.prod_foto_dir
		 INTO :ls_descripcion,   
				:il_empaque,   
				:ii_cantidad_unidad,   
				:ii_cantidad_empaque,
				:id_peso,
				:id_cubicaje,
				:id_precio_prod,
				:is_unidad,
				:id_costo_cif,
				:ii_acepta_descuento,
				:id_porc_descuento,
				:id_porc_maximo,
				:id_costo_fob,
				:is_modelo,
				:is_foto
		 FROM inmprodu,   
				inamedid inamedid_a,   
				inamedid inamedid_b  
		WHERE ( inamedid_a.medi_medida = inmprodu.prod_medida ) and  
				( inmprodu.prod_empaque_um = inamedid_b.medi_medida ) and  
				( ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
				( inmprodu.prod_empresa = :str.empresa ) AND  
				( inmprodu.prod_producto = :as_codigo ) )   ;
			if sqlca.sqlcode = 100 then
				  SELECT max(inmprodu.prod_descripcion),   
							max(inmprodu.prod_empaque),     
							max(inamedid_a.medi_cantidad),   
							max(inamedid_b.medi_cantidad),
							max(inmprodu.prod_peso),
							max(inmprodu.prod_cubicaje),
							max(inmprodu.prod_precio1),
							max(inmprodu.prod_medida),
							max(inmprodu.prod_costo_promedio),
							max(inmprodu.prod_descuento_siono),
							max(inmprodu.prod_descuento),
							max(inmprodu.prod_descuento_maximo),
							max(inmprodu.prod_costo_fob),
							max(inmprodu.prod_producto),
							max(inmprodu.prod_producto_dos),
							max(inmprodu.prod_foto_dir)
					 INTO :ls_descripcion,   
							:il_empaque,   
							:ii_cantidad_unidad,   
							:ii_cantidad_empaque,
							:id_peso,
							:id_cubicaje,
							:id_precio_prod,
							:is_unidad,
							:id_costo_cif,
							:ii_acepta_descuento,
							:id_porc_descuento,
							:id_porc_maximo,
							:id_costo_fob,
							:as_codigo,
							:as_modelo,
							:is_foto
					 FROM inmprodu,   
							inamedid inamedid_a,   
							inamedid inamedid_b  
					WHERE ( inamedid_a.medi_medida = inmprodu.prod_medida ) and  
							( inmprodu.prod_empaque_um = inamedid_b.medi_medida ) and  
							( ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
							( inmprodu.prod_empresa = :str.empresa ) AND  
							( inmprodu.prod_barra = :as_codigo ) )   ;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al recuperar datos del producto barra '+sqlca.sqlerrtext,1,1,'E')
							return false
						end if
					is_modelo = as_modelo
					dw_2.setitem(dw_2.getrow(),'dpro_codigo_item',as_codigo)

			elseif sqlca.sqlcode = -1 then
				gf_mensaje('','Error al recuperar datos del producto '+sqlca.sqlerrtext,1,1,'E')
				return false
			end if

else
  SELECT inmprodu.prod_descripcion,   
				inmprodu.prod_empaque,     
				inamedid_a.medi_cantidad,   
				inamedid_b.medi_cantidad,
				inmprodu.prod_peso,
				inmprodu.prod_cubicaje,
				inmprodu.prod_precio1,
				inmprodu.prod_medida,
				inmprodu.prod_costo_promedio,
				inmprodu.prod_descuento_siono,
				inmprodu.prod_descuento,
				inmprodu.prod_descuento_maximo,
				inmprodu.prod_costo_fob,
				inmprodu.prod_producto,
				inmprodu.prod_foto_dir
		 INTO :ls_descripcion,   
				:il_empaque,   
				:ii_cantidad_unidad,   
				:ii_cantidad_empaque,
				:id_peso,
				:id_cubicaje,
				:id_precio_prod,
				:is_unidad,
				:id_costo_cif,
				:ii_acepta_descuento,
				:id_porc_descuento,
				:id_porc_maximo,
				:id_costo_fob,
				:as_codigo,
				:is_foto
		 FROM inmprodu,   
				inamedid inamedid_a,   
				inamedid inamedid_b  
		WHERE ( inamedid_a.medi_medida = inmprodu.prod_medida ) and  
				( inmprodu.prod_empaque_um = inamedid_b.medi_medida ) and  
				( ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
				( inmprodu.prod_empresa = :str.empresa ) AND  
				( inmprodu.prod_producto_dos = :as_modelo ) )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al recuperar datos del producto '+sqlca.sqlerrtext,1,1,'E')
				return false
			end if
		is_modelo = as_modelo
		dw_2.setitem(dw_2.getrow(),'dpro_codigo_item',as_codigo)
	
end if

id_ultima_cantidad = 0
id_ultimo_precio    = 0

 DECLARE cur_ultima CURSOR FOR  
  SELECT isnull(faddiari.facd_cantidad,0),   
         isnull(faddiari.facd_precio_unidad_producto,0)  
    FROM faddiari,   
         fatdiari  
   WHERE ( fatdiari.fact_g_financiero = faddiari.facd_g_financiero ) and  
         ( fatdiari.fact_empresa = faddiari.facd_empresa ) and  
         ( fatdiari.fact_tipo = faddiari.facd_tipo ) and  
         ( fatdiari.fact_no_pedido = faddiari.facd_no_pedido ) and  
         ( fatdiari.fact_ann = faddiari.facd_ann ) and  
         ( ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
         ( faddiari.facd_empresa = :str.empresa ) AND  
         ( faddiari.facd_codigo_item = :as_codigo ) AND  
         ( fatdiari.fact_cliente = :il_tercero ) AND
		( fatdiari.fact_estado = 'I'))   
	ORDER BY fatdiari.fact_fecha DESC  ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al declarar cursor '+sqlca.sqlerrtext,1,1,'E')
		return false
	end if
	
	open cur_ultima;
	
	fetch cur_ultima into :id_ultima_cantidad, :id_ultimo_precio; 
	
	close cur_ultima;

return true

end function

on w_captura_proformas_productos_no_creados.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_6=create dw_6
this.st_1=create st_1
this.dw_7=create dw_7
this.dw_4=create dw_4
this.dw_5=create dw_5
this.pb_2=create pb_2
this.st_2=create st_2
this.pb_3=create pb_3
this.st_3=create st_3
this.cb_3=create cb_3
this.dw_9=create dw_9
this.uo_1=create uo_1
this.dw_10=create dw_10
this.dw_11=create dw_11
this.pb_prefactura=create pb_prefactura
this.dw_8=create dw_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.dw_6
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.dw_7
this.Control[iCurrent+8]=this.dw_4
this.Control[iCurrent+9]=this.dw_5
this.Control[iCurrent+10]=this.pb_2
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.pb_3
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.cb_3
this.Control[iCurrent+15]=this.dw_9
this.Control[iCurrent+16]=this.uo_1
this.Control[iCurrent+17]=this.dw_10
this.Control[iCurrent+18]=this.dw_11
this.Control[iCurrent+19]=this.pb_prefactura
this.Control[iCurrent+20]=this.dw_8
end on

on w_captura_proformas_productos_no_creados.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_6)
destroy(this.st_1)
destroy(this.dw_7)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.pb_3)
destroy(this.st_3)
destroy(this.cb_3)
destroy(this.dw_9)
destroy(this.uo_1)
destroy(this.dw_10)
destroy(this.dw_11)
destroy(this.pb_prefactura)
destroy(this.dw_8)
end on

event ue_pre_aceptar;//Override
dw_1.Accepttext()

this.postevent("ue_aceptar")

end event

event ue_adicionar;//Override
decimal{4} ld_cantidad
if datawindow = 1 then	
	dw_1.reset()
	dw_2.object.cargos.expression = "'"+string(0.00,'#,##0.00')+"'"	//Para blanquear los cargos
	dw_2.reset()
	dw_7.reset()
	dw_7.insertrow(1)
	dw_7.setitem(1,'dgmempre_empr_bodegas_definidas',ii_bodegas_definidas)
	dw_7.setitem(1,'bodega1',is_b1); dw_7.setitem(1,'bodega2',is_b2); dw_7.setitem(1,'bodega3',is_b3); dw_7.setitem(1,'bodega4',is_b4); dw_7.setitem(1,'bodega5',is_b5); dw_7.setitem(1,'bodega6',is_b6); dw_7.setitem(1,'bodega7',is_b7)
	dw_7.bringtotop = true
	dw_1.insertrow(1)
	//Pone invisible el insertar	
	dw_1.setitem(1,'prof_g_financiero',str.g_financiero)
	dw_1.setitem(1,'prof_empresa',str.empresa)
	dw_1.setitem(1,'prof_ann',ii_ann)
	dw_1.setitem(1,'prof_fecha',date(gf_fecha_serv()))
	dw_1.setitem(1,'prof_tipo_venta',2) //exterior
	dw_1.setitem(1,'prof_estado','A')
	dw_1.setitem(1,'prof_usuario',str.usuario)	
	dw_1.setfocus()
	dw_1.setcolumn('prof_ruc_cliente')
	idec_gastos = 0
	wf_orden_nueva()
	dw_1.setitem(1,'captura_por_bulto',ii_opcion_captura)
	//dw_1.SetItemStatus(1, 0, Primary!, New!)
else
	if dw_1.rowcount() > 0 then
		if (dw_1.getitemString(1,"prof_estado")) <> 'A' then
			gf_mensaje("Atencion Sr. Usuario","No se puede Modificar una Factura Actualizada, Verifique !!!.",1,1,"E")
			return
		end if	
	end if
	
	if dw_2.getrow() > 0 then	
		ld_cantidad = dw_2.getitemnumber(dw_2.rowcount(), 'dpro_cantidad')
		if isnull(ld_cantidad) then ld_cantidad = 0
		if ( dw_2.getitemstring(dw_2.getrow(), 'dpro_codigo_item') <> '' or &
			not isnull(dw_2.getitemstring(dw_2.getrow(), 'dpro_codigo_item'))) and  &
			ld_cantidad <> 0 then
			dw_2.scrolltorow(dw_2.insertrow(0))
			dw_2.setitem(dw_2.getrow(),'dpro_g_financiero',str.g_financiero)
			dw_2.setitem(dw_2.getrow(),'dpro_empresa',str.empresa)
			dw_2.setitem(dw_2.getrow(),'dpro_usuario',str.usuario)
			//Para repetir el ultimo item capturado
//			dw_7.retrieve(str.g_financiero, str.empresa, is_item)			
//			dw_2.setitem(dw_2.getrow(),'dpro_codigo_item',is_item)
//			dw_2.setitem(dw_2.getrow(),'dpro_descripcion_alterna',is_descrip)
//			dw_2.setitem(dw_2.getrow(),'dpro_unidad_venta',is_unidad)			
//			dw_2.setitem(dw_2.getrow(),'dpro_unidad_producto',is_unidad)		
//			dw_2.setitem(dw_2.getrow(),'dpro_precio_unidad_producto', id_precio)
//			dw_2.setitem(dw_2.getrow(),'dpro_precio_original', id_precio)			
//			dw_2.setitem(dw_2.getrow(),'dpro_costo_cif', id_costo_cif)			
//			dw_2.setitem(dw_2.getrow(),'dpro_metal_pendiente',ii_metal_pendiente)		
			//Ventana de Ventas
		end if
	else
		dw_2.scrolltorow(dw_2.insertrow(0))
		dw_2.setitem(dw_2.getrow(),'dpro_g_financiero',str.g_financiero)
		dw_2.setitem(dw_2.getrow(),'dpro_empresa',str.empresa)
		dw_2.setitem(dw_2.getrow(),'dpro_usuario',str.usuario)		
		is_foto = ''
		id_ultima_cantidad = 0
		id_ultimo_precio = 0
	
	end if
	dw_2.setfocus()
	if pos(str.empr_acceso_especial, 'HPSA') > 0 then
		dw_2.setcolumn('dpro_modelo')
	else
		dw_2.setcolumn('dpro_codigo_item')
	end if
end if

end event

event key;//override
end event

event close;Window lw_frame

lw_frame = ParentWindow()

If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_sheet_closed")
 End If
if isvalid(this) then close(this)
if isvalid(w_foto_producto) then close(w_foto_producto)
if isvalid(w_ventas_producto) then close(w_ventas_producto)
end event

event ue_hay_data;//Override
end event

event resize;//Override
//dw_1.Resize(This.Width - 170, This.Height - 390)
//gb_1.width  = this.width  - 63
//gb_1.height = this.height - 180
//st_nom_ventana.x = 28
//st_nom_ventana.y = this.height - 180
if ii_opcion_captura = 1 then
	dw_2.width = newwidth - 50
	dw_1.width = newwidth - 50
else
	dw_2.width = newwidth - 100
	dw_1.width = newwidth - 100
end if
dw_2.height= newheight - 600
dw_7.y = newheight - 520
//dw_8.y = newheight - 250
//pb_3.y = newheight - 160
//st_3.y = newheight - 165
end event

event open;//override
this.y = 0
this.x = 805
integer  i
string ls_cadena, ls_formato_proforma
dw = dw_1

ii_metal_pendiente = message.doubleparm

This.Icon = str.icono

//this.postevent("ue_post_open")
ii_opcion_captura = 1

//if ii_opcion_captura = 1 then
	dw_2.dataobject = 'dw_detalle_proformas_bultos2'
//else
//	dw_2.dataobject = 'dw_detalle_proformas2'
//end if

This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)

str.frame.SetRedraw ( True )

datawindowchild ldwc_plan
string ls_dw
idec_gastos = 0
dw_1.settransobject(sqlca);			
dw_2.settransobject(sqlca);	
dw_5.settransobject(sqlca);	
dw_6.settransobject(sqlca);
dw_7.settransobject(sqlca);
//dw_8.settransobject(sqlca);
dw_9.settransobject(sqlca);
dw_10.settransobject(sqlca);  //Total de la Orden a Facturar, para modificar si cobraran algo adicional
dw_10.insertrow(1)
dw_11.settransobject(sqlca);
dw_8.insertrow(1)

dw_11.getchild('ddia_mg_cuenta', ldwc_plan)
ldwc_plan.settransobject(sqlca)
ldwc_plan.retrieve(str.g_financiero, str.empresa)
ldwc_plan.insertrow(1)

dw_7.insertrow(1)

  SELECT dgmempre.empr_bodegas_definidas, empr_bodega1  , empr_bodega2 , empr_bodega3, empr_bodega4, empr_bodega5, empr_bodega6, empr_bodega7
    INTO :ii_bodegas_definidas , :is_b1, :is_b2, :is_b3, :is_b4, :is_b5, :is_b6, :is_b7  
    FROM dgmempre  
   WHERE ( dgmempre.empr_g_financiero = :str.g_financiero ) AND  
         ( dgmempre.empr_empresa = :str.empresa )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al Buscar Bodegas Definidas '+sqlca.sqlerrtext,1,1,'E')
	end if

dw_7.setitem(1,'dgmempre_empr_bodegas_definidas',ii_bodegas_definidas)
dw_7.setitem(1,'bodega1',is_b1); dw_7.setitem(1,'bodega2',is_b2); dw_7.setitem(1,'bodega3',is_b3); dw_7.setitem(1,'bodega4',is_b4); dw_7.setitem(1,'bodega5',is_b5); dw_7.setitem(1,'bodega6',is_b6); dw_7.setitem(1,'bodega7',is_b7)

dw_6.getchild('formato',idwc_formatos)
idwc_formatos.settransobject(sqlca)
idwc_formatos.retrieve(str.empresa, 'PR')
dw_6.insertrow(1)
dw_6.setitem(1,'formato','1')
ii_ann = year(date(gf_fecha_serv()))
datawindow = 1


if ls_dw = '' then ls_dw = 'dw_imprimir_proforma_no_productos'
if POS(str.empr_acceso_especial,'HPSA') > 0 then
	ls_dw = 'dw_imprimir_proforma_hpsa_2'
end if

dw_4.dataobject = ls_dw
dw_4.settransobject(sqlca)

dw_1.getchild('prof_tipo', idwc_tipo)
//dw_1.getchild('prof_cliente', idwc_cliente)
dw_1.getchild('prof_ruc_cliente', idwc_cliente)
dw_1.getchild('vendedor', idwc_vendedores)
dw_1.getchild('prof_dias_pago', idwc_dias)
idwc_tipo.settransobject(sqlca)
idwc_cliente.settransobject(sqlca)
idwc_vendedores.settransobject(sqlca)
idwc_dias.settransobject(sqlca)
idwc_tipo.retrieve(str.g_financiero, str.empresa, 'FA')
idwc_cliente.retrieve(str.g_financiero, str.empresa)
idwc_vendedores.retrieve(str.g_financiero, str.empresa)
idwc_vendedores.insertrow(1)
idwc_dias.retrieve(str.g_financiero, str.empresa)

datawindowchild ldwc_vendedor
dw_4.getchild('fadvenpr_vpro_vendedor', ldwc_vendedor)
ldwc_vendedor.settransobject(sqlca)
ldwc_vendedor.retrieve(str.g_financiero, str.empresa)

this.triggerevent('ue_adicionar')

dw_1.setitem(1,'captura_por_bulto',ii_opcion_captura)

//Recupera la secuencia siguiente y da opcion para buscar una
wf_orden_nueva()

	if pos(upper(str.empr_acceso_especial),'SURTI') > 0 then
		dw_2.Modify("dpro_monto_final.Edit.DisplayOnly=No")			
	else
		dw_2.Modify("dpro_monto_final.Edit.DisplayOnly=Yes")		
	end if

for i = 1 to ii_bodegas_definidas
	if i = 1 then
		ls_cadena = '"'+string(i)+"~t"+string(i)
		if ii_bodegas_definidas = 1 then
			ls_cadena = ls_cadena + '"'
		end if
	else
		ls_cadena = ls_cadena + "/"+string(i)+"~t"+string(i)
		if ii_bodegas_definidas = i then
			ls_cadena = ls_cadena + '"'
		end if
	end if
next
dw_2.Object.dpro_bodega.Values = ls_cadena

//m_fa_principal.m_edicin.m_insertar.visible = true
//m_fa_principal.m_edicin.m_insertar.enabled = true

str.frame.setmicrohelp('Cotizacion')
//il_tiempo = 150
//em_tiempo.text = string(150)
//timer(1)

//this.height = w_fa_fondo.height - 50
pb_3.picturename = str.path+'\Art\dba_cancel.bmp'						

dwItemStatus l_status
l_status = dw_1.GetItemStatus(1, 0, Primary!)
IF l_status = NewModified! or l_status = DataModified! THEN	
	dw_1.SetItemStatus(1, 0, Primary!, New!)
end if
end event

event ue_print;////override
long ll_tercero
string ls_saldo, ls_numero_palabra, ls_setprn
decimal{2} ld_saldo, ld_final
dw_4.settransobject(sqlca)
if is_secuencia = '' then return

if dw_1.getitemstring(1,'prof_estado') = 'A' then
	this.triggerevent('ue_aceptar')
end if

dw_4.retrieve(str.g_financiero, str.empresa, is_secuencia , ii_ann)
//
if dw_4.rowcount() = 0 then return
//
//st_1.visible = true
//dw_6.visible = true
//Asigna el saldo del cliente
ll_tercero = dw_4.getitemnumber(1,'prof_cliente')
ld_saldo = gf_saldo_anterior_new( ll_tercero, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)
ls_saldo = string(ld_saldo, '$ ##,##0.00')
if dw_4.Describe("saldo.x") <> "?" and dw_4.Describe("saldo.x") <> "!" then &
	dw_4.object.saldo.expression = "'" + ls_saldo + "'"

//asigna el valor del monto en letras
ld_final = dw_4.getitemnumber(1, "prof_monto_final")
ls_numero_palabra = " *** "+upper(gf_numerlet( round(ld_final,2)  ,1))+" ***"
//if simple
if dw_4.Describe("num_palabra.x") <> "?" and dw_4.Describe("num_palabra.x") <> "!" then &
	dw_4.object.num_palabra.expression = "'" + ls_numero_palabra + "'"

dw_4.object.datawindow.print.preview = 'yes'
dw_4.object.datawindow.print.preview.zoom = 100
dw_4.object.nom_empresa.expression = "'"+str.nombre_empresa+"'"
//
PrintSetPrinter (str.printer1)

if dw_4.Describe("ver.x") <> "?" and dw_4.Describe("ver.x") <> "!" then &
	dw_4.object.ver.expression = "'" + string(1) + "'"

dw_4.object.datawindow.print.preview = 'yes'

if str.contabiliza = 1 then
	dw_4.visible = true
	OpenWithParm(w_dw_print_options, dw_4)
	If Message.DoubleParm = -1 Then Return
end if

string ls_result
ls_result = dw_4.Describe('mantener.expression')
if ls_result = "'1'" then
	if dw_4.Describe("ver.x") <> "?" and dw_4.Describe("ver.x") <> "!" then &
		dw_4.object.ver.expression = "'" + string(1) + "'"
else
	if dw_4.Describe("ver.x") <> "?" and dw_4.Describe("ver.x") <> "!" then &
		dw_4.object.ver.expression = "'" + string(0) + "'"
end if

dw_4.Print(True)
dw_4.visible = false

//Imprime las otras dos copias de la factura
if str.contabiliza = 0 and pos(str.empr_acceso_especial, 'GOLD,') > 0 then
	ls_setprn = str.printer2
	PrintSetPrinter (ls_setprn)
	dw_4.Print(True)
	ls_setprn = str.printer3
	PrintSetPrinter (ls_setprn)
	dw_4.Print(True)
end if

if dw_4.Describe("ver.x") <> "?" and dw_4.Describe("ver.x") <> "!" then &
	dw_4.object.ver.expression = "'" + string(1) + "'"

/********************/
//Imprime la orden de facturacion
//if dw_1.getitemstring(1,'prof_tipo_movimiento') <> 'O' then
//	cb_3.triggerevent('clicked')
//end if
/********************/
PrintSetPrinter (str.printer1)
dw_1.setfocus()
datawindow = 1
this.triggerevent('ue_adicionar')
end event

event ue_aceptar;integer  li_contador,ll_update,ll_update2,li_encontro,li_lin_ref,li_posicion,li_frac2, li_find, li_existe
integer  li_costo,anulado=0,li_linea_uno,li_linea_dos,indice, li_existe_detalle, li_empresa ,li_salvar
decimal  li_cantidad,li_cantid, li_cos_tran, ld_cantidad
datetime ldt_fecha,ldt_fecha_real
string   ls_documento,ls_aplic,ls_tipo,ls_medida,ls_producto,ls_concepto, fila, ls_conc,ls_error,ls_cuenta, ls_expresion, ls_doc
Long		ll_found, ll_ann,ll_secuencia, ll_bultos, ll_lter 
boolean  lb_existe, lb_entro
decimal{2} ldec_monto, ld_limite, ld_saldo
decimal{3} ld_peso, ld_cubicaje

dw_1.acceptText()
dw_2.acceptText()
//dw=dw_1  

if (dw_1.getitemNumber(1,"prof_cliente")) = 0 or isnull(dw_1.getitemNumber(1,"prof_cliente")) then
	gf_mensaje("Atencion Sr. Usuario","Debe asignar el cliente antes de guardar.",1,1,'E')
	dw_1.setcolumn("prof_cliente")
	return
end if	

if (dw_1.getitemString(1,"prof_estado")) <> 'A' then
	gf_mensaje("Atencion Sr. Usuario","No se puede Modificar un Pedido Actualizado, Verifique !!!.",1,1,"E")
	return
end if	

if isnull(dw_1.getitemNumber(1,"prof_dias_pago")) then
	gf_mensaje("Atencion Sr. Usuario","Debe asignar el Termino de Pago antes de guardar.",1,1,'E')
	dw_1.setcolumn("prof_dias_pago")
	return
end if	

sqlca.autocommit = false

indice = 0

ls_documento = dw_1.getitemstring(1,"prof_no_proforma")
is_secuencia = ls_documento
/*grabamos los datos del DW_1 de la tabla de INTMOVIM*////////////////
if dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = New! or &
	dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = NewModified! then 	
	
   indice = 1
	
	if (dw_1.getitemString(1,"prof_no_proforma")) = '' or isnull(dw_1.getitemString(1,"prof_no_proforma")) then
		gf_mensaje("Atencion Sr. Usuario","Debe Asignar un valor valido, Verifique.",1,1,"E")
		sqlca.autocommit = true
		return
	end if	
	
	//Valida que no se duplique el pedido
	li_existe = 1
	ll_secuencia = long(is_secuencia)
	
	do while li_existe > 0
	 //Que busque solo si es newmodified
	  SELECT count(*)  
		 INTO :li_existe  
		 FROM fatprofo2  
	   WHERE ( fatprofo2.prof_g_financiero = :str.g_financiero ) AND  
				( fatprofo2.prof_empresa = :str.empresa ) AND  
				( fatprofo2.prof_no_proforma = :is_secuencia ) AND  
				( fatprofo2.prof_ann = :ii_ann ) ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Validar la Existencia '+sqlca.sqlerrtext,1,1,'E')
			end if		
			if li_existe > 0 then
				ll_secuencia ++
				is_secuencia = string(ll_secuencia)
				lb_entro  = true			
			end if			
	loop		
	
	if lb_entro then
		dw_1.setitem(1,'prof_no_proforma',is_secuencia)
	   //Si se busca el numero de documento y existe, debe asignar el nuevo documento en el detalle de facturas y articulos
	end if
	
	
	/*Actualiza el Encabezado*/
	ll_update = dw_1.update()
	
	/*Actualiza la Secuencia en Dgmserie*/
	if ll_update =1 then
//		 wf_asigna_vendedor()				 
		 commit using sqlca;
	else
		ls_error =sqlca.sqlerrtext
		rollback using sqlca;
		sqlca.autocommit = true
		gf_Mensaje("---Atención---","¡Error al Actualizar el encabezado ! "+ls_error,1,1,'E')
		ib_aceptar = False
		is_actualiza=''
		return
	end if
 	sqlca.autocommit = true
	 
//	if ll_secuencia <> ii_secuencia then
//		 messagebox('Atención ',' La Secuencia ha Cambiado a: '+string(ll_secuencia))
//	end if
	/**/
else
  if dw_2.rowcount() > 0 then
	 ldec_monto  = dw_2.getitemnumber(1,'monto_total')
	 ld_peso     = dw_2.getitemnumber(1,'peso_total')
	 ld_cubicaje = dw_2.getitemnumber(1,'cubicaje_total')	 
	 ll_bultos   = dw_2.getitemnumber(1,'bultos_total')	 
  else
	 ldec_monto  = 0
	 ld_peso 	 = 0
	 ld_cubicaje = 0
	 ll_bultos   = 0
  end if

  //Actualiza el total de peso, cubicaje y bultos
    UPDATE fatprofo2  
     SET prof_bultos_total = :ll_bultos,   
         prof_cubicaje_total = :ld_cubicaje,   
         prof_peso_total = :ld_peso
   WHERE ( fatprofo2.prof_g_financiero = :str.g_financiero ) AND  
         ( fatprofo2.prof_empresa = :str.empresa ) AND  
         ( fatprofo2.prof_no_proforma = :is_secuencia ) AND  
         ( fatprofo2.prof_ann = :ii_ann ) ;
	if sqlca.sqlcode = -1 then
			ls_error =sqlca.sqlerrtext
		rollback using sqlca;
		sqlca.autocommit = true
		ib_aceptar = False
		gf_Mensaje("---Atención---","¡Error al Actualizar el encabezado / Totales! "+ls_error,1,1,'E')
		is_actualiza=''
		return
	end if  
	
  dw_1.setitem(1,'prof_monto_total',ldec_monto)
  if isnull(idec_gastos) then idec_gastos = 0 
  if isnull(idec_descuento) then idec_descuento = 0 
  dw_1.setitem(1,'prof_monto_final',ldec_monto + idec_gastos - idec_descuento)
  dw_1.accepttext()	
  ll_update = dw_1.update()
  if ll_update = 1 then
//		wf_asigna_vendedor()	
		commit;
		sqlca.autocommit = true
	else
		ls_error =sqlca.sqlerrtext
		rollback using sqlca;
		sqlca.autocommit = true
		ib_aceptar = False
		gf_Mensaje("---Atención---","¡Error al Actualizar el encabezado ! "+ls_error,1,1,'E')
		is_actualiza=''
		return
	end if
	dw_1.setitem(1,'captura_por_bulto',ii_opcion_captura)
//	ll_secuencia = long(dw_1.getitemstring(1,'no_orden'))
end if

sqlca.autocommit = false

/*grabamos los datos de DW_2 en la tabla INDTRANS*/
dwItemStatus ls_status
// Borra registros en blanco

for li_contador = 1 to dw_2.rowcount()
	ls_producto = dw_2.getitemstring(li_contador,"dpro_codigo_item")
	ld_cantidad = dw_2.getitemnumber(li_contador,"dpro_cantidad")
	dw_2.setitem(li_contador,'dpro_g_financiero',str.g_financiero)
	dw_2.setitem(li_contador,'dpro_empresa',str.empresa)
	dw_2.setitem(li_contador,'dpro_no_proforma',is_secuencia)
	dw_2.setitem(li_contador,'dpro_ann',ii_ann)
	dw_2.setitem(li_contador,"dpro_linea",li_contador)		
	dw_2.setitem(li_contador,"dpro_index",li_contador)
	dw_2.setitem(li_contador,"dpro_usuario",str.usuario)		
	
Next
//
li_salvar=1

If li_salvar = 1 then //Si todas las bodegas/ubicacion destino existen que salve
													
	ll_update =dw_2.update()
			if ll_update = -1 then
				ls_error =sqlca.sqlerrtext
				rollback using sqlca;
				sqlca.autocommit = true
				ib_aceptar = False
				is_actualiza=''
				gf_Mensaje("---Aviso---","¡Error al Actualizar Detalle del Pedido! "+ls_error,1,1,'E')
				return
			end if
		
	  if ll_update = 1 then
		  sqlca.autocommit = true
		  
			 update fatprofo2 set prof_costos_total =
		 (select sum(fadprofo2.dpro_costo_total)
			from fadprofo2
			 where (fadprofo2.dpro_g_financiero = fatprofo2.prof_g_financiero) and
					 (fadprofo2.dpro_empresa = fatprofo2.prof_empresa) and
					 (fadprofo2.dpro_no_proforma = fatprofo2.prof_no_proforma) and
					 (fadprofo2.dpro_ann = fatprofo2.prof_ann ) )
			where (fatprofo2.prof_g_financiero = :str.g_financiero ) and
					(fatprofo2.prof_empresa = :str.empresa) and
					(fatprofo2.prof_no_proforma = :is_secuencia ) and
					(fatprofo2.prof_ann = :ii_ann ) ;
					if sqlca.sqlcode = -1 then
						ls_error =sqlca.sqlerrtext
						rollback using sqlca;
						sqlca.autocommit = true
						gf_Mensaje("---Atención---","¡Error al Actualizar Costos ! "+ls_error,1,1,'E')
						ib_aceptar = False
						is_actualiza=''
						return						
					end if		
		  
		  ib_aceptar = True

		  /* Refresca los datos del datawindows cuando la Actualizacion fue correcta */
		  dw_1.setredraw(false)
		  dw_2.setredraw(false)				
		  long ll_fila
		  ll_fila = dw_2.getrow()
		  ld_limite = dw_1.getitemnumber(1,'limite')
		  if dw_1.retrieve(str.g_financiero, str.empresa, is_secuencia, ii_ann ) > 0 then
//			dw_1.setitem(dw_1.getrow(),'vendedor',ii_vendedor)
			ll_lter = dw_1.getitemnumber(1,'prof_cliente')
			ld_saldo = gf_saldo_anterior_new( ll_lter, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)		
			if isnull(ld_saldo) then ld_saldo = 0.00
			dw_1.setitem(1,'saldo',ld_saldo)
			if ld_limite = 0 then
				ld_limite = idwc_cliente.getitemnumber(idwc_cliente.getrow(), 'clie_limite_credito')						
			end if
			dw_1.setitem(1,'limite',ld_limite)					
			dw_1.setitem(1,'captura_por_bulto',ii_opcion_captura)
		  end if
		  dw_2.retrieve(str.g_financiero, str.empresa, is_secuencia, ii_ann )
		  if dw_2.rowcount() = 0 then
			 datawindow = 2
			 dw = dw_2
			 this.triggerevent("ue_adicionar")
			 ll_fila = 1
		  end if
		  
		  dw_2.scrolltorow(ll_fila)
		  dw_1.setredraw(true)
		  dw_2.setredraw(true)	
		  /////////////mensaje("Atención","Acualización Existosa","")
		  
		  str.frame.setmicrohelp('Pedido Guardado.')
		  commit using sqlca ; 		  
		  
		else
			ls_error =sqlca.sqlerrtext
			rollback using sqlca;
			sqlca.autocommit = true
			ib_aceptar = False
			is_actualiza=''
			gf_Mensaje("---Aviso---","¡Error al Actualizar! "+ls_error,1,1,'E')
		end if
end if

sqlca.autocommit = true
//mensaje('Informacion','Actualizacion Exitosa','')
is_actualiza=''

end event

event timer;call super::timer;il_segundos = il_segundos + 1

if il_segundos > il_tiempo then
	wf_recupera()
	il_segundos = 0
end if
end event

event ue_busqueda;call super::ue_busqueda;//
String  ls_find,ls_codigo
integer li_c, li_b
long    ll_lter, ll_fila
string  ls_lter,ls_des
decimal{2} ld_saldo, ld_limite
Datawindow        dww
str_dg_dynamic_find	lstr_df

	lstr_df.texto_campo [1,1] = "fatprofo2.prof_no_proforma"
	lstr_df.texto_campo [1,2] = "Pedido"
	lstr_df.texto_campo [1,3] = "prof_no_proforma"
	lstr_df.texto_campo [1,4] = 'V'
	lstr_df.texto_campo [1,5] = '220'	
	lstr_df.texto_campo [2,1] = "fatprofo2.prof_a_nombre"
	lstr_df.texto_campo [2,2] = "A Nombre de"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '650'
	lstr_df.texto_campo [3,1] = "fatprofo2.prof_fecha"
	lstr_df.texto_campo [3,2] = "Fecha"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [3,5] = '315'
	lstr_df.texto_campo [4,1] = "case fatprofo2.prof_estado when 'P' then 'PASADO' else 'PENDIENTE' end prof_estado"
	lstr_df.texto_campo [4,2] = "Estado"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '300'
	lstr_df.texto_campo [5,1] = "fatprofo2.prof_monto_final"
	lstr_df.texto_campo [5,2] = "Monto"
	lstr_df.texto_campo [5,3] = ""
	lstr_df.texto_campo [5,4] = 'V'
	lstr_df.texto_campo [5,5] = '240'


	lstr_df.tabla = " fatprofo2 "
		
	lstr_df.tabla_where = &
				"WHERE (fatprofo2.prof_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(fatprofo2.prof_empresa = " + string(str.empresa) + ") 	and " +&
 						 "(fatprofo2.prof_ann = " + string(ii_ann) + ")" 
	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm

If len (ls_find) = 0 Then Return
	
ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)
is_secuencia = ls_codigo
dw_2.object.cargos.expression = "'"+string(0.00,'#,##0.00')+"'"	//Para blanquear los cargos
dw_2.object.descuento.expression = "'"+string(0.00,'#,##0.00')+"'"	//Para blanquear los descuentos
if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo, ii_ann ) > 0 then
	is_tipo = dw_1.getitemstring(1,'prof_tipo')
	select max(vpro_vendedor)
	into :ii_vendedor
	from fadvenpr
	where vpro_g_financiero = :str.g_financiero and
			vpro_empresa		= :str.empresa and
			vpro_no_proforma		= :is_secuencia and
			vpro_ann				= :ii_ann ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al validar vendedor '+sqlca.sqlerrtext,1,1,'E')
			end if
	dw_1.setitem(1, 'vendedor', ii_vendedor)
	idec_gastos = dw_1.getitemnumber(dw_1.getrow(),'prof_gastos_total')
	dw_2.object.cargos.expression = "'"+string(idec_gastos,'##0.00')+"'"	
	idec_descuento = dw_1.getitemnumber(dw_1.getrow(),'prof_por_descuento')
	dw_2.object.descuento.expression = "'"+string(idec_descuento,'##0.00')+"'"		
	ll_lter = dw_1.getitemnumber(1,'prof_cliente')
	il_tercero = ll_lter
	ld_saldo = gf_saldo_anterior_new( ll_lter, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)		
	if isnull(ld_saldo) then ld_saldo = 0.00
	dw_1.setitem(1,'saldo',ld_saldo)
	
	ll_fila = idwc_cliente.find('terc_tercero = '+string(ll_lter),1,idwc_cliente.rowcount())
	if ll_fila > 0 then
		idwc_cliente.scrolltorow(ll_fila)
	end if

	ld_limite = idwc_cliente.getitemnumber(idwc_cliente.getrow(), 'clie_limite_credito')						
	dw_1.setitem(1,'limite',ld_limite)		
	dw_1.setitem(1,'captura_por_bulto',ii_opcion_captura)
end if
dw_2.reset()
dw_2.retrieve(str.g_financiero, str.empresa, ls_codigo, ii_ann )
is_item = ''
dw_2.scrolltorow(dw_2.rowcount())
dw_2.setfocus()
end event

event ue_eliminar;//
//override
if datawindow = 1 then	
	if dw_1.getitemstring(1,'prof_estado') <> 'A' then
		gf_mensaje('','No Puede Eliminar una Factura Actualizada, Verifique !!!',1,1,'E')
		return
	end if
	if gf_mensaje('','Esta Seguro de Eliminar la Proforma ?',2,2,'E') = 1 then
		sqlca.autocommit = false
	    DELETE FROM fadprofo2  
			WHERE ( fadprofo2.dpro_g_financiero = :str.g_financiero ) AND  
					( fadprofo2.dpro_empresa = :str.empresa ) AND  
					( fadprofo2.dpro_no_proforma = :is_secuencia ) AND  
					( fadprofo2.dpro_ann = :ii_ann ) ;

			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al eliminar detalle ' + sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if

		  DELETE FROM fadproca  
			WHERE ( fadproca.prca_g_financiero = :str.g_financiero ) AND  
					( fadproca.prca_empresa = :str.empresa ) AND  
					( fadproca.prca_no_proforma = :is_secuencia ) AND  
					( fadproca.prca_ann = :ii_ann ) ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al eliminar gastos ' + sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if

	  DELETE FROM fadvenpr  
		WHERE ( fadvenpr.vpro_g_financiero = :str.g_financiero ) AND  
				( fadvenpr.vpro_empresa = :str.empresa ) AND  
				( fadvenpr.vpro_no_proforma = :is_secuencia ) AND  
				( fadvenpr.vpro_ann = :ii_ann ) ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al eliminar Vendedor ' + sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if

		  DELETE FROM fatprofo2  
			WHERE ( fatprofo2.prof_g_financiero = :str.g_financiero ) AND  
					( fatprofo2.prof_empresa = :str.empresa ) AND  
					( fatprofo2.prof_no_proforma = :is_secuencia ) AND  
					( fatprofo2.prof_ann = :ii_ann )  ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al eliminar encabezado ' + sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if
						
			commit;
			sqlca.autocommit = true
			this.triggerevent('ue_adicionar')			
	end if
else
	if dw_2.rowcount() > 0 then
		dw_2.deleterow(dw_2.getrow())
	else 
		messagebox("Atención","No hay registros para borrar!")
	end if
end if
end event

event activate;call super::activate;long ll_cliente, ll_fila
if dw_1.rowcount() > 0 then 
	ll_cliente = dw_1.getitemnumber(1,'prof_cliente')
end if

idwc_cliente.retrieve(str.g_financiero, str.empresa)

if ll_cliente <> 0 and not isnull(ll_cliente) then
ll_fila = idwc_cliente.find('terc_tercero = '+string(ll_cliente),1,idwc_cliente.rowcount())
	if ll_fila > 0 then
		idwc_cliente.scrolltorow(ll_fila)
	end if
end if

end event

event closequery;//override
long respuesta
constant int SW_HIDE = 0
dwItemStatus l_status
l_status = dw_1.GetItemStatus(1, 0, Primary!)

if dw.accepttext() = 1 then
	if dw.modifiedcount() > 0 or dw.deletedcount() > 0 then
//		respuesta = messagebox("Atención","El registro en "+this.title+ " no ha sido guardado!...~n ~t Desea guardarlo &
//ahora?",question!,YesNoCancel!) 
		respuesta = MessageBox("Atención -- " + str.nombre + " " + str.apellido, &
										"No se han Salvado los Cambios." + &
										"~n~n ¿Desea Salvar Ahora?", Question!, YesNoCancel!) 
		choose case respuesta 
			case 1 				
				this.triggerevent("ue_pre_aceptar")
			case 2
				
		   case 3
				return 1
		end choose
	end if
end if
ShowWindow(Handle(this), SW_HIDE)
//Para que al salir de la ventana libere las paginas
commit ;

gf_win_used_by_user(is_nombre, false)
end event

event ue_insertar;//Override
dw_2.setcolumn(1)
dw_2.scrolltorow(dw_2.insertrow(dw_2.Getrow()))
dw_2.setcolumn(1)

end event

event ue_save_as;//Override
integer li_respuesta
string ls_path, ls_title, ls_numero
//ls_title = this.title
datawindow dw_sa

if dw_4.visible then
	dw_sa = dw_4
else
	dw_sa = dw_2
end if
ls_numero = dw_1.getitemstring(1,'prof_no_proforma')
ls_title = 'PROFORMA NO INVENTARIO No '+ls_numero
li_respuesta = gf_mensaje('','Yes = Salvar a Excel, No = Otro Formato o Cancelar',4,1,'Q')
choose case li_respuesta
	case 1
		ls_path = nv_f.of_browseforfolder("Guardar Excel en ..",true)
		If Len(Trim(ls_path)) > 0 then		
			uf_save_dw_as_excel(dw_sa,ls_path+'\'+ls_title+'.xls')
		End If
	case 2
		dw_sa.saveas()
end choose

end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_captura_proformas_productos_no_creados
boolean visible = false
integer x = 46
integer y = 2040
integer width = 101
string text = ""
end type

type dw_1 from w_fa_padre`dw_1 within w_captura_proformas_productos_no_creados
event ue_escape pbm_dwescape
integer x = 27
integer y = 12
integer width = 4128
integer height = 588
integer taborder = 10
string dataobject = "dw_encab_proformas2"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event dw_1::ue_escape;//Override
////Codigo de Escape
//close(parent)
////parent.triggerevent("closequery")
////messagebox("Escape","Entro ...")
end event

event dw_1::ue_tabfinal;//override

end event

event dw_1::ue_down;//override
// Toma la Tecla que el usuario presione

CHOOSE CASE key
		
	CASE KeyF1! 
		
		This.Postevent("ue_helpcol")
		
	CASE	  Keyenter! 
		
	  This.Triggerevent("ue_entercol")
	  
END CHOOSE
end event

event dw_1::rbuttondown;//override
end event

event dw_1::ue_microayuda;//override
//override
//Para cuando pasa por encima del objeto
//Override
return 

//Integer li_pos, li_x, li_y,li_largo
//String ls_objeto, ls_col
//
//ls_objeto = This.GetObjectAtPointer()
//li_pos = pos  (ls_objeto,"~t")
//ls_col = left (ls_objeto, li_pos - 1)
//
////li_x	 = str.frame.GetActiveSheet ().PointerX () 
////li_largo = len("Haga click para ordenar por la Columna de " + this.describe(ls_col+".text"))*28
//
//
////li_y	 = str.frame.GetActiveSheet ().PointerY () - 200
//
//// Dependiendo de la Columna el Mensaje de Ayuda varía
//CHOOSE CASE ls_col
//	CASE 'prof_cliente_t'
//		this.Modify("prof_cliente_t.Font.Underline='1'")
//		this.Modify("prof_cliente_t.Color='63743'")
//	CASE ELSE
//		this.Modify("prof_cliente_t.Font.Underline='0'")
//		this.Modify("prof_cliente_t.Color='16316664'")
//
//END CHOOSE
end event

event dw_1::buttonclicked;call super::buttonclicked;long ll_codigo, ll_max
integer li_encontro, li_ann
if dwo.name = 'b_copiar' then
	if dw_2.rowcount() = 0 then return
	li_ann = year(date(gf_fecha_serv()))
	
	select max(convert(numeric(10), prof_no_proforma ))
	into	:ll_max
	from fatprofo2
	where prof_g_financiero = :str.g_financiero and
			prof_empresa		= :str.empresa and
			prof_ann				= :li_ann ;
		if sqlca.sqlcode = -1  then
			gf_mensaje('','Error al Buscar Secuencia '+sqlca.sqlerrtext,1,1,'E')		
			return
		end if
		
		if isnull(ll_max) then ll_max = 0		
		ll_max ++
		dw_8.setitem(1,'proforma',string(ll_max))
		dw_8.visible = true
		
elseif dwo.name = 'b_cliente' then
	
	String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error
	integer li_c, li_b
	long    ll_lter
	
	Datawindow        dww
	str_dg_dynamic_find	lstr_df
	
		lstr_df.texto_campo [2,1] = "ccmclien.clie_ref_anterior" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [2,2] = "Cuenta"
		lstr_df.texto_campo [2,3] = "clie_ref_anterior"
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '450'
		lstr_df.texto_campo [1,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [1,2] = "Descripción"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '700'		
		lstr_df.texto_campo [3,1] = "dgmterce.terc_tercero"
		lstr_df.texto_campo [3,2] = "Código Tercero"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [4,1] = "dgapais.pais_descripcion"
		lstr_df.texto_campo [4,2] = "País"
		lstr_df.texto_campo [4,3] = ""
		lstr_df.texto_campo [4,4] = 'V'
		lstr_df.texto_campo [4,5] = '550'
		
		lstr_df.tabla = " dgmterce, dgapais, ccmclien "
		
		
		lstr_df.tabla_where = &
					"WHERE ( dgmterce.terc_pais = dgapais.pais_pais ) and  " +&				
							 "(ccmclien.clie_g_financiero = " + string(str.g_financiero) + " and " +&
							 "ccmclien.clie_empresa = " + string(str.empresa) + ") 	and " +&
							"(dgmterce.terc_tercero = ccmclien.clie_tercero) and " +&
					      "(ccmclien.clie_estado = 'A' ) AND  " +&
					      "(ccmclien.clie_cuenta_mala <> 1 ) "  							
		
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	If len (ls_find) = 0 Then Return
		
		
	ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo1,"'"," ")
	ls_codigo1 = Trim(ls_codigo1)

	dw_1.setitem(1,'prof_ruc_cliente',ls_codigo1)
	dw_1.accepttext()
	dw_1.setcolumn('prof_ruc_cliente')
	dw_1.trigger event itemchanged(1,object,ls_codigo1)

elseif dwo.name = 'b_buscar' then
	parent.triggerevent('ue_busqueda')
end if
end event

event dw_1::clicked;datawindow = 1

//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto, ls_column
integer li_pos 
date 	ld_date,ld_ini_date, ld_hoy
accepttext()

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

ls_column = dwo.name

if ls_column = 'prof_cliente_t' then
	
	if row = 0  then return
	str_cc_formatos str_formato1		
	str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	str_formato1.tercero = dw_1.getitemNumber(1,"prof_cliente")
	Opensheetwithparm(w_estadocuenta,str_formato1,str.frame,2,original!)
elseif ls_column ='calendario' then
	ld_ini_date=date(dw_1.GetItemDateTime(dw_1.getrow(),"prof_fecha"))
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
	
end if

end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;datawindow = 1
end event

event dw_1::itemchanged;call super::itemchanged;string ls_columna, ls_nombre, ls_pasaporte, ls_codigo, ls_caracter, ls_cadena
integer i, li_vendedor, li_termino_pago, li_existe, li_ann_anterior
long    ll_tercero, ll_fila, ll_lter
decimal{2} ld_saldo, ld_limite, ldec_monto, ldec_final
datetime ldt_fecha_tran, ldt_fecha_anterior
this.accepttext()

ls_columna = this.getcolumnname()

choose case ls_columna
	case 'prof_no_proforma'

		ls_codigo = this.getitemstring(1,'prof_no_proforma')
		
		for i = 1 to len(ls_codigo)
			ls_caracter = mid(ls_codigo,i,1)
			if not isnumber(ls_caracter) then
				gf_mensaje('','Numero de Pedido Invalido, Verifique !!!',1,1,'E')
				this.setitem(1,'prof_no_proforma','')
				return 2
			end if
		next
		
		is_secuencia = ls_codigo
		dw_2.object.cargos.expression = "'"+string(0.00,'#,##0.00')+"'"	//Para blanquear los cargos
		dw_2.object.descuento.expression = "'"+string(0.00,'#,##0.00')+"'"	//Para blanquear los cargos
		if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo, ii_ann ) > 0 then
			idec_gastos = dw_1.getitemnumber(dw_1.getrow(),'prof_gastos_total')
			dw_2.object.cargos.expression = "'"+string(idec_gastos,'##0.00')+"'"	
			idec_descuento = dw_1.getitemnumber(dw_1.getrow(),'prof_por_descuento')
			dw_2.object.descuento.expression = "'"+string(idec_descuento,'##0.00')+"'"	
			ll_lter = dw_1.getitemnumber(1,'prof_cliente')
			il_tercero = ll_lter
			ld_saldo = gf_saldo_anterior_new( ll_lter, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)		
			if isnull(ld_saldo) then ld_saldo = 0.00
			dw_1.setitem(1,'saldo',ld_saldo)
			
			ll_fila = idwc_cliente.find('terc_tercero = '+string(ll_lter),1,idwc_cliente.rowcount())
			if ll_fila > 0 then
				idwc_cliente.scrolltorow(ll_fila)
			end if
		
			ld_limite = idwc_cliente.getitemnumber(idwc_cliente.getrow(), 'clie_limite_credito')						
			dw_1.setitem(1,'limite',ld_limite)		
			dw_1.setitem(1,'captura_por_bulto',ii_opcion_captura)
					
			dw_2.reset()
			dw_2.retrieve(str.g_financiero, str.empresa, ls_codigo, ii_ann )
			is_item = ''
			dw_2.scrolltorow(dw_2.rowcount())
			dw_2.setfocus()
		else
			parent.triggerevent('ue_adicionar')
			this.setitem(1,'prof_no_proforma',ls_codigo)
			ii_vendedor = 0
//			dw_1.setitem(1, 'vendedor', ii_vendedor)
			idec_gastos = 0
			dw_2.object.cargos.expression = "'"+string(idec_gastos,'##0.00')+"'"	
			dw_2.object.descuento.expression = "'"+string(idec_descuento,'##0.00')+"'"				
		end if		

	case 'prof_por_descuento'
		idec_descuento = double(data)
		dw_2.object.descuento.expression = "'"+string(idec_descuento,'##0.00')+"'"				
		if dw_2.rowcount() > 0 then
			 ldec_monto  = dw_2.getitemnumber(1,'monto_total')
		else
			 ldec_monto  = 0
		end if
		  if isnull(idec_gastos) then idec_gastos = 0 
		  if isnull(idec_descuento) then idec_descuento = 0 
		  ldec_final = ldec_monto + idec_gastos - idec_descuento
  		  dw_1.setitem(1,'prof_monto_final',ldec_final)
		  dw_1.accepttext()	 
		
	case 'prof_fecha_despacho', 'prof_tipo_movimiento', 'prof_despachado', 'prof_consignado', 'prof_pasaporte','prof_linea_aerea','prof_comentario', 'prof_a_nombre_direccion', 'prof_a_nombre'
		if dw_1.getitemstring(1,'prof_estado') = 'P' then
			sqlca.autocommit = false
			this.accepttext()
			if this.update() = -1 then
				gf_mensaje('','Error al Actualizar Fecha '+sqlca.sqlerrtext,1,1,'E')
				sqlca.autocommit = true
				rollback;
			end if
			commit ;
			sqlca.autocommit = true
		end if				
	case 'prof_ann'
		ii_ann = integer(data)
	case 'prof_condicion_pago'
		if data = 'CO' then
			this.setitem(1,'prof_dias_pago',0)		
		end if
	case 'prof_fecha'
		
		ldt_fecha_tran 	 = this.getitemdatetime(this.getrow(),'prof_fecha')		
		ldt_fecha_anterior = this.getitemdatetime(this.getrow(),'prof_fecha', Primary!, True)		
		ii_ann = year(date(this.getitemdatetime(this.getrow(),'prof_fecha')))
		li_ann_anterior = dw_1.getitemnumber(1,'prof_ann')
		
		if not gf_valida_fecha_conta(ldt_fecha_anterior) then			
			dw_1.setitem(1,'prof_fecha', ldt_fecha_anterior)
			dw_1.setcolumn('prof_fecha')
			return 2
		end if

		if not gf_valida_fecha_conta(ldt_fecha_tran) then			
			dw_1.setitem(1,'prof_fecha', ldt_fecha_anterior)
			dw_1.setcolumn('prof_fecha')
			return 2
		end if

		if not gf_valida_fecha_futura(ldt_fecha_tran) then			
			if ldt_fecha_tran = ldt_fecha_anterior then
				dw_1.setitem(1,'prof_fecha', date(gf_fecha_serv()))				
			else
				dw_1.setitem(1,'prof_fecha', ldt_fecha_anterior)
			end if
			dw_1.setcolumn('prof_fecha')
			return 2
		end if
		
		//Si los anios son diferentes asigna el anio
		if ii_ann <> li_ann_anterior then
			dw_1.setitem(1,'prof_ann',ii_ann)
		end if

		
	case 'prof_ruc_cliente'		
		
		  SELECT count(*)  
			 INTO :li_existe  
			 FROM ccmclien  
			WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
					( ccmclien.clie_empresa = :str.empresa ) AND  
					( ccmclien.clie_ref_anterior = :data ) AND
					( ccmclien.clie_cuenta_mala = 0);
			if li_existe = 0 or isnull(li_existe) then
				gf_mensaje('','Cliente no existe. Verifique !!!',1,1,'E')
				dw_1.setitem(1,'prof_ruc_cliente','')
				dw_1.setcolumn('prof_ruc_cliente')
				return 2
			end if		
			
		ll_tercero = idwc_cliente.getitemNumber(idwc_cliente.getrow(), 'terc_tercero')	
		il_tercero = ll_tercero
		ls_nombre = idwc_cliente.getitemstring(idwc_cliente.getrow(), 'terc_descripcion')
//		li_vendedor = idwc_cliente.getitemnumber(idwc_cliente.getrow(), 'clie_vendedor')
		li_termino_pago = idwc_cliente.getitemnumber(idwc_cliente.getrow(), 'clie_limite_morosidad')				
		ls_pasaporte = idwc_cliente.getitemstring(idwc_cliente.getrow(), 'clie_pasaporte')		
		if isnull(li_termino_pago) then li_termino_pago = 0
		ld_limite = idwc_cliente.getitemnumber(idwc_cliente.getrow(), 'clie_limite_credito')						
		if isnull(ld_limite) then ld_limite = 0.00
		this.setitem(1,'prof_a_nombre',ls_nombre)
		this.setitem(1,'prof_a_nombre_direccion', idwc_cliente.getitemstring(idwc_cliente.getrow(), 'regi_descripcion') + ', '+ idwc_cliente.getitemstring(idwc_cliente.getrow(), 'pais_descripcion') )		
		this.setitem(1,'prof_cliente', ll_tercero )				
	//	this.setitem(1,'vendedor',li_vendedor)
		this.setitem(1,'prof_dias_pago',li_termino_pago)		
		this.setitem(1,'prof_pasaporte',ls_pasaporte)		
		this.setcolumn('prof_a_nombre')
		ld_saldo = gf_saldo_anterior_new( ll_tercero, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)		
		if isnull(ld_saldo) then ld_saldo = 0.00
		this.setitem(1,'saldo',ld_saldo)
		this.setitem(1,'limite',ld_limite)		
		
end choose


end event

type st_ayuda from w_fa_padre`st_ayuda within w_captura_proformas_productos_no_creados
integer x = 2793
integer y = 636
end type

type dw_2 from datawindow within w_captura_proformas_productos_no_creados
event ue_enter pbm_dwnprocessenter
event ue_down pbm_dwnkey
event ue_helpcol ( )
integer x = 18
integer y = 596
integer width = 4137
integer height = 2004
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle de la Cotizacion"
string dataobject = "dw_detalle_proformas_bultos2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_enter;this.accepttext()
if str.contabiliza = 1 then
	if this.getcolumnname() = 'dpro_precio_unidad_producto' then	
		if this.getrow() = this.rowcount() then
			parent.triggerevent('ue_aceptar')
			parent.triggerevent('ue_adicionar')
		else
			this.scrolltorow(this.getrow() + 1)
			if pos(str.empr_acceso_especial, 'HPSA') > 0 then
				this.setcolumn('dpro_modelo')
			else			
				this.setcolumn('dpro_codigo_item')
			end if
		end if
	elseif this.getcolumnname() = 'dpro_bultos' then	
		this.setcolumn('dpro_precio_unidad_producto')	
	elseif this.getcolumnname() = 'dpro_modelo' then	
		this.setcolumn('dpro_descripcion_alterna')	
	elseif this.getcolumnname() = 'dpro_descripcion_alterna' then	
		if ii_opcion_captura = 1 then
			this.setcolumn('dpro_cantidad')	
		else
			this.setcolumn('dpro_cantidad')	
		end if
	elseif this.getcolumnname() = 'bultos' then
		if this.getitemnumber(this.getrow(),'bultos') = 0 then
			this.setcolumn('dpro_cantidad')	
		else
			this.setcolumn('dpro_precio_unidad_producto')			
		end if
	elseif this.getcolumnname() = 'dpro_cantidad' or this.getcolumnname() = 'dpro_fraccion' then	
		this.setcolumn('dpro_unidad_venta')
	elseif this.getcolumnname() = 'dpro_unidad_venta' then	
		this.setcolumn('dpro_bultos')	
	end if

else
	if this.getcolumnname() = 'dpro_precio_unidad_producto' then	
		if this.getrow() = this.rowcount() then
			parent.triggerevent('ue_aceptar')
			parent.triggerevent('ue_adicionar')
		else
			this.scrolltorow(this.getrow() + 1)
			if pos(str.empr_acceso_especial, 'HPSA') > 0 then
				this.setcolumn('dpro_modelo')
			else			
				this.setcolumn('dpro_codigo_item')
			end if
		end if
	elseif this.getcolumnname() = 'dpro_codigo_item' then	
		this.setcolumn('dpro_bodega')	
	elseif this.getcolumnname() = 'dpro_modelo' then	
		this.setcolumn('dpro_bodega')	
	elseif this.getcolumnname() = 'dpro_bodega' then	
		if ii_opcion_captura = 1 then
			this.setcolumn('bultos')	
		else
			this.setcolumn('dpro_cantidad')	
		end if
	elseif this.getcolumnname() = 'bultos' then
		if this.getitemnumber(this.getrow(),'bultos') = 0 then
			this.setcolumn('dpro_cantidad')	
		else
			this.setcolumn('dpro_precio_unidad_producto')			
		end if
	elseif this.getcolumnname() = 'dpro_cantidad' or this.getcolumnname() = 'dpro_fraccion' then	
		this.setcolumn('dpro_precio_unidad_producto')			
	end if
end if
return 2
end event

event ue_down;//override
// Toma la Tecla que el usuario presione

CHOOSE CASE key
		
	CASE KeyF1! 
		
		This.Postevent("ue_helpcol")
		
	CASE	  Keyenter! 
		
	  This.Triggerevent("ue_entercol")
	  
END CHOOSE
end event

event ue_helpcol();////Busqueda del producto
////
//String  ls_find,ls_codigo
//integer li_c, li_b
//long    ll_lter
//string  ls_lter,ls_des
//
//Datawindow        dww
//str_dg_dynamic_find	lstr_df
//
//choose case this.getcolumnname()
//	case 'dpro_codigo_item'
//		
//	lstr_df.texto_campo [1,1] = "inmprodu.prod_producto"
//	lstr_df.texto_campo [1,2] = "Referencia"
//	lstr_df.texto_campo [1,3] = "prod_producto"
//	lstr_df.texto_campo [1,4] = 'V'
////	lstr_df.texto_campo [1,5] = '280'	
//	lstr_df.texto_campo [2,1] = "inmprodu.prod_producto_dos"
//	lstr_df.texto_campo [2,2] = "Modelo"
//	lstr_df.texto_campo [2,3] = ""
//	lstr_df.texto_campo [2,4] = 'V'
////	lstr_df.texto_campo [2,5] = '770'
//	lstr_df.texto_campo [3,1] = "inmprodu.prod_descripcion"
//	lstr_df.texto_campo [3,2] = "Descripcion"
//	lstr_df.texto_campo [3,3] = ""
//	lstr_df.texto_campo [3,4] = 'V'
//	lstr_df.texto_campo [3,5] = '1070'
//	
//	lstr_df.texto_campo [4,1] = "convert(numeric(8,2),inmprodu.prod_existencia_total / medi_cantidad) prod_existencia_total"
//	lstr_df.texto_campo [4,2] = "Exist."
//	lstr_df.texto_campo [4,3] = ""
//	lstr_df.texto_campo [4,4] = 'V'
//	lstr_df.texto_campo [4,5] = '270'
//
//	lstr_df.texto_campo [5,1] = "convert(numeric(8,2),inmprodu.prod_reserva_total / medi_cantidad) prod_reserva_total"
//	lstr_df.texto_campo [5,2] = "Reserva"
//	lstr_df.texto_campo [5,3] = ""
//	lstr_df.texto_campo [5,4] = 'V'
//	lstr_df.texto_campo [5,5] = '270'
//
//	lstr_df.texto_campo [6,1] = "convert(numeric(8,2),(inmprodu.prod_existencia_total  - inmprodu.prod_reserva_total) / medi_cantidad) disponible"
//	lstr_df.texto_campo [6,2] = "Dispo."
//	lstr_df.texto_campo [6,3] = ""
//	lstr_df.texto_campo [6,4] = 'V'
//	lstr_df.texto_campo [6,5] = '270'
//
//	lstr_df.texto_campo [7,1] = "convert(numeric(12), inmprodu.prod_empaque) prod_empaque"
//	lstr_df.texto_campo [7,2] = "Empaque"
//	lstr_df.texto_campo [7,3] = ""
//	lstr_df.texto_campo [7,4] = 'V'
//	lstr_df.texto_campo [7,5] = '270'
//	
//	lstr_df.texto_campo [8,1] = "inmprodu.prod_medida"
//	lstr_df.texto_campo [8,2] = "Uni."
//	lstr_df.texto_campo [8,3] = ""
//	lstr_df.texto_campo [8,4] = 'V'
//	lstr_df.texto_campo [8,5] = '120'
//	lstr_df.texto_campo [9,1] = "cradivis.adiv_nombre_div"
//	lstr_df.texto_campo [9,2] = "Division"
//	lstr_df.texto_campo [9,3] = ""
//	lstr_df.texto_campo [9,4] = 'V'
//	lstr_df.texto_campo [9,5] = '870'
//	lstr_df.texto_campo [10,1] = "cragrupo.agru_descripcion_grupo"
//	lstr_df.texto_campo [10,2] = "Grupo"
//	lstr_df.texto_campo [10,3] = ""
//	lstr_df.texto_campo [10,4] = 'V'
//	lstr_df.texto_campo [10,5] = '870'
//
//	lstr_df.tabla = " inmprodu, cradivis, cragrupo, inamedid "
//		
//	lstr_df.tabla_where = &
//		"WHERE ( cragrupo.agru_g_financiero = inmprodu.prod_g_financiero ) and  " +&
//         "( cragrupo.agru_empresa = inmprodu.prod_empresa ) and  " +&
//         "( cragrupo.agru_codigo_div = inmprodu.prod_division ) and " +&  
//         "( cragrupo.agru_codigo_grupo = inmprodu.prod_grupo ) and " +&  			
//         "( inmprodu.prod_g_financiero = cradivis.adiv_g_financiero ) and " +& 
//         "( inmprodu.prod_empresa = cradivis.adiv_empresa ) and  " +&
//         "( inmprodu.prod_division = cradivis.adiv_codigo_div ) and " +&  
//         "( inmprodu.prod_medida = inamedid.medi_medida ) and " +&  			
//		"( inmprodu.prod_status = 1 ) and " + &	
//		"(inmprodu.prod_g_financiero = " + string(str.g_financiero) + ") and " +&
//		"(inmprodu.prod_empresa = " + string(str.empresa) + ") "	
//						 
//	OpenWithParm(w_buscar_producto, lstr_df)
//	ls_find = Message.StringParm
//
//	
//	
//	If len (ls_find) = 0 Then Return
//		
//	ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
//	gf_replace_cadena(ls_codigo,"'"," ")
//	ls_codigo = Trim(ls_codigo)
//	this.setitem(this.getrow(),'dpro_codigo_item',ls_codigo)
//
//case 'dpro_modelo'
//	
//	lstr_df.texto_campo [2,1] = "inmprodu.prod_producto"
//	lstr_df.texto_campo [2,2] = "Referencia"
//	lstr_df.texto_campo [2,3] = "prod_producto"
//	lstr_df.texto_campo [2,4] = 'V'
////	lstr_df.texto_campo [2,5] = '280'	
//	lstr_df.texto_campo [1,1] = "inmprodu.prod_producto_dos"
//	lstr_df.texto_campo [1,2] = "Modelo"
//	lstr_df.texto_campo [1,3] = ""
//	lstr_df.texto_campo [1,4] = 'V'
////	lstr_df.texto_campo [1,5] = '770'
//	lstr_df.texto_campo [3,1] = "inmprodu.prod_descripcion"
//	lstr_df.texto_campo [3,2] = "Descripcion"
//	lstr_df.texto_campo [3,3] = ""
//	lstr_df.texto_campo [3,4] = 'V'
//	lstr_df.texto_campo [3,5] = '1070'
//	
//	lstr_df.texto_campo [4,1] = "convert(numeric(8,2),inmprodu.prod_existencia_total / medi_cantidad) prod_existencia_total"
//	lstr_df.texto_campo [4,2] = "Exist."
//	lstr_df.texto_campo [4,3] = ""
//	lstr_df.texto_campo [4,4] = 'V'
//	lstr_df.texto_campo [4,5] = '270'
//
//	lstr_df.texto_campo [5,1] = "convert(numeric(8,2),inmprodu.prod_reserva_total / medi_cantidad) prod_reserva_total"
//	lstr_df.texto_campo [5,2] = "Reserva"
//	lstr_df.texto_campo [5,3] = ""
//	lstr_df.texto_campo [5,4] = 'V'
//	lstr_df.texto_campo [5,5] = '270'
//
//	lstr_df.texto_campo [6,1] = "convert(numeric(8,2),(inmprodu.prod_existencia_total  - inmprodu.prod_reserva_total) / medi_cantidad) disponible"
//	lstr_df.texto_campo [6,2] = "Dispo."
//	lstr_df.texto_campo [6,3] = ""
//	lstr_df.texto_campo [6,4] = 'V'
//	lstr_df.texto_campo [6,5] = '270'
//
//	lstr_df.texto_campo [7,1] = "convert(numeric(12), inmprodu.prod_empaque) prod_empaque"
//	lstr_df.texto_campo [7,2] = "Empaque"
//	lstr_df.texto_campo [7,3] = ""
//	lstr_df.texto_campo [7,4] = 'V'
//	lstr_df.texto_campo [7,5] = '270'
//	
//	lstr_df.texto_campo [8,1] = "inmprodu.prod_medida"
//	lstr_df.texto_campo [8,2] = "Uni."
//	lstr_df.texto_campo [8,3] = ""
//	lstr_df.texto_campo [8,4] = 'V'
//	lstr_df.texto_campo [8,5] = '120'
//	lstr_df.texto_campo [9,1] = "cradivis.adiv_nombre_div"
//	lstr_df.texto_campo [9,2] = "Division"
//	lstr_df.texto_campo [9,3] = ""
//	lstr_df.texto_campo [9,4] = 'V'
//	lstr_df.texto_campo [9,5] = '870'
//	lstr_df.texto_campo [10,1] = "cragrupo.agru_descripcion_grupo"
//	lstr_df.texto_campo [10,2] = "Grupo"
//	lstr_df.texto_campo [10,3] = ""
//	lstr_df.texto_campo [10,4] = 'V'
//	lstr_df.texto_campo [10,5] = '870'
//
//	lstr_df.tabla = " inmprodu, cradivis, cragrupo, inamedid "
//		
//	lstr_df.tabla_where = &
//		"WHERE ( cragrupo.agru_g_financiero = inmprodu.prod_g_financiero ) and  " +&
//         "( cragrupo.agru_empresa = inmprodu.prod_empresa ) and  " +&
//         "( cragrupo.agru_codigo_div = inmprodu.prod_division ) and " +&  
//         "( cragrupo.agru_codigo_grupo = inmprodu.prod_grupo ) and " +&  			
//         "( inmprodu.prod_g_financiero = cradivis.adiv_g_financiero ) and " +& 
//         "( inmprodu.prod_empresa = cradivis.adiv_empresa ) and  " +&
//         "( inmprodu.prod_division = cradivis.adiv_codigo_div ) and " +&  
//         "( inmprodu.prod_medida = inamedid.medi_medida ) and " +&  			
//		"( inmprodu.prod_status = 1 ) and " + &	
//		"(inmprodu.prod_g_financiero = " + string(str.g_financiero) + ") and " +&
//		"(inmprodu.prod_empresa = " + string(str.empresa) + ") "	
//						 
//	OpenWithParm(w_buscar_producto, lstr_df)
//	ls_find = Message.StringParm
//	
//	If len (ls_find) = 0 Then Return
//		
//	ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
//	gf_replace_cadena(ls_codigo,"'"," ")
//	ls_codigo = Trim(ls_codigo)
//	this.setitem(this.getrow(),'dpro_codigo_item',ls_codigo)
//	
//	  SELECT max(inmprodu.prod_producto_dos)
//		 INTO :ls_codigo  
//		 FROM inmprodu  
//		WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
//				( inmprodu.prod_empresa = :str.empresa ) AND  
//				( inmprodu.prod_producto = :ls_codigo )   ;
//		if sqlca.sqlcode = -1 then
//			gf_mensaje('','Error al buscar modelo '+sqlca.sqlerrtext,1,1,'E')
//			return
//		end if
//		
//		this.setitem(this.getrow(),'dpro_modelo',ls_codigo)
//		
//end choose
//
//this.accepttext()
//this.trigger event itemchanged(this.getrow(), object, ls_codigo)
end event

event itemfocuschanged;datawindow = 2
integer li_retorno
li_retorno = this.SelectText( 1, 99) 
end event

event clicked;if this.rowcount() = 0 then
	datawindow = 1
	parent.triggerevent('ue_aceptar')
else
	datawindow = 2
	if dw_1.getitemstring(1,'prof_estado') = 'A' then
		parent.triggerevent('ue_adicionar')
	end if
end if

datawindow = 2
end event

event buttonclicked;string ls_codigo
integer li_encontro
if dwo.name = 'b_productos' then

	string ls_producto
	str_kardex  str_opcion
			
	if dw_2.rowcount() > 0 then
		ls_producto = dw_2.getitemstring(dw_2.getrow(),'dpro_codigo_item')				
	end if			
	str_opcion.kproducto=ls_producto

//	OpenSheetWithParm(w_productos,str_opcion,str.frame,2,Original!)		

end if
end event

event itemchanged;string ls_codigo, ls_modelo, ls_descripcion, ls_uni_empaque, ls_condicion, ls_bodega
long   ll_bultos
decimal {3} ld_cantidad, ld_disponible
integer ll_fraccion
decimal {2} ld_precio_recargo, ld_monto_final, ld_total, ld_saldo_disponible, ld_bultos
decimal {8} ld_precio, ld_precio_original, ld_costo_cif
this.accepttext()
if this.getcolumnname() = 'bultos2' then
	this.setitem(row,'dpro_cantidad',integer(data) * il_empaque)	
	//this.accepttext()
	this.setcolumn('dpro_cantidad')
		ld_cantidad = this.getitemnumber(row,'dpro_cantidad')	
		ll_fraccion = this.getitemnumber(row,'dpro_fraccion')	
		
		//Valida que no supere la cantidad existente al facturar
		ls_bodega = this.getitemstring(row,'dpro_bodega')
		ld_disponible = dw_7.getitemnumber(1,'disponible'+ls_bodega)
		
		if isnull(ll_fraccion) then ll_fraccion = 0
		ld_precio   = this.getitemnumber(row, 'dpro_precio_unidad_producto')
		if ll_bultos = 0 then ll_bultos = 1
		if ld_bultos = 0 then ld_bultos = 1
		
		ld_monto_final = round( (ld_cantidad * ld_precio),2) //+ ((ld_precio / ii_cantidad_unidad) * ll_fraccion ) ,2)
		this.setitem(row,'dpro_monto_final', ld_monto_final)
		this.setitem(row,'dpro_monto_total', ld_monto_final)

		this.setitem(row,'dpro_bultos',ll_bultos)
		this.setitem(row,'dpro_bultos_original',ld_bultos)					
		this.setitem(row,'dpro_peso',ll_bultos * id_peso)
		this.setitem(row,'dpro_cubucaje',round(ll_bultos * id_cubicaje,4))
		this.setitem(row,'dpro_costo_cif', id_costo_cif)
		this.setitem(row,'dpro_costo_fob', id_costo_fob)		
		ld_total = dw_2.getitemnumber(1,'monto_final')
		ld_saldo_disponible = dw_1.getitemnumber(1,'disponible')
		ls_condicion		  = dw_1.getitemString(1,'prof_condicion_pago')		
elseif this.getcolumnname() = 'dpro_cantidad' or this.getcolumnname() = 'dpro_fraccion' then
//		if ii_cantidad_unidad = 0 or isnull(ii_cantidad_unidad) then
//			ls_codigo = this.getitemstring(row,'dpro_codigo_item')
//			if not wf_carga_producto(ls_codigo, ls_descripcion, ls_modelo) then
//				return 2
//			end if
//		end if
		ld_cantidad = this.getitemnumber(row,'dpro_cantidad')	
		ll_fraccion = this.getitemnumber(row,'dpro_fraccion')	
		
		//Valida que no supere la cantidad existente al facturar
		ls_bodega = this.getitemstring(row,'dpro_bodega')
		ld_disponible = dw_7.getitemnumber(1,'disponible'+ls_bodega)
		
		if isnull(ll_fraccion) then ll_fraccion = 0
		ld_precio   = this.getitemnumber(row, 'dpro_precio_unidad_producto')
		if ll_bultos = 0 then ll_bultos = 1
		if ld_bultos = 0 then ld_bultos = 1
		
			ld_monto_final = round( (ld_cantidad * ld_precio),2 ) //+ ((ld_precio / ii_cantidad_unidad) * ll_fraccion ) ,2)
			this.setitem(row,'dpro_monto_final', ld_monto_final)
			this.setitem(row,'dpro_monto_total', ld_monto_final)

		this.setitem(row,'dpro_bultos',ll_bultos)
		this.setitem(row,'dpro_bultos_original',ld_bultos)					
		this.setitem(row,'dpro_peso',ll_bultos * id_peso)
		this.setitem(row,'dpro_cubucaje',round(ll_bultos * id_cubicaje,4))
		this.setitem(row,'dpro_costo_cif', id_costo_cif)
		ld_total = dw_2.getitemnumber(1,'monto_final')
		ld_saldo_disponible = dw_1.getitemnumber(1,'disponible')
		ls_condicion		  = dw_1.getitemString(1,'prof_condicion_pago')		
		if ld_total > ld_saldo_disponible and ls_condicion <> 'CO' then
			if not wf_valida_limite_credito() then
				this.setitem(row,'dpro_cantidad',0)
				return 2
			end if
		end if
elseif this.getcolumnname() = 'dpro_precio_unidad_producto' then	
	ld_precio = double(data)	
//	if ii_acepta_descuento = 1 then
//		ld_precio = round( ld_precio - round((id_porc_descuento / 100) * ld_precio, 2 ),2)
//		this.setitem(row,'dpro_precio_original',ld_precio)
//		this.accepttext()
//		ld_precio = ld_precio
//	end if
	id_precio = ld_precio
//	ld_precio_recargo = this.getitemnumber(row, 'dpro_precio_recargo')	
//	ld_precio = ld_precio + ld_precio_recargo
//	this.setitem(row, 'dpro_precio_unidad_producto', ld_precio)	
	ld_cantidad   = this.getitemnumber(row, 'dpro_cantidad')	
	ll_fraccion   = this.getitemnumber(row,'dpro_fraccion')
	if isnull(ll_fraccion) then ll_fraccion = 0
	ld_costo_cif  = this.getitemnumber(row, 'dpro_costo_cif')
	if isnull(ld_costo_cif) then ld_costo_cif = 0
	ld_monto_final = round( (ld_cantidad * ld_precio),2) // + ((ld_precio / ii_cantidad_unidad) * ll_fraccion ) ,2)	
	this.setitem(row,'dpro_monto_final', ld_monto_final)
	this.setitem(row,'dpro_monto_total', ld_monto_final)
	ld_total = dw_2.getitemnumber(1,'monto_final')
	ld_saldo_disponible = dw_1.getitemnumber(1,'disponible')
	ls_condicion		  = dw_1.getitemString(1,'prof_condicion_pago')	

elseif this.getcolumnname() = 'dpro_cubicaje' then	
	if this.getrow() = this.rowcount() then
		parent.triggerevent('ue_adicionar')
	else
		this.scrolltorow(this.getrow() + 1)
		this.setcolumn('dpro_codigo_item')
	end if
elseif this.getcolumnname() = 'dpro_bodega' then
	//Validar la disponibilidad
	if ii_opcion_captura = 1 then
		this.setcolumn('bultos')
	else
		this.setcolumn('dpro_cantidad')
	end if
elseif this.getcolumnname() = 'dpro_rebajar' then
	if dw_1.getitemstring(1,'prof_estado') = 'I' then
		sqlca.autocommit = false
		this.accepttext()
		if this.update() = -1 then
			gf_mensaje('','Error al asignar rebaja '+sqlca.sqlerrtext,1,1,'E')
			sqlca.autocommit = true
			rollback;
		end if
		commit ;
		sqlca.autocommit = true
	end if
elseif this.getcolumnname() = 'dpro_monto_final' then	//Solo entra para la empresa 2
	ld_cantidad    = this.getitemnumber(row,'dpro_cantidad')
	ll_fraccion		= 0
	ld_monto_final = this.getitemnumber(row,'dpro_monto_final')
	this.setitem(row, 'dpro_monto_total', ld_monto_final)				
	if ld_cantidad <> 0 then
		ld_precio = ABS(ld_monto_final / ld_cantidad)
		this.setitem(row,'dpro_precio_original',ld_precio)		
		ld_precio_recargo = 0 //this.getitemnumber(row, 'dpro_precio_recargo')	
		ld_precio = ld_precio + ld_precio_recargo
		this.setitem(row, 'dpro_precio_unidad_producto', ld_precio)			
	end if

	ld_total = dw_2.getitemnumber(1,'monto_final')
	ld_saldo_disponible = dw_1.getitemnumber(1,'disponible')
	ls_condicion		  = dw_1.getitemString(1,'prof_condicion_pago')		

	
end if
end event

event rowfocuschanged;//string  ls_codigo, ls_descripcion, ls_modelo
//boolean lb_asignar
//il_row = currentrow
//if currentrow > 0 then
//	if isnull(is_item) or is_item = '' then 
//		is_item = this.getitemstring(currentrow, 'dpro_codigo_item')
//		lb_asignar = true
//	end if
//	
//	ls_codigo = this.getitemstring(currentrow, 'dpro_codigo_item')
//	if isnull(ls_codigo) then 
//		is_foto = ''
//		id_ultima_cantidad = 0
//		id_ultimo_precio = 0
//		if isvalid(w_foto_producto) then
//			w_foto_producto.wf_asignar(is_foto, id_ultima_cantidad, id_ultimo_precio)
//		else
//			istr_foto_cantidad_precio.foto = is_foto
//			istr_foto_cantidad_precio.ultima_cantidad = id_ultima_cantidad
//			istr_foto_cantidad_precio.ultimo_precio = id_ultimo_precio
//			opensheetwithparm(w_foto_producto, istr_foto_cantidad_precio ,str.frame, 2, Original!)
//			parent.dw_2.setfocus()
//		end if
//		if isvalid(w_ventas_producto) then
//			w_ventas_producto.dw_1.modify("t_precio_promedio.text = ''")	
//			w_ventas_producto.dw_1.reset()
//			w_ventas_producto.dw_1.insertrow(1)
//		end if
//		return 2
//	end if
//	if dw_7.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
//		dw_7.insertrow(1)
//		dw_7.setitem(1,'dgmempre_empr_bodegas_definidas',ii_bodegas_definidas)
//		dw_7.setitem(1,'bodega1',is_b1); dw_7.setitem(1,'bodega2',is_b2); dw_7.setitem(1,'bodega3',is_b3); dw_7.setitem(1,'bodega4',is_b4); dw_7.setitem(1,'bodega5',is_b5); dw_7.setitem(1,'bodega6',is_b6); dw_7.setitem(1,'bodega7',is_b7)
//	end if	
//	ls_modelo = ''
//	if not wf_carga_producto(ls_codigo, ls_descripcion, ls_modelo) then
//		return 2
//	end if
//	if lb_asignar then
//		is_descrip = ls_descripcion		
//	end if
//	dw_7.bringtotop = true
//	//Ventana de Ventas
//	if isvalid(w_ventas_producto) then
//		w_ventas_producto.wf_asignar(ls_codigo)
//	else
//		opensheetwithparm(w_ventas_producto, ls_codigo ,str.frame, 2, Original!)
//		w_ventas_producto.BringToTop = TRUE
//		parent.dw_2.setfocus()
//	end if
//	//Ventana de la Foto
//	if isvalid(w_foto_producto) then
//		w_foto_producto.wf_asignar(is_foto, id_ultima_cantidad, id_ultimo_precio)
//	else
//		istr_foto_cantidad_precio.foto = is_foto
//		istr_foto_cantidad_precio.ultima_cantidad = id_ultima_cantidad
//		istr_foto_cantidad_precio.ultimo_precio = id_ultimo_precio
//		opensheetwithparm(w_foto_producto, istr_foto_cantidad_precio ,str.frame, 2, Original!)
//		w_foto_producto.BringToTop = TRUE
//		parent.dw_2.setfocus()
//	end if
////	dw_8.bringtotop = true	
//end if
//
//
end event

type dw_3 from datawindow within w_captura_proformas_productos_no_creados
boolean visible = false
integer x = 1193
integer y = 260
integer width = 2501
integer height = 1376
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Proveedores"
string dataobject = "dw_clientes"
boolean controlmenu = true
boolean vscrollbar = true
string icon = "AppIcon!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;integer i
datawindowchild ldwc_proveedor

if dwo.name = 'b_cerrar' then
	this.update()
	this.visible = false
	if this.dataobject = 'dw_proveedores' then
		dw_1.getchild('enca_proveedor', ldwc_proveedor)
		ldwc_proveedor.settransobject(sqlca)
		ldwc_proveedor.retrieve()
		dw_1.setfocus()
		dw_1.setcolumn('enca_proveedor')
	end if
elseif dwo.name = 'b_grabar' then
	for i = 1 to this.rowcount()
		this.setitem(i,'prod_g_financiero', str.g_financiero)
		this.setitem(i,'prod_empresa', str.empresa)
	next
	if this.update() = -1 then
		gf_mensaje('','Error al actualizar '+sqlca.sqlerrtext,1,1,'E')
	end if
end if
end event

type cb_1 from commandbutton within w_captura_proformas_productos_no_creados
integer x = 2843
integer y = 44
integer width = 379
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargos"
end type

event clicked;//Ventana que llama a la ventana de cargos
Double  ld_cargos , tem, ld_est_valor_desc, ld_monto
string  ls_tipo
integer li_existe
datawindow ldw_1

ldw_1 = dw_1

str_fa_cargo_fac l_str		//Defino una variable tipo estructura

l_str.pedido = is_secuencia

ld_monto = ldw_1.getitemnumber(ldw_1.getrow(),"prof_monto_total")

//si aplica descuento al subtotal, se debe descontar el descuento, antes de calcular los cargos
ls_tipo = 'N' //ldw_1.GetItemString(ldw_1.getrow(),"prof_descuento_subt_deta")				 
ld_est_valor_desc = 0 //ldw_1.getitemnumber(ldw_1.getrow(),"prof_por_descuento")
if ls_tipo = 'S'	then //si aplica descuento al subtotal
	ld_monto = ld_monto - (ld_monto * (ld_est_valor_desc / 100))
end if

l_str.monto = ld_monto	//ASIGNA EL MONTO BASE PARA CALCULAR LOS CARGOS			 
				 
l_str.bultos = 0 //ldw_1.getitemnumber(ldw_1.getrow(),"prof_bultos_total")				 

l_str.tipo = is_tipo

l_str.estado = ldw_1.getitemstring(ldw_1.getrow(),"prof_estado")

l_str.an		 = ii_ann

l_str.window = parent

//Abre la ventana de cargos, que a su vez llama una funcion que recalcula el monto final
//siempre y cuando la factura esté guardada
  SELECT count(*)  
    INTO :li_existe  
    FROM fatprofo2  
   WHERE ( fatprofo2.prof_g_financiero = :str.g_financiero ) AND  
         ( fatprofo2.prof_empresa = :str.empresa ) AND  
         ( fatprofo2.prof_no_proforma = :is_secuencia ) AND  
         ( fatprofo2.prof_ann = :ii_ann )   ;
	if sqlca.sqlcode = -1 then
		mensaje("Aviso","Error al Validar Existencia de la Factura",sqlca.sqlerrtext)
	end if

if li_existe > 0 then
	OpensheetWithParm(w_cargos_pro, l_str,parent,2)
// 	m_fa_principal.m_archivo.m_guardar.enabled = true
end if
end event

type cb_2 from commandbutton within w_captura_proformas_productos_no_creados
boolean visible = false
integer x = 2834
integer y = 160
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
string text = "Actualizar"
end type

event clicked;string ls_factura
long   ll_factura
dw_5.reset()
dw_5.insertrow(1)
dw_5.setfocus()

if dw_2.rowcount() = 0 and dw_1.getitemstring(1,'prof_ruc_cliente') <> '0736' then return
if dw_1.getitemstring(1,'prof_estado') <> 'A' then return
	
parent.triggerevent('ue_aceptar')

if dw_1.getitemnumber(1,'prof_gastos_total') = 0 then cb_1.triggerevent('clicked')

  SELECT isnull(faaparam.fara_ult_ultima_factura  ,'0')
    INTO :ls_factura  
    FROM faaparam  
   WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
         ( faaparam.fara_empresa = :str.empresa )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al buscar secuencia '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
	ll_factura = long(ls_factura)
	
	ll_factura ++
	
	dw_5.setitem(1,'factura', string(ll_factura))

dw_5.visible = true

end event

type dw_6 from datawindow within w_captura_proformas_productos_no_creados
boolean visible = false
integer x = 3273
integer y = 68
integer width = 718
integer height = 96
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_formatos"
end type

event itemchanged;string ls_dw
ls_dw = idwc_formatos.getitemstring(idwc_formatos.getrow(),'datawindows')
dw_4.dataobject = ls_dw
dw_4.settransobject(sqlca)
dw_4.retrieve(str.g_financiero, str.empresa, is_secuencia , ii_ann)
dw_4.object.datawindow.print.preview = 'yes'
dw_4.object.datawindow.print.preview.zoom = 100
dw_4.object.nom_empresa.expression = "'"+str.nombre_empresa+"'"
dw_4.visible = true
end event

type st_1 from statictext within w_captura_proformas_productos_no_creados
boolean visible = false
integer x = 3328
integer y = 12
integer width = 603
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Seleccione el Formato "
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_7 from datawindow within w_captura_proformas_productos_no_creados
boolean visible = false
integer x = 41
integer y = 2088
integer width = 2222
integer height = 476
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_existencia_bodegas"
boolean border = false
boolean livescroll = true
end type

event retrieveend;if rowcount = 0 then return
string ls_error
decimal ld_reserva_total, ld_cantidad_total, ld_disponible
//Busca la reserva
		 DECLARE sp_reserva PROCEDURE FOR fa_reservados_totaldos  
				@g_financiero = :str.g_financiero,   
				@empresa = :str.empresa,   
				@codigo_producto = :is_item  ;
				
			if sqlca.sqlcode = -1 then
				mensaje("Aviso","Error al declarar el cursor",sqlca.sqlerrtext)
				return
			end if
			
			execute sp_reserva;												
			// set.
			DO WHILE SQLCA.sqlcode = 0							
			// Fetch the next row from the first result set.						
				FETCH sp_reserva INTO :ld_reserva_total;
			LOOP
			
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				gf_mensaje("Aviso","Error al buscar la reserva",1,1,'E')
				return
			end if
			
			close sp_reserva;
			
			if isnull(ld_reserva_total) then ld_reserva_total = 0
			
			
end event

event clicked;string ls_producto

choose case dwo.name
	case 'reserva1', 'reserva2','reserva3','reserva4','reserva5','reserva6','reserva7'
			str_fa_formato lstr_datawindow
			lstr_datawindow.datawindow = "dw_fa_rep_reserva_existencia_new"
			ls_producto = this.getitemstring(1,"prod_producto")
			lstr_datawindow.producto = ls_producto
			
			OpenSheetWithParm(w_disponibles,lstr_datawindow, str.frame,2, Original!)
end choose
end event

type dw_4 from datawindow within w_captura_proformas_productos_no_creados
boolean visible = false
integer x = 32
integer y = 20
integer width = 3717
integer height = 2228
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Impresión de la Proforma"
string dataobject = "dw_imprimir_proforma_hpsa_2"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
string icon = "AppIcon!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;if rowcount > 0 then
	wf_imprime_vendedor()
end if
end event

type dw_5 from datawindow within w_captura_proformas_productos_no_creados
boolean visible = false
integer x = 1211
integer y = 384
integer width = 1056
integer height = 492
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Actualizar Factura"
string dataobject = "dw_imprime_factura"
boolean controlmenu = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//string ls_factura, ls_cuenta, ls_pedido, ls_dw
//integer li_existe
//this.accepttext()
//choose case dwo.name
//	case 'b_actualiza'
//		ls_factura = this.getitemstring(1,'factura')
//		ls_pedido = dw_1.getitemstring(1,'prof_no_proforma')
//		ls_cuenta  = dw_1.getitemstring(1,'prof_ruc_cliente')
//		
//		if ls_factura = '' or isnull(ls_factura) then
//			gf_mensaje('','Numero de Factura Invalido, Verifique !!!',1,1,'E')
//			return
//		end if
//		
//		if gf_mensaje('','Esta Seguro de Actualizar la Factura ?',2,1,'E') = 2 then return
//		
//		
//		  SELECT count(*)  
//			 INTO :li_existe  
//			 FROM fatprofo2  
//			WHERE ( fatprofo2.prof_g_financiero = :str.g_financiero ) AND  
//					( fatprofo2.prof_empresa = :str.empresa ) AND  
//					( fatprofo2.prof_ann = :ii_ann ) AND  
//					( fatprofo2.prof_no_factura = :ls_factura ) and 
//					(fatprofo2.prof_no_proforma <> :ls_pedido );
//					if sqlca.sqlcode = -1 then
//						gf_mensaje('','Error al Validar Factura '+sqlca.sqlerrtext,1,1,'E')
//						return
//					end if
//
//		if li_existe > 0 then
//			gf_mensaje('','Factura ya Existe, Verifique !!!',1,1,'E')
//			return
//		end if
//		datawindow = 1
//		
//		if dw_1.getitemstring(1,'prof_estado') = 'A' then
//			parent.triggerevent('ue_aceptar')
//		end if
//		
//		//Si es la cuenta de anulado
//		if ls_cuenta = '0736' then			
//			
//			dw_1.setitem(1,'prof_estado', 'E')	
//			dw_1.setitem(1,'prof_no_factura', ls_factura)							
//			
//					if dw_1.update() = -1 then			
//						gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext ,1,1,'E')
//						rollback ;
//						sqlca.autocommit = true			
//						return
//					else //Si todo ok
//						UPDATE faaparam  
//						  SET fara_ult_ultima_factura = :ls_factura  
//						WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
//								( faaparam.fara_empresa = :str.empresa ) ;
//								if sqlca.sqlcode = -1 then
//									gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext ,1,1,'E')
//									rollback ;
//									sqlca.autocommit = true			
//									return
//								end if			
//					end if		
//					
//					dw_5.visible = false
//					
//		else//Si no es una cuenta de anulacion				
//						
//			if wf_actualiza_factura(ls_factura) then
//				dw_5.visible = false
//			else
//				return
//			end if
//			
//			  SELECT isnull(max(forma_datawindow),'')  
//				 INTO :ls_dw  
//				 FROM faaforma  
//				WHERE ( faaforma.forma_g_financiero = :str.g_financiero ) AND  
//						( faaforma.forma_empresa = :str.empresa ) AND  
//						( faaforma.forma_tipo_formato = 'FAC' )   ;
//				if sqlca.sqlcode = -1 then
//					gf_mensaje('','Error al Seleccionar formato '+sqlca.sqlerrtext,1,1,'E')
//				end if
//			
//			if ls_dw = '' then ls_dw = 'dw_imprimir_factura'
//			
//			dw_4.dataobject = ls_dw
//			dw_4.settransobject(sqlca)
//			
//			
//			parent.triggerevent('ue_print')								
//
//		end if
//	case 'b_cancelar'
//		dw_5.visible = false		
//end choose
end event

type pb_2 from picturebutton within w_captura_proformas_productos_no_creados
integer x = 3717
integer y = 220
integer width = 178
integer height = 152
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "C:\Sistemas\HYMSOFT\Art\NOTE04.BMP"
alignment htextalign = left!
end type

event clicked;long ll_tercero
ll_tercero = dw_1.getitemnumber(1,'prof_cliente')
str_cc_formatos str_formato2		
str_formato2.tercero = ll_tercero
if ll_tercero > 0 then
	Opensheetwithparm(w_notas,str_formato2,str.frame,2,original!)
end if

end event

type st_2 from statictext within w_captura_proformas_productos_no_creados
integer x = 3694
integer y = 368
integer width = 215
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Notas"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_3 from picturebutton within w_captura_proformas_productos_no_creados
boolean visible = false
integer x = 3881
integer y = 476
integer width = 133
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "C:\sistemas\hymsoft\Art\dba_cancel.bmp"
alignment htextalign = left!
end type

event clicked;datetime ldt_fecha
long ll_tercero
decimal ld_monto
string ls_detalle, ls_factura

	if dw_1.getitemstring(1,'prof_estado') = 'E' then
		gf_mensaje('','La Factura ya fue Anulada, Verifique !!!',1,1,'E')
		return		
	elseif dw_1.getitemstring(1,'prof_estado') = 'A' then
		gf_mensaje('','Solo se pueden Anular facturas Actualizadas Verifique !!!',1,1,'E')
		return				
	elseif dw_1.getitemstring(1,'prof_estado') = 'I' then
		if gf_mensaje('','Esta Seguro de Anular la Factura ?',2,2,'E') = 1 then
			
			OpenWithParm(w_clave_autorizada, parent)

			If is_user = "*" then
				return
			end if			
			
			sqlca.autocommit = false
			
			  UPDATE fadprofo2  
			  SET	dpro_lote = convert(varchar(20), fadprofo2.dpro_cantidad),
			  		dpro_cantidad = 0,   
					dpro_cantidad_fraccion = 0  
			WHERE ( fadprofo2.dpro_g_financiero = :str.g_financiero ) AND  
					( fadprofo2.dpro_empresa = :str.empresa ) AND  
					( fadprofo2.dpro_no_proforma = :is_secuencia ) AND  
					( fadprofo2.dpro_ann = :ii_ann )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Actualizar Detalle ' + sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if
			
		   update fatprofo2
			 set prof_estado = 'E',
			 	  prof_monto_prof_total = 0,
				  prof_monto_final = 0,
				  prof_costos_total = 0,
				  prof_a_nombre = 'ANULADA - '+ prof_a_nombre
		 	FROM fatprofo2  
			WHERE ( fatprofo2.prof_g_financiero = :str.g_financiero ) AND  
					( fatprofo2.prof_empresa = :str.empresa ) AND  
					( fatprofo2.prof_no_proforma = :is_secuencia ) AND  
					( fatprofo2.prof_ann = :ii_ann ) ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Actualizar Encabezado ' + sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if

		//libera las ordenes asociadas a la factura
		ls_factura = dw_1.getitemstring(1,'prof_no_factura')
		
			  UPDATE fatprofo2  
				  SET prof_factura_trafico = '',   
						prof_factura_impresa = 0,
						prof_fecha_impresion = null
				WHERE ( fatprofo2.prof_g_financiero = :str.g_financiero ) AND  
						( fatprofo2.prof_empresa = 1 ) AND  
						( fatprofo2.prof_factura_trafico = :ls_factura )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Liberar Ordenes ' + sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if

		
			if not wf_anula_movimiento() then
				sqlca.autocommit = true
				rollback;
				return
			end if
			
			 ldt_fecha  = gf_fecha_serv()
			 ll_tercero = dw_1.getitemnumber(1,'prof_cliente')
			 ld_monto	= dw_1.getitemnumber(1,'prof_monto_final')
			 ls_detalle = 'Se anulo la factura # '+dw_1.getitemstring(1,'prof_no_factura')+' Por: $'+string(ld_monto,'##,###,##0.00')
	
			  INSERT INTO notas_clientes  
				( nota_g_financiero,   
				  nota_empresa,   
				  nota_tercero,   
				  nota_detalle,   
				  nota_fecha,   
				  nota_usuario )  
			  VALUES ( :str.g_financiero,   
						  :str.empresa,   
						  :ll_tercero,   
						  :ls_detalle,     
						  :ldt_fecha,   
						  :str.usuario )  ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al registrar las notas '+sqlca.sqlerrtext,1,1,'E')
				end if
		
			
			dw_1.setitem(1,'prof_estado',"E")									
			commit;
			sqlca.autocommit = true
			gf_mensaje('','Anulación Exitosa',1,1,'E')
		end if
		
	end if
end event

type st_3 from statictext within w_captura_proformas_productos_no_creados
boolean visible = false
integer x = 3813
integer y = 592
integer width = 265
integer height = 128
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Anular Factura"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_captura_proformas_productos_no_creados
boolean visible = false
integer x = 3301
integer y = 288
integer width = 375
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Orden Fact."
end type

event clicked;//////override

dw_1.accepttext()
string ls_factura, ls_condicion_pago, ls_nombre, ls_direccion, ls_consignado, ls_marca, ls_tipo_movimiento, ls_factura_trafico, ls_descrip_grupo, &
		 ls_cuenta, ls_pedido, ls_pasaporte, ls_linea_aerea, ls_producto, ls_descrip, ls_buscar, ls_nombre_temp, ls_division, ls_grupo, ls_prod_original, &
		 ls_direccion_temp, ls_pasaporte_temp, ls_linea_aerea_temp, ls_marca_temp, ls_consignado_temp, ls_tipo_temp, ls_cuenta_temp, ls_producto_temp
integer li_ann, li_metal_pendiente, i, li_tipo_medida, li_encontro, li_factura_impresa, li_empresa = 2, j
decimal{2} ld_monto_final, ld_monto_detalle, ld_fraccion, ld_cantidad, ld_cantidad_pieza, ld_valor_pendiente, ld_gastos, ld_gastos_temp, ld_monto_a_facturar
datetime ldt_fecha, ldt_fecha_despacho, ldt_anterior, ldt_fecha_actual, ldt_fecha_impresion
time lt_time
lt_time = time('00:00:00.000000')

if is_secuencia = '' then return

if dw_1.getitemstring(1,'prof_estado') = 'A' then
	return
end if
	
	dw_9.reset()

	ls_factura = dw_1.getitemstring(1,'prof_no_factura')
	li_ann	  = dw_1.getitemnumber(1,'prof_ann')
	ldt_fecha_actual = datetime(date(gf_fecha_serv()),lt_time)
	
	 DECLARE fac_encab CURSOR FOR  
  SELECT isnull(fatprofo2.prof_condicion_pago,''),   
         fatprofo2.prof_fecha,   
         isnull(fatprofo2.prof_a_nombre,''),   
         isnull(fatprofo2.prof_a_nombre_direccion,''),   
         isnull(fatprofo2.prof_consignado,''),   
         isnull(fatprofo2.prof_monto_final,0),   
         isnull(fatprofo2.prof_marca,''),   
         isnull(fatprofo2.prof_tipo_movimiento,''),   
         isnull(fatprofo2.prof_ruc_cliente,''),   
         fatprofo2.prof_no_proforma,   
         fatprofo2.prof_fecha_despacho,   
         isnull(fatprofo2.prof_pasaporte,''),   
         isnull(fatprofo2.prof_linea_aerea,''),
			fatprofo2.prof_metal_pendiente,
			isnull(fatprofo2.prof_gastos_total,0),
			isnull(fatprofo2.prof_factura_trafico,''),
			isnull(fatprofo2.prof_factura_impresa,0),
			fatprofo2.prof_fecha_impresion,
			isnull(fatprofo2.prof_monto_a_facturar,0)
    FROM fatprofo2  
   WHERE ( fatprofo2.prof_g_financiero = :str.g_financiero ) AND  
         ( fatprofo2.prof_empresa = :str.empresa ) AND  
         ( fatprofo2.prof_tipo = '0' ) AND  
         ( fatprofo2.prof_ann = :li_ann ) AND  
         ( fatprofo2.prof_no_factura = :ls_factura )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al declarar cursor '+sqlca.sqlerrtext,1,1,'E')
		end if
	
	open fac_encab ;
	
	fetch fac_encab into :ls_condicion_pago, :ldt_fecha, :ls_nombre, :ls_direccion, :ls_consignado, &
					 :ld_monto_final, :ls_marca, :ls_tipo_movimiento, :ls_cuenta, :ls_pedido, :ldt_fecha_despacho, &
					 :ls_pasaporte, :ls_linea_aerea, :li_metal_pendiente, :ld_gastos, :ls_factura_trafico, :li_factura_impresa, :ldt_fecha_impresion, :ld_monto_a_facturar ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error en el fetch '+sqlca.sqlerrtext,1,1,'E')
		end if			 
	
	DO WHILE SQLCA.sqlcode = 0
	
		//inserta en el dw, ENCABEZADO
		if dw_9.rowcount() = 0 then
			dw_9.insertrow(1)			
		end if
		
				
		if isnull(dw_9.getitemstring(1,'prof_no_factura'))  then dw_9.setitem(1,'prof_no_factura', ls_factura)
		if isnull(dw_9.getitemstring(1,'prof_no_proforma'))  then dw_9.setitem(1,'prof_no_proforma', ls_pedido)
		dw_9.setitem(1,'prof_fecha', ldt_fecha)
		dw_9.setitem(1,'prof_fecha_despacho', ldt_fecha_despacho)		
		ls_nombre_temp = dw_9.getitemstring(1,'prof_a_nombre')
		if isnull(ls_nombre_temp) or ls_nombre_temp = '' then dw_9.setitem(1,'prof_a_nombre', ls_nombre)		
		ls_direccion_temp = dw_9.getitemstring(1,'prof_a_nombre_direccion')
		if isnull(ls_direccion_temp) or ls_direccion_temp = '' then dw_9.setitem(1,'prof_a_nombre_direccion', ls_direccion)		
		ls_marca_temp = dw_9.getitemstring(1,'prof_marca')
		if isnull(ls_marca_temp) or ls_marca_temp = '' then dw_9.setitem(1,'prof_marca', ls_marca)				
		ls_pasaporte_temp = dw_9.getitemstring(1,'prof_pasaporte')
		if isnull(ls_pasaporte_temp) or ls_pasaporte_temp = ''  then dw_9.setitem(1,'prof_pasaporte', ls_pasaporte)						
		ls_consignado_temp = dw_9.getitemstring(1,'prof_consignado')
		if isnull(ls_consignado_temp) or ls_consignado_temp = '' then dw_9.setitem(1,'prof_consignado', ls_consignado)						
		ls_linea_aerea_temp = dw_9.getitemstring(1,'prof_linea_aerea')		
		if isnull(ls_linea_aerea_temp) or ls_linea_aerea_temp = ''  then dw_9.setitem(1,'prof_linea_aerea', ls_linea_aerea)						
		ls_pasaporte_temp = dw_9.getitemstring(1,'prof_pasaporte')
		if isnull(ls_pasaporte_temp) or ls_pasaporte_temp = ''  then dw_9.setitem(1,'prof_pasaporte', ls_pasaporte)						
		ls_pasaporte_temp = dw_9.getitemstring(1,'prof_tipo_movimiento')
		if isnull(ls_pasaporte_temp) or ls_pasaporte_temp = ''  then dw_9.setitem(1,'prof_tipo_movimiento', ls_tipo_movimiento)								
		ls_cuenta_temp = dw_9.getitemstring(1,'prof_ruc_cliente')
		if isnull(ls_cuenta_temp) or ls_cuenta_temp = '' then dw_9.setitem(1,'prof_ruc_cliente', ls_cuenta)						
		ls_tipo_temp  = dw_9.getitemstring(1,'prof_condicion_pago')
		if isnull(ls_tipo_temp) or ls_tipo_temp = '' then dw_9.setitem(1,'prof_condicion_pago', ls_condicion_pago)								
		ld_gastos_temp = dw_9.getitemnumber(1,'gastos')
		if isnull(ld_gastos_temp) then ld_gastos_temp = 0
		dw_9.setitem(1,'gastos', 0)  //ld_gastos_temp + ld_gastos)
		dw_9.setitem(1,'prof_usuario', str.usuario )

		fetch fac_encab into :ls_condicion_pago, :ldt_fecha, :ls_nombre, :ls_direccion, :ls_consignado, &
					 :ld_monto_final, :ls_marca, :ls_tipo_movimiento, :ls_cuenta, :ls_pedido, :ldt_fecha_despacho, &
					 :ls_pasaporte, :ls_linea_aerea, :li_metal_pendiente, :ld_gastos, :ls_factura_trafico, :li_factura_impresa, :ldt_fecha_impresion, :ld_monto_a_facturar;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error en el fetch '+sqlca.sqlerrtext,1,1,'E')
		end if			 
		
	loop
	
	close fac_encab ;
	
	
	//Busca el detalle de la orden
		DECLARE fac_deta CURSOR FOR  
		  SELECT fadprofo2.dpro_codigo_item,   
				sum( dpro_monto_final ) monto_final,   
				sum( dpro_cantidad_fraccion ) fraccion,   
				max(medi_tipo_medida) tipo_medida,   
				case when max(medi_tipo_medida) = 5 then max(inmprodu.prod_descripcion_dos) else case when max(inmprodu.prod_division) = '004' then max(cragrupo.agru_descripcion_grupo) else max(cradivis.adiv_nombre_trafico) end end dpro_descripcion_alterna,
				sum( case when dpro_cantidad < 0 and dpro_rebajar = 0 then 0 else  case when medi_tipo_medida = 10 then 0 else dpro_cantidad end end ) cantidad,   
				sum( case when dpro_cantidad < 0 and dpro_rebajar = 0 then 0 else  case when medi_tipo_medida <> 10 then 0 else dpro_cantidad end end ) cantidad_pz , 
			   max(inmprodu.prod_division) division,			
				max(inmprodu.prod_grupo) grupo,
				max(inmprodu.prod_producto_dos) prod_original
		 FROM fadprofo2,   
				inamedid,
				inmprodu,
				inaaranc,
				cradivis,
				cragrupo
		WHERE ( fadprofo2.dpro_g_financiero = inmprodu.prod_g_financiero ) AND
				( fadprofo2.dpro_empresa = inmprodu.prod_empresa ) AND
				( fadprofo2.dpro_codigo_item = inmprodu.prod_producto ) AND
				( cradivis.adiv_g_financiero = inmprodu.prod_g_financiero ) AND
				( cradivis.adiv_empresa = inmprodu.prod_empresa ) AND
				( cradivis.adiv_codigo_div = inmprodu.prod_division ) AND								
				( cragrupo.agru_g_financiero =* inmprodu.prod_g_financiero ) AND
				( cragrupo.agru_empresa =* inmprodu.prod_empresa ) AND
				( cragrupo.agru_codigo_div =* inmprodu.prod_division ) AND				
				( cragrupo.agru_codigo_grupo =* inmprodu.prod_grupo ) AND							
				( inmprodu.prod_arancel = inaaranc.aran_arancel ) AND				
				( fadprofo2.dpro_unidad_venta = inamedid.medi_medida ) and  
				( ( fadprofo2.dpro_g_financiero = :str.g_financiero ) AND  
				( fadprofo2.dpro_empresa = :str.empresa ) AND  
				( fadprofo2.dpro_no_proforma = :ls_pedido ) AND  
				( fadprofo2.dpro_ann = :li_ann ) )   
		GROUP BY fadprofo2.dpro_codigo_item   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al declarar cursor detalle'+sqlca.sqlerrtext,1,1,'E')
		end if
	
		open fac_deta ;			
		
		fetch fac_deta into :ls_producto, :ld_monto_detalle, :ld_fraccion, :li_tipo_medida, :ls_descrip, :ld_cantidad, :ld_cantidad_pieza, :ls_division, :ls_grupo, :ls_prod_original ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error en el fetch detalle '+sqlca.sqlerrtext,1,1,'E')
		end if			 
		i = 1
		DO WHILE SQLCA.sqlcode = 0
			if dw_9.rowcount() = 0 then			 
				i = dw_9.insertrow(0)
			else
				//Busca la referencia, si la encuentra, le suma los gramos y el valor
				if li_tipo_medida <> 5 then   //  5 = GRAMOS 
				//	if ls_grupo = '004' then	//004 = ARTICULOS DE ACERO CON ORO
							//QUE AGRUPE POR EL CODIGO SECUNDARIO
				//		ls_producto = ls_division + ls_grupo
				//	else
				//		ls_producto = ls_division
				//	end if
						ls_producto = ls_prod_original
				end if
				ls_buscar   = "dpro_codigo_item = '"+ls_producto+"'"				
				li_encontro = dw_9.find(ls_buscar, 1, dw_9.rowcount())
				if isnull(li_encontro) then li_encontro = 0
				ls_producto_temp = dw_9.getitemstring(1,'dpro_codigo_item')
				if li_encontro = 0 then
					if ls_producto_temp <> '' and not isnull(ls_producto_temp) then
						i = dw_9.insertrow(0)
					end if
				else
					i = li_encontro
					ld_monto_detalle = ld_monto_detalle + dw_9.getitemnumber(li_encontro, 'monto_final')
					ld_cantidad      = ld_cantidad 		+ dw_9.getitemnumber(li_encontro, 'cantidad')					
					ld_cantidad_pieza= ld_cantidad_pieza+ dw_9.getitemnumber(li_encontro, 'cantidad_pz')
				end if
			end if
			
			dw_9.setitem(i,'dpro_codigo_item',ls_producto)
			dw_9.setitem(i,'tipo_medida',		 li_tipo_medida)
			
			  SELECT isnull(inmprodu.prod_descripcion ,'' )
				 INTO :ls_descrip  
				 FROM inmprodu  
				WHERE ( inmprodu.prod_g_financiero = :str.empresa ) AND  
						( inmprodu.prod_empresa = :li_empresa ) AND  
						( inmprodu.prod_producto = :ls_prod_original )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Buscar Descripcion '+sqlca.sqlerrtext,1,1,'E')
				end if						
			
			dw_9.setitem(i,'dpro_descripcion_alterna',ls_descrip)
			if li_metal_pendiente = 1 then
				ld_valor_pendiente = ld_cantidad 	  * str.valor_fixing
				ld_monto_detalle   = ld_monto_detalle + ld_valor_pendiente
			end if
				
			dw_9.setitem(i,'monto_final',ld_monto_detalle)			
			dw_9.setitem(i,'cantidad',	  ld_cantidad)
			dw_9.setitem(i,'cantidad_pz',ld_cantidad_pieza)

			fetch fac_deta into :ls_producto, :ld_monto_detalle, :ld_fraccion, :li_tipo_medida, :ls_descrip, :ld_cantidad, :ld_cantidad_pieza, :ls_division, :ls_grupo, :ls_prod_original ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error en el fetch detalle '+sqlca.sqlerrtext,1,1,'E')
			end if			 
			
		loop
		
		close fac_deta ;
				
		decimal{2} ld_temp
		for i = 1 to dw_9.rowcount()
			ld_monto_detalle = dw_9.getitemnumber(i,'monto_final')
			if i = 1 then
				ld_temp = ld_monto_detalle
				j = i				
			end if
			if dw_9.rowcount() = 1 then
				dw_9.setitem(i,'monto_final',ld_temp + ld_gastos)
			else
				if ld_monto_detalle > ld_temp then
					j = i
					ld_temp = ld_monto_detalle
				end if
			end if
		next
		if i > 1 then
			dw_9.setitem(j,'monto_final',ld_temp + ld_gastos)
		end if
				
dw_9.object.datawindow.print.preview = 'yes'
dw_9.object.datawindow.print.preview.zoom = 100
dw_9.object.nom_empresa.expression = "'"+str.nombre_empresa+"'"
dw_9.visible = true

if ld_monto_a_facturar <> 0 then ld_monto_final = ld_monto_a_facturar

dw_10.visible = true
dw_10.setitem(1,'valor',ld_monto_final)
dw_10.setfocus()
dw_10.setcolumn('valor')


//OpenWithParm(w_dw_print_options, dw_9)
////
//If Message.DoubleParm = -1 Then Return
//
//dw_9.Print(True)
//
//dw_1.setfocus()
//datawindow = 1
//
//
end event

type dw_9 from datawindow within w_captura_proformas_productos_no_creados
boolean visible = false
integer x = 82
integer y = 48
integer width = 3671
integer height = 1720
integer taborder = 60
boolean bringtotop = true
boolean titlebar = true
string title = "Orden de Facturacion"
string dataobject = "dw_imprimir_orden_fac"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_1 from u_ddcalen within w_captura_proformas_productos_no_creados
boolean visible = false
integer x = 1285
integer y = 128
integer taborder = 21
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;datetime ldt_fecha_tran, ldt_fecha_anterior
integer li_ann_anterior
dw_1.SetItem ( dw_1.getrow(), 'prof_fecha', uo_1.return_sel_date() )

if uo_1.allow_close then
	this.visible=false
	dw_1.SetFocus()
	
		ldt_fecha_tran 	 = dw_1.getitemdatetime(dw_1.getrow(),'prof_fecha')		
		ldt_fecha_anterior = dw_1.getitemdatetime(dw_1.getrow(),'prof_fecha', Primary!, True)		
		ii_ann = year(date(dw_1.getitemdatetime(dw_1.getrow(),'prof_fecha')))
		li_ann_anterior = dw_1.getitemnumber(1,'prof_ann')
		
		if not gf_valida_fecha_conta(ldt_fecha_anterior) then			
			dw_1.setitem(1,'prof_fecha', ldt_fecha_anterior)
			dw_1.setcolumn('prof_fecha')
			return
		end if

		if not gf_valida_fecha_conta(ldt_fecha_tran) then			
			dw_1.setitem(1,'prof_fecha', ldt_fecha_anterior)
			dw_1.setcolumn('prof_fecha')
			return
		end if

		if not gf_valida_fecha_futura(ldt_fecha_tran) then			
			if ldt_fecha_tran = ldt_fecha_anterior then
				dw_1.setitem(1,'prof_fecha', date(gf_fecha_serv()))				
			else
				dw_1.setitem(1,'prof_fecha', ldt_fecha_anterior)
			end if
			dw_1.setcolumn('prof_fecha')
			return
		end if
		
		//Si los anios son diferentes asigna el anio
		if ii_ann <> li_ann_anterior then
			dw_1.setitem(1,'prof_ann',ii_ann)
		end if
	
end if


end event

on uo_1.destroy
call u_ddcalen::destroy
end on

type dw_10 from datawindow within w_captura_proformas_productos_no_creados
boolean visible = false
integer x = 1381
integer y = 432
integer width = 736
integer height = 516
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Total a Facturar"
string dataobject = "dw_external_orden"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string ls_pedido
integer li_existe, i, j
decimal{2} ld_monto_detalle, ld_gastos, ld_valor, ld_diferencia, ld_monto_total

this.accepttext()
choose case dwo.name
	case 'b_aceptar'
		
		ld_valor = this.getitemnumber(1,'valor')
		ls_pedido = dw_9.getitemstring(1,'prof_no_proforma')
		decimal{2} ld_temp
		for i = 1 to dw_9.rowcount()
			ld_monto_detalle = dw_9.getitemnumber(i,'monto_final')
			ld_monto_total   = ld_monto_total + ld_monto_detalle
			if i = 1 then
				ld_temp = ld_monto_detalle
				j = i				
			end if
			if ld_monto_detalle > ld_temp then
				j = i
				ld_temp = ld_monto_detalle
			end if
		next

		ld_diferencia = ld_valor - ld_monto_total 		
				
		if ld_diferencia <> 0 then
			dw_9.setitem(j,'monto_final',ld_temp + ld_diferencia)
		end if
		
	  UPDATE fatprofo2  
		  SET prof_monto_a_facturar = :ld_valor  
		WHERE ( fatprofo2.prof_g_financiero = :str.g_financiero ) AND  
				( fatprofo2.prof_empresa = :str.empresa ) AND  
				( fatprofo2.prof_tipo = '0' ) AND  
				( fatprofo2.prof_no_proforma = :ls_pedido ) AND  
				( fatprofo2.prof_ann = :ii_ann ) ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al actualizar valor facturado '+sqlca.sqlerrtext,1,1,'E')
			end if
		
		PrintSetPrinter (str.printer3)
		
		if str.contabiliza = 1 then
			OpenWithParm(w_dw_print_options, dw_9)
			If Message.DoubleParm = -1 Then Return
		end if
		
		dw_9.Print(True)
		
		dw_10.visible = false	
		dw_9.visible  = false		
		
		dw_1.setfocus()
		datawindow = 1
				
	case 'b_cerrar'
		dw_10.visible = false	
		dw_9.visible  = false

end choose
end event

type dw_11 from datawindow within w_captura_proformas_productos_no_creados
boolean visible = false
integer x = 1632
integer y = 1176
integer width = 1911
integer height = 572
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_detalle_contable"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type pb_prefactura from picturebutton within w_captura_proformas_productos_no_creados
boolean visible = false
integer x = 2034
integer y = 32
integer width = 110
integer height = 96
integer taborder = 70
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
string picturename = "Retrieve!"
alignment htextalign = left!
end type

event clicked;//
String  ls_find,ls_codigo
integer li_c, li_b, li_ann_prefactura
long    ll_lter, ll_fila
string  ls_lter,ls_des
decimal{2} ld_saldo, ld_limite
Datawindow        dww
str_dg_dynamic_find	lstr_df

end event

type dw_8 from datawindow within w_captura_proformas_productos_no_creados
boolean visible = false
integer x = 1531
integer y = 292
integer width = 873
integer height = 548
integer taborder = 60
boolean bringtotop = true
boolean titlebar = true
string title = "Copiar Proforma ...."
string dataobject = "dw_external_copiar_proforma"
boolean controlmenu = true
string icon = "DataPipeline!"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;this.accepttext()
integer ll_dias_pago, li_ann_actual, li_ann
string ls_sqlerrtext, ls_prof_actual, ls_prof
datetime ldt_fecha_fin_plazo, ldt_fecha_servidor
time lt_time 
lt_time = time('00:00:00')

choose case dwo.name
	case 'b_cerrar'
		this.visible = false
	case 'b_copiar'
		sqlca.autocommit = false
		ldt_fecha_servidor = gf_fecha_serv()
		ldt_fecha_servidor = datetime(date(ldt_fecha_servidor), lt_time)
		li_ann_actual = dw_1.getitemnumber(1,'prof_ann')
		ls_prof_actual = dw_1.getitemstring(1,'prof_no_proforma')
		li_ann = year(date(ldt_fecha_servidor))
		ls_prof = this.getitemstring(1,'proforma')
		
		if ls_prof = '' or isnull(ls_prof) then return
		
		  select prof_dias_pago
		  into :ll_dias_pago
		  from fatprofo2
		  WHERE ( fatprofo2.prof_g_financiero = :str.g_financiero ) AND  
			 	  ( fatprofo2.prof_empresa = :str.empresa ) AND  
				  ( fatprofo2.prof_ann = :li_ann_actual ) AND  
				  ( fatprofo2.prof_no_proforma = :ls_prof_actual )   ;
				if sqlca.sqlcode = -1 then
					ls_sqlerrtext = sqlca.sqlerrtext
					rollback;
					mensaje("Información","Error al buscar registro en fatprofo2 ",ls_sqlerrtext)
					sqlca.autocommit = true
					return
				else
					if sqlca.sqlcode = 0 then
						ldt_fecha_fin_plazo = gf_recupera_dias(ll_dias_pago,date(ldt_fecha_servidor))
					end if
				end if			

//************************************************
			  
			  INSERT INTO fatprofo2  
						( prof_g_financiero,   
						  prof_empresa,   
						  prof_tipo,   
						  prof_no_proforma,   
						  prof_ann,   
						  prof_cliente,   
						  prof_ruc_cliente,   
						  prof_condicion_pago,   
						  prof_tipo_venta,   
						  prof_tipo_movimiento,   
						  prof_no_traspaso,   
						  prof_fecha,
						  prof_fecha_creacion,
						  prof_fecha_modificacion,   
						  prof_dias_pago,   
						  prof_consignado,   
						  prof_a_nombre,   
						  prof_a_nombre_direccion,   
						  prof_despachado,   
						  prof_via,   
						  prof_con_emb_no,   
						  prof_marca,   
						  prof_bultos_total,   
						  prof_cubicaje_total,   
						  prof_peso_total,   
						  prof_unidad_peso,   
						  prof_gastos_total,   
						  prof_monto_total,   
						  prof_descu_subt_deta,   
						  prof_por_descuento,   
						  prof_supervisor,   
						  prof_monto_final,   
						  prof_comentario,   
						  prof_estado,   
						  prof_documento,   
						  prof_actualizo_cargos,   
						  prof_actualizo_vendedor,   
						  prof_factura_de_bodega,   
						  prof_fecha_fin_plazo,   
						  prof_autorizacion,   
						  prof_cuatro_decimales,   
						  prof_precio_a_utilizar,   
						  prof_costos_total,   
						  prof_usuario,   
						  prof_restaurado_por )  
				  SELECT fatprofo2.prof_g_financiero,   
							fatprofo2.prof_empresa,   
							prof_tipo,   
							:ls_prof,   
							:li_ann,   
							fatprofo2.prof_cliente,   
							fatprofo2.prof_ruc_cliente,   
							fatprofo2.prof_condicion_pago,   
							fatprofo2.prof_tipo_venta,   
							fatprofo2.prof_tipo_movimiento,   
							fatprofo2.prof_no_traspaso,   
							:ldt_fecha_servidor,   
							:ldt_fecha_servidor,   
							fatprofo2.prof_fecha_modificacion,   
							fatprofo2.prof_dias_pago,   
							fatprofo2.prof_consignado,   
							fatprofo2.prof_a_nombre,   
							fatprofo2.prof_a_nombre_direccion,   
							fatprofo2.prof_despachado,   
							fatprofo2.prof_via,   
							fatprofo2.prof_con_emb_no,   
							fatprofo2.prof_marca,   
							fatprofo2.prof_bultos_total,   
							fatprofo2.prof_cubicaje_total,   
							fatprofo2.prof_peso_total,   
							fatprofo2.prof_unidad_peso,   
							fatprofo2.prof_gastos_total,   
							fatprofo2.prof_monto_total,   
							fatprofo2.prof_descu_subt_deta,   
							fatprofo2.prof_por_descuento,   
							fatprofo2.prof_supervisor,   
							fatprofo2.prof_monto_final,   
							fatprofo2.prof_comentario,   
							fatprofo2.prof_estado,   
							fatprofo2.prof_documento,   
							fatprofo2.prof_actualizo_cargos,   
							fatprofo2.prof_actualizo_vendedor,   
							fatprofo2.prof_factura_de_bodega,   
							:ldt_fecha_fin_plazo,   
							fatprofo2.prof_autorizacion,   
							fatprofo2.prof_cuatro_decimales,   
							fatprofo2.prof_precio_a_utilizar,   
							fatprofo2.prof_costos_total,   
							:str.usuario,   
							''  
					 FROM fatprofo2  
				    WHERE ( fatprofo2.prof_g_financiero = :str.g_financiero ) AND  
						    ( fatprofo2.prof_empresa = :str.empresa ) AND  
				    		    ( fatprofo2.prof_ann = :li_ann_actual ) AND  
						    ( fatprofo2.prof_no_proforma = :ls_prof_actual )   ;

					if sqlca.sqlcode = -1 then
						ls_sqlerrtext = sqlca.sqlerrtext
						rollback;
						mensaje("Información","Error al actualizar registro en fatprofo2",ls_sqlerrtext)
						sqlca.autocommit = true
						return
					end if			

//************************************************
				  INSERT INTO fadprofo2  
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
							  dpro_fecha_reg,   
							  dpro_usuario,   
							  dpro_supervisor,   
							  dpro_bultos,   
							  dpro_ubicacion,   
							  dpro_pasada,   
							  dpro_index,   
							  dpro_validado,   
							  dpro_bulto_inicio,   
							  dpro_bulto_fin,   
							  dpro_precio_original,   
							  dpro_costo_total,
							  dpro_modelo,
							  dpro_bultos_original,
							  dpro_comentario,
							  dpro_peso_neto,
							  dpro_cubicaje_metros)  
					  SELECT fadprofo2.dpro_g_financiero,   
								fadprofo2.dpro_empresa,   
								:ls_prof,   
								:li_ann,   
								fadprofo2.dpro_linea,   
								fadprofo2.dpro_producto_servicio,   
								fadprofo2.dpro_codigo_item,   
								fadprofo2.dpro_descripcion_alterna,   
								fadprofo2.dpro_cubucaje,   
								fadprofo2.dpro_peso,   
								fadprofo2.dpro_unidad_peso,   
								fadprofo2.dpro_unidad_producto,   
								fadprofo2.dpro_precio_mayor,   
								fadprofo2.dpro_precio_menor,   
								fadprofo2.dpro_bodega,   
								fadprofo2.dpro_costo_fob,   
								fadprofo2.dpro_costo_cif,   
								fadprofo2.dpro_precio_unidad_producto,   
								fadprofo2.dpro_unidad_venta,   
								fadprofo2.dpro_cantidad,   
								fadprofo2.dpro_fraccion,   
								fadprofo2.dpro_monto_total,   
								fadprofo2.dpro_por_descuento,   
								fadprofo2.dpro_monto_final,   
								fadprofo2.dpro_fecha_reg,   
								fadprofo2.dpro_usuario,   
								fadprofo2.dpro_supervisor,   
								fadprofo2.dpro_bultos,   
								fadprofo2.dpro_ubicacion,   
								fadprofo2.dpro_pasada,   
								fadprofo2.dpro_index,   
								fadprofo2.dpro_validado,   
								fadprofo2.dpro_bulto_inicio,   
								fadprofo2.dpro_bulto_fin,   
								fadprofo2.dpro_precio_original,   
								fadprofo2.dpro_costo_total,
								fadprofo2.dpro_modelo,
								fadprofo2.dpro_bultos_original,
								fadprofo2.dpro_comentario,
								fadprofo2.dpro_peso_neto,
								fadprofo2.dpro_cubicaje_metros
						 FROM fadprofo2  
				       WHERE ( fadprofo2.dpro_g_financiero = :str.g_financiero ) AND  
						       ( fadprofo2.dpro_empresa = :str.empresa ) AND  
						       ( fadprofo2.dpro_ann = :li_ann_actual ) AND  
						       ( fadprofo2.dpro_no_proforma = :ls_prof_actual )   ;

						if sqlca.sqlcode = -1 then
							ls_sqlerrtext = sqlca.sqlerrtext
							rollback;
							mensaje("Información","Error al actualizar registro en fadprofo2",ls_sqlerrtext)
							sqlca.autocommit = true
							return
						end if			
////************************************************
//					  INSERT INTO fadvenpr  
//								( vpro_g_financiero,   
//								  vpro_empresa,   
//								  vpro_tipo,   
//								  vpro_no_proforma,   
//								  vpro_ann,   
//								  vpro_vendedor )  
//						  SELECT fadvenpr.vpro_g_financiero,   
//									fadvenpr.vpro_empresa,   
//									fadvenpr.vpro_tipo, 
//									:ls_prof,   
//									:li_ann,   
//									fadvenpr.vpro_vendedor  
//							 FROM fadvenpr  
//							 WHERE ( fadvenpr.vpro_g_financiero = :str.g_financiero ) AND  
//									 ( fadvenpr.vpro_empresa = :str.empresa ) AND  
//									 ( fadvenpr.vpro_ann = :li_ann_actual ) AND  
//									 ( fadvenpr.vpro_no_proforma = :ls_prof_actual )   ;
//	
//							if sqlca.sqlcode = -1 then
//								ls_sqlerrtext = sqlca.sqlerrtext
//								rollback;
//								mensaje("Información","Error al actualizar registro en fadvenpr",ls_sqlerrtext)
//								sqlca.autocommit = true
//								return
//							end if			
////************************************************
//						  INSERT INTO fadproca  
//									( prca_g_financiero,   
//									  prca_empresa,   
//									  prca_ann,   
//									  prca_no_proforma,   
//									  prca_codigo_cargo,   
//									  prca_monto )  
//							  SELECT fadproca.prca_g_financiero,   
//										fadproca.prca_empresa,   
//										:li_ann,   
//										:ls_prof,   
//										fadproca.prca_codigo_cargo,   
//										fadproca.prca_monto  
//								 FROM fadproca  
//								 WHERE ( fadproca.prca_g_financiero = :str.g_financiero ) AND  
//										 ( fadproca.prca_empresa = :str.empresa ) AND  
//										 ( fadproca.prca_ann = :li_ann_actual ) AND  
//										 ( fadproca.prca_no_proforma = :ls_prof_actual )   ;
//		
//								if sqlca.sqlcode = -1 then
//									ls_sqlerrtext = sqlca.sqlerrtext
//									rollback;
//									mensaje("Información","Error al actualizar registro en fadproca",ls_sqlerrtext)
//									sqlca.autocommit = true
//									return
//								end if			
////************************************************
//                        if ll_valor > 0 then
//									update faaparam
//									set fara_ult_proforma = :ls_pedido_repl
//									where fara_g_financiero = :str.g_financiero
//									and   fara_empresa = :str.empresa ;
//									if sqlca.sqlcode = -1 then
//										ls_sqlerrtext = sqlca.sqlerrtext
//										rollback;
//										lb_salvo=false
//										mensaje("Información","Error al actualizar registro en faaparam",ls_sqlerrtext)
//										return
//									end if			
//								end if
commit ;
sqlca.autocommit = true
this.visible = false
end choose
end event

