//objectcomments ventana de ajuste de existencias y costos
forward
global type w_captura_notas_credito from w_in_padre
end type
type ln_1 from line within w_captura_notas_credito
end type
type cbx_1 from checkbox within w_captura_notas_credito
end type
type dw_3 from datawindow within w_captura_notas_credito
end type
type cbx_ubicacion from checkbox within w_captura_notas_credito
end type
type cb_1 from commandbutton within w_captura_notas_credito
end type
type cb_2 from commandbutton within w_captura_notas_credito
end type
type dw_4 from datawindow within w_captura_notas_credito
end type
end forward

global type w_captura_notas_credito from w_in_padre
integer x = 0
integer y = 0
integer width = 3840
integer height = 2512
string title = "(IN) Captura de Notas de Credito"
string menuname = "m_hs"
boolean controlmenu = false
boolean maxbox = false
long backcolor = 12639424
event ue_micro_ayuda pbm_nchittest
ln_1 ln_1
cbx_1 cbx_1
dw_3 dw_3
cbx_ubicacion cbx_ubicacion
cb_1 cb_1
cb_2 cb_2
dw_4 dw_4
end type
global w_captura_notas_credito w_captura_notas_credito

type variables
datawindowchild dwc,dwc_med,dwc_bod,dwc_ubic,dch_sec,dwc_prod, idwc_tipo
integer ii_secuencia, li_secuencia,is_definicion, ii_ann
string is_producto,ii_bodega,ii_ubicacion, is_unidad_venta,is_user, is_ubicacion, is_secuencia, is_documento

str_in_parametros str_in

integer ii_entre = 0, ii_cantidad_decimal

Boolean	ib_cerrar, ib_primera_vez = true
datastore ids_kardex

/*fecha de la entrada */
date         id_fecha2 
datetime idt_fecha

end variables

forward prototypes
public subroutine wf_desabilitar_botones ()
public function integer wf_verificar_ubicacion (string li_bodega, string li_ubicacion, string ls_producto, integer li_empresa)
public function integer wf_verificar_bodega (string ls_producto, string li_bodega, integer li_empresa)
public subroutine wf_ubicacion ()
public subroutine wf_setear_user (string as_user)
public subroutine wf_producto ()
public subroutine wf_prod_convert (string as_producto, ref decimal ad_costo_cif, ref string as_prod_medida, ref decimal ad_prod_convert, ref integer ad_sqlca)
public subroutine wf_mover (string ac_a_donde)
public subroutine wf_cargarchild_dw_1 ()
public subroutine wf_cargarchild_dw_2 ()
public subroutine wf_validar_ayuda ()
public function boolean wf_orden_nueva ()
public function integer medida ()
public subroutine wf_buscar_producto ()
public subroutine wf_eliminar_todo ()
public subroutine wf_eliminar_detalle ()
end prototypes

public subroutine wf_desabilitar_botones ();//Si el Estado de la Transaccion es Actualizado por Lotes o Cierres de Inventario
//desabilitamos los botones de adicionar, insertar, eliminar, guardar**********//

Integer li_estado
li_estado = dw_1.GetItemNumber(dw_1.GetRow(),'tmov_estado')

If li_estado = 2 Or li_estado = 3 Then
	m_in_principal.m_archivo.m_guardar.enabled = False
	m_in_principal.m_edicion.m_adicionar.enabled = False
	m_in_principal.m_edicion.m_insertar.enabled = False
	m_in_principal.m_edicion.m_eliminar.enabled = False
	
End If
end subroutine

public function integer wf_verificar_ubicacion (string li_bodega, string li_ubicacion, string ls_producto, integer li_empresa);/*Valida la ubicacion del ajuste*/

string ls_prod
integer valor,li_existe

select count(*)
into : li_existe
from inmbodeg
where ( mbod_g_financiero =: str.g_financiero) and
      ( mbod_empresa =: li_empresa) and
		( mbod_bodega =: li_bodega) and
		( mbod_ubicacion =: li_ubicacion) and
		( mbod_producto =: ls_producto) ;

	if sqlca.sqlcode = - 1 then
		messagebox('Atenciòn','Error al validar bodega/ubicación '+li_bodega+' '+li_ubicacion+' '+sqlca.sqlerrtext)
		return 0
	end if
		
	if li_existe <= 0 then
		valor = 0 
	else
		valor = 1
	end if
	
	return valor
end function

public function integer wf_verificar_bodega (string ls_producto, string li_bodega, integer li_empresa);string ls_prod
integer valor, li_existe
select count(*)
into : li_existe
from inmbodeg
where ( mbod_g_financiero =: str.g_financiero) and
      ( mbod_empresa =: li_empresa) and
		( mbod_bodega =: li_bodega) and
		( mbod_producto =: ls_producto) ;

	if sqlca.sqlcode = - 1 then
		messagebox('Atenciòn','Error al validar el producto en bodega '+li_bodega+' '+sqlca.sqlerrtext)
		return 0
	end if
	
	if li_existe <= 0  then
		valor = 0 
	else
		valor = 1
	end if
	
	return valor
end function

public subroutine wf_ubicacion ();/*dw_2.getchild("dmov_ubicacion",dwc_ubic)
dwc_ubic.settransobject(sqlca)
dwc_ubic.retrieve(str.g_financiero,str.empresa,ii_bodega)
dwc_ubic.setfilter("dmov_ubicacion <> '"+is_ubicacion+"'")
dwc_ubic.filter()*/
end subroutine

public subroutine wf_setear_user (string as_user);//Asigno el Usuario a la Variable de Instancia
is_user = as_user
end subroutine

public subroutine wf_producto ();/*dw_2.getchild("dmov_producto",dwc_prod)
dwc_prod.settransobject(sqlca)
dwc_prod.retrieve(str.g_financiero,str.empresa,ii_bodega,ii_ubicacion)*/

end subroutine

public subroutine wf_prod_convert (string as_producto, ref decimal ad_costo_cif, ref string as_prod_medida, ref decimal ad_prod_convert, ref integer ad_sqlca);SELECT prod_costo_cif,prod_medida
INTO   :ad_costo_cif,
		 :as_prod_medida
FROM   inmprodu 
WHERE (prod_g_financiero =:str.g_financiero) AND
		(prod_empresa=:str.empresa) AND
		(prod_producto =:as_producto);
		
if sqlca.sqlcode = - 1 then
	messagebox('Atenciòn','Error al leer el costo del producto')
	ad_sqlca = sqlca.sqlcode
	return
end if

/*Unidad de conversion de la unidad del ajuste*/
Select medi_cantidad
Into   :ad_prod_convert
From   inamedid
Where  (medi_medida =: as_prod_medida);

if sqlca.sqlcode = - 1 then
	messagebox('Atenciòn','Error al leer uniddad de conversión del producto ')
	ad_sqlca = sqlca.sqlcode
	return
end if
		
ad_sqlca = sqlca.sqlcode


end subroutine

public subroutine wf_mover (string ac_a_donde);Long ll_selected, ll_old_idx, ll_new_idx


dw_2.SetRedraw(False)

ll_selected = dw_2.GetSelectedRow(0)

If ac_a_donde = 'U' Then
	If ll_selected > 1 Then
		ll_old_idx = dw_2.GetItemNumber(ll_selected, "dmov_num_orden")
		ll_new_idx = dw_2.GetItemNumber(ll_selected - 1, "dmov_num_orden")
		
		dw_2.SetItem(ll_selected, "dmov_num_orden", ll_new_idx)
		dw_2.SetItem(ll_selected - 1, "dmov_num_orden", ll_old_idx)
		
	End If
