//objectcomments Consulta de Facturas
forward
global type w_recalcula_mayor_general from w_fa_padre_reportes
end type
type st_1 from statictext within w_recalcula_mayor_general
end type
end forward

global type w_recalcula_mayor_general from w_fa_padre_reportes
integer x = 5
integer y = 20
integer width = 1298
integer height = 572
string title = "Actualizando Mayor General"
long backcolor = 12639424
string icon = "AppIcon!"
event ue_buscar ( )
st_1 st_1
end type
global w_recalcula_mayor_general w_recalcula_mayor_general

type variables
string  is_tipo,is_pedido
integer ii_ann

datawindowchild idw_child

datastore lds_nivel
end variables

forward prototypes
public subroutine wf_fecha ()
public subroutine wf_nofecha ()
public function string wf_verificar (string ls_original)
public function boolean wf_blanquear_mayor (integer al_ann_actual, integer al_mes_actual, integer al_ann)
public function boolean wf_saldos_iniciales (integer al_ann_actual, integer al_mes_actual, integer al_ann)
public function boolean wf_acumula_en_niveles_anteriores (string ls_cuenta, decimal ld_monto, string ls_naturaleza, integer li_ann, integer li_mes, string ls_transaccion)
end prototypes

public subroutine wf_fecha ();//dw_2.visible = false
//em_1.visible = True
//em_1.text = string(today())
//em_2.visible = True
//em_2.text = string(today())
//pb_1.visible = True
//st_2.visible = True
//st_3.visible = True
//em_1.setfocus()
//
end subroutine

public subroutine wf_nofecha ();//dw_2.visible = true
//em_1.visible = false
//em_2.visible = false
//pb_1.visible = false
//st_2.visible = false
//st_3.visible = false
//dw_2.setfocus()
//dw_2.SetColumn("Texto")
//
end subroutine

public function string wf_verificar (string ls_original);//Se verifican las opciones de parámetros y se filtra
string ls_where
  
  if w_fa_fondo.str_para.mostrar <> 0 then  //mostrar un Año específico

	CHOOSE CASE w_fa_fondo.str_para.desde	//Si es desde el año en adelante o el año exclusivo.
		CASE 0

		 ls_where = ls_original + " where &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+" ) and &
					 (fatdiari.fact_ann = "+string(w_fa_fondo.str_para.mostrar)+" ) AND &
 					 ( fatdiari.fact_no_pedido not like '%NC%' )"	
		CASE 1
		 ls_where = ls_original + " where  &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+" ) and &
					 (fatdiari.fact_ann >= "+string(w_fa_fondo.str_para.mostrar)+" ) AND &
 					 ( fatdiari.fact_no_pedido not like '%NC%' )"		
	END CHOOSE			
	
  else
		 ls_where = ls_original + " where  &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+" ) AND &
 					 ( fatdiari.fact_no_pedido not like '%NC%' )"	
  end if
  
  if pos(gf_dg_nombre_empresa(),'ELBROS') > 0 then
	  ls_where = ls_where + " and (fatdiari.fact_no_factura <> '0' )"
  end if	
  
return(ls_where)
end function

