//objectcomments Ventana de captura de Saldas de movimiento Comercial
forward
global type w_ca_tz_salidas from w_grampa_tab
end type
type dw_4 from datawindow within tabpage_1
end type
type cb_procesar from commandbutton within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type cbx_varianza from checkbox within tabpage_1
end type
type cbx_1 from checkbox within tabpage_3
end type
type cbx_2 from checkbox within tabpage_3
end type
type st_1 from statictext within w_ca_tz_salidas
end type
type sle_nom_ventana from singlelineedit within w_ca_tz_salidas
end type
type gb_nom_ventana from groupbox within w_ca_tz_salidas
end type
type st_nom_ventana from statictext within w_ca_tz_salidas
end type
type dw_5 from datawindow within w_ca_tz_salidas
end type
end forward

global type w_ca_tz_salidas from w_grampa_tab
integer width = 3337
integer height = 2092
string title = "Captura de Salida Comercial"
string menuname = "m_fa_principal"
boolean maxbox = false
event ue_tab ( )
event ue_rules ( )
event ue_zoom ( )
event type integer ue_valida_salvado ( )
event ue_reimprimir_pagina ( )
st_1 st_1
sle_nom_ventana sle_nom_ventana
gb_nom_ventana gb_nom_ventana
st_nom_ventana st_nom_ventana
dw_5 dw_5
end type
global w_ca_tz_salidas w_ca_tz_salidas

type prototypes
Function long PPrtr  (long hhWnd, long ppSelection, &
      long PPNewValue, long ppAction) Library "PPRTR32.DLL"

Function long PPGetSizes (ref long iPaperX, ref long iPaperY, &
      ref long iPageX, ref long iPageY, ref long iPageLeft, ref long iPageTop, &
      ref long iPixInX, ref long iPixInY) Library "PPRTR32.DLL"

end prototypes

type variables
datawindowchild dwc_pais_d,dwc_puerto_d, dwc_trasporte
datawindowchild dwc_puerto_trasb,dwc_puerto_salida

datawindowchild dwc_pais_o,dwc_puerto_o,dwc_puerto_entrada

datawindowchild dch_unidad,&
dch_ped,dch_producto,dwc,dwc_arancel,dwc_arancel2
datawindow dw

/*Declaracion de campos a utilizar en toda la ventana*/
integer   ii_fac_igual_pedido, ii_number,ii_boton, ii_first_time  ,ii_anio_recupera, &
              ii_pages,ii_an,ii_pais,ii_num_pais,ii_clave_cia, ii_secuencia,ii_contador, ii_anio_fact

Long     il_ucom, il_rows, is_deleted,il_filas,il_recalcular, il_rowcount
Double  id_monto,id_final,id_cuben,&
             id_cubde, id_peso, id_cliente,id_cantidad,id_fraccion,id_selec
decimal id_porcentaje,id_mconver

string     is_item,is_pedido,is_unian,is_tipo_venta,is_unidad_peso,is_pais,is_factura
string     is_guardando,is_procede,is_busca_factura,is_valida_ped,is_pedido_fac
string     is_li_actu,is_li_ant,is_ruc, is_prod_ok,is_arancel,is_ent_sal,is_campo
string  is_valida,is_secuencia,is_nuevo, is_columna,is_producto,is_secuencia_nueva,&
          is_act_secuencia,documento[],is_impr_actual,is_fob_cif, is_win9598_winnt, is_dw
u_external_function   iu_externa
str_tz_documentos str_tz_doctos
end variables

forward prototypes
public subroutine wf_setear_lineas ()
public subroutine wf_elimina ()
public function integer wf_existe ()
public subroutine wf_valida_rowchange ()
public function integer wf_max_ped ()
public subroutine wf_actualiza_secuencia ()
public subroutine wf_botones ()
public subroutine wf_valida_bultos ()
public subroutine wf_filtra_pais ()
public subroutine wf_activa_titulos ()
public subroutine wf_desactiva_titulos ()
public subroutine wf_centrar ()
public subroutine wf_habilita_objetos (boolean integrado)
public function string wf_busca_pedido (long ll_max)
public subroutine wf_salvar ()
public subroutine wf_setea_encabezado ()
public subroutine wf_convierte_cantidad (string ls_unian, double ld_total_piezas)
public subroutine wf_oculta_lineas ()
public subroutine wf_oculta_totales ()
public subroutine wf_parametros ()
public subroutine wf_borrar_detalle ()
public subroutine wf_valida_exist_detalle ()
public subroutine wf_resumir_facturas ()
public function integer wf_busca_deta_ent (integer ii_lineas)
end prototypes

event ue_rules;call super::ue_rules;//Si el DW de impresion tiene un datawindow asignado
datawindow ldw_3
ldw_3 = tab_1.tabpage_3.dw_3

if ldw_3.DataObject <> "" then

	if ldw_3.object.datawindow.print.preview.rulers = 'yes' then
		ldw_3.object.datawindow.print.preview.rulers = 'no'
	else
		ldw_3.object.datawindow.print.preview.rulers = 'yes'
	end if	

end if


end event

event ue_zoom;call super::ue_zoom;openwithparm(w_zoom, tab_1.tabpage_3.dw_3)
end event

event ue_valida_salvado;Datawindow ldw_1,ldw_2
Integer	respuesta

ldw_1 = tab_1.tabpage_1.dw_1
ldw_2 = tab_1.tabpage_2.dw_2

If (ldw_2.ModifiedCount( ) + ldw_2.deletedcount() > 0) or &
	 (ldw_1.ModifiedCount( ) + ldw_1.deletedcount() > 0)  then

		respuesta = messagebox("Atención","La Información del Documento no ha sido guardado!  ~n" + &
		                       "     ... Desea guardarla ahora?",question!,YesNoCancel!) 
		choose case respuesta 
			case 1 
				this.triggerevent("ue_aceptar") 
			case 2
				ROLLBACK using sqlca; 	
		   case 3
				return 1 	
		end choose
end if
return 0
end event

event ue_reimprimir_pagina;Integer	li_lineas
Datawindow ldw_3

	wf_desactiva_titulos()
	
	dw = 	tab_1.tabpage_3.dw_3
	ldw_3 = dw
	OpenWithParm(w_dw_print_options, ldw_3)

	If Message.DoubleParm = -1 Then Return
	
	If is_win9598_winnt='win9598' then
		
		// abrir ventana de seleccion de modelo de impresora  
	
		OpenwithParm(w_tz_co_selec_modelo_print,str_tz_doctos)
			
		str_tz_doctos = message.PowerObjectParm
		
		if isvalid(str_tz_doctos) and Not IsNull(str_tz_doctos) then 
			
			if str_tz_doctos.aceptar = false then return
			
			if Isnull(str_tz_doctos.largo_doc) or str_tz_doctos.largo_doc = 0 or &
				Isnull(str_tz_doctos.ancho_doc) or str_tz_doctos.ancho_doc = 0 then 
				mensaje("Atención ","Debe asignarle los parámetros de largo y ancho del documento para la impresora seleccionada ...Ok","")
				return
			end If
			gf_dg_tamano_pagina(str_tz_doctos.largo_doc,str_tz_doctos.ancho_doc,ldw_3)
		end If
	end If
	
	ldw_3.object.datawindow.print.preview = 'yes'
	ldw_3.object.datawindow.print.preview.zoom =100

String	ls_rango, ls_copias
ls_copias =	ldw_3.Describe('datawindow.print.copies')
ls_rango  =	ldw_3.Describe('datawindow.print.page.range')

gf_tz_reimprime_x_pagina(ldw_3,ls_rango,ls_copias)
//wf_reimprime_pagina(ldw_3,ls_rango,ls_copias)
	
str.frame.setmicrohelp(" ")
wf_activa_titulos()

end event

public subroutine wf_setear_lineas ();// Para actualizar los valores de la linea de detalle
	
Integer	 recorrido,li_linea
Double	 ld_valor, ld_valor1
Long 		ll_update
datawindow ldw_2
is_guardando = 'S'
ldw_2 = tab_1.tabpage_2.dw_2
li_linea=0
FOR recorrido = 1 TO ldw_2.rowcount()

	if ldw_2.getItemNumber(recorrido,"traf_cantidad")+&
		ldw_2.getItemNumber(recorrido,"traf_fraccion") > 0 and & 
		len(trim(ldw_2.getitemstring(recorrido,"traf_arancel"))) > 0  then
	
		li_linea = li_linea + 1
		ldw_2.setitem(li_linea,"traf_linea",li_linea)
		ldw_2.setitem(li_linea,"traf_pedido",is_pedido)
		//ld_valor = ld_valor + ldw_2.getitemNumber(li_linea,"traf_valor")
		ld_valor1 = ldw_2.getitemNumber(li_linea,"traf_valor")
		If IsNull( ld_valor1 ) then ld_valor1 = 0
		ld_valor = ld_valor + ld_valor1
	else
		ldw_2.deleterow(recorrido)
		recorrido = recorrido - 1
	end if	
NEXT
// Actualiza el monto del movimiento
tab_1.tabpage_1.dw_1.setItem(tab_1.tabpage_1.dw_1.getRow(),"ttra_monto",ld_valor)
tab_1.tabpage_1.dw_1.setItem(tab_1.tabpage_1.dw_1.getRow(),"ttra_pedido",is_pedido)

ll_update=tab_1.tabpage_1.dw_1.update()

if ll_update = 1 then
	//Actualizo encabezado del documento
	commit using sqlca;
else
	rollback using sqlca;
	messagebox("Atención","¡Error al Actualizar el Encabezado!")	
end if

end subroutine

public subroutine wf_elimina ();		// Eliminar del detalle
			DELETE FROM tzdtraf1   
			 WHERE ( tzdtraf1.traf_g_financiero = :str.g_financiero ) 	AND  
			       ( tzdtraf1.traf_empresa = :str.empresa ) AND  
		 			 ( tzdtraf1.traf_ann = :w_fa_fondo.str_param.anio ) AND
		 			 ( tzdtraf1.traf_ent_sal = 'SA' ) AND
					 ( tzdtraf1.traf_pedido = "is_pedido" ) ; 
					 
		// Eliminar del encabezado
			DELETE FROM tzttraf0  
			 WHERE ( tzttraf0.ttra_g_financiero = :str.g_financiero ) 	AND  
			       ( tzttraf0.ttra_empresa = :str.empresa ) AND  
		 			 ( tzttraf0.ttra_ann = :w_fa_fondo.str_param.anio ) AND
		 			 ( tzttraf0.ttra_ent_sal = 'SA' ) AND
					 ( tzttraf0.ttra_pedido = "is_pedido" ) ; 


end subroutine

public function integer wf_existe (); //Verifica si la factura tiene detalle y dependiendo de esto, habilita o no la vista previa
 
 integer li_hay
 
		  select count(*)
		  into :li_hay
		  from tzdtraf1
		  where (tzdtraf1.traf_g_financiero = :str.g_financiero) and
		  		  (tzdtraf1.traf_empresa		= :str.empresa) and
				  (tzdtraf1.traf_ent_sal 	   = 'SA') and
				  (tzdtraf1.traf_pedido	 	   = :is_pedido) and
				  (tzdtraf1.traf_ann			   = :w_fa_fondo.str_param.anio) ;

return(li_hay)

end function

public subroutine wf_valida_rowchange ();// Esta Funcion valida cuando cambias de row en el encabezado 
// y has hecho elgo en el detalle

dw = tab_1.tabpage_2.dw_2
yield()
If dw.Rowcount () + dw.modifiedcount()+dw.deletedcount() > 0 Then  //Si hay lineas en el detalle
	dw.retrieve(str.g_financiero,str.empresa,'SA',w_fa_fondo.str_param.anio,"ttra_pedido")
End If	
return


end subroutine

public function integer wf_max_ped ();//Función que busca el pedido en la tabla de pedidos y luego actualiza la secuencia en 
//parámetros

integer li_max
string ls_max

SELECT tzaparam.para_sec_salidas
    INTO :li_max
    FROM tzaparam
   WHERE ( tzaparam.para_g_financiero = :str.g_financiero ) AND
         ( tzaparam.para_empresa = :str.empresa );

  ls_max = wf_busca_pedido(li_max) // Busca #Próximo Sec Ped disponible en tabla Tzttraf0
  li_max = integer(ls_max)  

  UPDATE tzaparam
     SET para_sec_salidas = :li_max
   WHERE ( tzaparam.para_g_financiero = :str.g_financiero ) AND
         ( tzaparam.para_empresa = :str.empresa );

	if SQLCA.SQLCODE = 0 THEN
		is_pedido=ls_max
		dw.setitem( dw.getrow(),"ttra_pedido",ls_max)
		 								// Setea la secuencia de Tzparam al DataWindow
		COMMIT USING SQLCA;		
		return (1)
	else
		ROLLBACK USING SQLCA;
		MESSAGEBOX("ATENCIÓN SR. USUARIO","Error al actualizar la secuencia, Verifique",StopSign!)
		return (-1)
	end if
end function

public subroutine wf_actualiza_secuencia ();//integer li_pedido, li_actualiza
//Recupera la secuencia de los pedidos

integer li_actualiza
Long	li_max,li_pedido
string ls_max
datawindow ldw_1
ldw_1=tab_1.tabpage_1.dw_1
SELECT tzaparam.para_sec_salidas
    INTO :li_max
    FROM tzaparam
   WHERE ( tzaparam.para_g_financiero = :str.g_financiero ) AND
         ( tzaparam.para_empresa = :str.empresa );

  ls_max = wf_busca_pedido(li_max) 	// Busca #Próximo Sec Ped disponible 
  												// en tabla Tzttraf0
  li_max = long(ls_max)  

  UPDATE tzaparam
     SET para_sec_salidas = :li_max
   WHERE ( tzaparam.para_g_financiero = :str.g_financiero ) AND
         ( tzaparam.para_empresa = :str.empresa );
	
	li_actualiza = 0

	if SQLCA.SQLCODE = 0 THEN
		li_actualiza = 1
		is_pedido=ls_max
		tab_1.tabpage_1.dw_1.setitem( tab_1.tabpage_1.dw_1.getrow(),"ttra_pedido",ls_max)
		 								// Setea la secuencia de Tzparam al DataWindow
		COMMIT USING SQLCA;		
	else
		ROLLBACK USING SQLCA;
		MESSAGEBOX("ATENCIÓN SR. USUARIO","Error al actualizar la secuencia, Verifique",StopSign!)
		li_actualiza = -1
	end if
	
	if li_actualiza = 1 then
		ldw_1.setitem(tab_1.tabpage_1.dw_1.getrow(),"ttra_pedido",is_pedido)
		ldw_1.setitem(tab_1.tabpage_1.dw_1.getrow(),"ttra_g_financiero",str.g_financiero)
		ldw_1.setitem(ldw_1.getrow(),"ttra_empresa",str.empresa)
		ldw_1.setitem(ldw_1.getrow(),"ttra_ann",w_fa_fondo.str_param.anio)
		ldw_1.setitem(ldw_1.getrow(),"ttra_ent_sal",'SA')
		li_actualiza = tab_1.tabpage_1.dw_1.update()
		if li_actualiza = 1 then
			is_act_secuencia = 'S'
		end if
	else
	 	//Si hubo error en la actualizacion de la secuencia 
	 	rollback using sqlca;
		messagebox("ATENCION SR. USUARIO","Error al Grabar el numero del Pedido, Reintente.",StopSign!)
	end if
end subroutine

public subroutine wf_botones ();//Deshabilita los botones inicialmente
If not IsValid(m_fa_principal) Then
	ChangeMenu(m_fa_principal)
End If
	m_fa_principal.m_edicin.m_insertar.toolbaritemvisible=false
	m_fa_principal.m_edicin.m_filtrar.toolbaritemvisible=false
	m_fa_principal.m_edicin.m_sortear.toolbaritemvisible=false

	m_fa_principal.m_edicin.m_primerregistro.enabled=false
	m_fa_principal.m_edicin.m_registroanterior.enabled=false
	m_fa_principal.m_edicin.m_siguienteregistro.enabled=false
	m_fa_principal.m_edicin.m_ultimoregistro.enabled=false
	m_fa_principal.m_edicin.m_adicionar.toolbaritemvisible=true
	m_fa_principal.m_edicin.m_adicionar.enabled = true

	m_fa_principal.m_archivo.m_guardar.enabled = false
   m_fa_principal.m_archivo.m_imprimir.enabled = false

end subroutine

public subroutine wf_valida_bultos ();integer li_bultos
dw.AcceptText()
Choose Case DW.GetColumnName()
	CASE "traf_cant_bultos"

//	CASE "traf_descrip_bulto"
		li_bultos=dw.getitemNumber(dw.getrow(),"traf_cant_bultos")
		if li_bultos <= 0 then
			messagebox("ItemfocusChange DESCRIP/BULTO Cantidad NoVálida",string(li_bultos))
			dw.setcolumn("traf_cant_bultos")
		end if
End Choose

end subroutine

public subroutine wf_filtra_pais ();string ls_pais1,ls_paisd
integer li_pais,li_paisd
CHOOSE CASE iS_CAMPO
	CASE "TTRA_PAIS_DESTINO"
		li_pais=dw.getitemNumber(dw.getrow(),"ttra_pais_destino")
		ls_pais1="puer_pais = "+string(li_pais)
		dw.setfilter(ls_pais1)
	CASE "TTRA_PAIS_ORIGEN"	// Pais Trasbordo
		li_paisd=dw.getitemNumber(dw.getrow(),"ttra_pais_origen")	
		ls_paisd="puer_pais = "+string(li_paisd)
		dw.setfilter(ls_paisd)
END CHOOSE

end subroutine

public subroutine wf_activa_titulos ();// Hace invisible los títulos del datawindow de impresion
// de documento comercial
datawindow ldw_3
ldw_3=tab_1.tabpage_3.dw_3

	ldw_3.Modify("dir_embarcador.Visible='1'")
	ldw_3.Modify("cia_import.Visible='1'")
	ldw_3.Modify("cia_export.Visible='1'")
	ldw_3.Modify("vuelo_barco.Visible='1'")
	ldw_3.Modify("pais_orig.Visible='1'")
	ldw_3.Modify("puerto_orig.Visible='1'")
	ldw_3.Modify("puerto_trasb.Visible='1'")
	ldw_3.Modify("conoc_emb.Visible='1'")
	ldw_3.Modify("clave_cia_imp.Visible='1'")
	ldw_3.Modify("clave_cia_exp.Visible='1'")
	ldw_3.Modify("salida_de.Visible='1'")
	ldw_3.Modify("entrada_a.Visible='1'")
	ldw_3.Modify("fecha_fac.Visible='1'")
	ldw_3.Modify("puerto_ent.Visible='1'")
	ldw_3.Modify("embarcador.Visible='1'")
	ldw_3.Modify("fact_comercial.Visible='1'")
	ldw_3.Modify("empr_transp.Visible='1'")
	ldw_3.Modify("puerto_sal.Visible='1'")
	ldw_3.Modify("destinatario.Visible='1'")
	ldw_3.Modify("dir_destinatario.Visible='1'")
	ldw_3.Modify("telefono.Visible='1'")
	ldw_3.Modify("traspaso.Visible='1'")
	ldw_3.Modify("fecha_reg.Visible='1'")
	ldw_3.Modify("clave_trasp_imp.Visible='1'")
	ldw_3.Modify("clave_trasp_exp.Visible='1'")
	ldw_3.Modify("salida_no.Visible='1'")
	ldw_3.Modify("entrada_no.Visible='1'")
	ldw_3.Modify("cia_imp.Visible='1'")
	
	ldw_3.Modify("head_cant.Visible='1'")
	ldw_3.Modify("head_clase.Visible='1'")
	ldw_3.Modify("head_descrip.Visible='1'")
	ldw_3.Modify("head_arancel.Visible='1'")
	ldw_3.Modify("head_empaque.Visible='1'")
	ldw_3.Modify("head_cantidad.Visible='1'")
	ldw_3.Modify("head_fraccion.Visible='1'")
	ldw_3.Modify("head_kilos.Visible='1'")
	ldw_3.Modify("head_total.Visible='1'")
