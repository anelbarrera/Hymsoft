using System;
using PowerServer.Core;

namespace Hymsoft_cloud
{
    public class Hymsoft_Cloud_Select
    {	
		public static string sqlHandle_01_7BBFC837 = "SELECT max ( isnull ( convert ( numeric ( 10 , 0 ) , clientes.codigo_cliente ) , 0 ) ) FROM clientes WHERE ( clientes.grupo =? ) AND ( clientes.empresa =? ) ";
		
		public static string sqlHandle_01_7048D1C2 = "SELECT count ( * ) FROM colores WHERE ( colores.empresa =? ) ";
		
		public static string sqlHandle_01_E831F449 = "SELECT count ( * ) FROM usuarios WHERE ( usuarios.usua_id =? ) AND ( usuarios.usua_clave =? ) AND ( usuarios.usua_estado ='A' ) ";
		
		public static string sqlHandle_01_C4155487 = "select isnull ( empr_valida_contabilidad , 1 ) , isnull ( empr_nd_por_subtransaccion , 1 ) , convert ( varchar ( 15 ) , isnull ( dgmempre.empr_ficha , 0 ) ) + '-' + convert ( varchar ( 4 ) , isnull ( dgmempre.empr_rollo , 0 ) ) + '-' + convert ( varchar ( 10 ) , isnull ( dgmempre.empr_imagen , 0 ) ) , isnull ( empr_dijito_verificador , '' ) , isnull ( empr_contabiliza , 1 ) , isnull ( empr_acceso_especial , '' ) , isnull ( empr_valor_itbm , 0.07 ) , isnull ( empr_imprime_fiscal , 0 ) , empr_numero_registro , isnull ( empr_cuenta_cxc_default , '' ) , isnull ( empr_cuenta_cxp_default , '' ) , isnull ( empr_genera_asiento_entrada , 0 ) , isnull ( empr_maneja_lotes , 0 ) , isnull ( empr_ruta_fotos , '' ) from dgmempre where empr_g_financiero =? and empr_empresa =? ";
		
		public static string sqlHandle_01_837B2FD3 = "SELECT count ( * ) FROM faaforma WHERE ( faaforma.forma_tipo_formato =? ) AND ( faaforma.forma_formato =? ) ";
		
		public static string sqlHandle_01_6FE5B9EB = "SELECT faaforma.forma_datawindow FROM faaforma WHERE ( faaforma.forma_tipo_formato =? ) AND ( faaforma.forma_formato =? ) ";
		
		public static string sqlHandle_01_802238DA = "SELECT faaforma.forma_datawindow FROM faaforma WHERE ( faaforma.forma_tipo_formato =? ) AND ( faaforma.forma_formato =? ) Order by forma_cod_fomato ";
		
		public static string sqlHandle_01_96042225 = "SELECT count ( * ) FROM dgmempre WHERE ( dgmempre.empr_g_financiero =? ) AND ( dgmempre.empr_empresa =? ) ";
		
		public static string sqlHandle_01_1F7FE9A7 = "SELECT dgmempre.empr_razon_social , empr_acceso_especial , empr_valor_fixing FROM dgmempre WHERE ( dgmempre.empr_g_financiero =? ) AND ( dgmempre.empr_empresa =? ) ";
		
		public static string sqlHandle_01_79A5495A = "SELECT isnull ( dgmempre.empr_ruta_de_manual , '' ) FROM dgmempre WHERE ( dgmempre.empr_g_financiero =? ) AND ( dgmempre.empr_empresa =? ) ";
		
		public static string sqlHandle_01_CB19552C = "SELECT inmprodu.prod_producto FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) order by prod_producto ";
		
		public static string sqlHandle_01_1F55B91D = "SELECT comparam.para_ann_actual , comparam.para_mes_actual FROM comparam WHERE ( comparam.para_g_financiero =? ) AND ( comparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_A76BDA8C = "SELECT ssmusuar.usua_autoriza_modificaciones FROM ssmusuar WHERE ( ssmusuar.usua_id =? ) AND ( ssmusuar.usua_clave =? ) AND ( ssmusuar.usua_estado ='A' ) ";
		
		public static string sqlHandle_01_5F776BE2 = "SELECT Isnull ( inaparam.para_titulo_kardex , '' ) FROM inaparam WHERE ( inaparam.para_g_financiero =? ) AND ( inaparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_5A0AAB13 = "SELECT isnull ( faaparam.fara_titulo_reservado , '' ) , isnull ( faaparam.fara_titulo_entradas , '' ) , isnull ( faaparam.fara_titulo_estado , '' ) , isnull ( faaparam.fara_titulo_factura , '' ) FROM faaparam WHERE ( faaparam.fara_g_financiero =? ) AND ( faaparam.fara_empresa =? ) ";
		
		public static string sqlHandle_01_20B141E8 = "select claco_clave from inaclaco where claco_g_financiero =? and claco_empresa =? and claco_codigo =? ";
		
		public static string sqlHandle_01_B673786D = "SELECT ssmgrupusemp.grue_grupo , ssmusuar.usua_nombre , ssmusuar.usua_apellido , ssmusuar.usua_clave FROM ssmgrupusemp , ssmusuar WHERE ( ssmusuar.usua_id =ssmgrupusemp.grue_usuario ) AND ( ( ssmgrupusemp.grue_g_financiero =? ) AND ( ssmgrupusemp.grue_aplicacion =? ) AND ( ssmgrupusemp.grue_empresa =? ) AND ( ssmusuar.usua_id =? ) AND ( ssmgrupusemp.grue_estado ='A' ) AND ( ssmusuar.usua_estado ='A' ) ) ";
		
		public static string sqlHandle_01_84F29E8 = "select max ( convert ( numeric ( 10 ) , pedi_no_pedido ) ) from pedidos where pedi_g_financiero =? and pedi_empresa =? and pedi_ann =? ";
		
		public static string sqlHandle_01_15FAB90A = "SELECT productos.prod_descripcion , productos.prod_empaque , productos.prod_unidad , unidades_a.medi_cantidad , unidades_b.medi_cantidad , productos.prod_peso , productos.prod_cubicaje , productos.prod_precio FROM productos , unidades unidades_a , unidades unidades_b WHERE ( unidades_a.medi_unidad =productos.prod_unidad ) and ( productos.prod_unidad_empaque =unidades_b.medi_unidad ) and ( ( productos.prod_g_financiero =? ) AND ( productos.prod_empresa =? ) AND ( productos.prod_producto =? ) ) ";
		
		public static string sqlHandle_01_B63C713D = "SELECT productos.prod_descripcion , productos.prod_unidad FROM productos WHERE ( productos.prod_g_financiero =? ) AND ( productos.prod_empresa =? ) AND ( productos.prod_producto =? ) ";
		
		public static string sqlHandle_01_DE2FB9A = "SELECT sum ( orden_detalle.deta_cantidad ) FROM orden_detalle WHERE ( orden_detalle.deta_g_financiero =? ) AND ( orden_detalle.deta_empresa =? ) AND ( orden_detalle.deta_referencia =? ) ";
		
		public static string sqlHandle_01_9C581F6 = "SELECT sum ( dped_cantidad ) FROM pedidos_detalle WHERE ( pedidos_detalle.dped_g_financiero =? ) AND ( pedidos_detalle.dped_empresa =? ) AND ( pedidos_detalle.dped_producto =? ) ";
		
		public static string sqlHandle_01_6759EB27 = "SELECT empr_bodegas_definidas , isnull ( empr_bodega1 , '' ) , isnull ( empr_bodega2 , '' ) , isnull ( empr_bodega3 , '' ) , isnull ( empr_bodega4 , '' ) , isnull ( empr_bodega5 , '' ) , isnull ( empr_bodega6 , '' ) , isnull ( empr_bodega7 , '' ) FROM dgmempre WHERE ( dgmempre.empr_g_financiero =? ) AND ( dgmempre.empr_empresa =? ) ";
		
		public static string sqlHandle_01_E2082ECB = "select count ( * ) from indmovim where dmov_g_financiero =? and dmov_empresa =? and dmov_producto =? ";
		
		public static string sqlHandle_01_D8CDC272 = "select max ( terc_tercero ) from dgmterce ";
		
		public static string sqlHandle_01_96DD710C = "SELECT count ( * ) FROM cpmprove WHERE ( cpmprove.prov_g_financiero =? ) AND ( cpmprove.prov_empresa =? ) AND ( cpmprove.prov_tercero =? ) ";
		
		public static string sqlHandle_01_D3D716F5 = "SELECT isnull ( max ( cuen_id ) , 0 ) FROM bamcuent WHERE ( bamcuent.cuen_g_financiero =? ) AND ( bamcuent.cuen_empresa =? ) AND ( bamcuent.cuen_banco =? ) ";
		
		public static string sqlHandle_01_A0CF763A = "SELECT count ( * ) FROM batdiari WHERE ( batdiari.btdi_g_financiero =? ) AND ( batdiari.btdi_empresa =? ) AND ( batdiari.btdi_banco =? ) AND ( batdiari.btdi_no_cuenta =? ) ";
		
		public static string sqlHandle_01_B7490FAC = "SELECT count ( * ) FROM cotdiari WHERE ( cotdiari.diar_g_financiero =? ) AND ( cotdiari.diar_empresa =? ) AND ( cotdiari.diar_cierre_mensual ='S' ) ";
		
		public static string sqlHandle_01_3EE3F730 = "SELECT colores.fondo_principal , colores.fondo_lateral , colores.fondo_cursor , colores.borde_cursor , colores.titulo_opciones , colores.letras_opciones , colores.letra_seleccion_principal , colores.titulo_opciones_lateral , colores.letras_opciones_lateral , colores.letra_seleccion_lateral FROM colores WHERE colores.empresa =? ";
		
		public static string sqlHandle_01_7EED19CC = "SELECT opciones.nivel , opciones.opcion , opciones.descripcion FROM opciones ";
		
		public static string sqlHandle_01_ADAD934D = "SELECT dgmempre.empr_razon_social , empr_acceso_especial , empr_valor_fixing , isnull ( empr_clave_estados_de_cuenta , '' ) , empr_bodegas_definidas , isnull ( empr_bodega1 , '' ) , isnull ( empr_bodega2 , '' ) , isnull ( empr_bodega3 , '' ) , isnull ( empr_bodega4 , '' ) , isnull ( empr_bodega5 , '' ) , isnull ( empr_bodega6 , '' ) , isnull ( empr_bodega7 , '' ) FROM dgmempre WHERE ( dgmempre.empr_g_financiero =? ) AND ( dgmempre.empr_empresa =? ) ";
		
		public static string sqlHandle_01_21297402 = "SELECT usuarios_accesos.priv_opcion11 , usuarios_accesos.priv_opcion12 , usuarios_accesos.priv_opcion13 , usuarios_accesos.priv_opcion14 , usuarios_accesos.priv_opcion15 , usuarios_accesos.priv_opcion16 , usuarios_accesos.priv_opcion17 , usuarios_accesos.priv_opcion18 , usuarios_accesos.priv_opcion19 , usuarios_accesos.priv_opcion110 , usuarios_accesos.priv_opcion111 , usuarios_accesos.priv_opcion21 , usuarios_accesos.priv_opcion22 , usuarios_accesos.priv_opcion23 , usuarios_accesos.priv_opcion24 , usuarios_accesos.priv_opcion25 , usuarios_accesos.priv_opcion26 , usuarios_accesos.priv_opcion27 , usuarios_accesos.priv_opcion28 , usuarios_accesos.priv_opcion29 , usuarios_accesos.priv_opcion210 , usuarios_accesos.priv_opcion31 , usuarios_accesos.priv_opcion32 , usuarios_accesos.priv_opcion33 , usuarios_accesos.priv_opcion34 , usuarios_accesos.priv_opcion35 , usuarios_accesos.priv_opcion36 , usuarios_accesos.priv_opcion37 , usuarios_accesos.priv_opcion38 , usuarios_accesos.priv_opcion39 , usuarios_accesos.priv_opcion310 , usuarios_accesos.priv_opcion311 , usuarios_accesos.priv_opcion312 , usuarios_accesos.priv_opcion313 , usuarios_accesos.priv_opcion314 , usuarios_accesos.priv_opcion315 , usuarios_accesos.priv_opcion41 , usuarios_accesos.priv_opcion42 , usuarios_accesos.priv_opcion43 , usuarios_accesos.priv_opcion44 , usuarios_accesos.priv_opcion45 , usuarios_accesos.priv_opcion46 , usuarios_accesos.priv_opcion47 , usuarios_accesos.priv_opcion48 , usuarios_accesos.priv_opcion49 , usuarios_accesos.priv_opcion410 , usuarios_accesos.priv_opcion411 , usuarios_accesos.priv_opcion412 , usuarios_accesos.priv_opcion413 , usuarios_accesos.priv_opcion414 , usuarios_accesos.priv_opcion415 , usuarios_accesos.priv_opcion416 , usuarios_accesos.priv_opcion417 , usuarios_accesos.priv_opcion418 , usuarios_accesos.priv_opcion419 , usuarios_accesos.priv_opcion420 , usuarios_accesos.priv_opcion51 , usuarios_accesos.priv_opcion52 , usuarios_accesos.priv_opcion53 , usuarios_accesos.priv_opcion54 , usuarios_accesos.priv_opcion55 , usuarios_accesos.priv_opcion56 , usuarios_accesos.priv_opcion57 , usuarios_accesos.priv_opcion58 , usuarios_accesos.priv_opcion59 , usuarios_accesos.priv_opcion510 , usuarios_accesos.priv_opcion511 , usuarios_accesos.priv_opcion512 , usuarios_accesos.priv_opcion513 , usuarios_accesos.priv_opcion514 , usuarios_accesos.priv_opcion515 , usuarios_accesos.priv_opcion516 , usuarios_accesos.priv_opcion517 , usuarios_accesos.priv_opcion518 , usuarios_accesos.priv_opcion519 , usuarios_accesos.priv_opcion520 , usuarios_accesos.priv_opcion61 , usuarios_accesos.priv_opcion62 , usuarios_accesos.priv_opcion63 , usuarios_accesos.priv_opcion64 , usuarios_accesos.priv_opcion65 , usuarios_accesos.priv_opcion66 , usuarios_accesos.priv_opcion67 , usuarios_accesos.priv_opcion68 , usuarios_accesos.priv_opcion69 , usuarios_accesos.priv_opcion610 , usuarios_accesos.priv_opcion611 , usuarios_accesos.priv_opcion612 , usuarios_accesos.priv_opcion613 , usuarios_accesos.priv_opcion614 , usuarios_accesos.priv_opcion615 , usuarios_accesos.priv_opcion71 , usuarios_accesos.priv_opcion211 , usuarios_accesos.priv_opcion212 , usuarios_accesos.priv_opcion213 FROM usuarios_accesos WHERE ( usuarios_accesos.priv_g_financiero =? ) AND ( usuarios_accesos.priv_empresa =? ) AND ( usuarios_accesos.priv_usuario =? ) ";
		
		public static string sqlHandle_01_F63EAA48 = "SELECT count ( * ) FROM faempbod WHERE ( faempbod.faem_g_financiero =? ) AND ( faempbod.faem_empresa =? ) AND ( faempbod.faem_bod_usuario =? ) AND ( faempbod.faem_clave =? ) AND ( faempbod.faem_autoriza_aprobacion ='S' ) ";
		
		public static string sqlHandle_01_DC20D865 = "SELECT count ( * ) FROM estados WHERE ( estados.empresa =? ) ";
		
		public static string sqlHandle_01_2C1AB62D = "SELECT inamedid.medi_cantidad FROM inamedid WHERE inamedid.medi_tipo_medida =? and inamedid.medi_medida =? ";
		
		public static string sqlHandle_01_27A2E0D0 = "SELECT count ( * ) FROM ccmclien , dgmterce WHERE ( ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) ) ";
		
		public static string sqlHandle_01_36F15F89 = "select count ( * ) from usuarios_accesos where priv_g_financiero =? and priv_empresa =? and priv_usuario =? ";
		
		public static string sqlHandle_01_2D258FFB = "SELECT isnull ( count ( * ) , 0 ) FROM usuarios WHERE usuarios.usua_id =? ";
		
		public static string sqlHandle_01_23348279 = "SELECT dgmempre.empr_g_financiero , dgmempre.empr_empresa , dgmempre.empr_razon_social FROM dgmempre WHERE dgmempre.empr_estado ='A' ";
		
		public static string sqlHandle_01_703EF260 = "SELECT empresas_usuario.emus_g_financiero , empresas_usuario.emus_empresa FROM empresas_usuario WHERE empresas_usuario.emus_usuario =? ";
		
		public static string sqlHandle_01_C2593C66 = "SELECT isnull ( cuen_monto_conciliacion , 0 ) FROM bamcuent WHERE ( cuen_g_financiero =? ) AND ( cuen_empresa =? ) AND ( cuen_banco =? ) AND ( cuen_no_cuenta =? ) ";
		
		public static string sqlHandle_01_79DEB5B8 = "SELECT bamcuent.cuen_fecha_conci FROM bamcuent WHERE ( bamcuent.cuen_g_financiero =? ) AND ( bamcuent.cuen_empresa =? ) AND ( bamcuent.cuen_banco =? ) AND ( bamcuent.cuen_no_cuenta =? ) ";
		
		public static string sqlHandle_01_EEC44C1A = "SELECT bamcuent.cuen_fecha_conci , bamcuent.cuen_monto_conciliacion FROM bamcuent WHERE ( bamcuent.cuen_g_financiero =? ) AND ( bamcuent.cuen_empresa =? ) AND ( bamcuent.cuen_no_cuenta =? ) AND ( bamcuent.cuen_banco =? ) ";
		
		public static string sqlHandle_01_C3770AE5 = "SELECT batdiari.btdi_fecha_tran , batdiari.btdi_monto FROM batdiari WHERE ( batdiari.btdi_g_financiero =? ) AND ( batdiari.btdi_empresa =? ) AND ( batdiari.btdi_tipo_transaccion ='SI' ) AND ( batdiari.btdi_sub_transaccion ='SI' ) AND ( batdiari.btdi_banco =? ) AND ( batdiari.btdi_no_cuenta =? ) ";
		
		public static string sqlHandle_01_1CBCF4A5 = "SELECT isnull ( sum ( case btdi_naturaleza when 'D' then batdiari.btdi_monto else - batdiari.btdi_monto end ) , 0 ) FROM batdiari WHERE ( batdiari.btdi_g_financiero =? ) AND ( batdiari.btdi_empresa =? ) AND ( batdiari.btdi_banco =? ) AND ( batdiari.btdi_no_cuenta =? ) AND ( batdiari.btdi_fecha_tran > ? ) and ( batdiari.btdi_fecha_tran < ? ) AND ( batdiari.btdi_tipo_transaccion <> 'SI' ) AND ( batdiari.btdi_estado <> 'X' ) ";
		
		public static string sqlHandle_01_D9D6AD40 = "SELECT isnull ( sum ( case btdi_naturaleza when 'D' then batdiari.btdi_monto else - batdiari.btdi_monto end ) , 0 ) FROM batdiari WHERE ( batdiari.btdi_g_financiero =? ) AND ( batdiari.btdi_empresa =? ) AND ( batdiari.btdi_banco =? ) AND ( batdiari.btdi_no_cuenta =? ) AND ( batdiari.btdi_fecha_tran > ? ) AND ( batdiari.btdi_fecha_tran < ? ) AND ( batdiari.btdi_tipo_transaccion <> 'SI' ) AND ( batdiari.btdi_estado <> 'X' ) ";
		
		public static string sqlHandle_01_58E8EF9A = "SELECT isnull ( sum ( batdiari.btdi_monto ) , 0 ) FROM batdiari WHERE ( batdiari.btdi_g_financiero =? ) AND ( batdiari.btdi_empresa =? ) AND ( batdiari.btdi_banco =? ) AND ( batdiari.btdi_no_cuenta =? ) AND ( batdiari.btdi_fecha_habilita_deposito >= ? ) AND ( batdiari.btdi_fecha_habilita_deposito <= ? ) AND ( batdiari.btdi_tipo_transaccion in ( 'DE' , 'SD' ) ) AND ( batdiari.btdi_estado <> 'X' ) ";
		
		public static string sqlHandle_01_258ED29C = "SELECT isnull ( sum ( case btdi_naturaleza when 'D' then batdiari.btdi_monto else - batdiari.btdi_monto end ) , 0 ) FROM batdiari WHERE ( batdiari.btdi_g_financiero =? ) AND ( batdiari.btdi_empresa =? ) AND ( batdiari.btdi_banco =? ) AND ( batdiari.btdi_no_cuenta =? ) AND ( batdiari.btdi_fecha_tran >= ? ) AND ( batdiari.btdi_fecha_tran <= ? ) AND ( batdiari.btdi_tipo_transaccion not in ( 'DE' , 'SD' ) ) AND ( batdiari.btdi_estado <> 'X' ) ";
		
		public static string sqlHandle_01_ECF21173 = "SELECT isnull ( sum ( batdiari.btdi_monto ) , 0 ) FROM batdiari WHERE ( batdiari.btdi_g_financiero =? ) AND ( batdiari.btdi_empresa =? ) AND ( batdiari.btdi_banco =? ) AND ( batdiari.btdi_no_cuenta =? ) AND ( batdiari.btdi_fecha_habilita_deposito >= ? ) AND ( batdiari.btdi_fecha_habilita_deposito <= Dateadd ( dd , 3 , ? ) ) AND ( batdiari.btdi_tipo_transaccion in ( 'DE' , 'SD' ) ) AND ( batdiari.btdi_estado <> 'X' ) ";
		
		public static string sqlHandle_01_92FA4D47 = "SELECT isnull ( sum ( case btdi_naturaleza when 'D' then batdiari.btdi_monto else - batdiari.btdi_monto end ) , 0 ) FROM batdiari WHERE ( batdiari.btdi_g_financiero =? ) AND ( batdiari.btdi_empresa =? ) AND ( batdiari.btdi_banco =? ) AND ( batdiari.btdi_no_cuenta =? ) AND ( batdiari.btdi_fecha_tran >= ? ) AND ( batdiari.btdi_fecha_habilita_deposito <= Dateadd ( dd , 3 , ? ) ) AND ( batdiari.btdi_tipo_transaccion not in ( 'DE' , 'SD' ) ) AND ( batdiari.btdi_estado <> 'X' ) ";
		
		public static string sqlHandle_01_D36A2F3 = "SELECT isnull ( batdiari.btdi_fecha_tran , '01/01/1900' ) , isnull ( batdiari.btdi_monto , 0 ) FROM batdiari WHERE ( batdiari.btdi_g_financiero =? ) AND ( batdiari.btdi_empresa =? ) AND ( batdiari.btdi_tipo_transaccion ='SI' ) AND ( batdiari.btdi_sub_transaccion ='SI' ) AND ( batdiari.btdi_banco =? ) AND ( batdiari.btdi_no_cuenta =? ) ";
		
		public static string sqlHandle_01_8DBDCEDB = "SELECT isnull ( sum ( case btdi_naturaleza when 'D' then batdiari.btdi_monto else - batdiari.btdi_monto end ) , 0 ) FROM batdiari WHERE ( batdiari.btdi_g_financiero =? ) AND ( batdiari.btdi_empresa =? ) AND ( batdiari.btdi_banco =? ) AND ( batdiari.btdi_no_cuenta =? ) AND ( batdiari.btdi_fecha_tran < ? ) AND ( batdiari.btdi_fecha_tran > ? ) AND ( batdiari.btdi_tipo_transaccion <> 'SI' ) AND ( batdiari.btdi_estado <> 'X' ) ";
		
		public static string sqlHandle_01_CEC61F92 = "SELECT sum ( batdiari.btdi_monto ) FROM batdiari WHERE ( batdiari.btdi_g_financiero =? ) AND ( batdiari.btdi_empresa =? ) AND ( batdiari.btdi_banco =? ) AND ( batdiari.btdi_no_cuenta =? ) AND ( batdiari.btdi_fecha_tran >= ? ) AND ( batdiari.btdi_fecha_tran <= ? ) AND ( batdiari.btdi_tipo_transaccion in ( 'DE' , 'SD' ) ) ";
		
		public static string sqlHandle_01_4B3A4BD4 = "SELECT sum ( batdiari.btdi_monto ) FROM batdiari WHERE ( batdiari.btdi_g_financiero =? ) AND ( batdiari.btdi_empresa =? ) AND ( batdiari.btdi_banco =? ) AND ( batdiari.btdi_no_cuenta =? ) AND ( batdiari.btdi_fecha_tran >= ? ) AND ( batdiari.btdi_fecha_tran <= ? ) AND ( batdiari.btdi_tipo_transaccion ='CH' ) ";
		
		public static string sqlHandle_01_71E8216C = "SELECT sum ( batdiari.btdi_monto ) FROM batdiari WHERE ( batdiari.btdi_g_financiero =? ) AND ( batdiari.btdi_empresa =? ) AND ( batdiari.btdi_banco =? ) AND ( batdiari.btdi_no_cuenta =? ) AND ( batdiari.btdi_fecha_tran >= ? ) AND ( batdiari.btdi_fecha_tran <= ? ) AND ( batdiari.btdi_naturaleza ='C' ) AND ( batdiari.btdi_tipo_transaccion not in ( 'CH' , 'DE' , 'SD' ) ) ";
		
		public static string sqlHandle_01_F6A618EB = "SELECT sum ( batdiari.btdi_monto ) FROM batdiari WHERE ( batdiari.btdi_g_financiero =? ) AND ( batdiari.btdi_empresa =? ) AND ( batdiari.btdi_banco =? ) AND ( batdiari.btdi_no_cuenta =? ) AND ( batdiari.btdi_fecha_tran >= ? ) AND ( batdiari.btdi_fecha_tran <= ? ) AND ( batdiari.btdi_naturaleza ='D' ) AND ( batdiari.btdi_tipo_transaccion not in ( 'CH' , 'DE' , 'SD' ) ) ";
		
		public static string sqlHandle_01_540E02D8 = "SELECT max ( btdi_historico ) FROM batdiari WHERE ( batdiari.btdi_g_financiero =? ) AND ( batdiari.btdi_empresa =? ) AND ( batdiari.btdi_tipo_transaccion =? ) AND ( batdiari.btdi_sub_transaccion =? ) AND ( batdiari.btdi_banco =? ) AND ( batdiari.btdi_no_cuenta =? ) AND ( batdiari.btdi_documento =? ) AND ( batdiari.btdi_referencia =? ) AND ( batdiari.btdi_ann =? ) ";
		
		public static string sqlHandle_01_CF19650 = "SELECT isnull ( ntransito.tran_transito , '' ) FROM ntransito WHERE ( ntransito.tran_g_financiero =? ) AND ( ntransito.tran_empresa =? ) AND ( ntransito.tran_transito like ? ) and ( ntransito.tran_estado <> 'C' ) ";
		
		public static string sqlHandle_01_4B5C9857 = "SELECT dgmserie.mser_movimiento FROM dgmserie WHERE ( dgmserie.mser_g_financiero =? ) AND ( dgmserie.mser_empresa =? ) AND ( dgmserie.mser_tipo_transaccion =? ) ";
		
		public static string sqlHandle_01_BCC7F5CA = "SELECT ncargos.carg_descripcion FROM ncargos WHERE ncargos.carg_cargo =? ";
		
		public static string sqlHandle_01_69720AD2 = "SELECT count ( * ) FROM banatpagar WHERE ( banatpagar.tpaga_g_financiero =? ) AND ( banatpagar.tpaga_empresa =? ) AND ( banatpagar.tpaga_transito =? ) AND ( banatpagar.tpaga_documento =? ) AND ( banatpagar.tpaga_agno =? ) AND ( banatpagar.tpaga_aplicacion =? ) AND ( banatpagar.tpaga_transaccion =? ) AND ( banatpagar.tpaga_subtransaccion =? ) ";
		
		public static string sqlHandle_01_1A2B9EF6 = "select isnull ( max ( cuen_secuencia_dep ) , 0 ) from bamcuent where cuen_g_financiero =? and cuen_empresa =? and cuen_banco =? and cuen_no_cuenta =? ";
		
		public static string sqlHandle_01_44CA38FC = "select isnull ( max ( cuen_secuencia ) , 0 ) from bamcuent where cuen_g_financiero =? and cuen_empresa =? and cuen_banco =? and cuen_no_cuenta =? ";
		
		public static string sqlHandle_01_CA8297E2 = "select count ( * ) from batdiari where btdi_g_financiero =? and btdi_empresa =? and btdi_tipo_transaccion =? and btdi_banco =? and btdi_no_cuenta =? and btdi_documento =? and btdi_ann =? ";
		
		public static string sqlHandle_01_1FD2D9F5 = "SELECT dgmterce.terc_identificacion , dgmterce.terc_descripcion , dgmterce.terc_digito_verificador FROM dgmterce WHERE dgmterce.terc_tercero =? ";
		
		public static string sqlHandle_01_891FC98A = "SELECT count ( * ) FROM cptmovim WHERE ( cptmovim.movi_g_financiero =? ) AND ( cptmovim.movi_empresa =? ) AND ( cptmovim.movi_aplicacion ='BA' ) AND ( cptmovim.movi_tipo_transaccion =? ) AND ( cptmovim.movi_sub_transaccion =? ) AND ( cptmovim.movi_documento =? ) AND ( cptmovim.movi_anno =? ) AND ( cptmovim.movi_referencia =? ) ";
		
		public static string sqlHandle_01_9BB1DAAE = "SELECT count ( * ) FROM cctmovim WHERE ( cctmovim.movi_g_financiero =? ) AND ( cctmovim.movi_empresa =? ) AND ( cctmovim.movi_aplicacion ='BA' ) AND ( cctmovim.movi_tipo_transaccion =? ) AND ( cctmovim.movi_sub_transaccion =? ) AND ( cctmovim.movi_documento =? ) AND ( cctmovim.movi_anno =? ) AND ( cctmovim.movi_referencia =? ) ";
		
		public static string sqlHandle_01_E5BB332A = "SELECT cpdrefac.refa_aplicacion_ori , cpdrefac.refa_tipo_transaccion_ori , cpdrefac.refa_sub_transaccion_ori , cpdrefac.refa_documento_ori , cpdrefac.refa_referencia_ori , cpdrefac.refa_ann_ori , cpdrefac.refa_monto_pagado , cpdrefac.refa_tercero FROM cpdrefac WHERE ( cpdrefac.refa_g_financiero =? ) AND ( cpdrefac.refa_empresa =? ) AND ( cpdrefac.refa_tipo_transaccion =? ) AND ( cpdrefac.refa_sub_transaccion =? ) AND ( cpdrefac.refa_documento =? ) AND ( cpdrefac.refa_referencia =? ) AND ( cpdrefac.refa_ann =? ) ";
		
		public static string sqlHandle_01_5918C665 = "SELECT count ( * ) FROM cotdiari WHERE ( cotdiari.diar_g_financiero =? ) AND ( cotdiari.diar_empresa =? ) AND ( cotdiari.diar_aplicacion_mg ='BA' ) AND ( cotdiari.diar_tipo_transaccion =? ) AND ( cotdiari.diar_sub_trans =? ) AND ( cotdiari.diar_no_documento =? ) AND ( cotdiari.diar_no_referencia =? ) AND ( cotdiari.diar_banco_cuenta =? ) AND ( cotdiari.diar_ann =? ) ";
		
		public static string sqlHandle_01_DD9BD26D = "SELECT isnull ( dgmempre.empr_imprimir_al_grabar , 0 ) FROM dgmempre WHERE ( dgmempre.empr_g_financiero =? ) AND ( dgmempre.empr_empresa =? ) ";
		
		public static string sqlHandle_01_17DB5ACE = "SELECT isnull ( max ( dgmterce.terc_tercero ) , 0 ) , isnull ( max ( dgmterce.terc_identificacion ) , '' ) , isnull ( max ( dgmterce.terc_digito_verificador ) , '' ) FROM dgmterce WHERE dgmterce.terc_descripcion =? ";
		
		public static string sqlHandle_01_5B29CED1 = "select max ( terc_tercero ) from dgmterce where terc_tercero <> 99999 ";
		
		public static string sqlHandle_01_3A098DB5 = "SELECT bamcuent.cuen_mg_cuenta , bamcuent.cuen_id FROM bamcuent WHERE ( bamcuent.cuen_g_financiero =? ) AND ( bamcuent.cuen_empresa =? ) AND ( bamcuent.cuen_banco =? ) AND ( bamcuent.cuen_no_cuenta =? ) ";
		
		public static string sqlHandle_01_BAD6A7F3 = "select count ( * ) from batdiari where btdi_g_financiero =? and btdi_empresa =? and btdi_tipo_transaccion =? and btdi_sub_transaccion =? and btdi_banco =? and btdi_no_cuenta =? and btdi_documento =? and btdi_referencia =? and btdi_ann =? ";
		
		public static string sqlHandle_01_C131BFD3 = "SELECT count ( * ) , max ( prov_mg_cuenta ) , max ( prov_cod_proveedor ) FROM cpmprove WHERE ( cpmprove.prov_g_financiero =? ) AND ( cpmprove.prov_empresa =? ) AND ( cpmprove.prov_cod_proveedor =? ) ";
		
		public static string sqlHandle_01_67DA3E3C = "SELECT count ( * ) FROM bamcuent WHERE ( bamcuent.cuen_g_financiero =? ) AND ( bamcuent.cuen_empresa =? ) AND ( bamcuent.cuen_banco =? ) ";
		
		public static string sqlHandle_01_FBD9E57A = "SELECT bamcuent.cuen_no_cuenta FROM bamcuent WHERE ( bamcuent.cuen_g_financiero =? ) AND ( bamcuent.cuen_empresa =? ) AND ( bamcuent.cuen_banco =? ) ";
		
		public static string sqlHandle_01_E666A52B = "SELECT bamcuent.cuen_mg_cuenta , cuen_id , isnull ( cuen_datawindow , '' ) , isnull ( cuen_sec_auto , 'N' ) FROM bamcuent WHERE ( bamcuent.cuen_g_financiero =? ) AND ( bamcuent.cuen_empresa =? ) AND ( bamcuent.cuen_banco =? ) AND ( bamcuent.cuen_no_cuenta =? ) ";
		
		public static string sqlHandle_01_8A836C3A = "SELECT count ( * ) , max ( clie_mg_cuenta ) FROM ccmclien WHERE ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_ref_anterior =? ) AND ( ccmclien.clie_estado ='A' ) ";
		
		public static string sqlHandle_01_3A62342C = "SELECT dgmserdr.serd_mgcuenta FROM dgmserdr WHERE ( dgmserdr.serd_g_financiero =? ) AND ( dgmserdr.serd_empresa =? ) AND ( dgmserdr.serd_transaccion =? ) AND ( dgmserdr.serd_sub_trans =? ) AND ( dgmserdr.serd_aplicacion ='BA' ) ";
		
		public static string sqlHandle_01_A1F1B71A = "SELECT terc_descripcion FROM dgmterce WHERE ( dgmterce.terc_tercero =? ) ";
		
		public static string sqlHandle_01_8081CA93 = "SELECT count ( * ) FROM ncargos WHERE ( ncargos.carg_cargo =? ) AND ( ncargos.carg_visible <> 1 or ncargos.carg_visible =null ) ";
		
		public static string sqlHandle_01_7EF86D43 = "SELECT ncargos.carg_descripcion , ncargos.carg_cargado_a FROM ncargos WHERE ( ncargos.carg_cargo =? ) AND ( ncargos.carg_visible <> 1 or ncargos.carg_visible =null ) ";
		
		public static string sqlHandle_01_BE5A04D9 = "SELECT ccmclien.clie_tercero , ccmclien.clie_mg_cuenta FROM ccmclien WHERE ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_ref_anterior =? ) ";
		
		public static string sqlHandle_01_A2B924D5 = "SELECT cpmprove.prov_tercero , cpmprove.prov_mg_cuenta FROM cpmprove WHERE ( cpmprove.prov_g_financiero =? ) AND ( cpmprove.prov_empresa =? ) AND ( cpmprove.prov_cod_proveedor =? ) ";
		
		public static string sqlHandle_01_1ED4126F = "SELECT cpmprove.prov_cod_proveedor FROM cpmprove WHERE ( cpmprove.prov_g_financiero =? ) AND ( cpmprove.prov_empresa =? ) AND ( cpmprove.prov_tercero =? ) ";
		
		public static string sqlHandle_01_8D5A2642 = "SELECT ccmclien.clie_ref_anterior FROM ccmclien WHERE ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_tercero =? ) ";
		
		public static string sqlHandle_01_1C8ED08A = "SELECT count ( * ) FROM comayor WHERE ( comayor.mayo_g_financiero =? ) AND ( comayor.mayo_empresa =? ) AND ( comayor.mayo_ann =? ) AND ( comayor.mayo_cuenta =? ) ";
		
		public static string sqlHandle_01_99AC7EB4 = "SELECT count ( * ) FROM dgmplanc WHERE ( dgmplanc.mg_g_financiero =? ) AND ( dgmplanc.mg_empresa =? ) AND ( dgmplanc.mg_cuenta =? ) ";
		
