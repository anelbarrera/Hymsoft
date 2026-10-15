//objectcomments Consulta de Existencias
forward
global type w_estructura_de_catalogo from w_fa_padre_reportes
end type
type dw_productos from datawindow within w_estructura_de_catalogo
end type
type sle_producto from singlelineedit within w_estructura_de_catalogo
end type
type cb_1 from commandbutton within w_estructura_de_catalogo
end type
type dw_2 from datawindow within w_estructura_de_catalogo
end type
type lb_1 from listbox within w_estructura_de_catalogo
end type
type cbx_solo from checkbox within w_estructura_de_catalogo
end type
type cb_2 from commandbutton within w_estructura_de_catalogo
end type
type lb_2 from listbox within w_estructura_de_catalogo
end type
type cb_3 from commandbutton within w_estructura_de_catalogo
end type
type cb_4 from commandbutton within w_estructura_de_catalogo
end type
type cb_5 from commandbutton within w_estructura_de_catalogo
end type
type cb_6 from commandbutton within w_estructura_de_catalogo
end type
type cb_7 from commandbutton within w_estructura_de_catalogo
end type
end forward

global type w_estructura_de_catalogo from w_fa_padre_reportes
integer x = 5
integer y = 60
integer width = 7771
integer height = 2196
string title = "Estructura de los Catalogos"
long backcolor = 12639424
windowanimationstyle openanimation = centeranimation!
windowanimationstyle closeanimation = centeranimation!
event ue_busqueda ( )
dw_productos dw_productos
sle_producto sle_producto
cb_1 cb_1
dw_2 dw_2
lb_1 lb_1
cbx_solo cbx_solo
cb_2 cb_2
lb_2 lb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
cb_6 cb_6
cb_7 cb_7
end type
global w_estructura_de_catalogo w_estructura_de_catalogo

type variables
long il_filas, il_swc
STRING is_foto, is_foto_catalogo
boolean ib_entro
datawindowchild idwc_nivel1, idwc_nivel2, idwc_nivel3, idwc_nivel4, idwc_nivel5
end variables

forward prototypes
public subroutine wf_actu ()
end prototypes

event ue_busqueda();//Long	 				ll_num_prove, ll_row
//String				ls_syntax, ls_codigo, ls_descripcion
//Integer           li_len
//str_dg_dynamic_find	lstr_df
//
///***************************************************************************************
// *										                                  								*
// *  									Búsqueda Dinámica de Productos									*
// ***************************************************************************************/
//
//
//lstr_df.texto_campo [1,1] = "inmprodu.prod_producto"
//lstr_df.texto_campo [1,2] = "Producto"
//lstr_df.texto_campo [1,3] = "prod_producto"
//lstr_df.texto_campo [1,4] = "V"
//lstr_df.texto_campo [2,1] = "inmprodu.prod_descripcion"
//lstr_df.texto_campo [2,2] = "Descripción"
//lstr_df.texto_campo [2,3] = ""
//lstr_df.texto_campo [2,4] = "V"
////lstr_df.texto_campo [3,1] = "inmprodu.prod_producto_dos"
////lstr_df.texto_campo [3,2] = "Producto Dos"
////lstr_df.texto_campo [3,3] = ""
////lstr_df.texto_campo [3,4] = "V"
////lstr_df.texto_campo [4,1] = "inmprodu.prod_descripcion_dos"
////lstr_df.texto_campo [4,2] = "Descripcion Dos"
////lstr_df.texto_campo [4,3] = ""
////lstr_df.texto_campo [4,4] = "V"	
//
//lstr_df.tabla 		  = " inmprodu "
//lstr_df.tabla_where = " WHERE ( ( inmprodu.prod_g_financiero = "+ string(str.g_financiero)+" ) AND  " +&
//							 "( inmprodu.prod_empresa = "+string(str.empresa)+" ) AND " +& 
//							 "( inmprodu.prod_status = 1 ) AND " +& 
//							 "( substring(inmprodu.prod_owner,1,1 ) = '1' ) )  " 
//			                 
//
//OpenWithParm(w_dg_a_custom_find,lstr_df)
//ls_syntax = Message.StringParm
//
//ls_codigo = String(Right(ls_syntax,Len(ls_syntax) - Pos(ls_syntax,"=")))
////messagebox('',ls_codigo)
//gf_replace_cadena(ls_codigo,"'"," ")
//ls_codigo = Trim(ls_codigo)
////messagebox('',ls_codigo)
//if not IsNull(ls_codigo) and (ls_codigo <> "") Then 
//	if il_swc = 0 Then
//		This.Show()
//		This.visible = true
//		//This.SetRedraw(True)
//		il_swc = 1
//	End If
//	
//	if dw_1.Retrieve(str.g_financiero,str.empresa,ls_codigo) > 0 then
//		//Para que se ubique en el datawindow de detalle de los productos
//		ll_row = dw_productos.find("producto = '"+ls_codigo+"'",1,dw_productos.rowcount())
//		if ll_row > 0 then
//			dw_productos.scrolltorow(ll_row)
//			dw_2.setitem(1,"foto",dw_1.getitemstring(dw_1.getrow(),"inmprodu_prod_foto_dir"))			
//		end if
//		ls_descripcion = dw_1.GetItemString(dw_1.GetRow(),'prod_descripcion')
//		//st_2.Text = '-----' + ls_codigo + '-----'+ ls_descripcion + '-----'
//	end if
//Else
//	If il_swc = 0 Then
////		Close(this)
//	Else
//		Return
//	End If
//End If
//
end event