ElseIf ac_a_donde = 'D' Then
	If ll_selected < dw_2.RowCount() Then
		ll_old_idx = dw_2.GetItemNumber(ll_selected, "dmov_num_orden")
		ll_new_idx = dw_2.GetItemNumber(ll_selected + 1, "dmov_num_orden")
		
		dw_2.SetItem(ll_selected, "dmov_num_orden", ll_new_idx)
		dw_2.SetItem(ll_selected + 1, "dmov_num_orden", ll_old_idx)
	End If
End If
dw_2.SetSort("dmov_num_orden A")
dw_2.Sort()
dw_2.SetRedraw(True)
end subroutine

public subroutine wf_cargarchild_dw_1 ();
/*concepto*/
dw_1.getchild("conc_concepto",dwc)
dwc.settransobject(sqlca)
dwc.retrieve(str.g_financiero,str.empresa,"IN","AE")


gf_hay_data_child(dwc)
dw_1.setitem(1,'conc_concepto',dwc.getitemstring(1,'conc_concepto'))

/*bodega*/
dw_2.getchild("dmov_bodega",dwc_bod)
dwc_bod.settransobject(sqlca)
dwc_bod.retrieve(str.g_financiero,str.empresa)
gf_hay_data_child(dwc_bod)




end subroutine

public subroutine wf_cargarchild_dw_2 ();//dwc_bod		
dw_2.getchild("dmov_bodega",dwc_bod)
dwc_bod.settransobject(sqlca)
dwc_bod.retrieve(str.g_financiero,str.empresa)
gf_hay_data_child(dwc_bod)

dw_2.getchild("dmov_ubicacion",dwc_ubic)
dwc_ubic.settransobject(sqlca)
dwc_ubic.retrieve(str.g_financiero,str.empresa)
gf_hay_data_child(dwc_ubic)
dwc_ubic.setfilter("dmov_ubicacion <> '"+is_ubicacion+"'")
dwc_ubic.filter()

dw_2.getchild("dmov_unidad_medida",dwc_med)
dwc_med.settransobject(sqlca)
dwc_med.retrieve()
gf_hay_data_child(dwc_med)


end subroutine

public subroutine wf_validar_ayuda ();Long li_filas

select count(*)
into   :li_filas
from   inmprodu
where  prod_g_financiero =: str.g_financiero and
       prod_empresa =: str.empresa ;
		 
if li_filas = 0 then
	gf_in_mensaje("Atencion",  &
	"Usted No puede Crear Ajustes de Existencias y Costos de Productos sin haber creado los Productos", &
	"Menu de Inventarios, Opción de Parametros, Opción de Productos", & 
	"w_cr_ma_referencia_a")
	close(This)
	return
end if

select count(*)
into   :li_filas
from   inmbodeg
where  mbod_g_financiero =: str.g_financiero and
       mbod_empresa =: str.empresa ;
		 
if li_filas = 0 then
	gf_in_mensaje("Atencion",  &
	"Usted No puede Crear Ajustes de Existencias y Costos de Productos sin haber creado los Productos por Bodega y Ubicacion", &
	"Menu de Inventarios, Opción de Parametros, Opción de Productos por Bodega y Ubicacion", & 
	"w_in_bod_ubi_man")
	close(This)
	return
end if
	
end subroutine

public function boolean wf_orden_nueva ();long ll_max
integer li_ann

li_ann = ii_ann //year(date(gf_fecha_serv()))

select max(convert(numeric(8,0),documento))
into	:ll_max
from notascr_encab
where g_financiero = :str.g_financiero and
		empresa		= :str.empresa and
		ann			= :li_ann; 
	if sqlca.sqlcode = -1  then
		gf_mensaje('','Error al Buscar Secuencia '+sqlca.sqlerrtext,1,1,'E')		
		return false
	end if
	
	if isnull(ll_max) then ll_max = 0
	
	ll_max ++
	
	dw_1.setitem(1,'documento',string(ll_max))
	
	is_documento = string(ll_max)
return true
end function

public function integer medida ();////********************************************************************
////**  Recorre el DWchild de medidas para confirmar que los valores  **
////**  son los correctos en las unidades de medida						  **
////********************************************************************	
//
Integer li_ciclo,li_ciclo2
//String  ls_codigo_m
//dw_2.accepttext()
//if dw_2.rowcount() < 1 then return 1
//ls_codigo_m = dw_2.GetItemString(dw_2.GetRow(),"dmov_unidad_medida")
//
//For li_ciclo =1 To dwc_med.Rowcount() 
//	If ls_codigo_m = dwc_med.GetItemString(li_ciclo, "medi_medida") Then
//		li_ciclo		= dwc_med.GetItemNumber(li_ciclo, "medi_cantidad")
//		Exit
//	End If 
//Next
//	is_producto=dw_2.GetItemString(dw_2.GetRow(),"dmov_producto")
//	
//   SELECT prod_unidad_venta
//  	INTO   :is_unidad_venta
//	FROM   inmprodu 
//	WHERE (prod_g_financiero =:str.g_financiero) AND
//		   (prod_empresa=:str.empresa) AND
//		   (prod_producto =:is_producto);
//
//
//For li_ciclo2 =1 To dwc_med.Rowcount() 
//	If is_unidad_venta = dwc_med.GetItemString(li_ciclo2, "medi_medida") Then
//		li_ciclo2		= dwc_med.GetItemNumber(li_ciclo2, "medi_cantidad")
//		Exit
//	End If 
//Next
//
//
//dw_2.SetItem(dw_2.GetRow(), "inamedid_unidad_cantidad", li_ciclo)
//dw_2.SetItem(dw_2.GetRow(), "unidad_venta", li_ciclo2)
//commit ;
Return li_ciclo
//
end function

public subroutine wf_buscar_producto ();Integer           li_linea
Long	 				ll_num_prove, ll_row
integer           respuesta, li_definicion
decimal           li_costo
String				ls_syntax, ls_bodega , ls_ubicacion, ls_codigo, ls_producto
Integer           li_len
string            ls_descripcion,ls_medida,ls_unidad,ls_conjunto
str_dynamic_find	lstr_df
Decimal				ld_canti
dw_2.AcceptText()


/***************************************************************************************
 *										                                  								*
 *  									Búsqueda Dinámica de Secuencia y Productos					*
 ***************************************************************************************/

	lstr_df.texto_campo [1,1] = "inmprodu.prod_producto"
	lstr_df.texto_campo [1,2] = "Producto"
	lstr_df.texto_campo [1,3] = "prod_producto"
	lstr_df.texto_campo [1,4] = "V"
	lstr_df.texto_campo [2,1] = "inmprodu.prod_descripcion"
	lstr_df.texto_campo [2,2] = "Descripción"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = "V"
	lstr_df.texto_campo [3,1] = "inmprodu.prod_producto_dos"
	lstr_df.texto_campo [3,2] = "Producto Dos"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = "V"
	lstr_df.texto_campo [4,1] = "inmprodu.prod_descripcion_dos"
	lstr_df.texto_campo [4,2] = "Descripcion Dos"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = "V"	

                       
	lstr_df.tabla 		  = " inmprodu "
	lstr_df.tabla_where = " WHERE  ( inmprodu.prod_g_financiero = "+ string(str.g_financiero)+" ) AND  " +&
                        			" ( inmprodu.prod_empresa = "+string(str.empresa)+" ) AND " +& 
								" ( inmprodu.prod_status = 1 )"  

	OpenWithParm(w_cr_busqueda, lstr_df)
	ls_syntax	= Message.StringParm

	ls_codigo =  String(Right ( ls_syntax, Len (ls_syntax) - Pos (ls_syntax, "=") ))
	gf_replace_cadena(ls_codigo,"'"," ")
	ls_codigo = Trim(ls_codigo)
	
	IF  IsNull(ls_codigo) Or (ls_codigo = "") Then 
  		 Return
	Else
		
		li_linea = dw_2.GetRow()

	//seteamos el producto a la ventana de w_in_ajuste_exit_costo//	
	
	 SELECT inmprodu.prod_descripcion,
	        inmprodu.prod_medida,
			  inmprodu.prod_costo_fob,
			  inmprodu.prod_definicion,
			  inmprodu.prod_unidad_venta
   	INTO :ls_descripcion,:ls_medida,:li_costo,:li_definicion,:is_unidad_venta
	   FROM inmprodu 
	   WHERE ((inmprodu.prod_g_financiero =:str.g_financiero) AND
		      (inmprodu.prod_empresa=:str.empresa) AND
				(inmprodu.prod_producto =:ls_codigo));	
				
		dw_2.setitem(dw_2.getrow(),"item",ls_codigo)		
		dw_2.SetItem(dw_2.getrow(),"descripcion", ls_descripcion)
      dw_2.SetItem(dw_2.getrow(),"precio", li_costo)
		dw_2.setitem(dw_2.GetRow(),"unidad",ls_medida)		 
