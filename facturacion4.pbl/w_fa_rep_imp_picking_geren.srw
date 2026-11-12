//objectcomments Ventana en donde se Desplegará el Data Window de impresion del Picking List Gerencial
forward
global type w_fa_rep_imp_picking_geren from w_fa_padre_reportes
end type
type dw_2 from datawindow within w_fa_rep_imp_picking_geren
end type
type dw_3 from datawindow within w_fa_rep_imp_picking_geren
end type
end forward

global type w_fa_rep_imp_picking_geren from w_fa_padre_reportes
integer width = 3333
integer height = 1752
string title = "Informe de Packing List Gerencial"
string menuname = "m_fa_rep"
dw_2 dw_2
dw_3 dw_3
end type
global w_fa_rep_imp_picking_geren w_fa_rep_imp_picking_geren

type variables
//Variable tipo Estructura
str_fa_carg_ped str_pedi
boolean ib_disparar_close
end variables

forward prototypes
public subroutine wf_imprime_vendedor (integer ai_agotados)
public subroutine wf_actualiza_antiguedad (datetime adt_desde, datetime adt_hasta, long al_tercero)
public subroutine wf_asigna_antig (long al_tercero)
end prototypes

public subroutine wf_imprime_vendedor (integer ai_agotados);integer li_hay, li_codigo, i=0
string  ls_nombre, ls_resultado, ls_nombre_imp, ls_cod_imp, ls_dataobject

datawindow ldw_1
if ai_agotados = 1 then
	ldw_1 = dw_2
else
	ldw_1 = dw_1
end if

ls_dataobject = dw_1.dataobject
		
if pos(ls_dataobject,"_prof",1) > 0 then  //Para cuando es proforma
		 DECLARE cur_vende_prof CURSOR FOR
		  SELECT fadvenpr.vpro_vendedor,   
					famvende.vend_nombre+' '+famvende.vend_apellido nombre  
			 FROM fadvenpr,   
					famvende  
			WHERE ( famvende.vend_g_financiero = fadvenpr.vpro_g_financiero ) and  
					( famvende.vend_empresa = fadvenpr.vpro_empresa ) and  
					( famvende.vend_vendedor = fadvenpr.vpro_vendedor ) and  
					( ( fadvenpr.vpro_g_financiero = :str.g_financiero ) AND  
					( fadvenpr.vpro_empresa = :str.empresa ) AND  
					( fadvenpr.vpro_no_proforma = :str_pedi.pedido ) AND  
					( fadvenpr.vpro_ann = :str_pedi.ano ) ) ;			
					
		 OPEN cur_vende_prof;
		 
		 if sqlca.sqlcode = -1 then
			mensaje("Aviso","Error al Abrir el Cursor",sqlca.sqlerrtext)
		 end if
		 
		 FETCH cur_vende_prof INTO :li_codigo,:ls_nombre;
		 
		 IF SQLCA.SQLCODE = -1 THEN	
			MESSAGEBOX("ERROR","ERROR AL SELECCIONAR LOS VENDEDORES "+SQLCA.SQLERRTEXT)
			CLOSE cur_vende_prof;
			RETURN
		 END IF	
		 
		 DO WHILE SQLCA.SQLCODE = 0
			 if i > 0 then //Si no es la primera vez ni la ultima, separa el codigo
				ls_nombre_imp += ' / '
				ls_cod_imp	+= ' / '		
			 end if	 
			 ls_nombre_imp += ls_nombre 	     //Concatena los codigos y nombres
			 ls_cod_imp		+= string(li_codigo)	 
			 i ++	 //Incrementa la i
			 FETCH cur_vende_prof INTO :li_codigo,:ls_nombre;	 
		 loop
		 
		 ls_resultado = ldw_1.modify("cod_vendedor.text='"+ls_cod_imp+"'")
		 ls_resultado = ldw_1.modify("nom_vendedor.text='"+ls_nombre_imp+"'")			
			 
		 CLOSE cur_vende_prof;

elseif pos(ls_dataobject,"_ped",1) > 0 then
		 DECLARE cur_vende_pe CURSOR FOR
		  SELECT fadvenpe.vped_vendedor,   
					famvende.vend_nombre+' '+famvende.vend_apellido nombre  
			 FROM fadvenpe,   
					famvende  
			WHERE ( famvende.vend_g_financiero = fadvenpe.vped_g_financiero ) and  
					( famvende.vend_empresa = fadvenpe.vped_empresa ) and  
					( famvende.vend_vendedor = fadvenpe.vped_vendedor ) and  
					( ( fadvenpe.vped_g_financiero = :str.g_financiero ) AND  
					( fadvenpe.vped_empresa = :str.empresa ) AND  
					( fadvenpe.vped_no_pedido = :str_pedi.pedido ) AND  
					( fadvenpe.vped_ann = :str_pedi.ano ) ) ;			
					
		 OPEN cur_vende_pe;
		 
		 if sqlca.sqlcode = -1 then
			mensaje("Aviso","Error al Abrir el Cursor",sqlca.sqlerrtext)
		 end if
		 
		 FETCH cur_vende_pe INTO :li_codigo,:ls_nombre;
		 
		 IF SQLCA.SQLCODE = -1 THEN	
			MESSAGEBOX("ERROR","ERROR AL SELECCIONAR LOS VENDEDORES "+SQLCA.SQLERRTEXT)
			CLOSE cur_vende_pe;
			RETURN
		 END IF	
		 
		 DO WHILE SQLCA.SQLCODE = 0
			 if i > 0 then //Si no es la primera vez ni la ultima, separa el codigo
				ls_nombre_imp += ' / '
				ls_cod_imp	+= ' / '		
			 end if	 
			 ls_nombre_imp += ls_nombre 	     //Concatena los codigos y nombres
			 ls_cod_imp		+= string(li_codigo)	 
			 i ++	 //Incrementa la i
			 FETCH cur_vende_pe INTO :li_codigo,:ls_nombre;	 
		 loop
		 
		 ls_resultado = ldw_1.modify("cod_vendedor.text='"+ls_cod_imp+"'")
		 ls_resultado = ldw_1.modify("nom_vendedor.text='"+ls_nombre_imp+"'")			
			 
		 CLOSE cur_vende_pe;

else		
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
					( fadvenfa.vfac_tipo = :str_pedi.tipo ) AND  
					( fadvenfa.vfac_no_pedido = :str_pedi.pedido ) AND  
					( fadvenfa.vfac_ann = :str_pedi.ano ) ) ;			 
	
 OPEN cur_vende;
 
 if sqlca.sqlcode = -1 then
	mensaje("Aviso","Error al Abrir el Cursor",sqlca.sqlerrtext)
 end if
 
 FETCH cur_vende INTO :li_codigo,:ls_nombre;
 
 IF SQLCA.SQLCODE = -1 THEN	
	MESSAGEBOX("ERROR","ERROR AL SELECCIONAR LOS VENDEDORES "+SQLCA.SQLERRTEXT)
	CLOSE cur_vende;
	RETURN
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
 
 ls_resultado = ldw_1.modify("cod_vendedor.text='"+ls_cod_imp+"'")
 ls_resultado = ldw_1.modify("nom_vendedor.text='"+ls_nombre_imp+"'")			
	 
 CLOSE cur_vende;
 
end if //del pos
end subroutine

