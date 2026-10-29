//objectcomments Ventana para la Captura de Transitos
forward
global type w_transito_bk from w_fa_padre
end type
type dw_2 from datawindow within w_transito_bk
end type
type dw_3 from datawindow within w_transito_bk
end type
type dw_4 from datawindow within w_transito_bk
end type
type cb_1 from commandbutton within w_transito_bk
end type
type pb_2 from picturebutton within w_transito_bk
end type
type st_1 from statictext within w_transito_bk
end type
end forward

global type w_transito_bk from w_fa_padre
integer x = 0
integer y = 0
integer width = 4146
integer height = 1932
string title = "Captura de Factura del Proveedor - Transito"
string menuname = "m_hs"
boolean controlmenu = false
long backcolor = 12639424
event ue_syscommand pbm_syscommand
event ue_aceptar_por_linea ( )
dw_2 dw_2
dw_3 dw_3
dw_4 dw_4
cb_1 cb_1
pb_2 pb_2
st_1 st_1
end type
global w_transito_bk w_transito_bk

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
from transito
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
  DELETE FROM transito_detalle  
   WHERE ( transito_detalle.deta_g_financiero = :str.g_financiero ) AND  
         ( transito_detalle.deta_empresa = :str.empresa ) AND  
         ( transito_detalle.deta_secuencia = :is_secuencia ) AND  
         ( transito_detalle.deta_ann = :ii_ann )  ;	
	if sqlca.sqlcode = -1 then 
		ls_error = sqlca.sqlerrtext
		rollback ; 
		messagebox('Error al eliminar los Registros del Detalle de la transito ','Error : '+ls_error)
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

on w_transito_bk.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.cb_1=create cb_1
this.pb_2=create pb_2
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.dw_4
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.pb_2
this.Control[iCurrent+6]=this.st_1
end on

on w_transito_bk.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.cb_1)
destroy(this.pb_2)
destroy(this.st_1)
end on

event ue_post_open;call super::ue_post_open;dw_1.settransobject(sqlca);			
dw_2.settransobject(sqlca);	
ii_ann = year(date(gf_fecha_serv()))
datawindow = 1


this.triggerevent('ue_adicionar')

//Recupera la secuencia siguiente y da opcion para buscar una
wf_orden_nueva()

str.frame.setmicrohelp('Factura')
//il_tiempo = 150
//em_tiempo.text = string(150)
//timer(1)

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
	dw_1.setitem(1,'enca_g_financiero',str.g_financiero)
	dw_1.setitem(1,'enca_empresa',str.empresa)
	dw_1.setitem(1,'enca_ann',ii_ann)
	dw_1.setitem(1,'enca_fecha',date(gf_fecha_serv()))
	dw_1.setitem(1,'enca_fecha_despacho',date(gf_fecha_serv()))
	dw_1.setitem(1,'enca_fecha_llegada',date(gf_fecha_serv()))
	dw_1.setfocus()
	dw_1.setcolumn('enca_proveedor')
	wf_orden_nueva()
else
	if dw_2.getrow() > 0 then	
		if dw_2.getitemstring(dw_2.getrow(), 'deta_referencia') <> '' or &
			not isnull(dw_2.getitemstring(dw_2.getrow(), 'deta_referencia')) then
			dw_2.scrolltorow(dw_2.insertrow(0))
			dw_2.setitem(dw_2.getrow(),'deta_g_financiero',str.g_financiero)
			dw_2.setitem(dw_2.getrow(),'deta_empresa',str.empresa)
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
close(this)
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
end event

event open;//override
//gf_acelerador()

dw = dw_1 
this.y = 0
this.x = 805
//this.height = w_fa_fondo.height - 50

This.Icon = str.icono

pb_2.picturename = str.path+'\Art\NOTE04.BMP'

datawindowchild ldwc_provee
dw_1.getchild('enca_cliente',ldwc_provee)
ldwc_provee.settransobject(sqlca)
ldwc_provee.retrieve(str.g_financiero, str.empresa)

