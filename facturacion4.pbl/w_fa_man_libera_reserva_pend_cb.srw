//objectcomments Busqueda Rapida de Productos Incluidos y Por Incluir en el Packing List
forward
global type w_fa_man_libera_reserva_pend_cb from w_fa_padre_reportes
end type
type dw_2 from datawindow within w_fa_man_libera_reserva_pend_cb
end type
type cb_1 from commandbutton within w_fa_man_libera_reserva_pend_cb
end type
type cb_2 from commandbutton within w_fa_man_libera_reserva_pend_cb
end type
type st_1 from statictext within w_fa_man_libera_reserva_pend_cb
end type
type st_2 from statictext within w_fa_man_libera_reserva_pend_cb
end type
end forward

global type w_fa_man_libera_reserva_pend_cb from w_fa_padre_reportes
integer width = 2642
integer height = 1292
string title = "(FA) Productos"
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_2 dw_2
cb_1 cb_1
cb_2 cb_2
st_1 st_1
st_2 st_2
end type
global w_fa_man_libera_reserva_pend_cb w_fa_man_libera_reserva_pend_cb

type variables
str_fa_pedi_empaque str_empaque
str_fa_desglose   str_desglose 
string  is_filter

end variables

forward prototypes
public subroutine wf_fecha ()
public subroutine wf_nofecha ()
public subroutine wf_actualiza ()
end prototypes

public subroutine wf_fecha ();
end subroutine

public subroutine wf_nofecha ();
end subroutine

public subroutine wf_actualiza ();is_filter = "actualizar = 1"

dw_2.SetFilter (is_filter)
dw_2.Filter()
if dw_2.rowcount() > 0 then
	// fin, empresa, no_pedido, ann_pedido, lin_refer
	// actualizar
	Long	ll_row, ll_lin_ref, ll_anio
	String	ls_pedido, ls_error
	Decimal	ld_cantidad
	
	for ll_row = 1 to dw_2.rowcount()
		ls_pedido 	= dw_2.GetItemString(ll_row,'enca_no_pedido')
		ll_anio 		= dw_2.GetItemNumber(ll_row,'enca_ann_pedido')
		ld_cantidad = dw_2.GetItemNumber(ll_row,'libera_reserva')
		ll_lin_ref  = dw_2.GetItemNumber(ll_row,'empa_linea_original')
		
			  UPDATE fadpedid  
		  SET dped_cantidad = (dped_cantidad - :ld_cantidad ) 
		WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
				( fadpedid.dped_empresa = :str.empresa ) AND  
				( fadpedid.dped_no_pedido = :ls_pedido ) AND  
				( fadpedid.dped_ann = :ll_anio )   AND
				( fadpedid.dped_linea = :ll_lin_ref ) ;
					
				If sqlca.sqlcode = -1  then
					ls_error =sqlca.sqlerrtext
					rollback using sqlca;
					mensaje("Error al actualizar cantidad reservada  (fadpedid) ",ls_error,"")
					return
				End If
				If sqlca.sqlcode = 0  then
					messagebox("Actualizda con éxito","Línea "+string(ll_lin_ref))
				End If

	Next
//	close(parent)
else
	is_filter = "libera_reserva <> 0 "
	dw_2.SetFilter (is_filter)
	dw_2.Filter()
	messagebox('Atención','Si desea liberar y/o reservar, debe seleccionar los registros ....!!')
	
end if

end subroutine

on w_fa_man_libera_reserva_pend_cb.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
end on

on w_fa_man_libera_reserva_pend_cb.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.st_2)
end on

event ue_post_open;call super::ue_post_open;If str_desglose.vienede <> 'PE' THEN 
	messagebox('Atención','Sólo Listas de Empaques originadas en Pedidos')
	This.Setredraw(true)
	str.frame.SetRedraw (true)
	triggerevent("close")
end if

Long	ll_row, ll_lin_ref, ll_anio, ll_ann_emp, li_linea_emp,li_row
String	ls_pedido, ls_error, ls_lista_emp, ls_expresion, ls_producto,ls_find
Decimal	ld_cantidad, ld_asignada, ld_reservada

SetPointer(HourGlass!)
dw_2.Retrieve(str.g_financiero, str.empresa,str_desglose.empaque,str_desglose.ann_empa)