public subroutine wf_actu ();sqlca.autocommit = true
string ls_foto_d, ls_producto, ls_error
ls_foto_d = dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir')
ls_producto = dw_1.getitemstring(dw_1.getrow(),'prod_producto')

update inmprodu set prod_foto_dir = :ls_foto_d where :str.g_financiero = prod_g_financiero and
						  :str.empresa = prod_empresa and :ls_producto = prod_producto ;

if sqlca.sqlcode = -1 then 
	ls_error = sqlca.sqlerrtext
	rollback;
	mensaje('Aviso','Error al Salvar la Foto',ls_error)
	/**/
else 
	if dw_2.update() = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje('Aviso','Error al Salvar la Estructura ',ls_error)
	end if
	/**/
end if
end subroutine

on w_estructura_de_catalogo.create
int iCurrent
call super::create
this.dw_productos=create dw_productos
this.sle_producto=create sle_producto
this.cb_1=create cb_1
this.dw_2=create dw_2
this.lb_1=create lb_1
this.cbx_solo=create cbx_solo
this.cb_2=create cb_2
this.lb_2=create lb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_6=create cb_6
this.cb_7=create cb_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_productos
this.Control[iCurrent+2]=this.sle_producto
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.lb_1
this.Control[iCurrent+6]=this.cbx_solo
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.lb_2
this.Control[iCurrent+9]=this.cb_3
this.Control[iCurrent+10]=this.cb_4
this.Control[iCurrent+11]=this.cb_5
this.Control[iCurrent+12]=this.cb_6
this.Control[iCurrent+13]=this.cb_7
end on

on w_estructura_de_catalogo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_productos)
destroy(this.sle_producto)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.lb_1)
destroy(this.cbx_solo)
destroy(this.cb_2)
destroy(this.lb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.cb_7)
end on

event open;sqlca.autocommit = true
integer li_pos
long i
string ls_mid
THIS.SetToolbar(1, true, alignattop!)
THIS.SetToolbarPos(1, 1, 50, false)

dw = dw_1
//This.SetRedraw(False)
This.Hide()
st_nom_ventana.text = this.classname()
str_fa_formato lstr_datawin
lstr_datawin = message.powerobjectparm
dw_1.settransobject(sqlca)
dw_1.getchild('prod_nivel1',idwc_nivel1)
dw_1.getchild('prod_nivel2',idwc_nivel2)
dw_1.getchild('prod_nivel3',idwc_nivel3)
dw_1.getchild('prod_nivel4',idwc_nivel4)
dw_1.getchild('prod_nivel5',idwc_nivel5)
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
if dw_1.retrieve(str.g_financiero, str.empresa) > 0 then
//	for i = 1 to dw_1.rowcount()
//		yield()
//		str.frame.setmicrohelp('Procesando '+string(i)+' de '+string(dw_1.rowcount()))
//		dw_1.setitem(i,'prod_nivel2',dw_1.getitemstring(i,'marca'))
//	next
//	if dw_1.update() = -1 then
//		gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
//	end if
end if

il_swc = 0

//this.y=1
This.Icon = str.icono
this.postevent("ue_post_open")

end event

event ue_post_open;//Override
string ls_codigo, ls_path