dw_1.getchild('enca_proveedor',ldwc_provee)
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
				gf_Mensaje("---Aviso---","¡Error al Actualizar Detalle de la Factura !!! "+ls_error,1,1,'E')
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
		  
		  str.frame.setmicrohelp('Factura Guardada.')
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
String  ls_find,ls_codigo
integer li_c, li_b
long    ll_lter
string  ls_lter,ls_des

Datawindow        dww
str_dg_dynamic_find	lstr_df

	lstr_df.texto_campo [1,1] = "transito.enca_secuencia"
	lstr_df.texto_campo [1,2] = "Secuencia"
	lstr_df.texto_campo [1,3] = "enca_secuencia"
	lstr_df.texto_campo [1,4] = 'V'
	lstr_df.texto_campo [1,5] = '280'	
	lstr_df.texto_campo [2,1] = "dgmterce.terc_descripcion"
	lstr_df.texto_campo [2,2] = "Proveedor"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '650'
	lstr_df.texto_campo [3,1] = "transito.enca_fecha"
	lstr_df.texto_campo [3,2] = "Fecha"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [3,5] = '285'
	lstr_df.texto_campo [4,1] = "transito.enca_documento"
	lstr_df.texto_campo [4,2] = "Factura Proveedor"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '385'
	lstr_df.tabla = " transito, dgmterce "
		
	lstr_df.tabla_where = &
				"WHERE (transito.enca_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(transito.enca_empresa = " + string(str.empresa) + ") 	and " +&
 						 "(transito.enca_ann = " + string(ii_ann) + ") 	and " +&
						"(transito.enca_proveedor = dgmterce.terc_tercero)"
	
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

event ue_eliminar;//override
Long resp
If dw.RowCount() > 0 Then
	
	If datawindow = 1 Then
		Resp = MessageBox("Aviso (Confirme el Siguiente Paso)",&
	 "¿ Esta Seguro que quiere borrar toda la Factura y su detalle  ?",Question!,YesNo!)
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

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_transito_bk
boolean visible = false
integer x = 46
integer y = 2040
integer width = 101
string text = ""
end type

type dw_1 from w_fa_padre`dw_1 within w_transito_bk
event ue_escape pbm_dwescape
integer x = 27
integer y = 12
integer width = 3662
integer height = 384
integer taborder = 10
string dataobject = "dw_transito_encabezado"
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
if dwo.name = 'b_1' then
	dw_3.dataobject = 'dw_proveedores'
	dw_3.title =	'Proveedores'
	dw_3.settransobject(sqlca)
	if dw_3.retrieve() = 0 then
		dw_3.insertrow(1)
	else
		ll_codigo	= dw_1.getitemnumber(1,'enca_proveedor')
		li_encontro = dw_3.find('prov_codigo = '+string(ll_codigo),1,dw_3.rowcount())
		if li_encontro > 0 then
			dw_3.scrolltorow(li_encontro)
		end if
	end if
	dw_3.setfocus()
	dw_3.width = 2500
	dw_3.x = 1493	
	dw_3.visible = true
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
	case 'enca_tipo'
		if gf_mensaje('','Esta Seguro de Cambiar el Tipo de la Factura del Proveedor ??',2,1,'E') = 1 then
			parent.triggerevent('ue_aceptar')
			for i = 1 to dw_2.rowcount()
				ls_producto = dw_2.getitemstring(i,'deta_referencia')
				update inmprodu set prod_cant_transito = 
				 ( SELECT isnull(sum(convert(numeric(17,0), transito_detalle.deta_cantidad * inamedid.medi_cantidad) ),0) 
					 FROM transito,   
							transito_detalle,   
							inamedid  
					WHERE ( transito_detalle.deta_g_financiero = transito.enca_g_financiero ) and  
							( transito_detalle.deta_empresa = transito.enca_empresa ) and  
							( transito_detalle.deta_secuencia = transito.enca_secuencia ) and  
							( transito_detalle.deta_ann = transito.enca_ann ) and  
							( transito_detalle.deta_unidad = inamedid.medi_medida ) and  
							( ( transito.enca_g_financiero = :str.g_financiero ) AND  
							( transito.enca_empresa = :str.empresa ) AND  
							( (transito_detalle.deta_cantidad * medi_cantidad ) - isnull(transito_detalle.deta_pasada,0) > 0 ) AND  
							( transito.enca_tipo = 0 ) ) and 
						( transito_detalle.deta_g_financiero = inmprodu.prod_g_financiero  and transito_detalle.deta_empresa = inmprodu.prod_empresa  and transito_detalle.deta_referencia = inmprodu.prod_producto) 
						 )
				  from inmprodu
				where prod_g_financiero = :str.g_financiero and prod_empresa = :str.empresa and prod_status = 1 and prod_producto = :ls_producto;

				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Actualizar Cantidad de transito '+sqlca.sqlerrtext,1,1,'E')
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

type st_ayuda from w_fa_padre`st_ayuda within w_transito_bk
integer x = 2793
integer y = 636
end type

