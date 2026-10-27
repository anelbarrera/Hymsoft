//objectcomments  
forward
global type w_cr_proveedores from w_granpa
end type
type gb_ventana from groupbox within w_cr_proveedores
end type
type st_micro from statictext within w_cr_proveedores
end type
type dw_2 from uos_in_datawindow_utility within w_cr_proveedores
end type
type cb_1 from commandbutton within w_cr_proveedores
end type
type cb_2 from commandbutton within w_cr_proveedores
end type
type st_1 from statictext within w_cr_proveedores
end type
type st_2 from statictext within w_cr_proveedores
end type
end forward

shared variables

end variables

global type w_cr_proveedores from w_granpa
integer x = 384
integer y = 320
integer width = 2167
integer height = 1232
string title = "(CR)Mantenimiento de Proveedores"
string menuname = "m_hs"
boolean controlmenu = false
gb_ventana gb_ventana
st_micro st_micro
dw_2 dw_2
cb_1 cb_1
cb_2 cb_2
st_1 st_1
st_2 st_2
end type
global w_cr_proveedores w_cr_proveedores

type variables

end variables

forward prototypes
public subroutine centrar_dw ()
end prototypes

public subroutine centrar_dw ();//integer li_posicion_x,li_posicion_y
//li_posicion_x=this.width/2  - dw_1.width/2 
//li_posicion_y=this.height/2 - dw_1.height/2 
//if 0  > li_posicion_x then
//	li_posicion_x = 1
//	this.HScrollBar = TRUE
//else
//	this.HScrollBar = False
//end if
//if 0  > li_posicion_y then
//	li_posicion_y = 1
//	this.VScrollBar = TRUE
//else
//	this.VScrollBar = False
//end if
//dw_1.x=li_posicion_x
//dw_1.y=li_posicion_y

integer li_posicion_x,li_posicion_y
//li_posicion_x=w_in_inventarios.width/2  -20 - this.width/2 
//li_posicion_y=w_in_inventarios.height/2 -100 - this.height/2 
if 0  > li_posicion_x then
	li_posicion_x = 1
	this.HScrollBar = TRUE
else
	this.HScrollBar = False
end if
if 0  > li_posicion_y then
	li_posicion_y = 1
	this.VScrollBar = TRUE
else
	this.VScrollBar = False
end if
this.x=li_posicion_x 
// this.y=li_posicion_y

end subroutine

on w_cr_proveedores.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.gb_ventana=create gb_ventana
this.st_micro=create st_micro
this.dw_2=create dw_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_ventana
this.Control[iCurrent+2]=this.st_micro
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.st_2
end on

on w_cr_proveedores.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_ventana)
destroy(this.st_micro)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.st_2)
end on

event ue_imprimir;// Comentario utilizado para colocar el OverRide

end event

event ue_post_open;// OverRide
// Gianni Araúz (13/07/2000)


int	li_cont

is_nombre = this.ClassName()

st_nom_ventana.text = is_nombre

dw_2.settransobject(sqlca)

this.visible = true

//if this.MenuName = 'm_hs' then &
//	m_hs.archivo.m_cerrar.toolbaritemvisible = false

//if w_cr_fondo.is_integrado_cp = 'S' then
//	select count(*)
//	into :li_cont
//	from cpatipro
//	where tpro_g_financiero = :str.g_financiero and
//			tpro_empresa = :str.empresa;
	
//	if sqlca.sqlcode = -1 then
//		mensaje('Error','Descripción: '+sqlca.sqlerrtext,'')
//		close(this)
//		return
//	elseif sqlca.sqlcode = 100 then
//		messagebox('Atención','No se ha configurado la Clasificación de Proveedores. La '+&
//						'opción se encuentra en Cuentas por Pagar - Parámetros - Proveedores - '+&
//						'Clasificación... ¡Esta Ventana se cerrará automáticamente!',StopSign!)
//		close(this)
//		return
//	end if
//end if

