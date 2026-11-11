//objectcomments Ventana de PAse de Pedido a Factura
forward
global type w_fa_co_ped_pasa_fact from w_fa_padre_reportes
end type
type gb_3 from groupbox within w_fa_co_ped_pasa_fact
end type
type rb_1 from radiobutton within w_fa_co_ped_pasa_fact
end type
type rb_2 from radiobutton within w_fa_co_ped_pasa_fact
end type
type dw_2 from datawindow within w_fa_co_ped_pasa_fact
end type
type rb_4 from radiobutton within w_fa_co_ped_pasa_fact
end type
type rb_5 from radiobutton within w_fa_co_ped_pasa_fact
end type
type rb_6 from radiobutton within w_fa_co_ped_pasa_fact
end type
type pb_1 from picturebutton within w_fa_co_ped_pasa_fact
end type
type em_1 from editmask within w_fa_co_ped_pasa_fact
end type
type em_2 from editmask within w_fa_co_ped_pasa_fact
end type
type st_2 from statictext within w_fa_co_ped_pasa_fact
end type
type st_3 from statictext within w_fa_co_ped_pasa_fact
end type
type dw_3 from datawindow within w_fa_co_ped_pasa_fact
end type
type pb_2 from picturebutton within w_fa_co_ped_pasa_fact
end type
type pb_3 from picturebutton within w_fa_co_ped_pasa_fact
end type
type dw_5 from datawindow within w_fa_co_ped_pasa_fact
end type
type pb_4 from picturebutton within w_fa_co_ped_pasa_fact
end type
type dw_6 from datawindow within w_fa_co_ped_pasa_fact
end type
type rb_7 from radiobutton within w_fa_co_ped_pasa_fact
end type
type gb_2 from groupbox within w_fa_co_ped_pasa_fact
end type
type rb_3 from radiobutton within w_fa_co_ped_pasa_fact
end type
type cb_1 from commandbutton within w_fa_co_ped_pasa_fact
end type
type cb_2 from commandbutton within w_fa_co_ped_pasa_fact
end type
type cb_3 from commandbutton within w_fa_co_ped_pasa_fact
end type
type dw_4 from datawindow within w_fa_co_ped_pasa_fact
end type
type cb_pedi_sala from commandbutton within w_fa_co_ped_pasa_fact
end type
end forward

global type w_fa_co_ped_pasa_fact from w_fa_padre_reportes
integer x = 503
integer y = 400
integer width = 2921
integer height = 1788
string title = "(FA) Pase de Pedidos a Facturas"
string menuname = ""
boolean controlmenu = false
windowtype windowtype = child!
long backcolor = 77107328
event ue_pasarow ( )
event ue_pase ( )
gb_3 gb_3
rb_1 rb_1
rb_2 rb_2
dw_2 dw_2
rb_4 rb_4
rb_5 rb_5
rb_6 rb_6
pb_1 pb_1
em_1 em_1
em_2 em_2
st_2 st_2
st_3 st_3
dw_3 dw_3
pb_2 pb_2
pb_3 pb_3
dw_5 dw_5
pb_4 pb_4
dw_6 dw_6
rb_7 rb_7
gb_2 gb_2
rb_3 rb_3
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
dw_4 dw_4
cb_pedi_sala cb_pedi_sala
end type
global w_fa_co_ped_pasa_fact w_fa_co_ped_pasa_fact

type variables
Datawindow idw_cual
Datawindowchild idw_child_uni , idch_cliente
integer ii_clicked, ii_cont = 0, ii_cualevent = 1, ii_ultgetrow, &
            ii_escpri = 1
long il_LastClickedRow, il_arrayrows[], il_cantidad
Double id_fraccion

boolean ib_action_on_buttonup, ib_tipoclicked = false, ib_flag = false
string is_user

//str_desglose	istr_parm
uo_ds_desglose	iuo_desglose, iuo_desg_a_pasar
end variables

forward prototypes
public subroutine wf_fecha ()
public subroutine wf_nofecha ()
public function string wf_verificar (string ls_original)
public function integer wf_shift_highlight (integer al_aclickedrow)
public subroutine wf_botones ()
public subroutine wf_cambuni ()
public subroutine wf_profident (string as_coditem, string as_codbodega, string as_ubicacion)
public subroutine wf_caldisp (readonly string as_coditem, readonly string as_bodega, readonly string as_ubicacion)
public subroutine wf_setear_user (string as_user)
public subroutine wf_ds_retrieve ()
public subroutine wf_convert_cant (string as_unidad, double al_cantidad, integer ai_row)
public subroutine wf_convert_uni (string as_med, double al_fracciones, ref long al_cantidad, ref long al_fraccion)
public subroutine wf_pasa_desglose (integer ai_index, string ac_opcion)
public subroutine wf_config_cant (long row)
public subroutine wf_set_lineas ()
public subroutine wf_cant_apasar ()
public function string wf_armar_sql (string ls_vienede)
public subroutine wf_efectuar_pase ()
end prototypes

event ue_pasarow;integer li_i, li_rows
long ll_c, ll_anno, ll_linea, ll_i
string ls_pedid,ls_cod_item

CHOOSE CASE idw_cual
	CASE dw_1
				dw_3.RowsMove(1,dw_3.RowCount(),Primary!,dw_4,1000,Primary!)
//				iuo_desglose.RowsCopy (1, iuo_desglose.RowCount() , Primary!, iuo_desg_a_pasar, &
//						  					  iuo_desg_a_pasar.RowCount() + 1, Primary!)
				dw_4.Object.c_cant_pas.protect = 0
				dw_4.Object.c_cant_frac.protect = 0	
				If dw_4.rowcount() > 0 then 
					pb_2.enabled = true
					//wf_ds_retrieve ()		// Desglose
				End If
				
	CASE dw_3
				For li_i = 1 to dw_3.RowCount()
					If dw_3.IsSelected(li_i) then
						wf_pasa_desglose (li_i, 'A')
						idw_cual.RowsMove(li_i,li_i,Primary!,dw_4,1000,Primary!)
					End IF		
				Next

				dw_4.Object.c_cant_pas.protect = 0
				dw_4.Object.c_cant_frac.protect = 0
				If dw_4.rowcount() > 0 then 
					pb_2.enabled = true
					//wf_ds_retrieve ()		// Desglose
				End If
	CASE dw_4
				li_rows = dw_1.RowCount()
				For ll_c = 1 to dw_4.RowCount()
					
					If dw_4.IsSelected(ll_c) Then
					wf_pasa_desglose (ll_c, 'B')

					ls_pedid = dw_4.getItemString(ll_c,"fadpedid_dped_no_pedido")
					ll_anno = dw_4.getItemNumber(ll_c,"fadpedid_dped_ann")
						
					For li_i = 1 to li_rows
						
					If dw_1.IsSelected(li_i) Then
						If dw_1.Getitemstring(li_i,"fatpedid_pedi_no_pedido") = ls_pedid AND &
							dw_1.Getitemnumber(li_i,"fatpedid_pedi_ann") = ll_anno Then
							dw_4.RowsDiscard(ll_c,ll_c,Primary!)
							dw_3.Setredraw(false)
							dw_3.Retrieve(str.g_financiero,str.empresa,ls_pedid,ll_anno)
							wf_cant_apasar()
							dw_3.Setredraw(true)
						Else
							dw_4.RowsDiscard(ll_c,ll_c,Primary!)
						End IF
					End If
					Next
					End If
				Next		
END CHOOSE
end event

event ue_pase;//wf_efectuar_pase()
wf_efectuar_pase()
end event

public subroutine wf_fecha ();dw_2.visible = false
em_1.visible = True
em_1.text = string(gf_fecha_serv())
em_2.visible = True
em_2.text = string(today())
pb_1.visible = True
st_2.visible = True
st_3.visible = True
em_1.setfocus()

end subroutine

public subroutine wf_nofecha ();dw_2.visible = True
em_1.visible = false
em_2.visible = false
pb_1.visible = false
st_2.visible = false
st_3.visible = false
dw_2.setfocus()
dw_2.SetColumn("texto")
end subroutine

public function string wf_verificar (string ls_original);//Funcion que verifica los parámetros y arma el SQL
string ls_where

//  if w_fa_fondo.str_para.mostrar <> 0 then  //mostrar un Año específico

//	CHOOSE CASE w_fa_fondo.str_para.desde	//Si es desde el año en adelante o el año exclusivo.

//		CASE 0

		 ls_where = ls_original + " and  &
					 ( fatprofo.prof_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatprofo.prof_empresa = "+string(str.empresa)+" ) and &
					 (fatprofo.prof_ann = "+string(w_fa_fondo.str_para.mostrar)+")"
//		CASE 1
//		 ls_where = ls_original + " and  &
//					 ( fatprofo.prof_g_financiero = "+string(str.g_financiero)+" ) AND &
//					 ( fatprofo.prof_empresa = "+string(str.empresa)+" ) and &
//					 (fatprofo.prof_ann >= "+string(w_fa_fondo.str_para.mostrar)+")"			
//	END CHOOSE			
	
//  else
//		 ls_where = ls_original + " and  &
//					 ( fatprofo.prof_g_financiero = "+string(str.g_financiero)+" ) AND &
//					 ( fatprofo.prof_empresa = "+string(str.empresa)+" )"
//  end if

  return(ls_where)
end function

public function integer wf_shift_highlight (integer al_aclickedrow);integer	li_Idx

//file manager functionality ... turn off all rows then select new range
dw_3.setredraw(false)
dw_3.selectrow(0,false)

If il_lastclickedrow = 0 then
//	dw_highlight.SelectRow(al_aclickedrow,TRUE)
	dw_3.setredraw(true)
	Return 1
end if


//selection moving backward
if il_lastclickedrow > al_aclickedrow then
	For li_Idx = il_lastclickedrow to al_aclickedrow STEP -1
		ii_cont++
		DW_3.selectrow(li_Idx,TRUE)	
		il_arrayrows[ii_cont] = li_idx
	end for	
else
//selection moving forward
	For li_Idx = il_lastclickedrow to al_aclickedrow 
		ii_cont++
		DW_3.selectrow(li_Idx,TRUE)	
		il_arrayrows[ii_cont] = li_idx	
	next	
end if

dw_3.setredraw(true)
Return 1

end function

public subroutine wf_botones ();//// Deshabilita algunas Opciones del Menú 

//   /*Insertar*/
//	m_fa_principal.m_edicin.m_insertar.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_insertar.visible=false
	
//	/*Adicionar*/
//	m_fa_principal.m_edicin.m_adicionar.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_adicionar.visible=false
	
//	/*Filtrar*/
//	m_fa_principal.m_edicin.m_filtrar.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_filtrar.visible=false
	
//	/*Sortear*/
//	m_fa_principal.m_edicin.m_sortear.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_sortear.visible=false
	
//	/*Primer Reg*/
//	m_fa_principal.m_edicin.m_primerregistro.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_primerregistro.visible=false
	
//	/*Ultimo Reg*/
//	m_fa_principal.m_edicin.m_ultimoregistro.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_ultimoregistro.visible=false
	
//	/*Sig Reg*/
//	m_fa_principal.m_edicin.m_siguienteregistro.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_siguienteregistro.visible=false
	

//  /*Reg Ant*/
//	m_fa_principal.m_edicin.m_registroanterior.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_registroanterior.visible=false

