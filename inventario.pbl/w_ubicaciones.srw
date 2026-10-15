//objectcomments Ventana para la Captura de Transferencia de Mercancia
forward
global type w_ubicaciones from w_fa_padre
end type
type cb_2 from commandbutton within w_ubicaciones
end type
type pb_1 from picturebutton within w_ubicaciones
end type
type uo_1 from u_ddcalen within w_ubicaciones
end type
type dw_2 from datawindow within w_ubicaciones
end type
type dw_3 from datawindow within w_ubicaciones
end type
type dw_4 from datawindow within w_ubicaciones
end type
type dw_5 from datawindow within w_ubicaciones
end type
type dw_6 from datawindow within w_ubicaciones
end type
type dw_7 from datawindow within w_ubicaciones
end type
end forward

global type w_ubicaciones from w_fa_padre
integer x = 0
integer y = 0
integer width = 6359
integer height = 1932
string title = "Mantenimiento de Ubicaciones de Producto"
string menuname = "m_fa_principal"
long backcolor = 12632256
windowanimationstyle openanimation = bottomroll!
windowanimationstyle closeanimation = bottomroll!
event ue_syscommand pbm_syscommand
event ue_aceptar_por_linea ( )
cb_2 cb_2
pb_1 pb_1
uo_1 uo_1
dw_2 dw_2
dw_3 dw_3
dw_4 dw_4
dw_5 dw_5
dw_6 dw_6
dw_7 dw_7
end type
global w_ubicaciones w_ubicaciones

type variables
integer ii_ann, datawindow, il_row, ii_cantidad_unidad, ii_cantidad_empaque, ii_bodegas_definidas
String  is_entrada, is_unidad_empaque, is_actualiza, is_bodega_ubica_compra, is_concepto, is_documento
date	  idt_desde, idt_hasta
long    il_tiempo, il_segundos, il_secuencia, il_empaque, il_ajuste, il_entrada
decimal{4} id_peso, id_cubicaje, id_costo
datawindowchild idwc_producto_destino
str_in_parametros str_in
end variables

forward prototypes
public function boolean wf_orden_nueva ()
public function boolean wf_recupera ()
public function boolean wf_ajuste_nuevo ()
end prototypes

event ue_syscommand;call super::ue_syscommand;if commandtype = 61536 then
	close(this)
end if
end event

public function boolean wf_orden_nueva ();long ll_max
integer li_ann

li_ann = year(date(gf_fecha_serv()))

select max(tmov_secuencia)
into	:ll_max
from intranfer
where tmov_g_financiero = :str.g_financiero and
		tmov_empresa		= :str.empresa and
		tmov_anual				= :li_ann and
		tmov_tipo_transaccion = 'TR';
	if sqlca.sqlcode = -1  then
		gf_mensaje('','Error al Buscar Secuencia '+sqlca.sqlerrtext,1,1,'E')		
		return false
	end if
	
	if isnull(ll_max) then ll_max = 0
	
	ll_max ++
	
	dw_1.setitem(1,'tmov_secuencia',ll_max)
	
	il_secuencia = ll_max
return true
end function

public function boolean wf_recupera ();//long ll_fila, ll_recuperados
//
//str.frame.setmicrohelp('Espere mientras se recuperan los registros...')
//
//ll_fila = dw_1.getrow()
//
//ll_recuperados = dw_1.retrieve(str.g_financiero, str.empresa, idt_desde, idt_hasta)
//if ll_recuperados > ll_fila then
//	dw_1.scrolltorow(ll_fila)
//end if
//
//il_segundos = 0
//
//str.frame.setmicrohelp('Bodegas Wireless Backoffice')
//
return true
end function

public function boolean wf_ajuste_nuevo ();long ll_max
integer li_ann

li_ann = year(date(gf_fecha_serv()))

select max(tmov_secuencia)
into	:ll_max
from intmovim
where tmov_g_financiero = :str.g_financiero and
		tmov_empresa		= :str.empresa and
		tmov_anual				= :li_ann and
		tmov_tipo_transaccion = 'AE';
	if sqlca.sqlcode = -1  then
		gf_mensaje('','Error al Buscar Secuencia '+sqlca.sqlerrtext,1,1,'E')		
		return false
	end if
	
	if isnull(ll_max) then ll_max = 0
	
	ll_max ++
		
	il_ajuste = ll_max

return true
end function

on w_ubicaciones.create
int iCurrent
call super::create
if this.MenuName = "m_fa_principal" then this.MenuID = create m_fa_principal
this.cb_2=create cb_2
this.pb_1=create pb_1
this.uo_1=create uo_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.dw_5=create dw_5
this.dw_6=create dw_6
this.dw_7=create dw_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.dw_4
this.Control[iCurrent+7]=this.dw_5
this.Control[iCurrent+8]=this.dw_6
this.Control[iCurrent+9]=this.dw_7
end on

on w_ubicaciones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_2)
destroy(this.pb_1)
destroy(this.uo_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.dw_6)
destroy(this.dw_7)
end on

event ue_post_open;//override
string ls_cadena, ls_b1, ls_b2, ls_b3, ls_b4, ls_b5, ls_b6, ls_b7
integer i
ii_ann = year(date(gf_fecha_serv()))
datawindow = 1

  SELECT dgmempre.empr_bodegas_definidas,   
         dgmempre.empr_bodega1,   
         dgmempre.empr_bodega2,   
         dgmempre.empr_bodega3,   
         dgmempre.empr_bodega4,   
         dgmempre.empr_bodega5,   
         dgmempre.empr_bodega6,   
         dgmempre.empr_bodega7  
    INTO :ii_bodegas_definidas,   :ls_b1,   :ls_b2,   :ls_b3,   :ls_b4,   :ls_b5,   :ls_b6,   :ls_b7  
    FROM dgmempre  
   WHERE ( dgmempre.empr_g_financiero = :str.g_financiero ) AND  
         ( dgmempre.empr_empresa = :str.empresa )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Buscar Bodegas '+sqlca.sqlerrtext,1,1,'E')
		end if

