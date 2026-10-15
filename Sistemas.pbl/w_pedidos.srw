//objectcomments Ventana para la Captura de Pedidos
forward
global type w_pedidos from w_fa_padre
end type
type dw_2 from datawindow within w_pedidos
end type
type dw_3 from datawindow within w_pedidos
end type
type dw_4 from datawindow within w_pedidos
end type
type cbx_1 from checkbox within w_pedidos
end type
end forward

global type w_pedidos from w_fa_padre
integer x = 0
integer y = 0
integer width = 3840
integer height = 1932
string title = "Captura de Pedidos"
string menuname = "m_hs"
boolean controlmenu = false
long backcolor = 82899184
event ue_syscommand pbm_syscommand
event ue_aceptar_por_linea ( )
dw_2 dw_2
dw_3 dw_3
dw_4 dw_4
cbx_1 cbx_1
end type
global w_pedidos w_pedidos

type variables
integer ii_ann, datawindow, il_row, ii_cantidad_unidad, ii_cantidad_empaque
String  is_entrada, is_unidad_empaque, is_secuencia, is_actualiza
date	  idt_desde, idt_hasta
long    il_tiempo, il_segundos, il_secuencia, il_empaque
decimal{4} id_peso, id_cubicaje
decimal{2} id_precio
end variables

forward prototypes
public function boolean wf_orden_nueva ()
public function boolean wf_recupera ()
end prototypes

event ue_syscommand;call super::ue_syscommand;if commandtype = 61536 then
	close(this)
end if
end event

public function boolean wf_orden_nueva ();long ll_max
integer li_ann

li_ann = year(date(gf_fecha_serv()))

select max(convert(numeric(10), pedi_no_pedido ))
into	:ll_max
from pedidos
where pedi_g_financiero = :str.g_financiero and
		pedi_empresa		= :str.empresa and
		pedi_ann				= :li_ann ;
	if sqlca.sqlcode = -1  then
		gf_mensaje('','Error al Buscar Secuencia '+sqlca.sqlerrtext,1,1,'E')		
		return false
	end if
	
	if isnull(ll_max) then ll_max = 0
	
	ll_max ++
	
	dw_1.setitem(1,'pedi_no_pedido',string(ll_max))
	
	is_secuencia = string(ll_max)	
return true
end function

public function boolean wf_recupera ();long ll_fila, ll_recuperados

str.frame.setmicrohelp('Espere mientras se recuperan los registros...')

ll_fila = dw_1.getrow()

ll_recuperados = dw_1.retrieve(str.g_financiero, str.empresa, idt_desde, idt_hasta)
if ll_recuperados > ll_fila then
	dw_1.scrolltorow(ll_fila)
end if

il_segundos = 0

str.frame.setmicrohelp('Captura de Pedidos')

return true
end function

on w_pedidos.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.dw_4
this.Control[iCurrent+4]=this.cbx_1
end on

on w_pedidos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.cbx_1)
end on

event ue_post_open;call super::ue_post_open;dw_1.settransobject(sqlca);			
dw_2.settransobject(sqlca);	
ii_ann = year(date(gf_fecha_serv()))
datawindow = 1



this.triggerevent('ue_adicionar')

//Recupera la secuencia siguiente y da opcion para buscar una
wf_orden_nueva()

str.frame.setmicrohelp('Pedido')
//il_tiempo = 150
//em_tiempo.text = string(150)
//timer(1)
this.y = 0
this.x = 805
//this.height = w_fa_fondo.height - 50
end event

event ue_pre_aceptar;//Override
dw_1.Accepttext()

this.postevent("ue_aceptar")

end event

event ue_adicionar;//Override

if datawindow = 1 then	
	dw_1.reset()
	dw_2.reset()
	dw_1.insertrow(1)
	//Pone invisible el insertar	
	dw_1.setitem(1,'pedi_g_financiero',str.g_financiero)
	dw_1.setitem(1,'pedi_empresa',str.empresa)
	dw_1.setitem(1,'pedi_ann',ii_ann)
	dw_1.setitem(1,'pedi_fecha',date(gf_fecha_serv()))
	dw_1.setitem(1,'pedi_tipo_venta','CRE')
	dw_1.setitem(1,'pedi_estado','AC')
	dw_1.setfocus()
	dw_1.setcolumn('pedi_cliente')
	wf_orden_nueva()
