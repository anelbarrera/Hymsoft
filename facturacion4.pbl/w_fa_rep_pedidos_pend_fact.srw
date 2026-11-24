//objectcomments Ventana de Impresión del listado de los Pedidos Reservados pendientes de Factura
forward
global type w_fa_rep_pedidos_pend_fact from w_fa_padre_reportes
end type
type dw_2 from datawindow within w_fa_rep_pedidos_pend_fact
end type
type dw_3 from datawindow within w_fa_rep_pedidos_pend_fact
end type
end forward

global type w_fa_rep_pedidos_pend_fact from w_fa_padre_reportes
integer width = 2912
integer height = 1524
string title = "(FA) Reporte de Pedidos Pendientes de Factura"
string menuname = "m_hs"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
dw_2 dw_2
dw_3 dw_3
end type
global w_fa_rep_pedidos_pend_fact w_fa_rep_pedidos_pend_fact

type variables
str_rangofecha lstr_rangfech
end variables

on w_fa_rep_pedidos_pend_fact.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.dw_2=create dw_2
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
end on

on w_fa_rep_pedidos_pend_fact.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_3)
end on

event open;call super::open;
string ls_empresa
datetime	ldt_fecha1,ldt_fecha2

lstr_rangfech = message.powerObjectParm

ldt_fecha1 = datetime(lstr_rangfech.fecha1,00:00:00)
ldt_fecha2 = datetime(lstr_rangfech.fecha2,23:59:59)
If lstr_rangfech.opcion = 'Pedido' then
	if w_hs_frame.str_para.utiliza_decimales = 1 then
//      m_fa_rep.m_edicin.m_sortear.toolbaritemvisible = false		
		if pos(upper(str.nombre_empresa),'TEXTILES INTERNA') > 0  then
			if lstr_rangfech.opcion_reporte = '1' then
				dw_1.DataObject = lstr_rangfech.dwo
			else
				dw_1.DataObject = "dw_fa_rep_pcking_pend_fact_t"
			end if
		else
			dw_1.DataObject = "dw_fa_rep_pcking_pend_fact_t"
		end if
	else
//      m_fa_rep.m_edicin.m_sortear.toolbaritemvisible = true		
		if pos(upper(str.nombre_empresa),'TEMPO') > 0  or pos(upper(str.nombre_empresa),'BODY') > 0 then
			dw_1.DataObject = "dw_fa_rep_pcking_pend_fact_tempo"
		else
			dw_1.DataObject = "dw_fa_rep_pcking_pend_fact"
		end if
	end if
elseif  lstr_rangfech.opcion = 'Factura' then
	dw_1.DataObject = "dw_fa_rep_pcking_pend_fact_factura"
elseif lstr_rangfech.opcion = 'Ambos' then
	if w_hs_frame.str_para.utiliza_decimales = 1 then
//      m_fa_rep.m_edicin.m_sortear.toolbaritemvisible = false		
		dw_1.DataObject = "dw_fa_rep_pedidos_facturas_reserva_t"
	else
//      m_fa_rep.m_edicin.m_sortear.toolbaritemvisible = true			
		if pos(upper(gf_dg_nombre_empresa()),'ELBROS') > 0  then		
			dw_1.DataObject = "dw_fa_rep_pedidos_facturas_reser_elbros"
		else
			dw_1.DataObject = "dw_fa_rep_pedidos_facturas_reserva"
		end if
	end if	
elseif lstr_rangfech.opcion = 'Registrados' then
//	   m_fa_rep.m_edicin.m_sortear.toolbaritemvisible = true		
		dw_1.DataObject = "dw_fa_rep_pedidos_registrados"
		this.title = '(FA) Reporte de Pedidos Registrados'
end If
dw = dw_1
dw.settransobject(sqlca)
dw.object.fecha_repo.expression= "'Del día: "+string(lstr_rangfech.fecha1)+" al "+string(lstr_rangfech.fecha2)+"'"
dw.object.data_window.expression= "'"+dw_1.dataobject+"'"
ls_empresa = gf_dg_nombre_empresa()
if dw.Describe("nomb_empresa.x") <> "?" and dw.Describe("nomb_empresa.x") <> "!" then &
dw.object.nomb_empresa.expression= "'"+ls_empresa+"'"

