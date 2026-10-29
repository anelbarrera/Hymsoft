//objectcomments Ventana de Captura de Tránsitos
forward
global type w_cz_ma_transito from w_fa_padre
end type
type tab_1 from tab within w_cz_ma_transito
end type
type tabpage_1 from userobject within tab_1
end type
type dw_7 from datawindow within tabpage_1
end type
type dw_5 from datawindow within tabpage_1
end type
type dw_4 from datawindow within tabpage_1
end type
type cb_cambiar from commandbutton within tabpage_1
end type
type cb_buscar from commandbutton within tabpage_1
end type
type p_1 from picture within tabpage_1
end type
type dw_generales from datawindow within tabpage_1
end type
type pb_3 from picture within tabpage_1
end type
type dw_3 from datawindow within tabpage_1
end type
type dw_8 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_7 dw_7
dw_5 dw_5
dw_4 dw_4
cb_cambiar cb_cambiar
cb_buscar cb_buscar
p_1 p_1
dw_generales dw_generales
pb_3 pb_3
dw_3 dw_3
dw_8 dw_8
end type
type tabpage_2 from userobject within tab_1
end type
type cb_3 from commandbutton within tabpage_2
end type
type dw_detalle from datawindow within tabpage_2
end type
type dw_2 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
cb_3 cb_3
dw_detalle dw_detalle
dw_2 dw_2
end type
type tabpage_3 from userobject within tab_1
end type
type tabpage_3 from userobject within tab_1
end type
type tabpage_4 from userobject within tab_1
end type
type st_2 from statictext within tabpage_4
end type
type pb_2 from picturebutton within tabpage_4
end type
type dw_imp_referencias from datawindow within tabpage_4
end type
type dw_listado from datawindow within tabpage_4
end type
type tabpage_4 from userobject within tab_1
st_2 st_2
pb_2 pb_2
dw_imp_referencias dw_imp_referencias
dw_listado dw_listado
end type
type tabpage_5 from userobject within tab_1
end type
type dw_10 from datawindow within tabpage_5
end type
type dw_9 from datawindow within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_10 dw_10
dw_9 dw_9
end type
type tab_1 from tab within w_cz_ma_transito
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type
type st_microhelp from statictext within w_cz_ma_transito
end type
type pb_1 from picturebutton within w_cz_ma_transito
end type
type cb_1 from commandbutton within w_cz_ma_transito
end type
type cb_2 from commandbutton within w_cz_ma_transito
end type
type st_1 from statictext within w_cz_ma_transito
end type
type st_3 from statictext within w_cz_ma_transito
end type
type st_5 from statictext within w_cz_ma_transito
end type
type cb_continuar from commandbutton within w_cz_ma_transito
end type
type cb_cancelar from commandbutton within w_cz_ma_transito
end type
type dw_6 from datawindow within w_cz_ma_transito
end type
type cb_4 from commandbutton within w_cz_ma_transito
end type
end forward

shared variables

end variables

global type w_cz_ma_transito from w_fa_padre
integer x = 133
integer y = 100
integer width = 4439
integer height = 2048
string title = "Captura de Factura del Proveedor - Transito"
string menuname = "m_hs"
boolean controlmenu = false
event ue_rbclick ( )
event ue_dwnkey pbm_activate
event ue_nulo ( )
tab_1 tab_1
st_microhelp st_microhelp
pb_1 pb_1
cb_1 cb_1
cb_2 cb_2
st_1 st_1
st_3 st_3
st_5 st_5
cb_continuar cb_continuar
cb_cancelar cb_cancelar
dw_6 dw_6
cb_4 cb_4
end type
global w_cz_ma_transito w_cz_ma_transito

type variables
datawindowchild idwchild,idwchild2,idwchild3, idwc_plan
datawindow idw_4, idw_5, idw_7, idw_9

string	is_descripcion_oc, is_numero_oc,is_codigo_referencia,is_sec_oc,&
         is_campo,is_numero_sup,is_unidad_fija, is_ruta

long		il_year, il_numero_oc,il_year_anterior,il_row
integer	ii_numero_tipo_compra,li_tipo_compra,ii_an,li_empaque,ii_definicion,ii_tabpage

string	is_pedido,is_tipo,is_sec_oc1,is_key,is_produc,is_parte,is_color,&
			is_descripcion,is_medida
boolean	ib_no_insertar,ib_adicionar,ib_band, ib_graba_modificado_por = false
dec{4}	id_costo

str_pase_fact lstr_pase, lstr_pase_devuelto
str_cr_formato str_formato
str_fa_cargo_fac	str_cargo
str_in_parte	str_parte

end variables

forward prototypes
public subroutine wf_set_datos_proveedor (datawindow pdw, integer pli_row, long pll_num_provee)
public function string wf_buscar_servicio ()
public function boolean wf_cargos_iniciales ()
public subroutine wf_cargos (double ld_cargos)
public subroutine wf_pase_presupuesto ()
public subroutine wf_calcula_costos (integer ai_row)
public function string wf_buscar_producto ()
public subroutine wf_busca_prod ()
public function boolean wf_enviar_correo ()
public function boolean wf_enviar_correo_a_muestras ()
public function boolean wf_registra_asiento (long al_entrada, string as_detalle)
end prototypes

public subroutine wf_set_datos_proveedor (datawindow pdw, integer pli_row, long pll_num_provee);long ll_tercero
string ls_descripcion,ls_direccion,ls_telefono1,ls_telefono2,ls_fax1
string ls_email, ls_mensaje_error
long ll_num_error, li_pais


SELECT terc_tercero,terc_descripcion,terc_direccion,   
terc_telefono1,terc_telefono2,terc_fax1,terc_email,terc_pais
INTO :ll_tercero,:ls_descripcion,:ls_direccion,:ls_telefono1,:ls_telefono2,
:ls_fax1,:ls_email,:li_pais
FROM dgmterce  
WHERE dgmterce.terc_tercero = :pll_num_provee;


if sqlca.sqlcode = -1 then
	ls_mensaje_error = sqlca.sqlerrtext
	ll_num_error = sqlca.sqldbcode
	rollback;
	messagebox('Error '+string(ll_num_error),ls_mensaje_error)
	return
end if

/* Asigna o Blanque los datos del proveedor */
pdw.Setitem(pli_row,'toco_num_prove',pll_num_provee)
pdw.Setitem(pli_row,'terc_descripcion',ls_descripcion)
pdw.Setitem(pli_row,'terc_telefono1',ls_telefono1)
pdw.Setitem(pli_row,'terc_telefono2',ls_telefono2)
pdw.Setitem(pli_row,'terc_fax1',ls_fax1)
pdw.Setitem(pli_row,'terc_email',ls_email)
pdw.Setitem(pli_row,'terc_pais',li_pais)
pdw.Setitem(pli_row,'terc_direccion',ls_direccion)

IF pll_num_provee <> ll_tercero  then	
	Mensaje("Atencion ", "El numero de Proveedor no Existe o No esta Asociado en Compras, Rectifique","")
end if
end subroutine

public function string wf_buscar_servicio ();String					ls_syntax, ls_codigo_referencia
str_dg_dynamic_find	lstr_df

// Parámetros para la Búsqueda

lstr_df.texto_campo [1,1] = "craservi.serv_codigo"
lstr_df.texto_campo [1,2] = "Cód. de Servicio"
lstr_df.texto_campo [1,3] = "serv_codigo"
lstr_df.texto_campo [1,4] = "V"
lstr_df.texto_campo [2,1] = "craservi.serv_descripcion"
lstr_df.texto_campo [2,2] = "Descripción"
lstr_df.texto_campo [2,3] = ""
lstr_df.texto_campo [2,4] = "V"
lstr_df.tabla 		  = "craservi"

OpenWithParm(w_cr_busqueda,lstr_df)
ls_syntax	= Message.StringParm

ls_codigo_referencia = Right(ls_syntax,Len(ls_syntax) - Pos(ls_syntax, "="))
ls_codigo_referencia = Right(ls_codigo_referencia,Len(ls_codigo_referencia) - Pos(ls_codigo_referencia,"'"))
ls_codigo_referencia = Left(ls_codigo_referencia,Len(trim(ls_codigo_referencia)) - 1)

return ls_codigo_referencia

end function

public function boolean wf_cargos_iniciales ();// Una vez que el usuario aplique un cargo
// Modificado por Gianni Arauz (27/04/2000). Optimizacion de Sql's.


Integer	li_cargo, li_encontro
dec{4}	ld_monto	// Gianni Arauz (27/04/2000). El monto es decimal de cuatro posiciones.
string	ls_errtext
 
DECLARE CARGOS CURSOR FOR
SELECT crmgastd.mgad_cod_gasto_desc
FROM crmgastd
WHERE ( crmgastd.mgad_g_financiero = :str.g_financiero ) AND
		( crmgastd.mgad_empresa = :str.empresa );

if sqlca.sqlcode = -1 then
	this.setredraw(true)
	ls_errtext = sqlca.sqlerrtext
	rollback;
	mensaje("Información(wf_cargos_iniciales)","Error al Seleccionar en crmgastd para abrir el cursor",ls_errtext)
	return false
end if

open CARGOS;
 
FETCH CARGOS INTO :li_cargo;
 
IF SQLCA.SQLCODE = -1 then
	this.setredraw(true)
	ls_errtext = sqlca.sqlerrtext
	messagebox("Error","Error en Cargos: "+ls_errtext)
	close CARGOS;
	return false
END IF

DO WHILE sqlca.sqlcode = 0
	ld_monto = 0
	INSERT INTO crdgastd
         (dgas_g_financiero,
           dgas_empresa,
           dgas_codigo,
           dgas_anno,
			  dgas_num_suplemento,
           dgas_cod_cargo,
           dgas_monto_cargo)
	VALUES (:str.g_financiero,
           :str.empresa,
           :is_numero_oc,
           :il_year,
			  :is_numero_sup,
           :li_cargo,
			  :ld_monto);
	
	if sqlca.sqlcode = -1 then
		this.setredraw(true)
		ls_errtext = sqlca.sqlerrtext
		rollback;
		mensaje("Aviso","Error al Insertar en Detalle de Cargos",ls_errtext)
		return false
	end if
	
	FETCH CARGOS INTO :li_cargo;
LOOP

CLOSE CARGOS;

if sqlca.sqlcode = -1 then
	this.setredraw(true)
	ls_errtext = sqlca.sqlerrtext
	rollback;
	messagebox('Error','Descripción del error: '+ls_errtext)
	return false
end if

return true

end function

public subroutine wf_cargos (double ld_cargos);dec{4}			ld_cargos_act
datawindow	ldw_1
string		ls_errtext

ldw_1 = tab_1.tabpage_1.dw_generales
 
ld_cargos_act = ldw_1.getitemnumber(ldw_1.getrow(),"toco_gastos_total")	// Cargos actuales

ldw_1.setitem(ldw_1.getrow(),"toco_gastos_total",ld_cargos)

UPDATE crtordco
SET toco_gastos_total = :ld_cargos
WHERE	( toco_g_financiero   = :str.g_financiero ) AND
		( toco_empresa 		 = :str.empresa ) AND
		( toco_codigo_oc 		 = :is_numero_oc ) AND
		( toco_anno_oc			 = :il_year ) AND
		( toco_num_suplemento = :is_numero_sup);

if sqlca.sqlcode = -1 then
	ls_errtext = sqlca.sqlerrtext
	rollback;
	messagebox('Error','Descripción del error: '+ls_errtext)
	return
elseif sqlca.sqlcode = 100 then
	rollback;
	messagebox('Atención','No se actualizaron los gastos.',Exclamation!)
end if

end subroutine

public subroutine wf_pase_presupuesto ();///*Inserción de Ordenes de Compra para el módulo de Presupuesto Mayté Aparicio (10/12/1999)*/
//	datetime		ldt_fectran, ldt_fecreg
//	dec{2}		ld_monto
//	String		ls_tippag, ls_trans,ls_sub_trans,ls_aplicacion,ls_estado,ls_errtext,ls_dbcode
//	String 		ls_naturaleza,ls_cuenta,ls_conta
//	Integer		li_count,li_renglon,li_final,li_actual,li_cambio
//	Long			ll_numprov
//	ldt_fectran = gf_fecha_serv()
//	ldt_fecreg = ldt_fectran
//	ld_monto = tab_1.tabpage_2.dw_detalle.getitemnumber(1,'t_final')
//	ll_numprov = tab_1.tabpage_1.dw_generales.getitemnumber(tab_1.tabpage_1.dw_generales.getrow(),'toco_num_prove')
//
//SELECT count(*)
//	INTO	:li_count
//	FROM 	prtmovim
//	Where prtm_g_financiero      = :str.g_financiero and
//		   prtm_empresa           = :str.empresa      and
//         prtm_aplicacion        = :str.aplicacion   and
//			prtm_transaccion       = 'OC'              and
//			prtm_sub_transaccion   = 'OC'              and
//			prtm_documento			  = :is_numero_oc     and
//			prtm_year				  = :il_year;
//
//	If Sqlca.SqlCode = -1 Then
//		Messagebox("Error # "+String(Sqlca.SqldbCode),"Descripción del error:"+Sqlca.SqlerrText)
//		return
//	End If
//
//	if li_count = 0 then
//		INSERT INTO prtmovim
//			(prtm_g_financiero,
//			prtm_empresa,
//			prtm_aplicacion,
//			prtm_transaccion,
//			prtm_sub_transaccion,
//			prtm_documento,
//			prtm_year,
//			prtm_tercero,
//			prtm_fecha_trans,
//			prtm_monto,
//			prtm_estado)
//		VALUES (:str.g_financiero,
//			:str.empresa,
//			:str.aplicacion,
//			'OC',
//			'OC',
//			:is_numero_oc,
//			:il_year,
//			:ll_numprov,
//			:ldt_fectran,
//			:ld_monto,
//			'O');
//			
//		if sqlca.sqlcode <> 0 then
//			ls_errtext = sqlca.sqlerrtext
//			ls_dbcode = string(sqlca.sqldbcode)
//			rollback;
//			mensaje('Error # '+ls_dbcode,'Error en el Pase al Sistema de Presupuesto.',&
//						'Descripción del error: '+ls_errtext)
//			return
//		end if
//	Else
//	/*Actualización del encabezado de la orden de compra*/		
//			ld_monto = tab_1.tabpage_2.dw_detalle.getitemnumber(1,'t_final')
//			ll_numprov = tab_1.tabpage_1.dw_generales.getitemnumber(tab_1.tabpage_1.dw_generales.getrow(),'toco_num_prove')
//			ldt_fectran = gf_fecha_serv()
//			ldt_fecreg = ldt_fectran
//			UPDATE prtmovim
//			SET prtm_documento      =:is_numero_oc,
//				 prtm_tercero        =:ll_numprov,
//				 prtm_monto          =:ld_monto,
//				 prtm_fecha_trans    =:ldt_fecreg
//			WHERE prtm_g_financiero =:str.g_financiero and
//				prtm_empresa         =:str.empresa      and
//				prtm_aplicacion      =:str.aplicacion   and
//				prtm_transaccion     ='OC'              and
//				prtm_sub_transaccion ='OC'              and
//				prtm_year            =:il_year			 and	
//				prtm_documento       =:is_numero_oc; 		
//	end if	
//	
///*Inserción del detalle de la Orden de Compra*/		
//   li_renglon = dw.getitemnumber(dw.rowcount(),"doco_num_renglon_oc")			
//	SELECT count(*)
//	INTO	:li_count
//	FROM 	prdmovim
//	Where prdm_g_financiero      = :str.g_financiero and
//		   prdm_empresa           = :str.empresa      and
//         prdm_aplicacion        = :str.aplicacion   and
//			prdm_transaccion       = 'OC'              and
//			prdm_subtrans          = 'OC'              and
//			prdm_documento			  = :is_numero_oc     and
//			prdm_year				  = :il_year			 and
//         prdm_renglon		     = :li_renglon;
//
//	If Sqlca.SqlCode = -1 Then
//		Messagebox("Error # "+String(Sqlca.SqldbCode),"Descripción del error:"+Sqlca.SqlerrText)
//		return
//	End If
//	If li_count = 0 then
//		FOR li_actual = 1 to dw.rowcount() 
//				ls_cuenta   = tab_1.tabpage_2.dw_detalle.getitemstring(li_actual,'doco_tipo_oc')
//				li_renglon  = tab_1.tabpage_2.dw_detalle.getitemnumber(li_actual,'doco_num_renglon_oc')
//				ld_monto    = tab_1.tabpage_2.dw_detalle.getitemnumber(li_actual,'total_l')
//				
//				Select cratipcr.crtc_mg_cuenta
//				Into :ls_conta
//				From cratipcr
//				Where crtc_codigo  = :ls_cuenta;				
//
//			INSERT INTO prdmovim
//				(prdm_g_financiero,
//				prdm_empresa,
//				prdm_aplicacion,
//				prdm_transaccion,
//				prdm_subtrans,
//				prdm_documento,
//				prdm_year,
//				prdm_renglon,
//				prdm_cuenta_presup,
//				prdm_monto,
//				prdm_naturaleza)
//			VALUES (:str.g_financiero,
//				:str.empresa,
//				:str.aplicacion,
//				'OC',
//				'OC',
//				:is_numero_oc,
//				:il_year,
//				:li_renglon,
//				:ls_conta,
//				:ld_monto,
//				'D');
//		Next		
//		if sqlca.sqlcode <> 0 then
//			ls_errtext = sqlca.sqlerrtext
//			ls_dbcode = string(sqlca.sqldbcode)
//			rollback;
//			mensaje('Error # '+ls_dbcode,'Error en el Pase del Detalle de la Orden de Compra al Sistema de Presupuesto.',&
//						'Descripción del error: '+ls_errtext)
//			return
//		end if
//	else
//		/*Actualización del detalle de la Orden de compra*/	
//			FOR li_cambio   = 1 to dw.rowcount()
//				 li_renglon  = dw.getitemnumber(li_cambio,'doco_num_renglon_oc')
//				 ls_cuenta   = dw.getitemstring(li_cambio,'doco_tipo_oc')
//				 ld_monto    = dw.getitemnumber(li_cambio,'total_l')
//				 
// 				Select cratipcr.crtc_mg_cuenta
//				Into :ls_conta
//				From cratipcr
//				Where crtc_codigo  = :ls_cuenta;				
//				 
//				UPDATE prdmovim
//				Set	 prdm_cuenta_presup =:ls_conta,
//						 prdm_monto         =:ld_monto
//				WHERE  prdm_g_financiero  =:str.g_financiero and
//						 prdm_empresa		  =:str.empresa      and
//						 prdm_aplicacion    =:str.aplicacion   and
//						 prdm_transaccion	  ='OC'              and
//						 prdm_subtrans		  ='OC'              and
//						 prdm_year			  =:il_year          and					
//						 prdm_documento	  =:is_numero_oc     and
//						 prdm_renglon		  =:li_renglon;
//			NEXT
//
//			if sqlca.sqlcode <> 0 then
//				ls_errtext = sqlca.sqlerrtext
//				ls_dbcode = string(sqlca.sqldbcode)
//				rollback;
//				mensaje('Error # '+ls_dbcode,'Error en la Actualización del Detalle de la orden de Compra a el módulo de'+&
//						'Presupuesto.','Descripción del error: '+ls_errtext)
//				return
//			end if
//	end if
///*Fin de la inserción al módulo de Presupuesto*/

