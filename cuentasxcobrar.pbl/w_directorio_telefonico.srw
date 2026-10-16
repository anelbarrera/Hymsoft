forward
global type w_directorio_telefonico from w_grampa_tab
end type
type dw_5 from datawindow within tabpage_1
end type
type pb_pdf from picturebutton within tabpage_1
end type
type dw_4 from datawindow within tabpage_2
end type
type cb_2 from commandbutton within tabpage_2
end type
type cb_1 from commandbutton within tabpage_2
end type
type pb_1 from picturebutton within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type pb_mala from picturebutton within tabpage_2
end type
type st_texto_cuenta_mala from statictext within tabpage_2
end type
type st_1 from statictext within w_directorio_telefonico
end type
type pb_top from picturebutton within w_directorio_telefonico
end type
type pb_back from picturebutton within w_directorio_telefonico
end type
type pb_next from picturebutton within w_directorio_telefonico
end type
type pb_bottom from picturebutton within w_directorio_telefonico
end type
type dw_6 from datawindow within w_directorio_telefonico
end type
end forward

global type w_directorio_telefonico from w_grampa_tab
integer width = 4050
integer height = 2688
string title = "Directorio Telefónico"
boolean controlmenu = false
long backcolor = 12639424
windowanimationstyle openanimation = centeranimation!
windowanimationstyle closeanimation = centeranimation!
event ue_save_as ( )
event ue_close ( )
st_1 st_1
pb_top pb_top
pb_back pb_back
pb_next pb_next
pb_bottom pb_bottom
dw_6 dw_6
end type
global w_directorio_telefonico w_directorio_telefonico

type variables
datawindow idw_1, idw_2, idw_3, idw_5
datawindowchild idwc_region, idwc_tipo
window iw_window
integer il_tab_activo
boolean ib_cerrar, ib_blink = false
string is_user
long il_segundos
str_rangofecha istr_rangfech, lstr_rangfech
n_cst_winsrv_shell32	nv_f
end variables

forward prototypes
public function boolean wf_asigna_antig ()
public function boolean wf_antiguedad ()
public function boolean wf_actualiza_antiguedad (datetime adt_desde, datetime adt_hasta, long al_tercero)
public subroutine wf_setear_user (string as_user)
public function boolean wf_cambiar_limite ()
public subroutine wf_actualiza_antiguedad (string idioma)
end prototypes

event ue_save_as();integer li_respuesta
string ls_path
//ls_title = this.title