//  /*Imprimir*/
//   m_fa_principal.m_archivo.m_imprimir.toolbaritemvisible=false
//	m_fa_principal.m_archivo.m_imprimir.visible=false
	
//	/*Eliminar*/
//	m_fa_principal.m_edicin.m_eliminar.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_eliminar.visible=false

end subroutine

public subroutine wf_cambuni ();	//	 /*Función que hace el cambio de unidad para la banda de disponibles*/
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

public subroutine wf_profident (string as_coditem, string as_codbodega, string as_ubicacion);
string ls_no_proforma, ls_no_prof, ls_coditem, ls_bodega, ls_ubicacion
integer li_cont, li_cuenta = 0

For li_cont = 1 to dw_4.RowCount() 
	 
//	 	ls_no_proforma = dw_6.GetItemString(li_cont,"dpro_no_proforma")
   
		ls_coditem = dw_4.Getitemstring(li_cont,"fadpedid_dped_codigo_item")
		ls_bodega = dw_4.Getitemstring(li_cont,"fadpedid_dped_bodega")
		ls_ubicacion = dw_4.Getitemstring(li_cont,"fadpedid_dped_ubicacion")
//		ll_linea = This.GetItemNumber(li_cont,"dpro_linea")
		
		IF as_coditem = ls_coditem  and &
				as_codbodega = ls_bodega and &
					as_ubicacion = ls_ubicacion THEN	
					
//		If ls_no_proforma = ls_no_prof then

		  	DO
				li_cuenta++
				ls_no_prof = dw_1.GetItemString(li_cuenta,"fatpedid_pedi_no_pedido")
				If ls_no_proforma = ls_no_prof Then
					dw_1.RowsCopy(li_cuenta,li_cuenta,Primary!,dw,1,Primary!)
				End If
			LOOP UNTIL (ls_no_proforma = ls_no_prof) Or (li_cuenta = dw_1.RowCount() )
			li_cuenta = 0
		End If

Next
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
		
       SELECT isnull(inamedid.medi_cantidad,1)
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

public subroutine wf_setear_user (string as_user);//se asigna el usuario desde la ventana de clave con Dynamic
is_user = as_user
end subroutine

public subroutine wf_ds_retrieve ();Double	ld_cantidad
Integer	li_ann, li_i, li_fila 
Long		ll_row, ll_pos, ll_max, ll_cantidad
String	ls_pedido, ls_unidad



ll_row    = dw_1.GetRow()
ls_pedido = dw_1.GetItemString (ll_row, 'fatpedid_pedi_no_pedido')
li_ann	 = dw_1.GetItemNumber (ll_row, 'fatpedid_pedi_ann')

iuo_desglose.Retrieve (str.empresa, str.empresa, ls_pedido, li_ann)

/********************************************************************************* 
	Convirtiendo cantidad en Entero|Fracción
 *********************************************************************************/
// Colocando la unidad de venta en el DataStore de Desglose
ll_max = iuo_desglose.RowCount() + 1
For li_i = 1 To dw_3.RowCount ()
	li_fila	 = dw_3.GetItemNumber (li_i, "fadpedid_dped_linea")
	ls_unidad = dw_3.GetItemString (li_i, "fadpedid_dped_unidad_venta")
	ll_pos 	 = iuo_desglose.Find ('dcpe_linea = ' + string (li_fila), 1, ll_max)
	Do While (ll_pos > 0)
		iuo_desglose.SetItem (ll_pos, 'unidad_venta', ls_unidad)
		ll_pos ++
		ll_pos 	 = iuo_desglose.Find ('dcpe_linea = ' + string (li_fila), ll_pos, ll_max)
//MessageBox ('RETRIEVE'+string (ll_pos) + ' '+string (li_i),string(iuo_desglose.RowCount()))
	Loop
Next

// Entero|Fracción
For li_i = 1 To iuo_desglose.RowCount()
	ls_unidad 	= iuo_desglose.GetItemString (li_i, 'unidad_venta')
	ld_cantidad = iuo_desglose.GetItemNumber (li_i, 'dcpe_cantidad')
//	wf_convert_cant (ls_unidad, ld_cantidad, li_i)
//	gf_conv_cantidad (ll_cantidad, ld_cantidad, 'A', ls_unidad)
	gf_fa_convert_cant (ll_cantidad, ld_cantidad, 'A', ls_unidad)
	iuo_desglose.SetItem (li_i, 'cantidad', long (ll_cantidad))
	iuo_desglose.SetItem (li_i, 'fraccion', long (ld_cantidad))
Next

end subroutine

public subroutine wf_convert_cant (string as_unidad, double al_cantidad, integer ai_row);//Para mostrar lo Asignado y lo disponible en Cantidad Fraccion

Long  ll_cant_asig=0, ll_frac_asig=0, ll_cant_disp=0, ll_frac_disp=0
	
wf_convert_uni(as_unidad,al_cantidad,ll_cant_asig, ll_frac_asig) //Conv. la Cantidad
//istr_parm.ds.Setitem(ai_row,"cantidad",ll_cant_asig)	
//istr_parm.ds.Setitem(ai_row,"fraccion",ll_frac_asig)	
//
end subroutine

public subroutine wf_convert_uni (string as_med, double al_fracciones, ref long al_cantidad, ref long al_fraccion);/*Esta Función Convierte de Unidad Minima a la Unidad que se Quiere*/
//Llamada desde: ue_postitem, retrieveend del dw2

long ll_total,ll_ucom, ll_mconvera,ll_frac

 
/*Extrae la Unidad comun "Pedo/Unidades/etc "*/
ll_ucom = gf_medi_prod(as_med)


/*Retorna el Factor de Converción a unidades minimas*/
ll_mconvera = gf_unidad_venta(as_med, ll_ucom)


If ll_mconvera <= 0 Then ll_mconvera = 1

ll_total = ( al_fracciones / ll_mconvera) 

ll_frac = (Mod(al_fracciones, ll_mconvera))
////messagebox("1",ld_frac)
//ld_frac = ld_frac*ld_mconvera
//messagebox("2",ld_frac)
//If ld_frac > ld_mconvera Then ld_frac = ld_frac /100

al_cantidad = Long(ll_total)
al_fraccion = ll_frac
end subroutine

public subroutine wf_pasa_desglose (integer ai_index, string ac_opcion);/*
	Pasa las filas del DataStore iuo_desglose al iuo_desg_a_pasar
	Desglose asociado con las lineas pasadas.
	
	ai_index		No. Renglón de Detalle
	ac_opcion	Opción,  A - Pasar, de dw_3 a dw_4
				   			B - Regresar, de dw_4 a dw_3
*/

Integer		li_linea, li_anno
String		ls_filtro, ls_pedido

// Pasando el Desglose asociado a la línea
If ac_opcion = 'A' Then
	li_linea  = dw_3.GetItemNumber (ai_index, 'fadpedid_dped_linea')
	ls_filtro = 'dcpe_linea = ' + string (li_linea)

	iuo_desglose.SetFilter (ls_filtro)
	iuo_desglose.Filter ()

	iuo_desglose.RowsCopy (1, iuo_desglose.RowCount() , Primary!, iuo_desg_a_pasar, &
							  iuo_desg_a_pasar.RowCount() + 1, Primary!)

	iuo_desglose.SetFilter ('')
	iuo_desglose.Filter ()

// Regresando el Desglose pasado
ElseIf ac_opcion = 'B' Then
	li_linea  = dw_4.GetItemNumber (ai_index, 'fadpedid_dped_linea')
	ls_pedido = dw_4.GetItemString (ai_index, 'fadpedid_dped_no_pedido')
	li_anno	 = dw_4.GetItemNumber (ai_index, 'fadpedid_dped_ann')
	ls_filtro = 'dcpe_linea = ' + string (li_linea) + ' And dcpe_anno = ' + string (li_anno)+&
					' And dcpe_no_pedido = "' + ls_pedido + '"'
	
	iuo_desg_a_pasar.SetFilter (ls_filtro)
	iuo_desg_a_pasar.Filter ()
	
	iuo_desg_a_pasar.RowsDiscard (1, iuo_desg_a_pasar.RowCount() , Primary!)

	iuo_desg_a_pasar.SetFilter ('')
	iuo_desg_a_pasar.Filter ()
End If

end subroutine

public subroutine wf_config_cant (long row);/*
	Configuración de Cantidades
	----------------------------
	20/mayo/99
*/
Integer			li_anno
double			ld_fraccion
Long				ll_entero, ll_linea
String			ls_bodega, ls_ubic, ls_producto, ls_pedido, ls_unidad
str_desglose	lstr_parm

ls_bodega 	= dw_4.GetItemString (row, 'fadpedid_dped_bodega')
ls_ubic   	= dw_4.GetItemString (row, 'fadpedid_dped_ubicacion')
ls_producto	= dw_4.GetItemString (row, 'fadpedid_dped_codigo_item')
ls_pedido	= dw_4.GetItemString (row, 'fadpedid_dped_no_pedido')
li_anno		= dw_4.GetItemnumber (row, 'fadpedid_dped_ann')
ls_unidad	= dw_4.GetItemString (row, 'fadpedid_dped_unidad_venta')
ll_entero	= dw_4.GetItemnumber (row, 'c_cant_pas')
ld_fraccion = dw_4.GetItemnumber (row, 'c_cant_frac')
ll_linea		= dw_4.GetItemNumber (row, 'fadpedid_dped_linea')

//messagebox ('antes '+ls_unidad, string(ll_entero)+ ' '+string(ld_fraccion))
ld_fraccion = gf_fa_convert_cant (ll_entero, ld_fraccion, 'C', ls_unidad)
//messagebox ('antes '+ls_unidad, string(ll_entero)+ ' '+string(ld_fraccion))
lstr_parm.ds			= iuo_desg_a_pasar
lstr_parm.filtro 		= 'dcpe_linea = ' + string (ll_linea) + ' And dcpe_anno = ' +&
								string (li_anno) + ' And dcpe_no_pedido = "' + ls_pedido + '"'
lstr_parm.anno			= li_anno
lstr_parm.cadena [2] = ls_pedido
lstr_parm.cadena [3] = ls_bodega
lstr_parm.cadena [4] = ls_ubic
lstr_parm.cadena [5] = ls_producto
lstr_parm.cantidad	= dec (ld_fraccion)

OpenWithParm (w_fa_co_ped_pasa_fact_desg, lstr_parm)
end subroutine

public subroutine wf_set_lineas ();// wf_set_lineas
// Setea el No. de Línea de los renglones del DataStore para que conserven relación con
// los de Detalle
//

Integer	li_anno
Long		ll_linea, ll_i, ll_pos
String	ls_pedido

// fadpedid_dped_no_pedido  fadpedid_dped_ann  fadpedid_dped_linea 
//  dcpe_no_pedido  dcpe_linea  dcpe_anno 
  