public function boolean wf_blanquear_mayor (integer al_ann_actual, integer al_mes_actual, integer al_ann);
choose case al_mes_actual
	case 1	
		 UPDATE comayor  
		  SET mayo_ene_inicial = 0, mayo_ene_db = 0, mayo_ene_cr = 0, mayo_feb_inicial = 0, mayo_feb_db = 0, mayo_feb_cr = 0,   
				mayo_mar_inicial = 0, mayo_mar_db = 0, mayo_mar_cr = 0, mayo_abr_inicial = 0, mayo_abr_db = 0, mayo_abr_cr = 0,   
				mayo_may_inicial = 0, mayo_may_db = 0, mayo_may_cr = 0, mayo_jun_inicial = 0, mayo_jun_db = 0, mayo_jun_cr = 0,   
				mayo_jul_inicial = 0, mayo_jul_db = 0, mayo_jul_cr = 0, mayo_ago_inicial = 0, mayo_ago_db = 0, mayo_ago_cr = 0,   
				mayo_sep_inicial = 0, mayo_sep_db = 0, mayo_sep_cr = 0, mayo_oct_inicial = 0, mayo_oct_db = 0, mayo_oct_cr = 0,   
				mayo_nov_inicial = 0, mayo_nov_db = 0, mayo_nov_cr = 0, mayo_dic_inicial = 0, mayo_dic_db = 0, mayo_dic_cr = 0,	mayo_cierre_inicial = 0, mayo_cierre_db = 0, mayo_cierre_cr = 0    
		WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
				( comayor.mayo_empresa = :str.empresa ) AND  
				( comayor.mayo_ann = :al_ann_actual ) ;
	case 2
		 UPDATE comayor  
		  SET mayo_feb_inicial = 0, mayo_feb_db = 0, mayo_feb_cr = 0,   
				mayo_mar_inicial = 0, mayo_mar_db = 0, mayo_mar_cr = 0, mayo_abr_inicial = 0, mayo_abr_db = 0, mayo_abr_cr = 0,   
				mayo_may_inicial = 0, mayo_may_db = 0, mayo_may_cr = 0, mayo_jun_inicial = 0, mayo_jun_db = 0, mayo_jun_cr = 0,   
				mayo_jul_inicial = 0, mayo_jul_db = 0, mayo_jul_cr = 0, mayo_ago_inicial = 0, mayo_ago_db = 0, mayo_ago_cr = 0,   
				mayo_sep_inicial = 0, mayo_sep_db = 0, mayo_sep_cr = 0, mayo_oct_inicial = 0, mayo_oct_db = 0, mayo_oct_cr = 0,   
				mayo_nov_inicial = 0, mayo_nov_db = 0, mayo_nov_cr = 0, mayo_dic_inicial = 0, mayo_dic_db = 0, mayo_dic_cr = 0, mayo_cierre_inicial = 0, mayo_cierre_db = 0, mayo_cierre_cr = 0    
		WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
				( comayor.mayo_empresa = :str.empresa ) AND  
				( comayor.mayo_ann = :al_ann_actual );
	case 3
		 UPDATE comayor  
		  SET mayo_mar_inicial = 0, mayo_mar_db = 0, mayo_mar_cr = 0, mayo_abr_inicial = 0, mayo_abr_db = 0, mayo_abr_cr = 0,   
				mayo_may_inicial = 0, mayo_may_db = 0, mayo_may_cr = 0, mayo_jun_inicial = 0, mayo_jun_db = 0, mayo_jun_cr = 0,   
				mayo_jul_inicial = 0, mayo_jul_db = 0, mayo_jul_cr = 0, mayo_ago_inicial = 0, mayo_ago_db = 0, mayo_ago_cr = 0,   
				mayo_sep_inicial = 0, mayo_sep_db = 0, mayo_sep_cr = 0, mayo_oct_inicial = 0, mayo_oct_db = 0, mayo_oct_cr = 0,   
				mayo_nov_inicial = 0, mayo_nov_db = 0, mayo_nov_cr = 0, mayo_dic_inicial = 0, mayo_dic_db = 0, mayo_dic_cr = 0, mayo_cierre_inicial = 0, mayo_cierre_db = 0, mayo_cierre_cr = 0      
		WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
				( comayor.mayo_empresa = :str.empresa ) AND  
				( comayor.mayo_ann = :al_ann_actual );
	case 4
		 UPDATE comayor  
		  SET mayo_abr_inicial = 0, mayo_abr_db = 0, mayo_abr_cr = 0,   
				mayo_may_inicial = 0, mayo_may_db = 0, mayo_may_cr = 0, mayo_jun_inicial = 0, mayo_jun_db = 0, mayo_jun_cr = 0,   
				mayo_jul_inicial = 0, mayo_jul_db = 0, mayo_jul_cr = 0, mayo_ago_inicial = 0, mayo_ago_db = 0, mayo_ago_cr = 0,   
				mayo_sep_inicial = 0, mayo_sep_db = 0, mayo_sep_cr = 0, mayo_oct_inicial = 0, mayo_oct_db = 0, mayo_oct_cr = 0,   
				mayo_nov_inicial = 0, mayo_nov_db = 0, mayo_nov_cr = 0, mayo_dic_inicial = 0, mayo_dic_db = 0, mayo_dic_cr = 0, mayo_cierre_inicial = 0, mayo_cierre_db = 0, mayo_cierre_cr = 0      
		WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
				( comayor.mayo_empresa = :str.empresa ) AND  
				( comayor.mayo_ann = :al_ann_actual );
	case 5
		 UPDATE comayor  
		  SET mayo_may_inicial = 0, mayo_may_db = 0, mayo_may_cr = 0, mayo_jun_inicial = 0, mayo_jun_db = 0, mayo_jun_cr = 0,   
				mayo_jul_inicial = 0, mayo_jul_db = 0, mayo_jul_cr = 0, mayo_ago_inicial = 0, mayo_ago_db = 0, mayo_ago_cr = 0,   
				mayo_sep_inicial = 0, mayo_sep_db = 0, mayo_sep_cr = 0, mayo_oct_inicial = 0, mayo_oct_db = 0, mayo_oct_cr = 0,   
				mayo_nov_inicial = 0, mayo_nov_db = 0, mayo_nov_cr = 0, mayo_dic_inicial = 0, mayo_dic_db = 0, mayo_dic_cr = 0, mayo_cierre_inicial = 0, mayo_cierre_db = 0, mayo_cierre_cr = 0      
		WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
				( comayor.mayo_empresa = :str.empresa ) AND  
				( comayor.mayo_ann = :al_ann_actual );
	case 6
		 UPDATE comayor  
		  SET mayo_jun_inicial = 0, mayo_jun_db = 0, mayo_jun_cr = 0,   
				mayo_jul_inicial = 0, mayo_jul_db = 0, mayo_jul_cr = 0, mayo_ago_inicial = 0, mayo_ago_db = 0, mayo_ago_cr = 0,   
				mayo_sep_inicial = 0, mayo_sep_db = 0, mayo_sep_cr = 0, mayo_oct_inicial = 0, mayo_oct_db = 0, mayo_oct_cr = 0,   
				mayo_nov_inicial = 0, mayo_nov_db = 0, mayo_nov_cr = 0, mayo_dic_inicial = 0, mayo_dic_db = 0, mayo_dic_cr = 0, mayo_cierre_inicial = 0, mayo_cierre_db = 0, mayo_cierre_cr = 0      
		WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
				( comayor.mayo_empresa = :str.empresa ) AND  
				( comayor.mayo_ann = :al_ann_actual );
	case 7
		 UPDATE comayor  
		  SET mayo_jul_inicial = 0, mayo_jul_db = 0, mayo_jul_cr = 0, mayo_ago_inicial = 0, mayo_ago_db = 0, mayo_ago_cr = 0,   
				mayo_sep_inicial = 0, mayo_sep_db = 0, mayo_sep_cr = 0, mayo_oct_inicial = 0, mayo_oct_db = 0, mayo_oct_cr = 0,   
				mayo_nov_inicial = 0, mayo_nov_db = 0, mayo_nov_cr = 0, mayo_dic_inicial = 0, mayo_dic_db = 0, mayo_dic_cr = 0, mayo_cierre_inicial = 0, mayo_cierre_db = 0, mayo_cierre_cr = 0      
		WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
				( comayor.mayo_empresa = :str.empresa ) AND  
				( comayor.mayo_ann = :al_ann_actual ) ;
	case 8
		 UPDATE comayor  
		  SET mayo_ago_inicial = 0, mayo_ago_db = 0, mayo_ago_cr = 0,   
				mayo_sep_inicial = 0, mayo_sep_db = 0, mayo_sep_cr = 0, mayo_oct_inicial = 0, mayo_oct_db = 0, mayo_oct_cr = 0,   
				mayo_nov_inicial = 0, mayo_nov_db = 0, mayo_nov_cr = 0, mayo_dic_inicial = 0, mayo_dic_db = 0, mayo_dic_cr = 0, mayo_cierre_inicial = 0, mayo_cierre_db = 0, mayo_cierre_cr = 0      
		WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
				( comayor.mayo_empresa = :str.empresa ) AND  
				( comayor.mayo_ann = :al_ann_actual ) ;
	case 9
		 UPDATE comayor  
		  SET mayo_sep_inicial = 0, mayo_sep_db = 0, mayo_sep_cr = 0, mayo_oct_inicial = 0, mayo_oct_db = 0, mayo_oct_cr = 0,   
				mayo_nov_inicial = 0, mayo_nov_db = 0, mayo_nov_cr = 0, mayo_dic_inicial = 0, mayo_dic_db = 0, mayo_dic_cr = 0, mayo_cierre_inicial = 0, mayo_cierre_db = 0, mayo_cierre_cr = 0      
		WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
				( comayor.mayo_empresa = :str.empresa ) AND  
				( comayor.mayo_ann = :al_ann_actual );
	case 10
		 UPDATE comayor  
		  SET mayo_oct_inicial = 0, mayo_oct_db = 0, mayo_oct_cr = 0,   
				mayo_nov_inicial = 0, mayo_nov_db = 0, mayo_nov_cr = 0, mayo_dic_inicial = 0, mayo_dic_db = 0, mayo_dic_cr = 0, mayo_cierre_inicial = 0, mayo_cierre_db = 0, mayo_cierre_cr = 0      
		WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
				( comayor.mayo_empresa = :str.empresa ) AND  
				( comayor.mayo_ann = :al_ann_actual );
	case 11
		 UPDATE comayor  
		  SET	mayo_nov_inicial = 0, mayo_nov_db = 0, mayo_nov_cr = 0, mayo_dic_inicial = 0, mayo_dic_db = 0, mayo_dic_cr = 0, mayo_cierre_inicial = 0, mayo_cierre_db = 0, mayo_cierre_cr = 0      
		WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
				( comayor.mayo_empresa = :str.empresa ) AND  
				( comayor.mayo_ann = :al_ann_actual ) ;
	case 12
		 UPDATE comayor  
		  SET	mayo_dic_inicial = 0, mayo_dic_db = 0, mayo_dic_cr = 0, mayo_cierre_inicial = 0, mayo_cierre_db = 0, mayo_cierre_cr = 0      
		WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
				( comayor.mayo_empresa = :str.empresa ) AND  
				( comayor.mayo_ann = :al_ann_actual ) ;
				

end choose

			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al blanquear saldos '+sqlca.sqlerrtext,1,1,'E')
				return false
			end if

		 UPDATE comayor  
		  SET mayo_ene_inicial = 0, mayo_ene_db = 0, mayo_ene_cr = 0, mayo_feb_inicial = 0, mayo_feb_db = 0, mayo_feb_cr = 0,   
				mayo_mar_inicial = 0, mayo_mar_db = 0, mayo_mar_cr = 0, mayo_abr_inicial = 0, mayo_abr_db = 0, mayo_abr_cr = 0,   
				mayo_may_inicial = 0, mayo_may_db = 0, mayo_may_cr = 0, mayo_jun_inicial = 0, mayo_jun_db = 0, mayo_jun_cr = 0,   
				mayo_jul_inicial = 0, mayo_jul_db = 0, mayo_jul_cr = 0, mayo_ago_inicial = 0, mayo_ago_db = 0, mayo_ago_cr = 0,   
				mayo_sep_inicial = 0, mayo_sep_db = 0, mayo_sep_cr = 0, mayo_oct_inicial = 0, mayo_oct_db = 0, mayo_oct_cr = 0,   
				mayo_nov_inicial = 0, mayo_nov_db = 0, mayo_nov_cr = 0, mayo_dic_inicial = 0, mayo_dic_db = 0, mayo_dic_cr = 0, mayo_cierre_inicial = 0, mayo_cierre_db = 0, mayo_cierre_cr = 0      
		WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
				( comayor.mayo_empresa = :str.empresa ) AND  
				( comayor.mayo_ann > :al_ann_actual ) ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al blanquear saldos '+sqlca.sqlerrtext,1,1,'E')
				return false
			end if		
			
return true
end function

public function boolean wf_saldos_iniciales (integer al_ann_actual, integer al_mes_actual, integer al_ann);decimal{2} ld_ene_db, ld_ene_cr, ld_ene_inicial,  ld_feb_db, ld_feb_cr, ld_feb_inicial,  ld_mar_db, ld_mar_cr, ld_mar_inicial, &
			  ld_abr_db, ld_abr_cr, ld_abr_inicial,  ld_may_db, ld_may_cr, ld_may_inicial,  ld_jun_db, ld_jun_cr, ld_jun_inicial, &
			  ld_jul_db, ld_jul_cr, ld_jul_inicial,  ld_ago_db, ld_ago_cr, ld_ago_inicial,  ld_sep_db, ld_sep_cr, ld_sep_inicial, &
			  ld_oct_db, ld_oct_cr, ld_oct_inicial,  ld_nov_db, ld_nov_cr, ld_nov_inicial,  ld_dic_db, ld_dic_cr, ld_dic_inicial, &
			  ld_saldo_anterior, ld_saldo_ene, ld_saldo_feb, ld_saldo_mar, ld_saldo_abr, ld_saldo_may, ld_saldo_jun, &
			  ld_saldo_jul, ld_saldo_ago, ld_saldo_sep, ld_saldo_oct, ld_saldo_nov, ld_saldo_dic, ld_saldo_dic_anterior, &
			  ld_saldo_cierre, ld_cierre_db, ld_cierre_cr, ld_cierre_inicial, ld_saldo_cierre_anterior
			  
