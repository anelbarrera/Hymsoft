forward
global type w_activar_factura from window
end type
type dw_8 from datawindow within w_activar_factura
end type
type dw_7 from datawindow within w_activar_factura
end type
type st_6 from statictext within w_activar_factura
end type
type dw_6 from datawindow within w_activar_factura
end type
type dw_5 from datawindow within w_activar_factura
end type
type dw_4 from datawindow within w_activar_factura
end type
type st_5 from statictext within w_activar_factura
end type
type st_4 from statictext within w_activar_factura
end type
type dw_2 from datawindow within w_activar_factura
end type
type cb_activar from commandbutton within w_activar_factura
end type
type st_3 from statictext within w_activar_factura
end type
type dw_1 from datawindow within w_activar_factura
end type
type cb_3 from commandbutton within w_activar_factura
end type
type cb_2 from commandbutton within w_activar_factura
end type
type cb_1 from commandbutton within w_activar_factura
end type
type em_ann from editmask within w_activar_factura
end type
type st_2 from statictext within w_activar_factura
end type
type st_1 from statictext within w_activar_factura
end type
type sle_factura from singlelineedit within w_activar_factura
end type
type dw_3 from datawindow within w_activar_factura
end type
end forward

global type w_activar_factura from window
integer width = 5495
integer height = 3060
boolean titlebar = true
string title = "Activacion de Factura"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_8 dw_8
dw_7 dw_7
st_6 st_6
dw_6 dw_6
dw_5 dw_5
dw_4 dw_4
st_5 st_5
st_4 st_4
dw_2 dw_2
cb_activar cb_activar
st_3 st_3
dw_1 dw_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
em_ann em_ann
st_2 st_2
st_1 st_1
sle_factura sle_factura
dw_3 dw_3
end type
global w_activar_factura w_activar_factura

type variables
integer ii_ann
end variables

on w_activar_factura.create
this.dw_8=create dw_8
this.dw_7=create dw_7
this.st_6=create st_6
this.dw_6=create dw_6
this.dw_5=create dw_5
this.dw_4=create dw_4
this.st_5=create st_5
this.st_4=create st_4
this.dw_2=create dw_2
this.cb_activar=create cb_activar
this.st_3=create st_3
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.em_ann=create em_ann
this.st_2=create st_2
this.st_1=create st_1
this.sle_factura=create sle_factura
this.dw_3=create dw_3
this.Control[]={this.dw_8,&
this.dw_7,&
this.st_6,&
this.dw_6,&
this.dw_5,&
this.dw_4,&
this.st_5,&
this.st_4,&
this.dw_2,&
this.cb_activar,&
this.st_3,&
this.dw_1,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.em_ann,&
this.st_2,&
this.st_1,&
this.sle_factura,&
this.dw_3}
end on

on w_activar_factura.destroy
destroy(this.dw_8)
destroy(this.dw_7)
destroy(this.st_6)
destroy(this.dw_6)
destroy(this.dw_5)
destroy(this.dw_4)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.dw_2)
destroy(this.cb_activar)
destroy(this.st_3)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.em_ann)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_factura)
destroy(this.dw_3)
end on

event open;this.y = 0
this.x = 805

em_ann.text = string(year(date(gf_fecha_serv())))
ii_ann = integer(em_ann.text)
sle_factura.setfocus()
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_5.settransobject(sqlca)
dw_6.settransobject(sqlca)
dw_7.settransobject(sqlca)
dw_8.settransobject(sqlca)
end event

type dw_8 from datawindow within w_activar_factura
integer x = 3122
integer y = 2220
integer width = 2139
integer height = 592
integer taborder = 80
string title = "none"
string dataobject = "dw_activar_factura_detalle_contabilidad"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_7 from datawindow within w_activar_factura
integer x = 18
integer y = 2220
integer width = 3040
integer height = 284
integer taborder = 70
string title = "none"
string dataobject = "dw_activar_factura_encab_contabilidad"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_activar_factura
integer x = 352
integer y = 2124
integer width = 837
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "MOVIMIENTO DE CONTABILIDAD"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_6 from datawindow within w_activar_factura
integer x = 3227
integer y = 1128
integer width = 1545
integer height = 560
integer taborder = 70
string title = "none"
string dataobject = "dw_activar_factura_gastos_inventario"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_5 from datawindow within w_activar_factura
integer x = 4091
integer y = 100
integer width = 1216
integer height = 408
integer taborder = 30
string title = "none"
string dataobject = "dw_activar_factura_detalle_factura"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_4 from datawindow within w_activar_factura
integer x = 37
integer y = 1128
integer width = 2994
integer height = 964
integer taborder = 60
string title = "none"
string dataobject = "dw_activar_factura_detalle_inventario"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_activar_factura
integer x = 311
integer y = 812
integer width = 777
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "MOVIMIENTO DE INVENTARIO"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_activar_factura
integer x = 311
integer y = 484
integer width = 777
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "MOVIMIENTO DE CXC"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_activar_factura
integer x = 37
integer y = 560
integer width = 5289
integer height = 204
integer taborder = 40
string title = "none"
string dataobject = "dw_activar_factura_movimiento_cxc"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_activar from commandbutton within w_activar_factura
integer x = 3387
integer y = 48
integer width = 539
integer height = 132
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "ACTIVAR"
end type