end subroutine

public subroutine wf_calcula_costos (integer ai_row);//Función donde se calculan los costos
Decimal{4}	ld_precio,ld_elmont,ld_direct,ld_flete,ld_gastos,ld_mylin,ld_pventa,ld_porcentaje,ld_margen
Datawindow  ldw_detalle
Integer i
ldw_detalle = tab_1.tabpage_2.dw_detalle

ldw_detalle.Accepttext()

ld_precio = ldw_detalle.getitemnumber(ai_row,'doco_precio_unitario')

For i = 1 to tab_1.tabpage_2.dw_2.rowcount()
	Choose Case i
			Case 1
				ld_porcentaje = tab_1.tabpage_2.dw_2.getitemnumber(i,'cost_porcentaje')
				ld_elmont = ld_precio*ld_porcentaje/100+ld_precio
				ldw_detalle.setitem(ai_row,'elmont',ld_elmont)
			Case 2
				ld_porcentaje = tab_1.tabpage_2.dw_2.getitemnumber(i,'cost_porcentaje')
				ld_flete =  ld_precio*ld_porcentaje/100+ld_precio
				ldw_detalle.setitem(ai_row,'flete',ld_flete)
			Case 3
				ld_porcentaje = tab_1.tabpage_2.dw_2.getitemnumber(i,'cost_porcentaje')
				ld_gastos = ld_flete*(1+.01*ld_porcentaje)
				ldw_detalle.setitem(ai_row,'gastos',ld_gastos)
			Case 4
				ld_porcentaje = tab_1.tabpage_2.dw_2.getitemnumber(i,'cost_porcentaje')
				ld_margen = ld_pventa/ld_gastos
				ldw_detalle.setitem(ai_row,'margen',ld_margen)
			Case 5
				ld_porcentaje = tab_1.tabpage_2.dw_2.getitemnumber(i,'cost_porcentaje')
				ld_direct =  ld_precio*ld_porcentaje/100+ld_precio
				ldw_detalle.setitem(ai_row,'direct',ld_direct)				
			Case 6 
				ld_porcentaje = tab_1.tabpage_2.dw_2.getitemnumber(i,'cost_porcentaje')
				ld_mylin =  ld_gastos*(1+.01*ld_porcentaje)
				ldw_detalle.setitem(ai_row,'mylin',ld_mylin)				
				ldw_detalle.setitem(ai_row,'doco_precio2',ld_mylin)				
			Case 7
				ld_porcentaje = tab_1.tabpage_2.dw_2.getitemnumber(i,'cost_porcentaje')
				ld_pventa =  ld_gastos*(1+.01*ld_porcentaje)
				ldw_detalle.setitem(ai_row,'pventa',ld_pventa)				
				ldw_detalle.setitem(ai_row,'doco_precio1',ld_pventa)								
	End Choose
	
Next
end subroutine

public function string wf_buscar_producto ();String				ls_syntax,ls_syntax_res, ls_codigo_referencia,ls_referencia
str_dg_dynamic_find	lstr_df

// Parámetros para la Búsqueda

lstr_df.texto_campo[1,1] = "prod_producto"
lstr_df.texto_campo[1,2] = "Código de Prod."
lstr_df.texto_campo[1,3] = "prod_producto"
lstr_df.texto_campo[1,4] = "V"
lstr_df.texto_campo[2,1] = "prod_barra"
lstr_df.texto_campo[2,2] = "Codigo de Barra"
lstr_df.texto_campo[2,3] = ""
lstr_df.texto_campo[2,4] = "V"
lstr_df.texto_campo[3,1] = "prod_producto_dos"
lstr_df.texto_campo[3,2] = "Cod. Secundario"
lstr_df.texto_campo[3,3] = ""
lstr_df.texto_campo[3,4] = "V"
lstr_df.texto_campo[4,1] = "prod_descripcion"
lstr_df.texto_campo[4,2] = "Descripcion"
lstr_df.texto_campo[4,3] = "prod_descripcion"
lstr_df.texto_campo[4,4] = "V"
lstr_df.texto_campo[5,1] = "prod_medida"
lstr_df.texto_campo[5,2] = "Medida"
lstr_df.texto_campo[5,3] = "prod_medida"
lstr_df.texto_campo[5,4] = "V"
lstr_df.texto_campo[6,1] = "prod_costo_fob"
lstr_df.texto_campo[6,2] = ""
lstr_df.texto_campo[6,3] = "prod_costo_fob"
lstr_df.texto_campo[6,4] = ""
lstr_df.tabla 		  = "inmprodu"
lstr_df.tabla_where = "WHERE ( inmprodu.prod_g_financiero = "+string(str.g_financiero) +") AND "+& 
" ( inmprodu.prod_empresa = "+ string(str.empresa)+" )";

if ib_band then
	ib_band = false
	if is_key = 'F2' or is_key = 'BC' then
		lstr_df.tabla_where += "and prod_producto like '"+is_produc+"%' "
	elseif is_key = 'F3' then
		lstr_df.tabla_where += "and prod_producto like '%"+is_produc+"' "
	elseif is_key = 'F4' then
		lstr_df.tabla_where += "and prod_producto like '%"+is_produc+"%' "
	end if
end if

OpenWithParm(w_cr_busqueda, lstr_df)

ls_syntax	= Message.StringParm
ls_syntax_res = Right(ls_syntax,Len(ls_syntax) - Pos(ls_syntax,"= '") - 2)
ls_referencia = left(ls_syntax_res,Pos(ls_syntax_res,"'  And") - 1)
ls_syntax_res = Right(ls_syntax_res,Len(ls_syntax_res) - Pos(ls_syntax_res,"= '") - 2)
//is_parte = left(ls_syntax_res,Pos(ls_syntax_res,"'  And") - 1)
//ls_syntax_res = Right(ls_syntax_res,Len(ls_syntax_res) - Pos(ls_syntax_res,"= '") - 2)
//is_color = left(ls_syntax_res,Pos(ls_syntax_res,"'  And") - 1)
//ls_syntax_res = Right(ls_syntax_res,Len(ls_syntax_res) - Pos(ls_syntax_res,"= '") - 2)
is_descripcion = Left(ls_syntax_res,Pos(ls_syntax_res,"'  And") - 1)
ls_syntax_res = Right(ls_syntax_res,Len(ls_syntax_res) - Pos(ls_syntax_res,"= '") - 2)
is_medida = Left(ls_syntax_res,Pos(ls_syntax_res,"'") - 1)
id_costo = dec(Right(ls_syntax_res,Len(ls_syntax_res) - Pos(ls_syntax_res,"= ") - 1))

return ls_referencia

end function

public subroutine wf_busca_prod ();/*Función para hacer la busqueda de los productos*/
string	ls_descripcion_referencia,ls_medida
Integer	li_medida
datawindow ldw_2
ldw_2 =this.tab_1.tabpage_2.dw_detalle
ldw_2.accepttext()

ii_numero_tipo_compra = ldw_2.getitemnumber(ldw_2.getrow(),"doco_tipo_compra")

if ii_numero_tipo_compra = 2 then //Servicio
	
	is_codigo_referencia = wf_buscar_servicio()
	
	SELECT serv_descripcion  
	INTO :ls_descripcion_referencia 
	FROM craservi  
	WHERE serv_codigo = :is_codigo_referencia;
	
	if sqlca.sqlcode = -1 then
		messagebox('Error','Descripción del error: '+sqlca.sqlerrtext)
		return
	end if
	
elseif ii_numero_tipo_compra = 3 then  //Productos
	
	is_codigo_referencia = wf_buscar_producto()
	
	if isNull(is_codigo_referencia) or is_codigo_referencia ='' then return
	
	SELECT prod_descripcion,
			 prod_medida,
			 inamedid.medi_cantidad			 
	INTO :ls_descripcion_referencia,
		  :ls_medida,
		  :li_medida
	FROM inmprodu,
		  inamedid  	
	WHERE (prod_medida = inamedid.medi_medida) AND
			( prod_g_financiero = :str.g_financiero ) AND  
			( prod_empresa = :str.empresa ) AND  
			( prod_producto = :is_codigo_referencia );
	
	if sqlca.sqlcode = -1 then
		messagebox('Error','Descripción del error: '+sqlca.sqlerrtext)
		return
	end if

		if li_medida  = 1 then 
			ldw_2.Object.doco_cant1.Protect='1'
		else 
			ldw_2.Object.doco_cant1.Protect='0'
		end if

end if
is_descripcion = ls_descripcion_referencia
ldw_2.setitem(il_row,'doco_id_referencia',is_codigo_referencia)
ldw_2.setitem(il_row,'doco_descripcion_ref',is_descripcion)
ldw_2.setitem(il_row,'doco_unidad',is_medida)
ldw_2.setitem(il_row,'doco_board',is_parte)
ldw_2.setitem(il_row,'doco_color',is_color)
ldw_2.setitem(il_row,'doco_precio_unitario',id_costo)
ldw_2.setitem(il_row,'inamedid_medi_cantidad',li_medida)

end subroutine

public function boolean wf_enviar_correo ();integer li_envio_correo, li_retorno
string ls_archivo, ls_email, ls_fecha, ls_producto, ls_comprador, ls_transito

ls_transito = tab_1.tabpage_1.dw_generales.getitemstring(1,'crtordco_toco_codigo_oc')

if idw_5.retrieve(str.g_financiero,str.empresa,ls_transito,il_year)  > 0 then
	 SELECT count(*)  
		 INTO :li_envio_correo  
		 FROM crtordco  
		WHERE ( crtordco.toco_g_financiero = :str.g_financiero ) AND  
				( crtordco.toco_empresa = :str.empresa ) AND  
				( crtordco.toco_codigo_oc = :is_numero_oc ) AND  
				( crtordco.toco_anno_oc = :il_year ) AND
				( crtordco.toco_correo_enviado = 1 );
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al buscar envio '+sqlca.sqlerrtext,1,1,'E')
			return false
		end if
		if li_envio_correo > 0 then
			if gf_mensaje('','Desea enviar el correo nuevamente ?',2,1,'E') = 2 then return false
		end if
		
		ls_fecha = string(date(gf_fecha_serv()))		
		ls_archivo = is_ruta+"Pendientes_Transito_"+ls_transito+".xls"		
		uf_save_dw_as_excel(idw_5,ls_archivo)
		ls_producto = idw_5.getitemstring(1,'crdordco_doco_id_referencia')
		
		select prod_comprado_por into :ls_comprador
		from inmprodu
		where prod_g_financiero = :str.g_financiero and prod_empresa = :str.empresa and prod_producto = :ls_producto ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Buscar Comprador '+sqlca.sqlerrtext,1,1,'E')
			return false
		end if
		
		  SELECT ssmusuar.usua_email  
			 INTO :ls_email  
			 FROM ssmusuar  
			WHERE ssmusuar.usua_id = :ls_comprador   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Buscar Correo '+sqlca.sqlerrtext,1,1,'E')
			return false
		end if
		
		if isnull(ls_email) or ls_email = '' then ls_email = 'codbarra@tempozl.com'
		ls_email = 'ruthlucero@tempozl.com'
		if str.empresa =  8 then
//			li_retorno = Run(is_ruta+"alerta_envio_pendientes.bat "+ls_email+" "+ls_archivo+" "+ls_fecha, Minimized!)		
			li_retorno = Run(is_ruta+"envio_correo.exe "+ls_archivo+ ", PendientesBody, "+ls_fecha + " "+ls_transito, Minimized!)		
		else
			li_retorno = Run(is_ruta+"envio_correo.exe "+ls_archivo+ ", Pendientes, "+ls_fecha + " "+ls_transito, Minimized!)		
		end if
		
		update crtordco  
		Set crtordco.toco_correo_enviado = 1 
		WHERE ( crtordco.toco_g_financiero = :str.g_financiero ) AND  
				( crtordco.toco_empresa = :str.empresa ) AND  
				( crtordco.toco_codigo_oc = :is_numero_oc ) AND  
				( crtordco.toco_anno_oc = :il_year );
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al actualizar envio '+sqlca.sqlerrtext,1,1,'E')
			return false
		end if
	
	return true
		
end if


end function

public function boolean wf_enviar_correo_a_muestras ();integer li_envio_correo, li_retorno
string ls_archivo, ls_email, ls_fecha, ls_producto, ls_comprador, ls_transito, ls_factura

ls_transito = tab_1.tabpage_1.dw_generales.getitemstring(1,'crtordco_toco_codigo_oc')
ls_factura  = tab_1.tabpage_1.dw_generales.getitemstring(1,'toco_factura_proveedor')

if idw_7.retrieve(str.g_financiero,str.empresa,ls_transito,il_year)  > 0 then
	 SELECT count(*)  
		 INTO :li_envio_correo  
		 FROM crtordco  
		WHERE ( crtordco.toco_g_financiero = :str.g_financiero ) AND  
				( crtordco.toco_empresa = :str.empresa ) AND  
				( crtordco.toco_codigo_oc = :is_numero_oc ) AND  
				( crtordco.toco_anno_oc = :il_year ) AND
				( crtordco.toco_envio_correo_muestras = 1 );
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al buscar envio '+sqlca.sqlerrtext,1,1,'E')
			return false
		end if
		if li_envio_correo > 0 then
			if gf_mensaje('','Desea enviar el correo nuevamente ?',2,1,'E') = 2 then return false
		end if
		
		ls_fecha = string(date(gf_fecha_serv()))		
		ls_archivo = is_ruta+"Llegando_Transito_"+ls_factura+".xls"		
		uf_save_dw_as_excel(idw_7,ls_archivo)
				
////	ls_email = 'tempofotoa@gmail.com tempoyarab@gmail.com abbygr@tempozl.com ren_medina@hotmail.com'
		if str.empresa = 8 then
//			li_retorno = Run(is_ruta+"alerta_envio_llegando_bg.bat  "+ls_archivo+" "+ls_fecha, Minimized!)		
			li_retorno = Run(is_ruta+"envio_correo.exe "+ls_archivo+ ", LlegandoBody, "+ls_fecha + " "+ls_factura, Minimized!)		
		else
			//li_retorno = Run(is_ruta+"alerta_envio_llegando.bat  "+ls_archivo+" "+ls_fecha, Minimized!)		
			li_retorno = Run(is_ruta+"envio_correo.exe "+ls_archivo+ ", Llegando, "+ls_fecha + " "+ls_factura, Minimized!)		
		end if
		
		update crtordco  
		Set crtordco.toco_envio_correo_muestras = 1 
		WHERE ( crtordco.toco_g_financiero = :str.g_financiero ) AND  
				( crtordco.toco_empresa = :str.empresa ) AND  
				( crtordco.toco_codigo_oc = :ls_transito ) AND  
				( crtordco.toco_anno_oc = :il_year );
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al actualizar envio '+sqlca.sqlerrtext,1,1,'E')
			return false
		end if
	
	return true
		
end if


end function

public function boolean wf_registra_asiento (long al_entrada, string as_detalle);integer li_existe, li_ann
long ll_tercero, ll_referencia_contable
string ls_documento, ls_referencia, ls_descrip, ls_nombre, ls_iden, ls_iden_cc_cp, ls_tran, ls_stran, ls_mg, ls_naturaleza, ls_comentario, ls_detalle, ls_iden_anterior, ls_entrada
decimal{2} ld_monto
datetime ldt_fecha, ldt_fecha_creacion


ldt_fecha	 = tab_1.tabpage_1.dw_generales.getitemdatetime(1,'toco_fecha_entrada')
li_ann = year(date(ldt_fecha))
ldt_fecha_creacion = gf_fecha_serv()
ls_detalle     = as_detalle
if isnull(ls_detalle) then ls_detalle = ''
ld_monto  =   tab_1.tabpage_2.dw_detalle.getitemnumber(1,'t_final')
ll_tercero  = tab_1.tabpage_1.dw_generales.getitemnumber(1,'toco_num_prove')
ls_descrip = 'COMPRA DE MERCANCIA - '+ls_detalle
ls_documento = tab_1.tabpage_1.dw_generales.getitemstring(1,'crtordco_toco_codigo_oc')
ll_referencia_contable = tab_1.tabpage_1.dw_generales.getitemnumber(1,'toco_referencia_contable')
ls_entrada = string(al_entrada)
  SELECT dgmterce.terc_descripcion  
    INTO :ls_nombre  
    FROM dgmterce  
   WHERE dgmterce.terc_tercero = :ll_tercero   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Buscar Nombre '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return false
		end if


  SELECT count(*)  
    INTO :li_existe  
    FROM cotdiari  
   WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
         ( cotdiari.diar_empresa = :str.empresa ) AND  
         ( cotdiari.diar_aplicacion_mg = 'IN' ) AND  
         ( cotdiari.diar_tipo_transaccion = 'EN' ) AND  
         ( cotdiari.diar_sub_trans = 'CR' ) AND  
         ( cotdiari.diar_identificacion = '1' ) AND  
         ( cotdiari.diar_no_referencia = :ll_referencia_contable ) AND  
         ( cotdiari.diar_ann = :li_ann )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Validar Existencia '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return false
		end if

	if li_existe = 0 then
		
		  INSERT INTO cotdiari  
         ( diar_g_financiero,   
           diar_empresa,   
           diar_aplicacion_mg,   
           diar_tipo_transaccion,   
           diar_sub_trans,   
           diar_no_documento,   
           diar_no_referencia,   
           diar_ann,   
           diar_fecha_transaccion,   
           diar_descripcion,   
           diar_id,   
           diar_fecha_creacion,   
           diar_estado,   
           diar_monto,   
           diar_balance,   
           diar_modificado,   
           diar_cerrado,   
           diar_cierre_mensual,   
           diar_banco,   
           diar_documento_a,   
           diar_nombre )  
  VALUES ( :str.g_financiero,   
           :str.empresa,   
           'IN',   
           'EN',   
           'CR',   
           :ls_documento,   
           :ll_referencia_contable,   
           :li_ann,   
           :ldt_fecha,   
           :ls_descrip,   
           :str.usuario,   
           :ldt_fecha_creacion,   
           'IM',   
           :ld_monto,   
           1,   
           0,   
           'N',   
           'N',   
           null,   
           :ls_entrada,   
           :ls_nombre )  ;
			  if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Insertar encabezado '+sqlca.sqlerrtext,1,1,'E')
					rollback;
					return false
			  end if
		
	else  // si ya existe se hace update
		
		  UPDATE cotdiari  
		  SET diar_fecha_transaccion = :ldt_fecha,   
				diar_descripcion = :ls_descrip,   
				diar_id = :str.usuario,   
				diar_monto = :ld_monto,   
				diar_nombre = :ls_nombre ,
				diar_ann = :li_ann
		WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
				( cotdiari.diar_empresa = :str.empresa ) AND  
				( cotdiari.diar_aplicacion_mg = 'IN' ) AND  
				( cotdiari.diar_tipo_transaccion = 'EN' ) AND  
				( cotdiari.diar_sub_trans = 'CR' ) AND  
				( cotdiari.diar_no_documento = :ls_documento ) AND  
				( cotdiari.diar_no_referencia = :ll_referencia_contable ) AND  
				( cotdiari.diar_ann = :ii_an ) ;
			  if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
					rollback;
					return false
			  end if
		
	end if
	
	tab_1.tabpage_1.dw_generales.setitem(1,'toco_referencia_contable',ll_referencia_contable)
	
	if tab_1.tabpage_1.dw_generales.update() = -1 then
		gf_mensaje('','Error al Actualizar referencia contable '+sqlca.sqlerrtext,1,1,'E')
		return false
	end if