//		dw_2.setcolumn("dmov_cantidad")	/*COMMENTED BY HGN/22/06/2002*/
		dw_2.setcolumn("cantidad")
	   dw_2.setfocus()
//		medida()
End If


end subroutine

public subroutine wf_eliminar_todo ();Integer    li_num_sec , li_anno , li_filas , li_contador, resp, li_definicion
String     ls_tipo = "AE"

Resp = MessageBox("Aviso (Eliminacion del Encabezado de la Nota de Credito )",&
	       "El Registro en "+This.Title+" va a ser eliminado!...~r~n~t&
Esta Seguro de Hacerlo Ahora? ( No Se podra Recuperar ) ",Question!,YesNo!)
	
	Choose Case resp
		Case 1
		/* */
	   Case 2
			Return
	End Choose
	
dw_1.AcceptText()

If dw_2.rowcount() > 0 Then
   li_filas = dw_2.rowcount()
   //Borramos el detalle de la cantidad//
	
	For li_contador = li_filas To 1 Step -1
		 dw_2.DeleteRow(li_contador)
	Next
	dw_2.update()
	If sqlca.sqlcode = -1 Then
		Messagebox('Error','Al Eliminar Detalle, Verificar')
		RollBack Using sqlca;		
	Return
	Else
		Commit Using sqlca;
   End If
	
	dw_1.DeleteRow(dw_1.GetRow())
	dw_1.update()
	If sqlca.sqlcode = -1 Then
		MessageBox('Error','Al Eliminar el Registro, Verifique')
		RollBack Using sqlca;
	Else
		Commit Using sqlca;
		dw_1.Reset()
		dw_2.Reset()
		This.TriggerEvent("ue_post_open")
	End If
		
Else
	dw_1.DeleteRow(dw_1.Getrow())
	dw_1.update()
	If sqlca.sqlcode = -1 Then
		MessageBox('Error','Al Eliminar el Registro, Verifique')
		RollBack Using sqlca;
	Else
		Commit Using sqlca;
		MessageBox('Atención','Registro eliminado correctamente',Information!)
		dw_1.Reset()
		dw_2.Reset()
		This.TriggerEvent("ue_post_open")
	End If
End If

end subroutine

public subroutine wf_eliminar_detalle ();Integer    li_num_sec , li_anno , li_filas , li_contador, li_linea, li_definicion, recorrido
String     ls_tipo = "AE"
 
dw_1.AcceptText()
dw_2.AcceptText() 
	
	   dw_2.DeleteRow(dw_2.GetRow())
		/*   */  
		
		FOR recorrido = 1 TO dw.rowcount()
			if len(trim(dw.getitemstring(recorrido,"item"))) > 0 &
				 and (dw.getitemNumber(recorrido,"cantidad")+ & 
					  dw.getitemNumber(recorrido,"fracion") <> 0 or  dw.getitemNumber(recorrido,"fracion") <> 0) then 
					  //** li_linea = li_linea +1
			else  
				dw.deleterow(recorrido)
				recorrido --
			end if	
		NEXT
		/* * */
		this.triggerevent("ue_pre_aceptar")		
		// dw_2.update()
		If sqlca.sqlcode = -1 Then
			RollBack Using sqlca;
			MessageBox('Error','Al Eliminar el Registro, Verifique')
			
	   Else
			Commit Using sqlca;
//			dw_2.SetRedraw(False) 
		   dw_2.retrieve(str.g_financiero,str.empresa,is_documento, ii_ann)
	//		dw_2.SetRedraw(True)
			MessageBox('Atención','Registro eliminado correctamente')
			Return
	   End If
end subroutine

on w_captura_notas_credito.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.ln_1=create ln_1
this.cbx_1=create cbx_1
this.dw_3=create dw_3
this.cbx_ubicacion=create cbx_ubicacion
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ln_1
this.Control[iCurrent+2]=this.cbx_1
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.cbx_ubicacion
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.dw_4
end on

on w_captura_notas_credito.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ln_1)
destroy(this.cbx_1)
destroy(this.dw_3)
destroy(this.cbx_ubicacion)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_4)
end on

event open;call super::open;
//m_in_principal.m_edicion.m_primerregistro.ToolBarItemVisible = False
//m_in_principal.m_edicion.m_registroanterior.ToolBarItemVisible = False
//m_in_principal.m_edicion.m_siguienteregistro.ToolBarItemVisible = False
//m_in_principal.m_edicion.m_ultimoregistro.ToolBarItemVisible = False



//m_in_principal.m_edicion.m_buscar.ToolBarItemVisible = True
//m_in_principal.m_edicion.m_buscar.ToolBarItemText = 'Buscar Secuencia'

//pb_buscar.Enabled = False

//If pos(upper(str.nombre_empresa),'ELECTROVISION') > 0  Then 
	//dw_2.dataobject = 'dw_in_exist_cost2_electro'
	dw_2.settransobject(sqlca);
//end if
dw_3.settransobject(sqlca);
dw_4.settransobject(sqlca);
end event

event ue_post_open;datetime fecha
string ls_aplic, ls_tipo,ls_doc_ajuste, ls_expression, ls_masca, ls_decimal
integer li_a_um
this.x = 1
this.y = 1
// Retorna el año de parámetros, si esta configurado, de lo contrario
// trae el año del Servidor

dw_1.GetChild('proveedor', dwc)
dwc.settransobject(sqlca)
dwc.retrieve('P')


gf_in_para_a_um(str_in.year,li_a_um)

/*Valida si la empresa utiliza decimales en cantidades
Modify by HGN 09/01/2001*/

SELECT inaparam.para_decimal_cantidad  
INTO :ii_cantidad_decimal   
FROM inaparam  
WHERE inaparam.para_g_financiero = :str.g_financiero and 
  		inaparam.para_empresa = :str.empresa ;
	if sqlca.sqlcode = -1 then
		mensaje('Aviso','Error al Seleccionar cantidad de decimales',sqlca.sqlerrtext)
	end if

If ii_cantidad_decimal > 0 then
	dw_2.object.cantidad.editmask.mask='###,###.'+fill('0',ii_cantidad_decimal)	
	dw_2.object.cantidad.format='###,###.'+fill('0',ii_cantidad_decimal)
	dw_2.object.cantidad.editmask.useformat='yes'
