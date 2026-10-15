//objectcomments Ventana para la Captura de Entradas
forward
global type w_entrada from w_fa_padre
end type
type dw_2 from datawindow within w_entrada
end type
type dw_3 from datawindow within w_entrada
end type
type dw_4 from datawindow within w_entrada
end type
type dw_5 from datawindow within w_entrada
end type
type cb_1 from commandbutton within w_entrada
end type
type cb_2 from commandbutton within w_entrada
end type
type dw_6 from datawindow within w_entrada
end type
type pb_1 from picturebutton within w_entrada
end type
type uo_1 from u_ddcalen within w_entrada
end type
end forward

global type w_entrada from w_fa_padre
integer x = 0
integer y = 0
integer width = 3835
integer height = 1932
string title = "Captura de Entrada de Mercancia"
string menuname = "m_hs"
boolean controlmenu = false
long backcolor = 82899184
event ue_syscommand pbm_syscommand
event ue_aceptar_por_linea ( )
dw_2 dw_2
dw_3 dw_3
dw_4 dw_4
dw_5 dw_5
cb_1 cb_1
cb_2 cb_2
dw_6 dw_6
pb_1 pb_1
uo_1 uo_1
end type
global w_entrada w_entrada

type variables
integer ii_ann, datawindow, il_row, ii_cantidad_unidad, ii_cantidad_empaque
String  is_entrada, is_unidad_empaque, is_actualiza, is_bodega_ubica_compra, is_concepto, is_documento, is_user
date	  idt_desde, idt_hasta
long    il_tiempo, il_segundos, il_secuencia, il_empaque
decimal{4} id_peso, id_cubicaje, id_costo
datawindowchild idw_child, idwc_grupo, idwc_region
str_in_parametros str_in
end variables

forward prototypes
public function boolean wf_recupera ()
public function boolean wf_child_productos ()
public function boolean wf_orden_nueva ()
public subroutine wf_setear_user (string as_user)
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

public function boolean wf_child_productos ();//override
String	ls_expresion
Integer	li_pos
datawindowchild ldwc_division, ldwc_subg, ldwc_clase, ldwc_arancel, ldwc_clase_prod, ldwc_tipo, &
					 ldwc_espec, ldwc_proveedor, ldwc_condicion, ldwc_color, ldwc_tama, ldwc_marca, ldwc_provee
dw = dw_6

sqlca.autocommit= true

dw_6.settransobject(sqlca)

dw_6.getchild('prod_division', ldwc_division)
ldwc_division.settransobject(sqlca)
ldwc_division.retrieve(str.g_financiero, str.empresa)
ldwc_division.insertrow(1)

dw_6.getchild('prod_grupo', idwc_grupo)
idwc_grupo.settransobject(sqlca)
idwc_grupo.retrieve(str.g_financiero, str.empresa)
idwc_grupo.insertrow(1)

dw_6.getchild('prod_marca', ldwc_marca)
ldwc_marca.settransobject(sqlca)
ldwc_marca.retrieve(str.g_financiero, str.empresa)
ldwc_marca.insertrow(1)

dw_6.getchild('prod_arancel', ldwc_arancel)
ldwc_arancel.settransobject(sqlca)
ldwc_arancel.retrieve(str.g_financiero, str.empresa)
ldwc_arancel.insertrow(1)

dw_6.getchild('prod_compuesto', ldwc_espec)
ldwc_espec.settransobject(sqlca)
ldwc_espec.retrieve(str.g_financiero, str.empresa)
ldwc_espec.insertrow(1)

dw_6.getchild('prod_color', ldwc_color)
ldwc_color.settransobject(sqlca)
ldwc_color.retrieve(str.g_financiero, str.empresa)
ldwc_color.insertrow(1)


dw_6.getchild('prod_cod_clase_tam', ldwc_tama)
ldwc_tama.settransobject(sqlca)
ldwc_tama.retrieve(str.g_financiero, str.empresa)
ldwc_tama.insertrow(1)

dw_6.getchild('prod_tercero', ldwc_provee)
ldwc_provee.settransobject(sqlca)
ldwc_provee.retrieve('P')
ldwc_provee.insertrow(1)


This.SetRedraw(True)

return true
end function

public function boolean wf_orden_nueva ();long ll_max
integer li_ann

//li_ann = year(date(gf_fecha_serv()))
//ii_ann = li_ann
dw_1.setitem(1,'tmov_anual',ii_ann)

select max(tmov_secuencia)
into	:ll_max
from intmovim
where tmov_g_financiero = :str.g_financiero and
		tmov_empresa		= :str.empresa and
		tmov_anual				= :ii_ann and
		tmov_tipo_transaccion = 'EN';
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

public subroutine wf_setear_user (string as_user);//Asigno el Usuario a la Variable de Instancia
is_user = as_user
end subroutine

