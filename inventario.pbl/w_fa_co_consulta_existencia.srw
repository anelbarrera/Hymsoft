//objectcomments Consulta de Existencias
forward
global type w_fa_co_consulta_existencia from w_fa_padre_reportes
end type
type sle_producto from singlelineedit within w_fa_co_consulta_existencia
end type
type cb_1 from commandbutton within w_fa_co_consulta_existencia
end type
type dw_3 from datawindow within w_fa_co_consulta_existencia
end type
type dw_4 from datawindow within w_fa_co_consulta_existencia
end type
type dw_2 from datawindow within w_fa_co_consulta_existencia
end type
type dw_5 from datawindow within w_fa_co_consulta_existencia
end type
type dw_productos from datawindow within w_fa_co_consulta_existencia
end type
type pb_1 from picturebutton within w_fa_co_consulta_existencia
end type
type st_1 from statictext within w_fa_co_consulta_existencia
end type
type dw_6 from datawindow within w_fa_co_consulta_existencia
end type
type pb_2 from picturebutton within w_fa_co_consulta_existencia
end type
type dw_7 from datawindow within w_fa_co_consulta_existencia
end type
end forward

global type w_fa_co_consulta_existencia from w_fa_padre_reportes
boolean visible = false
integer x = 5
integer y = 60
integer width = 5778
integer height = 2532
string title = "Consulta de Productos"
event ue_busqueda ( )
sle_producto sle_producto
cb_1 cb_1
dw_3 dw_3
dw_4 dw_4
dw_2 dw_2
dw_5 dw_5
dw_productos dw_productos
pb_1 pb_1
st_1 st_1
dw_6 dw_6
pb_2 pb_2
dw_7 dw_7
end type
global w_fa_co_consulta_existencia w_fa_co_consulta_existencia

type prototypes
FUNCTION long ShellExecute( ulong hWnd, string Operation, string lpFile, string  lpParameters, string lpDirectory, int nShowCmd ) LIBRARY "shell32.dll" ALIAS FOR "ShellExecuteW"
FUNCTION long ShellExecuteW ( &
    long hwnd, &
    string lpOperation, &
    string lpFile, &
    string lpParameters, &
    string lpDirectory, &
    long nShowCmd &
) LIBRARY "shell32.dll" ALIAS FOR "ShellExecuteW"

end prototypes

type variables
long il_filas, il_swc, ii_tiempo, il_amarillo, il_blanco
string is_bodega_ubica,is_codigo
boolean ib_viene_de_back
end variables

forward prototypes
public subroutine wf_recupera_confirmacion_transito (string as_codigo)
end prototypes

event ue_busqueda();Long	 				ll_num_prove, ll_row
String				ls_syntax, ls_codigo, ls_descripcion, ls_costos
Integer           li_len
str_dg_dynamic_find	lstr_df

/***************************************************************************************
 *										                                  								*
 *  									Búsqueda Dinámica de Productos									*
 ***************************************************************************************/

lstr_df.texto_campo [1,1] = "inmprodu.prod_producto"
lstr_df.texto_campo [1,2] = "Producto"
lstr_df.texto_campo [1,3] = "prod_producto"
lstr_df.texto_campo [1,4] = "V"
lstr_df.texto_campo [2,1] = "inmprodu.prod_descripcion"
lstr_df.texto_campo [2,2] = "Descripción"
lstr_df.texto_campo [2,3] = ""
lstr_df.texto_campo [2,4] = "V"
lstr_df.texto_campo [3,1] = "inmprodu.prod_barra"
lstr_df.texto_campo [3,2] = "Código de Barra"
lstr_df.texto_campo [3,3] = ""
lstr_df.texto_campo [3,4] = "V"
//lstr_df.texto_campo [4,1] = "inmprodu.prod_descripcion_dos"
//lstr_df.texto_campo [4,2] = "Descripcion Dos"
//lstr_df.texto_campo [4,3] = ""
//lstr_df.texto_campo [4,4] = "V"	

lstr_df.tabla 		  = " inmprodu "
lstr_df.tabla_where = " WHERE ( ( inmprodu.prod_g_financiero = "+ string(str.g_financiero)+" ) AND  " +&
							 "( inmprodu.prod_empresa = "+string(str.empresa)+" ) AND " +& 
							 "( inmprodu.prod_status = 1 ) ) "
			                 

OpenWithParm(w_dg_a_custom_find,lstr_df)
ls_syntax = Message.StringParm

ls_codigo = String(Right(ls_syntax,Len(ls_syntax) - Pos(ls_syntax,"=")))

gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)
//messagebox('',ls_codigo)
if not IsNull(ls_codigo) and (ls_codigo <> "") Then 
	if il_swc = 0 Then
		This.Show()
		This.visible = true
		//This.SetRedraw(True)
		il_swc = 1
	End If
	
	if dw_1.Retrieve(str.g_financiero,str.empresa,ls_codigo, is_bodega_ubica) > 0 then
		//Para que se ubique en el datawindow de detalle de los productos
		ll_row = dw_productos.find("producto = '"+ls_codigo+"'",1,dw_productos.rowcount())

		ls_costos = gf_clave_costos(dw_1.getitemnumber(1,"prod_costo_cif"))
		if isnull(ls_costos) then
			ls_costos = ' '
		end if		
		dw_1.object.costos.expression = "'"+ls_costos+"'"				

		//Recupera la informacion de la confirmacion y del transito
		if dw_1.dataobject = 'dw_co_fa_consulta_existencias_compras' then
			wf_recupera_confirmacion_transito(ls_codigo)
		end if	
			
		if ll_row > 0 then
			dw_productos.scrolltorow(ll_row)
		end if
		ls_descripcion = dw_1.GetItemString(dw_1.GetRow(),'prod_descripcion')
		//st_2.Text = '-----' + ls_codigo + '-----'+ ls_descripcion + '-----'
	end if
