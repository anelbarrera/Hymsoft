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
boolean visible = true
integer width = 1125
integer height = 648
string title = "Clave"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 79741120
boolean center = true
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
String is_user
end variables

event ue_postopen();//io_encryptor = Create nv_encryptor
//io_encryptor.of_setkey("ReMe")

//iw_window = message.PowerObjectParm

//em_user.Setfocus()

//this.Setredraw(true)

this.SetRedraw(true)
em_user.SetFocus()
end event

event open;// 1. Capturar el parámetro inmediatamente en el open (antes de cualquier PostEvent)
if IsValid(Message.PowerObjectParm) then
    iw_window = Message.PowerObjectParm
end if

// 2. Forzar que la ventana sea visible y se redibuje correctamente
this.SetRedraw(true)
this.BringToTop = true

this.PostEvent("ue_postopen")
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

event closequery;//destroy io_encryptor
constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)

This.SetRedraw(false)
end event

event resize;//override
end event

event close;Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then CloseWithReturn(This,is_user)
 
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_man_clave_pedido
boolean visible = false
integer x = 18
integer y = 644
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_man_clave_pedido
boolean visible = false
integer x = 78
integer y = 136
integer width = 69
integer height = 36
integer taborder = 10
end type

type st_ayuda from w_fa_padre`st_ayuda within w_fa_man_clave_pedido
end type

type gb_1 from groupbox within w_fa_man_clave_pedido
integer x = 14
integer width = 1079
integer height = 544
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Introduzca la Clave de Autorización"
end type

type st_1 from statictext within w_fa_man_clave_pedido
integer x = 187
integer y = 240
integer width = 297
integer height = 80
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Calisto MT"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Clave:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_fa_man_clave_pedido
integer x = 535
integer y = 236
integer width = 343
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_fa_man_clave_pedido
integer x = 192
integer y = 396
integer width = 311
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Aceptar"
boolean default = true
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
//				iw_window.Dynamic wf_setear_user(em_user.text)
//				Close(Parent)
				closewithreturn(Parent,em_user.text)
			else
				gf_mensaje("","El Usuario no Está Autorizado ",1,1,"E")
				sle_1.SetFocus()
			end if

end if
end event

type cb_2 from commandbutton within w_fa_man_clave_pedido
integer x = 558
integer y = 396
integer width = 302
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Cancelar"
end type

event clicked;//w_fa_man_pedidos.is_clave = '*'
//iw_window.Dynamic wf_setear_user("*")	
// Close(Parent)
 

is_user = '*'

CloseWithReturn(parent,is_user)
end event

type st_2 from statictext within w_fa_man_clave_pedido
integer x = 114
integer y = 120
integer width = 370
integer height = 76
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Calisto MT"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Usuario:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_user from editmask within w_fa_man_clave_pedido
integer x = 535
integer y = 104
integer width = 343
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "xxxxx"
end type

