//objectcomments Ventana para la Captura de Pedidos
forward
global type w_facturacion_standar from w_fa_padre
end type
type dw_2 from datawindow within w_facturacion_standar
end type
type dw_3 from datawindow within w_facturacion_standar
end type
type dw_4 from datawindow within w_facturacion_standar
end type
type cb_1 from commandbutton within w_facturacion_standar
end type
type cb_2 from commandbutton within w_facturacion_standar
end type
type dw_5 from datawindow within w_facturacion_standar
end type
type dw_6 from datawindow within w_facturacion_standar
end type
type st_1 from statictext within w_facturacion_standar
end type
type pb_1 from picturebutton within w_facturacion_standar
end type
type st_2 from statictext within w_facturacion_standar
end type
type pb_kardex from picturebutton within w_facturacion_standar
end type
end forward

global type w_facturacion_standar from w_fa_padre
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
dw_4 dw_4
cb_1 cb_1
cb_2 cb_2
dw_5 dw_5
dw_6 dw_6
st_1 st_1
pb_1 pb_1
st_2 st_2
pb_kardex pb_kardex
end type
global w_facturacion_standar w_facturacion_standar

type variables
integer ii_ann, datawindow, il_row, ii_cantidad_unidad, ii_cantidad_empaque, ii_vendedor
String  is_entrada, is_unidad_empaque, is_secuencia, is_actualiza, is_tipo, is_unidad
date	  idt_desde, idt_hasta
long    il_tiempo, il_segundos, il_secuencia, il_empaque
decimal{4} id_peso, id_cubicaje
decimal{2} id_precio, idec_gastos, id_costo_cif
datawindowchild idwc_cliente, idwc_tipo, idwc_vendedores, idwc_dias, idwc_formatos
end variables

forward prototypes
public function boolean wf_recupera ()
public function boolean wf_orden_nueva ()
public function boolean wf_imprime_vendedor ()
public function boolean wf_asigna_vendedor ()
public function boolean wf_act_encabezado ()
public function boolean wf_actualiza_inventario ()
public function boolean wf_act_detalle ()
public function boolean wf_act_cargos ()
public subroutine wf_cargos (double ld_cargos)
public function boolean wf_actualiza_cliente ()
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

public function boolean wf_act_detalle ();//Ciclo For que recorre el DWindow 2 para actualizar en el Detalle de actualizaciones
//str.frame.setmicrohelp("Actualizando el Detalle en Inventario...")
integer li_recorrido, li_grupo, li_empresa, li_linea,  li_ok,&
		  li_anual, li_fraccion
string  ls_aplicacion, ls_tipo_tran, ls_documento, ls_producto, ls_unidad_med, ls_movid,&
		  ls_fabricante, ls_secuencia, ls_codigo, ls_bodega, ls_ubicacion, ls_bodega_des, &
		  ls_ubica_des, ls_concepto,ls_def
double  ld_peso, ld_precio, ld_cubicaje, ld_bulto, ld_cargos, ld_precio_ent, ld_costos, ld_fob, ld_precio_original
long	  ll_cantidad, ll_cant1, li_secuencia

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
	ll_cantidad   = dw_2.getitemnumber(li_recorrido,"facd_cantidad")
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
           :ll_cantidad,   
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
					  movi_a_nombre)
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
					  :ls_nombre) ;

if sqlca.sqlerrtext <> "" then	
	ls_error = sqlca.sqlerrtext
	rollback ;
	gf_mensaje("Error","Error al Actualizar el Cliente " +ls_error,1,1,'E')	
	return false
end if	

return true
end function

public function boolean wf_actualiza_factura (string as_factura);string ls_factura
sqlca.autocommit = false
	ls_factura = dw_5.getitemstring(1,'factura')
	is_tipo = 	 dw_1.getitemstring(1,'fact_tipo')
	dw_1.setitem(1,'fact_no_factura', ls_factura)
	//dw_1.setitem(1,'fact_fecha', date(gf_fecha_serv()))
		
	if wf_actualiza_cliente() then
		if wf_actualiza_inventario() then
			dw_1.setitem(1,'fact_estado', 'I')	
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
		else //del actualizar cliente
			rollback ;
			sqlca.autocommit = true
			return false
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

on w_facturacion_standar.create
int iCurrent
call super::create
if this.MenuName = "m_fa_principal" then this.MenuID = create m_fa_principal
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_5=create dw_5
this.dw_6=create dw_6
this.st_1=create st_1
this.pb_1=create pb_1
this.st_2=create st_2
this.pb_kardex=create pb_kardex
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.dw_4
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.dw_5
this.Control[iCurrent+7]=this.dw_6
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.pb_1
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.pb_kardex
end on

