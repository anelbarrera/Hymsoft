//objectcomments Consulta de Existencias
forward
global type w_consulta_productos from w_fa_padre_reportes
end type
type dw_productos from datawindow within w_consulta_productos
end type
type sle_producto from singlelineedit within w_consulta_productos
end type
type cb_1 from commandbutton within w_consulta_productos
end type
type dw_3 from datawindow within w_consulta_productos
end type
type dw_4 from datawindow within w_consulta_productos
end type
end forward

global type w_consulta_productos from w_fa_padre_reportes
boolean visible = false
integer x = 5
integer y = 60
integer width = 3214
integer height = 1492
string title = "Consulta de Productos"
long backcolor = 12639424
event ue_busqueda ( )
dw_productos dw_productos
sle_producto sle_producto
cb_1 cb_1
dw_3 dw_3
dw_4 dw_4
end type
global w_consulta_productos w_consulta_productos

type variables
long il_filas, il_swc
string is_bodega_ubica
end variables

forward prototypes
public subroutine wf_recupera_confirmacion_transito (string as_codigo)
end prototypes

event ue_busqueda;Long	 				ll_num_prove, ll_row
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
//lstr_df.texto_campo [3,1] = "inmprodu.prod_producto_dos"
//lstr_df.texto_campo [3,2] = "Producto Dos"
//lstr_df.texto_campo [3,3] = ""
//lstr_df.texto_campo [3,4] = "V"
//lstr_df.texto_campo [4,1] = "inmprodu.prod_descripcion_dos"
//lstr_df.texto_campo [4,2] = "Descripcion Dos"
//lstr_df.texto_campo [4,3] = ""
//lstr_df.texto_campo [4,4] = "V"	

lstr_df.tabla 		  = " inmprodu "
lstr_df.tabla_where = " WHERE ( ( inmprodu.prod_g_financiero = "+ string(str.g_financiero)+" ) AND  " +&
							 "( inmprodu.prod_empresa = "+string(str.empresa)+" ) AND " +& 
							 "( inmprodu.prod_status = 1 ) AND " +& 
							 "( substring(inmprodu.prod_owner,1,1 ) = '1' ) )  " 
			                 

OpenWithParm(w_dg_a_custom_find,lstr_df)
ls_syntax = Message.StringParm

ls_codigo = String(Right(ls_syntax,Len(ls_syntax) - Pos(ls_syntax,"=")))
//messagebox('',ls_codigo)
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

on w_consulta_productos.create
int iCurrent
call super::create
this.dw_productos=create dw_productos
this.sle_producto=create sle_producto
this.cb_1=create cb_1
this.dw_3=create dw_3
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_productos
this.Control[iCurrent+2]=this.sle_producto
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.dw_4
end on

on w_consulta_productos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_productos)
destroy(this.sle_producto)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.dw_4)
end on

event open;//override
integer li_pos
string ls_mid

THIS.SetToolbar(1, true, alignattop!)
THIS.SetToolbarPos(1, 1, 50, false)

dw = dw_1
this.SetRedraw(False)
//This.Hide()
st_nom_ventana.text = this.classname()
str_fa_formato lstr_datawin
lstr_datawin = message.powerobjectparm

dw_1.dataobject = lstr_datawin.datawindow

st_nom_ventana.y = long(trim(mid(lstr_datawin.tipo_formato,pos(lstr_datawin.tipo_formato,"Sy=")+3,4)))

//messagebox('',long(mid(lstr_datawin.tipo_formato,pos(lstr_datawin.tipo_formato,"Wd=")+3,4)))
//Para cuando solo requiere del dw1

il_swc = 0

//this.y=1
This.Icon = str.icono

this.postevent("ue_post_open")

this.y = 0
this.x = 805
end event

event ue_post_open;//Override
string ls_codigo, ls_costos, ls_bodega, ls_ubica
datawindowChild ldwc_producto
//Para ocultar las opciones de consultas, cuando es Elbros
if pos(gf_dg_nombre_empresa(),'ELBROS') > 0 then gf_fa_cambiar_titulos(this.menuid)