li_respuesta = gf_mensaje('','Yes = Salvar a Excel, No = Otro Formato o Cancelar',4,1,'Q')
choose case li_respuesta
	case 1
		dw_6.retrieve()
		ls_path = nv_f.of_browseforfolder("Guardar Excel en ..",true)
		If Len(Trim(ls_path)) > 0 then		
			uf_save_dw_as_excel(dw_6,ls_path+'\'+this.title+'.xls')
		End If
	case 2
		dw_6.retrieve()
		dw_6.saveas()
end choose

end event

event ue_close();Close(This)
end event

public function boolean wf_asigna_antig ();string ls_error

  DELETE FROM ccatpan  
   WHERE ( ccatpan.tpan_g_financiero = :str.g_financiero ) AND  
         ( ccatpan.tpan_empresa = :str.empresa ) AND  
         ( ccatpan.tpan_maquina = :str.maquina )   ;
	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje('Aviso','Error al eliminar ccatpan',ls_error)
		return false
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
		( ccatempa.tmpa_usuario_maquina = :str.maquina)
GROUP BY ccatempa.tmpa_g_financiero,   
         ccatempa.tmpa_empresa,   
         ccatempa.tmpa_tercero ;
if sqlca.sqlcode = -1 then
	ls_error = sqlca.sqlerrtext
	rollback;
	mensaje('Aviso ','Error al insertar en ccatpan',ls_error)
	return false
else	
	commit ; 
	//mensaje('','Inserto en CCATPAN','')
	
end if

return true
end function

public function boolean wf_antiguedad ();long ll_tercero
datetime ld_tiempo1, ld_tiempo2, ldt_fecha
date		ldt_fecha_desde, ldt_fecha_hasta
ldt_fecha = gf_fecha_serv()
ldt_fecha_hasta = date(ldt_fecha)
ldt_fecha_desde = relativedate(date(gf_fecha_serv()), - 365)
ld_tiempo1 = Datetime(ldt_fecha_desde,00:00:00)
ld_tiempo2 = Datetime(ldt_fecha_hasta,00:00:00)
str.frame.setmicrohelp('Configurando la Antiguedad')
ll_tercero = idw_1.getitemnumber(1,'terc_tercero')
wf_actualiza_antiguedad(ld_tiempo1, ld_tiempo2, ll_tercero)
str.frame.setmicrohelp('Asignando Valores al Formato')
wf_asigna_antig()			
tab_1.tabpage_2.dw_4.retrieve(str.g_financiero, str.empresa, ll_tercero, str.maquina)
return true
end function

public function boolean wf_actualiza_antiguedad (datetime adt_desde, datetime adt_hasta, long al_tercero);
Integer  li_registros, li_i, li_empresa, li_grupofin, li_emp, li_dberror, &
         li_tipo, li_socio, li_audit
decimal  ld_x, ld_y, ld_monto
string   ls_db_err,ls_where_select, ls_error,ls_error_proc
long 		ll_tercero,ll_i,ll_proximo
Datetime ld_tiempo1, ld_tiempo2

DELETE FROM ccatempa
WHERE ( ccatempa.tmpa_g_financiero 	= :str.g_financiero 	) AND  
      ( ccatempa.tmpa_empresa 		= :str.empresa 		) and
		( ccatempa.tmpa_usuario_maquina = :str.maquina 		) ;
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

return true
end function

public subroutine wf_setear_user (string as_user);//Asigno el Usuario a la Variable de Instancia
is_user = as_user
end subroutine

public function boolean wf_cambiar_limite ();//Solicita la clave para cambiar el limite del credito

OpenWithParm(w_clave_autorizada, this)

If is_user = "*" then
	idw_2.setitem(1,'cambiar_limite',0)
else
	idw_2.setitem(1,'cambiar_limite',1)
end if

idw_2.accepttext()
idw_2.setcolumn('ccmclien_clie_limite_credito')

return true

end function

public subroutine wf_actualiza_antiguedad (string idioma);Integer  li_registros, li_i, li_empresa, li_grupofin, li_emp, li_dberror, &
         li_tipo, li_socio, li_audit
decimal  ld_x, ld_y, ld_monto
string   ls_db_err,ls_where_select, ls_error
long 		ll_tercero
Datetime ld_tiempo1, ld_tiempo2
Datastore lds_cliente, lds_tercero_empresa, lds_tercero_gf, lds_tercero_pais

DELETE FROM ccatempa
WHERE ( ccatempa.tmpa_g_financiero 	= :str.g_financiero 	) AND  
      ( ccatempa.tmpa_empresa 		= :str.empresa 		) and
		( ccatempa.tmpa_usuario_maquina = :str.maquina 		) ;
if sqlca.sqlcode = -1 then
	messagebox('error','error al elimianr registros desde ccatempa')
end if

DELETE FROM cchestado  
WHERE ( cchestado.est_g_financiero =:str.g_financiero  ) AND  
		( cchestado.est_empresa =:str.empresa  ) AND  
		( cchestado.est_usuario_maquina =:str.maquina  )   ;
if sqlca.sqlcode = -1 then
	mensaje('Error','Error eliminando de cchestado','')
end if

//datastore	lds_tercero_empresa, lds_tercero_gf,lds_cliente, lds_tercero_pais
Datawindowchild ldwc_sub_tran, ldwc_pais, ldwc_region

lds_cliente 			= create ds_dg_import_file
lds_tercero_empresa 	= create ds_dg_import_file
lds_tercero_gf 		= create ds_dg_import_file
lds_tercero_pais	 	= create ds_dg_import_file


lds_cliente.dataobject = 'dw_cc_inf_terceros_rango_1_nom'
//****************

lds_cliente.settransobject(sqlca)

istr_rangfech =  lstr_rangfech
ld_tiempo1 = Datetime(istr_rangfech.fecha1,00:00:00)
ld_tiempo2 = Datetime(istr_rangfech.fecha2,00:00:00)

//lstr_rangfech.tip_cliente = il_tip_cliente

CHOOSE CASE istr_rangfech.opcion
	CASE 'P' //Por Cliente 
			
		//**filtra el dw por tipo de cliente
		if lstr_rangfech.tip_cliente = 'P' then
			if not isnull(istr_rangfech.tipo_cliesp) then li_tipo = 1
			if not isnull(istr_rangfech.tipo_socio)  then li_socio = 1
			if not isnull(istr_rangfech.tipo_auditor) then li_audit = 1
		
			if li_tipo = 1 then
				lds_cliente.setfilter("ccmclien_clie_clasificacion="+string(lstr_rangfech.tipo_cliesp))
				lds_cliente.filter()
			elseif li_socio = 1 then
				lds_cliente.setfilter("clie_socio="+string(lstr_rangfech.tipo_socio))
				lds_cliente.filter()
			elseif li_audit = 1 then
				lds_cliente.setfilter("clie_auditor="+string(lstr_rangfech.tipo_auditor))
				lds_cliente.filter()
			end if
						
		elseif lstr_rangfech.tip_cliente = 'T' then
			lds_cliente.Setfilter('')
			lds_cliente.filter()
		end if
      //***

			lds_cliente.retrieve(str.g_financiero,str.empresa,istr_rangfech.nombre1,istr_rangfech.nombre2)
			li_registros = lds_cliente.rowcount()
			
			ls_where_select="( terc_descripcion + convert(char(5),dgmterce.terc_tercero) between '"+lstr_rangfech.nombre1+"' and '"+lstr_rangfech.nombre2+"' )"
		
		for li_i = 1 to li_registros 
			//ole_1.object.value 	= (li_i/lds_cliente.rowcount()) * 100		
			//valida que el cliente sea visible, si no tiene permisos, que se devuelva
				ll_tercero 				= lds_cliente.getitemnumber(li_i,"ccmclien_clie_tercero")										
				gf_antiguedad_x_cliente(ld_tiempo2, ll_tercero,idioma,ld_tiempo1)
				istr_rangfech.tipo_antig = 'N'
		next
		//ole_1.visible = false

END CHOOSE

//ole_1.visible = false

IF ISVALID(lds_cliente)  THEN
	DESTROY lds_cliente
END IF
commit using sqlca;
return;
end subroutine

on w_directorio_telefonico.create
int iCurrent
call super::create
this.st_1=create st_1
this.pb_top=create pb_top
this.pb_back=create pb_back
this.pb_next=create pb_next
this.pb_bottom=create pb_bottom
this.dw_6=create dw_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.pb_top
this.Control[iCurrent+3]=this.pb_back
this.Control[iCurrent+4]=this.pb_next
this.Control[iCurrent+5]=this.pb_bottom
this.Control[iCurrent+6]=this.dw_6
end on

on w_directorio_telefonico.destroy
call super::destroy
destroy(this.st_1)
destroy(this.pb_top)
destroy(this.pb_back)
destroy(this.pb_next)
destroy(this.pb_bottom)
destroy(this.dw_6)
end on

event ue_post_open;call super::ue_post_open;str_cc_formatos  lstr_formato
long ll_tercero, ll_encontro, ll_codigo
integer li_existe
string ls_codigo
datawindowchild ldwc_dias, ldwc_vendedores, ldwc_cuentas

iw_window = this

idw_1 = tab_1.tabpage_1.dw_1
idw_2 = tab_1.tabpage_2.dw_2
idw_3 = tab_1.tabpage_3.dw_3
idw_5 = tab_1.tabpage_1.dw_5
idw_1.settransobject(sqlca)
idw_2.settransobject(sqlca)
idw_3.settransobject(sqlca)
dw_6.settransobject(sqlca)
tab_1.tabpage_2.dw_4.settransobject(sqlca)
idw_5.settransobject(sqlca)
idw_5.retrieve()

idw_1.getchild('dgmterce_terc_region', idwc_region)
idwc_region.settransobject(sqlca)
idwc_region.insertrow(1)
idw_1.getchild('clie_clasificacion',idwc_tipo)
idwc_tipo.settransobject(sqlca)
idwc_tipo.retrieve(str.g_financiero, str.empresa)
idwc_tipo.insertrow(0)
idw_1.insertrow(1)

lstr_formato = Message.PowerObjectParm

if isvalid(lstr_formato) then
	ll_tercero = lstr_formato.tercero
end if

idw_1.setfocus()

if ll_tercero > 0 then	
	idw_1.setcolumn('id')	
	idw_1.setitem(1,'id',ll_tercero)
	if idw_1.retrieve( ll_tercero) > 0 then
		ll_encontro = idw_5.find("id = "+string(ll_tercero), 1, idw_5.rowcount())
		if ll_encontro > 0 then
			idw_5.scrolltorow(ll_encontro)
		end if			
	end if
else
	select max(id) into :ll_tercero
	from directorio ;
//	where terc_tipo = 1;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al seleccionar tercero',1,1,'E')
	end if	
	idw_1.setitem(1,'id',ll_tercero + 1)		
	idw_1.setitem(1,'fecha',gf_fecha_serv())
end if //Si no fue llamado desde otra ventana

idw_1.setitemstatus(1,0,primary!,NotModified!) 
idw_2.setitemstatus(1,0,primary!,NotModified!) 
idw_1.sharedata(idw_2)
end event

event ue_adicionar;//override
long ll_tercero
		idw_1.reset()
		idw_1.insertrow(1)
		idw_1.setcolumn('id')
		select max(id) into :ll_tercero
		from directorio; 
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al seleccionar contacto ',1,1,'E')
		end if
		idw_1.setitem(1,'id',ll_tercero + 1)
		idw_1.setcolumn('apellido')
		idw_1.setitem(1,'fecha',gf_fecha_serv())
		idw_1.setfocus()
end event

event ue_aceptar;////override
////wf_grabar_cliente(tab_1.tabpage_1.dw_1, 1)			
//long ll_encontro
//string ls_error, ls_codigo1
//			if idw_1.update() = -1 then
//				ls_error = sqlca.sqlerrtext
//				rollback;
//				gf_mensaje('','Error al Grabar Contacto '+ls_error,1,1,'E')				
//				sqlca.autocommit = true
//				return
//			else
//				commit;
//			end if

//		ls_codigo1 = string(idw_1.getitemnumber(idw_1.getrow(),'id'))

//		ll_encontro = idw_5.find("id = "+ls_codigo1, 1, idw_5.rowcount())
//		if ll_encontro > 0 then
//			idw_5.scrolltorow(ll_encontro)
//		end if
 
String ls_error
Tab_1.tabpage_1.dw_1.Accepttext()
If Tab_1.tabpage_1.dw_1.update() = -1 Then
	ls_error = sqlca.sqlerrtext
	rollback;
	gf_mensaje('','Error al Grabar Contacto '+ls_error,1,1,'E')				
	sqlca.autocommit = true
	return
Else
	Commit;
End If		
end event

event close;call super::close;
Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
 
end event

event ue_siguiente_reg;//siguiente registro
long ll_tercero
string ls_descrip
if idw_1.getrow() = 0 then return
ls_descrip = idw_1.getitemString(1,'apellido')
if ls_descrip  = '' or isnull(ls_descrip) then
	idw_5.scrolltorow(1)
else
	idw_5.scrollnextrow()
end if
ll_tercero = idw_5.getitemNumber(idw_5.getrow(),'id')
idw_1.setitem(1,'id',ll_tercero)
idw_1.retrieve(ll_tercero)
end event

event ue_reg_anterior;//override
//siguiente registro
long ll_tercero
idw_5.scrollpriorrow()
ll_tercero = idw_5.getitemNumber(idw_5.getrow(),'id')
idw_1.setitem(1,'id',ll_tercero)
idw_1.retrieve(ll_tercero)
end event

event ue_ultimo_reg;//override
//siguiente registro
long ll_tercero

idw_5.scrolltorow(idw_5.rowcount())
ll_tercero = idw_5.getitemNumber(idw_5.getrow(),'id')
idw_1.retrieve(ll_tercero)
end event

event ue_primer_reg;//override
//siguiente registro
long ll_tercero

idw_5.scrolltorow(1)
ll_tercero = idw_5.getitemNumber(idw_5.getrow(),'id')
idw_1.retrieve(ll_tercero)
end event

event closequery;//override
SetRedraw(false)
this.triggerevent("ue_valida_todo")
constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)
end event