integer	  li_ann, li_ann_temp
string 	  ls_cuenta, ls_cuenta_temp

str.frame.setmicrohelp('Actualizando los saldos....')

 DECLARE cur_mayor CURSOR FOR  
  SELECT comayor.mayo_cuenta, comayor.mayo_ann, comayor.mayo_ene_inicial, comayor.mayo_ene_db, comayor.mayo_ene_cr, 
  			comayor.mayo_feb_inicial, comayor.mayo_feb_db, comayor.mayo_feb_cr, comayor.mayo_mar_inicial, comayor.mayo_mar_db, comayor.mayo_mar_cr,   
         comayor.mayo_abr_inicial, comayor.mayo_abr_db, comayor.mayo_abr_cr, comayor.mayo_may_inicial, comayor.mayo_may_db, comayor.mayo_may_cr,  
         comayor.mayo_jun_inicial, comayor.mayo_jun_db, comayor.mayo_jun_cr, comayor.mayo_jul_inicial, comayor.mayo_jul_db, comayor.mayo_jul_cr,   
         comayor.mayo_ago_inicial, comayor.mayo_ago_db, comayor.mayo_ago_cr, comayor.mayo_sep_inicial, comayor.mayo_sep_db, comayor.mayo_sep_cr,   
         comayor.mayo_oct_inicial, comayor.mayo_oct_db, comayor.mayo_oct_cr, comayor.mayo_nov_inicial, comayor.mayo_nov_db, comayor.mayo_nov_cr,   
         comayor.mayo_dic_inicial, comayor.mayo_dic_db, comayor.mayo_dic_cr, comayor.mayo_cierre_inicial, comayor.mayo_cierre_db, comayor.mayo_cierre_cr    
    FROM comayor  
	WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
				( comayor.mayo_empresa = :str.empresa ) AND  
				( comayor.mayo_ann >= :al_ann_actual ) AND  
				( comayor.mayo_ann <= :al_ann )  // and mayo_cuenta like '609%'  //QUITAR
		Order by comayor.mayo_cuenta, comayor.mayo_ann;

	open cur_mayor ;
	
	fetch cur_mayor into :ls_cuenta, :li_ann, :ld_ene_inicial, :ld_ene_db, :ld_ene_cr, :ld_feb_inicial, :ld_feb_db, :ld_feb_cr, :ld_mar_inicial,  :ld_mar_db, :ld_mar_cr,  
			  :ld_abr_inicial, :ld_abr_db, :ld_abr_cr, :ld_may_inicial,  :ld_may_db, :ld_may_cr, :ld_jun_inicial,  :ld_jun_db, :ld_jun_cr,  
			  :ld_jul_inicial, :ld_jul_db, :ld_jul_cr, :ld_ago_inicial,  :ld_ago_db, :ld_ago_cr, :ld_sep_inicial,  :ld_sep_db, :ld_sep_cr,  
			  :ld_oct_inicial, :ld_oct_db, :ld_oct_cr,  :ld_nov_inicial,  :ld_nov_db, :ld_nov_cr,  :ld_dic_inicial, :ld_dic_db, :ld_dic_cr, 
  			  :ld_cierre_inicial, :ld_cierre_db, :ld_cierre_cr;
	
	ls_cuenta_temp  = ''
	
	do while sqlca.sqlcode = 0
			//Si las cuentas son diferentes
			
			//if left(ls_cuenta,3) = '200' then