if ii_bodegas_definidas >= 1 then
	dw_1.settransobject(sqlca);			
	dw_1.retrieve(str.g_financiero, str.empresa,'1')
	dw_1.modify('bodega_1.text="'+ls_b1+'"')
end if

if ii_bodegas_definidas >= 2 then
	dw_2.settransobject(sqlca);			
	dw_2.retrieve(str.g_financiero, str.empresa,'2')
	dw_2.modify('bodega_1.text="'+ls_b2+'"')
	dw_2.visible = true
end if

if ii_bodegas_definidas >= 3 then
	dw_3.settransobject(sqlca);			
	dw_3.retrieve(str.g_financiero, str.empresa,'3')
	dw_3.modify('bodega_1.text="'+ls_b3+'"')
	dw_3.visible = true
end if

if ii_bodegas_definidas >= 4 then
	dw_4.settransobject(sqlca);			
	dw_4.retrieve(str.g_financiero, str.empresa,'4')
	dw_4.modify('bodega_1.text="'+ls_b4+'"')
	dw_4.visible = true	
end if

if ii_bodegas_definidas >= 5 then
	dw_5.settransobject(sqlca);			
	dw_5.retrieve(str.g_financiero, str.empresa,'5')
	dw_5.modify('bodega_1.text="'+ls_b5+'"')
	dw_5.visible = true	
end if

if ii_bodegas_definidas >= 6 then
	dw_6.settransobject(sqlca);			
	dw_6.retrieve(str.g_financiero, str.empresa,'6')
	dw_6.modify('bodega_1.text="'+ls_b6+'"')
	dw_6.visible = true	
end if

if ii_bodegas_definidas >= 7 then
	dw_7.settransobject(sqlca);			
	dw_7.retrieve(str.g_financiero, str.empresa,'7')
	dw_7.modify('bodega_1.text="'+ls_b7+'"')
	dw_7.visible = true	
end if



end event

event ue_pre_aceptar;//Override
dw_1.Accepttext()

this.postevent("ue_aceptar")

end event

event ue_adicionar;////Override
//
//if datawindow = 1 then	
//	dw_1.reset()
//	dw_2.reset()
//	dw_1.insertrow(1)
//	//Pone invisible el insertar	
//	dw_1.setitem(1,'tmov_g_financiero',str.g_financiero)
//	dw_1.setitem(1,'tmov_empresa',str.empresa)
//	dw_1.setitem(1,'tmov_autoriza',str.usuario)	
//	dw_1.setitem(1,'tmov_id',str.usuario)		
//	dw_1.setitem(1,'tmov_anual',ii_ann)
//	dw_1.setitem(1,'tmov_fecha',date(gf_fecha_serv()))
//	dw_1.setfocus()
//	dw_1.setcolumn('tmov_documento')
//	wf_orden_nueva()
//else
//	if dw_2.getrow() > 0 then	
//		idwc_producto_destino.insertrow(1)
//		if dw_2.getitemstring(dw_2.getrow(), 'dmov_producto') <> '' or &
//			not isnull(dw_2.getitemstring(dw_2.getrow(), 'dmov_producto')) then
//			dw_2.scrolltorow(dw_2.insertrow(0))
//			dw_2.setitem(dw_2.getrow(),'dmov_g_financiero',str.g_financiero)
//			dw_2.setitem(dw_2.getrow(),'dmov_empresa',str.empresa)
//			dw_2.setitem(dw_2.getrow(),'dmov_aplicacion','IN')
//			dw_2.setitem(dw_2.getrow(),'dmov_tipo_transaccion','TR')
//			dw_2.setitem(dw_2.getrow(),'dmov_concepto',is_concepto)
//			dw_2.setitem(dw_2.getrow(),'dmov_documento',is_documento)			
//		end if
//	else
//		idwc_producto_destino.insertrow(1)
//		dw_2.scrolltorow(dw_2.insertrow(0))
//		dw_2.setitem(dw_2.getrow(),'dmov_g_financiero',str.g_financiero)
//		dw_2.setitem(dw_2.getrow(),'dmov_empresa',str.empresa)
//		dw_2.setitem(dw_2.getrow(),'dmov_aplicacion','IN')
//		dw_2.setitem(dw_2.getrow(),'dmov_tipo_transaccion','TR')
//		dw_2.setitem(dw_2.getrow(),'dmov_concepto',is_concepto)		
//		dw_2.setitem(dw_2.getrow(),'dmov_documento',is_documento)					
//	end if
//	dw_2.setfocus()
//		if pos(str.empr_acceso_especial, 'HPSA') > 0 then
//			dw_2.setcolumn('dmov_modelo')
//		else
//			dw_2.setcolumn('dmov_producto')
//		end if
//end if
//
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
//dw_2.width = newwidth - 100
dw_1.height= newheight - 100
dw_2.height= newheight - 100
dw_3.height= newheight - 100
dw_4.height= newheight - 100
dw_5.height= newheight - 100
dw_6.height= newheight - 100
dw_7.height= newheight - 100
end event

event open;//override
gf_acelerador()
dw = dw_1

This.Icon = str.icono

this.postevent("ue_post_open")

This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)
this.y = 0
this.x = 805
this.height = w_fa_fondo.height - 50

str.frame.SetRedraw ( True )
end event

event ue_print;////override
string ls_expresion
dw_4.settransobject(sqlca)
if il_secuencia = 0 then return
dw_4.retrieve(str.g_financiero, str.empresa, il_secuencia , ii_ann)
//
if dw_4.rowcount() = 0 then return
//
ls_expresion = str.nombre_empresa
dw_4.object.nom_empresa.expression = "'"+ls_expresion+"'"

