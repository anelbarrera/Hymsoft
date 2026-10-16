forward
global type w_plan_de_cuentas from w_grampa_tab
end type
type dw_5 from datawindow within tabpage_1
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
type st_1 from statictext within w_plan_de_cuentas
end type
type pb_top from picturebutton within w_plan_de_cuentas
end type
type pb_back from picturebutton within w_plan_de_cuentas
end type
type pb_next from picturebutton within w_plan_de_cuentas
end type
type pb_bottom from picturebutton within w_plan_de_cuentas
end type
end forward

global type w_plan_de_cuentas from w_grampa_tab
integer width = 2766
integer height = 1308
string title = "Mantenimiento de Cuentas Contables"
boolean controlmenu = false
long backcolor = 12639424
st_1 st_1
pb_top pb_top
pb_back pb_back
pb_next pb_next
pb_bottom pb_bottom
end type
global w_plan_de_cuentas w_plan_de_cuentas

type variables
datawindow idw_1, idw_2, idw_3, idw_5
datawindowchild idwc_grupo, idwc_subgrupo

window iw_window
integer il_tab_activo
boolean ib_cerrar
string is_user
end variables

forward prototypes
public subroutine wf_setear_user (string as_user)
public function boolean wf_cambiar_limite ()
public function boolean wf_grabar_cliente (datawindow adw_1, long fila)
end prototypes

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

public function boolean wf_grabar_cliente (datawindow adw_1, long fila);long ll_encontro
integer li_existe, li_ann
string ls_cuenta, ls_valor
idw_1.setitem(1,'mg_g_financiero',str.g_financiero)
idw_1.setitem(1,'mg_empresa',str.empresa)

ls_cuenta = adw_1.getitemstring(1,'mg_cuenta')
if isnull(ls_cuenta) or ls_cuenta = '' then
	gf_mensaje('','Debe asignar el Codigo de la cuenta',1,1,'E')
	return false
end if

ls_cuenta      = left(ls_cuenta + fill('0',20),20)
adw_1.setitem(1,'mg_cuenta',ls_cuenta)

ls_valor = adw_1.getitemstring(1,'mg_descripcion')
if isnull(ls_valor) or ls_valor = '' then
	gf_mensaje('','Debe asignar la Descripcion de la cuenta',1,1,'E')
	return false
end if

ls_valor = adw_1.getitemstring(1,'mg_tipo_cuenta')
if isnull(ls_valor) or ls_valor = '' then
	gf_mensaje('','Debe asignar el Tipo de la cuenta',1,1,'E')
	return false
end if

ls_valor = adw_1.getitemstring(1,'mg_cod_grupo')
if isnull(ls_valor) or ls_valor = '' then
	gf_mensaje('','Debe asignar el grupo de la cuenta',1,1,'E')
	return false
end if

ls_valor = adw_1.getitemstring(1,'mg_cod_subgrupo')
if isnull(ls_valor) or ls_valor = '' then
	gf_mensaje('','Debe asignar el sub grupo de la cuenta',1,1,'E')
	return false
end if


if adw_1.update() = -1 then
	gf_mensaje('','Error al crear cuenta '+sqlca.sqlerrtext,1,1,'E')
	rollback;
	return false
else		
		commit ;
		ls_cuenta = adw_1.getitemstring(adw_1.getrow(),'mg_cuenta')
		//Recupera el dw de busqueda
			idw_5.retrieve(str.g_financiero, str.empresa)
			ll_encontro = idw_5.find("mg_cuenta = '"+ls_cuenta+"'", 1, idw_5.rowcount())
			if ll_encontro > 0 then
				idw_5.scrolltorow(ll_encontro)
			end if
		//Inserta o actualiza en la tabls del mayor
		li_ann = year(date(gf_fecha_serv()))
		
		  SELECT count(*)  
			 INTO :li_existe  
			 FROM comayor  
			WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
					( comayor.mayo_empresa = :str.empresa ) AND
					( comayor.mayo_ann = :li_ann ) AND
					( comayor.mayo_cuenta = :ls_cuenta ) ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al validar existencia de cuenta en el mayor '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				return false
			end if
		
			if li_existe = 0 then
				
				  INSERT INTO comayor  
							( mayo_g_financiero,   
							  mayo_empresa,   
							  mayo_cuenta,   
							  mayo_ann)  
				  VALUES ( :str.g_financiero,   
							  :str.empresa,   
							  :ls_cuenta,   
							  :li_ann)  ;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al insertar cuenta en el mayor '+sqlca.sqlerrtext,1,1,'E')
							rollback;
							return false
						end if
							
			end if
end if

return true


