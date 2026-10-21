//objectcomments Ventana para la Captura de Entradas
forward
global type w_captura_depositos from w_fa_padre
end type
type dw_2 from datawindow within w_captura_depositos
end type
type dw_4 from datawindow within w_captura_depositos
end type
type cb_2 from commandbutton within w_captura_depositos
end type
type uo_1 from u_ddcalen within w_captura_depositos
end type
type dw_7 from datawindow within w_captura_depositos
end type
type cb_1 from commandbutton within w_captura_depositos
end type
type dw_3 from datawindow within w_captura_depositos
end type
type cb_3 from commandbutton within w_captura_depositos
end type
type cb_4 from commandbutton within w_captura_depositos
end type
type dw_5 from datawindow within w_captura_depositos
end type
type cb_5 from commandbutton within w_captura_depositos
end type
end forward

global type w_captura_depositos from w_fa_padre
integer x = 0
integer y = 0
integer width = 5029
integer height = 2552
string title = "Captura de Depositos"
string menuname = "m_hs"
boolean controlmenu = false
long backcolor = 12639424
windowanimationstyle openanimation = leftroll!
windowanimationstyle closeanimation = leftroll!
event ue_syscommand pbm_syscommand
event ue_aceptar_por_linea ( )
dw_2 dw_2
dw_4 dw_4
cb_2 cb_2
uo_1 uo_1
dw_7 dw_7
cb_1 cb_1
dw_3 dw_3
cb_3 cb_3
cb_4 cb_4
dw_5 dw_5
cb_5 cb_5
end type
global w_captura_depositos w_captura_depositos

type variables
integer ii_ann, datawindow, il_row, ii_cantidad_unidad, ii_cantidad_empaque, ii_banco
String  is_entrada, is_unidad_empaque, is_actualiza, is_sec_banco_cuenta, is_bodega_ubica_compra, is_tran, is_concepto, is_documento,  is_transaccion, is_datawindow , is_tran_automatica, is_cuenta_bancaria, is_user, is_motivo
date	  idt_desde, idt_hasta
long    il_tiempo, il_segundos, il_secuencia, il_empaque
decimal{4} id_peso, id_cubicaje
decimal{8} id_costo
integer ii_bodegas_definidas, ii_consumos, ii_tipo_medida, ii_cuenta_id, ii_filtrar_fecha = 0
str_in_parametros str_in
datawindowchild idw_suc_user, idwc_bancos, idwc_cuentas_bancarias, idwc_emp_afi, idwc_planc
end variables

forward prototypes
public function boolean wf_orden_nueva ()
public function boolean wf_recupera ()
public subroutine wf_libera_aplicado ()
public subroutine wf_libera_aplicado_depositado ()
public subroutine wf_setear_user (string as_user)
public subroutine wf_setear_user_nota_credito (string as_user, string as_motivo)
end prototypes

event ue_syscommand;call super::ue_syscommand;if commandtype = 61536 then
	close(this)
end if
end event

public function boolean wf_orden_nueva ();long ll_max
integer li_ann

dw_1.setitem(1,'slip_ann',ii_ann)

	select max(slip_documento)
	into	:ll_max
	from cctslips
	where slip_g_financiero  = :str.g_financiero and
			slip_empresa		= :str.empresa; // and
//			slip_ann				= :ii_ann;
		if sqlca.sqlcode = -1  then
			gf_mensaje('','Error al Buscar Secuencia '+sqlca.sqlerrtext,1,1,'E')		
			return false
		end if

if isnull(ll_max) then ll_max = 0
ll_max ++
dw_1.setitem(1,'slip_documento',ll_max)
il_secuencia = ll_max
is_documento = string(il_secuencia)	

	select max(slip_secuencia_banco_cuenta)
	into	:ll_max
	from cctslips
	where slip_g_financiero  = :str.g_financiero and
			slip_empresa		= :str.empresa and
//			slip_ann				= :ii_ann and
			slip_banco			= :ii_banco and
			slip_cuenta 			= :is_cuenta_bancaria;
		if sqlca.sqlcode = -1  then
			gf_mensaje('','Error al Buscar Secuencia '+sqlca.sqlerrtext,1,1,'E')		
			return false
		end if
if isnull(ll_max) then ll_max = 0
ll_max ++
is_sec_banco_cuenta = string(ll_max)

return true
end function

public function boolean wf_recupera ();//long ll_fila, ll_recuperados
//
//str.frame.setmicrohelp('Espere mientras se recuperan los registros...')
//
//ll_fila = dw_1.getrow()
//
//ll_recuperados = dw_1.retrieve(str.g_financiero, str.empresa, idt_desde, idt_hasta)
//if ll_recuperados > ll_fila then
//	dw_1.scrolltorow(ll_fila)
//end if
//
//il_segundos = 0
//
//str.frame.setmicrohelp('Bodegas Wireless Backoffice')
//
return true
end function

public subroutine wf_libera_aplicado ();string ls_referencia, ls_find
integer li_registro

ls_find = 'dslip_empresa_ori = '+string(dw_2.getitemnumber(dw_2.getrow(),'movi_empresa'))+' and dslip_aplicacion_ori = "'+dw_2.getitemstring(dw_2.getrow(),'movi_aplicacion')+'"  and '+&
			'dslip_transaccion_ori = "'+dw_2.getitemstring(dw_2.getrow(),'movi_tipo_transaccion')+'" and dslip_sub_transaccion_ori = "'+dw_2.getitemstring(dw_2.getrow(),'movi_sub_transaccion')+'" and '+&
			'dslip_documento_ori = "'+dw_2.getitemstring(dw_2.getrow(),'movi_documento')+'" and '+&
			'dslip_referencia_ori = "'+dw_2.getitemstring(dw_2.getrow(),'movi_referencia')+'" and dslip_ann_ori = '+string(dw_2.getitemnumber(dw_2.getrow(),'movi_anno'))

li_registro = dw_7.find(ls_find,1,dw_7.rowcount())			
if li_registro > 0 then
	dw_2.setitem(dw_2.getrow(),'movi_cant_depositada', dw_2.getitemnumber(dw_2.getrow(),'movi_cant_depositada') - abs(dw_7.getitemnumber(li_registro,'dslip_monto') ) )
	dw_7.deleterow(li_registro)
	dw_1.setitem(1,'slip_monto',dw_7.getitemnumber(1,'total'))				
end if



end subroutine

public subroutine wf_libera_aplicado_depositado ();string ls_referencia, ls_find
integer li_registro

ls_find = 'movi_empresa = '+string(dw_7.getitemnumber(dw_7.getrow(),'dslip_empresa_ori'))+' and movi_aplicacion = "'+dw_7.getitemstring(dw_7.getrow(),'dslip_aplicacion_ori')+'"  and '+&
			'movi_tipo_transaccion = "'+dw_7.getitemstring(dw_7.getrow(),'dslip_transaccion_ori')+'" and movi_sub_transaccion = "'+dw_7.getitemstring(dw_7.getrow(),'dslip_sub_transaccion_ori')+'" and '+&
			'movi_documento = "'+dw_7.getitemstring(dw_7.getrow(),'dslip_documento_ori')+'" and '+&
			'movi_referencia = "'+dw_7.getitemstring(dw_7.getrow(),'dslip_referencia_ori')+'" and movi_anno = '+string(dw_7.getitemnumber(dw_7.getrow(),'dslip_ann_ori'))

li_registro = dw_2.find(ls_find,1,dw_2.rowcount())			
if li_registro > 0 then
	dw_2.scrolltorow(li_registro)
	dw_2.setitem(li_registro,'movi_cant_depositada', dw_2.getitemnumber(li_registro,'movi_cant_depositada') - dw_7.getitemnumber(dw_7.getrow(),'dslip_monto') )							
	dw_2.setitem(li_registro,'aplicar',0)
	dw_7.deleterow(dw_7.getrow())
	if dw_7.rowcount() > 0 then
		dw_1.setitem(1,'slip_monto',dw_7.getitemnumber(1,'total'))				
	else
		dw_1.setitem(1,'slip_monto',0)				
	end if
end if



end subroutine

public subroutine wf_setear_user (string as_user);//Asigno el Usuario a la Variable de Instancia
is_user = as_user
end subroutine

public subroutine wf_setear_user_nota_credito (string as_user, string as_motivo);is_user = as_user
is_motivo = as_motivo

end subroutine

on w_captura_depositos.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.dw_2=create dw_2
this.dw_4=create dw_4
this.cb_2=create cb_2
this.uo_1=create uo_1
this.dw_7=create dw_7
this.cb_1=create cb_1
this.dw_3=create dw_3
this.cb_3=create cb_3
this.cb_4=create cb_4
this.dw_5=create dw_5
this.cb_5=create cb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_4
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.dw_7
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.cb_3
this.Control[iCurrent+9]=this.cb_4
this.Control[iCurrent+10]=this.dw_5
this.Control[iCurrent+11]=this.cb_5
end on

on w_captura_depositos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_4)
destroy(this.cb_2)
destroy(this.uo_1)
destroy(this.dw_7)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.dw_5)
destroy(this.cb_5)
end on

event ue_post_open;//override
dw.settransobject(sqlca)
string ls_cadena, ls_masca
integer i
THIS.postevent("ue_hay_data")
dw_4.settransobject(sqlca)
dw_1.settransobject(sqlca);			
dw_2.settransobject(sqlca);	
dw_3.settransobject(sqlca);
dw_7.settransobject(sqlca);	
dw_5.settransobject(sqlca)
dw_5.retrieve(str.empresa)
ii_ann = year(date(gf_fecha_serv()))


DataWindowChild dwc 

dw_2.retrieve(str.g_financiero, str.empresa)
if dw_2.rowcount() > 0 then
	dw_2.setfilter('por_depositar <> 0')
	dw_2.filter()
end if
dw_1.getchild('slip_banco', idwc_bancos)
idwc_bancos.settransobject(sqlca)
if idwc_bancos.retrieve(str.g_financiero, str.empresa) = 0  then
	gf_mensaje('','Debe crear las Cuentas Bancarias, Verifique !!',1,1,'E')
	this.postevent('close')
end if

dw_1.getchild('slip_cuenta', idwc_cuentas_bancarias)
idwc_cuentas_bancarias.settransobject(sqlca)
if idwc_cuentas_bancarias.retrieve(str.g_financiero, str.empresa) = 0  then
	gf_mensaje('','Debe crear las Cuentas Bancarias, Verifique !!',1,1,'E')
	this.postevent('close')
end if

dw_3.getchild('ddia_mg_cuenta', idwc_planc)
idwc_planc.settransobject(sqlca)
if idwc_planc.retrieve(str.g_financiero, str.empresa) = 0 then
	gf_mensaje('','Crear el Plan de Cuentas, Verifique !!',1,1,'E')
	this.postevent('close')
end if
idwc_planc.insertrow(1)

dw_3.getchild('ddia_afi_emp', idwc_emp_afi)
idwc_emp_afi.settransobject(sqlca)
idwc_emp_afi.retrieve(str.g_financiero, str.empresa) 
idwc_planc.insertrow(1)

ls_masca = gf_mascara()
dw_3.MODIFY("cuenta.editmask.mask='"+ls_masca+"'") //mascara para el compute de la cuenta
idwc_planc.MODIFY("mg_cuenta.editmask.mask='"+ls_masca+"'") //cuenta que se graba en el detalle contable

dw_3.MODIFY("ddia_afi_db_cuenta.editmask.mask='"+ls_masca+"'") //mascara para el compute de la cuenta
dw_3.MODIFY("ddia_afi_cr_cuenta.editmask.mask='"+ls_masca+"'") //mascara para el compute de la cuenta

  SELECT isnull(max(bamcuent.cuen_banco), 0) ,
         isnull(max(bamcuent.cuen_no_cuenta),'')  
    INTO :ii_banco,   
	         :is_cuenta_bancaria  
    FROM bamcuent  
   WHERE bamcuent.cuen_default = 1  and cuen_g_financiero = :str.g_financiero and cuen_empresa = :str.empresa ;
