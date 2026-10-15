//objectcomments Ventana de Impresión del Reporte de Ventas x Cliente
forward
global type w_reporte_inventario from w_fa_padre_reportes
end type
type st_sel_marca from statictext within w_reporte_inventario
end type
type ddlb_1 from dropdownlistbox within w_reporte_inventario
end type
type st_1 from statictext within w_reporte_inventario
end type
type dw_2 from datawindow within w_reporte_inventario
end type
type cbx_filtrar from checkbox within w_reporte_inventario
end type
type cbx_sin_grupo from checkbox within w_reporte_inventario
end type
type st_2 from statictext within w_reporte_inventario
end type
type dw_3 from datawindow within w_reporte_inventario
end type
type dw_4 from datawindow within w_reporte_inventario
end type
type cb_catalogo from commandbutton within w_reporte_inventario
end type
type cbx_bulto from checkbox within w_reporte_inventario
end type
type dw_5 from datawindow within w_reporte_inventario
end type
type st_3 from statictext within w_reporte_inventario
end type
type cb_cantidades from commandbutton within w_reporte_inventario
end type
type cbx_letras from checkbox within w_reporte_inventario
end type
type cbx_ver_existencias from checkbox within w_reporte_inventario
end type
type cbx_conteo from checkbox within w_reporte_inventario
end type
type ddlb_conteo from dropdownlistbox within w_reporte_inventario
end type
type st_deposito from statictext within w_reporte_inventario
end type
type cbx_por_fecha from checkbox within w_reporte_inventario
end type
type em_desde from editmask within w_reporte_inventario
end type
type em_hasta from editmask within w_reporte_inventario
end type
type st_4 from statictext within w_reporte_inventario
end type
type cbx_a_una_fecha from checkbox within w_reporte_inventario
end type
type em_fecha from editmask within w_reporte_inventario
end type
type cb_calcular from commandbutton within w_reporte_inventario
end type
type cbx_futuro from checkbox within w_reporte_inventario
end type
type cbx_foto from checkbox within w_reporte_inventario
end type
type cbx_venta from checkbox within w_reporte_inventario
end type
type dw_6 from datawindow within w_reporte_inventario
end type
type dw_7 from datawindow within w_reporte_inventario
end type
type cb_quote from commandbutton within w_reporte_inventario
end type
type cbx_con_fotos from checkbox within w_reporte_inventario
end type
type st_lineas from statictext within w_reporte_inventario
end type
type em_lineas from editmask within w_reporte_inventario
end type
type cbx_ver from checkbox within w_reporte_inventario
end type
type cb_enviar from commandbutton within w_reporte_inventario
end type
type em_correo from editmask within w_reporte_inventario
end type
type st_correo from statictext within w_reporte_inventario
end type
end forward

global type w_reporte_inventario from w_fa_padre_reportes
integer width = 6766
integer height = 2620
string title = "Reporte de Inventarios"
boolean minbox = false
long backcolor = 12639424
st_sel_marca st_sel_marca
ddlb_1 ddlb_1
st_1 st_1
dw_2 dw_2
cbx_filtrar cbx_filtrar
cbx_sin_grupo cbx_sin_grupo
st_2 st_2
dw_3 dw_3
dw_4 dw_4
cb_catalogo cb_catalogo
cbx_bulto cbx_bulto
dw_5 dw_5
st_3 st_3
cb_cantidades cb_cantidades
cbx_letras cbx_letras
cbx_ver_existencias cbx_ver_existencias
cbx_conteo cbx_conteo
ddlb_conteo ddlb_conteo
st_deposito st_deposito
cbx_por_fecha cbx_por_fecha
em_desde em_desde
em_hasta em_hasta
st_4 st_4
cbx_a_una_fecha cbx_a_una_fecha
em_fecha em_fecha
cb_calcular cb_calcular
cbx_futuro cbx_futuro
cbx_foto cbx_foto
cbx_venta cbx_venta
dw_6 dw_6
dw_7 dw_7
cb_quote cb_quote
cbx_con_fotos cbx_con_fotos
st_lineas st_lineas
em_lineas em_lineas
cbx_ver cbx_ver
cb_enviar cb_enviar
em_correo em_correo
st_correo st_correo
end type
global w_reporte_inventario w_reporte_inventario

type variables
str_fa_ventafact str_informe
datawindowchild idwc_grupo, idwc_division, idwc_cliente
date fecha_inicial
n_cst_sys gnv_sys

end variables

forward prototypes
public subroutine wf_inventario_especifico ()
public function boolean wf_crear_proforma (integer ai_ann, string as_proforma, long al_cliente)
public function boolean wf_orden_nueva ()
public function integer wf_send_mail (string as_archivo, string as_tag, string as_titulo, string as_correo)
end prototypes

public subroutine wf_inventario_especifico ();// Modificado por Gianni Araúz (15/01/2000)
// Modificado por Ariel Díaz (19/05/2000)


//////////////// D E C L A R A C I Ó N  D E  V A R I A B L E S ////////

string		ls_producto,proc_error,ls_prod,ls_tipo
decimal		ld_total_final,ld_fraccion, ld_cantidad_total, ld_total_reg,ld_costo,ld_saldo
double		ld_promedio,ld_costo_promed
datetime		dt_anterior,dt_posterior
time			tiempo1=00:00:00, tiempo2=23:59:59
integer		li_contador
long        a,b,ll_ultimo_reg,ll_anterior_reg,ll_anterior_reg1
string      ls_tipo1,ls_tipo2
decimal     ld_calculo1,ld_calculo2,ld_calculo3,ld_calculo4,ld_calculo5,ld_costo1,ld_saldo1
decimal     ld_costo2,ld_saldo2,ld_calculo22,ld_disponible,ld_calculo_fraccion,ld_disponible_total
long        ll_fraccion,ll_cant_medida, ll_formato_decimal 
sqlca.autocommit=false;
/////////////////////////////////////////////////////////////////////

//fecha_inicial = date(str_informe.fecha_periodo)
fecha_inicial    = date(em_fecha.text)

/////////////////////////////////////////////////////////////////////

sqlca.autocommit=true;

dt_anterior=datetime(date("01/01/1980"),tiempo1)
dt_posterior=datetime(fecha_inicial,tiempo2)

//SQLCA.dbParm ="CursorScroll='Dynamic',Cursor='lock'"
// Modificado por Ariel Díaz (19/05/2000)

select para_formato_decimal
  into :ll_formato_decimal
  from inaparam
 where para_g_financiero=:str.g_financiero
   and para_empresa=:str.empresa;

delete  
from inhprome 
 where prom_g_financiero=:str.g_financiero and
       prom_empresa=:str.empresa ;
		 
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Eliminar'+sqlca.sqlerrtext,1,1,'E')
		end if
//       prom_maquina=:str.maquina;
    
				 /*******************************/
				/*Para evaluar el tiempo que se demora el procedimiento*/
				time lt_hora1, lt_hora2
				long ll_segundos
				
				lt_hora1 = time(gf_fecha_Serv())
				/*******************************/
								
				declare sp_in_proc_costo_promedio_p  procedure for sp_in_proc_costo_promedio_real
					@p_gf     =:str.g_financiero,
					@p_emp    =:str.empresa,
					@maquina =:str.maquina,
					@p_fecha_i=:dt_posterior;
					execute sp_in_proc_costo_promedio_p;	
	
					if sqlca.sqlcode = - 1 then
						proc_error=sqlca.sqlErrText
						rollback;
						messagebox("Error!!!","Error al Ejecutar el Procedimiento sp_in_proc_costo_promedio_real:  "+"~r~n"+proc_error)
					end if
					
										
					//*Para medir el tiempo demorado en el procedimiento
//					lt_hora2 	= time(gf_fecha_Serv())
//					ll_segundos = SecondsAfter(lt_hora1, lt_hora2)
//					messagebox('Tiempo Ejec Proc..',string(ll_segundos))
					//*/	
				

end subroutine

public function boolean wf_crear_proforma (integer ai_ann, string as_proforma, long al_cliente);//Crea la proforma
integer i, li_morosidad, li_dias, li_incluir, j, li_existe
string ls_direccion, ls_nombre, ls_cuenta, ls_producto, ls_descripcion, ls_medida, ls_modelo
date ldt_fecha
decimal{2} ld_costo_fob, ld_costo_cif
long ll_cantidad
ldt_fecha = date(gf_fecha_serv())

SELECT dgmterce.terc_descripcion,   
				dgmterce.terc_direccion,   
				ccmclien.clie_ref_anterior,   
				ccmclien.clie_limite_morosidad  
		 INTO :ls_nombre,   
				:ls_direccion,   
				:ls_cuenta,   
				:li_morosidad  
		 FROM ccmclien,   
				dgmterce  
		WHERE ( ccmclien.clie_tercero = dgmterce.terc_tercero ) and  
				( ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
				( ccmclien.clie_empresa = :str.empresa ) AND
				( ccmclien.clie_tercero = :al_cliente))   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al buscar datos del cliente '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return false
			end if

		  SELECT count(*)  
			 INTO :li_existe  
			 FROM fatprofo  
			WHERE ( fatprofo.prof_g_financiero = :str.g_financiero ) AND  
					( fatprofo.prof_empresa = :str.empresa ) AND  
					( fatprofo.prof_no_proforma = :as_proforma ) AND  
					( fatprofo.prof_ann = :ai_ann )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al buscar datos de Proforma '+sqlca.sqlerrtext,1,1,'E')
						rollback;
						sqlca.autocommit = true
						return false
					end if