else
	if dw_2.getrow() > 0 then	
		if dw_2.getitemstring(dw_2.getrow(), 'dped_producto') <> '' or &
			not isnull(dw_2.getitemstring(dw_2.getrow(), 'dped_producto')) then
			dw_2.scrolltorow(dw_2.insertrow(0))
			dw_2.setitem(dw_2.getrow(),'dped_g_financiero',str.g_financiero)
			dw_2.setitem(dw_2.getrow(),'dped_empresa',str.empresa)
		end if
	else
		dw_2.scrolltorow(dw_2.insertrow(0))
		dw_2.setitem(dw_2.getrow(),'dped_g_financiero',str.g_financiero)
		dw_2.setitem(dw_2.getrow(),'dped_empresa',str.empresa)
	end if
	dw_2.setfocus()
	dw_2.setcolumn('dped_producto')
end if

end event

event key;//override
end event

event close;if isvalid(this) then close(this)
end event

event ue_hay_data;//Override
end event

event resize;//Override
//dw_1.Resize(This.Width - 170, This.Height - 390)
//gb_1.width  = this.width  - 63
//gb_1.height = this.height - 180
//st_nom_ventana.x = 28
//st_nom_ventana.y = this.height - 180
dw_2.width = newwidth - 100
dw_2.height= newheight - 700
end event

event open;//override
gf_acelerador()
dw = dw_1

This.Icon = str.icono

this.postevent("ue_post_open")


This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)

str.frame.SetRedraw ( True )
end event

event ue_print;////override
dw_4.settransobject(sqlca)
if is_secuencia = '' then return
dw_4.retrieve(str.g_financiero, str.empresa, is_secuencia , ii_ann)
//
if dw_4.rowcount() = 0 then return
//
dw_4.object.datawindow.print.preview = 'yes'
dw_4.object.datawindow.print.preview.zoom = 100
dw_4.visible = true
//
OpenWithParm(w_dw_print_options, dw_4)
//
If Message.DoubleParm = -1 Then Return
dw_4.Print(True)

end event

event ue_aceptar;integer  li_contador,ll_update,ll_update2,li_encontro,li_lin_ref,li_posicion,li_frac2, li_find
integer  li_costo,anulado=0,li_linea_uno,li_linea_dos,indice, li_existe_detalle, li_empresa ,li_salvar
decimal  li_cantidad,li_cantid, li_cos_tran
datetime ldt_fecha,ldt_fecha_real
string   ls_documento,ls_aplic,ls_tipo,ls_medida,ls_producto,ls_concepto, fila, ls_conc,ls_error,ls_cuenta, ls_expresion, ls_doc
Long		ll_found, ll_ann,ll_secuencia
boolean  lb_existe

dw_1.acceptText()
dw_2.acceptText()
//dw=dw_1  

if (dw_1.getitemNumber(1,"pedi_cliente")) = 0 or isnull(dw_1.getitemNumber(1,"pedi_cliente")) then
	mensaje("Atencion Sr. Usuario","Debe asignar el cliente antes de guardar.","")
	dw_1.setcolumn("pedi_cliente")
	return
end if	


sqlca.autocommit = false

indice = 0

ls_documento = dw_1.getitemstring(1,"pedi_no_pedido")
is_secuencia = ls_documento
/*grabamos los datos del DW_1 de la tabla de INTMOVIM*////////////////
if dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = New! or &
	dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = NewModified! then 	
	
	//ll_secuencia = wf_buscar_secuencia() //buscamos la secuencia de dgmserie//
//	wf_buscar_secuencia(ll_secuencia)
   indice = 1
	
//	//Si no se ha creado la orden, crea una nueva
//	if not wf_valida_exis(ls_documento) then
//		if pos(is_secuencia,'-') = 0 then
//			ii_secuencia = 0
//			wf_buscar_secuencia(ii_secuencia) 
//			if ii_secuencia <> -1 then
//				is_secuencia  = is_inicial+"-"+string(ii_secuencia)
//				dw_1.setitem(1,"no_orden", is_secuencia )
//			end if
//		end if
//	end if
//
//	dw_1.setitem(1,'no_orden',string(ll_secuencia))
	
	if (dw_1.getitemString(1,"pedi_no_pedido")) = '' or isnull(dw_1.getitemString(1,"pedi_no_pedido")) then
		mensaje("Atencion Sr. Usuario","Debe Asignar un valor valido, Verifique.","")
		sqlca.autocommit = true
		return
	end if	
	/*Actualiza el Encabezado*/
	ll_update = dw_1.update()
	
	/*Actualiza la Secuencia en Dgmserie*/
	if ll_update =1 then
		 commit using sqlca;
	else
		ls_error =sqlca.sqlerrtext
		rollback using sqlca;
		sqlca.autocommit = true
		Mensaje("---Atención---","¡Error al Actualizar el encabezado !",ls_error)
		ib_aceptar = False
		is_actualiza=''
		return
	end if
	 sqlca.autocommit = true
	 