For ll_i = 1 To iuo_desg_a_pasar.RowCount ()
	
	ll_linea  = iuo_desg_a_pasar.GetItemnumber (ll_i, 'dcpe_linea')
	ls_pedido = iuo_desg_a_pasar.GetItemString (ll_i, 'dcpe_no_pedido')
	li_anno	 = iuo_desg_a_pasar.GetItemnumber (ll_i, 'dcpe_anno')
	
	ll_pos = dw_4.Find ("fadpedid_dped_no_pedido = '" + ls_pedido + "' And fadpedid_dped_linea = " +&
						 		string (ll_linea) + " And fadpedid_dped_ann = " + string (li_anno), &
								1, dw_4.RowCount ())
	If ll_pos > 0 Then
		iuo_desg_a_pasar.SetItem (ll_i, "linea_nueva", ll_pos)
	Else
		Mensaje ("Error", "Error al configurar los números de líneas. Si el error persiste" +&
					" contacte su proveedor", "")
	End If
Next

end subroutine

public subroutine wf_cant_apasar ();Long 		ll_pasado, ll_unimin, ll_vendido, &
			ll_totvenpas, ll_linea, ll_row, ll_cont, ll_i,ll_cantidad,ll_fraccion
String 	ls_coditem, ls_bodega, ls_ubicacion, ls_uni, &
			ls_coditem2, ls_bodega2, ls_ubicacion2, ls_nomcolumna

ll_row = dw_3.Rowcount()
ls_nomcolumna = dw_3.GetColumnName()
If ll_row  < 0  then return

For ll_i = 1 to ll_row

//ls_coditem 	 = dw_3.Getitemstring(ll_i,"fadpedid_dped_codigo_item")
//ls_bodega 	 = dw_3.Getitemstring(ll_i,"fadpedid_dped_bodega")
//ls_ubicacion = dw_3.Getitemstring(ll_i,"fadpedid_dped_ubicacion")
//ll_pasado 	 = dw_3.GetitemNumber(ll_i,"fadpedid_dped_pasada")
//ll_vendido = dw_3.GetitemNumber(ll_i,"c_por_pasar")
ls_uni 		 = dw_3.GetitemString(ll_i,"fadpedid_dped_unidad_venta")
ll_cantidad  = dw_3.GetitemNumber(ll_i,"c_cant_pas")
ll_fraccion  = dw_3.GetitemNumber(ll_i,"c_cant_frac")

ll_unimin = 0
gf_fa_convertmin_new( ll_unimin ,ls_uni , ll_cantidad , ll_fraccion)

//If ll_unimin > ll_pasado then

dw_3.SetItem(ll_i,"c_a_pasar",ll_unimin)
//ElseIf ll_pasado > ll_unimin then

//	dw_3.SetItem(ll_i,"c_a_pasar",ll_unimin)
//End If
Next
end subroutine

public function string wf_armar_sql (string ls_vienede);// Función que arma el Sql de el DataWindow, y dependiendo de donde se llama, profura o consultas
// Filtra segun parámetros iniciales o no

string ls_where, ls_original

ls_original = dw_1.GetsqlSelect()

if ls_vienede = "Proforma" then

   ls_where = wf_verificar(ls_original)
	
else		//Si es llamado de consultas
	
//	if w_fa_fondo.str_para.afecta_consulta = 1 then		//Si los parámetros afectan consulta
	
//	   ls_where = wf_verificar(ls_original)		
		
//	else
		
		 ls_where = ls_original + " and  &
					 ( fatprofo.prof_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatprofo.prof_empresa = "+string(str.empresa)+" )"						 
//	end if				 
end if


return(ls_where)
end function

public subroutine wf_efectuar_pase ();long 		ll_cant_a_pasar, ll_fraccion_a_pasar, ll_cant_pasada,ll_convert, &
			ll_unidades_a_pasar, ll_vendido, ll_unidades_disponibles, ll_cont, ll_no_prof, &
			ll_cargo,ll_vendedor,ll_tot_bultos,&
			ll_existe,ll_cliente, ll_reservado, ll_frac_reservada,ll_cantidad, ll_index, &
			ll_bulto_inicio, ll_bulto_fin,ll_annio
			
string 	ls_item,ls_uni,ls_num_sec,ls_ruc_cli,ls_condi_pag,ls_tipomov,ls_consigna,ls_anombre,&
			ls_direccion,ls_despachado,ls_via,ls_no_emb,ls_marca,ls_unidpeso,ls_decu_subt_det, &  
			ls_supervi,ls_comentario,ls_estado,ls_prod_serv,ls_cod_item,ls_desc_alter,ls_uni_peso, &
			ls_uni_prod,ls_bodega,ls_uni_venta,ls_usuario,ls_supervisor,ls_ubicacion,ls_pedido,&
			ls_no_pedido, ls_pedi,ls_autorizacion,ls_tipo,ls_pormay, ls_error, ls_ped_pedido, &
			ls_no_conocimiento,ls_factura_de_bodega, ls_user,ls_guia, ls_destino, ls_origen
			
decimal	ld_montototal,ld_monto_final,ld_precio_my,ld_precio_mn,ld_costo_fob,ld_costo_cif, &  
         ld_precio_uni,ld_monto_tot,ld_monto_fin,ld_monto,ld_tot_montotot,ld_tot_montofin, &
			ld_tot_gastostot,ld_final,ld_monto_tot_pas,ld_total_pas,ld_precio,ld_convert,ld_cubicaje,&
			ld_pesototal,ld_gastostot,ld_peso,ld_tot_peso,ld_tot_cubicaje, ld_precio_original, &
			ld_costos_totales, ld_costo_total, ld_precio2, ld_fact_costo_total, ld_costo_uni,&
			ld_precio_descuento,ld_precio_descuento_uni,ld_descuento_ncr

integer 	li_tipovent,li_numtraspa,li_dias_pago,li_bultostotal,&
			li_por_descuento,li_linea,li_fraccion, li_vendedor, &
			li_por_desc,li_bultos,li_pasada,li_i,li_c,li_error, li_anio, &
			li_viene_de_pedido, li_precio_a_utilizar, li_cuatro_dec, li_ann, li_ped_vta_diaria	
						
dateTime ldt_fecha_pedido,ldt_fecha_crea,ldt_fecha_mod,ldt_fecha_reg,ldt_fecha_serv, ldt_fecha_fin_plazo 



Boolean	lb_pedido_unico, lb_entro
str_pasefact	lstr_pase_ff,lstr_pase_f
			  
ldt_fecha_serv	= gf_fecha_serv()  
ll_annio = Long(Year(Date(ldt_fecha_serv)))
If dw_4.Rowcount() < 1  then
	Mensaje("AVISO","No hay pedidos para efectuar el Pase A Factura","")
	return
End IF

dw_4.AcceptText()

lb_pedido_unico = True

For ll_cont = 1 to dw_4.Rowcount()
	
		ls_item 		= dw_4.Getitemstring(ll_cont,"fadpedid_dped_codigo_item")
		ls_uni 		= dw_4.GetitemString(ll_cont,"fadpedid_dped_unidad_venta")
		ll_cant_a_pasar 		= dw_4.GetitemNumber(ll_cont,"c_cant_pas")	// Cantidad a pasar
		ll_fraccion_a_pasar  = dw_4.GetitemNumber(ll_cont,"c_cant_frac")	// Fraccion a pasar
		ll_cant_pasada 		= dw_4.GetitemNumber(ll_cont,"fadpedid_dped_pasada") // lo que ya se paso
		ll_vendido 	= dw_4.GetitemNumber(ll_cont,"c_por_pasar")

	If ll_cant_a_pasar = 0 and ll_fraccion_a_pasar = 0 then
		Mensaje("AVISO","La Cantidad y la Fraccion no pueden estar en Cero (0)",&
				  "Verifique en el Codigo de Item "+ ls_item +"")
		dw_4.SelectRow(0,FALSE)
		dw_4.SelectRow(ll_cont,TRUE)
		return
	Else
		// Total de unidades a pasar
		gf_fa_convertmin_new(ll_unidades_a_pasar, ls_uni , ll_cant_a_pasar , ll_fraccion_a_pasar )
		
		//Total unidades reservadas
		//ES LO QUE ESTÁ EN c_por_pasar

		ll_unidades_disponibles = ll_vendido - ll_cant_pasada

		If ll_unidades_a_pasar   <= ll_unidades_disponibles then
			dw_4.SetItem(ll_cont,"fadpedid_dped_pasada",ll_unidades_a_pasar + ll_cant_pasada)
		Else
			Mensaje("ADVERTENCIA","Cantidad sobrepasa, lo disponible","")
			Return
		
		End IF
	End If
Next


 Open(w_fa_man_selecpedido)