dw.Object.datawindow.print.preview = true

if lstr_rangfech.opcion = 'Ambos' then
	dw.retrieve(str.g_financiero,str.empresa,ldt_fecha1,ldt_fecha2)
else
	if dw_1.DataObject = "dw_fa_rep_pcking_pend_fact_tempo" or dw_1.DataObject = "dw_fa_rep_pedidos_registrados" then
		dw.retrieve(str.g_financiero,str.empresa)
	else
		dw.retrieve(str.g_financiero,str.empresa,lstr_rangfech.fecha1,lstr_rangfech.fecha2)
	end if
end if
//Para inicializar el dw de los pedidos
dw_2.settransobject(sqlca)
dw_2.x = dw_1.x
dw_2.y = dw_1.y
dw_3.settransobject(sqlca)
dw_3.x = dw_1.x
dw_3.y = dw_1.y


end event

event resize;//Override
this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 278

dw_2.width = dw_1.width
dw_2.height = dw_1.height

dw_3.width = dw_1.width
dw_3.height = dw_1.height

gb_1.width  = this.width  - 63
gb_1.height = this.height - 220


st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180
this.SetRedraw(true)
end event

event activate;call super::activate;//Integer li_tp
//Long 	  ll_rtn

//if not isvalid(m_fa_rep) then 
//	this.changemenu(m_fa_rep)
//end if

end event

event key;//Override
//Para cerrar la ventana al dar escape
if Key = KeyEscape! and not dw_2.visible and not dw_3.visible then 	//Si el dw del detalle esta oculto
	this.Postevent("close")
elseif dw_2.visible and getfocus() <> dw_1 then	//Si el dw del detalle esta visible, lo oculta
	dw_2.visible = false
elseif dw_3.visible and getfocus() <> dw_1 then	//Si el dw del detalle esta visible, lo oculta
	dw_3.visible = false
end if


end event

event close;Window lw_frame

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

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_rep_pedidos_pend_fact
integer x = 37
integer y = 1288
end type

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_rep_pedidos_pend_fact
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_rep_pedidos_pend_fact
integer y = 44
integer width = 2789
integer height = 1216
string dataobject = "dw_fa_rep_pcking_pend_fact_tempo"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_syntax
datetime ld_fecha_ini, ld_fecha_fin

ld_fecha_ini = DateTime(lstr_rangfech.fecha1,Time("00:00:00"))
ld_fecha_fin = DateTime(lstr_rangfech.fecha2,Time("23:59:59"))
//messagebox(string(ld_fecha_ini),string(ld_fecha_fin))
ls_syntax = sqlsyntax
if dw_1.DataObject = "dw_fa_rep_pcking_pend_fact_tempo" then
	if lstr_rangfech.tipo_accion = 'S' then
		ls_syntax = ls_syntax + " AND (vi_pediapasar.pedi_fecha_creacion >= '"+string(ld_fecha_ini,'mm/dd/yyyy hh:mm:ss')+"' ) and (vi_pediapasar.pedi_fecha_creacion <= '"+string(ld_fecha_fin,'mm/dd/yyyy hh:mm:ss')+"') "		
	else
		ls_syntax = ls_syntax + " AND (vi_pediapasar.pedi_fecha >= '"+string(ld_fecha_ini,'mm/dd/yyyy hh:mm:ss')+"') and (vi_pediapasar.pedi_fecha <= '"+string(ld_fecha_fin,'mm/dd/yyyy hh:mm:ss')+"') "	
	end if	
	dw_1.setsqlpreview(ls_syntax)