//	if ll_secuencia <> ii_secuencia then
//		 messagebox('Atención ',' La Secuencia ha Cambiado a: '+string(ll_secuencia))
//	end if
	/**/
else
	ll_update = dw_1.update()
  if ll_update = 1 then
		commit;
		sqlca.autocommit = true
	else
		ls_error =sqlca.sqlerrtext
		rollback using sqlca;
		sqlca.autocommit = true
		ib_aceptar = False
		Mensaje("---Atención---","¡Error al Actualizar el encabezado !",ls_error)
		is_actualiza=''
		return
	end if
//	ll_secuencia = long(dw_1.getitemstring(1,'no_orden'))
end if

sqlca.autocommit = false

/*grabamos los datos de DW_2 en la tabla INDTRANS*/
dwItemStatus ls_status


// Borra registros en blanco

for li_contador = 1 to dw_2.rowcount()
	ls_producto = dw_2.getitemstring(li_contador,"dped_producto")
	if ls_producto = "" or isnull(ls_producto) then		
		dw_2.deleterow(li_contador)
		li_contador --
	End If
	dw_2.setitem(li_contador,'dped_no_pedido',is_secuencia)
	dw_2.setitem(li_contador,'dped_ann',ii_ann)
	dw_2.setitem(li_contador,"dped_linea",li_contador)
		
	//Si la marca no existe, la adiciona
//	if li_contador > 0 then
//		wf_valida_existencia("DESCRIPCION", dw3.getitemstring(li_contador, "descripcion_item"), dw3)
//		wf_valida_existencia("MARCA", dw3.getitemstring(li_contador, "marca"), dw3)
//		wf_valida_existencia("SEX", dw3.getitemstring(li_contador, "sex"), dw3)
//		wf_valida_existencia("MATERIAL", dw4.getitemstring(li_contador, "material"), dw4)
//		wf_valida_existencia("MAT_DESCRIPCION", dw4.getitemstring(li_contador, "mat_descripcion"), dw4)
//		wf_valida_existencia("SIZE", dw4.getitemstring(li_contador, "size"), dw4)
//		wf_valida_existencia("RATIO", dw4.getitemstring(li_contador, "ratio"), dw4)
//	end if
//	
Next
//
li_salvar=1

If li_salvar = 1 then //Si todas las bodegas/ubicacion destino existen que salve
													
	ll_update =dw_2.update()
			if ll_update = -1 then
				ls_error =sqlca.sqlerrtext
				rollback using sqlca;
				sqlca.autocommit = true
				ib_aceptar = False
				is_actualiza=''
				Mensaje("---Aviso---","¡Error al Actualizar Detalle del Pedido!",ls_error)
				return
			end if

		
	  if ll_update = 1 then
		  sqlca.autocommit = true
		  ib_aceptar = True

		  /* Refresca los datos del datawindows cuando la Actualizacion fue correcta */
		  dw_1.setredraw(false)
		  dw_2.setredraw(false)				
		  long ll_fila
		  ll_fila = dw_2.getrow()
		  dw_1.retrieve(str.g_financiero, str.empresa, is_secuencia, ii_ann )
		  dw_2.retrieve(str.g_financiero, str.empresa, is_secuencia, ii_ann )
		  if dw_2.rowcount() = 0 then
			 datawindow = 2
			 dw = dw_2
			 this.triggerevent("ue_adicionar")
			 ll_fila = 1
		  end if
		  
		  dw_2.scrolltorow(il_row)
		  dw_1.setredraw(true)
		  dw_2.setredraw(true)	
		  
		  /////////////mensaje("Atención","Acualización Existosa","")
		  
		  str.frame.setmicrohelp('Pedido Guardado.')
		  commit using sqlca ; 
		  
		  
		else
			ls_error =sqlca.sqlerrtext
			rollback using sqlca;
			sqlca.autocommit = true
			ib_aceptar = False
			is_actualiza=''
			Mensaje("---Aviso---","¡Error al Actualizar! ",ls_error)
		end if
end if

sqlca.autocommit = true
//mensaje('Informacion','Actualizacion Exitosa','')
is_actualiza=''

