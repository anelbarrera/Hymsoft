forward
global type w_clave from w_a
end type
type sle_clave from singlelineedit within w_clave
end type
type sle_usuario from singlelineedit within w_clave
end type
type st_3 from statictext within w_clave
end type
type st_2 from statictext within w_clave
end type
type st_1 from statictext within w_clave
end type
type cb_1 from u_cb_close within w_clave
end type
type cb_4 from u_cb_run_away within w_clave
end type
type cb_3 from commandbutton within w_clave
end type
type gb_1 from groupbox within w_clave
end type
type st_windows from statictext within w_clave
end type
type cb_2 from commandbutton within w_clave
end type
end forward

global type w_clave from w_a
integer width = 2002
integer height = 696
string title = "Clave"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 79741120
event ue_login pbm_custom15
event ue_cambiar pbm_custom16
sle_clave sle_clave
sle_usuario sle_usuario
st_3 st_3
st_2 st_2
st_1 st_1
cb_1 cb_1
cb_4 cb_4
cb_3 cb_3
gb_1 gb_1
st_windows st_windows
cb_2 cb_2
end type
global w_clave w_clave

type prototypes
FUNCTION boolean GetComputerNameA(ref string cname,ref long nbuf) LIBRARY "kernel32.dll" alias for "GetComputerNameA;Ansi"
end prototypes

type variables
Int           ii_intentos
Boolean  ib_que = true, ib_auto = false, ib_adios = false
u_external_function uo_sdk_func
String is_frame, is_ruta
//nv_encryptor io_encryptor

Long il_time
integer ii_bugs, ii_bugs2, ii_bugs3
string s_path
end variables

forward prototypes
public subroutine wf_accesos ()
public function boolean wf_extremo ()
public subroutine wf_regedit ()
public function string wf_asigna_ultimo_usuario ()
end prototypes

event ue_login;String	ls_clave, ls_host, ls_msgparm, ls_error
DateTime ldt_fecha
Integer	li_puede
String	ls_path

If wf_extremo() Then Return
IF Not ib_auto THEN	// auto es cuando ya se llama la ventana de clave desde el frame

ii_intentos++

//ls_clave = io_encryptor.of_set(sle_clave.text)

//MessageBox(sle_clave.text, ls_clave)

ls_clave = sle_clave.text
  
  IF ii_intentos >= 3 THEN 
	  cb_3.visible = false
	  cb_4.visible = true
	  cb_2.enabled = false
  END IF
  
  
  IF Len(sle_usuario.text) <= 0 THEN  
	  Mensaje("Aviso", "Debe Introducir un Nombre de Usuario Valido", "")
	  RETURN
  END IF
  
  IF Len(sle_clave.text) <= 0 THEN
	  Mensaje("Aviso","Debe Introducir su Clave", "")
	  sle_clave.SetFocus()
	  RETURN
  END IF	  

  SELECT ssmusuar.usua_id
    INTO :str.usuario
    FROM ssmusuar
   WHERE ssmusuar.usua_id = :sle_usuario.text;

  IF (sqlca.sqlcode <> 0) THEN 
	  Mensaje("Error","Usuario Incorrecto","Intentelo Nuevamente Le Restan " + &
	  			String(3 - ii_intentos) + " Oportunidades.~r~n~n" + sqlca.sqlerrtext)
	  sle_usuario.SetFocus()  
	  SelectText(sle_usuario, 1, len(sle_usuario.text))
	  RETURN
  END IF
  
ELSE
	ls_clave = str.clave
END IF // Fin de ib_auto

// Verifico las aplicaciones a las cuales el usuario posee permisos
 SELECT IsNull(count(ssmgrupusemp.grue_aplicacion ), 0)
    INTO :li_puede  
    FROM ssmgrupusemp  
   WHERE ssmgrupusemp.grue_usuario = :str.usuario   ;
	
	if sqlca.sqlcode = -1 then
		mensaje("Aviso","Error al Verificar si el Usuario Tiene Acceso",sqlca.sqlerrtext)
	end if
	
