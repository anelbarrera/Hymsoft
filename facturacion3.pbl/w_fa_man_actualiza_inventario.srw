//objectcomments Ventana de actualización de las Facturas en Inventario
forward
global type w_fa_man_actualiza_inventario from w_fa_padre
end type
type dw_2 from datawindow within w_fa_man_actualiza_inventario
end type
type dw_3 from datawindow within w_fa_man_actualiza_inventario
end type
type rb_1 from radiobutton within w_fa_man_actualiza_inventario
end type
type rb_2 from radiobutton within w_fa_man_actualiza_inventario
end type
type rb_3 from radiobutton within w_fa_man_actualiza_inventario
end type
type rb_4 from radiobutton within w_fa_man_actualiza_inventario
end type
type rb_5 from radiobutton within w_fa_man_actualiza_inventario
end type
type gb_rango from groupbox within w_fa_man_actualiza_inventario
end type
type gb_marcado from groupbox within w_fa_man_actualiza_inventario
end type
type gb_2 from groupbox within w_fa_man_actualiza_inventario
end type
type gb_1 from groupbox within w_fa_man_actualiza_inventario
end type
type gb_3 from groupbox within w_fa_man_actualiza_inventario
end type
type rb_todas from radiobutton within w_fa_man_actualiza_inventario
end type
type rb_desmarcar from radiobutton within w_fa_man_actualiza_inventario
end type
type sle_desde from singlelineedit within w_fa_man_actualiza_inventario
end type
type sle_hasta from singlelineedit within w_fa_man_actualiza_inventario
end type
type st_2 from statictext within w_fa_man_actualiza_inventario
end type
type st_hasta from statictext within w_fa_man_actualiza_inventario
end type
type cb_1 from commandbutton within w_fa_man_actualiza_inventario
end type
type cb_imprimir from commandbutton within w_fa_man_actualiza_inventario
end type
type st_3 from statictext within w_fa_man_actualiza_inventario
end type
type dw_4 from datawindow within w_fa_man_actualiza_inventario
end type
end forward

global type w_fa_man_actualiza_inventario from w_fa_padre
integer width = 2807
integer height = 1556
string title = "(FA) Actualización de Facturas en Inventario"
string menuname = "m_hs"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 79741120
event ue_post_aceptar ( )
dw_2 dw_2
dw_3 dw_3
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
rb_5 rb_5
gb_rango gb_rango
gb_marcado gb_marcado
gb_2 gb_2
gb_1 gb_1
gb_3 gb_3
rb_todas rb_todas
rb_desmarcar rb_desmarcar
sle_desde sle_desde
sle_hasta sle_hasta
st_2 st_2
st_hasta st_hasta
cb_1 cb_1
cb_imprimir cb_imprimir
st_3 st_3
dw_4 dw_4
end type
global w_fa_man_actualiza_inventario w_fa_man_actualiza_inventario

type variables
Integer ii_anno
String is_no_pedido
str_fa_carg_ped str_pedi
long il_secuencia
datetime idt_fecha_invent
end variables

forward prototypes
public subroutine wf_botones ()
public subroutine wf_valida_rango ()
public subroutine wf_eliminar_registros ()
public function integer wf_actualiza_gastos (string ls_tipo, string ls_no_pedido, string ls_no_factura, integer li_anno)
public function boolean wf_eliminar_registro (readonly integer ll_secuencia, readonly string ls_concepto, long ai_fila)
public function integer wf_act_detalle (string ls_tipo, string ls_no_pedido, string ls_no_factura, integer li_anno)
public function integer wf_act_encabezado (long ai_fila)
end prototypes

event ue_post_aceptar;//llamado desde ue_aceptar
sqlca.autocommit = true
end event

public subroutine wf_botones ();//// Deshabilita algunas Opciones del Menú 
//   /*Insertar*/
//	m_fa_principal.m_edicin.m_insertar.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_insertar.visible=false
	
//	/*Adicionar*/
//	m_fa_principal.m_edicin.m_adicionar.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_adicionar.visible=false
	
//	/*Filtrar*/
//	m_fa_principal.m_edicin.m_filtrar.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_filtrar.visible=false
	
//	/*Sortear*/
//	m_fa_principal.m_edicin.m_sortear.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_sortear.visible=false
	
//	/*Primer Reg*/
//	m_fa_principal.m_edicin.m_primerregistro.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_primerregistro.visible=false
	
//	/*Ultimo Reg*/
//	m_fa_principal.m_edicin.m_ultimoregistro.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_ultimoregistro.visible=false
	
//	/*Sig Reg*/
//	m_fa_principal.m_edicin.m_siguienteregistro.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_siguienteregistro.visible=false
	
//   /*Reg Ant*/
//	m_fa_principal.m_edicin.m_registroanterior.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_registroanterior.visible=false

//   /*Imprimir*/
//   m_fa_principal.m_archivo.m_imprimir.toolbaritemvisible=false
//	m_fa_principal.m_archivo.m_imprimir.visible=false
	
//	/*Eliminar*/
//	m_fa_principal.m_edicin.m_eliminar.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_eliminar.visible=false

end subroutine

public subroutine wf_valida_rango ();String ls_letra,formato,ls_setting
Date	ldt_fecha
Datetime	ldt_fecha_inicial, ldt_fecha_final
Long	ll_count

IF (trim(sle_desde.text) <>'' and not isNull(sle_desde.text)) then
	
   If (trim(sle_hasta.text) ='' or isNull(sle_hasta.text))  then
		mensaje("Atención ","Si desea filtrar por rango de fecha, asegúrese de que el mismo sea correcto, de lo contrario, borre ambas fechas","")
		sle_hasta.Setfocus()
		Return
	end If
	
	IF date(trim(sle_hasta.text)) >= date(trim(sle_desde.text)) Then
		 
		If  date(sle_desde.text) <= date('01/01/1900') Then
			 mensaje("Atención ","Digite una fecha hasta Válida, por favor","")
			 this.setfocus()
			 return
		Else
			//Permite modificar el estado con la finalidad de que funcione el filtrado
			ls_setting = dw_1.Describe("DataWindow.Retrieve.AsNeeded")
			
			If ls_setting = "yes" Then 
				dw_1.Modify("DataWindow.Retrieve.AsNeeded=No")	
			End If	
			
			IF trim(sle_desde.text) <>'' and not isNull(sle_desde.text) Then
				ldt_fecha = date(sle_desde.text)
	
				ldt_fecha_inicial = Datetime(date(sle_desde.text),00:00:00)
				ldt_fecha_final 	= Datetime(date(sle_hasta.text),23:59:59)
			
				formato = "fatdiari_fact_fecha_creacion >= datetime('" + string(ldt_fecha_inicial) +"')"
				formato += " and fatdiari_fact_fecha_creacion <= datetime('" + string(ldt_fecha_final) +"')"
			
			END IF
			  
			// Filtra
			If Formato <> "" Then
				dw_1.SetFilter ( Formato)
				dw_1.Filter()
				If dw_1.Rowcount() > 0 then