Else
	If il_swc = 0 Then
//		Close(this)
	Else
		Return
	End If
End If

end event

public subroutine wf_recupera_confirmacion_transito (string as_codigo);//Solo recupera la informacion de la confirmacion y el transito del producto
integer li_recupero
li_recupero = dw_3.retrieve(str.g_financiero, str.empresa, as_codigo)
if li_recupero = 0 then dw_3.insertrow(0)
li_recupero = dw_4.retrieve(str.g_financiero, str.empresa, as_codigo)
if li_recupero = 0 then dw_4.insertrow(0)
end subroutine

on w_fa_co_consulta_existencia.create
int iCurrent
call super::create
this.sle_producto=create sle_producto
this.cb_1=create cb_1
this.dw_3=create dw_3
this.dw_4=create dw_4
this.dw_2=create dw_2
this.dw_5=create dw_5
this.dw_productos=create dw_productos
this.pb_1=create pb_1
this.st_1=create st_1
this.dw_6=create dw_6
this.pb_2=create pb_2
this.dw_7=create dw_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_producto
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.dw_4
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.dw_5
this.Control[iCurrent+7]=this.dw_productos
this.Control[iCurrent+8]=this.pb_1
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.dw_6
this.Control[iCurrent+11]=this.pb_2
this.Control[iCurrent+12]=this.dw_7
end on

on w_fa_co_consulta_existencia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.sle_producto)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.dw_2)
destroy(this.dw_5)
destroy(this.dw_productos)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.dw_6)
destroy(this.pb_2)
destroy(this.dw_7)
end on

event open;//override
long ll_red1 = 255, ll_green1 = 255, ll_blue1 = 0, ll_red2 = 0, ll_green2 = 0, ll_blue2 = 0
string ls_filename_bat

il_amarillo = ll_Red1 + (256 * ll_Green1) + (65536 * ll_Blue1) 
//il_negro    = ll_Red2 + (256 * ll_Green2) + (65536 * ll_Blue2) 
//il_azul 	  = 16711680
il_blanco   = 16777215
integer li_pos
string ls_mid
this.y = 10
this.x = 10
THIS.SetToolbar(1, true, alignattop!)
THIS.SetToolbarPos(1, 1, 50, false)
yield()
dw = dw_1
//this.SetRedraw(False)
pb_2.visible = false
//This.Hide()
st_nom_ventana.text = this.classname()

is_codigo = message.stringparm

//str_fa_formato lstr_datawin
//lstr_datawin = message.powerobjectparm

//dw_1.dataobject = lstr_datawin.datawindow


//dw_2.dataobject = lstr_datawin.datawindow+"2"
//li_pos = pos(lstr_datawin.tipo_formato,"W=")
//ls_mid = mid(lstr_datawin.tipo_formato,li_pos + 2,4)

//dw_1.width  	  = long(mid(lstr_datawin.tipo_formato,pos(lstr_datawin.tipo_formato,"W=")+2,4))
//dw_1.Height 	  = long(trim(mid(lstr_datawin.tipo_formato,pos(lstr_datawin.tipo_formato,"H=")+2,4)))
//li_pos 			  = pos(lstr_datawin.tipo_formato,"Wd=")
//dw_2.width  	  = long(mid(lstr_datawin.tipo_formato,li_pos+3,4))
//dw_2.y      	  = long(trim(mid(lstr_datawin.tipo_formato,pos(lstr_datawin.tipo_formato,"Y=")+2,4)))
//st_nom_ventana.y = long(trim(mid(lstr_datawin.tipo_formato,pos(lstr_datawin.tipo_formato,"Sy=")+3,4)))

if pos(Upper(str.empr_acceso_especial),'ELBROS,') > 0 then
	dw_2.height = 0  	  
end if

//messagebox('',long(mid(lstr_datawin.tipo_formato,pos(lstr_datawin.tipo_formato,"Wd=")+3,4)))
//Para cuando solo requiere del dw1

//if long(mid(lstr_datawin.tipo_formato,pos(lstr_datawin.tipo_formato,"Wd=")+3,4)) = 1 then
//	dw_2.visible = false
//	this.height	= long(trim(mid(lstr_datawin.tipo_formato,pos(lstr_datawin.tipo_formato,"H=")+2,4))) +200
//	dw_2.y = 1200
//else
//	this.height	= long(trim(mid(lstr_datawin.tipo_formato,pos(lstr_datawin.tipo_formato,"H=")+2,4))) + 500
//end if
//this.width		  = dw_1.width + 2700

il_swc = 0

This.Icon = str.icono

//Solo para el historial de facturas(Para la consulta de reservado de productos)

//is_codigo = lstr_datawin.codigo

this.postevent("ue_post_open")

//dw_1.Sharedata(dw_2)



end event

event ue_post_open;//Override
string ls_codigo, ls_costos, ls_bodega, ls_ubica
datawindowChild ldwc_producto
//Para ocultar las opciones de consultas, cuando es Elbros
if pos(Upper(str.empr_acceso_especial),'ELBROS,') > 0 then gf_fa_cambiar_titulos(this.menuid)


dw_2.SetTransObject(sqlca)
dw_1.SetTransObject(sqlca)
dw_3.SetTransObject(sqlca)
dw_4.SetTransObject(sqlca)
dw_6.SetTransObject(sqlca)
dw_7.SetTransObject(sqlca)
dw_7.retrieve(str.usuario, str.empresa)
if isnull(is_bodega_ubica) then is_bodega_ubica = ' '

if dw_1.dataobject = 'dw_co_fa_consulta_existencias_compras' then
	dw_3.visible = true
	dw_4.visible = true
end if