public subroutine wf_actualiza_antiguedad (datetime adt_desde, datetime adt_hasta, long al_tercero);
Integer  li_registros, li_i, li_empresa, li_grupofin, li_emp, li_dberror, &
         li_tipo, li_socio, li_audit
decimal  ld_x, ld_y, ld_monto
string   ls_db_err,ls_where_select, ls_error,ls_error_proc
long 		ll_tercero,ll_i,ll_proximo
Datetime ld_tiempo1, ld_tiempo2

DELETE FROM ccatempa
WHERE ( ccatempa.tmpa_g_financiero 	= :str.g_financiero 	) AND  
      ( ccatempa.tmpa_empresa 		= :str.empresa 		) and
		( ccatempa.tmpa_usuario_maquina = :str.maquina 	) and
		( ccatempa.tmpa_tercero = :al_tercero );
		
if sqlca.sqlcode = -1 then
	messagebox('error','error al elimianr registros desde ccatempa')
end if

//datastore	lds_tercero_empresa, lds_tercero_gf,lds_cliente, lds_tercero_pais
Datawindowchild ldwc_sub_tran, ldwc_pais, ldwc_region

ld_tiempo1 = adt_desde
ld_tiempo2 = adt_hasta

ll_tercero = al_tercero
				
if ll_tercero = 99999 then
	gf_antiguedad_x_cliente_elbros(ld_tiempo2, ll_tercero,'E',ld_tiempo1)
else
	gf_antiguedad_x_cliente(ld_tiempo2, ll_tercero,'E',ld_tiempo1)
end if


end subroutine

public subroutine wf_asigna_antig (long al_tercero);string ls_error

  DELETE FROM ccatpan  
   WHERE ( ccatpan.tpan_g_financiero = :str.g_financiero ) AND  
         ( ccatpan.tpan_empresa = :str.empresa ) AND  
         ( ccatpan.tpan_maquina = :str.maquina )   ;
	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje('Aviso','Error al eliminar ccatpan',ls_error)
		return
	end if
	
	/* Inserta los nuevos valores */ 
  INSERT INTO ccatpan  
         ( tpan_g_financiero,tpan_empresa,tpan_tercero,tpan_saldo_anterior,
           tpan_col1,tpan_col2, tpan_col3,tpan_col4,tpan_col5,tpan_col6,   
           tpan_col7,tpan_col8,  tpan_col9, tpan_col10,tpan_col11,tpan_col12, 
           tpan_col13,tpan_col21,tpan_col1_t,tpan_col2_t,tpan_col3_t,   
           tpan_col4_t, tpan_col5_t,tpan_col6_t,tpan_col7_t,tpan_col8_t,   
           tpan_col9_t,tpan_col10_t,tpan_col11_t,tpan_col12_t,tpan_col13_t,
           tpan_col21_t,tpan_maquina)   
  SELECT ccatempa.tmpa_g_financiero,   
         ccatempa.tmpa_empresa,   
         ccatempa.tmpa_tercero,
			max( case ccatempa.tmpa_orden when 21 then ccatempa.tmpa_saldo_anterior  else ccatempa.tmpa_saldo_anterior end ),
			sum( case ccatempa.tmpa_orden when 1 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 2 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 3 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 4 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 5 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 6 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 7 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 8 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 9 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 10 then ccatempa.tmpa_monto else 0 end ),  
			sum( case ccatempa.tmpa_orden when 11 then ccatempa.tmpa_monto else 0 end ),  
			sum( case ccatempa.tmpa_orden when 12 then ccatempa.tmpa_monto else 0 end ),  
			sum( case ccatempa.tmpa_orden when 13 then ccatempa.tmpa_monto else 0 end ),  
			sum( case ccatempa.tmpa_orden when 21 then ccatempa.tmpa_monto else 0 end ),   
         max( case ccatempa.tmpa_orden when 1 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 2 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 3 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 4 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 5 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 6 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 7 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 8 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 9 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 10 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 11 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 12 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 13 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 21 then ccatempa.tmpa_descantig  else '' end ),
			max(ccatempa.tmpa_usuario_maquina) FROM ccatempa 
WHERE ( ccatempa.tmpa_g_financiero = :str.g_financiero ) AND  
      ( ccatempa.tmpa_empresa = :str.empresa ) and
		( ccatempa.tmpa_usuario_maquina = :str.maquina) and
		( ccatempa.tmpa_tercero = :al_tercero )
GROUP BY ccatempa.tmpa_g_financiero,   
         ccatempa.tmpa_empresa,   
         ccatempa.tmpa_tercero ;
if sqlca.sqlcode = -1 then
	ls_error = sqlca.sqlerrtext
	rollback;
	mensaje('Aviso ','Error al insertar en ccatpan',ls_error)
	return
else	
	commit ; 
	//mensaje('','Inserto en CCATPAN','')
	
end if
end subroutine

on w_fa_rep_imp_picking_geren.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_fa_rep" then this.MenuID = create m_fa_rep
this.dw_2=create dw_2
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
end on

on w_fa_rep_imp_picking_geren.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_3)
end on

event ue_post_open;//override
string ls_empresa,ls_title,ls_compute
String	ls_fec_ini,ls_fec_fin,ls_error
datetime   ldt_fecha_ini,ldt_fecha_fin
date     ld_fecha_ini,ld_fecha_fin
long ll_tercero

ls_empresa = gf_dg_nombre_empresa()
sqlca.autocommit = true

//Asigna el datawindow al reporte
str_pedi.datawindow = trim(str_pedi.datawindow)

dw_1.DataObject = str_pedi.datawindow

dw_1.settransobject(sqlca)
ls_title = 'Informe de Packing List Gerencial '

dw_2.settransobject(sqlca)
//sqlca.autocommit = false
// ***************************************************
if dw_1.dataobject <> "" then

	/*Valida de dònde debe seleccionarse el costo 0 = de inmprodu, 1 = de bodega*/
	/*MODIFICADO POR HGN EL 12/04/2002*/

	If w_fa_fondo.str_para.costo_de_prod_bodega = 'P'  then	//
	
	 choose case str_pedi.vienede
		case 'FA'
			ls_title += 'de Factura'
			/*Modificacion realizada para que se actualicen los costos de las facturas del dia seleccionado
			By HGN 10/01/2001*/				
	  
//********************************************************************************************
		
		If dw_1.retrieve(str.g_financiero,str.empresa,str_pedi.tipo, str_pedi.pedido,str_pedi.ano) < 1 then
			gf_mensaje("","La Factura No Existe",1,1,"E")
			str.frame.setredraw(True)				
			Return
		End If
		
		CASE 'PE'	
			ls_title += 'de Pedido'

			datetime ld_tiempo1, ld_tiempo2, ldt_fecha
			date		ldt_fecha_desde, ldt_fecha_hasta
			ldt_fecha = gf_fecha_serv()
			ldt_fecha_hasta = date(ldt_fecha)
			ldt_fecha_desde = relativedate(date(gf_fecha_serv()), - 365)
			ld_tiempo1 = Datetime(ldt_fecha_desde,00:00:00)
			ld_tiempo2 = Datetime(ldt_fecha_hasta,00:00:00)
			str.frame.setmicrohelp('Buscando el cliente de la proforma')
			  SELECT fatpedid.pedi_cliente  
				 INTO :ll_tercero  
				 FROM fatpedid  
				WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
						( fatpedid.pedi_empresa = :str.empresa ) AND  
						( fatpedid.pedi_no_pedido = :str_pedi.pedido ) AND  
						( fatpedid.pedi_ann = :str_pedi.ano )  ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al buscar clientes '+sqlca.sqlerrtext,1,1,'E')
					end if
			str.frame.setmicrohelp('Configurando la Antiguedad')
