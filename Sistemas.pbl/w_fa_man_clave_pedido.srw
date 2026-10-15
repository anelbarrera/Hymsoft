//objectcomments Para la Validación de la Clave del Usuario
forward
global type w_fa_man_clave_pedido from w_fa_padre
end type
type gb_1 from groupbox within w_fa_man_clave_pedido
end type
type st_1 from statictext within w_fa_man_clave_pedido
end type
type sle_1 from singlelineedit within w_fa_man_clave_pedido
end type
type cb_1 from commandbutton within w_fa_man_clave_pedido
end type
type cb_2 from commandbutton within w_fa_man_clave_pedido
end type
type st_2 from statictext within w_fa_man_clave_pedido
end type
type em_user from editmask within w_fa_man_clave_pedido
end type
end forward

global type w_fa_man_clave_pedido from w_fa_padre
int Width=1125
int Height=648
WindowType WindowType=response!
boolean TitleBar=true
string Title="Clave"
long BackColor=79741120
boolean ControlMenu=false
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event ue_postopen ( )
gb_1 gb_1
st_1 st_1
sle_1 sle_1
cb_1 cb_1
cb_2 cb_2
st_2 st_2
em_user em_user
end type
global w_fa_man_clave_pedido w_fa_man_clave_pedido

type variables
//nv_encryptor io_encryptor
window iw_window
end variables

event ue_postopen;//io_encryptor = Create nv_encryptor
//io_encryptor.of_setkey("ReMe")

iw_window = message.PowerObjectParm

em_user.Setfocus()

this.Setredraw(true)
end event

event open;call super::open;this.Setredraw(false)
gf_center_win(this)
this.postevent("ue_postopen")
end event

on w_fa_man_clave_pedido.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.em_user=create em_user
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.sle_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.em_user
end on

on w_fa_man_clave_pedido.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.em_user)
end on

event key;//Override

end event

event closequery;call super::closequery;//destroy io_encryptor
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_man_clave_pedido
int X=18
int Y=644
boolean Visible=false
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_man_clave_pedido
int X=78
int Y=136
int Width=69
int Height=36
int TabOrder=10
boolean Visible=false
end type

type st_ayuda from w_fa_padre`st_ayuda within w_fa_man_clave_pedido
boolean BringToTop=true
end type

type gb_1 from groupbox within w_fa_man_clave_pedido
int X=14
int Width=1079
int Height=544
string Text="Introduzca la Clave de Autorización"
BorderStyle BorderStyle=StyleLowered!
long TextColor=8388608
long BackColor=67108864
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_fa_man_clave_pedido
int X=187
int Y=240
int Width=297
int Height=80
boolean Enabled=false
boolean BringToTop=true
string Text="Clave:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-14
int Weight=700
string FaceName="Calisto MT"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_fa_man_clave_pedido
int X=535
int Y=236
int Width=343
int Height=100
int TabOrder=30
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
long TextColor=33554432
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_fa_man_clave_pedido
int X=192
int Y=396
int Width=311
int Height=108
int TabOrder=40
boolean BringToTop=true
string Text="Aceptar"
boolean Default=true
int TextSize=-10
int Weight=700
string FaceName="Times New Roman"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

event clicked;string  ls_clave
integer li_ok = 0

if sle_1.Text = '*' then 	  // No puede asignar un '*' como clave, ya que es un codigo para
	gf_mensaje("","Verifique la Clave, Asigne Otra.",1,1,"E") // identificar el cancelar de la ventana
	return
else

	ls_clave = sle_1.text
	
		  SELECT count(*)  
			 INTO :li_ok  
			 FROM faempbod  
			WHERE ( faempbod.faem_g_financiero = :str.g_financiero ) AND  
					( faempbod.faem_empresa = :str.empresa ) AND  
					( faempbod.faem_bod_usuario = :em_user.text ) AND  
					( faempbod.faem_clave = :ls_clave ) AND  
					( faempbod.faem_autoriza_aprobacion = 'S' )   ;
					
			if sqlca.sqlcode = -1 then
				gf_mensaje("","Error al Verificar Clave de Usuario "+sqlca.sqlerrtext,1,1,"E")
			end if
			
			if li_ok > 0 then
				iw_window.Dynamic wf_setear_user(em_user.text)
				Close(Parent)
			else
				gf_mensaje("","El Usuario no Está Autorizado ",1,1,"E")
				sle_1.SetFocus()
			end if

end if
end event

type cb_2 from commandbutton within w_fa_man_clave_pedido
int X=558
int Y=396
int Width=302
int Height=108
int TabOrder=50
boolean BringToTop=true
string Text="Cancelar"
int TextSize=-12
int Weight=700
string FaceName="Times New Roman"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

event clicked;//w_fa_man_pedidos.is_clave = '*'
iw_window.Dynamic wf_setear_user("*")	
 Close(Parent)
//closeWithReturn(parent,"*")
end event

type st_2 from statictext within w_fa_man_clave_pedido
int X=114
int Y=120
int Width=370
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Usuario:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-14
int Weight=700
string FaceName="Calisto MT"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type em_user from editmask within w_fa_man_clave_pedido
int X=535
int Y=104
int Width=343
int Height=100
int TabOrder=20
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
string Mask="xxxxx"
MaskDataType MaskDataType=StringMask!
long TextColor=33554432
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

