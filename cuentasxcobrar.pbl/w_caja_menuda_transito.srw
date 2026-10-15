forward
global type w_caja_menuda_transito from w_na_padre
end type
type pb_1 from picturebutton within w_caja_menuda_transito
end type
type pb_2 from picturebutton within w_caja_menuda_transito
end type
type pb_3 from picturebutton within w_caja_menuda_transito
end type
type pb_4 from picturebutton within w_caja_menuda_transito
end type
type pb_5 from picturebutton within w_caja_menuda_transito
end type
type pb_6 from picturebutton within w_caja_menuda_transito
end type
type dw_2 from datawindow within w_caja_menuda_transito
end type
type gb_1 from groupbox within w_caja_menuda_transito
end type
type cb_1 from commandbutton within w_caja_menuda_transito
end type
type cb_2 from commandbutton within w_caja_menuda_transito
end type
end forward

global type w_caja_menuda_transito from w_na_padre
integer x = 869
integer y = 492
integer width = 2715
integer height = 2032
string title = "Desembolso de Caja Menuda"
string menuname = "m_hs"
boolean controlmenu = false
boolean maxbox = false
boolean resizable = false
long backcolor = 12639424
string icon = "Application5!"
pb_1 pb_1
pb_2 pb_2
pb_3 pb_3
pb_4 pb_4
pb_5 pb_5
pb_6 pb_6
dw_2 dw_2
gb_1 gb_1
cb_1 cb_1
cb_2 cb_2
end type
global w_caja_menuda_transito w_caja_menuda_transito

type prototypes

end prototypes

type variables
integer ii_ann, ii_paga_itbms
str_dg_general str_parametro

datawindowchild dwc_cuenta, dwc_class, dwc_tercero

boolean  ib_adiciono_nuevo
end variables

forward prototypes
public function string wf_busqueda_fee ()
public function integer wf_verifica_reg_excluido ()
public subroutine wf_max_secuen ()
public function integer wf_elimina_voucher ()
public function integer wf_graba_auxiliar ()
public function boolean wf_calcula_itbm ()
end prototypes

public function string wf_busqueda_fee ();integer li_existe, li_ann, li_opcion
string ls_max, ls_coti, ls_param, ls_existe, ls_error
long ll_param,ll_max

li_ann = year(date(gf_fecha_serv()))
ii_ann = year(date(gf_fecha_serv()))

  SELECT nmparam.para_ult_desembolso  
    INTO :ls_param  
    FROM nmparam  
   WHERE ( nmparam.para_g_financiero = :str.g_financiero ) AND  
         ( nmparam.para_empresa = :str.empresa )   ;
	if sqlca.sqlcode = -1 then
		rollback;
		mensaje("Información wf_busca","Error al Seleccionar de registros en nmparam",sqlca.sqlerrtext)
		return '-1'
	end if

ll_param = long(ls_param) + 1
ls_param = string(ll_param)

  SELECT ntdesem.desem_desembolso
    INTO :ls_existe  
    FROM ntdesem  
   WHERE ( ntdesem.desem_g_financiero = :str.g_financiero ) AND  
         ( ntdesem.desem_empresa = :str.empresa ) AND  
         ( ntdesem.desem_desembolso = :ls_param  ) AND  
         ( ntdesem.desem_ann = :li_ann  )   ;
	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje("Información wf_busca","Error al Seleccionar de registros en natafee", ls_error)
		return '-1'
	end if
	
if isnull(ls_existe) then ls_existe = ''

if ls_existe <> '' then
	ll_max = ll_param
	DO
		ll_max = ll_max + 1
		ls_max = string(ll_max)
	
	  SELECT count(*) 
		 INTO :li_existe  
		 FROM ntdesem  
		WHERE ( ntdesem.desem_g_financiero = :str.g_financiero ) AND  
				( ntdesem.desem_empresa = :str.empresa ) AND  
				( ntdesem.desem_desembolso = :ls_max  ) AND  
				( ntdesem.desem_ann = :li_ann  )   ;
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Información wf_busca","Error al Seleccionar de registros en natafee",ls_error)
				return '-1'
			end if

	LOOP UNTIL li_existe = 0

	dw_1.setitem(dw_1.getrow(), 'desem_desembolso', long(ls_max))
	
//	li_opcion = messagebox('Atención', 'El Siguiente Número de Factura Disponibles es el: ' + ls_max + ".~n~r ¿Desea Asignar este Número? ", Question!, YesNo!)
//
//	if li_opcion <> 1 then
//		return '-1'
//	end if

  UPDATE nmparam  
     SET para_ult_desembolso = :ls_max  
   WHERE ( nmparam.para_g_financiero = :str.g_financiero ) AND  
         ( nmparam.para_empresa = :str.empresa ) ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Información wf_busca","Error al Seleccionar de registros en nmparam",ls_error)
			return '-1'
		end if

//	messagebox('Atención', 'No. Factura ajustado al siguiente disponible.')

	return(ls_max)

else

//	li_opcion = messagebox('Atención', 'El Siguiente Número de Desembolso Disponibles es el: ' + ls_param + ".~n~r ¿Desea Asignar este Número? ", Question!, YesNo!)
//
//	if li_opcion <> 1 then
//		return '-1'
//	end if

	UPDATE nmparam
     SET para_ult_desembolso = :ls_param
   WHERE ( nmparam.para_g_financiero = :str.g_financiero ) AND  
         ( nmparam.para_empresa = :str.empresa ) ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Información wf_busca","Error al Seleccionar de registros en nmparam",ls_error)
			return '-1'
		end if

	dw_1.setitem(dw_1.getrow(), 'desem_desembolso', long(ls_param))
	return(ls_param)
end if
end function

public function integer wf_verifica_reg_excluido ();string ls_doc,ls_tran,ls_subtran,ls_transito
integer li_ann,li_excluido

li_ann = dw_1.getitemnumber(dw_1.getrow(),'desem_ann')
ls_doc = string(dw_1.getitemnumber(dw_1.getrow(),'desem_desembolso'))
ls_transito = dw_1.getitemstring(dw_1.getrow(),"desem_transito_1")

ls_tran = 'CM'
ls_subtran = 'CM'


  SELECT banadpagar.dpaga_no_cuenta  
	 INTO :li_excluido  
	 FROM banadpagar,   
			banatpagar  
	WHERE ( banatpagar.tpaga_g_financiero = banadpagar.dpaga_g_financiero ) and  
			( banatpagar.tpaga_empresa = banadpagar.dpaga_empresa ) and  
			( banatpagar.tpaga_transito = banadpagar.dpaga_transito ) and  
			( banatpagar.tpaga_documento = banadpagar.dpaga_documento ) and  

			( banatpagar.tpaga_agno = banadpagar.dpaga_agno ) and  
			( banatpagar.tpaga_aplicacion = banadpagar.dpaga_aplicacion ) and  
			( banatpagar.tpaga_transaccion = banadpagar.dpaga_transaccion ) and  
			( banatpagar.tpaga_subtransaccion = banadpagar.dpaga_subtransaccion ) and  
			( ( banadpagar.dpaga_g_financiero = :str.g_financiero ) AND  
			( banadpagar.dpaga_empresa = :str.empresa ) AND  
			( banadpagar.dpaga_transito = :ls_transito ) AND  
			( banadpagar.dpaga_documento = :ls_doc ) AND  
			( banadpagar.dpaga_agno = :li_ann ) AND  
			( banadpagar.dpaga_aplicacion = 'NA' ) AND  
			( banadpagar.dpaga_transaccion = :ls_tran ) AND  
			( banadpagar.dpaga_subtransaccion = :ls_subtran ))   ;
	if sqlca.sqlcode = -1 then
		mensaje('ERROR', 'Error al Consultar registros en BANATPAGAR.', sqlca.sqlerrtext)
		return 1
	end if
	