elseif dw_1.DataObject = "dw_fa_rep_pedidos_registrados" then
	if lstr_rangfech.tipo_accion = 'S' then
		ls_syntax = ls_syntax + " AND (fatpedid.pedi_fecha_creacion >= '"+string(ld_fecha_ini)+"' ) and (fatpedid.pedi_fecha_creacion < DateAdd(dd,1, '"+string(ld_fecha_fin)+"')) "		
	else
		ls_syntax = ls_syntax + " AND (fatpedid.pedi_fecha >= '"+string(ld_fecha_ini)+"') and (fatpedid.pedi_fecha < DateAdd(dd,1, '"+string(ld_fecha_fin)+"')) "	
	end if	
	dw_1.setsqlpreview(ls_syntax)	
end if
end event

event dw_1::doubleclicked;call super::doubleclicked;string         ls_pointer
long           li_fila
datetime       ldt_fecha1
string ls_pedido,ls_factura
integer li_ann
window		   lw_child
str_rangofecha	str_rangofecha_opcion
//str_fa_bus_var str_busqueda

//If pos(upper(str.nombre_empresa),'ELECTROVISION') > 0 Then 
//if w_fa_fondo.str_aplica_links.habilita_links = 1	then
	ls_pointer = dw_1.GetObjectAtPointer()
	li_fila = integer(trim(mid(ls_pointer,31)))
	if pos(ls_pointer,'vi_pediapasar_t_pedi_no_pedido') > 0 then 
		str_rangofecha_opcion.orden = dw_1.getitemstring(li_fila,'vi_pediapasar_t_pedi_no_pedido')
		str_rangofecha_opcion.ano = dw_1.getitemnumber(li_fila,'vi_pediapasar_t_pedi_ann')
		OpenSheetWithParm(lw_child,str_rangofecha_opcion,"w_fa_co_pedidos_pendientes_facturar",str.frame,11,Original!)
	else
		if lstr_rangfech.opcion = 'Pedido' then
			ls_pedido = dw.getitemstring(dw.getrow(),'vi_pediapasar_pedi_no_pedido')
			li_ann	 = dw.getitemnumber(dw.getrow(),'vi_pediapasar_pedi_ann')
			dw_2.visible = true
			dw_2.title = 'Pedido '+ls_pedido+' - '+string(li_ann)
			dw_2.retrieve(str.g_financiero, str.empresa, ls_pedido, li_ann)
			dw_2.setfocus()
		elseif lstr_rangfech.opcion = 'Ambos' then
			ls_pedido = dw.getitemstring(dw.getrow(),'no_pedido')
			li_ann	 = dw.getitemnumber(dw.getrow(),'ann')	
			if right(ls_pedido,1) = 'F' then	//Si es de facturas, retorna
				ls_factura = dw.getitemstring(dw.getrow(),'factura')
				dw_3.visible = true
				  ls_pedido = mid(ls_pedido,1,len(ls_pedido)-1)		
				dw_3.title = 'Factura '+ls_factura +' Pedido '+ls_pedido+' - '+string(li_ann)
					dw_3.retrieve(str.g_financiero, str.empresa, ls_pedido, li_ann)
				dw_3.setfocus()
			else		
				dw_2.visible = true
				dw_2.title = 'Pedido '+ls_pedido+' - '+string(li_ann)
				dw_2.retrieve(str.g_financiero, str.empresa, ls_pedido, li_ann)
				dw_2.setfocus()
			end if
		
		else	//Por factura
			ls_pedido = dw.getitemstring(dw.getrow(),'vi_factuapasar_fact_no_pedido')
			li_ann	 = dw.getitemnumber(dw.getrow(),'vi_factuapasar_fact_ann')		
			ls_factura = dw.getitemstring(dw.getrow(),'vi_factuapasar_fact_no_factura')
			dw_3.visible = true
			dw_3.title = 'Factura '+ls_factura +' Pedido '+ls_pedido+' - '+string(li_ann)
			dw_3.retrieve(str.g_financiero, str.empresa, ls_pedido, li_ann)
			dw_3.setfocus()
		end if

	end if
//end if 

//	dw_3.Object.dmov_secuencia.Pointer = 'Cross!'

end event

event dw_1::retrieveend;call super::retrieveend;integer i, li_ann, li_existe
string ls_pedido
decimal{2} ld_total, ld_pendiente, ld_gastos

