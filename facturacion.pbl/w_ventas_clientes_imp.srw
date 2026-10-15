//objectcomments Ventana de Impresión del Reporte de Ventas x Factura
forward
global type w_ventas_clientes_imp from w_fa_padre_reportes
end type
type st_sel_marca from statictext within w_ventas_clientes_imp
end type
type ddlb_1 from dropdownlistbox within w_ventas_clientes_imp
end type
end forward

global type w_ventas_clientes_imp from w_fa_padre_reportes
integer width = 3063
integer height = 1656
string title = "Informe de Ventas"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 12639424
st_sel_marca st_sel_marca
ddlb_1 ddlb_1
end type
global w_ventas_clientes_imp w_ventas_clientes_imp

type variables
str_fa_ventafact str_informe

end variables

on w_ventas_clientes_imp.create
int iCurrent
call super::create
this.st_sel_marca=create st_sel_marca
this.ddlb_1=create ddlb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_sel_marca
this.Control[iCurrent+2]=this.ddlb_1
end on

on w_ventas_clientes_imp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_sel_marca)
destroy(this.ddlb_1)
end on

event ue_post_open;//Override
datetime ldt_fecha1, ldt_fecha2
str_informe = Message.PowerObjectParm
dw_1.settransobject(sqlca)
st_nom_ventana.text = this.classname()

This.SetRedraw(False)
/*Sòlo aplica para Newport y sus afiliadas*/
if pos(Upper(str.empr_acceso_especial),'NEWPORT,') > 0 then
	ddlb_1.text = 'TODAS'
	ddlb_1.visible = true
	st_sel_marca.visible = true
end if

Choose Case str_informe.tipo
		
	   Case "DETALLADO" 	
			If dw_1.DataObject <> "dw_fa_rep_ventas_cli_new" Then	
				dw_1.DataObject = "dw_fa_rep_ventas_cli_new"
			End If
//			THIS.TITLE ='(FA) Informe de Ventas por Cliente Detallado'
   	Case "RESUMIDO"				
			if str_informe.cliente_global = 1 then
				If dw_1.DataObject <> "dw_fa_rep_ventas_cli_global_pais" Then	
					dw_1.DataObject = "dw_fa_rep_ventas_cli_global_pais"	
				End If
			else
				If dw_1.DataObject <> "dw_fa_rep_ventas_cli_res_new" Then	
					dw_1.DataObject = "dw_fa_rep_ventas_cli_res_new"	
				End If
			end if
//			THIS.TITLE ='(FA) Informe de Ventas por Cliente Resumido'
		
	  Case "GLOBAL"
			if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 then
				If dw_1.DataObject <> "dw_fa_rep_ventas_cli_glo_acisa" Then	
					dw_1.DataObject = "dw_fa_rep_ventas_cli_glo_acisa"	
				end if
			else
				If dw_1.DataObject <> "dw_fa_rep_ventas_cli_glo_new" Then	
					dw_1.DataObject = "dw_fa_rep_ventas_cli_glo_new"	
				End If
			end if
			THIS.TITLE ='(FA) Informe de Ventas por Cliente Global'
	  Case "POR DIVISION"
			if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 then
				If dw_1.DataObject <> "dw_fa_rep_ventas_cli_division_acisa" Then	
					dw_1.DataObject = "dw_fa_rep_ventas_cli_division_acisa"	
				end if
			else
				If dw_1.DataObject <> "dw_fa_rep_ventas_cli_division_new" Then	
					dw_1.DataObject = "dw_fa_rep_ventas_cli_division_new"	
				End If
			end if
//			THIS.TITLE ='(FA) Informe de Ventas por Cliente / Division Detallado'
	  Case "RESUMIDO POR DIVISION"
			if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 then
				If dw_1.DataObject <> "dw_fa_rep_ventas_cli_division_res_acisa" Then	
					dw_1.DataObject = "dw_fa_rep_ventas_cli_division_res_acisa"	
				end if
			else
				If dw_1.DataObject <> "dw_fa_rep_ventas_cli_division_res_new" Then	
					dw_1.DataObject = "dw_fa_rep_ventas_cli_division_res_new"	
				End If
			end if
//			THIS.TITLE ='(FA) Informe de Ventas por Cliente / Division Resumido'
  End Choose

//****************************************************************************************
			
//	 If w_fa_fondo.str_para.lista_emp_especial = 1 Then 
		
