//objectcomments Ventana para la Captura de Entradas
forward
global type w_orden_compra_bk from w_fa_padre
end type
type dw_2 from datawindow within w_orden_compra_bk
end type
type dw_3 from datawindow within w_orden_compra_bk
end type
type dw_4 from datawindow within w_orden_compra_bk
end type
type cb_1 from commandbutton within w_orden_compra_bk
end type
type cb_2 from commandbutton within w_orden_compra_bk
end type
type cb_3 from commandbutton within w_orden_compra_bk
end type
type dw_5 from datawindow within w_orden_compra_bk
end type
end forward

global type w_orden_compra_bk from w_fa_padre
integer x = 0
integer y = 0
integer width = 5019
integer height = 2404
string title = "Captura de la Orden de Compra"
string menuname = "m_hs"
boolean controlmenu = false
long backcolor = 12639424
event ue_syscommand pbm_syscommand
event ue_aceptar_por_linea ( )
dw_2 dw_2
dw_3 dw_3
dw_4 dw_4
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
dw_5 dw_5
end type
global w_orden_compra_bk w_orden_compra_bk

type variables
integer ii_ann, datawindow, il_row, ii_cantidad_unidad, ii_cantidad_empaque
String  is_entrada, is_unidad_empaque, is_secuencia, is_actualiza
date	  idt_desde, idt_hasta
long    il_tiempo, il_segundos, il_secuencia, il_empaque
decimal{4} id_peso, id_cubicaje, id_costo

end variables

forward prototypes
public function boolean wf_recupera ()
public function boolean wf_orden_nueva ()
public subroutine wf_eliminar_detalle ()
public subroutine wf_eliminar_todo ()
end prototypes

event ue_syscommand;call super::ue_syscommand;if commandtype = 61536 then
	close(this)
end if
end event

public function boolean wf_recupera ();long ll_fila, ll_recuperados

str.frame.setmicrohelp('Espere mientras se recuperan los registros...')

ll_fila = dw_1.getrow()

ll_recuperados = dw_1.retrieve(str.g_financiero, str.empresa, idt_desde, idt_hasta)
if ll_recuperados > ll_fila then
	dw_1.scrolltorow(ll_fila)
end if

il_segundos = 0

str.frame.setmicrohelp('Bodegas Wireless Backoffice')

return true
end function

public function boolean wf_orden_nueva ();long ll_max
integer li_ann

li_ann = year(date(gf_fecha_serv()))

select max(convert(numeric(10), enca_secuencia))
into	:ll_max
from orden
where enca_g_financiero = :str.g_financiero and
		enca_empresa		= :str.empresa and
		enca_ann				= :li_ann ;
	if sqlca.sqlcode = -1  then
		gf_mensaje('','Error al Buscar Secuencia '+sqlca.sqlerrtext,1,1,'E')		
		return false
	end if
	
	if isnull(ll_max) then ll_max = 0
	
	ll_max ++
	
	dw_1.setitem(1,'enca_secuencia',string(ll_max))
	
	is_secuencia = string(ll_max)	
return true
end function

public subroutine wf_eliminar_detalle ();//Integer	numero
String	ls_error, ls_secuencia
//long	ll_row, ll_secuencia,ll_row1,ll_row2, max_linea = 0

sqlca.autocommit = false

dw_2.DeleteRow(dw_2.GetRow())	
//	

if dw_2.update() =1 then
	commit using sqlca;
	sqlca.autocommit = true
   //dw_2.retrieve(str.g_financiero, str.empresa, is_secuencia, ii_ann)	
else
	ls_error =sqlca.sqlerrtext
	rollback using sqlca;
	sqlca.autocommit = false
	gf_Mensaje("---Atención---","¡Error al eliminar ! "+ls_error,1,1,'E')
end if

end subroutine

public subroutine wf_eliminar_todo ();Integer    li_num_sec , li_linea , li_filas , li_contador,  li_empresa_des, li_costo_trans, li_anio
Long		ll_update,ll_secuencia
String 	ls_secuencia, ls_error
Boolean    lb_resp

sqlca.autocommit = false;

If dw_2.rowcount() > 0 Then
  DELETE FROM orden_detalle  
   WHERE ( orden_detalle.deta_g_financiero = :str.g_financiero ) AND  
         ( orden_detalle.deta_empresa = :str.empresa ) AND  
         ( orden_detalle.deta_secuencia = :is_secuencia ) AND  
         ( orden_detalle.deta_ann = :ii_ann )  ;	
	if sqlca.sqlcode = -1 then 
		ls_error = sqlca.sqlerrtext
		rollback ; 
		messagebox('Error al eliminar los Registros del Detalle de la Orden ','Error : '+ls_error)
		return  
	end if 

	/*************/	
	li_filas = dw_1.DeleteRow(dw_1.GetRow())  //eliminamos el encabezado del registro//
	
	If li_filas = -1 Then
		RollBack Using sqlca;
		MessageBox('Error en el Encabezado','Al Eliminar el Registro, Verifique',StopSign!)
		sqlca.autocommit = true
		return
	Else

		If dw_1.update() = 1 then
			Commit Using sqlca;
			dw_1.Reset()
			dw_2.Reset()
			This.TriggerEvent("ue_post_open")			
		else
			RollBack Using sqlca;
			MessageBox('Error en el Encabezado','Al Eliminar el Registro, Verifique',StopSign!)
		end if
	End If
/**/	
Else	/*Datawindow 2 no tiene detalle*/
	li_filas = dw_1.DeleteRow(dw_1.GetRow())  //eliminamos el encabezado del registro//
	
	If li_filas = -1 Then
		RollBack Using sqlca;
		MessageBox('Error','Al Eliminar el Registro de Encabezado, Verifique',StopSign!)
	Else
		
		If dw_1.update() = 1 then	
			Commit Using sqlca;
			MessageBox('Atención','Registro eliminado correctamente',Information!)
			dw_1.Reset()
			dw_2.Reset()
			This.TriggerEvent("ue_post_open")
		else
			RollBack Using sqlca;
			MessageBox('Error','Al Eliminar el Registro de Encabezado, Verifique',StopSign!)
		end if
	End If
End If
sqlca.autocommit = true;
end subroutine

on w_orden_compra_bk.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.dw_5=create dw_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.dw_4
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_3
this.Control[iCurrent+7]=this.dw_5
end on

on w_orden_compra_bk.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.dw_5)
end on

event ue_post_open;call super::ue_post_open;dw_1.settransobject(sqlca);			
dw_2.settransobject(sqlca);	
dw_5.settransobject(sqlca);	
ii_ann = year(date(gf_fecha_serv()))
datawindow = 1


this.triggerevent('ue_adicionar')

//Recupera la secuencia siguiente y da opcion para buscar una
wf_orden_nueva()

str.frame.setmicrohelp('Orden de Compra')
//il_tiempo = 150
//em_tiempo.text = string(150)
//timer(1)

end event

event ue_pre_aceptar;//Override
dw_1.Accepttext()

this.postevent("ue_aceptar")

end event

