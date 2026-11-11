//objectcomments Ventana que toma la secuencia de empaque
forward
global type w_fa_man_secemp from w_fa_padre
end type
type sle_1 from singlelineedit within w_fa_man_secemp
end type
type st_1 from statictext within w_fa_man_secemp
end type
type st_2 from statictext within w_fa_man_secemp
end type
type gb_1 from groupbox within w_fa_man_secemp
end type
type cb_1 from commandbutton within w_fa_man_secemp
end type
type cb_2 from commandbutton within w_fa_man_secemp
end type
end forward

global type w_fa_man_secemp from w_fa_padre
integer width = 1554
integer height = 716
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 74481808
sle_1 sle_1
st_1 st_1
st_2 st_2
gb_1 gb_1
cb_1 cb_1
cb_2 cb_2
end type
global w_fa_man_secemp w_fa_man_secemp

type variables
long il_pedexit
string is_pedi ,is_por_my
end variables

on w_fa_man_secemp.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
this.st_2=create st_2
this.gb_1=create gb_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
end on

on w_fa_man_secemp.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event ue_aceptar;long ll_acepta
string ls_sec_ret, ls_sec_new,ls_sec

if w_fa_fondo.str_para.utiliza_decimales = 1 then
	ls_sec_new = gf_fa_verifica_secped_cb(sle_1.text,is_por_my)
else
	ls_sec_new = gf_fa_verifica_secped(sle_1.text,is_por_my)
end if

If sle_1.text <> ls_sec_new then
	ll_acepta = Messagebox("AVISO","Desea utilizar el número "+ls_sec_new+" ajustado al Pedido "+is_pedi+"" &
					,Information!,OKCancel!,1)
	CHOOSE CASE ll_acepta
		CASE 1
			If sle_1.text <> "0" then
				closewithreturn(this,ls_sec_new)
			End If
		CASE 2
			return
		
	END CHOOSE
Else
	closewithreturn(this,sle_1.text)
End IF
end event

event close;///override
end event

event ue_post_open;call super::ue_post_open;string ls_pedi_sec
long ll_pos
 
ls_pedi_sec = Message.StringParm

ll_pos = Pos(ls_pedi_sec,"/")

is_pedi = Mid(ls_pedi_sec,1,ll_pos - 1)
is_por_my = Mid(ls_pedi_sec,ll_pos + 1,len(ls_pedi_sec))

sle_1.text = is_pedi

//string(gf_fa_busqueda_secemp(is_pedi,il_por_my))
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_man_secemp
integer x = 18
integer y = 516
integer width = 654
long backcolor = 74481808
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_man_secemp
boolean visible = false
integer x = 32
integer y = 124
integer width = 78
integer height = 68
integer taborder = 20
end type

type st_ayuda from w_fa_padre`st_ayuda within w_fa_man_secemp
end type

type sle_1 from singlelineedit within w_fa_man_secemp
event ue_key pbm_keydown
integer x = 795
integer y = 260
integer width = 407
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type st_1 from statictext within w_fa_man_secemp
integer x = 288
integer y = 216
integer width = 347
integer height = 184
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 74481808
boolean enabled = false
string text = "Número de la Secuencia de los Pedidos"
boolean focusrectangle = false
end type

type st_2 from statictext within w_fa_man_secemp
integer x = 142
integer y = 20
integer width = 1230
integer height = 104
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 74481808
boolean enabled = false
string text = "SECUENCIA DE PEDIDOS"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_fa_man_secemp
integer x = 142
integer y = 152
integer width = 1225
integer height = 288
integer taborder = 10
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 74481808
borderstyle borderstyle = styleraised!
end type

type cb_1 from commandbutton within w_fa_man_secemp
integer x = 805
integer y = 504
integer width = 343
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
boolean default = true
end type

event clicked;parent.TriggerEvent("ue_aceptar")
end event

type cb_2 from commandbutton within w_fa_man_secemp
integer x = 1161
integer y = 504
integer width = 343
integer height = 100
integer taborder = 22
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;
closewithreturn(Parent,"0")
end event