//			messagebox('','Antiguedad')
			wf_actualiza_antiguedad(ld_tiempo1, ld_tiempo2, ll_tercero)
			str.frame.setmicrohelp('Asignando Valores al Formato')
//			messagebox('','Asignacion')
			wf_asigna_antig(ll_tercero)		
							
	//************************************************************************************
			
	If w_fa_fondo.str_para.utiliza_decimales = 1 Then			
		
		
		If dw_1.Describe("exis_ent.x") <> "?" And dw_1.Describe("exis_ent.x") <> "!" Then		
		 dw.modify("exis_ent.format='###,###,##0.00'")
		End If
		
		If dw_1.Describe("dec.x") <> "?" And dw_1.Describe("dec.x") <> "!" Then		 
			dw.object.dec.expression = "'"+ "1" + "'"
		End If	
		
		//
		 If dw_1.Describe("exis_frac.x") <> "?" And dw_1.Describe("exis_frac.x") <> "!" Then
			dw_1.Modify("exis_frac.visible=False")
		 End If			 
		 
		 If dw_1.Describe("t_19.x") <> "?" And dw_1.Describe("t_19.x") <> "!" Then
			dw_1.Modify("t_19.visible=False") 
		 End If		
		// 
				
	 End If				
	
		//************************************************************************************	
	//				messagebox('','Retrieve')
			if dw_1.retrieve(str.g_financiero,str.empresa, str_pedi.pedido,str_pedi.ano, str.maquina) < 1 then
				gf_mensaje("","El Pedido No Existe ",1,1,"E")
				str.frame.setredraw(true)
				sqlca.autocommit = true
				return
			end if	
			
			//9/4/2001, para los agotados al imprimir
			if w_fa_fondo.str_para.agotados_al_imprimir = 1 then
				dw_2.retrieve(str.g_financiero,str.empresa, str_pedi.pedido,str_pedi.ano)				
				dw_2.Object.datawindow.print.preview = true				
			end if
		CASE 'PR' //PROFORMAS	
			
		//************************************************************************************	
		
				//Actualiza el costo_cif y costo total de la venta por renglon en faddiari
//			update fadprofo set dpro_costo_total =	convert(money,convert(money,(inmprodu.prod_costo_cif / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad) * (fadprofo.dpro_cantidad + ( fadprofo.dpro_fraccion /   inamedid_a.medi_cantidad )) ) , 
//							dpro_costo_cif = convert(money,(inmprodu.prod_costo_cif / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad),
//							dpro_costo_fob = convert(money,(inmprodu.prod_costo_fob / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad) 
//					 FROM fadprofo,   
//							fatprofo,   
//							inamedid inamedid_a,   
//							inamedid inamedid_b,   
//							inmprodu  
//					WHERE ( fadprofo.dpro_g_financiero = fatprofo.prof_g_financiero ) and  
//							( fadprofo.dpro_empresa = fatprofo.prof_empresa ) and  
//							( fadprofo.dpro_no_proforma = fatprofo.prof_no_proforma ) and  
//							( fadprofo.dpro_ann = fatprofo.prof_ann ) and  
//							( fadprofo.dpro_unidad_venta = inamedid_a.medi_medida ) and  
//							( inamedid_b.medi_medida = inmprodu.prod_medida ) and  
//							( fadprofo.dpro_codigo_item = inmprodu.prod_producto ) and  
//							( fadprofo.dpro_g_financiero = inmprodu.prod_g_financiero ) and  
//							( fadprofo.dpro_empresa = inmprodu.prod_empresa ) and  
//							( ( fadprofo.dpro_g_financiero = :str.g_financiero ) AND  
//							( fadprofo.dpro_empresa = :str.empresa ) AND  
//		      			( fadprofo.dpro_no_proforma = :str_pedi.pedido ) AND  
//				      	( fadprofo.dpro_ann = :str_pedi.ano ) ); 
//
//
//							If sqlca.sqlcode = -1 Then
//								ls_error = sqlca.sqlerrText
//								Rollback;
//								mensaje("Atención","Error al actualizar el costo del detalle de la proforma ",ls_error)
//								sqlca.autocommit = true								
//								//return 
//							End If
//				
//				//Actualiza el costo de la factura
//				
//				update  fatprofo  set prof_costos_total = 
//				( SELECT sum(fadprofo.dpro_costo_total)   
//					 FROM fadprofo
//					WHERE ( fadprofo.dpro_g_financiero = fatprofo.prof_g_financiero ) and  
//							( fadprofo.dpro_empresa = fatprofo.prof_empresa ) and  
//							( fadprofo.dpro_no_proforma = fatprofo.prof_no_proforma ) and  
//							( fadprofo.dpro_ann = fatprofo.prof_ann ) 
//				GROUP BY fatprofo.prof_g_financiero,   
//							fatprofo.prof_empresa,   
//							fatprofo.prof_no_proforma,   
//							fatprofo.prof_ann)
//					WHERE (fatprofo.prof_g_financiero = :str.g_financiero ) AND  
//							(fatprofo.prof_empresa = :str.empresa ) AND  
//					      ( fatprofo.prof_no_proforma = :str_pedi.pedido ) AND  
//					      ( fatprofo.prof_ann = :str_pedi.ano )  ; 
//				
//							If sqlca.sqlcode = -1 Then
//								ls_error = sqlca.sqlerrText
//								Rollback;
//								mensaje("Atención","Error al actualizar el costo total de la proforma fatprofo ",ls_error)
//								sqlca.autocommit = true
//								//return 
//							Else
//								Commit;
//							End If
//							
	//************************************************************************************		

			 If w_fa_fondo.str_para.utiliza_decimales = 1 Then			
				
				If dw_1.Describe("exis_ent.x") <> "?" And dw_1.Describe("exis_ent.x") <> "!" Then		
				 dw.modify("exis_ent.format='###,###,##0.00'")
				End If
				
				If dw_1.Describe("dec.x") <> "?" And dw_1.Describe("dec.x") <> "!" Then
				 dw.object.dec.expression = "'"+ "1" + "'"
				End If	
				
				//
				 If dw_1.Describe("exist_frac.x") <> "?" And dw_1.Describe("exist_frac.x") <> "!" Then
					dw_1.Modify("exist_frac.visible=False")
				 End If			 				
								 
			 End If							

		//************************************************************************************			
			
			ls_title += 'de Proforma'
			If dw_1.retrieve(str.g_financiero,str.empresa, str_pedi.pedido,str_pedi.ano) < 1 Then
				gf_mensaje("","La Proforma No Existe",1,1,"E")
				str.frame.setredraw(True)				
				Return
			End if		
	 End choose		
	 
