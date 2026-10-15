forward
global type w_antiguedad_cxp from w_cc_padre
end type
type cb_1 from commandbutton within w_antiguedad_cxp
end type
type st_1 from statictext within w_antiguedad_cxp
end type
type rb_1 from radiobutton within w_antiguedad_cxp
end type
type rb_2 from radiobutton within w_antiguedad_cxp
end type
type dw_3 from datawindow within w_antiguedad_cxp
end type
type rb_3 from radiobutton within w_antiguedad_cxp
end type
type rb_4 from radiobutton within w_antiguedad_cxp
end type
type cb_2 from commandbutton within w_antiguedad_cxp
end type
type st_2 from statictext within w_antiguedad_cxp
end type
end forward

global type w_antiguedad_cxp from w_cc_padre
integer width = 2126
integer height = 812
string title = "Antigüedad de Saldos de Proveedores"
long backcolor = 8421376
cb_1 cb_1
st_1 st_1
rb_1 rb_1
rb_2 rb_2
dw_3 dw_3
rb_3 rb_3
rb_4 rb_4
cb_2 cb_2
st_2 st_2
end type
global w_antiguedad_cxp w_antiguedad_cxp

type variables
datastore ids_proveedores
end variables

on w_antiguedad_cxp.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.st_1=create st_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.dw_3=create dw_3
this.rb_3=create rb_3
this.rb_4=create rb_4
this.cb_2=create cb_2
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.rb_1
this.Control[iCurrent+4]=this.rb_2
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.rb_3
this.Control[iCurrent+7]=this.rb_4
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.st_2
end on

on w_antiguedad_cxp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.dw_3)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.cb_2)
destroy(this.st_2)
end on

event ue_post_open;datawindowchild dwchild
 
// ids_proveedores = create Datastore
// ids_proveedores.dataobject = "dw_co_cp_proveedores_existentes"
// ids_proveedores.SetTransObject(sqlca)
// ids_proveedores.retrieve(str.g_financiero,str.empresa)
//
is_nombre = This.ClassName()
//dw_2.enabled = false
//gf_win_used_by_user(is_nombre, true)

dw.settransobject(sqlca)


//dw_2.settransobject(sqlca)
//dw_2.getchild('cod_clasificacion',dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve(str.g_financiero,str.empresa)

//dw_2.insertrow(0)


st_nom_ventana.text = is_nombre

THIS.postevent("ue_hay_data")
//em_1.text = string(date(gf_fecha_serv()))
dw_3.settransobject(sqlca)
dw_3.insertrow(0)
dw_3.setitem(1,'fecha',gf_fecha_serv())
end event

event open;call super::open;This.ToolbarVisible = false
end event

type st_nom_ventana from w_cc_padre`st_nom_ventana within w_antiguedad_cxp
boolean visible = false
integer x = 18
integer y = 760
integer width = 55
integer height = 68
end type

type dw_1 from w_cc_padre`dw_1 within w_antiguedad_cxp
boolean visible = false
integer x = 2176
integer y = 284
integer width = 55
integer height = 52
end type

type cb_1 from commandbutton within w_antiguedad_cxp
integer x = 631
integer y = 432
integer width = 334
integer height = 108
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;integer ll_i, li_proveedor
long ll_proveedor,ll_err
datetime ld_fecha
string ls_fecha,ls_tipo,ls_err
//rb_3
ids_proveedores = create Datastore
dw_3.accepttext()
if rb_1.checked = true then
 	ids_proveedores.dataobject = "dw_co_cp_proveedores_existentes"
	ids_proveedores.SetTransObject(sqlca)
	ids_proveedores.retrieve(str.g_financiero,str.empresa) 
elseif rb_2.checked = true then // por tipo proveedor 
//	ls_tipo = dw_2.getitemstring(1,'cod_clasificacion')
	ids_proveedores.dataobject = "dw_co_cp_proveedores_existentes_clasifi"
	ids_proveedores.SetTransObject(sqlca)
	ids_proveedores.retrieve(str.g_financiero,str.empresa,ls_tipo)
end if


//ld_fecha = datetime(date(em_1.text),Time(23,59,59))
ld_fecha = dw_3.getitemdatetime(1,'fecha')


//
delete from cpatempa 
where tmpa_g_financiero = :str.g_financiero 	and
		tmpa_empresa		= :str.empresa;
		
If sqlca.sqlcode = -1 then
	ll_err = sqlca.sqldbcode
	ls_err  = sqlca.SQLErrText
	rollback;
	if ll_err = 100 then
		messagebox('Aviso','No existen registros para ser eliminados')
	else
		mensaje("Error"+string(ll_err),"Eliminando registros de cpatempa ",&
		'Descripción del error: '+ls_err)
	end if
		return
end if	
//
For ll_i = 1 to ids_proveedores.RowCount()
ll_proveedor =  ids_proveedores.GetitemNumber(ll_i,"cpmprove_prov_tercero")
//ll_proveedor = 21006
if rb_3.checked = true then//contra saldo
       gf_cp_antiguedad_x_proveedor_prueba(ld_fecha,ll_proveedor)
elseif rb_4.checked = true then //por fecha de registro
	gf_cp_antiguedad_x_fechareg1(ld_fecha,ll_proveedor)
end if
Next

ls_fecha = 'Al '+gf_cp_fecha_palabras_2('W',0, ld_fecha)

//OpenWithParm(w_antiguedad_imp_cxp, )
OpenSheetWithparm(w_antiguedad_imp_cxp,ls_fecha,Parent,0, Layered!)			
end event

type st_1 from statictext within w_antiguedad_cxp
integer x = 14
integer y = 28
integer width = 2071
integer height = 108
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
boolean enabled = false
string text = "ANTIGÜEDAD DE SALDOS DE PROVEEDORES"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_antiguedad_cxp
boolean visible = false
integer x = 791
integer y = 440
integer width = 274
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Todos "
boolean checked = true
end type

event clicked;//if this.checked = true then
//	dw_2.enabled = false
//else
//	dw_2.enabled = true
//end if
//	
end event

type rb_2 from radiobutton within w_antiguedad_cxp
boolean visible = false
integer x = 795
integer y = 500
integer width = 663
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Por tipo de  Proveedor"
end type

event clicked;//if this.checked = true then
//	rb_1.checked = false
//	dw_2.enabled = true
//else
//	dw_2.enabled = false
//end if
//	
end event

type dw_3 from datawindow within w_antiguedad_cxp
integer x = 983
integer y = 228
integer width = 430
integer height = 96
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ext_hasta"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_3 from radiobutton within w_antiguedad_cxp
boolean visible = false
integer x = 73
integer y = 432
integer width = 571
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Contra saldo"
boolean checked = true
end type

type rb_4 from radiobutton within w_antiguedad_cxp
boolean visible = false
integer x = 73
integer y = 488
integer width = 571
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha del registro"
end type

type cb_2 from commandbutton within w_antiguedad_cxp
integer x = 1065
integer y = 432
integer width = 334
integer height = 108
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;close(parent)
end event

type st_2 from statictext within w_antiguedad_cxp
integer x = 507
integer y = 228
integer width = 416
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
string text = "Fecha: "
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

