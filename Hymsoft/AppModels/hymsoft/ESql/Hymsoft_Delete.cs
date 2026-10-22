using System;
using PowerServer.Core;

namespace Hymsoft
{
    public class Hymsoft_Delete
    {	
		public static string sqlHandle_04_71E3F9C5 = "delete from incantidades where cant_g_financiero =? and cant_empresa =? ";
		
		public static string sqlHandle_04_C705DE54 = "DELETE FROM bamcuent WHERE ( bamcuent.cuen_g_financiero =? ) AND ( bamcuent.cuen_empresa =? ) AND ( bamcuent.cuen_banco =? ) AND ( bamcuent.cuen_no_cuenta =? ) ";
		
		public static string sqlHandle_04_C774B16E = "DELETE FROM cpmprove WHERE ( cpmprove.prov_g_financiero =? ) AND ( cpmprove.prov_empresa =? ) AND ( cpmprove.prov_tercero =? ) ";
		
		public static string sqlHandle_04_B7DDB4D8 = "DELETE FROM usuarios_accesos WHERE ( usuarios_accesos.priv_g_financiero =? ) AND ( usuarios_accesos.priv_empresa =? ) AND ( usuarios_accesos.priv_usuario =? ) ";
		
		public static string sqlHandle_04_9784CE8D = "DELETE FROM empresas_usuario WHERE empresas_usuario.emus_usuario =? ";
		
		public static string sqlHandle_04_7085CEE3 = "DELETE FROM ccatempa WHERE ( ccatempa.tmpa_g_financiero =? ) AND ( ccatempa.tmpa_empresa =? ) and ( ccatempa.tmpa_usuario_maquina =? ) ";
		
		public static string sqlHandle_04_50DD70B4 = "DELETE FROM cchestado WHERE ( cchestado.est_g_financiero =? ) AND ( cchestado.est_empresa =? ) AND ( cchestado.est_usuario_maquina =? ) ";
		
		public static string sqlHandle_04_BC99E10F = "DELETE FROM cpdrefac WHERE ( cpdrefac.refa_g_financiero =? ) AND ( cpdrefac.refa_empresa =? ) AND ( cpdrefac.refa_tipo_transaccion =? ) AND ( cpdrefac.refa_sub_transaccion =? ) AND ( cpdrefac.refa_documento =? ) AND ( cpdrefac.refa_referencia =? ) AND ( cpdrefac.refa_ann =? ) ";
		
		public static string sqlHandle_04_F91158BD = "delete FROM cptmovim WHERE ( cptmovim.movi_g_financiero =? ) AND ( cptmovim.movi_empresa =? ) AND ( cptmovim.movi_aplicacion ='BA' ) AND ( cptmovim.movi_tipo_transaccion =? ) AND ( cptmovim.movi_sub_transaccion =? ) AND ( cptmovim.movi_documento =? ) AND ( cptmovim.movi_anno =? ) AND ( cptmovim.movi_referencia =? ) ";
		
		public static string sqlHandle_04_EBBF4B99 = "delete FROM cctmovim WHERE ( cctmovim.movi_g_financiero =? ) AND ( cctmovim.movi_empresa =? ) AND ( cctmovim.movi_aplicacion ='BA' ) AND ( cctmovim.movi_tipo_transaccion =? ) AND ( cctmovim.movi_sub_transaccion =? ) AND ( cctmovim.movi_documento =? ) AND ( cctmovim.movi_anno =? ) AND ( cctmovim.movi_referencia =? ) ";
		
		public static string sqlHandle_04_5D57B12A = "DELETE FROM coddiari WHERE ( coddiari.ddia_g_financiero =? ) AND ( coddiari.ddia_empresa =? ) AND ( coddiari.ddia_aplicacion_mg ='BA' ) AND ( coddiari.ddia_tipo_transaccion =? ) AND ( coddiari.ddia_sub_trans =? ) AND ( coddiari.ddia_no_documento =? ) AND ( coddiari.ddia_no_referencia =? ) AND ( coddiari.ddia_banco_cuenta =? ) and ( coddiari.ddia_ann =? ) ";
		
		public static string sqlHandle_04_6B9111C9 = "DELETE FROM cotdiari WHERE ( cotdiari.diar_g_financiero =? ) AND ( cotdiari.diar_empresa =? ) AND ( cotdiari.diar_aplicacion_mg ='BA' ) AND ( cotdiari.diar_tipo_transaccion =? ) AND ( cotdiari.diar_sub_trans =? ) AND ( cotdiari.diar_no_documento =? ) AND ( cotdiari.diar_no_referencia =? ) AND ( cotdiari.diar_banco_cuenta =? ) AND ( cotdiari.diar_ann =? ) ";
		
		public static string sqlHandle_04_315CFDD5 = "Delete FROM cctmovim WHERE ( cctmovim.movi_g_financiero =? ) AND ( cctmovim.movi_empresa =? ) AND ( cctmovim.movi_aplicacion ='BA' ) AND ( cctmovim.movi_tipo_transaccion =? ) AND ( cctmovim.movi_sub_transaccion =? ) AND ( cctmovim.movi_documento =? ) AND ( cctmovim.movi_anno =? ) AND ( cctmovim.movi_referencia =? ) ";
		
		public static string sqlHandle_04_830F28E4 = "DELETE FROM coddiari WHERE ( coddiari.ddia_g_financiero =? ) AND ( coddiari.ddia_empresa =? ) AND ( coddiari.ddia_aplicacion_mg ='BA' ) AND ( coddiari.ddia_tipo_transaccion =? ) AND ( coddiari.ddia_sub_trans =? ) AND ( coddiari.ddia_no_documento =? ) AND ( coddiari.ddia_no_referencia =? ) AND ( coddiari.ddia_banco_cuenta =? ) AND ( coddiari.ddia_ann =? ) ";
		