else 
	dw_2.object.cantidad.edit.format='###,##0'	
	dw_2.object.cantidad.format='###,##0'	
end if
/*****************************************/

//Seleccion de la bodega y ubicacion en compras, para que no aparezcan en las listas desplegables

  SELECT crmparam.mpar_ubicacion
    INTO :is_ubicacion
    FROM crmparam  
   WHERE ( crmparam.mpar_g_financiero = :str.g_financiero ) AND  
         ( crmparam.mpar_empresa = :str.empresa )   ;
	if sqlca.sqlcode = -1 then
		mensaje('Aviso','Error al Seleccionar la Bodega y Ubicación en Compras',sqlca.sqlerrtext)
	end if

if isnull(is_ubicacion) then is_ubicacion = ' '

/*cargar child primer datawindows*/
//wf_cargarchild_dw_1()
///*cargar child segundo datawindows*/
//wf_cargarchild_dw_2()

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

/*obtenemos la secuencia del ultimo ajuste realizado en la tabla de 
  DGMSERIE*/ 
ls_aplic = str.aplicacion
ls_tipo = "NR"
///////Secuencia de la transacción/////////
//ii_secuencia = gf_in_secuencia(ls_tipo)
//ii_secuencia= ii_secuencia+1
///////////////////////////////////////////

dw_1.insertrow(0)

if ib_primera_vez then
	fecha=gf_fecha_serv()
	dw_1.setitem(dw_1.getrow(),"fecha",fecha)
	ii_ann = year(date(fecha))
	dw_1.setitem(dw_1.getrow(),"ann",ii_ann)
	ib_primera_vez = false
else
	dw_1.setitem(dw_1.getrow(),"fecha",idt_fecha)
	dw_1.setitem(dw_1.getrow(),"ann",ii_ann)
end if

//dw_1.setitem(1,"documento",string(ii_secuencia))
dw_1.setitem(dw_1.getrow(),"g_financiero",str.g_financiero)
dw_1.setitem(dw_1.getrow(),"empresa",str.empresa)

wf_orden_nueva()


if dw_2.rowcount()<=0 then
	dw_2.insertrow(0)
	dw_2.setitem(dw_2.GetRow(),"linea",dw_2.GetRow())
//	dw_2.setitem(dw_2.GetRow(),"dmov_num_orden",dw_2.GetRow())
//	dw_2.setitem(dw_2.getrow(),"dmov_bodega",dwc_bod.getitemstring(1,"abod_bodega"))
//	dw_2.setitem(dw_2.getrow(),"dmov_ubicacion",dwc_ubic.getitemstring(1,"dmov_ubicacion"))
end if
dw_1.setfocus()
dw_1.setcolumn("documento")

dw_2.getchild('tipo',idwc_tipo)
idwc_tipo.settransobject(sqlca)
idwc_tipo.retrieve()
idwc_tipo.insertrow(1)

//st_nom_ventana.text=this.classname()
//m_in_principal.m_archivo.m_guardar.enabled=false

//*****************
wf_validar_ayuda()
//dw_2.Object.dmov_unidad_medida.Protect=li_a_um

if str.digito_decimal > 0 then 
	 ls_masca = '####,###.'+fill('0',str.digito_decimal)
else 
	 ls_masca = '####,###'
end if 

// Modificado por Mayté Aparicio 20/02/2001
 //dw_2.modify("dmov_costo.editmask.mask='"+ls_masca+"'")

// Modify by HGN 13/02/2001
ls_expression = str.nombre_empresa

end event

event ue_adicionar;If dw = dw_2 Then
	dw.ScrollToRow(dw.InsertRow(0))
	dw.setitem(dw.GetRow(),"linea",dw.GetRow())
	dw.setcolumn('item')
ElseIf dw = dw_1 Then
	dw_1.accepttext()
	idt_fecha = dw_1.getitemdatetime(dw_1.getrow(),'fecha')
	dw_1.Reset()
	dw_2.Reset()
	if ii_ann <> year(date(gf_fecha_serv())) then
		if gf_mensaje('','Desea Adicionar en el Año '+string(ii_ann)+ ' o en el Año Actual ? ',2,1,'Q') = 2 then
			ii_ann = year(date(gf_fecha_serv()))
		end if
	end if
	This.TriggerEvent('ue_post_open')	
End If

end event

event ue_insertar;Integer li_orden
If dw = dw_2 Then
	dw_2.scrolltorow(dw_2.insertrow(dw_2.getrow()))
//   dw.setcolumn("dmov_bodega")
	dw.setitem(dw.GetRow(),"linea",dw.RowCount())
//	dw.setitem(dw.GetRow(),"dmov_num_orden",dw.GetRow())
	For li_orden = 1 to dw.RowCount()
		dw.SetItem(li_orden,"linea",li_orden)
	Next
End If
end event

event ue_eliminar;Long resp

IF dw_1.getitemNumber(1,"estado") > 0 then
	messagebox('Atención ','Este documento fue actualizado, no puede ser Eliminado !!!')
	return
end if 