event ue_adicionar;//Override
string ls_contrato
if datawindow = 1 then	
	dw_1.reset()
	dw_2.reset()
	dw_1.insertrow(1)
	//Pone invisible el insertar	
	dw_1.setitem(1,'enca_g_financiero',str.g_financiero)
	dw_1.setitem(1,'enca_empresa',str.empresa)
	dw_1.setitem(1,'enca_ann',ii_ann)
	dw_1.setitem(1,'enca_estado','E')
	dw_1.setitem(1,'enca_fecha',date(gf_fecha_serv()))
	dw_1.setitem(1,'enca_fecha_despacho',date(gf_fecha_serv()))
	dw_1.setitem(1,'enca_fecha_llegada',date(gf_fecha_serv()))
	dw_1.setfocus()
	dw_1.setcolumn('enca_proveedor')
	wf_orden_nueva()
	dw_5.insertrow(1)
else
	if dw_2.getrow() > 0 then	
		if dw_2.getitemstring(dw_2.rowcount(), 'deta_referencia') <> '' or &
			not isnull(dw_2.getitemstring(dw_2.rowcount(), 'deta_referencia')) then
			dw_2.scrolltorow(dw_2.insertrow(0))
			dw_2.setitem(dw_2.getrow(),'deta_g_financiero',str.g_financiero)
			dw_2.setitem(dw_2.getrow(),'deta_empresa',str.empresa)
		end if
		if dw_2.getrow() > 1 then
			ls_contrato = dw_2.getitemstring(dw_2.getrow() - 1,'deta_contrato')
			dw_2.setitem(dw_2.getrow(),'deta_contrato',ls_contrato)
		end if
	else
		dw_2.scrolltorow(dw_2.insertrow(0))
		dw_2.setitem(dw_2.getrow(),'deta_g_financiero',str.g_financiero)
		dw_2.setitem(dw_2.getrow(),'deta_empresa',str.empresa)
	end if
	dw_2.setfocus()
	dw_2.setcolumn('deta_referencia')
end if

end event

event key;//override
end event

event close;Window lw_frame

lw_frame = ParentWindow()

If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_sheet_closed")
 End If
if isvalid(this) then close(this)
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
dw_2.height= newheight - 500
dw_5.y = newheight - 550
end event

event open;//override
//gf_acelerador()

dw = dw_1 
this.y = 0
this.x = 805
//this.height = w_fa_fondo.height - 50

This.Icon = str.icono

datawindowchild ldwc_provee

dw_1.getchild('enca_proveedor',ldwc_provee)
ldwc_provee.settransobject(sqlca)
ldwc_provee.retrieve(str.g_financiero, str.empresa)

dw_1.getchild('enca_cliente',ldwc_provee)
ldwc_provee.settransobject(sqlca)
ldwc_provee.retrieve(str.g_financiero, str.empresa)

this.postevent("ue_post_open")


This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)

str.frame.SetRedraw ( True )
end event

event ue_print;////override
string ls_empresa
dw_4.settransobject(sqlca)
if is_secuencia = '' then return
dw_4.retrieve(str.g_financiero, str.empresa, is_secuencia , ii_ann)
//
if dw_4.rowcount() = 0 then return
//
ls_empresa = gf_dg_nombre_empresa()
dw_4.object.nom_empresa.expression = "'"+ls_empresa+"'"

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
decimal{2} ldec_monto
datetime ldt_fecha,ldt_fecha_real
string   ls_documento,ls_aplic,ls_tipo,ls_medida,ls_producto,ls_concepto, fila, ls_conc,ls_error,ls_cuenta, ls_expresion, ls_doc
Long		ll_found, ll_ann,ll_secuencia
boolean  lb_existe

dw_1.acceptText()
dw_2.acceptText()
//dw=dw_1  

if dw_1.getitemstring(1,'enca_estado') <> 'E' then
	gf_mensaje('','La Orden de Compra esta Actualizada, No se Puede Modificar, Verifique !!!',1,1,'E')
	return
end if

if (dw_1.getitemNumber(1,"enca_proveedor")) = 0 or isnull(dw_1.getitemNumber(1,"enca_proveedor")) then
	gf_Mensaje("Atencion Sr. Usuario","Debe asignar el proveedor antes de guardar.",1,1,'E')
	dw_1.setcolumn("enca_proveedor")
	return
end if	


sqlca.autocommit = false

indice = 0

ls_documento = dw_1.getitemstring(1,"enca_secuencia")
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
	
	if (dw_1.getitemString(1,"enca_secuencia")) = '' or isnull(dw_1.getitemString(1,"enca_secuencia")) then
		gf_Mensaje("Atencion Sr. Usuario","Debe Asignar un valor valido, Verifique.",1,1,'E')
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
		gf_Mensaje("---Atención---","¡Error al Actualizar el encabezado !"+ls_error,1,1,'E')
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
  if dw_2.rowcount() > 0 then
	 ldec_monto  = dw_2.getitemnumber(1,'monto_total')
  else
	 ldec_monto  = 0
  end if
  dw_1.setitem(1,'enca_costo_total',ldec_monto)
  dw_1.setitem(1,'enca_usuario',str.usuario)
  
  ll_update = dw_1.update()
  if ll_update = 1 then
		commit;
		sqlca.autocommit = true
	else
		ls_error =sqlca.sqlerrtext
		rollback using sqlca;
		sqlca.autocommit = true
		ib_aceptar = False
		gf_Mensaje("---Atención---","¡Error al Actualizar el encabezado !"+ls_error,1,1,'E')
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
	ls_producto = dw_2.getitemstring(li_contador,"deta_referencia")
	if ls_producto = "" or isnull(ls_producto) then		
		dw_2.deleterow(li_contador)
		li_contador --
	End If
	dw_2.setitem(li_contador,'deta_secuencia',is_secuencia)
	dw_2.setitem(li_contador,'deta_ann',ii_ann)
	dw_2.setitem(li_contador,"deta_linea",li_contador)
		
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
				gf_Mensaje("---Aviso---","¡Error al Actualizar Detalle de la Orden! "+ls_error,1,1,'E')
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
		  
		  /////////////gf_Mensaje("Atención","Acualización Existosa","")
		  
		  str.frame.setmicrohelp('Orden Guardada.')
		  commit using sqlca ; 
		  
		else
			ls_error =sqlca.sqlerrtext
			rollback using sqlca;
			sqlca.autocommit = true
			ib_aceptar = False
			is_actualiza=''
			gf_Mensaje("---Aviso---","¡Error al Actualizar! "+ls_error,1,1,'E')
		end if
end if

sqlca.autocommit = true
//gf_Mensaje('Informacion','Actualizacion Exitosa','')
is_actualiza=''

end event

event timer;call super::timer;il_segundos = il_segundos + 1

if il_segundos > il_tiempo then
	wf_recupera()
	il_segundos = 0
end if
end event

event ue_busqueda;call super::ue_busqueda;//
String  ls_find,ls_codigo, ls_documento
integer li_c, li_b
long    ll_lter
string  ls_lter,ls_des