		public static string sqlHandle_04_AAD3175A = "DELETE FROM ccatpan WHERE ( ccatpan.tpan_g_financiero =? ) AND ( ccatpan.tpan_empresa =? ) AND ( ccatpan.tpan_maquina =? ) ";
		
		public static string sqlHandle_04_CB680894 = "DELETE FROM ccatemaf WHERE ( tmaf_g_financiero =? ) AND ( tmaf_empresa =? ) AND ( tmaf_usuario_maquina =? ) ";
		
		public static string sqlHandle_04_198A0F67 = "DELETE FROM comayor WHERE ( comayor.mayo_g_financiero =? ) AND ( comayor.mayo_empresa =? ) AND ( comayor.mayo_cuenta =? ) ";
		
		public static string sqlHandle_04_73F4A7DB = "DELETE FROM coddiari WHERE ( coddiari.ddia_g_financiero =? ) AND ( coddiari.ddia_empresa =? ) AND ( coddiari.ddia_aplicacion_mg ='CO' ) AND ( coddiari.ddia_tipo_transaccion ='RA' ) AND ( coddiari.ddia_sub_trans ='RA' ) AND ( coddiari.ddia_no_documento ='1' ) AND ( coddiari.ddia_no_referencia ='1' ) AND ( coddiari.ddia_ann =? ) ";
		
		public static string sqlHandle_04_39EB67D8 = "DELETE FROM cotdiari WHERE ( cotdiari.diar_g_financiero =? ) AND ( cotdiari.diar_empresa =? ) AND ( cotdiari.diar_aplicacion_mg ='CO' ) AND ( cotdiari.diar_tipo_transaccion ='RA' ) AND ( cotdiari.diar_sub_trans ='RA' ) AND ( cotdiari.diar_no_documento ='1' ) AND ( cotdiari.diar_no_referencia ='1' ) AND ( cotdiari.diar_ann =? ) ";
		
		public static string sqlHandle_04_96566F8C = "DELETE FROM coddiari WHERE ( coddiari.ddia_g_financiero =? ) AND ( coddiari.ddia_empresa =? ) AND ( coddiari.ddia_aplicacion_mg ='CO' ) AND ( coddiari.ddia_tipo_transaccion =? ) AND ( coddiari.ddia_sub_trans =? ) AND ( coddiari.ddia_no_documento =? ) AND ( coddiari.ddia_no_referencia =? ) AND ( coddiari.ddia_ann =? ) ";
		
		public static string sqlHandle_04_DB34F02 = "DELETE FROM cotdiari WHERE ( cotdiari.diar_g_financiero =? ) AND ( cotdiari.diar_empresa =? ) AND ( cotdiari.diar_aplicacion_mg ='CO' ) AND ( cotdiari.diar_tipo_transaccion =? ) AND ( cotdiari.diar_sub_trans =? ) AND ( cotdiari.diar_no_documento =? ) AND ( cotdiari.diar_no_referencia =? ) AND ( cotdiari.diar_ann =? ) ";
		
		public static string sqlHandle_04_31F6667D = "DELETE FROM banadpagar WHERE ( banadpagar.dpaga_g_financiero =? ) AND ( banadpagar.dpaga_empresa =? ) AND ( banadpagar.dpaga_aplicacion ='NA' ) AND ( banadpagar.dpaga_transaccion ='CM' ) AND ( banadpagar.dpaga_subtransaccion ='CM' ) AND ( banadpagar.dpaga_documento =? ) AND ( banadpagar.dpaga_agno =? ) AND ( banadpagar.dpaga_transito =? ) ";
		
		public static string sqlHandle_04_7E828CF6 = "DELETE FROM banatpagar WHERE ( banatpagar.tpaga_g_financiero =? ) AND ( banatpagar.tpaga_empresa =? ) AND ( banatpagar.tpaga_aplicacion ='NA' ) AND ( banatpagar.tpaga_transaccion ='CM' ) AND ( banatpagar.tpaga_subtransaccion ='CM' ) AND ( banatpagar.tpaga_documento =? ) AND ( banatpagar.tpaga_agno =? ) AND ( banatpagar.tpaga_transito =? ) ";
		
		public static string sqlHandle_04_4FC40479 = "DELETE FROM cctmovim WHERE ( cctmovim.movi_g_financiero =? ) AND ( cctmovim.movi_empresa =? ) AND ( cctmovim.movi_aplicacion ='NA' ) AND ( cctmovim.movi_tipo_transaccion ='NB' ) AND ( cctmovim.movi_sub_transaccion ='NB' ) AND ( cctmovim.movi_documento =? ) AND ( cctmovim.movi_anno =? ) AND ( cctmovim.movi_referencia =? ) ";
		
		public static string sqlHandle_04_435358A7 = "DELETE FROM banadpagar WHERE ( banadpagar.dpaga_g_financiero =? ) AND ( banadpagar.dpaga_empresa =? ) AND ( banadpagar.dpaga_transito =? ) AND ( banadpagar.dpaga_documento =? ) AND ( banadpagar.dpaga_agno =? ) AND ( banadpagar.dpaga_aplicacion ='NA' ) AND ( banadpagar.dpaga_transaccion =? ) AND ( banadpagar.dpaga_subtransaccion =? ) ";
		
		public static string sqlHandle_04_EAFC02EE = "DELETE FROM banatpagar WHERE ( banatpagar.tpaga_g_financiero =? ) AND ( banatpagar.tpaga_empresa =? ) AND ( banatpagar.tpaga_transito =? ) AND ( banatpagar.tpaga_documento =? ) AND ( banatpagar.tpaga_agno =? ) AND ( banatpagar.tpaga_aplicacion ='NA' ) AND ( banatpagar.tpaga_transaccion =? ) AND ( banatpagar.tpaga_subtransaccion =? ) ";
		
