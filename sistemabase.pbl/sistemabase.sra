//objectcomments Generated Application Object
forward
global type sistemabase from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
s_user_session gstr_session
str_general str
end variables

global type sistemabase from application
string appname = "sistemabase"

string themepath = "C:\Program Files (x86)\Appeon\PowerBuilder 25.0\IDE\theme"
string themename = "Flat Design Blue"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 5
long richtexteditx64type = 5
long richtexteditversion = 3
string richtexteditkey = ""
string appicon = ""
string appruntimeversion = "25.1.0.6430"
boolean manualsession = false
boolean unsupportedapierror = false
boolean ultrafast = false
boolean bignoreservercertificate = false
uint ignoreservercertificate = 0
long webview2distribution = 0
boolean webview2checkx86 = false
boolean webview2checkx64 = false
string webview2url = "https://developer.microsoft.com/en-us/microsoft-edge/webview2/"
end type
global sistemabase sistemabase

type prototypes

end prototypes

on sistemabase.create
appname="sistemabase"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on sistemabase.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;// Profile Tempo
SQLCA.DBMS = "MSOLEDBSQL SQL Server"
SQLCA.LogPass = "Temposql$"
SQLCA.ServerName = "SQLSERVER-MAIN\SQLSERVER"
SQLCA.LogId = "sa"
SQLCA.AutoCommit = False
SQLCA.DBParm = "Provider='MSOLEDBSQL19',Database='Tempo'"
CONNECT;

if SQLCA.SQLCode <> 0 then
    MessageBox("Error de Conexión", "No se pudo conectar a la base de datos: " + SQLCA.SQLErrText, StopSign!)
    Halt Close
end if


// 2. Abrir la pantalla de Login como punto de entrada
Open(w_login_modern)
//open(w_dashboard)
end event