if sqlca.sqlcode = -1 then
	gf_mensaje('','Error al buscar Cuenta Default '+sqlca.sqlerrtext,1,1,'E')
end if

datawindow = 1

this.triggerevent('ue_adicionar')

//Recupera la secuencia siguiente y da opcion para buscar una
wf_orden_nueva()

dw_1.setcolumn('slip_banco')

str.frame.setmicrohelp('Depositos')
//il_tiempo = 150
//em_tiempo.text = string(150)
//timer(1)
//this.height = w_fa_fondo.height - 50
//dw_1.visible = true
this.setredraw(true)
end event

event ue_pre_aceptar;//Override
dw_1.Accepttext()

this.postevent("ue_aceptar")

end event

event ue_adicionar;//Override
datetime ldt_fecha
string ls_cadena
//if dw_1.rowcount() > 0 then
//	if dw_1.getitemnumber(1,'slip_estado') = 1 then
//		dw_1.reset()
//		dw_7.reset()
//		dw_1.insertrow(1)
//		//Pone invisible el insertar	
//		dw_1.setitem(1,'slip_g_financiero',str.g_financiero)
//		dw_1.setitem(1,'slip_empresa',str.empresa)
//		dw_1.setitem(1,'slip_id',str.usuario)		
//		dw_1.setitem(1,'slip_ann',ii_ann)
//		dw_1.setitem(1,'slip_fecha',date(gf_fecha_serv()))
//		dw_1.setitem(1,'slip_sucursal',is_sucursal)
//		dw_1.setitem(1,'slip_banco',ii_banco)
//		dw_1.setitem(1,'slip_cuenta',is_cuenta_bancaria)
//		dw_1.setfocus()
//		dw_1.setcolumn('slip_documento')
//		wf_orden_nueva()		
//		dw_1.setitem(1,'slip_secuencia_banco_cuenta',long(is_sec_banco_cuenta))		
//		dw_1.setitem(1,'slip_referencia',string(ii_banco)+'-'+string(ii_cuenta_id)+'-'+is_sec_banco_cuenta)		
//		dw_1.setitem(1,'slip_observacion','SLIP DE DEPOSITO '+dw_1.getitemstring(1,'sucursal')+' '+dw_1.getitemstring(1,'banco')+' #-'+is_documento)
//		dw_1.setitem(1,'fecha',date(gf_fecha_serv()))
//		return
//	end if
//end if
//
//if datawindow = 1 then	
	dw_1.reset()
	dw_7.reset()
	dw_1.insertrow(1)
	//Pone invisible el insertar	
	dw_1.setitem(1,'slip_g_financiero',str.g_financiero)
	dw_1.setitem(1,'slip_empresa',str.empresa)
	dw_1.setitem(1,'slip_id',str.usuario)			
	dw_1.setitem(1,'slip_fecha',date(gf_fecha_serv()))
//	ii_ann = year(date(gf_fecha_serv())) despues no se puede buscar los dep de el anio
	dw_1.setitem(1,'slip_ann',ii_ann)
	dw_1.setitem(1,'slip_banco',ii_banco)
	dw_1.setitem(1,'slip_cuenta',is_cuenta_bancaria)
	dw_1.setfocus()
	dw_1.setcolumn('slip_documento')
	wf_orden_nueva()
	dw_1.setitem(1,'slip_secuencia_banco_cuenta',long(is_sec_banco_cuenta))
	dw_1.setitem(1,'slip_referencia',string(ii_banco)+'-'+string(ii_cuenta_id)+'-'+is_sec_banco_cuenta)
	dw_1.setitem(1,'slip_observacion','SLIP DE DEPOSITO '+dw_1.getitemstring(1,'banco')+' #-'+is_documento)
	dw_1.setitem(1,'fecha',date(gf_fecha_serv()))
	dw_1.setitem(1,'filtrar',ii_filtrar_fecha)
	dw_2.retrieve(str.g_financiero, str.empresa)
	if dw_2.rowcount() > 0 then
		if ii_filtrar_fecha = 1 then
			ldt_fecha = dw_1.getitemdatetime(dw_1.getrow(),'fecha')
			ls_cadena = 'por_depositar <> 0 and date(movi_fecha_tran) = date("' +string(date(ldt_fecha))+'")'
			dw_2.setfilter(ls_cadena)
			dw_2.filter()
		else
			dw_2.setfilter('por_depositar <> 0')
			dw_2.filter()
		end if
	end if
//else
//	dw_2.setfocus()
//end if
end event

event key;//override
end event

event close; 

w_hs_frame.Post Event ue_evaluar_panel_acciones()
end event

event ue_hay_data;//Override
end event

event resize;//Override
dw_2.height= newheight - 550
dw_7.height= newheight - 550

end event

event open;//override
gf_acelerador()
dw = dw_1
this.y = 0
this.x = 0

This.Icon = str.icono

this.postevent("ue_post_open")


This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)

str.frame.SetRedraw ( True )
end event

event ue_print;////override
string ls_expresion

if il_secuencia = 0 then return
dw_4.retrieve(str.g_financiero, str.empresa,il_secuencia , ii_ann)
//
if dw_4.rowcount() = 0 then return
//
ls_expresion = str.nombre_empresa
dw_4.object.nom_empresa.expression = "'"+ls_expresion+"'"

dw_4.object.datawindow.print.preview = 'yes'
dw_4.object.datawindow.print.preview.zoom = 100
dw_4.visible = true
//
if dw_1.getitemnumber(1,'slip_estado') = 0 then return

OpenWithParm(w_dw_print_options, dw_4)
If Message.DoubleParm = -1 Then Return
dw_4.Print(True)

end event

event ue_aceptar;integer  li_contador,ll_update,ll_update2,li_encontro,li_lin_ref,li_posicion,li_frac2, li_find
integer  li_costo,anulado=0,li_linea_uno,li_linea_dos,indice, li_existe_detalle, li_empresa ,li_salvar
decimal  li_cantidad,li_cantid, li_cos_tran
datetime ldt_fecha,ldt_fecha_real
string   ls_documento,ls_aplic,ls_tipo,ls_medida,ls_producto,ls_concepto, fila, ls_conc,ls_error,ls_cuenta, ls_expresion, ls_doc
Long		ll_found, ll_ann,ll_secuencia
boolean  lb_existe

dw_1.acceptText()
dw_2.acceptText()
dw_7.accepttext()
//dw=dw_1  

if dw_1.getitemnumber(1, 'slip_estado') <> 0 then
	gf_mensaje('','El Deposito ya fue Actualizado, Verifique !!!',1,1,'E')
	return
end if

ldt_fecha = dw_1.getitemdatetime(1,'slip_fecha')
if not gf_valida_fecha_conta(ldt_fecha) then
	return
end if

sqlca.autocommit = false

indice = 0

il_secuencia = dw_1.getitemNumber(1,"slip_documento")

/*grabamos los datos del DW_1 de la tabla de INTMOVIM*////////////////
if dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = New! or &
	dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = NewModified! then 	
	
	  indice = 1
	
	if (dw_1.getitemNumber(1,"slip_documento")) = 0 or isnull(dw_1.getitemNumber(1,"slip_documento")) then
		mensaje("Atencion Sr. Usuario","Debe Asignar un Documento valido, Verifique.","")
		sqlca.autocommit = true
		dw_1.setcolumn('slip_documento')
		dw_1.setfocus()
		return
	end if	

	if (dw_1.getitemNumber(1,"slip_banco")) = 0 or isnull(dw_1.getitemNumber(1,"slip_banco")) then
		mensaje("Atencion Sr. Usuario","Debe Asignar la Cuenta Bancaria, Verifique.","")
		sqlca.autocommit = true
		dw_1.setcolumn('slip_banco')
		dw_1.setfocus()
		return
	end if	

	if (dw_1.getitemstring(1,"slip_cuenta")) = '' or isnull(dw_1.getitemString(1,"slip_cuenta")) then
		mensaje("Atencion Sr. Usuario","Debe Asignar la Cuenta Bancaria, Verifique.","")
		sqlca.autocommit = true
		dw_1.setcolumn('slip_cuenta')
		dw_1.setfocus()
		return
	end if	
	
	/*Actualiza el Encabezado*/
	if dw_7.rowcount() > 0 then dw_1.setitem(1,'slip_monto',dw_7.getitemnumber(1,'total'))
	dw_1.setitem(1,'slip_fecha_registro', gf_fecha_serv())
	
	ll_update = dw_1.update()
	
	/*Actualiza la Secuencia en Dgmserie*/
	if ll_update =1 then
		 commit using sqlca;
	else
		ls_error =sqlca.sqlerrtext
		rollback using sqlca;
		sqlca.autocommit = true
		gf_Mensaje("---Atención---","¡Error al Actualizar el encabezado !" +ls_error,1,1,'E')
		ib_aceptar = False
		is_actualiza=''
		return
	end if
	 sqlca.autocommit = true
	 
else
ll_update = dw_1.update()
  if ll_update = 1 then
		commit;
		sqlca.autocommit = true
	else
		ls_error =sqlca.sqlerrtext
		rollback using sqlca;
		sqlca.autocommit = true
		ib_aceptar = False
		gf_Mensaje("---Atención---","¡Error al Actualizar el encabezado !"+ls_error,1,1,'E')
		is_actualiza=''
		return
	end if
//	ll_secuencia = long(dw_1.getitemstring(1,'no_orden'))
end if

sqlca.autocommit = false

/*grabamos los datos de DW_2 en la tabla INDTRANS*/
dwItemStatus ls_status


li_salvar=1

If li_salvar = 1 then //Si todas las bodegas/ubicacion destino existen que salve
													
	ll_update =dw_7.update()
			if ll_update = -1 then
				ls_error =sqlca.sqlerrtext
				rollback using sqlca;
				sqlca.autocommit = true
				ib_aceptar = False
				is_actualiza=''
				gf_Mensaje("---Aviso---","¡Error al Actualizar Detalle "+ls_error,1,1,'E')
				return
			end if

		
	  if ll_update = 1 then
			ll_update =dw_2.update()
			if ll_update = -1 then
				ls_error =sqlca.sqlerrtext
				rollback using sqlca;
				sqlca.autocommit = true
				ib_aceptar = False
				is_actualiza=''
				gf_Mensaje("---Aviso---","¡Error al Actualizar Documentos aplicados "+ls_error,1,1,'E')
				return
			end if
		
		  sqlca.autocommit = true
		  ib_aceptar = True

		  /* Refresca los datos del datawindows cuando la Actualizacion fue correcta */
		  dw_1.setredraw(false)
		  dw_2.setredraw(false)				
		  long ll_fila
		  ll_fila = dw_2.getrow()
  		  dw_2.retrieve(str.g_financiero, str.empresa)
		  dw_1.retrieve(str.g_financiero, str.empresa,il_secuencia, ii_ann )
		  dw_7.retrieve(str.g_financiero, str.empresa,il_secuencia, ii_ann )
		  if il_row = 0 then il_row = 1
		  dw_2.scrolltorow(il_row)
		  dw_1.setredraw(true)
		  dw_2.setredraw(true)	
		  
		  /////////////mensaje("Atención","Acualización Existosa","")
		  
		  str.frame.setmicrohelp('Ajuste Guardado.')
		  commit using sqlca ; 
		  
		else
			ls_error =sqlca.sqlerrtext
			rollback using sqlca;
			sqlca.autocommit = true
			ib_aceptar = False
			is_actualiza=''
			gf_Mensaje("---Aviso---","¡Error al Actualizar! "+ls_error,1,1,'E')
		end if
end if

