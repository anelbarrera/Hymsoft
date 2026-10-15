//objectcomments Ventana de Impresión del Reporte de Ventas x Cliente
forward
global type w_asigna_proveedor_producto from w_fa_padre_reportes
end type
type st_sel_marca from statictext within w_asigna_proveedor_producto
end type
type ddlb_1 from dropdownlistbox within w_asigna_proveedor_producto
end type
type st_1 from statictext within w_asigna_proveedor_producto
end type
type cbx_filtrar from checkbox within w_asigna_proveedor_producto
end type
type cbx_sin_grupo from checkbox within w_asigna_proveedor_producto
end type
type st_2 from statictext within w_asigna_proveedor_producto
end type
type cb_1 from commandbutton within w_asigna_proveedor_producto
end type
end forward

global type w_asigna_proveedor_producto from w_fa_padre_reportes
integer width = 4343
integer height = 2612
string title = "Asigna el ultimo proveedor al producto"
boolean minbox = false
long backcolor = 12639424
st_sel_marca st_sel_marca
ddlb_1 ddlb_1
st_1 st_1
cbx_filtrar cbx_filtrar
cbx_sin_grupo cbx_sin_grupo
st_2 st_2
cb_1 cb_1
end type
global w_asigna_proveedor_producto w_asigna_proveedor_producto

type variables
str_fa_ventafact str_informe
datawindowchild idwc_grupo, idwc_division

end variables

on w_asigna_proveedor_producto.create
int iCurrent
call super::create
this.st_sel_marca=create st_sel_marca
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.cbx_filtrar=create cbx_filtrar
this.cbx_sin_grupo=create cbx_sin_grupo
this.st_2=create st_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_sel_marca
this.Control[iCurrent+2]=this.ddlb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cbx_filtrar
this.Control[iCurrent+5]=this.cbx_sin_grupo
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.cb_1
end on

on w_asigna_proveedor_producto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_sel_marca)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.cbx_filtrar)
destroy(this.cbx_sin_grupo)
destroy(this.st_2)
destroy(this.cb_1)
end on

event ue_post_open;datetime ld_fecha1, ld_fecha2, ldt_fecha
integer li_grupo, i
string ls_empresa, ls_grupo, ls_tran, ls_producto
long ll_tercero

ls_empresa = gf_dg_nombre_empresa()

//lstr_rangfech = message.powerObjectParm
sqlca.autocommit = true
//Cambia DAtaWindow

dw_1.SettransObject(sqlca)
//ld_fecha1 = datetime(lstr_rangfech.fecha1)
//ld_fecha2 = datetime(lstr_rangfech.fecha2)
//dw.Object.datawindow.print.preview = true
if dw_1.retrieve() > 0 then
	for i = 1 to dw_1.rowcount()
		dw_1.scrolltorow(i)
		yield()
		ls_producto = dw_1.getitemstring(i,'prod_producto')
		ll_tercero = 0
		 DECLARE cur_prod CURSOR FOR  
		  SELECT tmov_terceros
		 FROM indmovim,   
				intmovim  
		WHERE ( intmovim.tmov_g_financiero = indmovim.dmov_g_financiero ) and  
				( intmovim.tmov_empresa = indmovim.dmov_empresa ) and  
				( intmovim.tmov_aplicacion = indmovim.dmov_aplicacion ) and  
				( intmovim.tmov_tipo_transaccion = indmovim.dmov_tipo_transaccion ) and  
				( intmovim.tmov_secuencia = indmovim.dmov_secuencia ) and  
				( intmovim.tmov_anual = indmovim.dmov_anual ) and  
				( intmovim.tmov_concepto = indmovim.dmov_concepto ) and  
				( ( intmovim.tmov_tipo_transaccion = 'EN' ) AND  
				( intmovim.tmov_empresa = :str.empresa ) AND  
				( indmovim.dmov_producto = :ls_producto ) ) order by tmov_fecha desc;  
	
		open cur_prod;
		
		fetch cur_prod into :ll_tercero ;
		
		if ll_tercero > 0 then
			dw_1.setitem(i,'prod_tercero',ll_tercero)
		end if
		
		close cur_prod;
	next
end if

end event

event resize;//Override
this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 425
gb_1.width  = this.width  - 63
gb_1.height = this.height - 360
cbx_filtrar.y = newheight - 90
cbx_sin_grupo.y = newheight - 90
st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180

ddlb_1.y = this.height - 200
ddlb_1.X = (this.width - 70) - ddlb_1.width 