return

end subroutine

public subroutine wf_desactiva_titulos ();// Hace invisible los títulos del datawindow de impresion
// de documento comercial
datawindow ldw_3
ldw_3=tab_1.tabpage_3.dw_3
	ldw_3.Modify("dir_embarcador.Visible='0'")
	ldw_3.Modify("cia_import.Visible='0'")
	ldw_3.Modify("cia_export.Visible='0'")
	ldw_3.Modify("vuelo_barco.Visible='0'")
	ldw_3.Modify("pais_orig.Visible='0'")
	ldw_3.Modify("puerto_orig.Visible='0'")
	ldw_3.Modify("puerto_trasb.Visible='0'")
	ldw_3.Modify("conoc_emb.Visible='0'")
	ldw_3.Modify("clave_cia_imp.Visible='0'")
	ldw_3.Modify("clave_cia_exp.Visible='0'")
	ldw_3.Modify("salida_de.Visible='0'")
	ldw_3.Modify("entrada_a.Visible='0'")
	ldw_3.Modify("fecha_fac.Visible='0'")
	ldw_3.Modify("puerto_ent.Visible='0'")
	ldw_3.Modify("embarcador.Visible='0'")
	ldw_3.Modify("fact_comercial.Visible='0'")
	ldw_3.Modify("empr_transp.Visible='0'")
	ldw_3.Modify("puerto_sal.Visible='0'")
	ldw_3.Modify("destinatario.Visible='0'")
	ldw_3.Modify("dir_destinatario.Visible='0'")
	ldw_3.Modify("cia_imp.Visible='0'")
	ldw_3.Modify("telefono.Visible='0'")
	ldw_3.Modify("traspaso.Visible='0'")
	ldw_3.Modify("fecha_reg.Visible='0'")
	ldw_3.Modify("clave_trasp_imp.Visible='0'")
	ldw_3.Modify("clave_trasp_exp.Visible='0'")
	ldw_3.Modify("salida_no.Visible='0'")
	ldw_3.Modify("entrada_no.Visible='0'")
	ldw_3.Modify("cia_imp.Visible='0'")
	
	ldw_3.Modify("head_cant.Visible='0'")
	ldw_3.Modify("head_clase.Visible='0'")
	ldw_3.Modify("head_descrip.Visible='0'")
	ldw_3.Modify("head_arancel.Visible='0'")
	ldw_3.Modify("head_empaque.Visible='0'")
	ldw_3.Modify("head_cantidad.Visible='0'")
	ldw_3.Modify("head_fraccion.Visible='0'")
	ldw_3.Modify("head_kilos.Visible='0'")
	ldw_3.Modify("head_total.Visible='0'")
return

end subroutine

public subroutine wf_centrar ();
integer li_posicion_x,li_posicion_y

li_posicion_x=str.frame.width/2 - 60  - this.width/2
li_posicion_y=str.frame.height/2 -100 - this.height/2

if 0 > li_posicion_x then
	li_posicion_x=1
	this.HScrollBar = True
else
	this.HScrollBar = false
end if

if 0 > li_posicion_y then
	li_posicion_y = 1
	this.VScrollbar = true
else
	this.VScrollBar = False
end if
 this.x=li_posicion_x
 this.y= 1

end subroutine

public subroutine wf_habilita_objetos (boolean integrado);
If w_fa_fondo.str_param.subfactura_sn = 1 then
	tab_1.tabpage_1.dw_1.Object.aplicar.visible = True
	tab_1.tabpage_1.dw_1.Object.ttra_porcentaje.visible = True
else
	tab_1.tabpage_1.dw_1.Object.aplicar.visible = false
	tab_1.tabpage_1.dw_1.Object.ttra_porcentaje.visible = false
	tab_1.tabpage_1.dw_1.Modify("ttra_porcentaje.TabSequence = 0")
end If

If Not Integrado  Then
	//	tab_1.tabpage_1.dw_1.Object.tipo_costo.visible = false
	tab_1.tabpage_1.dw_1.Modify("tipo_bulto.TabSequence = 0")
	tab_1.tabpage_1.dw_1.Modify("resumir.TabSequence = 0")
	//tab_1.tabpage_1.dw_1.Modify("porcentaje.TabSequence = 0")
	tab_1.tabpage_1.dw_1.Modify("seleccion.TabSequence = 0")
	
	
	//	tab_1.tabpage_1.dw_1.Object.tipo_bulto.visible = false
	//	tab_1.tabpage_1.dw_1.Object.resumir.visible = false
	//	tab_1.tabpage_1.dw_1.Object.porcentaje.visible = false
	//	tab_1.tabpage_1.dw_1.Object.seleccion.visible = false
		tab_1.tabpage_1.dw_1.Object.recuadro.visible = false
	
	//	tab_1.tabpage_1.dw_1.Object.ttra_tipo_fob_cif.visible = false
	//	tab_1.tabpage_1.dw_1.Object.ttra_flag.visible = false
	//	tab_1.tabpage_1.dw_1.Object.ttra_porcentaje.visible = false
	//	tab_1.tabpage_1.dw_1.Object.ttra_revisado.visible = false
	//	tab_1.tabpage_1.dw_1.Object.ttra_tipo_fact_pedido.visible = false
		tab_1.tabpage_1.cb_procesar.visible = False
		
		tab_1.tabpage_1.dw_1.Modify("ttra_flag.TabSequence = 0")
	//	tab_1.tabpage_1.dw_1.Modify("ttra_porcentaje.TabSequence = 0")
		tab_1.tabpage_1.dw_1.Modify("ttra_revisado.TabSequence = 0")
		tab_1.tabpage_1.dw_1.Modify("ttra_tipo_fact_pedido.TabSequence = 0")
	
Else
//	tab_1.tabpage_1.dw_1.Object.tipo_costo.visible = True
	tab_1.tabpage_1.dw_1.Object.tipo_bulto.visible = True
	tab_1.tabpage_1.dw_1.Object.resumir.visible = True
//	tab_1.tabpage_1.dw_1.Object.porcentaje.visible = True
	tab_1.tabpage_1.dw_1.Object.seleccion.visible = True
	tab_1.tabpage_1.dw_1.Object.recuadro.visible = True

//	tab_1.tabpage_1.dw_1.Object.ttra_tipo_fob_cif.visible = True
	tab_1.tabpage_1.dw_1.Object.ttra_flag.visible = True
	tab_1.tabpage_1.dw_1.Object.ttra_revisado.visible = True
	tab_1.tabpage_1.dw_1.Object.ttra_tipo_fact_pedido.visible = True
	tab_1.tabpage_1.cb_procesar.visible = True
End If
end subroutine

public function string wf_busca_pedido (long ll_max);// Obtiene la sig secuencia de documento disponible en Tzttraf0
integer 	li_para_entra,recorrido,li_existe
string 	ls_maxi,ls_max,ls_clave
Long		ll_maxi

SELECT tzaparam.para_sec_salidas,tzaparam.para_clave_cia,
		 tzaparam.para_num_pais
 INTO :ll_maxi,
		:ls_clave,
		:ii_num_pais
 FROM tzaparam
WHERE ( tzaparam.para_g_financiero = :str.g_financiero ) AND
		( tzaparam.para_empresa = :str.empresa );
	ii_clave_cia = Integer(ls_clave)

//  Busca el proximo pedido disponible en la tabla encabezado
If IsNull(ll_maxi) Then ll_maxi = 0

If ll_maxi >= 1 Then
	ll_maxi = ll_maxi - 1	
End if

DO	
	ll_maxi = ll_maxi + 1
	ls_max = string(ll_maxi)
  SELECT count(*)
    INTO :li_existe  
    FROM tzttraf0  
   WHERE ( tzttraf0.ttra_g_financiero = :str.g_financiero ) AND  
         ( tzttraf0.ttra_empresa = :str.empresa ) AND  
         ( tzttraf0.ttra_ent_sal = 'SA' ) AND  
			( tzttraf0.ttra_ann 		= :w_fa_fondo.str_param.anio ) AND
         ( tzttraf0.ttra_pedido  = :ls_max )  ;
LOOP UNTIL li_existe = 0

is_pedido			=string(ll_maxi) // Asigna la secuencia disponible en Tzttraf0
is_secuencia_nueva=string(ll_maxi) // Guarda la próxima secuencia disponible
return(string(ll_maxi))


end function

public subroutine wf_salvar ();//Salva la informacion de el encabezado del documento
If dw=tab_1.tabpage_2.dw_2 then
	String	ls_arancel
	ls_arancel = dw.GetItemstring(dw.rowcount(),'traf_arancel')
	If Isnull(ls_arancel) or trim(ls_arancel) = '' then
		dw.deleterow(dw.rowcount())
	end if
end if

if dw.update() = 1 then
		commit ;
	//Para que no se vea el documento borrado, en el ChildDW
	If dw = tab_1.tabpage_1.dw_1 Then
		If dch_ped.retrieve(str.g_financiero,str.empresa,"SA",w_fa_fondo.str_param.anio)&
		<=0 then dch_ped.insertrow(0)
	End If
else
		messagebox("ATENCIÓN SR. USUARIO","Error al Actualizar Eliminación, Verifique",Stopsign!)
		rollback;
end if	

end subroutine

public subroutine wf_setea_encabezado ();//Este scrip guarda el encabezado y los setea al registro nuevo insertado
Integer	li_pais_destino,  li_puerto_destino, li_puerto_salida,li_puerto_trasb
Long		ll_rowcount
Datetime	ldt_fecha_factura, ldt_fecha_reg
String	ls_vuelo,ls_num_conoc,ls_para_clave,ls_pedido, ls_facturas
String	ls_transportador, ls_dir_embarcador, ls_dir_destinatario, ls_telefonos, ls_nom_empresa

Datawindow ldw_3

ldw_3 = tab_1.tabpage_3.dw_3
//il_rowcount = ldw_3.rowcount()
li_pais_destino = ldw_3.GetItemNumber(il_rowcount,'ttra_pais_destino')
li_puerto_destino = ldw_3.GetItemNumber(il_rowcount,'ttra_puerto_destino')
li_puerto_trasb  = ldw_3.GetItemNumber(il_rowcount,'tzttraf0_ttra_puerto_trasbordo')
li_puerto_salida = ldw_3.GetItemNumber(il_rowcount,'ttra_puerto_salida')

ls_vuelo 		= ldw_3.GetItemString(il_rowcount,'tzttraf0_ttra_vuelo_barco')
ls_num_conoc 	= ldw_3.GetItemString(il_rowcount,'tzttraf0_ttra_num_conoc_emb')
ls_pedido 		= ldw_3.GetItemString(il_rowcount,'tzttraf0_ttra_pedido')
ls_para_clave 	= ldw_3.GetItemString(il_rowcount,'tzaparam_para_clave_cia')
ls_facturas 		= ldw_3.GetItemString(il_rowcount,'ttra_facturas')
ls_transportador  = ldw_3.GetItemString(il_rowcount,'tzttraf0_ttra_transportador')
ls_dir_embarcador = ldw_3.GetItemString(il_rowcount,'ttra_dir_embarcador')
ls_dir_destinatario =ldw_3.GetItemString(il_rowcount,'ttra_dir_destinatario')
ls_telefonos 		= ldw_3.GetItemString(il_rowcount,'dgmempre_empr_telefono1')
ls_nom_empresa		= ldw_3.GetItemString(il_rowcount,'nom_empresa')

ldt_fecha_factura = ldw_3.GetItemDateTime(il_rowcount,'tzttraf0_ttra_fecha_factura')
ldt_fecha_reg 		= ldw_3.GetItemDateTime(il_rowcount,'tzttraf0_ttra_fecha_reg')

ldw_3.Insertrow(0)
ll_rowcount = ldw_3.rowcount()

ldw_3.SetItem(ll_rowcount,'ttra_pais_destino',li_pais_destino)
ldw_3.SetItem(ll_rowcount,'ttra_puerto_destino',li_puerto_destino)
ldw_3.SetItem(ll_rowcount,'tzttraf0_ttra_puerto_trasbordo',li_puerto_trasb)
ldw_3.SetItem(ll_rowcount,'ttra_puerto_salida',li_puerto_salida)

ldw_3.SetItem(ll_rowcount,'tzttraf0_ttra_vuelo_barco',ls_vuelo)
ldw_3.SetItem(ll_rowcount,'tzttraf0_ttra_num_conoc_emb',ls_num_conoc)
ldw_3.SetItem(ll_rowcount,'tzttraf0_ttra_pedido',ls_pedido)
ldw_3.SetItem(ll_rowcount,'tzaparam_para_clave_cia',ls_para_clave)
ldw_3.SetItem(ll_rowcount,'ttra_facturas',ls_facturas)
ldw_3.SetItem(ll_rowcount,'tzttraf0_ttra_transportador',ls_transportador)
ldw_3.SetItem(ll_rowcount,'ttra_dir_embarcador',ls_dir_embarcador)
ldw_3.SetItem(ll_rowcount,'ttra_dir_destinatario',ls_dir_destinatario)
ldw_3.SetItem(ll_rowcount,'dgmempre_empr_telefono1',ls_telefonos)
ldw_3.SetItem(ll_rowcount,'nom_empresa',ls_nom_empresa)
ldw_3.SetItem(ll_rowcount,'tzttraf0_ttra_fecha_factura',ldt_fecha_factura)
ldw_3.SetItem(ll_rowcount,'tzttraf0_ttra_fecha_reg',ldt_fecha_reg)

end subroutine

public subroutine wf_convierte_cantidad (string ls_unian, double ld_total_piezas);Double ld_cant_x_bul, ld_mconver, ld_fraccion,ld_cantidad,ld_cant_dec
datawindow ldw_1,ldw_2

ldw_2 = tab_1.tabpage_2.dw_2

 if IsNull(ld_total_piezas) then ld_total_piezas = 0

// Busca la unidad de coversion de la unidad de medida requerida
 SELECT inamedid.medi_cantidad
 INTO	:ld_mconver
 FROM inamedid  
 WHERE inamedid.medi_medida = :ls_unian;

 if ld_mconver = 0 or IsNull(ld_mconver) then
	 ld_mconver = 1
 end if
 
 ld_cant_dec     = ld_total_piezas/ld_mconver	// total doc y decimales
 
 ld_cantidad     = long(ld_cant_dec) 	// Total doc
 ld_fraccion     = (ld_cant_dec - ld_cantidad) * ld_mconver //Residuo de la division

 If w_fa_fondo.str_param.decimales_sino = 1 then
 	ldw_2.SetItem(ldw_2.getrow(), "traf_cantidad",ld_cant_dec )
	ldw_2.SetItem(ldw_2.getrow(), "traf_fraccion",0 )
else
 	ldw_2.SetItem(ldw_2.getrow(), "traf_cantidad",ld_cantidad )
 	ldw_2.SetItem(ldw_2.getrow(), "traf_fraccion",ld_fraccion )
end if

end subroutine

public subroutine wf_oculta_lineas ();String ls_find
Integer	li_find
Datawindow ldw_3
ldw_3 = tab_1.tabpage_3.dw_3

ls_find = "traf_descrip_bulto = 'xx'"

li_find = ldw_3.Find(ls_find,1,ldw_3.rowcount())
If li_find > 0 then
If tab_1.tabpage_3.cbx_1.checked = true then
	ldw_3.SetItem(li_find,"oculta_totales",'0')	
	ldw_3.SetItem(li_find,"oculta_lineas",'1')	
else
	ldw_3.SetItem(li_find,"oculta_totales",'0')	
	ldw_3.SetItem(li_find,"oculta_lineas",'0')	
end if
end if		

end subroutine

public subroutine wf_oculta_totales ();String ls_find
Integer	li_find
Datawindow ldw_3
ldw_3 = tab_1.tabpage_3.dw_3

ls_find = "traf_descrip_bulto = 'xx'"

li_find = ldw_3.Find(ls_find,1,ldw_3.rowcount())
If li_find > 0 then
If tab_1.tabpage_3.cbx_2.checked = true then
	ldw_3.SetItem(li_find,"oculta_totales",'1')	
	ldw_3.SetItem(li_find,"oculta_lineas",'1')	
else
	ldw_3.SetItem(li_find,"oculta_totales",'0')	
	ldw_3.SetItem(li_find,"oculta_lineas",'0')	
end if
end if		

end subroutine

public subroutine wf_parametros ();// Asigna parametros de la llave principal al encabezado
dw.scrolltorow(dw.insertrow(0))
dw.setitem(dw.getrow(),"ttra_pedido",is_pedido)
dw.setitem(dw.getrow(),"ttra_g_financiero",str.g_financiero)
dw.setitem(dw.getrow(),"ttra_empresa",str.empresa)
dw.setitem(dw.getrow(),"ttra_ann",w_fa_fondo.str_param.anio)
dw.setitem(dw.getrow(),"ttra_ent_sal",'SA')
dw.setitem(dw.getrow(),"ttra_fecha_reg",gf_fecha_serv())

end subroutine

public subroutine wf_borrar_detalle ();// Borra el detalle de un documento
sqlca.autocommit=false

datawindow ldw_2
ldw_2 = tab_1.tabpage_2.dw_2
if ldw_2.rowcount() > 0  then

	do while ldw_2.rowcount() > 0
		ldw_2.deleterow(ldw_2.rowcount())
	loop
	
	tab_1.tabpage_2.dw_2.update()

	tab_1.tabpage_1.dw_1.setItem(tab_1.tabpage_1.dw_1.getRow(),"ttra_monto",0)

	tab_1.tabpage_1.dw_1.update()
	
//	m_fa_principal.m_archivo.m_imprimir.enabled = false
	tab_1.tabpage_3.enabled = false
	m_fa_principal.m_archivo.m_guardar.enabled = true		
end if
sqlca.autocommit=true

end subroutine

public subroutine wf_valida_exist_detalle ();// Busca si existe detalle de la factura en facturacion
// Si detecta que la factura existe va a la funcion wf_busca_deta_ent 
//	donde resume el detalle por arancel y lo setea al detalle de Trafico
 
decimal  ld_gastos,ld_gastos_tot,ld_flete,ld_seguro,ld_monto_cargo
datetime ld_fecha   
integer  li_sec,li_existe,li_largo,li_caracter,li_grupo,li_empresa,li_anio,li_lincar
string   ls_no_pedido,ls_conoc_emb,ls_marca,ls_no_factura,ls_pedido_fac,ls_numero,&
			ls_consignado,ls_a_nombre,ls_a_direccion,ls_despachado, ls_pedido_fac_1, ls_tipo

Double  	ld_peso_total,ld_cubicaje_total,ld_monto_fact_total,ld_monto_final
Long	   ll_bultos_total,ll_tercero, ll_row
String	array_null[],ls_error
Datawindow	ldw_4

ldw_4 = tab_1.tabpage_1.dw_4

documento[] = array_null[]
dw = tab_1.tabpage_1.dw_1

is_factura    = dw.getitemString(1,"ttra_facturas")
is_pedido_fac = dw.getitemString(1,"ttra_pedidos_fac")

ls_pedido_fac = is_pedido_fac
li_largo 	  = len(trim(is_pedido_fac)) + 2

id_selec = dw.getitemNumber(1,"ttra_tipo_fact_pedido")

ii_contador  = 0
li_existe = 0

