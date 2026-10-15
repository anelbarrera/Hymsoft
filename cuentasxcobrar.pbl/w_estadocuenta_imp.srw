//objectcomments Ventana del Informe del  Estado de Cuentas
forward
global type w_estadocuenta_imp from w_fa_padre_reportes
end type
type cb_calcular from commandbutton within w_estadocuenta_imp
end type
type em_monto from editmask within w_estadocuenta_imp
end type
type cb_aplicar from commandbutton within w_estadocuenta_imp
end type
type dw_2 from datawindow within w_estadocuenta_imp
end type
type dw_3 from datawindow within w_estadocuenta_imp
end type
type dw_4 from datawindow within w_estadocuenta_imp
end type
end forward

global type w_estadocuenta_imp from w_fa_padre_reportes
boolean visible = false
integer x = 128
integer y = 100
integer width = 5655
integer height = 2176
string title = ""
long backcolor = 12639424
cb_calcular cb_calcular
em_monto em_monto
cb_aplicar cb_aplicar
dw_2 dw_2
dw_3 dw_3
dw_4 dw_4
end type
global w_estadocuenta_imp w_estadocuenta_imp

type variables
str_rangofecha istr_rangfech

decimal idec_saldo_anterior
string  is_tip_busca, is_rango_descri,is_muestra_nombre
str_cc_formatos str_formato
n_cst_sys gnv_sys
end variables

forward prototypes
public subroutine wf_control_columna (integer registro)
public subroutine wf_asignar_antig ()
public function boolean wf_actualiza_antiguedad (datetime adt_desde, datetime adt_hasta, long al_tercero, long al_dias_limite)
public function boolean wf_asigna_antig_moroso ()
public function boolean wf_antiguedad ()
public function string wf_secuencia_tran ()
public function integer wf_send_mail (string as_archivo, string as_tag, string as_titulo, string as_correo)
end prototypes

public subroutine wf_control_columna (integer registro);
if registro <= 12  then
	dw.modify('rr_6.width= 1513')
	dw.modify('l_11.x2= 1531')
	dw.modify('l_15.visible=false')
	dw.modify('ccatpan_tpan_col13_t.visible= false')
	dw.modify('ccatpan_tpan_col13.visible= false')
	dw.modify('ccatpan_tpan_col21_t_1.x=1175')
	dw.modify('ccatpan_tpan_col21_1.x=1175')
end if

if registro <= 11  then
	dw.modify('rr_6.width= 1143')
	dw.modify('l_11.x2= 1161')
	dw.modify('l_14.visible=false')
	dw.modify('ccatpan_tpan_col12_t.visible= false')
	dw.modify('ccatpan_tpan_col12.visible= false')
	dw.modify('ccatpan_tpan_col21_t_1.x=800')
	dw.modify('ccatpan_tpan_col21_1.x=800')
end if

if registro <= 10 then
	dw.modify('rr_6.width= 768')
	dw.modify('l_11.x2= 782')
	dw.modify('l_13.visible=false')
	dw.modify('ccatpan_tpan_col11_t.visible= false')
	dw.modify('ccatpan_tpan_col11.visible= false')
	dw.modify('ccatpan_tpan_col21_t_1.x=425')
	dw.modify('ccatpan_tpan_col21_1.x=425')
end if

if registro <= 9 then
	dw.modify('rr_6.width= 393')
	dw.modify('l_11.x2= 411')
	dw.modify('l_12.visible=false')
	dw.modify('ccatpan_tpan_col10_t.visible= false')
	dw.modify('ccatpan_tpan_col10.visible= false')
	dw.modify('ccatpan_tpan_col21_t_1.x=41')
	dw.modify('ccatpan_tpan_col21_1.x=41')
end if
	
end subroutine

public subroutine wf_asignar_antig ();string ls_error
integer li_count
/* convierte una antiguedad Vertical en Horizontal */
/* Elimina los Valores Actuales */ 

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
         ( tpan_g_financiero,   
           tpan_empresa,   
           tpan_tercero,
			  tpan_saldo_anterior,
           tpan_col1,   
           tpan_col2,   
           tpan_col3,   
           tpan_col4,   
           tpan_col5,   
           tpan_col6,   
           tpan_col7,   
           tpan_col8,   
           tpan_col9,   
           tpan_col10,   
           tpan_col11, 
	        tpan_col12, 
           tpan_col13, 
           tpan_col21,   
           tpan_col1_t,   
           tpan_col2_t,   
           tpan_col3_t,   
           tpan_col4_t,   
           tpan_col5_t,   
           tpan_col6_t,   
           tpan_col7_t,   
           tpan_col8_t,   
           tpan_col9_t,   
           tpan_col10_t,   
           tpan_col11_t,
           tpan_col12_t,
           tpan_col13_t,
           tpan_col21_t,
			  tpan_maquina)   
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
	return
else	
	commit ; 
	//mensaje('','Inserto en CCATPAN','')
end if


end subroutine

public function boolean wf_actualiza_antiguedad (datetime adt_desde, datetime adt_hasta, long al_tercero, long al_dias_limite);
Integer  li_registros, li_i, li_empresa, li_grupofin, li_emp, li_dberror, &
         li_tipo, li_socio, li_audit
decimal  ld_x, ld_y, ld_monto
string   ls_db_err,ls_where_select, ls_error,ls_error_proc
long 		ll_tercero,ll_i,ll_proximo
Datetime ld_tiempo1, ld_tiempo2

DELETE FROM ccatempa
WHERE ( ccatempa.tmpa_g_financiero 	= :str.g_financiero 	) AND  
      ( ccatempa.tmpa_empresa 		= :str.empresa 		) and
		( ccatempa.tmpa_tercero 		= :al_tercero 			) AND
		( ccatempa.tmpa_usuario_maquina = :str.maquina 		) ;
if sqlca.sqlcode = -1 then
	messagebox('error','error al elimianr registros desde ccatempa')
end if

ld_tiempo1 = adt_desde
ld_tiempo2 = adt_hasta

ll_tercero = al_tercero
				
gf_antiguedad_x_cliente_moroso(ld_tiempo2, ll_tercero,'E',ld_tiempo1, al_dias_limite)


return true
end function

public function boolean wf_asigna_antig_moroso ();string ls_error

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
		( ccatempa.tmpa_usuario_maquina = :str.maquina) and
		( ccatempa.tmpa_maxdias >= tmpa_dias_morosos )
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

public function boolean wf_antiguedad ();long ll_tercero, i, ll_dias
datetime ld_tiempo1, ld_tiempo2, ldt_fecha
date		ldt_fecha_desde, ldt_fecha_hasta
ldt_fecha = gf_fecha_serv()
ldt_fecha_hasta = date(ldt_fecha)
ldt_fecha_desde = relativedate(date(gf_fecha_serv()), - 365)
ld_tiempo1 = Datetime(ldt_fecha_desde,00:00:00)
ld_tiempo2 = Datetime(ldt_fecha_hasta,00:00:00)
str.frame.setmicrohelp('Configurando la Antiguedad')
for i = 1 to dw_2.rowcount()
	ll_tercero = dw_2.getitemnumber(i,'clie_tercero')
	ll_dias	  = dw_2.getitemnumber(i,'dias_limite')
	wf_actualiza_antiguedad(ld_tiempo1, ld_tiempo2, ll_tercero, ll_dias)
	str.frame.setmicrohelp('Asignando Valores al Formato')
	wf_asigna_antig_moroso()				
next
return true
end function

public function string wf_secuencia_tran ();string ls_sec
long ll_max
integer li_existe, li_ann

li_ann = year(date(gf_fecha_serv()))

select max(convert(numeric(8),mser_secuencia))
into :ll_max
from dgmserie
where mser_g_financiero = :str.g_financiero and
	 	mser_empresa		= :str.empresa and
		mser_tipo_transaccion = 'ND' ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al seleccionar secuencia '+sqlca.sqlerrtext,1,1,'E')
			return ''
		end if
		

	DO WHILE true
		ll_max = ll_max + 1		
		ls_sec = string(ll_max)
		
		select count(*) into :li_existe
		from cctmovim
		where movi_g_financiero = :str.g_financiero and
				movi_empresa		= :str.empresa and
				movi_tipo_transaccion = 'ND' and
//				movi_sub_transaccion = 'IN' and
				movi_documento 	=  :ls_sec and
				movi_anno			=  :li_ann ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al validar existencia '+sqlca.sqlerrtext,1,1,'E')
					return ''
				end if
										
			if li_existe = 0 then
				exit
			end if
	LOOP

return ls_sec
end function

public function integer wf_send_mail (string as_archivo, string as_tag, string as_titulo, string as_correo);
//Variables Locales a ser usadas 
Integer	   li_Smtp_Puerto, i
Integer      li_max 
Integer      li_rc
Integer      li_idx
String 	   ls_Nombre_Archivo, ls_Remitente_Email, ls_Remitente_Usuario, ls_Remitente_contraseña, ls_Smtp_Servidor, ls_ToArray[], ls_tag
String 	   ls_Smtp_Tipo_Conexion, ls_Smtp_Puerto, ls_Destinatario_Email, ls_Destinatario_Nombre, ls_Asunto, ls_Mensaje, &
			   ls_Destinatario_Copia_Email, ls_Destinatario_Copia_Nombre, ls_Destinatario_Copia_Oculta_Email, ls_Destinatario_Copia_Oculta_Nombre