//this.setredraw(false)
//this.y = 10
dw_1.SetTransObject(sqlca)
dw_3.SetTransObject(sqlca)
dw_4.SetTransObject(sqlca)

  SELECT crmparam.mpar_bodega+crmparam.mpar_ubicacion  
    INTO :is_bodega_ubica  
    FROM crmparam  
   WHERE ( crmparam.mpar_g_financiero = :str.g_financiero ) AND  
         ( crmparam.mpar_empresa = :str.empresa )   ;
	if sqlca.sqlcode = -1 then
		mensaje('Aviso','Error al Seleccionar la Bodega y Ubicación en Compras',sqlca.sqlerrtext)
	end if

if isnull(is_bodega_ubica) then is_bodega_ubica = ' '

dw_1.Getchild('prod_producto',ldwc_producto)
ldwc_producto.Settransobject(sqlca)
if ldwc_producto.retrieve(str.g_financiero, str.empresa) = 0 then
	ldwc_producto.insertrow(1)
end if

dw_productos.settransobject(sqlca)
if dw_productos.retrieve(str.g_financiero, str.empresa) > 0 then
		
	ls_codigo = dw_productos.getitemstring(1,"producto")
	if dw_1.Retrieve(str.g_financiero,str.empresa,ls_codigo ) > 0 then
		ls_costos = gf_clave_costos(dw_1.getitemnumber(1,"prod_costo_cif"))
		if isnull(ls_costos) then
			mensaje("Atención",'Sr. Usuario, debe definir la clave para los costos en Inventario / Procesos / Clave de Costos y Precios','')
			ls_costos = ' '
		end if
		dw_1.object.costos.expression = "'"+ls_costos+"'"
	//	dw_1.modify("costos.expression = '"+ls_costos+"'")
		if dw_1.dataobject = 'dw_co_fa_consulta_existencias_compras' then
			wf_recupera_confirmacion_transito(ls_codigo)
		elseif dw_1.dataobject = 'dw_co_fa_consulta_existencias_venta' then
			if pos(gf_dg_nombre_empresa(),'TEMPO') > 0 then
				dw_1.object.prod_contrato_regalias.visible = true
			end if			
		 //si es la ventana de ventas y es cosmotex, que se vea el precio en
		 //el dw_1, que se oculte el dw_2 y que no se vea el costo ni su titulo y
		 //que la ventana sea mas pequeña
			if pos(lower(gf_dg_nombre_empresa()), 'cosmotex') > 0 then
				dw_1.object.costos.visible = false
				dw_1.object.t_costo.visible = false				
				this.height = this.height - 400
				dw_1.object.r_precio.visible = true
				dw_1.object.t_precio.visible = true				
				dw_1.object.prod_precio_mayor.visible = true
				dw_1.object.agru_descripcion_grupo.visible = true				
				dw_1.object.inmprodu_prod_observacion.visible = true												
				dw_1.object.t_grupo.visible = true								
			end if
		end if	
	end if
else
	messagebox("Atencion","No hay productos para consultar...Verifique !!!")
	dw_productos.insertrow(1)
	dw_1.InsertRow(0)
end if
//sle_producto.setfocus()
dw_1.setfocus()

if	w_fa_fondo.str_para.empaque_decimales = 1 then	
	dw_1.object.inmprodu_prod_empaque.edit.format='###0.##'
	dw_1.object.inmprodu_prod_empaque.format='###0.##'	
end if

m_fa_padre.m_edicin.m_busqueda.visible = true
m_fa_padre.m_edicin.m_busqueda.enabled = true
m_fa_padre.m_edicin.m_busqueda.toolbaritemvisible = true
this.setredraw(true)
//This.TriggerEvent('ue_buscar')
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
dw.SetRedraw(False)
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

