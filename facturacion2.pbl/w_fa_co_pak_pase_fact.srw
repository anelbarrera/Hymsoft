//objectcomments Pase de lista de empaque a factura
forward
global type w_fa_co_pak_pase_fact from w_fa_padre_reportes
end type
type gb_6 from groupbox within w_fa_co_pak_pase_fact
end type
type gb_nose from groupbox within w_fa_co_pak_pase_fact
end type
type dw_2 from datawindow within w_fa_co_pak_pase_fact
end type
type rb_4 from radiobutton within w_fa_co_pak_pase_fact
end type
type dw_3 from datawindow within w_fa_co_pak_pase_fact
end type
type pb_3 from picturebutton within w_fa_co_pak_pase_fact
end type
type dw_5 from datawindow within w_fa_co_pak_pase_fact
end type
type pb_4 from picturebutton within w_fa_co_pak_pase_fact
end type
type dw_6 from datawindow within w_fa_co_pak_pase_fact
end type
type dw_4 from datawindow within w_fa_co_pak_pase_fact
end type
type gb_4 from groupbox within w_fa_co_pak_pase_fact
end type
type gb_2 from groupbox within w_fa_co_pak_pase_fact
end type
type rb_3 from radiobutton within w_fa_co_pak_pase_fact
end type
type pb_2 from picturebutton within w_fa_co_pak_pase_fact
end type
type rb_1 from radiobutton within w_fa_co_pak_pase_fact
end type
type dw_7 from datawindow within w_fa_co_pak_pase_fact
end type
type st_1 from statictext within w_fa_co_pak_pase_fact
end type
type sle_ann from editmask within w_fa_co_pak_pase_fact
end type
type gb_5 from groupbox within w_fa_co_pak_pase_fact
end type
end forward

global type w_fa_co_pak_pase_fact from w_fa_padre_reportes
integer x = 503
integer y = 400
integer width = 2798
integer height = 1788
string title = " Pase de Lista de Empaques a Facturas"
string menuname = ""
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event ue_pasarow ( )
event ue_pase ( )
gb_6 gb_6
gb_nose gb_nose
dw_2 dw_2
rb_4 rb_4
dw_3 dw_3
pb_3 pb_3
dw_5 dw_5
pb_4 pb_4
dw_6 dw_6
dw_4 dw_4
gb_4 gb_4
gb_2 gb_2
rb_3 rb_3
pb_2 pb_2
rb_1 rb_1
dw_7 dw_7
st_1 st_1
sle_ann sle_ann
gb_5 gb_5
end type
global w_fa_co_pak_pase_fact w_fa_co_pak_pase_fact

type variables
Datawindow idw_cual
Datawindowchild idw_child_uni , idch_cliente
integer ii_clicked, ii_cont = 0, ii_cualevent = 1, ii_ultgetrow, &
            ii_escpri = 1, ii_ann
long il_LastClickedRow, il_arrayrows[], il_cantidad, il_fraccion
boolean ib_action_on_buttonup, ib_tipoclicked = false, ib_flag = false
string is_user
end variables

forward prototypes
public subroutine wf_cambuni ()
public subroutine wf_caldisp (readonly string as_coditem, readonly string as_bodega, readonly string as_ubicacion)
public subroutine wf_cant_apasar ()
public subroutine wf_setear_user (string as_user)
public subroutine wf_buscar_registro (string data)
public subroutine wf_botones ()
public subroutine wf_actualizar_reservado (string as_producto)
public subroutine wf_efectuar_pase ()
end prototypes

event ue_pasarow;integer li_i, li_rows
long ll_c, ll_anno, ll_linea, ll_i,ll_cant
string ls_lista,ls_cod_item


CHOOSE CASE idw_cual
	CASE dw_1, dw_3
		
//		For ll_cant = 1 to dw_3.RowCount()
//			
//			If dw_3.getItemNumber(ll_cant,"fadpedid_dped_pasada") <> 0 then
//				Mensaje("AVISO","Este pedido no se puede actualizar porque ya fue pasado","")
//				return
//			End If
//		Next

		dw_3.RowsMove(1,dw_3.RowCount(),Primary!,dw_4,1,Primary!)

		If dw_4.rowcount() > 0 then pb_2.enabled = true
		If dw_4.rowcount() > 0 then pb_2.enabled = true
	CASE ELSE 
		
		If dw_4.RowCount() < 1 then return
		
		li_rows = dw_1.RowCount()
		For ll_c = 1 to dw_4.RowCount()
			
			ls_lista = dw_4.getItemString(ll_c,"empa_lista_empaque")
			ll_anno = dw_4.getItemNumber(ll_c,"empa_ann")
				
			For li_i = 1 to li_rows
				
				If dw_1.Getitemstring(li_i,"fatempaq_enca_lista_empaque") = ls_lista AND &
					dw_1.Getitemnumber(li_i,"fatempaq_enca_ann") = ll_anno Then
					
					dw_4.RowsDiscard(1,dw_4.RowCount(),Primary!)
					dw_3.Setredraw(false)
					dw_3.Retrieve(str.g_financiero,str.empresa,ls_lista,ll_anno)
					dw_3.Setredraw(true)
					
				Else
					dw_4.RowsDiscard(1,dw_4.RowCount(),Primary!)		
				End IF
				
			Next
			
		Next		
END CHOOSE


	
end event

event ue_pase;wf_efectuar_pase()
end event

public subroutine wf_cambuni ();//	 /*Función que hace el cambio de unidad para la banda de disponibles*/
 //Llamada desde wf_calcdisp()
 
	String ls_unidad, ls_output
	Long ll_varcan = 0, ll_cantidad = 0, ll_varfrac = 0

	Datawindow ldw_banda
	
 	//ldw_2 = tab_1.tabpage_2.dw_2
	ldw_banda = dw_6
	
	ls_unidad = dw_4.GetItemString(dw_4.getrow(),"fadpedid_dped_unidad_venta")
	
	/*Existencia*/	
	ll_cantidad = ldw_banda.GetItemnumber(1,"mbod_cantidad")
	if isnull(ll_cantidad) then ll_cantidad = 0
	gf_fa_convertuni_new(ls_unidad,ll_cantidad,ll_varcan,ll_varfrac)
	ls_output = String(ll_varcan +ll_varfrac) 
	ldw_banda.SetItem(1,"cexistencia",ll_varcan)
	ldw_banda.SetItem(1,"fexistencia",ll_varfrac)

	/*ResErvado*/
	ll_cantidad = ldw_banda.GetItemnumber(1,"mbod_reserva")
	if isnull(ll_cantidad) then ll_cantidad = 0	
	gf_fa_convertuni_new(ls_unidad,ll_cantidad,ll_varcan,ll_varfrac)
	ls_output = String(ll_varcan)+'/'+string(ll_varfrac)
	ldw_banda.SetItem(1,"creserva",ll_varcan)
	ldw_banda.SetItem(1,"freserva",ll_varfrac)

	/*Disponible*/
	ll_cantidad = ldw_banda.GetItemnumber(1,"disponible")
	if isnull(ll_cantidad) then ll_cantidad = 0	
	gf_fa_convertuni_new(ls_unidad,ll_cantidad,ll_varcan,ll_varfrac)
	ls_output = String(ll_varcan)+'/'+string(ll_varfrac)
	ldw_banda.SetItem(1,"cdisponible",ll_varcan)
	ldw_banda.SetItem(1,"fdisponible",ll_varfrac)

	ldw_banda.Object.co_unidad[1] = ls_unidad
end subroutine

public subroutine wf_caldisp (readonly string as_coditem, readonly string as_bodega, readonly string as_ubicacion);// Función que prueba cuanto puede ser reservado

long  	ll_cantidad , &
			ll_fraccion , &
			ll_mconvera ,&
			ll_coverb ,&
			ll_acumulado ,&
			ll_cantor ,&
			ll_cantac ,&
        	ll_fracor ,&
			ll_fracac ,&
			ll_existencia ,&
			ll_reservado ,&
			ll_disponible ,&
			ll_diferencia ,&
		  	ll_cantne ,&
			ll_fracne

Integer li_row,li_fin,li_findel,li_resp
String  ls_gitem,ls_uniac ,ls_gbodega,ls_gubicacion


dwItemStatus l_stapcan,l_stapfr,l_rowstatus


li_fin = dw_4.rowcount()


ll_existencia = dw_6.GetItemnumber(1,"mbod_cantidad")
ll_reservado  = dw_6.GetItemnumber(1,"mbod_reserva")


FOR li_row = 1 TO li_fin
	
	ls_gitem   = dw_4.getitemstring(li_row,"fadpedid_dped_codigo_item")
   ls_gbodega = dw_4.getitemString(li_row,"fadpedid_dped_bodega")
   ls_gubicacion = dw_4.getitemString(li_row,"fadpedid_dped_ubicacion")
	
			
	IF as_coditem = ls_gitem  and as_bodega = ls_gbodega and as_ubicacion = ls_gubicacion THEN
	
	    ls_uniac  = dw_4.GetItemString(li_row,"fadpedid_dped_unidad_venta")
		
       SELECT inamedid.medi_cantidad
       INTO	 :ll_mconvera
       FROM  inamedid  
       WHERE /*inamedid.medi_tipo_medida = :il_ucon and*/
             inamedid.medi_medida = :ls_uniac;
				 
		
/******************************************************************************/		
		                 // Para las Cantidades
/******************************************************************************/				
		l_stapcan = dw_4.GetItemStatus(li_row,"c_cant_pas", Primary!)
		ll_cantor = dw_4.GetItemNumber(li_row,"c_cant_pas",Primary!,true)
		ll_cantac = dw_4.GetItemNumber(li_row,"c_cant_pas",Primary!,false) 
		
		
	   
					
      If l_stapcan = DataModified! Then
		// Hay que tomar del buffer anterior
			
			
		   If ll_cantor < ll_cantac Then
				
			   ll_acumulado = ll_acumulado + ((ll_cantac - ll_cantor)* ll_mconvera)
				
			ElseIf ll_cantor = ll_cantac Then
			
	      ll_cantidad  = dw_4.GetItemNumber(li_row,"c_cant_pas")
			
			ll_acumulado = ll_acumulado + (ll_cantidad * ll_mconvera)
			
		   Else

				
				ll_acumulado = ll_acumulado - ((ll_cantor - ll_cantac)* ll_mconvera)

			End If	
			
						
      END IF 
		
	
/******************************************************************************/		
		                 // Para las Fracciones
/******************************************************************************/				

		l_stapfr = dw_4.GetItemStatus(li_row,"c_cant_frac", Primary!)
		ll_fracor = dw_4.GetItemNumber(li_row,"c_cant_frac",Primary!,true)
		ll_fracac = dw_4.GetItemNumber(li_row,"c_cant_frac",Primary!,false) 
		
		
	   If l_stapfr = DataModified! Then
		// Hay que tomar del buffer anterior
			
			ll_fracor = dw_4.GetItemNumber(li_row,"c_cant_frac",Primary!,true)
			ll_fracac = dw_4.GetItemNumber(li_row,"c_cant_frac",Primary!,false) 
			
		   If ll_fracor < ll_fracac Then
				
			   ll_acumulado = ll_acumulado + (ll_fracac - ll_fracor)
			
		   ElseIf ll_fracor = ll_fracac Then
			
         l_stapcan = dw_4.GetItemStatus(li_row,"c_cant_pas", Primary!)
	      ll_fraccion = dw_4.GetItemNumber(li_row,"c_cant_frac")
			
			ll_acumulado = ll_acumulado + ll_fraccion
			
			Else
				
				ll_acumulado = ll_acumulado - ((ll_fracor - ll_fracac))

			End If	
			
			
      END IF

/******************************************************************************/		
		                 // Para la Unidad de Venta
/******************************************************************************/		
	
	
	End If	/*Es el que pregunta si la linea es la deseada*/


Next	

//*******************************************************************************

//                 **** Rutina para los Registros Eliminados  ****

//*******************************************************************************


// Verifica los registros eliminados

li_findel = dw_4.DeletedCount()
FOR li_row = 1 TO li_findel
	
   
   
	ls_gitem   = dw_4.getitemstring(li_row,"fadpedid_dped_codigo_item", Delete!,False)
   ls_gbodega = dw_4.getitemString(li_row,"fadpedid_dped_bodega", Delete!,False)
   ls_gubicacion = dw_4.getitemString(li_row,"fadpedid_dped_ubicacion", Delete!,False)

	
	IF as_coditem = ls_gitem  and as_bodega = ls_gbodega and as_ubicacion = ls_gubicacion THEN
	
	    ls_uniac  = dw_4.GetItemString(li_row,"fadpedid_dped_unidad_venta",Delete!,False)
		
       SELECT inamedid.medi_cantidad
       INTO	 :ll_mconvera
       FROM  inamedid  
       WHERE /*inamedid.medi_tipo_medida = :il_ucon and*/
             inamedid.medi_medida = :ls_uniac;
				 

/*OJO*/	
/******************************************************************************/		
                 // Para las Cantidades del Deleted
/******************************************************************************/				
		
		
		ll_cantor = dw_4.GetItemNumber(li_row,"c_cant_pas",Delete!,true)
		ll_cantac = dw_4.GetItemNumber(li_row,"c_cant_pas",Delete!,false) 
					
		
		 
		 
		   If ll_cantor < ll_cantac Then /*Aumente y luego elimine*/
				
			   ll_acumulado = ll_acumulado - (ll_cantac * ll_mconvera)
				
			ElseIf ll_cantor = ll_cantac Then /*Solo elimine*/
			
	      	ll_acumulado = ll_acumulado -  (ll_cantac * ll_mconvera)
			
		   Else /*Disminui y luego elimine*/
				
				ll_acumulado = ll_acumulado - (ll_cantor * ll_mconvera)

			End If	
			
					
      
	
		
	