//long ll_pais, ll_tercero, ll_encontro
//decimal{2} ld_cargo_mora, ld_limite_credito, ld_limite_anterior
//integer li_morosidad, li_vendedor
//string ls_cuenta, ls_estado, ls_detalle, ls_foto, ls_cuenta_oficial
//string ls_contacto, ls_cargo, ls_observacion, ls_telefono, ls_codigo, ls_ruc, ls_tipo_persona, ls_digito		
//integer li_pais, li_existe, li_tipo
//datetime ldt_fecha
//
//		
//		fila = 1
//		
//		if adw_1.getitemnumber(fila,'dgmterce_terc_region') = 0 or isnull(adw_1.getitemnumber(fila,'dgmterce_terc_region')) then
//			gf_mensaje('','Asigne la region a la que pertenece el cliente',1,1,'E')
//			adw_1.setcolumn('dgmterce_terc_region')
//			return false
//		end if
//		
//		if adw_1.getitemnumber(fila,'dgmterce_terc_pais') = 0 or isnull(adw_1.getitemnumber(fila,'dgmterce_terc_pais')) then
//			gf_mensaje('','Asigne el pais al que pertenece el cliente',1,1,'E')
//			adw_1.setcolumn('dgmterce_terc_pais')			
//			return false
//		end if
//		
//		if adw_1.getitemstring(fila,'clie_ref_anterior') = '' or isnull(adw_1.getitemString(fila,'clie_ref_anterior')) then
//			gf_mensaje('','Asigne la cuenta del cliente',1,1,'E')
//			adw_1.setcolumn('clie_ref_anterior')
//			return false
//		end if
//
//		ld_limite_anterior = adw_1.getitemnumber(fila,'ccmclien_clie_limite_credito', Primary!, true)			
//		
//		sqlca.autocommit = false
//		
//		if adw_1.update() = -1 then
//		  if sqlca.sqlcode = -1 then
//			 gf_mensaje('','Error al Actualizar clientes dw_1 '+sqlca.sqlerrtext,1,1,'E')
//			 rollback ;
//			 sqlca.autocommit = true
//			 return false
//		  end if
//		else
//
//			ls_contacto = adw_1.getitemstring(fila, 'clie_contacto')
//			ls_cargo		= adw_1.getitemstring(fila, 'clie_contacto_cargo')
//			ls_telefono	= adw_1.getitemstring(fila, 'clie_contacto_telefono')
//			ls_codigo	= adw_1.getitemstring(fila, 'clie_ref_anterior')
//			ls_observacion = adw_1.getitemstring(fila, 'clie_comentario')
//			li_tipo		= adw_1.getitemnumber(fila, 'clie_clasificacion')
//			ll_tercero	= adw_1.getitemnumber(fila,'terc_tercero')
//			ls_ruc		= adw_1.getitemstring(fila, 'dgmterce_terc_identificacion')
//			li_morosidad= adw_1.getitemnumber(fila,'ccmclien_clie_limite_morosidad')
//			li_vendedor = adw_1.getitemnumber(fila,'ccmclien_clie_vendedor')
//			ls_cuenta	= adw_1.getitemstring(fila,'ccmclien_clie_mg_cuenta')
//			ld_limite_credito  = adw_1.getitemnumber(fila,'ccmclien_clie_limite_credito')
//			ls_estado	= adw_1.getitemstring(fila,'ccmclien_clie_estado')
//			ld_cargo_mora=adw_1.getitemnumber(fila,'ccmclien_clie_cargo_morocidad')			
//			ls_foto		= adw_1.getitemstring(fila,'clie_foto_pasaporte')			
//			ls_cuenta_oficial = adw_1.getitemstring(fila, 'clie_cuenta_oficial')
//		
//		  SELECT count(*)  
//			 INTO :li_existe  
//			 FROM ccmclien  
//			WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
//					( ccmclien.clie_empresa = :str.empresa ) AND  
//					( ccmclien.clie_tercero = :ll_tercero ) ;
//				if sqlca.sqlcode = -1 then
//					gf_mensaje('','Error al validar cliente '+sqlca.sqlerrtext,1,1,'E')
//				end if				
//			if li_existe = 0 or isnull(li_existe) then //Si no existe, crea el proveedor
//		
//			  INSERT INTO ccmclien  
//					( clie_g_financiero,   
//					  clie_empresa,   
//					  clie_tercero,   
//					  clie_mg_cuenta,   
//					  clie_ref_anterior,   
//					  clie_limite_credito,   
//					  clie_ruc_tercero,   
//					  clie_contacto,   
//					  clie_contacto_cargo,   
//					  clie_contacto_telefono,    
//					  clie_comentario,   
//					  clie_estado,   
//					  clie_clasificacion,
//					  clie_tipo_desc,
//					  clie_limite_morosidad,
//					  clie_cargo_morocidad,
//					  clie_vendedor,
//					  clie_foto_pasaporte,
//					  clie_cuenta_oficial)  
//		  VALUES ( :str.g_financiero,   
//					  :str.empresa,   
//					  :ll_tercero,   
//					  :ls_cuenta,   
//					  :ls_codigo,   
//					  :ld_limite_credito,   
//					  :ls_ruc,   
//					  :ls_contacto,   
//					  :ls_cargo,   
//					  :ls_telefono,   
//					  :ls_observacion,   
//					  :ls_estado,   
//					  :li_tipo,
//					  'N',
//					  :li_morosidad,
//					  :ld_cargo_mora,
//					  :li_vendedor,
//					  :ls_foto,
//					  :ls_cuenta_oficial)  ;
//			  
//				  if sqlca.sqlcode = -1 then
//					 gf_mensaje('','Error al Insertar proveedor '+sqlca.sqlerrtext,1,1,'E')
//					 rollback ;
//					 sqlca.autocommit = true
//					 return false
//				  end if
//			
//			else //Si ya existe, actualiza los datos
//							
//				update ccmclien  
//					set clie_ref_anterior = :ls_codigo,   
//						  clie_ruc_tercero = :ls_ruc,    
//						  clie_contacto = :ls_contacto,   
//						  clie_contacto_cargo = :ls_cargo,      
//						  clie_contacto_telefono = :ls_telefono,   
//						  clie_comentario = :ls_observacion,
//						  clie_clasificacion = :li_tipo,
//						  clie_mg_cuenta		= :ls_cuenta,
//						  clie_limite_credito = :ld_limite_credito,
//						  clie_estado			= :ls_estado,
//						  clie_limite_morosidad = :li_morosidad,
//						  clie_cargo_morocidad = :ld_cargo_mora,
//						  clie_vendedor	= :li_vendedor,
//						  clie_foto_pasaporte = :ls_foto,
//						  clie_cuenta_oficial = :ls_cuenta_oficial
//				  where clie_g_financiero = :str.g_financiero and
//						  clie_empresa		= :str.empresa and
//						  clie_tercero		= :ll_tercero ;
//				  if sqlca.sqlcode = -1 then
//					 gf_mensaje('','Error al Actualizar cliente '+sqlca.sqlerrtext,1,1,'E')
//					 rollback ;
//					 sqlca.autocommit = true
//					 return false
//				  end if
//				
//			end if
//			
//			//Recupera el dw de busqueda
//			idw_5.retrieve(str.g_financiero, str.empresa)
//			ll_encontro = idw_5.find("terc_tercero = "+string(ll_tercero), 1, idw_5.rowcount())
//			if ll_encontro > 0 then
//				idw_5.scrolltorow(ll_encontro)
//			end if
//			
//			//Si se cambio el limite de Credito, crea la Nota
//			if idw_1.getitemnumber(1, 'cambiar_limite') = 1 then				
//				
//					ldt_fecha  = gf_fecha_serv()
//					ls_detalle = 'Cambio del Limite de Credito: de '+string(ld_limite_anterior,'$##,##0.00')+ ' a '+string(ld_limite_credito, '$##,##0.00')
//					
//					  INSERT INTO notas_clientes  
//						( nota_g_financiero,   
//						  nota_empresa,   
//						  nota_tercero,   
//						  nota_detalle,   
//						  nota_fecha,   
//						  nota_usuario )  
//					  VALUES ( :str.g_financiero,   
//								  :str.empresa,   
//								  :ll_tercero,   
//								  :ls_detalle,     
//								  :ldt_fecha,   
//								  :str.usuario )  ;
//						if sqlca.sqlcode = -1 then
//							gf_mensaje('','Error al registrar las notas '+sqlca.sqlerrtext,1,1,'E')
//						end if
//						
//						idw_1.setitem(1,'cambiar_limite',0)
//						idw_1.accepttext()
//			end if
//			
//		
//		end if //del update del dw_1
//
//		commit;
//		
//		sqlca.autocommit = true
//
//return true
end function