sqlca.autocommit = true
//mensaje('Informacion','Actualizacion Exitosa','')
is_actualiza=''

end event

event timer;call super::timer;il_segundos = il_segundos + 1

if il_segundos > il_tiempo then
	wf_recupera()
	il_segundos = 0
end if
end event

event ue_busqueda;call super::ue_busqueda;//
String  ls_find,ls_codigo, ls_tran
integer li_c, li_b
long    ll_lter
string  ls_lter,ls_des

Datawindow        dww
str_dg_dynamic_find	lstr_df

	lstr_df.texto_campo [1,1] = "cctslips.slip_documento"
	lstr_df.texto_campo [1,2] = "Documento"
	lstr_df.texto_campo [1,3] = "slip_documento"
	lstr_df.texto_campo [1,4] = 'V'
	lstr_df.texto_campo [1,5] = '320'	
	lstr_df.texto_campo [2,1] = "cctslips.slip_fecha"
	lstr_df.texto_campo [2,2] = "Fecha"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '310'
	lstr_df.texto_campo [3,1] = "cctslips.slip_referencia"
	lstr_df.texto_campo [3,2] = "Referencia"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [3,5] = '320'
	lstr_df.texto_campo [4,1] = "case cctslips.slip_estado when 0 then 'PENDIENTE' when 2 then 'ELIMINADO' else 'ACTUALIZADO' end estado"
	lstr_df.texto_campo [4,2] = "Estado"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '400'
	lstr_df.texto_campo [5,1] = "slip_observacion"
	lstr_df.texto_campo [5,2] = "Observacion"
	lstr_df.texto_campo [5,3] = ""
	lstr_df.texto_campo [5,4] = 'V'
	lstr_df.texto_campo [5,5] = '1700'
	lstr_df.texto_campo [6,1] = "(select b.banc_descripcion from bancos b where b.banc_codigo = cctslips.slip_banco) banco"
	lstr_df.texto_campo [6,2] = "Banco"
	lstr_df.texto_campo [6,3] = ""
	lstr_df.texto_campo [6,4] = 'V'
	lstr_df.texto_campo [6,5] = '400'
	lstr_df.texto_campo [7,1] = "slip_cuenta"
	lstr_df.texto_campo [7,2] = "Cuenta Bancaria"
	lstr_df.texto_campo [7,3] = ""
	lstr_df.texto_campo [7,4] = 'V'
	lstr_df.texto_campo [7,5] = '460'
	lstr_df.texto_campo [8,1] = "slip_monto"
	lstr_df.texto_campo [8,2] = "Monto"
	lstr_df.texto_campo [8,3] = ""
	lstr_df.texto_campo [8,4] = 'V'
	lstr_df.texto_campo [8,5] = '360'

	lstr_df.tabla = " cctslips "
		
	lstr_df.tabla_where = &
				"WHERE (cctslips.slip_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(cctslips.slip_empresa = " + string(str.empresa) + ") 	and " +&
 						 "(cctslips.slip_ann = " + string(ii_ann) + ") "
	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm

If len (ls_find) = 0 Then Return
	
ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)
il_secuencia = long(ls_codigo)
if dw_1.retrieve(str.g_financiero, str.empresa, il_secuencia, ii_ann) > 0 then
	is_documento = string(dw_1.getitemnumber(1,'slip_documento'))
	ii_banco = dw_1.getitemnumber(1,'slip_banco')
	is_cuenta_bancaria = dw_1.getitemstring(1,'slip_cuenta')
end if
dw_2.retrieve(str.g_financiero, str.empresa)
dw_7.reset()
dw_7.retrieve(str.g_financiero, str.empresa, il_secuencia, ii_ann)
dw_1.setfocus()
end event

event ue_eliminar;//override
datetime ldt_fecha_tran
if datawindow = 1 then	
		
	if dw_1.getitemnumber(1,'slip_estado') <> 0 then
		gf_mensaje('','No Puede Eliminar un Deposito Actualizado, Verifique !!!',1,1,'E')
		return
	end if
	
	ldt_fecha_tran = dw_1.getitemdatetime(1,'slip_fecha')
	if not gf_valida_fecha_conta(ldt_fecha_tran) then
		return
	end if

	if dw_7.rowcount() > 0 then
		gf_mensaje('','Debe Eliminar el Detalle del Deposito, Verifique !!!',1,1,'E')
	end if

	if gf_mensaje('','Esta Seguro de Eliminar el Deposito ?',2,2,'E') = 1 then
		sqlca.autocommit = false
			
			  DELETE FROM cctslips  
				WHERE ( cctslips.slip_g_financiero = :str.g_financiero ) AND  
						( cctslips.slip_empresa = :str.empresa ) AND  
						( cctslips.slip_documento = :il_secuencia ) AND  
						( cctslips.slip_ann = :ii_ann )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al eliminar encabezado ' + sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if
			commit;
			sqlca.autocommit = true
			this.triggerevent('ue_adicionar')			
	end if
end if
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_captura_depositos
boolean visible = false
integer x = 46
integer y = 2040
integer width = 101
string text = ""
end type

type dw_1 from w_fa_padre`dw_1 within w_captura_depositos
event ue_escape pbm_dwescape
event ue_enter pbm_dwnprocessenter
integer x = 27
integer y = 12
integer width = 4923
integer height = 488
integer taborder = 10
string dataobject = "dw_depositos_encabezado"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event dw_1::ue_escape;//Override
////Codigo de Escape
//close(parent)
////parent.triggerevent("closequery")
////messagebox("Escape","Entro ...")
end event

event dw_1::ue_enter;Send(Handle(this),256,9,Long(0,0)) 
return 1 

end event

event dw_1::ue_tabfinal;//override

end event

event dw_1::ue_down;//override
// Toma la Tecla que el usuario presione

CHOOSE CASE key
		
	CASE KeyF1! 
		
		This.Postevent("ue_helpcol")
		
	CASE	  Keyenter! 
		
	  This.Triggerevent("ue_entercol")
	  
END CHOOSE
end event

event dw_1::rbuttondown;//override
end event

event dw_1::ue_microayuda;//override
end event

event dw_1::buttonclicked;call super::buttonclicked;long ll_codigo
integer li_encontro
if dwo.name = 'b_secuencia' then
	parent.triggerevent('ue_busqueda')
end if
end event

event dw_1::clicked;call super::clicked;datawindow = 1
accepttext()
date 	ld_date,ld_ini_date, ld_hoy
ld_hoy = date(gf_fecha_serv())
if dwo.name='calendario' then
	ld_ini_date=date(dw_1.GetItemDateTime(dw_1.getrow(),"slip_fecha"))
	if year(ld_ini_date) = 1900 then
		ld_ini_date = ld_hoy
	end if
	if uo_1.visible=false then
		uo_1.wf_set_value(ld_ini_date)
		uo_1.visible=true
		uo_1.allow_close=false
		uo_1.inicializar()
		uo_1.TriggerEvent('ue_abrir')
	end if
end if
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;datawindow = 1
//override
string ls_filtro
integer li_rtn

accepttext()

CHOOSE CASE dwo.name
	CASE "slip_cuenta"
	//Se filtran los grupo por la división seleccionada
	ls_filtro = string(This.GetItemNumber(row,"slip_banco"))
	idwc_cuentas_bancarias.SetFilter("cuen_banco = " + ls_filtro )	
	li_rtn = idwc_cuentas_bancarias.Filter()
end choose
end event

event dw_1::itemchanged;call super::itemchanged;accepttext()
integer i, li_registro, li_ann_anterior
datetime ldt_fecha_tran, ldt_fecha_anterior, ldt_fecha
string ls_cuenta, ls_nulo, ls_doc, ls_cadena
time lt_time
lt_time = time('00:00:00')
choose case this.getcolumnname()
	case 'filtrar'
		ii_filtrar_fecha = integer(data)
		if data = '1' then
			ldt_fecha = this.getitemdatetime(this.getrow(),'fecha')
			ls_cadena = 'por_depositar <> 0 and date(movi_fecha_tran) = date("' +string(date(ldt_fecha))+'")'
			dw_2.setfilter(ls_cadena)
			dw_2.filter()
		else
			dw_2.setfilter('por_depositar <> 0')
			dw_2.filter()
		end if
	case	'fecha'
		ldt_fecha = this.getitemdatetime(this.getrow(),'fecha')
		dw_2.retrieve(str.g_financiero, str.empresa)
		if ii_filtrar_fecha = 1 then
			ls_cadena = 'por_depositar <> 0 and date(movi_fecha_tran) = date("' +string(date(ldt_fecha))+'")'
			dw_2.setfilter(ls_cadena)
			dw_2.filter()
		else
			dw_2.setfilter('por_depositar <> 0')
			dw_2.filter()
		end if		
	case 'slip_banco'
		ii_banco = this.getitemnumber(this.getrow(),'slip_banco')
			//asigna cuenta bancaria
		  SELECT count(*)
			 INTO :li_registro
			 FROM bamcuent  
			WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
					( bamcuent.cuen_empresa = :str.empresa ) AND  
					( bamcuent.cuen_banco = :ii_banco ) ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al seleccionar cuenta '+sqlca.sqlerrtext,1,1,'E')
				return 2
			end if
			if li_registro = 1 then
				//is_cuenta_bancaria = idwc_cuentas_bancarias.getitemstring(1,'cuen_no_cuenta')
				  SELECT bamcuent.cuen_no_cuenta
				 INTO :is_cuenta_bancaria
				 FROM bamcuent  
				WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
						( bamcuent.cuen_empresa = :str.empresa ) AND  
						( bamcuent.cuen_banco = :ii_banco ) ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al seleccionar cuenta '+sqlca.sqlerrtext,1,1,'E')
					return 2
				end if
				this.setitem(1,'slip_cuenta',is_cuenta_bancaria)
				this.accepttext()
			//asigna cuenta bancaria
			  SELECT bamcuent.cuen_mg_cuenta , cuen_id, isnull(cuen_datawindow,'') , isnull(case :is_tran when 'CH' then cuen_sec_auto when 'DE' then cuen_sec_auto_dep when 'NB' then cuen_sec_auto_nd when 'CB' then cuen_sec_auto_nc when 'TD' then cuen_sec_auto_trd when 'TC' then cuen_sec_auto_trc end ,'N')
				 INTO :ls_cuenta, :ii_cuenta_id , :is_datawindow , :is_tran_automatica
				 FROM bamcuent  
				WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
						( bamcuent.cuen_empresa = :str.empresa ) AND  
						( bamcuent.cuen_banco = :ii_banco ) AND  
						( bamcuent.cuen_no_cuenta = :is_cuenta_bancaria )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al seleccionar cuenta '+sqlca.sqlerrtext,1,1,'E')
					return 2
				end if
			parent.triggerevent('ue_adicionar')				
			dw_3.setitem(1,'ddia_mg_cuenta',ls_cuenta)
			dw_3.setitem(1,'cuenta',ls_cuenta)
			dw_1.setcolumn('slip_documento')			
		else
			this.setitem(this.getrow(),'slip_cuenta',ls_nulo)
			this.setcolumn('slip_cuenta')
		end if
//		dw_2.retrieve(is_sucursal)
	case 'slip_cuenta'
		is_cuenta_bancaria = this.getitemstring(this.getrow(),'slip_cuenta')
	
		//asigna cuenta bancaria
		  SELECT bamcuent.cuen_mg_cuenta , cuen_id, isnull(cuen_datawindow,'') , isnull(case :is_tran when 'CH' then cuen_sec_auto when 'DE' then cuen_sec_auto_dep when 'NB' then cuen_sec_auto_nd when 'CB' then cuen_sec_auto_nc when 'TD' then cuen_sec_auto_trd when 'TC' then cuen_sec_auto_trc end ,'N')
			 INTO :ls_cuenta, :ii_cuenta_id , :is_datawindow , :is_tran_automatica
			 FROM bamcuent  
			WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
					( bamcuent.cuen_empresa = :str.empresa ) AND  
					( bamcuent.cuen_banco = :ii_banco ) AND  
					( bamcuent.cuen_no_cuenta = :is_cuenta_bancaria )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al seleccionar cuenta '+sqlca.sqlerrtext,1,1,'E')
				return 2
			end if
			
			
			parent.triggerevent('ue_adicionar')
						
			dw_3.setitem(1,'ddia_mg_cuenta',ls_cuenta)
			dw_3.setitem(1,'cuenta',ls_cuenta)
			dw_1.setcolumn('slip_documento')
	//		dw_2.retrieve(is_sucursal)
	case 'tmov_documento'
		is_documento = data
		for i = 1 to dw_2.rowcount()
			dw_2.setitem(i,'dmov_documento', is_documento)
		next
	case 'slip_ann'
		ii_ann = integer(data)
		datawindow = 1
		parent.triggerevent('ue_adicionar')
	
	case 'slip_fecha'
		ldt_fecha_tran 	 = this.getitemdatetime(this.getrow(),'slip_fecha')		
		ldt_fecha_anterior = this.getitemdatetime(this.getrow(),'slip_fecha', Primary!, True)		
		if ldt_fecha_anterior = ldt_fecha_tran then
			ldt_fecha_anterior = datetime(date(gf_fecha_serv()),lt_time)
		end if
		ii_ann = year(date(this.getitemdatetime(this.getrow(),'slip_fecha')))
		this.setitem(1,'slip_ann',ii_ann)
		li_ann_anterior = dw_1.getitemnumber(1,'slip_ann',primary!, true)
		
		if not gf_valida_fecha_conta(ldt_fecha_anterior) then			
			dw_1.setitem(1,'slip_fecha', ldt_fecha_anterior)
			dw_1.setcolumn('slip_fecha')
			return 2
		end if

		if not gf_valida_fecha_conta(ldt_fecha_tran) then			
			dw_1.setitem(1,'slip_fecha', ldt_fecha_anterior)
			dw_1.setcolumn('slip_fecha')
			return 2
		end if  
		
		if not gf_valida_fecha_futura(ldt_fecha_tran) then			
			if ldt_fecha_tran = ldt_fecha_anterior then
				dw_1.setitem(1,'slip_fecha', date(gf_fecha_serv()))				
			else
				dw_1.setitem(1,'slip_fecha', ldt_fecha_anterior)
			end if
			dw_1.setcolumn('slip_fecha')
			return 2
		end if
		
		if not gf_valida_fecha_bancos(ldt_fecha_anterior, is_cuenta_bancaria, ii_banco) then			
			dw_1.setitem(1,'slip_fecha', ldt_fecha_anterior)
			dw_1.setcolumn('slip_fecha')
			return 2
		end if

		if not gf_valida_fecha_bancos(ldt_fecha_tran, is_cuenta_bancaria, ii_banco) then			
			dw_1.setitem(1,'slip_fecha', ldt_fecha_anterior)
			dw_1.setcolumn('slip_fecha')
			return 2
		end if

	if ii_ann <> year(date(gf_fecha_serv())) then	wf_orden_nueva()

end choose
end event

type st_ayuda from w_fa_padre`st_ayuda within w_captura_depositos
integer x = 2793
integer y = 636
end type