dw_4.object.datawindow.print.preview = 'yes'
dw_4.object.datawindow.print.preview.zoom = 100
dw_4.visible = true
//
OpenWithParm(w_dw_print_options, dw_4)
//
If Message.DoubleParm = -1 Then Return
dw_4.Print(True)

end event

event ue_aceptar;//integer  li_contador,ll_update,ll_update2,li_encontro,li_lin_ref,li_posicion,li_frac2, li_find
//integer  li_costo,anulado=0,li_linea_uno,li_linea_dos,indice, li_existe_detalle, li_empresa ,li_salvar
//decimal  li_cantidad,li_cantid, li_cos_tran
//datetime ldt_fecha,ldt_fecha_real
//string   ls_documento,ls_aplic,ls_tipo,ls_medida,ls_producto,ls_concepto, fila, ls_conc,ls_error,ls_cuenta, ls_expresion, ls_doc
//Long		ll_found, ll_ann,ll_secuencia
//boolean  lb_existe
//
//dw_1.acceptText()
////dw=dw_1  
//
//if dw_1.getitemnumber(1, 'tmov_estado') <> 0 then
//	gf_mensaje('','La Transferencia ya fue Actualizada, Verifique !!!',1,1,'E')
//	return
//end if
//
//sqlca.autocommit = false
//
//indice = 0
//
//il_secuencia = dw_1.getitemNumber(1,"tmov_secuencia")
//
///*grabamos los datos del DW_1 de la tabla de INTMOVIM*////////////////
//if dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = New! or &
//	dw_1.GetItemStatus(dw_1.getrow(),0,primary! ) = NewModified! then 	
//	
//	//ll_secuencia = wf_buscar_secuencia() //buscamos la secuencia de dgmserie//
////	wf_buscar_secuencia(ll_secuencia)
//   indice = 1
//	
////	//Si no se ha creado la orden, crea una nueva
////	if not wf_valida_exis(ls_documento) then
////		if pos(is_secuencia,'-') = 0 then
////			ii_secuencia = 0
////			wf_buscar_secuencia(ii_secuencia) 
////			if ii_secuencia <> -1 then
////				is_secuencia  = is_inicial+"-"+string(ii_secuencia)
////				dw_1.setitem(1,"no_orden", is_secuencia )
////			end if
////		end if
////	end if
////
////	dw_1.setitem(1,'no_orden',string(ll_secuencia))
//	
//	if (dw_1.getitemNumber(1,"tmov_secuencia")) = 0 or isnull(dw_1.getitemNumber(1,"tmov_secuencia")) then
//		mensaje("Atencion Sr. Usuario","Debe Asignar un valor valido, Verifique.","")
//		sqlca.autocommit = true
//		return
//	end if	
//	/*Actualiza el Encabezado*/
//	ll_update = dw_1.update()
//	
//	/*Actualiza la Secuencia en Dgmserie*/
//	if ll_update =1 then
//		 commit using sqlca;
//	else
//		ls_error =sqlca.sqlerrtext
//		rollback using sqlca;
//		sqlca.autocommit = true
//		gf_Mensaje("---Atención---","¡Error al Actualizar el encabezado !" +ls_error,1,1,'E')
//		ib_aceptar = False
//		is_actualiza=''
//		return
//	end if
//	 sqlca.autocommit = true
//	 
////	if ll_secuencia <> ii_secuencia then
////		 messagebox('Atención ',' La Secuencia ha Cambiado a: '+string(ll_secuencia))
////	end if
//	/**/
//else
//	ll_update = dw_1.update()
//  if ll_update = 1 then
//		commit;
//		sqlca.autocommit = true
//	else
//		ls_error =sqlca.sqlerrtext
//		rollback using sqlca;
//		sqlca.autocommit = true
//		ib_aceptar = False
//		gf_Mensaje("---Atención---","¡Error al Actualizar el encabezado !"+ls_error,1,1,'E')
//		is_actualiza=''
//		return
//	end if
////	ll_secuencia = long(dw_1.getitemstring(1,'no_orden'))
//end if
//
//sqlca.autocommit = false
//
///*grabamos los datos de DW_2 en la tabla INDTRANS*/
//dwItemStatus ls_status
//
//// Borra registros en blanco
//sqlca.autocommit = true
////mensaje('Informacion','Actualizacion Exitosa','')
//is_actualiza=''
//
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

	lstr_df.texto_campo [1,1] = "intranfer.tmov_secuencia"
	lstr_df.texto_campo [1,2] = "Secuencia"
	lstr_df.texto_campo [1,3] = "tmov_secuencia"
	lstr_df.texto_campo [1,4] = 'V'
	lstr_df.texto_campo [1,5] = '280'	
	lstr_df.texto_campo [2,1] = "intranfer.tmov_documento"
	lstr_df.texto_campo [2,2] = "Documento"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '350'
	lstr_df.texto_campo [3,1] = "intranfer.tmov_fecha"
	lstr_df.texto_campo [3,2] = "Fecha"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [3,5] = '270'
	lstr_df.texto_campo [4,1] = "intranfer.tmov_comentario"
	lstr_df.texto_campo [4,2] = "Observacion"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '670'
	lstr_df.tabla = " intranfer "
		
	lstr_df.tabla_where = &
				"WHERE (intranfer.tmov_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(intranfer.tmov_empresa = " + string(str.empresa) + ") 	and " +&
 						 "(intranfer.tmov_anual = " + string(ii_ann) + ") 	and " +&
						 "(intranfer.tmov_tipo_transaccion = 'TR' )"
	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm



If len (ls_find) = 0 Then Return
	
ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)
il_secuencia = long(ls_codigo)
if dw_1.retrieve(str.g_financiero, str.empresa, il_secuencia, ii_ann ) > 0 then
	is_concepto = dw_1.getitemstring(1,'tmov_concepto')
	is_documento = dw_1.getitemstring(1,'tmov_documento')	
end if

