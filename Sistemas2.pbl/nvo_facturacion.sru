//objectcomments Objeto que tiene las Funciones del Sistema de Facturación
forward
global type nvo_facturacion from nonvisualobject
end type
end forward

global type nvo_facturacion from nonvisualobject
event ue_cantidad ( )
end type
global nvo_facturacion nvo_facturacion

type variables

end variables

forward prototypes
public subroutine pr_prod_data (readonly string ls_bodega, string ls_producto)
public function string precio_ante (readonly string ls_item, readonly string ls_ruc)
end prototypes

public subroutine pr_prod_data (readonly string ls_bodega, string ls_producto);  // Carga Datos Iniciales para Una Linea de Detalle que sea Producto 17/04/1998

  SELECT inmprodu.prod_producto, 
         inmprodu.prod_descripcion,   
         inmprodu.prod_descripcion_dos,   
         inmprodu.prod_costo_unitario,   
         inmprodu.prod_medida,   
         inmprodu.prod_cubicaje,   
         inmprodu.prod_peso,   
         inmprodu.prod_peso_unidad_medida,
         inmprodu.prod_precio_mayor,   
         inmprodu.prod_precio_menor,   
         inmprodu.prod_precio_afiliadas,   
         inmprodu.prod_precio_otros,   
         inmprodu.prod_precio_especial,   
         inmprodu.prod_costo_fob,   
         inmprodu.prod_costo_cif,   
         inmprodu.prod_comision,   
         inmprodu.prod_descuento_maximo,   
         inmprodu.prod_existencia_total,   
         inmprodu.prod_reserva_total,
			inmprodu.prod_empaque,
			inmprodu.prod_empaque_um,
			inmprodu.prod_descuento_siono,
			inmprodu.prod_descuento_maximo,
			inmprodu.prod_pais			
    INTO :w_fa_fondo.strp.Item,
	      :w_fa_fondo.strp.descrip,
         :w_fa_fondo.strp.descripd,   
         :w_fa_fondo.strp.costo,   
         :w_fa_fondo.strp.unidad,   
         :w_fa_fondo.strp.cubicaje,   
         :w_fa_fondo.strp.peso,   
         :w_fa_fondo.strp.unidadp,   
         :w_fa_fondo.strp.p_ma,   
         :w_fa_fondo.strp.p_me,   
         :w_fa_fondo.strp.p_af,   
         :w_fa_fondo.strp.p_ot,   
         :w_fa_fondo.strp.p_es,   
         :w_fa_fondo.strp.fob,   
         :w_fa_fondo.strp.cif,   
         :w_fa_fondo.strp.comision,   
         :w_fa_fondo.strp.desc_max,   
         :w_fa_fondo.strp.existencia,   
         :w_fa_fondo.strp.reserbado,
			:w_fa_fondo.strp.empaque,
			:w_fa_fondo.strp.emp_um,
			:w_fa_fondo.strp.desc_siono,
			:w_fa_fondo.strp.desc_maximo,
			:w_fa_fondo.strp.pais
   FROM inmprodu  
   WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
         ( inmprodu.prod_empresa = :str.empresa ) AND  
         ( inmprodu.prod_producto = :ls_producto )  ;
			
	if sqlca.sqlcode < 0 then 
		gf_mensaje("",sqlca.sqlerrtext,1,1,"E")
	end if
end subroutine

public function string precio_ante (readonly string ls_item, readonly string ls_ruc);// Busca el Ultimo Precio Pagado por un Item en una Factura para un cliente
 
 Double ld_precio, ld_mconver
 String ls_unidad
 long ll_conver

DataStore lds_ultimo 										//Crea una variable tipo Datastore
lds_ultimo = create datastore //ds_dg_creacion_series								//Crea el DataStore
lds_ultimo.dataobject = "dw_pr_fa_ult_precio"		//Asignacion del datawindow
lds_ultimo.SetTransObject(SQLCA)						   //Se le setea el objeto transaccion
  
lds_ultimo.retrieve(str.g_financiero,str.empresa,ls_ruc,ls_item)  
if lds_ultimo.rowcount() = 0 then
	ld_precio = 0
else
	ld_precio = lds_ultimo.getitemnumber(1,"facd_precio")  
//	messagebox("Precio",ld_precio)
	ls_unidad = lds_ultimo.getitemstring(1,"facd_unidad")
//	messagebox("Unidad",ls_unidad)
   ll_conver  = gf_medi_prod(ls_unidad)		
   ld_mconver = gf_unidad_prod(ls_unidad, ll_conver)	
	
//	messagebox("Medida de Conversion",ld_mconver)
	
	if ld_mconver = 0 then
		gf_mensaje("","Verifique las Unidades del Producto",1,1,"E")
		ld_mconver = 1
	end if
	
	ld_precio  = round(ld_precio / ld_mconver,2)
//	messagebox("Ultimo Precio", ld_precio)
end if

//  SELECT faddiari.facd_precio_unidad_producto  
//    INTO :ld_precio  
//    FROM faddiari,   
//         fatdiari  
//   WHERE ( fatdiari.fact_g_financiero = faddiari.facd_g_financiero ) and  
//         ( fatdiari.fact_empresa = faddiari.facd_empresa ) and  
//         ( fatdiari.fact_por_mayor = faddiari.facd_por_mayor ) and  
//         ( fatdiari.fact_no_pedido = faddiari.facd_no_pedido ) and  
//         ( ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
//         ( faddiari.facd_empresa = :str.empresa ) AND  
//         ( faddiari.facd_codigo_item = :ls_item ) AND  
//         ( fatdiari.fact_ruc_cliente = :ls_ruc ) )   ;

If isnull(ld_precio) Then ld_precio = 0

Return(string(ld_precio)+"*"+ls_unidad)
end function

on nvo_facturacion.create
TriggerEvent( this, "constructor" )
end on

on nvo_facturacion.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;// Objeto del Sistema de facturación

end event