//if dw_1.dataobject = 'dw_co_fa_consulta_existencias_elbros'then
//   dw_1.Getchild('acol_num_color',ldwc_producto)
//	ldwc_producto.Settransobject(sqlca)
//	ldwc_producto.retrieve(str.g_financiero, str.empresa)
//end if	

dw_productos.settransobject(sqlca)
if dw_productos.retrieve(str.g_financiero, str.empresa) > 0 then
	
	dw_1.Getchild('prod_producto',ldwc_producto)
	ldwc_producto.Settransobject(sqlca)
	ldwc_producto.retrieve(str.g_financiero, str.empresa)
	//
	if is_codigo <> ''  THEN
		dw_productos.setitem(1,"producto",is_codigo)
	end if
	//
	ls_codigo = dw_productos.getitemstring(1,"producto")
	
	//if dw_1.Retrieve(str.g_financiero,str.empresa,ls_codigo, is_bodega_ubica ) > 0 then
	if dw_1.Retrieve(str.g_financiero,str.empresa,ls_codigo ) > 0 then
		ls_costos = gf_clave_costos(dw_1.getitemnumber(1,"prod_costo_cif"))
		if isnull(ls_costos) then
			mensaje("Atención",'Sr. Usuario, debe definir la clave para los costos en Inventario / Procesos / Clave de Costos y Precios','')
			ls_costos = ' '
		end if
		dw_1.object.costos.expression = "'"+ls_costos+"'"
		dw_6.retrieve(str.g_financiero, str.empresa, ls_codigo)
				
//		if dw_1.dataobject = 'dw_co_fa_consulta_existencias_compras' then
//			wf_recupera_confirmacion_transito(ls_codigo)
//		elseif dw_1.dataobject = 'dw_co_fa_consulta_existencias_venta' then
//			if pos(gf_dg_nombre_empresa(),'TEMPO') > 0 then
//				dw_1.object.prod_contrato_regalias.visible = true
//			end if			

//		end if	
		else 
			dw_1.InsertRow(0)
	end if
else
	messagebox("Atencion","No hay productos para consultar...Verifique")
	dw_1.InsertRow(0)
end if

dw_1.setfocus()

//if	w_fa_fondo.str_para.empaque_decimales = 1 then	
//	dw_1.object.inmprodu_prod_empaque.edit.format='###0.##'
//	dw_1.object.inmprodu_prod_empaque.format='###0.##'	
//end if

//m_fa_padre.m_edicin.m_busqueda.visible = true
//m_fa_padre.m_edicin.m_busqueda.enabled = true
//m_fa_padre.m_edicin.m_busqueda.toolbaritemvisible = true
dw_5.settransobject(sqlca)

//Agregado por Irving Aguilar 2 de Sept de 2004
if pos(Upper(str.empr_acceso_especial),'ELBROS,') > 0 and dw_1.dataobject = "dw_co_fa_consulta_existencias_elbros" then
	pb_1.picturename = str.path+"\art\blind.bmp"
	pb_1.visible = true
	st_1.visible = True
else
	pb_1.visible = false
	st_1.visible = false
end if
//Fin agregado 2 de Sep de 2004

//this.setredraw(true)
pb_2.visible = true
dw_1.setredraw(true)
dw_1.setcolumn('prod_producto')
end event

event ue_print;//
//dw = dw_1
//dw.SetRedraw(False)
//dw.Object.DataWindow.Color = RGB(255,255,255)
//dw.Object.DataWindow.Header.Height = 508
//OpenWithParm(w_dw_print_options, dw)
//If Message.DoubleParm = -1 Then Return
//dw.Print(True)
//dw.Object.DataWindow.Header.Height = 0
//dw.Object.DataWindow.Color = RGB(192,192,192)
//dw.SetRedraw(True)

dw = dw_1
//dw.SetRedraw(False)
dw.Object.DataWindow.Color = RGB(255,255,255)
dw.Object.DataWindow.Header.Height = 488
dw.Modify("DataWindow.Header.1.Height=1188")
dw.Object.DataWindow.Detail.Height = 72
dw.Object.DataWindow.Footer.Height = 88
OpenWithParm(w_dw_print_options, dw)
If Message.DoubleParm = -1 Then Return
dw.Print(True)
dw.Object.DataWindow.Header.Height = 0
dw.Modify("DataWindow.Header.1.Height=0")
dw.Object.DataWindow.Detail.Height = 0
dw.Object.DataWindow.Footer.Height = 0
dw.Object.DataWindow.Color = RGB(192,192,192)
dw.SetRedraw(True)
end event

event resize;st_nom_ventana.y = newheight - (st_nom_ventana.height + 10)
dw_2.y = newheight - (dw_2.height + 75)
//dw_1.Resize(newwidth - 30, newheight - 30)
//gb_1.Width = newwidth - 75
//gb_1.Height = newheight - 120
dw_5.y = 1 
dw_5.x = 1 
dw_5.Width = this.Width - 75
dw_5.height = this.height - 100

end event

event ue_siguiente_reg;//override
long ll_row
string ls_codigo, ls_sort, ls_costos
	ll_row = dw_productos.getrow()
	if ll_row < dw_productos.rowcount() then
		dw_productos.scrolltorow(ll_row + 1)
		ls_codigo = dw_productos.getitemstring(ll_row + 1,'producto')
		if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo, is_bodega_ubica) = 0 then
			messagebox("Atencion","No se encontro el producto "+ ls_codigo)
		else
			ls_costos = gf_clave_costos(dw_1.getitemnumber(1,"prod_costo_cif"))
			if isnull(ls_costos) then
				ls_costos = ' '
			end if					
			dw_1.object.costos.expression = "'"+ls_costos+"'"
			
			//Recupera la informacion de la confirmacion y del transito
			if dw_1.dataobject = 'dw_co_fa_consulta_existencias_compras' then
				wf_recupera_confirmacion_transito(ls_codigo)
			end if	
			
		end if
		if dw_1.object.color_orden.expression = '1' then
			dw_1.setcolumn(2)
		end if
	end if		
