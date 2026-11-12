//objectcomments Ventana de Devolución de Mercancía
forward
global type w_fa_man_modi_devolucion from w_fa_padre_maest_det
end type
type em_ann from editmask within w_fa_man_modi_devolucion
end type
type sle_pedido from singlelineedit within w_fa_man_modi_devolucion
end type
type cb_incluir from commandbutton within w_fa_man_modi_devolucion
end type
type gb_3 from groupbox within w_fa_man_modi_devolucion
end type
type em_total from editmask within w_fa_man_modi_devolucion
end type
type em_cargos from editmask within w_fa_man_modi_devolucion
end type
type em_final from editmask within w_fa_man_modi_devolucion
end type
type st_1 from statictext within w_fa_man_modi_devolucion
end type
type st_4 from statictext within w_fa_man_modi_devolucion
end type
type pb_1 from picturebutton within w_fa_man_modi_devolucion
end type
type st_2 from statictext within w_fa_man_modi_devolucion
end type
type st_5 from statictext within w_fa_man_modi_devolucion
end type
type em_desc from editmask within w_fa_man_modi_devolucion
end type
type st_6 from statictext within w_fa_man_modi_devolucion
end type
type cb_1 from commandbutton within w_fa_man_modi_devolucion
end type
type dw_4 from datawindow within w_fa_man_modi_devolucion
end type
type st_microhelp from statictext within w_fa_man_modi_devolucion
end type
type dw_3 from datawindow within w_fa_man_modi_devolucion
end type
type em_fecha from editmask within w_fa_man_modi_devolucion
end type
end forward

global type w_fa_man_modi_devolucion from w_fa_padre_maest_det
integer width = 3282
integer height = 1560
string title = "(FA) Modificacion de Devolucion de Mercancia"
string menuname = "m_hs"
boolean controlmenu = false
long backcolor = 79739096
event ue_adicionar ( )
event ue_config_cant ( )
event ue_vista ( )
em_ann em_ann
sle_pedido sle_pedido
cb_incluir cb_incluir
gb_3 gb_3
em_total em_total
em_cargos em_cargos
em_final em_final
st_1 st_1
st_4 st_4
pb_1 pb_1
st_2 st_2
st_5 st_5
em_desc em_desc
st_6 st_6
cb_1 cb_1
dw_4 dw_4
st_microhelp st_microhelp
dw_3 dw_3
em_fecha em_fecha
end type
global w_fa_man_modi_devolucion w_fa_man_modi_devolucion

type variables
String is_pedido, is_pedido_nc,is_tipo_fac,is_nativo,is_user
integer ii_ann, ii_pormayor, ii_flag = 0, il_modifica
double id_desc
long     il_secuencia
//Variable tipo estructura para cuando es parcial
//se pasan los parametros a la ventana

str_fa_devolucion str_argumen
str_fa_carg_ped str_pedi

//Para validar al cerrar la ventana
boolean ib_preguntar = true, ib_modificacion = false, ib_cerrar = false

DataStore ids_enca, ids_deta, ids_cargos

datawindow dw_actual,dw

DatawindowChild chdw_devolucion, dwc_tipo_fac,dwc_tipo_fac1,chdw_dev_pedido

// Utilizadas por DESGLOSE
String                   is_column
uo_ds_desglose  iuo_desglose

integer li_primera_vez = 0
//, li_viene_de_guardar=0
end variables

forward prototypes
public function string wf_unidad_empaque (string codigo)
public subroutine wf_picture_icon (long al_row)
public subroutine wf_imprime_vendedor ()
public subroutine wf_actualiza_vendedores ()
public subroutine wf_act_menor (string ls_numero)
public subroutine wf_modifica_precio ()
public subroutine wf_desg_dev_total ()
public subroutine wf_ajusta_totales ()
public subroutine wf_protege ()
public subroutine wf_botones ()
public function boolean wf_valida_todo (integer ldw_1)
public subroutine wf_recupera_nc ()
public function integer wf_act_cargos ()
public function integer wf_act_detalle (datawindow ldw_2)
public function integer wf_act_encabezado (datawindow ldw_1, long row)
public subroutine wf_act_mayor (string ls_numero)
public subroutine wf_act_sec_facturas (string ls_factura, string ls_pedido, ref boolean ab_act_secuencia)
public function integer wf_actualiza_cliente ()
public subroutine wf_actualiza_devol (string ls_numero, ref boolean ab_act_devol)
public function integer wf_actualiza_inventario (datawindow ldw_1, long row)
public function string wf_asigna_pedido (string pedido)
public subroutine wf_blanquea_totales ()
public subroutine wf_busca_detalle ()
public subroutine wf_busca_secuencia (ref string as_no_factura)
public function double wf_calcula_cargos (datawindow ldw_2, double ld_monto_total, integer li_bultos)
public subroutine wf_calcula_comisiones (double ad_monto, string as_tipo, integer ai_venta)
public function double wf_calcula_desc (double ad_total)
public function double wf_calcula_desc_detalle (double ad_var)
public function decimal wf_calcula_descuento_acisa ()
public function long wf_cantidad_total (long cantidad, integer fraccion, datawindow ldw_2, long row)
public subroutine wf_carga_cadena ()
public subroutine wf_cargos (double ld_cargos)
public subroutine wf_control ()
public subroutine wf_control2 ()
public subroutine wf_elimina_blanco ()
public function integer wf_elimina_det (string ls_pedido, integer li_anio, string ls_tipo)
public function integer wf_empaque_prod (string codigo)
public function long wf_recupera (string estado)
public subroutine wf_recupera_devueltas (long linea, datawindow ldw)
public function integer wf_recupera_dias (integer li_codigo_dias)
public subroutine wf_setea_iniciales ()
public subroutine wf_setea_lineas ()
public subroutine wf_setea_originales (long ll_cantidad1, integer li_fraccion2, double ld_monto, double ld_final, datawindow ldw_2, long row, integer devueltas)
public subroutine wf_setear_user (string as_user)
public subroutine wf_totaliza ()
end prototypes

event ue_adicionar;//Adiciona una nueva N/CR.
//Si esta en el DW 1
string ls_pedido, ls_campo
DwItemStatus ls_estatus1, ls_estatus2
Datetime ldt_fecha

If ib_cual_dw then
	//Función que muestra el significado del campo en la barra de abajo
	gf_micro_ayuda(dw_1)

		if dw_2.Rowcount() > 0 Then
			ls_estatus1 = dw_1.GetItemStatus(dw_1.Getrow(),0,primary!)
			ls_estatus2 = dw_2.GetItemStatus(dw_2.Getrow(),0,primary!)			
		
			If (ls_estatus1 = DataModified!) or (ls_estatus1 = Newmodified!) or & 
				(ls_estatus2 = DataModified!) or (ls_estatus2 = Newmodified!) then
				if wf_valida_todo(1) then // Devuelve true si se le da cancelar
					return 
				end if
			end if
		end if

if dw_1.Rowcount() = 0 then dw_1.scrolltorow(dw_1.insertrow(0))
	ls_pedido = dw_1.getitemstring(dw_1.getrow(),"fact_no_pedido")
	if ls_pedido <> "" or not isnull(ls_pedido) Then
		dw_1.Setcolumn(1)	
		dw_1.scrolltorow(dw_1.insertrow(0))

		ldt_fecha = gf_fecha_serv()
		
		dw_1.SetItem(1,"fact_fecha_modificacion",ldt_fecha)
		dw_1.SetItem(1,"fact_fecha",ldt_fecha)

		wf_setea_iniciales()
		//Cuando se adiciona, blanquea el detalle y los totales.
		dw_2.reset()
		dw_2.Scrolltorow(dw_2.insertrow(0))
		dw_2.setitem(dw_2.getrow(),"mod_precio",il_modifica)
		ii_flag = 0
		wf_blanquea_totales()
		ib_modificacion = false
		wf_control2()
	end if
End If

end event

event ue_config_cant;/******************************************************************************************
 *	Evento:	ue_config_cant																						*
 *																														*
 *	Propósito: Configura los Parámetros para llamar a la ventana de Desglose					*
 *																														*
 *	Fecha Creación: 21 / 4 / 99																				*
 *																														*
 *																														*
 ******************************************************************************************/
Decimal			ld_fraccion, ldc_rtn
Integer			li_row, li_entero, li_si[], li_no[]
String			ls_medida, ls_gcolor, ls_gtam, ls_producto, ls_estado
str_desglose	lstr_arg

li_row		= dw_2.GetRow ()
li_entero	= dw_2.GetItemNumber (li_row, "facd_cantidad")
ld_fraccion	= dw_2.GetItemNumber (li_row, "facd_cantidad_fraccion")
ls_medida	= dw_2.GetItemString (li_row, "facd_unidad_venta")

// Convirtiendo el ENTERO y la FRACCION en DECIMAL
ld_fraccion = gf_conv_cantidad (li_entero, ld_fraccion, 'C', ls_medida)

ls_producto = dw_2.GetItemString (li_row, "facd_codigo_item")
// Eliminando el _ del Código de Item
//ls_producto = Left (ls_producto, Pos (ls_producto, '_') - 1)

// Obteniendo el Grupo de Color y el Grupo de Tamaño
  SELECT inmprodu.prod_color,   
         inmprodu.prod_cod_clase_tam  
    INTO :ls_gcolor,   
         :ls_gtam  
    FROM inmprodu  
   WHERE inmprodu.prod_producto = :ls_producto  And
			inmprodu.prod_g_financiero  = :str.g_financiero And
			inmprodu.prod_empresa = :str.empresa;
			
		if sqlca.sqlcode = -1 then
			mensaje("Información (ue_config_cant)","Error al Seleccionar registros en inmprodu",sqlca.sqlerrtext)
			return
		end if				

// Argumentos
lstr_arg.dataobject = "dw_ma_fa_desglose_factura_desc"
lstr_arg.ds			  = iuo_desglose
lstr_arg.cantidad	  = ld_fraccion
lstr_arg.numero [2] = dw_2.GetItemNumber (li_row, "facd_linea_articulo_dev")
//lstr_arg.numero [3] = dw_2.GetItemString (li_row, "facd_tipo") // comentario by HG
lstr_arg.cadena [1] = 'Devolución de Desglose de Cantidades'
lstr_arg.cadena [2] = dw_2.GetItemString (li_row, "facd_no_pedido")
lstr_arg.grupo_tam  = ls_gtam
lstr_arg.g_color	  = ls_gcolor
lstr_arg.anno		  = ii_ann
lstr_arg.medida	  = ls_medida
lstr_arg.filtro	  = "dcdi_linea = " + string (lstr_arg.numero [2])
lstr_arg.param 	  = 'DES'

//OpenWithParm (w_fa_man_desg_factura, lstr_arg)

ldc_rtn = Message.DoubleParm
iuo_desglose.SetFilter ("")
iuo_desglose.Filter ()

// Hubo Cambios en el DS de Desglose
If ldc_rtn > 0.0 Then
	gf_conv_cantidad (li_entero, ldc_rtn, 'A', ls_medida)
	m_fa_padre.m_archivo.m_guardar.enabled	= True
	dw_2.Object.facd_cantidad_fraccion [long (li_row)] = ldc_rtn
	dw_2.Object.facd_cantidad [long (li_row)] 			= li_entero
End If
end event

public function string wf_unidad_empaque (string codigo);//Busca y retorna la unidad de empaque del producto
  string ls_unidad_empaque
  
  SELECT inmprodu.prod_empaque_um  
    INTO :ls_unidad_empaque  
    FROM inmprodu  
   WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
         ( inmprodu.prod_empresa = :str.empresa ) AND  
         ( inmprodu.prod_producto = :codigo ) ;

	if sqlca.sqlcode = -1 then 
		gf_mensaje("","Error al Seleccionar Empaque de Producto "+sqlca.sqlerrtext,1,1,"E")
	end if

return(ls_unidad_empaque)
end function

public subroutine wf_picture_icon (long al_row);/******************************************************************************************
 * Function: wf_picture_icon																					*
 *																														*
 * Purpose: Coloca la imagen de desglose dependiendo si tiene o no desglose asociado.		*
 *																														*
 *	Scope: ventana																									*
 *																														*
 *	Arguments: al_row		{Línea del Detalle}																*
 *																														*
 *	Returns: Nada																									*
 *																														*
 * Created:	22 / Abril / 1999																					*
 ******************************************************************************************/
Integer		li_linea
String		ls_icon

// Se modifico el Item
// Colocando la imagen en DESGLOSE dependiendo si tiene o no desglose.
ls_icon 	= str.path + 'art/desglose_s.bmp'
li_linea = dw_2.GetItemNumber (al_row, "facd_linea_articulo_dev")

If iuo_desglose.Dynamic of_tienedesglose (li_linea, "dcdi_linea") Then
	dw_2.SetItem (al_row, "desglose", ls_icon)
Else
	dw_2.SetItem (al_row, "desglose", '')
End If
end subroutine

public subroutine wf_imprime_vendedor ();integer li_hay, li_codigo, i=0
string  ls_nombre, ls_resultado, ls_nombre_imp, ls_cod_imp

datawindow ldw_3

ldw_3 = dw_3
		
		 DECLARE cur_vende CURSOR FOR
		  SELECT fadvenfa.vfac_vendedor,   
					famvende.vend_nombre+' '+famvende.vend_apellido nombre  
			 FROM fadvenfa,   
					famvende  
			WHERE ( famvende.vend_g_financiero = fadvenfa.vfac_g_financiero ) and  
					( famvende.vend_empresa = fadvenfa.vfac_empresa ) and  
					( famvende.vend_vendedor = fadvenfa.vfac_vendedor ) and  
					( ( fadvenfa.vfac_g_financiero = :str.g_financiero ) AND  
					( fadvenfa.vfac_empresa = :str.empresa ) AND  
					( fadvenfa.vfac_no_pedido = :is_pedido_nc ) AND  
					( fadvenfa.vfac_ann = :ii_ann ) ) ;			 
	
 OPEN cur_vende;
 
 if sqlca.sqlcode = -1 then
	mensaje("Aviso","Error al Abrir el Cursor",sqlca.sqlerrtext)
 end if
 
 FETCH cur_vende INTO :li_codigo,:ls_nombre;
 
 IF SQLCA.SQLCODE = -1 THEN	
	MESSAGEBOX("ERROR","ERROR AL SELECCIONAR LOS VENDEDORES "+SQLCA.SQLERRTEXT)
	CLOSE cur_vende;
	RETURN
 END IF	
 
 DO WHILE SQLCA.SQLCODE = 0
	 if i > 0 then //Si no es la primera vez ni la ultima, separa el codigo
	 	ls_nombre_imp += ' / '
		ls_cod_imp	+= ' / '		
	 end if	 
	 ls_nombre_imp += ls_nombre 	     //Concatena los codigos y nombres
	 ls_cod_imp		+= string(li_codigo)	 
	 i ++	 //Incrementa la i
	 FETCH cur_vende INTO :li_codigo,:ls_nombre;	 
 loop
 
 ls_resultado = ldw_3.modify("cod_vendedor.text='"+ls_cod_imp+"'")
 ls_resultado = ldw_3.modify("nom_vendedor.text='"+ls_nombre_imp+"'")			
	 
 CLOSE cur_vende;
end subroutine

public subroutine wf_actualiza_vendedores ();//Función llamada desde ue_aceptar, para adicionar los vendedores a la factura
integer li_existe
string ls_error

  SELECT count(*)  
    INTO :li_existe  
    FROM fadvenfa  
   WHERE ( fadvenfa.vfac_g_financiero = :str.g_financiero ) AND  
         ( fadvenfa.vfac_empresa = :str.empresa ) AND  
         ( fadvenfa.vfac_tipo = :is_tipo_fac ) AND  
         ( fadvenfa.vfac_no_pedido = :is_pedido_nc ) AND  
         ( fadvenfa.vfac_ann = :w_fa_fondo.str_para.ano )   ;
		if sqlca.sqlcode = -1 then
			mensaje("Atención","Error al validar la existencia de los vendedores por factura",sqlca.sqlerrtext)
			return
		end if

	if li_existe = 0 then

	  INSERT INTO fadvenfa  
         ( vfac_g_financiero,   
           vfac_empresa,   
           vfac_tipo,   
           vfac_no_pedido,   
           vfac_ann,   
           vfac_vendedor )  
     SELECT fadvenfa.vfac_g_financiero,   
            fadvenfa.vfac_empresa,   
            fadvenfa.vfac_tipo,   
            :is_pedido_nc,   
            :w_fa_fondo.str_para.ano,   
            fadvenfa.vfac_vendedor  
       FROM fadvenfa  
      WHERE ( fadvenfa.vfac_g_financiero = :str.g_financiero ) AND  
            ( fadvenfa.vfac_empresa = :str.empresa ) AND  
            ( fadvenfa.vfac_tipo = :is_tipo_fac ) AND  
            ( fadvenfa.vfac_no_pedido = :is_pedido ) AND  
            ( fadvenfa.vfac_ann = :ii_ann ) ;
				
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Atención","Error al Actualizar los vendedores por factura",ls_error)
			return
		end if
	
	end if


end subroutine

public subroutine wf_act_menor (string ls_numero);//Actualiza la secuencia de las facturas al por menor
string ls_tipo_menor
integer li_existe
str.frame.setmicrohelp("Actualizando secuencia...")
ls_numero = dw_1.getitemstring(dw_1.getrow(),"fact_no_factura")	

  SELECT faaparam.fara_por_menor  
    INTO :ls_tipo_menor
    FROM faaparam  ;
	 
		if sqlca.sqlcode = -1 then
			mensaje("Información(wf_act_menor)","Error al Seleccionar registros en faaparam",sqlca.sqlerrtext)
			return
		end if		 

 CHOOSE CASE ls_tipo_menor
	CASE "GT"
   UPDATE faaparam  
   SET fara_ult_fact_menor = :ls_numero  
   WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
         ( faaparam.fara_empresa = :str.empresa )   ;	 
 		 
	CASE "GL"
	UPDATE faaparam  
	SET fara_ult_ultima_factura = :ls_numero  
	WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
		( faaparam.fara_empresa = :str.empresa )   ;	 		 
		 
	CASE ELSE
	// abrir ventana para seleccionar la secuencia de la caja , filtrar por tipo = caja

	SELECT count(*)
	  INTO :li_existe
	  FROM famcajap
	 WHERE ( famcajap.faca_g_financiero = :str.g_financiero ) AND  
			 ( famcajap.faca_empresa = :str.empresa ) AND
			 ( famcajap.faca_venta = "PM" );  
				
		if sqlca.sqlcode = -1 then
			mensaje("Información(wf_act_menor)","Error al Seleccionar la cantidad de registros en famcajad",sqlca.sqlerrtext)
			return
		end if					

			
		if li_existe > 0 then
		//	OpenWithParm(w_fa_man_fac_Sec,"PY")
		  UPDATE famcajap  
	     SET faca_secuencia = :ls_numero  
   	  WHERE ( famcajap.faca_g_financiero = :str.g_financiero ) AND  
        		  ( famcajap.faca_empresa = :str.empresa ) AND  
		        ( famcajap.faca_venta = "PM" );
	 	else
			messagebox("ATENCIÓN SR. USUARIO","Verifique la Secuencia al por mayor en Cajas",Exclamation!)
		end if
		
 END CHOOSE
 
 if sqlca.sqlcode = -1 then
	messagebox("ATENCIÓN SR. USUARIO","Error al actualizar la secuencia, Verifique. : "+sqlca.sqlerrtext)
	rollback ;
 else
	commit ;
 end if
str.frame.setmicrohelp("")
return
end subroutine

public subroutine wf_modifica_precio ();///Función que verifica el parámetro que define si se pueden modificar los precios o no
 string	ls_mod_precio

  SELECT faaparam.fara_modificar_precio  
    INTO :ls_mod_precio  
    FROM faaparam  
   WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
         ( faaparam.fara_empresa = :str.empresa )   ;


 if ls_mod_precio = 'S' then
	il_modifica = 1
else
	il_modifica = 0
end if
end subroutine

public subroutine wf_desg_dev_total ();// Devolución Total del Desglose
// 28 de Abril de 1999
Integer		li_i, li_rowcount

iuo_desglose.Retrieve (str.g_financiero,str.empresa, is_pedido/*,is_tipo_fac*/ ,ii_ann)

li_rowcount = iuo_desglose.RowCount ()
//Messagebox ('ROwCount ANTES', string (li_rowcount))
For li_i = 1 To li_rowcount
	iuo_desglose.Object.dcdi_cant_devuelta [long (li_i)] = &
	iuo_desglose.Object.dcdi_cantidad [long (li_i)]
Next

//Messagebox ('ROwCount ANTES', string (iuo_desglose.RowCount ()))
end subroutine

public subroutine wf_ajusta_totales ();//Función que recalcula los totales finales
double ld_suma, ld_cargos, ld_desc
integer li_bultos