Boolean     lb_Return

// Creacion SmtpClient
SMTPClient lnv_SMTPClient
lnv_SMTPClient =  create SMTPClient

ls_tag = as_tag		//  ls_tag

//smtp-mail.outlook.com     Hotmail
//smtp.gmail.com                Gmail

// Setear el archivo log
	lnv_SMTPClient.LogFile("mail.log")

	SetPointer ( HourGlass! )
	
	//Reset SMTPClient Message
	lnv_SMTPClient.message.reset()

	// Los Datos del Remitente
	ls_Remitente_Email = ProfileString('config.ini', ls_tag, "SendEmail", "")
	lnv_SMTPClient.Message.SetSender(ls_Remitente_Email)
		
	// Los Datos de la conexion del Email Remitente
	ls_Remitente_Usuario = ProfileString('config.ini', ls_tag, "UserID", "")
	ls_Remitente_Contraseña = ProfileString('config.ini', ls_tag, "Password", "")
	IF ls_Remitente_Usuario <> ''  AND ls_Remitente_Contraseña <> '' THEN
		lnv_SMTPClient.Username =ls_Remitente_Usuario
		lnv_SMTPClient.password = ls_Remitente_Contraseña
	END IF

	// Los Datos del servidor
	ls_Smtp_Servidor = ProfileString('config.ini', ls_tag, "Server", "")
	lnv_SMTPClient.Host = ls_Smtp_Servidor
	
	// Los Datos del Puerto del Servidor
	ls_Smtp_Puerto = ProfileString('config.ini', ls_tag, "Port", "")
	IF IsNumber ( ls_Smtp_Puerto ) THEN
		li_Smtp_Puerto = Integer ( ls_Smtp_Puerto )
		lnv_SMTPClient.Port = li_Smtp_Puerto
	END IF

	// Los Datos del Destinatario
	ls_Destinatario_Email = ProfileString('config.ini', ls_tag, "FromEmail", "")	
	if len(ls_Destinatario_Email) > 0 and len(as_correo) > 0  then
		ls_Destinatario_Email = as_correo+', '+ls_Destinatario_Email
	else
		ls_Destinatario_Email = as_correo
	end if
	ls_Destinatario_Nombre = ProfileString('config.ini', ls_tag, "FromName", "")		
	ls_Destinatario_Email = gnv_sys.of_ReplaceAll(ls_Destinatario_Email,' ', '',False)
	ls_Destinatario_Email = gnv_sys.of_ReplaceAll(ls_Destinatario_Email,',', ';',False)
	gnv_sys.of_StringToArray(ls_Destinatario_Email,';', ls_ToArray[])
	For i = 1 To UpperBound(ls_ToArray[])
		lnv_SMTPClient.message.AddRecipient(ls_ToArray[i])
	Next 
	
	//IF ls_Destinatario_Email <> '' THEN
	//	lnv_SMTPClient.Message.AddRecipient(ls_Destinatario_Email ,ls_Destinatario_Nombre)
     //END IF
	  
	// Los Datos del Destinatario en Copia
	ls_Destinatario_Copia_Email = ProfileString('config.ini', ls_tag, "CopiaEmail", "")	
	ls_Destinatario_Copia_Nombre = ProfileString('config.ini', ls_tag, "CopiaName", "")	
	IF ls_Destinatario_Copia_Email <> '' THEN
		lnv_SMTPClient.Message.addcc(ls_Destinatario_Copia_Email,  ls_Destinatario_Copia_Nombre)
	END IF
	 
	 // Los Datos del Destinatario en Copia Oculta
	ls_Destinatario_Copia_Oculta_Email = ProfileString('config.ini', ls_tag, "CopiaOcultaEmail", "")	
	ls_Destinatario_Copia_Oculta_Nombre = ProfileString('config.ini', ls_tag, "CopiaOcultaName", "")	
	IF ls_Destinatario_Copia_Oculta_Email <> '' THEN
		lnv_SMTPClient.Message.addbcc(ls_Destinatario_Copia_Oculta_Email,  ls_Destinatario_Copia_Oculta_Nombre)
	END IF
	
	// Asunto del E-Mail
	ls_Asunto = ProfileString('config.ini', ls_tag, "Subject", "")		 
  	lnv_SMTPClient.Message.Subject = ls_Asunto + ' ' + as_titulo
	
	//Prioridad Alta
	lnv_SMTPClient.Message.priority = 2  
	
	//Cuerpo del Email
	ls_Mensaje = ProfileString('config.ini', ls_tag, "Body", "")		
	lnv_SMTPClient.Message.HtmlBody = ls_Mensaje

	lnv_SMTPClient.Message.AddAttachment( as_Archivo )
	
	li_rc = lnv_SMTPClient.Send()
	
	IF li_rc = 1 THEN
		 Messagebox('Atencion','Mail Enviado')
	ELSE
		 Messagebox('Atencion' ,'Email Error Enviando. Return ' + String(li_rc) + '.', StopSign!)
	END IF
	
	DESTROY lnv_SMTPClient

return li_rc
end function

on w_estadocuenta_imp.create
int iCurrent
call super::create
this.cb_calcular=create cb_calcular
this.em_monto=create em_monto
this.cb_aplicar=create cb_aplicar
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_calcular
this.Control[iCurrent+2]=this.em_monto
this.Control[iCurrent+3]=this.cb_aplicar
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.dw_4
end on

on w_estadocuenta_imp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_calcular)
destroy(this.em_monto)
destroy(this.cb_aplicar)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
end on

event resize;//Override
str.frame.setredraw(false)

//this.width = newwidth - 20
//this.height = newheight - 30

//dw_1.width = this.width  - 50
dw_1.height = this.height - 300

gb_1.width = this.width  - 40
gb_1.height = this.height - 272

cb_calcular.y = newheight - 120
cb_aplicar.y = newheight - 120
em_monto.y = newheight - 120

str.frame.setredraw(true)
end event

event ue_post_open;Integer  li_registros, li_i, li_empresa, li_grupofin, li_cliente , li_emp, li_dberror,&
         li_tip_cliente, li_grupo, li_tipo = 0, li_socio = 0, li_audit = 0, li_estadoc
decimal  ld_x, ld_y, ld_monto
string   ls_db_err, ls_fecha_est, ls_fecha_text, ls_mensaje, ls_datawindow, nombre_de_data
long 		ll_tercero
Datetime ld_tiempo1, ld_tiempo2
date ld_fecha_2
gnv_sys = Create n_cst_sys

Datawindowchild ldwc_sub_tran, ldwc_pais, ldwc_region, ldwc_credito
//dw_1.SetRedraw ( false )

//Para ocultar las opciones de consultas, cuando es Elbros
if pos(gf_dg_nombre_empresa(),'ELBROS') > 0 then gf_fa_cambiar_titulos(this.menuid)


dw_1.show() 
dw = dw_1
//dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()
gf_center_win(this)
this.y = 0
istr_rangfech = message.powerObjectParm

// Se Desabilitan Botones del menu Principal

if not isvalid(m_fa_rep) then ChangeMenu(m_fa_rep)
m_fa_rep.m_archivo.m_guardar.toolbaritemvisible				=false
m_fa_rep.m_archivo.m_guardar.visible							=false
m_fa_rep.m_archivo.m_guardar.enabled							=false
m_fa_rep.m_edicin.m_primerregistro.toolbaritemvisible		=true
m_fa_rep.m_edicin.m_primerregistro.visible			  		=true
m_fa_rep.m_edicin.m_adicionar.toolbaritemvisible			=false
m_fa_rep.m_edicin.m_adicionar.visible							=false
m_fa_rep.m_edicin.m_insertar.toolbaritemvisible				=false
m_fa_rep.m_edicin.m_insertar.visible							=false
m_fa_rep.m_edicin.m_eliminar.toolbaritemvisible				=false
m_fa_rep.m_edicin.m_eliminar.visible							=false
m_fa_rep.m_edicin.m_filtrar.toolbaritemvisible				=true
m_fa_rep.m_edicin.m_filtrar.visible								=true
m_fa_rep.m_edicin.m_sortear.toolbaritemvisible				=true
m_fa_rep.m_edicin.m_sortear.visible								=true
m_fa_rep.m_edicin.m_busqueda.toolbaritemvisible				=false
m_fa_rep.m_edicin.m_busqueda.visible							=false
m_fa_rep.m_edicin.m_ultimoregistro.toolbaritemvisible		=true
m_fa_rep.m_edicin.m_ultimoregistro.visible					=true
m_fa_rep.m_edicin.m_siguienteregistro.toolbaritemvisible	=true
m_fa_rep.m_edicin.m_siguienteregistro.visible				=true
m_fa_rep.m_edicin.m_registroanterior.toolbaritemvisible	=true
m_fa_rep.m_edicin.m_registroanterior.visible					=true