on w_plan_de_cuentas.create
int iCurrent
call super::create
this.st_1=create st_1
this.pb_top=create pb_top
this.pb_back=create pb_back
this.pb_next=create pb_next
this.pb_bottom=create pb_bottom
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.pb_top
this.Control[iCurrent+3]=this.pb_back
this.Control[iCurrent+4]=this.pb_next
this.Control[iCurrent+5]=this.pb_bottom
end on

on w_plan_de_cuentas.destroy
call super::destroy
destroy(this.st_1)
destroy(this.pb_top)
destroy(this.pb_back)
destroy(this.pb_next)
destroy(this.pb_bottom)
end on

event ue_post_open;call super::ue_post_open;str_cc_formatos  lstr_formato
long ll_tercero, ll_encontro
string ls_masca
datawindowchild ldwc_dias, ldwc_vendedores, ldwc_cuentas
iw_window = this

idw_1 = tab_1.tabpage_1.dw_1

idw_5 = tab_1.tabpage_1.dw_5
idw_1.settransobject(sqlca)

//tab_1.tabpage_2.dw_4.settransobject(sqlca)
idw_5.settransobject(sqlca)
idw_5.retrieve(str.g_financiero, str.empresa)

idw_1.getchild('mg_cod_grupo', idwc_grupo)
idwc_grupo.settransobject(sqlca)
idwc_grupo.retrieve(str.g_financiero, str.empresa)
//idwc_grupo.insertrow(1)
idw_1.getchild('mg_cod_subgrupo',idwc_subgrupo)
idwc_subgrupo.settransobject(sqlca)
idwc_subgrupo.retrieve(str.g_financiero, str.empresa)
//idwc_subgrupo.insertrow(1)
idw_1.insertrow(1)
idw_1.setitem(1,'mg_g_financiero',str.g_financiero)
idw_1.setitem(1,'mg_empresa',str.empresa)


