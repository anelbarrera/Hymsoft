//objectcomments Ventana para la Captura de Pedidos
forward
global type w_cierre_metal from w_fa_padre
end type
type dw_2 from datawindow within w_cierre_metal
end type
type dw_3 from datawindow within w_cierre_metal
end type
type cb_2 from commandbutton within w_cierre_metal
end type
type dw_6 from datawindow within w_cierre_metal
end type
type st_1 from statictext within w_cierre_metal
end type
type pb_1 from picturebutton within w_cierre_metal
end type
type dw_7 from datawindow within w_cierre_metal
end type
type dw_4 from datawindow within w_cierre_metal
end type
type dw_5 from datawindow within w_cierre_metal
end type
type pb_2 from picturebutton within w_cierre_metal
end type
type st_2 from statictext within w_cierre_metal
end type
type dw_8 from datawindow within w_cierre_metal
end type
type pb_3 from picturebutton within w_cierre_metal
end type
type st_3 from statictext within w_cierre_metal
end type
type dw_9 from datawindow within w_cierre_metal
end type
type cb_1 from commandbutton within w_cierre_metal
end type
type dw_10 from datawindow within w_cierre_metal
end type
type dw_11 from datawindow within w_cierre_metal
end type
type uo_1 from u_ddcalen within w_cierre_metal
end type
end forward

global type w_cierre_metal from w_fa_padre
integer x = 0
integer y = 0
integer width = 3840
integer height = 2800
string title = "Captura de Facturas"
string menuname = "m_fa_principal"
long backcolor = 82899184
event ue_syscommand pbm_syscommand
event ue_aceptar_por_linea ( )
dw_2 dw_2
dw_3 dw_3
cb_2 cb_2
dw_6 dw_6
st_1 st_1
pb_1 pb_1
dw_7 dw_7
dw_4 dw_4
dw_5 dw_5
pb_2 pb_2
st_2 st_2
dw_8 dw_8
pb_3 pb_3
st_3 st_3
dw_9 dw_9
cb_1 cb_1
dw_10 dw_10
dw_11 dw_11
uo_1 uo_1
end type
global w_cierre_metal w_cierre_metal

type variables
integer ii_ann, datawindow, il_row, ii_cantidad_unidad, ii_cantidad_empaque, ii_vendedor
String  is_entrada, is_unidad_empaque, is_secuencia, is_actualiza, is_tipo, is_unidad, is_descrip, is_item, is_user
date	  idt_desde, idt_hasta
long    il_tiempo, il_segundos, il_secuencia, il_empaque
decimal{4} id_peso, id_cubicaje
decimal{2} id_precio, idec_gastos, id_costo_cif, id_precio_prod, id_credito_adicional
datawindowchild idwc_cliente, idwc_tipo, idwc_vendedores, idwc_dias, idwc_formatos
integer ii_metal_pendiente
end variables

forward prototypes
public function boolean wf_recupera ()
public function boolean wf_orden_nueva ()
public function boolean wf_imprime_vendedor ()
public function boolean wf_asigna_vendedor ()
public subroutine wf_cargos (double ld_cargos)
public function boolean wf_act_detalle ()
public function boolean wf_actualiza_inventario ()
public function boolean wf_act_encabezado ()
public function boolean wf_anula_movimiento ()
public function boolean wf_valida_limite_credito ()
public function boolean wf_setear_user_credito (string as_user, double ad_monto, string as_nota)
public function boolean wf_carga_producto (string as_codigo, ref string ls_descripcion)
public function boolean wf_actualiza_cliente ()
public function boolean wf_act_cargos ()
public function boolean wf_actualiza_factura (string as_factura)
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

str.frame.setmicrohelp('Captura de Pedidos')

return true
end function

public function boolean wf_orden_nueva ();long ll_max
integer li_ann

li_ann = year(date(gf_fecha_serv()))

select max(convert(numeric(10), fact_no_pedido ))
into	:ll_max
from fatdiari
where fact_g_financiero = :str.g_financiero and
		fact_empresa		= :str.empresa and
		fact_ann				= :li_ann ;
	if sqlca.sqlcode = -1  then
		gf_mensaje('','Error al Buscar Secuencia '+sqlca.sqlerrtext,1,1,'E')		
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

public function boolean wf_act_detalle ();//Ciclo For que recorre el DWindow 2 para actualizar en el Detalle de actualizaciones
//str.frame.setmicrohelp("Actualizando el Detalle en Inventario...")
integer li_recorrido, li_grupo, li_empresa, li_linea,  li_ok,&
		  li_anual, li_fraccion
string  ls_aplicacion, ls_tipo_tran, ls_documento, ls_producto, ls_unidad_med, ls_movid,&
		  ls_fabricante, ls_secuencia, ls_codigo, ls_bodega, ls_ubicacion, ls_bodega_des, &
		  ls_ubica_des, ls_concepto,ls_def
double  ld_peso, ld_precio, ld_cubicaje, ld_bulto, ld_cargos, ld_precio_ent, ld_costos, ld_fob, ld_precio_original
long	  ll_cant1, li_secuencia
decimal{3} ld_cantidad

for li_recorrido = 1 to dw_2.rowcount()

ls_codigo = dw_2.getitemstring(li_recorrido,"facd_codigo_item")

 if trim(ls_codigo) <> "" then
	// Asignacion de los datos del DWin. a las variables de memoria
	li_grupo      = str.g_financiero
	li_empresa    = str.empresa
	ls_aplicacion = "FA"
	ls_tipo_tran  = "SA"			//Salida
	ls_secuencia  = dw_1.getitemstring(dw_1.getrow(),"fact_no_factura")
	li_secuencia  = il_secuencia //Se carga al actualizar el encabezado
	ls_documento  = dw_1.getitemstring(dw_1.getrow(),"fact_no_factura")
	li_linea		  = li_recorrido
	ls_bodega	  = '01' //dw_2.getitemString(li_recorrido,"facd_bodega")
	ls_ubicacion  = '01' //dw_2.getitemString(li_recorrido,"facd_ubicacion")
	ls_producto	  = dw_2.getitemstring(li_recorrido,"facd_codigo_item")
	ld_cantidad   = dw_2.getitemnumber(li_recorrido,"facd_cantidad")
	li_fraccion	  = dw_2.getitemnumber(li_recorrido,"facd_cantidad_fraccion")	//Sumar a Cantidad	
	ls_unidad_med = dw_2.getitemstring(li_recorrido,"facd_unidad_venta")
	ld_precio	  = dw_2.getitemnumber(li_recorrido,"facd_precio_unidad_producto")
//	ld_precio_original = dw_2.getitemnumber(li_recorrido,"facd_precio_original")
	ld_cubicaje   =  truncate(round(dw_2.getitemnumber(li_recorrido,"facd_cubicaje"),4),4)
	ld_peso		  = truncate(round(dw_2.getitemnumber(li_recorrido,"facd_peso"),6),6)
	ld_bulto		  = dw_2.getitemnumber(li_recorrido,"facd_bultos")
	ld_costos	  = dw_2.getitemnumber(li_recorrido,"facd_costo_cif")
	ld_fob		  = dw_2.getitemnumber(li_recorrido,"facd_costo_fob")
	ls_movid		  = str.usuario
	ls_concepto	  = is_tipo
	
	
	//Adicion de los datos a la tabla de actualizaciones

	INSERT INTO indmovim  
         ( dmov_g_financiero,   
           dmov_empresa,   
           dmov_aplicacion,   
           dmov_tipo_transaccion,   
           dmov_secuencia,   
           dmov_documento,   
           dmov_linea,   
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
			  dmov_costo_fob)			  
  VALUES ( :li_grupo,   
           :li_empresa,   
           "FA",   
           :ls_tipo_tran,   
           :li_secuencia,   
           :ls_documento,   
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
           :ld_bulto,   
           :ls_movid,   
           :ii_ann,
			  :ls_concepto,
			  :ld_costos,
			  :ld_fob); 

		if sqlca.sqlcode = -1 then
			messagebox("ATENCIÓN SR. USUARIO","Error: "+sqlca.sqlerrtext)
			return false
		end if


		//Insertando detalle del desglose en INDMODET

		//Valida si el producto tiene desglose
		
		If ls_def = '1' then 
			
		End If
		
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
         ( intmovim.tmov_tipo_transaccion = :ls_tipo_tran ) AND  
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

public function boolean wf_act_encabezado ();//Funcion que inserta el encabezado de la factura activa, al detalle de actualizaciones
//de inventario
//Declaracion de variables de memoria
str.frame.setmicrohelp("Actualizando el Encabezado")

integer li_anual
long  ll_cliente,  ll_secuencia
string ls_documento, ls_comen, ls_concepto, ls_fabricante, ls_secuencia, ls_nombre_tercero, &
		 ls_terminos, ls_pedido
datetime ldt_fecha
time	lt_time
double ld_costo, ld_peso, ld_precio, ld_cubicaje, ld_final, ld_cargos, ld_monto

lt_time = time(gf_fecha_serv())

