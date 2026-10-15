//objectcomments Ventana fondo de toda la Aplicación
forward
global type w_cc_fondo from window
end type
type st_empresa from statictext within w_cc_fondo
end type
type st_1 from statictext within w_cc_fondo
end type
end forward

global type w_cc_fondo from window
integer x = 137
integer y = 168
integer width = 2688
integer height = 1560
boolean enabled = false
windowtype windowtype = child!
long backcolor = 16777215
event ue_post_open ( )
event ue_pic ( )
st_empresa st_empresa
st_1 st_1
end type
global w_cc_fondo w_cc_fondo

type variables
str_cc_parametros str_para

boolean	ib_bandera, ib_activar = false

date	id_fecini

datetime    ldt_fecini




end variables

forward prototypes
public subroutine wf_carga_inicial ()
public subroutine wf_botones ()
end prototypes

event ue_post_open;wf_carga_inicial()
//wf_fondo()

st_empresa.text = '  '+gf_fa_nom_empr(str.g_financiero,str.empresa)

st_1.y = This.Height - st_1.Height
st_1.x = This.width - st_1.width

st_empresa.y = This.Height - st_empresa.Height
st_empresa.x = 1

st_1.visible = true
st_empresa.visible = true



//st_empresa
//if ib_activar then timer(60)

end event

public subroutine wf_carga_inicial ();string  ls_empresa, ls_descrip, ls_fecini, ls_db_err, ls_gf
date    ld_fecini
Long    ll_x,ll_y,ll_ox,ll_oy,ll_cox,ll_coy
integer li_ano_ini, li_contador, li_mes_ini, li_dberror

// Para X
//ll_x = this.width/2
//ll_ox = p_1.width/2
//ll_cox = ll_x - ll_ox

// Para Y
//ll_y = this.Height/2
//ll_oy = p_1.Height/2
//ll_coy = ll_y - ll_oy
//
//p_1.x = ll_cox
//p_1.y = ll_coy

/* SE CARGA LA ESTRUCTURA DE PARAMETROS INICIALES DE CUENTAS POR COBRAR */

  SELECT ccmparam.para_mes,   
         ccmparam.para_ano,   
         ccmparam.para_ultima_morocidad,   
         ccmparam.para_proxcicaj,   
         ccmparam.para_ulticicaj,   
         ccmparam.para_mens_aldia,   
         ccmparam.para_mens_mora,   
         ccmparam.para_mensaje_renovacion,   
         ccmparam.para_tiempo_aviso,   
         ccmparam.para_aplica_morosidad,   
         ccmparam.para_enl_conta,
			ccmparam.para_empre_logo,
			ccmparam.para_empre_fondo,
			ccmparam.para_empre_logoaplic,
         ccmparam.para_imprime_informe,
			ccmparam.para_fecha_ini_apli			
         
	 INTO :str_para.mes,   
         :str_para.ano, 
			:str_para.ult_morosidad,  
			:str_para.proxcicaj,
			:str_para.ulticicaj,
			:str_para.mens_aldia, 
			:str_para.mens_mora,
			:str_para.mensaje_renovacion,
			:str_para.tiempo_aviso,   
         :str_para.aplica_morosidad,   
         :str_para.enlace_conta,
			:str_para.empre_logo,
			:str_para.empre_fondo,
			:str_para.empre_logaplic,
			:str_para.imp_informe,
			:ldt_fecini
   FROM ccmparam  
   WHERE ( ccmparam.para_g_financiero = :str.g_financiero ) AND  
         ( ccmparam.para_empresa = :str.empresa ) ;  


IF SQLCA.SQLCode <> 0 then
	str_para.estado = false
	
	if sqlca.sqlcode = 100 then
		ls_descrip = 'Usted debe ir a la Opción de Parámetros - Sistema - Parámetros '+&
															'Iniciales; luego el Sistema se Cerrará '+&
															'Automáticamente (puede entrar inmediatamente. '
	else
		ls_descrip = '. Contacte a su Administrador de Servicios.'
	end if
	mensaje('¡Atención!','No fue posible cargar los '+ &
				'Parámetros Iniciales','Descripción: '+sqlca.sqlerrtext+ls_descrip)
	
	wf_botones()
	
	if sqlca.sqlcode = 100 then