		public static string sqlHandle_01_F9CF2024 = "SELECT isnull ( count ( * ) , 0 ) FROM coddiari WHERE ( coddiari.ddia_g_financiero =? ) AND ( coddiari.ddia_empresa =? ) AND ( coddiari.ddia_mg_cuenta =? ) ";
		
		public static string sqlHandle_01_231CF170 = "SELECT sum ( abs ( mayo_ene_inicial ) + abs ( mayo_ene_db ) + abs ( mayo_ene_cr ) + abs ( mayo_feb_inicial ) + abs ( mayo_feb_db ) + abs ( mayo_feb_cr ) + abs ( mayo_mar_inicial ) + abs ( mayo_mar_db ) + abs ( mayo_mar_cr ) + abs ( mayo_abr_inicial ) + abs ( mayo_abr_db ) + abs ( mayo_abr_cr ) + abs ( mayo_may_inicial ) + abs ( mayo_may_db ) + abs ( mayo_may_cr ) + abs ( mayo_jun_inicial ) + abs ( mayo_jun_db ) + abs ( mayo_jun_cr ) + abs ( mayo_jul_inicial ) + abs ( mayo_jul_db ) + abs ( mayo_jul_cr ) + abs ( mayo_ago_inicial ) + abs ( mayo_ago_db ) + abs ( mayo_ago_cr ) + abs ( mayo_sep_inicial ) + abs ( mayo_sep_db ) + abs ( mayo_sep_cr ) + abs ( mayo_oct_inicial ) + abs ( mayo_oct_db ) + abs ( mayo_oct_cr ) + abs ( mayo_nov_inicial ) + abs ( mayo_nov_db ) + abs ( mayo_nov_cr ) + abs ( mayo_dic_inicial ) + abs ( mayo_dic_db ) + abs ( mayo_dic_cr ) ) FROM comayor WHERE ( comayor.mayo_g_financiero =? ) AND ( comayor.mayo_empresa =? ) AND ( comayor.mayo_cuenta =? ) ";
		
		public static string sqlHandle_01_A672529F = "SELECT count ( * ) FROM coddiari WHERE ( coddiari.ddia_g_financiero =? ) AND ( coddiari.ddia_empresa =? ) AND ( coddiari.ddia_mg_cuenta =? ) ";
		
		public static string sqlHandle_01_D751397C = "SELECT sum ( comayor.mayo_ene_inicial + comayor.mayo_ene_db + comayor.mayo_ene_cr + comayor.mayo_feb_inicial + comayor.mayo_feb_db + comayor.mayo_feb_cr + comayor.mayo_mar_inicial + comayor.mayo_mar_db + comayor.mayo_mar_cr + comayor.mayo_abr_inicial + comayor.mayo_abr_db + comayor.mayo_abr_cr + comayor.mayo_may_inicial + comayor.mayo_may_db + comayor.mayo_may_cr + comayor.mayo_jun_inicial + comayor.mayo_jun_db + comayor.mayo_jun_cr + comayor.mayo_jul_inicial + comayor.mayo_jul_db + comayor.mayo_jul_cr + comayor.mayo_ago_inicial + comayor.mayo_ago_db + comayor.mayo_ago_cr + comayor.mayo_sep_inicial + comayor.mayo_sep_db + comayor.mayo_sep_cr + comayor.mayo_oct_inicial + comayor.mayo_oct_db + comayor.mayo_oct_cr + comayor.mayo_nov_inicial + comayor.mayo_nov_db + comayor.mayo_nov_cr + comayor.mayo_dic_inicial + comayor.mayo_dic_db + comayor.mayo_dic_cr + comayor.mayo_cierre_inicial + comayor.mayo_cierre_db + comayor.mayo_cierre_cr ) FROM comayor WHERE ( comayor.mayo_g_financiero =? ) AND ( comayor.mayo_empresa =? ) AND ( comayor.mayo_cuenta =? ) ";
		
		public static string sqlHandle_01_75CEDE53 = "SELECT dganivec.nive_cada_nivel FROM dganivec WHERE ( dganivec.nive_g_financiero =? ) AND ( dganivec.nive_empresa =? ) AND ( dganivec.nive_no_nivel =1 ) ";
		
		public static string sqlHandle_01_E35CA87A = "SELECT comayor.mayo_cuenta , comayor.mayo_ann , comayor.mayo_ene_inicial , comayor.mayo_ene_db , comayor.mayo_ene_cr , comayor.mayo_feb_inicial , comayor.mayo_feb_db , comayor.mayo_feb_cr , comayor.mayo_mar_inicial , comayor.mayo_mar_db , comayor.mayo_mar_cr , comayor.mayo_abr_inicial , comayor.mayo_abr_db , comayor.mayo_abr_cr , comayor.mayo_may_inicial , comayor.mayo_may_db , comayor.mayo_may_cr , comayor.mayo_jun_inicial , comayor.mayo_jun_db , comayor.mayo_jun_cr , comayor.mayo_jul_inicial , comayor.mayo_jul_db , comayor.mayo_jul_cr , comayor.mayo_ago_inicial , comayor.mayo_ago_db , comayor.mayo_ago_cr , comayor.mayo_sep_inicial , comayor.mayo_sep_db , comayor.mayo_sep_cr , comayor.mayo_oct_inicial , comayor.mayo_oct_db , comayor.mayo_oct_cr , comayor.mayo_nov_inicial , comayor.mayo_nov_db , comayor.mayo_nov_cr , comayor.mayo_dic_inicial , comayor.mayo_dic_db , comayor.mayo_dic_cr , comayor.mayo_cierre_inicial , comayor.mayo_cierre_db , comayor.mayo_cierre_cr FROM comayor WHERE ( comayor.mayo_g_financiero =? ) AND ( comayor.mayo_empresa =? ) AND ( comayor.mayo_ann >= ? ) AND ( comayor.mayo_ann <= ? ) Order by comayor.mayo_cuenta , comayor.mayo_ann ";
		
		public static string sqlHandle_01_91C9DD3A = "SELECT isnull ( comayor.mayo_cierre_inicial + comayor.mayo_cierre_db - comayor.mayo_cierre_cr , 0 ) FROM comayor WHERE ( comayor.mayo_g_financiero =? ) AND ( comayor.mayo_empresa =? ) AND ( comayor.mayo_cuenta =? ) AND ( comayor.mayo_ann =? ) ";
		
		public static string sqlHandle_01_E52C70D7 = "SELECT isnull ( comparam.para_ann_actual , 0 ) , isnull ( comparam.para_mes_actual , 0 ) FROM comparam WHERE ( comparam.para_g_financiero =? ) AND ( comparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_8B53BC71 = "select count ( * ) from comayor where mayo_g_financiero =? and mayo_empresa =? and mayo_cuenta =? and mayo_ann =? ";
		
		public static string sqlHandle_01_4564B286 = "SELECT count ( * ) FROM coddiari , cotdiari , dgmplanc WHERE ( cotdiari.diar_g_financiero =coddiari.ddia_g_financiero ) and ( cotdiari.diar_empresa =coddiari.ddia_empresa ) and ( cotdiari.diar_aplicacion_mg =coddiari.ddia_aplicacion_mg ) and ( cotdiari.diar_tipo_transaccion =coddiari.ddia_tipo_transaccion ) and ( cotdiari.diar_sub_trans =coddiari.ddia_sub_trans ) and ( cotdiari.diar_no_documento =coddiari.ddia_no_documento ) and ( cotdiari.diar_no_referencia =coddiari.ddia_no_referencia ) and ( cotdiari.diar_banco_cuenta =coddiari.ddia_banco_cuenta ) and ( cotdiari.diar_ann =coddiari.ddia_ann ) and ( dgmplanc.mg_g_financiero =coddiari.ddia_g_financiero ) and ( dgmplanc.mg_empresa =coddiari.ddia_empresa ) and ( dgmplanc.mg_cuenta =coddiari.ddia_mg_cuenta ) and ( ( cotdiari.diar_g_financiero =? ) AND ( cotdiari.diar_empresa =? ) AND ( cotdiari.diar_fecha_transaccion >= ? ) AND ( cotdiari.diar_fecha_transaccion <= ? ) ) ";
		
		public static string sqlHandle_01_70052A1F = "SELECT isnull ( coddiari.ddia_mg_cuenta , '' ) , isnull ( coddiari.ddia_monto , 0 ) , isnull ( coddiari.ddia_naturaleza , '' ) , cotdiari.diar_fecha_transaccion , isnull ( coddiari.ddia_tipo_transaccion , '' ) FROM coddiari , cotdiari , dgmplanc WHERE ( cotdiari.diar_g_financiero =coddiari.ddia_g_financiero ) and ( cotdiari.diar_empresa =coddiari.ddia_empresa ) and ( cotdiari.diar_aplicacion_mg =coddiari.ddia_aplicacion_mg ) and ( cotdiari.diar_tipo_transaccion =coddiari.ddia_tipo_transaccion ) and ( cotdiari.diar_sub_trans =coddiari.ddia_sub_trans ) and ( cotdiari.diar_no_documento =coddiari.ddia_no_documento ) and ( cotdiari.diar_no_referencia =coddiari.ddia_no_referencia ) and ( cotdiari.diar_banco_cuenta =coddiari.ddia_banco_cuenta ) and ( cotdiari.diar_ann =coddiari.ddia_ann ) and ( dgmplanc.mg_g_financiero =coddiari.ddia_g_financiero ) and ( dgmplanc.mg_empresa =coddiari.ddia_empresa ) and ( dgmplanc.mg_cuenta =coddiari.ddia_mg_cuenta ) and ( ( cotdiari.diar_g_financiero =? ) AND ( cotdiari.diar_empresa =? ) AND ( cotdiari.diar_fecha_transaccion >= ? ) AND ( cotdiari.diar_fecha_transaccion <= ? ) ) order by diar_fecha_transaccion ";
		
		public static string sqlHandle_01_A70F7D11 = "SELECT case ? when 1 then mayo_ene_inicial when 2 then mayo_feb_inicial when 3 then mayo_mar_inicial when 4 then mayo_abr_inicial when 5 then mayo_may_inicial when 6 then mayo_jun_inicial when 7 then mayo_jul_inicial when 8 then mayo_ago_inicial when 9 then mayo_sep_inicial when 10 then mayo_oct_inicial when 11 then mayo_nov_inicial when 12 then mayo_cierre_inicial end saldo_inicial , case ? when 1 then mayo_ene_db when 2 then mayo_feb_db when 3 then mayo_mar_db when 4 then mayo_abr_db when 5 then mayo_may_db when 6 then mayo_jun_db when 7 then mayo_jul_db when 8 then mayo_ago_db when 9 then mayo_sep_db when 10 then mayo_oct_db when 11 then mayo_nov_db when 12 then mayo_cierre_db end debito , case ? when 1 then mayo_ene_cr when 2 then mayo_feb_cr when 3 then mayo_mar_cr when 4 then mayo_abr_cr when 5 then mayo_may_cr when 6 then mayo_jun_cr when 7 then mayo_jul_cr when 8 then mayo_ago_cr when 9 then mayo_sep_cr when 10 then mayo_oct_cr when 11 then mayo_nov_cr when 12 then mayo_cierre_cr end credito , dgmplanc.mg_naturaleza FROM comayor , dganivec , dgmplanc WHERE ( comayor.mayo_g_financiero =dgmplanc.mg_g_financiero ) and ( comayor.mayo_empresa =dgmplanc.mg_empresa ) and ( comayor.mayo_cuenta =dgmplanc.mg_cuenta ) and ( dgmplanc.mg_g_financiero =dganivec.nive_g_financiero ) and ( dgmplanc.mg_empresa =dganivec.nive_empresa ) and ( dgmplanc.mg_nivel =dganivec.nive_no_nivel ) and ( ( comayor.mayo_g_financiero =? ) AND ( comayor.mayo_empresa =? ) AND ( comayor.mayo_cuenta =? ) AND ( comayor.mayo_ann =? ) ) ";
		
		public static string sqlHandle_01_4B5FC7DE = "SELECT isnull ( sum ( case when dgmplanc.mg_naturaleza ='D' then case when ddia_naturaleza ='D' then ddia_monto else - ddia_monto end else case when ddia_naturaleza ='D' then - ddia_monto else ddia_monto end end ) , 0 ) FROM coddiari , cotdiari , dgmplanc WHERE ( cotdiari.diar_g_financiero =coddiari.ddia_g_financiero ) and ( cotdiari.diar_empresa =coddiari.ddia_empresa ) and ( cotdiari.diar_aplicacion_mg =coddiari.ddia_aplicacion_mg ) and ( cotdiari.diar_tipo_transaccion =coddiari.ddia_tipo_transaccion ) and ( cotdiari.diar_sub_trans =coddiari.ddia_sub_trans ) and ( cotdiari.diar_no_documento =coddiari.ddia_no_documento ) and ( cotdiari.diar_no_referencia =coddiari.ddia_no_referencia ) and ( cotdiari.diar_banco_cuenta =coddiari.ddia_banco_cuenta ) and ( cotdiari.diar_ann =coddiari.ddia_ann ) and ( dgmplanc.mg_g_financiero =coddiari.ddia_g_financiero ) and ( dgmplanc.mg_empresa =coddiari.ddia_empresa ) and ( dgmplanc.mg_cuenta =coddiari.ddia_mg_cuenta ) and ( ( cotdiari.diar_g_financiero =? ) AND ( cotdiari.diar_empresa =? ) AND ( coddiari.ddia_mg_cuenta =? ) AND ( cotdiari.diar_fecha_transaccion >= ? ) AND ( cotdiari.diar_fecha_transaccion < ? ) ) ";
		
		public static string sqlHandle_01_9AB84B18 = "SELECT comparam.para_cuenta_utilidad FROM comparam WHERE ( comparam.para_g_financiero =? ) AND ( comparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_35DAA646 = "SELECT count ( * ) FROM cotdiari WHERE ( cotdiari.diar_g_financiero =? ) AND ( cotdiari.diar_empresa =? ) AND ( cotdiari.diar_aplicacion_mg ='CO' ) AND ( cotdiari.diar_tipo_transaccion ='RA' ) AND ( cotdiari.diar_sub_trans ='RA' ) AND ( cotdiari.diar_no_documento ='1' ) AND ( cotdiari.diar_no_referencia ='1' ) AND ( cotdiari.diar_ann =? ) ";
		
		public static string sqlHandle_01_A83B11F8 = "SELECT sum ( case when ddia_naturaleza ='D' then ddia_monto end ) FROM coddiari WHERE ( coddiari.ddia_g_financiero =? ) AND ( coddiari.ddia_empresa =? ) AND ( coddiari.ddia_aplicacion_mg ='CO' ) AND ( coddiari.ddia_tipo_transaccion ='RA' ) AND ( coddiari.ddia_sub_trans ='RA' ) AND ( coddiari.ddia_no_documento ='1' ) AND ( coddiari.ddia_no_referencia ='1' ) AND ( coddiari.ddia_ann =? ) ";
		
		public static string sqlHandle_01_C22C3BF6 = "select max ( convert ( numeric ( 8 ) , mser_secuencia ) ) from dgmserie where mser_g_financiero =? and mser_empresa =? and mser_tipo_transaccion =? ";
		
		public static string sqlHandle_01_8BA6CF11 = "select count ( * ) from cotdiari where diar_g_financiero =? and diar_empresa =? and diar_tipo_transaccion =? and diar_sub_trans =? and diar_no_documento =? and diar_ann =? ";
		
		public static string sqlHandle_01_99941C6 = "SELECT dgmplanc.mg_cuenta , dgmplanc.mg_descripcion , dgmplanc.mg_nivel , dgmplanc.mg_tipo_cuenta FROM comparam , dgmplanc WHERE ( dgmplanc.mg_g_financiero =comparam.para_g_financiero ) and ( dgmplanc.mg_empresa =comparam.para_empresa ) and ( dgmplanc.mg_cuenta =comparam.para_cuenta_utilidad ) and ( ( comparam.para_g_financiero =? ) AND ( comparam.para_empresa =? ) ) ";
		
		public static string sqlHandle_01_D19C338E = "SELECT ccmparam.para_mes , ccmparam.para_ano , ccmparam.para_ultima_morocidad , ccmparam.para_proxcicaj , ccmparam.para_ulticicaj , ccmparam.para_mens_aldia , ccmparam.para_mens_mora , ccmparam.para_mensaje_renovacion , ccmparam.para_tiempo_aviso , ccmparam.para_aplica_morosidad , ccmparam.para_enl_conta , ccmparam.para_empre_logo , ccmparam.para_empre_fondo , ccmparam.para_empre_logoaplic , ccmparam.para_imprime_informe , ccmparam.para_fecha_ini_apli FROM ccmparam WHERE ( ccmparam.para_g_financiero =? ) AND ( ccmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_B0E6DB9D = "SELECT count ( * ) FROM ccmcierr WHERE ( ccmcierr.cier_g_financiero =? ) AND ( ccmcierr.cier_empresa =? ) AND ( ccmcierr.cier_mes =? ) AND ( ccmcierr.cier_ano =? ) ";
		
		public static string sqlHandle_01_92460754 = "SELECT dgmempre.empr_razon_social FROM dgmempre WHERE ( dgmempre.empr_g_financiero =? ) AND ( dgmempre.empr_empresa =? ) ";
		