event ue_valida_todo;//override

integer li_cont
Boolean lb_r


FOR li_cont = 1 TO 1
	
	lb_r = w_valida_yguar(li_cont,li_cont)

	
NEXT














end event

event open;call super::open;//this.y = 0
//this.x = 805
//w_hs_frame.Post Event ue_evaluar_panel_acciones()
end event

event resize;call super::resize;//
tab_1.width = newwidth - 100
tab_1.tabpage_1.width = newwidth - 150
tab_1.tabpage_1.dw_1.width = newwidth - 180
end event

event ue_eliminar;//override
long ll_tercero
string ls_error
		if gf_mensaje('','Esta Seguro de Eliminar el Contacto ?',2,1,'E') = 1 then
			sqlca.autocommit = false		
			idw_1.deleterow(idw_1.getrow())			
			if idw_1.update() = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				gf_mensaje('','Error al Elimiar Contacto '+ls_error,1,1,'E')				
				sqlca.autocommit = true
				return
			else
				commit;
			end if
			sqlca.autocommit = true			
			idw_1.insertrow(1)
			select max(id) into :ll_tercero
			from directorio;
			
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al seleccionar tercero',1,1,'E')
			end if
			idw_1.setitem(1,'id',ll_tercero + 1)					
			idw_1.setitem(1,'fecha',gf_fecha_serv())
			idw_5.retrieve()			
		end if

