//objectcomments  
forward
global type w_login_modern from window
end type
type r_card from roundrectangle within w_login_modern
end type
type st_title from statictext within w_login_modern
end type
type r_user_border from roundrectangle within w_login_modern
end type
type p_user_icon from picture within w_login_modern
end type
type sle_user from singlelineedit within w_login_modern
end type
type r_pass_border from roundrectangle within w_login_modern
end type
type p_pass_icon from picture within w_login_modern
end type
type sle_password from singlelineedit within w_login_modern
end type
type p_eye from picture within w_login_modern
end type
type r_empresa_border from roundrectangle within w_login_modern
end type
type p_empresa_icon from picture within w_login_modern
end type
type dw_empresa from datawindow within w_login_modern
end type
type st_forgot from statictext within w_login_modern
end type
type cb_login from commandbutton within w_login_modern
end type
type st_version from statictext within w_login_modern
end type
type p_close from picture within w_login_modern
end type
type p_branding from picture within w_login_modern
end type
end forward

global type w_login_modern from window
integer width = 2487
integer height = 956
windowtype windowtype = response!
long backcolor = 16316664
boolean center = true
event ue_mousemove pbm_mousemove
r_card r_card
st_title st_title
r_user_border r_user_border
p_user_icon p_user_icon
sle_user sle_user
r_pass_border r_pass_border
p_pass_icon p_pass_icon
sle_password sle_password
p_eye p_eye
r_empresa_border r_empresa_border
p_empresa_icon p_empresa_icon
dw_empresa dw_empresa
st_forgot st_forgot
cb_login cb_login
st_version st_version
p_close p_close
p_branding p_branding
end type
global w_login_modern w_login_modern

type variables
private boolean ib_show_password = false
protected datawindowchild idwc_empresas
String is_user
end variables

forward prototypes
public subroutine of_toggle_password ()
public subroutine of_cargar_empresas (string as_usuario)
end prototypes

event ue_mousemove;if flags = 1 then
    Send(Handle(this), 161, 2, 0)
end if
end event

public subroutine of_toggle_password ();ib_show_password = not ib_show_password

if ib_show_password then
    sle_password.password = false
    p_eye.picturename = "Art\eye_slash.svg"
else
    sle_password.password = true
    p_eye.picturename = "Art\eye.svg"
end if
end subroutine

public subroutine of_cargar_empresas (string as_usuario);string ls_usuario
long ll_row

ls_usuario = Trim(as_usuario)

if IsNull(idwc_empresas) or not IsValid(idwc_empresas) then return

idwc_empresas.Reset()
dw_empresa.SetItem(1, "id_empresa", "")

if ls_usuario = "" then
    dw_empresa.Enabled = false
    r_empresa_border.linecolor = 14540253
    return
end if

// Activar control visual
dw_empresa.Enabled = true
r_empresa_border.linecolor = 15329769

// ================================================================
// Carga del Child DataWindow
// (Puedes hacer idwc_empresas.SetTransObject(SQLCA); idwc_empresas.Retrieve(ls_usuario))
// o poblarlo manualmente como se ilustra abajo:
// ================================================================
ll_row = idwc_empresas.InsertRow(0)
idwc_empresas.SetItem(ll_row, "id_empresa", "01")
idwc_empresas.SetItem(ll_row, "nombre_empresa", "01 - Empresa Matriz S.A.")

ll_row = idwc_empresas.InsertRow(0)
idwc_empresas.SetItem(ll_row, "id_empresa", "02")
idwc_empresas.SetItem(ll_row, "nombre_empresa", "02 - Sucursal Internacional")

ll_row = idwc_empresas.InsertRow(0)
idwc_empresas.SetItem(ll_row, "id_empresa", "03")
idwc_empresas.SetItem(ll_row, "nombre_empresa", "03 - Operaciones y Logística")

// Seleccionar la primera empresa por defecto
if idwc_empresas.RowCount() > 0 then
    dw_empresa.SetItem(1, "id_empresa", idwc_empresas.GetItemString(1, "id_empresa"))
end if
end subroutine

on w_login_modern.create
this.r_card=create r_card
this.st_title=create st_title
this.r_user_border=create r_user_border
this.p_user_icon=create p_user_icon
this.sle_user=create sle_user
this.r_pass_border=create r_pass_border
this.p_pass_icon=create p_pass_icon
this.sle_password=create sle_password
this.p_eye=create p_eye
this.r_empresa_border=create r_empresa_border
this.p_empresa_icon=create p_empresa_icon
this.dw_empresa=create dw_empresa
this.st_forgot=create st_forgot
this.cb_login=create cb_login
this.st_version=create st_version
this.p_close=create p_close
this.p_branding=create p_branding
this.Control[]={this.r_card,&
this.st_title,&
this.r_user_border,&
this.p_user_icon,&
this.sle_user,&
this.r_pass_border,&
this.p_pass_icon,&
this.sle_password,&
this.p_eye,&
this.r_empresa_border,&
this.p_empresa_icon,&
this.dw_empresa,&
this.st_forgot,&
this.cb_login,&
this.st_version,&
this.p_close,&
this.p_branding}
end on

