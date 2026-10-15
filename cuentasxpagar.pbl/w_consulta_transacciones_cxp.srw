//objectcomments Consulta de transacciones de clientes Vista Previa
forward
global type w_consulta_transacciones_cxp from w_fa_padre_reportes
end type
type st_sel_marca from statictext within w_consulta_transacciones_cxp
end type
type ddlb_1 from dropdownlistbox within w_consulta_transacciones_cxp
end type
type dw_2 from datawindow within w_consulta_transacciones_cxp
end type
type st_1 from statictext within w_consulta_transacciones_cxp
end type
type st_2 from statictext within w_consulta_transacciones_cxp
end type
type dw_3 from datawindow within w_consulta_transacciones_cxp
end type
type st_3 from statictext within w_consulta_transacciones_cxp
end type
type em_ann from editmask within w_consulta_transacciones_cxp
end type
type st_4 from statictext within w_consulta_transacciones_cxp
end type
type em_documento from editmask within w_consulta_transacciones_cxp
end type
type cb_consultar from commandbutton within w_consulta_transacciones_cxp
end type
type cb_2 from commandbutton within w_consulta_transacciones_cxp
end type
type pb_1 from picturebutton within w_consulta_transacciones_cxp
end type
type st_5 from statictext within w_consulta_transacciones_cxp
end type
type em_referencia from editmask within w_consulta_transacciones_cxp
end type
end forward

global type w_consulta_transacciones_cxp from w_fa_padre_reportes
integer width = 3739
integer height = 2680
string title = "Consulta de Transacciones de Cuentas por Pagar"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 12639424
string icon = "AppIcon!"
st_sel_marca st_sel_marca
ddlb_1 ddlb_1
dw_2 dw_2
st_1 st_1
st_2 st_2
dw_3 dw_3
st_3 st_3
em_ann em_ann
st_4 st_4
em_documento em_documento
cb_consultar cb_consultar
cb_2 cb_2
pb_1 pb_1
st_5 st_5
em_referencia em_referencia
end type
global w_consulta_transacciones_cxp w_consulta_transacciones_cxp

type variables
str_fa_ventafact str_informe
datawindowchild idwc_tran, idwc_subtran

end variables

on w_consulta_transacciones_cxp.create
int iCurrent
call super::create
this.st_sel_marca=create st_sel_marca
this.ddlb_1=create ddlb_1
this.dw_2=create dw_2
this.st_1=create st_1
this.st_2=create st_2
this.dw_3=create dw_3
this.st_3=create st_3
this.em_ann=create em_ann
this.st_4=create st_4
this.em_documento=create em_documento
this.cb_consultar=create cb_consultar
this.cb_2=create cb_2
this.pb_1=create pb_1
this.st_5=create st_5
this.em_referencia=create em_referencia
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_sel_marca
this.Control[iCurrent+2]=this.ddlb_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.dw_3
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.em_ann
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.em_documento
this.Control[iCurrent+11]=this.cb_consultar
this.Control[iCurrent+12]=this.cb_2
this.Control[iCurrent+13]=this.pb_1
this.Control[iCurrent+14]=this.st_5
this.Control[iCurrent+15]=this.em_referencia
end on

on w_consulta_transacciones_cxp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_sel_marca)
destroy(this.ddlb_1)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_3)
destroy(this.st_3)
destroy(this.em_ann)
destroy(this.st_4)
destroy(this.em_documento)
destroy(this.cb_consultar)
destroy(this.cb_2)
destroy(this.pb_1)
destroy(this.st_5)
destroy(this.em_referencia)
end on

event ue_post_open;//Override

//override
string  ls_dinero, ls_tran, ls_documento, ls_stran, ls_mascara, ls_ref
Integer li_ann, li_historico

dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)

dw_2.getchild('transaccion', idwc_tran)
dw_3.getchild('transaccion', idwc_subtran)

idwc_tran.settransobject(sqlca)
idwc_subtran.settransobject(sqlca)

idwc_tran.retrieve(str.g_financiero, str.empresa)
idwc_subtran.retrieve(str.g_financiero, str.empresa)