on w_entrada.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.dw_5=create dw_5
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_6=create dw_6
this.pb_1=create pb_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.dw_4
this.Control[iCurrent+4]=this.dw_5
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.dw_6
this.Control[iCurrent+8]=this.pb_1
this.Control[iCurrent+9]=this.uo_1
end on

on w_entrada.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_6)
destroy(this.pb_1)
destroy(this.uo_1)
end on

event ue_post_open;//override
dw.settransobject(sqlca)

THIS.postevent("ue_hay_data")

dw_1.settransobject(sqlca);			
dw_2.settransobject(sqlca);	
dw_5.settransobject(sqlca);	
ii_ann = year(date(gf_fecha_serv()))
datawindow = 1

DataWindowChild dwc 
str_in.transaccion = 'EN'
is_concepto = '005'
dw_1.GetChild('tmov_concepto', dwc)
dwc.settransobject(sqlca)
if dwc.retrieve(str.g_financiero,str.empresa,'IN',str_in.transaccion) = 0 then
	dwc.insertrow(0)
end if

dw_1.GetChild('tmov_terceros', dwc)
dwc.settransobject(sqlca)
dwc.retrieve(str.g_financiero, str.empresa)
dwc.insertrow(1)

  SELECT crmparam.mpar_bodega+crmparam.mpar_ubicacion
    INTO :is_bodega_ubica_compra
    FROM crmparam  
   WHERE ( crmparam.mpar_g_financiero = :str.g_financiero ) AND  
         ( crmparam.mpar_empresa = :str.empresa )   ;
	if sqlca.sqlcode = -1 then
		mensaje('Aviso','Error al Seleccionar la Bodega y Ubicación en Compras',sqlca.sqlerrtext)
	end if

if isnull(is_bodega_ubica_compra) then is_bodega_ubica_compra = ' '


this.triggerevent('ue_adicionar')

//Recupera la secuencia siguiente y da opcion para buscar una
wf_orden_nueva()

str.frame.setmicrohelp('Entradas')
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
	dw_1.setitem(1,'tmov_g_financiero',str.g_financiero)
	dw_1.setitem(1,'tmov_empresa',str.empresa)
	dw_1.setitem(1,'tmov_autoriza',str.usuario)	
	dw_1.setitem(1,'tmov_id',str.usuario)		
	dw_1.setitem(1,'tmov_anual',ii_ann)
	dw_1.setitem(1,'tmov_fecha',date(gf_fecha_serv()))
	dw_1.setfocus()
	dw_1.setcolumn('tmov_documento')
	wf_orden_nueva()
else
	if dw_2.getrow() > 0 then	
		if dw_2.getitemstring(dw_2.getrow(), 'dmov_producto') <> '' or &
			not isnull(dw_2.getitemstring(dw_2.getrow(), 'dmov_producto')) then
			dw_2.scrolltorow(dw_2.insertrow(0))
			dw_2.setitem(dw_2.getrow(),'dmov_g_financiero',str.g_financiero)
			dw_2.setitem(dw_2.getrow(),'dmov_empresa',str.empresa)
			dw_2.setitem(dw_2.getrow(),'dmov_aplicacion','IN')
			dw_2.setitem(dw_2.getrow(),'dmov_tipo_transaccion','EN')
			dw_2.setitem(dw_2.getrow(),'dmov_concepto',is_concepto)
			dw_2.setitem(dw_2.getrow(),'dmov_documento',is_documento)			
		end if
	else
		dw_2.scrolltorow(dw_2.insertrow(0))
		dw_2.setitem(dw_2.getrow(),'dmov_g_financiero',str.g_financiero)
		dw_2.setitem(dw_2.getrow(),'dmov_empresa',str.empresa)
		dw_2.setitem(dw_2.getrow(),'dmov_aplicacion','IN')
		dw_2.setitem(dw_2.getrow(),'dmov_tipo_transaccion','EN')
		dw_2.setitem(dw_2.getrow(),'dmov_concepto',is_concepto)		
		dw_2.setitem(dw_2.getrow(),'dmov_documento',is_documento)					
	end if
	dw_2.setitem(dw_2.getrow(),'dmov_linea',dw_2.getrow())
	dw_2.setfocus()
	dw_2.setcolumn('dmov_producto')
end if

end event

event key;//override
end event

event close;

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
end event

event open;//override
this.y = 0
this.x = 805
//this.height = w_fa_fondo.height - 50

gf_acelerador()
dw = dw_1

This.Icon = str.icono

this.postevent("ue_post_open")


This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)

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

if dw_1.getitemnumber(1, 'tmov_estado') <> 0 then
	gf_mensaje('','La Entrada ya fue Actualizada, Verifique !!!',1,1,'E')
	return
end if


if (dw_1.getitemNumber(1,"tmov_terceros")) = 0 or isnull(dw_1.getitemNumber(1,"tmov_terceros")) then
	gf_mensaje("Atencion Sr. Usuario","Debe asignar el proveedor antes de guardar.",1,1,'E')
	dw_1.setcolumn("tmov_terceros")
	return