end event

event timer;call super::timer;il_segundos = il_segundos + 1

if il_segundos > il_tiempo then
	wf_recupera()
	il_segundos = 0
end if
end event

event ue_busqueda;call super::ue_busqueda;//
String  ls_find,ls_codigo
integer li_c, li_b
long    ll_lter
string  ls_lter,ls_des

Datawindow        dww
str_dg_dynamic_find	lstr_df

	lstr_df.texto_campo [1,1] = "pedidos.pedi_no_pedido"
	lstr_df.texto_campo [1,2] = "Pedido"
	lstr_df.texto_campo [1,3] = "pedi_no_pedido"
	lstr_df.texto_campo [1,4] = 'V'
	lstr_df.texto_campo [1,5] = '280'	
	lstr_df.texto_campo [2,1] = "pedidos.pedi_a_nombre_de"
	lstr_df.texto_campo [2,2] = "A Nombre de"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '650'
	lstr_df.texto_campo [3,1] = "pedidos.pedi_fecha"
	lstr_df.texto_campo [3,2] = "Fecha"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [3,5] = '285'
	lstr_df.tabla = " pedidos "
		
	lstr_df.tabla_where = &
				"WHERE (pedidos.pedi_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(pedidos.pedi_empresa = " + string(str.empresa) + ") 	and " +&
 						 "(pedidos.pedi_ann = " + string(ii_ann) + ")"
	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm



If len (ls_find) = 0 Then Return
	
ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)
is_secuencia = ls_codigo
dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo, ii_ann )
dw_2.reset()
dw_2.retrieve(str.g_financiero, str.empresa, ls_codigo, ii_ann )
dw_2.scrolltorow(dw_2.rowcount())
dw_2.setfocus()
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_pedidos
boolean visible = false
integer x = 46
integer y = 2040
integer width = 101
string text = ""
end type

type dw_1 from w_fa_padre`dw_1 within w_pedidos
event ue_escape pbm_dwescape
integer x = 27
integer y = 12
integer width = 3662
integer height = 592
integer taborder = 10
string dataobject = "dw_encab_pedido"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event dw_1::ue_escape;//Override
////Codigo de Escape
//close(parent)
////parent.triggerevent("closequery")
////messagebox("Escape","Entro ...")
end event

event dw_1::ue_tabfinal;//override

end event

event dw_1::ue_down;//override
// Toma la Tecla que el usuario presione

CHOOSE CASE key
		
	CASE KeyF1! 
		
		This.Postevent("ue_helpcol")
		
	CASE	  Keyenter! 
		
	  This.Triggerevent("ue_entercol")
	  
END CHOOSE
end event

event dw_1::rbuttondown;//override
end event

event dw_1::ue_microayuda;//override
end event

event dw_1::buttonclicked;call super::buttonclicked;long ll_codigo
integer li_encontro
if dwo.name = 'b_cliente' then
	dw_3.dataobject = 'dw_clientes'
	dw_3.title =	'Mantenimiento de Clientes'
	dw_3.settransobject(sqlca)
	if dw_3.retrieve() = 0 then
		dw_3.insertrow(1)
	else
		ll_codigo	= dw_1.getitemnumber(1,'pedi_cliente')
		li_encontro = dw_3.find('clie_codigo = '+string(ll_codigo),1,dw_3.rowcount())
		if li_encontro > 0 then
			dw_3.scrolltorow(li_encontro)
		end if
	end if
	dw_3.setfocus()
	dw_3.width = 2400
	dw_3.x = 1293	
	dw_3.visible = true
elseif dwo.name = 'b_buscar' then
	parent.triggerevent('ue_busqueda')
end if
end event

event dw_1::clicked;call super::clicked;datawindow = 1
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;datawindow = 1
end event

event dw_1::itemchanged;call super::itemchanged;string ls_columna, ls_nombre
datawindowchild ldwc_cliente
this.accepttext()

ls_columna = this.getcolumnname()

choose case ls_columna
	case 'pedi_cliente'
		this.getchild('pedi_cliente', ldwc_cliente)
		ldwc_cliente.settransobject(sqlca)
//		ldwc_cliente.retrieve()
		ls_nombre = ldwc_cliente.getitemstring(ldwc_cliente.getrow(), 'clie_descripcion')
		this.setitem(1,'pedi_a_nombre_de',ls_nombre)
		this.setcolumn('pedi_a_nombre_de')
end choose


end event

type st_ayuda from w_fa_padre`st_ayuda within w_pedidos
integer x = 2793
integer y = 636
end type