type dw_2 from datawindow within w_transito_bk
event ue_enter pbm_dwnprocessenter
event ue_down pbm_dwnkey
event ue_helpcol ( )
integer x = 23
integer y = 408
integer width = 4027
integer height = 1248
integer taborder = 10
boolean bringtotop = true
boolean enabled = false
boolean titlebar = true
string title = "Detalle de la Factura del Proveedor"
string dataobject = "dw_transito_detalle"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_enter;if this.getcolumnname() = 'deta_bultos' then	
	if this.getrow() = this.rowcount() then
		parent.triggerevent('ue_aceptar')
		parent.triggerevent('ue_adicionar')
	else
		this.scrolltorow(this.getrow() + 1)
		this.setcolumn('deta_referencia')
	end if
elseif this.getcolumnname() = 'deta_referencia' then	
	this.setcolumn('deta_costo')
elseif this.getcolumnname() = 'deta_costo' then	
	this.setcolumn('deta_cantidad')	
elseif this.getcolumnname() = 'deta_cantidad' then	
	this.setcolumn('deta_bultos')	
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

end event

event clicked;datawindow = 2

if this.rowcount() = 0 then
	parent.triggerevent('ue_adicionar')
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

event itemchanged;string ls_codigo, ls_descripcion, ls_uni_empaque, ls_uni, ls_producto
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
			//Busca por modelo			
				  SELECT inmprodu.prod_descripcion,   
						inmprodu.prod_empaque,   
						inmprodu.prod_medida,   
						unidades_a.medi_cantidad,   
						unidades_b.medi_cantidad,
						inmprodu.prod_peso,
						inmprodu.prod_cubicaje,
						inmprodu.prod_costo_fob,
						inmprodu.prod_producto
				 INTO :ls_descripcion,   
						:il_empaque,   
						:ls_uni,   
						:ii_cantidad_unidad,   
						:ii_cantidad_empaque,
						:id_peso,
						:id_cubicaje,
						:id_costo,
						:ls_producto
				 FROM inmprodu,   
						inamedid unidades_a,   
						inamedid unidades_b  
				WHERE ( unidades_a.medi_medida = inmprodu.prod_medida ) and  
						( inmprodu.prod_empaque_um = unidades_b.medi_medida ) and  
						( ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
						( inmprodu.prod_empresa = :str.empresa ) AND  
						( inmprodu.prod_producto_dos = :ls_codigo ) )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al recuperar datos del producto modelo '+sqlca.sqlerrtext,1,1,'E')
						return 2
					end if
			if ls_descripcion = '' or isnull(ls_descripcion) then			
				gf_mensaje('','Referencia no Existe, Verifique !!!',1,1,'E')
				this.setitem(row,'deta_referencia','')
				this.setitem(row,'prod_descripcion','')
				this.setitem(row,'deta_costo',0.00)
				this.setcolumn('deta_referencia')
				return 2
			else
				this.setitem(row, 'prod_descripcion', ls_descripcion)
				this.setitem(row, 'deta_unidad', ls_uni)
				this.setitem(row, 'deta_costo', id_costo)
				this.setitem(row, 'deta_referencia', ls_producto)
				this.setcolumn('deta_costo')				
				return 2
			end if
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
	  SELECT  productos.prod_empaque,   
         unidades_a.medi_cantidad,   
         unidades_b.medi_cantidad,
			productos.prod_peso,
			productos.prod_cubicaje,
			productos.prod_costo
    INTO :il_empaque,   
         :ii_cantidad_unidad,   
         :ii_cantidad_empaque,
			:id_peso,
			:id_cubicaje,
			:id_costo
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