if str_tz_doctos.viene_de_buscar = 0 then	
//Significa que se editaron los documentos a procesar

	for li_caracter = 1 to li_largo
		
		 if len(trim(mid(ls_pedido_fac,li_caracter,1)))> 0 and (not IsNull(mid(ls_pedido_fac,li_caracter,1))) then
			ls_numero = trim(ls_numero)+trim(mid(ls_pedido_fac,li_caracter,1))
		 else
	
			if len(trim(ls_numero)) > 0 then
				ii_contador = ii_contador + 1
				ls_numero = trim(ls_numero)	
	
				if id_selec = 1 then 	// Factura
		
				  SELECT fatdiari.fact_no_pedido,   
							fatdiari.fact_con_emb_no,   
							fatdiari.fact_marca,   
							fatdiari.fact_gastos_total,   
							fatdiari.fact_fecha,
							fatdiari.fact_consignado,
							fatdiari.fact_cliente,
							fatdiari.fact_a_nombre,
							fatdiari.fact_a_nombre_direccion,
							fatdiari.fact_despachado,
							fatdiari.fact_bultos_total,
							fatdiari.fact_peso_total,
							fatdiari.fact_cubicaje_total,
							fatdiari.fact_monto_fact_total,
							fatdiari.fact_monto_final
					 INTO :ls_no_pedido,   
							:ls_conoc_emb,   
							:ls_marca,   
							:ld_gastos,   
							:ld_fecha,
							:ls_consignado,
							:ll_tercero,
							:ls_a_nombre,
							:ls_a_direccion,
							:ls_despachado,
							:ll_bultos_total,
							:ld_peso_total,
							:ld_cubicaje_total,
							:ld_monto_fact_total,
							:ld_monto_final
	
					 FROM fatdiari  
					WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
							( fatdiari.fact_empresa		  = :str.empresa ) AND  
							( fatdiari.fact_ann   		  = :ii_anio_recupera) AND  
							( fatdiari.fact_no_factura   = :ls_numero ) AND 
							( fatdiari.fact_no_pedido not like '%NC%' );
	
						documento[ii_contador] = ls_no_pedido
	
						if SQLCA.sqlcode = 0 then
							ls_pedido_fac_1 = trim(ls_pedido_fac_1)+' '+trim(ls_no_pedido)
						end if
						ls_numero = ls_no_pedido  //Para recuperar detalle de gastos
				else
		
					documento[ii_contador] = ls_numero
	
				  SELECT fatdiari.fact_no_factura,   
							fatdiari.fact_con_emb_no,   
							fatdiari.fact_marca,   
							fatdiari.fact_gastos_total,   
							fatdiari.fact_fecha,   
							fatdiari.fact_consignado,
							fatdiari.fact_cliente,
							fatdiari.fact_a_nombre,
							fatdiari.fact_a_nombre_direccion,
							fatdiari.fact_despachado,
							fatdiari.fact_bultos_total,
							fatdiari.fact_peso_total,
							fatdiari.fact_cubicaje_total,
							fatdiari.fact_monto_fact_total,
							fatdiari.fact_monto_final
					 INTO :ls_no_factura,   
							:ls_conoc_emb,   
							:ls_marca,   
							:ld_gastos,   
							:ld_fecha,
							:ls_consignado,
							:ll_tercero,
							:ls_a_nombre,
							:ls_a_direccion,
							:ls_despachado,
							:ll_bultos_total,
							:ld_peso_total,
							:ld_cubicaje_total,
							:ld_monto_fact_total,
							:ld_monto_final
					 FROM fatdiari  
					WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
							( fatdiari.fact_empresa		  = :str.empresa ) AND  
							( fatdiari.fact_ann   		  = :ii_anio_recupera ) AND  
							( fatdiari.fact_no_pedido    = :ls_numero ) AND 
							( fatdiari.fact_no_pedido not like '%NC%' ) ;
		
					if SQLCA.sqlcode = 0 then
						ls_pedido_fac_1 = trim(ls_pedido_fac_1)+' '+trim(ls_no_factura)
					end if
				end if
//				ls_numero = ''		
	
				if SQLCA.sqlcode = -1 then
					ls_error = sqlca.sqlerrText
					mensaje("Error","Se ha producido un error al leer el documento No. "+trim(ls_pedido_fac_1)+' '+trim(ls_no_pedido)+' '+ls_error,"")
				end if
				
				if SQLCA.sqlcode = 0 then
					
					if li_existe = 0 then	// Guarda datos del primer doc que encontró
						 dw.setitem(1,"ttra_fecha_factura",ld_fecha)
						 dw.setitem(1,"ttra_marca",ls_marca)
						 dw.setitem(1,"ttra_num_conoc_emb",ls_conoc_emb)
						 dw.setitem(1,"ttra_tercero",ll_tercero)
						 dw.setitem(1,"ttra_destinatario",ll_tercero)
						 dw.setitem(1,"ttra_consignado",ls_consignado)
						 dw.setitem(1,"ttra_dir_embarcador",ls_a_nombre)
						 dw.setitem(1,"ttra_dir_destinatario",ls_a_direccion)
					end if

					/*RECUPERA EL FLETE Y SEGURO EN FORMA SEPARADA*/
					
					if dw_5.retrieve(str.g_financiero,str.empresa,ls_numero,ii_anio_recupera)> 0 then
						For li_lincar=1 to dw_5.rowcount()
							
							ld_monto_cargo =dw_5.getitemNumber(li_lincar,"dcar_monto")
							
							if isNull(ld_monto_cargo ) then ld_monto_cargo =0
							
							If dw_5.getitemString(li_lincar,"carg_flete_seguro")='S' then  // Seguro
								ld_seguro = ld_seguro + ld_monto_cargo
							end if
							If dw_5.getitemString(li_lincar,"carg_flete_seguro")='F' then  // Flete
								ld_flete = ld_flete + ld_monto_cargo
							end if
						Next
					end if
	
					ld_gastos_tot = ld_gastos_tot + ld_gastos
					li_existe = li_existe + 1
				end if
				ls_numero = ''		

			end if
		 end if
	
	NEXT

Else	// Los argumentos de recuperción vienen el la estructura

	/**************************************/

	for ll_row = 1 to ldw_4.rowcount()
		
				ii_contador = ii_contador + 1
				
				ls_numero = ldw_4.GetItemString(ll_row,"fact_no_factura")
				li_anio   = ldw_4.GetItemNumber(ll_row,"fact_ann")
				ls_tipo   = ldw_4.GetItemString(ll_row,"fact_tipo")
				
				if id_selec = 1 then 	// Factura
		
				  SELECT fatdiari.fact_no_pedido,   
							fatdiari.fact_con_emb_no,   
							fatdiari.fact_marca,   
							fatdiari.fact_gastos_total,   
							fatdiari.fact_fecha,
							fatdiari.fact_consignado,
							fatdiari.fact_cliente,
							fatdiari.fact_a_nombre,
							fatdiari.fact_a_nombre_direccion,
							fatdiari.fact_despachado,
							fatdiari.fact_bultos_total,
							fatdiari.fact_peso_total,
							fatdiari.fact_cubicaje_total,
							fatdiari.fact_monto_fact_total,
							fatdiari.fact_monto_final
					 INTO :ls_no_pedido,   
							:ls_conoc_emb,   
							:ls_marca,   
							:ld_gastos,   
							:ld_fecha,
							:ls_consignado,
							:ll_tercero,
							:ls_a_nombre,
							:ls_a_direccion,
							:ls_despachado,
							:ll_bultos_total,
							:ld_peso_total,
							:ld_cubicaje_total,
							:ld_monto_fact_total,
							:ld_monto_final
	
					 FROM fatdiari  
					WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
							( fatdiari.fact_empresa		  = :str.empresa ) AND  
							( fatdiari.fact_ann   		  = :li_anio) AND  
							( fatdiari.fact_no_factura   = :ls_numero ) AND 
							( fatdiari.fact_tipo   = :ls_tipo ) AND 
							( fatdiari.fact_no_pedido not like '%NC%' );
	
						documento[ii_contador] = ls_no_pedido
	
						if SQLCA.sqlcode = 0 then
							ls_pedido_fac_1 = trim(ls_pedido_fac_1)+' '+trim(ls_no_pedido)
						end if
						ls_numero = ls_no_pedido // para recuperar detalle de gastos
				else
		
					ls_numero = ldw_4.GetItemString(ll_row,"fact_no_pedido")
					documento[ii_contador] = ls_numero
	
				  SELECT fatdiari.fact_no_factura,   
							fatdiari.fact_con_emb_no,   
							fatdiari.fact_marca,   
							fatdiari.fact_gastos_total,   
							fatdiari.fact_fecha,   
							fatdiari.fact_consignado,
							fatdiari.fact_cliente,
							fatdiari.fact_a_nombre,
							fatdiari.fact_a_nombre_direccion,
							fatdiari.fact_despachado,
							fatdiari.fact_bultos_total,
							fatdiari.fact_peso_total,
							fatdiari.fact_cubicaje_total,
							fatdiari.fact_monto_fact_total,
							fatdiari.fact_monto_final
					 INTO :ls_no_factura,   
							:ls_conoc_emb,   
							:ls_marca,   
							:ld_gastos,   
							:ld_fecha,
							:ls_consignado,
							:ll_tercero,
							:ls_a_nombre,
							:ls_a_direccion,
							:ls_despachado,
							:ll_bultos_total,
							:ld_peso_total,
							:ld_cubicaje_total,
							:ld_monto_fact_total,
							:ld_monto_final
					 FROM fatdiari  
					WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
							( fatdiari.fact_empresa		  = :str.empresa ) AND  
							( fatdiari.fact_ann   		  = :li_anio ) AND  
							( fatdiari.fact_no_pedido    = :ls_numero ) AND 
							( fatdiari.fact_tipo   = :ls_tipo ) AND 
							( fatdiari.fact_no_pedido not like '%NC%' ) ;
		
					if SQLCA.sqlcode = 0 then
						ls_pedido_fac_1 = trim(ls_pedido_fac_1)+' '+trim(ls_no_factura)
					end if
				end if
//				ls_numero = ''		
	
				if SQLCA.sqlcode = -1 then
					ls_error = sqlca.sqlerrText
					mensaje("Error","Se ha producido un error al leer el documento No. "+trim(ls_pedido_fac_1)+' '+trim(ls_no_pedido)+' '+ls_error,"")
				end if
				
				if SQLCA.sqlcode = 0 then
					if li_existe = 0 then	// Guarda datos del primer doc que encontró
						 dw.setitem(1,"ttra_fecha_factura",ld_fecha)
						 dw.setitem(1,"ttra_marca",ls_marca)
						 dw.setitem(1,"ttra_num_conoc_emb",ls_conoc_emb)
						 dw.setitem(1,"ttra_tercero",ll_tercero)
						 dw.setitem(1,"ttra_destinatario",ll_tercero)
						 dw.setitem(1,"ttra_consignado",ls_consignado)
						 dw.setitem(1,"ttra_dir_embarcador",ls_a_nombre)
						 dw.setitem(1,"ttra_dir_destinatario",ls_a_direccion)
					end if
						/*RECUPERA EL FLETE Y SEGURO EN FORMA SEPARADA*/
					
					if dw_5.retrieve(str.g_financiero,str.empresa,ls_numero,li_anio)> 0 then
						For li_lincar=1 to dw_5.rowcount()
							
							ld_monto_cargo =dw_5.getitemNumber(li_lincar,"dcar_monto")
							
							if isNull(ld_monto_cargo ) then ld_monto_cargo =0
							
							If dw_5.getitemString(li_lincar,"carg_flete_seguro")='S' then  // Seguro
								ld_seguro = ld_seguro + ld_monto_cargo
							end if
							If dw_5.getitemString(li_lincar,"carg_flete_seguro")='F' then  // Flete
								ld_flete = ld_flete + ld_monto_cargo
							end if
						Next
					end if

					ld_gastos_tot = ld_gastos_tot + ld_gastos
					li_existe = li_existe + 1
				end if
				ls_numero = ''		

	NEXT
	
end if

if li_existe > 0 then
	 tab_1.tabpage_2.dw_2.Reset()
	 ld_gastos_tot = ld_gastos_tot - ld_seguro - ld_flete
	 
	 dw.setitem(1,"ttra_flete",ld_flete)
	 dw.setitem(1,"ttra_seguro",ld_seguro)
	 dw.setitem(1,"ttra_otros",ld_gastos_tot)

	
	 wf_busca_deta_ent(1)	// Resume productos por arancel
	 dw = tab_1.tabpage_1.dw_1
	 
	 dw.setitem(1,"ttra_facturas",ls_pedido_fac_1)	// Acumula no de facturas
else
	if id_selec = 1 then 	// Factura			
	  messagebox("Factura no  Existe",is_pedido_fac)	
	else
	  messagebox("Pedido No Existe",is_pedido_fac)	
	end if
end if
str_tz_doctos.viene_de_buscar = 0 
ldw_4.Reset()
return



end subroutine

public subroutine wf_resumir_facturas ();Long ll_verifica, ll_detalle
String ls_pedido_fac

datawindow ldw_2
ldw_2 = tab_1.tabpage_2.dw_2

dw = tab_1.tabpage_1.dw_1

dw.acceptText()
// Valida existencia del documento
id_selec=dw.getitemNumber(1,"ttra_tipo_fact_pedido")

If id_selec <=  0 Then
	If dw.getitemNumber(dw.getrow(),"ttra_tipo_fact_pedido") <= 0 or &
		IsNull( dw.getitemNumber(dw.getrow(),"ttra_tipo_fact_pedido")) Then
		mensaje("Aviso ","Para procesar los Documentos es necesario que elija la opción de búsqueda deseada","")
		return
	Else
		id_selec=dw.getitemNumber(dw.getrow(),"ttra_tipo_fact_pedido")
	End If
End If

If len(Trim(dw.getitemString(dw.getrow(),"ttra_pedidos_fac"))) = 0 Then
	mensaje("Atención Estimado Usuario",&
	"Asegúrese de haber digitado los números de documentos correspondientes para poder hacer la búsqueda","")
	Return
End If

is_fob_cif 	  = dw.getitemString(dw.getrow(),"ttra_tipo_fob_cif")
id_porcentaje = dw.getitemNumber(dw.getrow(),"ttra_porcentaje")
	
if id_selec > 0 then 
	is_factura    = dw.getitemString(dw.getrow(),"ttra_facturas")
	is_pedido_fac = dw.getitemString(dw.getrow(),"ttra_pedidos_fac")
else
	mensaje("Atención ","Debe seleccionar la forma de búsqueda, Por Factura o por Pedido","")
	return
end if

is_pedido = dw.getitemstring(dw.getrow(),"ttra_pedido")
// Valida si el nùmero de documento fue seleccionado o digitado

//If Isnull(str_tz_doctos.anio) or str_tz_doctos.anio = 0 then
if str_tz_doctos.viene_de_buscar = 0 then	
	ii_anio_recupera = w_fa_fondo.str_param.anio
elseIf Isnull(str_tz_doctos.anio) or str_tz_doctos.anio = 0 then
	ii_anio_recupera = w_fa_fondo.str_param.anio
else
	ii_anio_recupera = str_tz_doctos.anio
end if

//*******************
SELECT count(*)  
 INTO :ll_verifica  
 FROM tzttraf0  
WHERE ( tzttraf0.ttra_g_financiero = :str.g_financiero ) AND  
		( tzttraf0.ttra_empresa = :str.empresa ) AND  
		( tzttraf0.ttra_ent_sal = "SA" ) AND  
		( tzttraf0.ttra_ann = :w_fa_fondo.str_param.anio ) AND  
		( tzttraf0.ttra_pedido = :is_pedido );

il_recalcular = 0			
if ll_verifica > 0 then		// Existe encabezado

  SELECT count(*)  
  INTO :ll_detalle  
  FROM tzdtraf1  
  WHERE ( tzdtraf1.traf_g_financiero = :str.g_financiero ) AND  
		( tzdtraf1.traf_empresa = :str.empresa ) AND  
		( tzdtraf1.traf_ent_sal = "SA" ) AND  
		( tzdtraf1.traf_ann = :w_fa_fondo.str_param.anio ) AND  
		( tzdtraf1.traf_pedido = :is_pedido )   ;

	 if ll_detalle = 0 Then
		If ldw_2.rowcount() > 0  then
		 	ll_detalle = ldw_2.rowcount()
		End If
	 End If

	 if ll_detalle > 0 then
			il_recalcular = MessageBox("","Documento Tiene Detalle.. ¿ Recalcular ? ",Exclamation!,OKCancel! , 2)
			IF il_recalcular = 1 THEN 
				il_recalcular = 0
				wf_borrar_detalle()			//Elimina el detalle
			else
				il_recalcular = 1
			end if
	 end if
end if


if il_recalcular = 0 then
	wf_valida_exist_detalle()	// Valida existencia de los documentos
end if

str_tz_doctos.viene_de_buscar = 0 
tab_1.tabpage_1.dw_4.Reset()
//***

end subroutine

public function integer wf_busca_deta_ent (integer ii_lineas);// Data Store para resumir detalle de la salida y su pase
// resumido al detalle de tráfico
			
if ii_contador <= 0 then return(0)

long	 recorrido, li_fila,li_bulto,li_linea,ll_rows,ll_filas
Decimal ld_cant, ld_frac, ld_total_piezas
Decimal	ld_cargo, ld_precio, ld_valor, ld_peso, ld_mconver, ld_porcentaje,ld_cant_x_linea,ld_cubicaje,ld_valor_tot
 
string	ls_arancel,ls_producto,ls_unidad,ls_aran_descrip,ls_fob_cif,ls_tipo_bulto,ls_tipo_empaque
string	ls_pedido_fac,ls_numero, ls_existe_aran, ls_error,ls_tipo
String	ls_resum_arancel_unidad, ls_unid,ls_unian, ls_resumir_a_unasola_unidad
integer	li_largo,li_caracter, li_anio

datawindow ldw_2,ldw_1,ldw_4
ldw_2=tab_1.tabpage_2.dw_2
ldw_1=tab_1.tabpage_1.dw_1
ldw_4=tab_1.tabpage_1.dw_4

datastore lds_detalle,lds_trabajo
// DataStore de trabajo para extraer los documentos de facturacion
lds_trabajo = create datastore
lds_trabajo.DataObject="dw_ca_tz_det_sal_facturas"
if tab_1.tabpage_1.cbx_varianza.checked then;ls_unid=lds_trabajo.DataObject+'_sf';lds_trabajo.DataObject=ls_unid;end if //dwo'subf(eavm)
lds_trabajo.SetTransObject(SQLCA)

// DataStore donde se acumulan los registros de los documentos
lds_detalle = create datastore
if str_tz_doctos.viene_de_buscar = 0 then	
	lds_detalle.DataObject="dw_ca_tz_det_sal_facturas" //No recupera con el tipo
else
	lds_detalle.DataObject="dw_ca_tz_det_sal_facturas_1"		//Recupera con el tipo
end if
if tab_1.tabpage_1.cbx_varianza.checked then;ls_unid=lds_detalle.DataObject+'_sf';lds_detalle.DataObject=ls_unid;end if //dwo'subf(eavm)
lds_detalle.SetTransObject(SQLCA)

// Se obtiene el largo de la cadena de pedidos para la búsqueda
If id_selec = 1 then	//Facturas
	li_largo = len(trim( dw.getitemString(1,"ttra_facturas")))	// Pedidos
else
	li_largo = len(trim( dw.getitemString(1,"ttra_pedidos_fac")))	// Pedidos
end if

if str_tz_doctos.viene_de_buscar = 0 then	

	li_caracter = 0
	For li_caracter = 1 to ii_contador
		ls_pedido_fac	= trim(documento[li_caracter])
		ll_rows  = lds_trabajo.Retrieve(str.g_financiero,str.empresa,ii_anio_recupera,'P',ls_pedido_fac)
		ll_filas =lds_trabajo.RowsCopy(1,lds_trabajo.rowcount(), primary!, lds_detalle, 1, primary!)
	NEXT