if this.dataobject <> 'dw_fa_rep_pcking_pend_fact_tempo' then return

for i = 1 to rowcount
	str.frame.setmicrohelp('Procesando el Pedido '+string(i) +' de '+string(rowcount))
	ls_pedido = this.getitemstring(i,'vi_pediapasar_pedi_no_pedido')
	li_ann	 = this.getitemnumber(i,'vi_pediapasar_pedi_ann')
	ld_total	 = this.getitemnumber(i,'vi_pediapasar_pedi_monto_final')
	ld_gastos = this.getitemnumber(i,'pedi_gastos_total')
	
	SELECT  isnull(sum(convert(numeric(8,2),(((fadpedid.dped_fraccion + (fadpedid.dped_cantidad * inamedid.medi_cantidad )) - fadpedid.dped_pasada) / inamedid.medi_cantidad )) * dped_precio_original ),0)
	into :ld_pendiente
  FROM fadpedid,
         inamedid
   WHERE ( inamedid.medi_medida = fadpedid.dped_unidad_venta ) and
			( fadpedid.dped_g_financiero = :str.g_financiero ) and
			( fadpedid.dped_empresa	= :str.empresa ) and
			( fadpedid.dped_no_pedido = :ls_pedido ) and
			( fadpedid.dped_ann = :li_ann  ) and
          fadpedid.dped_pasada <  (fadpedid.dped_fraccion + (fadpedid.dped_cantidad * inamedid.medi_cantidad )) ;

			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Seleccionar Pendientes '+sqlca.sqlerrtext,1,1,'E')
			end if
	
	this.setitem(i,'pendiente',ld_pendiente + ld_gastos)

	  SELECT count(*)  
		 INTO :li_existe  
		 FROM fatempaq  
		WHERE ( fatempaq.enca_g_financiero = :str.g_financiero ) AND  
				( fatempaq.enca_empresa = :str.empresa ) AND  
				( fatempaq.enca_fuente = 'PE' ) AND  
				( fatempaq.enca_no_pedido = :ls_pedido ) AND  
				( fatempaq.enca_ann_pedido = :li_ann )    ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Buscar Lista de Empaque '+sqlca.sqlerrtext,1,1,'E')
			end if

	if li_existe > 0 then
		this.setitem(i,'en_lista_empaque',1)
	end if
	
next

str.frame.setmicrohelp('Listo')

end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_rep_pedidos_pend_fact
integer y = 4
integer width = 2821
integer height = 1268
end type

type dw_2 from datawindow within w_fa_rep_pedidos_pend_fact
event ue_microayuda pbm_nchittest
event ue_escape pbm_dwnprocessenter
boolean visible = false
integer x = 238
integer y = 8
integer width = 1851
integer height = 548
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "dw_ma_fa_detalle_pedido"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event ue_microayuda;/*
	Evento que muestra una pequeña Ayuda dependiendo en que columna se encuentre el mouse
*/

Integer li_pos, li_x, li_y
String ls_objeto, ls_col

ls_objeto = This.GetObjectAtPointer()
li_pos = pos  (ls_objeto,"~t")
ls_col = left (ls_objeto, li_pos - 1)


li_x	 = str.frame.GetActiveSheet ().PointerX () //- 900
li_y	 = str.frame.GetActiveSheet ().PointerY () - 200

//messagebox("Apunta a :",ls_col)

// Dependiendo de la Columna el Mensaje de Ayuda varía
CHOOSE CASE right(ls_col,2)
	CASE '_t'
//		messagebox("!","Invisible")
		If st_ayuda.Visible Then Return
		st_ayuda.Move (li_x, li_y)
		st_ayuda.Text 	= "Haga click para ordenar por la Columna de " + this.describe(ls_col+".text")
		st_ayuda.Width 	= Len (st_ayuda.Text) * 28
		st_ayuda.Visible = TRUE	
	CASE ELSE
	st_ayuda.Visible = FALSE
END CHOOSE

