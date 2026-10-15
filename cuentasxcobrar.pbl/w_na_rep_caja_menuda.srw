forward
global type w_na_rep_caja_menuda from w_na_padre_reportes
end type
type cb_1 from commandbutton within w_na_rep_caja_menuda
end type
type st_6 from statictext within w_na_rep_caja_menuda
end type
type em_1 from editmask within w_na_rep_caja_menuda
end type
type em_2 from editmask within w_na_rep_caja_menuda
end type
type st_4 from statictext within w_na_rep_caja_menuda
end type
type sle_2 from singlelineedit within w_na_rep_caja_menuda
end type
type sle_1 from singlelineedit within w_na_rep_caja_menuda
end type
type pb_1 from picturebutton within w_na_rep_caja_menuda
end type
type dw_2 from datawindow within w_na_rep_caja_menuda
end type
type st_7 from statictext within w_na_rep_caja_menuda
end type
type cbx_1 from checkbox within w_na_rep_caja_menuda
end type
type gb_2 from groupbox within w_na_rep_caja_menuda
end type
type gb_3 from groupbox within w_na_rep_caja_menuda
end type
end forward

global type w_na_rep_caja_menuda from w_na_padre_reportes
integer width = 3552
integer height = 1332
string title = "Reporte de Caja Menuda"
string menuname = "m_na_rep"
long backcolor = 12639424
cb_1 cb_1
st_6 st_6
em_1 em_1
em_2 em_2
st_4 st_4
sle_2 sle_2
sle_1 sle_1
pb_1 pb_1
dw_2 dw_2
st_7 st_7
cbx_1 cbx_1
gb_2 gb_2
gb_3 gb_3
end type
global w_na_rep_caja_menuda w_na_rep_caja_menuda

on w_na_rep_caja_menuda.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_na_rep" then this.MenuID = create m_na_rep
this.cb_1=create cb_1
this.st_6=create st_6
this.em_1=create em_1
this.em_2=create em_2
this.st_4=create st_4
this.sle_2=create sle_2
this.sle_1=create sle_1
this.pb_1=create pb_1
this.dw_2=create dw_2
this.st_7=create st_7
this.cbx_1=create cbx_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.st_6
this.Control[iCurrent+3]=this.em_1
this.Control[iCurrent+4]=this.em_2
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.sle_2
this.Control[iCurrent+7]=this.sle_1
this.Control[iCurrent+8]=this.pb_1
this.Control[iCurrent+9]=this.dw_2
this.Control[iCurrent+10]=this.st_7
this.Control[iCurrent+11]=this.cbx_1
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.gb_3
end on