Datawindow        dww
str_dg_dynamic_find	lstr_df

	lstr_df.texto_campo [1,1] = "orden.enca_secuencia"
	lstr_df.texto_campo [1,2] = "Secuencia"
	lstr_df.texto_campo [1,3] = "enca_secuencia"
	lstr_df.texto_campo [1,4] = 'V'
	lstr_df.texto_campo [1,5] = '280'	
	lstr_df.texto_campo [2,1] = "dgmterce.terc_descripcion"
	lstr_df.texto_campo [2,2] = "Proveedor"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '650'
	lstr_df.texto_campo [3,1] = "orden.enca_fecha"
	lstr_df.texto_campo [3,2] = "Fecha"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [3,5] = '295'
	lstr_df.texto_campo [4,1] = "orden.enca_documento"
	lstr_df.texto_campo [4,2] = "Orden Compra"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '385'
	lstr_df.texto_campo [5,1] = "Tipo = case orden.enca_tipo when 0 then 'LOCAL' when 1 then 'EXTERIOR' else 'DIRECTA' end"
	lstr_df.texto_campo [5,2] = "Tipo"
	lstr_df.texto_campo [5,3] = ""
	lstr_df.texto_campo [5,4] = 'V'
	lstr_df.texto_campo [5,5] = '385'
	lstr_df.texto_campo [6,1] = "Estado = case orden.enca_estado when 'P' then 'PASADA' when 'A' then 'ACTUALIZADA' else 'PENDIENTE' end"
	lstr_df.texto_campo [6,2] = "Estado"
	lstr_df.texto_campo [6,3] = ""
	lstr_df.texto_campo [6,4] = 'V'
	lstr_df.texto_campo [6,5] = '385'
	lstr_df.texto_campo [7,1] = "cliente = (select max(b.terc_descripcion) from dgmterce b where b.terc_tercero = orden.enca_cliente and orden.enca_cliente <> 0)"
	lstr_df.texto_campo [7,2] = "Cliente"
	lstr_df.texto_campo [7,3] = ""
	lstr_df.texto_campo [7,4] = 'V'
	lstr_df.texto_campo [7,5] = '750'
	lstr_df.tabla = " orden, dgmterce "
		
	lstr_df.tabla_where = &
				"WHERE (orden.enca_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(orden.enca_empresa = " + string(str.empresa) + ") 	and " +&
 						 "(orden.enca_ann = " + string(ii_ann) + ") 	and " +&
						"(orden.enca_proveedor = dgmterce.terc_tercero)"
	
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
if dw_1.rowcount() > 0 then
	ll_lter = dw_1.getitemnumber(1,'enca_proveedor')
	ls_documento = dw_1.getitemstring(1,'enca_documento')
	dw_5.retrieve(str.g_financiero, str.empresa, ll_lter, ls_codigo, ii_ann )
else
	dw_5.reset()
	dw_5.insertrow(1)
end if
end event

event ue_eliminar;//override
Long resp
If dw.RowCount() > 0 Then
	
	If datawindow = 1 Then
		Resp = MessageBox("Aviso (Confirme el Siguiente Paso)",&
	 "¿ Esta Seguro que quiere borrar toda la Orden y su detalle  ?",Question!,YesNo!)
		If resp = 1 then
			wf_eliminar_todo()
		end IF
	ElseIf datawindow = 2 Then
		Resp = 1 //MessageBox("Aviso (Confirme el Siguiente Paso)",&
					// "El Registro en "+This.Title+" va a ser eliminado!...~r~n~t&
					//Está Seguro de Hacerlo Ahora?",Question!,YesNo!)
		If resp = 1 then
			wf_eliminar_detalle()
		end If
	End If
	Return
End If
	

end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_orden_compra_bk
boolean visible = false
integer x = 46
integer y = 2040
integer width = 101
string text = ""
end type