if dw_2.rowcount() > 0 then

	ls_pedido 	= dw_2.GetItemString(1,'enca_no_pedido')
	ll_anio 		= dw_2.GetItemNumber(1,'enca_ann_pedido')
	
	dw_1.settransobject(sqlca)
	
	dw_1.Retrieve(str.g_financiero, str.empresa,	ls_pedido,ll_anio)

	/*Valida status del pedido*/
	if dw_1.GetItemString(1,'pedi_estado') <> 'A' then
		messagebox('Atención','Este pedido no esta activo, por lo que no puede modificarse ...!!1')
		This.Setredraw(true)
		str.frame.SetRedraw (true)
		triggerevent("close")
		return
	end if
	
	for ll_row = 1 to dw_2.rowcount()
		ll_lin_ref  = dw_2.GetItemNumber(ll_row,'empa_linea_original')
		ls_producto = dw_2.GetItemString(ll_row,'empa_codigo_producto')
		
		ls_expresion 		=  "codigo_item = '"+ls_producto+"' and dped_linea = "+string(ll_lin_ref)
	
		//Busca en el dw_1
		li_row	=  dw_1.Find(ls_expresion,1,dw_1.Rowcount())
		If li_row > 0 then
			ls_find = 'S'
			
			ld_reservada = round(dw_1.GetItemNumber(li_row,'dped_cantidad'),2)
			
			dw_2.SetItem(ll_row,'fadempaq_reservada',ld_reservada)
			
			ld_asignada = dw_1.GetItemNumber(li_row,'dped_cant_asignada')

			if ld_asignada <= 0 then ld_asignada = dw_1.GetItemNumber(li_row,'dped_cantidad')
			
			/*Marca registros donde lo asignado > reservado*/
			dw_2.SetItem(ll_row,'fadempaq_asignada',ld_asignada)
			
			If ld_asignada > ld_reservada then
				dw_2.SetItem(ll_row,'asig_may_reservada',1)
			else
				dw_2.SetItem(ll_row,'asig_may_reservada',0)
			end if
		end if
	Next
/**/
	
end if 

/* Filtra registros donde (lo asignado del renglón L.Emp. <> desglosado)
  o donde luego de liberar lo que quede de la lista de empaque, lo reservado > asignado o
  aquellos en donde lo asignado en la lista de empaque > a lo desglosado */
is_filter = "libera_reserva <> 0 or lib_reser_total > 0 or asig_may_reservada = 1"

if ls_find = 'S' then
	dw_2.SetFilter (is_filter)
	dw_2.Filter()
end if

if dw_2.rowcount() < 1 then
	messagebox('','No hay registros pendientes de reserva ni para liberar ...!!1')
	This.Setredraw(true)
	str.frame.SetRedraw (true)
	triggerevent("close")
	return
end if

dw_2.Setredraw(true)
str.frame.SetRedraw (true)

//str.frame.SetMicroHelp ("Seleccione una Linea y Precione la Tecla Enter para Cargar la Información" )
end event

event resize;//Override
end event

event key;//Override

if keydown(keyEscape!) then
	this.Postevent("close")
end if
end event

event open;//OVERRIDE
/***************************/
gf_center_win(This)
/**************************/

This.Setredraw(false)
dw_2.Setredraw(false)
str.frame.SetRedraw ( false )

dw = dw_2
//dw_impresion = dw_2
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()

This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)
This.icon = str.icono

str_desglose = Message.PowerObjectParm

This.Postevent("ue_post_open")

end event

event close;//Override
if isvalid(this) then
	CloseWithReturn(this,str_desglose)
End If

end event

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_man_libera_reserva_pend_cb
integer x = 14
integer y = 1112
end type

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_man_libera_reserva_pend_cb
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_man_libera_reserva_pend_cb
event ue_down pbm_dwnkey
event ue_entercol ( )
event ue_escape pbm_dwescape
event ue_sobre pbm_nchittest
boolean visible = false
integer x = 9
integer y = 716
integer width = 2592
integer height = 356
integer taborder = 110
string dataobject = "dw_ma_fa_pedi_reserva_asignada"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = false
borderstyle borderstyle = stylelowered!
end type

event dw_1::ue_entercol;
close(parent)
end event

event dw_1::rbuttondown;//
end event

event dw_1::doubleclicked;call super::doubleclicked;//This.TriggerEvent("ue_entercol")
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_man_libera_reserva_pend_cb
integer x = 5
integer y = 0
integer width = 2615
integer height = 1092
integer taborder = 0
end type

type dw_2 from datawindow within w_fa_man_libera_reserva_pend_cb
integer x = 9
integer y = 60
integer width = 2601
integer height = 1012
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ma_fa_libera_act_reserva_packing"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_1 from commandbutton within w_fa_man_libera_reserva_pend_cb
integer x = 1920
integer y = 1104
integer width = 325
integer height = 88
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event clicked;str_desglose.devuelve='0'
/* Filtra registros donde (lo asignado del renglón L.Emp. <> desglosado)
   o donde la reserva total > (asignado total después de liberar y/o 
	reservar el renglón de la L.Emp.)*/
