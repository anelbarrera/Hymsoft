//objectcomments Para la Validación de la Clave del Usuario
forward
global type w_clave_autorizada_credito from w_fa_padre
end type
type st_1 from statictext within w_clave_autorizada_credito
end type
type sle_1 from singlelineedit within w_clave_autorizada_credito
end type
type cb_1 from commandbutton within w_clave_autorizada_credito
end type
type cb_2 from commandbutton within w_clave_autorizada_credito
end type
type st_2 from statictext within w_clave_autorizada_credito
end type
type em_user from editmask within w_clave_autorizada_credito
end type
type em_credito from editmask within w_clave_autorizada_credito
end type
type st_3 from statictext within w_clave_autorizada_credito
end type
type st_4 from statictext within w_clave_autorizada_credito
end type
type mle_nota from multilineedit within w_clave_autorizada_credito
end type
type gb_1 from groupbox within w_clave_autorizada_credito
end type
end forward

global type w_clave_autorizada_credito from w_fa_padre
integer width = 1193
integer height = 1020
string title = "Autorización"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 12632256
event ue_postopen ( )
st_1 st_1
sle_1 sle_1
cb_1 cb_1
cb_2 cb_2
st_2 st_2
em_user em_user
em_credito em_credito
st_3 st_3
st_4 st_4
mle_nota mle_nota
gb_1 gb_1
end type
global w_clave_autorizada_credito w_clave_autorizada_credito

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

on w_clave_autorizada_credito.create
int iCurrent
call super::create
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.em_user=create em_user
this.em_credito=create em_credito
this.st_3=create st_3
this.st_4=create st_4
this.mle_nota=create mle_nota
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.em_user
this.Control[iCurrent+7]=this.em_credito
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.mle_nota
this.Control[iCurrent+11]=this.gb_1
end on

on w_clave_autorizada_credito.destroy
call super::destroy
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.em_user)
destroy(this.em_credito)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.mle_nota)
destroy(this.gb_1)
end on

event key;//Override

end event

event closequery;call super::closequery;//destroy io_encryptor
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_clave_autorizada_credito
boolean visible = false
integer x = 18
integer y = 644
end type

type dw_1 from w_fa_padre`dw_1 within w_clave_autorizada_credito
boolean visible = false
integer x = 78
integer y = 136
integer width = 69
integer height = 36
integer taborder = 10
end type

type st_ayuda from w_fa_padre`st_ayuda within w_clave_autorizada_credito
end type

type st_1 from statictext within w_clave_autorizada_credito
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

type sle_1 from singlelineedit within w_clave_autorizada_credito
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

type cb_1 from commandbutton within w_clave_autorizada_credito
integer x = 219
integer y = 768
integer width = 325
integer height = 116
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
string facename = "Teen"
string text = "Aceptar"
boolean default = true
end type

event clicked;string  ls_clave, ls_passw
integer li_ok = 0, li_existe

if sle_1.Text = '*' then 	  // No puede asignar un '*' como clave, ya que es un codigo para
	gf_mensaje("","Verifique la Clave, Asigne Otra.",1,1,"E") // identificar el cancelar de la ventana
	return
else

	if double(em_credito.text) = 0 then
		gf_mensaje('','Debe asignar un Monto para el Crédito Adicional',1,1,'E')
		em_credito.setfocus()
		return		
	end if

	if mle_nota.text = '' then
		gf_mensaje('','Debe asignar una nota para autorizar el crédito',1,1,'E')
		mle_nota.setfocus()
		return
	end if
	
	ls_clave = sle_1.text
			
		    SELECT count(*)  
			 INTO :li_existe  
			 FROM usuarios  
			WHERE ( usua_id = :em_user.text ) AND  
					( usua_clave = :ls_clave ) AND  
					( usua_especial > 0 ) AND
					( usua_estado = 'A' )   ;
					
			if sqlca.sqlcode = -1 then
				gf_mensaje("","Error al Verificar Clave de Usuario "+sqlca.sqlerrtext,1,1,"E")
			end if
			
			if li_existe > 0 then
				iw_window.Dynamic wf_setear_user_credito(em_user.text, double(em_credito.text), mle_nota.text)				
				Close(Parent)
			else
				gf_mensaje("","Usuario no Autorizado ",1,1,"E")
				sle_1.SetFocus()
			end if
			
end if
end event

type cb_2 from commandbutton within w_clave_autorizada_credito
integer x = 640
integer y = 768
integer width = 320
integer height = 116
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
string facename = "Teen"
string text = "Cancelar"
end type

event clicked;//w_fa_man_pedidos.is_clave = '*'
iw_window.Dynamic wf_setear_user_credito("*", 0.00, '')	
 Close(Parent)
//closeWithReturn(parent,"*")
end event

type st_2 from statictext within w_clave_autorizada_credito
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

type em_user from editmask within w_clave_autorizada_credito
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

type em_credito from editmask within w_clave_autorizada_credito
integer x = 741
integer y = 372
integer width = 393
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,##0.00"
end type

type st_3 from statictext within w_clave_autorizada_credito
integer x = 114
integer y = 396
integer width = 603
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Crédito Adicional:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_clave_autorizada_credito
integer x = 389
integer y = 484
integer width = 402
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "NOTA"
alignment alignment = center!
boolean focusrectangle = false
end type

type mle_nota from multilineedit within w_clave_autorizada_credito
integer x = 41
integer y = 544
integer width = 1088
integer height = 208
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_clave_autorizada_credito
integer x = 14
integer width = 1147
integer height = 900
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 32896
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