ld_tiempo1 = Datetime(istr_rangfech.fecha1,00:00:00)
ld_tiempo2 = Datetime(istr_rangfech.fecha2,00:00:00)

//Cuenta los regidtros en ccaantig
  SELECT count(*)  
    INTO :li_registros  
    FROM ccaantig  
   WHERE ( ccaantig.ccan_g_financiero = :str.g_financiero ) AND  
         ( ccaantig.ccan_empresa = :str.empresa )   ;
if sqlca.sqlcode = -1 then
	ls_db_err = sqlca.sqlerrtext
	mensaje('Error','Error al contar registros en ccantig',ls_db_err)
end if



if isnull(istr_rangfech.preimpreso) then istr_rangfech.preimpreso = 'N'

if istr_rangfech.tipo_bd > 0 then
//	CASE > 0//sql
	CHOOSE CASE istr_rangfech.opcion

	CASE 'P' //Por Cliente 
		this.title 		= "Estado de Cuenta de Clientes"
		
		CHOOSE CASE istr_rangfech.tipo_accion
			CASE '2'	//con movimientos o sin movimientos
				if istr_rangfech.idioma = 'E' then//Idioma Español
					dw.DataObject = 'dw_cc_inf_estcuen_sin_mov_sql'//
				elseif istr_rangfech.idioma = 'I' then//Idioma Inglés
					dw.DataObject = 'dw_cc_inf_estcuen_sin_mov_ingles_sql'//
				end if
		   CASE ELSE
				choose case istr_rangfech.preimpreso
					case 'N'
						choose case istr_rangfech.idioma 
							case  'E' 
								dw.DataObject = 'dw_cc_inf_est_cuen_x_cliente_sql'
							case 'I' 
								dw.DataObject = 'dw_cc_inf_estcuen_ingles_sql'
						end choose			
				   CASE ELSE
//						      select forma_datawindow
//								into :ls_datawindow
//								from ccaforma
//								where forma_g_financiero = :str.g_financiero and
//										forma_empresa		 = :str.empresa and
//										forma_tipo_formato = 'EST'
//								and   forma_formato = 'ESTAD' ;
//								if sqlca.sqlcode = 0 then
////									dw.DataObject = 'dw_cc_inf_est_cuen_x_textiles'
//									dw.DataObject = ls_datawindow
//								else
//									messagebox("ATENCION","DEBE AGREGAR EN PARAMETROS-FORMATO EL DATAWINDOW")
//									CLOSE(THIS)
//									RETURN
//								end if
					END CHOOSE
		END CHOOSE
		
		
		
		
		dw.SetTransObject(Sqlca)
		SetPointer(HourGlass!)
     
	   //Retrieve a los dropdown--------------------------		
		dw.GetChild("cctmovim_movi_tipo_transaccion",ldwc_sub_tran)
		ldwc_sub_tran.SetTransObject(Sqlca)
		ldwc_sub_tran.Retrieve(str.g_financiero,str.empresa) 
		if ldwc_sub_tran.rowcount() > 0 then
			ldwc_sub_tran.InsertRow(0)
		end if	
		
		dw.GetChild("dgmterce_terc_pais",ldwc_pais)
		ldwc_pais.SetTransObject(Sqlca)
		ldwc_pais.Retrieve(str.g_financiero) 
		gf_cc_haydata_dd(ldwc_pais)
		
		dw.GetChild("dgmterce_terc_region",ldwc_region)
		ldwc_region.SetTransObject(Sqlca)
		ldwc_region.Retrieve(str.g_financiero,str.empresa) 
		gf_cc_haydata_dd(ldwc_region)


   if dw.dataobject = 'dw_cc_inf_est_cuen_x_cliente_preimpreso' then
		dw.GetChild("limite_credito",ldwc_credito)
		ldwc_credito.SetTransObject(Sqlca)
		ldwc_credito.Retrieve(str.g_financiero,str.empresa) 
		gf_cc_haydata_dd(ldwc_credito)

	end if	
		wf_asignar_antig()
		
//		dw.SetRedraw(false)
		if istr_rangfech.tipo_accion = '2' then
			dw.retrieve(str.g_financiero,str.empresa,ld_tiempo1,ld_tiempo2, istr_rangfech.desdecliente,istr_rangfech.hastacliente) //,li_emp)
		else
			if istr_rangfech.tipo_orden = 'N' then //is_tip_busca = 'S' then
				dw.retrieve(str.g_financiero,str.empresa,ld_tiempo1,ld_tiempo2,istr_rangfech.desdeclienteref,istr_rangfech.hastaclienteref) //,li_emp)
			elseif istr_rangfech.tipo_orden = 'A' then
				dw.retrieve(str.g_financiero,str.empresa,ld_tiempo1,ld_tiempo2,istr_rangfech.nombre1,istr_rangfech.nombre2) //,li_emp)
			
			elseif istr_rangfech.tipo_orden = 'C' then
				dw.retrieve(str.g_financiero,str.empresa,ld_tiempo1,ld_tiempo2,istr_rangfech.ruccli1,istr_rangfech.ruccli2) //,li_emp)
			end if
		end if				
		
		if istr_rangfech.tipo_accion <> '2' then
			//Filtrar por tipo de cliente
			if istr_rangfech.tip_cliente = 'P' then
				dw.Setfilter("ccmclien_clie_clasificacion ="+string(istr_rangfech.tipo_cliesp))
				dw.Filter()	
			else
				dw.Setfilter("")
				dw.Filter()
			end if
	//		dw.SetRedraw(true)
			
			if istr_rangfech.tipo_orden = 'A' then
				dw.Setsort("dgmterce_terc_descripcion A, vi_cc_movimientos_movi_fecha_tran A")
				dw.Sort()
			elseif istr_rangfech.tipo_orden = 'C' then
				dw.SetSort("ccmclien_clie_ref_anterior A, vi_cc_movimientos_movi_fecha_tran A")
				dw.Sort()
			elseif istr_rangfech.tipo_orden = 'N' then
				dw.SetSort("ccmclien_clie_tercero A, vi_cc_movimientos_movi_fecha_tran A")
				dw.Sort()
			end if
		end if

		if dw.rowcount() = 0 then
			mensaje('Informacion', 'No se Encontraron Registros......','')
		end if

		SetPointer(Arrow!)
		
	CASE 'G'	//Por Empresa
		this.title = "(CC) Estado de Cuenta por Empresa"
		
      if istr_rangfech.idioma = 'E' then
			dw.DataObject 	= 'dw_cc_inf_est_cuen_clien_empresa_sql'
		elseif istr_rangfech.idioma = 'I' then
			dw.DataObject 	= 'dw_cc_inf_est_cuen_empresa_ingles_sql'
		end if
	
		dw.SetTransObject(Sqlca)

		SetPointer(HourGlass!)

		dw.GetChild("dgmterce_terc_pais",ldwc_pais)
		ldwc_pais.SetTransObject(Sqlca)
		ldwc_pais.Retrieve(str.g_financiero) 
		gf_cc_haydata_dd(ldwc_pais)
		
		dw.GetChild("dgmterce_terc_region",ldwc_region)
		ldwc_region.SetTransObject(Sqlca)
		ldwc_region.Retrieve(str.g_financiero,str.empresa) 
		gf_cc_haydata_dd(ldwc_region)
		
      wf_asignar_antig()

		dw.retrieve(str.g_financiero,istr_rangfech.desdecliente,istr_rangfech.hastacliente,ld_tiempo1,ld_tiempo2)
	
		if istr_rangfech.tipo_orden = 'A' then
			dw.Setsort("vi_cc_movimientos_movi_empresa A, dgmterce_terc_descripcion A, vi_cc_movimientos_movi_fecha_tran A")
			dw.Sort()
		elseif istr_rangfech.tipo_orden = 'C' then
			dw.SetSort("vi_cc_movimientos_movi_empresa A, ccmclien_clie_ref_anterior A, vi_cc_movimientos_mov_fecha_tran A")
			dw.Sort()
		elseif istr_rangfech.tipo_orden = 'N' then
			dw.SetSort("vi_cc_movimientos_empresa A, ccmclien_clie_tercero A, vi_cc_movimientos_movi_tercero A, vi_cc_movimientos_mov_fecha_tran A")
			dw.Sort()
		end if



		if dw.rowcount() = 0 then
			mensaje('Informacion', 'No se Encontraron Registros......','')
		end if

		//dw.object.data_window.expression = "'"+"dw_cc_inf_est_cuen_clien_empresa"+"'"
		SetPointer(Arrow!)

	CASE 'F'	//Por Grupo Financiero
		this.title 		= "(CC) Estado de Cuenta por Grupo Financiero"

		if istr_rangfech.idioma = 'E' then
			dw.DataObject 	= 'dw_cc_inf_est_cuen_clien_gfinan_sql'
		elseif istr_rangfech.idioma = 'I' then
			dw.DataObject 	= 'dw_cc_inf_est_cuen_gfinan_ingles_sql'
		end if	
		
		dw.SetTransObject(Sqlca)
		SetPointer(HourGlass!)

		dw.GetChild("dgmterce_terc_pais",ldwc_pais)
		ldwc_pais.SetTransObject(Sqlca)
		ldwc_pais.Retrieve(str.g_financiero) 
		gf_cc_haydata_dd(ldwc_pais)
		
		dw.GetChild("dgmterce_terc_region",ldwc_region)
		ldwc_region.SetTransObject(Sqlca)
		ldwc_region.Retrieve(str.g_financiero,str.empresa) 
		gf_cc_haydata_dd(ldwc_region)

		wf_asignar_antig()

		dw.retrieve(ld_tiempo1,ld_tiempo2,istr_rangfech.desdecliente,istr_rangfech.hastacliente)
		
		
		if istr_rangfech.tipo_orden = 'A' then
			dw.Setsort("ccmclien_clie_g_financiero A, dgmterce_terc_descripcion A, vi_cc_movimientos_movi_fecha_tran A")
			dw.Sort()
		elseif istr_rangfech.tipo_orden = 'C' then
			dw.SetSort("ccmclien_clie_g_financiero A, ccmclien_clie_ref_anterior A, vi_cc_movimientos_mov_fecha_tran A")
			dw.Sort()
		elseif istr_rangfech.tipo_orden = 'N' then
			dw.SetSort("ccmclien_clie_g_financiero A, ccmclien_clie_tercero A, vi_cc_movimientos_mov_fecha_tran A")
			dw.Sort()
		end if



		if dw.rowcount() = 0 then
			mensaje('informacion', 'No se Encontraron Registros......','')
		end if

		SetPointer(Arrow!)
		//dw.object.data_windo.expression = "'"+"dw_cc_inf_est_cuen_clien_gfinan_sql"+"'"

		li_grupo = gf_cc_imprime_grupo(str.g_financiero,str.empresa)
		if isnull(li_grupo) then li_grupo = 0
		if li_grupo = 1 then
			dw.object.financiero.expression = "'"+gf_dg_nom_gfinanciero(str.g_financiero, str.empresa)+"'"
		end if

   	