If IsValid (message.PowerObjectParm) then

	//ls_no_pedido = string(message.Doubleparm)
	lstr_pase_f = message.PowerObjectParm
	ls_no_pedido = lstr_pase_f.numped		// pedido seleccionado
	//si se dio cancelar en la seleccion del pedido	
	if ls_no_pedido = '0' then
		For li_c = 1 to dw_4.RowCount()
			dw_4.SetItem(li_c,"fadpedid_dped_pasada",0)
		next
		rollback using sqlca;
		Return		
	end if
	
	
	OpenWithParm(w_fa_man_secfact,lstr_pase_f)
	
	lstr_pase_ff = message.PowerObjectParm
	
	If lstr_pase_ff.numped <> "0" then
					
		ls_num_sec = lstr_pase_ff.numped	//Secuencia nueva disponible
	
		For li_i = 1 to dw_1.RowCount()
			if dw_1.getitemnumber(li_i, "pedi_pedido_vta_diaria") = 1 then
				li_ped_vta_diaria = 1
			end if
			
			If dw_1.GetItemString(li_i,"fatpedid_pedi_no_pedido") = ls_no_pedido then
				ii_ultgetrow = li_i
			End If
		Next

		  li_ann		 		= dw_1.GetItemNumber(ii_ultgetrow,"fatpedid_pedi_ann")
		  ls_tipo= dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_tipo")

		  ll_cliente 		= dw_1.GetItemNumber(ii_ultgetrow,"fatpedid_pedi_cliente")  
		  ls_ruc_cli 		= dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_ruc_cliente")
		  ls_condi_pag 	= dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_condicion_pago")   
		  li_tipovent		= dw_1.GetItemNumber(ii_ultgetrow,"fatpedid_pedi_tipo_venta")   
		  ls_tipomov 		= dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_tipo_movimiento")   
		  li_numtraspa 	= dw_1.GetItemNumber(ii_ultgetrow,"fatpedid_pedi_no_traspaso")  
		  ldt_fecha_pedido= ldt_fecha_serv
		  ldt_fecha_crea 	= ldt_fecha_serv
		  ldt_fecha_mod 	= ldt_fecha_serv   
		  li_dias_pago 	= dw_1.GetItemNumber(ii_ultgetrow,"fatpedid_pedi_dias_pago")  
		
		  ls_anombre  		= dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_a_nombre") 
		  ls_direccion  	= dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_a_nombre_direccion") 
		  ls_despachado  	= dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_despachado")  
		  ls_consigna		= dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_consignado")  
		  ls_no_conocimiento	 =  dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_con_emb_no")  
		  ls_marca			= dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_marca")  
		  ls_via = dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_via")      
		  ls_comentario	= dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_comentario")    
		
		  ls_origen	= dw_1.GetItemString(ii_ultgetrow,"pedi_origen_venta")    
		
		  li_bultostotal 	= 0  
		  ld_cubicaje   	= 0
		  ld_pesototal 	= 0
		  ls_unidpeso 		= dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_unidad_peso")
		  ld_gastostot  	= 0
		  ld_montototal 	= 0
		  ls_decu_subt_det 	= dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_descu_subt_deta")   
		  li_por_descuento  	= dw_1.GetItemNumber(ii_ultgetrow,"fatpedid_pedi_por_descuento")
		
		  ls_estado = "A"
		  ls_autorizacion	= dw_1.GetItemString(ii_ultgetrow,"fatpedid_pedi_autorizacion")  
		  ls_factura_de_bodega = dw_1.GetItemString(ii_ultgetrow,"pedi_factura_de_bodega")  
  		  li_cuatro_dec		  = dw_1.GetItemNumber(ii_ultgetrow,"pedi_cuatro_decimales")  
		  ls_user				  = dw_1.GetItemString(ii_ultgetrow,"pedi_usuario")
		  li_precio_a_utilizar = dw_1.GetItemNumber(ii_ultgetrow,"pedi_precio_a_utilizar")  		  
		  ld_costos_totales	  = dw_1.GetItemNumber(ii_ultgetrow,"pedi_costos_total")

		  ls_guia				  = dw_1.GetItemString(ii_ultgetrow,"pedi_guia")
		  ls_destino			  = dw_1.GetItemString(ii_ultgetrow,"pedi_destino")
		  
			If  ls_autorizacion = "" OR IsNull( ls_autorizacion) Then
				dw_1.SetItem(ii_ultgetrow,"fatpedid_pedi_autorizacion",is_user)
				ls_autorizacion = is_user  
			End If
		
		  ldt_fecha_fin_plazo = gf_recupera_dias(li_dias_pago, date(ldt_fecha_pedido))
		
		 INSERT INTO fatdiari  
			( fact_g_financiero,   
			  fact_empresa,   
			  fact_tipo,   
			  fact_no_pedido,   
			  fact_ann,   
			  fact_no_factura,   
			  fact_cliente,   
			  fact_ruc_cliente,   
			  fact_condicion_pago,   
			  fact_tipo_venta,   
			  fact_tipo_movimiento,   
			  fact_no_traspaso,   
			  fact_fecha,   
			  fact_fecha_creacion,   
			  fact_fecha_modificacion,   
			  fact_dias_pago,   
			  fact_fecha_fin_plazo,   
			  fact_fecha_cancelado,   
			  fact_consignado,   
			  fact_a_nombre,   
			  fact_a_nombre_direccion,   
			  fact_despachado,   
			  fact_via,   
			  fact_con_emb_no,   
			  fact_marca,   
			  fact_bultos_total,   
			  fact_cubicaje_total,   
			  fact_peso_total,   
			  fact_unidad_peso,   
			  fact_gastos_total,   
			  fact_monto_fact_total,   
			  fact_descuento_subt_deta,   
			  fact_por_descuento,   
			  fact_supervisor,   
			  fact_monto_final,   
			  fact_comentario,   
			  fact_estado ,  
			  fact_act_cliente,   
			  fact_act_inventario,   
			  fact_act_conta,   
			  fact_cerrada,   
			  fact_referencia_fac,   
			  fact_monto_abonado,   
			  fact_fecha_act_conta,
			  fact_pedido_original,
			  fact_autorizacion,
			  fact_viene_de_pedido,
  			  fact_actualizo_cargos,
			  fact_actualizo_vendedor,			  
			  fact_factura_de_bodega,
			  fact_cuatro_decimales,
			  fact_usuario,
			  fact_precio_a_utilizar,
			  fact_costos_total,
			  fact_viene_de_ventas_diarias,fact_guia,fact_destino,
			  fact_origen_venta)    
		VALUES ( :str.g_financiero, 
			  :str.empresa,  
			  :ls_tipo,
			  :ls_num_sec,   
			  :ll_annio, //w_fa_fondo.str_para.ano,   
			  '0',
			  :ll_cliente,   
			  :ls_ruc_cli,   
			  :ls_condi_pag,   
			  :li_tipovent,   
			  :ls_tipomov,   
			  :li_numtraspa,   
			  :ldt_fecha_serv,  
			  :ldt_fecha_serv,  
			  :ldt_fecha_serv,   
			  :li_dias_pago,  
			  :ldt_fecha_fin_plazo,
			  null,
			  :ls_consigna,   
			  :ls_anombre,   
			  :ls_direccion,   
			  :ls_despachado,   
			  :ls_via,   
			  :ls_no_conocimiento,   
			  :ls_marca,   
			  :li_bultostotal,   
			  :ld_cubicaje,   
			  :ld_pesototal, 
			  :ls_unidpeso,  
			  :ld_gastostot,  
			  :ld_montototal,
			  :ls_decu_subt_det, 
			  :li_por_descuento,  
			  :ls_supervi, 
			  :ld_monto_final,   
			  :ls_comentario, 
			  :ls_estado,
			  0,
			  0,
			  0,
			  0,
			  '',
			  0,
			  null,
			  :ls_no_pedido,
			  :ls_autorizacion,
			  1,	//Indica que viene de pedido, para que en el trigger no reserve nuevamente
			  'S', /*Actualizo. Cargos*/
			  'S', /*Actualizo Vendedor*/
  			  :ls_factura_de_bodega,
			  :li_cuatro_dec,
			  :str.usuario,
			  :li_precio_a_utilizar,
			  :ld_costos_totales,
			  :li_ped_vta_diaria,
			  :ls_guia,
			  :ls_destino,
			  :ls_origen)  ;
					  
			If sqlca.sqlcode = -1 then
			  ls_error =sqlca.sqlerrtext
			  rollback using sqlca;
			  mensaje("Atención ","Error al Insertar en (Fatdiari) "+ls_error,"")
			  return
			Else				
			  //Cursor de los pedidos para la factura
			  Declare  cur_fadpedid Cursor For		
				SELECT fadpecar.peca_codigo_cargo,
						 fadpecar.peca_monto
				 FROM fadpecar  
				WHERE ( fadpecar.peca_g_financiero = :str.g_financiero ) AND  
						( fadpecar.peca_empresa = :str.empresa ) AND  
						( fadpecar.peca_no_pedido = :ls_no_pedido  ) AND  
						( fadpecar.peca_ann = :li_ann )   ;
				
/*prueba*/		//		sqlca.autocommit =false
				Open cur_fadpedid;
				
				   If sqlca.sqlcode = -1 Then
						ls_error =sqlca.sqlerrtext
						rollback using sqlca;
						Close cur_fadpedid;
/*prueba*/	//			sqlca.autocommit =true
						mensaje("ERROR","Fallo del Cursor al intentar Abrirlo "+ls_error,"")
						Return
					End If
					
					Fetch cur_fadpedid into :ll_cargo , :ld_monto;
					
					If sqlca.sqlcode = -1 Then
						ls_error =sqlca.sqlerrtext
						rollback using sqlca;
						Close cur_fadpedid;
/*prueba*/		//		sqlca.autocommit =true
						mensaje("ERROR","Fallo del Cursor al intentar obtener los Cargos "+ls_error,"")
						Return
					End If
						
				Do While sqlca.Sqlcode = 0 
					  INSERT INTO fadcargo  
								( dcar_g_financiero,   
								  dcar_empresa,   
								  dcar_tipo,   
								  dcar_no_pedido,   
								  dcar_ann,   
								  dcar_monto,   
								  dcar_codigo )  
					  VALUES ( :str.g_financiero,   
								  :str.empresa,
								  :ls_tipo,
								  :ls_num_sec,
								  :ll_annio, //w_fa_fondo.str_para.ano,   
								  :ld_monto,   
								  :ll_cargo )  ;
						If sqlca.sqlcode = -1 then
							ls_error =sqlca.sqlerrtext
							rollback using sqlca;
							Close cur_fadpedid;
/*prueba*/	//			sqlca.autocommit =true
							mensaje("Atención ","Error al Insertar los Cargos "+ls_error,"")
						  return
						End IF								  								  

						Fetch cur_fadpedid into :ll_cargo, :ld_monto ;
						If sqlca.sqlcode = -1 Then
							ls_error =sqlca.sqlerrtext
							rollback using sqlca;
							Close cur_fadpedid;
/*prueba*/		//		sqlca.autocommit =true
							mensaje("ERROR","Fallo del Cursor al intentar obtener los Cargos "+ls_error,"")
							Return
						End If												
				Loop
				
				If sqlca.sqlcode = -1 then
					ls_error =sqlca.sqlerrtext
					rollback using sqlca;
					Close cur_fadpedid;
/*prueba*/	//			sqlca.autocommit =true
					mensaje("Atención ","Error al Insertar los Cargos "+ls_error,"")
				  return
				End IF
				
				Close cur_fadpedid;  