ls_masca = gf_mascara()
idw_1.MODIFY("mg_cuenta.editmask.mask='"+ls_masca+"'")


lstr_formato = Message.PowerObjectParm

if isvalid(lstr_formato) then
	ll_tercero = lstr_formato.tercero
end if

if ll_tercero > 0 then	
	idw_1.setcolumn('terc_tercero')	
	idw_1.setitem(1,'terc_tercero',ll_tercero)
	if idw_1.retrieve(str.g_financiero, str.empresa, ll_tercero) > 0 then
//		idwc_region.Retrieve (idw_1.getitemnumber(1,'dgmterce_terc_pais'))					
		ll_encontro = idw_5.find("terc_tercero = "+string(ll_tercero), 1, idw_5.rowcount())
		if ll_encontro > 0 then
			idw_5.scrolltorow(ll_encontro)
		end if			
	end if
end if

idw_1.setitemstatus(1,0,primary!,NotModified!) 

idw_1.setfocus()
end event

event ue_adicionar;//override
long ll_tercero
idw_1.reset()
idw_1.insertrow(1)
idw_1.setitem(1,'mg_g_financiero',str.g_financiero)
idw_1.setitem(1,'mg_empresa',str.empresa)
//idw_1.setcolumn('terc_tercero')
//select max(terc_tercero) into :ll_tercero
//from dgmterce 
//where terc_tipo = 1;
//if sqlca.sqlcode = -1 then
//	gf_mensaje('','Error al seleccionar tercero',1,1,'E')
//end if
//idw_1.setitem(1,'terc_tercero',ll_tercero + 1)
//idw_1.setcolumn('dgmterce_terc_descripcion')
end event

event ue_aceptar;//override
wf_grabar_cliente(tab_1.tabpage_1.dw_1, 1)			

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
string ls_descrip, ls_cuenta
if idw_1.getrow() = 0 then return
ls_descrip = idw_1.getitemString(1,'mg_descripcion')
if ls_descrip  = '' or isnull(ls_descrip) then
	idw_5.scrolltorow(1)
else
	idw_5.scrollnextrow()
end if
ls_cuenta = idw_5.getitemstring(idw_5.getrow(),'mg_cuenta')
idw_1.setitem(1,'mg_cuenta',ls_cuenta)
idw_1.accepttext()
idw_1.setcolumn('mg_cuenta')
idw_1.trigger event itemchanged(1,idw_1.object,ls_cuenta)


end event

event ue_reg_anterior;//override
//siguiente registro
string ls_cuenta
idw_5.scrollpriorrow()
ls_cuenta = idw_5.getitemstring(idw_5.getrow(),'mg_cuenta')
idw_1.setitem(1,'mg_cuenta',ls_cuenta)
idw_1.accepttext()
idw_1.setcolumn('mg_cuenta')
idw_1.trigger event itemchanged(1,idw_1.object,ls_cuenta)



end event

event ue_ultimo_reg;//override
//siguiente registro
string ls_cuenta

idw_5.scrolltorow(idw_5.rowcount())
ls_cuenta = idw_5.getitemstring(idw_5.getrow(),'mg_cuenta')
idw_1.setitem(1,'mg_cuenta',ls_cuenta)
idw_1.accepttext()
idw_1.setcolumn('mg_cuenta')
idw_1.trigger event itemchanged(1,idw_1.object,ls_cuenta)



end event

event ue_primer_reg;//override
//siguiente registro
string ls_cuenta

idw_5.scrolltorow(1)
ls_cuenta = idw_5.getitemString(idw_5.getrow(),'mg_cuenta')
idw_1.setitem(1,'mg_cuenta',ls_cuenta)
idw_1.accepttext()
idw_1.setcolumn('mg_cuenta')
idw_1.trigger event itemchanged(1,idw_1.object,ls_cuenta)


end event

event closequery;//override
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

event open;call super::open;this.y = 0
this.x = 805
w_hs_frame.Post Event ue_evaluar_panel_acciones()
setredraw(true)
end event

event ue_print;call super::ue_print;	OpenSheet(w_impresion_plan_cuentas,str.frame,2,Original!)		
end event

type tab_1 from w_grampa_tab`tab_1 within w_plan_de_cuentas
integer x = 23
integer y = 24
integer width = 2683
integer height = 1108
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
//		wf_antiguedad()
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
integer width = 2647
integer height = 980
long backcolor = 12639424
string pointer = "HyperLink!"
string text = "Plan de Cuentas "
long tabbackcolor = 12632256
string picturename = "Custom039!"
long picturemaskcolor = 553648127
string powertiptext = "Datos Generales del Cliente"
dw_5 dw_5
end type

on tabpage_1.create
this.dw_5=create dw_5
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_5
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_5)
end on

type dw_1 from w_grampa_tab`dw_1 within tabpage_1
event ue_down pbm_dwnkey
integer x = 0
integer y = 44
integer width = 2638
integer height = 712
string dataobject = "dw_plan_de_cuentas"
boolean border = false
end type

