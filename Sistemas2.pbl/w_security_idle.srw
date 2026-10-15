forward
global type w_security_idle from w_a
end type
type st_1 from statictext within w_security_idle
end type
type sle_1 from singlelineedit within w_security_idle
end type
type gb_2 from groupbox within w_security_idle
end type
type gb_1 from groupbox within w_security_idle
end type
type cb_1 from u_cb_aceptar within w_security_idle
end type
type cb_2 from u_cb_cancelar within w_security_idle
end type
type cb_3 from u_cb_close within w_security_idle
end type
type cb_4 from u_cb_run_away within w_security_idle
end type
end forward

global type w_security_idle from w_a
int Width=1577
int Height=756
WindowType WindowType=response!
boolean TitleBar=true
string Title="Verificación del Usuario "
long BackColor=79741120
boolean ControlMenu=false
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event ue_cancelar pbm_custom16
st_1 st_1
sle_1 sle_1
gb_2 gb_2
gb_1 gb_1
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
end type
global w_security_idle w_security_idle

type variables
Integer ii_intentos
end variables

event ue_cancelar;str.idle = 'T'

str.frame.WindowState = Minimized!
This.WindowState = Minimized!

CloseWithReturn(This, str.idle)
end event

event ue_close;call super::ue_close;Halt Close
end event

on w_security_idle.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_1=create sle_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cb_3
this.Control[iCurrent+8]=this.cb_4
end on

on w_security_idle.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
end on

event open;call super::open;//Herick

gf_center_win(this)

This.Title += Upper(str.usuario)
end event

event ue_init;call super::ue_init;st_1.text = str.nombre + " " + str.apellido
end event

event ue_aceptar;String   ls_error, ls_clave
DateTime ldt_fecha
//nv_encryptor lo_encryptor


If Len(String(sle_1.Text)) <= 0 Then
	Mensaje("Información","Verifique que Ud. Introdujo su Clave.","Intentelo Nuevamente!")
	Return
End If

ii_intentos++

//lo_encryptor = Create nv_encryptor

//ls_clave = lo_encryptor.of_set(sle_1.Text, "HwGm")
ls_clave = sle_1.Text

//Destroy lo_encryptor

If str.clave <> ls_clave Then
	
   IF ii_intentos >= 3 THEN 
	   cb_1.visible = false
	   cb_4.visible = true
		cb_2.enabled = false
   END IF
  
	If 3 - ii_intentos = 1 Then
		Mensaje("Error","Clave Incorrecta","Intentelo Nuevamente Le Resta " + &
				 String(3 - ii_intentos) + " Oportunidad.~r~n~n" + sqlca.sqlerrtext)
		Return
	ElseIf 3 - ii_intentos = 0 Then
		Mensaje("Error","Clave Incorrecta","No Logro Pasar la Seguridad.   ~r~n" + &
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
			Commit;
					 
			Return
		Else
	  		Mensaje("Error","Clave Incorrecta","Intentelo Nuevamente Le Restan " + &
	  				 String(3 - ii_intentos) + " Oportunidades.~r~n~n" + sqlca.sqlerrtext)
			Return
		End If
Else
	str.frame.WindowState = Maximized!
	str.idle = 'F'
	CloseWithReturn(This, str.idle)
End If
end event

event close;//Override
end event

type st_window_name from w_a`st_window_name within w_security_idle
int X=37
end type

type st_1 from statictext within w_security_idle
int X=73
int Y=88
int Width=1394
int Height=108
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=16777215
int TextSize=-14
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_security_idle
int X=73
int Y=312
int Width=1394
int Height=108
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
long TextColor=8388608
int TextSize=-14
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_security_idle
int X=37
int Y=244
int Width=1467
int Height=208
int TabOrder=50
string Text="Clave"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_security_idle
int X=37
int Y=20
int Width=1467
int Height=208
int TabOrder=60
string Text="Usuario"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from u_cb_aceptar within w_security_idle
int X=393
int Y=480
int TabOrder=40
boolean BringToTop=true
boolean Default=true
end type

type cb_2 from u_cb_cancelar within w_security_idle
int X=773
int Y=480
int TabOrder=30
boolean BringToTop=true
string Text="Ca&ncelar"
end type

type cb_3 from u_cb_close within w_security_idle
int X=1152
int Y=480
int TabOrder=20
boolean BringToTop=true
end type

type cb_4 from u_cb_run_away within w_security_idle
int X=393
int Y=480
int TabOrder=11
boolean Visible=false
boolean BringToTop=true
string Text="&Aceptar"
end type