on w_login_modern.destroy
destroy(this.r_card)
destroy(this.st_title)
destroy(this.r_user_border)
destroy(this.p_user_icon)
destroy(this.sle_user)
destroy(this.r_pass_border)
destroy(this.p_pass_icon)
destroy(this.sle_password)
destroy(this.p_eye)
destroy(this.r_empresa_border)
destroy(this.p_empresa_icon)
destroy(this.dw_empresa)
destroy(this.st_forgot)
destroy(this.cb_login)
destroy(this.st_version)
destroy(this.p_close)
destroy(this.p_branding)
end on

event open; 

gf_center_win(this)
 
dw_empresa.settransobject(sqlca)
dw_empresa.GetChild("empresa", idwc_empresas)
idwc_empresas.settransobject(sqlca)

sle_user.SetFocus()
end event

type p_branding from picture within w_login_modern
integer x = 183
integer y = 328
integer width = 818
integer height = 212
boolean bringtotop = true
boolean originalsize = true
string picturename = ".\Art\Hymsoft.png"
boolean focusrectangle = false
end type

event clicked;Send(Handle(parent), 161, 2, 0)
end event

type r_card from roundrectangle within w_login_modern
long linecolor = 15921906
integer linethickness = 2
long fillcolor = 16777215
integer x = 1175
integer y = 52
integer width = 1211
integer height = 872
integer cornerheight = 25
integer cornerwidth = 25
end type

type st_title from statictext within w_login_modern
integer x = 1225
integer y = 92
integer width = 1138
integer height = 92
integer textsize = -13
integer weight = 700
string facename = "Segoe UI"
long textcolor = 1118481
long backcolor = 16777215
string text = "Acceso al Sistema"
alignment alignment = center!
end type

type r_user_border from roundrectangle within w_login_modern
long linecolor = 15329769
integer linethickness = 2
long fillcolor = 16777215
integer x = 1248
integer y = 220
integer width = 1102
integer height = 120
integer cornerheight = 20
integer cornerwidth = 20
end type

type p_user_icon from picture within w_login_modern
integer x = 1189
integer y = 252
integer width = 59
integer height = 60
string picturename = "Art\user_icon.svg"
boolean focusrectangle = false
end type

type sle_user from singlelineedit within w_login_modern
integer x = 1353
integer y = 240
integer width = 969
integer height = 80
integer taborder = 10
integer textsize = -9
string facename = "Segoe UI"
long textcolor = 2171169
long backcolor = 16777215
boolean border = false
end type

event modified;//parent.of_cargar_empresas(this.text)

integer li_empresa, li_grupo
is_user = this.text
if idwc_empresas.retrieve(is_user) > 0 then
	li_empresa = idwc_empresas.getitemnumber(1,'empr_empresa')
	li_grupo = idwc_empresas.getitemnumber(1,'empr_g_financiero')
	dw_empresa.insertrow(1)
	dw_empresa.setitem(1,'empresa',li_empresa)
	str.empresa = li_empresa
	str.g_financiero = li_grupo
	if idwc_empresas.rowcount() > 1 then
		dw_empresa.visible = true
		//st_titulo.visible = true
	elseif idwc_empresas.rowcount() = 1 then
		dw_empresa.visible = false
		//st_titulo.visible = false	
	else
		gf_mensaje('','Usiario Invalido o No tiene acceso al Sistema, Verifique !!!',1,1,'E')
	end if
else
	if is_user = 'SA' then
		idwc_empresas.insertrow(1)
		idwc_empresas.setitem(1,'empr_empresa',1)
		idwc_empresas.setitem(1,'empr_g_financiero',1)		
	end if
end if
end event

event losefocus;//if IsValid(idwc_empresas) then
//    if idwc_empresas.RowCount() = 0 then
//        parent.of_cargar_empresas(this.text)
//    end if
//end i
end event

type r_pass_border from roundrectangle within w_login_modern
long linecolor = 14540253
integer linethickness = 2
long fillcolor = 16777215
integer x = 1248
integer y = 372
integer width = 1102
integer height = 120
integer cornerheight = 20
integer cornerwidth = 20
end type

type p_pass_icon from picture within w_login_modern
integer x = 1189
integer y = 400
integer width = 59
integer height = 60
string picturename = "Art\lock_icon.svg"
boolean focusrectangle = false
end type

type sle_password from singlelineedit within w_login_modern
integer x = 1353
integer y = 392
integer width = 901
integer height = 80
integer taborder = 20
integer textsize = -9
string facename = "Segoe UI"
long textcolor = 2171169
long backcolor = 16777215
boolean border = false
boolean password = true
end type

