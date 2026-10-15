forward
global type w_acceso from window
end type
type dw_2 from datawindow within w_acceso
end type
type cbx_1 from checkbox within w_acceso
end type
type st_titulo from statictext within w_acceso
end type
type dw_1 from datawindow within w_acceso
end type
type sle_clave from singlelineedit within w_acceso
end type
type em_usuario from editmask within w_acceso
end type
type cb_2 from commandbutton within w_acceso
end type
type cb_1 from commandbutton within w_acceso
end type
type st_2 from statictext within w_acceso
end type
type st_1 from statictext within w_acceso
end type
type gb_1 from groupbox within w_acceso
end type
end forward

global type w_acceso from window
integer width = 1349
integer height = 936
boolean titlebar = true
string title = "Acceso al Sistema"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 8421504
string icon = "AppIcon!"
dw_2 dw_2
cbx_1 cbx_1
st_titulo st_titulo
dw_1 dw_1
sle_clave sle_clave
em_usuario em_usuario
cb_2 cb_2
cb_1 cb_1
st_2 st_2
st_1 st_1
gb_1 gb_1
end type
global w_acceso w_acceso

type variables
string is_user
datawindowchild idwc_empresa, idwc_theme
end variables

on w_acceso.create
this.dw_2=create dw_2
this.cbx_1=create cbx_1
this.st_titulo=create st_titulo
this.dw_1=create dw_1
this.sle_clave=create sle_clave
this.em_usuario=create em_usuario
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_2=create st_2
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.dw_2,&
this.cbx_1,&
this.st_titulo,&
this.dw_1,&
this.sle_clave,&
this.em_usuario,&
this.cb_2,&
this.cb_1,&
this.st_2,&
this.st_1,&
this.gb_1}
end on

on w_acceso.destroy
destroy(this.dw_2)
destroy(this.cbx_1)
destroy(this.st_titulo)
destroy(this.dw_1)
destroy(this.sle_clave)
destroy(this.em_usuario)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;gf_center_win(this)
dw_1.settransobject(sqlca)
dw_1.getchild('empresa',idwc_empresa)
idwc_empresa.settransobject(sqlca)

dw_2.getchild('theme',idwc_theme)
idwc_theme.settransobject(sqlca)
idwc_theme.retrieve()
dw_2.insertrow(1)
end event

type dw_2 from datawindow within w_acceso
boolean visible = false
integer x = 654
integer y = 736
integer width = 544
integer height = 76
integer taborder = 60
string title = "none"
string dataobject = "dw_dd_themes"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;this.accepttext()
string ls_theme, ls_usuario, ls_codigo

ls_usuario = em_usuario.text
if ls_usuario = '' then return
ls_codigo = data
ls_theme = idwc_theme.getitemstring(idwc_theme.getrow(),'theme_name')