idw_1.setfocus()
end event

event timer;call super::timer;il_segundos ++
if ib_blink then
	if mod(il_segundos, 2) > 0 then
		idw_1.modify('pasaporte_vencido.visible = 1')
	else
		idw_1.modify('pasaporte_vencido.visible = 0')
	end if
end if
end event

type tab_1 from w_grampa_tab`tab_1 within w_directorio_telefonico
integer x = 23
integer y = 24
integer width = 3941
integer height = 2528
long backcolor = 12639424
boolean fixedwidth = true
boolean powertips = true
boolean boldselectedtext = true
boolean pictureonright = true
end type

event tab_1::selectionchanged;call super::selectionchanged;
choose case newindex
	case 1
		il_tab_activo = newindex
//		idw_1.setfocus()
	case 2
		il_tab_activo = newindex		
//		idw_2.setfocus()
		wf_antiguedad()
	case 3
		il_tab_activo = newindex		
//		idw_3.setfocus()
end choose
end event

on tab_1.create
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
call super::destroy
end on

type tabpage_1 from w_grampa_tab`tabpage_1 within tab_1
integer width = 3904
integer height = 2400
long backcolor = 12639424
string pointer = "HyperLink!"
string text = "Directorio  "
long tabbackcolor = 12632256
string picturename = "Custom039!"
long picturemaskcolor = 553648127
string powertiptext = "Directorio Telefónico de Contactos"
dw_5 dw_5
pb_pdf pb_pdf
end type

on tabpage_1.create
this.dw_5=create dw_5
this.pb_pdf=create pb_pdf
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_5
this.Control[iCurrent+2]=this.pb_pdf
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_5)
destroy(this.pb_pdf)
end on

