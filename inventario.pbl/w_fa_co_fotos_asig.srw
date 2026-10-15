//objectcomments Consulta de Existencias
forward
global type w_fa_co_fotos_asig from w_fa_padre_reportes
end type
type dw_productos from datawindow within w_fa_co_fotos_asig
end type
type sle_producto from singlelineedit within w_fa_co_fotos_asig
end type
type cb_1 from commandbutton within w_fa_co_fotos_asig
end type
type dw_2 from datawindow within w_fa_co_fotos_asig
end type
type lb_1 from listbox within w_fa_co_fotos_asig
end type
type dw_3 from datawindow within w_fa_co_fotos_asig
end type
type cb_2 from commandbutton within w_fa_co_fotos_asig
end type
type dw_4 from datawindow within w_fa_co_fotos_asig
end type
type lb_2 from listbox within w_fa_co_fotos_asig
end type
type dw_5 from datawindow within w_fa_co_fotos_asig
end type
type gb_2 from groupbox within w_fa_co_fotos_asig
end type
end forward

global type w_fa_co_fotos_asig from w_fa_padre_reportes
integer x = 0
integer y = 0
integer width = 6103
integer height = 2176
string title = "Asignacion de Fotos a los Productos"
string menuname = ""
boolean controlmenu = false
long backcolor = 12639424
event ue_busqueda ( )
dw_productos dw_productos
sle_producto sle_producto
cb_1 cb_1
dw_2 dw_2
lb_1 lb_1
dw_3 dw_3
cb_2 cb_2
dw_4 dw_4
lb_2 lb_2
dw_5 dw_5
gb_2 gb_2
end type
global w_fa_co_fotos_asig w_fa_co_fotos_asig

type variables
long il_filas, il_swc
STRING is_foto, is_foto_catalogo
datawindowchild idwc_nivel1, idwc_nivel2, idwc_nivel3, idwc_nivel4, idwc_nivel5
end variables

forward prototypes
public subroutine wf_actu ()
end prototypes

event ue_busqueda;Long	 				ll_num_prove, ll_row
String				ls_syntax, ls_codigo, ls_descripcion
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
	
	if dw_1.Retrieve(str.g_financiero,str.empresa,ls_codigo) > 0 then
		//Para que se ubique en el datawindow de detalle de los productos
		ll_row = dw_productos.find("producto = '"+ls_codigo+"'",1,dw_productos.rowcount())
		if ll_row > 0 then
			dw_productos.scrolltorow(ll_row)
			dw_2.setitem(1,"foto",dw_1.getitemstring(dw_1.getrow(),"inmprodu_prod_foto_dir"))			
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

public subroutine wf_actu ();sqlca.autocommit = true
string ls_foto_d, ls_producto, ls_error, ls_foto_catalogo, ls_foto_editada
ls_foto_d = dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir')
ls_foto_catalogo = dw_1.getitemstring(dw_1.getrow(),'prod_foto_catalogo')
ls_foto_editada = dw_1.getitemstring(dw_1.getrow(),'prod_foto_editada')
ls_producto = dw_1.getitemstring(dw_1.getrow(),'prod_producto')

update inmprodu set prod_foto_dir = :ls_foto_d, prod_foto_catalogo = :ls_foto_catalogo , prod_foto_editada = :ls_foto_editada
where :str.g_financiero = prod_g_financiero and
	      :str.empresa = prod_empresa and :ls_producto = prod_producto ;
if sqlca.sqlcode = -1 then 
	ls_error = sqlca.sqlerrtext
	rollback;
	mensaje('Aviso','Error al Salvar la Foto',ls_error)
	/**/
else 
	if dw_3.update() = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje('Aviso','Error al Salvar la Estructura ',ls_error)
	end if
	/**/
end if
end subroutine

on w_fa_co_fotos_asig.create
int iCurrent
call super::create
this.dw_productos=create dw_productos
this.sle_producto=create sle_producto
this.cb_1=create cb_1
this.dw_2=create dw_2
this.lb_1=create lb_1
this.dw_3=create dw_3
this.cb_2=create cb_2
this.dw_4=create dw_4
this.lb_2=create lb_2
this.dw_5=create dw_5
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_productos
this.Control[iCurrent+2]=this.sle_producto
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.lb_1
this.Control[iCurrent+6]=this.dw_3
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.dw_4
this.Control[iCurrent+9]=this.lb_2
this.Control[iCurrent+10]=this.dw_5
this.Control[iCurrent+11]=this.gb_2
end on