type dw_2 from datawindow within w_captura_depositos
event ue_enter pbm_dwnprocessenter
event ue_down pbm_dwnkey
event ue_helpcol ( )
integer x = 5
integer y = 504
integer width = 3163
integer height = 1704
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Documentos Pendientes"
string dataobject = "dw_depositos_pendientes_todos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_enter;if this.getcolumnname() = 'dmov_cantidad' then	
	if this.getrow() = this.rowcount() then
		parent.triggerevent('ue_aceptar')
		datawindow = 2
		parent.triggerevent('ue_adicionar')
	else
		parent.triggerevent('ue_aceptar')
		this.scrolltorow(this.getrow() + 1)
		if pos(str.empr_acceso_especial, 'HPSA') > 0 then
			this.setcolumn('dmov_modelo')
		else
			this.setcolumn('dmov_producto')
		end if
	end if
elseif this.getcolumnname() = 'dmov_producto' or this.getcolumnname() = 'prod_cod_alternativo' then	
	this.setcolumn('dmov_comentarios')
elseif this.getcolumnname() = 'dmov_comentarios' then	
	this.setcolumn('dmov_cantidad')	
end if

return 2
end event

event ue_down;//override
// Toma la Tecla que el usuario presione

CHOOSE CASE key
		
	CASE KeyF1! 
		
		if this.getcolumnname() = 'dmov_producto' or this.getcolumnname() = 'dmov_modelo'  then
			This.Postevent("ue_helpcol")
		end if
		
	CASE	  Keyenter! 
		
	  This.Triggerevent("ue_entercol")
	  
END CHOOSE
end event

event ue_helpcol();//Busqueda del producto
//
String  ls_find,ls_codigo, ls_modelo, ls_cadena_consumo
integer li_c, li_b, li_fila, li_fila2
long    ll_lter
string  ls_lter,ls_des

Datawindow        dww
str_dg_dynamic_find	lstr_df
	if this.getcolumnname() = 'dmov_producto' then
		li_fila = 1
		li_fila2 = 2
	else
		li_fila = 2
		li_fila2 = 1
	end if
	
	lstr_df.texto_campo [3,1] = "inmprodu.prod_producto"
	lstr_df.texto_campo [3,2] = "Cod. Interno"
	lstr_df.texto_campo [3,3] = "prod_producto"
	lstr_df.texto_campo [3,4] = 'V'
//	lstr_df.texto_campo [1,5] = '280'	
	lstr_df.texto_campo [1,1] = "inmprodu.prod_cod_alternativo"
	lstr_df.texto_campo [1,2] = "Codigo"
	lstr_df.texto_campo [1,3] = ""
	lstr_df.texto_campo [1,4] = 'V'
	
	lstr_df.texto_campo [2,1] = "inmprodu.prod_descripcion"
	lstr_df.texto_campo [2,2] = "Descripcion"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '1070'
	
	lstr_df.texto_campo [4,1] = "datediff(month, prod_entrada_fecha, getdate()) mes"
	lstr_df.texto_campo [4,2] = "M"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '100'
	
	lstr_df.texto_campo [5,1] = "convert(numeric(8,2),inmprodu.prod_existencia_total / medi_cantidad) prod_existencia_total"
	lstr_df.texto_campo [5,2] = "Exist."
	lstr_df.texto_campo [5,3] = ""
	lstr_df.texto_campo [5,4] = 'V'
	lstr_df.texto_campo [5,5] = '270'

	lstr_df.texto_campo [6,1] = "convert(numeric(8,2),inmprodu.prod_reserva_total / medi_cantidad) prod_reserva_total"
	lstr_df.texto_campo [6,2] = "Reserva"
	lstr_df.texto_campo [6,3] = ""
	lstr_df.texto_campo [6,4] = 'V'
	lstr_df.texto_campo [6,5] = '270'

	lstr_df.texto_campo [7,1] = "convert(numeric(8,2),(inmprodu.prod_existencia_total  - inmprodu.prod_reserva_total) / medi_cantidad) disponible"
	lstr_df.texto_campo [7,2] = "Dispo."
	lstr_df.texto_campo [7,3] = ""
	lstr_df.texto_campo [7,4] = 'V'
	lstr_df.texto_campo [7,5] = '270'

	lstr_df.texto_campo [8,1] = "convert(numeric(8), inmprodu.prod_empaque) prod_empaque"
	lstr_df.texto_campo [8,2] = "Empaque"
	lstr_df.texto_campo [8,3] = ""
	lstr_df.texto_campo [8,4] = 'V'
	lstr_df.texto_campo [8,5] = '270'
	
	lstr_df.texto_campo [9,1] = "inmprodu.prod_medida"
	lstr_df.texto_campo [9,2] = "Uni."
	lstr_df.texto_campo [9,3] = ""
	lstr_df.texto_campo [9,4] = 'V'
	lstr_df.texto_campo [9,5] = '120'
	
	lstr_df.texto_campo [10,1] = "cradivis.adiv_nombre_div"
	lstr_df.texto_campo [10,2] = "Division"
	lstr_df.texto_campo [10,3] = ""
	lstr_df.texto_campo [10,4] = 'V'
	lstr_df.texto_campo [10,5] = '870'
	
	lstr_df.texto_campo [11,1] = "cragrupo.agru_descripcion_grupo"
	lstr_df.texto_campo [11,2] = "Grupo"
	lstr_df.texto_campo [11,3] = ""
	lstr_df.texto_campo [11,4] = 'V'
	lstr_df.texto_campo [11,5] = '870'

	lstr_df.tabla = " inmprodu, cradivis, cragrupo, inamedid "
	
	ls_cadena_consumo = ""
	if ii_consumos = 1 then	
		ls_cadena_consumo = " AND prod_consumo = 1 and prod_existencia_total >= 1 "
	end if
	
	lstr_df.tabla_where = &
		"WHERE ( cragrupo.agru_g_financiero = inmprodu.prod_g_financiero ) and  " +&
         "( cragrupo.agru_empresa = inmprodu.prod_empresa ) and  " +&
         "( cragrupo.agru_codigo_div = inmprodu.prod_division ) and " +&  
         "( cragrupo.agru_codigo_grupo = inmprodu.prod_grupo ) and " +&  			
         "( inmprodu.prod_g_financiero = cradivis.adiv_g_financiero ) and " +& 
         "( inmprodu.prod_empresa = cradivis.adiv_empresa ) and  " +&
         "( inmprodu.prod_division = cradivis.adiv_codigo_div ) and " +&  
         "( inmprodu.prod_medida = inamedid.medi_medida ) and " +&  			
		"( inmprodu.prod_status = 1 ) and " + &	
		"(inmprodu.prod_g_financiero = " + string(str.g_financiero) + ") and " +&
		"(inmprodu.prod_empresa = " + string(str.empresa) + ") "	+ ls_cadena_consumo
						 
	OpenWithParm(w_buscar_producto, lstr_df)
	ls_find = Message.StringParm


If len (ls_find) = 0 Then Return
	
ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)
this.setitem(this.getrow(),'dmov_producto',ls_codigo)
	  SELECT inmprodu.prod_producto_dos  
		 INTO :ls_modelo  
		 FROM inmprodu  
		WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
				( inmprodu.prod_empresa = :str.empresa ) AND  
				( inmprodu.prod_producto = :ls_codigo )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Buscar Modelo '+sqlca.sqlerrtext,1,1,'E')
		end if
this.setitem(this.getrow(),'dmov_modelo',ls_modelo)
this.accepttext()

this.trigger event itemchanged(this.getrow(), object, ls_codigo)

end event

event itemfocuschanged;datawindow = 2
il_row = row

end event

event clicked;datawindow = 2

if this.rowcount() = 0 then
	parent.triggerevent('ue_adicionar')
	return
end if

if dwo.name = 'p_delete' then
	dw_2.scrolltorow(row)
	parent.triggerevent('ue_eliminar')
elseif	dwo.name = 'p_add' then
	parent.triggerevent('ue_adicionar')
elseif dwo.name = 'p_buscar' then
	dw_2.scrolltorow(row)
	dw_2.setfocus()
	dw_2.setcolumn('dmov_producto')
	This.triggerevent("ue_helpcol")
end if
end event