/*prueba*/		//		sqlca.autocommit =true
						
				//Cursor para el vendedor de facturas	  
		
				Declare cur_fadvenfa cursor For		  
				  SELECT fadvenpe.vped_tipo,   
							fadvenpe.vped_vendedor  
					 FROM fadvenpe  
					WHERE ( fadvenpe.vped_g_financiero = :str.g_financiero ) AND  
							( fadvenpe.vped_empresa = :str.empresa ) AND  
							( fadvenpe.vped_no_pedido = :ls_no_pedido ) AND  
							( fadvenpe.vped_ann = :li_ann )   ;
				
				If sqlca.sqlcode = -1 Then
					ls_error =sqlca.sqlerrtext
					rollback using sqlca;
					Close cur_fadvenfa;
					mensaje("ERROR","Fallo del Select del Cursor al intentar obtener el vendedor "+ls_error,"")
					Return
				End If
						
				Open cur_fadvenfa;
				Fetch cur_fadvenfa into :ls_pormay,:ll_vendedor;
					
				If sqlca.sqlcode = -1 Then
					ls_error =sqlca.sqlerrtext
					rollback using sqlca;
					Close cur_fadvenfa;
					mensaje("ERROR","Fallo del Cursor al intentar obtener el vendedor "+ls_error,"")
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
							  :ls_tipo,
							  :ls_num_sec,   
							  :ll_annio, //w_fa_fondo.str_para.ano,   
							  :ll_vendedor )  ;
							  
					
							If sqlca.sqlcode = -1 then
								ls_error =sqlca.sqlerrtext
								rollback using sqlca;
								Close cur_fadvenfa;			
								mensaje("Atención ","Error al Insertar los Vendedores asociados al Pedido "+ls_error,"")
								return
							End IF
					
					Fetch cur_fadvenfa into :ls_pormay,:ll_vendedor; 
				Loop
							
				Close cur_fadvenfa;	  
		
				ls_pedido 	= ls_num_sec
				lb_entro = false
				For li_i = 1 to dw_4.RowCount()
					  ls_ped_pedido = dw_4.GetItemString(li_i,"fadpedid_dped_no_pedido")
					
					  If ls_ped_pedido <> ls_no_pedido Then
							lb_pedido_unico = False
					  End If					
					
					  li_anio		= dw_4.GetItemNumber(li_i,"fadpedid_dped_ann")
					  
					  li_linea 		= dw_4.GetItemNumber(li_i,"fadpedid_dped_linea")
					  ls_prod_serv = dw_4.GetItemString(li_i,"fadpedid_dped_producto_servicio") 
					  ls_cod_item  = dw_4.GetItemString(li_i,"fadpedid_dped_codigo_item") 
					  ls_desc_alter= dw_4.GetItemString(li_i,"fadpedid_dped_descripcion_alterna")
					  ld_cubicaje  = truncate(round(dw_4.GetItemNumber(li_i,"fadpedid_dped_cubicaje"),4),4)
					  ld_peso   	= truncate(round(dw_4.GetItemNumber(li_i,"fadpedid_dped_peso"),4),4)
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
					  ls_uni_peso  = dw_4.GetItemString(li_i,"fadpedid_dped_unidad_peso")
					  ls_uni_prod  = dw_4.GetItemString(li_i,"fadpedid_dped_unidad_producto")
					  ld_precio_my = dw_4.GetItemNumber(li_i,"fadpedid_dped_precio_mayor") 
					  ld_precio_mn = dw_4.GetItemNumber(li_i,"fadpedid_dped_precio_menor")
					  ls_bodega 	= dw_4.GetItemString(li_i,"fadpedid_dped_bodega")
					  ld_costo_fob = dw_4.GetItemNumber(li_i,"fadpedid_dped_costo_fob")
					  ld_costo_cif = dw_4.GetItemNumber(li_i,"fadpedid_dped_costo_cif")
					  ld_precio_uni = dw_4.GetItemNumber(li_i,"fadpedid_dped_precio_unidad_producto")
					  ls_uni_venta  = dw_4.GetItemString(li_i,"fadpedid_dped_unidad_venta")
					  ll_cantidad   = dw_4.GetItemNumber(li_i,"c_cant_pas")
					  li_fraccion   = dw_4.GetItemNumber(li_i,"c_cant_frac")
					  li_por_desc   	= dw_4.GetItemNumber(li_i,"fadpedid_dped_por_descuento")
					  
					  ld_precio_descuento = dw_4.GetItemNumber(li_i,"dped_precio_descuento")
					  ld_descuento_ncr	  = dw_4.GetItemNumber(li_i,"dped_descuento_ncr")
					  //dped_descuento_ncr
					  ldt_fecha_reg   = dw_4.GetItemdatetime(li_i,"fadpedid_dped_fecha_reg")
					  ls_usuario   	= dw_4.GetItemString(li_i,"fadpedid_dped_usuario")
					  ls_supervisor   = dw_4.GetItemString(li_i,"fadpedid_dped_supervisor")
					  li_bultos   		= dw_4.GetItemNumber(li_i,"fadpedid_dped_bultos")
					  ll_bulto_inicio	= dw_4.GetItemNumber(li_i,"dped_bulto_inicio")
					  ll_bulto_fin		= dw_4.GetItemNumber(li_i,"dped_bulto_fin")
					  ls_ubicacion  	= dw_4.GetItemString(li_i,"fadpedid_dped_ubicacion")
					  ld_precio_original	= dw_4.GetItemNumber(li_i,"dped_precio_original")	
					  ld_costo_total		= dw_4.GetItemNumber(li_i,"dped_costo_total")	
					  li_vendedor		= dw_4.GetItemNumber(li_i,"dped_vendedor")	
					  if not lb_pedido_unico then
						  ll_index ++
					  else
						  ll_index			= dw_4.GetItemNumber(li_i,"dped_index")
					  end if
					  
					  ll_unidades_a_pasar 		= dw_4.GetitemNumber(li_i,"fadpedid_dped_pasada") // lo que ya se paso
					
					  ll_convert 	= gf_unidad_venta(ls_uni_venta,gf_medi_prod(ls_uni_prod))
					  ld_precio2 	= ld_precio_original / ll_convert
					  ld_precio		= ld_precio_uni / ll_convert
					  
					  ld_precio_descuento_uni = ld_precio_descuento/ll_convert
					  
					  //Para el calculo del costo total por linea
					  ld_costo_uni   = ld_costo_cif / ll_convert	//costo minimo
					  ld_costo_total = ld_costo_uni * dw_4.GetItemNumber(li_i,"c_a_pasar") //costo total
					  
					
					 CHOOSE CASE ls_decu_subt_det
						CASE "D"
							  //Calcula el monto total de la linea de detalle
							  ld_monto_tot_pas = round(ld_precio2 * dw_4.GetItemNumber(li_i,"c_a_pasar"),2)
							  ld_monto_tot = ld_monto_tot_pas			  
							  ld_monto_tot_pas = round(ld_precio  * dw_4.GetItemNumber(li_i,"c_a_pasar"),2)
  							  ld_monto_fin =  ld_monto_tot_pas							  
  							  //Calcula el Costo total de la linea de detalle
								 
						CASE ELSE 
							  //Calcula el monto total de la linea de detalle							
							  ld_monto_tot_pas = round(ld_precio * dw_4.GetItemNumber(li_i,"c_a_pasar"),2)
							  ld_monto_tot = ld_monto_tot_pas
							  ld_monto_fin =  ld_monto_tot 
  							  //Calcula el Costo total de la linea de detalle
								 
					 END CHOOSE
					 /*Desc para Acisa*/
					 ld_descuento_ncr = round(ld_precio_descuento_uni * dw_4.GetItemNumber(li_i,"c_a_pasar"),2)
					  
					  INSERT INTO faddiari  
							( facd_g_financiero,   
							  facd_empresa,   
							  facd_tipo,   
							  facd_no_pedido,   
							  facd_pedido_original,   
							  facd_linea,   
							  facd_ann,   
							  facd_producto_servicio,   
							  facd_codigo_item,   
							  facd_descripcion_alterna,   
							  facd_cubicaje,   
							  facd_peso,   
							  facd_unidad_peso,   
							  facd_unidad_producto,   
							  facd_precio_mayor,   
							  facd_precio_menor,   
							  facd_bodega,   
							  facd_costo_fob,   
							  facd_costo_cif,   
							  facd_precio_unidad_producto,   
							  facd_unidad_venta,   
							  facd_cantidad,   
							  facd_cantidad_fraccion,   
							  facd_monto_total,   
							  facd_por_descuento,   
							  facd_monto_final,   
							  facd_fecha_reg,   
							  facd_usuario,   
							  facd_supervisor,   
							  facd_bultos,   
							  facd_pais,   
							  facd_ubicacion,   
							  facd_cant_devuelta,   
							  facd_linea_articulo_dev,
							  facd_index,
							  facd_viene_de_pedido,
							  facd_bulto_inicio,
							  facd_bulto_fin,
							  facd_precio_original,
							  facd_costo_total,
							  facd_precio_descuento,
							  facd_descuento_ncr,
							  facd_vendedor)
						VALUES (:str.g_financiero,   
								  :str.empresa,   
								  :ls_tipo,
								  :ls_pedido,
								  :ls_ped_pedido,
								  :li_i,  
								  :ll_annio, //w_fa_fondo.str_para.ano,   
								  :ls_prod_serv,   
								  :ls_cod_item,   
								  :ls_desc_alter,   
								  :ld_cubicaje,   
								  :ld_peso,   
								  :ls_uni_peso,   
								  :ls_uni_prod,   
								  :ld_precio_my,   
								  :ld_precio_mn,   
								  :ls_bodega,
								  :ld_costo_fob,   
								  :ld_costo_cif,   
								  :ld_precio_uni,   
								  :ls_uni_venta,   
								  :ll_cantidad,   
								  :li_fraccion,   
								  :ld_monto_tot,   
								  :li_por_desc,   
								  :ld_monto_fin,
								  :ldt_fecha_reg,   
								  :ls_usuario,   
								  :ls_supervisor,   
								  :li_bultos,   
								  0,
								  :ls_ubicacion,
								  0,
								  0,
								  :ll_index,
								  1, //Ya no se toma en cuenta en el trigger.
								  :ll_bulto_inicio,
								  :ll_bulto_fin,
								  :ld_precio_original,
								  :ld_costo_total,
								  :ld_precio_descuento,
								  :ld_descuento_ncr,
								  :li_vendedor);
								
								If sqlca.sqlcode <> 0 then
									ls_error =sqlca.sqlerrtext
									rollback using sqlca;
									mensaje("Error 3","Error al insertar en faddiari "+ls_error,"")
									return
								End If
							  
					 
								UPDATE fadpedid  
								  SET dped_pasada = :ll_unidades_a_pasar 
								WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
										( fadpedid.dped_empresa 	= :str.empresa ) AND  
										( fadpedid.dped_no_pedido 	= :ls_ped_pedido ) AND  
										( fadpedid.dped_ann 		=  :li_anio) AND  
										( fadpedid.dped_linea 	=  :li_linea) AND
										( fadpedid.dped_codigo_item = :ls_cod_item) ;
		
								If sqlca.sqlcode = -1 then
									ls_error =sqlca.sqlerrtext
									rollback using sqlca;
									mensaje("Ateción","Error al actualizar unidades a pasar "+ls_error,"")
									return
								End If
					Next
		End If //del If sqlca.sqlcode = -1 then
	Else	//del If lstr_pase_ff.numped <> "0" then, ES IGUAL A '0'
		For li_c = 1 to dw_4.RowCount()
			dw_4.SetItem(li_c,"fadpedid_dped_pasada",0)
		next
		rollback using sqlca;
		Return 
	End If
Else //del If IsValid (message.PowerObjectParm), no es valido
	For li_c = 1 to dw_4.RowCount()
		dw_4.SetItem(li_c,"fadpedid_dped_pasada",0)
	next
	Return
End If
//////////////////////////////////////////////////////////////////////////////////////////

SELECT sum(faddiari.facd_bultos),   
	 	 sum(faddiari.facd_peso),   
		 sum(faddiari.facd_cubicaje),   
		 sum(faddiari.facd_monto_total),   
		 sum(faddiari.facd_monto_final),  
 		 sum(faddiari.facd_costo_total),  
 		 sum(faddiari.facd_descuento_ncr) 
 INTO :ll_tot_bultos,   
		:ld_tot_peso,   
		:ld_tot_cubicaje,
		:ld_tot_montotot,
		:ld_tot_montofin,
		:ld_fact_costo_total,
		:ld_descuento_ncr
 FROM faddiari  
WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
		( faddiari.facd_empresa 	= :str.empresa ) AND  
		( faddiari.facd_no_pedido	=  :ls_num_sec  ) AND  
		( faddiari.facd_tipo			= :ls_tipo ) AND
		( faddiari.facd_ann = :ll_annio ) ;

	If sqlca.sqlcode = -1 then
		ls_error =sqlca.sqlerrtext
		rollback using sqlca;
		mensaje("Ateción","Error al actualizar los totales en faddiari "+ls_error,"")
		return
	End If
	
	
 SELECT sum(fadcargo.dcar_monto)
 INTO :ld_tot_gastostot
 FROM fadcargo  
WHERE ( fadcargo.dcar_g_financiero = :str.g_financiero ) AND  
		( fadcargo.dcar_empresa 	= :str.empresa ) AND  
		( fadcargo.dcar_no_pedido 	= :ls_num_sec ) AND  
		( fadcargo.dcar_tipo	= :ls_tipo ) AND
		( fadcargo.dcar_ann 	= :ll_annio ) ;

if IsNull(ld_descuento_ncr) then ld_descuento_ncr=0
If IsNull(ld_tot_gastostot) then
	ld_tot_gastostot = 0
End If
If IsNull(ld_tot_montotot) then
	ld_tot_montotot = 0
End If 
If IsNull(ld_tot_montofin) then
	ld_tot_montofin = 0
End If 
	