		public static string sqlHandle_01_A40D9C22 = "SELECT ccmparam.para_mes , ccmparam.para_ano FROM ccmparam WHERE ( ccmparam.para_g_financiero =? ) AND ( ccmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_A7550E3B = "SELECT isnull ( ccmparam.para_proy_anam , 'N' ) , isnull ( ccmparam.para_usa_servicios , 'N' ) , isnull ( ccmparam.para_especial_tarjetas , 'N' ) , isnull ( ccmparam.para_siafpa , 'N' ) FROM ccmparam WHERE ( ccmparam.para_g_financiero =? ) AND ( ccmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_50FF9420 = "SELECT isnull ( ccmparam.para_proy_anam , 'N' ) , isnull ( ccmparam.para_siafpa , 'N' ) FROM ccmparam WHERE ( ccmparam.para_g_financiero =? ) AND ( ccmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_28ABD51F = "SELECT isnull ( ccmparam.para_proy_anam , 'N' ) FROM ccmparam WHERE ( ccmparam.para_g_financiero =? ) AND ( ccmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_50872597 = "SELECT isnull ( ccmparam.para_cambio_pais_region , 'N' ) , isnull ( ccmparam.para_proy_anam , 'N' ) , isnull ( ccmparam.para_especial_tarjetas , 'N' ) , isnull ( ccmparam.para_usa_servicios , 'N' ) FROM ccmparam WHERE ( ccmparam.para_g_financiero =? ) AND ( ccmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_3ED09A9F = "SELECT ccmparam.para_imprime_informe , ccmparam.para_fecha_ini_apli , ccmparam.para_mes , ccmparam.para_ano , isnull ( ccmparam.para_proy_anam , 'N' ) , isnull ( ccmparam.para_especial_tarjetas , 'N' ) , isnull ( ccmparam.para_usa_servicios , 'N' ) , isnull ( ccmparam.para_siafpa , 'N' ) FROM ccmparam WHERE ( ccmparam.para_g_financiero =? ) AND ( ccmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_FBCB60D8 = "SELECT ccmparam.para_tipo_informe_caja FROM ccmparam WHERE ( ccmparam.para_g_financiero =? ) AND ( ccmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_781194F1 = "SELECT count ( * ) FROM ccbinfcja WHERE ( ccbinfcja.infcja_g_financiero =? ) AND ( ccbinfcja.infcja_empresa =? ) AND ( ccbinfcja.infcja_aplicacion ='CC' ) ";
		
		public static string sqlHandle_01_E8D67F83 = "SELECT ccmparam.para_imprime_informe , isnull ( ccmparam.para_proy_anam , 'N' ) FROM ccmparam WHERE ( ccmparam.para_g_financiero =? ) AND ( ccmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_3B1137F2 = "SELECT isnull ( ccmparam.para_imprime_informe , 'N' ) , isnull ( ccmparam.para_cambio_pais_region , 'N' ) , isnull ( ccmparam.para_proyeccion_cobros , 'N' ) , isnull ( ccmparam.para_consolidados , 'N' ) , isnull ( ccmparam.para_proy_anam , 'N' ) , isnull ( ccmparam.para_siafpa , 'N' ) FROM ccmparam WHERE ( ccmparam.para_g_financiero =? ) AND ( ccmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_D672C0CE = "SELECT isnull ( ccmparam.para_proy_anam , 'N' ) , isnull ( ccmparam.para_comision_prl , 'N' ) , isnull ( ccmparam.para_especial_tarjetas , 'N' ) FROM ccmparam WHERE ( ccmparam.para_g_financiero =? ) AND ( ccmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_8621E88E = "SELECT isnull ( ccmparam.para_proy_anam , 'N' ) , isnull ( ccmparam.para_comision_prl , 'N' ) , isnull ( ccmparam.para_especial_tarjetas , 'N' ) , isnull ( ccmparam.para_usa_servicios , 'N' ) , isnull ( ccmparam.para_siafpa , 'N' ) FROM ccmparam WHERE ( ccmparam.para_g_financiero =? ) AND ( ccmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_CD063BC3 = "SELECT cajamenuda.caja_saldo_actual FROM cajamenuda WHERE ( cajamenuda.caja_g_financiero =? ) AND ( cajamenuda.caja_empresa =? ) AND ( cajamenuda.caja_fecha_cierre < ? ) AND ( cajamenuda.caja_fecha_cierre >= dateadd ( dd , - 7 , ? ) ) order by caja_fecha_cierre desc ";
		
		public static string sqlHandle_01_D9EBF226 = "SELECT isnull ( sum ( movi_efectivo ) , 0 ) , isnull ( sum ( movi_cheque ) , 0 ) , isnull ( sum ( movi_tarjeta ) , 0 ) - isnull ( sum ( movi_comision ) , 0 ) , isnull ( sum ( movi_vuelto ) , 0 ) , isnull ( sum ( movi_transferencia ) , 0 ) FROM cctmovim WHERE ( cctmovim.movi_g_financiero =? ) AND ( cctmovim.movi_empresa =? ) AND ( cctmovim.movi_aplicacion ='CC' ) AND ( cctmovim.movi_tipo_transaccion ='RC' ) AND ( cctmovim.movi_fecha_tran >= ? ) AND ( cctmovim.movi_fecha_tran <= ? ) ";
		
		public static string sqlHandle_01_13162800 = "SELECT isnull ( sum ( movi_efectivo ) , 0 ) , isnull ( sum ( movi_cheque ) , 0 ) FROM cctmovim WHERE ( cctmovim.movi_g_financiero =? ) AND ( cctmovim.movi_empresa =? ) AND ( cctmovim.movi_aplicacion ='CC' ) AND ( cctmovim.movi_tipo_transaccion ='ND' ) AND ( cctmovim.movi_sub_transaccion ='0' ) AND ( cctmovim.movi_fecha_tran >= ? ) AND ( cctmovim.movi_fecha_tran <= ? ) ";
		
		public static string sqlHandle_01_9F570CD3 = "select isnull ( max ( convert ( numeric ( 10 ) , contrato ) ) , 0 ) from fixing where grupo =? and empresa =? ";
		
		public static string sqlHandle_01_724F1200 = "select isnull ( terc_descripcion , '' ) , isnull ( terc_tercero , 0 ) from dgmterce , ccmclien where terc_tercero =clie_tercero and clie_g_financiero =? and clie_empresa =? and clie_ref_anterior =? ";
		
		public static string sqlHandle_01_E7F5B2B9 = "SELECT nmparam.para_ult_desembolso FROM nmparam WHERE ( nmparam.para_g_financiero =? ) AND ( nmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_BEBD7A6C = "SELECT ntdesem.desem_desembolso FROM ntdesem WHERE ( ntdesem.desem_g_financiero =? ) AND ( ntdesem.desem_empresa =? ) AND ( ntdesem.desem_desembolso =? ) AND ( ntdesem.desem_ann =? ) ";
		
		public static string sqlHandle_01_F79B852E = "SELECT count ( * ) FROM ntdesem WHERE ( ntdesem.desem_g_financiero =? ) AND ( ntdesem.desem_empresa =? ) AND ( ntdesem.desem_desembolso =? ) AND ( ntdesem.desem_ann =? ) ";
		
		public static string sqlHandle_01_9A2558DC = "SELECT banadpagar.dpaga_no_cuenta FROM banadpagar , banatpagar WHERE ( banatpagar.tpaga_g_financiero =banadpagar.dpaga_g_financiero ) and ( banatpagar.tpaga_empresa =banadpagar.dpaga_empresa ) and ( banatpagar.tpaga_transito =banadpagar.dpaga_transito ) and ( banatpagar.tpaga_documento =banadpagar.dpaga_documento ) and ( banatpagar.tpaga_agno =banadpagar.dpaga_agno ) and ( banatpagar.tpaga_aplicacion =banadpagar.dpaga_aplicacion ) and ( banatpagar.tpaga_transaccion =banadpagar.dpaga_transaccion ) and ( banatpagar.tpaga_subtransaccion =banadpagar.dpaga_subtransaccion ) and ( ( banadpagar.dpaga_g_financiero =? ) AND ( banadpagar.dpaga_empresa =? ) AND ( banadpagar.dpaga_transito =? ) AND ( banadpagar.dpaga_documento =? ) AND ( banadpagar.dpaga_agno =? ) AND ( banadpagar.dpaga_aplicacion ='NA' ) AND ( banadpagar.dpaga_transaccion =? ) AND ( banadpagar.dpaga_subtransaccion =? ) ) ";
		
		public static string sqlHandle_01_F56073C2 = "SELECT max ( isnull ( ntdesem.desem_desembolso , 0 ) ) FROM ntdesem WHERE ( ntdesem.desem_g_financiero =? ) AND ( ntdesem.desem_empresa =? ) AND ( ntdesem.desem_ann =? ) ";
		
		public static string sqlHandle_01_688F4F4D = "SELECT nmparam.para_tran_caja FROM nmparam WHERE ( nmparam.para_g_financiero =? ) AND ( nmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_F64AC6F0 = "SELECT ncargos.carg_descripcion FROM ncargos WHERE ( ncargos.carg_cargo =? ) ";
		
		public static string sqlHandle_01_4CD33C4E = "SELECT ccmclien.clie_ruc_tercero FROM ccmclien WHERE ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_tercero =? ) ";
		
		public static string sqlHandle_01_5F71E96B = "SELECT ccmclien.clie_ultima_fecha_restringido FROM ccmclien WHERE ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_tercero =? ) ";
		
		public static string sqlHandle_01_A6B59338 = "SELECT nmparam.para_cuenta FROM nmparam WHERE ( nmparam.para_g_financiero =? ) AND ( nmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_8F41169E = "SELECT isnull ( nmparam.para_cuenta , '' ) FROM nmparam WHERE ( nmparam.para_g_financiero =? ) AND ( nmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_F4C93229 = "SELECT nmplantillas.mpla_descripcion , nmplantillas.mpla_class FROM nmplantillas WHERE nmplantillas.mpla_plantilla =? ";
		
		public static string sqlHandle_01_970D2B26 = "SELECT ccmclien.clie_mg_cuenta FROM ccmclien WHERE ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_tercero =? ) ";
		
		public static string sqlHandle_01_2952132D = "SELECT ntransito.tran_estado FROM ntransito WHERE ( ntransito.tran_g_financiero =? ) AND ( ntransito.tran_empresa =? ) AND ( ntransito.tran_transito =? ) ";
		
		public static string sqlHandle_01_54D8C14E = "SELECT ccmclien.clie_mg_cuenta , ccmclien.clie_restringido , ccmclien.clie_ultima_fecha_restringido FROM ccmclien WHERE ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_tercero =? ) ";
		
		public static string sqlHandle_01_4C60C3D4 = "SELECT SUM ( case cctmovim.movi_naturaleza WHEN 'D' THEN cctmovim.movi_monto else - cctmovim.movi_monto END ) FROM cctmovim where movi_g_financiero =? and movi_empresa =? and movi_tercero =? and movi_fecha_tran < ? and movi_estado ='IM' and movi_tran_contado <> 'S' group by movi_g_financiero , movi_empresa , movi_tercero ";
		
		public static string sqlHandle_01_1F573CB5 = "SELECT SUM ( case cctmovim.movi_naturaleza WHEN 'D' THEN cctmovim.movi_monto else - cctmovim.movi_monto END ) FROM cctmovim where movi_g_financiero =? and movi_empresa =? and movi_tercero =? and movi_fecha_tran < ? and movi_estado ='IM' and movi_tran_contado <> 'S' and movi_tipo_transaccion + movi_naturaleza <> 'RCD' and movi_tipo_transaccion + movi_sub_transaccion <> 'SD0' and movi_tipo_transaccion <> 'AJ' and movi_tipo_transaccion <> 'AR' group by movi_g_financiero , movi_empresa , movi_tercero ";
		
		public static string sqlHandle_01_47C665A3 = "SELECT SUM ( case cctmovim.movi_naturaleza WHEN 'D' THEN cctmovim.movi_monto else - cctmovim.movi_monto END ) FROM cctmovim where movi_g_financiero =? and movi_empresa =? and movi_tercero =? and movi_fecha_tran <= ? and movi_estado ='IM' and movi_tran_contado <> 'S' GROUP BY cctmovim.movi_g_financiero , cctmovim.movi_empresa , cctmovim.movi_tercero ORDER BY cctmovim.movi_g_financiero ASC , cctmovim.movi_empresa ASC , cctmovim.movi_tercero ASC ";
		
		public static string sqlHandle_01_9586B43 = "SELECT isnull ( ccmparam.para_tipo_descrip_antig_estcta , 'N' ) FROM ccmparam WHERE ( ccmparam.para_g_financiero =? ) AND ( ccmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_18CF31BA = "select para_imprime_grupo from ccmparam where para_g_financiero =? and para_empresa =? commit ";
		
		public static string sqlHandle_01_8989F37B = "SELECT dgmempre.empr_razon_social , dgmempre.empr_razon_comercial , dgmempre.empr_utiliza_nombre FROM dgmempre WHERE ( dgmempre.empr_g_financiero =? ) AND ( dgmempre.empr_empresa =? ) ";
		
		public static string sqlHandle_01_A17E2226 = "SELECT dgmempre.empr_direccion FROM dgmempre WHERE ( dgmempre.empr_g_financiero =? ) AND ( dgmempre.empr_empresa =? ) ";
		
		public static string sqlHandle_01_A060F32E = "SELECT dgagrupf.grup_descripcion FROM dgagrupf WHERE dgagrupf.grup_g_financiero =? ";
		
		public static string sqlHandle_01_5370BC17 = "SELECT dgmempre.empr_transferencia FROM dgmempre WHERE ( dgmempre.empr_g_financiero =? ) AND ( dgmempre.empr_empresa =? ) ";
		
		public static string sqlHandle_01_C1D89891 = "SELECT SUM ( case cctmovim.movi_naturaleza when 'D' then cctmovim.movi_monto else - cctmovim.movi_monto end ) , SUM ( case cctmovim.movi_naturaleza when 'D' then cctmovim.movi_monto else 0 end ) , SUM ( case cctmovim.movi_naturaleza when 'C' then cctmovim.movi_monto else 0 end ) FROM cctmovim WHERE ( cctmovim.movi_g_financiero =? ) and ( cctmovim.movi_empresa =? ) and ( cctmovim.movi_tercero =? ) AND ( cctmovim.movi_fecha_tran <= ? ) AND ( cctmovim.movi_estado ='IM' ) and ( cctmovim.movi_tercero <> 99999 ) and ( cctmovim.movi_tran_contado <> 'S' ) GROUP BY cctmovim.movi_g_financiero , cctmovim.movi_empresa , cctmovim.movi_tercero ";
		
		public static string sqlHandle_01_A9D59DB1 = "SELECT SUM ( case cctmovim.movi_naturaleza when 'D' then cctmovim.movi_monto else - cctmovim.movi_monto end ) , SUM ( case cctmovim.movi_naturaleza when 'D' then cctmovim.movi_monto else 0 end ) , SUM ( case cctmovim.movi_naturaleza when 'C' then cctmovim.movi_monto else 0 end ) FROM cctmovim WHERE ( cctmovim.movi_g_financiero =? ) and ( cctmovim.movi_empresa =? ) and ( cctmovim.movi_tercero =? ) AND ( cctmovim.movi_fecha_tran >= ? ) AND ( cctmovim.movi_fecha_tran <= ? ) AND ( cctmovim.movi_estado ='IM' ) and ( cctmovim.movi_tercero <> 99999 ) and ( cctmovim.movi_tran_contado <> 'S' ) GROUP BY cctmovim.movi_g_financiero , cctmovim.movi_empresa , cctmovim.movi_tercero ";
		
		public static string sqlHandle_01_73F20C5E = "SELECT SUM ( case cctmovim.movi_naturaleza when 'D' then cctmovim.movi_monto else - cctmovim.movi_monto end ) , SUM ( case cctmovim.movi_naturaleza when 'D' then cctmovim.movi_monto else 0 end ) , SUM ( case cctmovim.movi_naturaleza when 'C' then cctmovim.movi_monto else 0 end ) FROM cctmovim WHERE ( cctmovim.movi_g_financiero =? ) AND ( cctmovim.movi_empresa =? ) AND ( cctmovim.movi_tercero =? ) AND ( cctmovim.movi_fecha_tran <= ? ) AND ( cctmovim.movi_estado ='IM' ) and ( cctmovim.movi_tran_contado <> 'S' ) and ( cctmovim.movi_tipo_transaccion + cctmovim.movi_naturaleza <> 'RCD' ) and ( cctmovim.movi_tipo_transaccion + cctmovim.movi_sub_transaccion <> 'SD0' ) and ( cctmovim.movi_tipo_transaccion <> 'AJ' ) and ( cctmovim.movi_tipo_transaccion <> 'AR' ) GROUP BY cctmovim.movi_g_financiero , cctmovim.movi_empresa , cctmovim.movi_tercero ";
		
		public static string sqlHandle_01_F4FCA61E = "SELECT SUM ( case cctmovim.movi_naturaleza when 'D' then cctmovim.movi_monto else - cctmovim.movi_monto end ) , SUM ( case cctmovim.movi_naturaleza when 'D' then cctmovim.movi_monto else 0 end ) , SUM ( case cctmovim.movi_naturaleza when 'C' then cctmovim.movi_monto else 0 end ) FROM cctmovim WHERE ( cctmovim.movi_g_financiero =? ) AND ( cctmovim.movi_empresa =? ) AND ( cctmovim.movi_tercero =? ) AND ( cctmovim.movi_fecha_tran >= ? ) AND ( cctmovim.movi_fecha_tran <= ? ) AND ( cctmovim.movi_estado ='IM' ) and ( cctmovim.movi_tran_contado <> 'S' ) and ( cctmovim.movi_tipo_transaccion + cctmovim.movi_naturaleza <> 'RCD' ) and ( cctmovim.movi_tipo_transaccion + cctmovim.movi_sub_transaccion <> 'SD0' ) and ( cctmovim.movi_tipo_transaccion <> 'AJ' ) and ( cctmovim.movi_tipo_transaccion <> 'AR' ) GROUP BY cctmovim.movi_g_financiero , cctmovim.movi_empresa , cctmovim.movi_tercero ";
		
		public static string sqlHandle_01_42F5109B = "SELECT SUM ( case cctmovim.movi_naturaleza when 'D' then cctmovim.movi_monto else - cctmovim.movi_monto end ) , SUM ( case cctmovim.movi_naturaleza when 'D' then cctmovim.movi_monto else 0 end ) , SUM ( case cctmovim.movi_naturaleza when 'C' then cctmovim.movi_monto else 0 end ) FROM cctmovim WHERE ( cctmovim.movi_g_financiero =? ) AND ( cctmovim.movi_empresa =? ) AND ( cctmovim.movi_tercero =? ) AND ( cctmovim.movi_fecha_tran <= ? ) AND ( cctmovim.movi_tercero <> 99999 ) and ( cctmovim.movi_estado ='IM' ) and ( cctmovim.movi_tran_contado <> 'S' ) GROUP BY cctmovim.movi_g_financiero , cctmovim.movi_empresa , cctmovim.movi_tercero ";
		
		public static string sqlHandle_01_DC1B59A7 = "SELECT SUM ( case cctmovim.movi_naturaleza when 'D' then cctmovim.movi_monto else - cctmovim.movi_monto end ) , SUM ( case cctmovim.movi_naturaleza when 'D' then cctmovim.movi_monto else 0 end ) , SUM ( case cctmovim.movi_naturaleza when 'C' then cctmovim.movi_monto else 0 end ) FROM cctmovim WHERE ( cctmovim.movi_g_financiero =? ) AND ( cctmovim.movi_empresa =? ) AND ( cctmovim.movi_tercero =? ) AND ( cctmovim.movi_fecha_tran >= ? ) AND ( cctmovim.movi_fecha_tran <= ? ) AND ( cctmovim.movi_estado ='IM' ) and ( cctmovim.movi_tercero <> 99999 ) and ( cctmovim.movi_tran_contado <> 'S' ) GROUP BY cctmovim.movi_g_financiero , cctmovim.movi_empresa , cctmovim.movi_tercero ";
		
		public static string sqlHandle_01_E7A9B92A = "SELECT isnull ( dgmterce.terc_descripcion , '' ) , isnull ( ccmclien.clie_ref_anterior , '' ) FROM dgmterce , ccmclien , dgapais WHERE ( ccmclien.clie_tercero =dgmterce.terc_tercero ) and ( dgmterce.terc_pais =dgapais.pais_pais ) and ( ccmclien.clie_g_financiero =? ) and ( ccmclien.clie_empresa =? ) and ( ccmclien.clie_estado ='A' ) and ( dgmterce.terc_tercero =? ) ";
		
		public static string sqlHandle_01_BB52147B = "SELECT dgmplanc.mg_descripcion FROM dgmplanc WHERE ( dgmplanc.mg_g_financiero =? ) AND ( dgmplanc.mg_empresa =? ) AND ( dgmplanc.mg_cuenta =? ) ";
		
		public static string sqlHandle_01_BA09345A = "SELECT SUM ( case cchestado.est_naturaleza when 'D' then cchestado.est_monto_saldo else - ( cchestado.est_monto_saldo ) end ) FROM cchestado WHERE ( cchestado.est_g_financiero =? ) AND ( cchestado.est_empresa =? ) AND ( cchestado.est_tercero =? ) AND ( convert ( char , cchestado.est_fecha_tran , 111 ) >= ? ) AND ( convert ( char , cchestado.est_fecha_tran , 111 ) <= ? ) AND ( cchestado.est_estado ='IM' ) and ( cchestado.est_usuario_maquina =? ) ";
		
		public static string sqlHandle_01_C5D2005B = "SELECT SUM ( case cchestado.est_naturaleza when 'D' then cchestado.est_monto_saldo else - ( cchestado.est_monto_saldo ) end ) FROM cchestado WHERE ( cchestado.est_g_financiero =? ) AND ( cchestado.est_empresa =? ) AND ( convert ( char , cchestado.est_fecha_tran , 111 ) < ? ) AND ( cchestado.est_tercero =? ) AND ( cchestado.est_estado ='IM' ) and ( cchestado.est_usuario_maquina =? ) ";
		
		public static string sqlHandle_01_96C758A0 = "select count ( * ) from cctmovim where movi_g_financiero =? and movi_empresa =? and movi_tipo_transaccion =? and movi_documento =? and movi_anno =? ";
		
		public static string sqlHandle_01_C528FA9F = "select max ( convert ( numeric ( 8 ) , subs_secuencia ) ) from dgmsubse where subs_g_financiero =? and subs_empresa =? and subs_transaccion =? and subs_sub_trans =? ";
		
		public static string sqlHandle_01_262757C = "select count ( * ) from cctmovim where movi_g_financiero =? and movi_empresa =? and movi_tipo_transaccion =? and movi_sub_transaccion =? and movi_documento =? and movi_anno =? ";
		
		public static string sqlHandle_01_59624B5C = "SELECT ccdrefac.refa_aplicacion_ori , ccdrefac.refa_tipo_transaccion_ori , ccdrefac.refa_sub_transaccion_ori , ccdrefac.refa_documento_ori , ccdrefac.refa_referencia_ori , ccdrefac.refa_ann_ori , ccdrefac.refa_monto_pagado , ccdrefac.refa_tercero FROM ccdrefac WHERE ( ccdrefac.refa_g_financiero =? ) AND ( ccdrefac.refa_empresa =? ) AND ( ccdrefac.refa_tipo_transaccion =? ) AND ( ccdrefac.refa_sub_transaccion =? ) AND ( ccdrefac.refa_documento =? ) AND ( ccdrefac.refa_referencia =? ) AND ( ccdrefac.refa_ann =? ) ";
		
		public static string sqlHandle_01_24C6FE78 = "SELECT isnull ( dgmserdr.serd_mgcuenta , '' ) FROM dgmserdr WHERE ( dgmserdr.serd_g_financiero =? ) AND ( dgmserdr.serd_empresa =? ) AND ( dgmserdr.serd_transaccion =? ) AND ( dgmserdr.serd_sub_trans =? ) AND ( dgmserdr.serd_aplicacion ='CC' ) ";
		
		public static string sqlHandle_01_69346C65 = "SELECT count ( * ) FROM cotdiari WHERE ( cotdiari.diar_g_financiero =? ) AND ( cotdiari.diar_empresa =? ) AND ( cotdiari.diar_aplicacion_mg ='CC' ) AND ( cotdiari.diar_tipo_transaccion =? ) AND ( cotdiari.diar_sub_trans =? ) AND ( cotdiari.diar_no_documento =? ) AND ( cotdiari.diar_no_referencia =? ) AND ( cotdiari.diar_ann =? ) ";
		
		public static string sqlHandle_01_2A2C8509 = "SELECT max ( caja_fecha_cierre ) FROM cajamenuda WHERE ( cajamenuda.caja_g_financiero =? ) AND ( cajamenuda.caja_empresa =? ) AND ( cajamenuda.caja_cerrada =1 ) ";
		
		public static string sqlHandle_01_A371A929 = "select max ( mser_descripcion ) from dgmserie where mser_g_financiero =? and mser_empresa =? and mser_tipo_transaccion =? ";
		
		public static string sqlHandle_01_565B8CF8 = "SELECT count ( * ) FROM ccmclien WHERE ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_tercero =? ) ";
		
		public static string sqlHandle_01_4BC23E9E = "SELECT isnull ( dgmsubse.subs_descripcion , '' ) FROM dgmsubse WHERE ( dgmsubse.subs_g_financiero =? ) AND ( dgmsubse.subs_empresa =? ) AND ( dgmsubse.subs_transaccion =? ) AND ( dgmsubse.subs_sub_trans =? ) ";
		
		public static string sqlHandle_01_887E128F = "SELECT natransito.tran_sin FROM natransito WHERE ( natransito.tran_g_financiero =? ) AND ( natransito.tran_empresa =? ) AND ( natransito.tran_transito =? ) ";
		
		public static string sqlHandle_01_745B1F5C = "SELECT nanave.nav_nombre FROM nanave WHERE ( nanave.nav_g_financiero =? ) AND ( nanave.nav_empresa =? ) AND ( nanave.nav_sin =? ) ";
		
		public static string sqlHandle_01_4B5F19D6 = "SELECT comparam.para_an_fiscal_actual , comparam.para_mes_fiscal_actual FROM comparam WHERE ( comparam.para_g_financiero =? ) AND ( comparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_B730FCA2 = "SELECT count ( * ) FROM usuarios WHERE ( usuarios.usua_id =? ) AND ( usuarios.usua_clave =? ) AND ( usuarios.usua_especial =1 ) AND ( usuarios.usua_estado ='A' ) ";
		
		public static string sqlHandle_01_5EC767AB = "SELECT count ( * ) FROM usuarios WHERE ( usuarios.usua_id ='SA' ) AND ( usuarios.usua_clave =? ) AND ( usuarios.usua_estado ='A' ) ";
		
		public static string sqlHandle_01_65F63B0D = "SELECT max ( movi_historica ) FROM cctmovim WHERE ( cctmovim.movi_g_financiero =? ) AND ( cctmovim.movi_empresa =? ) AND ( cctmovim.movi_aplicacion =? ) AND ( cctmovim.movi_tipo_transaccion =? ) AND ( cctmovim.movi_sub_transaccion =? ) AND ( cctmovim.movi_documento =? ) AND ( cctmovim.movi_anno =? ) ";
		
		public static string sqlHandle_01_A778963E = "SELECT count ( * ) FROM ssmusuar WHERE ( ssmusuar.usua_id =? ) ";
		
		public static string sqlHandle_01_92572E0D = "SELECT count ( * ) FROM ssmusuar WHERE ( ssmusuar.usua_id =? ) AND ( ssmusuar.usua_clave =? ) ";
		
		public static string sqlHandle_01_21FEFC55 = "SELECT ssmusuar.usua_supervisor FROM ssmusuar WHERE ( ssmusuar.usua_id =? ) AND ( ssmusuar.usua_clave =? ) ";
		
		public static string sqlHandle_01_96CF6635 = "select max ( id ) from directorio ";
		
		public static string sqlHandle_01_C9854060 = "SELECT max ( id ) FROM directorio WHERE ( directorio.apellido =? ) ";
		
		public static string sqlHandle_01_54E51DC7 = "SELECT count ( * ) FROM directorio WHERE ( directorio.id =? ) ";
		
		public static string sqlHandle_01_E0735EAE = "SELECT ccmclien.clie_ruc_tercero FROM ccmclien , dgmterce WHERE ( ccmclien.clie_tercero =dgmterce.terc_tercero ) and ( ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_tercero =? ) ) ";
		
		public static string sqlHandle_01_950F8086 = "SELECT isnull ( ccmparam.para_tipo_busqueda , 'S' ) , isnull ( ccmparam.para_fecha_estado_cuenta , '2' ) , isnull ( ccmparam.para_piepag_estado_cuenta , '2' ) , isnull ( ccmparam.para_tipocli_estado_cuenta , 'N' ) , ccmparam.para_tipo_busqueda , isnull ( ccmparam.para_mensaje_ecuenta , 'P' ) , isnull ( ccmparam.para_mens_aldia , '' ) , isnull ( ccmparam.para_mostrar_mora , 'N' ) , isnull ( ccmparam.para_tipo_antig_en_ecuenta , 'N' ) , isnull ( ccmparam.para_estcuen_preimpreso , 'N' ) FROM ccmparam WHERE ( ccmparam.para_g_financiero =? ) AND ( ccmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_9921E022 = "SELECT dgmterce.terc_tercero FROM dgmterce , ccmclien WHERE ( ccmclien.clie_tercero =dgmterce.terc_tercero ) and ( ( ccmclien.clie_ref_anterior =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_g_financiero =? ) ) ";
		
		public static string sqlHandle_01_85B98F88 = "SELECT ccmclien.clie_ref_anterior , terc_descripcion FROM ccmclien , dgmterce WHERE ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_tercero =dgmterce.terc_tercero ) AND ( ccmclien.clie_tercero =? ) ";
		
		public static string sqlHandle_01_EA671F17 = "SELECT dgmterce.terc_descripcion FROM dgmterce WHERE dgmterce.terc_tercero =? ";
		
		public static string sqlHandle_01_F3A750AD = "SELECT ccmclien.clie_ruc_tercero , ccmclien.clie_ref_anterior FROM ccmclien WHERE ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_tercero =? ) ";
		
		public static string sqlHandle_01_E5D8CA54 = "SELECT ccmclien.clie_tercero FROM ccmclien WHERE ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_ruc_tercero =? ) ";
		
		public static string sqlHandle_01_D01F5A6F = "SELECT ccmclien.clie_tercero FROM ccmclien WHERE ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_ref_anterior =? ) ";
		
		public static string sqlHandle_01_6C1F3DD0 = "SELECT dgmterce.terc_descripcion , dgmterce.terc_identificacion FROM dgmterce WHERE ( dgmterce.terc_tercero =? ) ";
		
		public static string sqlHandle_01_CE3F9862 = "SELECT dgmterce.terc_descripcion , dgmterce.terc_identificacion FROM dgmterce WHERE dgmterce.terc_tercero =? ";
		
		public static string sqlHandle_01_11870852 = "select max ( convert ( numeric ( 8 ) , mser_secuencia ) ) from dgmserie where mser_g_financiero =? and mser_empresa =? and mser_tipo_transaccion ='ND' ";
		
		public static string sqlHandle_01_35A030A1 = "select count ( * ) from cctmovim where movi_g_financiero =? and movi_empresa =? and movi_tipo_transaccion ='ND' and movi_documento =? and movi_anno =? ";
		
		public static string sqlHandle_01_F244E686 = "SELECT count ( * ) FROM ccaantig WHERE ( ccaantig.ccan_g_financiero =? ) AND ( ccaantig.ccan_empresa =? ) ";
		
		public static string sqlHandle_01_EE943FDC = "select forma_datawindow from ccaforma where forma_g_financiero =? and forma_empresa =? and forma_tipo_formato ='EST' and forma_formato ='ESTAD' ";
		
		public static string sqlHandle_01_AD0EB850 = "SELECT count ( * ) FROM ccaforma where forma_tipo_formato ='EST' and forma_formato ='ESTAD' and forma_g_financiero =? and forma_empresa =? ";
		
		public static string sqlHandle_01_DA8CF4B5 = "select forma_datawindow from ccaforma where forma_tipo_formato ='EST' and forma_formato ='ESTAD' and forma_g_financiero =? and forma_empresa =? ";
		
		public static string sqlHandle_01_C8D6BBA6 = "SELECT ccmparam.para_tipo_busqueda , ccmparam.para_tipo_descrip_antig_estcta , ccmparam.para_mostrar_nombre_dw FROM ccmparam WHERE ( ccmparam.para_g_financiero =? ) AND ( ccmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_1952DEFE = "select count ( * ) from cctmovim where movi_g_financiero =? and movi_empresa =? and movi_tipo_transaccion ='ND' and movi_sub_transaccion ='IN' and movi_documento =? and movi_anno =? ";
		
		public static string sqlHandle_01_4F5E8A28 = "SELECT cpmparam.para_fecha_inicio FROM cpmparam WHERE ( cpmparam.para_g_financiero =? ) AND ( cpmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_71A291E1 = "SELECT count ( * ) FROM ccaantig WHERE ( ccaantig.ccan_g_financiero =? ) AND ( ccaantig.ccan_empresa =? ) AND ( ccaantig.ccan_codigo =? ) ";
		
		public static string sqlHandle_01_EB1D41D2 = "SELECT isnull ( para_para_antig_fact , 'SI' ) , isnull ( ccmparam.para_antiguedad_pais , 'R' ) , isnull ( ccmparam.para_cambio_pais_region , 'N' ) FROM ccmparam WHERE ( para_g_financiero =? ) and ( para_empresa =? ) ";
		
		public static string sqlHandle_01_DED46B7D = "SELECT count ( * ) FROM ccaantig WHERE ( ccan_g_financiero =? ) and ( ccan_empresa =? ) and ( ccan_codigo =? ) ";
		
		public static string sqlHandle_01_4929061C = "SELECT dgmempre.empr_cuenta_cxc_default FROM dgmempre WHERE ( dgmempre.empr_g_financiero =? ) AND ( dgmempre.empr_empresa =? ) ";
		
		public static string sqlHandle_01_1C486EEF = "select count ( * ) from dgmterce where terc_tercero =? ";
		
		public static string sqlHandle_01_8D136F36 = "SELECT max ( clie_tercero ) FROM ccmclien WHERE ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_ref_anterior =? ) ";
		
		public static string sqlHandle_01_AE0AC84A = "select max ( terc_tercero ) from dgmterce where terc_tipo =1 ";
		
		public static string sqlHandle_01_3BE9F1FC = "select count ( * ) from cctmovim where movi_g_financiero =? and movi_empresa =? and movi_tercero =? ";
		
		public static string sqlHandle_01_579A0E9A = "SELECT count ( * ) FROM banadpagar , banatpagar WHERE ( banatpagar.tpaga_g_financiero =banadpagar.dpaga_g_financiero ) and ( banatpagar.tpaga_empresa =banadpagar.dpaga_empresa ) and ( banatpagar.tpaga_transito =banadpagar.dpaga_transito ) and ( banatpagar.tpaga_documento =banadpagar.dpaga_documento ) and ( banatpagar.tpaga_agno =banadpagar.dpaga_agno ) and ( banatpagar.tpaga_aplicacion =banadpagar.dpaga_aplicacion ) and ( banatpagar.tpaga_transaccion =banadpagar.dpaga_transaccion ) and ( banatpagar.tpaga_subtransaccion =banadpagar.dpaga_subtransaccion ) and ( ( banadpagar.dpaga_g_financiero =? ) AND ( banadpagar.dpaga_empresa =? ) AND ( banadpagar.dpaga_transito =? ) AND ( banadpagar.dpaga_documento =? ) AND ( banatpagar.tpaga_transaccion ='CM' ) AND ( banatpagar.tpaga_subtransaccion ='CM' ) AND ( banatpagar.tpaga_aplicacion ='NA' ) AND ( banatpagar.tpaga_agno =? ) ) ";
		
		public static string sqlHandle_01_1E26170B = "SELECT nmparam.para_tran_caja , nmparam.para_cuenta , nmparam.para_mg_cuenta_itbm FROM nmparam WHERE ( nmparam.para_g_financiero =? ) AND ( nmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_C0E19F32 = "SELECT nmcaja.mcaj_cuenta FROM nmcaja WHERE nmcaja.mcaj_caja =? ";
		
		public static string sqlHandle_01_E9D9E10B = "SELECT count ( * ) FROM ccaantig WHERE ccan_g_financiero =? AND ccan_empresa =? AND ccan_codigo =? ";
		
		public static string sqlHandle_01_C83253F = "SELECT para_tipo_busqueda , isnull ( ccmparam.para_cambio_pais_region , 'N' ) , isnull ( ccmparam.para_proy_anam , 'N' ) FROM ccmparam WHERE ( para_g_financiero =? ) AND ( para_empresa =? ) ";
		
		public static string sqlHandle_01_A2A186FA = "SELECT isnull ( cptmovim.movi_monto_final , 0 ) FROM cptmovim WHERE ( cptmovim.movi_g_financiero =? ) AND ( cptmovim.movi_empresa =? ) AND ( cptmovim.movi_tercero =? ) AND ( cptmovim.movi_tipo_transaccion + cptmovim.movi_sub_transaccion ='NC9' ) AND ( cptmovim.movi_aplicacion ='CP' ) ";
		
		public static string sqlHandle_01_70A9812A = "SELECT isnull ( sum ( case movi_naturaleza when 'D' then ( - 1 * isnull ( abs ( movi_monto_final ) , 0 ) ) else isnull ( abs ( movi_monto_final ) , 0 ) end ) , 0 ) FROM cptmovim WHERE ( movi_g_financiero =? ) AND ( movi_empresa =? ) and ( movi_tercero =? ) and ( movi_fecha_tran <= ? ) and ( movi_estado <> 'AN' ) and ( movi_tipo_transaccion + movi_sub_transaccion <> 'NC9' ) ";
		
		public static string sqlHandle_01_97A59CDF = "SELECT SUM ( abs ( isnull ( cptmovim.movi_monto_final , 0 ) ) ) FROM cptmovim WHERE ( cptmovim.movi_g_financiero =? ) AND ( cptmovim.movi_empresa =? ) AND ( cptmovim.movi_naturaleza ='D' ) AND ( cptmovim.movi_fecha_tran < dateadd ( dd , 1 , ? ) ) AND ( cptmovim.movi_tercero =? ) ";
		
		public static string sqlHandle_01_F58D6E3E = "SELECT sum ( abs ( isnull ( cptmovim.movi_monto_final , 0 ) ) ) FROM cptmovim WHERE ( cptmovim.movi_g_financiero =? ) AND ( cptmovim.movi_empresa =? ) AND ( cptmovim.movi_fecha_tran < ? ) AND ( cptmovim.movi_naturaleza ='C' ) AND ( cptmovim.movi_tercero =? ) ";
		
		public static string sqlHandle_01_4F9B8789 = "SELECT sum ( abs ( isnull ( cptmovim.movi_monto_final , 0 ) ) ) FROM cptmovim WHERE ( cptmovim.movi_g_financiero =? ) AND ( cptmovim.movi_empresa =? ) AND ( cptmovim.movi_fecha_tran >= ? ) AND ( cptmovim.movi_fecha_tran <= ? ) AND ( cptmovim.movi_naturaleza ='C' ) AND ( cptmovim.movi_tercero =? ) ";
		
		public static string sqlHandle_01_3F8B604 = "SELECT isnull ( sum ( case movi_naturaleza when 'D' then ( - 1 * isnull ( abs ( movi_monto_final ) , 0 ) ) else isnull ( abs ( movi_monto_final ) , 0 ) end ) , 0 ) FROM cptmovim WHERE ( movi_g_financiero =? ) AND ( movi_empresa =? ) and ( movi_tercero =? ) and ( movi_fecha_tran < ? ) and ( movi_estado <> 'AN' ) and ( movi_tipo_transaccion + movi_sub_transaccion <> 'NC9' ) ";
		
		public static string sqlHandle_01_A14FA64D = "SELECT max ( movi_historico ) FROM cptmovim WHERE ( cptmovim.movi_g_financiero =? ) AND ( cptmovim.movi_empresa =? ) AND ( cptmovim.movi_tipo_transaccion =? ) AND ( cptmovim.movi_documento =? ) AND ( cptmovim.movi_anno =? ) ";
		
		public static string sqlHandle_01_B8421E00 = "SELECT cptmovim.movi_referencia FROM cptmovim WHERE ( cptmovim.movi_g_financiero =? ) AND ( cptmovim.movi_empresa =? ) AND ( cptmovim.movi_aplicacion ='CP' ) AND ( cptmovim.movi_tipo_transaccion =? ) AND ( cptmovim.movi_documento =? ) AND ( cptmovim.movi_anno =? ) ";
		
		public static string sqlHandle_01_E385CA5F = "SELECT sum ( ( case movi_naturaleza when 'D' then ( ( - 1 ) * isnull ( abs ( cptmovim.movi_monto_final ) , 0 ) ) else isnull ( abs ( cptmovim.movi_monto_final ) , 0 ) end ) ) FROM cptmovim WHERE ( cptmovim.movi_g_financiero =? ) AND ( cptmovim.movi_empresa =? ) AND ( cptmovim.movi_fecha_tran < ? ) AND ( cptmovim.movi_estado <> 'AN' ) AND ( cptmovim.movi_tercero =? ) ";
		
		public static string sqlHandle_01_16B5379E = "SELECT sum ( ( case movi_naturaleza when 'D' then ( ( - 1 ) * isnull ( abs ( cptmovim.movi_monto_final ) , 0 ) ) else isnull ( abs ( cptmovim.movi_monto_final ) , 0 ) end ) ) FROM cptmovim WHERE ( cptmovim.movi_g_financiero =? ) AND ( cptmovim.movi_empresa =? ) AND ( cptmovim.movi_fecha_tran >= ? ) AND ( cptmovim.movi_fecha_tran <= ? ) AND ( cptmovim.movi_estado <> 'AN' ) AND ( cptmovim.movi_tercero =? ) ";
		
		public static string sqlHandle_01_8224CE2F = "SELECT dgmempre.empr_cuenta_cxp_default FROM dgmempre WHERE ( dgmempre.empr_g_financiero =? ) AND ( dgmempre.empr_empresa =? ) ";
		
		public static string sqlHandle_01_AC02241 = "SELECT max ( convert ( numeric ( 8 ) , prov_cod_proveedor ) ) FROM cpmprove WHERE ( cpmprove.prov_g_financiero =? ) AND ( cpmprove.prov_empresa =? ) ";
		
		public static string sqlHandle_01_D04D9355 = "select count ( * ) from cpmprove where prov_cod_proveedor =? and prov_g_financiero =? and prov_empresa =? ";
		
		public static string sqlHandle_01_20A4043 = "select count ( * ) from cptmovim where movi_g_financiero =? and movi_empresa =? and movi_tercero =? ";
		
		public static string sqlHandle_01_8AB92769 = "select max ( terc_tercero ) from dgmterce where terc_tipop =1 ";
		
		public static string sqlHandle_01_AB3F4E76 = "SELECT count ( * ) FROM cpmprove WHERE ( cpmprove.prov_g_financiero =? ) AND ( cpmprove.prov_empresa =? ) AND ( cpmprove.prov_cod_proveedor =? ) ";
		
		public static string sqlHandle_01_9B2EAE30 = "SELECT count ( * ) FROM cotdiari WHERE ( cotdiari.diar_g_financiero =? ) AND ( cotdiari.diar_empresa =? ) AND ( cotdiari.diar_aplicacion_mg ='CP' ) AND ( cotdiari.diar_tipo_transaccion =? ) AND ( cotdiari.diar_sub_trans =? ) AND ( cotdiari.diar_no_documento =? ) AND ( cotdiari.diar_no_referencia =? ) AND ( cotdiari.diar_ann =? ) ";
		
		public static string sqlHandle_01_F5E0D5A1 = "SELECT count ( * ) FROM dgmempre , inaparam WHERE ( inaparam.para_g_financiero =dgmempre.empr_g_financiero ) and ( inaparam.para_empresa =dgmempre.empr_empresa ) and ( ( dgmempre.empr_g_financiero =? ) AND ( dgmempre.empr_empresa =? ) AND ( dgmempre.empr_empresa <> 1 ) ) ";
		
		public static string sqlHandle_01_1FD4D47B = "SELECT isnull ( usua_letras_por_default , 1 ) FROM usuarios WHERE usuarios.usua_id =? ";
		
		public static string sqlHandle_01_91626DDC = "select para_clave_costos , inaparam.para_foto_dir , inaparam.para_foto_dir_catalogo from inaparam where ( para_g_financiero =? ) and ( para_empresa =? ) ";
		
		public static string sqlHandle_01_A9978A27 = "SELECT max ( agru_descripcion_grupo ) FROM cragrupo WHERE ( cragrupo.agru_g_financiero =? ) AND ( cragrupo.agru_empresa =? ) AND ( cragrupo.agru_codigo_div =? ) AND ( cragrupo.agru_codigo_grupo =? ) ";
		
		public static string sqlHandle_01_A4353DFA = "SELECT max ( acol_nombre_color ) FROM cracolor WHERE ( cracolor.acol_g_financiero =? ) AND ( cracolor.acol_empresa =? ) AND ( cracolor.acol_num_color =? ) ";
		
		public static string sqlHandle_01_200EAC90 = "SELECT max ( acta_descripcion ) FROM cracltam WHERE ( cracltam.acta_g_financiero =? ) AND ( cracltam.acta_empresa =? ) AND ( cracltam.acta_cod_clase_tam =? ) ";
		
		public static string sqlHandle_01_A5BEA3A1 = "SELECT max ( aesp_descripcion_espec ) FROM craespec WHERE ( craespec.aesp_g_financiero =? ) AND ( craespec.aesp_empresa =? ) AND ( craespec.aesp_num_especificacion =? ) ";
		
		public static string sqlHandle_01_338C9E42 = "SELECT inmprodu.prod_producto FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ";
		
		public static string sqlHandle_01_BDEA10C0 = "select count ( * ) , max ( prod_producto ) from inmprodu where prod_g_financiero =? and prod_empresa =? and prod_producto_dos =? ";
		
		public static string sqlHandle_01_5CBF2684 = "SELECT max ( inmprodu.prod_producto ) , count ( * ) FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto_dos =? ) ";
		
		public static string sqlHandle_01_CB2F67BF = "select count ( * ) from inmprodu where prod_g_financiero =? and prod_empresa =? and prod_producto =? ";
		
		public static string sqlHandle_01_C242B511 = "SELECT isnull ( usuarios.usua_especial , 0 ) FROM usuarios WHERE usuarios.usua_id =? ";
		
		public static string sqlHandle_01_773C55FE = "SELECT inmprodu.prod_descripcion , inmprodu.prod_precio1 , inmprodu.prod_cod_alternativo FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ";
		
		public static string sqlHandle_01_C401C77F = "SELECT count ( * ) FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ";
		
		public static string sqlHandle_01_FA1F67F8 = "select isnull ( max ( registro ) , 0 ) from promedio_mano_obra where grupo =? and empresa =? and ann =? ";
		
		public static string sqlHandle_01_B30835F5 = "SELECT sum ( valor_mano_obra ) , sum ( cantidad_gramos ) FROM promedio_mano_obra WHERE promedio_mano_obra.ann =? AND promedio_mano_obra.kilates =? ";
		
		public static string sqlHandle_01_E21C279 = "SELECT prov_cod_proveedor FROM cpmprove WHERE ( cpmprove.prov_g_financiero =? ) AND ( cpmprove.prov_empresa =? ) AND ( cpmprove.prov_tercero =? ) ";
		
		public static string sqlHandle_01_3FE746F = "select isnull ( max ( registro ) , 0 ) from entrada_plateria where grupo =? and empresa =? and ann =? ";
		
		public static string sqlHandle_01_D5103D8D = "SELECT sum ( valor_compra ) , sum ( cantidad_gramos ) FROM entrada_plateria WHERE entrada_plateria.ann =? ";
		
		public static string sqlHandle_01_9C98BA5E = "select max ( convert ( numeric ( 10 ) , enca_secuencia ) ) from orden where enca_g_financiero =? and enca_empresa =? and enca_ann =? ";
		
		public static string sqlHandle_01_5430FFCB = "SELECT count ( * ) FROM cpdrefac WHERE ( cpdrefac.refa_g_financiero =? ) AND ( cpdrefac.refa_empresa =? ) AND ( cpdrefac.refa_aplicacion_ori ='CP' ) AND ( cpdrefac.refa_tipo_transaccion_ori ='OC' ) AND ( cpdrefac.refa_sub_transaccion_ori ='OC' ) AND ( cpdrefac.refa_documento_ori =? ) AND ( cpdrefac.refa_referencia_ori =? ) AND ( cpdrefac.refa_tercero =? ) ";
		
		public static string sqlHandle_01_437597B0 = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inmprodu.prod_medida , unidades_a.medi_cantidad , unidades_b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_costo_fob FROM inmprodu , inamedid unidades_a , inamedid unidades_b WHERE ( unidades_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =unidades_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ) ";
		
		public static string sqlHandle_01_63D3F90 = "SELECT inmprodu.prod_empaque , inamedid_a.medi_cantidad , inamedid_b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_costo_promedio FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ) ";
		
		public static string sqlHandle_01_198766CC = "SELECT count ( * ) FROM productos WHERE ( productos.prod_g_financiero =? ) AND ( productos.prod_empresa =? ) AND ( productos.prod_producto =? ) ";
		
		public static string sqlHandle_01_7C790F61 = "SELECT count ( * ) FROM orden_detalle WHERE ( orden_detalle.deta_g_financiero =? ) AND ( orden_detalle.deta_empresa =? ) AND ( orden_detalle.deta_referencia =? ) ";
		
		public static string sqlHandle_01_54A9D216 = "SELECT count ( * ) FROM pedidos_detalle WHERE ( pedidos_detalle.dped_g_financiero =? ) AND ( pedidos_detalle.dped_empresa =? ) AND ( pedidos_detalle.dped_producto =? ) ";
		
		public static string sqlHandle_01_8AFB6FB4 = "SELECT count ( * ) FROM orden WHERE ( orden.enca_g_financiero =? ) AND ( orden.enca_empresa =? ) AND ( orden.enca_secuencia =? ) AND ( orden.enca_ann =? ) ";
		
		public static string sqlHandle_01_787762C4 = "SELECT count ( * ) FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_orden_compra =? ) ";
		
		public static string sqlHandle_01_BE47728F = "SELECT count ( * ) FROM orden_detalle WHERE ( orden_detalle.deta_g_financiero =? ) AND ( orden_detalle.deta_empresa =? ) AND ( orden_detalle.deta_secuencia =? ) AND ( orden_detalle.deta_ann =? ) ";
		
		public static string sqlHandle_01_FDF0FEB5 = "SELECT inmprodu.prod_producto , inmprodu.prod_descripcion , inmprodu.prod_empaque , inmprodu.prod_medida , inmprodu.prod_empaque_um , inmprodu.prod_peso , inmprodu.prod_cubicaje , isnull ( inmprodu.prod_costo_oc , 0 ) , isnull ( inmprodu.prod_cantidad_oc , 0 ) FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_orden_compra =? ) ";
		
		public static string sqlHandle_01_A28BE3EA = "SELECT unidades_a.medi_cantidad , unidades_b.medi_cantidad FROM inmprodu , inamedid unidades_a , inamedid unidades_b WHERE ( unidades_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =unidades_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ) ";
		
		public static string sqlHandle_01_5772A6B9 = "SELECT inmprodu.prod_empaque , inmprodu.prod_peso , inmprodu.prod_cubicaje , a.medi_cantidad , b.medi_cantidad FROM inmprodu , inamedid a , inamedid b WHERE ( a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =b.medi_medida ) and ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ";
		
		public static string sqlHandle_01_CE104C1C = "SELECT dgmterce.terc_descripcion , cpmprove.prov_cod_proveedor , cpmprove.prov_mg_cuenta FROM cpmprove , dgmterce WHERE ( dgmterce.terc_tercero =cpmprove.prov_tercero ) and ( ( cpmprove.prov_g_financiero =? ) AND ( cpmprove.prov_empresa =? ) AND ( cpmprove.prov_tercero =? ) ) ";
		
		public static string sqlHandle_01_565AA6A4 = "SELECT isnull ( max ( prod_id ) , 0 ) FROM productos_importar ";
		
		public static string sqlHandle_01_A52353D = "SELECT cradivis.adiv_codigo_div FROM cradivis WHERE ( cradivis.adiv_g_financiero =? ) AND ( cradivis.adiv_empresa =? ) AND ( cradivis.adiv_nombre_div =? ) ";
		
		public static string sqlHandle_01_F70DF0F5 = "SELECT cragrupo.agru_codigo_grupo FROM cragrupo WHERE ( cragrupo.agru_g_financiero =? ) AND ( cragrupo.agru_empresa =? ) AND ( cragrupo.agru_codigo_div =? ) AND ( cragrupo.agru_descripcion_grupo =? ) ";
		
		public static string sqlHandle_01_26445F88 = "SELECT inamedid.medi_medida FROM inamedid WHERE inamedid.medi_descripcion =? ";
		
		public static string sqlHandle_01_DA6394D3 = "SELECT cracltam.acta_cod_clase_tam FROM cracltam WHERE ( cracltam.acta_g_financiero =? ) AND ( cracltam.acta_empresa =? ) AND ( cracltam.acta_descripcion =? ) ";
		
		public static string sqlHandle_01_EA9A590D = "SELECT cramarca.amar_num_marca FROM cramarca WHERE cramarca.amar_nombre_marca =? and cramarca.amar_g_financiero =? and cramarca.amar_empresa =? ";
		
		public static string sqlHandle_01_84735F4E = "SELECT dgapais.pais_pais FROM dgapais WHERE dgapais.pais_descripcion =? ";
		
		public static string sqlHandle_01_C828B2B9 = "SELECT dgmterce.terc_tercero FROM dgmterce , cpmprove WHERE dgmterce.terc_descripcion =? and dgmterce.terc_tercero =cpmprove.prov_tercero and cpmprove.prov_g_financiero =? and cpmprove.prov_empresa =? ";
		
		public static string sqlHandle_01_42B51756 = "select para_sistema_costeo , para_formato_decimal from inaparam where para_g_financiero =? and para_empresa =? ";
		
		public static string sqlHandle_01_84ECB74F = "SELECT count ( * ) FROM intmovim , indmovim WHERE ( indmovim.dmov_g_financiero =intmovim.tmov_g_financiero ) and ( indmovim.dmov_empresa =intmovim.tmov_empresa ) and ( indmovim.dmov_aplicacion =intmovim.tmov_aplicacion ) and ( indmovim.dmov_tipo_transaccion =intmovim.tmov_tipo_transaccion ) and ( indmovim.dmov_concepto =intmovim.tmov_concepto ) and ( indmovim.dmov_secuencia =intmovim.tmov_secuencia ) and ( indmovim.dmov_anual =intmovim.tmov_anual ) and ( ( intmovim.tmov_g_financiero =? ) AND ( intmovim.tmov_empresa =? ) AND ( intmovim.tmov_aplicacion ='FA' ) AND ( intmovim.tmov_tipo_transaccion ='SA' ) AND ( intmovim.tmov_fecha >= ? ) AND ( indmovim.dmov_producto =? ) ) ";
		
		public static string sqlHandle_01_9A6D96F5 = "SELECT inmprodu.prod_barra , inmprodu.prod_producto , inmprodu.prod_descripcion , inmprodu.prod_precio1 , inmprodu.prod_precio2 , inmprodu.prod_precio3 , inmprodu.prod_precio4 , inmprodu.prod_precio5 , inmprodu.prod_medida , inmprodu.prod_cubicaje , inmprodu.prod_empaque , inmprodu.prod_peso , inmprodu.prod_empaque_descripcion , inmprodu.prod_empaque_um , inmprodu.prod_peso_unidad_medida , inmprodu.prod_cod_clase_tam , inmprodu.prod_gramaje , inmprodu.prod_costo_cif , inmprodu.prod_ultima_entrada_doc , isnull ( inmprodu.prod_alto , 0 ) , isnull ( inmprodu.prod_ancho , 0 ) , isnull ( inmprodu.prod_largo , 0 ) FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ";
		
		public static string sqlHandle_01_27B593EB = "SELECT inamedid.medi_descripcion FROM inamedid WHERE inamedid.medi_medida =? ";
		
		public static string sqlHandle_01_9C10D08E = "SELECT cracltam.acta_descripcion FROM cracltam WHERE ( cracltam.acta_g_financiero =? ) AND ( cracltam.acta_empresa =? ) AND ( cracltam.acta_cod_clase_tam =? ) ";
		
		public static string sqlHandle_01_3B27A4BA = "SELECT dgmempre.empr_porcentaje_etiqueta FROM dgmempre WHERE ( dgmempre.empr_g_financiero =? ) AND ( dgmempre.empr_empresa =? ) ";
		
		public static string sqlHandle_01_29DF9CA7 = "select max ( tmov_secuencia ) from intmovim where tmov_g_financiero =? and tmov_empresa =? and tmov_anual =? and tmov_tipo_transaccion ='EN' ";
		
		public static string sqlHandle_01_D17F06A4 = "SELECT crmparam.mpar_bodega + crmparam.mpar_ubicacion FROM crmparam WHERE ( crmparam.mpar_g_financiero =? ) AND ( crmparam.mpar_empresa =? ) ";
		
		public static string sqlHandle_01_C9F3F0B0 = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inmprodu.prod_medida , inamedid_a.medi_cantidad , inamedid_b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_costo_fob FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ) ";
		
		public static string sqlHandle_01_E95B645F = "select count ( * ) from intmovim where tmov_g_financiero =? and tmov_empresa =? and tmov_aplicacion ='IN' and tmov_tipo_transaccion ='EN' and tmov_secuencia =? and tmov_anual =? ";
		
		public static string sqlHandle_01_D41FF9B4 = "SELECT forma_datawindow FROM inaforma WHERE ( inaforma.forma_tipo_formato ='P' ) AND ( inaforma.forma_formato_clase ='C' ) ";
		
		public static string sqlHandle_01_61DB2B6A = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inmprodu.prod_medida , inamedid_a.medi_cantidad , inamedid_b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_costo_fob , inmprodu.prod_producto_dos , inamedid_a.medi_tipo_medida FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ) ";
		
		public static string sqlHandle_01_A7FFF145 = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inmprodu.prod_medida , inamedid_a.medi_cantidad , inamedid_b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_costo_fob , inmprodu.prod_producto , inamedid_a.medi_tipo_medida FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto_dos =? ) ) ";
		
		public static string sqlHandle_01_EB322DE4 = "SELECT transito.enca_proveedor , transito.enca_documento FROM transito WHERE ( transito.enca_g_financiero =? ) AND ( transito.enca_empresa =? ) AND ( transito.enca_secuencia =? ) AND ( transito.enca_ann =? ) ";
		
		public static string sqlHandle_01_8EC89CC9 = "SELECT orden.enca_proveedor , orden.enca_documento FROM orden WHERE ( orden.enca_g_financiero =? ) AND ( orden.enca_empresa =? ) AND ( orden.enca_secuencia =? ) AND ( orden.enca_ann =? ) ";
		
		public static string sqlHandle_01_3F93FE30 = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inamedid_a.medi_cantidad , inamedid_b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_medida , inmprodu.prod_costo_promedio , inmprodu.prod_producto_dos FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ) ";
		
		public static string sqlHandle_01_6D346434 = "SELECT isnull ( orden_detalle.deta_precio_venta , 0 ) FROM orden_detalle WHERE ( orden_detalle.deta_g_financiero =? ) AND ( orden_detalle.deta_empresa =? ) AND ( orden_detalle.deta_secuencia =? ) AND ( orden_detalle.deta_ann =? ) AND ( orden_detalle.deta_linea =? ) ";
		
		public static string sqlHandle_01_D5480AA1 = "SELECT inamedid.medi_cantidad FROM orden_detalle , inamedid WHERE ( orden_detalle.deta_unidad =inamedid.medi_medida ) and ( ( orden_detalle.deta_g_financiero =? ) AND ( orden_detalle.deta_empresa =? ) AND ( orden_detalle.deta_secuencia =? ) AND ( orden_detalle.deta_ann =? ) AND ( orden_detalle.deta_linea =? ) AND ( orden_detalle.deta_referencia =? ) ) ";
		
		public static string sqlHandle_01_C41219F1 = "SELECT Count ( * ) FROM orden_detalle , orden WHERE ( orden.enca_g_financiero =orden_detalle.deta_g_financiero ) and ( orden.enca_empresa =orden_detalle.deta_empresa ) and ( orden.enca_secuencia =orden_detalle.deta_secuencia ) and ( orden.enca_ann =orden_detalle.deta_ann ) and ( orden.enca_g_financiero =? ) AND ( orden.enca_empresa =? ) and ( orden.enca_secuencia =? ) and ( orden.enca_ann =? ) and orden_detalle.deta_pasada < ( orden_detalle.deta_cantidad * ( SELECT inamedid.medi_cantidad FROM inamedid WHERE inamedid.medi_medida =orden_detalle.deta_unidad ) ) ";
		
		public static string sqlHandle_01_220BCF22 = "SELECT inamedid.medi_cantidad FROM transito_detalle , inamedid WHERE ( transito_detalle.deta_unidad =inamedid.medi_medida ) and ( ( transito_detalle.deta_g_financiero =? ) AND ( transito_detalle.deta_empresa =? ) AND ( transito_detalle.deta_secuencia =? ) AND ( transito_detalle.deta_ann =? ) AND ( transito_detalle.deta_linea =? ) AND ( transito_detalle.deta_referencia =? ) ) ";
		
		public static string sqlHandle_01_4D81B7AC = "SELECT Count ( * ) FROM transito_detalle , transito WHERE ( transito.enca_g_financiero =transito_detalle.deta_g_financiero ) and ( transito.enca_empresa =transito_detalle.deta_empresa ) and ( transito.enca_secuencia =transito_detalle.deta_secuencia ) and ( transito.enca_ann =transito_detalle.deta_ann ) and ( transito.enca_g_financiero =? ) AND ( transito.enca_empresa =? ) and ( transito.enca_secuencia =? ) and ( transito.enca_ann =? ) and transito_detalle.deta_pasada < ( transito_detalle.deta_cantidad * ( SELECT inamedid.medi_cantidad FROM inamedid WHERE inamedid.medi_medida =transito_detalle.deta_unidad ) ) ";
		
		public static string sqlHandle_01_A8EAB3C = "select count ( * ) from usuarios where usua_id =? and usua_especial =1 ";
		
		public static string sqlHandle_01_B83812DA = "SELECT isnull ( inaparam.para_gastos_admon , 0 ) , isnull ( inaparam.para_grupo_f_entrada , 0 ) , isnull ( inaparam.para_empresa_entrada , 0 ) , isnull ( inaparam.para_costea_cubicaje , 0 ) FROM inaparam WHERE ( inaparam.para_g_financiero =? ) AND ( inaparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_18A40F26 = "SELECT isnull ( dgmempre.empr_bodegas_definidas , 0 ) FROM dgmempre WHERE ( dgmempre.empr_g_financiero =? ) AND ( dgmempre.empr_empresa =? ) ";
		
		public static string sqlHandle_01_5E9A73CC = "SELECT inmprodu.prod_producto_dos FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ";
		
		public static string sqlHandle_01_16B9BD21 = "SELECT inmprodu.prod_existencia_total / isnull ( inamedid.medi_cantidad , 1 ) , prod_costo_promedio , medi_cantidad FROM inmprodu , inamedid WHERE ( inamedid.medi_medida =inmprodu.prod_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ) ";
		
		public static string sqlHandle_01_479AA9EE = "SELECT isnull ( count ( * ) , 0 ) FROM intmovim WHERE ( intmovim.tmov_g_financiero =? ) AND ( intmovim.tmov_empresa =? ) AND ( intmovim.tmov_aplicacion ='IN' ) AND ( intmovim.tmov_tipo_transaccion ='EN' ) AND ( intmovim.tmov_estado =0 ) AND ( intmovim.tmov_fecha < ? ) AND ( intmovim.tmov_secuencia <> ? ) ";
		
		public static string sqlHandle_01_5A1B18F5 = "select isnull ( para_gastos_admon , 0 ) from inaparam where para_g_financiero =? and para_empresa =? ";
		
		public static string sqlHandle_01_5FCE155 = "select sum ( ( dmov_cantidad * dmov_costo_fob ) + ( ( dmov_costo_fob / medi_cantidad ) * dmov_cant1 ) ) , sum ( intmovim.tmov_total_cargos ) from indmovim , intmovim , inamedid where ( intmovim.tmov_g_financiero =indmovim.dmov_g_financiero ) and ( intmovim.tmov_empresa =indmovim.dmov_empresa ) and ( intmovim.tmov_aplicacion =indmovim.dmov_aplicacion ) and ( intmovim.tmov_tipo_transaccion =indmovim.dmov_tipo_transaccion ) and ( intmovim.tmov_secuencia =indmovim.dmov_secuencia ) and ( intmovim.tmov_anual =indmovim.dmov_anual ) and ( intmovim.tmov_concepto =indmovim.dmov_concepto ) and ( dmov_unidad_medida =medi_medida ) and ( ( tmov_g_financiero =? ) and ( tmov_empresa =? ) and ( tmov_aplicacion ='IN' ) and ( tmov_tipo_transaccion ='EN' ) and ( tmov_concepto =? ) and ( tmov_secuencia =? ) and ( tmov_anual =? ) ) group by tmov_g_financiero , tmov_empresa , tmov_aplicacion , tmov_tipo_transaccion , tmov_concepto , tmov_secuencia , tmov_anual ";
		
		public static string sqlHandle_01_C5FA2F59 = "select dmov_producto , dmov_costo_fob , isnull ( dmov_cantidad , 0 ) + ( isnull ( dmov_cant1 , 0 ) / medi_cantidad ) , dmov_linea from indmovim , inamedid where dmov_g_financiero =? and dmov_empresa =? and dmov_aplicacion ='IN' and dmov_tipo_transaccion ='EN' and dmov_concepto =? and dmov_secuencia =? and dmov_anual =? and dmov_unidad_medida =medi_medida ";
		
		public static string sqlHandle_01_B34168A1 = "SELECT isnull ( dgmserdr.serd_mgcuenta , '' ) FROM dgmserdr WHERE ( dgmserdr.serd_g_financiero =? ) AND ( dgmserdr.serd_empresa =? ) AND ( dgmserdr.serd_transaccion ='EN' ) AND ( dgmserdr.serd_sub_trans =? ) AND ( dgmserdr.serd_aplicacion ='IN' ) ";
		
		public static string sqlHandle_01_68EEB4CF = "select tmov_estado , tmov_precio_base from intmovim WHERE tmov_g_financiero =? AND tmov_empresa =? AND tmov_aplicacion =? AND tmov_tipo_transaccion =? AND tmov_concepto =? AND tmov_secuencia =? AND tmov_anual =? ";
		
		public static string sqlHandle_01_6B5888DD = "Select para_costo_aplicado , para_sistema_costeo , para_roun , para_formato_decimal , isnull ( para_act_precio_ent , 0 ) , isnull ( para_decimal_precio , 2 ) From inaparam Where para_g_financiero =? And para_empresa =? ";
		
		public static string sqlHandle_01_BF957EA1 = "SELECT inaparam.para_formato_decimal FROM inaparam WHERE ( inaparam.para_g_financiero =? ) AND ( inaparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_3FCDC723 = "SELECT isnull ( count ( * ) , 0 ) FROM intmovim WHERE ( intmovim.tmov_g_financiero =? ) AND ( intmovim.tmov_empresa =? ) AND ( intmovim.tmov_aplicacion ='IN' ) AND ( intmovim.tmov_tipo_transaccion ='EN' ) AND ( intmovim.tmov_secuencia =? ) AND ( intmovim.tmov_anual =? ) ";
		
		public static string sqlHandle_01_E47104CF = "select max ( convert ( numeric ( 10 ) , enca_secuencia ) ) from transito where enca_g_financiero =? and enca_empresa =? and enca_ann =? ";
		
		public static string sqlHandle_01_19AED2EE = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inmprodu.prod_medida , unidades_a.medi_cantidad , unidades_b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_costo_fob , inmprodu.prod_producto FROM inmprodu , inamedid unidades_a , inamedid unidades_b WHERE ( unidades_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =unidades_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto_dos =? ) ) ";
		