end if	


sqlca.autocommit = false

indice = 0

il_secuencia = dw_1.getitemNumber(1,"tmov_secuencia")

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
	
	if (dw_1.getitemNumber(1,"tmov_secuencia")) = 0 or isnull(dw_1.getitemNumber(1,"tmov_secuencia")) then
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
		gf_Mensaje("---Atención---","¡Error al Actualizar el encabezado !" +ls_error,1,1,'E')
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
	ls_producto = dw_2.getitemstring(li_contador,"dmov_producto")
	if ls_producto = "" or isnull(ls_producto) then		
		dw_2.deleterow(li_contador)
		li_contador --
	End If
	dw_2.setitem(li_contador,'dmov_secuencia',il_secuencia)
	dw_2.setitem(li_contador,'dmov_anual',ii_ann)
	dw_2.setitem(li_contador,"dmov_linea",li_contador)
	dw_2.setitem(li_contador,"dmov_aplicacion",'IN')
	dw_2.setitem(li_contador,"dmov_tipo_transaccion",'EN')
	dw_2.setitem(li_contador,"dmov_concepto",is_concepto)
	dw_2.setitem(li_contador,"dmov_g_financiero",str.g_financiero)
	dw_2.setitem(li_contador,"dmov_empresa",str.empresa)
	dw_2.setitem(li_contador,"dmov_documento",is_documento)
	
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
		  dw_1.retrieve(str.g_financiero, str.empresa, il_secuencia, ii_ann )
		  dw_2.retrieve(str.g_financiero, str.empresa, il_secuencia, ii_ann )
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
		  
		  str.frame.setmicrohelp('Entrada Guardada.')
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
dw_1.accepttext()
Datawindow        dww
str_dg_dynamic_find	lstr_df

	lstr_df.texto_campo [1,1] = "intmovim.tmov_documento"
	lstr_df.texto_campo [1,2] = "Documento"
	lstr_df.texto_campo [1,3] = ""
	lstr_df.texto_campo [1,4] = 'V'
	lstr_df.texto_campo [1,5] = '280'	
	lstr_df.texto_campo [2,1] = "dgmterce.terc_descripcion"
	lstr_df.texto_campo [2,2] = "Proveedor"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '650'
	lstr_df.texto_campo [3,1] = "intmovim.tmov_fecha"
	lstr_df.texto_campo [3,2] = "Fecha"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [3,5] = '285'
	lstr_df.texto_campo [4,1] = "intmovim.tmov_secuencia"
	lstr_df.texto_campo [4,2] = "Secuencia"
	lstr_df.texto_campo [4,3] = "tmov_secuencia"
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '280'	
	
	lstr_df.tabla = " intmovim, dgmterce "
		
	lstr_df.tabla_where = &
				"WHERE (intmovim.tmov_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(intmovim.tmov_empresa = " + string(str.empresa) + ") 	and " +&
 						 "(intmovim.tmov_anual = " + string(ii_ann) + ") 	and " +&
						 "(intmovim.tmov_tipo_transaccion = 'EN' ) and " +&
						"(intmovim.tmov_terceros = dgmterce.terc_tercero)"
	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm



If len (ls_find) = 0 Then Return
	
ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)
il_secuencia = long(ls_codigo)
dw_1.retrieve(str.g_financiero, str.empresa, il_secuencia, ii_ann )
is_concepto  = dw_1.getitemstring(1,'tmov_concepto')
is_documento = dw_1.getitemstring(1,'tmov_documento')
dw_2.reset()
dw_2.retrieve(str.g_financiero, str.empresa, il_secuencia, ii_ann )
dw_2.scrolltorow(dw_2.rowcount())
dw_2.setfocus()
end event

event ue_eliminar;//override
if datawindow = 1 then	
	if dw_1.getitemnumber(1,'tmov_estado') <> 0 then
		gf_mensaje('','No Puede Eliminar una Entrada Actualizada, Verifique !!!',1,1,'E')
		return
	end if
	if gf_mensaje('','Esta Seguro de Eliminar la Entrada ?',2,2,'E') = 1 then
		sqlca.autocommit = false
	  DELETE FROM indmovim  
		WHERE ( indmovim.dmov_g_financiero = :str.g_financiero ) AND  
				( indmovim.dmov_empresa = :str.empresa ) AND  
				( indmovim.dmov_aplicacion = 'IN' ) AND  
				( indmovim.dmov_tipo_transaccion = 'EN' ) AND  
				( indmovim.dmov_secuencia = :il_secuencia ) AND  
				( indmovim.dmov_anual = :ii_ann )  ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al eliminar detalle ' + sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if
	
	  DELETE FROM indgasto  
		WHERE ( indgasto.gast_g_financiero = :str.g_financiero ) AND  
				( indgasto.gast_empresa = :str.empresa ) AND  
				( indgasto.gast_aplicacion = 'IN' ) AND  
				( indgasto.gast_transaccion = 'EN' ) AND  
				( indgasto.gast_secuencia = :il_secuencia ) AND  
				( indgasto.gast_ann = :ii_ann )  ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al eliminar gastos ' + sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if
	
	
	  DELETE FROM intmovim  
		WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
				( intmovim.tmov_empresa = :str.empresa ) AND  
				( intmovim.tmov_aplicacion = 'IN' ) AND  
				( intmovim.tmov_tipo_transaccion = 'EN' ) AND  
				( intmovim.tmov_secuencia = :il_secuencia ) AND  
				( intmovim.tmov_anual = :ii_ann )  ;
	
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

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_entrada
boolean visible = false
integer x = 46
integer y = 2040
integer width = 101
string text = ""
end type