on w_fa_co_fotos_asig.destroy
call super::destroy
destroy(this.dw_productos)
destroy(this.sle_producto)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.lb_1)
destroy(this.dw_3)
destroy(this.cb_2)
destroy(this.dw_4)
destroy(this.lb_2)
destroy(this.dw_5)
destroy(this.gb_2)
end on

event open;sqlca.autocommit = true
integer li_pos
string ls_mid
THIS.SetToolbar(1, true, alignattop!)
THIS.SetToolbarPos(1, 1, 50, false)

dw = dw_1
//This.SetRedraw(False)
This.Hide()
st_nom_ventana.text = this.classname()
str_fa_formato lstr_datawin
lstr_datawin = message.powerobjectparm
dw_3.settransobject(sqlca)
dw_3.getchild('prod_nivel1',idwc_nivel1)
dw_3.getchild('prod_nivel2',idwc_nivel2)
dw_3.getchild('prod_nivel3',idwc_nivel3)
dw_3.getchild('prod_nivel4',idwc_nivel4)
dw_3.getchild('prod_nivel5',idwc_nivel5)
idwc_nivel1.settransobject(sqlca)
idwc_nivel2.settransobject(sqlca)
idwc_nivel3.settransobject(sqlca)
idwc_nivel4.settransobject(sqlca)
idwc_nivel5.settransobject(sqlca)
idwc_nivel1.retrieve(str.g_financiero, str.empresa)
idwc_nivel2.retrieve(str.g_financiero, str.empresa)
idwc_nivel3.retrieve(str.g_financiero, str.empresa)
idwc_nivel4.retrieve(str.g_financiero, str.empresa)
idwc_nivel5.retrieve(str.g_financiero, str.empresa)
dw_3.insertrow(1)

il_swc = 0

//this.y=1
This.Icon = str.icono
this.postevent("ue_post_open")
w_hs_frame.Post Event ue_evaluar_panel_acciones()
end event

event ue_post_open;//Override
string ls_codigo, ls_path

//Para ocultar las opciones de consultas, cuando es Elbros

dw_2.SetTransObject(sqlca)
dw_2.insertrow(1)
dw_1.SetTransObject(sqlca)
dw_4.insertrow(1)
dw_5.insertrow(1)
dw_productos.settransobject(sqlca)
if dw_productos.retrieve(str.g_financiero, str.empresa) > 0 then
	ls_codigo = dw_productos.getitemstring(1,"producto")
	dw_1.Retrieve(str.g_financiero,str.empresa,ls_codigo)
	dw_2.setitem(1,"foto",dw_1.getitemstring(1,"inmprodu_prod_foto_dir"))
	dw_4.setitem(1,"foto",dw_1.getitemstring(1,"prod_foto_catalogo"))
else
	messagebox("Atencion","No hay productos para consultar...Verifique")
	dw_1.InsertRow(0)
end if
//sle_producto.setfocus()

dw_1.setfocus()

//m_fa_padre.m_edicin.m_busqueda.visible = true
//m_fa_padre.m_edicin.m_busqueda.enabled = true
//m_fa_padre.m_edicin.m_busqueda.toolbaritemvisible = true


  SELECT inaparam.para_foto_dir  ,  inaparam.para_foto_dir_catalogo  
    INTO :is_foto  , :is_foto_catalogo
    FROM inaparam  
   WHERE ( inaparam.para_g_financiero = :str.g_financiero ) AND  
         ( inaparam.para_empresa = :str.empresa )   ;
	if sqlca.sqlcode = -1 then
		mensaje('Aviso','Error al Seleccionar la Ruta de las Fotos',sqlca.sqlerrtext)
	end if
if  is_foto = '' or isnull(is_foto) then 
	 is_foto = str.path
end if
ls_path = is_foto+'\*.jpg'	//Se hace con la finalidad de que al buscar los productos, 
									//se ubique en la ruta seleccionada en parametros, ruta para las fotos
lb_1.DirList(ls_path, 2)   //2 es archivos ocultos, para que no encuentre muchos
	
if  is_foto_catalogo = '' or isnull(is_foto_catalogo) then 
	 is_foto_catalogo = str.path
end if
ls_path = is_foto_catalogo+'\*.jpg'	//Se hace con la finalidad de que al buscar los productos, 
									//se ubique en la ruta seleccionada en parametros, ruta para las fotos