		public static string sqlHandle_01_6BD38901 = "SELECT productos.prod_empaque , unidades_a.medi_cantidad , unidades_b.medi_cantidad , productos.prod_peso , productos.prod_cubicaje , productos.prod_costo FROM productos , unidades unidades_a , unidades unidades_b WHERE ( unidades_a.medi_unidad =productos.prod_unidad ) and ( productos.prod_unidad_empaque =unidades_b.medi_unidad ) and ( ( productos.prod_g_financiero =? ) AND ( productos.prod_empresa =? ) AND ( productos.prod_producto =? ) ) ";
		
		public static string sqlHandle_01_199ED0CE = "SELECT count ( * ) FROM transito_detalle WHERE ( transito_detalle.deta_g_financiero =? ) AND ( transito_detalle.deta_empresa =? ) AND ( transito_detalle.deta_referencia =? ) ";
		
		public static string sqlHandle_01_5A4AC60E = "SELECT count ( * ) FROM transito_detalle WHERE ( transito_detalle.deta_g_financiero =? ) AND ( transito_detalle.deta_empresa =? ) AND ( transito_detalle.deta_secuencia =? ) AND ( transito_detalle.deta_ann =? ) ";
		
		public static string sqlHandle_01_7E9C49AC = "SELECT productos.prod_producto , productos.prod_descripcion , productos.prod_empaque , productos.prod_unidad , productos.prod_unidad_empaque , productos.prod_peso , productos.prod_cubicaje , productos.prod_costo , productos.prod_cantidad FROM productos WHERE ( productos.prod_g_financiero =? ) AND ( productos.prod_empresa =? ) AND ( productos.prod_oc =? ) ";
		
		public static string sqlHandle_01_EAE65B14 = "SELECT unidades_a.medi_cantidad , unidades_b.medi_cantidad FROM productos , unidades unidades_a , unidades unidades_b WHERE ( unidades_a.medi_unidad =productos.prod_unidad ) and ( productos.prod_unidad_empaque =unidades_b.medi_unidad ) and ( ( productos.prod_g_financiero =? ) AND ( productos.prod_empresa =? ) AND ( productos.prod_producto =? ) ) ";
		
		public static string sqlHandle_01_4C4453FA = "SELECT tzaparam.para_ann , tzaparam.para_clave_cia , tzaparam.para_recupera_de_salida , tzaparam.para_num_pais , tzaparam.para_mod_integrado , tzaparam.para_subfactura_sn , tzaparam.para_imp_x_renglones , tzaparam.para_imp_gastos_sa_tr , tzaparam.para_imp_no_ped_traspaso , tzaparam.para_detalle_bultos , tzaparam.para_imp_total_despues_lin10 , tzaparam.para_trabaja_decimales , tzaparam.para_inserta_lin_totales , tzaparam.para_totales_en_linea_10 FROM tzaparam WHERE ( tzaparam.para_g_financiero =? ) AND ( tzaparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_B94E1A64 = "SELECT inamedid.medi_cantidad FROM inamedid WHERE inamedid.medi_medida =? ";
		
		public static string sqlHandle_01_90573FDB = "SELECT inmprodu.prod_medida , inmprodu.prod_cubicaje , inmprodu.prod_peso , inmprodu.prod_peso_unidad_medida , inmprodu.prod_empaque , inmprodu.prod_empaque_um , inmprodu.prod_empaque_descripcion FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =':is_producto' ) ";
		
		public static string sqlHandle_01_68DBC294 = "SELECT tzaparam.para_foto_grande FROM tzaparam WHERE ( tzaparam.para_g_financiero =? ) AND ( tzaparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_DBF8D762 = "SELECT tzaparam.para_foto_chica FROM tzaparam WHERE ( tzaparam.para_g_financiero =? ) AND ( tzaparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_6C4AEF2A = "SELECT tzmprint.prin_impresora , tzmprint.prin_impresora_reg FROM tzmprint WHERE ( tzmprint.prin_maquina =? ) AND ( tzmprint.prin_printer_trafico =1 ) ";
		
		public static string sqlHandle_01_994328CA = "SELECT tzaparam.para_printer_doc_comercial , tzaparam.para_puerto_doc_comercial , tzaparam.para_printer_puerto_ruta FROM tzaparam WHERE ( tzaparam.para_g_financiero =? ) AND ( tzaparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_B7974FDB = "SELECT sum ( tzdtraf1.traf_cant_bultos ) FROM tzdtraf1 WHERE ( tzdtraf1.traf_g_financiero =? ) AND ( tzdtraf1.traf_empresa =? ) AND ( tzdtraf1.traf_ent_sal =? ) AND ( tzdtraf1.traf_ann =? ) AND ( tzdtraf1.traf_pedido =? ) ";
		
		public static string sqlHandle_01_103AE097 = "select count ( * ) from tzdtraf1 where ( tzdtraf1.traf_g_financiero =? ) and ( tzdtraf1.traf_empresa =? ) and ( tzdtraf1.traf_ent_sal ='EN' ) and ( tzdtraf1.traf_pedido =? ) and ( tzdtraf1.traf_ann =? ) ";
		
		public static string sqlHandle_01_F96555E2 = "SELECT tzaparam.para_sec_entradas FROM tzaparam WHERE ( tzaparam.para_g_financiero =? ) AND ( tzaparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_14020FFE = "SELECT tzaparam.para_sec_entradas , tzaparam.para_clave_cia , tzaparam.para_num_pais FROM tzaparam WHERE ( tzaparam.para_g_financiero =? ) AND ( tzaparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_10F065A = "SELECT count ( * ) FROM tzttraf0 WHERE ( tzttraf0.ttra_g_financiero =? ) AND ( tzttraf0.ttra_empresa =? ) AND ( tzttraf0.ttra_ent_sal ='EN' ) AND ( tzttraf0.ttra_ann =? ) AND ( tzttraf0.ttra_pedido =? ) ";
		
		public static string sqlHandle_01_5056FFFF = "SELECT inmprodu.prod_arancel FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ";
		
		public static string sqlHandle_01_5F2C620E = "SELECT inaaranc.aran_descripcion FROM inaaranc WHERE inaaranc.aran_arancel =? ORDER BY inaaranc.aran_arancel ASC ";
		
		public static string sqlHandle_01_1C079EE4 = "SELECT count ( * ) FROM tzttraf0 WHERE ( tzttraf0.ttra_g_financiero =? ) AND ( tzttraf0.ttra_empresa =? ) AND ( tzttraf0.ttra_ent_sal =\"EN\" ) AND ( tzttraf0.ttra_ann =? ) AND ( tzttraf0.ttra_pedido =? ) ";
		
		public static string sqlHandle_01_D5F49881 = "SELECT count ( * ) FROM tzdtraf1 WHERE ( tzdtraf1.traf_g_financiero =? ) AND ( tzdtraf1.traf_empresa =? ) AND ( tzdtraf1.traf_ent_sal =\"EN\" ) AND ( tzdtraf1.traf_ann =? ) AND ( tzdtraf1.traf_pedido =? ) ";
		
		public static string sqlHandle_01_B5E081BD = "SELECT intmovim.tmov_documento , intmovim.tmov_fecha , intmovim.tmov_terceros , tmov_total_cargos FROM intmovim WHERE intmovim.tmov_g_financiero =? AND intmovim.tmov_empresa =? AND intmovim.tmov_tipo_transaccion ='EN' AND intmovim.tmov_aplicacion ='IN' AND intmovim.tmov_secuencia =? AND intmovim.tmov_anual =? ";
		
		public static string sqlHandle_01_13B95523 = "SELECT intmovim.tmov_secuencia , intmovim.tmov_fecha , intmovim.tmov_terceros , tmov_total_cargos FROM intmovim WHERE intmovim.tmov_g_financiero =? AND intmovim.tmov_empresa =? AND intmovim.tmov_tipo_transaccion ='EN' AND intmovim.tmov_aplicacion ='IN' AND intmovim.tmov_documento =? and intmovim.tmov_anual =? ";
		
		public static string sqlHandle_01_6E259147 = "SELECT intmovim.tmov_documento , intmovim.tmov_fecha , intmovim.tmov_terceros , tmov_total_cargos FROM intmovim WHERE intmovim.tmov_g_financiero =? AND intmovim.tmov_empresa =? AND intmovim.tmov_tipo_transaccion ='EN' AND intmovim.tmov_aplicacion ='IN' AND intmovim.tmov_secuencia =? AND intmovim.tmov_concepto =? AND intmovim.tmov_anual =? ";
		
		public static string sqlHandle_01_5B315910 = "SELECT intmovim.tmov_secuencia , intmovim.tmov_fecha , intmovim.tmov_terceros , tmov_total_cargos FROM intmovim WHERE intmovim.tmov_g_financiero =? AND intmovim.tmov_empresa =? AND intmovim.tmov_tipo_transaccion ='EN' AND intmovim.tmov_aplicacion ='IN' AND intmovim.tmov_documento =? AND intmovim.tmov_concepto =? AND intmovim.tmov_anual =? ";
		
		public static string sqlHandle_01_D3F5614 = "SELECT dgmterce.terc_descripcion , dgmterce.terc_direccion FROM dgmterce WHERE dgmterce.terc_tercero =? ";
		
		public static string sqlHandle_01_24E4CB08 = "Select count ( * ) from tzttraf0 ";
		
		public static string sqlHandle_01_D9683989 = "SELECT count ( * ) FROM tzdtraf1 WHERE ( tzdtraf1.traf_g_financiero =? ) AND ( tzdtraf1.traf_empresa =? ) AND ( tzdtraf1.traf_ann =? ) AND ( tzdtraf1.traf_ent_sal ='EN' ) AND ( tzdtraf1.traf_pedido =? ) ";
		
		public static string sqlHandle_01_65D5AAD0 = "SELECT count ( * ) FROM tzttraf0 WHERE ( tzttraf0.ttra_g_financiero =? ) AND ( tzttraf0.ttra_empresa =? ) AND ( tzttraf0.ttra_ann =? ) AND ( tzttraf0.ttra_ent_sal ='EN' ) AND ( tzttraf0.ttra_pedido =? ) ";
		
		public static string sqlHandle_01_B39B34F5 = "SELECT inaaranc.aran_arancel , inaaranc.aran_descripcion FROM inaaranc WHERE inaaranc.aran_arancel =? ORDER BY inaaranc.aran_descripcion ASC ";
		
		public static string sqlHandle_01_66A2618B = "SELECT count ( * ) FROM usuarios WHERE ( usua_id =? ) AND ( usua_clave =? ) AND ( usua_especial > 0 ) AND ( usua_estado ='A' ) ";
		
		public static string sqlHandle_01_59F9D988 = "select max ( convert ( numeric ( 10 ) , fact_no_pedido ) ) from fatdiari where fact_g_financiero =? and fact_empresa =? and fact_ann =? ";
		
		public static string sqlHandle_01_DE7CE678 = "SELECT fadvenfa.vfac_vendedor , famvende.vend_nombre + ' ' + famvende.vend_apellido nombre FROM fadvenfa , famvende WHERE ( famvende.vend_g_financiero =fadvenfa.vfac_g_financiero ) and ( famvende.vend_empresa =fadvenfa.vfac_empresa ) and ( famvende.vend_vendedor =fadvenfa.vfac_vendedor ) and ( ( fadvenfa.vfac_g_financiero =? ) AND ( fadvenfa.vfac_empresa =? ) AND ( fadvenfa.vfac_tipo =? ) AND ( fadvenfa.vfac_no_pedido =? ) AND ( fadvenfa.vfac_ann =? ) ) ";
		
		public static string sqlHandle_01_638034FD = "select count ( * ) from fadvenfa where vfac_g_financiero =? and vfac_empresa =? and vfac_tipo =? and vfac_no_pedido =? and vfac_ann =? ";
		
		public static string sqlHandle_01_6D3F7339 = "SELECT dgmserie.mser_secuencia FROM dgmserie WHERE ( dgmserie.mser_g_financiero =? ) AND ( dgmserie.mser_empresa =? ) AND ( dgmserie.mser_tipo_transaccion ='FA' ) ";
		
		public static string sqlHandle_01_44A381B0 = "select movi_comentario from cctmovim WHERE ( cctmovim.movi_g_financiero =? ) AND ( cctmovim.movi_empresa =? ) AND ( cctmovim.movi_aplicacion ='FA' ) AND ( cctmovim.movi_tipo_transaccion =? ) AND ( cctmovim.movi_documento =? ) AND ( cctmovim.movi_anno =? ) ";
		
		public static string sqlHandle_01_C00F75B9 = "SELECT max ( inmprodu.prod_descripcion ) , max ( inmprodu.prod_empaque ) , max ( inamedid_a.medi_cantidad ) , max ( inamedid_b.medi_cantidad ) , max ( inmprodu.prod_peso ) , max ( inmprodu.prod_cubicaje ) , max ( inmprodu.prod_precio_mayor ) , max ( inmprodu.prod_medida ) , max ( inmprodu.prod_costo_cif ) FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b , faddiari , fatdiari WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ) and ( faddiari.facd_g_financiero =fatdiari.fact_g_financiero ) and ( faddiari.facd_empresa =fatdiari.fact_empresa ) and ( faddiari.facd_tipo =fatdiari.fact_tipo ) and ( faddiari.facd_no_pedido =fatdiari.fact_no_pedido ) and ( faddiari.facd_ann =fatdiari.fact_ann ) and ( faddiari.facd_g_financiero =inmprodu.prod_g_financiero ) and ( faddiari.facd_empresa =inmprodu.prod_empresa ) and ( faddiari.facd_codigo_item =inmprodu.prod_producto ) and ( fatdiari.fact_cliente =? ) and ( faddiari.facd_cantidad - faddiari.facd_cantidad_cerrada > 0 ) ";
		
		public static string sqlHandle_01_AAF9C9E1 = "SELECT count ( * ) FROM fadcargo WHERE ( fadcargo.dcar_g_financiero =? ) AND ( fadcargo.dcar_empresa =? ) AND ( fadcargo.dcar_no_pedido =? ) AND ( fadcargo.dcar_ann =? ) AND ( fadcargo.dcar_tipo =? ) ";
		
		public static string sqlHandle_01_907C61D9 = "SELECT faacargo.carg_descripcion , fadcargo.dcar_monto FROM fadcargo , faacargo WHERE ( fadcargo.dcar_codigo =faacargo.carg_cargo ) and ( ( fadcargo.dcar_g_financiero =? ) AND ( fadcargo.dcar_empresa =? ) AND ( fadcargo.dcar_no_pedido =? ) AND ( fadcargo.dcar_ann =? ) AND ( fadcargo.dcar_tipo =? ) ) ";
		
		public static string sqlHandle_01_2CD10A96 = "SELECT count ( * ) FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_no_pedido =? ) AND ( fatdiari.fact_ann =? ) ";
		
		public static string sqlHandle_01_493E0AEE = "select max ( vfac_vendedor ) from fadvenfa where vfac_g_financiero =? and vfac_empresa =? and vfac_tipo =? and vfac_no_pedido =? and vfac_ann =? ";
		
		public static string sqlHandle_01_E70CB384 = "SELECT count ( * ) FROM ccmclien WHERE ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_ref_anterior =? ) ";
		
		public static string sqlHandle_01_CAA51A1E = "SELECT isnull ( faaparam.fara_ult_ultima_factura , '0' ) FROM faaparam WHERE ( faaparam.fara_g_financiero =? ) AND ( faaparam.fara_empresa =? ) ";
		
		public static string sqlHandle_01_C16525 = "SELECT count ( * ) FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_ann =? ) AND ( fatdiari.fact_no_factura =? ) ";
		
		public static string sqlHandle_01_8802DC4F = "SELECT isnull ( fatdiari.fact_condicion_pago , '' ) , fatdiari.fact_fecha , isnull ( fatdiari.fact_a_nombre , '' ) , isnull ( fatdiari.fact_a_nombre_direccion , '' ) , isnull ( fatdiari.fact_consignado , '' ) , isnull ( fatdiari.fact_monto_final , 0 ) , isnull ( fatdiari.fact_marca , '' ) , isnull ( fatdiari.fact_tipo_movimiento , '' ) , isnull ( fatdiari.fact_ruc_cliente , '' ) , fatdiari.fact_no_pedido , fatdiari.fact_fecha_despacho , isnull ( fatdiari.fact_pasaporte , '' ) , isnull ( fatdiari.fact_linea_aerea , '' ) , fatdiari.fact_metal_pendiente , isnull ( fatdiari.fact_gastos_total , 0 ) , isnull ( fatdiari.fact_factura_trafico , '' ) , isnull ( fatdiari.fact_factura_impresa , 0 ) , fatdiari.fact_fecha_impresion FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_tipo ='0' ) AND ( fatdiari.fact_ann =? ) AND ( fatdiari.fact_no_factura =? ) ";
		
		public static string sqlHandle_01_214DE7BB = "SELECT faddiari.facd_codigo_item , sum ( facd_monto_final ) monto_final , sum ( facd_cantidad_fraccion ) fraccion , max ( medi_tipo_medida ) tipo_medida , case when max ( medi_tipo_medida ) =5 then max ( inmprodu.prod_descripcion_dos ) else case when max ( inmprodu.prod_division ) ='004' then max ( cragrupo.agru_descripcion_grupo ) else max ( cradivis.adiv_nombre_trafico ) end end facd_descripcion_alterna , sum ( case when facd_cantidad < 0 and facd_rebajar =0 then 0 else case when medi_tipo_medida =10 then 0 else facd_cantidad end end ) cantidad , sum ( case when facd_cantidad < 0 and facd_rebajar =0 then 0 else case when medi_tipo_medida <> 10 then 0 else facd_cantidad end end ) cantidad_pz , max ( inmprodu.prod_division ) division , max ( inmprodu.prod_grupo ) grupo , isnull ( max ( facd_cantidad_orden ) , 0 ) cantidad_orden , isnull ( max ( facd_monto_orden ) , 0 ) monto_orden , max ( inmprodu.prod_producto_dos ) prod_original FROM faddiari , inamedid , inmprodu , inaaranc , cradivis , cragrupo WHERE ( faddiari.facd_g_financiero =inmprodu.prod_g_financiero ) AND ( faddiari.facd_empresa =inmprodu.prod_empresa ) AND ( faddiari.facd_codigo_item =inmprodu.prod_producto ) AND ( cradivis.adiv_g_financiero =inmprodu.prod_g_financiero ) AND ( cradivis.adiv_empresa =inmprodu.prod_empresa ) AND ( cradivis.adiv_codigo_div =inmprodu.prod_division ) AND ( cragrupo.agru_g_financiero =* inmprodu.prod_g_financiero ) AND ( cragrupo.agru_empresa =* inmprodu.prod_empresa ) AND ( cragrupo.agru_codigo_div =* inmprodu.prod_division ) AND ( cragrupo.agru_codigo_grupo =* inmprodu.prod_grupo ) AND ( inmprodu.prod_arancel =inaaranc.aran_arancel ) AND ( faddiari.facd_unidad_venta =inamedid.medi_medida ) and ( ( faddiari.facd_g_financiero =? ) AND ( faddiari.facd_empresa =? ) AND ( faddiari.facd_no_pedido =? ) AND ( faddiari.facd_ann =? ) ) GROUP BY faddiari.facd_codigo_item ";
		
		public static string sqlHandle_01_D9CCEFC4 = "SELECT fixing.contrato , fixing.kilates , fixing.precio_onza , fixing.cantidad_onza , fixing.mano_de_obra , fixing.calo , fixing.total_gramos FROM fixing WHERE ( fixing.cerrado =0 ) and ( ( fixing.grupo =? ) AND ( fixing.empresa =? ) AND ( fixing.fecha >= ? ) AND ( fixing.fecha <= ? ) ) ";
		
		public static string sqlHandle_01_8C814645 = "select max ( convert ( numeric ( 10 ) , prof_no_proforma ) ) from fatprofo where prof_g_financiero =? and prof_empresa =? and prof_ann =? and isnull ( prof_pdt , 0 ) =0 ";
		
		public static string sqlHandle_01_7B53B9A9 = "select max ( convert ( numeric ( 10 ) , prof_no_proforma ) ) from fatprofo where prof_g_financiero =? and prof_empresa =? and prof_ann =? ";
		
		public static string sqlHandle_01_43398B41 = "SELECT fadvenpr.vpro_vendedor , famvende.vend_nombre + ' ' + famvende.vend_apellido nombre FROM fadvenpr , famvende WHERE ( famvende.vend_g_financiero =fadvenpr.vpro_g_financiero ) and ( famvende.vend_empresa =fadvenpr.vpro_empresa ) and ( famvende.vend_vendedor =fadvenpr.vpro_vendedor ) and ( ( fadvenpr.vpro_g_financiero =? ) AND ( fadvenpr.vpro_empresa =? ) AND ( fadvenpr.vpro_no_proforma =? ) AND ( fadvenpr.vpro_ann =? ) ) ";
		
		public static string sqlHandle_01_54B0C655 = "select count ( * ) from fadvenpr where vpro_g_financiero =? and vpro_empresa =? and vpro_no_proforma =? and vpro_ann =? ";
		
		public static string sqlHandle_01_279D3C20 = "SELECT faprefactura.prof_cliente , faprefactura.prof_ruc_cliente , faprefactura.prof_condicion_pago , faprefactura.prof_tipo_venta , faprefactura.prof_tipo_movimiento , faprefactura.prof_dias_pago , faprefactura.prof_consignado , faprefactura.prof_a_nombre , faprefactura.prof_a_nombre_direccion , faprefactura.prof_despachado , faprefactura.prof_gastos_total , faprefactura.prof_monto_prof_total , faprefactura.prof_monto_final , faprefactura.prof_comentario , faprefactura.prof_fecha_despacho , faprefactura.prof_pasaporte , faprefactura.prof_linea_aerea , faprefactura.prof_vendedor , faprefactura.prof_recargo_especial FROM faprefactura WHERE ( faprefactura.prof_g_financiero =? ) AND ( faprefactura.prof_empresa =? ) AND ( faprefactura.prof_no_proforma =? ) AND ( faprefactura.prof_ann =? ) ";
		
		public static string sqlHandle_01_8031741E = "SELECT faprefacturad.dpro_linea , faprefacturad.dpro_codigo_item , faprefacturad.dpro_descripcion_alterna , faprefacturad.dpro_unidad_producto , faprefacturad.dpro_bodega , faprefacturad.dpro_costo_fob , faprefacturad.dpro_costo_cif , faprefacturad.dpro_precio_unidad_producto , faprefacturad.dpro_unidad_venta , faprefacturad.dpro_cantidad , faprefacturad.dpro_cantidad_fraccion , faprefacturad.dpro_monto_total , faprefacturad.dpro_monto_final , faprefacturad.dpro_bultos , faprefacturad.dpro_ubicacion , faprefacturad.dpro_index , faprefacturad.dpro_precio_original , faprefacturad.dpro_costo_total , faprefacturad.dpro_precio_recargo FROM faprefacturad WHERE ( faprefacturad.dpro_g_financiero =? ) AND ( faprefacturad.dpro_empresa =? ) AND ( faprefacturad.dpro_no_proforma =? ) AND ( faprefacturad.dpro_ann =? ) ";
		
		public static string sqlHandle_01_968F7531 = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inamedid_a.medi_cantidad , inamedid_b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_precio1 , inmprodu.prod_medida , inmprodu.prod_costo_promedio , inmprodu.prod_descuento_siono , inmprodu.prod_descuento , inmprodu.prod_descuento_maximo , inmprodu.prod_costo_fob , inmprodu.prod_producto_dos , inmprodu.prod_foto_dir FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ) ";
		
		public static string sqlHandle_01_247538E0 = "SELECT max ( inmprodu.prod_descripcion ) , max ( inmprodu.prod_empaque ) , max ( inamedid_a.medi_cantidad ) , max ( inamedid_b.medi_cantidad ) , max ( inmprodu.prod_peso ) , max ( inmprodu.prod_cubicaje ) , max ( inmprodu.prod_precio1 ) , max ( inmprodu.prod_medida ) , max ( inmprodu.prod_costo_promedio ) , max ( inmprodu.prod_descuento_siono ) , max ( inmprodu.prod_descuento ) , max ( inmprodu.prod_descuento_maximo ) , max ( inmprodu.prod_costo_fob ) , max ( inmprodu.prod_producto ) , max ( inmprodu.prod_producto_dos ) , max ( inmprodu.prod_foto_dir ) FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_barra =? ) ) ";
		
		public static string sqlHandle_01_5DA6AED4 = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inamedid_a.medi_cantidad , inamedid_b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_precio1 , inmprodu.prod_medida , inmprodu.prod_costo_promedio , inmprodu.prod_descuento_siono , inmprodu.prod_descuento , inmprodu.prod_descuento_maximo , inmprodu.prod_costo_fob , inmprodu.prod_producto , inmprodu.prod_foto_dir FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto_dos =? ) ) ";
		
		public static string sqlHandle_01_AD74EBF5 = "SELECT isnull ( faddiari.facd_cantidad , 0 ) , isnull ( faddiari.facd_precio_unidad_producto , 0 ) FROM faddiari , fatdiari WHERE ( fatdiari.fact_g_financiero =faddiari.facd_g_financiero ) and ( fatdiari.fact_empresa =faddiari.facd_empresa ) and ( fatdiari.fact_tipo =faddiari.facd_tipo ) and ( fatdiari.fact_no_pedido =faddiari.facd_no_pedido ) and ( fatdiari.fact_ann =faddiari.facd_ann ) and ( ( faddiari.facd_g_financiero =? ) AND ( faddiari.facd_empresa =? ) AND ( faddiari.facd_codigo_item =? ) AND ( fatdiari.fact_cliente =? ) AND ( fatdiari.fact_estado ='I' ) ) ORDER BY fatdiari.fact_fecha DESC ";
		
		public static string sqlHandle_01_E32A89A5 = "select isnull ( usua_captura_por_bulto , 0 ) from usuarios WHERE usuarios.usua_id =? ";
		