end event

type dw_3 from datawindow within w_transito_bk
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
			 FROM transito_detalle  
			WHERE ( transito_detalle.deta_g_financiero = :str.g_financiero ) AND  
					( transito_detalle.deta_empresa = :str.empresa ) AND  
					( transito_detalle.deta_referencia = :ls_codigo_anterior )  ;
			if sqlca.sqlcode = -1 then 
				gf_mensaje('','Error al Validar Detalle de la Factura '+sqlca.sqlerrtext,1,1,'E')
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

type dw_4 from datawindow within w_transito_bk
boolean visible = false
integer x = 55
integer y = 20
integer width = 3611
integer height = 1556
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Impresión de la Factura del Proveedor"
string dataobject = "dw_impresion_transito"
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

type cb_1 from commandbutton within w_transito_bk
boolean visible = false
integer x = 2848
integer y = 248
integer width = 512
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pasar Productos"
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
    FROM transito_detalle  
   WHERE ( transito_detalle.deta_g_financiero = :str.g_financiero ) AND  
         ( transito_detalle.deta_empresa = :str.empresa ) AND  
         ( transito_detalle.deta_secuencia = :ls_secuencia ) AND  
         ( transito_detalle.deta_ann = :li_ann ) ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al buscar detalle '+sqlca.sqlerrtext,1,1,'E')
		return
	end if
	
sqlca.autocommit = false

 if li_existe > 0 then
	if gf_mensaje('','La Factura tiene Detalle, desea Pasarlo Nuevamente ?',2,2,'E') = 1 then
		
		DELETE FROM transito_detalle  
		WHERE ( transito_detalle.deta_g_financiero = :str.g_financiero ) AND  
				( transito_detalle.deta_empresa = :str.empresa ) AND  
				( transito_detalle.deta_secuencia = :ls_secuencia ) AND  
				( transito_detalle.deta_ann = :li_ann ) ;
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
  SELECT productos.prod_producto,   
         productos.prod_descripcion,   
         productos.prod_empaque,   
         productos.prod_unidad,   
         productos.prod_unidad_empaque,   
         productos.prod_peso,   
         productos.prod_cubicaje,   
         productos.prod_costo,   
         productos.prod_cantidad  
    FROM productos  
   WHERE ( productos.prod_g_financiero = :str.g_financiero ) AND  
         ( productos.prod_empresa = :str.empresa ) AND  
         ( productos.prod_oc = :ls_oc ) ;
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
		FROM productos,   
				unidades unidades_a,   
				unidades unidades_b  
		WHERE ( unidades_a.medi_unidad = productos.prod_unidad ) and  
				( productos.prod_unidad_empaque = unidades_b.medi_unidad ) and  
				( ( productos.prod_g_financiero = :str.g_financiero ) AND  
				( productos.prod_empresa = :str.empresa ) AND  
				( productos.prod_producto = :ls_producto ) )   ;
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
	
		  INSERT INTO transito_detalle  
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

type pb_2 from picturebutton within w_transito_bk
integer x = 3451
integer y = 156
integer width = 178
integer height = 152
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "C:\Sistemas\HYMSOFT\Art\NOTE04.BMP"
alignment htextalign = left!
end type

event clicked;long ll_tercero
ll_tercero = dw_1.getitemnumber(1,'enca_proveedor')
str_cc_formatos str_formato2		
str_formato2.tercero = ll_tercero	
if ll_tercero > 0 then
	Opensheetwithparm(w_notas,str_formato2,str.frame,2,original!)
end if

end event

type st_1 from statictext within w_transito_bk
integer x = 3433
integer y = 316
integer width = 219
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "NOTAS"
alignment alignment = center!
boolean focusrectangle = false
end type