IF li_excluido = 1 THEN
	messagebox("Atención","No puede modificar o eliminar este registro porque el mismo está excluido en el proceso Cambio de class.&
 Debe primero habilitarlo nuevamente para entonces poder modificarlo o eliminarlo.")
	return 1
END IF

	
return 0	
end function

public subroutine wf_max_secuen ();//Busca la ultima secuencia de la caja menuda.

integer li_existe, li_ann, li_opcion
string ls_max, ls_coti, ls_param, ls_existe, ls_error
long ll_param,ll_max

dw_1.accepttext()

li_ann = year(date(dw_1.getitemdatetime(dw_1.getrow(),'desem_fecha')))
ii_ann = year(date(dw_1.getitemdatetime(dw_1.getrow(),'desem_fecha')))


SELECT max(isnull(ntdesem.desem_desembolso,0))
    INTO :ls_param
    FROM ntdesem  
   WHERE ( ntdesem.desem_g_financiero = :str.g_financiero ) AND  
         ( ntdesem.desem_empresa = :str.empresa ) AND  
         ( ntdesem.desem_ann = :li_ann  )   ;	
	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje("Información wf_max_secuen","Error al Seleccionar de registro maximo en ntdesem", ls_error)
	end if

if isnull(ls_param) then ls_param = '0'

ll_param = long(ls_param) + 1
ls_param = string(ll_param)

  SELECT ntdesem.desem_desembolso
    INTO :ls_existe  
    FROM ntdesem  
   WHERE ( ntdesem.desem_g_financiero = :str.g_financiero ) AND  
         ( ntdesem.desem_empresa = :str.empresa ) AND  
         ( ntdesem.desem_desembolso = :ll_param  ) AND  
         ( ntdesem.desem_ann = :li_ann  )   ;	
	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje("Información wf_max_secuen","Error al Seleccionar de registros en natafee", ls_error)
	end if
	
if isnull(ls_existe) then ls_existe = ''

if ls_existe <> '' then
	ll_max = ll_param
	DO
		ll_max = ll_max + 1
		ls_max = string(ll_max)
	
	  SELECT count(*) 
		 INTO :li_existe  
		 FROM ntdesem  
		WHERE ( ntdesem.desem_g_financiero = :str.g_financiero ) AND  
				( ntdesem.desem_empresa = :str.empresa ) AND  
				( ntdesem.desem_desembolso = :ll_max  ) AND  
				( ntdesem.desem_ann = :li_ann  )   ;	//Para validar que no exista la secuencia
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Información wf_max_secuen","Error al Seleccionar de registros en natafee",ls_error)
			end if

	LOOP UNTIL li_existe = 0

	dw_1.setitem(dw_1.getrow(), 'desem_desembolso', long(ls_max))
else
	dw_1.setitem(dw_1.getrow(),'desem_desembolso',long(ls_param))
end if

dw_1.setitem(dw_1.getrow(), 'desem_ann', li_ann)



end subroutine

public function integer wf_elimina_voucher ();integer li_cuenta,li_ann
string ls_doc,ls_code,ls_descrip,ls_error
long ll_tercero
datetime ldt_fecha

li_cuenta = dw_1.getitemnumber(dw_1.getrow(),"desem_cuenta")
ls_doc = string(dw_1.getitemnumber(1,'desem_desembolso'))
ls_code = dw_1.getitemstring(1,'desem_transito')
ll_tercero = dw_1.getitemnumber(1,'desem_tercero')
ldt_fecha = dw_1.getitemdatetime(1,'desem_fecha')
li_ann = year(date(ldt_fecha))


IF li_cuenta = 1 THEN
	DELETE FROM banadpagar  
	WHERE ( banadpagar.dpaga_g_financiero = :str.g_financiero ) AND  
			( banadpagar.dpaga_empresa = :str.empresa ) AND  
			( banadpagar.dpaga_aplicacion = 'NA' ) AND  
			( banadpagar.dpaga_transaccion = 'CM' ) AND  
			( banadpagar.dpaga_subtransaccion = 'CM' ) AND  
			( banadpagar.dpaga_documento = :ls_doc ) AND  
			( banadpagar.dpaga_agno = :li_ann ) AND
			( banadpagar.dpaga_transito = :ls_code ) ;
	
	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		sqlca.autocommit = true
		mensaje('ERROR', 'Error al Elimnar registros en BANADPAGAR.', ls_error)
		return 1
	end if
	
	DELETE FROM banatpagar    
	WHERE ( banatpagar.tpaga_g_financiero = :str.g_financiero ) AND  
			( banatpagar.tpaga_empresa = :str.empresa ) AND  
			( banatpagar.tpaga_aplicacion = 'NA' ) AND  
			( banatpagar.tpaga_transaccion = 'CM' ) AND  
			( banatpagar.tpaga_subtransaccion = 'CM' ) AND  
			( banatpagar.tpaga_documento = :ls_doc ) AND  
			( banatpagar.tpaga_agno = :li_ann ) AND
			( banatpagar.tpaga_transito = :ls_code ) ;
	
	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		sqlca.autocommit = true
		mensaje('ERROR', 'Error al Elimnar registros en BANATPAGAR.', ls_error)
		return 1
	end if	
	
ELSEIF li_cuenta = 2 THEN
	DELETE FROM cctmovim 
	WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
			( cctmovim.movi_empresa = :str.empresa ) AND  
			( cctmovim.movi_aplicacion = 'NA' ) AND  
			( cctmovim.movi_tipo_transaccion = 'NB' ) AND  
			( cctmovim.movi_sub_transaccion = 'NB' ) AND  
			( cctmovim.movi_documento = :ls_doc ) AND  
			( cctmovim.movi_anno = :li_ann ) AND
			( cctmovim.movi_referencia = :ls_doc );
	
	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		sqlca.autocommit = true
		mensaje('ERROR', 'Error al Elimnar registros en CCTMOVIM.', ls_error)
		return 1
	end if
	

END IF

return 0 
end function

public function integer wf_graba_auxiliar ();long ll_tercero
integer li_ann
string ls_error, ls_tran2, ls_tran, ls_sub, ls_doc, ls_code, ls_class, ls_cargado, &
		 ls_caja, ls_descrip_class, ls_desc, ls_paid_to,ls_fecha, ls_sort,ls_ruc,ls_estado, ls_descripcion_corta
string ls_descripcion,ls_naturaleza,ls_transito,ls_voucher,ls_trans_ant,ls_no_caso,ls_desc_class
datetime ldt_fecha, ldt_actual
decimal ldc_monto_t

li_ann = dw_1.getitemnumber(1,'desem_ann')
ldc_monto_t = dw_1.getitemdecimal(1,'desem_monto')
ldt_actual = gf_fecha_serv()
ldt_fecha = dw_1.getitemdatetime(1,'desem_fecha')
ls_doc = string(dw_1.getitemnumber(1,'desem_desembolso'))
ls_cargado = dw_1.getitemstring(1,'desem_cargado_a')
ls_class = dw_1.getitemstring(1,'desem_class')
ls_code = dw_1.getitemstring(1,'desem_transito')
ls_paid_to = dw_1.getitemstring(1,'desem_pagado_a')
ll_tercero = dw_1.getitemnumber(1,'desem_tercero')
ls_descripcion = dw_1.getitemstring(1,'desem_descripcion')
ls_descripcion_corta = mid(ls_descripcion,1,250)
ls_no_caso = dw_1.getitemstring(1,'desem_no_caso')

SELECT nmparam.para_tran_caja
  INTO :ls_tran2
  FROM nmparam  
 WHERE ( nmparam.para_g_financiero = :str.g_financiero ) AND  
		 ( nmparam.para_empresa = :str.empresa )   ;
if sqlca.sqlcode = -1 then
	ls_error = sqlca.sqlerrtext
	rollback;
	sqlca.autocommit = true
	mensaje('ERROR', 'Error al Consultar registros en nmparam.', ls_error)
	return 1
end if

ls_tran = left(ls_tran2, 2)

if len(ls_tran2) = 4 then
	ls_sub = right(ls_tran2, 2)
elseif len(ls_tran2) = 5 then
	ls_sub = right(ls_tran2, 3)
elseif len(ls_tran2) = 3 then
	ls_sub = right(ls_tran2, 1)
end if

if dw_1.getitemnumber(1,'desem_cuenta',Primary!,true) = 1 then
	ls_trans_ant = dw_1.getitemstring(1,'desem_transito',Primary!,true)
	DELETE FROM banadpagar  
   WHERE ( banadpagar.dpaga_g_financiero = :str.g_financiero ) AND  
         ( banadpagar.dpaga_empresa = :str.empresa ) AND  
         ( banadpagar.dpaga_transito = :ls_trans_ant ) AND  
         ( banadpagar.dpaga_documento = :ls_doc ) AND  
         ( banadpagar.dpaga_agno = :li_ann ) AND  
         ( banadpagar.dpaga_aplicacion = 'NA' ) AND  
         ( banadpagar.dpaga_transaccion = :ls_tran ) AND  
         ( banadpagar.dpaga_subtransaccion = :ls_sub )  ;
			
	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		sqlca.autocommit = true
		mensaje("Atención ","¡Error al Insertar BANADPAGAR!", ls_error)		
		return 1
	end if
	
	DELETE FROM banatpagar  
   WHERE ( banatpagar.tpaga_g_financiero = :str.g_financiero ) AND  
         ( banatpagar.tpaga_empresa = :str.empresa ) AND  
         ( banatpagar.tpaga_transito = :ls_trans_ant ) AND  
         ( banatpagar.tpaga_documento = :ls_doc ) AND  
         ( banatpagar.tpaga_agno = :li_ann ) AND  
         ( banatpagar.tpaga_aplicacion = 'NA' ) AND  
         ( banatpagar.tpaga_transaccion = :ls_tran ) AND  
         ( banatpagar.tpaga_subtransaccion = :ls_sub )   ;
			
	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		sqlca.autocommit = true
		mensaje("Atención ","¡Error al Insertar BANATPAGAR!", ls_error)		
		return 1
	end if
elseif dw_1.getitemnumber(1,'desem_cuenta',Primary!,true) = 2 then
	DELETE FROM cctmovim  
   WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
         ( cctmovim.movi_empresa = :str.empresa ) AND  
         ( cctmovim.movi_aplicacion = 'NA' ) AND  
         ( cctmovim.movi_tipo_transaccion = 'NB' ) AND  
         ( cctmovim.movi_sub_transaccion = 'NB' ) AND  
         ( cctmovim.movi_documento = :ls_doc ) AND  
         ( cctmovim.movi_anno = :li_ann ) AND  
         ( cctmovim.movi_referencia = :ls_doc ) AND  
         ( cctmovim.movi_transaccion_origen = :ls_tran )  ;

	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		sqlca.autocommit = true
		mensaje('ERROR', 'Error al Insertar registros en CCTMOVIM1.', ls_error)
		return 1
	end if

end if 

	
if dw_1.getitemnumber(1,'desem_cuenta') = 1 then //CXC DEL BARCO
	INSERT INTO banatpagar  
				( tpaga_g_financiero,tpaga_empresa,tpaga_transito,tpaga_documento,tpaga_agno,   
				  tpaga_aplicacion,tpaga_transaccion,tpaga_subtransaccion,tpaga_monto_total,   
				  tpaga_usuario,tpaga_fecha,tpaga_referencia,tpaga_naturaleza,tpaga_fecha_voucher)  
	  VALUES ( :str.g_financiero,:str.empresa,:ls_code,:ls_doc,:li_ann,   
				  'NA',:ls_tran,:ls_sub,:ldc_monto_t,   
				  :str.usuario,:ldt_fecha,'','D',:ldt_fecha)  ;
			  
	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		sqlca.autocommit = true
		mensaje("Atención ","¡Error al Insertar BANATPAGAR!", ls_error)		
		return 1
	end if
		
  SELECT ncargos.carg_descripcion  
	 INTO :ls_descrip_class  
	 FROM ncargos  
	WHERE ( ncargos.carg_cargo = :ls_class ) ;
	
	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		sqlca.autocommit = true
		mensaje("Atención ","¡Error al Seleccionar Descripción del Class!", ls_error)
		return 1
	end if

	INSERT INTO banadpagar  
				( dpaga_g_financiero,dpaga_empresa,dpaga_transito,dpaga_documento,   
				  dpaga_agno,dpaga_aplicacion,dpaga_transaccion,dpaga_subtransaccion,   
				  dpaga_cargo,dpaga_descripcion_cargo,dpaga_linea,dpaga_monto,
				  dpaga_fecha,dpaga_no_cuenta,dpaga_cargado_a,dpaga_referencia,dpaga_fecha_voucher )  
	  VALUES ( :str.g_financiero,:str.empresa,:ls_code,:ls_doc,
				  :li_ann,'NA',:ls_tran,:ls_sub,
				  :ls_class,:ls_descrip_class,1,:ldc_monto_t,   
				  :ldt_fecha,0,:ls_cargado,'',:ldt_fecha)  ;
			  
	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		sqlca.autocommit = true
		mensaje("informacion","Error al Insertar!",ls_error)		
		return 1
	end if
					
elseif dw_1.getitemnumber(1,'desem_cuenta') = 2 then //CXC DEL CLIENTE
	SELECT ccmclien.clie_ruc_tercero  
	  INTO :ls_ruc
	  FROM ccmclien  
	 WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
			 ( ccmclien.clie_empresa = :str.empresa ) AND  
			 ( ccmclien.clie_tercero = :ll_tercero )   ;
			 
	IF sqlca.sqlcode = -1 THEN
		rollback;
		sqlca.autocommit = true
		messagebox("Atención","Hubo un error al seleccionar en ccmclien.")
		return 1			
	END IF

	ls_naturaleza = 'D'
	INSERT INTO cctmovim  
				( movi_g_financiero,movi_empresa,movi_aplicacion,movi_tipo_transaccion,movi_sub_transaccion,   
				  movi_documento,movi_anno,movi_referencia,movi_tercero,movi_ruc_tercero,movi_naturaleza,   
				  movi_monto,movi_fecha_tran,movi_fecha_reg,movi_usuario,movi_estado,movi_fecha_vence, 
				  movi_comentario,movi_afiliada,movi_cierre_mensual,movi_estado_pase_conta,
				  movi_deposito,movi_cant_depo_ante,movi_saldo,movi_tran_contado,
				  movi_impreso,movi_comision_pagada,movi_transaccion_origen, movi_comments)
	  VALUES ( :str.g_financiero,:str.empresa,'NA','NB','NB',
				  :ls_doc,:li_ann,:ls_doc,:ll_tercero,:ls_ruc,:ls_naturaleza,
				  :ldc_monto_t,:ldt_fecha,:ldt_actual,:str.usuario,'IM',:ldt_fecha,
				  :ls_descripcion,'0','N','E',0,0,:ldc_monto_t,'N',
				  'N','N','CM', :ls_descripcion_corta)  ;
				  
	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		sqlca.autocommit = true
		mensaje('ERROR', 'Error al Insertar registros en CCTMOVIM1.', ls_error)
		return 1
	end if
	
end if	

return 0
end function

public function boolean wf_calcula_itbm ();decimal{2} ld_valor = 0, ld_monto
if isnull(ii_paga_itbms) then ii_paga_itbms = 0
if ii_paga_itbms = 0 then
	if dw_1.rowcount() > 0 then
		dw_1.setitem(1,'desem_valor_itbm',0)
		dw_1.setitem(1,'desem_monto_final',0)
	end if
else
	if dw_1.rowcount() > 0 then
		ld_monto = dw_1.getitemnumber(1,'desem_monto')
		ld_valor   = round(ld_monto * str.valor_itbm,2)
		dw_1.setitem(1,'desem_valor_itbm',ld_valor)
		dw_1.setitem(1,'desem_monto_final',ld_monto + ld_valor)
	end if			
end if

return true

end function

on w_caja_menuda_transito.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.pb_1=create pb_1
this.pb_2=create pb_2
this.pb_3=create pb_3
this.pb_4=create pb_4
this.pb_5=create pb_5
this.pb_6=create pb_6
this.dw_2=create dw_2
this.gb_1=create gb_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.pb_3
this.Control[iCurrent+4]=this.pb_4
this.Control[iCurrent+5]=this.pb_5
this.Control[iCurrent+6]=this.pb_6
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.cb_2
end on

on w_caja_menuda_transito.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.pb_3)
destroy(this.pb_4)
destroy(this.pb_5)
destroy(this.pb_6)
destroy(this.dw_2)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event ue_post_open;call super::ue_post_open;datawindowchild ldwc_no_caso, ldwc_barco



