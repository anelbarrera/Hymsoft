//objectcomments Ventana de modificacion del detalle de la Factura
forward
global type w_fa_ma_modificar_detalle from w_fa_padre
end type
type dw_2 from datawindow within w_fa_ma_modificar_detalle
end type
type cb_1 from commandbutton within w_fa_ma_modificar_detalle
end type
type cb_2 from commandbutton within w_fa_ma_modificar_detalle
end type
type gb_1 from groupbox within w_fa_ma_modificar_detalle
end type
type dw_3 from datawindow within w_fa_ma_modificar_detalle
end type
end forward

global type w_fa_ma_modificar_detalle from w_fa_padre
integer width = 6249
integer height = 1988
string title = "(FA) Modificacion de Detalle de Facturas"
string menuname = "m_hs"
boolean controlmenu = false
dw_2 dw_2
cb_1 cb_1
cb_2 cb_2
gb_1 gb_1
dw_3 dw_3
end type
global w_fa_ma_modificar_detalle w_fa_ma_modificar_detalle

type variables
string is_user, is_tipo, is_pedido
integer ii_ann

end variables

on w_fa_ma_modificar_detalle.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.dw_2=create dw_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.gb_1=create gb_1
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.dw_3
end on

on w_fa_ma_modificar_detalle.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.dw_3)
end on

event ue_post_open;Long ll_anno
string ls_error
datawindowchild ldwc_pedidos

is_nombre = This.ClassName()

//gf_win_used_by_user(is_nombre, true)

dw.settransobject(sqlca)

st_nom_ventana.text = is_nombre

dw_2.settransobject(sqlca)

dw_3.settransobject(sqlca)

   SELECT faaparam.fara_fact_ano  
	Into: ll_anno
    FROM faaparam 
         
   WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
         ( faaparam.fara_empresa = :str.empresa ) ;
			
			if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			messagebox ("Atención","Error en el Select en faaparam "+ls_error)
			
			return 
		end if	
           
			  
dw_2.Getchild("pedido",ldwc_pedidos)
ldwc_pedidos.settransobject(sqlca)
IF ldwc_pedidos.retrieve(str.g_financiero, str.empresa,ll_anno) < 1 then 
	ldwc_pedidos.insertrow(0)
	messagebox('Atención ','No hay Pedidos para Modificar '+string(ll_anno))
	return
end if

dw_2.insertrow(0)
dw_2.setfocus()
end event

event open;sqlca.autocommit = true
//gf_acelerador()
dw = dw_1

This.Icon = str.icono

This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)

//Configurar los Accesos

//mf_accesos(this.menuid, this)

str.frame.SetRedraw ( True )

this.postevent("ue_post_open")
end event

event resize;//Override
//dw_1.Resize(This.Width - 170, This.Height - 880)
//dw_1.height = newheight - 880
//dw_3.height = newheight - 280
//st_nom_ventana.x = 28
//st_nom_ventana.y = this.height - 180
end event

event ue_aceptar;//override
datawindowchild ldwc_pedidos
double	ld_peso, ld_cubicaje
long ll_update, ll_bultos, ll_anno, ll_documento
integer li_ann, i
window lw_ventana
string ls_titulo, ls_error, ls_tipo, ls_pedido, ls_nombre, ls_direccion, ls_despachado, ls_consignado, ls_observacion, ls_descripcion_cuba , ls_producto, ls_arancel_cuba, ls_barra_alterna

//lw_ventana = this.getactivesheet()
//ls_titulo = lw_ventana.title

dw_1.getchild("pedido",ldwc_pedidos)
ldwc_pedidos.settransobject(sqlca)

ls_pedido = dw_2.getitemstring(1,'pedido')
//ls_tipo   = dw_2.getitemstring(1,'tipo')
li_ann	 = dw_2.getitemNumber(1,'ann')

dw_2.accepttext()

ll_update=dw.update()