//		OpenSheetWithParm(w_cc_man_parametros_logos,'C',str.frame,0,Original!)
	else
		halt close
	end if
//	
//	p_1.picturename = str.path + "\art\harr_logo.bmp"
	
//	messagebox("Advertencia", "No fue posible cargar los Parámetros Iniciales" + sqlca.sqlerrtext)
//
//	wf_botones()
//	OpenSheet(w_cc_man_para_concili_mensajes,w_cc_fondo,9,Original!)
////	OpenSheet(w_cc_man_parametros,w_cc_fondo,9,Original!)
	//p_1.picturename = str.path + "\art\harr_logo.bmp"
	
Else
//	 UPDATE cctcarpa  
//     SET   carp_estado = 'IM'  
//	 WHERE  ( cctcarpa.carp_estado 			= 'AC' 					);
//		IF SQLCA.SQLCode = -1 THEN 
//			Mensaje("informacion", "Error al actualizar Transacciones en CCTARPA!",SQLCA.SQLErrText)
//			ROLLBACK USING SQLCA;
//		ELSE
//			COMMIT USING SQLCA;
//		END IF
//
//	UPDATE cctrecib  
//     SET   reci_estado = 'IM'  
//	 WHERE  ( cctrecib.reci_estado 			= 'AC' 					);
//		IF SQLCA.SQLCode = -1 THEN 
//			Mensaje("informacion", "Error al actualizar Transacciones en CCTRECIB!",SQLCA.SQLErrText)
//			ROLLBACK USING SQLCA;
//		ELSE
//			COMMIT USING SQLCA;
//		END IF

//	  UPDATE cctmovim
//     SET movi_estado = 'IM'  
//   WHERE ( cctmovim.movi_g_financiero = 1 ) AND  
//         ( cctmovim.movi_empresa = 1 ) AND  
//         ( cctmovim.movi_estado = 'AC' )   ;
//		IF SQLCA.SQLCode = -1 THEN 
//			Mensaje("informacion", "Error al actualizar Transacciones en CCTMOVIM!",SQLCA.SQLErrText)
//			ROLLBACK USING SQLCA;
//		ELSE
//			COMMIT USING SQLCA;
//		END IF
	
	str_para.estado = true	
//	If str_para.empre_logaplic = "" Or IsNull(str_para.empre_logaplic) then
//		p_1.picturename = str.path + "\art\harr_logo.bmp"
//	Else
//		p_1.picturename = str_para.empre_logaplic
//	End IF


	if isnull(str_para.mes) or str_para.mes = 0 or isnull(str_para.ano) then
//		messagebox('¡Buenos Días Sr. Usuario!','¡¡¡ Bienvenido al Sistema de Cuentas por '+&
//						'Pagar !!!',information!)
//						
		ls_descrip = 'Usted debe ir a la Opción de Parámetros - Sistema - Parámetros '+&
															'Iniciales; luego el Sistema se Cerrará '+&
															'Automáticamente (puede entrar inmediatamente.'
		mensaje('¡Atención!','No fue posible cargar los '+ &
					'Parámetros Iniciales (Mes y/o Año de Proceso).','Descripción: '+ls_descrip)
					
//		OpenSheetWithParm(w_cc_man_parametros_logos,'C',str.frame,0,Original!)			
//		OpenSheetWithParm(w_cc_man_parametros_fecha,'C',str.frame,0,Original!)
		
	end if
	