return true



//
//	
//  DELETE FROM coddiari  
//   WHERE ( coddiari.ddia_g_financiero = :str.g_financiero ) AND  
//         ( coddiari.ddia_empresa = :str.empresa ) AND  
//         ( coddiari.ddia_aplicacion_mg = 'IN' ) AND  
//         ( coddiari.ddia_tipo_transaccion = 'EN' ) AND  
//         ( coddiari.ddia_sub_trans = 'CR' ) AND  
//         ( coddiari.ddia_no_referencia = :al_entrada ) AND  
//         ( coddiari.ddia_ann = :ii_an ) ;
//		if sqlca.sqlcode = -1 then
//			gf_mensaje('','Error al Eliminar Encabezado del Asiento '+sqlca.sqlerrtext,1,1,'E')
//			rollback;
//			return false
//		end if
//
//
//  DELETE FROM cotdiari  
//   WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
//         ( cotdiari.diar_empresa = :str.empresa ) AND  
//         ( cotdiari.diar_aplicacion_mg = 'IN' ) AND  
//         ( cotdiari.diar_tipo_transaccion = 'EN' ) AND  
//         ( cotdiari.diar_sub_trans = 'CR') AND  
////         ( cotdiari.diar_no_documento = :is_doc_anterior ) AND  
//         ( cotdiari.diar_no_referencia = :al_entrada ) AND  
//         ( cotdiari.diar_ann = :ii_an ) ;
//		if sqlca.sqlcode = -1 then
//			gf_mensaje('','Error al Eliminar Encabezado del Asiento '+sqlca.sqlerrtext,1,1,'E')
//			rollback;
//			return false
//		end if
//
end function

on w_cz_ma_transito.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.tab_1=create tab_1
this.st_microhelp=create st_microhelp
this.pb_1=create pb_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_1=create st_1
this.st_3=create st_3
this.st_5=create st_5
this.cb_continuar=create cb_continuar
this.cb_cancelar=create cb_cancelar
this.dw_6=create dw_6
this.cb_4=create cb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.st_microhelp
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.cb_continuar
this.Control[iCurrent+10]=this.cb_cancelar
this.Control[iCurrent+11]=this.dw_6
this.Control[iCurrent+12]=this.cb_4
end on

on w_cz_ma_transito.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.st_microhelp)
destroy(this.pb_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_5)
destroy(this.cb_continuar)
destroy(this.cb_cancelar)
destroy(this.dw_6)
destroy(this.cb_4)
end on

event open;// Override
/****************************************************************************************** 
 *												Presentación de la Ventana										*
 ******************************************************************************************/
int		ll_are[] = {1}

gf_center_win(This)
gf_acelerador()
This.title = 'Captura de Factura del Proveedor - Transito'
THIS.Icon = str.icono
THIS.SetToolbar(1, true, alignattop!)
THIS.SetToolbarPos(1, 1, 50, false)
this.y = this.y - 150

//str_formato = Message.PowerObjectParm
//tab_1.tabpage_1.dw_generales.DataObject = trim(str_formato.datawindow_detalle)
//tab_1.tabpage_1.dw_generales.SettransObject(sqlca)
//tab_1.tabpage_2.dw_detalle.DataObject = trim(str_formato.datawindow)
//tab_1.tabpage_2.dw_detalle.SettransObject(sqlca)
//is_descripcion_oc = gf_cr_descripcion_oc('TR') /* Establece el titulo de la ventana de Ord. 
	//														 Compra/Pedido/Requisicion */
															 
//Encabezado
if isnull(trim(str_formato.datawindow)) or trim(str_formato.datawindow) = '' then 
	tab_1.tabpage_1.dw_generales.DataObject = "dw_ma_cz_pedidos_grals"
	tab_1.tabpage_1.dw_generales.SettransObject(sqlca)
else
	tab_1.tabpage_1.dw_generales.DataObject = trim(str_formato.datawindow)
	tab_1.tabpage_1.dw_generales.SettransObject(sqlca)
end if

//Detalle
if isnull(trim(str_formato.datawindow_detalle)) or trim(str_formato.datawindow_detalle) = '' then 
	tab_1.tabpage_2.dw_detalle.DataObject = "dw_ma_cz_pedidos_detalle"
	tab_1.tabpage_2.dw_detalle.SettransObject(sqlca)
else
	tab_1.tabpage_2.dw_detalle.DataObject = trim(str_formato.datawindow_detalle)
	tab_1.tabpage_2.dw_detalle.SettransObject(sqlca)
end if

//Listado
if isnull(trim(str_formato.datawindow_listado)) or trim(str_formato.datawindow_listado) = '' then 
	tab_1.tabpage_4.dw_listado.DataObject = "dw_re_cz_tran_sin_detalle"
	tab_1.tabpage_4.dw_listado.SettransObject(sqlca)
else
	tab_1.tabpage_4.dw_listado.DataObject = trim(str_formato.datawindow_listado)
	tab_1.tabpage_4.dw_listado.SettransObject(sqlca)
end if															 
												 
//this.title = is_descripcion_oc
//il_year = year(date(gf_fecha_serv()))
/*Para que tome el año de parametro de inventario HGN/03/02/03*/
//il_year  = w_cr_fondo.ii_anio_proceso

//m_cr_padre.archivo.m_imprimir.enabled = true
//m_cr_padre.archivo.m_imprimir.visible = true
//m_cr_padre.archivo.m_imprimir.toolbaritemvisible=true

tab_1.tabpage_1.dw_generales.getchild('toco_cod_tipo_pago',idwchild2)
idwchild2.SetTransObject(sqlca)
if idwchild2.Retrieve(str.g_financiero,str.empresa) = 0 then
	idwchild2.InsertRow(0)
end if

tab_1.tabpage_2.dw_detalle.getchild('doco_tipo_oc',idwchild3)
idwchild3.SetTransObject(sqlca)
if idwchild3.Retrieve(ll_are) = 0 then
	idwchild3.InsertRow(0)
end if
this.postevent("ue_post_open")

end event

event ue_post_open;datawindowchild ldwc_planc
string	ls_mascara,ls_auto, ls_masca
integer	li_secuencia
long	   ll_row
is_nombre = This.ClassName()
dw.settransobject(sqlca)
st_nom_ventana.text = is_nombre
tab_1.tabpage_1.dw_8.settransobject(sqlca)

tab_1.selectedtab = 1
tab_1.tabpage_1.dw_generales.SetTransObject(sqlca)
tab_1.tabpage_2.dw_detalle.SetTransObject(sqlca)
tab_1.tabpage_4.dw_listado.SetTransObject(sqlca)
tab_1.tabpage_2.dw_2.SetTransObject(sqlca)

idw_4 = tab_1.tabpage_1.dw_4
idw_4.settransobject(sqlca)
idw_4.visible = false
idw_4.insertrow(1)
idw_5 = tab_1.tabpage_1.dw_5
idw_5.SetTransObject(sqlca)
dw_6.settransobject(sqlca)
dw_6.visible = false
idw_7 = tab_1.tabpage_1.dw_7
idw_7.SetTransObject(sqlca)
idw_9 = tab_1.tabpage_5.dw_9
idw_9.SetTransObject(sqlca)

idw_9.getchild('ddia_mg_cuenta',idwc_plan)
idwc_plan.settransobject(sqlca)
idwc_plan.retrieve(str.g_financiero, str.empresa)

ls_masca = gf_mascara()
idw_9.MODIFY("cuenta.editmask.mask='"+ls_masca+"'") //mascara para el compute de la cuenta
idwc_plan.MODIFY("mg_cuenta.editmask.mask='"+ls_masca+"'") //cuenta que se graba en el detalle contable


	  SELECT inaparam.para_ruta_ordenes_pendientes		//C:\Harr2000\Ordenes_pendientes\ 
			 INTO :is_ruta  
			 FROM inaparam  
			WHERE ( inaparam.para_g_financiero = :str.g_financiero ) AND  
					( inaparam.para_empresa = :str.empresa )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al buscar Ruta '+sqlca.sqlerrtext,1,1,'E')
		end if
			
dw = tab_1.tabpage_2.dw_detalle
dw.Getchild ('doco_c_costo',idwchild)
idwchild.settransobject(sqlca)

if idwchild.Retrieve(str.g_financiero,str.empresa) = 0 then
	idwchild.insertrow(1)
end if

is_tipo = gf_tipo_inventario()

if mid(is_tipo,1,5) = 'Error' then
	mensaje('Error','No se recuperó el Tipo de Inventario.','Descripción del '+is_tipo)
	close(this)
	return
end if

if isnull(is_tipo) or trim(is_tipo) = '' then
	messagebox('Atención','No se ha definido el tipo de Inventario. Usted no podrá continuar.',StopSign!)
	close(this)
	return
end if

//// Para asignarle la cantidad de decimales que se utilizarán - 19/02/2001.
//ls_mascara = gf_cr_mascara_dec()
//tab_1.tabpage_2.dw_detalle.modify("doco_precio_unitario.editmask.mask='"+ls_mascara+"'")
//tab_1.tabpage_2.dw_detalle.object.formato.expression = "'"+ls_mascara+"'"

this.triggerevent("ue_hay_data")
this.visible = true

//Para validar la unidad en que se va a registrar la compra
Select mpar_unidad_compra
Into   :is_unidad_fija
From	 crmparam
Where	mpar_g_financiero = :str.g_financiero and
		mpar_empresa = :str.empresa;

if sqlca.sqlcode = -1 then
	mensaje("Aviso","Error al Seleccionar el Parametro de Compras(Unidad Fija) ",sqlca.sqlerrtext)
end if

	/*ADD BY HGN/30/09/2002 si viene de ventana procesos uno a uno */
	if str_formato.viene_de ='unif'  then 
		//if w_cr_compras_unif.is_desact_ono_a_uno = '0' then //Proceso uno a uno activado
		If 0 = 2 then
			cb_continuar.enabled = true
			cb_continuar.visible = true
			cb_cancelar.enabled = true
			cb_cancelar.visible = true
//			this.controlmenu = false
//			If This.MenuName = "m_cr_principal" Then m_cr_principal.archivo.m_cerrar1.toolbaritemvisible = False
	
			select count(*) 
			into :ll_row
			from crtordco
			WHERE ( crtordco.toco_g_financiero = :str.g_financiero)  AND  
					( crtordco.toco_empresa = :str.empresa) AND 
					( crtordco.toco_num_suplemento = '         ' ) and 
					( crtordco.toco_pedido =:str_formato.num_oc_tran) ;
				
					if sqlca.sqlcode = -1 then
						mensaje("Aviso","Error validar existencia de Tránsito para esta Orden de Compra ",sqlca.sqlerrtext)
					end if
		 
			If ll_row > 0 then
				this.postevent("ue_buscar")
			end if
		else
			cb_continuar.enabled = false
			cb_continuar.visible = false
			cb_cancelar.enabled = false
			cb_cancelar.visible = false
		end if

	else
		cb_continuar.enabled = false
		cb_continuar.visible = false
		cb_cancelar.enabled = false
		cb_cancelar.visible = false
	end if


end event

event ue_buscar;//Override

If ii_tabpage =1 then 

	/******************************************************************************************
	 *									Búsqueda Dinámica de Orden de Compra									*
	 ******************************************************************************************/
	String	ls_syntax,ls_syntres, ls_error,ls_pase
	str_dg_dynamic_find	lstr_df
	
	// Parámetros para la Búsqueda
	lstr_df.texto_campo [1,1] = "crtordco.toco_factura_proveedor"
	lstr_df.texto_campo [1,2] = "No. Factura"
	lstr_df.texto_campo [1,3] = ""
	lstr_df.texto_campo [1,4] = "V"
	lstr_df.texto_campo [1,5] = "800"
	
	lstr_df.texto_campo [2,1] = "crtordco.toco_codigo_oc"
	lstr_df.texto_campo [2,2] = "No.Orden "
	lstr_df.texto_campo [2,3] = "ttoco_codigo_oc"
	lstr_df.texto_campo [2,4] = "V"
		
	lstr_df.texto_campo [3,1] = "dgmterce.terc_descripcion"
	lstr_df.texto_campo [3,2] = "Proveedor"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = "V"
	
	lstr_df.texto_campo [4,1] = "crtordco.toco_tipo_oc"
	lstr_df.texto_campo [4,2] = "Tipo"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = "V"
	
	lstr_df.texto_campo [5,1] = "crtordco.toco_fecha_oc"
	lstr_df.texto_campo [5,2] = "Fecha"
	lstr_df.texto_campo [5,3] = ""
	lstr_df.texto_campo [5,4] = "V"
	
	lstr_df.texto_campo [6,1] = "crtordco.toco_vapor"
	lstr_df.texto_campo [6,2] = "Barco"
	lstr_df.texto_campo [6,3] = ""
	lstr_df.texto_campo [6,4] = "V"
	lstr_df.texto_campo [6,5] = "800"
	
	lstr_df.texto_campo [7,1] = "crtordco.toco_num_suplemento"
	lstr_df.texto_campo [7,2] = "No.Suplemento"
	lstr_df.texto_campo [7,3] = "toco_num_suplemento"
	lstr_df.texto_campo [7,4] = "I"

	lstr_df.texto_campo [8,1] = "toco_anno_oc"
	lstr_df.texto_campo [8,2] = "Año"
	lstr_df.texto_campo [8,3] = "toco_anno_oc"
	lstr_df.texto_campo [8,4] = "V"

	lstr_df.texto_campo [9,1] = "toco_entrada_inv"
	lstr_df.texto_campo [9,2] = "Secuencia Ent."
	lstr_df.texto_campo [9,3] = ""
	lstr_df.texto_campo [9,4] = "V"
	
	lstr_df.tabla 		  = "crtordco, dgmterce"
	lstr_df.tabla_where = "WHERE ( crtordco.toco_g_financiero = "+string(str.g_financiero) +") AND "+& 
	" ( crtordco.toco_empresa = "+ string(str.empresa)+" ) AND "+&
	" ( crtordco.toco_num_prove = dgmterce.terc_tercero ) AND "+&
	" ( crtordco.toco_num_suplemento = '         ' )"
	
	if str_formato.viene_de   ='unif' then 
//		if w_cr_compras_unif.is_desact_ono_a_uno = '0' then //Proceso uno a uno activado
//			lstr_df.tabla_where += " and ( crtordco.toco_pedido ="+"'"+str_formato.num_oc_tran+"'"+") "
//			cb_continuar.visible = true
//			cb_cancelar.visible = true
//		end if
	end if
	
	
	OpenWithParm(w_cr_busqueda, lstr_df)
	ls_syntax	= Message.StringParm
	
	ls_syntres = Right ( ls_syntax, Len (ls_syntax) - Pos (ls_syntax, "= '") - 2)
	is_numero_oc = left ( ls_syntres, Pos (ls_syntres, "'  And") - 1)
	
	ls_syntres = Right ( ls_syntres, Len (ls_syntres) - Pos (ls_syntres, "= '") - 2)
	is_numero_sup = Left ( ls_syntres,Pos(ls_syntres,"'  And") - 1)
	
	il_year = integer(Right ( ls_syntres, Len (ls_syntres) - Pos (ls_syntres, "= ") - 1))
	
	IF NOT IsNull(is_numero_oc) AND (is_numero_oc <> '') Then
		if tab_1.tabpage_1.dw_generales.retrieve(str.g_financiero,str.empresa,is_numero_oc,il_year,is_numero_sup) > 0 then
			if tab_1.tabpage_2.dw_detalle.retrieve(str.g_financiero,str.empresa,is_numero_oc,il_year) > 0 then
				ib_graba_modificado_por = true
			end if
		end if
	END IF
Elseif  ii_tabpage =2 then	/*Búsqueda de productos*/
	if il_row <= 0 then 
		messagebox('Atención ','Dé un click en la columna del producto del registro deseado')
		return
	end if
	
	wf_busca_prod()
END if

end event

event ue_adicionar;Integer li_row, li_max_linea,li_largo_codigo_oc,li_existe,li_secuencia
Long ll_secuencia_oc,ll_secuencia_tran
String ls_sec_oc,ls_tipo_oc,ls_descripcion,ls_secuencia,ls_auto


CHOOSE CASE tab_1.selectedtab
CASE 1
	ib_graba_modificado_por = false
	
		SELECT isnull(mpar_largo_codigo_oc,0),
				 isnull(mpar_secuencia_oc,0),
				 isnull(mpar_secuencia_transito,0)
		INTO   :li_largo_codigo_oc,
				 :ll_secuencia_oc,
				 :ll_secuencia_tran
		FROM   crmparam
		WHERE  ( crmparam.mpar_g_financiero = :str.g_financiero ) AND
				 ( crmparam.mpar_empresa = :str.empresa );
		
			if sqlca.sqlcode = -1 then
				messagebox('Error','Descripción del error: '+sqlca.sqlerrtext,StopSign!)
				close(this)
				return
			elseif sqlca.sqlcode = 100 then
				messagebox('Atención','No se obtuvo el número de secuencia.',StopSign!)
				close(this)
				return
			end if
		
			dw = tab_1.tabpage_1.dw_generales
			dw.Reset()
			tab_1.tabpage_2.dw_detalle.Reset()
			dw_1.Reset()
		
CASE 2
			ib_graba_modificado_por = true
	
			dw = tab_1.tabpage_2.dw_detalle
		
			if dw.rowcount() > 0 then 
				li_max_linea = dw.getitemnumber(dw.rowcount(),"doco_num_renglon_oc")			
			else 
				li_max_linea = 0
			end if
			
			if isnull(li_max_linea) or li_max_linea = 0 then
				li_max_linea = 1
			else
				li_max_linea += 1
			end if
		
END CHOOSE

li_row = dw.insertrow(0)
dw.scrolltorow(li_row)