event dw_1::ue_down;if keydown(Keyescape!) then
	iw_window.postevent('close')
elseif keydown(KeyF1!) then
	
	if this.getcolumnname() <> 'mg_cuenta' then return		
	
	String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error
	integer li_c, li_b
	long    ll_lter, ll_encontro
			
		str_dg_dynamic_find	lstr_df
	
		lstr_df.texto_campo [1,1] = "dgmplanc.mg_cuenta" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [1,2] = "Cuenta"
		lstr_df.texto_campo [1,3] = "mg_cuenta"
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '300'
		lstr_df.texto_campo [2,1] = "dgmplanc.mg_descripcion"
		lstr_df.texto_campo [2,2] = "Descripción"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '1000'		
		lstr_df.texto_campo [3,1] = "case when dgmplanc.mg_tipo_cuenta = 'R' then 'RESUMEN' else 'DETALLE' end mg_tipo_cuenta"
		lstr_df.texto_campo [3,2] = "Tipo"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [3,5] = '250'
		
		lstr_df.tabla = " dgmplanc "
		
		
		lstr_df.tabla_where = &
					"WHERE (dgmplanc.mg_g_financiero = " + string(str.g_financiero) + " and " +&
							 "dgmplanc.mg_empresa = " + string(str.empresa) + ")" 
		
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	If len (ls_find) = 0 Then Return
				
	ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo1,"'"," ")
	ls_codigo1 = Trim(ls_codigo1)

	idw_1.setitem(1,'mg_cuenta',ls_codigo1)
	idw_1.accepttext()
	ll_encontro = dw_5.find("mg_cuenta = '"+ls_codigo1+"'", 1, dw_5.rowcount())
	if ll_encontro > 0 then
		dw_5.scrolltorow(ll_encontro)
	end if	
	
	idw_1.setcolumn('mg_cuenta')
	idw_1.trigger event itemchanged(1,object,ls_codigo1)
	
end if
end event

event dw_1::buttonclicked;call super::buttonclicked;	String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error
	integer li_c, li_b
	long    ll_lter, ll_encontro
	
	choose case dwo.name
			
		case	'b_buscar'		
		
		str_dg_dynamic_find	lstr_df
	
		lstr_df.texto_campo [1,1] = "dgmplanc.mg_cuenta" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [1,2] = "Cuenta"
		lstr_df.texto_campo [1,3] = "mg_cuenta"
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '300'
		lstr_df.texto_campo [2,1] = "dgmplanc.mg_descripcion"
		lstr_df.texto_campo [2,2] = "Descripción"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '1000'		
		lstr_df.texto_campo [3,1] = "case when dgmplanc.mg_tipo_cuenta = 'R' then 'RESUMEN' else 'DETALLE' end mg_tipo_cuenta"
		lstr_df.texto_campo [3,2] = "Tipo"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [3,5] = '250'
		
		lstr_df.tabla = " dgmplanc "
		
		
		lstr_df.tabla_where = &
					"WHERE (dgmplanc.mg_g_financiero = " + string(str.g_financiero) + " and " +&
							 "dgmplanc.mg_empresa = " + string(str.empresa) + ")" 
		
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	If len (ls_find) = 0 Then Return
				
	ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo1,"'"," ")
	ls_codigo1 = Trim(ls_codigo1)

	idw_1.setitem(1,'mg_cuenta',ls_codigo1)
	idw_1.accepttext()
	ll_encontro = dw_5.find("mg_cuenta = '"+ls_codigo1+"'", 1, dw_5.rowcount())
	if ll_encontro > 0 then
		dw_5.scrolltorow(ll_encontro)
	end if	
	
	idw_1.setcolumn('mg_cuenta')
	idw_1.trigger event itemchanged(1,object,ls_codigo1)
	
end choose
end event

event dw_1::itemchanged;call super::itemchanged;long ll_tercero, ll_pais
integer li_existe, li_rtn, li_encontro
string ls_cuenta, ls_filtro, ls_nulo, ls_tipo_cuenta, ls_tipo_cuenta_anterior
decimal{2} ld_suma
idw_1.accepttext()
Setnull(ls_nulo)
//datawindowsstatus ldws_estado
choose case this.getcolumnname()
	case "mg_cuenta"
		