//			if ls_cuenta = '40000600000000000000' then
//				ls_cuenta = ls_cuenta
//			end if
			
			if ls_cuenta_temp <> ls_cuenta then
				
				ld_saldo_ene = 0; ld_saldo_feb = 0; ld_saldo_mar = 0; ld_saldo_abr = 0; ld_saldo_may = 0; ld_saldo_jun = 0
				ld_saldo_jul = 0; ld_saldo_ago = 0; ld_saldo_sep = 0; ld_saldo_oct = 0; ld_saldo_nov = 0; ld_saldo_dic = 0; ld_saldo_dic_anterior = 0; ld_saldo_cierre = 0 			
				
				ls_cuenta_temp = ls_cuenta
				
				//busca el saldo inicial
				if al_mes_actual = 1 then
					li_ann_temp = al_ann_actual - 1
					
					if li_ann = 2012 and mid(ls_cuenta,1,1) = '4' then
						li_ann = 2012
					end if
					
					  SELECT isnull(comayor.mayo_cierre_inicial + comayor.mayo_cierre_db - comayor.mayo_cierre_cr ,0)  
						 INTO :ld_saldo_anterior  
						 FROM comayor  
						WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
								( comayor.mayo_empresa = :str.empresa ) AND  
								( comayor.mayo_cuenta = :ls_cuenta ) AND  
								( comayor.mayo_ann = :li_ann_temp )   ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al buscar saldo '+sqlca.sqlerrtext,1,1,'E')
							end if
							
							ld_saldo_feb = ld_saldo_anterior + ld_ene_db - ld_ene_cr
							ld_saldo_mar = ld_saldo_feb + ld_feb_db - ld_feb_cr							
							ld_saldo_abr = ld_saldo_mar + ld_mar_db - ld_mar_cr							
							ld_saldo_may = ld_saldo_abr + ld_abr_db - ld_abr_cr							
							ld_saldo_jun = ld_saldo_may + ld_may_db - ld_may_cr							
							ld_saldo_jul = ld_saldo_jun + ld_jun_db - ld_jun_cr							
							ld_saldo_ago = ld_saldo_jul + ld_jul_db - ld_jul_cr							
							ld_saldo_sep = ld_saldo_ago + ld_ago_db - ld_ago_cr							
							ld_saldo_oct = ld_saldo_sep + ld_sep_db - ld_sep_cr							
							ld_saldo_nov = ld_saldo_oct + ld_oct_db - ld_oct_cr							
							ld_saldo_dic = ld_saldo_nov + ld_nov_db - ld_nov_cr							
							ld_saldo_dic_anterior	 = 	ld_saldo_dic + ld_cierre_db - ld_cierre_cr	//ld_dic_db - ld_dic_cr				
							
							update comayor
							set	    comayor.mayo_ene_inicial = :ld_saldo_anterior , comayor.mayo_feb_inicial = :ld_saldo_feb, comayor.mayo_mar_inicial = :ld_saldo_mar, comayor.mayo_abr_inicial = :ld_saldo_abr, 
									comayor.mayo_may_inicial = :ld_saldo_may, comayor.mayo_jun_inicial = :ld_saldo_jun, 
									comayor.mayo_jul_inicial = :ld_saldo_jul, comayor.mayo_ago_inicial = :ld_saldo_ago, comayor.mayo_sep_inicial = :ld_saldo_sep, 
									comayor.mayo_oct_inicial = :ld_saldo_oct, comayor.mayo_nov_inicial = :ld_saldo_nov, comayor.mayo_dic_inicial = :ld_saldo_dic,
									comayor.mayo_cierre_inicial = :ld_saldo_dic
							WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
								( comayor.mayo_empresa = :str.empresa ) AND  
								( comayor.mayo_cuenta = :ls_cuenta ) AND  
								( comayor.mayo_ann = :li_ann )   ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al Actualizar saldo '+sqlca.sqlerrtext,1,1,'E')
								return false
							end if
							
							
				elseif al_mes_actual = 2 then
							ld_saldo_anterior = ld_ene_inicial + ld_ene_db - ld_ene_cr
							ld_saldo_mar = ld_saldo_anterior + ld_feb_db - ld_feb_cr							
							ld_saldo_abr = ld_saldo_mar + ld_mar_db - ld_mar_cr							
							ld_saldo_may = ld_saldo_abr + ld_abr_db - ld_abr_cr							
							ld_saldo_jun = ld_saldo_may + ld_may_db - ld_may_cr							
							ld_saldo_jul = ld_saldo_jun + ld_jun_db - ld_jun_cr							
							ld_saldo_ago = ld_saldo_jul + ld_jul_db - ld_jul_cr							
							ld_saldo_sep = ld_saldo_ago + ld_ago_db - ld_ago_cr							
							ld_saldo_oct = ld_saldo_sep + ld_sep_db - ld_sep_cr							
							ld_saldo_nov = ld_saldo_oct + ld_oct_db - ld_oct_cr							
							ld_saldo_dic = ld_saldo_nov + ld_nov_db - ld_nov_cr							
							ld_saldo_dic_anterior	 = 	ld_saldo_dic + ld_cierre_db - ld_cierre_cr //+ 	ld_dic_db - ld_dic_cr		
							
							update comayor
							set	comayor.mayo_feb_inicial = :ld_saldo_anterior, comayor.mayo_mar_inicial = :ld_saldo_mar, comayor.mayo_abr_inicial = :ld_saldo_abr, 
									comayor.mayo_may_inicial = :ld_saldo_may, comayor.mayo_jun_inicial = :ld_saldo_jun, 
									comayor.mayo_jul_inicial = :ld_saldo_jul, comayor.mayo_ago_inicial = :ld_saldo_ago, comayor.mayo_sep_inicial = :ld_saldo_sep, 
									comayor.mayo_oct_inicial = :ld_saldo_oct, comayor.mayo_nov_inicial = :ld_saldo_nov, comayor.mayo_dic_inicial = :ld_saldo_dic,
									comayor.mayo_cierre_inicial = :ld_saldo_dic
							WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
								( comayor.mayo_empresa = :str.empresa ) AND  
								( comayor.mayo_cuenta = :ls_cuenta ) AND  
								( comayor.mayo_ann = :li_ann )   ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al Actualizar saldo '+sqlca.sqlerrtext,1,1,'E')
								return false
							end if

				elseif al_mes_actual = 3 then
							ld_saldo_anterior = ld_feb_inicial + ld_feb_db - ld_feb_cr
							ld_saldo_abr = ld_saldo_anterior + ld_mar_db - ld_mar_cr							
							ld_saldo_may = ld_saldo_abr + ld_abr_db - ld_abr_cr							
							ld_saldo_jun = ld_saldo_may + ld_may_db - ld_may_cr							
							ld_saldo_jul = ld_saldo_jun + ld_jun_db - ld_jun_cr							
							ld_saldo_ago = ld_saldo_jul + ld_jul_db - ld_jul_cr							
							ld_saldo_sep = ld_saldo_ago + ld_ago_db - ld_ago_cr							
							ld_saldo_oct = ld_saldo_sep + ld_sep_db - ld_sep_cr							
							ld_saldo_nov = ld_saldo_oct + ld_oct_db - ld_oct_cr							
							ld_saldo_dic = ld_saldo_nov + ld_nov_db - ld_nov_cr							
							ld_saldo_dic_anterior	 = 	ld_saldo_dic + ld_cierre_db - ld_cierre_cr //+ 	ld_dic_db - ld_dic_cr			
							
							update comayor
							set	comayor.mayo_mar_inicial = :ld_saldo_anterior, comayor.mayo_abr_inicial = :ld_saldo_abr, 
									comayor.mayo_may_inicial = :ld_saldo_may, comayor.mayo_jun_inicial = :ld_saldo_jun, 
									comayor.mayo_jul_inicial = :ld_saldo_jul, comayor.mayo_ago_inicial = :ld_saldo_ago, comayor.mayo_sep_inicial = :ld_saldo_sep, 
									comayor.mayo_oct_inicial = :ld_saldo_oct, comayor.mayo_nov_inicial = :ld_saldo_nov, comayor.mayo_dic_inicial = :ld_saldo_dic,
									comayor.mayo_cierre_inicial = :ld_saldo_dic
							WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
								( comayor.mayo_empresa = :str.empresa ) AND  
								( comayor.mayo_cuenta = :ls_cuenta ) AND  
								( comayor.mayo_ann = :li_ann )   ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al Actualizar saldo '+sqlca.sqlerrtext,1,1,'E')
								return false
							end if
					
				elseif al_mes_actual = 4 then
							ld_saldo_anterior = ld_mar_inicial + ld_mar_db - ld_mar_cr
							ld_saldo_may = ld_saldo_anterior + ld_abr_db - ld_abr_cr							
							ld_saldo_jun = ld_saldo_may + ld_may_db - ld_may_cr							
							ld_saldo_jul = ld_saldo_jun + ld_jun_db - ld_jun_cr							
							ld_saldo_ago = ld_saldo_jul + ld_jul_db - ld_jul_cr							
							ld_saldo_sep = ld_saldo_ago + ld_ago_db - ld_ago_cr							
							ld_saldo_oct = ld_saldo_sep + ld_sep_db - ld_sep_cr							
							ld_saldo_nov = ld_saldo_oct + ld_oct_db - ld_oct_cr							
							ld_saldo_dic = ld_saldo_nov + ld_nov_db - ld_nov_cr							
							ld_saldo_dic_anterior	 = 	ld_saldo_dic + ld_cierre_db - ld_cierre_cr //+ 	ld_dic_db - ld_dic_cr			
							
							update comayor
							set	comayor.mayo_abr_inicial = :ld_saldo_anterior, 
									comayor.mayo_may_inicial = :ld_saldo_may, comayor.mayo_jun_inicial = :ld_saldo_jun, 
									comayor.mayo_jul_inicial = :ld_saldo_jul, comayor.mayo_ago_inicial = :ld_saldo_ago, comayor.mayo_sep_inicial = :ld_saldo_sep, 
									comayor.mayo_oct_inicial = :ld_saldo_oct, comayor.mayo_nov_inicial = :ld_saldo_nov, comayor.mayo_dic_inicial = :ld_saldo_dic,
									comayor.mayo_cierre_inicial = :ld_saldo_dic									
							WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
								( comayor.mayo_empresa = :str.empresa ) AND  
								( comayor.mayo_cuenta = :ls_cuenta ) AND  
								( comayor.mayo_ann = :li_ann )   ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al Actualizar saldo '+sqlca.sqlerrtext,1,1,'E')
								return false
							end if
					
				elseif al_mes_actual = 5 then
							ld_saldo_anterior = ld_abr_inicial + ld_abr_db - ld_abr_cr					
							ld_saldo_jun = ld_saldo_anterior + ld_may_db - ld_may_cr							
							ld_saldo_jul = ld_saldo_jun + ld_jun_db - ld_jun_cr							
							ld_saldo_ago = ld_saldo_jul + ld_jul_db - ld_jul_cr							
							ld_saldo_sep = ld_saldo_ago + ld_ago_db - ld_ago_cr							
							ld_saldo_oct = ld_saldo_sep + ld_sep_db - ld_sep_cr							
							ld_saldo_nov = ld_saldo_oct + ld_oct_db - ld_oct_cr							
							ld_saldo_dic = ld_saldo_nov + ld_nov_db - ld_nov_cr							
							ld_saldo_dic_anterior	 = 	ld_saldo_dic + ld_cierre_db - ld_cierre_cr //+ 	ld_dic_db - ld_dic_cr			
							
							update comayor
							set	comayor.mayo_may_inicial = :ld_saldo_anterior, comayor.mayo_jun_inicial = :ld_saldo_jun, 
									comayor.mayo_jul_inicial = :ld_saldo_jul, comayor.mayo_ago_inicial = :ld_saldo_ago, comayor.mayo_sep_inicial = :ld_saldo_sep, 
									comayor.mayo_oct_inicial = :ld_saldo_oct, comayor.mayo_nov_inicial = :ld_saldo_nov, comayor.mayo_dic_inicial = :ld_saldo_dic,
									comayor.mayo_cierre_inicial = :ld_saldo_dic									
							WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
								( comayor.mayo_empresa = :str.empresa ) AND  
								( comayor.mayo_cuenta = :ls_cuenta ) AND  
								( comayor.mayo_ann = :li_ann )   ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al Actualizar saldo '+sqlca.sqlerrtext,1,1,'E')
								return false
							end if
					
				elseif al_mes_actual = 6 then
							ld_saldo_anterior = ld_may_inicial + ld_may_db - ld_may_cr
							ld_saldo_jul = ld_saldo_anterior + ld_jun_db - ld_jun_cr							
							ld_saldo_ago = ld_saldo_jul + ld_jul_db - ld_jul_cr							
							ld_saldo_sep = ld_saldo_ago + ld_ago_db - ld_ago_cr							
							ld_saldo_oct = ld_saldo_sep + ld_sep_db - ld_sep_cr							
							ld_saldo_nov = ld_saldo_oct + ld_oct_db - ld_oct_cr							
							ld_saldo_dic = ld_saldo_nov + ld_nov_db - ld_nov_cr							
							ld_saldo_dic_anterior	 = 	ld_saldo_dic + ld_cierre_db - ld_cierre_cr //+ 	ld_dic_db - ld_dic_cr			
							
							update comayor
							set	comayor.mayo_jun_inicial = :ld_saldo_anterior, 
									comayor.mayo_jul_inicial = :ld_saldo_jul, comayor.mayo_ago_inicial = :ld_saldo_ago, comayor.mayo_sep_inicial = :ld_saldo_sep, 
									comayor.mayo_oct_inicial = :ld_saldo_oct, comayor.mayo_nov_inicial = :ld_saldo_nov, comayor.mayo_dic_inicial = :ld_saldo_dic,
									comayor.mayo_cierre_inicial = :ld_saldo_dic
							WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
								( comayor.mayo_empresa = :str.empresa ) AND  
								( comayor.mayo_cuenta = :ls_cuenta ) AND  
								( comayor.mayo_ann = :li_ann )   ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al Actualizar saldo '+sqlca.sqlerrtext,1,1,'E')
								return false
							end if
					
				elseif al_mes_actual = 7 then
							ld_saldo_anterior = ld_jun_inicial + ld_jun_db - ld_jun_cr
							ld_saldo_ago = ld_saldo_anterior + ld_jul_db - ld_jul_cr							
							ld_saldo_sep = ld_saldo_ago + ld_ago_db - ld_ago_cr							
							ld_saldo_oct = ld_saldo_sep + ld_sep_db - ld_sep_cr							
							ld_saldo_nov = ld_saldo_oct + ld_oct_db - ld_oct_cr							
							ld_saldo_dic = ld_saldo_nov + ld_nov_db - ld_nov_cr							
							ld_saldo_dic_anterior	 = 	ld_saldo_dic + ld_cierre_db - ld_cierre_cr //+ 	ld_dic_db - ld_dic_cr			
							
							update comayor
							set	comayor.mayo_jul_inicial = :ld_saldo_anterior, comayor.mayo_ago_inicial = :ld_saldo_ago, comayor.mayo_sep_inicial = :ld_saldo_sep, 
									comayor.mayo_oct_inicial = :ld_saldo_oct, comayor.mayo_nov_inicial = :ld_saldo_nov, comayor.mayo_dic_inicial = :ld_saldo_dic,
									comayor.mayo_cierre_inicial = :ld_saldo_dic
							WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
								( comayor.mayo_empresa = :str.empresa ) AND  
								( comayor.mayo_cuenta = :ls_cuenta ) AND  
								( comayor.mayo_ann = :li_ann )   ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al Actualizar saldo '+sqlca.sqlerrtext,1,1,'E')
								return false
							end if
					
				elseif al_mes_actual = 8 then
							ld_saldo_anterior = ld_jul_inicial + ld_jul_db - ld_jul_cr
							ld_saldo_sep = ld_saldo_anterior + ld_ago_db - ld_ago_cr							
							ld_saldo_oct = ld_saldo_sep + ld_sep_db - ld_sep_cr							
							ld_saldo_nov = ld_saldo_oct + ld_oct_db - ld_oct_cr							
							ld_saldo_dic = ld_saldo_nov + ld_nov_db - ld_nov_cr							
							ld_saldo_dic_anterior	 = 	ld_saldo_dic + ld_cierre_db - ld_cierre_cr //+ 	ld_dic_db - ld_dic_cr			
							
							update comayor
							set	comayor.mayo_ago_inicial = :ld_saldo_anterior, comayor.mayo_sep_inicial = :ld_saldo_sep, 
									comayor.mayo_oct_inicial = :ld_saldo_oct, comayor.mayo_nov_inicial = :ld_saldo_nov, comayor.mayo_dic_inicial = :ld_saldo_dic,
									comayor.mayo_cierre_inicial = :ld_saldo_dic
							WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
								( comayor.mayo_empresa = :str.empresa ) AND  
								( comayor.mayo_cuenta = :ls_cuenta ) AND  
								( comayor.mayo_ann = :li_ann )   ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al Actualizar saldo '+sqlca.sqlerrtext,1,1,'E')
								return false
							end if
					
				elseif al_mes_actual = 9 then
							ld_saldo_anterior = ld_ago_inicial + ld_ago_db - ld_ago_cr					
							ld_saldo_oct = ld_saldo_anterior + ld_sep_db - ld_sep_cr							
							ld_saldo_nov = ld_saldo_oct + ld_oct_db - ld_oct_cr							
							ld_saldo_dic = ld_saldo_nov + ld_nov_db - ld_nov_cr							
							ld_saldo_dic_anterior	 = 	ld_saldo_dic + ld_cierre_db - ld_cierre_cr //+ 	ld_dic_db - ld_dic_cr			
							
							update comayor
							set	comayor.mayo_sep_inicial = :ld_saldo_anterior, 
									comayor.mayo_oct_inicial = :ld_saldo_oct, comayor.mayo_nov_inicial = :ld_saldo_nov, comayor.mayo_dic_inicial = :ld_saldo_dic,
									comayor.mayo_cierre_inicial = :ld_saldo_dic									
							WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
								( comayor.mayo_empresa = :str.empresa ) AND  
								( comayor.mayo_cuenta = :ls_cuenta ) AND  
								( comayor.mayo_ann = :li_ann )   ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al Actualizar saldo '+sqlca.sqlerrtext,1,1,'E')
								return false
							end if
						
				elseif al_mes_actual = 10 then
							ld_saldo_anterior = ld_sep_inicial + ld_sep_db - ld_sep_cr
							ld_saldo_nov = ld_saldo_anterior + ld_oct_db - ld_oct_cr							
							ld_saldo_dic = ld_saldo_nov + ld_nov_db - ld_nov_cr							
							ld_saldo_dic_anterior	 = 	ld_saldo_dic + ld_cierre_db - ld_cierre_cr //+ 	ld_dic_db - ld_dic_cr			
							
							update comayor
							set	comayor.mayo_oct_inicial = :ld_saldo_anterior, comayor.mayo_nov_inicial = :ld_saldo_nov, comayor.mayo_dic_inicial = :ld_saldo_dic,
								comayor.mayo_cierre_inicial = :ld_saldo_dic
							WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
								( comayor.mayo_empresa = :str.empresa ) AND  
								( comayor.mayo_cuenta = :ls_cuenta ) AND  
								( comayor.mayo_ann = :li_ann )   ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al Actualizar saldo '+sqlca.sqlerrtext,1,1,'E')
								return false
							end if
					
				elseif al_mes_actual = 11 then
							ld_saldo_anterior = ld_oct_inicial + ld_oct_db - ld_oct_cr
							ld_saldo_dic = ld_saldo_anterior + ld_nov_db - ld_nov_cr							
							ld_saldo_dic_anterior	 = 	ld_saldo_dic + ld_cierre_db - ld_cierre_cr //+ 	ld_dic_db - ld_dic_cr			
							
							update comayor
							set	comayor.mayo_nov_inicial = :ld_saldo_anterior, comayor.mayo_dic_inicial = :ld_saldo_dic, comayor.mayo_cierre_inicial = :ld_saldo_dic
							WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
								( comayor.mayo_empresa = :str.empresa ) AND  
								( comayor.mayo_cuenta = :ls_cuenta ) AND  
								( comayor.mayo_ann = :li_ann )   ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al Actualizar saldo '+sqlca.sqlerrtext,1,1,'E')
								return false
							end if
							
				elseif al_mes_actual = 12 then
						ld_saldo_anterior = ld_nov_inicial + ld_nov_db - ld_nov_cr			
						ld_saldo_dic_anterior	 = 	ld_saldo_anterior + ld_cierre_db - ld_cierre_cr //+ ld_dic_db - ld_dic_cr			
						
							update comayor
							set	comayor.mayo_dic_inicial = :ld_saldo_anterior, comayor.mayo_cierre_inicial = :ld_saldo_anterior
							WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
								( comayor.mayo_empresa = :str.empresa ) AND  
								( comayor.mayo_cuenta = :ls_cuenta ) AND  
								( comayor.mayo_ann = :li_ann )   ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al Actualizar saldo '+sqlca.sqlerrtext,1,1,'E')
								return false
							end if
							
							ld_saldo_dic = ld_saldo_anterior + ld_dic_db - ld_dic_cr
				end if				
				
			else// SI LA CUENTA ES IGUAL del ls_cuenta <> ls_cuenta_temp
			
					if li_ann = 2012 and mid(ls_cuenta,1,1) = '4' then
						li_ann = 2012
					end if
							ld_saldo_ene = ld_saldo_dic_anterior
							ld_saldo_feb = ld_saldo_ene + ld_ene_db - ld_ene_cr
							ld_saldo_mar = ld_saldo_feb + ld_feb_db - ld_feb_cr							
							ld_saldo_abr = ld_saldo_mar + ld_mar_db - ld_mar_cr							
							ld_saldo_may = ld_saldo_abr + ld_abr_db - ld_abr_cr							
							ld_saldo_jun = ld_saldo_may + ld_may_db - ld_may_cr							
							ld_saldo_jul = ld_saldo_jun + ld_jun_db - ld_jun_cr							
							ld_saldo_ago = ld_saldo_jul + ld_jul_db - ld_jul_cr							
							ld_saldo_sep = ld_saldo_ago + ld_ago_db - ld_ago_cr							
							ld_saldo_oct = ld_saldo_sep + ld_sep_db - ld_sep_cr							
							ld_saldo_nov = ld_saldo_oct + ld_oct_db - ld_oct_cr							
							ld_saldo_dic = ld_saldo_nov + ld_nov_db - ld_nov_cr							
							ld_saldo_dic_anterior	 = 	ld_saldo_dic + ld_cierre_db - ld_cierre_cr //+ 	ld_dic_db - ld_dic_cr			
							
							update comayor
							set	comayor.mayo_ene_inicial = :ld_saldo_ene , comayor.mayo_feb_inicial = :ld_saldo_feb, comayor.mayo_mar_inicial = :ld_saldo_mar, comayor.mayo_abr_inicial = :ld_saldo_abr, 
									comayor.mayo_may_inicial = :ld_saldo_may, comayor.mayo_jun_inicial = :ld_saldo_jun, 
									comayor.mayo_jul_inicial = :ld_saldo_jul, comayor.mayo_ago_inicial = :ld_saldo_ago, comayor.mayo_sep_inicial = :ld_saldo_sep, 
									comayor.mayo_oct_inicial = :ld_saldo_oct, comayor.mayo_nov_inicial = :ld_saldo_nov, comayor.mayo_dic_inicial = :ld_saldo_dic,
									comayor.mayo_cierre_inicial = :ld_saldo_dic
							WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
								( comayor.mayo_empresa = :str.empresa ) AND  
								( comayor.mayo_cuenta = :ls_cuenta ) AND  
								( comayor.mayo_ann = :li_ann )   ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al Actualizar saldo '+sqlca.sqlerrtext,1,1,'E')
								return false
							end if
												
				
			end if // del ls_cuenta <> ls_cuenta_temp
		
		
			fetch cur_mayor into :ls_cuenta, :li_ann, :ld_ene_inicial, :ld_ene_db, :ld_ene_cr, :ld_feb_inicial, :ld_feb_db, :ld_feb_cr, :ld_mar_inicial,  :ld_mar_db, :ld_mar_cr,  
			  :ld_abr_inicial, :ld_abr_db, :ld_abr_cr, :ld_may_inicial,  :ld_may_db, :ld_may_cr, :ld_jun_inicial,  :ld_jun_db, :ld_jun_cr,  
			  :ld_jul_inicial, :ld_jul_db, :ld_jul_cr, :ld_ago_inicial,  :ld_ago_db, :ld_ago_cr, :ld_sep_inicial,  :ld_sep_db, :ld_sep_cr,  
			  :ld_oct_inicial, :ld_oct_db, :ld_oct_cr,  :ld_nov_inicial,  :ld_nov_db, :ld_nov_cr,  :ld_dic_inicial, :ld_dic_db, :ld_dic_cr,
  			  :ld_cierre_inicial, :ld_cierre_db, :ld_cierre_cr;
				 
	loop

	close cur_mayor;		