		public static string sqlHandle_01_DC307D8C = "SELECT dgmempre.empr_bodegas_definidas , empr_bodega1 , empr_bodega2 , empr_bodega3 , empr_bodega4 , empr_bodega5 , empr_bodega6 , empr_bodega7 FROM dgmempre WHERE ( dgmempre.empr_g_financiero =? ) AND ( dgmempre.empr_empresa =? ) ";
		
		public static string sqlHandle_01_A81E8DCB = "SELECT formatos.datawindows FROM formatos WHERE ( formatos.empresa =? ) AND ( formatos.tipo ='PR' ) AND ( formatos.codigo ='1' ) ";
		
		public static string sqlHandle_01_F47F020B = "SELECT count ( * ) FROM fatprofo WHERE ( fatprofo.prof_g_financiero =? ) AND ( fatprofo.prof_empresa =? ) AND ( fatprofo.prof_no_proforma =? ) AND ( fatprofo.prof_ann =? ) ";
		
		public static string sqlHandle_01_F5291B61 = "select max ( vpro_vendedor ) from fadvenpr where vpro_g_financiero =? and vpro_empresa =? and vpro_no_proforma =? and vpro_ann =? ";
		
		public static string sqlHandle_01_F340DD14 = "SELECT count ( * ) FROM ccmclien WHERE ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_ref_anterior =? ) AND ( ccmclien.clie_cuenta_mala =0 ) ";
		
		public static string sqlHandle_01_7507DD10 = "SELECT max ( inmprodu.prod_producto_dos ) FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ";
		
		public static string sqlHandle_01_B66C9875 = "SELECT isnull ( fatprofo.prof_condicion_pago , '' ) , fatprofo.prof_fecha , isnull ( fatprofo.prof_a_nombre , '' ) , isnull ( fatprofo.prof_a_nombre_direccion , '' ) , isnull ( fatprofo.prof_consignado , '' ) , isnull ( fatprofo.prof_monto_final , 0 ) , isnull ( fatprofo.prof_marca , '' ) , isnull ( fatprofo.prof_tipo_movimiento , '' ) , isnull ( fatprofo.prof_ruc_cliente , '' ) , fatprofo.prof_no_proforma , fatprofo.prof_fecha_despacho , isnull ( fatprofo.prof_pasaporte , '' ) , isnull ( fatprofo.prof_linea_aerea , '' ) , fatprofo.prof_metal_pendiente , isnull ( fatprofo.prof_gastos_total , 0 ) , isnull ( fatprofo.prof_factura_trafico , '' ) , isnull ( fatprofo.prof_factura_impresa , 0 ) , fatprofo.prof_fecha_impresion , isnull ( fatprofo.prof_monto_a_facturar , 0 ) FROM fatprofo WHERE ( fatprofo.prof_g_financiero =? ) AND ( fatprofo.prof_empresa =? ) AND ( fatprofo.prof_tipo ='0' ) AND ( fatprofo.prof_ann =? ) AND ( fatprofo.prof_no_factura =? ) ";
		
		public static string sqlHandle_01_D3FACF6D = "SELECT fadprofo.dpro_codigo_item , sum ( dpro_monto_final ) monto_final , sum ( dpro_cantidad_fraccion ) fraccion , max ( medi_tipo_medida ) tipo_medida , case when max ( medi_tipo_medida ) =5 then max ( inmprodu.prod_descripcion_dos ) else case when max ( inmprodu.prod_division ) ='004' then max ( cragrupo.agru_descripcion_grupo ) else max ( cradivis.adiv_nombre_trafico ) end end dpro_descripcion_alterna , sum ( case when dpro_cantidad < 0 and dpro_rebajar =0 then 0 else case when medi_tipo_medida =10 then 0 else dpro_cantidad end end ) cantidad , sum ( case when dpro_cantidad < 0 and dpro_rebajar =0 then 0 else case when medi_tipo_medida <> 10 then 0 else dpro_cantidad end end ) cantidad_pz , max ( inmprodu.prod_division ) division , max ( inmprodu.prod_grupo ) grupo , max ( inmprodu.prod_producto_dos ) prod_original FROM fadprofo , inamedid , inmprodu , inaaranc , cradivis , cragrupo WHERE ( fadprofo.dpro_g_financiero =inmprodu.prod_g_financiero ) AND ( fadprofo.dpro_empresa =inmprodu.prod_empresa ) AND ( fadprofo.dpro_codigo_item =inmprodu.prod_producto ) AND ( cradivis.adiv_g_financiero =inmprodu.prod_g_financiero ) AND ( cradivis.adiv_empresa =inmprodu.prod_empresa ) AND ( cradivis.adiv_codigo_div =inmprodu.prod_division ) AND ( cragrupo.agru_g_financiero =* inmprodu.prod_g_financiero ) AND ( cragrupo.agru_empresa =* inmprodu.prod_empresa ) AND ( cragrupo.agru_codigo_div =* inmprodu.prod_division ) AND ( cragrupo.agru_codigo_grupo =* inmprodu.prod_grupo ) AND ( inmprodu.prod_arancel =inaaranc.aran_arancel ) AND ( fadprofo.dpro_unidad_venta =inamedid.medi_medida ) and ( ( fadprofo.dpro_g_financiero =? ) AND ( fadprofo.dpro_empresa =? ) AND ( fadprofo.dpro_no_proforma =? ) AND ( fadprofo.dpro_ann =? ) ) GROUP BY fadprofo.dpro_codigo_item ";
		
		public static string sqlHandle_01_F773DC1B = "SELECT isnull ( inmprodu.prod_descripcion , '' ) FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ";
		
		public static string sqlHandle_01_E39F8050 = "select prof_dias_pago from fatprofo WHERE ( fatprofo.prof_g_financiero =? ) AND ( fatprofo.prof_empresa =? ) AND ( fatprofo.prof_ann =? ) AND ( fatprofo.prof_no_proforma =? ) ";
		
		public static string sqlHandle_01_851587E3 = "select max ( convert ( numeric ( 10 ) , prof_no_proforma ) ) from fatprofo2 where prof_g_financiero =? and prof_empresa =? and prof_ann =? ";
		
		public static string sqlHandle_01_3CAE9136 = "SELECT count ( * ) FROM fatprofo2 WHERE ( fatprofo2.prof_g_financiero =? ) AND ( fatprofo2.prof_empresa =? ) AND ( fatprofo2.prof_no_proforma =? ) AND ( fatprofo2.prof_ann =? ) ";
		
		public static string sqlHandle_01_1DAE31A8 = "SELECT isnull ( fatprofo2.prof_condicion_pago , '' ) , fatprofo2.prof_fecha , isnull ( fatprofo2.prof_a_nombre , '' ) , isnull ( fatprofo2.prof_a_nombre_direccion , '' ) , isnull ( fatprofo2.prof_consignado , '' ) , isnull ( fatprofo2.prof_monto_final , 0 ) , isnull ( fatprofo2.prof_marca , '' ) , isnull ( fatprofo2.prof_tipo_movimiento , '' ) , isnull ( fatprofo2.prof_ruc_cliente , '' ) , fatprofo2.prof_no_proforma , fatprofo2.prof_fecha_despacho , isnull ( fatprofo2.prof_pasaporte , '' ) , isnull ( fatprofo2.prof_linea_aerea , '' ) , fatprofo2.prof_metal_pendiente , isnull ( fatprofo2.prof_gastos_total , 0 ) , isnull ( fatprofo2.prof_factura_trafico , '' ) , isnull ( fatprofo2.prof_factura_impresa , 0 ) , fatprofo2.prof_fecha_impresion , isnull ( fatprofo2.prof_monto_a_facturar , 0 ) FROM fatprofo2 WHERE ( fatprofo2.prof_g_financiero =? ) AND ( fatprofo2.prof_empresa =? ) AND ( fatprofo2.prof_tipo ='0' ) AND ( fatprofo2.prof_ann =? ) AND ( fatprofo2.prof_no_factura =? ) ";
		
		public static string sqlHandle_01_8E5E676 = "SELECT fadprofo2.dpro_codigo_item , sum ( dpro_monto_final ) monto_final , sum ( dpro_cantidad_fraccion ) fraccion , max ( medi_tipo_medida ) tipo_medida , case when max ( medi_tipo_medida ) =5 then max ( inmprodu.prod_descripcion_dos ) else case when max ( inmprodu.prod_division ) ='004' then max ( cragrupo.agru_descripcion_grupo ) else max ( cradivis.adiv_nombre_trafico ) end end dpro_descripcion_alterna , sum ( case when dpro_cantidad < 0 and dpro_rebajar =0 then 0 else case when medi_tipo_medida =10 then 0 else dpro_cantidad end end ) cantidad , sum ( case when dpro_cantidad < 0 and dpro_rebajar =0 then 0 else case when medi_tipo_medida <> 10 then 0 else dpro_cantidad end end ) cantidad_pz , max ( inmprodu.prod_division ) division , max ( inmprodu.prod_grupo ) grupo , max ( inmprodu.prod_producto_dos ) prod_original FROM fadprofo2 , inamedid , inmprodu , inaaranc , cradivis , cragrupo WHERE ( fadprofo2.dpro_g_financiero =inmprodu.prod_g_financiero ) AND ( fadprofo2.dpro_empresa =inmprodu.prod_empresa ) AND ( fadprofo2.dpro_codigo_item =inmprodu.prod_producto ) AND ( cradivis.adiv_g_financiero =inmprodu.prod_g_financiero ) AND ( cradivis.adiv_empresa =inmprodu.prod_empresa ) AND ( cradivis.adiv_codigo_div =inmprodu.prod_division ) AND ( cragrupo.agru_g_financiero =* inmprodu.prod_g_financiero ) AND ( cragrupo.agru_empresa =* inmprodu.prod_empresa ) AND ( cragrupo.agru_codigo_div =* inmprodu.prod_division ) AND ( cragrupo.agru_codigo_grupo =* inmprodu.prod_grupo ) AND ( inmprodu.prod_arancel =inaaranc.aran_arancel ) AND ( fadprofo2.dpro_unidad_venta =inamedid.medi_medida ) and ( ( fadprofo2.dpro_g_financiero =? ) AND ( fadprofo2.dpro_empresa =? ) AND ( fadprofo2.dpro_no_proforma =? ) AND ( fadprofo2.dpro_ann =? ) ) GROUP BY fadprofo2.dpro_codigo_item ";
		
		public static string sqlHandle_01_285D1D1D = "select prof_dias_pago from fatprofo2 WHERE ( fatprofo2.prof_g_financiero =? ) AND ( fatprofo2.prof_empresa =? ) AND ( fatprofo2.prof_ann =? ) AND ( fatprofo2.prof_no_proforma =? ) ";
		