on w_facturacion_standar.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_5)
destroy(this.dw_6)
destroy(this.st_1)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.pb_kardex)
end on

event ue_post_open;call super::ue_post_open;string ls_dw
idec_gastos = 0
dw_1.settransobject(sqlca);			
dw_2.settransobject(sqlca);	
dw_5.settransobject(sqlca);	
dw_6.settransobject(sqlca);
dw_6.getchild('formato',idwc_formatos)
idwc_formatos.settransobject(sqlca)
idwc_formatos.retrieve()
dw_6.insertrow(1)
dw_6.setitem(1,'formato','1')
ii_ann = year(date(gf_fecha_serv()))
datawindow = 1
  SELECT isnull(formatos.datawindows ,'') 
    INTO :ls_dw  
    FROM formatos  
   WHERE formatos.codigo = '1'   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al Seleccionar formato '+sqlca.sqlerrtext,1,1,'E')
	end if

if ls_dw = '' then ls_dw = 'dw_imprimir_factura'
dw_4.dataobject = ls_dw

dw_1.getchild('fact_tipo', idwc_tipo)
dw_1.getchild('fact_cliente', idwc_cliente)
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

this.triggerevent('ue_adicionar')

//Recupera la secuencia siguiente y da opcion para buscar una
wf_orden_nueva()

str.frame.setmicrohelp('Factura')
//il_tiempo = 150
//em_tiempo.text = string(150)
//timer(1)
this.height = w_fa_fondo.height - 50
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
	dw_1.setitem(1,'fact_tipo_venta',2) //exterior
	dw_1.setitem(1,'fact_estado','A')
	is_tipo = idwc_tipo.getitemstring(1,'dgmsubse_subs_sub_trans')
	dw_1.setitem(1,'fact_tipo', is_tipo)	
	dw_1.setfocus()
	dw_1.setcolumn('fact_cliente')
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
			dw_2.scrolltorow(dw_2.insertrow(0))
			dw_2.setitem(dw_2.getrow(),'facd_g_financiero',str.g_financiero)
			dw_2.setitem(dw_2.getrow(),'facd_empresa',str.empresa)
			dw_2.setitem(dw_2.getrow(),'facd_usuario',str.usuario)
		end if
	else
		dw_2.scrolltorow(dw_2.insertrow(0))
		dw_2.setitem(dw_2.getrow(),'facd_g_financiero',str.g_financiero)
		dw_2.setitem(dw_2.getrow(),'facd_empresa',str.empresa)
		dw_2.setitem(dw_2.getrow(),'facd_usuario',str.usuario)		
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
end event

event open;//override
this.y = 0
this.x = 805
gf_acelerador()
dw = dw_1

This.Icon = str.icono

this.postevent("ue_post_open")


This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)

str.frame.SetRedraw ( True )
end event

event ue_print;////override
dw_4.settransobject(sqlca)
if is_secuencia = '' then return
dw_4.retrieve(str.g_financiero, str.empresa, is_secuencia , ii_ann, is_tipo)
//
if dw_4.rowcount() = 0 then return
//
st_1.visible = true
dw_6.visible = true
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

event ue_aceptar;integer  li_contador,ll_update,ll_update2,li_encontro,li_lin_ref,li_posicion,li_frac2, li_find
integer  li_costo,anulado=0,li_linea_uno,li_linea_dos,indice, li_existe_detalle, li_empresa ,li_salvar
decimal  li_cantidad,li_cantid, li_cos_tran
datetime ldt_fecha,ldt_fecha_real
string   ls_documento,ls_aplic,ls_tipo,ls_medida,ls_producto,ls_concepto, fila, ls_conc,ls_error,ls_cuenta, ls_expresion, ls_doc
Long		ll_found, ll_ann,ll_secuencia, ll_bultos
boolean  lb_existe
decimal{2} ldec_monto, ld_peso, ld_cubicaje

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


sqlca.autocommit = false

indice = 0

ls_documento = dw_1.getitemstring(1,"fact_no_pedido")
is_secuencia = ls_documento
/*grabamos los datos del DW_1 de la tabla de INTMOVIM*////////////////
if dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = New! or &
	dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = NewModified! then 	
	
	//ll_secuencia = wf_buscar_secuencia() //buscamos la secuencia de dgmserie//