end event

event ue_reg_anterior;//override
long ll_row
string ls_codigo, ls_sort, ls_costos
	ll_row = dw_productos.getrow()
	if ll_row > 1 then
		dw_productos.scrolltorow(ll_row - 1)
		ls_codigo = dw_productos.getitemstring(ll_row - 1,'producto')
		if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo, is_bodega_ubica) = 0 then
			messagebox("Atencion","No se encontro el producto "+ ls_codigo)
		else
			ls_costos = gf_clave_costos(dw_1.getitemnumber(1,"prod_costo_cif"))
			if isnull(ls_costos) then
				ls_costos = ' '
			end if					
			dw_1.object.costos.expression = "'"+ls_costos+"'"
			//Recupera la informacion de la confirmacion y del transito
			if dw_1.dataobject = 'dw_co_fa_consulta_existencias_compras' then
				wf_recupera_confirmacion_transito(ls_codigo)
			end if	
			
		end if
		if dw_1.object.color_orden.expression = '1' then
			dw_1.setcolumn(2)
		end if		
	end if
end event

event ue_ultimo_reg;//Override
long ll_row
string ls_codigo, ls_sort, ls_costos
	ll_row = dw_productos.rowcount()
	if ll_row > 1 then
		dw_productos.scrolltorow(ll_row)
		ls_codigo = dw_productos.getitemstring(ll_row,'producto')
		if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo, is_bodega_ubica) = 0 then
			messagebox("Atencion","No se encontro el producto "+ ls_codigo)
		else
			ls_costos = gf_clave_costos(dw_1.getitemnumber(1,"prod_costo_cif"))
			if isnull(ls_costos) then
				ls_costos = ' '
			end if		
			dw_1.object.costos.expression = "'"+ls_costos+"'"
			//Recupera la informacion de la confirmacion y del transito
			if dw_1.dataobject = 'dw_co_fa_consulta_existencias_compras' then
				wf_recupera_confirmacion_transito(ls_codigo)
			end if	
			
		end if
		if dw_1.object.color_orden.expression = '1' then
			dw_1.setcolumn(2)
		end if		
	end if	

end event

event ue_primer_reg;//Override
long ll_row
string ls_codigo, ls_sort, ls_costos
	dw_productos.scrolltorow(1)
	ls_codigo = dw_productos.getitemstring(1,'producto')
	if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo, is_bodega_ubica) = 0 then
		messagebox("Atencion","No se encontro el producto "+ ls_codigo)		
	else
		ls_costos = gf_clave_costos(dw_1.getitemnumber(1,"prod_costo_cif"))
		if isnull(ls_costos) then
			ls_costos = ' '
		end if		
		dw_1.object.costos.expression = "'"+ls_costos+"'"
		//Recupera la informacion de la confirmacion y del transito
		if dw_1.dataobject = 'dw_co_fa_consulta_existencias_compras' then
			wf_recupera_confirmacion_transito(ls_codigo)
		end if	
		
	end if
	
		if dw_1.object.color_orden.expression = '1' then
			dw_1.setcolumn(2)
		end if



end event

event activate;call super::activate;if not isvalid(m_fa_rep) then
	this.changemenu(m_fa_rep)
end if
end event

event timer;call super::timer;ii_tiempo ++

if mod (ii_tiempo ,2) = 0 then
	dw_1.Modify("transito.Background.Color='"+string(il_amarillo)+"'")
else
	dw_1.Modify("transito.Background.Color='"+string(il_blanco)+"'")
end if
end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_co_consulta_existencia
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_co_consulta_existencia
boolean visible = false
integer x = 27
integer y = 1852
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_co_consulta_existencia
event ue_down pbm_dwnkey
event ue_enter pbm_dwnprocessenter
integer x = 18
integer y = 0
integer width = 2953
integer height = 2168
integer taborder = 0
string dataobject = "dw_co_fa_consulta_existencias_elbros"
boolean border = false
boolean livescroll = false
end type

event dw_1::ue_down;//Teclas de funciones
long ll_row 
string ls_codigo, ls_sort
if keyDown(KeyUpArrow!) then
	parent.triggerevent('ue_reg_anterior')
	return 2
elseif keyDown(KeyDownArrow!) then	
	parent.triggerevent('ue_siguiente_reg')
//	dw_1.Modify("DataWindow.VerticalScrollPosition='1'")	
	return 2
elseif keydown(KeyControl!) and keydown(KeyC!) then
	ls_codigo = dw_productos.getitemstring(dw_productos.getrow(),"producto")
	ls_sort = dw_productos.Describe("DataWindow.Table.Sort")
	if ls_sort <> "producto A" then		
		dw_productos.setsort("producto A")
		dw_productos.sort()
		dw_1.object.color_orden.expression = '0'
		ll_row = dw_productos.find('producto = "'+ls_codigo+'"',1,dw_productos.rowcount())
		if ll_row > 0 then
			dw_productos.scrolltorow(ll_row)
		end if
	end if
	dw_1.setcolumn(1)		
elseif keydown(KeyControl!) and keydown(KeyD!) then
	ls_codigo = dw_productos.getitemstring(dw_productos.getrow(),"producto")
	ls_sort = dw_productos.Describe("DataWindow.Table.Sort") 
	if ls_sort <> "descripcion A" then			
		dw_productos.setsort("descripcion A")	
		dw_productos.sort()
		dw_1.object.color_orden.expression = '1'		
		ll_row = dw_productos.find('producto = "'+ls_codigo+'"',1,dw_productos.rowcount())
		if ll_row > 0 then
			dw_productos.scrolltorow(ll_row)
		end if		
	end if	
	dw_1.setcolumn(2)	