lb_2.DirList(ls_path, 2)   //2 es archivos ocultos, para que no encuentre muchos
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

event resize;//st_nom_ventana.y = newheight - (st_nom_ventana.height + 10)
//dw_1.Resize(newwidth - 30, newheight - 30)
//gb_1.Width = newwidth - 75
//gb_1.Height = newheight - 120
end event

event timer;//String ls_cadena, ls_ultimo
//Integer li_largo
//
//ls_cadena = st_2.Text
//
//If Not Isnull(ls_cadena) Then
//	li_largo  = Len(ls_cadena)
//	ls_ultimo = Right(ls_cadena, li_largo -1)
//	ls_cadena = ls_ultimo + Left(ls_cadena, 1)
//	st_2.Text = ls_cadena
//End If
end event

event ue_siguiente_reg;//override
long ll_row
string ls_codigo, ls_sort
	ll_row = dw_productos.getrow()
	if ll_row < dw_productos.rowcount() then
		dw_productos.scrolltorow(ll_row + 1)
		ls_codigo = dw_productos.getitemstring(ll_row + 1,'producto')
		dw_3.retrieve(str.g_financiero, str.empresa, ls_codigo)
		if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
			messagebox("Atencion","No se encontro el producto "+ ls_codigo)
		else
			dw_2.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir'))
			dw_4.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'prod_foto_catalogo'))			
			dw_5.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'prod_foto_editada'))
		end if
		if dw_1.object.color_orden.expression = '1' then
			dw_1.setcolumn(2)
		end if
	end if		
end event

event ue_reg_anterior;//override
long ll_row
string ls_codigo, ls_sort
	ll_row = dw_productos.getrow()
	if ll_row > 1 then
		dw_productos.scrolltorow(ll_row - 1)
		ls_codigo = dw_productos.getitemstring(ll_row - 1,'producto')
		dw_3.retrieve(str.g_financiero, str.empresa, ls_codigo)
		if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
			messagebox("Atencion","No se encontro el producto "+ ls_codigo)
		else
			dw_2.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir'))				
			dw_4.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'prod_foto_catalogo'))	
			dw_5.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'prod_foto_editada'))
		end if
		if dw_1.object.color_orden.expression = '1' then
			dw_1.setcolumn(2)
		end if		
	end if	

end event

event ue_ultimo_reg;//Override
long ll_row
string ls_codigo, ls_sort
	ll_row = dw_productos.rowcount()
	if ll_row > 1 then
		dw_productos.scrolltorow(ll_row)
		ls_codigo = dw_productos.getitemstring(ll_row,'producto')
		dw_3.retrieve(str.g_financiero, str.empresa, ls_codigo)
		if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
			messagebox("Atencion","No se encontro el producto "+ ls_codigo)
		else
			dw_2.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir'))				
			dw_4.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'prod_foto_catalogo'))			
			dw_5.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'prod_foto_editada'))
		end if
		if dw_1.object.color_orden.expression = '1' then
			dw_1.setcolumn(2)
		end if		
	end if	

end event

event ue_primer_reg;//Override
long ll_row
string ls_codigo, ls_sort
	dw_productos.scrolltorow(1)
	ls_codigo = dw_productos.getitemstring(1,'producto')
	dw_3.retrieve(str.g_financiero, str.empresa, ls_codigo)
	if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
		messagebox("Atencion","No se encontro el producto "+ ls_codigo)		
	else
		dw_2.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir'))
		dw_4.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'prod_foto_catalogo'))					
		dw_5.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'prod_foto_editada'))		
	end if
	
		if dw_1.object.color_orden.expression = '1' then
			dw_1.setcolumn(2)
		end if



end event

event activate;call super::activate;//if not isvalid(m_fa_rep) then
//	this.changemenu(m_fa_rep)
//end if
end event

event close;call super::close;setredraw(false)
w_hs_frame.Post Event ue_evaluar_panel_acciones()
end event

event closequery;call super::closequery;setredraw(false)
end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_co_fotos_asig
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_co_fotos_asig
boolean visible = false
integer x = 41
integer y = 1868
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_co_fotos_asig
event ue_down pbm_dwnkey
event ue_enter pbm_dwnprocessenter
integer x = 64
integer y = 48
integer width = 2921
integer height = 356
integer taborder = 0
string dataobject = "dw_co_fa_foto_prod"
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
end if

end event

event dw_1::ue_enter;//return 2
dw_3.setfocus()
dw_3.setcolumn('prod_nivel1')
end event