event itemchanged;this.accepttext()
integer li_encontro, li_aplica, li_registro
string ls_cadena, ls_referencia, ls_tran, ls_find
datetime ldt_fecha
choose case dwo.name
	case 'aplicar_referencia'		
		if data = '1' then
			if dw_2.getitemnumber(row,'aplicar') = 1 then
				li_aplica = 0
			else
				li_aplica = 1
			end if
		else
			li_aplica = 0
		end if
		ls_referencia = dw_2.getitemstring(row,'movi_referencia')
		ls_tran		  = dw_2.getitemstring(row,'movi_tipo_transaccion')
		ldt_fecha		  = dw_2.getitemdatetime(row,'movi_fecha_tran')
		ls_cadena 	  = 'movi_referencia = "'+ls_referencia+'" and movi_tipo_transaccion = "'+ls_tran+'" and date(movi_fecha_tran) = date("'+string(date(ldt_fecha))+'")'
		li_encontro    =  dw_2.find(ls_cadena, 1, dw_2.rowcount())
		do while li_encontro > 0
			dw_2.setitem(li_encontro,'aplicar',li_aplica)
			if li_aplica = 1 then
				
				ls_find = 'dslip_empresa_ori = '+string(dw_2.getitemnumber(li_encontro,'movi_empresa'))+' and dslip_aplicacion_ori = "'+dw_2.getitemstring(li_encontro,'movi_aplicacion')+'"  and '+&
							'dslip_transaccion_ori = "'+dw_2.getitemstring(li_encontro,'movi_tipo_transaccion')+'" and dslip_sub_transaccion_ori = "'+dw_2.getitemstring(li_encontro,'movi_sub_transaccion')+'" and '+&
							'dslip_documento_ori = "'+dw_2.getitemstring(li_encontro,'movi_documento')+'" and '+&
							'dslip_referencia_ori = "'+dw_2.getitemstring(li_encontro,'movi_referencia')+'" and dslip_ann_ori = '+string(dw_2.getitemnumber(li_encontro,'movi_anno'))
				
				li_registro = dw_7.find(ls_find,1,dw_7.rowcount())			
				if li_registro = 0 then								
					dw_7.scrolltorow(dw_7.insertrow(0))
					dw_7.setitem(dw_7.getrow(),'dslip_g_financiero',str.g_financiero)
					dw_7.setitem(dw_7.getrow(),'dslip_empresa',str.empresa)
					dw_7.setitem(dw_7.getrow(),'dslip_documento',il_secuencia)			
					dw_7.setitem(dw_7.getrow(),'dslip_referencia',dw_1.getitemstring(1,'slip_referencia'))
					dw_7.setitem(dw_7.getrow(),'dslip_ann',ii_ann)			
					dw_7.setitem(dw_7.getrow(),'dslip_empresa_ori',dw_2.getitemnumber(li_encontro,'movi_empresa'))			
					dw_7.setitem(dw_7.getrow(),'dslip_aplicacion_ori',dw_2.getitemstring(li_encontro,'movi_aplicacion'))						
					dw_7.setitem(dw_7.getrow(),'dslip_transaccion_ori',dw_2.getitemstring(li_encontro,'movi_tipo_transaccion'))						
					dw_7.setitem(dw_7.getrow(),'dslip_sub_transaccion_ori',dw_2.getitemstring(li_encontro,'movi_sub_transaccion'))											
					dw_7.setitem(dw_7.getrow(),'dslip_documento_ori',dw_2.getitemstring(li_encontro,'movi_documento'))						
					dw_7.setitem(dw_7.getrow(),'dslip_referencia_ori',dw_2.getitemstring(li_encontro,'movi_referencia'))									
					dw_7.setitem(dw_7.getrow(),'dslip_ann_ori',dw_2.getitemnumber(li_encontro,'movi_anno'))						
					dw_7.setitem(dw_7.getrow(),'dslip_monto',dw_2.getitemnumber(li_encontro,'por_depositar'))					//movi_monto	
					dw_7.setitem(dw_7.getrow(),'dslip_monto_original',dw_2.getitemnumber(li_encontro,'por_depositar'))		//movi_monto				
					dw_7.setitem(dw_7.getrow(),'dslip_fecha',dw_2.getitemdatetime(li_encontro,'movi_fecha_tran'))			
					dw_7.setitem(dw_7.getrow(),'empresa',dw_2.getitemstring(li_encontro,'empresa'))									
					dw_7.setitem(dw_7.getrow(),'aplicado',1)						
					dw_2.setitem(li_encontro,'movi_cant_depositada', dw_2.getitemnumber(li_encontro,'movi_cant_depositada')+abs(dw_2.getitemnumber(li_encontro,'por_depositar')) )		//movi_monto	
				end if
			else
				
				ls_find = 'dslip_empresa_ori = '+string(dw_2.getitemnumber(li_encontro,'movi_empresa'))+' and dslip_aplicacion_ori = "'+dw_2.getitemstring(li_encontro,'movi_aplicacion')+'"  and '+&
							'dslip_transaccion_ori = "'+dw_2.getitemstring(li_encontro,'movi_tipo_transaccion')+'" and dslip_sub_transaccion_ori = "'+dw_2.getitemstring(li_encontro,'movi_sub_transaccion')+'" and '+&
							'dslip_documento_ori = "'+dw_2.getitemstring(li_encontro,'movi_documento')+'" and '+&
							'dslip_referencia_ori = "'+dw_2.getitemstring(li_encontro,'movi_referencia')+'" and dslip_ann_ori = '+string(dw_2.getitemnumber(li_encontro,'movi_anno'))
				
				li_registro = dw_7.find(ls_find,1,dw_7.rowcount())			
				if li_registro > 0 then
					dw_2.setitem(li_encontro,'movi_cant_depositada', dw_2.getitemnumber(li_encontro,'movi_cant_depositada') - abs(dw_7.getitemnumber(li_registro,'dslip_monto') ) )							
					dw_7.deleterow(li_registro)
					dw_1.setitem(1,'slip_monto',dw_7.getitemnumber(1,'total'))				
				end if
				
			end if
			li_encontro    =  dw_2.find(ls_cadena, li_encontro + 1, dw_2.rowcount())
		loop
	case 'aplicar'
		if dw_1.getitemnumber(1,'slip_estado') = 1 then return
		if data = '1' then
			dw_7.scrolltorow(dw_7.insertrow(0))
			dw_7.setitem(dw_7.getrow(),'dslip_g_financiero',str.g_financiero)
			dw_7.setitem(dw_7.getrow(),'dslip_empresa',str.empresa)
			dw_7.setitem(dw_7.getrow(),'dslip_documento',il_secuencia)			
			dw_7.setitem(dw_7.getrow(),'dslip_referencia',dw_1.getitemstring(1,'slip_referencia'))
			dw_7.setitem(dw_7.getrow(),'dslip_ann',ii_ann)			
			dw_7.setitem(dw_7.getrow(),'dslip_empresa_ori',dw_2.getitemnumber(row,'movi_empresa'))			
			dw_7.setitem(dw_7.getrow(),'dslip_aplicacion_ori',dw_2.getitemstring(row,'movi_aplicacion'))						
			dw_7.setitem(dw_7.getrow(),'dslip_transaccion_ori',dw_2.getitemstring(row,'movi_tipo_transaccion'))						
			dw_7.setitem(dw_7.getrow(),'dslip_sub_transaccion_ori',dw_2.getitemstring(row,'movi_sub_transaccion'))						
			dw_7.setitem(dw_7.getrow(),'dslip_documento_ori',dw_2.getitemstring(row,'movi_documento'))						
			dw_7.setitem(dw_7.getrow(),'dslip_referencia_ori',dw_2.getitemstring(row,'movi_referencia'))									
			dw_7.setitem(dw_7.getrow(),'dslip_ann_ori',dw_2.getitemnumber(row,'movi_anno'))						
			dw_7.setitem(dw_7.getrow(),'dslip_monto',dw_2.getitemnumber(row,'por_depositar'))						
			dw_7.setitem(dw_7.getrow(),'dslip_monto_original',dw_2.getitemnumber(row,'por_depositar'))									
			dw_7.setitem(dw_7.getrow(),'dslip_fecha',dw_2.getitemdatetime(row,'movi_fecha_tran'))			
			dw_7.setitem(dw_7.getrow(),'empresa',dw_2.getitemstring(row,'empresa'))									
			dw_7.setitem(dw_7.getrow(),'aplicado',1)						
			dw_2.setitem(row,'movi_cant_depositada', dw_2.getitemnumber(row,'movi_cant_depositada')+abs(dw_2.getitemnumber(row,'por_depositar') ) )			
		else
			wf_libera_aplicado()
		end if
		dw_1.setitem(1,'slip_monto',dw_7.getitemnumber(1,'total'))
end choose
end event

type dw_4 from datawindow within w_captura_depositos
boolean visible = false
integer x = 55
integer y = 20
integer width = 3611
integer height = 1876
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Impresión del Deposito"
string dataobject = "dw_impresion_deposito"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
string icon = "Report5!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_captura_depositos
integer x = 3890
integer y = 16
integer width = 439
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "ACTUALIZAR"
end type

event clicked;string ls_producto, ls_tipo, ls_cuenta, ls_documento, ls_referencia, ls_descrip, ls_iden, ls_mg, ls_comentario
decimal{2} ld_monto
integer i, li_linea
datetime ldt_fecha_tran, ldt_fecha
if dw_7.rowcount() = 0 then return

if dw_1.getitemnumber(1,'slip_estado') <> 0 then
	gf_mensaje('','El Deposito ya fue Actualizado, Verifique !!!',1,1,'E')
	return
end if

parent.triggerevent('ue_aceptar')

ld_monto = dw_1.getitemnumber(1,'slip_monto')
if ld_monto = 0 then
	gf_mensaje('','El Deposito no tiene montos asignados, Verifique !!!',1,1,'E')
	return
end if

ldt_fecha_tran = dw_1.getitemdatetime(1,'slip_fecha')
ldt_fecha = ldt_fecha_tran
ls_descrip = dw_1.getitemstring(1,'slip_observacion')
if not gf_valida_fecha_conta(ldt_fecha_tran) then
	return
end if

