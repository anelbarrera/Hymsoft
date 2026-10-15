forward
global type w_activar_entradas from window
end type
type dw_8 from datawindow within w_activar_entradas
end type
type dw_7 from datawindow within w_activar_entradas
end type
type st_6 from statictext within w_activar_entradas
end type
type dw_5 from datawindow within w_activar_entradas
end type
type st_5 from statictext within w_activar_entradas
end type
type st_4 from statictext within w_activar_entradas
end type
type cb_activar from commandbutton within w_activar_entradas
end type
type st_3 from statictext within w_activar_entradas
end type
type dw_1 from datawindow within w_activar_entradas
end type
type cb_3 from commandbutton within w_activar_entradas
end type
type cb_2 from commandbutton within w_activar_entradas
end type
type cb_1 from commandbutton within w_activar_entradas
end type
type em_ann from editmask within w_activar_entradas
end type
type st_2 from statictext within w_activar_entradas
end type
type st_1 from statictext within w_activar_entradas
end type
type sle_factura from singlelineedit within w_activar_entradas
end type
type dw_2 from datawindow within w_activar_entradas
end type
end forward

global type w_activar_entradas from window
integer width = 5495
integer height = 2784
boolean titlebar = true
string title = "Activacion de Entradas"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "Database!"
boolean center = true
dw_8 dw_8
dw_7 dw_7
st_6 st_6
dw_5 dw_5
st_5 st_5
st_4 st_4
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
dw_2 dw_2
end type
global w_activar_entradas w_activar_entradas

type variables
integer ii_ann

end variables

on w_activar_entradas.create
this.dw_8=create dw_8
this.dw_7=create dw_7
this.st_6=create st_6
this.dw_5=create dw_5
this.st_5=create st_5
this.st_4=create st_4
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
this.dw_2=create dw_2
this.Control[]={this.dw_8,&
this.dw_7,&
this.st_6,&
this.dw_5,&
this.st_5,&
this.st_4,&
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
this.dw_2}
end on

on w_activar_entradas.destroy
destroy(this.dw_8)
destroy(this.dw_7)
destroy(this.st_6)
destroy(this.dw_5)
destroy(this.st_5)
destroy(this.st_4)
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
destroy(this.dw_2)
end on

event open;this.y = 0
this.x = 805
datawindowchild ldwc_suc
em_ann.text = string(year(date(gf_fecha_serv())))
ii_ann = integer(em_ann.text)
sle_factura.setfocus()
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_5.settransobject(sqlca)
dw_7.settransobject(sqlca)
dw_8.settransobject(sqlca)


end event

type dw_8 from datawindow within w_activar_entradas
integer x = 3122
integer y = 1976
integer width = 2139
integer height = 592
integer taborder = 80
string title = "none"
string dataobject = "dw_activar_entrada_detalle_contabilidad"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_7 from datawindow within w_activar_entradas
integer x = 18
integer y = 1976
integer width = 3040
integer height = 284
integer taborder = 70
string title = "none"
string dataobject = "dw_activar_entrada_encab_contabilidad"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_activar_entradas
integer x = 352
integer y = 1880
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

type dw_5 from datawindow within w_activar_entradas
integer x = 46
integer y = 568
integer width = 4603
integer height = 1012
integer taborder = 30
string title = "none"
string dataobject = "dw_activar_entradas_detalle"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_activar_entradas
integer x = 306
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
string text = "DETALLE DE ENTRADA"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_activar_entradas
integer x = 293
integer y = 1612
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
string text = "MOVIMIENTO DE CXP"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_activar from commandbutton within w_activar_entradas
integer x = 3461
integer y = 32
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
//if dw_2.rowcount() <> 1 then return
//if dw_7.rowcount() <> 1 then return

if gf_mensaje('','Esta Seguro de Activar la Entrada ',2,1,'E') = 2 then return

dw_1.setitem(1,'tmov_estado',0)

sqlca.autocommit = false