event clicked;string ls_factura, ls_producto
integer i, ll_total

ls_factura = sle_factura.text

if len(ls_factura) = 0 then return
if dw_1.rowcount() <> 1 then return
if dw_2.rowcount() <> 1 then return
if dw_3.rowcount() <> 1 then return
if dw_7.rowcount() <> 2 then return

if gf_mensaje('','Esta Seguro de Activar la Factura ',2,1,'E') = 2 then return

dw_1.setitem(1,'fact_estado','A')
dw_1.setitem(1,'fact_act_cliente',0)
dw_1.setitem(1,'fact_act_inventario',0)
dw_1.setitem(1,'fact_act_conta',0)


sqlca.autocommit = false

//Factura
if dw_1.update() = -1 then
	gf_mensaje('','Error en encabezado de factura '+sqlca.sqlerrtext,1,1,'E')
	rollback;
	return
end if

//CXC
dw_2.deleterow(1)
if dw_2.update() = -1 then
	gf_mensaje('','Error en movimiento de cxc '+sqlca.sqlerrtext,1,1,'E')
	rollback;
	return
end if
//////Inventarios
ll_total = dw_4.rowcount()
for i = 1 to ll_total
	dw_4.deleterow(1)
next
if dw_4.update() = -1 then
	gf_mensaje('','Error en Detalle de inventarios '+sqlca.sqlerrtext,1,1,'E')
	rollback;
	return
end if
ll_total = dw_6.rowcount()
for i = 1 to ll_total
	dw_6.deleterow(1)
next
if dw_6.update() = -1 then
	gf_mensaje('','Error en gastos de inventarios '+sqlca.sqlerrtext,1,1,'E')
	rollback;
	return
end if

dw_3.deleterow(1)
if dw_3.update() = -1 then
	gf_mensaje('','Error en Encabezado de inventarios '+sqlca.sqlerrtext,1,1,'E')
	rollback;
	return
end if
//Contabilidad
ll_total = dw_8.rowcount()
for i = 1 to ll_total
	dw_8.deleterow(1)
next
if dw_8.update() = -1 then
	gf_mensaje('','Error en Detalle de Contabilidad '+sqlca.sqlerrtext,1,1,'E')
	rollback;
	return
end if

ll_total = dw_7.rowcount()
for i = 1 to ll_total
	dw_7.deleterow(1)
next
if dw_7.update() = -1 then
	gf_mensaje('','Error en Encabezado de Contabilidad '+sqlca.sqlerrtext,1,1,'E')
	rollback;
	return
end if
	
commit;
sqlca.autocommit = true

for i = 1 to dw_5.rowcount()
	ls_producto = dw_5.getitemstring(i,'faddiari_facd_codigo_item')
	gf_actualiza_reserva_producto(ls_producto)
next
str.frame.setmicrohelp('Listo')
sle_factura.text = ''
cb_2.triggerevent('clicked')
end event

type st_3 from statictext within w_activar_factura
integer x = 297
integer y = 192
integer width = 777
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "ENCABEZADO DE FACTURA"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_activar_factura
integer x = 37
integer y = 272
integer width = 4037
integer height = 196
integer taborder = 30
string title = "none"
string dataobject = "dw_activar_factura_encab_factura"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_activar_factura
integer x = 2633
integer y = 36
integer width = 434
integer height = 128
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
end type

event clicked;close(parent)
end event

type cb_2 from commandbutton within w_activar_factura
integer x = 2117
integer y = 36
integer width = 434
integer height = 128
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
boolean default = true
end type

event clicked;string ls_factura
long ll_secuencia

ls_factura = sle_factura.text
cb_activar.enabled = true

if dw_1.retrieve(str.g_financiero, str.empresa,ls_factura,ii_ann) = 0 then cb_activar.enabled = false
if dw_5.retrieve(str.g_financiero, str.empresa,ls_factura,ii_ann) = 0 then cb_activar.enabled = false
if dw_2.retrieve(str.g_financiero, str.empresa,ls_factura,ii_ann) = 0 then cb_activar.enabled = false
if dw_3.retrieve(str.g_financiero, str.empresa,ls_factura,ii_ann) = 0 then cb_activar.enabled = false
if dw_4.retrieve(str.g_financiero, str.empresa,ls_factura,ii_ann) = 0 then cb_activar.enabled = false
if dw_5.rowcount() <> dw_4.rowcount() then cb_activar.enabled = false
if dw_3.rowcount() > 0 then
	ll_secuencia = dw_3.getitemnumber(1,'tmov_secuencia')
	 dw_6.retrieve(str.g_financiero, str.empresa,ll_secuencia,ii_ann)