//		w_valida_yguar(1,1)
		
		ls_cuenta = data
		ls_cuenta = left(ls_cuenta+ fill('0',20),20)		
		dw_1.SetItem(1,"mg_cuenta",ls_cuenta)

		  SELECT count(*)
			 INTO :li_existe  
			 FROM dgmplanc  
			WHERE ( dgmplanc.mg_g_financiero = :str.g_financiero ) AND  
					( dgmplanc.mg_empresa = :str.empresa ) AND  
					( dgmplanc.mg_cuenta = :ls_cuenta ) ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al validar cuenta '+sqlca.sqlerrtext,1,1,'E')
					return
				end if
		
			if li_existe = 0 or isnull(li_existe) then
				this.reset()
				this.insertrow(1)
				this.setitem(1,'mg_cuenta',ls_cuenta)
			//	this.setcolumn('dgmterce_terc_descripcion')				
			else
				if this.retrieve(str.g_financiero, str.empresa, ls_cuenta) > 0 then				
					ls_filtro = This.GetItemString(row,"mg_cod_grupo")
					idwc_subgrupo.SetFilter("asgr_cod_grupo = '" + ls_filtro + "'")	
					li_rtn = idwc_subgrupo.Filter()	
				end if
				li_encontro = idw_5.find('mg_cuenta = "'+ls_cuenta+'"',1,idw_5.rowcount())
				if li_encontro > 0 then
					idw_5.scrolltorow(li_encontro)
				end if
				
			end if
			
			///////////////////////////
			//BUSQUEDA DEL NIVEL
	Datastore 	lds_nivel			
	string ls_cuenta1, ls_Cadena, ls_cuenta_anterior
	integer li_num_nivel, li_contador, li_acum, li_ncaracter, li_pos, li_nivel, li_s, li_nivel_anterior, li_acum2, li_found, li_found2
	
	
	If Left(ls_cuenta,1) = '0' Then
		Mensaje("Atención","La Cuenta No Puede Iniciar con Cero", "")
		dw_1.SetItem(dw_1.GetRow(),"mg_cuenta",'')
		return 2
	Else
		// Creamos Datastore
				
		lds_nivel = Create ds_dg_import_file
		lds_nivel.dataobject = "dw_ma_co_niveles"
		lds_nivel.settransobject(sqlca)
		lds_nivel.retrieve(str.g_financiero,str.empresa)
		
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
		
//			If ll_encontrado = 0 Or isnull(ll_encontrado) Then
			If li_found = 0 Or isnull(li_found) Then
				Mensaje("Atención Sr. Usuario","La Cuenta Que Esta Creando No Tiene Nivel Anterior, Verifique !!!", "")
				this.setitem(1,'mg_cuenta','')
				Return 2		
			end if
		end if
	
		If li_nivel <> 0 And li_s = 0 Then
			dw_1.SetItem(dw_1.GetRow(),"mg_nivel",li_nivel)		
		End If
		
		
	end if	
			
			//FIN DE LA BUSQUEDA DEL NIVEL
			///////////////////////////

	//		this.setitemstatus(1,0,primary!,NotModified!) 			
			
	case 'mg_cod_grupo'				
		//Se blanquean las columnas dependientes
		This.SetItem(row,"mg_cod_subgrupo",ls_nulo)
		ls_filtro = This.GetItemString(row,"mg_cod_grupo")
		idwc_subgrupo.SetFilter("asgr_cod_grupo = '" + ls_filtro + "'")	
		li_rtn = idwc_subgrupo.Filter()				
		CHOOSE CASE left(this.getitemstring(1,'mg_cuenta'),1)
			CASE '1', '5', '6'
				dw_1.SetItem(1, "mg_naturaleza", "D")
			CASE '2', '3', '4'
				dw_1.SetItem(1, "mg_naturaleza", "C")
		END CHOOSE
	case 'mg_tipo_cuenta'
		ls_cuenta 		= this.getitemstring(row,'mg_cuenta')
		ls_tipo_cuenta  = data
		ls_tipo_cuenta_anterior  = this.getitemstring(row,'mg_tipo_cuenta', Primary!, true)
		
		if ls_tipo_cuenta_anterior = 'D' then  //Si esta cambiando de detalle a resumen			
		  SELECT isnull(count(*) ,0)
			 INTO :li_existe  
			 FROM coddiari  
			WHERE ( coddiari.ddia_g_financiero = :str.g_financiero ) AND  
					( coddiari.ddia_empresa = :str.empresa ) AND  
					( coddiari.ddia_mg_cuenta = :ls_cuenta )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Validar Existencia de Movimientos '+sqlca.sqlerrtext,1,1,'E')
					return
				end if				
				
				if li_existe > 0 then
					gf_mensaje('','No puede cambiar el tipo de cuenta, la misma ya tiene movimientos !!!',1,1,'E')
					this.setitem(row,'mg_tipo_cuenta',ls_tipo_cuenta_anterior)
					return 2
				end if				
		else //Si esta cambiando una de resumen a detalle
			  SELECT sum(abs(mayo_ene_inicial) + abs(mayo_ene_db) + abs(mayo_ene_cr) + abs(mayo_feb_inicial) + abs(mayo_feb_db) + abs(mayo_feb_cr)  + abs(mayo_mar_inicial) + abs(mayo_mar_db) + abs(mayo_mar_cr) + abs(mayo_abr_inicial) + abs(mayo_abr_db) + abs(mayo_abr_cr) 
						+ abs(mayo_may_inicial) + abs(mayo_may_db) + abs(mayo_may_cr) + abs(mayo_jun_inicial) + abs(mayo_jun_db) + abs(mayo_jun_cr) + abs(mayo_jul_inicial) + abs(mayo_jul_db) + abs(mayo_jul_cr) + abs(mayo_ago_inicial) + abs(mayo_ago_db) + abs(mayo_ago_cr) 
						+ abs(mayo_sep_inicial) + abs(mayo_sep_db) + abs(mayo_sep_cr) + abs(mayo_oct_inicial) + abs(mayo_oct_db) + abs(mayo_oct_cr) + abs(mayo_nov_inicial) + abs(mayo_nov_db) + abs(mayo_nov_cr) + abs(mayo_dic_inicial) + abs(mayo_dic_db) + abs(mayo_dic_cr) )
				 INTO :ld_suma  
				 FROM comayor  
				WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
						( comayor.mayo_empresa = :str.empresa ) AND  
						( comayor.mayo_cuenta = :ls_cuenta )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al validar en el Mayor '+sqlca.sqlerrtext,1,1,'E')
				end if
				if ld_suma > 0 then
					gf_mensaje('','No puede cambiar el tipo de cuenta, la misma ya tiene cuentas de niveles inferiores con movimiento !!!',1,1,'E')
					this.setitem(row,'mg_tipo_cuenta',ls_tipo_cuenta_anterior)
					return 2
				end if

		end if		