//					For ll_count = 1 to dw_1.rowcount()
//						dw_1.SetItem(ll_count,"fatdiari_fact_act_inventario",1)
//					Next
					//mensaje("Atención ","El proceso de SELECCION DE FACTURAS ha culminado con éxito, proceda a salvar ","")
				Else
					mensaje("Atención ","No hay facturas por actualizar en este período","")
				End If
			End If	
		End if
	Else
		mensaje("Atención "," La fecha HASTA no puede ser menor que la fecha DESDE ","")
		sle_desde.SetFocus()
		return
	End If
End If	 

end subroutine

public subroutine wf_eliminar_registros (); 

end subroutine

public function integer wf_actualiza_gastos (string ls_tipo, string ls_no_pedido, string ls_no_factura, integer li_anno);//Función que Actualiza el Detalle de los Cargos en INDGASTOS
integer li_exist, li_linea
string  ls_descrip, ls_tipo_transaccion
double  ld_monto
Long    ll_no_factura

ll_no_factura = long(ls_no_factura) 
ls_tipo_transaccion='FA'

if pos(ls_no_pedido,'NC') > 0 THEN ls_tipo_transaccion='DV'

	//Verifica si hay detalle 
	SELECT count(*)  
  	INTO   :li_exist  
 	FROM   fadcargo  
 	WHERE (( fadcargo.dcar_g_financiero = :str.g_financiero ) AND  
         ( fadcargo.dcar_empresa = :str.empresa ) AND  
         ( fadcargo.dcar_no_pedido = :ls_no_pedido ) AND  
         ( fadcargo.dcar_ann = :li_anno ) AND  
         ( fadcargo.dcar_tipo = :ls_tipo));
		  
		if sqlca.sqlcode = -1 then
			mensaje("Información (wf_actualiza_gastos)","Error al Seleccionar un count en fadcargo",sqlca.sqlerrtext)
			return -1
		end if	  

If li_exist > 0 Then
  Declare cursor_gas Cursor For  
  SELECT faacargo.carg_descripcion,   
         fadcargo.dcar_monto  
    FROM fadcargo,   
         faacargo  
   WHERE ( fadcargo.dcar_codigo = faacargo.carg_cargo ) and  
         ((fadcargo.dcar_g_financiero =:str.g_financiero  ) AND  
         ( fadcargo.dcar_empresa = :str.empresa ) AND  
         ( fadcargo.dcar_no_pedido = :ls_no_pedido  ) AND  
         ( fadcargo.dcar_ann = :li_anno  ) AND  
         ( fadcargo.dcar_tipo = :ls_tipo)) ;
			
	Open cursor_gas;
		
	Fetch cursor_gas Into :ls_descrip, :ld_monto;				
					
		If SQLCA.SQLCODE = -1 Then
			Messagebox("ATENCION SR. USUARIO.","ERROR EN LA ACTUALIZACIÓN DE LOS GASTOS.")
			Close cursor_gas;
			Return(0)
  		End If	
		
	Do While SQLCA.SQLCODE = 0
			
		li_linea ++

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
	   VALUES (:str.g_financiero,   
     		  	  :str.empresa,   
	           :str.aplicacion,   
	           :ls_tipo_transaccion,
				  :ls_tipo,
	           :il_secuencia,   
	           :li_linea,   
				  :li_anno,
	           :ls_descrip,   
	           :ld_monto);
		
		If Sqlca.Sqlerrtext <> "" Then
			Messagebox("Error al isertar los Gastos",SQLCA.SQLERRTEXT+' Fact No. '+ls_no_factura)			
			Return(0)
		End If
		
		Fetch cursor_gas Into :ls_descrip, :ld_monto;
		
	Loop
	Close cursor_gas;

End If

Return(1) 
end function

public function boolean wf_eliminar_registro (readonly integer ll_secuencia, readonly string ls_concepto, long ai_fila);if ll_secuencia <> 0 then
String	ls_no_pedido,ls_tipo_transaccion
ls_tipo_transaccion='FA'
ls_no_pedido = dw_1.GetItemString(ai_fila,"fact_no_pedido")

if pos(ls_no_pedido,'NC') > 0 THEN ls_tipo_transaccion='DV'
	
	  DELETE FROM indgasto  
   WHERE ( indgasto.gast_g_financiero = :str.g_financiero ) AND  
         ( indgasto.gast_empresa = :str.empresa ) AND  
         ( indgasto.gast_aplicacion = :str.aplicacion ) AND  
         ( indgasto.gast_transaccion = :ls_tipo_transaccion ) AND  
         ( indgasto.gast_concepto = :ls_concepto ) AND  
         ( indgasto.gast_secuencia = :ll_secuencia ) AND  
         ( indgasto.gast_ann = :ii_anno )   
           ;
if sqlca.sqlcode = -1 then
	gf_mensaje('','Error al eliminar cargos '+sqlca.sqlerrtext,1,1,'E')
	return false
end if
	
	
   DELETE FROM indmovim  
   WHERE ( indmovim.dmov_g_financiero = :str.g_financiero ) AND  
         ( indmovim.dmov_empresa = :str.empresa ) AND  
         ( indmovim.dmov_aplicacion = :str.aplicacion ) AND  
         ( indmovim.dmov_tipo_transaccion = :ls_tipo_transaccion ) AND  
         ( indmovim.dmov_concepto = :ls_concepto ) AND  
         ( indmovim.dmov_secuencia = :ll_secuencia ) AND  
         ( indmovim.dmov_anual = :ii_anno )   
           ;