this.postevent('ue_hay_data')

end event

event open;// OverRide

gf_center_win(This)
gf_acelerador()

this.Icon = str.icono

this.SetToolbar(1,true,alignattop!)
this.SetToolbarPos(1,1,50,false)
this.y = this.y - 150

this.postevent('ue_post_open')

end event

event ue_aceptar;// Override
// Gianni Araúz (12/07/2000)
// Validaciones para la inserción en la Base de Datos
// Inserción en la tabla de cpmprove


long		ll_terc
string	ls_prov, ls_dbcode, ls_errtext, ls_clasif
int		li_pais

dw_2.accepttext()

//if w_cr_fondo.is_integrado_cp = 'S' then
//	if isnull(dw_2.object.proveedor[1]) or trim(dw_2.object.proveedor[1]) = '' then
//		messagebox('Atención','No puede dejar vacío el campo Cód. Proveedor.',Exclamation!)
//		dw_2.setfocus()
//		dw_2.setcolumn('proveedor')
//		return
//	end if
//else
	if isnull(dw_2.object.terc_tercero[1]) /*or trim(dw_2.object.terc_tercero[1]) = ''*/ then
		messagebox('Atención','No puede dejar vacío el campo Cód. Proveedor.',Exclamation!)
		dw_2.setfocus()
		dw_2.setcolumn('terc_tercero')
		return
	end if
//end if

if isnull(dw_2.object.terc_descripcion[1]) or trim(dw_2.object.terc_descripcion[1]) = '' then
	messagebox('Atención','No puede dejar vacío el campo Descripción.',Exclamation!)
	dw_2.setfocus()
	dw_2.setcolumn('terc_descripcion')
	return
end if

if isnull(dw_2.object.terc_pais[1]) then
	messagebox('Atención','No puede dejar vacío el campo Pais.',Exclamation!)
	dw_2.setfocus()
	dw_2.setcolumn('terc_pais')
	return
end if
// Comentado por Mayte Aparicio (26/07/2000)
//if isnull(dw_2.object.terc_telefono1[1]) or trim(dw_2.object.terc_telefono1[1]) = '' then
//	messagebox('Atención','No puede dejar vacío el campo Teléfono.',Exclamation!)
//	dw_2.setfocus()
//	dw_2.setcolumn('terc_telefono1')
//	return
//end if
//
//if isnull(dw_2.object.terc_fax1[1]) or trim(dw_2.object.terc_fax1[1]) = '' then
//	messagebox('Atención','No puede dejar vacío el campo Fax.',Exclamation!)
//	dw_2.setfocus()
//	dw_2.setcolumn('terc_fax1')
//	return
//end if
//
//if isnull(dw_2.object.terc_direccion[1]) or trim(dw_2.object.terc_direccion[1]) = '' then
//	messagebox('Atención','No puede dejar vacío el campo Dirección.',Exclamation!)
//	dw_2.setfocus()
//	dw_2.setcolumn('terc_direccion')
//	return
//end if
//
//if isnull(dw_2.object.terc_email[1]) or trim(dw_2.object.terc_email[1]) = '' then
//	messagebox('Atención','No puede dejar vacío el campo E-mail.',Exclamation!)
//	dw_2.setfocus()
//	dw_2.setcolumn('terc_email')
//	return
//end if

////if w_cr_fondo.is_integrado_cp = 'S' then
//	ll_terc = dw_2.object.terc_tercero[1]
//	ls_prov = dw_2.object.proveedor[1]
//	li_pais = dw_2.object.terc_pais[1]
	
//	select tpro_clasificacion
//	into :ls_clasif
//	from cpatipro
//	where tpro_g_financiero = :str.g_financiero and
//			tpro_empresa = :str.empresa and
//			tpro_clasificacion = (select min(tpro_clasificacion)
//											from cpatipro
//											where tpro_g_financiero = :str.g_financiero and
//													tpro_empresa = :str.empresa);
	