type dw_1 from w_grampa_tab`dw_1 within tabpage_1
event ue_down pbm_dwnkey
integer x = 0
integer y = 44
integer width = 3886
integer height = 2148
string dataobject = "dw_directorio"
boolean border = false
end type

event dw_1::ue_down;if keydown(Keyescape!) then
	iw_window.postevent('close')
end if
end event

event dw_1::buttonclicked;call super::buttonclicked;	String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error
	integer li_c, li_b
	long    ll_lter, ll_encontro
	str_dg_dynamic_find	lstr_df
	
	choose case dwo.name
			
		case	'b_buscar'		
		
		lstr_df.texto_campo [1,1] = "directorio.apellido" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [1,2] = "Apellido"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '570'
		lstr_df.texto_campo [2,1] = "directorio.nombre_1"
		lstr_df.texto_campo [2,2] = "Nombre"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '500'		
		lstr_df.texto_campo [3,1] = "directorio.pasaporte"
		lstr_df.texto_campo [3,2] = "Pasaporte"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [3,5] = '380'
		lstr_df.texto_campo [4,1] = "directorio.area"
		lstr_df.texto_campo [4,2] = "Area"
		lstr_df.texto_campo [4,3] = ""
		lstr_df.texto_campo [4,4] = 'V'
		lstr_df.texto_campo [4,5] = '550'
		lstr_df.texto_campo [5,1] = "directorio.direc_1"
		lstr_df.texto_campo [5,2] = "Direccion"
		lstr_df.texto_campo [5,3] = ""
		lstr_df.texto_campo [5,4] = 'V'
		lstr_df.texto_campo [5,5] = '750'
		lstr_df.texto_campo [6,1] = "directorio.id"
		lstr_df.texto_campo [6,2] = "Id"
		lstr_df.texto_campo [6,3] = "id"
		lstr_df.texto_campo [6,4] = 'I'
		lstr_df.texto_campo [7,1] = "directorio.ruta_pasaporte"
		lstr_df.texto_campo [7,2] = "Foto"
		lstr_df.texto_campo [7,3] = ""
		lstr_df.texto_campo [7,4] = 'V'
		lstr_df.texto_campo [7,5] = '200'
		
		lstr_df.tabla = " directorio "
		
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
		If len (ls_find) = 0 Then Return
					
		ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
		gf_replace_cadena(ls_codigo1,"'"," ")
		ls_codigo1 = Trim(ls_codigo1)
	
		idw_1.setitem(1,'id',long(ls_codigo1))
		idw_1.accepttext()
		ll_encontro = dw_5.find("id = "+ls_codigo1, 1, dw_5.rowcount())
		if ll_encontro > 0 then
			dw_5.scrolltorow(ll_encontro)
		end if	
		
		if this.retrieve(long(ls_codigo1)) > 0 then
		end if
		this.setitemstatus(1,0,primary!,NotModified!) 			
		
		//idw_1.setcolumn('apellido')
		//idw_1.trigger event itemchanged(1,object,ls_codigo1)
	
end choose
end event

event dw_1::itemchanged;call super::itemchanged;long ll_tercero, ll_pais
integer li_existe
string ls_cuenta
idw_1.accepttext()
//datawindowsstatus ldws_estado
choose case this.getcolumnname()		
		case "apellido"			
			
			ls_cuenta = data
			
			  SELECT max(id)
				 INTO :ll_tercero
				 FROM directorio  
				WHERE ( directorio.apellido = :ls_cuenta ) ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al validar cliente '+sqlca.sqlerrtext,1,1,'E')
						return
					end if
			
				if ll_tercero = 0 or isnull(ll_tercero) then
					//valida que el codigo del tercero no exista, para permitir la captura
					ll_tercero = this.getitemnumber(row,'id')
					  SELECT count(*)
						 INTO :li_existe
						 FROM directorio  
						WHERE ( directorio.id= :ll_tercero ) ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al validar cliente '+sqlca.sqlerrtext,1,1,'E')
								return
							end if
					//si existe, crea un nuevo registro para captar		
					if li_existe > 0 then															
						this.reset()
						this.insertrow(1)
						this.setcolumn('apellido')
						select max(id) into :ll_tercero
						from directorio ;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al seleccionar tercero',1,1,'E')
						end if
						this.setitem(1,'id',ll_tercero + 1)
						this.setitem(1,'apellido',ls_cuenta)
						this.setcolumn('apellido')					
					end if
				else
					if idw_1.GetItemStatus(idw_1.getrow(),0,primary! ) = New! or &
						idw_1.GetItemStatus(idw_1.getrow(),0,primary! ) = NewModified! then
					//	gf_mensaje('','Cuenta ya existe, Verifique !!!',2,1,'E')
					//	idw_1.setitem(idw_1.getrow(), 'clie_ref_anterior', '')						
					//	return 2	
					end if
					
					if this.retrieve( ll_tercero) > 0 then
					end if
					
				end if				
				this.setitemstatus(1,0,primary!,NotModified!) 				
		case "dgmterce_terc_pais"
//			idwc_region.Retrieve (long (data))
			idw_1.setitem(1,'dgmterce_terc_region',0)
			
	end choose
end event

event dw_1::clicked;call super::clicked;long ll_pais, ll_tercero, ll_encontro
decimal{2} ld_cargo_mora, ld_limite_credito
integer li_morosidad, li_vendedor, li_contador, li_rtn
string ls_cuenta, ls_estado, ls_path,ls_nomfile,ls_filter, ls_error

THIS.ACCEPTTEXT()

choose case dwo.name
	case	'b_adicionar_cli'
		this.reset()
		this.insertrow(1)
		this.setcolumn('id')
		select max(id) into :ll_tercero
		from directorio; 
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al seleccionar contacto ',1,1,'E')
		end if
		this.setitem(1,'id',ll_tercero + 1)
		this.setcolumn('apellido')
		idw_1.setitem(1,'fecha',gf_fecha_serv())
				
	case 'b_eliminar_cli'
				
		if gf_mensaje('','Esta Seguro de Eliminar el Contacto ?',2,1,'E') = 1 then
			sqlca.autocommit = false		
			this.deleterow(this.getrow())			
			if this.update() = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				gf_mensaje('','Error al Elimiar Contacto '+ls_error,1,1,'E')				
				sqlca.autocommit = true
				return
			else
				commit;
			end if
			sqlca.autocommit = true			
			this.insertrow(1)
			select max(id) into :ll_tercero
			from directorio;
			
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al seleccionar tercero',1,1,'E')
			end if
			this.setitem(1,'id',ll_tercero + 1)					
			idw_1.setitem(1,'fecha',gf_fecha_serv())
		end if
	case 'b_cerrar_cli'
		iw_window.triggerevent('close')
	case	'b_grabar_cli'
			if this.update() = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				gf_mensaje('','Error al Grabar Contacto '+ls_error,1,1,'E')				
				sqlca.autocommit = true
				return
			else
				commit;
			end if
	case 'clie_foto_pasaporte'
			
		ls_path = this.getitemstring(this.getrow(),'clie_foto_pasaporte')
		openwithparm(w_foto_cliente, ls_path) 
		ls_path = message.stringparm
		this.SetItem(this.Getrow(),"clie_foto_pasaporte",ls_path)

end choose
end event

event dw_1::doubleclicked;call super::doubleclicked;//
string	ls_nomfile, ls_path, ls_filter
integer	li_rtn

if dwo.name = 'ruta_foto' then
	
	ls_filter = "Achivos de Fotos (*.jpg),*.jpg," +&
					"Archivos de Fotos (*.gif),*.gif," +&
					"Archivos de Fotos(*.bmp),*.bmp"
	
	li_rtn = GetFileOpenName("Asignar Foto ",ls_path,ls_nomfile,"jpg",ls_filter)
	
	if li_rtn = 1 then
		this.SetItem(this.Getrow(),"ruta_foto",ls_path)
	end if
elseif dwo.name = 'ruta_pasaporte' then
	
	ls_filter = "Achivos de Fotos (*.jpg),*.jpg," +&
					"Archivos de Fotos (*.gif),*.gif," +&
					"Archivos de Fotos(*.bmp),*.bmp"
	
	li_rtn = GetFileOpenName("Asignar Foto ",ls_path,ls_nomfile,"jpg",ls_filter)
	
	if li_rtn = 1 then
		this.SetItem(this.Getrow(),"ruta_pasaporte",ls_path)
	end if
	
end if
end event

event dw_1::retrieveend;call super::retrieveend;datetime ldt_fecha_vencimiento, ldt_fecha_actual

if rowcount = 0 then return

ldt_fecha_actual = gf_fecha_serv()
ldt_fecha_vencimiento = this.getitemdatetime(this.getrow(),'fecha_vencimiento')

if isnull(ldt_fecha_vencimiento) or not isdate(string(date(ldt_fecha_vencimiento))) then
	ib_blink = false
	timer(0)
	idw_1.modify('pasaporte_vencido.visible = 0')
	return
end if
il_segundos = 0
if ldt_fecha_vencimiento < ldt_fecha_actual then
	ib_blink = true
	timer(1)
	idw_1.modify('pasaporte_vencido.visible = 1')
else
	ib_blink = false
	timer(0)
	idw_1.modify('pasaporte_vencido.visible = 0')
end if
end event

type tabpage_2 from w_grampa_tab`tabpage_2 within tab_1
boolean visible = false
integer width = 3904
integer height = 2400
long backcolor = 12639424
string pointer = "HyperLink!"
string text = "Financiera"
long tabbackcolor = 12632256
string picturename = "Cursor!"
string powertiptext = "Datos Financiero"
dw_4 dw_4
cb_2 cb_2
cb_1 cb_1
pb_1 pb_1
st_2 st_2
pb_mala pb_mala
st_texto_cuenta_mala st_texto_cuenta_mala
end type