//Para ocultar las opciones de consultas, cuando es Elbros

dw_2.SetTransObject(sqlca)
dw_2.insertrow(1)
dw_1.SetTransObject(sqlca)

dw_productos.settransobject(sqlca)
if dw_productos.retrieve(str.g_financiero, str.empresa) > 0 then
	ls_codigo = dw_productos.getitemstring(1,"producto")
	dw_1.Retrieve(str.g_financiero,str.empresa,ls_codigo)
//	dw_2.setitem(1,"foto",dw_1.getitemstring(1,"inmprodu_prod_foto_dir"))
else
	messagebox("Atencion","No hay productos para consultar...Verifique")
	dw_1.InsertRow(0)
end if
//sle_producto.setfocus()

dw_1.setfocus()

m_fa_padre.m_edicin.m_busqueda.visible = true
m_fa_padre.m_edicin.m_busqueda.enabled = true
m_fa_padre.m_edicin.m_busqueda.toolbaritemvisible = true


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
if  is_foto_catalogo = '' or isnull(is_foto_catalogo) then 
	 is_foto = str.path
end if

ls_path = is_foto+'\*.jpg'	//Se hace con la finalidad de que al buscar los productos, 
									//se ubique en la ruta seleccionada en parametros, ruta para las fotos
lb_1.DirList(ls_path, 2)   //2 es archivos ocultos, para que no encuentre muchos
	
ls_path = is_foto_catalogo+'\*.jpeg'	//Se hace con la finalidad de que al buscar los productos, 
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
OpenWithParm(w_dw_print_options, dw)
If Message.DoubleParm = -1 Then Return
dw.modify("")
dw.Modify("DataWindow.Zoom='60'")
dw.Print(True)
dw.Modify("DataWindow.Zoom='100'")
end event

event resize;//st_nom_ventana.y = newheight - (st_nom_ventana.height + 10)
dw_1.Resize(newwidth - 130, newheight - 300)
cbx_solo.y = newheight - 100
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

event ue_siguiente_reg;////override
//long ll_row
//string ls_codigo, ls_sort
//	ll_row = dw_productos.getrow()
//	if ll_row < dw_productos.rowcount() then
//		dw_productos.scrolltorow(ll_row + 1)
//		ls_codigo = dw_productos.getitemstring(ll_row + 1,'producto')
//		dw_3.retrieve(str.g_financiero, str.empresa, ls_codigo)
//		if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
//			messagebox("Atencion","No se encontro el producto "+ ls_codigo)
//		else
//			dw_2.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir'))
//		end if
//		if dw_1.object.color_orden.expression = '1' then
//			dw_1.setcolumn(2)
//		end if
//	end if		
end event

event ue_reg_anterior;////override
//long ll_row
//string ls_codigo, ls_sort
//	ll_row = dw_productos.getrow()
//	if ll_row > 1 then
//		dw_productos.scrolltorow(ll_row - 1)
//		ls_codigo = dw_productos.getitemstring(ll_row - 1,'producto')
//		dw_3.retrieve(str.g_financiero, str.empresa, ls_codigo)
//		if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
//			messagebox("Atencion","No se encontro el producto "+ ls_codigo)
//		else
//			dw_2.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir'))				
//		end if
//		if dw_1.object.color_orden.expression = '1' then
//			dw_1.setcolumn(2)
//		end if		
//	end if	
//
end event

event ue_ultimo_reg;////Override
//long ll_row
//string ls_codigo, ls_sort
//	ll_row = dw_productos.rowcount()
//	if ll_row > 1 then
//		dw_productos.scrolltorow(ll_row)
//		ls_codigo = dw_productos.getitemstring(ll_row,'producto')
//		dw_3.retrieve(str.g_financiero, str.empresa, ls_codigo)
//		if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
//			messagebox("Atencion","No se encontro el producto "+ ls_codigo)
//		else
//			dw_2.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir'))				
//		end if
//		if dw_1.object.color_orden.expression = '1' then
//			dw_1.setcolumn(2)
//		end if		
//	end if	
//
end event

event ue_primer_reg;////Override
//long ll_row
//string ls_codigo, ls_sort
//	dw_productos.scrolltorow(1)
//	ls_codigo = dw_productos.getitemstring(1,'producto')
//	dw_3.retrieve(str.g_financiero, str.empresa, ls_codigo)
//	if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
//		messagebox("Atencion","No se encontro el producto "+ ls_codigo)		
//	else
//		dw_2.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir'))
//	end if
//	
//		if dw_1.object.color_orden.expression = '1' then
//			dw_1.setcolumn(2)
//		end if
//
//
//
end event