CHOOSE CASE tab_1.selectedtab
CASE 1
	if pos(str.nombre_empresa, 'ELBROS') > 0  then
		SELECT isnull(mser_secuencia,0),
				 mser_sec_auto
		INTO   :li_secuencia,
				 :ls_auto
		FROM   dgmserie
		WHERE  (mser_g_financiero =:str.g_financiero) and
				 (mser_empresa =:str.empresa) and
				 (mser_tipo_transaccion = 'EN');
					 
				li_secuencia = li_secuencia + 1
				
		if tab_1.tabpage_1.dw_generales.describe('toco_entrada_inv.x') <> "?" and &
			tab_1.tabpage_1.dw_generales.describe('toco_entrada_inv.x') <> "!" then
			tab_1.tabpage_1.dw_generales.setitem(1,'toco_entrada_inv',li_secuencia)
		end if
	end if

		if isnull(ll_secuencia_tran) or ll_secuencia_tran = 0 then
			ll_secuencia_tran = 1
		else
			ll_secuencia_tran += 1
		end if

//Para verificar si la secuencia existe en crtconfi
			ls_secuencia =  string('TR'+ fill('0',li_largo_codigo_oc - len(string(ll_secuencia_tran)))+string(ll_secuencia_tran))
  			DO 
					SELECT count(*)
					INTO   :li_existe
					FROM   crtordco
					WHERE ( toco_g_financiero = :str.g_financiero ) AND
							( toco_empresa = :str.empresa ) and
							( toco_codigo_oc = :ls_secuencia);
				if sqlca.sqlcode = -1 then
					rollback;
					messagebox('Error','Descripción del error: '+sqlca.sqlerrtext)
					close(this)
					return
				elseif sqlca.sqlcode = 100 then
					messagebox('Atención','No se recuperó la secuencia. Verifique Usted no puede continuar.',StopSign!)
					close(this)
					return
				end if
									
				if li_existe > 0 then
					ll_secuencia_tran ++
					ls_secuencia =  string('TR'+ fill('0',li_largo_codigo_oc - len(string(ll_secuencia_tran)))+string(ll_secuencia_tran))
				end if
									
			LOOP UNTIL li_existe = 0

		//Si el año es nulo o 0, que le ponga el año actual
		if il_year = 0 or isnull(il_year) then il_year = year(date(gf_fecha_serv()))
		il_numero_oc = ll_secuencia_tran
		dw.setitem(li_row,'toco_g_financiero',str.g_financiero)
		dw.setitem(li_row,'toco_empresa',str.empresa)
		dw.setitem(li_row,'crtordco_toco_codigo_oc',ls_secuencia)
		dw.setitem(li_row,'toco_fecha_oc',gf_fecha_serv())
		dw.setitem(li_row,'toco_fecha_entrada',datetime(date(gf_fecha_serv()),time('00:00:00')))
		dw.setitem(li_row,'toco_fecha_entrega',gf_fecha_serv())
		dw.setitem(li_row,'toco_fecha_modificacion',gf_fecha_serv())		
		dw.setitem(li_row,'toco_anno_oc',il_year)
		is_numero_oc = ls_secuencia		
		is_sec_oc = is_numero_oc
      lstr_pase.orden = is_numero_oc
	CASE 2
		dw.setitem(li_row,'doco_g_financiero',str.g_financiero)
		dw.setitem(li_row,'doco_empresa',str.empresa)
		dw.setitem(li_row,'doco_codigo_oc',is_numero_oc)
		dw.setitem(li_row,'doco_anno_oc',il_year)
		dw.setitem(li_row,'doco_num_renglon_oc',li_max_linea)
		dw.SetColumn('doco_id_referencia')
END CHOOSE



end event

event ue_aceptar;// Override

Long		ll_update
Integer	li_row, li_sig , li_secuencia,li_existe, i
Double	ld_total,ld_monto_actual,ld_cantidad,ld_anterior
String	ls_num_carta,ls_producto,ls_color,ls_board, ls_errtext,ls_nulo, ls_factura_proveedor, ls_transito
datetime ldt_fecha
setnull(ls_nulo)

tab_1.tabpage_1.dw_generales.accepttext() 
tab_1.tabpage_2.dw_detalle.accepttext() 

if not isnull(tab_1.tabpage_1.dw_generales.getitemstring(1,'crtordco_toco_tipo_compra')) then
	if isnull(tab_1.tabpage_1.dw_generales.getitemnumber(1,'toco_num_prove')) then
		messagebox("Atención","Seleccione el Proveedor con el cual desea realizar la Compra.",Exclamation!)
		return
	end if
end if

// Para validar que la secuencia no se le haya asignado a otro documento
if tab_1.tabpage_1.dw_generales.describe('crtordco_toco_entrada_inv.x') <> "?" and &
	tab_1.tabpage_1.dw_generales.describe('crtordco_toco_entrada_inv.x') <> "!" then
	li_secuencia = tab_1.tabpage_1.dw_generales.getitemnumber(1,'crtordco_toco_entrada_inv')
end if

if pos(str.nombre_empresa, 'ELBROS') > 0 then
	
	if isNull(li_secuencia) or li_secuencia = 0 then
		messagebox("Atención","Digite el Número de Entrada a Inventario ...",Exclamation!)
		return
	end if
	
	SELECT count(*) 
	Into	:li_existe
	FROM   crtordco  
	WHERE ( crtordco.toco_g_financiero = :str.g_financiero ) AND  
			( crtordco.toco_empresa = :str.empresa  ) AND  
			( crtordco.toco_entrada_inv =:li_secuencia )   ;
	
	if li_existe > 1 then
		messagebox("Atención","Este número de entrada ya fué asignado para otro documento",Exclamation!)
		return			
	end if
end if

dw = tab_1.tabpage_2.dw_detalle

if dw.rowcount() > 0 then ld_total = dw.getitemnumber(dw.getrow(),'t_final')	
ls_num_carta = tab_1.tabpage_1.dw_generales.getitemstring(1,"toco_num_carta_credito")
tab_1.tabpage_1.dw_generales.setitem(1,'toco_monto_total_orden',ld_total)

if ib_graba_modificado_por then
	tab_1.tabpage_1.dw_generales.setitem(1,'toco_usuario',str.usuario)
	tab_1.tabpage_1.dw_generales.setitem(1,'toco_fecha_modificacion',gf_fecha_serv())
end if

fOR li_sig =1 to dw.rowcount()
	if len(trim(dw.getitemstring(li_sig,"doco_id_referencia"))) = 0 or isnull(dw.getitemstring(li_sig,"doco_id_referencia")) then
		dw.deleterow(li_sig)
		li_sig  --
	end if
Next

if isnull(tab_1.tabpage_1.dw_generales.getitemString(1,'toco_factura_proveedor')) or tab_1.tabpage_1.dw_generales.getitemString(1,'toco_factura_proveedor') = '' then
	messagebox("Atención","Debe Asignal el Numero de la Factura del Proveedor, Verifique !!!",Exclamation!)
	tab_1.tabpage_1.dw_generales.setcolumn('toco_factura_proveedor')
	return
end if

if tab_1.tabpage_1.dw_generales.update() = 1  then
	if tab_1.tabpage_2.dw_detalle.update() = 1  then
		if li_secuencia > 0 then
			
			Update dgmserie
			Set    mser_secuencia = :li_secuencia
			WHERE  (mser_g_financiero =:str.g_financiero) and
					 (mser_empresa =:str.empresa) and
					 (mser_tipo_transaccion = 'EN')  and
					 (mser_secuencia + 1 = :li_secuencia);
				if sqlca.sqlcode = -1 then
					ls_errtext = Sqlca.Sqlerrtext			
					rollback;
					messagebox("Error",'Descripción: '+ls_errtext)
					return
				elseif sqlca.sqlcode = 100 then
					rollback;
					messagebox('Atención',"No se actualizó la secuencia en inventario",Exclamation!)
					return
				end if
		end if
		Commit;
		messagebox('Información','Actualización Exitosa!',Information!)
		cb_4.triggerevent('clicked')
	end if
else
	rollback;
	messagebox("Atención - Error ","¡Error Cuando de Estan Grabando los Registros!",Exclamation!)
	Return
end if

If is_numero_oc = is_sec_oc  then
	UPDATE crmparam
	SET mpar_secuencia_transito = :il_numero_oc
	WHERE ( crmparam.mpar_g_financiero = :str.g_financiero ) AND
			( crmparam.mpar_empresa = :str.empresa );
	
	if sqlca.sqlcode = -1 then
		ls_errtext = sqlca.sqlerrtext
		rollback;
		messagebox('Error','Descripción del error: '+ls_errtext)
		return
	elseif sqlca.sqlcode = 100 then
		rollback;
		messagebox('Atención','No se actualizó la secuencia en transito',Exclamation!)
		return
	end if
end if

wf_enviar_correo()

wf_enviar_correo_a_muestras()

ldt_fecha = tab_1.tabpage_1.dw_generales.getitemdatetime(1,'toco_fecha_oc')
ls_transito = tab_1.tabpage_1.dw_generales.getitemstring(1,'crtordco_toco_codigo_oc')
ls_factura_proveedor = tab_1.tabpage_1.dw_generales.getitemstring(1,'toco_factura_proveedor')

li_row = tab_1.tabpage_2.dw_detalle.rowcount()
for i = 1 to li_row
	str.frame.setmicrohelp('Procesando '+string(i)+' de '+string(li_row))
	ls_producto = tab_1.tabpage_2.dw_detalle.getitemstring(i,'doco_id_referencia')
	
	  UPDATE inmprodu  
		  SET prod_ultima_entrada_doc = :ls_transito,   
				prod_factura_proveedor = :ls_factura_proveedor  
		WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
				( inmprodu.prod_empresa = :str.empresa ) AND  
				( inmprodu.prod_producto = :ls_producto ) AND  
				(( inmprodu.prod_entrada_fecha < :ldt_fecha ) or (inmprodu.prod_entrada_fecha = null) )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Actualizar Transito '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				return
			end if
	
next
str.frame.setmicrohelp('Listo')
commit;

end event

event ue_hay_data;/* OverRide ( Evita la seleccion azul del primer registro )  */
if dw.rowcount() = 0 then
	this.triggerevent("ue_adicionar")
end if

end event

event ue_imprimir;integer Net

Net = MessageBox("Result", "Desea Imprimir",  &
		Exclamation!, OKCancel!, 2)
IF Net = 1 THEN 
  // Process OK.
   SetPointer(Hourglass!)
	tab_1.tabpage_2.dw_detalle.print(true)
ELSE
 // Process CANCEL.
END IF
end event

event ue_print;if dw_6.visible then
	OpenWithParm(w_dw_print_options, dw_6)
	If Message.DoubleParm = -1 Then Return
	dw_6.Print(True)
else
	OpenWithParm(w_dw_print_options, dw)
	If Message.DoubleParm = -1 Then Return
	dw.Print(True)
end if
end event

event key;// Para que ejecute el evento clicked del picturebutton cuando se presiona enter y el foco
// está sobre dicho botón.

if key = keyenter! then
	if getfocus().typeof() = picturebutton! then getfocus().triggerevent(clicked!)
end if

end event

event activate;call super::activate;//this.changemenu(m_hs)

end event

event close;if isvalid(this) then close(this)
end event

event ue_eliminar;//OverRide
//Creado para actualizar las cantidades del tránsito en la confirmación

string 	ls_orden,ls_errtext, ls_producto, ls_unidad,ls_error
integer	li_linea,li_anio, newindex
long		ll_cantidad, ll_cant1,   ll_cant_min


CHOOSE CASE tab_1.selectedtab
// Para eliminar el encabezado y detalle de la mercancía en tránsito		
	Case 1
		if tab_1.tabpage_1.dw_generales.getitemstring(1,'toco_pase_factura') = 'S' then
			messagebox('Atención','Esta transacción no se puede eliminar ya se pasó a Factura')
			return
		end if
		
		if messagebox('Atención','¿Está usted seguro de borrar esta transacción?',Question!,YesNo!,2) = 1 then
			DELETE FROM crdordco  
			WHERE ( crdordco.doco_g_financiero = :str.g_financiero ) AND  
				   ( crdordco.doco_empresa = :str.empresa ) AND  
 					( crdordco.doco_codigo_oc = :is_numero_oc) AND  
					( crdordco.doco_anno_oc = :il_year ) AND  
					( crdordco.doco_num_suplemento = :is_numero_sup ) ;
				
			DELETE FROM crtordco  
			WHERE ( crtordco.toco_g_financiero = :str.g_financiero ) AND  
				   ( crtordco.toco_empresa = :str.empresa ) AND  
 					( crtordco.toco_codigo_oc = :is_numero_oc ) AND  
					( crtordco.toco_anno_oc = :il_year ) AND  
					( crtordco.toco_num_suplemento = :is_numero_sup ) ;
							
			if tab_1.tabpage_2.dw_detalle.update() = 1 then
				if tab_1.tabpage_1.dw_generales.update() = 1 then
					tab_1.tabpage_1.dw_generales.retrieve(str.g_financiero,str.empresa,is_numero_oc,il_year,is_numero_sup)
					tab_1.tabpage_2.dw_detalle.retrieve(str.g_financiero,str.empresa,is_numero_oc,il_year)					
					this.triggerevent('ue_adicionar')
					messagebox('Atención','Transacción Eliminada con Éxito')
				else
					rollback;
					messagebox('Error','No se pudo eliminar la transacción')
				end if
			else
				rollback;
				messagebox('Error','No se pudo eliminar la transacción')
			end if
		end if

Case 2	
	/*MODIFICADO POR HGN/28/01/03 PERMITIA BORRAR DETALLE DE UN TRANSITO FACTURADO*/
	if tab_1.tabpage_1.dw_generales.getitemstring(1,'toco_pase_factura') = 'S' then
		messagebox('Atención','Esta transacción no se puede eliminar ya se pasó a Factura')
		return
	end if
	dw = tab_1.tabpage_2.dw_detalle
	if dw.getrow() = 0 then return
		ls_orden		= dw.getitemstring(dw.getrow(),"doco_pedido_conf")
		li_linea		= dw.getitemnumber(dw.getrow(),"doco_linea_conf")
		li_linea		= dw.getitemnumber(dw.getrow(),"doco_linea_conf")
		li_anio 		= dw.getitemnumber(dw.getrow(),"doco_anno_oc")
		ll_cantidad = dw.getitemnumber(dw.getrow(),"doco_cantidad_total")
		ll_cant1 	= dw.getitemnumber(dw.getrow(),"doco_cant1")
		ls_producto = dw.getitemstring(dw.getrow(),"doco_id_referencia")
		ls_unidad	= dw.getitemstring(dw.getrow(),"doco_unidad")
		dw.deleterow(dw.getrow())
	
	if dw.update() = 1 then	
	//Para actualizar las cantidades en la orden de compra	
		 UPDATE 	crdconfi  
		 SET 		dcof_cant_facturada 	= dcof_cant_facturada - :ll_cantidad,
					dcof_cant1_facturada = dcof_cant1_facturada - :ll_cant1,
					dcof_cant_pendiente	= dcof_cant_pendiente + :ll_cantidad,
					dcof_cant1_pendiente = dcof_cant1_pendiente + :ll_cant1
		 WHERE   ( crdconfi.dcof_g_financiero	= :str.g_financiero ) AND  
					( crdconfi.dcof_empresa			= :str.empresa ) AND  
					( crdconfi.dcof_num_conf_oc	= :ls_orden ) AND  
					( crdconfi.dcof_num_ren_confi	= :li_linea ) AND
					( crdconfi.dcof_anno_oc			= :li_anio) ;
	
			if sqlca.sqlcode = -1 then
				ls_errtext = sqlca.sqlerrtext
				rollback;
				messagebox('Error','Descripción del error: '+ls_errtext)
				return
			elseif sqlca.sqlcode = 1 then //si actualizo la cantidad en la confirmación
				//	gf_cr_convertmin(ll_cant_min, ls_unidad, ll_cantidad, ll_cant1)
					update inmprodu
					set prod_cant_confirma = prod_cant_confirma + :ll_cant_min
					where prod_g_financiero = :str.g_financiero and
							prod_empresa = :str.empresa and
							prod_producto = :ls_producto ;
					if sqlca.sqlcode = -1 then
						ls_errtext = sqlca.sqlerrtext
						rollback;
						messagebox('Error','Error al Actualizar el Producto '+ls_errtext)
						return
					end if
					
//					update inmbodeg
//					set mbod_cant_confirma = mbod_cant_confirma + :ll_cant_min
//					where mbod_g_financiero = :str.g_financiero and
//							mbod_empresa = :str.empresa and
//							mbod_bodega = :w_cr_fondo.is_bodega and
//							mbod_ubicacion = :w_cr_fondo.is_ubicacion and
//							mbod_producto = :ls_producto;				
//					if sqlca.sqlcode = -1 then
//						ls_errtext = sqlca.sqlerrtext
//						rollback;
//						messagebox('Error','Error al Actualizar las cantidades en Bodega '+ls_errtext)
//						return
//					end if						
			end if
	else
		rollback;
		messagebox("Atención - Error ","¡Error Cuando de Estan Grabando los Registros!",Exclamation!)
		Return
	end if
End Choose
end event

event closequery;call super::closequery;/*ADD BY HGN/30/09/2002 para proceso unificado HABILITA BOTONES */
if str_formato.viene_de ='unif' then 
//	if w_cr_compras_unif.is_desact_ono_a_uno = '1' then //Proceso uno a uno deasactivado
//		w_cr_compras_unif.Dynamic wf_habilita_todos()
//	end if
end if

end event

event ue_insertar;//override
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_cz_ma_transito
boolean visible = false
integer x = 50
integer y = 1760
integer width = 795
end type