is_filter = "actualizar = 1 or actua_tpedido = 'S'"
dw_2.SetFilter (is_filter)
dw_2.Filter()
if dw_2.rowcount() > 0 then

	Long	ll_row, ll_lin_ref, ll_anio, ll_ann_emp, li_linea_emp
	String	ls_pedido, ls_error, ls_lista_emp
	Decimal	ld_cantidad, ld_libera_ped
	
	for ll_row = 1 to dw_2.rowcount()
		ls_pedido 	= dw_2.GetItemString(ll_row,'enca_no_pedido')
		ll_anio 		= dw_2.GetItemNumber(ll_row,'enca_ann_pedido')
		
		ld_cantidad   = round(dw_2.GetItemNumber(ll_row,'libera_reserva'),6)
		ld_libera_ped = round(dw_2.GetItemNumber(ll_row,'lib_reser_total'),6)
		
		ll_lin_ref  = dw_2.GetItemNumber(ll_row,'empa_linea_original')

		ls_lista_emp 	= dw_2.GetItemString(ll_row,'empa_lista_empaque')
		ll_ann_emp 		= dw_2.GetItemNumber(ll_row,'empa_ann')
		li_linea_emp  = dw_2.GetItemNumber(ll_row,'empa_linea')
		//actua_tpedido
		
		If dw_2.GetItemNumber(ll_row,'actualizar') =1 then
			
			  UPDATE fadpedid  
		  SET dped_cantidad = (dped_cantidad - :ld_cantidad ) 
		WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
				( fadpedid.dped_empresa = :str.empresa ) AND  
				( fadpedid.dped_no_pedido = :ls_pedido ) AND  
				( fadpedid.dped_ann = :ll_anio )   AND
				( fadpedid.dped_linea = :ll_lin_ref ) ;
					
				If sqlca.sqlcode = -1  then
					str_desglose.devuelve='0'
					ls_error =sqlca.sqlerrtext
					rollback using sqlca;
					mensaje("Error al actualizar cantidad reservada x L.Emp.  (fadpedid) ",ls_error,"")
					return
				End If

			  UPDATE fadempaq  
				  SET empa_cantidad = (empa_cantidad - :ld_cantidad)
				WHERE ( fadempaq.empa_g_financiero = :str.g_financiero ) AND  
						( fadempaq.empa_empresa = :str.empresa ) AND  
						( fadempaq.empa_lista_empaque = :ls_lista_emp ) AND  
						( fadempaq.empa_ann = :ll_ann_emp) AND  
						( fadempaq.empa_linea = :li_linea_emp )  ;
				If sqlca.sqlcode = -1  then
					str_desglose.devuelve='0'
					ls_error =sqlca.sqlerrtext
					rollback using sqlca;
					mensaje("Error al actualizar cantidad asignada  (fadempaq) ",ls_error,"")
					return
				End If

				str_desglose.devuelve='1'
			end if
			
		If dw_2.GetItemString(ll_row,'actua_tpedido') ='S' then
			
			  UPDATE fadpedid  
		  SET dped_cantidad = (dped_cantidad - :ld_libera_ped) 
		WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
				( fadpedid.dped_empresa = :str.empresa ) AND  
				( fadpedid.dped_no_pedido = :ls_pedido ) AND  
				( fadpedid.dped_ann = :ll_anio )   AND
				( fadpedid.dped_linea = :ll_lin_ref ) ;
					
				If sqlca.sqlcode = -1  then
					str_desglose.devuelve='0'
					ls_error =sqlca.sqlerrtext
					rollback using sqlca;
					mensaje("Error al actualizar pendiente total pedido  (fadpedid) ",ls_error,"")
					return
				End If
				str_desglose.devuelve='1'
			end if			

	Next
	if str_desglose.devuelve='1' then
		commit;
	end if 
	parent.triggerevent("close")

else
	messagebox('Atención','Si desea liberar y/o reservar, debe seleccionar los registros ....!!')
	parent. triggerevent('ue_post_open')
end if

end event

type cb_2 from commandbutton within w_fa_man_libera_reserva_pend_cb
integer x = 2267
integer y = 1104
integer width = 325
integer height = 88
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
boolean default = true
end type

event clicked;str_desglose.devuelve='0'

parent.postevent("close")

end event

type st_1 from statictext within w_fa_man_libera_reserva_pend_cb
integer x = 1911
integer y = 1096
integer width = 338
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within w_fa_man_libera_reserva_pend_cb
integer x = 2263
integer y = 1100
integer width = 329
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