on w_na_rep_caja_menuda.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.st_6)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_4)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.pb_1)
destroy(this.dw_2)
destroy(this.st_7)
destroy(this.cbx_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event resize;//OVERRIDE
this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 475
gb_1.width  = this.width  - 63
gb_1.height = this.height - 415


st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180
this.SetRedraw(true)


end event

event ue_post_open;call super::ue_post_open;string ls_masca
datawindowchild ldwc_barco

if pos(str.empr_acceso_especial, 'OCEAN') > 0 then
	dw_1.dataobject  = 'dw_na_rep_caja_menuda_2o'
	dw_1.settransobject(sqlca)
end if

//pb_1.picturename = str.path+"art\blind.bmp"
pb_1.picturename = str.path+"art\blind.bmp"

dw_2.retrieve()
dw_2.insertrow(0)

dw_1.getchild('ntdesem_desem_transito',ldwc_barco)
ldwc_barco.settransobject(sqlca);
if ldwc_barco.retrieve(str.g_financiero, str.empresa) = 0 then
	ldwc_barco.insertrow(1)
end if


em_2.text = string(date(gf_fecha_serv()),'dd/mm/yyyy')
em_1.text = string(date(year(date(gf_fecha_serv())),month(date(gf_fecha_serv())), 01),'dd/mm/yyyy')


ls_masca = gf_co_mascara_de_cuentas()
dw_1.MODIFY("ntdesem_desem_cuenta_mg.editmask.mask='"+ls_masca+"'")


end event

type st_ayuda from w_na_padre_reportes`st_ayuda within w_na_rep_caja_menuda
end type

type st_nom_ventana from w_na_padre_reportes`st_nom_ventana within w_na_rep_caja_menuda
integer y = 1048
end type

type dw_1 from w_na_padre_reportes`dw_1 within w_na_rep_caja_menuda
integer y = 316
integer width = 3374
integer height = 668
boolean titlebar = true
string dataobject = "dw_na_rep_caja_menuda"
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
end type

type gb_1 from w_na_padre_reportes`gb_1 within w_na_rep_caja_menuda
integer y = 252
integer width = 3410
integer height = 756
long backcolor = 12639424
end type

type cb_1 from commandbutton within w_na_rep_caja_menuda
integer x = 2999
integer y = 72
integer width = 430
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Consultar"
end type

event clicked;string ls_transito, ls_para, ls_cargo,ls_fecha_1,ls_fecha_2
decimal ldec_remesas
datetime ldt_desde, ldt_hasta

//ls_transito = sle_1.text
ls_fecha_1 = em_1.text
//ls_fecha_1 = mid(ls_fecha_1, 4,2) + '/'+left(ls_fecha_1, 2) +'/'+ Mid(ls_fecha_1,7,4)
ldt_desde = datetime(date(ls_fecha_1),Time("00:00:00") )
ls_fecha_2 = em_2.text
//ls_fecha_2 = mid(ls_fecha_2, 4,2) + '/'+left(ls_fecha_2, 2) +'/'+ Mid(ls_fecha_2,7,4)
ldt_hasta = datetime(date(ls_fecha_2) ,Time("23:59:59") )

dw_1.retrieve(str.g_financiero, str.empresa, ldt_desde, ldt_hasta )
dw_1.groupcalc()

//messagebox('', "natdesem_desem_caja ='" + dw_2.getitemstring(dw_2.getrow(), 'caja') +"'")

if dw_2.getitemstring(dw_2.getrow(), 'caja') = '' or isnull(dw_2.getitemstring(dw_2.getrow(),'caja')) then
	dw_1.setfilter("")
	dw_1.filter()
else
	IF cbx_1.checked = true THEN
		dw_1.setfilter("ntdesem_desem_caja = '" + dw_2.getitemstring(dw_2.getrow(),'caja') + "'" + " and ntdesem_desem_status in('A','R')" )
		dw_1.filter()
	ELSE
		dw_1.setfilter("ntdesem_desem_caja = '" + dw_2.getitemstring(dw_2.getrow(),'caja') +"'" + " and ntdesem_desem_status = 'S'")
		dw_1.filter()
	END IF
end if

dw_1.groupcalc()

if dw_1.rowcount() = 0 then
	messagebox('Atención', 'No se encontraron registros para estos parámetros.')
	return
end if
end event

type st_6 from statictext within w_na_rep_caja_menuda
integer x = 101
integer y = 96
integer width = 187
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12639424
string text = "Desde:"
boolean focusrectangle = false
end type

type em_1 from editmask within w_na_rep_caja_menuda
integer x = 297
integer y = 84
integer width = 448
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean spin = true
end type

type em_2 from editmask within w_na_rep_caja_menuda
integer x = 969
integer y = 84
integer width = 416
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean spin = true
end type

type st_4 from statictext within w_na_rep_caja_menuda
integer x = 882
integer y = 96
integer width = 64
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12639424
string text = "al:"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_na_rep_caja_menuda
boolean visible = false
integer x = 2574
integer y = 80
integer width = 713
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_na_rep_caja_menuda
boolean visible = false
integer x = 2158
integer y = 80
integer width = 411
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type pb_1 from picturebutton within w_na_rep_caja_menuda
boolean visible = false
integer x = 3291
integer y = 72
integer width = 105
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
alignment htextalign = left!
end type

event clicked;long ll_found
String ls_find,ls_codigo, ls_nombre, ls_sin, ls_nave

str_dg_dynamic_find	lstr_df

lstr_df.texto_campo [1,1] = "natransito.tran_transito"
lstr_df.texto_campo [1,2] = "Transito"
lstr_df.texto_campo [1,3] = "nav_sin"
lstr_df.texto_campo [1,4] = 'V'

lstr_df.texto_campo [3,1] = "convert(char, natransito.tran_fecha_llegada)"
lstr_df.texto_campo [3,2] = "ETA"
lstr_df.texto_campo [3,3] = ""
lstr_df.texto_campo [3,4] = 'V'
lstr_df.texto_campo [3,5] = '345'

lstr_df.texto_campo [2,1] = "nanave.nav_nombre"
lstr_df.texto_campo [2,2] = "Barco / Nave"
lstr_df.texto_campo [2,3] = ""
lstr_df.texto_campo [2,4] = 'V'
lstr_df.texto_campo [2,5] = '600'

lstr_df.texto_campo [4,1] = "nampuerto.mpuert_nombre"
lstr_df.texto_campo [4,2] = "Visita"
lstr_df.texto_campo [4,3] = ""
lstr_df.texto_campo [4,4] = 'V'

lstr_df.tabla = "natransito, nanave, nampuerto"

lstr_df.tabla_where = &
			"WHERE (natransito.tran_g_financiero = " + string(str.g_financiero) + " and " +&
					 "natransito.tran_empresa = " + string(str.empresa) + ") and " +&
					 "(natransito.tran_g_financiero = nanave.nav_g_financiero ) and " +&
					 "(natransito.tran_empresa = nanave.nav_empresa ) and " +&
 					 "(natransito.tran_sin = nanave.nav_sin ) and " +&
					 "(natransito.tran_puerto *= nampuerto.mpuert_puerto) "

OpenWithParm(w_dg_a_custom_find, lstr_df)
ls_find = Message.StringParm

ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)