type dw_1 from w_fa_padre`dw_1 within w_orden_compra_bk
event ue_escape pbm_dwescape
integer x = 23
integer y = 0
integer width = 4937
integer height = 400
integer taborder = 10
string dataobject = "dw_orden_encabezado"
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

event dw_1::buttonclicked;call super::buttonclicked;long ll_codigo, ll_proveedor
integer li_encontro, li_existe
string ls_documento
dw_1.accepttext()
if dwo.name = 'b_activar' then
	if gf_mensaje('','Esta Seguro de Activar la Orden de Compra ?',2,1,'E') = 2 then return

	sqlca.autocommit = false
	
	  UPDATE orden  
     SET enca_estado = 'E'  
   WHERE ( orden.enca_g_financiero = :str.g_financiero ) AND  
         ( orden.enca_empresa = :str.empresa ) AND  
         ( orden.enca_secuencia = :is_secuencia ) AND  
         ( orden.enca_ann = :ii_ann )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al Activar Entrada '+sqlca.sqlerrtext,1,1,'E')
		rollback ;
		sqlca.autocommit = true
		return
	end if
	
	  UPDATE orden_detalle  
     SET deta_pasada = 0  
   WHERE ( orden_detalle.deta_g_financiero = :str.g_financiero ) AND  
         ( orden_detalle.deta_empresa = :str.empresa ) AND  
         ( orden_detalle.deta_secuencia = :is_secuencia ) AND  
         ( orden_detalle.deta_ann = :ii_ann )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al Activar Detalle '+sqlca.sqlerrtext,1,1,'E')
		rollback ;
		sqlca.autocommit = true
		return
	end if

	//Elimina la OC de cctmovim
	ls_documento = dw_1.getitemstring(1,'enca_documento')
	  DELETE FROM cptmovim  
   WHERE ( cptmovim.movi_g_financiero = :str.g_financiero ) AND  
         ( cptmovim.movi_empresa = :str.empresa ) AND  
         ( cptmovim.movi_aplicacion = 'CP' ) AND  
         ( cptmovim.movi_tipo_transaccion = 'OC' ) AND  
         ( cptmovim.movi_sub_transaccion = 'OC' ) AND  
         ( cptmovim.movi_documento = :ls_documento ) AND  
         ( cptmovim.movi_anno = :ii_ann ) AND  
         ( cptmovim.movi_referencia = :is_secuencia )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al Activar en el Proveedor '+sqlca.sqlerrtext,1,1,'E')
		rollback ;
		sqlca.autocommit = true
		return
	end if

	//Liberar los pagos realizados a la OC	
	ll_proveedor = dw_1.getitemnumber(1,'enca_proveedor')
	  SELECT count(*)  
		 INTO :li_existe  
		 FROM cpdrefac  
		WHERE ( cpdrefac.refa_g_financiero = :str.g_financiero ) AND  
				( cpdrefac.refa_empresa = :str.empresa ) AND  
				( cpdrefac.refa_aplicacion_ori = 'CP' ) AND  
				( cpdrefac.refa_tipo_transaccion_ori = 'OC' ) AND  
				( cpdrefac.refa_sub_transaccion_ori = 'OC' ) AND  
				( cpdrefac.refa_documento_ori = :ls_documento ) AND  
				( cpdrefac.refa_referencia_ori = :is_secuencia ) AND  
//				( cpdrefac.refa_ann_ori = :ii_ann ) AND  
				( cpdrefac.refa_tercero = :ll_proveedor )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Buscar Documento Aplicado '+sqlca.sqlerrtext,1,1,'E')
			rollback ;
			sqlca.autocommit = true
			return
		end if
		
		if li_existe > 0 then
			if gf_mensaje('','La OC tiene Pagos Aplicados, Desea Liberar los Pagos ?',2,1,'E') = 2 then
				rollback ;
				sqlca.autocommit = true
				return
			end if

			DELETE FROM cpdrefac  
			WHERE ( cpdrefac.refa_g_financiero = :str.g_financiero ) AND  
					( cpdrefac.refa_empresa = :str.empresa ) AND  
					( cpdrefac.refa_aplicacion_ori = 'CP' ) AND  
					( cpdrefac.refa_tipo_transaccion_ori = 'OC' ) AND  
					( cpdrefac.refa_sub_transaccion_ori = 'OC' ) AND  
					( cpdrefac.refa_documento_ori = :ls_documento ) AND  
					( cpdrefac.refa_referencia_ori = :is_secuencia ) AND  
	//				( cpdrefac.refa_ann_ori = :ii_ann ) AND  
					( cpdrefac.refa_tercero = :ll_proveedor )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Eliminar Documentos Aplicado '+sqlca.sqlerrtext,1,1,'E')
				rollback ;
				sqlca.autocommit = true
				return
			end if
			
		end if
		
	commit ;
	sqlca.autocommit = true
	dw_1.retrieve(str.g_financiero, str.empresa, is_secuencia, ii_ann )
	dw_2.reset()
	dw_2.retrieve(str.g_financiero, str.empresa, is_secuencia, ii_ann )
	dw_2.scrolltorow(dw_2.rowcount())
	dw_2.setfocus()

elseif dwo.name = 'b_buscar' then
	String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error
	integer li_c, li_b
	long    ll_lter
	
	Datawindow        dww
	str_dg_dynamic_find	lstr_df
	
		lstr_df.texto_campo [2,1] = "ccmclien.clie_ref_anterior" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [2,2] = "Cuenta"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '450'
		lstr_df.texto_campo [1,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [1,2] = "Nombre del Cliente"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '700'		
		lstr_df.texto_campo [4,1] = "dgmterce.terc_tercero"
		lstr_df.texto_campo [4,2] = "Tercero"
		lstr_df.texto_campo [4,3] = "terc_tercero"
		lstr_df.texto_campo [4,4] = 'I'
		lstr_df.texto_campo [3,1] = "dgapais.pais_descripcion"
		lstr_df.texto_campo [3,2] = "País"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [3,5] = '550'
		
		lstr_df.tabla = " dgmterce, dgapais, ccmclien "
		
		
		lstr_df.tabla_where = &
					"WHERE ( dgmterce.terc_pais = dgapais.pais_pais ) and  " +&				
							 "(ccmclien.clie_g_financiero = " + string(str.g_financiero) + " and " +&
							 "ccmclien.clie_empresa = " + string(str.empresa) + ") 	and " +&
							"(dgmterce.terc_tercero = ccmclien.clie_tercero) and " +&
					      "(ccmclien.clie_estado = 'A' ) AND  " +&
					      "(ccmclien.clie_cuenta_mala <> 1 ) "  							
		
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	If len (ls_find) = 0 Then Return
		
		
	ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo1,"'"," ")
	ls_codigo1 = Trim(ls_codigo1)

	dw_1.setitem(1,'enca_cliente',long(ls_codigo1))
	dw_1.accepttext()
	dw_1.setcolumn('enca_cliente')

elseif dwo.name = 'b_secuencia' then
	parent.triggerevent('ue_busqueda')
end if
end event

event dw_1::clicked;call super::clicked;datawindow = 1
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;datawindow = 1
end event

event dw_1::getfocus;call super::getfocus;datawindow = 1
end event

event dw_1::itemchanged;call super::itemchanged;dw_1.accepttext()
string ls_producto
integer i
choose case dwo.name
	case 'enca_ann'
		ii_ann = integer(data)
	case 'enca_tipo'
		if gf_mensaje('','Esta Seguro de Cambiar el Tipo de la Orden ??',2,1,'E') = 1 then
			parent.triggerevent('ue_aceptar')
			for i = 1 to dw_2.rowcount()
				ls_producto = dw_2.getitemstring(i,'deta_referencia')
				update inmprodu set prod_cant_confirma = 
				 ( SELECT isnull(sum(convert(numeric(17,0), orden_detalle.deta_cantidad * inamedid.medi_cantidad) ),0) 
					 FROM orden,   
							orden_detalle,   
							inamedid  
					WHERE ( orden_detalle.deta_g_financiero = orden.enca_g_financiero ) and  
							( orden_detalle.deta_empresa = orden.enca_empresa ) and  
							( orden_detalle.deta_secuencia = orden.enca_secuencia ) and  
							( orden_detalle.deta_ann = orden.enca_ann ) and  
							( orden_detalle.deta_unidad = inamedid.medi_medida ) and  
							( ( orden.enca_g_financiero = :str.g_financiero ) AND  
							( orden.enca_empresa = :str.empresa ) AND  
							( (orden_detalle.deta_cantidad * medi_cantidad ) - isnull(orden_detalle.deta_pasada,0) > 0 ) AND  
							( orden.enca_tipo = 0 ) ) and 
						( orden_detalle.deta_g_financiero = inmprodu.prod_g_financiero  and orden_detalle.deta_empresa = inmprodu.prod_empresa  and orden_detalle.deta_referencia = inmprodu.prod_producto) 
						 )
				  from inmprodu
				where prod_g_financiero = :str.g_financiero and prod_empresa = :str.empresa and prod_status = 1 and prod_producto = :ls_producto;

				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Actualizar Cantidad de Orden '+sqlca.sqlerrtext,1,1,'E')
					rollback;
					return
				end if
				commit;
			next
		else
			if long(data) = 1 then
				dw_1.setitem(1,'enca_tipo',0)
			else
				dw_1.setitem(1,'enca_tipo',1)				
			end if
			return 2
		end if
end choose
end event

type st_ayuda from w_fa_padre`st_ayuda within w_orden_compra_bk
integer x = 2793
integer y = 636
end type

type dw_2 from datawindow within w_orden_compra_bk
event ue_enter pbm_dwnprocessenter
event ue_down pbm_dwnkey
event ue_helpcol ( )
integer x = 18
integer y = 408
integer width = 4955
integer height = 1756
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle de la Orden"
string dataobject = "dw_orden_detalle"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_enter;if this.getcolumnname() = 'deta_contrato' then	
	if this.getrow() = this.rowcount() then
		parent.triggerevent('ue_aceptar')
		parent.triggerevent('ue_adicionar')
	else
		this.scrolltorow(this.getrow() + 1)
		this.setcolumn('deta_referencia')
	end if
elseif this.getcolumnname() = 'deta_bultos' then	
	this.setcolumn('deta_contrato')	
elseif this.getcolumnname() = 'deta_referencia' then	
	this.setcolumn('deta_costo')
elseif this.getcolumnname() = 'deta_costo' then	
	this.setcolumn('deta_cantidad')	
elseif this.getcolumnname() = 'deta_cantidad' then	
	this.setcolumn('deta_bultos')	
elseif this.getcolumnname() = 'deta_precio_venta' then	
	if this.getrow() + 1 <= this.rowcount() then  this.scrolltorow(this.getrow() + 1)
	this.setcolumn('deta_referencia')		
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

choose case this.getcolumnname()
	case 'deta_referencia'
		
	lstr_df.texto_campo [1,1] = "inmprodu.prod_producto"
	lstr_df.texto_campo [1,2] = "Referencia"
	lstr_df.texto_campo [1,3] = "prod_producto"
	lstr_df.texto_campo [1,4] = 'V'
