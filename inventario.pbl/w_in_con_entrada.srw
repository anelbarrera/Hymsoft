forward
global type w_in_con_entrada from w_fa_padre_reportes
end type
type dw_2 from datawindow within w_in_con_entrada
end type
type pb_1 from picturebutton within w_in_con_entrada
end type
type st_1 from statictext within w_in_con_entrada
end type
type em_ann from editmask within w_in_con_entrada
end type
type st_2 from statictext within w_in_con_entrada
end type
type cb_1 from commandbutton within w_in_con_entrada
end type
type dw_3 from datawindow within w_in_con_entrada
end type
end forward

global type w_in_con_entrada from w_fa_padre_reportes
integer width = 3611
integer height = 1924
string title = "Saldos por Entrada"
string menuname = ""
boolean maxbox = false
boolean resizable = false
event ue_buscar ( )
dw_2 dw_2
pb_1 pb_1
st_1 st_1
em_ann em_ann
st_2 st_2
cb_1 cb_1
dw_3 dw_3
end type
global w_in_con_entrada w_in_con_entrada

type variables
datawindowchild idch_entrada , idch_producto , idch_proveedor 
string is_aplic, is_producto, is_documento, is_cant
long  il_entrada,il_proveedor, il_ann
datetime id_fecha




end variables

on w_in_con_entrada.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.pb_1=create pb_1
this.st_1=create st_1
this.em_ann=create em_ann
this.st_2=create st_2
this.cb_1=create cb_1
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.em_ann
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.dw_3
end on

on w_in_con_entrada.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.em_ann)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.dw_3)
end on

event open;
gf_acelerador()
THIS.SetToolbar(1, true, alignattop!)
THIS.SetToolbarPos(1, 1, 50, false)
//this.y = 10
//this.x = 10
This.Icon = str.icono

//i_str = message.PowerObjectParm	

this.postevent("ue_post_open")

//
//m_in_reportes.m_edicion.m_adicionar.ToolBarItemVisible = False
//m_in_reportes.m_edicion.m_adicionar.Visible = False
//
//m_in_reportes.m_edicion.m_insertar.ToolBarItemVisible = False
//m_in_reportes.m_edicion.m_insertar.Visible = False
//
//m_in_reportes.m_edicion.m_eliminar.ToolBarItemVisible = False
//m_in_reportes.m_edicion.m_eliminar.Visible = False
//
//m_in_reportes.m_edicion.m_primerregistro.ToolBarItemVisible = False
//m_in_reportes.m_edicion.m_primerregistro.Visible = False
//
//m_in_reportes.m_edicion.m_siguienteregistro.ToolBarItemVisible = False
//m_in_reportes.m_edicion.m_siguienteregistro.Visible = False
//
//m_in_reportes.m_edicion.m_registroanterior.ToolBarItemVisible = False
//m_in_reportes.m_edicion.m_registroanterior.Visible = False
//
//m_in_reportes.m_edicion.m_ultimoregistro.ToolBarItemVisible = False
//m_in_reportes.m_edicion.m_ultimoregistro.Visible = False
//
//m_in_reportes.m_edicion.m_buscar.ToolBarItemVisible = False
//m_in_reportes.m_edicion.m_buscar.Visible = False
//
//m_in_reportes.m_edicion.m_filtrar.ToolBarItemVisible = False
//m_in_reportes.m_edicion.m_filtrar.Visible = False
//
//m_in_reportes.m_edicion.m_sortear.ToolBarItemVisible = False
//m_in_reportes.m_edicion.m_sortear.Visible = False
//
//m_in_reportes.m_edicion.m_zoom-2.ToolBarItemVisible = False
//m_in_reportes.m_edicion.m_zoom-2.Visible = False
//
//m_in_reportes.m_edicion.m_zoom3.ToolBarItemVisible = False
//m_in_reportes.m_edicion.m_zoom3.Visible = False
//
//m_in_reportes.m_edicion.m_zoom_rep.ToolBarItemVisible = False
//m_in_reportes.m_edicion.m_zoom_rep.Visible = False
//
//m_in_reportes.m_archivo.m_imprimir.ToolBarItemVisible = False
//m_in_reportes.m_archivo.m_imprimir.Visible = False
//
//m_in_reportes.m_edicion.m_habilitardeshabilitarvistaprevia.ToolBarItemVisible = False
//m_in_reportes.m_edicion.m_habilitardeshabilitarvistaprevia.Visible = False
end event