//Cargar los datos en las variables
ls_pedido	 = dw_1.getitemstring(dw_1.getrow(),"fact_no_pedido")
ls_documento = dw_1.getitemstring(dw_1.getrow(),"fact_no_factura")
ls_secuencia = dw_1.getitemstring(dw_1.getrow(),"fact_no_factura")
ll_secuencia = long(ls_secuencia)
ldt_fecha	 = dw_1.getitemdatetime(dw_1.getrow(),"fact_fecha")
ll_cliente   = dw_1.getitemnumber(dw_1.getrow(),"fact_cliente")
ls_nombre_tercero = dw_1.getitemstring(dw_1.getrow(),"fact_a_nombre")
ls_terminos	 = dw_1.getitemstring(dw_1.getrow(),"fact_condicion_pago")
ls_comen		 =	"Factura # "+ls_secuencia+" "+ls_terminos+ "/Ped. "+ls_pedido+" a "+ls_nombre_tercero
//ldw_1.getitemstring(ldw_1.getrow(),"fact_comentario")
ld_final     = dw_1.getitemnumber(dw_1.getrow(),"fact_monto_final")
ld_monto 	 = dw_1.getitemnumber(dw_1.getrow(),"fact_monto_fact_total")
ld_cargos	 = dw_1.getitemnumber(dw_1.getrow(),"fact_gastos_total")

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
			  tmov_rebaja_reserva)  
  VALUES ( :str.g_financiero,   
           :str.empresa,
           "FA",   
           "SA",   		//Tipo de Transaccion
           :ll_secuencia,   
           :ls_concepto,   
           :ldt_fecha,   
           :str.usuario,   		//autorizacion, si necesitó autorización, validar esto
           :ls_documento,
           :ll_cliente,   
           :ls_comen,   
           :str.usuario,
			  "C",				//Tipo Credito
           :ii_ann,
			  :ld_cargos,
			  :ls_nombre_tercero,
			  :ls_pedido,
			  1);

		if sqlca.sqlcode = -1 then
			messagebox("ATENCIÓN SR. USUARIO","Error: "+sqlca.sqlerrtext)
			return false
		end if		

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

str.frame.Setmicrohelp("")

return true
end function

public function boolean wf_valida_limite_credito ();if gf_mensaje('','El Cliente Excedió su Límite de Crédito, Desea autorizar Crédito ? !!!',2,2,'E') = 2 then
	return false
else
	OpenWithParm(w_clave_autorizada_credito, this)

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

public function boolean wf_carga_producto (string as_codigo, ref string ls_descripcion);long ll_cliente
ll_cliente = dw_1.getitemnumber(1,'fact_cliente')
	  SELECT max(inmprodu.prod_descripcion),   
				max(inmprodu.prod_empaque),     
				max(inamedid_a.medi_cantidad),   
				max(inamedid_b.medi_cantidad),
				max(inmprodu.prod_peso),
				max(inmprodu.prod_cubicaje),
				max(inmprodu.prod_precio_mayor),
				max(inmprodu.prod_medida),
				max(inmprodu.prod_costo_cif)
		 INTO :ls_descripcion,   
				:il_empaque,   
				:ii_cantidad_unidad,   
				:ii_cantidad_empaque,
				:id_peso,
				:id_cubicaje,
				:id_precio_prod,
				:is_unidad,
				:id_costo_cif
		 FROM inmprodu,   
				inamedid inamedid_a,   
				inamedid inamedid_b  ,
				faddiari,
				fatdiari
		WHERE ( inamedid_a.medi_medida = inmprodu.prod_medida ) and  
				( inmprodu.prod_empaque_um = inamedid_b.medi_medida ) and  
				( ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
				( inmprodu.prod_empresa = :str.empresa ) AND  
				( inmprodu.prod_producto = :as_codigo )) and
			   ( faddiari.facd_g_financiero = fatdiari.fact_g_financiero ) and  
				( faddiari.facd_empresa = fatdiari.fact_empresa ) and  
				( faddiari.facd_tipo = fatdiari.fact_tipo ) and  
				( faddiari.facd_no_pedido = fatdiari.fact_no_pedido ) and  
				( faddiari.facd_ann = fatdiari.fact_ann ) and  
				( faddiari.facd_g_financiero = inmprodu.prod_g_financiero ) and  
				( faddiari.facd_empresa = inmprodu.prod_empresa ) and  
				( faddiari.facd_codigo_item = inmprodu.prod_producto ) and
				( fatdiari.fact_cliente = :ll_cliente ) and 
				( faddiari.facd_cantidad - faddiari.facd_cantidad_cerrada > 0 );
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al recuperar datos del producto '+sqlca.sqlerrtext,1,1,'E')
				return false
			end if

return true

end function

public function boolean wf_actualiza_cliente ();//Función que afecta la tabla de Actualizaciones en Cliente
//Variables de Memoria
datawindow ldw_1
ldw_1 = dw_1
integer  li_coddias, li_dias, li_ann, li_mes
long     ll_cliente
string   ls_secuencia, ls_pedido, ls_nombre, ls_ruc,ls_subt, ls_comen, ls_transac, ls_error
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

ls_time = '00:00:00'
ldt_fecha = datetime(date(ldt_fecha),time(ls_time))


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
					  movi_comments)
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
					  "D",
					  :ld_monto,   
					  :ldt_fecha,   
					  :str.usuario,
					  "IM",
					  :ldt_fechavence,
					  :ls_comen,
					  :ld_monto,
					  :ls_nombre,
					  'CIERRE DE METAL') ;

if sqlca.sqlerrtext <> "" then	
	ls_error = sqlca.sqlerrtext
	rollback ;
	gf_mensaje("Error","Error al Actualizar el Cliente " +ls_error,1,1,'E')	
	return false
end if	

return true
end function

public function boolean wf_act_cargos ();//Funcion que actualiza el detalle de los cargos
integer li_exist, li_linea,  li_ok
long   ll_factura
string ls_descrip, ls_concepto, ls_pedido
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
		
  DECLARE cursor_gas CURSOR FOR  
  SELECT faacargo.carg_descripcion,   
         fadcargo.dcar_monto  
    FROM fadcargo,   
         faacargo  
   WHERE ( fadcargo.dcar_codigo = faacargo.carg_cargo ) and  
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
		
//		li_ok = sqlca.sqlcode
					
		FETCH cursor_gas INTO :ls_descrip, :ld_monto;				
					
// CASO DE ERROR
//		messagebox("actualiza_det",sqlca.sqlerrtext)

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
			           "SA",
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

public function boolean wf_actualiza_factura (string as_factura);string ls_factura
sqlca.autocommit = false
	ls_factura = dw_5.getitemstring(1,'factura')
	is_tipo = 	 dw_1.getitemstring(1,'fact_tipo')
	dw_1.setitem(1,'fact_no_factura', ls_factura)
//	dw_1.setitem(1,'fact_fecha', date(gf_fecha_serv()))
		
	if wf_actualiza_cliente() then

			dw_1.setitem(1,'fact_estado', 'I')	
			dw_1.setitem(1,'fact_act_cliente', 1)				
			dw_1.setitem(1,'fact_act_inventario', 1)							
			if dw_1.update() = -1 then			
				gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext ,1,1,'E')
				rollback ;
				sqlca.autocommit = true			
				return false
			else //Si todo ok
				  UPDATE faaparam  
				  SET fara_ult_ultima_factura = :ls_factura  
				WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
						( faaparam.fara_empresa = :str.empresa ) ;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext ,1,1,'E')
							rollback ;
							sqlca.autocommit = true			
							return false						
						end if
	
			end if		
			
	else
		rollback ;
		sqlca.autocommit = true
		return false
	end if

commit;
sqlca.autocommit = true
gf_mensaje('','Actualizacion Exitosa',1,1,'E')
return true
end function

on w_cierre_metal.create
int iCurrent
call super::create
if this.MenuName = "m_fa_principal" then this.MenuID = create m_fa_principal
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cb_2=create cb_2
this.dw_6=create dw_6
this.st_1=create st_1
this.pb_1=create pb_1
this.dw_7=create dw_7
this.dw_4=create dw_4
this.dw_5=create dw_5
this.pb_2=create pb_2
this.st_2=create st_2
this.dw_8=create dw_8
this.pb_3=create pb_3
this.st_3=create st_3
this.dw_9=create dw_9
this.cb_1=create cb_1
this.dw_10=create dw_10
this.dw_11=create dw_11
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.dw_6
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.pb_1
this.Control[iCurrent+7]=this.dw_7
this.Control[iCurrent+8]=this.dw_4
this.Control[iCurrent+9]=this.dw_5
this.Control[iCurrent+10]=this.pb_2
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.dw_8
this.Control[iCurrent+13]=this.pb_3
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.dw_9
this.Control[iCurrent+16]=this.cb_1
this.Control[iCurrent+17]=this.dw_10
this.Control[iCurrent+18]=this.dw_11
this.Control[iCurrent+19]=this.uo_1
end on

on w_cierre_metal.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cb_2)
destroy(this.dw_6)
destroy(this.st_1)
destroy(this.pb_1)
destroy(this.dw_7)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.dw_8)
destroy(this.pb_3)
destroy(this.st_3)
destroy(this.dw_9)
destroy(this.cb_1)
destroy(this.dw_10)
destroy(this.dw_11)
destroy(this.uo_1)
end on

event ue_post_open;call super::ue_post_open;idec_gastos = 0
dw_1.settransobject(sqlca);			
dw_2.settransobject(sqlca);	
dw_5.settransobject(sqlca);	
dw_6.settransobject(sqlca);
dw_7.settransobject(sqlca);
dw_8.settransobject(sqlca);
dw_9.settransobject(sqlca);
dw_10.settransobject(sqlca);
dw_11.settransobject(sqlca);
dw_7.insertrow(1)
dw_6.getchild('formato',idwc_formatos)
idwc_formatos.settransobject(sqlca)
idwc_formatos.retrieve()
dw_6.insertrow(1)
dw_6.setitem(1,'formato','1')
ii_ann = year(date(gf_fecha_serv()))
datawindow = 1

dw_1.getchild('fact_tipo', idwc_tipo)
dw_1.getchild('fact_ruc_cliente', idwc_cliente)
dw_1.getchild('vendedor', idwc_vendedores)
dw_1.getchild('fact_dias_pago', idwc_dias)
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
dw_4.getchild('fadvenfa_vfac_vendedor', ldwc_vendedor)
ldwc_vendedor.settransobject(sqlca)
ldwc_vendedor.retrieve(str.g_financiero, str.empresa)