		public static string sqlHandle_04_A9E8B97A = "DELETE FROM cctmovim WHERE ( cctmovim.movi_g_financiero =? ) AND ( cctmovim.movi_empresa =? ) AND ( cctmovim.movi_aplicacion ='NA' ) AND ( cctmovim.movi_tipo_transaccion ='NB' ) AND ( cctmovim.movi_sub_transaccion ='NB' ) AND ( cctmovim.movi_documento =? ) AND ( cctmovim.movi_anno =? ) AND ( cctmovim.movi_referencia =? ) AND ( cctmovim.movi_transaccion_origen =? ) ";
		
		public static string sqlHandle_04_2510C45F = "DELETE FROM cctantig WHERE ( cctantig.ant_g_financiero =? ) AND ( cctantig.ant_empresa =? ) AND ( cctantig.ant_usuario_maquina =? ) ";
		
		public static string sqlHandle_04_6C7F3384 = "DELETE FROM ccatempa WHERE ( ccatempa.tmpa_g_financiero =? ) AND ( ccatempa.tmpa_empresa =? ) AND ( ccatempa.tmpa_usuario_maquina =? ) ";
		
		public static string sqlHandle_04_4AAC03B2 = "DELETE FROM cctantig WHERE 0 =( SELECT sum ( cct.ant_facturas - cct.ant_recibos ) FROM cctantig cct WHERE ( cct.ant_g_financiero =cctantig.ant_g_financiero ) AND ( cct.ant_empresa =cctantig.ant_empresa ) AND ( cct.ant_tercero =cctantig.ant_tercero ) AND ( cct.ant_usuario_maquina =cctantig.ant_usuario_maquina ) GROUP BY cct.ant_g_financiero , cct.ant_empresa , cct.ant_tercero ) and cctantig.ant_g_financiero =? and cctantig.ant_empresa =? and cctantig.ant_usuario_maquina =? ";
		
		public static string sqlHandle_04_AAE21A05 = "DELETE FROM cctantig WHERE 0 > ( SELECT sum ( cct.ant_facturas - cct.ant_recibos ) FROM cctantig cct WHERE ( cct.ant_g_financiero =cctantig.ant_g_financiero ) AND ( cct.ant_empresa =cctantig.ant_empresa ) AND ( cct.ant_tercero =cctantig.ant_tercero ) GROUP BY cct.ant_g_financiero , cct.ant_empresa , cct.ant_tercero ) and cctantig.ant_g_financiero =? and cctantig.ant_empresa =? and cctantig.ant_usuario_maquina =? ";
		
		public static string sqlHandle_04_F19A8A3D = "DELETE FROM cctantig WHERE 0 < ( SELECT sum ( cct.ant_facturas - cct.ant_recibos ) FROM cctantig cct WHERE ( cct.ant_g_financiero =cctantig.ant_g_financiero ) AND ( cct.ant_empresa =cctantig.ant_empresa ) AND ( cct.ant_tercero =cctantig.ant_tercero ) GROUP BY cct.ant_g_financiero , cct.ant_empresa , cct.ant_tercero ) and cctantig.ant_g_financiero =? and cctantig.ant_empresa =? and cctantig.ant_usuario_maquina =? ";
		
		public static string sqlHandle_04_1A835EEA = "delete from ccatempa ";
		
		public static string sqlHandle_04_DDA916E6 = "delete from ccatempa where tmpa_g_financiero =? and tmpa_empresa =? and tmpa_tercero =? ";
		
		public static string sqlHandle_04_259081DE = "DELETE FROM ccdrefac WHERE ( ccdrefac.refa_g_financiero =? ) AND ( ccdrefac.refa_empresa =? ) AND ( ccdrefac.refa_tipo_transaccion =? ) AND ( ccdrefac.refa_sub_transaccion =? ) AND ( ccdrefac.refa_documento =? ) AND ( ccdrefac.refa_referencia =? ) AND ( ccdrefac.refa_ann =? ) ";
		
		public static string sqlHandle_04_42D66CB3 = "DELETE FROM coddiari WHERE ( coddiari.ddia_g_financiero =? ) AND ( coddiari.ddia_empresa =? ) AND ( coddiari.ddia_aplicacion_mg ='CC' ) AND ( coddiari.ddia_tipo_transaccion =? ) AND ( coddiari.ddia_sub_trans =? ) AND ( coddiari.ddia_no_documento =? ) AND ( coddiari.ddia_no_referencia =? ) AND ( coddiari.ddia_ann =? ) ";
		
		public static string sqlHandle_04_D9334C3D = "DELETE FROM cotdiari WHERE ( cotdiari.diar_g_financiero =? ) AND ( cotdiari.diar_empresa =? ) AND ( cotdiari.diar_aplicacion_mg ='CC' ) AND ( cotdiari.diar_tipo_transaccion =? ) AND ( cotdiari.diar_sub_trans =? ) AND ( cotdiari.diar_no_documento =? ) AND ( cotdiari.diar_no_referencia =? ) AND ( cotdiari.diar_ann =? ) ";
		
		public static string sqlHandle_04_FEF4C37E = "DELETE FROM coddiari WHERE ( coddiari.ddia_g_financiero =? ) AND ( coddiari.ddia_empresa =? ) AND ( coddiari.ddia_aplicacion_mg ='CC' ) AND ( coddiari.ddia_tipo_transaccion =? ) AND ( coddiari.ddia_sub_trans =? ) AND ( coddiari.ddia_sub_trans =? ) AND ( coddiari.ddia_no_documento =? ) AND ( coddiari.ddia_no_referencia =? ) AND ( coddiari.ddia_ann =? ) ";
		