elseif keydown(KeyControl!) and keydown(Keyend!) then
	parent.triggerevent('ue_ultimo_reg')
	return 2
elseif keydown(KeyControl!) and keydown(Keyhome!) then
	parent.triggerevent('ue_primer_reg')
	return 2
elseif keydown(KeyControl!) and keydown(KeyB!) or keydown(keyf1!)then
	parent.triggerevent('ue_busqueda')	
elseif keydown(KeyF5!) then
	ls_codigo = dw_productos.getitemstring(dw_productos.getrow(),"producto")
	this.trigger event itemchanged(this.getrow(),This.object.prod_producto,ls_codigo)		
//elseif keydown(KeyF3!) then
//	//Asigna un uno al compute codigo_barra si anteriormente tenia cero 
//	if this.object.codigo_barra.expression = '0' then
//		this.object.codigo_barra.expression = string(1)
//	else
//		this.object.codigo_barra.expression = string(0)
//	end if		
//	
elseif keydown(KeyF9!) then 
	this.setredraw(false)
	if this.describe("inmprodu_prod_foto_dir.y") <> '8' then
//		this.modify("inmprodu_prod_foto_dir.y ='8'")	
//		this.modify("inmprodu_prod_foto_dir.x ='1367'")		
//		this.modify("inmprodu_prod_foto_dir.height ='917'")		
//		this.modify("inmprodu_prod_foto_dir.width ='1440'")	
		this.modify("inmprodu_prod_foto_dir.y ='8'")	
		this.modify("inmprodu_prod_foto_dir.x ='9'")		
		this.modify("inmprodu_prod_foto_dir.height ='1080'")		
		this.modify("inmprodu_prod_foto_dir.width ='2798'")	
	else
		if pos(Upper(str.empr_acceso_especial),'ELBROS,') > 0 then
			this.modify("inmprodu_prod_foto_dir.y ='896'")	
			this.modify("inmprodu_prod_foto_dir.x ='1504'")
			this.modify("inmprodu_prod_foto_dir.height ='800'")		
			this.modify("inmprodu_prod_foto_dir.width ='1088'")			
		else
			this.modify("inmprodu_prod_foto_dir.y ='304'")	
			this.modify("inmprodu_prod_foto_dir.x ='1989'")
			this.modify("inmprodu_prod_foto_dir.height ='620'")		
			this.modify("inmprodu_prod_foto_dir.width ='818'")			
		end if
	end if
	this.setredraw(true)	
end if
end event

event dw_1::ue_enter;//return 2
end event

event dw_1::clicked;//Script que Permite Ordenar Ascendentemente, o Descendente en caso que se dé click nuevamente
//en la misma columna.
dw_5.visible = false 
string ls_objeto
integer li_pos 

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if ls_objeto = 'rentero' then
		str_fa_formato lstr_datawindow
		string ls_producto
		
			lstr_datawindow.datawindow = "dw_fa_rep_reserva_existencia_new"
			ls_producto = dw_1.getitemstring(1,"prod_producto")
			lstr_datawindow.producto = ls_producto
			
			OpenSheetWithParm(w_disponibles,lstr_datawindow, str.frame,2, Original!)
			
end if
end event

event dw_1::ue_microayuda;//override
end event

event dw_1::constructor;//Override
end event

event dw_1::itemchanged;call super::itemchanged;//modificación
string  ls_codigo, ls_descrip, ls_sort, ls_costos, ls_expresion,ls_error, ls_prod_back
long    ll_row

this.accepttext()