if ll_update = 1  then
	ld_peso		= truncate(round(dw_1.getitemnumber(1,"peso_total"),4),4)	
   ld_cubicaje = truncate(round(dw_1.GetItemNumber(1,"cubicaje_total"),4),4)
   ll_bultos   = truncate(round(dw_1.GetItemNumber(1,"bultos_total"),4),4)
	
	ls_direccion  = dw_2.Getitemstring(1,'direccion')
	ls_despachado = dw_2.Getitemstring(1,'despachado')
	ls_consignado = dw_2.Getitemstring(1,'consignado')
	ls_nombre	  = dw_2.Getitemstring(1,'nombre')
	ls_observacion= dw_2.Getitemstring(1,'observacion')
	ll_documento  = dw_2.getitemnumber(1,'no_traspaso')
	
	  UPDATE fatdiari  
     SET fact_bultos_total = :ll_bultos,   
         fact_peso_total = :ld_peso,   
         fact_cubicaje_total = :ld_cubicaje,
			fact_a_nombre_direccion = :ls_direccion,
			fact_despachado			= :ls_despachado,
			fact_consignado			= :ls_consignado,
			fact_a_nombre				= :ls_nombre,
			fact_no_traspaso			= :ll_documento,
			fact_comentario			= :ls_observacion
   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
         ( fatdiari.fact_empresa = :str.empresa ) AND  
         ( fatdiari.fact_no_pedido = :ls_pedido ) AND  
         ( fatdiari.fact_ann = :li_ann ) ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback using sqlca;
			mensaje('Atención',"¡ Error al Actualizar !", ls_error)
		else
			commit using sqlca;
			
			ll_anno = year(date(gf_fecha_serv()))
			dw_2.Getchild("pedido",ldwc_pedidos)
			ldwc_pedidos.settransobject(sqlca)
			IF ldwc_pedidos.retrieve(str.g_financiero, str.empresa,ll_anno) < 1 then 
				ldwc_pedidos.insertrow(0)
				messagebox('Atención ','No hay Pedidos para Modificar '+string(ll_anno))
				return
			end if			

		end if
else
	ls_error = sqlca.sqlerrtext
	rollback using sqlca;
	mensaje("Atención","¡Error al Actualizar !",ls_error)
end if

str.frame.setmicrohelp('Actualizando las Descripciones de Cuba')

for i = 1 to dw_1.rowcount()
		ls_descripcion_cuba = dw_1.getitemstring(i, 'prod_descripcion_cuba')
		ls_producto = dw_1.getitemstring(i, 'facd_codigo_item')		
		ls_arancel_cuba = dw_1.getitemstring(i, 'prod_contrato_regalias')		
		ls_barra_alterna = dw_1.getitemstring(i, 'prod_cod_alternativo')	
		
		update inmprodu
		set prod_descripcion_cuba = :ls_descripcion_cuba,
			 prod_contrato_regalias = :ls_arancel_cuba,
			 prod_cod_alternativo    = :ls_barra_alterna
		where prod_g_financiero = :str.g_financiero and
				prod_empresa		= :str.empresa and
				prod_producto = :ls_producto ;
				
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback using sqlca;
			mensaje('Atención',"¡ Error al Actualizar Descripcion Cuba!", ls_error)
		end if		
Next

mensaje("Aviso","¡Actualización Exitosa !","")

sqlca.autocommit = true
str.frame.setmicrohelp('')
end event

event key;//override
end event

event close;close(This)
Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
 
end event

event closequery;call super::closequery;constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)

This.SetRedraw(false)
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_ma_modificar_detalle
integer x = 18
integer y = 1412
integer width = 942
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_ma_modificar_detalle
integer x = 9
integer y = 640
integer width = 4462
integer height = 740
boolean titlebar = true
string title = "Detalle de la Factura"
string dataobject = "dw_ma_fa_modifica_detalle"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::ue_tabfinal;//override
end event

event dw_1::ue_down;//override
end event

event dw_1::ue_entercol;// Override
end event

event dw_1::ue_helpcol;//Override
end event

event dw_1::rbuttondown;//Override
end event

event dw_1::clicked;//Override
end event

event dw_1::itemfocuschanged;//Override
end event

event dw_1::itemchanged;//Override
end event

event dw_1::dberror;//Override
end event

event dw_1::ue_microayuda;//override
end event