end choose
end event

event dw_1::clicked;call super::clicked;long ll_pais, ll_tercero, ll_encontro
decimal{2} ld_cargo_mora, ld_limite_credito, ld_valor
integer li_morosidad, li_vendedor, li_contador, li_rtn, li_existe, li_encontro
string ls_cuenta, ls_estado, ls_path,ls_nomfile,ls_filter, ls_filtro, ls_error

THIS.ACCEPTTEXT()

choose case dwo.name
		
	CASE "mg_cod_grupo"
		ls_filtro = This.GetItemString(row,"mg_cod_grupo")
		if not isnull(ls_filtro) and ls_filtro <> '' then 
			idwc_subgrupo.SetFilter("asgr_cod_grupo = '" + ls_filtro + "'")	
			li_rtn = idwc_subgrupo.Filter()		
		end if
		
	case	'b_adicionar_cli'
		this.reset()
		this.insertrow(1)
		idw_1.setitem(1,'mg_g_financiero',str.g_financiero)
		idw_1.setitem(1,'mg_empresa',str.empresa)

	case 'b_eliminar_cli'
		
		
		if gf_mensaje('','Esta Seguro de Eliminar la Cuenta ?',2,1,'E') = 1 then
			sqlca.autocommit = false			
			
			ls_cuenta = this.getitemstring(this.getrow(),'mg_cuenta')
			
			  SELECT count(*)  
				 INTO :li_existe  
				 FROM coddiari  
				WHERE ( coddiari.ddia_g_financiero = :str.g_financiero ) AND  
						( coddiari.ddia_empresa = :str.empresa ) AND  
						( coddiari.ddia_mg_cuenta = :ls_cuenta ) ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al validar existencia '+sqlca.sqlerrtext,1,1,'E')
						return
					end if
			if li_existe > 0 then //Si ya tiene movimiento, debe reclasificarse para poder eliminarla
				gf_mensaje('','La Cuenta tiene Movimiento, no se puede eliminar, Verifique !!!',1,1,'E')
				return
			else //Si no ha tenido movimiento, elimina del mayor
				
				 SELECT sum(comayor.mayo_ene_inicial + comayor.mayo_ene_db + comayor.mayo_ene_cr + comayor.mayo_feb_inicial + comayor.mayo_feb_db + comayor.mayo_feb_cr + comayor.mayo_mar_inicial   
							+ comayor.mayo_mar_db + comayor.mayo_mar_cr + comayor.mayo_abr_inicial + comayor.mayo_abr_db + comayor.mayo_abr_cr + comayor.mayo_may_inicial + comayor.mayo_may_db
							+ comayor.mayo_may_cr + 	comayor.mayo_jun_inicial + comayor.mayo_jun_db + comayor.mayo_jun_cr + comayor.mayo_jul_inicial + comayor.mayo_jul_db + 	comayor.mayo_jul_cr
							+ comayor.mayo_ago_inicial + 	comayor.mayo_ago_db + comayor.mayo_ago_cr + comayor.mayo_sep_inicial + comayor.mayo_sep_db + comayor.mayo_sep_cr + comayor.mayo_oct_inicial
							+ comayor.mayo_oct_db + comayor.mayo_oct_cr + comayor.mayo_nov_inicial + comayor.mayo_nov_db + comayor.mayo_nov_cr + comayor.mayo_dic_inicial + comayor.mayo_dic_db
							+ comayor.mayo_dic_cr + comayor.mayo_cierre_inicial + comayor.mayo_cierre_db + comayor.mayo_cierre_cr)  
					 INTO :ld_valor   
					 FROM comayor  
					WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
							( comayor.mayo_empresa = :str.empresa ) AND  
							( comayor.mayo_cuenta = :ls_cuenta ) ;   
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al Buscar Movimiento en el Mayor '+sqlca.sqlerrtext,1,1,'E')
								rollback;
								sqlca.autocommit = true
								return
							end if
					if ld_valor > 0 then
						gf_mensaje('','Es una cuenta de Resumen y hay Movimientos, Verifique !!!',1,1,'E')
						return
					end if
				
				  DELETE FROM comayor  
					WHERE ( comayor.mayo_g_financiero = :str.g_financiero ) AND  
							( comayor.mayo_empresa = :str.empresa ) AND  
							( comayor.mayo_cuenta = :ls_cuenta );
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Eliminar del mayor '+sqlca.sqlerrtext,1,1,'E')
						rollback;
						sqlca.autocommit = true
						return
					end if
			end if
			
			this.deleterow(this.getrow())			
			if this.update() = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				gf_mensaje('','Error al Elimiar Cuenta '+ls_error,1,1,'E')				
				sqlca.autocommit = true
				return
			else
				
				li_encontro = idw_5.find('mg_cuenta = "'+ls_cuenta+'"',1,idw_5.rowcount())
				if li_encontro > 0 then
					idw_5.scrolltorow(li_encontro)
					idw_5.deleterow(li_encontro)
				end if
				commit;
			end if
			sqlca.autocommit = true			
			this.insertrow(1)

		end if
	case 'b_cerrar_cli'
		iw_window.triggerevent('close')
	case	'b_grabar_cli'
		wf_grabar_cliente(this, row)			