//	lstr_df.texto_campo [1,5] = '280'	
	lstr_df.texto_campo [2,1] = "inmprodu.prod_producto_dos"
	lstr_df.texto_campo [2,2] = "Modelo"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
//	lstr_df.texto_campo [2,5] = '770'
	lstr_df.texto_campo [3,1] = "inmprodu.prod_descripcion"
	lstr_df.texto_campo [3,2] = "Descripcion"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [3,5] = '1070'
	
	lstr_df.texto_campo [4,1] = "convert(numeric(8,2),inmprodu.prod_existencia_total / medi_cantidad) prod_existencia_total"
	lstr_df.texto_campo [4,2] = "Exist."
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '270'

	lstr_df.texto_campo [5,1] = "convert(numeric(8,2),inmprodu.prod_reserva_total / medi_cantidad) prod_reserva_total"
	lstr_df.texto_campo [5,2] = "Reserva"
	lstr_df.texto_campo [5,3] = ""
	lstr_df.texto_campo [5,4] = 'V'
	lstr_df.texto_campo [5,5] = '270'

	lstr_df.texto_campo [6,1] = "convert(numeric(8,2),(inmprodu.prod_existencia_total  - inmprodu.prod_reserva_total) / medi_cantidad) disponible"
	lstr_df.texto_campo [6,2] = "Dispo."
	lstr_df.texto_campo [6,3] = ""
	lstr_df.texto_campo [6,4] = 'V'
	lstr_df.texto_campo [6,5] = '270'

	lstr_df.texto_campo [7,1] = "convert(numeric(12), inmprodu.prod_empaque) prod_empaque"
	lstr_df.texto_campo [7,2] = "Empaque"
	lstr_df.texto_campo [7,3] = ""
	lstr_df.texto_campo [7,4] = 'V'
	lstr_df.texto_campo [7,5] = '270'
	
	lstr_df.texto_campo [8,1] = "inmprodu.prod_medida"
	lstr_df.texto_campo [8,2] = "Uni."
	lstr_df.texto_campo [8,3] = ""
	lstr_df.texto_campo [8,4] = 'V'
	lstr_df.texto_campo [8,5] = '120'
	lstr_df.texto_campo [9,1] = "cradivis.adiv_nombre_div"
	lstr_df.texto_campo [9,2] = "Division"
	lstr_df.texto_campo [9,3] = ""
	lstr_df.texto_campo [9,4] = 'V'
	lstr_df.texto_campo [9,5] = '870'
	lstr_df.texto_campo [10,1] = "cragrupo.agru_descripcion_grupo"
	lstr_df.texto_campo [10,2] = "Grupo"
	lstr_df.texto_campo [10,3] = ""
	lstr_df.texto_campo [10,4] = 'V'
	lstr_df.texto_campo [10,5] = '870'

	lstr_df.tabla = " inmprodu, cradivis, cragrupo, inamedid "
		
	lstr_df.tabla_where = &
		"WHERE ( cragrupo.agru_g_financiero = inmprodu.prod_g_financiero ) and  " +&
         "( cragrupo.agru_empresa = inmprodu.prod_empresa ) and  " +&
         "( cragrupo.agru_codigo_div = inmprodu.prod_division ) and " +&  
         "( cragrupo.agru_codigo_grupo = inmprodu.prod_grupo ) and " +&  			
         "( inmprodu.prod_g_financiero = cradivis.adiv_g_financiero ) and " +& 
         "( inmprodu.prod_empresa = cradivis.adiv_empresa ) and  " +&
         "( inmprodu.prod_division = cradivis.adiv_codigo_div ) and " +&  
         "( inmprodu.prod_medida = inamedid.medi_medida ) and " +&  			
		"( inmprodu.prod_status = 1 ) and " + &	
		"(inmprodu.prod_g_financiero = " + string(str.g_financiero) + ") and " +&
		"(inmprodu.prod_empresa = " + string(str.empresa) + ") "	
						 
	OpenWithParm(w_buscar_producto, lstr_df)
	ls_find = Message.StringParm	
	
	If len (ls_find) = 0 Then Return
		
	ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo,"'"," ")
	ls_codigo = Trim(ls_codigo)
	this.setitem(this.getrow(),'deta_referencia',ls_codigo)
	this.accepttext()
	this.trigger event itemchanged(this.getrow(), object, ls_codigo)
	
end choose

end event

event itemfocuschanged;datawindow = 2
this.selecttext(1,100)
end event

event clicked;if dwo.name = 'p_delete' then
	dw_2.scrolltorow(row)
	parent.triggerevent('ue_eliminar')
	return
end if

if this.rowcount() = 0 then
	datawindow = 1
	parent.triggerevent('ue_aceptar')
else
	datawindow = 2
	parent.triggerevent('ue_adicionar')
end if

datawindow = 2

if	dwo.name = 'p_add' then
	parent.triggerevent('ue_adicionar')
elseif dwo.name = 'p_buscar' then
	dw_2.scrolltorow(row)
	This.triggerevent("ue_helpcol")
end if
end event

event buttonclicked;string ls_codigo
integer li_encontro
if dwo.name = 'b_producto' then
		string ls_producto
		str_kardex  str_opcion2
		if dw_2.rowcount() > 0 then
			ls_producto = dw_2.getitemstring(dw_2.getrow(),'deta_referencia')				
		end if			
		str_opcion2.kproducto=ls_producto
		OpenSheetWithParm(w_productos,str_opcion2,str.frame,2,Original!)		

elseif dwo.name = 'b_unidades' then
	dw_3.dataobject = 'dw_unidades'
	dw_3.title =	'Unidades de Medida'
	dw_3.settransobject(sqlca)
	if dw_3.retrieve() = 0 then
		dw_3.insertrow(1)
	else
		ls_codigo	= dw_2.getitemstring(dw_2.getrow(),'deta_unidad')
		li_encontro = dw_3.find('medi_unidad = "'+string(ls_codigo)+'"',1,dw_3.rowcount())
		if li_encontro > 0 then
			dw_3.scrolltorow(li_encontro)
		end if
	end if
	dw_3.setfocus()
	dw_3.width = 1800
	dw_3.x = 1493
	dw_3.visible = true	
end if
end event

event itemchanged;string ls_codigo, ls_descripcion, ls_uni_empaque, ls_uni
long   ll_bultos, ll_cantidad


if this.getcolumnname() = 'deta_referencia' then
	  ls_codigo = data
	  SELECT inmprodu.prod_descripcion,   
         inmprodu.prod_empaque,   
         inmprodu.prod_medida,   
         unidades_a.medi_cantidad,   
         unidades_b.medi_cantidad,
			inmprodu.prod_peso,
			inmprodu.prod_cubicaje,
			inmprodu.prod_costo_fob
    INTO :ls_descripcion,   
         :il_empaque,   
         :ls_uni,   
         :ii_cantidad_unidad,   
         :ii_cantidad_empaque,
			:id_peso,
			:id_cubicaje,
			:id_costo
    FROM inmprodu,   
         inamedid unidades_a,   
         inamedid unidades_b  
   WHERE ( unidades_a.medi_medida = inmprodu.prod_medida ) and  
         ( inmprodu.prod_empaque_um = unidades_b.medi_medida ) and  
         ( ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
         ( inmprodu.prod_empresa = :str.empresa ) AND  
         ( inmprodu.prod_producto = :ls_codigo ) )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al recuperar datos del producto '+sqlca.sqlerrtext,1,1,'E')
			return 2
		end if
		if ls_descripcion = '' or isnull(ls_descripcion) then
			gf_mensaje('','Referencia no Existe, Verifique !!!',1,1,'E')
			this.setitem(row,'deta_referencia','')
			this.setcolumn('deta_referencia')
			return 2
		else
			this.setitem(row, 'prod_descripcion', ls_descripcion)
			this.setitem(row, 'deta_unidad', ls_uni)
			this.setitem(row, 'deta_costo', id_costo)
			this.setcolumn('deta_costo')
		end if