if gf_mensaje('','Esta seguro de actualizar el Deposito ?',2,1,'E') = 2 then return
	
	ls_documento  = string(il_secuencia)
	ls_referencia = dw_1.getitemstring(1,'slip_referencia')
	ls_comentario = dw_1.getitemstring(1,'slip_observacion')
	
		  SELECT bamcuent.cuen_mg_cuenta , cuen_id
			 INTO :ls_cuenta, :ii_cuenta_id
			 FROM bamcuent  
			WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
					( bamcuent.cuen_empresa = :str.empresa ) AND  
					( bamcuent.cuen_banco = :ii_banco ) AND  
					( bamcuent.cuen_no_cuenta = :is_cuenta_bancaria )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al seleccionar cuenta '+sqlca.sqlerrtext,1,1,'E')
				return 2
			end if
			
			ls_iden = string(ii_banco)+'-'+string(ii_cuenta_id)
			
			dw_3.reset()			
			dw_3.insertrow(1)
			dw_3.setitem(1,'ddia_fecha', date(gf_fecha_serv()))
			dw_3.setitem(1,'ddia_g_financiero',str.g_financiero)
			dw_3.setitem(1,'ddia_empresa',str.empresa)
			dw_3.setitem(1,'ddia_aplicacion_mg','CC')
			dw_3.setitem(1,'ddia_id', str.usuario)
			dw_3.setitem(1,'ddia_tipo_transaccion', 'SD')
			dw_3.setitem(1,'ddia_sub_trans', '0')
			dw_3.setitem(1,'naturaleza','D')	
			dw_3.setitem(1,'ddia_linea',1)
			dw_3.setitem(1,'ddia_ann',ii_ann)
			dw_3.setitem(1,'ddia_no_documento',ls_documento)
			dw_3.setitem(1,'ddia_no_referencia',ls_referencia)
			dw_3.setitem(1,'ddia_mg_cuenta',ls_cuenta)
			dw_3.setitem(1,'cuenta',ls_cuenta)
			dw_3.setitem(1,'ddia_monto',ld_monto)
			dw_3.setitem(1,'monto_debito',ld_monto)
			dw_3.setitem(1,'ddia_banco_cuenta',ls_iden)
						
			  SELECT dgmserdr.serd_mgcuenta  
				 INTO :ls_cuenta  
				 FROM dgmserdr  
				WHERE ( dgmserdr.serd_g_financiero = :str.g_financiero ) AND  
						( dgmserdr.serd_empresa = :str.empresa ) AND  
						( dgmserdr.serd_transaccion = 'SD' ) AND  
						( dgmserdr.serd_sub_trans = '0' ) AND  
						( dgmserdr.serd_aplicacion = 'CC' )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al seleccionar cuenta credito '+sqlca.sqlerrtext,1,1,'E')
				return 
			end if
			
			if ls_cuenta = '' or isnull(ls_cuenta) then
				gf_mensaje('','Debe Asignar la Cuenta a la Transaccion SD',1,1,'E')
				return
			end if
			
			dw_3.insertrow(2)
			dw_3.setitem(2,'ddia_fecha', date(gf_fecha_serv()))
			dw_3.setitem(2,'ddia_g_financiero',str.g_financiero)
			dw_3.setitem(2,'ddia_empresa',str.empresa)
			dw_3.setitem(2,'ddia_aplicacion_mg','CC')
			dw_3.setitem(2,'ddia_id', str.usuario)
			dw_3.setitem(2,'ddia_tipo_transaccion', 'SD')
			dw_3.setitem(2,'ddia_sub_trans', '0')
			dw_3.setitem(2,'naturaleza','C')	
			dw_3.setitem(2,'ddia_linea',2)
			dw_3.setitem(2,'ddia_ann',ii_ann)
			dw_3.setitem(2,'ddia_no_documento',ls_documento)
			dw_3.setitem(2,'ddia_no_referencia',ls_referencia)
			dw_3.setitem(2,'ddia_mg_cuenta',ls_cuenta)
			dw_3.setitem(2,'cuenta',ls_cuenta)
			dw_3.setitem(2,'ddia_monto',ld_monto)
			dw_3.setitem(2,'monto_credito',ld_monto)
			dw_3.setitem(2,'ddia_banco_cuenta',ls_iden)						
			
			sqlca.autocommit = false
			
				  INSERT INTO cotdiari  
					( diar_g_financiero,   
					  diar_empresa,   
					  diar_aplicacion_mg,   
					  diar_tipo_transaccion,   
					  diar_sub_trans,   
					  diar_no_documento,   
					  diar_no_referencia,   
					  diar_banco_cuenta,
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
					  diar_nombre,
					  diar_comentario)  
		  VALUES ( :str.g_financiero,   
					  :str.empresa,   
					  'CC',   
					  'SD',   
					  '0',   
					  :ls_documento,   
					  :ls_referencia,   
					  :ls_iden,
					  :ii_ann,   
					  :ldt_fecha,   
					  :ls_descrip,   
					  :str.usuario,   
					  getdate(),   
					  'I',   
					  :ld_monto,   
					  1,   
					  0,   
					  'N',   
					  'N',   
					  null,   
					  null,   
					  'SLIP DE DEPOSITO',
					  :ls_comentario)  ;
				  if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Insertar encabezado contable '+sqlca.sqlerrtext,1,1,'E')
						rollback;
						sqlca.autocommit = true
						return 
				  end if
	
			if	dw_3.update() = -1 then	
					gf_mensaje('','Error al Insertar detalle contable '+sqlca.sqlerrtext,1,1,'E')
					rollback;
					sqlca.autocommit = true
					return 								
			end if

			//Inserta en Bancos como una transaccion historica
				  INSERT INTO batdiari  
					( btdi_g_financiero,   
					  btdi_empresa,   
					  btdi_tipo_transaccion,   
					  btdi_sub_transaccion,   
					  btdi_banco,   
					  btdi_no_cuenta,   
					  btdi_documento,   
					  btdi_referencia,   
					  btdi_ann,   
					  btdi_aplicacion,   
					  btdi_fecha_tran,   
					  btdi_fecha_reg,   
					  btdi_tercero,   
					  btdi_a_nombre_de,   
					  btdi_naturaleza,   
					  btdi_comentario,   
					  btdi_id_usuario_registra,   
					  btdi_estado,   					
					  btdi_monto,   
					  btdi_aplica_origen,   
					  btdi_conciliacion,   
					  btdi_ruc,   
					  btdi_digito_verificador,   
					  btdi_impreso,   
					  btdi_cuenta,   
					  btdi_historico,   
					  btdi_fecha_habilita_deposito,   
					  btdi_comentario2)  
		  VALUES ( :str.g_financiero,   
					  :str.empresa,   
					  'SD',   
					  '0',   
					  :ii_banco,   
					  :is_cuenta_bancaria,   
					  :ls_documento,   
					  :ls_referencia,   
					  :ii_ann,   
					  'CC',   
					  :ldt_fecha,   
					  getdate(),   
					  null,   
					  'SLIP DE DEPOSITO',   
					  'D',   
					  :ls_descrip,   
					  :str.usuario,   
					  'A',   
					  :ld_monto,   
					  'CC',   
					  'P',   
					  null,   
					  null,   
					  'N',   
					  null,   
					  1,   
					  null,   
					  :ls_descrip)  ;
				if sqlca.sqlcode = -1 then
					ls_mg = sqlca.sqlerrtext
					rollback;
					sqlca.autocommit = true;				
					messagebox('Error al Insertar Deposito ',ls_mg)
					return
				end if

  UPDATE cctslips  
     SET slip_estado = 1  
   WHERE ( cctslips.slip_g_financiero = :str.g_financiero ) AND  
         ( cctslips.slip_empresa = :str.empresa ) AND  
         ( cctslips.slip_documento = :il_secuencia ) AND  
		( cctslips.slip_referencia = :ls_referencia ) AND	
         ( cctslips.slip_ann = :ii_ann )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al Actualizar Estado '+sqlca.sqlerrtext,1,1,'E')
		rollback;
		sqlca.autocommit = true
		return
	end if
dw_1.setitem(1,'slip_estado',1)

sqlca.autocommit = true		
commit;

parent.triggerevent('ue_print')
end event

type uo_1 from u_ddcalen within w_captura_depositos
boolean visible = false
integer x = 2528
integer y = 116
integer taborder = 21
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;datetime ldt_fecha_tran, ldt_fecha_anterior
time lt_time
lt_time = time('00:00:00')
integer li_ann_anterior 
dw_1.SetItem ( dw_1.getrow(), 'slip_fecha', uo_1.return_sel_date() )

if uo_1.allow_close then
	this.visible=false
	dw_1.SetFocus()
	
		ldt_fecha_tran 	 = dw_1.getitemdatetime(dw_1.getrow(),'slip_fecha')		
		ldt_fecha_anterior = dw_1.getitemdatetime(dw_1.getrow(),'slip_fecha', Primary!, True)		
		if ldt_fecha_anterior = ldt_fecha_tran then
			ldt_fecha_anterior = datetime(date(gf_fecha_serv()),lt_time)
		end if
		if not gf_valida_fecha_conta(ldt_fecha_anterior) then			
			dw_1.setitem(1,'slip_fecha', ldt_fecha_anterior)
			dw_1.setcolumn('slip_fecha')
			return
		end if

		if not gf_valida_fecha_conta(ldt_fecha_tran) then			
			dw_1.setitem(1,'slip_fecha', ldt_fecha_anterior)
			dw_1.setcolumn('slip_fecha')
			return
		end if
		
		if not gf_valida_fecha_futura(ldt_fecha_tran) then			
			if ldt_fecha_tran = ldt_fecha_anterior then
				dw_1.setitem(1,'slip_fecha', date(gf_fecha_serv()))				
			else
				dw_1.setitem(1,'slip_fecha', ldt_fecha_anterior)
			end if
			dw_1.setcolumn('slip_fecha')
			return
		end if
		
		//Valida fecha de conciliacion bancaria
		if not gf_valida_fecha_bancos(ldt_fecha_anterior, is_cuenta_bancaria, ii_banco) then			
			dw_1.setitem(1,'slip_fecha', ldt_fecha_anterior)
			dw_1.setcolumn('slip_fecha')
			return
		end if
	
		if not gf_valida_fecha_bancos(ldt_fecha_tran, is_cuenta_bancaria, ii_banco) then			
			dw_1.setitem(1,'slip_fecha', ldt_fecha_anterior)
			dw_1.setcolumn('slip_fecha')
			return
		end if

	ii_ann = year(date(dw_1.getitemdatetime(dw_1.getrow(),'slip_fecha')))
	dw_1.setitem(1,'slip_ann',ii_ann)
	if ii_ann <> year(date(gf_fecha_serv())) then	wf_orden_nueva()
end if
end event

on uo_1.destroy
call u_ddcalen::destroy
end on

type dw_7 from datawindow within w_captura_depositos
integer x = 3182
integer y = 512
integer width = 1774
integer height = 1704
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Depositado"
string dataobject = "dw_detalle_depositos"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemfocuschanged;this.selecttext(1,100)
end event

event itemchanged;this.accepttext()
string ls_referencia, ls_find
integer li_registro
decimal{2} ld_monto, ld_total
choose case dwo.name
	case 'aplicado'
		wf_libera_aplicado_depositado()
	case 'dslip_monto'
		ld_monto = this.getitemnumber(row,'dslip_monto')
		ld_total = this.getitemnumber(row,'dslip_monto_original')
		if abs(ld_monto) > abs(ld_total) then
			gf_mensaje('','Verifique el Monto',1,1,'E')
			this.setitem(row,'dslip_monto',ld_total)
			dw_1.setitem(1,'slip_monto',dw_7.getitemnumber(1,'total'))				
			return 2
		end if
		dw_1.setitem(1,'slip_monto',dw_7.getitemnumber(1,'total'))	
		
		//Modifica la cantidad Deposotada
		ls_find = 'movi_empresa = '+string(dw_7.getitemnumber(dw_7.getrow(),'dslip_empresa_ori'))+' and movi_aplicacion = "'+dw_7.getitemstring(dw_7.getrow(),'dslip_aplicacion_ori')+'"  and '+&
					'movi_tipo_transaccion = "'+dw_7.getitemstring(dw_7.getrow(),'dslip_transaccion_ori')+'" and movi_sub_transaccion = "'+dw_7.getitemstring(dw_7.getrow(),'dslip_sub_transaccion_ori')+'" and '+&
					'movi_documento = "'+dw_7.getitemstring(dw_7.getrow(),'dslip_documento_ori')+'" and '+&
					'movi_referencia = "'+dw_7.getitemstring(dw_7.getrow(),'dslip_referencia_ori')+'" and movi_anno = '+string(dw_7.getitemnumber(dw_7.getrow(),'dslip_ann_ori'))
		
		li_registro = dw_2.find(ls_find,1,dw_2.rowcount())			
		if li_registro > 0 then
			dw_2.scrolltorow(li_registro)
			dw_2.setitem(li_registro,'movi_cant_depositada', dw_2.getitemnumber(li_registro,'movi_cant_depositada', Primary!, true) + dw_7.getitemnumber(dw_7.getrow(),'dslip_monto') )							
		end if

end choose

end event

event retrieveend;integer i, li_registro
string ls_find

if rowcount = 0 then return

dw_2.setfilter('')
dw_2.filter()