ii_ann = year(date(gf_fecha_serv()))

//m_na_padre.m_edicin.m_insertar.visible = false
//m_na_padre.m_edicin.m_insertar.toolbaritemvisible=false
//if not isvalid(m_fa_principal) then &
//	this.changemenu(m_fa_principal)
//m_fa_principal.m_edicin.m_busqueda.ToolbarItemVisible  = true
//m_fa_principal.m_edicin.m_busqueda.enabled  = true

dw_1.getchild('desem_cuenta_mg', dwc_cuenta)
dwc_cuenta.settransobject(sqlca)
dwc_cuenta.retrieve(str.g_financiero, str.empresa)

dw_1.getchild('desem_tercero', dwc_tercero)
dwc_tercero.settransobject(sqlca)
dwc_tercero.retrieve(str.g_financiero, str.empresa)
dwc_tercero.insertrow(1)

//dw_1.getchild('desem_transito',ldwc_barco)
//ldwc_barco.settransobject(sqlca)
//if ldwc_barco.retrieve(str.g_financiero, str.empresa) = 0 then
//	ldwc_barco.insertrow(1)
//end if

dw_1.getchild('desem_class', dwc_class)
dwc_class.settransobject(sqlca)
dwc_class.retrieve()

//dw_1.getchild('desem_no_caso', ldwc_no_caso)
//ldwc_no_caso.settransobject(sqlca)
//IF ldwc_no_caso.retrieve(str.g_financiero, str.empresa) = 0 THEN
//	ldwc_no_caso.insertrow(0)
//END IF
//
//dw_1.getchild('desem_no_caso_1', ldwc_no_caso)
//ldwc_no_caso.settransobject(sqlca)
//ldwc_no_caso.retrieve(str.g_financiero, str.empresa)
//ldwc_no_caso.insertrow(0)

	dw_1.object.desem_tercero.protect = '1'
		pb_4.enabled =  true
		
		dw_1.Modify ( "desem_transito.Background.Color='80269524'" )
		dw_1.Modify ( "desem_transito_1.Background.Color='80269524'" )
		dw_1.Modify ( "ann.Background.Color='80269524'" )
		dw_1.Modify ( "desem_class.Background.Color='80269524'" ) 
		dw_1.Modify ( "desem_tercero.Background.Color='80269524'" ) 
		
		pb_3.enabled = false
		pb_5.enabled = false


this.triggerevent('ue_adicionar')
end event

event key;//override

end event

event resize;//gb_1.width  = this.width  - 100
//gb_1.height = this.height - 220
end event

event ue_aceptar;//override
long ll_update, ll_count,ll_tercero,ll_tercero_2,ll_cliente
string ls_titulo, ls_error, ls_codigo, ls_desc, ls_fee, ls_caja, ls_estado,ls_retorno
string ls_no_caso,ls_cuenta_mg
integer li_cuenta,li_wording
decimal ld_monto
datetime ldt_fecha_tran,ldt_fecha_restriccion,ldt_fecha_actual

setnull(str_parametro.variable1)	//Caja
setnull(str_parametro.numero1)	//desembolso 1
setnull(str_parametro.numero2)	//desembolso 2
setnull(str_parametro.numero3)	//año

ldt_fecha_actual = gf_fecha_serv()

//Se asigna la secuencia al momento de guardar, para evitar que los usuarios se dupliquen
if ib_adiciono_nuevo then
	wf_max_secuen()
end if

dw_1.accepttext() 

ls_caja = dw_1.getitemstring(dw_1.getrow(),"desem_caja")
IF isnull(ls_caja) or ls_caja = "" THEN
	messagebox("Atención Sr. Usuario","No puede grabar un Voucher con la caja en blanco.")
	return
END IF

li_cuenta = dw_1.getitemnumber(dw_1.getrow(),"desem_cuenta")

li_wording = dw_1.getitemnumber(dw_1.getrow(),"desem_wording")
IF (isnull(li_wording) or li_wording = 0) and (li_cuenta <> 3 and li_cuenta <> 2) THEN
	messagebox("Atención Sr. Usuario","No puede grabar un Voucher con el Wording en blanco.")
	return
END IF

ls_codigo = dw_1.getitemstring(dw_1.getrow(),'desem_transito')
IF (isnull(ls_codigo) or ls_codigo = '') and li_cuenta = 1 THEN
	messagebox("Atención Sr. Usuario","No puede grabar un Voucher sin el Tránsito Asignado.")
	return
END IF

ls_no_caso = dw_1.getitemstring(dw_1.getrow(),'desem_no_caso')
IF (isnull(ls_no_caso) or ls_no_caso = '') and li_cuenta = 4 THEN
	messagebox("Atención Sr. Usuario","No puede grabar un Voucher sin el No. de Caso Asignado.")
	return
END IF

ll_cliente = dw_1.getitemnumber(dw_1.getrow(),'desem_tercero')
IF (isnull(ll_cliente) or ll_cliente = 0) and li_cuenta = 2 THEN
	messagebox("Atención Sr. Usuario","No puede grabar un Voucher sin el Cliente Asignado.")
	return
END IF

ls_cuenta_mg = dw_1.getitemstring(dw_1.getrow(),'desem_cuenta_mg') 
IF (isnull(ls_cuenta_mg) or ls_cuenta_mg = '') and li_cuenta = 3 THEN
	messagebox("Atención Sr. Usuario","No puede grabar un Voucher sin la Cuenta de Gastos Asignada.")
	return
END IF

//Valida que no asigne el monto en 0
ld_monto = dw_1.getitemnumber(dw_1.getrow(),'desem_monto')	

IF isnull(ld_monto) or ld_monto = 0 then
	messagebox("Atención Sr. Usuario","No puede grabar un Voucher con el Monto en blanco.")
	return
END IF

ls_estado = dw_1.getitemstring(dw_1.getrow(),'desem_status')
if ls_estado <> 'S' then
	mensaje('Aviso','No se Puede Modificar este Registro, ya fue Procesado','')
	return
end if

ll_tercero = dw_1.getitemnumber(1,"desem_tercero")
ldt_fecha_tran = dw_1.getitemdatetime(1,"desem_fecha")