//asigna totales
//	 ld_suma			= dw_2.getitemnumber(dw_2.getrow(),"suma")
//	 li_bultos 		= dw_2.getitemnumber(dw_2.getrow(),"bultos")

    ld_suma       = double(mid(em_total.text,2))
	 ld_cargos 		= double(mid(em_cargos.text,2))
	 ld_desc			= double(mid(em_desc.text,2))

	 em_final.text = string(ld_suma + ld_cargos - ld_desc)
	 
    
end subroutine

public subroutine wf_protege ();//Si el menu no es valido, lo cambia
//if not isvalid(m_fa_principal) then
//	this.changemenu(m_fa_principal)
//end if	
//Protege una vez que se imprimio la devolucion
//m_fa_padre.m_edicin.m_eliminar.enabled  = true	
//m_fa_padre.m_archivo.m_guardar.enabled = true
//m_fa_padre.m_edicin.m_adicionar.enabled  = false				
//m_fa_padre.m_archivo.m_imprimir.enabled = true

end subroutine

public subroutine wf_botones ();//// Deshabilita el 
//	m_fa_padre.m_edicin.m_insertar.toolbaritemvisible	= true
//	m_fa_padre.m_edicin.m_filtrar.toolbaritemvisible	= False
//	m_fa_padre.m_edicin.m_sortear.toolbaritemvisible	= False
////	m_fa_padre.m_edicin.m_herramientas.m_copiar.m_defactura.enabled=true
//	m_fa_padre.m_archivo.m_guardar.enabled 				= true
//	wf_control2()
//	m_fa_padre.m_ventanas.m_regla.toolbaritemvisible	= False
//	m_fa_padre.m_archivo.m_vistapreliminar.toolbaritemvisible=false
//	m_fa_padre.m_archivo.m_vistapreliminar.visible = false
//	m_fa_padre.m_archivo.m_vistapreliminar.enabled = false

end subroutine

public function boolean wf_valida_todo (integer ldw_1);string ls_titulo
long respuesta,ll_cont 

dwItemStatus l_status,l_status2,l_status3

// Mira si el Dw del tab anterior tiene datos
// de Tenerlos mire si al cambiar de tab el Dw a sufrido modificaciones 
IF dw_1.accepttext() = 1 THEN
 l_status = dw_1.GetItemStatus(dw_1.getrow(),0, Primary!)	
 l_status2=	dw_2.GetItemStatus(dw_2.getrow(),0, Primary!)	
 
  if (l_status <> NotModified! and l_status <> new!) or dw_2.DeletedCount () <> 0 or &
  	  (l_status2 <> NotModified! and l_status2 <> new!)	then
		respuesta = messagebox("Atención","La Información en la Devolucion no ha sido guardada!  ~n" + &
		                       "     ... Desea guardarla ahora?",question!,YesNoCancel!) 
		choose case respuesta 
			case 1 		
				w_fa_man_modi_devolucion.triggerevent("ue_aceptar")
				return false
			case 2
				ROLLBACK using sqlca; 	
				return false
		   case 3
             return(true)
		end choose
	end if
END IF

return(false)
end function

public subroutine wf_recupera_nc ();//Recupera los datos del dropdown
//Recupera los pedidos
string 	ls_where
integer  li_mostrar, li_desde

ls_where = is_nativo + " and  &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+" ) AND &
					 ( fatdiari.fact_estado =   'I' ) AND &
					 ( fatdiari.fact_no_pedido  Like '%NC%')"

//if w_fa_fondo.str_para.mostrar <> 0 then  //mostrar un Año específico
//	CHOOSE CASE w_fa_fondo.str_para.desde
//		CASE 0
			ls_where = ls_where + " AND (fatdiari.fact_ann = "+string(ii_ann)+")"
//		CASE 1
//			ls_where = ls_where + " AND (fatdiari.fact_ann >= "+string(w_fa_fondo.str_para.mostrar)+")"
//	END CHOOSE
//end if

chdw_dev_pedido.SetSQLSelect(ls_where)		//Setea el SQL al Child de Pedidos

if chdw_dev_pedido.Retrieve(str.g_financiero, str.empresa) < 1 then
	chdw_dev_pedido.Scrolltorow(chdw_dev_pedido.insertrow(0))
end if

//Tipos de Facturas
/*Comentado por HGN/06/02/2003 provocaba que se seteara descrip al pedido*/
//If dwc_tipo_fac.Retrieve(str.g_financiero, str.empresa,'FA') < 1 Then  dwc_tipo_fac.Insertrow(0)
//dwc_tipo_fac.Scrolltorow(1)
is_tipo_fac = dwc_tipo_fac.GetItemString(1,"dgmsubse_subs_sub_trans")


end subroutine

public function integer wf_act_cargos ();//Funcion que actualiza el detalle de los cargos
integer li_exist, li_linea, li_ok
string  ls_descrip, ls_concepto
long    ll_factura
decimal  ld_monto

//Función que Verifica si hay detalle
	str.frame.setmicrohelp("Actualizando cargos...") 
	 
   SELECT count(*)  
    INTO :li_exist  
    FROM fadcargo  
   WHERE ( fadcargo.dcar_g_financiero = :str.g_financiero ) AND  
         ( fadcargo.dcar_empresa = :str.empresa ) AND  
         ( fadcargo.dcar_no_pedido = :is_pedido_nc ) AND  
         ( fadcargo.dcar_ann = :ii_ann ) AND  
         ( fadcargo.dcar_tipo = :is_tipo_fac )   ;

	if sqlca.sqlcode = -1 then
		gf_mensaje("","Error al Verificar Existencia de los cargos "+sqlca.sqlerrtext,1,1,"E")
	end if

 If li_exist > 0 Then

	  ld_monto = dw_1.getitemNumber(dw_1.getrow(),"fact_monto_final")
	  /*Valida si el monto es cero, debe borrarse detalle de gastos*/
	  if ld_monto = 0 then
		
			delete from indgasto  
  			 where  ( gast_g_financiero = :str.g_financiero)  and 
				     ( gast_empresa      =  :str.empresa) and 
					  ( gast_aplicacion   =  :str.aplicacion) and 
					  ( gast_transaccion  =  "DV" ) and
					  ( gast_concepto     =  :ls_concepto ) and 
			        ( gast_secuencia    =  :ll_factura ) and 
					  ( gast_ann          =  :ii_ann ) ; 
			
			li_ok = sqlca.sqlcode			  
					
			IF SQLCA.SQLCODE = -1 THEN 
				messagebox("Error al eliminar los gastos (indgastos) :",sqlca.sqlerrtext)
				ROLLBACK USING SQLCA;
				return -1
		   END IF

			delete FROM fadcargo 
			WHERE ( fadcargo.dcar_g_financiero = :str.g_financiero ) AND  
					( fadcargo.dcar_empresa = :str.empresa ) AND  
					( fadcargo.dcar_no_pedido = :is_pedido_nc ) AND  
					( fadcargo.dcar_ann = :ii_ann ) AND  
					( fadcargo.dcar_tipo = :is_tipo_fac )   ;
			li_ok = sqlca.sqlcode			  
					
			IF SQLCA.SQLCODE = -1 THEN 
				messagebox("Error al eliminar los cargos (fadcargo) :",sqlca.sqlerrtext)
				ROLLBACK USING SQLCA;
				return -1
		   END IF
		
	  end if
	
	  ll_factura = long(dw_1.getitemstring(dw_1.getrow(),"fact_no_factura"))
	  ls_concepto = is_tipo_fac
			
	  DECLARE cursor_gas CURSOR FOR  
	  SELECT faacargo.carg_descripcion,   
				fadcargo.dcar_monto  
		 FROM fadcargo,   
				faacargo  
		WHERE ( fadcargo.dcar_codigo = faacargo.carg_cargo ) and  
				( ( fadcargo.dcar_g_financiero =:str.g_financiero  ) AND  
				( fadcargo.dcar_empresa = :str.empresa ) AND  
				( fadcargo.dcar_no_pedido = :is_pedido_nc  ) AND  
				( fadcargo.dcar_ann = :ii_ann  ) AND  
				( fadcargo.dcar_tipo = :is_tipo_fac ) )   ;
				
		if sqlca.sqlcode = -1 then
				mensaje("Información(wf_act_cargos)","Error al Seleccionar en fadcargo y en faacargo",sqlca.sqlerrtext)
				return -1
		end if			
				
		OPEN cursor_gas;
		
		li_ok = sqlca.sqlcode
		
		FETCH cursor_gas INTO :ls_descrip, :ld_monto;				
					

		IF SQLCA.SQLCODE = -1 THEN
			MESSAGEBOX("ATENCION SR. USUARIO.","ERROR EN LA ACTUALIZACIÓN")
			CLOSE cursor_gas;
			RETURN -1
		END IF	
		
		DO WHILE SQLCA.SQLCODE = 0
			
			li_linea = li_linea + 1
			
			update indgasto  
          set    gast_g_financiero =  :str.g_financiero,   
					  gast_empresa      =  :str.empresa,   
					  gast_aplicacion   =  :str.aplicacion,   
					  gast_transaccion  =  "DV",   
					  gast_concepto     =  :ls_concepto,
					  gast_secuencia    =  :ll_factura,   
					  gast_linea        =  :li_linea,   
					  gast_ann          =  :ii_ann,
					  gast_descripcion  =  :ls_descrip,   
					  gast_valor        =  :ld_monto    
  			 where  ( gast_g_financiero = :str.g_financiero)  and 
				     ( gast_empresa      =  :str.empresa) and 
					  ( gast_aplicacion   =  :str.aplicacion) and 
					  ( gast_transaccion  =  "DV" ) and
					  ( gast_concepto     =  :ls_concepto ) and 
			        ( gast_secuencia    =  :ll_factura ) and 
					  ( gast_linea        =  :li_linea ) and  
					  ( gast_ann          =  :ii_ann ) ; 
			
			li_ok = sqlca.sqlcode			  
					
			IF SQLCA.SQLCODE = -1 THEN 
				messagebox("Error al actualizar los cargos :",sqlca.sqlerrtext)
				ROLLBACK USING SQLCA;
				exit
		   END IF
		 
		FETCH cursor_gas INTO :ls_descrip, :ld_monto;
			if sqlca.sqlcode = -1 then
				gf_mensaje("","Error en el Fetch "+sqlca.sqlerrtext,1,1,"E")
				exit
			end if
      LOOP

	CLOSE cursor_gas;

end if
str.frame.setmicrohelp("")
return li_ok

end function

public function integer wf_act_detalle (datawindow ldw_2);//Ciclo For que recorre el DWindow 2 para actualizar en el Detalle de actualizaciones
str.frame.setmicrohelp("Actualizando el Detalle en Inventario...")
integer li_recorrido,  li_linea, li_ok,&
		  li_fraccion,li_anio
string  ls_documento, ls_producto, ls_unidad_med, ls_movid,&
		  ls_fabricante, ls_secuencia, ls_codigo, ls_bodega, ls_ubicacion, ls_bodega_des,&
		  ls_ubica_des, ls_concepto,ls_err
decimal  ld_peso, ld_precio, ld_cubicaje, ld_bulto, ld_cargos, ld_precio_ent
long    li_cantidad, li_cant1, ll_secuencia,ll_err

ls_secuencia  = dw_1.getitemstring(1,"fact_no_factura")
ll_secuencia  = il_secuencia //Se carga al actualizar el encabezado
ls_documento  = dw_1.getitemstring(1,"fact_no_factura")
li_anio		  = dw_1.getitemNumber(1,"fact_ann")

	  DELETE FROM indmovim  
		 WHERE ( indmovim.dmov_g_financiero = :str.g_financiero ) AND  
				( indmovim.dmov_empresa = :str.empresa) AND  
				( indmovim.dmov_aplicacion = :str.aplicacion ) AND  
				( indmovim.dmov_tipo_transaccion = 'DV') AND  
				( indmovim.dmov_documento = :ls_documento ) AND  
				( indmovim.dmov_concepto = 'DV' ) AND  
				( indmovim.dmov_anual = :li_anio ) and 
				( indmovim.dmov_secuencia = :il_secuencia );

			if sqlca.sqlcode = -1 then
				ll_err = sqlca.sqlcode
				ls_err = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso", "Error al borrar el detalle (indmovim)",ls_err)
			end if

for li_recorrido = 1 to ldw_2.rowcount()
	ls_codigo = ldw_2.getitemstring(li_recorrido,"facd_codigo_item")

	 if trim(ls_codigo) <> "" then
		// Asignacion de los datos del DWin. a las variables de memoria
		//Ya no es NC porque en inventario, se hace referencia a dgmseries y NC es tipo Credito, para
		//CxC y en Inventario debe ser Debito, así que se creo otra transaccion con naturaleza "Debito"
		//ls_tipo_tran  = "DV"			//Nota de credito (DEVOLUCION)

		ls_bodega	  = ldw_2.getitemString(li_recorrido,"facd_bodega")
		ls_ubicacion  = ldw_2.getitemString(li_recorrido,"facd_ubicacion")
		ls_producto	  = ldw_2.getitemstring(li_recorrido,"facd_codigo_item")
		li_cantidad   = ldw_2.getitemnumber(li_recorrido,"facd_cantidad")
		li_fraccion	  = ldw_2.getitemnumber(li_recorrido,"facd_cantidad_fraccion")	//Sumar a Cantidad	
		ls_unidad_med = ldw_2.getitemstring(li_recorrido,"facd_unidad_venta")
		ld_precio	  = ldw_2.getitemnumber(li_recorrido,"facd_precio_unidad_producto")
		ld_cubicaje   = ldw_2.getitemnumber(li_recorrido,"facd_cubicaje")
		ld_peso		  = ldw_2.getitemnumber(li_recorrido,"facd_peso")
		ld_bulto		  = ldw_2.getitemnumber(li_recorrido,"facd_bultos")
		li_linea		  = ldw_2.getitemnumber(li_recorrido,"facd_linea")
		ls_movid		  = str.usuario
		ls_concepto	  = is_tipo_fac
	
	
		insert into indmovim  
				  ( dmov_g_financiero ,       
				  dmov_empresa       ,           
				  dmov_aplicacion    ,    
				  dmov_tipo_transaccion   ,   
				  dmov_concepto,		  
				  dmov_secuencia        ,    
				  dmov_anual,
				  dmov_linea          ,   
				  dmov_documento        ,   
				  dmov_bodega           ,    
				  dmov_ubicacion         ,   
				  dmov_producto  ,    
				  dmov_cantidad,   
				  dmov_cant1 ,   
				  dmov_unidad_medida ,   
				  dmov_precio  ,   
				  dmov_cubicaje ,   
				  dmov_peso ,   
				  dmov_bulto,   
				  dmov_id)
			 values (  :str.g_financiero, 
						 :str.empresa,       
						 :str.aplicacion,
						 'DV',
						 'DV'	,
						 :il_secuencia, 
						 :li_anio,
						 :li_linea, 
						 :ls_documento, 
						 :ls_bodega,
						 :ls_ubicacion,
						 :ls_producto,
						 :li_cantidad,
						 :li_fraccion,
						 :ls_unidad_med,
						 :ld_precio,
						 :ld_cubicaje,
						 :ld_peso,
						 :ld_bulto,
						 :ls_movid);
	end if
 next	

if sqlca.sqlcode = -1 then
	messagebox("ATENCIÓN SR. USUARIO","Error al actualizar detalle indmovim : "+sqlca.sqlerrtext)
end if
str.frame.setmicrohelp("")
return sqlca.sqlcode

end function

public function integer wf_act_encabezado (datawindow ldw_1, long row);//Funcion que inserta el encabezado de la factura activa, al detalle de actualizaciones
//de inventario
//Declaracion de variables de memoria
str.frame.setmicrohelp("Actualizando el Encabezado en inventario...")

integer  li_anual,ll_existe
long     ll_cliente,  ll_secuencia,ll_sec_origen,ll_err
string   ls_documento, ls_comen, ls_concepto, ls_fabricante,&
			ls_secuencia,ls_err, ls_pedido
datetime ldt_fecha
decimal   ld_costo, ld_peso, ld_precio, ld_cubicaje, ld_final, ld_cargos, ld_monto

string ls_nombre, ls_existe_sec= ''
//Cargar los datos en las variables
ls_documento = ldw_1.getitemstring(row,"fact_no_factura")
ls_secuencia = ldw_1.getitemstring(row,"fact_no_factura")
ll_secuencia = long(ls_secuencia)
ldt_fecha	 = ldw_1.getitemdatetime(row,"fact_fecha")
ll_cliente   = ldw_1.getitemnumber(row,"fact_cliente")
ls_nombre	 =	ldw_1.getitemstring(row,"fact_a_nombre")
ls_comen		 =	"Nota de Credito # "+ls_secuencia+"/P-"+is_pedido_nc+" a "+ls_nombre
ld_final     = ldw_1.getitemnumber(row,"fact_monto_final")
ld_monto 	 = ldw_1.getitemnumber(row,"fact_monto_fact_total")
ld_cargos	 = ldw_1.getitemnumber(row,"fact_gastos_total")
li_anual		 = ldw_1.getitemnumber(row,"fact_ann")
ls_pedido    = ldw_1.getitemstring(row,"fact_no_pedido")
ls_concepto  = is_tipo_fac
time lt_time
lt_time = time(gf_fecha_serv())
ldt_fecha = datetime(date(ldt_fecha),lt_time)

//si la secuencia devuelve 0, porque tiene letras la factura, que busque la secuencia de la transaccion
//de salidas de inventario
/**/
SELECT intmovim.tmov_secuencia
Into :ll_secuencia
from intmovim
WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
	( intmovim.tmov_empresa = :str.empresa ) AND  
	( intmovim.tmov_aplicacion = :str.aplicacion ) AND  
	( intmovim.tmov_tipo_transaccion = 'DV' ) AND  
	( intmovim.tmov_documento = :ls_documento ) AND  
	( intmovim.tmov_anual = :li_anual ) and
	( intmovim.tmov_concepto = 'DV' );	

if sqlca.sqlcode = -1 then
	ll_err = sqlca.sqlcode
	ls_err = sqlca.sqlerrtext
	rollback;
	messagebox('Error No. '+string(ll_err),'Error al seleccinar la secuencia en intmovim '+ls_err)
	RETURN ll_err
end if

If sqlca.sqlcode = 100 then	// No existe encabezado

  SELECT dgmserie.mser_secuencia
	 INTO :il_secuencia
	 FROM dgmserie  
	WHERE ( dgmserie.mser_g_financiero = :str.g_financiero ) AND  
			( dgmserie.mser_empresa = :str.empresa ) AND  
			( dgmserie.mser_tipo_transaccion = 'DV' );
			
			if sqlca.sqlcode = -1 then
				ll_err = sqlca.sqlcode
				ls_err = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso", "Error al Leer la Secuencia en dgmserie",ls_err)
				return ll_err
			end if
			
			il_secuencia ++
	DO
			SELECT count(*)
			Into :ll_existe
			from intmovim
			WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
				( intmovim.tmov_empresa = :str.empresa ) AND  
				( intmovim.tmov_aplicacion = :str.aplicacion ) AND  
				( intmovim.tmov_tipo_transaccion = 'DV' ) AND  
	         ( intmovim.tmov_secuencia = :il_secuencia) AND  
				( intmovim.tmov_anual = :li_anual ) and
				( intmovim.tmov_documento = :ls_documento ) AND  
				( intmovim.tmov_concepto = 'DV' );	
				
				if ll_existe <> 0 then il_secuencia ++
				
	LOOP UNTIL ll_existe =0
			
			
  UPDATE dgmserie  
  SET mser_secuencia = :il_secuencia  
	WHERE ( dgmserie.mser_g_financiero = :str.g_financiero ) AND  
			( dgmserie.mser_empresa = :str.empresa ) AND  
			( dgmserie.mser_tipo_transaccion = 'DV' )   ;
			
	if sqlca.sqlcode = -1 then
		ll_err = sqlca.sqlcode
		ls_err = sqlca.sqlerrtext
		rollback;
		messagebox('Error No. '+string(ll_err),'Error al seleccinar la secuencia en dgmserie '+ls_err)
		Return ll_err
	else
		ll_secuencia = il_secuencia
		ls_existe_sec = '1'
	end if	
else
	il_secuencia = ll_secuencia
	ls_existe_sec = ''
end if

if ls_existe_sec = ''  then	//Existe encabezado actualiza

	//Actualiza en intmovim
	/*Se procede a actualizar el encabezado de Intmovim*/
    UPDATE intmovim  
     SET   tmov_autoriza = :str.usuario,
           tmov_documento = :ls_documento,   
           tmov_terceros = :ll_cliente ,   
           tmov_comentario = :ls_comen,
           tmov_id  =  :str.usuario,   
			  tmov_tipo = "D",
			  tmov_fecha =:ldt_fecha,
			  tmov_nombre_tercero = :ls_nombre
		   WHERE (intmovim.tmov_g_financiero = :str.g_financiero) and 
			      ( intmovim.tmov_empresa = :str.empresa ) AND  
               ( intmovim.tmov_aplicacion = :str.aplicacion ) AND  
               ( intmovim.tmov_tipo_transaccion = 'DV' ) AND  
		         ( intmovim.tmov_secuencia = :il_secuencia) AND  
               ( intmovim.tmov_documento = :ls_documento ) AND  
					( intmovim.tmov_concepto = 'DV' ) and 
		         ( intmovim.tmov_anual = :li_anual ) ;

	if sqlca.sqlcode = -1 then
		ll_err = sqlca.sqlcode
		ls_err = sqlca.sqlerrtext
		rollback;
		messagebox('Atención','Error al actualizar el encabezado de la Devolución intmovim '+ls_err)
		return ll_err
	end if