event activate;call super::activate;if not isvalid(m_fa_rep) then
	this.changemenu(m_fa_rep)
end if
end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_estructura_de_catalogo
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_estructura_de_catalogo
boolean visible = false
integer x = 41
integer y = 1868
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_estructura_de_catalogo
event ue_down pbm_dwnkey
event ue_enter pbm_dwnprocessenter
integer y = 280
integer width = 7643
integer height = 1688
integer taborder = 0
string dataobject = "dw_estructura_catalogo"
boolean hscrollbar = true
boolean vscrollbar = true
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
//dw_3.setfocus()
//dw_3.setcolumn('prod_nivel1')
end event

event dw_1::clicked;//Script que Permite Ordenar Ascendentemente, o Descendente en caso que se dé click nuevamente
//en la misma columna.

//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto
integer li_pos 

this.Setredraw(false)

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if right(ls_objeto,2)='_t' then

	ls_objeto = left(ls_objeto,len(ls_objeto)-2)
	
	if ls_objeto = is_ultima_ or is_ultima_ = "" then	//Si es la misma columna 
																	// o si es la primera vez
		if is_orden_  = "" or is_orden_ = "D" then
			is_orden_ = 'A'		
			this.SetSort(ls_objeto+" A")	//Ordena Ascendente
			this.sort()		
		else
			is_orden_ = 'D'					
			this.SetSort(ls_objeto+" D")	//Ordena Descendente
			this.sort()				
		end if	
		is_ultima_ = ls_objeto		
	else				
			is_orden_ = 'A'
			this.SetSort(ls_objeto+" A")
			this.sort()
			is_ultima_ = ls_objeto
	end if

end if

this.Setredraw(true)

end event

event dw_1::ue_microayuda;//override
end event

event dw_1::constructor;//Override
end event

event dw_1::itemchanged;call super::itemchanged;////modificación
//string ls_codigo, ls_descrip, ls_sort, ls_codigo_dir
//long   ll_row
//
this.accepttext()

if dw_1.update() = -1 then	
	gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
	rollback;
	dw_1.retrieve(str.g_financiero, str.empresa)
end if

choose case this.getcolumnname()
	case "prod_nivel1", "prod_nivel2", "prod_nivel3", "prod_nivel4", "prod_nivel5"
		idwc_nivel1.retrieve(str.g_financiero, str.empresa)
		idwc_nivel2.retrieve(str.g_financiero, str.empresa)
		idwc_nivel3.retrieve(str.g_financiero, str.empresa)
		idwc_nivel4.retrieve(str.g_financiero, str.empresa)
		idwc_nivel5.retrieve(str.g_financiero, str.empresa)		