if sqlca.sqlcode = -1 then
	gf_mensaje('','Error al eliminar detalle '+sqlca.sqlerrtext,1,1,'E')
	return false
end if

	
	
	delete from intmovim where   
           tmov_g_financiero = :str.g_financiero   and
           tmov_empresa = :str.empresa    and
           tmov_aplicacion =  :str.aplicacion and 
           tmov_tipo_transaccion = :ls_tipo_transaccion and
           tmov_secuencia = :ll_secuencia and
           tmov_concepto  = :ls_concepto  and  
           tmov_anual     = :ii_anno ;
if sqlca.sqlcode = -1 then
	gf_mensaje('','Error al eliminar encabezado '+sqlca.sqlerrtext,1,1,'E')
	return false
end if
			  
			  
else 
	/**/
end if

return true
end function

public function integer wf_act_detalle (string ls_tipo, string ls_no_pedido, string ls_no_factura, integer li_anno);long li_linea
string  ls_bodega, ls_ubicacion, ls_codigo_item, ls_unidad_venta, ls_tipo_transaccion
decimal  ld_cantidad, ld_cant_frac, ld_bultos, ld_costo_cif, ld_precio, ld_costo_fob, ld_precio_original
ls_tipo_transaccion='SA'
decimal{4} ld_cubicaje, ld_peso

if pos(ls_no_pedido,'NC') > 0 THEN ls_tipo_transaccion='DV'


Declare cur_det_factura cursor for
	SELECT faddiari.facd_linea,   
   	    faddiari.facd_bodega,   
          faddiari.facd_ubicacion,   
          faddiari.facd_codigo_item,   
          faddiari.facd_cantidad,   
          faddiari.facd_cantidad_fraccion,   
          faddiari.facd_unidad_venta,   
          faddiari.facd_cubicaje,   
          faddiari.facd_peso,   
          faddiari.facd_bultos,   
          faddiari.facd_costo_cif,
			 faddiari.facd_precio_unidad_producto,
			 faddiari.facd_costo_fob,
			 faddiari.facd_precio_original
	FROM faddiari,
        fatdiari
   WHERE ((fatdiari.fact_g_financiero = faddiari.facd_g_financiero ) and  
         ( fatdiari.fact_empresa = faddiari.facd_empresa ) and  
         ( fatdiari.fact_tipo = faddiari.facd_tipo ) and  
         ( fatdiari.fact_no_pedido = faddiari.facd_no_pedido ) and  
         ( fatdiari.fact_ann = faddiari.facd_ann ) and
         ( faddiari.facd_g_financiero = :str.g_financiero ) and
         ( faddiari.facd_empresa = :str.empresa ) and 
         ( faddiari.facd_tipo    = :ls_tipo ) and 
         ( faddiari.facd_no_pedido = :ls_no_pedido ) and
         ( facd_ann=:li_anno));
		
		if sqlca.sqlcode = -1 then
			mensaje("Información (wf_act_detalle)","Error al Seleccionar en faddiari y en fatdiari",sqlca.sqlerrtext)
			return -1
		end if
		
Open cur_det_factura;

Fetch cur_det_factura into :li_linea, :ls_bodega, :ls_ubicacion, :ls_codigo_item, 
                           :ld_cantidad, :ld_cant_frac, :ls_unidad_venta, :ld_cubicaje,
									:ld_peso, :ld_bultos, :ld_costo_cif, :ld_precio, :ld_costo_fob, :ld_precio_original ;

	If sqlca.sqlcode = -1 Then
		mensaje("Error","Fallo en apertura del Cursor"+Sqlca.Sqlerrtext,"")
		Close cur_det_factura;
		Return(0)
	End If

	ld_cubicaje	= truncate(round(ld_cubicaje,4),4)
	ld_peso		= truncate(round(ld_peso,6),6)
	
	Do While sqlca.sqlcode = 0 	
	  INSERT INTO indmovim  
   	      ( dmov_g_financiero,    dmov_empresa,   
      	     dmov_aplicacion,   	dmov_tipo_transaccion,   
         	  dmov_secuencia,   		dmov_documento,   
	           dmov_linea,   			dmov_bodega,   
   	        dmov_ubicacion,   		dmov_producto,   
      	     dmov_cantidad,   		dmov_cant1,   
         	  dmov_unidad_medida,   dmov_cubicaje,
				  dmov_peso,            dmov_bulto, 
  				  dmov_id,              dmov_anual,		
				  dmov_concepto,        dmov_precio,
				  dmov_costo,				dmov_costo_fob,
				  dmov_precio_original)			  
	  VALUES ( :str.g_financiero, 	:str.empresa,   
   	        :str.aplicacion,   	:ls_tipo_transaccion,   
	           :il_secuencia,   		:ls_no_factura,   
   	        :li_linea,   			:ls_bodega,   
      	     :ls_ubicacion,   		:ls_codigo_item,   
         	  :ld_cantidad,   		:ld_cant_frac,   
	           :ls_unidad_venta,   	:ld_cubicaje,   
   	        :ld_peso,             :ld_bultos,
      	     :str.usuario,         :li_anno,	
				  :ls_tipo,        		:ld_precio,
				  :ld_costo_cif,		   :ld_costo_fob,
				  :ld_precio_original);   
		
		If Sqlca.Sqlerrtext <> "" Then
			mensaje("Error","Fallo al insertar en el Cursor producto "+ls_codigo_item+" "+Sqlca.Sqlerrtext,ls_codigo_item)
			Close cur_det_factura;
			Return(0)
		End If
		
		
		Fetch cur_det_factura into :li_linea, :ls_bodega, :ls_ubicacion, :ls_codigo_item, 
                          			:ld_cantidad, :ld_cant_frac, :ls_unidad_venta, :ld_cubicaje,
											:ld_peso, :ld_bultos, :ld_costo_cif, :ld_precio, :ld_costo_fob, :ld_precio_original ;
	
	Loop
	Close cur_det_factura;

