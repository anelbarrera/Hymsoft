//objectcomments Para la Validación de la Clave del Usuario
forward
global type w_clave_autorizada from w_fa_padre
end type
type gb_1 from groupbox within w_clave_autorizada
end type
type st_1 from statictext within w_clave_autorizada
end type
type sle_1 from singlelineedit within w_clave_autorizada
end type
type cb_1 from commandbutton within w_clave_autorizada
end type
type cb_2 from commandbutton within w_clave_autorizada
end type
type st_2 from statictext within w_clave_autorizada
end type
type em_user from editmask within w_clave_autorizada
end type
end forward

global type w_clave_autorizada from w_fa_padre
integer width = 1125
integer height = 648
string title = "Autorización"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 12632256
boolean center = true
windowanimationstyle openanimation = rightroll!
windowanimationstyle closeanimation = rightslide!
event ue_postopen ( )
gb_1 gb_1
st_1 st_1
sle_1 sle_1
cb_1 cb_1
cb_2 cb_2
st_2 st_2
em_user em_user
end type
global w_clave_autorizada w_clave_autorizada

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

on w_clave_autorizada.create
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

on w_clave_autorizada.destroy
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

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_clave_autorizada
boolean visible = false
integer x = 18
integer y = 644
end type

type dw_1 from w_fa_padre`dw_1 within w_clave_autorizada
boolean visible = false
integer x = 78
integer y = 136
integer width = 69
integer height = 36
end type

type st_ayuda from w_fa_padre`st_ayuda within w_clave_autorizada
end type

type gb_1 from groupbox within w_clave_autorizada
integer x = 14
integer width = 1079
integer height = 544
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32896
long backcolor = 12632256
end type

type st_1 from statictext within w_clave_autorizada
integer x = 187
integer y = 240
integer width = 297
integer height = 80
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
string facename = "Catriel"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Clave:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_clave_autorizada
integer x = 535
integer y = 236
integer width = 434
integer height = 100
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

type cb_1 from commandbutton within w_clave_autorizada
integer x = 219
integer y = 396
integer width = 325
integer height = 116
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
string facename = "Teen"
string text = "Aceptar"
boolean default = true
end type

event clicked;string  ls_clave, ls_passw, ls_user
integer li_ok = 0, li_existe

if sle_1.Text = '*' then 	  // No puede asignar un '*' como clave, ya que es un codigo para
	gf_mensaje("","Verifique la Clave, Asigne Otra.",1,1,"E") // identificar el cancelar de la ventana
	return
else

	ls_clave = sle_1.text
	CHOOSE CASE iw_window
		CASE w_mant_clientes, w_facturacion, w_transacciones, w_entrada
			
	     SELECT count(*)  
			 INTO :li_existe  
			 FROM usuarios  
			WHERE ( usuarios.usua_id = :str.usuario ) AND  
					( usuarios.usua_clave = :ls_clave )  AND
					( usuarios.usua_especial = 1 ) AND
					(usuarios.usua_estado = 'A');
			
			if sqlca.sqlcode = -1 then
				gf_mensaje("","Error al Verificar Clave de Usuario "+sqlca.sqlerrtext,1,1,"E")
			end if
			
			if li_existe > 0 then
				iw_window.Dynamic wf_setear_user(em_user.text)
				Close(Parent)
			else
				gf_mensaje("","Usuario no Autorizado ",1,1,"E")
				sle_1.SetFocus()
			end if
		CASE w_reporte_mayor_general
			ls_user = em_user.text
			
			   SELECT count(*)  
			 INTO :li_existe  
			 FROM usuarios  
			WHERE ( usuarios.usua_id = :ls_user ) AND  
					( usuarios.usua_clave = :ls_clave )  AND
					( usuarios.usua_cambia_cuentas = 1 ) AND
					(usuarios.usua_estado = 'A');
			
			if sqlca.sqlcode = -1 then
				gf_mensaje("","Error al Verificar Clave de Usuario "+sqlca.sqlerrtext,1,1,"E")
			end if
			
			if li_existe > 0 then
				iw_window.Dynamic wf_setear_user(em_user.text)
				Close(Parent)
			else
				gf_mensaje("","Usuario no Autorizado ",1,1,"E")
				sle_1.SetFocus()
			end if
		CASE ELSE		
		     SELECT count(*)  
			 INTO :li_ok  
			 FROM usuarios  
			WHERE ( usuarios.usua_id = 'SA' ) AND  
					( usuarios.usua_clave = :ls_clave )  AND
					(usuarios.usua_estado = 'A');
				if sqlca.sqlcode = -1 then
					gf_mensaje("","Error al Verificar Clave de Usuario en seguridad "+sqlca.sqlerrtext,1,1,"E")
				end if							
			
			if li_ok > 0 and str.usuario = 'SA' then
				iw_window.Dynamic wf_setear_user("SA")
				Close(Parent)
			else
				gf_mensaje("","Usuario no Autorizado ",1,1,"E")
				sle_1.SetFocus()
			end if
	END CHOOSE
end if
end event

type cb_2 from commandbutton within w_clave_autorizada
integer x = 640
integer y = 396
integer width = 320
integer height = 116
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
string facename = "Teen"
string text = "Cancelar"
end type

event clicked;//w_fa_man_pedidos.is_clave = '*'
iw_window.Dynamic wf_setear_user("*")	
 Close(Parent)
//closeWithReturn(parent,"*")
end event

type st_2 from statictext within w_clave_autorizada
integer x = 133
integer y = 116
integer width = 370
integer height = 92
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
string facename = "Catriel"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Usuario:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_user from editmask within w_clave_autorizada
integer x = 535
integer y = 104
integer width = 439
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
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXXX"
end type

