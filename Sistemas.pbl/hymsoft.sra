//objectcomments HymSoft App
forward
global type hymsoft from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
//Datos Generales
str_general str
Environment ge_Environment
Boolean gb_expand = True

end variables

global type hymsoft from application
string appname = "hymsoft"
string microhelpdefault = "Sistema Hymsoft"
string displayname = "Sistema Hymsoft"

string themepath = "C:\Program Files (x86)\Appeon\PowerBuilder 25.0\IDE\theme"
string themename = "Flat Design Blue"
boolean nativepdfvalid = true
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 5
long richtexteditx64type = 5
long richtexteditversion = 3
string richtexteditkey = ""
string appicon = "C:\Sistemas\Hymsoft\Art\ICONO HYMOFT.ico"
string appruntimeversion = "25.1.0.6430"
boolean manualsession = false
boolean unsupportedapierror = true
boolean ultrafast = false
boolean bignoreservercertificate = true
uint ignoreservercertificate = 0
long webview2distribution = 0
boolean webview2checkx86 = false
boolean webview2checkx64 = false
string webview2url = "https://developer.microsoft.com/en-us/microsoft-edge/webview2/"
end type
global hymsoft hymsoft

type prototypes
FUNCTION boolean GetComputerNameA(ref string cname,ref long nbuf) LIBRARY "kernel32.dll" alias for "GetComputerNameA;Ansi"
Function Long OpenFpctrl( String IpPortName) LIBRARY "tfhkaif.dll" alias for "OpenFpctrl;Ansi"
Function Long CloseFpctrl( ) LIBRARY "tfhkaif.dll" alias for "CloseFpctrl;Ansi"
Function Long SendCmd ( ref long status, ref long error1, string cmd) LIBRARY "tfhkaif.dll" alias for "SendCmd;Ansi"
Function Long CheckFprinter ()  LIBRARY "tfhkaif.dll" alias for "CheckFprinter;Ansi"
Function Long UploadStatusDin (ref long  status, ref long error1, string cmd, ref string cadena) LIBRARY "tfhkaif.dll" alias for "UploadStatusDin;Ansi"
Function Long UploadReportCmdDin (ref long  status, ref long error_c, string cmd, ref string cadena) LIBRARY "tfhkaif.dll" alias for "UploadReportCmdDin;Ansi"
Function Long UploadStatusCmd (ref long  status, ref long error1, string cmd, ref string filereport) LIBRARY "tfhkaif.dll" alias for "UploadStatusCmd;Ansi" 
Function Long CopyFile (String lpExistingFileName, String lpNewFileName, Long bFailIfExists) Library "kernel32.dll" ALIAS FOR "CopyFileA;Ansi"

//TFHKADIR.dll
Function ULong GetCurrentDirectory(ULong nBufferLength, Ref String lpBuffer) Library "kernel32.dll" Alias for "GetCurrentDirectoryW"
Function Boolean SetCurrentDirectory(String lpPathName) Library "kernel32.dll" Alias for "SetCurrentDirectoryW"

 
end prototypes

type variables
u_external_function uo_sdk_func
string is_frame
string as_key = 'K#89mP$2vL0!qA8@7zW5tY1*uI3^oR4'
str_fa_param str_para
str_colores istr_colores
str_aplica_links str_aplica_links
window w_login

str_fa_producto strp
Integer	ii_controla_modificaciones
String	is_exclusivo_cliente
date idt_fecha_contabilidad
str_tr_param str_param
//str_cc_formatos str_formato1

uo_configuracion_regional uo_regional
end variables

forward prototypes
public subroutine af_idle ()
public subroutine af_find_ini ()
public function string af_encriptar (string as_password, string as_key, string as_ini_path)
public function string af_desencriptar (string as_encrypted_base64, string as_key)
public function string af_check_password (string as_file, string as_sector)
end prototypes

public subroutine af_idle ();str.idle = 'T'

//Open(w_security_idle, str.frame)

//str.idle = Message.StringParm

//If str.idle = 'T' Then af_idle()


end subroutine

public subroutine af_find_ini ();String	win, nombre, path
Int		value
u_external_function_win32 gu_ext_func


f_create_external_func_uo(gu_ext_func)