return true
end function

public function boolean wf_acumula_en_niveles_anteriores (string ls_cuenta, decimal ld_monto, string ls_naturaleza, integer li_ann, integer li_mes, string ls_transaccion);integer li_num_nivel, li_contador, li_acum, li_acum2, li_ncaracter, li_pos, li_nivel, li_s, li_nivel_anterior, li_found, li_found2
string ls_cadena, ls_cuenta_anterior
		
		li_num_nivel = lds_nivel.rowcount()

		for li_contador = li_num_nivel to 1 step -1
	
			li_acum = lds_nivel.GetItemNumber(li_contador,"nive_todos_nivel")
			li_ncaracter = lds_nivel.GetItemNumber(li_contador,"nive_cada_nivel")
			li_pos = (li_acum + 1) - li_ncaracter
			
			//Extraemos la cadena//
			ls_cadena = mid(ls_cuenta, li_pos, li_ncaracter)
		
			If fill('0',li_ncaracter) <> ls_cadena And li_nivel = 0 Then	li_nivel=li_contador
		   
		   If fill('0',li_ncaracter) = ls_cadena And li_nivel <> 0 Then
				Mensaje("","Número de Cuenta Errado, Por Favor Corrija su Error", "")
				li_s=1
				Exit
			End If
		Next
		
		li_nivel_anterior=li_nivel - 1
		
		If li_nivel_anterior > 0 Then
			li_acum2 = lds_nivel.GetItemNumber(li_nivel_anterior,"nive_todos_nivel")