for i = 1 to rowcount
	this.setitem(i,'aplicado',1)

	ls_find = 'movi_empresa = '+string(dw_7.getitemnumber(i,'dslip_empresa_ori'))+' and movi_aplicacion = "'+dw_7.getitemstring(i,'dslip_aplicacion_ori')+'"  and '+&
				'movi_tipo_transaccion = "'+dw_7.getitemstring(i,'dslip_transaccion_ori')+'" and movi_sub_transaccion = "'+dw_7.getitemstring(i,'dslip_sub_transaccion_ori')+'" and '+&
				'movi_documento = "'+dw_7.getitemstring(i,'dslip_documento_ori')+'" and '+&
				'movi_referencia = "'+dw_7.getitemstring(i,'dslip_referencia_ori')+'" and movi_anno = '+string(dw_7.getitemnumber(i,'dslip_ann_ori'))
	
	li_registro = dw_2.find(ls_find,1,dw_2.rowcount())			
	if li_registro > 0 then
		dw_2.scrolltorow(li_registro)
		dw_2.setitem(li_registro,'por_depositar', dw_2.getitemnumber(li_registro,'por_depositar') + dw_7.getitemnumber(i,'dslip_monto') )							
		dw_2.setitem(li_registro,'aplicar',1)
	end if
	
next

dw_2.setfilter('por_depositar <> 0')
dw_2.filter()

end event

type cb_1 from commandbutton within w_captura_depositos
integer x = 3141
integer y = 380
integer width = 402
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "GUARDAR"
end type

event clicked;PARENT.TRIGGEREVENT('ue_aceptar')
end event

type dw_3 from datawindow within w_captura_depositos
boolean visible = false
integer x = 55
integer y = 1092
integer width = 3858
integer height = 800
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle Contable"
string dataobject = "dw_detalle_contable"
boolean controlmenu = true
boolean vscrollbar = true
string icon = "AppIcon!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;integer i
datawindowchild ldwc_proveedor

if dwo.name = 'b_cerrar' then
	this.update()
	this.visible = false
	if this.dataobject = 'dw_proveedores' then
		dw_1.getchild('enca_proveedor', ldwc_proveedor)
		ldwc_proveedor.settransobject(sqlca)
		ldwc_proveedor.retrieve()
		dw_1.setfocus()
		dw_1.setcolumn('enca_proveedor')
	end if
elseif dwo.name = 'b_grabar' then
	for i = 1 to this.rowcount()
		this.setitem(i,'prod_g_financiero', str.g_financiero)
		this.setitem(i,'prod_empresa', str.empresa)
	next
	if this.update() = -1 then
		gf_mensaje('','Error al actualizar '+sqlca.sqlerrtext,1,1,'E')
	end if
end if
end event

type cb_3 from commandbutton within w_captura_depositos
integer x = 3872
integer y = 376
integer width = 526
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Eliminar Deposito"
end type

event clicked;datetime ldt_fecha_tran, ldt_fecha
string ls_iden, ls_documento, ls_referencia, ls_app, ls_tran, ls_stran, ls_suc, ls_doc, ls_ref, ls_cadena
decimal{2} ld_monto
integer li_empresa, li_ann_dep

		if dw_1.getitemNumber(1,'slip_estado') = 2 then 
			gf_mensaje('','El Deposito ya fue Eliminado, Verifique !!!',1,1,'E')
			return
		end if

		if gf_mensaje('','Esta Seguro de Eliminar el Deposito ?',2,2,'E') = 1 then
			
			//OpenWithParm(w_clave_autorizada_nota_credito, parent)

			If is_user = "*" then
				return
			end if						
			
			ldt_fecha_tran = dw_1.getitemdatetime(1,'slip_fecha')

			if not gf_valida_fecha_conta(ldt_fecha_tran) then			
				return 
			end if  
			
			if not gf_valida_fecha_bancos(ldt_fecha_tran, is_cuenta_bancaria, ii_banco) then			
				return 
			end if
			
			sqlca.autocommit = false

				ls_documento = string(dw_1.getitemnumber(1,'slip_documento'))
				ls_referencia = dw_1.getitemstring(1,'slip_referencia')
				
					  SELECT cuen_id
						 INTO :ii_cuenta_id
						 FROM bamcuent  
						WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
								( bamcuent.cuen_empresa = :str.empresa ) AND  
								( bamcuent.cuen_banco = :ii_banco ) AND  
								( bamcuent.cuen_no_cuenta = :is_cuenta_bancaria )   ;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al seleccionar cuenta '+sqlca.sqlerrtext,1,1,'E')
							rollback;
							sqlca.autocommit = true
							return 
						end if
						
						ls_iden = string(ii_banco)+'-'+string(ii_cuenta_id)
						
						  DELETE FROM coddiari  
							WHERE ( coddiari.ddia_g_financiero = :str.g_financiero ) AND  
									( coddiari.ddia_empresa = :str.empresa ) AND  
									( coddiari.ddia_aplicacion_mg = 'CC' ) AND  
									( coddiari.ddia_tipo_transaccion = 'SD' ) AND  
									( coddiari.ddia_sub_trans = '0' ) AND  
									( coddiari.ddia_no_documento = :ls_documento ) AND  
									( coddiari.ddia_no_referencia = :ls_referencia ) AND  
									( coddiari.ddia_banco_cuenta = :ls_iden ) AND  
									( coddiari.ddia_ann = :ii_ann )   ;
								if sqlca.sqlcode = -1 then
									gf_mensaje('','Error al Eliminar Detalle Contable '+sqlca.sqlerrtext,1,1,'E')
									rollback;
									sqlca.autocommit = true
									return 
								end if

						  DELETE FROM cotdiari  
							WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
									( cotdiari.diar_empresa = :str.empresa ) AND  
									( cotdiari.diar_aplicacion_mg = 'CC' ) AND  
									( cotdiari.diar_tipo_transaccion = 'SD' ) AND  
									( cotdiari.diar_sub_trans = '0' ) AND  
									( cotdiari.diar_no_documento = :ls_documento ) AND  
									( cotdiari.diar_no_referencia = :ls_referencia ) AND  
									( cotdiari.diar_banco_cuenta = :ls_iden ) AND  
									( cotdiari.diar_ann = :ii_ann )   ;
								if sqlca.sqlcode = -1 then
									gf_mensaje('','Error al Eliminar Encabezado Contable '+sqlca.sqlerrtext,1,1,'E')
									rollback;
									sqlca.autocommit = true
									return 
								end if

								  DELETE FROM batdiari  
									WHERE ( batdiari.btdi_g_financiero = :str.g_financiero ) AND  
											( batdiari.btdi_empresa = :str.empresa ) AND  
											( batdiari.btdi_tipo_transaccion = 'SD' ) AND  
											( batdiari.btdi_sub_transaccion = '0' ) AND  
											( batdiari.btdi_banco = :ii_banco ) AND  
											( batdiari.btdi_no_cuenta = :is_cuenta_bancaria ) AND  
											( batdiari.btdi_documento = :ls_documento ) AND  
											( batdiari.btdi_referencia = :ls_referencia ) AND  
											( batdiari.btdi_ann = :ii_ann ) AND  
											( batdiari.btdi_aplicacion = 'CC' )   ;
								if sqlca.sqlcode = -1 then
									gf_mensaje('','Error al Eliminar Encabezado Bancos '+sqlca.sqlerrtext,1,1,'E')
									rollback;
									sqlca.autocommit = true
									return 
								end if
						
						//Ciclo para restaurar la cantidad depositada a los documentos
				 DECLARE cur_dep CURSOR FOR  
			  SELECT ccdslips.dslip_empresa_ori,   
						ccdslips.dslip_aplicacion_ori,   
						ccdslips.dslip_transaccion_ori,   
						ccdslips.dslip_sub_transaccion_ori,   
						ccdslips.dslip_documento_ori,   
						ccdslips.dslip_referencia_ori,   
						ccdslips.dslip_ann_ori,   
						ccdslips.dslip_monto  
				 FROM ccdslips  
				WHERE ( ccdslips.dslip_g_financiero = :str.g_financiero ) AND  
						( ccdslips.dslip_empresa = :str.empresa ) AND  
						( ccdslips.dslip_documento = :il_secuencia ) AND  
						( ccdslips.dslip_referencia = :ls_referencia ) AND  
						( ccdslips.dslip_ann = :ii_ann )   ;
							if sqlca.sqlcode = -1 then
									gf_mensaje('','Error al Eliminar Encabezado Bancos '+sqlca.sqlerrtext,1,1,'E')
									rollback;
									sqlca.autocommit = true
									return 
								end if
					open cur_dep;
					
					fetch cur_dep into :li_empresa, :ls_app, :ls_tran, :ls_stran, :ls_doc, :ls_ref, :li_ann_dep, :ld_monto;
								
					do while sqlca.sqlcode = 0
						
						  UPDATE cctmovim  
						  SET movi_cant_depositada = movi_cant_depositada - :ld_monto  
						WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
								( cctmovim.movi_empresa = :li_empresa ) AND  
								( cctmovim.movi_aplicacion = :ls_app ) AND  
								( cctmovim.movi_tipo_transaccion = :ls_tran ) AND  
								( cctmovim.movi_sub_transaccion = :ls_stran ) AND  
								( cctmovim.movi_documento = :ls_doc ) AND  
								( cctmovim.movi_anno = :li_ann_dep ) AND  
								( cctmovim.movi_referencia = :ls_ref )  ;
								if sqlca.sqlcode = -1 then
									gf_mensaje('','Error al Actualizar Cantidad Depositada '+sqlca.sqlerrtext,1,1,'E')
									rollback;
									sqlca.autocommit = true
									return 
								end if
						
						fetch cur_dep into :li_empresa, :ls_app, :ls_tran, :ls_stran, :ls_doc, :ls_ref, :li_ann_dep, :ld_monto;
					loop
					close cur_dep;
						//
							  DELETE FROM ccdslips  
								WHERE ( ccdslips.dslip_g_financiero = :str.g_financiero ) AND  
										( ccdslips.dslip_empresa = :str.empresa ) AND  
										( ccdslips.dslip_documento = :il_secuencia ) AND  
										( ccdslips.dslip_referencia = :ls_referencia ) AND  
										( ccdslips.dslip_ann = :ii_ann )   ;
								if sqlca.sqlcode = -1 then
									gf_mensaje('','Error al Eliminar Detalle del Slip '+sqlca.sqlerrtext,1,1,'E')
									rollback;
									sqlca.autocommit = true
									return 
								end if
			
					  UPDATE cctslips  
					  SET slip_estado = 2  ,
					  		slip_usuario_eliminado = :str.usuario,
							slip_fecha_eliminado = getdate(),
							slip_motivo_eliminacion = :is_motivo
					WHERE ( cctslips.slip_g_financiero = :str.g_financiero ) AND  
							( cctslips.slip_empresa = :str.empresa ) AND  
							( cctslips.slip_documento = :il_secuencia ) AND  
							( cctslips.slip_referencia = :ls_referencia ) AND  	
							( cctslips.slip_ann = :ii_ann )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Actualizar Estado '+sqlca.sqlerrtext,1,1,'E')
						rollback;
						sqlca.autocommit = true
						return
					end if
	
			dw_1.setitem(1,'slip_estado',2)
			dw_1.setitem(1,'slip_usuario_eliminado',str.usuario)
			dw_1.setitem(1,'slip_fecha_eliminado',gf_fecha_serv())			
			dw_1.setitem(1,'slip_motivo_eliminacion',is_motivo)			

			dw_7.reset()		
			ldt_fecha = dw_1.getitemdatetime(dw_1.getrow(),'fecha')
			dw_2.retrieve(str.g_financiero, str.empresa)
			if ii_filtrar_fecha = 1 then
				ls_cadena = 'por_depositar <> 0 and date(movi_fecha_tran) = date("' +string(date(ldt_fecha))+'")'
				dw_2.setfilter(ls_cadena)
				dw_2.filter()
			else
				dw_2.setfilter('por_depositar <> 0')
				dw_2.filter()
			end if		
			
			sqlca.autocommit = true
	end if
end event

type cb_4 from commandbutton within w_captura_depositos
boolean visible = false
integer x = 3840
integer y = 228
integer width = 599
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "ACTUALIZAR OLD OK"
end type