type p_eye from picture within w_login_modern
integer x = 2267
integer y = 400
integer width = 59
integer height = 60
string picturename = "Art\eye.svg"
boolean focusrectangle = false
end type

event clicked;parent.of_toggle_password()
end event

type r_empresa_border from roundrectangle within w_login_modern
long linecolor = 14540253
integer linethickness = 2
long fillcolor = 16777215
integer x = 1248
integer y = 520
integer width = 1102
integer height = 120
integer cornerheight = 20
integer cornerwidth = 20
end type

type p_empresa_icon from picture within w_login_modern
integer x = 1189
integer y = 552
integer width = 59
integer height = 60
string picturename = "Art\company_icon.svg"
boolean focusrectangle = false
end type

type dw_empresa from datawindow within w_login_modern
integer x = 1353
integer y = 536
integer width = 969
integer height = 92
integer taborder = 30
string dataobject = "dw_external_empresa"
boolean border = false
end type

type st_forgot from statictext within w_login_modern
boolean visible = false
integer x = 1440
integer y = 660
integer width = 498
integer height = 52
integer textsize = -8
string facename = "Segoe UI"
long textcolor = 5395026
long backcolor = 16777215
string text = "¿Olvidó su contraseña?"
alignment alignment = right!
end type

type cb_login from commandbutton within w_login_modern
integer x = 1248
integer y = 740
integer width = 1102
integer height = 120
integer taborder = 40
integer textsize = -10
integer weight = 700
string facename = "Segoe UI"
string text = "INICIAR SESIÓN"
boolean default = true
end type

event clicked;string ls_user, ls_pass, ls_empresa
integer li_existe

dw_empresa.AcceptText()

ls_user = Trim(sle_user.text)
ls_pass = Trim(sle_password.text)
ls_empresa = Trim(dw_empresa.GetItemString(1, "empresa"))


  SELECT count(1)  
    INTO :li_existe  
    FROM usuarios  
   WHERE ( usuarios.usua_id = :ls_user ) AND  
         ( usuarios.usua_clave = :ls_pass ) AND  
         ( usuarios.usua_estado = 'A' )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al validar usuario '+sqlca.sqlerrtext,1,1,'E')
				end if
				
if li_existe = 0 then
	gf_mensaje('','Acceso no autorizado...Verifique!!!',1,1,'E')
	return
end if
if idwc_empresas.rowcount() = 0 then
	gf_mensaje('','No tiene acceso a las Empresas Creadas...Verifique!!!',1,1,'E')
	return
end if

str.empresa = idwc_empresas.getitemnumber(idwc_empresas.getrow(),'empr_empresa')
str.g_financiero = idwc_empresas.getitemnumber(idwc_empresas.getrow(),'empr_g_financiero')

select isnull(empr_valida_contabilidad,1),  isnull(empr_nd_por_subtransaccion,1), convert(varchar(15),isnull(dgmempre.empr_ficha,0))+'-'+convert(varchar(4),isnull(dgmempre.empr_rollo,0))+'-'+convert(varchar(10),isnull(dgmempre.empr_imagen,0)) , isnull(empr_dijito_verificador,''), isnull(empr_contabiliza,1), isnull(empr_acceso_especial,''), isnull(empr_valor_itbm,0.07), isnull(empr_imprime_fiscal, 0), empr_numero_registro, isnull(empr_cuenta_cxc_default,''), isnull(empr_cuenta_cxp_default,''), isnull(empr_genera_asiento_entrada,0), isnull(empr_maneja_lotes,0), isnull(empr_ruta_fotos,'')
into :str.valida_contabilidad, :str.nd_por_subtransaccion, :str.ruc, :str.dv, :str.contabiliza, :str.empr_acceso_especial, :str.valor_itbm, :str.imprime_fiscal, :str.numero_registro, :str.cxc_default, :str.cxp_default, :str.genera_asiento_entradas, :str.maneja_lotes, :str.ruta_foto
from dgmempre
where empr_g_financiero = :str.g_financiero and
		 empr_empresa	 = :str.empresa ;
if sqlca.sqlcode = -1 then
	gf_mensaje('','Error al validar si la empresa verifica contablemente '+sqlca.sqlerrtext,1,1,'E')
end if
		
str.usuario = ls_user
closewithreturn(parent, 'OK')

end event

type st_version from statictext within w_login_modern
boolean visible = false
integer x = 1618
integer y = 1260
integer width = 379
integer height = 40
integer textsize = -8
string facename = "Segoe UI"
long textcolor = 9474192
long backcolor = 16316664
string text = "v2025.1.002"
alignment alignment = right!
end type

type p_close from picture within w_login_modern
integer x = 2377
integer y = 16
integer width = 50
integer height = 52
string picturename = "Art\close_icon.svg"
boolean focusrectangle = false
end type

event clicked;CloseWithReturn(parent, 0)
end event