//			il_acuev = li_acum2
			ls_cuenta_anterior= left(ls_cuenta, li_acum2)
			ls_cuenta_anterior= left(ls_cuenta_anterior + fill('0',20),20)

			SELECT count(*)
			 INTO :li_found
			 FROM dgmplanc  
			WHERE ( dgmplanc.mg_g_financiero = :str.g_financiero ) AND  
					( dgmplanc.mg_empresa = :str.empresa ) AND  
					( dgmplanc.mg_cuenta  = :ls_cuenta_anterior )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al validar cuenta '+sqlca.sqlerrtext,1,1,'E')
			end if
			
			li_found2 = li_found	
		
			If li_found = 0 Or isnull(li_found) Then
				//Mensaje("Atención Sr. Usuario","La Cuenta Que Esta Creando No Tiene Nivel Anterior, Verifique !!!", "")
			end if
			
			if li_found > 0 then
				
				ls_cuenta = ls_cuenta_anterior
				
				choose case ls_naturaleza
					
				case 'D'			
						choose case li_mes
							case 1
								  UPDATE comayor  
									  SET mayo_ene_db = mayo_ene_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;
							case 2
								  UPDATE comayor  
									  SET mayo_feb_db = mayo_feb_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;
							case 3
								  UPDATE comayor  
									  SET mayo_mar_db = mayo_mar_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;
							case 4
								  UPDATE comayor  
									  SET mayo_abr_db = mayo_abr_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;
							case 5
								  UPDATE comayor  
									  SET mayo_may_db = mayo_may_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 6
								  UPDATE comayor  
									  SET mayo_jun_db = mayo_jun_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 7
								  UPDATE comayor  
									  SET mayo_jul_db = mayo_jul_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 8
								  UPDATE comayor  
									  SET mayo_ago_db = mayo_ago_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 9
								  UPDATE comayor  
									  SET mayo_sep_db = mayo_sep_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 10
								  UPDATE comayor  
									  SET mayo_oct_db = mayo_oct_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 11
								  UPDATE comayor  
									  SET mayo_nov_db = mayo_nov_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 12		
								if ls_transaccion <> 'RA' then
								  UPDATE comayor  
									  SET mayo_dic_db = mayo_dic_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;
											
										if sqlca.sqlcode = -1 then
											gf_mensaje('','Error al Actualizar Mayor '+sqlca.sqlerrtext,1,1,'E')
											return false
										end if						
								end if															
									 UPDATE comayor  
									  SET mayo_cierre_db = mayo_cierre_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;			
											
						end choose
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al Actualizar Mayor '+sqlca.sqlerrtext,1,1,'E')
							return false
						end if						
					case 'C'
						choose case li_mes
							case 1
								  UPDATE comayor  
									  SET mayo_ene_cr = mayo_ene_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;
							case 2
								  UPDATE comayor  
									  SET mayo_feb_cr = mayo_feb_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;
							case 3
								  UPDATE comayor  
									  SET mayo_mar_cr = mayo_mar_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;
							case 4
								  UPDATE comayor  
									  SET mayo_abr_cr = mayo_abr_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;
							case 5
								  UPDATE comayor  
									  SET mayo_may_cr = mayo_may_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 6
								  UPDATE comayor  
									  SET mayo_jun_cr = mayo_jun_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 7
								  UPDATE comayor  
									  SET mayo_jul_cr = mayo_jul_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 8
								  UPDATE comayor  
									  SET mayo_ago_cr = mayo_ago_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 9
								  UPDATE comayor  
									  SET mayo_sep_cr = mayo_sep_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 10
								  UPDATE comayor  
									  SET mayo_oct_cr = mayo_oct_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 11
								  UPDATE comayor  
									  SET mayo_nov_cr = mayo_nov_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 12		
								if ls_transaccion <> 'RA' then						
								  UPDATE comayor  
									  SET mayo_dic_cr = mayo_dic_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;
												if sqlca.sqlcode = -1 then
													gf_mensaje('','Error al Actualizar Mayor '+sqlca.sqlerrtext,1,1,'E')
													return false
												end if						
								end if												
								  UPDATE comayor  
									  SET mayo_cierre_cr = mayo_cierre_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;
						end choose
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al Actualizar Mayor Credito '+sqlca.sqlerrtext,1,1,'E')
							return false
						end if												
				end choose
				
			end if //del cuenta anterior existe
			
			
		end if
			