dw_2.reset()
dw_2.retrieve(str.g_financiero, str.empresa, il_secuencia, ii_ann )
dw_2.scrolltorow(dw_2.rowcount())
dw_2.setfocus()
end event

event ue_eliminar;//override
if datawindow = 1 then	
	if dw_1.getitemnumber(1,'tmov_estado') <> 0 then
		gf_mensaje('','No Puede Eliminar una Transferencia Actualizada, Verifique !!!',1,1,'E')
		return
	end if
	if gf_mensaje('','Esta Seguro de Eliminar la Transferencia ?',2,2,'E') = 1 then
		sqlca.autocommit = false
	  DELETE FROM indtranfer  
		WHERE ( indtranfer.dmov_g_financiero = :str.g_financiero ) AND  
				( indtranfer.dmov_empresa = :str.empresa ) AND  
				( indtranfer.dmov_aplicacion = 'IN' ) AND  
				( indtranfer.dmov_tipo_transaccion = 'TR' ) AND  
				( indtranfer.dmov_secuencia = :il_secuencia ) AND  
				( indtranfer.dmov_anual = :ii_ann )  ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al eliminar detalle ' + sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if
	
	  DELETE FROM intranfer  
		WHERE ( intranfer.tmov_g_financiero = :str.g_financiero ) AND  
				( intranfer.tmov_empresa = :str.empresa ) AND  
				( intranfer.tmov_aplicacion = 'IN' ) AND  
				( intranfer.tmov_tipo_transaccion = 'TR' ) AND  
				( intranfer.tmov_secuencia = :il_secuencia ) AND  
				( intranfer.tmov_anual = :ii_ann )  ;
	
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al eliminar encabezado ' + sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if
			commit;
			sqlca.autocommit = true
			this.triggerevent('ue_adicionar')			
	end if
else
	if dw_2.rowcount() > 0 then
		dw_2.deleterow(dw_2.getrow())
	else 
		messagebox("Atención","No hay registros para borrar!")
	end if
end if
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_ubicaciones
boolean visible = false
integer x = 46
integer y = 2040
integer width = 101
string text = ""
end type

type dw_1 from w_fa_padre`dw_1 within w_ubicaciones
event ue_escape pbm_dwescape
integer x = 32
integer y = 24
integer width = 869
integer height = 1656
integer taborder = 10
string dataobject = "dw_ubicaciones_productos"
boolean vscrollbar = true
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
this.accepttext()
if dwo.name = 'b_adicionar' then
	if this.getitemstring(this.rowcount(),'ubic_ubicacion') <> '' and this.getitemstring(this.rowcount(),'ubic_descripcion') <> '' then
		this.scrolltorow(this.insertrow(0))
		this.setitem(this.getrow(),'ubic_g_financiero',str.g_financiero)
		this.setitem(this.getrow(),'ubic_empresa',str.empresa)	
		this.setitem(this.getrow(),'ubic_bodega','1')	
		this.setcolumn('ubic_ubicacion')
	end if
elseif dwo.name = 'b_guardar' then
	if dw_1.update() = -1 then
		gf_mensaje('','Error al Guardar Bodega 1 '+sqlca.sqlerrtext,1,1,'E')
		rollback;
	else
		commit;
	end if
end if
end event

event dw_1::clicked;call super::clicked;datawindow = 1
accepttext()
date 	ld_date,ld_ini_date, ld_hoy
ld_hoy = date(gf_fecha_serv())
if dwo.name='calendario' then
	ld_ini_date=date(dw_1.GetItemDateTime(dw_1.getrow(),"tmov_fecha"))
	if year(ld_ini_date) = 1900 then
		ld_ini_date = ld_hoy
	end if
	if uo_1.visible=false then
		uo_1.wf_set_value(ld_ini_date)
		uo_1.visible=true
		uo_1.allow_close=false
		uo_1.inicializar()
		uo_1.TriggerEvent('ue_abrir')
	end if
end if
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;datawindow = 1
end event

event dw_1::itemchanged;call super::itemchanged;accepttext()
choose case this.getcolumnname()
	case 'tmov_concepto'
		is_concepto = data
	case 'tmov_documento'
		is_documento = data
	case 'tmov_anual'
		ii_ann = integer(data)
end choose
end event

type st_ayuda from w_fa_padre`st_ayuda within w_ubicaciones
integer x = 2793
integer y = 636
end type

type cb_2 from commandbutton within w_ubicaciones
boolean visible = false
integer x = 2990
integer y = 48
integer width = 439
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "ACTUALIZAR"
end type

event clicked;string ls_documento, ls_entrada, ls_comentario, ls_bodega, ls_bodega_destino, ls_producto
integer i, li_linea, li_fila
decimal ld_costo_fob, ld_costo_cif, ld_costo_promedio

if dw_2.rowcount() = 0 then return

if dw_1.getitemnumber(1,'tmov_estado') <> 0 then
	gf_mensaje('','La Transferencia ya fue Actualizada, Verifique !!!',1,1,'E')
	return
end if

if gf_mensaje('','Esta seguro de actualizar la Transferencia ?',2,1,'E') = 2 then return

  parent.triggerevent('ue_aceptar')

  sqlca.autocommit = false
//  wf_ajuste_nuevo()
  ls_documento = dw_1.getitemstring(1,'tmov_documento')
  