event ue_print;//Override

end event

event ue_post_open;//----------------------------------------
//Modificacion Irving Aguilar
str_br_general i_str
String ls_modo
i_str=message.PowerObjectparm

iF isvalid(i_str)  Then
	ls_modo = i_str.variable1
end if
//Modificacion Irving Aguilar

Long li_valor



//Override
dw_1.settransobject(SQLCA)
dw_2.settransobject(SQLCA)

st_nom_ventana.text = this.classname()

dw_2.accepttext()


//Para ocultar las opciones de consultas, cuando es Elbros
if pos(Upper(str.empr_acceso_especial),'ELBROS,') > 0 then
	gf_fa_cambiar_titulos(this.menuid)
end if

is_aplic = 'IN'

dw_2.getchild('secuencia',idch_entrada)
idch_entrada.settransobject(SQLCA)
if idch_entrada.retrieve(str.g_financiero, str.empresa,'IN','EN') = 0 then &
	idch_entrada.insertrow(0)

	il_ann = year(date(gf_fecha_serv()))
	em_ann.text = string(il_ann)
	idch_entrada.setfilter('tmov_anual = '+string(il_ann))
	idch_entrada.filter()

	
dw_2.getchild('proveedor',idch_proveedor)
idch_proveedor.settransobject(SQLCA)
if idch_proveedor.retrieve(str.g_financiero, str.empresa) = 0 then &
	idch_proveedor.insertrow(0)

dw_2.insertrow(0)

dw_2.setitem(1,'aplicacion','IN')
dw_2.setfocus()
dw_2.setcolumn('secuencia')
//-----------------------------------------
//Modificacion Irving Aguilar

	
If ls_modo = "C" Then	
	//Modificacion Irving Aguilar
	//-----------------------------------------
	this.move(0,300)
	il_entrada=i_str.numero2
	il_ann=i_str.numero1
	em_ann.text = string(il_ann)
	dw_2.setitem(1,"secuencia",il_entrada)
	dw_2.setitem(1,"fecha",il_ann)
	pb_1.PostEvent(Clicked!)
	setnull(i_str.numero2 )
	setnull(i_str.numero1 )
	setnull(i_str.variable1)	
end if
end event

event activate;//Override
end event

event resize;//Override

end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_in_con_entrada
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_in_con_entrada
integer x = 27
integer y = 1748
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_in_con_entrada
integer x = 14
integer y = 292
integer width = 3561
integer height = 1436
string dataobject = "dw_lis_in_consulta_entrada"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event dw_1::constructor;//Override
dw=this

end event

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql

ls_sql = sqlsyntax

ls_sql += " And ((intmovim.tmov_g_financiero     = " + string(str.g_financiero)   + ") " + & 
          " And ( intmovim.tmov_empresa          = " + string(str.empresa)       + ") " + &  
          " And ( intmovim.tmov_secuencia        = " + string(il_entrada)        + ") " + &
          " And ( intmovim.tmov_anual        = " + string(il_ann)        + ") " + &			 
          " And ( intmovim.tmov_aplicacion       = '" + is_aplic                 + "'))"

SetSQLpreview(ls_sql)			 


end event

event dw_1::rbuttondown;//Override
end event

event dw_1::printend;call super::printend;if pos(Upper(str.empr_acceso_especial),'ELBROS,') > 0 then
	dw_1.Modify("DataWindow.Header.Height='84'")
	dw_1.Object.no_t.Y='492'
	dw_1.Object.indmovim_dmov_producto_t.Y='20'
	dw_1.Object.inmprodu_prod_descripcion_t.Y='20'
	dw_1.Object.inamedid_medi_abre_t.Y='20'
	dw_1.Object.indmovim_dmov_costo_fob_t.Y='20'
	dw_1.Object.entero_t.Y='20'
	dw_1.Object.indmovim_dmov_cantidad_t.Y='20'
	dw_1.Object.rentero_t.Y='20'
	dw_1.Object.dentero_t.Y='20'
	dw_1.setredraw(true)
end if

end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_in_con_entrada
end type