sqlca.autocommit = false
if li_existe = 0 then	
	  INSERT INTO fatprofo  
         ( prof_g_financiero,   
           prof_empresa,   
           prof_tipo,   
           prof_no_proforma,   
           prof_ann,   
           prof_cliente,   
           prof_ruc_cliente,   
           prof_condicion_pago,   
           prof_tipo_venta,   
           prof_tipo_movimiento,   
           prof_no_traspaso,   
           prof_fecha,   
           prof_fecha_creacion,   
           prof_fecha_modificacion,   
           prof_dias_pago,   
           prof_consignado,   
           prof_a_nombre,   
           prof_a_nombre_direccion,   
           prof_despachado,   
           prof_via,   
           prof_con_emb_no,   
           prof_marca,   
           prof_bultos_total,   
           prof_cubicaje_total,   
           prof_peso_total,   
           prof_unidad_peso,   
           prof_gastos_total,   
           prof_monto_total,   
           prof_descu_subt_deta,   
           prof_por_descuento,   
           prof_supervisor,   
           prof_monto_final,   
           prof_comentario,   
           prof_estado,   
           prof_documento,   
           prof_actualizo_cargos,   
           prof_actualizo_vendedor,   
           prof_factura_de_bodega,   
           prof_fecha_fin_plazo,   
           prof_autorizacion,   
           prof_cuatro_decimales,   
           prof_precio_a_utilizar,   
           prof_costos_total,   
           prof_usuario )  
  VALUES ( :str.g_financiero,   
           :str.empresa,   
           '1',   
           :as_proforma,   
           :ai_ann,   
           :al_cliente,   
           :ls_cuenta,   
           'CR',   
           1,   
           'S',   
           null,   
           :ldt_fecha,   
           getdate(),   
           getdate(),   
           2,   
           null,   
           :ls_nombre,   
           :ls_direccion,   
           null,   
           'MR',   
           null,   
           null,   
           0,   
           0,   
           0,   
           'KG',   
           0,   
           0,   
           'N',   
           0,   
           null,   
           0,   
           null,   
           'A',   
           null,   
           'N',   
           'N',   
           null,   
           null,   
           null,   
           null,   
           null,   
           0,   
           :str.usuario )  ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al insertar proforma '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return false
			end if
j = 0
else	//Si ya existe la proforma
	  SELECT max(dpro_linea)  
		 INTO :j  
		 FROM fadprofo  
		WHERE ( fadprofo.dpro_g_financiero = :str.g_financiero ) AND  
				( fadprofo.dpro_empresa = :str.empresa ) AND  
				( fadprofo.dpro_no_proforma = :as_proforma ) AND  
				( fadprofo.dpro_ann = :ai_ann )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Buscar Linea '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return false
			end if

end if

for i = 1 to dw_1.rowcount()	
	li_incluir = dw_1.getitemnumber(i,'incluir') 
	if li_incluir = 1 then
		j ++
		ls_producto = dw_1.getitemstring(i,'prod_producto')
		ls_descripcion = dw_1.getitemstring(i,'inmprodu_prod_descripcion')
		ls_medida	= dw_1.getitemstring(i,'prod_medida')
		ld_costo_fob	= dw_1.getitemnumber(i,'prod_costo_fob')
		ld_costo_cif	= dw_1.getitemnumber(i,'prod_costo_cif')
		ls_modelo	= dw_1.getitemstring(i,'inmprodu_prod_producto_dos')
		ll_cantidad	= dw_7.getitemnumber(1,'cantidad')
		INSERT INTO fadprofo  
         ( dpro_g_financiero,   
           dpro_empresa,   
           dpro_no_proforma,   
           dpro_ann,   
           dpro_linea,   
           dpro_producto_servicio,   
           dpro_codigo_item,   
           dpro_descripcion_alterna,   
           dpro_cubucaje,   
           dpro_peso,   
           dpro_unidad_peso,   
           dpro_unidad_producto,   
           dpro_precio_mayor,   
           dpro_precio_menor,   
           dpro_bodega,   
           dpro_costo_fob,   
           dpro_costo_cif,   
           dpro_precio_unidad_producto,   
           dpro_unidad_venta,   
           dpro_cantidad,   
           dpro_fraccion,   
           dpro_monto_total,   
           dpro_por_descuento,   
           dpro_monto_final,   
           dpro_fecha_reg,   
           dpro_usuario,   
           dpro_supervisor,   
           dpro_bultos,   
           dpro_ubicacion,   
           dpro_pasada,   
           dpro_index,   
           dpro_validado,   
           dpro_bulto_inicio,   
           dpro_bulto_fin,   
           dpro_precio_original,   
           dpro_costo_total,   
           dpro_ped_futuro,   
           dpro_ann_futuro,   
           dpro_bultos_cambiados,   
           dpro_peso_cambiado,   
           dpro_cubicaje_cambiado,   
           dpro_precio_descuento,   
           dpro_cubicaje_metros,   
           dpro_peso_neto,   
           dpro_comentario,   
           dpro_bultos_original,   
           dpro_modelo )  
  VALUES ( :str.g_financiero,   
           :str.empresa,   
           :as_proforma,   
           :ai_ann,   
           :j,   
           'P',   
           :ls_producto,   
           :ls_descripcion,   
           0,   
           0,   
           'KG',   
           :ls_medida,   
           0,   
           0,   
           '1',   
           :ld_costo_fob,   
           :ld_costo_cif,   
           0,   
           :ls_medida,   
           :ll_cantidad,   
           0,   
           0,   
           0,   
           0,   
           getdate(),   
           :str.usuario,   
           null,   
           0,   
           '1',   
           0,   
           :j,   
           0,   
           0,   
           0,   
           0,   
           0,   
           null,   
           null,   
           0,   
           0,   
           0,   
           0,   
           0,   
           0,   
           null,   
           null,   
           :ls_modelo )  ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al insertar proforma '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return false
			end if

		
	end if
next

commit;
sqlca.autocommit = true

return true
end function

public function boolean wf_orden_nueva ();long ll_max
integer li_ann

li_ann = dw_7.getitemnumber(1,'ann')

select max(convert(numeric(10), prof_no_proforma ))
into	:ll_max
from fatprofo
where prof_g_financiero = :str.g_financiero and
		prof_empresa		= :str.empresa and
		prof_ann				= :li_ann and
		prof_pdt = 0 ;
	if sqlca.sqlcode = -1  then
		gf_mensaje('','Error al Buscar Secuencia '+sqlca.sqlerrtext,1,1,'E')		
		return false
	end if
	
	if isnull(ll_max) then ll_max = 0
	
	ll_max ++
	
	dw_7.setitem(1,'proforma',string(ll_max))
	
return true
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

on w_reporte_inventario.create
int iCurrent
call super::create
this.st_sel_marca=create st_sel_marca
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.dw_2=create dw_2
this.cbx_filtrar=create cbx_filtrar
this.cbx_sin_grupo=create cbx_sin_grupo
this.st_2=create st_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.cb_catalogo=create cb_catalogo
this.cbx_bulto=create cbx_bulto
this.dw_5=create dw_5
this.st_3=create st_3
this.cb_cantidades=create cb_cantidades
this.cbx_letras=create cbx_letras
this.cbx_ver_existencias=create cbx_ver_existencias
this.cbx_conteo=create cbx_conteo
this.ddlb_conteo=create ddlb_conteo
this.st_deposito=create st_deposito
this.cbx_por_fecha=create cbx_por_fecha
this.em_desde=create em_desde
this.em_hasta=create em_hasta
this.st_4=create st_4
this.cbx_a_una_fecha=create cbx_a_una_fecha
this.em_fecha=create em_fecha
this.cb_calcular=create cb_calcular
this.cbx_futuro=create cbx_futuro
this.cbx_foto=create cbx_foto
this.cbx_venta=create cbx_venta
this.dw_6=create dw_6
this.dw_7=create dw_7
this.cb_quote=create cb_quote
this.cbx_con_fotos=create cbx_con_fotos
this.st_lineas=create st_lineas
this.em_lineas=create em_lineas
this.cbx_ver=create cbx_ver
this.cb_enviar=create cb_enviar
this.em_correo=create em_correo
this.st_correo=create st_correo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_sel_marca
this.Control[iCurrent+2]=this.ddlb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cbx_filtrar
this.Control[iCurrent+6]=this.cbx_sin_grupo
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.dw_4
this.Control[iCurrent+10]=this.cb_catalogo
this.Control[iCurrent+11]=this.cbx_bulto
this.Control[iCurrent+12]=this.dw_5
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.cb_cantidades
this.Control[iCurrent+15]=this.cbx_letras
this.Control[iCurrent+16]=this.cbx_ver_existencias
this.Control[iCurrent+17]=this.cbx_conteo
this.Control[iCurrent+18]=this.ddlb_conteo
this.Control[iCurrent+19]=this.st_deposito
this.Control[iCurrent+20]=this.cbx_por_fecha
this.Control[iCurrent+21]=this.em_desde
this.Control[iCurrent+22]=this.em_hasta
this.Control[iCurrent+23]=this.st_4
this.Control[iCurrent+24]=this.cbx_a_una_fecha
this.Control[iCurrent+25]=this.em_fecha
this.Control[iCurrent+26]=this.cb_calcular
this.Control[iCurrent+27]=this.cbx_futuro
this.Control[iCurrent+28]=this.cbx_foto
this.Control[iCurrent+29]=this.cbx_venta
this.Control[iCurrent+30]=this.dw_6
this.Control[iCurrent+31]=this.dw_7
this.Control[iCurrent+32]=this.cb_quote
this.Control[iCurrent+33]=this.cbx_con_fotos
this.Control[iCurrent+34]=this.st_lineas
this.Control[iCurrent+35]=this.em_lineas
this.Control[iCurrent+36]=this.cbx_ver
this.Control[iCurrent+37]=this.cb_enviar
this.Control[iCurrent+38]=this.em_correo
this.Control[iCurrent+39]=this.st_correo
end on

on w_reporte_inventario.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_sel_marca)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.cbx_filtrar)
destroy(this.cbx_sin_grupo)
destroy(this.st_2)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.cb_catalogo)
destroy(this.cbx_bulto)
destroy(this.dw_5)
destroy(this.st_3)
destroy(this.cb_cantidades)
destroy(this.cbx_letras)
destroy(this.cbx_ver_existencias)
destroy(this.cbx_conteo)
destroy(this.ddlb_conteo)
destroy(this.st_deposito)
destroy(this.cbx_por_fecha)
destroy(this.em_desde)
destroy(this.em_hasta)
destroy(this.st_4)
destroy(this.cbx_a_una_fecha)
destroy(this.em_fecha)
destroy(this.cb_calcular)
destroy(this.cbx_futuro)
destroy(this.cbx_foto)
destroy(this.cbx_venta)
destroy(this.dw_6)
destroy(this.dw_7)
destroy(this.cb_quote)
destroy(this.cbx_con_fotos)
destroy(this.st_lineas)
destroy(this.em_lineas)
destroy(this.cbx_ver)
destroy(this.cb_enviar)
destroy(this.em_correo)
destroy(this.st_correo)
end on

event ue_post_open;//Override
dw_1.settransobject(sqlca)
dw_5.settransobject(sqlca)
dw_5.insertrow(1)

dw_7.getchild('cliente',idwc_cliente)
idwc_cliente.settransobject(sqlca)
idwc_cliente.retrieve(str.g_financiero, str.empresa)