//Para que no rebaje reserva las siguientes veces

	  UPDATE intmovim  
		  SET tmov_rebaja_reserva = 0  
		WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
				( intmovim.tmov_empresa = :str.empresa ) AND  
				( intmovim.tmov_aplicacion = :str.aplicacion ) AND  
				( intmovim.tmov_tipo_transaccion = :ls_tipo_transaccion ) AND  
				( intmovim.tmov_secuencia = :il_secuencia ) AND  
				( intmovim.tmov_concepto = :ls_tipo ) AND  
				( intmovim.tmov_anual = :li_anno ) ;
		
		if sqlca.sqlcode = -1 then
			messagebox("ATENCIÓN SR. USUARIO","Error en Rebaja Reserva: "+sqlca.sqlerrtext)
			return(0)
		end if


Return(1)
end function

public function integer wf_act_encabezado (long ai_fila);//Función que actualiza el encabezado de las facturas en la Tabla INTMOVIM de Inventario
Integer  li_anual, li_retorno, li_existe
Long     ll_cliente, ll_secuencia
String   ls_documento, ls_comen, ls_concepto, ls_nombre_tercero, ls_terminos, ls_pedido
Datetime ldt_fecha
Decimal   ld_final, ld_cargos, ld_monto, ld_descuento
String	ls_tipo_transaccion,ls_no_pedido, ls_naturaleza, ls_marca
//
//Carga los datos en las variables
ls_documento = dw_1.GetItemString(ai_fila,"fact_no_factura")

ls_tipo_transaccion='SA'
ls_naturaleza ='C'

ls_no_pedido = dw_1.GetItemString(ai_fila,"fact_no_pedido")

if pos(ls_no_pedido,'NC') > 0 THEN 
	ls_tipo_transaccion='DV'
	ls_naturaleza ='D'
end if

ll_secuencia = long(ls_documento)
ls_concepto  = dw_1.GetItemString(ai_fila,"fact_tipo")

//si la secuencia devuelve 0, porque tiene letras la factura, que busque la secuencia de la transaccion
//de salidas de inventario

/**/

if not wf_eliminar_registro(ll_secuencia,ls_concepto,ai_fila) then /* Elimina los registros en el sistema de inventarios si estan*/	
	rollback;
	sqlca.autocommit = true
	return 0
end if
/**/
if ll_secuencia <= 0 then
	
  SELECT dgmserie.mser_secuencia
    INTO :ll_secuencia
    FROM dgmserie  
   WHERE ( dgmserie.mser_g_financiero = :str.g_financiero ) AND  
         ( dgmserie.mser_empresa = :str.empresa ) AND  
         ( dgmserie.mser_tipo_transaccion = :ls_tipo_transaccion );
			
			if sqlca.sqlcode = -1 then
				mensaje("Aviso", "Error al Seleccionar la Secuencia",sqlca.sqlerrtext)
			end if
			
			do 
				  ll_secuencia ++						
				  
				  SELECT count(*)  
					 INTO :li_existe  
					 FROM intmovim  
					WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
							( intmovim.tmov_empresa = :str.empresa ) AND  
							( intmovim.tmov_aplicacion = 'FA' ) AND  
							( intmovim.tmov_tipo_transaccion = :ls_tipo_transaccion ) AND  
							( intmovim.tmov_secuencia = :ll_secuencia ) AND  
							( intmovim.tmov_anual = :ii_anno ) ;
					if sqlca.sqlcode = -1 then
						mensaje("Aviso", "Error al Validar la Secuencia",sqlca.sqlerrtext)
					end if
			
			loop	while li_existe > 0
			
	  UPDATE dgmserie  
     SET mser_secuencia = :ll_secuencia  
		WHERE ( dgmserie.mser_g_financiero = :str.g_financiero ) AND  
				( dgmserie.mser_empresa = :str.empresa ) AND  
				( dgmserie.mser_tipo_transaccion = :ls_tipo_transaccion );
				
			if sqlca.sqlcode = -1 then
				mensaje("Aviso", "Error al Actualizar la Secuencia",sqlca.sqlerrtext)
			end if			
	
end if

il_secuencia = ll_secuencia	//il_secuencia es utilizada para el detalle de los registros



ldt_fecha	 = dw_1.GetItemDatetime(ai_fila,"fatdiari_fact_fecha")
ll_cliente   = dw_1.GetItemNumber(ai_fila,"fact_cliente")
ls_terminos	 = dw_1.getitemstring(ai_fila,"fatdiari_fact_condicion_pago")
ls_pedido	 = dw_1.getitemstring(ai_fila,"fact_no_pedido")

ls_nombre_tercero = dw_1.getitemstring(ai_fila,"fatdiari_fact_a_nombre")
ls_marca = dw_1.getitemstring(ai_fila,"fatdiari_fact_marca")

//ls_comen		 = dw_1.GetItemString(ai_fila,"fatdiari_fact_comentario")
if pos(ls_no_pedido,'NC') > 0 THEN 
	ls_comen		 =	"Nota de Credito # "+ls_documento+" "+ls_terminos+ "/Ped. "+ls_pedido+" a "+ls_nombre_tercero
else
	ls_comen		 =	"Factura # "+ls_documento+" "+ls_terminos+ "/Ped. "+ls_pedido+" a "+ls_nombre_tercero
end if

ld_final     = dw_1.GetItemNumber(ai_fila,"fact_monto_final")
ld_monto 	 = dw_1.GetItemNumber(ai_fila,"fatdiari_fact_monto_fact_total")
ld_cargos	 = dw_1.GetItemNumber(ai_fila,"fatdiari_fact_gastos_total")

ld_descuento =	abs( round(ld_final,2) - round(ld_cargos,2) - round(ld_monto,2) )

//Para que aparezca en el kardex
if ls_terminos = 'CO' then ls_nombre_tercero = 'CONTADO - '+ls_nombre_tercero

//Inserto en INTMOVIM
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
  			  tmov_nombre_tercero,
			  tmov_no_pedido,
			  tmov_rebaja_reserva,
			  tmov_marca_cliente)
  VALUES ( :str.g_financiero,   
           :str.empresa,
           :str.aplicacion,   
           :ls_tipo_transaccion,   	        //Tipo de Transacción: SA=Salida
           :ll_secuencia,   
           :ls_concepto,   
           :ldt_fecha,   
           :str.usuario,  
           :ls_documento,
           :ll_cliente,   
           :ls_comen,   
           :str.usuario,
			  :ls_naturaleza,	   
           :ii_anno,
			  :ls_nombre_tercero,
			  :ls_pedido,
			  1,
			  :ls_marca);