//		If dw_1.Describe("frac.x") <> "?" And dw_1.Describe("frac.x") <> "!" Then
//		 dw_1.object.frac.expression = "'"+ "1" + "'"
//		End If			 
//	 End If
	  
	  
//	 If w_fa_fondo.str_para.utiliza_decimales = 1 Then			
		
//		If dw_1.Describe("dec.x") <> "?" And dw_1.Describe("dec.x") <> "!" Then
//		 dw_1.object.dec.expression = "'"+ "1" + "'"
//		End If			 
		
//	 Else	
		
		If dw_1.Describe("dec.x") <> "?" And dw_1.Describe("dec.x") <> "!" Then
		 dw_1.object.dec.expression = "'"+ "0" + "'"
		End If			 
		
//	 End If		  						
								
//****************************************************************************************

//dw_1.Object.Data = w_fa_rep_ventas_cli_new.dw_1.Object.Data


/**/ /*CHANGED BY HGN 18/12/2002*/
Long	ll_resultado
dw_1.settransobject(sqlca)

if str_informe.cliente_global = 1 then
	 
	ldt_fecha1 = datetime(date(str_informe.fecha1),time('00:00:00'))
	ldt_fecha2 = datetime(date(str_informe.fecha2),time('00:00:00'))
	
	ll_resultado = dw_1.Retrieve(str.g_financiero, str.empresa, ldt_fecha1, ldt_fecha2)			//	Recupera los Datos
else	
	 
	dw_1.SetSQLSelect(str_informe.ls_where)		//Setea el SQL al Data Window
	ll_resultado = dw_1.Retrieve()			//	Recupera los Datos
end if


If ll_resultado = -1 Then
	Messagebox("ATENCIÓN SR. USUARIO","Error "+sqlca.sqlerrtext)
ElseIf dw_1.RowCount() = 0 Then
	Messagebox("ATENCIÓN SR. USUARIO","No hay Registros Disponibles para esta Selección",Exclamation!)
	dw_1.Reset()
	This.SetRedraw(True)
	Return
End If
/**/

/*Muestra o no el descuento solo para ACISA*/
//If dw_1.Describe("desc_sino.x") <> "?" And dw_1.Describe("desc_sino.x") <> "!" Then
//	dw_1.object.desc_sino.expression = "'"+ string(str_informe.desc_sino) +"'"
//End If	

//Para setear el nombre de la Cia. al DW de impresion.
If dw_1.Describe("empresa.x") <> "?" And dw_1.Describe("empresa.x") <> "!" Then
	dw_1.object.empresa.expression = "'"+ gf_dg_nombre_empresa() +"'"
End If	


//Setea el Nombre de la Ventana
st_nom_ventana.text = This.Classname()

//Setea el Nombre del DW
dw_1.object.datawin.expression = "'"+ dw_1.dataobject +"'"
dw_1.object.fechas.expression = "'" +"Facturas Desde "+ str_informe.fecha1 +" Hasta "+ str_informe.fecha2 +"'"	 
//
String	ls_expresion
Integer	li_pos
ls_expresion = string(date(gf_fecha_serv()))
dw_1.object.fecha.expression = "'"+ls_expresion+"'"

ls_expresion = string(gf_fecha_serv(), "dd/mm/yyyy hh:mm AM/PM")
li_pos = Pos(ls_expresion," ")

ls_expresion ='Hora '+Right(ls_expresion, Len(ls_expresion) - li_pos)		
	
dw_1.object.hora.expression = "'"+ls_expresion+"'"

//
dw_1.object.datawindow.print.preview = True
dw_1.object.datawindow.print.preview.zoom = 100

This.SetRedraw(True)


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

event open;call super::open;//str_informe = Message.PowerObjectParm

end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_ventas_clientes_imp
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_ventas_clientes_imp
boolean visible = false
integer x = 32
integer y = 1384
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_ventas_clientes_imp
integer x = 41
integer y = 40
integer width = 2935
integer height = 1308
string dataobject = "dw_fa_rep_ventas_cli_new"
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

end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_ventas_clientes_imp
integer x = 27
integer y = 0
integer width = 2967
integer height = 1364
long backcolor = 12639424
end type

type st_sel_marca from statictext within w_ventas_clientes_imp
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

type ddlb_1 from dropdownlistbox within w_ventas_clientes_imp
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