type dw_2 from datawindow within w_pedidos
event ue_enter pbm_dwnprocessenter
event ue_down pbm_dwnkey
event ue_helpcol ( )
integer x = 18
integer y = 604
integer width = 3675
integer height = 1088
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle del Pedido"
string dataobject = "dw_detalle_pedido"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_enter;if this.getcolumnname() = 'dped_cubicaje' then	
	if this.getrow() = this.rowcount() then
		parent.triggerevent('ue_aceptar')
		parent.triggerevent('ue_adicionar')
	else
		this.scrolltorow(this.getrow() + 1)
		this.setcolumn('dped_producto')
	end if
elseif this.getcolumnname() = 'dped_producto' then	
	this.setcolumn('dped_precio')
elseif this.getcolumnname() = 'dped_precio' then	
	this.setcolumn('dped_cantidad')	
elseif this.getcolumnname() = 'dped_bultos' then	
	this.setcolumn('dped_peso')	
elseif this.getcolumnname() = 'dped_peso' then	
	this.setcolumn('dped_cubicaje')		
elseif this.getcolumnname() = 'dped_cantidad' then	
	this.setcolumn('dped_bultos')	
end if

return 2
end event

event ue_down;//override
// Toma la Tecla que el usuario presione

CHOOSE CASE key
		
	CASE KeyF1! 
		
		This.Postevent("ue_helpcol")
		
	CASE	  Keyenter! 
		
	  This.Triggerevent("ue_entercol")
	  
END CHOOSE
end event

event ue_helpcol();//Busqueda del producto
//
String  ls_find,ls_codigo
integer li_c, li_b
long    ll_lter
string  ls_lter,ls_des

Datawindow        dww
str_dg_dynamic_find	lstr_df

	lstr_df.texto_campo [1,1] = "productos.prod_producto"
	lstr_df.texto_campo [1,2] = "Referencia"
	lstr_df.texto_campo [1,3] = "prod_producto"
	lstr_df.texto_campo [1,4] = 'V'
//	lstr_df.texto_campo [1,5] = '280'	
	lstr_df.texto_campo [2,1] = "productos.prod_descripcion"
	lstr_df.texto_campo [2,2] = "Descripcion"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '770'
//	lstr_df.texto_campo [3,1] = "orden.enca_fecha"
//	lstr_df.texto_campo [3,2] = "Fecha"
//	lstr_df.texto_campo [3,3] = ""
//	lstr_df.texto_campo [3,4] = 'V'
//	lstr_df.texto_campo [3,5] = '285'
	lstr_df.tabla = " productos "
		
	lstr_df.tabla_where = &
				"WHERE (productos.prod_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(productos.prod_empresa = " + string(str.empresa) + ") "	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm



If len (ls_find) = 0 Then Return
	
ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)
this.setitem(this.getrow(),'dped_producto',ls_codigo)
this.accepttext()
this.trigger event itemchanged(this.getrow(), object, ls_codigo)
end event

event itemfocuschanged;datawindow = 2

end event

event clicked;datawindow = 2

if this.rowcount() = 0 then
	parent.triggerevent('ue_adicionar')
end if
end event

event buttonclicked;string ls_codigo
integer li_encontro
if dwo.name = 'b_producto' then
	dw_3.dataobject = 'dw_productos'
	dw_3.title =	'Productos'
	dw_3.settransobject(sqlca)
	if dw_3.retrieve(str.g_financiero, str.empresa) = 0 then
		dw_3.insertrow(1)
	else
		ls_codigo	= dw_2.getitemstring(dw_2.getrow(),'dped_producto')
		li_encontro = dw_3.find('prod_producto = "'+string(ls_codigo)+'"',1,dw_3.rowcount())
		if li_encontro > 0 then
			dw_3.scrolltorow(li_encontro)
		end if
	end if
	dw_3.setfocus()
	dw_3.width = 2501 + 1170
	dw_3.x = 0
	dw_3.visible = true

end if
end event

event itemchanged;string ls_codigo, ls_descripcion, ls_uni_empaque, ls_uni
long   ll_bultos, ll_cantidad
decimal {2} ld_precio

