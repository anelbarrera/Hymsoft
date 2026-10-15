forward
global type w_cambiar_clave from w_a
end type
type sle_new from singlelineedit within w_cambiar_clave
end type
type sle_old from singlelineedit within w_cambiar_clave
end type
type st_3 from statictext within w_cambiar_clave
end type
type st_2 from statictext within w_cambiar_clave
end type
type st_1 from statictext within w_cambiar_clave
end type
type cb_1 from u_cb_close within w_cambiar_clave
end type
type cb_3 from u_cb_run_away within w_cambiar_clave
end type
type sle_check from singlelineedit within w_cambiar_clave
end type
type st_4 from statictext within w_cambiar_clave
end type
type cb_2 from u_cb_aceptar within w_cambiar_clave
end type
type gb_1 from groupbox within w_cambiar_clave
end type
end forward

global type w_cambiar_clave from w_a
int Height=812
boolean TitleBar=true
string Title="Cambiar Clave"
long BackColor=79741120
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event ue_login pbm_custom13
event ue_cambiar pbm_custom14
sle_new sle_new
sle_old sle_old
st_3 st_3
st_2 st_2
st_1 st_1
cb_1 cb_1
cb_3 cb_3
sle_check sle_check
st_4 st_4
cb_2 cb_2
gb_1 gb_1
end type
global w_cambiar_clave w_cambiar_clave

type variables
Int ii_intentos
String is_frame
//nv_encryptor io_encryptor
end variables

forward prototypes
public subroutine wf_accesos ()
end prototypes

public subroutine wf_accesos ();Integer		li_sqlcode, li_i = 1


	
DECLARE cur_menu CURSOR FOR  						// Declaro el Cursor
  SELECT "acceso"."menu_item"  
    FROM "acceso"  
   WHERE ( "acceso"."id_grupo" = :str.grupo ) AND  
         ( "acceso"."acceso" = 'N' )   ;

Open cur_menu;											// Abro el Cursor
FETCH cur_menu INTO :str.menus[li_i] ; 

li_sqlcode = sqlca.sqlcode							// Verifico el sqlcode

DO WHILE li_sqlcode = 0								// Cargo el arreglo de la estructura usuario
	li_i++
	FETCH cur_menu INTO :str.menus[li_i] ;
	li_sqlcode = sqlca.sqlcode
LOOP

Close cur_menu;										// Cierro el Cursor

end subroutine

event ue_close;This.TriggerEvent(close!)
end event

on w_cambiar_clave.create
int iCurrent
call super::create
this.sle_new=create sle_new
this.sle_old=create sle_old
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_3=create cb_3
this.sle_check=create sle_check
this.st_4=create st_4
this.cb_2=create cb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_new
this.Control[iCurrent+2]=this.sle_old
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_3
this.Control[iCurrent+8]=this.sle_check
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.cb_2
this.Control[iCurrent+11]=this.gb_1
end on

on w_cambiar_clave.destroy
call super::destroy
destroy(this.sle_new)
destroy(this.sle_old)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.sle_check)
destroy(this.st_4)
destroy(this.cb_2)
destroy(this.gb_1)
end on

event ue_aceptar;String ls_new_encrypt


//If sle_old.text <> gf_decrypt(str.clave, "HwGm") Then
//If io_encryptor.of_set(sle_old.text) <> str.clave Then
If sle_old.text <> str.clave Then
	sle_old.SetFocus()
	SelectText(sle_old, 1, len(sle_old.text))
	Mensaje("Aviso", "La Clave es Incorrecta", "")
	Return
End If

If Len(Trim(sle_new.text)) < 1 Then
	sle_new.SetFocus()
	SelectText(sle_new, 1, len(sle_new.text))
	Mensaje("Aviso", "Debe Colocar una Palabra Clave", "")
	Return
End If

If sle_new.text <> sle_check.text Then
	sle_new.SetFocus()
	SelectText(sle_new, 1, len(sle_new.text))
	Mensaje("Aviso", "La Nueva Clave Concuerda con la Validación", "")
	Return
End If

//ls_new_encrypt = io_encryptor.of_set(sle_new.text)	
ls_new_encrypt = sle_new.text	

  UPDATE ssmusuar  
     SET usua_clave = :ls_new_encrypt
   WHERE ( ssmusuar.usua_id = :str.usuario ) AND  
         ( ssmusuar.usua_clave = :str.clave )   ;

str.clave = ls_new_encrypt

If sqlca.sqlcode <> 0 Then
	Mensaje("Error", "No se Logro Guardar el Cambio de la Clave.", sqlca.sqlerrtext)
	Return
Else
	Commit using Sqlca;
End If

Mensaje("Aviso", "Clave Cambiada Exitosamente.", "")

Open(str.frame,is_frame)

This.TriggerEvent(Close!)
end event

event open;call super::open;is_frame = Message.StringParm

gf_center_win(this)

st_window_name.hide()

//io_encryptor = Create nv_encryptor
//io_encryptor.of_setkey("HwGm")
end event

event ue_init;is_nombre = This.ClassName()

st_window_name.text = is_nombre
st_window_name.width = len(st_window_name.text) * 35
end event

event closequery;//Destroy io_encryptor
end event

type sle_new from singlelineedit within w_cambiar_clave
int X=626
int Y=428
int Width=750
int Height=92
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
long BackColor=16777215
int TextSize=-12
int Weight=400
string FaceName="Bookman Old Style"
boolean Italic=true
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type sle_old from singlelineedit within w_cambiar_clave
int X=626
int Y=292
int Width=750
int Height=92
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
long BackColor=16777215
int TextSize=-12
int Weight=400
string FaceName="Bookman Old Style"
boolean Italic=true
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_cambiar_clave
int X=73
int Y=416
int Width=498
int Height=116
boolean Enabled=false
string Text="Nueva"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-18
int Weight=400
string FaceName="Bookman Old Style"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_cambiar_clave
int X=73
int Y=280
int Width=498
int Height=116
boolean Enabled=false
string Text="Antigüa"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-18
int Weight=400
string FaceName="Bookman Old Style"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_cambiar_clave
int X=119
int Y=40
int Width=1211
int Height=148
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Cambiar Clave"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-20
int Weight=400
string FaceName="Bookman Old Style"
boolean Italic=true
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type cb_1 from u_cb_close within w_cambiar_clave
int X=1531
int Y=500
int TabOrder=50
boolean BringToTop=true
end type

type cb_3 from u_cb_run_away within w_cambiar_clave
int X=1531
int Y=376
int TabOrder=60
boolean Visible=false
string Text="&Aceptar"
boolean Default=true
end type

type sle_check from singlelineedit within w_cambiar_clave
int X=626
int Y=564
int Width=750
int Height=92
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
long BackColor=16777215
int TextSize=-12
int Weight=400
string FaceName="Bookman Old Style"
boolean Italic=true
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_cambiar_clave
int X=73
int Y=552
int Width=498
int Height=116
boolean Enabled=false
string Text="Verifica"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-18
int Weight=400
string FaceName="Bookman Old Style"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type cb_2 from u_cb_aceptar within w_cambiar_clave
int X=1531
int Y=376
int TabOrder=40
boolean BringToTop=true
boolean Default=true
end type

type gb_1 from groupbox within w_cambiar_clave
int X=1477
int Y=316
int Width=462
int Height=316
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