/*  se elimino el distinct para evaluacion de acceso rapido -
  SELECT IsNull(count(DISTINCT ssmgrupusemp.grue_aplicacion ), 0)
    INTO :li_puede  
    FROM ssmgrupusemp  
   WHERE ssmgrupusemp.grue_usuario = :str.usuario   ; */

	IF li_puede < 1 THEN
		Mensaje("Seguridad", "El Usuario '" + str.usuario + &
											"' No Posee Accesos para este Sistema.", sqlca.sqlerrtext)
		Return
	END IF //TEMP
	
//Open(w_select_aplic_empr)
  SELECT min(dgmempre.empr_g_financiero),   
         min(dgmempre.empr_empresa)  
    INTO :str.g_financiero,   
         :str.empresa  
    FROM dgmempre  
   WHERE dgmempre.empr_estado = 'A'   ;

	if sqlca.sqlcode = -1 then
		mensaje("Aviso","Error al Seleccionar el grupo y empresa",sqlca.sqlerrtext)
		return
	end if
			
str.aplicacion = 'FA'


// El usuario ha cancelado
If str.g_financiero = 0 and str.empresa = 0 Then Return

// Ventana de Espera
if isvalid(this) then
	THIS.Hide()
end if
/* Abro la Ventanita de Espera */

Open(w_espere)

//ii_bugs = 1
//ls_path = str.path
//gf_find_path(ls_path)
////s_path = ls_path + "art\n"
//ls_path = "\harr2000\art\n"
//timer(0.1)
w_espere.visible = true
//  yield()  -- eliminado el 11 de febrero del 2000
// encadeno el nombre del frame de cada aplicación
is_frame = "w_" + Lower(str.aplicacion) + "_frame"

// Busco en que grupo de seguridad, aplicación se encuentra el usuario
  SELECT ssmgrupusemp.grue_g_financiero,   
         ssmgrupusemp.grue_empresa,   
         ssmgrupusemp.grue_grupo,   
         ssmusuar.usua_nombre,   
         ssmusuar.usua_apellido,   
         ssmusuar.usua_clave  
    INTO :str.g_financiero,   
         :str.empresa,   
         :str.grupo,   
         :str.nombre,   
         :str.apellido,   
         :str.clave  
    FROM ssmgrupusemp,   
         ssmusuar  
   WHERE ( ssmusuar.usua_id = ssmgrupusemp.grue_usuario ) AND
			( ( ssmgrupusemp.grue_g_financiero = :str.g_financiero ) AND
			( ssmgrupusemp.grue_aplicacion = :str.aplicacion ) AND
         ( ssmgrupusemp.grue_empresa = :str.empresa ) AND
         ( ssmusuar.usua_id = :str.usuario ) AND  
         ( ssmusuar.usua_clave = :ls_clave ) AND  
         ( ssmgrupusemp.grue_estado = 'A' ) AND  
         ( ssmusuar.usua_estado = 'A' ) )   ;

			if sqlca.sqlcode = -1 then
				messagebox("Atención Sr. Usuario","Error al Seleccionar los datos del Usuario (ssmgrupusemp) "+sqlca.sqlerrtext)
				close(w_espere)
				return
			 end if
			
			

	 //Solo entrará cuando NO se hallan creado empresas
   if isnull(str.empresa) or str.empresa = 0 then		
		str.empresa = 1
		
		  SELECT ssmusuar.usua_nombre,   
					ssmusuar.usua_apellido,   
					ssmusuar.usua_clave  
			 INTO :str.nombre,   
					:str.apellido,   
					:str.clave  
			 FROM ssmusuar  ;			 
			 if sqlca.sqlcode = -1 then
				messagebox("Atención Sr. Usuario","Error al Seleccionar los datos del Usuario (Usuario) "+sqlca.sqlerrtext)
				close(w_espere)				
				return
			 end if
	end if


   IF (sqlca.sqlcode <> 0) THEN 
		/* Cierro la Ventanita de Espera */
		Close(w_espere)
				
		THIS.Show()
		If 3 - ii_intentos = 1 Then
			Mensaje("Acceso al Sistema Harr2000 (#1)","Clave Incorrecta","Intentelo Nuevamente Le Resta " + &
	  				 String(3 - ii_intentos) + " Oportunidad.~r~n~n" + sqlca.sqlerrtext)
			Return
		ElseIf 3 - ii_intentos = 0 Then
			Mensaje("Acceso al Sistema Harr2000 (#2)","Clave Incorrecta","No Logro Pasar la Seguridad.   ~r~n" + &
	  				 "Estos Intentos Fallidos seran Registrados.   ~r~n" + &
					 "Si Ud. es Usuario del Sistema y No Recuerda su Clave, LLame al Administrador.")

			ls_error = "PC: " + str.maquina + " WinUser: " + str.win_user + " AppUser: " + &
						  str.usuario + " Aplic: " + str.aplicacion + " GF: " + &
						  string(str.g_financiero) + " Empr: " + string(str.empresa)
						  
			ldt_fecha = gf_fecha_serv()
					 
		  INSERT INTO dgterror  
		         ( erro_aplica,   
		           erro_usuario,   
		           erro_fecha,   
		           erro_programa,   
		           erro_tipo )  
		  VALUES ( :str.aplicacion,   
		           :str.usuario,   
		           :ldt_fecha,   
		           :ls_error,   
		           'SS' )  ;
			if sqlca.sqlcode = -1 then
				rollback ;
				messagebox("Atención Sr. Usuario","Error al Insertar en Tabla de Error "+sqlca.sqlerrtext)
				return
			end if					  
					  
			Commit;
					 
			Return
		Else
	  		Mensaje("Error 3","Clave Incorrecta","Intentelo Nuevamente Le Restan " + &
	  				 String(3 - ii_intentos) + " Oportunidades.~r~n~n" + sqlca.sqlerrtext)
			Return
		End If
	  	sle_clave.SetFocus()
	  	SelectText(sle_clave, 1, len(sle_clave.text))
		RETURN
   END IF