		public static string sqlHandle_01_13DA6A41 = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inamedid_a.medi_cantidad , inamedid_b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_precio1 , inmprodu.prod_medida , inmprodu.prod_costo_promedio , inmprodu.prod_descuento_siono , inmprodu.prod_descuento , inmprodu.prod_descuento_maximo , inmprodu.prod_costo_fob , inmprodu.prod_producto_dos , inmprodu.prod_foto_dir , inmprodu.prod_itbm_local , inamedid_a.medi_tipo_medida FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ) ";
		
		public static string sqlHandle_01_233672D = "SELECT max ( inmprodu.prod_descripcion ) , max ( inmprodu.prod_empaque ) , max ( inamedid_a.medi_cantidad ) , max ( inamedid_b.medi_cantidad ) , max ( inmprodu.prod_peso ) , max ( inmprodu.prod_cubicaje ) , max ( inmprodu.prod_precio1 ) , max ( inmprodu.prod_medida ) , max ( inmprodu.prod_costo_promedio ) , max ( inmprodu.prod_descuento_siono ) , max ( inmprodu.prod_descuento ) , max ( inmprodu.prod_descuento_maximo ) , max ( inmprodu.prod_costo_fob ) , max ( inmprodu.prod_producto ) , max ( inmprodu.prod_producto_dos ) , max ( inmprodu.prod_foto_dir ) , max ( inamedid_a.medi_tipo_medida ) FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_barra =? ) ) ";
		
		public static string sqlHandle_01_20AA4416 = "SELECT inmprodu.prod_itbm_local FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ";
		
		public static string sqlHandle_01_124F5329 = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inamedid_a.medi_cantidad , inamedid_b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_precio1 , inmprodu.prod_medida , inmprodu.prod_costo_promedio , inmprodu.prod_descuento_siono , inmprodu.prod_descuento , inmprodu.prod_descuento_maximo , inmprodu.prod_costo_fob , inmprodu.prod_producto , inmprodu.prod_foto_dir , inmprodu.prod_itbm_local , inamedid_a.medi_tipo_medida FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto_dos =? ) ) ";
		
		public static string sqlHandle_01_A245B2CF = "select max ( convert ( numeric ( 10 ) , pedi_no_pedido ) ) from fatpedid where pedi_g_financiero =? and pedi_empresa =? and pedi_ann =? ";
		
		public static string sqlHandle_01_2F42DAB2 = "SELECT fadvenpe.vped_vendedor , famvende.vend_nombre + ' ' + famvende.vend_apellido nombre FROM fadvenpe , famvende WHERE ( famvende.vend_g_financiero =fadvenpe.vped_g_financiero ) and ( famvende.vend_empresa =fadvenpe.vped_empresa ) and ( famvende.vend_vendedor =fadvenpe.vped_vendedor ) and ( ( fadvenpe.vped_g_financiero =? ) AND ( fadvenpe.vped_empresa =? ) AND ( fadvenpe.vped_no_pedido =? ) AND ( fadvenpe.vped_ann =? ) ) ";
		
		public static string sqlHandle_01_E69F8F96 = "select count ( * ) from fadvenpe where vped_g_financiero =? and vped_empresa =? and vped_no_pedido =? and vped_ann =? ";
		
		public static string sqlHandle_01_814E6139 = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inamedid_a.medi_cantidad , inamedid_b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_precio1 , inmprodu.prod_medida , inmprodu.prod_costo_promedio , inmprodu.prod_descuento_siono , inmprodu.prod_descuento , inmprodu.prod_descuento_maximo , inmprodu.prod_costo_fob , inmprodu.prod_producto_dos , inmprodu.prod_empaque_um FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ) ";
		
		public static string sqlHandle_01_41A7C285 = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inamedid_a.medi_cantidad , inamedid_b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_precio1 , inmprodu.prod_medida , inmprodu.prod_costo_promedio , inmprodu.prod_descuento_siono , inmprodu.prod_descuento , inmprodu.prod_descuento_maximo , inmprodu.prod_costo_fob , inmprodu.prod_producto , inmprodu.prod_empaque_um FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto_dos =? ) ) ";
		
		public static string sqlHandle_01_F12CAAF = "SELECT fatprofo.prof_cliente , fatprofo.prof_ruc_cliente , fatprofo.prof_condicion_pago , fatprofo.prof_tipo_venta , fatprofo.prof_tipo_movimiento , fatprofo.prof_dias_pago , fatprofo.prof_consignado , fatprofo.prof_a_nombre , fatprofo.prof_a_nombre_direccion , fatprofo.prof_despachado , fatprofo.prof_gastos_total , fatprofo.prof_monto_total , fatprofo.prof_monto_final , fatprofo.prof_comentario , fatprofo.prof_pasaporte , fatprofo.prof_linea_aerea , fatprofo.prof_por_descuento , fatprofo.prof_marca FROM fatprofo WHERE ( fatprofo.prof_g_financiero =? ) AND ( fatprofo.prof_empresa =? ) AND ( fatprofo.prof_no_proforma =? ) AND ( fatprofo.prof_ann =? ) ";
		
		public static string sqlHandle_01_D02AAA5 = "SELECT fadprofo.dpro_linea , fadprofo.dpro_codigo_item , fadprofo.dpro_descripcion_alterna , fadprofo.dpro_unidad_producto , fadprofo.dpro_bodega , fadprofo.dpro_costo_fob , fadprofo.dpro_costo_cif , fadprofo.dpro_precio_unidad_producto , fadprofo.dpro_unidad_venta , fadprofo.dpro_bultos , fadprofo.dpro_ubicacion , fadprofo.dpro_index , fadprofo.dpro_precio_original , fadprofo.dpro_bulto_inicio , fadprofo.dpro_bulto_fin , inmprodu.prod_producto_dos , inmprodu.prod_empaque , a.medi_cantidad , a.medi_tipo_medida , b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje FROM fadprofo , inmprodu , inamedid a , inamedid b WHERE ( fadprofo.dpro_g_financiero =inmprodu.prod_g_financiero ) AND ( fadprofo.dpro_empresa =inmprodu.prod_empresa ) AND ( fadprofo.dpro_codigo_item =inmprodu.prod_producto ) AND ( fadprofo.dpro_unidad_venta =a.medi_medida ) AND ( inmprodu.prod_empaque_um =b.medi_medida ) and ( fadprofo.dpro_g_financiero =? ) AND ( fadprofo.dpro_empresa =? ) AND ( fadprofo.dpro_no_proforma =? ) AND ( fadprofo.dpro_ann =? ) AND ( fadprofo.dpro_linea =? ) ";
		
		public static string sqlHandle_01_44DF4523 = "SELECT a.medi_cantidad FROM fadprofo , inamedid a WHERE ( fadprofo.dpro_unidad_venta =a.medi_medida ) AND ( fadprofo.dpro_g_financiero =? ) AND ( fadprofo.dpro_empresa =? ) AND ( fadprofo.dpro_no_proforma =? ) AND ( fadprofo.dpro_ann =? ) AND ( fadprofo.dpro_linea =? ) ";
		
		public static string sqlHandle_01_F30E196F = "SELECT Count ( * ) FROM fadprofo , fatprofo WHERE ( fatprofo.prof_g_financiero =fadprofo.dpro_g_financiero ) and ( fatprofo.prof_empresa =fadprofo.dpro_empresa ) and ( fatprofo.prof_no_proforma =fadprofo.dpro_no_proforma ) and ( fatprofo.prof_ann =fadprofo.dpro_ann ) and ( fatprofo.prof_g_financiero =? ) AND ( fatprofo.prof_empresa =? ) and ( fatprofo.prof_no_proforma =? ) and ( fatprofo.prof_ann =? ) and fadprofo.dpro_pasada < ( fadprofo.dpro_fraccion + fadprofo.dpro_cantidad * ( SELECT inamedid.medi_cantidad FROM inamedid WHERE inamedid.medi_medida =fadprofo.dpro_unidad_venta ) ) ";
		
		public static string sqlHandle_01_A33AD94B = "SELECT count ( * ) FROM fatpedid WHERE ( fatpedid.pedi_g_financiero =? ) AND ( fatpedid.pedi_empresa =? ) AND ( fatpedid.pedi_no_pedido =? ) AND ( fatpedid.pedi_ann =? ) ";
		
		public static string sqlHandle_01_50C204D9 = "select max ( vped_vendedor ) from fadvenpe where vped_g_financiero =? and vped_empresa =? and vped_no_pedido =? and vped_ann =? ";
		
		public static string sqlHandle_01_1B2A7853 = "SELECT isnull ( fatpedid.pedi_condicion_pago , '' ) , fatpedid.pedi_fecha , isnull ( fatpedid.pedi_a_nombre , '' ) , isnull ( fatpedid.pedi_a_nombre_direccion , '' ) , isnull ( fatpedid.pedi_consignado , '' ) , isnull ( fatpedid.pedi_monto_final , 0 ) , isnull ( fatpedid.pedi_marca , '' ) , isnull ( fatpedid.pedi_tipo_movimiento , '' ) , isnull ( fatpedid.pedi_ruc_cliente , '' ) , fatpedid.pedi_no_pedido , fatpedid.pedi_fecha_despacho , isnull ( fatpedid.pedi_pasaporte , '' ) , isnull ( fatpedid.pedi_linea_aerea , '' ) , fatpedid.pedi_metal_pendiente , isnull ( fatpedid.pedi_gastos_total , 0 ) , isnull ( fatpedid.pedi_factura_trafico , '' ) , isnull ( fatpedid.pedi_factura_impresa , 0 ) , fatpedid.pedi_fecha_impresion , isnull ( fatpedid.pedi_monto_a_facturar , 0 ) FROM fatpedid WHERE ( fatpedid.pedi_g_financiero =? ) AND ( fatpedid.pedi_empresa =? ) AND ( fatpedid.pedi_tipo ='0' ) AND ( fatpedid.pedi_ann =? ) AND ( fatpedid.pedi_no_factura =? ) ";
		
		public static string sqlHandle_01_27C4D10A = "SELECT fadpedid.dped_codigo_item , sum ( dped_monto_final ) monto_final , sum ( dped_cantidad_fraccion ) fraccion , max ( medi_tipo_medida ) tipo_medida , case when max ( medi_tipo_medida ) =5 then max ( inmprodu.prod_descripcion_dos ) else case when max ( inmprodu.prod_division ) ='004' then max ( cragrupo.agru_descripcion_grupo ) else max ( cradivis.adiv_nombre_trafico ) end end dped_descripcion_alterna , sum ( case when dped_cantidad < 0 and dped_rebajar =0 then 0 else case when medi_tipo_medida =10 then 0 else dped_cantidad end end ) cantidad , sum ( case when dped_cantidad < 0 and dped_rebajar =0 then 0 else case when medi_tipo_medida <> 10 then 0 else dped_cantidad end end ) cantidad_pz , max ( inmprodu.prod_division ) division , max ( inmprodu.prod_grupo ) grupo , max ( inmprodu.prod_producto_dos ) prod_original FROM fadpedid , inamedid , inmprodu , inaaranc , cradivis , cragrupo WHERE ( fadpedid.dped_g_financiero =inmprodu.prod_g_financiero ) AND ( fadpedid.dped_empresa =inmprodu.prod_empresa ) AND ( fadpedid.dped_codigo_item =inmprodu.prod_producto ) AND ( cradivis.adiv_g_financiero =inmprodu.prod_g_financiero ) AND ( cradivis.adiv_empresa =inmprodu.prod_empresa ) AND ( cradivis.adiv_codigo_div =inmprodu.prod_division ) AND ( cragrupo.agru_g_financiero =* inmprodu.prod_g_financiero ) AND ( cragrupo.agru_empresa =* inmprodu.prod_empresa ) AND ( cragrupo.agru_codigo_div =* inmprodu.prod_division ) AND ( cragrupo.agru_codigo_grupo =* inmprodu.prod_grupo ) AND ( inmprodu.prod_arancel =inaaranc.aran_arancel ) AND ( fadpedid.dped_unidad_venta =inamedid.medi_medida ) and ( ( fadpedid.dped_g_financiero =? ) AND ( fadpedid.dped_empresa =? ) AND ( fadpedid.dped_no_pedido =? ) AND ( fadpedid.dped_ann =? ) ) GROUP BY fadpedid.dped_codigo_item ";
		
		public static string sqlHandle_01_ABEAE049 = "SELECT dgaperio.peri_frecuencia , dgaperio.peri_valor_d_s FROM dgaperio WHERE ( dgaperio.peri_aplicacion =\"FA\" ) AND ( dgaperio.peri_periodo =? ) ";
		
		public static string sqlHandle_01_852042F7 = "SELECT ccmparam.para_fecha_ini_apli FROM ccmparam WHERE ( ccmparam.para_g_financiero =? ) AND ( ccmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_AA48DF4 = "SELECT isnull ( sum ( case prod_kilates when 24 then facd_cantidad else 0 end ) , 0 ) , isnull ( sum ( case prod_kilates when 18 then facd_cantidad else 0 end ) , 0 ) , isnull ( sum ( case prod_kilates when 10 then facd_cantidad else 0 end ) , 0 ) FROM faddiari , fatdiari , inmprodu WHERE ( fatdiari.fact_g_financiero =faddiari.facd_g_financiero ) and ( fatdiari.fact_empresa =faddiari.facd_empresa ) and ( fatdiari.fact_tipo =faddiari.facd_tipo ) and ( fatdiari.fact_no_pedido =faddiari.facd_no_pedido ) and ( fatdiari.fact_ann =faddiari.facd_ann ) and ( faddiari.facd_g_financiero =inmprodu.prod_g_financiero ) and ( faddiari.facd_empresa =inmprodu.prod_empresa ) and ( faddiari.facd_codigo_item =inmprodu.prod_producto ) and ( ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_excluir_de_reporte =0 ) AND ( fatdiari.fact_cierre_de_metal =1 ) AND ( fatdiari.fact_fecha >= ? ) AND ( fatdiari.fact_fecha <= ? ) AND ( fatdiari.fact_estado ='I' ) AND ( inmprodu.prod_kilates <> 0 ) ) ";
		
		public static string sqlHandle_01_75BFC254 = "SELECT isnull ( sum ( cantidad_onza ) , 0 ) FROM fixing WHERE ( fixing.grupo =? ) AND ( fixing.empresa =? ) AND ( fixing.fecha >= ? ) AND ( fixing.fecha <= ? ) ";
		
		public static string sqlHandle_01_EF001A38 = "SELECT fixing.kilates , sum ( fixing.valor ) / sum ( fixing.total_gramos ) FROM fixing WHERE ( fixing.grupo =? ) AND ( fixing.empresa =? ) AND ( fixing.fecha >= ? ) AND ( fixing.fecha <= ? ) group by kilates ";
		
		public static string sqlHandle_01_37B36FC3 = "SELECT isnull ( sum ( fact_monto_final ) , 0 ) , isnull ( sum ( fact_monto_fact_total ) , 0 ) , isnull ( sum ( fact_gastos_total ) , 0 ) FROM fatdiari WHERE ( ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_metal_pendiente =1 ) AND ( fact_factura_cierre =0 ) and ( fatdiari.fact_fecha >= ? ) AND ( fatdiari.fact_fecha <= ? ) AND ( fatdiari.fact_estado ='I' ) ) ";
		
		public static string sqlHandle_01_85A625B6 = "SELECT faddiari.facd_codigo_item , inamedid.medi_tipo_medida FROM faddiari , fatdiari , inamedid WHERE ( fatdiari.fact_g_financiero =faddiari.facd_g_financiero ) and ( fatdiari.fact_empresa =faddiari.facd_empresa ) and ( fatdiari.fact_tipo =faddiari.facd_tipo ) and ( fatdiari.fact_no_pedido =faddiari.facd_no_pedido ) and ( fatdiari.fact_ann =faddiari.facd_ann ) and ( faddiari.facd_unidad_venta =inamedid.medi_medida ) and ( ( faddiari.facd_g_financiero =? ) AND ( faddiari.facd_empresa =? ) AND ( fatdiari.fact_fecha >= ? ) AND ( fatdiari.fact_fecha <= ? ) AND ( fatdiari.fact_cierre_de_metal =1 ) AND ( fatdiari.fact_estado ='I' ) ) order by faddiari.facd_codigo_item desc ";
		
		public static string sqlHandle_01_7074943C = "SELECT DISTINCT terc_descripcion FROM dgmterce , fatdiari WHERE ( terc_tercero =fact_cliente ) AND ( fact_g_financiero =? ) AND ( fact_empresa =? ) ";
		
		public static string sqlHandle_01_BCAF0544 = "SELECT cctmovim.movi_documento , cctmovim.movi_tercero , cctmovim.movi_ruc_tercero , cctmovim.movi_monto , cctmovim.movi_fecha_tran , cctmovim.movi_a_nombre FROM cctmovim WHERE ( cctmovim.movi_g_financiero =? ) AND ( cctmovim.movi_empresa =? ) AND ( cctmovim.movi_aplicacion ='CC' ) AND ( cctmovim.movi_tipo_transaccion ='NC' ) AND ( cctmovim.movi_fecha_tran >= ? ) AND ( cctmovim.movi_fecha_tran <= ? ) AND ( cctmovim.movi_afecta_ganancia =1 ) ";
		
		public static string sqlHandle_01_466F2CD3 = "select max ( convert ( numeric ( 10 ) , fact_no_pedido ) ) from offatdiari where fact_g_financiero =? and fact_empresa =? and fact_ann =? ";
		
		public static string sqlHandle_01_821ABD47 = "SELECT isnull ( offatdiari.fact_costos_total , 0 ) FROM offatdiari WHERE ( offatdiari.fact_g_financiero =? ) AND ( offatdiari.fact_empresa =? ) AND ( offatdiari.fact_tipo ='0' ) AND ( offatdiari.fact_no_pedido =? ) AND ( offatdiari.fact_ann =? ) ";
		
		public static string sqlHandle_01_A9455292 = "SELECT count ( * ) FROM cotdiari WHERE ( cotdiari.diar_g_financiero =? ) AND ( cotdiari.diar_empresa =? ) AND ( cotdiari.diar_aplicacion_mg ='FA' ) AND ( cotdiari.diar_tipo_transaccion =? ) AND ( cotdiari.diar_sub_trans =? ) AND ( cotdiari.diar_no_documento =? ) AND ( cotdiari.diar_no_referencia =? ) AND ( cotdiari.diar_ann =? ) ";
		
		public static string sqlHandle_01_1CAFB0AE = "SELECT isnull ( ccmclien.clie_mg_cuenta , '' ) FROM ccmclien , dgmplanc WHERE ( ccmclien.clie_g_financiero =dgmplanc.mg_g_financiero ) and ( ccmclien.clie_empresa =dgmplanc.mg_empresa ) and ( ccmclien.clie_mg_cuenta =dgmplanc.mg_cuenta ) and ( ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_tercero =? ) ) ";
		
		public static string sqlHandle_01_AE6C9D6E = "SELECT faacargo.carg_descripcion , fadcargo.dcar_monto FROM fadcargo , faacargo WHERE ( fadcargo.dcar_g_financiero =faacargo.carg_g_financiero ) and ( fadcargo.dcar_empresa =faacargo.carg_empresa ) and ( fadcargo.dcar_codigo =faacargo.carg_cargo ) and ( ( fadcargo.dcar_g_financiero =? ) AND ( fadcargo.dcar_empresa =? ) AND ( fadcargo.dcar_no_pedido =? ) AND ( fadcargo.dcar_ann =? ) AND ( fadcargo.dcar_tipo =? ) ) ";
		
		public static string sqlHandle_01_B7DAF818 = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inamedid_a.medi_cantidad , inamedid_b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_precio_mayor , inmprodu.prod_medida , inmprodu.prod_costo_promedio , inmprodu.prod_descuento_siono , inmprodu.prod_descuento , inmprodu.prod_descuento_maximo , inmprodu.prod_costo_fob FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ) ";
		
		public static string sqlHandle_01_6969BDC2 = "SELECT faprefactura.fact_cliente , faprefactura.fact_ruc_cliente , faprefactura.fact_condicion_pago , faprefactura.fact_tipo_venta , faprefactura.fact_tipo_movimiento , faprefactura.fact_dias_pago , faprefactura.fact_consignado , faprefactura.fact_a_nombre , faprefactura.fact_a_nombre_direccion , faprefactura.fact_despachado , faprefactura.fact_gastos_total , faprefactura.fact_monto_fact_total , faprefactura.fact_monto_final , faprefactura.fact_comentario , faprefactura.fact_fecha_despacho , faprefactura.fact_pasaporte , faprefactura.fact_linea_aerea , faprefactura.fact_vendedor FROM faprefactura WHERE ( faprefactura.fact_g_financiero =? ) AND ( faprefactura.fact_empresa =? ) AND ( faprefactura.fact_no_pedido =? ) AND ( faprefactura.fact_ann =? ) ";
		
		public static string sqlHandle_01_C5CDF7D4 = "SELECT faprefacturad.facd_linea , faprefacturad.facd_codigo_item , faprefacturad.facd_descripcion_alterna , faprefacturad.facd_unidad_producto , faprefacturad.facd_bodega , faprefacturad.facd_costo_fob , faprefacturad.facd_costo_cif , faprefacturad.facd_precio_unidad_producto , faprefacturad.facd_unidad_venta , faprefacturad.facd_cantidad , faprefacturad.facd_cantidad_fraccion , faprefacturad.facd_monto_total , faprefacturad.facd_monto_final , faprefacturad.facd_bultos , faprefacturad.facd_ubicacion , faprefacturad.facd_index , faprefacturad.facd_precio_original , faprefacturad.facd_costo_total , faprefacturad.facd_precio_recargo FROM faprefacturad WHERE ( faprefacturad.facd_g_financiero =? ) AND ( faprefacturad.facd_empresa =? ) AND ( faprefacturad.facd_no_pedido =? ) AND ( faprefacturad.facd_ann =? ) ";
		
		public static string sqlHandle_01_6E120611 = "SELECT isnull ( max ( forma_datawindow ) , '' ) FROM faaforma WHERE ( faaforma.forma_g_financiero =? ) AND ( faaforma.forma_empresa =? ) AND ( faaforma.forma_tipo_formato ='FAC' ) ";
		
		public static string sqlHandle_01_827697D1 = "SELECT isnull ( facuentas.para_cuenta_exterior , '' ) , isnull ( facuentas.para_cuenta_local , '' ) , isnull ( facuentas.para_cuenta_inventarios , '' ) , isnull ( facuentas.para_cuenta_costos , '' ) , isnull ( facuentas.fara_cuenta_costos_locales , '' ) FROM facuentas WHERE ( facuentas.para_g_financiero =? ) AND ( facuentas.para_empresa =2 ) ";
		
		public static string sqlHandle_01_70A065F5 = "SELECT count ( * ) FROM offatdiari WHERE ( offatdiari.fact_g_financiero =? ) AND ( offatdiari.fact_empresa =? ) AND ( offatdiari.fact_no_pedido =? ) AND ( offatdiari.fact_ann =? ) ";
		
		public static string sqlHandle_01_59BFC9A = "SELECT count ( * ) FROM offatdiari WHERE ( offatdiari.fact_g_financiero =? ) AND ( offatdiari.fact_empresa =? ) AND ( offatdiari.fact_ann =? ) AND ( offatdiari.fact_no_factura =? ) and ( offatdiari.fact_no_pedido <> ? ) ";
		
		public static string sqlHandle_01_EB436EAD = "SELECT isnull ( offatdiari.fact_condicion_pago , '' ) , offatdiari.fact_fecha , isnull ( offatdiari.fact_a_nombre , '' ) , isnull ( offatdiari.fact_a_nombre_direccion , '' ) , isnull ( offatdiari.fact_consignado , '' ) , isnull ( offatdiari.fact_monto_final , 0 ) , isnull ( offatdiari.fact_marca , '' ) , isnull ( offatdiari.fact_tipo_movimiento , '' ) , isnull ( offatdiari.fact_ruc_cliente , '' ) , offatdiari.fact_no_pedido , offatdiari.fact_fecha_despacho , isnull ( offatdiari.fact_pasaporte , '' ) , isnull ( offatdiari.fact_linea_aerea , '' ) , offatdiari.fact_metal_pendiente , isnull ( offatdiari.fact_gastos_total , 0 ) , isnull ( offatdiari.fact_factura_trafico , '' ) , isnull ( offatdiari.fact_factura_impresa , 0 ) , offatdiari.fact_fecha_impresion , isnull ( offatdiari.fact_monto_a_facturar , 0 ) FROM offatdiari WHERE ( offatdiari.fact_g_financiero =? ) AND ( offatdiari.fact_empresa =? ) AND ( offatdiari.fact_tipo ='0' ) AND ( offatdiari.fact_ann =? ) AND ( offatdiari.fact_no_pedido =? ) ";
		
		public static string sqlHandle_01_8B0F0A18 = "SELECT offaddiari.facd_codigo_item , sum ( facd_monto_final ) monto_final , sum ( facd_cantidad_fraccion ) fraccion , max ( medi_tipo_medida ) tipo_medida , case when max ( medi_tipo_medida ) =5 then max ( inmprodu.prod_descripcion_dos ) else case when max ( inmprodu.prod_division ) ='004' then max ( cragrupo.agru_descripcion_grupo ) else max ( cradivis.adiv_nombre_trafico ) end end facd_descripcion_alterna , sum ( case when facd_cantidad < 0 and facd_rebajar =0 then 0 else case when medi_tipo_medida =10 then 0 else facd_cantidad end end ) cantidad , sum ( case when facd_cantidad < 0 and facd_rebajar =0 then 0 else case when medi_tipo_medida <> 10 then 0 else facd_cantidad end end ) cantidad_pz , max ( inmprodu.prod_division ) division , max ( inmprodu.prod_grupo ) grupo , max ( inmprodu.prod_producto_dos ) prod_original FROM offaddiari , inamedid , inmprodu , inaaranc , cradivis , cragrupo WHERE ( offaddiari.facd_g_financiero =inmprodu.prod_g_financiero ) AND ( offaddiari.facd_empresa =inmprodu.prod_empresa ) AND ( offaddiari.facd_codigo_item =inmprodu.prod_producto ) AND ( cradivis.adiv_g_financiero =inmprodu.prod_g_financiero ) AND ( cradivis.adiv_empresa =inmprodu.prod_empresa ) AND ( cradivis.adiv_codigo_div =inmprodu.prod_division ) AND ( cragrupo.agru_g_financiero =* inmprodu.prod_g_financiero ) AND ( cragrupo.agru_empresa =* inmprodu.prod_empresa ) AND ( cragrupo.agru_codigo_div =* inmprodu.prod_division ) AND ( cragrupo.agru_codigo_grupo =* inmprodu.prod_grupo ) AND ( inmprodu.prod_arancel =inaaranc.aran_arancel ) AND ( offaddiari.facd_unidad_venta =inamedid.medi_medida ) and ( ( offaddiari.facd_g_financiero =? ) AND ( offaddiari.facd_empresa =? ) AND ( offaddiari.facd_no_pedido =? ) AND ( offaddiari.facd_ann =? ) ) GROUP BY offaddiari.facd_codigo_item ";
		
		public static string sqlHandle_01_E1249095 = "SELECT isnull ( max ( faprefactura.fact_ann ) , 0 ) FROM faprefactura WHERE ( faprefactura.fact_g_financiero =? ) AND ( faprefactura.fact_empresa =? ) AND ( faprefactura.fact_no_pedido =? ) AND ( faprefactura.fact_estado ='F' ) ";
		
		public static string sqlHandle_01_5FB75200 = "SELECT favervencidos.ver_vencidos FROM favervencidos WHERE ( favervencidos.maquina =? ) ";
		
		public static string sqlHandle_01_A42BB6E = "SELECT isnull ( count ( * ) , 0 ) FROM favervencidos WHERE ( favervencidos.maquina =? ) ";
		
		public static string sqlHandle_01_7E9AED54 = "SELECT isnull ( inaparam.para_gastos_admon , 0 ) , isnull ( inaparam.para_grupo_f_entrada , 0 ) , isnull ( inaparam.para_empresa_entrada , 0 ) FROM inaparam WHERE ( inaparam.para_g_financiero =? ) AND ( inaparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_A95507F3 = "Select sum ( 1 ) from indmovim where ( indmovim.dmov_g_financiero =? ) AND ( indmovim.dmov_empresa =? ) AND ( indmovim.dmov_aplicacion ='FA' ) and ( indmovim.dmov_tipo_transaccion ='SA' ) AND ( indmovim.dmov_secuencia =? ) AND ( indmovim.dmov_anual =? ) and null =( select sum ( 1 ) from inmprodu where inmprodu.prod_g_financiero =? and inmprodu.prod_empresa =? and indmovim.dmov_producto =inmprodu.prod_producto ) ";
		
		public static string sqlHandle_01_EFD2E30A = "SELECT max ( fadprofo.dpro_index ) , max ( fadprofo.dpro_linea ) FROM fadprofo WHERE ( fadprofo.dpro_g_financiero =? ) AND ( fadprofo.dpro_empresa =? ) AND ( fadprofo.dpro_ann =? ) AND ( fadprofo.dpro_no_proforma =? ) ";
		
		public static string sqlHandle_01_57680FF1 = "SELECT fadprofo.dpro_codigo_item , fadprofo.dpro_descripcion_alterna , fadprofo.dpro_cubucaje , fadprofo.dpro_peso , fadprofo.dpro_unidad_peso , fadprofo.dpro_unidad_producto , fadprofo.dpro_precio_mayor , fadprofo.dpro_precio_menor , fadprofo.dpro_bodega , fadprofo.dpro_costo_fob , fadprofo.dpro_costo_cif , fadprofo.dpro_precio_unidad_producto , fadprofo.dpro_unidad_venta , fadprofo.dpro_cantidad , fadprofo.dpro_fraccion , fadprofo.dpro_monto_total , fadprofo.dpro_por_descuento , fadprofo.dpro_monto_final , fadprofo.dpro_usuario , fadprofo.dpro_supervisor , fadprofo.dpro_bultos , fadprofo.dpro_ubicacion , fadprofo.dpro_bulto_inicio , fadprofo.dpro_bulto_fin , fadprofo.dpro_precio_original , fadprofo.dpro_linea , fadprofo.dpro_index , fadprofo.dpro_producto_servicio , ( fadprofo.dpro_cantidad * inamedid.medi_cantidad + fadprofo.dpro_fraccion ) - dpro_pasada pasada , ( fadprofo.dpro_cantidad * fadprofo.dpro_costo_cif ) + ( ( fadprofo.dpro_costo_cif / inamedid.medi_cantidad ) * fadprofo.dpro_fraccion ) From fadprofo , inamedid Where fadprofo.dpro_g_financiero =? and fadprofo.dpro_empresa =? and fadprofo.dpro_no_proforma =? and fadprofo.dpro_ann =? and fadprofo.dpro_cantidad * inamedid.medi_cantidad + fadprofo.dpro_fraccion > dpro_pasada and fadprofo.dpro_unidad_venta =inamedid.medi_medida ORDER BY fadprofo.dpro_index ASC ";
		
		public static string sqlHandle_01_DE1D3D6C = "SELECT sum ( fadprofo.dpro_bultos ) , sum ( fadprofo.dpro_cubucaje ) , sum ( fadprofo.dpro_peso ) , sum ( fadprofo.dpro_monto_total ) , sum ( fadprofo.dpro_monto_final ) , sum ( fadprofo.dpro_costo_total ) FROM fadprofo WHERE ( fadprofo.dpro_g_financiero =? ) AND ( fadprofo.dpro_empresa =? ) AND ( fadprofo.dpro_ann =? ) AND ( fadprofo.dpro_no_proforma =? ) ";
		
		public static string sqlHandle_01_8B6917BA = "SELECT fadprofo.dpro_codigo_item , fadprofo.dpro_descripcion_alterna , fadprofo.dpro_cubucaje , fadprofo.dpro_peso , fadprofo.dpro_unidad_peso , fadprofo.dpro_unidad_producto , fadprofo.dpro_precio_mayor , fadprofo.dpro_precio_menor , fadprofo.dpro_bodega , fadprofo.dpro_costo_fob , fadprofo.dpro_costo_cif , fadprofo.dpro_precio_unidad_producto , fadprofo.dpro_unidad_venta , fadprofo.dpro_cantidad , fadprofo.dpro_fraccion , fadprofo.dpro_monto_total , fadprofo.dpro_por_descuento , fadprofo.dpro_monto_final , fadprofo.dpro_usuario , fadprofo.dpro_supervisor , fadprofo.dpro_bultos , fadprofo.dpro_ubicacion , fadprofo.dpro_bulto_inicio , fadprofo.dpro_bulto_fin , fadprofo.dpro_precio_original , fadprofo.dpro_linea , fadprofo.dpro_index , fadprofo.dpro_producto_servicio , ( fadprofo.dpro_cantidad * inamedid.medi_cantidad + fadprofo.dpro_fraccion ) - dpro_pasada pasada , ( fadprofo.dpro_cantidad * fadprofo.dpro_costo_cif ) + ( ( fadprofo.dpro_costo_cif / inamedid.medi_cantidad ) * fadprofo.dpro_fraccion ) , dpro_cubicaje_metros , dpro_peso_neto , dpro_comentario , dpro_bultos_original , dpro_modelo From fadprofo , inamedid Where fadprofo.dpro_g_financiero =? and fadprofo.dpro_empresa =? and fadprofo.dpro_no_proforma =? and fadprofo.dpro_ann =? and fadprofo.dpro_unidad_venta =inamedid.medi_medida ORDER BY fadprofo.dpro_index ASC ";
		
		public static string sqlHandle_01_E4D1BC61 = "SELECT max ( fadpedid.dped_linea ) , max ( fadpedid.dped_index ) FROM fadpedid Where fadpedid.dped_g_financiero =? and fadpedid.dped_empresa =? and fadpedid.dped_no_pedido =? and fadpedid.dped_ann =? ";
		
		public static string sqlHandle_01_258FBB51 = "SELECT fadprofo.dpro_codigo_item , fadprofo.dpro_descripcion_alterna , fadprofo.dpro_cubucaje , fadprofo.dpro_peso , fadprofo.dpro_unidad_peso , fadprofo.dpro_unidad_producto , fadprofo.dpro_precio_mayor , fadprofo.dpro_precio_menor , fadprofo.dpro_bodega , fadprofo.dpro_costo_fob , fadprofo.dpro_costo_cif , fadprofo.dpro_precio_unidad_producto , fadprofo.dpro_unidad_venta , fadprofo.dpro_cantidad , fadprofo.dpro_fraccion , fadprofo.dpro_monto_total , fadprofo.dpro_por_descuento , fadprofo.dpro_monto_final , fadprofo.dpro_usuario , fadprofo.dpro_supervisor , fadprofo.dpro_bultos , fadprofo.dpro_ubicacion , fadprofo.dpro_bulto_inicio , fadprofo.dpro_bulto_fin , fadprofo.dpro_precio_original , fadprofo.dpro_linea , fadprofo.dpro_index , ( fadprofo.dpro_cantidad * inamedid.medi_cantidad + fadprofo.dpro_fraccion ) - fadprofo.dpro_pasada pasada , ( fadprofo.dpro_cantidad * inamedid.medi_cantidad + fadprofo.dpro_fraccion ) cantidad_total , ( fadprofo.dpro_cantidad * fadprofo.dpro_costo_cif ) + ( ( fadprofo.dpro_costo_cif / inamedid.medi_cantidad ) * fadprofo.dpro_fraccion ) From fadprofo , inamedid Where fadprofo.dpro_g_financiero =? and fadprofo.dpro_empresa =? and fadprofo.dpro_no_proforma =? and fadprofo.dpro_ann =? and fadprofo.dpro_unidad_venta =inamedid.medi_medida ORDER BY fadprofo.dpro_index ASC ";
		
		public static string sqlHandle_01_2AB64A57 = "SELECT sum ( fadpedid.dped_bultos ) , sum ( fadpedid.dped_cubicaje ) , sum ( fadpedid.dped_peso ) , sum ( fadpedid.dped_monto_total ) , sum ( fadpedid.dped_monto_final ) , sum ( fadpedid.dped_costo_total ) FROM fadpedid WHERE ( fadpedid.dped_g_financiero =? ) AND ( fadpedid.dped_empresa =? ) AND ( fadpedid.dped_no_pedido =? ) AND ( fadpedid.dped_ann =? ) ";
		
		public static string sqlHandle_01_E124E1CD = "SELECT max ( faddiari.facd_linea ) , max ( faddiari.facd_index ) FROM faddiari WHERE ( faddiari.facd_g_financiero =? ) AND ( faddiari.facd_empresa =? ) AND ( faddiari.facd_tipo =? ) AND ( faddiari.facd_ann =? ) AND ( faddiari.facd_no_pedido =? ) ";
		
		public static string sqlHandle_01_B808DECD = "SELECT fadpedid.dped_codigo_item , fadpedid.dped_descripcion_alterna , fadempaq.empa_cubicaje , fadempaq.empa_peso , fadpedid.dped_unidad_peso , fadpedid.dped_unidad_producto , fadpedid.dped_precio_mayor , fadpedid.dped_precio_menor , fadpedid.dped_bodega , fadpedid.dped_costo_fob , fadpedid.dped_costo_cif , fadpedid.dped_precio_unidad_producto , fadpedid.dped_unidad_venta , fadempaq.empa_cantidad , fadpedid.dped_fraccion , fadpedid.dped_monto_total , fadpedid.dped_por_descuento , fadpedid.dped_monto_final , fadpedid.dped_usuario , fadpedid.dped_supervisor , fadempaq.empa_bultos , fadpedid.dped_ubicacion , fadempaq.empa_bulto_inicio , fadempaq.empa_bulto_fin , fadpedid.dped_precio_original , fadempaq.empa_linea , fadempaq.empa_index , fadempaq.empa_cantidad pasada , fadempaq.empa_linea_original , ( fadempaq.empa_cantidad * fadpedid.dped_costo_cif ) + ( ( fadpedid.dped_costo_cif / inamedid.medi_cantidad ) * fadpedid.dped_fraccion ) FROM fadempaq , fadpedid , fatempaq , inamedid WHERE ( fatempaq.enca_g_financiero =fadempaq.empa_g_financiero ) and ( fatempaq.enca_empresa =fadempaq.empa_empresa ) and ( fatempaq.enca_lista_empaque =fadempaq.empa_lista_empaque ) and ( fatempaq.enca_ann =fadempaq.empa_ann ) and ( fatempaq.enca_g_financiero =fadpedid.dped_g_financiero ) and ( fatempaq.enca_empresa =fadpedid.dped_empresa ) and ( fatempaq.enca_no_pedido =fadpedid.dped_no_pedido ) and ( fatempaq.enca_ann_pedido =fadpedid.dped_ann ) and ( fadpedid.dped_linea =fadempaq.empa_linea_original ) and ( fadpedid.dped_unidad_venta =inamedid.medi_medida ) and ( ( fadempaq.empa_g_financiero =? ) AND ( fadempaq.empa_empresa =? ) AND ( fadempaq.empa_lista_empaque =? ) AND ( fadempaq.empa_ann =? ) ) ORDER BY fadempaq.empa_index ASC ";
		
		public static string sqlHandle_01_2798D932 = "SELECT Count ( * ) FROM fadpedid , fatpedid WHERE ( fatpedid.pedi_g_financiero =fadpedid.dped_g_financiero ) and ( fatpedid.pedi_empresa =fadpedid.dped_empresa ) and ( fatpedid.pedi_no_pedido =fadpedid.dped_no_pedido ) and ( fatpedid.pedi_ann =fadpedid.dped_ann ) and ( fatpedid.pedi_g_financiero =? ) AND ( fatpedid.pedi_empresa =? ) and ( fatpedid.pedi_no_pedido =? ) and ( fatpedid.pedi_ann =? ) and fadpedid.dped_pasada < ( fadpedid.dped_fraccion + fadpedid.dped_cantidad * ( SELECT inamedid.medi_cantidad FROM inamedid WHERE inamedid.medi_medida =fadpedid.dped_unidad_venta ) ) ";
		
		public static string sqlHandle_01_4755AECD = "SELECT sum ( faddiari.facd_cubicaje ) , sum ( faddiari.facd_peso ) , sum ( faddiari.facd_monto_total ) , sum ( faddiari.facd_monto_final ) , sum ( faddiari.facd_bultos ) , sum ( faddiari.facd_costo_total ) FROM faddiari WHERE ( faddiari.facd_g_financiero =? ) AND ( faddiari.facd_empresa =? ) AND ( faddiari.facd_tipo =? ) AND ( faddiari.facd_no_pedido =? ) AND ( faddiari.facd_ann =? ) ";
		
		public static string sqlHandle_01_AF640A23 = "SELECT fadpedid.dped_codigo_item , fadpedid.dped_descripcion_alterna , fadempaq.empa_cubicaje , fadempaq.empa_peso , fadpedid.dped_unidad_peso , fadpedid.dped_unidad_producto , fadpedid.dped_precio_mayor , fadpedid.dped_precio_menor , fadpedid.dped_bodega , fadpedid.dped_costo_fob , fadpedid.dped_costo_cif , fadpedid.dped_precio_unidad_producto , fadpedid.dped_unidad_venta , fadpedid.dped_cantidad , fadempaq.empa_cantidad , fadpedid.dped_fraccion , fadpedid.dped_monto_total , fadpedid.dped_por_descuento , fadpedid.dped_monto_final , fadpedid.dped_usuario , fadpedid.dped_supervisor , fadempaq.empa_bultos , fadpedid.dped_ubicacion , fadempaq.empa_bulto_inicio , fadempaq.empa_bulto_fin , fadpedid.dped_precio_original , fadempaq.empa_linea , fadempaq.empa_index , fadpedid.dped_pasada , fadempaq.empa_linea_original , ( fadempaq.empa_cantidad * fadpedid.dped_costo_cif ) + ( ( fadpedid.dped_costo_cif / inamedid.medi_cantidad ) * fadpedid.dped_fraccion ) FROM fadempaq , fadpedid , fatempaq , inamedid WHERE ( fatempaq.enca_g_financiero =fadempaq.empa_g_financiero ) and ( fatempaq.enca_empresa =fadempaq.empa_empresa ) and ( fatempaq.enca_lista_empaque =fadempaq.empa_lista_empaque ) and ( fatempaq.enca_ann =fadempaq.empa_ann ) and ( fatempaq.enca_g_financiero =fadpedid.dped_g_financiero ) and ( fatempaq.enca_empresa =fadpedid.dped_empresa ) and ( fatempaq.enca_no_pedido =fadpedid.dped_no_pedido ) and ( fatempaq.enca_ann_pedido =fadpedid.dped_ann ) and ( fadpedid.dped_linea =fadempaq.empa_linea_original ) and ( fadpedid.dped_unidad_venta =inamedid.medi_medida ) and ( ( fadempaq.empa_g_financiero =? ) AND ( fadempaq.empa_empresa =? ) AND ( fadempaq.empa_lista_empaque =? ) AND ( fadempaq.empa_ann =? ) ) ORDER BY fadempaq.empa_index ASC ";
		
		public static string sqlHandle_01_8A660FCD = "SELECT sum ( fademtel.fade_cantidad ) FROM fademtel WHERE ( fademtel.fade_g_financiero =? ) AND ( fademtel.fade_empresa =? ) AND ( fademtel.fade_lista_empaque =? ) AND ( fademtel.fade_ann =? ) AND ( fademtel.fade_linea_refer =? ) ";
		
		public static string sqlHandle_01_B0BDBC9A = "SELECT inmprodu.prod_definicion FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ";
		
		public static string sqlHandle_01_90DB1794 = "SELECT Count ( * ) FROM fadempaq , fatempaq , fadpedid WHERE ( fatempaq.enca_g_financiero =fadempaq.empa_g_financiero ) and ( fatempaq.enca_empresa =fadempaq.empa_empresa ) and ( fatempaq.enca_lista_empaque =fadempaq.empa_lista_empaque ) and ( fatempaq.enca_ann =fadempaq.empa_ann ) and ( fatempaq.enca_g_financiero =fadpedid.dped_g_financiero ) and ( fatempaq.enca_empresa =fadpedid.dped_empresa ) and ( fatempaq.enca_no_pedido =fadpedid.dped_no_pedido ) and ( fatempaq.enca_ann_pedido =fadpedid.dped_ann ) and ( fadempaq.empa_linea_original =fadpedid.dped_linea ) and ( fatempaq.enca_g_financiero =? ) AND ( fatempaq.enca_empresa =? ) AND ( fatempaq.enca_lista_empaque =? ) AND ( fatempaq.enca_ann =? ) and fadpedid.dped_pasada < ( fadpedid.dped_fraccion + fadpedid.dped_cantidad * ( SELECT inamedid.medi_cantidad FROM inamedid WHERE inamedid.medi_medida =fadpedid.dped_unidad_venta ) ) ";
		
		public static string sqlHandle_01_E951E003 = "SELECT max ( faddiari.facd_linea ) , max ( faddiari.facd_index ) FROM faddiari WHERE ( faddiari.facd_g_financiero =? ) AND ( faddiari.facd_empresa =? ) AND ( faddiari.facd_ann =? ) AND ( faddiari.facd_no_pedido =? ) ";
		
		public static string sqlHandle_01_DA86A921 = "SELECT faddiari.facd_tipo , faddiari.facd_pedido_original , faddiari.facd_codigo_item , faddiari.facd_descripcion_alterna , faddiari.facd_cubicaje , faddiari.facd_peso , faddiari.facd_unidad_peso , faddiari.facd_unidad_producto , faddiari.facd_precio_mayor , faddiari.facd_precio_menor , faddiari.facd_bodega , faddiari.facd_costo_fob , faddiari.facd_costo_cif , faddiari.facd_precio_unidad_producto , faddiari.facd_unidad_venta , faddiari.facd_cantidad , faddiari.facd_cantidad_fraccion , faddiari.facd_monto_total , faddiari.facd_por_descuento , faddiari.facd_monto_final , faddiari.facd_fecha_reg , faddiari.facd_usuario , faddiari.facd_supervisor , faddiari.facd_bultos , faddiari.facd_pais , faddiari.facd_ubicacion , faddiari.facd_cant_devuelta , faddiari.facd_linea_articulo_dev , faddiari.facd_cant_asignada , faddiari.facd_validado , faddiari.facd_viene_de_pedido , faddiari.facd_bulto_inicio , faddiari.facd_bulto_fin , faddiari.facd_precio_original , faddiari.facd_costo_total , faddiari.facd_producto_servicio , faddiari.facd_ann , faddiari.facd_linea , facd_precio_descuento , ( faddiari.facd_cantidad * faddiari.facd_costo_cif ) + ( ( faddiari.facd_costo_cif / inamedid.medi_cantidad ) * faddiari.facd_cantidad_fraccion ) FROM faddiari , inamedid WHERE ( faddiari.facd_g_financiero =? ) AND ( faddiari.facd_empresa =? ) AND ( faddiari.facd_no_pedido =? ) AND ( faddiari.facd_ann =? ) and ( faddiari.facd_unidad_venta =inamedid.medi_medida ) ORDER BY faddiari.facd_index ASC ";
		
		public static string sqlHandle_01_E380823C = "SELECT faddiari.facd_codigo_item FROM faddiari WHERE ( faddiari.facd_g_financiero =? ) AND ( faddiari.facd_empresa =? ) AND ( faddiari.facd_no_pedido =? ) AND ( faddiari.facd_ann =? ) ";
		
		public static string sqlHandle_01_4E4A0F78 = "SELECT max ( faddiari.facd_linea ) , max ( faddiari.facd_index ) FROM faddiari WHERE ( faddiari.facd_empresa =? ) AND ( faddiari.facd_empresa =? ) AND ( faddiari.facd_ann =? ) AND ( faddiari.facd_tipo =? ) AND ( faddiari.facd_no_pedido =? ) ";
		
		public static string sqlHandle_01_26DE6EE7 = "SELECT isnull ( fatpedid.pedi_restaurado_por , '' ) FROM fatpedid WHERE ( fatpedid.pedi_g_financiero =? ) AND ( fatpedid.pedi_empresa =? ) AND ( fatpedid.pedi_no_pedido =? ) AND ( fatpedid.pedi_ann =? ) ";
		
		public static string sqlHandle_01_D600B9AE = "SELECT fadpedid.dped_codigo_item , fadpedid.dped_descripcion_alterna , fadpedid.dped_cubicaje , fadpedid.dped_peso , fadpedid.dped_unidad_peso , fadpedid.dped_unidad_producto , fadpedid.dped_precio_mayor , fadpedid.dped_precio_menor , fadpedid.dped_bodega , fadpedid.dped_costo_fob , fadpedid.dped_costo_cif , fadpedid.dped_precio_unidad_producto , fadpedid.dped_unidad_venta , fadpedid.dped_cantidad , fadpedid.dped_fraccion , fadpedid.dped_monto_total , fadpedid.dped_por_descuento , fadpedid.dped_monto_final , fadpedid.dped_usuario , fadpedid.dped_supervisor , fadpedid.dped_bultos , fadpedid.dped_ubicacion , fadpedid.dped_bulto_inicio , fadpedid.dped_bulto_fin , fadpedid.dped_precio_original , fadpedid.dped_linea , fadpedid.dped_index , ( fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion ) - fadpedid.dped_pasada pasada , ( fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion ) ld_cantidad_total , dped_precio_descuento , ( fadpedid.dped_cantidad * fadpedid.dped_costo_cif ) + ( ( fadpedid.dped_costo_cif / inamedid.medi_cantidad ) * fadpedid.dped_fraccion ) FROM fadpedid , inamedid Where fadpedid.dped_g_financiero =? and fadpedid.dped_empresa =? and fadpedid.dped_no_pedido =? and fadpedid.dped_ann =? and ( fadpedid.dped_unidad_venta =inamedid.medi_medida ) ORDER BY fadpedid.dped_index ASC ";
		
		public static string sqlHandle_01_7585114A = "SELECT fadpedid.dped_codigo_item , fadpedid.dped_descripcion_alterna , fadpedid.dped_cubicaje , fadpedid.dped_peso , fadpedid.dped_unidad_peso , fadpedid.dped_unidad_producto , fadpedid.dped_precio_mayor , fadpedid.dped_precio_menor , fadpedid.dped_bodega , fadpedid.dped_costo_fob , fadpedid.dped_costo_cif , fadpedid.dped_precio_unidad_producto , fadpedid.dped_unidad_venta , fadpedid.dped_cantidad , fadpedid.dped_fraccion , fadpedid.dped_monto_total , fadpedid.dped_por_descuento , fadpedid.dped_monto_final , fadpedid.dped_usuario , fadpedid.dped_supervisor , fadpedid.dped_bultos , fadpedid.dped_ubicacion , fadpedid.dped_bulto_inicio , fadpedid.dped_bulto_fin , fadpedid.dped_precio_original , fadpedid.dped_linea , fadpedid.dped_index , fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion pasada , fadpedid.dped_validado , fadpedid.dped_vendedor , fadpedid.dped_pedido_vta_detal , fadpedid.dped_promocion , fadpedid.dped_reserva_origen , fadpedid.dped_num_orden_compra , fadpedid.dped_ann_orden_compra , fadpedid.dped_num_transito , fadpedid.dped_ann_transito , fadpedid.dped_linea_orden , fadpedid.dped_linea_transito , dped_precio_descuento , ( fadpedid.dped_cantidad * fadpedid.dped_costo_cif ) + ( ( fadpedid.dped_costo_cif / inamedid.medi_cantidad ) * fadpedid.dped_fraccion ) FROM fadpedid , inamedid Where fadpedid.dped_g_financiero =? and fadpedid.dped_empresa =? and fadpedid.dped_no_pedido =? and fadpedid.dped_ann =? and ( fadpedid.dped_unidad_venta =inamedid.medi_medida ) ORDER BY fadpedid.dped_index ASC ";
		
		public static string sqlHandle_01_8B234365 = "SELECT fadpedid.dped_codigo_item , fadpedid.dped_descripcion_alterna , fadpedid.dped_cubicaje , fadpedid.dped_peso , fadpedid.dped_unidad_peso , fadpedid.dped_unidad_producto , fadpedid.dped_precio_mayor , fadpedid.dped_precio_menor , fadpedid.dped_bodega , fadpedid.dped_costo_fob , fadpedid.dped_costo_cif , fadpedid.dped_precio_unidad_producto , fadpedid.dped_unidad_venta , fadpedid.dped_cantidad , fadpedid.dped_fraccion , fadpedid.dped_monto_total , fadpedid.dped_por_descuento , fadpedid.dped_monto_final , fadpedid.dped_usuario , fadpedid.dped_supervisor , fadpedid.dped_bultos , fadpedid.dped_ubicacion , fadpedid.dped_bulto_inicio , fadpedid.dped_bulto_fin , fadpedid.dped_precio_original , fadpedid.dped_linea , fadpedid.dped_index , fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion a_pasar , fadpedid.dped_validado , fadpedid.dped_vendedor , fadpedid.dped_pedido_vta_detal , fadpedid.dped_promocion , fadpedid.dped_reserva_origen , fadpedid.dped_num_orden_compra , fadpedid.dped_ann_orden_compra , fadpedid.dped_num_transito , fadpedid.dped_ann_transito , fadpedid.dped_linea_orden , fadpedid.dped_linea_transito , ( fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion ) - dped_pasada pasada , dped_precio_descuento , ( fadpedid.dped_cantidad * fadpedid.dped_costo_cif ) + ( ( fadpedid.dped_costo_cif / inamedid.medi_cantidad ) * fadpedid.dped_fraccion ) FROM fadpedid , inamedid Where fadpedid.dped_g_financiero =? and fadpedid.dped_empresa =? and fadpedid.dped_no_pedido =? and fadpedid.dped_ann =? and fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion > dped_pasada and ( fadpedid.dped_unidad_venta =inamedid.medi_medida ) ORDER BY fadpedid.dped_index ASC ";
		
		public static string sqlHandle_01_6F499D5F = "SELECT Count ( * ) FROM ccmclien WHERE ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) ";
		
		public static string sqlHandle_01_7910ECD = "SELECT faaparam.fara_ult_pedido FROM faaparam WHERE ( faaparam.fara_g_financiero =? ) AND ( faaparam.fara_empresa =? ) ";
		
		public static string sqlHandle_01_8E2B4E95 = "SELECT sum ( facd_monto_final ) , sum ( facd_cantidad ) FROM faddiari , fatdiari , inmprodu WHERE ( fatdiari.fact_g_financiero =faddiari.facd_g_financiero ) and ( fatdiari.fact_empresa =faddiari.facd_empresa ) and ( fatdiari.fact_tipo =faddiari.facd_tipo ) and ( fatdiari.fact_no_pedido =faddiari.facd_no_pedido ) and ( fatdiari.fact_ann =faddiari.facd_ann ) and ( inmprodu.prod_g_financiero =faddiari.facd_g_financiero ) and ( inmprodu.prod_empresa =faddiari.facd_empresa ) and ( inmprodu.prod_producto =faddiari.facd_codigo_item ) and ( fatdiari.fact_estado ='I' ) AND ( ( faddiari.facd_g_financiero =? ) AND ( faddiari.facd_empresa =? ) AND ( fatdiari.fact_cliente =? ) AND ( fatdiari.fact_fecha >= ? ) AND ( fatdiari.fact_fecha <= ? ) ) ";
		
		public static string sqlHandle_01_14358FCB = "SELECT inmprodu.prod_existencia_total , inmprodu.prod_reserva_total , inmprodu.prod_descripcion , inmprodu.prod_medida , inmprodu.prod_foto_dir FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ";
		
		public static string sqlHandle_01_8BF5A0DA = "SELECT count ( * ) FROM fadcardes WHERE ( fadcardes.card_g_financiero =? ) AND ( fadcardes.card_empresa =? ) AND ( fadcardes.card_tipo =? ) AND ( fadcardes.card_no_pedido =? ) AND ( fadcardes.card_ann =? ) AND ( fadcardes.card_codigo =? ) ";
		
		public static string sqlHandle_01_87F7742A = "SELECT fadcardes.card_descripcion FROM fadcardes WHERE ( fadcardes.card_g_financiero =? ) AND ( fadcardes.card_empresa =? ) AND ( fadcardes.card_tipo =? ) AND ( fadcardes.card_no_pedido =? ) AND ( fadcardes.card_ann =? ) AND ( fadcardes.card_codigo =? ) ";
		
		public static string sqlHandle_01_D3CABBD3 = "SELECT faacargo.carg_sobre , faacargo.carg_porcentaje , faacargo.carg_variante , faacargo.carg_descripcion FROM faacargo WHERE faacargo.carg_g_financiero =? AND faacargo.carg_empresa =? and faacargo.carg_cargo =? ";
		
		public static string sqlHandle_01_3607325D = "SELECT faacargo.carg_sobre , faacargo.carg_porcentaje , faacargo.carg_variante , faacargo.carg_descripcion , faacargo.carg_cargo FROM faacargo WHERE ( faacargo.carg_g_financiero =? ) AND ( faacargo.carg_empresa =? ) ";
		
		public static string sqlHandle_01_36F84C01 = "SELECT faacargo.carg_sobre , faacargo.carg_porcentaje , faacargo.carg_variante , faacargo.carg_descripcion , faacargo.carg_cargo FROM faacargo WHERE faacargo.carg_prede =1 And ( faacargo.carg_g_financiero =? ) AND ( faacargo.carg_empresa =? ) ";
		
		public static string sqlHandle_01_E4598AB4 = "SELECT count ( * ) FROM faacargo WHERE ( faacargo.carg_g_financiero =? ) AND ( faacargo.carg_empresa =? ) ";
		
		public static string sqlHandle_01_1A970AA3 = "SELECT count ( * ) FROM fadcargo WHERE ( fadcargo.dcar_g_financiero =? ) AND ( fadcargo.dcar_empresa =? ) ";
		
		public static string sqlHandle_01_73D79FA7 = "SELECT fatdiari.fact_actualizo_cargos FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_tipo =? ) AND ( fatdiari.fact_no_pedido =? ) AND ( fatdiari.fact_ann =? ) ";
		
		public static string sqlHandle_01_EA139633 = "select max ( fact_no_pedido ) from fatdiari where fact_g_financiero =? and fact_empresa =? and fact_ann =? ";
		
		public static string sqlHandle_01_BCD42A68 = "select max ( fact_no_pedido ) from fatdiari where fact_g_financiero =? and fact_empresa =? and fact_ann =? and isnull ( fact_pdt , 0 ) =0 ";
		
		public static string sqlHandle_01_DA74DE04 = "SELECT isnull ( fatdiari.fact_costos_total , 0 ) FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_no_pedido =? ) AND ( fatdiari.fact_ann =? ) ";
		
		public static string sqlHandle_01_39640F53 = "SELECT dgmserdr.serd_mgcuenta FROM dgmserdr WHERE ( dgmserdr.serd_g_financiero =? ) AND ( dgmserdr.serd_empresa =? ) AND ( dgmserdr.serd_transaccion =? ) AND ( dgmserdr.serd_sub_trans =? ) AND ( dgmserdr.serd_aplicacion ='FA' ) ";
		
		public static string sqlHandle_01_8D435BF6 = "SELECT isnull ( inmprodu.prod_existencia_total , 0 ) FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ";
		
		public static string sqlHandle_01_CF3C6D04 = "SELECT faprefactura.fact_cliente , faprefactura.fact_ruc_cliente , faprefactura.fact_condicion_pago , faprefactura.fact_tipo_venta , faprefactura.fact_tipo_movimiento , faprefactura.fact_dias_pago , faprefactura.fact_consignado , faprefactura.fact_a_nombre , faprefactura.fact_a_nombre_direccion , faprefactura.fact_despachado , faprefactura.fact_gastos_total , faprefactura.fact_monto_fact_total , faprefactura.fact_monto_final , faprefactura.fact_comentario , faprefactura.fact_fecha_despacho , faprefactura.fact_pasaporte , faprefactura.fact_linea_aerea , faprefactura.fact_vendedor , faprefactura.fact_recargo_especial FROM faprefactura WHERE ( faprefactura.fact_g_financiero =? ) AND ( faprefactura.fact_empresa =? ) AND ( faprefactura.fact_no_pedido =? ) AND ( faprefactura.fact_ann =? ) ";
		
		public static string sqlHandle_01_9E33DB6C = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inamedid_a.medi_cantidad , inamedid_b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_precio1 , inmprodu.prod_medida , inmprodu.prod_costo_promedio , inmprodu.prod_descuento_siono , inmprodu.prod_descuento , inmprodu.prod_descuento_maximo , inmprodu.prod_costo_fob , inmprodu.prod_producto_dos , inmprodu.prod_metros_cubicos FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ) ";
		
		public static string sqlHandle_01_A2EEA1B4 = "SELECT max ( inmprodu.prod_descripcion ) , max ( inmprodu.prod_empaque ) , max ( inamedid_a.medi_cantidad ) , max ( inamedid_b.medi_cantidad ) , max ( inmprodu.prod_peso ) , max ( inmprodu.prod_cubicaje ) , max ( inmprodu.prod_precio1 ) , max ( inmprodu.prod_medida ) , max ( inmprodu.prod_costo_promedio ) , max ( inmprodu.prod_descuento_siono ) , max ( inmprodu.prod_descuento ) , max ( inmprodu.prod_descuento_maximo ) , max ( inmprodu.prod_costo_fob ) , max ( inmprodu.prod_producto ) , max ( inmprodu.prod_producto_dos ) , max ( inmprodu.prod_metros_cubicos ) FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_barra =? ) ) ";
		
		public static string sqlHandle_01_659BCDF3 = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inamedid_a.medi_cantidad , inamedid_b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_precio1 , inmprodu.prod_medida , inmprodu.prod_costo_promedio , inmprodu.prod_descuento_siono , inmprodu.prod_descuento , inmprodu.prod_descuento_maximo , inmprodu.prod_costo_fob , inmprodu.prod_producto , inmprodu.prod_metros_cubicos FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto_dos =? ) ) ";
		
		public static string sqlHandle_01_B2F3B7D9 = "SELECT fatdiari.fact_cliente , fatdiari.fact_ruc_cliente , fatdiari.fact_condicion_pago , fatdiari.fact_tipo_movimiento , fatdiari.fact_dias_pago , fatdiari.fact_tipo_venta , fatdiari.fact_consignado , fatdiari.fact_a_nombre , fatdiari.fact_a_nombre_direccion , fatdiari.fact_despachado , fatdiari.fact_gastos_total , fatdiari.fact_monto_fact_total , fatdiari.fact_monto_final , fatdiari.fact_comentario , fatdiari.fact_no_traspaso , fatdiari.fact_marca , fatdiari.fact_por_descuento FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_no_pedido =? ) AND ( fatdiari.fact_ann =? ) ";
		
		public static string sqlHandle_01_A1AD3D8B = "SELECT isnull ( fadvenfa.vfac_vendedor , 0 ) FROM fadvenfa WHERE ( fadvenfa.vfac_g_financiero =? ) AND ( fadvenfa.vfac_empresa =? ) AND ( fadvenfa.vfac_no_pedido =? ) AND ( fadvenfa.vfac_ann =? ) ";
		
		public static string sqlHandle_01_E5DB25CE = "SELECT faddiari.facd_linea , faddiari.facd_codigo_item , faddiari.facd_descripcion_alterna , faddiari.facd_cubicaje , faddiari.facd_peso , faddiari.facd_unidad_peso , faddiari.facd_unidad_producto , faddiari.facd_precio_mayor , faddiari.facd_precio_menor , faddiari.facd_bodega , faddiari.facd_costo_fob , faddiari.facd_costo_cif , faddiari.facd_precio_unidad_producto , faddiari.facd_unidad_venta , faddiari.facd_cantidad , faddiari.facd_cantidad_fraccion , faddiari.facd_monto_total , faddiari.facd_por_descuento , faddiari.facd_monto_final , faddiari.facd_bultos , faddiari.facd_ubicacion , faddiari.facd_index , faddiari.facd_bulto_inicio , faddiari.facd_bulto_fin , faddiari.facd_precio_original , faddiari.facd_costo_total , faddiari.facd_modelo , faddiari.facd_bultos_original , faddiari.facd_peso_neto , faddiari.facd_cubicaje_metros FROM faddiari WHERE ( faddiari.facd_g_financiero =? ) AND ( faddiari.facd_empresa =? ) AND ( faddiari.facd_no_pedido =? ) AND ( faddiari.facd_ann =? ) ";
		
		public static string sqlHandle_01_12F2903B = "SELECT fadcargo.dcar_codigo , fadcargo.dcar_monto FROM fadcargo WHERE ( fadcargo.dcar_g_financiero =? ) AND ( fadcargo.dcar_empresa =? ) AND ( fadcargo.dcar_no_pedido =? ) AND ( fadcargo.dcar_ann =? ) AND ( fadcargo.dcar_monto > 0 ) ";
		
		public static string sqlHandle_01_C9D91E31 = "SELECT fatpedid.pedi_cliente , fatpedid.pedi_ruc_cliente , fatpedid.pedi_condicion_pago , fatpedid.pedi_tipo_venta , fatpedid.pedi_tipo_movimiento , fatpedid.pedi_dias_pago , fatpedid.pedi_consignado , fatpedid.pedi_a_nombre , fatpedid.pedi_a_nombre_direccion , fatpedid.pedi_despachado , fatpedid.pedi_gastos_total , fatpedid.pedi_monto_total , fatpedid.pedi_monto_final , fatpedid.pedi_comentario , fatpedid.pedi_pasaporte , fatpedid.pedi_linea_aerea , fatpedid.pedi_por_descuento , fatpedid.pedi_marca FROM fatpedid WHERE ( fatpedid.pedi_g_financiero =? ) AND ( fatpedid.pedi_empresa =? ) AND ( fatpedid.pedi_no_pedido =? ) AND ( fatpedid.pedi_ann =? ) ";
		
		public static string sqlHandle_01_C73183C7 = "SELECT fadpedid.dped_linea , fadpedid.dped_codigo_item , fadpedid.dped_descripcion_alterna , fadpedid.dped_unidad_producto , fadpedid.dped_bodega , fadpedid.dped_costo_fob , fadpedid.dped_costo_cif , fadpedid.dped_precio_unidad_producto , fadpedid.dped_unidad_venta , fadpedid.dped_bultos , fadpedid.dped_ubicacion , fadpedid.dped_index , fadpedid.dped_precio_original , fadpedid.dped_bulto_inicio , fadpedid.dped_bulto_fin , inmprodu.prod_producto_dos , inmprodu.prod_empaque , a.medi_cantidad , a.medi_tipo_medida , b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje FROM fadpedid , inmprodu , inamedid a , inamedid b WHERE ( fadpedid.dped_g_financiero =inmprodu.prod_g_financiero ) AND ( fadpedid.dped_empresa =inmprodu.prod_empresa ) AND ( fadpedid.dped_codigo_item =inmprodu.prod_producto ) AND ( fadpedid.dped_unidad_venta =a.medi_medida ) AND ( inmprodu.prod_empaque_um =b.medi_medida ) and ( fadpedid.dped_g_financiero =? ) AND ( fadpedid.dped_empresa =? ) AND ( fadpedid.dped_no_pedido =? ) AND ( fadpedid.dped_ann =? ) AND ( fadpedid.dped_linea =? ) ";
		
		public static string sqlHandle_01_BE10DEB7 = "SELECT a.medi_cantidad FROM fadpedid , inamedid a WHERE ( fadpedid.dped_unidad_venta =a.medi_medida ) AND ( fadpedid.dped_g_financiero =? ) AND ( fadpedid.dped_empresa =? ) AND ( fadpedid.dped_no_pedido =? ) AND ( fadpedid.dped_ann =? ) AND ( fadpedid.dped_linea =? ) ";
		
		public static string sqlHandle_01_1A8ED771 = "SELECT indmovim.dmov_linea , indmovim.dmov_producto , inmprodu.prod_descripcion , indmovim.dmov_unidad_medida , indmovim.dmov_bodega , indmovim.dmov_costo_fob , indmovim.dmov_costo_cif , indmovim.dmov_precio , indmovim.dmov_unidad_medida , indmovim.dmov_bulto , indmovim.dmov_ubicacion , indmovim.dmov_linea , indmovim.dmov_precio , 0 , 0 , inmprodu.prod_producto_dos , inmprodu.prod_empaque , a.medi_cantidad , a.medi_tipo_medida , b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje FROM indmovim , inmprodu , inamedid a , inamedid b WHERE ( indmovim.dmov_g_financiero =inmprodu.prod_g_financiero ) AND ( indmovim.dmov_empresa =inmprodu.prod_empresa ) AND ( indmovim.dmov_producto =inmprodu.prod_producto ) AND ( indmovim.dmov_unidad_medida =a.medi_medida ) AND ( inmprodu.prod_empaque_um =b.medi_medida ) and ( indmovim.dmov_g_financiero =? ) AND ( indmovim.dmov_empresa =? ) AND ( indmovim.dmov_secuencia =? ) AND ( indmovim.dmov_anual =? ) AND ( indmovim.dmov_aplicacion ='IN' ) AND ( indmovim.dmov_tipo_transaccion ='EN' ) AND ( indmovim.dmov_linea =? ) ";
		
		public static string sqlHandle_01_F66EEEF1 = "SELECT a.medi_cantidad FROM indmovim , inamedid a WHERE ( indmovim.dmov_unidad_medida =a.medi_medida ) AND ( indmovim.dmov_g_financiero =? ) AND ( indmovim.dmov_empresa =? ) AND ( indmovim.dmov_secuencia =? ) AND ( indmovim.dmov_anual =? ) AND ( indmovim.dmov_linea =? ) AND ( indmovim.dmov_aplicacion ='IN' ) AND ( indmovim.dmov_tipo_transaccion ='EN' ) ";
		
		public static string sqlHandle_01_ED9E1B33 = "SELECT count ( * ) FROM indmovim , intmovim WHERE ( intmovim.tmov_g_financiero =indmovim.dmov_g_financiero ) and ( intmovim.tmov_empresa =indmovim.dmov_empresa ) and ( intmovim.tmov_aplicacion =indmovim.dmov_aplicacion ) and ( intmovim.tmov_tipo_transaccion =indmovim.dmov_tipo_transaccion ) and ( intmovim.tmov_secuencia =indmovim.dmov_secuencia ) and ( intmovim.tmov_concepto =indmovim.dmov_concepto ) and ( intmovim.tmov_anual =indmovim.dmov_anual ) and ( ( indmovim.dmov_g_financiero =? ) AND ( indmovim.dmov_empresa =? ) AND ( indmovim.dmov_aplicacion ='IN' ) AND ( indmovim.dmov_tipo_transaccion ='EN' ) AND ( indmovim.dmov_secuencia =? ) AND ( indmovim.dmov_anual =? ) AND indmovim.dmov_pasada < ( indmovim.dmov_cant1 + indmovim.dmov_cantidad * ( SELECT inamedid.medi_cantidad FROM inamedid WHERE inamedid.medi_medida =indmovim.dmov_unidad_medida ) ) ) ";
		
		public static string sqlHandle_01_2F283ACD = "SELECT isnull ( facuentas.para_cuenta_exterior , '' ) , isnull ( facuentas.para_cuenta_local , '' ) , isnull ( facuentas.para_cuenta_inventarios , '' ) , isnull ( facuentas.para_cuenta_costos , '' ) , isnull ( facuentas.fara_cuenta_costos_locales , '' ) , isnull ( facuentas.para_cuenta_descuento , '' ) , isnull ( facuentas.para_cuenta_cargos , '' ) , isnull ( facuentas.para_devolucion_ventas , '' ) FROM facuentas WHERE ( facuentas.para_g_financiero =? ) AND ( facuentas.para_empresa =? ) ";
		
		public static string sqlHandle_01_24CA90FC = "SELECT isnull ( count ( * ) , 0 ) FROM usuarios WHERE ( usuarios.usua_id =? ) AND ( usuarios.usua_usuario_bodega =1 ) ";
		
		public static string sqlHandle_01_FA011437 = "SELECT isnull ( max ( fatdiari.fact_no_factura ) , '' ) FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_no_pedido =? ) AND ( fatdiari.fact_ann =? ) AND ( fatdiari.fact_estado ='I' ) ";
		
		public static string sqlHandle_01_8C6BDE56 = "SELECT count ( * ) FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_no_factura =? ) AND ( fatdiari.fact_ann =? ) and ( fatdiari.fact_no_pedido <> ? ) ";
		
		public static string sqlHandle_01_A4E1F724 = "SELECT isnull ( inmprodu.prod_costo_fob , 0 ) , isnull ( inmprodu.prod_costo_promedio , 0 ) FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ";
		
		public static string sqlHandle_01_1942F83F = "SELECT isnull ( faddiari.facd_cantidad , 0 ) FROM faddiari WHERE ( faddiari.facd_g_financiero =? ) AND ( faddiari.facd_empresa =? ) AND ( faddiari.facd_no_pedido =? ) AND ( faddiari.facd_ann =? ) AND ( faddiari.facd_linea =? ) ";
		
		public static string sqlHandle_01_82960AF7 = "SELECT case when ? =1 then isnull ( faaparam.fara_ult_devolucion , '0' ) else isnull ( faaparam.fara_ult_ultima_factura , '0' ) end FROM faaparam WHERE ( faaparam.fara_g_financiero =? ) AND ( faaparam.fara_empresa =? ) ";
		
		public static string sqlHandle_01_2F574233 = "SELECT count ( * ) FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_ann =? ) AND ( fatdiari.fact_no_factura =? ) and ( fatdiari.fact_no_pedido <> ? ) and fact_nota_credito =0 ";
		
		public static string sqlHandle_01_97EB2556 = "SELECT count ( * ) FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_ann =? ) AND ( fatdiari.fact_no_factura =? ) and ( fatdiari.fact_no_pedido <> ? ) and fact_nota_credito =1 ";
		
		public static string sqlHandle_01_6F590F16 = "SELECT count ( * ) FROM indmovim , intmovim WHERE ( intmovim.tmov_g_financiero =indmovim.dmov_g_financiero ) and ( intmovim.tmov_empresa =indmovim.dmov_empresa ) and ( intmovim.tmov_aplicacion =indmovim.dmov_aplicacion ) and ( intmovim.tmov_tipo_transaccion =indmovim.dmov_tipo_transaccion ) and ( intmovim.tmov_secuencia =indmovim.dmov_secuencia ) and ( intmovim.tmov_anual =indmovim.dmov_anual ) and ( intmovim.tmov_concepto =indmovim.dmov_concepto ) and ( ( indmovim.dmov_g_financiero =? ) AND ( indmovim.dmov_empresa =? ) AND ( indmovim.dmov_aplicacion ='IN' ) AND ( indmovim.dmov_tipo_transaccion ='EN' ) AND ( indmovim.dmov_producto =? ) AND ( intmovim.tmov_estado =0 ) ) ";
		
		public static string sqlHandle_01_A7E338A2 = "SELECT isnull ( fatdiari.fact_condicion_pago , '' ) , fatdiari.fact_fecha , isnull ( fatdiari.fact_a_nombre , '' ) , isnull ( fatdiari.fact_a_nombre_direccion , '' ) , isnull ( fatdiari.fact_consignado , '' ) , isnull ( fatdiari.fact_monto_final , 0 ) , isnull ( fatdiari.fact_marca , '' ) , isnull ( fatdiari.fact_tipo_movimiento , '' ) , isnull ( fatdiari.fact_ruc_cliente , '' ) , fatdiari.fact_no_pedido , fatdiari.fact_fecha_despacho , isnull ( fatdiari.fact_pasaporte , '' ) , isnull ( fatdiari.fact_linea_aerea , '' ) , fatdiari.fact_metal_pendiente , isnull ( fatdiari.fact_gastos_total , 0 ) , isnull ( fatdiari.fact_factura_trafico , '' ) , isnull ( fatdiari.fact_factura_impresa , 0 ) , fatdiari.fact_fecha_impresion , isnull ( fatdiari.fact_monto_a_facturar , 0 ) FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_tipo ='0' ) AND ( fatdiari.fact_ann =? ) AND ( fatdiari.fact_no_factura =? ) ";
		
		public static string sqlHandle_01_F1E47E75 = "SELECT faddiari.facd_codigo_item , sum ( facd_monto_final ) monto_final , sum ( facd_cantidad_fraccion ) fraccion , max ( medi_tipo_medida ) tipo_medida , case when max ( medi_tipo_medida ) =5 then max ( inmprodu.prod_descripcion_dos ) else case when max ( inmprodu.prod_division ) ='004' then max ( cragrupo.agru_descripcion_grupo ) else max ( cradivis.adiv_nombre_trafico ) end end facd_descripcion_alterna , sum ( case when facd_cantidad < 0 and facd_rebajar =0 then 0 else case when medi_tipo_medida =10 then 0 else facd_cantidad end end ) cantidad , sum ( case when facd_cantidad < 0 and facd_rebajar =0 then 0 else case when medi_tipo_medida <> 10 then 0 else facd_cantidad end end ) cantidad_pz , max ( inmprodu.prod_division ) division , max ( inmprodu.prod_grupo ) grupo , max ( inmprodu.prod_producto_dos ) prod_original FROM faddiari , inamedid , inmprodu , inaaranc , cradivis , cragrupo WHERE ( faddiari.facd_g_financiero =inmprodu.prod_g_financiero ) AND ( faddiari.facd_empresa =inmprodu.prod_empresa ) AND ( faddiari.facd_codigo_item =inmprodu.prod_producto ) AND ( cradivis.adiv_g_financiero =inmprodu.prod_g_financiero ) AND ( cradivis.adiv_empresa =inmprodu.prod_empresa ) AND ( cradivis.adiv_codigo_div =inmprodu.prod_division ) AND ( cragrupo.agru_g_financiero =* inmprodu.prod_g_financiero ) AND ( cragrupo.agru_empresa =* inmprodu.prod_empresa ) AND ( cragrupo.agru_codigo_div =* inmprodu.prod_division ) AND ( cragrupo.agru_codigo_grupo =* inmprodu.prod_grupo ) AND ( inmprodu.prod_arancel =inaaranc.aran_arancel ) AND ( faddiari.facd_unidad_venta =inamedid.medi_medida ) and ( ( faddiari.facd_g_financiero =? ) AND ( faddiari.facd_empresa =? ) AND ( faddiari.facd_no_pedido =? ) AND ( faddiari.facd_ann =? ) ) GROUP BY faddiari.facd_codigo_item ";
		
		public static string sqlHandle_01_17BA71C9 = "SELECT isnull ( count ( * ) , 0 ) FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_no_pedido =? ) AND ( fatdiari.fact_ann =? ) ";
		
		public static string sqlHandle_01_971C9DEC = "select fact_dias_pago from fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_ann =? ) AND ( fatdiari.fact_no_pedido =? ) ";
		
		public static string sqlHandle_01_752F8F82 = "SELECT isnull ( formatos.datawindows , '' ) FROM formatos WHERE formatos.codigo ='1' ";
		
		public static string sqlHandle_01_CD18E4A2 = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inmprodu.prod_medida , inamedid_a.medi_cantidad , inamedid_b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_precio_mayor , inmprodu.prod_medida , inmprodu.prod_costo_cif FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ) ";
		
		public static string sqlHandle_01_8180E216 = "SELECT count ( * ) FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_ann =? ) AND ( fatdiari.fact_no_factura =? ) and ( fatdiari.fact_estado ='I' ) ";
		
		public static string sqlHandle_01_3B47BFDC = "SELECT isnull ( fatdiari.fact_costos_total , 0 ) FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_tipo ='0' ) AND ( fatdiari.fact_no_pedido =? ) AND ( fatdiari.fact_ann =? ) ";
		
		public static string sqlHandle_01_5F6CFA13 = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inamedid_a.medi_cantidad , inamedid_b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_precio1 , inmprodu.prod_medida , inmprodu.prod_costo_promedio , inmprodu.prod_descuento_siono , inmprodu.prod_descuento , inmprodu.prod_descuento_maximo , inmprodu.prod_costo_fob , inmprodu.prod_producto_dos , inmprodu.prod_itbm_local , inamedid_a.medi_tipo_medida FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ) ";
		
		public static string sqlHandle_01_A076C97F = "SELECT max ( inmprodu.prod_descripcion ) , max ( inmprodu.prod_empaque ) , max ( inamedid_a.medi_cantidad ) , max ( inamedid_b.medi_cantidad ) , max ( inmprodu.prod_peso ) , max ( inmprodu.prod_cubicaje ) , max ( inmprodu.prod_precio1 ) , max ( inmprodu.prod_medida ) , max ( inmprodu.prod_costo_promedio ) , max ( inmprodu.prod_descuento_siono ) , max ( inmprodu.prod_descuento ) , max ( inmprodu.prod_descuento_maximo ) , max ( inmprodu.prod_costo_fob ) , max ( inmprodu.prod_producto ) , max ( inmprodu.prod_producto_dos ) , max ( inamedid_a.medi_tipo_medida ) FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_barra =? ) ) ";
		
		public static string sqlHandle_01_1FE8CC0C = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inamedid_a.medi_cantidad , inamedid_b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_precio1 , inmprodu.prod_medida , inmprodu.prod_costo_promedio , inmprodu.prod_descuento_siono , inmprodu.prod_descuento , inmprodu.prod_descuento_maximo , inmprodu.prod_costo_fob , inmprodu.prod_producto , inmprodu.prod_itbm_local , inamedid_a.medi_tipo_medida FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto_dos =? ) ) ";
		
		public static string sqlHandle_01_87A03978 = "SELECT fatdiari.fact_cliente , fatdiari.fact_ruc_cliente , fatdiari.fact_condicion_pago , fatdiari.fact_tipo_movimiento , fatdiari.fact_dias_pago , fatdiari.fact_tipo_venta , fatdiari.fact_consignado , fatdiari.fact_a_nombre , fatdiari.fact_a_nombre_direccion , fatdiari.fact_despachado , fatdiari.fact_gastos_total , fatdiari.fact_monto_fact_total , fatdiari.fact_monto_final , fatdiari.fact_comentario , fatdiari.fact_no_traspaso , fatdiari.fact_marca , fatdiari.fact_por_descuento , fatdiari.fact_paga_itbm FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_no_pedido =? ) AND ( fatdiari.fact_ann =? ) ";
		
		public static string sqlHandle_01_AEFD5939 = "SELECT ccmclien.clie_exento_itbm FROM ccmclien WHERE ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_tercero =? ) ";
		
		public static string sqlHandle_01_B3D66053 = "SELECT isnull ( inmprodu.prod_itbm_local , 1 ) FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ";
		
		public static string sqlHandle_01_24A96B48 = "SELECT fatprofo.prof_cliente , fatprofo.prof_ruc_cliente , fatprofo.prof_condicion_pago , fatprofo.prof_tipo_venta , fatprofo.prof_tipo_movimiento , fatprofo.prof_dias_pago , fatprofo.prof_consignado , fatprofo.prof_a_nombre , fatprofo.prof_a_nombre_direccion , fatprofo.prof_despachado , fatprofo.prof_gastos_total , fatprofo.prof_monto_total , fatprofo.prof_monto_final , fatprofo.prof_comentario , fatprofo.prof_pasaporte , fatprofo.prof_linea_aerea , fatprofo.prof_por_descuento , fatprofo.prof_marca , fatprofo.prof_paga_itbm FROM fatprofo WHERE ( fatprofo.prof_g_financiero =? ) AND ( fatprofo.prof_empresa =? ) AND ( fatprofo.prof_no_proforma =? ) AND ( fatprofo.prof_ann =? ) ";
		
		public static string sqlHandle_01_BB53668F = "SELECT fadprofo.dpro_linea , fadprofo.dpro_codigo_item , fadprofo.dpro_descripcion_alterna , fadprofo.dpro_unidad_producto , fadprofo.dpro_bodega , fadprofo.dpro_costo_fob , fadprofo.dpro_costo_cif , fadprofo.dpro_precio_unidad_producto , fadprofo.dpro_unidad_venta , fadprofo.dpro_bultos , fadprofo.dpro_ubicacion , fadprofo.dpro_index , fadprofo.dpro_precio_original , fadprofo.dpro_bulto_inicio , fadprofo.dpro_bulto_fin , inmprodu.prod_producto_dos , inmprodu.prod_empaque , a.medi_cantidad , a.medi_tipo_medida , b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_itbm_local FROM fadprofo , inmprodu , inamedid a , inamedid b WHERE ( fadprofo.dpro_g_financiero =inmprodu.prod_g_financiero ) AND ( fadprofo.dpro_empresa =inmprodu.prod_empresa ) AND ( fadprofo.dpro_codigo_item =inmprodu.prod_producto ) AND ( fadprofo.dpro_unidad_venta =a.medi_medida ) AND ( inmprodu.prod_empaque_um =b.medi_medida ) and ( fadprofo.dpro_g_financiero =? ) AND ( fadprofo.dpro_empresa =? ) AND ( fadprofo.dpro_no_proforma =? ) AND ( fadprofo.dpro_ann =? ) AND ( fadprofo.dpro_linea =? ) ";
		
		public static string sqlHandle_01_C4A897EB = "SELECT dgmempre.empr_bodegas_definidas , empr_bodega1 , empr_bodega2 , empr_bodega3 , empr_bodega4 , empr_bodega5 , empr_bodega6 , empr_bodega7 , isnull ( empr_numero_registro , 'TBSR0000' ) FROM dgmempre WHERE ( dgmempre.empr_g_financiero =? ) AND ( dgmempre.empr_empresa =? ) ";
		
		public static string sqlHandle_01_E7B2CAB0 = "SELECT isnull ( facuentas.para_cuenta_exterior , '' ) , isnull ( facuentas.para_cuenta_local , '' ) , isnull ( facuentas.para_cuenta_inventarios , '' ) , isnull ( facuentas.para_cuenta_costos , '' ) , isnull ( facuentas.fara_cuenta_costos_locales , '' ) , isnull ( facuentas.para_cuenta_descuento , '' ) , isnull ( facuentas.para_cuenta_cargos , '' ) FROM facuentas WHERE ( facuentas.para_g_financiero =? ) AND ( facuentas.para_empresa =? ) ";
		
		public static string sqlHandle_01_16405900 = "SELECT count ( * ) FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_ann =? ) AND ( fatdiari.fact_no_factura =? ) and ( fatdiari.fact_no_pedido <> ? ) ";
		
		public static string sqlHandle_01_2A20B375 = "SELECT ccmclien.clie_ref_anterior , dgmterce.terc_descripcion , dgmterce.terc_direccion FROM ccmclien , dgmterce WHERE ( dgmterce.terc_tercero =ccmclien.clie_tercero ) and ( ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_tercero =? ) ) ";
		
		public static string sqlHandle_01_2C689DC4 = "SELECT para_bodega_entrada , para_ubicacion_entrada from inaparam where para_g_financiero =? and para_empresa =? ";
		
		public static string sqlHandle_01_8A6ABFC2 = "SELECT count ( * ) FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_no_pedido =? ) AND ( fatdiari.fact_tipo =? ) AND ( fatdiari.fact_ann =? ) ";
		
		public static string sqlHandle_01_4A68E22E = "SELECT inaparam.para_cliente_control , inaparam.para_grupo_f_entrada , inaparam.para_empresa_entrada FROM inaparam WHERE ( inaparam.para_g_financiero =? ) AND ( inaparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_3A485A3F = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inamedid_a.medi_cantidad , inamedid_b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_precio1 , inmprodu.prod_medida , inmprodu.prod_costo_promedio , inmprodu.prod_descuento_siono , inmprodu.prod_descuento , inmprodu.prod_descuento_maximo , inmprodu.prod_costo_fob , inmprodu.prod_producto_dos FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ) ";
		
		public static string sqlHandle_01_E66480E9 = "SELECT max ( inmprodu.prod_descripcion ) , max ( inmprodu.prod_empaque ) , max ( inamedid_a.medi_cantidad ) , max ( inamedid_b.medi_cantidad ) , max ( inmprodu.prod_peso ) , max ( inmprodu.prod_cubicaje ) , max ( inmprodu.prod_precio1 ) , max ( inmprodu.prod_medida ) , max ( inmprodu.prod_costo_promedio ) , max ( inmprodu.prod_descuento_siono ) , max ( inmprodu.prod_descuento ) , max ( inmprodu.prod_descuento_maximo ) , max ( inmprodu.prod_costo_fob ) , max ( inmprodu.prod_producto ) , max ( inmprodu.prod_producto_dos ) FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_barra =? ) ) ";
		
		public static string sqlHandle_01_B3CA5119 = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inamedid_a.medi_cantidad , inamedid_b.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_precio1 , inmprodu.prod_medida , inmprodu.prod_costo_promedio , inmprodu.prod_descuento_siono , inmprodu.prod_descuento , inmprodu.prod_descuento_maximo , inmprodu.prod_costo_fob , inmprodu.prod_producto FROM inmprodu , inamedid inamedid_a , inamedid inamedid_b WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( inmprodu.prod_empaque_um =inamedid_b.medi_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto_dos =? ) ) ";
		
		public static string sqlHandle_01_30A890F2 = "select isnull ( max ( convert ( numeric ( 10 ) , contrato ) ) , 0 ) from fixing where grupo =? and empresa =? and datepart ( yy , fecha ) =? ";
		
		public static string sqlHandle_01_C90B6E4A = "SELECT sum ( case when facd_cantidad < 0 and facd_rebajar =0 then 0 else case when medi_tipo_medida =10 then 0 else facd_cantidad end end ) cantidad , sum ( case when facd_cantidad < 0 and facd_rebajar =0 then 0 else case when medi_tipo_medida <> 10 then 0 else facd_cantidad end end ) cantidad_pz FROM faddiari , inamedid , inmprodu WHERE ( faddiari.facd_g_financiero =inmprodu.prod_g_financiero ) AND ( faddiari.facd_empresa =inmprodu.prod_empresa ) AND ( faddiari.facd_codigo_item =inmprodu.prod_producto ) AND ( faddiari.facd_unidad_venta =inamedid.medi_medida ) and ( ( faddiari.facd_g_financiero =? ) AND ( faddiari.facd_empresa =? ) AND ( faddiari.facd_no_pedido =? ) AND ( faddiari.facd_ann =? ) ) ";
		
		public static string sqlHandle_01_BC909ABA = "select para_clave_costos from inaparam where ( para_g_financiero =? ) and ( para_empresa =? ) ";
		
		public static string sqlHandle_01_CE3296C3 = "SELECT case when fatdiari.fact_a_nombre =null or fatdiari.fact_a_nombre ='' then dgmterce.terc_descripcion else fatdiari.fact_a_nombre end , fatdiari.fact_fecha , faddiari.facd_precio_unidad_producto , faddiari.facd_cantidad FROM faddiari , fatdiari , dgmterce WHERE ( fatdiari.fact_cliente =dgmterce.terc_tercero ) and ( fatdiari.fact_g_financiero =faddiari.facd_g_financiero ) and ( fatdiari.fact_empresa =faddiari.facd_empresa ) and ( fatdiari.fact_tipo =faddiari.facd_tipo ) and ( fatdiari.fact_no_pedido =faddiari.facd_no_pedido ) and ( fatdiari.fact_ann =faddiari.facd_ann ) and ( ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( faddiari.facd_codigo_item =? ) ) ORDER BY fatdiari.fact_fecha DESC ";
		
		public static string sqlHandle_01_C752629E = "select max ( tmov_secuencia ) from intmovim where tmov_g_financiero =? and tmov_empresa =? and tmov_anual =? and tmov_tipo_transaccion ='AE' ";
		
		public static string sqlHandle_01_CB051BC8 = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inmprodu.prod_medida , inamedid_a.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_costo_cif FROM inmprodu , inamedid inamedid_a WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ) ";
		
		public static string sqlHandle_01_B6D923F4 = "SELECT dgmempre.empr_bodegas_definidas FROM dgmempre WHERE ( dgmempre.empr_g_financiero =? ) AND ( dgmempre.empr_empresa =? ) ";
		
		public static string sqlHandle_01_35D433CE = "SELECT count ( * ) FROM intmovim WHERE ( intmovim.tmov_g_financiero =? ) AND ( intmovim.tmov_empresa =? ) AND ( intmovim.tmov_tipo_transaccion <> 'AE' ) AND ( intmovim.tmov_fecha > ? ) ";
		
		public static string sqlHandle_01_1C01EA2C = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inmprodu.prod_medida , inamedid_a.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_costo_promedio , inmprodu.prod_producto_dos , inamedid_a.medi_tipo_medida FROM inmprodu , inamedid inamedid_a WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ) ";
		
		public static string sqlHandle_01_8A130B89 = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inmprodu.prod_medida , inamedid_a.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_costo_promedio , inmprodu.prod_producto , inamedid_a.medi_tipo_medida FROM inmprodu , inamedid inamedid_a WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto_dos =? ) ) ";
		
		public static string sqlHandle_01_20EF2255 = "select case ? when '1' then ( prod_existencia1 - prod_reserva1 ) / medi_cantidad when '2' then ( prod_existencia2 - prod_reserva2 ) / medi_cantidad when '3' then ( prod_existencia3 - prod_reserva3 ) / medi_cantidad when '4' then ( prod_existencia4 - prod_reserva4 ) / medi_cantidad when '5' then ( prod_existencia5 - prod_reserva5 ) / medi_cantidad when '6' then ( prod_existencia6 - prod_reserva6 ) / medi_cantidad when '7' then ( prod_existencia7 - prod_reserva7 ) / medi_cantidad end , inamedid.medi_cantidad from inmprodu , inamedid where prod_medida =medi_medida and prod_g_financiero =? and prod_empresa =? and prod_producto =? ";
		
		public static string sqlHandle_01_1C17EC96 = "SELECT inmprodu.prod_existencia_total / isnull ( inamedid.medi_cantidad , 1 ) , prod_costo_promedio , prod_costo_fob FROM inmprodu , inamedid WHERE ( inamedid.medi_medida =inmprodu.prod_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ) ";
		
		public static string sqlHandle_01_E22FDB23 = "SELECT max ( tmov_fecha ) fecha FROM indmovim , intmovim WHERE ( intmovim.tmov_g_financiero =indmovim.dmov_g_financiero ) and ( intmovim.tmov_empresa =indmovim.dmov_empresa ) and ( intmovim.tmov_aplicacion =indmovim.dmov_aplicacion ) and ( intmovim.tmov_tipo_transaccion =indmovim.dmov_tipo_transaccion ) and ( intmovim.tmov_secuencia =indmovim.dmov_secuencia ) and ( intmovim.tmov_anual =indmovim.dmov_anual ) and ( intmovim.tmov_concepto =indmovim.dmov_concepto ) and ( ( indmovim.dmov_g_financiero =? ) AND ( indmovim.dmov_empresa =? ) AND ( indmovim.dmov_producto =? ) AND ( indmovim.dmov_tipo_transaccion ='EN' ) ) ";
		
		public static string sqlHandle_01_A699DC76 = "SELECT max ( tmov_fecha ) fecha FROM indmovim , intmovim WHERE ( intmovim.tmov_g_financiero =indmovim.dmov_g_financiero ) and ( intmovim.tmov_empresa =indmovim.dmov_empresa ) and ( intmovim.tmov_aplicacion =indmovim.dmov_aplicacion ) and ( intmovim.tmov_tipo_transaccion =indmovim.dmov_tipo_transaccion ) and ( intmovim.tmov_secuencia =indmovim.dmov_secuencia ) and ( intmovim.tmov_anual =indmovim.dmov_anual ) and ( intmovim.tmov_concepto =indmovim.dmov_concepto ) and ( ( indmovim.dmov_g_financiero =? ) AND ( indmovim.dmov_empresa =? ) AND ( indmovim.dmov_producto =? ) AND ( indmovim.dmov_tipo_transaccion ='AE' ) and dmov_cantidad > 0 ) ";
		
		public static string sqlHandle_01_8809074D = "SELECT sum ( dmov_cantidad * medi_cantidad ) dmov_cantidad FROM indmovim , inamedid , intmovim WHERE ( intmovim.tmov_g_financiero =indmovim.dmov_g_financiero ) and ( intmovim.tmov_empresa =indmovim.dmov_empresa ) and ( intmovim.tmov_aplicacion =indmovim.dmov_aplicacion ) and ( intmovim.tmov_tipo_transaccion =indmovim.dmov_tipo_transaccion ) and ( intmovim.tmov_secuencia =indmovim.dmov_secuencia ) and ( intmovim.tmov_anual =indmovim.dmov_anual ) and ( intmovim.tmov_concepto =indmovim.dmov_concepto ) and ( indmovim.dmov_unidad_medida =inamedid.medi_medida ) and ( ( indmovim.dmov_g_financiero =? ) AND ( indmovim.dmov_empresa =? ) AND ( indmovim.dmov_aplicacion ='IN' ) AND ( indmovim.dmov_tipo_transaccion ='EN' ) AND ( indmovim.dmov_producto =? ) ) GROUP BY indmovim.dmov_documento , intmovim.tmov_fecha ORDER BY intmovim.tmov_fecha DESC , indmovim.dmov_documento ASC ";
		
		public static string sqlHandle_01_95759432 = "SELECT inmprodu.prod_barra , inmprodu.prod_producto , inmprodu.prod_descripcion , inmprodu.prod_precio_mayor , inmprodu.prod_precio_menor , inmprodu.prod_precio_afiliadas , inmprodu.prod_precio_otros , inmprodu.prod_precio_especial , inmprodu.prod_medida , inmprodu.prod_cubicaje , inmprodu.prod_empaque , inmprodu.prod_peso , inmprodu.prod_empaque_descripcion , inmprodu.prod_empaque_um , inmprodu.prod_peso_unidad_medida , inmprodu.prod_cod_clase_tam , inmprodu.prod_gramaje FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ";
		
		public static string sqlHandle_01_6743CA7 = "select max ( mbod_ubicacion ) from inmbodeg where mbod_producto =? and not mbod_bodega ='03' and mbod_empresa =? and mbod_g_financiero =? ";
		
		public static string sqlHandle_01_FE01F90C = "select para_formato_decimal from inaparam where para_g_financiero =? and para_empresa =? ";
		
		public static string sqlHandle_01_C71E09A0 = "SELECT dgmterce.terc_descripcion , dgmterce.terc_direccion , ccmclien.clie_ref_anterior , ccmclien.clie_limite_morosidad FROM ccmclien , dgmterce WHERE ( ccmclien.clie_tercero =dgmterce.terc_tercero ) and ( ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_tercero =? ) ) ";
		
		public static string sqlHandle_01_36EC7F21 = "SELECT max ( dpro_linea ) FROM fadprofo WHERE ( fadprofo.dpro_g_financiero =? ) AND ( fadprofo.dpro_empresa =? ) AND ( fadprofo.dpro_no_proforma =? ) AND ( fadprofo.dpro_ann =? ) ";
		
		public static string sqlHandle_01_337976FA = "select max ( tmov_secuencia ) from intranfer where tmov_g_financiero =? and tmov_empresa =? and tmov_anual =? and tmov_tipo_transaccion ='TR' ";
		
		public static string sqlHandle_01_DD717C25 = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inmprodu.prod_medida , inamedid_a.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_costo_cif , inmprodu.prod_producto_dos FROM inmprodu , inamedid inamedid_a WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ) ";
		
		public static string sqlHandle_01_D55F5437 = "SELECT inmprodu.prod_descripcion , inmprodu.prod_empaque , inmprodu.prod_medida , inamedid_a.medi_cantidad , inmprodu.prod_peso , inmprodu.prod_cubicaje , inmprodu.prod_costo_cif , inmprodu.prod_producto FROM inmprodu , inamedid inamedid_a WHERE ( inamedid_a.medi_medida =inmprodu.prod_medida ) and ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto_dos =? ) ) ";
		
		public static string sqlHandle_01_DAB9B584 = "select case ? when '1' then ( prod_existencia1 - prod_reserva1 ) / medi_cantidad when '2' then ( prod_existencia2 - prod_reserva2 ) / medi_cantidad when '3' then ( prod_existencia3 - prod_reserva3 ) / medi_cantidad when '4' then ( prod_existencia4 - prod_reserva4 ) / medi_cantidad when '5' then ( prod_existencia5 - prod_reserva5 ) / medi_cantidad when '6' then ( prod_existencia6 - prod_reserva6 ) / medi_cantidad when '7' then ( prod_existencia7 - prod_reserva7 ) / medi_cantidad end from inmprodu , inamedid where prod_medida =medi_medida and prod_g_financiero =? and prod_empresa =? and prod_producto =? ";
		
		public static string sqlHandle_01_C463B872 = "SELECT inmprodu.prod_costo_fob , inmprodu.prod_costo_cif , inmprodu.prod_costo_promedio FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ";
		
		public static string sqlHandle_01_585EFAD = "Select para_uso_desglose From inaparam Where para_g_financiero =? and para_empresa =? ";
		
		public static string sqlHandle_01_373AEE10 = "Select para_uso_desglose From inaparam Where para_g_financiero =? And para_empresa =? ";
		
		public static string sqlHandle_01_585A1710 = "select prod_producto from inmprodu where ( prod_g_financiero =? ) and ( prod_empresa =? ) and ( prod_producto =? ) ";
		
		public static string sqlHandle_01_C19B6902 = "Select para_uso_desglose , para_decimal_cantidad From inaparam Where para_g_financiero =? and para_empresa =? ";
		
		public static string sqlHandle_01_BCB159CE = "SELECT inmprodu.prod_producto , prod_cod_clase_tam FROM inmprodu WHERE ( ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto_dos =? ) AND ( inmprodu.prod_producto <> ? ) ) ";
		
		public static string sqlHandle_01_6719EA98 = "SELECT isnull ( usua_letras_por_default , 1 ) , isnull ( usua_costo_en_letras , 1 ) FROM usuarios WHERE usuarios.usua_id =? ";
		
		public static string sqlHandle_01_946A7CAB = "SELECT inaparam.para_costo_en_clave FROM inaparam WHERE ( inaparam.para_g_financiero =? ) AND ( inaparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_87111367 = "select usua_especial from ssmusuar where usua_id =? ";
		
		public static string sqlHandle_01_5EE1E80B = "SELECT max ( inmprodu.prod_producto ) FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto_dos =? ) ";
		
		public static string sqlHandle_01_22B197EE = "SELECT ccmclien.clie_ruc_tercero , dgmterce.terc_descripcion FROM ccmclien , dgmterce WHERE ( ccmclien.clie_tercero =dgmterce.terc_tercero ) and ( ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_tercero =? ) ) ";
		
		public static string sqlHandle_01_E842BCFA = "SELECT convert ( numeric ( 8 , 2 ) , sum ( dmov_precio_original * dmov_cantidad ) / sum ( dmov_cantidad ) ) , convert ( numeric ( 12 , 6 ) , sum ( prod_costo_fob * dmov_cantidad ) / sum ( dmov_precio_original * dmov_cantidad ) ) FROM indmovim , inmprodu WHERE ( indmovim.dmov_g_financiero =inmprodu.prod_g_financiero ) AND ( indmovim.dmov_empresa =inmprodu.prod_empresa ) AND ( indmovim.dmov_producto =inmprodu.prod_producto ) AND ( indmovim.dmov_g_financiero =? ) AND ( indmovim.dmov_empresa =? ) AND ( indmovim.dmov_aplicacion ='FA' ) AND ( indmovim.dmov_producto =? ) ";
		
		public static string sqlHandle_01_6514EC31 = "SELECT isnull ( sum ( faddiari.facd_monto_final ) , 0 ) FROM faddiari , fatdiari WHERE ( fatdiari.fact_g_financiero =faddiari.facd_g_financiero ) and ( fatdiari.fact_empresa =faddiari.facd_empresa ) and ( fatdiari.fact_tipo =faddiari.facd_tipo ) and ( fatdiari.fact_no_pedido =faddiari.facd_no_pedido ) and ( fatdiari.fact_ann =faddiari.facd_ann ) and ( ( faddiari.facd_g_financiero =? ) AND ( faddiari.facd_empresa =? ) AND ( faddiari.facd_codigo_item =? ) AND ( fatdiari.fact_fecha >= ? ) ) ";
		
		public static string sqlHandle_01_AA2C8ACA = "SELECT isnull ( convert ( numeric ( 8 , 2 ) , sum ( dmov_precio * dmov_cantidad ) ) , 0 ) , isnull ( convert ( numeric ( 8 , 2 ) , sum ( dmov_cantidad ) ) , 0 ) , isnull ( convert ( numeric ( 12 , 6 ) , sum ( dmov_costo_promedio * dmov_cantidad ) ) , 0 ) , isnull ( sum ( dmov_precio * dmov_cantidad ) , 0 ) FROM intmovim , indmovim , inmprodu WHERE ( indmovim.dmov_g_financiero =intmovim.tmov_g_financiero ) and ( indmovim.dmov_empresa =intmovim.tmov_empresa ) and ( indmovim.dmov_aplicacion =intmovim.tmov_aplicacion ) and ( indmovim.dmov_tipo_transaccion =intmovim.tmov_tipo_transaccion ) and ( indmovim.dmov_concepto =intmovim.tmov_concepto ) and ( indmovim.dmov_secuencia =intmovim.tmov_secuencia ) and ( indmovim.dmov_anual =intmovim.tmov_anual ) and ( indmovim.dmov_g_financiero =inmprodu.prod_g_financiero ) AND ( indmovim.dmov_empresa =inmprodu.prod_empresa ) AND ( indmovim.dmov_producto =inmprodu.prod_producto ) AND ( indmovim.dmov_g_financiero =? ) AND ( indmovim.dmov_empresa =? ) AND ( indmovim.dmov_tipo_transaccion in ( 'SA' , 'FA' ) ) AND ( indmovim.dmov_producto =? ) AND ( intmovim.tmov_fecha >= ? ) AND ( intmovim.tmov_fecha <= ? ) ";
		
		public static string sqlHandle_01_10D38AF = "SELECT max ( tmov_fecha ) fecha FROM indmovim , intmovim WHERE ( intmovim.tmov_g_financiero =indmovim.dmov_g_financiero ) and ( intmovim.tmov_empresa =indmovim.dmov_empresa ) and ( intmovim.tmov_aplicacion =indmovim.dmov_aplicacion ) and ( intmovim.tmov_tipo_transaccion =indmovim.dmov_tipo_transaccion ) and ( intmovim.tmov_secuencia =indmovim.dmov_secuencia ) and ( intmovim.tmov_anual =indmovim.dmov_anual ) and ( intmovim.tmov_concepto =indmovim.dmov_concepto ) and ( ( indmovim.dmov_g_financiero =? ) AND ( indmovim.dmov_empresa =? ) AND ( indmovim.dmov_producto =? ) AND ( indmovim.dmov_tipo_transaccion ='SA' ) ) ";
		
		public static string sqlHandle_01_4AA242E9 = "SELECT max ( tmov_fecha ) fecha FROM indmovim , intmovim WHERE ( intmovim.tmov_g_financiero =indmovim.dmov_g_financiero ) and ( intmovim.tmov_empresa =indmovim.dmov_empresa ) and ( intmovim.tmov_aplicacion =indmovim.dmov_aplicacion ) and ( intmovim.tmov_tipo_transaccion =indmovim.dmov_tipo_transaccion ) and ( intmovim.tmov_secuencia =indmovim.dmov_secuencia ) and ( intmovim.tmov_anual =indmovim.dmov_anual ) and ( intmovim.tmov_concepto =indmovim.dmov_concepto ) and ( ( indmovim.dmov_g_financiero =? ) AND ( indmovim.dmov_empresa =? ) AND ( indmovim.dmov_producto =? ) AND ( indmovim.dmov_tipo_transaccion ='AE' ) and dmov_cantidad < 0 ) ";
		
		public static string sqlHandle_01_9352C372 = "SELECT tmov_terceros FROM indmovim , intmovim WHERE ( intmovim.tmov_g_financiero =indmovim.dmov_g_financiero ) and ( intmovim.tmov_empresa =indmovim.dmov_empresa ) and ( intmovim.tmov_aplicacion =indmovim.dmov_aplicacion ) and ( intmovim.tmov_tipo_transaccion =indmovim.dmov_tipo_transaccion ) and ( intmovim.tmov_secuencia =indmovim.dmov_secuencia ) and ( intmovim.tmov_anual =indmovim.dmov_anual ) and ( intmovim.tmov_concepto =indmovim.dmov_concepto ) and ( ( intmovim.tmov_tipo_transaccion ='EN' ) AND ( intmovim.tmov_empresa =? ) AND ( indmovim.dmov_producto =? ) ) order by tmov_fecha desc ";
		
		public static string sqlHandle_01_AEFF0B3 = "SELECT cratallas.talla_descripcion FROM cratallas WHERE ( cratallas.talla_g_financiero =? ) AND ( cratallas.talla_empresa =? ) AND ( cratallas.talla_codigo =? ) ";
		
		public static string sqlHandle_01_798BD9E0 = "select claco_codigo from inaclaco where claco_g_financiero =? and claco_empresa =? order by claco_codigo ";
		
		public static string sqlHandle_01_75764FA3 = "SELECT isnull ( dmov_costo_fob , 0 ) FROM indmovim , intmovim WHERE ( intmovim.tmov_g_financiero =indmovim.dmov_g_financiero ) and ( intmovim.tmov_empresa =indmovim.dmov_empresa ) and ( intmovim.tmov_aplicacion =indmovim.dmov_aplicacion ) and ( intmovim.tmov_tipo_transaccion =indmovim.dmov_tipo_transaccion ) and ( intmovim.tmov_secuencia =indmovim.dmov_secuencia ) and ( intmovim.tmov_anual =indmovim.dmov_anual ) and ( intmovim.tmov_concepto =indmovim.dmov_concepto ) and ( ( indmovim.dmov_g_financiero =? ) AND ( indmovim.dmov_empresa =? ) AND ( indmovim.dmov_aplicacion ='IN' ) AND ( indmovim.dmov_tipo_transaccion ='EN' ) AND ( indmovim.dmov_producto =? ) ) ORDER BY intmovim.tmov_fecha Desc ";
		
		public static string sqlHandle_01_217844B7 = "SELECT isnull ( max ( notascr_detalle.total ) , 0 ) , isnull ( max ( notascr_detalle.porciento ) , 0 ) FROM notascr_detalle , notascr_encab WHERE ( notascr_encab.g_financiero =notascr_detalle.g_financiero ) and ( notascr_encab.empresa =notascr_detalle.empresa ) and ( notascr_encab.documento =notascr_detalle.documento ) and ( notascr_encab.ann =notascr_detalle.ann ) and ( ( notascr_detalle.g_financiero =? ) AND ( notascr_detalle.empresa =? ) AND ( notascr_detalle.item =? ) ) ";
		
		public static string sqlHandle_01_692C6385 = "SELECT isnull ( convert ( numeric ( 8 , 2 ) , sum ( dmov_precio_original * dmov_cantidad ) ) , 0 ) , isnull ( convert ( numeric ( 8 , 2 ) , sum ( dmov_cantidad ) ) , 0 ) , isnull ( convert ( numeric ( 12 , 6 ) , sum ( prod_costo_fob * dmov_cantidad ) ) , 0 ) , isnull ( sum ( dmov_precio_original * dmov_cantidad ) , 0 ) FROM intmovim , indmovim , inmprodu WHERE ( indmovim.dmov_g_financiero =intmovim.tmov_g_financiero ) and ( indmovim.dmov_empresa =intmovim.tmov_empresa ) and ( indmovim.dmov_aplicacion =intmovim.tmov_aplicacion ) and ( indmovim.dmov_tipo_transaccion =intmovim.tmov_tipo_transaccion ) and ( indmovim.dmov_concepto =intmovim.tmov_concepto ) and ( indmovim.dmov_secuencia =intmovim.tmov_secuencia ) and ( indmovim.dmov_anual =intmovim.tmov_anual ) and ( indmovim.dmov_g_financiero =inmprodu.prod_g_financiero ) AND ( indmovim.dmov_empresa =inmprodu.prod_empresa ) AND ( indmovim.dmov_producto =inmprodu.prod_producto ) AND ( indmovim.dmov_g_financiero =? ) AND ( indmovim.dmov_empresa =? ) AND ( indmovim.dmov_tipo_transaccion in ( 'SA' , 'FA' ) ) AND ( indmovim.dmov_producto =? ) ";
		
		public static string sqlHandle_01_2241FCF2 = "SELECT isnull ( convert ( numeric ( 8 , 2 ) , sum ( dped_precio_original * dped_cantidad ) ) , 0 ) , isnull ( convert ( numeric ( 8 , 2 ) , sum ( dped_cantidad ) ) , 0 ) , isnull ( convert ( numeric ( 12 , 6 ) , sum ( prod_costo_fob * dped_cantidad ) ) , 0 ) , isnull ( sum ( dped_precio_original * dped_cantidad ) , 0 ) FROM fadpedid , inmprodu WHERE ( fadpedid.dped_g_financiero =inmprodu.prod_g_financiero ) AND ( fadpedid.dped_empresa =inmprodu.prod_empresa ) AND ( fadpedid.dped_codigo_item =inmprodu.prod_producto ) AND ( fadpedid.dped_g_financiero =? ) AND ( fadpedid.dped_empresa =? ) AND ( fadpedid.dped_pasada =0 ) AND ( fadpedid.dped_codigo_item =? ) ";
		
		public static string sqlHandle_01_FA80D02A = "SELECT isnull ( convert ( numeric ( 8 , 2 ) , sum ( facd_precio_original * facd_cantidad ) ) , 0 ) , isnull ( convert ( numeric ( 8 , 2 ) , sum ( facd_cantidad ) ) , 0 ) , isnull ( convert ( numeric ( 12 , 6 ) , sum ( prod_costo_fob * facd_cantidad ) ) , 0 ) , isnull ( sum ( facd_precio_original * facd_cantidad ) , 0 ) FROM faddiari , fatdiari , inmprodu WHERE ( faddiari.facd_g_financiero =inmprodu.prod_g_financiero ) AND ( faddiari.facd_empresa =inmprodu.prod_empresa ) AND ( faddiari.facd_codigo_item =inmprodu.prod_producto ) AND ( faddiari.facd_g_financiero =fatdiari.fact_g_financiero ) and ( faddiari.facd_empresa =fatdiari.fact_empresa ) and ( faddiari.facd_tipo =fatdiari.fact_tipo ) and ( faddiari.facd_no_pedido =fatdiari.fact_no_pedido ) and ( faddiari.facd_ann =fatdiari.fact_ann ) and ( fatdiari.fact_estado ='A' ) and ( faddiari.facd_g_financiero =? ) AND ( faddiari.facd_empresa =? ) AND ( faddiari.facd_codigo_item =? ) ";
		
		public static string sqlHandle_01_CD154CA2 = "SELECT inaparam.para_foto_dir , inaparam.para_foto_dir_catalogo FROM inaparam WHERE ( inaparam.para_g_financiero =? ) AND ( inaparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_89E86D7D = "SELECT dgmempre.empr_bodegas_definidas , dgmempre.empr_bodega1 , dgmempre.empr_bodega2 , dgmempre.empr_bodega3 , dgmempre.empr_bodega4 , dgmempre.empr_bodega5 , dgmempre.empr_bodega6 , dgmempre.empr_bodega7 FROM dgmempre WHERE ( dgmempre.empr_g_financiero =? ) AND ( dgmempre.empr_empresa =? ) ";
		
		public static string sqlHandle_01_3493213A = "select count ( * ) from tzdtraf1 where ( tzdtraf1.traf_g_financiero =? ) and ( tzdtraf1.traf_empresa =? ) and ( tzdtraf1.traf_ent_sal ='SA' ) and ( tzdtraf1.traf_pedido =? ) and ( tzdtraf1.traf_ann =? ) ";
		
		public static string sqlHandle_01_DF497833 = "SELECT tzaparam.para_sec_salidas FROM tzaparam WHERE ( tzaparam.para_g_financiero =? ) AND ( tzaparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_28206703 = "SELECT tzaparam.para_sec_salidas , tzaparam.para_clave_cia , tzaparam.para_num_pais FROM tzaparam WHERE ( tzaparam.para_g_financiero =? ) AND ( tzaparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_25A6C7F7 = "SELECT count ( * ) FROM tzttraf0 WHERE ( tzttraf0.ttra_g_financiero =? ) AND ( tzttraf0.ttra_empresa =? ) AND ( tzttraf0.ttra_ent_sal ='SA' ) AND ( tzttraf0.ttra_ann =? ) AND ( tzttraf0.ttra_pedido =? ) ";
		
		public static string sqlHandle_01_33E011C1 = "SELECT fatdiari.fact_no_pedido , fatdiari.fact_con_emb_no , fatdiari.fact_marca , fatdiari.fact_gastos_total , fatdiari.fact_fecha , fatdiari.fact_consignado , fatdiari.fact_cliente , fatdiari.fact_a_nombre , fatdiari.fact_a_nombre_direccion , fatdiari.fact_despachado , fatdiari.fact_bultos_total , fatdiari.fact_peso_total , fatdiari.fact_cubicaje_total , fatdiari.fact_monto_fact_total , fatdiari.fact_monto_final FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_ann =? ) AND ( fatdiari.fact_no_factura =? ) AND ( fatdiari.fact_no_pedido not like '%NC%' ) ";
		
		public static string sqlHandle_01_D033528A = "SELECT fatdiari.fact_no_factura , fatdiari.fact_con_emb_no , fatdiari.fact_marca , fatdiari.fact_gastos_total , fatdiari.fact_fecha , fatdiari.fact_consignado , fatdiari.fact_cliente , fatdiari.fact_a_nombre , fatdiari.fact_a_nombre_direccion , fatdiari.fact_despachado , fatdiari.fact_bultos_total , fatdiari.fact_peso_total , fatdiari.fact_cubicaje_total , fatdiari.fact_monto_fact_total , fatdiari.fact_monto_final FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_ann =? ) AND ( fatdiari.fact_no_pedido =? ) AND ( fatdiari.fact_no_pedido not like '%NC%' ) ";
		
		public static string sqlHandle_01_D48E06D1 = "SELECT fatdiari.fact_no_pedido , fatdiari.fact_con_emb_no , fatdiari.fact_marca , fatdiari.fact_gastos_total , fatdiari.fact_fecha , fatdiari.fact_consignado , fatdiari.fact_cliente , fatdiari.fact_a_nombre , fatdiari.fact_a_nombre_direccion , fatdiari.fact_despachado , fatdiari.fact_bultos_total , fatdiari.fact_peso_total , fatdiari.fact_cubicaje_total , fatdiari.fact_monto_fact_total , fatdiari.fact_monto_final FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_ann =? ) AND ( fatdiari.fact_no_factura =? ) AND ( fatdiari.fact_tipo =? ) AND ( fatdiari.fact_no_pedido not like '%NC%' ) ";
		
		public static string sqlHandle_01_B9782C1F = "SELECT fatdiari.fact_no_factura , fatdiari.fact_con_emb_no , fatdiari.fact_marca , fatdiari.fact_gastos_total , fatdiari.fact_fecha , fatdiari.fact_consignado , fatdiari.fact_cliente , fatdiari.fact_a_nombre , fatdiari.fact_a_nombre_direccion , fatdiari.fact_despachado , fatdiari.fact_bultos_total , fatdiari.fact_peso_total , fatdiari.fact_cubicaje_total , fatdiari.fact_monto_fact_total , fatdiari.fact_monto_final FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_ann =? ) AND ( fatdiari.fact_no_pedido =? ) AND ( fatdiari.fact_tipo =? ) AND ( fatdiari.fact_no_pedido not like '%NC%' ) ";
		
		public static string sqlHandle_01_38AE5F49 = "SELECT count ( * ) FROM tzttraf0 WHERE ( tzttraf0.ttra_g_financiero =? ) AND ( tzttraf0.ttra_empresa =? ) AND ( tzttraf0.ttra_ent_sal =\"SA\" ) AND ( tzttraf0.ttra_ann =? ) AND ( tzttraf0.ttra_pedido =? ) ";
		
		public static string sqlHandle_01_F15D592C = "SELECT count ( * ) FROM tzdtraf1 WHERE ( tzdtraf1.traf_g_financiero =? ) AND ( tzdtraf1.traf_empresa =? ) AND ( tzdtraf1.traf_ent_sal =\"SA\" ) AND ( tzdtraf1.traf_ann =? ) AND ( tzdtraf1.traf_pedido =? ) ";
		
		public static string sqlHandle_01_5DE84B66 = "SELECT tzaparam.para_num_pais FROM tzaparam where para_g_financiero =? and para_empresa =? ";
		
		public static string sqlHandle_01_4DD412BC = "SELECT count ( * ) FROM tzdtraf1 WHERE ( tzdtraf1.traf_g_financiero =? ) AND ( tzdtraf1.traf_empresa =? ) AND ( tzdtraf1.traf_ann =? ) AND ( tzdtraf1.traf_ent_sal ='SA' ) AND ( tzdtraf1.traf_pedido =? ) ";
		
		public static string sqlHandle_01_F16981E5 = "SELECT count ( * ) FROM tzttraf0 WHERE ( tzttraf0.ttra_g_financiero =? ) AND ( tzttraf0.ttra_empresa =? ) AND ( tzttraf0.ttra_ann =? ) AND ( tzttraf0.ttra_ent_sal ='SA' ) AND ( tzttraf0.ttra_pedido =? ) ";
		
		public static string sqlHandle_01_D780D414 = "SELECT tzaparam.param_subfacturacion FROM tzaparam WHERE ( tzaparam.para_g_financiero =? ) AND ( tzaparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_133E5AA = "SELECT tzaparam.para_sec_traspasos FROM tzaparam WHERE ( tzaparam.para_g_financiero =? ) AND ( tzaparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_F3AC864C = "SELECT tzaparam.para_sec_traspasos , tzaparam.para_clave_cia , tzaparam.para_num_pais FROM tzaparam WHERE ( tzaparam.para_g_financiero =? ) AND ( tzaparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_92753E62 = "SELECT count ( * ) FROM tzttraf0 WHERE ( tzttraf0.ttra_g_financiero =? ) AND ( tzttraf0.ttra_empresa =? ) AND ( tzttraf0.ttra_ent_sal ='TR' ) AND ( tzttraf0.ttra_ann =? ) AND ( tzttraf0.ttra_pedido =? ) ";
		
		public static string sqlHandle_01_8F7DA6DC = "SELECT count ( * ) FROM tzttraf0 WHERE ( tzttraf0.ttra_g_financiero =? ) AND ( tzttraf0.ttra_empresa =? ) AND ( tzttraf0.ttra_ent_sal =\"TR\" ) AND ( tzttraf0.ttra_ann =? ) AND ( tzttraf0.ttra_pedido =? ) ";
		
		public static string sqlHandle_01_468EA0B9 = "SELECT count ( * ) FROM tzdtraf1 WHERE ( tzdtraf1.traf_g_financiero =? ) AND ( tzdtraf1.traf_empresa =? ) AND ( tzdtraf1.traf_ent_sal =\"TR\" ) AND ( tzdtraf1.traf_ann =? ) AND ( tzdtraf1.traf_pedido =? ) ";
		
		public static string sqlHandle_01_78D89555 = "SELECT fatdiari.fact_no_pedido , fatdiari.fact_marca , fatdiari.fact_gastos_total , fatdiari.fact_fecha , fatdiari.fact_cliente , fatdiari.fact_a_nombre , fatdiari.fact_a_nombre_direccion FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_ann =? ) AND ( fatdiari.fact_no_factura =? ) and ( fatdiari.fact_no_pedido not like '%NC%' ) ";
		
		public static string sqlHandle_01_D87EB1F6 = "SELECT fatdiari.fact_no_factura , fatdiari.fact_marca , fatdiari.fact_gastos_total , fatdiari.fact_fecha , fatdiari.fact_cliente , fatdiari.fact_a_nombre , fatdiari.fact_a_nombre_direccion FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_ann =? ) AND ( fatdiari.fact_no_pedido =? ) AND ( fatdiari.fact_no_pedido not like '%NC%' ) ";
		
		public static string sqlHandle_01_518918D5 = "SELECT fatdiari.fact_no_pedido , fatdiari.fact_marca , fatdiari.fact_gastos_total , fatdiari.fact_fecha , fatdiari.fact_cliente , fatdiari.fact_a_nombre , fatdiari.fact_a_nombre_direccion FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_ann =? ) AND ( fatdiari.fact_no_factura =? ) and ( fatdiari.fact_tipo =? ) and ( fatdiari.fact_no_pedido not like '%NC%' ) ";
		
		public static string sqlHandle_01_795BAC45 = "SELECT fatdiari.fact_no_factura , fatdiari.fact_marca , fatdiari.fact_gastos_total , fatdiari.fact_fecha , fatdiari.fact_cliente , fatdiari.fact_a_nombre , fatdiari.fact_a_nombre_direccion FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_ann =? ) AND ( fatdiari.fact_no_pedido =? ) AND ( fatdiari.fact_tipo =? ) AND ( fatdiari.fact_no_pedido not like '%NC%' ) ";
		
		public static string sqlHandle_01_D2C0B90 = "SELECT count ( * ) FROM tzdtraf1 WHERE ( tzdtraf1.traf_g_financiero =? ) AND ( tzdtraf1.traf_empresa =? ) AND ( tzdtraf1.traf_ann =? ) AND ( tzdtraf1.traf_ent_sal ='TR' ) AND ( tzdtraf1.traf_pedido =? ) ";
		
		public static string sqlHandle_01_B19198C9 = "SELECT count ( * ) FROM tzttraf0 WHERE ( tzttraf0.ttra_g_financiero =? ) AND ( tzttraf0.ttra_empresa =? ) AND ( tzttraf0.ttra_ann =? ) AND ( tzttraf0.ttra_ent_sal ='TR' ) AND ( tzttraf0.ttra_pedido =? ) ";
		
		public static string sqlHandle_01_E91054DB = "SELECT inmprodu.prod_producto , inmprodu.prod_descripcion , inmprodu.prod_descripcion_dos , inmprodu.prod_costo_unitario , inmprodu.prod_medida , inmprodu.prod_cubicaje , inmprodu.prod_peso , inmprodu.prod_peso_unidad_medida , inmprodu.prod_precio_mayor , inmprodu.prod_precio_menor , inmprodu.prod_precio_afiliadas , inmprodu.prod_precio_otros , inmprodu.prod_precio_especial , inmprodu.prod_costo_fob , inmprodu.prod_costo_cif , inmprodu.prod_comision , inmprodu.prod_descuento_maximo , inmprodu.prod_existencia_total , inmprodu.prod_reserva_total , inmprodu.prod_empaque , inmprodu.prod_empaque_um , inmprodu.prod_descuento_siono , inmprodu.prod_descuento_maximo , inmprodu.prod_pais FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ";
		
		public static string sqlHandle_01_960BA773 = "SELECT isnull ( inamedid.medi_cantidad , 0 ) FROM inamedid WHERE inamedid.medi_medida =? ";
		
		public static string sqlHandle_01_2F99CF1C = "SELECT isnull ( inamedid.medi_cantidad , 0 ) FROM inamedid WHERE inamedid.medi_tipo_medida =? and inamedid.medi_medida =? ";
		
		public static string sqlHandle_01_91754CE6 = "SELECT count ( * ) FROM ssmacceso WHERE ( acce_id_grupo =? ) AND ( acce_cod_menu =? ) AND ( acce_menu_item =? ) AND ( acce_aplicacion =? ) AND ( acce_acceso ='S' ) ";
		
		public static string sqlHandle_01_D73D33F7 = "SELECT inamedid.medi_tipo_medida FROM inamedid WHERE inamedid.medi_medida =? ";
		
		public static string sqlHandle_01_6CD58BC0 = "SELECT dgmserie.mser_secuencia , dgmserie.mser_anno FROM dgmserie WHERE ( dgmserie.mser_g_financiero =? ) AND ( dgmserie.mser_empresa =? ) AND ( dgmserie.mser_tipo_transaccion =? ) ";
		
		public static string sqlHandle_01_9DF93FA = "SELECT max ( tsec_linea ) FROM dgtemsec WHERE ( dgtemsec.tsec_g_financiero =? ) AND ( dgtemsec.tsec_empresa =? ) AND ( dgtemsec.tsec_aplicacion =? ) AND ( dgtemsec.tsec_tipotransac =? ) ";
		
		public static string sqlHandle_01_74EFFD18 = "SELECT Count ( * ) FROM dgtemsec WHERE ( dgtemsec.tsec_g_financiero =? ) AND ( dgtemsec.tsec_empresa =? ) AND ( dgtemsec.tsec_aplicacion =? ) AND ( dgtemsec.tsec_tipotransac =? ) AND ( dgtemsec.tsec_sec_alfnum =? ) ";
		
		public static string sqlHandle_01_1D6120FA = "SELECT Count ( * ) FROM dgmserie WHERE ( dgmserie.mser_g_financiero =? ) AND ( dgmserie.mser_empresa =? ) AND ( dgmserie.mser_tipo_transaccion =? ) AND ( dgmserie.mser_secuencia =? ) ";
		
		public static string sqlHandle_01_E1738E52 = "SELECT badplche.plch_nombre_campo , badplche.plch_x , badplche.plch_y , badplche.plch_alto , badplche.plch_ancho , badplche.plch_visible , badplche.plch_borde , badplche.plch_tipo , badplche.plch_tamano , badplche.plch_bold , badplche.plch_italic , badplche.plch_underline , badplche.plch_alineado , badplche.plch_color_letra , badplche.plch_color_texto FROM badplche WHERE badplche.plch_no_plantilla =? AND badplche.plch_g_financiero =? AND badplche.plch_empresa =? ";
		
		public static string sqlHandle_01_65EE0AC9 = "SELECT Getdate ( ) ";
		
		public static string sqlHandle_01_DCB509A8 = "SELECT COUNT ( * ) FROM inmbodet WHERE ( inmbodet.mbde_g_financiero =? ) AND ( inmbodet.mbde_empresa =? ) AND ( inmbodet.mbde_bodega =? ) AND ( inmbodet.mbde_ubicacion =? ) AND ( inmbodet.mbde_producto =? ) ";
		
		public static string sqlHandle_01_72BC15A6 = "SELECT faaparam.fara_fact_ano , faaparam.fara_venta , faaparam.fara_produ_servi , faaparam.fara_comision , faaparam.fara_comi_por_cobro , faaparam.fara_mostrar_desde , faaparam.fara_desde , faaparam.fapa_igual_factura_pedido , faaparam.fara_modi_fac , faaparam.fara_afecta_consultas , faaparam.fara_uni_peso , faaparam.fara_titulo_reimpresion , faaparam.fara_bodega , faaparam.fara_ubicacion , faaparam.fara_logo_apli , faaparam.fara_ingles , faaparam.fara_nota_credito , faaparam.fara_genera_recibo , faaparam.fara_act_cliente , faaparam.fara_act_inventario , faaparam.fara_precio_ayuda_clave , faaparam.fara_dw_impresion1 , faaparam.fara_dw_impresion2 , faaparam.fara_unidad_cubicaje , faaparam.fara_titulo_desglose_abreviado , faaparam.fara_adicionar_al_guardar , faaparam.fara_ayuda_en_codigo , faaparam.fara_cliente_contado , faaparam.fara_unidad_default , faaparam.fara_ayuda_en_unidad , faaparam.fara_detalle_de_cargos , faaparam.fara_facturar_en_negativo , faaparam.fara_cambiar_al_detalle , faaparam.fara_recalcular_peso , faaparam.fara_recalcular_cubicaje , faaparam.fara_recalcular_bultos , faaparam.fara_recibo_en_fac_contado , faaparam.fara_tipo_de_empaques , faaparam.fara_formato_pb_usuario , isnull ( faaparam.fara_orden_default , 2 ) , faaparam.fara_sec_vta_detal , faaparam.fara_pedido_vta_detal , faaparam.fara_bod_vta_detal , faaparam.fara_ubica_vta_detal , faaparam.fara_tiene_vta_detal , faaparam.fara_tipo_vta_detal , faaparam.fara_precio_vta_detal , isnull ( faaparam.fara_mostrar_empaque , 0 ) , isnull ( faaparam.fara_pais_en_direccion , 0 ) , isnull ( faaparam.fara_mostrar_bultos , 0 ) , isnull ( faaparam.fara_fecha_serv_al_imprimir , 0 ) , isnull ( faaparam.fara_lista_emp_especial , 0 ) , faaparam.fara_precio_a_utilizar , faaparam.fara_dec_en_cantidad , faaparam.fara_reserva_en_transito , isnull ( faaparam.fara_seis_digitos_pedido , 0 ) , isnull ( faaparam.fara_pasar_mismo_numero , 0 ) , isnull ( fara_abrir_ventana_vendedor , 0 ) , isnull ( faaparam.fara_clave_reserva_negativo , 0 ) , isnull ( faaparam.fara_empaque_decimales , 0 ) , isnull ( faaparam.fara_mostrar_precio_uno , 1 ) , isnull ( faaparam.fara_clave_bajo_costos , 1 ) , isnull ( faaparam.fara_pregunta_por_negativos , 1 ) , isnull ( faaparam.fara_default_codigo_barra , 0 ) , isnull ( faaparam.fara_inf_agotado_pedfact , 0 ) , isnull ( faaparam.fara_proteger_actualizacion , 1 ) , faaparam.fara_cantidad_linea_doc , isnull ( fara_ctl_fecha_fac , 0 ) , isnull ( fara_formula_utilidad , 1 ) , isnull ( faaparam.fara_mostrar_producto_dos , 0 ) FROM faaparam WHERE ( faaparam.fara_g_financiero =? ) AND ( faaparam.fara_empresa =? ) ";
		
		public static string sqlHandle_01_CEEED4B7 = "SELECT Isnull ( inaparam.para_costo_aplicado , '' ) FROM inaparam WHERE ( inaparam.para_g_financiero =? ) AND ( inaparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_29701D02 = "SELECT para_utiliza_nombre FROM plmparam WHERE ( plmparam.para_g_financiero =? ) AND ( plmparam.para_empresa =? ) ";
		
		public static string sqlHandle_01_A729FCC = "SELECT prod_definicion FROM inmprodu WHERE ( prod_g_financiero =? ) AND ( prod_empresa =? ) AND ( prod_producto =? ) ";
		
		public static string sqlHandle_01_186D6CEC = "select para_clave_precios from inaparam where ( para_g_financiero =? ) and ( para_empresa =? ) ";
		
		public static string sqlHandle_01_9BE59230 = "SELECT dgmaplica.apli_descripcion FROM dgmaplica WHERE dgmaplica.apli_aplicacion =? ";
		
		public static string sqlHandle_01_1EDF802A = "SELECT dgacolor.color1 , dgacolor.color2 FROM dgacolor WHERE ( dgacolor.colo_g_finanaciero =? ) AND ( dgacolor.colo_empresa =? ) AND ( dgacolor.colo_aplicacion =? ) AND ( dgacolor.ventana =? ) ";
		
		public static string sqlHandle_01_37D289B6 = "SELECT \"acceso\".\"menu_item\" FROM \"acceso\" WHERE ( \"acceso\".\"id_grupo\" =? ) AND ( \"acceso\".\"acceso\" ='N' ) ";
		
		public static string sqlHandle_01_E3323956 = "SELECT ssmusuar.usua_id FROM ssmusuar WHERE ssmusuar.usua_id =? ";
		
		public static string sqlHandle_01_1E2B6A3D = "SELECT IsNull ( count ( ssmgrupusemp.grue_aplicacion ) , 0 ) FROM ssmgrupusemp WHERE ssmgrupusemp.grue_usuario =? ";
		
		public static string sqlHandle_01_349A9048 = "SELECT min ( dgmempre.empr_g_financiero ) , min ( dgmempre.empr_empresa ) FROM dgmempre WHERE dgmempre.empr_estado ='A' ";
		
		public static string sqlHandle_01_DC0A47D9 = "SELECT ssmgrupusemp.grue_g_financiero , ssmgrupusemp.grue_empresa , ssmgrupusemp.grue_grupo , ssmusuar.usua_nombre , ssmusuar.usua_apellido , ssmusuar.usua_clave FROM ssmgrupusemp , ssmusuar WHERE ( ssmusuar.usua_id =ssmgrupusemp.grue_usuario ) AND ( ( ssmgrupusemp.grue_g_financiero =? ) AND ( ssmgrupusemp.grue_aplicacion =? ) AND ( ssmgrupusemp.grue_empresa =? ) AND ( ssmusuar.usua_id =? ) AND ( ssmusuar.usua_clave =? ) AND ( ssmgrupusemp.grue_estado ='A' ) AND ( ssmusuar.usua_estado ='A' ) ) ";
		
		public static string sqlHandle_01_B440E41 = "SELECT ssmusuar.usua_nombre , ssmusuar.usua_apellido , ssmusuar.usua_clave FROM ssmusuar ";
		
		public static string sqlHandle_01_382ED268 = "SELECT dgmaplica.apli_icono FROM dgmaplica WHERE dgmaplica.apli_aplicacion =? ";
		
		public static string sqlHandle_01_10E4E5A6 = "SELECT inmbodet.mbde_reserva , inmbodet.mbde_cantidad FROM inmbodet WHERE ( inmbodet.mbde_g_financiero =? ) AND ( inmbodet.mbde_empresa =? ) AND ( inmbodet.mbde_producto =? ) AND ( inmbodet.mbde_cod_clase_tam =? ) AND ( inmbodet.mbde_bodega =? ) AND ( inmbodet.mbde_ubicacion =? ) AND ( inmbodet.mbde_cod_tamano =? ) AND ( inmbodet.mbde_largo =? ) AND ( inmbodet.mbde_color =? ) ";
		
		public static string sqlHandle_01_CDBF1E47 = "Select Count ( * ) From inmprodu Where prod_g_financiero =? and prod_empresa =? ";
		
		public static string sqlHandle_01_9F43156E = "Select Count ( * ) From intmovim Where tmov_g_financiero =? and tmov_empresa =? ";
		
    }
}