else	//Insertar encabezado
	
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
           tmov_fecha_registro,   
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
           tmov_marca )  
  VALUES ( :str.g_financiero,   
           :str.empresa,   
           :str.aplicacion,   
           'DV',   
           :il_secuencia,   
           'DV',   
           :li_anual,   
           '',   
           :ldt_fecha,   
           :str.usuario,   
           :ls_documento,   
           :ldt_fecha,   
           :ll_cliente,   
           :ls_comen,   
           '',   
           :str.usuario,   
           'D',   
           1,   
           0,   
           0,	//total cargos   
           Null,   
           Null,   
           Null,   
           Null,   
           Null,   
           Null,   
           Null,   
           Null,   
           :ls_nombre,   
           Null,  //pase
           Null,  //moneda
           Null,  //cambio
           1,		//constante
           0,   	//descuento
           1,   //tipo gasto
           0,  	//por admin
           :ls_pedido,   	//pedido
           0,   	//precio
           0,   	//pasad a empresa
           Null,   		//rebaja reserva
           Null )  ;	//marca
/**/			  
	if sqlca.sqlcode = -1 then
		ll_err = sqlca.sqlcode
		ls_err = sqlca.sqlerrtext
		rollback;
		messagebox('Atención','Error al Insertar el encabezado de la Devolución intmovim '+ls_err)
		return ll_err
	end if
end if
  

return sqlca.sqlcode

end function

public subroutine wf_act_mayor (string ls_numero);//Actualiza la secuencia de las facturas al por mayor en parámetros 
//Localiza según los parametros iniciales (faaparam) la secuencia correspondiente
string ls_tipo_mayor
integer li_existe
	str.frame.setmicrohelp("Actualizando secuencia...")

  SELECT faaparam.fara_por_mayor  
    INTO :ls_tipo_mayor
    FROM faaparam  
   WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
         ( faaparam.fara_empresa = :str.empresa )   ;	
			
		if sqlca.sqlcode = -1 then
			mensaje("Información(wf_act_mayor)","Error al Seleccionar registros en faaparam",sqlca.sqlerrtext)
			return
		end if				

 CHOOSE CASE ls_tipo_mayor
	CASE "GT"
		 
   UPDATE faaparam  
   SET fara_ult_fact_mayor = :ls_numero  
   WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
         ( faaparam.fara_empresa = :str.empresa )   ;	 
 		 
	CASE "GL"

	   UPDATE faaparam  
   	SET fara_ult_ultima_factura = :ls_numero  
	   WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
            ( faaparam.fara_empresa = :str.empresa )   ;	 		 
		 
	CASE ELSE
		// abrir ventana para seleccionar la secuencia de la caja , filtrar por tipo = caja
		SELECT count(*)
   	  INTO :li_existe
	     FROM famcajap
   	 WHERE ( famcajap.faca_g_financiero = :str.g_financiero ) AND  
      	    ( famcajap.faca_empresa = :str.empresa ) AND
				 ( famcajap.faca_venta = "PY" ); 
				
		if sqlca.sqlcode = -1 then
			mensaje("Información(wf_act_mayor)","Error al Seleccionar la cantidad de registros en famcajap",sqlca.sqlerrtext)
			return
		end if					
			
		if li_existe > 0 then
		//	OpenWithParm(w_fa_man_fac_Sec,"PY")
		  UPDATE famcajap  
	     SET faca_secuencia = :ls_numero  
   	  WHERE ( famcajap.faca_g_financiero = :str.g_financiero ) AND  
        		  ( famcajap.faca_empresa = :str.empresa ) AND  
		        ( famcajap.faca_venta = "PY" );

	 	else
			messagebox("ATENCIÓN SR. USUARIO","Verifique la Secuencia al por mayor en Cajas",Exclamation!)
		end if
		
 END CHOOSE
 
  if sqlca.sqlcode = -1 then
	messagebox("ATENCIÓN SR. USUARIO","Error al actualizar la secuencia, Verifique. : "+sqlca.sqlerrtext)
	rollback ;
 else
	commit ;
	
	str.frame.setmicrohelp("Actualizando secuencia...")
	timer(2)
	str.frame.setmicrohelp("")
 end if

str.frame.setmicrohelp("")
return

end subroutine

public subroutine wf_act_sec_facturas (string ls_factura, string ls_pedido, ref boolean ab_act_secuencia);//Función que actualiza la tabla de parámetros, secuencias de facturas
//Dependiendo de el tipo de secuencia que se maneje.
string ls_tipo_venta, lsqlerrtext
integer li_fac_igual_pedido, li_sec_fac_nc
Boolean	ab_act_devol
ab_act_devol = False

ls_tipo_venta = w_fa_fondo.str_para.tipo
li_fac_igual_pedido = w_fa_fondo.str_para.fac_igual_ped

//Asigna el tipo de secuencia que utiliza el cliente, de facturas o de NC de CxC
li_sec_fac_nc = w_fa_fondo.str_para.nc_o_fac

if li_sec_fac_nc = 1 then //Si selecciona secuencias de facturas.
	if li_fac_igual_pedido = 1	then	//Si son iguales las secuencias de pedidos a las de facturas
												//lo pongo de solo lectura y le seteo el numero de pedido a la factura	
		ls_factura = is_pedido
	end if
	// Si no son iguales
	// Actualizo la secuencia de factura
	UPDATE faaparam  
		SET fara_ult_ultima_factura = :ls_factura 
		WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
				( faaparam.fara_empresa = :str.empresa )   ;	 
				
	if sqlca.sqlcode = -1 then
		lsqlerrtext = sqlca.sqlerrtext
		messagebox("ATENCIÓN SR. USUARIO","Error al actualizar la secuencia, Verifique. : "+lsqlerrtext)
		ab_act_secuencia = False
		Return
	end if	
else	//Si es secuencia de devoluciones.
	wf_actualiza_devol(ls_factura,ab_act_devol)	  //Actualiza secuencias de devoluciones
	If ab_act_devol = False Then 
		ab_act_secuencia = False
		Return
	End If
end if	
ab_act_secuencia = True

end subroutine

public function integer wf_actualiza_cliente ();//Variables de Memoria
long 		ll_cliente
string  	ls_documento, ls_ruc_cliente, ls_subt, ls_comentario, ls_referencia
double  	ld_monto
datetime ldt_fecha, ldt_fechareg

//Cargar los valores a variables
ls_documento	=	dw_1.getitemstring(dw_1.getrow(),"fact_no_factura")
ls_referencia	=	dw_1.getitemstring(dw_1.getrow(),"fact_no_pedido")
ll_cliente		=	dw_1.getitemnumber(dw_1.getrow(),"fact_cliente")
ls_ruc_cliente =  dw_1.getitemstring(dw_1.getrow(),"fact_ruc_cliente")
ldt_fecha	   =  dw_1.getitemdatetime(dw_1.getrow(),"fact_fecha")
ldt_fechareg	=	gf_fecha_serv()
ld_monto			=	dw_1.getitemnumber(dw_1.getrow(),"fact_monto_final")
ld_monto			=  truncate( round (ld_monto, 2), 2)
ls_subt			=	is_tipo_fac
ls_comentario	=	'DEVOLUCION DE MERCANCIA'//dw_1.getitemstring(dw_1.getrow(),"fact_comentario")

//Para recuperar la cantidad de dias para pagar la factura
if ld_monto =0 then  //Eliminar registro
delete from cctmovim
	WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
         ( cctmovim.movi_empresa = :str.empresa ) AND 
		   ( cctmovim.movi_aplicacion  = :str.aplicacion ) AND 
         ( cctmovim.movi_tipo_transaccion =  'NC' ) AND  
         ( cctmovim.movi_sub_transaccion = '2' ) AND  
         ( cctmovim.movi_documento = :ls_documento ) AND  
         ( cctmovim.movi_anno = :ii_ann ) AND  
         ( cctmovim.movi_referencia = :ls_referencia)   ;

		if sqlca.sqlcode = -1 then
			messagebox("Atención ",'Se ha producido un eror al eliminar Ncr con monto 0 '+sqlca.sqlerrtext)
		end if	

	return sqlca.sqlcode
end if

update cctmovim  
set  movi_g_financiero      = :str.g_financiero,   
     movi_empresa           = :str.empresa,   
     movi_aplicacion        = :str.aplicacion,   
     movi_tipo_transaccion  = 'NC',   
     movi_documento         = :ls_documento,   
	  movi_anno			       = :ii_ann, 
	  movi_referencia        = :ls_referencia,
	  movi_sub_transaccion   = '2',   			  
     movi_tercero           = :ll_cliente ,   
	  movi_ruc_tercero       = :ls_ruc_cliente,   			  
     movi_naturaleza        = 'C',   
     movi_monto             = :ld_monto,   
     movi_fecha_tran        = :ldt_fecha,   
     movi_usuario           = :str.usuario,
	  movi_estado            = 'IM',
	  movi_estado_pase_conta =   'S'
	WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
         ( cctmovim.movi_empresa = :str.empresa ) AND 
		   ( cctmovim.movi_aplicacion  = :str.aplicacion ) AND 
         ( cctmovim.movi_tipo_transaccion =  'NC' ) AND  
         ( cctmovim.movi_sub_transaccion = '2' ) AND  
         ( cctmovim.movi_documento = :ls_documento ) AND  
         ( cctmovim.movi_anno = :ii_ann ) AND  
         ( cctmovim.movi_referencia = :ls_referencia)   ;
                               
			  
if sqlca.sqlerrtext <> "" then
	messagebox("Mensaje de Error en cliente",sqlca.sqlerrtext)
end if	
return sqlca.sqlcode
end function

public subroutine wf_actualiza_devol (string ls_numero, ref boolean ab_act_devol);//Función que actualiza la secuencia de devoluciones
  UPDATE faaparam  
     SET fara_ult_devolucion = :ls_numero  
   WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
         ( faaparam.fara_empresa = :str.empresa )   ;

if sqlca.sqlcode = -1 then
	messagebox("ATENCIÓN SR. USUARIO","Error al Actualizar la Secuencia "+" ~n "+ sqlca.sqlerrtext, Exclamation!)
	ab_act_devol = False
Else
	ab_act_devol = True
end if
end subroutine

public function integer wf_actualiza_inventario (datawindow ldw_1, long row);// Funcion que actualiza los datos de inventario
// Declaracion de variables de memoria
integer li_ok
If  dw_2.rowcount() <=  0  Then
	 dw_2.retrieve(str.g_financiero, str.empresa, is_tipo_fac,is_pedido_nc, ii_ann) //, is_tipo_fac)
end if

//Inserta la información de el encabezado al Encabezado de Actualizaciones en Inventario
li_ok = wf_act_encabezado(ldw_1, row)				//Actualiza el Encabezado

if li_ok = 0 then
	
	li_ok = wf_act_cargos()					//Actualiza los Cargos
	if li_ok = 0 or li_ok = 100 then		//Si estubo bien o no encontro cargos
			li_ok = wf_act_detalle(dw_2)		//Actualiza el Detalle
			if li_ok = 0 then
				commit;
			else
				if sqlca.sqlerrtext <> "" then
					messagebox("ATENCIÓN SR. USUARIO","Error "+sqlca.sqlerrtext,Exclamation!)
				end if				
				messagebox("ATENCIÓN SR. USUARIO","Error al Actualizar Inventario (Detalle). Verifique")
				rollback;				
			end if
	else
		messagebox("ATENCIÓN SR. USUARIO","Error al Actualizar Inventario (cargos). Verifique")
		rollback;
		if sqlca.sqlerrtext <> "" then
			messagebox("ATENCIÓN SR. USUARIO","Error "+sqlca.sqlerrtext,Exclamation!)
		end if		
	end if
	
else
	messagebox("ATENCIÓN SR. USUARIO","Error al Actualizar Inventario (encabezado). Verifique")
	rollback;
	if sqlca.sqlerrtext <> "" then
		messagebox("ATENCIÓN SR. USUARIO","Error "+sqlca.sqlerrtext,Exclamation!)
	end if
end if

return li_ok
end function

public function string wf_asigna_pedido (string pedido);integer li_existe, li_contador = 0
string ls_pedido

ls_pedido = pedido + "NC"

do 
	li_contador = li_contador + 1
	
	if li_contador > 1 then
		ls_pedido = pedido + "NC" + string(li_contador)
	end if
	
	SELECT count(*)
   INTO :li_existe
   FROM fatdiari
   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND
         ( fatdiari.fact_empresa = :str.empresa ) AND
         ( fatdiari.fact_tipo = :is_tipo_fac ) AND
         ( fatdiari.fact_no_pedido = :ls_pedido ) AND
         ( fatdiari.fact_ann = :ii_ann ) ;
			
		if sqlca.sqlcode = -1 then
			mensaje("Información","Error al Seleccionar la cantidad de registros en fadpecar",sqlca.sqlerrtext)
			return ''
		end if			
			
	if li_existe > 0 then
		messagebox("ATENCIÓN SR. USUARIO","Ya existe una devolución para este pedido..",Exclamation!)	
	end if
	
loop until li_existe = 0

return(ls_pedido)
end function

public subroutine wf_blanquea_totales ();//Blanquea los totales de la devolucion
 em_total.text = "0" 
 em_final.text = "0"
 em_cargos.text = "0"

end subroutine

public subroutine wf_busca_detalle ();// Función que busca el detalle de la factura llamada en el encabezado.
string  ls_pedido, ls_codigo
double  ld_total, ld_suma, ld_cargos 
long    ll_recorrido,ll_cantidad, ll_fraccion, ll_devuelta, ll_total
long 	  ll_recuperados, ll_ucom, ll_linea
string  ls_unian, ls_unidad_prod, ls_unidad_venta
long    ll_mconvera, ll_mconverb, ll_cant_x_linea
double  ld_precio, ld_descuento, ld_monto


If trim(is_pedido) <> "0" Then
 //Recupera en el DataStore
 ll_recuperados = ids_deta.Retrieve(str.g_financiero, str.empresa,is_tipo_fac, is_pedido, ii_ann) //, is_tipo_fac)

 
 if ll_recuperados > 0 then
	ls_pedido = ids_deta.Getitemstring(ids_deta.getrow(),"facd_no_pedido")
	//Mueve al DW_2

	for ll_recorrido = 1 to ids_deta.rowcount()
		
		ls_unian        = ids_deta.GetItemString(ll_recorrido,"facd_unidad_venta")
		ls_unidad_prod  = ids_deta.GetItemString(ll_recorrido,"facd_unidad_producto")
		ls_unidad_venta = ids_deta.GetItemString(ll_recorrido,"facd_unidad_venta")
		ll_cantidad     = ids_deta.GetItemNumber(ll_recorrido,"facd_cantidad")
		ll_fraccion     = ids_deta.GetItemNumber(ll_recorrido,"facd_cantidad_fraccion") 
  		ll_linea		    = ids_deta.Getitemnumber(ll_recorrido,"facd_linea")
		
	   //Tipo de medida de la unidad del producto	(UNIDADES, UNIDAD DE PESO, CONVERSIONES, ETC)
	   // Devuleve 10 en caso de que sea una medida
		ll_ucom = gf_medi_prod(ls_unidad_prod)
  
		//Carga Los Datos de Converción de la Unidad Actual		
		ll_mconvera = gf_unidad_venta(ls_unidad_venta, ll_ucom)
		
		ll_cant_x_linea = ll_mconvera * ll_cantidad + ll_fraccion   //Cantidad a pedir
		
		ll_devuelta = ids_deta.getitemnumber(ll_recorrido,"facd_cant_devuelta")
		
//		messagebox("Cant. por Linea ",ld_cant_x_linea)
 		ids_deta.setitem(ll_recorrido,"facd_cant_devuelta",ll_cant_x_linea)
		ids_deta.setitem(ll_recorrido,"total",ll_cant_x_linea)
 		ids_deta.Setitem(ll_recorrido,"facd_no_pedido",is_pedido_nc)
		ids_deta.Setitem(ll_recorrido,"facd_pedido_original",ls_pedido)
		ids_deta.Setitem(ll_recorrido,"linea",ll_linea)
		ids_deta.Setitem(ll_recorrido,"facd_linea_articulo_dev",ll_linea)
		ids_deta.Setitem(ll_recorrido,"facd_ann",w_fa_fondo.str_para.ano)		
		//setea al campo que protege el precio
		ids_deta.Setitem(ll_recorrido,"mod_precio",il_modifica)

		if ll_cant_x_linea - ll_devuelta = 0 then			
			ls_codigo = ids_deta.getitemstring(ll_recorrido,"facd_codigo_item")
			messagebox("ATENCIÓN SR. USUARIO","El artículo " + ls_codigo + "  " + "fue devuelto en su totalidad, devuelva Parcialmente")
			return
		else
			ids_deta.rowscopy(ll_recorrido,ll_recorrido,Primary!,dw_2,1000,primary!)
		end if
		
		//100 para que lo ponga al final
	end for
  end if
		
	//cantidad y fraccion a solo lectura
	dw_2.Modify("facd_cantidad.Edit.DisplayOnly=yes")
	dw_2.Modify("facd_cantidad_fraccion.Edit.DisplayOnly=yes")

Else
	
	dw_2.Reset()
	dw_2.scrolltorow(dw_2.insertrow(0))
	//Para poder modificar las cantidades
	dw_2.Modify("facd_cantidad.Edit.DisplayOnly=no")
	dw_2.Modify("facd_cantidad_fraccion.Edit.DisplayOnly=no")

End If
end subroutine

public subroutine wf_busca_secuencia (ref string as_no_factura);Long		ll_max
Integer	li_existe
string 	ls_max

SELECT faaparam.fara_ult_ultima_factura
INTO :ls_max  
FROM faaparam  
WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
	 ( faaparam.fara_empresa = :str.empresa )   ;
ll_max = long(ls_max)

DO	
	ll_max = ll_max + 1

	ls_max = string(ll_max)

  SELECT count(*)
    INTO :li_existe  
    FROM fatdiari  
   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND
         ( fatdiari.fact_empresa = :str.empresa ) AND
         ( fatdiari.fact_tipo = :is_tipo_fac ) AND
			( fatdiari.fact_ann = :ii_ann ) AND
         ( fatdiari.fact_no_factura = :ls_max );

LOOP UNTIL li_existe = 0
as_no_factura = ls_max
end subroutine

public function double wf_calcula_cargos (datawindow ldw_2, double ld_monto_total, integer li_bultos);//Calcula los cargos para las devoluciones
//llamada desde wf_totaliza()
Integer li_cargo,li_booleana,li_recorrido
string ls_sobre,ls_cargo
double ld_var, ld_monto, ld_valor
long	 ll_recupero
//, ld_monto_total

//blanquea los cargos del dw_4
dw_4.reset()

//Recupera los datos por medio del DataStore
//messagebox("pedido",is_pedido)
ll_recupero = ids_cargos.Retrieve(str.g_financiero,str.empresa,is_tipo_fac,is_pedido,ii_ann) //,is_tipo_fac)

//Filtra por los que no se devuelven
ids_cargos.Setfilter("carg_se_devuelve <> 0")
ids_cargos.Filter()


//if ldw_2.rowcount() = 1 and ldw_2.Getitemstring(1, "facd_codigo_item") = "" &
//	or isnull(ldw_2.Getitemstring(1, "facd_codigo_item") )then return 0

//Recupera el monto total de las facturas
if ids_cargos.rowcount() <= 0 then return 0

FOR li_recorrido = 1 TO ids_cargos.rowcount()
 
	ld_valor = ids_cargos.getitemnumber(li_recorrido,"dcar_monto")

	ld_monto = ld_monto + ld_valor
	
	//Setea el número de pedido al Data Store de cargos
	ids_cargos.Setitem(li_recorrido,"dcar_no_pedido", is_pedido_nc)
	//Setea el año de parámetros
	ids_cargos.Setitem(li_recorrido,"dcar_ann",w_fa_fondo.str_para.ano)
	
	//Copia el registro al dw 4, cargos de devolucion.
	ids_cargos.Rowscopy(li_recorrido, li_recorrido, primary!, dw_4, 100, primary!)
	
END FOR

Return ld_monto
end function

public subroutine wf_calcula_comisiones (double ad_monto, string as_tipo, integer ai_venta);//Función que Calcula las Comisiones de los Vendedores
integer li_vendedor, li_total
double  ld_comision,  ld_porciento
string  ls_sub_tran