If sqlca.sqlcode = -1 then
	string a
	a=""
	messagebox("ATENCIÓN SR. USUARIO","Error: "+sqlca.sqlerrtext)
	li_retorno = 0
//	ROLLBACK;
Else
	li_retorno = 1
End If

Return(li_retorno)

end function

on w_fa_man_actualiza_inventario.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.dw_2=create dw_2
this.dw_3=create dw_3
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.rb_4=create rb_4
this.rb_5=create rb_5
this.gb_rango=create gb_rango
this.gb_marcado=create gb_marcado
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_3=create gb_3
this.rb_todas=create rb_todas
this.rb_desmarcar=create rb_desmarcar
this.sle_desde=create sle_desde
this.sle_hasta=create sle_hasta
this.st_2=create st_2
this.st_hasta=create st_hasta
this.cb_1=create cb_1
this.cb_imprimir=create cb_imprimir
this.st_3=create st_3
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.rb_1
this.Control[iCurrent+4]=this.rb_2
this.Control[iCurrent+5]=this.rb_3
this.Control[iCurrent+6]=this.rb_4
this.Control[iCurrent+7]=this.rb_5
this.Control[iCurrent+8]=this.gb_rango
this.Control[iCurrent+9]=this.gb_marcado
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.gb_3
this.Control[iCurrent+13]=this.rb_todas
this.Control[iCurrent+14]=this.rb_desmarcar
this.Control[iCurrent+15]=this.sle_desde
this.Control[iCurrent+16]=this.sle_hasta
this.Control[iCurrent+17]=this.st_2
this.Control[iCurrent+18]=this.st_hasta
this.Control[iCurrent+19]=this.cb_1
this.Control[iCurrent+20]=this.cb_imprimir
this.Control[iCurrent+21]=this.st_3
this.Control[iCurrent+22]=this.dw_4
end on

on w_fa_man_actualiza_inventario.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.gb_rango)
destroy(this.gb_marcado)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.rb_todas)
destroy(this.rb_desmarcar)
destroy(this.sle_desde)
destroy(this.sle_hasta)
destroy(this.st_2)
destroy(this.st_hasta)
destroy(this.cb_1)
destroy(this.cb_imprimir)
destroy(this.st_3)
destroy(this.dw_4)
end on

event ue_post_open;string ls_vienede, ls_where
DataWindowChild child_produc

dw_3.SetTransObject(SQLCA)
dw.settransobject(Sqlca)
dw.Retrieve(str.g_financiero,str.empresa)

dw_2.SetTransObject(SQLCA)
dw_2.InsertRow(0)
dw_2.setfocus()
dw_2.SetColumn("texto")

  SELECT inaparam.para_cierre_inventario  
    INTO :idt_fecha_invent  
    FROM inaparam  
   WHERE ( inaparam.para_g_financiero = :str.g_financiero ) AND  
         ( inaparam.para_empresa = :str.empresa );
	if sqlca.sqlcode = -1 then
		mensaje('Aviso','Error al Seleccionar la Fecha de Parámetros ',sqlca.sqlerrtext)
	end if

if idt_fecha_invent < datetime('01/01/1990 00:00:00') or isnull(idt_fecha_invent) then
	idt_fecha_invent = datetime(RelativeDate(date(gf_fecha_serv()), - 365))
end if

sle_desde.text = string(date(idt_fecha_invent))
sle_hasta.text = string(date(gf_fecha_serv()))

//dw.setfilter("fact_fecha >= '01/01/2001'")
//"+string(date(idt_fecha_invent))+"'")
//dw.filter()

This.PostEvent("ue_hay_data")
end event

event ue_hay_data;//Override
If dw.RowCount() > 0 Then
	ii_anno = dw.GetItemNumber(1,"fact_ann")
	is_no_pedido = dw.GetItemString(1,"fact_no_pedido")
	
	dw_3.Retrieve(str.g_financiero,str.empresa,is_no_pedido,ii_anno)
	dw.SelectRow(0, FALSE)
   dw.SelectRow(1, TRUE)
End If
end event

event open;This.SetRedraw(False)
wf_botones()
This.SetRedraw(true)
dw = dw_1
this.postevent("ue_post_open")

end event

event ue_aceptar;//Override
Integer li_fila_dw1, li_fila_dw3, li_anno, li_check
Long    ll_update_dw, ll_update_encab, ll_update_detalle, ll_update_cargos
String  ls_tipo, ls_no_factura, ls_no_pedido, ls_formato, ls_error


this.postevent('ue_post_aceptar')
dw_1.AcceptText()
ls_formato = "fatdiari_fact_act_inventario = 1"
dw_1.Setfilter(ls_formato)
dw_1.Filter()

If dw_1.RowCount() < 1 Then 
	mensaje("Atención estimado Usuario ","No hay ninguna factura seleccionada para actualizar, debe seleccionar las facturas que desee actualizar","")
	return
End if

if gf_mensaje("","¿ Está Seguro que Desea ACTUALIZAR las Transacciones Seleccionadas ?",2,1,"E") = 2 then return

//Imprime el detalle de facturas a actualizar
cb_imprimir.TriggerEvent("Cliked") 

ls_formato = "fatdiari_fact_act_inventario = 1"
dw_1.Setfilter(ls_formato)
dw_1.Filter()

sqlca.autocommit = false