/******************************************************************************/		
		                 // Para las Fracciones
/******************************************************************************/				

		
		
		ll_fracor = dw_4.GetItemNumber(li_row,"c_cant_frac", Delete!,true)
		ll_fracac = dw_4.GetItemNumber(li_row,"c_cant_frac", Delete!,false) 
		
		
	   
			
		   If ll_fracor < ll_fracac Then /*Aumente y luego elimine*/
				
			   ll_acumulado = ll_acumulado - ll_fracac 
			
		   ElseIf ll_fracor = ll_fracac Then
			            
			
			ll_acumulado = ll_acumulado - ll_fracac
			
			Else /*Disminui y luego elimine*/
				
				ll_acumulado = ll_acumulado - ll_fracor

			End If	

	
End If
	
NEXT	/*Fin del Recorrido del delete*/



// Ya en esta sección se maneja el calculo de Totales
	
ll_disponible = ll_existencia - (ll_reservado + ll_acumulado)
l_rowstatus = dw_4.GetItemStatus(dw_4.Getrow(), 0, Primary!)
dw_6.SetItem (1,"mbod_reserva", (ll_reservado + ll_acumulado ))
wf_cambuni()

If ll_disponible < 0 Then
		
	
	 ll_diferencia = ll_acumulado - (ll_disponible *-1) 

	 If  l_rowstatus <> NotModified! Then 
		
     li_resp =	Messagebox("Advertencia",&
	  "Para el Item " + as_coditem + " Bodega " + string(as_bodega)+ " Ubicación " + string(as_ubicacion)&
	  +"~n ~n" + "Unted ha Intentado Reservar " + String(ll_acumulado) &
	  +"~n " +"Solo se Dispone de " +  string(ll_diferencia)&
	  +"~n "+"¿Esta Seguro que Quiere Exceder lo Disponible?",Question!,YesNo! ) 
    End If
	
   If li_resp = 2 Then
	  /*Verifica si la linea es nueva o modificada para retornar el valor anterior*/ 
     If  l_rowstatus = NewModified! Then 
		

		 dw_4.SetItem(dw_4.Getrow(),"c_cant_frac",0) 
	    dw_4.SetItem(dw_4.Getrow(),"c_cant_frac",0) 
			 
	  Else	
		 
	    dw_4.ReselectRow (dw_4.GetRow()) 
	 
     End If
    
	    dw_4.AcceptText()
	 
    End If
	 
//End If	 

End If	
end subroutine

public subroutine wf_cant_apasar ();long 	ll_pasado, ll_unimin, ll_vendido, &
		ll_totvenpas, ll_linea, ll_row, ll_cont, ll_i,ll_cantidad,ll_fraccion
string 	ls_coditem, ls_bodega, ls_ubicacion, ls_uni, &
			ls_coditem2, ls_bodega2, ls_ubicacion2, ls_nomcolumna

ll_row = dw_3.Rowcount()
ls_nomcolumna = dw_3.GetColumnName()
If ll_row  < 0  then return

For ll_i = 1 to ll_row


ls_coditem = dw_3.Getitemstring(ll_i,"fadpedid_dped_codigo_item")
ls_bodega = dw_3.Getitemstring(ll_i,"fadpedid_dped_bodega")
ls_ubicacion = dw_3.Getitemstring(ll_i,"fadpedid_dped_ubicacion")
ls_uni = dw_3.GetitemString(ll_i,"fadpedid_dped_unidad_venta")
ll_pasado = dw_3.GetitemNumber(ll_i,"fadpedid_dped_pasada")
//ll_vendido = dw_3.GetitemNumber(ll_i,"c_por_pasar")
ll_cantidad = dw_3.GetitemNumber(ll_i,"c_cant_pas")
ll_fraccion = dw_3.GetitemNumber(ll_i,"c_cant_frac")

ll_unimin = 0
gf_fa_convertmin_new(ll_unimin, ls_uni , ll_cantidad , ll_fraccion)

//If ll_unimin > ll_pasado then

	dw_3.SetItem(ll_i,"c_a_pasar",ll_unimin)
//ElseIf ll_pasado > ll_unimin then

//	dw_3.SetItem(ll_i,"c_a_pasar",ll_unimin)
//End If
	
	
Next
end subroutine

public subroutine wf_setear_user (string as_user);is_user = as_user
end subroutine

public subroutine wf_buscar_registro (string data);//Función que busca el numero de pedido o lista de empaque
long   ll_encontro, ll_tercero
Integer li_encontro
string ls_expresion

If rb_4.Checked = True Then /*A PEDIDO*/
  SELECT count(*)  
    INTO :ll_encontro  
    FROM fatempaq          
   WHERE ( ( fatempaq.enca_g_financiero = :str.g_financiero ) AND  
         ( fatempaq.enca_empresa = :str.empresa ) AND  
         ( fatempaq.enca_ann = :ii_ann ) AND // w_fa_fondo.str_para.ano ) AND  
         ( fatempaq.enca_fuente = 'PE' ) AND  
         ( fatempaq.enca_no_pedido = :data ) AND  
         ( fatempaq.enca_despachado = 'S' ) AND  
         ( fatempaq.enca_pasado <> 'S' ) )   ;
			
		if sqlca.sqlcode = -1 then
			mensaje('Aviso','Error al Verificar existencia del Pedido',sqlca.sqlerrtext)
			return
		end if
	
		if ll_encontro = 1 then
			  SELECT fatpedid.pedi_cliente  
				 INTO :ll_tercero  
				 FROM fatpedid  
				WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
						( fatpedid.pedi_empresa = :str.empresa ) AND  
						( fatpedid.pedi_no_pedido = :data ) AND  
						( fatpedid.pedi_ann = :ii_ann ) ; //w_fa_fondo.str_para.ano ) ;
				if sqlca.sqlcode = -1 then
					mensaje('Aviso','Error al seleccionar el tercero del Pedido',sqlca.sqlerrtext)
					return
				end if				 
				
			ll_encontro = idch_cliente.find('terc_tercero = '+string(ll_tercero),1,idch_cliente.rowcount())
			if ll_encontro > 0 then
				dw_5.setitem(1,1,ll_tercero)
				dw_5.trigger event itemchanged(1,dw_5.object.notercero,string(ll_tercero))
				
				li_encontro = dw_1.find('fatpedid_pedi_no_pedido = "'+data+'"',1,dw_1.rowcount())
				if li_encontro > 0 then
					dw_1.scrolltorow(li_encontro)
				end if
				
			end if	
		end if //Primer ll_encontro
ElseIf rb_3.Checked = True Then /*EMPAQUE*/
	
END IF
end subroutine

public subroutine wf_botones ();// Deshabilita algunas Opciones del Menú 

   /*Insertar*/
	m_fa_principal.m_edicin.m_insertar.toolbaritemvisible=false
	m_fa_principal.m_edicin.m_insertar.visible=false
	
	/*Adicionar*/
	m_fa_principal.m_edicin.m_adicionar.toolbaritemvisible=false
	m_fa_principal.m_edicin.m_adicionar.visible=false
	
	/*Filtrar*/
	m_fa_principal.m_edicin.m_filtrar.toolbaritemvisible=false
	m_fa_principal.m_edicin.m_filtrar.visible=false
	
	/*Sortear*/
	m_fa_principal.m_edicin.m_sortear.toolbaritemvisible=false
	m_fa_principal.m_edicin.m_sortear.visible=false
	
	/*Primer Reg*/
	m_fa_principal.m_edicin.m_primerregistro.toolbaritemvisible=false
	m_fa_principal.m_edicin.m_primerregistro.visible=false
	
	/*Ultimo Reg*/
	m_fa_principal.m_edicin.m_ultimoregistro.toolbaritemvisible=false
	m_fa_principal.m_edicin.m_ultimoregistro.visible=false
	
	/*Sig Reg*/
	m_fa_principal.m_edicin.m_siguienteregistro.toolbaritemvisible=false
	m_fa_principal.m_edicin.m_siguienteregistro.visible=false
	

  /*Reg Ant*/
	m_fa_principal.m_edicin.m_registroanterior.toolbaritemvisible=false
	m_fa_principal.m_edicin.m_registroanterior.visible=false

  /*Imprimir*/
   m_fa_principal.m_archivo.m_imprimir.toolbaritemvisible=false
	m_fa_principal.m_archivo.m_imprimir.visible=false
	
	/*Eliminar*/
	m_fa_principal.m_edicin.m_eliminar.toolbaritemvisible=false
	m_fa_principal.m_edicin.m_eliminar.visible=false

end subroutine

public subroutine wf_actualizar_reservado (string as_producto);string ls_error

//mensaje("Atención","Sr. Usuario, procure que al Ejecutar este Proceso, ningún usuario esté utilizando los Archivos de Facturación o Inventario, ya que se puede Bloquear la Base de datos e Incurrir en la Perdida de Datos.","")

//if gf_mensaje("","¿ Está seguro de Actualizar los Productos Reservados ? ",2,1,"E") = 1 then

// str.frame.setmicrohelp("Inicializando los Productos Reservados.............por favor Espere")

  sqlca.autocommit = false
  
//str.frame.setmicrohelp("Actualizando los Productos Reservados.............por favor Espere")

/*Actualiza los reservados del producto, procedentes de pedidos*/
  UPDATE inmprodu  
     SET prod_reserva_total = vi_reserva.reservado  
    FROM inmprodu,   
         vi_reserva  
   WHERE ( inmprodu.prod_g_financiero = vi_reserva.dped_g_financiero ) AND  
         ( inmprodu.prod_empresa = vi_reserva.dped_empresa ) AND  
         ( inmprodu.prod_producto = vi_reserva.dped_codigo_item )  and
			( inmprodu.prod_producto = :as_producto );
	  if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje("Aviso","Error al Actualizar las Reservas de los Productos ",ls_error)
		sqlca.autocommit = true
		return
	  end if

/*Actualiza los reservados del producto, procedentes de factura*/
  UPDATE inmprodu  
     SET prod_reserva_total = prod_reserva_total + vi_reserva_fac.reservado
    FROM inmprodu,   
         vi_reserva_fac  
   WHERE ( inmprodu.prod_g_financiero = vi_reserva_fac.facd_g_financiero ) AND  
         ( inmprodu.prod_empresa = vi_reserva_fac.facd_empresa ) AND  
         ( inmprodu.prod_producto = vi_reserva_fac.facd_codigo_item ) AND
			( inmprodu.prod_producto = :as_producto);
			
	  if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje("Aviso","Error al Actualizar las Reservas de Productos ",ls_error)
		sqlca.autocommit = true
		return
	  end if

/*Para actualizar las cantidades pasadas con la cantidad total del Registro, si la cantidad
 pasada es mayor a la total*/
  UPDATE fadpedid  
     SET dped_pasada = fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion  
    FROM fadpedid,   
         inamedid  
   WHERE ( fadpedid.dped_pasada > fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion ) AND  
         ( fadpedid.dped_unidad_venta = inamedid.medi_medida ) and
			( fadpedid.dped_g_financiero = :str.g_financiero ) and
			( fadpedid.dped_empresa	=	:str.empresa ) and			
			( fadpedid.dped_codigo_item = :as_producto);
			
	  if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje("Aviso","Error al Actualizar las Cantidades Pasadas",ls_error)
		sqlca.autocommit = true
		return
	  end if

/*Actualiza los reservados por bodega, procedentes de factura*/
// str.frame.setmicrohelp("Actualizando los Productos Reservados por Bodega.............por favor Espere")

  UPDATE inmbodeg  
     SET mbod_reserva = vi_reserva_fac_bodega.reservado
    FROM inmbodeg,   
         vi_reserva_fac_bodega  
   WHERE ( inmbodeg.mbod_g_financiero = vi_reserva_fac_bodega.facd_g_financiero ) AND  
         ( inmbodeg.mbod_empresa = vi_reserva_fac_bodega.facd_empresa ) AND  
         ( inmbodeg.mbod_bodega = vi_reserva_fac_bodega.facd_bodega ) AND  
         ( inmbodeg.mbod_ubicacion = vi_reserva_fac_bodega.facd_ubicacion ) AND  
         ( inmbodeg.mbod_producto = vi_reserva_fac_bodega.facd_codigo_item ) AND
			( inmbodeg.mbod_producto = :as_producto);
			
	  if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje("Aviso","Error al Actualizar las Reservas de productos por bodega ",ls_error)
		sqlca.autocommit = true
		return
	  end if
			

/*Actualiza los reservados por bodega, procedentes de pedidos*/
  UPDATE inmbodeg  
     SET mbod_reserva = mbod_reserva  +  vi_reserva_ped_bodega.reservado
    FROM inmbodeg,   
         vi_reserva_ped_bodega  
   WHERE ( inmbodeg.mbod_g_financiero = vi_reserva_ped_bodega.dped_g_financiero ) AND  
         ( inmbodeg.mbod_empresa = vi_reserva_ped_bodega.dped_empresa ) AND  
         ( inmbodeg.mbod_bodega = vi_reserva_ped_bodega.dped_bodega ) AND  
         ( inmbodeg.mbod_ubicacion = vi_reserva_ped_bodega.dped_ubicacion ) AND  
         ( inmbodeg.mbod_producto = vi_reserva_ped_bodega.dped_codigo_item ) AND
			( inmbodeg.mbod_producto = :as_producto );
			
	  if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje("Aviso","Error al Actualizar las Reservas de productos por bodega ",ls_error)
		sqlca.autocommit = true
		return
	  end if
	
	
	//Si no manda error , guarda en la base de datos
	
	commit;

	sqlca.autocommit = true	
	