//	wf_buscar_secuencia(ll_secuencia)
   indice = 1
	
//	//Si no se ha creado la orden, crea una nueva
//	if not wf_valida_exis(ls_documento) then
//		if pos(is_secuencia,'-') = 0 then
//			ii_secuencia = 0
//			wf_buscar_secuencia(ii_secuencia) 
//			if ii_secuencia <> -1 then
//				is_secuencia  = is_inicial+"-"+string(ii_secuencia)
//				dw_1.setitem(1,"no_orden", is_secuencia )
//			end if
//		end if
//	end if
//
//	dw_1.setitem(1,'no_orden',string(ll_secuencia))
	
	if (dw_1.getitemString(1,"fact_no_pedido")) = '' or isnull(dw_1.getitemString(1,"fact_no_pedido")) then
		gf_mensaje("Atencion Sr. Usuario","Debe Asignar un valor valido, Verifique.",1,1,"E")
		sqlca.autocommit = true
		return
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
		
		//costo total de la factura
  		update  fatdiari  set fact_costos_total = 
		( SELECT sum(faddiari.facd_costo_total)   
			 FROM faddiari
			WHERE ( faddiari.facd_g_financiero = fatdiari.fact_g_financiero ) and  
					( faddiari.facd_empresa = fatdiari.fact_empresa ) and  
					( faddiari.facd_tipo = fatdiari.fact_tipo ) and  
					( faddiari.facd_no_pedido = fatdiari.fact_no_pedido ) and  
					( faddiari.facd_ann = fatdiari.fact_ann ) 
		GROUP BY fatdiari.fact_g_financiero,   
					fatdiari.fact_empresa,   
					fatdiari.fact_tipo,   
					fatdiari.fact_no_pedido,   
					fatdiari.fact_ann,   
					fatdiari.fact_no_factura   )
			WHERE  (fatdiari.fact_g_financiero = :str.g_financiero ) AND  
					 (fatdiari.fact_empresa = :str.empresa ) AND  
		          ( fatdiari.fact_no_pedido = :is_secuencia ) AND  
       			 ( fatdiari.fact_ann = :ii_ann ) ;		
					If sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrText
						Rollback;
						sqlca.autocommit = true
						ib_aceptar = False
						is_actualiza=''
						gf_mensaje("Atención","Error al actualizar el costo total de la factura fatdiari "+ls_error,1,1,'E')
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
		  end if
		  dw_2.retrieve(str.g_financiero, str.empresa, is_secuencia, ii_ann )
		  if dw_2.rowcount() = 0 then
			 datawindow = 2
			 dw = dw_2
			 this.triggerevent("ue_adicionar")
			 ll_fila = 1
		  end if
		  
		  dw_2.scrolltorow(il_row)
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
long    ll_lter
string  ls_lter,ls_des

Datawindow        dww
str_dg_dynamic_find	lstr_df

	lstr_df.texto_campo [1,1] = "fatdiari.fact_no_pedido"
	lstr_df.texto_campo [1,2] = "Pedido"
	lstr_df.texto_campo [1,3] = "fact_no_pedido"
	lstr_df.texto_campo [1,4] = 'V'
	lstr_df.texto_campo [1,5] = '280'	
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
	lstr_df.tabla = " fatdiari "
		
	lstr_df.tabla_where = &
				"WHERE (fatdiari.fact_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(fatdiari.fact_empresa = " + string(str.empresa) + ") 	and " +&
 						 "(fatdiari.fact_ann = " + string(ii_ann) + ")"
	
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
end if
dw_2.reset()
dw_2.retrieve(str.g_financiero, str.empresa, ls_codigo, ii_ann )
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

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_facturacion_standar
boolean visible = false
integer x = 46
integer y = 2040
integer width = 101
string text = ""
end type