//  if dw_2.getitemstring(1,'indtranfer_dmov_producto_destino') = '' or isnull(dw_2.getitemstring(1,'indtranfer_dmov_producto_destino')) then
//	gf_mensaje('','Debe asignar el producto destino, Verifique!!!',1,1,'E')
//	dw_2.setcolumn('indtranfer_dmov_producto_destino')
//	return
//  end if
  
  ls_comentario = 'TRANSFERENCIA - BODEGA' //	dw_2.getitemstring(1,'dmov_producto')+' A ' +dw_2.getitemstring(1,'indtranfer_dmov_producto_destino')
 
  //Inserta en Inventarios como ajuste negativo
    INSERT INTO intmovim  
         ( tmov_g_financiero,   
           tmov_empresa,   
           tmov_aplicacion,   
           tmov_tipo_transaccion,   
           tmov_secuencia,   
           tmov_concepto,   
           tmov_anual,   
           tmov_descripcion,   
           tmov_fecha,   
           tmov_autoriza,   
           tmov_documento,   
           tmov_terceros,   
           tmov_comentario,   
           tmov_tipo_costo,   
           tmov_id,   
           tmov_tipo,   
           tmov_estado,   
           tmov_anulado,   
           tmov_total_cargos,   
           tmov_fecha_actualizacion,   
           tmov_documento_entrada,   
           tmov_estado_costo,   
           tmov_forma_costeo,   
           tmov_tipo_trafico,   
           tmov_documento_comercial,   
           tmov_fecha_cierre_mensual,   
           tmov_cuenta,   
           tmov_nombre_tercero,   
           tmov_pase,   
           tmov_moneda,   
           tmov_cambio,   
           tmov_constante,   
           tmov_descuento,   
           tmov_tipo_gasto,   
           tmov_por_admin,   
           tmov_no_pedido,   
           tmov_precio_base,   
           tmov_pasada_a_empresa,   
           tmov_rebaja_reserva,   
           tmov_marca,   
           tmov_descuento_subdeta,   
           tmov_itbm,   
           tmov_itbm_subdeta,   
           tmov_secuencia_actual,   
           tmov_centro_costo,   
           tmov_codigo_uso,   
           tmov_descuento_ncr,   
           tmov_tipo_movimiento )  
     SELECT intranfer.tmov_g_financiero,   
            intranfer.tmov_empresa,   
            intranfer.tmov_aplicacion,   
            intranfer.tmov_tipo_transaccion,    
            intranfer.tmov_secuencia,   
            intranfer.tmov_concepto,   
            intranfer.tmov_anual,   
            'TRANSFERENCIA - BODEGA',   
            intranfer.tmov_fecha,   
            intranfer.tmov_autoriza,   
            :ls_documento,    
            intranfer.tmov_terceros,   
            :ls_comentario,   
            intranfer.tmov_tipo_costo,   
            :str.usuario,   
            intranfer.tmov_tipo,   
            1,   
            0,   
            intranfer.tmov_total_cargos,   
            intranfer.tmov_fecha_actualizacion,   
            intranfer.tmov_documento_entrada,   
            intranfer.tmov_estado_costo,   
            intranfer.tmov_forma_costeo,   
            intranfer.tmov_tipo_trafico,   
            intranfer.tmov_documento_comercial,   
            intranfer.tmov_fecha_cierre_mensual,   
            intranfer.tmov_cuenta,   
            intranfer.tmov_nombre_tercero,   
            intranfer.tmov_pase,   
            intranfer.tmov_moneda,   
            intranfer.tmov_cambio,   
            intranfer.tmov_constante,   
            intranfer.tmov_descuento,   
            intranfer.tmov_tipo_gasto,   
            intranfer.tmov_por_admin,   
            intranfer.tmov_no_pedido,   
            intranfer.tmov_precio_base,   
            intranfer.tmov_pasada_a_empresa,   
            intranfer.tmov_rebaja_reserva,   
            intranfer.tmov_marca,   
            intranfer.tmov_descuento_subdeta,   
            intranfer.tmov_itbm,   
            intranfer.tmov_itbm_subdeta,   
            intranfer.tmov_secuencia_actual,   
            intranfer.tmov_centro_costo,   
            intranfer.tmov_codigo_uso,   
            intranfer.tmov_descuento_ncr,   
            intranfer.tmov_tipo_movimiento  
       FROM intranfer  
      WHERE ( intranfer.tmov_g_financiero = :str.g_financiero ) AND  
            ( intranfer.tmov_empresa = :str.empresa ) AND  
            ( intranfer.tmov_aplicacion = 'IN' ) AND  
            ( intranfer.tmov_tipo_transaccion = 'TR' ) AND  
            ( intranfer.tmov_secuencia = :il_secuencia ) AND  
            ( intranfer.tmov_anual = :ii_ann )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Actualizar Ajuste negativo '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			sqlca.autocommit = true
			return
		end if