CASE 'R'	//General Paises
		this.title 		= "Estado de Cuenta por País"
		
		if istr_rangfech.idioma = 'E' then
			dw.DataObject 	= 'dw_cc_inf_est_cuen_x_pais_antig_sql'
		elseif istr_rangfech.idioma = 'I' then
			dw.DataObject 	= 'dw_cc_inf_est_cuen_x_pais_ingles_sql'
		end if
		dw.SetTransObject(Sqlca)
		SetPointer(HourGlass!)


		dw.GetChild("dgmterce_terc_pais",ldwc_pais)
		ldwc_pais.SetTransObject(Sqlca)
		ldwc_pais.Retrieve(str.g_financiero) 
		gf_cc_haydata_dd(ldwc_pais)
		dw.GetChild("dgmterce_terc_region",ldwc_region)
		ldwc_region.SetTransObject(Sqlca)
		ldwc_region.Retrieve(str.g_financiero,str.empresa) 
		gf_cc_haydata_dd(ldwc_region)

      	wf_asignar_antig()
			
		dw.retrieve(str.g_financiero, str.empresa, ld_tiempo1,ld_tiempo2, istr_rangfech.desdecliente,istr_rangfech.hastacliente)

		if istr_rangfech.tipo_orden = 'A' then
			dw.Setsort("dgapais_pais_pais A, dgmterce_terc_descripcion A, cctmovim_movi_fecha_tran A")
			dw.Sort()
		elseif istr_rangfech.tipo_orden = 'C' then
			dw.SetSort("dgapais_pais_pais A, ccmclien_clie_ref_anterior A, cctmovim_mov_fecha_tran A")
			dw.Sort()
		elseif istr_rangfech.tipo_orden = 'N' then
			dw.SetSort("dgapais_pais_pais A, ccmclien_clie_tercero A, cctmovim_movi_tercero A, cctmovim_mov_fecha_tran A")
			dw.Sort()
		end if

		if dw.rowcount() = 0 then
			mensaje('informacion', 'No se Encontraron Registros......','')
		end if

		SetPointer(Arrow!)
		//dw.object.data_window.expression = "'"+"dw_cc_inf_est_cuen_x_pais_sql"+"'"
	END CHOOSE
		
ELSE    //CASE 0//sybase
	
		CHOOSE CASE istr_rangfech.opcion

		CASE 'P' //Por Cliente 
			this.title = "Estado de Cuenta por Clientes"
		
			CHOOSE CASE istr_rangfech.tipo_accion
			CASE '2'	//con movimientos o sin movimientos
				if istr_rangfech.idioma = 'E' then//Idioma Español
					dw.DataObject = 'dw_cc_inf_estcuen_sin_mov'//
				elseif istr_rangfech.idioma = 'I' then//Idioma Inglés
					dw.DataObject = 'dw_cc_inf_estcuen_sin_mov_ingles'//
				end if
		   CASE ELSE
				choose case istr_rangfech.preimpreso
					case 'N'
						choose case istr_rangfech.idioma 
							case  'E' 
								dw.DataObject = 'dw_cc_inf_est_cuen_x_cliente'  //Toma el actual de Gold
								if pos(upper(str.empr_acceso_especial),'RM,') > 0 or pos(upper(str.empr_acceso_especial),'DUNCAN') > 0 or  pos(upper(str.empr_acceso_especial),'FOSTER') > 0 then
									dw.DataObject = 'dw_cc_inf_est_cuen_x_cliente_rm' //para la empresa RM, sin el origen al final
								end if
							case 'I' 
								dw.DataObject = 'dw_cc_inf_estcuen_ingles'
						end choose			
				   CASE ELSE