For li_fila_dw1 = 1 to dw_1.RowCount()
	
	If dw_1.GetItemNumber(li_fila_dw1,"fatdiari_fact_act_inventario") = 1 Then
		li_check ++
		ll_update_encab = wf_act_encabezado(li_fila_dw1)  // Inserta reg de encab en Intmovim
		
		If ll_update_encab = 1 Then
			ls_tipo  = dw_1.GetItemString(li_fila_dw1,"fact_tipo")
			ls_no_factura = dw_1.GetItemString(li_fila_dw1,"fact_no_factura")
			ls_no_pedido  = dw_1.GetItemString(li_fila_dw1,"fact_no_pedido")
			li_anno = dw_1.GetItemNumber(li_fila_dw1,"fact_ann")
			
			// Inserta reg de detalle en Indmovim
	 		ll_update_detalle = wf_act_detalle(ls_tipo,ls_no_pedido,ls_no_factura,li_anno)
			 
   	   If ll_update_detalle = 1 Then
				ll_update_cargos = wf_actualiza_gastos(ls_tipo,ls_no_pedido,ls_no_factura,li_anno)
			Else
				mensaje("Error","Falló al intentar guardar el detalle de la factura","")
				Rollback Using Sqlca;			
				sqlca.autocommit = true
				Return
			End If	
		Else
			mensaje("Error","Falló al intentar guardar el encabezado de la factura","")
			Rollback Using Sqlca;			
			Return
		End If

		If ll_update_encab = 1 And & 
			ll_update_detalle = 1 And ll_update_cargos = 1 Then
			Commit Using Sqlca;
			str.frame.setmicrohelp('Actualizando la Factura ....>>'+ls_no_factura+'    Registro '+string(li_fila_dw1)+' de '+string(dw_1.rowcount()))
			if li_fila_dw1 + 1 <= dw_1.rowcount() then
				dw_1.scrolltorow(li_fila_dw1 + 1)
			end if
			
//			dw.Retrieve(str.g_financiero,str.empresa)
//			dw_3.Reset()
//			dw_1.TriggerEvent("RowFocusChanged") 


		Else
			messagebox("Atención:", "¡¡¡ Error al Actualizar !!! "+sqlca.sqlerrtext)
			Rollback Using Sqlca;			
//			This.SetRedraw(False)
			dw.Retrieve(str.g_financiero,str.empresa)
			dw_3.Reset()
//			dw_1.TriggerEvent("RowFocusChanged") 
			if li_fila_dw1 + 1 < dw_1.rowcount() then
				dw_1.scrolltorow(li_fila_dw1 + 1)
			end if
//			This.SetRedraw(True)			
			return
		End If

	End If
	
Next

ll_update_dw = dw_1.Update()
if ll_update_dw = -1 then
	ls_error = sqlca.sqlerrtext
	messagebox("Atención:", "¡¡¡ Error al Actualizar !!! "+ls_error)
	Rollback Using Sqlca;			

	dw.Retrieve(str.g_financiero,str.empresa)
	dw_3.Reset()
	dw_1.TriggerEvent("RowFocusChanged") 
	
else
		Commit Using Sqlca;
		messagebox("Atención:", "Actualización Exitosa !")		
end if

If li_check = 0 Then
   mensaje("Atención Sr. Usuario:","Para actualizar las facturas en inventario, haga" + &
      	  " un  <<Check>>  en la columna de actualizar, la cual corresponda con" + & 
			  " la línea de la factura que Ud. desea seleccionar.","")
else
	dw.Retrieve(str.g_financiero,str.empresa)
	dw_3.Reset()
	dw_1.TriggerEvent("RowFocusChanged") 

End If

dw_1.Setfilter('')
dw_1.Filter()

end event

event resize;//Override
end event

event closequery;constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)

This.SetRedraw(false)
end event

event close;Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
 
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_man_actualiza_inventario
boolean visible = false
integer x = 27
integer y = 1284
integer width = 1280
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_man_actualiza_inventario
event ue_postitemchanged ( )
integer x = 46
integer y = 52
integer width = 2629
integer height = 332
integer taborder = 0
string dataobject = "dw_man_fa_act_inv_encabezado"
boolean vscrollbar = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_1::ue_postitemchanged;This.SelectRow(0, FALSE)
This.SelectRow(dw.GetRow(), TRUE)
	
ii_anno = dw.GetItemNumber(dw.GetRow(),"fact_ann")
is_no_pedido = dw.GetItemString(dw.GetRow(),"fact_no_pedido")
	
Parent.SetRedraw(False)
dw_3.Retrieve(str.g_financiero,str.empresa,is_no_pedido,ii_anno)
Parent.SetRedraw(True)
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;//Recupera los datos del Detalle haciendo Referencia al Encabezado

This.SelectRow(0, FALSE)
This.SelectRow(currentrow, TRUE)

	If dw_1.RowCount() > 0 Then
		
		ii_anno = dw.GetItemNumber(currentrow,"fact_ann")
		is_no_pedido = dw.GetItemString(currentrow,"fact_no_pedido")
	
		Parent.SetRedraw(False)
		dw_3.Retrieve(str.g_financiero,str.empresa,is_no_pedido,ii_anno)
		Parent.SetRedraw(True)
		
	End If
end event

event dw_1::clicked;call super::clicked;This.SelectRow(0, FALSE)
This.SelectRow(row, TRUE)

//This.TriggerEvent("RowFocusChanged")

end event

event dw_1::losefocus;call super::losefocus;this.SelectRow (0, False)
end event

event dw_1::itemchanged;call super::itemchanged;String ls_campo

ls_campo = dw_1.GetColumnName()

If ls_campo = "fact_act_inventario" Then
	This.TriggerEvent("ue_postitemchanged")
End If
end event