//Para setear el nombre de la Cia. al DW de impresion.
If dw_1.Describe("nom_empresa.x") <> "?" And dw_1.Describe("nom_empresa.x") <> "!" Then
	dw_1.object.nom_empresa.expression = "'"+ gf_dg_nombre_empresa() +"'"
End If	

if dw_1.retrieve(str.g_financiero, str.empresa) > 0 then
	if cbx_filtrar.checked then
		if not cbx_futuro.checked then
			dw_1.setfilter('prod_existencia_total > 0')
		else
			dw_1.setfilter('orden_compra > 0')
		end if
	else
		dw_1.setfilter('')
	end if
	dw_1.filter()
	
	dw_1.Modify ("DataWindow.Header.1.Height = 0")
	dw_1.Modify ("DataWindow.Header.2.Height = 0")
	dw_1.Modify ("DataWindow.Trailer.1.Height = 0")
	dw_1.Modify ("DataWindow.Trailer.2.Height = 0")	
	dw_1.setsort('inmprodu_prod_descripcion')
	dw_1.sort()
	dw_1.groupcalc()
end if
ddlb_conteo.text = '1'

em_desde.text = string(relativedate(date(gf_fecha_serv()), -30))
em_hasta.text = string(date(gf_fecha_serv()))
em_fecha.text = string(date(gf_fecha_serv()))

//Setea el Nombre de la Ventana
//
//dw_1.object.datawindow.print.preview = True
//dw_1.object.datawindow.print.preview.zoom = 100




end event

event resize;//Override
this.SetRedraw(false)
dw_1.width  = this.width  - 130
dw_1.height = this.height - 545
gb_1.width  = this.width  - 63
gb_1.height = this.height - 490
cbx_filtrar.y = newheight - 200
cbx_bulto.y = newheight - 90
cbx_sin_grupo.y = newheight - 200
cb_catalogo.y = newheight - 110
cb_quote.y = newheight - 218
cb_cantidades.y = newheight - 110
st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180

cbx_por_fecha.y 	=  newheight - 320
em_desde.y 	=  newheight - 330
em_hasta.y 	=  newheight - 330
st_4.y 	=  newheight - 320

ddlb_1.y = this.height - 200
ddlb_1.X = (this.width - 70) - ddlb_1.width 

st_sel_marca.y = this.height - 200
st_sel_marca.X = (this.width - 70) - ddlb_1.width - st_sel_marca.width -100

dw_3.y 	=  newheight - 220
dw_2.y 	=  newheight - 120
dw_5.y 	=  newheight - 120
st_1.y 	=  newheight - 190
st_2.y 	=  newheight - 85
st_3.y 	=  newheight - 85
cbx_ver_existencias.y  =  newheight - 200
cbx_letras.y  =  newheight - 200
cbx_futuro.y  =  newheight - 305
cbx_venta.y  =  newheight - 305
cbx_foto.y  =  newheight - 305
cbx_conteo.y =  newheight - 200
cbx_con_fotos.y =  newheight - 200
cb_enviar.y =  newheight - 205
ddlb_conteo.y = newheight - 95
st_deposito.y = newheight - 90
em_correo.y = newheight - 94
st_correo.y = newheight - 88

cbx_a_una_fecha.y 	=  newheight - 320
em_fecha.y 	=  newheight - 330
cb_calcular.y 	=  newheight - 330

em_lineas.y  =  newheight - 305
cbx_ver.y = newheight - 305
st_lineas.y = newheight - 305


this.SetRedraw(true)

end event

event open;call super::open;//str_informe = Message.PowerObjectParm
//this.y = 0
//this.x = 805
gnv_sys = Create n_cst_sys
if pos(upper(str.empr_acceso_especial),'ADVANCED') > 0 then
	dw_1.dataobject = 'dw_reporte_inventario_estandar'
elseif pos(upper(str.empr_acceso_especial),'DUNCAN') > 0  then
	dw_1.dataobject = 'dw_reporte_inventario_duncan'
else
	dw_1.dataobject = 'dw_reporte_inventario'
end if
dw_2.settransobject(sqlca)
dw_2.getchild('grupo', idwc_grupo)
idwc_grupo.settransobject(sqlca)
idwc_grupo.retrieve(str.g_financiero, str.empresa)
idwc_grupo.insertrow(1)

dw_6.settransobject(sqlca)

dw_3.settransobject(sqlca)
dw_3.getchild('division', idwc_division)
idwc_division.settransobject(sqlca)
idwc_division.retrieve(str.g_financiero, str.empresa)
idwc_division.insertrow(1)

dw_4.settransobject(sqlca)
dw_1.sharedata(dw_4)
dw_4.object.empresa_nom.expression = "'"+str.nombre_empresa+"'"
//dw_4.Object.datawindow.print.preview = true

dw_2.insertrow(1)
dw_3.insertrow(1)
end event

event ue_print;//override
//dw.Object.datawindow.print.preview = true
dw_2.accepttext()
dw_5.accepttext()
dw_1.accepttext()
string ls_cadena, ls_desc, ls_division, ls_descrip, ls_and, ls_cadena_temp
ls_desc = idwc_grupo.getitemstring(idwc_grupo.getrow(),'agru_descripcion_grupo')
ls_division = idwc_division.getitemstring(idwc_division.getrow(),'adiv_nombre_div')
ls_descrip = dw_5.getitemstring(1,'descripcion')
ls_cadena = ''
ls_and = ''

if dw_6.visible  = true then
	OpenWithParm(w_dw_print_options, dw_6)
	If Message.DoubleParm = -1 Then
		Return
	end if
	dw_6.Print(True)
	return
end if

if dw_4.visible  = true then
	dw_4.Object.datawindow.print.preview = true
	dw_4.object.nom_empresa.expression = "'"+str.nombre_empresa+"'"
	OpenWithParm(w_dw_print_options, dw_4)
	If Message.DoubleParm = -1 Then
		Return
	end if
	dw_4.Print(True)
	return
end if	
	
if len(ls_descrip) > 0 then 
	ls_cadena = 'left(upper(inmprodu_prod_descripcion),'+ string(len(ls_descrip))+ ') = "'+upper(ls_descrip)+'"'
	ls_and = ' and '
end if

if cbx_bulto.checked then		
		ls_cadena = ls_cadena + ls_and + 'entero > prod_empaque'
		if ls_desc <> '' and not isnull(ls_desc) then
				ls_cadena = ls_cadena + " and cragrupo_agru_descripcion_grupo ='"+ls_desc+"'"
		end if
		if ls_division <> '' and not isnull(ls_division) then
			ls_cadena = ls_cadena + " and cradivis_adiv_nombre_div ='"+ls_division+"'"
		end if
else
		if cbx_filtrar.checked then
			if not cbx_futuro.checked then
				ls_cadena = ls_cadena + ls_and + 'prod_existencia_total > 0'
			else
				ls_cadena = ls_cadena + ls_and + 'orden_compra > 0'
			end if
		end if
		if ls_desc <> '' and not isnull(ls_desc) then
				ls_cadena = ls_cadena + " and cragrupo_agru_descripcion_grupo ='"+ls_desc+"'"
		end if
		if ls_division <> '' and not isnull(ls_division) then
			ls_cadena = ls_cadena + " and cradivis_adiv_nombre_div ='"+ls_division+"'"
		end if
end if

ls_cadena_temp = ls_cadena
if len(ls_cadena) > 0 then
	ls_cadena = ls_cadena + ' and incluir = 1'
else
	ls_cadena = 'incluir = 1'
end if

if dw_1.dataobject <> 'dw_reporte_conteo_fisico' then
	dw_1.setfilter(ls_cadena)
	dw_1.filter()
	dw_1.groupcalc()
	if dw_1.rowcount() = 0 then
		dw_1.setfilter(ls_cadena_temp)
		dw_1.filter()	
		gf_mensaje('','Debe Seleccionar los Registros a Imprimir, Verifique !!!',1,1,'E')
		return
	end if
end if
dw.Object.datawindow.print.preview = true
OpenWithParm(w_dw_print_options, dw)
If Message.DoubleParm = -1 Then
	dw.Object.datawindow.print.preview = false
	if dw_1.dataobject <> 'dw_reporte_conteo_fisico' then
		dw_1.setfilter(ls_cadena_temp)
		dw_1.filter()
		dw_1.groupcalc()	
	end if
	Return
end if
dw.Print(True)
dw.Object.datawindow.print.preview = false
if dw_1.dataobject <> 'dw_reporte_conteo_fisico' then
	dw_1.setfilter(ls_cadena_temp)
	dw_1.filter()
	dw_1.groupcalc()
end if

end event

event activate;call super::activate;idwc_cliente.retrieve(str.g_financiero, str.empresa)
end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_reporte_inventario
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_reporte_inventario
boolean visible = false
integer x = 32
integer y = 1384
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_reporte_inventario
integer x = 41
integer y = 40
integer width = 4841
integer height = 2044
string dataobject = "dw_reporte_inventario"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::doubleclicked;call super::doubleclicked;string         ls_pointer
long           li_fila
datetime       ldt_fecha1
window		   lw_child
str_rangofecha	str_rangofecha_opcion
str_fa_bus_var str_busqueda

//If pos(upper(str.nombre_empresa),'ELECTROVISION') > 0 Then 
if w_fa_fondo.str_aplica_links.habilita_links = 1	then
	ls_pointer = dw_1.GetObjectAtPointer()
	li_fila = integer(trim(mid(ls_pointer,7)))
	if pos(ls_pointer,'numero') > 0 then 
		str_rangofecha_opcion.opcion = 'Kardex'
		str_rangofecha_opcion.orden = dw_1.getitemstring(li_fila,'fact_no_factura')
		if w_fa_fondo.str_aplica_links.factura_activa_fa = 'A' then
			OpenSheetWithParm(lw_child,str_rangofecha_opcion,"w_fa_co_facturas_cab_det_99_e",str.frame,11,Original!)
		end if
	else
		if pos(ls_pointer,'nomcli') > 0 then 
			str_rangofecha_opcion.opcion = 'Kardex'
			str_rangofecha_opcion.cliente = dw_1.getitemnumber(li_fila,'terc_tercero')
//			ldt_fecha1 = dw_1.getitemdatetime(li_fila,'fact_fecha')
			str_rangofecha_opcion.fecha1 = date('01/01/1990')
			if w_fa_fondo.str_aplica_links.cxc_activa_cc = 'A' then
				OpenSheetWithParm(lw_child,str_rangofecha_opcion,"w_fa_co_mov_cliente_saldo",str.frame,11,Original!)
			end if
		end if
	end if