//Factura
if dw_1.update() = -1 then
	gf_mensaje('','Error en encabezado de factura '+sqlca.sqlerrtext,1,1,'E')
	rollback;
	return
end if

//CXP
dw_2.deleterow(1)
if dw_2.update() = -1 then
	gf_mensaje('','Error en movimiento de cxc '+sqlca.sqlerrtext,1,1,'E')
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

//for i = 1 to dw_5.rowcount()
//	ls_producto = dw_5.getitemstring(i,'faddiari_facd_codigo_item')
//	gf_actualiza_reserva_producto(ls_producto)
//next
//
sle_factura.text = ''
cb_2.triggerevent('clicked')
end event

type st_3 from statictext within w_activar_entradas
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
string text = "ENCABEZADO DE ENTRADA"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_activar_entradas
integer x = 37
integer y = 272
integer width = 3794
integer height = 196
integer taborder = 30
string title = "none"
string dataobject = "dw_activar_entradas_encab"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_activar_entradas
integer x = 2985
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

type cb_2 from commandbutton within w_activar_entradas
integer x = 2149
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

event clicked;string ls_factura, ls_sucursal, ls_documento, ls_producto
long ll_secuencia
Integer li_existe, i
datetime ldt_fecha
ls_factura = sle_factura.text
cb_activar.enabled = true

ll_secuencia = long(ls_factura)

if dw_1.retrieve(str.g_financiero, str.empresa,ll_secuencia,ii_ann) = 0 then 
	cb_activar.enabled = false
else
	ls_documento = dw_1.getitemstring(1,'intmovim_tmov_documento')
end if
if dw_5.retrieve(str.g_financiero, str.empresa,ll_secuencia,ii_ann) = 0 then 
	cb_activar.enabled = false
else
	ldt_fecha = dw_1.getitemdatetime(1,'intmovim_tmov_fecha')
	for i = 1 to dw_5.rowcount()
	  
	  ls_producto = dw_5.getitemstring(i,'indmovim_dmov_producto')
		
	  SELECT count(*)  
		 INTO :li_existe
		 FROM intmovim,   
				indmovim  
		WHERE ( indmovim.dmov_g_financiero = intmovim.tmov_g_financiero ) and  
				( indmovim.dmov_empresa = intmovim.tmov_empresa ) and  
				( indmovim.dmov_aplicacion = intmovim.tmov_aplicacion ) and  
				( indmovim.dmov_tipo_transaccion = intmovim.tmov_tipo_transaccion ) and  
				( indmovim.dmov_concepto = intmovim.tmov_concepto ) and  
				( indmovim.dmov_secuencia = intmovim.tmov_secuencia ) and  
				( indmovim.dmov_anual = intmovim.tmov_anual ) and  
				( ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
				( intmovim.tmov_empresa = :str.empresa ) AND  
				( intmovim.tmov_aplicacion = 'FA' ) AND  
				( intmovim.tmov_tipo_transaccion = 'SA' ) AND  
				( intmovim.tmov_fecha >= :ldt_fecha ) AND  
				( indmovim.dmov_producto = :ls_producto ) )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Buscar Facturas '+sqlca.sqlerrtext,1,1,'E')
				cb_activar.enabled = false
				return
			end if
			
			if li_existe >= 1 and false then
				gf_mensaje('','Existen Facturas Posteriores a la Fecha de la Entrada, Verifique !!!',1,1,'E')
				cb_activar.enabled = false
				return
			end if
			
		next
end if
dw_2.retrieve(str.g_financiero, str.empresa,ls_documento,ii_ann, ls_factura) // = 0 then cb_activar.enabled = false

 dw_7.retrieve(str.g_financiero, str.empresa,ls_documento,ii_ann, ls_factura) //<> 1 then cb_activar.enabled = false
 dw_8.retrieve(str.g_financiero, str.empresa,ls_documento,ii_ann, ls_factura) //= 0 then cb_activar.enabled = false
 
end event