else
	li_caracter = 0
	For li_caracter = 1 to ldw_4.rowcount()
		ls_pedido_fac = ldw_4.GetItemString(li_caracter,"fact_no_pedido")
		li_anio   = ldw_4.GetItemNumber(li_caracter,"fact_ann")
		ls_tipo   = ldw_4.GetItemString(li_caracter,"fact_tipo")

		ll_rows  = lds_trabajo.Retrieve(str.g_financiero,str.empresa,li_anio,'P',ls_pedido_fac,ls_tipo)
		ll_filas =lds_trabajo.RowsCopy(1,lds_trabajo.rowcount(), primary!, lds_detalle, 1, primary!)
	NEXT
end if

	ll_rows = lds_detalle.rowCount()

	if ll_rows > 0 then	// Carga el arancel al dataStore

		recorrido = 1
		do while recorrido <= ll_rows
			  ls_producto=lds_detalle.getItemString(recorrido,"facd_codigo_item")

			  SELECT inmprodu.prod_arancel  
	  		   INTO :ls_arancel
	   		 FROM inmprodu  
	  			WHERE ( inmprodu.prod_g_financiero =:str.g_financiero ) AND  
	      		   ( inmprodu.prod_empresa 		=:str.empresa ) AND  
	         		( inmprodu.prod_producto		=:ls_producto ) ;   
			li_fila=recorrido
			If IsNull(ls_arancel) or ls_arancel='' then ls_arancel = 'Nulo'

			choose case SQLCA.sqlcode
				case 0
				   lds_detalle.setitem(recorrido,"facd_descripcion_alterna",ls_arancel)
				case -1
					ls_error = sqlca.sqlerrText
					commit;
					mensaje("Atención","Error buscar el arancel del producto "+ls_producto,ls_error)
					return 0
				case 100
					ls_arancel = ''
				   lds_detalle.setitem(recorrido,"facd_descripcion_alterna",ls_producto+' No.Existe')
			end choose

			commit;
			recorrido = recorrido + 1
		LOOP			
	end if

li_linea =ldw_2.rowcount()

if il_recalcular = 1 then
	li_linea = 0
end if

if IsNull(id_porcentaje) then 
	id_porcentaje = 0 
end if
If w_fa_fondo.str_param.subfactura_sn = 1 then
	ld_porcentaje = ldw_1.getItemNumber(1,"ttra_porcentaje")
	if IsNull(ld_porcentaje) then ld_porcentaje = 0
else
	ld_porcentaje = 0
end If
	
ld_porcentaje = (100 - ld_porcentaje)/100	// calcula el porcentaje a aplicar
// ls_tipo_bulto 	= Clase de bulto a utilizar  1=BULTOS 2=CARTONS 3 = ROLLOS
// ls_tipo_empaque= Tipo de empaque				  DOC
ls_fob_cif    		= ldw_1.getItemString(1,"ttra_tipo_fob_cif")
ls_tipo_bulto 		= ldw_1.getItemString(1,"ttra_flag")

ls_tipo_empaque	= ldw_1.getItemString(1,"ttra_revisado")
ls_resumir_a_unasola_unidad= ldw_1.getItemString(1,"ttra_resumir_a_unidad")

If ls_resumir_a_unasola_unidad = 'SI' and ( Not IsNull(ls_tipo_empaque) and trim(ls_tipo_empaque) <>'' ) then
	ls_resum_arancel_unidad = '0'	// La validación valida que sea mismo Arancel
else
	ls_resum_arancel_unidad = '1'	// La validación concatena Arancel+unidad
end if

if ll_rows > 0 then
		lds_detalle.SetSort("facd_descripcion_alterna A,facd_unidad_venta A")
		lds_detalle.Sort()
	 
	 recorrido = 1
	do while recorrido <= ll_rows

	   ls_arancel=lds_detalle.getItemString(recorrido,"facd_descripcion_alterna")
		if IsNull (ls_arancel) or ls_arancel='' then ls_arancel= 'Nulo'
			
		li_fila=recorrido
		li_linea =li_linea +1		
		
		  SELECT inaaranc.aran_descripcion
			 INTO :ls_aran_descrip
		    FROM inaaranc  
		   WHERE inaaranc.aran_arancel = :ls_arancel   
		ORDER BY inaaranc.aran_arancel ASC  ;

		ldw_2.scrolltorow(ldw_2.insertrow(0))

		choose case SQLCA.sqlcode
			case 0
			   ldw_2.setitem(li_linea,"traf_descripcion",ls_aran_descrip)
			case -1
				ls_error = sqlca.sqlerrText
				commit;
				mensaje("Atención","Error buscar la descripción del arancel "+ls_arancel,ls_error)
				return 0
			case 100
			   ldw_2.setitem(li_linea,"traf_descripcion",ls_arancel+' No existe Descripción')
		end choose

		commit;
		ldw_2.setitem(li_linea,"traf_arancel",ls_arancel)
		
		ls_unian = lds_detalle.getItemString(li_fila,"facd_unidad_venta")

		// Resume detalle de la entrada por arancel y / o unidad
		If ls_resum_arancel_unidad = '0' then //Resume sólo por arancel
			ls_unid =''
			ls_unidad = ''
		else	//concatena la unidad
			ls_unidad = lds_detalle.getItemString(li_fila,"facd_unidad_venta")
			ls_unid =ls_unidad
		end if
		
		ls_existe_aran ='N'
		
		DO WHILE  ls_arancel = lds_detalle.getItemString(li_fila,"facd_descripcion_alterna") &
			and li_fila	<= ll_rows  and ls_unidad = ls_unid	//lds_detalle.getItemString(li_fila,"facd_unidad_venta")
			ls_existe_aran ='S'
		   ls_unian   = lds_detalle.GetItemString(li_fila,"facd_unidad_venta")

			//* Busca la unidad de conversion 

			 SELECT inamedid.medi_cantidad
			 INTO	:ld_mconver
			 FROM inamedid  
			 WHERE inamedid.medi_medida = :ls_unian;
			 
			 if ld_mconver = 0 or IsNull(ld_mconver) then
				 ld_mconver = 1
			 end if

			ld_cant		     = lds_detalle.getItemNumber(li_fila,"facd_cantidad")
			ld_frac			  = lds_detalle.getItemNumber(li_fila,"facd_cantidad_fraccion")

			if IsNull(ld_cant) then ld_cant = 0
			if IsNull(ld_frac) then ld_frac = 0
			ld_cant_x_linea = (ld_mconver * ld_cant) + ld_frac   // Total de piezas

			if IsNull(ld_cant_x_linea) then ld_cant_x_linea = 0

			ld_total_piezas += ld_cant_x_linea	// total piezas por arancel

			ld_peso  = ld_peso + lds_detalle.getItemDecimal(li_fila,"facd_peso")
			li_bulto = li_bulto + lds_detalle.getItemNumber(li_fila,"facd_bultos")

			ld_cubicaje = ld_cubicaje + lds_detalle.getItemDecimal(li_fila,"facd_cubicaje")

			ld_valor = ld_valor + round(lds_detalle.getItemDecimal(li_fila,"facd_monto_final")*ld_porcentaje,2)

			li_fila = li_fila + 1
			if li_fila > ll_rows then exit

			If ls_resum_arancel_unidad = '1' then	//Resume por Arancel y unidad
				ls_unid = lds_detalle.getItemString(li_fila,"facd_unidad_venta")
			end if
			
		LOOP
		
		// Significa que el arancel no existe
		
		If ls_existe_aran ='N' then
		   ls_unian   = lds_detalle.GetItemString(li_fila,"facd_unidad_venta")
			
			//* Busca la unidad de conversion 

			 SELECT inamedid.medi_cantidad
			 INTO	:ld_mconver
			 FROM inamedid  
			 WHERE inamedid.medi_medida = :ls_unian;

			 
			 if ld_mconver = 0 or IsNull(ld_mconver) then
				 ld_mconver = 1
			 end if
			
			ld_cant		     = lds_detalle.getItemNumber(li_fila,"facd_cantidad")
			ld_frac			  = lds_detalle.getItemNumber(li_fila,"facd_cantidad_fraccion")

			if IsNull(ld_cant) then ld_cant = 0
			if IsNull(ld_frac) then ld_frac = 0

			ld_cant_x_linea = (ld_mconver * ld_cant) + ld_frac   // Total de piezas

			if IsNull(ld_cant_x_linea) then ld_cant_x_linea = 0

			ld_total_piezas += ld_cant_x_linea	// total piezas por arancel

			ld_peso  = ld_peso + lds_detalle.getItemDecimal(li_fila,"facd_peso")
			li_bulto = li_bulto + lds_detalle.getItemNumber(li_fila,"facd_bultos")

			ld_cubicaje = ld_cubicaje + lds_detalle.getItemDecimal(li_fila,"facd_cubicaje")

			ld_valor = ld_valor + round(lds_detalle.getItemDecimal(li_fila,"facd_monto_final")*ld_porcentaje,2)
			li_fila = li_fila + 1
		end if

		IF trim(ls_tipo_bulto) = '1' then 
			ldw_2.setitem(li_linea,"traf_descrip_bulto",'BULT')
		elseiF trim(ls_tipo_bulto) = '2' then 
			ldw_2.setitem(li_linea,"traf_descrip_bulto",'CTNS')
		elseIf trim(ls_tipo_bulto) = '3' then
			ldw_2.setitem(li_linea,"traf_descrip_bulto",'PALET')
		elseIf trim(ls_tipo_bulto) = '4' then
			ldw_2.setitem(li_linea,"traf_descrip_bulto",'ROLLOS')
		end if
		
		//	Asignación de unidad de empaque requerida
		 If ls_resum_arancel_unidad = '0'	then	// Sólo resume por arancel 
			 is_unian    = ls_tipo_empaque //Tipo de Empaque DO/PZ/GR
		 else
			 is_unian = ls_unian
		 end if
		
		 wf_convierte_cantidad(is_unian,ld_total_piezas)
		 
		ldw_2.setitem(li_linea,"traf_peso_bruto",ld_peso)
		ldw_2.setitem(li_linea,"traf_cant_bultos",li_bulto)
		ldw_2.setitem(li_linea,"traf_valor",ld_valor)
		ldw_2.setitem(li_linea,"traf_cubicaje",ld_cubicaje)		
		ldw_2.setitem(li_linea,"traf_g_financiero",str.g_financiero)
		ldw_2.setitem(li_linea,"traf_empresa",str.empresa)
		ldw_2.setitem(li_linea,"traf_ent_sal",'SA')
		ldw_2.setitem(li_linea,"traf_ann",w_fa_fondo.str_param.anio)
		ldw_2.setitem(li_linea,"traf_pedido",is_pedido)
		ldw_2.setitem(li_linea,"traf_linea",li_linea)
		ldw_2.setitem(li_linea,"traf_empaque_um",is_unian)
		ld_valor_tot += ld_valor
		
		recorrido = li_fila
		ld_cubicaje = 0
		ld_peso  = 0
		li_bulto = 0
		ld_cargo = 0
		ld_precio = 0
		ld_valor = 0
		ld_total_piezas = 0
		if recorrido > ll_rows then exit	
	LOOP	//while recorrido <= ll_rows
	 m_fa_principal.m_archivo.m_imprimir.enabled = false
	 m_fa_principal.m_archivo.m_guardar.enabled = True	 
	 tab_1.tabpage_2.enabled = true
	 tab_1.tabpage_1.dw_1.setItem(tab_1.tabpage_1.dw_1.getRow(),"ttra_monto",ld_valor_tot)
end if

destroy lds_detalle
destroy lds_trabajo
return(ll_rows)



end function

on w_ca_tz_salidas.create
int iCurrent
call super::create
if this.MenuName = "m_fa_principal" then this.MenuID = create m_fa_principal
this.st_1=create st_1
this.sle_nom_ventana=create sle_nom_ventana
this.gb_nom_ventana=create gb_nom_ventana
this.st_nom_ventana=create st_nom_ventana
this.dw_5=create dw_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.sle_nom_ventana
this.Control[iCurrent+3]=this.gb_nom_ventana
this.Control[iCurrent+4]=this.st_nom_ventana
this.Control[iCurrent+5]=this.dw_5
end on

on w_ca_tz_salidas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.sle_nom_ventana)
destroy(this.gb_nom_ventana)
destroy(this.st_nom_ventana)
destroy(this.dw_5)
end on

event ue_post_open;call super::ue_post_open;Integer li_para_ent,recorrido,li_ped,li_hay,li_mostrar, li_desde, li_pais_salida
string 	ls_where, ls_original,ls_max
Int   i,li_largo,li_ancho,li_papel_ant,li_width_ant,li_length_ant,li_hnd,li_p1
LONG 	li_p2, ll_max
st_nom_ventana.text = this.classname()

gf_tr_param()

id_selec = 1	// Por defecto la búsqueda es por factura 

f_create_external_func_uo(iu_externa)	// 

tab_1.tabpage_1.dw_1.settransobject(SQLCA)
tab_1.tabpage_1.dw_4.settransobject(SQLCA)

Tab_1.tabpage_1.dw_1.GetChild ("ttra_pedido",dch_ped)
dch_ped.SetTransObject(SQLCA);
if dch_ped.retrieve(str.g_financiero,str.empresa,"SA",w_fa_fondo.str_param.anio)<=0 then dch_ped.insertrow(0)
dch_ped.SetSort('1 A')
dch_ped.Sort()
//
tab_1.tabpage_1.dw_1.GetChild('ttra_pais_origen',dwc_pais_o)
dwc_pais_o.settransobject(SQLCA) 
If dwc_pais_o.retrieve() <= 0 then dwc_pais_o.insertRow(0)

// Child de transportista
tab_1.tabpage_1.dw_1.GetChild('ttra_transportador',dwc_trasporte)
dwc_trasporte.settransobject(SQLCA) 
If dwc_trasporte.retrieve() <= 0 Then dwc_trasporte.InsertRow(0)
//
tab_1.tabpage_1.dw_1.GetChild('ttra_pais_destino',dwc_pais_d)
dwc_pais_d.settransobject(SQLCA) 
dwc_pais_d.retrieve()

tab_1.tabpage_1.dw_1.GetChild('ttra_puerto_destino',dwc_puerto_d)
dwc_puerto_d.settransobject(SQLCA) 
If dwc_puerto_d.retrieve(1) < 1 then dwc_puerto_d.InsertRow(0)

tab_1.tabpage_1.dw_1.GetChild('ttra_puerto_trasbordo',dwc_puerto_trasb)
dwc_puerto_trasb.settransobject(SQLCA) 
If dwc_puerto_trasb.retrieve(1) < 1 then dwc_puerto_trasb.InsertRow(0)

tab_1.tabpage_1.dw_1.GetChild('ttra_puerto_salida',dwc_puerto_salida)
dwc_puerto_salida.settransobject(SQLCA) 

SELECT tzaparam.para_num_pais  
 INTO :li_pais_salida  
 FROM tzaparam  
	where para_g_financiero=:str.G_financiero and 
	para_empresa=:str.empresa;

If dwc_puerto_salida.retrieve(li_pais_salida) <=0 then dwc_puerto_salida.insertrow(0)

ii_first_time = 1 // Indica que no debe validar salvado, pero sí buscar secuencia

if tab_1.tabpage_1.dw_1.rowcount()=0 then
	this.triggerevent("ue_adicionar")
end if
// Declaracion de datawindows Child

If w_fa_fondo.str_param.imp_x_renglones = 11 then
	tab_1.tabpage_2.dw_2.DataObject = 'dw_ca_tz_det_entradas_textiles'
else
	tab_1.tabpage_2.dw_2.DataObject = 'dw_ca_tz_det_entradas'
end if

Tab_1.tabpage_2.DW_2.GetChild ("traf_arancel",dwc_arancel)
Tab_1.tabpage_2.DW_2.GetChild ("descripcion_arancel",dwc_arancel2)
dwc_arancel.SetTransObject(SQLCA);
dwc_arancel2.SetTransObject(SQLCA);
tab_1.tabpage_2.DW_2.SetTransObject(SQLCA);

// Valida y mofifica el formato de edición de la cantidad, si la empresa utiliza
// decimales en cantidad del producto

 if w_fa_fondo.str_param.decimales_sino = 1 then
	tab_1.tabpage_2.DW_2.object.decimales_sino.expression = "'"+'1'+"'"
	tab_1.tabpage_2.dw_2.object.traf_cantidad.edit.format='###,##0.00'
	tab_1.tabpage_2.dw_2.object.traf_cantidad.format='###,##0.00'
else 
	tab_1.tabpage_2.DW_2.object.decimales_sino.expression = "'"+'0'+"'"
	tab_1.tabpage_2.dw_2.object.traf_cantidad.edit.format='###,##0'	
	tab_1.tabpage_2.dw_2.object.traf_cantidad.format='###,##0'	
end if	


dw = Tab_1.tabpage_1.dw_1

is_secuencia_nueva=is_pedido // Guarda la próxima secuencia disponible


//Deshabilita los botones
wf_botones()  
  	  
// Para que se posicione en el campo de numero de pedido

dw.setcolumn(2)
dw.setfocus()
dw.setitem(dw.getrow(),"ttra_pedido",is_pedido)

//dw.resetUpdate()
dw.setItemStatus(1,0 ,Primary! ,NotModified!)

//*****************************************************************************
//Re-Asigna la impresora predeterminada con la que se encuentre en el parametro
//como impresora para los documentos de Movimiento Comercial Devuelve la 
//impresora predeterminada
//*****************************************************************************

// OJO OJO OJO DESCONECTADA TEMPORALMENTE
Environment env
Integer	rtn

rtn = GetEnvironment(env)
/*Verifica el sistema operativo */

CHOOSE CASE env.OSType
	case windows!
		is_win9598_winnt='win9598'
		is_impr_actual = gf_asigna_printer_trafico()
	case WindowsNT!
		is_win9598_winnt='winnt'
END CHOOSE

dw.Object.integrado.Expression = "'"+w_fa_fondo.str_param.integrado_independiente+"'"

dw.Object.subfactura_sn.Expression = "'"+string(w_fa_fondo.str_param.subfactura_sn)+"'"

If w_fa_fondo.str_param.integrado_independiente = 'I' Then
	wf_habilita_objetos(True)
Else
	wf_habilita_objetos(False)
End If

dw_5.SetTransObject(SQLCA);

end event

event closequery;//Override

integer respuesta,rtn
datawindow ldw_1, ldw_2
yield()
// OJO OJO OJO DESCONECTADA TEMPORALMENTE
Environment env

rtn = GetEnvironment(env)
/*Verifica el sistema operativo */

CHOOSE CASE env.OSType
	case windows!
		gf_asigna_printer_default(is_impr_actual)
	case WindowsNT!
END CHOOSE

ldw_1 = tab_1.tabpage_1.dw_1
ldw_2 = tab_1.tabpage_2.dw_2

If (ldw_2.ModifiedCount( ) + ldw_2.deletedcount() > 0) or &
	 (ldw_1.ModifiedCount( ) + ldw_1.deletedcount() > 0)  then

		respuesta = messagebox("Atención","La Información del Documento no ha sido guardado!  ~n" + &
		                       "     ... Desea guardarla ahora?",question!,YesNoCancel!) 
		choose case respuesta 
			case 1 
				this.triggerevent("ue_aceptar") 
			case 2
				ROLLBACK using sqlca; 	
		   case 3
             return 1
		end choose
end if


end event

event open;call super::open;//this.x=1
//wf_centrar()
this.y = 0
this.x = 805

sqlca.autocommit=true
end event

event ue_aceptar;//Rutina en la cual se guarda tanto el encabezado y el detalle de la Factura
String 	 ls_actualizo,ls_pedido
Long		 ll_update,ll_update2, ll_del_modify, ll_max
Integer	 li_entro, li_hay, li_delete
Double 	 ld_monto

dwItemStatus l_status
this.setredraw(false)

sqlca.autocommit=false