type dw_1 from w_fa_padre`dw_1 within w_facturacion_standar
event ue_escape pbm_dwescape
integer x = 27
integer y = 12
integer width = 3662
integer height = 716
integer taborder = 10
string dataobject = "dw_encab_factura_standar"
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
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '450'
		lstr_df.texto_campo [2,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [2,2] = "Descripción"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '700'		
		lstr_df.texto_campo [3,1] = "dgmterce.terc_tercero"
		lstr_df.texto_campo [3,2] = "Código Tercero"
		lstr_df.texto_campo [3,3] = "terc_tercero"
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [4,1] = "dgapais.pais_descripcion"
		lstr_df.texto_campo [4,2] = "País"
		lstr_df.texto_campo [4,3] = ""
		lstr_df.texto_campo [4,4] = 'V'
		lstr_df.texto_campo [4,5] = '550'
		
		lstr_df.tabla = " dgmterce, dgapais, ccmclien "
		
		
		lstr_df.tabla_where = &
					"WHERE ( dgmterce.terc_pais *= dgapais.pais_pais ) and  " +&				
							 "(ccmclien.clie_g_financiero = " + string(str.g_financiero) + " and " +&
							 "ccmclien.clie_empresa = " + string(str.empresa) + ") 	and " +&
							"(dgmterce.terc_tercero = ccmclien.clie_tercero)"
		
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	If len (ls_find) = 0 Then Return
		
		
	ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo1,"'"," ")
	ls_codigo1 = Trim(ls_codigo1)

	dw_1.setitem(1,'fact_cliente',long(ls_codigo1))
	dw_1.accepttext()
	dw_1.setcolumn('fact_cliente')
	dw_1.trigger event itemchanged(1,object,ls_codigo1)

elseif dwo.name = 'b_buscar' then
	parent.triggerevent('ue_busqueda')
end if
end event

event dw_1::clicked;call super::clicked;datawindow = 1
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;datawindow = 1
end event

event dw_1::itemchanged;call super::itemchanged;string ls_columna, ls_nombre
integer li_vendedor, li_termino_pago
datawindowchild ldwc_cliente
this.accepttext()

ls_columna = this.getcolumnname()

choose case ls_columna
	case 'fact_tipo'
		is_tipo = data
	case 'fact_cliente'
		this.getchild('fact_cliente', ldwc_cliente)
		ldwc_cliente.settransobject(sqlca)
//		ldwc_cliente.retrieve()
		ls_nombre = ldwc_cliente.getitemstring(ldwc_cliente.getrow(), 'terc_descripcion')
		li_vendedor = ldwc_cliente.getitemnumber(ldwc_cliente.getrow(), 'clie_vendedor')
		li_termino_pago = ldwc_cliente.getitemnumber(ldwc_cliente.getrow(), 'clie_limite_morosidad')		
		this.setitem(1,'fact_a_nombre',ls_nombre)
		this.setitem(1,'fact_a_nombre_direccion', ldwc_cliente.getitemstring(ldwc_cliente.getrow(), 'terc_direccion') )		
		this.setitem(1,'fact_ruc_cliente', idwc_cliente.getitemstring(idwc_cliente.getrow(), 'clie_ref_anterior') )							
		this.setitem(1,'vendedor',li_vendedor)
		this.setitem(1,'fact_dias_pago',li_termino_pago)
		this.setcolumn('fact_a_nombre')
end choose


end event

type st_ayuda from w_fa_padre`st_ayuda within w_facturacion_standar
integer x = 2793
integer y = 636
end type

type dw_2 from datawindow within w_facturacion_standar
event ue_enter pbm_dwnprocessenter
event ue_down pbm_dwnkey
event ue_helpcol ( )
integer x = 18
integer y = 744
integer width = 3675
integer height = 1524
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle de la Factura"
string dataobject = "dw_detalle_factura_standar"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_enter;this.accepttext()
if this.getcolumnname() = 'facd_cubicaje' then	
	if this.getrow() = this.rowcount() then
		parent.triggerevent('ue_aceptar')
		parent.triggerevent('ue_adicionar')
	else
		this.scrolltorow(this.getrow() + 1)
		this.setcolumn('facd_codigo_item')
	end if
elseif this.getcolumnname() = 'facd_codigo_item' then	
	this.setcolumn('facd_precio_unidad_producto')
elseif this.getcolumnname() = 'facd_precio_unidad_producto' then	
	this.setcolumn('facd_cantidad')	
elseif this.getcolumnname() = 'facd_cantidad' or this.getcolumnname() = 'facd_cantidad_fraccion' then	
	this.setcolumn('facd_bultos')		
elseif this.getcolumnname() = 'facd_bultos' then	
	this.setcolumn('facd_peso')	
elseif this.getcolumnname() = 'facd_peso' then	
	this.setcolumn('facd_cubicaje')		