elseif this.getcolumnname() = 'deta_cantidad' then
	ll_cantidad = long(data)	
	if il_empaque = 0 or isnull(il_empaque) then il_empaque = 1
	if ii_cantidad_empaque = 0 or isnull(ii_cantidad_empaque) then ii_cantidad_empaque = 1
	ll_bultos = (ll_cantidad * ii_cantidad_unidad ) / (il_empaque * ii_cantidad_empaque)
	if ll_bultos = 0 then ll_bultos = 1
	this.setitem(row,'deta_bultos',ll_bultos)
	this.setitem(row,'deta_peso',ll_bultos * id_peso)
	this.setitem(row,'deta_cubicaje',round(ll_bultos * id_cubicaje,4))		
	this.setcolumn('deta_bultos')
elseif this.getcolumnname() = 'deta_costo' then	
	this.setcolumn('deta_cantidad')
elseif this.getcolumnname() = 'deta_bultos' then	
	if this.getrow() = this.rowcount() then
		parent.triggerevent('ue_adicionar')
	else
		this.scrolltorow(this.getrow() + 1)
		this.setcolumn('deta_referencia')
	end if
end if
end event

event getfocus;datawindow = 2
end event

event rowfocuschanged;
string ls_codigo

ls_codigo = this.getitemstring(currentrow,'deta_referencia')
	  SELECT  inmprodu.prod_empaque,   
         inamedid_a.medi_cantidad,   
         inamedid_b.medi_cantidad,
			inmprodu.prod_peso,
			inmprodu.prod_cubicaje,
			inmprodu.prod_costo_promedio
    INTO :il_empaque,   
         :ii_cantidad_unidad,   
         :ii_cantidad_empaque,
			:id_peso,
			:id_cubicaje,
			:id_costo
    FROM inmprodu,   
         inamedid inamedid_a,   
         inamedid inamedid_b  
   WHERE ( inamedid_a.medi_medida = inmprodu.prod_medida ) and  
         ( inmprodu.prod_empaque_um = inamedid_b.medi_medida ) and  
         ( ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
         ( inmprodu.prod_empresa = :str.empresa ) AND  
         ( inmprodu.prod_producto = :ls_codigo ) )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al recuperar datos del producto '+sqlca.sqlerrtext,1,1,'E')
			return 2
		end if

end event

type dw_3 from datawindow within w_orden_compra_bk
boolean visible = false
integer x = 1193
integer y = 260
integer width = 2501
integer height = 1376
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Proveedores"
string dataobject = "dw_proveedores"
boolean controlmenu = true
boolean hscrollbar = true
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
	sqlca.autocommit = false
	if this.update() = -1 then
		gf_mensaje('','Error al actualizar '+sqlca.sqlerrtext,1,1,'E')
		rollback;
	end if
	sqlca.autocommit = true
elseif dwo.name = 'b_adicionar' then
	
	this.scrolltorow(this.insertrow(0))
	this.setitem(this.getrow(),'prod_g_financiero', str.g_financiero)
	this.setitem(this.getrow(),'prod_empresa', str.empresa)
	
end if
end event

event itemchanged;//Para que al momento de seleccionar un cargo fijo, setear NO al porcentaje y a nivel del
//campo en el DW, se proteje el campo
Integer li_existe
string ls_col, ls_codigo, ls_codigo_anterior
this.accepttext()
//w_colores.triggerevent("ue_pre_aceptar")
ls_col = this.getcolumnname()

choose case ls_col
	case	'prod_producto'
		ls_codigo = data
		ls_codigo_anterior = this.getitemstring(row,'prod_producto',Primary!, true)

		  SELECT count(*)  
			 INTO :li_existe  
			 FROM productos  
			WHERE ( productos.prod_g_financiero = :str.g_financiero ) AND  
					( productos.prod_empresa = :str.empresa ) AND  
					( productos.prod_producto = :ls_codigo )  ;
			if sqlca.sqlcode = -1 then 
				gf_mensaje('','Error al Validar Productos '+sqlca.sqlerrtext,1,1,'E')
				return 2
			end if
		
			if li_existe > 0 then
				gf_mensaje('','Esta Referencia ya Existe, Verifique !!!',1,1,'E')
				this.setitem(row,'prod_producto',ls_codigo_anterior)
				this.setcolumn('prod_producto')
				return 2
			end if
		
		
		  SELECT count(*)  
			 INTO :li_existe  
			 FROM orden_detalle  
			WHERE ( orden_detalle.deta_g_financiero = :str.g_financiero ) AND  
					( orden_detalle.deta_empresa = :str.empresa ) AND  
					( orden_detalle.deta_referencia = :ls_codigo_anterior )  ;
			if sqlca.sqlcode = -1 then 
				gf_mensaje('','Error al Validar Detalle de la Orden '+sqlca.sqlerrtext,1,1,'E')
				return 2
			end if
		
			if li_existe > 0 then
				gf_mensaje('','No Puede Modificar esta Referencia, Existen Ordenes Asociadas a la misma, Verifique !!!',1,1,'E')
				this.setitem(row,'prod_producto',ls_codigo_anterior)				
				this.setcolumn('prod_producto')
				return 2
			end if
		
			  SELECT count(*)  
				 INTO :li_existe  
				 FROM pedidos_detalle  
				WHERE ( pedidos_detalle.dped_g_financiero = :str.g_financiero ) AND  
						( pedidos_detalle.dped_empresa = :str.empresa ) AND  
						( pedidos_detalle.dped_producto = :ls_codigo_anterior )  ;
			if sqlca.sqlcode = -1 then 
				gf_mensaje('','Error al Validar Detalle del Pedido '+sqlca.sqlerrtext,1,1,'E')
				return 2
			end if
		
			if li_existe > 0 then
				gf_mensaje('','No Puede Modificar esta Referencia, Existen Pedidos Asociados a la misma, Verifique !!!',1,1,'E')
				this.setitem(row,'prod_producto',ls_codigo_anterior)
				this.setcolumn('prod_producto')
				return 2
			end if

		
end choose

end event

type dw_4 from datawindow within w_orden_compra_bk
boolean visible = false
integer x = 55
integer y = 20
integer width = 3611
integer height = 1556
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Impresión de la Orden de Compra"
string dataobject = "dw_impresion_orden"
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

type cb_1 from commandbutton within w_orden_compra_bk
boolean visible = false
integer x = 2295
integer y = 292
integer width = 1079
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Importar Productos al Detalle de la OC"
end type