end if 

//	dw_3.Object.dmov_secuencia.Pointer = 'Cross!'

end event

event dw_1::ue_microayuda;//override
//override
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
	CASE 'prod_producto'
		this.Modify("prod_producto.Font.Underline='1'")
		this.Modify("prod_producto.Color='16711680'")				
	CASE ELSE
		this.Modify("prod_producto.Font.Underline='0'")
		this.Modify("prod_producto.Color='0'")
END CHOOSE
end event

event dw_1::clicked;//override
string ls_column
ls_column = dwo.name
if ls_column = 'incluir_t' then
	string ls_descrip, ls_sexo, ls_temp
	integer i, li_marcar
	this.accepttext()
	if dwo.name = 'incluir_t' then
		if this.rowcount() = 0 then return
		li_marcar = this.getitemnumber(1,'incluir')
		if li_marcar = 1 then
			li_marcar = 0
		else
			li_marcar = 1
		end if
		for i = 1 to this.rowcount()
			this.setitem(i,'incluir',li_marcar)
		next
	end if
elseif ls_column = "prod_producto" then
	
	if row = 0 then return
	
		Window lw_child_v				
		string ls_producto
		str_kardex  str_opcion
		
			str_opcion.opcion_menu = 'MCP'
			str_opcion.opcion_ventana    = 'P'
			str_opcion.dwpantalla     = 'dw_in_mcp_prod_kard_1'
			str_opcion.dwreporte      = 'dw_in_mcp_prod_kard_2'
			str_opcion.titulo_ventana = 'Movimientos de Productos (Kardex)'
			
			if dw_1.rowcount() > 0 then
				ls_producto = dw_1.getitemstring(row,'prod_producto')				
			end if
			
			str_opcion.kproducto=ls_producto
			OpenSheetWithParm(lw_child_v,ls_producto,"w_fa_co_consulta_existencia",str.frame,2,Original!)		
			//OpenSheetWithParm(lw_child_v,str_opcion,"w_in_movi_prod_kardex",str.frame,2,Original!)		
	
else
string ls_objeto
integer li_pos 

this.Setredraw(false)

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if right(ls_objeto,2)='_t' then

	ls_objeto = left(ls_objeto,len(ls_objeto)-2)
	
	if ls_objeto = is_ultima_ or is_ultima_ = "" then	//Si es la misma columna 
																	// o si es la primera vez
		if is_orden_  = "" or is_orden_ = "D" then
			is_orden_ = 'A'		
			this.SetSort(ls_objeto+" A")	//Ordena Ascendente
			this.sort()		
		else
			is_orden_ = 'D'					
			this.SetSort(ls_objeto+" D")	//Ordena Descendente
			this.sort()				
		end if	
		is_ultima_ = ls_objeto		
	else				
			is_orden_ = 'A'
			this.SetSort(ls_objeto+" A")
			this.sort()
			is_ultima_ = ls_objeto
	end if

end if

this.Setredraw(true)
end if


end event

event dw_1::buttonclicked;call super::buttonclicked;string ls_descrip, ls_sexo, ls_temp
integer i, li_marcar
this.accepttext()
if dwo.name = 'b_marcar' then
	if this.rowcount() = 0 then return
	li_marcar = this.getitemnumber(1,'incluir')
	if li_marcar = 1 then
		li_marcar = 0
	else
		li_marcar = 1
	end if
	for i = 1 to this.rowcount()
		this.setitem(i,'incluir',li_marcar)
	next
end if
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_reporte_inventario
integer x = 27
integer y = 0
integer width = 4887
integer height = 1364
long backcolor = 12639424
end type