event dw_1::clicked;//Script que Permite Ordenar Ascendentemente, o Descendente en caso que se dé click nuevamente
//en la misma columna.

if dwo.name = 'p_1' then
	parent.triggerevent('ue_busqueda')
end if
end event

event dw_1::ue_microayuda;//override
end event

event dw_1::constructor;//Override
end event

event dw_1::itemchanged;call super::itemchanged;//modificación
string ls_codigo, ls_descrip, ls_sort, ls_codigo_dir
long   ll_row

this.accepttext()
idwc_nivel1.retrieve(str.g_financiero, str.empresa)
idwc_nivel2.retrieve(str.g_financiero, str.empresa)
idwc_nivel3.retrieve(str.g_financiero, str.empresa)
idwc_nivel4.retrieve(str.g_financiero, str.empresa)
idwc_nivel5.retrieve(str.g_financiero, str.empresa)
choose case this.getcolumnname()
	case "prod_producto"
		ls_codigo = data //dw_productos.getitemstring(dw_productos.getrow(),"producto")
		ls_sort = dw_productos.Describe("DataWindow.Table.Sort") 
		if ls_sort <> "producto A" then			
			dw_productos.setsort("producto A")	
			dw_productos.sort()
			dw_1.object.color_orden.expression = '0'		
		end if

		ll_row = dw_productos.find('producto = "'+ls_codigo+'"',1,dw_productos.rowcount())
		
		if ll_row > 0 then
			dw_productos.scrolltorow(ll_row)
			dw_3.retrieve(str.g_financiero, str.empresa, ls_codigo)
			if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
				messagebox("Atencion","No se encontro el producto "+ ls_codigo)
			else
				ls_codigo_dir = ls_codigo
				if dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir') = ''  or isnull(dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir')) then
					dw_1.setitem(dw_1.getrow(),'inmprodu_prod_foto_dir',is_foto + '\' + ls_codigo_dir + '.jpg' )				
					wf_actu()
				end if
				if dw_1.getitemstring(dw_1.getrow(),'prod_foto_catalogo') = ''  or isnull(dw_1.getitemstring(dw_1.getrow(),'prod_foto_catalogo')) then
					dw_1.setitem(dw_1.getrow(),'prod_foto_catalogo',is_foto_catalogo + '\' + ls_codigo_dir + '.jpg')				
					wf_actu()
				end if									
				dw_1.accepttext()				
				dw_2.accepttext()								
				dw_2.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir'))				
				dw_4.accepttext()								
				dw_4.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'prod_foto_catalogo'))			
				dw_5.accepttext()								
				dw_5.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'prod_foto_editada'))		
			end if		
			return 2
		else
			ll_row = dw_productos.find('producto like "'+ls_codigo+'%"',1,dw_productos.rowcount())			
			if ll_row > 0 then
				dw_productos.scrolltorow(ll_row)
				dw_3.retrieve(str.g_financiero, str.empresa, ls_codigo)
				ls_codigo = dw_productos.getitemstring(ll_row,'producto')				
				if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
					messagebox("Atencion","No se encontro el producto "+ ls_codigo)
				else
					ls_codigo_dir = ls_codigo
					if dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir') = ''  or isnull(dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir')) then
						dw_1.setitem(dw_1.getrow(),'inmprodu_prod_foto_dir',is_foto + '\' + ls_codigo_dir + '.jpg')				
						wf_actu()
					end if
					if dw_1.getitemstring(dw_1.getrow(),'prod_foto_catalogo') = ''  or isnull(dw_1.getitemstring(dw_1.getrow(),'prod_foto_catalogo')) then
						dw_1.setitem(dw_1.getrow(),'prod_foto_catalogo',is_foto_catalogo + '\' + ls_codigo_dir + '.jpg')				
						wf_actu()
					end if					
					dw_1.accepttext()									
					dw_2.accepttext()
					dw_2.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir'))
					dw_4.accepttext()								
					dw_4.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'prod_foto_catalogo'))	
					dw_5.accepttext()								
					dw_5.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'prod_foto_editada'))	
				end if				
				return 2
			else	
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
				dw_3.retrieve(str.g_financiero, str.empresa, ls_codigo)
				if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
					messagebox("Atencion","No se encontro el producto "+ ls_codigo)
				else
					dw_2.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir'))						
					dw_2.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'prod_foto_catalogo'))								
				end if
				dw_1.setcolumn(2)				
				return 2
			else
				ll_row = dw_productos.find('descripcion like "'+ls_descrip+'%"',1,dw_productos.rowcount())			
				if ll_row > 0 then
					dw_productos.scrolltorow(ll_row)
					ls_codigo = dw_productos.getitemstring(ll_row,'producto')
					dw_3.retrieve(str.g_financiero, str.empresa, ls_codigo)
					if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
						messagebox("Atencion","No se encontro el producto "+ ls_codigo)
					end if				
					dw_2.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir'))
					dw_4.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'prod_foto_catalogo'))		
					dw_5.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'prod_foto_editada'))	
					dw_1.setcolumn(2)					
					return 2
				else	
					dw_1.setcolumn(2)					
					return 2
				end if
			end if				
			
		case 'inmprodu_prod_foto_dir','prod_foto_catalogo', 'prod_foto_editada'
				wf_actu()