IF ll_tercero <> 0 and not isnull(ll_tercero) THEN
	SELECT ccmclien.clie_ultima_fecha_restringido  
	  INTO :ldt_fecha_restriccion
	  FROM ccmclien  
	 WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
			 ( ccmclien.clie_empresa = :str.empresa ) AND  
			 ( ccmclien.clie_tercero = :ll_tercero )   ;
	
	IF sqlca.sqlcode = -1 THEN
		mensaje('ERROR', 'Error al Consultar registros en CCMCLIEN.', sqlca.sqlerrtext)
		return	
	END IF
	
	IF ldt_fecha_tran <= ldt_fecha_restriccion THEN
		IF messagebox("Atención","El cliente seleccionado tiene fecha de última revisión de cuenta una fecha mayor a la fecha de la transacción.	&
		Desea continuar y grabar la transacción de todas maneras?",Question!,YesNo!) = 1 THEN
			OpenWithParm(w_dg_man_clave_2,"")
			ls_retorno = Message.StringParm
			IF ls_retorno <> '1' THEN
				dw_1.setitem(1,"desem_fecha",ldt_fecha_actual)
				return
			END IF
		ELSE
			dw_1.setitem(1,"desem_fecha",ldt_fecha_actual)
			return
		END IF
	END IF	
END IF

if   dw_1.getitemnumber(dw_1.getrow(),'desem_paga_itbm') = 0 then
	dw_1.setitem(dw_1.getrow(),'desem_monto_final', ld_monto)
end if

sqlca.autocommit = false

//IF wf_graba_auxiliar() = 1 THEN
//	return		
//END IF	

ll_update=dw.update()

if ll_update = 1  then
	commit using sqlca;
	cb_1.enabled = true
	str_parametro.variable1 = dw_1.getitemstring(dw_1.getrow(),'desem_caja')
	str_parametro.numero1 = dw_1.getitemnumber(dw_1.getrow(),'desem_desembolso')
	str_parametro.numero2 = dw_1.getitemnumber(dw_1.getrow(),'desem_desembolso')	
	str_parametro.numero3 = dw_1.getitemnumber(dw_1.getrow(),'desem_ann')
	ib_adiciono_nuevo = true
	this.postevent("open")
//	mensaje("Información","¡Actualización Exitosa !","")
else
	ls_error = sqlca.sqlerrtext
	rollback using sqlca;
	mensaje("Atención","¡Error al Actualizar !",ls_error)
end if

sqlca.autocommit = true
end event

event ue_busqueda;call super::ue_busqueda;long ll_found
String ls_find,ls_codigo, ls_codigo_2,ls_codigo_3
integer li_cuenta, li_ann
str_dg_dynamic_find	lstr_df

dw_1.accepttext()

li_ann =  integer (dw_1.getitemstring(dw_1.getrow(),'ann'))
if li_ann = 0 or isnull(li_ann) then
	li_ann = ii_ann
end if
  
lstr_df.texto_campo [1,1] = "ntdesem.desem_desembolso"
lstr_df.texto_campo [1,2] = "Secuencia"
lstr_df.texto_campo [1,3] = "desem_desembolso"
lstr_df.texto_campo [1,4] = 'V'

lstr_df.texto_campo [2,1] = "ntdesem.desem_pagado_a"
lstr_df.texto_campo [2,2] = "Pagado a"
lstr_df.texto_campo [2,3] = ""
lstr_df.texto_campo [2,4] = 'V'
lstr_df.texto_campo [2,5] = '1200'

lstr_df.texto_campo [3,1] = "ntdesem.desem_fecha"
lstr_df.texto_campo [3,2] = "Fecha"
lstr_df.texto_campo [3,3] = ""
lstr_df.texto_campo [3,4] = 'V'

lstr_df.texto_campo [4,1] = "ntdesem.desem_transito"
lstr_df.texto_campo [4,2] = "Transito"
lstr_df.texto_campo [4,3] = ""
lstr_df.texto_campo [4,4] = 'V'

lstr_df.texto_campo [5,1] = "ntdesem.desem_monto"
lstr_df.texto_campo [5,2] = "Monto"
lstr_df.texto_campo [5,3] = ""
lstr_df.texto_campo [5,4] = 'V'

lstr_df.texto_campo [6,1] = "ntdesem.desem_ann"
lstr_df.texto_campo [6,2] = "Año"
lstr_df.texto_campo [6,3] = "desem_ann"
lstr_df.texto_campo [6,4] = 'V'


lstr_df.tabla = "ntdesem"

lstr_df.tabla_where = &
			"WHERE  ( ntdesem.desem_g_financiero = " + string(str.g_financiero) + " ) and " +&
					 "( ntdesem.desem_empresa = " + string(str.empresa) + ") and " +&
					 "( ntdesem.desem_ann = " + string(li_ann) + ") "
					 
OpenWithParm(w_dg_a_custom_find, lstr_df)
ls_find = Message.StringParm

ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
ls_codigo_2 = Trim(string( Left(ls_codigo, Pos(ls_codigo, " A") )))
ls_codigo_3 = Trim(string( Right(ls_codigo, Len(ls_codigo) - Pos(ls_codigo, "=") )))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)

if ls_codigo = '' or isnull(ls_codigo) then return
dw_1.retrieve(str.g_financiero, str.empresa, long(ls_codigo_2),integer(ls_codigo_3))

li_cuenta = dw_1.getitemnumber(dw_1.getrow(),"desem_cuenta")

//Para que al guardar, no intente modificarle la secuencia, que solo guarde
ib_adiciono_nuevo = false
	
end event

event ue_adicionar;string ls_cuenta,ls_fee
datetime ldt_fecha_desem

dw_1.reset()
dw.setcolumn(1)
dw.scrolltorow(dw.insertrow(0))
dw.setcolumn(1)
//Se activa la variable, para que al guardar busque la secuencia nuevamente, para evitar duplicados
ib_adiciono_nuevo = true

cb_1.enabled = false

dw_1.setitem(dw_1.getrow(), 'desem_g_financiero', str.g_financiero)
dw_1.setitem(dw_1.getrow(), 'desem_empresa', str.empresa)
dw_1.setitem(dw_1.getrow(), 'desem_usuario', str.usuario)
ldt_fecha_desem = gf_fecha_serv()
ldt_fecha_desem = datetime(date(ldt_fecha_desem), time('00:00:00'))
dw_1.setitem(dw_1.getrow(), 'desem_fecha', ldt_fecha_desem)
dw_1.setitem(dw_1.getrow(), 'desem_ann', year(date(gf_fecha_serv())))
dw_1.setitem(dw_1.getrow(), 'ann', string(year(date(gf_fecha_serv()))))

  SELECT nmparam.para_cuenta
    INTO :ls_cuenta  
    FROM nmparam  
   WHERE ( nmparam.para_g_financiero = :str.g_financiero ) AND  
         ( nmparam.para_empresa = :str.empresa )   ;
	if sqlca.sqlcode = -1 then
		mensaje('ERROR', 'Error al Consultar registros en nmparam.', sqlca.sqlerrtext)
		return
	end if

wf_max_secuen()
dw_1.setitem(dw_1.getrow(), 'desem_cuenta_mg', ls_cuenta)
dw_1.setitem(dw_1.getrow(), 'desem_cuenta_mg_1', ls_cuenta)

IF str_parametro.numero1 <> 0 THEN
	dw_1.setitem(dw_1.getrow(),'desem_caja',str_parametro.variable1)
	cb_1.enabled = true
	dw_1.Modify ( "desem_transito.Background.Color='16777215'" )
	dw_1.Modify ( "desem_transito_1.Background.Color='16777215'" )
	dw_1.Modify ( "ann.Background.Color='16777215'" )
	pb_3.enabled = true
	dw_1.setcolumn("desem_fecha")
ELSE
	dw_1.Modify ( "desem_transito.Background.Color='16777215'" )
	dw_1.Modify ( "desem_transito_1.Background.Color='16777215'" )
	dw_1.Modify ( "ann.Background.Color='16777215'" )
	pb_3.enabled = true
END IF



end event

event open;call super::open;pb_1.picturename = str.path+"art\blind.bmp"
pb_2.picturename = str.path+"art\min_calendar.bmp"
pb_3.picturename = str.path+"art\blind.bmp"
pb_4.picturename = str.path+"art\blind.bmp"
pb_5.picturename = str.path+"art\blind.bmp"
pb_6.picturename = str.path+"art\blind.bmp"

this.y = 0
this.x = 805

end event

event ue_print;OpenWithParm(w_dw_print_options, dw_2)

If Message.DoubleParm = -1 Then Return
dw_2.Print(True)

end event

event ue_eliminar;integer li_resp,li_update
string ls_error,ls_status

if dw_1.rowcount() > 0 then
	ls_status = dw_1.getitemstring(dw_1.getrow(),"desem_status")
	IF ls_status <> "S" THEN
		messagebox("Atención","Este registro no puede ser eliminado porque ya fue aprobado.")
		return
	END IF	
	li_resp = messagebox("Atención","Desea realmente borrar este registro ?",Question!,YesNo!)
	IF li_resp = 1 THEN
		sqlca.autocommit = false
		IF wf_elimina_voucher() = 1 THEN
			rollback;
			sqlca.autocommit = true
			return 
		END IF
		dw_1.deleterow(dw_1.getrow())
		li_update = dw_1.update()
		if li_update = 1  then
			commit using sqlca;
			sqlca.autocommit = true
			cb_1.enabled = true
			this.postevent("open")
		else
			ls_error = sqlca.sqlerrtext
			rollback using sqlca;
			sqlca.autocommit = true
			mensaje("Atención","¡Error al Actualizar !",ls_error)
		end if
	END IF
else 
	messagebox("Atención","No hay registros para borrar!")
end if
sqlca.autocommit = true
end event

event closequery;//
end event

event close;call super::close;Window lw_frame

lw_frame = ParentWindow()

If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_sheet_closed")
 End If
end event

type st_nom_ventana from w_na_padre`st_nom_ventana within w_caja_menuda_transito
integer x = 64
integer y = 1756
integer width = 1358
integer height = 72
end type

type dw_1 from w_na_padre`dw_1 within w_caja_menuda_transito
integer x = 50
integer y = 36
integer width = 2578
integer height = 1632
string dataobject = "dw_na_man_desembolso"
end type

event dw_1::doubleclicked;call super::doubleclicked;//Si se le da doble click en el campo, abre la busqueda respectiva, transito , cuenta contable o wording
if this.getcolumnname() = 'desem_transito_1' or this.getcolumnname() = 'desem_transito' then
	pb_3.triggerevent('clicked')
elseif this.getcolumnname() = "desem_cuenta_mg" then
	pb_4.triggerevent('clicked')
elseif this.getcolumnname() = "desem_wording" then		
	pb_6.triggerevent('clicked')
end if
end event