st_sel_marca.y = this.height - 200
st_sel_marca.X = (this.width - 70) - ddlb_1.width - st_sel_marca.width -100

st_1.y =  newheight - 190
st_2.y =  newheight - 85

this.SetRedraw(true)

end event

event open;call super::open;//str_informe = Message.PowerObjectParm
this.y = 0
this.x = 805


end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_asigna_proveedor_producto
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_asigna_proveedor_producto
boolean visible = false
integer x = 32
integer y = 1384
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_asigna_proveedor_producto
integer x = 41
integer y = 40
integer width = 3301
integer height = 2160
string dataobject = "asigna_proveedores"
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
//override
//Para cuando pasa por encima del objeto
//Override
return

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
	CASE 'prod_producto'
		this.Modify("prod_producto.Font.Underline='1'")
		this.Modify("prod_producto.Color='16711680'")				
	CASE ELSE
		this.Modify("prod_producto.Font.Underline='0'")
		this.Modify("prod_producto.Color='0'")
END CHOOSE
end event

event dw_1::clicked;//override
string ls_column
ls_column = dwo.name
if ls_column = "prod_producto" then
	
	if row = 0 then return
	
		Window lw_child_v				
		string ls_producto
		str_kardex  str_opcion
		
			str_opcion.opcion_menu = 'MCP'
			str_opcion.opcion_ventana    = 'P'
			str_opcion.dwpantalla     = 'dw_in_mcp_prod_kard_1'
			str_opcion.dwreporte      = 'dw_in_mcp_prod_kard_2'
			str_opcion.titulo_ventana = 'Movimientos de Productos (Kardex)'
			
			if dw_1.rowcount() > 0 then
				ls_producto = dw_1.getitemstring(row,'prod_producto')				
			end if
			
			str_opcion.kproducto=ls_producto
		
			OpenSheetWithParm(lw_child_v,str_opcion,"w_in_movi_prod_kardex",str.frame,2,Original!)		
	
end if
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_asigna_proveedor_producto
integer x = 27
integer y = 0
integer width = 3346
integer height = 1364
long backcolor = 12639424
end type

type st_sel_marca from statictext within w_asigna_proveedor_producto
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

type ddlb_1 from dropdownlistbox within w_asigna_proveedor_producto
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

type st_1 from statictext within w_asigna_proveedor_producto
boolean visible = false
integer x = 32
integer y = 2220
integer width = 517
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Filtrar por Division:"
boolean focusrectangle = false
end type

type cbx_filtrar from checkbox within w_asigna_proveedor_producto
boolean visible = false
integer x = 1870
integer y = 2224
integer width = 951
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Sólo Productos con Existencias"
boolean checked = true
end type

event clicked;if this.checked then
	dw_1.setfilter('prod_existencia_total > 0')
else
	dw_1.setfilter('')
end if

dw_1.filter()
dw_1.groupcalc()
end event

type cbx_sin_grupo from checkbox within w_asigna_proveedor_producto
boolean visible = false
integer x = 3013
integer y = 2220
integer width = 599
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Listado sin Grupos"
end type

event clicked;if this.checked then
   dw_1.Modify ("DataWindow.Header.1.Height = 0")
   dw_1.Modify ("DataWindow.Header.2.Height = 0")
 	dw_1.Modify ("DataWindow.Trailer.1.Height = 0")
  	dw_1.Modify ("DataWindow.Trailer.2.Height = 0")	
   dw_1.setsort('inmprodu_prod_descripcion')
else
   dw_1.Modify ("DataWindow.Header.1.Height = 88")
   dw_1.Modify ("DataWindow.Header.2.Height = 100")
 	dw_1.Modify ("DataWindow.Trailer.1.Height = 88")
  	dw_1.Modify ("DataWindow.Trailer.2.Height = 104")		
   dw_1.setsort('cradivis_adiv_nombre_div, cragrupo_agru_descripcion_grupo, inmprodu_prod_descripcion')
end if
dw_1.sort()
dw_1.groupcalc()
end event

type st_2 from statictext within w_asigna_proveedor_producto
boolean visible = false
integer x = 73
integer y = 2332
integer width = 462
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Filtrar por Grupo:"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_asigna_proveedor_producto
integer x = 3433
integer y = 76
integer width = 343
integer height = 100
integer taborder = 11
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar"
end type

event clicked;if dw_1.update() = -1 then
	gf_mensaje('','Error al Guardar '+sqlca.sqlerrtext,1,1,'E')
end if
end event