wf_accesos()

// Cargo el nombre del Host y busco el ini

/* Favor de evaluar datos de la coneccion a la base de datos 04/OCT/1999 */

ls_host = "appname='Harr2000-"+gf_app_name(str.aplicacion)+"',host='"+str.win_user+&
           "'"+",PacketSize=1024,MaxConnect=100,CursorUpdate=1,OptSelectBlob=1,StaticBind=0"
sqlca.dbparm = ls_host

/*   04/OCT/1999 */

If ge_environment.OsType = windows! Then
//	SetProfileString(str.path, "HARR2000", "DbParm", ls_host)
ElseIf ge_environment.OsType = windowsnt! Then
//	SetProfileString(str.path, "HARR2000-NT", "DbParm", ls_host)
End If

// Carga nuevamente str.path con el directorio final de la path, el cual debe ser
// el directorio raíz de nuestra aplicación HARR2000.
gf_find_path(str.path)

/* 22/mayo/2000 (1) */
//DISCONNECT USING SQLCA;
//if sqlca.sqlcode = -1 then
//	mensaje("Aviso","Error al Desconectar - Conectar de la Base de Datos.",sqlca.sqlerrtext)
//	halt close	
//else
//	CONNECT USING SQLCA;
//	if sqlca.sqlcode = -1 then
//		mensaje("Aviso","Error al Conectar - Conectar de la Base de Datos.",sqlca.sqlerrtext)
//		halt close	
//	end if
//end if
/* 22/mayo/2000 (1) comentarios por revision de Cibernetica para hacer el acceso mas rapido */
SELECT dgmaplica.apli_icono
  INTO :str.icono  
  FROM dgmaplica  
 WHERE dgmaplica.apli_aplicacion = :str.aplicacion   ;
 if sqlca.sqlcode = -1 then
	mensaje("Aviso","Error al Seleccionar el Icono del Sistema",sqlca.sqlerrtext)
 end if
	
str.icono = str.path + str.icono


If Not(ib_que) Then
	OpenWithParm(w_cambiar_clave, is_frame)
Else	
	//Buscar el error de que no está la librería asociada, y que no rompa
	wf_regedit()
	Open(str.frame,is_frame)