type dw_1 from w_fa_padre`dw_1 within w_entrada
event ue_escape pbm_dwescape
integer x = 27
integer y = 12
integer width = 3730
integer height = 380
integer taborder = 10
string dataobject = "dw_entrada_encabezado"
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

event dw_1::buttonclicked;call super::buttonclicked;long ll_codigo, ll_dias
date ldt_fecha, ldt_actual
integer li_encontro
if dwo.name = 'b_modificar' then
	ldt_actual = date(gf_fecha_serv())
	ldt_fecha = date(dw_1.getitemdatetime(1,'tmov_fecha'))
	ll_dias = DaysAfter(ldt_fecha, ldt_actual)
	if ll_dias > 31 then
		gf_mensaje('','Entrada fuera del periodo de modificacion, Verifique !!!',1,1,'E')
		return
	end if
	
	OpenWithParm(w_clave_autorizada, parent)
	If is_user <> "*" then
		dw_1.setitem(1,'tmov_estado',0)
		ll_codigo	= dw_1.getitemnumber(1,'tmov_terceros')
		  UPDATE intmovim  
			  SET tmov_activada_por = :str.usuario,   
					tmov_fecha_activacion = getdate()  
			WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
					( intmovim.tmov_empresa = :str.empresa ) AND  
					( intmovim.tmov_aplicacion = 'IN' ) AND  
					( intmovim.tmov_tipo_transaccion = 'EN' ) AND  
					( intmovim.tmov_secuencia = :il_secuencia ) AND  
					( intmovim.tmov_anual = :ii_ann )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Actualizar Activado por.. '+sqlca.sqlerrtext,1,1,'E')
				end if
	end if	
	dw_1.accepttext()
elseif dwo.name = 'b_1' then
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

event dw_1::itemchanged;call super::itemchanged;datetime ldt_fecha_tran, ldt_fecha_anterior
integer li_ann_anterior
accepttext()
choose case this.getcolumnname()
	case 'tmov_concepto'
		is_concepto = data
	case 'tmov_documento'
		is_documento = data
	case 'tmov_anual'
		ii_ann = integer(data)
		datawindow = 1
		parent.triggerevent('ue_adicionar')
	case 'tmov_fecha'
		
		ldt_fecha_tran 	 = this.getitemdatetime(this.getrow(),'tmov_fecha')		
		ldt_fecha_anterior = this.getitemdatetime(this.getrow(),'tmov_fecha', Primary!, True)		
		ii_ann = year(date(this.getitemdatetime(this.getrow(),'tmov_fecha')))
		li_ann_anterior = dw_1.getitemnumber(1,'tmov_anual')
		
		if not gf_valida_fecha_futura(ldt_fecha_tran) then			
			if ldt_fecha_tran = ldt_fecha_anterior then
				dw_1.setitem(1,'tmov_fecha', date(gf_fecha_serv()))				
			else
				dw_1.setitem(1,'tmov_fecha', ldt_fecha_anterior)
			end if
			dw_1.setcolumn('tmov_fecha')
			return 2
		end if
		
		//Si los anios son diferentes asigna el anio
		if ii_ann <> li_ann_anterior then
			dw_1.setitem(1,'tmov_anual',ii_ann)
		end if

end choose
end event

type st_ayuda from w_fa_padre`st_ayuda within w_entrada
integer x = 2793
integer y = 636
end type

type dw_2 from datawindow within w_entrada
event ue_enter pbm_dwnprocessenter
event ue_down pbm_dwnkey
event ue_helpcol ( )
integer x = 18
integer y = 408
integer width = 3753
integer height = 1248
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle de la Orden"
string dataobject = "dw_entrada_detalle"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_enter;if this.getcolumnname() = 'dmov_cantidad' then		
	if this.getrow() = this.rowcount() then
		parent.triggerevent('ue_aceptar')
   	datawindow = 2		
		parent.triggerevent('ue_adicionar')
	else
		this.scrolltorow(this.getrow() + 1)
		this.setcolumn('dmov_producto')
	end if