//						SELECT count(*) into :li_estadoc 
//                  FROM ccaforma 
//						where forma_tipo_formato    = 'EST'
//						   and   forma_formato      = 'ESTAD' 
//						   and   forma_g_financiero = :str.g_financiero
//						   and   forma_empresa      = :str.empresa ;
//						if sqlca.sqlcode = -1 then	
//							ls_db_err = sqlca.sqlerrtext
//							mensaje("Error","Error al contar formato de usuario",ls_db_err)
//							return
//						end if
//                  
//						if li_estadoc > 1 then
//							str_formato.tipo_formato = 'EST'
//							//abrir la ventana
//							OpenwithParm(w_cc_selec_formatos,str_formato)
//	   					str_formato = message.PowerObjectParm
//						
//								if isvalid(str_formato) and Not IsNull(str_formato)  then 
//									if str_formato.aceptar = false then
//										return
//									end if
//									if Isnull(str_formato.datawindow) or trim(str_formato.datawindow) = ''then 
//										mensaje("Atención ","El formato seleccionado es inválido, comuníquese con el personal de soporte técnico o llame a su programador,..gracias !!","")
//										return
//									end if
//								end if
//							
//							
//							dw_1.DataObject = trim(str_formato.datawindow)
//													
//						else
//							select forma_datawindow
//							into :ls_datawindow
//							from ccaforma
//							where forma_tipo_formato = 'EST'
//							and   forma_formato = 'ESTAD' 
//							and   forma_g_financiero = :str.g_financiero
//							and   forma_empresa = :str.empresa ;
//															
//							if sqlca.sqlcode = 0 then
//								dw.DataObject = ls_datawindow
//							elseif sqlca.sqlcode = 100 then
//								messagebox("ATENCION","DEBE AGREGAR EN PARAMETROS-FORMATO EL DATAWINDOW")
//								CLOSE(THIS)
//								RETURN
//							elseif sqlca.sqlcode = -1 then	
//								ls_db_err = sqlca.sqlerrtext
//								mensaje("Error","Error al seleccionar formato de usuario",ls_db_err)
//								RETURN
//							end if
//						end if
					END CHOOSE
		END CHOOSE
		nombre_de_data = dw.dataobject
		dw.SetTransObject(Sqlca)
		SetPointer(HourGlass!)
     
	   //Retrieve a los dropdown--------------------------		
		dw.GetChild("cctmovim_movi_tipo_transaccion",ldwc_sub_tran)
		ldwc_sub_tran.SetTransObject(Sqlca)
		ldwc_sub_tran.Retrieve(str.g_financiero,str.empresa) 
		if ldwc_sub_tran.rowcount() > 0 then
			ldwc_sub_tran.InsertRow(0)
		end if	
		
		dw.GetChild("dgmterce_terc_pais",ldwc_pais)
		ldwc_pais.SetTransObject(Sqlca)
		ldwc_pais.Retrieve(str.g_financiero) 
		gf_cc_haydata_dd(ldwc_pais)
		
		dw.GetChild("dgmterce_terc_region",ldwc_region)
		ldwc_region.SetTransObject(Sqlca)
		ldwc_region.Retrieve(str.g_financiero,str.empresa) 
		gf_cc_haydata_dd(ldwc_region)


   if dw.dataobject = 'dw_cc_inf_est_cuen_x_cliente_preimpreso' then
		dw.GetChild("limite_credito",ldwc_credito)
		ldwc_credito.SetTransObject(Sqlca)
		ldwc_credito.Retrieve(str.g_financiero,str.empresa) 
		gf_cc_haydata_dd(ldwc_credito)

	end if	

		wf_asignar_antig()


		//RETRIEVE
		if istr_rangfech.tipo_accion = '2' then

			dw.retrieve(str.g_financiero,str.empresa,ld_tiempo1,ld_tiempo2, istr_rangfech.desdecliente,istr_rangfech.hastacliente) //,li_emp)
		else
			if istr_rangfech.tipo_orden = 'N' then 				//is_tip_busca = 'S' then
				dw.retrieve(str.g_financiero,str.empresa,ld_tiempo1,ld_tiempo2,istr_rangfech.desdeclienteref,istr_rangfech.hastaclienteref) //,li_emp)
			elseif istr_rangfech.tipo_orden = 'A' then
				dw.retrieve(str.g_financiero,str.empresa,ld_tiempo1,ld_tiempo2,istr_rangfech.nombre1,istr_rangfech.nombre2) //,li_emp)
			elseif istr_rangfech.tipo_orden = 'C' then
				dw.retrieve(str.g_financiero,str.empresa,ld_tiempo1,ld_tiempo2,istr_rangfech.ruccli1,istr_rangfech.ruccli2) //,li_emp)
			end if
		end if

		if istr_rangfech.tipo_accion <> '2' then
			//Filtrar por tipo de cliente
			if istr_rangfech.tip_cliente = 'P' then//Eligio un tipo
				//---Valida cual de los tipos fue elegido----
				if not isnull(istr_rangfech.tipo_cliesp) then li_tipo = 1
				if not isnull(istr_rangfech.tipo_socio)  then li_socio = 1
				if not isnull(istr_rangfech.tipo_auditor) then li_audit = 1
			
				if li_tipo = 1 then	
					dw.Setfilter("ccmclien_clie_clasificacion ="+string(istr_rangfech.tipo_cliesp))
					dw.Filter()	
				elseif li_socio = 1 then
					dw.Setfilter("clie_socio ="+string(istr_rangfech.tipo_socio))
					dw.Filter()	
				elseif li_audit = 1 then
					dw.Setfilter("clie_auditor ="+string(istr_rangfech.tipo_auditor))
					dw.Filter()	
				end if
					
			else//No eligio ningun tipo
				
				if nombre_de_data = "dw_cc_inf_est_cuen_x_cliente" then 
					if is_muestra_nombre = 'N'then//parametro que indica si se desea ver los clientes con saldo cero
						dw.Setfilter("totaliza <> "+string(0.00))
						dw.Filter()
					else
						dw.Setfilter("")
						dw.Filter()
					end if
				else
					dw.setfilter("")
					dw.filter()
				end if	
			end if		//eligio tipo
				
				
		end if//tipo accion <>  2

   	//Mostrar mora
		
		if istr_rangfech.cadena = 'S' and istr_rangfech.preimpreso = 'N'then//Mora en el estado de cuenta
			if messagebox('Atención'+string(dw.dataobject),'Desea Generar el Estado de Cuenta con Mora ?',Question!,YesNo!,2)= 1 then
				dw.object.mora.expression = "'"+'S'+"'"
				//mueve los campos de saldo y mora
				dw.modify("t_14.x=2789")
				dw.modify("t_14.y=1120")				
				dw.modify("t_14.with=229")
				dw.modify("t_14.hight=64")
				
				dw.modify("l_1.x1=2574")
				dw.modify("l_1.y1=0")				
				dw.modify("l_1.x2=3071")
				dw.modify("l_1.y2=0")
				
				dw.modify("t_21.x=3173")
				dw.modify("t_21.y=1120")				
				dw.modify("t_21.with=169")
				dw.modify("t_21.hight=64")
				
				dw.modify("vi_cc_movimientos_movi_saldo.x=2967")
				dw.modify("vi_cc_movimientos_movi_saldo.y=4")				
				dw.modify("vi_cc_movimientos_movi_saldo.with=443")
				dw.modify("vi_cc_movimientos_movi_saldo.hight=60")
				
				dw.modify("ccatpan_tpan_saldo_anterior.x=2587")
				dw.modify("ccatpan_tpan_saldo_anterior.y=0")				
				dw.modify("ccatpan_tpan_saldo_anterior.with=443")
				dw.modify("ccatpan_tpan_saldo_anterior.hight=56")
				
				dw.modify("compute_12.x=2583")
				dw.modify("compute_12.y=4")				
				dw.modify("compute_12.with=443")
				dw.modify("compute_12.hight=56")
				
			else
				dw.object.mora.expression = "'"+'N'+"'"
			end if
		else
			if istr_rangfech.preimpreso = 'N' then
				dw.object.mora.expression  = "'"+'N'+"'"
			end if
		end if



		if dw.rowcount() = 0 then
			mensaje('Informacion', 'No se Encontraron Registros......','')
		end if

	SetPointer(Arrow!)


  	
CASE 'R'	//General Paises
		this.title 		= "Estado de Cuenta por País"
		
		if istr_rangfech.idioma = 'E' then
			dw.DataObject 	= 'dw_cc_inf_est_cuen_x_pais_antig'
		elseif istr_rangfech.idioma = 'I' then
			dw.DataObject 	= 'dw_cc_inf_est_cuen_x_pais_ingles'
		end if
		dw.SetTransObject(Sqlca)
		SetPointer(HourGlass!)


		dw.GetChild("dgmterce_terc_pais",ldwc_pais)
		ldwc_pais.SetTransObject(Sqlca)
		ldwc_pais.Retrieve(str.g_financiero) 
		gf_cc_haydata_dd(ldwc_pais)
		dw.GetChild("dgmterce_terc_region",ldwc_region)
		ldwc_region.SetTransObject(Sqlca)
		ldwc_region.Retrieve(str.g_financiero,str.empresa) 
		gf_cc_haydata_dd(ldwc_region)

      wf_asignar_antig()
		dw.retrieve(str.g_financiero, str.empresa, ld_tiempo1,ld_tiempo2, istr_rangfech.desdecliente,istr_rangfech.hastacliente)

		if dw.rowcount() = 0 then
			mensaje('informacion', 'No se Encontraron Registros......','')
		end if

		SetPointer(Arrow!)
	//	dw.object.data_window.expression = "'"+"dw_cc_inf_est_cuen_x_pais"+"'"
END CHOOSE


END if//CHOOSE///validacion de sql y sybase
dw_4.settransobject(sqlca)
if dw_4.retrieve(istr_rangfech.desdecliente) = 0 then
	dw_4.insertrow(1)
end if

//-----------Controla el tipo de fecha de reporte ---------------
string  ls_transfer,ls_nombre_emp, ls_dir_empre, ls_nempre,ls_dir_e, ls_fecha_a,&
        ls_time_a

ls_nombre_emp = gf_cc_nom_empresa(str.g_financiero,istr_rangfech.desdecliente)
ls_dir_empre  = gf_dg_dir_empresa(str.g_financiero,istr_rangfech.desdecliente)
ls_nempre     = gf_cc_nom_empresa(str.g_financiero,str.empresa)
ls_dir_e      = gf_dg_dir_empresa(str.g_financiero,str.empresa)

CHOOSE CASE istr_rangfech.idioma
	CASE 'E' 
		if istr_rangfech.tipo_fecha = '1' then
			ls_fecha_text = 'Al  '+gf_fecha_palabras_datetime(ld_tiempo2)
		else
			ls_fecha_text = 'Desde '+gf_fecha_palabras_datetime(ld_tiempo1)+'  Hasta '+gf_fecha_palabras_datetime(ld_tiempo2)
		end if
		ls_fecha_a    = 'FECHA :'  + " " +string(gf_fecha_serv(),'dd/mmm/yyyy')
		ls_time_a     = 'HORA :' + " " +string(time(gf_fecha_serv()))	
	CASE 'I' 
		if istr_rangfech.tipo_fecha = '1' then
			ls_fecha_text = gf_fecha_palabras_datetime_ingles(ld_tiempo2 )
		else
			ls_fecha_text = 'Of '+gf_fecha_palabras_datetime_ingles(ld_tiempo1)+' To '+gf_fecha_palabras_datetime_ingles(ld_tiempo2)
		end if
		ls_fecha_a    = 'DATE :'  + " " +string(gf_fecha_serv(),'dd/mmm/yyyy')
		ls_time_a     = 'TIME :' + " " +string(time(gf_fecha_serv()))

//		//--pie-de-pagina---
      ls_transfer = gf_dg_tranferencia_empresa(str.g_financiero,str.empresa)
		if istr_rangfech.piepag = '1' then
			dw.object.pie.expression = "'"+'1'+"'" 
		
		elseif istr_rangfech.piepag = '2' then
			dw.object.transfer.expression = "'"+ls_transfer+"'"
		end if
		
		if istr_rangfech.tipocliente = 'S'then
			dw.object.nombre.expression = "'"+'Agente      :'+"'" 
		else
			dw.object.nombre.expression = "'"+'Cliente     :'+"'"  
		end if
	END CHOOSE
	