type st_sel_marca from statictext within w_reporte_inventario
boolean visible = false
integer x = 1541
integer y = 1408
integer width = 640
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleccione la Marca"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_reporte_inventario
boolean visible = false
integer x = 2240
integer y = 1388
integer width = 754
integer height = 244
integer taborder = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
boolean vscrollbar = true
string item[] = {"NATURAL EXCHANGE","PUNTOCOM","TODAS"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String	ls_filtro
ls_filtro = 'PC'

if index = 1 then	//NATURAL
	dw_1.setFilter("fact_ruc_cliente not like '" +ls_filtro+ "%'")
	dw_1.filter()
	dw_1.groupcalc()
elseIf index = 2 then //PUNTO COM
	dw_1.setFilter( "fact_ruc_cliente like '" +ls_filtro+ "%'")
	dw_1.filter()
	dw_1.groupcalc()
elseIf index = 3 then //TOTAL
	ls_filtro = 'XX'
	dw_1.setFilter( "fact_ruc_cliente not like '" +ls_filtro+ "%'")
	dw_1.filter()
	dw_1.groupcalc()
end if

end event

type st_1 from statictext within w_reporte_inventario
integer x = 32
integer y = 2220
integer width = 517
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Filtrar por Division:"
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_reporte_inventario
integer x = 544
integer y = 2316
integer width = 1019
integer height = 104
integer taborder = 61
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "dw_external_grupo"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;this.accepttext()
string ls_cadena, ls_desc, ls_division
ls_desc = idwc_grupo.getitemstring(idwc_grupo.getrow(),'agru_descripcion_grupo')
ls_division = idwc_division.getitemstring(idwc_division.getrow(),'adiv_nombre_div')

if ls_desc = '' or isnull(ls_desc) then
	if cbx_filtrar.checked then
		ls_cadena = 'prod_existencia_total > 0'
	else
		ls_cadena = ''
	end if
else
	if cbx_filtrar.checked then
		ls_cadena = "cragrupo_agru_descripcion_grupo ='"+ls_desc+"' and prod_existencia_total > 0"
	else
		ls_cadena = "cragrupo_agru_descripcion_grupo ='"+ls_desc+"'"
	end if
end if

ls_cadena = ls_cadena + " and cradivis_adiv_nombre_div ='"+ls_division+"'"

dw_1.setfilter(ls_cadena)
dw_1.filter()

end event

event itemfocuschanged;//override
string ls_filtro
integer li_rtn

accepttext()

//Se filtran los grupo por la división seleccionada
ls_filtro = dw_3.GetItemString(row,"division")
idwc_grupo.SetFilter("agru_codigo_div = '" + ls_filtro + "'")	
li_rtn = idwc_grupo.Filter()

end event

event clicked;//override
string ls_filtro
integer li_rtn

accepttext()

//Se filtran los grupo por la división seleccionada
ls_filtro = dw_3.GetItemString(row,"division")
idwc_grupo.SetFilter("agru_codigo_div = '" + ls_filtro + "'")	
li_rtn = idwc_grupo.Filter()

end event

type cbx_filtrar from checkbox within w_reporte_inventario
integer x = 1614
integer y = 2224
integer width = 951
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Sólo Productos con Existencias"
boolean checked = true
end type

event clicked;if this.checked then
	if not cbx_a_una_fecha.checked then	dw_1.setfilter('prod_existencia_total > 0')
else
	dw_1.setfilter('')
end if

dw_1.filter()
dw_1.groupcalc()
end event

type cbx_sin_grupo from checkbox within w_reporte_inventario
integer x = 2592
integer y = 2220
integer width = 599
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Listado sin Grupos"
boolean checked = true
end type

event clicked;if this.checked then
   dw_1.Modify ("DataWindow.Header.1.Height = 0")
   dw_1.Modify ("DataWindow.Header.2.Height = 0")
 	dw_1.Modify ("DataWindow.Trailer.1.Height = 0")
  	dw_1.Modify ("DataWindow.Trailer.2.Height = 0")	
   dw_1.setsort('inmprodu_prod_descripcion')
else
   dw_1.Modify ("DataWindow.Header.1.Height = 88")
   dw_1.Modify ("DataWindow.Header.2.Height = 100")
 	dw_1.Modify ("DataWindow.Trailer.1.Height = 88")
  	dw_1.Modify ("DataWindow.Trailer.2.Height = 104")		
   dw_1.setsort('cradivis_adiv_nombre_div, cragrupo_agru_descripcion_grupo, inmprodu_prod_descripcion')
end if
dw_1.sort()
dw_1.groupcalc()
end event

type st_2 from statictext within w_reporte_inventario
integer x = 73
integer y = 2332
integer width = 462
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Filtrar por Grupo:"
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_reporte_inventario
integer x = 544
integer y = 2204
integer width = 1019
integer height = 104
integer taborder = 71
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_division"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;this.accepttext()
string ls_desc
ls_desc = idwc_division.getitemstring(idwc_division.getrow(),'adiv_nombre_div')
if ls_desc = '' or isnull(ls_desc) then
	if cbx_filtrar.checked then
		dw_1.setfilter('prod_existencia_total > 0')
	else
		dw_1.setfilter("")
	end if
	dw_2.enabled = false
else
	if cbx_filtrar.checked then
		dw_1.setfilter("cradivis_adiv_nombre_div ='"+ls_desc+"' and prod_existencia_total > 0")
	else	
		dw_1.setfilter("cradivis_adiv_nombre_div ='"+ls_desc+"'")
	end if
	dw_2.enabled = true
end if
dw_1.filter()
dw_2.setitem(1,'grupo','')

end event

type dw_4 from datawindow within w_reporte_inventario
boolean visible = false
integer x = 315
integer y = 24
integer width = 4229
integer height = 2308
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Impresion de Catalogo"
string dataobject = "dw_reporte_inventario_catalogo"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event clicked;if dwo.name = "prod_producto" then
	string ls_producto
	window lw_child_v
	if row = 0 then return
			
			if dw_4.rowcount() > 0 then
				ls_producto = dw_4.getitemstring(row,'prod_producto')				
			end if
			
			OpenSheetWithParm(lw_child_v,ls_producto,"w_fa_co_consulta_existencia",str.frame,2,Original!)		
end if
end event

type cb_catalogo from commandbutton within w_reporte_inventario
integer x = 3291
integer y = 2208
integer width = 402
integer height = 104
integer taborder = 81
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Catalogo"
end type

event clicked;//override
//dw.Object.datawindow.print.preview = true
long i, ll_total
cbx_ver_existencias.visible = true
dw_2.accepttext()
dw_5.accepttext()
dw_1.accepttext()
string ls_cadena, ls_desc, ls_division, ls_descrip, ls_and, ls_cadena_temp, ls_producto, ls_foto
date ldt_Desde, ldt_hasta
ls_desc = idwc_grupo.getitemstring(idwc_grupo.getrow(),'agru_descripcion_grupo')
ls_division = idwc_division.getitemstring(idwc_division.getrow(),'adiv_nombre_div')
ls_descrip = dw_5.getitemstring(1,'descripcion')
ls_cadena = ''
ls_and = ''
	
if len(ls_descrip) > 0 then 
	ls_cadena = 'left(upper(inmprodu_prod_descripcion),'+ string(len(ls_descrip))+ ') = "'+upper(ls_descrip)+'"'
	ls_and = ' and '
end if
if cbx_por_fecha.checked then
	ldt_desde = date(em_desde.text)
	ldt_hasta  = date(em_hasta.text)
	ls_cadena = ls_cadena + ls_and + 'date( prod_entrada_fecha ) >= date("'+string(ldt_desde)+'") and date( prod_entrada_fecha ) <= date("'+string(ldt_hasta)+'")'
	ls_and = ' and '	
end if
if cbx_bulto.checked then		
		ls_cadena = ls_cadena + ls_and + 'entero > prod_empaque'
		if ls_desc <> '' and not isnull(ls_desc) then
				ls_cadena = ls_cadena + " and cragrupo_agru_descripcion_grupo ='"+ls_desc+"'"
		end if
		if ls_division <> '' and not isnull(ls_division) then
			ls_cadena = ls_cadena + " and cradivis_adiv_nombre_div ='"+ls_division+"'"
		end if
else
		if cbx_filtrar.checked then
			ls_cadena = ls_cadena + ls_and + 'disponible > 0'
		end if
		if ls_desc <> '' and not isnull(ls_desc) then
				ls_cadena = ls_cadena + " and cragrupo_agru_descripcion_grupo ='"+ls_desc+"'"
		end if
		if ls_division <> '' and not isnull(ls_division) then
			ls_cadena = ls_cadena + " and cradivis_adiv_nombre_div ='"+ls_division+"'"
		end if
end if

if cbx_con_fotos.checked then
	ll_total = dw_1.rowcount()
	for i = 1 to ll_total
		ls_foto = dw_1.getitemstring(i,'inmprodu_prod_foto_dir')
		if not fileexists(ls_foto) then
			dw_1.setitem(i,'incluir',0)
		end if
	next
end if

ls_cadena_temp = ls_cadena
if len(ls_cadena) > 0 then
	ls_cadena = ls_cadena + ' and incluir = 1'
else
	ls_cadena = 'incluir = 1'
end if

dw_1.setfilter(ls_cadena)
dw_1.filter()
dw_1.groupcalc()
if dw_1.rowcount() = 0 then
	dw_1.setfilter(ls_cadena_temp)
	dw_1.filter()	
	gf_mensaje('','Debe Seleccionar los Registros a Imprimir, Verifique !!!',1,1,'E')
	return
end if

dw_4.Object.datawindow.print.preview = true
dw_4.object.empresa_nom.expression = "'"+str.nombre_empresa+"'"
dw_4.visible = true
OpenWithParm(w_dw_print_options, dw_4)
If Message.DoubleParm = -1 Then
	dw.Object.datawindow.print.preview = false
	dw_1.setfilter(ls_cadena_temp)
	dw_1.filter()
	dw_1.groupcalc()	
	Return
end if
dw_4.Print(True)
dw.Object.datawindow.print.preview = false
dw_1.setfilter(ls_cadena_temp)
dw_1.filter()
dw_1.groupcalc()

end event

type cbx_bulto from checkbox within w_reporte_inventario
integer x = 3762
integer y = 2224
integer width = 512
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Mayor al Bulto"
end type

event clicked;dw_2.accepttext()
dw_5.accepttext()
string ls_cadena, ls_desc, ls_division, ls_descrip, ls_and
date ldt_Desde, ldt_hasta
ls_desc = idwc_grupo.getitemstring(idwc_grupo.getrow(),'agru_descripcion_grupo')
ls_division = idwc_division.getitemstring(idwc_division.getrow(),'adiv_nombre_div')
ls_descrip = dw_5.getitemstring(1,'descripcion')
ls_and = ''
ls_cadena = ''

if len(ls_descrip) > 0 then 
	ls_cadena = 'left(upper(inmprodu_prod_descripcion),'+ string(len(ls_descrip))+ ') = "'+upper(ls_descrip)+'"'
	ls_and = ' and '
end if

if cbx_por_fecha.checked then
	ldt_desde = date(em_desde.text)
	ldt_hasta  = date(em_hasta.text)
	ls_cadena = ls_cadena + ls_and + 'date( prod_entrada_fecha ) >= date("'+string(ldt_desde)+'") and date( prod_entrada_fecha ) <= date("'+string(ldt_hasta)+'")'
end if

if this.checked then		
		ls_cadena = ls_cadena+ls_and+'entero > prod_empaque'
		if ls_desc <> '' and not isnull(ls_desc) then
				ls_cadena = ls_cadena + " and cragrupo_agru_descripcion_grupo ='"+ls_desc+"'"
		end if
		if ls_division <> '' and not isnull(ls_division) then
			ls_cadena = ls_cadena + " and cradivis_adiv_nombre_div ='"+ls_division+"'"
		end if
else
		if cbx_filtrar.checked then
			ls_cadena = ls_cadena+ls_and+ 'prod_existencia_total > 0'
		end if
		if ls_desc <> '' and not isnull(ls_desc) then
				ls_cadena = ls_cadena + " and cragrupo_agru_descripcion_grupo ='"+ls_desc+"'"
		end if
		if ls_division <> '' and not isnull(ls_division) then
			ls_cadena = ls_cadena + " and cradivis_adiv_nombre_div ='"+ls_division+"'"
		end if
end if
dw_1.setfilter(ls_cadena)
dw_1.filter()

end event

type dw_5 from datawindow within w_reporte_inventario
integer x = 1952
integer y = 2312
integer width = 1161
integer height = 96
integer taborder = 71
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_descripcion"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event editchanged;dw_2.accepttext()
date ldt_Desde, ldt_hasta
string ls_cadena, ls_desc, ls_division, ls_descrip, ls_and
ls_desc = idwc_grupo.getitemstring(idwc_grupo.getrow(),'agru_descripcion_grupo')
ls_division = idwc_division.getitemstring(idwc_division.getrow(),'adiv_nombre_div')
ls_descrip = data
ls_cadena = ''
ls_and = ''
	
if len(ls_descrip) > 0 then 
	ls_cadena = 'left(upper(inmprodu_prod_descripcion),'+ string(len(ls_descrip))+ ') = "'+upper(ls_descrip)+'"'
	ls_and = ' and '
end if

if cbx_por_fecha.checked then
	ldt_desde = date(em_desde.text)
	ldt_hasta  = date(em_hasta.text)
	ls_cadena = ls_cadena + ls_and + 'date( prod_entrada_fecha ) >= date("'+string(ldt_desde)+'") and date( prod_entrada_fecha ) <= date("'+string(ldt_hasta)+'")'
	ls_and = ' and '
end if

if cbx_bulto.checked then		
		ls_cadena = ls_cadena + ls_and + 'entero > prod_empaque'
		if ls_desc <> '' and not isnull(ls_desc) then
				ls_cadena = ls_cadena + " and cragrupo_agru_descripcion_grupo ='"+ls_desc+"'"
		end if
		if ls_division <> '' and not isnull(ls_division) then
			ls_cadena = ls_cadena + " and cradivis_adiv_nombre_div ='"+ls_division+"'"
		end if
else
		if cbx_filtrar.checked then
			ls_cadena = ls_cadena + ls_and + 'prod_existencia_total > 0'
		end if
		if ls_desc <> '' and not isnull(ls_desc) then
				ls_cadena = ls_cadena + " and cragrupo_agru_descripcion_grupo ='"+ls_desc+"'"
		end if
		if ls_division <> '' and not isnull(ls_division) then
			ls_cadena = ls_cadena + " and cradivis_adiv_nombre_div ='"+ls_division+"'"
		end if
end if



dw_1.setfilter(ls_cadena)
dw_1.filter()

end event

type st_3 from statictext within w_reporte_inventario
integer x = 1586
integer y = 2332
integer width = 357
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Descripcion:"
boolean focusrectangle = false
end type

type cb_cantidades from commandbutton within w_reporte_inventario
boolean visible = false
integer x = 5243
integer y = 1848
integer width = 617
integer height = 104
integer taborder = 91
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Asignar Cantidades"
end type

event clicked;open(w_asigna_cantidades)
str_cantidades_producto lstr_cantidades
integer li_minima, li_reorden, li_maxima
long i
string ls_producto

lstr_cantidades = message.powerobjectparm

if isvalid(lstr_cantidades) then
	li_minima = lstr_cantidades.minima
	li_reorden	= lstr_cantidades.reorden
	li_maxima   = lstr_cantidades.maxima
	for i = 1 to dw_1.rowcount()
		yield()
		ls_producto = dw_1.getitemstring(i,'prod_producto')
		  UPDATE inmprodu  
			  SET prod_punto_minimo = :li_minima,   
					prod_cant_a_pedir = :li_reorden,   
					prod_punto_maximo = :li_maxima  
			WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
					( inmprodu.prod_empresa = :str.empresa ) AND  
					( inmprodu.prod_producto = :ls_producto )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Actualizar Producto '+sqlca.sqlerrtext,1,1,'E')
					return
				end if
	next
	gf_mensaje('','Se Asignaron las Cantidades a los Productos.',1,1,'E')
end if

end event

type cbx_letras from checkbox within w_reporte_inventario
integer x = 3762
integer y = 2320
integer width = 544
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Valores en Letras"
end type

event clicked;string ls_cadena_costo, ls_costo
integer i, li_Ver, li_total
decimal{2} ld_costo, ld_entero, ld_promedio, ld_total_final
if this.checked then
	li_ver = 1
	li_total =  dw_1.rowcount()
	dw_1.object.ver.expression = "'"+string(li_ver)+"'"
	select para_clave_costos  //Clave de Costos
		into : ls_cadena_costo
		from inaparam
		where (para_g_financiero =: str.g_financiero) and
				(para_empresa =: str.empresa);
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al buscar clave '+sqlca.sqlerrtext,1,1,'E')
		end if
		
		for i = 1 to li_total
			yield()
			str.frame.setmicrohelp('Procesando el registro '+string(i)+ ' de '+string(li_total))
			ld_costo = dw_1.getitemnumber(i,'prod_costo_promedio')
			ls_costo = gf_clave_costos_sin_select(ld_costo, ls_cadena_costo)		
			dw_1.setitem(i,'costo_promedio',ls_costo)
			ld_costo = dw_1.getitemnumber(i,'prod_costo_cif_1')
			ls_costo = gf_clave_costos_sin_select(ld_costo, ls_cadena_costo)		
			dw_1.setitem(i,'costo_cif',ls_costo)
			ld_costo = dw_1.getitemnumber(i,'prod_costo_fob')
			ls_costo = gf_clave_costos_sin_select(ld_costo, ls_cadena_costo)		
			dw_1.setitem(i,'costo_fob',ls_costo)
			ld_entero = dw_1.getitemnumber(i,'entero')
			ld_promedio = dw_1.getitemnumber(i,'prod_costo_promedio')
			ld_costo = ld_entero * ld_promedio
			ls_costo = gf_clave_costos_sin_select(ld_costo, ls_cadena_costo)		
			dw_1.setitem(i,'valor_inv_promedio',ls_costo)
			ld_promedio = dw_1.getitemnumber(i,'prod_costo_cif')
			ld_costo = ld_entero * ld_promedio
			ls_costo = gf_clave_costos_sin_select(ld_costo, ls_cadena_costo)		
			dw_1.setitem(i,'valor_inv_cif_letras',ls_costo)				
			ld_promedio = dw_1.getitemnumber(i,'prod_costo_fob')
			ld_costo = ld_entero * ld_promedio
			ls_costo = gf_clave_costos_sin_select(ld_costo, ls_cadena_costo)		
			dw_1.setitem(i,'valor_inv_fob_letras',ls_costo)				
		next
		ld_total_final = dw_1.getitemnumber(1,'total_valor_inv')
		ls_costo = gf_clave_costos_sin_select(ld_total_final, ls_cadena_costo)		
		dw_1.setitem(1,'total_valor_letras',ls_costo)		
		ld_total_final = dw_1.getitemnumber(1,'total_ultimo')
		ls_costo = gf_clave_costos_sin_select(ld_total_final, ls_cadena_costo)		
		dw_1.setitem(1,'total_ultimo_letras',ls_costo)		
		ld_total_final = dw_1.getitemnumber(1,'total_fob')
		ls_costo = gf_clave_costos_sin_select(ld_total_final, ls_cadena_costo)		
		dw_1.setitem(1,'total_fob_letras',ls_costo)		

	else
		li_ver = 0
		dw_1.object.ver.expression = "'"+string(li_ver)+"'"	
	end if
str.frame.setmicrohelp('Listo')
dw_1.groupcalc()
end event

type cbx_ver_existencias from checkbox within w_reporte_inventario
boolean visible = false
integer x = 3186
integer y = 2320
integer width = 567
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Ver Existencias ?"
boolean checked = true
end type

event clicked;if cbx_ver_existencias.checked then
	dw_4.setitem(1,'ver_existencia',1)
else
	dw_4.setitem(1,'ver_existencia',0)	
end if
end event

type cbx_conteo from checkbox within w_reporte_inventario
integer x = 4334
integer y = 2228
integer width = 526
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Archivo Conteo"
end type

event clicked;if cbx_conteo.checked then
	dw_1.dataobject = 'dw_reporte_conteo_fisico'
	ddlb_conteo.visible = true
	st_deposito.visible = true
else
	dw_1.dataobject = 'dw_reporte_inventario'
	ddlb_conteo.visible = false
	st_deposito.visible = false
end if

dw_1.settransobject(sqlca)
dw_1.sharedata(dw_4)
dw_4.object.empresa_nom.expression = "'"+str.nombre_empresa+"'"
parent.triggerevent('ue_post_open')
if cbx_conteo.checked then
	if cbx_bulto.checked then
		dw_1.setfilter('bultos'+ddlb_conteo.text+' > 0')
	else
		dw_1.setfilter('inmprodu_prod_existencia'+ddlb_conteo.text+' > 0')
	end if
	dw_1.filter()
end if
dw_1.setitem(1,'deposito',ddlb_conteo.text)
dw_1.groupcalc()

end event

type ddlb_conteo from dropdownlistbox within w_reporte_inventario
boolean visible = false
integer x = 4347
integer y = 2320
integer width = 480
integer height = 376
integer taborder = 71
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string item[] = {"1","2","3"}
end type

event selectionchanged;if cbx_bulto.checked then
	dw_1.setfilter('bultos'+ddlb_conteo.text+' > 0 and inmprodu_prod_existencia'+ddlb_conteo.text+' > 0')
else
	dw_1.setfilter('inmprodu_prod_existencia'+ddlb_conteo.text+' > 0')
end if
dw_1.filter()
dw_1.setitem(1,'deposito',ddlb_conteo.text)
dw_1.groupcalc()
end event

type st_deposito from statictext within w_reporte_inventario
boolean visible = false
integer x = 4846
integer y = 2336
integer width = 311
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "DEPOSITO"
boolean focusrectangle = false
end type

type cbx_por_fecha from checkbox within w_reporte_inventario
integer x = 32
integer y = 2108
integer width = 635
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Por Fecha de Entrada"
end type

event clicked;dw_2.accepttext()
dw_5.accepttext()
string ls_cadena, ls_desc, ls_division, ls_descrip, ls_and
date ldt_desde, ldt_hasta

ls_desc = idwc_grupo.getitemstring(idwc_grupo.getrow(),'agru_descripcion_grupo')
ls_division = idwc_division.getitemstring(idwc_division.getrow(),'adiv_nombre_div')
ls_descrip = dw_5.getitemstring(1,'descripcion')
ls_cadena = ''
ls_and = ''

if cbx_por_fecha.checked then
	em_desde.visible = true
	em_hasta.visible = true
	st_4.visible = true
	ldt_desde = date(em_desde.text)
	ldt_hasta  = date(em_hasta.text)
	ls_cadena = 'date( prod_entrada_fecha ) >= date("'+string(ldt_desde)+'") and date( prod_entrada_fecha ) <= date("'+string(ldt_hasta)+'")'
	ls_and = ' and '
	cbx_a_una_fecha.checked = false	
	em_fecha.visible = false
	cb_calcular.visible = false	
	if 	dw_1.dataobject = 'dw_reporte_inventario_a_una_fecha' then
		dw_1.dataobject = 'dw_reporte_inventario'
		dw_1.settransobject(sqlca)
	end if
else
	em_desde.visible = false
	em_hasta.visible = false
	st_4.visible = false
end if

if len(ls_descrip) > 0 then 
	ls_cadena = ls_cadena+ls_and+ 'left(upper(inmprodu_prod_descripcion),'+ string(len(ls_descrip))+ ') = "'+upper(ls_descrip)+'"'
	ls_and = ' and '
end if

if cbx_bulto.checked then		
		ls_cadena = ls_cadena + ls_and + 'entero > prod_empaque'
		if ls_desc <> '' and not isnull(ls_desc) then
				ls_cadena = ls_cadena + " and cragrupo_agru_descripcion_grupo ='"+ls_desc+"'"
		end if
		if ls_division <> '' and not isnull(ls_division) then
			ls_cadena = ls_cadena + " and cradivis_adiv_nombre_div ='"+ls_division+"'"
		end if
else
		if cbx_filtrar.checked then
			ls_cadena = ls_cadena + ls_and + 'prod_existencia_total > 0'
		end if
		if ls_desc <> '' and not isnull(ls_desc) then
				ls_cadena = ls_cadena + " and cragrupo_agru_descripcion_grupo ='"+ls_desc+"'"
		end if
		if ls_division <> '' and not isnull(ls_division) then
			ls_cadena = ls_cadena + " and cradivis_adiv_nombre_div ='"+ls_division+"'"
		end if
end if
dw_1.setfilter(ls_cadena)
dw_1.filter()


end event

type em_desde from editmask within w_reporte_inventario
boolean visible = false
integer x = 695
integer y = 2092
integer width = 393
integer height = 96
integer taborder = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean spin = true
double increment = 1
end type

event modified;dw_2.accepttext()
dw_5.accepttext()
string ls_cadena, ls_desc, ls_division, ls_descrip, ls_and
date ldt_desde, ldt_hasta

ls_desc = idwc_grupo.getitemstring(idwc_grupo.getrow(),'agru_descripcion_grupo')
ls_division = idwc_division.getitemstring(idwc_division.getrow(),'adiv_nombre_div')
ls_descrip = dw_5.getitemstring(1,'descripcion')
ls_cadena = ''
ls_and = ''

if cbx_por_fecha.checked then
	em_desde.visible = true
	em_hasta.visible = true
	st_4.visible = true
	ldt_desde = date(em_desde.text)
	ldt_hasta  = date(em_hasta.text)
	ls_cadena = 'date( prod_entrada_fecha ) >= date("'+string(ldt_desde)+'") and date( prod_entrada_fecha ) <= date("'+string(ldt_hasta)+'")'
	ls_and = ' and '
else
	em_desde.visible = false
	em_hasta.visible = false
	st_4.visible = false
end if

if len(ls_descrip) > 0 then 
	ls_cadena = ls_cadena+ls_and+ 'left(upper(inmprodu_prod_descripcion),'+ string(len(ls_descrip))+ ') = "'+upper(ls_descrip)+'"'
	ls_and = ' and '
end if

if cbx_bulto.checked then		
		ls_cadena = ls_cadena + ls_and + 'entero > prod_empaque'
		if ls_desc <> '' and not isnull(ls_desc) then
				ls_cadena = ls_cadena + " and cragrupo_agru_descripcion_grupo ='"+ls_desc+"'"
		end if
		if ls_division <> '' and not isnull(ls_division) then
			ls_cadena = ls_cadena + " and cradivis_adiv_nombre_div ='"+ls_division+"'"
		end if
else
		if cbx_filtrar.checked then
			ls_cadena = ls_cadena + ls_and + 'prod_existencia_total > 0'
		end if
		if ls_desc <> '' and not isnull(ls_desc) then
				ls_cadena = ls_cadena + " and cragrupo_agru_descripcion_grupo ='"+ls_desc+"'"
		end if
		if ls_division <> '' and not isnull(ls_division) then
			ls_cadena = ls_cadena + " and cradivis_adiv_nombre_div ='"+ls_division+"'"
		end if
end if
dw_1.setfilter(ls_cadena)
dw_1.filter()


end event

type em_hasta from editmask within w_reporte_inventario
boolean visible = false
integer x = 1321
integer y = 2092
integer width = 393
integer height = 96
integer taborder = 71
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean spin = true
double increment = 1
end type

event modified;dw_2.accepttext()
dw_5.accepttext()
string ls_cadena, ls_desc, ls_division, ls_descrip, ls_and
date ldt_desde, ldt_hasta

ls_desc = idwc_grupo.getitemstring(idwc_grupo.getrow(),'agru_descripcion_grupo')
ls_division = idwc_division.getitemstring(idwc_division.getrow(),'adiv_nombre_div')
ls_descrip = dw_5.getitemstring(1,'descripcion')
ls_cadena = ''
ls_and = ''

if cbx_por_fecha.checked then
	em_desde.visible = true
	em_hasta.visible = true
	st_4.visible = true
	ldt_desde = date(em_desde.text)
	ldt_hasta  = date(em_hasta.text)
	ls_cadena = 'date( prod_entrada_fecha ) >= date("'+string(ldt_desde)+'") and date( prod_entrada_fecha ) <= date("'+string(ldt_hasta)+'")'
	ls_and = ' and '
else
	em_desde.visible = false
	em_hasta.visible = false
	st_4.visible = false
end if

if len(ls_descrip) > 0 then 
	ls_cadena = ls_cadena+ls_and+ 'left(upper(inmprodu_prod_descripcion),'+ string(len(ls_descrip))+ ') = "'+upper(ls_descrip)+'"'
	ls_and = ' and '
end if

if cbx_bulto.checked then		
		ls_cadena = ls_cadena + ls_and + 'entero > prod_empaque'
		if ls_desc <> '' and not isnull(ls_desc) then
				ls_cadena = ls_cadena + " and cragrupo_agru_descripcion_grupo ='"+ls_desc+"'"
		end if
		if ls_division <> '' and not isnull(ls_division) then
			ls_cadena = ls_cadena + " and cradivis_adiv_nombre_div ='"+ls_division+"'"
		end if
else
		if cbx_filtrar.checked then
			ls_cadena = ls_cadena + ls_and + 'prod_existencia_total > 0'
		end if
		if ls_desc <> '' and not isnull(ls_desc) then
				ls_cadena = ls_cadena + " and cragrupo_agru_descripcion_grupo ='"+ls_desc+"'"
		end if
		if ls_division <> '' and not isnull(ls_division) then
			ls_cadena = ls_cadena + " and cradivis_adiv_nombre_div ='"+ls_division+"'"
		end if
end if
dw_1.setfilter(ls_cadena)
dw_1.filter()


end event

type st_4 from statictext within w_reporte_inventario
boolean visible = false
integer x = 1111
integer y = 2112
integer width = 197
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Hasta:"
boolean focusrectangle = false
end type

type cbx_a_una_fecha from checkbox within w_reporte_inventario
integer x = 1829
integer y = 2108
integer width = 727
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "A una Fecha Especíifica"
end type

event clicked;string ls_titulo
if this.checked then
	//dw_1.dataobject = 'dw_reporte_inventario_a_una_fecha'
	dw_1.dataobject = 'dw_valor_inventario_fecha_especifica'
	cb_calcular.visible = true
	em_fecha.visible = true
	cbx_por_fecha.checked = false
	em_desde.visible = false
	em_hasta.visible = false
	st_4.visible = false
	cbx_filtrar.checked = false
	em_fecha.setfocus()
else
	if pos(upper(str.empr_acceso_especial),'ADVANCED') > 0 then
		dw_1.dataobject = 'dw_reporte_inventario_estandar'
	else
		dw_1.dataobject = 'dw_reporte_inventario'
	end if
	dw_1.settransobject(sqlca)
	em_fecha.visible = false
	cb_calcular.visible = false	
	cbx_filtrar.checked = true
	ls_titulo = 'Al '+string( date(gf_fecha_serv()), 'dd,mmm,yyyy' )
	dw_1.object.fecha_titulo.expression = "'"+ls_titulo+"'"
	if dw_1.retrieve(str.g_financiero, str.empresa) > 0 then	
		dw_1.Modify ("DataWindow.Header.1.Height = 0")
		dw_1.Modify ("DataWindow.Header.2.Height = 0")
		dw_1.Modify ("DataWindow.Trailer.1.Height = 0")
		dw_1.Modify ("DataWindow.Trailer.2.Height = 0")	
		dw_1.setsort('inmprodu_prod_descripcion')
		dw_1.sort()
		dw_1.groupcalc()
	end if
end if
dw_1.settransobject(sqlca)
dw_4.object.empresa_nom.expression = "'"+str.nombre_empresa+"'"

ddlb_conteo.text = '1'
dw_1.object.nom_empresa.expression = "'"+str.nombre_empresa+"'"
end event

type em_fecha from editmask within w_reporte_inventario
boolean visible = false
integer x = 2560
integer y = 2092
integer width = 393
integer height = 96
integer taborder = 91
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean spin = true
double increment = 1
end type

event modified;cb_calcular.triggerevent('clicked')
end event

type cb_calcular from commandbutton within w_reporte_inventario
boolean visible = false
integer x = 2971
integer y = 2092
integer width = 288
integer height = 100
integer taborder = 101
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Calcular"
end type

event clicked;integer i, li_total
decimal ld_saldo
string ls_producto, ls_titulo
date ldt_fecha

ldt_fecha = date(em_fecha.text)
ls_titulo = 'Al '+string( ldt_fecha, 'dd,mmm,yyyy' )
dw_1.object.fecha_titulo.expression = "'"+ls_titulo+"'"

str.frame.setmicrohelp('Hymsoft')

wf_inventario_especifico()
dw_1.Retrieve(str.g_financiero,str.empresa,str.maquina)  //ldt_fecha de tercero en argumentos
dw_1.sort()
dw_1.groupcalc()
dw_1.Object.datawindow.print.preview = true

//li_total = dw_1.rowcount()
//for i = 1 to li_total
//	ls_producto = dw_1.getitemstring(i,'prod_producto')
//	str.frame.setmicrohelp('Procesando el Registro '+string(i)+ ' de '+string(li_total))
//	  SELECT isnull(sum(case when tmov_tipo = 'D' then dmov_cantidad else - dmov_cantidad end)  ,0)
//		  into :ld_saldo
//		 FROM indmovim,   
//				intmovim  
//		WHERE ( intmovim.tmov_g_financiero = indmovim.dmov_g_financiero ) and  
//				( intmovim.tmov_empresa = indmovim.dmov_empresa ) and  
//				( intmovim.tmov_aplicacion = indmovim.dmov_aplicacion ) and  
//				( intmovim.tmov_tipo_transaccion = indmovim.dmov_tipo_transaccion ) and  
//				( intmovim.tmov_secuencia = indmovim.dmov_secuencia ) and  
//				( intmovim.tmov_anual = indmovim.dmov_anual ) and  
//				( intmovim.tmov_concepto = indmovim.dmov_concepto ) and  
//				( ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
//				( intmovim.tmov_empresa = :str.empresa ) AND  
//				( intmovim.tmov_fecha <= :ldt_fecha ) AND  
//				( indmovim.dmov_producto = :ls_producto ) )   ;
//				if sqlca.sqlcode = -1 then
//					gf_mensaje('','Error al Buscar Saldo '+sqlca.sqlerrtext,1,1,'E')
//				end if
//				
//				dw_1.setitem(i,'entero',long(ld_saldo))
//next

end event

type cbx_futuro from checkbox within w_reporte_inventario
integer x = 3762
integer y = 2124
integer width = 549
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Ver Futuro"
end type

event clicked;if this.checked then
	dw_1.dataobject = 'dw_reporte_inventario_futuro'
	cbx_foto.visible = true
else
	dw_1.dataobject = 'dw_reporte_inventario'
	cbx_foto.visible = false
	cbx_foto.checked = false
end if
parent.triggerevent('ue_post_open')
end event

type cbx_foto from checkbox within w_reporte_inventario
boolean visible = false
integer x = 4334
integer y = 2124
integer width = 421
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Ver Foto"
end type

event clicked;if this.checked then
   dw_1.Modify ("prod_foto_dir.visible = true")
   dw_1.Modify ("DataWindow.Detail.Height = 368")
else
   dw_1.Modify ("prod_foto_dir.visible = false")	
   dw_1.Modify ("DataWindow.Detail.Height = 60")
end if

end event

type cbx_venta from checkbox within w_reporte_inventario
integer x = 4827
integer y = 2124
integer width = 462
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Para la Venta"
end type

event clicked;if this.checked then
	dw_6.retrieve(str.g_financiero, str.empresa)
	dw_6.visible = true
else
	dw_6.visible = false
end if
end event

type dw_6 from datawindow within w_reporte_inventario
boolean visible = false
integer x = 78
integer y = 204
integer width = 4087
integer height = 1936
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "Reporte de Inventario para la Venta"
string dataobject = "dw_reporte_inventario_para_venta"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_7 from datawindow within w_reporte_inventario
boolean visible = false
integer x = 1829
integer y = 1052
integer width = 1719
integer height = 700
integer taborder = 31
boolean bringtotop = true
boolean titlebar = true
string title = "Datos de la Proforma"
string dataobject = "dw_external_crear_proforma"
boolean controlmenu = true
string icon = "Form!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;long ll_tercero
string ls_proforma
integer li_ann
this.accepttext()
if dwo.name = 'b_aceptar' then
	ll_tercero = this.getitemnumber(1,'cliente')
	if ll_tercero = 0 or isnull(ll_tercero) then
		gf_mensaje('','Must be Assign the Customer',1,1,'E')
		return
	end if

	li_ann = this.getitemnumber(1,'ann')	
	ls_proforma = this.getitemstring(1,'proforma')
	if ls_proforma = '' or isnull(ls_proforma) then
		gf_mensaje('','Debe Asignar el # de la Proforma',1,1,'E')
		return
	end if
	
	if wf_crear_proforma(li_ann, ls_proforma, ll_tercero) then
		gf_mensaje('','Proforma Creada',1,1,'E')
	end if
	this.visible = false
	
elseif dwo.name = 'b_close' then
	dw_7.visible = false
elseif dwo.name = 'p_cliente' then
	
	String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error
	integer li_c, li_b
	long    ll_lter
	
	Datawindow        dww
	str_dg_dynamic_find	lstr_df
	
		lstr_df.texto_campo [2,1] = "ccmclien.clie_ref_anterior" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [2,2] = "Codigo"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '450'
		lstr_df.texto_campo [1,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [1,2] = "Nombre"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '700'		
		lstr_df.texto_campo [3,1] = "dgmterce.terc_tercero"
		lstr_df.texto_campo [3,2] = "Código Tercero"
		lstr_df.texto_campo [3,3] = "terc_tercero"
		lstr_df.texto_campo [3,4] = 'I'
		lstr_df.texto_campo [4,1] = "dgapais.pais_descripcion"
		lstr_df.texto_campo [4,2] = "Pais"
		lstr_df.texto_campo [4,3] = ""
		lstr_df.texto_campo [4,4] = 'V'
		lstr_df.texto_campo [4,5] = '550'
		
		lstr_df.tabla = " dgmterce, dgapais, ccmclien "
		
		
		lstr_df.tabla_where = &
					"WHERE ( dgmterce.terc_pais = dgapais.pais_pais ) and  " +&				
							 "(ccmclien.clie_g_financiero = " + string(str.g_financiero) + " and " +&
							 "ccmclien.clie_empresa = " + string(str.empresa) + ") 	and " +&
							"(dgmterce.terc_tercero = ccmclien.clie_tercero) and " +&
					      "(ccmclien.clie_estado = 'A' ) AND  " +&
					      "(ccmclien.clie_cuenta_mala <> 1 ) "  							
		
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	If len (ls_find) = 0 Then Return
		
		
	ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo1,"'"," ")
	ls_codigo1 = Trim(ls_codigo1)
	ll_tercero = long(ls_codigo1)
	dw_7.setitem(1,'cliente',ll_tercero)
elseif dwo.name = 'p_proforma' then
	li_ann = this.getitemnumber(1,'ann')
	lstr_df.texto_campo [1,1] = "fatprofo.prof_no_proforma"
	lstr_df.texto_campo [1,2] = "Proforma"
	lstr_df.texto_campo [1,3] = "prof_no_proforma"
	lstr_df.texto_campo [1,4] = 'V'
	lstr_df.texto_campo [1,5] = '220'	
	lstr_df.texto_campo [2,1] = "fatprofo.prof_a_nombre"
	lstr_df.texto_campo [2,2] = "Shipped to .."
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '650'
	lstr_df.texto_campo [3,1] = "fatprofo.prof_fecha"
	lstr_df.texto_campo [3,2] = "Date"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [3,5] = '315'
	lstr_df.texto_campo [4,1] = "case fatprofo.prof_estado when 'P' then 'PASS' else 'PENDING' end prof_estado"
	lstr_df.texto_campo [4,2] = "Status"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '300'
	lstr_df.texto_campo [5,1] = "fatprofo.prof_monto_final"
	lstr_df.texto_campo [5,2] = "Amount"
	lstr_df.texto_campo [5,3] = ""
	lstr_df.texto_campo [5,4] = 'V'
	lstr_df.texto_campo [5,5] = '240'


	lstr_df.tabla = " fatprofo "
		
	lstr_df.tabla_where = &
				"WHERE (fatprofo.prof_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(fatprofo.prof_empresa = " + string(str.empresa) + ") 	and " +&
 						 "(fatprofo.prof_ann = " + string(li_ann) + ") and (fatprofo.prof_estado = 'A')" 
	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm
	
	If len (ls_find) = 0 Then Return
		
	ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo1,"'"," ")
	ls_codigo1 = Trim(ls_codigo1)
	this.setitem(1,'proforma',ls_codigo1)