if ls_codigo = '' or isnull(ls_codigo) then return

  SELECT natransito.tran_sin  
    INTO :ls_sin  
    FROM natransito  
   WHERE ( natransito.tran_g_financiero = :str.g_financiero ) AND  
         ( natransito.tran_empresa = :str.empresa ) AND  
         ( natransito.tran_transito = :ls_codigo )   ;
	if sqlca.sqlcode = -1 then
		mensaje('Error', 'Erro al Selecionar registrs em NATRANSITO', sqlca.sqlerrtext)		
		return
	end if

  SELECT nanave.nav_nombre  
    INTO :ls_nave  
    FROM nanave  
   WHERE ( nanave.nav_g_financiero = :str.g_financiero ) AND  
         ( nanave.nav_empresa = :str.empresa ) AND  
         ( nanave.nav_sin = :ls_sin )   ;
	if sqlca.sqlcode = -1 then
		mensaje('Error', 'Erro al Selecionar registrs em NANAVE', sqlca.sqlerrtext)		
		return
	end if

sle_1.text = ls_codigo
sle_2.text = ls_nave

dw_1.setfilter("natdesem_desem_transito = '" + ls_codigo +"'")
dw_1.filter()

dw_1.groupcalc()

end event

type dw_2 from datawindow within w_na_rep_caja_menuda
integer x = 1765
integer y = 56
integer width = 1019
integer height = 88
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "dw_na_ext_caja"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type st_7 from statictext within w_na_rep_caja_menuda
integer x = 1614
integer y = 72
integer width = 151
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12639424
string text = "Caja:"
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_na_rep_caja_menuda
integer x = 1765
integer y = 160
integer width = 1106
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12639424
string text = "Comprobantes Actualizados"
boolean checked = true
end type

type gb_2 from groupbox within w_na_rep_caja_menuda
boolean visible = false
integer x = 2107
integer y = 8
integer width = 1335
integer height = 204
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
long textcolor = 8388608
long backcolor = 67108864
string text = "Tránsito"
end type

type gb_3 from groupbox within w_na_rep_caja_menuda
integer x = 41
integer y = 8
integer width = 2871
integer height = 236
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
long textcolor = 8388608
long backcolor = 12639424
string text = "Rango de Fechas"
end type

