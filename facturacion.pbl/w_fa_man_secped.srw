//objectcomments Toma la Secuencia de Pedidos
forward
global type w_fa_man_secped from w_fa_padre
end type
type sle_1 from singlelineedit within w_fa_man_secped
end type
type st_1 from statictext within w_fa_man_secped
end type
type st_2 from statictext within w_fa_man_secped
end type
type gb_1 from groupbox within w_fa_man_secped
end type
type cb_1 from commandbutton within w_fa_man_secped
end type
type cb_2 from commandbutton within w_fa_man_secped
end type
end forward

global type w_fa_man_secped from w_fa_padre
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
global w_fa_man_secped w_fa_man_secped

type variables
long il_pedexit 
end variables

on w_fa_man_secped.create
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

on w_fa_man_secped.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event ue_post_open;call super::ue_post_open; string ls_no_proforma
 ls_no_proforma = message.stringparm
 gf_fa_busqueda_sec(sle_1.Text,ls_no_proforma)

end event

event ue_aceptar;long   ll_sec_ret, ll_sec_ant,ll_acepta
integer li_existe
string ls_sec_ped, ls_sec_ret

/*Modify by HGN 23/01/2002*/
/*No validaba si el # de documento estába en blanco on nullo*/
If IsNull(sle_1.text) or sle_1.text ='' then
	messagebox('Atención ','El número del pedido no puede ser nullo, Edite el # que le desea asignar al pedido...!!!!')
	this.sle_1.SetFocus ( )
	return
end if
/*Fin validacion*/
ll_sec_ant = long(sle_1.text)

if ll_sec_ant <= 0 then //si tiene letras la secuencia
	ls_sec_ped = sle_1.text
  	SELECT count(*)  
    INTO :li_existe  
    FROM fatpedid  
   WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
         ( fatpedid.pedi_empresa = :str.empresa ) AND  
         ( fatpedid.pedi_no_pedido = :ls_sec_ped ) AND  
         ( fatpedid.pedi_ann = :w_fa_fondo.str_para.ano )   ;
		if sqlca.sqlcode = -1 then
			mensaje("Aviso","Error al validar la existencia del pedido",sqlca.sqlerrtext)
			return
		end if
		
		if li_existe > 0 then
			mensaje("Aviso","La secuencia seleccionada, ya existe en pedidos. Verifique","")
			return
		else
			closewithreturn(this,ls_sec_ped)
		end if
		
else
	ls_sec_ret = gf_fa_verifica_sec(sle_1.text)  //Si es numerico, va a esta funcion
	sle_1.text = ls_sec_ret
end if

If ll_sec_ant = long(ls_sec_ret) or left(ls_sec_ret,1) = '0' then
	closewithreturn(this,ls_sec_ret)
Else
	ll_acepta = Messagebox("AVISO","Desea Utilizar el Numero dado en la SECUENCIA "+ls_sec_ret+"",Information!,OKCancel!,1)
	CHOOSE CASE ll_acepta
		CASE 1
			If ll_sec_ret > 0 then
				closewithreturn(this,ls_sec_ret)
			Else
				return
			End If
		CASE 2
			return
		
	END CHOOSE
End IF
end event

event close;///override
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_man_secped
boolean visible = false
integer x = 18
integer y = 516
integer width = 654
long backcolor = 74481808
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_man_secped
boolean visible = false
integer x = 32
integer y = 124
integer width = 78
integer height = 68
integer taborder = 20
end type

type st_ayuda from w_fa_padre`st_ayuda within w_fa_man_secped
end type

type sle_1 from singlelineedit within w_fa_man_secped
event ue_key pbm_keydown
integer x = 795
integer y = 260
integer width = 407
integer height = 92
integer taborder = 40
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

type st_1 from statictext within w_fa_man_secped
integer x = 288
integer y = 200
integer width = 347
integer height = 212
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

type st_2 from statictext within w_fa_man_secped
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

type gb_1 from groupbox within w_fa_man_secped
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

type cb_1 from commandbutton within w_fa_man_secped
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

type cb_2 from commandbutton within w_fa_man_secped
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
closewithreturn(Parent,'0')
end event