type dw_1 from w_fa_padre`dw_1 within w_cz_ma_transito
boolean visible = false
integer x = 91
integer y = 844
integer width = 663
integer height = 1136
integer taborder = 20
borderstyle borderstyle = stylelowered!
end type

event dw_1::rowfocuschanged;//No se debe ejecutar
end event

type tab_1 from tab within w_cz_ma_transito
integer x = 55
integer y = 12
integer width = 4320
integer height = 1680
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
boolean underline = true
long backcolor = 79741120
boolean raggedright = true
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
end on

event selectionchanged;Integer li_registros,i, li_ann
string	ls_mascara, ls_cuenta_compras, ls_detalle, ls_cuenta_cxp, ls_factura, ls_fac, ls_dmce
long ll_entrada, ll_tercero, ll_referencia_contable
decimal{2} ld_monto
datetime ldt_fecha
CHOOSE CASE newindex 
	CASE 5
		if tab_1.tabpage_2.dw_detalle.rowcount() = 0 then return
		tab_1.tabpage_1.dw_generales.accepttext()
		ll_entrada = tab_1.tabpage_1.dw_generales.getitemnumber(1,'crtordco_toco_entrada_inv')
		if isnull(ll_entrada) then ll_entrada = 0
		if isnull(ll_entrada) or ll_entrada = 0	then
	//		gf_mensaje('','Debe Asignar un numero de entrada para poder generar el Asiento Contable',1,1,'E')
	//		return
		end if
		ls_dmce	  = tab_1.tabpage_1.dw_generales.getitemstring(1,'toco_no_dmce')
		if isnull(ls_dmce) then ls_dmce = ''			
		if isnull(ls_dmce) or ls_dmce = ''	then
	//		gf_mensaje('','Debe Asignar un numero de DMCE para poder generar el Asiento Contable',1,1,'E')
	//		return
		end if
		ls_fac = tab_1.tabpage_1.dw_generales.getitemstring(1,'toco_factura_proveedor')
		if isnull(ls_fac) or ls_fac = ''	then
			gf_mensaje('','Debe Asignar un numero de Factura para poder generar el Asiento Contable',1,1,'E')
			return
		end if
		ld_monto  =   tab_1.tabpage_2.dw_detalle.getitemnumber(1,'t_final')
		ll_tercero  = tab_1.tabpage_1.dw_generales.getitemnumber(1,'toco_num_prove')
		ls_detalle  = 'Entrada: '+string(ll_entrada)+' - No. DMCE: '+ls_dmce+ ' - Factura: '+ls_fac
		ll_referencia_contable = tab_1.tabpage_1.dw_generales.getitemnumber(1,'toco_referencia_contable')
		ldt_fecha	 = tab_1.tabpage_1.dw_generales.getitemdatetime(1,'toco_fecha_oc')
		li_ann = year(date(ldt_fecha))		
		if idw_9.retrieve(str.g_financiero, str.empresa,'IN','EN',ll_referencia_contable, li_ann) > 0 then
			for i = 1 to idw_9.rowcount()
				if idw_9.getitemstring(i,'naturaleza') = 'C' then
					idw_9.setitem(i,'monto_credito',idw_9.getitemnumber(i,'ddia_monto'))
				else
					idw_9.setitem(i,'monto_debito',idw_9.getitemnumber(i,'ddia_monto'))
				end if
				idw_9.setitem(i,'cuenta',idw_9.getitemstring(i,'ddia_mg_cuenta'))
			next
			idw_9.setfocus()
		else
			if ll_referencia_contable = 0 or isnull(ll_referencia_contable) then
				  SELECT max(diar_no_referencia)  
					 INTO :ll_referencia_contable  
					 FROM cotdiari  
					WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
							( cotdiari.diar_empresa = :str.empresa ) AND  
							( cotdiari.diar_aplicacion_mg = 'IN' ) AND  
							( cotdiari.diar_tipo_transaccion = 'EN' ) AND  
							( cotdiari.diar_sub_trans = 'CR' )   ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al Buscar Referencia Compras '+sqlca.sqlerrtext,1,1,'E')
								return
							end if
							if isnull(ll_referencia_contable) then ll_referencia_contable = 0
				ll_referencia_contable ++
			end if
			ldt_fecha = datetime(date(gf_fecha_serv()),time('00:00;00'))
			idw_9.scrolltorow(idw_9.insertrow(0))
				  SELECT isnull(dgmserdr.serd_mgcuenta,'')
					 INTO :ls_cuenta_compras  
					 FROM dgmserdr  
					WHERE ( dgmserdr.serd_g_financiero = :str.g_financiero ) AND  
							( dgmserdr.serd_empresa = :str.empresa ) AND  
							( dgmserdr.serd_transaccion = 'EN' ) AND  
							( dgmserdr.serd_sub_trans = 'CR' ) AND  
							( dgmserdr.serd_aplicacion = 'IN' )   ;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al Buscar Cuenta Compras '+sqlca.sqlerrtext,1,1,'E')
							return
						end if
			
			if ls_cuenta_compras = '' then
				gf_mensaje('','Debe Asignar la Cuenta de Compras en Datos Generales Transacciones ...',1,1,'E')
				return
			end if
			
			idw_9.setitem(1,'ddia_monto',ld_monto)
			idw_9.setitem(1,'monto_debito',ld_monto)
			idw_9.setitem(1,'naturaleza','D')
			idw_9.setitem(1,'ddia_linea',1)
			idw_9.setitem(1,'ddia_ann',li_ann)					
			idw_9.setitem(1,'ddia_g_financiero',str.g_financiero)
			idw_9.setitem(1,'ddia_empresa',str.empresa)			
			idw_9.setitem(1,'ddia_aplicacion_mg','IN')			
			idw_9.setitem(1,'ddia_tipo_transaccion','EN')			
			idw_9.setitem(1,'ddia_sub_trans','CR')
			idw_9.setitem(1,'ddia_mg_cuenta',ls_cuenta_compras)			
			idw_9.setitem(1,'cuenta',ls_cuenta_compras)						
			idw_9.setitem(1,'ddia_id',str.usuario)			
			idw_9.setitem(1,'ddia_fecha',ldt_fecha)		
			idw_9.setitem(1,'ddia_tercero',ll_tercero)		
			idw_9.setitem(1,'ddia_documento_anexo',ll_entrada)		
			idw_9.setitem(1,'ddia_comentario_detalle',ls_detalle)		
			idw_9.setitem(1,'ddia_identificacion','1')
			idw_9.setitem(1,'ddia_no_referencia',ll_referencia_contable)					
			
			idw_9.scrolltorow(idw_9.insertrow(0))
			  SELECT max(prov_mg_cuenta)
				 INTO :ls_cuenta_cxp
				 FROM cpmprove  
				WHERE ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
						( cpmprove.prov_empresa = :str.empresa ) AND  
						( cpmprove.prov_tercero = :ll_tercero ) ;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al Buscar Cuenta Proveedor '+sqlca.sqlerrtext,1,1,'E')
							return
						end if
			if ls_cuenta_cxp = '' then
				gf_mensaje('','Debe Asignar la Cuenta de Proveedores ...',1,1,'E')
				return
			end if
			
			idw_9.setitem(2,'ddia_monto',ld_monto)
			idw_9.setitem(2,'monto_credito',ld_monto)
			idw_9.setitem(2,'naturaleza','C')
			idw_9.setitem(2,'ddia_linea',2)
			idw_9.setitem(2,'ddia_ann',li_ann)					
			idw_9.setitem(2,'ddia_g_financiero',str.g_financiero)
			idw_9.setitem(2,'ddia_empresa',str.empresa)			
			idw_9.setitem(2,'ddia_aplicacion_mg','IN')			
			idw_9.setitem(2,'ddia_tipo_transaccion','EN')			
			idw_9.setitem(2,'ddia_sub_trans','CR')
			idw_9.setitem(2,'ddia_mg_cuenta',ls_cuenta_cxp)			
			idw_9.setitem(2,'cuenta',ls_cuenta_cxp)						
			idw_9.setitem(2,'ddia_id',str.usuario)			
			idw_9.setitem(2,'ddia_fecha',ldt_fecha)		
			idw_9.setitem(2,'ddia_tercero',ll_tercero)		
			idw_9.setitem(2,'ddia_documento_anexo',ll_entrada)		
			idw_9.setitem(2,'ddia_comentario_detalle',ls_detalle)		
			idw_9.setitem(2,'ddia_identificacion','1')
			idw_9.setitem(2,'ddia_no_referencia',ll_referencia_contable)
			
			tab_1.tabpage_1.dw_generales.setitem(1,'toco_referencia_contable',ll_referencia_contable)
			
		end if
		
	CASE 1
		dw = tab_1.tabpage_1.dw_generales
		dw_6.visible = false
	case 2
 		dw = tab_1.tabpage_2.dw_detalle
		tab_1.tabpage_2.dw_2.retrieve(str.g_financiero,str.empresa,is_numero_oc,il_year,is_numero_sup) 
		For i = 1 to dw.rowcount()
			wf_calcula_costos(i)
		Next
		if tab_1.tabpage_2.dw_detalle.rowcount() = 0 then
			parent.triggerevent("ue_adicionar")
		else  
			dw.setfocus()
			dw.SetColumn(27)
			if dw.rowcount() > 0 then
				li_tipo_compra = dw.GetItemNumber(dw.getrow(),'doco_tipo_compra')
			   dw.postevent("ue_despues")
			end if
		end if 
		//Para validar la unidad de medida			
		if is_unidad_fija = 'S' then
			if tab_1.tabpage_2.dw_detalle.describe('unidad_fija.x') <> "?" and &
				tab_1.tabpage_2.dw_detalle.describe('unidad_fija.x') <> "!" then
				tab_1.tabpage_2.dw_detalle.object.unidad_fija.expression = '1'
			end if
		else
			if tab_1.tabpage_2.dw_detalle.describe('unidad_fija.x') <> "?" and &
				tab_1.tabpage_2.dw_detalle.describe('unidad_fija.x') <> "!" then
				tab_1.tabpage_2.dw_detalle.object.unidad_fija.expression = '0'
			end if					
		end if
	case 4	
		dw_6.visible = false
		dw =  tab_1.tabpage_4.dw_listado
//		ls_mascara = gf_cr_mascara_dec()
//		dw.modify("crdordco_doco_precio_unitario.editmask.mask='"+ls_mascara+"'")
//		dw.object.formato.expression = "'"+ls_mascara+"'"
		
		tab_1.tabpage_4.dw_listado.retrieve(str.g_financiero,str.empresa,is_numero_oc,il_year)
		dw.Object.Datawindow.print.preview = 'yes'
		dw.Object.DataWindow.Zoom = 80
END CHOOSE

end event

event selectionchanging;// Gianni Arauz (27/04/2000)
// Validar que existan registros en el datawindow de la cabecera
ii_tabpage =newindex
if newindex = 2 or newindex = 3 or newindex = 4 or newindex = 5 then
	if tab_1.tabpage_1.dw_generales.rowcount() = 0 then return 1
end if


end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4283
integer height = 1552
long backcolor = 79741120
string text = "Generales"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Custom090!"
long picturemaskcolor = 553648127
string powertiptext = "Generales de la Orden"
dw_7 dw_7
dw_5 dw_5
dw_4 dw_4
cb_cambiar cb_cambiar
cb_buscar cb_buscar
p_1 p_1
dw_generales dw_generales
pb_3 pb_3
dw_3 dw_3
dw_8 dw_8
end type

on tabpage_1.create
this.dw_7=create dw_7
this.dw_5=create dw_5
this.dw_4=create dw_4
this.cb_cambiar=create cb_cambiar
this.cb_buscar=create cb_buscar
this.p_1=create p_1
this.dw_generales=create dw_generales
this.pb_3=create pb_3
this.dw_3=create dw_3
this.dw_8=create dw_8
this.Control[]={this.dw_7,&
this.dw_5,&
this.dw_4,&
this.cb_cambiar,&
this.cb_buscar,&
this.p_1,&
this.dw_generales,&
this.pb_3,&
this.dw_3,&
this.dw_8}
end on

on tabpage_1.destroy
destroy(this.dw_7)
destroy(this.dw_5)
destroy(this.dw_4)
destroy(this.cb_cambiar)
destroy(this.cb_buscar)
destroy(this.p_1)
destroy(this.dw_generales)
destroy(this.pb_3)
destroy(this.dw_3)
destroy(this.dw_8)
end on

type dw_7 from datawindow within tabpage_1
boolean visible = false
integer x = 1435
integer y = 76
integer width = 2971
integer height = 1244
integer taborder = 70
string title = "none"
string dataobject = "dw_productos_guias_llegando"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_5 from datawindow within tabpage_1
boolean visible = false
integer x = 133
integer y = 188
integer width = 2971
integer height = 704
integer taborder = 60
string title = "none"
string dataobject = "dw_pendientes_a_excell"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_4 from datawindow within tabpage_1
boolean visible = false
integer x = 146
integer y = 156
integer width = 635
integer height = 428
integer taborder = 50
boolean titlebar = true
string title = "Cambiar # TR"
string dataobject = "dw_external_codigo"
boolean controlmenu = true
string icon = "Error!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;string ls_codigo, ls_codigo_anterior, ls_estado, ls_sqlerrtext
integer li_ann, li_existe
boolean lb_salvo
this.accepttext()

ls_codigo = this.getitemstring(1,'codigo')
if ls_codigo = '' or isnull(ls_codigo) then return
ls_estado = tab_1.tabpage_1.dw_generales.getitemstring(1,'toco_pase_factura')
if ls_estado = 'S' then return

ls_codigo_anterior = tab_1.tabpage_1.dw_generales.getitemstring(1,'crtordco_toco_codigo_oc')
li_ann = tab_1.tabpage_1.dw_generales.getitemnumber(1,'toco_anno_oc')

if gf_mensaje('','Esta Seguro de Cambiar el Numero ??',2,1,'E') = 2 then return

  SELECT isnull(count(*),0)  
    INTO :li_existe  
    FROM crtordco  
   WHERE ( crtordco.toco_g_financiero = :str.g_financiero ) AND  
         ( crtordco.toco_empresa = :str.empresa ) AND  
         ( crtordco.toco_codigo_oc = :ls_codigo ) AND  
         ( crtordco.toco_anno_oc = :li_ann )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al validar existencia '+sqlca.sqlerrtext,1,1,'E')
		return
	end if
	if li_existe > 0 then
		gf_mensaje('','El número ya existe, Verifique !!!',1,1,'E')
		this.setcolumn('codigo')
		return
	end if
	sqlca.autocommit = false
//	gf_fa_cambiar_tipo_fac_anio(ls_pedido, li_ann, ls_pedido_new, lb_salvo)
	  INSERT INTO crtordco  
         ( toco_g_financiero,   
           toco_empresa,   
           toco_codigo_oc,   
           toco_anno_oc,   
           toco_num_suplemento,   
           toco_tipo_oc,   
           toco_num_prove,   
           toco_cod_tipo_pago,   
           toco_fecha_oc,   
           toco_fecha_entrega,   
           toco_estatus_oc,   
           toco_representante_empresa,   
           toco_observacion,   
           toco_tipo_costo,   
           toco_ref_oc,   
           toco_representante_prov,   
           toco_tipo_compra,   
           toco_clase_compra,   
           toco_tipo_entrega,   
           toco_tiempo_entrega,   
           toco_forma_pago,   
           toco_justificacion,   
           toco_pedido,   
           toco_autorizacion,   
           toco_autoriza_cedula,   
           toco_entregarse,   
           toco_ent_atencion,   
           toco_actualizo_cargos,   
           toco_gastos_total,   
           toco_monto_total_orden,   
           toco_monto_anterior,   
           toco_codigo_viaje,   
           toco_num_confirmacion,   
           toco_fecha_embarque,   
           toco_fecha_confirmado,   
           toco_forma_embarque,   
           toco_packing,   
           toco_fabrica,   
           toco_tipo_mercancia,   
           toco_status,   
           toco_temporada,   
           toco_num_carta_credito,   
           toco_bultos,   
           toco_vapor,   
           toco_pase_factura,   
           toco_peso,   
           toco_cubicage_total,   
           toco_costo_flete,   
           toco_clave_pedido,   
           toco_cuenta_req,   
           toco_cuenta_cargar,   
           toco_moneda,   
           toco_cambio,   
           toco_contenedor,   
           toco_entrada_inv,   
           toco_anio_orden_c,   
           toco_fecha_creacion,   
           toco_factura_proveedor,   
           toco_tiene_muestras,   
           toco_muestra_procesada,   
           toco_usuario,   
           toco_fecha_modificacion,
		  toco_usuario_cambio_numero,
		  toco_fecha_cambio_numero)  
     SELECT crtordco.toco_g_financiero,   
            crtordco.toco_empresa,   
            :ls_codigo,   
            crtordco.toco_anno_oc,   
            crtordco.toco_num_suplemento,   
            crtordco.toco_tipo_oc,   
            crtordco.toco_num_prove,   
            crtordco.toco_cod_tipo_pago,   
            crtordco.toco_fecha_oc,   
            crtordco.toco_fecha_entrega,   
            crtordco.toco_estatus_oc,   
            crtordco.toco_representante_empresa,   
            crtordco.toco_observacion,   
            crtordco.toco_tipo_costo,   
            crtordco.toco_ref_oc,   
            crtordco.toco_representante_prov,   
            crtordco.toco_tipo_compra,   
            crtordco.toco_clase_compra,   
            crtordco.toco_tipo_entrega,   
            crtordco.toco_tiempo_entrega,   
            crtordco.toco_forma_pago,   
            crtordco.toco_justificacion,   
            crtordco.toco_pedido,   
            crtordco.toco_autorizacion,   
            crtordco.toco_autoriza_cedula,   
            crtordco.toco_entregarse,   
            crtordco.toco_ent_atencion,   
            crtordco.toco_actualizo_cargos,   
            crtordco.toco_gastos_total,   
            crtordco.toco_monto_total_orden,   
            crtordco.toco_monto_anterior,   
            crtordco.toco_codigo_viaje,   
            crtordco.toco_num_confirmacion,   
            crtordco.toco_fecha_embarque,   
            crtordco.toco_fecha_confirmado,   
            crtordco.toco_forma_embarque,   
            crtordco.toco_packing,   
            crtordco.toco_fabrica,   
            crtordco.toco_tipo_mercancia,   
            crtordco.toco_status,   
            crtordco.toco_temporada,   
            crtordco.toco_num_carta_credito,   
            crtordco.toco_bultos,   
            crtordco.toco_vapor,   
            crtordco.toco_pase_factura,   
            crtordco.toco_peso,   
            crtordco.toco_cubicage_total,   
            crtordco.toco_costo_flete,   
            crtordco.toco_clave_pedido,   
            crtordco.toco_cuenta_req,   
            crtordco.toco_cuenta_cargar,   
            crtordco.toco_moneda,   
            crtordco.toco_cambio,   
            crtordco.toco_contenedor,   
            crtordco.toco_entrada_inv,   
            crtordco.toco_anio_orden_c,   
            crtordco.toco_fecha_creacion,   
            crtordco.toco_factura_proveedor,   
            crtordco.toco_tiene_muestras,   
            crtordco.toco_muestra_procesada,   
            crtordco.toco_usuario,   
            crtordco.toco_fecha_modificacion,
		   :str.usuario,
		   getdate()
       FROM crtordco  
      WHERE ( crtordco.toco_g_financiero = :str.g_financiero ) AND  
            ( crtordco.toco_empresa = :str.empresa ) AND  
            ( crtordco.toco_codigo_oc = :ls_codigo_anterior ) AND  
            ( crtordco.toco_anno_oc = :li_ann )   ;
		if sqlca.sqlcode = -1 then
			ls_sqlerrtext = sqlca.sqlerrtext
			rollback;
			lb_salvo=false
			this.visible = false
			mensaje("Información","Error al Insertar registro en crtordco",ls_sqlerrtext)
			return
		end if			
		
		//************************************************
  UPDATE crdordco  
     SET doco_codigo_oc = :ls_codigo  
   WHERE ( crdordco.doco_g_financiero = :str.g_financiero ) AND  
         ( crdordco.doco_empresa = :str.empresa ) AND  
         ( crdordco.doco_codigo_oc = :ls_codigo_anterior ) AND  
         ( crdordco.doco_anno_oc = :li_ann )   ;
		if sqlca.sqlcode = -1 then
			ls_sqlerrtext = sqlca.sqlerrtext
			rollback;
			lb_salvo=false
			this.visible = false
			mensaje("Información","Error al actualizar registro en crdordco ",ls_sqlerrtext)
			return
		end if			
//************************************************
		  DELETE FROM crtordco  
		WHERE ( crtordco.toco_g_financiero = :str.g_financiero ) AND  
				( crtordco.toco_empresa = :str.empresa ) AND  
				( crtordco.toco_codigo_oc = :ls_codigo_anterior ) AND  
				( crtordco.toco_anno_oc = :li_ann )   ;	
		if sqlca.sqlcode = -1 then
			ls_sqlerrtext = sqlca.sqlerrtext
			rollback;
			lb_salvo=false
			this.visible = false
			mensaje("Información","Error al eliminar registro en crtordco",ls_sqlerrtext)
			return
		end if			
//************************************************
commit using sqlca;
lb_salvo = true
this.visible = false
mensaje("","El Cambio fue Realizado Exitosamente","")

	sqlca.autocommit = true
	this.setitem(1,'codigo','')
	if lb_salvo then
		tab_1.tabpage_1.dw_generales.setcolumn('crtordco_toco_codigo_oc')
		tab_1.tabpage_1.dw_generales.setitem(1,'crtordco_toco_codigo_oc',ls_codigo)
		if tab_1.tabpage_1.dw_generales.retrieve(str.g_financiero,str.empresa,ls_codigo,li_ann,is_numero_sup) > 0 then
			if tab_1.tabpage_2.dw_detalle.retrieve(str.g_financiero,str.empresa,ls_codigo,li_ann) > 0 then
				ib_graba_modificado_por = true
			end if
		end if
	end if

end event

event itemchanged;this.accepttext()
end event

type cb_cambiar from commandbutton within tabpage_1
integer x = 192
integer y = 60
integer width = 247
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Cambiar"
end type

event clicked;idw_4.setitem(1,'codigo','')
idw_4.visible = true
idw_4.setfocus()

end event

type cb_buscar from commandbutton within tabpage_1
integer x = 1134
integer y = 604
integer width = 110
integer height = 80
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "?"
end type

event clicked;str_dg_dynamic_find		lstr_df
string						ls_cadena
Long							ll_num_prove
String						ls_syntax

//if w_cr_fondo.is_integrado_cp = 'N' then
	// Compras
	
	/***************************************************************************************
	 *										Se hizo Clic sobre el botón										*
	 *											Proveedores Directos												*
	 *  									Búsqueda Dinámica del Proveedor									*
	 ***************************************************************************************/
	
	lstr_df.texto_campo [1,1] = "dgmterce.terc_tercero"
	lstr_df.texto_campo [1,2] = "No. Prov."
	lstr_df.texto_campo [1,3] = "tfac_num_prove"
	lstr_df.texto_campo [1,4] = "V"
	lstr_df.texto_campo [2,1] = "dgmterce.terc_descripcion"
	lstr_df.texto_campo [2,2] = "Descripción"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = "V"
	lstr_df.texto_campo [3,1] = "dgapais.pais_descripcion"
	lstr_df.texto_campo [3,2] = "País"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = "V"
	lstr_df.texto_campo [4,1] = "dgmterce.terc_direccion"
	lstr_df.texto_campo [4,2] = "Dirección"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = "V"	
	
	lstr_df.tabla 		  = " dgmterce, dgapais "
	lstr_df.tabla_where = " WHERE dgmterce.terc_tipop = 1 And"+&
								 " dgapais.pais_pais = dgmterce.terc_pais"
	
	OpenWithParm(w_cr_busqueda, lstr_df)
	ls_syntax = Message.StringParm
	
	ll_num_prove = Long (Right ( ls_syntax, Len (ls_syntax) - Pos (ls_syntax, "=") ))
	IF NOT IsNull(ll_num_prove) AND (ll_num_prove <> 0) Then
		wf_set_datos_proveedor(dw_generales,dw_generales.getrow(),ll_num_prove)
	END IF
	
//else
//	// Cuentas por Pagar
//   lstr_df.texto_campo [1,1] = "prov_cod_proveedor"
//	lstr_df.texto_campo [1,2] = "Proveedor"
//	lstr_df.texto_campo [1,3] = ""
//	lstr_df.texto_campo [1,4] = 'V'
//	lstr_df.texto_campo [2,1] = "terc_tercero"
//	lstr_df.texto_campo [2,2] = "Tercero"
//	lstr_df.texto_campo [2,3] = "terc_tercero"
//	lstr_df.texto_campo [2,4] = 'V'
//	lstr_df.texto_campo [3,1] = "terc_descripcion"
//	lstr_df.texto_campo [3,2] = "Descripción"
//	lstr_df.texto_campo [3,3] = ""
//	lstr_df.texto_campo [3,4] = 'V'
//	lstr_df.texto_campo [4,1] = "pais_descripcion"
//	lstr_df.texto_campo [4,2] = "País"
//	lstr_df.texto_campo [4,3] = ""
//	lstr_df.texto_campo [4,4] = 'V'
//	lstr_df.texto_campo [5,1] = "terc_direccion"
//	lstr_df.texto_campo [5,2] = "Dirección"
//	lstr_df.texto_campo [5,3] = ""
//	lstr_df.texto_campo [5,4] = 'V'
//	
//	lstr_df.tabla 		  = " cpmprove, dgmterce, dgapais "
//	lstr_df.tabla_where = " WHERE dgmterce.terc_tipop = 1 And "+&
//								 " dgapais.pais_pais = dgmterce.terc_pais and "+&
//								 " prov_tercero = terc_tercero and "+&
//								 ' prov_g_financiero = '+string(str.g_financiero)+' and '+&
//								 ' prov_empresa = '+string(str.empresa)
//	
//	OpenWithParm(w_dg_a_custom_find,lstr_df)
//	
//	ls_syntax = Message.StringParm
//
//	if len(ls_syntax) = 0 then
//		return
//	else
//		ll_num_prove = long(Right(ls_syntax,Len(ls_syntax) - Pos(ls_syntax,"=")))
//		if not IsNull(ll_num_prove) and (ll_num_prove <> 0) Then
//			wf_set_datos_proveedor(this,this.getrow(),ll_num_prove)
//		end if
//	end if
//end if
//
end event

type p_1 from picture within tabpage_1
boolean visible = false
integer x = 2985
integer y = 1220
integer width = 256
integer height = 180
boolean bringtotop = true
string picturename = "f:\harr2000\art\impresora.bmp"
boolean border = true
boolean focusrectangle = false
end type

event clicked;//tab_1.tabpage_4.dw_listado.print(true)



end event

type dw_generales from datawindow within tabpage_1
event ue_enter pbm_dwnprocessenter
event ue_post_changed ( long row,  date data )
event ue_nulo ( )
integer x = 82
integer y = 4
integer width = 3470
integer height = 1536
integer taborder = 4
string dataobject = "dw_ma_cz_pedidos_grals"
boolean border = false
end type

event ue_enter;this.accepttext()
send(handle(this),256,9,long(0,0))
return -1
end event

event ue_post_changed;date    ld_fecha_hasta,ld_fecha_desde
ld_fecha_desde	= date(tab_1.tabpage_1.dw_generales.GetItemDatetime(row,"toco_fecha_oc"))
tab_1.tabpage_1.dw_generales.SetItem(row,"toco_tiempo_entrega", DaysAfter(ld_fecha_desde, data))

end event

event ue_nulo;messagebox('Atención','El No. de Documento  no puede ser nulo')
this.setfocus()
this.setcolumn('crtordco_toco_codigo_oc')
this.setitem(1,"crtordco_toco_codigo_oc",	is_sec_oc )
return
end event

event buttonclicked;str_dg_dynamic_find		lstr_df
string						ls_cadena
Long							ll_num_prove
String						ls_syntax

//if w_cr_fondo.is_integrado_cp = 'N' then
	// Compras
	
	/***************************************************************************************
	 *										Se hizo Clic sobre el botón										*
	 *											Proveedores Directos												*
	 *  									Búsqueda Dinámica del Proveedor									*
	 ***************************************************************************************/
	
	lstr_df.texto_campo [1,1] = "dgmterce.terc_tercero"
	lstr_df.texto_campo [1,2] = "No. Prov."
	lstr_df.texto_campo [1,3] = "tfac_num_prove"
	lstr_df.texto_campo [1,4] = "V"
	lstr_df.texto_campo [2,1] = "dgmterce.terc_descripcion"
	lstr_df.texto_campo [2,2] = "Descripción"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = "V"
	lstr_df.texto_campo [3,1] = "dgapais.pais_descripcion"
	lstr_df.texto_campo [3,2] = "País"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = "V"
	lstr_df.texto_campo [4,1] = "dgmterce.terc_direccion"
	lstr_df.texto_campo [4,2] = "Dirección"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = "V"	
	
	lstr_df.tabla 		  = " dgmterce, dgapais "
	lstr_df.tabla_where = " WHERE dgmterce.terc_tipop = 1 And"+&
								 " dgapais.pais_pais = dgmterce.terc_pais"
	
	OpenWithParm(w_cr_busqueda, lstr_df)
	ls_syntax = Message.StringParm
	
	ll_num_prove = Long (Right ( ls_syntax, Len (ls_syntax) - Pos (ls_syntax, "=") ))
	IF NOT IsNull(ll_num_prove) AND (ll_num_prove <> 0) Then
		wf_set_datos_proveedor(this,this.getrow(),ll_num_prove)
	END IF
	
//else
//	// Cuentas por Pagar
//   lstr_df.texto_campo [1,1] = "prov_cod_proveedor"
//	lstr_df.texto_campo [1,2] = "Proveedor"
//	lstr_df.texto_campo [1,3] = ""
//	lstr_df.texto_campo [1,4] = 'V'
//	lstr_df.texto_campo [2,1] = "terc_tercero"
//	lstr_df.texto_campo [2,2] = "Tercero"
//	lstr_df.texto_campo [2,3] = "terc_tercero"
//	lstr_df.texto_campo [2,4] = 'V'
//	lstr_df.texto_campo [3,1] = "terc_descripcion"
//	lstr_df.texto_campo [3,2] = "Descripción"
//	lstr_df.texto_campo [3,3] = ""
//	lstr_df.texto_campo [3,4] = 'V'
//	lstr_df.texto_campo [4,1] = "pais_descripcion"
//	lstr_df.texto_campo [4,2] = "País"
//	lstr_df.texto_campo [4,3] = ""
//	lstr_df.texto_campo [4,4] = 'V'
//	lstr_df.texto_campo [5,1] = "terc_direccion"
//	lstr_df.texto_campo [5,2] = "Dirección"
//	lstr_df.texto_campo [5,3] = ""
//	lstr_df.texto_campo [5,4] = 'V'
//	
//	lstr_df.tabla 		  = " cpmprove, dgmterce, dgapais "
//	lstr_df.tabla_where = " WHERE dgmterce.terc_tipop = 1 And "+&
//								 " dgapais.pais_pais = dgmterce.terc_pais and "+&
//								 " prov_tercero = terc_tercero and "+&
//								 ' prov_g_financiero = '+string(str.g_financiero)+' and '+&
//								 ' prov_empresa = '+string(str.empresa)
//	
//	OpenWithParm(w_dg_a_custom_find,lstr_df)
//	
//	ls_syntax = Message.StringParm
//
//	if len(ls_syntax) = 0 then
//		return
//	else
//		ll_num_prove = long(Right(ls_syntax,Len(ls_syntax) - Pos(ls_syntax,"=")))
//		if not IsNull(ll_num_prove) and (ll_num_prove <> 0) Then
//			wf_set_datos_proveedor(this,this.getrow(),ll_num_prove)
//		end if
//	end if
//end if
//
end event

event itemchanged;Integer	li_existe, li_existe2
date ld_fecha_hasta
string	ls_orden_ant,ls_orden, ls_factura

this.accepttext()
if len(this.getitemstring(1,'crtordco_toco_codigo_oc'))  <  1 then
	this.postevent("ue_nulo")
	return 
end if
ib_graba_modificado_por = true

CHOOSE CASE this.getcolumnname()
CASE "toco_factura_proveedor"
		ls_factura = this.getitemstring(row,'toco_factura_proveedor')
		li_existe = pos(ls_factura,'/')
		li_existe2 = pos(ls_factura,'\')
		if li_existe > 0 or li_existe2 > 0 then
			gf_mensaje('','El numero de la Factura no debe llevar "/" ni "\" , Verifique !!!',1,1,'E')
			this.setitem(row,'toco_factura_proveedor','')
			THIS.SETCOLUMN('toco_factura_proveedor')
			return 2
		end if
		
CASE "crtordco_toco_codigo_oc"
		ls_orden_ant = this.getitemstring(row,'crtordco_toco_codigo_oc')
		is_numero_oc = data
		ls_orden = is_numero_oc
	
		tab_1.tabpage_2.dw_2.retrieve(str.g_financiero,str.empresa,is_numero_oc,il_year,is_numero_sup) 	
			
			if tab_1.tabpage_1.dw_generales.retrieve(str.g_financiero,str.empresa,is_numero_oc,il_year,is_numero_sup) > 0 then
				tab_1.tabpage_2.dw_detalle.retrieve(str.g_financiero,str.empresa,is_numero_oc,il_year)
			else
				w_cz_ma_transito.triggerevent('ue_adicionar')
				this.setitem(this.getrow(),'crtordco_toco_codigo_oc',ls_orden)
				is_numero_oc = ls_orden
				is_sec_oc = ls_orden_ant
			end if
			
if isnull(data) or trim(data) = '' then
	post event ue_nulo()
end if

CASE "toco_num_prove"
		wf_set_datos_proveedor(this,this.getrow(),this.getitemnumber(row,'toco_num_prove'))
		/* El codigo de proveedor se va a cambiar a string en algun momento */
Case "toco_fecha_entrega"
		ld_fecha_hasta = date(tab_1.tabpage_1.dw_generales.GetItemDatetime(row,"toco_fecha_entrega"))
			This.Post Event ue_post_changed(row, ld_fecha_hasta)
Case "toco_tiempo_entrega", "toco_fecha_oc"
			ld_fecha_hasta = relativedate(date(tab_1.tabpage_1.dw_generales.GetItemDatetime(row,"toco_fecha_oc")), &
			                 tab_1.tabpage_1.dw_generales.GetItemnumber(row,"toco_tiempo_entrega"))
			tab_1.tabpage_1.dw_generales.setItem(row,"toco_fecha_entrega",datetime(ld_fecha_hasta))         								  
Case	"toco_cod_tipo_pago"
			If this.getitemstring(row,'toco_cod_tipo_pago') = 'CCR' Then
				// Habilitar OpenWithParm(w_cz_detalle_credito,0)
			End If
END CHOOSE


end event

event itemfocuschanged;//if dwo.name = "toco_cod_tipo_pago" then
//	If this.getitemstring(row,'toco_cod_tipo_pago') = 'CCR' Then
//		OpenWithParm(w_cz_detalle_credito,0)
//	End If
//end if
this.selecttext(1,100)
end event

event dberror;if trim(sqlerrtext) <> '' then
	rollback;
end if

end event

event clicked;//dw_position =
end event

type pb_3 from picture within tabpage_1
boolean visible = false
integer x = 923
integer y = 1092
integer width = 187
integer height = 144
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;// Ventana que llama a la ventana de cargos en ordenes de compra


//integer		li_existe
//datawindow	ldw_1
//
//ldw_1 = tab_1.tabpage_1.dw_generales
//str_cr_cargo_fac l_str		//Definicion de variable tipo estructura

//l_str.pedido = is_numero_oc
//l_str.an		 = il_year
//l_str.codigo = is_numero_sup
//
//l_str.monto = ldw_1.getitemnumber&
//             (ldw_1.getrow(),"toco_monto_total_orden")
//
////Abre la ventana de cargos, que a su vez llama una funcion que recalcula el monto final
//SELECT count(*)  
//INTO :li_existe  
//FROM crtordco
//WHERE ( toco_g_financiero = :str.g_financiero ) AND
//		( toco_empresa = :str.empresa ) AND
//		( toco_codigo_oc = :is_numero_oc ) AND
//		( toco_anno_oc = :il_year )   AND
//		( toco_num_suplemento = :is_numero_sup);
//
//if sqlca.sqlcode = -1 then
//	mensaje("Aviso","Error al Validar Existencia de la Orden de Compra",sqlca.sqlerrtext)
//	return
//end if
//
//if li_existe > 0 then
//	OpenWithParm(w_cz_man_confirma_carn,l_str)
//end if
//

if dw_3.visible <> true then
	if dw_3.retrieve(str.g_financiero,str.empresa,is_numero_oc,il_year,is_numero_sup) = 0 then
		dw_3.insertrow(0)
	end if
		dw_3.visible = true
end if
	


end event

type dw_3 from datawindow within tabpage_1
integer x = 937
integer y = 308
integer width = 1504
integer height = 560
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "Gastos"
string dataobject = "dw_cr_man_gastos"
boolean controlmenu = true
boolean minbox = true
end type

event constructor;dw_3.SettransObject(Sqlca)
dw_3.visible = false
end event

event buttonclicked;if dwo.name = 'cancelar' then
	dw_3.visible = false
end if
end event

type dw_8 from datawindow within tabpage_1
boolean visible = false
integer x = -5
integer y = 80
integer width = 3561
integer height = 1472
integer taborder = 80
boolean bringtotop = true
boolean titlebar = true
string title = "Reporte de Discrepancias"
string dataobject = "dw_discrepancias_transito_orden"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "Report5!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4283
integer height = 1552
long backcolor = 79741120
string text = "Detalles"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Report!"
long picturemaskcolor = 553648127
string powertiptext = "Detalle de la Orden"
cb_3 cb_3
dw_detalle dw_detalle
dw_2 dw_2
end type

on tabpage_2.create
this.cb_3=create cb_3
this.dw_detalle=create dw_detalle
this.dw_2=create dw_2
this.Control[]={this.cb_3,&
this.dw_detalle,&
this.dw_2}
end on

on tabpage_2.destroy
destroy(this.cb_3)
destroy(this.dw_detalle)
destroy(this.dw_2)
end on

type cb_3 from commandbutton within tabpage_2
integer x = 50
integer y = 1444
integer width = 658
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
boolean underline = true
string text = "Crear Transito Muestras"
end type

event clicked;if tab_1.tabpage_2.dw_detalle.rowcount() = 0 then return

integer i, li_ann, li_existe
datetime ldt_fecha_entrega
long ll_secuencia, ll_cantidad
string ls_producto, ls_transito, ls_unidad, ls_empresa
decimal{2} ld_costo, ld_costo_pieza, ld_valor

li_ann = tab_1.tabpage_1.dw_generales.getitemnumber(tab_1.tabpage_1.dw_generales.getrow(),'toco_anno_oc')
ls_transito = tab_1.tabpage_1.dw_generales.getitemString(tab_1.tabpage_1.dw_generales.getrow(),'crtordco_toco_codigo_oc')
ll_secuencia = tab_1.tabpage_1.dw_generales.getitemnumber(tab_1.tabpage_1.dw_generales.getrow(),'crtordco_toco_entrada_inv')
ldt_fecha_entrega = tab_1.tabpage_1.dw_generales.getitemdatetime(tab_1.tabpage_1.dw_generales.getrow(),'toco_fecha_entrega')

if ll_secuencia = 0 then 
	gf_mensaje('','Debe Asignar la Secuencia de la Entrada, Verifique !!!',1,1,'E')
	return
end if

  SELECT count(*)  
    INTO :li_existe  
    FROM muestras_entradas_transito  
   WHERE ( muestras_entradas_transito.mues_g_financiero = :str.g_financiero ) AND  
         ( muestras_entradas_transito.mues_empresa = :str.empresa ) AND  
         ( muestras_entradas_transito.mues_secuencia = :ll_secuencia ) AND  
         ( muestras_entradas_transito.mues_ann = :li_ann )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Buscar Existencia '+sqlca.sqlerrtext,1,1,'E')
			return
		end if
		
	if li_existe > 0 then
		DELETE	FROM muestras_entradas_transito  
			WHERE ( muestras_entradas_transito.mues_g_financiero = :str.g_financiero ) AND  
					( muestras_entradas_transito.mues_empresa = :str.empresa ) AND  
					( muestras_entradas_transito.mues_secuencia = :ll_secuencia ) AND  
					( muestras_entradas_transito.mues_ann = :li_ann )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Eliminar '+sqlca.sqlerrtext,1,1,'E')
			return
		end if
	end if

sqlca.autocommit = false
for i = 1 to tab_1.tabpage_2.dw_detalle.rowcount()
	ls_producto = tab_1.tabpage_2.dw_detalle.getitemstring(i,'doco_id_referencia')
	ls_unidad	= tab_1.tabpage_2.dw_detalle.getitemstring(i,'doco_unidad')
	ld_costo		= tab_1.tabpage_2.dw_detalle.getitemnumber(i,'doco_precio_unitario')
	  SELECT inamedid.medi_cantidad  INTO :ll_cantidad  
	    FROM inamedid  WHERE inamedid.medi_medida = :ls_unidad   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Buscar Medida '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			sqlca.autocommit = true
			return
		end if
	ld_costo_pieza = round(ld_costo / ll_cantidad, 2)
	ld_valor           = round(ld_costo_pieza * 3,2)
	
	  INSERT INTO muestras_entradas_transito  
         ( mues_g_financiero,   
           mues_empresa,   
           mues_secuencia,   
           mues_ann,   
           mues_transito,   
           mues_linea,   
           mues_fecha,   
           mues_producto,   
           mues_cantidad,   
           mues_costo,   
           mues_costo_pieza,   
           mues_valor,   
           mues_usuario,   
           mues_maquina,   
           mues_estado,   
           mues_fecha_creacion )  
  VALUES ( :str.g_financiero,   
           :str.empresa,   
           :ll_secuencia,   
           :li_ann,   
           :ls_transito,   
           :i,   
           :ldt_fecha_entrega,   
           :ls_producto,   
           3,   
           :ld_costo,   
           :ld_costo_pieza,   
           :ld_valor,   
           :str.usuario,   
           :str.maquina,   
           0,   
           getdate() )  ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Insertar '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			sqlca.autocommit = true
			return
		end if
	
next

commit;
sqlca.autocommit = true
gf_mensaje('','Creacion de Transito de Muestras Exitosa',1,1,'E')

if dw_6.retrieve(str.g_financiero, str.empresa, ll_secuencia, li_ann) > 0 then
	ls_empresa = gf_dg_nombre_empresa()
	dw_6.object.empresa.expression = "'"+ls_empresa+"'"
	dw_6.Object.Datawindow.print.preview = 'yes'
	dw_6.visible = true
	
end if
end event

type dw_detalle from datawindow within tabpage_2
event ue_enter pbm_dwnprocessenter
event ue_micro pbm_nchittest
event ue_despues ( )
event ue_dwnkey pbm_dwnkey
integer x = 37
integer y = 12
integer width = 4229
integer height = 1420
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ma_cz_pedidos_detalle"
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_enter;//string ls_descripcion_referencia, ls_meg_error
//long ll_sqlcod
//
//CHOOSE CASE getcolumnname()
//	CASE 'doco_id_referencia'
//		this.accepttext()
//		is_codigo_referencia = getitemstring(getrow(),'doco_id_referencia')
//		if ii_numero_tipo_compra = 2 then //Servicio
//			SELECT craservi.serv_descripcion  
//			INTO :ls_descripcion_referencia 
//			FROM craservi  
//			WHERE craservi.serv_codigo = :is_codigo_referencia;
//			
//		elseif ii_numero_tipo_compra = 3 then  //Productos
//			SELECT inmprodu.prod_descripcion  
//			INTO :ls_descripcion_referencia
//			FROM inmprodu  
//			WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
//			( inmprodu.prod_empresa = :str.empresa ) AND  
//			( inmprodu.prod_producto = :is_codigo_referencia );
//			
//		end if
//		
//		if sqlca.sqlcode = 0 then		
//			setitem(getrow(),'doco_descripcion_ref',ls_descripcion_referencia)
//		elseif sqlca.sqlcode = 100 then		
//			Mensaje('Atención - No Encotrado ','El codigo introducido no existe, Por favor Rectifique',"")
//			return
//		else
//			ls_meg_error = sqlca.sqlerrtext
//			ll_sqlcod = sqlca.sqldbcode
//			mensaje('Atencion - Error '+string(ll_sqlcod),'Hubo un error al buscar el Codigo ',&
//			ls_meg_error)
//			return
//		end if
//END CHOOSE
//send(handle(this),256,9,long(0,0))
//return -1

string		ls_colum
long			ll_cont, ll_num_max_col, ll_tab_order, ll_tab_order_next
boolean		lb_exist_nextcol
window		lw_window

lw_window = str.frame.getactivesheet()

lb_exist_nextcol = true

if IsValid(this) then
	if this.AcceptText() < 0 then
		return 1
	end if
	lb_exist_nextcol = false
	ls_colum = GetColumnName()
	ll_num_max_col = long(this.object.datawindow.column.count)
	ll_tab_order = long(this.Describe(ls_colum + ".TabSequence"))
	for ll_cont = 1 to ll_num_max_col
		ls_colum = this.Describe("#" + string(ll_cont) + ".Name")
		ll_tab_order_next = long(this.Describe(ls_colum + ".TabSequence"))
		if ll_tab_order_next = ll_tab_order + 10 then
			lb_exist_nextcol = true
			ll_cont = ll_num_max_col
		end if
	next
end if

if not lb_exist_nextcol then
	if not ib_no_insertar then
		if this.getrow() = this.rowcount() then
			if messagebox('Información','¿Desea Insertar otro Registro?',Information!,Yesno!,1) = 1 then
				if ib_adicionar then
					lw_window.triggerevent('ue_adicionar')
					this.setcolumn('doco_id_referencia')
					this.Modify("DataWindow.HorizontalScrollPosition = '0'")
				else
					this.InsertRow(0)
				end if
			else
				return 1
			end if
		else
			Send(Handle(this),256,9,long(0,0))
		end if
	else
		Send(Handle(this),256,9,long(0,0))
	end if
else
	Send(Handle(this),256,9,long(0,0))
end if

return 1

end event

event ue_micro;////   Recibe el objeto o del campo del datawindow al pasar el mouse por
////   encima para deslegar el MicroHelp o micro ayuda para esto toda la
////   columnas del DW tinene que tener el TAG con información sino
////   aparecera "?" en el microhelp                 
//
string ls_retorno,ls_tag
integer li_pos

ls_retorno = this.GetObjectAtPointer ()
li_pos = pos(ls_retorno, "~t") 
is_campo = left(ls_retorno, li_pos -1)
ls_tag = this.Describe (is_campo+".tag")
str.frame.SetMicroHelp (ls_tag)


end event

event ue_despues;int	li_var,li_var2
long	li_tipcom2[]

// Definición de arreglo para selecionar el tipo de compra

li_var =1
li_tipcom2[li_var] = li_tipo_compra

if  li_tipo_compra = 4 then
	li_var =0
	FOR li_var = 1 TO 3
		li_var2 = UpperBound(li_tipcom2) + 1
		li_tipcom2[li_var2] = li_var
	NEXT
end if

idwchild3.SetTransObject(sqlca)
idwchild3.retrieve(li_tipcom2[])

end event

event ue_dwnkey;dwobject		ls_col

if this.getcolumnname() = 'doco_id_referencia' then
	if key = KeyF2! then
		is_key = 'F2'
		ib_band = true
		this.post event buttonclicked(this.getrow(),1,ls_col)
	elseif key = KeyF3! then
		is_key = 'F3'
		ib_band = true
		this.post event buttonclicked(this.getrow(),1,ls_col)
	elseif key = KeyF4! then
		is_key = 'F4'
		ib_band = true
		this.post event buttonclicked(this.getrow(),1,ls_col)
	end if
end if


if keydown(keycontrol!) and keydown(keyT!) then
	choose case tab_1.SelectedTab
		case 1
			if tab_1.tabpage_2.visible = true then
				tab_1.SelectedTab = 2
			elseif tab_1.tabpage_3.visible = true then
				tab_1.SelectedTab = 3
			elseif tab_1.tabpage_4.visible = true then
				tab_1.SelectedTab = 4
			end if
		case 2
			if tab_1.tabpage_3.visible = true then
				tab_1.SelectedTab = 3
			elseif tab_1.tabpage_4.visible = true then
					tab_1.SelectedTab = 4
			elseif tab_1.tabpage_1.visible = true then
				tab_1.SelectedTab = 1
			end if
		case 3
			if tab_1.tabpage_4.visible = true then
				tab_1.SelectedTab = 4
			elseif tab_1.tabpage_1.visible = true then
					tab_1.SelectedTab = 1
			elseif tab_1.tabpage_2.visible = true then
				tab_1.SelectedTab = 2
			end if
		case 4
			if tab_1.tabpage_1.visible = true then
				tab_1.SelectedTab = 1
			elseif tab_1.tabpage_2.visible = true then
					tab_1.SelectedTab = 2
			elseif tab_1.tabpage_3.visible = true then
				tab_1.SelectedTab = 3
			end if
	end choose
end if

end event

event buttonclicked;//Búsqueda según tipo de compra
/*
string	ls_descripcion_referencia,ls_medida
Integer	li_medida
dw = this
dw.accepttext()
//tab_1.tabpage_2.dw_detalle.triggerevent("buttonclicked!")

ii_numero_tipo_compra = dw.getitemnumber(dw.getrow(),"doco_tipo_compra")

if ii_numero_tipo_compra = 2 then //Servicio
	
	is_codigo_referencia = wf_buscar_servicio()
	
	SELECT serv_descripcion  
	INTO :ls_descripcion_referencia 
	FROM craservi  
	WHERE serv_codigo = :is_codigo_referencia;
	
	if sqlca.sqlcode = -1 then
		messagebox('Error','Descripción del error: '+sqlca.sqlerrtext)
		return
	end if
	
elseif ii_numero_tipo_compra = 3 then  //Productos
	
	is_codigo_referencia = wf_buscar_producto()
	
	SELECT prod_descripcion,
			 prod_medida,
			 inamedid.medi_cantidad			 
	INTO :ls_descripcion_referencia,
		  :ls_medida,
		  :li_medida
	FROM inmprodu,
		  inamedid  	
	WHERE (prod_medida = inamedid.medi_medida) AND
			( prod_g_financiero = :str.g_financiero ) AND  
			( prod_empresa = :str.empresa ) AND  
			( prod_producto = :is_codigo_referencia );
	
	if sqlca.sqlcode = -1 then
		messagebox('Error','Descripción del error: '+sqlca.sqlerrtext)
		return
	end if

		if li_medida  = 1 then 
			this.Object.doco_cant1.Protect='1'
		else 
			this.Object.doco_cant1.Protect='0'
		end if

end if
is_descripcion = ls_descripcion_referencia
setitem(row,'doco_id_referencia',is_codigo_referencia)
setitem(row,'doco_descripcion_ref',is_descripcion)
setitem(row,'doco_unidad',is_medida)
setitem(row,'doco_board',is_parte)
setitem(row,'doco_color',is_color)
setitem(row,'doco_precio_unitario',id_costo)
setitem(row,'inamedid_medi_cantidad',li_medida)
*/
wf_busca_prod()



end event

event clicked;int	li_var,  li_var2
long  li_tipo_compra2[]
il_row =row
CHOOSE CASE is_campo
	CASE 'doco_id_referencia'
		il_row = row
	CASE 'doco_tipo_compra'
		li_tipo_compra = this.GetItemNumber(row,'doco_tipo_compra')
		this.postevent("ue_despues")
	CASE 'doco_tipo_oc' 
		this.postevent("ue_despues")
END CHOOSE

end event

event itemchanged;long				ll_contador, ll_cantidad
integer			li_sig,li_medida, li_bultos
String		ls_producto, ls_autoriza, ls_autoriza_s_n
decimal{4}		ld_costo, ld_cantidad_total_empaque, ld_peso

ib_modify = true
ib_graba_modificado_por = true

if dwo.name = 'doco_id_referencia' then
		str_parte.producto = data

	  SELECT prod_producto,		
				prod_medida,
				prod_peso,
				prod_cubicaje,
				prod_status,
				prod_definicion,
				prod_board,
				prod_color,
				prod_cod_clase_tam,
				prod_descripcion,
				prod_costo_fob,
	         a.medi_cantidad,
				prod_empaque,
				b.medi_cantidad
		INTO  :str_parte.producto,
				:str_parte.medida,
				:str_parte.peso,
				:str_parte.cubicaje,
				:str_parte.status,
				:ii_definicion,
				:str_parte.parte,
				:str_parte.color,
				:str_parte.cod_clase_tam,
				:str_parte.descripcion,
				:ld_costo,
				:str_parte.cant_unidad,
				:str_parte.empaque,
				:str_parte.cant_unidad_empaque
		FROM inmprodu, 
			  inamedid a,
			  inamedid b
		WHERE (prod_medida = a.medi_medida) AND
				(prod_empaque_um = b.medi_medida) AND
				(prod_g_financiero =:str.g_financiero) AND
				(prod_empresa = :str.empresa) AND
				(prod_producto = :data) ;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error # '+string(sqlca.sqldbcode),'No se recuperaron los datos '+&
			'de los productos. Descripción del error: '+sqlca.sqlerrtext+'.')
			return
		elseif sqlca.sqlcode = 100 then
			messagebox('Atención','Este producto no existe.',Exclamation!)
			return 1
		end if

		li_medida = str_parte.cant_unidad
		li_empaque = str_parte.empaque
	
		setitem(row,'doco_descripcion_ref',str_parte.descripcion)
		setitem(row,'doco_color',str_parte.color)
		setitem(row,'doco_board',str_parte.parte)
		setitem(row,'doco_unidad',str_parte.medida)
		setitem(row,'doco_precio_unitario',ld_costo)
		setitem(row,'inamedid_medi_cantidad',li_medida)

		if li_medida  = 1 then 
			this.Object.doco_cant1.Protect='1'
		else 
			this.Object.doco_cant1.Protect='0'
		end if
		
		this.post event rowfocuschanged(row)
end if


CHOOSE CASE dwo.name
	CASE 'doco_tipo_compra'
			setitem(row,'doco_id_referencia','')
			setitem(row,'doco_descripcion_ref','')
			setitem(row,'doco_tipo_oc','')
			ii_numero_tipo_compra = integer(data)
			li_tipo_compra = ii_numero_tipo_compra
			ii_linea = row
			this.postevent("ue_despues")
	CASE 'doco_cantidad_total'
		ll_cantidad = long(data)		
		ld_cantidad_total_empaque = (str_parte.empaque * str_parte.cant_unidad_empaque)
		if ld_cantidad_total_empaque = 0 then ld_cantidad_total_empaque = 1
		li_bultos = ( ll_cantidad * str_parte.cant_unidad ) / ld_cantidad_total_empaque
		ld_peso = str_parte.peso * li_bultos
		setitem(row,'crdordco_doco_bultos',li_bultos)
		setitem(row,'crdordco_doco_peso',ld_peso)

	CASE 'doco_tipo_oc' 
		this.postevent("ue_despues")
	CASE 'doco_precio_unitario'
		wf_calcula_costos(row)
END CHOOSE


end event

event retrieveend;Integer i

For i =1  to rowcount()
	wf_calcula_costos(i)
Next

if rowcount > 0 then
	li_tipo_compra = this.GetItemNumber(1,'doco_tipo_compra')
   this.postevent("ue_despues")
end if

end event

event dberror;if trim(sqlerrtext) <> '' then
	rollback;
end if

end event

event itemfocuschanged;string			ls_parte_si
long				ll_cantidad=0, ld_fraccion
str_detalles	str_datos
datawindow		dw1

// Gianni Araúz y Mayté Aparicio (11/05/2000)
// Abrir la ventana de desglose para el tránsito

dw1 = tab_1.tabpage_1.dw_generales

if row < 1 then return

if dwo.name = 'doco_cantidad_total' then
	if is_tipo = 'S' Then return
	str_datos.opcion = 'TRA'
	str_datos.parte = this.GetItemString(row,'doco_board')
	if len(trim(str_datos.parte)) > 0 then ls_parte_si += ' / '
	str_datos.cod_color = this.GetItemString(row,'doco_color')
	str_datos.medida = this.GetItemString(row,'doco_unidad')
	str_datos.concepto = dw1.GetItemString(dw1.GetRow(),'crtordco_toco_codigo_oc')
	str_datos.fecha = dw1.GetItemDateTime(dw1.getrow(),'toco_fecha_oc')
	str_datos.anio = dw1.GetItemNumber(dw1.getrow(),'toco_anno_oc')
	str_datos.renglon = this.GetItemNumber(row,'doco_num_renglon_oc')
	str_datos.cantidad_max = this.GetItemNumber(row,'doco_cantidad_total')
	ld_fraccion = this.GetItemNumber(row,'doco_cant1')
	if isnull(ld_fraccion) then ld_fraccion = 0
	str_datos.fraccion_max = ld_fraccion
	str_datos.unid_medida = str_datos.medida
	str_datos.producto = this.GetItemString(row,'doco_id_referencia')
	
	select medi_cantidad
	into :str_datos.med_cant
	from inamedid
	where medi_medida = :str_datos.medida;
	
	if sqlca.sqlcode = -1 then
		messagebox('Error','Descripción del error: '+sqlca.sqlerrtext)
		return
	elseif sqlca.sqlcode = 100 then
		messagebox('Atención','No se recuperó la unidad de medida en cantidad.',Exclamation!)
		return
	end if
	
	if isnull(str_datos.med_cant) or str_datos.med_cant = 0 then
		messagebox('Atención','No se ha definido la unidad de medida en cantidad.',Exclamation!)
		return
	end if
	
	openwithparm(w_cr_man_desglose_1,str_datos)
end if

end event

event constructor;ib_adicionar = true
end event

event editchanged;IF dwo.name ='doco_id_referencia' then
	il_row = row
else
	il_row = 0
end if
if len(trim(data)) > 0 and trim(data) <> '' then
	is_produc = data
else
	is_produc = ''
end if

end event

type dw_2 from datawindow within tabpage_2
boolean visible = false
integer x = 850
integer y = 556
integer width = 1769
integer height = 364
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ma_cz_costo_transito"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_3 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 4283
integer height = 1552
long backcolor = 79741120
string text = "Vista Previa"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "EditDataTabular!"
long picturemaskcolor = 553648127
string powertiptext = "Vista Previa de la Orden"
end type

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4283
integer height = 1552
long backcolor = 79741120
string text = "Listado"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Menu!"
long picturemaskcolor = 553648127
st_2 st_2
pb_2 pb_2
dw_imp_referencias dw_imp_referencias
dw_listado dw_listado
end type

on tabpage_4.create
this.st_2=create st_2
this.pb_2=create pb_2
this.dw_imp_referencias=create dw_imp_referencias
this.dw_listado=create dw_listado
this.Control[]={this.st_2,&
this.pb_2,&
this.dw_imp_referencias,&
this.dw_listado}
end on

on tabpage_4.destroy
destroy(this.st_2)
destroy(this.pb_2)
destroy(this.dw_imp_referencias)
destroy(this.dw_listado)
end on

type st_2 from statictext within tabpage_4
integer x = 2510
integer y = 1460
integer width = 704
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
long backcolor = 67108864
string text = "Referencias para Fotografías"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_2 from picturebutton within tabpage_4
integer x = 2395
integer y = 1444
integer width = 110
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
boolean underline = true
string pointer = "HyperLink!"
string picturename = "Print!"
string powertiptext = "Referencias para Fotografías"
end type

event clicked;//tab_1.tabpage_4.dw_listado.visible = false
tab_1.tabpage_4.dw_imp_referencias.visible = true
tab_1.tabpage_4.dw_imp_referencias.retrieve(str.g_financiero,str.empresa,is_numero_oc,il_year)
tab_1.tabpage_4.dw_imp_referencias.Object.Datawindow.print.preview = 'yes'
tab_1.tabpage_4.dw_imp_referencias.Object.DataWindow.Zoom = 80

OpenWithParm(w_dw_print_options, tab_1.tabpage_4.dw_imp_referencias)
If Message.DoubleParm = -1 Then Return
tab_1.tabpage_4.dw_imp_referencias.Print(True)

end event

type dw_imp_referencias from datawindow within tabpage_4
boolean visible = false
integer x = 14
integer y = 16
integer width = 3195
integer height = 1100
integer taborder = 40
boolean titlebar = true
string dataobject = "dw_re_cz_tran_sin_detalle_2"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_listado from datawindow within tabpage_4
integer x = 27
integer y = 28
integer width = 4160
integer height = 1372
integer taborder = 30
string dataobject = "dw_re_cz_tran_sin_detalle"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//This.SelectRow(0, FALSE)
//This.SelectRow(row, TRUE)
//This.ScrollToRow(row)
//
//string ls_objeto
//
//ls_objeto = This.GetObjectAtPointer()
//integer li_pos 
//li_pos 	 =  Pos(ls_objeto, "~t")
//ls_objeto = Left(ls_objeto, li_pos - 1)
//if right(ls_objeto,2)='_t' then
//	ls_objeto = left(ls_objeto,len(ls_objeto)-2)
//	this.SetSort(ls_objeto)
//	this.sort()
//end if
//this.groupcalc()


end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4283
integer height = 1552
long backcolor = 134217744
string text = "Contabilidad"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Custom081!"
long picturemaskcolor = 536870912
dw_10 dw_10
dw_9 dw_9
end type

on tabpage_5.create
this.dw_10=create dw_10
this.dw_9=create dw_9
this.Control[]={this.dw_10,&
this.dw_9}
end on

on tabpage_5.destroy
destroy(this.dw_10)
destroy(this.dw_9)
end on

type dw_10 from datawindow within tabpage_5
boolean visible = false
integer width = 3493
integer height = 1484
integer taborder = 90
boolean titlebar = true
string title = "Impresion del Asiento de la Entrada"
string dataobject = "dw_imprimir_conta_tempo"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_9 from datawindow within tabpage_5
integer y = -4
integer width = 3561
integer height = 1560
integer taborder = 40
string title = "none"
string dataobject = "dw_detalle_contable"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;Integer li_registros,i, li_ann
string	ls_mascara, ls_cuenta_compras, ls_detalle, ls_cuenta_cxp, ls_fac, ls_oc, ls_masca, ls_dmce
long ll_entrada, ll_tercero, ll_referencia_contable
decimal{2} ld_monto, ld_balance
datetime ldt_fecha
		if tab_1.tabpage_2.dw_detalle.rowcount() = 0 then return
		ll_entrada = tab_1.tabpage_1.dw_generales.getitemnumber(1,'crtordco_toco_entrada_inv')
		if isnull(ll_entrada) then ll_entrada = 0		
		ls_dmce	  = tab_1.tabpage_1.dw_generales.getitemstring(1,'toco_no_dmce')
		if isnull(ls_dmce) then ls_dmce = ''
		ld_monto  =   tab_1.tabpage_2.dw_detalle.getitemnumber(1,'t_final')
		ll_tercero  = tab_1.tabpage_1.dw_generales.getitemnumber(1,'toco_num_prove')
		ls_fac = tab_1.tabpage_1.dw_generales.getitemstring(1,'toco_factura_proveedor')
		ls_detalle  = 'Entrada: '+string(ll_entrada)+' - No. DMCE: '+ls_dmce+ ' - Factura: '+ls_fac
		ll_referencia_contable = tab_1.tabpage_1.dw_generales.getitemnumber(1,'toco_referencia_contable')
choose case dwo.name
	case 'b_imprimir'
		ldt_fecha	 = tab_1.tabpage_1.dw_generales.getitemdatetime(1,'toco_fecha_oc')
		li_ann = year(date(ldt_fecha))		
		if tab_1.tabpage_5.dw_10.retrieve(str.g_financiero, str.empresa, li_ann, ll_referencia_contable) > 0 then
			ls_masca = gf_mascara()
			tab_1.tabpage_5.dw_10.MODIFY("ddia_mg_cuenta.editmask.mask='"+ls_masca+"'") //mascara para el compute de la cuenta			
			 tab_1.tabpage_5.dw_10.visible = true
			  tab_1.tabpage_5.dw_10.Object.datawindow.print.preview = true			 
			OpenWithParm(w_dw_print_options,  tab_1.tabpage_5.dw_10)
			If Message.DoubleParm = -1 Then Return
			 tab_1.tabpage_5.dw_10.Print(True)			
		end if
	case 'b_adicionar'
			idw_9.scrolltorow(idw_9.insertrow(0))			
			ldt_fecha	 = tab_1.tabpage_1.dw_generales.getitemdatetime(1,'toco_fecha_oc')
			li_ann = year(date(ldt_fecha))					
			idw_9.setitem(idw_9.getrow(),'naturaleza','C')
			idw_9.setitem(idw_9.getrow(),'ddia_linea',idw_9.getrow())
			idw_9.setitem(idw_9.getrow(),'ddia_ann',li_ann)					
			idw_9.setitem(idw_9.getrow(),'ddia_g_financiero',str.g_financiero)
			idw_9.setitem(idw_9.getrow(),'ddia_empresa',str.empresa)			
			idw_9.setitem(idw_9.getrow(),'ddia_aplicacion_mg','IN')			
			idw_9.setitem(idw_9.getrow(),'ddia_tipo_transaccion','EN')			
			idw_9.setitem(idw_9.getrow(),'ddia_sub_trans','CR')
			idw_9.setitem(idw_9.getrow(),'ddia_id',str.usuario)			
			idw_9.setitem(idw_9.getrow(),'ddia_fecha',ldt_fecha)		
			idw_9.setitem(idw_9.getrow(),'ddia_tercero',ll_tercero)		
			idw_9.setitem(idw_9.getrow(),'ddia_documento_anexo',ll_entrada)		
			idw_9.setitem(idw_9.getrow(),'ddia_comentario_detalle',ls_detalle)		
			idw_9.setitem(idw_9.getrow(),'ddia_identificacion','1')
			idw_9.setitem(idw_9.getrow(),'ddia_no_referencia',ll_referencia_contable)	
			idw_9.setitem(idw_9.getrow(),'ddia_monto', 0)			
	case 'b_grabar'
		ld_balance = this.getitemnumber(1,'balance')
		if ld_balance <> 0 then
			gf_mensaje('','Debe Balancear la Transaccion antes de Guardar, Verifique !!!',1,1,'E')
			return
		end if
		wf_registra_asiento(ll_entrada,  ls_detalle)
		if this.update() = -1 then
			gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
			return
		end if
	case 'b_eliminar'
		if this.getrow() > 2 then this.deleterow(this.getrow())
	case 'b_eliminar_asiento'
		if gf_mensaje('','Esta Seguro de Eliminar el Asiento Completo ?',2,1,'E') = 2 then return
		ll_referencia_contable = tab_1.tabpage_1.dw_generales.getitemnumber(1,'toco_referencia_contable')
		ls_oc = tab_1.tabpage_1.dw_generales.getitemstring(1,'crtordco_toco_codigo_oc')		
		  DELETE FROM coddiari  
			WHERE ( coddiari.ddia_g_financiero = :str.g_financiero ) AND  
					( coddiari.ddia_empresa = :str.empresa ) AND  
					( coddiari.ddia_aplicacion_mg = 'IN' ) AND  
					( coddiari.ddia_tipo_transaccion = 'EN' ) AND  
					( coddiari.ddia_sub_trans = 'CR' ) AND  
					( coddiari.ddia_no_referencia = :ll_referencia_contable ) AND  
					( coddiari.ddia_identificacion = '1' )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Eliminar Detalle Contable '+sqlca.sqlerrtext,1,1,'E')
					return
				end if
		  DELETE FROM cotdiari  
			WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
					( cotdiari.diar_empresa = :str.empresa ) AND  
					( cotdiari.diar_aplicacion_mg = 'IN' ) AND  
					( cotdiari.diar_tipo_transaccion = 'EN' ) AND  
					( cotdiari.diar_sub_trans = 'CR' ) AND  
					( cotdiari.diar_no_referencia = :ll_referencia_contable ) AND  
					( cotdiari.diar_identificacion = '1' )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Eliminar Encabezado Contable '+sqlca.sqlerrtext,1,1,'E')
					return
				end if
				
				  UPDATE crtordco  
					  SET toco_referencia_contable = 0  
					WHERE ( crtordco.toco_g_financiero = :str.g_financiero ) AND  
							( crtordco.toco_empresa = :str.empresa ) AND  
							( crtordco.toco_codigo_oc = :ls_oc ) AND  
							( crtordco.toco_anno_oc = :ii_an )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Actualizar Encabezado Transito '+sqlca.sqlerrtext,1,1,'E')
					return
				end if
				
		tab_1.tabpage_1.dw_generales.setitem(1,'toco_referencia_contable',0)		
				
		commit;
		idw_9.reset()
end choose
end event

event itemchanged;accepttext()
string ls_columna, ls_cuenta, ls_transito, ls_descrip, ls_cargado_a
integer li_encontro
long ll_tercero, ll_pos
decimal{2} ld_balance
ls_columna = this.getcolumnname()

choose case ls_columna
	case 'monto_debito'
			this.setitem(row,'monto_credito',0)
			this.setitem(row,'naturaleza','D')
			if double(data) < 0 then
				gf_mensaje('','No se permiten valores en negativo, Verifique !!!',1,1,'E')
				this.setcolumn('monto_debito')
				this.setitem(row,'monto_debito', abs(double(data)))
				return 2
			end if
			this.setitem(row,'ddia_monto', abs(double(data)))			
	case 'monto_credito'
			this.setitem(row,'monto_debito',0)
			this.setitem(row,'naturaleza','C')		
			if double(data) < 0 then
				gf_mensaje('','No se permiten valores en negativo, Verifique !!!',1,1,'E')
				this.setcolumn('monto_credito')
				this.setitem(row,'monto_credito', abs(double(data)))
				return 2
			end if			
			this.setitem(row,'ddia_monto', abs(double(data)))
	case 'cuenta'
		ls_cuenta = this.getitemstring(this.getrow(),'cuenta')
		ls_cuenta = left( ls_cuenta + fill("0",20) ,20)
		li_encontro = idwc_plan.find("mg_cuenta = '"+ls_cuenta+"'",1,idwc_plan.rowcount())
		if li_encontro > 0 then
			this.setitem(this.getrow(),'ddia_mg_cuenta',ls_cuenta)
		else
			gf_mensaje('','Cuenta no Existe, Verifique !!!',1,1,'E')
			this.setitem(this.getrow(),'cuenta','')
			this.setitem(this.getrow(),'ddia_mg_cuenta','')
			return 2
		end if
		ld_balance = abs(this.getitemnumber(1,'balance'))
		if this.getitemstring(this.getrow(),'naturaleza') = 'D' then
			this.setcolumn('monto_debito')
			if this.getitemnumber(this.getrow(),'monto_debito') = 0 then 
				this.setitem(this.getrow(),'monto_debito',ld_balance)
				this.accepttext()
			end if
		else
			this.setcolumn('monto_credito')			
			if this.getitemnumber(this.getrow(),'monto_credito') = 0 then 
				this.setitem(this.getrow(),'monto_credito',ld_balance)			
				this.accepttext()
			end if
		end if
		this.setitem(this.getrow(),'ddia_monto', ld_balance)			
	case 'ddia_mg_cuenta'
		ls_cuenta = this.getitemstring(this.getrow(),'ddia_mg_cuenta')
		ls_cuenta = left( ls_cuenta + fill("0",20) ,20)
		this.setitem(this.getrow(),'cuenta',ls_cuenta)	
		if this.getitemstring(this.getrow(),'naturaleza') = 'D' then
			this.setcolumn('monto_debito')
			if this.getitemnumber(this.getrow(),'monto_debito') = 0 then 
				this.setitem(this.getrow(),'monto_debito',ld_balance)
				this.accepttext()
			end if
		else
			this.setcolumn('monto_credito')			
			if this.getitemnumber(this.getrow(),'monto_credito') = 0 then 
				this.setitem(this.getrow(),'monto_credito',ld_balance)			
				this.accepttext()
			end if
		end if
		
end choose


end event

event itemfocuschanged;this.SelectText( 1, 99) 
end event

type st_microhelp from statictext within w_cz_ma_transito
boolean visible = false
integer x = 1065
integer y = 1596
integer width = 416
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
string text = "Haga Dobleclick"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_cz_ma_transito
integer x = 2281
integer y = 1744
integer width = 1038
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
boolean underline = true
string text = "Confirmaciones de Ordenes de Compra"
end type

event clicked;integer li_ann
li_ann = tab_1.tabpage_1.dw_generales.getitemnumber(1,'toco_anno_oc')
lstr_pase.anno = li_ann
int ll_open
 OpenWithParm(w_pases_confirmacion,lstr_pase)
//OpenSheetWithparm(w_pases_confirmacion,lstr_pase,Parent,0, Original!)	
//messagebox('',string(ll_open))
lstr_pase_devuelto = message.PowerObjectParm

if not isvalid(lstr_pase_devuelto) then return

if trim(lstr_pase_devuelto.orden) = '' or isnull(lstr_pase_devuelto.orden)  then return

if tab_1.tabpage_1.dw_generales.retrieve(str.g_financiero,str.empresa,lstr_pase_devuelto.orden,lstr_pase_devuelto.anno,is_numero_sup) > 0 then
	tab_1.tabpage_2.dw_detalle.retrieve(str.g_financiero,str.empresa,lstr_pase_devuelto.orden,lstr_pase_devuelto.anno) //,is_numero_sup)
	ib_graba_modificado_por = false
end if

end event

type cb_1 from commandbutton within w_cz_ma_transito
integer x = 1449
integer y = 1744
integer width = 366
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
string text = "P&roductos"
end type

event clicked;OpenSheet(w_in_ma_prod_reducido_comp,parent,4,Original!)
end event

type cb_2 from commandbutton within w_cz_ma_transito
integer x = 1865
integer y = 1744
integer width = 366
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
string text = "Prov&eedores"
end type

event clicked;OpenSheet(w_cr_proveedores,parent,4,Original!)
end event

type st_1 from statictext within w_cz_ma_transito
integer x = 1435
integer y = 1732
integer width = 393
integer height = 112
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_3 from statictext within w_cz_ma_transito
integer x = 1851
integer y = 1732
integer width = 393
integer height = 112
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_5 from statictext within w_cz_ma_transito
integer x = 2267
integer y = 1732
integer width = 1065
integer height = 112
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_continuar from commandbutton within w_cz_ma_transito
integer x = 1778
integer y = 12
integer width = 306
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;If tab_1.tabpage_2.dw_detalle.rowcount() >0 then
	Integer	li_anio
	String	ls_oord_compra
	str_formato.cancel_sino = false
	
	ls_oord_compra = tab_1.tabpage_1.dw_generales.getitemstring(1,'crtordco_toco_codigo_oc')
	li_anio 			= tab_1.tabpage_1.dw_generales.getitemNumber(1,'toco_anno_oc')
	
	//w_cr_compras_unif.Dynamic wf_devuelve_llave(ls_oord_compra,'0',li_anio,false,0,'transito')
	close(parent)
else
	messagebox('Atención ','El documento seleccionado no tiene detalle ....!')	
	cb_cancelar.setfocus()
end if
end event

type cb_cancelar from commandbutton within w_cz_ma_transito
integer x = 2167
integer y = 12
integer width = 306
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
boolean underline = true
string text = "Cancelar"
end type

event clicked;str_formato.cancel_sino = true
//w_cr_compras_unif.Dynamic wf_devuelve_llave('','',0,str_formato.cancel_sino,0,'transito')
close(parent)

//If tab_1.tabpage_2.dw_detalle.rowcount() >0 then
//	w_cr_compras_unif.Dynamic wf_devuelve_llave(str_formato.num_oc_tran,'0',str_formato.anio_oc_tran,str_formato.cancel_sino,0,'transito')
//	close(parent)
//else
//	w_cr_compras_unif.Dynamic wf_devuelve_llave('','',0,str_formato.cancel_sino,0,'compras')
//	close(parent)
//end if

end event

type dw_6 from datawindow within w_cz_ma_transito
boolean visible = false
integer x = 425
integer y = 260
integer width = 2784
integer height = 1620
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Reporte de Transito de Muestras"
string dataobject = "dw_reporte_transito_muestras"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "Form!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_cz_ma_transito
integer x = 2907
integer width = 434
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Discrepancias"
end type

event clicked;if tab_1.tabpage_1.dw_8.retrieve(str.g_financiero,str.empresa,is_numero_oc,il_year) > 0 then
	tab_1.tabpage_1.dw_8.visible = true
	OpenWithParm(w_dw_print_options, 	tab_1.tabpage_1.dw_8)
	If Message.DoubleParm = -1 Then Return
		tab_1.tabpage_1.dw_8.Print(True)
end if
end event

type st_ayuda from w_fa_padre`st_ayuda within w_cz_ma_transito
end type