If sqlca.sqlcode = -1 then
	ls_error =sqlca.sqlerrtext
	rollback using sqlca;
	mensaje("Atención ","Error al totalizar cargos "+ls_error,"")
	return
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
	
  UPDATE fatdiari  
     SET fact_peso_total 		= :ld_tot_peso,   
         fact_cubicaje_total 	= :ld_tot_cubicaje,   
         fact_bultos_total 	= :ll_tot_bultos,   
         fact_monto_fact_total =:ld_tot_montotot,   
         fact_gastos_total 	= :ld_tot_gastostot,   
         fact_monto_final 		= :ld_final,  
         fact_costos_total		= :ld_fact_costo_total,
			fact_descuento_ncr	= :ld_descuento_ncr,
			fact_viene_de_pedido = 0 //Para que cuando entre en factura de productos, rebaje y reserve normalmente
   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
         ( fatdiari.fact_empresa 	= :str.empresa ) AND
         ( fatdiari.fact_no_pedido 	= :ls_num_sec ) AND  
			( fatdiari.fact_tipo			= :ls_tipo ) AND
         ( fatdiari.fact_ann 			= :ll_annio ) ;

			If sqlca.sqlcode <> 0 then
				ls_error =sqlca.sqlerrtext
				rollback using sqlca;
			  	mensaje("Error","Error al actualizar totales de la factura "+ls_error,"")
			  	return
			End If
			
	commit using sqlca;
 
If lb_pedido_unico Then
  UPDATE fatdiari
     SET fact_actualizo_cargos = 'S'
   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
         ( fatdiari.fact_empresa 	= :str.empresa ) AND
         ( fatdiari.fact_no_pedido 	= :ls_num_sec ) AND  
			( fatdiari.fact_tipo			= :ls_tipo ) AND			
         ( fatdiari.fact_ann 			= :ll_annio ) ;
			
	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback ;
		gf_mensaje("","Error al Actualizar Cargos en Facturas "+ls_error,1,1,"E")
		return
	end if
	commit using sqlca;
End If

mensaje("AVISO","El pase a Factura se ha Efectuado Satisfactoriamente","")		
		
ll_cliente = idch_cliente.GetItemnumber(idch_cliente.GetRow(),"terc_tercero")

If dw_1.Retrieve(str.g_financiero,str.empresa,ll_cliente) < 1 then dw_3.Reset()

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
         ( fatpedid.pedi_no_pedido = :ls_ped_pedido ) and
         ( fatpedid.pedi_ann = :li_ann ) and
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
				( fatpedid.pedi_no_pedido 	= :ls_ped_pedido ) AND  
				( fatpedid.pedi_ann = :li_ann )   ;

		If sqlca.sqlcode = -1 then
			ls_error =sqlca.sqlerrtext
			rollback using sqlca;
			mensaje("Error ","Error al marcar estado del pedido Pasado "+ls_error,"")
			return
		End If
		
		commit using sqlca;				
		
End If

dw_3.Reset()
dw_4.Reset()
end subroutine

on w_fa_co_ped_pasa_fact.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.rb_1=create rb_1
this.rb_2=create rb_2
this.dw_2=create dw_2
this.rb_4=create rb_4
this.rb_5=create rb_5
this.rb_6=create rb_6
this.pb_1=create pb_1
this.em_1=create em_1
this.em_2=create em_2
this.st_2=create st_2
this.st_3=create st_3
this.dw_3=create dw_3
this.pb_2=create pb_2
this.pb_3=create pb_3
this.dw_5=create dw_5
this.pb_4=create pb_4
this.dw_6=create dw_6
this.rb_7=create rb_7
this.gb_2=create gb_2
this.rb_3=create rb_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.dw_4=create dw_4
this.cb_pedi_sala=create cb_pedi_sala
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.rb_4
this.Control[iCurrent+6]=this.rb_5
this.Control[iCurrent+7]=this.rb_6
this.Control[iCurrent+8]=this.pb_1
this.Control[iCurrent+9]=this.em_1
this.Control[iCurrent+10]=this.em_2
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.dw_3
this.Control[iCurrent+14]=this.pb_2
this.Control[iCurrent+15]=this.pb_3
this.Control[iCurrent+16]=this.dw_5
this.Control[iCurrent+17]=this.pb_4
this.Control[iCurrent+18]=this.dw_6
this.Control[iCurrent+19]=this.rb_7
this.Control[iCurrent+20]=this.gb_2
this.Control[iCurrent+21]=this.rb_3
this.Control[iCurrent+22]=this.cb_1
this.Control[iCurrent+23]=this.cb_2
this.Control[iCurrent+24]=this.cb_3
this.Control[iCurrent+25]=this.dw_4
this.Control[iCurrent+26]=this.cb_pedi_sala
end on

on w_fa_co_ped_pasa_fact.destroy
call super::destroy
destroy(this.gb_3)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.dw_2)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.rb_6)
destroy(this.pb_1)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_3)
destroy(this.pb_2)
destroy(this.pb_3)
destroy(this.dw_5)
destroy(this.pb_4)
destroy(this.dw_6)
destroy(this.rb_7)
destroy(this.gb_2)
destroy(this.rb_3)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.dw_4)
destroy(this.cb_pedi_sala)
end on

event ue_post_open;//Override/*Jorge Herrera*///Fecha: 24/2/99
string ls_vienede, ls_where,ls_medact
long ll_recupero

this.y = 1
this.x =1
	iuo_desglose = Create uo_ds_desglose
	iuo_desglose.Dynamic of_init ("dw_co_fa_pedpasfac_desg")

	iuo_desg_a_pasar = Create uo_ds_desglose
	iuo_desg_a_pasar.Dynamic of_init ("dw_co_fa_pedpasfac_desg")
	
	DataWindowChild child_produc
	
	if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 then
		DW_1.dataobject='dw_co_fa_pedapasar_acisa'
		DW_5.Modify("notercero.DDDW.Name=dw_pr_fa_pedidos_x_pasar_acisa")
	END IF
	dw_1.SetTransObject(Sqlca)
	
	dw_2.SetTransObject(SQLCA)
	Dw_2.InsertRow(0)
	dw_2.setfocus()
	dw_2.SetColumn("texto")
	
	dw_3.SetTransObject(SQLCA)
	
	dw_4.GetChild("fadpedid_dped_unidad_venta", idw_child_uni)
	idw_child_uni.setTransObject(sqlca)
	idw_child_uni.Retrieve()
	dw_4.SetTransObject(sqlca)
	
	dw_5.Accepttext()
//	dw_5.insertrow(0)
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
			mensaje("Información (ue_post_open)","Error al Seleccionar el conteo en ccmclien",sqlca.sqlerrtext)
			return 
		end if					
	
	If ll_recupero < 1 then
		idch_cliente.InsertRow(0)
	Else
//		idch_cliente.Retrieve(str.g_financiero,str.empresa)
		if idch_cliente.Retrieve(str.g_financiero,str.empresa) < 1 then idch_cliente.insertrow(0)
	End If
	dw_5.SetTransObject(Sqlca)
	dw_5.ScrollToRow(dw_5.InsertRow(0))
	dw_5.SetFocus()
	pb_2.PictureName = str.path +"art\pasar_rp.jpg"
	pb_2.Enabled = false
	str.frame.SetMicroHelp ("Seleccione una Linea y Precione la Tecla Enter para Cargar la Información" )
//End If
//If w_fa_fondo.str_para.tiene_vta_detal = 1 then
//	cb_pedi_sala.visible = true
//else
	cb_pedi_sala.visible = false
//end if

end event

event open;//Override
//OpenWithParm(w_fa_man_clave_pedido, this)
//
//If is_user = "*" then
//	close(this)
//	Return
//END IF

st_nom_ventana.text = this.classname()
this.triggerevent("ue_post_open")


end event

event close;//Override
Destroy iuo_desglose
Destroy iuo_desg_a_pasar

if isvalid(this) then close(this)
end event

event resize;//OVERRIDE
st_nom_ventana.y = newheight - 60	//Nombre de la ventana
gb_2.y = newheight - 220				//Grupo del filtrado
rb_5.y = newheight - 160				//Boton del estado
rb_4.y = newheight - 160				//Boton del pedido
rb_3.y = newheight - 160				//Boton del nombre
dw_2.y = newheight - 165				//DW del filtrado
dw_6.y = newheight - 310				//DW de las existencias
dw_4.height = newheight - 1280
end event

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_co_ped_pasa_fact
boolean visible = false
integer x = 18
integer y = 1628
long backcolor = 74481808
end type

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_co_ped_pasa_fact
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_co_ped_pasa_fact
event ue_down pbm_dwnkey
event ue_post ( )
integer x = 59
integer y = 120
integer width = 2802
integer height = 384
integer taborder = 140
string dataobject = "dw_co_fa_pedapasar"
boolean vscrollbar = true
boolean border = false
boolean livescroll = false
end type

event dw_1::ue_down;call super::ue_down;//Si el Usuario Dio Enter

//If key = KeyUpArrow! Or Key = KeyDownArrow! Then 
//
//	This.Postevent("r")
//	return(2)
//	
//ElseIf key = KeyUpArrow! Then
//This.ScrollPriorRow ( ) 
//
//ElseIf key = KeyDownArrow! Then
//This.ScrollNextRow ( ) 	
	
//End If	



end event

event dw_1::doubleclicked;call super::doubleclicked;//This.Postevent("ue_entercol")
end event

event dw_1::rowfocuschanged;//Recupera los datos del detalle haciendo referencia al encabezado
//JORGE HERRERA 11/03/1998
String ls_prof
Integer li_ano, li_rows

this.SelectRow(0,FALSE)
this.SelectRow(currentrow,TRUE)

li_rows = this.RowCount()
If this.RowCount() < 1 Or currentrow = 0 then return
If currentrow = this.GetRow() Then
	ls_prof = GetitemString(currentrow ,"fatpedid_pedi_no_pedido")
	li_ano =  GetitemNumber(currentrow ,"fatpedid_pedi_ann")
	parent.SetRedraw(False)
	dw_3.Retrieve(str.g_financiero,str.empresa,ls_prof,li_ano)
	wf_cant_apasar()
	parent.SetRedraw(true)
End IF


end event

event dw_1::clicked;call super::clicked;/*Jorge Herrera*///Fecha: 24/2/99
String ls_pedi 
Integer li_ano

If this.RowCount() < 1 Or Row = 0 then return
	this.SelectRow(0,FALSE)
	this.SelectRow(row,TRUE)
	pb_3.text = "Pasar Todos"
	ls_pedi = GetitemString(row ,"fatpedid_pedi_no_pedido")
	li_ano =  GetitemNumber(row ,"fatpedid_pedi_ann")

	this.SetRedraw(False)
	dw_3.Retrieve(str.g_financiero,str.empresa,ls_pedi,li_ano)
	wf_cant_apasar()
	this.SetRedraw(True)
	
	idw_cual = this
	pb_4.enabled = false
	ii_escpri = 0	
	
	
end event