//Asigno el tipo de la Factura a el Tipo de la Subtransaccion, que es Varchar(3)
ls_sub_tran = is_tipo_fac

//Asigno el tipo de Venta Correspondiente, Según los codigos de comisiones
	choose case as_tipo
		case "CR"
			as_tipo = "CRE"
		case "CO"	
			as_tipo = "CON"
	end choose

//Consulto el Total de Vendedores que tiene una factura
  SELECT count(*)  
    INTO :li_total  
    FROM fadvenfa  
   WHERE ( fadvenfa.vfac_g_financiero = :str.g_financiero ) AND  
         ( fadvenfa.vfac_empresa = :str.empresa ) AND  
         ( fadvenfa.vfac_tipo = :is_tipo_fac ) AND  
         ( fadvenfa.vfac_no_pedido = :is_pedido ) AND  
         ( fadvenfa.vfac_ann = :ii_ann )   ;

	if SQLCA.sqlcode < 0 then
		MessageBox("Error al Seleccionar Total de Vendedores",SQLCA.sqlerrtext)
		return
	elseif li_total = 0 then 
		//Si no hay Vendedores Asignados, Retorna
		return
	end if

if li_total = 1 then
   //Selecciona el Vendedor	
  SELECT fadvenfa.vfac_vendedor    
    INTO :li_vendedor
    FROM fadvenfa  
   WHERE ( fadvenfa.vfac_g_financiero = :str.g_financiero ) AND  
         ( fadvenfa.vfac_empresa = :str.empresa ) AND  
         ( fadvenfa.vfac_tipo = :is_tipo_fac ) AND  
         ( fadvenfa.vfac_no_pedido = :is_pedido ) AND  
         ( fadvenfa.vfac_ann = :ii_ann )   ;
			
		if sqlca.sqlcode = -1 then
			mensaje("Información(wf_calcula_comisiones)","Error al Seleccionar el vendedor en fadvenfa",sqlca.sqlerrtext)
			return
		end if			

	//Selecciona el Porcentaje a pagar, por comision
   SELECT famcomis.comi_porcentaje  
	 INTO :ld_porciento  
	 FROM famcomis  
	WHERE ( famcomis.comi_g_financiero = :str.g_financiero ) AND  
			( famcomis.comi_empresa = :str.empresa ) AND  
			( famcomis.comi_vendedor = :li_vendedor ) AND  
			( famcomis.comi_tipo_venta = :ai_venta ) AND  	
			(( famcomis.comi_tipo_credito = 'A' and famcomis.comi_tipo_comision = :as_tipo ) OR
			(  famcomis.comi_tipo_credito is null and famcomis.comi_tipo_comision = :as_tipo ))  ;
			
		if sqlca.sqlcode = -1 then
			mensaje("Información(wf_calcula_comisiones)","Error al Seleccionar el porcentaje de comisión en famcomis",sqlca.sqlerrtext)
			return
		end if			
						
		if ld_porciento > 0 then					
				//calculo de la comision
				ld_comision = round((ld_porciento / 100) * ad_monto,2) * - 1
				
				INSERT INTO fadcoven  
						( cone_g_financiero,   
						  cone_empresa,   
						  cone_sub_tran,   
						  cone_tran,
						  cone_pedido,   
						  cone_ann,   
						  cone_recibo,   
						  cone_vendedor,   
						  cone_monto,   
						  cone_pagado )  
			   VALUES (:str.g_financiero,
						  :str.empresa,
						  :ls_sub_tran,   
						  'FA',
						  :is_pedido_nc, 
						  :ii_ann,
						  0,
						  :li_vendedor,
						  :ld_comision,
						  0 );	
	  Else
			gf_mensaje("","El Vendedor "+string(li_vendedor)+" no tiene Configurada esta Comisión",1,1,"E")
	  End if

ELSE //Para más de un vendedor	
//Declaro el Cursor para los Vendedores que fueron asignados a una Factura

 DECLARE cur_vendedores CURSOR FOR  
  SELECT fadvenfa.vfac_vendedor    
    FROM fadvenfa  
   WHERE ( fadvenfa.vfac_g_financiero = :str.g_financiero ) AND  
         ( fadvenfa.vfac_empresa = :str.empresa ) AND  
         ( fadvenfa.vfac_tipo = :is_tipo_fac ) AND  
         ( fadvenfa.vfac_no_pedido = :is_pedido ) AND  
         ( fadvenfa.vfac_ann = :ii_ann )   ;
			
		if sqlca.sqlcode = -1 then
			mensaje("Información(wf_calcula_comisiones)","Error al Seleccionar en fadvenfa",sqlca.sqlerrtext)
			return
		end if			
						
			
	Open cur_vendedores;

	if SQLCA.sqlcode < 0 then
		MessageBox("Error al Abrir el Cursor",SQLCA.sqlerrtext)
	end if

	FETCH cur_vendedores INTO :li_vendedor;
	if SQLCA.sqlcode < 0 then
		MessageBox("Error en el Fetch",SQLCA.sqlerrtext,Exclamation!)
	end if

	DO WHILE SQLCA.sqlcode = 0

	 ld_porciento = 0

			//Selecciona el Porcentaje a pagar, por comision
		   SELECT famcomis.comi_porcentaje  
			 INTO :ld_porciento  
			 FROM famcomis  
			WHERE ( famcomis.comi_g_financiero = :str.g_financiero ) AND  
					( famcomis.comi_empresa = :str.empresa ) AND  
					( famcomis.comi_vendedor = :li_vendedor ) AND  
					( famcomis.comi_tipo_venta = :ai_venta ) AND  
					(( famcomis.comi_tipo_credito = 'A' and famcomis.comi_tipo_comision = :as_tipo ) OR
					(  famcomis.comi_tipo_credito is null and famcomis.comi_tipo_comision = :as_tipo ))  ;					
					
		if sqlca.sqlcode = -1 then
			mensaje("Información(wf_calcula_comisiones)","Error al Seleccionar en famcomis",sqlca.sqlerrtext)
			return
		end if			
								
					
			if ld_porciento > 0 then					

				//calculo de la comision
				ld_comision = round((ld_porciento / 100) * ad_monto,2) / li_total * - 1
								
				INSERT INTO fadcoven  
						( cone_g_financiero,   
						  cone_empresa,   
						  cone_sub_tran,   
						  cone_tran,
						  cone_pedido,   
						  cone_ann,   
						  cone_recibo,   
						  cone_vendedor,   
						  cone_monto,   
						  cone_pagado )  
			   VALUES (:str.g_financiero,
						  :str.empresa,
						  :ls_sub_tran,   
						  'FA',
						  :is_pedido_nc, 
						  :ii_ann,
						  0,
						  :li_vendedor,
						  :ld_comision,
						  0 );
			  else
//					gf_mensaje("","El Vendedor "+string(li_vendedor)+" no tiene Configurada esta Comisión",1,1,"E")
			  end if

		FETCH cur_vendedores INTO :li_vendedor;
		
		if SQLCA.sqlcode < 0 then
			MessageBox("Error en el Fetch",SQLCA.sqlerrtext,Exclamation!)
			return
		end if

	LOOP //Fin del ciclo 
	
	//Cierro el Cursor
	CLOSE cur_vendedores;
	
	if SQLCA.sqlcode <> 0 then
		MessageBox("Error al Cerrar Cursor", SQLCA.sqlerrtext, Exclamation!)
	end if

End if //Del if de más de un Vendedor

end subroutine

public function double wf_calcula_desc (double ad_total);//Función que calcula el descuento 
double ld_desc = 0, ld_var
string ls_tipo_desc

if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 then
	ld_desc = wf_calcula_descuento_acisa()
else
	//Recupera el tipo de descuento
	ls_tipo_desc = dw_1.Getitemstring(dw_1.getrow(),"fact_descuento_subt_deta")
	
	//Si no aplica descuento, retorna
	id_desc = 0
	if ls_tipo_desc = "N" then Return 0


	//Recupera la variante
	ld_var = dw_1.GetitemNumber(dw_1.getrow(),"fact_por_descuento")
	
	 choose case ls_tipo_desc
		case "S"
			ld_desc = (ld_var / 100) * ad_total
		case "F"	
			ld_desc = ld_var
		case "D"	
			ld_desc = wf_calcula_desc_detalle(ld_var)
	 end choose
end if

 id_desc = ld_desc
 
return ld_desc
end function

public function double wf_calcula_desc_detalle (double ad_var);//Función en la que se calcula el Porcentaje de descuento, aplicado a la factura,
//Cuando se aplica al detalle
double  ld_desc = 0, ld_total, ld_maximo
integer i, li_acepta_desc
string  ls_producto

for i = 1 to dw_2.rowcount()	
	
	ls_producto = dw_2.Getitemstring(i,"facd_codigo_item")
	//Verificar si el producto, acepta descuento o no.			
	  SELECT inmprodu.prod_descuento_maximo,   
				inmprodu.prod_descuento_siono  
		 INTO :ld_maximo,   
				:li_acepta_desc  
		 FROM inmprodu  
		WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
				( inmprodu.prod_empresa = :str.empresa ) AND  
				( inmprodu.prod_producto = :ls_producto )   ;
			
	if sqlca.sqlcode = -1 then
		gf_mensaje("","Error al Seleccionar datos del Producto "+sqlca.sqlerrtext,1,1,"E")
	end if
	
	if li_acepta_desc = 0 or isnull(li_acepta_desc) then  //Si el Artículo no acepta descuento
		gf_mensaje("","El Articulo "+ls_producto+" no Acepta Descuento, Verifique..?",1,1,"E")
	else
	 if ad_var > ld_maximo then									//Si el Desc. es Mayor a lo Permitido
	   gf_mensaje("","El Descuento del producto "+ls_producto+" Sobrepaso el Límite, Verifique..?",1,1,"E")
	 else
		ld_total = dw_2.Getitemnumber(i,"facd_monto_total")	
		ld_desc = ld_desc + (ld_total * (ad_var / 100))	
	 end if	
	end if	
	
end for

return ld_desc
end function

public function decimal wf_calcula_descuento_acisa ();/*FUNCION QUE CALCULA EL DESCUENTO DEL PEDIDO*/
integer i 
Decimal	ld_precio_descuento, ld_precio_original,ld_descto_vta,ld_monto_total,ld_total_desc=0,ld_cantidad

if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 then

	ld_descto_vta = 0
	ld_total_desc = 0

	for i = 1 to dw_2.rowcount()
		/* Sólo para Acisa 22/11/2002 */

		ld_precio_descuento = dw_2.getitemNumber(i,"facd_precio_descuento")
		if IsNull(ld_precio_descuento) then ld_precio_descuento = 0
		ld_precio_original = dw_2.getitemNumber(i,"facd_precio_unidad_producto")
		
		if IsNull(ld_precio_original) or ld_precio_original=0 then 
			ld_precio_original = 1
			ld_precio_descuento= 1
		end if
		/*Valida si hubo descuento*/
		if ld_precio_descuento > 0 and ld_precio_descuento < ld_precio_original then
			ld_monto_total     = dw_2.getitemNumber(i,"facd_monto_total")
			if IsNull(ld_monto_total) then ld_monto_total = 0
			
			ld_cantidad = dw_2.getitemNumber(i,"facd_cantidad")
			ld_descto_vta =ld_monto_total - round((ld_monto_total/ld_precio_original)*ld_precio_descuento,2)

			dw_2.setitem(i,"facd_descuento_ncr",ld_descto_vta)
		else
			dw_2.setitem(i,"facd_descuento_ncr",0)
		end if
		// para setear al encabezado de factura
		if isNull(ld_descto_vta) then ld_descto_vta = 0
		ld_total_desc = ld_total_desc + ld_descto_vta
		ld_descto_vta = 0
	next
	dw_1.setitem(1,'fact_descuento_ncr',ld_total_desc)
end if
return ld_total_desc
end function

public function long wf_cantidad_total (long cantidad, integer fraccion, datawindow ldw_2, long row);//Función que devuelve la cantidad total pedida en piezas

 long ll_ucom, ll_total , ll_mconvera
 string ls_unidad_prod, ls_unidad_venta
 
 ls_unidad_prod  = ldw_2.GetItemString(row,"facd_unidad_producto")
		
 ls_unidad_venta = ldw_2.GetItemString(row,"facd_unidad_venta")
  
 //Tipo de medida de la unidad del producto	(UNIDADES, UNIDAD DE PESO, CONVERSIONES, ETC)
 // Devuleve 10 en caso de que sea una medida  
  
 ll_ucom = gf_medi_prod(ls_unidad_prod)
  
 //* Carga Los Datos de Converción de la Unidad Actual
 ll_mconvera = gf_unidad_venta(ls_unidad_venta, ll_ucom)
 
 if ll_mconvera = 0 or isnull(ll_mconvera) then
 
 	messagebox("ATENCIÓN SR. USUARIO", "Verifique las Unidades del Producto",Exclamation!)

	return 2
 
 end if

	ll_total = ( cantidad * ll_mconvera ) + fraccion   
	
return (ll_total)
end function

public subroutine wf_carga_cadena ();integer li_recorrido, li_linea
string ls_codigo
double ld_precio

//Inicializa la cadena
str_argumen.cadena_filtro = "(facd_codigo_item <> '') "


for li_recorrido = 1 to dw_2.rowcount()
	ls_codigo = dw_2.getitemstring(li_recorrido,"facd_codigo_item")			
	ld_precio = dw_2.getitemnumber(li_recorrido,"facd_precio_unidad_producto")
//	li_linea  = dw_2.getitemnumber(li_recorrido,"linea")
	li_linea  = dw_2.getitemnumber(li_recorrido,"facd_linea_articulo_dev")	
	if ls_codigo <> "" and not isnull(ls_codigo) then
	
		str_argumen.cadena_filtro = str_argumen.cadena_filtro + " and  facd_linea <> "+string(li_linea)
	
	end if	
	
end for

//messagebox("Cadena filtro",str_argumen.cadena_filtro)
end subroutine

public subroutine wf_cargos (double ld_cargos);
double ld_cargos_act, ld_monto
 
ld_cargos_act = dw_1.getitemnumber(dw_1.getrow(),"fact_gastos_total")	// Cargos actuales

dw_1.Accepttext()

If ld_cargos_act <> ld_cargos then
		
	ld_monto = dw_1.getitemnumber(dw_1.getrow(),"fact_monto_fact_total")	// Cargos actuales
	
	dw_1.setitem(dw_1.getrow(),"fact_gastos_total",ld_cargos)
	
	em_cargos.text = string(ld_cargos)  // Asignación de los cargos totales
	
	dw_1.setitem(dw_1.getrow(),"fact_monto_final",  ld_cargos + ld_monto)
	
   em_final.text = string(ld_monto +  ld_cargos)  // Asignación del monto total
	
End if
end subroutine

public subroutine wf_control ();//Control de Consistencia de los datos
if dw_1.getitemstring(dw_1.getrow(),"fact_estado") = "I" then
//	m_fa_padre.m_archivo.m_guardar.enabled = true
//	m_fa_padre.m_archivo.m_imprimir.enabled = true
//	m_fa_padre.m_archivo.m_vistapreliminar.enabled = false
end if	
end subroutine

public subroutine wf_control2 ();//Control de los botones
//	m_fa_padre.m_edicin.m_eliminar.enabled  = true
//	m_fa_padre.m_edicin.m_adicionar.enabled = false
//   m_fa_padre.m_archivo.m_imprimir.enabled = true
//	m_fa_padre.m_archivo.m_guardar.enabled  = true
end subroutine

public subroutine wf_elimina_blanco ();//Función que elimina el último registro en blanco y carga la cadena para filtro
integer li_recorrido
string ls_codigo

for li_recorrido = 1 to dw_2.rowcount()
	ls_codigo = dw_2.getitemstring(li_recorrido,"facd_codigo_item")				
	if ls_codigo = "" or isnull(ls_codigo) then
		dw_2.deleterow(li_recorrido)	
		ii_flag = 1		
	end if
	
end for
end subroutine

public function integer wf_elimina_det (string ls_pedido, integer li_anio, string ls_tipo);//Elimina el detalle de la devolución
	 Long	ll_anio
  DELETE FROM fadcargo  
   WHERE ( fadcargo.dcar_g_financiero = :str.g_financiero ) AND  
         ( fadcargo.dcar_empresa = :str.empresa ) AND  
         ( fadcargo.dcar_tipo = :ls_pedido ) AND  
         ( fadcargo.dcar_no_pedido = :ls_tipo ) AND  
         ( fadcargo.dcar_ann = :li_anio ) ;
		ll_anio =	sqlca.sqlcode 
		if sqlca.sqlcode = -1 then
			mensaje("Información(wf_elimina_det)","Error al Eliminar en fadcargo",sqlca.sqlerrtext)
			rollback using sqlca;
			return 0
		end if
		
  DELETE FROM fadvenfa  
   WHERE ( fadvenfa.vfac_g_financiero = :str.g_financiero ) AND  
         ( fadvenfa.vfac_empresa = :str.empresa ) AND  
         ( fadvenfa.vfac_tipo = :ls_tipo ) AND  
         ( fadvenfa.vfac_no_pedido = :ls_pedido ) AND  
         ( fadvenfa.vfac_ann = :li_anio )  ;

		ll_anio =	sqlca.sqlcode 

		if sqlca.sqlcode = -1 then
			mensaje("Información(wf_elimina_det)","Error al Eliminar en fadvenfa",sqlca.sqlerrtext)
			rollback using sqlca;
			return 0
		end if

		commit using sqlca;
return 1

end function

public function integer wf_empaque_prod (string codigo);//Retorna el empaque del producto
integer li_empaque

  SELECT inmprodu.prod_empaque  
    INTO :li_empaque  
    FROM inmprodu  
   WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
         ( inmprodu.prod_empresa = :str.empresa ) AND  
         ( inmprodu.prod_producto = :codigo )   ;
			
		if sqlca.sqlcode = -1 then
			mensaje("Información(wf_empaque_prod)","Error al Seleccionar el empaque en inmprodu",sqlca.sqlerrtext)
			return -1
		end if			
						
return(li_empaque)
end function

public function long wf_recupera (string estado);//Verifica si existe o no el pedido o la nota de credito
long ll_recuperados

if estado = "S" then
		select count(*)
		into :ll_recuperados
		from fatdiari
		where fact_g_financiero = :str.g_financiero and
				fact_empresa	   = :str.empresa and
				fact_no_pedido		= :is_pedido and
				fact_ann				= :ii_ann and
//				fact_tipo			= :is_tipo_fac and
				fact_estado			= "I";
				
	if sqlca.sqlcode = -1 then
		gf_mensaje("","Error al Validar Existencia "+sqlca.sqlerrtext,1,1,"E")
	end if		
				
else	
		select count(*)
		into :ll_recuperados
		from fatdiari
		where fact_g_financiero = :str.g_financiero and
				fact_empresa	   = :str.empresa and
				fact_no_pedido		= :is_pedido and
				fact_ann				= :ii_ann ;
	//			fact_tipo			= :is_tipo_fac;
				
	if sqlca.sqlcode = -1 then
		gf_mensaje("","Error al Validar Existencia "+sqlca.sqlerrtext,1,1,"E")
	end if				
	
end if	
return(ll_recuperados)				
end function

public subroutine wf_recupera_devueltas (long linea, datawindow ldw);//Función que restaura las cantidades devueltas.
string ls_codigo
long ll_linea, ll_devuelta


if dw_2.rowcount() > 0 and ldw = dw_2 then
	 em_total.text = string(dw_2.getitemnumber(linea,"suma"))
	 ll_devuelta = dw_2.Getitemnumber(linea,"devuelta_mod")
	 ls_codigo   = dw_2.getitemstring(linea,"facd_codigo_item")
	 ll_linea    = dw_2.getitemnumber(linea,"facd_linea_articulo_dev")
	
	 UPDATE faddiari  
    SET 	facd_cant_devuelta = :ll_devuelta
	 WHERE  ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
   	     ( faddiari.facd_empresa = :str.empresa ) AND  
      	  ( faddiari.facd_tipo = :is_tipo_fac ) AND  
           ( faddiari.facd_no_pedido = :is_pedido ) AND  
           ( faddiari.facd_linea = :ll_linea ) AND  
           ( faddiari.facd_ann = :ii_ann ) AND  
           ( faddiari.facd_codigo_item = :ls_codigo );

end if	
end subroutine

public function integer wf_recupera_dias (integer li_codigo_dias);//Función que recupera el numero de dias que tiene el cliente para pagar la factura
//Variables de memoria
string	ls_frecuencia
integer	li_cantidad, li_dias
  
  SELECT dgaperio.peri_frecuencia,   //Extrae la frecuencia M=mes, D=dias, etc.
         dgaperio.peri_valor_d_s  
    INTO :ls_frecuencia,   
         :li_cantidad  
    FROM dgaperio  
   WHERE ( dgaperio.peri_aplicacion = "FA" ) AND  
         ( dgaperio.peri_periodo = :li_codigo_dias ) ;
			
		if sqlca.sqlcode = -1 then
			mensaje("Información(wf_recupera_dias)","Error al Seleccionar en dgaperio",sqlca.sqlerrtext)
			return -1
		end if			
						
		CHOOSE CASE ls_frecuencia
			CASE "D"
				li_dias	=	li_cantidad
			CASE "M"
				li_dias	=  li_cantidad	*	30
			CASE "A"
				li_dias	=	li_cantidad	*	365
		END CHOOSE