End If

// Cierro la ventana de espera
Close(w_espere)

//If ib_auto And IsValid(w_presentacion) Then Close(w_presentacion)
if (str.aplicacion = 'Acceso no Permitido' ) then
	THIS.Show()
else 
	This.TriggerEvent(Close!)
end if
end event

event ue_cambiar;call super::ue_cambiar;This.TriggerEvent("ue_login")
end event

public subroutine wf_accesos ();Integer		li_sqlcode, li_i = 1
String		ls_array[]

/* Eliminado para evitar bloqueos, Pendiente correccion // 04/10/1999 // */

//
//
//If UpperBound(str.menus[]) > 0 Then str.menus[] = ls_array[]
//If UpperBound(str.ventanas[]) > 0 Then str.ventanas[] = ls_array[]
//	
//DECLARE cur_menu CURSOR FOR  						// Declaro el Cursor
//  SELECT ssmacceso.acce_menu_item,   
//         ssmacceso.acce_ventana  
//    FROM ssmacceso,   
//         ssmmenu 
//   WHERE ( ssmmenu.menu_cod_menu = ssmacceso.acce_cod_menu ) and  
//         ( ssmmenu.menu_item = ssmacceso.acce_menu_item ) and  
//         ( ssmmenu.menu_aplicacion = ssmacceso.acce_aplicacion ) and  
//         ( ( ssmacceso.acce_acceso = 'N' ) AND  
//         ( ssmacceso.acce_id_grupo = :str.grupo ) )   ;
//			
//Open cur_menu;											// Abro el Cursor
//FETCH cur_menu INTO :str.menus[li_i], :str.ventanas[li_i] ; 
//
//li_sqlcode = sqlca.sqlcode							// Verifico el sqlcode
//
//DO WHILE li_sqlcode = 0								// Cargo el arreglo de la estructura usuario
//	li_i++
//	FETCH cur_menu INTO :str.menus[li_i], :str.ventanas[li_i] ;
//	li_sqlcode = sqlca.sqlcode
//LOOP
//
//Close cur_menu;										// Cierro el Cursor

end subroutine

public function boolean wf_extremo ();/* Bloqueado hasta establecer su uso real y nueva clave de acceso */

//IF str.comando = "AdminHARR" THEN
//	
//	gf_find_path(str.path)
//	
//	// Abro la ventana frame de seguridad
//	Open(str.frame, "w_ss_frame")
//	str.frame.Title = "SISTEMA DE EMERGENCIA EXTREMA"
//	
//	// Cierro la ventana de espera
//	Close(w_espere)
//	
//	// Cierro esta Ventana
//	This.TriggerEvent(Close!)
//	
//	Return True
//END IF
//
Return False
end function

public subroutine wf_regedit ();If ge_environment.OsType = windows! Then	
		/*Ultimo Usuario del Sistema, para desplegar en la clave de acceso*/
		if RegistrySet( &
			"HKEY_LOCAL_MACHINE\Config\ HAUsuario", &
			"Usuario", RegString!, str.usuario) = -1 then
			mensaje("Aviso","Error al Registrar el Ultimo Usuario ",sqlca.sqlerrtext)
		end if

		/*Usuario del Sistema para la aplicacion en donde entro*/
		if RegistrySet( &
			"HKEY_LOCAL_MACHINE\Config\ HAppl\Acceso"+str.aplicacion, &
			"Usuario", RegString!, str.usuario) = -1 then
			mensaje("Aviso","Error al Registrar el Usuario ",sqlca.sqlerrtext)
		end if
		/*Aplicacion*/
		if RegistrySet( &
			"HKEY_LOCAL_MACHINE\Config\ HAppl\Acceso"+str.aplicacion, &
			"Aplicacion", RegString!, str.aplicacion) = -1 then
			mensaje("Aviso","Error al Registrar la Aplicacion ",sqlca.sqlerrtext)
		end if			
		
		/*Grupo Financiero*/
		if RegistrySet( &
			"HKEY_LOCAL_MACHINE\Config\ HAppl\Acceso"+str.aplicacion, &
			"Str_grupo", RegString!, string(str.g_financiero)) = -1 then
			mensaje("Aviso","Error al Registrar el grupo Financiero ",sqlca.sqlerrtext)
		end if
		/*Empresa*/	
		if RegistrySet( &
			"HKEY_LOCAL_MACHINE\Config\ HAppl\Acceso"+str.aplicacion, &
			"Str_empresa", RegString!, string(str.empresa)) = -1 then
			mensaje("Aviso","Error al Registrar la Empresa ",sqlca.sqlerrtext)
		end if
			
		/*Usuario de Windows*/	
		if RegistrySet( &
			"HKEY_LOCAL_MACHINE\Config\ HAppl\Acceso"+str.aplicacion, &
			"Str_WinUser", RegString!, str.win_user) = -1 then
			mensaje("Aviso","Error al Registrar el Usuario ",sqlca.sqlerrtext)
		end if
		/*Para que pueda entrar el usuario*/			
		if RegistrySet( &
			"HKEY_LOCAL_MACHINE\Config\ HAppl\Acceso"+str.aplicacion, &
			"Entrar", RegString!, '1') = -1 then
			mensaje("Aviso","Error al Registrar la Autorización de Entrada ",sqlca.sqlerrtext)
		end if				