if this.getcolumnname() = 'dped_producto' then
	  ls_codigo = data
	  SELECT productos.prod_descripcion,   
         productos.prod_empaque,   
         productos.prod_unidad,   
         unidades_a.medi_cantidad,   
         unidades_b.medi_cantidad,
			productos.prod_peso,
			productos.prod_cubicaje,
			productos.prod_precio
    INTO :ls_descripcion,   
         :il_empaque,   
         :ls_uni,   
         :ii_cantidad_unidad,   
         :ii_cantidad_empaque,
			:id_peso,
			:id_cubicaje,
			:id_precio
    FROM productos,   
         unidades unidades_a,   
         unidades unidades_b  
   WHERE ( unidades_a.medi_unidad = productos.prod_unidad ) and  
         ( productos.prod_unidad_empaque = unidades_b.medi_unidad ) and  
         ( ( productos.prod_g_financiero = :str.g_financiero ) AND  
         ( productos.prod_empresa = :str.empresa ) AND  
         ( productos.prod_producto = :ls_codigo ) )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al recuperar datos del producto '+sqlca.sqlerrtext,1,1,'E')
			return 2
		end if
		if ls_descripcion = '' or isnull(ls_descripcion) then
			gf_mensaje('','Referencia no Existe, Verifique !!!',1,1,'E')
			this.setitem(row,'dped_producto','')
			this.setcolumn('dped_producto')
			return 2
		else
			this.setitem(row, 'dped_descripcion', ls_descripcion)
			this.setitem(row, 'dped_precio', id_precio)
			this.setcolumn('dped_precio')
		end if
elseif this.getcolumnname() = 'dped_cantidad' then
	ll_cantidad = long(data)	
	ld_precio   = this.getitemnumber(row, 'dped_precio')
	ll_bultos = (ll_cantidad * ii_cantidad_unidad ) / (il_empaque * ii_cantidad_empaque)
	if ll_bultos = 0 then ll_bultos = 1
	this.setitem(row,'dped_monto', round( ll_cantidad * ld_precio ,2))
	this.setitem(row,'dped_bultos',ll_bultos)
	this.setitem(row,'dped_peso',ll_bultos * id_peso)
	this.setitem(row,'dped_cubicaje',round(ll_bultos * id_cubicaje,4))
	this.setcolumn('dped_bultos')
	
elseif this.getcolumnname() = 'dped_precio' then	
	ld_precio = double(data)	
	ll_cantidad   = this.getitemnumber(row, 'dped_cantidad')	
	this.setitem(row,'dped_monto', round( ll_cantidad * ld_precio ,2))	
	this.setcolumn('dped_cantidad')
elseif this.getcolumnname() = 'dped_cubicaje' then	
	if this.getrow() = this.rowcount() then
		parent.triggerevent('ue_adicionar')
	else
		this.scrolltorow(this.getrow() + 1)
		this.setcolumn('dped_producto')
	end if
end if
end event

type dw_3 from datawindow within w_pedidos
boolean visible = false
integer x = 1193
integer y = 260
integer width = 2501
integer height = 1376
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Proveedores"
string dataobject = "dw_clientes"
boolean controlmenu = true
boolean vscrollbar = true
string icon = "AppIcon!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;integer i
datawindowchild ldwc_proveedor

if dwo.name = 'b_cerrar' then
	this.update()
	this.visible = false
	if this.dataobject = 'dw_proveedores' then
		dw_1.getchild('enca_proveedor', ldwc_proveedor)
		ldwc_proveedor.settransobject(sqlca)
		ldwc_proveedor.retrieve()
		dw_1.setfocus()
		dw_1.setcolumn('enca_proveedor')
	end if
elseif dwo.name = 'b_grabar' then
	for i = 1 to this.rowcount()
		this.setitem(i,'prod_g_financiero', str.g_financiero)
		this.setitem(i,'prod_empresa', str.empresa)
	next
	if this.update() = -1 then
		gf_mensaje('','Error al actualizar '+sqlca.sqlerrtext,1,1,'E')
	end if
end if
end event

type dw_4 from datawindow within w_pedidos
boolean visible = false
integer x = 55
integer y = 20
integer width = 3611
integer height = 1556
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Impresión de Pedidos"
string dataobject = "dw_impresion_pedido_proveedor"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
string icon = "AppIcon!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_1 from checkbox within w_pedidos
integer x = 2688
integer y = 16
integer width = 983
integer height = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Imprimir Agrupado por Proveedor"
boolean checked = true
end type

event clicked;if this.checked then
	dw_4.dataobject = 'dw_impresion_pedido_proveedor'
else
	dw_4.dataobject = 'dw_impresion_pedido'
end if

dw_4.settransobject(sqlca)

end event