elseif this.getcolumnname() = 'facd_cantidad' then	
	this.setcolumn('facd_bultos')	
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
	lstr_df.texto_campo [1,5] = '390'	
	lstr_df.texto_campo [2,1] = "inmprodu.prod_descripcion"
	lstr_df.texto_campo [2,2] = "Descripcion"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '770'
	lstr_df.texto_campo [3,1] = "convert(numeric(5,0),inmprodu.prod_existencia_total / inamedid.medi_cantidad) Exist"
	lstr_df.texto_campo [3,2] = "Exist."
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [3,5] = '225'
	lstr_df.texto_campo [4,1] = "cracolor.acol_nombre_color"
	lstr_df.texto_campo [4,2] = "Color"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '380'
	lstr_df.texto_campo [5,1] = "inmprodu.prod_precio_mayor"
	lstr_df.texto_campo [5,2] = "Precio"
	lstr_df.texto_campo [5,3] = ""
	lstr_df.texto_campo [5,4] = 'V'
	lstr_df.texto_campo [5,5] = '280'
	
	lstr_df.tabla = " inmprodu, inamedid, cracolor "
		
	lstr_df.tabla_where = &
				"WHERE  (inmprodu.prod_medida = inamedid.medi_medida ) and " +&
						 "(inmprodu.prod_g_financiero = cracolor.acol_g_financiero ) and " +&
						 "(inmprodu.prod_empresa = cracolor.acol_empresa ) and " +&
						 "(inmprodu.prod_color = cracolor.acol_num_color ) and " +&						 
						 "(inmprodu.prod_g_financiero = " + string(str.g_financiero) + ") and " +&
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

event clicked;datawindow = 2

if this.rowcount() = 0 then
	parent.triggerevent('ue_adicionar')
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

event itemchanged;string ls_codigo, ls_descripcion, ls_uni_empaque, ls_uni
long   ll_bultos, ll_cantidad, ll_fraccion
decimal {2} ld_precio, ld_costo_cif
this.accepttext()
if this.getcolumnname() = 'facd_codigo_item' then
	  ls_codigo = data
	  SELECT inmprodu.prod_descripcion,   
         inmprodu.prod_empaque,   
         inmprodu.prod_medida,   
         inamedid_a.medi_cantidad,   
         inamedid_b.medi_cantidad,
			inmprodu.prod_peso,
			inmprodu.prod_cubicaje,
			inmprodu.prod_precio_mayor,
			inmprodu.prod_medida,
			inmprodu.prod_costo_cif
    INTO :ls_descripcion,   
         :il_empaque,   
         :ls_uni,   
         :ii_cantidad_unidad,   
         :ii_cantidad_empaque,
			:id_peso,
			:id_cubicaje,
			:id_precio,
			:is_unidad,
			:id_costo_cif
    FROM inmprodu,   
         inamedid inamedid_a,   
         inamedid inamedid_b  
   WHERE ( inamedid_a.medi_medida = inmprodu.prod_medida ) and  
         ( inmprodu.prod_empaque_um = inamedid_b.medi_medida ) and  
         ( ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
         ( inmprodu.prod_empresa = :str.empresa ) AND  
         ( inmprodu.prod_producto = :ls_codigo ) )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al recuperar datos del producto '+sqlca.sqlerrtext,1,1,'E')
			return 2
		end if
		if ls_descripcion = '' or isnull(ls_descripcion) then
			gf_mensaje('','Referencia no Existe, Verifique !!!',1,1,'E')
			this.setitem(row,'facd_codigo_item','')
			this.setcolumn('facd_codigo_item')
			return 2
		else
			this.setitem(row, 'facd_descripcion_alterna', ls_descripcion)
			this.setitem(row, 'facd_precio_unidad_producto', id_precio)
			this.setitem(row, 'facd_unidad_venta',is_unidad)
			this.setcolumn('facd_precio_unidad_producto')
		end if