		public static string sqlHandle_04_7A087E42 = "DELETE FROM ccdrefac WHERE ( ccdrefac.refa_g_financiero =? ) AND ( ccdrefac.refa_empresa =? ) AND ( ccdrefac.refa_tercero =? ) AND ( ccdrefac.refa_fecha_recibo >= ? ) AND ( ccdrefac.refa_fecha_recibo <= ? ) ";
		
		public static string sqlHandle_04_A55BA00B = "DELETE FROM ccatempa WHERE ( ccatempa.tmpa_g_financiero =? ) AND ( ccatempa.tmpa_empresa =? ) and ( ccatempa.tmpa_tercero =? ) AND ( ccatempa.tmpa_usuario_maquina =? ) ";
		
		public static string sqlHandle_04_7F24C9A = "DELETE FROM ccmclien WHERE ( ccmclien.clie_g_financiero =? ) AND ( ccmclien.clie_empresa =? ) AND ( ccmclien.clie_tercero =? ) ";
		
		public static string sqlHandle_04_441A7975 = "DELETE banadpagar WHERE ( banadpagar.dpaga_g_financiero =? ) AND ( banadpagar.dpaga_empresa =? ) AND ( banadpagar.dpaga_transito =? ) AND ( banadpagar.dpaga_documento =? ) AND ( banadpagar.dpaga_agno =? ) AND ( banadpagar.dpaga_aplicacion ='NA' ) AND ( banadpagar.dpaga_transaccion =? ) AND ( banadpagar.dpaga_subtransaccion =? ) ";
		
		public static string sqlHandle_04_EDB5233C = "DELETE banatpagar WHERE ( banatpagar.tpaga_g_financiero =? ) AND ( banatpagar.tpaga_empresa =? ) AND ( banatpagar.tpaga_transito =? ) AND ( banatpagar.tpaga_documento =? ) AND ( banatpagar.tpaga_agno =? ) AND ( banatpagar.tpaga_aplicacion ='NA' ) AND ( banatpagar.tpaga_transaccion =? ) AND ( banatpagar.tpaga_subtransaccion =? ) ";
		
		public static string sqlHandle_04_A00EED33 = "DELETE cctmovim WHERE ( cctmovim.movi_g_financiero =? ) AND ( cctmovim.movi_empresa =? ) AND ( cctmovim.movi_aplicacion ='NA' ) AND ( cctmovim.movi_tipo_transaccion ='NB' ) AND ( cctmovim.movi_sub_transaccion ='NB' ) AND ( cctmovim.movi_documento =? ) AND ( cctmovim.movi_anno =? ) AND ( cctmovim.movi_referencia =? ) AND ( cctmovim.movi_transaccion_origen =? ) ";
		
		public static string sqlHandle_04_8AD7AC32 = "DELETE banadpagar WHERE ( banadpagar.dpaga_g_financiero =? ) AND ( banadpagar.dpaga_empresa =? ) AND ( banadpagar.dpaga_documento =? ) AND ( banadpagar.dpaga_agno =? ) AND ( banadpagar.dpaga_aplicacion ='NA' ) AND ( banadpagar.dpaga_transaccion =? ) AND ( banadpagar.dpaga_subtransaccion =? ) ";
		
		public static string sqlHandle_04_619F4E7A = "DELETE banatpagar WHERE ( banatpagar.tpaga_g_financiero =? ) AND ( banatpagar.tpaga_empresa =? ) AND ( banatpagar.tpaga_documento =? ) AND ( banatpagar.tpaga_agno =? ) AND ( banatpagar.tpaga_aplicacion ='NA' ) AND ( banatpagar.tpaga_transaccion =? ) AND ( banatpagar.tpaga_subtransaccion =? ) ";
		
		public static string sqlHandle_04_5A6B6A2B = "Delete From ccatempa where tmpa_g_financiero =? and tmpa_empresa =? and tmpa_usuario_maquina =? ";
		
		public static string sqlHandle_04_834644F8 = "delete from cctcancl where ancl_maquina =? ";
		
		public static string sqlHandle_04_AE9DEFE3 = "delete from cpatempa where tmpa_g_financiero =? and tmpa_empresa =? ";
		
		public static string sqlHandle_04_7973878 = "DELETE FROM cpatpan WHERE ( cpatpan.tpan_g_financiero =? ) AND ( cpatpan.tpan_empresa =? ) AND ( cpatpan.tpan_maquina =? ) ";
		
		public static string sqlHandle_04_F631988A = "DELETE FROM cpatempa WHERE ( cpatempa.tmpa_g_financiero =? ) AND ( cpatempa.tmpa_empresa =? ) and ( cpatempa.tmpa_maquina =? ) ";
		
		public static string sqlHandle_04_B0CCAEE6 = "DELETE FROM coddiari WHERE ( coddiari.ddia_g_financiero =? ) AND ( coddiari.ddia_empresa =? ) AND ( coddiari.ddia_aplicacion_mg ='CP' ) AND ( coddiari.ddia_tipo_transaccion =? ) AND ( coddiari.ddia_sub_trans =? ) AND ( coddiari.ddia_no_documento =? ) AND ( coddiari.ddia_no_referencia =? ) AND ( coddiari.ddia_ann =? ) ";
		
		public static string sqlHandle_04_2B298E68 = "DELETE FROM cotdiari WHERE ( cotdiari.diar_g_financiero =? ) AND ( cotdiari.diar_empresa =? ) AND ( cotdiari.diar_aplicacion_mg ='CP' ) AND ( cotdiari.diar_tipo_transaccion =? ) AND ( cotdiari.diar_sub_trans =? ) AND ( cotdiari.diar_no_documento =? ) AND ( cotdiari.diar_no_referencia =? ) AND ( cotdiari.diar_ann =? ) ";
		