//		ls_codigo = data //dw_productos.getitemstring(dw_productos.getrow(),"producto")
//		ls_sort = dw_productos.Describe("DataWindow.Table.Sort") 
//		if ls_sort <> "producto A" then			
//			dw_productos.setsort("producto A")	
//			dw_productos.sort()
//			dw_1.object.color_orden.expression = '0'		
//		end if
//
//		ll_row = dw_productos.find('producto = "'+ls_codigo+'"',1,dw_productos.rowcount())
//		
//		if ll_row > 0 then
//			dw_productos.scrolltorow(ll_row)
//			dw_3.retrieve(str.g_financiero, str.empresa, ls_codigo)
//			if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
//				messagebox("Atencion","No se encontro el producto "+ ls_codigo)
//			else
//				ls_codigo_dir = ls_codigo
//				if dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir') = ''  or isnull(dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir')) then
//					dw_1.setitem(dw_1.getrow(),'inmprodu_prod_foto_dir',is_foto + '\' + ls_codigo_dir + '.jpg' )				
//					wf_actu()
//				end if
//				dw_1.accepttext()				
//				dw_2.accepttext()								
//				dw_2.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir'))				
//
//			end if		
//			return 2
//		else
//			ll_row = dw_productos.find('producto like "'+ls_codigo+'%"',1,dw_productos.rowcount())			
//			if ll_row > 0 then
//				dw_productos.scrolltorow(ll_row)
//				dw_3.retrieve(str.g_financiero, str.empresa, ls_codigo)
//				ls_codigo = dw_productos.getitemstring(ll_row,'producto')				
//				if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
//					messagebox("Atencion","No se encontro el producto "+ ls_codigo)
//				else
//					ls_codigo_dir = ls_codigo
//					if dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir') = ''  or isnull(dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir')) then
//						dw_1.setitem(dw_1.getrow(),'inmprodu_prod_foto_dir',is_foto + '\' + ls_codigo_dir + '.jpg')				
//						wf_actu()
//					end if
//					dw_1.accepttext()									
//					dw_2.accepttext()
//					dw_2.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir'))
//				end if				
//				return 2
//			else	
//				return 2
//			end if
//		end if							
//	case "prod_descripcion"
//		ls_descrip = data
//		ls_sort = dw_productos.Describe("DataWindow.Table.Sort") 
//		if ls_sort <> "descripcion A" then			
//			dw_productos.setsort("descripcion A")	
//			dw_productos.sort()
//			dw_1.object.color_orden.expression = '1'		
//		end if
//		
//			ll_row = dw_productos.find('descripcion = "'+ls_descrip+'"',1,dw_productos.rowcount())
//			if ll_row > 0 then
//				dw_productos.scrolltorow(ll_row)
//				ls_codigo = dw_productos.getitemstring(ll_row,"producto")
//				dw_3.retrieve(str.g_financiero, str.empresa, ls_codigo)
//				if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
//					messagebox("Atencion","No se encontro el producto "+ ls_codigo)
//				else
//					dw_2.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir'))						
//				end if
//				dw_1.setcolumn(2)				
//				return 2
//			else
//				ll_row = dw_productos.find('descripcion like "'+ls_descrip+'%"',1,dw_productos.rowcount())			
//				if ll_row > 0 then
//					dw_productos.scrolltorow(ll_row)
//					ls_codigo = dw_productos.getitemstring(ll_row,'producto')
//					dw_3.retrieve(str.g_financiero, str.empresa, ls_codigo)
//					if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
//						messagebox("Atencion","No se encontro el producto "+ ls_codigo)
//					else
//						dw_2.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir'))	
//					end if				
//					dw_2.setitem(1, 'foto',dw_1.getitemstring(dw_1.getrow(),'inmprodu_prod_foto_dir'))
//					dw_1.setcolumn(2)					
//					return 2
//				else	
//					dw_1.setcolumn(2)					
//					return 2
//				end if
//			end if				
//			
//		case 'inmprodu_prod_foto_dir'
//				wf_actu()
end choose
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;//RETURN 2


end event

event dw_1::doubleclicked;call super::doubleclicked;string ls_nivel1, ls_nivel2, ls_nivel3
long i
choose case dwo.name
	case 'prod_nivel2'
		ls_nivel2 = this.getitemstring(row,'prod_nivel2')
		if isnull(ls_nivel2) or ls_nivel2 = '' then return
		
		for i = row to this.rowcount()
			this.setitem(i, 'prod_nivel2', ls_nivel2)
		next
		
		this.accepttext()
		if dw_1.update() = -1 then	
			gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			dw_1.retrieve(str.g_financiero, str.empresa)
		end if
	case 'prod_nivel4'
		ls_nivel2 = this.getitemstring(row,'prod_nivel4')
		if isnull(ls_nivel2) or ls_nivel2 = '' then return
		
		for i = row to this.rowcount()
			this.setitem(i, 'prod_nivel4', ls_nivel2)
		next
		
		this.accepttext()
		if dw_1.update() = -1 then	
			gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			dw_1.retrieve(str.g_financiero, str.empresa)
		end if
end choose
//
//string ls_objeto
//integer li_pos 
//
//ls_objeto = This.GetObjectAtPointer()
//
//li_pos 	 =  Pos(ls_objeto, "~t")
//ls_objeto = Left(ls_objeto, li_pos - 1)
//
//if not (ls_objeto = 't_2' or ls_objeto = 'inmprodu_prod_foto_dir') then return
//
///* Alexis Receda 24/nov/2000 */
//
//
//integer li_row, li_rc
//string ls_path, ls_file
//
//		li_row = dw_1.getrow()
//		li_rc = getfileopenname("Selección de las Fotos",&
//		+ ls_path, ls_file, "gif",&
//		+ "Archivos de Fotos (*.jpg), *.jpg,"&
//		+ "Archivos de Fotos (*.gif), *.gif,"&
//		+ "Archivos de Fotos (*.bmp), *.bmp")
//		if li_rc = 0 then
//			return
//		end if
//		dw_1.setitem(1, 'inmprodu_prod_foto_dir',ls_path)
//		dw_2.setitem(1, 'foto',ls_path)
//		wf_actu()
//		
//		dw_1.setfocus()
//		
//		
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_estructura_de_catalogo
boolean visible = false
integer x = 14
integer y = 32
integer width = 2962
integer height = 288
integer taborder = 20
end type