choose case this.getcolumnname()
	case "prod_producto","inmprodu_prod_barra"
		dw_6.reset()
		if this.getcolumnname() = 'prod_producto' then
			ls_codigo = 	this.getitemString(1,'prod_producto')
		else
			ls_codigo = 	this.getitemString(1,'inmprodu_prod_barra')			
		end if
		
			//Valida si el codigo de barra del producto existe.
				  SELECT max(inmprodu.prod_producto)  
					 INTO :ls_codigo  
					 FROM inmprodu  
					WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
							( inmprodu.prod_empresa = :str.empresa ) AND  
							( ( inmprodu.prod_producto = :ls_codigo )  or  ( inmprodu.prod_barra = :ls_codigo ) )AND  //Tiene el codigo de barra
							( inmprodu.prod_status = 1 )   ;
					if sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrtext
						mensaje("Aviso","Error al Validar existencia del Artículo (Codigo de Barra)",ls_error)
						return
					end if						
	
		ls_sort = dw_productos.Describe("DataWindow.Table.Sort") 
		if ls_sort <> "producto A" then			
			dw_productos.setsort("producto A")	
			dw_productos.sort()
			dw_1.object.color_orden.expression = '0'		
		end if

		ll_row = dw_productos.find('producto = "'+ls_codigo+'"',1,dw_productos.rowcount())
		
		if ll_row > 0 then
			dw_productos.scrolltorow(ll_row)
			if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo, is_bodega_ubica) = 0 then
				messagebox("Atencion","No se encontro el producto "+ ls_codigo)
			else
				dw_6.retrieve(str.g_financiero, str.empresa, ls_codigo)
				ls_costos = gf_clave_costos(dw_1.getitemnumber(1,"prod_costo_cif"))				
				if isnull(ls_costos) then
					ls_costos = ' '
				end if				
				dw_1.object.costos.expression = "'"+ls_costos+"'"
				//Recupera la informacion de la confirmacion y del transito
				if dw_1.dataobject = 'dw_co_fa_consulta_existencias_compras' then
					wf_recupera_confirmacion_transito(ls_codigo)
				end if	
				if dw_1.getitemnumber(1,'transito') > 0 then
					timer(1)
				else
					timer(0)
					dw_1.Modify("transito.Background.Color='"+string(il_blanco)+"'")
				end if
				//Adiciona el producto en la tabla para el BACK historial de busquedas
				if not ib_viene_de_back then
					if dw_7.rowcount() > 0 then ls_prod_back = dw_7.getitemstring(1,'producto')
					if ls_prod_back <> ls_codigo then
						dw_7.scrolltorow(dw_7.insertrow(1))
						dw_7.setitem(dw_7.getrow(),'producto',ls_codigo)
						dw_7.setitem(dw_7.getrow(),'usuario',str.usuario)
						dw_7.setitem(dw_7.getrow(),'empresa',str.empresa)
						if dw_7.update() = -1 then gf_mensaje('','Error al Guardar '+sqlca.sqlerrtext,1,1,'E')
					else
						dw_7.scrolltorow(1)
					end if
				end if
				ib_viene_de_back = false	
			end if
			return 2
		else
			ll_row = dw_productos.find('producto like "'+ls_codigo+'%"',1,dw_productos.rowcount())			
			if ll_row > 0 then
				dw_productos.scrolltorow(ll_row)
				ls_codigo = dw_productos.getitemstring(ll_row,'producto')				
				if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo, is_bodega_ubica) = 0 then
					messagebox("Atencion","No se encontro el producto "+ ls_codigo)
				else
					dw_6.retrieve(str.g_financiero, str.empresa, ls_codigo)
					ls_costos = gf_clave_costos(dw_1.getitemnumber(1,"prod_costo_cif"))
					if isnull(ls_costos) then
						ls_costos = ' '
					end if		
					dw_1.object.costos.expression = "'"+ls_costos+"'"
					//Recupera la informacion de la confirmacion y del transito
					if dw_1.dataobject = 'dw_co_fa_consulta_existencias_compras' then
						wf_recupera_confirmacion_transito(ls_codigo)
					end if	
					if dw_1.getitemnumber(1,'transito') > 0 then
						timer(1)
					else
						timer(0)
						dw_1.Modify("transito.Background.Color='"+string(il_blanco)+"'")
					end if
					
					//Adiciona el producto en la tabla para el BACK historial de busquedas
					if not ib_viene_de_back then
						if dw_7.rowcount() > 0 then ls_prod_back = dw_7.getitemstring(1,'producto')
						if ls_prod_back <> ls_codigo then
							dw_7.scrolltorow(dw_7.insertrow(1))
							dw_7.setitem(dw_7.getrow(),'producto',ls_codigo)
							dw_7.setitem(dw_7.getrow(),'usuario',str.usuario)
							dw_7.setitem(dw_7.getrow(),'empresa',str.empresa)							
							if dw_7.update() = -1 then gf_mensaje('','Error al Guardar '+sqlca.sqlerrtext,1,1,'E')
						else
							dw_7.scrolltorow(1)
						end if
					end if
					ib_viene_de_back = false	
					
				end if				
				return 2
			else	
				mensaje("Atención ","Código No existe ...!!!","")					
				return 2
			end if
		end if				
	
	case "prod_descripcion"
		ls_descrip = data
		ls_sort = dw_productos.Describe("DataWindow.Table.Sort") 
		if ls_sort <> "descripcion A" then			
			dw_productos.setsort("descripcion A")	
			dw_productos.sort()
			dw_1.object.color_orden.expression = '1'		
		end if
		
			ll_row = dw_productos.find('descripcion = "'+ls_descrip+'"',1,dw_productos.rowcount())
			
			if ll_row > 0 then
				dw_productos.scrolltorow(ll_row)
				ls_codigo = dw_productos.getitemstring(ll_row,"producto")
				if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo, is_bodega_ubica) = 0 then
					messagebox("Atencion","No se encontro el producto "+ ls_codigo)
				else
					dw_6.retrieve(str.g_financiero, str.empresa, ls_codigo)
					ls_costos = gf_clave_costos(dw_1.getitemnumber(1,"prod_costo_cif"))
					if isnull(ls_costos) then
						ls_costos = ' '
					end if
					dw_1.object.costos.expression = "'"+ls_costos+"'"
					//Recupera la informacion de la confirmacion y del transito
					if dw_1.dataobject = 'dw_co_fa_consulta_existencias_compras' then
						wf_recupera_confirmacion_transito(ls_codigo)
					end if	
					
				end if
				dw_1.setcolumn(2)				
				return 2
			else
				ll_row = dw_productos.find('descripcion like "'+ls_descrip+'%"',1,dw_productos.rowcount())			
				if ll_row > 0 then
					dw_productos.scrolltorow(ll_row)
					ls_codigo = dw_productos.getitemstring(ll_row,'producto')
					if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo, is_bodega_ubica) = 0 then
						messagebox("Atencion","No se encontro el producto "+ ls_codigo)
					else
						dw_6.retrieve(str.g_financiero, str.empresa, ls_codigo)
						ls_costos = gf_clave_costos(dw_1.getitemnumber(1,"prod_costo_cif"))
						if isnull(ls_costos) then
							ls_costos = ' '
						end if		
						dw_1.object.costos.expression = "'"+ls_costos+"'"						
						//Recupera la informacion de la confirmacion y del transito
						if dw_1.dataobject = 'dw_co_fa_consulta_existencias_compras' then
							wf_recupera_confirmacion_transito(ls_codigo)
						end if							
					end if				
					dw_1.setcolumn(2)					
					return 2
				else	
					mensaje("Atención ","Código No existe ...!!!","")										
					dw_1.setcolumn(2)					
					return 2
				end if
			end if				
			
		
end choose
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;//RETURN 2
end event

