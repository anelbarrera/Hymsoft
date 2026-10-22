//  SELECT fatprofo.prof_g_financiero,   
//         fatprofo.prof_empresa,   
//         fatprofo.prof_tipo,   
//         fatprofo.prof_no_proforma,   
//         fatprofo.prof_ann,   
//         fatprofo.prof_cliente,   
//         fatprofo.prof_ruc_cliente,   
//         fatprofo.prof_condicion_pago,   
//         fatprofo.prof_tipo_venta,   
//         fatprofo.prof_tipo_movimiento,   
//         fatprofo.prof_no_traspaso,   
//         fatprofo.prof_fecha,   
//         fatprofo.prof_fecha_creacion,   
//         fatprofo.prof_fecha_modificacion,   
//         fatprofo.prof_dias_pago,   
//         fatprofo.prof_consignado,   
//         fatprofo.prof_a_nombre,   
//         fatprofo.prof_a_nombre_direccion,   
//         fatprofo.prof_despachado,   
//         fatprofo.prof_via,   
//         fatprofo.prof_con_emb_no,   
//         fatprofo.prof_marca,   
//         fatprofo.prof_bultos_total,   
//         fatprofo.prof_cubicaje_total,   
//         fatprofo.prof_peso_total,   
//         fatprofo.prof_unidad_peso,   
//         fatprofo.prof_gastos_total,   
//         fatprofo.prof_monto_total,   
//         fatprofo.prof_descu_subt_deta,   
//         fatprofo.prof_por_descuento,   
//         fatprofo.prof_supervisor,   
//         fatprofo.prof_monto_final,   
//         fatprofo.prof_comentario,   
//         fatprofo.prof_estado,   
//         fatprofo.prof_documento,   
//         fatprofo.prof_actualizo_cargos,   
//         fatprofo.prof_actualizo_vendedor,   
//         fatprofo.prof_factura_de_bodega,   
//         fatprofo.prof_fecha_fin_plazo,   
//         fatprofo.prof_autorizacion,   
//         fatprofo.prof_cuatro_decimales,   
//         fatprofo.prof_precio_a_utilizar,   
//         fatprofo.prof_costos_total,   
//         fatprofo.prof_usuario,   
//         fatprofo.prof_restaurado_por,   
//         fatprofo.prof_linea_aerea,   
//         fatprofo.prof_pasaporte,   
//         fatprofo.prof_fecha_restaurada,   
//         fatprofo.prof_afecta_sugerido,   
//         fatprofo.prof_pdt,   
//         fatprofo.prof_paga_itbm  
//    FROM fatprofo  
//   WHERE fatprofo.prof_fecha < '10/01/2024'   ;
//

  SELECT fatprofo.prof_g_financiero,   
         fatprofo.prof_empresa,   
         fatprofo.prof_tipo,   
         fatprofo.prof_no_proforma,   
         fatprofo.prof_ann,   
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
         fatprofo.prof_estado,   
         fatprofo.prof_documento,   
         fatprofo.prof_actualizo_cargos,   
         fatprofo.prof_actualizo_vendedor,   
         fatprofo.prof_factura_de_bodega,   
         fatprofo.prof_fecha_fin_plazo,   
         fatprofo.prof_autorizacion,   
         fatprofo.prof_cuatro_decimales,   
         fatprofo.prof_precio_a_utilizar,   
         fatprofo.prof_costos_total,   
         fatprofo.prof_usuario,   
         fatprofo.prof_restaurado_por,   
         '',   
         null,   
         null,   
         0,   
         1,   
         0  
    FROM fatprofo  
   WHERE fatprofo.prof_fecha < '10/01/2024'   ;


//Vendedores
  SELECT fadvenpr.vpro_g_financiero,   
         case when fadvenpr.vpro_empresa = 3 then 10 else vpro_empresa end empresa,   
         fadvenpr.vpro_tipo,   
         fadvenpr.vpro_no_proforma,   
         fadvenpr.vpro_ann,   
         fadvenpr.vpro_vendedor  
    FROM fadvenpr,   
         fatprofo  
   WHERE ( fatprofo.prof_g_financiero = fadvenpr.vpro_g_financiero ) and  
         ( fatprofo.prof_empresa = fadvenpr.vpro_empresa ) and  
         ( fatprofo.prof_no_proforma = fadvenpr.vpro_no_proforma ) and  
         ( fatprofo.prof_ann = fadvenpr.vpro_ann ) and  
         ( ( fatprofo.prof_fecha < '10/01/2024' ) )   ;



//Cargos
  SELECT fadproca.prca_g_financiero,   
         case when fadproca.prca_empresa = 3 then 10 else prca_empresa end empresa,   
         fadproca.prca_ann,   
         fadproca.prca_no_proforma,   
         fadproca.prca_codigo_cargo,   
         fadproca.prca_monto  
    FROM fadproca,   
         fatprofo  
   WHERE ( fatprofo.prof_g_financiero = fadproca.prca_g_financiero ) and  
         ( fatprofo.prof_empresa = fadproca.prca_empresa ) and  
         ( fatprofo.prof_no_proforma = fadproca.prca_no_proforma ) and  
         ( fatprofo.prof_ann = fadproca.prca_ann ) and  
         ( ( fatprofo.prof_fecha < '10/01/2024' ) )   ;