if istr_rangfech.opcion = 'G' then
	dw.object.nom_empre.expression = "'"+ls_nombre_emp+"'"
	dw.object.dir_empre.expression = "'"+ls_dir_empre+"'"
	
elseif istr_rangfech.opcion = 'P' then
	if istr_rangfech.tipo_bd > 0 then
		//////
	else
		dw.object.mensaje.expression = "'"+istr_rangfech.mensaje+"'"
		dw.object.otro_mensaje.expression = "'"+istr_rangfech.texto_mensaje+"'"
	end if
	dw.object.nom_empre.expression = "'"+ls_nempre+"'"
	dw.object.dir_empre.expression = "'"+ls_dir_e+"'"
else	
	dw.object.nom_empre.expression = "'"+ls_nempre+"'"
	dw.object.dir_empre.expression = "'"+ls_dir_e+"'"
end if

//controla tipo de descripcion del rango de antiguedad
if istr_rangfech.opcion = 'P' then//Solo por cliente
	if istr_rangfech.tipo_bd > 0 then
		//
	else
		if is_rango_descri = 'N' then
			dw.object.descrip.expression = "'"+'N'+"'"
		else
			dw.object.descrip.expression = "'"+'S'+"'"
		end if
	end if
end if
dw.object.reg.expression = "'"+string(li_registros)+"'"
dw.object.tipo_fecha.expression = "'"+ls_fecha_text+"'"
dw.object.fecha_a.expression = "'"+ls_fecha_a+"'"
dw.object.time_a.expression = "'"+ls_time_a+"'"
wf_control_columna(li_registros)
//Mueve trailer para la antiguedad del dw
if li_registros > 8 then
	dw_1.Modify("DataWindow.Trailer.1.Height=728")
else
	dw_1.Modify("DataWindow.Trailer.1.Height=516")
end if




this.resize(This.width - 8, This.height - 20)

dw.Modify("DataWindow.Print.Preview=true")
//
//if dw.DataObject="dw_cc_inf_est_cuen_x_cliente" then
//	dw.SetFilter("Desplega_cero_sn <> 0")
//	dw.Filter()
//	dw.groupcalc ()
//end if

//**ORDENAMIENTO***
CHOOSE CASE istr_rangfech.opcion
	CASE 'P'
		if istr_rangfech.tipo_orden = 'A' then
			dw.Setsort("dgmterce_terc_descripcion A, vi_cc_movimientos_movi_fecha_tran A, vi_cc_movimientos_movi_fecha_reg A")
			dw.Sort()
		elseif istr_rangfech.tipo_orden = 'C' then
			dw.SetSort("ccmclien_clie_ref_anterior A, vi_cc_movimientos_movi_fecha_tran A, vi_cc_movimientos_movi_fecha_reg A")
			dw.Sort()
		elseif istr_rangfech.tipo_orden = 'N' then
			dw.SetSort("ccmclien_clie_tercero A, vi_cc_movimientos_movi_fecha_tran A, vi_cc_movimientos_movi_fecha_reg A")
			dw.Sort()
		end if
	case 'G'
		if istr_rangfech.tipo_orden = 'A' then
			dw.Setsort("vi_cc_movimientos_movi_empresa A, dgmterce_terc_descripcion A, vi_cc_movimientos_movi_fecha_tran A")
			dw.Sort()
		elseif istr_rangfech.tipo_orden = 'C' then
			dw.SetSort("vi_cc_movimientos_movi_empresa A, ccmclien_clie_ref_anterior A, vi_cc_movimientos_mov_fecha_tran A")
			dw.Sort()
		elseif istr_rangfech.tipo_orden = 'N' then
			dw.SetSort("vi_cc_movimientos_empresa A, ccmclien_clie_tercero A, vi_cc_movimientos_movi_tercero A, vi_cc_movimientos_mov_fecha_tran A")
			dw.Sort()
		end if
	case 'F'
		
		if istr_rangfech.tipo_orden = 'A' then
			dw.Setsort("ccmclien_clie_g_financiero A, dgmterce_terc_descripcion A, vi_cc_movimientos_movi_fecha_tran A")
			dw.Sort()
		elseif istr_rangfech.tipo_orden = 'C' then
			dw.SetSort("ccmclien_clie_g_financiero A, ccmclien_clie_ref_anterior A, vi_cc_movimientos_mov_fecha_tran A")
			dw.Sort()
		elseif istr_rangfech.tipo_orden = 'N' then
			dw.SetSort("ccmclien_clie_g_financiero A, ccmclien_clie_tercero A, vi_cc_movimientos_mov_fecha_tran A")
			dw.Sort()
		end if
	case 'R'
		if istr_rangfech.tipo_orden = 'A' then
			dw.Setsort("dgapais_pais_pais A, dgmterce_terc_descripcion A, cctmovim_movi_fecha_tran A")
			dw.Sort()
		elseif istr_rangfech.tipo_orden = 'C' then
			dw.SetSort("dgapais_pais_pais A, ccmclien_clie_ref_anterior A, cctmovim_mov_fecha_tran A")
			dw.Sort()
		elseif istr_rangfech.tipo_orden = 'N' then
			dw.SetSort("dgapais_pais_pais A, ccmclien_clie_tercero A, cctmovim_movi_tercero A, cctmovim_mov_fecha_tran A")
			dw.Sort()
		end if

end choose
dw.GroupCalc ( )
dw.setfocus()
if dw.rowcount() <= 0 then close(this)
end event

event ue_reg_anterior;//Override
dw.ScrollPriorPage( )
end event

event ue_primer_reg;//Override
dw.scrollNextpage()
end event

event close;
if isvalid(w_estadocuenta_imp) then
	close(w_estadocuenta_imp)
end if
close(this)
setredraw(false)
end event

event open;call super::open;string ls_error
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)

SELECT ccmparam.para_tipo_busqueda,
       ccmparam.para_tipo_descrip_antig_estcta,
	    ccmparam.para_mostrar_nombre_dw//para estados en cero
  INTO :is_tip_busca,
  		 :is_rango_descri,
		 :is_muestra_nombre
	   FROM ccmparam  
   WHERE ( ccmparam.para_g_financiero = :str.g_financiero ) AND  
         ( ccmparam.para_empresa = :str.empresa )   ;
if sqlca.sqldbcode = -1 then
	ls_error = sqlca.sqlerrtext
	Rollback;
	mensaje("Error","Ha ocurrido un error al recuperar el tipo de búsqueda",ls_error)

end if
if isnull(is_tip_busca) then is_tip_busca = ''
end event

event ue_filter;call super::ue_filter;String var
SetNull(var)

// Open The Filter Window
dw.SetFilter(var)

// Execute the filter expresion definida to the user
dw.filter()

dw_1.groupcalc()
end event

event ue_sort;call super::ue_sort;dw_1.groupcalc()
end event

event closequery;call super::closequery;setredraw(false)
end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_estadocuenta_imp
integer x = 2213
integer y = 1480
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_estadocuenta_imp
boolean visible = false
integer x = 37
integer y = 956
integer width = 1280
integer height = 80
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_estadocuenta_imp
integer x = 5
integer y = 8
integer width = 4073
integer height = 1808
integer taborder = 10
string dataobject = "dw_cc_inf_est_cuen_x_cliente"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event dw_1::constructor;this.settransobject(sqlca)
dw=this
this.visible = true
end event

event dw_1::sqlpreview;call super::sqlpreview;String  ls_sql
datetime ld_tiempo1,ld_tiempo2
long     ll_t

ll_t = 99999

ls_sql = sqlsyntax

if istr_rangfech.opcion = 'P'then//por cliente

	CHOOSE CASE istr_rangfech.tipo_orden//is_tip_busca
		CASE  'N'//por cliente
//		  if dw_1.Dataobject = 'dw_cc_inf_estcuen_ingles' or &
//			  dw_1.Dataobject = 'dw_cc_inf_est_cuen_x_cliente'or & 
//			  dw_1.Dataobject = 'dw_cc_inf_est_cuen_x_cliente_sql' then
			  
			ls_sql+=  " AND  " + &
			"  ( ccmclien.clie_ref_anterior >= '"  + istr_rangfech.desdeclienteref + "' ) AND "  + &
			"  ( ccmclien.clie_ref_anterior <= '" + istr_rangfech.hastaclienteref + "' ) AND "  + &
			"  ( vi_cc_movimientos.movi_estado = '"+'IM'+"') and"+&
			"  (ccatpan.tpan_maquina ='"+str.maquina+"')"
				
			//end if
		CASE 'A'