win = Space (60)
gu_ext_func.uf_GetWindowsDirectory(win, 60)
	
Destroy gu_ext_func


/* Valida si win es nulo */
if win = space(60) or isnull(win) then
	IF FileExists("c:\winnt35\win.ini") THEN
		win = "c:\winnt35"
	ELSEIF FileExists("c:\winnt\win.ini") THEN
		win = "c:\winnt"
	ELSEIF FileExists("c:\winnt.sbs\win.ini") THEN
		win = "c:\winnt"
	ELSEIF FileExists("c:\winnt4\win.ini") THEN
		win = "c:\winnt"
	ELSEIF FileExists("d:\winnt35\win.ini") THEN
		win = "d:\winnt35"
	ELSEIF FileExists("d:\winnt\win.ini") THEN
		win = "d:\winnt"
	ELSEIF FileExists("d:\winnt.sbs\win.ini") THEN
		win = "d:\winnt.sbs"
	ELSEIF FileExists("d:\winnt4\win.ini") THEN
		win = "d:\winnt4"
	elseIF FileExists("c:\windows\win.ini") THEN
		win = "c:\windows"
	elseIF FileExists("d:\windows\win.ini") THEN
		win = "d:\windows"		
	END IF
end if


// Coloco el formato de fecha utilizada por nuestra aplicación
//RegistrySet("HKEY_CURRENT_USER\Control Panel\International", "sShortDate", "dd/MM/yyyy")
//RegistrySet("HKEY_USERS\.Default\Control Panel\International", "sShortDate", "dd/MM/yyyy")
SetProfileString(win + "\win.ini", "intl", "sShortDate", "dd/MM/yyyy")

str.path = ProfileString(win + "\win.ini", "HYMSOFT", "ruta", "")

If Not FileExists(str.path) Then 
	gf_ini_get()	
	If Not FileExists(str.path) Then 
		value = GetFileOpenName("Seleccione el Archivo",  &
		+ path, nombre, "INI",  &
		+ "Archivo Inicialización (Harr.ini),Harr.Ini")
		str.path = path
		gf_ini_set()		
		SetProfileString(win + "\win.ini", "HARR2000", "ruta", path)
	end if
End If


end subroutine

public function string af_encriptar (string as_password, string as_key, string as_ini_path);// Parámetros:
//   string as_password (texto a encriptar)
//   string as_key      (cualquier frase o palabra, sin importar la longitud)
// Retorna: string

CrypterObject lnv_crypter
CoderObject   lnv_coder
Blob lblb_data, lblb_raw_key, lblb_aes_key, lblb_encrypted
String ls_encrypted_base64

lnv_crypter = CREATE CrypterObject
lnv_coder   = CREATE CoderObject

// 1. Derivar la clave a exactamente 32 bytes (AES-256) mediante SHA-256
lblb_raw_key = Blob(as_key, EncodingUTF8!)
lblb_aes_key = lnv_crypter.SHA(SHA256!, lblb_raw_key)

// 2. Encriptar los datos
lblb_data      = Blob(as_password, EncodingUTF8!)
lblb_encrypted = lnv_crypter.SymmetricEncrypt(AES!, lblb_data, lblb_aes_key)

// 3. Pasar a Base64
ls_encrypted_base64 = lnv_coder.Base64Encode(lblb_encrypted)

DESTROY lnv_crypter
DESTROY lnv_coder

RETURN ls_encrypted_base64

end function

public function string af_desencriptar (string as_encrypted_base64, string as_key);// Parámetros:
//   string as_encrypted_base64 (cadena cifrada leída del INI)
//   string as_key              (misma frase usada para encriptar)
// Retorna: string

CrypterObject lnv_crypter
CoderObject   lnv_coder
Blob lblb_raw_key, lblb_aes_key, lblb_encrypted, lblb_decrypted
String ls_password

IF IsNull(as_encrypted_base64) OR Trim(as_encrypted_base64) = "" THEN
    RETURN ""
END IF

lnv_crypter = CREATE CrypterObject
lnv_coder   = CREATE CoderObject

// 1. Recrear exactamente la misma clave de 32 bytes
lblb_raw_key = Blob(as_key, EncodingUTF8!)
lblb_aes_key = lnv_crypter.SHA(SHA256!, lblb_raw_key)