		public static string sqlHandle_04_264B54F8 = "DELETE FROM banadpagar WHERE ( banadpagar.dpaga_g_financiero =? ) AND ( banadpagar.dpaga_empresa =? ) AND ( banadpagar.dpaga_transito =? ) AND ( banadpagar.dpaga_documento_original =? ) AND ( banadpagar.dpaga_agno =? ) AND ( banadpagar.dpaga_aplicacion ='CP' ) AND ( banadpagar.dpaga_transaccion =? ) AND ( banadpagar.dpaga_subtransaccion =? ) ";
		
		public static string sqlHandle_04_B4A7EF75 = "DELETE FROM banatpagar WHERE ( banatpagar.tpaga_g_financiero =? ) AND ( banatpagar.tpaga_empresa =? ) AND ( banatpagar.tpaga_transito =? ) AND ( banatpagar.tpaga_documento_original =? ) AND ( banatpagar.tpaga_agno =? ) AND ( banatpagar.tpaga_aplicacion ='CP' ) AND ( banatpagar.tpaga_transaccion =? ) AND ( banatpagar.tpaga_subtransaccion =? ) ";
		
		public static string sqlHandle_04_B890CCFD = "DELETE FROM banadpagar WHERE ( banadpagar.dpaga_g_financiero =? ) AND ( banadpagar.dpaga_empresa =? ) AND ( banadpagar.dpaga_transito =? ) AND ( ( banadpagar.dpaga_documento =? ) or ( banadpagar.dpaga_documento like ? + '-%' ) ) AND ( banadpagar.dpaga_agno =? ) AND ( banadpagar.dpaga_aplicacion =? ) AND ( banadpagar.dpaga_transaccion =? ) AND ( banadpagar.dpaga_subtransaccion =? ) ";
		
		public static string sqlHandle_04_35077EAB = "DELETE FROM banatpagar WHERE ( banatpagar.tpaga_g_financiero =? ) AND ( banatpagar.tpaga_empresa =? ) AND ( banatpagar.tpaga_transito =? ) AND ( ( banatpagar.tpaga_documento =? ) or ( banatpagar.tpaga_documento like ? + '-%' ) ) AND ( banatpagar.tpaga_agno =? ) AND ( banatpagar.tpaga_aplicacion =? ) AND ( banatpagar.tpaga_transaccion =? ) AND ( banatpagar.tpaga_subtransaccion =? ) ";
		
		public static string sqlHandle_04_3241B406 = "Delete FROM banadpagar WHERE ( banadpagar.dpaga_g_financiero =? ) AND ( banadpagar.dpaga_empresa =? ) AND ( banadpagar.dpaga_transito =? ) AND ( ( banadpagar.dpaga_documento =? ) or ( banadpagar.dpaga_documento like ? + '-%' ) ) AND ( banadpagar.dpaga_agno =? ) AND ( banadpagar.dpaga_aplicacion ='CP' ) AND ( banadpagar.dpaga_transaccion =? ) AND ( banadpagar.dpaga_subtransaccion =? ) ";
		
		public static string sqlHandle_04_E25D17C8 = "Delete FROM banatpagar WHERE ( banatpagar.tpaga_g_financiero =? ) AND ( banatpagar.tpaga_empresa =? ) AND ( banatpagar.tpaga_transito =? ) AND ( ( banatpagar.tpaga_documento =? ) or ( banatpagar.tpaga_documento like ? + '-%' ) ) AND ( banatpagar.tpaga_agno =? ) AND ( banatpagar.tpaga_aplicacion ='CP' ) AND ( banatpagar.tpaga_transaccion =? ) AND ( banatpagar.tpaga_subtransaccion =? ) ";
		
		public static string sqlHandle_04_97DA9DE4 = "DELETE FROM cpdrefac WHERE ( cpdrefac.refa_g_financiero =? ) AND ( cpdrefac.refa_empresa =? ) AND ( cpdrefac.refa_tercero =? ) AND ( cpdrefac.refa_fecha_recibo >= ? ) AND ( cpdrefac.refa_fecha_recibo <= ? ) ";
		
		public static string sqlHandle_04_1B3AE512 = "delete FROM inmbodeg WHERE ( inmbodeg.mbod_g_financiero =? ) AND ( inmbodeg.mbod_empresa =? ) AND ( inmbodeg.mbod_producto =? ) ";
		
		public static string sqlHandle_04_61B67C21 = "delete FROM inmprodu WHERE ( inmprodu.prod_g_financiero =? ) AND ( inmprodu.prod_empresa =? ) AND ( inmprodu.prod_producto =? ) ";
		
		public static string sqlHandle_04_FF600DCE = "DELETE FROM orden_detalle WHERE ( orden_detalle.deta_g_financiero =? ) AND ( orden_detalle.deta_empresa =? ) AND ( orden_detalle.deta_secuencia =? ) AND ( orden_detalle.deta_ann =? ) ";
		
		public static string sqlHandle_04_1C000E59 = "DELETE FROM cptmovim WHERE ( cptmovim.movi_g_financiero =? ) AND ( cptmovim.movi_empresa =? ) AND ( cptmovim.movi_aplicacion ='CP' ) AND ( cptmovim.movi_tipo_transaccion ='OC' ) AND ( cptmovim.movi_sub_transaccion ='OC' ) AND ( cptmovim.movi_documento =? ) AND ( cptmovim.movi_anno =? ) AND ( cptmovim.movi_referencia =? ) ";
		