event dw_1::itemchanged;long ll_cuenta, ll_wording, ll_tercero,ll_tercero_2,ll_null
string ls_wording, ls_desc, ls_class, ls_cuen, ls_transito, ls_ann, ls_busq, ls_cuenta,ls_estado
string ls_transito_act,ls_retorno,ls_transito_ant,ls_no_caso
integer li_null,li_estado,li_cont
date ldt_fecha, ldt_fecha_actual,ldt_fecha_menor
datetime ldt_fecha_restriccion,ldt_fecha_tran,ldt_fecha_max
this.accepttext()
setnull(li_null)
setnull(ll_null)

if dwo.name = 'desem_cuenta' then
	//Valida el tránsito y al cliente
	IF dw_1.getitemnumber(1,"desem_cuenta") = 1 THEN
		
	ELSEIF dw_1.getitemnumber(1,"desem_cuenta") = 2 THEN
		ll_tercero = this.getitemnumber(1,"desem_tercero")
		ldt_fecha_tran = this.getitemdatetime(1,"desem_fecha")
		
	END IF	

	ll_cuenta = long(data)
	
if ll_cuenta = 3 then	
		dw_1.object.desem_tercero.protect = '1'
		pb_4.enabled =  true
		
		this.Modify ( "desem_transito.Background.Color='80269524'" )
		this.Modify ( "desem_transito_1.Background.Color='80269524'" )
		this.Modify ( "ann.Background.Color='80269524'" )
		this.Modify ( "desem_class.Background.Color='80269524'" ) 
		this.Modify ( "desem_tercero.Background.Color='80269524'" ) 
		
		dw_1.setitem(dw_1.getrow(), 'desem_transito', '')
		dw_1.setitem(dw_1.getrow(), 'desem_class', '')
		dw_1.setitem(dw_1.getrow(), 'desem_pagado_a', '')
		dw_1.setitem(dw_1.getrow(), 'desem_wording', 0)
		dw_1.setitem(dw_1.getrow(), 'desem_descripcion', '')
		dw_1.setitem(dw_1.getrow(), 'desem_monto', 0)
		dw_1.setitem(dw_1.getrow(), 'desem_valor_itbm', 0)
		dw_1.setitem(dw_1.getrow(), 'desem_monto_final', 0)
		dw_1.setitem(dw_1.getrow(), 'desem_paga_itbm', 0)		
		dw_1.setitem(dw_1.getrow(), 'desem_transito_1', '')
		dw_1.setitem(dw_1.getrow(), 'desem_tercero', li_null)
		dw_1.setitem(dw_1.getrow(), 'desem_cuenta_mg', '')
		dw_1.setitem(dw_1.getrow(), 'desem_no_caso', '')
		
		pb_3.enabled = false
		pb_5.enabled = false

	elseif ll_cuenta = 2 then		
		dw_1.object.desem_tercero.protect = '0'
		pb_4.enabled =  false
		
		this.Modify ( "desem_class.Background.Color='80269524'" ) 
		this.Modify ( "desem_tercero.Background.Color='16777215'" )
		
		dw_1.setitem(dw_1.getrow(), 'desem_transito', '')
		dw_1.setitem(dw_1.getrow(), 'desem_class', '')
		dw_1.setitem(dw_1.getrow(), 'desem_pagado_a', '')
		dw_1.setitem(dw_1.getrow(), 'desem_wording', 0)
		dw_1.setitem(dw_1.getrow(), 'desem_descripcion', '')
		dw_1.setitem(dw_1.getrow(), 'desem_monto', 0)
		dw_1.setitem(dw_1.getrow(), 'desem_valor_itbm', 0)
		dw_1.setitem(dw_1.getrow(), 'desem_monto_final', 0)
		dw_1.setitem(dw_1.getrow(), 'desem_paga_itbm', 0)				
		dw_1.setitem(dw_1.getrow(), 'desem_transito_1', '')
		dw_1.setitem(dw_1.getrow(), 'desem_tercero', li_null)		
		dw_1.setitem(dw_1.getrow(), 'desem_cuenta_mg', '')
		dw_1.setitem(dw_1.getrow(), 'desem_no_caso', '')
		pb_3.enabled = true
		
	elseif ll_cuenta = 1 then	
		dw_1.object.desem_tercero.protect = '1'
		pb_4.enabled =  false
		
		this.Modify ( "desem_transito.Background.Color='16777215'" )
		this.Modify ( "desem_transito_1.Background.Color='16777215'" )
		this.Modify ( "ann.Background.Color='16777215'" )
	//	this.Modify ( "desem_class.Background.Color='16777215'" )
		this.Modify ( "desem_tercero.Background.Color='16777215'" )
		
		dw_1.setitem(dw_1.getrow(), 'desem_transito', '')
		dw_1.setitem(dw_1.getrow(), 'desem_class', '')
		dw_1.setitem(dw_1.getrow(), 'desem_pagado_a', '')
		dw_1.setitem(dw_1.getrow(), 'desem_wording', 0)
		dw_1.setitem(dw_1.getrow(), 'desem_descripcion', '')
		dw_1.setitem(dw_1.getrow(), 'desem_monto', 0)
		dw_1.setitem(dw_1.getrow(), 'desem_valor_itbm', 0)
		dw_1.setitem(dw_1.getrow(), 'desem_monto_final', 0)
		dw_1.setitem(dw_1.getrow(), 'desem_paga_itbm', 0)				
		dw_1.setitem(dw_1.getrow(), 'desem_transito_1', '')
		dw_1.setitem(dw_1.getrow(), 'desem_tercero', li_null)	
		dw_1.setitem(dw_1.getrow(), 'desem_no_caso', '')
		
		  SELECT isnull(nmparam.para_cuenta,'')
			 INTO :ls_cuen
			 FROM nmparam  
			WHERE ( nmparam.para_g_financiero = :str.g_financiero ) AND  
					( nmparam.para_empresa = :str.empresa )   ;
			if sqlca.sqlcode = -1 then
				mensaje('ERROR', 'Error al Consultar registros en nmparam.', sqlca.sqlerrtext)
				return
			end if
		
		dw_1.setitem(dw_1.getrow(), 'desem_cuenta_mg', ls_cuenta)
		
		pb_3.enabled = true
		pb_5.enabled = true
	end if
elseif dwo.name = 'desem_monto' then
	wf_calcula_itbm()	
elseif dwo.name = 'desem_paga_itbm' then
	ii_paga_itbms =  integer(data) //this.getitemnumber(1,'fact_paga_itbm')
	wf_calcula_itbm()
			
elseif dwo.name = 'desem_wording' then

	ll_wording = long(data)

  SELECT nmplantillas.mpla_descripcion,
	  		nmplantillas.mpla_class 
    INTO :ls_desc,
	 		:ls_class
    FROM nmplantillas  
	WHERE nmplantillas.mpla_plantilla = :ll_wording  ;
	
	if sqlca.sqlcode = -1 then
		mensaje('Atención', 'Error al Consultar Registrtos', sqlca.sqlerrtext)
		return
	end if

	if ls_desc = '' or isnull(ls_desc) then
		mensaje('Atención', 'No existe Wording con este código... Revise.', '')
		dw_1.setitem(dw_1.getrow(), 'desem_descripcion', '')
		dw_1.setitem(dw_1.getrow(), 'desem_wording', 0)
		return
	else
		dw_1.setitem(dw_1.getrow(), 'desem_descripcion', ls_desc)

		if dw_1.getitemnumber(dw_1.getrow(), 'desem_cuenta') <> 3 then
			dw_1.setitem(dw_1.getrow(), 'desem_class', ls_class)
		end if
	end if