on tabpage_2.create
this.dw_4=create dw_4
this.cb_2=create cb_2
this.cb_1=create cb_1
this.pb_1=create pb_1
this.st_2=create st_2
this.pb_mala=create pb_mala
this.st_texto_cuenta_mala=create st_texto_cuenta_mala
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.pb_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.pb_mala
this.Control[iCurrent+7]=this.st_texto_cuenta_mala
end on

on tabpage_2.destroy
call super::destroy
destroy(this.dw_4)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.pb_mala)
destroy(this.st_texto_cuenta_mala)
end on

type dw_2 from w_grampa_tab`dw_2 within tabpage_2
event ue_down pbm_dwnkey
boolean visible = false
integer x = 41
integer y = 48
integer width = 2331
integer height = 1496
end type

event dw_2::ue_down;if keydown(Keyescape!) then
	iw_window.postevent('close')
end if
end event

event dw_2::clicked;call super::clicked;string ls_error
THIS.ACCEPTTEXT()

choose case dwo.name
	case 'b_cerrar_cli'
		iw_window.triggerevent('close')
	case	'b_grabar_cli'
			if this.update() = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				gf_mensaje('','Error al Grabar Contacto '+ls_error,1,1,'E')				
				sqlca.autocommit = true
				return
			else
				commit;
			end if	
	case  'b_cambiar_limite'
		wf_cambiar_limite()
end choose
end event

event dw_2::doubleclicked;call super::doubleclicked;if dwo.name = 'ccmclien_clie_limite_credito' then
	wf_cambiar_limite()
end if
end event

type tabpage_3 from w_grampa_tab`tabpage_3 within tab_1
boolean visible = false
integer width = 3904
integer height = 2400
boolean enabled = false
long backcolor = 12639424
string pointer = "HyperLink!"
string text = "Seguridad"
long tabbackcolor = 12632256
string picturename = "CreateIndex!"
string powertiptext = "Decisiones Administrativas"
end type