else	//si es NT
	/*Ultimo Usuario del Sistema, para desplegar en la clave de acceso*/
	if RegistrySet( &
		"HKEY_LOCAL_MACHINE\SOFTWARE\Config\ HAUsuario", &
		"Usuario", RegString!, str.usuario) = -1 then
		mensaje("Aviso","Error al Registrar el Ultimo Usuario ",sqlca.sqlerrtext)
	end if	
	/*Usuario del Sistema para la aplicacion en donde entro*/
	if RegistrySet( &
		"HKEY_LOCAL_MACHINE\SOFTWARE\Config\ HAppl\Acceso"+str.aplicacion, &
		"Usuario", RegString!, str.usuario) = -1 then
		mensaje("Aviso","Error al Registrar el Usuario ",sqlca.sqlerrtext)
	end if
	/*Aplicacion*/
	if RegistrySet( &
		"HKEY_LOCAL_MACHINE\SOFTWARE\Config\ HAppl\Acceso"+str.aplicacion, &
		"Aplicacion", RegString!, str.aplicacion) = -1 then
		mensaje("Aviso","Error al Registrar la Aplicacion ",sqlca.sqlerrtext)
	end if
	/*Grupo Financiero*/		
	if RegistrySet( &
		"HKEY_LOCAL_MACHINE\SOFTWARE\Config\ HAppl\Acceso"+str.aplicacion, &
		"Str_grupo", RegString!, string(str.g_financiero)) = -1 then
		mensaje("Aviso","Error al Registrar el grupo Financiero ",sqlca.sqlerrtext)
	end if
	/*Empresa*/	
	if RegistrySet( &
		"HKEY_LOCAL_MACHINE\SOFTWARE\Config\ HAppl\Acceso"+str.aplicacion, &
		"Str_empresa", RegString!, string(str.empresa)) = -1 then
		mensaje("Aviso","Error al Registrar la Empresa ",sqlca.sqlerrtext)
	end if
	/*Usuario de Windows*/			
	if RegistrySet( &
		"HKEY_LOCAL_MACHINE\SOFTWARE\Config\ HAppl\Acceso"+str.aplicacion, &
		"Str_WinUser", RegString!, str.win_user) = -1 then
		mensaje("Aviso","Error al Registrar el Usuario ",sqlca.sqlerrtext)
	end if
	/*Para que pueda entrar el usuario*/			
	if RegistrySet( &
		"HKEY_LOCAL_MACHINE\SOFTWARE\Config\ HAppl\Acceso"+str.aplicacion, &
		"Entrar", RegString!, '1') = -1 then
		mensaje("Aviso","Error al Registrar la Autorización de Entrada ",sqlca.sqlerrtext)
	end if		
end if
end subroutine

