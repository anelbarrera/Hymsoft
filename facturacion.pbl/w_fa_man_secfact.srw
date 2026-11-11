//objectcomments Ventana que controla y retorna la secuencia de la factura
forward
global type w_fa_man_secfact from w_fa_padre
end type
type sle_1 from singlelineedit within w_fa_man_secfact
end type
type st_1 from statictext within w_fa_man_secfact
end type
type st_2 from statictext within w_fa_man_secfact
end type
type gb_1 from groupbox within w_fa_man_secfact
end type
type cb_1 from commandbutton within w_fa_man_secfact
end type
type cb_2 from commandbutton within w_fa_man_secfact
end type
end forward

global type w_fa_man_secfact from w_fa_padre
integer width = 1554
integer height = 716
string title = "(CC) Secuencia de Pedidos en Factura"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 79741120
sle_1 sle_1
st_1 st_1
st_2 st_2
gb_1 gb_1
cb_1 cb_1
cb_2 cb_2
end type
global w_fa_man_secfact w_fa_man_secfact

type variables
long il_pedexit 
str_pasefact lstr_pase_f


end variables

on w_fa_man_secfact.create
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

on w_fa_man_secfact.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event ue_post_open;call super::ue_post_open;//sle_1.text = message.stringParm
lstr_pase_f = message.PowerObjectParm
sle_1.text = lstr_pase_f.numped 

If pos(upper(str.nombre_empresa),'TEXTILES') > 0 Then	
	gf_fa_busqueda_secfad_textil(sle_1.Text,lstr_pase_f.tipo)
else
	if w_fa_fondo.str_para.utiliza_decimales = 1 then
		gf_fa_busqueda_secfad_cb(sle_1.Text,lstr_pase_f.tipo)
	else
		gf_fa_busqueda_secfad(sle_1.Text,lstr_pase_f.tipo)
	end if
end if
 

end event

event ue_aceptar;
long ll_sec_ret, ll_sec_ant,ll_acepta, ll_sec_Act

ll_sec_ant = long(sle_1.text)

//ll_sec_ret =  gf_fa_verifica_secfad(sle_1.text)

lstr_pase_f = gf_fa_verifica_secfad(sle_1.text)

sle_1.text = lstr_pase_f.numped

ll_sec_act = long(lstr_pase_f.numped)

if ll_sec_act <= 0 then //Si le pusieron letras
	if lstr_pase_f.numped <> '0'	then
		closewithreturn(this,lstr_pase_f)		
	else
		return
	end if		
else				
		If ll_sec_ant = ll_sec_act then
			closewithreturn(this,lstr_pase_f)
		Else
			ll_acepta = Messagebox("AVISO","Desea Utilizar el Numero dado en la SECUENCIA "+string(lstr_pase_f.numped )+"",Information!,OKCancel!,1)
			CHOOSE CASE ll_acepta
				CASE 1
					If ll_sec_ret > 0 then
		//				closewithreturn(this,ll_sec_ret)
						closewithreturn(this,lstr_pase_f)
					Else
						return
					End If
				CASE 2
					return
				
			END CHOOSE
		End IF
End if
end event

event close;//override

lstr_pase_f.numped = sle_1.text
//lstr_pase_f.tipo = '0'
closewithreturn(this,lstr_pase_f)
end event

event closequery;//
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_man_secfact
integer x = 18
integer y = 516
integer width = 654
long backcolor = 74481808
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_man_secfact
boolean visible = false
integer x = 32
integer y = 124
integer width = 78
integer height = 68
integer taborder = 20
end type

type st_ayuda from w_fa_padre`st_ayuda within w_fa_man_secfact
end type

type sle_1 from singlelineedit within w_fa_man_secfact
event ue_key pbm_keydown
integer x = 768
integer y = 256
integer width = 407
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

event ue_key;//string ls_pedido, ls_max
//integer li_existe, li_contemp
//
// 
////If sle_1.Text <> "" Then 
////Else	
// 
//il_pedexit = 	long(sle_1.Text)
//	
//li_contemp = il_pedexit
//DO	
//	
//
//	ls_max = string(il_pedexit)
//
//  SELECT count(*)
//    INTO :li_existe  
//    FROM fatpedid
//   WHERE (fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
//         ( fatpedid.pedi_empresa = :str.empresa ) AND  
//			( fatpedid.pedi_ann = :w_fa_fondo.str_para.ano ) AND
//         ( fatpedid.pedi_no_pedido = :ls_max )  ;
//			
//	il_pedexit = il_pedexit + 1
//LOOP UNTIL li_existe = 0
end event

type st_1 from statictext within w_fa_man_secfact
integer x = 320
integer y = 244
integer width = 347
integer height = 116
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 74481808
boolean enabled = false
string text = "Número de la Secuencia"
boolean focusrectangle = false
end type

type st_2 from statictext within w_fa_man_secfact
integer x = 18
integer y = 24
integer width = 1513
integer height = 104
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 74481808
boolean enabled = false
string text = "SECUENCIA DE PEDIDOS EN FACTURAS"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_fa_man_secfact
integer x = 192
integer y = 152
integer width = 1138
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

type cb_1 from commandbutton within w_fa_man_secfact
integer x = 805
integer y = 504
integer width = 343
integer height = 100
integer taborder = 40
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

type cb_2 from commandbutton within w_fa_man_secfact
integer x = 1161
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
string text = "Cancelar"
end type

event clicked;str_pasefact lstr_pases
lstr_pases.numped 	= '0'
sle_1.text = '0'
lstr_pases.tipo 	= '0'
closewithreturn(Parent,lstr_pases)
end event