//	gf_mensaje("","Actualización Exitosa de los Reservados",1,1,"E")
	
//end if //Del messagebox Aceptar o Cancelar
end subroutine

public subroutine wf_efectuar_pase ();
long 		ll_fraccion, ll_pasado, ll_cant_frac, ll_convert, ll_cantidad, ll_cantpas_tot, &
			ll_unimin, ll_vendido, ll_totvenpas, ll_cont, ll_no_prof, ll_cliente, &
			ll_cargo,ll_pormay,ll_vendedor, ll_ann_emp, &
			ll_bultostotal, ll_bultos,ll_row, ll_found,ll_i,ll_cant_ent, ll_pendiente_resumido, &
			ll_bultos_tot,ll_pasada, ll_tot_bultos, ll_existe, ll_linea_faddiari = 0,ll_bulto_inicio, ll_bulto_fin, &
			ll_cantidad_pedida, ll_cantidad_pedido, ll_fraccion_pedido, ll_cant_pending, ll_frac_pending, ll_cantidad_pending_total, ll_linea_pedido = 0
			
string 	ls_item,ls_uni, ls_num_sec, ls_ruc_cli, ls_condi_pag, ls_tipomov, ls_consigna, &
			ls_anombre, ls_direccion, ls_despachado, ls_via, ls_no_emb, ls_marca, ls_unidpeso, & 
			ls_decu_subt_det, ls_supervi, ls_comentario, ls_estado, ls_prod_serv, ls_cod_item, &  
         ls_desc_alter, ls_uni_peso, ls_uni_prod, ls_bodega, ls_uni_venta, ls_usuario, ls_supervisor, &
			ls_ubicacion, ls_pedido, ls_no_pedido, ls_lista_emp,ls_tipo_fac, ls_tipo_fac1, ls_filtro, &
			ls_error, ls_user, ls_reser_origen, ls_orden_compra, ls_transito, ls_find, ls_origen, ls_ruc, ls_dv
			
decimal	ld_montototal, ld_monto_final, ld_precio_my, ld_precio_mn, ld_costo_fob, ld_costo_cif, &  
         ld_precio_uni, ld_monto_tot, ld_monto_fin, ld_monto, ld_tot_montotot, ld_tot_montofin, &
			ld_tot_gastostot, ld_final, ld_monto_tot_pas, ld_total_pas, ld_precio,  &
			ld_peso_tot, ld_peso, ld_cubicaje_tot, ld_cubicaje,&
			ld_tot_peso, ld_tot_cubicaje, ld_precio_original, ld_costo_total,ld_fact_costo_total, ld_precio2, &
			ld_costo_uni, ld_monto_tot_pas_p, ld_monto_tot_p, ld_monto_fin_p, ld_costo_uni_p, ld_costo_total_p, ld_pasada
			
integer 	li_tipovent, li_numtraspa, li_dias_pago, li_gastostot, li_por_descuento, li_procesado, li_ann_pedido, &
			li_linea, li_fraccion, li_por_desc, li_c, li_error, li_linea_orig, li_precio_a_utilizar, li_varias_listas, &
			li_cuatro_decimales, li_ann_compra, li_ann_transito, li_lin_transito, li_lin_orden, li_existe, li_encontro, li_vendedor, &
			li_provincia, li_distrito, li_corregimiento
						
dateTime ldt_fecha_pedido, ldt_fecha_crea, ldt_fecha_mod, ldt_fecha_reg, ldt_fecha_serv, &
			ldt_fecha_fin_plazo

boolean lb_crear_encabezado = false, lb_genero_pedido = false, lb_entro = false

str_pasefact lstr_pasef
			  			  
ldt_fecha_serv	= gf_fecha_serv()  

ls_filtro = "empa_cantidad > 0"

dw_4.SetFilter(ls_filtro)
dw_4.filter()

If dw_4.Rowcount() < 1  then
	Mensaje("AVISO","No hay detalle para efectuar el pase a factura","")
	return
End IF

dw_4.AcceptText()

ii_ultgetrow = dw_1.GetRow()
	
li_ann_pedido 		 = dw_1.getitemnumber(ii_ultgetrow,"fatpedid_pedi_ann")
ls_no_pedido = dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_no_pedido")
ls_tipo_fac  = dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_tipo")

  SELECT count(*)  
    INTO :li_existe  
    FROM fatdiari  
   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
         ( fatdiari.fact_empresa = :str.empresa ) AND  
         ( fatdiari.fact_no_pedido = :ls_no_pedido ) AND  
         ( fatdiari.fact_ann = :li_ann_pedido )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al validar '+sqlca.sqlerrtext,1,1,'E')
		end if

if li_existe > 0 then
	gf_mensaje('','Pedido ya existe, Verifique !!!',1,1,'E')
end if

OpenWithParm(w_fa_man_secemp,ls_no_pedido +"/"+ls_tipo_fac+"")
	
lstr_pasef.numped = message.stringParm
	
	
	If lstr_pasef.numped <> "0" then
		
	    ls_lista_emp =  dw_1.GetItemString(ii_ultgetrow,"fatempaq_enca_lista_empaque")
		 ll_ann_emp   =  dw_1.GetItemNumber(ii_ultgetrow,"fatempaq_enca_ann") 
		
		 //Recupera los pendientes por pedido, resumidos
		 dw_7.retrieve(str.g_financiero, str.empresa, ls_lista_emp, ll_ann_emp)
       
		 //Verifica si el pedido esta en mas de una lista de empaque pendiente de pasar, si esta en varias, 
		 //que no valide lo pendiente y no cree el pedido con P, si es la ultima que si lo valide
		 
		   SELECT isnull(count(*),0)  
			 INTO :li_varias_listas  
			 FROM fatempaq  
			WHERE ( fatempaq.enca_g_financiero = :str.g_financiero ) AND  
					( fatempaq.enca_empresa = :str.empresa ) AND  
					( fatempaq.enca_no_pedido = :ls_no_pedido ) AND  
					( fatempaq.enca_ann_pedido = :li_ann_pedido ) AND  
					( fatempaq.enca_pasado = 'N' )  ;
					if sqlca.sqlcode = -1 then
						ls_error =sqlca.sqlerrtext
						rollback using sqlca;
						sqlca.autocommit = true
						gf_mensaje("","Error al verificar listas " + ls_error,1,1,'E')				
					   return						
					end if
		 
		 if li_varias_listas > 1 then
			dw_7.reset()
			ll_pendiente_resumido = 0
		 end if
				
		 sqlca.autocommit = false
		
		 ls_num_sec = lstr_pasef.numped
	
		  ll_cliente = dw_1.GetItemNumber(ii_ultgetrow,"fatpedid_pedi_cliente")  
		  ls_ruc_cli = dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_ruc_cliente")
		  ls_condi_pag = dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_condicion_pago")   
		  li_tipovent= dw_1.GetItemNumber(ii_ultgetrow,"fatpedid_pedi_tipo_venta")   
		  ls_tipomov = dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_tipo_movimiento")   
		  li_numtraspa = dw_1.GetItemNumber(ii_ultgetrow,"fatpedid_pedi_no_traspaso")  
		  ldt_fecha_pedido = dw_1.GetItemDateTime(ii_ultgetrow,"fatpedid_pedi_fecha")
		  ldt_fecha_crea = dw_1.GetItemDateTime(ii_ultgetrow,"fatpedid_pedi_fecha_creacion")
		  ldt_fecha_mod = dw_1.GetItemDateTime(ii_ultgetrow,"fatpedid_pedi_fecha_modificacion")  
		  li_dias_pago = dw_1.GetItemNumber(ii_ultgetrow,"fatpedid_pedi_dias_pago")  

		  ls_anombre  = dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_a_nombre") 
		  ls_direccion  = dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_a_nombre_direccion") 
		  ls_despachado  = dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_despachado")  
		  ls_via = dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_via")      
		  ll_bultostotal = dw_1.GetItemNumber(ii_ultgetrow,"enca_bultos_total")  
		  	
		  ls_ruc  = dw_1.GetItemString(ii_ultgetrow,"terc_ruc")  		  
  		  ls_dv  = dw_1.GetItemString(ii_ultgetrow,"terc_digito_verificador")  		  
		  li_provincia = dw_1.GetItemNumber(ii_ultgetrow,"terc_provincia")
		  li_distrito = dw_1.GetItemNumber(ii_ultgetrow,"terc_distrito")
		  li_corregimiento = dw_1.GetItemNumber(ii_ultgetrow,"terc_corregimiento")	
		  
		  ld_cubicaje   = 0
		  ld_peso_tot = 0
		  li_gastostot  = 0
		  ld_montototal = 0
		  ls_decu_subt_det  = dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_descu_subt_deta")   
		  li_por_descuento  = dw_1.GetItemNumber(ii_ultgetrow,"fatpedid_pedi_por_descuento")
		  ls_estado = "A"
		  
		  ls_origen  = dw_1.GetItemString(ii_ultgetrow,"pedi_origen_venta") 
		  
		  ldt_fecha_fin_plazo = gf_recupera_dias(li_dias_pago, date(ldt_fecha_pedido))
		
		  li_cuatro_decimales  = dw_1.GetItemNumber(ii_ultgetrow,"pedi_cuatro_decimales") 
		  li_precio_a_utilizar = dw_1.GetItemNumber(ii_ultgetrow,"pedi_precio_a_utilizar") 
		  ls_user				  = str.usuario //Para que guarde el usuario que paso la lista de empaque
		
		  ldt_fecha_pedido = datetime(date(ldt_fecha_serv))
		
		    INSERT INTO fatdiari  
         ( fact_g_financiero,  			fact_empresa,   
           fact_tipo,   				   fact_no_pedido,   
           fact_ann,   						fact_no_factura,   
           fact_cliente,   				fact_ruc_cliente,   
           fact_condicion_pago,   		fact_tipo_venta,   
           fact_tipo_movimiento,   		fact_no_traspaso,   
           fact_fecha,   					fact_fecha_creacion,   
           fact_fecha_modificacion,   	fact_dias_pago,   
           fact_fecha_fin_plazo,   		fact_fecha_cancelado,   
           fact_consignado,   			fact_a_nombre,   
           fact_a_nombre_direccion,   	fact_despachado,   
           fact_via,   						fact_con_emb_no,   
           fact_marca,   					fact_bultos_total,   
           fact_cubicaje_total,   		fact_peso_total,   
           fact_unidad_peso,   			fact_gastos_total,   
           fact_monto_fact_total,   	fact_descuento_subt_deta,   
           fact_por_descuento,   		fact_supervisor,   
           fact_monto_final,   			fact_comentario,   
           fact_estado ,  					fact_act_cliente,   
           fact_act_inventario,   		fact_act_conta,   
           fact_cerrada,   				fact_referencia_fac,   
           fact_monto_abonado,   		fact_fecha_act_conta,
			  fact_pedido_original,			fact_cuatro_decimales,
			  fact_usuario,				   fact_precio_a_utilizar,
			  fact_viene_de_pedido,		fact_origen_venta,
			  fact_ruc,			fact_dv,
			  fact_provincia_fe,		fact_distrito, 	fact_corregimiento)  			
     VALUES ( :str.g_financiero, 		:str.empresa,  
			  :ls_tipo_fac,						:ls_num_sec,   
           :w_fa_fondo.str_para.ano,   '0',
           :ll_cliente,   					:ls_ruc_cli,   
           :ls_condi_pag,   				:li_tipovent,   
           :ls_tipomov,   					:li_numtraspa,   
           :ldt_fecha_pedido,				:ldt_fecha_serv,  
           :ldt_fecha_serv,   			:li_dias_pago,  
			  :ldt_fecha_fin_plazo,				null,
           null,   							:ls_anombre,   
           :ls_direccion,   				:ls_despachado,   
           :ls_via,   						null,   
           null,   							:ll_bultostotal,   
           :ld_cubicaje,   				:ld_peso_tot, 
           :ls_unidpeso,  					:li_gastostot,  
           :ld_montototal,					:ls_decu_subt_det, 
           :li_por_descuento,  			:ls_supervi, 
           :ld_monto_final,   			:ls_comentario, 
           :ls_estado,						0,
			  0,									0,
			  0,									'',
			  0,									null,
			  :ls_no_pedido,					:li_cuatro_decimales,
			  :ls_user,				 		   :li_precio_a_utilizar,
			  1,									:ls_origen,
			  :ls_ruc,				:ls_dv,
			  :li_provincia,		:li_distrito,	:li_corregimiento)  ;					
			  
			If sqlca.sqlcode = -1  then
				ls_error =sqlca.sqlerrtext
				rollback using sqlca;
				sqlca.autocommit = true
				mensaje("Error ",ls_error,"")				
			  return
			Else
				
		//Cursor de los pedidos para la factura
		  Declare  cur_fadpedid Cursor For
		
			  	SELECT fadpecar.peca_codigo_cargo  
				 FROM fadpecar  
				WHERE ( fadpecar.peca_g_financiero = :str.g_financiero ) AND  
						( fadpecar.peca_empresa = :str.empresa ) AND  
						( fadpecar.peca_no_pedido = :ls_no_pedido  ) AND  
						( fadpecar.peca_ann = :li_ann_pedido) ; //w_fa_fondo.str_para.ano)   ;

			Open cur_fadpedid;
				Fetch cur_fadpedid into :ll_cargo ;
				
					If sqlca.sqlcode = -1 Then
						Messagebox("ERROR","Fallo del Cursor al intentar obtener los Cargos")
						rollback;
						sqlca.autocommit = true
						Close cur_fadpedid;
						Return
					End If
				
				Do While sqlca.Sqlcode = 0 
					  INSERT INTO fadcargo  
								( dcar_g_financiero,   
								  dcar_empresa,   
								  dcar_tipo,   
								  dcar_no_pedido,   
								  dcar_ann,   
								  dcar_codigo,   
								  dcar_monto )  
					  VALUES ( :str.g_financiero,   
								  :str.empresa,
								  :ls_tipo_fac,
								  :ls_num_sec,   
								  :w_fa_fondo.str_para.ano,   
								  :ll_cargo,   
								  :ld_monto )  ;

					Fetch cur_fadpedid into :ll_cargo ;
					
				LOOP
				If sqlca.sqlcode = -1  then
					ls_error =sqlca.sqlerrtext
					rollback using sqlca;
					mensaje("Error ",ls_error,"")
					sqlca.autocommit = true					
				  return
				End IF
				
				Close cur_fadpedid;  								
				  
	//Cursor para el vendedor de facturas	  
		Declare cur_fadvenfa cursor For		  
			  SELECT fadvenpe.vped_vendedor  
				 FROM fadvenpe  
				WHERE ( fadvenpe.vped_g_financiero = :str.g_financiero ) AND  
						( fadvenpe.vped_empresa = :str.empresa ) AND  
						( fadvenpe.vped_no_pedido = :ls_no_pedido ) AND  
						( fadvenpe.vped_ann = :li_ann_pedido ) ; //w_fa_fondo.str_para.ano )   ;
			
			Open cur_fadvenfa;
				Fetch cur_fadvenfa into :ll_vendedor;
						
					If sqlca.sqlcode = -1   Then
						Messagebox("ERROR","Fallo del Cursor al intentar obtener el vendedor")
						Close cur_fadvenfa;
						rollback;
						sqlca.autocommit = true
						Return
					End If
				
				Do While sqlca.Sqlcode = 0 	
					INSERT INTO fadvenfa  
						( vfac_g_financiero,   
						  vfac_empresa,   
						  vfac_tipo,   
						  vfac_no_pedido,   
						  vfac_ann,   
						  vfac_vendedor )    
					VALUES (:str.g_financiero,   
							  :str.empresa, 
							  :ls_tipo_fac,
							  :ls_num_sec,   
							  :w_fa_fondo.str_para.ano,   
							  :ll_vendedor )  ;
							  					
							If sqlca.sqlcode = -1 then
								  messagebox("Error",sqlca.sqlerrtext)
								  rollback using sqlca;
								  sqlca.autocommit = true								  
								  return
							End IF
					
					Fetch cur_fadvenfa into :ll_vendedor; 
				Loop
							
				Close cur_fadvenfa;	  
							
	