return true

end function

on w_recalcula_mayor_general.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_recalcula_mayor_general.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
end on

event ue_post_open;// Override
str_secuencia_doc lstr_sec
string ls_vienede, ls_where, ls_pedido, ls_dw, ls_masca
integer li_ann
long	 ll_recup

dw = dw_1 
dw.settransobject(sqlca)
//dw.object.datawindow.readonly = 'yes'
lds_nivel = Create ds_dg_import_file
lds_nivel.dataobject = "dw_ma_co_niveles"
lds_nivel.settransobject(sqlca)
lds_nivel.retrieve(str.g_financiero,str.empresa)

ls_masca = gf_mascara()
dw.MODIFY("mg_cuenta.editmask.mask='"+ls_masca+"'")

dw.retrieve(str.g_financiero, str.empresa)
//dw.Object.datawindow.print.preview = true



end event

event resize;//Override No borrar no tocar
dw_1.Width  = newwidth - 85
dw_1.Height = newheight - 145


end event

event key;call super::key;//Override

end event

event open;call super::open;
this.y = 0
this.x = 805

end event

event ue_imprimir;//override
dw = dw_1
OpenWithParm(w_dw_print_options, dw)
If Message.DoubleParm = -1 Then Return
dw.Print(True)

end event

event ue_print;//override
dw = dw_1
OpenWithParm(w_dw_print_options, dw)
If Message.DoubleParm = -1 Then Return
dw.Print(True)

end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_recalcula_mayor_general
integer x = 1879
integer y = 1492
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_recalcula_mayor_general
boolean visible = false
integer x = 41
integer y = 1752
integer width = 101
integer height = 64
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_recalcula_mayor_general
event ue_down pbm_dwnkey
event ue_entercol ( )
boolean visible = false
integer x = 46
integer y = 68
integer width = 1193
integer height = 356
integer taborder = 130
string dataobject = "dw_calcula_saldos_plan_cuentas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = false
end type

event dw_1::ue_down;// Si el Usuario Dio Enter

if key = Keyenter! Then
	This.Postevent("ue_entercol")
	return(2)
End If

end event

event dw_1::doubleclicked;call super::doubleclicked;//this.triggerevent("ue_entercol")

end event

event dw_1::ue_microayuda;////OVERRIDE
//// Evento que muestra una pequeña Ayuda dependiendo en que columna se encuentre el mouse
//
//Integer li_pos, li_x, li_y
//String ls_objeto, ls_col
//
//ls_objeto = This.GetObjectAtPointer()
//li_pos = pos  (ls_objeto,"~t")
//ls_col = left (ls_objeto, li_pos - 1)
//
//
//li_x	 = str.frame.GetActiveSheet ().PointerX () //- 900
//li_y	 = str.frame.GetActiveSheet ().PointerY () //- 200
//
//// Dependiendo de la Columna el Mensaje de Ayuda varía
//CHOOSE CASE right(ls_col,2)
//	CASE '_t'
////		messagebox("!","Invisible")
//		If st_ayuda.Visible Then Return
//		st_ayuda.Move (li_x, li_y)
//		st_ayuda.Text 	= "Haga click para ordenar por la Columna de " + this.describe(ls_col+".text")
//		st_ayuda.Width 	= Len (st_ayuda.Text) * 28
//		st_ayuda.Visible = TRUE	
//	CASE ELSE
//	st_ayuda.Visible = FALSE
//END CHOOSE
//
end event

event dw_1::clicked;//// Script que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//// en la misma columna.
//
//string	ls_objeto
//integer	li_pos
//
//
//ls_objeto = This.GetObjectAtPointer()
//
//li_pos = Pos(ls_objeto, "~t")
//ls_objeto = Left(ls_objeto, li_pos - 1)
//
//if right(ls_objeto,2)='_t' then
//
//	ls_objeto = left(ls_objeto,len(ls_objeto)-2)
//	
//	if ls_objeto = is_ultima_ or is_ultima_ = "" then	//Si es la misma columna 
//																	// o si es la primera vez
//		if is_orden_  = "" or is_orden_ = "D" then
//			is_orden_ = 'A'		
//			this.SetSort(ls_objeto+" A")	//Ordena Ascendente
//			this.sort()		
//		else
//			is_orden_ = 'D'					
//			this.SetSort(ls_objeto+" D")	//Ordena Descendente
//			this.sort()				
//		end if	
//		is_ultima_ = ls_objeto		
//	else				
//			is_orden_ = 'A'
//			this.SetSort(ls_objeto+" A")
//			this.sort()
//			is_ultima_ = ls_objeto
//	end if
//
//end if
//
end event

event dw_1::retrieveend;call super::retrieveend;integer li_existe, li_ann, li_ann_actual, li_mes_actual, li_mes, li_ann_temp
long ll_total, i, j
string  ls_cuenta, ls_naturaleza, ls_transaccion
datetime ldt_fecha1, ldt_fecha2, ldt_fecha_tran
decimal{2} ld_monto
time lt_time

lt_time = time('00:00:00')

ldt_fecha2 = datetime(relativedate(date(gf_fecha_serv()), 60), lt_time)
//datetime( date('12/31/2011') ,lt_time)

  SELECT isnull(comparam.para_ann_actual,0),   
         isnull(comparam.para_mes_actual,0)  
    INTO :li_ann_actual,   
         :li_mes_actual  
    FROM comparam  
   WHERE ( comparam.para_g_financiero = :str.g_financiero ) AND  
         ( comparam.para_empresa = :str.empresa )  ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Buscar Periodo Actual '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
		
		if li_ann_actual = 0 or li_mes_actual = 0 then
			gf_mensaje('','Debe Configurar el Periodo Contable en Parametros Generales, Verifique !!!',1,1,'E')
			return
		end if

ldt_fecha1 = datetime( date('01/'+string(li_mes_actual)+'/'+string(li_ann_actual)) , lt_time)

//li_ann = 2011 //year(date(gf_fecha_serv()))
li_ann = li_ann_actual
li_ann --

//Se crean las cuentas en el mayor, si no existen, para el anio actual y el anio anterior
for j = 1 to 4
	yield()
	for i = 1 to rowcount
		ls_cuenta = dw_1.getitemstring(i,'mg_cuenta')

		str.frame.setmicrohelp('Procesando el registro ( '+string(j)+') '+string(i)+ ' de '+string(rowcount))
		yield()
		
		select count(*) into :li_existe from comayor
		where mayo_g_financiero = :str.g_financiero and
				mayo_empresa		= :str.empresa and
				mayo_cuenta			= :ls_cuenta and
				mayo_ann				= :li_ann;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Validar cuentas '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
		
		if li_existe = 0 then
			  INSERT INTO comayor  
						( mayo_g_financiero,   
						  mayo_empresa,   
						  mayo_cuenta,   
						  mayo_ann )  
			  VALUES ( :str.g_financiero,   
						  :str.empresa,   
						  :ls_cuenta,   
						  :li_ann)  ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Validar cuentas '+sqlca.sqlerrtext,1,1,'E')
						return
					end if
		end if
		
	next
	
	li_ann ++
next

li_ann_temp = li_ann

//Limpia el mayor para volver a asignar las transacciones
wf_blanquear_mayor(li_ann_actual, li_mes_actual, li_ann)