public function string wf_asigna_ultimo_usuario ();//Función que recupera el ultimo usuario que en tro a la aplicacion y lo despliega en la cleve de acceso
string ls_usuario
If ge_environment.OsType = windows! Then	
		/*Ultimo Usuario del Sistema, para desplegar en la clave de acceso*/
		if RegistryGet( &
			"HKEY_LOCAL_MACHINE\Config\ HAUsuario", &
			"Usuario", RegString!, ls_usuario) = -1 then
			//mensaje("Aviso","Error al Recuparar el Ultimo Usuario ",sqlca.sqlerrtext)
		end if
	else
		/*Ultimo Usuario del Sistema, para desplegar en la clave de acceso*/
		if RegistryGet( &
			"HKEY_LOCAL_MACHINE\SOFTWARE\Config\ HAUsuario", &
			"Usuario", RegString!, ls_usuario) = -1 then
			//mensaje("Aviso","Error al Recuperar el Ultimo Usuario ",sqlca.sqlerrtext)
		end if		
	end if
	
	return ls_usuario
end function

event ue_close;ib_adios = true
This.TriggerEvent(close!)
end event

on w_clave.create
int iCurrent
call super::create
this.sle_clave=create sle_clave
this.sle_usuario=create sle_usuario
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.gb_1=create gb_1
this.st_windows=create st_windows
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_clave
this.Control[iCurrent+2]=this.sle_usuario
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_4
this.Control[iCurrent+8]=this.cb_3
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.st_windows
this.Control[iCurrent+11]=this.cb_2
end on

on w_clave.destroy
call super::destroy
destroy(this.sle_clave)
destroy(this.sle_usuario)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.gb_1)
destroy(this.st_windows)
destroy(this.cb_2)
end on

event ue_init;String	usuario, maquina
Long		ll_size = 255


// Si str.path no contiene el archivo ini se le agrega
If Right(str.path, 1) = "\" Then str.path += "harr.ini"

is_nombre = This.ClassName()

st_window_name.text = is_nombre
st_window_name.width = len(st_window_name.text) * 35


maquina = space(ll_size)

uo_sdk_func.uf_get_logon_name(usuario)
GetComputerNameA(maquina, ll_size)


If ge_environment.OsType = windows! Then
If Len(Trim(usuario)) > 0 Then &
	st_windows.text = 'Usuario de Windows: '+Upper(usuario)
ElseIf ge_environment.OsType = windowsnt! Then
If Len(Trim(usuario)) > 0 Then &
	st_windows.text = 'Usuario de Windows NT: '+Upper(usuario)
End If

str.win_user = usuario
str.maquina  = maquina

//Para Asignar el ultimo usuario que entro a la aplicacion de consultas de ventas
sle_usuario.text = wf_asigna_ultimo_usuario()

If len(sle_usuario.text) > 0 Then sle_clave.SetFocus()

end event

event open;call super::open;If Message.StringParm = "No Password" Then	
	This.hide()
//	OpenWithParm(w_presentacion, "No Password")
	ib_auto = true
	This.PostEvent("ue_login")
End If

gf_center_win(this)

f_create_external_func_uo (uo_sdk_func)

st_window_name.hide()

timer(1)
//io_encryptor = Create nv_encryptor
//io_encryptor.of_setkey("HwGm")
end event

event closequery;//Destroy io_encryptor

//If ib_adios Then
//	is_ruta = str.path
//	gf_find_path(is_ruta)
//	is_ruta += "art\sonidos\"
//	uo_sdk_func.uf_playsound(is_ruta + "adios.wav" , 0)
//End If
//
commit;

end event

event key;call super::key;If KeyDown(KeyEscape!) Then This.TriggerEvent("ue_close")
end event

event timer;string ld_df[]

il_time ++

if il_time > 60 and this.visible  then
	this.postevent("close")
end if