if ls_theme <> 'Default' then
	ApplyTheme('C:\Sistemas\Hymsoft\theme\'+ls_theme)
end if

  UPDATE usuarios  
     SET usua_theme = :ls_codigo  
   WHERE usuarios.usua_id = :ls_usuario   ;
if sqlca.sqlcode = -1 then
	gf_mensaje('','Error al Asignar Theme '+sqlca.sqlerrtext,1,1,'E')
end if

SetProfileString("nom.ini", "data", "theme", ls_theme)



end event

type cbx_1 from checkbox within w_acceso
integer x = 50
integer y = 752
integer width = 562
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421504
string text = "Seleccione Theme"
end type

event clicked;if this.checked then
	dw_2.visible = true
else
	dw_2.visible = false	
end if
end event

type st_titulo from statictext within w_acceso
boolean visible = false
integer x = 530
integer y = 356
integer width = 297
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8421504
string text = "Empresa"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_acceso
boolean visible = false
integer x = 160
integer y = 420
integer width = 1019
integer height = 96
integer taborder = 30
string title = "none"
string dataobject = "dw_external_empresa"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;accepttext()
str.empresa = integer(data)
str.g_financiero = idwc_empresa.getitemnumber(idwc_empresa.getrow(),'empr_g_financiero')
end event

type sle_clave from singlelineedit within w_acceso
integer x = 485
integer y = 216
integer width = 517
integer height = 128
integer taborder = 20
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Clarendon"
long textcolor = 33554432
long backcolor = 10789024
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type em_usuario from editmask within w_acceso
integer x = 485
integer y = 72
integer width = 517
integer height = 128
integer taborder = 10
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Clarendon"
long textcolor = 33554432
long backcolor = 10789024
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!!!!"
end type

event modified;integer li_empresa, li_grupo
is_user = this.text
if idwc_empresa.retrieve(is_user) > 0 then
	li_empresa = idwc_empresa.getitemnumber(1,'empr_empresa')
	li_grupo = idwc_empresa.getitemnumber(1,'empr_g_financiero')
	dw_1.insertrow(1)
	dw_1.setitem(1,'empresa',li_empresa)
	str.empresa = li_empresa
	str.g_financiero = li_grupo
	if idwc_empresa.rowcount() > 1 then
		dw_1.visible = true
		st_titulo.visible = true
	elseif idwc_empresa.rowcount() = 1 then
		dw_1.visible = false
		st_titulo.visible = false	
	else
		gf_mensaje('','Usiario Invalido o No tiene acceso al Sistema, Verifique !!!',1,1,'E')
	end if
else
	if is_user = 'SA' then
		idwc_empresa.insertrow(1)
		idwc_empresa.setitem(1,'empr_empresa',1)
		idwc_empresa.setitem(1,'empr_g_financiero',1)		
	end if
end if
end event

type cb_2 from commandbutton within w_acceso
integer x = 750
integer y = 568
integer width = 352
integer height = 132
integer taborder = 50
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Clarendon"
string text = "Salir"
end type

event clicked;w_fa_fondo.uo_regional.of_setvalores_anteriores()
close(parent)
end event

type cb_1 from commandbutton within w_acceso
integer x = 238
integer y = 568
integer width = 352
integer height = 132
integer taborder = 40
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Clarendon"
string text = "Aceptar"
boolean default = true
end type

event clicked;string ls_usuario, ls_clave
integer li_existe

ls_usuario = em_usuario.text
ls_clave = sle_clave.text

  SELECT count(*)  
    INTO :li_existe  
    FROM usuarios  
   WHERE ( usuarios.usua_id = :ls_usuario ) AND  
         ( usuarios.usua_clave = :ls_clave ) AND  
         ( usuarios.usua_estado = 'A' )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al validar usuario '+sqlca.sqlerrtext,1,1,'E')
				end if
				
if li_existe = 0 then
	gf_mensaje('','Acceso no autorizado...Verifique!!!',1,1,'E')
	return
end if

if idwc_empresa.rowcount() = 0 then
	gf_mensaje('','No tiene acceso a las Empresas Creadas...Verifique!!!',1,1,'E')
	return
end if

str.empresa = idwc_empresa.getitemnumber(idwc_empresa.getrow(),'empr_empresa')
str.g_financiero = idwc_empresa.getitemnumber(idwc_empresa.getrow(),'empr_g_financiero')

select isnull(empr_valida_contabilidad,1),  isnull(empr_nd_por_subtransaccion,1), convert(varchar(15),isnull(dgmempre.empr_ficha,0))+'-'+convert(varchar(4),isnull(dgmempre.empr_rollo,0))+'-'+convert(varchar(10),isnull(dgmempre.empr_imagen,0)) , isnull(empr_dijito_verificador,''), isnull(empr_contabiliza,1), isnull(empr_acceso_especial,''), isnull(empr_valor_itbm,0.07), isnull(empr_imprime_fiscal, 0), empr_numero_registro, isnull(empr_cuenta_cxc_default,''), isnull(empr_cuenta_cxp_default,''), isnull(empr_genera_asiento_entrada,0), isnull(empr_maneja_lotes,0), isnull(empr_ruta_fotos,'')
into :str.valida_contabilidad, :str.nd_por_subtransaccion, :str.ruc, :str.dv, :str.contabiliza, :str.empr_acceso_especial, :str.valor_itbm, :str.imprime_fiscal, :str.numero_registro, :str.cxc_default, :str.cxp_default, :str.genera_asiento_entradas, :str.maneja_lotes, :str.ruta_foto
from dgmempre
where empr_g_financiero = :str.g_financiero and
		 empr_empresa	 = :str.empresa ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al validar si la empresa verifica contablemente '+sqlca.sqlerrtext,1,1,'E')
		end if

str.usuario = ls_usuario
closewithreturn(parent, 'OK')

end event

type st_2 from statictext within w_acceso
integer x = 151
integer y = 252
integer width = 325
integer height = 60
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Clarendon"
long textcolor = 33554432
long backcolor = 8421504
string text = "Clave:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_acceso
integer x = 142
integer y = 120
integer width = 334
integer height = 60
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Clarendon"
long textcolor = 33554432
long backcolor = 8421504
string text = "Usuario:"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_acceso
integer x = 27
integer width = 1271
integer height = 848
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Clarendon"
long textcolor = 33554432
long backcolor = 8421504
end type