elseif this.getcolumnname() = 'facd_cantidad' or this.getcolumnname() = 'facd_cantidad_fraccion' then
		if ii_cantidad_unidad = 0 or isnull(ii_cantidad_unidad) then
			ls_codigo = this.getitemstring(row,'facd_codigo_item')
		  SELECT inmprodu.prod_descripcion,   
				inmprodu.prod_empaque,   
				inmprodu.prod_medida,   
				inamedid_a.medi_cantidad,   
				inamedid_b.medi_cantidad,
				inmprodu.prod_peso,
				inmprodu.prod_cubicaje,
				inmprodu.prod_precio_mayor,
				inmprodu.prod_medida,
				inmprodu.prod_costo_cif
		 INTO :ls_descripcion,   
				:il_empaque,   
				:ls_uni,   
				:ii_cantidad_unidad,   
				:ii_cantidad_empaque,
				:id_peso,
				:id_cubicaje,
				:id_precio,
				:is_unidad,
				:id_costo_cif
		 FROM inmprodu,   
				inamedid inamedid_a,   
				inamedid inamedid_b  
		WHERE ( inamedid_a.medi_medida = inmprodu.prod_medida ) and  
				( inmprodu.prod_empaque_um = inamedid_b.medi_medida ) and  
				( ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
				( inmprodu.prod_empresa = :str.empresa ) AND  
				( inmprodu.prod_producto = :ls_codigo ) )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al recuperar datos del producto '+sqlca.sqlerrtext,1,1,'E')
				return 2
			end if
			
		end if
		ll_cantidad = this.getitemnumber(row,'facd_cantidad')	
		ll_fraccion = this.getitemnumber(row,'facd_cantidad_fraccion')	
		if isnull(ll_fraccion) then ll_fraccion = 0
		ld_precio   = this.getitemnumber(row, 'facd_precio_unidad_producto')
		if (il_empaque * ii_cantidad_empaque) <> 0 then
			ll_bultos = (ll_cantidad * ii_cantidad_unidad ) / (il_empaque * ii_cantidad_empaque)
		end if
		if ll_bultos = 0 then ll_bultos = 1
		this.setitem(row,'facd_monto_final', round( (ll_cantidad * ld_precio) + ((ld_precio / ii_cantidad_unidad) * ll_fraccion ) ,2) )
		this.setitem(row,'facd_monto_total', round( (ll_cantidad * ld_precio) + ((ld_precio / ii_cantidad_unidad) * ll_fraccion ) ,2) )
		this.setitem(row,'facd_bultos',ll_bultos)
		this.setitem(row,'facd_peso',ll_bultos * id_peso)
		this.setitem(row,'facd_cubicaje',round(ll_bultos * id_cubicaje,4))
		this.setitem(row,'facd_costo_cif', id_costo_cif)
		this.setitem(row,'facd_costo_total', round( (ll_cantidad * id_costo_cif) + ((id_costo_cif / ii_cantidad_unidad) * ll_fraccion ) ,2) )
		this.setcolumn('facd_bultos')
	
elseif this.getcolumnname() = 'facd_precio_unidad_producto' then	
	ld_precio = double(data)	
	ll_cantidad   = this.getitemnumber(row, 'facd_cantidad')	
	ld_costo_cif  = this.getitemnumber(row, 'facd_costo_cif')
	if isnull(ld_costo_cif) then ld_costo_cif = 0
	if ld_precio <= ld_costo_cif then
		gf_mensaje('','Verifique el Precio, es igual o menor al costo',1,1,'E')
	end if
	this.setitem(row,'facd_monto_final', round( ll_cantidad * ld_precio ,2))	
	this.setitem(row,'facd_monto_total', round( ll_cantidad * ld_precio ,2))	
	this.setcolumn('facd_cantidad')
elseif this.getcolumnname() = 'facd_cubicaje' then	
	if this.getrow() = this.rowcount() then
		parent.triggerevent('ue_adicionar')
	else
		this.scrolltorow(this.getrow() + 1)
		this.setcolumn('facd_codigo_item')
	end if
end if
end event

type dw_3 from datawindow within w_facturacion_standar
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

type dw_4 from datawindow within w_facturacion_standar
boolean visible = false
integer x = 55
integer y = 20
integer width = 3621
integer height = 2228
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Impresión de Pedidos"
string dataobject = "dw_imprimir_factura"
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

type cb_1 from commandbutton within w_facturacion_standar
integer x = 2949
integer y = 76
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

type cb_2 from commandbutton within w_facturacion_standar
integer x = 2939
integer y = 236
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

parent.triggerevent('ue_aceptar')

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

type dw_5 from datawindow within w_facturacion_standar
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
					( fatdiari.fact_no_factura = :ls_factura ) and
					( fatdiari.fact_estado = 'I');
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
		end if
		datawindow = 1
	case 'b_cancelar'
		dw_5.visible = false		
end choose
end event

type dw_6 from datawindow within w_facturacion_standar
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

type st_1 from statictext within w_facturacion_standar
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

type pb_1 from picturebutton within w_facturacion_standar
integer x = 2770
integer y = 452
integer width = 178
integer height = 152
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "C:\Harr2000\Art\NOTE04.BMP"
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

type st_2 from statictext within w_facturacion_standar
integer x = 2779
integer y = 604
integer width = 192
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
boolean focusrectangle = false
end type

type pb_kardex from picturebutton within w_facturacion_standar
integer x = 3122
integer y = 596
integer width = 352
integer height = 92
integer taborder = 60
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