//ii_bugs++
//ii_bugs2++
//
//ld_df[1] = '                 Esp'
//ld_df[2] = '              Espere'
//ld_df[3] = '           Espere un'
//ld_df[4] = '        Espere un mo'
//ld_df[5] = '     Espere un momen'
//ld_df[6] = '   Espere un momento'
//ld_df[7] = 'Espere un momento...'
//ld_df[8] = 'ere un momento...   '
//ld_df[9] = ' un momento...      '
//ld_df[10]= 'momento...          '
//ld_df[11]= 'nto...              '
//ld_df[12]= '.                   '
//ld_df[13]= '                    '
//// Espere un momento... 
//If ii_bugs <= 6 Then
//	w_espere.p_1.picturename = s_path  + String(ii_bugs) + '.bmp'
//Else
//	ii_bugs = 1
//	w_espere.p_1.picturename = s_path  + String(ii_bugs) + '.bmp'	
//End If
//
//If ii_bugs2 <= 13 Then
//		w_espere.st_1.text = ld_df[ii_bugs2]
//	If ii_bugs2 <= 6 Then
//		w_espere.st_1.Alignment= right!
//	else
//		w_espere.st_1.Alignment  = left!
//	end if
//else
//	ii_bugs2 = 0
//
//if  ii_bugs3	<= 0 then
//	ii_bugs3	= 1
//	st_1.y =  456
//else
//	ii_bugs3	= 0
//	 st_1.y =  140   //456
//end if
//
//end if
//
//// yield()
//
end event

type st_msghlp from w_a`st_msghlp within w_clave
integer taborder = 10
end type

type st_window_name from w_a`st_window_name within w_clave
end type

type sle_clave from singlelineedit within w_clave
integer x = 622
integer y = 356
integer width = 750
integer height = 92
integer taborder = 30
integer textsize = -12
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Bookman Old Style"
boolean italic = true
long backcolor = 16777215
boolean autohscroll = false
boolean password = true
borderstyle borderstyle = stylelowered!
end type

event modified;il_time = 1
end event

type sle_usuario from singlelineedit within w_clave
integer x = 617
integer y = 216
integer width = 750
integer height = 92
integer taborder = 20
integer textsize = -12
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Bookman Old Style"
boolean italic = true
long backcolor = 16777215
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event getfocus;SelectText(this, 1, len(this.text))
il_time = 1
end event

type st_3 from statictext within w_clave
integer x = 73
integer y = 340
integer width = 498
integer height = 116
integer textsize = -18
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Bookman Old Style"
long backcolor = 79741120
boolean enabled = false
string text = "Clave"
boolean focusrectangle = false
end type

type st_2 from statictext within w_clave
integer x = 73
integer y = 208
integer width = 498
integer height = 116
integer textsize = -18
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Bookman Old Style"
long backcolor = 79741120
boolean enabled = false
string text = "Usuario"
boolean focusrectangle = false
end type

type st_1 from statictext within w_clave
integer x = 46
integer y = 28
integer width = 1330
integer height = 148
integer textsize = -20
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Bookman Old Style"
boolean italic = true
long backcolor = 79741120
boolean enabled = false
string text = "Acceso a HARR2000"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_1 from u_cb_close within w_clave
integer x = 1536
integer y = 308
integer width = 352
integer height = 96
integer taborder = 60
boolean bringtotop = true
end type

event clicked;close(parent)
end event

type cb_4 from u_cb_run_away within w_clave
boolean visible = false
integer x = 1531
integer y = 152
integer width = 352
integer height = 96
integer taborder = 0
string text = "&Aceptar"
end type

event clicked;call super::clicked;ib_adios = true
end event

type cb_3 from commandbutton within w_clave
integer x = 1531
integer y = 152
integer width = 352
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Aceptar"
boolean default = true
end type

event clicked;ib_que = true
il_time= 1
Parent.TriggerEvent("ue_login")
end event

type gb_1 from groupbox within w_clave
integer x = 1477
integer y = 72
integer width = 462
integer height = 452
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
end type

type st_windows from statictext within w_clave
integer x = 73
integer y = 508
integer width = 1371
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Bookman Old Style"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_clave
boolean visible = false
integer x = 1531
integer y = 272
integer width = 352
integer height = 96
integer taborder = 50
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "C&ambiar"
end type

event clicked;ib_que = false

Parent.TriggerEvent("ue_cambiar")
end event