event dw_1::doubleclicked;call super::doubleclicked;if dwo.name = 'inmprodu_prod_ultima_entrada_sec' or dwo.name = 'inmprodu_prod_entrada_fecha' then
	String ls_producto,ls_bodega,ls_documento,ls_unid_medida
	integer li_anio
	long li_secuencia
	date	ldt_fecha
	
	/*dw_5.Object.nom_empresa.Expression="'"+str.nombre_empresa + "'"*/
	/*dw_5.Object.fecha.Expression="'"+string(today()) + "'"
	  dw_5.Object.hora.Expression="'"+string(time(today())) + "'"*/
	
	ls_producto = dw_1.GetItemString(dw_1.getrow(),"prod_producto")
	//ls_documento   = dw_1.getitemstring ( dw_1.getrow(),'inmprodu_prod_ultima_entrada_doc')
	li_secuencia   = dw_1.getitemnumber ( dw_1.getrow(),'inmprodu_prod_ultima_entrada_sec')
	ldt_fecha   = date (dw_1.getitemdatetime(dw_1.getrow(),'inmprodu_prod_entrada_fecha'))
	li_anio = year(ldt_fecha)
	
	If isNull(ls_producto)  or ls_producto = '' then
		mensaje("Atención ","Posiciónese en un renglón que tenga código el artículo..y reinténtelo..","")
		return
	end if
//	Messagebox("dw_5.dataobject" ,dw_5.dataobject)
	w_fa_fondo.Setmicrohelp("Recuperando listado de entradas sin costo")
	Setpointer(Hourglass!)
//	if dw_5.retrieve(str.g_financiero,str.empresa,li_anio,li_secuencia) = 0 then	
	if dw_5.retrieve(str.g_financiero,str.empresa,li_secuencia,"EN", li_anio) = 0 then	
		messagebox('Atención','No existen entradas para este producto') 
	else 
   	dw_5.visible = true	
//		w_fa_fondo.Setmicrohelp("No se recuperaron registros")
	end if
	w_fa_fondo.Setmicrohelp("Recuperacion terminada")
	Setpointer(Arrow!)
//	Messagebox("Despues","dw_5.dataobject")
end if


end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_co_consulta_existencia
boolean visible = false
integer taborder = 20
end type

type sle_producto from singlelineedit within w_fa_co_consulta_existencia
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 2391
integer y = 48
integer width = 494
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 16711680
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;//Teclas de funciones
long ll_row 
string ls_codigo, ls_sort
if keyDown(KeyUpArrow!) then
	parent.triggerevent('ue_reg_anterior')
	return 2
elseif keyDown(KeyDownArrow!) then	
	parent.triggerevent('ue_siguiente_reg')
//	dw_1.Modify("DataWindow.VerticalScrollPosition='1'")	
	return 2
elseif keydown(KeyControl!) and keydown(KeyC!) then
	ls_codigo = dw_productos.getitemstring(dw_productos.getrow(),"producto")
	ls_sort = dw_productos.Describe("DataWindow.Table.Sort") 
	if ls_sort <> "producto A" then		
		dw_productos.setsort("producto A")
		dw_productos.sort()
		dw_1.object.color_orden.expression = '0'
		ll_row = dw_productos.find('producto = "'+ls_codigo+'"',1,dw_productos.rowcount())
		if ll_row > 0 then
			dw_productos.scrolltorow(ll_row)
		end if
	end if
elseif keydown(KeyControl!) and keydown(KeyD!) then
	ls_codigo = dw_productos.getitemstring(dw_productos.getrow(),"producto")
	ls_sort = dw_productos.Describe("DataWindow.Table.Sort") 
	if ls_sort <> "descripcion A" then			
		dw_productos.setsort("descripcion A")	
		dw_productos.sort()
		dw_1.object.color_orden.expression = '1'		
		ll_row = dw_productos.find('producto = "'+ls_codigo+'"',1,dw_productos.rowcount())
		if ll_row > 0 then
			dw_productos.scrolltorow(ll_row)
		end if		
	end if	
elseif keydown(KeyControl!) and keydown(Keyend!) then
	parent.triggerevent('ue_ultimo_reg')
	return 2
elseif keydown(KeyControl!) and keydown(Keyhome!) then
	parent.triggerevent('ue_primer_reg')
	return 2
elseif keydown(KeyControl!) and keydown(KeyB!) then
	parent.triggerevent('ue_buscar')	
end if
end event

event modified;string ls_codigo, ls_sort
long   ll_row
		
		ls_codigo = sle_producto.text //dw_productos.getitemstring(dw_productos.getrow(),"producto")
		ls_sort = dw_productos.Describe("DataWindow.Table.Sort") 
		if ls_sort <> "producto A" then			
			dw_productos.setsort("producto A")	
			dw_productos.sort()
			dw_1.object.color_orden.expression = '1'		
		end if

		ll_row = dw_productos.find('producto = "'+ls_codigo+'"',1,dw_productos.rowcount())
		
		if ll_row > 0 then
			dw_productos.scrolltorow(ll_row)
			if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo, is_bodega_ubica) = 0 then
				messagebox("Atencion","No se encontro el producto "+ ls_codigo)
			end if
			return 2
		else
			ll_row = dw_productos.find('producto like "'+ls_codigo+'%"',1,dw_productos.rowcount())		
			if ll_row > 0 then
				dw_productos.scrolltorow(ll_row)
				ls_codigo = dw_productos.getitemstring(ll_row,'producto')				
				if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo, is_bodega_ubica) = 0 then
					messagebox("Atencion","No se encontro el producto "+ ls_codigo)
				end if				
				return 2
			else	
				return 2
			end if
		end if
end event

type cb_1 from commandbutton within w_fa_co_consulta_existencia
boolean visible = false
integer x = 2565
integer y = 80
integer width = 247
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;DW_1.scrolltorow(1)
dw_1.modify("DataWindow.VerticalScrollPosition=0")
end event

type dw_3 from datawindow within w_fa_co_consulta_existencia
boolean visible = false
integer x = 1344
integer y = 636
integer width = 425
integer height = 148
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "dw_co_in_consulta_transito"
boolean border = false
boolean livescroll = true
end type