return li_dias
end function

public subroutine wf_setea_iniciales ();//Setea el año y si es al por mayor o no, el pedido a buscar

ii_ann = Year(Date(gf_fecha_serv()))					//Año de Parametros	

dwc_tipo_fac.Scrolltorow(1)

is_tipo_fac = dwc_tipo_fac.GetItemString(1,"dgmsubse_subs_sub_trans")

dw_1.Setitem(dw_1.getrow(),"fact_tipo",is_tipo_fac) //Setea el tipo de factura

em_ann.text = string(ii_ann)						//Seteo el año al DW

end subroutine

public subroutine wf_setea_lineas ();//Función que setea la numeración de los registros a las lineas del detalle en FADDIARI
long ll_recorrido, ll_cantidad, ll_fraccion, ll_devuelta
string ls_codigo
long ll_linea, ll_total

if dw_2.Rowcount() > 0 then
	for ll_recorrido = 1 to dw_2.rowcount()
		
	 dw_2.Setitem(ll_recorrido,"facd_linea",ll_recorrido)
		
	 ls_codigo   = dw_2.getitemstring(ll_recorrido,"facd_codigo_item")
	 ll_linea    = dw_2.getitemnumber(ll_recorrido,"linea")
	 ll_cantidad = dw_2.GetItemNumber(ll_recorrido,"facd_cantidad") 
	 ll_fraccion = dw_2.GetItemNumber(ll_recorrido,"facd_cantidad_fraccion") 
	 ll_devuelta = dw_2.Getitemnumber(ll_recorrido,"devuelta")

	 if ib_modificacion then
		 ll_devuelta = dw_2.GetitemNumber(ll_recorrido,"devuelta_mod")
	 end if
	
//Funcion que devuelve la cantidad total en piezas.	
	 ll_total = wf_cantidad_total(ll_cantidad, ll_fraccion, dw_2, ll_recorrido)
//messagebox("Total devuelto", ll_total)
// dw_2.getitemnumber(ll_recorrido,"total")
				
//	 messagebox("",is_pedido+ "  "+string(ii_pormayor)+"  "+string(ii_ann) + "  "+ls_codigo+"  "+string(ll_linea)+"  "+string(ll_total))
		
	//Actualiza la cantidad devuelta en el Pedido Original	

	  UPDATE faddiari  
     SET facd_cant_devuelta = :ll_total  + :ll_devuelta
	  WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
   	     ( faddiari.facd_empresa = :str.empresa ) AND  
      	  ( faddiari.facd_tipo = :is_tipo_fac ) AND  
           ( faddiari.facd_no_pedido = :is_pedido ) AND  
           ( faddiari.facd_linea = :ll_linea ) AND  
           ( faddiari.facd_ann = :ii_ann ) AND  
           ( faddiari.facd_codigo_item = :ls_codigo )   ;			  
	
		IF SQLCA.SQLCODE = -1 THEN
			gf_mensaje("","Error al Actualizar Cant. Devuelta en Faddiari "+sqlca.sqlerrtext,1,1,"E")
		end if

	  dw_2.Setitem(ll_recorrido,"facd_cant_devuelta",ll_total  + ll_devuelta)
		
	end for			
	
end if
end subroutine

public subroutine wf_setea_originales (long ll_cantidad1, integer li_fraccion2, double ld_monto, double ld_final, datawindow ldw_2, long row, integer devueltas);
messagebox("ATENCIÓN SR. USUARIO","No puede devolver más de la cantidad facturada")

		  ldw_2.setitem(row,"facd_cantidad",ll_cantidad1)
		  ldw_2.setitem(row,"facd_cantidad_fraccion",li_fraccion2)
		  ldw_2.setitem(row,"facd_monto_total",ld_monto)		  
		  ldw_2.setitem(row,"facd_monto_final",ld_final)		  		  
 		  ldw_2.setitem(row,"facd_cant_devuelta", devueltas)
		  ldw_2.accepttext()
		  //asigna el total
 		  em_total.text = string(ldw_2.getitemnumber(row,"suma"))			  
end subroutine

public subroutine wf_setear_user (string as_user);//Asigno el Usuario a la Variable de Instancia
is_user = as_user
end subroutine

public subroutine wf_totaliza ();double ld_suma, ld_cargos, ld_desc
integer li_bultos

	 ld_suma			= dw_2.getitemnumber(dw_2.getrow(),"suma")
	 li_bultos 		= dw_2.getitemnumber(dw_2.getrow(),"bultos")
  	 em_total.text = string(ld_suma)
	 ld_cargos		= dw_1.getitemnumber(dw_1.getrow(),"fact_gastos_total")
	 ld_desc			= wf_calcula_desc(ld_suma)
	 em_desc.text	= string(ld_desc)
	 em_cargos.text= string(ld_cargos)
	 em_final.text = string(ld_suma + ld_cargos - ld_desc)
	 
end subroutine

on w_fa_man_modi_devolucion.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.em_ann=create em_ann
this.sle_pedido=create sle_pedido
this.cb_incluir=create cb_incluir
this.gb_3=create gb_3
this.em_total=create em_total
this.em_cargos=create em_cargos
this.em_final=create em_final
this.st_1=create st_1
this.st_4=create st_4
this.pb_1=create pb_1
this.st_2=create st_2
this.st_5=create st_5
this.em_desc=create em_desc
this.st_6=create st_6
this.cb_1=create cb_1
this.dw_4=create dw_4
this.st_microhelp=create st_microhelp
this.dw_3=create dw_3
this.em_fecha=create em_fecha
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_ann
this.Control[iCurrent+2]=this.sle_pedido
this.Control[iCurrent+3]=this.cb_incluir
this.Control[iCurrent+4]=this.gb_3
this.Control[iCurrent+5]=this.em_total
this.Control[iCurrent+6]=this.em_cargos
this.Control[iCurrent+7]=this.em_final
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.pb_1
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.em_desc
this.Control[iCurrent+14]=this.st_6
this.Control[iCurrent+15]=this.cb_1
this.Control[iCurrent+16]=this.dw_4
this.Control[iCurrent+17]=this.st_microhelp
this.Control[iCurrent+18]=this.dw_3
this.Control[iCurrent+19]=this.em_fecha
end on

on w_fa_man_modi_devolucion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_ann)
destroy(this.sle_pedido)
destroy(this.cb_incluir)
destroy(this.gb_3)
destroy(this.em_total)
destroy(this.em_cargos)
destroy(this.em_final)
destroy(this.st_1)
destroy(this.st_4)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.st_5)
destroy(this.em_desc)
destroy(this.st_6)
destroy(this.cb_1)
destroy(this.dw_4)
destroy(this.st_microhelp)
destroy(this.dw_3)
destroy(this.em_fecha)
end on

event open;//override
This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)
str.frame.SetRedraw ( True )

str_pedi = message.PowerObjectParm

this.postevent("ue_post_open")
end event

event resize;this.x = 5
this.y = 5
end event

event ue_post_open;//Procesos iniciales de la ventana
int li_Count
long ll_lineas = 0
datetime ldt_fecha

This.Icon = str.icono
//if	isNull ( str_pedi.datawindow ) or trim(str_pedi.datawindow)='' then
//	mensaje("Atención ","Estimado Usuario, no se ha configurado el formato de Impresión de la Devolución a" + &
//	"ser utilizado, para ello debe ir a Parámetros, opción de Formatos "+& 
//	"/Devolución y Agregar el formato a utilizar .. gracias","")
//	Return
//end if

//Child de Devoluciones
dw_1.GetChild('fact_no_pedido',chdw_dev_pedido)
chdw_dev_pedido.Settransobject(sqlca);
//fact_tipo
dw_1.Modify("fact_tipo.TabSequence='0'")
is_nativo = chdw_dev_pedido.GetSqlSelect()

dw_1.GetChild('fact_tipo', dwc_tipo_fac)
dwc_tipo_fac.Settransobject(sqlca);
If dwc_tipo_fac.Retrieve(str.g_financiero, str.empresa,'FA') < 1 Then  dwc_tipo_fac.Insertrow(0)
dwc_tipo_fac.setfilter("subs_transaccion = 'FA'") //Para que no muestre las transacciones de FC (Contado)
dwc_tipo_fac.filter()

wf_recupera_nc()

//chdw_devolucion.Retrieve(str.g_financiero, str.empresa)
//Yield()

dw_1.SetTransObject(Sqlca);
dw_2.SetTransObject(Sqlca);
dw_4.SetTransObject(Sqlca);

dw_4.visible = false

dw_2.SetRowFocusIndicator(Hand!)

ldt_fecha = gf_fecha_serv()
em_fecha.text = string(date(ldt_fecha))
wf_botones()

dw_2.scrolltorow(dw_2.insertrow(0))
dw_1.scrolltorow(dw_1.insertrow(0))

dw_1.Setfocus()

wf_setea_iniciales()

dw_1.SetItem(1,"fact_fecha",ldt_fecha)
		
dw_1.SetItem(1,"fact_fecha_modificacion",ldt_fecha)

st_3.text = this.classname()

//Crea DataStore de encabezado, detalle , cargos y vendedores

ids_enca = create datastore
ids_enca.DataObject = 'dw_ma_fa_tdevol_modi'
ids_enca.SetTransobject(sqlca);

ids_deta = create datastore
ids_deta.DataObject = 'dw_ma_fa_ddevol_modi'
ids_deta.SetTransobject(sqlca);

ids_cargos = create datastore
ids_cargos.DataObject = 'dw_ma_fa_cardevol_modi'
ids_cargos.Settransobject(sqlca);

//Child de Devoluciones el Data Store
ids_enca.GetChild('fact_no_pedido', chdw_devolucion)
chdw_devolucion.Settransobject(sqlca);

//Child de Tipo de Factura
ids_enca.GetChild('fact_tipo', dwc_tipo_fac1)
dwc_tipo_fac1.Settransobject(sqlca);
If dwc_tipo_fac1.Retrieve(str.g_financiero, str.empresa,'FA') < 1 Then  dwc_tipo_fac1.Insertrow(0)
dwc_tipo_fac1.Scrolltorow(1)
dwc_tipo_fac1.setfilter("subs_transaccion = 'FA'") //Para que no muestre las transacciones de FC (Contado)
dwc_tipo_fac1.filter()

wf_recupera_nc()

// Creando el UO DataStore de Desglose
iuo_desglose = Create uo_ds_desglose
iuo_desglose.Dynamic of_init ("dw_ma_fa_desglose_factura_desc")

wf_modifica_precio()

String	ls_autoriza_s_n,ls_autoriza

ib_cerrar = false

//if w_fa_fondo.str_aplica_links.controla_modificaciones =1 then /*Controla modificaciones*/	

//	openwithparm(w_dg_man_clave,ls_autoriza)
	
//	ls_autoriza_s_n = Message.StringParm 
	
//	CHOOSE CASE ls_autoriza_s_n
//	CASE '1'	//Usuario Autorizado
//	CASE '2'	//Usuario no Autorizado
//		messagebox('Atención ','Estimado Usuario Ud. no está autorizado para Mofificar Devoluciones, consulte a su Supervisor...!!!')
//		ib_cerrar = true
//		timer(1)
//		return 
//	CASE ELSE
//		ib_cerrar = true
//		timer(1)
//		return 
//	END CHOOSE
//end if

end event

event ue_syscommand;if commandtype = 61536 then		
   string ls_codigo	
   if dw_2.rowcount() > 0 then ls_codigo = dw_2.getitemstring(1,"facd_codigo_item")
	if ls_codigo = "" or isnull(ls_codigo) then
		ib_preguntar = false
	else
		ib_preguntar = true
	end if
end if	

end event

event ue_eliminar;string ls_estado, ls_pedido, ls_tipo,ls_secuencia, ls_documento,ls_error
integer li_recorrido,li_anio
long ll_registros, ll_secuencia
DataWindow	ldw_cual

//If ib_cual_dw Then
//If ib_cual_dw Then
//	ldw_cual = dw_1
//Else
//	ldw_cual = dw_2
//End If

ldw_cual = dw_actual

wf_recupera_devueltas(dw_2.getrow(),ldw_cual)

if ldw_cual.rowcount() > 0 then
	if messagebox("ATENCIÓN SR. USUARIO", "Esta seguro de Eliminar el Registro", Question! ,Yesno!, 1) = 1 then
		if ldw_cual.rowcount() > 1  then
			/*comentado por HGN/06/03/2003 si era dw_1 lo borraba sin haber
			borrado el detalle y se producia error*/
			
//			ldw_cual.deleterow(ldw_cual.getrow())
			//**  **//
			if ldw_cual = dw_2 then
				ldw_cual.deleterow(ldw_cual.getrow())
				ib_cual_dw = false
				ll_registros = dw_2.Rowcount()
				for li_recorrido = 1 to ll_registros
					wf_recupera_devueltas(li_recorrido, dw_2)
				end for
				ib_cual_dw = true												
				
				if wf_valida_todo(1) then 
					commit using sqlca;
				end if	
				
				wf_control2() //Deshabilita los 4 botones
				cb_incluir.enabled = true
			else
				ii_flag = 0  //Flag para eliminar el espacio en blanco del detalle
				ldw_cual.Scrolltorow(ldw_cual.insertrow(0))		//*******		
			end if
		elseif ldw_cual = dw_2 then
			ldw_cual.deleterow(ldw_cual.getrow())
		elseif ldw_cual = dw_1 then
			if dw_2.rowcount() > 0 then
				messagebox('Atención ','Elimine el detalle ')
				return
			else
				this.setredraw(false)
				ls_pedido = dw_1.getItemString(dw_1.getrow(),"fact_no_pedido")
				li_anio = dw_1.getItemNumber(dw_1.getrow(),"fact_ann")
				ls_tipo = dw_1.getItemString(dw_1.getrow(),"fact_tipo")

/*				if wf_elimina_det(ls_pedido,li_anio,ls_tipo) = 1 then
				
					dw_1.deleterow(dw_1.getrow())
					if dw_1.update() = 1 then
						commit using sqlca;
						
						if chdw_dev_pedido.Retrieve(str.g_financiero, str.empresa) < 1 then
							chdw_dev_pedido.Scrolltorow(chdw_dev_pedido.insertrow(0))
						end if
						if chdw_devolucion.Retrieve(str.g_financiero, str.empresa) < 1 then
							chdw_devolucion.Scrolltorow(chdw_devolucion.insertrow(0))
						end if
						
						this.triggerevent("ue_adicionar")
						str.frame.Setmicrohelp("Actualización Exitosa ")
					else
						rollback using sqlca;
						str.frame.Setmicrohelp("Error al eliminar Encabezado")	
						mensaje("Atención","¡Error al eliminar Encabezado !", is_db_err)
						If dw_1.retrieve(str.g_financiero,str.empresa,ls_pedido,li_anio) <1 then
							this.triggerevent("ue_adicionar")
						end if
					end if 
				else
					rollback using sqlca;
				end if
*/
				dw_1.setitem(dw_1.getrow(),"fact_monto_fact_total",0)
				dw_1.setitem(dw_1.getrow(),"fact_monto_final",0)
				dw_1.setitem(dw_1.getrow(),"fact_gastos_total",0)
				
				this.triggerevent("ue_aceptar")
				
				ls_secuencia  = dw_1.getitemstring(1,"fact_no_factura")
				ll_secuencia  = il_secuencia //Se carga al actualizar el encabezado
				ls_documento  = ls_secuencia
				
				  DELETE FROM intmovim  
					 WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
							( intmovim.tmov_empresa = :str.empresa) AND  
							( intmovim.tmov_aplicacion = :str.aplicacion ) AND  
							( intmovim.tmov_tipo_transaccion = 'DV') AND  
							( intmovim.tmov_documento = :ls_documento ) AND  
							( intmovim.tmov_concepto = 'DV' ) AND  
							( intmovim.tmov_anual = :li_anio ) and 
							( intmovim.tmov_secuencia = :il_secuencia );
			
						if sqlca.sqlcode = -1 then
							
							ls_error = sqlca.sqlerrtext
							rollback;
							mensaje("Aviso", "Error al borrar el encabezado (intmovim)",ls_error)
						elseif sqlca.sqlcode = 0 then	

							dw_1.deleterow(dw_1.getrow())
							if dw_1.update() = 1 then
								commit using sqlca;
								wf_recupera_nc()

							else
								rollback using sqlca;
							end if
							commit;
							this.triggerevent("ue_adicionar")
						end if
/**/					
				this.setredraw(true)
				return
			end if
		end if
		
		//Asigna totales
		if dw_2.rowcount() <> 0 then wf_totaliza()

		wf_recupera_nc()
	end if	
else 
	messagebox("Atención","No hay registros para borrar !")
end if


end event

event closequery;Int li_msg
Boolean lb_dw_modify = false
dwItemStatus l_status_1, l_status_2

dw_1.AcceptText()
dw_2.AcceptText()

if dw_2.rowcount() = 0 then 
	Close(this)
	return
end if

if dw_2.rowcount() = 1 and dw_2.getitemstring(dw_2.Getrow(),"facd_codigo_item") = "" &
   or isnull(dw_2.getitemstring(1,"facd_codigo_item")) then
	dw_1.ResetUpdate()
end if
l_status_1 = dw_1.GetItemStatus(dw_1.GetRow(), dw_1.GetColumn(), Primary!)
l_status_2 = dw_2.GetItemStatus(dw_2.GetRow(), dw_2.GetColumn(), Primary!)

IF (l_status_1 <> NotModified! AND l_status_1 <> New!) OR ((dw_1.ModifiedCount() + dw_1.DeletedCount()) > 0) THEN &
	lb_dw_modify = true
	
IF (l_status_2 <> NotModified! AND l_status_2 <> New!) OR ((dw_2.ModifiedCount() + dw_2.DeletedCount()) > 0) THEN &
	lb_dw_modify = true

IF lb_dw_modify and ib_preguntar  THEN 
	li_msg = MessageBox("Aviso " + This.Title, "¿Desea Salvar los Cambios Realizados?", Question!, yesnocancel!, 1)
	If li_msg = 1 Then
		This.TriggerEvent("ue_aceptar")
		ib_preguntar = true
		If Len(Trim(is_db_err)) > 0 Then	Return
	ElseIf li_msg = 3 Then
		ib_preguntar = true
		Return(1)
	End If
END IF
Close(this)
end event

event ue_print;// Para 	la impresión de la factura
integer 	li_pos, li_paginas, li_ok, li_pos2, li_pos3, li_act_invent, li_act_cliente, li_pos4
double	ld_monto
integer 	li_open, li_venta
string 	ls_retorno, ls_devol, ls_estado, ls_tipo, ls_monto, ls_fecha, ls_nom
long 		ll_estatus, ll_ann
Boolean	lb_act_secuencia
date		ldt_fecha
lb_act_secuencia = False
ls_monto = em_total.text
ld_monto = double(mid(ls_monto,pos(ls_monto,"$") + 1))

li_venta = dw_1.GetitemNumber(dw_1.Getrow(),"fact_tipo_venta")
ls_tipo  = dw_1.GetItemString(dw_1.getrow(),"fact_condicion_pago")

if dw_2.rowcount() <> 0 then
	integer li_mod, li_recorrido, li_var	
	str_pedi.datawindow = trim(str_pedi.datawindow)
 
	//	dw_3.DataObject  = "dw_ma_fa_imp_dev_dapol"
		dw_3.DataObject = str_pedi.datawindow
	
	dw=dw_3	
	dw.settransobject(sqlca)
	ls_nom = gf_fa_nom_empr( str.g_financiero , str.empresa  )
	
	if dw.describe("nom_empresa.x") <> "?" And dw.describe("nom_empresa.x") <> "!" then
		dw.object.nom_empresa.expression = "'" + ls_nom + "'"
	End if

	ll_ann = dw_1.getitemnumber(1,"fact_ann")
	
	li_open = dw.retrieve(str.g_financiero,str.empresa,is_tipo_fac,is_pedido_nc, ll_ann) //, is_tipo_fac)

	//Seteo el estado de la factura
	ls_estado 	= dw_1.getitemstring(1,"fact_estado")
	
	li_open 		= dw_1.retrieve(str.g_financiero,str.empresa,is_tipo_fac,is_pedido_nc, ll_ann) //, is_tipo_fac)
	
	if li_open = 0 then
		messagebox("Atencion Sr. Usuario", "No se Recuperaron Registros para Imprimir")
	else		
		//Funcion que busca y asigna los  vendedores involucrados en la factura
		wf_imprime_vendedor()
	end if	
	

	//Abrir la ventana de impresión de facturas
	li_open = OpenWithParm(w_fa_man_modi_dev_num, dw)