		public static string sqlHandle_04_A6698745 = "DELETE FROM cpdrefac WHERE ( cpdrefac.refa_g_financiero =? ) AND ( cpdrefac.refa_empresa =? ) AND ( cpdrefac.refa_aplicacion_ori ='CP' ) AND ( cpdrefac.refa_tipo_transaccion_ori ='OC' ) AND ( cpdrefac.refa_sub_transaccion_ori ='OC' ) AND ( cpdrefac.refa_documento_ori =? ) AND ( cpdrefac.refa_referencia_ori =? ) AND ( cpdrefac.refa_tercero =? ) ";
		
		public static string sqlHandle_04_73D57F5D = "DELETE FROM intmovim WHERE ( intmovim.tmov_g_financiero =? ) AND ( intmovim.tmov_empresa =? ) AND ( intmovim.tmov_aplicacion ='IN' ) AND ( intmovim.tmov_tipo_transaccion ='EN' ) AND ( intmovim.tmov_secuencia =? ) AND ( intmovim.tmov_anual =? ) ";
		
		public static string sqlHandle_04_D18226CD = "DELETE FROM indmovim WHERE ( indmovim.dmov_g_financiero =? ) AND ( indmovim.dmov_empresa =? ) AND ( indmovim.dmov_aplicacion ='IN' ) AND ( indmovim.dmov_tipo_transaccion ='EN' ) AND ( indmovim.dmov_secuencia =? ) AND ( indmovim.dmov_anual =? ) ";
		
		public static string sqlHandle_04_8DE441E1 = "DELETE FROM indgasto WHERE ( indgasto.gast_g_financiero =? ) AND ( indgasto.gast_empresa =? ) AND ( indgasto.gast_aplicacion ='IN' ) AND ( indgasto.gast_transaccion ='EN' ) AND ( indgasto.gast_secuencia =? ) AND ( indgasto.gast_ann =? ) ";
		
		public static string sqlHandle_04_6F51B260 = "DELETE FROM intmovim WHERE ( intmovim.tmov_g_financiero =? ) AND ( intmovim.tmov_empresa =? ) AND ( intmovim.tmov_aplicacion ='IN' ) AND ( intmovim.tmov_tipo_transaccion ='EN' ) AND ( intmovim.tmov_secuencia =? ) AND ( intmovim.tmov_anual =? ) AND ( intmovim.tmov_concepto =? ) ";
		
		public static string sqlHandle_04_FA51506E = "DELETE FROM transito_detalle WHERE ( transito_detalle.deta_g_financiero =? ) AND ( transito_detalle.deta_empresa =? ) AND ( transito_detalle.deta_secuencia =? ) AND ( transito_detalle.deta_ann =? ) ";
		
		public static string sqlHandle_04_E0C8C660 = "DELETE FROM tzdtraf1 WHERE ( tzdtraf1.traf_g_financiero =? ) AND ( tzdtraf1.traf_empresa =? ) AND ( tzdtraf1.traf_ann =? ) AND ( tzdtraf1.traf_ent_sal ='EN' ) AND ( tzdtraf1.traf_pedido =\"is_pedido\" ) ";
		
		public static string sqlHandle_04_DF0C8028 = "DELETE FROM tzttraf0 WHERE ( tzttraf0.ttra_g_financiero =? ) AND ( tzttraf0.ttra_empresa =? ) AND ( tzttraf0.ttra_ann =? ) AND ( tzttraf0.ttra_ent_sal ='EN' ) AND ( tzttraf0.ttra_pedido =\"is_pedido\" ) ";
		
		public static string sqlHandle_04_5622D591 = "delete from fadvenfa where vfac_g_financiero =? and vfac_empresa =? and vfac_tipo =? and vfac_no_pedido =? and vfac_ann =? ";
		
		public static string sqlHandle_04_81B50C4A = "delete from indmovim WHERE ( indmovim.dmov_g_financiero =? ) AND ( indmovim.dmov_empresa =? ) AND ( indmovim.dmov_aplicacion ='FA' ) AND ( indmovim.dmov_tipo_transaccion =\"SA\" ) AND ( indmovim.dmov_secuencia =? ) AND ( indmovim.dmov_anual =? ) ";
		
		public static string sqlHandle_04_D72E16B3 = "delete from indgasto WHERE ( indgasto.gast_g_financiero =? ) AND ( indgasto.gast_empresa =? ) AND ( indgasto.gast_aplicacion ='FA' ) AND ( indgasto.gast_transaccion =\"SA\" ) AND ( indgasto.gast_secuencia =? ) AND ( indgasto.gast_ann =? ) ";
		
		public static string sqlHandle_04_23E255DA = "delete from intmovim WHERE ( intmovim.tmov_g_financiero =? ) AND ( intmovim.tmov_empresa =? ) AND ( intmovim.tmov_aplicacion ='FA' ) AND ( intmovim.tmov_tipo_transaccion =\"SA\" ) AND ( intmovim.tmov_secuencia =? ) AND ( intmovim.tmov_anual =? ) ";
		
		public static string sqlHandle_04_EE9C0BEA = "DELETE FROM faddiari WHERE ( faddiari.facd_g_financiero =? ) AND ( faddiari.facd_empresa =? ) AND ( faddiari.facd_no_pedido =? ) AND ( faddiari.facd_ann =? ) ";
		
		public static string sqlHandle_04_8B6FB424 = "DELETE FROM fadcargo WHERE ( fadcargo.dcar_g_financiero =? ) AND ( fadcargo.dcar_empresa =? ) AND ( fadcargo.dcar_no_pedido =? ) AND ( fadcargo.dcar_ann =? ) ";
		
		public static string sqlHandle_04_BC08B75 = "DELETE FROM fadvenfa WHERE ( fadvenfa.vfac_g_financiero =? ) AND ( fadvenfa.vfac_empresa =? ) AND ( fadvenfa.vfac_no_pedido =? ) AND ( fadvenfa.vfac_ann =? ) ";
		