datawindow ldw_1
ldw_1 = tab_1.tabpage_1.dw_1
DW=tab_1.tabpage_2.dw_2
//***********************
	SELECT count(*) 
	INTO	:li_hay
  	  FROM tzttraf0  
  	 WHERE ( tzttraf0.ttra_g_financiero = :str.g_financiero ) AND  
  	       ( tzttraf0.ttra_empresa = :str.empresa ) AND  
  	       ( tzttraf0.ttra_ent_sal = 'SA' ) AND  
  	       ( tzttraf0.ttra_ann 	 = :w_fa_fondo.str_param.anio ) AND  
  	       ( tzttraf0.ttra_pedido  = :is_pedido );    

	if li_hay = 0 THEN
		// Documento es nuevo y debe actualizar secuencia
		is_act_secuencia = ''
		//	Actualiza la Secuencia si no existe
		SELECT tzaparam.para_sec_salidas
		 INTO :ll_max
		 FROM tzaparam
		WHERE ( tzaparam.para_g_financiero 	= :str.g_financiero ) AND
				( tzaparam.para_empresa 		= :str.empresa );
		If SQLCA.SQLCODE = -1 Then
			sqlca.autocommit=true
			mensaje("Atención","Error al leer secuencia de la Salida","")
			return
		end If
		if ll_max +1 = long(is_pedido) Then
			wf_actualiza_secuencia()
		End If
	Else
		l_status = ldw_1.GetItemStatus(ldw_1.GetRow(), 0, Primary!)
		
		If l_status = New! or  l_status = NewModified!  Then
			//Obtener nueva secuencia
			is_pedido 		= wf_busca_pedido(ll_max) 	// Busca #Próximo Sec Ped disponible 
			mensaje("Atención ","La secuencia de la Salida ha cambiado y el próxima disponible es : "+is_pedido,"")
			is_act_secuencia = ''
			//	Verifica la proxima sec disponible y actualiza la misma
			// modifica el número de Traspaso en el ecabezado
			wf_actualiza_secuencia()
			ldw_1.setItem(ldw_1.getRow(),"ttra_pedido",is_pedido)
			//wf_setear_lineas()
		End if
	end if

ll_update=tab_1.tabpage_1.dw_1.update()

if ll_update = 1 then
	//Actualizo encabezado del documento
	commit using sqlca;
	ldw_1.retrieve(str.g_financiero,str.empresa,"SA",w_fa_fondo.str_param.anio,is_pedido)
	tab_1.tabpage_2.enabled = true
	st_1.visible = false
	if	is_act_secuencia = 'S' then
		is_act_secuencia = ''
		dch_ped.retrieve(str.g_financiero,str.empresa,'SA',w_fa_fondo.str_param.anio)
	end if
else
	rollback using sqlca;
	sqlca.autocommit=true
	messagebox("Atención","¡Error al Actualizar el Encabezado!")	
end if
 
if ll_update <> 1 then
	sqlca.autocommit=true
   messagebox("Atención","¡No se puede Actualizar el Detalle!")
	return
end if


DW=tab_1.tabpage_2.dw_2

l_status = dw.GetItemStatus(dw.GetRow(), 0, Primary!)

ll_del_modify = dw.ModifiedCount( ) + dw.deletedcount()

wf_setear_lineas()  // Elimina las líneas de detalle que están en blanco
							// y reasigna num documento al detalle y el número de línea 
 is_guardando =' '
 li_delete = tab_1.tabpage_2.dw_2.deletedcount()
 ll_update2= tab_1.tabpage_2.dw_2.update()

 if ll_update2 = 1 then
	// Actualiza el detalle del documento 
	tab_1.tabpage_3.enabled = true
	commit using sqlca;
	dw.retrieve(str.g_financiero,str.empresa,'SA',w_fa_fondo.str_param.anio,is_pedido)
 else
	rollback using sqlca;
	sqlca.autocommit=true
	messagebox("Atención","¡Error al Actualizar el Detalle!")
 end if
sqlca.autocommit=true

 m_fa_principal.m_archivo.m_imprimir.enabled = true
 m_fa_principal.m_archivo.m_reimprimir.enabled = true
 m_fa_principal.m_archivo.m_guardar.enabled = false
 m_fa_principal.m_edicin.m_adicionar.enabled = true
 this.setredraw(true)
 
 
end event

event ue_adicionar;// Valida el salvado del documento y si debe o no buscar la secuencia
// del mismo en forma automática o no
Long	ll_row
ll_row = 0

If dw= tab_1.tabpage_1.dw_1 then
	If ii_first_time <> 1 then // Si viene del Post_open no debe hacer esta validación
		If Trigger Event ue_valida_salvado() =1 then return
	end If
	w_ca_tz_salidas.setredraw(False)
	tab_1.tabpage_2.dw_2.Reset()
	tab_1.tabpage_1.dw_1.Reset()
	dw= tab_1.tabpage_1.dw_1
	If ii_first_time <> 2 then	// si es 2 indica que se va a utilizar un número 
										// de Pedido distinto a la secuencia
		is_pedido = wf_busca_pedido(ll_row) 	 
	end If
	ii_first_time = 0
end If
// Adiciona un nuevo Registro

//
if dw = Tab_1.tabpage_2.dw_2 then
	if dw.rowcount() = 0 then
		ll_row = dw.insertrow(0)
		dw.scrolltorow(ll_row)
		dw.setitem(ll_row,"traf_g_financiero",str.g_financiero)
		dw.setitem(ll_row,"traf_empresa",str.empresa)
		dw.setitem(ll_row,"traf_ent_sal",'SA')
		dw.setitem(ll_row,"traf_ann",w_fa_fondo.str_param.anio)
		dw.setitem(ll_row,"traf_pedido",is_pedido)
		dw.setitem(ll_row,"traf_linea",ll_row)
		dw.setcolumn(1)
	else
		tab_1.tabpage_3.enabled = true      //Impresión
	end if
else
	// Si es en el tab uno  (Encabezado)
	if dw.rowcount() = 0  then
		dw.scrolltorow(dw.insertrow(0))
		dw.setitem(dw.getrow(),"ttra_g_financiero",str.g_financiero)
		dw.setitem(dw.getrow(),"ttra_empresa",str.empresa)
		dw.setitem(dw.getrow(),"ttra_ann",w_fa_fondo.str_param.anio)
		dw.setitem(dw.getrow(),"ttra_ent_sal",'SA')
		dw.setitem(dw.getrow(),"ttra_pedido",is_pedido)
		dw.setitem(dw.getrow(),"ttra_fecha_reg",gf_fecha_serv())
		tab_1.tabpage_2.dw_2.reset()
		tab_1.tabpage_2.enabled = false
		tab_1.tabpage_3.enabled = false
		st_1.visible = true				
	   m_fa_principal.m_archivo.m_imprimir.enabled = false		//Boton de imprimir
		m_fa_principal.m_archivo.m_reimprimir.enabled = false
//	   m_fa_principal.m_edicin.m_adicionar.enabled = false		//Boton de adicionar
		dw.setcolumn(2)
	end if
	w_ca_tz_salidas.setredraw(True)
end if

end event

event ue_eliminar;
this.setredraw(false)
Integer li_resultado,li_rows,li_rowsdet,li_fila_det
Double	ld_monto_detalle, ld_monto
Datawindow ldw_1,ldw_2

ldw_1 = tab_1.tabpage_1.dw_1
ldw_2 = tab_1.tabpage_2.dw_2

if dw.rowcount() > 0  then
		
		//Confirmar borrado
		li_resultado = messagebox("ATENCIÓN SR. USUARIO","Esta seguro de Eliminar hg ",Exclamation!,OKCancel!,2)

		if li_resultado = 1 then

			if dw = ldw_1 then

				// Borra el Detalle del registro si es todo el datawindow
				li_fila_det = ldw_2.rowcount()
				if ldw_2.rowcount() >0 then
					wf_borrar_detalle()
					li_rowsdet = ldw_2.update()
					//Salva la informacion del detalle del documento
					if li_rowsdet = 1 then
						commit ;
					else
						rollback;
						messagebox("ATENCIÓN SR. USUARIO","Error al  Eliminar Detalle, Verifique",Stopsign!)
						return
					end if	

					if ldw_2.rowcount() = 0 then
						ldw_2.scrolltorow(ldw_2.insertrow(0))
						ldw_2.setcolumn(1)
					else
						tab_1.tabpage_3.enabled = true      //Impresión
					end if

				end if
				// Si existe detalle y no se actualizo el borrado 
				// no puede actualizar encabezado
				
				if li_fila_det > 0 and li_rowsdet <> 1 then return
					
			end if

			If dw = ldw_1 Then
				if dw.rowcount() > 0  then
					li_rows = dw.deleterow(dw.getrow())
				end if
			Else
				if dw.rowcount() > 0  then
					ld_monto_detalle  = ldw_2.GetItemNumber(ldw_2.GetRow(),"traf_valor")
					ld_monto 			= ldw_1.GetItemNumber(ldw_1.GetRow(),"ttra_monto")
					
					If IsNull(ld_monto_detalle ) Then ld_monto_detalle =0
					If IsNull(ld_monto ) Then ld_monto =0
					
					ld_monto 			= ld_monto - ld_monto_detalle
					ldw_1.setItem(ldw_1.getRow(),"ttra_monto",ld_monto)

					li_rows = dw.deleterow(dw.getrow())
				end if
			End If

			if li_rows = 1 then		//Si elimino satisfactoriamente, guardar
				wf_salvar()
			else
				messagebox("ATENCIÓN SR. USUARIO","Error al Eliminar Encabezado, Verifique",Stopsign!)
			end if
		
			if dw.rowcount() = 0  then
				this.triggerevent("ue_adicionar")   //Para que no quede sin pintar la pantalla
			end if
		end if
else
	messagebox("Atención","No hay registros para borrar!")
end if

m_fa_principal.m_archivo.m_imprimir.enabled = false
m_fa_principal.m_archivo.m_reimprimir.enabled = false
tab_1.tabpage_3.enabled = false
m_fa_principal.m_archivo.m_guardar.enabled = True		
this.setredraw(true)		
				
end event

event ue_prox_dw;call super::ue_prox_dw;DwItemStatus ls_estatus1,ls_estatus2
Datawindow ldw_1
ldw_1 = tab_1.tabpage_1.dw_1
integer li_hay, li_recuperadas

CHOOSE CASE ii_nex_tab
		
	CASE 1
		dw = tab_1.tabpage_1.dw_1
		ls_estatus1=	dw.GetItemStatus(dw.getrow(),"ttra_pedido",primary!)
		If ls_estatus1 <> NotModified!  Then 
		  li_recuperadas = dw.retrieve(str.g_financiero,str.empresa,'SA',w_fa_fondo.str_param.anio,is_pedido)
		  if li_recuperadas = 0 then
				messagebox("ATENCIÓN SR. USUARIO","Entrada No existe..",Exclamation!)
		  end if
		  //Verifica si el doc tiene detalle y dependiendo de esto, 
		  // habilita o no la vista previa
			li_hay = wf_existe()	
			tab_1.tabpage_2.dw_2.enabled = true	//DataWindow del Detalle				
			if li_hay > 0 then 
				tab_1.tabpage_3.enabled = true		//Vista previa
			else
				tab_1.tabpage_3.enabled = false		//Vista previa
			end if	
		  dw.triggerevent("ue_tab")
	   End If     			

   CASE 2
//      wf_valida_rowchange()	// En resumen son las 4 líneas de abajo
		yield()
		If dw.Rowcount () + dw.modifiedcount()+dw.deletedcount() > 0 Then  //Si hay lineas en el detalle
			dw.retrieve(str.g_financiero,str.empresa,'SA',w_fa_fondo.str_param.anio,is_pedido)
		End If	
END ChooSE

end event

event ue_insertar;call super::ue_insertar;idw_proximo=dw

end event

event ue_primer_reg;if dw=tab_1.tabpage_1.dw_1 then
	dw.scrolltorow(3)
else
	dw.scrolltorow(1)
end if


end event

event ue_reg_anterior;dw.scrollpriorrow()
end event

event ue_siguiente_reg;dw.scrollnextrow()

end event

event ue_ultimo_reg;dw.scrolltorow(dw.rowcount())

end event

event ue_print;Integer li_lineas,li_pos
String	ls_hora
Datawindow	ldw_3

	wf_desactiva_titulos()
	dw = 	tab_1.tabpage_3.dw_3
	ldw_3 = dw

	ls_hora = string(gf_fecha_serv(), "dd/mm/yyyy hh:mm AM/PM")
	li_pos = Pos(ls_hora," ")

	ls_hora ='Hora '+Right(ls_hora, Len(ls_hora) - li_pos)		
	
	ldw_3.object.hora.expression = "'"+ls_hora+"'"
	
	OpenWithParm(w_dw_print_options, ldw_3)

	If Message.DoubleParm = -1 Then Return

	dw = 	tab_1.tabpage_3.dw_3

	If is_win9598_winnt='win9598' then
		
		// abrir ventana de seleccion de modelo de impresora  
	
		OpenwithParm(w_tz_co_selec_modelo_print,str_tz_doctos)
			
		str_tz_doctos = message.PowerObjectParm
		dw = 	tab_1.tabpage_3.dw_3
		
		if isvalid(str_tz_doctos) and Not IsNull(str_tz_doctos) then 
			
			if str_tz_doctos.aceptar = false then return
			
			if Isnull(str_tz_doctos.largo_doc) or str_tz_doctos.largo_doc = 0 or &
				Isnull(str_tz_doctos.ancho_doc) or str_tz_doctos.ancho_doc = 0 then 
				mensaje("Atención ","Debe asignarle los parámetros de largo y ancho del documento para la impresora seleccionada ...Ok","")
				return
			end If
			gf_dg_tamano_pagina(str_tz_doctos.largo_doc,str_tz_doctos.ancho_doc,ldw_3)
		end If
	end If
	
	ldw_3.object.datawindow.print.preview = 'yes'
	ldw_3.object.datawindow.print.preview.zoom =100
	
	dw = 	tab_1.tabpage_3.dw_3
	If w_fa_fondo.str_param.imp_x_renglones = 1 or is_dw ='11' then
		li_lineas = 8
	else
		li_lineas = w_fa_fondo.str_param.imp_x_renglones
	end if

	// Funcion que imprime 2 veces cada pagina en forma consecutiva
	gf_tz_rango_page(ldw_3,li_lineas)	
	
	str.frame.setmicrohelp(" ")
	wf_activa_titulos()

end event

event activate;If not IsValid(m_fa_principal) Then
	ChangeMenu(m_fa_principal)
End If

end event

type tab_1 from w_grampa_tab`tab_1 within w_ca_tz_salidas
integer x = 9
integer y = 28
integer width = 3150
integer height = 1784
integer taborder = 0
long backcolor = 8421376
boolean powertips = true
boolean boldselectedtext = true
boolean pictureonright = true
end type

event tab_1::selectionchanged;call super::selectionchanged;String ls_arancel, ls_datawindow, ls_dwobj, ls_empre, ls_error
Boolean lb_readonly
Long	ll_row
Integer	li_page, li_largo_dwobj

Datawindow ldw_2,ldw_3

ldw_2 = tab_1.tabpage_2.dw_2

Int  i,li_papel_ant,li_width_ant,li_length_ant,li_hnd,li_largo
LONG li_ancho
If not IsValid(m_fa_principal) Then
	ChangeMenu(m_fa_principal)
End If
CHOOSE CASE newindex
 CASE 1
	dw = tab_1.tabpage_1.dw_1
	m_fa_principal.m_edicin.m_adicionar.enabled = true	//Boton de adicionar
	
	dw.setfocus()
	dw.setcolumn(2)
 CASE 2
   dw = tab_1.tabpage_2.dw_2
	ldw_2 = dw
	m_fa_principal.m_edicin.m_adicionar.enabled = false	//Boton de adicionar

	lb_readonly = tab_1.tabpage_2.dw_2.enabled
	ldw_2.setfocus()
	ldw_2.setcolumn(1)
  // Validacion para que cuando se cambie al detalle se adicione una linea al final
  // y si esta enblanco el codigo de producto, no siga adicionando
  	yield()
	if ldw_2.rowcount() = 0 then
		iw_this.triggerevent("ue_adicionar")
	else 
//	 	if lb_readonly then //Si la entrada no ha sido eliminada
	 		yield() 
	  		ldw_2.accepttext()
	  		ls_arancel = ldw_2.GetItemString(ldw_2.rowcount(),"traf_arancel")

			If ldw_2.ModifiedCount() > 0 and ( len(trim(ls_arancel)) > 0 and not isnull(ls_arancel)) then 
				iw_this.triggerevent("ue_aceptar")
			End if

	  		If len(trim(ls_arancel)) > 0 and not isnull(ls_arancel)  then
				iw_this.triggerevent("ue_adicionar")
			End if
//		End if 
	End if

 CASE 3
	dw = tab_1.tabpage_3.dw_3
	ldw_3 = dw
	m_fa_principal.m_edicin.m_adicionar.enabled = false	//Boton de adicionar

	ls_datawindow ='dw_ca_tz_imp_salidas'
	If IsNull ( w_fa_fondo.str_param.imp_x_renglones ) THEN
		mensaje("Atención ","No se ha configurado el Formato a utilizar para la impresión del Documento Comercial "+ &
		" Debe ir a parámetros Generales y seleccionar en el campo .. Formato de Documento Comercial .."+ &
		"la opción a utilizar ...gracias ..!!!","")
		return
	end If

/// agregado por arturo 01/03/2001
/*Datawindow 12 sólo existe para Entradas - Tempo*/
If w_fa_fondo.str_param.imp_x_renglones = 12 then w_fa_fondo.str_param.imp_x_renglones = 10

	CHOOSE CASE w_fa_fondo.str_param.imp_x_renglones
		CASE 1	// 8 Registros
			tab_1.tabpage_3.dw_3.DataObject = "dw_ca_tz_imp_salidas_afisa"
		CASE 10	// 10 Registros todo el mundo
			tab_1.tabpage_3.dw_3.DataObject = ls_datawindow+trim(string(w_fa_fondo.str_param.imp_x_renglones))
		CASE 11	// 10 Formato para pocos registros (Textiles)

//			tab_1.tabpage_3.dw_3.DataObject = ls_datawindow+trim(string(w_fa_fondo.str_param.imp_x_renglones))
			tab_1.tabpage_3.dw_3.DataObject = ls_datawindow+'10'

			/* w_fa_fondo.str_param.totales_en_linea_10 */
			/* Setear 0 a parámetro totales_en_linea_10 y 1 a inserta_totales */
	
			sqlca.Autocommit = false;
	
			  UPDATE tzaparam  
				  SET para_totales_en_linea_10 = 0,   
						para_inserta_lin_totales = 1,
						para_imp_total_despues_lin10=0
				WHERE ( tzaparam.para_g_financiero = :str.g_financiero ) AND  
						( tzaparam.para_empresa = :str.empresa );
						
						If SQLCA.sqlcode= -1 then
							ls_error = sqlca.sqlerrText
							rollback;
							mensaje("Atención ","Se ha producido un error al setear parámetros de totales",ls_error)
							Return
						end if
						sqlca.Autocommit = true;
						
						w_fa_fondo.str_param.inserta_lin_totales = 1
						w_fa_fondo.str_param.totales_en_linea_10 = 0
		CASE 13	// 10 Formato Especial Issa
			tab_1.tabpage_3.dw_3.DataObject = ls_datawindow+'_issa'+trim(string(w_fa_fondo.str_param.imp_x_renglones))
		CASE ELSE
			mensaje("Atención ","No se ha configurado el formato de impresión +&
			del documento Comercial ","Entre a parámetros de la aplicación, opción +&
			'Parámetros Generales y seleccione el formato.. gracias..!!' ")
			Return
	END CHOOSE

/// termina agregado por arturo 01/03/2001

		ldw_3.settransobject(sqlca)		
		ls_empre = gf_fa_nom_empr( str.g_financiero , str.empresa)
		ldw_3.object.nom_empresa.expression = "'"+ls_empre +"'"
		ldw_3.object.nom_empresa1.expression = "'"+ls_empre +"'"

		//Valida si el cliente trabaja con decimales
		If w_fa_fondo.str_param.decimales_sino = 1 then
			ldw_3.object.decimales_sino.expression = "'"+'1'+"'"
		else
			ldw_3.object.decimales_sino.expression = "'"+'0'+"'"
		end if

		If IsNull (w_fa_fondo.str_param.imp_gastos_en_sal_trasp) then w_fa_fondo.str_param.imp_gastos_en_sal_trasp = 0

		ldw_3.object.imp_gastos.expression = "'"+string(w_fa_fondo.str_param.imp_gastos_en_sal_trasp)+"'"

	// Obtiene el los 2 ultimos caract del nombre del dw impresion

	ls_dwobj = tab_1.tabpage_3.dw_3.DataObject
	
	li_largo_dwobj = len(trim(tab_1.tabpage_3.dw_3.DataObject))
	
	is_dw    = mid ( ls_dwobj, li_largo_dwobj - 1, li_largo_dwobj)

	//**/	if is_dw ='11' then is_dw = '10'	/*Textiles*/
	/**/	if is_dw ='13' then is_dw = '10'	/*Issa*/

	ldw_3.retrieve(str.g_financiero,str.empresa,'SA',w_fa_fondo.str_param.anio,is_pedido)

	//* Script para la asignacion del tamaño de página ....

	li_hnd = Handle(parent)	// Long que identifica el objeto 
//	li_largo = 2370	// largo
	li_largo = 2375	// largo
	li_ancho = 3500	// ancho

	If is_win9598_winnt='win9598' then
		gf_dg_tamano_pagina(li_largo,li_ancho,ldw_3)
	end if
	ldw_3.object.datawindow.print.preview = 'yes'
	ldw_3.object.datawindow.print.preview.zoom =100
END CHOOSE

end event

type tabpage_1 from w_grampa_tab`tabpage_1 within tab_1
integer width = 3113
integer height = 1656
long backcolor = 12639424
string pointer = "HyperLink!"
string text = "Generales"
long tabtextcolor = 8388608
long tabbackcolor = 12639424
string picturename = "NestedReport!"
long picturemaskcolor = 553648127
string powertiptext = "Captura del Encabezado de la Salida"
dw_4 dw_4
cb_procesar cb_procesar
cb_1 cb_1
cbx_varianza cbx_varianza
end type