//	if isnull(ldt_fecini) then
//		
////		messagebox('¡Buenos Días Sr. Usuario!','¡¡¡ Bienvenido al Sistema de Cuentas por '+&
////						'Cobrar !!!',information!)
////		
//		messagebox('¡Atención!','El Sistema colocará automáticamente la Fecha de Inicio del '+&
//						'Sistema.',information!)
//		
//		open(w_cc_man_parametros_fecha)
//		
//		ld_fecini = date('01/'+string(str_para.mes)+'/'+string(str_para.ano))
//		
//		ls_fecini = string(ld_fecini,'dd/mm/yyyy')
//		
//		str_para.fecha_inicio = date(ls_fecini)
//		
//		str_para.captura_inicial = false
//	else
		str_para.fecha_inicio = date(ldt_fecini)
		li_mes_ini = month(str_para.fecha_inicio)
		li_ano_ini = year(str_para.fecha_inicio)
		
		SELECT count(*)
		INTO :li_contador
		FROM ccmcierr  
		WHERE ( ccmcierr.cier_g_financiero = :str.g_financiero ) AND  
			( ccmcierr.cier_empresa = :str.empresa ) AND
			( ccmcierr.cier_mes = :li_mes_ini ) AND
			( ccmcierr.cier_ano = :li_ano_ini);
	If sqlca.sqlcode = -1 then
		li_dberror = sqlca.sqldbcode
		ls_db_err = sqlca.SQLErrText
		mensaje("Error"+string(li_dberror),"No se pudo recuperar el mes en ccmcierr",&
					'Descripción del error: '+ls_db_err)
		return
	end if

	if not isnull(li_contador) and li_contador > 0 then
//		m_fa_padre.m_capturas1.m_saldosiniciales.visible = false
	else
//		m_fa_padre.m_capturas1.m_saldosiniciales.visible = true
	end if
//	if str_para.imp_informe = 'S' then
//		m_cc_padre.m_parmetros.m_transinfocaja.visible=true
//   else		
//		m_cc_padre.m_parmetros.m_transinfocaja.visible=false
//	end if

//		
//		str_para.fecha_inicio = date(ldt_fecini)
//		if year(str_para.fecha_inicio) = str_para.ano and &
//		month(str_para.fecha_inicio) = str_para.mes then
//			str_para.captura_inicial = true
//			m_cc_padre.m_capturas1.m_saldosiniciales.visible = true
////			messagebox('¡Información!','La Empresa está en período de Captura Inicial.',information!)
//			ib_activar = true
//		else
//			str_para.captura_inicial = false
//		end if
//
//	end if
	
	if trim(str_para.empre_logaplic) = "" or IsNull(str_para.empre_logaplic) then
		//p_1.picturename = str.path + "\art\harr_logo.bmp"
	else
		//p_1.picturename = str_para.empre_logaplic
	end if
	
	str.frame.Title = "(CC) Sistema de Cuentas por Cobrar. Mes de Proceso " + &
							string(gf_dg_mes(str_para.mes)) + " de " + string(str_para.ano)
//----------------------------------------------------------------	

  SELECT dgmempre.empr_razon_social
    into :ls_empresa
    FROM dgmempre  
   WHERE ( dgmempre.empr_g_financiero = :str.g_financiero ) AND  
         ( dgmempre.empr_empresa = :str.empresa ) ;
		if sqlca.sqlcode = -1 then
			mensaje('Aviso','Error al Seleccionar el Nombre',sqlca.sqlerrtext)
		end if

//ls_gf = gf_dg_nom_gfinanciero(str.g_financiero, str.empresa)
str.frame.Title = ls_empresa +".  Mes de Proceso " +  &
				 string(gf_dg_mes(str_para.mes)) +" de "+string(str_para.ano)


//str.frame.Title = "(CC)Sistema de Cuentas por Cobrar. " + ls_empresa +" Mes de Proceso " +  &
//				 string(gf_dg_mes(str_para.mes)) +" de "+string(str_para.ano)
End If


//p_1.visible = true

end subroutine

public subroutine wf_botones ();// Deshabilita algunas Opciones del Menú 
	
//	m_fa_padre.m_archivo.m_1.enabled = false
	m_fa_padre.m_archivo.m_imprimir.enabled = false
	m_fa_padre.m_edicin.enabled = false