end if

end event

event ue_aceptar;//window lw_ventana
Long 		ll_update_1, ll_update_2, ll_update_3,ll_estatus
String 	ls_titulo
Boolean	lb_act_secuencia
long		ll_facd_cantidad,ll_facd_linea,ll_lineas_dw2,ll_err
decimal	ld_facd_costo_cif,ld_facd_fraccion,ld_medi_cantidad,ld_costo_total,ld_tot
string	ls_facd_unidad_venta,ls_err, ls_devol
integer 	li_act_invent , li_act_cliente,li_ok
datetime ldt_fecha 
	

//Habilita la impresion y deshabilita Guardar
if dw_2.rowcount() > 0 then	
	 if dw_2.getitemstring(1,"facd_codigo_item")	= ""	or &
		 isnull(dw_2.getitemstring(1,"facd_codigo_item")) then
		 gf_mensaje("","La devolución no tiene Detalle",1,1,"S")
		 return	  
	 end if		  
end if

//if not isvalid(m_fa_principal) then
//	this.Changemenu(m_fa_principal)
//end if	
m_fa_padre.m_archivo.m_guardar.enabled 			= False
m_fa_padre.m_archivo.m_imprimir.enabled 			= True
m_fa_padre.m_archivo.m_vistapreliminar.enabled 	= false
m_fa_padre.m_edicin.m_eliminar.enabled 			= True	

/*Calculo de descuento para Acisa*/
if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 then
	ld_tot=wf_calcula_descuento_acisa()
end if

//Setea Los Totales al DW 1
dw_1.SetItem(1,"fact_monto_final",dec(mid(em_final.text,2)))
dw_1.SetItem(1,"fact_monto_fact_total",dec(mid(em_total.text,2)))
dw_1.SetItem(1,"fact_gastos_total",dec(mid(em_cargos.text,2)))

ldt_fecha = gf_fecha_serv()

dw_1.SetItem(1,"fact_fecha_modificacion",ldt_fecha)

ldt_fecha		=  dw_1.getitemDatetime(dw_1.getrow(),'fact_fecha')

em_fecha.text = string(date(ldt_fecha))

ll_update_1 = dw_1.Update (True, False)

ll_update_2 = dw_2.Update (True, False)

if ll_update_1 = 1 And ll_update_2 = 1 then
	//Actualiza los cargos
   ll_update_3 = dw_4.Update()
	
	if ll_update_3 = -1 then
		str.frame.Setmicrohelp("Error al Actualizar")
		timer(6)
		str.frame.Setmicrohelp(" ")
		is_db_err = sqlca.sqlerrtext
		rollback using sqlca;
		mensaje("Atención","¡Error al Actualizar !", is_db_err)		
		return
	end if
	
	dw_1.ResetUpdate ()
	dw_2.ResetUpdate ()
	iuo_desglose.ResetUpdate()
/// cambio por arturo actualizar el costo total

	for ll_lineas_dw2 = 1 to dw_2.rowcount()

		ld_facd_costo_cif = dw_2.getitemdecimal(dw_2.getrow(),"facd_costo_cif")
		ll_facd_cantidad =  dw_2.getitemnumber(dw_2.getrow(),"facd_cantidad")
		ll_facd_linea = dw_2.getitemnumber(dw_2.getrow(),"facd_linea")
		ld_facd_fraccion = dw_2.getitemdecimal(dw_2.getrow(),"facd_cantidad_fraccion")
		ls_facd_unidad_venta = dw_2.getitemstring(dw_2.getrow(),"facd_unidad_venta")
			
		select medi_cantidad
		into :ld_medi_cantidad
		from inamedid
		where medi_medida = :ls_facd_unidad_venta ;

		update faddiari
		set facd_costo_total = convert(numeric(12, :w_fa_fondo.str_para.formato_decimal_costo),(:ll_facd_cantidad * :ld_facd_costo_cif) + ((:ld_facd_costo_cif / :ld_medi_cantidad ) * :ld_facd_fraccion))
		where facd_g_financiero = :str.g_financiero
		and   facd_empresa      = :str.empresa
		and   facd_tipo         = :is_tipo_fac
		and   facd_no_pedido    = :is_pedido_nc
		and   facd_ann          = :ii_ann
		and   facd_linea        = :ll_facd_linea;
	
		if sqlca.sqlcode = -1 then
			ll_err = sqlca.sqlcode
			ls_err = sqlca.sqlerrtext
			rollback;
			if ll_err = 100 then
				messagebox('Aviso','No se pudo actualizar el costo total '+ls_err)
			end if
			return
		end if
		
	next	
	
      select sum(facd_costo_total)
		into :ld_costo_total
		from faddiari
		where facd_g_financiero = :str.g_financiero
		and   facd_empresa      = :str.empresa
		and   facd_tipo         = :is_tipo_fac
		and   facd_no_pedido    = :is_pedido_nc
		and   facd_ann          = :ii_ann;
		
		if sqlca.sqlcode = -1 then
			ll_err = sqlca.sqlcode
			ls_err = sqlca.sqlerrtext
			rollback;
			if ll_err = 100 then
				messagebox('Aviso','No se pudo recuperar los datos en FADDIARI '+ls_err)
			end if
			return
		end if

		update fatdiari
		set fact_costos_total = :ld_costo_total
		where fact_g_financiero = :str.g_financiero
		and   fact_empresa      = :str.empresa
		and   fact_tipo         = :is_tipo_fac
		and   fact_no_pedido    = :is_pedido_nc
		and   fact_ann          = :ii_ann ;
	
		if sqlca.sqlcode = -1 then
			ll_err = sqlca.sqlcode
			ls_err = sqlca.sqlerrtext
			rollback;
			if ll_err = 100 then
				messagebox('Aviso','No se pudo actualizar el costo total en FATDIARI '+ls_err)
			end if
			return
		end if
	
/// fin del cambio por arturo de actualizar el costo total

	commit using sqlca;
	str.frame.Setmicrohelp("Actualización Exitosa ")
	timer(600000)

else
	rollback using sqlca;
	str.frame.Setmicrohelp("Error al Actualizar")	
	mensaje("Atención","¡Error al Actualizar !", is_db_err)
	Return
end if

////Recupera los datos del dropdown
//dw_1.GetChild('fact_no_pedido', chdw_devolucion)
//chdw_devolucion.Settransobject(sqlca);

//Child de Tipo de Factura
ids_enca.GetChild('fact_tipo', dwc_tipo_fac1)
dwc_tipo_fac1.Settransobject(sqlca);
dwc_tipo_fac1.setfilter("subs_transaccion = 'FA'") //Para que no muestre las transacciones de FC (Contado)
dwc_tipo_fac1.filter()

//dw_1.setitem(dw_1.getrow(),"fact_no_pedido",is_pedido_nc)
dw_1.setItemStatus(dw_1.getrow(), "fact_no_pedido",Primary!, NotModified!);

li_act_invent  =  dw_1.getitemnumber(dw_1.getrow(),'fact_act_inventario')
li_act_cliente =  dw_1.getitemnumber(dw_1.getrow(),'fact_act_cliente')
ls_devol       =  dw_1.getitemstring(dw_1.getrow(),'fact_no_factura')

if ll_update_1	 = 1	 then	//Actualiza la factura
	commit using sqlca;								  // Salva la factura
	
	if li_act_invent = 1 then	// si actualiza inventario
		
		li_ok = wf_actualiza_inventario(dw_1, dw_1.getrow()) // Funcion que afecta a inventario

		if li_ok = 0 then
			dw_1.setitem(dw_1.getrow(),"fact_act_inventario",1)	//Si actualizó inventario
			if dw_1.update() = 1 then
				commit using sqlca;					  //Salva las actualizaciones a inventario
				str.frame.setmicrohelp("Actualizo Inventario OK.")
			else
				str.frame.setmicrohelp("Error al Actualizar Inventario.")
				timer(50)	
				rollback using sqlca;
			end if
		else
			str.frame.setmicrohelp("Error al Actualizar Inventario.")
			rollback using sqlca;				
			timer(50)
		end if
	end if
	
	if li_act_cliente = 1 then					//Si actualiza al cliente
		li_ok = wf_actualiza_cliente()		//Función que actualiza a clientes

		if li_ok = 0 then
			dw_1.setitem(dw_1.getrow(),"fact_act_cliente",1)	//Si actualizó inventario
			if dw_1.update() = 1 then
				commit using sqlca;					//Salva las actualizaciones a clientes
				str.frame.setmicrohelp("Actualizo Cliente OK.")
				wf_protege()
			else
				str.frame.setmicrohelp("Error al Actualizar Cliente.")
				timer(50)					
				rollback using sqlca;
			end if	
		else
			str.frame.setmicrohelp("Error al Actualizar Cliente.")
			timer(50)
			rollback using sqlca;
		end if				
	end if
			
	if li_ok = 0 then
		str.frame.setmicrohelp("Devolución Actualizada Satisfactoriamente..!! ")
		gf_mensaje("","Actualización Exitosa ",1,1,"E")
	END IF
else
	rollback using sqlca;
	messagebox("ATENCIÓN ","Error al Actualizar ",Exclamation!)
end if

str.frame.setmicrohelp(" ")

end event

event close;//Override
// Destruyendo el Objeto Desglose
if isvalid(iuo_desglose) then destroy iuo_desglose
if isvalid(this) then close(this)
end event

event timer;call super::timer;if ib_cerrar then
	this.postevent("close")
end if
end event

type st_3 from w_fa_padre_maest_det`st_3 within w_fa_man_modi_devolucion
boolean visible = false
integer x = 14
integer y = 1264
integer width = 1285
string text = "nombre"
end type

type st_msg_row from w_fa_padre_maest_det`st_msg_row within w_fa_man_modi_devolucion
integer x = 1751
integer y = 1052
integer width = 1111
integer height = 200
end type