event dw_1::ue_microayuda;////override
///*
//	Evento que muestra una pequeña Ayuda dependiendo en que columna se encuentre el mouse
//*/
//
//Integer li_pos, li_x, li_y
//String ls_objeto, ls_col
//
//ls_objeto = This.GetObjectAtPointer()
//li_pos = pos  (ls_objeto,"~t")
//ls_col = left (ls_objeto, li_pos - 1)
//
//
//li_x	 = str.frame.GetActiveSheet ().PointerX () //- 900
//li_y	 = str.frame.GetActiveSheet ().PointerY () - 200
//
////messagebox("Apunta a :",ls_col)
//
//// Dependiendo de la Columna el Mensaje de Ayuda varía
//CHOOSE CASE right(ls_col,2)
//	CASE '_t'
////		messagebox("!","Invisible")
//		If st_ayuda.Visible Then Return
//		st_ayuda.Move (1600,11)
//		st_ayuda.Text 	= "Haga click para ordenar por la Columna de " + this.describe(ls_col+".text")
//		st_ayuda.Width 	= Len (st_ayuda.Text) * 28
//		st_ayuda.Visible = TRUE	
//	CASE ELSE
//	st_ayuda.Visible = FALSE
//END CHOOSE

end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_co_ped_pasa_fact
integer x = 23
integer y = 24
integer width = 2862
integer height = 504
integer taborder = 0
long textcolor = 8388608
long backcolor = 74481808
string text = "Encabezado"
end type

type gb_3 from groupbox within w_fa_co_ped_pasa_fact
integer x = 2423
integer y = 1320
integer width = 480
integer height = 300
integer taborder = 200
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 74481808
string text = "Ejecutar el Pase"
end type

type rb_1 from radiobutton within w_fa_co_ped_pasa_fact
event clicked pbm_bnclicked
boolean visible = false
integer x = 722
integer y = 1376
integer width = 320
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Cliente"
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()

end event

type rb_2 from radiobutton within w_fa_co_ped_pasa_fact
event clicked pbm_bnclicked
boolean visible = false
integer x = 1102
integer y = 1376
integer width = 219
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "R.U.C."
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()

end event

type dw_2 from datawindow within w_fa_co_ped_pasa_fact
event editchanged pbm_dwnchanging
integer x = 1449
integer y = 1504
integer width = 827
integer height = 84
integer taborder = 120
boolean bringtotop = true
string dataobject = "dw_texto"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event editchanged;String ls_letra,formato,ls_setting,ls_estado
This.accepttext()
ls_letra =This.getitemstring(1,1) 



If Match (data, "%") = True Then Return
If ls_letra = "Texto" Then Return


// Permite Modificar el estado Con la Finalidad de que Funcione el Filtrado
      ls_setting = dw_1.Describe("DataWindow.Retrieve.AsNeeded")
       If ls_setting = "yes" Then 
           dw_1.Modify("DataWindow.Retrieve.AsNeeded=No")	
       End If	

 

IF rb_1.Checked = True THEN /*Cliente*/
	Formato =  "String("  + "dgmterce_terc_descripcion)"  + "like "   + "'" + data +"%" + "'"

ELSEIF rb_2.Checked = True THEN /*Ruc*/
	
	Formato =  "fatprofo_prof_ruc_cliente like " +"'"+data+"%"+"'"
ELSEIF rb_3.Checked = True THEN /*A Nombre*/
	Formato =  "fatpedid_pedi_a_nombre like " +"'"+data+"%"+"'"
	
ELSEIF rb_4.Checked = True THEN /*Pedido*/
	Formato =  "fatpedid_pedi_no_pedido like " +"'"+data+"%"+"'"

ELSEIF rb_5.Checked = True THEN /*Estado*/
		
	Formato =  "fatpedid_pedi_estado  like " +"'"+data+"%"+"'"

ELSEIF rb_6.Checked = True THEN /*Fecha*/
	Formato =  " date(fatpedid_pedi_fecha) Between " + &
	                  "Date(" + "'" + em_1.text + "'" + ")" + " And " + & 
					"Date("+ "'" +em_2.text +"'"+")"

ELSEIF rb_7.Checked = True THEN /*Vendedor*/
	Formato =  "fatpedid_pedi_a_nombre like " +"'"+data+"%"+"'"


ELSE /*Proforma*/
	Formato =  "String("  + "fatpedid_pedi_no_pedido)"  + "like "  +"'"+data+"%"+"'"
END IF

If Formato <> "" Then
	dw_1.SetFilter(Formato)
	dw_1.Filter()
	If dw_1.RowCount() > 0 Then dw_3.Reset()

End If
end event

type rb_4 from radiobutton within w_fa_co_ped_pasa_fact
integer x = 526
integer y = 1516
integer width = 251
integer height = 76
integer taborder = 20
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
wf_nofecha()

end event

type rb_5 from radiobutton within w_fa_co_ped_pasa_fact
integer x = 64
integer y = 1516
integer width = 247
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 74481808
string text = "Estado"
boolean checked = true
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()
end event

type rb_6 from radiobutton within w_fa_co_ped_pasa_fact
boolean visible = false
integer x = 1115
integer y = 1520
integer width = 247
integer height = 76
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 74481808
string text = "Fecha"
boolean lefttext = true
end type

event clicked;wf_fecha()
end event

type pb_1 from picturebutton within w_fa_co_ped_pasa_fact
event clicked pbm_bnclicked
boolean visible = false
integer x = 2254
integer y = 1504
integer width = 101
integer height = 88
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "\art\blind.bmp"
end type

event clicked;If em_1.text <> "" And em_2.text <> "" Then
	dw_2.Triggerevent("editchanged")
else
	Messagebox("Alto","Es Requerida Una fecha para Realizar la Busqueda",StopSign!)
End If	
end event

type em_1 from editmask within w_fa_co_ped_pasa_fact
boolean visible = false
integer x = 1591
integer y = 1504
integer width = 283
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
string displaydata = "~b"
end type

type em_2 from editmask within w_fa_co_ped_pasa_fact
boolean visible = false
integer x = 1961
integer y = 1504
integer width = 283
integer height = 84
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
string displaydata = "~b"
end type

type st_2 from statictext within w_fa_co_ped_pasa_fact
boolean visible = false
integer x = 1426
integer y = 1504
integer width = 160
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 77107328
boolean enabled = false
string text = "Entre"
alignment alignment = center!
long bordercolor = 77107328
boolean focusrectangle = false
end type

type st_3 from statictext within w_fa_co_ped_pasa_fact
boolean visible = false
integer x = 1874
integer y = 1504
integer width = 87
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 77107328
boolean enabled = false
string text = "y"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_fa_co_ped_pasa_fact
event ue_lbuttonup pbm_dwnlbuttonup
integer x = 23
integer y = 540
integer width = 2354
integer height = 404
integer taborder = 160
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle del pedido"
string dataobject = "dw_co_fa_pedpasfact"
boolean maxbox = true
boolean vscrollbar = true
boolean resizable = true
boolean border = false
string icon = "AppIcon!"
boolean livescroll = true
end type

event ue_lbuttonup;long	  ll_ClickedRow
string	  ls_KeyDownType

If ib_action_on_buttonup Then
	ib_action_on_buttonup = false

	If Keydown(KeyControl!) then
		this.selectrow(il_lastclickedrow,FALSE)
	Else
		this.SelectRow(0,FALSE)
		this.SelectRow(il_lastclickedrow,TRUE)
		ib_tipoclicked = false
	End If
	
	il_lastclickedrow = 0
End If
end event

event clicked;idw_cual = this
pb_3.Text = "Pasar"
pb_4.enabled = false
ii_clicked = row

string	  ls_KeyDownType

If row = 0 then Return

If Keydown(KeyShift!) then
	wf_Shift_Highlight(row)
	ib_tipoclicked = true
ElseIf this.IsSelected(row) Then
	il_LastClickedRow = row
	ib_action_on_buttonup = true
//	ib_tipoclicked = false
//ElseIf Keydown(KeyControl!) then
//	il_LastClickedRow = row
//	this.SelectRow(row,TRUE)
Else
//	ib_tipoclicked = false
	il_LastClickedRow = row
	this.SelectRow(0,FALSE)
	this.SelectRow(row,TRUE)
End If  
end event

event retrieveend;//Script que Calcula las cantidades por pasar 
String  	ls_uni, ls_item, ls_profor, ls_cod_item, ls_filtro, ls_restaurado_por
long  	ll_cantidad, ll_fraccion,ll_conv, ll_i, ll_pasado,ll_cant_pas, ll_c, &
			ll_anno,ll_linea, ll_unimin, ll_cant_frac
Integer 	li_rows, li_restaurado_por
//decimal	ld_cant_frac, ld_unimin, ld_pasado,ld_fraccion

this.SetRedraw(False)
this.SetFilter("")
this.Filter()

li_rows = this.RowCount()

For ll_i = 1 to li_rows
	ls_item = This.Getitemstring(ll_i,"fadpedid_dped_codigo_item")
	ls_uni = This.GetitemString(ll_i,"fadpedid_dped_unidad_venta")
	ll_cantidad = This.GetitemNumber(ll_i,"fadpedid_dped_cantidad")
	ll_fraccion = This.GetitemNumber(ll_i,"fadpedid_dped_fraccion")
	ll_pasado = This.GetitemNumber(ll_i,"fadpedid_dped_pasada")

//	ll_unimin = gf_fa_convertmin( ls_uni , ll_cantidad , ll_fraccion )
	ll_unimin = 0
	gf_fa_convertmin_new(ll_unimin, ls_uni , ll_cantidad , ll_fraccion )

//	gf_fa_convertuni(ls_uni,ll_unimin - ll_pasado,ll_cant_pas,ld_cant_frac)
	gf_fa_convertuni_new(ls_uni, ll_unimin - ll_pasado,ll_cant_pas , ll_cant_frac)
	
	this.SetItem(ll_i,"c_cant_pas",ll_cant_pas)
	this.SetITem(ll_i,"c_cant_frac",ll_cant_frac)
	this.SetItem(ll_i,"c_por_pasar",ll_unimin)
	
	//Para reservar o no al insertar en pedidos, reserva si el pedido fue restaurado
	ls_restaurado_por = dw_1.getitemstring(dw_1.getrow(),"pedi_restaurado_por")	
	if len(trim(ls_restaurado_por)) > 0 then
		li_restaurado_por = 0  //PARA QUE RESERVE EN FADDIARI
	else
		li_restaurado_por = 1
	end if

	this.SetItem(ll_i,"viene_de_pedido",li_restaurado_por)	
	
Next

this.SetFilter("c_cant_pas > 0 OR c_cant_frac > 0")
this.Filter()

If dw_4.RowCount() > 0 then
li_rows = this.RowCount()
For ll_c = 1 to dw_4.RowCount()
	ls_profor = dw_4.getItemString(ll_c,"fadpedid_dped_no_pedido")
	ll_anno = dw_4.getItemNumber(ll_c,"fadpedid_dped_ann")
	ll_linea =  dw_4.getItemNumber(ll_c,"fadpedid_dped_linea")
	ls_cod_item =  dw_4.getItemString(ll_c,"fadpedid_dped_codigo_item")
	
	For ll_i = 1 to li_rows
		
		If This.Getitemstring(ll_i,"fadpedid_dped_codigo_item") = ls_cod_item AND &
			This.Getitemnumber(ll_i,"fadpedid_dped_linea") = ll_linea AND &
			This.Getitemnumber(ll_i,"fadpedid_dped_ann") = ll_anno AND &
			This.GetitemString(ll_i,"fadpedid_dped_no_pedido") = ls_profor Then
			this.Deleterow(ll_i)
			ll_i = ll_i - 1
			li_rows = this.RowCount()
			
			//  Desglose
			ls_filtro = 'dcpe_linea = ' + string (ll_linea) + ' And dcpe_anno = ' +&
							 string (ll_anno) + ' And dcpe_no_pedido = "' + ls_profor + '"'
			iuo_desg_a_pasar.SetFilter (ls_filtro)
			iuo_desg_a_pasar.Filter ()

			Do While iuo_desg_a_pasar.RowCount () > 0
				iuo_desg_a_pasar.DeleteRow (0)
			Loop
			
			iuo_desg_a_pasar.SetFilter ('')
			iuo_desg_a_pasar.Filter ()
		End IF
		
	Next