end choose
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;//RETURN 2


end event

event dw_1::doubleclicked;call super::doubleclicked;/* Alexis Receda 24/nov/2000 (Habilita Buscar Foto Solo Cuando Se le da DClick a la Dir Foto)*/

string ls_objeto
integer li_pos 
integer li_row, li_rc
string ls_path, ls_file

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if (ls_objeto = 't_2' or ls_objeto = 'inmprodu_prod_foto_dir') then

		li_row = dw_1.getrow()
		li_rc = getfileopenname("Selección de las Fotos",&
		+ ls_path, ls_file, "jpg",&
		+ "Archivos de Fotos (*.jpg), *.jpg,"&
		+ "Archivos de Fotos (*.jpeg), *.jpeg,"&
		+ "Archivos de Fotos (*.png), *.png,"&
		+ "Archivos de Fotos (*.gif), *.gif,"&
		+ "Archivos de Fotos (*.bmp), *.bmp")
		if li_rc = 0 then
			return
		end if
		dw_1.setitem(1, 'inmprodu_prod_foto_dir',ls_path)
		dw_2.setitem(1, 'foto',ls_path)
		wf_actu()
		
		dw_1.setfocus()
		
	elseif (ls_objeto = 't_3' or ls_objeto = 'prod_foto_catalogo') then
		li_row = dw_1.getrow()
		li_rc = getfileopenname("Selección de las Fotos",&
		+ ls_path, ls_file, "jpg",&
		+ "Archivos de Fotos (*.jpg), *.jpg,"&
		+ "Archivos de Fotos (*.jpeg), *.jpeg,"&
		+ "Archivos de Fotos (*.png), *.png,"&
		+ "Archivos de Fotos (*.gif), *.gif,"&
		+ "Archivos de Fotos (*.bmp), *.bmp")
		if li_rc = 0 then
			return
		end if
		dw_1.setitem(1, 'prod_foto_catalogo',ls_path)
		dw_4.setitem(1, 'foto',ls_path)
		wf_actu()
		
		dw_1.setfocus()		
	end if
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_co_fotos_asig
boolean visible = false
integer x = 14
integer y = 32
integer width = 2962
integer height = 288
integer taborder = 20
end type

type dw_productos from datawindow within w_fa_co_fotos_asig
boolean visible = false
integer x = 1454
integer y = 336
integer width = 1385
integer height = 868
integer taborder = 50
boolean bringtotop = true
string dataobject = "fa_dw_productos_datastore"
borderstyle borderstyle = stylelowered!
end type

type sle_producto from singlelineedit within w_fa_co_fotos_asig
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
			if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
				messagebox("Atencion","No se encontro el producto "+ ls_codigo)
			end if
			return 2
		else
			ll_row = dw_productos.find('producto like "'+ls_codigo+'%"',1,dw_productos.rowcount())		
			if ll_row > 0 then
				dw_productos.scrolltorow(ll_row)
				ls_codigo = dw_productos.getitemstring(ll_row,'producto')				
				if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
					messagebox("Atencion","No se encontro el producto "+ ls_codigo)
				end if				
				return 2
			else	
				return 2
			end if
		end if
end event

type cb_1 from commandbutton within w_fa_co_fotos_asig
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

type dw_2 from datawindow within w_fa_co_fotos_asig
integer x = 1687
integer y = 444
integer width = 1248
integer height = 1128
integer taborder = 60
boolean bringtotop = true
boolean titlebar = true
string title = "Despligue de foto"
string dataobject = "dw_fa_asig_foto_des"
boolean controlmenu = true
boolean border = false
string icon = "AppIcon!"
boolean livescroll = true
end type