//	************************************************************************************

		DO
			ll_row ++
			li_linea = dw_4.GetItemNumber(ll_row,"fadpedid_dped_linea")

//			ll_found = dw_4.Find("empa_linea_original = "+string(li_linea),ll_row ,dw_4.RowCount())
			
//			If ll_found = 0 Or ll_found = dw_4.RowCount() then
//			If ll_found > 0  then

			  ls_pedido     = ls_num_sec
			  ls_prod_serv  = dw_4.GetItemString(ll_row,"fadpedid_dped_producto_servicio") 
           ls_cod_item   = dw_4.GetItemString(ll_row,"fadpedid_dped_codigo_item") 
           ls_desc_alter = dw_4.GetItemString(ll_row,"fadpedid_dped_descripcion_alterna")
           ls_uni_peso   = dw_4.GetItemString(ll_row,"fadpedid_dped_unidad_peso")
           ls_uni_prod   = dw_4.GetItemString(ll_row,"fadpedid_dped_unidad_producto")
           ld_precio_my  = dw_4.GetItemNumber(ll_row,"fadpedid_dped_precio_mayor") 
           ld_precio_mn  = dw_4.GetItemNumber(ll_row,"fadpedid_dped_precio_menor")
           ls_bodega     = dw_4.GetItemString(ll_row,"fadpedid_dped_bodega")
           ld_costo_fob  = dw_4.GetItemNumber(ll_row,"fadpedid_dped_costo_fob")
           ld_costo_cif  = dw_4.GetItemNumber(ll_row,"fadpedid_dped_costo_cif")
			  ld_precio_uni = dw_4.GetItemNumber(ll_row,"fadpedid_dped_precio_unidad_producto") 
			  li_por_desc   = dw_4.GetItemNumber(ll_row,"fadpedid_dped_por_descuento")

           ldt_fecha_reg = dw_4.GetItemdatetime(ll_row,"fadpedid_dped_fecha_reg")
           ls_usuario    = dw_4.GetItemString(ll_row,"fadpedid_dped_usuario")
           ls_supervisor = dw_4.GetItemString(ll_row,"fadpedid_dped_supervisor")
           ls_ubicacion  = dw_4.GetItemString(ll_row,"fadpedid_dped_ubicacion")
           ll_pasada     = dw_4.GetItemNumber(ll_row,"fadpedid_dped_pasada")
			  ll_bulto_inicio=dw_4.GetItemNumber(ll_row,"empa_bulto_inicio")
			  ll_bulto_fin  = dw_4.GetItemNumber(ll_row,"empa_bulto_fin")
			  ld_precio_original = dw_4.GetItemNumber(ll_row,"dped_precio_original")
			  
				  li_linea_orig = dw_4.GetItemNumber(ll_row,"empa_linea_original")
				
				  ld_cubicaje   = truncate(round(dw_4.GetItemNumber(ll_row,"empa_cubicaje"),4),4)
				  ld_peso      = truncate(round(dw_4.GetItemNumber(ll_row,"empa_peso"),4),4)
				  if isnull(ld_cubicaje) then ld_cubicaje = 0
				  if isnull(ld_peso) then ld_peso = 0
				  if ld_cubicaje = 0 and not lb_entro then
						gf_mensaje('','Existen Referencias sin Cubicaje Asignado, Verifique !!!',1,1,'E')
						lb_entro = true
				  end if
				  if ld_peso = 0 and not lb_entro then
						gf_mensaje('','Existen Referencias sin Peso Asignado, Verifique !!!',1,1,'E')
						lb_entro = true
				  end if

				  ls_uni_venta = dw_4.GetItemString(ll_row,"fadpedid_dped_unidad_venta")
				  ll_bultos    		= dw_4.GetItemNumber(ll_row,"empa_bultos")
				  ll_convert   = gf_unidad_venta(ls_uni_venta,gf_medi_prod( ls_uni_prod ))
				  if ll_convert = 0 or isnull(ll_convert) then
					  ll_convert = 1
				  end if
				  ld_precio    = ld_precio_uni / ll_convert
				  ll_cantidad  = dw_4.GetItemNumber(ll_row,"empa_cantidad")
				
				  ld_precio2   = ld_precio_original / ll_convert
				  
				  //-----------------------------------------------------------------------
				  //para poner como pasado el registro, si deja remanente	
				  ll_cantidad_pedido = dw_4.GetItemNumber(ll_row,"fadpedid_dped_cantidad")	
				  ll_fraccion_pedido = dw_4.GetItemNumber(ll_row,"fadpedid_dped_fraccion")					  
				  ll_cantidad_pedida = ll_cantidad_pedido * ll_convert + ll_fraccion_pedido
				  if ll_pasada + ll_cantidad < ll_cantidad_pedida then
								
					//Validar que tenga pendientes el pedido
					if dw_7.rowcount() > 0 then
						 ll_found = dw_7.find("producto = '"+ ls_cod_item +"'",1, dw_7.rowcount() )
						 if ll_found > 0 then
							li_procesado = dw_7.getitemnumber(ll_found, 'procesado')
							ll_pendiente_resumido  = 0
							if li_procesado = 0 then
								ll_pendiente_resumido = dw_7.getitemnumber(ll_found, 'pendiente')
							end if								
						 end if
					end if
					
					 if not lb_crear_encabezado then //crea el encabezado de las referencias a poner como pasadas
					 	
						if ll_pendiente_resumido > 23 then		//TENIA MAYOR a 0
						
	 					 lb_crear_encabezado = true	
						 lb_genero_pedido		= true
						 
				 		    INSERT INTO fatpedid  
								( pedi_g_financiero,  			pedi_empresa,   
								  pedi_tipo,   				   pedi_no_pedido,   
								  pedi_ann,   						   
								  pedi_cliente,   				pedi_ruc_cliente,   
								  pedi_condicion_pago,   		pedi_tipo_venta,   
								  pedi_tipo_movimiento,   		pedi_no_traspaso,   
								  pedi_fecha,   					pedi_fecha_creacion,   
								  pedi_fecha_modificacion,   	pedi_dias_pago,   
								  pedi_fecha_fin_plazo,   		   
								  pedi_consignado,   			pedi_a_nombre,   
								  pedi_a_nombre_direccion,   	pedi_despachado,   
								  pedi_via,   						pedi_con_emb_no,   
								  pedi_marca,   					pedi_bultos_total,   
								  pedi_cubicaje_total,   		pedi_peso_total,   
								  pedi_unidad_peso,   			pedi_gastos_total,   
								  pedi_monto_total,		   	pedi_descu_subt_deta,   
								  pedi_por_descuento,   		pedi_supervisor,   
								  pedi_monto_final,   			pedi_comentario,   
								  pedi_estado ,  					pedi_cuatro_decimales,
								  pedi_usuario,				   pedi_precio_a_utilizar,
								  pedi_viene_de_pedido,		pedi_origen_venta )  			
						  VALUES ( :str.g_financiero, 		:str.empresa,  
								  :ls_tipo_fac,					'P'+:ls_no_pedido,   
								  :w_fa_fondo.str_para.ano,   
								  :ll_cliente,   					:ls_ruc_cli,   
								  :ls_condi_pag,   				:li_tipovent,   
								  :ls_tipomov,   					:li_numtraspa,   
								  :ldt_fecha_pedido,				:ldt_fecha_serv,  
								  :ldt_fecha_serv,   			:li_dias_pago,  
								  :ldt_fecha_fin_plazo,			
								  null,   							:ls_anombre,   
								  :ls_direccion,   				:ls_despachado,   
								  :ls_via,   						null,   
								  null,   							:ll_bultostotal,   
								  :ld_cubicaje,   				:ld_peso_tot, 
								  :ls_unidpeso,  				:li_gastostot,  
								  :ld_montototal,				:ls_decu_subt_det, 
								  :li_por_descuento,  			:ls_supervi, 
								  :ld_monto_final,   			:ls_comentario, 
								  :ls_estado,						:li_cuatro_decimales,
								  :ls_user,				 		:li_precio_a_utilizar,
								  0,								:ls_origen )  ;					
								  
								If sqlca.sqlcode = -1  then
									ls_error =sqlca.sqlerrtext
									rollback using sqlca;
									mensaje("Error en encabezado del pedido",ls_error,"")
									sqlca.autocommit = true									
								  return
								Else
								//Cursor para el vendedor de facturas	  
									Declare cur_fadvenpe cursor For		  
										  SELECT fadvenpe.vped_vendedor  
											 FROM fadvenpe  
											WHERE ( fadvenpe.vped_g_financiero = :str.g_financiero ) AND  
													( fadvenpe.vped_empresa = :str.empresa ) AND  
													( fadvenpe.vped_no_pedido = :ls_no_pedido ) AND  
													( fadvenpe.vped_ann = :li_ann_pedido ) ; //w_fa_fondo.str_para.ano )   ;
										
										Open cur_fadvenpe;
											Fetch cur_fadvenpe into :ll_vendedor;
													
												If sqlca.sqlcode = -1   Then
													Messagebox("ERROR","Fallo del Cursor al intentar obtener el vendedor")
													Close cur_fadvenpe;
													rollback;
													sqlca.autocommit = true
													Return
												End If
											
											Do While sqlca.Sqlcode = 0 	
												INSERT INTO fadvenpe  
													( vped_g_financiero,   
													  vped_empresa,   
													  vped_tipo,   
													  vped_no_pedido,   
													  vped_ann,   
													  vped_vendedor )    
												VALUES (:str.g_financiero,   
														  :str.empresa, 
														  :ls_tipo_fac,
														  'P'+:ls_no_pedido,   
														  :w_fa_fondo.str_para.ano,   
														  :ll_vendedor )  ;
																			
														If sqlca.sqlcode = -1 then
															  messagebox("Error",sqlca.sqlerrtext)
															  rollback using sqlca;
																sqlca.autocommit = true															  
															  return
														End IF
												
												Fetch cur_fadvenpe into :ll_vendedor; 
											Loop
														
											Close cur_fadvenpe;	  
											
										end if														
										
							end if //Del ll_pendiente_resumido > 0
							
							//	************************************************************************************						 						 
					 end if //DEL CREAR ENCABEZADO DEL PEDIDO PENDIENTE
					 
					 ll_cantidad_pending_total = ll_pendiente_resumido // ll_cantidad_pedida - (ll_pasada + ll_cantidad) antes de cambios
					 gf_fa_convertuni_new(ls_uni_venta,ll_cantidad_pending_total,ll_cant_pending,ll_frac_pending)
					 
		 				 CHOOSE CASE ls_decu_subt_det
							CASE "D"
								  ld_monto_tot_pas_p = ld_precio2 * ll_cantidad_pending_total
								  ld_monto_tot_p = ld_monto_tot_pas_p
								  ld_monto_tot_pas_p = ld_precio * ll_cantidad_pending_total						  
								  ld_monto_fin_p = ld_monto_tot_pas_p
							CASE ELSE 
								  ld_monto_tot_pas_p = ld_precio * ll_cantidad_pending_total
								  ld_monto_tot_p     = ld_monto_tot_pas_p
								  ld_monto_fin_p     = ld_monto_tot_p
						 END CHOOSE

						  //Para el calculo del costo total por linea
						  ld_costo_uni_p   = ld_costo_cif / ll_convert	//costo minimo
						  ld_costo_total_p = ld_costo_uni_p * ll_cantidad_pending_total //costo total
					 
					 
						  ll_linea_pedido ++
						  
						  if ll_pendiente_resumido > 23 then		//TENIA MAYOR a 0
				 
							  INSERT INTO fadpedid  
									( dped_g_financiero,         		dped_empresa,
									  dped_no_pedido,				    dped_linea,
									  dped_ann,							dped_producto_servicio,    	
									  dped_codigo_item,				dped_descripcion_alterna,
									  dped_cubicaje,     				dped_peso,
									  dped_unidad_peso,   			dped_unidad_producto,
									  dped_precio_mayor,   			dped_precio_menor,
									  dped_bodega,						dped_costo_fob,
									  dped_costo_cif,					dped_precio_unidad_producto,
									  dped_unidad_venta,				dped_cantidad,
									  dped_fraccion,		  			dped_monto_total,
									  dped_por_descuento,			dped_monto_final, 
									  dped_fecha_reg, 				dped_usuario,
									  dped_supervisor,					dped_bultos,	
									  dped_ubicacion,
									  dped_index,						dped_viene_de_pedido,
									  dped_bulto_inicio,				dped_bulto_fin,
									  dped_precio_original,			dped_costo_total,
									  dped_validado,					dped_vendedor )					 //Para que no recalcule nada en la factura
								VALUES (:str.g_financiero,   		:str.empresa,   
										  'P'+:ls_no_pedido,				:ll_linea_pedido,  
										  :w_fa_fondo.str_para.ano,:ls_prod_serv,   
										  :ls_cod_item,   			:ls_desc_alter,   
										  :ld_cubicaje,   			:ld_peso,   
										  :ls_uni_peso,   			:ls_uni_prod,   
										  :ld_precio_my,   			:ld_precio_mn,   
										  :ls_bodega,				:ld_costo_fob,   
										  :ld_costo_cif,   			:ld_precio_uni,   
										  :ls_uni_venta,   			:ll_cant_pending,   
										  :ll_frac_pending,  		:ld_monto_tot_p,   
										  :li_por_desc,   			:ld_monto_fin_p,
										  :ldt_fecha_reg,   			:ls_usuario,   
										  :ls_supervisor,   			0,   
										  :ls_ubicacion,
										  :ll_linea_pedido,			1,
										  0,								0,
										  :ld_precio_original,		:ld_costo_total_p,
										  1,		:ll_vendedor);
							  
								If sqlca.sqlcode = -1  then
									ls_error =sqlca.sqlerrtext
									rollback using sqlca;
									mensaje("Error al insertar en fadpedid Pedido: P"+ls_no_pedido+" ",ls_error,"")
									sqlca.autocommit = true									
									return
								End If			
								
								dw_7.setitem(ll_found, 'procesado', 1)
												
							end if //del ll_pendiente_resumido > 0
					 
				  end if					
				  //Hasta aqui ---------------------------------------------------------------------------------				 			

				 CHOOSE CASE ls_decu_subt_det
					CASE "D"
						  ld_monto_tot_pas = ld_precio2 * ll_cantidad
						  ld_monto_tot = ld_monto_tot_pas
						  ld_monto_tot_pas = ld_precio * ll_cantidad						  
						  ld_monto_fin = ld_monto_tot_pas
					CASE ELSE 
						  ld_monto_tot_pas = ld_precio * ll_cantidad
						  ld_monto_tot     = ld_monto_tot_pas
						  ld_monto_fin     = ld_monto_tot
				 END CHOOSE
				
				ll_cantpas_tot = ll_cantidad //cantidad esta en lo minimo, ya que en la lista de empaque se 
														//guarda en lo minimo
			