elseif this.getcolumnname() = 'dmov_producto' then	
	this.setcolumn('dmov_costo_fob')
elseif this.getcolumnname() = 'dmov_costo_fob' then	
	this.setcolumn('dmov_cantidad')	
end if

return 2
end event

event ue_down;//override
// Toma la Tecla que el usuario presione

CHOOSE CASE key
		
	CASE KeyF1! 
		if this.getcolumnname() = 'dmov_producto' then
			This.Postevent("ue_helpcol")
		end if
		
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

	lstr_df.texto_campo [1,1] = "inmprodu.prod_producto"
	lstr_df.texto_campo [1,2] = "Referencia"
	lstr_df.texto_campo [1,3] = "prod_producto"
	lstr_df.texto_campo [1,4] = 'V'
//	lstr_df.texto_campo [1,5] = '280'	
	lstr_df.texto_campo [2,1] = "inmprodu.prod_descripcion"
	lstr_df.texto_campo [2,2] = "Descripcion"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '770'
//	lstr_df.texto_campo [3,1] = "orden.enca_fecha"
//	lstr_df.texto_campo [3,2] = "Fecha"
//	lstr_df.texto_campo [3,3] = ""
//	lstr_df.texto_campo [3,4] = 'V'
//	lstr_df.texto_campo [3,5] = '285'
	lstr_df.tabla = " inmprodu "
		
	lstr_df.tabla_where = &
				"WHERE (inmprodu.prod_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(inmprodu.prod_empresa = " + string(str.empresa) + ") "	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm



If len (ls_find) = 0 Then Return
	
ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)
this.setitem(this.getrow(),'dmov_producto',ls_codigo)
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
if dwo.name = 'b_productos' then
	
	string ls_producto
	str_kardex  str_opcion
			
	if dw_2.rowcount() > 0 then
		ls_producto = dw_2.getitemstring(dw_2.getrow(),'dmov_producto')				
	end if			
	str_opcion.kproducto=ls_producto
	
	OpenSheetWithParm(w_productos,str_opcion,str.frame,2,Original!)		
	
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


if this.getcolumnname() = 'dmov_producto' then
	  ls_codigo = data
	  SELECT inmprodu.prod_descripcion,   
         inmprodu.prod_empaque,   
         inmprodu.prod_medida,   
         inamedid_a.medi_cantidad,   
         inamedid_b.medi_cantidad,
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
		if ls_descripcion = '' or isnull(ls_descripcion) then
			gf_mensaje('','Referencia no Existe, Verifique !!!',1,1,'E')
			this.setitem(row,'dmov_producto','')
			this.setcolumn('dmov_producto')
			return 2
		else
			this.setitem(row, 'prod_descripcion', ls_descripcion)
			this.setitem(row, 'dmov_unidad_medida', ls_uni)
			this.setitem(row, 'dmov_costo_fob', id_costo)
			this.setitem(row, 'medi_cantidad',ii_cantidad_unidad)
			this.setcolumn('dmov_costo_fob')
		end if
elseif this.getcolumnname() = 'dmov_cantidad' then
	ll_cantidad = long(data)	
	if il_empaque <> 0 and ii_cantidad_empaque <> 0 then
		ll_bultos = (ll_cantidad * ii_cantidad_unidad ) / (il_empaque * ii_cantidad_empaque)
	end if
	if ll_bultos = 0 then ll_bultos = 1
	if this.getrow() = this.rowcount() then
		parent.triggerevent('ue_adicionar')
	else
		this.scrolltorow(this.getrow() + 1)
		this.setcolumn('dmov_producto')
	end if	
//	this.setitem(row,'dmov_bulto',ll_bultos)
//	this.setitem(row,'dmov_peso',ll_bultos * id_peso)
//	this.setitem(row,'dmov_cubicaje',round(ll_bultos * id_cubicaje,4))		
//	this.setcolumn('dmov_bulto')
elseif this.getcolumnname() = 'dmov_costo_fob' then	
	this.setcolumn('dmov_cantidad')
//elseif this.getcolumnname() = 'dmov_bulto' then	

end if
end event

type dw_3 from datawindow within w_entrada
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
boolean vscrollbar = true
string icon = "AppIcon!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;integer i
string ls_producto
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

type dw_4 from datawindow within w_entrada
boolean visible = false
integer x = 55
integer y = 20
integer width = 3611
integer height = 1876
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Impresión de la Entrada"
string dataobject = "dw_rep_entrada"
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

type dw_5 from datawindow within w_entrada
boolean visible = false
integer x = 1829
integer y = 256
integer width = 1691
integer height = 764
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Gastos de las Entradas"
string dataobject = "dw_gastos_entradas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;decimal{2} ld_gasto_total		