on tabpage_1.create
this.dw_4=create dw_4
this.cb_procesar=create cb_procesar
this.cb_1=create cb_1
this.cbx_varianza=create cbx_varianza
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.cb_procesar
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cbx_varianza
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_4)
destroy(this.cb_procesar)
destroy(this.cb_1)
destroy(this.cbx_varianza)
end on

type dw_1 from w_grampa_tab`dw_1 within tabpage_1
event ue_post_clicked ( )
event insertar ( )
event consultar ( )
event ue_tab ( )
event ue_valida_ped ( )
event ue_postitemchanged ( string data,  long row,  string columna )
event ue_down pbm_dwnkey
event ue_helpcol ( )
integer x = 32
integer y = 20
integer width = 2953
integer height = 1452
integer taborder = 10
string dataobject = "dw_ca_tz_salida"
borderstyle borderstyle = styleraised!
end type

event dw_1::ue_tab;Integer li_registros
datawindow ldw_1
ldw_1 = tab_1.tabpage_1.dw_1

if ldw_1.rowcount() < 1 Then Return

// Valida que el Detalle no Pueda ser Accesado si no hay un encabezado activo
is_pedido = ldw_1.getitemstring(ldw_1.getrow(),"ttra_pedido") 

If  integer(is_pedido) > 0 and  tab_1.tabpage_2.enabled = False then
		tab_1.tabpage_2.enabled = true
		if tab_1.tabpage_2.dw_2.rowcount() > 0 then tab_1.tabpage_3.enabled = true
			// SQL que me trae la cantidad de registros que hay en el detalle
			// para habilitar o deshabilitar el boton de DETALLE (tab)
	
			 SELECT count (*) 
		    INTO :li_registros
		    FROM tzdtraf1  
			 WHERE ( tzdtraf1.traf_g_financiero =: str.g_financiero ) AND  
		         ( tzdtraf1.traf_empresa   =: str.empresa) AND  
					( tzdtraf1.traf_ann		  =:w_fa_fondo.str_param.anio) AND
					( tzdtraf1.traf_ent_sal   ='SA') AND
		         ( tzdtraf1.traf_pedido    =: is_pedido) ;
	
			if li_registros = 0 then
				m_fa_principal.m_edicin.m_sortear.enabled=false
			else		
				if tab_1.tabpage_2.dw_2.rowcount() > 2 then	
				  // 	Habilita el boton de ordenar
		  		  m_fa_principal.m_edicin.m_sortear.enabled=true		 
			   end if	 
				dw.retrieve(str.g_financiero,str.empresa,'SA',w_fa_fondo.str_param.anio,is_pedido)
		end if			
Else
	 SELECT count (*) 
    INTO :li_registros
    FROM tzttraf0  
	 WHERE ( tzttraf0.ttra_g_financiero =: str.g_financiero ) AND  
          ( tzttraf0.ttra_empresa   =: str.empresa) AND  
			 ( tzttraf0.ttra_ann		  =:w_fa_fondo.str_param.anio) AND
			 ( tzttraf0.ttra_ent_sal   ='SA') AND
          ( tzttraf0.ttra_pedido =: is_pedido) ;

	If	li_registros = 0 Then
		tab_1.tabpage_2.enabled = false
		tab_1.tabpage_3.enabled = false	
	end if
End if	
end event

event dw_1::ue_valida_ped;// Valida la existencia del encabezado y del detalle
integer li_filas_det
If not IsValid(m_fa_principal) Then
	ChangeMenu(m_fa_principal)
End If

if is_valida_ped = 'S' then return  
is_valida_ped = 'S'

IF il_filas < 1 THEN //El documento no existe 			
	wf_parametros()	// Carga los parametros de la llave primaria
	ii_first_time = 2	// Indica que no debe buscar nueva secuencia si no tomar el editado
	tab_1.tabpage_2.dw_2.Reset()
else
	// Doc existe, verifico si hay detalle
	li_filas_det = tab_1.tabpage_2.dw_2.retrieve(str.g_financiero,str.empresa,'SA',w_fa_fondo.str_param.anio,is_pedido)
	if li_filas_det < 1 then
	else
		tab_1.tabpage_2.enabled = true
		tab_1.tabpage_3.enabled = true
		m_fa_principal.m_archivo.m_imprimir.enabled = true
		m_fa_principal.m_archivo.m_reimprimir.enabled = true
		m_fa_principal.m_archivo.m_guardar.enabled = false
	end if
end if

end event

event dw_1::ue_postitemchanged(string data, long row, string columna);Integer	li_pais_salida, li_pais, li_paistrb
If not IsValid(m_fa_principal) Then
	ChangeMenu(m_fa_principal)
End If
is_campo = columna
dw.acceptText()

CHOOSE CASE columna
	
	case "ttra_fecha_reg"
			if il_filas < 1 Then
			//	dw.setitem(row,"ttra_fecha_reg",gf_fecha_serv())
			End If
	case "ttra_tipo_fact_pedido"
		id_selec = long(data)
		if id_selec = 1 Then
			cb_1.text = 'Facturas'
			cb_procesar.text = 'Procesar'
		else
			cb_1.text = 'Pedidos'
			cb_procesar.text = 'Procesar'
		End if
	CASE "ttra_pais_destino"
		li_pais = dw.getitemnumber(row,"ttra_pais_destino")
	   dwc_puerto_d.settransobject(SQLCA) 
		if dwc_puerto_d.retrieve(li_pais)	<=0 then dwc_puerto_d.insertrow(0)

	case "ttra_pais_origen"
		li_paistrb = dw.getitemnumber(row,"ttra_pais_origen")
	   dwc_puerto_trasb.settransobject(SQLCA) 
		If dwc_puerto_trasb.retrieve(li_paistrb) <=0 then dwc_puerto_trasb.insertrow(0)
END CHOOSE
m_fa_principal.m_archivo.m_guardar.enabled = true


end event

event dw_1::ue_down;Integer li_column
Long 	ll_row
Datawindow ldw_1

ldw_1 =  tab_1.tabpage_1.dw_1
ll_row = ldw_1.GetRow()

If  key = Keyenter!  Then
			
	li_column = ldw_1.getcolumn()+1
	
	if ldw_1.GetColumnName() = "ttra_flete" Then	
		li_column = 1
	end if
	ldw_1.setcolumn(li_column)
	ldw_1.setfocus()	
	return 2
End if



end event

event dw_1::ue_helpcol();tab_1.tabpage_1.dw_4.settransobject(SQLCA)
tab_1.tabpage_1.dw_4.Reset()

str_tz_doctos.dw_object =tab_1.tabpage_1.dw_4
str_tz_doctos.viene_de_buscar = 0

OpenwithParm(w_tz_co_busca_factura_cliente,str_tz_doctos)

str_tz_doctos = message.PowerObjectParm

if isvalid(str_tz_doctos) and Not IsNull(str_tz_doctos) and str_tz_doctos.viene_de_buscar = 1 then 

	id_selec = tab_1.tabpage_1.dw_1.GetItemNumber(1,"ttra_tipo_fact_pedido")
	
	if id_selec = 1 Then
		cb_procesar.text = 'Procesar'
		cb_1.text = 'Facturas'
		tab_1.tabpage_1.dw_1.SetItem(dw_1.GetRow(),"ttra_pedidos_fac",str_tz_doctos.documento)
		tab_1.tabpage_1.dw_1.SetItem(dw_1.GetRow(),"ttra_facturas",str_tz_doctos.pedido)
	else
		cb_procesar.text = 'Procesar'
		cb_1.text = 'Pedidos'
		tab_1.tabpage_1.dw_1.SetItem(dw_1.GetRow(),"ttra_pedidos_fac",str_tz_doctos.pedido)
		tab_1.tabpage_1.dw_1.SetItem(dw_1.GetRow(),"ttra_facturas",str_tz_doctos.documento)
	End if
Else
	ii_anio_recupera = 0
	str_tz_doctos.viene_de_buscar = 0
	tab_1.tabpage_1.dw_4.Reset()
End If


////OpenwithParm(w_tz_co_busca_docum_salida,str_tz_doctos)
//OpenwithParm(w_tz_co_busca_factura_cliente,str_tz_doctos)
//
//str_tz_doctos = message.PowerObjectParm
//
//if isvalid(str_tz_doctos) and Not IsNull(str_tz_doctos) then 
//	id_selec = tab_1.tabpage_1.dw_1.GetItemNumber(1,"ttra_tipo_fact_pedido")
//
//	if id_selec = 1 Then
//		cb_1.text = 'Buscar Facturas'
//		cb_procesar.text = 'Procesar Facturas'
//		tab_1.tabpage_1.dw_1.SetItem(dw_1.GetRow(),"ttra_pedidos_fac",str_tz_doctos.documento)
//		tab_1.tabpage_1.dw_1.SetItem(dw_1.GetRow(),"ttra_facturas",str_tz_doctos.pedido)
//	else
//		cb_procesar.text = 'Procesar Pedidos'
//		cb_1.text = 'Buscar Pedidos'
//		tab_1.tabpage_1.dw_1.SetItem(dw_1.GetRow(),"ttra_pedidos_fac",str_tz_doctos.pedido)
//		tab_1.tabpage_1.dw_1.SetItem(dw_1.GetRow(),"ttra_facturas",str_tz_doctos.documento)
//	End if
//ELSE
//	ii_anio_recupera = 0
//	mensaje("Atención ","No devuelve nada","")
//End If
//
end event

event dw_1::itemchanged;//Funciona cuando existe y se escoge de la lista
THIS.ACCEPTTEXT()
CHOOSE CASE dw.getcolumnname()
	CASE "ttra_pedido"
		is_valida_ped =''		
		is_pedido = data	
/**/	w_ca_tz_salidas.setredraw(false)
		il_filas = dw.retrieve(str.g_financiero,str.empresa,"SA",w_fa_fondo.str_param.anio,is_pedido)
		this.triggerevent("ue_valida_ped")	// Vallida existencia del documento
/**/	w_ca_tz_salidas.setredraw(true)
END CHOOSE
This.Post Event ue_postitemchanged(data,row,dw.getcolumnname())

end event

event dw_1::getfocus;dw = tab_1.tabpage_1.dw_1
If not IsValid(m_fa_principal) Then
	ChangeMenu(m_fa_principal)
End If
m_fa_principal.m_edicin.m_insertar.toolbaritemvisible=false
m_fa_principal.m_edicin.m_filtrar.toolbaritemvisible=false
//m_fa_principal.m_edicin.m_adicionar.toolbaritemvisible=false
m_fa_principal.m_edicin.m_sortear.toolbaritemvisible=false

m_fa_principal.m_edicin.m_primerregistro.enabled=false
m_fa_principal.m_edicin.m_registroanterior.enabled=false
m_fa_principal.m_edicin.m_siguienteregistro.enabled=false
m_fa_principal.m_edicin.m_ultimoregistro.enabled=false
dw.setredraw(true)



end event

event dw_1::clicked;dw=this

end event

event dw_1::itemfocuschanged;is_campo = This.GetColumnName ()


end event

event dw_1::editchanged;If not IsValid(m_fa_principal) Then
	ChangeMenu(m_fa_principal)
End If
If dwo.name = 'ttra_pedidos_fac' then
	tab_1.tabpage_1.dw_4.reset()
	str_tz_doctos.viene_de_buscar = 0
end if
m_fa_principal.m_archivo.m_imprimir.enabled = false
m_fa_principal.m_archivo.m_reimprimir.enabled = false
m_fa_principal.m_archivo.m_guardar.enabled = True
tab_1.tabpage_3.enabled = false

end event

event dw_1::retrieveend;Integer li_pais 
datawindow ldw_1
ldw_1 = tab_1.tabpage_1.dw_1
If ldw_1.rowcount() = 0 then return

li_pais = ldw_1.getitemnumber(1,"ttra_pais_destino")
if dwc_puerto_d.retrieve(li_pais)	<=0 then dwc_puerto_d.insertrow(0)

li_pais = ldw_1.getitemnumber(1,"ttra_pais_origen")
If dwc_puerto_trasb.retrieve(li_pais) <=0 then dwc_puerto_trasb.insertrow(0)

end event

event dw_1::doubleclicked;Integer li_pais
datawindow ldw_1
ldw_1 = tab_1.tabpage_1.dw_1
If ldw_1.rowcount() = 0 then return

CHOOSE CASE dw.getcolumnname()
	CASE 'ttra_pais_origen'
		If dwc_pais_o.retrieve() <= 0 then dwc_pais_o.insertRow(0)
		
	CASE 'ttra_transportador'
		If dwc_trasporte.retrieve() <= 0 Then dwc_trasporte.InsertRow(0)
		
	CASE 'ttra_pais_destino'
		iF dwc_pais_d.retrieve()  <= 0 Then dwc_pais_d.InsertRow(0)
		
	CASE 'ttra_puerto_destino'
		li_pais = ldw_1.getitemnumber(1,"ttra_pais_destino")
		if dwc_puerto_d.retrieve(li_pais)	<=0 then dwc_puerto_d.insertrow(0)
		
	CASE 'ttra_puerto_trasbordo'
		li_pais = ldw_1.getitemnumber(1,"ttra_pais_origen")
		If dwc_puerto_trasb.retrieve(li_pais) <=0 then dwc_puerto_trasb.insertrow(0)
		
	CASE 'ttra_puerto_salida'
		If dwc_puerto_salida.retrieve(w_fa_fondo.str_param.num_pais) <=0 then dwc_puerto_salida.insertrow(0)
		
END CHOOSE 
If not IsValid(m_fa_principal) Then
	ChangeMenu(m_fa_principal)
End If


end event

type tabpage_2 from w_grampa_tab`tabpage_2 within tab_1
integer width = 3113
integer height = 1656
long backcolor = 12639424
string pointer = "HyperLink!"
string text = "Detalle"
long tabtextcolor = 8388608
long tabbackcolor = 12639424
string picturename = "Custom082!"
string powertiptext = "Detalle de la Salida"
end type

