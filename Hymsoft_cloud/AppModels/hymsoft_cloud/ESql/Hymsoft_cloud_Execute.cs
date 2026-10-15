using System;
using PowerServer.Core;

namespace Hymsoft_cloud
{
    public class Hymsoft_Cloud_Execute
    {	
		public static string sqlHandle_08_925E5122 = "execute sp_cc_recibos_factura @gf =? , @emp =? , @cliente =? , @cliente1 =? , @fecha =? , @usuario_maquina =? ";
		
		public static string sqlHandle_08_6EC57473 = "execute fa_reservados_totaldos @g_financiero =? , @empresa =? , @codigo_producto =? ";
		
		public static string sqlHandle_08_5A013065 = "execute sp_in_proc_costo_promedio_real @p_gf =? , @p_emp =? , @maquina =? , @p_fecha_i =? ";
		
		public static string sqlHandle_08_9638C077 = "execute sp_in_proc_costo_promedio_p @p_gf =? , @p_emp =? , @maquina =? , @p_fecha_i =? ";
		
		public static string sqlHandle_08_93A6726D = "execute sp_actualiza_margen_y_precio @g_financiero =? , @empresa =? , @producto =? ";
		
    }
}