choose case dwo.name
	case 'b_cerrar'	
		if this.update() = -1 then
			gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return
		end if		
		if this.rowcount() > 0 then
			ld_gasto_total = this.getitemnumber(1,'gasto_total')
		else
			ld_gasto_total = 0
		end if
		
		UPDATE intmovim  
		  SET tmov_total_cargos = :ld_gasto_total  
		WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
				( intmovim.tmov_empresa = :str.empresa ) AND  
				( intmovim.tmov_aplicacion = 'IN' ) AND  
				( intmovim.tmov_tipo_transaccion = 'EN' ) AND  
				( intmovim.tmov_secuencia = :il_secuencia ) AND  
				( intmovim.tmov_anual = :ii_ann )  ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al grabar los cargos totales '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return
		end if
		
		commit;		
		this.visible = false
	case 'b_adicionar'
		if this.rowcount() < 3 then
			this.scrolltorow(this.insertrow(0))
			dw_5.setitem(this.getrow(),'gast_g_financiero',str.g_financiero)
			dw_5.setitem(this.getrow(),'gast_empresa',str.empresa)
			dw_5.setitem(this.getrow(),'gast_secuencia',il_secuencia)
			dw_5.setitem(this.getrow(),'gast_concepto',is_concepto)			
			dw_5.setitem(this.getrow(),'gast_ann',ii_ann)
			dw_5.setitem(this.getrow(),'gast_linea',this.getrow())
		end if
	case	'b_grabar'

		if this.update() = -1 then
			gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return
		end if
		if this.rowcount() = 0 then 
			ld_gasto_total = 0
		else
			ld_gasto_total = this.getitemnumber(1,'gasto_total')
		end if
		
		UPDATE intmovim  
		  SET tmov_total_cargos = :ld_gasto_total  
		WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
				( intmovim.tmov_empresa = :str.empresa ) AND  
				( intmovim.tmov_aplicacion = 'IN' ) AND  
				( intmovim.tmov_tipo_transaccion = 'EN' ) AND  
				( intmovim.tmov_secuencia = :il_secuencia ) AND  
				( intmovim.tmov_anual = :ii_ann )  ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al grabar los cargos totales '+sqlca.sqlerrtext,1,1,'E')
			rollback;
			return
		end if
		
		commit;
		
end choose
end event

type cb_1 from commandbutton within w_entrada
integer x = 2926
integer y = 32
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
string text = "Gastos"
end type

event clicked;integer li_existe

if dw_1.getitemnumber(1, 'tmov_estado') <> 0 then
	gf_mensaje('','La Entrada ya fue Actualizada, Verifique !!!',1,1,'E')
	return
end if

if dw_5.retrieve(str.g_financiero, str.empresa, il_secuencia, ii_ann) = 0 then
	select count(*) into :li_existe
	from intmovim where tmov_g_financiero = :str.g_financiero and tmov_empresa = :str.empresa and
							  tmov_aplicacion = 'IN' and tmov_tipo_transaccion = 'EN' and tmov_secuencia = :il_secuencia and
							  tmov_anual = :ii_ann ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al validar encabezado '+sqlca.sqlerrtext,1,1,'E')
					return
				end if
	if li_existe > 0 then
		dw_5.scrolltorow(dw_5.insertrow(1))
		dw_5.setitem(1,'gast_g_financiero',str.g_financiero)
		dw_5.setitem(1,'gast_empresa',str.empresa)
		dw_5.setitem(1,'gast_secuencia',il_secuencia)
		dw_5.setitem(1,'gast_concepto',is_concepto)			
		dw_5.setitem(1,'gast_ann',ii_ann)
		dw_5.setitem(1,'gast_linea',1)
	else
		return
	end if
end if
dw_5.visible = true
dw_5.setfocus()
end event

type cb_2 from commandbutton within w_entrada
integer x = 2912
integer y = 148
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