//			  gf_fa_convertuni(ls_uni_venta,ll_cantpas_tot,ll_cant_ent,ld_cant_frac)
			  gf_fa_convertuni_new(ls_uni_venta,ll_cantpas_tot,ll_cant_ent,ll_cant_frac)

			  //Para el calculo del costo total por linea
			  ld_costo_uni   = ld_costo_cif / ll_convert	//costo minimo
			  ld_costo_total = ld_costo_uni * ll_cantidad //costo total
			 
			 //es la linea que se va a guardar en el detalle de la factura, ya que una linea de 
			 //pedido puede ser varias en la lista de empaque
			 
	 		  ll_linea_faddiari ++
 
			  INSERT INTO faddiari  
					( facd_g_financiero,         	facd_empresa,
					  facd_tipo,            	   facd_no_pedido,
					  facd_pedido_original,      	facd_linea,
					  facd_ann,							facd_producto_servicio,    	
					  facd_codigo_item,				facd_descripcion_alterna,
					  facd_cubicaje,     			facd_peso,
					  facd_unidad_peso,   			facd_unidad_producto,
					  facd_precio_mayor,   			facd_precio_menor,
					  facd_bodega,						facd_costo_fob,
					  facd_costo_cif,					facd_precio_unidad_producto,
					  facd_unidad_venta,				facd_cantidad,
					  facd_cantidad_fraccion,		facd_monto_total,
					  facd_por_descuento,			facd_monto_final, 
					  facd_fecha_reg, 				facd_usuario,
					  facd_supervisor,				facd_bultos,	
					  facd_pais,  						facd_ubicacion,
					  facd_cant_devuelta,			facd_linea_articulo_dev,
					  facd_index,						facd_viene_de_pedido,
					  facd_bulto_inicio,				facd_bulto_fin,
					  facd_precio_original,			facd_costo_total,
					  facd_validado,					facd_vendedor )					 //Para que no recalcule nada en la factura
				VALUES (:str.g_financiero,   		:str.empresa,   
						  :ls_tipo_fac,				:ls_pedido,
						  :ls_no_pedido,				:ll_linea_faddiari,  
						  :w_fa_fondo.str_para.ano,:ls_prod_serv,   
						  :ls_cod_item,   			:ls_desc_alter,   
						  :ld_cubicaje,   			:ld_peso,   
						  :ls_uni_peso,   			:ls_uni_prod,   
						  :ld_precio_my,   			:ld_precio_mn,   
						  :ls_bodega,					:ld_costo_fob,   
						  :ld_costo_cif,   			:ld_precio_uni,   
						  :ls_uni_venta,   			:ll_cant_ent,   
						  :ll_cant_frac,   			:ld_monto_tot,   
						  :li_por_desc,   			:ld_monto_fin,
						  :ldt_fecha_reg,   			:ls_usuario,   
						  :ls_supervisor,   			:ll_bultos,   
						  0,								:ls_ubicacion,
						  0,								0,
						  :ll_linea_faddiari,		1,
						  :ll_bulto_inicio,			:ll_bulto_fin,
						  :ld_precio_original,		:ld_costo_total,
						  1,							:ll_vendedor) ;
			  
				If sqlca.sqlcode = -1  then
					ls_error =sqlca.sqlerrtext
					rollback using sqlca;
					mensaje("Error al insertar en Faddiari",ls_error,"")
					sqlca.autocommit = true					
				  	return
				End If
				
				//Se puso la cantidad pedida para que limpie la reserva 27/11/2009	
				if dw_7.rowcount() > 0 then
						UPDATE fadpedid  
						  SET dped_pasada = dped_pasada +  :ll_cantidad_pedida  //:ll_cantpas_tot
						WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
								( fadpedid.dped_empresa = :str.empresa ) AND  
								( fadpedid.dped_no_pedido = :ls_no_pedido ) AND  
								( fadpedid.dped_ann =  :li_ann_pedido ) AND //w_fa_fondo.str_para.ano) AND  
								( fadpedid.dped_linea =  :li_linea) AND
								( fadpedid.dped_codigo_item = :ls_cod_item) ;	
				else //si tiene varias listas de empaque, que ponga como pasada solo la cantidad de la lista de empaque
					UPDATE fadpedid  
					  SET dped_pasada = dped_pasada +  :ll_cantpas_tot
					WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
							( fadpedid.dped_empresa = :str.empresa ) AND  
							( fadpedid.dped_no_pedido = :ls_no_pedido ) AND  
							( fadpedid.dped_ann =  :li_ann_pedido ) AND //w_fa_fondo.str_para.ano) AND  
							( fadpedid.dped_linea =  :li_linea) AND
							( fadpedid.dped_codigo_item = :ls_cod_item) ;

				end if
								
				If sqlca.sqlcode = -1  then
					ls_error =sqlca.sqlerrtext
					rollback using sqlca;
					mensaje("Error al actualizar cantidad pasada de fadpedid ",ls_error,"")
					sqlca.autocommit = true					
				  	return
				End If
				
				//Actualiza la reserva del pedido
				//no es necesario, ya que lo que queda pendiente, se corrige al terminar de pasar
				//el pedido
				//wf_actualizar_reservado(ls_producto)	
				
				ll_cantpas_tot = 0
				ll_bultos_tot  = 0
				ld_peso_tot    = 0
				ld_cubicaje_tot= 0
				ld_monto_tot   = 0
				ld_monto_fin   = 0
		//	End If 
		LOOP UNTIL ll_row	 = dw_4.Rowcount() //ll_found
		
		End If
	Else
		return
	End If

  SELECT sum(faddiari.facd_peso),   
         sum(faddiari.facd_cubicaje),   
         sum(faddiari.facd_monto_total),   
         sum(faddiari.facd_monto_final),
			sum(faddiari.facd_costo_total)
    INTO :ld_tot_peso,   
         :ld_tot_cubicaje,
			:ld_tot_montotot,
			:ld_tot_montofin,
			:ld_fact_costo_total
    FROM faddiari  
   WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
         ( faddiari.facd_empresa = :str.empresa ) AND  
         ( faddiari.facd_no_pedido =  :ls_num_sec  ) AND  
      	( faddiari.facd_ann = :w_fa_fondo.str_para.ano ) ;

		If sqlca.sqlcode = -1  then
			ls_error =sqlca.sqlerrtext
			rollback using sqlca;
			mensaje("Error ",ls_error,"")
			sqlca.autocommit = true			
			return
		End If
		
		
	 
	SELECT sum(fadpecar.peca_monto)
    INTO :ld_tot_gastostot  
    FROM fadpecar  
   WHERE ( fadpecar.peca_g_financiero = :str.g_financiero ) AND  
         ( fadpecar.peca_empresa = :str.empresa ) AND  
         ( fadpecar.peca_no_pedido = :ls_no_pedido ) AND  
         ( fadpecar.peca_ann = :li_ann_pedido ) ; //w_fa_fondo.str_para.ano )   ;
			
	If sqlca.sqlcode = -1  then
		ls_error =sqlca.sqlerrtext
		rollback using sqlca;
		mensaje("Error ",ls_error,"")
		sqlca.autocommit = true		
		return
	End If	

If IsNull(ld_tot_gastostot) then
	ld_tot_gastostot = 0
End If
If IsNull(ld_tot_montotot) then
	ld_tot_montotot = 0
End If 
If IsNull(ld_tot_montofin) then
	ld_tot_montofin = 0
End If 
	
 CHOOSE CASE ls_decu_subt_det  
	CASE "S"
		
		ld_final = (ld_tot_montotot + ld_tot_gastostot ) - ld_tot_montotot * (li_por_descuento/100)
		li_error = gf_clean_desc_pedi(ls_num_sec,w_fa_fondo.str_para.ano)
		
	CASE "D"
		
		ld_final = ld_tot_montofin + ld_tot_gastostot
		
	CASE "F"
		
		ld_final = ld_tot_montotot + ld_tot_gastostot - li_por_descuento
		li_error = gf_clean_desc_pedi(ls_num_sec,w_fa_fondo.str_para.ano)
		
	CASE "N"
		
		ld_final = ld_tot_montotot + ld_tot_gastostot 
		li_error = gf_clean_desc_pedi(ls_num_sec,w_fa_fondo.str_para.ano)
	
 END CHOOSE
	
If li_error = -1 then
	ls_error =sqlca.sqlerrtext
	rollback using sqlca;
	mensaje("Error ",ls_error,"")
	sqlca.autocommit = true	
  	return