If dw.RowCount() > 0 Then
	Resp = MessageBox("Aviso (Confirme el Siguiente Paso)",&
	       "El Registro en "+This.Title+" va a ser eliminado!...~r~n~t&
Esta Seguro de Hacerlo Ahora?",Question!,YesNo!)
	
	Choose Case resp
		Case 1
			If dw = dw_1 Then
				MessageBox("Aviso (Eliminacion de todo el Ajuste )",&
	       "El Registro en "+This.Title+" va a ser eliminado!...~r~n~t",Question!)
				wf_eliminar_todo()			
		   ElseIf dw = dw_2 Then
				wf_eliminar_detalle()
			Else
				Return
			End If
		
	   Case 2
			Return
	End Choose

End If
	

end event

event ue_pre_aceptar;/*salvar datos de la ventana de ajuste de existencias y costos*/
dw_1.acceptText()

IF dw_1.getitemNumber(1,"estado") > 0 then
	messagebox('Atención ','Este documento fue actualizado, no puede ser Guardado !!!')
	return
end if 

IF dw_1.getitemstring(1,"factura") = '' then
	messagebox('Atención ','Debe Asignar el Numero de la Nota de Credito, Verifique  !!!')
	dw_1.setcolumn('factura')
	return
end if 

string ls_documento,ls_aplic,ls_tipo,ls_cod_medida,ls_concepto,ls_bodega,ls_ubicacion,ls_fila
datetime ldt_fecha

String   ls_costo_proc, ls_clase_costo ,ls_producto, ls_costo_aplica,  ls_error
Integer  li_anio, li_flag, li_linea, li_final, li_1
integer li_contador,ll_update,li_cantidad,li_costo,ll_update2,li_precio,li_medida,indice = 0

Decimal  ld_cargos, ld_costo_fob, ld_costo, ld_costo_promedio, ld_precio_base, ld_precio_venta
Decimal  ld_precio1, ld_precio2, ld_precio3, ld_precio4, ld_precio5,ld_cantidad
Decimal  ld_pprecio1, ld_pprecio2, ld_pprecio3, ld_roun

datetime dt_anterior,dt_posterior
time tiempo1 = 00:00:00, tiempo2 = 23:59:59

dt_anterior=datetime(date("01/01/1980"),tiempo1)
dt_posterior=datetime(id_fecha2,tiempo2)
					
dw_2.acceptText()
dw=dw_1
li_precio = 0
ldt_fecha = gf_fecha_serv()
//ls_concepto = dw_1.getitemstring(dw_1.getrow(),'conc_concepto')
/*grabamos los datos del DW_1 de la tabla de INTMOVIM*/

li_anio = year(date(dw_1.getitemdatetime(1,"fecha")))

	dw_1.setitem(dw_1.getrow(),"ann",li_anio)	

dw_1.setitem(dw_1.getrow(),"usuario",str.usuario)

ls_documento = dw_1.getitemstring(dw_1.getrow(),"documento")

/*grabamos los datos de DW_2 en la tabla INDMOVIM*/
for li_contador = 1 to dw_2.rowcount()
    dw_2.setitem(li_contador,"g_financiero",str.g_financiero)
	 dw_2.setitem(li_contador,"empresa",str.empresa)
	 dw_2.setitem(li_contador,"linea",li_contador)
	 dw_2.setitem(li_contador,"documento",ls_documento)
	 dw_2.setitem(li_contador,"ann",li_anio)
	 /*buscamos el codigo de la unidad de medida en INMPRODU*/
	 is_producto = dw_2.getitemstring(li_contador,"item")
	 ls_cod_medida = dw_2.GetItemString(li_contador,'unidad')
next

dw=dw_1
ll_update = dw.update()
 if ll_update = 1 then
	ll_update =dw_2.update()
	if ll_update = 1 then
	
		dw_1.resetupdate()
		dw_2.resetupdate()					
		commit using sqlca;
		ib_aceptar = True
		/* Refresca los datos del datawindows cuando la Actualizacion fue correcta */
		dw_1.setredraw(false)
		dw_2.setredraw(false)				
		dw_1.retrieve(str.g_financiero,str.empresa,ls_documento,li_anio)
		dw_2.retrieve(str.g_financiero,str.empresa,ls_documento,li_anio)
		dw_1.setredraw(true)
		dw_2.setredraw(true)				

		MessageBox("Atencion Sr. Usuario","Actualización  Existosa")

		/* Fin tal y como estaba originalmente */

		/* Script para el proceso de actualizar costos de productos al inventario  */
		
		/*****************SCRIPT ISERTADO********************* */		
	else
		rollback using sqlca;
		ib_aceptar = False
		MessageBox("Notas de Credito ",&
					  "¡Error al Actualizar!")
	end if				
else
	rollback using sqlca;
	ib_aceptar = False
	MessageBox("(Notas de Credito",&
				  "¡Error al Actualizar!")
end if
	 



end event

event ue_aceptar;string ls_tipo, ls_codigo
integer li_existe
dw_1.accepttext()
IF dw_1.getitemNumber(1,"estado") > 0 then
	messagebox('Atención ','Este documento fue actualizado, por lo que no puede ser salvado, al menos que sea activado !!!')
	return
end if 
//verificamos que la cantidad a ajustar no exceda a la existente//
dw_2.accepttext()
integer li_cantidad,li_cant,li_residuo,li_contador,li_encender=0
for li_contador = 1 to dw_2.rowcount()
    if isnull(dw_2.getitemstring(li_contador,"item")) then
		 dw_2.deleterow(li_contador)
	    li_contador = li_contador - 1
		continue 
	 end if
	 ls_tipo = dw_2.getitemstring(li_contador,'tipo')
	   SELECT count(*)  
		 INTO :li_existe  
		 FROM intipos_notascr  
		WHERE intipos_notascr.tipo = :ls_tipo   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Contar Tipos de Ncr '+sqlca.sqlerrtext,1,1,'E')
		end if
		if li_existe = 0 then
			ls_codigo = mid(ls_tipo,1,5)
			idwc_tipo.retrieve()
		end if
next 

if li_encender = 1 then
  return 
else
	this.postevent("ue_pre_aceptar")
end if

		 
		

end event

event closequery;	long respuesta
	if dw.accepttext() = 1 then
		if dw.modifiedcount() > 0 or dw.deletedcount() > 0 then
			respuesta = MessageBox("Atención -- " + str.nombre + " " + str.apellido, &
											"No se han Salvado los Cambios." + &
											"~n~n ¿Desea Salvar Ahora?", Question!, YesNoCancel!) 
			choose case respuesta 
				case 1 				
					this.triggerevent("ue_pre_aceptar")
				case 2
					
				case 3
					return 1
			end choose
		end if
	end if
 

gf_win_used_by_user(is_nombre, false)
end event

event ue_buscar;integer li_sec
string ls_tipo = "AE",ls_conjunto, ls_codigo
dw_1.accepttext()

Long	 				ll_num
String				ls_syntax
str_dynamic_find	lstr_df

/***************************************************************************************
 *										Se hizo Clic sobre el buton										*
 *  									Búsqueda Dinámica Entradas       								*
 ***************************************************************************************/


	lstr_df.texto_campo [1,1] = "notascr_encab.factura"
	lstr_df.texto_campo [1,2] = "Nota/Credito"
	lstr_df.texto_campo [1,3] = ""  //"~t000000000# ~ttmov_secuencia"
	lstr_df.texto_campo [1,4] = "V"
	lstr_df.texto_campo [2,1] = "documento"
	lstr_df.texto_campo [2,2] = "Documento"
	lstr_df.texto_campo [2,3] = "documento"
	lstr_df.texto_campo [2,4] = "V"
	lstr_df.texto_campo [3,1] = "fecha"
	lstr_df.texto_campo [3,2] = "Fecha"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = "V"	
	lstr_df.texto_campo [4,1] = "comentario"
	lstr_df.texto_campo [4,2] = "Comentario"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = "V"	


	lstr_df.tabla 		  = "notascr_encab "
	lstr_df.tabla_where = "WHERE ( notascr_encab.g_financiero = "+string(str.g_financiero)+" ) AND " +& 
        " ( notascr_encab.empresa = "+string(str.empresa)+" ) AND  " +&
		  " ( notascr_encab.ann = "+string(ii_ann)+" )"
		  
	OpenWithParm(w_cr_busqueda, lstr_df)
	
	ls_syntax	= Message.StringParm

	ls_codigo =  String(Right ( ls_syntax, Len (ls_syntax) - Pos (ls_syntax, "=") ))
	gf_replace_cadena(ls_codigo,"'"," ")
	ls_codigo = Trim(ls_codigo)
	
	IF not IsNull(ls_codigo) and ls_codigo <> '' Then 
		is_documento = ls_codigo
      dw_1.setitem(1,"documento",is_documento)
	   dw_1.retrieve(str.g_financiero,str.empresa,is_documento, ii_ann)
	   dw_2.retrieve(str.g_financiero,str.empresa,is_documento, ii_ann)
   End If
	
	m_in_principal.m_archivo.m_guardar.enabled = False

end event

event resize;dw_2.Resize(newwidth - 30, newheight - 700)
dw_2.x = 14
dw_2.y = 572
st_nom_ventana.y = dw_2.y + dw_2.height + 35

cbx_ubicacion.y =st_nom_ventana.y 

gb_ventana.y =dw_2.y + dw_2.height 

end event

event ue_imprimir;//override
string ls_expresion
if dw_3.retrieve(str.g_financiero, str.empresa, is_documento, ii_ann) = 0 then return

ls_expresion = str.nombre_empresa
dw_3.object.nom_empresa.expression = "'"+ls_expresion+"'"

dw_3.object.datawindow.print.preview = 'yes'
dw_3.object.datawindow.print.preview.zoom = 90
dw_3.visible = true


OpenWithParm(w_dw_print_options, dw_3)

If Message.DoubleParm = -1 Then Return
SetPointer(Hourglass!)
dw_3.print(true)

end event

type st_nom_ventana from w_in_padre`st_nom_ventana within w_captura_notas_credito
boolean visible = false
integer x = 27
integer y = 1384
end type

type dw_1 from w_in_padre`dw_1 within w_captura_notas_credito
event ue_micro_ayuda pbm_nchittest
event ue_buscar_secuencia ( )
integer x = 5
integer y = 0
integer width = 3776
integer height = 540
string dataobject = "dw_notascr_encab"
boolean hscrollbar = false
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_1::clicked;call super::clicked;dw=dw_1
  
end event

event dw_1::itemchanged;string ls_concepto, ls_tipo="NR", ls_doc="AJEC-",ls_aplic = "IN"
string ls_usuario,ls_autorizacion, ls_sec, ls_documento
datetime fecha
integer li_sec
dw_1.accepttext()

if Dw_1.GetColumnName () = "documento"  then
//	dw_1.accepttext()

	dw_2.enabled=true
	ls_documento = dw_1.getitemstring(dw_1.getrow(),"documento")
//buscamos la secuencia para verificar si existe//	
	select documento
	into : ls_sec
	from notascr_encab
	where (g_financiero =: str.g_financiero) and
	      (empresa=:str.empresa) and
			(documento =: ls_documento) and
			(ann = :ii_ann);
	
	if ls_documento = ls_sec then		
	   dw_1.retrieve(str.g_financiero,str.empresa,ls_documento, ii_ann)
		yield()
		if dw_1.rowcount() <= 0 then
		   dw_1.insertrow(0)
		   dw_1.setitem(DW_1.GETROW(),"documento",ls_documento)
			dw_1.setitem(DW_1.GETROW(),"ann",ii_ann)
	   end if	
	    dw_2.retrieve(str.g_financiero,str.empresa,ls_documento, ii_ann)
		 yield()
			   if dw_2.rowcount() <= 0 then
		         dw_2.insertrow(1)
	         end if
//				wf_desabilitar_botones()
	else
		 dw_1.reset()
		 dw_2.reset()		 
		 		       
             ii_secuencia=gf_in_secuencia(ls_tipo)
             ii_secuencia= ii_secuencia+1
             dw_1.insertrow(0)
             dw_1.setitem(1,"tmov_secuencia",ii_secuencia)
		 
	    fecha=gf_fecha_serv()
       dw_1.setitem(dw_1.getrow(),"tmov_fecha",fecha)
//       ls_tipo = "AJEC-"
//       dw_1.setitem(dw_1.getrow(),"tmov_documento",ls_doc)
		 dw_2.insertrow(0)
		 dw_1.setcolumn("conc_concepto")
		 dw_1.setfocus()
	end if
elseif dw_1.getcolumnName() = "documento" then
	dw_2.enabled = true
elseif dw_1.getcolumnName() = "comentario" then
	dw_2.enabled = true
elseif dw_1.getcolumnName() = "ann" then
	ii_ann = integer(data)
	parent.triggerevent("ue_adicionar")
end if
IF dw_1.getitemNumber(1,"estado") > 0 then
	m_in_principal.m_archivo.m_guardar.enabled=false
else
	m_in_principal.m_archivo.m_guardar.enabled=true
end if
end event

event dw_1::getfocus;dw=dw_1
end event

event dw_1::ue_enter;//override
if this.getcolumnname() <> 'comentario' then
	send(handle(this),256,9,long(0,0))
	return 1
end if
end event

type dw_2 from w_in_padre`dw_2 within w_captura_notas_credito
event ue_micro_ayuda pbm_nchittest
event ue_down pbm_dwnkey
event ue_helpcol ( )
event ue_adicionar ( )
event ue_post_changed ( string columna,  long row,  string data )
boolean visible = true
integer x = 0
integer y = 560
integer width = 3781
integer height = 1712
string dataobject = "dw_notascr_detalle"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = false
borderstyle borderstyle = stylelowered!
end type

event dw_2::ue_down;CHOOSE CASE key
	CASE KeyF1! 
		This.Postevent("ue_helpcol")
END CHOOSE

end event

event dw_2::ue_helpcol;wf_buscar_producto()
end event

event dw_2::ue_adicionar();
//Verifica si no existe renglon vacio para adicionar
integer recorrido,li_linea
Long	ll_row
li_linea = 0
FOR recorrido = 1 TO dw.rowcount()
 if len(trim(dw.getitemstring(recorrido,"item"))) > 0 &
	 and (dw.getitemNumber(recorrido,"cantidad")+ dw.getitemNumber(recorrido,"fracion") <> 0 or  dw.getitemNumber(recorrido,"fracion") <> 0) then 
	li_linea = li_linea +1
	dw.setitem(li_linea,"linea",li_linea)	
else
	dw.deleterow(recorrido)
	recorrido --
 end if	
NEXT

ll_row = li_linea +1
dw.scrolltorow(dw.insertrow(0))

dw.setitem(ll_row,"linea",ll_row)
dw.setcolumn("item")
dw.Setfocus()
end event

event dw_2::ue_post_changed(string columna, long row, string data);// Declaracion de Variables****************************************//

string     ls_descripcion,ls_medida,ls_unidad,ls_filtro,ls_unidad_aj,& 
			  ls_product,ls_conjunto, ls_unid_ajuste,ls_expresion, ls_message, ls_ubicacion,ls_bodega
integer    li_residuo,status , li_linea, li_cant_um, li_fraccion,li_find,li_sqlca, li_index, li_ann
long 		 ll_entrada_sec
decimal    li_cantidad,ld_cant_bod, ld_costo_cif,ld_costo,ld_conv_aj,ld_conv_prod,ld_prod_convert, ld_porciento, ld_cantidad
//dw_2.AcceptText()

//Columna Código de Producto**************************************//
If columna = "item" Then

	dw_2.setitem(row,"precio",0)
	dw_2.setitem(row,"cantidad",0)
	dw_2.setitem(row,"fracion",0)
	dw_2.setitem(row,"total",0)		

	
	is_producto=dw_2.GetItemString(row,"item")
   SELECT prod_producto,
	          prod_descripcion,
	          prod_medida,
			 prod_costo_fob,
			 prod_status,
			 prod_definicion,
			 prod_unidad_venta,
			 Round(prod_ultima_entrada_can / medi_cantidad,2),
			 isnull(prod_ultima_entrada_sec,0),
			 isnull(datepart(yy,prod_entrada_fecha),0)
  	INTO   :ls_product,
		      :ls_descripcion,
			 :ls_medida,
			 :ld_costo_cif,
			 :status,
			 :is_definicion,
			 :is_unidad_venta,
			 :ld_cantidad,
			 :ll_entrada_sec,
			 :li_ann
	FROM   inmprodu , inamedid
	WHERE ( inmprodu.prod_medida = inamedid.medi_medida ) AND
		   (prod_g_financiero =:str.g_financiero) AND
		   (prod_empresa=:str.empresa) AND
		   (prod_producto =:is_producto);
			
	if sqlca.sqlcode = - 1 then
		messagebox('Atenciòn','Error al leer informaciòn del producto')
		dw_2.SetColumn("item")
		dw_2.setfocus()		
		return
	elseif	sqlca.sqlcode = 100 then
		messagebox('Atenciòn','Producto No Existe')
		dw_2.SetColumn("item")
		dw_2.setfocus()		
		return
	end if
	
	  SELECT isnull(sum(dmov_cantidad),0)  
		 INTO :ld_cantidad  
		 FROM indmovim  
		WHERE ( indmovim.dmov_g_financiero = :str.g_financiero ) AND  
				( indmovim.dmov_empresa = :str.empresa ) AND  
				( indmovim.dmov_aplicacion = 'IN' ) AND  
				( indmovim.dmov_tipo_transaccion = 'EN' ) AND  
				( indmovim.dmov_secuencia = :ll_entrada_sec ) AND  
				( indmovim.dmov_anual = :li_ann ) AND  
				( indmovim.dmov_producto = :is_producto )   ;
			if sqlca.sqlcode = - 1 then
				messagebox('Atenciòn','Error al Buscar la cantidad del producto')
				dw_2.SetColumn("item")
				dw_2.setfocus()		
				return
			end if
	
	If status = 1 Then 
		dw_2.SetItem(row,"descripcion", ls_descripcion)
		dw_2.setitem(row,"unidad",ls_medida)
		dw_2.setitem(row,"cantidad",ld_cantidad)
	Else
		MessageBox('Atención','Este producto no esta activo, ¡Verificar!')
		dw_2.SetItem(row,"item", '')		
		dw_2.setitem(row,"precio",0)
		dw_2.setitem(row,"cantidad",0)
		dw_2.setitem(row,"fracion",0)
		dw_2.setitem(row,"total",0)		
		dw_2.SetColumn("item")		
		dw_2.setfocus()		
	End If
	
	dw_2.setitem(row,"precio",ld_costo_cif) /*Costo de Unidad de Producto*/	

	 	Select medi_cantidad
		Into   :ld_prod_convert
		From   inamedid
		Where  (medi_medida =: ls_medida);
	
	ld_porciento = dw_2.getitemnumber(row,'porciento')

	if ld_porciento = 0 then
		dw_2.setItem(row,'total',(ld_costo_cif * ld_cantidad ))		
	else
		dw_2.setItem(row,'total',(ld_costo_cif * ld_cantidad ) * (ld_porciento / 100))
	end if
	
ElseIf columna = "cantidad" Then
	is_producto=dw_2.GetItemString(row,"item")

	li_cantidad = dec(data) 
	if isnull(li_cantidad) then li_cantidad = 0
	li_fraccion = dw_2.GetItemdecimal(row,"fracion")
	if isnull(li_fraccion) then li_fraccion = 0
 	ld_costo=dw_2.GetItemdecimal(row,"precio")	
	ls_unidad = dw_2.getitemstring(row,'unidad')	 
	 	Select medi_cantidad
		Into   :ld_prod_convert
		From   inamedid
		Where  (medi_medida =: ls_unidad);
	
	ld_porciento = dw_2.getitemnumber(row,'porciento')

	if ld_porciento = 0 then
		dw_2.setItem(row,'total',(ld_costo * li_cantidad + (ld_costo / ld_prod_convert * li_fraccion )))		
	else
		dw_2.setItem(row,'total',(ld_costo * li_cantidad + (ld_costo / ld_prod_convert * li_fraccion )) * (ld_porciento / 100))
	end if

ElseIf columna = "fracion" Then
	is_producto=dw_2.GetItemString(row,"item")

	li_fraccion = dec(data) 
	if isnull(li_cantidad) then li_cantidad = 0
	li_cantidad = dw_2.GetItemdecimal(row,"cantidad")
	if isnull(li_fraccion) then li_fraccion = 0
 	ld_costo=dw_2.GetItemdecimal(row,"precio")	
	ls_unidad = dw_2.getitemstring(row,'unidad')	 
	 	Select medi_cantidad
	Into   :ld_prod_convert
	From   inamedid
	Where  (medi_medida =: ls_unidad);
	
	ld_porciento = dw_2.getitemnumber(row,'porciento')

	if ld_porciento = 0 then
		dw_2.setItem(row,'total',(ld_costo * li_cantidad + (ld_costo / ld_prod_convert * li_fraccion )))		
	else
		dw_2.setItem(row,'total',(ld_costo * li_cantidad + (ld_costo / ld_prod_convert * li_fraccion )) * (ld_porciento / 100))
	end if

ElseIf columna = "precio" Then
	li_cantidad = dw_2.GetItemdecimal(row,"cantidad")
	if isnull(li_cantidad) then li_cantidad = 0
	li_fraccion = dw_2.GetItemdecimal(row,"fracion")
	if isnull(li_fraccion) then li_fraccion = 0
 	ld_costo=dw_2.GetItemdecimal(row,"precio")	
	ls_unidad = dw_2.getitemstring(row,'unidad')	 
	 	Select medi_cantidad
	Into   :ld_prod_convert
	From   inamedid
	Where  (medi_medida =: ls_unidad);
	
	ld_porciento = dw_2.getitemnumber(row,'porciento')
	 
	if ld_porciento = 0 then
		dw_2.setItem(row,'total',(ld_costo * li_cantidad + (ld_costo / ld_prod_convert * li_fraccion )))		
	else
		dw_2.setItem(row,'total',(ld_costo * li_cantidad + (ld_costo / ld_prod_convert * li_fraccion )) * (ld_porciento/100) )
	end if	
elseif columna = 'porciento' then
	ld_porciento = dw_2.getitemnumber(row,'porciento')
	li_cantidad = dw_2.GetItemdecimal(row,"cantidad")
	if isnull(li_cantidad) then li_cantidad = 0
	li_fraccion = dw_2.GetItemdecimal(row,"fracion")
	if isnull(li_fraccion) then li_fraccion = 0
 	ld_costo=dw_2.GetItemdecimal(row,"precio")	
	ls_unidad = dw_2.getitemstring(row,'unidad')	 
 	Select medi_cantidad
	Into   :ld_prod_convert
	From   inamedid
	Where  (medi_medida =: ls_unidad);
	 
	if ld_porciento = 0 then
		dw_2.setItem(row,'total',(ld_costo * li_cantidad + (ld_costo / ld_prod_convert * li_fraccion )))		
	else
		dw_2.setItem(row,'total',(ld_costo * li_cantidad + (ld_costo / ld_prod_convert * li_fraccion )) * (ld_porciento/100) )
	end if
End if


m_in_principal.m_archivo.m_guardar.enabled = true
dw=dw_2
medida()
end event

event dw_2::clicked;dw = dw_2

if this.rowcount() = 0 then
	parent.triggerevent('ue_adicionar')
end if

if dwo.name = 'b_new' then
	dw_4.retrieve()
	dw_4.visible = true	
	dw_4.setfocus()
	
end if
end event

event dw_2::itemchanged;//Declaracion de Variables****************************************//
this.accepttext()
this.post event ue_post_changed(dw_2.GetColumnName(),row,data)


end event

event dw_2::ue_enter;this.accepttext()
IF not (dw_2.GETItemString(dw_2.GetRow(),"item") = ' ' OR  dw_2.GETItemString(dw_2.GetRow(),"item") = '') then
	send(handle(this),256,9,long(0,0))
end if

integer li_cantidad,li_cant,li_residuo
if dw_2.GetColumnName() = "cantidad" then
	 dw_2.acceptText()
	 is_producto=dw_2.getitemstring(dw_2.getrow(),"item")
	 li_cantidad= dw_2.getitemnumber(dw_2.getrow(),"cantidad")
end if
	

integer li_fin
//send(handle(this),256,9,long(0,0))
if dw_2.GetColumnName() = "total" then
	dw_2.setfocus()
	dw_2.setcolumn('item')
	if dw_2.rowcount()=dw_2.getrow() then
		dw = dw_2
		this.triggerevent("ue_adicionar")
		dw_2.scrolltorow(dw_2.getrow())		
	else
		dw_2.scrolltorow(dw_2.getrow() + 1)	
	end if 

end if

ii_entre = 0

return 1	
end event

event dw_2::doubleclicked;dw = dw_2

str_detalles   str_datos
Integer li_existe_detalle
Double ld_cant
Decimal ld_precio
String ls_prod, ls_bod, ls_ubi, ls_tipo

ls_tipo = gf_tipo_inventario()
If ls_tipo = 'S' Then Return


end event

event dw_2::rowfocuschanged;/*dw = dw_2*/

end event

event dw_2::getfocus;dw = dw_2
end event

event dw_2::itemfocuschanged;///**/
//Decimal	li_costo, ld_prod_convert,ld_conv_aj,ld_costo_cif
//String	ls_medida, ls_expresion,ls_unidad_aj, ls_message
//Integer	li_find, li_sqlca
//
//if dw_2.getcolumnName()="cantidad" then
//
//	is_producto=dw_2.GetItemString(row,"item")
//		
//	wf_prod_convert(is_producto,ld_costo_cif,ls_medida,ld_prod_convert,li_sqlca)
//	ls_message =''
//		
//	if li_sqlca = - 1 then
//		messagebox('Atenciòn','Error al leer el costo del producto ')
//		dw_2.setitem(row,"precio",0)
//		dw_2.SetColumn("unidad")
//		dw_2.setfocus()		
//		return
//	end if
//	
//	ls_unidad_aj = dw_2.GetItemString(row,"unidad")
//	
//	/*Unidad de conversion de la unidad del ajuste*/
//		Select medi_cantidad
//		Into   :ld_conv_aj
//		From   inamedid
//		Where  (medi_medida =: ls_unidad_aj);
//
//		if sqlca.sqlcode = - 1 then
//			messagebox('Atenciòn','Error al leer uniddad de conversión de la unidad de ajuste ')
//			return
//		end if
//		
//		if IsNull(ld_conv_aj) or ld_conv_aj = 0 then ld_conv_aj =1
//		if IsNull(ld_prod_convert) or ld_prod_convert = 0 then ld_prod_convert =1
//
//		ld_costo_cif = round((ld_costo_cif/ld_prod_convert)*ld_conv_aj,2)
//
//		dw_2.setitem(row,"precio",ld_costo_cif) /*Costo de la Unidad del Ajuste*/
//	
//end if
///**/
end event

type gb_ventana from w_in_padre`gb_ventana within w_captura_notas_credito
boolean visible = false
integer x = 5
integer y = 1348
integer height = 104
integer taborder = 90
long textcolor = 0
end type

type ln_1 from line within w_captura_notas_credito
long linecolor = 16777215
integer linethickness = 4
integer beginx = 5
integer beginy = 496
integer endx = 2798
integer endy = 496
end type

type cbx_1 from checkbox within w_captura_notas_credito
boolean visible = false
integer x = 2053
integer y = 1384
integer width = 773
integer height = 76
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Capturar Comentarios por linea"
borderstyle borderstyle = styleraised!
boolean righttoleft = true
end type

event clicked;if this.checked=true then
	dw_2.Modify("DataWindow.Detail.Height='150'")
	//dw_2.Object.DataWindow.Detail.Height.AutoSize='No'
	dw_2.Modify("inmprodu_prod_descripcion.Height.AutoSize=No>")
	dw_2.Modify("dmov_comentarios.Visible='1'")
	dw_2.Modify("dmov_comentarios.y='72'")
else
	dw_2.Modify("DataWindow.Detail.Height='68'")
	//dw_2.Object.DataWindow.Detail.Height.AutoSize='Yes'	
	dw_2.Modify("dmov_comentarios.Visible='0'")
	dw_2.Modify("dmov_comentarios.y='0'")
end if
end event

type dw_3 from datawindow within w_captura_notas_credito
boolean visible = false
integer y = 16
integer width = 3365
integer height = 1828
integer taborder = 110
boolean bringtotop = true
boolean titlebar = true
string title = "Impresion de Notas de Credito"
string dataobject = "dw_reporte_nc"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_ubicacion from checkbox within w_captura_notas_credito
boolean visible = false
integer x = 1083
integer y = 1384
integer width = 453
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ver Ubicación"
end type

event clicked;If cbx_ubicacion.checked = true then
	dw_3.visible = true
else
	dw_3.visible = false
end if
end event

type cb_1 from commandbutton within w_captura_notas_credito
boolean visible = false
integer x = 1531
integer y = 4
integer width = 411
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Activar Ajuste"
end type

event clicked;//str.usuario = 'HGN'
String	ls_autoriza_s_n,ls_autoriza

if dw_1.GetItemNumber(1,'tmov_estado') = 2 and str.usuario = 'SA' then
	dw_1.setitem(1,"tmov_estado",1)
	dw_1.setitem(1,"tmov_estado_costo",0)
	//w_in_ajuste_exit_costo.triggerevent("ue_aceptar")    VAlidar 23-10-2026
//	wf_guardar_informacion()
//	tab_1.tabpage_2.enabled = true
else 
	If dw_1.GetItemNumber(1,'tmov_estado') = 2 then /*Estado actualizado lote cantidad*/
//		if w_in_fondo.str_aplica_links.controla_modificaciones =1 then /*Controla modificaciones*/	

			openwithparm(w_dg_man_clave,ls_autoriza)
			
			ls_autoriza_s_n = Message.StringParm 
			
			CHOOSE CASE ls_autoriza_s_n
			CASE '1'	//Usuario Autorizado
				dw_1.setitem(1,"tmov_estado",1)
				dw_1.setitem(1,"tmov_estado_costo",0)
				
				//w_in_ajuste_exit_costo.triggerevent("ue_aceptar") VALIDAR 23-10-2026
				
//				wf_guardar_informacion()
//				tab_1.tabpage_2.enabled = true				
			CASE '2'	//Usuario no Autorizado
				messagebox('Atención ','Estimado Usuario Ud. no está autorizado para activar Entradas, consulte a su Supervisor...!!!')
			CASE ELSE
				/*No controla o se produjo un error*/
			END CHOOSE

//		end if
	end if
end if


end event

type cb_2 from commandbutton within w_captura_notas_credito
integer x = 2638
integer y = 140
integer width = 562
integer height = 132
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "ACTUALIZAR"
end type

event clicked;
if gf_mensaje('','Se Actualizara la Nota de Credito, Esta Seguro ?',2,1,'Q') = 1 then

  UPDATE notascr_encab  
     SET estado = 1  
   WHERE ( notascr_encab.g_financiero = :str.g_financiero ) AND  
         ( notascr_encab.empresa = :str.empresa ) AND  
         ( notascr_encab.documento = :is_documento ) AND  
         ( notascr_encab.ann = :ii_ann ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Actualizar NC '+sqlca.sqlerrtext,1,1,'E')
			return
		end if
	
	dw_1.retrieve(str.g_financiero, str.empresa, is_documento, ii_ann)
	dw_2.retrieve(str.g_financiero, str.empresa, is_documento, ii_ann)	

end if
end event

type dw_4 from datawindow within w_captura_notas_credito
boolean visible = false
integer x = 1509
integer y = 868
integer width = 1056
integer height = 952
integer taborder = 60
boolean bringtotop = true
boolean titlebar = true
string title = "Tipos de N/Cr"
string dataobject = "dw_tipos_notacr"
boolean controlmenu = true
boolean vscrollbar = true
string icon = "DosEdit5!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;choose case dwo.name
	case 'b_adicionar'
		this.scrolltorow(this.insertrow(0))
	case 'b_guardar'
		if this.update() = -1 then
			gf_mensaje('','Error al Guardar '+sqlca.sqlerrtext,1,1,'E')
		end if
		idwc_tipo.retrieve()
end choose
end event