event clicked;string ls_producto, ls_tipo, ls_cuenta, ls_documento, ls_referencia, ls_descrip, ls_iden, ls_mg, ls_comentario, ls_cuenta_caja
decimal{2} ld_monto
integer i, li_linea
datetime ldt_fecha_tran, ldt_fecha

SELECT dgmserdr.serd_mgcuenta  
					 INTO :ls_cuenta_caja  
					 FROM dgmserdr  
					WHERE ( dgmserdr.serd_g_financiero = :str.g_financiero ) AND  
							( dgmserdr.serd_empresa = :str.empresa ) AND  
							( dgmserdr.serd_transaccion = 'SD' ) AND  
							( dgmserdr.serd_sub_trans = '0' ) AND  
							( dgmserdr.serd_aplicacion = 'CC' )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al seleccionar cuenta credito '+sqlca.sqlerrtext,1,1,'E')
					return 
				end if
				
				if ls_cuenta_caja = '' or isnull(ls_cuenta_caja) then
					gf_mensaje('','Debe Asignar la Cuenta a la Transaccion SD',1,1,'E')
					return
				end if

for i = 1 to dw_5.rowcount()
	dw_5.scrolltorow(i)
	ls_documento = string(dw_5.getitemnumber(i,'slip_documento'))
	il_secuencia = long(is_documento)
	ii_banco = dw_5.getitemnumber(i,'slip_banco')
	is_cuenta_bancaria = dw_5.getitemstring(i,'slip_cuenta')
		ld_monto = dw_5.getitemnumber(i,'slip_monto')
	if ld_monto = 0 then
		gf_mensaje('','El Deposito no tiene montos asignados, Verifique !!!',1,1,'E')
		//return
	end if
	
	ldt_fecha_tran = dw_5.getitemdatetime(i,'slip_fecha')
	ldt_fecha = ldt_fecha_tran
	ls_descrip = dw_5.getitemstring(i,'slip_observacion')
	
		ls_referencia = dw_5.getitemstring(i,'slip_referencia')
		ls_comentario = dw_5.getitemstring(i,'slip_observacion')
		
			  SELECT bamcuent.cuen_mg_cuenta , cuen_id
				 INTO :ls_cuenta, :ii_cuenta_id
				 FROM bamcuent  
				WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
						( bamcuent.cuen_empresa = :str.empresa ) AND  
						( bamcuent.cuen_banco = :ii_banco ) AND  
						( bamcuent.cuen_no_cuenta = :is_cuenta_bancaria )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al seleccionar cuenta '+sqlca.sqlerrtext,1,1,'E')
					return 2
				end if
				
				ls_iden = string(ii_banco)+'-'+string(ii_cuenta_id)
				
				dw_3.reset()			
				dw_3.insertrow(1)
				dw_3.setitem(1,'ddia_fecha', ldt_fecha)
				dw_3.setitem(1,'ddia_g_financiero',str.g_financiero)
				dw_3.setitem(1,'ddia_empresa',str.empresa)
				dw_3.setitem(1,'ddia_aplicacion_mg','CC')
				dw_3.setitem(1,'ddia_id', str.usuario)
				dw_3.setitem(1,'ddia_tipo_transaccion', 'SD')
				dw_3.setitem(1,'ddia_sub_trans', '0')
				dw_3.setitem(1,'naturaleza','D')	
				dw_3.setitem(1,'ddia_linea',1)
				dw_3.setitem(1,'ddia_ann',ii_ann)
				dw_3.setitem(1,'ddia_no_documento',ls_documento)
				dw_3.setitem(1,'ddia_no_referencia',ls_referencia)
				dw_3.setitem(1,'ddia_mg_cuenta',ls_cuenta)
				dw_3.setitem(1,'cuenta',ls_cuenta)
				dw_3.setitem(1,'ddia_monto',ld_monto)
				dw_3.setitem(1,'monto_debito',ld_monto)
				dw_3.setitem(1,'ddia_banco_cuenta',ls_iden)
							
				  
				
				dw_3.insertrow(2)
				dw_3.setitem(2,'ddia_fecha', ldt_fecha)
				dw_3.setitem(2,'ddia_g_financiero',str.g_financiero)
				dw_3.setitem(2,'ddia_empresa',str.empresa)
				dw_3.setitem(2,'ddia_aplicacion_mg','CC')
				dw_3.setitem(2,'ddia_id', str.usuario)
				dw_3.setitem(2,'ddia_tipo_transaccion', 'SD')
				dw_3.setitem(2,'ddia_sub_trans', '0')
				dw_3.setitem(2,'naturaleza','C')	
				dw_3.setitem(2,'ddia_linea',2)
				dw_3.setitem(2,'ddia_ann',ii_ann)
				dw_3.setitem(2,'ddia_no_documento',ls_documento)
				dw_3.setitem(2,'ddia_no_referencia',ls_referencia)
				dw_3.setitem(2,'ddia_mg_cuenta',ls_cuenta_caja)
				dw_3.setitem(2,'cuenta',ls_cuenta_caja)
				dw_3.setitem(2,'ddia_monto',ld_monto)
				dw_3.setitem(2,'monto_credito',ld_monto)
				dw_3.setitem(2,'ddia_banco_cuenta',ls_iden)						
				
		
				if	dw_3.update() = -1 then	
						gf_mensaje('','Error al Insertar detalle contable '+sqlca.sqlerrtext,1,1,'E')
						rollback;
						sqlca.autocommit = true
						return 								
				end if
	
				  UPDATE cctslips  
					     SET slip_motivo_eliminacion = 'OK'  
					   WHERE ( cctslips.slip_g_financiero = :str.g_financiero ) AND  
					         ( cctslips.slip_empresa = :str.empresa ) AND  
					         ( cctslips.slip_documento = :il_secuencia ) AND  
					         ( cctslips.slip_referencia = :ls_referencia ) AND  
					         ( cctslips.slip_ann = :ii_ann )   ;
				if sqlca.sqlcode = -1 then			
					gf_mensaje('','Error al Actualizar cuenta '+sqlca.sqlerrtext,1,1,'E')
					rollback;
					return 
				end if
	
	sqlca.autocommit = true		
	commit;
	
next
end event

type dw_5 from datawindow within w_captura_depositos
boolean visible = false
integer x = 142
integer y = 384
integer width = 4539
integer height = 776
integer taborder = 60
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "aa_actualizar_detalle_slips"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_5 from commandbutton within w_captura_depositos
boolean visible = false
integer x = 4809
integer y = 112
integer width = 507
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "ACTUALIZAR OLD"
end type

event clicked;string ls_producto, ls_tipo, ls_cuenta, ls_documento, ls_referencia, ls_descrip, ls_iden, ls_mg, ls_comentario
decimal{2} ld_monto
integer i, li_linea
datetime ldt_fecha_tran, ldt_fecha

ld_monto = dw_1.getitemnumber(1,'slip_monto')
if ld_monto = 0 then
	gf_mensaje('','El Deposito no tiene montos asignados, Verifique !!!',1,1,'E')
	return
end if

ldt_fecha_tran = dw_1.getitemdatetime(1,'slip_fecha')
ldt_fecha = ldt_fecha_tran
ls_descrip = dw_1.getitemstring(1,'slip_observacion')
if not gf_valida_fecha_conta(ldt_fecha_tran) then
	return
end if
	
	ls_documento  = string(il_secuencia)
	ls_referencia = dw_1.getitemstring(1,'slip_referencia')
	ls_comentario = dw_1.getitemstring(1,'slip_observacion')
	
		  SELECT bamcuent.cuen_mg_cuenta , cuen_id
			 INTO :ls_cuenta, :ii_cuenta_id
			 FROM bamcuent  
			WHERE ( bamcuent.cuen_g_financiero = :str.g_financiero ) AND  
					( bamcuent.cuen_empresa = :str.empresa ) AND  
					( bamcuent.cuen_banco = :ii_banco ) AND  
					( bamcuent.cuen_no_cuenta = :is_cuenta_bancaria )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al seleccionar cuenta '+sqlca.sqlerrtext,1,1,'E')
				return 2
			end if
			
			ls_iden = string(ii_banco)+'-'+string(ii_cuenta_id)
			
			dw_3.reset()			
			dw_3.insertrow(1)
			dw_3.setitem(1,'ddia_fecha', date(gf_fecha_serv()))
			dw_3.setitem(1,'ddia_g_financiero',str.g_financiero)
			dw_3.setitem(1,'ddia_empresa',str.empresa)
			dw_3.setitem(1,'ddia_aplicacion_mg','CC')
			dw_3.setitem(1,'ddia_id', str.usuario)
			dw_3.setitem(1,'ddia_tipo_transaccion', 'SD')
			dw_3.setitem(1,'ddia_sub_trans', '0')
			dw_3.setitem(1,'naturaleza','D')	
			dw_3.setitem(1,'ddia_linea',1)
			dw_3.setitem(1,'ddia_ann',ii_ann)
			dw_3.setitem(1,'ddia_no_documento',ls_documento)
			dw_3.setitem(1,'ddia_no_referencia',ls_referencia)
			dw_3.setitem(1,'ddia_mg_cuenta',ls_cuenta)
			dw_3.setitem(1,'cuenta',ls_cuenta)
			dw_3.setitem(1,'ddia_monto',ld_monto)
			dw_3.setitem(1,'monto_debito',ld_monto)
			dw_3.setitem(1,'ddia_banco_cuenta',ls_iden)
						
			  SELECT dgmserdr.serd_mgcuenta  
				 INTO :ls_cuenta  
				 FROM dgmserdr  
				WHERE ( dgmserdr.serd_g_financiero = :str.g_financiero ) AND  
						( dgmserdr.serd_empresa = :str.empresa ) AND  
						( dgmserdr.serd_transaccion = 'SD' ) AND  
						( dgmserdr.serd_sub_trans = '0' ) AND  
						( dgmserdr.serd_aplicacion = 'CC' )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al seleccionar cuenta credito '+sqlca.sqlerrtext,1,1,'E')
				return 
			end if
			
			if ls_cuenta = '' or isnull(ls_cuenta) then
				gf_mensaje('','Debe Asignar la Cuenta a la Transaccion SD',1,1,'E')
				return
			end if
			
			dw_3.insertrow(2)
			dw_3.setitem(2,'ddia_fecha', date(gf_fecha_serv()))
			dw_3.setitem(2,'ddia_g_financiero',str.g_financiero)
			dw_3.setitem(2,'ddia_empresa',str.empresa)
			dw_3.setitem(2,'ddia_aplicacion_mg','CC')
			dw_3.setitem(2,'ddia_id', str.usuario)
			dw_3.setitem(2,'ddia_tipo_transaccion', 'SD')
			dw_3.setitem(2,'ddia_sub_trans', '0')
			dw_3.setitem(2,'naturaleza','C')	
			dw_3.setitem(2,'ddia_linea',2)
			dw_3.setitem(2,'ddia_ann',ii_ann)
			dw_3.setitem(2,'ddia_no_documento',ls_documento)
			dw_3.setitem(2,'ddia_no_referencia',ls_referencia)
			dw_3.setitem(2,'ddia_mg_cuenta',ls_cuenta)
			dw_3.setitem(2,'cuenta',ls_cuenta)
			dw_3.setitem(2,'ddia_monto',ld_monto)
			dw_3.setitem(2,'monto_credito',ld_monto)
			dw_3.setitem(2,'ddia_banco_cuenta',ls_iden)						
			
			sqlca.autocommit = false
	
			if	dw_3.update() = -1 then	
					gf_mensaje('','Error al Insertar detalle contable '+sqlca.sqlerrtext,1,1,'E')
					rollback;
					sqlca.autocommit = true
					return 								
			end if


sqlca.autocommit = true		
commit;


end event