End If	

  UPDATE fatdiari  
     SET fact_peso_total = :ld_tot_peso,   
         fact_cubicaje_total = :ld_tot_cubicaje,   
         fact_monto_fact_total =:ld_tot_montotot,   
         fact_gastos_total = :ld_tot_gastostot,   
         fact_monto_final =:ld_final,
		fact_costos_total = :ld_fact_costo_total,
		fact_viene_de_pedido = 0
   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
         ( fatdiari.fact_empresa = :str.empresa ) AND
         ( fatdiari.fact_no_pedido = :ls_num_sec ) AND  
         ( fatdiari.fact_ann = :w_fa_fondo.str_para.ano ) ;

			If sqlca.sqlcode = -1  then
				ls_error =sqlca.sqlerrtext
				rollback using sqlca;
				mensaje("Error al totalizar ",ls_error,"")
				sqlca.autocommit = true				
			  	return
			End If

//verificar si hay lineas que se quedaron pendientes y no esta el encabezado creado, lo cree
		select count(*) into :li_existe
		from fatpedid
		WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
				( fatpedid.pedi_empresa = :str.empresa ) AND  
				( fatpedid.pedi_no_pedido = 'P'+:ls_no_pedido ) AND  
				( fatpedid.pedi_ann =  :w_fa_fondo.str_para.ano) ;
				If sqlca.sqlcode = -1  then
					ls_error =sqlca.sqlerrtext
					rollback using sqlca;
					mensaje("Error al validar existencia ",ls_error,"")
					sqlca.autocommit = true				
					return
				End If

		if li_existe = 0 then
			lb_crear_encabezado = true 									
		end if


//----------------------------------------------------------------------------------------------------		
//Asigna los totales al nuevo pedido
if lb_crear_encabezado and dw_7.rowcount() > 0 then //si entro a crear el encabezado del pedido remanente	
							  
	//Verificar si hay lineas del pedido que no se pasaron totalmente
	 DECLARE cur_pendientes CURSOR FOR  
		 SELECT fadpedid.dped_linea,
		   fadpedid.dped_codigo_item,   
         fadpedid.dped_descripcion_alterna,   
         fadpedid.dped_cubicaje,   
         fadpedid.dped_peso,   
         fadpedid.dped_unidad_peso,   
         fadpedid.dped_unidad_producto,   
         fadpedid.dped_precio_mayor,   
         fadpedid.dped_precio_menor,   
         fadpedid.dped_bodega,   
         fadpedid.dped_costo_fob,   
         fadpedid.dped_costo_cif,   
         fadpedid.dped_precio_unidad_producto,   
         fadpedid.dped_unidad_venta,   
         fadpedid.dped_cantidad,   
         fadpedid.dped_fraccion,   
         fadpedid.dped_monto_total,   
         fadpedid.dped_por_descuento,   
         fadpedid.dped_monto_final,            
         fadpedid.dped_bultos,   
         fadpedid.dped_ubicacion,   
         fadpedid.dped_bulto_inicio,   
         fadpedid.dped_bulto_fin,   
         fadpedid.dped_precio_original,   		
         fadpedid.dped_reserva_origen,   			
         fadpedid.dped_num_orden_compra,   
         fadpedid.dped_ann_orden_compra,   
         fadpedid.dped_num_transito,   
         fadpedid.dped_costo_total,   
         fadpedid.dped_ann_transito,  			
         fadpedid.dped_linea_orden,   
         fadpedid.dped_linea_transito,   
         fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion cantidad_a_pasar  ,
		fadpedid.dped_vendedor
    FROM fadpedid,   
         inamedid  
   WHERE ( fadpedid.dped_unidad_venta = inamedid.medi_medida ) and  
         ( ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
         ( fadpedid.dped_empresa = :str.empresa ) AND  
         ( fadpedid.dped_no_pedido = :ls_no_pedido ) AND  
         ( fadpedid.dped_ann = :li_ann_pedido ) AND //w_fa_fondo.str_para.ano ) AND  
         ( fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion > fadpedid.dped_pasada ) )   ; 
			If sqlca.sqlcode = -1  then
				ls_error =sqlca.sqlerrtext
				rollback using sqlca;
				mensaje("Error ",ls_error,"")
				sqlca.autocommit = true				
			  	return
			End If

  			open cur_pendientes ;

			fetch cur_pendientes into :li_linea,  :ls_cod_item, :ls_desc_alter, :ld_cubicaje, :ld_peso, :ls_uni_peso, :ls_uni_prod,   &
						  :ld_precio_my, :ld_precio_mn, :ls_bodega, :ld_costo_fob, :ld_costo_cif, :ld_precio_uni, :ls_uni_venta, &
						  :ll_cant_pending, :ll_frac_pending, :ld_monto_tot_p, :li_por_desc, :ld_monto_fin_p, :ll_bultos, &
						  :ls_ubicacion, :ll_bulto_inicio, :ll_bulto_fin, :ld_precio_original, :ls_reser_origen , :ls_orden_compra, :li_ann_compra, &
						  :ls_transito, :ld_costo_total_p, :li_ann_transito, :li_lin_orden, :li_lin_transito, :ld_pasada, :ll_vendedor;
					If sqlca.sqlcode = -1  then
						ls_error =sqlca.sqlerrtext
						rollback using sqlca;
						mensaje("Error en el fetch: ",ls_error,"")
						sqlca.autocommit = true									
						return
					End If			

			Do While sqlca.Sqlcode = 0 	
				
				  //Si no encontro el encabezado y se requiere para algunos detalles, lo crea
				  if li_existe = 0 then
					
							 li_existe = 1 //para que solo entre una vez
						    lb_genero_pedido		= true							 
						    INSERT INTO fatpedid  
								( pedi_g_financiero,  			pedi_empresa,   
								  pedi_tipo,   				   pedi_no_pedido,   
								  pedi_ann,   						   
								  pedi_cliente,   				pedi_ruc_cliente,   
								  pedi_condicion_pago,   		pedi_tipo_venta,   
								  pedi_tipo_movimiento,   		pedi_no_traspaso,   
								  pedi_fecha,   					pedi_fecha_creacion,   
								  pedi_fecha_modificacion,   	pedi_dias_pago,   
								  pedi_fecha_fin_plazo,   		   
								  pedi_consignado,   			pedi_a_nombre,   
								  pedi_a_nombre_direccion,   	pedi_despachado,   
								  pedi_via,   						pedi_con_emb_no,   
								  pedi_marca,   					pedi_bultos_total,   
								  pedi_cubicaje_total,   		pedi_peso_total,   
								  pedi_unidad_peso,   			pedi_gastos_total,   
								  pedi_monto_total,		   	pedi_descu_subt_deta,   
								  pedi_por_descuento,   		pedi_supervisor,   
								  pedi_monto_final,   			pedi_comentario,   
								  pedi_estado ,  					pedi_cuatro_decimales,
								  pedi_usuario,				   pedi_precio_a_utilizar,
								  pedi_viene_de_pedido,		pedi_origen_venta)  			
						  VALUES ( :str.g_financiero, 		:str.empresa,  
								  :ls_tipo_fac,					'P'+:ls_no_pedido ,   
								  :w_fa_fondo.str_para.ano,   
								  :ll_cliente,   					:ls_ruc_cli,   
								  :ls_condi_pag,   				:li_tipovent,   
								  :ls_tipomov,   					:li_numtraspa,   
								  :ldt_fecha_pedido,				:ldt_fecha_serv,  
								  :ldt_fecha_serv,   			:li_dias_pago,  
								  :ldt_fecha_fin_plazo,			
								  null,   							:ls_anombre,   
								  :ls_direccion,   				:ls_despachado,   
								  :ls_via,   						null,   
								  null,   							:ll_bultostotal,   
								  :ld_cubicaje,   				:ld_peso_tot, 
								  :ls_unidpeso,  					0,  
								  0,					:ls_decu_subt_det, 
								  :li_por_descuento,  			:ls_supervi, 
								  0,   			:ls_comentario, 
								  :ls_estado,						:li_cuatro_decimales,
								  :ls_user,				 		   :li_precio_a_utilizar,
								  0,			:ls_origen )  ;					
								  
								If sqlca.sqlcode = -1  then
									ls_error =sqlca.sqlerrtext
									rollback using sqlca;
									mensaje("Error en encabezado del pedido total: ",ls_error,"")
									sqlca.autocommit = true									
								  return
								Else
								//Cursor para el vendedor de facturas	  
									Declare cur_fadvenpe2 cursor For		  
										  SELECT fadvenpe.vped_vendedor  
											 FROM fadvenpe  
											WHERE ( fadvenpe.vped_g_financiero = :str.g_financiero ) AND  
													( fadvenpe.vped_empresa = :str.empresa ) AND  
													( fadvenpe.vped_no_pedido = :ls_no_pedido ) AND  
													( fadvenpe.vped_ann = :li_ann_pedido ) ; //w_fa_fondo.str_para.ano )   ;
										
										Open cur_fadvenpe2;
											Fetch cur_fadvenpe2 into :ll_vendedor;
													
												If sqlca.sqlcode = -1   Then
													Messagebox("ERROR VENDEDORES","Fallo del Cursor al intentar obtener el vendedor")
													Close cur_fadvenpe2;
													rollback;
													sqlca.autocommit = true
													Return
												End If
											
											Do While sqlca.Sqlcode = 0 	
												INSERT INTO fadvenpe  
													( vped_g_financiero,   
													  vped_empresa,   
													  vped_tipo,   
													  vped_no_pedido,   
													  vped_ann,   
													  vped_vendedor )    
												VALUES (:str.g_financiero,   
														  :str.empresa, 
														  :ls_tipo_fac,
														  'P'+:ls_no_pedido ,   
														  :w_fa_fondo.str_para.ano,   
														  :ll_vendedor )  ;
																			
														If sqlca.sqlcode = -1 then
															  messagebox("Error Insert: ",sqlca.sqlerrtext)
															  rollback using sqlca;
																sqlca.autocommit = true															  
															  return
														End IF
												
												Fetch cur_fadvenpe2 into :ll_vendedor; 
											Loop
														
											Close cur_fadvenpe2;	  
											
										end if
										
				  end if //del li_existe = 0
				
			 	  ll_linea_pedido ++
				
				  INSERT INTO fadpedid  
					( dped_g_financiero,         	dped_empresa,
					  dped_no_pedido,				   dped_linea,
					  dped_ann,							dped_producto_servicio,    	
					  dped_codigo_item,				dped_descripcion_alterna,
					  dped_cubicaje,     			dped_peso,
					  dped_unidad_peso,   			dped_unidad_producto,
					  dped_precio_mayor,   			dped_precio_menor,
					  dped_bodega,						dped_costo_fob,
					  dped_costo_cif,					dped_precio_unidad_producto,
					  dped_unidad_venta,				dped_cantidad,
					  dped_fraccion,		  			dped_monto_total,
					  dped_por_descuento,			dped_monto_final, 
					  dped_fecha_reg, 				dped_usuario,
					  dped_supervisor,				dped_bultos,	
					  dped_ubicacion,
					  dped_index,						dped_viene_de_pedido,
					  dped_bulto_inicio,				dped_bulto_fin,
					  dped_precio_original,			dped_costo_total,
					  dped_validado, 	         	fadpedid.dped_reserva_origen,   			
			         fadpedid.dped_num_orden_compra,   fadpedid.dped_ann_orden_compra,   
			         fadpedid.dped_num_transito,       fadpedid.dped_ann_transito,  
						fadpedid.dped_linea_orden,        fadpedid.dped_linea_transito , dped_vendedor
 )					 //Para que no recalcule nada en la factura
				VALUES (:str.g_financiero,   		:str.empresa,   
						  'P'+:ls_no_pedido,				:ll_linea_pedido,  
						  :w_fa_fondo.str_para.ano,:ls_prod_serv,   
						  :ls_cod_item,   			:ls_desc_alter,   
						  :ld_cubicaje,   			:ld_peso,   
						  :ls_uni_peso,   			:ls_uni_prod,   
						  :ld_precio_my,   			:ld_precio_mn,   
						  :ls_bodega,					:ld_costo_fob,   
						  :ld_costo_cif,   			:ld_precio_uni,   
						  :ls_uni_venta,   			:ll_cant_pending,   
						  :ll_frac_pending,  		:ld_monto_tot_p,   
						  :li_por_desc,   			:ld_monto_fin_p,
						  :ldt_fecha_reg,   			:ls_usuario,   
						  :ls_supervisor,   			:ll_bultos,   
						  :ls_ubicacion,
						  :ll_linea_pedido,			1,
						  :ll_bulto_inicio,			:ll_bulto_fin,
						  :ld_precio_original,		:ld_costo_total_p,
						  1,								:ls_reser_origen,
						  :ls_orden_compra, 			:li_ann_compra,
						  :ls_transito,				:li_ann_transito,
						  :li_lin_orden,			:li_lin_transito, :ll_vendedor );
							If sqlca.sqlcode = -1  then
								ls_error =sqlca.sqlerrtext
								rollback using sqlca;
								mensaje("Error al insertar en fadpedid, lineas: ",ls_error,"")
								sqlca.autocommit = true									
								return
							End If			
				
					//Pone a pasado el producto del pedido original
					UPDATE fadpedid  
						  SET dped_pasada = :ld_pasada
						WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
								( fadpedid.dped_empresa = :str.empresa ) AND  
								( fadpedid.dped_no_pedido = :ls_no_pedido ) AND  
								( fadpedid.dped_ann =  :li_ann_pedido ) AND //w_fa_fondo.str_para.ano) AND  
								( fadpedid.dped_linea =  :li_linea) AND
								( fadpedid.dped_codigo_item = :ls_cod_item) ;
					
					If sqlca.sqlcode = -1  then
						ls_error =sqlca.sqlerrtext
						rollback using sqlca;
						mensaje("Error al actualizar cantidad pasada de fadpedid totales ",ls_error,"")
						sqlca.autocommit = true					
						return
					End If
					
				
					fetch cur_pendientes into :li_linea, :ls_cod_item, :ls_desc_alter, :ld_cubicaje, :ld_peso, :ls_uni_peso, :ls_uni_prod,   &
						  :ld_precio_my, :ld_precio_mn, :ls_bodega, :ld_costo_fob, :ld_costo_cif, :ld_precio_uni, :ls_uni_venta, &
						  :ll_cant_pending, :ll_frac_pending, :ld_monto_tot_p, :li_por_desc, :ld_monto_fin_p, :ll_bultos, &
						  :ls_ubicacion, :ll_bulto_inicio, :ll_bulto_fin, :ld_precio_original, :ls_reser_origen , :ls_orden_compra, :li_ann_compra, &
						  :ls_transito, :ld_costo_total_p, :li_ann_transito, :li_lin_orden, :li_lin_transito, :ld_pasada, :ll_vendedor;
							If sqlca.sqlcode = -1  then
								ls_error =sqlca.sqlerrtext
								rollback using sqlca;
								mensaje("Error en el fetch: ",ls_error,"")
								sqlca.autocommit = true									
								return
							End If			
			loop

			close cur_pendientes;

	//TOTALIZA

  SELECT isnull(sum(fadpedid.dped_peso),0),   
         isnull(sum(fadpedid.dped_cubicaje),0),   
         isnull(sum(fadpedid.dped_monto_total),0),   
         isnull(sum(fadpedid.dped_monto_final),0),
			isnull(sum(fadpedid.dped_costo_total),0)
    INTO :ld_tot_peso,   
         :ld_tot_cubicaje,
			:ld_tot_montotot,
			:ld_tot_montofin,
			:ld_fact_costo_total
    FROM fadpedid  
   WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
         ( fadpedid.dped_empresa = :str.empresa ) AND  
         ( fadpedid.dped_no_pedido =  'P'+:ls_no_pedido  ) AND  
      	( fadpedid.dped_ann = :w_fa_fondo.str_para.ano ) ;

		If sqlca.sqlcode = -1  then
			ls_error =sqlca.sqlerrtext
			rollback using sqlca;
			mensaje("Error en sumatoria ",ls_error,"")
			sqlca.autocommit = true			
			return
		End If

  UPDATE fatpedid  
     SET pedi_peso_total = :ld_tot_peso,   
         pedi_cubicaje_total = :ld_tot_cubicaje,   
         pedi_monto_total =:ld_tot_montotot,   
         pedi_gastos_total = 0,   
         pedi_monto_final =:ld_tot_montofin,
			pedi_costos_total = :ld_fact_costo_total,
			pedi_viene_de_pedido = 0
   WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
         ( fatpedid.pedi_empresa = :str.empresa ) AND
         ( fatpedid.pedi_no_pedido = 'P'+:ls_no_pedido ) AND  
         ( fatpedid.pedi_ann = :w_fa_fondo.str_para.ano ) ;

			If sqlca.sqlcode = -1  then
				ls_error =sqlca.sqlerrtext
				rollback using sqlca;
				mensaje("Error en la suma del pedido P",ls_error,"")
				sqlca.autocommit = true				
			  	return				  
			End If
	