end if

 if dw_7.retrieve(str.g_financiero, str.empresa,ls_factura,ii_ann) <> 2 then cb_activar.enabled = false
 if dw_8.retrieve(str.g_financiero, str.empresa,ls_factura,ii_ann) = 0 then cb_activar.enabled = false
 
end event

type cb_1 from commandbutton within w_activar_factura
integer x = 1367
integer y = 36
integer width = 261
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Buscar"
end type

event clicked;
String  ls_find,ls_codigo
integer li_c, li_b
long    ll_lter, ll_fila
string  ls_lter,ls_des
decimal{2} ld_saldo, ld_limite
Datawindow        dww
str_dg_dynamic_find	lstr_df

	lstr_df.texto_campo [1,1] = "fatdiari.fact_no_factura"
	lstr_df.texto_campo [1,2] = "Factura"
	lstr_df.texto_campo [1,3] = "fact_no_factura"
	lstr_df.texto_campo [1,4] = 'V'
	lstr_df.texto_campo [1,5] = '320'	
	lstr_df.texto_campo [2,1] = "fatdiari.fact_no_pedido"
	lstr_df.texto_campo [2,2] = "Pedido"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '220'	
	lstr_df.texto_campo [3,1] = "fatdiari.fact_a_nombre"
	lstr_df.texto_campo [3,2] = "A Nombre de"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [3,5] = '650'
	lstr_df.texto_campo [4,1] = "fatdiari.fact_fecha"
	lstr_df.texto_campo [4,2] = "Fecha"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '285'
	lstr_df.texto_campo [5,1] = "case fatdiari.fact_estado when 'E' then 'ANULADA' when 'I' then 'IMPRESA' else 'PENDIENTE' end fact_estado"
	lstr_df.texto_campo [5,2] = "Estado"
	lstr_df.texto_campo [5,3] = ""
	lstr_df.texto_campo [5,4] = 'V'
	lstr_df.texto_campo [5,5] = '240'
	lstr_df.texto_campo [6,1] = "fact_monto_final"
	lstr_df.texto_campo [6,2] = "Monto"
	lstr_df.texto_campo [6,3] = ""
	lstr_df.texto_campo [6,4] = 'V'
	lstr_df.texto_campo [7,1] = "case fatdiari.fact_nota_credito when 1 then 'SI' else 'NO' end fact_nota_credito"
	lstr_df.texto_campo [7,2] = "Nota Cr."
	lstr_df.texto_campo [7,3] = ""
	lstr_df.texto_campo [7,4] = 'V'
	lstr_df.texto_campo [7,5] = '180'

	lstr_df.tabla = " fatdiari "
		
	lstr_df.tabla_where = &
				"WHERE (fatdiari.fact_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(fatdiari.fact_empresa = " + string(str.empresa) + ") 	and " +&
 						 "(fatdiari.fact_ann = " + string(ii_ann) + ") and " + &
						 " fact_estado = 'I'" 						 
	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm


If len (ls_find) = 0 Then Return
	
ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)

sle_factura.text = ls_codigo

cb_2.triggerevent('clicked')
end event

type em_ann from editmask within w_activar_factura
integer x = 347
integer y = 40
integer width = 247
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "###0"
boolean spin = true
double increment = 1
end type

event modified;string ls_factura
ii_ann = long(em_ann.text)
ls_factura = sle_factura.text


if len(ls_factura) = 0 then return
if dw_1.rowcount() = 0 then return

dw_1.setitem(1,'fact_estado','A')
dw_1.setitem(1,'fact_act_cliente',0)
dw_1.setitem(1,'fact_act_inventario',0)
dw_1.setitem(1,'fact_act_conta',0)

end event

type st_2 from statictext within w_activar_factura
integer x = 183
integer y = 64
integer width = 178
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_activar_factura
integer x = 649
integer y = 64
integer width = 238
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Factura:"
boolean focusrectangle = false
end type

type sle_factura from singlelineedit within w_activar_factura
integer x = 914
integer y = 40
integer width = 402
integer height = 104
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;cb_2.triggerevent('clicked')
end event

type dw_3 from datawindow within w_activar_factura
integer x = 37
integer y = 904
integer width = 5289
integer height = 204
integer taborder = 50
string title = "none"
string dataobject = "dw_activar_factura_encab_inventario"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