type dw_2 from datawindow within w_in_con_entrada
event ue_enter pbm_dwnkey
integer x = 14
integer y = 32
integer width = 2958
integer height = 248
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dwe_in_entrada_1"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_enter;if keydown(keyenter!) then
	choose case dw_2.getcolumnname()
		case 'aplicacion'
			dw_2.setcolumn('secuencia')
		case 'secuencia'
			pb_1.TriggerEvent(Clicked!)
		case 'documento'
			dw_2.setcolumn('fecha')
		case 'fecha'
			dw_2.setcolumn('proveedor')			
		case 'proveedor'
			dw_2.setcolumn('aplicacion')
	end choose
end if	
end event

event itemchanged;string ls_documento
datetime ld_fecha
long ll_proveedor
integer li_ann

//This.accepttext()

If dw_2.getcolumnname() = 'secuencia' then
	ls_documento = idch_entrada.getitemstring(idch_entrada.getrow(),'tmov_documento')
	dw_2.setitem(1,'documento',ls_documento)
	
	ld_fecha = idch_entrada.getitemdatetime(idch_entrada.getrow(),'tmov_fecha')		
	dw_2.setitem(1,'fecha',ld_fecha)
	
	il_ann = idch_entrada.getitemNumber(idch_entrada.getrow(),'tmov_anual')		
	
	ll_proveedor = idch_entrada.getitemnumber(idch_entrada.getrow(),'tmov_terceros')		
	dw_2.setitem(1,'proveedor',ll_proveedor)
	
ElseIf dw_2.getcolumnname() = 'aplicacion' then

	If data <> '' or Not isnull(data) then	 
		
	
		dw_2.getchild('secuencia',idch_entrada)
		idch_entrada.settransobject(SQLCA)
		if idch_entrada.retrieve(str.g_financiero, str.empresa,data,'EN') = 0 then &
			idch_entrada.insertrow(0)
		
	//	idch_entrada.scrolltorow(insertrow(0))			
		
		is_aplic = data
		
   End if

//ElseIf  dw_2.getcolumnname() = 'cuantos' then
//
//	if data = 'N' then
//		dw_2.modify("producto.protect=false")
//	Else
////		idch_producto.scrolltorow(insertrow(0))
//		dw_2.modify("producto.protect=true")		
//	End If

End If


	
	
end event

type pb_1 from picturebutton within w_in_con_entrada
integer x = 3022
integer y = 96
integer width = 393
integer height = 116
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Aceptar"
boolean originalsize = true
vtextalign vtextalign = vcenter!
end type

event clicked;dw_2.accepttext()


if isnull(dw_2.getitemnumber(1,'secuencia')) then
	dw_2.setcolumn("secuencia")
	return
End if

il_entrada = dw_2.getitemnumber(1,'secuencia')

//if isnull(dw_2.getitemnumber(1,'proveedor')) then
//	dw_2.setcolumn("proveedor")
//	return
//End if	
//
//il_proveedor = dw_2.getitemnumber(1,'proveedor')
//if isnull(dw_2.getitemstring(1,'documento')) or dw_2.getitemstring(1,'documento') = ' ' then
//	dw_2.setcolumn("documento")
//	return
//End if	

//is_documento = dw_2.getitemstring(1,'documento')
//
//if isnull(dw_2.getitemdatetime(1,'fecha')) then
//	dw_2.setcolumn("fecha")
//	return
//End if	

//id_fecha = dw_2.getitemdatetime(1,'fecha')

If dw_1.retrieve() = 0 then
			  messagebox('Aviso','Esta Entrada No Existe.',Information!)
			  dw_2.setcolumn('secuencia')
			  return
End If			  


end event

type st_1 from statictext within w_in_con_entrada
integer x = 2999
integer y = 76
integer width = 434
integer height = 152
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type em_ann from editmask within w_in_con_entrada
integer x = 2272
integer y = 56
integer width = 210
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###0"
end type

event modified;il_ann = long(em_ann.text)
idch_entrada.setfilter('tmov_anual = '+string(il_ann))
idch_entrada.filter()
end event

type st_2 from statictext within w_in_con_entrada
integer x = 2062
integer y = 68
integer width = 192
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_in_con_entrada
integer x = 3223
integer y = 1740
integer width = 357
integer height = 104
integer taborder = 11
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir"
end type