type dw_2 from w_grampa_tab`dw_2 within tabpage_2
event ue_post_clicked ( )
event ue_cantidad ( )
event ue_prowcam ( )
event ue_fraccion ( )
event ue_down pbm_dwnkey
event ue_tabfinal pbm_dwntabout
event ue_adicionar ( )
event type integer ue_fil_uni ( )
event ue_cant_bulto ( )
event ue_arancel ( )
event ue_set_column ( )
event ue_prim_key ( )
event ue_valida_arancel ( )
event ue_post_itemchange ( long row,  string data,  string columna )
event ue_esnuevo ( )
integer x = 0
integer y = 16
integer width = 3109
integer height = 1632
string dataobject = "dw_ca_tz_det_entradas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = styleraised!
end type

event dw_2::ue_post_clicked;String ls_aranc_descrip
dw = tab_1.tabpage_2.dw_2
this.accepttext()

//Desabilita la vista previa y la impresión hasta que Salves
m_fa_principal.m_archivo.m_imprimir.enabled = false
m_fa_principal.m_archivo.m_reimprimir.enabled = false
m_fa_principal.m_archivo.m_guardar.enabled = True
tab_1.tabpage_3.enabled = false

CHOOSE CASE This.GetColumnName()
	CASE "traf_arancel"
	  is_arancel 		 = dw.getitemstring(dw.getrow(),"traf_arancel")
	  ls_aranc_descrip = dwc_arancel.getitemstring(dwc_arancel.getrow(), "aran_descripcion")
	  dw.setitem (dw.getrow(),"traf_descripcion", ls_aranc_descrip)		

	CASE "traf_empaque_um"
		// La Unidad de empaque 
		is_unian =  This.GetItemString(This.getrow(),"traf_empaque_um")						

END CHOOSE

end event

event dw_2::ue_cantidad;Double ld_cant_x_linea,ld_cant_x_bul, ld_mconver, ld_fraccion
Double li_cantidad
dw = tab_1.tabpage_2.dw_2

 li_cantidad = dw.GetItemNumber(dw.getrow(),"traf_cantidad")
 ld_fraccion = dw.GetItemNumber(dw.getrow(),"traf_fraccion") 
 is_unian    = dw.GetItemString(dw.getrow(),"traf_empaque_um")
 
//* Convierte las cantidades en Unidades de Empaque y piezas

 SELECT inamedid.medi_cantidad
 INTO	:ld_mconver
 FROM inamedid  
 WHERE inamedid.medi_medida = :is_unian;

 if ld_mconver = 0 then
	 messagebox("Atención Sr. Usuario","Verifique las medidas del Producto",exclamation!)
 end if	
 
 if ld_mconver = 0 then
	 ld_mconver = 1
 end if

 ld_cant_x_linea = (ld_mconver * li_cantidad) + ld_fraccion   // Total de piezas
 li_cantidad	= int(ld_cant_x_linea/ld_mconver)
 ld_fraccion   = mod(ld_cant_x_linea,ld_mconver)

 If w_fa_fondo.str_param.decimales_sino = 1 then
// 	dw.SetItem(dw.getrow(), "traf_cantidad",li_cantidad )
 	dw.SetItem(dw.getrow(), "traf_fraccion",0 )
 else
 	dw.SetItem(dw.getrow(), "traf_cantidad",li_cantidad )
 	dw.SetItem(dw.getrow(), "traf_fraccion",ld_fraccion )
 end if
end event

event dw_2::ue_prowcam;String ls_medac,ls_fil
Integer li_hay


li_hay = this.getrow()

If  li_hay > 0 Then 

	//En caso de que el usuario seleccione una cantidad o fraccion y luego no haga TAB
	// Al momento que se posisione en la linea se recalculara el monto

	IF is_li_actu = "traf_cantidad" OR is_li_actu = "traf_fraccion"	THEN
		This.Postevent("ue_cantidad")
	END IF				
End If


end event

event dw_2::ue_fraccion;call super::ue_fraccion;Double ld_monto,ld_mconvera,ld_fraccion,ld_descuento,ld_ff,ld_final,ld_preciofr,ld_puni,&
		 ld_mconver, ld_cant_x_bul, ld_cant_x_linea
String ls_ua

// Carga de Datos Necesarios para Los Calculos
 ld_monto    = This.GetItemNumber(This.getrow(),"traf_valor")
 is_unian    = This.GetItemString(This.getrow(),"traf_empaque_um")
 ld_fraccion = This.GetItemNumber(This.getrow(),"traf_fraccion")
  
 //* Carga Los Datos de Converción de la Unidad Actual

 SELECT inamedid.medi_cantidad
 INTO	:ld_mconvera
 FROM    inamedid  
 WHERE inamedid.medi_tipo_medida = :il_ucom and
              inamedid.medi_medida = :is_unian;

	
If  Not isnull(ld_fraccion) Then
// Cuanto cuesta la Fraccion de Mercancia

 if ld_mconvera = 0 then
	
	 ld_mconvera = 1
	
 end if	

ld_preciofr = ld_puni/ld_mconvera

//ld_monto = ld_monto + (ld_preciofr * ld_fraccion)

This.SetItem(This.getrow(),"traf_valor",ld_monto)

// Calcula el Cubicaje

//wf_cubicaje()

This.SetItem(This.getrow(),"Traf_valor",ld_monto)

End if

end event

event dw_2::ue_down;Integer li_column,li_row
Long 	ll_row

Datawindow ldw_1

ldw_1 =  tab_1.tabpage_2.dw_2
ll_row = ldw_1.GetRow()

If  ll_row = ldw_1.rowcount() Then
	If key = Keyenter!  Then
		
		li_column = ldw_1.getcolumn() + 1
		
		if li_column > 9 then
			li_column = 1
			If ll_row = ldw_1.rowcount() Then
				This.triggerevent("ue_adicionar")
			Else
				ldw_1.ScrollToRow(ll_row+1)
			End If
		end if
		ldw_1.setcolumn(li_column)
		ldw_1.setfocus()	

	end if
Else	
	If key = Keyenter!   Then
		li_column = ldw_1.getcolumn() + 1
		if li_column > 9 then
			ll_row = ldw_1.getrow() + 1

			li_column = 1
			ldw_1.ScrollToRow(ll_row )
		End If
		ldw_1.setcolumn(li_column)
		ldw_1.setfocus()	
		return 2
	End If
end if


end event

event dw_2::ue_tabfinal;this.Triggerevent("ue_adicionar")	

end event

event dw_2::ue_adicionar;//Verifica si no existe renglon vacio para adicionar
integer recorrido,li_linea
string ls_linea_vacia
Long	ll_row
ls_linea_vacia=' '
li_linea = 0
dw = tab_1.tabpage_2.dw_2
FOR recorrido = 1 TO dw.rowcount()
 if len(trim(dw.getitemstring(recorrido,"traf_arancel"))) > 0 &
	 and dw.getitemNumber(recorrido,"traf_cantidad")+ & 
	     dw.getitemNumber(recorrido,"traf_fraccion") > 0 then 
	li_linea = li_linea +1
	dw.setitem(li_linea,"traf_linea",li_linea)
else
	dw.deleterow(recorrido)
 end if	
NEXT

ll_row = li_linea +1
dw.scrolltorow(dw.insertrow(0))

dw.setitem(ll_row,"traf_g_financiero",str.g_financiero)
dw.setitem(ll_row,"traf_empresa",str.empresa)
dw.setitem(ll_row,"traf_ent_sal",'SA')
dw.setitem(ll_row,"traf_ann",w_fa_fondo.str_param.anio)
dw.setitem(ll_row,"traf_pedido",is_pedido)
dw.setitem(ll_row,"traf_linea",ll_row)

dw.setcolumn("traf_arancel")


end event

event dw_2::ue_fil_uni;call super::ue_fil_uni;return 0
end event

event dw_2::ue_cant_bulto;call super::ue_cant_bulto;integer li_bultos
li_bultos=dw.getitemNumber(dw.getrow(),"traf_cant_bultos")
if li_bultos <= 0 then
	messagebox("Ue Cant Bulto / Cantidad NoVálida",string(li_bultos))
	dw.setcolumn("traf_cant_bultos")
end if

end event

event dw_2::ue_arancel;this.setcolumn(3)
end event

event dw_2::ue_set_column;Choose Case This.GetColumnName()
	Case "traf_cantidad", "traf_descripcion"
			dw.setcolumn("traf_arancel")
	CASE "traf_descrip_bulto"
			dw.setcolumn("traf_cant_bultos")
	CASE "traf_peso_bruto"
			dw.setcolumn("traf_cantidad")
	CASE "traf_valor"						
			dw.setcolumn("traf_peso_bruto")
		
End Choose

end event

event dw_2::ue_prim_key;call super::ue_prim_key;// Setea los campos de la llave primaria del detalle

dw.setitem(This.Getrow(),"traf_g_financiero",str.g_financiero)
dw.setitem(This.Getrow(),"traf_empresa",str.empresa)
dw.setitem(This.Getrow(),"traf_ent_sal",'SA')
dw.setitem(This.Getrow(),"traf_ann",w_fa_fondo.str_param.anio)
dw.setitem(This.Getrow(),"traf_pedido",is_pedido)
dw.setitem(This.Getrow(),"traf_arancel",is_arancel)
dw.setitem(This.Getrow(),"traf_linea",This.Getrow())

end event

event dw_2::ue_valida_arancel;String ls_col,arancel,ls_aranc_descrip

//Verifica si existe el arancel
  SELECT inaaranc.aran_arancel,   
	      inaaranc.aran_descripcion  
  INTO   :arancel,   
         :ls_aranc_descrip  
   FROM  inaaranc  
  WHERE  inaaranc.aran_arancel =:is_arancel   
ORDER BY inaaranc.aran_descripcion ASC  ;

	if SQLCA.sqlcode = 0 then
		is_valida='0'
		dw.SetItem(dw.getRow(),"traf_descripcion",ls_aranc_descrip)
		dw.SetItem(dw.getRow(),"traf_arancel",is_arancel)
	else
		is_valida='1'
		this.postevent("ue_arancel")
	end if

end event

event dw_2::ue_post_itemchange;Double	ld_peso,ll_cant,ll_frac
Long 		ll_bultos
boolean 	lb_arancel
String	ls_aranc_descrip
If not IsValid(m_fa_principal) Then
	ChangeMenu(m_fa_principal)
End If

Choose Case columna
	Case "traf_arancel"
	  is_arancel 		 = dw.getitemstring(row,"traf_arancel")
	  ls_aranc_descrip = dwc_arancel.getitemstring(dwc_arancel.getrow(), "aran_descripcion")
	  dw.setitem (row,"traf_descripcion", ls_aranc_descrip)		
			
	CASE "traf_descripcion"
		If len(trim(dw.GetItemString(row,"traf_descripcion")))= 0 or &
		IsNull(dw.GetItemString(row,"traf_descripcion")) Then
			this.triggerevent("ue_valida_arancel")
		End If
		
	CASE "traf_fraccion"
		ll_cant =dw.getitemNumber(row,"traf_cantidad")
		ll_frac =dw.getitemNumber(row,"traf_fraccion")
		If Isnull(ll_cant) then ll_cant = 0
		If Isnull(ll_frac) then ll_frac = 0
		
 		if  ll_cant + ll_frac <= 0 then
			 mensaje("Atención Sr. Usuario","La Cantidad y Fraccion no Pueden ser Ambas (Cero)","")
			this.postevent('ue_set_column')
		end if	

	CASE "traf_peso_bruto"
		// Valida que el peso de los bultos no sea <= 0
			is_arancel = dw.getitemstring(row,"traf_arancel")
			is_arancel = trim(is_arancel)
			ld_peso=dw.getitemNumber(row,"traf_peso_bruto")
			if ld_peso <= 0 and len(is_arancel) > 0 then
				mensaje("Atención","Peso Bruto Inválido",string(ld_peso))
				this.postevent('ue_set_column')
			end if

	CASE "traf_cant_bultos"
		// Valida que la cantidad de bultos no sea <= 0
		ll_bultos=dw.getitemNumber(row,"traf_cant_bultos")
		If Isnull(ll_bultos) then ll_bultos = 0
		if ll_bultos <= 0 then
			mensaje("Atención","Cantidad No Válida",string(ll_bultos))
		//	this.postevent('ue_set_column')
		end if
End Choose
m_fa_principal.m_archivo.m_guardar.enabled = true	

end event

event dw_2::ue_esnuevo;dwItemStatus l_status
l_status = dw.GetItemStatus(dw.GetRow(), 0, Primary!)

If l_status = New! or  l_status = NewModified! or dw.Rowcount() = dw.GetRow() Then
//	this.triggerevent("ue_prim_key")
end if

end event

event dw_2::itemchanged;string ls_arancel

if dw.rowcount()=0  or dw <> this OR is_guardando = 'S' then return

is_columna =This.GetColumnName()

m_fa_principal.m_archivo.m_imprimir.enabled = false
m_fa_principal.m_archivo.m_reimprimir.enabled = false
m_fa_principal.m_archivo.m_guardar.enabled = True
tab_1.tabpage_3.enabled = false

This.Post Event ue_post_itemchange(row, data, This.GetColumnName())

end event

event dw_2::retrieveend;// Si No Hay Valores en el Data Window
If dw = tab_1.tabpage_1.dw_1 then Return
If this.rowcount()< 1 Then 
	iw_this.Triggerevent("ue_adicionar")
End If

end event

event dw_2::itemfocuschanged;String	ls_aranc_descrip
Long		ll_bultos
Double	ld_peso,ll_frac,ll_cant
dw = tab_1.tabpage_2.dw_2

if dw.rowcount()=0  or dw <> this  OR is_guardando = 'S' then return

is_columna =This.GetColumnName()
is_arancel = dw.getitemstring(dw.getrow(),"traf_arancel")

if len(trim(is_arancel)) = 0 then return

row = dw.getrow()

Choose Case This.GetColumnName()
//	Case "traf_descripcion"
//	  is_arancel 		 = dw.getitemstring(row,"traf_arancel")
//	  ls_aranc_descrip = dwc_arancel.getitemstring(dwc_arancel.getrow(), "aran_descripcion")
//	  dw.setitem (row,"traf_descripcion", ls_aranc_descrip)		

	CASE "traf_descrip_bulto"
		ll_bultos=dw.getitemNumber(row,"traf_cant_bultos")
		If Isnull(ll_bultos) then ll_bultos = 0
		if ll_bultos <= 0 then
			mensaje("Atención","Cantidad No Válida",string(ll_bultos))
		//	this.postevent('ue_set_column')
		end if
		
	CASE "traf_peso_bruto" //valida fraccion

		ll_cant =dw.getitemNumber(row,"traf_cantidad")
		ll_frac =dw.getitemNumber(row,"traf_fraccion")
		If Isnull(ll_cant) then ll_cant = 0
		If Isnull(ll_frac) then ll_frac = 0
		
 		if  ll_cant + ll_frac <= 0 then
			 mensaje("Atención Sr. Usuario","La Cantidad y Fraccion no Pueden ser Ambas (Cero)","")
			this.postevent('ue_set_column')
		end if	

	CASE "traf_valor"
		// Valida que el peso de los bultos no sea <= 0
			ld_peso=dw.getitemNumber(row,"traf_peso_bruto")
			If Isnull(ld_peso) then ld_peso = 0
			if ld_peso <= 0 and len(is_arancel) > 0 then
				mensaje("Atención","Peso Bruto Inválido",string(ld_peso))
				this.postevent('ue_set_column')
			end if
End Choose

end event

event dw_2::rowfocuschanged;//// Si Existen Datos en el Data Window Valida
double  ld_linea, ld_ultima

if dw <> this OR is_guardando = 'S' or This.Rowcount()  = 0 then return

tab_1.tabpage_2.dw_2.ScrollToRow(This.Getrow())

If This.Rowcount()  > 0 and this.getrow() > 0 Then
	is_arancel = This.getitemstring(This.getrow(),"traf_arancel")
End If
end event

event dw_2::getfocus;dw = tab_1.tabpage_2.dw_2
If not IsValid(m_fa_principal) Then
	ChangeMenu(m_fa_principal)
End If

m_fa_principal.m_edicin.m_sortear.toolbaritemvisible=false
//m_fa_principal.m_edicin.m_adicionar.toolbaritemvisible=false

m_fa_principal.m_edicin.m_primerregistro.enabled=true
m_fa_principal.m_edicin.m_registroanterior.enabled=true
m_fa_principal.m_edicin.m_siguienteregistro.enabled=true
m_fa_principal.m_edicin.m_ultimoregistro.enabled=true


end event

event dw_2::clicked;dw=this

end event

event dw_2::editchanged;String ls_aranc_descrip
If not IsValid(m_fa_principal) Then
	ChangeMenu(m_fa_principal)
End If
m_fa_principal.m_archivo.m_guardar.enabled = true	
m_fa_principal.m_archivo.m_imprimir.enabled = false
m_fa_principal.m_archivo.m_reimprimir.enabled = false
tab_1.tabpage_3.enabled = false

CHOOSE CASE This.GetColumnName()
	CASE "traf_arancel"
	  is_arancel 		 = dw.getitemstring(dw.getrow(),"traf_arancel")
	  ls_aranc_descrip = dwc_arancel.getitemstring(dwc_arancel.getrow(), "aran_descripcion")
	  dw.setitem (dw.getrow(),"traf_descripcion", ls_aranc_descrip)		
End Choose

end event

type tabpage_3 from w_grampa_tab`tabpage_3 within tab_1
integer width = 3113
integer height = 1656
long backcolor = 12639424
string pointer = "HyperLink!"
string text = "Vista Previa"
long tabtextcolor = 8388608
long tabbackcolor = 12639424
string picturename = "Preview!"
string powertiptext = "Vista Preliminar de la Impresion de la Salida"
cbx_1 cbx_1
cbx_2 cbx_2
end type

on tabpage_3.create
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.cbx_2
end on

on tabpage_3.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.cbx_2)
end on