//		if dw_1.Dataobject = 'dw_cc_inf_estcuen_ingles'  or &
//				dw_1.Dataobject = 'dw_cc_inf_est_cuen_x_cliente'or & 
//				dw_1.Dataobject = 'dw_cc_inf_est_cuen_x_cliente_sql'then

				if istr_rangfech.tipo_antig = 'S' then
					ls_sql+=  " AND  " + &
					"  ( rtrim(dgmterce.terc_descripcion) + convert(char(5),dgmterce.terc_tercero) >= "  +"'"+ istr_rangfech.nombre1 +"'"+ " ) AND "  + &
					"  ( rtrim(dgmterce.terc_descripcion) + convert(char(5),dgmterce.terc_tercero) <= " + "'"+istr_rangfech.nombre2 + "'"+") and " + &
					"  ( vi_cc_movimientos.movi_estado = '"+'IM'+"') and "+&
					"  ( vi_cc_movimientos.movi_tran_contado <> '"+'S'+"') and"+&
					"  (ccatpan.tpan_maquina ='"+str.maquina+"')"
				else
					//mensaje('','istr_rangfech.nombre1 :'+istr_rangfech.nombre1 +' istr_rangfech.nombre2: '+istr_rangfech.nombre2,'')
						ls_sql+=  " AND  " + &
					"  ( rtrim(dgmterce.terc_descripcion) + convert(char(5),dgmterce.terc_tercero) >= "  +"'"+ istr_rangfech.nombre1 +"'"+ " ) AND "  + &
					"  ( rtrim(dgmterce.terc_descripcion) + convert(char(5),dgmterce.terc_tercero) <= " + "'"+istr_rangfech.nombre2 + "'"+") and " + &
					"  ( vi_cc_movimientos.movi_estado = '"+'IM'+"') and "+&
					"  ( vi_cc_movimientos.movi_tran_contado <> '"+'S'+"') and "+ &
					"  (ccatpan.tpan_maquina ='"+str.maquina+"')"
				
				end if
			//end if
		CASE 'C'
//			if dw_1.Dataobject = 'dw_cc_inf_estcuen_ingles' or &
//				dw_1.Dataobject = 'dw_cc_inf_est_cuen_x_cliente' or & 
//			   dw_1.Dataobject = 'dw_cc_inf_est_cuen_x_cliente_sql' then
			ls_sql+=  " AND  " + &
			"  ( ccmclien.clie_ruc_tercero >= '"  + istr_rangfech.ruccli1 + "' ) AND "  + &
			"  ( ccmclien.clie_ruc_tercero <= '" + istr_rangfech.ruccli2 + "') and  " + &
			"  ( vi_cc_movimientos.movi_estado = '"+'IM'+"') and"+&
			"  (ccatpan.tpan_maquina ='"+str.maquina+"')"

			//end if
	 CASE  ELSE//Por tercero o por ruc
//		if dw_1.Dataobject = 'dw_cc_inf_estcuen_ingles' or &
//			dw_1.Dataobject = 'dw_cc_inf_est_cuen_x_cliente' or & 
//			dw_1.Dataobject = 'dw_cc_inf_est_cuen_x_cliente_sql' then
			
//			ls_sql+=  " AND  " + &
//			"  ( ccmclien.clie_tercero >= " + string(istr_rangfech.desdecliente) + " ) AND "  + &
//			"  ( ccmclien.clie_tercero <= " + string(istr_rangfech.hastacliente) + " ) AND "  + &
//			"  ( vi_cc_movimientos.movi_estado = '"+'IM'+"') and"+&
//			"  (ccatpan.tpan_maquina ='"+str.maquina+"')"
//				
//			elseif dw_1.DAtaobject = 'dw_cc_inf_est_cuen_x_cliente' then
			
			ls_sql+=  " AND  " + &
			"  ( ccmclien.clie_tercero >= " + string(istr_rangfech.desdecliente) + " ) AND "  + &
			"  ( ccmclien.clie_tercero <= " + string(istr_rangfech.hastacliente) + " ) AND "  + &
			"  ( vi_cc_movimientos.movi_estado = '"+'IM'+"') AND "+&
			"  ( vi_cc_movimientos.movi_tercero <> "+ string(ll_t)+") and"+&
			"  (ccatpan.tpan_maquina ='"+str.maquina+"')"
	//	end if
	
	END CHOOSE



elseif istr_rangfech.opcion = 'R' or istr_rangfech.opcion = 'G' or istr_rangfech.opcion = 'F'then//por pais/empresa y grupo
	ls_sql+=  " AND  " + &
	"  (ccatpan.tpan_maquina ='"+str.maquina+"')"
end if

//mensaje('',ls_sql,'')
This.SetSqlPreview(ls_sql)



end event

event dw_1::printstart;call super::printstart;//

string ls_resp
ls_resp=dw_1.Describe("DataWindow.Syntax")

If dw_1.Describe("t_dw_name.x") <> "?" And dw_1.Describe("t_dw_name.x") <> "!" Then
	if pos(ls_resp,"t_dw_name") > 0 then this.object.t_dw_name.visible=false	
end if
If dw_1.Describe("data_windo.x") <> "?" And dw_1.Describe("data_windo.x") <> "!" Then
	if pos(ls_resp,"data_windo") > 0 then this.object.t_dw_name.visible=false	
end if
If dw_1.Describe("data_window.x") <> "?" And dw_1.Describe("data_window.x") <> "!" Then
	if pos(ls_resp,"data_window") > 0 then this.object.t_dw_name.visible=false	
end if
end event

event dw_1::printend;call super::printend;
string ls_resp
ls_resp=dw_1.Describe("DataWindow.Syntax")

If dw_1.Describe("t_dw_name.x") <> "?" And dw_1.Describe("t_dw_name.x") <> "!" Then
	if pos(ls_resp,"t_dw_name") > 0 then this.object.t_dw_name.visible=true	
end if
If dw_1.Describe("data_windo.x") <> "?" And dw_1.Describe("data_windo.x") <> "!" Then
	if pos(ls_resp,"data_windo") > 0 then this.object.t_dw_name.visible=true
end if
If dw_1.Describe("data_window.x") <> "?" And dw_1.Describe("data_window.x") <> "!" Then
	if pos(ls_resp,"data_window") > 0 then this.object.t_dw_name.visible=true
end if
end event

event dw_1::doubleclicked;call super::doubleclicked;//Llama a la ventana de Pedidos Reservados
String ls_producto, ls_objeto
integer li_pos
long ll_tercero

ls_objeto = dwo.name

if ls_objeto = "vi_cc_movimientos_movi_documento" then
	
	if row = 0 then return
	
	if dw_1.getitemstring(row,'movi_aplicacion') <> 'FA' then return
	
	str_secuencia_doc lstr_sec
	lstr_sec.ano = dw_1.getitemNumber(row,"movi_ann")
	lstr_sec.sec_manual = dw_1.getitemstring(row,"vi_cc_movimientos_movi_documento")
	opensheetwithparm(w_facturas_actualizadas,lstr_sec,str.frame,9,layered!)
end if


end event

event dw_1::clicked;call super::clicked;string ls_column
ls_column = dwo.name
if ls_column = "vi_cc_movimientos_movi_documento" then
	
	if row = 0 then return
	
	str_secuencia_doc lstr_sec
	lstr_sec.ano = dw_1.getitemNumber(row,"movi_ann")
	lstr_sec.sec_manual = dw_1.getitemstring(row,"vi_cc_movimientos_movi_documento")
	lstr_sec.tran	= dw_1.getitemstring(row,"vi_cc_movimientos_movi_tipo_transaccion")
	lstr_sec.subtran	= dw_1.getitemstring(row,"vi_cc_movimientos_movi_sub_transaccion")	
	lstr_sec.aplicacion = dw_1.getitemstring(row,'movi_aplicacion')
	if dw_1.getitemstring(row,'movi_aplicacion') = 'FA' then
		opensheetwithparm(w_facturas_actualizadas,lstr_sec,str.frame,2,original!)
	else
		opensheetwithparm(w_consulta_transacciones, lstr_sec,str.frame,2,original!)
	end if
	
elseif ls_column = 'dgmterce_terc_descripcion' then
	str_cc_formatos str_formato1		
	str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	str_formato1.tercero = dw_1.getitemNumber(1,"ccmclien_clie_tercero")
	OpenSheetwithparm(w_mant_clientes,str_formato1,parent,2, Original!)

end if
end event

event dw_1::ue_microayuda;//override
//Para cuando pasa por encima del objeto
//Override
return
Integer li_pos, li_x, li_y,li_largo
String ls_objeto, ls_col

ls_objeto = This.GetObjectAtPointer()
li_pos = pos  (ls_objeto,"~t")
ls_col = left (ls_objeto, li_pos - 1)

//li_x	 = str.frame.GetActiveSheet ().PointerX () 
//li_largo = len("Haga click para ordenar por la Columna de " + this.describe(ls_col+".text"))*28


//li_y	 = str.frame.GetActiveSheet ().PointerY () - 200