li_linea = 0
for i = 1 to dw_2.rowcount()
	li_linea ++
	ls_producto = dw_2.getitemstring(i,'dmov_producto')
	li_fila			= dw_2.getitemNumber(i,'dmov_linea')
	ls_bodega   = dw_2.getitemstring(i,'dmov_bodega')
	ls_bodega_destino   = dw_2.getitemstring(i,'dmov_bodega_destino')
	
	if ls_bodega = ls_bodega_destino then
		gf_mensaje('','La Bodega de Salida debe ser diferente a la de Salida, Verifique !!!',1,1,'E')
		dw_2.scrolltorow(i)
		rollback;
		sqlca.autocommit = true
		return					
	end if
	
	  SELECT inmprodu.prod_costo_fob,   
				inmprodu.prod_costo_cif,   
				inmprodu.prod_costo_promedio  
		 INTO :ld_costo_fob,   
				:ld_costo_cif,   
				:ld_costo_promedio  
		 FROM inmprodu  
		WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
				( inmprodu.prod_empresa = :str.empresa ) AND  
				( inmprodu.prod_producto = :ls_producto )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Buscar Costos '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			sqlca.autocommit = true
			return			
		end if
	
    INSERT INTO indmovim  
         ( dmov_g_financiero,   
           dmov_empresa,   
           dmov_aplicacion,   
           dmov_tipo_transaccion,   
           dmov_concepto,   
           dmov_secuencia,   
           dmov_anual,   
           dmov_linea,   
           dmov_documento,   
           dmov_linea_referencia,   
           dmov_bodega,   
           dmov_ubicacion,   
           dmov_producto,   
           dmov_cantidad,   
           dmov_cant1,   
           dmov_unidad_medida,   
           dmov_costo,   
           dmov_precio,   
           dmov_cubicaje,   
           dmov_peso,   
           dmov_bulto,   
           dmov_costo_cif,   
           dmov_cargos,   
           dmov_precio_ent,   
           dmov_id,   
           dmov_bodega_destino,   
           dmov_ubicacion_destino,   
           dmov_fabricante,   
           dmov_anulado,   
           dmov_id_precio,   
           dmov_fecha_agotado,   
           dmov_existe_detalle,   
           dmov_num_orden,   
           dmov_comentarios,   
           dmov_clave,   
           dmov_costo_fob,   
           dmov_precio1,   
           dmov_precio2,   
           dmov_precio3,   
           dmov_secuencia_ea,   
           dmov_terceros_ea,   
           dmov_numpo_ea,   
           dmov_board,   
           dmov_color,   
           dmov_porcentaje_gasto,   
           dmov_lote,   
           dmov_descuento,   
           dmov_itbm,   
           dmov_precio_descuento,   
           dmov_descuento_ncr,   
           dmov_monto_final,   
           dmov_costo_promedio )  
     SELECT indtranfer.dmov_g_financiero,   
            indtranfer.dmov_empresa,   
            indtranfer.dmov_aplicacion,   
            indtranfer.dmov_tipo_transaccion,   
            indtranfer.dmov_concepto,   
            indtranfer.dmov_secuencia,   
            indtranfer.dmov_anual,   
            :li_linea,   
            :ls_documento,   
            indtranfer.dmov_linea_referencia,   
            :ls_bodega,   
            indtranfer.dmov_ubicacion,   
            indtranfer.dmov_producto,   
            - indtranfer.dmov_cantidad,   
            indtranfer.dmov_cant1,   
            indtranfer.dmov_unidad_medida,   
            indtranfer.dmov_costo,   
            indtranfer.dmov_precio,   
            indtranfer.dmov_cubicaje,   
            indtranfer.dmov_peso,   
            indtranfer.dmov_bulto,   
            :ld_costo_cif,   
            indtranfer.dmov_cargos,   
            indtranfer.dmov_precio_ent,   
            indtranfer.dmov_id,   
            :ls_bodega_destino,   
            indtranfer.dmov_ubicacion_destino,   
            indtranfer.dmov_fabricante,   
            indtranfer.dmov_anulado,   
            indtranfer.dmov_id_precio,   
            indtranfer.dmov_fecha_agotado,   
            indtranfer.dmov_existe_detalle,   
            indtranfer.dmov_num_orden,   
            indtranfer.dmov_comentarios,   
            indtranfer.dmov_clave,   
            :ld_costo_fob,   
            indtranfer.dmov_precio1,   
            indtranfer.dmov_precio2,   
            indtranfer.dmov_precio3,   
            indtranfer.dmov_secuencia_ea,   
            indtranfer.dmov_terceros_ea,   
            indtranfer.dmov_numpo_ea,   
            indtranfer.dmov_board,   
            indtranfer.dmov_color,   
            indtranfer.dmov_porcentaje_gasto,   
            indtranfer.dmov_lote,   
            indtranfer.dmov_descuento,   
            indtranfer.dmov_itbm,   
            indtranfer.dmov_precio_descuento,   
            indtranfer.dmov_descuento_ncr,   
            indtranfer.dmov_monto_final,   
            :ld_costo_promedio  
       FROM indtranfer  
      WHERE ( indtranfer.dmov_g_financiero = :str.g_financiero ) AND  
            ( indtranfer.dmov_empresa = :str.empresa ) AND  
            ( indtranfer.dmov_aplicacion = 'IN' ) AND  
            ( indtranfer.dmov_tipo_transaccion = 'TR' ) AND  
            ( indtranfer.dmov_secuencia = :il_secuencia ) AND  
            ( indtranfer.dmov_anual = :ii_ann )  AND
		   ( indtranfer.dmov_linea = :li_fila )	;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Actualizar Ajuste negativo '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			sqlca.autocommit = true
			return
		end if

	li_linea ++

    INSERT INTO indmovim  
         ( dmov_g_financiero,   
           dmov_empresa,   
           dmov_aplicacion,   
           dmov_tipo_transaccion,   
           dmov_concepto,   
           dmov_secuencia,   
           dmov_anual,   
           dmov_linea,   
           dmov_documento,   
           dmov_linea_referencia,   
           dmov_bodega,   
           dmov_ubicacion,   
           dmov_producto,   
           dmov_cantidad,   
           dmov_cant1,   
           dmov_unidad_medida,   
           dmov_costo,   
           dmov_precio,   
           dmov_cubicaje,   
           dmov_peso,   
           dmov_bulto,   
           dmov_costo_cif,   
           dmov_cargos,   
           dmov_precio_ent,   
           dmov_id,   
           dmov_bodega_destino,   
           dmov_ubicacion_destino,   
           dmov_fabricante,   
           dmov_anulado,   
           dmov_id_precio,   
           dmov_fecha_agotado,   
           dmov_existe_detalle,   
           dmov_num_orden,   
           dmov_comentarios,   
           dmov_clave,   
           dmov_costo_fob,   
           dmov_precio1,   
           dmov_precio2,   
           dmov_precio3,   
           dmov_secuencia_ea,   
           dmov_terceros_ea,   
           dmov_numpo_ea,   
           dmov_board,   
           dmov_color,   
           dmov_porcentaje_gasto,   
           dmov_lote,   
           dmov_descuento,   
           dmov_itbm,   
           dmov_precio_descuento,   
           dmov_descuento_ncr,   
           dmov_monto_final,   
           dmov_costo_promedio )  
     SELECT indtranfer.dmov_g_financiero,   
            indtranfer.dmov_empresa,   
            indtranfer.dmov_aplicacion,   
            indtranfer.dmov_tipo_transaccion,   
            indtranfer.dmov_concepto,   
            indtranfer.dmov_secuencia,   
            indtranfer.dmov_anual,   
            :li_linea,   
            :ls_documento,   
            indtranfer.dmov_linea_referencia,   
            :ls_bodega_destino,   
            indtranfer.dmov_ubicacion,   
            indtranfer.dmov_producto,   
            indtranfer.dmov_cantidad,   
            indtranfer.dmov_cant1,   
            indtranfer.dmov_unidad_medida,   
            indtranfer.dmov_costo,   
            indtranfer.dmov_precio,   
            indtranfer.dmov_cubicaje,   
            indtranfer.dmov_peso,   
            indtranfer.dmov_bulto,   
            :ld_costo_cif,   
            indtranfer.dmov_cargos,   
            indtranfer.dmov_precio_ent,   
            indtranfer.dmov_id,   
            :ls_bodega,   
            indtranfer.dmov_ubicacion_destino,   
            indtranfer.dmov_fabricante,   
            indtranfer.dmov_anulado,   
            indtranfer.dmov_id_precio,   
            indtranfer.dmov_fecha_agotado,   
            indtranfer.dmov_existe_detalle,   
            indtranfer.dmov_num_orden,   
            indtranfer.dmov_comentarios,   
            indtranfer.dmov_clave,   
            :ld_costo_fob,   
            indtranfer.dmov_precio1,   
            indtranfer.dmov_precio2,   
            indtranfer.dmov_precio3,   
            indtranfer.dmov_secuencia_ea,   
            indtranfer.dmov_terceros_ea,   
            indtranfer.dmov_numpo_ea,   
            indtranfer.dmov_board,   
            indtranfer.dmov_color,   
            indtranfer.dmov_porcentaje_gasto,   
            indtranfer.dmov_lote,   
            indtranfer.dmov_descuento,   
            indtranfer.dmov_itbm,   
            indtranfer.dmov_precio_descuento,   
            indtranfer.dmov_descuento_ncr,   
            indtranfer.dmov_monto_final,   
            :ld_costo_promedio  
       FROM indtranfer  
      WHERE ( indtranfer.dmov_g_financiero = :str.g_financiero ) AND  
            ( indtranfer.dmov_empresa = :str.empresa ) AND  
            ( indtranfer.dmov_aplicacion = 'IN' ) AND  
            ( indtranfer.dmov_tipo_transaccion = 'TR' ) AND  
            ( indtranfer.dmov_secuencia = :il_secuencia ) AND  
            ( indtranfer.dmov_anual = :ii_ann )  AND
		   ( indtranfer.dmov_linea = :li_fila )	;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Actualizar Ajuste negativo '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			sqlca.autocommit = true
			return
		end if