end choose
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;string ls_filtro
integer li_rtn

accepttext()

CHOOSE CASE dwo.name
	CASE "mg_cod_grupo"
		ls_filtro = This.GetItemString(row,"mg_cod_grupo")
		if not isnull(ls_filtro) and ls_filtro <> '' then 
			idwc_subgrupo.SetFilter("asgr_cod_grupo = '" + ls_filtro + "'")	
			li_rtn = idwc_subgrupo.Filter()	
		end if
end choose
end event

type tabpage_2 from w_grampa_tab`tabpage_2 within tab_1
boolean visible = false
integer width = 2647
integer height = 980
boolean enabled = false
long backcolor = 12639424
string pointer = "HyperLink!"
string text = "Financiera"
long tabbackcolor = 12632256
string picturename = "Cursor!"
string powertiptext = "Datos Financiero"
cb_2 cb_2
cb_1 cb_1
pb_1 pb_1
st_2 st_2
pb_mala pb_mala
st_texto_cuenta_mala st_texto_cuenta_mala
end type

on tabpage_2.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.pb_1=create pb_1
this.st_2=create st_2
this.pb_mala=create pb_mala
this.st_texto_cuenta_mala=create st_texto_cuenta_mala
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.pb_mala
this.Control[iCurrent+6]=this.st_texto_cuenta_mala
end on

on tabpage_2.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.pb_mala)
destroy(this.st_texto_cuenta_mala)
end on

type dw_2 from w_grampa_tab`dw_2 within tabpage_2
event ue_down pbm_dwnkey
integer x = 41
integer y = 204
integer width = 2331
integer height = 1340
end type

event dw_2::ue_down;if keydown(Keyescape!) then
	iw_window.postevent('close')
end if
end event

event dw_2::clicked;call super::clicked;
THIS.ACCEPTTEXT()

choose case dwo.name
	case 'b_cerrar_cli'
		iw_window.triggerevent('close')
	case	'b_grabar_cli'
		wf_grabar_cliente(this, row)		
	case  'b_cambiar_limite'
		wf_cambiar_limite()
end choose
end event

event dw_2::itemchanged;call super::itemchanged;this.accepttext()
long ll_tercero
string ls_detalle
datetime ldt_fecha
if this.getcolumnname() = 'ccmclien_clie_estado' then
	if data = 'I' then
		
		if gf_mensaje('','Esta seguro de INACTIVAR el cliente ?',2,2,'E') = 2 then return 2		
		ls_detalle = 'Se Inactivo el Cliente'		
	else
		ls_detalle = 'Se Activo el Cliente'
	end if
	
	ll_tercero = idw_1.getitemnumber(1,'terc_tercero')
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
		
		wf_grabar_cliente(this, row)		
		
	commit ;
end if
end event

event dw_2::doubleclicked;call super::doubleclicked;if dwo.name = 'ccmclien_clie_limite_credito' then
	wf_cambiar_limite()
end if
end event

type tabpage_3 from w_grampa_tab`tabpage_3 within tab_1
boolean visible = false
integer width = 2647
integer height = 980
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
string dataobject = "dw_busca_cuentas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
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

event clicked;	str_cc_formatos str_formato1		
	str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	str_formato1.tercero = idw_1.getitemNumber(1,"terc_tercero")
	Opensheetwithparm(w_estadocuenta,str_formato1,str.frame,2,original!)
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

type st_1 from statictext within w_plan_de_cuentas
integer x = 846
integer y = 528
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

type pb_top from picturebutton within w_plan_de_cuentas
integer x = 891
integer y = 548
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

type pb_back from picturebutton within w_plan_de_cuentas
integer x = 1038
integer y = 548
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

type pb_next from picturebutton within w_plan_de_cuentas
integer x = 1189
integer y = 548
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

type pb_bottom from picturebutton within w_plan_de_cuentas
integer x = 1335
integer y = 548
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