end if
end event

type cb_quote from commandbutton within w_reporte_inventario
integer x = 3269
integer y = 2096
integer width = 462
integer height = 104
integer taborder = 111
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crear Proforma"
end type

event clicked;string ls_proforma
dw_7.reset()
dw_7.insertrow(1)
dw_7.setitem(1,'ann',year(date(gf_fecha_serv())))
wf_orden_nueva()
dw_7.setcolumn('cliente')
dw_7.visible = true
dw_7.setfocus()
end event

type cbx_con_fotos from checkbox within w_reporte_inventario
integer x = 4832
integer y = 2220
integer width = 462
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Solo con Fotos"
end type

type em_lineas from editmask within w_reporte_inventario
integer x = 5531
integer y = 2116
integer width = 165
integer height = 84
integer taborder = 121
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "0"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###0"
end type

event modified;dw_2.accepttext()
long ll_cantidad
date ldt_Desde, ldt_hasta
string ls_cadena, ls_desc, ls_division, ls_descrip, ls_and
ls_desc = idwc_grupo.getitemstring(idwc_grupo.getrow(),'agru_descripcion_grupo')
ls_division = idwc_division.getitemstring(idwc_division.getrow(),'adiv_nombre_div')

ls_cadena = ''
ls_and = ''

ll_cantidad = long(em_lineas.text)
if ll_cantidad > 0 then
	dw_4.visible = true
	ls_cadena = 'getrow() <= '+string(ll_cantidad)
	ls_and = ' and '