dw_2.insertrow(1)
dw_3.insertrow(1)

str_secuencia_doc lstr_sec
lstr_sec = Message.PowerObjectParm
if isvalid(lstr_sec) then 
	ls_documento = lstr_sec.sec_manual
	ls_ref		 = lstr_sec.referencia
	em_referencia.text = ls_ref
	li_ann	 = lstr_sec.ano
	ls_tran	 = lstr_sec.tran
	ls_stran	 = lstr_sec.subtran
	em_ann.text = string(li_ann)
	dw_2.setitem(1,'transaccion',ls_tran)
	idwc_subtran.setfilter("dgmsubse_subs_transaccion = '"+ls_tran+"'")
	idwc_subtran.filter()
	dw_3.setitem(1,'transaccion',ls_stran)	
	em_documento.text = ls_documento
	em_documento.setfocus()
else
	em_ann.text = string(year(date(gf_fecha_serv())))
end if

if ls_documento <> '' and not isnull(ls_documento) then
	
	  SELECT max(movi_historico)  
		 INTO :li_historico  
		 FROM cptmovim  
		WHERE ( cptmovim.movi_g_financiero = :str.g_financiero ) AND  
				( cptmovim.movi_empresa = :str.empresa ) AND  
			//	( cptmovim.movi_aplicacion = 'CP' ) AND  
				( cptmovim.movi_tipo_transaccion = :ls_tran ) AND  
				( cptmovim.movi_documento = :ls_documento ) AND  
				( cptmovim.movi_anno = :li_ann )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al buscar historico '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
	
	if li_historico = 1 then
		dw_1.dataobject = 'dw_imprimir_cxp_historico'
	else
		dw_1.dataobject = 'dw_imprimir_cxp'
	end if
	
	dw_1.settransobject(sqlca)	
	
	if dw_1.retrieve(str.g_financiero, str.empresa, ls_tran, ls_documento, li_ann, ls_ref) > 0 then
		ls_dinero =  upper(gf_numerlet(dw_1.getitemnumber(1,'movi_monto_final'),1))
		if dw_1.describe("numero_letra.x") <> "!" and dw_1.describe("numero_letra.x") <> "?"then				
			dw_1.object.numero_letra.expression = "'"+ls_dinero+"'"
		end if
	   ls_mascara = gf_mascara()
      dw_1.MODIFY("ddia_mg_cuenta.editmask.mask='"+ls_mascara+"'") //mascara para el compute de la cuenta
	else
		gf_mensaje('','Transaccion no Registrada, Verifique!!!',1,1,'E')
		return
	end if		
end if

//Para setear el nombre de la Cia. al DW de impresion.
If dw_1.Describe("nom_empresa.x") <> "?" And dw_1.Describe("nom_empresa.x") <> "!" Then
	dw_1.object.nom_empresa.expression = "'"+ gf_dg_nombre_empresa() +"'"
End If	
//
dw_1.object.datawindow.print.preview = True
dw_1.object.datawindow.print.preview.zoom = 100




end event

event resize;//Override
this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 278
gb_1.width  = this.width  - 63
gb_1.height = this.height - 220


st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180

ddlb_1.y = this.height - 200
ddlb_1.X = (this.width - 70) - ddlb_1.width 

st_sel_marca.y = this.height - 200
st_sel_marca.X = (this.width - 70) - ddlb_1.width - st_sel_marca.width -100

this.SetRedraw(true)

end event

event open;/***************************/
//gf_center_win(This)
//gf_acelerador()
/**************************/

dw = dw_1
dw_impresion = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()

//Configurar los Accesos
//mf_accesos(this.menuid, this)

This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)
str.frame.SetRedraw ( True )

This.Icon = str.icono
this.postevent("ue_post_open")

//str_informe = Message.PowerObjectParm
this.y = 0
this.x = 805