this.triggerevent('ue_adicionar')

//Recupera la secuencia siguiente y da opcion para buscar una
wf_orden_nueva()

str.frame.setmicrohelp('Factura')
//il_tiempo = 150
//em_tiempo.text = string(150)
//timer(1)

this.height = w_fa_fondo.height - 50
pb_3.picturename = str.path+'\Art\dba_cancel.bmp'						
end event

event ue_pre_aceptar;//Override
dw_1.Accepttext()

this.postevent("ue_aceptar")

end event

event ue_adicionar;//Override

if datawindow = 1 then	
	dw_1.reset()
	dw_2.object.cargos.expression = "'"+string(0.00,'#,##0.00')+"'"	//Para blanquear los cargos
	dw_2.reset()
	dw_1.insertrow(1)
	//Pone invisible el insertar	
	dw_1.setitem(1,'fact_g_financiero',str.g_financiero)
	dw_1.setitem(1,'fact_empresa',str.empresa)
	dw_1.setitem(1,'fact_ann',ii_ann)
	dw_1.setitem(1,'fact_fecha',date(gf_fecha_serv()))
	dw_1.setitem(1,'fact_fix_fecha',date(gf_fecha_serv()))
	dw_1.setitem(1,'fact_tipo_venta',2) //exterior
	dw_1.setitem(1,'fact_estado','A')
	dw_1.setitem(1,'fact_metal_pendiente',ii_metal_pendiente)	
	dw_1.setitem(1,'fact_factura_cierre',ii_metal_pendiente)		
	dw_1.setitem(1,'fact_cierre_de_metal',1)
	is_tipo = idwc_tipo.getitemstring(1,'dgmsubse_subs_sub_trans')
	dw_1.setitem(1,'fact_tipo', is_tipo)
	dw_1.setfocus()
	dw_1.setcolumn('fact_ruc_cliente')
	idec_gastos = 0	
	wf_orden_nueva()
else
	if dw_1.rowcount() > 0 then
		if (dw_1.getitemString(1,"fact_estado")) <> 'A' then
			gf_mensaje("Atencion Sr. Usuario","No se puede Modificar una Factura Actualizada, Verifique !!!.",1,1,"E")
			return
		end if	
	end if
	
	if dw_2.getrow() > 0 then	
		if dw_2.getitemstring(dw_2.getrow(), 'facd_codigo_item') <> '' or &
			not isnull(dw_2.getitemstring(dw_2.getrow(), 'facd_codigo_item')) then
			if dw_2.rowcount() < 1 then
				dw_2.scrolltorow(dw_2.insertrow(0))
				dw_2.setitem(dw_2.getrow(),'facd_g_financiero',str.g_financiero)
				dw_2.setitem(dw_2.getrow(),'facd_empresa',str.empresa)
				dw_2.setitem(dw_2.getrow(),'facd_usuario',str.usuario)
				//Para repetir el ultimo item capturado
				dw_2.setitem(dw_2.getrow(),'facd_codigo_item',is_item)
				dw_2.setitem(dw_2.getrow(),'facd_descripcion_alterna',is_descrip)
				dw_2.setitem(dw_2.getrow(),'facd_unidad_venta',is_unidad)			
				dw_2.setitem(dw_2.getrow(),'facd_unidad_producto',is_unidad)		
				dw_2.setitem(dw_2.getrow(),'facd_precio_unidad_producto', id_precio)
				dw_2.setitem(dw_2.getrow(),'facd_precio_original', id_precio)			
				dw_2.setitem(dw_2.getrow(),'facd_costo_cif', id_costo_cif)			
				dw_2.setitem(dw_2.getrow(),'facd_metal_pendiente',ii_metal_pendiente)				
			end if
		end if
	else
		if dw_2.rowcount() = 0 then
			dw_2.scrolltorow(dw_2.insertrow(0))
			dw_2.setitem(dw_2.getrow(),'facd_g_financiero',str.g_financiero)
			dw_2.setitem(dw_2.getrow(),'facd_empresa',str.empresa)
			dw_2.setitem(dw_2.getrow(),'facd_usuario',str.usuario)		
			dw_2.setitem(dw_2.getrow(),'facd_metal_pendiente',ii_metal_pendiente)						
		end if
	end if
	dw_2.setfocus()
	dw_2.setcolumn('facd_codigo_item')
end if

end event

event key;//override
end event

event close;if isvalid(this) then close(this)
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
dw_2.height= newheight - 750
dw_7.y = newheight - 250
pb_3.y = newheight - 160
st_3.y = newheight - 165
end event

event open;//override
this.y = 0
this.x = 805

dw = dw_1

ii_metal_pendiente = message.doubleparm
if ii_metal_pendiente = 1 then
	this.title = 'Facturas - Cierre de Metal'
end if

This.Icon = str.icono

this.postevent("ue_post_open")


This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)

str.frame.SetRedraw ( True )
end event

event ue_print;////override
long ll_tercero
string ls_saldo, ls_numero_palabra
decimal{2} ld_saldo, ld_final
dw_4.settransobject(sqlca)
if is_secuencia = '' then return
dw_4.retrieve(str.g_financiero, str.empresa, is_secuencia , ii_ann, is_tipo)
//
if dw_4.rowcount() = 0 then return
//
//st_1.visible = true
//dw_6.visible = true
//Asigna el saldo del cliente
ll_tercero = dw_4.getitemnumber(1,'fact_cliente')
ld_saldo = gf_saldo_anterior_new( ll_tercero, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)
ls_saldo = string(ld_saldo, '$ ##,##0.00')
if dw_4.Describe("saldo.x") <> "?" and dw_4.Describe("saldo.x") <> "!" then &
	dw_4.object.saldo.expression = "'" + ls_saldo + "'"

//asigna el valor del monto en letras
ld_final = dw_4.getitemnumber(1, "fact_monto_final")
ls_numero_palabra = " *** "+upper(gf_numerlet( round(ld_final,2)  ,1))+" ***"
//if simple
if dw_4.Describe("num_palabra.x") <> "?" and dw_4.Describe("num_palabra.x") <> "!" then &
	dw_4.object.num_palabra.expression = "'" + ls_numero_palabra + "'"

dw_4.object.datawindow.print.preview = 'yes'
dw_4.object.datawindow.print.preview.zoom = 100
dw_4.object.nom_empresa.expression = "'"+str.nombre_empresa+"'"
dw_4.visible = true
//
OpenWithParm(w_dw_print_options, dw_4)
//
If Message.DoubleParm = -1 Then Return
dw_4.Print(True)

end event

event ue_aceptar;integer  li_contador,ll_update,ll_update2,li_encontro,li_lin_ref,li_posicion,li_frac2, li_find, li_total, li_existe
integer  li_costo,anulado=0,li_linea_uno,li_linea_dos,indice, li_existe_detalle, li_empresa ,li_salvar, i, j, li_ann
decimal{2}  ld_cantidad,li_cantid, li_cos_tran, ld_pendiente, ld_cant_cerrada, ld_cantidad_anterior
datetime ldt_fecha,ldt_fecha_real
string   ls_documento,ls_aplic,ls_tipo,ls_medida,ls_producto,ls_concepto, fila, ls_conc,ls_error,ls_cuenta, ls_expresion, ls_doc, ls_pedido
Long		ll_found, ll_ann,ll_secuencia, ll_bultos, ll_lter 
boolean  lb_existe, lb_entro
decimal{2} ldec_monto, ld_limite, ld_saldo
decimal{3} ld_peso, ld_cubicaje

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

if (dw_1.getitemNumber(1,"fact_precio_onza")) = 0 or isnull(dw_1.getitemNumber(1,"fact_precio_onza")) then
	gf_mensaje("Atencion Sr. Usuario","Debe asignar el Precio de la Onza antes de guardar.",1,1,"E")
	dw_1.setcolumn("fact_precio_onza")
	return
end if	

if (dw_1.getitemNumber(1,"fact_fix")) = 0 or isnull(dw_1.getitemNumber(1,"fact_fix")) then
	gf_mensaje("Atencion Sr. Usuario","Debe asignar el Fix de Londres antes de guardar.",1,1,"E")
	dw_1.setcolumn("fact_fix")
	return
end if	


sqlca.autocommit = false

indice = 0