next

  //Actualiza el Estado
  UPDATE intranfer  
     SET tmov_estado = 1  
   WHERE ( intranfer.tmov_g_financiero = :str.g_financiero ) AND  
         ( intranfer.tmov_empresa = :str.empresa ) AND  
         ( intranfer.tmov_aplicacion = 'IN' ) AND  
         ( intranfer.tmov_tipo_transaccion = 'TR' ) AND  
         ( intranfer.tmov_secuencia = :il_secuencia ) AND  
         ( intranfer.tmov_anual = :ii_ann )  ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Actualizar Transferencia '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			sqlca.autocommit = true			
			return
		end if
		dw_1.setitem(1,'tmov_estado',1)
		commit;
		
end event

type pb_1 from picturebutton within w_ubicaciones
boolean visible = false
integer x = 2994
integer y = 224
integer width = 425
integer height = 120
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
string pointer = "HyperLink!"
string text = "KARDEX"
boolean originalsize = true
end type

event clicked;		Window lw_child_v				
		string ls_producto
		str_kardex  str_opcion
		
			str_opcion.opcion_menu = 'MCP'
			str_opcion.opcion_ventana    = 'P'
			str_opcion.dwpantalla     = 'dw_in_mcp_prod_kard_1'
			str_opcion.dwreporte      = 'dw_in_mcp_prod_kard_2'
			str_opcion.titulo_ventana = 'Movimientos de Productos (Kardex)'
			
			if dw_2.rowcount() > 0 then
				ls_producto = dw_2.getitemstring(dw_2.getrow(),'dmov_producto')				
			end if
			
			str_opcion.kproducto=ls_producto
		
			window lw_win, lw_first
			lw_first = str.frame.GetFirstSheet()	
			lw_win = str.frame.GetNextSheet(lw_first)
				do while isvalid(lw_win)
					if lw_win.classname()  = "w_in_movi_prod_kardex" then
						//gf_mensaje('','Esta abierta  Dirigirse a DMC',1,1,'E')
						lw_win.BringToTop = TRUE
						w_in_movi_prod_kardex.wf_asignar(str_opcion.kproducto)
						return
					end if
					lw_win = str.frame.GetNextSheet(lw_win)					
				loop	
		
			OpenSheetWithParm(w_in_movi_prod_kardex,str_opcion,str.frame,2,Original!)		
				
end event

type uo_1 from u_ddcalen within w_ubicaciones
boolean visible = false
integer x = 1303
integer y = 124
integer taborder = 21
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;dw_1.SetItem ( dw_1.getrow(), 'tmov_fecha', uo_1.return_sel_date() )

if uo_1.allow_close then
	this.visible=false
	dw_1.SetFocus()
end if


end event

on uo_1.destroy
call u_ddcalen::destroy
end on

type dw_2 from datawindow within w_ubicaciones
boolean visible = false
integer x = 928
integer y = 24
integer width = 869
integer height = 1656
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ubicaciones_productos"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;long ll_codigo
integer li_encontro
this.accepttext()
if dwo.name = 'b_adicionar' then
	if this.getitemstring(this.rowcount(),'ubic_ubicacion') <> '' and this.getitemstring(this.rowcount(),'ubic_descripcion') <> '' then
		this.scrolltorow(this.insertrow(0))
		this.setitem(this.getrow(),'ubic_g_financiero',str.g_financiero)
		this.setitem(this.getrow(),'ubic_empresa',str.empresa)	
		this.setitem(this.getrow(),'ubic_bodega','2')	
		this.setcolumn('ubic_ubicacion')
	end if