Next
End If

this.SetRedraw(True)

//Desglose
wf_ds_retrieve ()		
end event

type pb_2 from picturebutton within w_fa_co_ped_pasa_fact
integer x = 2537
integer y = 1388
integer width = 233
integer height = 208
integer taborder = 240
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\harr2000\art\pasar_rp.jpg"
vtextalign vtextalign = multiline!
end type

event clicked;//ue_pase, llama a su vez a wf_efectuar_pase()
//sqlca.autocommit = false
parent.TriggerEvent("ue_pase")
sqlca.autocommit = true
end event

type pb_3 from picturebutton within w_fa_co_ped_pasa_fact
integer x = 2418
integer y = 692
integer width = 448
integer height = 108
integer taborder = 180
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pasar"
end type

event clicked;parent.Triggerevent("ue_pasarow")
end event

type dw_5 from datawindow within w_fa_co_ped_pasa_fact
event ue_key pbm_dwnkey
integer x = 46
integer y = 8
integer width = 1262
integer height = 96
integer taborder = 150
boolean bringtotop = true
string dataobject = "dw_dd_fa_clientes_pedidos"
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

event itemchanged;/*Jorge Herrera*/
//24/2/99

long ll_cliente

ll_cliente = idch_cliente.GetItemnumber(idch_cliente.GetRow(),"terc_tercero")
dw_3.Reset()
dw_4.Reset()

If dw_1.Retrieve(str.g_financiero,str.empresa,ll_cliente) < 1 then
	
	// Inicializando DataStore
	iuo_desg_a_pasar.Reset ()
	iuo_desglose.Reset ()
Else
	
	pb_2.PictureName = str.path +"art\pasar_rp.jpg"
	pb_2.enabled = true
End IF
end event

type pb_4 from picturebutton within w_fa_co_ped_pasa_fact
integer x = 2418
integer y = 1060
integer width = 448
integer height = 108
integer taborder = 170
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

type dw_6 from datawindow within w_fa_co_ped_pasa_fact
integer x = 59
integer y = 1368
integer width = 2258
integer height = 88
integer taborder = 210
boolean bringtotop = true
string dataobject = "dw_man_fa_exist"
boolean border = false
boolean livescroll = true
end type

type rb_7 from radiobutton within w_fa_co_ped_pasa_fact
boolean visible = false
integer x = 946
integer y = 1520
integer width = 215
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 74481808
string text = "Fecha"
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()

end event

type gb_2 from groupbox within w_fa_co_ped_pasa_fact
integer x = 23
integer y = 1448
integer width = 2363
integer height = 156
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
string text = "Busquedas"
end type

type rb_3 from radiobutton within w_fa_co_ped_pasa_fact
event clicked pbm_bnclicked
integer x = 919
integer y = 1508
integer width = 411
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 77107328
string text = "A Nombre de "
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()

end event

type cb_1 from commandbutton within w_fa_co_ped_pasa_fact
boolean visible = false
integer x = 1687
integer y = 1620
integer width = 247
integer height = 68
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;MessageBox ('DATA',iuo_desg_a_pasar.Describe ('DataWindow.Data'))
end event

type cb_2 from commandbutton within w_fa_co_ped_pasa_fact
boolean visible = false
integer x = 2185
integer y = 1620
integer width = 247
integer height = 68
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;MessageBox ('DATA',iuo_desglose.Describe ('DataWindow.Data'))
end event

type cb_3 from commandbutton within w_fa_co_ped_pasa_fact
boolean visible = false
integer x = 2551
integer y = 888
integer width = 247
integer height = 108
integer taborder = 190
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;wf_set_lineas ()
end event

type dw_4 from datawindow within w_fa_co_ped_pasa_fact
event ue_key pbm_dwnkey
event ue_postkey ( )
integer x = 27
integer y = 956
integer width = 2350
integer height = 404
integer taborder = 230
boolean bringtotop = true
boolean titlebar = true
string title = "Por Pasar"
string dataobject = "dw_co_fa_pedpasfact"
boolean maxbox = true
boolean vscrollbar = true
boolean resizable = true
boolean border = false
string icon = "AppIcon!"
boolean livescroll = true
end type

event clicked;idw_cual = this
pb_4.Text = "Retornar"
pb_4.enabled = true
ii_clicked = row
this.SelectRow(0,FALSE)
this.SelectRow(row,TRUE)





end event

event rowfocuschanged;long ll_ucom, ll_cont, coont, ll_linea, ll_row
string ls_medactual ,ls_filtro, ls_coditem, ls_bodega, ls_ubicacion,&
ls_coditem2 , ls_bodega2, ls_ubicacion2 
ll_row = this.RowCount()

If ll_row  > 0 then
	
	ls_coditem = This.Getitemstring(this.GetRow(),"fadpedid_dped_codigo_item")
	ls_bodega = This.Getitemstring(this.GetRow(),"fadpedid_dped_bodega")
	ls_ubicacion = This.Getitemstring(this.GetRow(),"fadpedid_dped_ubicacion")
	ll_linea = This.GetItemNumber(this.GetRow(),"fadpedid_dped_linea")
	
	If ll_row  > 1 then
	
	For ll_cont = 1 to ll_row - 1
		
		ls_coditem2 = dw_4.Getitemstring(ll_cont,"fadpedid_dped_codigo_item")
		ls_bodega2 = dw_4.Getitemstring(ll_cont,"fadpedid_dped_bodega")
		ls_ubicacion2 = dw_4.Getitemstring(ll_cont,"fadpedid_dped_ubicacion")
		
		IF ls_coditem = ls_coditem2  and &
				ls_bodega = ls_bodega2 and &
					ls_ubicacion = ls_ubicacion2 THEN	
					ib_flag = true
		End IF
	Next 
	End If
	
ls_coditem = This.Getitemstring(this.GetRow(),"fadpedid_dped_codigo_item")
ls_bodega = This.Getitemstring(this.GetRow(),"fadpedid_dped_bodega")
ls_ubicacion = This.Getitemstring(this.GetRow(),"fadpedid_dped_ubicacion")

dw_6.SetFilter("mbod_producto = '"+ls_coditem + "' AND mbod_bodega = '"+ls_bodega+ "' AND mbod_ubicacion = '"+ls_ubicacion +"'")
dw_6.Filter()

End If
end event

event itemfocuschanged;string ls_coditem, ls_bodega, ls_ubicacion
long  ll_linea

If this.Rowcount() > 0 then

ls_coditem = This.Getitemstring(row,"fadpedid_dped_codigo_item")
ls_bodega = This.Getitemstring(row,"fadpedid_dped_bodega")
ls_ubicacion = This.Getitemstring(row,"fadpedid_dped_ubicacion")

If dw_6.Retrieve(str.g_financiero,str.empresa,ls_coditem,ls_bodega,ls_ubicacion) <> 1 then return

wf_caldisp(ls_coditem,ls_bodega,ls_ubicacion)

End If



end event

event editchanged;long 	ll_pasado, ll_unimin, ll_vendido, &
		ll_totvenpas, ll_linea, ll_row, ll_cont
string 	ls_coditem, ls_bodega, ls_ubicacion, ls_uni, &
			ls_coditem2, ls_bodega2, ls_ubicacion2, ls_nomcolumna
//decimal	ld_unimin, ld_totvenpas, ld_vendido ,ld_pasado

ll_row = this.Rowcount()
ls_nomcolumna = this.GetColumnName()
If ll_row  < 0  then return

CHOOSE CASE ls_nomcolumna
	CASE "c_cant_pas"
		il_cantidad = long(this.GetText())
		id_fraccion = This.GetitemNumber(row,"c_cant_frac")
	CASE "c_cant_frac"
		id_fraccion = long(this.GetText())
		il_cantidad = This.GetitemNumber(row,"c_cant_pas")
END CHOOSE

ls_uni = This.GetitemString(row,"fadpedid_dped_unidad_venta")
ll_pasado = This.GetitemNumber(row,"fadpedid_dped_pasada")
ll_vendido = This.GetitemNumber(row,"c_por_pasar")

ll_totvenpas = ll_vendido - ll_pasado

//ll_unimin = gf_fa_convertmin( ls_uni , il_cantidad , il_fraccion )
ll_unimin = 0
gf_fa_convertmin_new(ll_unimin, ls_uni , il_cantidad , id_fraccion )

If  ll_unimin  <= ll_totvenpas then
	this.SetItem(row,"c_a_pasar",ll_unimin)
Else
	Mensaje("ADVERTENCIA","Cantidad sobrepasada","")
	this.SetItem(row,"c_a_pasar",ll_unimin)
	If ls_nomcolumna = "c_cant_pas" then
		this.SetItem(row,"c_cant_pas",This.GetitemNumber(Row,"c_cant_pas",Primary!,true))
	ElseIf ls_nomcolumna = "c_cant_frac" then
		this.SetITem(row,"c_cant_frac",This.GetitemNumber(Row,"c_cant_frac",Primary!,true))
	End If
//	ld_unimin = gf_fa_convertmin( ls_uni ,This.GetitemNumber(Row,"c_cant_pas",Primary!,true),&
//					This.GetitemNumber(Row,"c_cant_frac",Primary!,true))
	ll_unimin = 0
	gf_fa_convertmin_new(ll_unimin, ls_uni , This.GetitemNumber(Row,"c_cant_pas",Primary!,true),&
					This.GetitemNumber(Row,"c_cant_frac",Primary!,true) )
	this.SetItem(row,"c_a_pasar",ll_unimin)
End IF
end event

event itemchanged;// 20/mayo/1999
// Si se cambia la Cantidad es necesario desglosar las cantidades en Tamaños (tallas) y 
// Colores
String	ls_bodega, ls_ubic, ls_producto
Long		ll_linea

If dwo.name = 'c_cant_pas' oR dwo.name = 'c_cant_frac' Then

	ls_bodega 	= GetItemString (row, 'fadpedid_dped_bodega')
	ls_ubic   	= GetItemString (row, 'fadpedid_dped_ubicacion')
	ls_producto	= GetItemString (row, 'fadpedid_dped_codigo_item')

	// Verificando si tiene desglose en Bodega
	If gf_fa_tiene_desglose (ls_bodega, ls_ubic, ls_producto) Then
		
		//ll_linea	= GetItemNumber (row, 'fadpedid_dped_linea')
		//Post wf_config_cant (row)
	End If
End If
end event

type cb_pedi_sala from commandbutton within w_fa_co_ped_pasa_fact
boolean visible = false
integer x = 2418
integer y = 568
integer width = 462
integer height = 108
integer taborder = 150
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ped. Sala Venta"
end type

event clicked;Opensheet(w_fa_co_pedidos_sala_vta,str.frame,9,Original!)

end event