//Integer li_pos, li_x, li_y,li_largo
//String ls_objeto, ls_col
//
//ls_objeto = This.GetObjectAtPointer()
//li_pos = pos  (ls_objeto,"~t")
//ls_col = left (ls_objeto, li_pos - 1)
//
//li_x	 = str.frame.GetActiveSheet ().PointerX () 
//li_largo = len("Haga click para ordenar por la Columna de " + this.describe(ls_col+".text"))*28
//
//If li_x +li_largo >(li_w_ancho +100) then
//	li_x = (li_w_ancho +100) - li_largo
//end if
//
//li_y	 = str.frame.GetActiveSheet ().PointerY () - 200
//
//// Dependiendo de la Columna el Mensaje de Ayuda varía
//CHOOSE CASE right(ls_col,2)
//	CASE '_t'
//		If st_ayuda.Visible Then Return
//		st_ayuda.Move (li_x, li_y)
//		st_ayuda.Text 	= "Haga click para ordenar por la Columna de " + this.describe(ls_col+".text")
//		st_ayuda.Width 	= Len (st_ayuda.Text) * 28
//		st_ayuda.Visible = TRUE	
//	CASE ELSE
//	st_ayuda.Visible = FALSE
//END CHOOSE
end event

event ue_escape;this.visible = false
end event

event clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
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

type dw_3 from datawindow within w_fa_rep_pedidos_pend_fact
event ue_microayuda pbm_nchittest
event ue_escape pbm_dwescape
boolean visible = false
integer x = 347
integer y = 40
integer width = 1897
integer height = 508
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "dw_ma_fa_detalle_factura"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event ue_microayuda;/*
	Evento que muestra una pequeña Ayuda dependiendo en que columna se encuentre el mouse
*/

Integer li_pos, li_x, li_y
String ls_objeto, ls_col

ls_objeto = This.GetObjectAtPointer()
li_pos = pos  (ls_objeto,"~t")
ls_col = left (ls_objeto, li_pos - 1)


li_x	 = str.frame.GetActiveSheet ().PointerX () //- 900
li_y	 = str.frame.GetActiveSheet ().PointerY () - 200

//messagebox("Apunta a :",ls_col)

// Dependiendo de la Columna el Mensaje de Ayuda varía
CHOOSE CASE right(ls_col,2)
	CASE '_t'
//		messagebox("!","Invisible")
		If st_ayuda.Visible Then Return
		st_ayuda.Move (li_x, li_y)
		st_ayuda.Text 	= "Haga click para ordenar por la Columna de " + this.describe(ls_col+".text")
		st_ayuda.Width 	= Len (st_ayuda.Text) * 28
		st_ayuda.Visible = TRUE	
	CASE ELSE
	st_ayuda.Visible = FALSE
END CHOOSE

//Integer li_pos, li_x, li_y,li_largo
//String ls_objeto, ls_col
//
//ls_objeto = This.GetObjectAtPointer()
//li_pos = pos  (ls_objeto,"~t")
//ls_col = left (ls_objeto, li_pos - 1)
//
//li_x	 = str.frame.GetActiveSheet ().PointerX () 
//li_largo = len("Haga click para ordenar por la Columna de " + this.describe(ls_col+".text"))*28
//
//If li_x +li_largo >(li_w_ancho +100) then
//	li_x = (li_w_ancho +100) - li_largo
//end if
//
//li_y	 = str.frame.GetActiveSheet ().PointerY () - 200
//
//// Dependiendo de la Columna el Mensaje de Ayuda varía
//CHOOSE CASE right(ls_col,2)
//	CASE '_t'
//		If st_ayuda.Visible Then Return
//		st_ayuda.Move (li_x, li_y)
//		st_ayuda.Text 	= "Haga click para ordenar por la Columna de " + this.describe(ls_col+".text")
//		st_ayuda.Width 	= Len (st_ayuda.Text) * 28
//		st_ayuda.Visible = TRUE	
//	CASE ELSE
//	st_ayuda.Visible = FALSE
//END CHOOSE
end event

event ue_escape;this.visible = false
end event

event clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
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