elseif dwo.name = 'b_guardar' then
	if dw_2.update() = -1 then
		gf_mensaje('','Error al Guardar Bodega 1 '+sqlca.sqlerrtext,1,1,'E')
		rollback;
	else
		commit;
	end if
end if
end event

type dw_3 from datawindow within w_ubicaciones
boolean visible = false
integer x = 1815
integer y = 24
integer width = 869
integer height = 1656
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ubicaciones_productos"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;long ll_codigo
integer li_encontro
this.accepttext()
if dwo.name = 'b_adicionar' then
	if this.getitemstring(this.rowcount(),'ubic_ubicacion') <> '' and this.getitemstring(this.rowcount(),'ubic_descripcion') <> '' then
		this.scrolltorow(this.insertrow(0))
		this.setitem(this.getrow(),'ubic_g_financiero',str.g_financiero)
		this.setitem(this.getrow(),'ubic_empresa',str.empresa)	
		this.setitem(this.getrow(),'ubic_bodega','3')	
		this.setcolumn('ubic_ubicacion')
	end if
elseif dwo.name = 'b_guardar' then
	if dw_3.update() = -1 then
		gf_mensaje('','Error al Guardar Bodega 1 '+sqlca.sqlerrtext,1,1,'E')
		rollback;
	else
		commit;
	end if
end if
end event

type dw_4 from datawindow within w_ubicaciones
boolean visible = false
integer x = 2706
integer y = 24
integer width = 869
integer height = 1656
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ubicaciones_productos"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;long ll_codigo
integer li_encontro
this.accepttext()
if dwo.name = 'b_adicionar' then
	if this.getitemstring(this.rowcount(),'ubic_ubicacion') <> '' and this.getitemstring(this.rowcount(),'ubic_descripcion') <> '' then
		this.scrolltorow(this.insertrow(0))
		this.setitem(this.getrow(),'ubic_g_financiero',str.g_financiero)
		this.setitem(this.getrow(),'ubic_empresa',str.empresa)	
		this.setitem(this.getrow(),'ubic_bodega','4')	
		this.setcolumn('ubic_ubicacion')
	end if
elseif dwo.name = 'b_guardar' then
	if dw_4.update() = -1 then
		gf_mensaje('','Error al Guardar Bodega 1 '+sqlca.sqlerrtext,1,1,'E')
		rollback;
	else
		commit;
	end if
end if
end event

type dw_5 from datawindow within w_ubicaciones
boolean visible = false
integer x = 3598
integer y = 24
integer width = 869
integer height = 1656
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ubicaciones_productos"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;long ll_codigo
integer li_encontro
this.accepttext()
if dwo.name = 'b_adicionar' then
	if this.getitemstring(this.rowcount(),'ubic_ubicacion') <> '' and this.getitemstring(this.rowcount(),'ubic_descripcion') <> '' then
		this.scrolltorow(this.insertrow(0))
		this.setitem(this.getrow(),'ubic_g_financiero',str.g_financiero)
		this.setitem(this.getrow(),'ubic_empresa',str.empresa)	
		this.setitem(this.getrow(),'ubic_bodega','5')	
		this.setcolumn('ubic_ubicacion')
	end if
elseif dwo.name = 'b_guardar' then
	if dw_5.update() = -1 then
		gf_mensaje('','Error al Guardar Bodega 1 '+sqlca.sqlerrtext,1,1,'E')
		rollback;
	else
		commit;
	end if
end if
end event

type dw_6 from datawindow within w_ubicaciones
boolean visible = false
integer x = 4489
integer y = 24
integer width = 869
integer height = 1656
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ubicaciones_productos"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;long ll_codigo
integer li_encontro
this.accepttext()
if dwo.name = 'b_adicionar' then
	if this.getitemstring(this.rowcount(),'ubic_ubicacion') <> '' and this.getitemstring(this.rowcount(),'ubic_descripcion') <> '' then
		this.scrolltorow(this.insertrow(0))
		this.setitem(this.getrow(),'ubic_g_financiero',str.g_financiero)
		this.setitem(this.getrow(),'ubic_empresa',str.empresa)	
		this.setitem(this.getrow(),'ubic_bodega','6')	
		this.setcolumn('ubic_ubicacion')
	end if
elseif dwo.name = 'b_guardar' then
	if dw_6.update() = -1 then
		gf_mensaje('','Error al Guardar Bodega 1 '+sqlca.sqlerrtext,1,1,'E')
		rollback;
	else
		commit;
	end if
end if
end event

type dw_7 from datawindow within w_ubicaciones
boolean visible = false
integer x = 5381
integer y = 24
integer width = 869
integer height = 1656
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ubicaciones_productos"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;long ll_codigo
integer li_encontro
this.accepttext()
if dwo.name = 'b_adicionar' then
	if this.getitemstring(this.rowcount(),'ubic_ubicacion') <> '' and this.getitemstring(this.rowcount(),'ubic_descripcion') <> '' then
		this.scrolltorow(this.insertrow(0))
		this.setitem(this.getrow(),'ubic_g_financiero',str.g_financiero)
		this.setitem(this.getrow(),'ubic_empresa',str.empresa)	
		this.setitem(this.getrow(),'ubic_bodega','7')	
		this.setcolumn('ubic_ubicacion')
	end if
elseif dwo.name = 'b_guardar' then
	if dw_7.update() = -1 then
		gf_mensaje('','Error al Guardar Bodega 1 '+sqlca.sqlerrtext,1,1,'E')
		rollback;
	else
		commit;
	end if
end if
end event

