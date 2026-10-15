//objectcomments Para la Validación de la Clave del Usuario
forward
global type w_dg_man_clave_2 from w_dg_padre
end type
type gb_1 from groupbox within w_dg_man_clave_2
end type
type st_1 from statictext within w_dg_man_clave_2
end type
type sle_clave from singlelineedit within w_dg_man_clave_2
end type
type cb_1 from commandbutton within w_dg_man_clave_2
end type
type cb_2 from commandbutton within w_dg_man_clave_2
end type
type st_2 from statictext within w_dg_man_clave_2
end type
type em_user from editmask within w_dg_man_clave_2
end type
end forward

global type w_dg_man_clave_2 from w_dg_padre
integer width = 1033
integer height = 596
string title = "Modificacion"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 12639424
event ue_postopen ( )
gb_1 gb_1
st_1 st_1
sle_clave sle_clave
cb_1 cb_1
cb_2 cb_2
st_2 st_2
em_user em_user
end type
global w_dg_man_clave_2 w_dg_man_clave_2

type variables
String	is_autoriza_s_n
end variables

event ue_postopen;//io_encryptor = Create nv_encryptor
//io_encryptor.of_setkey("ReMe")

//iw_window = message.PowerObjectParm
is_autoriza_s_n = message.StringParm
em_user.Setfocus()

this.Setredraw(true)
end event

event open;call super::open;this.Setredraw(false)
gf_center_win(this)
this.postevent("ue_postopen")
end event

on w_dg_man_clave_2.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.st_1=create st_1
this.sle_clave=create sle_clave
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.em_user=create em_user
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.sle_clave
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.em_user
end on

on w_dg_man_clave_2.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.sle_clave)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.em_user)
end on

event key;//Override

end event

event closequery;call super::closequery;//Override

end event

event close;/*Primero se ejecuta el closeaquery y luego el close*/
CloseWithReturn(this,is_autoriza_s_n)

end event

type st_nom_ventana from w_dg_padre`st_nom_ventana within w_dg_man_clave_2
boolean visible = false
integer x = 18
end type

type dw_1 from w_dg_padre`dw_1 within w_dg_man_clave_2
boolean visible = false
integer x = 78
integer y = 136
integer width = 69
integer height = 36
end type

type gb_1 from groupbox within w_dg_man_clave_2
integer x = 14
integer width = 978
integer height = 464
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Clave de Autorización"
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_dg_man_clave_2
integer x = 169
integer y = 196
integer width = 297
integer height = 80
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "Clave:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_clave from singlelineedit within w_dg_man_clave_2
integer x = 498
integer y = 200
integer width = 343
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
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

type cb_1 from commandbutton within w_dg_man_clave_2
integer x = 155
integer y = 316
integer width = 311
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Aceptar"
boolean default = true
end type

event clicked;Integer	li_autoriza_s_n,li_permiso,li_cont,li_cont_1
string ls_usuario,ls_pass

If isNull(sle_clave.text) or sle_clave.text = "" then
	messagebox('Atención ','Digite su clave')
	return
end if

If isNull(em_user.text) or em_user.text = "" then
	messagebox('Atención ','Digite su codigo de usuario')
	return
end if

em_user.text = upper(em_user.text)
sle_clave.text = lower(sle_clave.text)

ls_usuario = em_user.text
ls_pass = sle_clave.text

// Valida el usuario colocado en la ventana.
SELECT count(*)  
  INTO :li_cont  
  FROM ssmusuar  
 WHERE ( ssmusuar.usua_id = :ls_usuario ) ;
 
IF sqlca.sqlcode = -1 THEN
	messagebox('Atención ','Error al Seleccionar en ssmusuar.')
	return
END IF 

IF li_cont = 0 THEN
	messagebox('Atención ','El Usuario no es válido. Verifique')
	return
END IF

// Valida el password colocado en la ventana.
SELECT count(*)
  INTO :li_cont_1  
  FROM ssmusuar  
 WHERE ( ssmusuar.usua_id = :ls_usuario ) AND  
		 ( ssmusuar.usua_clave = :ls_pass )   ;
		 
IF sqlca.sqlcode = -1 THEN
	messagebox('Atención ','Error al Seleccionar en ssmusuar.')
	return
END IF

IF li_cont_1 = 0 THEN
	messagebox('Atención ','La palabra Clave no es válida. Verifique')
	return
END IF

// Valida si se tiene permiso de supervisor.
SELECT ssmusuar.usua_supervisor  
  INTO :li_permiso  
  FROM ssmusuar  
 WHERE ( ssmusuar.usua_id = :ls_usuario ) AND  
		 ( ssmusuar.usua_clave = :ls_pass )   ;

IF sqlca.sqlcode = -1 THEN
	messagebox('Atención ','Error al Seleccionar en ssmusuar.')
	return
END IF

is_autoriza_s_n = string(li_permiso)

CHOOSE CASE is_autoriza_s_n
	CASE '0'	//Usuario no Autorizado
		messagebox('Atención ','Estimado Usuario Ud. no está autorizado para realizar este cambio, consulte a su Supervisor...!!!')
		return
		
	CASE '1'	//Usuario Autorizado
		CloseWithReturn(parent,is_autoriza_s_n)
	
	CASE ELSE
		messagebox('Atención ','Error al validar autorizacion')
		CloseWithReturn(parent,is_autoriza_s_n)
		return
END CHOOSE

end event

type cb_2 from commandbutton within w_dg_man_clave_2
integer x = 521
integer y = 316
integer width = 302
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Cancelar"
end type

event clicked;is_autoriza_s_n = '0'

CloseWithReturn(parent,is_autoriza_s_n)

end event

type st_2 from statictext within w_dg_man_clave_2
integer x = 96
integer y = 88
integer width = 370
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "Usuario:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_user from editmask within w_dg_man_clave_2
integer x = 498
integer y = 84
integer width = 343
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
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

event losefocus;sle_clave.setfocus()

end event