end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_consulta_transacciones_cxp
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_consulta_transacciones_cxp
boolean visible = false
integer x = 32
integer y = 1384
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_consulta_transacciones_cxp
integer x = 41
integer y = 236
integer width = 3662
integer height = 2220
string dataobject = "dw_imprimir_cxp"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::doubleclicked;call super::doubleclicked;string         ls_pointer
long           li_fila
datetime       ldt_fecha1
window		   lw_child
str_rangofecha	str_rangofecha_opcion
str_fa_bus_var str_busqueda

//If pos(upper(str.nombre_empresa),'ELECTROVISION') > 0 Then 
if w_fa_fondo.str_aplica_links.habilita_links = 1	then
	ls_pointer = dw_1.GetObjectAtPointer()
	li_fila = integer(trim(mid(ls_pointer,7)))
	if pos(ls_pointer,'numero') > 0 then 
		str_rangofecha_opcion.opcion = 'Kardex'
		str_rangofecha_opcion.orden = dw_1.getitemstring(li_fila,'fact_no_factura')
		if w_fa_fondo.str_aplica_links.factura_activa_fa = 'A' then
			OpenSheetWithParm(lw_child,str_rangofecha_opcion,"w_fa_co_facturas_cab_det_99_e",str.frame,11,Original!)
		end if
	else
		if pos(ls_pointer,'nomcli') > 0 then 
			str_rangofecha_opcion.opcion = 'Kardex'
			str_rangofecha_opcion.cliente = dw_1.getitemnumber(li_fila,'terc_tercero')
//			ldt_fecha1 = dw_1.getitemdatetime(li_fila,'fact_fecha')
			str_rangofecha_opcion.fecha1 = date('01/01/1990')
			if w_fa_fondo.str_aplica_links.cxc_activa_cc = 'A' then
				OpenSheetWithParm(lw_child,str_rangofecha_opcion,"w_fa_co_mov_cliente_saldo",str.frame,11,Original!)
			end if
		end if
	end if
end if 

//	dw_3.Object.dmov_secuencia.Pointer = 'Cross!'

end event

event dw_1::ue_microayuda;//override
//Para cuando pasa por encima del objeto
//Override

Integer li_pos, li_x, li_y,li_largo
String ls_objeto, ls_col

ls_objeto = This.GetObjectAtPointer()
li_pos = pos  (ls_objeto,"~t")
ls_col = left (ls_objeto, li_pos - 1)

//li_x	 = str.frame.GetActiveSheet ().PointerX () 
//li_largo = len("Haga click para ordenar por la Columna de " + this.describe(ls_col+".text"))*28


//li_y	 = str.frame.GetActiveSheet ().PointerY () - 200

// Dependiendo de la Columna el Mensaje de Ayuda varía
CHOOSE CASE ls_col
	CASE 'cctmovim_movi_a_nombre'
		this.Modify("cctmovim_movi_a_nombre.Font.Underline='1'")
		this.Modify("cctmovim_movi_a_nombre.Color='7536640'")

	CASE ELSE
		this.Modify("cctmovim_movi_a_nombre.Font.Underline='0'")
		this.Modify("cctmovim_movi_a_nombre.Color='0'")

END CHOOSE
end event

event dw_1::clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto, ls_column
integer li_pos 

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

ls_column = dwo.name

if ls_column = 'cptmovim_movi_a_nombre' then
	str_cc_formatos str_formato1		
	str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	str_formato1.tercero = dw_1.getitemNumber(1,"cptmovim_movi_tercero")
	OpenSheetwithparm(w_mant_proveedores,str_formato1,parent,2, Original!)
	
end if
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_consulta_transacciones_cxp
integer x = 27
integer y = 192
integer width = 2967
integer height = 1364
long backcolor = 12639424
end type