		public static string sqlHandle_04_967DF38F = "DELETE FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_no_pedido =? ) AND ( fatdiari.fact_ann =? ) ";
		
		public static string sqlHandle_04_FA17467A = "delete from fadvenpr where vpro_g_financiero =? and vpro_empresa =? and vpro_no_proforma =? and vpro_ann =? ";
		
		public static string sqlHandle_04_80633E03 = "DELETE FROM coddiari WHERE ( coddiari.ddia_g_financiero =? ) AND ( coddiari.ddia_empresa =? ) AND ( coddiari.ddia_aplicacion_mg ='FA' ) AND ( coddiari.ddia_no_documento =? ) AND ( coddiari.ddia_ann =? ) ";
		
		public static string sqlHandle_04_473B29A8 = "DELETE FROM cotdiari WHERE ( cotdiari.diar_g_financiero =? ) AND ( cotdiari.diar_empresa =? ) AND ( cotdiari.diar_aplicacion_mg ='FA' ) AND ( cotdiari.diar_no_documento =? ) AND ( cotdiari.diar_ann =? ) ";
		
		public static string sqlHandle_04_1AB43B26 = "DELETE FROM fadprofo WHERE ( fadprofo.dpro_g_financiero =? ) AND ( fadprofo.dpro_empresa =? ) AND ( fadprofo.dpro_no_proforma =? ) AND ( fadprofo.dpro_ann =? ) ";
		
		public static string sqlHandle_04_2A7F4066 = "DELETE FROM fadproca WHERE ( fadproca.prca_g_financiero =? ) AND ( fadproca.prca_empresa =? ) AND ( fadproca.prca_no_proforma =? ) AND ( fadproca.prca_ann =? ) ";
		
		public static string sqlHandle_04_3FCCBCFE = "DELETE FROM fadvenpr WHERE ( fadvenpr.vpro_g_financiero =? ) AND ( fadvenpr.vpro_empresa =? ) AND ( fadvenpr.vpro_no_proforma =? ) AND ( fadvenpr.vpro_ann =? ) ";
		
		public static string sqlHandle_04_4A7DFB36 = "DELETE FROM fatprofo WHERE ( fatprofo.prof_g_financiero =? ) AND ( fatprofo.prof_empresa =? ) AND ( fatprofo.prof_no_proforma =? ) AND ( fatprofo.prof_ann =? ) ";
		
		public static string sqlHandle_04_1C6B7E1D = "DELETE FROM fadprofo2 WHERE ( fadprofo2.dpro_g_financiero =? ) AND ( fadprofo2.dpro_empresa =? ) AND ( fadprofo2.dpro_no_proforma =? ) AND ( fadprofo2.dpro_ann =? ) ";
		
		public static string sqlHandle_04_A999DEFF = "DELETE FROM fatprofo2 WHERE ( fatprofo2.prof_g_financiero =? ) AND ( fatprofo2.prof_empresa =? ) AND ( fatprofo2.prof_no_proforma =? ) AND ( fatprofo2.prof_ann =? ) ";
		
		public static string sqlHandle_04_D6688FE7 = "delete from fadvenpe where vped_g_financiero =? and vped_empresa =? and vped_no_pedido =? and vped_ann =? ";
		
		public static string sqlHandle_04_A6BCD0B0 = "DELETE FROM fadpedid WHERE ( fadpedid.dped_g_financiero =? ) AND ( fadpedid.dped_empresa =? ) AND ( fadpedid.dped_no_pedido =? ) AND ( fadpedid.dped_ann =? ) ";
		
		public static string sqlHandle_04_145C5045 = "DELETE FROM fadpecar WHERE ( fadpecar.peca_g_financiero =? ) AND ( fadpecar.peca_empresa =? ) AND ( fadpecar.peca_no_pedido =? ) AND ( fadpecar.peca_ann =? ) ";
		
		public static string sqlHandle_04_2DAA4EDD = "DELETE FROM fadvenpe WHERE ( fadvenpe.vped_g_financiero =? ) AND ( fadvenpe.vped_empresa =? ) AND ( fadvenpe.vped_no_pedido =? ) AND ( fadvenpe.vped_ann =? ) ";
		
		public static string sqlHandle_04_19962052 = "DELETE FROM fatpedid WHERE ( fatpedid.pedi_g_financiero =? ) AND ( fatpedid.pedi_empresa =? ) AND ( fatpedid.pedi_no_pedido =? ) AND ( fatpedid.pedi_ann =? ) ";
		
		public static string sqlHandle_04_8832EA6A = "DELETE FROM fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_ann =? ) AND ( fatdiari.fact_no_pedido =? ) ";
		
		public static string sqlHandle_04_36B36B31 = "DELETE FROM offaddiari WHERE ( offaddiari.facd_g_financiero =? ) AND ( offaddiari.facd_empresa =? ) AND ( offaddiari.facd_no_pedido =? ) AND ( offaddiari.facd_ann =? ) ";
		
		public static string sqlHandle_04_AC05F12 = "DELETE FROM offatdiari WHERE ( offatdiari.fact_g_financiero =? ) AND ( offatdiari.fact_empresa =? ) AND ( offatdiari.fact_no_pedido =? ) AND ( offatdiari.fact_ann =? ) ";
		
		public static string sqlHandle_04_D1973810 = "DELETE FROM fadcardes WHERE ( fadcardes.card_g_financiero =? ) AND ( fadcardes.card_empresa =? ) AND ( fadcardes.card_tipo =? ) AND ( fadcardes.card_no_pedido =? ) AND ( fadcardes.card_ann =? ) AND ( fadcardes.card_codigo =? ) ";
		