Else	/*SI EL COSTO SE DEBE TOMAR DE LA BODEGA*/
	/*MODIFICADO POR HGN EL 12/04/2002*/
	 choose case str_pedi.vienede
		case 'FA'
			ls_title += 'de Factura'
			/*Modificacion realizada para que se actualicen los costos de las facturas del dia seleccionado
			By HGN 10/01/2001*/			
		
				//Actualiza el costo_cif y costo total de la venta por renglon en faddiari
		  update  faddiari set facd_costo_cif =   
					convert(numeric(12,2),ROUND((IsNull ( inmbodeg.mbod_costo_cif,0) / inamedid_a.medi_cantidad ) * inamedid_b.medi_cantidad,2)),   
					faddiari.facd_costo_fob =   
					convert(numeric(12,2),ROUND((IsNull (inmbodeg.mbod_costo_fob,0) / inamedid_a.medi_cantidad ) * inamedid_b.medi_cantidad,2)),   
					faddiari.facd_costo_total =   
					convert(numeric(12,2),convert(numeric(12,2),ROUND((IsNull(inmbodeg.mbod_costo_cif,0) / inamedid_a.medi_cantidad ) * inamedid_b.medi_cantidad,2)) * (isNull(faddiari.facd_cantidad ,0)+ ( IsNull(faddiari.facd_cantidad_fraccion,0) / inamedid_b.medi_cantidad )) ) 
			 FROM faddiari,   
					fatdiari,   
					inmbodeg,   
					inmprodu,   
					inamedid inamedid_a,   
					inamedid inamedid_b  
			WHERE ( fatdiari.fact_g_financiero = faddiari.facd_g_financiero ) and  
					( fatdiari.fact_empresa = faddiari.facd_empresa ) and  
					( fatdiari.fact_tipo = faddiari.facd_tipo ) and  
					( fatdiari.fact_no_pedido = faddiari.facd_no_pedido ) and  
					( fatdiari.fact_ann = faddiari.facd_ann ) and  
					( inmbodeg.mbod_g_financiero = faddiari.facd_g_financiero ) and  
					( inmbodeg.mbod_empresa = faddiari.facd_empresa ) and  
					( inmbodeg.mbod_bodega = faddiari.facd_bodega ) and  
					( inmbodeg.mbod_ubicacion = faddiari.facd_ubicacion ) and  
					( inmbodeg.mbod_producto = faddiari.facd_codigo_item ) and  
					( inmprodu.prod_g_financiero = inmbodeg.mbod_g_financiero ) and  
					( inmprodu.prod_empresa = inmbodeg.mbod_empresa ) and  
					( inmprodu.prod_producto = inmbodeg.mbod_producto ) and  
					( inmprodu.prod_g_financiero = faddiari.facd_g_financiero ) and  
					( inmprodu.prod_empresa = faddiari.facd_empresa ) and  
					( inmprodu.prod_producto = faddiari.facd_codigo_item ) and  
					( inamedid_a.medi_medida = inmprodu.prod_medida ) and  
					( inamedid_b.medi_medida = faddiari.facd_unidad_venta ) and  
					( ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
					( faddiari.facd_empresa = :str.empresa ) AND  
					( faddiari.facd_tipo = :str_pedi.tipo ) AND  
					( faddiari.facd_no_pedido = :str_pedi.pedido ) AND  
					( faddiari.facd_ann = :str_pedi.ano ) ); 

/****************************************************************/
							If sqlca.sqlcode = -1 then
								ls_error = sqlca.sqlerrText
								Rollback;
								mensaje("Atención","Error al actualizar el costo del detalle de faddiari ",ls_error)
								sqlca.autocommit = true
								//return 
							end if
				
				//Actualiza el costo de la factura
				
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
		     				 ( fatdiari.fact_tipo = :str_pedi.tipo ) AND  
					       ( fatdiari.fact_no_pedido = :str_pedi.pedido ) AND  
					       ( fatdiari.fact_ann = :str_pedi.ano )  ;
				
							If sqlca.sqlcode = -1 then
								ls_error = sqlca.sqlerrText
								Rollback;
								mensaje("Atención","Error al actualizar el costo total de la factura fatdiari ",ls_error)
								sqlca.autocommit = true
								//return 
							Else
								Commit;
							End If
						
//			End if
					
	  
//********************************************************************************************
		
		If dw_1.retrieve(str.g_financiero,str.empresa,str_pedi.tipo, str_pedi.pedido,str_pedi.ano) < 1 then
			gf_mensaje("","La Factura No Existe",1,1,"E")
			str.frame.setredraw(True)				
			Return
		End If
		
		CASE 'PE'	
			ls_title += 'de Pedido'

	

				//Actualiza el costo_cif y costo total de la venta por renglon en faddiari