//	m_fa_padre.m_consultas.enabled = false

//	m_fa_padre.m_informes.enabled = false
//	m_fa_padre.m_controldecxc.enabled = false
	
	
	
   /*Insertar*/
	m_fa_padre.m_edicin.m_insertar.toolbaritemvisible=false
	m_fa_padre.m_edicin.m_insertar.visible=false
	
	/*Adicionar*/
	m_fa_padre.m_edicin.m_adicionar.toolbaritemvisible=false
	m_fa_padre.m_edicin.m_adicionar.visible=false
	
	/*Filtrar*/
	m_fa_padre.m_edicin.m_filtrar.toolbaritemvisible=false
	m_fa_padre.m_edicin.m_filtrar.visible=false
	
	/*Sortear*/
	m_fa_padre.m_edicin.m_sortear.toolbaritemvisible=false
	m_fa_padre.m_edicin.m_sortear.visible=false
	
	/*Primer Reg*/
	m_fa_padre.m_edicin.m_primerregistro.toolbaritemvisible=false
	m_fa_padre.m_edicin.m_primerregistro.visible=false
	
	/*Ultimo Reg*/
	m_fa_padre.m_edicin.m_ultimoregistro.toolbaritemvisible=false
	m_fa_padre.m_edicin.m_ultimoregistro.visible=false
	
	/*Sig Reg*/
	m_fa_padre.m_edicin.m_siguienteregistro.toolbaritemvisible=false
	m_fa_padre.m_edicin.m_siguienteregistro.visible=false
	

  /*Reg Ant*/
	m_fa_padre.m_edicin.m_registroanterior.toolbaritemvisible=false
	m_fa_padre.m_edicin.m_registroanterior.visible=false

  /*Imprimir*/
   m_fa_padre.m_archivo.m_imprimir.toolbaritemvisible=false
	m_fa_padre.m_archivo.m_imprimir.visible=false
	
	/*Eliminar*/
	m_fa_padre.m_edicin.m_eliminar.toolbaritemvisible=false
	m_fa_padre.m_edicin.m_eliminar.visible=false

	

end subroutine

on w_cc_fondo.create
this.st_empresa=create st_empresa
this.st_1=create st_1
this.Control[]={this.st_empresa,&
this.st_1}
end on

on w_cc_fondo.destroy
destroy(this.st_empresa)
destroy(this.st_1)
end on

event open;sqlca.autocommit =  true
This.PostEvent("ue_post_open")
end event

event timer;// Gianni Araúz (11/11/1999)
// En este script se controla el período de captura inicial, validando que el usuario, a
// pesar de dejar corriendo la aplicación de un día para otro, no pueda seguir capturando.
// Valida que no se ejecute nuevamente el script si el usuario permanece con el mensaje
// desplegado sin presionar Aceptar.

if not ib_bandera then
	ib_bandera = true
	return
end if

//if year(str_para.fecha_inicio) <> str_para.ano or &
//month(str_para.fecha_inicio) <> str_para.mes then
//	messagebox('¡ATENCIÓN!','EL SISTEMA HA CONCLUIDO EL PERÍODO DE CAPTURA INICIAL, POR '+&
//					'LO QUE SE CERRARÁ PARA REASIGNAR VALORES....PUEDE ENTRAR INMEDIATAMENTE.',&
//					exclamation!)
//	halt close
//	return
//end if
//
ib_bandera = false

end event

type st_empresa from statictext within w_cc_fondo
integer x = 55
integer y = 1420
integer width = 2345
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Courier New"
long textcolor = 8388608
long backcolor = 16777215
boolean enabled = false
boolean focusrectangle = false
end type

type st_1 from statictext within w_cc_fondo
boolean visible = false
integer x = 1842
integer y = 1440
integer width = 713
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Courier New"
long textcolor = 8388608
long backcolor = 16777215
boolean enabled = false
string text = "CUENTAS POR COBRAR"
boolean focusrectangle = false
end type

