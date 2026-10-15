//objectcomments Ventana para la Captura de Pedidos
forward
global type w_facturacion from w_fa_padre
end type
type dw_2 from datawindow within w_facturacion
end type
type dw_3 from datawindow within w_facturacion
end type
type cb_1 from commandbutton within w_facturacion
end type
type cb_2 from commandbutton within w_facturacion
end type
type dw_6 from datawindow within w_facturacion
end type
type st_1 from statictext within w_facturacion
end type
type pb_1 from picturebutton within w_facturacion
end type
type dw_7 from datawindow within w_facturacion
end type
type dw_4 from datawindow within w_facturacion
end type
type dw_5 from datawindow within w_facturacion
end type
type pb_2 from picturebutton within w_facturacion
end type
type st_2 from statictext within w_facturacion
end type
type cb_3 from commandbutton within w_facturacion
end type
type dw_9 from datawindow within w_facturacion
end type
type uo_1 from u_ddcalen within w_facturacion
end type
type dw_10 from datawindow within w_facturacion
end type
type dw_11 from datawindow within w_facturacion
end type
type pb_prefactura from picturebutton within w_facturacion
end type
type cb_4 from commandbutton within w_facturacion
end type
type em_total from editmask within w_facturacion
end type
type em_subtotal from editmask within w_facturacion
end type
type dw_8 from datawindow within w_facturacion
end type
type pb_4 from picturebutton within w_facturacion
end type
type dw_12 from datawindow within w_facturacion
end type
type pb_entradas from picturebutton within w_facturacion
end type
type dw_13 from datawindow within w_facturacion
end type
type dw_14 from datawindow within w_facturacion
end type
type cb_5 from commandbutton within w_facturacion
end type
type dw_15 from datawindow within w_facturacion
end type
type dw_16 from datawindow within w_facturacion
end type
type dw_17 from datawindow within w_facturacion
end type
type cb_6 from commandbutton within w_facturacion
end type
type pb_3 from picturebutton within w_facturacion
end type
type st_3 from statictext within w_facturacion
end type
type cb_7 from commandbutton within w_facturacion
end type
end forward

global type w_facturacion from w_fa_padre
integer x = 0
integer y = 0
integer width = 4453
integer height = 2800
string title = "Captura de Facturas"
string menuname = "m_hs"
boolean controlmenu = false
long backcolor = 12639424
windowanimationstyle openanimation = toproll!
windowanimationstyle closeanimation = topslide!
event ue_syscommand pbm_syscommand
event ue_aceptar_por_linea ( )
event ue_consolidar ( )
dw_2 dw_2
dw_3 dw_3
cb_1 cb_1
cb_2 cb_2
dw_6 dw_6
st_1 st_1
pb_1 pb_1
dw_7 dw_7
dw_4 dw_4
dw_5 dw_5
pb_2 pb_2
st_2 st_2
cb_3 cb_3
dw_9 dw_9
uo_1 uo_1
dw_10 dw_10
dw_11 dw_11
pb_prefactura pb_prefactura
cb_4 cb_4
em_total em_total
em_subtotal em_subtotal
dw_8 dw_8
pb_4 pb_4
dw_12 dw_12
pb_entradas pb_entradas
dw_13 dw_13
dw_14 dw_14
cb_5 cb_5
dw_15 dw_15
dw_16 dw_16
dw_17 dw_17
cb_6 cb_6
pb_3 pb_3
st_3 st_3
cb_7 cb_7
end type
global w_facturacion w_facturacion

type variables
integer ii_ann, datawindow, il_row, ii_cantidad_unidad, ii_cantidad_empaque, ii_vendedor, ii_acepta_descuento
String  is_entrada, is_unidad_empaque, is_secuencia, is_actualiza, is_tipo, is_unidad, is_descrip, is_item, is_user, &
		  is_cta_ingreso_local, is_cta_ingreso_exterior, is_cta_inventarios, is_cta_costos_local, is_cta_costos_exterior, is_cta_descuento , is_cta_cargos, &
		  is_b1, is_b2, is_b3, is_b4, is_b5, is_b6, is_b7, is_modelo, is_sucursal, is_cta_devoluciones, is_estado_factura
date	  idt_desde, idt_hasta
long    il_tiempo, il_segundos, il_secuencia, il_empaque, il_ucom
decimal{4} id_peso, id_cubicaje, id_cubicaje_m3
decimal{8} id_precio, id_precio_prod, id_costo_cif, id_costo_fob
decimal{2} idec_gastos, id_credito_adicional, id_porc_descuento, id_porc_maximo, id_costo_total, idec_descuento
datawindowchild idwc_cliente, idwc_tipo, idwc_vendedores, idwc_dias, idwc_formatos,  idwc_provincia, idwc_distrito, idwc_corregimiento, idwc_pais, idwc_region

integer ii_metal_pendiente
Integer MODE_ANSI = 1
Integer Handler, ii_bodegas_definidas, ii_redondeo = 2, ii_recal_precio, ii_controla_pedido
str_pase_pedido istr_pedidos
str_pase_proforma istr_proformas
str_pase_entradas istr_entradas
boolean ib_rebajar_pedido = false, ib_rebajar_proforma = false, ib_usuario_consulta, ib_rebaja_entrada = false
end variables

forward prototypes
public function boolean wf_recupera ()
public function boolean wf_orden_nueva ()
public function boolean wf_imprime_vendedor ()
public function boolean wf_asigna_vendedor ()
public subroutine wf_cargos (double ld_cargos)
public function boolean wf_actualiza_inventario ()
public subroutine wf_setear_user (string as_user)
public function boolean wf_valida_limite_credito ()
public function boolean wf_setear_user_credito (string as_user, double ad_monto, string as_nota)
public function boolean wf_setear_user_venta (string as_user, double ad_monto, string as_nota)
public function boolean wf_actualiza_cliente ()
public function boolean wf_registra_asiento_costos (string as_factura)
public function boolean wf_actualiza_factura (string as_factura)
public function boolean wf_registra_asiento (string as_factura)
public function boolean wf_act_cargos ()
public function boolean wf_act_encabezado ()
public function boolean wf_act_detalle ()
public function boolean wf_anula_movimiento ()
public function boolean wf_asigna_pre_factura (string as_pre_factura, integer ai_ann_pre_factura)
public function boolean wf_actualiza_prefactura (string as_estado)
public subroutine openport (integer port)
public subroutine enviarstringfiscal (string comando)
public function boolean wf_carga_producto (ref string as_codigo, ref string ls_descripcion, ref string as_modelo)
public function boolean wf_asigna_factura_nc (string as_factura, integer ai_ann, string as_pedido)
public subroutine wf_pasar_estructura (str_pase_pedido lstr_pedidos)
public function boolean wf_asigna_pedido (str_pase_pedido astr_pedidos)
public function boolean wf_rebaja_pedido ()
public function boolean wf_asigna_proforma (str_pase_proforma astr_proformas)
public subroutine wf_pasar_estructura_prof (str_pase_proforma lstr_proformas)
public function boolean wf_rebaja_proforma ()
public function boolean wf_recalcula_factura ()
public function integer wf_cantidad_total (integer cantidad, integer fraccion, integer row)
public subroutine wf_setea_vencimiento ()
public function integer wf_recupera_dias (integer li_codigo_dias)
public subroutine wf_consolidar_factura ()
public function double wf_calcula_precio (string as_unidad_producto, string as_unidad_venta, double ad_precio)
public function long wf_convert_min (string as_med, long al_cantidad, long al_fraccion)
public subroutine wf_convert_uni (string as_med, long al_fracciones, ref long al_cantidad, ref long al_fraccion)
public subroutine wf_monto_total (integer ai_linea, string as_unidad_prod, string as_unidad_vta, long al_cantidad, long al_fraccion, double ad_precio, datawindow adw_2, double ad_precio_original)
public function double wf_precio_por_unidad_consol (string as_unidad_prod, string as_unidad_venta, double ad_precio_minimo)
public function double wf_precio_por_unidad (string as_unidad_prod, string as_unidad_venta, double ad_precio_minimo)
public function double wf_peso ()
public subroutine wf_pasar_estructura_entrada (str_pase_entradas lstr_entradas)
public function boolean wf_asigna_entrada (str_pase_entradas astr_entradas)
public function boolean wf_rebaja_entrada ()
public function double wf_cubicaje (boolean ab_metros_cubicos)
public function boolean wf_cambiar_tipo (string as_tipo_anterior)
public function integer wf_activa_campos (boolean ab_activa)
end prototypes

event ue_syscommand;call super::ue_syscommand;if commandtype = 61536 then
	close(this)
end if
end event

event ue_consolidar();wf_consolidar_factura()
end event

public function boolean wf_recupera ();long ll_fila, ll_recuperados

str.frame.setmicrohelp('Espere mientras se recuperan los registros...')

ll_fila = dw_1.getrow()

ll_recuperados = dw_1.retrieve(str.g_financiero, str.empresa, idt_desde, idt_hasta)
if ll_recuperados > ll_fila then
	dw_1.scrolltorow(ll_fila)
end if

il_segundos = 0

str.frame.setmicrohelp('Captura de Pedidos')

return true
end function

public function boolean wf_orden_nueva ();long ll_max
integer li_ann, li_existe
string ls_max

//li_ann = year(date(gf_fecha_serv()))
if pos(str.empr_acceso_especial,"FOSTER") > 0 and str.empresa <> 3 then
	select max(fact_no_pedido )
	into	:ls_max
	from fatdiari
	where fact_g_financiero = :str.g_financiero and
			fact_empresa		= :str.empresa and
			fact_ann				= :ii_ann ;
			
			ll_max = long(ls_max)
elseif pos(str.empr_acceso_especial,"UNION") > 0 then
	select  max(convert( numeric(8),fact_no_pedido) )		//max(fact_no_pedido )
	into	:ls_max
	from fatdiari
	where fact_g_financiero = :str.g_financiero and
			fact_empresa		= :str.empresa and
			fact_ann				= :ii_ann and
			isnull(fact_pdt,0) = 0;
	if sqlca.sqlcode = -1  then
		gf_mensaje('','Error al Buscar Secuencia orden nueva Union '+sqlca.sqlerrtext,1,1,'E')		
		return false
	end if
	
	ll_max = long(ls_max)	
	
	do while true		
	  SELECT count(*)  
		 INTO :li_existe  
		 FROM fatdiari  
		WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
				( fatdiari.fact_empresa = :str.empresa ) AND  
				( fatdiari.fact_no_pedido = :ll_max ) AND  
				( fatdiari.fact_ann = :ii_ann )   ;
		if sqlca.sqlcode = -1  then
			gf_mensaje('','Error al Buscar Secuencia orden existente Union '+sqlca.sqlerrtext,1,1,'E')		
			return false
		end if
		if li_existe = 0 then
			exit
		else
			ll_max ++
		end if
	loop	
	
else
	select max(convert(numeric(10), fact_no_pedido ))
	into	:ll_max
	from fatdiari
	where fact_g_financiero = :str.g_financiero and
			fact_empresa		= :str.empresa and
			fact_ann				= :ii_ann ;
end if

	if sqlca.sqlcode = -1  then
		gf_mensaje('','Error al Buscar Secuencia orden nueva '+sqlca.sqlerrtext,1,1,'E')		
		return false
	end if
	
	if isnull(ll_max) then ll_max = 0
	
	ll_max ++
	
	dw_1.setitem(1,'fact_no_pedido',string(ll_max))
	
	is_secuencia = string(ll_max)	
return true
end function

public function boolean wf_imprime_vendedor ();integer li_hay, li_codigo, i=0
string  ls_nombre, ls_resultado, ls_nombre_imp, ls_cod_imp

datawindow ldw_3

ldw_3 = dw_4
		
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
					( fadvenfa.vfac_no_pedido = :is_secuencia ) AND  
					( fadvenfa.vfac_ann = :ii_ann ) ) ;			 
	
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
	delete from fadvenfa
	where vfac_g_financiero = :str.g_financiero and
		vfac_empresa		= :str.empresa and
		vfac_tipo			= :is_tipo and
		vfac_no_pedido		= :is_secuencia and
		vfac_ann				= :ii_ann ;
		
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Eliminar vendedor '+sqlca.sqlerrtext,1,1,'E')
			return false
		end if		
		return true
end if

select count(*)
into :li_existe
from fadvenfa
where vfac_g_financiero = :str.g_financiero and
		vfac_empresa		= :str.empresa and
		vfac_tipo			= :is_tipo and
		vfac_no_pedido		= :is_secuencia and
		vfac_ann				= :ii_ann ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al validar vendedor '+sqlca.sqlerrtext,1,1,'E')
		end if		
		
if li_existe = 0 then
	
	  INSERT INTO fadvenfa  
         ( vfac_g_financiero,   
           vfac_empresa,   
           vfac_tipo,   
           vfac_no_pedido,   
           vfac_ann,   
           vfac_vendedor )  
	  VALUES ( :str.g_financiero,   
				  :str.empresa,   
				  :is_tipo,   
				  :is_secuencia,   
				  :ii_ann,   
				  :ii_vendedor )  ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al insertar vendedor '+sqlca.sqlerrtext,1,1,'E')
			rollback ;
		end if
	
else
		
	  UPDATE fadvenfa  
		  SET vfac_vendedor = :ii_vendedor  
		WHERE ( fadvenfa.vfac_g_financiero = :str.g_financiero ) AND  
				( fadvenfa.vfac_empresa = :str.empresa ) AND  
				( fadvenfa.vfac_tipo = :is_tipo ) AND  
				( fadvenfa.vfac_no_pedido = :is_secuencia ) AND  
				( fadvenfa.vfac_ann = :ii_ann )  ;
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
 
ld_cargos_act = ldw_1.getitemnumber(ldw_1.getrow(),"fact_gastos_total")	// Cargos actuales


If ld_cargos_act <> ld_cargos then
	ldw_1.setitem(ldw_1.getrow(),"fact_gastos_total",ld_cargos)
	dw_2.object.cargos.expression = "'"+string(ld_cargos,'#,##0.00')+"'"
//	wf_recalcula()
	idec_gastos = ld_cargos
	this.postevent('ue_aceptar')
End if
end subroutine

public function boolean wf_actualiza_inventario ();//Funcion que actualiza los datos de inventario
//Declaracion de variables de memoria
sqlca.autocommit = false
string  ls_error, ls_pedido
boolean li_ok

//Inserta la información de el encabezado al Encabezado de Actualizaciones en Inventario
ls_pedido = dw_1.getitemstring(1,'fact_no_pedido')
dw_2.retrieve(str.g_financiero, str.empresa, ls_pedido, ii_ann)

li_ok = wf_act_encabezado()				//Actualiza el Encabezado

if li_ok then
	li_ok = wf_act_cargos()					//Actualiza los Cargos

	if li_ok then		//Si estubo bien o no encontro cargos
			li_ok = wf_act_detalle()	//Actualiza el Detalle
			
			if li_ok then

				if li_ok then
					return true;
				else
					ls_error = sqlca.sqlerrtext	
					rollback;				
					if ls_error <> "" then
						messagebox("ATENCIÓN SR. USUARIO","Error "+ls_error,Exclamation!)
					end if				
					return false										
				end if
		else
			ls_error = sqlca.sqlerrtext	
			rollback;			
			if ls_error <> "" then
				messagebox("ATENCIÓN SR. USUARIO","Error "+ls_error,Exclamation!)
			end if				
			messagebox("ATENCIÓN SR. USUARIO","Error al Actualizar Inventario (Detalle). Verifique")	
			return false
		end if
	else
		messagebox("ATENCIÓN SR. USUARIO","Error al Actualizar Inventario (cargos). Verifique")
		ls_error = sqlca.sqlerrtext			
		rollback;
		if ls_error <> "" then
			messagebox("ATENCIÓN SR. USUARIO","Error "+ls_error,Exclamation!)
		end if		
		return false
	end if
	
else
	messagebox("ATENCIÓN SR. USUARIO","Error al Actualizar Inventario (encabezado). Verifique")
	ls_error = sqlca.sqlerrtext	
	rollback;
	if ls_error <> "" then
		messagebox("ATENCIÓN SR. USUARIO","Error "+ls_error,Exclamation!)
		return false
	end if
end if

return true
end function

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
ll_cliente = dw_1.getitemnumber(1,'fact_cliente')
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
ll_cliente = dw_1.getitemnumber(1,'fact_cliente')
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

public function boolean wf_actualiza_cliente ();//Función que afecta la tabla de Actualizaciones en Cliente
//Variables de Memoria
datawindow ldw_1
ldw_1 = dw_1
integer  li_coddias, li_dias, li_ann, li_mes, li_nc
long     ll_cliente
string   ls_secuencia, ls_pedido, ls_nombre, ls_ruc,ls_subt, ls_comen, ls_transac, ls_error, ls_comments = '', ls_naturaleza
decimal   ld_monto,ld_descuento_ncr
datetime ldt_fecha, ldt_fechavence
string   ls_condicion_pago,ls_tran_contado, ls_time
ldw_1.accepttext()
//Cargar los valores a variables
ls_secuencia	=	dw_5.getitemstring(1,"factura")
ls_pedido		=	ldw_1.getitemstring(ldw_1.getrow(),"fact_no_pedido")
ll_cliente		=	ldw_1.getitemnumber(ldw_1.getrow(),"fact_cliente")
ls_nombre		=	ldw_1.getitemstring(ldw_1.getrow(),"fact_a_nombre")
//li_coddias			=  ldw_1.getitemnumber(ldw_1.getrow(),"fact_dias_pago")
ldt_fecha	   =  ldw_1.getitemdatetime(ldw_1.getrow(),"fact_fecha")
ld_monto			=	ldw_1.getitemnumber(ldw_1.getrow(),"fact_monto_final")
ld_monto			=  truncate( round (ld_monto, 2), 2)
li_nc    =			 dw_1.getitemnumber(1,'fact_nota_credito')

ls_time = '00:00:00'
ldt_fecha = datetime(date(ldt_fecha),time(ls_time))

ls_comments	= ldw_1.getitemstring(ldw_1.getrow(),"fact_comentario")

if ii_metal_pendiente = 1 then ls_comments = 'METAL PENDIENTE'

ls_condicion_pago	=	ldw_1.getitemstring(ldw_1.getrow(),"fact_condicion_pago")
ls_ruc			=	ldw_1.getitemstring(ldw_1.getrow(),"fact_ruc_cliente")
ldt_fechavence =  datetime(relativedate(date(ldt_fecha), 30)) //ldw_1.getitemdatetime(ldw_1.getrow(),"fact_fecha_fin_plazo")
//Para recuperar la cantidad de dias para pagar la factura
//li_dias			=  wf_recupera_dias(li_coddias)
ls_comen		   =  ldw_1.getitemstring(ldw_1.getrow(),"fact_comentario")

if ls_condicion_pago <> 'CR' then
	ls_tran_contado = 'S'
else
	ls_tran_contado = 'N'
end if

//Poner un parametro, para manejar las facturas contados
if ldw_1.Getitemstring(ldw_1.Getrow(),"fact_condicion_pago") = "CO" then
	//Si en parametros se especificó que a las facturas contado no se le hacen recibos en CXC,
	//En Facturacion se debe crear una transaccion automática que rebaje el saldo del cliente

	ls_transac = "FC" 
	
else
	ls_transac = "FA"   //Y LAS C.O.D. ??????
end if

ls_subt = is_tipo		  //Toma el Tipo de las Facturas

ls_naturaleza = 'D'

if li_nc = 1 then //PARA LAS NC
	ls_naturaleza = 'C'
	ls_transac = 'NC'
	ls_subt = '0'
	ls_pedido = dw_1.getitemstring(1,'fact_factura_referencia')
end if

//Inserta en la Tabla CCTMOVIM
		  INSERT INTO cctmovim  
					( movi_g_financiero,   
					  movi_empresa,   
					  movi_aplicacion,   
					  movi_tipo_transaccion,   
					  movi_documento,   
					  movi_anno,			
					  movi_sub_transaccion,   			  
					  movi_tercero,   
					  movi_ruc_tercero,   			  
					  movi_referencia,   
					  movi_naturaleza,   
					  movi_monto,   
					  movi_fecha_tran,   
					  movi_usuario,
					  movi_estado,
					  movi_fecha_vence,
					  movi_comentario,
					  movi_saldo,
					  movi_a_nombre,
					  movi_comments )
		  VALUES ( :str.g_financiero,
					  :str.empresa,   
					  'FA',   
					  :ls_transac,   
					  :ls_secuencia,   
					  :ii_ann,	  
					  :ls_subt,
					  :ll_cliente,   
					  :ls_ruc,
					  :ls_pedido, 			 
					  :ls_naturaleza,
					  :ld_monto,   
					  :ldt_fecha,   
					  :str.usuario,
					  "IM",
					  :ldt_fechavence,
					  :ls_comen,
					  :ld_monto,
					  :ls_nombre,
					  :ls_comments) ;

if sqlca.sqlerrtext <> "" then	
	ls_error = sqlca.sqlerrtext
	rollback ;
	gf_mensaje("Error","Error al Actualizar el Cliente " +ls_error,1,1,'E')	
	return false
end if	

return true
end function

public function boolean wf_registra_asiento_costos (string as_factura);integer li_existe, li_linea, li_empresa, li_nc
long ll_cliente
string ls_documento, ls_referencia, ls_descrip, ls_nombre, ls_cuenta, ls_codigo, ls_tran, ls_stran, ls_tipo_movimiento, ls_cuenta_costo, ls_comentario
decimal{2} ld_monto, ld_monto_detalle, ld_cargos, ld_final
datetime ldt_fecha, ldt_fecha_creacion, ldt_fecha_despacho
li_empresa = str.empresa

//if dw_1.Getitemstring(1,"fact_condicion_pago") = "CO" then
//	ls_tran = "FC" 
//else
	ls_tran = "CV"   //Y LAS C.O.D. ??????
//end if
ls_stran = 'CV'

ls_documento = as_factura
ls_referencia= dw_1.getitemstring(1,'fact_no_pedido')
ls_codigo    = dw_1.getitemstring(1,'fact_ruc_cliente')
ls_comentario = 'COSTO DE LA MERCANCIA VENDIDA'

ldt_fecha	 = dw_1.getitemdatetime(1,'fact_fecha')
ldt_fecha_despacho	 = dw_1.getitemdatetime(1,'fact_fecha_despacho')

  SELECT isnull(fatdiari.fact_costos_total ,0) 
    INTO :id_costo_total  
    FROM fatdiari  
   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
         ( fatdiari.fact_empresa = :str.empresa ) AND  
         ( fatdiari.fact_tipo = :is_tipo ) AND  
         ( fatdiari.fact_no_pedido = :is_secuencia ) AND  
         ( fatdiari.fact_ann = :ii_ann )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Buscar Costo',1,1,'E')
		end if

if id_costo_total = 0 then
	gf_mensaje('','Factura sin costos. Verifique !!!',1,1,'E')
	return false
end if

ld_final			=	id_costo_total //dw_1.getitemnumber(dw_1.getrow(),"costo_final")
ld_final			=  truncate( round (ld_final, 2), 2)
//ld_monto 	 = dw_1.getitemnumber(dw_1.getrow(),"sub_total")
//ld_cargos	 = dw_1.getitemnumber(dw_1.getrow(),"gastos")

if ldt_fecha_despacho > ldt_fecha then
	ldt_fecha = ldt_fecha_despacho
end if

ldt_fecha_creacion = gf_fecha_serv()
ls_descrip	 = 'COSTO FACTURA'
ls_nombre	 = dw_1.getitemstring(1,'fact_a_nombre')
ll_cliente	 = dw_1.getitemNumber(1,'fact_cliente')

li_nc    =		 dw_1.getitemnumber(1,'fact_nota_credito')
if li_nc = 1 then //PARA LAS NC
	ls_descrip = 'NOTA CREDITO - COSTO'
	ls_referencia= 'F-'+dw_1.getitemstring(1,'fact_factura_referencia')	
end if

  SELECT count(*)  
    INTO :li_existe  
    FROM cotdiari  
   WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
         ( cotdiari.diar_empresa = :li_empresa ) AND  
         ( cotdiari.diar_aplicacion_mg = 'FA' ) AND  
         ( cotdiari.diar_tipo_transaccion = :ls_tran ) AND  
         ( cotdiari.diar_sub_trans = :ls_stran ) AND  
         ( cotdiari.diar_no_documento = :ls_documento ) AND  
         ( cotdiari.diar_no_referencia = :ls_referencia ) AND  
         ( cotdiari.diar_ann = :ii_ann );
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Validar Existencia '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return false
		end if

	if li_existe = 0 then
		
		  INSERT INTO cotdiari  
         ( diar_g_financiero,   
           diar_empresa,   
           diar_aplicacion_mg,   
           diar_tipo_transaccion,   
           diar_sub_trans,   
           diar_no_documento,   
           diar_no_referencia,   
           diar_ann,   
           diar_fecha_transaccion,   
           diar_descripcion,   
           diar_id,   
           diar_fecha_creacion,   
           diar_estado,   
           diar_monto,   
           diar_balance,   
           diar_modificado,   
           diar_cerrado,   
           diar_cierre_mensual,   
           diar_banco,   
           diar_documento_a,   
           diar_nombre ,
			  diar_comentario)  
  VALUES ( :str.g_financiero,   
           :li_empresa,   
           'FA',   
           :ls_tran,   
           :ls_stran,   
           :ls_documento,   
           :ls_referencia,   
           :ii_ann,   
           :ldt_fecha,   
           :ls_descrip,   
           :str.usuario,   
           :ldt_fecha_creacion,   
           'I',   
           :id_costo_total,   
           1,   
           0,   
           'N',   
           'N',   
           null,   
           null,   
           :ls_nombre,
			  :ls_comentario)  ;
			  if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Insertar '+sqlca.sqlerrtext,1,1,'E')
					rollback;
					return false
			  end if
		
	else  // si ya existe se hace update
		
		  UPDATE cotdiari  
		  SET diar_fecha_transaccion = :ldt_fecha,   
				diar_descripcion = :ls_descrip,   
				diar_id = :str.usuario,   
				diar_monto = :id_costo_total,   
				diar_nombre = :ls_nombre  
		WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
				( cotdiari.diar_empresa = :li_empresa ) AND  
				( cotdiari.diar_aplicacion_mg = 'FA' ) AND  
				( cotdiari.diar_tipo_transaccion = :ls_tran ) AND  
				( cotdiari.diar_sub_trans = :ls_stran ) AND  
				( cotdiari.diar_no_documento = :ls_documento ) AND  
				( cotdiari.diar_no_referencia = :ls_referencia ) AND  
				( cotdiari.diar_ann = :ii_ann ) ;
			  if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
					rollback;
					return false
			  end if
		
	end if

//Inserta el detalle contable
	ls_tipo_movimiento = dw_1.getitemstring(1,'fact_tipo_movimiento')	
	if ls_tipo_movimiento = 'L' then	//Liquidacion, venta local
		ls_cuenta_costo = is_cta_costos_local
	else	//Venta exterior
		ls_cuenta_costo = is_cta_costos_exterior				
	end if

	dw_11.reset()
	dw_11.insertrow(1)
	dw_11.setitem(1,'ddia_fecha', date(gf_fecha_serv()))
	dw_11.setitem(1,'ddia_g_financiero',str.g_financiero)
	dw_11.setitem(1,'ddia_empresa',li_empresa)
	dw_11.setitem(1,'ddia_aplicacion_mg','FA')
	dw_11.setitem(1,'ddia_ann', ii_ann)
	dw_11.setitem(1,'ddia_banco_cuenta', '1')
	dw_11.setitem(1,'ddia_id', str.usuario)
	dw_11.setitem(1,'ddia_tipo_transaccion', ls_tran)
	dw_11.setitem(1,'ddia_sub_trans', ls_stran)
	dw_11.setitem(1,'ddia_no_documento', ls_documento)
	dw_11.setitem(1,'ddia_no_referencia', ls_referencia)
	if li_nc = 1 then //PARA LAS NC
		dw_11.setitem(1,'naturaleza','C')	
		dw_11.setitem(1,'monto_credito',id_costo_total)			
	else
		dw_11.setitem(1,'naturaleza','D')	
		dw_11.setitem(1,'monto_debito',id_costo_total)	
	end if	
	dw_11.setitem(1,'ddia_linea',1)
	dw_11.setitem(1,'tipo','C')
	dw_11.setitem(1,'ddia_mg_cuenta',ls_cuenta_costo)
	dw_11.setitem(1,'ddia_monto',id_costo_total)
	dw_11.setitem(1,'ddia_tercero',ll_cliente)	
	dw_11.setitem(1,'ddia_documento_anexo',ls_referencia)
	dw_11.setitem(1,'ddia_codigo_cte_prov',ls_codigo)		

		li_linea = dw_11.insertrow(0)
		dw_11.setitem(li_linea,'ddia_fecha', date(gf_fecha_serv()))
		dw_11.setitem(li_linea,'ddia_g_financiero',str.g_financiero)
		dw_11.setitem(li_linea,'ddia_empresa',li_empresa)
		dw_11.setitem(li_linea,'ddia_aplicacion_mg','FA')
		dw_11.setitem(li_linea,'ddia_banco_cuenta', '1')
		dw_11.setitem(li_linea,'ddia_ann', ii_ann)
		dw_11.setitem(li_linea,'ddia_id', str.usuario)
		dw_11.setitem(li_linea,'ddia_tipo_transaccion', ls_tran)
		dw_11.setitem(li_linea,'ddia_sub_trans',ls_stran)
		dw_11.setitem(li_linea,'ddia_no_documento', ls_documento)
		dw_11.setitem(li_linea,'ddia_no_referencia', ls_referencia)
		if li_nc = 1 then //PARA LAS NC
			dw_11.setitem(li_linea,'naturaleza','D')	
			dw_11.setitem(li_linea,'monto_debito',id_costo_total)			
		else	
			dw_11.setitem(li_linea,'naturaleza','C')	
			dw_11.setitem(li_linea,'monto_credito',id_costo_total)			
		end if
		dw_11.setitem(li_linea,'ddia_linea',li_linea)
		dw_11.setitem(li_linea,'tipo','C')
		dw_11.setitem(li_linea,'ddia_mg_cuenta',is_cta_inventarios)
		dw_11.setitem(li_linea,'ddia_monto',id_costo_total)
		dw_11.setitem(li_linea,'ddia_tercero',ll_cliente)	
		dw_11.setitem(li_linea,'ddia_documento_anexo',ls_referencia)		
				
	//valida q este en balance
	if dw_11.getitemnumber(1,'balance') <> 0 then
		gf_mensaje('','Debe Balancear la Transaccion de Costos para Guardar, Verifique !!!',1,1,'E')
		rollback;
		return false
	end if
	
	if dw_11.update() = -1 then
		gf_mensaje('','Error al Actualizar Detalle del Asiento Contable de Costos '+sqlca.sqlerrtext,1,1,'E')
		rollback;
		return false		
	end if

return true
end function

public function boolean wf_actualiza_factura (string as_factura);string ls_factura, ls_cadena
integer li_nc, li_retorno
sqlca.autocommit = false
	ls_factura = dw_5.getitemstring(1,'factura')
	is_tipo = 	 dw_1.getitemstring(1,'fact_tipo')
	dw_1.setitem(1,'fact_no_factura', ls_factura)
	li_nc    =		 dw_1.getitemnumber(1,'fact_nota_credito')
		
	//dw_1.setitem(1,'fact_fecha', date(gf_fecha_serv()))
		
	if wf_actualiza_cliente() then
		if wf_actualiza_inventario() then					
			
			if str.contabiliza = 1 then
				//Actualiza el asiento contable ingresos
				if not wf_registra_asiento(ls_factura) then
					dw_1.setitem(1,'fact_no_factura', '')					
					dw_11.reset()
					rollback ;
					sqlca.autocommit = true
					return false
				end if
				//Actualiza el asiento contable costos		
				if not wf_registra_asiento_costos(ls_factura) then
					dw_1.setitem(1,'fact_no_factura', '')
					dw_11.reset()
					rollback ;
					sqlca.autocommit = true
					return false
				end if
			end if
			
			dw_1.setitem(1,'fact_estado', 'I')	
			dw_1.setitem(1,'fact_act_cliente', 1)				
			dw_1.setitem(1,'fact_act_inventario', 1)		
			
			if dw_1.update() = -1 then			
				gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext ,1,1,'E')				
				rollback ;
				sqlca.autocommit = true			
				return false
			else //Si todo ok
					if li_nc = 1 then
							UPDATE faaparam  
							  SET faaparam.fara_ult_devolucion = :ls_factura  
							WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
									( faaparam.fara_empresa = :str.empresa ) ;					
					else
							UPDATE faaparam  
							  SET fara_ult_ultima_factura = :ls_factura  
							WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
									( faaparam.fara_empresa = :str.empresa ) ;
					end if
					if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext ,1,1,'E')
							rollback ;
							sqlca.autocommit = true			
							return false						
					end if
			end if		
		else //del actualizar cliente
			dw_1.setitem(1,'fact_no_factura', '')			
			rollback ;
			sqlca.autocommit = true
			return false
		end if
	else
		dw_1.setitem(1,'fact_no_factura', '')
		rollback ;
		sqlca.autocommit = true
		return false
	end if

commit;
sqlca.autocommit = true
is_sucursal = '0001'
ls_cadena = string(str.g_financiero)+','+string(str.empresa)+','+'"'+is_tipo+'"'+ ','+'"'+is_sucursal+'"'+','+'"'+is_secuencia+'"'+','+string(ii_ann)+','+'"'+as_factura+'"'
li_retorno = Run('C:\Sistemas\Integracion\IntegraciondirectaCSharpTF.exe '+ls_cadena, Minimized!)
sleep(10)
dw_1.retrieve(str.g_financiero, str.empresa, is_secuencia, ii_ann )
//gf_mensaje('','Actualizacion Exitosa',1,1,'E')
return true
end function

public function boolean wf_registra_asiento (string as_factura);integer li_existe, li_linea, li_empresa, li_nc, i
long ll_cliente
string ls_comentario, ls_documento, ls_referencia, ls_descrip, ls_nombre, ls_cuenta, ls_codigo, ls_tran, ls_stran, ls_tipo_movimiento, ls_cuenta_ingreso, ls_cuenta_cargos
decimal{2} ld_monto, ld_monto_detalle, ld_cargos, ld_final, ld_descuento, ld_monto_cargos
datetime ldt_fecha, ldt_fecha_creacion, ldt_fecha_despacho

li_empresa = str.empresa

//if dw_1.Getitemstring(1,"fact_condicion_pago") = "CO" then
//	ls_tran = "FC" 
//else
	ls_tran = "FA"   //Y LAS C.O.D. ??????
//end if
ls_stran = is_tipo

ls_documento = as_factura
ls_referencia= dw_1.getitemstring(1,'fact_no_pedido')
ls_codigo    = dw_1.getitemstring(1,'fact_ruc_cliente')

ldt_fecha	 = dw_1.getitemdatetime(1,'fact_fecha')
ldt_fecha_despacho	 = dw_1.getitemdatetime(1,'fact_fecha_despacho')
ld_final			=	dw_2.getitemnumber(dw_2.getrow(),"monto_final")
ld_final			=  truncate( round (ld_final, 2), 2)
ld_descuento   = dw_1.getitemnumber(1,'fact_por_descuento')
ld_descuento			=  truncate( round (ld_descuento, 2), 2)
ld_monto 	 = dw_2.getitemnumber(dw_2.getrow(),"monto_total")
ld_monto			=  truncate( round (ld_monto, 2), 2)
ld_cargos	 = dw_1.getitemnumber(dw_1.getrow(),"fact_gastos_total")
ld_cargos			=  truncate( round (ld_cargos, 2), 2)

//if ldt_fecha_despacho > ldt_fecha then
//	ldt_fecha = ldt_fecha_despacho
//end if

ldt_fecha_creacion = gf_fecha_serv()
ls_descrip	 = 'FACTURA'
ls_nombre	 = dw_1.getitemstring(1,'fact_a_nombre')
ll_cliente	 = dw_1.getitemNumber(1,'fact_cliente')
ls_comentario	 = dw_1.getitemstring(1,'fact_comentario')

li_nc    =		 dw_1.getitemnumber(1,'fact_nota_credito')
if li_nc = 1 then //PARA LAS NC
	ls_tran = 'NC'
	ls_stran = '0'
	ls_descrip = 'NOTA CREDITO'
	ls_referencia= 'F-'+dw_1.getitemstring(1,'fact_factura_referencia')	
end if

  SELECT count(*)  
    INTO :li_existe  
    FROM cotdiari  
   WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
         ( cotdiari.diar_empresa = :li_empresa ) AND  
         ( cotdiari.diar_aplicacion_mg = 'FA' ) AND  
         ( cotdiari.diar_tipo_transaccion = :ls_tran ) AND  
         ( cotdiari.diar_sub_trans = :ls_stran ) AND  
         ( cotdiari.diar_no_documento = :ls_documento ) AND  
         ( cotdiari.diar_no_referencia = :ls_referencia ) AND  
         ( cotdiari.diar_ann = :ii_ann );
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Validar Existencia '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return false
		end if

	if li_existe = 0 then

  INSERT INTO cotdiari  
         ( diar_g_financiero,   
           diar_empresa,   
           diar_aplicacion_mg,   
           diar_tipo_transaccion,   
           diar_sub_trans,   
           diar_no_documento,   
           diar_no_referencia,   
           diar_banco_cuenta,   
           diar_ann,   
           diar_fecha_transaccion,   
           diar_descripcion,   
           diar_id,   
           diar_fecha_creacion,   
           diar_estado,   
           diar_monto,   
           diar_balance,   
           diar_modificado,   
           diar_cerrado,   
           diar_cierre_mensual,   
           diar_banco,   
           diar_documento_a,   
           diar_nombre,   
           diar_impreso,
			  diar_comentario)  
  VALUES ( :str.g_financiero,   
           :str.empresa,   
           'FA',   
           :ls_tran,   
           :ls_stran,   
           :ls_documento,   
           :ls_referencia,   
           '1',   
           :ii_ann,   
           :ldt_fecha,   
           :ls_descrip,   
           :str.usuario,   
           getdate(),   
           'I',   
           :ld_final,   
           1,   
           0,   
           'N',   
           'N',   
           null,   
           null,   
           :ls_nombre,   
           'N',
			  :ls_comentario )  ;
			  if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Insertar Contabilidad Encabezado '+sqlca.sqlerrtext,1,1,'E')
					rollback;
					return false
			  end if
		
	else  // si ya existe se hace update
		
		  UPDATE cotdiari  
		  SET diar_fecha_transaccion = :ldt_fecha,   
				diar_descripcion = :ls_descrip,   
				diar_id = :str.usuario,   
				diar_monto = :ld_final,   
				diar_nombre = :ls_nombre,
				diar_comentario = :ls_comentario
		WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
				( cotdiari.diar_empresa = :li_empresa ) AND  
				( cotdiari.diar_aplicacion_mg = 'FA' ) AND  
				( cotdiari.diar_tipo_transaccion = :ls_tran ) AND  
				( cotdiari.diar_sub_trans = :ls_stran ) AND  
				( cotdiari.diar_no_documento = :ls_documento ) AND  
				( cotdiari.diar_no_referencia = :ls_referencia ) AND  
				( cotdiari.diar_ann = :ii_ann ) ;
			  if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
					rollback;
					return false
			  end if
		
	end if

//Inserta el detalle contable
//Inserta la parte del cliente Cuentas por Cobrar

   SELECT isnull(ccmclien.clie_mg_cuenta,'')  
    INTO :ls_cuenta  
    FROM ccmclien,   
         dgmplanc  
   WHERE ( ccmclien.clie_g_financiero = dgmplanc.mg_g_financiero ) and  
         ( ccmclien.clie_empresa = dgmplanc.mg_empresa ) and  
         ( ccmclien.clie_mg_cuenta = dgmplanc.mg_cuenta ) and  
         ( ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
         ( ccmclien.clie_empresa = :li_empresa ) AND  
         ( ccmclien.clie_tercero = :ll_cliente ) )   ;
		  if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Buscar cuenta '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				return false
		  elseif ls_cuenta = '' then
				gf_mensaje('','Asigne la Cuenta Contable al Cliente para Actualizar la Factura',1,1,'E')
				rollback;
				return false	
		  end if
		  
	dw_11.reset()
	dw_11.insertrow(1)
	dw_11.setitem(1,'ddia_fecha', date(gf_fecha_serv()))
	dw_11.setitem(1,'ddia_g_financiero',str.g_financiero)
	dw_11.setitem(1,'ddia_empresa',li_empresa)
	dw_11.setitem(1,'ddia_aplicacion_mg','FA')
	dw_11.setitem(1,'ddia_banco_cuenta', '1')
	dw_11.setitem(1,'ddia_ann', ii_ann)
	dw_11.setitem(1,'ddia_id', str.usuario)
	dw_11.setitem(1,'ddia_tipo_transaccion', ls_tran)
	dw_11.setitem(1,'ddia_sub_trans', ls_stran)
	dw_11.setitem(1,'ddia_no_documento', ls_documento)
	dw_11.setitem(1,'ddia_no_referencia', ls_referencia)
	if li_nc = 1 then //PARA LAS NC
		dw_11.setitem(1,'naturaleza','C')	
		dw_11.setitem(1,'monto_credito',ld_final)			
	else
		dw_11.setitem(1,'naturaleza','D')	
		dw_11.setitem(1,'monto_debito',ld_final)	
	end if
	dw_11.setitem(1,'ddia_linea',1)
	dw_11.setitem(1,'tipo','C')
	dw_11.setitem(1,'ddia_mg_cuenta',ls_cuenta)
	dw_11.setitem(1,'ddia_monto',ld_final)
	dw_11.setitem(1,'ddia_tercero',ll_cliente)
	dw_11.setitem(1,'ddia_documento_anexo',ls_referencia)
	dw_11.setitem(1,'ddia_codigo_cte_prov',ls_codigo)

	ls_tipo_movimiento = dw_1.getitemstring(1,'fact_tipo_movimiento')
	
//	if ls_tipo_movimiento = 'L' then	//Liquidacion, venta local
//		ls_cuenta_ingreso = is_cta_ingreso_local
//	else	//Venta exterior
//		ls_cuenta_ingreso = is_cta_ingreso_exterior				
//	end if
if li_nc = 1 then
	
	ls_cuenta_ingreso = is_cta_devoluciones
	
else
	
	  SELECT dgmserdr.serd_mgcuenta  
		 INTO :ls_cuenta_ingreso  
		 FROM dgmserdr  
		WHERE ( dgmserdr.serd_g_financiero = :str.g_financiero ) AND  
				( dgmserdr.serd_empresa = :str.empresa ) AND  
				( dgmserdr.serd_transaccion = :ls_tran ) AND  
				( dgmserdr.serd_sub_trans = :is_tipo ) AND  
				( dgmserdr.serd_aplicacion = 'FA' )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Buscar cuenta ingresos '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return false
		end if
end if

		if isnull(ls_cuenta_ingreso) or ls_cuenta_ingreso = '' then
			gf_mensaje('','Cuenta de Ingresos Invalida, Verifique !!!',1,1,'E')
			rollback;
			return false			
		end if
	
		li_linea = dw_11.insertrow(0)
		dw_11.setitem(li_linea,'ddia_fecha', date(gf_fecha_serv()))
		dw_11.setitem(li_linea,'ddia_g_financiero',str.g_financiero)
		dw_11.setitem(li_linea,'ddia_empresa',li_empresa)
		dw_11.setitem(li_linea,'ddia_aplicacion_mg','FA')
		dw_11.setitem(li_linea,'ddia_banco_cuenta', '1')		
		dw_11.setitem(li_linea,'ddia_ann', ii_ann)
		dw_11.setitem(li_linea,'ddia_id', str.usuario)
		dw_11.setitem(li_linea,'ddia_tipo_transaccion', ls_tran)
		dw_11.setitem(li_linea,'ddia_sub_trans',ls_stran)
		dw_11.setitem(li_linea,'ddia_no_documento', ls_documento)
		dw_11.setitem(li_linea,'ddia_no_referencia', ls_referencia)
		if li_nc = 1 then //PARA LAS NC
			dw_11.setitem(li_linea,'naturaleza','D')	
			dw_11.setitem(li_linea,'monto_debito',ld_monto)			
		else
			dw_11.setitem(li_linea,'naturaleza','C')				
			dw_11.setitem(li_linea,'monto_credito',ld_monto)			
		end if		
		dw_11.setitem(li_linea,'ddia_linea',li_linea)
		dw_11.setitem(li_linea,'tipo','C')
		dw_11.setitem(li_linea,'ddia_mg_cuenta',ls_cuenta_ingreso)
		dw_11.setitem(li_linea,'ddia_monto',ld_monto)
		dw_11.setitem(li_linea,'ddia_tercero',ll_cliente)	
		dw_11.setitem(li_linea,'ddia_documento_anexo',ls_referencia)		
	
	if ld_cargos <> 0 then
		
		dw_16.retrieve(str.g_financiero, str.empresa, ls_stran, ls_referencia, ii_ann)
		for i = 1 to dw_16.rowcount()
			ls_cuenta_cargos = dw_16.getitemstring(i,'carg_cuenta')	
			ld_monto_cargos = dw_16.getitemnumber(i,'dcar_monto')
			
			li_linea = dw_11.insertrow(0)
			dw_11.setitem(li_linea,'ddia_fecha', date(gf_fecha_serv()))
			dw_11.setitem(li_linea,'ddia_g_financiero',str.g_financiero)
			dw_11.setitem(li_linea,'ddia_empresa',li_empresa)
			dw_11.setitem(li_linea,'ddia_aplicacion_mg','FA')
			dw_11.setitem(li_linea,'ddia_banco_cuenta', '1')		
			dw_11.setitem(li_linea,'ddia_ann', ii_ann)
			dw_11.setitem(li_linea,'ddia_id', str.usuario)
			dw_11.setitem(li_linea,'ddia_tipo_transaccion', ls_tran)
			dw_11.setitem(li_linea,'ddia_sub_trans',ls_stran)
			dw_11.setitem(li_linea,'ddia_no_documento', ls_documento)
			dw_11.setitem(li_linea,'ddia_no_referencia', ls_referencia)
			if li_nc = 1 then //PARA LAS NC
				dw_11.setitem(li_linea,'naturaleza','D')		
				dw_11.setitem(li_linea,'monto_debito',ld_monto_cargos)						
			else
				dw_11.setitem(li_linea,'naturaleza','C')		
				dw_11.setitem(li_linea,'monto_credito',ld_monto_cargos)			
			end if		
			dw_11.setitem(li_linea,'ddia_linea',li_linea)
			dw_11.setitem(li_linea,'tipo','C')
			dw_11.setitem(li_linea,'ddia_mg_cuenta',ls_cuenta_cargos)
			dw_11.setitem(li_linea,'ddia_monto',ld_monto_cargos)
			dw_11.setitem(li_linea,'ddia_tercero',ll_cliente)	
			dw_11.setitem(li_linea,'ddia_documento_anexo',ls_referencia)		
			
		next
		
	end if
	if ld_descuento <> 0 then
		li_linea = dw_11.insertrow(0)
		dw_11.setitem(li_linea,'ddia_fecha', date(gf_fecha_serv()))
		dw_11.setitem(li_linea,'ddia_g_financiero',str.g_financiero)
		dw_11.setitem(li_linea,'ddia_empresa',li_empresa)
		dw_11.setitem(li_linea,'ddia_aplicacion_mg','FA')
		dw_11.setitem(li_linea,'ddia_banco_cuenta', '1')
		dw_11.setitem(li_linea,'ddia_ann', ii_ann)
		dw_11.setitem(li_linea,'ddia_id', str.usuario)
		dw_11.setitem(li_linea,'ddia_tipo_transaccion', ls_tran)
		dw_11.setitem(li_linea,'ddia_sub_trans',ls_stran)
		dw_11.setitem(li_linea,'ddia_no_documento', ls_documento)
		dw_11.setitem(li_linea,'ddia_no_referencia', ls_referencia)
		if li_nc = 1 then //PARA LAS NC
			dw_11.setitem(li_linea,'naturaleza','C')		
			dw_11.setitem(li_linea,'monto_credito',ld_descuento)						
		else
			dw_11.setitem(li_linea,'naturaleza','D')		
			dw_11.setitem(li_linea,'monto_debito',ld_descuento)			
		end if				
		dw_11.setitem(li_linea,'ddia_linea',li_linea)
		dw_11.setitem(li_linea,'tipo','C')
		dw_11.setitem(li_linea,'ddia_mg_cuenta',is_cta_descuento)
		dw_11.setitem(li_linea,'ddia_monto',ld_descuento)
		dw_11.setitem(li_linea,'ddia_tercero',ll_cliente)	
		dw_11.setitem(li_linea,'ddia_documento_anexo',ls_referencia)		
	end if
	
	//valida q este en balance
	if dw_11.getitemnumber(1,'balance') <> 0 then
		gf_mensaje('','Debe Balancear la Transaccion para Guardar, Verifique !!!',1,1,'E')
		rollback;
		return false
	end if
	
	if dw_11.update() = -1 then
		gf_mensaje('','Error al Actualizar Detalle del Asiento Contable '+sqlca.sqlerrtext,1,1,'E')
		rollback;
		return false		
	end if

return true
end function

public function boolean wf_act_cargos ();//Funcion que actualiza el detalle de los cargos
integer li_nc, li_exist, li_linea,  li_ok
long   ll_factura
string ls_descrip, ls_concepto, ls_pedido, ls_tran
double ld_monto

//Función que Verifica si hay detalle
str.frame.setmicrohelp("Actualizando cargos de la Factura...") 

ls_pedido	 = dw_1.getitemstring(dw_1.getrow(),"fact_no_pedido")

  SELECT count(*)  
    INTO :li_exist  
    FROM fadcargo  
   WHERE ( fadcargo.dcar_g_financiero = :str.g_financiero ) AND  
         ( fadcargo.dcar_empresa = :str.empresa ) AND  
         ( fadcargo.dcar_no_pedido = :ls_pedido ) AND  
         ( fadcargo.dcar_ann = :ii_ann ) AND  
         ( fadcargo.dcar_tipo = :is_tipo )   ;
			
			if sqlca.sqlcode = -1 then
				gf_mensaje("","Error al Verificar Existencia de los cargos "+sqlca.sqlerrtext,1,1,"E")
			end if

  If li_exist > 0 Then	
		
  ls_concepto = is_tipo		
		
	li_nc    =			 dw_1.getitemnumber(1,'fact_nota_credito')
	if li_nc = 1 then
		ls_tran    = 'DV'
	else
		ls_tran    = 'SA'
	end if		
		
  DECLARE cursor_gas CURSOR FOR  
  SELECT faacargo.carg_descripcion,   
         fadcargo.dcar_monto  
    FROM fadcargo,   
         faacargo  
   WHERE ( fadcargo.dcar_g_financiero = faacargo.carg_g_financiero ) and  
			( fadcargo.dcar_empresa = faacargo.carg_empresa ) and  
   		( fadcargo.dcar_codigo = faacargo.carg_cargo ) and  
         ( ( fadcargo.dcar_g_financiero =:str.g_financiero  ) AND  
         ( fadcargo.dcar_empresa = :str.empresa ) AND  
         ( fadcargo.dcar_no_pedido = :ls_pedido  ) AND  
         ( fadcargo.dcar_ann = :ii_ann  ) AND  
         ( fadcargo.dcar_tipo = :is_tipo ) )   ;
			
		if sqlca.sqlcode = -1 then
			mensaje("Información","Error al Seleccionar registros en la tabla fadcargo",sqlca.sqlerrtext)
			return false
		end if			
						
				
		OPEN cursor_gas;
		
		FETCH cursor_gas INTO :ls_descrip, :ld_monto;				
					
		IF SQLCA.SQLCODE = -1 THEN
			MESSAGEBOX("ATENCION SR. USUARIO.","ERROR EN LA ACTUALIZACIÓN DE LOS GASTOS")
			CLOSE cursor_gas;
			RETURN false
		END IF	
		
		DO WHILE SQLCA.SQLCODE = 0
			
			li_linea = li_linea + 1

			INSERT INTO indgasto  
         ( gast_g_financiero,   
           gast_empresa,   
           gast_aplicacion,   
           gast_transaccion,   
		  gast_concepto,
           gast_secuencia,   
           gast_linea,   
		  gast_ann,
           gast_descripcion,   
           gast_valor )  
VALUES ( :str.g_financiero,   
		  :str.empresa,   
		  "FA",   
		  :ls_tran,
		  :ls_concepto,
		  :il_secuencia,   //Se cargo en act_encabezado
		  :li_linea,   
		  :ii_ann,
		  :ls_descrip,   
		  :ld_monto )  ;
						  
//			li_ok = sqlca.sqlcode						  
						
			IF  SQLCA.SQLCODE = -1 THEN 
				messagebox("Error al actualizar los cargos :",sqlca.sqlerrtext)
				ROLLBACK USING SQLCA;
				CLOSE cursor_gas;
				return false			
		   END IF
		 
		FETCH cursor_gas INTO :ls_descrip, :ld_monto;
			IF  SQLCA.SQLCODE = -1 THEN 
				messagebox("Error en el Fetch :",sqlca.sqlerrtext)
				ROLLBACK USING SQLCA;
				CLOSE cursor_gas;
				return false
		   END IF
		
		
      LOOP

	CLOSE cursor_gas;

end if
str.frame.setmicrohelp("")
return true
end function

public function boolean wf_act_encabezado ();//Funcion que inserta el encabezado de la factura activa, al detalle de actualizaciones
//de inventario
//Declaracion de variables de memoria
str.frame.setmicrohelp("Actualizando el Encabezado")

integer li_anual, li_nc, li_rebaja_reserva
long  ll_cliente,  ll_secuencia
string ls_documento, ls_comen, ls_concepto, ls_fabricante, ls_secuencia, ls_nombre_tercero, &
		 ls_terminos, ls_pedido, ls_movimiento, ls_tipo, ls_tran, ls_descrip
datetime ldt_fecha
time	lt_time
double ld_costo, ld_peso, ld_precio, ld_cubicaje, ld_final, ld_cargos, ld_monto

lt_time = TIME('00:00:00')//time(gf_fecha_serv())

//Cargar los datos en las variables
ls_pedido	 = dw_1.getitemstring(dw_1.getrow(),"fact_no_pedido")
ls_documento = dw_1.getitemstring(dw_1.getrow(),"fact_no_factura")
ls_secuencia = dw_1.getitemstring(dw_1.getrow(),"fact_no_factura")
ll_secuencia = long(ls_secuencia)
ldt_fecha	 = dw_1.getitemdatetime(dw_1.getrow(),"fact_fecha")
ll_cliente   = dw_1.getitemnumber(dw_1.getrow(),"fact_cliente")
ls_nombre_tercero = dw_1.getitemstring(dw_1.getrow(),"fact_a_nombre")
ls_terminos	 = dw_1.getitemstring(dw_1.getrow(),"fact_condicion_pago")
li_nc    =			 dw_1.getitemnumber(1,'fact_nota_credito')
if li_nc = 1 then
	ls_descrip		 = "Nota Credito # "+ls_secuencia
	ls_comen		 =	"Nota Credito # "+ls_secuencia+" /Ped. "+ls_pedido+" a "+ls_nombre_tercero
	ls_tipo 	= 'D'
	ls_tran    = 'DV'
	li_rebaja_reserva = 0
else
	ls_descrip		 = "Factura # "+ls_secuencia
	ls_comen		 =	"Factura # "+ls_secuencia+" "+ls_terminos+ " /Ped. "+ls_pedido+" a "+ls_nombre_tercero	
	ls_tipo	= 'C'
	ls_tran    = 'SA'
	li_rebaja_reserva	= 1
end if
//ldw_1.getitemstring(ldw_1.getrow(),"fact_comentario")
ld_final     = dw_1.getitemnumber(dw_1.getrow(),"fact_monto_final")
ld_monto 	 = dw_1.getitemnumber(dw_1.getrow(),"fact_monto_fact_total")
ld_cargos	 = dw_1.getitemnumber(dw_1.getrow(),"fact_gastos_total")
ls_movimiento = dw_1.getitemstring(dw_1.getrow(),"fact_tipo_movimiento")

ldt_fecha = datetime(date(ldt_fecha),lt_time)

//Para que aparezca en el kardex
if ls_terminos = 'CO' then ls_nombre_tercero = 'CONTADO - '+ls_nombre_tercero

// Extraigo el tipo de concepto de la factura
// Optimizar
ls_concepto = is_tipo

//si la secuencia devuelve 0, porque tiene letras la factura, que busque la secuencia de la transaccion
//de salidas de inventario

if ll_secuencia <= 0 then
	
  SELECT dgmserie.mser_secuencia
    INTO :ll_secuencia
    FROM dgmserie  
   WHERE ( dgmserie.mser_g_financiero = :str.g_financiero ) AND  
         ( dgmserie.mser_empresa = :str.empresa ) AND  
         ( dgmserie.mser_tipo_transaccion = 'FA' );
			
			if sqlca.sqlcode = -1 then
				mensaje("Aviso", "Error al Seleccionar la Secuencia",sqlca.sqlerrtext)
			end if
			
			ll_secuencia ++						
			
	  UPDATE dgmserie  
     SET mser_secuencia = :ll_secuencia  
		WHERE ( dgmserie.mser_g_financiero = :str.g_financiero ) AND  
				( dgmserie.mser_empresa = :str.empresa ) AND  
				( dgmserie.mser_tipo_transaccion = 'FA' );
				
			if sqlca.sqlcode = -1 then
				mensaje("Aviso", "Error al Actualizar la Secuencia",sqlca.sqlerrtext)
			end if			
	
end if

il_secuencia = ll_secuencia	//il_secuencia es utilizada para el detalle de los registros
//Inserto en intmovim

//  INSERT INTO intmovim  
//         ( tmov_g_financiero,   
//           tmov_empresa,   
//           tmov_aplicacion,   
//           tmov_tipo_transaccion,   
//           tmov_secuencia,   
//           tmov_concepto,   
//           tmov_anual,   
//           tmov_descripcion,   
//           tmov_fecha,   
//           tmov_autoriza,   
//           tmov_documento,   
//           tmov_fecha_registro,   
//           tmov_terceros,   
//           tmov_comentario,   
//           tmov_tipo_costo,   
//           tmov_id,   
//           tmov_tipo,   
//           tmov_estado,   
//           tmov_anulado,   
//           tmov_total_cargos,   
//           tmov_fecha_actualizacion,   
//           tmov_documento_entrada,   
//           tmov_estado_costo,   
//           tmov_forma_costeo,   
//           tmov_tipo_trafico,   
//           tmov_documento_comercial,   
//           tmov_fecha_cierre_mensual,   
//           tmov_cuenta,   
//           tmov_nombre_tercero,   
//           tmov_pase,   
//           tmov_moneda,   
//           tmov_cambio,   
//           tmov_constante,   
//           tmov_descuento,   
//           tmov_tipo_gasto,   
//           tmov_por_admin,   
//           tmov_no_pedido,   
//           tmov_precio_base,   
//           tmov_pasada_a_empresa,   
//           tmov_rebaja_reserva,   
//           tmov_marca,   
//           tmov_descuento_subdeta,   
//           tmov_itbm,   
//           tmov_itbm_subdeta,   
//           tmov_secuencia_actual,   
//           tmov_centro_costo,   
//           tmov_codigo_uso,   
//           tmov_descuento_ncr,   
//           tmov_tipo_movimiento,   
//           tmov_activada_por,   
//           tmov_fecha_activacion )  
//  VALUES ( :str.g_financiero,   
//           :str.empresa,   
//           'FA',   
//		  :ls_tran,   		//Tipo de Transaccion
//           :ll_secuencia,   
//           :ls_concepto,   
//           :ii_ann,   
//           :ls_comen,
//           :ldt_fecha,   
//           :str.usuario,   		//autorizacion, si necesitó autorización, validar esto
//           :ls_documento,
//		  getdate(),
//           :ll_cliente,   
//           :ls_comen,   
//           0,   
//           :str.usuario,
//		  :ls_tipo,				//Tipo Credito
//           1,   
//           0,   
//   		  :ld_cargos,
//           getdate(),   
//           null,   
//           null,   
//           null,   
//           null,   
//           null,   
//           null,   
//           null,   
//           :ls_nombre_tercero,   
//           null,   
//           1,   
//           1,   
//           1,   
//           null,   
//           null,   
//           null,   
//           :ls_pedido,   
//           0,   
//           0,   
//           :li_rebaja_reserva,   
//           null,   
//           null,   
//           null,   
//           null,   
//           null,   
//           null,   
//           null,   
//           null,   			  
//           :ls_movimiento,   
//           null,   
//           null )  ;
//
  INSERT INTO intmovim  
         ( tmov_g_financiero,   
           tmov_empresa,   
           tmov_aplicacion,   
           tmov_tipo_transaccion,
           tmov_secuencia,   
           tmov_concepto,   
           tmov_fecha,   
           tmov_autoriza,
           tmov_documento,   
           tmov_terceros,   
           tmov_comentario,
           tmov_id,   
		  tmov_tipo,
           tmov_anual,
           tmov_total_cargos,
		  tmov_nombre_tercero,
		  tmov_no_pedido,
		  tmov_rebaja_reserva,
		  tmov_tipo_movimiento,
		  tmov_descripcion,
		  tmov_fecha_registro)  
  VALUES ( :str.g_financiero,   
           :str.empresa,
           "FA",   
           :ls_tran,   		//Tipo de Transaccion
           :ll_secuencia,   
           :ls_concepto,   
           :ldt_fecha,   
           :str.usuario,   		//autorizacion, si necesitó autorización, validar esto
           :ls_documento,
           :ll_cliente,   
           :ls_comen,   
           :str.usuario,
		  :ls_tipo,				//Tipo Credito
           :ii_ann,
		  :ld_cargos,
		  :ls_nombre_tercero,
		  :ls_pedido,
		  :li_rebaja_reserva,
		  :ls_movimiento,
		  :ls_descrip,
		  getdate());
		if sqlca.sqlcode = -1 then
			messagebox("ATENCIÓN SR. USUARIO","Error encab inventario : "+sqlca.sqlerrtext)
			return false
		end if		

return true
end function

public function boolean wf_act_detalle ();//Ciclo For que recorre el DWindow 2 para actualizar en el Detalle de actualizaciones
//str.frame.setmicrohelp("Actualizando el Detalle en Inventario...")
integer li_recorrido, li_grupo, li_empresa, li_linea,  li_ok,&
		  li_anual, li_fraccion, li_bultos, li_nc, li_formato_decimal_costo = 2
string  ls_aplicacion, ls_tran, ls_documento, ls_producto, ls_unidad_med, ls_movid,&
		  ls_fabricante, ls_secuencia, ls_codigo, ls_bodega, ls_ubicacion, ls_bodega_des, &
		  ls_ubica_des, ls_concepto,ls_def, ls_modelo
double  ld_peso,  ld_cubicaje, ld_bulto, ld_cargos  
decimal{8} ld_precio, ld_precio_ent, ld_costos, ld_fob, ld_precio_original
long	  ll_cant1, li_secuencia
decimal{3} ld_cantidad, ld_existencia
decimal{2} ld_monto_final, ld_costo_cif

for li_recorrido = 1 to dw_2.rowcount()

ls_codigo = dw_2.getitemstring(li_recorrido,"facd_codigo_item")

 if trim(ls_codigo) <> "" then
	// Asignacion de los datos del DWin. a las variables de memoria
	li_grupo      = str.g_financiero
	li_empresa    = str.empresa
	ls_aplicacion = "FA"
	li_nc    =			 dw_1.getitemnumber(1,'fact_nota_credito')
	if li_nc = 1 then
		ls_tran    = 'DV'
	else
		ls_tran    = 'SA'
	end if
	ls_secuencia  = dw_1.getitemstring(dw_1.getrow(),"fact_no_factura")
	li_secuencia  = il_secuencia //Se carga al actualizar el encabezado
	ls_documento  = dw_1.getitemstring(dw_1.getrow(),"fact_no_factura")
	li_linea		  = li_recorrido
	ls_bodega	  = dw_2.getitemString(li_recorrido,"facd_bodega")
	ls_ubicacion  = dw_2.getitemString(li_recorrido,"facd_ubicacion")
	ls_producto	  = dw_2.getitemstring(li_recorrido,"facd_codigo_item")
	ld_cantidad   = dw_2.getitemnumber(li_recorrido,"facd_cantidad")
	li_fraccion	  = dw_2.getitemnumber(li_recorrido,"facd_cantidad_fraccion")	//Sumar a Cantidad	
	ls_unidad_med = dw_2.getitemstring(li_recorrido,"facd_unidad_venta")
	ls_modelo	 = dw_2.getitemstring(li_recorrido,"facd_modelo")
	ld_precio	  = dw_2.getitemnumber(li_recorrido,"facd_precio_unidad_producto")
//	ld_precio_original = dw_2.getitemnumber(li_recorrido,"facd_precio_original")
	ld_monto_final = dw_2.getitemnumber(li_recorrido,"facd_monto_final")
	ld_cubicaje   =  truncate(round(dw_2.getitemnumber(li_recorrido,"facd_cubicaje"),4),4)
	ld_peso		  = truncate(round(dw_2.getitemnumber(li_recorrido,"facd_peso"),6),6)
	li_bultos		  = dw_2.getitemnumber(li_recorrido,"facd_bultos")
	if li_bultos > 9999 then
		li_bultos = 9999
	end if
	ld_costos	  = dw_2.getitemnumber(li_recorrido,"facd_costo_cif")
	ld_fob		  = dw_2.getitemnumber(li_recorrido,"facd_costo_fob")
	ls_movid		  = str.usuario
	ls_concepto	  = is_tipo

	  SELECT isnull(inmprodu.prod_existencia_total  ,0), isnull(prod_costo_cif,0)
		 INTO :ld_existencia  , :ld_costo_cif
		 FROM inmprodu  
		WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
				( inmprodu.prod_empresa = :str.empresa ) AND  
				( inmprodu.prod_producto = :ls_producto )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al buscar existencia '+sqlca.sqlerrtext,1,1,'E')
			return false
		end if
		
		if false then //ld_cantidad > ld_existencia then
			rollback;
			gf_mensaje('','No hay suficiente disponibilidad del producto '+ls_producto+'. Verifique el Kardex !!!',1,1,'E')
			return false
		end if
	
	//Adicion de los datos a la tabla de actualizaciones
	if ld_costos = 0 or isnull(ld_costos) then ld_costos = ld_costo_cif
	
		 update  faddiari set facd_costo_cif =   
					convert(numeric(12,2),ROUND((IsNull ( inmprodu.prod_costo_cif,0) / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad,2)) ,   
					facd_costo_fob =   
					convert(numeric(12,2),ROUND((IsNull (inmprodu.prod_costo_fob,0) / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad,2)) ,   			
					faddiari.facd_costo_total = 
					convert(numeric(12,2),convert(numeric(12,2),ROUND((IsNull(inmprodu.prod_costo_cif,0) / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad,2)) * (isNull(faddiari.facd_cantidad ,0)+ ( IsNull(faddiari.facd_cantidad_fraccion,0) /   inamedid_a.medi_cantidad )) )  
			 FROM faddiari,   
					fatdiari,   
					inamedid inamedid_a,   
					inamedid inamedid_b,   
					inmprodu  
			WHERE ( faddiari.facd_g_financiero = fatdiari.fact_g_financiero ) and  
					( faddiari.facd_empresa = fatdiari.fact_empresa ) and  
					( faddiari.facd_tipo = fatdiari.fact_tipo ) and  
					( faddiari.facd_no_pedido = fatdiari.fact_no_pedido ) and  
					( faddiari.facd_ann = fatdiari.fact_ann ) and  
					( faddiari.facd_unidad_venta = inamedid_a.medi_medida ) and  
					( inamedid_b.medi_medida = inmprodu.prod_medida ) and  
					( faddiari.facd_codigo_item = inmprodu.prod_producto ) and  
					( faddiari.facd_g_financiero = inmprodu.prod_g_financiero ) and  
					( faddiari.facd_empresa = inmprodu.prod_empresa ) and  
					( ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
					( faddiari.facd_empresa = :str.empresa ) AND  
					( fatdiari.fact_no_pedido = :is_secuencia  and 
					( fatdiari.fact_ann = :ii_ann ) ) ) ;									
			if sqlca.sqlcode = -1 then
				messagebox("ATENCIÓN SR. USUARIO","Error Actualizacion de Costos : "+sqlca.sqlerrtext)
				return false
			end if

		 update fatdiari set fact_costos_total =
		 (select sum(faddiari.facd_costo_total)
			from faddiari
			 where (faddiari.facd_g_financiero = fatdiari.fact_g_financiero) and
					 (faddiari.facd_empresa = fatdiari.fact_empresa) and
					 (faddiari.facd_tipo = fatdiari.fact_tipo) and
					 (faddiari.facd_no_pedido = fatdiari.fact_no_pedido) and
					 (faddiari.facd_ann = fatdiari.fact_ann ) )
			where (fatdiari.fact_g_financiero = :str.g_financiero ) and
					(fatdiari.fact_empresa = :str.empresa) and
					(fatdiari.fact_no_pedido = :is_secuencia ) and
					(fatdiari.fact_ann = :ii_ann ) ;
			if sqlca.sqlcode = -1 then
				messagebox("ATENCIÓN SR. USUARIO","Error Actualizacion de Costos : "+sqlca.sqlerrtext)
				return false
			end if
			
	INSERT INTO indmovim  
         ( dmov_g_financiero,   
           dmov_empresa,   
           dmov_aplicacion,   
           dmov_tipo_transaccion,   
           dmov_secuencia,   
           dmov_documento,   
           dmov_linea,   
		  dmov_linea_referencia,
           dmov_bodega,   
           dmov_ubicacion,   
           dmov_producto,   
           dmov_cantidad,   
           dmov_cant1,   
           dmov_unidad_medida,   
           dmov_precio,   
           dmov_cubicaje,   
           dmov_peso,   
           dmov_bulto,   
           dmov_id,   
           dmov_anual,
		  dmov_concepto,
		  dmov_costo,
		  dmov_costo_fob,
		  dmov_costo_cif,
		  dmov_costo_promedio,
		  dmov_modelo,
		  dmov_monto_final)			  
VALUES ( :li_grupo,   
           :li_empresa,   
           "FA",   
           :ls_tran,   
           :li_secuencia,   
           :ls_documento,   
           :li_linea,   
           :li_linea,   			  
           :ls_bodega,   
           :ls_ubicacion,   
           :ls_producto,   
           :ld_cantidad,   
           :li_fraccion,   
           :ls_unidad_med,   
           :ld_precio,   
           :ld_cubicaje,   
           :ld_peso,   
           :li_bultos,   
           :ls_movid,   
		  :ii_ann,
		  :ls_concepto,
		  :ld_costos,
		  :ld_fob,
		  :ld_costos,
		  :ld_costos,
		  :ls_modelo,
		  :ld_monto_final); 

		if sqlca.sqlcode = -1 then
			messagebox("ATENCIÓN SR. USUARIO","Error detalle indmovim : "+sqlca.sqlerrtext)
			return false
		end if
	
  end if
 next	

if sqlca.sqlcode = -1 then
	messagebox("ATENCIÓN SR. USUARIO","Error: "+sqlca.sqlerrtext)
	return false	
end if

  UPDATE intmovim  
     SET tmov_rebaja_reserva = 0  
   WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
         ( intmovim.tmov_empresa = :str.empresa ) AND  
         ( intmovim.tmov_aplicacion = :ls_aplicacion ) AND  
         ( intmovim.tmov_tipo_transaccion = :ls_tran ) AND  
         ( intmovim.tmov_secuencia = :li_secuencia ) AND  
         ( intmovim.tmov_concepto = :ls_concepto ) AND  
         ( intmovim.tmov_anual = :ii_ann ) ;
	
	if sqlca.sqlcode = -1 then
		messagebox("ATENCIÓN SR. USUARIO","Error en Rebaja Reserva: "+sqlca.sqlerrtext)
		return false	
	end if

str.frame.setmicrohelp("")
return true
end function

public function boolean wf_anula_movimiento ();//Setea a anulado el movimiento tanto en inventario como en clientes
string ls_factura, ls_comentario, ls_monto, ls_error, ls_transac
long li_factura

ls_factura	=	dw_1.getitemstring(dw_1.getrow(),"fact_no_factura")
ls_monto	   =	string(dw_1.getitemNumber(dw_1.getrow(),"fact_monto_final"))
li_factura	=  long(ls_factura)  
//Poner un parametro, para manejar las facturas contados
if dw_1.Getitemstring(dw_1.Getrow(),"fact_condicion_pago") = "CO" then
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
  
  SELECT faprefactura.fact_cliente,   
         faprefactura.fact_ruc_cliente,   
         faprefactura.fact_condicion_pago,   
         faprefactura.fact_tipo_venta,   
         faprefactura.fact_tipo_movimiento,   
         faprefactura.fact_dias_pago,   
         faprefactura.fact_consignado,   
         faprefactura.fact_a_nombre,   
         faprefactura.fact_a_nombre_direccion,   
         faprefactura.fact_despachado,   
         faprefactura.fact_gastos_total,   
         faprefactura.fact_monto_fact_total,   
         faprefactura.fact_monto_final,   
         faprefactura.fact_comentario,   
         faprefactura.fact_fecha_despacho,   
         faprefactura.fact_pasaporte,   
         faprefactura.fact_linea_aerea,   
         faprefactura.fact_vendedor  ,
		faprefactura	.fact_recargo_especial
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
   WHERE ( faprefactura.fact_g_financiero = :str.g_financiero ) AND  
         ( faprefactura.fact_empresa = :str.empresa ) AND  
         ( faprefactura.fact_no_pedido = :as_pre_factura ) AND  
         ( faprefactura.fact_ann = :ai_ann_pre_factura )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Seleccionar el Encabezado '+sqlca.sqlerrtext,1,1,'E')
			return false
		end if
		
		// Crea un nuevo registro
		dw_1.reset()
		dw_2.object.cargos.expression = "'"+string(0.00,'#,##0.00')+"'"	//Para blanquear los cargos
		dw_2.object.descuento.expression = "'"+string(0.00,'#,##0.00')+"'"	//Para blanquear los cargos
		dw_2.reset()
		dw_7.reset()
		dw_7.insertrow(1)
//		dw_8.reset()
//		dw_8.insertrow(1)
		dw_7.bringtotop = true
//		dw_8.bringtotop = true	
		dw_1.insertrow(1)
		//Pone invisible el insertar	
		dw_1.setitem(1,'fact_g_financiero',str.g_financiero)
		dw_1.setitem(1,'fact_empresa',str.empresa)
		dw_1.setitem(1,'fact_ann',ii_ann)
		dw_1.setitem(1,'fact_fecha',date(gf_fecha_serv()))
		dw_1.setitem(1,'fact_fecha_despacho',ldt_fecha_despacho)	
		dw_1.setitem(1,'fact_tipo_venta',li_tipo) //exterior
		dw_1.setitem(1,'fact_estado','A')
		dw_1.setitem(1,'fact_usuario',str.usuario)	
		dw_1.setitem(1,'fact_metal_pendiente',ii_metal_pendiente)	
		if ii_metal_pendiente = 1 then
			dw_1.setitem(1,'fact_cierre_de_metal',0)	
			dw_1.setitem(1,'fact_excluir_de_reporte',1)	
		end if
		is_tipo = idwc_tipo.getitemstring(1,'dgmsubse_subs_sub_trans')
		dw_1.setitem(1,'fact_tipo', is_tipo)
		dw_1.setfocus()
		dw_1.setcolumn('fact_ruc_cliente')
		idec_gastos = 0
		wf_orden_nueva()
		
		dw_1.setitem(1,'fact_no_pedido',is_secuencia)
		dw_1.setitem(1,'fact_ann',ii_ann)	
		dw_1.setitem(1,'fact_pre_factura',as_pre_factura)
		dw_1.setitem(1,'fact_ann_pre_factura',ai_ann_pre_factura)
		dw_1.setitem(1,'fact_cliente',ll_cliente)
		dw_1.setitem(1,'fact_ruc_cliente',ls_cuenta)
		dw_1.setitem(1,'fact_condicion_pago',ls_condicion)
		dw_1.setitem(1,'fact_tipo_movimiento',ls_movimiento)
		dw_1.setitem(1,'fact_dias_pago',li_dias)
		dw_1.setitem(1,'fact_consignado',ls_consignado)
		dw_1.setitem(1,'fact_a_nombre',ls_a_nombre)
		dw_1.setitem(1,'fact_a_nombre_direccion',ls_direccion)
		dw_1.setitem(1,'fact_despachado',ls_despachado)
		dw_1.setitem(1,'fact_gastos_total',ld_gastos)
		dw_1.setitem(1,'fact_monto_fact_total',ld_monto)
		dw_1.setitem(1,'fact_monto_final',ld_monto_final)
		dw_1.setitem(1,'fact_comentario',ls_comentario)
		dw_1.setitem(1,'fact_pasaporte',ls_pasaporte)
		dw_1.setitem(1,'fact_linea_aerea',ls_linea_aerea)
		dw_1.setitem(1,'vendedor',li_vendedor)
		dw_1.setitem(1,'fact_recargo_especial',ld_rec_especial)
		
		 DECLARE cur_detalle CURSOR FOR  
		  SELECT faprefacturad.facd_linea,   
					faprefacturad.facd_codigo_item,   
					faprefacturad.facd_descripcion_alterna,   
					faprefacturad.facd_unidad_producto,   
			   		faprefacturad.facd_bodega,   
					faprefacturad.facd_costo_fob,   
					faprefacturad.facd_costo_cif,   
					faprefacturad.facd_precio_unidad_producto,   
					faprefacturad.facd_unidad_venta,   
					faprefacturad.facd_cantidad,   
					faprefacturad.facd_cantidad_fraccion,   
					faprefacturad.facd_monto_total,   
					faprefacturad.facd_monto_final,   
					faprefacturad.facd_bultos,   
					faprefacturad.facd_ubicacion,   
					faprefacturad.facd_index,   
					faprefacturad.facd_precio_original,   
					faprefacturad.facd_costo_total,
					faprefacturad.facd_precio_recargo
			 FROM faprefacturad  
			WHERE ( faprefacturad.facd_g_financiero = :str.g_financiero ) AND  
					( faprefacturad.facd_empresa = :str.empresa ) AND  
					( faprefacturad.facd_no_pedido = :as_pre_factura ) AND  
					( faprefacturad.facd_ann = :ai_ann_pre_factura )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Declarar el Cursor '+sqlca.sqlerrtext,1,1,'E')
						return false
					end if
				
		open cur_detalle ;
		
		fetch cur_detalle into :li_linea, :ls_producto, :ls_descripcion, :ls_unidad, :ls_bodega, :ld_costo_fob, :ld_costo_cif, :ld_precio_unidad_producto, &
									:ls_unidad_venta, :ld_cantidad, :li_fraccion, :ld_monto, :ld_monto_final, :li_bultos, :ls_ubicacion, :li_index, :ld_precio_original, :ld_costo_total, :ld_precio_recargo;
		do while sqlca.sqlcode = 0
				
			dw_2.scrolltorow(dw_2.insertrow(0))
			dw_2.setitem(dw_2.getrow(),'facd_g_financiero',str.g_financiero)
			dw_2.setitem(dw_2.getrow(),'facd_empresa',str.empresa)
			dw_2.setitem(dw_2.getrow(),'facd_usuario',str.usuario)
			dw_2.setitem(dw_2.getrow(),'facd_codigo_item',ls_producto)
			dw_2.setitem(dw_2.getrow(),'facd_descripcion_alterna',ls_descripcion)
			dw_2.setitem(dw_2.getrow(),'facd_unidad_venta',ls_unidad)			
			dw_2.setitem(dw_2.getrow(),'facd_unidad_producto',ls_unidad)		
			dw_2.setitem(dw_2.getrow(),'facd_costo_cif', ld_costo_cif)			
			dw_2.setitem(dw_2.getrow(),'facd_costo_cif', ld_costo_fob)
			dw_2.setitem(dw_2.getrow(),'facd_unidad_venta', ls_unidad_venta)
			dw_2.setitem(dw_2.getrow(),'facd_costo_cif', ld_costo_cif)
			dw_2.setitem(dw_2.getrow(),'facd_metal_pendiente',ii_metal_pendiente)				
			dw_2.setitem(dw_2.getrow(),'facd_linea', li_linea)
			dw_2.setitem(dw_2.getrow(),'facd_index', li_index)	
			dw_2.setitem(dw_2.getrow(),'facd_bodega', ls_bodega)
			dw_2.setitem(dw_2.getrow(),'facd_ubicacion', ls_ubicacion)			
			dw_2.setitem(dw_2.getrow(),'facd_costo_total', ld_costo_total)
			dw_2.setitem(dw_2.getrow(),'facd_bultos', li_bultos)			
			dw_2.setitem(dw_2.getrow(),'facd_cantidad_fraccion', li_fraccion)
			dw_2.setitem(dw_2.getrow(),'facd_cantidad', ld_cantidad)
			
			if ii_metal_pendiente = 1 then
				dw_2.setitem(dw_2.getrow(),'facd_precio_original', 0)			
				dw_2.setitem(dw_2.getrow(),'facd_precio_recargo', ld_precio_recargo)			
				dw_2.setitem(dw_2.getrow(),'facd_precio_unidad_producto', ld_precio_recargo)			
				dw_2.setitem(dw_2.getrow(),'facd_monto_total', ld_precio_recargo * ld_cantidad)
				dw_2.setitem(dw_2.getrow(),'facd_monto_final', ld_precio_recargo * ld_cantidad)							
				if ld_precio_recargo * ld_cantidad = 0 then
					dw_2.deleterow(dw_2.getrow())
				end if
			else
				dw_2.setitem(dw_2.getrow(),'facd_precio_original', ld_precio_original)			
				dw_2.setitem(dw_2.getrow(),'facd_precio_recargo', ld_precio_recargo)			
				dw_2.setitem(dw_2.getrow(),'facd_precio_unidad_producto', ld_precio_unidad_producto)
				dw_2.setitem(dw_2.getrow(),'facd_monto_total', ld_monto)
				dw_2.setitem(dw_2.getrow(),'facd_monto_final', ld_monto_final)							
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

public function boolean wf_actualiza_prefactura (string as_estado);string ls_prefactura
integer li_ann_prefactura

ls_prefactura = dw_1.getitemstring(1,'fact_pre_factura')
li_ann_prefactura = dw_1.getitemnumber(1,'fact_ann_pre_factura')

if ls_prefactura = '' or isnull(ls_prefactura) then return true

  UPDATE faprefactura  
     SET fact_estado = :as_estado  
   WHERE ( faprefactura.fact_g_financiero = :str.g_financiero ) AND  
         ( faprefactura.fact_empresa = :str.empresa ) AND  
         ( faprefactura.fact_no_pedido = :ls_prefactura ) AND  
         ( faprefactura.fact_ann = :li_ann_prefactura )   ;

		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Actualizar Pre-Factura '+sqlca.sqlerrtext,1,1,'E')
			return false
		end if

return true
end function

public subroutine openport (integer port);//Handler = OpenComFiscal(Port, MODE_ANSI)
//if Handler < 0 then
//	gf_mensaje('','No Pudo Abrir el Puerto '+ string(Port),1,1,'E')
//end if
end subroutine

public subroutine enviarstringfiscal (string comando);//Integer PrinterStatus, FiscalStatus
//
//if MandaPaqueteFiscal(Handler,Comando) < 0 then
//	gf_mensaje('','Error Mandando Paquete',1,1,'E')
//else
//	if UltimoStatus(Handler, FiscalStatus, PrinterStatus) = 0 then
//		gf_mensaje('Status','Printer Status: '+string(PrinterStatus) + '   Fiscal Status: '+string(FiscalStatus),1,1,'E')
//	end if
//end if
end subroutine

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
				inmprodu.prod_metros_cubicos
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
				:id_cubicaje_m3				
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
							max(inmprodu.prod_metros_cubicos)
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
							:id_cubicaje_m3
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
//					dw_2.setitem(dw_2.getrow(),'dpro_codigo_item',as_codigo)

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
				inmprodu.prod_metros_cubicos
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
				:id_cubicaje_m3
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
		dw_2.setitem(dw_2.getrow(),'facd_codigo_item',as_codigo)
	
end if

return true

end function

public function boolean wf_asigna_factura_nc (string as_factura, integer ai_ann, string as_pedido);string ls_modelo, ls_unidad_peso, ls_unidad_producto,  ls_cuenta, ls_condicion, ls_traspaso, ls_marca, ls_tipo, ls_movimiento, ls_consignado, ls_a_nombre, ls_direccion, ls_despachado, &
		ls_comentario, ls_pasaporte, ls_nave, ls_viaje, ls_guia, ls_producto, ls_descripcion, ls_unidad, ls_bodega, ls_ubicacion, ls_unidad_venta, ls_item, &
		ls_origen, ls_destino, ls_transporte, ls_tamano_contenedor, ls_contenedor, ls_peso
datetime ldt_fecha_despacho, ldt_fecha
decimal{2} ld_limite, ld_gastos, ld_precio_mayor, ld_precio_menor, ld_monto, ld_monto_final , ld_monto_cargo, ld_costo_fob, ld_costo_cif, ld_cantidad, ld_precio_original, ld_costo_total, ld_precio, ld_descuento	, ld_saldo	
decimal{3} ld_cubicaje, ld_peso, ld_peso_neto, ld_cubicaje_metros
integer li_dias, li_vendedor, li_tipo, li_linea, li_index, li_fraccion, li_bultos, i, li_codigo
long ll_cliente, ll_fila, ll_bultos, ll_bulto_ini, ll_bulto_fin, ll_bulto_original
  
   SELECT fatdiari.fact_cliente,   
         fatdiari.fact_ruc_cliente,  
         fatdiari.fact_condicion_pago,			
         fatdiari.fact_tipo_movimiento,   
         fatdiari.fact_dias_pago,   			
		fatdiari.fact_tipo_venta,
         fatdiari.fact_consignado,   
		fatdiari.fact_a_nombre,   
         fatdiari.fact_a_nombre_direccion,   
         fatdiari.fact_despachado,   
         fatdiari.fact_gastos_total,   
         fatdiari.fact_monto_fact_total,   
         fatdiari.fact_monto_final,   
		fatdiari.fact_comentario,   
         fatdiari.fact_no_traspaso,   
         fatdiari.fact_marca,   
         fatdiari.fact_por_descuento		
    INTO :ll_cliente,   
         :ls_cuenta,   
         :ls_condicion,   
         :ls_movimiento,   
         :li_dias,   
		:li_tipo,
         :ls_consignado,   
         :ls_a_nombre,   
         :ls_direccion,   
         :ls_despachado,   
         :ld_gastos,   
         :ld_monto,   
         :ld_monto_final,   
         :ls_comentario,   
		:ls_traspaso,	
  		:ls_marca,
    		:ld_descuento
    FROM fatdiari  
   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
         ( fatdiari.fact_empresa = :str.empresa ) AND  
         ( fatdiari.fact_no_pedido = :as_pedido ) AND  
         ( fatdiari.fact_ann = :ai_ann )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Seleccionar el Encabezado '+sqlca.sqlerrtext,1,1,'E')
			return false
		end if
		
		// Crea un nuevo registro
		dw_1.reset()
		dw_2.object.cargos.expression = "'"+string(0.00,'#,##0.00')+"'"	//Para blanquear los cargos
		dw_2.object.descuento.expression = "'"+string(0.00,'#,##0.00')+"'"	//Para blanquear descuento
		dw_2.reset()
		dw_1.insertrow(1)
		//Pone invisible el insertar	
		dw_1.setitem(1,'fact_g_financiero',str.g_financiero)
		dw_1.setitem(1,'fact_empresa',str.empresa)
		dw_1.setitem(1,'fact_ann',ii_ann)
		dw_1.setitem(1,'fact_fecha',date(gf_fecha_serv()))
		dw_1.setitem(1,'fact_fecha_fin_plazo',date(gf_fecha_serv()))
		dw_1.setitem(1,'fact_tipo_venta',li_tipo) //exterior
		dw_1.setitem(1,'fact_estado','A')
		dw_1.setitem(1,'fact_usuario',str.usuario)	
		is_tipo = idwc_tipo.getitemstring(1,'dgmsubse_subs_sub_trans')
		dw_1.setitem(1,'fact_tipo', is_tipo)
		dw_1.setitem(1,'fact_cliente', ll_cliente)
		dw_1.setitem(1,'fact_a_nombre', ls_a_nombre)
		dw_1.setitem(1,'fact_ruc_cliente', ls_cuenta)		
		dw_1.setitem(1,'fact_a_nombre_direccion', ls_direccion)				
		dw_1.setitem(1,'fact_condicion_pago',ls_condicion)	
		dw_1.setitem(1,'fact_tipo_movimiento',ls_movimiento)	
		dw_1.setitem(1,'fact_dias_pago',li_dias)	
		dw_1.setitem(1,'fact_consignado',ls_consignado)	
		dw_1.setitem(1,'fact_despachado',ls_despachado)	
		dw_1.setitem(1,'fact_marca',ls_marca)	
		dw_1.setitem(1,'fact_por_descuento',ld_descuento)	
		dw_1.setitem(1,'fact_gastos_total',ld_gastos)	
		dw_1.setitem(1,'fact_monto_fact_total',ld_monto)			
		dw_1.setitem(1,'fact_monto_final',ld_monto_final)	
		dw_1.setitem(1,'fact_comentario','NOTA DE CREDITO S/F:'+as_factura)	
		dw_1.setitem(1,'fact_act_conta',0)	
		dw_1.setitem(1,'fact_act_cliente',0)	
		dw_1.setitem(1,'fact_act_inventario',0)					
		ld_saldo = gf_saldo_anterior_new( ll_cliente, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)		
		if isnull(ld_saldo) then ld_saldo = 0.00
		dw_1.setitem(1,'saldo',ld_saldo)
		ll_fila = idwc_cliente.find('terc_tercero = '+string(ll_cliente),1,idwc_cliente.rowcount())
		if ll_fila > 0 then
			idwc_cliente.scrolltorow(ll_fila)
		end if
		ld_limite = idwc_cliente.getitemnumber(idwc_cliente.getrow(), 'clie_limite_credito')						
		dw_1.setitem(1,'limite',ld_limite)		
	

		dw_1.setfocus()
		dw_1.setcolumn('fact_ruc_cliente')
		idec_gastos = 0
		wf_orden_nueva()
		
		dw_1.setitem(1,'fact_no_pedido',is_secuencia)
		dw_1.setitem(1,'fact_ann',ii_ann)	
		dw_1.setitem(1,'fact_nota_credito',1)	
		dw_1.setitem(1,'fact_factura_referencia',as_factura)
		dw_1.setitem(1,'fact_ann_fact_referencia',ai_ann)
		dw_1.setitem(1,'fact_tipo_documento','06')	
	
		//vendedor
		  SELECT isnull(fadvenfa.vfac_vendedor  ,0)
			 INTO :li_vendedor  
			 FROM fadvenfa  
			WHERE ( fadvenfa.vfac_g_financiero = :str.g_financiero ) AND  
					( fadvenfa.vfac_empresa = :str.empresa ) AND  
					( fadvenfa.vfac_no_pedido = :as_pedido ) AND  
					( fadvenfa.vfac_ann = :ii_ann )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Buscar Vendedor '+sqlca.sqlerrtext,1,1,'E')
						return false
					end if
		dw_1.setitem(1,'vendedor',li_vendedor)

		if dw_13.retrieve(ll_cliente) = 0 then dw_13.insertrow(1)		
		if dw_14.retrieve(ll_cliente) = 0 then dw_14.insertrow(1)		
		
		idec_descuento = ld_descuento
		dw_2.object.descuento.expression = "'"+string(idec_descuento,'##0.00')+"'"			
		
		//Pasa el Detalle de la Prefactura
 DECLARE cur_detalle CURSOR FOR  
  SELECT faddiari.facd_linea,   
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
         faddiari.facd_bultos,   
         faddiari.facd_ubicacion,   
         faddiari.facd_index,   
         faddiari.facd_bulto_inicio,   
         faddiari.facd_bulto_fin,   
         faddiari.facd_precio_original,   
         faddiari.facd_costo_total,   
         faddiari.facd_modelo,   
         faddiari.facd_bultos_original,   
         faddiari.facd_peso_neto,   
         faddiari.facd_cubicaje_metros  
    FROM faddiari 
			WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
					( faddiari.facd_empresa = :str.empresa ) AND  
					( faddiari.facd_no_pedido = :as_pedido ) AND  
					( faddiari.facd_ann = :ai_ann )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Declarar el Cursor '+sqlca.sqlerrtext,1,1,'E')
						return false
					end if
				
		open cur_detalle ;
		
		fetch cur_detalle into :li_linea, :ls_producto, :ls_descripcion, :ld_cubicaje, :ld_peso, :ls_unidad_peso, :ls_unidad_producto, :ld_precio_mayor, :ld_precio_menor, :ls_bodega, :ld_costo_fob, :ld_costo_cif, &
									:ld_precio, :ls_unidad, :ld_cantidad, :li_fraccion, :ld_monto, :ld_descuento, :ld_monto_final, :ll_bultos, :ls_ubicacion, :li_index, :ll_bulto_ini, :ll_bulto_fin, :ld_precio_original, &
									:ld_costo_total, :ls_modelo, :ll_bulto_original, :ld_peso_neto, :ld_cubicaje_metros;
		do while sqlca.sqlcode = 0
				
			dw_2.scrolltorow(dw_2.insertrow(0))
			dw_2.setitem(dw_2.getrow(),'facd_g_financiero',str.g_financiero)
			dw_2.setitem(dw_2.getrow(),'facd_empresa',str.empresa)
			dw_2.setitem(dw_2.getrow(),'facd_codigo_item',ls_producto)
			dw_2.setitem(dw_2.getrow(),'facd_descripcion_alterna',ls_descripcion)
			dw_2.setitem(dw_2.getrow(),'facd_linea', li_linea)
			dw_2.setitem(dw_2.getrow(),'facd_cantidad', ld_cantidad)			
			dw_2.setitem(dw_2.getrow(),'facd_cantidad_fraccion', li_fraccion)						
			dw_2.setitem(dw_2.getrow(),'facd_precio_unidad_producto', ld_precio)
			dw_2.setitem(dw_2.getrow(),'facd_precio_original', ld_precio_original)
			dw_2.setitem(dw_2.getrow(),'facd_monto_total', ld_monto)					
			dw_2.setitem(dw_2.getrow(),'facd_monto_final', ld_monto_final)					
			dw_2.setitem(dw_2.getrow(),'facd_costo_total', ld_costo_total)								
			dw_2.setitem(dw_2.getrow(),'facd_modelo', ls_modelo)			
			dw_2.setitem(dw_2.getrow(),'facd_bodega', ls_bodega)			
			dw_2.setitem(dw_2.getrow(),'facd_ubicacion', ls_ubicacion)			
			dw_2.setitem(dw_2.getrow(),'facd_unidad_producto', ls_unidad_producto)			
			dw_2.setitem(dw_2.getrow(),'facd_unidad_venta', ls_unidad)			
			dw_2.setitem(dw_2.getrow(),'facd_bultos', ll_bultos)									
			dw_2.setitem(dw_2.getrow(),'facd_bulto_inicio', ll_bulto_ini)									
			dw_2.setitem(dw_2.getrow(),'facd_bulto_fin', ll_bulto_fin)												
			dw_2.setitem(dw_2.getrow(),'facd_bultos_original', ll_bulto_original)
			dw_2.setitem(dw_2.getrow(),'facd_peso', ld_peso)
			dw_2.setitem(dw_2.getrow(),'facd_cubicaje', ld_cubicaje)
			dw_2.setitem(dw_2.getrow(),'facd_peso_neto', ld_peso_neto)
			dw_2.setitem(dw_2.getrow(),'facd_cubicaje_metros', ld_cubicaje_metros)
			
			ls_item = ls_producto
			
		fetch cur_detalle into :li_linea, :ls_producto, :ls_descripcion, :ld_cubicaje, :ld_peso, :ls_unidad_peso, :ls_unidad_producto, :ld_precio_mayor, :ld_precio_menor, :ls_bodega, :ld_costo_fob, :ld_costo_cif, &
									:ld_precio, :ls_unidad, :ld_cantidad, :li_fraccion, :ld_monto, :ld_descuento, :ld_monto_final, :ll_bultos, :ls_ubicacion, :li_index, :ll_bulto_ini, :ll_bulto_fin, :ld_precio_original, &
									:ld_costo_total, :ls_modelo, :ll_bulto_original, :ld_peso_neto, :ld_cubicaje_metros;
		
		loop
		
		close cur_detalle;

	dw_2.object.cargos.expression = "'"+string(idec_gastos,'#,##0.00')+"'"

	this.triggerevent('ue_aceptar')

	//Pasa los Cargos de la Factura
		 DECLARE cur_cargos CURSOR FOR  
		  SELECT fadcargo.dcar_codigo,   
					fadcargo.dcar_monto  
			 FROM fadcargo  
			WHERE ( fadcargo.dcar_g_financiero = :str.g_financiero ) AND  
					( fadcargo.dcar_empresa = :str.empresa ) AND  
					( fadcargo.dcar_no_pedido = :as_pedido ) AND  
					( fadcargo.dcar_ann = :ai_ann ) AND  
					( fadcargo.dcar_monto > 0 )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Declarar Cursor Cargos '+sqlca.sqlerrtext,1,1,'E')
						return false
					end if
			
			open cur_cargos;
			idec_gastos = 0
			fetch cur_cargos into :li_codigo, :ld_monto_cargo;
			
			do while sqlca.sqlcode = 0
				idec_gastos = idec_gastos + ld_monto_cargo
					  INSERT INTO fadcargo  
							( dcar_g_financiero,   
							  dcar_empresa,   
							  dcar_tipo,   
							  dcar_no_pedido,   
							  dcar_ann,   
							  dcar_codigo,   
							  dcar_monto )  
				  VALUES ( :str.g_financiero,   
							  :str.empresa,   
							  :is_tipo,   
							  :is_secuencia,   
							  :ii_ann,   
							  :li_codigo,   
							  :ld_monto_cargo )  ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Insertar Cargos '+sqlca.sqlerrtext,1,1,'E')
						return false
					end if
				
					fetch cur_cargos into :li_codigo, :ld_monto_cargo;
			loop
			
			close cur_cargos;
	
	dw_1.setitem(dw_1.getrow(),"fact_gastos_total",idec_gastos)
	dw_2.object.cargos.expression = "'"+string(idec_gastos,'#,##0.00')+"'"
	
//	this.triggerevent('ue_aceptar')
commit;

return true

end function

public subroutine wf_pasar_estructura (str_pase_pedido lstr_pedidos);istr_pedidos = lstr_pedidos
end subroutine

public function boolean wf_asigna_pedido (str_pase_pedido astr_pedidos);string ls_modelo, ls_cuenta, ls_condicion, ls_tipo, ls_movimiento, ls_consignado, ls_a_nombre, ls_direccion, ls_despachado, &
		ls_comentario, ls_pasaporte, ls_linea_aerea, ls_producto, ls_descripcion, ls_unidad, ls_bodega, ls_ubicacion, ls_unidad_venta, ls_item, ls_marca
datetime ldt_fecha_despacho, ldt_fecha
decimal{2} ld_bultos, ld_bultos_original, ld_saldo, ld_limite, ld_descuento, ld_gastos, ld_monto, ld_monto_final , ld_costo_fob, ld_costo_cif, ld_cantidad, ld_precio_original, ld_costo_total, ld_precio, ld_precio_recargo, ld_rec_especial		
integer i, li_dias, li_vendedor, li_tipo, li_linea, li_index, li_fraccion, li_bultos, li_tipo_medida, li_bulto_inicio, li_bulto_fin
long ll_cliente, ll_fila, ll_bultos
  
datawindow = 1

this.triggerevent('ue_adicionar')
  
  SELECT fatpedid.pedi_cliente,   
         fatpedid.pedi_ruc_cliente,   
         fatpedid.pedi_condicion_pago,   
         fatpedid.pedi_tipo_venta,   
         fatpedid.pedi_tipo_movimiento,   
         fatpedid.pedi_dias_pago,   
         fatpedid.pedi_consignado,   
         fatpedid.pedi_a_nombre,   
         fatpedid.pedi_a_nombre_direccion,   
         fatpedid.pedi_despachado,   
         fatpedid.pedi_gastos_total,   
         fatpedid.pedi_monto_total,   
         fatpedid.pedi_monto_final,   
         fatpedid.pedi_comentario,   
         fatpedid.pedi_pasaporte,   
         fatpedid.pedi_linea_aerea,
		fatpedid.pedi_por_descuento,
		fatpedid.pedi_marca
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
         :ls_pasaporte,   
         :ls_linea_aerea,
		:ld_descuento,
		:ls_marca
    FROM fatpedid 
   WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
         ( fatpedid.pedi_empresa = :str.empresa ) AND  
         ( fatpedid.pedi_no_pedido = :astr_pedidos.pedido ) AND  
         ( fatpedid.pedi_ann = :astr_pedidos.ann )   ;
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
		dw_7.bringtotop = true
		dw_1.insertrow(1)
		//Pone invisible el insertar	
		dw_1.setitem(1,'fact_g_financiero',str.g_financiero)
		dw_1.setitem(1,'fact_empresa',str.empresa)
		dw_1.setitem(1,'fact_ann',ii_ann)
		dw_1.setitem(1,'fact_fecha',date(gf_fecha_serv()))
//		dw_1.setitem(1,'fact_fecha_despacho',ldt_fecha_despacho)	
		dw_1.setitem(1,'fact_tipo_venta',li_tipo) //exterior
		dw_1.setitem(1,'fact_estado','A')
		dw_1.setitem(1,'fact_usuario',str.usuario)	
		is_tipo = idwc_tipo.getitemstring(1,'dgmsubse_subs_sub_trans')
		dw_1.setitem(1,'fact_tipo', is_tipo)
		dw_1.setfocus()
		dw_1.setcolumn('fact_ruc_cliente')
		idec_gastos = 0
		wf_orden_nueva()
		
		dw_1.setitem(1,'fact_no_pedido',is_secuencia)
		dw_1.setitem(1,'fact_ann',ii_ann)	
		dw_1.setitem(1,'fact_pre_factura',astr_pedidos.pedido)
		dw_1.setitem(1,'fact_ann_pre_factura',astr_pedidos.ann)
		dw_1.setitem(1,'fact_cliente',ll_cliente)
		dw_1.setitem(1,'fact_ruc_cliente',ls_cuenta)
		dw_1.setitem(1,'fact_condicion_pago',ls_condicion)
		dw_1.setitem(1,'fact_tipo_movimiento',ls_movimiento)
		dw_1.setitem(1,'fact_dias_pago',li_dias)
		dw_1.setitem(1,'fact_consignado',ls_consignado)
		dw_1.setitem(1,'fact_a_nombre',ls_a_nombre)
		dw_1.setitem(1,'fact_a_nombre_direccion',ls_direccion)
		dw_1.setitem(1,'fact_despachado',ls_despachado)
		ld_gastos = 0
		dw_1.setitem(1,'fact_gastos_total',ld_gastos)
		dw_1.setitem(1,'fact_monto_fact_total',ld_monto)
		dw_1.setitem(1,'fact_monto_final',ld_monto_final)
		dw_1.setitem(1,'fact_comentario',ls_comentario)
		dw_1.setitem(1,'fact_pasaporte',ls_pasaporte)
		dw_1.setitem(1,'fact_linea_aerea',ls_linea_aerea)
		dw_1.setitem(1,'fact_marca',ls_marca)
		dw_1.setitem(1,'vendedor',li_vendedor)
		dw_1.setitem(1,'fact_por_descuento',ld_descuento)

		idec_gastos = ld_gastos
		dw_2.object.cargos.expression = "'"+string(idec_gastos,'##0.00')+"'"	
		idec_descuento = ld_descuento
		dw_2.object.descuento.expression = "'"+string(idec_descuento,'##0.00')+"'"	
		ld_saldo = gf_saldo_anterior_new( ll_cliente, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)		
		if isnull(ld_saldo) then ld_saldo = 0.00
		dw_1.setitem(1,'saldo',ld_saldo)
		
		ll_fila = idwc_cliente.find('terc_tercero = '+string(ll_cliente),1,idwc_cliente.rowcount())
		if ll_fila > 0 then
			idwc_cliente.scrolltorow(ll_fila)
		end if
	
		ld_limite = idwc_cliente.getitemnumber(idwc_cliente.getrow(), 'clie_limite_credito')						
		dw_1.setitem(1,'limite',ld_limite)		
		li_bulto_inicio = 1

for i = 1 to upperbound(istr_pedidos.referencia)
		
		 DECLARE cur_detalle CURSOR FOR  
		  SELECT fadpedid.dped_linea,   
					fadpedid.dped_codigo_item,   
					fadpedid.dped_descripcion_alterna,   
					fadpedid.dped_unidad_producto,   
			   		fadpedid.dped_bodega,   
					fadpedid.dped_costo_fob,   
					fadpedid.dped_costo_cif,   
					fadpedid.dped_precio_unidad_producto,   
					fadpedid.dped_unidad_venta,   
					fadpedid.dped_bultos,   
					fadpedid.dped_ubicacion,   
					fadpedid.dped_index,   
					fadpedid.dped_precio_original,   
					fadpedid.dped_bulto_inicio,
					fadpedid.dped_bulto_fin,
					inmprodu.prod_producto_dos,
					inmprodu.prod_empaque,
					a.medi_cantidad,
					a.medi_tipo_medida,
					b.medi_cantidad,
					inmprodu.prod_peso,
					inmprodu.prod_cubicaje
			 FROM fadpedid, inmprodu, inamedid a , inamedid b
			WHERE (fadpedid.dped_g_financiero = inmprodu.prod_g_financiero ) AND
					( fadpedid.dped_empresa = inmprodu.prod_empresa ) AND
					( fadpedid.dped_codigo_item = inmprodu.prod_producto ) AND
					( fadpedid.dped_unidad_venta = a.medi_medida ) AND
					( inmprodu.prod_empaque_um = b.medi_medida ) and  					
					( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
					( fadpedid.dped_empresa = :str.empresa ) AND  
					( fadpedid.dped_no_pedido = :istr_pedidos.pedido ) AND  
					( fadpedid.dped_ann = :istr_pedidos.ann )  AND
					( fadpedid.dped_linea = :istr_pedidos.linea[i] );
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Declarar el Cursor '+sqlca.sqlerrtext,1,1,'E')
						return false
					end if
				
		open cur_detalle ;
		
		fetch cur_detalle into :li_linea, :ls_producto, :ls_descripcion, :ls_unidad, :ls_bodega, :ld_costo_fob, :ld_costo_cif, :ld_precio, &
									:ls_unidad_venta, :li_bultos, :ls_ubicacion, :li_index, :ld_precio_original, :li_bulto_inicio, :li_bulto_fin, :ls_modelo, :il_empaque, :ii_cantidad_unidad, :li_tipo_medida, :ii_cantidad_empaque, :id_peso, :id_cubicaje ;

			dw_2.scrolltorow(dw_2.insertrow(0))
			ld_cantidad = istr_pedidos.cantidad[i]
			li_fraccion  = istr_pedidos.fraccion[i]
			
			if (il_empaque * ii_cantidad_empaque) <> 0 then
				ll_bultos = (ld_cantidad * ii_cantidad_unidad ) / (il_empaque * ii_cantidad_empaque)
				ld_bultos = (ld_cantidad * ii_cantidad_unidad ) / (il_empaque * ii_cantidad_empaque)
			end if
			if ll_bultos = 0 then ll_bultos = 1		
			
			ld_monto_final = round( (ld_cantidad * ld_precio) + ((ld_precio / ii_cantidad_unidad) * li_fraccion ) ,2)
			
			dw_2.setitem(dw_2.getrow(),'facd_g_financiero',str.g_financiero)
			dw_2.setitem(dw_2.getrow(),'facd_empresa',str.empresa)
			dw_2.setitem(dw_2.getrow(),'facd_usuario',str.usuario)
			dw_2.setitem(dw_2.getrow(),'facd_codigo_item',ls_producto)
			dw_2.setitem(dw_2.getrow(),'facd_descripcion_alterna',ls_descripcion)
			dw_2.setitem(dw_2.getrow(),'facd_unidad_venta',ls_unidad)			
			dw_2.setitem(dw_2.getrow(),'facd_unidad_producto',ls_unidad)		
			dw_2.setitem(dw_2.getrow(),'facd_costo_cif', id_costo_cif)			
			dw_2.setitem(dw_2.getrow(),'facd_costo_fob', id_costo_fob)
			dw_2.setitem(dw_2.getrow(),'facd_unidad_venta', ls_unidad_venta)
			dw_2.setitem(dw_2.getrow(),'facd_linea', i)
			dw_2.setitem(dw_2.getrow(),'facd_index', i)	
			dw_2.setitem(dw_2.getrow(),'facd_bodega', ls_bodega)
			dw_2.setitem(dw_2.getrow(),'facd_ubicacion', ls_ubicacion)			
			dw_2.setitem(dw_2.getrow(),'facd_costo_total', round( (ld_cantidad * id_costo_cif) + ((id_costo_cif / ii_cantidad_unidad) * li_fraccion ) ,2))
			dw_2.setitem(dw_2.getrow(),'facd_bultos', li_bultos)			
			dw_2.setitem(dw_2.getrow(),'facd_cantidad_fraccion', li_fraccion)
			dw_2.setitem(dw_2.getrow(),'facd_cantidad', ld_cantidad)
			dw_2.setitem(dw_2.getrow(),'facd_modelo', ls_modelo)
			
			if ll_bultos = 0 then
				li_bulto_fin = li_bulto_inicio
			else
				li_bulto_fin = li_bulto_inicio + ll_bultos - 1
			end if		
			dw_2.setitem(dw_2.getrow(),'facd_bulto_inicio', li_bulto_inicio)
			dw_2.setitem(dw_2.getrow(),'facd_bulto_fin', li_bulto_fin)			
			if ll_bultos = 0 then
				li_bulto_inicio = li_bulto_fin
			else
				li_bulto_inicio = li_bulto_fin + 1
			end if			
						
			dw_2.setitem(dw_2.getrow(),'facd_precio_original', ld_precio_original)			
			dw_2.setitem(dw_2.getrow(),'facd_precio_unidad_producto', ld_precio)
			dw_2.setitem(dw_2.getrow(),'facd_monto_total', ld_monto_final)
			dw_2.setitem(dw_2.getrow(),'facd_monto_final', ld_monto_final)							
			dw_2.setitem(dw_2.getrow(),'facd_bultos_original',ld_bultos)					
			dw_2.setitem(dw_2.getrow(),'facd_peso',ll_bultos * id_peso)
			dw_2.setitem(dw_2.getrow(),'facd_cubicaje',round(ll_bultos * id_cubicaje,4))
			dw_2.setitem(dw_2.getrow(),'tipo_medida', li_tipo_medida)			
			
			ls_item = ls_producto
			
		close cur_detalle;

next

dw_7.retrieve(str.g_financiero, str.empresa, ls_item)

ib_rebajar_pedido = true

return true
end function

public function boolean wf_rebaja_pedido ();integer i, li_fraccion, li_cantidad_medida, li_existe
decimal{2} ld_cantidad, ld_pasada
string ls_error
	for i = 1 to upperbound(istr_pedidos.referencia)
		
		 DECLARE cur_detalle CURSOR FOR  
		  SELECT a.medi_cantidad
			 FROM fadpedid, inamedid a
			WHERE ( fadpedid.dped_unidad_venta = a.medi_medida ) AND
					( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
					( fadpedid.dped_empresa = :str.empresa ) AND  
					( fadpedid.dped_no_pedido = :istr_pedidos.pedido ) AND  
					( fadpedid.dped_ann = :istr_pedidos.ann )  AND
					( fadpedid.dped_linea = :istr_pedidos.linea[i] );
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Declarar el Cursor '+sqlca.sqlerrtext,1,1,'E')
						return false
					end if
				
		open cur_detalle ;
		
		fetch cur_detalle into :li_cantidad_medida;

			ld_cantidad = istr_pedidos.cantidad[i]
			if isnull(ld_cantidad) then ld_cantidad = 0
			li_fraccion  = istr_pedidos.fraccion[i]
			if isnull(li_fraccion) then li_fraccion = 0
			ld_pasada = ld_cantidad * li_cantidad_medida + li_fraccion
			
			  UPDATE fadpedid  
				  SET dped_pasada = dped_pasada + :ld_pasada  
				WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
						( fadpedid.dped_empresa = :str.empresa ) AND  
						( fadpedid.dped_no_pedido = :istr_pedidos.pedido ) AND  
						( fadpedid.dped_ann = :istr_pedidos.ann ) AND  
						( fadpedid.dped_linea = :istr_pedidos.linea[i] )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
						return false
					end if						
			
		close cur_detalle;

			gf_actualiza_reserva_producto(istr_pedidos.referencia[i])

next

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
         ( fatpedid.pedi_no_pedido = :istr_pedidos.pedido ) and
         ( fatpedid.pedi_ann = :istr_pedidos.ann ) and
            fadpedid.dped_pasada <  (fadpedid.dped_fraccion + fadpedid.dped_cantidad * (SELECT inamedid.medi_cantidad
		FROM    inamedid
		WHERE inamedid.medi_medida = fadpedid.dped_unidad_venta)) ;
		If sqlca.sqlcode = -1 then
			ls_error =sqlca.sqlerrtext
			mensaje("Error ","Error al verificar lo pasado "+ls_error,"")
			return false
		End If

	If li_existe = 0 then
	  UPDATE fatpedid  
		  SET pedi_estado = "P"  
		WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
				( fatpedid.pedi_empresa 	= :str.empresa ) AND  
				( fatpedid.pedi_no_pedido 	= :istr_pedidos.pedido ) AND  
				( fatpedid.pedi_ann = :istr_pedidos.ann )   ;

		If sqlca.sqlcode = -1 then
			ls_error =sqlca.sqlerrtext
			mensaje("Error ","Error al marcar estado del Pedido Pasado "+ls_error,"")
			return false
		End If
		commit using sqlca;	
	End If

return true
end function

public function boolean wf_asigna_proforma (str_pase_proforma astr_proformas);string ls_modelo, ls_cuenta, ls_condicion, ls_tipo, ls_movimiento, ls_consignado, ls_a_nombre, ls_direccion, ls_despachado, &
		ls_comentario, ls_pasaporte, ls_linea_aerea, ls_producto, ls_descripcion, ls_unidad, ls_bodega, ls_ubicacion, ls_unidad_venta, ls_item, ls_marca
datetime ldt_fecha_despacho, ldt_fecha, ldt_fecha_fin_plazo
decimal{2} ld_bultos, ld_bultos_original, ld_saldo, ld_limite, ld_descuento, ld_gastos, ld_monto, ld_monto_final , ld_costo_fob, ld_costo_cif, ld_cantidad, ld_precio_original, ld_costo_total, ld_precio, ld_precio_recargo, ld_rec_especial		
integer i, li_dias, li_vendedor, li_tipo, li_linea, li_index, li_fraccion, li_bultos, li_tipo_medida, li_bulto_inicio, li_bulto_fin
long ll_cliente, ll_fila, ll_bultos
  
datawindow = 1

this.triggerevent('ue_adicionar')
  
  SELECT fatprofo.prof_cliente,   
         fatprofo.prof_ruc_cliente,   
         fatprofo.prof_condicion_pago,   
         fatprofo.prof_tipo_venta,   
         fatprofo.prof_tipo_movimiento,   
         fatprofo.prof_dias_pago,   
         fatprofo.prof_consignado,   
         fatprofo.prof_a_nombre,   
         fatprofo.prof_a_nombre_direccion,   
         fatprofo.prof_despachado,   
         fatprofo.prof_gastos_total,   
         fatprofo.prof_monto_total,   
         fatprofo.prof_monto_final,   
         fatprofo.prof_comentario,   
         fatprofo.prof_pasaporte,   
         fatprofo.prof_linea_aerea,
		fatprofo.prof_por_descuento,
		fatprofo.prof_marca
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
         :ls_pasaporte,   
         :ls_linea_aerea,
		:ld_descuento,
		:ls_marca
    FROM fatprofo  
   WHERE ( fatprofo.prof_g_financiero = :str.g_financiero ) AND  
         ( fatprofo.prof_empresa = :str.empresa ) AND  
         ( fatprofo.prof_no_proforma = :astr_proformas.proforma ) AND  
         ( fatprofo.prof_ann = :astr_proformas.ann )   ;
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
		dw_7.bringtotop = true
		dw_1.insertrow(1)
		//Pone invisible el insertar	
		dw_1.setitem(1,'fact_g_financiero',str.g_financiero)
		dw_1.setitem(1,'fact_empresa',str.empresa)
		dw_1.setitem(1,'fact_ann',ii_ann)
		dw_1.setitem(1,'fact_fecha',date(gf_fecha_serv()))
		dw_1.setitem(1,'fact_fecha_fin_plazo',date(gf_fecha_serv()))	
		dw_1.setitem(1,'fact_tipo_venta',li_tipo) //exterior
		dw_1.setitem(1,'fact_estado','A')
		dw_1.setitem(1,'fact_usuario',str.usuario)	
		is_tipo = idwc_tipo.getitemstring(1,'dgmsubse_subs_sub_trans')
		dw_1.setitem(1,'fact_tipo', is_tipo)
		dw_1.setfocus()
		dw_1.setcolumn('fact_ruc_cliente')
		idec_gastos = 0
		//wf_orden_nueva()
		
		dw_1.setitem(1,'fact_no_pedido',is_secuencia)
		dw_1.setitem(1,'fact_ann',ii_ann)	
		dw_1.setitem(1,'fact_pre_factura',astr_proformas.proforma)
		dw_1.setitem(1,'fact_ann_pre_factura',astr_proformas.ann)
		dw_1.setitem(1,'fact_cliente',ll_cliente)
		dw_1.setitem(1,'fact_ruc_cliente',ls_cuenta)
		dw_1.setitem(1,'fact_condicion_pago',ls_condicion)
		dw_1.setitem(1,'fact_tipo_movimiento',ls_movimiento)
		dw_1.setitem(1,'fact_dias_pago',li_dias)
		dw_1.setitem(1,'fact_consignado',ls_consignado)
		dw_1.setitem(1,'fact_a_nombre',ls_a_nombre)
		dw_1.setitem(1,'fact_a_nombre_direccion',ls_direccion)
		dw_1.setitem(1,'fact_despachado',ls_despachado)
		ld_gastos = 0
		dw_1.setitem(1,'fact_gastos_total',ld_gastos)
		dw_1.setitem(1,'fact_monto_fact_total',ld_monto)
		dw_1.setitem(1,'fact_monto_final',ld_monto_final)
		dw_1.setitem(1,'fact_comentario',ls_comentario)
		dw_1.setitem(1,'fact_pasaporte',ls_pasaporte)
		dw_1.setitem(1,'fact_linea_aerea',ls_linea_aerea)
		dw_1.setitem(1,'fact_marca',ls_marca)
		dw_1.setitem(1,'vendedor',li_vendedor)
		dw_1.setitem(1,'fact_por_descuento',ld_descuento)
		dw_1.setitem(1,'fact_act_cliente',0)
		dw_1.setitem(1,'fact_act_inventario',0)
		dw_1.setitem(1,'fact_act_conta',0)	

		idec_gastos = ld_gastos
		dw_2.object.cargos.expression = "'"+string(idec_gastos,'##0.00')+"'"	
		idec_descuento = ld_descuento
		dw_2.object.descuento.expression = "'"+string(idec_descuento,'##0.00')+"'"	
		ld_saldo = gf_saldo_anterior_new( ll_cliente, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)		
		if isnull(ld_saldo) then ld_saldo = 0.00
		dw_1.setitem(1,'saldo',ld_saldo)
		
		ll_fila = idwc_cliente.find('terc_tercero = '+string(ll_cliente),1,idwc_cliente.rowcount())
		if ll_fila > 0 then
			idwc_cliente.scrolltorow(ll_fila)
		end if
	
		ld_limite = idwc_cliente.getitemnumber(idwc_cliente.getrow(), 'clie_limite_credito')						
		dw_1.setitem(1,'limite',ld_limite)		
		li_bulto_inicio = 1

for i = 1 to upperbound(istr_proformas.referencia)
		
		 DECLARE cur_detalle CURSOR FOR  
		  SELECT fadprofo.dpro_linea,   
					fadprofo.dpro_codigo_item,   
					fadprofo.dpro_descripcion_alterna,   
					fadprofo.dpro_unidad_producto,   
			   		fadprofo.dpro_bodega,   
					fadprofo.dpro_costo_fob,   
					fadprofo.dpro_costo_cif,   
					fadprofo.dpro_precio_unidad_producto,   
					fadprofo.dpro_unidad_venta,   
					fadprofo.dpro_bultos,   
					fadprofo.dpro_ubicacion,   
					fadprofo.dpro_index,   
					fadprofo.dpro_precio_original,   
					fadprofo.dpro_bulto_inicio,
					fadprofo.dpro_bulto_fin,
					inmprodu.prod_producto_dos,
					inmprodu.prod_empaque,
					a.medi_cantidad,
					a.medi_tipo_medida,
					b.medi_cantidad,
					inmprodu.prod_peso,
					inmprodu.prod_cubicaje
			 FROM fadprofo, inmprodu, inamedid a , inamedid b
			WHERE (fadprofo.dpro_g_financiero = inmprodu.prod_g_financiero ) AND
					( fadprofo.dpro_empresa = inmprodu.prod_empresa ) AND
					( fadprofo.dpro_codigo_item = inmprodu.prod_producto ) AND
					( fadprofo.dpro_unidad_venta = a.medi_medida ) AND
					( inmprodu.prod_empaque_um = b.medi_medida ) and  					
					( fadprofo.dpro_g_financiero = :str.g_financiero ) AND  
					( fadprofo.dpro_empresa = :str.empresa ) AND  
					( fadprofo.dpro_no_proforma = :istr_proformas.proforma ) AND  
					( fadprofo.dpro_ann = :istr_proformas.ann )  AND
					( fadprofo.dpro_linea = :istr_proformas.linea[i] );
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Declarar el Cursor '+sqlca.sqlerrtext,1,1,'E')
						return false
					end if
				
		open cur_detalle ;
		
		fetch cur_detalle into :li_linea, :ls_producto, :ls_descripcion, :ls_unidad, :ls_bodega, :ld_costo_fob, :ld_costo_cif, :ld_precio, &
									:ls_unidad_venta, :li_bultos, :ls_ubicacion, :li_index, :ld_precio_original, :li_bulto_inicio, :li_bulto_fin, :ls_modelo, :il_empaque, :ii_cantidad_unidad, :li_tipo_medida, :ii_cantidad_empaque, :id_peso, :id_cubicaje ;

			dw_2.scrolltorow(dw_2.insertrow(0))
			ld_cantidad = istr_proformas.cantidad[i]
			li_fraccion  = istr_proformas.fraccion[i]
			
			if (il_empaque * ii_cantidad_empaque) <> 0 then
				ll_bultos = (ld_cantidad * ii_cantidad_unidad ) / (il_empaque * ii_cantidad_empaque)
				ld_bultos = (ld_cantidad * ii_cantidad_unidad ) / (il_empaque * ii_cantidad_empaque)
			end if
			if ll_bultos = 0 then ll_bultos = 1		
			
			if ld_precio = 0 or isnull(ld_precio) then
				  SELECT inmprodu.prod_precio1  
					    INTO :ld_precio  
					    FROM inmprodu  
					   WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
					         ( inmprodu.prod_empresa = :str.empresa ) AND  
					         ( inmprodu.prod_producto = :ls_producto )   ;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al Buscar Precio '+sqlca.sqlerrtext,1,1,'E')
							return false
						end if
			end if
			
			ld_monto_final = round( (ld_cantidad * ld_precio) + ((ld_precio / ii_cantidad_unidad) * li_fraccion ) ,2)
			
			dw_2.setitem(dw_2.getrow(),'facd_g_financiero',str.g_financiero)
			dw_2.setitem(dw_2.getrow(),'facd_empresa',str.empresa)
			dw_2.setitem(dw_2.getrow(),'facd_usuario',str.usuario)
			dw_2.setitem(dw_2.getrow(),'facd_codigo_item',ls_producto)
			dw_2.setitem(dw_2.getrow(),'facd_descripcion_alterna',ls_descripcion)
			dw_2.setitem(dw_2.getrow(),'facd_unidad_venta',ls_unidad)			
			dw_2.setitem(dw_2.getrow(),'facd_unidad_producto',ls_unidad)		
			dw_2.setitem(dw_2.getrow(),'facd_costo_cif', id_costo_cif)			
			dw_2.setitem(dw_2.getrow(),'facd_costo_fob', id_costo_fob)
			dw_2.setitem(dw_2.getrow(),'facd_unidad_venta', ls_unidad_venta)
			dw_2.setitem(dw_2.getrow(),'facd_linea', i)
			dw_2.setitem(dw_2.getrow(),'facd_index', i)	
			dw_2.setitem(dw_2.getrow(),'facd_bodega', ls_bodega)
			dw_2.setitem(dw_2.getrow(),'facd_ubicacion', ls_ubicacion)			
			dw_2.setitem(dw_2.getrow(),'facd_costo_total', round( (ld_cantidad * id_costo_cif) + ((id_costo_cif / ii_cantidad_unidad) * li_fraccion ) ,2))
			dw_2.setitem(dw_2.getrow(),'facd_bultos', li_bultos)			
			dw_2.setitem(dw_2.getrow(),'facd_cantidad_fraccion', li_fraccion)
			dw_2.setitem(dw_2.getrow(),'facd_cantidad', ld_cantidad)
			dw_2.setitem(dw_2.getrow(),'facd_modelo', ls_modelo)

			if ll_bultos = 0 then
				li_bulto_fin = li_bulto_inicio
			else
				li_bulto_fin = li_bulto_inicio + ll_bultos - 1
			end if		
			dw_2.setitem(dw_2.getrow(),'facd_bulto_inicio', li_bulto_inicio)
			dw_2.setitem(dw_2.getrow(),'facd_bulto_fin', li_bulto_fin)			
			if ll_bultos = 0 then
				li_bulto_inicio = li_bulto_fin
			else
				li_bulto_inicio = li_bulto_fin + 1
			end if			
						
			dw_2.setitem(dw_2.getrow(),'facd_precio_original', ld_precio_original)			
			dw_2.setitem(dw_2.getrow(),'facd_precio_unidad_producto', ld_precio)
			dw_2.setitem(dw_2.getrow(),'facd_monto_total', ld_monto_final)
			dw_2.setitem(dw_2.getrow(),'facd_monto_final', ld_monto_final)							
			dw_2.setitem(dw_2.getrow(),'facd_bultos_original',ld_bultos)					
			dw_2.setitem(dw_2.getrow(),'facd_peso',ll_bultos * id_peso)
			dw_2.setitem(dw_2.getrow(),'facd_cubicaje',round(ll_bultos * id_cubicaje,4))
			dw_2.setitem(dw_2.getrow(),'tipo_medida', li_tipo_medida)			
			
			ls_item = ls_producto
			
		close cur_detalle;

next

dw_7.retrieve(str.g_financiero, str.empresa, ls_item)

ib_rebajar_proforma = true

return true
end function

public subroutine wf_pasar_estructura_prof (str_pase_proforma lstr_proformas);istr_proformas = lstr_proformas
end subroutine

public function boolean wf_rebaja_proforma ();integer i, li_fraccion, li_cantidad_medida, li_existe
decimal{2} ld_cantidad, ld_pasada
string ls_error
	for i = 1 to upperbound(istr_proformas.referencia)
		
		 DECLARE cur_detalle CURSOR FOR  
		  SELECT a.medi_cantidad
			 FROM fadprofo, inamedid a
			WHERE ( fadprofo.dpro_unidad_venta = a.medi_medida ) AND
					( fadprofo.dpro_g_financiero = :str.g_financiero ) AND  
					( fadprofo.dpro_empresa = :str.empresa ) AND  
					( fadprofo.dpro_no_proforma = :istr_proformas.proforma ) AND  
					( fadprofo.dpro_ann = :istr_proformas.ann )  AND
					( fadprofo.dpro_linea = :istr_proformas.linea[i] );
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Declarar el Cursor '+sqlca.sqlerrtext,1,1,'E')
						return false
					end if
				
		open cur_detalle ;
		
		fetch cur_detalle into :li_cantidad_medida;

			ld_cantidad = istr_proformas.cantidad[i]
			if isnull(ld_cantidad) then ld_cantidad = 0
			li_fraccion  = istr_proformas.fraccion[i]
			if isnull(li_fraccion) then li_fraccion = 0
			ld_pasada = ld_cantidad * li_cantidad_medida + li_fraccion
			
			  UPDATE fadprofo  
				  SET dpro_pasada = dpro_pasada + :ld_pasada  
				WHERE ( fadprofo.dpro_g_financiero = :str.g_financiero ) AND  
						( fadprofo.dpro_empresa = :str.empresa ) AND  
						( fadprofo.dpro_no_proforma = :istr_proformas.proforma ) AND  
						( fadprofo.dpro_ann = :istr_proformas.ann ) AND  
						( fadprofo.dpro_linea = :istr_proformas.linea[i] )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
						return false
					end if						
			
		close cur_detalle;

			gf_actualiza_reserva_producto(istr_proformas.referencia[i])

next

SELECT Count(*) 
 INTO :li_existe
 FROM fadprofo,
         fatprofo
   WHERE ( fatprofo.prof_g_financiero = fadprofo.dpro_g_financiero ) and
         ( fatprofo.prof_empresa = fadprofo.dpro_empresa ) and
         ( fatprofo.prof_no_proforma = fadprofo.dpro_no_proforma ) and
         ( fatprofo.prof_ann = fadprofo.dpro_ann ) and
		( fatprofo.prof_g_financiero = :str.g_financiero) AND
         ( fatprofo.prof_empresa = :str.empresa ) and
         ( fatprofo.prof_no_proforma = :istr_proformas.proforma ) and
         ( fatprofo.prof_ann = :istr_proformas.ann ) and
            fadprofo.dpro_pasada <  (fadprofo.dpro_fraccion + fadprofo.dpro_cantidad * (SELECT inamedid.medi_cantidad
		FROM    inamedid
		WHERE inamedid.medi_medida = fadprofo.dpro_unidad_venta)) ;
		If sqlca.sqlcode = -1 then
			ls_error =sqlca.sqlerrtext
			mensaje("Error ","Error al verificar lo pasado "+ls_error,"")
			return false
		End If

	If li_existe = 0 then
	  UPDATE fatprofo  
		  SET prof_estado = "P"  
		WHERE ( fatprofo.prof_g_financiero = :str.g_financiero ) AND  
				( fatprofo.prof_empresa 	= :str.empresa ) AND  
				( fatprofo.prof_no_proforma 	= :istr_proformas.proforma ) AND  
				( fatprofo.prof_ann = :istr_proformas.ann )   ;

		If sqlca.sqlcode = -1 then
			ls_error =sqlca.sqlerrtext
			mensaje("Error ","Error al marcar estado de la Proforma Pasado "+ls_error,"")
			return false
		End If
		commit using sqlca;	
	End If

return true
end function

public function boolean wf_recalcula_factura ();// Función que recalcula la Factura, "Solo para efectos de Impresion"

integer li_recorrido, li_fraccion,  i
double ld_final, ld_descuento, ld_porciento,  &
       ld_gastos, ld_precio_uni, ld_rebaja, ld_porc	,ld_monto_ori 
long ll_ucon, ll_mconvera, ll_cantidad_piezas, ll_cantidad
string ls_unidad_prod, ls_unidad_venta, ls_empre, ls_numero_palabra 
decimal{2} ld_precio, ld_monto, ld_monto_total = 0

ld_gastos = dw_4.getitemnumber(dw_4.getrow(),"fact_gastos_total")
ld_porciento = dw_1.getitemnumber(1,'porc')
for li_recorrido = 1 to dw_4.rowcount()
	
		ld_monto_ori	= round(dw_4.getitemnumber(li_recorrido, "facd_monto_final"),2)	
		ld_precio      = round(dw_4.getitemnumber(li_recorrido, "facd_precio_unidad_producto"),2)
		ll_cantidad    = dw_4.getitemnumber(li_recorrido, "facd_cantidad")
		li_fraccion    = dw_4.getitemnumber(li_recorrido, "facd_cantidad_fraccion")
		if isnull(li_fraccion) then li_fraccion = 0
		if isnull(ll_cantidad) then ll_cantidad = 0
		ls_unidad_prod = dw_4.getitemstring(li_recorrido, "facd_unidad_producto")
		ls_unidad_venta= dw_4.getitemstring(li_recorrido, "facd_unidad_venta")
	
		//Para transformar al precio por unidad
		ll_ucon = gf_medi_prod(ls_unidad_prod)
		ll_mconvera = gf_unidad_venta(ls_unidad_venta, ll_ucon)

		/*Puesto para poder ver los resultados desde el debug*/		
//		ld_precio_uni = round(ld_precio / ll_mconvera,2)
//		ld_porc       = round(ld_porciento / 100,2)		//Porcentaje
//		ld_rebaja	  = round(ld_precio_uni * ld_porc ,2)	//
		/*Comentado por hgn/12/10/02 */
//		ld_precio     = round(ld_precio_uni - ld_rebaja ,2)
		ld_precio     = round(ld_precio *(1 - ld_porciento / 100) ,2)
//		ll_cantidad_piezas = wf_cantidad_total(ll_cantidad, li_fraccion, li_recorrido)
		/*Monto total por el Porcentaje, calculando el monto primero*/		
		//ld_monto = round(ld_monto_ori - (ld_monto_ori * ld_porc),2)
		ld_monto = ld_precio * ll_cantidad + (li_fraccion * (ld_precio / ll_mconvera ))
//		if ll_cantidad_piezas = 0 or isnull(ll_cantidad_piezas) then ll_cantidad_piezas = 1
//		if ll_cantidad_piezas > 0 then
//			ld_precio= (ld_monto / ll_cantidad_piezas )	* ll_mconvera
//		end if
		/**/				
//		ld_monto = round(ld_precio * ll_cantidad_piezas,2)
//		ld_precio = round(ld_precio * ll_mconvera,2)
		
		dw_4.Setitem(li_recorrido,"facd_precio_unidad_producto",ld_precio)	
		dw_4.Setitem(li_recorrido,"facd_monto_total",ld_monto)
		dw_4.Setitem(li_recorrido,"facd_monto_final",ld_monto)
		
		//Es para que aparezcan los totales por pagina correctamente
		dw_4.Setitem(li_recorrido,"tot_por_registro",ld_monto)
		
		if isnull(ld_monto) then 
			//messagebox("Nulo",dw_4.getitemstring(li_recorrido,"facd_codigo_item"))
			ld_monto = 0
		end if
		
		ld_monto_total = ld_monto_total + ld_monto
		
		i ++
		
end for
	//Si no tiene gastos, se asigna el sub total a la variable global para que se grabe 
	if idec_gastos <> 0 and not isnull(idec_gastos) then
		str.porc = ld_monto_total
	end if
	//Se setean los totales a los respectivos computes
	dw_4.Setitem(dw_4.rowcount(),"fact_monto_fact_total",ld_monto_total)
	dw_4.Setitem(dw_4.rowcount(),"fact_monto_final",ld_monto_total + ld_gastos)	
	
	dw_4.Setitem(i + 1,"facd_monto_final",ld_monto_total)
	
//	ld_monto_total = dw_4.getitemnumber(dw_4.getrow(),"fact_monto_fact_total")
//	dw_4.object.tot.expression = string(ld_monto_total)
//	dw_4.object.tot2.expression = string(ld_monto_total)	
	/*puesto en comentario para que no quedara fijo el monto.*/
//	dw_4.object.tot_fin.expression = string(ld_monto_total + ld_gastos)
	
		
	ls_numero_palabra = " *** "+upper(gf_numerlet( ld_monto_total + ld_gastos ,1))+" ***"
	//if simple
	if dw_4.Describe("num_palabra.x") <> "?" and dw_4.Describe("num_palabra.x") <> "!" then &
	dw_4.object.num_palabra.expression = "'" + ls_numero_palabra + "'"
	
	return true
end function

public function integer wf_cantidad_total (integer cantidad, integer fraccion, integer row);//Función que devuelve la cantidad total pedida en piezas
 long ll_ucom, ll_mconvera, ll_total 
 string ls_unidad_prod, ls_unidad_venta
 
 ls_unidad_prod= dw_2.GetItemString(row,"facd_unidad_producto")
		
 ls_unidad_venta= dw_2.GetItemString(row,"facd_unidad_venta")
  
 //Tipo de medida de la unidad del producto	(UNIDADES, UNIDAD DE PESO, CONVERSIONES, ETC)
 // Devuleve 10 en caso de que sea una medida  
  
 ll_ucom = gf_medi_prod(ls_unidad_prod)
  
 //* Carga Los Datos de Converción de la Unidad Actual
 ll_mconvera = gf_unidad_venta(ls_unidad_venta, ll_ucom)
 
 if ll_mconvera = 0 or isnull(ll_mconvera) then
 
 	messagebox("ATENCIÓN SR. USUARIO", "Verifique las Unidades del Producto",Exclamation!)

	return 2
 
 end if

	ll_total = ( cantidad * ll_mconvera ) + fraccion

return (ll_total)
end function

public subroutine wf_setea_vencimiento ();//Cuando es Credito, se le setea la fecha de la factura + los días a pagar a fin del plazo
  integer li_coddias, li_dias
  date ld_fecha_final, ld_fecha
    
  li_coddias	=  dw_1.getitemnumber(dw_1.getrow(),"fact_dias_pago")
  //Recupera la cantidad de dias de la periodicidad
  
  li_dias		=  wf_recupera_dias(li_coddias)	
  ld_fecha 		=  date(dw_1.getitemdatetime(dw_1.getrow(),"fact_fecha"))
  ld_fecha_final  =  gf_suma_fecha_valor(li_dias, ld_fecha)
  
  dw_1.Setitem(dw_1.Getrow(),"fact_fecha_fin_plazo",ld_fecha_final)
end subroutine

public function integer wf_recupera_dias (integer li_codigo_dias);//Función que recupera el numero de dias que tiene el cliente para pagar la factura
//Variables de memoria
string	ls_frecuencia
integer	li_cantidad, li_dias
  
  SELECT dgaperio.peri_frecuencia,   //Extrae la frecuencia M=mes, D=dias, etc.
         dgaperio.peri_valor_d_s  
    INTO :ls_frecuencia,   
         :li_cantidad  
    FROM dgaperio  
   WHERE ( dgaperio.peri_aplicacion = "FA" ) AND  
         ( dgaperio.peri_periodo = :li_codigo_dias ) ;
			
		if sqlca.sqlcode = -1 then
			mensaje("Información (wf_recupera_días)","Error al Seleccionar registros en dgaperio",sqlca.sqlerrtext)
			return -1
		end if					
			
		CHOOSE CASE ls_frecuencia
			CASE "D"
				li_dias	=	li_cantidad
			CASE "M"
				li_dias	=  li_cantidad	*	30
			CASE "A"
				li_dias	=	li_cantidad	*	365
		END CHOOSE
return li_dias
end function

public subroutine wf_consolidar_factura ();//Función en la que se consolidan los articulos
//* Actualizada el 20 de Diciembre de 2001 *//

string  ls_producto, ls_prod_temporal, ls_unidad, ls_unidad_temporal, ls_unidad_producto,&
		  ls_bod_temporal, ls_ubic_temporal, ls_bodega, ls_ubicacion
integer i , li_linea
long    ll_total_registros, ll_contador, ll_cantidad, ll_fraccion, ll_cantidad_total, ll_cant_tot,&
		  ll_bultos
double  ld_precio,  ld_cubicaje, ld_peso, ld_precio_por_unidad, ld_costo, ld_costo_total, &
		  ld_costo_por_unidad
decimal ld_precio_total, ld_monto_total

datawindow ldw_2

/* Activa automaticamente los decimales para que cuadren los montos totales */


if gf_mensaje('','Esta Seguro de Consolidar la Factura ??',2,1,'E') = 2 then return
ii_recal_precio =0	/*Para validar si se recalcula el precio */
//If pos(UPPER(w_fa_fondo.str_para.dw_imp1),'NEWPORT') > 0 THEN
	ii_recal_precio = 1	/*No activa los 4 decimales*/
//else
//	
//	dw_1.setitem(1,"fact_cuatro_decimales",1)
//	dw_1.modify("fact_cuatro_decimales.visible='1'")
//	dw_1.object.t_4dec.visible = true	
//	dw_2.object.facd_precio_unidad_producto.edit.format='###,##0.0000'
//	dw_2.object.facd_precio_unidad_producto.format='###,##0.0000'
//	dw_2.object.facd_precio_original.edit.format='###,##0.0000'
//	dw_2.object.facd_precio_original.format='###,##0.0000'
//	if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 then
//	   dw_2.object.facd_precio_descuento.edit.format='###,##0.0000'
//	   dw_2.object.facd_precio_descuento.format='###,##0.0000'
//	end if
//	
//	ii_redondeo = 4 
//end if

ldw_2 = dw_2
//Para eliminar el ultimo registro del detalle de la factura, si esta en blanco
if ldw_2.rowcount() > 0 then
	if ldw_2.getitemstring(ldw_2.rowcount(),"facd_codigo_item") = '' or isnull(ldw_2.getitemstring(ldw_2.rowcount(),"facd_codigo_item")) then
		ldw_2.deleterow(ldw_2.rowcount())
	end if
end if

ll_total_registros = ldw_2.rowcount()

if ll_total_registros < 2 then return //Regresa si hay menos de dos registros

ldw_2.setsort("facd_codigo_item A facd_bodega A facd_ubicacion A")
ldw_2.sort()

ls_prod_temporal = ldw_2.getitemstring(1,"facd_codigo_item")
ls_bod_temporal  = trim(ldw_2.getitemstring(1,"facd_bodega"))
ls_ubic_temporal = ldw_2.getitemstring(1,"facd_ubicacion")

for i = 1 to ll_total_registros
	/*Llave*/
	ls_producto = ldw_2.getitemstring(i,"facd_codigo_item")
	ls_bodega	= ldw_2.getitemstring(i,"facd_bodega")
	ls_ubicacion= ldw_2.getitemstring(i,"facd_ubicacion")
	
	ls_unidad	=  ldw_2.getitemstring(i,"facd_unidad_venta")
	//Calcula el Precio
	ld_precio   =	ldw_2.getitemNumber(i,"facd_precio_unidad_producto")
	ls_unidad_producto = ldw_2.getitemString(i,"facd_unidad_producto")
	
	ld_precio	=  wf_calcula_precio(ls_unidad_producto, ls_unidad, ld_precio)
	
	//Calcula el Costo
	ld_costo    =	ldw_2.getitemNumber(i,"facd_costo_cif")
	ld_costo		=  wf_calcula_precio(ls_unidad_producto, ls_unidad, ld_costo)
	
	//Cantidad Total
	ll_cantidad =  ldw_2.getitemNumber(i,"facd_cantidad")
	ll_fraccion =  ldw_2.getitemNumber(i,"facd_cantidad_fraccion")

	//Función que calcula la cantidad minima
	ll_cant_tot = wf_convert_min(ls_unidad, ll_cantidad, ll_fraccion)
	
	//Si se repiten los productos para una misma bodega y ubicacion, acumula
	if ls_producto+ls_bodega+ls_ubicacion = ls_prod_temporal+ls_bod_temporal+ls_ubic_temporal then
		ll_contador ++		
		//Acumula los precios y cantidades
		ld_precio_total   += ld_precio
		ld_costo_total		+= ld_costo
		ll_cantidad_total += ll_cant_tot

		ld_monto_total  += ld_precio * ll_cant_tot
		
		ll_bultos		   += ldw_2.getitemNumber(i,"facd_bultos")
		ld_cubicaje			+= ldw_2.getitemNumber(i,"facd_cubicaje")
		ld_peso				+=	ldw_2.getitemNumber(i,"facd_peso")
		
		if ll_contador = 1 then	//Guarda la linea en donde debe setear los totales
			ls_unidad_temporal = ls_unidad //Para convertir en dicha unidad
			li_linea = i
		else	//Elimina los registros repetidos
			i --			
			ll_total_registros --
			li_linea = i
			ldw_2.deleterow(i)
		end if
	else
		//Para que entre a setear siempre y cuando sean mas de dos
		if ll_contador > 1 then
			
			//ld_precio_total =	truncate(round(ld_precio_total / ll_contador,2),2)
			ld_precio_total =	ld_precio_total / ll_contador			
			ld_costo_total  = ld_costo_total / ll_contador
			ld_precio_total = ld_monto_total / ll_cantidad_total
			//Dependiendo de la unidad del primer registro, asi despliega el precio y asigna al precio original
			ld_precio_por_unidad = wf_precio_por_unidad_consol(ls_unidad_producto, ls_unidad_temporal, ld_precio_total)
			ldw_2.Setitem(li_linea,"facd_precio_unidad_producto",ld_precio_por_unidad)
			ldw_2.Setitem(li_linea,"facd_precio_original",ld_precio_por_unidad)
			//Dependiendo de la unidad del primer registro, asi asigna el costo total
			ld_costo_por_unidad = wf_precio_por_unidad(ls_unidad_producto, ls_unidad_temporal, ld_costo_total)
			ldw_2.Setitem(li_linea,"facd_costo_cif",ld_costo_por_unidad)
			
			//Función  que convierte a la unidad facturada del primer registro						
			wf_convert_uni(ls_unidad_temporal, ll_cantidad_total, ll_cantidad_total, ll_fraccion)		
			ldw_2.Setitem(li_linea,"facd_cantidad",ll_cantidad_total)
			ldw_2.Setitem(li_linea,"facd_cantidad_fraccion",ll_fraccion)			
			ldw_2.Setitem(li_linea,"facd_unidad_venta",ls_unidad_temporal)			
			//Funcion que asigna los totales por registro
			//ll_cantidad_total va en la unidad de venta
			wf_monto_total(li_linea, ls_unidad_producto, ls_unidad_temporal,ll_cantidad_total,ll_fraccion,ld_precio_por_unidad,ldw_2, 0) //el 0 es del precio original
			
			ldw_2.Setitem(li_linea,"facd_bultos",ll_bultos)
			ldw_2.Setitem(li_linea,"facd_cubicaje",ld_cubicaje)
			ldw_2.Setitem(li_linea,"facd_peso",ld_peso)			
			ldw_2.Setitem(li_linea,"facd_index",li_linea)						
		end if	
		
		ls_unidad_temporal = ls_unidad //Para convertir en dicha unidad Actual del Producto		
		
		ls_prod_temporal	= ls_producto
		ls_bod_temporal 	= ls_bodega
		ls_ubic_temporal	= ls_ubicacion
		
		ld_precio_total   = ld_precio
		ld_costo_total		= ld_costo
		ll_contador 		= 1
		ll_cantidad_total	= ll_cant_tot
		
		ld_monto_total    = ld_precio * ll_cant_tot
		
		ll_bultos			= ldw_2.getitemNumber(i,"facd_bultos")
		ld_cubicaje			= ldw_2.getitemNumber(i,"facd_cubicaje")
		ld_peso				= ldw_2.getitemNumber(i,"facd_peso")		
	end if
	
next

//Para cuando es el ultimo registro
if ll_contador > 1 then 		
	ld_precio_total =	ld_precio_total / ll_contador	
	ld_precio_total = ld_monto_total / ll_cantidad_total
	//Dependiendo de la unidad del primer registro, asi despliega el precio
	ld_precio_por_unidad = wf_precio_por_unidad_consol(ls_unidad_producto, ls_unidad_temporal, ld_precio_total)
	ldw_2.Setitem(li_linea,"facd_precio_unidad_producto",ld_precio_por_unidad)
	
	ld_costo_total  = ld_costo_total / ll_contador	
	//Dependiendo de la unidad del primer registro, asi asigna el costo total
	ld_costo_por_unidad = wf_precio_por_unidad(ls_unidad_producto, ls_unidad_temporal, ld_costo_total)
	ldw_2.Setitem(li_linea,"facd_costo_cif",ld_costo_por_unidad)
		
	//Función  que convierte a la unidad facturada del primer registro	
	wf_convert_uni(ls_unidad_temporal, ll_cantidad_total, ll_cantidad_total, ll_fraccion)		
	ldw_2.Setitem(li_linea,"facd_cantidad",ll_cantidad_total)
	ldw_2.Setitem(li_linea,"facd_cantidad_fraccion",ll_fraccion)
	ldw_2.Setitem(li_linea,"facd_unidad_venta",ls_unidad_temporal)			
	//Funcion que asigna los totales por registro
	//ll_cantidad_total va en la unidad de venta	
	wf_monto_total(li_linea, ls_unidad_producto, ls_unidad_temporal, ll_cantidad_total, ll_fraccion, ld_precio_por_unidad, ldw_2, 0)//el 0 es del precio original, sin descuento
	ldw_2.Setitem(li_linea,"facd_bultos",ll_bultos)
	ldw_2.Setitem(li_linea,"facd_cubicaje",ld_cubicaje)
	ldw_2.Setitem(li_linea,"facd_peso",ld_peso)			
	ldw_2.Setitem(li_linea,"facd_index",li_linea)									
end if

for i = 1 to ldw_2.rowcount()
	ldw_2.Setitem(i,"facd_index",i)							
next


ldw_2.setsort("facd_index A")
ldw_2.sort()

//Desabilita la vista previa y la impresión hasta que salves
//m_fa_principal.m_archivo.m_imprimir.enabled = false
//m_fa_principal.m_archivo.m_guardar.enabled  = True


end subroutine

public function double wf_calcula_precio (string as_unidad_producto, string as_unidad_venta, double ad_precio);//llamada desde consolidar factura
Long ll_ucom, ll_mvonvera
double ld_precio
 //Tipo de medida de la unidad del producto	(UNIDADES, UNIDAD DE PESO, CONVERSIONES, ETC)
  // Devuleve 10 en caso de que sea una medida
 ll_ucom = gf_medi_prod(as_unidad_producto)
  
 //* Carga Los Datos de Converción de la Unidad Actual
 ll_mvonvera = gf_unidad_venta(as_unidad_venta, ll_ucom)
 
 if ll_mvonvera = 0 or isnull(ll_mvonvera) then
 	messagebox("ATENCIÓN SR. USUARIO  (wf_calcula_precio)", "Verifique las Unidades del Producto",Exclamation!)
	return ad_precio
 end if //Tipo de medida de la unidad del producto	(UNIDADES, UNIDAD DE PESO, CONVERSIONES, ETC)
 
 //Convierte el precio en su unidad minima
// ld_precio = truncate(round(( ad_precio / ll_mconvera ),2),2)
  ld_precio = ad_precio / ll_mvonvera
  
 return ld_precio
end function

public function long wf_convert_min (string as_med, long al_cantidad, long al_fraccion);/*Esta función recibe la cantidad y fracción y retorna todo convertido a fracción*/
//Llamada desde: retrieveend del DW 4, wf_validar_cantidad()

Long ll_ucom, ll_mconvera, ll_total

/*Extrae la Unidad comun "Pedo/Unidades/etc "*/
ll_ucom = gf_medi_prod(as_med)

/*Retorna el Factor de Converción a unidades minimas*/
ll_mconvera = gf_unidad_venta(as_med, ll_ucom)

If ll_mconvera <= 0 Then ll_mconvera = 1

ll_total = (al_cantidad * ll_mconvera) + al_fraccion

Return (ll_total)
end function

public subroutine wf_convert_uni (string as_med, long al_fracciones, ref long al_cantidad, ref long al_fraccion);/*Esta Función Convierte de Unidad Minima a la Unidad que se Quiere*/
//Llamada desde: wf_consolidar_facturas()

Double ld_total,ld_ucom
long   ll_mconvera, ll_frac

 
/*Extrae la Unidad comun "Pedo/Unidades/etc "*/
ld_ucom = gf_medi_prod(as_med)


/*Retorna el Factor de Converción a unidades minimas*/
ll_mconvera = gf_unidad_venta(as_med, ld_ucom)


If ll_mconvera <= 0 Then ll_mconvera = 1

ld_total = ( al_fracciones / ll_mconvera) 

ll_frac = (Mod(al_fracciones, ll_mconvera))
////messagebox("1",ld_frac)
//ld_frac = ld_frac*ld_mconvera
//messagebox("2",ld_frac)
//If ld_frac > ld_mconvera Then ld_frac = ld_frac /100

al_cantidad = Long(ld_total)
al_fraccion = ll_frac
end subroutine

public subroutine wf_monto_total (integer ai_linea, string as_unidad_prod, string as_unidad_vta, long al_cantidad, long al_fraccion, double ad_precio, datawindow adw_2, double ad_precio_original);//LLAMADA DESDE WF_CONSOLIDA_FACTURA Y DESDE UE_DWON
//NO CAMBIAR

long ll_ucom, ll_mconvera
Decimal ld_precio,ld_monto, ld_monto_tot

  //Tipo de medida de la unidad del producto	(UNIDADES, UNIDAD DE PESO, CONVERSIONES, ETC)
  // Devuleve 10 en caso de que sea una medida
 ll_ucom = gf_medi_prod(as_unidad_prod)
  
 //* Carga Los Datos de Converción de la Unidad Actual
 ll_mconvera = gf_unidad_venta(as_unidad_vta, ll_ucom)
 
 if ll_mconvera = 0 or isnull(ll_mconvera) then
 	messagebox("ATENCIÓN SR. USUARIO (wf_monto_total)", "Verifique las Unidades del Producto",Exclamation!)
	return 
 end if
 
ld_monto  =  round((ad_precio * al_cantidad) + round( (ad_precio / ll_mconvera) * al_fraccion ,2) ,2)

/**/
If ii_recal_precio = 1  then	
	ld_monto  =  round((ad_precio * al_cantidad) + (ad_precio / ll_mconvera) * al_fraccion ,2)
	
	/*Recalcula el precio para obtener un precio exacto */
	ld_precio =  round(ld_monto/(al_cantidad+(al_fraccion/ll_mconvera)),2)
	/*Recalcula el monto para que el mismo sea el producto de precio*cantidad
	  y no hayan diferencias */
	ld_monto  =  round(ld_precio*(al_cantidad+(al_fraccion/ll_mconvera)),2)
end if
/**/

if ad_precio_original <> 0 then
	ld_monto_tot  =  round((ad_precio_original * al_cantidad) + round( (ad_precio_original / ll_mconvera) * al_fraccion ,2) ,2)	
else
	ld_monto_tot = ld_monto
	
	If ii_recal_precio = 1  then
		adw_2.Setitem(ai_linea,"facd_precio_unidad_producto",ld_precio)
	end if
end if

adw_2.setitem(ai_linea,"facd_monto_total",ld_monto_tot)

adw_2.setitem(ai_linea,"facd_monto_final",ld_monto)


end subroutine

public function double wf_precio_por_unidad_consol (string as_unidad_prod, string as_unidad_venta, double ad_precio_minimo);long ll_ucom, ll_mconvera
double ld_precio

  //Tipo de medida de la unidad del producto	(UNIDADES, UNIDAD DE PESO, CONVERSIONES, ETC)
  // Devuleve 10 en caso de que sea una medida
 ll_ucom = gf_medi_prod(as_unidad_prod)
  
 //* Carga Los Datos de Converción de la Unidad Actual
 ll_mconvera = gf_unidad_venta(as_unidad_venta, ll_ucom)
 
 if ll_mconvera = 0 or isnull(ll_mconvera) then
 	messagebox("ATENCIÓN SR. USUARIO  (wf_precio_por_unidad)", "Verifique las Unidades del Producto",Exclamation!)
	return ad_precio_minimo
 end if


ld_precio = truncate(round(ad_precio_minimo * ll_mconvera,4),4)

return ld_precio
end function

public function double wf_precio_por_unidad (string as_unidad_prod, string as_unidad_venta, double ad_precio_minimo);long ll_ucom, ll_mconvera
double ld_precio

  //Tipo de medida de la unidad del producto	(UNIDADES, UNIDAD DE PESO, CONVERSIONES, ETC)
  // Devuleve 10 en caso de que sea una medida
 ll_ucom = gf_medi_prod(as_unidad_prod)
  
 //* Carga Los Datos de Converción de la Unidad Actual
 ll_mconvera = gf_unidad_venta(as_unidad_venta, ll_ucom)
 
 if ll_mconvera = 0 or isnull(ll_mconvera) then
 	messagebox("ATENCIÓN SR. USUARIO  (wf_precio_por_unidad)", "Verifique las Unidades del Producto",Exclamation!)
	return ad_precio_minimo
 end if


ld_precio = truncate(round(ad_precio_minimo * ll_mconvera,2),2)

return ld_precio
end function

public function double wf_peso ();// Función que  Calcula el peso de un Producto tomando en cuenta la cantidad y ...
// llamado desde ue_cantidad()

Double ld_cubifin,ld_frac,ld_resultado,ld_gecubi,&
       ld_cubi,ld_gepeso,ld_peso,ld_pesofin, ld_total_minimo
long	 ll_gecan,ll_gefrac, ll_mconvera,ll_mconverb, ll_mconverc , ll_total
Integer li_linea
String ls_medac,ls_unive, ls_peso_enca,ls_bodega

datawindow ldw, ldw_1

ldw_1=dw_1		


//****************************************************************************
                         // Inicio del Programa
//****************************************************************************
ldw = dw_2
li_linea = dw_2.Getrow()

		is_item =   ldw.getitemstring(li_linea,"facd_codigo_item")
		
		ls_bodega = trim(ldw.getitemString(li_linea,"facd_bodega"))
		ll_gecan =  ldw.getitemNumber(li_linea,"facd_cantidad")	
		ll_gefrac = ldw.getitemNumber(li_linea,"facd_cantidad_fraccion")
		ld_gecubi = id_cubicaje
		ld_gepeso = id_peso	
	
		If ld_gepeso = 0 Then
			ld_gepeso = 1
			return 0
//			messagebox("ATENCION SR. USUARIO","Verifique el Peso del Producto",Exclamation!)
		End If	
										
			  ld_peso =   ldw.getitemNumber(li_linea,"facd_peso")	// para que ?
	 
	       // Unidad del producto
           ls_medac = ldw.getitemstring(li_linea,"facd_unidad_producto")
				
		    // Unidad con la cual se esta vendiendo el producto a un cliente		
		      ls_unive = ldw.GetItemString(li_linea,"facd_unidad_venta")		
			
		    //Tipo de medida de la unidad del producto
			 
 			 	il_ucom = gf_medi_prod(ls_medac)
				  		  
			//* Carga Los Datos de Converción de la Unidad del Producto a la Nueva unidad o 
			// Cantidad de unidades minimas de la unidade de venta

			 ll_mconverb = gf_unidad_prod(ls_medac, il_ucom)
			 
	        //* cantidad de unidades minimas que tiene la unidad del producto        
		    ll_mconvera = gf_unidad_venta(ls_unive, il_ucom)
  

	// cubicaje /piesas = bubicaje por piesa eso por la cantidad de unidades que tiene la unidad 
	// con la cual se esta vendiendo
		if ll_mconvera = 0 then			
			ll_mconvera = 1			
		end if

	  ll_total = ( ll_gecan * ll_mconvera )  + ll_gefrac  // Cantidad de peso de la unidad  
	  																		 // que se esta vendiendo
		//Valor del empaque																				
  		ll_mconverc = ii_cantidad_empaque //gf_unidad_venta(w_fa_fondo.strp.emp_um, il_ucom)
		
		if ll_mconverc = 0 or isnull(ll_mconverc) then ll_mconverc = 1
		
		/*Sacar lo equivalente del empaque para dividir entre lo calculado
		ld_mconverc = ver unidad del empaque y traer su equivalente*/
		
		//0 al peso, si no hay empaque definido para el producto
		if il_empaque = 0.00 or isnull(il_empaque) then 
			ld_resultado = 0
		else				
			ld_total_minimo = ld_gepeso / il_empaque / ll_mconverc
	
			if ld_total_minimo = 0 or isnull(ld_total_minimo) then ld_total_minimo = 1
																					
			ld_pesofin = ll_total *  ld_total_minimo
		  
		//   ld_resultado = wf_compara_peso(ld_pesofin)
		  
	  end if
	  
//	  ldw.Setitem(li_linea,"facd_peso", truncate(round(ld_pesofin,4),4))
	  
return(ld_pesofin)
end function

public subroutine wf_pasar_estructura_entrada (str_pase_entradas lstr_entradas);istr_entradas = lstr_entradas
end subroutine

public function boolean wf_asigna_entrada (str_pase_entradas astr_entradas);string ls_modelo, ls_cuenta, ls_condicion, ls_tipo, ls_movimiento, ls_consignado, ls_a_nombre, ls_direccion, ls_despachado, &
		ls_comentario, ls_pasaporte, ls_linea_aerea, ls_producto, ls_descripcion, ls_unidad, ls_bodega, ls_ubicacion, ls_unidad_venta, ls_item, ls_marca
datetime ldt_fecha_despacho, ldt_fecha
decimal{2} ld_bultos, ld_bultos_original, ld_saldo, ld_limite, ld_descuento, ld_gastos, ld_monto, ld_monto_final , ld_costo_fob, ld_costo_cif, ld_cantidad, ld_precio_original, ld_costo_total, ld_precio, ld_precio_recargo, ld_rec_especial		
integer i, li_dias, li_vendedor, li_tipo, li_linea, li_index, li_fraccion, li_bultos, li_tipo_medida, li_bulto_inicio, li_bulto_fin
long ll_cliente, ll_fila, ll_bultos
  
for i = 1 to upperbound(istr_entradas.referencia)
		
		 DECLARE cur_detalle CURSOR FOR  
		  SELECT indmovim.dmov_linea,   
					indmovim.dmov_producto,   
					inmprodu.prod_descripcion,   
					indmovim.dmov_unidad_medida,   
			   		indmovim.dmov_bodega,   
					indmovim.dmov_costo_fob,   
					indmovim.dmov_costo_cif,   
					indmovim.dmov_precio,   
					indmovim.dmov_unidad_medida,   
					indmovim.dmov_bulto,   
					indmovim.dmov_ubicacion,   
					indmovim.dmov_linea,   
					indmovim.dmov_precio,   
					0,
					0,
					inmprodu.prod_producto_dos,
					inmprodu.prod_empaque,
					a.medi_cantidad,
					a.medi_tipo_medida,
					b.medi_cantidad,
					inmprodu.prod_peso,
					inmprodu.prod_cubicaje
			 FROM indmovim, inmprodu, inamedid a , inamedid b
			WHERE (indmovim.dmov_g_financiero = inmprodu.prod_g_financiero ) AND
					( indmovim.dmov_empresa = inmprodu.prod_empresa ) AND
					( indmovim.dmov_producto = inmprodu.prod_producto ) AND
					( indmovim.dmov_unidad_medida = a.medi_medida ) AND
					( inmprodu.prod_empaque_um = b.medi_medida ) and  					
					( indmovim.dmov_g_financiero = :str.g_financiero ) AND  
					( indmovim.dmov_empresa = :str.empresa ) AND  
					( indmovim.dmov_secuencia = :istr_entradas.entrada ) AND  
					( indmovim.dmov_anual = :istr_entradas.ann )  AND
					( indmovim.dmov_aplicacion = 'IN') AND
					( indmovim.dmov_tipo_transaccion = 'EN' ) AND
					( indmovim.dmov_linea = :istr_entradas.linea[i] );
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Declarar el Cursor '+sqlca.sqlerrtext,1,1,'E')
						return false
					end if
				
		open cur_detalle ;
		
		fetch cur_detalle into :li_linea, :ls_producto, :ls_descripcion, :ls_unidad, :ls_bodega, :ld_costo_fob, :ld_costo_cif, :ld_precio, &
									:ls_unidad_venta, :li_bultos, :ls_ubicacion, :li_index, :ld_precio_original, :li_bulto_inicio, :li_bulto_fin, :ls_modelo, :il_empaque, :ii_cantidad_unidad, :li_tipo_medida, :ii_cantidad_empaque, :id_peso, :id_cubicaje ;

			dw_2.scrolltorow(dw_2.insertrow(0))
			ld_cantidad = istr_entradas.cantidad[i]
			li_fraccion  = istr_entradas.fraccion[i]
			
			if (il_empaque * ii_cantidad_empaque) <> 0 then
				ll_bultos = (ld_cantidad * ii_cantidad_unidad ) / (il_empaque * ii_cantidad_empaque)
				ld_bultos = (ld_cantidad * ii_cantidad_unidad ) / (il_empaque * ii_cantidad_empaque)
			end if
			if ll_bultos = 0 then ll_bultos = 1		
			
			ld_monto_final = round( (ld_cantidad * ld_precio) + ((ld_precio / ii_cantidad_unidad) * li_fraccion ) ,2)
			
			dw_2.setitem(dw_2.getrow(),'facd_g_financiero',str.g_financiero)
			dw_2.setitem(dw_2.getrow(),'facd_empresa',str.empresa)
			dw_2.setitem(dw_2.getrow(),'facd_usuario',str.usuario)
			dw_2.setitem(dw_2.getrow(),'facd_codigo_item',ls_producto)
			dw_2.setitem(dw_2.getrow(),'facd_descripcion_alterna',ls_descripcion)
			dw_2.setitem(dw_2.getrow(),'facd_unidad_venta',ls_unidad)			
			dw_2.setitem(dw_2.getrow(),'facd_unidad_producto',ls_unidad)		
			dw_2.setitem(dw_2.getrow(),'facd_costo_cif', id_costo_cif)			
			dw_2.setitem(dw_2.getrow(),'facd_costo_fob', id_costo_fob)
			dw_2.setitem(dw_2.getrow(),'facd_unidad_venta', ls_unidad_venta)
			dw_2.setitem(dw_2.getrow(),'facd_linea', i)
			dw_2.setitem(dw_2.getrow(),'facd_index', i)	
			dw_2.setitem(dw_2.getrow(),'facd_bodega', ls_bodega)
			dw_2.setitem(dw_2.getrow(),'facd_ubicacion', ls_ubicacion)			
			dw_2.setitem(dw_2.getrow(),'facd_costo_total', round( (ld_cantidad * id_costo_cif) + ((id_costo_cif / ii_cantidad_unidad) * li_fraccion ) ,2))
			dw_2.setitem(dw_2.getrow(),'facd_bultos', li_bultos)			
			dw_2.setitem(dw_2.getrow(),'facd_cantidad_fraccion', li_fraccion)
			dw_2.setitem(dw_2.getrow(),'facd_cantidad', ld_cantidad)
			dw_2.setitem(dw_2.getrow(),'facd_modelo', ls_modelo)

			if ll_bultos = 0 then
				li_bulto_fin = li_bulto_inicio
			else
				li_bulto_fin = li_bulto_inicio + ll_bultos - 1
			end if		
			dw_2.setitem(dw_2.getrow(),'facd_bulto_inicio', li_bulto_inicio)
			dw_2.setitem(dw_2.getrow(),'facd_bulto_fin', li_bulto_fin)			
			if ll_bultos = 0 then
				li_bulto_inicio = li_bulto_fin
			else
				li_bulto_inicio = li_bulto_fin + 1
			end if			
						
			dw_2.setitem(dw_2.getrow(),'facd_precio_original', ld_precio_original)			
			dw_2.setitem(dw_2.getrow(),'facd_precio_unidad_producto', ld_precio)
			dw_2.setitem(dw_2.getrow(),'facd_monto_total', ld_monto_final)
			dw_2.setitem(dw_2.getrow(),'facd_monto_final', ld_monto_final)							
			dw_2.setitem(dw_2.getrow(),'facd_bultos_original',ld_bultos)					
			dw_2.setitem(dw_2.getrow(),'facd_peso',ll_bultos * id_peso)
			dw_2.setitem(dw_2.getrow(),'facd_cubicaje',round(ll_bultos * id_cubicaje,4))
			dw_2.setitem(dw_2.getrow(),'tipo_medida', li_tipo_medida)			
			
			ls_item = ls_producto
			
		close cur_detalle;

next

dw_7.retrieve(str.g_financiero, str.empresa, ls_item)

ib_rebaja_entrada = true

return true
end function

public function boolean wf_rebaja_entrada ();integer i, li_fraccion, li_cantidad_medida, li_existe
decimal{2} ld_cantidad, ld_pasada
string ls_error
	for i = 1 to upperbound(istr_entradas.referencia)
		
		 DECLARE cur_detalle CURSOR FOR  
		  SELECT a.medi_cantidad
			 FROM indmovim, inamedid a
			WHERE ( indmovim.dmov_unidad_medida = a.medi_medida ) AND
					( indmovim.dmov_g_financiero = :str.g_financiero ) AND  
					( indmovim.dmov_empresa = :str.empresa ) AND  
					( indmovim.dmov_secuencia = :istr_entradas.entrada ) AND  
					( indmovim.dmov_anual = :istr_entradas.ann )  AND
					( indmovim.dmov_linea = :istr_entradas.linea[i] ) AND 
					( indmovim.dmov_aplicacion = 'IN' ) AND
					( indmovim.dmov_tipo_transaccion = 'EN');
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Declarar el Cursor '+sqlca.sqlerrtext,1,1,'E')
						return false
					end if
				
		open cur_detalle ;
		
		fetch cur_detalle into :li_cantidad_medida;

			ld_cantidad = istr_entradas.cantidad[i]
			if isnull(ld_cantidad) then ld_cantidad = 0
			li_fraccion  = istr_entradas.fraccion[i]
			if isnull(li_fraccion) then li_fraccion = 0
			ld_pasada = ld_cantidad * li_cantidad_medida + li_fraccion
			
			  UPDATE indmovim  
				  SET dmov_pasada = isnull(dmov_pasada,0) + :ld_pasada  
				WHERE ( indmovim.dmov_g_financiero = :str.g_financiero ) AND  
						( indmovim.dmov_empresa = :str.empresa ) AND  
						( indmovim.dmov_secuencia = :istr_entradas.entrada ) AND  
						( indmovim.dmov_anual = :istr_entradas.ann ) AND  
						( indmovim.dmov_linea = :istr_entradas.linea[i] ) AND
						( indmovim.dmov_aplicacion = 'IN' ) AND
						( indmovim.dmov_tipo_transaccion = 'EN');
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
						return false
					end if						
			
		close cur_detalle;

		gf_actualiza_reserva_producto(istr_entradas.referencia[i])

			  SELECT count(*)  
			 INTO :li_existe  
			 FROM indmovim,   
					intmovim  
			WHERE ( intmovim.tmov_g_financiero = indmovim.dmov_g_financiero ) and  
					( intmovim.tmov_empresa = indmovim.dmov_empresa ) and  
					( intmovim.tmov_aplicacion = indmovim.dmov_aplicacion ) and  
					( intmovim.tmov_tipo_transaccion = indmovim.dmov_tipo_transaccion ) and  
					( intmovim.tmov_secuencia = indmovim.dmov_secuencia ) and  
					( intmovim.tmov_concepto = indmovim.dmov_concepto ) and  
					( intmovim.tmov_anual = indmovim.dmov_anual ) and  
					( ( indmovim.dmov_g_financiero = :str.g_financiero ) AND  
					( indmovim.dmov_empresa = :str.empresa ) AND  
					( indmovim.dmov_aplicacion = 'IN' ) AND  
					( indmovim.dmov_tipo_transaccion = 'EN' ) AND  
					( indmovim.dmov_secuencia = :istr_entradas.entrada ) AND  
					( indmovim.dmov_anual = :istr_entradas.ann ) AND  
				  indmovim.dmov_pasada <  (indmovim.dmov_cant1 + indmovim.dmov_cantidad * (SELECT inamedid.medi_cantidad FROM   inamedid WHERE inamedid.medi_medida = indmovim.dmov_unidad_medida))) ;
						If sqlca.sqlcode = -1 then
							ls_error =sqlca.sqlerrtext
							mensaje("Error ","Error al verificar lo pasado "+ls_error,"")
							return false
						End If
		
			If li_existe = 0 then
			
			  UPDATE intmovim  
			  SET tmov_estado_entrada = 'P'  
			WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
					( intmovim.tmov_empresa = :str.empresa ) AND  
					( intmovim.tmov_aplicacion = 'IN' ) AND  
					( intmovim.tmov_tipo_transaccion = 'EN' ) AND  
					( intmovim.tmov_secuencia = :istr_entradas.entrada ) AND  
					( intmovim.tmov_anual = :istr_entradas.ann )   ;
				If sqlca.sqlcode = -1 then
					ls_error =sqlca.sqlerrtext
					mensaje("Error ","Error al marcar estado de la Entrada a Pasado "+ls_error,"")
					return false
				End If
				commit using sqlca;	
			End If

next


return true
end function

public function double wf_cubicaje (boolean ab_metros_cubicos);// Función que  Calcula el cubicaje de un Producto tomando en cuenta la cantidad y
// Llamada desde ue_fraccion

Double ld_cubifin,ld_frac,ld_resultado,ld_gecubi,&
       ld_cubi, ld_total_minimo 
long	 ll_gecan, ll_gefrac, ll_total,ll_mconvera, ll_mconverb,ll_mconverc
Integer li_linea
datawindow ldw
String ls_medac,ls_unive,ls_bodega

//****************************************************************************
                         // Inicio del Programa
//****************************************************************************
ldw = dw_2
li_linea = dw_2.Getrow()

// For li_linea = 1 To ldw.Rowcount() 
//   Si la Linea es un producto

		is_item =   ldw.getitemstring(li_linea,"facd_codigo_item")
		//Funcion que extrae el codigo del producto del compute Concatenado de prod...+bodega+ubicacion	
		//Si el compute tiene "_" , el item se modifica en la funcion
		//wf_extrae_codigo(is_item)
		ls_bodega = trim(ldw.getitemString(li_linea,"facd_bodega"))
		ll_gecan =  ldw.getitemNumber(li_linea,"facd_cantidad")	
		ll_gefrac = ldw.getitemNumber(li_linea,"facd_cantidad_fraccion")
		if ab_metros_cubicos then
			ld_gecubi = id_cubicaje_m3
		else
			ld_gecubi = id_cubicaje
		end if
		
		If ld_gecubi = 0 Then
			//messagebox("ATENCIÓN SR. USUARIO","Verifique el Cubicaje del Producto",Exclamation!)
			//ld_gecubi = 1
		   ldw.Setitem(li_linea,"facd_cubicaje", 0)
			return 0
		End If	
			
			  ld_cubi =   ldw.getitemNumber(li_linea,"facd_cubicaje")
			  
	       // Unidad del producto
           ls_medac = ldw.getitemstring(li_linea,"facd_unidad_producto")
			  
		    // Unidad con la cual se esta vendiendo el producto a un cliente		
		      ls_unive = ldw.GetItemString(li_linea,"facd_unidad_venta")		
			
  		    //Tipo de medida de la unidad del producto	(UNIDADES, UNIDAD DE PESO, CONVERSIONES, ETC)	 
 			 	il_ucom = gf_medi_prod(ls_medac)
				  		  
			//* Carga Los Datos de Converción de la Unidad del Producto a la Nueva unidad o 
			// Cantidad de unidades minimas de la unidade de venta
			 ll_mconverb = gf_unidad_prod(ls_medac, il_ucom)

			 if ll_mconverb	= 0 then ll_mconverb = 1
			 
         //* cantidad de unidades minimas que tiene la unidad del producto
	      ll_mconvera = gf_unidad_venta(ls_unive, il_ucom)			  			 

///		Calcula la cantidad minima del cubicaje	 
//			//Valor del empaque																				
			ll_mconverc = ii_cantidad_empaque //gf_unidad_venta(w_fa_fondo.strp.emp_um, il_ucom)
			
			if ll_mconverc = 0 or isnull(ll_mconverc) then ll_mconverc = 1

			//0 al peso, si no hay empaque definido para el producto
			if il_empaque = 0.00 or isnull(il_empaque) then 
				ld_resultado = 0
			else
			  //Cubicaje minimo
			  ld_total_minimo = ld_gecubi / il_empaque / ll_mconverc
	
			  if ld_total_minimo = 0 or isnull(ld_total_minimo) then ld_total_minimo = 1			
				
			  //total de cantidad en unidad minima																		
			  ll_total = ll_gecan * ll_mconvera + ll_gefrac									
					
			  ld_cubifin = (ll_total   *  ld_total_minimo ) 
			  
			  ld_resultado = ld_cubifin // (/ ld_mconvera)
		  
		   end if
	  
	//	ldw.Setitem(li_linea,"dped_cubicaje", truncate(round(ld_resultado,4),4))	  	 
	
// Next		  
	return(ld_resultado)
end function

public function boolean wf_cambiar_tipo (string as_tipo_anterior);sqlca.autocommit = false
string ls_error

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
           fact_estado,   
           fact_act_cliente,   
           fact_act_inventario,   
           fact_act_conta,   
           fact_cerrada,   
           fact_referencia_fac,   
           fact_monto_abonado,   
           fact_fecha_act_conta,   
           fact_pedido_original,   
           fact_autorizacion,   
           fact_actualizo_cargos,   
           fact_actualizo_vendedor,   
           fact_factura_de_bodega,   
           fact_viene_de_pedido,   
           fact_habilitada_por,   
           fact_cuatro_decimales,   
           fact_usuario,   
           fact_precio_a_utilizar,   
           fact_costos_total,   
           fact_pasado_a_empresa,   
           fact_modificada_por,   
           fact_descartada_por,   
           fact_fecha_descarte,   
           fact_viene_de_ventas_diarias,   
           fact_ncr_descuento,   
           fact_descuento_ncr,   
           fact_guia,   
           fact_destino,   
           fact_porcentaje,   
           fact_tipo_costo,   
           fact_metal_pendiente,   
           fact_cierre_de_metal,   
           fact_precio_onza,   
           fact_fix,   
           fact_factura_cierre,   
           fact_excluir_de_reporte,   
           fact_fecha_despacho,   
           fact_pasaporte,   
           fact_linea_aerea,   
           fact_factura_trafico,   
           fact_factura_impresa,   
           fact_fecha_impresion,   
           fact_detalle_liquidacion,   
           fact_monto_a_facturar,   
           fact_pre_factura,   
           fact_ann_pre_factura,   
           fact_recargo_especial,   
           fact_fix_fecha,   
           fact_nota_credito,   
           fact_ann_fact_referencia,   
           fact_factura_referencia,   
           fact_usuario_print,   
           fact_vence_reserva,   
           fact_reserva_vence,   
           fact_paga_itbm,   
           fact_ruc,   
           fact_dv,   
           fact_alerta_vencimiento,   
           fact_provincia_fe,   
           fact_distrito,   
           fact_corregimiento,   
           fact_tipo_fact,   
           fact_itbm_retenido,   
           fact_efectivo,   
           fact_cheque,   
           fact_tarjeta,   
           fact_transferencia,   
           fact_nota_de_credito,   
           fact_intcoterms,   
           fact_tipo_ventas,   
           fact_tipo_documento,   
           fact_cubicaje_total_metros,   
           fact_cliente_contado,   
           fact_pdt )  
     SELECT fatdiari.fact_g_financiero,   
            fatdiari.fact_empresa,   
            :is_tipo,   
            fatdiari.fact_no_pedido,   
            fatdiari.fact_ann,   
            fatdiari.fact_no_factura,   
            fatdiari.fact_cliente,   
            fatdiari.fact_ruc_cliente,   
            fatdiari.fact_condicion_pago,   
            fatdiari.fact_tipo_venta,   
            fatdiari.fact_tipo_movimiento,   
            fatdiari.fact_no_traspaso,   
            fatdiari.fact_fecha,   
            fatdiari.fact_fecha_creacion,   
            fatdiari.fact_fecha_modificacion,   
            fatdiari.fact_dias_pago,   
            fatdiari.fact_fecha_fin_plazo,   
            fatdiari.fact_fecha_cancelado,   
            fatdiari.fact_consignado,   
            fatdiari.fact_a_nombre,   
            fatdiari.fact_a_nombre_direccion,   
            fatdiari.fact_despachado,   
            fatdiari.fact_via,   
            fatdiari.fact_con_emb_no,   
            fatdiari.fact_marca,   
            fatdiari.fact_bultos_total,   
            fatdiari.fact_cubicaje_total,   
            fatdiari.fact_peso_total,   
            fatdiari.fact_unidad_peso,   
            fatdiari.fact_gastos_total,   
            fatdiari.fact_monto_fact_total,   
            fatdiari.fact_descuento_subt_deta,   
            fatdiari.fact_por_descuento,   
            fatdiari.fact_supervisor,   
            fatdiari.fact_monto_final,   
            fatdiari.fact_comentario,   
            fatdiari.fact_estado,   
            fatdiari.fact_act_cliente,   
            fatdiari.fact_act_inventario,   
            fatdiari.fact_act_conta,   
            fatdiari.fact_cerrada,   
            fatdiari.fact_referencia_fac,   
            fatdiari.fact_monto_abonado,   
            fatdiari.fact_fecha_act_conta,   
            fatdiari.fact_pedido_original,   
            fatdiari.fact_autorizacion,   
            fatdiari.fact_actualizo_cargos,   
            fatdiari.fact_actualizo_vendedor,   
            fatdiari.fact_factura_de_bodega,   
            fatdiari.fact_viene_de_pedido,   
            fatdiari.fact_habilitada_por,   
            fatdiari.fact_cuatro_decimales,   
            fatdiari.fact_usuario,   
            fatdiari.fact_precio_a_utilizar,   
            fatdiari.fact_costos_total,   
            fatdiari.fact_pasado_a_empresa,   
            fatdiari.fact_modificada_por,   
            fatdiari.fact_descartada_por,   
            fatdiari.fact_fecha_descarte,   
            fatdiari.fact_viene_de_ventas_diarias,   
            fatdiari.fact_ncr_descuento,   
            fatdiari.fact_descuento_ncr,   
            fatdiari.fact_guia,   
            fatdiari.fact_destino,   
            fatdiari.fact_porcentaje,   
            fatdiari.fact_tipo_costo,   
            fatdiari.fact_metal_pendiente,   
            fatdiari.fact_cierre_de_metal,   
            fatdiari.fact_precio_onza,   
            fatdiari.fact_fix,   
            fatdiari.fact_factura_cierre,   
            fatdiari.fact_excluir_de_reporte,   
            fatdiari.fact_fecha_despacho,   
            fatdiari.fact_pasaporte,   
            fatdiari.fact_linea_aerea,   
            fatdiari.fact_factura_trafico,   
            fatdiari.fact_factura_impresa,   
            fatdiari.fact_fecha_impresion,   
            fatdiari.fact_detalle_liquidacion,   
            fatdiari.fact_monto_a_facturar,   
            fatdiari.fact_pre_factura,   
            fatdiari.fact_ann_pre_factura,   
            fatdiari.fact_recargo_especial,   
            fatdiari.fact_fix_fecha,   
            fatdiari.fact_nota_credito,   
            fatdiari.fact_ann_fact_referencia,   
            fatdiari.fact_factura_referencia,   
            fatdiari.fact_usuario_print,   
            fatdiari.fact_vence_reserva,   
            fatdiari.fact_reserva_vence,   
            fatdiari.fact_paga_itbm,   
            fatdiari.fact_ruc,   
            fatdiari.fact_dv,   
            fatdiari.fact_alerta_vencimiento,   
            fatdiari.fact_provincia_fe,   
            fatdiari.fact_distrito,   
            fatdiari.fact_corregimiento,   
            fatdiari.fact_tipo_fact,   
            fatdiari.fact_itbm_retenido,   
            fatdiari.fact_efectivo,   
            fatdiari.fact_cheque,   
            fatdiari.fact_tarjeta,   
            fatdiari.fact_transferencia,   
            fatdiari.fact_nota_de_credito,   
            fatdiari.fact_intcoterms,   
            fatdiari.fact_tipo_ventas,   
            fatdiari.fact_tipo_documento,   
            fatdiari.fact_cubicaje_total_metros,   
            fatdiari.fact_cliente_contado,   
            fatdiari.fact_pdt  
       FROM fatdiari  
      WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
            ( fatdiari.fact_empresa = :str.empresa ) AND  
            ( fatdiari.fact_tipo = :as_tipo_anterior ) AND  
            ( fatdiari.fact_no_pedido = :is_secuencia ) AND  
            ( fatdiari.fact_ann = :ii_ann )   ;

		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			gf_mensaje('','Error al Cambiar Tipo Encabezado '+ls_error,1,1,'E')
			sqlca.autocommit = true
			return false
		end if

	  UPDATE fadcargo  
		  SET dcar_tipo = :is_tipo  
		WHERE ( fadcargo.dcar_g_financiero = :str.g_financiero ) AND  
				( fadcargo.dcar_empresa = :str.empresa ) AND  
				( fadcargo.dcar_tipo = :as_tipo_anterior ) AND  
				( fadcargo.dcar_no_pedido = :is_secuencia ) AND  
				( fadcargo.dcar_ann = :ii_ann )   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			gf_mensaje('','Error al Cambiar Cargos '+ls_error,1,1,'E')
			sqlca.autocommit = true
			return false
		end if

	  UPDATE fadvenfa  
		  SET vfac_tipo = :is_tipo  
		WHERE ( fadvenfa.vfac_g_financiero = :str.g_financiero ) AND  
				( fadvenfa.vfac_empresa = :str.empresa ) AND  
				( fadvenfa.vfac_tipo = :as_tipo_anterior ) AND  
				( fadvenfa.vfac_no_pedido = :is_secuencia ) AND  
				( fadvenfa.vfac_ann = :ii_ann )   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			gf_mensaje('','Error al Cambiar Vendedor '+ls_error,1,1,'E')
			sqlca.autocommit = true
			return false
		end if
		
		
		
  UPDATE faddiari  
     SET facd_tipo = :is_tipo  
   WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
         ( faddiari.facd_empresa = :str.empresa ) AND  
         ( faddiari.facd_tipo = :as_tipo_anterior ) AND  
         ( faddiari.facd_no_pedido = :is_secuencia ) AND  
         ( faddiari.facd_ann = :ii_ann )   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			gf_mensaje('','Error al Cambiar Detalle '+ls_error,1,1,'E')
			sqlca.autocommit = true
			return false
		end if
	Delete from fatdiari
   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
         ( fatdiari.fact_empresa = :str.empresa ) AND  
         ( fatdiari.fact_tipo = :as_tipo_anterior ) AND  
         ( fatdiari.fact_no_pedido = :is_secuencia ) AND  
         ( fatdiari.fact_ann = :ii_ann )   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			gf_mensaje('','Error al Eliminar Encabezado '+ls_error,1,1,'E')
			sqlca.autocommit = true
			return false
		end if


Commit ;
sqlca.autocommit = true

dw_1.retrieve(str.g_financiero, str.empresa, is_secuencia, ii_ann )

select max(vfac_vendedor)
	into :ii_vendedor
	from fadvenfa
	where vfac_g_financiero = :str.g_financiero and
			vfac_empresa		= :str.empresa and
			vfac_tipo			= :is_tipo and
			vfac_no_pedido		= :is_secuencia and
			vfac_ann				= :ii_ann ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al validar vendedor '+sqlca.sqlerrtext,1,1,'E')
			end if
dw_1.setitem(1, 'vendedor', ii_vendedor)

dw_2.reset()
dw_2.retrieve(str.g_financiero, str.empresa, is_secuencia, ii_ann )
dw_2.scrolltorow(dw_2.rowcount())
dw_2.setfocus()

return true
end function

public function integer wf_activa_campos (boolean ab_activa);if ab_activa then
	dw_2.Modify("facd_cantidad.Protect=0")
	dw_2.Modify("facd_bultos.Protect=0")
	dw_2.Modify("facd_codigo_item.Protect=0")
	dw_2.Modify("facd_modelo.Protect=0")
	dw_2.Modify("facd_descripcion_alterna.Protect=0")
	dw_2.Modify("facd_bulto_inicio.Protect=0")
	dw_2.Modify("facd_bulto_fin.Protect=0")
	dw_2.Modify("facd_peso.Protect=0")
	dw_2.Modify("facd_cubicaje.Protect=0")
	dw_2.Modify("facd_cubicaje_metros.Protect=0")
	dw_2.Modify("facd_precio_unidad_producto.Protect=0")
else
	dw_2.Modify("facd_cantidad.Protect=1")
	dw_2.Modify("facd_bultos.Protect=1")
	dw_2.Modify("facd_codigo_item.Protect=1")
	dw_2.Modify("facd_modelo.Protect=1")
	dw_2.Modify("facd_descripcion_alterna.Protect=1")
	dw_2.Modify("facd_bulto_inicio.Protect=1")
	dw_2.Modify("facd_bulto_fin.Protect=1")
	dw_2.Modify("facd_peso.Protect=1")
	dw_2.Modify("facd_cubicaje.Protect=1")
	dw_2.Modify("facd_cubicaje_metros.Protect=1")
	dw_2.Modify("facd_precio_unidad_producto.Protect=0")
end if

//if ab_activa then
//	dw_2.Modify("facd_cantidad.Edit.DisplayOnly=No")
//	dw_2.Modify("facd_bultos.Edit.DisplayOnly=No")
//	dw_2.Modify("facd_codigo_item.Edit.DisplayOnly=No")
//	dw_2.Modify("facd_modelo.Edit.DisplayOnly=No")
//	dw_2.Modify("facd_descripcion_alterna.Edit.DisplayOnly=No")
//	dw_2.Modify("facd_bulto_inicio.Edit.DisplayOnly=No")
//	dw_2.Modify("facd_bulto_fin.Edit.DisplayOnly=No")
//	dw_2.Modify("facd_peso.Edit.DisplayOnly=No")
//	dw_2.Modify("facd_cubicaje.Edit.DisplayOnly=No")
//	dw_2.Modify("facd_cubicaje_metros.Edit.DisplayOnly=No")
//	dw_2.Modify("facd_precio_unidad_producto.Edit.DisplayOnly=No")
//else
//	dw_2.Modify("facd_cantidad.Edit.DisplayOnly=Yes")
//	dw_2.Modify("facd_bultos.Edit.DisplayOnly=Yes")
//	dw_2.Modify("facd_codigo_item.Edit.DisplayOnly=Yes")
//	dw_2.Modify("facd_modelo.Edit.DisplayOnly=Yes")
//	dw_2.Modify("facd_descripcion_alterna.Edit.DisplayOnly=Yes")
//	dw_2.Modify("facd_bulto_inicio.Edit.DisplayOnly=Yes")
//	dw_2.Modify("facd_bulto_fin.Edit.DisplayOnly=Yes")
//	dw_2.Modify("facd_peso.Edit.DisplayOnly=Yes")
//	dw_2.Modify("facd_cubicaje.Edit.DisplayOnly=Yes")
//	dw_2.Modify("facd_cubicaje_metros.Edit.DisplayOnly=Yes")
//	dw_2.Modify("facd_precio_unidad_producto.Edit.DisplayOnly=No")
//end if
//
//return 1

return 1

end function

on w_facturacion.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_6=create dw_6
this.st_1=create st_1
this.pb_1=create pb_1
this.dw_7=create dw_7
this.dw_4=create dw_4
this.dw_5=create dw_5
this.pb_2=create pb_2
this.st_2=create st_2
this.cb_3=create cb_3
this.dw_9=create dw_9
this.uo_1=create uo_1
this.dw_10=create dw_10
this.dw_11=create dw_11
this.pb_prefactura=create pb_prefactura
this.cb_4=create cb_4
this.em_total=create em_total
this.em_subtotal=create em_subtotal
this.dw_8=create dw_8
this.pb_4=create pb_4
this.dw_12=create dw_12
this.pb_entradas=create pb_entradas
this.dw_13=create dw_13
this.dw_14=create dw_14
this.cb_5=create cb_5
this.dw_15=create dw_15
this.dw_16=create dw_16
this.dw_17=create dw_17
this.cb_6=create cb_6
this.pb_3=create pb_3
this.st_3=create st_3
this.cb_7=create cb_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.dw_6
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.pb_1
this.Control[iCurrent+8]=this.dw_7
this.Control[iCurrent+9]=this.dw_4
this.Control[iCurrent+10]=this.dw_5
this.Control[iCurrent+11]=this.pb_2
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.cb_3
this.Control[iCurrent+14]=this.dw_9
this.Control[iCurrent+15]=this.uo_1
this.Control[iCurrent+16]=this.dw_10
this.Control[iCurrent+17]=this.dw_11
this.Control[iCurrent+18]=this.pb_prefactura
this.Control[iCurrent+19]=this.cb_4
this.Control[iCurrent+20]=this.em_total
this.Control[iCurrent+21]=this.em_subtotal
this.Control[iCurrent+22]=this.dw_8
this.Control[iCurrent+23]=this.pb_4
this.Control[iCurrent+24]=this.dw_12
this.Control[iCurrent+25]=this.pb_entradas
this.Control[iCurrent+26]=this.dw_13
this.Control[iCurrent+27]=this.dw_14
this.Control[iCurrent+28]=this.cb_5
this.Control[iCurrent+29]=this.dw_15
this.Control[iCurrent+30]=this.dw_16
this.Control[iCurrent+31]=this.dw_17
this.Control[iCurrent+32]=this.cb_6
this.Control[iCurrent+33]=this.pb_3
this.Control[iCurrent+34]=this.st_3
this.Control[iCurrent+35]=this.cb_7
end on

on w_facturacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_6)
destroy(this.st_1)
destroy(this.pb_1)
destroy(this.dw_7)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.cb_3)
destroy(this.dw_9)
destroy(this.uo_1)
destroy(this.dw_10)
destroy(this.dw_11)
destroy(this.pb_prefactura)
destroy(this.cb_4)
destroy(this.em_total)
destroy(this.em_subtotal)
destroy(this.dw_8)
destroy(this.pb_4)
destroy(this.dw_12)
destroy(this.pb_entradas)
destroy(this.dw_13)
destroy(this.dw_14)
destroy(this.cb_5)
destroy(this.dw_15)
destroy(this.dw_16)
destroy(this.dw_17)
destroy(this.cb_6)
destroy(this.pb_3)
destroy(this.st_3)
destroy(this.cb_7)
end on

event ue_pre_aceptar;//Override
dw_1.Accepttext()

this.postevent("ue_aceptar")

end event

event ue_adicionar;//Override
decimal{4} ld_cantidad
pb_prefactura.enabled = true

if datawindow = 1 then	
	dw_1.reset()
	dw_2.object.cargos.expression = "'"+string(0.00,'#,##0.00')+"'"	//Para blanquear los cargos
	dw_2.object.descuento.expression = "'"+string(0.00,'#,##0.00')+"'"	//Para blanquear los cargos
	dw_2.reset()
	dw_7.reset()
	dw_7.insertrow(1)
	dw_7.setitem(1,'dgmempre_empr_bodegas_definidas',ii_bodegas_definidas)
	dw_7.setitem(1,'bodega1',is_b1); dw_7.setitem(1,'bodega2',is_b2); dw_7.setitem(1,'bodega3',is_b3); dw_7.setitem(1,'bodega4',is_b4); dw_7.setitem(1,'bodega5',is_b5); dw_7.setitem(1,'bodega6',is_b6); dw_7.setitem(1,'bodega7',is_b7)
	dw_7.bringtotop = true
	dw_1.insertrow(1)
	//Pone invisible el insertar	
	dw_1.setitem(1,'fact_g_financiero',str.g_financiero)
	dw_1.setitem(1,'fact_empresa',str.empresa)
	dw_1.setitem(1,'fact_ann',ii_ann)
	dw_1.setitem(1,'fact_fecha',date(gf_fecha_serv()))
	dw_1.setitem(1,'fact_fecha_despacho',date(gf_fecha_serv()))	
	dw_1.setitem(1,'fact_tipo_venta',2) //exterior
	dw_1.setitem(1,'fact_estado','A')
	dw_1.setitem(1,'fact_act_cliente',0)
	dw_1.setitem(1,'fact_act_inventario',0)
	dw_1.setitem(1,'fact_act_conta',0)	
	dw_1.setitem(1,'fact_usuario',str.usuario)	
	dw_1.setitem(1,'fact_metal_pendiente',ii_metal_pendiente)	
	if ii_metal_pendiente = 1 then
		dw_1.setitem(1,'fact_cierre_de_metal',0)	
		dw_1.setitem(1,'fact_excluir_de_reporte',1)	
	end if
	is_tipo = idwc_tipo.getitemstring(1,'dgmsubse_subs_sub_trans')
	dw_1.setitem(1,'fact_tipo', is_tipo)
	dw_1.setfocus()
	dw_1.setcolumn('fact_ruc_cliente')
	idec_gastos = 0
	idec_descuento = 0
	//wf_orden_nueva()
	dw_1.setitem(1,'fact_pdt', 0)	
	wf_activa_campos(true)
else
	if dw_1.rowcount() > 0 then
		if (dw_1.getitemString(1,"fact_estado")) <> 'A' then
			gf_mensaje("Atencion Sr. Usuario","No se puede Modificar una Factura Actualizada, Verifique !!!.",1,1,"E")
			return
		end if	
	end if
	
	if not 	ib_usuario_consulta then //Si no es el usuario de consulta
		if dw_2.getrow() > 0 then	
			
			if ii_controla_pedido = 0 and is_estado_factura <> 'A' then
				gf_mensaje('','El Pedido ya Fue Pasado a Bodega, No Puede Adicionar Registros',1,1,'E')
				return
			end if
			
			ld_cantidad = dw_2.getitemnumber(dw_2.rowcount(), 'facd_cantidad')
			if isnull(ld_cantidad) then ld_cantidad = 0
			if ( dw_2.getitemstring(dw_2.getrow(), 'facd_codigo_item') <> '' or &
				not isnull(dw_2.getitemstring(dw_2.getrow(), 'facd_codigo_item'))) and  &
				ld_cantidad <> 0 then
				dw_2.scrolltorow(dw_2.insertrow(0))
				dw_2.setitem(dw_2.getrow(),'facd_g_financiero',str.g_financiero)
				dw_2.setitem(dw_2.getrow(),'facd_empresa',str.empresa)
				dw_2.setitem(dw_2.getrow(),'facd_usuario',str.usuario)
				//Para repetir el ultimo item capturado
	//			dw_7.retrieve(str.g_financiero, str.empresa, is_item)			
	//			dw_2.setitem(dw_2.getrow(),'facd_codigo_item',is_item)
	//			dw_2.setitem(dw_2.getrow(),'facd_descripcion_alterna',is_descrip)
	//			dw_2.setitem(dw_2.getrow(),'facd_unidad_venta',is_unidad)			
	//			dw_2.setitem(dw_2.getrow(),'facd_unidad_producto',is_unidad)		
	//			dw_2.setitem(dw_2.getrow(),'facd_precio_unidad_producto', id_precio)
	//			dw_2.setitem(dw_2.getrow(),'facd_precio_original', id_precio)			
	//			dw_2.setitem(dw_2.getrow(),'facd_costo_cif', id_costo_cif)			
	//			dw_2.setitem(dw_2.getrow(),'facd_metal_pendiente',ii_metal_pendiente)				
			end if
		else
			dw_2.scrolltorow(dw_2.insertrow(0))
			dw_2.setitem(dw_2.getrow(),'facd_g_financiero',str.g_financiero)
			dw_2.setitem(dw_2.getrow(),'facd_empresa',str.empresa)
			dw_2.setitem(dw_2.getrow(),'facd_usuario',str.usuario)		
			dw_2.setitem(dw_2.getrow(),'facd_metal_pendiente',ii_metal_pendiente)						
		end if
	end if // del 	ib_usuario_consulta = false
	dw_2.setfocus()
	if pos(str.empr_acceso_especial, 'HPSA') > 0 then
		dw_2.setcolumn('facd_modelo')
	else
		dw_2.setcolumn('facd_codigo_item')
	end if

end if

end event

event key;//override
end event

event close;This.setredraw(False)
This.hide()
This.visible = false
w_hs_frame.Post Event ue_evaluar_panel_acciones()
Window lw_frame

lw_frame = ParentWindow()

If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_sheet_closed")
 End If
if isvalid(this) then close(this)
 
end event

event ue_hay_data;//Override
end event

event resize;//Override
//dw_1.Resize(This.Width - 170, This.Height - 390)
//gb_1.width  = this.width  - 63
//gb_1.height = this.height - 180
//st_nom_ventana.x = 28
//st_nom_ventana.y = this.height - 180
dw_2.width = newwidth - 100
dw_2.height= newheight - 1120
em_total.y = newheight - 245
em_subtotal.y = newheight - 470
dw_7.y = newheight - 510
dw_17.y = newheight - 600

//dw_8.y = newheight - 250
//pb_3.y = newheight - 160
//st_3.y = newheight - 165
end event

event open;//override
This.setredraw(False)
This.visible = false
this.y = 0
this.x = 805
integer  i, li_existe
string ls_cadena
dw = dw_1
 
ii_metal_pendiente = message.doubleparm
if ii_metal_pendiente = 1 then
	this.title = 'Facturas - Metal Pendiente'
end if

This.Icon = str.icono

//this.postevent("ue_post_open")

This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)


datawindowchild ldwc_plan
string ls_dw
idec_gastos = 0
dw_1.settransobject(sqlca);			
dw_2.settransobject(sqlca);	
dw_5.settransobject(sqlca);	
dw_6.settransobject(sqlca);
dw_7.settransobject(sqlca);
dw_8.settransobject(sqlca);
dw_8.insertrow(1)
dw_12.insertrow(1)
dw_13.settransobject(sqlca);
dw_14.settransobject(sqlca);
dw_9.settransobject(sqlca);
dw_10.settransobject(sqlca);  //Total de la Orden a Facturar, para modificar si cobraran algo adicional
dw_10.insertrow(1)
dw_11.settransobject(sqlca);
dw_15.settransobject(sqlca);
dw_16.settransobject(sqlca);

dw_11.getchild('ddia_mg_cuenta', ldwc_plan)
ldwc_plan.settransobject(sqlca)
ldwc_plan.retrieve(str.g_financiero, str.empresa)
ldwc_plan.insertrow(1)

dw_13.getchild('terc_pais', idwc_pais)
idwc_pais.settransobject(sqlca)
idwc_pais.retrieve()
dw_13.getchild('terc_region', idwc_region)
idwc_region.settransobject(sqlca)
idwc_region.insertrow(1)

dw_13.insertrow(1)
dw_14.insertrow(1)
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
if idwc_formatos.retrieve(str.empresa, 'FA') = 0 Then idwc_formatos.insertrow(0)
dw_6.insertrow(1)
dw_6.setitem(1,'formato','1')
ii_ann = year(date(gf_fecha_serv()))
datawindow = 1

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
dw_4.dataobject = ls_dw
dw_4.settransobject(sqlca)

dw_1.getchild('fact_tipo', idwc_tipo)
//dw_1.getchild('fact_cliente', idwc_cliente)
dw_1.getchild('fact_ruc_cliente', idwc_cliente)
dw_1.getchild('vendedor', idwc_vendedores)
dw_1.getchild('fact_dias_pago', idwc_dias)
idwc_tipo.settransobject(sqlca)
idwc_cliente.settransobject(sqlca)
idwc_vendedores.settransobject(sqlca)
idwc_dias.settransobject(sqlca)
idwc_tipo.retrieve(str.g_financiero, str.empresa, 'FA')
if idwc_cliente.retrieve(str.g_financiero, str.empresa) = 0 Then idwc_cliente.insertrow(0)
idwc_vendedores.retrieve(str.g_financiero, str.empresa)
idwc_vendedores.insertrow(1)
idwc_dias.retrieve(str.g_financiero, str.empresa)

if idwc_tipo.retrieve(str.g_financiero, str.empresa, "FA") = 0 then
	gf_mensaje("Aviso","Sr. Usuario, Debe definir los tipos de Facturas.",1,1,'G')
	idwc_tipo.insertrow(0)
	this.Postevent("close")
end if

datawindowchild ldwc_vendedor
dw_4.getchild('fadvenfa_vfac_vendedor', ldwc_vendedor)
ldwc_vendedor.settransobject(sqlca)
ldwc_vendedor.retrieve(str.g_financiero, str.empresa)

dw_1.getchild('fact_provincia_fe',idwc_provincia)
idwc_provincia.settransobject(sqlca)
idwc_provincia.retrieve()
idwc_provincia.insertrow(1)
dw_1.getchild('fact_distrito',idwc_distrito)
idwc_distrito.settransobject(sqlca)
idwc_distrito.retrieve()
idwc_distrito.insertrow(1)
dw_1.getchild('fact_corregimiento',idwc_corregimiento)
idwc_corregimiento.settransobject(sqlca)
idwc_corregimiento.retrieve(str.g_financiero, str.empresa)
idwc_corregimiento.insertrow(1)

//this.triggerevent('ue_adicionar')

this.postevent('ue_adicionar')

//Recupera la secuencia siguiente y da opcion para buscar una
//wf_orden_nueva()

if str.contabiliza = 1 then
	  SELECT isnull(facuentas.para_cuenta_exterior,''),   
         isnull(facuentas.para_cuenta_local,''),   
         isnull(facuentas.para_cuenta_inventarios,''),   
         isnull(facuentas.para_cuenta_costos,''),   
         isnull(facuentas.fara_cuenta_costos_locales,''),
         isnull(facuentas.para_cuenta_descuento,''),
		isnull(facuentas.para_cuenta_cargos,''),
		isnull(facuentas.para_devolucion_ventas,'')	
    INTO :is_cta_ingreso_exterior,   
         :is_cta_ingreso_local,   
         :is_cta_inventarios,   
         :is_cta_costos_exterior,   
         :is_cta_costos_local,
		:is_cta_descuento,
		:is_cta_cargos,
		:is_cta_devoluciones
    FROM facuentas  
   WHERE ( facuentas.para_g_financiero = :str.g_financiero ) AND  
         ( facuentas.para_empresa = :str.empresa )   ;			
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al seleccionar fixing '+sqlca.sqlerrtext,1,1,'E')			
		end if

		if is_cta_ingreso_exterior = '' or is_cta_ingreso_local = '' or is_cta_inventarios = '' or is_cta_costos_exterior = '' or is_cta_costos_local = ''  or is_cta_descuento = '' or is_cta_cargos = '' then
			gf_mensaje('','Es Necesario Asignar las Cuentas Contables de los Asientos, para proseguir, Verifique !!!',1,1,'E')
			this.postevent('close')
		end if
	dw_2.Modify("facd_monto_final.Edit.DisplayOnly=No")			
else
	if pos(upper(str.empr_acceso_especial),'SURTI') > 0 then  
		dw_2.Modify("facd_monto_final.Edit.DisplayOnly=No")			
	else
		dw_2.Modify("facd_monto_final.Edit.DisplayOnly=Yes")		
	end if
end if
if pos(upper(str.empr_acceso_especial),'ADVANCED') > 0 then  
	em_subtotal.text = 'SUB TOTAL:'
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
dw_2.Object.facd_bodega.Values = ls_cadena

  SELECT isnull(usua_usuario_bodega,0)
    INTO :li_existe 
    FROM usuarios  
   WHERE ( usuarios.usua_id = :str.usuario ) AND  
         ( usuarios.usua_usuario_bodega = 1 )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al Validar Usuario '+sqlca.sqlerrtext,1,1,'E')
	end if
ib_usuario_consulta = false
if li_existe > 0 then
	ib_usuario_consulta = true
	dw_2.Modify("facd_cantidad.Edit.DisplayOnly=Yes")
	dw_2.Modify("facd_bultos.Edit.DisplayOnly=Yes")
	dw_2.Modify("facd_codigo_item.Edit.DisplayOnly=Yes")
	dw_2.Modify("facd_modelo.Edit.DisplayOnly=Yes")
	dw_2.Modify("facd_descripcion_alterna.Edit.DisplayOnly=Yes")
	dw_2.Modify("facd_bulto_inicio.Edit.DisplayOnly=Yes")
	dw_2.Modify("facd_bulto_fin.Edit.DisplayOnly=Yes")
	dw_2.Modify("facd_peso.Edit.DisplayOnly=Yes")
	dw_2.Modify("facd_cubicaje.Edit.DisplayOnly=Yes")
	dw_2.Modify("facd_precio_unidad_producto.Edit.DisplayOnly=Yes")		
end if


  SELECT isnull(usua_controla_pedidos,0)
    INTO  :ii_controla_pedido
    FROM usuarios  
   WHERE ( usuarios.usua_id = :str.usuario );
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al Validar Usuario '+sqlca.sqlerrtext,1,1,'E')
	end if
dw_4.Modify("DataWindow.Print.Preview.Rulers=Yes")

str.frame.setmicrohelp('Factura')
//il_tiempo = 150
//em_tiempo.text = string(150)
//timer(1)

//this.height = w_fa_fondo.height - 50


//m_fa_principal.m_edicin.m_consolidar.visible = true
//m_fa_principal.m_edicin.m_consolidar.toolbaritemvisible = true
dw_17.insertrow(1)
dw_17.bringtotop = true

w_hs_frame.Post Event ue_evaluar_panel_acciones()
This.setredraw(True)
This.visible = True
end event

event ue_print;////override
long ll_tercero
datetime ldt_fecha
string ls_saldo, ls_numero_palabra, ls_setprn, ls_estado_factura
decimal{2} ld_saldo, ld_final
datetime ldt_fecha_actual
integer li_lista_empaque
dw_1.accepttext()
dw_4.settransobject(sqlca)
if is_secuencia = '' then return

if dw_1.getitemstring(1,'fact_estado') = 'A' then
	ldt_fecha_actual = dw_1.getitemdatetime(1,'fact_fecha')
	ldt_fecha = datetime(date(gf_fecha_serv()),time('00:00:00'))
	dw_1.setitem(1,'fact_usuario_print',str.usuario)
	if ldt_fecha > ldt_fecha_actual then 
		if pos(str.empr_acceso_especial,'HPSA') > 0 then
			dw_1.setitem(1,'fact_fecha',ldt_fecha)
		end if
	end if
	this.triggerevent('ue_aceptar')
end if

dw_4.retrieve(str.g_financiero, str.empresa, is_secuencia , ii_ann)
//
if dw_4.rowcount() = 0 then return

//st_1.visible = true
//dw_6.visible = true
//Asigna el saldo del cliente

if dw_4.dataobject = 'dw_imprimir_factura_hpsa' then
	ll_tercero = dw_4.getitemnumber(1,'fact_cliente')
	ld_saldo = gf_saldo_anterior_new( ll_tercero, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)
	ls_saldo = string(ld_saldo, '$ ##,##0.00')
	if dw_4.Describe("saldo.x") <> "?" and dw_4.Describe("saldo.x") <> "!" then &
		dw_4.object.saldo.expression = "'" + ls_saldo + "'"
	end if

	//asigna el valor del monto en letras
	ld_final = dw_4.getitemnumber(1, "fact_monto_final")
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

if idec_gastos = 0 or isnull(idec_gastos) then
	if dw_4.Describe("ver_cargos.x") <> "?" and dw_4.Describe("ver_cargos.x") <> "!" then &
		dw_4.object.ver_cargos.expression = "'" + string(1) + "'"
	dw_4.Modify("dw_1.visible = false") 		
	//Para poner el titulo de subtotal y total
	if dw_4.Describe("t_subtotal.x") <> "?" and dw_4.Describe("t_subtotal.x") <> "!" then &
			dw_4.object.t_subtotal.text = em_subtotal.text
	if dw_4.Describe("t_total.x") <> "?" and dw_4.Describe("t_total.x") <> "!" then &
			dw_4.object.t_total.text = em_total.text
	if dw_4.Describe("t_total2.x") <> "?" and dw_4.Describe("t_total2.x") <> "!" then &
			dw_4.object.t_total2.text = em_total.text
else
	if dw_4.Describe("ver_cargos.x") <> "?" and dw_4.Describe("ver_cargos.x") <> "!" then &
		dw_4.object.ver_cargos.expression = "'" + string(0) + "'"
	dw_4.Modify("dw_1.visible = true") 
	//Para poner el titulo de subtotal y total
	str.subtotal = em_subtotal.text
	str.total = em_total.text
//	str.porc = dw_1.getitemnumber(1,'porc')   //Se asigna el subtotal en la funcion recalcula factura
end if

if dw_1.getitemnumber(1,'porc') <> 0 then 
	wf_recalcula_factura()
else
	str.porc = 0
end if

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

li_lista_empaque = idwc_formatos.getitemnumber(idwc_formatos.getrow(),'lista_empaque')
if li_lista_empaque = 1 then
	
   SELECT isnull(fact_estado_factura,'A')
	  into :ls_estado_factura
	  FROM fatdiari
   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
         ( fatdiari.fact_empresa = :str.empresa ) AND  
         ( fatdiari.fact_no_pedido = :is_secuencia ) AND  
         ( fatdiari.fact_ann = :ii_ann ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Buscar Estado '+sqlca.sqlerrtext,1,1,'E')
		end if
	if ls_estado_factura = 'A' then
		if gf_mensaje('','Pedido Enviado a Bodega ?',2,1,'Q')  = 1 then
		  UPDATE fatdiari  
			  SET fact_estado_factura = 'B'  
			WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
					( fatdiari.fact_empresa = :str.empresa ) AND  
					( fatdiari.fact_no_pedido = :is_secuencia ) AND  
					( fatdiari.fact_ann = :ii_ann )  AND
				(( isnull(fact_estado_factura,'') = ''  or fact_estado_factura = 'A' ) )	;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Actualizar Estado '+sqlca.sqlerrtext,1,1,'E')
			end if
			dw_1.setitem(1,'fact_estado_factura', 'B')
			is_estado_factura = 'B'
		end if
	end if
end if

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
//if dw_1.getitemstring(1,'fact_tipo_movimiento') <> 'O' then
//	cb_3.triggerevent('clicked')
//end if
/********************/
PrintSetPrinter (str.printer1)
dw_1.setfocus()
datawindow = 1
//this.triggerevent('ue_adicionar')
end event

event ue_aceptar;integer  li_contador,ll_update,ll_update2,li_encontro,li_lin_ref,li_posicion,li_frac2, li_find, li_existe, li_fraccion
integer  li_costo,anulado=0,li_linea_uno,li_linea_dos,indice, li_existe_detalle, li_empresa ,li_salvar
decimal  li_cantidad,li_cantid, li_cos_tran, ld_cantidad
datetime ldt_fecha,ldt_fecha_real
string   ls_documento,ls_aplic,ls_tipo,ls_medida,ls_producto,ls_concepto, fila, ls_conc,ls_error,ls_cuenta, ls_expresion, ls_doc
Long		ll_found, ll_ann,ll_secuencia, ll_bultos, ll_lter 
boolean  lb_existe, lb_entro, lb_borrar
decimal{2} ldec_monto, ld_limite, ld_saldo, ld_porc
decimal{3} ld_peso, ld_cubicaje, ld_cubicaje_metros

dw_1.acceptText()
dw_2.acceptText()
//dw=dw_1  

if (dw_1.getitemNumber(1,"fact_cliente")) = 0 or isnull(dw_1.getitemNumber(1,"fact_cliente")) then
	gf_mensaje("Atencion Sr. Usuario","Debe asignar el cliente antes de guardar.",1,1,'E')
	dw_1.setcolumn("fact_cliente")
	return
end if	

if (dw_1.getitemString(1,"fact_tipo")) = '' or isnull(dw_1.getitemString(1,"fact_tipo")) then
	gf_mensaje("Atencion Sr. Usuario","Debe asignar el Tipo de Factura antes de guardar.",1,1,"E")
	dw_1.setcolumn("fact_tipo")
	return
end if	

if (dw_1.getitemString(1,"fact_estado")) <> 'A' then
	gf_mensaje("Atencion Sr. Usuario","No se puede Modificar una Factura Actualizada, Verifique !!!.",1,1,"E")
	return
end if	

if isnull(dw_1.getitemNumber(1,"fact_dias_pago")) then
	gf_mensaje("Atencion Sr. Usuario","Debe asignar el Termino de Pago antes de guardar.",1,1,'E')
	dw_1.setcolumn("fact_dias_pago")
	return
end if	

if isnull(dw_1.getitemstring(1,"fact_intcoterms")) then
	gf_mensaje("Atencion Sr. Usuario","Debe asignar el Intcoterms antes de guardar.",1,1,'E')
	dw_1.setcolumn("fact_intcoterms")
	return
end if	

sqlca.autocommit = false

indice = 0

ls_documento = dw_1.getitemstring(1,"fact_no_pedido")
is_secuencia = ls_documento
/*grabamos los datos del DW_1 de la tabla de INTMOVIM*////////////////
if dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = New! or &
	dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = NewModified! then 	
	
   indice = 1
	
	if (dw_1.getitemString(1,"fact_no_pedido")) = '' or isnull(dw_1.getitemString(1,"fact_no_pedido")) then
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
		 FROM fatdiari  
	   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
				( fatdiari.fact_empresa = :str.empresa ) AND  
				( fatdiari.fact_no_pedido = :is_secuencia ) AND  
				( fatdiari.fact_ann = :ii_ann ) ;
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
		dw_1.setitem(1,'fact_no_pedido',is_secuencia)
	   //Si se busca el numero de documento y existe, debe asignar el nuevo documento en el detalle de facturas y articulos
	end if
	
	
	/*Actualiza el Encabezado*/
	ll_update = dw_1.update()
	
	/*Actualiza la Secuencia en Dgmserie*/
	if ll_update =1 then
		 wf_asigna_vendedor()				 
		 wf_actualiza_prefactura('I')
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
	 ld_cubicaje_metros = dw_2.getitemnumber(1,'cubicaje_metros_total')
  else
	 ldec_monto  = 0
	 ld_peso 	 = 0
	 ld_cubicaje = 0
	 ll_bultos   = 0
	 ld_cubicaje_metros = 0
  end if

  //Actualiza el total de peso, cubicaje y bultos
  if not ib_usuario_consulta then  // Si no es el usuario de consulta
    UPDATE fatdiari  
     SET fact_bultos_total = :ll_bultos,   
         fact_cubicaje_total = :ld_cubicaje,   
         fact_peso_total = :ld_peso,
		fact_cubicaje_total_metros = :ld_cubicaje_metros
   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
         ( fatdiari.fact_empresa = :str.empresa ) AND  
         ( fatdiari.fact_no_pedido = :is_secuencia ) AND  
         ( fatdiari.fact_ann = :ii_ann ) ;
	if sqlca.sqlcode = -1 then
			ls_error =sqlca.sqlerrtext
		rollback using sqlca;
		sqlca.autocommit = true
		ib_aceptar = False
		gf_Mensaje("---Atención---","¡Error al Actualizar el encabezado / Totales! "+ls_error,1,1,'E')
		is_actualiza=''
		return
	end if  
  end if

  dw_1.setitem(1,'fact_monto_fact_total',ldec_monto)
  if isnull(idec_gastos) then idec_gastos = 0 
  if isnull(idec_descuento) then idec_descuento = 0 
  dw_1.setitem(1,'fact_monto_final',ldec_monto + idec_gastos - idec_descuento)
  dw_1.accepttext()	
  ll_update = dw_1.update()
  if ll_update = 1 then
		wf_asigna_vendedor()	
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
//	ll_secuencia = long(dw_1.getitemstring(1,'no_orden'))
end if

sqlca.autocommit = false

/*grabamos los datos de DW_2 en la tabla INDTRANS*/
dwItemStatus ls_status
// Borra registros en blanco

for li_contador = 1 to dw_2.rowcount()
	ls_producto = dw_2.getitemstring(li_contador,"facd_codigo_item")
	ld_cantidad = dw_2.getitemnumber(li_contador,"facd_cantidad")
	li_fraccion	= dw_2.getitemnumber(li_contador,"facd_cantidad_fraccion")
	lb_borrar = true
	if ld_cantidad = 0.00 or isnull(ld_cantidad) then
		if li_fraccion = 0.00 or isnull(li_fraccion) then
			lb_borrar = true
		else
			lb_borrar = false
		end if
	else
		lb_borrar = false
	end if
	if ls_producto = "" or isnull(ls_producto) or lb_borrar then
		dw_2.deleterow(li_contador)
		li_contador --
	End If
	dw_2.setitem(li_contador,'facd_g_financiero',str.g_financiero)
	dw_2.setitem(li_contador,'facd_empresa',str.empresa)
	dw_2.setitem(li_contador,'facd_tipo',is_tipo)
	dw_2.setitem(li_contador,'facd_no_pedido',is_secuencia)
	dw_2.setitem(li_contador,'facd_ann',ii_ann)
	dw_2.setitem(li_contador,"facd_linea",li_contador)		
	dw_2.setitem(li_contador,"facd_index",li_contador)
	dw_2.setitem(li_contador,"facd_usuario",str.usuario)		
	
Next
//
li_salvar=1

If li_salvar = 1 and not ib_usuario_consulta  then //Si todas las bodegas/ubicacion destino existen que salve
													
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
		  
			 update fatdiari set fact_costos_total =
		 (select sum(faddiari.facd_costo_total)
			from faddiari
			 where (faddiari.facd_g_financiero = fatdiari.fact_g_financiero) and
					 (faddiari.facd_empresa = fatdiari.fact_empresa) and
					 (faddiari.facd_tipo = fatdiari.fact_tipo) and
					 (faddiari.facd_no_pedido = fatdiari.fact_no_pedido) and
					 (faddiari.facd_ann = fatdiari.fact_ann ) )
			where (fatdiari.fact_g_financiero = :str.g_financiero ) and
					(fatdiari.fact_empresa = :str.empresa) and
					(fatdiari.fact_no_pedido = :is_secuencia ) and
					(fatdiari.fact_ann = :ii_ann ) ;
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

		  if ib_rebajar_pedido then //SI VIENE DE PASE DE PEDIDOS
		  	if not wf_rebaja_pedido() then
				ls_error =sqlca.sqlerrtext
				rollback using sqlca;
				sqlca.autocommit = true
				gf_Mensaje("---Atención---","¡Error al Actualizar Cantidades Pasadas ! "+ls_error,1,1,'E')
				ib_aceptar = False
				is_actualiza=''
				return						
			 end if
		  end if

		  if ib_rebajar_proforma then //SI VIENE DE PASE DE PROFORMAS
		  	if not wf_rebaja_proforma() then
				ls_error =sqlca.sqlerrtext
				rollback using sqlca;
				sqlca.autocommit = true
				gf_Mensaje("---Atención---","¡Error al Actualizar Cantidades Pasadas ! "+ls_error,1,1,'E')
				ib_aceptar = False
				is_actualiza=''
				return						
			 end if
		  end if
		  
		  if ib_rebaja_entrada then //SI VIENE DE PASE DE ENTRADAS
		  	if not wf_rebaja_entrada() then
				ls_error =sqlca.sqlerrtext
				rollback using sqlca;
				sqlca.autocommit = true
				gf_Mensaje("---Atención---","¡Error al Actualizar Cantidades Entradas Pasadas ! "+ls_error,1,1,'E')
				ib_aceptar = False
				is_actualiza=''
				return						
			 end if
		  end if

		  /* Refresca los datos del datawindows cuando la Actualizacion fue correcta */
		  dw_1.setredraw(false)
		  dw_2.setredraw(false)				
		  long ll_fila
		  ll_fila = dw_2.getrow()
		  ld_limite = dw_1.getitemnumber(1,'limite')
		  ld_porc = dw_1.getitemnumber(1,'porc')
		  if dw_1.retrieve(str.g_financiero, str.empresa, is_secuencia, ii_ann ) > 0 then
			dw_1.setitem(dw_1.getrow(),'porc',ld_porc)
			dw_1.setitem(dw_1.getrow(),'vendedor',ii_vendedor)
			ll_lter = dw_1.getitemnumber(1,'fact_cliente')
			ld_saldo = gf_saldo_anterior_new( ll_lter, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)		
			if isnull(ld_saldo) then ld_saldo = 0.00
			dw_1.setitem(1,'saldo',ld_saldo)
			if ld_limite = 0 then
				ld_limite = idwc_cliente.getitemnumber(idwc_cliente.getrow(), 'clie_limite_credito')						
			end if
			dw_1.setitem(1,'limite',ld_limite)	
			if dw_13.retrieve(ll_lter) = 0 then dw_13.insertrow(1)		
			if dw_14.retrieve(ll_lter) = 0 then dw_14.insertrow(1)	
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
		  
		  str.frame.setmicrohelp('Factura Guardada.')
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

pb_prefactura.enabled = true

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

	lstr_df.texto_campo [1,1] = "fatdiari.fact_no_factura"
	lstr_df.texto_campo [1,2] = "Factura"
	lstr_df.texto_campo [1,3] = ""
	lstr_df.texto_campo [1,4] = 'V'
	lstr_df.texto_campo [1,5] = '320'	
	lstr_df.texto_campo [2,1] = "fatdiari.fact_no_pedido"
	lstr_df.texto_campo [2,2] = "Pedido"
	lstr_df.texto_campo [2,3] = "fact_no_pedido"
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '220'	
	lstr_df.texto_campo [3,1] = "fatdiari.fact_a_nombre"
	lstr_df.texto_campo [3,2] = "A Nombre de"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [3,5] = '690'
	lstr_df.texto_campo [4,1] = "fatdiari.fact_fecha"
	lstr_df.texto_campo [4,2] = "Fecha"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '285'
	lstr_df.texto_campo [5,1] = "case fatdiari.fact_estado when 'E' then 'ANULADA' when 'I' then 'IMPRESA' when 'P' then 'PASADO' else 'PENDIENTE' end fact_estado"
	lstr_df.texto_campo [5,2] = "Estado"
	lstr_df.texto_campo [5,3] = ""
	lstr_df.texto_campo [5,4] = 'V'
	lstr_df.texto_campo [5,5] = '285'
	lstr_df.texto_campo [6,1] = "fact_monto_final"
	lstr_df.texto_campo [6,2] = "Monto"
	lstr_df.texto_campo [6,3] = ""
	lstr_df.texto_campo [6,4] = 'V'
	lstr_df.texto_campo [6,5] = '285'	
	lstr_df.texto_campo [7,1] = "case fatdiari.fact_nota_credito when 1 then 'SI' else 'NO' end fact_nota_credito"
	lstr_df.texto_campo [7,2] = "Nota Cr."
	lstr_df.texto_campo [7,3] = ""
	lstr_df.texto_campo [7,4] = 'V'
	lstr_df.texto_campo [7,5] = '180'
	lstr_df.texto_campo [8,1] = "fact_ruc_cliente"
	lstr_df.texto_campo [8,2] = "Cuenta"
	lstr_df.texto_campo [8,3] = ""
	lstr_df.texto_campo [8,4] = 'V'
	lstr_df.texto_campo [8,5] = '305'
	lstr_df.texto_campo [9,1] = "(select t.terc_descripcion from dgmterce t where t.terc_tercero = fatdiari.fact_cliente) nombre_cliente"
	lstr_df.texto_campo [9,2] = "Nombre Cliente"
	lstr_df.texto_campo [9,3] = ""
	lstr_df.texto_campo [9,4] = 'V'
	lstr_df.texto_campo [9,5] = '985'
	
	lstr_df.tabla = " fatdiari "
		
	lstr_df.tabla_where = &
				"WHERE (fatdiari.fact_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(fatdiari.fact_empresa = " + string(str.empresa) + ") 	and " +&
 						 "(fatdiari.fact_ann = " + string(ii_ann) + ") and " + &
						 "(fatdiari.fact_estado <> 'P' )" 						 
	
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
	is_tipo = dw_1.getitemstring(1,'fact_tipo')
	select max(vfac_vendedor)
	into :ii_vendedor
	from fadvenfa
	where vfac_g_financiero = :str.g_financiero and
			vfac_empresa		= :str.empresa and
			vfac_tipo			= :is_tipo and
			vfac_no_pedido		= :is_secuencia and
			vfac_ann				= :ii_ann ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al validar vendedor '+sqlca.sqlerrtext,1,1,'E')
			end if
	dw_1.setitem(1, 'vendedor', ii_vendedor)
	idec_gastos = dw_1.getitemnumber(dw_1.getrow(),'fact_gastos_total')
	dw_2.object.cargos.expression = "'"+string(idec_gastos,'##0.00')+"'"	
	idec_descuento = dw_1.getitemnumber(dw_1.getrow(),'fact_por_descuento')
	dw_2.object.descuento.expression = "'"+string(idec_descuento,'##0.00')+"'"	
	ll_lter = dw_1.getitemnumber(1,'fact_cliente')
	ld_saldo = gf_saldo_anterior_new( ll_lter, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)		
	if isnull(ld_saldo) then ld_saldo = 0.00
	dw_1.setitem(1,'saldo',ld_saldo)
	is_estado_factura = dw_1.getitemstring(1,'fact_estado_factura')
	if is_estado_factura <> 'A' then
		if ii_controla_pedido = 1  then
			wf_activa_campos(true)
		else
			wf_activa_campos(false)		
		end if
	else
		wf_activa_campos(true)
	end if
	ll_fila = idwc_cliente.find('terc_tercero = '+string(ll_lter),1,idwc_cliente.rowcount())
	if ll_fila > 0 then
		idwc_cliente.scrolltorow(ll_fila)
	end if

	ld_limite = idwc_cliente.getitemnumber(idwc_cliente.getrow(), 'clie_limite_credito')						
	dw_1.setitem(1,'limite',ld_limite)		
	if dw_13.retrieve(ll_lter) = 0 then dw_13.insertrow(1)		
	if dw_14.retrieve(ll_lter) = 0 then dw_14.insertrow(1)		
end if
dw_2.reset()
dw_2.retrieve(str.g_financiero, str.empresa, ls_codigo, ii_ann )
is_item = ''
dw_2.scrolltorow(dw_2.rowcount())
dw_2.setfocus()
end event

event ue_eliminar;//
//override
if datawindow = 1 and not ib_usuario_consulta then	
	if dw_1.getitemstring(1,'fact_estado') <> 'A' then
		gf_mensaje('','No Puede Eliminar una Factura Actualizada, Verifique !!!',1,1,'E')
		return
	end if
	if gf_mensaje('','Esta Seguro de Eliminar la Factura ?',2,2,'E') = 1 then
		
		if ii_controla_pedido = 0 and is_estado_factura <> 'A' then
			gf_mensaje('','El Pedido ya Fue Pasado a Bodega, No Puede Eliminarlo',1,1,'E')
			return
		end if
		
		sqlca.autocommit = false
	    DELETE FROM faddiari  
			WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
					( faddiari.facd_empresa = :str.empresa ) AND  
					( faddiari.facd_no_pedido = :is_secuencia ) AND  
					( faddiari.facd_ann = :ii_ann ) ;

			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al eliminar detalle ' + sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if

		  DELETE FROM fadcargo  
			WHERE ( fadcargo.dcar_g_financiero = :str.g_financiero ) AND  
					( fadcargo.dcar_empresa = :str.empresa ) AND  
					( fadcargo.dcar_no_pedido = :is_secuencia ) AND  
					( fadcargo.dcar_ann = :ii_ann ) ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al eliminar gastos ' + sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if

	  DELETE FROM fadvenfa  
		WHERE ( fadvenfa.vfac_g_financiero = :str.g_financiero ) AND  
				( fadvenfa.vfac_empresa = :str.empresa ) AND  
				( fadvenfa.vfac_no_pedido = :is_secuencia ) AND  
				( fadvenfa.vfac_ann = :ii_ann ) ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al eliminar Vendedor ' + sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if

		  DELETE FROM fatdiari  
			WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
					( fatdiari.fact_empresa = :str.empresa ) AND  
					( fatdiari.fact_no_pedido = :is_secuencia ) AND  
					( fatdiari.fact_ann = :ii_ann )  ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al eliminar encabezado ' + sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if
			
			//Para habilitar la PreFactura si se elimina la factura
			wf_actualiza_prefactura('F')
			
			commit;
			sqlca.autocommit = true
			this.triggerevent('ue_adicionar')			
	end if
else
	if not ib_usuario_consulta then
		if dw_2.rowcount() > 0 then
			
			if ii_controla_pedido = 0 and is_estado_factura <> 'A' then
				gf_mensaje('','El Pedido ya Fue Pasado a Bodega, No Puede Eliminarlo Registros',1,1,'E')
				return
			end if

			dw_2.deleterow(dw_2.getrow())
		else 
			messagebox("Atención","No hay registros para borrar!")
		end if
	end if
end if
end event

event activate;call super::activate;long ll_cliente, ll_fila
if dw_1.rowcount() > 0 then 
	ll_cliente = dw_1.getitemnumber(1,'fact_cliente')
end if

idwc_cliente.retrieve(str.g_financiero, str.empresa)

if ll_cliente <> 0 and not isnull(ll_cliente) then
ll_fila = idwc_cliente.find('terc_tercero = '+string(ll_cliente),1,idwc_cliente.rowcount())
	if ll_fila > 0 then
		idwc_cliente.scrolltorow(ll_fila)
	end if
end if

end event

event ue_save_as;//override
integer li_respuesta
string ls_path
//ls_title = this.title

li_respuesta = gf_mensaje('','Yes = Salvar a Excel, No = Otro Formato o Cancelar',4,1,'Q')

long ll_tercero
datetime ldt_fecha
string ls_saldo, ls_numero_palabra, ls_setprn
decimal{2} ld_saldo, ld_final
datetime ldt_fecha_actual
dw_1.accepttext()
dw_4.settransobject(sqlca)
if is_secuencia = '' then return

if dw_1.getitemstring(1,'fact_estado') = 'A' then
	ldt_fecha_actual = dw_1.getitemdatetime(1,'fact_fecha')
	ldt_fecha = datetime(date(gf_fecha_serv()),time('00:00:00'))
	dw_1.setitem(1,'fact_usuario_print',str.usuario)
	if ldt_fecha > ldt_fecha_actual then 
		if pos(str.empr_acceso_especial,'HPSA') = 0 then
			dw_1.setitem(1,'fact_fecha',ldt_fecha)
		end if
	end if
	this.triggerevent('ue_aceptar')
end if

dw_4.retrieve(str.g_financiero, str.empresa, is_secuencia , ii_ann)
//
if dw_4.rowcount() = 0 then return

//st_1.visible = true
//dw_6.visible = true
//Asigna el saldo del cliente

if dw_4.dataobject = 'dw_imprimir_factura_hpsa' then
	ll_tercero = dw_4.getitemnumber(1,'fact_cliente')
	ld_saldo = gf_saldo_anterior_new( ll_tercero, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)
	ls_saldo = string(ld_saldo, '$ ##,##0.00')
	if dw_4.Describe("saldo.x") <> "?" and dw_4.Describe("saldo.x") <> "!" then &
		dw_4.object.saldo.expression = "'" + ls_saldo + "'"
	end if

	//asigna el valor del monto en letras
	ld_final = dw_4.getitemnumber(1, "fact_monto_final")
	ls_numero_palabra = " *** "+upper(gf_numerlet( round(ld_final,2)  ,1))+" ***"
	//if simple
	if dw_4.Describe("num_palabra.x") <> "?" and dw_4.Describe("num_palabra.x") <> "!" then &
		dw_4.object.num_palabra.expression = "'" + ls_numero_palabra + "'"

	
dw_4.object.datawindow.print.preview = 'yes'
dw_4.object.datawindow.print.preview.zoom = 100
dw_4.object.nom_empresa.expression = "'"+str.nombre_empresa+"'"
//

if dw_4.Describe("ver.x") <> "?" and dw_4.Describe("ver.x") <> "!" then &
	dw_4.object.ver.expression = "'" + string(1) + "'"

if idec_gastos = 0 or isnull(idec_gastos) then
	if dw_4.Describe("ver_cargos.x") <> "?" and dw_4.Describe("ver_cargos.x") <> "!" then &
		dw_4.object.ver_cargos.expression = "'" + string(1) + "'"
	dw_4.Modify("dw_1.visible = false") 		
	//Para poner el titulo de subtotal y total
	if dw_4.Describe("t_subtotal.x") <> "?" and dw_4.Describe("t_subtotal.x") <> "!" then &
			dw_4.object.t_subtotal.text = em_subtotal.text
	if dw_4.Describe("t_total.x") <> "?" and dw_4.Describe("t_total.x") <> "!" then &
			dw_4.object.t_total.text = em_total.text
	if dw_4.Describe("t_total2.x") <> "?" and dw_4.Describe("t_total2.x") <> "!" then &
			dw_4.object.t_total2.text = em_total.text
else
	if dw_4.Describe("ver_cargos.x") <> "?" and dw_4.Describe("ver_cargos.x") <> "!" then &
		dw_4.object.ver_cargos.expression = "'" + string(0) + "'"
	dw_4.Modify("dw_1.visible = true") 
	//Para poner el titulo de subtotal y total
	str.subtotal = em_subtotal.text
	str.total = em_total.text
//	str.porc = dw_1.getitemnumber(1,'porc')   //Se asigna el subtotal en la funcion recalcula factura
end if

if dw_1.getitemnumber(1,'porc') <> 0 then 
	wf_recalcula_factura()
else
	str.porc = 0
end if

dw_4.object.datawindow.print.preview = 'yes'

dw_4.visible = true

string ls_result
ls_result = dw_4.Describe('mantener.expression')
if ls_result = "'1'" then
	if dw_4.Describe("ver.x") <> "?" and dw_4.Describe("ver.x") <> "!" then &
		dw_4.object.ver.expression = "'" + string(1) + "'"
else
	if dw_4.Describe("ver.x") <> "?" and dw_4.Describe("ver.x") <> "!" then &
		dw_4.object.ver.expression = "'" + string(0) + "'"
end if


if dw_4.Describe("ver.x") <> "?" and dw_4.Describe("ver.x") <> "!" then &
	dw_4.object.ver.expression = "'" + string(1) + "'"

choose case li_respuesta
	case 1
		ls_path = nv_f.of_browseforfolder("Guardar Excel en ..",true)
		If Len(Trim(ls_path)) > 0 then		
			uf_save_dw_as_excel(dw_4,ls_path+'\'+this.title+'.xls')
		End If
	case 2
		dw_4.saveas()
end choose

end event

event closequery;call super::closequery;This.Hide()
This.SetRedraw(False)

end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_facturacion
boolean visible = false
integer x = 46
integer y = 2040
integer width = 101
string text = ""
end type

type dw_1 from w_fa_padre`dw_1 within w_facturacion
event ue_escape pbm_dwescape
event ue_enter pbm_dwnprocessenter
integer x = 27
integer y = 12
integer width = 4366
integer height = 1056
integer taborder = 10
string dataobject = "dw_encab_factura"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event dw_1::ue_escape;//Override
////Codigo de Escape
//close(parent)
////parent.triggerevent("closequery")
////messagebox("Escape","Entro ...")
end event

event dw_1::ue_enter;Send(Handle(this),256,9,Long(0,0))
RETURN 1 

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
	CASE 'fact_cliente_t'
		this.Modify("fact_cliente_t.Font.Underline='1'")
		this.Modify("fact_cliente_t.Color='63743'")
	CASE ELSE
		this.Modify("fact_cliente_t.Font.Underline='0'")
		this.Modify("fact_cliente_t.Color='16316664'")

END CHOOSE
end event

event dw_1::buttonclicked;call super::buttonclicked;long ll_codigo, ll_max
integer li_encontro, li_ann
this.accepttext()

if dwo.name = 'b_copiar' then
	
	if dw_2.rowcount() = 0 then return
	li_ann = year(date(gf_fecha_serv()))
	
	select max(convert(numeric(10), fact_no_pedido ))
	into	:ll_max
	from fatdiari
	where fact_g_financiero = :str.g_financiero and
			fact_empresa		= :str.empresa and
			fact_ann				= :li_ann and
			fact_pdt = 0;
		if sqlca.sqlcode = -1  then
			gf_mensaje('','Error al Buscar Secuencia '+sqlca.sqlerrtext,1,1,'E')		
			return
		end if
		
		if isnull(ll_max) then ll_max = 0		
		ll_max ++
		dw_12.setitem(1,'pedido',string(ll_max))
		dw_12.visible = true
		dw_2.modify('copiar.visible=true')
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
		lstr_df.texto_campo [1,2] = "Nombre del Cliente"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '700'		
		lstr_df.texto_campo [4,1] = "dgmterce.terc_tercero"
		lstr_df.texto_campo [4,2] = "Tercero"
		lstr_df.texto_campo [4,3] = ""
		lstr_df.texto_campo [4,4] = 'I'
		lstr_df.texto_campo [3,1] = "dgapais.pais_descripcion"
		lstr_df.texto_campo [3,2] = "País"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [3,5] = '550'
		
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

	dw_1.setitem(1,'fact_ruc_cliente',ls_codigo1)
	dw_1.accepttext()
	dw_1.setcolumn('fact_ruc_cliente')
	dw_1.trigger event itemchanged(1,object,ls_codigo1)

elseif dwo.name = 'b_buscar' then
	parent.triggerevent('ue_busqueda')
end if
end event

event dw_1::clicked;datawindow = 1

//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto, ls_column, ls_factura, ls_codigo
integer li_pos , li_ann_nc
date 	ld_date,ld_ini_date, ld_hoy
string ls_cadena
integer li_retorno

accepttext()

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)
is_sucursal = '0001'
ls_column = dwo.name
if ls_column = 'estado' then
	
	ls_factura = dw_1.getitemstring(1,'fact_no_factura')
	if dw_15.retrieve(str.g_financiero, str.empresa, is_sucursal, is_secuencia, ii_ann, ls_factura) > 0 then
		dw_15.visible = true
	end if

elseif ls_column = 'fact_cliente_t' then
	
	if row = 0  then return
	str_cc_formatos str_formato1		
	str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	str_formato1.tercero = dw_1.getitemNumber(1,"fact_cliente")
	Opensheetwithparm(w_estadocuenta,str_formato1,str.frame,2,original!)
elseif ls_column ='calendario' then
	ld_ini_date=date(dw_1.GetItemDateTime(dw_1.getrow(),"fact_fecha"))
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
elseif ls_column = 'b_nc' then
	//
		String  ls_find
		integer li_c, li_b, li_ann_prefactura
		long    ll_lter, ll_fila
		string  ls_lter,ls_des
		decimal{2} ld_saldo, ld_limite
		Datawindow        dww
		str_dg_dynamic_find	lstr_df
		
			lstr_df.texto_campo [1,1] = "fatdiari.fact_no_factura"
			lstr_df.texto_campo [1,2] = "Factura"
			lstr_df.texto_campo [1,3] = ""
			lstr_df.texto_campo [1,4] = 'V'
			lstr_df.texto_campo [1,5] = '250'	
			lstr_df.texto_campo [2,1] = "fatdiari.fact_a_nombre"
			lstr_df.texto_campo [2,2] = "A Nombre de"
			lstr_df.texto_campo [2,3] = ""
			lstr_df.texto_campo [2,4] = 'V'
			lstr_df.texto_campo [2,5] = '650'
			lstr_df.texto_campo [3,1] = "fatdiari.fact_fecha"
			lstr_df.texto_campo [3,2] = "Fecha"
			lstr_df.texto_campo [3,3] = ""
			lstr_df.texto_campo [3,4] = 'V'
			lstr_df.texto_campo [3,5] = '285'
			lstr_df.texto_campo [4,1] = "fatdiari.fact_monto_final"
			lstr_df.texto_campo [4,2] = "Valor"
			lstr_df.texto_campo [4,3] = ""
			lstr_df.texto_campo [4,4] = 'V'
			lstr_df.texto_campo [4,5] = '220'	
			lstr_df.texto_campo [5,1] = "fatdiari.fact_no_pedido"
			lstr_df.texto_campo [5,2] = "Pedido"
			lstr_df.texto_campo [5,3] = "fact_no_pedido"
			lstr_df.texto_campo [5,4] = 'V'
			lstr_df.texto_campo [5,5] = '250'	
			
			lstr_df.tabla = " fatdiari "
				
			lstr_df.tabla_where = &
						"WHERE (fatdiari.fact_g_financiero = " + string(str.g_financiero) + ") and " +&
								 "(fatdiari.fact_empresa = " + string(str.empresa) + ") 	and " +&
								 "(fatdiari.fact_ann = " + string(ii_ann) + ") 	and " +&
								 "(fatdiari.fact_estado = 'I' ) and (fatdiari.fact_nota_credito = 0)"		 
			
			OpenWithParm(w_dg_a_custom_find, lstr_df)
			ls_find = Message.StringParm
		
		If len (ls_find) = 0 Then Return
			
		ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
		gf_replace_cadena(ls_codigo,"'"," ")
		ls_codigo = Trim(ls_codigo)
		
		if ls_codigo <> '' then
			
				 SELECT isnull(max(fatdiari.fact_no_factura),'')
					 INTO :ls_factura  
					 FROM fatdiari  
					WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
							( fatdiari.fact_empresa = :str.empresa ) AND  
							( fatdiari.fact_no_pedido = :ls_codigo ) AND  
							( fatdiari.fact_ann = :ii_ann ) AND
							( fatdiari.fact_estado = 'I' )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Seleccionar Registro '+sqlca.sqlerrtext,1,1,'E')
						return
					end if
					if ls_factura = '' then
						gf_mensaje('','No se pudo recuperar el numero de factura, Verifique',1,1,'E')
						return
					end if	
					
			this.setitem(1,'fact_factura_referencia', ls_factura)
			this.setitem(1,'fact_ann_fact_referencia',ii_ann)
			
			wf_asigna_factura_nc(ls_factura, ii_ann, ls_codigo)	
			
		end if
	
end if

end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;datawindow = 1
this.selecttext(1,100)
this.accepttext()
integer li_provincia, li_distrito
choose case dwo.name
	case 'fact_distrito'
		li_provincia = this.getitemnumber(1,'fact_provincia_fe')
		idwc_distrito.setfilter('codprovincia = '+string(li_provincia))
		idwc_distrito.filter()
	case 'fact_corregimiento'
		li_provincia = this.getitemnumber(1,'fact_provincia_fe')
		li_distrito = this.getitemnumber(1,'fact_distrito')
		idwc_corregimiento.setfilter('codprovincia = '+string(li_provincia)+ ' and coddistrito = '+string(li_distrito))
		idwc_corregimiento.filter()
		
end choose

end event

event dw_1::itemchanged;call super::itemchanged;string ls_columna, ls_nombre, ls_pasaporte, ls_codigo, ls_caracter, ls_factura, ls_pedido_encontrado, ls_factura_anterior
integer i, li_termino_pago, li_existe, li_ann_anterior, li_nc
long    ll_tercero, ll_fila, ll_lter
decimal{2} ld_saldo, ld_limite, ldec_monto, ldec_final
datetime ldt_fecha_tran, ldt_fecha_anterior
string ls_descrip1, ls_descrip2, ls_descrip3, ls_tipo_cliente, ls_ruc, ls_tipo_fact, ls_dv, ls_estado, ls_tipo_anterior
integer li_vendedor, li_dias, li_provincia, li_distrito, li_corregimiento, li_traspaso
date   ldt_fecha_plazo
this.accepttext()

ls_columna = this.getcolumnname()
ls_estado = this.getitemstring(1,'fact_estado')

choose case ls_columna
	case 'fact_tipo'
		is_tipo = dw_1.getitemstring(1,'fact_tipo')
		dw_2.retrieve(str.g_financiero, str.empresa, is_secuencia, ii_ann )
		if dw_2.rowcount() > 0  then
				if dw_2.getitemstring(1,'facd_codigo_item') <> '' and not isnull(dw_2.getitemstring(1,'facd_codigo_item')) then
					ls_tipo_anterior = dw_1.getitemstring(1,'fact_tipo', Primary!, true)
					if gf_mensaje('','Esta Seguro de Cambiar el Tipo de la Factura ???',2,1,'E') = 1 then
							if is_tipo <> ls_tipo_anterior then
								wf_cambiar_tipo(ls_tipo_anterior)								
							end if
					else
						is_tipo = ls_tipo_anterior
						dw_1.setitem(1,'fact_tipo',ls_tipo_anterior)
						return 2	
					end if
				end if
		end if
		  SELECT count(*)  
			 INTO :li_traspaso  
			 FROM dgmsubse  
			WHERE ( dgmsubse.subs_g_financiero = :str.g_financiero ) AND  
					( dgmsubse.subs_empresa = :str.empresa ) AND  
					( dgmsubse.subs_sub_trans = :is_tipo ) AND  
					( isnull(dgmsubse.subs_traspaso,0) = 1 )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al buscar tipo traspaso '+sqlca.sqlerrtext,1,1,'E')										
			end if
			if li_traspaso > 0 then
				dw_1.setitem(1,'fact_tipo_ventas','10')
			else
				dw_1.setitem(1,'fact_tipo_ventas','02')				
			end if
	case 'fact_ruc'
		ls_tipo_cliente  = dw_1.getitemstring(1,'fact_tipo_fact')
		ls_ruc				= dw_1.getitemstring(1,'fact_ruc')		
		if ls_ruc = '' or isnull(ls_ruc) then
			gf_mensaje('','Debe Asignar un R.U.C. Valido, Verifique !!!',1,1,'E')
			dw_1.setcolumn('fact_ruc')
			return 2
		end if
		if ls_tipo_cliente = 'G' then
			if pos(ls_ruc,'NT') = 0 then
				gf_mensaje('','Debe Asignar un R.U.C. Valido para Cliente de Gobierno, Debe contener NT, Verifique !!!',1,1,'E')
				dw_1.setcolumn('fact_ruc')
				return 2
			end if			
		end if
		if ls_estado = 'I' then
			if dw_1.update() = -1 then
				gf_mensaje('','Error al Guardar '+sqlca.sqlerrtext,1,1,'E')
			end if
		end if
	case 'fact_provincia_fe'
		str.frame.setredraw(false)		
		this.setitem(1,'fact_distrito',0)
		this.setitem(1,'fact_corregimiento',0)		
		dw_1.accepttext()		
		str.frame.setredraw(true)		
		if ls_estado = 'I' then
			if dw_1.update() = -1 then
				gf_mensaje('','Error al Guardar '+sqlca.sqlerrtext,1,1,'E')
			end if
		end if
		
	case 'fact_distrito'
		str.frame.setredraw(false)				
		this.setitem(1,'fact_corregimiento',0)
		dw_1.accepttext()		
		str.frame.setredraw(true)					
		if ls_estado = 'I' then
			if dw_1.update() = -1 then
				gf_mensaje('','Error al Guardar '+sqlca.sqlerrtext,1,1,'E')
			end if
		end if
	case 'fact_corregimiento'
		if ls_estado = 'I' then
			if dw_1.update() = -1 then
				gf_mensaje('','Error al Guardar '+sqlca.sqlerrtext,1,1,'E')
			end if
		end if
	case 'fact_tipo_fact'
			if ls_estado = 'I' then
			if dw_1.update() = -1 then
				gf_mensaje('','Error al Guardar '+sqlca.sqlerrtext,1,1,'E')
			end if
		end if		
	case 'fact_dv'
		if ls_estado = 'I' then
			if dw_1.update() = -1 then
				gf_mensaje('','Error al Guardar '+sqlca.sqlerrtext,1,1,'E')
			end if
		end if
	case 'fact_intcoterms'
		if ls_estado = 'I' then
			if dw_1.update() = -1 then
				gf_mensaje('','Error al Guardar Intcoterms '+sqlca.sqlerrtext,1,1,'E')
			end if
		end if	
	case 'fact_tipo_documento'
		if ls_estado = 'I' then
			if dw_1.update() = -1 then
				gf_mensaje('','Error al Guardar tipo documento '+sqlca.sqlerrtext,1,1,'E')
			end if
		end if
	case 'fact_tipo_ventas'
		if ls_estado = 'I' then
			if dw_1.update() = -1 then
				gf_mensaje('','Error al Guardar tipo ventas '+sqlca.sqlerrtext,1,1,'E')
			end if
		end if
		
case	'fact_no_factura'
		ls_factura = data
		
		  SELECT count(*)  
			 INTO :li_existe  
			 FROM fatdiari  
			WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
					( fatdiari.fact_empresa = :str.empresa ) AND  
					( fatdiari.fact_no_factura = :ls_factura ) AND  
					( fatdiari.fact_ann = :ii_ann )  and
					(fatdiari.fact_no_pedido <> :is_secuencia );
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al validar numero de factura '+sqlca.sqlerrtext,1,1,'E')
					return
				end if
				
				if li_existe > 0 then
					gf_mensaje('','Factura Ya Existe. Verifique !!!',1,1,'E')
					ls_factura_anterior = this.getitemstring(1,'fact_no_factura',Primary!,true)
					this.setitem(1,'fact_no_factura',ls_factura_anterior)
					this.setcolumn('fact_no_factura')
					this.setfocus()
					return 2 
				end if
				
	case 'fact_nota_credito'
		li_nc = integer(data)
		parent.triggerevent('ue_adicionar')
		this.setitem(1,'fact_nota_credito',li_nc)
		this.accepttext()
	case 'fact_no_pedido'

		ls_codigo = this.getitemstring(1,'fact_no_pedido')
		
		for i = 1 to len(ls_codigo)
			ls_caracter = mid(ls_codigo,i,1)
			if not isnumber(ls_caracter) then
				gf_mensaje('','Numero de Pedido Invalido, Verifique !!!',1,1,'E')
				this.setitem(1,'fact_no_pedido','')
				return 2
			end if
		next
		
		is_secuencia = ls_codigo
		dw_2.object.cargos.expression = "'"+string(0.00,'#,##0.00')+"'"	//Para blanquear los cargos
		dw_2.object.descuento.expression = "'"+string(0.00,'#,##0.00')+"'"	//Para blanquear los cargos
		dw_13.reset()
		dw_14.reset()
		if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo, ii_ann ) > 0 then
			is_tipo = dw_1.getitemstring(1,'fact_tipo')
			select max(vfac_vendedor)
			into :ii_vendedor
			from fadvenfa
			where vfac_g_financiero = :str.g_financiero and
					vfac_empresa		= :str.empresa and
					vfac_tipo			= :is_tipo and
					vfac_no_pedido		= :is_secuencia and
					vfac_ann				= :ii_ann ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al validar vendedor '+sqlca.sqlerrtext,1,1,'E')
					end if
			dw_1.setitem(1, 'vendedor', ii_vendedor)
			idec_gastos = dw_1.getitemnumber(dw_1.getrow(),'fact_gastos_total')
			dw_2.object.cargos.expression = "'"+string(idec_gastos,'##0.00')+"'"	
			idec_descuento = dw_1.getitemnumber(dw_1.getrow(),'fact_por_descuento')
			dw_2.object.descuento.expression = "'"+string(idec_descuento,'##0.00')+"'"	
			ll_lter = dw_1.getitemnumber(1,'fact_cliente')
			ld_saldo = gf_saldo_anterior_new( ll_lter, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)		
			if isnull(ld_saldo) then ld_saldo = 0.00
			dw_1.setitem(1,'saldo',ld_saldo)
			is_estado_factura = dw_1.getitemstring(1,'fact_estado_factura')
			if is_estado_factura <> 'A' then
				if ii_controla_pedido = 1  then
					wf_activa_campos(true)
				else
					wf_activa_campos(false)		
				end if
			else
				wf_activa_campos(true)
			end if
			ll_fila = idwc_cliente.find('terc_tercero = '+string(ll_lter),1,idwc_cliente.rowcount())
			if ll_fila > 0 then
				idwc_cliente.scrolltorow(ll_fila)
			end if
		
			ld_limite = idwc_cliente.getitemnumber(idwc_cliente.getrow(), 'clie_limite_credito')						
			dw_1.setitem(1,'limite',ld_limite)		
			
			dw_2.reset()
			dw_2.retrieve(str.g_financiero, str.empresa, ls_codigo, ii_ann )
			is_item = ''
			dw_2.scrolltorow(dw_2.rowcount())
			dw_2.setfocus()
			
			li_provincia = this.getitemnumber(1,'fact_provincia_fe')
				if not isnull(li_provincia) then
					idwc_distrito.setfilter('codprovincia = '+string(li_provincia))
					idwc_distrito.filter()
					li_distrito = this.getitemnumber(1,'fact_distrito')
					if not isnull(li_distrito) then
						idwc_corregimiento.setfilter('codprovincia = '+string(li_provincia)+ ' and coddistrito = '+string(li_distrito))
						idwc_corregimiento.filter()
					end if
				end if	
				
				if dw_13.retrieve(ll_lter) = 0 then dw_13.insertrow(1)
				if dw_14.retrieve(ll_lter) = 0 then dw_14.insertrow(1)	
			
		else
			parent.triggerevent('ue_adicionar')
			this.setitem(1,'fact_no_pedido',ls_codigo)
			ii_vendedor = 0
			dw_1.setitem(1, 'vendedor', ii_vendedor)
			idec_gastos = 0
			idec_descuento = 0
			dw_2.object.cargos.expression = "'"+string(idec_gastos,'##0.00')+"'"	
			dw_2.object.descuento.expression = "'"+string(idec_descuento,'##0.00')+"'"				
			dw_13.insertrow(1)
			dw_14.insertrow(1)
		end if		
	case 'fact_por_descuento'
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
  		  dw_1.setitem(1,'fact_monto_final',ldec_final)
		  dw_1.accepttext()	 
  case 'fact_alerta_vencimiento', 'fact_fecha_despacho', 'fact_tipo_movimiento', 'fact_despachado', 'fact_consignado', 'fact_pasaporte','fact_linea_aerea','fact_comentario', 'fact_a_nombre_direccion', 'fact_a_nombre'
		if ls_columna = 'fact_tipo_movimiento' then
			//Si es despacho directo, pone la alerta
			if this.getitemstring(1,'fact_tipo_movimiento') = 'D' then this.setitem(1,'fact_alerta_vencimiento',1)
		end if
		
		if dw_1.getitemstring(1,'fact_estado') = 'I' then
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
	case 'fact_ann'
		ii_ann = integer(data)
	case 'fact_tipo'
		is_tipo = data
	case 'fact_condicion_pago'
		if data = 'CO' then
			this.setitem(1,'fact_dias_pago',0)		
		end if
		wf_setea_vencimiento()					
    CASE "fact_dias_pago"
			 //Funcion que calcula la cantidad de dias para que la factura llegue a su vencimiento 
			 //y se los suma a la fecha de la factura.
			 wf_setea_vencimiento()				
	case 'fact_fecha'
		this.setitem(1,'fact_fecha_despacho',this.getitemdatetime(1,'fact_fecha'))
		
		ldt_fecha_tran 	 = this.getitemdatetime(this.getrow(),'fact_fecha')		
		ldt_fecha_anterior = this.getitemdatetime(this.getrow(),'fact_fecha', Primary!, True)		
		ii_ann = year(date(this.getitemdatetime(this.getrow(),'fact_fecha')))
		li_ann_anterior = dw_1.getitemnumber(1,'fact_ann')
		
		if not gf_valida_fecha_conta(ldt_fecha_anterior) then			
			dw_1.setitem(1,'fact_fecha', ldt_fecha_anterior)
			dw_1.setcolumn('fact_fecha')
			return 2
		end if

		if not gf_valida_fecha_conta(ldt_fecha_tran) then			
			dw_1.setitem(1,'fact_fecha', ldt_fecha_anterior)
			dw_1.setcolumn('fact_fecha')
			return 2
		end if

		if not gf_valida_fecha_futura(ldt_fecha_tran) then			
			if ldt_fecha_tran = ldt_fecha_anterior then
				dw_1.setitem(1,'fact_fecha', date(gf_fecha_serv()))				
			else
				dw_1.setitem(1,'fact_fecha', ldt_fecha_anterior)
			end if
			dw_1.setcolumn('fact_fecha')
			return 2
		end if
		
		//Si los anios son diferentes asigna el anio
		if ii_ann <> li_ann_anterior then
			dw_1.setitem(1,'fact_ann',ii_ann)
		end if

		 //Funcion que calcula la cantidad de dias para que la factura llegue a su vencimiento 
		 //y se los suma a la fecha de la factura.
		 wf_setea_vencimiento()		
		
	case 'fact_ruc_cliente'		
		
		  SELECT count(*)  
			 INTO :li_existe  
			 FROM ccmclien  
			WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
					( ccmclien.clie_empresa = :str.empresa ) AND  
					( ccmclien.clie_ref_anterior = :data ) AND
					( ccmclien.clie_cuenta_mala = 0);
			if li_existe = 0 or isnull(li_existe) then
				gf_mensaje('','Cliente no existe. Verifique !!!',1,1,'E')
				dw_1.setitem(1,'fact_ruc_cliente','')
				dw_1.setcolumn('fact_ruc_cliente')
				return 2
			end if		
			
		ll_tercero = idwc_cliente.getitemNumber(idwc_cliente.getrow(), 'terc_tercero')		
		ls_nombre = idwc_cliente.getitemstring(idwc_cliente.getrow(), 'terc_descripcion')
		li_vendedor = idwc_cliente.getitemnumber(idwc_cliente.getrow(), 'clie_vendedor')
		li_termino_pago = idwc_cliente.getitemnumber(idwc_cliente.getrow(), 'clie_limite_morosidad')				
		ls_pasaporte = idwc_cliente.getitemstring(idwc_cliente.getrow(), 'clie_pasaporte')		
		li_provincia  = idwc_cliente.getitemNumber(idwc_cliente.getrow(), 'terc_provincia')
		li_distrito     = idwc_cliente.getitemNumber(idwc_cliente.getrow(), 'terc_distrito')
		li_corregimiento  = idwc_cliente.getitemNumber(idwc_cliente.getrow(), 'terc_corregimiento')
		ls_tipo_fact = idwc_cliente.getitemstring(idwc_cliente.getrow(),'terc_tipo_fact')		
		ls_ruc = idwc_cliente.getitemstring(idwc_cliente.getrow(),'terc_identificacion')
		ls_dv = idwc_cliente.getitemstring(idwc_cliente.getrow(),'terc_digito_verificador')				
		if isnull(li_termino_pago) then li_termino_pago = 0
		ld_limite = idwc_cliente.getitemnumber(idwc_cliente.getrow(), 'clie_limite_credito')						
		if isnull(ld_limite) then ld_limite = 0.00
		this.setitem(1,'fact_a_nombre',ls_nombre)
		this.setitem(1,'fact_cliente', ll_tercero )
		this.setitem(1,'fact_dias_pago',li_termino_pago)
		this.setitem(1,'fact_provincia_fe', li_provincia)	
		this.setitem(1,'fact_distrito', li_distrito)	
		this.setitem(1,'fact_corregimiento', li_corregimiento)	
		this.setitem(1,'fact_tipo_fact', ls_tipo_fact)			
		this.setitem(1,'fact_ruc', ls_ruc)			
		this.setitem(1,'fact_dv', ls_dv)			
		this.setitem(1,'fact_condicion_pago', 'CR')	
		if data = '99999' then
			this.setitem(1,'fact_condicion_pago', 'CO')
			this.setitem(1,'fact_dias_pago', 0)	
			this.setitem(1,'fact_a_nombre_direccion','')
		else
			this.setitem(1,'fact_a_nombre_direccion', idwc_cliente.getitemstring(idwc_cliente.getrow(), 'regi_descripcion') + ', '+ idwc_cliente.getitemstring(idwc_cliente.getrow(), 'pais_descripcion') )		
		end if
		this.setitem(1,'vendedor',li_vendedor)	
		this.setitem(1,'fact_pasaporte',ls_pasaporte)		
		this.setcolumn('fact_a_nombre')
		ld_saldo = gf_saldo_anterior_new( ll_tercero, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)		
		if isnull(ld_saldo) then ld_saldo = 0.00
		this.setitem(1,'saldo',ld_saldo)
		this.setitem(1,'limite',ld_limite)		
		wf_setea_vencimiento()				
		if dw_13.retrieve(ll_tercero) = 0 then dw_13.insertrow(1)		
		if dw_14.retrieve(ll_tercero) = 0 then dw_14.insertrow(1)		
		
		li_provincia = this.getitemnumber(1,'fact_provincia_fe')
			if not isnull(li_provincia) then
				idwc_distrito.setfilter('codprovincia = '+string(li_provincia))
				idwc_distrito.filter()
				li_distrito = this.getitemnumber(1,'fact_distrito')
				if not isnull(li_distrito) then
					idwc_corregimiento.setfilter('codprovincia = '+string(li_provincia)+ ' and coddistrito = '+string(li_distrito))
					idwc_corregimiento.filter()
				end if
			end if						 
end choose


end event

event dw_1::doubleclicked;call super::doubleclicked;string ls_objeto, ls_column, ls_factura, ls_codigo
integer li_pos , i
date 	ld_date,ld_ini_date, ld_hoy
accepttext()

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

ls_column = dwo.name

if ls_column = 'fact_no_pedido_t' then
	if is_secuencia <> '' and not isnull(is_secuencia) then
		dw_8.visible = true
		dw_8.setfocus()
	end if
elseif ls_column = 'fact_estado' then
	if is_secuencia <> '' and not isnull(is_secuencia) then
		if this.getitemstring(1,'fact_estado') = 'A' and this.getitemnumber(1,'fact_monto_final') > 0 then
			if gf_mensaje('','Esta Seguro de Cambiar el Estado a PASADO ?',2,1,'Q') = 2 then return
			this.setitem(1,'fact_estado','P')
			if this.update() = -1 then
				gf_mensaje('','Error al Cambiar el Estado '+sqlca.sqlerrtext,1,1,'E')
				this.setitem(1,'fact_estado','A')
				return
			else
				for i = 1 to dw_2.rowcount()
					ls_codigo = dw_2.getitemstring(i,'facd_codigo_item')
					gf_actualiza_reserva_producto(ls_codigo)
				next
				str.frame.setmicrohelp('Hymsoft')
			end if
		end if
	end if
end if
end event

type st_ayuda from w_fa_padre`st_ayuda within w_facturacion
integer x = 2793
integer y = 636
end type

type dw_2 from datawindow within w_facturacion
event ue_enter pbm_dwnprocessenter
event ue_down pbm_dwnkey
event ue_helpcol ( )
integer x = 18
integer y = 1080
integer width = 4370
integer height = 1188
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle de la Factura"
string dataobject = "dw_detalle_factura"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_enter;this.accepttext()
if str.contabiliza = 1 then
	if this.getcolumnname() = 'facd_precio_unidad_producto' then	
		if this.getrow() = this.rowcount() then
			parent.triggerevent('ue_aceptar')
			parent.triggerevent('ue_adicionar')
		else
			this.scrolltorow(this.getrow() + 1)
			if pos(str.empr_acceso_especial, 'HPSA') > 0 then
				this.setcolumn('facd_modelo')
			else
				this.setcolumn('facd_codigo_item')
			end if

		end if
	elseif this.getcolumnname() = 'facd_codigo_item' then	
		this.setcolumn('facd_bodega')	
	elseif this.getcolumnname() = 'facd_modelo' then	
		this.setcolumn('facd_bodega')
	elseif this.getcolumnname() = 'facd_bodega' then	
		this.setcolumn('facd_cantidad')		
	elseif this.getcolumnname() = 'facd_cantidad' or this.getcolumnname() = 'facd_cantidad_fraccion' then	
		this.setcolumn('facd_precio_unidad_producto')			
	end if

else
	if this.getcolumnname() = 'facd_precio_unidad_producto' then	
		if this.getrow() = this.rowcount() then
			parent.triggerevent('ue_aceptar')
			parent.triggerevent('ue_adicionar')
		else
			this.scrolltorow(this.getrow() + 1)
			if pos(str.empr_acceso_especial, 'HPSA') > 0 then
				this.setcolumn('facd_modelo')
			else
				this.setcolumn('facd_codigo_item')
			end if

		end if
	elseif this.getcolumnname() = 'facd_codigo_item' then	
		this.setcolumn('facd_bodega')	
	elseif this.getcolumnname() = 'facd_modelo' then	
		this.setcolumn('facd_bodega')	
	elseif this.getcolumnname() = 'facd_bodega' then	
		this.setcolumn('facd_cantidad')		
	elseif this.getcolumnname() = 'facd_cantidad' or this.getcolumnname() = 'facd_cantidad_fraccion' then	
		this.setcolumn('facd_precio_unidad_producto')			
	end if
end if
return 2
end event

event ue_down;//override
// Toma la Tecla que el usuario presione
long ll_cantidad
integer ll_fraccion, i, li_cantidad_unidad
decimal{2} ld_costo_cif, ld_monto_final, ld_fob
string ls_unidad, ls_producto

CHOOSE CASE key
		
	CASE KeyF1! 
		
		This.Postevent("ue_helpcol")
		
	CASE	  Keyenter! 
		
	  This.Triggerevent("ue_entercol")
	  
END CHOOSE

if keydown(keycontrol!) and keydown(KeyM!) then   								
	if gf_mensaje("","Está seguro de realizar el cambio de los precios por el costo ?",2,1,"E") = 1 then
		//Recorre todo el datawindow		
		for i = 1 to this.rowcount()
			//si el codigo del articulo es valido
			ls_producto = this.getitemstring(i,"facd_codigo_item")
			if trim(ls_producto) <> '' and not isnull(ls_producto) then
				//Cambia el precio por el costo
				SELECT isnull(inmprodu.prod_costo_fob,0),   
							isnull(inmprodu.prod_costo_promedio ,0) 
					 INTO :ld_fob,   
							:ld_costo_cif 
					 FROM inmprodu  
					WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
							( inmprodu.prod_empresa = :str.empresa ) AND  
							( inmprodu.prod_producto = :ls_producto )   ;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al buscar costos '+sqlca.sqlerrtext,1,1,'E')
							return
						end if
				this.setitem(i,'facd_costo_fob',ld_fob)
				this.setitem(i,'facd_costo_cif',ld_costo_cif)
				this.setitem(i,"facd_precio_unidad_producto",ld_costo_cif)				
				this.setitem(i,"facd_precio_original",ld_costo_cif)								
				ls_unidad	   = 	this.getitemstring(i,"facd_unidad_venta")					
				  SELECT inamedid.medi_cantidad  
					 INTO :li_cantidad_unidad  
					 FROM inamedid  
					WHERE inamedid.medi_medida = :ls_unidad   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al buscar cantidad unidad '+sqlca.sqlerrtext,1,1,'E')
						return
					end if
				//Cantidad Total
				ll_cantidad =  this.getitemNumber(i,"facd_cantidad")
				ll_fraccion =  this.getitemNumber(i,"facd_cantidad_fraccion")							
				ld_monto_final = round( (ll_cantidad * ld_costo_cif) + ((ld_costo_cif / li_cantidad_unidad) * ll_fraccion ) ,2)
				this.setitem(i,'facd_monto_final', ld_monto_final)
				this.setitem(i,'facd_monto_total', ld_monto_final)
				this.setitem(i,'facd_costo_total', ld_monto_final)
				//Funcion que asigna los totales por registro
//				wf_monto_total(i, ls_unidad_prod, ls_unidad, ll_cantidad, ll_fraccion, ld_costo_cif, this, 0 ) //el precio original es 0 para descuento por linea = 0				
			end if
		next
	end if
end if
end event

event ue_helpcol();//Busqueda del producto
//
String  ls_find,ls_codigo
integer li_c, li_b
long    ll_lter
string  ls_lter,ls_des

Datawindow        dww
str_dg_dynamic_find	lstr_df

choose case this.getcolumnname()
	case 'facd_codigo_item'
		
	lstr_df.texto_campo [1,1] = "inmprodu.prod_producto"
	lstr_df.texto_campo [1,2] = "Referencia"
	lstr_df.texto_campo [1,3] = "prod_producto"
	lstr_df.texto_campo [1,4] = 'V'
//	lstr_df.texto_campo [1,5] = '280'	
	lstr_df.texto_campo [2,1] = "inmprodu.prod_producto_dos"
	lstr_df.texto_campo [2,2] = "Modelo"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
//	lstr_df.texto_campo [2,5] = '770'
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
	
	lstr_df.texto_campo [5,1] = "convert(numeric(10,2),inmprodu.prod_existencia_total / medi_cantidad) prod_existencia_total"
	lstr_df.texto_campo [5,2] = "Exist."
	lstr_df.texto_campo [5,3] = ""
	lstr_df.texto_campo [5,4] = 'V'
	lstr_df.texto_campo [5,5] = '270'

	lstr_df.texto_campo [6,1] = "convert(numeric(10,2),inmprodu.prod_reserva_total / medi_cantidad) prod_reserva_total"
	lstr_df.texto_campo [6,2] = "Reserva"
	lstr_df.texto_campo [6,3] = ""
	lstr_df.texto_campo [6,4] = 'V'
	lstr_df.texto_campo [6,5] = '270'

	lstr_df.texto_campo [7,1] = "convert(numeric(10,2),(inmprodu.prod_existencia_total  - inmprodu.prod_reserva_total) / medi_cantidad) disponible"
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


	lstr_df.tabla = " inmprodu, cradivis, cragrupo, inamedid "
		
	lstr_df.tabla_where = &
		"WHERE ( cragrupo.agru_g_financiero = inmprodu.prod_g_financiero ) and  " +&
         "( cragrupo.agru_empresa = inmprodu.prod_empresa ) and  " +&
         "( cragrupo.agru_codigo_div = inmprodu.prod_division ) and " +&  
         "( cragrupo.agru_codigo_grupo = inmprodu.prod_grupo ) and " +&  			
         "( inmprodu.prod_g_financiero = cradivis.adiv_g_financiero ) and " +& 
         "( inmprodu.prod_empresa = cradivis.adiv_empresa ) and  " +&
         "( inmprodu.prod_division = cradivis.adiv_codigo_div ) and " +&  
         "( inmprodu.prod_medida = inamedid.medi_medida ) and " +&  			
		"( inmprodu.prod_status = 1 ) and " + &	
		"(inmprodu.prod_g_financiero = " + string(str.g_financiero) + ") and " +&
		"(inmprodu.prod_empresa = " + string(str.empresa) + ") "	
						 
	OpenWithParm(w_buscar_producto, lstr_df)
	ls_find = Message.StringParm

	
	
	If len (ls_find) = 0 Then Return
		
	ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo,"'"," ")
	ls_codigo = Trim(ls_codigo)
	this.setitem(this.getrow(),'facd_codigo_item',ls_codigo)

case 'facd_modelo'
	
	lstr_df.texto_campo [2,1] = "inmprodu.prod_producto"
	lstr_df.texto_campo [2,2] = "Referencia"
	lstr_df.texto_campo [2,3] = "prod_producto"
	lstr_df.texto_campo [2,4] = 'V'
//	lstr_df.texto_campo [2,5] = '280'	
	lstr_df.texto_campo [1,1] = "inmprodu.prod_producto_dos"
	lstr_df.texto_campo [1,2] = "Modelo"
	lstr_df.texto_campo [1,3] = ""
	lstr_df.texto_campo [1,4] = 'V'
//	lstr_df.texto_campo [1,5] = '770'
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
	
	lstr_df.texto_campo [5,1] = "convert(numeric(8,2),inmprodu.prod_existencia_total / medi_cantidad) prod_existencia_total"
	lstr_df.texto_campo [5,2] = "Exist."
	lstr_df.texto_campo [5,3] = ""
	lstr_df.texto_campo [5,4] = 'V'
	lstr_df.texto_campo [5,5] = '270'

	lstr_df.texto_campo [6,1] = "convert(numeric(8,2),inmprodu.prod_reserva_total / medi_cantidad) prod_reserva_total"
	lstr_df.texto_campo [6,2] = "Reserva"
	lstr_df.texto_campo [6,3] = ""
	lstr_df.texto_campo [6,4] = 'V'
	lstr_df.texto_campo [6,5] = '270'

	lstr_df.texto_campo [7,1] = "convert(numeric(8,2),(inmprodu.prod_existencia_total  - inmprodu.prod_reserva_total) / medi_cantidad) disponible"
	lstr_df.texto_campo [7,2] = "Dispo."
	lstr_df.texto_campo [7,3] = ""
	lstr_df.texto_campo [7,4] = 'V'
	lstr_df.texto_campo [7,5] = '270'

	lstr_df.texto_campo [8,1] = "convert(numeric(8), inmprodu.prod_empaque) prod_empaque"
	lstr_df.texto_campo [8,2] = "Empaque"
	lstr_df.texto_campo [8,3] = ""
	lstr_df.texto_campo [8,4] = 'V'
	lstr_df.texto_campo [8,5] = '270'
	
	lstr_df.texto_campo [9,1] = "inmprodu.prod_medida"
	lstr_df.texto_campo [9,2] = "Uni."
	lstr_df.texto_campo [9,3] = ""
	lstr_df.texto_campo [9,4] = 'V'
	lstr_df.texto_campo [9,5] = '120'
	
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


	lstr_df.tabla = " inmprodu, cradivis, cragrupo, inamedid "
		
	lstr_df.tabla_where = &
		"WHERE ( cragrupo.agru_g_financiero = inmprodu.prod_g_financiero ) and  " +&
         "( cragrupo.agru_empresa = inmprodu.prod_empresa ) and  " +&
         "( cragrupo.agru_codigo_div = inmprodu.prod_division ) and " +&  
         "( cragrupo.agru_codigo_grupo = inmprodu.prod_grupo ) and " +&  			
         "( inmprodu.prod_g_financiero = cradivis.adiv_g_financiero ) and " +& 
         "( inmprodu.prod_empresa = cradivis.adiv_empresa ) and  " +&
         "( inmprodu.prod_division = cradivis.adiv_codigo_div ) and " +&  
         "( inmprodu.prod_medida = inamedid.medi_medida ) and " +&  			
		"( inmprodu.prod_status = 1 ) and " + &	
		"(inmprodu.prod_g_financiero = " + string(str.g_financiero) + ") and " +&
		"(inmprodu.prod_empresa = " + string(str.empresa) + ") "	
						 
	OpenWithParm(w_buscar_producto, lstr_df)
	ls_find = Message.StringParm
	
	If len (ls_find) = 0 Then Return
		
	ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo,"'"," ")
	ls_codigo = Trim(ls_codigo)
	this.setitem(this.getrow(),'facd_codigo_item',ls_codigo)
	
	  SELECT max(inmprodu.prod_producto_dos)
		 INTO :ls_codigo  
		 FROM inmprodu  
		WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
				( inmprodu.prod_empresa = :str.empresa ) AND  
				( inmprodu.prod_producto = :ls_codigo )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al buscar modelo '+sqlca.sqlerrtext,1,1,'E')
			return
		end if
		
		this.setitem(this.getrow(),'facd_modelo',ls_codigo)
		
end choose

this.accepttext()
this.trigger event itemchanged(this.getrow(), object, ls_codigo)
end event

event itemfocuschanged;datawindow = 2
this.selecttext(1,100)
end event

event clicked;datawindow = 2
if dwo.name = 'p_delete' then
	dw_2.scrolltorow(row)
	parent.triggerevent('ue_eliminar')
	return
end if

if this.rowcount() = 0 then
	datawindow = 1
	parent.triggerevent('ue_aceptar')
else
	datawindow = 2
//	if dw_1.getitemstring(1,'fact_estado') = 'A' then &
//	parent.triggerevent('ue_adicionar')
end if

datawindow = 2

if	dwo.name = 'p_add' then
	parent.triggerevent('ue_adicionar')
elseif dwo.name = 'p_buscar' then
	dw_2.scrolltorow(row)
	This.triggerevent("ue_helpcol")
end if
end event

event buttonclicked;string ls_codigo
integer li_encontro
if dwo.name = 'b_productos' then

	string ls_producto
	str_kardex  str_opcion
			
	if dw_2.rowcount() > 0 then
		ls_producto = dw_2.getitemstring(dw_2.getrow(),'facd_codigo_item')				
	end if			
	str_opcion.kproducto=ls_producto

	OpenSheetWithParm(w_productos,str_opcion,str.frame,2,Original!)		

end if
end event

event itemchanged;string ls_codigo, ls_modelo = '', ls_descripcion, ls_uni_empaque, ls_condicion, ls_bodega
long   ll_bultos
decimal {3} ld_cantidad, ld_disponible, ld_cantidad_grabada, ld_cantidad_grabada2
integer ll_fraccion, li_encontro, li_linea, li_encontro_temp
decimal {2} ld_precio_recargo, ld_monto_final, ld_total, ld_saldo_disponible, ld_bultos, ld_peso
decimal {8} ld_precio, ld_precio_original, ld_costo_cif
decimal{3} ld_cubicaje, ld_cubicaje_m3
this.accepttext()
if this.getcolumnname() = 'facd_codigo_item' then
	   ls_codigo = data
	   ls_modelo = ''
   		if isnull(ls_codigo) then return 2	
		if not wf_carga_producto(ls_codigo, ls_descripcion, ls_modelo) then
			return 2
		end if
		
		id_precio = id_precio_prod
		
		if ls_descripcion = '' or isnull(ls_descripcion) then
			gf_mensaje('','Referencia no Existe, Verifique !!!',1,1,'E')
			this.setitem(row,'facd_codigo_item','')
			this.setcolumn('facd_codigo_item')
			return 2
		else
			is_item 		= ls_codigo
			is_descrip	= ls_descripcion
			this.setitem(row, 'facd_descripcion_alterna', ls_descripcion)
			this.setitem(row, 'facd_precio_unidad_producto', id_precio)
			this.setitem(row, 'facd_precio_original', id_precio)			
			this.setitem(row, 'facd_unidad_venta',is_unidad)
			this.setitem(row, 'facd_unidad_producto',is_unidad)			
			this.setitem(row, 'facd_costo_cif', id_costo_cif)			
			this.setitem(row, 'facd_costo_fob', id_costo_fob)		
			this.setitem(row, 'facd_modelo', is_modelo)						
			this.setitem(row,'facd_cantidad',0.00)
			this.setitem(row,'facd_cantidad_fraccion',0.00)
			this.setitem(row,'facd_monto_final', 0.00 )
			this.setitem(row,'facd_monto_total', 0.00 )
			this.setitem(row,'facd_bultos',0)
			this.setitem(row,'facd_bultos_original',0)			
			this.setitem(row,'facd_peso',0.00)
			this.setitem(row,'facd_cubicaje',0.00)
			this.setitem(row,'facd_cubicaje_metros',0.00)			
			this.setitem(row,'facd_costo_total', 0.00)	

			if dw_7.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
				dw_7.insertrow(1)
				dw_7.setitem(1,'dgmempre_empr_bodegas_definidas',ii_bodegas_definidas)
				dw_7.setitem(1,'bodega1',is_b1); dw_7.setitem(1,'bodega2',is_b2); dw_7.setitem(1,'bodega3',is_b3); dw_7.setitem(1,'bodega4',is_b4); dw_7.setitem(1,'bodega5',is_b5); dw_7.setitem(1,'bodega6',is_b6); dw_7.setitem(1,'bodega7',is_b7)
			end if
			//Valida que no se capture dos veces el mismo producto
			ls_bodega = trim(this.getitemstring(row,'facd_bodega'))
			li_encontro = this.find('facd_codigo_item = "'+ls_codigo+'" and facd_bodega = "'+ls_bodega+'"',1,this.rowcount())
			if li_encontro > 0 then
				li_encontro_temp = li_encontro
				if li_encontro + 1 <= this.rowcount() then
					li_encontro = this.find('facd_codigo_item = "'+ls_codigo+'" and facd_bodega = "'+ls_bodega+'"',li_encontro + 1,this.rowcount())
					if li_encontro > 0 then
						gf_mensaje('','La Referencia ya fue Capturada. Verifique !!!',1,1,'E')
						ld_precio = this.getitemnumber(li_encontro_temp,'facd_precio_unidad_producto')
						this.setitem(row,'facd_precio_unidad_producto',ld_precio)
					end if
				end if
			end if
			if ls_codigo <> data then
				this.setitem(row, 'facd_codigo_item', ls_codigo)	
				return 2
			end if
		end if
elseif this.getcolumnname() = 'facd_modelo' then
	   ls_modelo = data
	   ls_codigo = ''
		if not wf_carga_producto(ls_codigo, ls_descripcion, ls_modelo) then
			return 2
		end if
		
		id_precio = id_precio_prod
		
		if ls_descripcion = '' or isnull(ls_descripcion) then
			gf_mensaje('','Referencia no Existe, Verifique !!!',1,1,'E')
			this.setitem(row,'facd_codigo_item','')
			this.setcolumn('facd_codigo_item')
			return 2
		else
			is_item 		= ls_codigo
			is_descrip	= ls_descripcion
			this.setitem(row, 'facd_descripcion_alterna', ls_descripcion)
			this.setitem(row, 'facd_precio_unidad_producto', id_precio)
			this.setitem(row, 'facd_precio_original', id_precio)			
			this.setitem(row, 'facd_unidad_venta',is_unidad)
			this.setitem(row, 'facd_unidad_producto',is_unidad)			
			this.setitem(row, 'facd_costo_cif', id_costo_cif)			
			this.setitem(row, 'facd_costo_fob', id_costo_fob)		
			this.setitem(row, 'facd_modelo', is_modelo)						
			this.setitem(row,'facd_cantidad',0.00)
			this.setitem(row,'facd_cantidad_fraccion',0.00)
			this.setitem(row,'facd_monto_final', 0.00 )
			this.setitem(row,'facd_monto_total', 0.00 )
			this.setitem(row,'facd_bultos',0)
			this.setitem(row,'facd_bultos_original',0)			
			this.setitem(row,'facd_peso',0.00)
			this.setitem(row,'facd_cubicaje',0.00)
			this.setitem(row,'facd_cubicaje_metros',0.00)						
			this.setitem(row,'facd_costo_total', 0.00)	
			if dw_7.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
				dw_7.insertrow(1)
				dw_7.setitem(1,'dgmempre_empr_bodegas_definidas',ii_bodegas_definidas)
				dw_7.setitem(1,'bodega1',is_b1); dw_7.setitem(1,'bodega2',is_b2); dw_7.setitem(1,'bodega3',is_b3); dw_7.setitem(1,'bodega4',is_b4); dw_7.setitem(1,'bodega5',is_b5); dw_7.setitem(1,'bodega6',is_b6); dw_7.setitem(1,'bodega7',is_b7)
			end if
			//Valida que no se capture dos veces el mismo producto
			ls_bodega = trim(this.getitemstring(row,'facd_bodega'))
			li_encontro = this.find('facd_codigo_item = "'+ls_codigo+'" and facd_bodega = "'+ls_bodega+'"',1,this.rowcount())
			if li_encontro > 0 then
				if li_encontro + 1 <= this.rowcount() then
					li_encontro = this.find('facd_codigo_item = "'+ls_codigo+'" and facd_bodega = "'+ls_bodega+'"',li_encontro + 1,this.rowcount())
					if li_encontro > 0 then
						gf_mensaje('','La Referencia ya fue Capturada. Verifique !!!',1,1,'E')
					end if
				end if
			end if

		end if
elseif this.getcolumnname() = 'facd_cantidad' or this.getcolumnname() = 'facd_cantidad_fraccion' then
		dw_7.accepttext()
		if ii_cantidad_unidad = 0 or isnull(ii_cantidad_unidad) then
			ls_codigo = this.getitemstring(row,'facd_codigo_item')
			if not wf_carga_producto(ls_codigo, ls_descripcion, ls_modelo) then
				return 2
			end if
		end if
		ld_cantidad = this.getitemnumber(row,'facd_cantidad')	
		ll_fraccion = this.getitemnumber(row,'facd_cantidad_fraccion')	
		
		//Valida que no supere la cantidad existente al facturar
		ls_bodega = trim(this.getitemstring(row,'facd_bodega'))
		li_linea = this.getitemnumber(row,'facd_linea')
		ld_disponible = dw_7.getitemnumber(1,'disponible'+ls_bodega)
		  SELECT isnull( faddiari.facd_cantidad ,0) 
			 INTO :ld_cantidad_grabada  
			 FROM faddiari  
			WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
					( faddiari.facd_empresa = :str.empresa ) AND  
					( faddiari.facd_no_pedido = :is_secuencia ) AND
					( faddiari.facd_ann = :ii_ann ) AND
			//		( faddiari.facd_codigo_item = :ls_codigo ) AND  
			//		( faddiari.facd_bodega = :ls_bodega ); // AND  
					( faddiari.facd_linea = :li_linea )   ;

//		ld_cantidad_grabada = 	this.getitemnumber(row,'facd_cantidad', Primary!, True)	
//		if isnull(ld_cantidad_grabada) then ld_cantidad_grabada = 0
//		ld_cantidad_grabada2 = 	this.getitemnumber(row,'facd_cantidad', Primary!, false)	
//		if isnull(ld_cantidad_grabada2) then ld_cantidad_grabada2 = 0
//		if ld_cantidad_grabada = ld_cantidad_grabada2 then ld_cantidad_grabada = 0
//		
		if false and ld_cantidad > ld_disponible + ld_cantidad_grabada then
			gf_mensaje('','La Cantidad es Mayor a lo Disponible, Verifique !!!',1,1,'E')
			this.setitem(row,'facd_cantidad',0.00)
			this.setitem(row,'facd_cantidad_fraccion',0.00)
			this.setitem(row,'facd_monto_final', 0.00 )
			this.setitem(row,'facd_monto_total', 0.00 )
			this.setitem(row,'facd_bultos',0)
			this.setitem(row,'facd_bultos_original',0)			
			this.setitem(row,'facd_peso',0.00)
			this.setitem(row,'facd_cubicaje',0.00)
			this.setitem(row,'facd_cubicaje_metros',0.00)						
			this.setitem(row,'facd_costo_total', 0.00)	
			this.setcolumn('facd_cantidad')
			return 2
		end if
		
		if isnull(ll_fraccion) then ll_fraccion = 0
		ld_precio   = this.getitemnumber(row, 'facd_precio_unidad_producto')
		if (il_empaque * ii_cantidad_empaque) <> 0 then
			ll_bultos = (ld_cantidad * ii_cantidad_unidad + ll_fraccion ) / (il_empaque * ii_cantidad_empaque)
			ld_bultos = (ld_cantidad * ii_cantidad_unidad + ll_fraccion) / (il_empaque * ii_cantidad_empaque)			
		end if
		
				
		if false then //str.contabiliza = 1 then  //Para la empresa de arriba, calcula el nuevo precio, si cambia la cantidad
			ld_monto_final = this.getitemnumber(row,'facd_monto_final')
			if ld_cantidad <> 0 then
				ld_precio = ABS(ld_monto_final / ld_cantidad)
				this.setitem(row,'facd_precio_original',ld_precio)		
				ld_precio_recargo = this.getitemnumber(row, 'facd_precio_recargo')	
				ld_precio = ld_precio + ld_precio_recargo
				this.setitem(row, 'facd_precio_unidad_producto', ld_precio)			
			end if
		else
			ld_monto_final = round( (ld_cantidad * ld_precio) + ((ld_precio / ii_cantidad_unidad) * ll_fraccion ) ,2)
			this.setitem(row,'facd_monto_final', ld_monto_final)
			this.setitem(row,'facd_monto_total', ld_monto_final)
		end if
		this.setitem(row,'facd_bultos',truncate(ld_bultos,0))	//Tenia ll_bultos y redondeaba a 1 cuando era menor a 1
		this.setitem(row,'facd_bultos_original',ld_bultos)					
//		this.setitem(row,'facd_peso',ll_bultos * id_peso)
		ld_peso = wf_peso()
		this.setitem(row,'facd_peso',ld_peso)				
		//this.setitem(row,'facd_cubicaje',round(ll_bultos * id_cubicaje,4))
		ld_cubicaje = wf_cubicaje(false)
		this.setitem(row,'facd_cubicaje',ld_cubicaje)
		ld_cubicaje_m3 = wf_cubicaje(true)
		this.setitem(row,'facd_cubicaje_metros',ld_cubicaje_m3)			
		this.setitem(row,'facd_costo_cif', id_costo_cif)
		this.setitem(row,'facd_costo_fob', id_costo_fob)		
		this.setitem(row,'facd_costo_total', round( (ld_cantidad * id_costo_cif) + ((id_costo_cif / ii_cantidad_unidad) * ll_fraccion ) ,2) )
		ld_total = dw_2.getitemnumber(1,'monto_final')
		ld_saldo_disponible = dw_1.getitemnumber(1,'disponible')
		ls_condicion		  = dw_1.getitemString(1,'fact_condicion_pago')		
		if false and ld_total > ld_saldo_disponible and ls_condicion <> 'CO' then
			if not wf_valida_limite_credito() then
				this.setitem(row,'facd_cantidad',0)
				return 2
			end if
		end if
elseif this.getcolumnname() = 'facd_precio_unidad_producto' then	
	ld_precio = double(data)	
//	if ii_acepta_descuento = 1 then
//		ld_precio = round( ld_precio - round((id_porc_descuento / 100) * ld_precio, 2 ),2)
//		this.setitem(row,'facd_precio_original',ld_precio)
//		this.accepttext()
//		ld_precio = ld_precio
//	end if
	id_precio = ld_precio
//	ld_precio_recargo = this.getitemnumber(row, 'facd_precio_recargo')	
//	ld_precio = ld_precio + ld_precio_recargo
//	this.setitem(row, 'facd_precio_unidad_producto', ld_precio)	
	ld_cantidad   = this.getitemnumber(row, 'facd_cantidad')	
	ll_fraccion   = this.getitemnumber(row,'facd_cantidad_fraccion')
	if isnull(ll_fraccion) then ll_fraccion = 0
	ld_costo_cif  = this.getitemnumber(row, 'facd_costo_cif')
	if isnull(ld_costo_cif) then ld_costo_cif = 0
 	if ld_costo_cif <> 0 and ld_precio <= ld_costo_cif then
		gf_mensaje('','Verifique el Precio, es igual o menor al costo',1,1,'E')
	end if
	ld_monto_final = round( (ld_cantidad * ld_precio) + ((ld_precio / ii_cantidad_unidad) * ll_fraccion ) ,2)	
	this.setitem(row,'facd_monto_final', ld_monto_final)
	this.setitem(row,'facd_monto_total', ld_monto_final)
	this.setitem(row,'facd_costo_total', round( (ld_cantidad * ld_costo_cif) + ((ld_costo_cif / ii_cantidad_unidad) * ll_fraccion ) ,2) )	
	ld_total = dw_2.getitemnumber(1,'monto_final')
	ld_saldo_disponible = dw_1.getitemnumber(1,'disponible')
	ls_condicion		  = dw_1.getitemString(1,'fact_condicion_pago')	
	if false and ld_total > ld_saldo_disponible and ls_condicion <> 'CO' then
		if not wf_valida_limite_credito() then
			this.setitem(row,'facd_precio_unidad_producto',0.00)
			return 2
		end if
	end if
	if ii_acepta_descuento = 1 then
		this.setitem(row,'facd_precio_unidad_producto',ld_precio)
		return 2
	end if

elseif this.getcolumnname() = 'facd_precio_recargo' then	
	ld_precio = double(data)	
	ld_precio_original = this.getitemnumber(row, 'facd_precio_original')	
	if isnull(ld_precio_original) then ld_precio_original = 0
	ld_precio = ld_precio + ld_precio_original
	this.setitem(row, 'facd_precio_unidad_producto', ld_precio)
	ld_cantidad   = this.getitemnumber(row, 'facd_cantidad')	
	ll_fraccion   = this.getitemnumber(row,'facd_cantidad_fraccion')
	if isnull(ll_fraccion) then ll_fraccion = 0	
	ld_costo_cif  = this.getitemnumber(row, 'facd_costo_cif')
	if isnull(ld_costo_cif) then ld_costo_cif = 0
	if ld_costo_cif <> 0 and ld_precio <= ld_costo_cif then
		gf_mensaje('','Verifique el Precio, es igual o menor al costo',1,1,'E')
	end if
	ld_monto_final = round( (ld_cantidad * ld_precio) + ((ld_precio / ii_cantidad_unidad) * ll_fraccion ) ,2)	
	this.setitem(row,'facd_monto_final', ld_monto_final )
	this.setitem(row,'facd_monto_total', ld_monto_final )
	this.setitem(row,'facd_costo_total', round( (ld_cantidad * ld_costo_cif) + ((ld_costo_cif / ii_cantidad_unidad) * ll_fraccion ) ,2) )
	ld_total = dw_2.getitemnumber(1,'monto_final')
	ld_saldo_disponible = dw_1.getitemnumber(1,'disponible')
	ls_condicion		  = dw_1.getitemString(1,'fact_condicion_pago')
	if false and  ld_total > ld_saldo_disponible and ls_condicion <> 'CO' then
		if not wf_valida_limite_credito() then
			this.setitem(row,'facd_precio_recargo',0.00)
			return 2
		end if
	end if	
elseif this.getcolumnname() = 'facd_cubicaje' then	
	if this.getrow() = this.rowcount() then
		parent.triggerevent('ue_adicionar')
	else
		this.scrolltorow(this.getrow() + 1)
		this.setcolumn('facd_codigo_item')
	end if
elseif this.getcolumnname() = 'facd_bodega' then
	//Validar la disponibilidad
	if ii_cantidad_unidad = 0 or isnull(ii_cantidad_unidad) then
			ls_codigo = this.getitemstring(row,'facd_codigo_item')
			if not wf_carga_producto(ls_codigo, ls_descripcion, ls_modelo) then
				return 2
			end if
		end if
		ld_cantidad = this.getitemnumber(row,'facd_cantidad')	
		ll_fraccion = this.getitemnumber(row,'facd_cantidad_fraccion')	
		
		//Valida que no supere la cantidad existente al facturar
		ls_codigo = this.getitemstring(row,'facd_codigo_item')
		ls_bodega = trim(this.getitemstring(row,'facd_bodega'))
		ld_disponible = dw_7.getitemnumber(1,'disponible'+ls_bodega)
		
		if false and ld_cantidad > ld_disponible then
			gf_mensaje('','La Cantidad es Mayor a lo Disponible, Verifique !!!',1,1,'E')
			this.setitem(row,'facd_cantidad',0.00)
			this.setitem(row,'facd_cantidad_fraccion',0.00)
			this.setitem(row,'facd_monto_final', 0.00 )
			this.setitem(row,'facd_monto_total', 0.00 )
			this.setitem(row,'facd_bultos',0)
			this.setitem(row,'facd_bultos_original',0)			
			this.setitem(row,'facd_peso',0.00)
			this.setitem(row,'facd_cubicaje',0.00)
			this.setitem(row,'facd_cubicaje_metros',0.00)
			this.setitem(row,'facd_costo_total', 0.00)	
			this.setcolumn('facd_cantidad')
			return 2
		end if
	
		li_encontro = this.find('facd_codigo_item = "'+ls_codigo+'" and facd_bodega = "'+ls_bodega+'"',1,this.rowcount())
		if li_encontro > 0 then
			if li_encontro + 1 <= this.rowcount() then
				li_encontro = this.find('facd_codigo_item = "'+ls_codigo+'" and facd_bodega = "'+ls_bodega+'"',li_encontro + 1,this.rowcount())
				if li_encontro > 0 then
					gf_mensaje('','La Referencia ya fue Capturada. Verifique !!!',1,1,'E')
				end if
			end if
		end if
	this.setcolumn('facd_cantidad')
elseif this.getcolumnname() = 'facd_rebajar' then
	if dw_1.getitemstring(1,'fact_estado') = 'I' then
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
elseif this.getcolumnname() = 'facd_monto_final' then	//Solo entra para la empresa 2
	ld_cantidad    = this.getitemnumber(row,'facd_cantidad')
	ll_fraccion		= 0
	ld_monto_final = this.getitemnumber(row,'facd_monto_final')
	this.setitem(row, 'facd_monto_total', ld_monto_final)				
	if ld_cantidad <> 0 then
		ld_precio = ABS(ld_monto_final / ld_cantidad)
		this.setitem(row,'facd_precio_original',ld_precio)		
		ld_precio_recargo = this.getitemnumber(row, 'facd_precio_recargo')	
		ld_precio = ld_precio + ld_precio_recargo
		this.setitem(row, 'facd_precio_unidad_producto', ld_precio)			
	end if

	this.setitem(row,'facd_costo_total', round( (ld_cantidad * id_costo_cif) + ((id_costo_cif / ii_cantidad_unidad) * ll_fraccion ) ,2) )
	ld_total = dw_2.getitemnumber(1,'monto_final')
	ld_saldo_disponible = dw_1.getitemnumber(1,'disponible')
	ls_condicion		  = dw_1.getitemString(1,'fact_condicion_pago')		
	if false and  ld_total > ld_saldo_disponible and ls_condicion <> 'CO' then
		if not wf_valida_limite_credito() then
			this.setitem(row,'facd_cantidad',0)
			this.setitem(row,'facd_precio_original',0.00)
			this.setitem(row,'facd_precio_recargo',0.00)
			this.setitem(row,'facd_monto_final',0.00)
			return 2
		end if
	end if

	
end if
end event

event rowfocuschanged;string  ls_codigo, ls_descripcion, ls_modelo
boolean lb_asignar
il_row = currentrow
if currentrow > 0 then
	
	if isnull(is_item) or is_item = '' then 
		is_item = this.getitemstring(currentrow, 'facd_codigo_item')
		lb_asignar = true
	end if
	
	ls_codigo = this.getitemstring(currentrow, 'facd_codigo_item')
	if isnull(ls_codigo) then return 2
	if dw_7.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
		dw_7.insertrow(1)
		dw_7.setitem(1,'dgmempre_empr_bodegas_definidas',ii_bodegas_definidas)
		dw_7.setitem(1,'bodega1',is_b1); dw_7.setitem(1,'bodega2',is_b2); dw_7.setitem(1,'bodega3',is_b3); dw_7.setitem(1,'bodega4',is_b4); dw_7.setitem(1,'bodega5',is_b5); dw_7.setitem(1,'bodega6',is_b6); dw_7.setitem(1,'bodega7',is_b7)
	end if	
	ls_modelo = ''
	if not wf_carga_producto(ls_codigo, ls_descripcion, ls_modelo) then
		return 2
	end if
	if lb_asignar then
		is_descrip = ls_descripcion		
	end if
	dw_7.bringtotop = true
//	dw_8.bringtotop = true	
end if


end event

type dw_3 from datawindow within w_facturacion
boolean visible = false
integer x = 1193
integer y = 260
integer width = 2501
integer height = 1376
integer taborder = 30
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

type cb_1 from commandbutton within w_facturacion
integer x = 2843
integer y = 28
integer width = 379
integer height = 96
integer taborder = 100
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

ld_monto = ldw_1.getitemnumber(ldw_1.getrow(),"fact_monto_fact_total")

//si aplica descuento al subtotal, se debe descontar el descuento, antes de calcular los cargos
ls_tipo = 'N' //ldw_1.GetItemString(ldw_1.getrow(),"fact_descuento_subt_deta")				 
ld_est_valor_desc = 0 //ldw_1.getitemnumber(ldw_1.getrow(),"fact_por_descuento")
if ls_tipo = 'S'	then //si aplica descuento al subtotal
	ld_monto = ld_monto - (ld_monto * (ld_est_valor_desc / 100))
end if

l_str.monto = ld_monto	//ASIGNA EL MONTO BASE PARA CALCULAR LOS CARGOS			 
				 
l_str.bultos = 0 //ldw_1.getitemnumber(ldw_1.getrow(),"fact_bultos_total")				 

l_str.tipo = is_tipo

l_str.estado = ldw_1.getitemstring(ldw_1.getrow(),"fact_estado")

l_str.an		 = ii_ann

l_str.window = parent

//Abre la ventana de cargos, que a su vez llama una funcion que recalcula el monto final
//siempre y cuando la factura esté guardada
  SELECT count(*)  
    INTO :li_existe  
    FROM fatdiari  
   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
         ( fatdiari.fact_empresa = :str.empresa ) AND  
         ( fatdiari.fact_no_pedido = :is_secuencia ) AND  
         ( fatdiari.fact_ann = :ii_ann )   ;
	if sqlca.sqlcode = -1 then
		mensaje("Aviso","Error al Validar Existencia de la Factura",sqlca.sqlerrtext)
	end if

if li_existe > 0 then
	OpensheetWithParm(w_cargos, l_str,parent,2)
// 	m_fa_principal.m_archivo.m_guardar.enabled = true
end if
end event

type cb_2 from commandbutton within w_facturacion
integer x = 2834
integer y = 132
integer width = 402
integer height = 104
integer taborder = 150
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event clicked;string ls_factura
long   ll_factura
integer li_nc, li_existe
datetime ldt_fecha
dw_5.reset()
dw_5.insertrow(1)
dw_5.setfocus()

if dw_2.rowcount() = 0 and dw_1.getitemstring(1,'fact_ruc_cliente') <> '0736' then return
if dw_1.getitemstring(1,'fact_estado') <> 'A' then return
	
parent.triggerevent('ue_aceptar')

if dw_1.getitemnumber(1,'fact_gastos_total') = 0 then cb_1.triggerevent('clicked')

ls_factura = dw_1.getitemstring(1,'fact_no_factura')
li_nc    =		 dw_1.getitemnumber(1,'fact_nota_credito')

  SELECT count(*)  
    INTO :li_existe  
    FROM dgmserdr  
   WHERE ( dgmserdr.serd_g_financiero = :str.g_financiero ) AND  
         ( dgmserdr.serd_empresa = :str.empresa ) AND  
         ( dgmserdr.serd_sub_trans = :is_tipo ) AND  
         ( dgmserdr.serd_aplicacion = 'FA' ) AND  
         ( len(serd_mgcuenta) > 0 ) AND  
         ( dgmserdr.serd_transaccion in ('FA','FC') )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al Buscar Tipo Cuenta '+sqlca.sqlerrtext,1,1,'E')	
		return
	end if

if li_existe = 0 then
	gf_mensaje('','Debe Asignar un Tipo de Factura para Continuar, Verifique !!!',1,1,'E')
	dw_1.setcolumn('fact_tipo')
	dw_1.setfocus()		
	return
end if

ldt_fecha  = datetime(date(gf_fecha_serv()),time('00:00:00'))
dw_1.setitem(1,'fact_fecha',ldt_fecha)

if ls_factura = '' or isnull(ls_factura) then
   SELECT case when :li_nc = 1 then isnull(faaparam.fara_ult_devolucion  ,'0') else isnull(faaparam.fara_ult_ultima_factura  ,'0') end
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
else
	dw_5.setitem(1,'factura',ls_factura)
end if
dw_5.visible = true

end event

type dw_6 from datawindow within w_facturacion
integer x = 3301
integer y = 140
integer width = 718
integer height = 100
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_formatos"
end type

event itemchanged;string ls_dw
ls_dw = idwc_formatos.getitemstring(idwc_formatos.getrow(),'datawindows')
dw_4.dataobject = ls_dw
dw_4.settransobject(sqlca)
dw_4.retrieve(str.g_financiero, str.empresa, is_secuencia , ii_ann)

if idec_gastos = 0 or isnull(idec_gastos) then
	if dw_4.Describe("ver_cargos.x") <> "?" and dw_4.Describe("ver_cargos.x") <> "!" then &
		dw_4.object.ver_cargos.expression = "'" + string(1) + "'"
	dw_4.Modify("dw_1.visible = false") 		
	//Para poner el titulo de subtotal y total
	if dw_4.Describe("t_subtotal.x") <> "?" and dw_4.Describe("t_subtotal.x") <> "!" then &
			dw_4.object.t_subtotal.text = em_subtotal.text
	if dw_4.Describe("t_total.x") <> "?" and dw_4.Describe("t_total.x") <> "!" then &
			dw_4.object.t_total.text = em_total.text
	if dw_4.Describe("t_total2.x") <> "?" and dw_4.Describe("t_total2.x") <> "!" then &
			dw_4.object.t_total2.text = em_total.text
else
	if dw_4.Describe("ver_cargos.x") <> "?" and dw_4.Describe("ver_cargos.x") <> "!" then &
		dw_4.object.ver_cargos.expression = "'" + string(0) + "'"
	dw_4.Modify("dw_1.visible = true") 
	//Para poner el titulo de subtotal y total
	str.subtotal = em_subtotal.text
	str.total = em_total.text
end if

dw_4.object.datawindow.print.preview = 'yes'
dw_4.object.datawindow.print.preview.zoom = 100
dw_4.object.nom_empresa.expression = "'"+str.nombre_empresa+"'"
dw_4.visible = true
end event

type st_1 from statictext within w_facturacion
integer x = 3337
integer y = 72
integer width = 603
integer height = 60
boolean bringtotop = true
integer textsize = -9
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

type pb_1 from picturebutton within w_facturacion
integer x = 3845
integer y = 940
integer width = 329
integer height = 108
integer taborder = 190
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
string pointer = "HyperLink!"
string text = "KARDEX"
boolean originalsize = true
end type

event clicked;		Window lw_child_v				
		string ls_producto
		str_kardex  str_opcion
		
			str_opcion.opcion_menu = 'MCP'
			str_opcion.opcion_ventana    = 'P'
			str_opcion.dwpantalla     = 'dw_in_mcp_prod_kard_1'
			if str.contabiliza = 0 then
				str_opcion.dwreporte      = 'dw_in_mcp_prod_kard_2'
			else
				str_opcion.dwreporte      = 'dw_in_mcp_prod_kard_2_arriba'
			end if
			str_opcion.titulo_ventana = 'Movimientos de Productos (Kardex)'
			
			if dw_2.rowcount() > 0 then
				ls_producto = dw_2.getitemstring(dw_2.getrow(),'facd_codigo_item')				
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
		
			//OpenSheetWithParm(lw_child_v,str_opcion,"w_in_movi_prod_kardex",str.frame,2,Original!)		
end event

type dw_7 from datawindow within w_facturacion
integer x = 41
integer y = 1764
integer width = 2085
integer height = 476
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_existencia_bodegas"
boolean border = false
boolean livescroll = true
end type

event retrieveend;if rowcount = 0 then return
string ls_error
//decimal ld_reserva_total, ld_cantidad_total, ld_disponible
////Busca la reserva
//		 DECLARE sp_reserva PROCEDURE FOR fa_reservados_totaldos  
//				@g_financiero = :str.g_financiero,   
//				@empresa = :str.empresa,   
//				@codigo_producto = :is_item  ;
//				
//			if sqlca.sqlcode = -1 then
//				mensaje("Aviso","Error al declarar el cursor",sqlca.sqlerrtext)
//				return
//			end if
//			
//			execute sp_reserva;												
//			// set.
//			DO WHILE SQLCA.sqlcode = 0							
//			// Fetch the next row from the first result set.						
//				FETCH sp_reserva INTO :ld_reserva_total;
//			LOOP
//			
//			if sqlca.sqlcode = -1 then
//				ls_error = sqlca.sqlerrtext
//				gf_mensaje("Aviso","Error al buscar la reserva "+ls_error,1,1,'E')
//				return
//			end if
//			
//			close sp_reserva;
//			
//			if isnull(ld_reserva_total) then ld_reserva_total = 0
//			
			
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

type dw_4 from datawindow within w_facturacion
boolean visible = false
integer x = 32
integer y = 20
integer width = 3717
integer height = 2228
integer taborder = 60
boolean bringtotop = true
boolean titlebar = true
string title = "Impresión de Factura"
string dataobject = "dw_imprimir_factura_gold"
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

type dw_5 from datawindow within w_facturacion
boolean visible = false
integer x = 1211
integer y = 384
integer width = 1056
integer height = 492
integer taborder = 110
boolean bringtotop = true
boolean titlebar = true
string title = "Actualizar Factura"
string dataobject = "dw_imprime_factura"
boolean controlmenu = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string ls_factura, ls_cuenta, ls_pedido, ls_dw, ls_producto, ls_unidad
decimal{2} ld_fob, ld_promedio, ld_costo_total, ld_cantidad
integer li_existe, i, li_fraccion, li_cantidad_unidad, li_nc
this.accepttext()
choose case dwo.name
	case 'b_actualiza'
		ls_factura = this.getitemstring(1,'factura')
		ls_pedido = dw_1.getitemstring(1,'fact_no_pedido')
		ls_cuenta  = dw_1.getitemstring(1,'fact_ruc_cliente')
		
		if ls_factura = '' or isnull(ls_factura) then
			gf_mensaje('','Numero de Factura Invalido, Verifique !!!',1,1,'E')
			return
		end if
		
		if gf_mensaje('','Esta Seguro de Actualizar la Factura ?',2,1,'E') = 2 then return
		
		li_nc    =		 dw_1.getitemnumber(1,'fact_nota_credito')
		if li_nc = 0 then
		  SELECT count(*)  
			 INTO :li_existe  
			 FROM fatdiari  
			WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
					( fatdiari.fact_empresa = :str.empresa ) AND  
					( fatdiari.fact_ann = :ii_ann ) AND  
					( fatdiari.fact_no_factura = :ls_factura ) and 
					(fatdiari.fact_no_pedido <> :ls_pedido ) and fact_nota_credito = 0;
		else  //Si es Nota de Credito
		  SELECT count(*)  
			 INTO :li_existe  
			 FROM fatdiari  
			WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
					( fatdiari.fact_empresa = :str.empresa ) AND  
					( fatdiari.fact_ann = :ii_ann ) AND  
					( fatdiari.fact_no_factura = :ls_factura ) and 
					(fatdiari.fact_no_pedido <> :ls_pedido ) and fact_nota_credito = 1;			
		end if
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Validar Factura '+sqlca.sqlerrtext,1,1,'E')
				return
			end if

		if li_existe > 0 then
			gf_mensaje('','Factura ya Existe, Verifique !!!',1,1,'E')
			this.setitem(1,'factura',dw_1.getitemstring(1,'fact_no_factura',Primary!, true))
			return
		end if
		datawindow = 1
		
		if dw_1.getitemstring(1,'fact_estado') = 'A' then		
			//Calcula los costos para la factura a actualizar
			for i = 1 to dw_2.rowcount()
				ls_producto = dw_2.getitemstring(i,'facd_codigo_item')
				  SELECT isnull(inmprodu.prod_costo_fob,0),   
							isnull(inmprodu.prod_costo_promedio ,0) 
					 INTO :ld_fob,   
							:ld_promedio  
					 FROM inmprodu  
					WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
							( inmprodu.prod_empresa = :str.empresa ) AND  
							( inmprodu.prod_producto = :ls_producto )   ;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al buscar costos '+sqlca.sqlerrtext,1,1,'E')
							return
						end if
				
				  SELECT count(*)  
					 INTO :li_existe  
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
							( indmovim.dmov_producto = :ls_producto ) AND  
							( intmovim.tmov_estado = 0 ) )   ;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al buscar entradas pendientes '+sqlca.sqlerrtext,1,1,'E')
							return
						end if
	
				//Si existen entradas pendientes se retorna sin actualizar
				if li_existe > 0 then
				//	gf_mensaje('','Existen entradas pendientes por actualizar, Verifique !!!',1,1,'E')
				//	return
				end if
						
				dw_2.setitem(i,'facd_costo_fob',ld_fob)
				dw_2.setitem(i,'facd_costo_cif',ld_promedio)
				ld_cantidad = dw_2.getitemnumber(i,'facd_cantidad')
				li_fraccion   = dw_2.getitemnumber(i,'facd_cantidad_fraccion')
				ls_unidad = dw_2.getitemstring(i,'facd_unidad_venta')
				li_cantidad_unidad = gf_unidad_venta(ls_unidad,0)
				dw_2.setitem(i,'facd_costo_total', round( (ld_cantidad * ld_promedio) + ((ld_promedio / li_cantidad_unidad) * li_fraccion ) ,2) )
			next
			
			parent.triggerevent('ue_aceptar')
		end if
		
		//Si es la cuenta de anulado
		if ls_cuenta = '0736' then			
			
			dw_1.setitem(1,'fact_estado', 'E')	
			dw_1.setitem(1,'fact_no_factura', ls_factura)							
			
					if dw_1.update() = -1 then			
						gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext ,1,1,'E')
						rollback ;
						sqlca.autocommit = true			
						return
					else //Si todo ok
						UPDATE faaparam  
						  SET fara_ult_ultima_factura = :ls_factura  
						WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
								( faaparam.fara_empresa = :str.empresa ) ;
								if sqlca.sqlcode = -1 then
									gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext ,1,1,'E')
									rollback ;
									sqlca.autocommit = true			
									return
								end if			
					end if		
					
					dw_5.visible = false
					
		else//Si no es una cuenta de anulacion				
					
			if wf_actualiza_factura(ls_factura) then
				dw_5.visible = false
			else
				return
			end if
			
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
			
			dw_4.dataobject = ls_dw
			dw_4.settransobject(sqlca)			
			
			parent.triggerevent('ue_print')								

		end if
	case 'b_cancelar'
		dw_5.visible = false		
end choose
end event

type pb_2 from picturebutton within w_facturacion
integer x = 3835
integer y = 248
integer width = 178
integer height = 152
integer taborder = 120
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
ll_tercero = dw_1.getitemnumber(1,'fact_cliente')
str_cc_formatos str_formato2		
str_formato2.tercero = ll_tercero
if ll_tercero > 0 then
	Opensheetwithparm(w_notas,str_formato2,str.frame,2,original!)
end if

end event

type st_2 from statictext within w_facturacion
integer x = 3826
integer y = 396
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

type cb_3 from commandbutton within w_facturacion
boolean visible = false
integer x = 4037
integer y = 284
integer width = 375
integer height = 104
integer taborder = 200
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

if dw_1.getitemstring(1,'fact_estado') = 'A' then
	return
end if
	
	dw_9.reset()

	ls_factura = dw_1.getitemstring(1,'fact_no_factura')
	li_ann	  = dw_1.getitemnumber(1,'fact_ann')
	ldt_fecha_actual = datetime(date(gf_fecha_serv()),lt_time)
	
	 DECLARE fac_encab CURSOR FOR  
  SELECT isnull(fatdiari.fact_condicion_pago,''),   
         fatdiari.fact_fecha,   
         isnull(fatdiari.fact_a_nombre,''),   
         isnull(fatdiari.fact_a_nombre_direccion,''),   
         isnull(fatdiari.fact_consignado,''),   
         isnull(fatdiari.fact_monto_final,0),   
         isnull(fatdiari.fact_marca,''),   
         isnull(fatdiari.fact_tipo_movimiento,''),   
         isnull(fatdiari.fact_ruc_cliente,''),   
         fatdiari.fact_no_pedido,   
         fatdiari.fact_fecha_despacho,   
         isnull(fatdiari.fact_pasaporte,''),   
         isnull(fatdiari.fact_linea_aerea,''),
			fatdiari.fact_metal_pendiente,
			isnull(fatdiari.fact_gastos_total,0),
			isnull(fatdiari.fact_factura_trafico,''),
			isnull(fatdiari.fact_factura_impresa,0),
			fatdiari.fact_fecha_impresion,
			isnull(fatdiari.fact_monto_a_facturar,0)
    FROM fatdiari  
   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
         ( fatdiari.fact_empresa = :str.empresa ) AND  
         ( fatdiari.fact_tipo = '0' ) AND  
         ( fatdiari.fact_ann = :li_ann ) AND  
         ( fatdiari.fact_no_factura = :ls_factura )   ;
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
		
				
		if isnull(dw_9.getitemstring(1,'fact_no_factura'))  then dw_9.setitem(1,'fact_no_factura', ls_factura)
		if isnull(dw_9.getitemstring(1,'fact_no_pedido'))  then dw_9.setitem(1,'fact_no_pedido', ls_pedido)
		dw_9.setitem(1,'fact_fecha', ldt_fecha)
		dw_9.setitem(1,'fact_fecha_despacho', ldt_fecha_despacho)		
		ls_nombre_temp = dw_9.getitemstring(1,'fact_a_nombre')
		if isnull(ls_nombre_temp) or ls_nombre_temp = '' then dw_9.setitem(1,'fact_a_nombre', ls_nombre)		
		ls_direccion_temp = dw_9.getitemstring(1,'fact_a_nombre_direccion')
		if isnull(ls_direccion_temp) or ls_direccion_temp = '' then dw_9.setitem(1,'fact_a_nombre_direccion', ls_direccion)		
		ls_marca_temp = dw_9.getitemstring(1,'fact_marca')
		if isnull(ls_marca_temp) or ls_marca_temp = '' then dw_9.setitem(1,'fact_marca', ls_marca)				
		ls_pasaporte_temp = dw_9.getitemstring(1,'fact_pasaporte')
		if isnull(ls_pasaporte_temp) or ls_pasaporte_temp = ''  then dw_9.setitem(1,'fact_pasaporte', ls_pasaporte)						
		ls_consignado_temp = dw_9.getitemstring(1,'fact_consignado')
		if isnull(ls_consignado_temp) or ls_consignado_temp = '' then dw_9.setitem(1,'fact_consignado', ls_consignado)						
		ls_linea_aerea_temp = dw_9.getitemstring(1,'fact_linea_aerea')		
		if isnull(ls_linea_aerea_temp) or ls_linea_aerea_temp = ''  then dw_9.setitem(1,'fact_linea_aerea', ls_linea_aerea)						
		ls_pasaporte_temp = dw_9.getitemstring(1,'fact_pasaporte')
		if isnull(ls_pasaporte_temp) or ls_pasaporte_temp = ''  then dw_9.setitem(1,'fact_pasaporte', ls_pasaporte)						
		ls_pasaporte_temp = dw_9.getitemstring(1,'fact_tipo_movimiento')
		if isnull(ls_pasaporte_temp) or ls_pasaporte_temp = ''  then dw_9.setitem(1,'fact_tipo_movimiento', ls_tipo_movimiento)								
		ls_cuenta_temp = dw_9.getitemstring(1,'fact_ruc_cliente')
		if isnull(ls_cuenta_temp) or ls_cuenta_temp = '' then dw_9.setitem(1,'fact_ruc_cliente', ls_cuenta)						
		ls_tipo_temp  = dw_9.getitemstring(1,'fact_condicion_pago')
		if isnull(ls_tipo_temp) or ls_tipo_temp = '' then dw_9.setitem(1,'fact_condicion_pago', ls_condicion_pago)								
		ld_gastos_temp = dw_9.getitemnumber(1,'gastos')
		if isnull(ld_gastos_temp) then ld_gastos_temp = 0
		dw_9.setitem(1,'gastos', 0)  //ld_gastos_temp + ld_gastos)
		dw_9.setitem(1,'fact_usuario', str.usuario )

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
		  SELECT faddiari.facd_codigo_item,   
				sum( facd_monto_final ) monto_final,   
				sum( facd_cantidad_fraccion ) fraccion,   
				max(medi_tipo_medida) tipo_medida,   
				case when max(medi_tipo_medida) = 5 then max(inmprodu.prod_descripcion_dos) else case when max(inmprodu.prod_division) = '004' then max(cragrupo.agru_descripcion_grupo) else max(cradivis.adiv_nombre_trafico) end end facd_descripcion_alterna,
				sum( case when facd_cantidad < 0 and facd_rebajar = 0 then 0 else  case when medi_tipo_medida = 10 then 0 else facd_cantidad end end ) cantidad,   
				sum( case when facd_cantidad < 0 and facd_rebajar = 0 then 0 else  case when medi_tipo_medida <> 10 then 0 else facd_cantidad end end ) cantidad_pz , 
			   max(inmprodu.prod_division) division,			
				max(inmprodu.prod_grupo) grupo,
				max(inmprodu.prod_producto_dos) prod_original
		 FROM faddiari,   
				inamedid,
				inmprodu,
				inaaranc,
				cradivis,
				cragrupo
		WHERE ( faddiari.facd_g_financiero = inmprodu.prod_g_financiero ) AND
				( faddiari.facd_empresa = inmprodu.prod_empresa ) AND
				( faddiari.facd_codigo_item = inmprodu.prod_producto ) AND
				( cradivis.adiv_g_financiero = inmprodu.prod_g_financiero ) AND
				( cradivis.adiv_empresa = inmprodu.prod_empresa ) AND
				( cradivis.adiv_codigo_div = inmprodu.prod_division ) AND								
				( cragrupo.agru_g_financiero = inmprodu.prod_g_financiero ) AND
				( cragrupo.agru_empresa = inmprodu.prod_empresa ) AND
				( cragrupo.agru_codigo_div = inmprodu.prod_division ) AND				
				( cragrupo.agru_codigo_grupo = inmprodu.prod_grupo ) AND							
				( inmprodu.prod_arancel = inaaranc.aran_arancel ) AND				
				( faddiari.facd_unidad_venta = inamedid.medi_medida ) and  
				( ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
				( faddiari.facd_empresa = :str.empresa ) AND  
				( faddiari.facd_no_pedido = :ls_pedido ) AND  
				( faddiari.facd_ann = :li_ann ) )   
		GROUP BY faddiari.facd_codigo_item   ;
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
				ls_buscar   = "facd_codigo_item = '"+ls_producto+"'"				
				li_encontro = dw_9.find(ls_buscar, 1, dw_9.rowcount())
				if isnull(li_encontro) then li_encontro = 0
				ls_producto_temp = dw_9.getitemstring(1,'facd_codigo_item')
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
			
			dw_9.setitem(i,'facd_codigo_item',ls_producto)
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
			
			dw_9.setitem(i,'facd_descripcion_alterna',ls_descrip)
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

type dw_9 from datawindow within w_facturacion
boolean visible = false
integer x = 82
integer y = 48
integer width = 3671
integer height = 1720
integer taborder = 210
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

type uo_1 from u_ddcalen within w_facturacion
boolean visible = false
integer x = 1285
integer y = 128
integer taborder = 90
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;datetime ldt_fecha_tran, ldt_fecha_anterior
integer li_ann_anterior
dw_1.SetItem ( dw_1.getrow(), 'fact_fecha', uo_1.return_sel_date() )

if uo_1.allow_close then
	this.visible=false
	dw_1.SetFocus()
	
		ldt_fecha_tran 	 = dw_1.getitemdatetime(dw_1.getrow(),'fact_fecha')		
		ldt_fecha_anterior = dw_1.getitemdatetime(dw_1.getrow(),'fact_fecha', Primary!, True)		
		ii_ann = year(date(dw_1.getitemdatetime(dw_1.getrow(),'fact_fecha')))
		li_ann_anterior = dw_1.getitemnumber(1,'fact_ann')
		
		if not gf_valida_fecha_conta(ldt_fecha_anterior) then			
			dw_1.setitem(1,'fact_fecha', ldt_fecha_anterior)
			dw_1.setcolumn('fact_fecha')
			return
		end if

		if not gf_valida_fecha_conta(ldt_fecha_tran) then			
			dw_1.setitem(1,'fact_fecha', ldt_fecha_anterior)
			dw_1.setcolumn('fact_fecha')
			return
		end if

		if not gf_valida_fecha_futura(ldt_fecha_tran) then			
			if ldt_fecha_tran = ldt_fecha_anterior then
				dw_1.setitem(1,'fact_fecha', date(gf_fecha_serv()))				
			else
				dw_1.setitem(1,'fact_fecha', ldt_fecha_anterior)
			end if
			dw_1.setcolumn('fact_fecha')
			return
		end if
		
		//Si los anios son diferentes asigna el anio
		if ii_ann <> li_ann_anterior then
			dw_1.setitem(1,'fact_ann',ii_ann)
		end if
	
end if


end event

on uo_1.destroy
call u_ddcalen::destroy
end on

type dw_10 from datawindow within w_facturacion
boolean visible = false
integer x = 1381
integer y = 432
integer width = 736
integer height = 516
integer taborder = 160
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
		ls_pedido = dw_9.getitemstring(1,'fact_no_pedido')
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
		
	  UPDATE fatdiari  
		  SET fact_monto_a_facturar = :ld_valor  
		WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
				( fatdiari.fact_empresa = :str.empresa ) AND  
				( fatdiari.fact_tipo = '0' ) AND  
				( fatdiari.fact_no_pedido = :ls_pedido ) AND  
				( fatdiari.fact_ann = :ii_ann ) ;
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

type dw_11 from datawindow within w_facturacion
boolean visible = false
integer x = 229
integer y = 1040
integer width = 2958
integer height = 1068
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "dw_detalle_contable"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type pb_prefactura from picturebutton within w_facturacion
integer x = 2034
integer y = 36
integer width = 110
integer height = 96
integer taborder = 240
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean flatstyle = true
string picturename = "Retrieve!"
alignment htextalign = left!
string powertiptext = "Pasar Proformas ..."
end type

event clicked;str_pase_proforma lstr_proformas
istr_proformas = lstr_proformas
ib_rebajar_proforma = false
pb_prefactura.enabled = false
openwithparm(w_pasar_proformas, istr_proformas) //, w_fa_fondo, 2, Original!)

//istr_proformas = message.powerobjectparm

if not isvalid(istr_proformas) then 
	pb_prefactura.enabled = true
	return
end if

wf_asigna_proforma(istr_proformas)


end event

type cb_4 from commandbutton within w_facturacion
boolean visible = false
integer x = 2706
integer y = 56
integer width = 498
integer height = 104
integer taborder = 250
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Prueba Fiscal"
end type

event clicked;//integer li_retorno
//OpenPort(6)
//
//li_retorno = InitFiscal(Handler)
//if li_retorno < 0 then
//	gf_mensaje('','Fallo InitFiscal: Error '+string(li_retorno),1,1,'E')
//	return
//end if
//
//EnviarStringFiscal('X' + '971231'+'235900')
end event

type em_total from editmask within w_facturacion
integer x = 2935
integer y = 2072
integer width = 718
integer height = 64
integer taborder = 130
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
string text = "TOTAL USD:"
boolean border = false
alignment alignment = right!
textcase textcase = upper!
maskdatatype maskdatatype = stringmask!
end type

type em_subtotal from editmask within w_facturacion
integer x = 2926
integer y = 1848
integer width = 727
integer height = 64
integer taborder = 170
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
string text = "SUB TOTAL FOB:"
boolean border = false
alignment alignment = right!
textcase textcase = upper!
maskdatatype maskdatatype = stringmask!
end type

type dw_8 from datawindow within w_facturacion
boolean visible = false
integer x = 855
integer y = 116
integer width = 663
integer height = 404
integer taborder = 270
boolean bringtotop = true
boolean titlebar = true
string title = "Cambiar # Pedido"
string dataobject = "dw_cambio_de_pedido"
boolean controlmenu = true
string icon = "Function!"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;string ls_pedido, ls_pedido_new
integer li_ann, li_existe
boolean lb_salvo
this.accepttext()
ls_pedido = is_secuencia
ls_pedido_new = this.getitemstring(1,'pedido')
li_ann = dw_1.getitemnumber(1,'fact_ann')

if isnull(ls_pedido_new) or ls_pedido_new = '' then
	gf_mensaje('','Asigne un numero de pedido valido !!!',1,1,'E')
	this.setcolumn('pedido')
	return
end if

  SELECT isnull(count(*),0)  
    INTO :li_existe  
    FROM fatdiari  
   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
         ( fatdiari.fact_empresa = :str.empresa ) AND  
         ( fatdiari.fact_no_pedido = :ls_pedido_new ) AND  
         ( fatdiari.fact_ann = :li_ann )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al validar existencia '+sqlca.sqlerrtext,1,1,'E')
		return
	end if
	if li_existe > 0 then
		gf_mensaje('','El número de Pedido ya existe, Verifique !!!',1,1,'E')
		this.setcolumn('pedido')
		return
	end if
	sqlca.autocommit = false
	gf_fa_cambiar_tipo_fac_anio(ls_pedido, li_ann, ls_pedido_new, lb_salvo)
	sqlca.autocommit = true
	this.setitem(1,'pedido','')
	this.visible = false
	if lb_salvo then
		dw_1.setcolumn('fact_no_pedido')
		dw_1.setitem(1,'fact_no_pedido',ls_pedido_new)
		dw_1.triggerevent('itemchanged')
	end if

	
	
end event

type pb_4 from picturebutton within w_facturacion
boolean visible = false
integer x = 2034
integer y = 148
integer width = 110
integer height = 96
integer taborder = 280
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean flatstyle = true
string picturename = "Retrieve!"
alignment htextalign = left!
end type

event clicked;str_pase_pedido lstr_pedidos
istr_pedidos = lstr_pedidos
ib_rebajar_pedido = false

openwithparm(w_pasar_pedidos, istr_pedidos) //, w_fa_fondo, 2, Original!)

//istr_proformas = message.powerobjectparm

if not isvalid(istr_pedidos) then return

wf_asigna_pedido(istr_pedidos)
	
end event

type dw_12 from datawindow within w_facturacion
boolean visible = false
integer x = 1746
integer y = 328
integer width = 859
integer height = 724
integer taborder = 220
boolean bringtotop = true
boolean titlebar = true
string title = "Copiar Factura"
string dataobject = "dw_external_copiar_factura"
boolean controlmenu = true
string icon = "DataPipeline!"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;this.accepttext()
integer ll_dias_pago, li_ann_actual, li_ann, li_lineas[], i, j, li_eliminar
string ls_sqlerrtext, ls_pedi_actual, ls_pedi, ls_lineas, ls_sql, ls_estado
datetime ldt_fecha_fin_plazo, ldt_fecha_servidor
boolean lb_copiar_detalle = false
time lt_time 
lt_time = time('00:00:00')
choose case dwo.name
	case 'b_cerrar'
		this.visible = false
		dw_2.modify('copiar.visible=false')
	case 'b_copiar'
		sqlca.autocommit = false
		ldt_fecha_servidor = gf_fecha_serv()
		ldt_fecha_servidor = datetime(date(ldt_fecha_servidor), lt_time)
		li_ann_actual = dw_1.getitemnumber(1,'fact_ann')
		ls_estado = dw_1.getitemstring(1,'fact_estado')
		ls_pedi_actual = dw_1.getitemstring(1,'fact_no_pedido')
		li_ann = year(date(ldt_fecha_servidor))
		ls_pedi = this.getitemstring(1,'pedido')
	   li_eliminar = this.getitemnumber(1,'eliminar')
				
		if ls_pedi = '' or isnull(ls_pedi) then return
				
			 select fact_dias_pago
			  into :ll_dias_pago
			  from fatdiari
			  WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
					  ( fatdiari.fact_empresa = :str.empresa ) AND  
					  ( fatdiari.fact_ann = :li_ann_actual ) AND  
					  ( fatdiari.fact_no_pedido = :ls_pedi_actual )   ;
				if sqlca.sqlcode = -1 then
					ls_sqlerrtext = sqlca.sqlerrtext
					rollback;
					mensaje("Información","Error al Insertar registro en fatdiari",ls_sqlerrtext)
					sqlca.autocommit = true
					return
				else
					if sqlca.sqlcode = 0 then
						ldt_fecha_fin_plazo = gf_recupera_dias(ll_dias_pago,date(ldt_fecha_servidor))
					end if
				end if			
		if this.getitemnumber(1,'cp_profo') = 0 then
			j = 0	
			for 	i = 1 to dw_2.rowcount()
				if dw_2.getitemnumber(i,'copiar') = 1 then
					j ++
					li_lineas[j] = dw_2.getitemnumber(i,'facd_linea')					
					if j = 1 then
						ls_lineas = string(li_lineas[j])
					else
						ls_lineas = ls_lineas + ", "+string(li_lineas[j])									
					end if
					lb_copiar_detalle = true
				end if
			next	
			
			//************************************************
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
						  fact_estado,   
						  fact_act_cliente,   
						  fact_act_inventario,   
						  fact_act_conta,   
						  fact_cerrada,   
						  fact_referencia_fac,   
						  fact_monto_abonado,   
						  fact_fecha_act_conta,   
						  fact_pedido_original,   
						  fact_autorizacion,   
						  fact_actualizo_cargos,   
						  fact_actualizo_vendedor,   
						  fact_factura_de_bodega,   
						  fact_viene_de_pedido,   
						  fact_habilitada_por,   
						  fact_cuatro_decimales,   
						  fact_usuario,   
						  fact_precio_a_utilizar,   
						  fact_costos_total,   
						  fact_pasado_a_empresa,
				           fatdiari.fact_pasaporte,   
						fatdiari.fact_linea_aerea,   
						fatdiari.fact_nota_credito,   
						fatdiari.fact_factura_referencia,   
						fatdiari.fact_ann_fact_referencia,   
						fatdiari.fact_paga_itbm,   
						fatdiari.fact_ruc,   
						fatdiari.fact_dv,
						fatdiari.fact_provincia_fe,
						fatdiari.fact_distrito,
						fatdiari.fact_corregimiento,
						fatdiari.fact_tipo_fact,
						fatdiari.fact_itbm_retenido,
						fatdiari.fact_efectivo,
						fatdiari.fact_cheque,
						fatdiari.fact_tarjeta,
						fatdiari.fact_transferencia,
						fatdiari.fact_nota_de_credito,
						fatdiari.fact_intcoterms,
						fatdiari.fact_tipo_ventas,
						fatdiari.fact_tipo_documento,
						fatdiari.fact_cubicaje_total_metros,
						fatdiari.fact_cliente_contado,
						fatdiari.fact_pdt,
						fatdiari.fact_estado_factura)  
				  SELECT fatdiari.fact_g_financiero,   
							fatdiari.fact_empresa,   
							fatdiari.fact_tipo,   
							:ls_pedi,   
							:li_ann,   
							'',   
							fatdiari.fact_cliente,   
							fatdiari.fact_ruc_cliente,   
							fatdiari.fact_condicion_pago,   
							fatdiari.fact_tipo_venta,   
							fatdiari.fact_tipo_movimiento,   
							fatdiari.fact_no_traspaso,   
							:ldt_fecha_servidor,   
							getdate(),
							fatdiari.fact_fecha_modificacion,   
							fatdiari.fact_dias_pago,   
							:ldt_fecha_fin_plazo,   
							fatdiari.fact_fecha_cancelado,   
							fatdiari.fact_consignado,   
							fatdiari.fact_a_nombre,   
							fatdiari.fact_a_nombre_direccion,   
							fatdiari.fact_despachado,   
							fatdiari.fact_via,   
							fatdiari.fact_con_emb_no,   
							fatdiari.fact_marca,   
							fatdiari.fact_bultos_total,   
							fatdiari.fact_cubicaje_total,   
							fatdiari.fact_peso_total,   
							fatdiari.fact_unidad_peso,   
							fatdiari.fact_gastos_total,   
							fatdiari.fact_monto_fact_total,   
							fatdiari.fact_descuento_subt_deta,   
							fatdiari.fact_por_descuento,   
							fatdiari.fact_supervisor,   
							fatdiari.fact_monto_final,   
							fatdiari.fact_comentario,   
							'A',   
							fatdiari.fact_act_cliente,   
							fatdiari.fact_act_inventario,   
							fatdiari.fact_act_conta,   
							fatdiari.fact_cerrada,   
							fatdiari.fact_referencia_fac,   
							fatdiari.fact_monto_abonado,   
							fatdiari.fact_fecha_act_conta,   
							fatdiari.fact_pedido_original,   
							fatdiari.fact_autorizacion,   
							fatdiari.fact_actualizo_cargos,   
							fatdiari.fact_actualizo_vendedor,   
							fatdiari.fact_factura_de_bodega,   
							0,   
							'',   
							fatdiari.fact_cuatro_decimales,   
							:str.usuario,   
							fatdiari.fact_precio_a_utilizar,   
							fatdiari.fact_costos_total,   
							0,
							fatdiari.fact_pasaporte,   
							fatdiari.fact_linea_aerea,   
							fatdiari.fact_nota_credito,   
							fatdiari.fact_factura_referencia,   
							fatdiari.fact_ann_fact_referencia,   
							fatdiari.fact_paga_itbm,   
							fatdiari.fact_ruc,   
							fatdiari.fact_dv,
							fatdiari.fact_provincia_fe,
							fatdiari.fact_distrito,
							fatdiari.fact_corregimiento,
							fatdiari.fact_tipo_fact,
							fatdiari.fact_itbm_retenido,
							fatdiari.fact_efectivo,
							fatdiari.fact_cheque,
							fatdiari.fact_tarjeta,
							fatdiari.fact_transferencia,
							fatdiari.fact_nota_de_credito,
							fatdiari.fact_intcoterms,
							fatdiari.fact_tipo_ventas,
							fatdiari.fact_tipo_documento,
							fatdiari.fact_cubicaje_total_metros,
							fatdiari.fact_cliente_contado,
							0,
							'A'
					 FROM fatdiari  
					 WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
							 ( fatdiari.fact_empresa = :str.empresa ) AND  
							 ( fatdiari.fact_ann = :li_ann_actual ) AND  
							 ( fatdiari.fact_no_pedido = :ls_pedi_actual )   ;
					if sqlca.sqlcode = -1 then
						ls_sqlerrtext = sqlca.sqlerrtext
						rollback;
						mensaje("Información","Error al actualizar registro en fatdiari ",ls_sqlerrtext)
						sqlca.autocommit = true
						return
					end if			

//************************************************
		if lb_copiar_detalle then
			
			ls_sql = "INSERT INTO faddiari ( facd_g_financiero, "+&  
				 " facd_empresa,   "+&
				 " facd_tipo,   "+&
				 " facd_no_pedido, "+&   
				 " facd_pedido_original, "+&   
				 " facd_linea,   "+&
				 " facd_ann,   "+&
				 " facd_producto_servicio, "+&  
				 " facd_codigo_item,   "+&
				 " facd_descripcion_alterna,   "+&
				 " facd_cubicaje,   "+&
				 " facd_peso,   "+&
				 " facd_unidad_peso,   "+&
				 " facd_unidad_producto,  "+& 
				 " facd_precio_mayor, "+&  
				 " facd_precio_menor, "+&   
				 " facd_bodega,   "+&
				 " facd_costo_fob,   "+&
				 " facd_costo_cif,   "+&
				 " facd_precio_unidad_producto,   "+&
				 " facd_unidad_venta,  "+& 
				 " facd_cantidad,   "+&
				 " facd_cantidad_fraccion, "+&  
				 " facd_monto_total,   "+&
				 " facd_por_descuento,   "+&
				 " facd_monto_final,   "+&
				 " facd_fecha_reg,   "+&
				 " facd_usuario,   "+&
				 " facd_supervisor,   "+&
				 " facd_bultos,   "+&
				 " facd_pais,   "+&
				 " facd_ubicacion,   "+&
				 " facd_cant_devuelta,   "+&
				 " facd_linea_articulo_dev,   "+&
				 " facd_cant_asignada,   "+&
				 " facd_index,   "+&
				 " facd_validado,   "+&
				 " facd_viene_de_pedido, "+&  
				 " facd_bulto_inicio,   "+&
				 " facd_bulto_fin,   "+&
				 " facd_precio_original,  "+& 
				 " facd_actualizado, "+&  
				 " facd_costo_total, "+&
		       "    faddiari.facd_modelo,   "+&
				" faddiari.facd_bultos_original,   "+&
				" faddiari.facd_comentario,   "+&
				" faddiari.facd_peso_neto,   "+&
				" faddiari.facd_cubicaje_metros  )  "+&
		  " SELECT faddiari.facd_g_financiero,   "+&
			"		faddiari.facd_empresa, "+&  
			"		faddiari.facd_tipo,  "+& 
					string(ls_pedi) + " , "+&   
			"		faddiari.facd_pedido_original,   "+&
			"		faddiari.facd_linea,   "+&
					string(li_ann) + " , "+&   
			"		faddiari.facd_producto_servicio,   "+&
			"		faddiari.facd_codigo_item,   "+&
			"		faddiari.facd_descripcion_alterna,   "+&
			"		faddiari.facd_cubicaje,   "+&
			"		faddiari.facd_peso,   "+&
			"		faddiari.facd_unidad_peso,   "+&
			"		faddiari.facd_unidad_producto,   "+&
			"		faddiari.facd_precio_mayor,   "+&
			"		faddiari.facd_precio_menor, "+&   
			"		faddiari.facd_bodega,   "+&
			"		faddiari.facd_costo_fob,   "+&
			"		faddiari.facd_costo_cif,   "+&
			"		faddiari.facd_precio_unidad_producto,   "+&
			"		faddiari.facd_unidad_venta,  "+& 
			"		faddiari.facd_cantidad,   "+&
			"		faddiari.facd_cantidad_fraccion, "+&  
			"		faddiari.facd_monto_total,   "+&
			"		faddiari.facd_por_descuento,   "+&
			"		faddiari.facd_monto_final,   "+&
			"		faddiari.facd_fecha_reg,   "+&
			"		faddiari.facd_usuario,   "+&
			"		faddiari.facd_supervisor,   "+&
			"		faddiari.facd_bultos,   "+&
			"		faddiari.facd_pais,   "+&
			"		faddiari.facd_ubicacion,   "+&
			"		faddiari.facd_cant_devuelta,   "+&
			"		faddiari.facd_linea_articulo_dev,   "+&
			"		faddiari.facd_cant_asignada,    "+&
			"		faddiari.facd_index,   "+&
			"		faddiari.facd_validado,   "+&
			"		0,   "+&
			"		faddiari.facd_bulto_inicio,   "+&
			"		faddiari.facd_bulto_fin,   "+&
			"		faddiari.facd_precio_original,   "+&
			"		faddiari.facd_actualizado,   "+&
			"		faddiari.facd_costo_total,"+&
			"		faddiari.facd_modelo,   "+&
			"		faddiari.facd_bultos_original,   "+&
			"		faddiari.facd_comentario,   "+&
			"		faddiari.facd_peso_neto,   "+&
			"		faddiari.facd_cubicaje_metros		"+&			
			" FROM faddiari "+&
			" WHERE ( faddiari.facd_g_financiero = " + string(str.g_financiero) + " ) AND  "+&
			"		 ( faddiari.facd_empresa = " + string(str.empresa) + " ) AND  "+&
			"		 ( faddiari.facd_ann = "+ string(li_ann_actual)+ " ) AND  "+&
			"		 ( faddiari.facd_no_pedido = '" + ls_pedi_actual + "' )  AND "+&
			"		 ( faddiari.facd_linea in ( "+ ls_lineas + " )) "

EXECUTE IMMEDIATE :ls_sql USING SQLCA;

						if sqlca.sqlcode = -1 then
							ls_sqlerrtext = sqlca.sqlerrtext
							rollback;
							mensaje("Información","Error al actualizar registro en faddiari",ls_sqlerrtext)
							sqlca.autocommit = true
							return
						end if						
						
					if ls_estado = 'A' and li_eliminar = 1 then							
						
						ls_sql = " DELETE FROM faddiari "+&
							" WHERE ( faddiari.facd_g_financiero = " + string(str.g_financiero) + " ) AND  "+&
							"		 ( faddiari.facd_empresa = " + string(str.empresa) + " ) AND  "+&
							"		 ( faddiari.facd_ann = "+ string(li_ann_actual)+ " ) AND  "+&
							"		 ( faddiari.facd_no_pedido = '" + ls_pedi_actual + "' )  AND "+&
							"		 ( faddiari.facd_linea in ( "+ ls_lineas + " )) "
												
						EXECUTE IMMEDIATE :ls_sql USING SQLCA;

						if sqlca.sqlcode = -1 then
							ls_sqlerrtext = sqlca.sqlerrtext
							rollback;
							mensaje("Información","Error al Eliminar registro en faddiari",ls_sqlerrtext)
							sqlca.autocommit = true
							return
						end if						
						
						dw_2.retrieve(str.g_financiero, str.empresa, is_secuencia, ii_ann )
						
					end if
						
		else //Copiar Todo
		
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
				  facd_fecha_reg,   
				  facd_usuario,   
				  facd_supervisor,   
				  facd_bultos,   
				  facd_pais,   
				  facd_ubicacion,   
				  facd_cant_devuelta,   
				  facd_linea_articulo_dev,   
				  facd_cant_asignada,   
				  facd_index,   
				  facd_validado,   
				  facd_viene_de_pedido,   
				  facd_bulto_inicio,   
				  facd_bulto_fin,   
				  facd_precio_original,   
				  facd_actualizado,   
				  facd_costo_total,
		           faddiari.facd_modelo,   
				faddiari.facd_bultos_original,   
				faddiari.facd_comentario,   
				faddiari.facd_peso_neto,   
				faddiari.facd_cubicaje_metros  )  
		  SELECT faddiari.facd_g_financiero,   
					faddiari.facd_empresa,   
					faddiari.facd_tipo,   
					:ls_pedi,   
					faddiari.facd_pedido_original,   
					faddiari.facd_linea,   
					:li_ann,   
					faddiari.facd_producto_servicio,   
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
					faddiari.facd_index,   
					faddiari.facd_validado,   
					0,   
					faddiari.facd_bulto_inicio,   
					faddiari.facd_bulto_fin,   
					faddiari.facd_precio_original,   
					faddiari.facd_actualizado,   
					faddiari.facd_costo_total,
					faddiari.facd_modelo,   
					faddiari.facd_bultos_original,   
					faddiari.facd_comentario,   
					faddiari.facd_peso_neto,   
					faddiari.facd_cubicaje_metros					
			 FROM faddiari 
			 WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
					 ( faddiari.facd_empresa = :str.empresa) AND  
					 ( faddiari.facd_ann = :li_ann_actual ) AND  
					 ( faddiari.facd_no_pedido = :ls_pedi_actual )   ;
						if sqlca.sqlcode = -1 then
							ls_sqlerrtext = sqlca.sqlerrtext
							rollback;
							mensaje("Información","Error al actualizar registro en fadprofo",ls_sqlerrtext)
							sqlca.autocommit = true
							return
						end if			
						
		end if //Del copiar todo
//************************************************
			  INSERT INTO fadvenfa  
					( vfac_g_financiero,   
					  vfac_empresa,   
					  vfac_tipo,   
					  vfac_no_pedido,   
					  vfac_ann,   
					  vfac_vendedor )  
			  SELECT fadvenfa.vfac_g_financiero,   
						fadvenfa.vfac_empresa,   
						fadvenfa.vfac_tipo,   
						:ls_pedi,   
						:li_ann,   
						fadvenfa.vfac_vendedor  
				 FROM fadvenfa  
				 WHERE ( fadvenfa.vfac_g_financiero = :str.g_financiero ) AND  
						 ( fadvenfa.vfac_empresa = :str.empresa ) AND  
						 ( fadvenfa.vfac_ann = :li_ann_actual ) AND  
						 ( fadvenfa.vfac_no_pedido = :ls_pedi_actual )   ;
							if sqlca.sqlcode = -1 then
								ls_sqlerrtext = sqlca.sqlerrtext
								rollback;
								mensaje("Información","Error al actualizar registro en fadvenpr",ls_sqlerrtext)
								sqlca.autocommit = true
								return
							end if			
//************************************************
			  INSERT INTO fadcargo  
						( dcar_g_financiero,   
						  dcar_empresa,   
						  dcar_tipo,   
						  dcar_no_pedido,   
						  dcar_ann,   
						  dcar_codigo,   
						  dcar_monto )  
				  SELECT fadcargo.dcar_g_financiero,   
							fadcargo.dcar_empresa,   
							fadcargo.dcar_tipo,
							:ls_pedi,   
							:li_ann,   
							fadcargo.dcar_codigo,   
							fadcargo.dcar_monto  
					 FROM fadcargo 
					 WHERE ( fadcargo.dcar_g_financiero = :str.g_financiero ) AND  
							 ( fadcargo.dcar_empresa = :str.empresa ) AND  
							 ( fadcargo.dcar_no_pedido = :ls_pedi_actual ) and
							 ( fadcargo.dcar_ann = :li_ann_actual ) ;
								if sqlca.sqlcode = -1 then
									ls_sqlerrtext = sqlca.sqlerrtext
									rollback;
									mensaje("Información","Error al actualizar registro en fadproca",ls_sqlerrtext)
									sqlca.autocommit = true
									return
								end if			


else	//Copiar factura a proforma
			  INSERT INTO fatprofo  
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
						  prof_usuario )  
				  SELECT fatdiari.fact_g_financiero,   
							fatdiari.fact_empresa,   
							fatdiari.fact_tipo,   
							:ls_pedi,   
							:li_ann,   
							fatdiari.fact_cliente,   
							fatdiari.fact_ruc_cliente,   
							fatdiari.fact_condicion_pago,   
							fatdiari.fact_tipo_venta,   
							fatdiari.fact_tipo_movimiento,   
							fatdiari.fact_no_traspaso,   
							:ldt_fecha_servidor,	//Para mantener la misma de la factura
							getdate(),
							fatdiari.fact_fecha_modificacion,   
							fatdiari.fact_dias_pago,   
							fatdiari.fact_consignado,   
							fatdiari.fact_a_nombre,   
							fatdiari.fact_a_nombre_direccion,   
							fatdiari.fact_despachado,   
							fatdiari.fact_via,   
							fatdiari.fact_con_emb_no,   
							fatdiari.fact_marca,   
							fatdiari.fact_bultos_total,   
							fatdiari.fact_cubicaje_total,   
							fatdiari.fact_peso_total,   
							fatdiari.fact_unidad_peso,   
							fatdiari.fact_gastos_total,   
							fatdiari.fact_monto_fact_total,   
							fatdiari.fact_descuento_subt_deta,   
							fatdiari.fact_por_descuento,   
							fatdiari.fact_supervisor,   
							fatdiari.fact_monto_final,   
							fatdiari.fact_comentario,   
							'A',   
							fatdiari.fact_no_factura, //En el documento, para que salga la factura
							fatdiari.fact_actualizo_cargos,   
							fatdiari.fact_actualizo_vendedor,   							
							fatdiari.fact_factura_de_bodega,   
							:ldt_fecha_fin_plazo,
							fatdiari.fact_autorizacion,   						
							fatdiari.fact_cuatro_decimales,   
							fatdiari.fact_precio_a_utilizar,   
							fatdiari.fact_costos_total,   							
							:str.usuario		
					 FROM fatdiari  
					 WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
							 ( fatdiari.fact_empresa = :str.empresa ) AND  
							 ( fatdiari.fact_ann = :li_ann_actual ) AND  
							 ( fatdiari.fact_no_pedido = :ls_pedi_actual )   ;							

					if sqlca.sqlcode = -1 then
						ls_sqlerrtext = sqlca.sqlerrtext
						rollback;
						mensaje("Información","Error al actualizar registro en fatdiari ",ls_sqlerrtext)
						sqlca.autocommit = true
						return
					end if			
				
				//Detalle de la factura
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
							  dpro_costo_total )  
					  SELECT faddiari.facd_g_financiero,   
								faddiari.facd_empresa,   
								:ls_pedi,   
								:li_ann,   
								faddiari.facd_linea,   
								faddiari.facd_producto_servicio,   
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
								faddiari.facd_ubicacion,   
								0,
								faddiari.facd_index,   
								faddiari.facd_validado,   
								faddiari.facd_bulto_inicio,   
								faddiari.facd_bulto_fin,  								
								faddiari.facd_precio_original,   
								faddiari.facd_costo_total  
						 FROM faddiari 
						 WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
								 ( faddiari.facd_empresa = :str.empresa) AND  
								 ( faddiari.facd_ann = :li_ann_actual ) AND  
								 ( faddiari.facd_no_pedido = :ls_pedi_actual )   ;
						if sqlca.sqlcode = -1 then
							ls_sqlerrtext = sqlca.sqlerrtext
							rollback;
							mensaje("Información","Error al actualizar registro en fadprofo",ls_sqlerrtext)
							sqlca.autocommit = true
							return
						end if					
						//Cargos de la proforma
						  INSERT INTO fadproca  
									( prca_g_financiero,   
									  prca_empresa,   
									  prca_ann,   
									  prca_no_proforma,   
									  prca_codigo_cargo,   
									  prca_monto )  
							  SELECT fadcargo.dcar_g_financiero,   
										fadcargo.dcar_empresa,   
										:li_ann,   										
										:ls_pedi,   
										fadcargo.dcar_codigo,   
										fadcargo.dcar_monto  
								 FROM fadcargo 
								 WHERE ( fadcargo.dcar_g_financiero = :str.g_financiero ) AND  
										 ( fadcargo.dcar_empresa = :str.empresa ) AND  
										 ( fadcargo.dcar_no_pedido = :ls_pedi_actual ) and
										 ( fadcargo.dcar_ann = :li_ann_actual ) ;
							if sqlca.sqlcode = -1 then
								ls_sqlerrtext = sqlca.sqlerrtext
								rollback;
								mensaje("Información","Error al actualizar registro en fadproca ",ls_sqlerrtext)
								sqlca.autocommit = true
								return
							end if			
					//************************************************
					  INSERT INTO fadvenpr  
								( vpro_g_financiero,   
								  vpro_empresa,   
								  vpro_tipo,   
								  vpro_no_proforma,   
								  vpro_ann,   
								  vpro_vendedor )  
						  SELECT fadvenfa.vfac_g_financiero,   
									fadvenfa.vfac_empresa,   
									fadvenfa.vfac_tipo,   
									:ls_pedi,   
									:li_ann,   
									fadvenfa.vfac_vendedor  
							 FROM fadvenfa  
							 WHERE ( fadvenfa.vfac_g_financiero = :str.g_financiero ) AND  
									 ( fadvenfa.vfac_empresa = :str.empresa ) AND  
									 ( fadvenfa.vfac_ann = :li_ann_actual ) AND  
									 ( fadvenfa.vfac_no_pedido = :ls_pedi_actual )   ;
								if sqlca.sqlcode = -1 then
									ls_sqlerrtext = sqlca.sqlerrtext
									rollback;
									mensaje("Información","Error al actualizar registro en fadvenpr ",ls_sqlerrtext)
									sqlca.autocommit = true
									return
								end if			
					 
end if

commit ;
sqlca.autocommit = true
beep(1)
this.visible = false
dw_2.modify('copiar.visible=false')
end choose
end event

event itemchanged;dw_12.accepttext()
integer li_ann
long ll_max
if dwo.name = 'cp_profo' then
	li_ann = year(date(gf_fecha_serv()))
	if integer(data) = 0 then		
			this.modify("proforma_t.text = 'Pedido:'")
			
			select max(convert(numeric(10), fact_no_pedido ))
			into	:ll_max
			from fatdiari
			where fact_g_financiero = :str.g_financiero and
					fact_empresa		= :str.empresa and
					fact_ann				= :li_ann and
					fact_pdt = 0 ;
	else
			this.modify("proforma_t.text = 'Proforma:'")
			select max(convert(numeric(10), prof_no_proforma ))
			into	:ll_max
			from fatprofo
			where prof_g_financiero = :str.g_financiero and
					prof_empresa		= :str.empresa and
					prof_ann				= :li_ann and
					prof_pdt = 0;
	end if
		if sqlca.sqlcode = -1  then
			gf_mensaje('','Error al Buscar Secuencia '+sqlca.sqlerrtext,1,1,'E')		
			return
		end if	
		
		if isnull(ll_max) then ll_max = 0		
		ll_max ++
		dw_12.setitem(1,'pedido',string(ll_max))
end if
end event

type pb_entradas from picturebutton within w_facturacion
integer x = 4041
integer y = 28
integer width = 105
integer height = 96
integer taborder = 300
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean flatstyle = true
string picturename = "SelectObject!"
alignment htextalign = left!
string powertiptext = "Pasar Entradas ..."
end type

event clicked;str_pase_entradas lstr_entradas
istr_entradas = lstr_entradas
ib_rebaja_entrada = false
pb_prefactura.enabled = false
openwithparm(w_pasar_entradas, istr_entradas) //, w_fa_fondo, 2, Original!)

if not isvalid(istr_entradas) then return

wf_asigna_entrada(istr_entradas)


end event

type dw_13 from datawindow within w_facturacion
integer x = 46
integer y = 368
integer width = 1879
integer height = 80
integer taborder = 260
boolean bringtotop = true
string dataobject = "dw_pais_region_tercero"
boolean border = false
borderstyle borderstyle = styleraised!
end type

event itemchanged;this.accepttext()
choose case dwo.name
	case "terc_pais"
			idwc_region.Retrieve (long (data))
			dw_1.setitem(1,'pais',long (data))			
			this.setitem(1,'terc_region',0)
			dw_1.accepttext()
end choose
end event

event retrieveend;long ll_pais
if rowcount = 0 then return
ll_pais = this.getitemnumber(1,'terc_pais')
idwc_region.retrieve(ll_pais)
dw_1.setitem(1,'pais',ll_pais)
dw_1.accepttext()
end event

type dw_14 from datawindow within w_facturacion
integer x = 50
integer y = 532
integer width = 2171
integer height = 80
integer taborder = 290
boolean bringtotop = true
string title = "none"
string dataobject = "dw_correo_tel_tercero"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;this.accepttext()
string ls_correo, ls_telefono
choose case dwo.name
	case 'terc_email'
		ls_correo = this.getitemstring(1,'terc_email')
		if pos(ls_correo,'@') = 0 then
			gf_mensaje('','El Formato del Correo no es Válido, Verifique !!!',1,1,'E')
			dw_14.setcolumn('terc_email')
			return 2
		end if

	case 'terc_telefono1'
		ls_telefono = this.getitemstring(1,'terc_telefono1')
		if pos(ls_telefono,'-') = 0 then
			gf_mensaje('','El Formato del Teléfono no es Válido, Verifique !!!. Debe ser ###-#### o ####-####',1,1,'E')
			dw_14.setcolumn('terc_telefono1')
			return 2
		end if

end choose

if this.update() = -1 then
	//gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
end if
end event

type cb_5 from commandbutton within w_facturacion
integer x = 3817
integer y = 680
integer width = 288
integer height = 104
integer taborder = 310
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Enviar"
end type

event clicked;string ls_cadena, ls_factura, ls_estado
integer li_retorno
dw_1.accepttext()
ls_estado = dw_1.getitemstring(1,'estado')
if long(ls_estado) = 200 then return	
ls_factura = dw_1.getitemstring(1,'fact_no_factura')
is_sucursal = '0001'
is_tipo = dw_1.getitemstring(1,'fact_tipo')
ls_cadena = string(str.g_financiero)+','+string(str.empresa)+','+'"'+is_tipo+'"'+ ','+'"'+is_sucursal+'"'+','+'"'+is_secuencia+'"'+','+string(ii_ann)+','+'"'+ls_factura+'"'
li_retorno = Run('C:\Sistemas\Integracion\IntegraciondirectaCSharpTF.exe '+ls_cadena, Minimized!)
sleep(10)
dw_1.retrieve(str.g_financiero, str.empresa, is_secuencia, ii_ann )


end event

type dw_15 from datawindow within w_facturacion
boolean visible = false
integer x = 87
integer y = 248
integer width = 4160
integer height = 820
integer taborder = 140
boolean bringtotop = true
boolean titlebar = true
string dataobject = "dw_electronica_mensajes"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "Report5!"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_16 from datawindow within w_facturacion
boolean visible = false
integer x = 1664
integer y = 2248
integer width = 686
integer height = 400
integer taborder = 180
boolean bringtotop = true
string title = "none"
string dataobject = "dw_cargos_factura_contabilidad"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_17 from datawindow within w_facturacion
integer x = 59
integer y = 1676
integer width = 960
integer height = 88
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_find_item"
boolean livescroll = true
end type

event editchanged;string ls_modelo
integer li_encontro

ls_modelo = data
li_encontro = dw_2.find('facd_codigo_item like "%'+ls_modelo+'%"',1,dw_2.rowcount())

if li_encontro > 0 then
	dw_2.scrolltorow(li_encontro)
end if
end event

type cb_6 from commandbutton within w_facturacion
integer x = 3803
integer y = 816
integer width = 384
integer height = 116
integer taborder = 320
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Unir Pedidos"
end type

event clicked;String  ls_find,ls_codigo, ls_error
integer li_c, li_b, li_ann
long    ll_lter, ll_fila, ll_linea, ll_linea_nueva
string  ls_lter,ls_des, ls_tipo, ls_producto
decimal{2} ld_saldo, ld_limite
Datawindow        dww
str_dg_dynamic_find	lstr_df

if dw_1.getitemstring(1,'fact_estado') <> 'A' then return

	lstr_df.texto_campo [2,1] = "fatdiari.fact_ann"
	lstr_df.texto_campo [2,2] = "Año"
	lstr_df.texto_campo [2,3] = "fact_ann"
	lstr_df.texto_campo [2,4] = 'I'
	lstr_df.texto_campo [2,5] = '320'	
	lstr_df.texto_campo [1,1] = "fatdiari.fact_no_pedido"
	lstr_df.texto_campo [1,2] = "Pedido"
	lstr_df.texto_campo [1,3] = "fact_no_pedido"
	lstr_df.texto_campo [1,4] = 'V'
	lstr_df.texto_campo [1,5] = '220'	
	lstr_df.texto_campo [3,1] = "fatdiari.fact_a_nombre"
	lstr_df.texto_campo [3,2] = "A Nombre de"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [3,5] = '950'
	lstr_df.texto_campo [4,1] = "fatdiari.fact_fecha"
	lstr_df.texto_campo [4,2] = "Fecha"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '295'
	lstr_df.texto_campo [5,1] = "fatdiari.fact_ruc_cliente"
	lstr_df.texto_campo [5,2] = "Cuenta"
	lstr_df.texto_campo [5,3] = ""
	lstr_df.texto_campo [5,4] = 'V'
	lstr_df.texto_campo [5,5] = '385'
	lstr_df.texto_campo [6,1] = "fact_monto_final"
	lstr_df.texto_campo [6,2] = "Monto"
	lstr_df.texto_campo [6,3] = ""
	lstr_df.texto_campo [6,4] = 'V'

	lstr_df.tabla = " fatdiari "
		
	lstr_df.tabla_where = &
				"WHERE (fatdiari.fact_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(fatdiari.fact_empresa = " + string(str.empresa) + ") 	and " +&
 						 "(fatdiari.fact_estado = 'A') and " + &
						 "(fatdiari.fact_nota_credito = 0  ) and " + &
						 "(fatdiari.fact_no_pedido <> '" + is_secuencia + "') 	and " +&						 
						 "(fatdiari.fact_factura_cierre = 0 ) and (fatdiari.fact_monto_final > 0)" 						 
	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm



If len (ls_find) = 0 Then Return
li_ann = long(right(ls_find, 5))
ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
ls_codigo = mid(ls_codigo,1,pos(ls_codigo,'And') - 1)
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)

  SELECT isnull(max(facd_linea)  ,0)
    INTO :ll_linea_nueva  
    FROM faddiari  
   WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
         ( faddiari.facd_empresa = :str.empresa ) AND  
         ( faddiari.facd_no_pedido = :is_secuencia ) AND  
         ( faddiari.facd_ann = :ii_ann )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al Buscar Linea del pedido '+sqlca.sqlerrtext,1,1,'E')
		return
	end if

if gf_mensaje('','Esta Seguro de Fusionar el Pedido ?',2,1,'E') = 2 then return

sqlca.autocommit = false
	//Guarda el Encabezado del Pedido a Fusionar antes de Eliminarlo
	  INSERT INTO fatdiari_fusion  
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
           fact_estado,   
           fact_act_cliente,   
           fact_act_inventario,   
           fact_act_conta,   
           fact_cerrada,   
           fact_referencia_fac,   
           fact_monto_abonado,   
           fact_fecha_act_conta,   
           fact_pedido_original,   
           fact_autorizacion,   
           fact_actualizo_cargos,   
           fact_actualizo_vendedor,   
           fact_factura_de_bodega,   
           fact_viene_de_pedido,   
           fact_habilitada_por,   
           fact_cuatro_decimales,   
           fact_usuario,   
           fact_precio_a_utilizar,   
           fact_costos_total,   
           fact_pasado_a_empresa,   
           fact_modificada_por,   
           fact_descartada_por,   
           fact_fecha_descarte,   
           fact_viene_de_ventas_diarias,   
           fact_ncr_descuento,   
           fact_descuento_ncr,   
           fact_guia,   
           fact_destino,   
           fact_porcentaje,   
           fact_tipo_costo,   
           fact_metal_pendiente,   
           fact_cierre_de_metal,   
           fact_precio_onza,   
           fact_fix,   
           fact_factura_cierre,   
           fact_excluir_de_reporte,   
           fact_fecha_despacho,   
           fact_pasaporte,   
           fact_linea_aerea,   
           fact_factura_trafico,   
           fact_factura_impresa,   
           fact_fecha_impresion,   
           fact_detalle_liquidacion,   
           fact_monto_a_facturar,   
           fact_pre_factura,   
           fact_ann_pre_factura,   
           fact_recargo_especial,   
           fact_fix_fecha,   
           fact_nota_credito,   
           fact_ann_fact_referencia,   
           fact_factura_referencia,   
           fact_usuario_print,   
           fact_vence_reserva,   
           fact_reserva_vence,   
           fact_paga_itbm,   
           fact_ruc,   
           fact_dv,   
           fact_alerta_vencimiento,   
           fact_provincia_fe,   
           fact_distrito,   
           fact_corregimiento,   
           fact_tipo_fact,   
           fact_itbm_retenido,   
           fact_efectivo,   
           fact_cheque,   
           fact_tarjeta,   
           fact_transferencia,   
           fact_nota_de_credito,   
           fact_intcoterms,   
           fact_tipo_ventas,   
           fact_tipo_documento,   
           fact_cubicaje_total_metros,   
           fact_cliente_contado,   
           fact_pdt )  
     SELECT fatdiari.fact_g_financiero,   
            fatdiari.fact_empresa,   
            fatdiari.fact_tipo,   
            fatdiari.fact_no_pedido,   
            fatdiari.fact_ann,   
            fatdiari.fact_no_factura,   
            fatdiari.fact_cliente,   
            fatdiari.fact_ruc_cliente,   
            fatdiari.fact_condicion_pago,   
            fatdiari.fact_tipo_venta,   
            fatdiari.fact_tipo_movimiento,   
            fatdiari.fact_no_traspaso,   
            fatdiari.fact_fecha,   
            fatdiari.fact_fecha_creacion,   
            fatdiari.fact_fecha_modificacion,   
            fatdiari.fact_dias_pago,   
            fatdiari.fact_fecha_fin_plazo,   
            fatdiari.fact_fecha_cancelado,   
            fatdiari.fact_consignado,   
            fatdiari.fact_a_nombre,   
            fatdiari.fact_a_nombre_direccion,   
            fatdiari.fact_despachado,   
            fatdiari.fact_via,   
            fatdiari.fact_con_emb_no,   
            fatdiari.fact_marca,   
            fatdiari.fact_bultos_total,   
            fatdiari.fact_cubicaje_total,   
            fatdiari.fact_peso_total,   
            fatdiari.fact_unidad_peso,   
            fatdiari.fact_gastos_total,   
            fatdiari.fact_monto_fact_total,   
            fatdiari.fact_descuento_subt_deta,   
            fatdiari.fact_por_descuento,   
            fatdiari.fact_supervisor,   
            fatdiari.fact_monto_final,   
            fatdiari.fact_comentario,   
            fatdiari.fact_estado,   
            fatdiari.fact_act_cliente,   
            fatdiari.fact_act_inventario,   
            fatdiari.fact_act_conta,   
            fatdiari.fact_cerrada,   
            fatdiari.fact_referencia_fac,   
            fatdiari.fact_monto_abonado,   
            fatdiari.fact_fecha_act_conta,   
            fatdiari.fact_pedido_original,   
            fatdiari.fact_autorizacion,   
            fatdiari.fact_actualizo_cargos,   
            fatdiari.fact_actualizo_vendedor,   
            fatdiari.fact_factura_de_bodega,   
            fatdiari.fact_viene_de_pedido,   
            fatdiari.fact_habilitada_por,   
            fatdiari.fact_cuatro_decimales,   
            fatdiari.fact_usuario,   
            fatdiari.fact_precio_a_utilizar,   
            fatdiari.fact_costos_total,   
            fatdiari.fact_pasado_a_empresa,   
            fatdiari.fact_modificada_por,   
            fatdiari.fact_descartada_por,   
            fatdiari.fact_fecha_descarte,   
            fatdiari.fact_viene_de_ventas_diarias,   
            fatdiari.fact_ncr_descuento,   
            fatdiari.fact_descuento_ncr,   
            fatdiari.fact_guia,   
            fatdiari.fact_destino,   
            fatdiari.fact_porcentaje,   
            fatdiari.fact_tipo_costo,   
            fatdiari.fact_metal_pendiente,   
            fatdiari.fact_cierre_de_metal,   
            fatdiari.fact_precio_onza,   
            fatdiari.fact_fix,   
            fatdiari.fact_factura_cierre,   
            fatdiari.fact_excluir_de_reporte,   
            fatdiari.fact_fecha_despacho,   
            fatdiari.fact_pasaporte,   
            fatdiari.fact_linea_aerea,   
            fatdiari.fact_factura_trafico,   
            fatdiari.fact_factura_impresa,   
            fatdiari.fact_fecha_impresion,   
            fatdiari.fact_detalle_liquidacion,   
            fatdiari.fact_monto_a_facturar,   
            fatdiari.fact_pre_factura,   
            fatdiari.fact_ann_pre_factura,   
            fatdiari.fact_recargo_especial,   
            fatdiari.fact_fix_fecha,   
            fatdiari.fact_nota_credito,   
            fatdiari.fact_ann_fact_referencia,   
            fatdiari.fact_factura_referencia,   
            fatdiari.fact_usuario_print,   
            fatdiari.fact_vence_reserva,   
            fatdiari.fact_reserva_vence,   
            fatdiari.fact_paga_itbm,   
            fatdiari.fact_ruc,   
            fatdiari.fact_dv,   
            fatdiari.fact_alerta_vencimiento,   
            fatdiari.fact_provincia_fe,   
            fatdiari.fact_distrito,   
            fatdiari.fact_corregimiento,   
            fatdiari.fact_tipo_fact,   
            fatdiari.fact_itbm_retenido,   
            fatdiari.fact_efectivo,   
            fatdiari.fact_cheque,   
            fatdiari.fact_tarjeta,   
            fatdiari.fact_transferencia,   
            fatdiari.fact_nota_de_credito,   
            fatdiari.fact_intcoterms,   
            fatdiari.fact_tipo_ventas,   
            fatdiari.fact_tipo_documento,   
            fatdiari.fact_cubicaje_total_metros,   
            fatdiari.fact_cliente_contado,   
            fatdiari.fact_pdt  
       FROM fatdiari  
      WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
            ( fatdiari.fact_empresa = :str.empresa ) AND  
            ( fatdiari.fact_no_pedido = :ls_codigo ) AND  
            ( fatdiari.fact_ann = :li_ann )   ;
	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		sqlca.autocommit = true
		gf_mensaje('','Error al Guardar Encabezado del pedido '+ls_error,1,1,'E')		
		return
	end if

	//Guarda el Detalle Para BAckup
  INSERT INTO faddiari_fusion  
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
           facd_fecha_reg,   
           facd_usuario,   
           facd_supervisor,   
           facd_bultos,   
           facd_pais,   
           facd_ubicacion,   
           facd_cant_devuelta,   
           facd_linea_articulo_dev,   
           facd_cant_asignada,   
           facd_index,   
           facd_validado,   
           facd_viene_de_pedido,   
           facd_bulto_inicio,   
           facd_bulto_fin,   
           facd_precio_original,   
           facd_actualizado,   
           facd_costo_total,   
           facd_bultos_cambiados,   
           facd_peso_cambiado,   
           facd_cubicaje_cambiado,   
           facd_lote,   
           facd_precio_descuento,   
           facd_descuento_ncr,   
           facd_precio_recargo,   
           facd_metal_pendiente,   
           facd_cantidad_cerrada,   
           facd_rebajar,   
           facd_cantidad_orden,   
           facd_monto_orden,   
           facd_modelo,   
           facd_bultos_original,   
           facd_comentario,   
           facd_peso_neto,   
           facd_cubicaje_metros,   
           facd_aplica_descuento,   
           facd_ann_pedido_original,   
           facd_linea_pedido_original )  
     SELECT faddiari.facd_g_financiero,   
            faddiari.facd_empresa,   
            faddiari.facd_tipo,   
            faddiari.facd_no_pedido,   
            faddiari.facd_pedido_original,   
            faddiari.facd_linea,   
            faddiari.facd_ann,   
            faddiari.facd_producto_servicio,   
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
            faddiari.facd_index,   
            faddiari.facd_validado,   
            faddiari.facd_viene_de_pedido,   
            faddiari.facd_bulto_inicio,   
            faddiari.facd_bulto_fin,   
            faddiari.facd_precio_original,   
            faddiari.facd_actualizado,   
            faddiari.facd_costo_total,   
            faddiari.facd_bultos_cambiados,   
            faddiari.facd_peso_cambiado,   
            faddiari.facd_cubicaje_cambiado,   
            faddiari.facd_lote,   
            faddiari.facd_precio_descuento,   
            faddiari.facd_descuento_ncr,   
            faddiari.facd_precio_recargo,   
            faddiari.facd_metal_pendiente,   
            faddiari.facd_cantidad_cerrada,   
            faddiari.facd_rebajar,   
            faddiari.facd_cantidad_orden,   
            faddiari.facd_monto_orden,   
            faddiari.facd_modelo,   
            faddiari.facd_bultos_original,   
            faddiari.facd_comentario,   
            faddiari.facd_peso_neto,   
            faddiari.facd_cubicaje_metros,   
            faddiari.facd_aplica_descuento,   
            faddiari.facd_ann_pedido_original,   
            faddiari.facd_linea_pedido_original  
       FROM faddiari  
      WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
            ( faddiari.facd_empresa = :str.empresa ) AND  
            ( faddiari.facd_no_pedido = :ls_codigo ) AND  
            ( faddiari.facd_ann = :li_ann )   ;
	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		sqlca.autocommit = true
		gf_mensaje('','Error al Guardar detalle del pedido '+ls_error,1,1,'E')		
		return
	end if
	

 DECLARE cur_detalle CURSOR FOR  
  SELECT faddiari.facd_linea,   
         faddiari.facd_codigo_item,   
         faddiari.facd_tipo  
    FROM faddiari,   
         fatdiari  
   WHERE ( fatdiari.fact_g_financiero = faddiari.facd_g_financiero ) and  
         ( fatdiari.fact_empresa = faddiari.facd_empresa ) and  
         ( fatdiari.fact_tipo = faddiari.facd_tipo ) and  
         ( fatdiari.fact_no_pedido = faddiari.facd_no_pedido ) and  
         ( fatdiari.fact_ann = faddiari.facd_ann ) and  
         ( ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
         ( faddiari.facd_empresa = :str.empresa ) AND  
         ( faddiari.facd_no_pedido = :ls_codigo ) AND  
         ( faddiari.facd_ann = :li_ann ) AND  
         ( fatdiari.fact_estado = 'A' ) )   ;
	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		gf_mensaje('','Error al Declarar cursor detalle del pedido '+ls_error,1,1,'E')
		sqlca.autocommit = true
		return
	end if
		
	open cur_detalle;
	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		sqlca.autocommit = true
		gf_mensaje('','Error al Abirir cursor detalle del pedido '+ls_error,1,1,'E')
		return
	end if
	
	fetch cur_detalle into :ll_linea, :ls_producto, :ls_tipo ; 
	
	do while sqlca.sqlcode = 0
			
			ll_linea_nueva ++
			
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
				  facd_fecha_reg,   
				  facd_usuario,   
				  facd_supervisor,   
				  facd_bultos,   
				  facd_pais,   
				  facd_ubicacion,   
				  facd_cant_devuelta,   
				  facd_linea_articulo_dev,   
				  facd_cant_asignada,   
				  facd_index,   
				  facd_validado,   
				  facd_viene_de_pedido,   
				  facd_bulto_inicio,   
				  facd_bulto_fin,   
				  facd_precio_original,   
				  facd_actualizado,   
				  facd_costo_total,   
				  facd_bultos_cambiados,   
				  facd_peso_cambiado,   
				  facd_cubicaje_cambiado,   
				  facd_lote,   
				  facd_precio_descuento,   
				  facd_descuento_ncr,   
				  facd_precio_recargo,   
				  facd_metal_pendiente,   
				  facd_cantidad_cerrada,   
				  facd_rebajar,   
				  facd_cantidad_orden,   
				  facd_monto_orden,   
				  facd_modelo,   
				  facd_bultos_original,   
				  facd_comentario,   
				  facd_peso_neto,   
				  facd_cubicaje_metros,   
				  facd_aplica_descuento,   
				  facd_ann_pedido_original,   
				  facd_linea_pedido_original )  
		  SELECT faddiari.facd_g_financiero,   
					faddiari.facd_empresa,   
					:is_tipo,   
					:is_secuencia,   
					:ls_codigo,   
					:ll_linea_nueva,   
					:ii_ann,   
					faddiari.facd_producto_servicio,   
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
					faddiari.facd_index,   
					faddiari.facd_validado,   
					faddiari.facd_viene_de_pedido,   
					faddiari.facd_bulto_inicio,   
					faddiari.facd_bulto_fin,   
					faddiari.facd_precio_original,   
					faddiari.facd_actualizado,   
					faddiari.facd_costo_total,   
					faddiari.facd_bultos_cambiados,   
					faddiari.facd_peso_cambiado,   
					faddiari.facd_cubicaje_cambiado,   
					faddiari.facd_lote,   
					faddiari.facd_precio_descuento,   
					faddiari.facd_descuento_ncr,   
					faddiari.facd_precio_recargo,   
					faddiari.facd_metal_pendiente,   
					faddiari.facd_cantidad_cerrada,   
					faddiari.facd_rebajar,   
					faddiari.facd_cantidad_orden,   
					faddiari.facd_monto_orden,   
					faddiari.facd_modelo,   
					faddiari.facd_bultos_original,   
					faddiari.facd_comentario,   
					faddiari.facd_peso_neto,   
					faddiari.facd_cubicaje_metros,   
					faddiari.facd_aplica_descuento,   
					:li_ann,   
					:ll_linea  
			 FROM faddiari  
			WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
					( faddiari.facd_empresa = :str.empresa ) AND  
					( faddiari.facd_no_pedido = :ls_codigo ) AND  
					( faddiari.facd_ann = :li_ann ) AND  
					( faddiari.facd_linea = :ll_linea )   ;
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					sqlca.autocommit = true
					gf_mensaje('','Error al Insertar Producto al pedido '+ls_error,1,1,'E')
					return
				end if
		
			//Eliminar del Pedido a Fusionar
			DELETE FROM faddiari  
			WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
					( faddiari.facd_empresa = :str.empresa ) AND  
					( faddiari.facd_no_pedido = :ls_codigo ) AND  
					( faddiari.facd_ann = :li_ann ) AND  
					( faddiari.facd_linea = :ll_linea )   ;
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					sqlca.autocommit = true
					gf_mensaje('','Error al Eliminar Producto Del Pedido Original '+ls_error,1,1,'E')
					return
				end if	
		
			fetch cur_detalle into :ll_linea, :ls_producto, :ls_tipo ; 
	loop
	
	//Actualiza el Encabezado a Pasado
			Update fatdiari  
			SEt	fact_estado = 'P',
					fact_monto_fact_total = 0,
					fact_monto_final = 0,
					fact_gastos_total = 0
			WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
					( fatdiari.fact_empresa = :str.empresa ) AND  
					( fatdiari.fact_no_pedido = :ls_codigo ) AND  
					( fatdiari.fact_ann = :li_ann );
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					sqlca.autocommit = true
					gf_mensaje('','Error al Actualizar Estado a Pasado '+ls_error,1,1,'E')
					return
				end if	
	
	commit;
	sqlca.autocommit = true
	dw_2.retrieve(str.g_financiero, str.empresa, is_secuencia, ii_ann)
	gf_mensaje('','Fusion del Pedido Generada Exitosamente',1,1,'E')
end event

type pb_3 from picturebutton within w_facturacion
integer x = 3611
integer y = 860
integer width = 133
integer height = 112
integer taborder = 330
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\sistemas\hymsoft\Art\dba_cancel.bmp"
alignment htextalign = left!
end type

event clicked;datetime ldt_fecha, ldt_fecha_factura
long ll_tercero
decimal ld_monto
string ls_detalle, ls_factura
string ls_cadena, ls_estado
integer li_retorno, li_dias

ldt_fecha_factura = dw_1.getitemdatetime(1,'fact_fecha')			
ldt_fecha  = gf_fecha_serv()
li_dias = DaysAfter ( date(ldt_fecha_factura), date(ldt_fecha) )			

if li_dias > 6 then
	gf_mensaje('','No Puede Anular una Factura despues de 7 dias de Emitida, Verifique !!!',1,1,'E')
	return
end if

	if dw_1.getitemstring(1,'fact_estado') = 'E' then
		gf_mensaje('','La Factura ya fue Anulada, Verifique !!!',1,1,'E')
		return		
	elseif dw_1.getitemstring(1,'fact_estado') = 'A' then
		gf_mensaje('','Solo se pueden Anular facturas Actualizadas Verifique !!!',1,1,'E')
		return				
	elseif dw_1.getitemstring(1,'fact_estado') = 'I' then
		if gf_mensaje('','Esta Seguro de Anular la Factura ?',2,2,'E') = 1 then
			
			OpenWithParm(w_clave_autorizada, parent)

			If is_user = "*" then
				return
			end if			
			
			sqlca.autocommit = false
			
			  UPDATE faddiari  
			  SET	facd_lote = convert(varchar(20), faddiari.facd_cantidad),
					facd_cantidad = 0,   
					facd_cantidad_fraccion = 0,
					facd_monto_total = 0,
					facd_monto_final = 0
			WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
					( faddiari.facd_empresa = :str.empresa ) AND  
					( faddiari.facd_no_pedido = :is_secuencia ) AND  
					( faddiari.facd_ann = :ii_ann )   ;							

			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Actualizar Detalle ' + sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if
			
		   update fatdiari
			 set fact_estado = 'E',
			 	  fact_monto_fact_total = 0,
				  fact_monto_final = 0,
				  fact_costos_total = 0,
				  fact_gastos_total = 0,
				  fact_a_nombre = 'ANULADA - '+ fact_a_nombre
		 	FROM fatdiari  
			WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
					( fatdiari.fact_empresa = :str.empresa ) AND  
					( fatdiari.fact_no_pedido = :is_secuencia ) AND  
					( fatdiari.fact_ann = :ii_ann ) ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Actualizar Encabezado ' + sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if
		
		delete from fadcargo
			WHERE ( fadcargo.dcar_g_financiero = :str.g_financiero ) AND  
					( fadcargo.dcar_empresa = :str.empresa ) AND  
					( fadcargo.dcar_no_pedido = :is_secuencia ) AND  
					( fadcargo.dcar_ann = :ii_ann )   ;							

			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Actualizar Detalle ' + sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if
			

		//libera las ordenes asociadas a la factura
		ls_factura = dw_1.getitemstring(1,'fact_no_factura')		
		
			if not wf_anula_movimiento() then
				sqlca.autocommit = true
				rollback;
				return
			end if
			
			 ldt_fecha  = gf_fecha_serv()
			 ll_tercero = dw_1.getitemnumber(1,'fact_cliente')
			 ld_monto	= dw_1.getitemnumber(1,'fact_monto_final')
			 ls_detalle = 'Se anulo la factura # '+dw_1.getitemstring(1,'fact_no_factura')+' Por: $'+string(ld_monto,'##,###,##0.00')
	
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
		
			
			dw_1.setitem(1,'fact_estado',"E")									
			commit;
			sqlca.autocommit = true
			
			dw_1.accepttext()
//			ls_estado = dw_1.getitemstring(1,'estado')
//			ls_factura = dw_1.getitemstring(1,'fact_no_factura')
//			is_sucursal = '0001'
//			is_tipo = '0'
//			ls_cadena = string(str.g_financiero)+','+string(str.empresa)+','+'"'+is_tipo+'"'+ ','+'"'+is_sucursal+'"'+','+'"'+is_secuencia+'"'+','+string(ii_ann)+','+'"'+ls_factura+'"'
//			li_retorno = Run('C:\Sistemas\Integracion\IntegraciondirectaCSharpTF.exe '+ls_cadena, Minimized!)
//			sleep(7)
//			dw_1.retrieve(str.g_financiero, str.empresa, is_secuencia, ii_ann, is_sucursal )
			
			gf_mensaje('','Anulación Exitosa',1,1,'E')
		end if
		
	end if
end event

type st_3 from statictext within w_facturacion
integer x = 3552
integer y = 980
integer width = 251
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Anular"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_7 from commandbutton within w_facturacion
integer x = 4187
integer y = 940
integer width = 174
integer height = 104
integer taborder = 230
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "AP"
end type

event clicked;string ls_estado_factura, ls_estado

if ii_controla_pedido = 0 then return

ls_estado_factura = dw_1.getitemstring(1,'fact_estado_factura')
ls_estado = dw_1.getitemstring(1,'fact_estado')

if ls_estado_factura = 'B' and ls_estado = 'A' then
		if gf_mensaje('','Reactivar Pedido para Modificar ?',2,1,'Q')  = 1 then
		  UPDATE fatdiari  
			  SET fact_estado_factura = 'A'  
			WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
					( fatdiari.fact_empresa = :str.empresa ) AND  
					( fatdiari.fact_no_pedido = :is_secuencia ) AND  
					( fatdiari.fact_ann = :ii_ann )  and ( fact_estado_factura = 'B'  )	;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Actualizar Estado '+sqlca.sqlerrtext,1,1,'E')
			end if
			dw_1.setitem(1,'fact_estado_factura', 'A')
			is_estado_factura = 'A'
		end if
	end if
end event