type st_ayuda from w_fa_padre`st_ayuda within w_fa_man_actualiza_inventario
end type

type dw_2 from datawindow within w_fa_man_actualiza_inventario
integer x = 786
integer y = 1132
integer width = 800
integer height = 88
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_texto"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event editchanged;String ls_letra,formato,ls_setting,ls_estado
This.accepttext()
ls_letra =This.getitemstring(1,1) 


If Match (ls_letra, "%") = True Then Return
If ls_letra = "Texto" Then Return


// Permite Modificar el estado Con la Finalidad de que Funcione el Filtrado
      ls_setting = dw_1.Describe("DataWindow.Retrieve.AsNeeded")
       If ls_setting = "yes" Then 
           dw_1.Modify("DataWindow.Retrieve.AsNeeded=No")	
       End If	



IF rb_1.Checked = True THEN /*Cliente*/
	Formato =  "String("  + "dgmterce_terc_descripcion)"  + "like "   + "'" + ls_letra +"%" + "'"

	ELSEIF rb_2.Checked = True THEN /*# Pedido*/
		Formato =  "String("  + "fact_no_pedido)"  + "like "   + "'" + ls_letra +"%" + "'"
		
		ELSEIF rb_3.Checked = True THEN /*# Factura*/
			Formato =  "String("  + "fact_no_factura)"  + "like "   + "'" + ls_letra +"%" + "'"

			ELSEIF rb_5.Checked = True THEN /*Fecha*/
				Formato =  "String("  + "fatdiari_fact_fecha)"  + "like "   + "'" + ls_letra +"%" + "'"

				ELSEIF rb_4.Checked = True THEN /*Monto Final*/
					Formato =  "String("  + "fact_monto_final)"  + "like "   + "'" + ls_letra +"%" + "'"

					
      		END IF
						
						
If Formato <> "" Then
	
	dw_1.SetFilter(Formato)
	dw_1.Filter()
	
	If dw_1.RowCount() > 0 Then 
		dw_1.Trigger Event RowFocusChanged(1)
	Else
		dw_3.Reset()
	End If	
	
End If
end event

type dw_3 from datawindow within w_fa_man_actualiza_inventario
integer x = 37
integer y = 468
integer width = 2647
integer height = 476
boolean bringtotop = true
string dataobject = "dw_man_fa_act_inv_detalle"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_1 from radiobutton within w_fa_man_actualiza_inventario
integer x = 471
integer y = 1124
integer width = 261
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Cliente "
boolean lefttext = true
end type

event clicked;dw_2.Postevent("editchanged")
end event

type rb_2 from radiobutton within w_fa_man_actualiza_inventario
integer x = 78
integer y = 1048
integer width = 297
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "# Pedido "
boolean lefttext = true
end type

event clicked;dw_2.Postevent("editchanged")
end event

type rb_3 from radiobutton within w_fa_man_actualiza_inventario
integer x = 425
integer y = 1048
integer width = 306
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "# Factura "
boolean lefttext = true
end type

event clicked;dw_2.Postevent("editchanged")
end event

type rb_4 from radiobutton within w_fa_man_actualiza_inventario
integer x = 791
integer y = 1048
integer width = 379
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Monto Total "
boolean lefttext = true
end type

event clicked;dw_2.Postevent("editchanged")
end event

type rb_5 from radiobutton within w_fa_man_actualiza_inventario
integer x = 128
integer y = 1124
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Fecha"
boolean lefttext = true
end type

event clicked;dw_2.Postevent("editchanged")
end event

type gb_rango from groupbox within w_fa_man_actualiza_inventario
integer x = 2130
integer y = 976
integer width = 585
integer height = 292
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79416533
string text = "Rango"
end type

type gb_marcado from groupbox within w_fa_man_actualiza_inventario
integer x = 1646
integer y = 976
integer width = 475
integer height = 292
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79416533
string text = "Selec /Deselec."
end type

type gb_2 from groupbox within w_fa_man_actualiza_inventario
integer x = 18
integer y = 420
integer width = 2693
integer height = 552
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79416533
string text = " Detalle "
end type

type gb_1 from groupbox within w_fa_man_actualiza_inventario
integer x = 18
integer width = 2688
integer height = 412
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79416533
string text = " Encabezado "
end type

type gb_3 from groupbox within w_fa_man_actualiza_inventario
integer x = 18
integer y = 972
integer width = 1618
integer height = 292
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79416533
string text = " Búsquedas "
end type

type rb_todas from radiobutton within w_fa_man_actualiza_inventario
integer x = 1669
integer y = 1024
integer width = 425
integer height = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Selec. Todas "
boolean lefttext = true
end type

event clicked;Long	ll_count
dw_1.SetFilter ("")
dw_1.Filter()

If dw_1.Rowcount() > 0 then
	For ll_count = 1 to dw_1.rowcount()
		dw_1.SetItem(ll_count,"fatdiari_fact_act_inventario",1)
	Next
//	mensaje("Atención ","El proceso de selección de facturas ha culminado con éxito, proceda a salvar ","")
Else
	mensaje("Atención ","No hay facturas por actualizar ","")
End If

end event

type rb_desmarcar from radiobutton within w_fa_man_actualiza_inventario
integer x = 1669
integer y = 1132
integer width = 425
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Deseleccionar"
boolean lefttext = true
end type

event clicked;Long	ll_count
Boolean	lb_selec

lb_selec = False
If dw_1.Rowcount() > 0 then
	For ll_count = 1 to dw_1.rowcount()
		If dw_1.GetItemNumber(ll_count,"fatdiari_fact_act_inventario") = 1 Then
			dw_1.SetItem(ll_count,"fatdiari_fact_act_inventario",0)
			lb_selec = True
		End If
	Next
	If lb_selec Then
	//	mensaje("Atención ","El proceso de Deselección ha culminado con éxito ","")
	End If
End if

If lb_selec = False Then
	mensaje("Atención ","No hay facturas seleccionadas","")
End If

end event

type sle_desde from singlelineedit within w_fa_man_actualiza_inventario
event key pbm_keydown
integer x = 2350
integer y = 1036
integer width = 343
integer height = 68
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event key;//if Key = KeyEnter! then
//	messagebox("","Voy al editchanged desde keyenter")
//	is_viene_de = '1'
//
//	dw_2.Triggerevent("edithchanged")
//end if
end event

event modified;IF trim(sle_desde.text) <> '' and not isNull(sle_desde.text) Then
	If date(sle_desde.text) <= date(idt_fecha_invent) Then
		 mensaje("Atención ","Digite una fecha correcta o  superior al mes de proceso de inventario, por favor","")
		 sle_desde.text = string(date(idt_fecha_invent))		 
		 this.setfocus()
		 return
	End if
End If
		 
end event

type sle_hasta from singlelineedit within w_fa_man_actualiza_inventario
event key pbm_keydown
integer x = 2350
integer y = 1132
integer width = 343
integer height = 68
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event key;if Key = KeyEnter! then
	wf_valida_rango()
end if
end event

event modified;//wf_valida_rango()

IF (trim(sle_desde.text) <>'' and not isNull(sle_desde.text)) then
	
   If (trim(sle_hasta.text) ='' or isNull(sle_hasta.text))  then
		mensaje("Atención ","Si desea filtrar por rango de fecha, asegúrese de que el mismo sea correcto, de lo contrario, borre ambas fechas","")
		sle_hasta.Setfocus()
		Return
	end If
	
	IF date(trim(sle_hasta.text)) < date(trim(sle_desde.text)) or &
		date(sle_desde.text) <= date(idt_fecha_invent) Then
		 mensaje("Atención ","Verifique que el rango de fecha sea Válido, por favor","")
		 sle_desde.setfocus()
		 return
	End If
End If	 

end event

type st_2 from statictext within w_fa_man_actualiza_inventario
integer x = 2171
integer y = 1040
integer width = 155
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long backcolor = 79416533
boolean enabled = false
string text = "Desde"
boolean focusrectangle = false
end type

type st_hasta from statictext within w_fa_man_actualiza_inventario
integer x = 2171
integer y = 1132
integer width = 160
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long backcolor = 79416533
boolean enabled = false
string text = "Hasta"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_fa_man_actualiza_inventario
integer x = 1198
integer y = 1284
integer width = 699
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Descartar Transacciones"
end type

event clicked;integer li_reg_check, li_filas
long    ll_update, i, li_anio
string  ls_error, ls_no_pedido, ls_tipo_fac

dw_1.AcceptText()

if gf_mensaje("","¿ Está Seguro que Desea DESCARTAR las Transacciones Seleccionadas ?",2,1,"E") = 2 then return

sqlca.autocommit = false

	For li_filas = 1 to dw_1.Rowcount()
		If dw_1.GetItemNumber(li_filas,"fatdiari_fact_act_inventario") = 1 Then
			li_reg_check ++ 
			exit //para que salga del ciclo
  		End If
	Next	

If li_reg_check > 0 Then
	ll_update = dw.update()
	If ll_update = 1 Then
		if dw.dataobject = 'dw_man_fa_act_inv_encabezado' then //Solo para los registros de inventario
			dw.setfilter('fatdiari_fact_act_inventario = 1')
			dw.filter()
			
			for i = 1 to dw.rowcount()

				 ls_no_pedido = dw.getitemstring(i,'fact_no_pedido')
				 ls_tipo_fac  = dw.getitemstring(i,'fact_tipo')
				 li_anio		  = dw.getitemnumber(i,'fact_ann')
				 
				 DECLARE proc_libera PROCEDURE FOR sp_libera_factura_reservada
					@p_gf = :str.g_financiero,   
					@p_emp = :str.empresa,   
					@p_pedido = :ls_no_pedido,   
					@p_tipo	= :ls_tipo_fac,
					@p_ann = :li_anio  ;
				 
				 execute proc_libera ;
					if sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrtext
						rollback;
						mensaje("Aviso","Error al actualizar la Reserva en faddiari (Procedimiento)",ls_error)
						sqlca.autocommit = true
						dw.setfilter('')
						dw.filter()										
						return
					end if														
					
			next
			
			dw.setfilter('')
			dw.filter()			
		end if			
						
		Commit Using Sqlca;
		messagebox("Atención","¡Actualización Exitosa !")
		
		This.SetRedraw(False)
		dw_1.Retrieve(str.g_financiero,str.empresa)
		dw_3.reset()
		This.SetRedraw(True)
		
	Else
		messagebox("Atención Sr. Usuario","¡Error al Actualizar ! "+sqlca.sqlerrtext)
		Rollback Using Sqlca;			
	End If
		
Else
	mensaje("Atención Sr. Usuario:", "Seleccione el documento que desea actualizar...","") 	
End If

sqlca.autocommit = true
end event

type cb_imprimir from commandbutton within w_fa_man_actualiza_inventario
integer x = 2240
integer y = 1284
integer width = 471
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar Reporte"
end type

event clicked;Long		ll_filas,ll_row,ll_rows
Integer	li_anio,li_factura
string	ls_pedido,ls_tipo, ls_pedido_tipo[], ls_filtro

If dw_1.rowcount() = 0 then Return

ll_row =0
For ll_filas = 1 to dw_1.rowcount()

	If dw_1.GetItemNumber(ll_filas,"fatdiari_fact_act_inventario") =1 then
		ll_row ++
	end if
next

If ll_row > 0 then
	
	ls_filtro = "fatdiari_fact_act_inventario= 1"
	dw_1.SetFilter(ls_filtro)
	dw_1.Filter( )
	dw_3.Reset()
	
	li_factura = 0
	For li_factura = 1 to dw_1.rowcount()
		ls_pedido = dw_1.GetItemString(li_factura,"fact_no_pedido")
		ls_tipo  = dw_1.GetItemString(li_factura,"fact_tipo")
		li_anio  = dw_1.GetItemNumber(li_factura,"fact_ann")
		ls_pedido_tipo[li_factura] = ls_pedido+ls_tipo
	NEXT
	//Recupera los pedidos seleccionados
	dw_4.SetTransObject(SQLCA)
	dw_4.Retrieve(str.g_financiero,str.empresa,li_anio,ls_pedido_tipo)

	If dw_4.rowcount() <= 0 then
		mensaje("Atención","No hay data para este reporte.. seleccione las facturas a pasar","")
		return
	end if
	str_pedi.vienede = 'act_invent'	
	str_pedi.dwobject = dw_4
	str_pedi.datawindow = 'dw_fa_rep_actualiza_inventario'
	str.frame.SetRedraw ( false )
	OpenSheetWithParm(w_fa_rep_imp_factura_ref, str_pedi, str.frame,9,Layered!)
	str.frame.SetRedraw ( true )
else
	mensaje("Atención ","No hay ninguna factura seleccionada, selecciónela para proceder, dé click en el campo incluir a cada factura que desee incluir","")
end if
dw_1.SetFilter('')
dw_1.Filter( )

if not isvalid(m_fa_padre) then
	w_fa_man_actualiza_inventario.Changemenu(m_fa_principal)
	wf_botones()
end if

end event

type st_3 from statictext within w_fa_man_actualiza_inventario
integer x = 2231
integer y = 1276
integer width = 485
integer height = 108
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_4 from datawindow within w_fa_man_actualiza_inventario
boolean visible = false
integer x = 114
integer y = 1412
integer width = 2473
integer height = 252
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_fa_rep_actualiza_inventario"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