end if
//----------------------------------------------------------------------------------------------------			
			

//		SELECT Count(*) 
//		 INTO :ll_existe
//			 FROM fadempaq,   
//					fatempaq,   
//					fadpedid  
//			WHERE ( fatempaq.enca_g_financiero = fadempaq.empa_g_financiero ) and  
//					( fatempaq.enca_empresa = fadempaq.empa_empresa ) and  
//					( fatempaq.enca_lista_empaque = fadempaq.empa_lista_empaque ) and  
//					( fatempaq.enca_ann = fadempaq.empa_ann ) and
//					( fatempaq.enca_g_financiero = fadpedid.dped_g_financiero ) and  
//					( fatempaq.enca_empresa = fadpedid.dped_empresa ) and  
//					( fatempaq.enca_no_pedido = fadpedid.dped_no_pedido ) and  
//					( fatempaq.enca_ann_pedido = fadpedid.dped_ann ) and  
//					( fadempaq.empa_linea_original = fadpedid.dped_linea ) and  
//					( ( fatempaq.enca_g_financiero = :str.g_financiero ) AND  
//					( fatempaq.enca_empresa = :str.empresa ) AND  
//					( fatempaq.enca_lista_empaque = :ls_lista_emp ) AND  
//					( fatempaq.enca_ann = :ll_ann_emp ) and 		
//					fadpedid.dped_pasada <  (fadpedid.dped_fraccion + fadpedid.dped_cantidad * 
//													(SELECT inamedid.medi_cantidad FROM inamedid WHERE 
//													inamedid.medi_medida = fadpedid.dped_unidad_venta )));
//			
//			if sqlca.sqlcode = -1 then
//				mensaje('Aviso','Error al Verificar Existencia',sqlca.sqlerrtext)
//				return
//			end if
		
//		If ll_existe = 0 then
			  UPDATE fatempaq
			  SET enca_pasado = "S"   
			WHERE ( fatempaq.enca_g_financiero = :str.g_financiero ) AND  
					( fatempaq.enca_empresa = :str.empresa ) AND  
					( fatempaq.enca_no_pedido = :ls_no_pedido ) AND  
					( fatempaq.enca_ann_pedido = :li_ann_pedido ) AND //w_fa_fondo.str_para.ano ) AND
					( fatempaq.enca_lista_empaque = :ls_lista_emp) AND
					( fatempaq.enca_ann =  :ll_ann_emp) ;
		
				If sqlca.sqlcode = -1 then
					ls_error =sqlca.sqlerrtext
					rollback using sqlca;
					mensaje("Error ","Error al marcar estado de la Lista de Empaque como Pasada "+ls_error,"")
					return
				End If
//		End If
//		
		//		ACTUALIZAR A PASADO EL PEDIDO, SI Y SOLO SI EL PEDIDO FUE PASADO EN SU TOTALIDAD	
		SELECT Count(*) 
		 INTO :ll_existe
		 FROM fadpedid,
					fatpedid
			WHERE ( fatpedid.pedi_g_financiero = fadpedid.dped_g_financiero ) and
					( fatpedid.pedi_empresa = fadpedid.dped_empresa ) and
					( fatpedid.pedi_no_pedido = fadpedid.dped_no_pedido ) and
					( fatpedid.pedi_ann = fadpedid.dped_ann ) and
					( fatpedid.pedi_g_financiero = :str.g_financiero) AND
					( fatpedid.pedi_empresa = :str.empresa ) and
					( fatpedid.pedi_no_pedido = :ls_no_pedido ) and
					( fatpedid.pedi_ann = :li_ann_pedido) and
						fadpedid.dped_pasada <  (fadpedid.dped_fraccion + fadpedid.dped_cantidad * (SELECT inamedid.medi_cantidad
			FROM    inamedid
			WHERE inamedid.medi_medida = fadpedid.dped_unidad_venta)) ;
				If sqlca.sqlcode = -1 then
					ls_error =sqlca.sqlerrtext
					rollback using sqlca;
					mensaje("Error ","Error al verificar lo pasado "+ls_error,"")
					return
				End If
		
			If ll_existe = 0 then
				  UPDATE fatpedid  
					  SET pedi_estado = "P"  
					WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
							( fatpedid.pedi_empresa 	= :str.empresa ) AND  
							( fatpedid.pedi_no_pedido 	= :ls_no_pedido ) AND  
							( fatpedid.pedi_ann = :li_ann_pedido )   ;
			
					If sqlca.sqlcode = -1 then
						ls_error =sqlca.sqlerrtext
						rollback using sqlca;
						mensaje("Error ","Error al marcar estado del pedido Pasado "+ls_error,"")
						return
					End If					
					
			End If //del existe = 0



commit;	

Messagebox("AVISO","Se ha efectuado el pase a Factura Exitosamente")

if lb_genero_pedido then
	gf_mensaje('','Se genero el pedido P'+ls_no_pedido+' con las referencias pendientes',1,1,'E')
end if
				
ll_cliente = idch_cliente.GetItemnumber(idch_cliente.GetRow(),"terc_tercero")

If dw_1.Retrieve(str.g_financiero,str.empresa,ll_cliente) < 1 then dw_3.Reset()
dw_3.Reset()
dw_4.Reset()
end subroutine

on w_fa_co_pak_pase_fact.create
int iCurrent
call super::create
this.gb_6=create gb_6
this.gb_nose=create gb_nose
this.dw_2=create dw_2
this.rb_4=create rb_4
this.dw_3=create dw_3
this.pb_3=create pb_3
this.dw_5=create dw_5
this.pb_4=create pb_4
this.dw_6=create dw_6
this.dw_4=create dw_4
this.gb_4=create gb_4
this.gb_2=create gb_2
this.rb_3=create rb_3
this.pb_2=create pb_2
this.rb_1=create rb_1
this.dw_7=create dw_7
this.st_1=create st_1
this.sle_ann=create sle_ann
this.gb_5=create gb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_6
this.Control[iCurrent+2]=this.gb_nose
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.rb_4
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.pb_3
this.Control[iCurrent+7]=this.dw_5
this.Control[iCurrent+8]=this.pb_4
this.Control[iCurrent+9]=this.dw_6
this.Control[iCurrent+10]=this.dw_4
this.Control[iCurrent+11]=this.gb_4
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.rb_3
this.Control[iCurrent+14]=this.pb_2
this.Control[iCurrent+15]=this.rb_1
this.Control[iCurrent+16]=this.dw_7
this.Control[iCurrent+17]=this.st_1
this.Control[iCurrent+18]=this.sle_ann
this.Control[iCurrent+19]=this.gb_5
end on

on w_fa_co_pak_pase_fact.destroy
call super::destroy
destroy(this.gb_6)
destroy(this.gb_nose)
destroy(this.dw_2)
destroy(this.rb_4)
destroy(this.dw_3)
destroy(this.pb_3)
destroy(this.dw_5)
destroy(this.pb_4)
destroy(this.dw_6)
destroy(this.dw_4)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.rb_3)
destroy(this.pb_2)
destroy(this.rb_1)
destroy(this.dw_7)
destroy(this.st_1)
destroy(this.sle_ann)
destroy(this.gb_5)
end on

event ue_post_open;//Override
gf_center_win(This)
this.y=1

string ls_vienede, ls_where,ls_medact
long ll_recupero
		
	DataWindowChild child_produc
	
	dw_1.SetTransObject(Sqlca)
	
	dw_2.SetTransObject(SQLCA)
	Dw_2.InsertRow(0)
	dw_2.setfocus()
	dw_2.SetColumn("texto")
	
	dw_3.SetTransObject(SQLCA)
	
	dw_7.SetTransObject(Sqlca)
	
	 SELECT count(*)  
    INTO :ll_recupero  
    FROM ccmclien,   
         dgmterce  
   WHERE ( dgmterce.terc_tercero = ccmclien.clie_tercero ) and  
         ( ccmclien.clie_ruc_tercero = dgmterce.terc_identificacion ) and  
         ( ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
         ( ccmclien.clie_empresa = :str.empresa ) )   ;

	if sqlca.sqlcode = -1 then
		mensaje("Aviso","Error al Verificar existencia del Cliente", sqlca.sqlerrtext)
	end if


	if ll_recupero < 0 then
		dw_1.insertrow(0)
	end if

	
	
	dw_4.GetChild("fadpedid_dped_unidad_venta", idw_child_uni)
	idw_child_uni.setTransObject(sqlca)
	idw_child_uni.Retrieve()
	dw_4.SetTransObject(sqlca)
	
	dw_5.Accepttext()
	dw_5.GetChild("notercero",idch_cliente)
	idch_cliente.SetTransObject(Sqlca)
	
	dw_6.SetTransObject(Sqlca)
	dw_6.InsertRow(0)
	
	  SELECT Count (*)  
		 INTO :ll_recupero  
		 FROM ccmclien  
		WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
				( ccmclien.clie_empresa = :str.empresa )  ;
	if sqlca.sqlcode = -1 then
		mensaje("Aviso","Error al Verificar existencia del Cliente", sqlca.sqlerrtext)
	end if
	
//	If ll_recupero < 1 then
//		idch_cliente.InsertRow(0)
//	Else
	If idch_cliente.Retrieve(str.g_financiero,str.empresa) < 1 then idch_cliente.InsertRow(0)
//	End If
	dw_5.SetTransObject(Sqlca)
	dw_5.ScrollToRow(dw_5.InsertRow(0))
	dw_5.SetFocus()
	
	pb_2.DisabledName = ""+ str.path +"\art\pasar_rp.bmp"
	pb_2.Enabled = false
	str.frame.SetMicroHelp ("Seleccione una Línea y Presione la Tecla Enter para Cargar la Información" )
	

end event

event resize;//
end event

event open;//Override
st_nom_ventana.text = this.classname()
ii_ann = Integer(Year(Date(gf_fecha_serv())))
sle_ann.text = string(ii_ann)
this.triggerevent("ue_post_open")
end event

event close;Window lw_frame
 

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
 
end event

event closequery;constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)