end if


ls_descrip = dw_5.getitemstring(1,'descripcion')
if len(ls_descrip) > 0 then 
	ls_cadena = ls_cadena + ls_and + 'left(upper(inmprodu_prod_descripcion),'+ string(len(ls_descrip))+ ') = "'+upper(ls_descrip)+'"'
	ls_and = ' and '
end if

if cbx_por_fecha.checked then
	ldt_desde = date(em_desde.text)
	ldt_hasta  = date(em_hasta.text)
	ls_cadena = ls_cadena + ls_and + 'date( prod_entrada_fecha ) >= date("'+string(ldt_desde)+'") and date( prod_entrada_fecha ) <= date("'+string(ldt_hasta)+'")'
	ls_and = ' and '
end if

if cbx_bulto.checked then		
		ls_cadena = ls_cadena + ls_and + 'entero > prod_empaque'
		if ls_desc <> '' and not isnull(ls_desc) then
				ls_cadena = ls_cadena + " and cragrupo_agru_descripcion_grupo ='"+ls_desc+"'"
		end if
		if ls_division <> '' and not isnull(ls_division) then
			ls_cadena = ls_cadena + " and cradivis_adiv_nombre_div ='"+ls_division+"'"
		end if
else
		if cbx_filtrar.checked then
			ls_cadena = ls_cadena + ls_and + 'prod_existencia_total > 0'
		end if
		if ls_desc <> '' and not isnull(ls_desc) then
				ls_cadena = ls_cadena + " and cragrupo_agru_descripcion_grupo ='"+ls_desc+"'"
		end if
		if ls_division <> '' and not isnull(ls_division) then
			ls_cadena = ls_cadena + " and cradivis_adiv_nombre_div ='"+ls_division+"'"
		end if