ls_documento = dw_1.getitemstring(1,"fact_no_pedido")
is_secuencia = ls_documento
/*grabamos los datos del DW_1 de la tabla *////////////////
if dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = New! or &
	dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = NewModified! then 	
	
   indice = 1
	
	if (dw_1.getitemString(1,"fact_no_pedido")) = '' or isnull(dw_1.getitemString(1,"fact_no_pedido")) then
		gf_mensaje("Atencion Sr. Usuario","Debe Asignar un valor valido, Verifique.",1,1,"E")
		sqlca.autocommit = true
		return
	end if	
	
		//Para actualizar el monto total de la factura, cuando no se ha grabado y se le da actualizar
	  if dw_2.rowcount() > 0 then
		 ldec_monto  = dw_2.getitemnumber(1,'facd_monto_final')//'monto_total')
		 ld_peso     = dw_2.getitemnumber(1,'peso_total')
		 ld_cubicaje = dw_2.getitemnumber(1,'cubicaje_total')	 
		 ll_bultos   = dw_2.getitemnumber(1,'bultos_total')	 
	  else
		 ldec_monto  = 0
		 ld_peso 	 = 0
		 ld_cubicaje = 0
		 ll_bultos   = 0
	  end if	
	  dw_1.setitem(1,'fact_monto_fact_total',ldec_monto)
	  if isnull(idec_gastos) then idec_gastos = 0 
	  dw_1.setitem(1,'fact_monto_final',ldec_monto + idec_gastos )
	  dw_1.accepttext()	
	
   dw_1.setitem(1,'fact_factura_cierre',1)
	
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
	 ldec_monto  = dw_2.getitemnumber(1,'facd_monto_final')//'monto_total')
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
    UPDATE fatdiari  
     SET fact_bultos_total = :ll_bultos,   
         fact_cubicaje_total = :ld_cubicaje,   
         fact_peso_total = :ld_peso
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
	
  dw_1.setitem(1,'fact_monto_fact_total',ldec_monto)
  if isnull(idec_gastos) then idec_gastos = 0 
  dw_1.setitem(1,'fact_monto_final',ldec_monto + idec_gastos )
  dw_1.setitem(1,'fact_factura_cierre',1)
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
	if ls_producto = "" or isnull(ls_producto) then		
		dw_2.deleterow(li_contador)
		li_contador --
	End If
	dw_2.setitem(li_contador,'facd_tipo',is_tipo)
	dw_2.setitem(li_contador,'facd_no_pedido',is_secuencia)
	dw_2.setitem(li_contador,'facd_ann',ii_ann)
	dw_2.setitem(li_contador,"facd_linea",li_contador)		
	dw_2.setitem(li_contador,"facd_index",li_contador)
	if dw_2.rowcount() = 0 then	
		ld_cantidad = 0
	else
		ld_cantidad = dw_2.getitemnumber(li_contador, 'facd_cantidad')
	end if	
	if dw_2.GetItemStatus(dw_2.getrow(),0,primary! ) = New! or &
		dw_2.GetItemStatus(dw_2.getrow(),0,primary! ) = NewModified! then 	
		for i = 1 to dw_8.rowcount()
			ld_pendiente 	 = dw_8.getitemnumber(i,'pendiente')
			ld_cant_cerrada = dw_8.getitemnumber(i,'facd_cantidad_cerrada')
			if ld_pendiente >= ld_cantidad then
				dw_8.setitem(i,'facd_cantidad_cerrada', round(ld_cant_cerrada + ld_cantidad ,2))
				exit
			else
				ld_cantidad = ld_cantidad - ld_pendiente
				dw_8.setitem(i,'facd_cantidad_cerrada', round(ld_cant_cerrada + ld_pendiente ,2))
			end if
		next
		if dw_8.rowcount() > 0 then
			//cambia el estatus de metal cerrado a la factura inicial de metal pendiente
			if dw_8.getitemnumber(1, 'total') = dw_2.getitemnumber(1, 'facd_cantidad') then 
				ls_pedido = dw_8.getitemstring(1, 'fatdiari_fact_no_pedido')
				li_ann    = dw_8.getitemNumber(1, 'fatdiari_fact_ann')
				
				  UPDATE fatdiari  
					  SET fact_cierre_de_metal = 1
					WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
							( fatdiari.fact_empresa = :str.empresa ) AND  
							( fatdiari.fact_no_pedido = :ls_pedido ) AND  
							( fatdiari.fact_ann = :li_ann )  ;
					if sqlca.sqlcode = -1 then
						ls_error =sqlca.sqlerrtext
						rollback using sqlca;
						sqlca.autocommit = true
						ib_aceptar = False
						is_actualiza=''
						gf_Mensaje("","¡Error al Actualizar Detalle del Pedido! "+ls_error,1,1,'E')
						return								
					end if					
			end if
		end if
		//Si 
	else //si es modificacion
		
		if dw_2.rowcount() = 0 then
			//verificar en el buffer del delete
			
		else
			ld_cantidad_anterior	= dw_2.getitemnumber(li_contador, 'facd_cantidad', primary!, true)
		end if
		//Reasigna en el dw9, que busca lo ultimo cerrado para restaurarlo y luego asignar la nueva cantidad
//		if ld_cantidad <> ld_cantidad_anterior then
//			ll_lter = dw_1.getitemnumber(1,'fact_cliente')
//			//actualiza la cantidad anterior
//			if dw_9.retrieve(str.g_financiero, str.empresa, ll_lter) > 0 then		
////				messAGEbox(string(ld_cantidad),ld_cantidad_anterior)
//				li_total = dw_9.rowcount()
//				for j = li_total to 0 step -1
//					
//					if j = 0 then exit
//					
//					ld_cant_cerrada = dw_9.getitemnumber(j,'facd_cantidad_cerrada')			
//					if ld_cant_cerrada >= ld_cantidad_anterior then
//						dw_9.setitem(j,'facd_cantidad_cerrada',round(ld_cant_cerrada - ld_cantidad_anterior ,2))
//						exit
//					else
//						ld_cantidad_anterior = ld_cantidad_anterior - ld_cant_cerrada
//						dw_9.setitem(j,'facd_cantidad_cerrada',0)
//					end if
//					
//				next
//				
////Se bloquea la tabla al hacer el retrieve del dw8				
////				if dw_9.update() = -1 then
////					ls_error =sqlca.sqlerrtext
////					rollback using sqlca;
////					sqlca.autocommit = true
////					ib_aceptar = False
////					is_actualiza=''
////					gf_Mensaje("","¡Error al Actualizar Detalle del Pedido! "+ls_error,1,1,'E')
////					return								
////				end if
//				
//				//actualiza los pendientes
//				if dw_8.retrieve(str.g_financiero, str.empresa, ll_lter) > 0 then							
//					for i = 1 to dw_8.rowcount()
//						ld_pendiente 	 = dw_8.getitemnumber(i,'pendiente')
//						ld_cant_cerrada = dw_8.getitemnumber(i,'facd_cantidad_cerrada')
//						if ld_pendiente >= ld_cantidad then
//							dw_8.setitem(i,'facd_cantidad_cerrada', round( ld_cant_cerrada + ld_cantidad ,2))
//							exit
//						else
//							ld_cantidad = ld_cantidad - ld_pendiente
//							dw_8.setitem(i,'facd_cantidad_cerrada', round( ld_cant_cerrada + ld_pendiente ,2))
//						end if
//					next
//				end if
//			else //Si modifico y ya se haba devuelto completo, se debe recuperar otro dw para buscar lo cerrado
//				
//			end if
//		end if
	end if //Si las cantidades son diferentes
Next

li_salvar=1

If li_salvar = 1 then //Si todas las bodegas/ubicacion destino existen que salve
													
	ll_update =dw_2.update()
			if ll_update = -1 then
				ls_error =sqlca.sqlerrtext
				rollback using sqlca;
				sqlca.autocommit = true
				ib_aceptar = False
				is_actualiza=''
				gf_Mensaje("","¡Error al Actualizar Detalle del Pedido! "+ls_error,1,1,'E')
				return
			end if
		
	  if ll_update = 1 then
		  
		  if dw_8.update() = -1 then
				ls_error =sqlca.sqlerrtext
				rollback using sqlca;
				sqlca.autocommit = true
				ib_aceptar = False
				is_actualiza=''
				gf_Mensaje("","¡Error al Actualizar Detalle del Pedido! "+ls_error,1,1,'E')
				return			
		  end if
		  
		  sqlca.autocommit = true
		  ib_aceptar = True

		  /* Refresca los datos del datawindows cuando la Actualizacion fue correcta */
		  dw_1.setredraw(false)
		  dw_2.setredraw(false)				
		  long ll_fila
		  ll_fila = dw_2.getrow()
		  if dw_1.retrieve(str.g_financiero, str.empresa, is_secuencia, ii_ann ) > 0 then
			dw_1.setitem(dw_1.getrow(),'vendedor',ii_vendedor)
			ll_lter = dw_1.getitemnumber(1,'fact_cliente')
			ld_saldo = gf_saldo_anterior_new( ll_lter, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)		
			if isnull(ld_saldo) then ld_saldo = 0.00
			dw_1.setitem(1,'saldo',ld_saldo)
			ld_limite = idwc_cliente.getitemnumber(idwc_cliente.getrow(), 'clie_limite_credito')						
			dw_1.setitem(1,'limite',ld_limite)					
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
		  if ll_lter = 0 or isnull(ll_lter) then ll_lter = dw_1.getitemnumber(1,'fact_cliente')
		  dw_8.retrieve(str.g_financiero, str.empresa, ll_lter)
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
	lstr_df.texto_campo [1,5] = '220'	
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
	lstr_df.texto_campo [4,1] = "fatdiari.fact_estado"
	lstr_df.texto_campo [4,2] = "Estado"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '240'
	lstr_df.texto_campo [5,1] = "fatdiari.fact_no_pedido"
	lstr_df.texto_campo [5,2] = "Pedido"
	lstr_df.texto_campo [5,3] = "fact_no_pedido"
	lstr_df.texto_campo [5,4] = 'V'
	lstr_df.texto_campo [5,5] = '220'	
	
	lstr_df.tabla = " fatdiari "
		
	lstr_df.tabla_where = &
				"WHERE (fatdiari.fact_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(fatdiari.fact_empresa = " + string(str.empresa) + ") 	and " +&
 						 "(fatdiari.fact_ann = " + string(ii_ann) + ") and " + &
						 "(fatdiari.fact_metal_pendiente = " + string(ii_metal_pendiente)+" ) and " + &
						 "(fatdiari.fact_factura_cierre = 1) "
	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm



If len (ls_find) = 0 Then Return
	
ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)
is_secuencia = ls_codigo
dw_2.object.cargos.expression = "'"+string(0.00,'#,##0.00')+"'"	//Para blanquear los cargos
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
	ll_lter = dw_1.getitemnumber(1,'fact_cliente')
	ld_saldo = gf_saldo_anterior_new( ll_lter, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)		
	if isnull(ld_saldo) then ld_saldo = 0.00
	dw_1.setitem(1,'saldo',ld_saldo)
	
	ll_fila = idwc_cliente.find('terc_tercero = '+string(ll_lter),1,idwc_cliente.rowcount())
	if ll_fila > 0 then
		idwc_cliente.scrolltorow(ll_fila)
	end if

	ld_limite = idwc_cliente.getitemnumber(idwc_cliente.getrow(), 'clie_limite_credito')						
	dw_1.setitem(1,'limite',ld_limite)		
	
end if
dw_8.retrieve(str.g_financiero, str.empresa, ll_lter )
dw_2.reset()
dw_2.retrieve(str.g_financiero, str.empresa, ls_codigo, ii_ann )
is_item = ''
dw_2.scrolltorow(dw_2.rowcount())
dw_2.setfocus()
end event

event ue_eliminar;//
//override
if datawindow = 1 then	
	if dw_1.getitemstring(1,'fact_estado') <> 'A' then
		gf_mensaje('','No Puede Eliminar una Factura Actualizada, Verifique !!!',1,1,'E')
		return
	end if
	if gf_mensaje('','Esta Seguro de Eliminar la Factura ?',2,2,'E') = 1 then
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

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_cierre_metal
boolean visible = false
integer x = 46
integer y = 2040
integer width = 101
string text = ""
end type

type dw_1 from w_fa_padre`dw_1 within w_cierre_metal
event ue_escape pbm_dwescape
integer x = 27
integer y = 12
integer width = 3685
integer height = 608
integer taborder = 10
string dataobject = "dw_encab_cierre"
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

event dw_1::buttonclicked;call super::buttonclicked;long ll_codigo
integer li_encontro
if dwo.name = 'b_cliente' then
	
	String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error
	integer li_c, li_b
	long    ll_lter
	
	Datawindow        dww
	str_dg_dynamic_find	lstr_df
	
		lstr_df.texto_campo [1,1] = "ccmclien.clie_ref_anterior" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [1,2] = "Cuenta"
		lstr_df.texto_campo [1,3] = "clie_ref_anterior"
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '450'
		lstr_df.texto_campo [2,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [2,2] = "Descripción"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '700'		
		lstr_df.texto_campo [3,1] = "dgmterce.terc_tercero"
		lstr_df.texto_campo [3,2] = "Código Tercero"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [4,1] = "dgapais.pais_descripcion"
		lstr_df.texto_campo [4,2] = "País"
		lstr_df.texto_campo [4,3] = ""
		lstr_df.texto_campo [4,4] = 'V'
		lstr_df.texto_campo [4,5] = '550'
		
		lstr_df.tabla = " dgmterce, dgapais, ccmclien, fatdiari "
		
		
		lstr_df.tabla_where = &
					"WHERE ( dgmterce.terc_pais *= dgapais.pais_pais ) and  " +&				
						   "( fatdiari.fact_g_financiero = ccmclien.clie_g_financiero ) and  " + &
				         "( fatdiari.fact_empresa = ccmclien.clie_empresa ) and  " + &
				         "( fatdiari.fact_cliente = ccmclien.clie_tercero ) and  " + &					
							 "(ccmclien.clie_g_financiero = " + string(str.g_financiero) + " and " +&
							 "ccmclien.clie_empresa = " + string(str.empresa) + ") 	and " +&
							"(dgmterce.terc_tercero = ccmclien.clie_tercero) and " +&
					      "(ccmclien.clie_estado = 'A' ) AND  " +&
					      "(ccmclien.clie_cuenta_mala <> 1 ) AND " +& 							
					      "(fatdiari.fact_metal_pendiente = 1 ) AND " +& 
					      "(fatdiari.fact_cierre_de_metal = 0 ) AND " +&
					      "(fatdiari.fact_factura_cierre = 0 )  "
		
		
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

string ls_objeto, ls_column
integer li_pos 


date 	ld_date,ld_ini_date, ld_hoy
accepttext()

ld_hoy = date(gf_fecha_serv())

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

ls_column = dwo.name

if ls_column = 'fact_cliente_t' then
	
	if row = 0  then return
	str_cc_formatos str_formato1		
	str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	str_formato1.tercero = dw_1.getitemNumber(1,"fact_cliente")
	Opensheetwithparm(w_estadocuenta,str_formato1,str.frame,2,original!)
	
elseif dwo.name='calendario' then
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
end if

end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;datawindow = 1
end event

event dw_1::itemchanged;call super::itemchanged;string ls_columna, ls_nombre
integer li_vendedor, li_termino_pago, li_existe
long    ll_tercero
decimal{2} ld_saldo, ld_limite

this.accepttext()

ls_columna = this.getcolumnname()

choose case ls_columna
	case 'fact_tipo'
		is_tipo = data
	case 'fact_ruc_cliente'
		
	  SELECT count(*)  
		 INTO :li_existe  
		 FROM ccmclien  
		WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
				( ccmclien.clie_empresa = :str.empresa ) AND  
				( ccmclien.clie_ref_anterior = :data ) ;
		if li_existe = 0 or isnull(li_existe) then
			gf_mensaje('','Cliente no existe. Verifique !!!',1,1,'E')
			dw_1.setitem(1,'fact_ruc_cliente','')
			dw_1.setcolumn('fact_ruc_cliente')
			return 2
		end if		
		
		ls_nombre = idwc_cliente.getitemstring(idwc_cliente.getrow(), 'terc_descripcion')
		li_vendedor = idwc_cliente.getitemnumber(idwc_cliente.getrow(), 'clie_vendedor')
		li_termino_pago = idwc_cliente.getitemnumber(idwc_cliente.getrow(), 'clie_limite_morosidad')				
		if isnull(li_termino_pago) then li_termino_pago = 0
		ld_limite = idwc_cliente.getitemnumber(idwc_cliente.getrow(), 'clie_limite_credito')						
		if isnull(ld_limite) then ld_limite = 0.00
		this.setitem(1,'fact_a_nombre',ls_nombre)
		this.setitem(1,'fact_a_nombre_direccion', idwc_cliente.getitemstring(idwc_cliente.getrow(), 'terc_direccion') )		
	   ll_tercero = idwc_cliente.getitemNumber(idwc_cliente.getrow(), 'terc_tercero')
		this.setitem(1,'fact_cliente', ll_tercero )				
		this.setitem(1,'vendedor',li_vendedor)
		this.setitem(1,'fact_dias_pago',li_termino_pago)		
		this.setcolumn('fact_a_nombre')
		ld_saldo = gf_saldo_anterior_new( ll_tercero, gf_fecha_serv(), str.g_financiero, str.empresa, 99999999	)		
		if isnull(ld_saldo) then ld_saldo = 0.00
		this.setitem(1,'saldo',ld_saldo)
		this.setitem(1,'limite',ld_limite)		
		if dw_8.retrieve(str.g_financiero, str.empresa, ll_tercero) = 0 then
			gf_mensaje('','No existen Referencias Pendientes de Cierre',1,1,'E')
		end if
		dw_9.retrieve(str.g_financiero, str.empresa, ll_tercero)
end choose


end event

type st_ayuda from w_fa_padre`st_ayuda within w_cierre_metal
integer x = 2793
integer y = 636
end type

type dw_2 from datawindow within w_cierre_metal
event ue_enter pbm_dwnprocessenter
event ue_down pbm_dwnkey
event ue_helpcol ( )
integer x = 18
integer y = 636
integer width = 3675
integer height = 1632
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle del Cierre de Metal"
string dataobject = "dw_detalle_cierre"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_enter;this.accepttext()
if this.getcolumnname() = 'facd_peso' then	
	if this.getrow() = this.rowcount() then
		parent.triggerevent('ue_aceptar')
		parent.triggerevent('ue_adicionar')
	else
		this.scrolltorow(this.getrow() + 1)
		this.setcolumn('facd_codigo_item')
	end if
elseif this.getcolumnname() = 'facd_codigo_item' then	
	this.setcolumn('facd_cantidad')	
elseif this.getcolumnname() = 'facd_precio_unidad_producto' then	
	this.setcolumn('facd_peso')	
elseif this.getcolumnname() = 'facd_cantidad' or this.getcolumnname() = 'facd_cantidad_fraccion' then	
	this.setcolumn('facd_precio_original')			
elseif this.getcolumnname() = 'facd_precio_original' then	
	this.setcolumn('facd_precio_recargo')		
elseif this.getcolumnname() = 'facd_precio_recargo' then	
	this.setcolumn('facd_peso')			
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

event ue_helpcol();//Busqueda del producto
//
String  ls_find,ls_codigo
integer li_c, li_b
long    ll_lter
string  ls_lter,ls_des

Datawindow        dww
str_dg_dynamic_find	lstr_df

	lstr_df.texto_campo [1,1] = "inmprodu.prod_producto"
	lstr_df.texto_campo [1,2] = "Referencia"
	lstr_df.texto_campo [1,3] = "prod_producto"
	lstr_df.texto_campo [1,4] = 'V'
//	lstr_df.texto_campo [1,5] = '280'	
	lstr_df.texto_campo [2,1] = "inmprodu.prod_descripcion"
	lstr_df.texto_campo [2,2] = "Descripcion"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '770'
//	lstr_df.texto_campo [3,1] = "orden.enca_fecha"
//	lstr_df.texto_campo [3,2] = "Fecha"
//	lstr_df.texto_campo [3,3] = ""
//	lstr_df.texto_campo [3,4] = 'V'
//	lstr_df.texto_campo [3,5] = '285'
	lstr_df.tabla = " inmprodu "
		
	lstr_df.tabla_where = &
				"WHERE (inmprodu.prod_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(inmprodu.prod_empresa = " + string(str.empresa) + ") "	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm



If len (ls_find) = 0 Then Return
	
ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)
this.setitem(this.getrow(),'facd_codigo_item',ls_codigo)
this.accepttext()
this.trigger event itemchanged(this.getrow(), object, ls_codigo)
end event

event itemfocuschanged;datawindow = 2

end event

event clicked;if this.rowcount() = 0 then
	datawindow = 1
	parent.triggerevent('ue_aceptar')
else
	datawindow = 2
	parent.triggerevent('ue_adicionar')
end if

datawindow = 2
end event

event buttonclicked;string ls_codigo
integer li_encontro
if dwo.name = 'b_producto' then
	dw_3.dataobject = 'dw_productos'
	dw_3.title =	'Productos'
	dw_3.settransobject(sqlca)
	if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
		dw_3.insertrow(1)
	else
		ls_codigo	= dw_2.getitemstring(dw_2.getrow(),'facd_codigo_item')
		li_encontro = dw_3.find('prod_producto = "'+string(ls_codigo)+'"',1,dw_3.rowcount())
		if li_encontro > 0 then
			dw_3.scrolltorow(li_encontro)
		end if
	end if
	dw_3.setfocus()
	dw_3.width = 2501 + 1170
	dw_3.x = 0
	dw_3.visible = true

end if
end event

event itemchanged;string ls_codigo, ls_descripcion, ls_uni_empaque, ls_condicion
long   ll_bultos
decimal {3} ld_cantidad, ld_disponible
integer ll_fraccion
decimal {8} ld_precio, ld_costo_cif, ld_precio_original, ld_precio_recargo
decimal {2} ld_monto_final, ld_total, ld_saldo_disponible
this.accepttext()
if this.getcolumnname() = 'facd_codigo_item' then
	   ls_codigo = data
		if not wf_carga_producto(ls_codigo, ls_descripcion) then
			return 2
		end if
		
//		if id_precio = 0 or isnull(id_precio) then id_precio = id_precio_prod
		id_precio = id_precio_prod
		
		if ls_descripcion = '' or isnull(ls_descripcion) then
			gf_mensaje('','Referencia no Existe o No tiene Pendientes por Cerrar, Verifique !!!',1,1,'E')
			this.setitem(row,'facd_codigo_item','')
			this.setcolumn('facd_codigo_item')
			return 2
		else
			is_item = ls_codigo
			is_descrip = ls_descripcion
			this.setitem(row, 'facd_descripcion_alterna', ls_descripcion)
			this.setitem(row, 'facd_precio_unidad_producto', id_precio)
			this.setitem(row, 'facd_precio_original', id_precio)			
			this.setitem(row, 'facd_unidad_venta',is_unidad)
			this.setitem(row, 'facd_unidad_producto',is_unidad)			
			if dw_7.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
				dw_7.insertrow(1)
			end if
		end if
elseif this.getcolumnname() = 'facd_cantidad' or this.getcolumnname() = 'facd_cantidad_fraccion' then
		if ii_cantidad_unidad = 0 or isnull(ii_cantidad_unidad) then
			ls_codigo = this.getitemstring(row,'facd_codigo_item')
			if not wf_carga_producto(ls_codigo, ls_descripcion) then
				return 2
			end if
		end if
		ld_cantidad = this.getitemnumber(row,'facd_cantidad')	
		ll_fraccion = this.getitemnumber(row,'facd_cantidad_fraccion')	
		
		//Valida que no supere la cantidad existente al facturar
		ld_disponible = dw_8.getitemnumber(1,'total')
		if ld_cantidad > ld_disponible then
			gf_mensaje('','La Cantidad es Mayor a lo Pendiente de Cierre, Verifique !!!',1,1,'E')
			this.setitem(row,'facd_cantidad',0.00)
			this.setitem(row,'facd_cantidad_fraccion',0.00)
			this.setitem(row,'facd_monto_final', 0.00 )
			this.setitem(row,'facd_monto_total', 0.00 )
			this.setitem(row,'facd_bultos',0)
			this.setitem(row,'facd_peso',0.00)
			this.setitem(row,'facd_cubicaje',0.00)
			this.setitem(row,'facd_costo_total', 0.00)	
			this.setcolumn('facd_cantidad')
			return 2
		end if
		
		if isnull(ll_fraccion) then ll_fraccion = 0
		ld_precio   = this.getitemnumber(row, 'facd_precio_unidad_producto')
		if (il_empaque * ii_cantidad_empaque) <> 0 then
			ll_bultos = (ld_cantidad * ii_cantidad_unidad ) / (il_empaque * ii_cantidad_empaque)
		end if
		if ll_bultos = 0 then ll_bultos = 1
		ld_monto_final = round( (ld_cantidad * ld_precio) + ((ld_precio / ii_cantidad_unidad) * ll_fraccion ) ,2)
		this.setitem(row,'facd_monto_final', ld_monto_final)
		this.setitem(row,'facd_monto_total', ld_monto_final)
		this.setitem(row,'facd_bultos',ll_bultos)
		this.setitem(row,'facd_peso',ll_bultos * id_peso)
		this.setitem(row,'facd_cubicaje',round(ll_bultos * id_cubicaje,4))
		this.setitem(row,'facd_costo_cif', id_costo_cif)
		this.setitem(row,'facd_costo_total', round( (ld_cantidad * id_costo_cif) + ((id_costo_cif / ii_cantidad_unidad) * ll_fraccion ) ,2) )
		ld_total = dw_2.getitemnumber(1,'monto_final')
		ld_saldo_disponible = dw_1.getitemnumber(1,'disponible')
		ls_condicion		  = dw_1.getitemString(1,'fact_condicion_pago')		
		if ld_total > ld_saldo_disponible and ls_condicion <> 'CO' then
			if not wf_valida_limite_credito() then
				this.setitem(row,'facd_cantidad',0)
				return 2
			end if
		end if
elseif this.getcolumnname() = 'facd_precio_original' then	
	ld_precio = double(data)	
	id_precio = ld_precio
	ld_precio_recargo = this.getitemnumber(row, 'facd_precio_recargo')	
	ld_precio = ld_precio + ld_precio_recargo
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
	this.setitem(row,'facd_monto_final', ld_monto_final)
	this.setitem(row,'facd_monto_total', ld_monto_final)
	this.setitem(row,'facd_costo_total', round( (ld_cantidad * id_costo_cif) + ((id_costo_cif / ii_cantidad_unidad) * ll_fraccion ) ,2) )	
	ld_total = dw_2.getitemnumber(1,'monto_final')
	ld_saldo_disponible = dw_1.getitemnumber(1,'disponible')
	ls_condicion		  = dw_1.getitemString(1,'fact_condicion_pago')	
	if ld_total > ld_saldo_disponible and ls_condicion <> 'CO' then
		if not wf_valida_limite_credito() then
			this.setitem(row,'facd_precio_original',0.00)
			return 2
		end if
	end if
elseif this.getcolumnname() = 'facd_precio_recargo' then	
	ld_precio = double(data)	
	ld_precio_original = this.getitemnumber(row, 'facd_precio_original')	
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
	this.setitem(row,'facd_costo_total', round( (ld_cantidad * id_costo_cif) + ((id_costo_cif / ii_cantidad_unidad) * ll_fraccion ) ,2) )
	ld_total = dw_2.getitemnumber(1,'monto_final')
	ld_saldo_disponible = dw_1.getitemnumber(1,'disponible')
	ls_condicion		  = dw_1.getitemString(1,'fact_condicion_pago')	
	if ld_total > ld_saldo_disponible and ls_condicion <> 'CO' then
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
end if
end event

event rowfocuschanged;string ls_codigo, ls_descripcion
il_row = currentrow
if currentrow > 0 then
	if isnull(is_item) or is_item = '' then is_item = this.getitemstring(currentrow, 'facd_codigo_item')
	ls_codigo = is_item 
//	if dw_7.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
//		dw_7.insertrow(1)
//	end if	
	if not wf_carga_producto(ls_codigo, ls_descripcion) then
		return 2
	end if
	is_descrip = ls_descripcion
end if


end event

type dw_3 from datawindow within w_cierre_metal
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

type cb_2 from commandbutton within w_cierre_metal
integer x = 3241
integer y = 28
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

if dw_2.rowcount() = 0 then return
if dw_1.getitemstring(1,'fact_estado') <> 'A' then return
datawindow = 2	
parent.triggerevent('ue_aceptar')

  SELECT isnull(faaparam.fara_ult_ultima_factura  ,'0')
    INTO :ls_factura  
    FROM faaparam  
   WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
         ( faaparam.fara_empresa = :str.empresa );
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al buscar secuencia '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
	ll_factura = long(ls_factura)
	
	ll_factura ++
	
	dw_5.setitem(1,'factura', string(ll_factura))

dw_5.visible = true
datawindow = 1
end event

type dw_6 from datawindow within w_cierre_metal
boolean visible = false
integer x = 439
integer y = 2276
integer width = 718
integer height = 100
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_formatos"
end type

event itemchanged;string ls_dw
ls_dw = idwc_formatos.getitemstring(idwc_formatos.getrow(),'datawindows')
dw_4.dataobject = ls_dw
dw_4.settransobject(sqlca)
dw_4.retrieve(str.g_financiero, str.empresa, is_secuencia , ii_ann, is_tipo)
dw_4.object.datawindow.print.preview = 'yes'
dw_4.object.datawindow.print.preview.zoom = 100
dw_4.object.nom_empresa.expression = "'"+str.nombre_empresa+"'"

end event