// Dependiendo de la Columna el Mensaje de Ayuda varía
CHOOSE CASE ls_col
	CASE 'dgmterce_terc_descripcion'
		this.Modify("dgmterce_terc_descripcion.Font.Underline='1'")
		this.Modify("dgmterce_terc_descripcion.Color='16711680'")
	CASE 'vi_cc_movimientos_movi_documento'
		this.Modify("vi_cc_movimientos_movi_documento.Font.Underline='1'")
		this.Modify("vi_cc_movimientos_movi_documento.Color='7536640'")
	CASE 'tmov_nombre_tercero'
		this.Modify("tmov_nombre_tercero.Font.Underline='1'")
		this.Modify("tmov_nombre_tercero.Color='7536640'")

	CASE ELSE
		this.Modify("dgmterce_terc_descripcion.Font.Underline='0'")
		this.Modify("dgmterce_terc_descripcion.Color='0'")
		this.Modify("vi_cc_movimientos_movi_documento.Font.Underline='0'")
		this.Modify("vi_cc_movimientos_movi_documento.Color='0'")
//		this.Modify("tmov_nombre_tercero.Font.Underline='0'")
//		this.Modify("tmov_nombre_tercero.Color='0'")

END CHOOSE
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_estadocuenta_imp
integer x = 2117
integer y = 568
integer width = 69
integer height = 84
integer taborder = 20
end type

event gb_1::constructor;this.visible = false
end event

type cb_calcular from commandbutton within w_estadocuenta_imp
boolean visible = false
integer x = 14
integer y = 912
integer width = 891
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Calcular Interes por Morosidad"
end type

event clicked;long ll_cliente
if dw_1.rowcount() = 0 then return
ll_cliente = dw_1.getitemnumber(dw_1.getrow(),'ccmclien_clie_tercero')
if dw_2.retrieve(str.g_financiero, str.empresa, ll_cliente) > 0 then
	if wf_antiguedad() then
		if dw_3.retrieve(str.g_financiero,str.empresa, str.maquina, ll_cliente) > 0 then
			em_monto.text = string(dw_3.getitemnumber(1,'cargo'))
		end if
	end if
end if
end event

type em_monto from editmask within w_estadocuenta_imp
boolean visible = false
integer x = 955
integer y = 916
integer width = 334
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
boolean displayonly = true
string mask = "###,##0.00"
end type

type cb_aplicar from commandbutton within w_estadocuenta_imp
boolean visible = false
integer x = 1344
integer y = 912
integer width = 343
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "APLICAR"
end type

event clicked;integer i, li_ann 
long ll_cliente, ll_secuencia
decimal{2} ld_cargo
string ls_comentario, ls_ruc, ls_error, ls_nombre, ls_secuencia
datetime ldt_fecha, ldt_fechavence


if double(em_monto.text) = 0 then 
	gf_mensaje('','No existe morosidad vencida para el cliente, verifique !!!',1,1,'E')	
	return
end if

if gf_mensaje('','Esta Seguro de Generar el cargo por morosidad ?',2,1,'Q') = 1 then
	sqlca.autocommit = false
	ls_comentario = 'Cargo por morosidad vencida'
	ldt_fecha = datetime(date(gf_fecha_serv()))
	li_ann 	 = year(date(ldt_fecha))
	ldt_fechavence = datetime(relativedate(date(ldt_fecha), 30))
	ls_secuencia = wf_secuencia_tran()	
	
		ll_cliente = dw_3.getitemnumber(1,'clie_tercero')
		ls_ruc	  = dw_3.getitemstring(1,'ccmclien_clie_ref_anterior')
		ld_cargo	  = dw_3.getitemnumber(1,'cargo')				
		ls_nombre  = dw_3.getitemstring(1,'dgmterce_terc_descripcion')
		
		//Inserta en la Tabla CCTMOVIM
		  INSERT INTO cctmovim  
					( movi_g_financiero,   
					  movi_empresa,   
					  movi_aplicacion,   
					  movi_tipo_transaccion,   
					  movi_documento,   
					  movi_anno,			
					  movi_sub_transaccion,   			  
					  movi_tercero,   
					  movi_ruc_tercero,   			  
					  movi_referencia,   
					  movi_naturaleza,   
					  movi_monto,   
					  movi_fecha_tran,   
					  movi_usuario,
					  movi_estado,
					  movi_fecha_vence,
					  movi_comentario,
					  movi_saldo,
					  movi_a_nombre)
		  VALUES ( :str.g_financiero,
					  :str.empresa,   
					  'CC',   
					  'ND',   
					  :ls_secuencia,   
					  :li_ann,	  
					  'IN',			//Intereses
					  :ll_cliente,   
					  :ls_ruc,
					  :ls_secuencia, 			 
					  "D",
					  :ld_cargo,   
					  :ldt_fecha,   
					  :str.usuario,
					  "IM",
					  :ldt_fechavence,
					  :ls_comentario,
					  :ld_cargo,
					  :ls_nombre) ;

				if sqlca.sqlerrtext <> "" then	
					ls_error = sqlca.sqlerrtext
					sqlca.autocommit = true
					rollback ;
					gf_mensaje("Error","Error al Actualizar el Cliente " +ls_error,1,1,'E')	
					return
				end if	
	
				  UPDATE ccmclien  
			     SET clie_fecha_intereses = :ldt_fecha  
					WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
							( ccmclien.clie_empresa = :str.empresa ) AND  
							( ccmclien.clie_tercero = :ll_cliente ) ;
					if sqlca.sqlerrtext <> "" then	
						ls_error = sqlca.sqlerrtext
						sqlca.autocommit = true
						rollback ;
						gf_mensaje("Error","Error al Actualizar fecha en el cliente " +ls_error,1,1,'E')	
						return
					end if					
	
	ll_secuencia = long(ls_secuencia) - 1
	
	  UPDATE dgmserie  
     SET mser_secuencia = :ll_secuencia
   WHERE ( dgmserie.mser_g_financiero = :str.g_financiero ) AND  
         ( dgmserie.mser_empresa = :str.empresa ) AND  
         ( dgmserie.mser_tipo_transaccion = 'ND' ) ;
				if sqlca.sqlerrtext <> "" then	
					ls_error = sqlca.sqlerrtext
					sqlca.autocommit = true
					rollback ;
					gf_mensaje("Error","Error al Actualizar la secuencia " +ls_error,1,1,'E')	
					return
				end if	
	
	commit;
	

else //Si responde no a la pregunta
	return
end if

sqlca.autocommit = true

gf_mensaje('','Generacion Exitosa del Cargo por Morosidad',1,1,'E')	
	
return
end event

type dw_2 from datawindow within w_estadocuenta_imp
boolean visible = false
integer x = 1746
integer y = 920
integer width = 178
integer height = 108
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_clientes_a_generar_est_cuenta"
boolean livescroll = true
end type

type dw_3 from datawindow within w_estadocuenta_imp
boolean visible = false
integer x = 1984
integer y = 920
integer width = 210
integer height = 112
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "dw_clientes_morosos_est_cuenta"
boolean livescroll = true
end type

type dw_4 from datawindow within w_estadocuenta_imp
integer x = 4101
integer y = 24
integer width = 1614
integer height = 352
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_enviar_correo_estado_cuenta"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;this.accepttext()

end event

event buttonclicked;string ls_correo, ls_ruc, ls_tag, ls_fecha
this.accepttext()
ls_correo = dw_4.getitemstring(1,'terc_email')

OLEObject ole_object 
Integer li_rc , li_Ret, li_return
String ls_ruta , ls_raiz
integer li_result, li_FileNum
string ls_path, ls_archivo2, ls_nombre

ls_path = "C:\Sistemas\Comprobantes"
	//	li_result = GetFolder( "Seleccionar Carpeta Destino", ls_path )
		ls_nombre = 'Estado_Cuenta'
		ls_archivo2= ls_path+"\"+ls_nombre+".pdf"
				PrintSetPrinter ("Bullzip PDF Printer")
				dw_1.Object.DataWindow.Printer = "Bullzip PDF Printer" // "Sybase DataWindow PS" //"Adobe DataWindow PS"
				dw_1.Object.DataWindow.Export.PDF.Method = Distill!
				dw_1.Object.DataWindow.Export.PDF.Distill.CustomPostScript="Yes"
				dw_1.Modify("datawindow.Export.PDF.Method = '1'")
//				dw_1.Modify("datawindow.Export.PDF.xslfop.print=no")
				dw_1.print()		

		sleep(7)
		
ls_raiz = 'C:\Sistemas\Comprobantes\comprobante.pdf'
li_FileNum = FileCopy (ls_raiz , ls_archivo2, TRUE)
if li_Filenum <> 1 then
	gf_mensaje('','Error al Copiar ...'+string(li_Filenum),1,1,'E')
	return
end if
filedelete("C:\Sistemas\Comprobantes\comprobante.pdf")

if fileexists(ls_archivo2) then
	
	ls_tag = 'Estado'
	ls_nombre = dw_1.getitemstring(1,'dgmterce_terc_descripcion')
	ls_fecha = string(istr_rangfech.fecha2,'dd/MMM/yyyy')

	if len(ls_correo) = 0 or pos(ls_correo,'@') = 0 then
		gf_mensaje('','Se Requiere un Correo Valido, Verifique !!!',1,1,'E')
		return
	end if
	li_return = wf_send_mail(ls_archivo2, ls_tag, ' - '+ls_nombre + ' al ' +ls_fecha, ls_correo)	
	
end if
end event