event clicked;dw = dw_3
dw_3.settransobject(sqlca);
dw_3.retrieve()
if dw_3.rowcount() < 1 then return

OpenWithParm(w_dw_print_options, dw_3)
If Message.DoubleParm = -1 Then Return

String	ls_expresion
ls_expresion = gf_dg_nombre_empresa()


If dw_3.describe("empresa.x") <> "?" And dw_3.describe("empresa.x") <> "!" Then	
	dw_3.object.empresa.expression = "'" + ls_expresion +"'"					
end if

ls_expresion = string(date(gf_fecha_serv()))
If dw_3.describe("fecha.x") <> "?" And dw_3.describe("fecha.x") <> "!" Then	
	dw_3.object.fecha.expression = "'" +ls_expresion+"'"					
end if

ls_expresion = string(time(gf_fecha_serv()))
If dw_3.describe("hora.x") <> "?" And dw_3.describe("hora.x") <> "!" Then	
	dw_3.object.hora.expression = "'" +ls_expresion+"'"					
end if
ls_expresion = dw_3.DataObject
If dw_3.describe("datawin.x") <> "?" And dw_3.describe("datawin.x") <> "!" Then	
	dw_3.object.datawin.expression = "'" +ls_expresion+"'"					
end if
	
dw_3.Print(True)
dw=dw_1
//dw = dw_1
//
//OpenWithParm(w_dw_print_options, dw)
//If Message.DoubleParm = -1 Then Return
//	String	ls_expresion
//	ls_expresion = gf_dg_nombre_empresa()
//
//if pos(ls_expresion,'ELBROS') > 0 then
//	dw_1.setredraw(false)
//	dw_1.Modify("DataWindow.Header.Height='560'")
//	dw_1.Object.no_t.Y='492'
//	dw_1.Object.indmovim_dmov_producto_t.Y='492'
//	dw_1.Object.inmprodu_prod_descripcion_t.Y='492'
//	dw_1.Object.inamedid_medi_abre_t.Y='492'
//	dw_1.Object.indmovim_dmov_costo_fob_t.Y='492'
//	dw_1.Object.entero_t.Y='492'
//	dw_1.Object.indmovim_dmov_cantidad_t.Y='492'
//	dw_1.Object.rentero_t.Y='492'
//	dw_1.Object.dentero_t.Y='492'
//	
//		If dw_1.describe("empresa.x") <> "?" And dw_1.describe("empresa.x") <> "!" Then	
//			dw_1.object.empresa.expression = "'" + ls_expresion +"'"					
//		end if
//		
//		ls_expresion = string(date(gf_fecha_serv()))
//		If dw_1.describe("fecha.x") <> "?" And dw_1.describe("fecha.x") <> "!" Then	
//			dw_1.object.fecha.expression = "'" +ls_expresion+"'"					
//		end if
//		
//		ls_expresion = string(time(gf_fecha_serv()))
//		If dw_1.describe("hora.x") <> "?" And dw_1.describe("hora.x") <> "!" Then	
//			dw_1.object.hora.expression = "'" +ls_expresion+"'"					
//		end if
//		ls_expresion = dw_1.DataObject
//		If dw_1.describe("datawin.x") <> "?" And dw_1.describe("datawin.x") <> "!" Then	
//			dw_1.object.datawin.expression = "'" +ls_expresion+"'"					
//		end if
//	
//end if
//
//dw.Print(True)
//
end event

type dw_3 from datawindow within w_in_con_entrada
boolean visible = false
integer x = 2679
integer y = 1728
integer width = 411
integer height = 96
integer taborder = 21
boolean bringtotop = true
string title = "none"
string dataobject = "dw_rep_in_consulta_entrada"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event sqlpreview;string ls_sql

ls_sql = sqlsyntax

ls_sql += " And ((intmovim.tmov_g_financiero     = " + string(str.g_financiero)   + ") " + & 
          " And ( intmovim.tmov_empresa          = " + string(str.empresa)       + ") " + &  
          " And ( intmovim.tmov_secuencia        = " + string(il_entrada)        + ") " + &
          " And ( intmovim.tmov_anual        = " + string(il_ann)        + ") " + &			 
          " And ( intmovim.tmov_aplicacion       = '" + is_aplic                 + "'))"

SetSQLpreview(ls_sql)			 


end event