elseif dwo.name = 'desem_tercero' then
	//Valida cliente actual
	ll_tercero = this.getitemnumber(1,"desem_tercero")
	ldt_fecha_tran = this.getitemdatetime(1,"desem_fecha")
	
	  SELECT ccmclien.clie_mg_cuenta 
	    INTO :ls_cuen
		 FROM ccmclien  
		WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
				( ccmclien.clie_empresa = :str.empresa ) AND  
				( ccmclien.clie_tercero = :ll_tercero )   ;
	if sqlca.sqlcode = -1 then
		mensaje('ERROR', 'Error al Consultar Cuenta del Cliente.', sqlca.sqlerrtext)
		return
	end if
	
	IF ldt_fecha_tran <= ldt_fecha_restriccion THEN
		IF messagebox("Atención","El cliente grabado tiene fecha de última revisión de cuenta una fecha mayor a la fecha de la transacción.&
		Desea cambiarlo de todas maneras?",Question!,YesNo!) = 1 THEN
			OpenWithParm(w_dg_man_clave_2,"")
			ls_retorno = Message.StringParm
			IF ls_retorno <> '1' THEN
				ll_tercero_2 = dw_1.getitemnumber(1,"desem_tercero")
				dw_1.setitem(1,"desem_tercero",ll_tercero_2)
				return 2
			END IF
		ELSE
			ll_tercero_2 = dw_1.getitemnumber(1,"desem_tercero")
			dw_1.setitem(1,"desem_tercero",ll_tercero_2)
			return 2
		END IF
	END IF
	
	//Valida cliente seleccionado
	ll_tercero = long(data)
	ldt_fecha_tran = this.getitemdatetime(1,"desem_fecha")
	
	  SELECT ccmclien.clie_mg_cuenta  
		 INTO :ls_cuenta
		 FROM ccmclien  
		WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
				( ccmclien.clie_empresa = :str.empresa ) AND  
				( ccmclien.clie_tercero = :ll_tercero )   ;
				
	if sqlca.sqlcode = -1 then
		mensaje('ERROR', 'Error al Consultar Cuenta del Cliente.', sqlca.sqlerrtext)
		return
	end if
	
	IF ldt_fecha_tran <= ldt_fecha_restriccion THEN
		IF messagebox("Atención","El cliente seleccionado tiene fecha de última revisión de cuenta una fecha mayor a la fecha de la transacción.&
		Desea seleccionarlo de todas maneras?",Question!,YesNo!) = 1 THEN
			OpenWithParm(w_dg_man_clave_2,"")
			ls_retorno = Message.StringParm
			IF ls_retorno <> '1' THEN
				dw_1.setitem(1,"desem_tercero",ll_null)
				return 2
			END IF
		ELSE
			dw_1.setitem(1,"desem_tercero",ll_null)
			return 2
		END IF
	END IF
	
	dw_1.setitem(dw_1.getrow(), 'desem_cuenta_mg', ls_cuen)

elseif dwo.name = 'desem_transito_1' then

	if len(data) = 1 then
		ls_transito = '000' + data
	elseif len(data) = 2 then
		ls_transito = '00' + data
	elseif len(data) = 3 then
		ls_transito = '0' + data
	else
		ls_transito = data
	end if

	ls_ann = dw_1.getitemstring(dw_1.getrow(), 'ann')

	ls_transito = "%" + ls_transito + "-" + ls_ann + "%"
//	ls_transito = data


	if ls_busq = '' then
		mensaje('Atención', 'Este Tránsito no esta registrado en el Sistema o está cerrado... Revise.', '')
		this.setitem(this.getrow(), 'desem_transito', '' )
		return 2
	else		
		IF ls_estado = 'R' THEN
			IF messagebox("Atención","El Tránsito seleccionado se encuentra en estado de revisión. Desea seleccionarlo de todas maneras?",Question!,YesNo!) = 1 THEN
				OpenWithParm(w_dg_man_clave_2,"")
				ls_retorno = Message.StringParm
				IF ls_retorno <> '1' THEN
					ls_transito_act = dw_1.getitemstring(1,"desem_transito_1")
					this.setitem(1,"desem_transito_1",ls_transito_act)
					return 2
				END IF
			ELSE
				this.setitem(1,"desem_transito_1",ls_transito_act)
				return 2
			END IF
		END IF
		
		this.setitem(this.getrow(), 'desem_transito', ls_busq )
		return 2
	end if
	
elseif dwo.name = "desem_cuenta_mg" then
	dw_1.setitem(dw_1.getrow(),"desem_cuenta_mg_1",data)
	
elseif dwo.name = "desem_fecha" then
	this.accepttext()
	ldt_fecha_actual = date(gf_fecha_serv())
	ldt_fecha		  = date(this.getitemdatetime(this.getrow(),'desem_fecha'))
	
	if ldt_fecha > ldt_fecha_actual then
		mensaje('Aviso','Sr. Usuario, no Puede Introducir una Fecha Mayor a la Fecha Actual, Verifique !!!','')
		this.setitem(this.getrow(),'desem_fecha',ldt_fecha_actual)
		this.setcolumn('desem_fecha')
		return 2
	end if
	
	//Valida que no pueda introducir fechas menores al mes de proceso en contabilidad
	if ldt_fecha < w_fa_fondo.idt_fecha_contabilidad then
		mensaje('Aviso','Sr. Usuario, no Puede Introducir una Fecha Menor a la del mes de Proceso en Contabilidad, Verifique !!!','')
		this.setitem(this.getrow(),'desem_fecha',ldt_fecha_actual)
		this.setcolumn('desem_fecha')
		return 2
	end if
	
	
	IF month(date(ldt_fecha_max)) = 12 and month(ldt_fecha) = 12 and year(date(ldt_fecha_max)) = year(ldt_fecha) THEN
		mensaje('Aviso','Sr. Usuario, La Fecha que esta Asignando no esta Permitida porque este mes ya fue pasado a Contabilidad, Verifique !!!','')
		this.setitem(this.getrow(),'desem_fecha',date(gf_fecha_serv()))
		this.setcolumn('desem_fecha')
		return 2	
	END IF
	
	IF ldt_fecha <= date(ldt_fecha_max) THEN
		mensaje('Aviso','Sr. Usuario, La Fecha que esta Asignando no esta Permitida porque este mes ya fue pasado a Contabilidad, Verifique !!!','')
		this.setitem(this.getrow(),'desem_fecha',date(gf_fecha_serv()))
		this.setcolumn('desem_fecha')
		return 2	
	END IF 
	
	//Para que si no es nuevo, no modifique la secuencia
	if ib_adiciono_nuevo = true then	
		wf_max_secuen()
	end if
		
elseif dwo.name = "desem_caja" then
	str_parametro.variable1 = data
	
//	SELECT count(*)  
//     INTO :li_cont  
//     FROM ntdesem  
//    WHERE ( ntdesem.desem_g_financiero = :str.g_financiero ) AND  
//          ( ntdesem.desem_empresa = :str.empresa ) AND  
//          ( ntdesem.desem_caja = :data ) AND  
//          ( ntdesem.desem_status = 'S' )   ;
//	
//	if sqlca.sqlcode = -1 then
//		mensaje('ERROR', 'Error al Consultar registros en ntdesem.', sqlca.sqlerrtext)
//		return
//	end if
//	
//	IF li_cont >= 65 THEN
//		messagebox("Atención","Esta caja a llegado a la cantidad máxima de vouchers necesarios para el cierre de la misma. &
//Debe primero cerrar esta caja para poder entonces captar otro voucher.")
//		close(w_caja_menuda_transito)
//	END IF
	
end if
end event

event dw_1::ue_down;// Toma la Tecla que el usuario presione

CHOOSE CASE key		
	CASE KeyF1! 
		if this.getcolumnname() = 'desem_wording' then
			pb_6.triggerevent("clicked")
		end if
END CHOOSE

end event

event dw_1::editchanged;call super::editchanged;//integer li_cont
//string ls_caja
//
//ls_caja = this.getitemstring(1,"desem_caja")
//	
//	SELECT count(*)  
//     INTO :li_cont  
//     FROM ntdesem  
//    WHERE ( ntdesem.desem_g_financiero = :str.g_financiero ) AND  
//          ( ntdesem.desem_empresa = :str.empresa ) AND  
//          ( ntdesem.desem_caja = :ls_caja ) AND  
//          ( ntdesem.desem_status = 'S' )   ;
//	
//	if sqlca.sqlcode = -1 then
//		mensaje('ERROR', 'Error al Consultar registros en ntdesem.', sqlca.sqlerrtext)
//		return
//	end if
//	
//	IF li_cont >= 65 THEN
//		messagebox("Atención","Esta caja a llegado a la cantidad máxima de vouchers necesarios para el cierre de la misma. &
//Debe primero cerrar esta caja para poder entonces captar otro voucher.")
//		close(w_caja_menuda_transito)
//	END IF
end event

type st_ayuda from w_na_padre`st_ayuda within w_caja_menuda_transito
end type

type dw_10 from w_na_padre`dw_10 within w_caja_menuda_transito
end type

type pb_1 from picturebutton within w_caja_menuda_transito
integer x = 494
integer y = 96
integer width = 96
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
alignment htextalign = left!
end type

event clicked;string ls_codigo, ls_find, ls_ann
integer li_ann
long ll_cuenta
dw_1.accepttext()
ii_ann = year(date(dw_1.getitemdatetime(dw_1.getrow(),'desem_fecha')))
li_ann =  integer (dw_1.getitemstring(dw_1.getrow(),'ann'))

if li_ann = 0 or isnull(li_ann) then
	li_ann = ii_ann
end if

str_dg_dynamic_find	lstr_df

lstr_df.texto_campo [1,1] = "ntdesem.desem_desembolso"
lstr_df.texto_campo [1,2] = "Secuencia"
lstr_df.texto_campo [1,3] = "desem_cargo"
lstr_df.texto_campo [1,4] = 'V'
lstr_df.texto_campo [1,5] = '400'

lstr_df.texto_campo [2,1] = "ntdesem.desem_pagado_a"
lstr_df.texto_campo [2,2] = "Pagado a"
lstr_df.texto_campo [2,3] = ""
lstr_df.texto_campo [2,4] = 'V'
lstr_df.texto_campo [2,5] = '1200'

lstr_df.texto_campo [3,1] = "ntdesem.desem_ann"
lstr_df.texto_campo [3,2] = "Año"
lstr_df.texto_campo [3,3] = "desem_ann"
lstr_df.texto_campo [3,4] = 'V'

lstr_df.texto_campo [4,1] = "ntdesem.desem_fecha"
lstr_df.texto_campo [4,2] = "Fecha"
lstr_df.texto_campo [4,3] = ""
lstr_df.texto_campo [4,4] = 'V'
lstr_df.texto_campo [4,5] = '300'

lstr_df.texto_campo [5,1] = "ntdesem.desem_monto"
lstr_df.texto_campo [5,2] = "Monto"
lstr_df.texto_campo [5,3] = ""
lstr_df.texto_campo [5,4] = 'V'

lstr_df.texto_campo [6,1] = "ntdesem.desem_transito"
lstr_df.texto_campo [6,2] = "Tránsito"
lstr_df.texto_campo [6,3] = ""
lstr_df.texto_campo [6,4] = 'V'

lstr_df.tabla = "ntdesem"

lstr_df.tabla_where = &
			"WHERE (ntdesem.desem_g_financiero = " + string(str.g_financiero) + ") and " +&
					"( ntdesem.desem_empresa = " + string(str.empresa) + ") and " +&
					 "( ntdesem.desem_ann = " + string(li_ann) + ") " + &
					 " order by ntdesem.desem_desembolso" 

OpenWithParm(w_dg_a_custom_find, lstr_df)
ls_find = Message.StringParm

//------------------------------------------------------------------------------------------------------
	ls_codigo =  mid(ls_find, pos(ls_find, '=') + 1, ((pos(ls_find, 'And') - pos(ls_find, '='))- 1 ))
	gf_replace_cadena(ls_codigo,"'"," ")
	ls_codigo = Trim(ls_codigo)

//------------------------------------------------------------------------------------------------------
	ls_ann = right(ls_find, 5)
	ls_ann = trim(ls_ann)	
//-------------------------------------------------------------------------------------------------------

if ls_codigo = '' or isnull(ls_codigo) then return

dw_1.retrieve(str.g_financiero, str.empresa, long(ls_codigo), long(ls_ann))

str_parametro.variable1 = dw_1.getitemstring(dw_1.getrow(),'desem_caja')
str_parametro.numero1 = long(ls_codigo)
str_parametro.numero2 = long(ls_codigo)
str_parametro.numero3 = long(ls_ann)
cb_1.enabled = true

ll_cuenta = dw_1.getitemnumber(dw_1.getrow(), 'desem_cuenta')

ii_paga_itbms = dw_1.getitemnumber(dw_1.getrow(), 'desem_paga_itbm')

	if ll_cuenta = 3 then
		dw_1.Modify ( "desem_transito.Background.Color='80269524'" )
		dw_1.Modify ( "desem_transito_1.Background.Color='80269524'" )
		dw_1.Modify ( "ann.Background.Color='80269524'" )
		dw_1.Modify ( "desem_class.Background.Color='80269524'" ) 
		dw_1.Modify ( "desem_tercero.Background.Color='80269524'" ) 
		pb_3.enabled = false
		pb_5.enabled = false
		pb_4.enabled = true
		dw_1.setitem(dw_1.getrow(), 'desem_transito', '')
		dw_1.setitem(dw_1.getrow(), 'desem_class', '')

	elseif ll_cuenta = 2 then
		dw_1.setitem(dw_1.getrow(), 'desem_class', '')
		dw_1.Modify ( "desem_class.Background.Color='80269524'" ) 
		dw_1.Modify ( "desem_tercero.Background.Color='16777215'" )
		
		dw_1.setitem(dw_1.getrow(), 'desem_transito', '')
		dw_1.setitem(dw_1.getrow(), 'desem_class', '')
		
		pb_3.enabled = true
		
	elseif ll_cuenta = 1 then
		dw_1.Modify ( "desem_transito.Background.Color='16777215'" )
		dw_1.Modify ( "desem_transito_1.Background.Color='16777215'" )
		dw_1.Modify ( "ann.Background.Color='16777215'" )
		dw_1.Modify ( "desem_class.Background.Color='16777215'" )
		dw_1.Modify ( "desem_tercero.Background.Color='16777215'" )
		pb_3.enabled = true
		pb_5.enabled = true
		
	elseif ll_cuenta = 4 then
		dw_1.Modify ( "desem_transito.Background.Color='16777215'" )
		dw_1.Modify ( "desem_transito_1.Background.Color='16777215'" )
		dw_1.Modify ( "ann.Background.Color='16777215'" )
		dw_1.Modify ( "desem_class.Background.Color='16777215'" )
		dw_1.Modify ( "desem_tercero.Background.Color='16777215'" )
		pb_3.enabled = true
		pb_5.enabled = true
	end if

//Para que al guardar, no intente modificarle la secuencia, que solo guarde
ib_adiciono_nuevo = false
end event

type pb_2 from picturebutton within w_caja_menuda_transito
boolean visible = false
integer x = 2432
integer y = 284
integer width = 96
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
alignment htextalign = left!
end type

event clicked;date   ldt_fecha_actual, ldt_fecha,ldt_fecha_menor
string ls_fecha

//open(w_select_date)

dw_1.setitem(dw_1.getrow(), 'desem_fecha', date(message.stringparm))

//Valida que no pueda introducir fechas menores al mes de proceso en contabilidad
if date(message.stringparm) < w_fa_fondo.idt_fecha_contabilidad then
	mensaje('Aviso','Sr. Usuario, no Puede Introducir una Fecha Menor a la del mes de Proceso en Contabilidad, Verifique !!!','')
	dw_1.setitem(dw_1.getrow(),'desem_fecha',date(gf_fecha_serv()))
	dw_1.setcolumn('desem_fecha')
	return 2
end if

ldt_fecha_actual = date(gf_fecha_serv())
ldt_fecha		  = date(message.stringparm)

if ldt_fecha > ldt_fecha_actual then
	mensaje('Aviso','Sr. Usuario, no Puede Introducir una Fecha Mayor a la Fecha Actual, Verifique !!!','')
	dw_1.setitem(dw_1.getrow(),'desem_fecha',ldt_fecha_actual)
	dw_1.setcolumn('desem_fecha')
	return 2
end if

ldt_fecha_menor  = RelativeDate(ldt_fecha_actual, - 60)
	
if ldt_fecha < ldt_fecha_menor then
	mensaje('Aviso','Sr. Usuario, La Fecha que esta Asignando esta Fuera del Rango Permitido, Verifique !!!','')
	dw_1.setitem(dw_1.getrow(),'desem_fecha',date(gf_fecha_serv()))
	dw_1.setcolumn('desem_fecha')
	return 2
end if

end event

type pb_3 from picturebutton within w_caja_menuda_transito
integer x = 1664
integer y = 476
integer width = 96
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
alignment htextalign = left!
end type

event clicked;long ll_found, ll_charterer, ll_owner, ll_codigo, ll_count, ll_servicio, ll_tercero,ll_tercero_2
String ls_find,ls_codigo, ls_nombre, ls_sin, ls_nave, ls_puerto, ls_visita, ls_llegada, ls_salida, ls_desc, &
		 ls_cuenta, ls_cuen,ls_transito_ant,ls_estado,ls_retorno,ls_no_caso,ls_estado_caso
decimal ldec_saldo_c, ldec_saldo_o, ldec_monto
datetime ldt_llegada, ldt_salida,ldt_fecha_restriccion,ldt_fecha_tran
integer li_estado

str_dg_dynamic_find	lstr_df

if dw_1.getitemnumber(dw_1.getrow(), 'desem_cuenta') = 1 then
	ls_transito_ant = dw_1.getitemstring(1,"desem_transito_1")	
	
	SELECT ntransito.tran_estado  
	  INTO :ls_estado  
	  FROM ntransito  
	 WHERE ( ntransito.tran_g_financiero = :str.g_financiero ) AND  
			 ( ntransito.tran_empresa = :str.empresa ) AND  
			 ( ntransito.tran_transito = :ls_transito_ant )   ;

	IF sqlca.sqlcode = -1 THEN
		mensaje('ERROR', 'Error al Consultar registros en ntransito.', sqlca.sqlerrtext)
		return	
	END IF
		
	IF ls_estado = 'R' THEN
		IF messagebox("Atención","El Tránsito grabado para esta caja menuda se encuentra en estado de revisión. &
Desea modificarlo de todas maneras?",Question!,YesNo!) = 1 THEN
			OpenWithParm(w_dg_man_clave_2,"")
			ls_retorno = Message.StringParm
			IF ls_retorno <> '1' THEN
				dw_1.setitem(1,"desem_transito_1",ls_transito_ant)
				return 2
			END IF
		ELSE
			dw_1.setitem(1,"desem_transito_1",ls_transito_ant)
			return 2
		END IF
	ELSEIF ls_estado = 'C' THEN
		messagebox('Atención','No puede modificar el Tránsito ya que se encuentra cerrado.')
		dw_1.setitem(1,"desem_transito_1",ls_transito_ant)
		return 2 	
	END IF

	lstr_df.texto_campo [1,1] = "ntransito.tran_transito"
	lstr_df.texto_campo [1,2] = "Transito"
	lstr_df.texto_campo [1,3] = "nav_sin"
	lstr_df.texto_campo [1,4] = 'V'
	lstr_df.texto_campo [1,5] = '400'
	
	lstr_df.texto_campo [2,1] = "nnave.nav_nombre"
	lstr_df.texto_campo [2,2] = "Barco"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '600'
	
	lstr_df.texto_campo [3,1] = "convert(char, ntransito.tran_fecha_llegada) tran_fecha_llegada"
	lstr_df.texto_campo [3,2] = "ETA"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [3,5] = '345'
	
	lstr_df.texto_campo [4,1] = "nmpuerto.mpuert_nombre"
	lstr_df.texto_campo [4,2] = "Visita"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	
	lstr_df.tabla = "ntransito, nnave, nmpuerto"
	
	lstr_df.tabla_where = &
				"WHERE (ntransito.tran_g_financiero = " + string(str.g_financiero) + " and " +&
						 "ntransito.tran_empresa = " + string(str.empresa) + ") and " +&
						 "(ntransito.tran_g_financiero = nnave.nav_g_financiero ) and " +&
						 "(ntransito.tran_empresa = nnave.nav_empresa ) and " +&						 
						 "(ntransito.tran_barco = nnave.nav_sin ) and " +&
						 "(ntransito.tran_puerto *= nmpuerto.mpuert_puerto) and " +&
						 "(ntransito.tran_estado <> 'C') " +&
						 " order by substring(ntransito.tran_transito,9,4) desc,ntransito.tran_transito desc"
	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm
	
	ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo,"'"," ")
	ls_codigo = Trim(ls_codigo)
	
	if ls_codigo = '' or isnull(ls_codigo) then return
	
	ls_transito_ant = ls_codigo
	
	IF ls_transito_ant <> '' and not isnull(ls_transito_ant) THEN
		SELECT ntransito.tran_estado  
		  INTO :ls_estado  
		  FROM ntransito  
		 WHERE ( ntransito.tran_g_financiero = :str.g_financiero ) AND  
				 ( ntransito.tran_empresa = :str.empresa ) AND  
				 ( ntransito.tran_transito = :ls_transito_ant )   ;

		IF sqlca.sqlcode = -1 THEN
			mensaje('ERROR', 'Error al Consultar registros en ntransito.', sqlca.sqlerrtext)
			return	
		END IF
		
		IF ls_estado = 'R' THEN
			IF messagebox("Atención","El Tránsito seleccionado se encuentra en estado de revisión. Desea seleccionarlo de todas maneras?",Question!,YesNo!) = 1 THEN
				OpenWithParm(w_dg_man_clave_2,"")
				ls_retorno = Message.StringParm
				IF ls_retorno <> '1' THEN
					ls_transito_ant = dw_1.getitemstring(1,"desem_transito_1")
					dw_1.setitem(1,"desem_transito_1",ls_transito_ant)
					return 2
				END IF
			ELSE
				ls_transito_ant = dw_1.getitemstring(1,"desem_transito_1")
				dw_1.setitem(1,"desem_transito_1",ls_transito_ant)
				return 2
			END IF
		END IF
	END IF	
	
	dw_1.setitem(dw_1.getrow(), 'desem_transito', ls_codigo)

elseif dw_1.getitemnumber(dw_1.getrow(), 'desem_cuenta') = 2 then	
	ll_tercero = dw_1.getitemnumber(1,"desem_tercero")
	ldt_fecha_tran = dw_1.getitemdatetime(1,"desem_fecha")
	
	  SELECT ccmclien.clie_mg_cuenta,ccmclien.clie_restringido,ccmclien.clie_ultima_fecha_restringido  
		 INTO :ls_cuen,:li_estado,:ldt_fecha_restriccion
		 FROM ccmclien  
		WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
				( ccmclien.clie_empresa = :str.empresa ) AND  
				( ccmclien.clie_tercero = :ll_tercero )   ;
	
	IF ldt_fecha_tran <= ldt_fecha_restriccion THEN
		IF messagebox("Atención","El cliente seleccionado tiene fecha de última revisión de cuenta una fecha mayor a la fecha de la transacción.&
		Desea seleccionarlo de todas maneras?",Question!,YesNo!) = 1 THEN
			OpenWithParm(w_dg_man_clave_2,"")
			ls_retorno = Message.StringParm
			IF ls_retorno <> '1' THEN
				ll_tercero_2 = dw_1.getitemnumber(1,"desem_tercero")
				dw_1.setitem(1,"desem_tercero",ll_tercero_2)
				return 2
			END IF
		ELSE
			ll_tercero_2 = dw_1.getitemnumber(1,"desem_tercero")
			dw_1.setitem(1,"desem_tercero",ll_tercero_2)
			return 2
		END IF
	END IF

	lstr_df.texto_campo [2,1] = "dgmterce.terc_tercero"
	lstr_df.texto_campo [2,2] = "Código"
	lstr_df.texto_campo [2,3] = "terc_tercero"
	lstr_df.texto_campo [2,4] = 'V'

	lstr_df.texto_campo [3,1] = "dgmterce.terc_identificacion"
	lstr_df.texto_campo [3,2] = "Identificación"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'

	lstr_df.texto_campo [1,1] = "dgmterce.terc_descripcion"
	lstr_df.texto_campo [1,2] = "Descripción"
	lstr_df.texto_campo [1,3] = ""
	lstr_df.texto_campo [1,4] = 'V'
	lstr_df.texto_campo [1,5] = '650'

	lstr_df.texto_campo [4,1] = "dgapais.pais_descripcion"
	lstr_df.texto_campo [4,2] = "País"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '500'


	lstr_df.tabla = " dgmterce, dgapais, ccmclien"

	lstr_df.tabla_where = &
				"WHERE ( dgmterce.terc_pais *= dgapais.pais_pais ) and  " +&
						"(ccmclien.clie_g_financiero = " + string(str.g_financiero) + " and " +&
						 "ccmclien.clie_empresa = " + string(str.empresa) + ") 	and " +&
						"(dgmterce.terc_tercero = ccmclien.clie_tercero ) " 

	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm

	ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo,"'"," ")
	ls_codigo = Trim(ls_codigo)

	if ls_codigo = '' or isnull(ls_codigo) then return
	
	ll_tercero = long(ls_codigo)
	ldt_fecha_tran = dw_1.getitemdatetime(1,"desem_fecha")
	
	SELECT ccmclien.clie_mg_cuenta,ccmclien.clie_restringido,ccmclien.clie_ultima_fecha_restringido  
	  INTO :ls_cuen,:li_estado,:ldt_fecha_restriccion
	  FROM ccmclien  
	 WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
			 ( ccmclien.clie_empresa = :str.empresa ) AND  
			 ( ccmclien.clie_tercero = :ll_tercero )   ;
	
	IF sqlca.sqlcode = -1 THEN
		mensaje('ERROR', 'Error al Consultar registros en CCMCLIEN.', sqlca.sqlerrtext)
		return	
	END IF
	
	IF ldt_fecha_tran <= ldt_fecha_restriccion THEN
		IF messagebox("Atención","El cliente seleccionado tiene fecha de última revisión de cuenta una fecha mayor a la fecha de la transacción.&
		Desea seleccionarlo de todas maneras?",Question!,YesNo!) = 1 THEN
			OpenWithParm(w_dg_man_clave_2,"")
			ls_retorno = Message.StringParm
			IF ls_retorno <> '1' THEN
				ll_tercero_2 = dw_1.getitemnumber(1,"desem_tercero")
				dw_1.setitem(1,"desem_tercero",ll_tercero_2)
				return 2
			END IF
		ELSE
			ll_tercero_2 = dw_1.getitemnumber(1,"desem_tercero")
			dw_1.setitem(1,"desem_tercero",ll_tercero_2)
			return 2
		END IF
	END IF
	
	dw_1.setitem(dw_1.getrow(), 'desem_tercero', long(ls_codigo))		

	dw_1.setitem(dw_1.getrow(), 'desem_cuenta_mg', ls_cuen)
		
end if
end event

type pb_4 from picturebutton within w_caja_menuda_transito
integer x = 1664
integer y = 560
integer width = 96
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
alignment htextalign = left!
end type

event clicked;String ls_syntax, ls_cta, ls_descrip,ls_err
long ll_err
int li_posicion1,li_posicion2

	str_dg_dynamic_find	lstr_df
	lstr_df.texto_campo[1, 1] = "dgmplanc.mg_descripcion"
	lstr_df.texto_campo[1, 2] = "Descripción"
	lstr_df.texto_campo[1, 3] = ""
	lstr_df.texto_campo[1, 4] = "V"
	lstr_df.texto_campo[1, 5] = "1150"
	
	lstr_df.texto_campo[2, 1] = "dgmplanc.mg_cuenta"
	lstr_df.texto_campo[2, 2] = "Cuenta"
	lstr_df.texto_campo[2, 3] = "mg_cuenta"
	lstr_df.texto_campo[2, 4] = "V"
	
	lstr_df.tabla				  = " dgmplanc  "
	lstr_df.tabla_where		  = " WHERE ( dgmplanc.mg_g_financiero = " + String(str.g_financiero) + ") AND " + &
											"( dgmplanc.mg_empresa = " + String(str.empresa) + ") AND " + &
											"(dgmplanc.mg_tipo_cuenta = 'D')" 
											
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_syntax = Message.StringParm
	li_posicion1 = Pos(ls_syntax,"'")
	ls_cta = Mid (ls_syntax,li_posicion1+1,20)

	if ls_cta = '' or isnull(ls_cta) then return

	dw_1.SetItem(dw_1.getrow(), "desem_cuenta_mg", ls_cta)
end event

type pb_5 from picturebutton within w_caja_menuda_transito
boolean visible = false
integer x = 1563
integer y = 672
integer width = 96
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
alignment htextalign = left!
end type

event clicked;string ls_codigo, ls_find

str_dg_dynamic_find	lstr_df

lstr_df.texto_campo [2,1] = "ncargos.carg_cargo"
lstr_df.texto_campo [2,2] = "Código"
lstr_df.texto_campo [2,3] = "carg_cargo"
lstr_df.texto_campo [2,4] = 'V'

lstr_df.texto_campo [1,1] = "ncargos.carg_descripcion"
lstr_df.texto_campo [1,2] = "Descripción"
lstr_df.texto_campo [1,3] = ""
lstr_df.texto_campo [1,4] = 'V'
lstr_df.texto_campo [1,5] = '1200'

lstr_df.tabla = "ncargos"

lstr_df.tabla_where = &
			"WHERE (( ncargos.carg_visible <> 1 ) or" +&
					 "( ncargos.carg_visible = null))"

OpenWithParm(w_dg_a_custom_find, lstr_df)
ls_find = Message.StringParm

ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)

if ls_codigo = '' or isnull(ls_codigo) then return

dw_1.setitem(dw_1.getrow(), 'desem_class', ls_codigo)
end event

type pb_6 from picturebutton within w_caja_menuda_transito
integer x = 741
integer y = 996
integer width = 96
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
alignment htextalign = left!
end type

event clicked;string ls_codigo, ls_find, ls_plantilla, ls_class
long ll_codigo

str_dg_dynamic_find	lstr_df

lstr_df.texto_campo [1,1] = "nmplantillas.mpla_plantilla"
lstr_df.texto_campo [1,2] = "Código"
lstr_df.texto_campo [1,3] = "carg_cargo"
lstr_df.texto_campo [1,4] = 'V'

lstr_df.texto_campo [2,1] = "nmplantillas.mpla_descripcion"
lstr_df.texto_campo [2,2] = "Descripción"
lstr_df.texto_campo [2,3] = ""
lstr_df.texto_campo [2,4] = 'V'
lstr_df.texto_campo [2,5] = '2000'

lstr_df.tabla = "nmplantillas"


OpenWithParm(w_dg_a_custom_find, lstr_df)
ls_find = Message.StringParm

ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)

if ls_codigo = '' or isnull(ls_codigo) then return

dw_1.setitem(dw_1.getrow(), 'desem_wording', long(ls_codigo))

ll_codigo = long(ls_codigo)

  SELECT nmplantillas.mpla_descripcion,
  			nmplantillas.mpla_class
    INTO :ls_plantilla,
	 		:ls_class
    FROM nmplantillas  
   WHERE nmplantillas.mpla_plantilla =  :ll_codigo  ;

if dw_1.getitemnumber(dw_1.getrow(), 'desem_cuenta') <> 3 then
	dw_1.setitem(dw_1.getrow(), 'desem_class', ls_class)
end if	
		
dw_1.setitem(dw_1.getrow(), 'desem_descripcion', ls_plantilla)


end event

type dw_2 from datawindow within w_caja_menuda_transito
boolean visible = false
integer width = 2377
integer height = 1512
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Voucher"
string dataobject = "dw_na_desem_imp"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type gb_1 from groupbox within w_caja_menuda_transito
integer x = 37
integer width = 2638
integer height = 1712
integer taborder = 20
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
end type

type cb_1 from commandbutton within w_caja_menuda_transito
integer x = 2075
integer y = 140
integer width = 343
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Preliminar"
end type

event clicked;//dw_2.visible = true

OpenSheetWithParm(w_na_rep_preli_caja_menuda,str_parametro,str.frame,9,Layered!)

end event

type cb_2 from commandbutton within w_caja_menuda_transito
integer x = 2089
integer y = 992
integer width = 480
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Detlle Frm.43"
end type

event clicked;str_cc_formatos str_formato1
dw_1.accepttext()
str_formato1.documento = string(dw_1.getitemnumber(1,'desem_desembolso'))
if str_formato1.documento = '' or isnull(str_formato1.documento) then return
str_formato1.transaccion = 'CM'
str_formato1.sub_transaccion = 'CM'
str_formato1.cuenta_banco = '1'
str_formato1.banco = 1
str_formato1.referencia = str_formato1.documento
str_formato1.anio = year(date(dw_1.getitemdatetime(1,'desem_fecha')))
str_formato1.aplicacion = 'NA'
str_formato1.tercero = 0 //dw_1.getitemnumber(1,'movi_tercero')
str_formato1.nombre = dw_1.getitemstring(1,'desem_pagado_a')
str_formato1.ruc = '' //dw_1.getitemstring(1,'movi_ruc')
str_formato1.dv = '' //dw_1.getitemstring(1,'movi_dv')
str_formato1.fecha_tran = date(dw_1.getitemdatetime(1,'desem_fecha'))

//Openwithparm(w_detalles_conceptos_frm43,str_formato1)

end event