type dw_2 from w_fa_padre_maest_det`dw_2 within w_fa_man_modi_devolucion
event ue_cantidad ( )
event ue_fraccion ( )
event ue_bultos ( integer cantidad,  integer fraccion )
event ue_down pbm_dwnkey
event ue_posteditchanged ( long row,  dwobject dwo,  string data )
event ue_modifica_precio ( )
integer x = 23
integer y = 632
integer width = 3173
integer height = 408
integer taborder = 90
string dataobject = "dw_ma_fa_ddevol_modi"
end type

event dw_2::ue_cantidad;string ls_unian, ls_unidad_prod, ls_unidad_venta
long   ll_ucom
long   ll_mconvera, ll_mconverb, ll_cant_x_linea
double ld_precio, ld_descuento, ld_monto
long   ll_cantidad, ll_fraccion, ll_total, ll_devuelta, ll_devuelta_anterior

 ls_unian      = This.GetItemString(This.getrow(),"facd_unidad_venta")
 ls_unidad_prod= This.GetItemString(This.getrow(),"facd_unidad_producto")
 ls_unidad_venta= This.GetItemString(This.getrow(),"facd_unidad_venta")
// ll_cantidad = This.GetItemNumber(This.getrow(),"facd_cantidad")
 ll_cantidad = long(this.Gettext())
 ll_fraccion = This.GetItemNumber(This.getrow(),"facd_cantidad_fraccion") 
 ld_precio   = This.GetItemNumber(This.getrow(),"facd_precio_unidad_producto") 
 ld_descuento= This.GetitemNumber(This.getrow(),"facd_por_descuento")
 ll_devuelta = This.GetitemNumber(This.getrow(),"facd_cant_devuelta")
 ll_devuelta_anterior = This.GetitemNumber(This.getrow(),"devuelta")
 if ib_modificacion then
	 ll_devuelta_anterior = This.GetitemNumber(This.getrow(),"devuelta_mod")
 end if
 ll_total	 = This.GetitemNumber(This.getrow(),"total")
 
  //Tipo de medida de la unidad del producto	(UNIDADES, UNIDAD DE PESO, CONVERSIONES, ETC)
  // Devuleve 10 en caso de que sea una medida
 ll_ucom = gf_medi_prod(ls_unidad_prod)
  
 //* Carga Los Datos de Converción de la Unidad Actual
 ll_mconvera = gf_unidad_venta(ls_unidad_venta, ll_ucom)
 
 if ll_mconvera = 0 or isnull(ll_mconvera) then
 	messagebox("ATENCIÓN SR. USUARIO", "Verifique las Unidades del Producto",Exclamation!)
	return 
 end if
 
ll_cant_x_linea = ll_mconvera * ll_cantidad + ll_fraccion   // cantidad a pedir
 
// messagebox("Totales", string(ll_total)+"  ,   "+string(ld_cant_x_linea))
 
ld_monto  =  (ld_precio * ll_cantidad) + ( ( ld_precio / ll_mconvera ) * ll_fraccion )
 
this.setitem(this.getrow(),"facd_monto_total",ld_monto)
 
if ld_descuento <> 0.00 then
	this.setitem(this.getrow(),"facd_monto_final",ld_monto - (ld_monto * (ld_descuento / 100) ))
else
 	this.setitem(this.getrow(),"facd_monto_final",ld_monto)
end if

this.setitem(this.getrow(),"facd_cant_devuelta",ll_cant_x_linea + ll_devuelta_anterior)
 
end event

event dw_2::ue_fraccion;string ls_unian, ls_unidad_prod, ls_unidad_venta
long ll_ucom, ll_mconvera, ll_mconverb, ll_cant_x_linea
double ld_precio, ld_descuento, ld_monto
long ll_cantidad, ll_fraccion, ll_devuelta,  ll_devueltas_anteriores

 ls_unian        = This.GetItemString(This.getrow(),"facd_unidad_venta")
 ls_unidad_prod  = This.GetItemString(This.getrow(),"facd_unidad_producto")
 ls_unidad_venta = This.GetItemString(This.getrow(),"facd_unidad_venta")
 ll_cantidad     = This.GetItemNumber(This.getrow(),"facd_cantidad")

 ll_fraccion = long(this.Gettext())
 //ll_fraccion = This.GetItemNumber(This.getrow(),"facd_cantidad_fraccion") 
 
 ld_precio   = This.GetItemNumber(This.getrow(),"facd_precio_unidad_producto") 
 ld_descuento= This.GetitemNumber(This.getrow(),"facd_por_descuento")

 ll_devuelta = This.GetitemNumber(This.getrow(),"facd_cant_devuelta")
 
 ll_devueltas_anteriores = This.GetitemNumber(This.getrow(),"devuelta")

 if ib_modificacion then
	 ll_devueltas_anteriores = This.GetitemNumber(This.getrow(),"devuelta_mod")
 end if

  //Tipo de medida de la unidad del producto	(UNIDADES, UNIDAD DE PESO, CONVERSIONES, ETC)
  // Devuleve 10 en caso de que sea una medida
 ll_ucom = gf_medi_prod(ls_unidad_prod)
  
 //* Carga Los Datos de Converción de la Unidad Actual
 ll_mconvera = gf_unidad_venta(ls_unidad_venta, ll_ucom)
 
 if ll_mconvera = 0 or isnull(ll_mconvera) then
 	messagebox("ATENCIÓN SR. USUARIO", "Verifique las Unidades del Producto",Exclamation!)
	return 
 end if
 
 ll_cant_x_linea = ll_mconvera * ll_cantidad + ll_fraccion   // cantidad a pedir
 
 ld_monto  =  (ld_precio * ll_cantidad) + ( (ld_precio / ll_mconvera ) * ll_fraccion )
 
 this.setitem(this.getrow(),"facd_monto_total",ld_monto)
 
 if ld_descuento <> 0.00 then
	this.setitem(this.getrow(),"facd_monto_final",ld_monto - (ld_monto * (ld_descuento / 100) ))
 else
 	this.setitem(this.getrow(),"facd_monto_final",ld_monto)
 end if

 this.setitem(this.getrow(),"facd_cant_devuelta",ll_cant_x_linea +  ll_devueltas_anteriores)
end event

event dw_2::ue_bultos;// Calcula la cantidad de bultos
string ls_unian, ls_medac, ls_uni_empaque, ls_codigo
long ll_fraccion, ll_cantidad, ll_empaque, ll_cant_x_bul
long ll_ucom, ll_mconvera, ll_mconver, ll_cant_x_linea

 ls_unian      = This.GetItemString(This.getrow(),"facd_unidad_venta")
//  	= This.GetItemNumber(This.getrow(),"facd_cantidad_fraccion")
// ll_cantidad   = This.GetItemNumber(This.getrow(),"facd_cantidad")
 
// Unidad del producto
ls_medac = This.getitemstring(This.getrow(),"facd_unidad_producto")
			  			
//Tipo de medida de la unidad del producto	(UNIDADES, UNIDAD DE PESO, CONVERSIONES, ETC)	 
ll_ucom = gf_medi_prod(ls_medac)
   
// Carga Los Datos de Converción de la Unidad Actual
ll_mconvera 	= gf_unidad_venta(ls_unian, ll_ucom)

//Codigo del producto
ls_codigo = This.Getitemstring(This.Getrow(),"facd_codigo_item")

//Funcion que retorna la unidad de empaque del producto
ls_uni_empaque = wf_unidad_empaque(ls_codigo)

// Carga Los Datos de Converción de la Unidad de empaque
ll_mconver 	= gf_unidad_prod(ls_uni_empaque, ll_ucom)
		 
 if ll_mconver = 0 then	
	 messagebox("Atención Sr. Usuario","Verifique las medidas del Producto",exclamation!)	
 end if	
 
 //Empaque en que biene el producto
 ll_empaque = wf_empaque_prod(ls_codigo) 
 
 if ll_empaque = 0 then		// para que no divida por cero mas adelante
	
   messagebox("Atención Sr. Usuario","Verifique el empaque del producto",exclamation!)  
	
	ll_empaque = 1
 
 end if
  
 ll_cant_x_bul   = ll_mconver * ll_empaque						 // Cantidad por bulto
 
 if ll_cant_x_bul = 0 then
	
	 ll_cant_x_bul = 1
	
 end if	
 
 ll_cant_x_linea = ll_mconvera * cantidad + fraccion   // cantidad a pedir
 
 This.SetItem(This.getrow(), "facd_bultos", long(ll_cant_x_linea / ll_cant_x_bul))

end event

event dw_2::ue_down;call super::ue_down;//Para que avance en el Enter
choose case key
	CASE	  Keyenter! 
		this.Setcolumn(19)
end choose

end event

event dw_2::ue_posteditchanged;//Integer		li_rtn
//String 		ls_columna
//
////dwo.Data [row, long (dwo.id)] = dec (data)
//ls_columna = string (dwo.name)
//SetItem (row, ls_columna, dec (data))
//	
//If string (Object.desglose [row]) <> '' Then 
//	li_rtn = MessageBox ('Atención', 'La línea posee desglose asociado.  ¿Desea ' +&
//				'configurar las cantidades? ', question!, YesNo!)
//	If li_rtn = 1 Then
//		Parent.TriggerEvent ('ue_config_cant')
//	End If
//End If
end event

event dw_2::ue_modifica_precio;string ls_unian, ls_unidad_prod, ls_unidad_venta
long   ll_ucom, ll_mconvera, ll_mconverb, ll_cant_x_linea
double ld_precio, ld_descuento, ld_monto
long   ll_cantidad, ll_fraccion, ll_total, ll_devuelta, ll_devuelta_anterior

 ls_unian        = This.GetItemString(This.getrow(),"facd_unidad_venta")
 ls_unidad_prod  = This.GetItemString(This.getrow(),"facd_unidad_producto")
 ls_unidad_venta = This.GetItemString(This.getrow(),"facd_unidad_venta")
 ll_cantidad     = This.GetItemNumber(This.getrow(),"facd_cantidad")
 ld_precio       = double(this.Gettext())
 ll_fraccion = This.GetItemNumber(This.getrow(),"facd_cantidad_fraccion") 
// ld_precio   = This.GetItemNumber(This.getrow(),"facd_precio_unidad_producto") 
 ld_descuento= This.GetitemNumber(This.getrow(),"facd_por_descuento")
 ll_devuelta = This.GetitemNumber(This.getrow(),"facd_cant_devuelta")
 ll_devuelta_anterior = This.GetitemNumber(This.getrow(),"devuelta")
 if ib_modificacion then
	 ll_devuelta_anterior = This.GetitemNumber(This.getrow(),"devuelta_mod")
 end if
 ll_total	 = This.GetitemNumber(This.getrow(),"total")
 
  //Tipo de medida de la unidad del producto	(UNIDADES, UNIDAD DE PESO, CONVERSIONES, ETC)
  // Devuelve 10 en caso de que sea una medida
 ll_ucom = gf_medi_prod(ls_unidad_prod)
  
 //* Carga Los Datos de Converción de la Unidad Actual
 ll_mconvera = gf_unidad_venta(ls_unidad_venta, ll_ucom)
 
 if ll_mconvera = 0 or isnull(ll_mconvera) then
 	messagebox("ATENCIÓN SR. USUARIO", "Verifique las Unidades del Producto",Exclamation!)
	return 
 end if
 
ll_cant_x_linea = ll_mconvera * ll_cantidad + ll_fraccion   // cantidad a pedir
 
// messagebox("Totales", string(ll_total)+"  ,   "+string(ld_cant_x_linea))
 
ld_monto  =  (ld_precio * ll_cantidad) + ( ( ld_precio / ll_mconvera ) * ll_fraccion )
 
this.setitem(this.getrow(),"facd_monto_total",ld_monto)
 
if ld_descuento <> 0.00 then
	this.setitem(this.getrow(),"facd_monto_final",ld_monto - (ld_monto * (ld_descuento / 100) ))
else
 	this.setitem(this.getrow(),"facd_monto_final",ld_monto)
end if

this.setitem(this.getrow(),"facd_cant_devuelta",ll_cant_x_linea + ll_devuelta_anterior)
 
end event

event dw_2::itemchanged;Integer	li_linea, li_entero
Long 		ll_cantidad1, ll_cantidad2, ll_total, ll_fraccion, ll_total2,&
			ll_fraccion2, ll_can_devueltas
String 	ls_col, ls_unidad_prod, ls_unidad_venta, ls_icon, ls_filtro
Double 	ld_monto, ld_final, ld_suma, ld_cargos = 0

//this.accepttext()
ls_Col = This.GetColumnName()

//if not isvalid(m_fa_principal) then
//	w_fa_man_modi_devolucion.Changemenu(m_fa_principal)
//	wf_botones()
//end if

// Verificando que la cantidad recién introducida no sea menor de la cantidad
// asignada en el Desglose
//If dwo.name = "facd_cantidad"  Or  dwo.name = "facd_cantidad_fraccion" Then
//	If dwo.name = "facd_cantidad" Then 
//		li_entero 	 = integer (data)
//		ldc_fraccion = GetItemNumber (row, 'facd_cantidad_fraccion')
//	Else
//		li_entero    = GetItemNumber (row, 'facd_cantidad')
//		ldc_fraccion = dec (data)
//	End If
//		
//	ls_unidad_venta = GetItemString (row, 'facd_unidad_venta')
//	ld_monto		  	 = gf_conv_cantidad (li_entero, ldc_fraccion, 'C', ls_unidad_venta)
//	ls_filtro = 'dcdi_linea = ' + string (GetItemNumber (row, 'facd_linea_articulo_dev'))
//	If NOT iuo_desglose.Dynamic of_validar_cant (ls_filtro, dec(ld_monto)) Then 
//			
//		li_entero = MessageBox ("Cantidad No Válida", "La cantidad introducida es menor a la as" +&
//										"ignada en el Desglose del Renglón.  ~n¿Desea Ajustar las cantida" +&
//										"des del desglose? ", exclamation!, YesNo!)
//		If li_entero = 1 Then				 
//			str.frame.GetActiveSheet().PostEvent ("ue_config_cant")
//		Else
//			Return 2
//		End If
//		//SetItem (row, is_ca_cantidad, data)
//		//Return 2
//	End If
//End If 


choose case ls_col
		
	case "facd_cantidad"
		
		ll_cantidad1 	  = this.getitemnumber(this.getrow(),"cantidad") 	//Compute Primario
		ll_cantidad2 	  = integer(this.GetText ()) //Extrae el valor del Edit
		ll_total	 	 	  = This.Getitemnumber(This.getrow(),"total") 		//Total de Unidades
		ll_fraccion  	  = this.getitemnumber(this.getrow(),"facd_cantidad_fraccion") //Campo Primario
		ll_fraccion2 	  = this.getitemnumber(this.getrow(),"fraccion") 	//Compute Primario
		ld_monto		 	  = This.GetItemnumber(This.getrow(),"monto")  		//Monto y Monto Final por linea
		ld_final		 	  = This.GetItemnumber(This.getrow(),"monto_fin")
		ll_can_devueltas = This.GetItemNumber(This.getrow(),"devuelta") 	//Cantidad Devuelta
		
		//Calcula la cantidad total entre cantidad y fracciones en la funcion 
		//de la ventana de seleccion
		
		ll_total2 =	wf_cantidad_total(ll_cantidad2, ll_fraccion, this, row)
		
		if ib_modificacion = true then
			ll_can_devueltas = This.GetItemNumber(This.getrow(),"devuelta_mod") //cantidad devuelta
		end if																					  //en modificacion
		
	   if ll_total2 + ll_can_devueltas > ll_total then
			
		   //Funcion que setea los campos computes que son los originales y manda un mensaje			
		   wf_setea_originales(ll_cantidad1, ll_fraccion2, ld_monto, ld_final, this, this.Getrow(), ll_can_devueltas)
//			messagebox("Itemchange", string(ll_cantidad1)+ "  " +string(ll_fraccion))
		   this.trigger event ue_bultos(ll_cantidad1, ll_fraccion)
		   //asigna totales
			wf_totaliza()		  				
		   return 2
		else
		  triggerevent("ue_cantidad")	
		end if
		
		//Asigna los totales de la devolucion en el user event bultos, que recibe dos parametros		
		this.trigger event ue_bultos(ll_cantidad2, ll_fraccion)
		
		wf_totaliza()				
		
	case "facd_cantidad_fraccion"
		
		ll_fraccion2 = this.GetItemnumber(this.getrow(),"fraccion") //Compute Primario
		ll_fraccion  = integer(this.GetText ()) //Extrae el valor del Edit
		ll_cantidad2 = this.GetItemnumber(this.getrow(),"facd_cantidad") //Cantidad primaria
		ll_cantidad1 = this.GetItemnumber(this.getrow(),"cantidad") //Compute Primario		
		ld_monto		 = This.GetItemnumber(This.getrow(),"monto")
		ld_final		 = This.GetItemNumber(This.getrow(),"monto_fin")
		ll_can_devueltas = This.GetItemNumber(This.getrow(),"devuelta")

		//messagebox("Devueltas anteriores",ll_can_devueltas)
		ll_total	 = This.GetitemNumber(This.getrow(),"total")
		
		//Calcula la cantidad total entre cantidad y fracciones en la funcion de la ventana de seleccion
		ll_total2 =	wf_cantidad_total(ll_cantidad2, ll_fraccion, this, row)

		if ib_modificacion = true then
			ll_can_devueltas = This.GetItemNumber(This.getrow(),"devuelta_mod") //cantidad devuelta
		end if																					  //en modificacion	

		
	   if ll_total2 +  ll_can_devueltas > ll_total then
		  //Funcion que setea los campos computes que son los originales 	
		  wf_setea_originales(ll_cantidad1, ll_fraccion2, ld_monto, ld_final, this, this.Getrow(),ll_can_devueltas)
		  this.trigger event ue_bultos(ll_cantidad1, ll_fraccion)		  
			//asigna totales
			wf_totaliza()		  
		  return 2
		else
		  triggerevent("ue_fraccion")
		end if
		
		//Asigna los totales de la devolucion en el user event bultos, que recibe dos parametros		
		this.trigger event ue_bultos(ll_cantidad2, ll_fraccion)		
		//asigna totales
		wf_totaliza()
	
case "facd_precio_unidad_producto"
		  triggerevent("ue_modifica_precio")	
	//asigna totales
		wf_totaliza()
	end choose

end event

event dw_2::getfocus;call super::getfocus;//Para que cuando de enter en el DW 2 no abra la ventana de Seleccion
cb_incluir.default = false

//Valida que el menu sea valido, para poder modificarlo, (se deshabilita cuando se abre otra ventana)
//if not isvalid(m_fa_principal) then
//	parent.Changemenu(m_fa_principal)
//	wf_botones()
//end if

if dw_4.visible then
	dw_4.triggerevent("doubleclicked")
end if
end event

event dw_2::updatestart;//Para que setee los numeros de lineas al detalle de la devolucion
if this.rowcount() <> 0 then
  if (this.Getitemstring(this.getrow(),"facd_codigo_item") <> "" or &
	  isnull(this.Getitemstring(this.getrow(),"facd_codigo_item"))) then wf_setea_lineas()

////		Rutina que detecta cual es el campo que se le está seteando valor
//	integer cont
//	dwitemstatus l_status2
//	messagebox("validar ue_aceptar","valida")
//FOR cont =1 TO 46
//	l_status2 = this.GetItemStatus(this.getrow(),cont, Primary!)
//	if l_status2 <> NotModified! Then
//		
//	  messagebox("DW2 Te coji",cont)
//	end if	
//NEXT
end if
end event

event dw_2::editchanged;Integer		li_rtn
String		ls_bodega, ls_ubic, ls_data
//decimal ls_codigo

// Se habilita el boton de Guardar y se Deshabilita el de Imprimir
wf_control()

If dwo.name = 'facd_cantidad' Or dwo.name = 'facd_cantidad_fraccion' Then
	/*
	ls_bodega = string (Object.facd_bodega [row])
	ls_ubic	 = string (Object.facd_ubicacion [row])
	ls_codigo =	string (Object.facd_codigo_item [row])
	gf_fa_tiene_desglose (ls_bodega, ls_ubic, ls_codigo)
	*/
	CHOOSE CASE dwo.name
		CASE 'facd_cantidad'
			ls_data = string (GetItemNumber (row, 'facd_cantidad'))
			
		CASE 'facd_cantidad_fraccion' 
			ls_data = string (GetItemNumber (row, 'facd_cantidad_fraccion'))
	END CHOOSE
	
	Post Event ue_posteditchanged (row, dwo, ls_data)
End If



end event

event dw_2::retrieveend;//Se deben setear los valores totales de los articulos originales, de la factura
Double 	ld_monto, ld_final
Integer	li_linea
Long 		ll_linea, ll_cantidad, ll_fraccion, ll_devuelta, ll_total2, ll_cantidad_ori, &
		  	ll_fraccion_ori, ll_recorrido, ll_total1
String 	ls_codigo, ls_uni_venta, ls_uni_prod, ls_icon

for ll_recorrido = 1 to rowcount
//Recupero los datos de los artículos que ya fueron devueltos y cargo los campo computes
//de cantidades, totales, etc. para efectos de validación en el itemchanged poder restaurar
//los valores iniciales de los artículos.

ls_codigo = this.getitemstring(ll_recorrido,"facd_codigo_item")
ll_linea  = this.getitemnumber(ll_recorrido,"facd_linea_articulo_dev")
ll_cantidad_ori = this.getitemnumber(ll_recorrido,"facd_cantidad")
ll_fraccion_ori = this.getitemnumber(ll_recorrido,"facd_cantidad_fraccion")
ld_monto	 = This.GetItemnumber(ll_recorrido,"facd_monto_total")  // monto y monto final por linea
ld_final	 = This.GetItemnumber(ll_recorrido,"facd_monto_final")
this.Setitem(ll_recorrido,"monto",ld_monto)
this.Setitem(ll_recorrido,"linea",ll_linea)
this.Setitem(ll_recorrido,"monto_fin",ld_final)
this.Setitem(ll_recorrido,"cantidad",ll_cantidad_ori)
this.Setitem(ll_recorrido,"fraccion",ll_fraccion_ori)			
			
//Recupero los datos del pedido original para calcular la cantidad total vendida del producto.
  SELECT faddiari.facd_cantidad,
         faddiari.facd_cantidad_fraccion,   
         faddiari.facd_monto_total,   
         faddiari.facd_monto_final,   
         faddiari.facd_cant_devuelta  
    INTO :ll_cantidad,   
         :ll_fraccion,   
         :ld_monto,   
         :ld_final,   
         :ll_devuelta  
    FROM faddiari  
   WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
         ( faddiari.facd_empresa = :str.empresa ) AND  
         ( faddiari.facd_tipo = :is_tipo_fac ) AND  
         ( faddiari.facd_no_pedido = :is_pedido ) AND  
			( faddiari.facd_codigo_item = :ls_codigo ) AND  
         ( faddiari.facd_linea = :ll_linea ) AND  
         ( faddiari.facd_ann = :ii_ann )  ;
	
	if sqlca.sqlcode = -1 then
		gf_mensaje("","Error al Seleccionar de Faddiari "+sqlca.sqlerrtext,1,1,"E")
	end if	

	//Calcula la cantidad total entre cantidad y fracciones en la funcion 	
	//de la ventana de seleccion
	ll_total2 =	wf_cantidad_total(ll_cantidad, ll_fraccion, this, ll_recorrido)
	ll_total1 =	wf_cantidad_total(ll_cantidad_ori, ll_fraccion_ori, this, ll_recorrido)
	
	this.Setitem(ll_recorrido,"total",ll_total2)			
	this.Setitem(ll_recorrido,"devuelta",ll_devuelta)
	this.Setitem(ll_recorrido,"devuelta_mod", ll_devuelta - ll_total1)
	//setea al campo que protege el precio
	This.Setitem(ll_recorrido,"mod_precio",il_modifica)
	this.ResetUpdate() //Para que no Pregunte por los cambios realizados
	ib_modificacion = true
next

// Realizando RETRIEVE al Desglose
iuo_desglose.Retrieve (str.g_financiero,str.empresa, is_pedido/*,is_tipo_fac*/,ii_ann)

// Se debe Setear la imagen en el campo de DESGLOSE de cada Renglón, 
// la cual indica si tiene o no DESGLOSE
ls_icon 		= str.path + 'art/desglose_s.bmp'
For ll_recorrido = 1 To rowcount
	li_linea = GetItemNumber (ll_recorrido, "facd_linea_articulo_dev")
	//MessageBox (string(li_linea), string(iuo_desglose.Dynamic of_tienedesglose (li_linea, "dcdi_linea") ))
	If iuo_desglose.Dynamic of_tienedesglose (li_linea, "dcdi_linea") Then
		SetItem (ll_recorrido, "desglose", ls_icon)
	Else
		SetItem (ll_recorrido, "desglose", '')
	End If
Next

end event

event dw_2::micro;//String		ls_objeto, ls_row, ls_producto
//Integer		li_row
//
////Para ocultar el mensaje de los cargos
//st_microhelp.Visible = false
//
//ls_objeto = GetObjectAtPointer ()
//ls_row	 = Right (ls_objeto, Len (ls_objeto) - Pos (ls_objeto, '~t'))
//ls_objeto = Left (ls_objeto, Pos (ls_objeto, '~t') - 1)
//
//li_row = integer (ls_row)
//st_6.Text = ls_row + ' ' + ls_objeto + ' image ' //+ GetItemString (1, 'desglose')
//If is_column = ls_objeto Then Return
//
//is_column = lower (ls_objeto)
//
//// Desplegando mensaje en el MicroHelp si tiene imagen de DESGLOSE
//If NOT (ls_objeto = 'facd_cantidad' Or ls_objeto = 'facd_cantidad_fraccion' Or &
//    	  ls_objeto = 'facd_cant_devuelta')  Then 
//	str.frame.SetMicroHelp ('')		
//	Return
//End If
//
//If Len (GetItemString (li_row, 'desglose')) > 5 Then
//	str.frame.SetMicroHelp ('Dobleclic para devolver desglose')
//Else
//	str.frame.SetMicroHelp ('')
//End If
//
end event

event dw_2::doubleclicked;call super::doubleclicked;// Haciendo el llamado al evento ue_cantidad si la Línea posee Desglose Asociado.
// Para verificar si tiene Desglose asociado se utiliza el campo de la imagen de DESGLOSE
//If Len (GetItemString (row, 'desglose')) > 5 And & 
//	(dwo.name = 'facd_cantidad_fraccion' Or dwo.name = 'facd_cantidad' Or &
//	 dwo.name = 'facd_cant_devuelta') Then
//	str.frame.GetActiveSheet().TriggerEvent ('ue_config_cant')
//End If

cb_incluir.enabled = true
end event

event dw_2::clicked;call super::clicked;dw_actual=this
end event

type dw_1 from w_fa_padre_maest_det`dw_1 within w_fa_man_modi_devolucion
event ue_down pbm_dwnkey
integer x = 23
integer y = 52
integer width = 3173
integer height = 480
integer taborder = 0
string dataobject = "dw_ma_fa_tdevol_modi"
boolean vscrollbar = false
end type

event dw_1::ue_down;// Toma el Número de Proforma si es que el usuario seleccionó alguno
String  ls_retorno, ls_pedi, ls_tipo_fac
integer li_pormayor , li_pos, li_pos2
long	  ll_an

//Para que avance en el enter
choose case key
	CASE	  Keyenter! 
		this.Setcolumn(37)
	CASE    KeyF1! 

 if This.GetColumnName()	= "fact_no_pedido" then
  //Llamado de la ventana de búsqueda
	OpenWithParm(w_fa_co_facturas, "Modi_devolucion")

	ls_retorno = Message.StringParm		

	li_pos = pos(ls_retorno,"=",1)		// Posición donde inicia el "="

	li_pos2 = pos(ls_retorno,"_",li_pos)// Posición donde inicia el "_"

	ls_pedi = left(ls_retorno,li_pos - 1)	// Extrae el número del pedido

	ls_tipo_fac= mid(ls_retorno,li_pos + 1,li_pos2 - (li_pos + 1))  //Extrae si es por mayor o menor

	ll_an		=	integer(mid(ls_retorno,li_pos2 + 1))


	If ls_pedi <> "" Then 	
		is_pedido = ls_pedi			// Pedido
		is_tipo_fac = ls_tipo_fac	// Tipo factura
		ii_ann			= ll_an
		this.Setitem(this.getrow(),"fact_no_pedido",is_pedido)
		this.Setitem(this.getrow(),"fact_tipo",is_tipo_fac)
		this.Setitem(this.getrow(),"fact_ann",ii_ann)
		
		dw_1.Setfocus()
		dw_1.Setcolumn(4)
		this.triggerevent("itemchanged")
	end if		
  end if
end choose		
end event

event dw_1::itemchanged;long ll_recuperados, ll_pos
integer li_respuesta, li_bultos, li_existe
string ls_factura, ls_pedido, ls_columna
decimal ld_cargos, ld_suma
//Inicializa la bandera para que recorra una sola vez buscando la linea en blanco para eliminarla
 //m_fa_padre.m_edicin.m_eliminar.enabled = true
this.accepttext()
ls_columna = dw_1.Getcolumnname()

//Valida que el menu sea valido, para poder modificarlo, (se deshabilita cuando se abre otra ventana)
//if not isvalid(m_fa_principal) then
//	parent.Changemenu(m_fa_principal)
//	wf_botones()
//end if

choose case ls_columna
	case	"fact_tipo"				
//		is_tipo_fac = data
		m_fa_padre.m_archivo.m_guardar.enabled = true
	case	"fact_no_pedido"

		this.setredraw(false) //fatdiari_fact_tipo