//	if sqlca.sqlcode = -1 then
//		ls_dbcode = string(sqlca.sqldbcode)
//		ls_errtext = sqlca.sqlerrtext
//		rollback;
//		mensaje('Error # '+ls_dbcode,'Descripción: '+sqlca.sqlerrtext,'')
//		return
//	elseif sqlca.sqlcode = 100 then
//		rollback;
//		messagebox('Atención','No se recuperó la clasificación del Proveedor.',Exclamation!)
//		return
//	end if
	
//	INSERT INTO cpmprove
//		(prov_g_financiero,
//		prov_empresa,
//		prov_tercero,
//		prov_mg_cuenta,
//		prov_cod_proveedor,
//		prov_clasificacion,
//		prov_estado,
//		prov_pais,
//		prov_contrato_s_n)
//	VALUES (:str.g_financiero,
//		:str.empresa,
//		:ll_terc,
//		' ',
//		:ls_prov,
//		:ls_clasif,
//		'A',
//		:li_pais,
//		0);
	
//	if sqlca.sqlcode <> 0 then
//		ls_dbcode = string(sqlca.sqldbcode)
//		ls_errtext = sqlca.sqlerrtext
//		rollback;
//		mensaje('Error # '+ls_dbcode,'Descripción: '+ls_errtext,'')
//		return
//	end if
////end if

if dw_2.update() = 1  then
	commit;
	messagebox('Información','¡Actualización Exitosa!')
else
	rollback;
	messagebox('Atención','¡No se Actualizó la Información!',Exclamation!)
end if

end event

event ue_adicionar;// OverRide

int	li_fila, li_flag
long	ll_terc

dw_2.reset()

//if w_cr_fondo.is_integrado_cp = 'N' then dw_2.object.opcion.expression = '1'

select isnull(max(terc_tercero)+1,1)
into :ll_terc
from dgmterce
where terc_tercero <> 99999;

if sqlca.sqlcode = -1 then
	mensaje('Error','Descripción: '+sqlca.sqlerrtext+'.','')
	close(this)
	return
end if

li_fila = dw_2.scrolltorow(dw_2.insertrow(1))
dw_2.setitem(1,'terc_tercero',ll_terc)
dw_2.setitem(1,'terc_tipop',1)

dw_2.setfocus()

end event

event ue_hay_data;// OverRide


if dw_2.rowcount() = 0 then this.triggerevent('ue_adicionar')

end event

event closequery;// Comentario utilizado para colocar el OverRide

end event

event ue_insertar;This.triggerevent('ue_adicionar')
end event

type st_nom_ventana from w_granpa`st_nom_ventana within w_cr_proveedores
boolean visible = false
integer x = 32
integer y = 960
end type

type dw_1 from w_granpa`dw_1 within w_cr_proveedores
event ue_micro pbm_nchittest
boolean visible = false
integer x = 27
integer y = 32
integer width = 41
integer height = 40
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type gb_ventana from groupbox within w_cr_proveedores
boolean visible = false
integer x = 5
integer y = 920
integer width = 832
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type st_micro from statictext within w_cr_proveedores
boolean visible = false
integer x = 699
integer y = 612
integer width = 302
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15793151
boolean enabled = false
boolean focusrectangle = false
end type

type dw_2 from uos_in_datawindow_utility within w_cr_proveedores
integer width = 2130
integer height = 928
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_cr_proveedores1"
end type

event dberror;// OveRide
// Gianni Araúz (12/07/2000)


integer		li_pos, li_digaum, li_fila
string		ls_campo, ls_camptra, ls_sqlerrtext
long			ll_sqldbcode