type st_sel_marca from statictext within w_consulta_transacciones_cxp
boolean visible = false
integer x = 1541
integer y = 1408
integer width = 640
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleccione la Marca"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_consulta_transacciones_cxp
boolean visible = false
integer x = 2240
integer y = 1388
integer width = 754
integer height = 244
integer taborder = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
boolean vscrollbar = true
string item[] = {"NATURAL EXCHANGE","PUNTOCOM","TODAS"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String	ls_filtro
ls_filtro = 'PC'

if index = 1 then	//NATURAL
	dw_1.setFilter("fact_ruc_cliente not like '" +ls_filtro+ "%'")
	dw_1.filter()
	dw_1.groupcalc()
elseIf index = 2 then //PUNTO COM
	dw_1.setFilter( "fact_ruc_cliente like '" +ls_filtro+ "%'")
	dw_1.filter()
	dw_1.groupcalc()
elseIf index = 3 then //TOTAL
	ls_filtro = 'XX'
	dw_1.setFilter( "fact_ruc_cliente not like '" +ls_filtro+ "%'")
	dw_1.filter()
	dw_1.groupcalc()
end if

end event

type dw_2 from datawindow within w_consulta_transacciones_cxp
integer x = 576
integer width = 1106
integer height = 100
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_transaccion_cxp"
boolean livescroll = true
end type

event itemchanged;	if data = 'RC' then
		dw_1.dataobject = 'dw_imprimir_recibo'
	else
		dw_1.dataobject = 'dw_imprimir_transacciones'
	end if	
	dw_1.settransobject(sqlca)	
	
idwc_subtran.setfilter("dgmsubse_subs_transaccion = '"+data+"'")
idwc_subtran.filter()
if idwc_subtran.rowcount() > 0 then
	dw_3.setitem(1,'transaccion',idwc_subtran.getitemstring(1,'dgmsubse_subs_sub_trans'))
end if
em_documento.setfocus()
end event

type st_1 from statictext within w_consulta_transacciones_cxp
integer x = 174
integer y = 8
integer width = 402
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Transacción:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_consulta_transacciones_cxp
integer x = 32
integer y = 120
integer width = 535
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Sub. Transacción:"
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_consulta_transacciones_cxp
integer x = 576
integer y = 104
integer width = 1111
integer height = 100
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_sub_transaccion_cxp"
boolean livescroll = true
end type

type st_3 from statictext within w_consulta_transacciones_cxp
integer x = 1701
integer y = 64
integer width = 165
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Año:"
boolean focusrectangle = false
end type

type em_ann from editmask within w_consulta_transacciones_cxp
integer x = 1838
integer y = 52
integer width = 206
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
string mask = "###0"
end type

type st_4 from statictext within w_consulta_transacciones_cxp
integer x = 2057
integer y = 40
integer width = 343
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Documento:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_documento from editmask within w_consulta_transacciones_cxp
integer x = 2391
integer y = 12
integer width = 306
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
maskdatatype maskdatatype = stringmask!
end type

type cb_consultar from commandbutton within w_consulta_transacciones_cxp
integer x = 2976
integer y = 48
integer width = 343
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
boolean default = true
end type

event clicked;string ls_dinero, ls_tran, ls_documento, ls_mascara, ls_ref
integer li_ann, li_historico

li_ann = integer(em_ann.text)
ls_documento = em_documento.text
ls_ref = em_referencia.text
ls_tran = dw_2.getitemstring(1,'transaccion')

  SELECT max(movi_historico)  
		 INTO :li_historico  
		 FROM cptmovim  
		WHERE ( cptmovim.movi_g_financiero = :str.g_financiero ) AND  
				( cptmovim.movi_empresa = :str.empresa ) AND  
//				( cptmovim.movi_aplicacion = 'CP' ) AND  
				( cptmovim.movi_tipo_transaccion = :ls_tran ) AND  
				( cptmovim.movi_documento = :ls_documento ) AND  
				( cptmovim.movi_anno = :li_ann )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al buscar historico '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
	
	if li_historico = 1 then
		dw_1.dataobject = 'dw_imprimir_cxp_historico'
	else
		dw_1.dataobject = 'dw_imprimir_cxp'
	end if
	
	dw_1.settransobject(sqlca)		

if dw_1.retrieve(str.g_financiero, str.empresa, ls_tran, ls_documento, li_ann, ls_ref) > 0 then
	ls_dinero =  upper(gf_numerlet(dw_1.getitemnumber(1,'movi_monto_final'),1))
	if dw_1.describe("numero_letra.x") <> "!" and dw_1.describe("numero_letra.x") <> "?"then				
		dw_1.object.numero_letra.expression = "'"+ls_dinero+"'"
	end if
   ls_mascara = gf_mascara()
   dw_1.MODIFY("ddia_mg_cuenta.editmask.mask='"+ls_mascara+"'") //mascara para el compute de la cuenta
else
	gf_mensaje('','Transaccion no Registrada, Verifique!!!',1,1,'E')
	return
end if		
dw_1.object.datawindow.print.preview = True
dw_1.object.datawindow.print.preview.zoom = 100
dw_1.setfocus()
end event

type cb_2 from commandbutton within w_consulta_transacciones_cxp
integer x = 3360
integer y = 48
integer width = 343
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
end type

event clicked;parent.triggerevent('close')
end event

type pb_1 from picturebutton within w_consulta_transacciones_cxp
integer x = 2711
integer y = 16
integer width = 110
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\sistemas\hymsoft\Art\BLIND.bmp"
end type

event clicked;	String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error, ls_tran, ls_codigo, ls_ref
	integer li_c, li_b, li_ann
	long    ll_lter
	Datawindow        dww
	str_dg_dynamic_find	lstr_df

	ls_tran = dw_2.getitemstring(1,'transaccion')
	li_ann = integer(em_ann.text)
	
	if ls_tran = '' or isnull(ls_tran) then
		gf_mensaje('','Seleccione una Transaccion para buscar Documentos',1,1,'E')
		return
	end if
	
	
		lstr_df.texto_campo [1,1] = "cptmovim.movi_documento"
		lstr_df.texto_campo [1,2] = "Documento"
		lstr_df.texto_campo [1,3] = "movi_documento"
		lstr_df.texto_campo [1,4] = 'V'
	//	lstr_df.texto_campo [1,5] = '280'	
		lstr_df.texto_campo [2,1] = "cptmovim.movi_a_nombre"
		lstr_df.texto_campo [2,2] = "A Nombre de"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '770'
		lstr_df.texto_campo [3,1] = "cptmovim.movi_fecha_tran"
		lstr_df.texto_campo [3,2] = "Fecha"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [3,5] = '285'
		lstr_df.tabla = " cptmovim "
			
		lstr_df.tabla_where = &
					"WHERE (cptmovim.movi_g_financiero = " + string(str.g_financiero) + ") and " +&
							 "(cptmovim.movi_empresa = " + string(str.empresa) + ") and " +&
							 "(cptmovim.movi_anno = " + string(li_ann) + ") and " +&
							 "(cptmovim.movi_tipo_transaccion = '"+ls_tran+"') and " +&
							 "(cptmovim.movi_tipo_transaccion + movi_sub_transaccion <> 'NC9') "
							 
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	
	If len (ls_find) = 0 Then Return
		
	ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo,"'"," ")
	ls_codigo = Trim(ls_codigo)

	  SELECT cptmovim.movi_referencia  
		 INTO :ls_ref  
		 FROM cptmovim  
		WHERE ( cptmovim.movi_g_financiero = :str.g_financiero ) AND  
				( cptmovim.movi_empresa = :str.empresa ) AND  
				( cptmovim.movi_aplicacion = 'CP' ) AND  
				( cptmovim.movi_tipo_transaccion = :ls_tran ) AND  
				( cptmovim.movi_documento = :ls_codigo ) AND  
				( cptmovim.movi_anno = :li_ann )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al buscar Referencia '+sqlca.sqlerrtext,1,1,'E')
		end if
	
	em_referencia.text = ls_ref
	em_documento.text = ls_codigo
	cb_consultar.triggerevent('clicked')

end event

type st_5 from statictext within w_consulta_transacciones_cxp
integer x = 2053
integer y = 128
integer width = 343
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Referencia:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_referencia from editmask within w_consulta_transacciones_cxp
integer x = 2391
integer y = 120
integer width = 306
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
maskdatatype maskdatatype = stringmask!
end type