event resize;//dw_1.Resize(newwidth - 30, newheight - 30)
//gb_1.Width = newwidth - 75
//gb_1.Height = newheight - 120
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

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_consulta_productos
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_consulta_productos
boolean visible = false
integer x = 46
integer y = 1152
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_consulta_productos
event ue_down pbm_dwnkey
event ue_enter pbm_dwnprocessenter
integer x = 27
integer y = 0
integer width = 3122
integer height = 1264
integer taborder = 0
string dataobject = "dw_co_fa_consulta_existencias_venta"
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
elseif keydown(KeyF9!) then 
	this.setredraw(false)
	if this.dataobject = "dw_co_fa_consulta_existencias_venta" then
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
			if pos(gf_dg_nombre_empresa(),'ELBROS') > 0 then
				this.modify("inmprodu_prod_foto_dir.y ='896'")	
				this.modify("inmprodu_prod_foto_dir.x ='1504'")
				this.modify("inmprodu_prod_foto_dir.height ='800'")		
				this.modify("inmprodu_prod_foto_dir.width ='1088'")			
			else
				this.modify("inmprodu_prod_foto_dir.y ='364'")	
				this.modify("inmprodu_prod_foto_dir.x ='1989'")
				this.modify("inmprodu_prod_foto_dir.height ='1244'")		
				this.modify("inmprodu_prod_foto_dir.width ='1339'")			
			end if
		end if
	end if
	this.setredraw(true)	
end if
end event

event dw_1::ue_enter;//return 2
end event

event dw_1::clicked;//Script que Permite Ordenar Ascendentemente, o Descendente en caso que se dé click nuevamente
//en la misma columna.


end event

event dw_1::ue_microayuda;//override
end event

event dw_1::constructor;//Override
end event

event dw_1::itemchanged;call super::itemchanged;//modificación
string  ls_codigo, ls_descrip, ls_sort, ls_costos, ls_expresion
long    ll_row

this.accepttext()

choose case this.getcolumnname()
	case "prod_producto"
		ls_codigo = upper(data) //dw_productos.getitemstring(dw_productos.getrow(),"producto")
		ls_sort = dw_productos.Describe("DataWindow.Table.Sort") 
		if ls_sort <> "producto A" then			
			dw_productos.setsort("producto A")	
			dw_productos.sort()
			dw_1.object.color_orden.expression = '0'		
		end if

		ll_row = dw_productos.find('producto = "'+ls_codigo+'"',1,dw_productos.rowcount())
		
		if ll_row > 0 then
			dw_productos.scrolltorow(ll_row)
			if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
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
			return 2
		else
			ll_row = dw_productos.find('producto like "'+ls_codigo+'%"',1,dw_productos.rowcount())			
			if ll_row > 0 then
				dw_productos.scrolltorow(ll_row)
				ls_codigo = dw_productos.getitemstring(ll_row,'producto')				
				if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
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
				if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
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
				dw_1.setcolumn(2)				
				return 2
			else
				ll_row = dw_productos.find('descripcion like "'+ls_descrip+'%"',1,dw_productos.rowcount())			
				if ll_row > 0 then
					dw_productos.scrolltorow(ll_row)
					ls_codigo = dw_productos.getitemstring(ll_row,'producto')
					if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
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

type gb_1 from w_fa_padre_reportes`gb_1 within w_consulta_productos
boolean visible = false
integer taborder = 20
end type

type dw_productos from datawindow within w_consulta_productos
boolean visible = false
integer x = 1454
integer y = 336
integer width = 1179
integer height = 460
integer taborder = 50
boolean bringtotop = true
string dataobject = "fa_dw_productos_datastore"
borderstyle borderstyle = stylelowered!
end type

type sle_producto from singlelineedit within w_consulta_productos
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

type cb_1 from commandbutton within w_consulta_productos
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

type dw_3 from datawindow within w_consulta_productos
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

type dw_4 from datawindow within w_consulta_productos
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