		public static string sqlHandle_04_30446FF = "DELETE FROM fadcargo WHERE ( fadcargo.dcar_g_financiero =? ) AND ( fadcargo.dcar_empresa =? ) AND ( fadcargo.dcar_tipo =? ) AND ( fadcargo.dcar_no_pedido =? ) AND ( fadcargo.dcar_ann =? ) ";
		
		public static string sqlHandle_04_C4DD2A4F = "Delete from fatdiari WHERE ( fatdiari.fact_g_financiero =? ) AND ( fatdiari.fact_empresa =? ) AND ( fatdiari.fact_tipo =? ) AND ( fatdiari.fact_no_pedido =? ) AND ( fatdiari.fact_ann =? ) ";
		
		public static string sqlHandle_04_FB1775DA = "DELETE FROM cctmovim WHERE ( cctmovim.movi_g_financiero =? ) AND ( cctmovim.movi_empresa =? ) AND ( cctmovim.movi_aplicacion ='FA' ) AND ( cctmovim.movi_tipo_transaccion in ( 'FA' , 'FC' , 'NC' ) ) AND ( cctmovim.movi_sub_transaccion in ( ? , '0' ) ) AND ( cctmovim.movi_documento =? ) AND ( cctmovim.movi_anno =? ) AND ( cctmovim.movi_referencia =? ) ";
		
		public static string sqlHandle_04_62CBD8FB = "DELETE FROM indmovim WHERE ( indmovim.dmov_g_financiero =? ) AND ( indmovim.dmov_empresa =? ) AND ( indmovim.dmov_aplicacion ='IN' ) AND ( indmovim.dmov_tipo_transaccion ='AE' ) AND ( indmovim.dmov_secuencia =? ) AND ( indmovim.dmov_anual =? ) ";
		
		public static string sqlHandle_04_74C776F0 = "DELETE FROM indgasto WHERE ( indgasto.gast_g_financiero =? ) AND ( indgasto.gast_empresa =? ) AND ( indgasto.gast_aplicacion ='IN' ) AND ( indgasto.gast_transaccion ='AE' ) AND ( indgasto.gast_secuencia =? ) AND ( indgasto.gast_ann =? ) ";
		
		public static string sqlHandle_04_C09C816B = "DELETE FROM intmovim WHERE ( intmovim.tmov_g_financiero =? ) AND ( intmovim.tmov_empresa =? ) AND ( intmovim.tmov_aplicacion ='IN' ) AND ( intmovim.tmov_tipo_transaccion ='AE' ) AND ( intmovim.tmov_secuencia =? ) AND ( intmovim.tmov_anual =? ) ";
		
		public static string sqlHandle_04_48DE46BD = "delete from inhprome where prom_g_financiero =? and prom_empresa =? ";
		
		public static string sqlHandle_04_4F69D74E = "DELETE FROM indtranfer WHERE ( indtranfer.dmov_g_financiero =? ) AND ( indtranfer.dmov_empresa =? ) AND ( indtranfer.dmov_aplicacion ='IN' ) AND ( indtranfer.dmov_tipo_transaccion ='TR' ) AND ( indtranfer.dmov_secuencia =? ) AND ( indtranfer.dmov_anual =? ) ";
		
		public static string sqlHandle_04_93E7DEA6 = "DELETE FROM intranfer WHERE ( intranfer.tmov_g_financiero =? ) AND ( intranfer.tmov_empresa =? ) AND ( intranfer.tmov_aplicacion ='IN' ) AND ( intranfer.tmov_tipo_transaccion ='TR' ) AND ( intranfer.tmov_secuencia =? ) AND ( intranfer.tmov_anual =? ) ";
		
		public static string sqlHandle_04_9FBE0EEF = "delete from inhprome where inhprome.prom_maquina ='IRI' + ? ";
		
		public static string sqlHandle_04_94B12E83 = "delete from inhprome where prom_g_financiero =? and prom_empresa =? and prom_maquina =? ";
		
		public static string sqlHandle_04_A2A90E90 = "DELETE FROM tzdtraf1 WHERE ( tzdtraf1.traf_g_financiero =? ) AND ( tzdtraf1.traf_empresa =? ) AND ( tzdtraf1.traf_ann =? ) AND ( tzdtraf1.traf_ent_sal ='SA' ) AND ( tzdtraf1.traf_pedido =\"is_pedido\" ) ";
		
		public static string sqlHandle_04_9D6D48D8 = "DELETE FROM tzttraf0 WHERE ( tzttraf0.ttra_g_financiero =? ) AND ( tzttraf0.ttra_empresa =? ) AND ( tzttraf0.ttra_ann =? ) AND ( tzttraf0.ttra_ent_sal ='SA' ) AND ( tzttraf0.ttra_pedido =\"is_pedido\" ) ";
		
		public static string sqlHandle_04_1274873A = "DELETE FROM ssaudito WHERE ( ssaudito.audi_usuario_apl =? ) AND ( ssaudito.audi_usuario_win =? ) AND ( ssaudito.audi_maquina =? ) AND ( ssaudito.audi_cod_aplicacion =? ) AND ( ssaudito.audi_g_seguridad =? ) AND ( ssaudito.audi_ventana =? ) ";
		
		public static string sqlHandle_04_F8FB4E9E = "DELETE FROM ssaudito WHERE ( ssaudito.audi_usuario_apl =? ) AND ( ssaudito.audi_usuario_win =? ) AND ( ssaudito.audi_maquina =? ) AND ( ssaudito.audi_cod_aplicacion =? ) AND ( ssaudito.audi_g_seguridad =? ) ";
		
		public static string sqlHandle_04_6AE25C94 = "DELETE FROM inreport WHERE ( inreport.repo_grupo_financiero =? ) AND ( inreport.repo_empresa =? ) AND ( inreport.repo_cod_reporte =? ) ";
		
    }
}