type dw_3 from w_grampa_tab`dw_3 within tabpage_3
end type

type dw_5 from datawindow within tabpage_1
boolean visible = false
integer x = 9
integer y = 696
integer width = 494
integer height = 604
integer taborder = 24
boolean bringtotop = true
string title = "none"
string dataobject = "dw_buscar_directorio"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_pdf from picturebutton within tabpage_1
integer x = 2153
integer y = 1916
integer width = 128
integer height = 112
integer taborder = 44
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "PictureButton!"
alignment htextalign = left!
boolean map3dcolors = true
string powertiptext = "Ver PDF ..."
end type

event clicked;		OLEObject ole_object 
		Integer li_rc 
		String ls_ruta 
		
		dw_1.accepttext()
		ls_ruta = idw_1.getitemstring(idw_1.getrow(),'clie_foto_pasaporte') // 'P:\'+idw_25.getitemstring(1,'oc')+'.PDF'
		if fileexists(ls_ruta) then
			
		else
			//ls_ruta = " C:\Sistemas\Documentos\hymsoft.pdf" 
			gf_mensaje('','Pdf no Existe, Verifique !!!',1,1,'E')
			return
		end if
		
		ls_ruta = " "+ls_ruta
		
		ole_object = CREATE OleObject 
		li_rc = ole_object.ConnectToNewObject( "WScript.Shell" ) 
		
		IF li_rc<>0 THEN 
		DESTROY ole_object 
		MessageBox("Error", "No puede conectarse a Acrobat ") 
		RETURN 
		END IF 
		
		ole_object.run("AcroRd32"+ls_ruta) //, Maximized!) 
end event

type dw_4 from datawindow within tabpage_2
integer x = 1458
integer y = 412
integer width = 782
integer height = 764
integer taborder = 14
boolean bringtotop = true
string title = "none"
string dataobject = "dw_antiguedad"
boolean livescroll = true
end type

type cb_2 from commandbutton within tabpage_2
integer x = 503
integer y = 816
integer width = 667
integer height = 128
integer taborder = 24
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Estado de Cuenta"
end type

event clicked;string ls_error
		str_cc_formatos str_formato1		
		str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
		str_formato1.tercero = idw_1.getitemNumber(1,"terc_tercero")
		date ldt_fecha
		ldt_fecha = date(gf_fecha_Serv())
		lstr_rangfech.fecha1 = date('01/01/'+string(year(ldt_fecha) - 1 ))
		lstr_rangfech.fecha2 = ldt_fecha
	
		//Elimina las tablas temporales 
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
			
		DELETE FROM ccatempa
		WHERE ( ccatempa.tmpa_g_financiero 	= :str.g_financiero 	) AND  
				( ccatempa.tmpa_empresa 		= :str.empresa 		) and
				( ccatempa.tmpa_usuario_maquina = :str.maquina 		) ;
		if sqlca.sqlcode = -1 then
			messagebox('error','error al elimianr registros desde ccatempa')
		end if
		
		  DELETE FROM ccatemaf
			WHERE ( tmaf_g_financiero = :str.g_financiero ) AND  
					( tmaf_empresa = :str.empresa ) AND  
					( tmaf_usuario_maquina = :str.maquina )   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje('Aviso','Error al eliminar ccatemaf',ls_error)
			return
		end if
		
		DELETE FROM cchestado  
		WHERE ( cchestado.est_g_financiero =:str.g_financiero  ) AND  
				( cchestado.est_empresa =:str.empresa  ) AND  
				( cchestado.est_usuario_maquina =:str.maquina  )   ;
		if sqlca.sqlcode = -1 then
			mensaje('Error','Error eliminando de cchestado','')
		end if
	
		lstr_rangfech.opcion = 'P'
		lstr_rangfech.mensaje = "P"
		lstr_rangfech.cadena = "N"
		lstr_rangfech.tipo_orden = 'C'//ruc
		lstr_rangfech.tipo_accion = '1'  //solo con movimientos
		lstr_rangfech.idioma = 'E' // en espanol
		lstr_rangfech.tip_cliente = 'T'//todos
		lstr_rangfech.preimpreso = 'N'//preimpresos
		lstr_rangfech.tipo_fecha  = '2'  
		lstr_rangfech.piepag      = '2'  
		lstr_rangfech.tipocliente = 'N'
		lstr_rangfech.tipo_orden = 'A'
		lstr_rangfech.nombre1 = idw_1.GetItemstring(1,"dgmterce_terc_descripcion")+string(str_formato1.tercero)
		lstr_rangfech.nombre2 = idw_1.GetItemstring(1,"dgmterce_terc_descripcion")+string(str_formato1.tercero)
		string ls_ruc
		  SELECT ccmclien.clie_ruc_tercero  
		 INTO :ls_ruc  
		 FROM ccmclien,   
				dgmterce  
		WHERE ( ccmclien.clie_tercero = dgmterce.terc_tercero ) and  
				( ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
				( ccmclien.clie_empresa = :str.empresa ) AND  
				( ccmclien.clie_tercero = :str_formato1.tercero ) )   ;
	
		
		lstr_rangfech.desdeclienteref = ls_ruc//str_formato1.tercero
		lstr_rangfech.hastaclienteref = ls_ruc//str_formato1.tercero
							
		if not isnull(lstr_rangfech.fecha1) and not isnull(lstr_rangfech.fecha2) or &
				lstr_rangfech.fecha1 <> date('00/00/0000') and lstr_rangfech.fecha2 <> date('00/00/0000')then
				commit using sqlca;
				wf_actualiza_antiguedad('E')
				OpenSheetWithParm(w_estadocuenta_imp,lstr_rangfech,str.frame,2, layered!)			
		end if	
	
end event

type cb_1 from commandbutton within tabpage_2
integer x = 507
integer y = 984
integer width = 663
integer height = 128
integer taborder = 24
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Análisis de Compras"
end type

event clicked;	str_cc_formatos str_formato1		
	str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	str_formato1.tercero = idw_1.getitemNumber(1,"terc_tercero")
	Opensheetwithparm(w_analisis_de_compras,str_formato1,str.frame,2,original!)
end event

type pb_1 from picturebutton within tabpage_2
integer x = 2171
integer y = 1380
integer width = 178
integer height = 152
integer taborder = 34
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "C:\sistemas\hymsoft\Art\NOTE04.BMP"
alignment htextalign = left!
end type

event clicked;long ll_tercero
ll_tercero = idw_1.getitemnumber(1,'terc_tercero')
str_cc_formatos str_formato2		
str_formato2.tercero = ll_tercero
if ll_tercero > 0 then
	Opensheetwithparm(w_notas,str_formato2,str.frame,2,original!)
end if

end event

type st_2 from statictext within tabpage_2
integer x = 1911
integer y = 1400
integer width = 242
integer height = 124
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Notas del Cliente"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_mala from picturebutton within tabpage_2
integer x = 119
integer y = 1212
integer width = 133
integer height = 112
integer taborder = 34
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "C:\sistemas\hymsoft\Art\dba_cancel.bmp"
alignment htextalign = left!
end type

event clicked;long ll_tercero
integer li_cuenta_mala = 1
datetime ldt_fecha
string ls_detalle, ls_mensaje

ls_mensaje = 'Esta seguro de pasar el Cliente a Cuentas Malas?'
ls_detalle = 'Cliente Pasado a Cuentas Malas'
	
if idw_1.getitemnumber(1,'ccmclien_clie_cuenta_mala') = 1 then
	gf_mensaje('','El Cliente ya pertenece a las Cuentas Malas, Verifique !!!',1,1,'E')
	ls_mensaje = 'Desea Habilitar el Cliente de Cuentas Malas ?'
	ls_detalle = 'Cliente Activado de Cuentas Malas'
	li_cuenta_mala = 0
end if

if gf_mensaje('',ls_mensaje,2,2,'E') = 2 then return 2		

OpenWithParm(w_clave_autorizada, iw_window)

If is_user <> "*" then
	
	ll_tercero = idw_1.getitemnumber(idw_1.getrow(),'terc_tercero')
	
	UPDATE ccmclien  
     SET clie_cuenta_mala = :li_cuenta_mala  
   WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
         ( ccmclien.clie_empresa = :str.empresa ) AND  
         ( ccmclien.clie_tercero = :ll_tercero );
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al actualizar a cuentas malas '+sqlca.sqlerrtext,1,1,'E')
		end if
	
	idw_1.setitem(1,'ccmclien_clie_cuenta_mala',li_cuenta_mala)
	
	if li_cuenta_mala = 1 then
		tab_1.tabpage_2.st_texto_cuenta_mala.text = 'Habilitar Cuenta'
		tab_1.tabpage_2.pb_mala.picturename = str.path+'\Art\dba_acept.bmp'
	else
		tab_1.tabpage_2.st_texto_cuenta_mala.text = 'Pasar a Cuentas Malas'
		tab_1.tabpage_2.pb_mala.picturename = str.path+'\Art\dba_cancel.bmp'						
	end if
	
	
	ldt_fecha  = gf_fecha_serv()
	
	  INSERT INTO notas_clientes  
		( nota_g_financiero,   
		  nota_empresa,   
		  nota_tercero,   
		  nota_detalle,   
		  nota_fecha,   
		  nota_usuario )  
	  VALUES ( :str.g_financiero,   
				  :str.empresa,   
				  :ll_tercero,   
				  :ls_detalle,     
				  :ldt_fecha,   
				  :str.usuario )  ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al registrar las notas '+sqlca.sqlerrtext,1,1,'E')
		end if
	
end if
end event

type st_texto_cuenta_mala from statictext within tabpage_2
integer x = 261
integer y = 1208
integer width = 393
integer height = 128
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Pasar a Cuentas Malas"
boolean focusrectangle = false
end type

type st_1 from statictext within w_directorio_telefonico
integer x = 2382
integer y = 596
integer width = 654
integer height = 144
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 12639424
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type pb_top from picturebutton within w_directorio_telefonico
integer x = 2427
integer y = 616
integer width = 119
integer height = 104
integer taborder = 44
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Sistemas\Hymsoft\Art\WZTOP.BMP"
alignment htextalign = left!
end type

event clicked;iw_window.triggerevent('ue_primer_reg')
end event

type pb_back from picturebutton within w_directorio_telefonico
integer x = 2574
integer y = 616
integer width = 119
integer height = 104
integer taborder = 44
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Sistemas\Hymsoft\Art\WZBACK.BMP"
alignment htextalign = left!
end type

event clicked;iw_window.triggerevent('ue_reg_anterior')
end event

type pb_next from picturebutton within w_directorio_telefonico
integer x = 2725
integer y = 616
integer width = 119
integer height = 104
integer taborder = 44
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Sistemas\Hymsoft\Art\WZNEXT.BMP"
alignment htextalign = left!
end type

event clicked;iw_window.triggerevent('ue_siguiente_reg')
end event

type pb_bottom from picturebutton within w_directorio_telefonico
integer x = 2871
integer y = 616
integer width = 128
integer height = 112
integer taborder = 34
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Sistemas\Hymsoft\Art\WZEND.BMP"
alignment htextalign = left!
end type

event clicked;iw_window.triggerevent('ue_ultimo_reg')
end event

type dw_6 from datawindow within w_directorio_telefonico
boolean visible = false
integer x = 3982
integer y = 216
integer width = 686
integer height = 400
integer taborder = 13
boolean bringtotop = true
string title = "none"
string dataobject = "dw_directorio_to_excell"
boolean border = false
boolean livescroll = true
end type