event doubleclicked;call super::doubleclicked;integer li_row, li_rc
string ls_path, ls_file

		li_row = dw_1.getrow()
		li_rc = getfileopenname("Selección de las Fotos",&
		+ ls_path, ls_file, "gif",&
		+ "Archivos de Fotos (*.jpg), *.jpg,"&
		+ "Archivos de Fotos (*.gif), *.gif,"&
		+ "Archivos de Fotos (*.bmp), *.bmp")
		
		if li_rc = 0 then
			return
		end if
		dw_1.setitem(1, 'inmprodu_prod_foto_dir',ls_path)
		dw_2.setitem(1, 'foto',ls_path)
		wf_actu()
		
		dw_1.setfocus()
end event

type lb_1 from listbox within w_fa_co_fotos_asig
boolean visible = false
integer x = 78
integer y = 432
integer width = 480
integer height = 400
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_fa_co_fotos_asig
event ue_enter pbm_dwnprocessenter
integer x = 69
integer y = 448
integer width = 1577
integer height = 816
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "dw_estructura_producto"
boolean border = false
boolean livescroll = true
end type

event ue_enter;//
if this.getcolumnname() = 'prod_nivel5' then
	dw_1.setfocus()
	dw_1.setcolumn('prod_producto')
else
	Send(Handle(This), 256, 9, Long(0,0))
end if
end event

event itemchanged;this.accepttext()
if this.update() = -1 then
	gf_mensaje('','Error al Guardar '+sqlca.sqlerrtext,1,1,'E')
end if

end event

type cb_2 from commandbutton within w_fa_co_fotos_asig
integer x = 3040
integer y = 104
integer width = 503
integer height = 120
integer taborder = 50
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "VER TODO"
end type

event clicked;opensheet(w_estructura_de_catalogo, str.frame,2 , layered!)
end event

type dw_4 from datawindow within w_fa_co_fotos_asig
integer x = 2953
integer y = 448
integer width = 1248
integer height = 1124
integer taborder = 70
boolean bringtotop = true
boolean titlebar = true
string title = "Foto Catalogo"
string dataobject = "dw_fa_asig_foto_des"
boolean controlmenu = true
boolean border = false
string icon = "AppIcon!"
boolean livescroll = true
end type

event doubleclicked;call super::doubleclicked;integer li_row, li_rc
string ls_path, ls_file

		li_row = dw_1.getrow()
		li_rc = getfileopenname("Selección de las Fotos",&
		+ ls_path, ls_file, "gif",&
		+ "Archivos de Fotos (*.jpg), *.jpg,"&
		+ "Archivos de Fotos (*.gif), *.gif,"&
		+ "Archivos de Fotos (*.bmp), *.bmp")
		
		if li_rc = 0 then
			return
		end if
		dw_1.setitem(1, 'prod_foto_catalogo',ls_path)
		dw_4.setitem(1, 'foto',ls_path)
		wf_actu()
		
		dw_1.setfocus()
end event

type lb_2 from listbox within w_fa_co_fotos_asig
boolean visible = false
integer x = 78
integer y = 852
integer width = 480
integer height = 400
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type dw_5 from datawindow within w_fa_co_fotos_asig
integer x = 4206
integer y = 448
integer width = 1239
integer height = 1124
integer taborder = 80
boolean bringtotop = true
boolean titlebar = true
string title = "Foto Editada"
string dataobject = "dw_fa_asig_foto_des"
boolean controlmenu = true
boolean border = false
string icon = "AppIcon!"
boolean livescroll = true
end type

event doubleclicked;call super::doubleclicked;integer li_row, li_rc
string ls_path, ls_file

		li_row = dw_1.getrow()
		li_rc = getfileopenname("Selección de las Fotos",&
		+ ls_path, ls_file, "gif",&
		+ "Archivos de Fotos (*.jpg), *.jpg,"&
		+ "Archivos de Fotos (*.gif), *.gif,"&
		+ "Archivos de Fotos (*.bmp), *.bmp")
		
		if li_rc = 0 then
			return
		end if
		dw_1.setitem(1, 'prod_foto_editada',ls_path)
		dw_5.setitem(1, 'foto',ls_path)
		wf_actu()
		
		dw_1.setfocus()
end event

type gb_2 from groupbox within w_fa_co_fotos_asig
integer x = 23
integer width = 2990
integer height = 432
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
end type