//busca el total de transaciones
    SELECT count(*)
	 into	:ll_total
    FROM coddiari,   
         cotdiari,   
         dgmplanc  
   WHERE ( cotdiari.diar_g_financiero = coddiari.ddia_g_financiero ) and  
         ( cotdiari.diar_empresa = coddiari.ddia_empresa ) and  
         ( cotdiari.diar_aplicacion_mg = coddiari.ddia_aplicacion_mg ) and  
         ( cotdiari.diar_tipo_transaccion = coddiari.ddia_tipo_transaccion ) and  
         ( cotdiari.diar_sub_trans = coddiari.ddia_sub_trans ) and  
         ( cotdiari.diar_no_documento = coddiari.ddia_no_documento ) and  
         ( cotdiari.diar_no_referencia = coddiari.ddia_no_referencia ) and  
         ( cotdiari.diar_banco_cuenta = coddiari.ddia_banco_cuenta ) and  
         ( cotdiari.diar_ann = coddiari.ddia_ann ) and  
         ( dgmplanc.mg_g_financiero = coddiari.ddia_g_financiero ) and  
         ( dgmplanc.mg_empresa = coddiari.ddia_empresa ) and  
         ( dgmplanc.mg_cuenta = coddiari.ddia_mg_cuenta ) and  
//         ( coddiari.ddia_mg_cuenta like '609%' ) and  			//QUITAR			
         ( ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
         ( cotdiari.diar_empresa = :str.empresa ) AND  
		( cotdiari.diar_fecha_transaccion >= :ldt_fecha1 ) AND  
         ( cotdiari.diar_fecha_transaccion <= :ldt_fecha2 ) )    ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Contar '+sqlca.sqlerrtext,1,1,'E')
						return
					end if

//Recorre las transacciones y asigna los valores al mayor
 DECLARE cur_transacciones CURSOR FOR  
    SELECT isnull(coddiari.ddia_mg_cuenta,''),   
         isnull(coddiari.ddia_monto,0),   
         isnull(coddiari.ddia_naturaleza,''),   
         cotdiari.diar_fecha_transaccion,
		isnull(coddiari.ddia_tipo_transaccion,'')		
    FROM coddiari,   
         cotdiari,   
         dgmplanc  
   WHERE ( cotdiari.diar_g_financiero = coddiari.ddia_g_financiero ) and  
         ( cotdiari.diar_empresa = coddiari.ddia_empresa ) and  
         ( cotdiari.diar_aplicacion_mg = coddiari.ddia_aplicacion_mg ) and  
         ( cotdiari.diar_tipo_transaccion = coddiari.ddia_tipo_transaccion ) and  
         ( cotdiari.diar_sub_trans = coddiari.ddia_sub_trans ) and  
         ( cotdiari.diar_no_documento = coddiari.ddia_no_documento ) and  
         ( cotdiari.diar_no_referencia = coddiari.ddia_no_referencia ) and  
         ( cotdiari.diar_banco_cuenta = coddiari.ddia_banco_cuenta ) and  
         ( cotdiari.diar_ann = coddiari.ddia_ann ) and  
         ( dgmplanc.mg_g_financiero = coddiari.ddia_g_financiero ) and  
         ( dgmplanc.mg_empresa = coddiari.ddia_empresa ) and  
         ( dgmplanc.mg_cuenta = coddiari.ddia_mg_cuenta ) and  
//         ( coddiari.ddia_mg_cuenta like '609%' ) and  			//QUITAR
         ( ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
         ( cotdiari.diar_empresa = :str.empresa ) AND  
         ( cotdiari.diar_fecha_transaccion >= :ldt_fecha1 ) AND  
         ( cotdiari.diar_fecha_transaccion <= :ldt_fecha2 ) )  order by diar_fecha_transaccion  ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Declarar Cursor '+sqlca.sqlerrtext,1,1,'E')
						return
					end if
			
			open cur_transacciones;
			
			fetch cur_transacciones into :ls_cuenta, :ld_monto, :ls_naturaleza, :ldt_fecha_tran, :ls_transaccion ;
			
			i = 1
			
			do while sqlca.sqlcode = 0
				
				if isnull(ld_monto) then ld_monto = 0
				
				str.frame.setmicrohelp('Procesando Transacciones....Por favor Espere '+ string(i)+ ' de '+string(ll_total))
			
				yield()
		
				li_ann = year(date(ldt_fecha_tran))
				li_mes = month(date(ldt_fecha_tran))
				
				if ld_monto = 8000.00 then
					ld_monto = 8000.00
				end if
				
			  choose case ls_naturaleza
					
				case 'D'			
						choose case li_mes
							case 1
								  UPDATE comayor  
									  SET mayo_ene_db = mayo_ene_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;
							case 2
								  UPDATE comayor  
									  SET mayo_feb_db = mayo_feb_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;
							case 3
								  UPDATE comayor  
									  SET mayo_mar_db = mayo_mar_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;
							case 4
								  UPDATE comayor  
									  SET mayo_abr_db = mayo_abr_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;
							case 5
								  UPDATE comayor  
									  SET mayo_may_db = mayo_may_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 6
								  UPDATE comayor  
									  SET mayo_jun_db = mayo_jun_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 7
								  UPDATE comayor  
									  SET mayo_jul_db = mayo_jul_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 8
								  UPDATE comayor  
									  SET mayo_ago_db = mayo_ago_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 9
								  UPDATE comayor  
									  SET mayo_sep_db = mayo_sep_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 10
								  UPDATE comayor  
									  SET mayo_oct_db = mayo_oct_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 11
								  UPDATE comayor  
									  SET mayo_nov_db = mayo_nov_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 12		
									if ls_transaccion <> 'RA' then
									  UPDATE comayor  
										  SET mayo_dic_db = mayo_dic_db + :ld_monto  
										WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
												( comayor.mayo_empresa = :str.empresa ) AND  
												( comayor.mayo_cuenta = :ls_cuenta ) AND  
												( comayor.mayo_ann = :li_ann ) ;
											if sqlca.sqlcode = -1 then
												gf_mensaje('','Error al Actualizar Mayor '+sqlca.sqlerrtext,1,1,'E')
												return
											end if						
									end if
							
								  UPDATE comayor  
									  SET mayo_cierre_db = mayo_cierre_db + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;
					end choose
					
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al Actualizar Mayor '+sqlca.sqlerrtext,1,1,'E')
							return
						end if						
					case 'C'
						choose case li_mes
							case 1
								  UPDATE comayor  
									  SET mayo_ene_cr = mayo_ene_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;
							case 2
								  UPDATE comayor  
									  SET mayo_feb_cr = mayo_feb_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;
							case 3
								  UPDATE comayor  
									  SET mayo_mar_cr = mayo_mar_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;
							case 4
								  UPDATE comayor  
									  SET mayo_abr_cr = mayo_abr_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;
							case 5
								  UPDATE comayor  
									  SET mayo_may_cr = mayo_may_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 6
								  UPDATE comayor  
									  SET mayo_jun_cr = mayo_jun_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 7
								  UPDATE comayor  
									  SET mayo_jul_cr = mayo_jul_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 8
								  UPDATE comayor  
									  SET mayo_ago_cr = mayo_ago_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 9
								  UPDATE comayor  
									  SET mayo_sep_cr = mayo_sep_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 10
								  UPDATE comayor  
									  SET mayo_oct_cr = mayo_oct_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 11
								  UPDATE comayor  
									  SET mayo_nov_cr = mayo_nov_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;								
							case 12		
								if ls_transaccion <> 'RA' then
								  UPDATE comayor  
									  SET mayo_dic_cr = mayo_dic_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;
											if sqlca.sqlcode = -1 then
												gf_mensaje('','Error al Actualizar Mayor '+sqlca.sqlerrtext,1,1,'E')
												return
											end if						
								end if
								
								  UPDATE comayor  
									  SET mayo_cierre_cr = mayo_cierre_cr + :ld_monto  
									WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
											( comayor.mayo_empresa = :str.empresa ) AND  
											( comayor.mayo_cuenta = :ls_cuenta ) AND  
											( comayor.mayo_ann = :li_ann ) ;						end choose
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al Actualizar Mayor Credito '+sqlca.sqlerrtext,1,1,'E')
							return
						end if												
				end choose
				
				wf_acumula_en_niveles_anteriores(ls_cuenta, ld_monto, ls_naturaleza, li_ann, li_mes, ls_transaccion)
				
				fetch cur_transacciones into :ls_cuenta, :ld_monto, :ls_naturaleza, :ldt_fecha_tran, :ls_transaccion ;
				
				i ++
				
			loop
			
			close cur_transacciones;
			
			//Recalcula los Saldos Iniciales
			
			wf_saldos_iniciales(li_ann_actual, li_mes_actual, li_ann_temp)


str.frame.setmicrohelp('HymSoft')			

parent.triggerevent('close')
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_recalcula_mayor_general
boolean visible = false
integer x = 18
integer y = 0
integer width = 987
integer height = 376
integer taborder = 0
long backcolor = 12639424
end type

type st_1 from statictext within w_recalcula_mayor_general
integer x = 160
integer y = 100
integer width = 914
integer height = 148
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "PROCESANDO..."
boolean focusrectangle = false
end type