type dw_productos from datawindow within w_estructura_de_catalogo
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

type sle_producto from singlelineedit within w_estructura_de_catalogo
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

type cb_1 from commandbutton within w_estructura_de_catalogo
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

type dw_2 from datawindow within w_estructura_de_catalogo
integer x = 55
integer y = 40
integer width = 6711
integer height = 236
integer taborder = 60
boolean bringtotop = true
boolean titlebar = true
string title = "Filtros de Campos"
string dataobject = "dw_external_filtros_asignacion"
boolean controlmenu = true
boolean border = false
string icon = "Database!"
boolean livescroll = true
end type

event editchanged;string ls_cadena, ls_producto, ls_descripcion, ls_nivel1, ls_nivel2, ls_nivel3, ls_nivel4, ls_nivel5
integer li_existencias
boolean lb_entro
this.accepttext()

ls_producto 	= this.getitemstring(1,'producto')
ls_descripcion = this.getitemstring(1,'descripcion')
ls_nivel1 = this.getitemstring(1,'nivel1')
ls_nivel2 = this.getitemstring(1,'nivel2')
ls_nivel3 = this.getitemstring(1,'nivel3')
ls_nivel4 = this.getitemstring(1,'nivel4')
ls_nivel5 = this.getitemstring(1,'nivel5')

if cbx_solo.checked then
	li_existencias = 1
else
	li_existencias = 0
end if

if len(ls_producto) > 0 then
	ls_cadena = 'upper(prod_producto) like "%'+upper(ls_producto)+'%"'
	lb_entro = true
end if

if len(ls_nivel1) > 0 then
	if lb_entro then
		ls_cadena = ls_cadena + ' and left(upper(prod_nivel1),'+ string(len(ls_nivel1))+ ') = "'+upper(ls_nivel1)+'"'
	else
		ls_cadena = 'left(upper(prod_nivel1),'+ string(len(ls_nivel1))+ ') = "'+upper(ls_nivel1)+'"'
	end if
	lb_entro = true
end if

if len(ls_nivel2) > 0 then
	if lb_entro then
		ls_cadena = ls_cadena + ' and left(upper(prod_nivel2),'+ string(len(ls_nivel2))+ ') = "'+upper(ls_nivel2)+'"'
	else
		ls_cadena = 'left(upper(prod_nivel2),'+ string(len(ls_nivel2))+ ') = "'+upper(ls_nivel2)+'"'
	end if
	lb_entro = true
end if

if len(ls_nivel3) > 0 then
	if lb_entro then
		ls_cadena = ls_cadena + ' and left(upper(prod_nivel3),'+ string(len(ls_nivel3))+ ') = "'+upper(ls_nivel3)+'"'
	else
		ls_cadena = 'left(upper(prod_nivel3),'+ string(len(ls_nivel3))+ ') = "'+upper(ls_nivel3)+'"'
	end if
	lb_entro = true
end if

if len(ls_nivel4) > 0 then
	if lb_entro then
		ls_cadena = ls_cadena + ' and left(upper(prod_nivel4),'+ string(len(ls_nivel4))+ ') = "'+upper(ls_nivel4)+'"'
	else
		ls_cadena = 'left(upper(prod_nivel4),'+ string(len(ls_nivel4))+ ') = "'+upper(ls_nivel4)+'"'
	end if
	lb_entro = true
end if

if len(ls_nivel5) > 0 then
	if lb_entro then
		ls_cadena = ls_cadena + ' and left(upper(prod_nivel5),'+ string(len(ls_nivel5))+ ') = "'+upper(ls_nivel5)+'"'
	else
		ls_cadena = 'left(upper(prod_nivel5),'+ string(len(ls_nivel5))+ ') = "'+upper(ls_nivel5)+'"'
	end if
	lb_entro = true