/*				update fadpedid set dped_costo_total =	convert(money,convert(money,(inmprodu.prod_costo_cif / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad) * (fadpedid.dped_cantidad + ( fadpedid.dped_fraccion /   inamedid_a.medi_cantidad )) ) , 
							dped_costo_cif = convert(money,(inmprodu.prod_costo_cif / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad),
							dped_costo_fob = convert(money,(inmprodu.prod_costo_fob / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad) 
					 FROM fadpedid,   
							fatpedid,   
							inamedid inamedid_a,   
							inamedid inamedid_b,   
							inmprodu  
					WHERE ( fadpedid.dped_g_financiero = fatpedid.pedi_g_financiero ) and  
							( fadpedid.dped_empresa = fatpedid.pedi_empresa ) and  
							( fadpedid.dped_no_pedido = fatpedid.pedi_no_pedido ) and  
							( fadpedid.dped_ann = fatpedid.pedi_ann ) and  
							( fadpedid.dped_unidad_venta = inamedid_a.medi_medida ) and  
							( inamedid_b.medi_medida = inmprodu.prod_medida ) and  
							( fadpedid.dped_codigo_item = inmprodu.prod_producto ) and  
							( fadpedid.dped_g_financiero = inmprodu.prod_g_financiero ) and  
							( fadpedid.dped_empresa = inmprodu.prod_empresa ) and  
							( ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
							( fadpedid.dped_empresa = :str.empresa ) AND  
		      			( fadpedid.dped_no_pedido = :str_pedi.pedido ) AND  
				      	( fadpedid.dped_ann = :str_pedi.ano ) ); 
*/
		  	   update fadpedid set dped_costo_total = convert(numeric(12,2),convert(numeric(12,2),ROUND((IsNull(inmbodeg.mbod_costo_cif,0) / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad,2)) * (fadpedid.dped_cantidad + ( fadpedid.dped_fraccion /   inamedid_a.medi_cantidad )) ) ,
		  			 		dped_costo_cif = convert(numeric(12,2),ROUND((IsNull ( inmbodeg.mbod_costo_cif,0) / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad,2)),   
					 		dped_costo_fob = convert(numeric(12,2),ROUND((IsNull (inmbodeg.mbod_costo_fob,0) / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad,2)) 
					FROM fadpedid,   
							fatpedid,   
							inamedid inamedid_a,   
							inmbodeg,   
							inamedid inamedid_b,   
							inmprodu  
					WHERE ( fatpedid.pedi_g_financiero = fadpedid.dped_g_financiero ) and  
							( fatpedid.pedi_empresa = fadpedid.dped_empresa ) and  
							( fatpedid.pedi_no_pedido = fadpedid.dped_no_pedido ) and  
							( fatpedid.pedi_ann = fadpedid.dped_ann ) and  
							( inmbodeg.mbod_g_financiero = fadpedid.dped_g_financiero ) and  
							( inmbodeg.mbod_empresa = fadpedid.dped_empresa ) and  
							( inmbodeg.mbod_bodega = fadpedid.dped_bodega ) and  
							( inmbodeg.mbod_ubicacion = fadpedid.dped_ubicacion ) and  
							( inmbodeg.mbod_producto = fadpedid.dped_codigo_item ) and
				  
							( inamedid_a.medi_medida = fadpedid.dped_unidad_venta ) and  
							( inmprodu.prod_g_financiero = inmbodeg.mbod_g_financiero ) and  
							( inmprodu.prod_empresa = inmbodeg.mbod_empresa ) and  
							( inmprodu.prod_producto = inmbodeg.mbod_producto ) and  
							( inmprodu.prod_g_financiero = fadpedid.dped_g_financiero ) and  
							( inmprodu.prod_empresa = fadpedid.dped_empresa ) and  
							( inmprodu.prod_producto = fadpedid.dped_codigo_item ) and  
							( inamedid_b.medi_medida = inmprodu.prod_medida )   AND
											( ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
											( fadpedid.dped_empresa = :str.empresa ) AND  
											( fadpedid.dped_no_pedido = :str_pedi.pedido ) AND  
											( fadpedid.dped_ann = :str_pedi.ano ) ); 

							If sqlca.sqlcode = -1 Then
								ls_error = sqlca.sqlerrText
								Rollback;
								mensaje("Atención","Error al actualizar el costo del detalle de fadpedid ",ls_error)
								sqlca.autocommit = true
								//return 
							End If
				
				//Actualiza el costo de la factura
				
				update  fatpedid  set pedi_costos_total = 
				( SELECT sum(fadpedid.dped_costo_total)   
					 FROM fadpedid
					WHERE ( fadpedid.dped_g_financiero = fatpedid.pedi_g_financiero ) and  
							( fadpedid.dped_empresa = fatpedid.pedi_empresa ) and  
							( fadpedid.dped_no_pedido = fatpedid.pedi_no_pedido ) and  
							( fadpedid.dped_ann = fatpedid.pedi_ann ) 
				GROUP BY fatpedid.pedi_g_financiero,   
							fatpedid.pedi_empresa,   
							fatpedid.pedi_no_pedido,   
							fatpedid.pedi_ann)
					WHERE (fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
							(fatpedid.pedi_empresa = :str.empresa ) AND  
					      ( fatpedid.pedi_no_pedido = :str_pedi.pedido ) AND  
					      ( fatpedid.pedi_ann = :str_pedi.ano )  ; 
				
							If sqlca.sqlcode = -1 Then
								ls_error = sqlca.sqlerrText
								Rollback;
								mensaje("Atención","Error al actualizar el costo total del pedido fatpedid ",ls_error)
								sqlca.autocommit = true
								//return 
							Else
								Commit;
							End If
							
	//************************************************************************************
			
	If w_fa_fondo.str_para.utiliza_decimales = 1 Then			
		
		
		If dw_1.Describe("exis_ent.x") <> "?" And dw_1.Describe("exis_ent.x") <> "!" Then		
		 dw.modify("exis_ent.format='###,###,##0.00'")
		End If
		
		If dw_1.Describe("dec.x") <> "?" And dw_1.Describe("dec.x") <> "!" Then		 
			dw.object.dec.expression = "'"+ "1" + "'"
		End If	
		
		//
		 If dw_1.Describe("exis_frac.x") <> "?" And dw_1.Describe("exis_frac.x") <> "!" Then
			dw_1.Modify("exis_frac.visible=False")
		 End If			 
		 
		 If dw_1.Describe("t_19.x") <> "?" And dw_1.Describe("t_19.x") <> "!" Then
			dw_1.Modify("t_19.visible=False") 
		 End If		
		// 
				
	 End If				
	
		//************************************************************************************	
			if dw_1.retrieve(str.g_financiero,str.empresa, str_pedi.pedido,str_pedi.ano) < 1 then
				gf_mensaje("","El Pedido No Existe ",1,1,"E")
				str.frame.setredraw(true)
				sqlca.autocommit = true
				return
			end if	
			//9/4/2001, para los agotados al imprimir
			if w_fa_fondo.str_para.agotados_al_imprimir = 1 then
				dw_2.retrieve(str.g_financiero,str.empresa, str_pedi.pedido,str_pedi.ano)				
				dw_2.Object.datawindow.print.preview = true				
			end if
		CASE 'PR' //PROFORMAS	
			
		//************************************************************************************	
		
				//Actualiza el costo_cif y costo total de la venta por renglon en faddiari
/*				update fadprofo set dpro_costo_total =	convert(money,convert(money,(inmprodu.prod_costo_cif / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad) * (fadprofo.dpro_cantidad + ( fadprofo.dpro_fraccion /   inamedid_a.medi_cantidad )) ) , 
							dpro_costo_cif = convert(money,(inmprodu.prod_costo_cif / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad),
							dpro_costo_fob = convert(money,(inmprodu.prod_costo_fob / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad) 
					 FROM fadprofo,   
							fatprofo,   
							inamedid inamedid_a,   
							inamedid inamedid_b,   
							inmprodu  
					WHERE ( fadprofo.dpro_g_financiero = fatprofo.prof_g_financiero ) and  
							( fadprofo.dpro_empresa = fatprofo.prof_empresa ) and  
							( fadprofo.dpro_no_proforma = fatprofo.prof_no_proforma ) and  
							( fadprofo.dpro_ann = fatprofo.prof_ann ) and  
							( fadprofo.dpro_unidad_venta = inamedid_a.medi_medida ) and  
							( inamedid_b.medi_medida = inmprodu.prod_medida ) and  
							( fadprofo.dpro_codigo_item = inmprodu.prod_producto ) and  
							( fadprofo.dpro_g_financiero = inmprodu.prod_g_financiero ) and  
							( fadprofo.dpro_empresa = inmprodu.prod_empresa ) and  
							( ( fadprofo.dpro_g_financiero = :str.g_financiero ) AND  
							( fadprofo.dpro_empresa = :str.empresa ) AND  
		      			( fadprofo.dpro_no_proforma = :str_pedi.pedido ) AND  
				      	( fadprofo.dpro_ann = :str_pedi.ano ) ); 
*/

/*				update fadprofo set dpro_costo_total =	convert(money,convert(money,(inmprodu.prod_costo_cif / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad) * (fadprofo.dpro_cantidad + ( fadprofo.dpro_fraccion /   inamedid_a.medi_cantidad )) ) , 
						dpro_costo_cif = convert(money,(inmprodu.prod_costo_cif / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad),
						dpro_costo_fob = convert(money,(inmprodu.prod_costo_fob / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad) 
*/
		  	   update fadprofo set dpro_costo_total = convert(numeric(12,2),convert(numeric(12,2),ROUND((IsNull(inmbodeg.mbod_costo_cif,0) / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad,2)) * (fadprofo.dpro_cantidad + ( fadprofo.dpro_fraccion /   inamedid_a.medi_cantidad )) ) ,
		  			 		dpro_costo_cif = convert(numeric(12,2),ROUND((IsNull ( inmbodeg.mbod_costo_cif,0) / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad,2)),   
					 		dpro_costo_fob = convert(numeric(12,2),ROUND((IsNull (inmbodeg.mbod_costo_fob,0) / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad,2)) 

					 FROM fatprofo,   

							fadprofo,   
							inamedid inamedid_a,   
							inmbodeg,   
							inmprodu,   
							inamedid inamedid_b  
					WHERE ( fadprofo.dpro_g_financiero = fatprofo.prof_g_financiero ) and  
							( fadprofo.dpro_empresa = fatprofo.prof_empresa ) and  
							( fadprofo.dpro_no_proforma = fatprofo.prof_no_proforma ) and  
							( fadprofo.dpro_ann = fatprofo.prof_ann ) and  
							( inmbodeg.mbod_g_financiero = fadprofo.dpro_g_financiero ) and  
							( inmbodeg.mbod_empresa = fadprofo.dpro_empresa ) and  
							( inmbodeg.mbod_bodega = fadprofo.dpro_bodega ) and  
							( inmbodeg.mbod_ubicacion = fadprofo.dpro_ubicacion ) and  
							( inmbodeg.mbod_producto = fadprofo.dpro_codigo_item ) and  
							( inamedid_a.medi_medida = fadprofo.dpro_unidad_venta ) and  
							( inmprodu.prod_g_financiero = inmbodeg.mbod_g_financiero ) and  
							( inmprodu.prod_empresa = inmbodeg.mbod_empresa ) and  
							( inmprodu.prod_producto = inmbodeg.mbod_producto ) and  
							( inmprodu.prod_medida = inamedid_a.medi_medida ) and  
							( inamedid_b.medi_medida = inmprodu.prod_medida )   and
											( ( fadprofo.dpro_g_financiero = :str.g_financiero ) AND  
											( fadprofo.dpro_empresa = :str.empresa ) AND  
											( fadprofo.dpro_no_proforma = :str_pedi.pedido ) AND  
											( fadprofo.dpro_ann = :str_pedi.ano ) ); 

							If sqlca.sqlcode = -1 Then
								ls_error = sqlca.sqlerrText
								Rollback;
								mensaje("Atención","Error al actualizar el costo del detalle de la proforma ",ls_error)
								sqlca.autocommit = true								
								//return 
							End If
				
				//Actualiza el costo de la factura
				
				update  fatprofo  set prof_costos_total = 
				( SELECT sum(fadprofo.dpro_costo_total)   
					 FROM fadprofo
					WHERE ( fadprofo.dpro_g_financiero = fatprofo.prof_g_financiero ) and  
							( fadprofo.dpro_empresa = fatprofo.prof_empresa ) and  
							( fadprofo.dpro_no_proforma = fatprofo.prof_no_proforma ) and  
							( fadprofo.dpro_ann = fatprofo.prof_ann ) 
				GROUP BY fatprofo.prof_g_financiero,   
							fatprofo.prof_empresa,   
							fatprofo.prof_no_proforma,   
							fatprofo.prof_ann)
					WHERE (fatprofo.prof_g_financiero = :str.g_financiero ) AND  
							(fatprofo.prof_empresa = :str.empresa ) AND  
					      ( fatprofo.prof_no_proforma = :str_pedi.pedido ) AND  
					      ( fatprofo.prof_ann = :str_pedi.ano )  ; 
				
							If sqlca.sqlcode = -1 Then
								ls_error = sqlca.sqlerrText
								Rollback;
								mensaje("Atención","Error al actualizar el costo total de la proforma fatprofo ",ls_error)
								sqlca.autocommit = true
								//return 
							Else
								Commit;
							End If
							
	//************************************************************************************		

			 If w_fa_fondo.str_para.utiliza_decimales = 1 Then			
				
				If dw_1.Describe("exis_ent.x") <> "?" And dw_1.Describe("exis_ent.x") <> "!" Then		
				 dw.modify("exis_ent.format='###,###,##0.00'")
				End If
				
				If dw_1.Describe("dec.x") <> "?" And dw_1.Describe("dec.x") <> "!" Then
				 dw.object.dec.expression = "'"+ "1" + "'"
				End If	
				
				//
				 If dw_1.Describe("exist_frac.x") <> "?" And dw_1.Describe("exist_frac.x") <> "!" Then
					dw_1.Modify("exist_frac.visible=False")
				 End If			 				
								 
			 End If							

		//************************************************************************************			
			
			ls_title += 'de Proforma'
			If dw_1.retrieve(str.g_financiero,str.empresa, str_pedi.pedido,str_pedi.ano) < 1 Then
				gf_mensaje("","La Proforma No Existe",1,1,"E")
				str.frame.setredraw(True)				
				Return
			End if		
	 End choose		
	
end if
	 
	This.title = ls_title
	dw_1.Object.datawindow.print.preview = true
	dw_1.object.datawindow.print.preview.zoom =100
	dw_1.object.empresa.expression = "'"+ls_empresa+"'"
	dw_impresion = dw_1													//Para los eventos de Zoom + / -
	dw_1.object.datawin.expression = "'" + dw_1.dataobject + "'"	//Setea el nombre del Datawindow
	
	//si se le pone que vaya directo al printer, que dispare el evento imprimir y cierre la ventana
	if str_pedi.directo_al_printer then
		this.triggerevent('ue_print')
		if ib_disparar_close then this.postevent('close')
	end if

//dw_1.retrieve(str.g_financiero,str.empresa,str_pedi.pedido,str_pedi.ano ) 
end if
str.frame.setredraw(true)  

end event

event resize;////Override
dw_1.width  = this.width  - 99
dw_1.height = this.height - 278
gb_1.width  = this.width  - 63
gb_1.height = this.height - 220

st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180

end event

event open;call super::open;str_pedi = message.PowerObjectParm

end event

event ue_print;//override
OpenWithParm(w_dw_print_options, dw)
If Message.DoubleParm = -1 Then 
	ib_disparar_close = false
	Return
end if
ib_disparar_close = true
string ls_secuencia, ls_pedido
long  ll_secuencia
Integer li_existe, li_ann

if str_pedi.vienede = 'PE' then
	ls_secuencia = dw_1.getitemstring(1,'pedi_secuencia_gerencial')

	if (isnull(ls_secuencia) or ls_secuencia = '' ) then
	
		select fara_secuencia_gerencial
		into	:ls_secuencia
		from	faaparam
		where fara_g_financiero = :str.g_financiero and
				 fara_empresa		= :str.empresa; 
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Buscar Secuencia '+sqlca.sqlerrtext,1,1,'E')
					return
				end if
				
		ll_secuencia = long(ls_secuencia)
		ls_pedido =  str_pedi.pedido
		li_ann		 = str_pedi.ano
		li_existe = 1
		
		do while li_existe > 0
			ll_secuencia ++
			ls_secuencia = string(ll_secuencia)
			  SELECT count(*)  
				 INTO :li_existe  
				 FROM fatpedid  
				WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
						( fatpedid.pedi_empresa = :str.empresa ) AND  
						( fatpedid.pedi_no_pedido = :ls_pedido ) AND  
						( fatpedid.pedi_ann = :li_ann ) AND
						( fatpedid.pedi_secuencia_gerencial = :ls_secuencia );
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Buscar Existencia '+sqlca.sqlerrtext,1,1,'E')
					return
				end if	
		loop
		
		  UPDATE fatpedid  
			  SET pedi_secuencia_gerencial = :ls_secuencia  
			WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
					( fatpedid.pedi_empresa = :str.empresa ) AND  
					( fatpedid.pedi_no_pedido = :ls_pedido ) AND  
					( fatpedid.pedi_ann = :li_ann )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Actualizar Secuencia '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				return
			end if	
		
		UPDATE faaparam  
			  SET fara_secuencia_gerencial = :ls_secuencia  
			WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
					  ( faaparam.fara_empresa = :str.empresa );
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Actualizar Secuencia en parametros '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				return
			end if		
		
		dw_1.setitem(1,'pedi_secuencia_gerencial',ls_secuencia)		
	end if
end if	
dw.Print(True)
if w_fa_fondo.str_para.agotados_al_imprimir = 1 and dw_2.rowcount() > 0 then
	//dw_2.print(True)
end if

end event

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_rep_imp_picking_geren
integer x = 23
integer y = 1512
integer width = 1120
end type

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_rep_imp_picking_geren
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_rep_imp_picking_geren
integer x = 32
integer y = 48
integer width = 3214
integer height = 1432
string dataobject = "dw_fa_rep_imp_packing_geren_ped_tempo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event dw_1::retrieveend;call super::retrieveend;//Para imprimir los nombres o codigos de los vendedores
wf_imprime_vendedor(0)

String  ls_unidad_vta, ls_unidad_prod, ls_producto, ls_codigo, ls_unidad, ls_sexo, ls_define
Double  ld_costo_cif, ld_cantidad, ld_cant_fracc, ld_costo_total, ld_flete
decimal ld_reserva_total, ld_existencia, ld_existencia_fraccion, ld_total, ld_fraccion, ld_conversion, ld_costo_fob, ld_monto_final
//Double  arreglo[]
datetime ldt_fecha_entrada
Integer li_reg, li_articulo_promocion
long    ll_reserva_entera, ll_reserva_fraccion, ll_disponible
date 	  ldt_fecha_agotado
//Parent.SetRedraw(False)
//ldt_fecha_agotado = date(gf_fecha_serv())
//Para verificar si existe o no el campo de costo_t

if dw_1.Describe("costo_t.x") = "?" or dw_1.Describe("costo_t.x") = "!" then return


If Rowcount > 0 Then
	
	
	For li_reg = 1 To Rowcount				

	  if str_pedi.vienede = 'PR' then
				
			ls_unidad_vta  = dw_1.GetItemString(li_reg,"dpro_unidad_venta")
			ls_unidad_prod = dw_1.GetItemString(li_reg,"dpro_unidad_producto")
			ld_costo_cif   = dw_1.GetItemNumber(li_reg,"dpro_costo_cif")
			ld_cantidad    = dw_1.GetItemNumber(li_reg,"dpro_cantidad")
			ld_cant_fracc  = dw_1.GetItemNumber(li_reg,"dpro_fraccion")		
			ld_costo_fob	= dw_1.GetItemNumber(li_reg,"inmprodu_prod_costo_fob") 
			ls_codigo = dw_1.getitemstring(li_reg, 'dpro_codigo_item')
			
			if isnull(ld_costo_fob) then ld_costo_fob = 0
			ld_costo_fob   = round(ld_costo_fob * 1.05,2)			
     	 //Se Calcula el costo total del registro	
		  ld_costo_total = Round(gf_costo_total(ls_unidad_vta, ls_unidad_prod, ld_costo_fob, &
																ld_cantidad, ld_cant_fracc),2)					
     	  //Se asigna en el datawindow	
	     dw_1.SetItem(li_reg,"costo_t",ld_costo_total)						
		 
		 
			dw_3.retrieve(str.g_financiero, str.empresa, ls_codigo)
			ld_reserva_total = 0
			if dw_3.rowcount() > 0 then ld_reserva_total = dw_3.getitemnumber(1,'reserva_total')
			if isnull(ld_reserva_total) then ld_reserva_total = 0
				ld_existencia 	  = dw_1.getitemnumber(li_reg,'prod_existencia_total')
				
				ls_unidad 		  = dw_1.getitemstring(li_reg,'dpro_unidad_venta')
				ld_conversion	  = gf_unidad_venta(ls_unidad, 10)
				ld_total			  = truncate( (ld_existencia - ld_reserva_total) / ld_conversion, 0)
				dw_1.setitem(li_reg, 'disponible', ld_total)
				ld_fraccion = (((ld_existencia - ld_reserva_total) / ld_conversion) - truncate( (ld_existencia - ld_reserva_total) / ld_conversion ,0 )) * 12
				dw_1.setitem(li_reg, 'disponible_fraccion', ld_fraccion  )	
			
		elseif str_pedi.vienede = 'PE' then
				
			ls_unidad_vta  = dw_1.GetItemString(li_reg,"dped_unidad_venta")
			ls_unidad_prod = dw_1.GetItemString(li_reg,"dped_unidad_producto")
			ld_costo_cif   = dw_1.GetItemNumber(li_reg,"dped_costo_cif")
			ld_cantidad    = dw_1.GetItemNumber(li_reg,"dped_cantidad")
			ld_cant_fracc  = dw_1.GetItemNumber(li_reg,"dped_fraccion")					
		  	ls_codigo = dw_1.getitemstring(li_reg, 'dped_codigo_item')
			ld_monto_final =  dw_1.GetItemNumber(li_reg,"dped_monto_total")		
			ls_sexo = dw_1.GetItemString(li_reg,"prod_sexo")
	
		 if 	ls_codigo = '24-305578' then
			ls_codigo = '24-305578'
		 end if
	
			  SELECT max(inmprodu.prod_entrada_fecha)  , sum(prod_existencia_total), max(prod_costo_fob), isnull(max(prod_promocion),0), max(prod_costo_cif), isnull(max(prod_flete),0)
			 INTO :ldt_fecha_entrada  , :ld_existencia, :ld_costo_fob, :li_articulo_promocion, :ld_costo_cif, :ld_flete
			 FROM inmprodu  
			WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
					( inmprodu.prod_empresa in (:str.empresa,8) ) AND  
					( inmprodu.prod_producto = :ls_codigo )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Buscar fecha de entrada '+sqlca.sqlerrtext,1,1,'E')
				end if
	
			//ld_costo_fob	= dw_1.GetItemNumber(li_reg,"prod_costo_fob") 
			dw_1.setitem(li_reg, 'prod_costo_fob', ld_costo_fob + ld_flete)
//			if ls_codigo = 'W06-003B' then
//				ls_codigo = 'W06-003B'
//			end if
					select max(cradefineprod.defp_codefine)
						into	:ls_define
						FROM  inmprodu, cradetalle, cradefineprod
						WHERE  ( inmprodu.prod_g_financiero = cradetalle.deta_g_financiero ) and  
						         ( inmprodu.prod_empresa = cradetalle.deta_empresa ) and  
						         ( inmprodu.prod_tipo_item = cradetalle.deta_cod ) and  
						         ( inmprodu.prod_desc_item = cradetalle.deta_cod_det ) and  
						         ( inmprodu.prod_sexo = cradetalle.deta_cod_sex ) and  
						         ( cradetalle.deta_g_financiero = cradefineprod.defp_f_financiero ) and  
						         ( cradetalle.deta_empresa = cradefineprod.defp_empresa ) and  
						         ( cradetalle.deta_define = cradefineprod.defp_codefine )    and
								( inmprodu.prod_g_financiero = :str.g_financiero ) and
								( inmprodu.prod_empresa = :str.empresa ) and
								( inmprodu.prod_producto = :ls_codigo );
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al Buscar Definicion del Producto '+sqlca.sqlerrtext,1,1,'E')
						end if
			
			if str.empresa = 9 or str.empresa = 1 or ls_define = 'S' then 
				ld_costo_fob = round(ld_costo_fob + ld_flete,2)
				dw_1.setitem(li_reg, 'prod_costo_cif', ld_costo_cif)
				dw_1.setitem(li_reg, 'prod_costo_fob', ld_costo_fob)				
			end if
			dw_1.setitem(li_reg, 'inmprodu_prod_entrada_fecha', ldt_fecha_entrada)
			
			ldt_fecha_agotado	= date(dw_1.getitemdatetime(li_reg,"pedi_fecha"))
			ll_disponible    = dw_1.GetItemNumber(li_reg,"dped_disponible")
			if isnull(ld_costo_fob) then ld_costo_fob = 0
			if str.empresa <> 9 then 
				ld_costo_fob   = round((ld_costo_fob) * 1.05,2)
			end if
			
     	 //Se Calcula el costo total del registro										  //antes enviaba el cif
		 if li_articulo_promocion = 1 or pos(ls_codigo,'SAL') > 0 then
		 	  ld_costo_total = ld_monto_final 
		 else
//			  if str.empresa = 9 then
//				ld_costo_total = Round(gf_costo_total(ls_unidad_vta, ls_unidad_prod, ld_costo_cif, ld_cantidad, ld_cant_fracc),2)					
//			  else
				 ld_costo_total = Round(gf_costo_total(ls_unidad_vta, ls_unidad_prod, (ld_costo_fob), ld_cantidad, ld_cant_fracc),2)					
//			end if
		 end if
     	  //Se asigna en el datawindow	
	     dw_1.SetItem(li_reg,"costo_t",ld_costo_total)									
		 
			dw_3.retrieve(str.g_financiero, str.empresa, ls_codigo)
			if dw_3.rowcount() > 0 then						
				ld_reserva_total = dw_3.getitemnumber(1,'reserva_total')
			//	ld_existencia 	  = dw_1.getitemnumber(li_reg,'prod_existencia_total')
				
				ls_unidad 		  = dw_1.getitemstring(li_reg,'dped_unidad_venta')
				ld_conversion	  = gf_unidad_venta(ls_unidad, 10)
				ld_total			  = truncate( (ld_existencia - ld_reserva_total) / ld_conversion, 0)
				dw_1.setitem(li_reg, 'disponible', ld_total)
				ld_fraccion = (((ld_existencia - ld_reserva_total) / ld_conversion) - truncate( (ld_existencia - ld_reserva_total) / ld_conversion ,0 )) * 12
				dw_1.setitem(li_reg, 'disponible_fraccion', ld_fraccion  )
				ll_disponible = ll_disponible - (ld_cantidad * ld_conversion + ld_cant_fracc)
			
				if ld_total <= 1 and not isnull(ldt_fecha_entrada) then	// si al disponibilidad es menor o igual a una docena lo graba en tabla de agotados
		//		if ll_disponible <= 12 then
					  INSERT INTO fadagotados  
								( agot_g_financiero,   
								  agot_empresa,   
								  agot_producto,   
								  agot_no_pedido,   
								  agot_anno,   
								  agot_fecha_agotado,   
								  agot_cantidad,
								  agot_usuario,
								  agot_maquina)  
					  VALUES ( :str.g_financiero,   
								  :str.empresa,   
								  :ls_codigo,   
								  :str_pedi.pedido,   
								  :str_pedi.ano,   
								  :ldt_fecha_agotado,   
								  :ld_cantidad,
								  :str.usuario,
								  :str.maquina)  ;
						if sqlca.sqlcode = -1 then
						//	gf_mensaje('','Error al insertar en Agotados '+sqlca.sqlerrtext,1,1,'E')
						end if
						
						  UPDATE inmprodu  
						  SET prod_pedido_agotado = :str_pedi.pedido,   
								prod_ann_agotado = :str_pedi.ano  ,
								prod_fecha_agotado = :ldt_fecha_agotado
						WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
								( inmprodu.prod_empresa = :str.empresa ) AND  
								( inmprodu.prod_producto = :ls_codigo )   ;
						if sqlca.sqlcode = -1 then
						//	gf_mensaje('','Error al Actualizar en Productos Agotados '+sqlca.sqlerrtext,1,1,'E')
						end if

						
						commit ;						
				end if
				
			end if	
		  
		elseif str_pedi.vienede = 'FA' then
				
			ls_unidad_vta  = dw_1.GetItemString(li_reg,"facd_unidad_venta")
			ls_unidad_prod = dw_1.GetItemString(li_reg,"facd_unidad_producto")
			ld_costo_cif   = dw_1.GetItemNumber(li_reg,"facd_costo_cif")
			ld_cantidad    = dw_1.GetItemNumber(li_reg,"facd_cantidad")
			ld_cant_fracc  = dw_1.GetItemNumber(li_reg,"facd_cantidad_fraccion")		
			ld_costo_fob	= dw_1.GetItemNumber(li_reg,"prod_costo_fob") 
			if isnull(ld_costo_fob) then ld_costo_fob = 0
			ld_costo_fob   = round(ld_costo_fob * 1.05,2)
			
			
     	 //Se Calcula el costo total del registro	
		  ld_costo_total = Round(gf_costo_total(ls_unidad_vta, ls_unidad_prod, ld_costo_fob, &
																ld_cantidad, ld_cant_fracc),2)					
     	  //Se asigna en el datawindow	
	     dw_1.SetItem(li_reg,"costo_t",ld_costo_total)									

		  //Para buscar la reserva real
		  	ls_codigo = dw_1.getitemstring(li_reg, 'facd_codigo_item')
			dw_3.retrieve(str.g_financiero, str.empresa, ls_codigo)
			if dw_3.rowcount() > 0 then
				ld_reserva_total = dw_3.getitemnumber(1,'reserva_total')
				ld_existencia 	  = dw_1.getitemnumber(li_reg,'prod_existencia_total')
				ls_unidad 		  = dw_1.getitemstring(li_reg,'facd_unidad_venta')
				ld_conversion	  = gf_unidad_venta(ls_unidad, 10)
				ld_total			  = truncate( (ld_existencia - ld_reserva_total) / ld_conversion, 0)
				dw_1.setitem(li_reg, 'disponible', ld_total)
				ld_fraccion = (((ld_existencia - ld_reserva_total) / ld_conversion) - truncate( (ld_existencia - ld_reserva_total) / ld_conversion ,0 )) * 12
				dw_1.setitem(li_reg, 'disponible_fraccion', ld_fraccion  )			
			end if							
						
	  end if
		
	
		
	Next
	
End If

end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_rep_imp_picking_geren
integer x = 14
integer y = 4
integer width = 3264
integer height = 1504
end type

type dw_2 from datawindow within w_fa_rep_imp_picking_geren
boolean visible = false
integer x = 1230
integer y = 1072
integer width = 1344
integer height = 696
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_fa_rep_agotada_pedido"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event retrieveend;//Para imprimir los nombres o codigos de los vendedores
wf_imprime_vendedor(1)
end event

type dw_3 from datawindow within w_fa_rep_imp_picking_geren
boolean visible = false
integer x = 512
integer y = 1148
integer width = 411
integer height = 432
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_fa_rep_reservados"
boolean livescroll = true
end type

event constructor;dw_3.settransobject(sqlca)
end event