type dw_4 from datawindow within w_fa_co_consulta_existencia
boolean visible = false
integer x = 2386
integer y = 628
integer width = 389
integer height = 152
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "dw_co_in_consulta_confirmacion"
boolean border = false
boolean livescroll = true
end type

type dw_2 from datawindow within w_fa_co_consulta_existencia
event ue_down pbm_keydown
boolean visible = false
integer x = 37
integer y = 832
integer width = 2976
integer height = 280
string dataobject = "dw_co_fa_consulta_existencias_venta2"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_5 from datawindow within w_fa_co_consulta_existencia
boolean visible = false
integer x = 87
integer y = 308
integer width = 2784
integer height = 600
integer taborder = 50
boolean titlebar = true
string title = "none"
string dataobject = "dw_lis_in_entradas_sin_costo"
boolean controlmenu = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_productos from datawindow within w_fa_co_consulta_existencia
boolean visible = false
integer x = 1454
integer y = 320
integer width = 1385
integer height = 840
integer taborder = 50
string dataobject = "fa_dw_productos_datastore"
borderstyle borderstyle = stylelowered!
end type

type pb_1 from picturebutton within w_fa_co_consulta_existencia
boolean visible = false
integer x = 2683
integer y = 256
integer width = 101
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\art\blind.bmp"
end type

event clicked;//Programacion 2 de Sept de 2004 Irving Aguilar

str_br_general l_str
String ls_numero_entrada,ls_modo
Date ld_fecha_entrada,ldt_fecha 
long li_anio,li_secuencia

li_secuencia   = dw_1.getitemnumber ( dw_1.getrow(),'inmprodu_prod_ultima_entrada_sec')
ldt_fecha   = date (dw_1.getitemdatetime(dw_1.getrow(),'inmprodu_prod_entrada_fecha'))
li_anio = year(ldt_fecha)

//Modo C de consulta desde la consulta de producto
ls_modo = "C"
//Modo C de consulta desde la consulta de producto

l_str.numero2 = li_secuencia 
l_str.numero1 =li_anio
l_str.variable1 = ls_modo
OpenWithParm(w_in_con_entrada,l_str)
end event

type st_1 from statictext within w_fa_co_consulta_existencia
boolean visible = false
integer x = 2405
integer y = 244
integer width = 274
integer height = 112
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Ver detalle de entrada"
boolean focusrectangle = false
end type

type dw_6 from datawindow within w_fa_co_consulta_existencia
integer x = 3013
integer y = 8
integer width = 2638
integer height = 1780
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Consulta de Facturas del Proveedor"
string dataobject = "dw_facturas_producto"
boolean vscrollbar = true
string icon = "Form!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;long ll_secuencia
integer li_ann
string ls_concepto

if dwo.name = 'tmov_documento' then
	str_in_entradas lstr_entrada
	
	ll_secuencia = this.getitemnumber(row,'tmov_secuencia')
	li_ann = this.getitemnumber(row,'tmov_anual')
	ls_concepto = this.getitemstring(row,'tmov_concepto')
	
	lstr_entrada.secuencia = ll_secuencia
	lstr_entrada.ann = li_ann
	lstr_entrada.concepto = ls_concepto
	
	OpenSheetWithParm(w_in_rep_entradas,lstr_entrada,str.frame,11,Layered!)	
end if
end event

event buttonclicked;if dwo.name = 'b_ver' then
	string ls_column, ls_filename
	string ls_null, ls_ruta
	SetNull(ls_null)

		ls_ruta = this.getitemstring(row, 'tmov_ruta_factura')
		
		if len(ls_ruta) = 0 then return
		
		if fileexists(ls_ruta) then
			
		else
			gf_mensaje('','Archivo no Existe, Verifique !!!',1,1,'E')
			return
		end if
		
		ls_filename =ls_ruta
		
		ShellExecutew( 0 , "open", ls_filename, ls_Null, ls_Null, 1)
end if
end event

type pb_2 from picturebutton within w_fa_co_consulta_existencia
integer x = 2455
integer y = 20
integer width = 110
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "Undo!"
alignment htextalign = left!
string powertiptext = "Recupera Última Búsqueda"
end type

event clicked;string ls_prod, ls_codigo

if dw_7.getrow() + 1 > dw_7.rowcount() then return
ls_codigo = dw_1.getitemstring(1,'prod_producto')
ib_viene_de_back = true
if ls_codigo = '' or isnull(ls_codigo) then 
	ls_prod = dw_7.getitemstring(1,'producto')
else
	if dw_7.getrow() = 1 and ls_codigo <> dw_7.getitemstring(1,'producto') then
		ls_prod = dw_7.getitemstring(1,'producto')
	else
		ls_prod = dw_7.getitemstring(dw_7.getrow() + 1,'producto')
		dw_7.scrolltorow(dw_7.getrow() + 1)
	end if

end if
dw_7.visible = false
dw_1.setitem(1,'prod_producto',ls_prod)
dw_1.setcolumn('prod_producto')
dw_1.triggerevent('itemchanged')



end event

event rbuttondown;dw_7.visible = true
end event

type dw_7 from datawindow within w_fa_co_consulta_existencia
boolean visible = false
integer x = 2277
integer y = 120
integer width = 699
integer height = 1096
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_historial_usuario"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event rbuttondown;dw_7.visible = true
end event

event clicked;string ls_prod
	ls_prod = dw_7.getitemstring(row,'producto')
	dw_7.scrolltorow(row)
	dw_7.deleterow(dw_7.getrow())
	if dw_7.update() = -1 then gf_mensaje('','Error al Eliminar '+sqlca.sqlerrtext,1,1,'E')
	dw_1.setitem(1,'prod_producto',ls_prod)	
	dw_1.setcolumn('prod_producto')
	dw_1.triggerevent('itemchanged')
	this.visible = false



end event