end if

if li_existencias = 1 then
	if lb_entro then
		ls_cadena = ls_cadena +' and prod_existencia_total > 12'
	else
		ls_cadena = 'prod_existencia_total > 12'
	end if
	lb_entro = true
end if

if len(ls_descripcion) > 0 then
	if lb_entro then
		if len(ls_producto) > 0 then
			ls_cadena = 'left(upper(prod_descripcion),'+ string(len(ls_descripcion))+ ') = "'+upper(ls_descripcion)+'" and ' +ls_cadena
		else
			ls_cadena = ls_cadena + ' and upper(prod_descripcion) LIKE "%'+upper(ls_descripcion)+'%"'
		end if
	else
		ls_cadena = 'upper(prod_descripcion) LIKE "%'+upper(ls_descripcion)+'%"'
	end if
	lb_entro = true
end if

if not lb_entro then
	ls_cadena = ''
end if

dw_1.setfilter(ls_cadena)
dw_1.filter()
end event

type lb_1 from listbox within w_estructura_de_catalogo
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

type cbx_solo from checkbox within w_estructura_de_catalogo
integer x = 718
integer y = 1900
integer width = 736
integer height = 84
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Solo con Existencias"
end type

event clicked;dw_2.triggerevent('editchanged')
end event

type cb_2 from commandbutton within w_estructura_de_catalogo
integer x = 4485
integer y = 284
integer width = 311
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event clicked;long i

if gf_mensaje('','Esta Seguro de Actualizar la Marca en el Nivel 3 ?',2,1,'Q') = 2 then return

	for i = 1 to dw_1.rowcount()
		yield()
		str.frame.setmicrohelp('Procesando '+string(i)+' de '+string(dw_1.rowcount()))
		dw_1.setitem(i,'prod_nivel3',dw_1.getitemstring(i,'marca'))
	next
	if dw_1.update() = -1 then
		gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
	end if
end event

type lb_2 from listbox within w_estructura_de_catalogo
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

type cb_3 from commandbutton within w_estructura_de_catalogo
integer x = 6775
integer y = 136
integer width = 343
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Validar Foto"
end type

event clicked;long i
string ls_foto
string ls_cadena, ls_producto, ls_descripcion, ls_nivel1, ls_nivel2, ls_nivel3, ls_nivel4
boolean lb_entro

for i = 1 to dw_1.rowcount()
	yield()
	str.frame.setmicrohelp('Procesando el Registro '+string(i) +' de '+string(dw_1.rowcount()))
	ls_foto = dw_1.getitemstring(i,'prod_foto_dir')
	if fileexists(ls_foto) then
		dw_1.setitem(i,'foto_existe',1)
	else
		dw_1.setitem(i,'foto_existe',0)
	end if

next

dw_1.accepttext()
dw_2.accepttext()

ls_producto 	= dw_2.getitemstring(1,'producto')
ls_descripcion = dw_2.getitemstring(1,'descripcion')
ls_nivel1 = dw_2.getitemstring(1,'nivel1')
ls_nivel2 = dw_2.getitemstring(1,'nivel2')
ls_nivel3 = dw_2.getitemstring(1,'nivel3')
ls_nivel4 = dw_2.getitemstring(1,'nivel4')

if len(ls_producto) > 0 then
	ls_cadena = 'left(upper(prod_producto),'+ string(len(ls_producto))+ ') = "'+upper(ls_producto)+'"'
	lb_entro = true
end if

if len(ls_descripcion) > 0 then
	if lb_entro then
		ls_cadena = ls_cadena + ' and left(upper(prod_descripcion),'+ string(len(ls_descripcion))+ ') = "'+upper(ls_descripcion)+'"'
	else
		ls_cadena = 'left(upper(prod_descripcion),'+ string(len(ls_descripcion))+ ') = "'+upper(ls_descripcion)+'"'
	end if
	lb_entro = true
end if

if cbx_solo.checked then
	if lb_entro then
		ls_cadena = ls_cadena + ' and prod_existencia_total > 12'
	else
		ls_cadena = 'prod_existencia_total > 12'
	end if
	lb_entro = true
end if

if len(ls_nivel1) > 0 then
	if lb_entro then
		ls_cadena = ls_cadena + ' and left(upper(prod_nivel1),'+ string(len(ls_nivel1))+ ') = "'+upper(ls_nivel1)+'"'
	else
		ls_cadena = 'left(upper(prod_nivel1),'+ string(len(ls_nivel1))+ ') = "'+upper(ls_nivel1)+'"'
	end if
	lb_entro = true