type dw_3 from w_grampa_tab`dw_3 within tabpage_3
integer x = 23
integer y = 24
integer width = 3081
integer height = 1620
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event dw_3::getfocus;call super::getfocus;If not IsValid(m_fa_principal) Then
	ChangeMenu(m_fa_principal)
End If
end event

event dw_3::retrieveend;Datawindow ldw_3
Long	ll_rowcount, ll_row_orig, ll_row, li_nw_rowcount
Decimal	ld_total_valor,ld_flete,ld_seguro,ld_otros,ld_tot_final, ld_sum_valor,ld_descuento
String	ls_sello,ls_contenedor,ls_marca,ls_boking, ls_costo,ls_observacion, ls_lin10, ls_expression
String	ls_inserto_totales = ' ',ls_visible, ls_facturas, ls_pedido_fac
Integer	li_expandir_campo, li_limite, li_max, li_ipo_fact_ped

ldw_3 = tab_1.tabpage_3.dw_3
ll_rowcount = ldw_3.Rowcount()
ll_row_orig = ll_rowcount
il_rowcount = ll_rowcount

If ll_rowcount <= 0 then return

If is_dw ='10'  or is_dw ='11' then
	/* Guarda los valores de las campos del ultimo registro por si se
	 inserta algún reglón poderlos setear*/
	ls_sello 	= ldw_3.GetItemString(ll_rowcount,'ttra_sello')
	ls_contenedor = ldw_3.GetItemString(ll_rowcount,'ttra_contenedor')
	ls_marca 	= ldw_3.GetItemString(ll_rowcount,'ttra_marca')
	ls_boking 	= ldw_3.GetItemString(ll_rowcount,'ttra_boking')
	ls_observacion = ldw_3.GetItemString(ll_rowcount,'ttra_observacion')
	
	// Validar si estos campos expression contienen ' o " (sello,contenedor y observacion)
	ls_sello 	= gf_elimina_comillas(ls_sello,"'",'´')
	ls_contenedor = gf_elimina_comillas(ls_contenedor,"'","´")
	ls_observacion = gf_elimina_comillas(ls_observacion,"'","´")
	ls_marca 	= gf_elimina_comillas(ls_marca,"'","´")
	ls_boking 	= gf_elimina_comillas(ls_boking,"'","´")
	
	ls_costo = ldw_3.GetItemString(ll_rowcount,'tzttraf0_ttra_tipo_fob_cif')
	ld_total_valor = ldw_3.GetItemNumber(ll_rowcount,'valor')
	ld_sum_valor = ldw_3.GetItemNumber(ll_rowcount,'valor_total')
	
	ld_flete      = ldw_3.GetItemNumber(ll_rowcount,"tzttraf0_ttra_flete")
	ld_seguro     = ldw_3.GetItemNumber(ll_rowcount,"tzttraf0_ttra_seguro")
	ld_otros      = ldw_3.GetItemNumber(ll_rowcount,"tzttraf0_ttra_otros")

	/*Para determinar qué campo tiene los números de factura*/
	li_ipo_fact_ped = ldw_3.GetItemNumber(il_rowcount,'ttra_tipo_fact_pedido')
	ls_facturas 	= ldw_3.GetItemString(il_rowcount,'ttra_facturas')
	ls_pedido_fac  = ldw_3.GetItemString(il_rowcount,'ttra_pedidos_fac')

	If li_ipo_fact_ped = 1 then 
		ls_facturas ='Facturas :'+ls_pedido_fac
	else
		ls_facturas ='Facturas :'+ls_facturas
	end if
	/**/
		
	If IsNull( ld_total_valor ) then  ld_total_valor = 0
	If IsNull( ld_flete ) then  ld_flete = 0
	If IsNull( ld_seguro ) then  ld_seguro = 0
	If IsNull( ld_otros ) then  ld_otros = 0
		
	ld_tot_final  = ld_total_valor + ld_flete + ld_seguro + ld_otros
		
	If IsNull( ld_tot_final ) then  ld_tot_final = 0

	If IsNull(w_fa_fondo.str_param.imp_totales_desp_lin10) then w_fa_fondo.str_param.imp_totales_desp_lin10 = 0
	If IsNull(w_fa_fondo.str_param.inserta_lin_totales) then w_fa_fondo.str_param.inserta_lin_totales = 0
	If IsNull(w_fa_fondo.str_param.totales_en_linea_10) then w_fa_fondo.str_param.totales_en_linea_10 = 0

	li_nw_rowcount = Int(ll_rowcount/10)*10+10 

	// Inserta, pero no es necesario setear encabezado
	If mod(ll_rowcount,10) > 0 then
		//Inserta registros en blanco hasta el próximo múltiplo de 10 si el cliente así
		//lo configuró
		If w_fa_fondo.str_param.totales_en_linea_10 = 1 then

			for ll_row = ll_rowcount + 1 to li_nw_rowcount
				wf_setea_encabezado()
				if ldw_3.rowcount() < li_nw_rowcount then ldw_3.SetItem(ldw_3.rowcount(),'traf_pedido','.')
			Next
		else
			wf_setea_encabezado()
		end if
		ldw_3.SetItem(ldw_3.Rowcount(),'traf_descrip_bulto','xx')
	end if
	
	/*	Si el mod(ll_rowcount,10) =0 y el cliente quiere que se inserte línea 
		para totales o que se muestra en la última línea del doc.*/
	
	If mod(ll_rowcount,10) = 0 and ( w_fa_fondo.str_param.inserta_lin_totales= 1 &
		or w_fa_fondo.str_param.totales_en_linea_10 = 1 ) then

		If w_fa_fondo.str_param.totales_en_linea_10 = 1 then
			
			for ll_row = ll_rowcount + 1 to li_nw_rowcount
				wf_setea_encabezado()
				if ldw_3.rowcount() < li_nw_rowcount then ldw_3.SetItem(ldw_3.rowcount(),'traf_pedido','.')
			Next
		else
			wf_setea_encabezado()
		end if

		ldw_3.SetItem(ldw_3.rowcount(),'traf_pedido','')
		ldw_3.SetItem(ldw_3.Rowcount(),'traf_descrip_bulto','xx')
	end if

	/* Si no se configuró dónde y cómo imprimir totales, no se imprimen los
	 	mismos cuando mod(ll_rowcount,10) = 0*/
	If mod(ll_rowcount,10) = 0 and  w_fa_fondo.str_param.inserta_lin_totales= 0 &
		and w_fa_fondo.str_param.totales_en_linea_10 = 0 then
	
		ldw_3.SetItem(ldw_3.Rowcount(),'traf_descrip_bulto','')
	end if

	/*Insert para totales*/
	If	ldw_3.GetItemString(ldw_3.Rowcount(),'traf_descrip_bulto')= 'xx' then
		ls_inserto_totales = '1'
//		ldw_3.object.inserto_totales.expression = "'"+ls_inserto_totales+"'"
	end if

	ldw_3.SetItem(ldw_3.Rowcount(),'ttra_sello',ls_sello)
	ldw_3.SetItem(ldw_3.Rowcount(),'ttra_contenedor',ls_contenedor)
	ldw_3.SetItem(ldw_3.Rowcount(),'ttra_marca',ls_marca)
	ldw_3.SetItem(ldw_3.Rowcount(),'ttra_boking',ls_boking)
	
	ldw_3.SetItem(ldw_3.Rowcount(),'ttra_observacion',ls_observacion)
	
	// Setea los valores del último registro antes del Insert al
	// registro agregado para los totales del documento
	ldw_3.setItem(ldw_3.Rowcount(),'tzttraf0_ttra_tipo_fob_cif',ls_costo)
	ldw_3.object.valor.expression = "'"+string(round(ld_total_valor,2))+"'"
	ldw_3.setitem(ldw_3.Rowcount(),"tzttraf0_ttra_flete",ld_flete)
	ldw_3.setitem(ldw_3.Rowcount(),"tzttraf0_ttra_seguro",ld_seguro)
	ldw_3.setitem(ldw_3.Rowcount(),"tzttraf0_ttra_otros",ld_otros)
	ldw_3.object.final.expression = "'"+string(round(ld_tot_final,2))+"'"
	
	/*Validaciones para determinar dónde imprimir los No. de doc. según
	  como lo haya configurado el cliente*/
	  
	if len(trim(ls_contenedor))= 0 or isnull(ls_contenedor) then ls_contenedor =' ' else ls_contenedor = 'CONT.: '+ls_contenedor  
	if len(trim(ls_sello))		= 0 or isnull(ls_sello) then ls_sello 		=' ' else ls_sello = 'SELLO: '+ls_sello
	if len(trim(ls_observacion))= 0 or isnull(ls_observacion) then ls_observacion =' ' else ls_observacion = 'OBSERV.:'+ls_observacion
	if len(trim(ls_boking))		= 0 or isnull(ls_boking) then ls_boking 		=' ' else ls_boking = 'BOKING:'+ls_boking
	if len(trim(ls_marca))		= 0 or isnull(ls_marca) then ls_marca ='' else ls_marca = 'MARCA: '+ls_marca

	ls_expression = ls_marca+'    '+ls_contenedor+'     '+ls_sello+'     '+ls_observacion +'     '+ls_boking

	li_expandir_campo = 0

	If mod(ldw_3.Rowcount(),10) = 0 then
		li_limite = 0
	else
		li_limite = Int(ldw_3.Rowcount()/10)*10+10
	end if
	
	/* Totales después del ultimo reg de detalle */
	If w_fa_fondo.str_param.inserta_lin_totales= 1  then

		if ldw_3.rowcount() < li_limite then
			ldw_3.InsertRow(0)		
/**/		ldw_3.SetItem(ldw_3.Rowcount(),'traf_descrip_bulto','xx') /*no se muestran totales*/
			ldw_3.Modify("ccontenedor.width=3899")  //Lin blanco
			ldw_3.SetItem(ldw_3.Rowcount(),'ccontenedor',ls_expression)
			ldw_3.SetItem(ldw_3.Rowcount(),'doc_visible','1')
			ldw_3.SetItem(ldw_3.rowcount(),'traf_pedido','.')
			If len(trim(ls_expression)) >= 96 then li_expandir_campo = 1

			// Setea los valores del último registro antes del Insert al
			// registro agregado para los totales del documento
			ldw_3.setItem(ldw_3.Rowcount(),'tzttraf0_ttra_tipo_fob_cif',ls_costo)
			ldw_3.object.valor.expression = "'"+string(round(ld_total_valor,2))+"'"
			ldw_3.setitem(ldw_3.Rowcount(),"tzttraf0_ttra_flete",ld_flete)
			ldw_3.setitem(ldw_3.Rowcount(),"tzttraf0_ttra_seguro",ld_seguro)
			ldw_3.setitem(ldw_3.Rowcount(),"tzttraf0_ttra_otros",ld_otros)
			ldw_3.object.final.expression = "'"+string(round(ld_tot_final,2))+"'"

			if len(trim(ls_facturas))>24 then
				if ldw_3.rowcount() < li_limite then
					/* Inserta línea para # de facturas después de los # de documentos*/
					/* Added 27/08/2001 hace visible campo con N.de facturas cuando la 
					cantidad de caracteres es > 14 y lo muestra después del #documentos*/
					gf_tz_factura_visible(li_limite,ld_total_valor,ls_costo,ld_flete,ld_seguro,ld_otros,ld_tot_final,ls_facturas,ldw_3,il_rowcount)

				else	/*Se muestran en la línea de totales*/
					/* Added 27/08/2001 hace visible campo con N.de facturas cuando la 
					cantidad de caracteres es > 16 y lo muestra en la línea de totales*/
					ls_visible = 'S'		
					ldw_3.object.visible_fact.expression = "'"+ls_visible+"'"
					ldw_3.SetItem(ldw_3.Rowcount() -1,'factura_visible','S')
					ldw_3.SetItem(ldw_3.Rowcount() -1,'no_facturas',ls_facturas)
				end if
			end if
/**/

		else //El compute de # de documentos va en la línea de totales
			ldw_3.Modify("ccontenedor.width=2789")	//Lin totales
			ldw_3.SetItem(ldw_3.Rowcount(),'ccontenedor',ls_expression)
			ldw_3.SetItem(ldw_3.Rowcount(),'doc_visible','1')
			If len(trim(ls_expression)) >= 71 then li_expandir_campo = 1
		end if
	end if

	/* Totales en la linea 10 */
	If w_fa_fondo.str_param.totales_en_linea_10 = 1 then
		/*Suma 1 al rowcount() original por los totales y uno para los documentos*/
		ll_rowcount = ll_rowcount +2
		If ldw_3.Rowcount() > ll_rowcount then
			/* Hace visible los documentos en la línea anterior a la
				línea de totales expandido */
			ldw_3.Modify("ccontenedor.width=3899")
			ldw_3.SetItem(ldw_3.Rowcount() -1,'ccontenedor',ls_expression)
			ldw_3.SetItem(ldw_3.Rowcount() -1,'doc_visible','1')
			If len(trim(ls_expression)) >= 96 then li_expandir_campo = 1

/**/
				if len(trim(ls_facturas))>24 then
				/* Added 27/08/2001 hace visible campo con N.de facturas cuando la 
					cantidad de caracteres es > 14 y lo muestra después de los totales*/
					ls_visible = 'S'		
					ldw_3.object.visible_fact.expression = "'"+ls_visible+"'"
					ldw_3.SetItem(ldw_3.Rowcount() -2,'factura_visible','S')
					ldw_3.SetItem(ldw_3.Rowcount() -2,'no_facturas',ls_facturas)
				end if
/**/
		else

			ll_rowcount = ll_rowcount - 1
			If ldw_3.Rowcount() > ll_rowcount then
				/*Queda una línea disponible entre la linea 10 y la última 
				  del detalle por lo que se puede imprimir los # documentos 
				  en la línea anterior y los # de factura en la de totales*/
				ldw_3.Modify("ccontenedor.width=3899")
				ldw_3.SetItem(ldw_3.Rowcount() - 1,'ccontenedor',ls_expression)
				ldw_3.SetItem(ldw_3.Rowcount() - 1,'doc_visible','1')
				If len(trim(ls_expression)) >= 96 then li_expandir_campo = 1

				/*Facturas en la línea de totales*/
//				ls_visible = 'S'		
//				ldw_3.object.visible_fact.expression = "'"+ls_visible+"'"
//				ldw_3.SetItem(ldw_3.Rowcount() ,'factura_visible','S')
//				ldw_3.SetItem(ldw_3.Rowcount() ,'no_facturas',ls_facturas)
				
			else
				/* hace visible los documentos en la línea de totales,
					no se puede imprimir # de facturas abajo */
				ldw_3.Modify("ccontenedor.width=2789")
				ldw_3.SetItem(ldw_3.Rowcount(),'ccontenedor',ls_expression)
				ldw_3.SetItem(ldw_3.Rowcount(),'doc_visible','1')
				If len(trim(ls_expression)) >= 71 then li_expandir_campo = 1
			end if
		end if
	end if

	/* El cliente no desea que inserte cuando el rowcount es multiplo de 10 exacto */
	If w_fa_fondo.str_param.inserta_lin_totales= 0 	and w_fa_fondo.str_param.totales_en_linea_10 = 0 then

		if ldw_3.Rowcount() < li_limite then
			ldw_3.InsertRow(0)		
			ldw_3.Modify("ccontenedor.width=3899") //Lin blanco
			ldw_3.SetItem(ldw_3.Rowcount(),'ccontenedor',ls_expression)
			ldw_3.SetItem(ldw_3.Rowcount(),'doc_visible','1')
			ldw_3.SetItem(ldw_3.rowcount(),'traf_pedido','.')
			If len(trim(ls_expression)) >= 96 then li_expandir_campo = 1
			// Setea los valores del último registro antes del Insert al
			// registro agregado para los totales del documento
			ldw_3.setItem(ldw_3.Rowcount(),'tzttraf0_ttra_tipo_fob_cif',ls_costo)
			ldw_3.object.valor.expression = "'"+string(round(ld_total_valor,2))+"'"
			ldw_3.setitem(ldw_3.Rowcount(),"tzttraf0_ttra_flete",ld_flete)
			ldw_3.setitem(ldw_3.Rowcount(),"tzttraf0_ttra_seguro",ld_seguro)
			ldw_3.setitem(ldw_3.Rowcount(),"tzttraf0_ttra_otros",ld_otros)
			ldw_3.object.final.expression = "'"+string(round(ld_tot_final,2))+"'"

/**/
			if len(trim(ls_facturas))>24 then
				if ldw_3.rowcount() < li_limite then
					/* Inserta línea para # de facturas después de los # de documentos*/
					/* Added 27/08/2001 hace visible campo con N.de facturas cuando la 
					cantidad de caracteres es > 14 y lo muestra después del #documentos*/
					gf_tz_factura_visible(li_limite,ld_total_valor,ls_costo,ld_flete,ld_seguro,ld_otros,ld_tot_final,ls_facturas,ldw_3,il_rowcount)

				else	/*Se muestran en la línea de totales*/
					/* Added 27/08/2001 hace visible campo con N.de facturas cuando la 
					cantidad de caracteres es > 14 y lo muestra en la línea de totales*/
					ls_visible = 'S'		
					ldw_3.object.visible_fact.expression = "'"+ls_visible+"'"
					ldw_3.SetItem(ldw_3.Rowcount() -1,'factura_visible','S')
					ldw_3.SetItem(ldw_3.Rowcount() -1,'no_facturas',ls_facturas)
				end if
			end if
/**/
		else
//			if ls_inserto_totales = '0' and w_fa_fondo.str_param.imp_totales_desp_lin10 = 1 then
			If ls_inserto_totales = '0' and w_fa_fondo.str_param.inserta_lin_totales= 0 	and w_fa_fondo.str_param.totales_en_linea_10 = 0 then
				/* Son 10 aranceles y no se ha insertado registro para totales,
					los mismos al igual que los no doc se mostrarán abajo de 
				 	la línea 10 si así fue configurado Los Angeles */
				ldw_3.Modify("ccontenedor_1.width=2825") //Lin blanco debajo de línea 10
				ldw_3.object.ccontenedor_1.expression = "'"+ls_expression+"'"
				ldw_3.object.inserto_totales.expression = "'"+ls_inserto_totales+"'"
					 
			elseif ls_inserto_totales = '1' then /*Insertó totales*/
				ldw_3.Modify("ccontenedor.width=2825") //Lin totales
				ldw_3.SetItem(ldw_3.Rowcount(),'ccontenedor',ls_expression)
				ldw_3.SetItem(ldw_3.Rowcount(),'doc_visible','1')
			end if
			If len(trim(ls_expression)) >= 71  then li_expandir_campo = 1 
		end if
		
	end if

	If is_dw ='11' then /*Formato de Textiles */
		
		li_max = (Int(ldw_3.rowcount()/8)+1)*8
		
		li_limite = li_max - ldw_3.rowcount()
		if mod(ldw_3.rowcount(),8) = 0 then  li_limite = 1

//		ldw_3.Modify("ccontenedor.visible=No")
		
		for ll_row = 1 to li_limite
			wf_setea_encabezado()
			ldw_3.SetItem(ldw_3.rowcount(),'traf_pedido','text')
			ldw_3.SetItem(ldw_3.Rowcount(),'traf_descrip_bulto','text')
			ldw_3.SetItem(ldw_3.Rowcount(),'visible_true','yes')
		Next
		
		/* Setea los valores del primer registro para los totales del documento 
			si se insertó alguno*/
		If li_limite > 0 then
			
			/*No de línea donde se iniciarán adesplegar los No. de documentos */
			If ld_descuento > 0 then 
				ll_row = ldw_3.rowcount() - li_limite 
				li_limite ++	//Hace visible el contenedor en el mismo reg del descuento
				ldw_3.SetItem(ll_row,'visible_true','yes')
			end if
			ll_row = ldw_3.rowcount() - li_limite +1


			If li_limite >= 3 then
				ldw_3.setItem(ll_row,'ccontenedor',ls_contenedor)
				ldw_3.setItem(ll_row+1,'ccontenedor',ls_sello)
				ldw_3.setItem(ll_row+2,'ccontenedor',ls_observacion)
				ldw_3.SetItem(ll_row,'visible_true','yes')
				ldw_3.SetItem(ll_row+1,'visible_true','yes')
				ldw_3.SetItem(ll_row+2,'visible_true','yes')
			end if
			
			If li_limite = 2 then
				ldw_3.setItem(ll_row,'ccontenedor',ls_contenedor)
				ldw_3.setItem(ll_row+1,'ccontenedor',ls_sello)
				ldw_3.SetItem(ll_row,'visible_true','yes')
				ldw_3.SetItem(ll_row+1,'visible_true','yes')
			end if

			If li_limite = 1 then
				ldw_3.setItem(ll_row,'ccontenedor',ls_contenedor+' '+ls_sello)
				ldw_3.SetItem(ll_row,'visible_true','yes')
			end if
			
			ldw_3.setItem(ldw_3.rowcount(),'tzttraf0_ttra_tipo_fob_cif',ls_costo)
			ldw_3.object.valor.expression = "'"+string(round(ld_total_valor,2))+"'"
			ldw_3.setitem(ldw_3.rowcount(),"tzttraf0_ttra_flete",ld_flete)
			ldw_3.setitem(ldw_3.rowcount(),"tzttraf0_ttra_seguro",ld_seguro)
			ldw_3.setitem(ldw_3.rowcount(),"tzttraf0_ttra_otros",ld_otros)
			ldw_3.setitem(ldw_3.rowcount(),"ttra_descuento",ld_descuento)
			ldw_3.object.final.expression = "'"+string(round(ld_tot_final,2))+"'"
		end if
	end if
	

	If li_expandir_campo = 1 then
		ldw_3.Modify("ccontenedor.Height.AutoSize=Yes")
		ldw_3.Modify("ccontenedor.Y=4")
		ldw_3.Modify("ccontenedor.Height=124")
	end if
/**/
end If


// Especifica si se muestra el detalle de bultos x renglón o sólo el total
if IsNull(w_fa_fondo.str_param.detalle_bultos) then w_fa_fondo.str_param.detalle_bultos =0

ldw_3.object.muestra_det_bulto.expression = string(w_fa_fondo.str_param.detalle_bultos)
end event

type dw_4 from datawindow within tabpage_1
boolean visible = false
integer x = 9
integer y = 1180
integer width = 192
integer height = 60
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_tz_co_pedidos_seleccionados"
boolean livescroll = true
end type

type cb_procesar from commandbutton within tabpage_1
integer x = 1531
integer y = 952
integer width = 453
integer height = 116
integer taborder = 14
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked;wf_resumir_facturas()
end event

type cb_1 from commandbutton within tabpage_1
integer x = 1531
integer y = 828
integer width = 448
integer height = 108
integer taborder = 24
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Facturas"
end type

event clicked;ii_boton = 1
tab_1.tabpage_1.dw_1.TriggerEvent('ue_helpcol')
end event

type cbx_varianza from checkbox within tabpage_1
boolean visible = false
integer x = 1545
integer y = 716
integer width = 517
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Varianza"
borderstyle borderstyle = stylelowered!
end type

event constructor;
//***
integer li1
SELECT tzaparam.param_subfacturacion
	INTO :li1 FROM tzaparam  
	WHERE ( tzaparam.para_g_financiero = :str.g_financiero )
	AND ( tzaparam.para_empresa = :str.empresa )   ;
if isnull(li1) then li1=0
visible = (li1=1)
//***
end event

type cbx_1 from checkbox within tabpage_3
boolean visible = false
integer x = 151
integer width = 777
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Ocultar líneas de totales"
borderstyle borderstyle = stylelowered!
end type

event clicked;tab_1.tabpage_3.cbx_2.checked = false
wf_oculta_lineas()

end event

type cbx_2 from checkbox within tabpage_3
boolean visible = false
integer x = 1088
integer width = 923
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Ocultar totales y líneas de totales"
borderstyle borderstyle = stylelowered!
end type

event clicked;tab_1.tabpage_3.cbx_1.checked = false
wf_oculta_totales()

end event

type st_1 from statictext within w_ca_tz_salidas
boolean visible = false
integer x = 1477
integer y = 40
integer width = 1285
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 8421376
boolean enabled = false
string text = "Gardar encabezado para pasar al Detalle"
boolean focusrectangle = false
end type

type sle_nom_ventana from singlelineedit within w_ca_tz_salidas
boolean visible = false
integer x = 32
integer y = 1688
integer width = 777
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
boolean autohscroll = false
end type

type gb_nom_ventana from groupbox within w_ca_tz_salidas
integer x = 5
integer y = 1356
integer width = 1051
integer height = 132
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type st_nom_ventana from statictext within w_ca_tz_salidas
boolean visible = false
integer y = 1700
integer width = 1015
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type dw_5 from datawindow within w_ca_tz_salidas
boolean visible = false
integer x = 1481
integer y = 1668
integer width = 571
integer height = 112
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_tz_sel_cargos"
boolean livescroll = true
end type