event clicked;/*ADD BY HGN 15/08/2002 PARA QUE ACTUALICE COSTO CIF*/	
	String	ls_concepto, ls_costo_proc , ls_dbcode, ls_errtext, ls_producto, ls_error
	integer i
	decimal{2} ld_costo_fob
	
	if gf_mensaje('','Esta Seguro de Actualizar la Entrada ?',2,1,'E') = 2 then return

		for i = 1 to dw_2.rowcount()
			ls_producto			= dw_2.getitemstring(i,'dmov_producto')
			ld_costo_fob		= dw_2.getitemnumber(i,'dmov_costo_fob')			
			
		  UPDATE inmprodu  
			  SET prod_costo_fob = :ld_costo_fob,   
					prod_costo_cif = :ld_costo_fob,   
					prod_costo_promedio = :ld_costo_fob  
			WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
					( inmprodu.prod_empresa = :str.empresa ) AND  
					( inmprodu.prod_producto = :ls_producto )  ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Actualizar producto '+sqlca.sqlerrtext,1,1,'E')
					rollback;
					sqlca.autocommit = true
					return
				end if
			
		next


  SELECT forma_datawindow  
    INTO :ls_costo_proc  
    FROM inaforma  
   WHERE ( inaforma.forma_tipo_formato = 'P' ) AND  
         ( inaforma.forma_formato_clase = 'C' )   ;

		if sqlca.sqlcode = -1 then
			ls_errtext = sqlca.sqlerrtext
			ls_dbcode = ' # '+string(sqlca.sqldbcode)
			rollback;
			mensaje('Error'+ls_dbcode,'Se ha producido un error al leer procedimiento de cálculo del costo cif',ls_errtext)
			sqlca.autocommit = true
			return
		end if

	str.frame.setmicrohelp("Actualizando el Costo Cif de la Entrada")

			ls_costo_proc=ls_costo_proc+" "+string(str.g_financiero)+","+string(str.empresa)+"," &
							 +string(il_secuencia)+","+string(ii_ann)  +",'"+is_concepto+"'"

			execute immediate :ls_costo_proc;
			
			 If Sqlca.sqlcode = -1 Then
				 gf_mensaje("","¡Error al Actualizar El Costo Cif! " +sqlca.sqlerrtext,1,1,'E')
				 Rollback;
				sqlca.autocommit = true
				return
			 End If 
	/**/
	dw_1.setitem(1,'tmov_estado',1)
	if dw_1.update() =1 then
		 commit using sqlca;
	else
		ls_error =sqlca.sqlerrtext
		rollback using sqlca;
		sqlca.autocommit = true
		gf_Mensaje("---Atención---","¡Error al Actualizar el encabezado !" +ls_error,1,1,'E')
		ib_aceptar = False
		is_actualiza=''
		return
	end if
	 sqlca.autocommit = true

end event

type dw_6 from datawindow within w_entrada
event ue_helpcol ( )
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 773
integer y = 124
integer width = 2565
integer height = 1744
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Productos"
boolean controlmenu = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_helpcol();//Busqueda del producto
//
String  ls_find,ls_codigo
integer li_c, li_b
long    ll_lter
string  ls_lter,ls_des

Datawindow        dww
str_dg_dynamic_find	lstr_df

	lstr_df.texto_campo [1,1] = "inmprodu.prod_producto"
	lstr_df.texto_campo [1,2] = "Referencia"
	lstr_df.texto_campo [1,3] = "prod_producto"
	lstr_df.texto_campo [1,4] = 'V'
//	lstr_df.texto_campo [1,5] = '280'	
	lstr_df.texto_campo [2,1] = "inmprodu.prod_descripcion"
	lstr_df.texto_campo [2,2] = "Descripcion"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '770'
//	lstr_df.texto_campo [3,1] = "orden.enca_fecha"
//	lstr_df.texto_campo [3,2] = "Fecha"
//	lstr_df.texto_campo [3,3] = ""
//	lstr_df.texto_campo [3,4] = 'V'
//	lstr_df.texto_campo [3,5] = '285'
	lstr_df.tabla = " inmprodu "
		
	lstr_df.tabla_where = &
				"WHERE (inmprodu.prod_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(inmprodu.prod_empresa = " + string(str.empresa) + ") "	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm



If len (ls_find) = 0 Then Return
	
ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
gf_replace_cadena(ls_codigo,"'"," ")
ls_codigo = Trim(ls_codigo)
this.setitem(this.getrow(),'prod_producto',ls_codigo)
this.accepttext()
this.trigger event itemchanged(this.getrow(), object, ls_codigo)
end event

event ue_keydown;//override
CHOOSE CASE key
		
	CASE KeyF1! 

			if this.dataobject = 'dw_producto' then
				This.Postevent("ue_helpcol")
			end if
end choose
end event

event itemchanged;String ls_codigo, ls_nulo
long 	 ll_fila, ll_tercero, ll_pais
integer li_existe

this.accepttext()
Setnull(ls_nulo)

choose case this.getcolumnname() 
	case  "prod_producto"
		str.frame.setredraw(false)
		data = this.getitemstring(this.getrow(), 'prod_producto')
		if this.retrieve(str.g_financiero, str.empresa, data) = 0 then
			this.insertrow(1)
			this.setitem(1,'prod_g_financiero',str.g_financiero)
			this.setitem(1,'prod_empresa',str.empresa)
			this.setitem(1,'prod_producto',data)
			this.setcolumn('prod_producto')
		end if
		str.frame.setredraw(true)		
end choose
end event

event buttonclicked;integer i, li_conteo
datawindowchild ldwc_proveedor
string ls_division, ls_producto
long ll_pais, ll_tercero, ll_row
THIS.ACCEPTTEXT()