event clicked;integer i, li_empaque, li_existe, li_ann
string ls_oc, ls_producto, ls_descrip, ls_unidad, ls_unidad_empaque, ls_secuencia
decimal  ld_peso, ld_cubicaje, ld_costo, ld_peso_tot, ld_cubicaje_tot
long ll_cantidad, ll_bultos

ls_secuencia = dw_1.getitemstring(dw_1.getrow(),'enca_secuencia')
li_ann		 = dw_1.getitemnumber(dw_1.getrow(),'enca_ann')
ls_oc = dw_1.getitemstring(dw_1.getrow(),'enca_documento')

if ls_oc = '' or isnull(ls_oc) then
	gf_mensaje('','Asigne el numero de la Orden a Pasar',1,1,'E')
	return
end if

  SELECT count(*)  
    INTO :li_existe  
    FROM orden  
   WHERE ( orden.enca_g_financiero = :str.g_financiero ) AND  
         ( orden.enca_empresa = :str.empresa ) AND  
         ( orden.enca_secuencia = :ls_secuencia ) AND  
         ( orden.enca_ann = :li_ann ) ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al buscar detalle '+sqlca.sqlerrtext,1,1,'E')
		return
	end if

	if li_existe = 0 then
		gf_mensaje('','Debe Grabar el Encabezado antes de pasar los productos, Verifique!!!',1,1,'E')
		return
	end if

  	SELECT count(*)  
   		 INTO :li_existe  	
	    FROM inmprodu  
   WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
         ( inmprodu.prod_empresa = :str.empresa ) AND  
         ( inmprodu.prod_orden_compra = :ls_oc ) ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al declarar cursor '+sqlca.sqlerrtext,1,1,'E')
		sqlca.autocommit = true
		return
	end if
	if li_existe = 0 then
		gf_mensaje('','No Existen Productos con este Numero de Orden Asociada, Verifique !!!',1,1,'E')
		return
	end if
	
	
SELECT count(*)  
    INTO :li_existe  
    FROM orden_detalle  
   WHERE ( orden_detalle.deta_g_financiero = :str.g_financiero ) AND  
         ( orden_detalle.deta_empresa = :str.empresa ) AND  
         ( orden_detalle.deta_secuencia = :ls_secuencia ) AND  
         ( orden_detalle.deta_ann = :li_ann ) ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al buscar detalle '+sqlca.sqlerrtext,1,1,'E')
		return
	end if
	