type st_1 from statictext within w_cierre_metal
boolean visible = false
integer x = 96
integer y = 2300
integer width = 329
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Formato de :"
alignment alignment = right!
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_cierre_metal
integer x = 3259
integer y = 508
integer width = 352
integer height = 92
integer taborder = 50
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
			str_opcion.dwreporte      = 'dw_in_mcp_prod_kard_2'
			str_opcion.titulo_ventana = 'Movimientos de Productos (Kardex)'
			
			if dw_2.rowcount() > 0 then
				ls_producto = dw_2.getitemstring(dw_2.getrow(),'facd_codigo_item')				
			end if
			
			str_opcion.kproducto=ls_producto
		
			OpenSheetWithParm(lw_child_v,str_opcion,"w_in_movi_prod_kardex",str.frame,2,Original!)		
end event

type dw_7 from datawindow within w_cierre_metal
boolean visible = false
integer x = 41
integer y = 2000
integer width = 1221
integer height = 200
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_existencia"
boolean livescroll = true
borderstyle borderstyle = styleraised!
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

type dw_4 from datawindow within w_cierre_metal
boolean visible = false
integer x = 32
integer y = 20
integer width = 3717
integer height = 2228
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Impresión de Pedidos"
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

type dw_5 from datawindow within w_cierre_metal
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

event clicked;string ls_factura
integer li_existe
this.accepttext()
choose case dwo.name
	case 'b_actualiza'
		ls_factura = this.getitemstring(1,'factura')
		if ls_factura = '' or isnull(ls_factura) then
			gf_mensaje('','Numero de Factura Invalido, Verifique !!!',1,1,'E')
			return
		end if
		
		if gf_mensaje('','Esta Seguro de Actualizar la Factura ?',2,1,'E') = 2 then return
		
		
		  SELECT count(*)  
			 INTO :li_existe  
			 FROM fatdiari  
			WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
					( fatdiari.fact_empresa = :str.empresa ) AND  
					( fatdiari.fact_ann = :ii_ann ) AND  
					( fatdiari.fact_no_factura = :ls_factura ) ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Validar Factura '+sqlca.sqlerrtext,1,1,'E')
						return
					end if

		if li_existe > 0 then
			gf_mensaje('','Factura ya Existe, Verifique !!!',1,1,'E')
			return
		end if
		if wf_actualiza_factura(ls_factura) then
			dw_5.visible = false
		else
			return
		end if
		parent.triggerevent('ue_print')		
		datawindow = 1
	case 'b_cancelar'
		dw_5.visible = false		
end choose
end event

type pb_2 from picturebutton within w_cierre_metal
integer x = 3342
integer y = 268
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
string picturename = "C:\sistemas\hymsoft\Art\NOTE04.BMP"
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

type st_2 from statictext within w_cierre_metal
integer x = 3319
integer y = 420
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
long backcolor = 15780518
string text = "Notas"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_8 from datawindow within w_cierre_metal
integer x = 1554
integer y = 1020
integer width = 1550
integer height = 696
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_pendiente_de_cierre"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type pb_3 from picturebutton within w_cierre_metal
integer x = 3186
integer y = 2112
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
string ls_detalle

	if dw_1.getitemstring(1,'fact_estado') = 'E' then
		gf_mensaje('','La Factura ya fue Anulada, Verifique !!!',1,1,'E')
		return		
	elseif dw_1.getitemstring(1,'fact_estado') = 'I' then

		if gf_mensaje('','Esta Seguro de Anular la Factura ?',2,2,'E') = 1 then
			sqlca.autocommit = false
		   update fatdiari
			 set fact_estado = 'E'
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
			gf_mensaje('','Anulación Exitosa',1,1,'E')
		end if
		
	end if
end event

type st_3 from statictext within w_cierre_metal
integer x = 3310
integer y = 2104
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
long backcolor = 67108864
string text = "Anular Factura"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_9 from datawindow within w_cierre_metal
boolean visible = false
integer x = 55
integer y = 1088
integer width = 1563
integer height = 768
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_pendiente_cerrados"
boolean resizable = true
boolean livescroll = true
end type

type cb_1 from commandbutton within w_cierre_metal
integer x = 3241
integer y = 156
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
string text = "Orden Fact."
end type

event clicked;//////override

dw_1.accepttext()
string ls_factura, ls_condicion_pago, ls_nombre, ls_direccion, ls_consignado, ls_marca, ls_tipo_movimiento, ls_factura_trafico, ls_descrip_grupo, &
		 ls_cuenta, ls_pedido, ls_pasaporte, ls_linea_aerea, ls_producto, ls_descrip, ls_buscar, ls_nombre_temp, ls_division, ls_grupo, &
		 ls_direccion_temp, ls_pasaporte_temp, ls_linea_aerea_temp, ls_marca_temp, ls_consignado_temp, ls_tipo_temp, ls_cuenta_temp, ls_producto_temp, ls_prod_original
integer li_ann, li_metal_pendiente, i, li_tipo_medida, li_encontro, li_factura_impresa
decimal{2} ld_monto_final, ld_monto_detalle, ld_fraccion, ld_cantidad, ld_cantidad_pieza, ld_valor_pendiente, ld_gastos, ld_gastos_temp, ld_cantidad_orden, ld_monto_orden
datetime ldt_fecha, ldt_fecha_despacho, ldt_anterior, ldt_fecha_actual, ldt_fecha_impresion
time lt_time
lt_time = time('00:00:00.000000')

if is_secuencia = '' then return

if dw_1.getitemstring(1,'fact_estado') = 'A' then
	return
end if
	
	dw_10.reset()
	dw_11.reset()

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
			fatdiari.fact_fecha_impresion			
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
					 :ls_pasaporte, :ls_linea_aerea, :li_metal_pendiente, :ld_gastos, :ls_factura_trafico, :li_factura_impresa, :ldt_fecha_impresion ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error en el fetch '+sqlca.sqlerrtext,1,1,'E')
		end if			 
	
	DO WHILE SQLCA.sqlcode = 0
	
		//inserta en el dw, ENCABEZADO
		if dw_10.rowcount() = 0 then
			dw_10.insertrow(1)			
		end if
		
				
		if isnull(dw_10.getitemstring(1,'fact_no_factura'))  then dw_10.setitem(1,'fact_no_factura', ls_factura)
		if isnull(dw_10.getitemstring(1,'fact_no_pedido'))  then dw_10.setitem(1,'fact_no_pedido', ls_pedido)
		dw_10.setitem(1,'fact_fecha', ldt_fecha)
		dw_10.setitem(1,'fact_fecha_despacho', ldt_fecha_despacho)		
		ls_nombre_temp = dw_10.getitemstring(1,'fact_a_nombre')
		if isnull(ls_nombre_temp) or ls_nombre_temp = '' then dw_10.setitem(1,'fact_a_nombre', ls_nombre)		
		ls_direccion_temp = dw_10.getitemstring(1,'fact_a_nombre_direccion')
		if isnull(ls_direccion_temp) or ls_direccion_temp = '' then dw_10.setitem(1,'fact_a_nombre_direccion', ls_direccion)		
		ls_marca_temp = dw_10.getitemstring(1,'fact_marca')
		if isnull(ls_marca_temp) or ls_marca_temp = '' then dw_10.setitem(1,'fact_marca', ls_marca)				
		ls_pasaporte_temp = dw_10.getitemstring(1,'fact_pasaporte')
		if isnull(ls_pasaporte_temp) or ls_pasaporte_temp = ''  then dw_10.setitem(1,'fact_pasaporte', ls_pasaporte)						
		ls_consignado_temp = dw_10.getitemstring(1,'fact_consignado')
		if isnull(ls_consignado_temp) or ls_consignado_temp = '' then dw_10.setitem(1,'fact_consignado', ls_consignado)						
		ls_linea_aerea_temp = dw_10.getitemstring(1,'fact_linea_aerea')		
		if isnull(ls_linea_aerea_temp) or ls_linea_aerea_temp = ''  then dw_10.setitem(1,'fact_linea_aerea', ls_linea_aerea)						
		ls_pasaporte_temp = dw_10.getitemstring(1,'fact_pasaporte')
		if isnull(ls_pasaporte_temp) or ls_pasaporte_temp = ''  then dw_10.setitem(1,'fact_pasaporte', ls_pasaporte)						
		ls_pasaporte_temp = dw_10.getitemstring(1,'fact_tipo_movimiento')
		if isnull(ls_pasaporte_temp) or ls_pasaporte_temp = ''  then dw_10.setitem(1,'fact_tipo_movimiento', ls_tipo_movimiento)								
		ls_cuenta_temp = dw_10.getitemstring(1,'fact_ruc_cliente')
		if isnull(ls_cuenta_temp) or ls_cuenta_temp = '' then dw_10.setitem(1,'fact_ruc_cliente', ls_cuenta)						
		ls_tipo_temp  = dw_10.getitemstring(1,'fact_condicion_pago')
		if isnull(ls_tipo_temp) or ls_tipo_temp = '' then dw_10.setitem(1,'fact_condicion_pago', ls_condicion_pago)								
		ld_gastos_temp = dw_10.getitemnumber(1,'gastos')
		if isnull(ld_gastos_temp) then ld_gastos_temp = 0
		dw_10.setitem(1,'gastos', ld_gastos_temp + ld_gastos)
		dw_10.setitem(1,'fact_usuario', str.usuario )

		fetch fac_encab into :ls_condicion_pago, :ldt_fecha, :ls_nombre, :ls_direccion, :ls_consignado, &
					 :ld_monto_final, :ls_marca, :ls_tipo_movimiento, :ls_cuenta, :ls_pedido, :ldt_fecha_despacho, &
					 :ls_pasaporte, :ls_linea_aerea, :li_metal_pendiente, :ld_gastos, :ls_factura_trafico, :li_factura_impresa, :ldt_fecha_impresion;
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
				isnull(max(facd_cantidad_orden),0) cantidad_orden,
				isnull(max(facd_monto_orden),0) monto_orden,
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
				( cragrupo.agru_g_financiero =* inmprodu.prod_g_financiero ) AND
				( cragrupo.agru_empresa =* inmprodu.prod_empresa ) AND
				( cragrupo.agru_codigo_div =* inmprodu.prod_division ) AND				
				( cragrupo.agru_codigo_grupo =* inmprodu.prod_grupo ) AND							
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
		
		fetch fac_deta into :ls_producto, :ld_monto_detalle, :ld_fraccion, :li_tipo_medida, :ls_descrip, :ld_cantidad, :ld_cantidad_pieza, :ls_division, :ls_grupo, :ld_cantidad_orden, :ld_monto_orden, :ls_prod_original ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error en el fetch detalle '+sqlca.sqlerrtext,1,1,'E')
		end if			 
		i = 1
		DO WHILE SQLCA.sqlcode = 0
			if dw_10.rowcount() = 0 then			 
				i = dw_10.insertrow(0)
			else
				//Busca la referencia, si la encuentra, le suma los gramos y el valor
				if li_tipo_medida <> 5 then   //  5 = GRAMOS