end if


dw_4.Object.datawindow.print.preview = true
dw_1.setfilter(ls_cadena)
dw_1.filter()

end event

type st_lineas from statictext within w_reporte_inventario
integer x = 5710
integer y = 2132
integer width = 201
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Líneas"
boolean focusrectangle = false
end type

type cbx_ver from checkbox within w_reporte_inventario
integer x = 5349
integer y = 2120
integer width = 178
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Ver"
end type

event clicked;if this.checked then
	dw_4.dataobject = 'dw_reporte_inventario_con_foto'	
	em_lineas.enabled = true	
	em_lineas.setfocus()
	em_lineas.selecttext(1,100)
	cb_enviar.visible = true
	em_correo.visible = true
else
	dw_4.dataobject = 'dw_reporte_inventario_catalogo'
	em_lineas.enabled = false	
	cb_enviar.visible = false
	em_correo.visible = false
end if

dw_4.settransobject(sqlca)
dw_1.sharedata(dw_4)
end event

type cb_enviar from commandbutton within w_reporte_inventario
boolean visible = false
integer x = 5353
integer y = 2220
integer width = 453
integer height = 116
integer taborder = 91
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Enviar Correo"
end type

event clicked;string ls_correo, ls_ruc, ls_tag, ls_fecha

ls_correo = em_correo.text

OLEObject ole_object 
Integer li_rc , li_Ret, li_return
PDFDocument lpdf_doc
String ls_ruta , ls_raiz
integer li_result, li_FileNum
long ll_return
string ls_path, ls_archivo2, ls_nombre
lpdf_doc = create PDFDocument

ls_path = "C:\Sistemas\Comprobantes"
ls_nombre = 'Inventario'
ls_archivo2= ls_path+"\"+ls_nombre+".pdf"
FileDelete(ls_archivo2)

//		 dw_4.Modify ("DataWindow.Export.PDF.Method = NativePDF! ")
//		 dw_4.modify("DataWindow.Export.PDF.NativePDF.PDFStandard =1")
//		 ll_return =  lpdf_doc.importdatawindow(dw_4)
//		 lpdf_doc.CompressionLevel = 9	
//		 ll_return = lpdf_doc.save(ls_archivo2)
//		 destroy lpdf_doc
		
		PrintSetPrinter ("Bullzip PDF Printer")
		dw_4.Object.DataWindow.Printer = "Bullzip PDF Printer" // "Sybase DataWindow PS" //"Adobe DataWindow PS"
		dw_4.Object.DataWindow.Export.PDF.Method = Distill!
		dw_4.Object.DataWindow.Export.PDF.Distill.CustomPostScript="Yes"
		dw_4.Modify("datawindow.Export.PDF.Method = '1'")
		dw_4.print()		

		sleep(13)
		
ls_raiz = 'C:\Sistemas\Comprobantes\comprobante.pdf'
li_FileNum = FileCopy (ls_raiz , ls_archivo2, TRUE)
if li_Filenum <> 1 then
	gf_mensaje('','Error al Copiar ...'+string(li_Filenum),1,1,'E')
	return
end if
		
if fileexists(ls_archivo2) then
	
	ls_tag = 'Inventario'
	ls_nombre =  'Inventario'
	ls_fecha = string(gf_fecha_serv(),'dd/MMM/yyyy')

	if len(ls_correo) = 0 or pos(ls_correo,'@') = 0 then
		gf_mensaje('','Se Requiere un Correo Valido, Verifique !!!',1,1,'E')
		return
	end if
	li_return = wf_send_mail(ls_archivo2, ls_tag, ' - '+ls_nombre + ' al ' +ls_fecha, ls_correo)	
	
end if
end event

type em_correo from editmask within w_reporte_inventario
boolean visible = false
integer x = 5362
integer y = 2340
integer width = 773
integer height = 88
integer taborder = 81
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
textcase textcase = lower!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type st_correo from statictext within w_reporte_inventario
integer x = 5175
integer y = 2356
integer width = 187
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Correo:"
alignment alignment = right!
boolean focusrectangle = false
end type