choose case dwo.name 						
	case 'b_kardex'
		Window lw_child_v				
		str_kardex  str_opcion
		
		str_opcion.opcion_menu = 'MCP'
		str_opcion.opcion_ventana    = 'P'
		str_opcion.dwpantalla     = 'dw_in_mcp_prod_kard_1'
		str_opcion.dwreporte      = 'dw_in_mcp_prod_kard_2'
		str_opcion.titulo_ventana = 'Movimiento del Producto (Kardex)'
		
		if this.rowcount() > 0 then
			ls_producto = this.getitemstring(this.getrow(),'prod_producto')				
		end if
		
		str_opcion.kproducto=ls_producto
	
		OpenSheetWithParm(lw_child_v,str_opcion,"w_in_movi_prod_kardex",str.frame,2,Original!)		
		
	case 'b_adicionar_producto'
		this.reset()
		this.scrolltorow(this.insertrow(0))
		this.setitem(this.getrow(),'prod_g_financiero', str.g_financiero)
		this.setitem(this.getrow(),'prod_empresa', str.empresa)
	case 'b_grabar_producto'
		if this.getitemstring(1,'prod_producto') = '' or isnull(this.getitemstring(1,'prod_producto')) then 
			gf_mensaje('','Debe asignar el codigo del producto para grabar, verifique !!!',1,1,'E')
			return 2
		end if
		if this.getitemstring(1,'prod_descripcion') = '' or isnull(this.getitemstring(1,'prod_descripcion')) then 
			gf_mensaje('','Debe asignar la descripcion del producto para grabar, verifique !!!',1,1,'E')
			return 2
		end if		
		if this.update() = -1 then
			gf_mensaje('','Error al actualizar los productos '+sqlca.sqlerrtext,1,1,'E')
		else
			commit;
		end if		
	case 'b_cerrar_producto'
		if this.getitemstring(1,'prod_producto') = '' or isnull(this.getitemstring(1,'prod_producto')) then 
			this.visible = false
			dw_2.setfocus()
			return
		end if			
		if this.update() = -1 then
			gf_mensaje('','Error al actualizar los productos '+sqlca.sqlerrtext,1,1,'E')
		end if		
		this.visible = false
	case 'b_eliminar_producto'
		ls_producto = this.getitemstring(1,'prod_producto')
		if ls_producto = '' or isnull(ls_producto) then return 		
		
		select count(*)
		into :li_conteo
		from indmovim
		where dmov_g_financiero = :str.g_financiero and
				dmov_empresa		= :str.empresa and
				dmov_producto		= :ls_producto ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al verificar existencia '+sqlca.sqlerrtext,1,1,'E')
				end if
		
		if li_conteo > 0 then
			gf_mensaje('','No se puede eliminar un producto que tiene movimientos, verifique el kardex !!!',1,1,'E')
			return
		end if
		
		if gf_mensaje('','Esta seguro de eliminar el producto ?',2,1,'E') = 2 then return
				
		this.deleterow(this.getrow())
		
		if this.update() = -1 then
			gf_mensaje('','Error al eliminar los productos '+sqlca.sqlerrtext,1,1,'E')
		end if		
		this.reset()
		this.scrolltorow(this.insertrow(0))
		this.setitem(this.getrow(),'prod_g_financiero', str.g_financiero)
		this.setitem(this.getrow(),'prod_empresa', str.empresa)				
	case else
		
		//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
		//en la misma columna.
		
		string ls_objeto
		integer li_pos 
		
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
	
		
end choose

end event

type pb_1 from picturebutton within w_entrada
integer x = 3392
integer y = 268
integer width = 347
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
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

type uo_1 from u_ddcalen within w_entrada
boolean visible = false
integer x = 1289
integer y = 116
integer taborder = 40
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;datetime ldt_fecha_tran, ldt_fecha_anterior
integer li_ann_anterior
dw_1.SetItem ( dw_1.getrow(), 'tmov_fecha', uo_1.return_sel_date() )

if uo_1.allow_close then
	this.visible=false
	dw_1.SetFocus()
	
		ldt_fecha_tran 	 = dw_1.getitemdatetime(dw_1.getrow(),'tmov_fecha')		
		ldt_fecha_anterior = dw_1.getitemdatetime(dw_1.getrow(),'tmov_fecha', Primary!, True)		
		ii_ann = year(date(dw_1.getitemdatetime(dw_1.getrow(),'tmov_fecha')))
		li_ann_anterior = dw_1.getitemnumber(1,'tmov_anual')
		
		if not gf_valida_fecha_futura(ldt_fecha_tran) then			
			if ldt_fecha_tran = ldt_fecha_anterior then
				dw_1.setitem(1,'tmov_fecha', date(gf_fecha_serv()))				
			else
				dw_1.setitem(1,'tmov_fecha', ldt_fecha_anterior)
			end if
			dw_1.setcolumn('tmov_fecha')
		end if
		
		//Si los anios son diferentes asigna el anio
		if ii_ann <> li_ann_anterior then
			dw_1.setitem(1,'tmov_anual',ii_ann)
		end if
	
end if


end event

on uo_1.destroy
call u_ddcalen::destroy
end on