type cb_1 from commandbutton within w_activar_entradas
integer x = 1815
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
String  ls_find,ls_codigo, ls_sucursal
integer li_c, li_b
long    ll_lter, ll_fila
string  ls_lter,ls_des
decimal{2} ld_saldo, ld_limite
Datawindow        dww
str_dg_dynamic_find	lstr_df

	lstr_df.texto_campo [1,1] = "intmovim.tmov_secuencia"
	lstr_df.texto_campo [1,2] = "Secuencia"
	lstr_df.texto_campo [1,3] = "tmov_secuencia"
	lstr_df.texto_campo [1,4] = 'V'
	lstr_df.texto_campo [1,5] = '280'	
	lstr_df.texto_campo [2,1] = "intmovim.tmov_documento"
	lstr_df.texto_campo [2,2] = "Documento"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '315'	
	lstr_df.texto_campo [3,1] = "dgmsubse.subs_descripcion"
	lstr_df.texto_campo [3,2] = "Tipo"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [3,5] = '415'	
	lstr_df.texto_campo [4,1] = "dgmterce.terc_descripcion"
	lstr_df.texto_campo [4,2] = "Proveedor"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '650'
	lstr_df.texto_campo [5,1] = "intmovim.tmov_fecha"
	lstr_df.texto_campo [5,2] = "Fecha"
	lstr_df.texto_campo [5,3] = ""
	lstr_df.texto_campo [5,4] = 'V'
	lstr_df.texto_campo [5,5] = '285'
	lstr_df.texto_campo [6,1] = "intmovim.tmov_documento_entrada"
	lstr_df.texto_campo [6,2] = "Orden / Compra"
	lstr_df.texto_campo [6,3] = ""
	lstr_df.texto_campo [6,4] = 'V'
	lstr_df.texto_campo [6,5] = '420'	
	lstr_df.texto_campo [7,1] = "case when intmovim.tmov_estado = 1 then 'ACTUALIZADA' else 'PENDIENTE' end ESTADO"
	lstr_df.texto_campo [7,2] = "Estado"
	lstr_df.texto_campo [7,3] = ""
	lstr_df.texto_campo [7,4] = 'V'
	lstr_df.texto_campo [7,5] = '280'	
	lstr_df.texto_campo [8,1] = "intmovim.tmov_comentario"
	lstr_df.texto_campo [8,2] = "Observacion"
	lstr_df.texto_campo [8,3] = ""
	lstr_df.texto_campo [8,4] = 'V'
	lstr_df.texto_campo [8,5] = '600'		
	lstr_df.tabla = " intmovim, dgmterce, dgmsubse "
		
	lstr_df.tabla_where = &
				"WHERE (intmovim.tmov_g_financiero = dgmsubse.subs_g_financiero) and " +&
						 "(intmovim.tmov_empresa = dgmsubse.subs_empresa ) 	and " +&
						 "(intmovim.tmov_concepto = dgmsubse.subs_sub_trans ) 	and " +&						 
						 " (intmovim.tmov_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(intmovim.tmov_empresa = " + string(str.empresa) + ") 	and " +&
 						 "(intmovim.tmov_anual = " + string(ii_ann) + ") 	and " +&
						 "(intmovim.tmov_tipo_transaccion = 'EN' ) and (intmovim.tmov_estado = 1 ) and " +&
						"(intmovim.tmov_terceros = dgmterce.terc_tercero)"
			 
	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm


If len (ls_find) = 0 Then Return
	
ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)

sle_factura.text = ls_codigo

cb_2.triggerevent('clicked')
end event

type em_ann from editmask within w_activar_entradas
integer x = 224
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

type st_2 from statictext within w_activar_entradas
integer x = 59
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

type st_1 from statictext within w_activar_entradas
integer x = 1102
integer y = 64
integer width = 233
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Entrada:"
boolean focusrectangle = false
end type

type sle_factura from singlelineedit within w_activar_entradas
integer x = 1349
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

type dw_2 from datawindow within w_activar_entradas
integer x = 18
integer y = 1692
integer width = 4393
integer height = 204
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dw_activar_entradas_cxp"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