//					if ls_grupo = '004' then	//004 = ARTICULOS DE ACERO CON ORO
//						ls_producto = ls_division + ls_grupo
//					else
//						ls_producto = ls_division
//					end if
					ls_producto = ls_prod_original
				end if
				ls_buscar   = "facd_codigo_item = '"+ls_producto+"'"				
				li_encontro = dw_10.find(ls_buscar, 1, dw_10.rowcount())
				if isnull(li_encontro) then li_encontro = 0
				ls_producto_temp = dw_10.getitemstring(1,'facd_codigo_item')
				if li_encontro = 0 then
					if ls_producto_temp <> '' and not isnull(ls_producto_temp) then
						i = dw_10.insertrow(0)
					end if
				else
					i = li_encontro
					ld_monto_detalle = ld_monto_detalle + dw_10.getitemnumber(li_encontro, 'monto_final')
					ld_cantidad      = ld_cantidad 		+ dw_10.getitemnumber(li_encontro, 'cantidad')					
					ld_cantidad_pieza= ld_cantidad_pieza+ dw_10.getitemnumber(li_encontro, 'cantidad_pz')
				end if
			end if
			
			dw_10.setitem(i,'facd_codigo_item',ls_producto)
			dw_10.setitem(i,'tipo_medida',		 li_tipo_medida)
			dw_10.setitem(i,'facd_descripcion_alterna',ls_descrip)
			if ld_cantidad_orden <> 0 then
				ld_cantidad = ld_cantidad_orden
			end if
			dw_10.setitem(i,'cantidad',	  ld_cantidad)				
			if ld_monto_orden <> 0 then
				ld_monto_detalle = ld_monto_orden
			end if
			dw_10.setitem(i,'monto_final',ld_monto_detalle)						
			dw_10.setitem(i,'cantidad_pz',ld_cantidad_pieza)

			fetch fac_deta into :ls_producto, :ld_monto_detalle, :ld_fraccion, :li_tipo_medida, :ls_descrip, :ld_cantidad, :ld_cantidad_pieza, :ls_division, :ls_grupo, :ld_cantidad_orden, :ld_monto_orden, :ls_prod_original ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error en el fetch detalle '+sqlca.sqlerrtext,1,1,'E')
			end if			 
			
		loop
		
		close fac_deta ;
		
dw_10.object.datawindow.print.preview = 'yes'
dw_10.object.datawindow.print.preview.zoom = 100
dw_10.object.nom_empresa.expression = "'"+str.nombre_empresa+"'"
dw_10.visible = true

//OpenWithParm(w_dw_print_options, dw_10)
//If Message.DoubleParm = -1 Then Return
//dw_10.Print(True)


dw_11.visible = true
dw_11.insertrow(1)
dw_11.setitem(1,'vendidoa',ls_nombre)
dw_11.setitem(1,'consignado',ls_consignado)
dw_11.setitem(1,'destino',ls_direccion)
dw_11.setitem(1,'condicion',ls_condicion_pago)
dw_11.setitem(1,'vuelo',ls_linea_aerea)
dw_11.setitem(1,'fechadespacho',ldt_fecha_despacho)
dw_11.setitem(1,'tipodespacho',ls_tipo_movimiento)
dw_11.setitem(1,'marca',ls_marca)
dw_11.setitem(1,'pasaporte',ls_pasaporte)
dw_11.setitem(1,'gramos',ld_cantidad + ld_cantidad_pieza)
dw_11.setitem(1,'monto',ld_monto_detalle)

dw_11.setfocus()

datawindow = 1

end event

type dw_10 from datawindow within w_cierre_metal
boolean visible = false
integer x = 37
integer y = 932
integer width = 3456
integer height = 1480
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Orden de Facturacion"
string dataobject = "dw_imprimir_orden_fac"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
string icon = "AppIcon!"
boolean livescroll = true
end type

type dw_11 from datawindow within w_cierre_metal
event ue_enter pbm_dwnprocessenter
boolean visible = false
integer x = 594
integer y = 680
integer width = 2656
integer height = 1100
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle de la Orden de Facturacion"
string dataobject = "dw_detalle_de_orden_fac"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event ue_enter;this.accepttext()
end event

event clicked;string ls_pedido, ls_consignado, ls_destino, ls_condicion, ls_vuelo, ls_tipo, ls_marca, ls_pasaporte
date ldt_fecha
datetime ldt_fecha_despacho
decimal{3} ld_cantidad
decimal{2} ld_monto
integer li_existe
time lt_time
lt_time = time('00:00:00.000000')
this.accepttext()
choose case dwo.name
	case 'b_aceptar'
		ls_pedido = dw_1.getitemstring(1,'fact_no_pedido')
		if ls_pedido = '' or isnull(ls_pedido) then
//			gf_mensaje('','Numero de Factura Invalido, Verifique !!!',1,1,'E')
			return
		end if		
		
		ls_consignado = this.getitemstring(1,'consignado')
		ls_destino	  = this.getitemstring(1,'destino')
		ls_condicion  = this.getitemstring(1,'condicion')
		ls_vuelo		  = this.getitemstring(1,'vuelo')
		ls_tipo		  = this.getitemstring(1,'tipodespacho')
		ls_marca		  = this.getitemstring(1,'marca')
		ls_pasaporte  = this.getitemstring(1,'pasaporte')
		ldt_fecha	  = this.getitemdate(1,'fechadespacho')
		ldt_fecha_despacho = datetime(ldt_fecha, lt_time)
		ld_cantidad = this.getitemnumber(1,'gramos')
		ld_monto		= this.getitemnumber(1,'monto')
		
		  UPDATE fatdiari  
		  SET fact_tipo_movimiento = :ls_tipo,   
				fact_consignado = :ls_consignado,   
				fact_a_nombre_direccion = :ls_destino,   
				fact_marca = :ls_marca,   
				fact_fecha_despacho = :ldt_fecha_despacho,   
				fact_pasaporte = :ls_pasaporte,   
				fact_linea_aerea = :ls_vuelo,
				fact_monto_a_facturar = :ld_monto
		WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
				( fatdiari.fact_empresa = :str.empresa ) AND  
				( fatdiari.fact_tipo = '0' ) AND  
				( fatdiari.fact_no_pedido = :ls_pedido ) AND  
				( fatdiari.fact_ann = :ii_ann ) ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Grabar '+sqlca.sqlerrtext,1,1,'E')
			else
				
				  UPDATE faddiari  
				  SET facd_cantidad_orden = :ld_cantidad,   
						facd_monto_orden = :ld_monto  
				WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
						( faddiari.facd_empresa = :str.empresa ) AND  
						( faddiari.facd_tipo = '0' ) AND  
						( faddiari.facd_no_pedido = :ls_pedido ) AND  
						( faddiari.facd_ann = :ii_ann )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Grabar Detalle'+sqlca.sqlerrtext,1,1,'E')
					else			
						commit;
					end if
			end if
				
		dw_11.visible = false		
		
		dw_10.setitem(1,'fact_a_nombre_direccion',ls_destino)
		dw_10.setitem(1,'fact_consignado',ls_consignado)
		dw_10.setitem(1,'fact_tipo_movimiento',ls_tipo)
		dw_10.setitem(1,'fact_marca',ls_marca)
		dw_10.setitem(1,'fact_fecha_despacho',ldt_fecha_despacho)
		dw_10.setitem(1,'fact_pasaporte',ls_pasaporte)		
		dw_10.setitem(1,'fact_linea_aerea',ls_vuelo)
		
		dw_10.setitem(1,'cantidad',ld_cantidad)
		dw_10.setitem(1,'cantidad_pz',0)				 
		dw_10.setitem(1,'monto_final',ld_monto)
		dw_10.groupcalc()
		
		OpenWithParm(w_dw_print_options, dw_10)
		If Message.DoubleParm = -1 Then 
			dw_10.visible = false
			Return
		end if
		dw_10.Print(True)
		dw_10.visible = false
		dw_11.reset()
								
	case 'b_cancelar'
		dw_11.visible = false		
		dw_10.visible = false			
		dw_11.reset()
end choose

end event

event itemchanged;this.accepttext()
end event

type uo_1 from u_ddcalen within w_cierre_metal
boolean visible = false
integer x = 1275
integer y = 124
integer taborder = 21
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;dw_1.SetItem ( dw_1.getrow(), 'fact_fecha', uo_1.return_sel_date() )

if uo_1.allow_close then
	this.visible=false
	dw_1.SetFocus()
end if


end event

on uo_1.destroy
call u_ddcalen::destroy
end on