// 2. Decodificar Base64 a binario
lblb_encrypted = lnv_coder.Base64Decode(as_encrypted_base64)

// 3. Desencriptar usando la clave derivada
lblb_decrypted = lnv_crypter.SymmetricDecrypt(AES!, lblb_encrypted, lblb_aes_key)

// 4. Convertir a string
ls_password = String(lblb_decrypted, EncodingUTF8!)

DESTROY lnv_crypter
DESTROY lnv_coder

RETURN ls_password
end function

public function string af_check_password (string as_file, string as_sector);String ls_password,ls_pass,ls_encripted
 

ls_password = ProfileString (as_file, as_sector, "LogPass",  "")
ls_encripted = ProfileString (as_file, as_sector, "Encripted",  "")

Choose Case ls_encripted
	Case 'True'
		 ls_pass = af_desencriptar(ls_password,as_key)		 
		 Return ls_pass
	Case 'False'
		ls_pass = af_encriptar(ls_password,as_key,as_file)
		SetProfileString(as_file, as_sector, "LogPass", ls_pass)
		SetProfileString(as_file, as_sector, "Encripted", 'True')
		Return ls_password
	Case Else
End Choose








end function

on hymsoft.create
appname="hymsoft"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on hymsoft.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event close;DISCONNECT USING SQLCA;


end event

event systemerror;f_sys_error()
end event

event open;String	usuario, maquina, file, sector, ls_theme, ls_retorno,ls_pass,ls_key,ls_password
Long		ll_size = 255
 

//---- Aplicación NOMINA --------\\

sector = "Data" ; file = "NOM.ini"


ls_theme 	   = ProfileString (file, sector, "theme",  "")

if ls_theme <> 'Default' then
	applytheme('C:\Sistemas\Hymsoft\Theme\'+ls_theme)
end if

//Validar conexión driver nativo Sql Server
// Profile Tempo
ls_pass = ProfileString (file, sector, "LogPass",  "")
ls_pass = af_check_password(file,sector)
SQLCA.DBMS = ProfileString (file, sector, "DBMS",  "")
SQLCA.LogId = ProfileString (file, sector, "LogId",  "") 
SQLCA.LogPass = ls_pass
SQLCA.ServerName = ProfileString (file, sector, "ServerName",  "")
SQLCA.AutoCommit = False
SQLCA.DBParm = ProfileString (file, sector, "DBParm",  "")

Connect Using SQLCA;

if sqlca.sqlcode <> 0 then
	MessageBox ("Fallo durante la conexion a la Base de Datos ( "+sqlca.DBMS+" )",&
	"Debido a un problema se recibio el sig. mensaje:~r~n~n"+sqlca.sqlerrtext,StopSign!)
else

	is_frame  = "w_fa_frame"
	str.frame = w_fa_frame
	
	str.printer1 = ProfileString(str.path, "HYMSOFT", "impresora1", "")
	str.printer2 = ProfileString(str.path, "HYMSOFT", "impresora2", "")
	str.printer3 = ProfileString(str.path, "HYMSOFT", "impresora3", "")

	str.puerto = ProfileString(str.path, "HYMSOFT", "puerto", "")
	
	gf_find_path(str.path)

	maquina = space(ll_size)
	
	f_create_external_func_uo (uo_sdk_func)
	
	uo_sdk_func.uf_get_logon_name(usuario)
	GetComputerNameA(maquina, ll_size)
	
	str.maquina = maquina
	str.win_user= usuario
	
  if gf_busca_datos_usuario() = -1 then halt close
 	//Open(str.frame,is_frame)	 
	Open(w_hs_frame,'w_hs_frame')	 	
	// open(w_frame_outlook)
  end if

//	uo_regional = create uo_configuracion_regional 
//	
//	uo_regional.of_getvalores()
//	uo_regional.of_setvalores()
//		
//	//gf_fa_param()		//Carga la estructura de Facturacion
//	open(w_acceso)
//	
//	ls_retorno = message.stringparm
//	
//	if ls_retorno <> 'OK' then
//		halt close
//	end if
//	
//	open(w_main)

//end if
end event