sqlca.autocommit = false

 if li_existe > 0 then
	if gf_mensaje('','La Orden tiene Detalle, desea Pasarlo Nuevamente ?, Se eliminara todo el detalle !!!',2,2,'E') = 1 then
		
		DELETE FROM orden_detalle  
		WHERE ( orden_detalle.deta_g_financiero = :str.g_financiero ) AND  
				( orden_detalle.deta_empresa = :str.empresa ) AND  
				( orden_detalle.deta_secuencia = :ls_secuencia ) AND  
				( orden_detalle.deta_ann = :li_ann ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al buscar detalle '+sqlca.sqlerrtext,1,1,'E')
			sqlca.autocommit = true	
			return
		end if
		dw_2.reset()
	else
		sqlca.autocommit = true
		return
	end if
 end if

 DECLARE detalle_orden CURSOR FOR  
  SELECT inmprodu.prod_producto,   
         inmprodu.prod_descripcion,   
         inmprodu.prod_empaque,   
         inmprodu.prod_medida,   
         inmprodu.prod_empaque_um,   
         inmprodu.prod_peso,   
         inmprodu.prod_cubicaje,   
         isnull(inmprodu.prod_costo_oc,0),   
         isnull(inmprodu.prod_cantidad_oc,0)  
    FROM inmprodu  
   WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
         ( inmprodu.prod_empresa = :str.empresa ) AND  
         ( inmprodu.prod_orden_compra = :ls_oc ) ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al declarar cursor '+sqlca.sqlerrtext,1,1,'E')
		sqlca.autocommit = true
		return
	end if
	
	open detalle_orden;

	FETCH detalle_orden INTO :ls_producto, :ls_descrip, :li_empaque, :ls_unidad, :ls_unidad_empaque, :ld_peso, :ld_cubicaje, :ld_costo, :ll_cantidad ;
	
	DO WHILE sqlca.sqlcode = 0
		i ++
		
		//calcula bultos peso y cubicaje
		SELECT unidades_a.medi_cantidad,   
				unidades_b.medi_cantidad
		INTO :ii_cantidad_unidad,   
				:ii_cantidad_empaque
		FROM inmprodu,   
				inamedid unidades_a,   
				inamedid unidades_b  
		WHERE ( unidades_a.medi_medida = inmprodu.prod_medida ) and  
				( inmprodu.prod_empaque_um = unidades_b.medi_medida ) and  
				( ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
				( inmprodu.prod_empresa = :str.empresa ) AND  
				( inmprodu.prod_producto = :ls_producto ) )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al recuperar datos del producto '+sqlca.sqlerrtext,1,1,'E')
			sqlca.autocommit = true
			return 
		end if		
		
		if li_empaque = 0 or isnull(li_empaque) then li_empaque = 1
		ll_bultos = (ll_cantidad * ii_cantidad_unidad ) / (li_empaque * ii_cantidad_empaque)
		if ll_bultos = 0 then ll_bultos = 1
		ld_peso_tot = ll_bultos * ld_peso
		ld_cubicaje_tot = round(ll_bultos * ld_cubicaje,4)
	
		  INSERT INTO orden_detalle  
         ( deta_g_financiero,   
           deta_empresa,   
           deta_secuencia,   
           deta_ann,   
           deta_linea,   
           deta_referencia,   
           deta_unidad,   
           deta_costo,   
           deta_cantidad,   
           deta_bultos,   
           deta_comentario,   
           deta_peso,   
           deta_cubicaje,   
           deta_reservado )  
		  VALUES ( :str.g_financiero,   
           :str.empresa,   
           :ls_secuencia,   
           :li_ann,   
           :i,   
           :ls_producto,   
           :ls_unidad,   
           :ld_costo,   
           :ll_cantidad,   
           :ll_bultos,   
           '',   
           :ld_peso_tot,   
           :ld_cubicaje_tot,   
           0 )  ;

				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Insertar detalle '+sqlca.sqlerrtext,1,1,'E')
					rollback;
					sqlca.autocommit = true
					return
				end if
		
		
		FETCH detalle_orden INTO :ls_producto, :ls_descrip, :li_empaque, :ls_unidad, :ls_unidad_empaque, :ld_peso, :ld_cubicaje, :ld_costo, :ll_cantidad ;
	LOOP

	commit; 
	
	close detalle_orden;

	sqlca.autocommit = true
	
	gf_mensaje('','Creacion Exitosa',1,1,'E')
	
	dw_2.retrieve(str.g_financiero, str.empresa, ls_secuencia, li_ann)
	dw_2.setfocus()
end event

type cb_2 from commandbutton within w_orden_compra_bk
boolean visible = false
integer x = 3141
integer y = 292
integer width = 338
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "Recalcular"
end type

event clicked;string ls_producto
integer i, li_empaque, li_cantidad_empaque, li_cantidad_unidad
decimal{2} ld_costo
decimal{3} ld_peso, ld_cubicaje
long ll_cantidad, ll_bultos

for i = 1 to dw_2.rowcount()
	ls_producto = dw_2.getitemstring(i,'deta_referencia')
	ld_costo = dw_2.getitemnumber(i,'deta_costo')
	ll_cantidad = dw_2.getitemnumber(i,'deta_cantidad')
	
	  SELECT inmprodu.prod_empaque,   
				inmprodu.prod_peso,   
				inmprodu.prod_cubicaje ,
				a.medi_cantidad,
				b.medi_cantidad
		 INTO :li_empaque,   
				:ld_peso,   
				:ld_cubicaje , 
				:li_cantidad_unidad,
				:li_cantidad_empaque
		 FROM inmprodu, inamedid a, inamedid b
		WHERE ( a.medi_medida = inmprodu.prod_medida ) and  
         		( inmprodu.prod_empaque_um = b.medi_medida ) and  
				( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
				( inmprodu.prod_empresa = :str.empresa ) AND  
				( inmprodu.prod_producto = :ls_producto )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Buscar Campos del Producto '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
	
		if li_empaque = 0 or isnull(li_empaque) then li_empaque = 1
		if li_cantidad_empaque = 0 or isnull(li_cantidad_empaque) then li_cantidad_empaque = 1
		ll_bultos = (ll_cantidad * li_cantidad_unidad ) / (li_empaque * li_cantidad_empaque)
		if ll_bultos = 0 then ll_bultos = 1
		dw_2.setitem(i,'deta_bultos',ll_bultos)
		dw_2.setitem(i,'deta_peso',ll_bultos * ld_peso)
		dw_2.setitem(i,'deta_cubicaje',round(ll_bultos * ld_cubicaje,4))		
	
next
end event

type cb_3 from commandbutton within w_orden_compra_bk
integer x = 3771
integer y = 28
integer width = 402
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "ACTUALIZAR"
end type

event clicked;/*ADD BY HGN 15/08/2002 PARA QUE ACTUALICE COSTO CIF*/	
	String	ls_expresion, ls_concepto, ls_costo_proc , ls_dbcode, ls_errtext, ls_producto, ls_documento, ls_comentario, ls_referencia, ls_cuenta, ls_cuenta_contable_proveedor, ls_nombre, ls_tran = 'FF', ls_subtran = 'FF', ls_cuenta_compras
	integer  i, li_linea, li_existe, li_excluir_sugerido = 0, li_encontro
	decimal{4} ld_costo_promedio, ld_costo_cif, ld_costo_fob, ld_gastos_admon, cargo, costo_cif, costo
	decimal ld_costo_global, total_cargos, cantidad 
	decimal{2} ld_monto
	datetime ldt_fecha	
	long ll_cantidad_por_producto, ll_tercero, linea


	parent.triggerevent('ue_aceptar')
	
		if dw_1.getitemstring(1, 'enca_estado', primary!, true) <> 'E' then
			return
		end if
		ls_expresion = str.nombre_empresa

		if gf_mensaje('','Esta Seguro de Actualizar la Orden de Compra ?',2,1,'E') = 2 then return
		
		ldt_fecha = dw_1.getitemdatetime(1,'enca_fecha')
		ls_documento = dw_1.getitemstring(1,'enca_documento')
		ld_monto		= dw_2.getitemnumber(1,'monto_total')
							
		sqlca.autocommit = false
		ll_tercero = dw_1.getitemnumber(1,'enca_proveedor')
		ls_concepto = dw_1.getitemString(1,'enca_tipo')

		ls_comentario = dw_1.getitemstring(1,'enca_comentario')
		ls_comentario = 'SEC. '+is_secuencia+' O/C: '+ls_documento+' - '+ls_comentario
		ls_referencia = is_secuencia
		//Datos y cuenta del proveedor
		  SELECT dgmterce.terc_descripcion,   
					cpmprove.prov_cod_proveedor,   
					cpmprove.prov_mg_cuenta  
			 INTO :ls_nombre,   
					:ls_cuenta,   
					:ls_cuenta_contable_proveedor  
			 FROM cpmprove,   
					dgmterce  
			WHERE ( dgmterce.terc_tercero = cpmprove.prov_tercero ) and  
					( ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
					( cpmprove.prov_empresa = :str.empresa ) AND  
					( cpmprove.prov_tercero = :ll_tercero ) )   ;
			 If Sqlca.sqlcode = -1 Then
				 gf_mensaje("","¡Error al Buscar datos del Proveedor " +sqlca.sqlerrtext,1,1,'E')
				 Rollback;
				sqlca.autocommit = true
				return
			 End If 	
	
	ls_tran 	  = 'OC'
	ls_subtran = 'OC'
				
		  INSERT INTO cptmovim  
				( movi_g_financiero,   
				  movi_empresa,   
				  movi_aplicacion,   
				  movi_tipo_transaccion,   
				  movi_sub_transaccion,   
				  movi_documento,   
				  movi_anno,   
				  movi_referencia,   
				  movi_tercero,   
				  movi_ruc_tercero,   
				  movi_naturaleza,   
				  movi_monto,   
				  movi_fecha_tran,   
				  movi_fecha_reg,   
				  movi_usuario,   
				  movi_estado,   
				  movi_comentario,   
				  movi_saldo,   
				  movi_itbm,   
				  movi_cierre_mensual,   
				  movi_pase_conta,   
				  movi_a_nombre,   
				  movi_impreso,   
				  movi_historico,   
				  movi_monto_aplicado,   
				  movi_paga_itbm,   
				  movi_monto_final)  
	  VALUES ( :str.g_financiero,   
				  :str.empresa,   
				  'CP',   
				  :ls_tran,   
				  :ls_subtran,   
				  :ls_documento,   
				  :ii_ann,   
				  :ls_referencia,   
				  :ll_tercero,   
				  :ls_cuenta,   
				  'C',   
				  :ld_monto,   
				  :ldt_fecha,   
				  getdate(),   
				  :str.usuario,   
				  'IM',   
				  :ls_comentario,   
				  :ld_monto,   
				  0,   
				  'N',   
				  'N',    
				  :ls_nombre,   
				  'S',   
				  0,   
				  0,   
				  0,   
				  :ld_monto )  ;
			 If Sqlca.sqlcode = -1 Then
				 gf_mensaje("","¡Error al Insertar Movimiento " +sqlca.sqlerrtext,1,1,'E')
				 Rollback;
				sqlca.autocommit = true
				return
			 End If 
	/**/
	
	
	dw_1.setitem(1,'enca_estado','A')
	if dw_1.update() = -1 then
		 gf_mensaje("","¡Error al Actualizar Orden " +sqlca.sqlerrtext,1,1,'E')
		 Rollback;
		sqlca.autocommit = true
		return
	else
		commit;
	end if
	
	//parent.triggerevent('ue_aceptar')
	
end event

type dw_5 from datawindow within w_orden_compra_bk
boolean visible = false
integer x = 23
integer y = 1668
integer width = 2249
integer height = 544
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "PAGOS REALIZADOS"
string dataobject = "dw_pagos_a_ordenes"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event retrieveend;decimal{2} ld_pagos
if rowcount > 0 then
	ld_pagos = this.getitemnumber(1,'total')
else
	ld_pagos = 0
end if

if dw_2.rowcount() > 0 then dw_2.setitem(1,'pagos',ld_pagos)
end event