if sqlerrtext <> '' then
	ll_sqldbcode = sqldbcode
	li_fila = row
	ls_sqlerrtext = sqlerrtext
	
	rollback;
	
	if ll_sqldbcode = 233 then
		li_pos = pos(ls_sqlerrtext,'terc_')
		ls_campo = mid(ls_sqlerrtext,li_pos,5)
		li_digaum = li_pos + 5
		do while mid(ls_sqlerrtext,li_digaum,1) <> ' '
			ls_campo += mid(ls_sqlerrtext,li_digaum,1)
			li_digaum ++
		loop
		choose case ls_campo
			case 'terc_tercero'
				ls_camptra = 'Número de Tercero'
			case 'terc_pais'
				ls_camptra = 'País'
			case else
				ls_camptra = ls_campo
		end choose
		
		messagebox(string(ll_sqldbcode),'No puede dejar vacío el campo: '+ls_camptra+'. Fila # '+&
						string(li_fila),Exclamation!)
	else
		mensaje(string(ll_sqldbcode),ls_sqlerrtext+'. Fila # '+string(li_fila),'')
	end if
	return 1
end if

end event

event itemchanged;call super::itemchanged;// Gianni Araúz (13/07/2000)
// Serializando la región


datawindowchild	ldwc_
integer				li_cont

// Gianni, revisa (22/07/2000)
//long	ll_find
//
//ll_find = dw_2.Find('dcop_num_prove = '+data,1,dw_2.rowcount())
//
//if ll_find > 0 then return 1


if dwo.name = 'proveedor' then
//	if w_cr_fondo.is_integrado_cp = 'S' then
//		select count(*)
//		into :li_cont
//		from cpmprove
//		where prov_g_financiero = :str.g_financiero and
//				prov_empresa = :str.empresa and
//				prov_cod_proveedor = :data;
		
//		if sqlca.sqlcode = -1 then
//			mensaje('Error','Descripción: '+sqlca.sqlerrtext,'')
//			return
//		end if
//	else
		select count(1)
		into :li_cont
		from dgmterce
		where terc_tercero = convert(numeric(5,0),:data);
		
		if sqlca.sqlcode = -1 then
			mensaje('Error','Descripción: '+sqlca.sqlerrtext,'')
			return
		end if
//	end if
	if li_cont > 0 then
		messagebox('Atención','¡Este proveedor ya existe!',Exclamation!)
		return 1
	end if
end if

if dwo.name = 'terc_pais' then
	this.getchild('terc_pais',ldwc_)
	ldwc_.settransobject(sqlca)
	this.object.terc_region[1] = ldwc_.getitemnumber(ldwc_.getrow(),'dgaregio_regi_codigo_region')
end if

end event

event itemerror;call super::itemerror;// Gianni Araúz (13/07/2000)


string	ls_nulo
long		ll_nulo

if dwo.name = 'proveedor' then
	if trim(data) = '' then messagebox('Atención','¡Código de Proveedor Inválido!',Exclamation!)
	setnull(ls_nulo)
	this.setitem(row,'proveedor',ls_nulo)
end if

if dwo.name = 'terc_tercero' then
	setnull(ll_nulo)
	messagebox('Atención','¡Código de Proveedor Inválido!',Exclamation!)
	this.setitem(row,'terc_tercero',ll_nulo)
end if

return 1

end event

type cb_1 from commandbutton within w_cr_proveedores
boolean visible = false
integer x = 1486
integer y = 952
integer width = 247
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Salvar"
end type

event clicked;parent.triggerevent('ue_aceptar')

end event

type cb_2 from commandbutton within w_cr_proveedores
boolean visible = false
integer x = 1778
integer y = 952
integer width = 247
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "S&alir"
end type

event clicked;// OverRide
// Gianni Araúz (12/07/2000)


if messagebox('Información','¿Está seguro que desea salir de la Ventana?',&
					Question!,YesNo!,2) = 1 then close(parent)

end event

type st_1 from statictext within w_cr_proveedores
boolean visible = false
integer x = 1472
integer y = 940
integer width = 270
integer height = 96
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within w_cr_proveedores
boolean visible = false
integer x = 1765
integer y = 940
integer width = 270
integer height = 96
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