type st_ayuda from w_fa_padre`st_ayuda within w_fa_ma_modificar_detalle
end type

type dw_2 from datawindow within w_fa_ma_modificar_detalle
integer x = 23
integer y = 44
integer width = 3429
integer height = 556
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_pr_fa_seleccion_pedido"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;datawindowchild ldwc_pedido
string  ls_pedido, ls_tipo, ls_cuenta, ls_nombre, ls_despacho, ls_direccion,  ls_consignado, ls_comentario
integer li_ann
long  ll_documento  
date    ldt_fecha
dw_2.getchild("pedido",ldwc_pedido)
ldwc_pedido.settransobject(sqlca)

if this.getcolumnname() = 'pedido' then
	
	is_pedido = ldwc_pedido.getitemstring(ldwc_pedido.getrow(),"fact_no_pedido")
	ls_pedido = is_pedido
	is_tipo   = ldwc_pedido.getitemstring(ldwc_pedido.getrow(),"fact_tipo")
	ls_tipo    = is_tipo   
	ii_ann	 = ldwc_pedido.getitemNumber(ldwc_pedido.getrow(),"fact_ann")
	li_ann = ii_ann
	
	ldt_fecha = date(ldwc_pedido.getitemdatetime(ldwc_pedido.getrow(),"fact_fecha"))
	ls_nombre = ldwc_pedido.getitemstring(ldwc_pedido.getrow(),"fact_a_nombre")
	ls_cuenta = ldwc_pedido.getitemstring(ldwc_pedido.getrow(),"fact_ruc_cliente")
	ls_direccion  = ldwc_pedido.getitemstring(ldwc_pedido.getrow(),"fact_a_nombre_direccion")
	ls_despacho   = ldwc_pedido.getitemstring(ldwc_pedido.getrow(),"fact_despachado")
	ls_consignado = ldwc_pedido.getitemstring(ldwc_pedido.getrow(),"fact_consignado")
	ls_comentario = ldwc_pedido.getitemstring(ldwc_pedido.getrow(),"fact_comentario")
	ll_documento  = ldwc_pedido.getitemnumber(ldwc_pedido.getrow(),"fact_no_traspaso")
	
	
	dw_2.setitem(1,'nombre', ls_nombre)
	dw_2.setitem(1,'fecha',ldt_fecha)
	dw_2.setitem(1,'ann',li_ann)
	dw_2.setitem(1,'direccion',ls_direccion)
	dw_2.setitem(1,'despachado',ls_despacho)
	dw_2.setitem(1,'consignado',ls_consignado)
	dw_2.setitem(1,'a_nombre_de', ls_nombre)
	dw_2.setitem(1,'no_traspaso', ll_documento)
	dw_2.setitem(1,'observacion', ls_comentario)
	
	if dw_1.retrieve(str.g_financiero, str.empresa, ls_tipo, ls_pedido, li_ann) = 0 then
		mensaje('Aviso','El Pedido Seleccionado no tiene detalle. Verifique','')
	end if

end if
end event

type cb_1 from commandbutton within w_fa_ma_modificar_detalle
integer x = 4837
integer y = 36
integer width = 663
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar Productos"
end type

event clicked;integer i
string ls_descripcion, ls_codigo_alterno, ls_producto, ls_error, ls_arancel_cuba
decimal{2} ld_peso

if dw_3.rowcount() = 0 then return
if gf_mensaje('','Esta Seguro de Actualizar los Datos ?',2,1,'Q') = 2 then return

for i = 1 to dw_3.rowcount()
	dw_3.scrolltorow(i)
	ls_producto	    		= dw_3.getitemstring(i,'referencia')
	ls_descripcion		= dw_3.getitemstring(i,'descripcion')	
	ls_codigo_alterno	= dw_3.getitemstring(i,'codigo_alternativo')	
	ld_peso				= dw_3.getitemnumber(i,'peso')
	ls_arancel_cuba    = dw_3.getitemstring(i,'arancel_cuba')	
	
		update inmprodu
		set prod_descripcion_cuba = :ls_descripcion,
			 prod_contrato_regalias = :ls_arancel_cuba,
			 prod_cod_alternativo    = :ls_codigo_alterno,
			 prod_peso					= :ld_peso
		where prod_g_financiero = :str.g_financiero and
				prod_empresa		= :str.empresa and
				prod_producto = :ls_producto ;
				
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback using sqlca;
			mensaje('Atención',"¡ Error al Actualizar Descripcion Cuba!", ls_error)
		end if		
	
next

gf_mensaje('','Importacion Exitosa',1,1,'E')

if dw_1.retrieve(str.g_financiero, str.empresa, is_tipo, is_pedido, ii_ann) = 0 then
	mensaje('Aviso','El Pedido Seleccionado no tiene detalle. Verifique','')
end if

dw_2.setfocus()

end event

type cb_2 from commandbutton within w_fa_ma_modificar_detalle
integer x = 3867
integer y = 36
integer width = 663
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Importar Archivo"
end type

event clicked;string docname, named
integer value

dw_3.reset()

if dw_1.rowcount() = 0 then return

value = GetFileOpenName("Seleccione la Compra...", &
		+ docname, named, "TXT", &
		+ "Archivo de Texto (*.TXT),*.TXT")
IF value = 1 THEN 
	dw_3.ImportFile(docname)
end if

end event

type gb_1 from groupbox within w_fa_ma_modificar_detalle
integer x = 14
integer width = 3483
integer height = 624
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
string text = "Seleccionar Pedido"
end type

type dw_3 from datawindow within w_fa_ma_modificar_detalle
integer x = 3525
integer y = 180
integer width = 2651
integer height = 1520
integer taborder = 30
boolean titlebar = true
string title = "Datos a Actualizar"
string dataobject = "dw_external_cuba"
boolean controlmenu = true
boolean vscrollbar = true
string icon = "AppIcon!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