end if

if len(ls_nivel2) > 0 then
	if lb_entro then
		ls_cadena = ls_cadena + ' and left(upper(prod_nivel2),'+ string(len(ls_nivel2))+ ') = "'+upper(ls_nivel2)+'"'
	else
		ls_cadena = 'left(upper(prod_nivel2),'+ string(len(ls_nivel2))+ ') = "'+upper(ls_nivel2)+'"'
	end if
	lb_entro = true
end if

if len(ls_nivel3) > 0 then
	if lb_entro then
		ls_cadena = ls_cadena + ' and left(upper(prod_nivel3),'+ string(len(ls_nivel3))+ ') = "'+upper(ls_nivel3)+'"'
	else
		ls_cadena = 'left(upper(prod_nivel3),'+ string(len(ls_nivel3))+ ') = "'+upper(ls_nivel3)+'"'
	end if
	lb_entro = true
end if

if len(ls_nivel4) > 0 then
	if lb_entro then
		ls_cadena = ls_cadena + ' and left(upper(prod_nivel4),'+ string(len(ls_nivel4))+ ') = "'+upper(ls_nivel4)+'"'
	else
		ls_cadena = 'left(upper(prod_nivel4),'+ string(len(ls_nivel4))+ ') = "'+upper(ls_nivel4)+'"'
	end if
	lb_entro = true
end if



if not lb_entro then
	ls_cadena = 'foto_existe = 0'
else
	ls_cadena = ls_cadena + ' and foto_existe = 0'
end if

dw_1.setfilter(ls_cadena)
dw_1.filter()


str.frame.setmicrohelp('Listo')
end event

type cb_4 from commandbutton within w_estructura_de_catalogo
integer x = 2418
integer y = 284
integer width = 311
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event clicked;long i

if gf_mensaje('','Esta Seguro de Actualizar el Genero (Dama, Caballero, etc.) en el Nivel 1 ?',2,1,'Q') = 2 then return

	for i = 1 to dw_1.rowcount()
		yield()
		str.frame.setmicrohelp('Procesando '+string(i)+' de '+string(dw_1.rowcount()))
		dw_1.setitem(i,'prod_nivel1',dw_1.getitemstring(i,'departamento'))
	next
	if dw_1.update() = -1 then
		gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
	end if
end event

type cb_5 from commandbutton within w_estructura_de_catalogo
integer x = 3387
integer y = 288
integer width = 311
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event clicked;long i
if gf_mensaje('','Esta Seguro de Actualizar la Categoria en el Nivel 2 ?',2,1,'Q') = 2 then return
	for i = 1 to dw_1.rowcount()
		yield()
		str.frame.setmicrohelp('Procesando '+string(i)+' de '+string(dw_1.rowcount()))
		dw_1.setitem(i,'prod_nivel2',dw_1.getitemstring(i,'tipo'))
	next
	if dw_1.update() = -1 then
		gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
	end if
end event

type cb_6 from commandbutton within w_estructura_de_catalogo
boolean visible = false
integer x = 5458
integer y = 280
integer width = 311
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event clicked;long i

if gf_mensaje('','Esta Seguro de Actualizar la Talla en el Nivel 4 ?',2,1,'Q') = 2 then return

	for i = 1 to dw_1.rowcount()
		yield()
		str.frame.setmicrohelp('Procesando '+string(i)+' de '+string(dw_1.rowcount()))
		dw_1.setitem(i,'prod_nivel4',dw_1.getitemstring(i,'taman'))
	next
	if dw_1.update() = -1 then
		gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
	end if
end event

type cb_7 from commandbutton within w_estructura_de_catalogo
integer x = 5463
integer y = 284
integer width = 311
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event clicked;long i

if gf_mensaje('','Esta Seguro de Actualizar la Talla en el Nivel 4 ?',2,1,'Q') = 2 then return

	for i = 1 to dw_1.rowcount()
		yield()
		str.frame.setmicrohelp('Procesando '+string(i)+' de '+string(dw_1.rowcount()))
		dw_1.setitem(i,'prod_nivel4',dw_1.getitemstring(i,'taman'))
	next
	if dw_1.update() = -1 then
		gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
	end if
end event