This.SetRedraw(false)
end event

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_co_pak_pase_fact
boolean visible = false
integer x = 32
integer y = 1628
integer width = 1111
long backcolor = 74481808
end type

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_co_pak_pase_fact
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_co_pak_pase_fact
event ue_down pbm_dwnkey
event ue_post ( )
integer x = 73
integer y = 140
integer width = 2633
integer height = 368
integer taborder = 40
string dataobject = "dw_ma_fa_empag"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event dw_1::rowfocuschanged;//Recupera los datos del detalle haciendo referencia al encabezado
//JORGE HERRERA 11/03/1998

String ls_prof
Integer li_ano, li_rows

li_rows = this.RowCount()
If this.RowCount() < 1 Or currentrow = 0 then return
If currentrow = this.GetRow() Then


	ls_prof = GetitemString(currentrow ,"fatempaq_enca_lista_empaque")
	li_ano =  GetitemNumber(currentrow ,"fatempaq_enca_ann")
	
	parent.SetRedraw(False)
	dw_3.Retrieve(str.g_financiero,str.empresa,ls_prof,li_ano)

	If dw_4.RowCount() > 0 then 
		dw_4.Reset()
	End If
	parent.SetRedraw(true)

End IF


end event

event dw_1::clicked;/*Jorge Herrera*/
//24/2/99

String ls_lista
Integer li_ano

If this.RowCount() < 1 Or Row = 0 then return

ii_ultgetrow = row

ls_lista = GetitemString(row ,"fatempaq_enca_lista_empaque")
li_ano =  GetitemNumber(row ,"fatempaq_enca_ann")


this.SetRedraw(False)
dw_3.Retrieve(str.g_financiero,str.empresa,ls_lista,li_ano)

If dw_4.RowCount() > 0 then 
	dw_4.Reset()
End If
this.SetRedraw(True)

idw_cual = this
pb_4.enabled = false
ii_escpri = 0		

end event

event dw_1::retrieveend;//
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_co_pak_pase_fact
boolean visible = false
integer width = 3072
integer height = 484
integer taborder = 0
long textcolor = 8388608
long backcolor = 74481808
string text = "Encabezado"
end type

type gb_6 from groupbox within w_fa_co_pak_pase_fact
integer x = 2304
integer y = 508
integer width = 402
integer height = 196
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Ejecutar Pase"
borderstyle borderstyle = styleraised!
end type

type gb_nose from groupbox within w_fa_co_pak_pase_fact
integer x = 32
integer y = 724
integer width = 2715
integer height = 444
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 74481808
string text = "Detalle"
end type

type dw_2 from datawindow within w_fa_co_pak_pase_fact
event editchanged pbm_dwnchanging
integer x = 1330
integer y = 588
integer width = 896
integer height = 84
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_texto"
boolean border = false
boolean livescroll = true
end type

event editchanged;String ls_letra,formato,ls_setting,ls_estado
//This.accepttext()
ls_letra =This.getitemstring(1,1) 



If Match (data, "%") = True Then Return
If ls_letra = "Texto" Then Return


// Permite Modificar el estado Con la Finalidad de que Funcione el Filtrado
      ls_setting = dw_1.Describe("DataWindow.Retrieve.AsNeeded")
       If ls_setting = "yes" Then 
           dw_1.Modify("DataWindow.Retrieve.AsNeeded=No")	
       End If	

If rb_1.Checked = True Then /*PASADO*/
	Formato = "fatpedid_pedi_estado like " +"'"+data+"%"+"'"

ElseIf rb_4.Checked = True Then /*A PEDIDO*/
//	Formato =  "fatpedid_pedi_no_pedido like " +"'"+data+"%"+"'"
	
ElseIf rb_3.Checked = True Then /*EMPAQUE*/
	Formato =  "fatempaq_enca_lista_empaque like " +"'"+data+"%"+"'"

//ELSEIF rb_6.Checked = True THEN /*Fecha*/
//	Formato =  " date(fatpedid_pedi_fecha) Between " + &
//	                  "Date(" + "'" + em_1.text + "'" + ")" + " And " + & 
//					"Date("+ "'" +em_2.text +"'"+")"

END IF
If Formato <> "" Then
	dw_1.SetFilter(Formato)
	dw_1.Filter()
	If dw_1.RowCount() > 0 Then 
		dw_3.Reset()
	else
//		wf_buscar_registro(data)
	end if
	
End If
end event

event itemchanged;//Para buscar el pedido o lista de empaque
this.accepttext()
if dw_1.rowcount() = 0 then wf_buscar_registro(data)
end event

type rb_4 from radiobutton within w_fa_co_pak_pase_fact
integer x = 690
integer y = 588
integer width = 251
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 74481808
string text = "Pedido"
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")


end event

type dw_3 from datawindow within w_fa_co_pak_pase_fact
event ue_lbuttonup pbm_dwnlbuttonup
integer x = 73
integer y = 780
integer width = 2057
integer height = 356
integer taborder = 80
boolean bringtotop = true
string dataobject = "dw_ma_fa_dempaq"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;idw_cual = this
pb_3.enabled= true
pb_4.enabled = false
ii_clicked = row



end event

event retrieveend;//Script que Calcula las cantidades por pasar 
//Jorge Herrera Inicio 6/5/1999 // Modificado 25/05/2000 by HGN
String  ls_uni, ls_item, ls_uni_min
long  ll_cantidad, ll_fraccion, ll_i, ll_cant_pas, ll_cant_frac, ll_tipo_medida
Integer 	li_rows

this.SetRedraw(False)

li_rows = this.RowCount()

For ll_i = 1 to li_rows
	
	ls_item = This.Getitemstring(ll_i,"fadpedid_dped_codigo_item")
	
	ls_uni = This.GetitemString(ll_i,"fadpedid_dped_unidad_venta")
	ll_tipo_medida = gf_medi_prod(ls_uni)

	SELECT inamedid.medi_enlace
	Into	:ls_uni_min
	FROM  inamedid  
	WHERE inamedid.medi_tipo_medida = :ll_tipo_medida and
		   inamedid.medi_medida = :ls_uni;
	
	ll_cantidad = This.GetitemNumber(ll_i,"empa_cantidad")

	//gf_fa_convertuni(ls_uni,ll_fraccion,ll_cant_pas,ld_cant_frac)
	
//	this.SetITem(ll_i,"c_cant_frac",string(ll_cant_pas)+"."+string(ld_cant_frac))
	this.SetITem(ll_i,"c_cant_frac",ll_cantidad)
	this.SetITem(ll_i,"empa_unidad",ls_uni_min)
	
Next

this.SetRedraw(True)
end event

type pb_3 from picturebutton within w_fa_co_pak_pase_fact
integer x = 2249
integer y = 916
integer width = 389
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pasar "
end type

event clicked;parent.Triggerevent("ue_pasarow")
end event

type dw_5 from datawindow within w_fa_co_pak_pase_fact
event ue_key pbm_dwnkey
integer x = 87
integer y = 32
integer width = 1234
integer height = 108
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_dd_fa_clientes2"
boolean border = false
boolean livescroll = true
end type

event ue_key;long ll_clien

If Key = KeyF1! then
	  Open(w_fa_co_clien)
				ll_clien = Message.Doubleparm
				
				If IsNull(ll_clien) Then 
					Return
				Else
					This.SetItem(1,"notercero",ll_clien)			
				End If	
End IF
end event

event itemchanged;long ll_cliente
dw_5.Accepttext()
ll_cliente = idch_cliente.GetItemnumber(idch_cliente.GetRow(),"terc_tercero")
dw_3.Reset()
dw_4.Reset()
//w_fa_fondo.str_para.ano
If dw_1.Retrieve(str.g_financiero,str.empresa,ll_cliente) < 1 then
	dw_3.Reset()
Else	
	pb_2.PictureName = str.path +"\art\pasar_rp.bmp"
	pb_2.enabled = true
End IF
end event

type pb_4 from picturebutton within w_fa_co_pak_pase_fact
integer x = 2249
integer y = 1356
integer width = 389
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Retornar"
end type

event clicked;parent.Triggerevent("ue_pasarow")
end event

type dw_6 from datawindow within w_fa_co_pak_pase_fact
integer x = 91
integer y = 1824
integer width = 2258
integer height = 92
integer taborder = 110
boolean bringtotop = true
string dataobject = "dw_man_fa_exist"
boolean border = false
boolean livescroll = true
end type

type dw_4 from datawindow within w_fa_co_pak_pase_fact
event ue_key pbm_dwnkey
event ue_postkey ( )
integer x = 78
integer y = 1244
integer width = 2057
integer height = 348
integer taborder = 130
string dataobject = "dw_ma_fa_dempaq"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;idw_cual = this
pb_4.enabled = true
pb_3.enabled = false
ii_clicked = row





end event

event itemfocuschanged;//
//string ls_coditem, ls_bodega, ls_ubicacion
//long  ll_linea
//
//If this.Rowcount() > 0 then
//
////ls_coditem = This.Getitemstring(row,"fadpedid_dped_codigo_item")
////ls_bodega = This.Getitemstring(row,"fadpedid_dped_bodega")
////ls_ubicacion = This.Getitemstring(row,"fadpedid_dped_ubicacion")
////
////If dw_6.Retrieve(str.g_financiero,str.empresa,ls_coditem,ls_bodega,ls_ubicacion) <> 1 then return
//
////wf_caldisp(ls_coditem,ls_bodega,ls_ubicacion)
//
//End If
//
//
//
end event

event editchanged;//long 	ll_pasado, ll_unimin, ll_vendido, &
//		ll_totvenpas, ll_linea, ll_row, ll_cont
//string 	ls_coditem, ls_bodega, ls_ubicacion, ls_uni, &
//			ls_coditem2, ls_bodega2, ls_ubicacion2, ls_nomcolumna
//
//ll_row = this.Rowcount()
//ls_nomcolumna = this.GetColumnName()
//If ll_row  < 0  then return
//
//CHOOSE CASE ls_nomcolumna
//	CASE "c_cant_pas"
//		il_cantidad = long(this.GetText())
//		il_fraccion = This.GetitemNumber(row,"c_cant_frac")
//	CASE "c_cant_frac"
//		il_fraccion = long(this.GetText())
//		il_cantidad = This.GetitemNumber(row,"c_cant_pas")
//END CHOOSE
//
//
//ls_uni = This.GetitemString(row,"fadpedid_dped_unidad_venta")
//ll_pasado = This.GetitemNumber(row,"fadpedid_dped_pasada")
//ll_vendido = This.GetitemNumber(row,"c_por_pasar")
//
//
//ll_totvenpas = ll_vendido - ll_pasado
//
//ll_unimin = gf_fa_convertmin( ls_uni , il_cantidad , il_fraccion )
//If  ll_unimin  <= ll_totvenpas then
//	this.SetItem(row,"c_a_pasar",ll_unimin)
//	
//Else
//	Mensaje("ADVERTENCIA","Cantidad sobrepasada","")
//	this.SetItem(row,"c_a_pasar",ll_unimin)
//	If ls_nomcolumna = "c_cant_pas" then
//		this.SetItem(row,"c_cant_pas",This.GetitemNumber(Row,"c_cant_pas",Primary!,true))
//	ElseIf ls_nomcolumna = "c_cant_frac" then
//		this.SetITem(row,"c_cant_frac",This.GetitemNumber(Row,"c_cant_frac",Primary!,true))
//	End If
//	ll_unimin = gf_fa_convertmin( ls_uni ,This.GetitemNumber(Row,"c_cant_pas",Primary!,true),&
//					This.GetitemNumber(Row,"c_cant_frac",Primary!,true))
//	this.SetItem(row,"c_a_pasar",ll_unimin)
//End IF
end event

type gb_4 from groupbox within w_fa_co_pak_pase_fact
integer x = 32
integer y = 1180
integer width = 2715
integer height = 444
integer taborder = 120
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 74481808
string text = "Pasar"
end type

type gb_2 from groupbox within w_fa_co_pak_pase_fact
integer x = 69
integer y = 528
integer width = 2199
integer height = 172
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
string text = "Busquedas"
borderstyle borderstyle = styleraised!
end type

type rb_3 from radiobutton within w_fa_co_pak_pase_fact
event clicked pbm_bnclicked
integer x = 105
integer y = 588
integer width = 526
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 77107328
string text = "Lista de Empaque"
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")


end event

type pb_2 from picturebutton within w_fa_co_pak_pase_fact
integer x = 2386
integer y = 556
integer width = 242
integer height = 124
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
vtextalign vtextalign = multiline!
end type

event clicked;
parent.TriggerEvent("ue_pase")
end event

type rb_1 from radiobutton within w_fa_co_pak_pase_fact
integer x = 1001
integer y = 588
integer width = 251
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
string text = "Pasado"
boolean lefttext = true
end type

type dw_7 from datawindow within w_fa_co_pak_pase_fact
boolean visible = false
integer x = 27
integer y = 468
integer width = 1417
integer height = 572
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ma_fa_dempaq_resumido"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_fa_co_pak_pase_fact
integer x = 2185
integer y = 20
integer width = 178
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 74481808
string text = "Año:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_ann from editmask within w_fa_co_pak_pase_fact
integer x = 2377
integer width = 233
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
string mask = "###0"
boolean spin = true
double increment = 1
string minmax = "2000~~3000"
end type

event modified;ii_ann = integer(this.text)
end event

type gb_5 from groupbox within w_fa_co_pak_pase_fact
integer x = 32
integer y = 52
integer width = 2715
integer height = 668
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
end type