//		is_pedido_nc = dw_1.getitemstring(dw_1.getrow(),"fact_no_pedido")
		is_pedido_nc = chdw_dev_pedido.getitemstring(chdw_dev_pedido.getrow(),"fact_no_pedido")
		is_tipo_fac  = chdw_dev_pedido.getitemstring(chdw_dev_pedido.getrow(),"fatdiari_fact_tipo")
		ii_ann		 = chdw_dev_pedido.getitemNumber(chdw_dev_pedido.getrow(),"fact_ann")
		ii_flag = 0

		parent.setredraw(false)
		
		is_pedido = is_pedido_nc
		
		if Match(is_pedido, "NC") then
			ll_recuperados = wf_recupera("N")
			ll_pos = pos(is_pedido,"N")
			is_pedido = left(is_pedido,ll_pos - 1)
		   cb_incluir.enabled = true     //Habilito el boton de incluir articulo			
			//Carga la estructura para recuperar el pedido en la ventana de seleccion
			str_argumen.pedido   = is_pedido
			str_argumen.pedido2  = is_pedido_nc
			str_argumen.tipo		= is_tipo_fac
		 	str_argumen.an       = ii_ann
			ib_modificacion = true
		else
			//ib_modificacion = false			
			ib_modificacion = true			
			ll_recuperados = wf_recupera("S")
		end if
		
		if ll_recuperados = 0 then
			if li_primera_vez = 0 then		
				li_primera_vez = 1
			else
				messagebox("ATENCIÓN SR. USUARIO","No Existe, se Eliminó o no  se ha Impreso, verifique los Datos",Exclamation!)	
			end if
			dw_2.reset()	
			dw_2.scrolltorow(dw_2.insertrow(0))
			wf_blanquea_totales()
			dw_1.setfocus()
			dw_1.postevent("getfocus")
			dw_1.reset()		
			ib_cual_dw = true	//Para que pueda adicionar en el DW 1
			parent.triggerevent("ue_adicionar")
			wf_control2()
			cb_incluir.enabled = false
		else
			if not Match(is_pedido_nc, "NC") then
				
				//Verifica si existe o no el pedido y le concatena "NC" o "NC2"
				is_pedido_nc = wf_asigna_pedido(is_pedido)				
							
				//Recupera en el DataStore y mueve al DataWindow del encabezado				
				
				ids_enca.retrieve(str.g_financiero, str.empresa, is_tipo_fac,is_pedido, ii_ann) //, is_tipo_fac)

				ls_factura = ids_enca.getitemstring(ids_enca.getrow(),"fact_no_factura")

				ids_enca.setitem(ids_enca.getrow(),"fact_referencia_fac",ls_factura)
				ids_enca.setitem(ids_enca.getrow(),"fact_no_factura","0")
				ids_enca.setitem(ids_enca.getrow(),"fact_estado","A")
				ids_enca.setitem(ids_enca.getrow(),"fact_act_cliente",0)
				ids_enca.setitem(ids_enca.getrow(),"fact_act_inventario",0)
				ids_enca.setitem(ids_enca.getrow(),"fact_act_conta",0)
				ids_enca.setitem(ids_enca.getrow(),"fact_no_pedido",is_pedido_nc)
				ids_enca.setitem(ids_enca.getrow(),"fact_ann", w_fa_fondo.str_para.ano)
				
				//Para crear el registro de los vendedores
				
				
				//Mueve el encabezado de la factura
				dw_1.reset()
				ids_enca.RowsMove(1,1,Primary!,dw_1,1,Primary!)
				
				parent.Setredraw(true)
				
				//Para que se vaya directo a devolucion parcial, si ya hay otra devolucion
				//para el pedido
				
				SELECT count(*)
			   INTO :li_existe
			   FROM fatdiari
			   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND
			         ( fatdiari.fact_empresa = :str.empresa ) AND
			         ( fatdiari.fact_tipo = :is_tipo_fac ) AND
			         ( fatdiari.fact_no_pedido = :is_pedido + "NC" ) AND
			         ( fatdiari.fact_ann = :ii_ann ) ;
						
				if sqlca.sqlcode = -1 then
					gf_mensaje("","Error al Verificar Existencia en Faddiari "+sqlca.sqlerrtext,1,1,"E")
				end if
	
				if li_existe > 0 then
				// Match(is_pedido_nc, "NC")					
					li_respuesta = 2				
				else				
					li_respuesta = messagebox("ATENCIÓN SR. USUARIO","¿La devolución es Total?",Question!,yesno!,1)
				end if
		
				if  li_respuesta = 1 then
					 cb_incluir.enabled = false
					 //codigo que estaba en el ue_post
					 dw_2.SetRedraw(False)
					 dw_2.Reset()
					 wf_blanquea_totales()
					 wf_busca_detalle()
					 //Asigna los totales de la devolucion
					 if dw_2.Rowcount() > 0 then 
						wf_totaliza()
					   //Devuelve el total de los cargos
					 	ld_cargos = wf_calcula_cargos(dw_2, ld_suma, li_bultos)
					 end if
					
				 	 wf_desg_dev_total()
					 dw_2.SetRedraw(True)
					 m_fa_principal.m_archivo.m_guardar.enabled	= True
				else
					 dw_2.reset()
					 //Inserta una Linea
				    dw_2.scrolltorow(dw_2.insertrow(0))
					 //Blanque los Totales del Encabezado
					 dw_1.setitem(dw_1.Getrow(),"fact_monto_final",0)
					 dw_1.setitem(dw_1.Getrow(),"fact_monto_fact_total",0) 					 
					 dw_1.setitem(dw_1.Getrow(),"fact_gastos_total",0) 					 
					 dw_1.setitem(dw_1.Getrow(),"fact_cubicaje_total",0) 					 
					 dw_1.setitem(dw_1.Getrow(),"fact_peso_total",0) 					 
					 
					 //Limpia los totales
					 wf_blanquea_totales()
					 //Para poder modificar las cantidades
					 dw_2.Modify("facd_cantidad.Edit.DisplayOnly=no")
					 dw_2.Modify("facd_cantidad_fraccion.Edit.DisplayOnly=no")
					 //Carga la estructura para recuperar el pedido en la ventana de seleccion
					 str_argumen.pedido   = is_pedido
					 str_argumen.pedido2  = is_pedido_nc
					 str_argumen.tipo		 = is_tipo_fac
					 str_argumen.an       = ii_ann

					 //Devuelve el total de los cargos
					 ld_cargos = wf_calcula_cargos(dw_2, ld_suma, li_bultos)
					 dw_1.setitem(dw_1.Getrow(),"fact_gastos_total",ld_cargos) 					 					 
					 em_cargos.text = string(ld_cargos)
					 
					 //Habilita el boton de incluir productos		
					 cb_incluir.enabled = true
					 cb_incluir.Setfocus()			
					 
				end if
			 	//Habilitar boton de eliminar y adicionar
				 m_fa_padre.m_edicin.m_eliminar.enabled = true
				 m_fa_padre.m_edicin.m_adicionar.enabled = false		 
				//Habilita el guardar
				
				
				 
			else //del ls_pedido <> "NC"
				//				MODIFICACIONES
				dw_1.retrieve(str.g_financiero, str.empresa,is_tipo_fac, is_pedido_nc, ii_ann) //, is_tipo_fac)
				ll_recuperados = dw_2.Retrieve(str.g_financiero, str.empresa,is_tipo_fac,is_pedido_nc, ii_ann) //, is_tipo_fac)
			   if ll_recuperados > 0 then wf_totaliza()
				//Recupera el total de los cargos
	 			dw_4.Retrieve(str.g_financiero, str.empresa,is_tipo_fac, is_pedido_nc, ii_ann)
				
				//Si el estado es activa, que pueda eliminarla
				if dw_1.Getitemstring(dw_1.getrow(),"fact_estado") = "A" then
					m_fa_padre.m_edicin.m_eliminar.enabled  = true
					m_fa_padre.m_edicin.m_adicionar.enabled  = false
				   m_fa_padre.m_archivo.m_imprimir.enabled = true
				else
					wf_protege()
					cb_incluir.enabled = false	
				end if	
				str.frame.Setmicrohelp("Devolución Existente")
			end if
		end if
		parent.setredraw(true)
		this.setredraw(true)
end choose
end event

event dw_1::ue_post;//no borrar
end event

event dw_1::getfocus;//no borrar
ib_cual_dw = true
wf_set_dw_current(ib_cual_dw)
cb_incluir.default = true

//Valida que el menu sea valido, para poder modificarlo, (se deshabilita cuando se abre otra ventana)
//if not isvalid(m_fa_principal) then
//	parent.Changemenu(m_fa_principal)
//	wf_botones()
//end if

if dw_4.visible then
	dw_4.triggerevent("doubleclicked")
end if
end event

event dw_1::clicked;// override
dw_actual=this
end event

event dw_1::doubleclicked;// override
end event

event dw_1::micro;//No borrar
//Para ocultar el mensaje de los cargos
//st_microhelp.Visible = false
//
end event

event dw_1::editchanged;call super::editchanged;//Se habilita el boton de Guardar y se Deshabilita el de Imprimir
wf_control()
end event

event dw_1::itemfocuschanged;DwItemStatus ls_estatus1, ls_estatus2
string ls_campo

//Función que muestra el significado del campo en la barra de abajo
gf_micro_ayuda(dw_1)

ls_campo = dw_1.GetColumnName()

CHOOSE CASE ls_campo
	CASE "fact_no_pedido"

		if dw_2.Rowcount() > 0 Then
//		 if dw_2.getitemstring(1,"facd_codigo_item")	<> ""	and &
//		 	 not isnull(dw_2.getitemstring(1,"facd_codigo_item")) then
			  
			/*ls_estatus1 = dw_1.GetItemStatus(dw_1.Getrow(),0,primary!)
			ls_estatus2 = dw_2.GetItemStatus(dw_2.Getrow(),0,primary!)			
		
			If (ls_estatus1 = DataModified!) or (ls_estatus1 = Newmodified!) or & 
				(ls_estatus2 = DataModified!) or (ls_estatus2 = Newmodified!) then
				wf_valida_todo(1)
			end if*/
//		 end if 	
		end if
end choose		
end event

type sle_con from w_fa_padre_maest_det`sle_con within w_fa_man_modi_devolucion
boolean visible = false
integer x = 2226
integer y = 1276
integer taborder = 70
end type

type ddplb_1 from w_fa_padre_maest_det`ddplb_1 within w_fa_man_modi_devolucion
boolean visible = false
integer x = 1787
integer y = 1300
integer taborder = 10
end type

type gb_2 from w_fa_padre_maest_det`gb_2 within w_fa_man_modi_devolucion
integer x = 14
integer y = 580
integer width = 3205
integer height = 516
integer taborder = 0
integer weight = 700
long textcolor = 8388608
string text = "Detalle de la Devolución"
end type

type gb_1 from w_fa_padre_maest_det`gb_1 within w_fa_man_modi_devolucion
integer x = 9
integer y = 4
integer width = 3205
integer height = 548
integer taborder = 0
integer weight = 700
long textcolor = 8388608
string text = "Generales de la Devolución"
end type

type em_ann from editmask within w_fa_man_modi_devolucion
integer x = 901
integer y = 132
integer width = 197
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#,##0"
string displaydata = "¼„ssmgrupusemp"
end type

event modified;//Asigno el año a la variable de instancia
ii_ann = integer(em_ann.text)
parent.sle_pedido.postevent("modified")
end event

type sle_pedido from singlelineedit within w_fa_man_modi_devolucion
boolean visible = false
integer x = 2007
integer y = 1284
integer width = 247
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
integer limit = 10
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

event modified;long ll_recuperados
integer li_respuesta, li_bultos
string ls_factura, ls_pedido
double ld_cargos, ld_suma
//Inicializa la bandera para que recorra una sola vez buscando la linea en blanco para eliminarla

	ii_flag = 0
		
		parent.setredraw(false)
		
		is_pedido = sle_pedido.text
		
		if Match(is_pedido, "NC") then
			ll_recuperados = wf_recupera("N")
		else
			ll_recuperados = wf_recupera("S")
		end if
		
		if ll_recuperados = 0 then
			messagebox("ATENCIÓN SR. USUARIO","No Existe, se Eliminó o no  se ha Impreso, verifique los Datos",Exclamation!)	
			dw_2.reset()	
			dw_2.scrolltorow(dw_2.insertrow(0))
			em_total.text = "0" 
			em_final.text = "0"
			em_cargos.text = "0"
			dw_1.setfocus()
			dw_1.postevent("getfocus")
			dw_1.reset()		
			sle_pedido.Setfocus()
			ib_cual_dw = true	//Para que pueda adicionar en el DW 1
			parent.triggerevent("ue_adicionar")
			m_fa_padre.m_archivo.m_guardar.enabled = false
		   m_fa_padre.m_archivo.m_imprimir.enabled = false
			cb_incluir.enabled = false
		else
			//Concatena NC al numero de pedido introducido
//			messagebox("Pedidos",ls_pedido)
			
			if not Match(sle_pedido.text, "NC") then

				//Verifica si existe o no el pedido y le concatena "NC" o "NC2"
				sle_pedido.text = wf_asigna_pedido(is_pedido)
				
				//Recupera en el DataStore y mueve al DataWindow del encabezado
				ids_enca.retrieve(str.g_financiero, str.empresa,is_tipo_fac, is_pedido, ii_ann)//, is_tipo_fac)

				ls_factura = ids_enca.getitemstring(ids_enca.getrow(),"fact_no_factura")

				ids_enca.setitem(ids_enca.getrow(),"fact_referencia_fac",ls_factura)
				ids_enca.setitem(ids_enca.getrow(),"fact_no_factura","0")
				ids_enca.setitem(ids_enca.getrow(),"fact_estado","A")
				ids_enca.setitem(ids_enca.getrow(),"fact_act_cliente",0)
				ids_enca.setitem(ids_enca.getrow(),"fact_act_inventario",0)
				ids_enca.setitem(ids_enca.getrow(),"fact_act_conta",0)		
				ids_enca.setitem(ids_enca.getrow(),"fact_no_pedido",sle_pedido.text)
			
				ids_enca.RowsMove(1,1,Primary!,dw_1,1,Primary!)
				parent.Setredraw(true)
				
				//Para que se vaya directo a devolucion parcial, si ya hay otra devolucion
				//para el pedido
				if right(sle_pedido.text,1) <> "C" then
					
					li_respuesta = 2
				
				else
				
					li_respuesta = messagebox("ATENCIÓN SR. USUARIO","¿La devolución es Total?",Question!,yesno!,1)
				
				end if
		
				if  li_respuesta = 1 then
					 cb_incluir.enabled = false
					 //codigo que estaba en el ue_post
					 dw_2.SetRedraw(False)
					 dw_2.Reset()
					 em_total.text = "0" 
 					 em_final.text = "0"
					 em_cargos.text = "0"					 
					 wf_busca_detalle()
					 //Asigna los totales de la devolucion	
					 wf_totaliza()
					 wf_desg_dev_total ()
					 dw_2.SetRedraw(True)
				else
					 dw_2.reset()	
				    dw_2.scrolltorow(dw_2.insertrow(0))
					 em_total.text = "0" 
		 			 em_final.text = "0"
		 			 em_cargos.text = "0"					 
					 //Habilitar boton de eliminar		
					 m_fa_padre.m_edicin.m_eliminar.enabled = true
					 //Para poder modificar las cantidades
					 dw_2.Modify("facd_cantidad.Edit.DisplayOnly=no")	
					 dw_2.Modify("facd_cantidad_fraccion.Edit.DisplayOnly=no")		
					 //Carga la estructura para recuperar el pedido en la ventana de seleccion
					 str_argumen.pedido   = is_pedido
					 str_argumen.pedido2  = sle_pedido.text
					 str_argumen.tipo= is_tipo_fac
					 str_argumen.an       = ii_ann

					//Habilita el boton de incluir productos					
					cb_incluir.enabled = true
					cb_incluir.Setfocus()
					
				end if	
				//Habilita el guardar
				m_fa_padre.m_archivo.m_guardar.enabled = true
			else //del ls_pedido <> "NC"
				dw_1.retrieve(str.g_financiero, str.empresa,is_tipo_fac, is_pedido, ii_ann)//, is_tipo_fac)
				dw_2.Retrieve(str.g_financiero, str.empresa, is_tipo_fac,is_pedido, ii_ann)//, is_tipo_fac)
				str.frame.Setmicrohelp("Devolución Existente")
			end if
		end if
		parent.setredraw(true)
		
end event

event getfocus;//Para que se marque el DW 1
dw_1.postevent("getfocus")

end event

type cb_incluir from commandbutton within w_fa_man_modi_devolucion
integer x = 2656
integer y = 396
integer width = 462
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Incluir Producto"
boolean default = true
end type

event clicked;
wf_carga_cadena()

openwithparm(w_fa_man_modi_devol_art,str_argumen, parent) 

dw_2.Setfocus()
end event

event getfocus;//Elimina el Blanco del Datawindow Dos
double ld_suma, ld_cargos = 0

if dw_2.rowcount() > 1 and ii_flag = 0 then wf_elimina_blanco()

if dw_2.rowcount() > 0  then
  if dw_2.getitemstring(1,"facd_codigo_item") <> ""  and not &
  		isnull(dw_2.getitemstring(1,"facd_codigo_item")) then	

	wf_totaliza()
	
	m_fa_padre.m_archivo.m_guardar.enabled = true
  end if	
end if
end event

type gb_3 from groupbox within w_fa_man_modi_devolucion
integer x = 9
integer y = 1096
integer width = 3205
integer height = 156
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79416533
string text = "Totales"
end type

type em_total from editmask within w_fa_man_modi_devolucion
integer x = 686
integer y = 1148
integer width = 384
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
string mask = "$#,###,##0.00"
string displaydata = ""
end type

event modified;	m_fa_padre.m_archivo.m_guardar.enabled = true
end event

type em_cargos from editmask within w_fa_man_modi_devolucion
event ue_microhelp pbm_nchittest
integer x = 1335
integer y = 1148
integer width = 384
integer height = 76
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
string mask = "$#,###,##0.00"
end type

event ue_microhelp;//Para mostrare el mensaje de cambiar los cargos.
//   if dw_4.visible 			then return   //si esta en el dw de los cargos, retorna
//	If st_microhelp.Visible Then Return	  //si ya está visible retorna
//	st_microhelp.Visible = TRUE
//
end event

event rbuttondown;dw_4.visible = true
dw_4.setfocus()

//Para ocultar el mensaje de los cargos
st_microhelp.Visible = false

//Para que no salga la lista de copiar, pegar, seleccionar todo, etc
return 2
end event

event losefocus;st_microhelp.Visible = false
end event

type em_final from editmask within w_fa_man_modi_devolucion
integer x = 2802
integer y = 1148
integer width = 384
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
string mask = "$#,###,##0.00"
string displaydata = ""
end type

type st_1 from statictext within w_fa_man_modi_devolucion
integer x = 430
integer y = 1160
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
boolean enabled = false
string text = "Subtotal:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_fa_man_modi_devolucion
integer x = 2551
integer y = 1160
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
boolean enabled = false
string text = "Total Final:"
alignment alignment = right!
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_fa_man_modi_devolucion
boolean visible = false
integer x = 1093
integer y = 1144
integer width = 247
integer height = 88
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargos:"
alignment htextalign = right!
end type

event clicked;//Ventana que llama a la ventana de cargos
double ld_cargos

str_fa_cargo_fac l_str		//Defino una variable tipo estructura

l_str.pedido = is_pedido
l_str.monto = dw_1.getitemnumber&
             (dw_1.getrow(),"fact_monto_fact_total")
				 
l_str.bultos = dw_1.getitemnumber&
             (dw_1.getrow(),"fact_bultos_total")

l_str.tipo = is_tipo_fac

l_str.estado = dw_1.getitemstring(dw_1.getrow(),"fact_estado")

l_str.an		 = ii_ann

//Abre la ventana de cargos, que a su vez llama una funcion que recalcula el monto final

if is_pedido <> "0" and not isnull(is_pedido) and trim(is_pedido) <> "" then

	OpenWithParm(w_fa_man_dev_carn, l_str)
	
end if
end event

type st_2 from statictext within w_fa_man_modi_devolucion
integer x = 1088
integer y = 1152
integer width = 247
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
boolean enabled = false
string text = "Cargos:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within w_fa_man_modi_devolucion
integer x = 1829
integer y = 1160
integer width = 261
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
boolean enabled = false
string text = "Descuento:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_desc from editmask within w_fa_man_modi_devolucion
integer x = 2089
integer y = 1148
integer width = 384
integer height = 76
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "$#,###,##0.00"
end type

event modified;//Ejecuta la función que ajusta * recalcula los totales, segun la modificacion del descuento

if id_desc = double(mid(em_desc.text,2)) then return

if gf_mensaje("","La Configuración del Descuento Cambiará, Está seguro.. ?",2,1,"E") = 1 then
	wf_ajusta_totales()
	dw_1.Setitem(dw_1.Getrow(),"fact_descuento_subt_deta","F")
	dw_1.Setitem(dw_1.Getrow(),"fact_por_descuento",double(mid(em_desc.text,2)))
else
	wf_calcula_desc(double(mid(em_total.text,2)))
end if
end event

type st_6 from statictext within w_fa_man_modi_devolucion
boolean visible = false
integer x = 1632
integer y = 1256
integer width = 1449
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 65535
boolean enabled = false
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_fa_man_modi_devolucion
boolean visible = false
integer x = 2071
integer y = 1260
integer width = 608
integer height = 64
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "DESGLOSE DATA"
end type

event clicked;//MessageBox ('DESGLOSE DATA',iuo_desglose.Describe ('DataWindow.Data'))
end event

type dw_4 from datawindow within w_fa_man_modi_devolucion
event ue_post_item ( long row,  dwobject dwo,  string data )
boolean visible = false
integer x = 1010
integer y = 724
integer width = 1093
integer height = 360
integer taborder = 100
boolean bringtotop = true
string dataobject = "dw_ma_fa_cardevol_modi"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_post_item;//Post item
double ld_cargos

ld_cargos = this.getitemnumber(1,"suma")

em_cargos.text = string(ld_cargos)

dw_1.setitem(dw_1.getrow(),"fact_gastos_total",ld_cargos)

wf_ajusta_totales()

m_fa_padre.m_archivo.m_guardar.enabled = true
end event

event doubleclicked;//Para ocultar el dw y devolver el valor ajustado

//wf_ajusta_totales()
//
//em_cargos.setfocus()
//
//dw_4.visible = false
end event

event itemchanged;//Llama el post del itemchanged

this.post event ue_post_item(row, dwo, data)
end event

type st_microhelp from statictext within w_fa_man_modi_devolucion
boolean visible = false
integer x = 1783
integer y = 1064
integer width = 997
integer height = 132
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15793151
boolean enabled = false
string text = "Haga click con el boton derecho del mouse para configurar los Cargos"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_fa_man_modi_devolucion
boolean visible = false
integer x = 434
integer y = 668
integer width = 2510
integer height = 680
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type em_fecha from editmask within w_fa_man_modi_devolucion
boolean visible = false
integer x = 1559
integer y = 300
integer width = 279
integer height = 68
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

