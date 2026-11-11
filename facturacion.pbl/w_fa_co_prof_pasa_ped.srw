//objectcomments Nueva ventana de pase de Proforma a Pedidos
forward
global type w_fa_co_prof_pasa_ped from w_fa_padre_reportes
end type
type gb_nose from groupbox within w_fa_co_prof_pasa_ped
end type
type gb_2 from groupbox within w_fa_co_prof_pasa_ped
end type
type rb_1 from radiobutton within w_fa_co_prof_pasa_ped
end type
type rb_2 from radiobutton within w_fa_co_prof_pasa_ped
end type
type rb_3 from radiobutton within w_fa_co_prof_pasa_ped
end type
type dw_2 from datawindow within w_fa_co_prof_pasa_ped
end type
type rb_4 from radiobutton within w_fa_co_prof_pasa_ped
end type
type rb_5 from radiobutton within w_fa_co_prof_pasa_ped
end type
type rb_6 from radiobutton within w_fa_co_prof_pasa_ped
end type
type rb_7 from radiobutton within w_fa_co_prof_pasa_ped
end type
type pb_1 from picturebutton within w_fa_co_prof_pasa_ped
end type
type em_1 from editmask within w_fa_co_prof_pasa_ped
end type
type em_2 from editmask within w_fa_co_prof_pasa_ped
end type
type st_2 from statictext within w_fa_co_prof_pasa_ped
end type
type st_3 from statictext within w_fa_co_prof_pasa_ped
end type
type dw_3 from datawindow within w_fa_co_prof_pasa_ped
end type
type pb_3 from picturebutton within w_fa_co_prof_pasa_ped
end type
type pb_4 from picturebutton within w_fa_co_prof_pasa_ped
end type
type dw_5 from datawindow within w_fa_co_prof_pasa_ped
end type
type cb_1 from commandbutton within w_fa_co_prof_pasa_ped
end type
type cb_2 from commandbutton within w_fa_co_prof_pasa_ped
end type
type gb_4 from groupbox within w_fa_co_prof_pasa_ped
end type
type dw_6 from datawindow within w_fa_co_prof_pasa_ped
end type
type dw_4 from datawindow within w_fa_co_prof_pasa_ped
end type
type st_1 from statictext within w_fa_co_prof_pasa_ped
end type
type st_7 from statictext within w_fa_co_prof_pasa_ped
end type
type st_8 from statictext within w_fa_co_prof_pasa_ped
end type
type pb_2 from picturebutton within w_fa_co_prof_pasa_ped
end type
type gb_3 from groupbox within w_fa_co_prof_pasa_ped
end type
end forward

global type w_fa_co_prof_pasa_ped from w_fa_padre_reportes
integer x = 503
integer y = 400
integer width = 2958
integer height = 1784
string title = "(FA) Pase de Proformas a Pedidos Reservados"
string menuname = ""
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
string icon = "Application!"
event ue_pasarow ( )
event ue_pase ( )
gb_nose gb_nose
gb_2 gb_2
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
dw_2 dw_2
rb_4 rb_4
rb_5 rb_5
rb_6 rb_6
rb_7 rb_7
pb_1 pb_1
em_1 em_1
em_2 em_2
st_2 st_2
st_3 st_3
dw_3 dw_3
pb_3 pb_3
pb_4 pb_4
dw_5 dw_5
cb_1 cb_1
cb_2 cb_2
gb_4 gb_4
dw_6 dw_6
dw_4 dw_4
st_1 st_1
st_7 st_7
st_8 st_8
pb_2 pb_2
gb_3 gb_3
end type
global w_fa_co_prof_pasa_ped w_fa_co_prof_pasa_ped

type variables
Datawindow idw_cual
Datawindowchild idw_child_uni , idch_cliente
integer ii_clicked, ii_cont = 0, ii_cualevent = 1, ii_ultgetrow, &
            ii_escpri = 1
long il_LastClickedRow, il_arrayrows[],il_cantidad, il_fraccion
//Double  id_fraccion
boolean ib_action_on_buttonup, ib_tipoclicked = false, ib_flag = false
end variables

forward prototypes
public subroutine wf_fecha ()
public subroutine wf_nofecha ()
public function string wf_verificar (string ls_original)
public function integer wf_shift_highlight (integer al_aclickedrow)
public subroutine wf_botones ()
public subroutine wf_cambuni ()
public subroutine wf_profident (string as_coditem, string as_codbodega, string as_ubicacion)
public subroutine wf_cant_apasar (string ls_tipo)
public subroutine wf_caldisp (string as_coditem, string as_bodega, string as_ubicacion)
public function string wf_armar_sql (string ls_vienede)
public subroutine wf_efectuar_pase ()
public function boolean wf_calcula_disponible (string as_producto, ref long al_disponible, long al_pedido)
end prototypes

event ue_pasarow;integer li_i, li_rows
long ll_c, ll_anno, ll_linea, ll_i
string ls_proforped,ls_cod_item, ls_tipo

CHOOSE CASE idw_cual
	CASE dw_1
		dw_3.RowsMove(1,dw_3.RowCount(),Primary!,dw_4,1000,Primary!)
		dw_4.Object.c_cant_pas.protect = 0
		dw_4.Object.c_cant_frac.protect = 0	
		If dw_4.rowcount() > 0 then pb_2.enabled = true

	CASE dw_3
		For li_i = 1 to dw_3.RowCount()
			If dw_3.IsSelected(li_i) then
				idw_cual.RowsMove(li_i,li_i,Primary!,dw_4,1000,Primary!)
			End IF		
		Next

		dw_4.Object.c_cant_pas.protect = 0
		dw_4.Object.c_cant_frac.protect = 0
		If dw_4.rowcount() > 0 then pb_2.enabled = true
		dw_3.setfocus()
		dw_3.selectrow(dw_3.getrow(),true)		
	CASE dw_4
		li_rows = dw_1.RowCount()
		For ll_c = 1 to dw_4.RowCount()
			If dw_4.IsSelected(ll_c) Then
			ls_proforped = dw_4.getItemString(ll_c,"dpro_no_proforma")
			ll_anno = dw_4.getItemNumber(ll_c,"dpro_ann")
				
			For li_i = 1 to li_rows
				
			If dw_1.IsSelected(li_i) Then
				If dw_1.Getitemstring(li_i,"fatprofo_prof_no_proforma") = ls_proforped AND &
					dw_1.Getitemnumber(li_i,"fatprofo_prof_ann") = ll_anno Then
					ls_tipo = dw_1.GetItemString(li_i,"fatprofo_prof_tipo")
					dw_4.RowsDiscard(ll_c,ll_c,Primary!)
					dw_3.Setredraw(false)
					dw_3.Retrieve(str.g_financiero,str.empresa,ls_proforped,ll_anno)
					wf_cant_apasar(ls_tipo)	// convierte a unidades minimas y setea resultado
											// en cantidad a pasar
					dw_3.Setredraw(true)
				Else
					dw_4.RowsDiscard(ll_c,ll_c,Primary!)
				End IF
			End If
			Next
			dw_4.setfocus()
			if dw_4.rowcount() > 0 then
				dw_4.selectrow(dw_4.getrow(),true)
			end if
			End If
		Next		
END CHOOSE
	
end event

event ue_pase;wf_efectuar_pase()

end event

public subroutine wf_fecha ();dw_2.visible = false
em_1.visible = True
em_1.text = string(today())
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

public function string wf_verificar (string ls_original);//Función que verifica los parámetros y arma el SQL
string ls_where

  if w_fa_fondo.str_para.mostrar <> 0 then  //mostrar un Año específico
	CHOOSE CASE w_fa_fondo.str_para.desde	//Si es desde el año en adelante o el año exclusivo.
		CASE 0
		 ls_where = ls_original + " and  &
					 ( fatprofo.prof_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatprofo.prof_empresa = "+string(str.empresa)+" ) and &
					 (fatprofo.prof_ann = "+string(w_fa_fondo.str_para.mostrar)+")"
		CASE 1
		 ls_where = ls_original + " and  &
					 ( fatprofo.prof_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatprofo.prof_empresa = "+string(str.empresa)+" ) and &
					 (fatprofo.prof_ann >= "+string(w_fa_fondo.str_para.mostrar)+")"			
	END CHOOSE			
  else
		 ls_where = ls_original + " and  &
					 ( fatprofo.prof_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatprofo.prof_empresa = "+string(str.empresa)+" )"
  end if
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

public subroutine wf_cambuni ();//	 /*Función que hace el cambio de unidad para la banda de disponibles*/
 //Llamada desde wf_calcdisp()
 
	String ls_unidad, ls_output
	Long ll_varcan = 0, ll_cantidad = 0, ll_varfrac = 0

	Datawindow ldw_banda
	
 	//ldw_2 = tab_1.tabpage_2.dw_2
	ldw_banda = dw_6
	
	ls_unidad = dw_4.GetItemString(dw_4.getrow(),"dpro_unidad_venta")
	
	/*Existencia*/	
//	ll_cantidad = ldw_banda.GetItemnumber(1,"mbod_cantidad")
//	if isnull(ll_cantidad) then ll_cantidad = 0
//   gf_fa_convertuni(ls_unidad,ll_cantidad,ll_varcan,ll_varfrac)
//   ls_output = String(ll_varcan +ll_varfrac) 
//   ldw_banda.Object.co_exist.Expression = ls_output

	ll_cantidad = ldw_banda.GetItemnumber(1,"mbod_cantidad")
	if isnull(ll_cantidad) then ll_cantidad = 0
	gf_fa_convertuni_new(ls_unidad,ll_cantidad,ll_varcan,ll_varfrac)
	ls_output = String(ll_varcan +ll_varfrac) 
	ldw_banda.SetItem(1,"cexistencia",ll_varcan)
	ldw_banda.SetItem(1,"fexistencia",ll_varfrac)

	/*ResErvado*/
//	ll_cantidad = ldw_banda.GetItemnumber(1,"mbod_reserva")
//	if isnull(ll_cantidad) then ll_cantidad = 0	
//	gf_fa_convertuni(ls_unidad,ll_cantidad,ll_varcan,ll_varfrac)
//   ls_output = String(ll_varcan +ll_varfrac)
//   ldw_banda.Object.co_res.Expression = ls_output

	ll_cantidad = ldw_banda.GetItemnumber(1,"mbod_reserva")
	if isnull(ll_cantidad) then ll_cantidad = 0	
	gf_fa_convertuni_new(ls_unidad,ll_cantidad,ll_varcan,ll_varfrac)
	ls_output = String(ll_varcan)+'/'+string(ll_varfrac)
	ldw_banda.SetItem(1,"creserva",ll_varcan)
	ldw_banda.SetItem(1,"freserva",ll_varfrac)

	/*Disponible*/
//	ll_cantidad = ldw_banda.GetItemnumber(1,"disponible")
//	if isnull(ll_cantidad) then ll_cantidad = 0	
//   gf_fa_convertuni(ls_unidad,ll_cantidad,ll_varcan,ll_varfrac)
//   ls_output = String(ll_varcan +ll_varfrac)
//   ldw_banda.Object.co_dis.Expression = ls_output

	ll_cantidad = ldw_banda.GetItemnumber(1,"disponible")
	if isnull(ll_cantidad) then ll_cantidad = 0	
	gf_fa_convertuni_new(ls_unidad,ll_cantidad,ll_varcan,ll_varfrac)
	ls_output = String(ll_varcan)+'/'+string(ll_varfrac)
	ldw_banda.SetItem(1,"cdisponible",ll_varcan)
	ldw_banda.SetItem(1,"fdisponible",ll_varfrac)

	ldw_banda.Object.co_unidad[1] = ls_unidad

end subroutine

public subroutine wf_profident (string as_coditem, string as_codbodega, string as_ubicacion);string ls_no_proforma, ls_no_prof, ls_coditem, ls_bodega, ls_ubicacion
integer li_cont, li_cuenta = 0

For li_cont = 1 to dw_4.RowCount() 
//	 	ls_no_proforma = dw_6.GetItemString(li_cont,"dpro_no_proforma")
		ls_coditem = dw_4.Getitemstring(li_cont,"dpro_codigo_item")
		ls_bodega = dw_4.Getitemstring(li_cont,"dpro_bodega")
		ls_ubicacion = dw_4.Getitemstring(li_cont,"dpro_ubicacion")
//		ll_linea = This.GetItemNumber(li_cont,"dpro_linea")
		
		IF as_coditem = ls_coditem  and &
				as_codbodega = ls_bodega and &
					as_ubicacion = ls_ubicacion THEN	
//		If ls_no_proforma = ls_no_prof then
		  	DO
				li_cuenta++
				ls_no_prof = dw_1.GetItemString(li_cuenta,"fatprofo_prof_no_proforma")
				If ls_no_proforma = ls_no_prof Then
//					messagebox(""+string(li_cuenta) +"",ls_no_proforma +" / " + ls_no_prof)
//					dw_1.RowsCopy(li_cuenta,li_cuenta,Primary!,dw,1,Primary!)
				End If
			LOOP UNTIL (ls_no_proforma = ls_no_prof) Or (li_cuenta = dw_1.RowCount() )
			li_cuenta = 0
		End If
Next
end subroutine

public subroutine wf_cant_apasar (string ls_tipo);long 	ll_pasado, ll_unimin, ll_i, ll_cantidad, ll_fraccion, ll_row
string ls_uni

ll_row = dw_3.Rowcount()
If ll_row  < 0  then return

For ll_i = 1 to ll_row	
	ls_uni = dw_3.GetitemString(ll_i,"dpro_unidad_venta")
	ll_cantidad = dw_3.GetitemNumber(ll_i,"c_cant_pas")
	ll_fraccion = dw_3.GetitemNumber(ll_i,"c_cant_frac")
	
	gf_fa_convertmin_new(ll_unimin , ls_uni , ll_cantidad , ll_fraccion)
	dw_3.SetItem(ll_i,"c_a_pasar",ll_unimin)
	dw_3.SetItem(ll_i,"dpro_tipo",ls_tipo)

Next
end subroutine

public subroutine wf_caldisp (string as_coditem, string as_bodega, string as_ubicacion);// Función que prueba cuanto puede ser reservado
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
	
	ls_gitem   = dw_4.getitemstring(li_row,"dpro_codigo_item")
   ls_gbodega = dw_4.getitemString(li_row,"dpro_bodega")
   ls_gubicacion = dw_4.getitemString(li_row,"dpro_ubicacion")
		
	IF as_coditem = ls_gitem  and as_bodega = ls_gbodega and as_ubicacion = ls_gubicacion THEN
	    ls_uniac  = dw_4.GetItemString(li_row,"dpro_unidad_venta")
		
       SELECT isnull(inamedid.medi_cantidad,1)
       INTO	 :ll_mconvera
       FROM  inamedid  
       WHERE /*inamedid.medi_tipo_medida = :il_ucon and*/
             inamedid.medi_medida = :ls_uniac;
				 
		if sqlca.sqlcode = -1 then
			mensaje("Información1 (wf_caldisp)","Error al Seleccionar en inamedid",sqlca.sqlerrtext)
			return 
		end if					 
				 
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
	
	ls_gitem   = dw_4.getitemstring(li_row,"dpro_codigo_item", Delete!,False)
   ls_gbodega = dw_4.getitemString(li_row,"dpro_bodega", Delete!,False)
   ls_gubicacion = dw_4.getitemString(li_row,"dpro_ubicacion", Delete!,False)

	IF as_coditem = ls_gitem  and as_bodega = ls_gbodega and as_ubicacion = ls_gubicacion THEN
	    ls_uniac  = dw_4.GetItemString(li_row,"dpro_unidad_venta",Delete!,False)
		
       SELECT isnull(inamedid.medi_cantidad,1)
       INTO	 :ll_mconvera
       FROM  inamedid  
       WHERE /*inamedid.medi_tipo_medida = :il_ucon and*/
             inamedid.medi_medida = :ls_uniac;

		if sqlca.sqlcode = -1 then
			mensaje("Información2 (wf_caldisp)","Error al Seleccionar en inamedid",sqlca.sqlerrtext)
			return 
		end if					 

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
//     li_resp =	Messagebox("Advertencia",&
//	  "Para el Item " + as_coditem + " Bodega " + string(as_bodega)+ " Ubicación " + string(as_ubicacion)&
//	  +"~n ~n" + "Unted ha Intentado Reservar " + String(ll_acumulado) &
//	  +"~n " +"Solo se Dispone de " +  string(ll_diferencia)&
//	  +"~n "+"¿Esta Seguro que Quiere Exceder lo Disponible?",Question!,YesNo! ) 
//    End If
	
//   If li_resp = 2 Then
	  /*Verifica si la linea es nueva o modificada para retornar el valor anterior*/ 
//     If  l_rowstatus = NewModified! Then 
//		
//		 dw_4.SetItem(dw_4.Getrow(),"c_cant_frac",0) 
//	    dw_4.SetItem(dw_4.Getrow(),"c_cant_frac",0) 
//			 
//	  Else	
//		 
//	    dw_4.ReselectRow (dw_4.GetRow()) 
//	 
//     End If
//    
	    dw_4.AcceptText()
//	 
//    End If
End If	 
End If	
end subroutine

public function string wf_armar_sql (string ls_vienede);// Función que arma el Sql de el DataWindow, y dependiendo de donde se llama, profura o consultas
// Filtra segun parámetros iniciales o no
string ls_where, ls_original

ls_original = dw_1.GetsqlSelect()

if ls_vienede = "Proforma" then
   ls_where = wf_verificar(ls_original)
else		//Si es llamado de consultas
	if w_fa_fondo.str_para.afecta_consulta = 1 then		//Si los parámetros afectan consulta
	   ls_where = wf_verificar(ls_original)		
	else
		 ls_where = ls_original + " and  &
					 ( fatprofo.prof_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatprofo.prof_empresa = "+string(str.empresa)+" )"						 
	end if				 
end if
return(ls_where)
end function

public subroutine wf_efectuar_pase ();long 		ll_cantidad, ll_fraccion, ll_pasado, ll_convert, ll_unimini, &
			ll_unimin, ll_vendido, ll_totvenpas, ll_cont, ll_no_prof, ll_cliente, &
			ll_pasada, ll_cargo, ll_tot_bultos, ll_vendedor, ll_index, ll_bulto_inicio,&
			ll_bulto_fin, ll_disponible, ll_cant_a_pasar,ll_annio
			
			
string 	ls_item, ls_uni, ls_num_sec, ls_ruc_cli, ls_condi_pag, ls_tipomov, &
			ls_anombre, ls_direccion, ls_despachado, ls_via, ls_no_emb, ls_marca, ls_unidpeso, &
			ls_decu_subt_det, ls_supervi, ls_comentario, ls_estado, ls_prod_serv, ls_cod_item, &
         ls_desc_alter, ls_uni_peso, ls_uni_prod, ls_bodega, ls_uni_venta, ls_usuario, &
			ls_supervisor, ls_ubicacion, ls_no_proforma, ls_no_prof, ls_errtext,ls_tipo_fac, &
			ls_proforma, ls_tipo_profo, ls_proforma_new, ls_consignado, ls_prof_unica, &
			ls_factura_de_bodega, ls_user, ls_error, ls_origen
			
decimal	ld_montototal, ld_monto_final, ld_precio_my, ld_precio_mn, ld_costo_fob, &
			ld_costo_cif, ld_precio_uni, ld_monto_tot, ld_monto_fin, ld_monto, ld_tot_monto, &
			ld_tot_gastostot, ld_tot_montotot, ld_tot_montofin, ld_final, ld_precio, &
			ld_monto_tot_pas, &
			ld_tot_peso, ld_tot_cubicaje, ld_peso, ld_cubicaje, ld_costos_totales, ld_costo_total,&
			ld_precio_original, ld_precio2, ld_fact_costo_total, ld_costo_uni
			
integer 	li_tipovent, li_numtraspa, li_dias_pago, li_bultostotal,  li_vendedor, &
			li_pesototal, li_gastostot, li_por_descuento, li_linea, li_cantidad, &
			li_fraccion, li_por_desc, li_bultos, li_i, li_c, li_error, li_dbcode, &
			li_cuatro_decimales, li_precio_a_utilizar, li_existe, li_ann
			
dateTime ldt_fecha_pedido, ldt_fecha_crea, ldt_fecha_mod, ldt_fecha_reg, ldt_fecha_fin_plazo
Boolean	lb_pasada_totalmente


ll_annio = Long(Year(Date(gf_fecha_serv())))
dw_4.AcceptText()

if dw_4.RowCount() < 1 then 
	Mensaje("AVISO","No hay Proformas para efectuar el Pase a Pedido","")
	return
end if

lb_pasada_totalmente = true
ls_proforma = dw_4.GetItemString(1,"dpro_no_proforma")
ls_tipo_profo = dw_4.GetItemString(1,"dpro_tipo")

//For para Calcular las cantidades a pasar en su unidad minima y actualizar en el dw_4

for ll_cont = 1 to dw_4.Rowcount()
	
	ls_item = dw_4.Getitemstring(ll_cont,"dpro_codigo_item")
	
	ls_uni = dw_4.GetitemString(ll_cont,"dpro_unidad_venta")
	ll_cantidad = dw_4.GetitemNumber(ll_cont,"c_cant_pas")
	ll_fraccion = dw_4.GetitemNumber(ll_cont,"c_cant_frac")
//	ll_pasado = dw_4.GetitemNumber(ll_cont,"dpro_pasada")
	ll_pasado = dw_4.GetitemNumber(ll_cont,"dpro_pasada")
	ll_vendido = dw_4.GetitemNumber(ll_cont,"c_por_pasar")

	ll_unimin = 0

	if ll_cantidad = 0 and ll_fraccion = 0 then
		Mensaje("AVISO","La Cantidad y la Fraccion no pueden estar en Cero (0)",&
				  "Verifique en el Codigo de Item "+ ls_item +"")
		dw_4.SelectRow(0,FALSE)
		dw_4.SelectRow(ll_cont,TRUE)
		return
	else
		
		ll_totvenpas = ll_vendido - ll_pasado

//		ll_unimin = gf_fa_convertmin( ls_uni , ll_cantidad , ll_fraccion )
		// devuelve total de piezas
		ll_unimin= 0
		gf_fa_convertmin_new(ll_unimin, ls_uni , ll_cantidad , ll_fraccion )

		If ll_unimin  <= ll_totvenpas then
			dw_4.SetItem(ll_cont,"dpro_pasada",ll_unimin + ll_pasado)
		else
			Mensaje("ADVERTENCIA","Cantidad sobrepasada","")
			return
		end iF
//
		ll_cantidad = dw_4.GetitemNumber(ll_cont,"dpro_cantidad")
		ll_fraccion = dw_4.GetitemNumber(ll_cont,"dpro_fraccion")
		
		ll_unimini = 0
//		If ll_unimin + ll_pasado < gf_fa_convertmin( ls_uni , ll_cantidad , ll_fraccion ) then
		gf_fa_convertmin_new(ll_unimini, ls_uni , ll_cantidad , ll_fraccion )
		//VERIFICAR ESTA CONDICION
		If ll_unimin + ll_pasado < ll_unimini then
			lb_pasada_totalmente = false
		end IF
	end if
	
	ll_cantidad = 0
	ll_fraccion = 0
	ll_vendido  = 0
	ll_pasado	= 0
	ll_totvenpas= 0
next

//Para seleccionar el Encabezado de la Proforma
open(w_fa_selecprofor)

if message.Stringparm <> '' and message.Stringparm <> '0' and not isnull(message.Stringparm) then
	ls_no_prof = message.Stringparm
	//Para seleccionar la Secuencia en Pedidos
   openwithparm(w_fa_man_secped,ls_no_prof)
	
	If message.stringparm <> '0' then
		ls_num_sec = message.stringparm
		For li_i = 1 to dw_1.RowCount()
			If dw_1.GetItemString(li_i,"fatprofo_prof_no_proforma") = ls_no_prof then
				ii_ultgetrow = li_i
			End If
		Next
		
		li_ann		 	= dw_1.GetItemNumber(ii_ultgetrow,"fatprofo_prof_ann")
		ls_tipo_fac 	= dw_1.GetItemString(ii_ultgetrow,"fatprofo_prof_tipo")
		ll_cliente 		= dw_1.GetItemNumber(ii_ultgetrow,"fatprofo_prof_cliente")  
		ls_ruc_cli 		= dw_1.GetItemString(ii_ultgetrow,"fatprofo_prof_ruc_cliente")
		ls_condi_pag 	= dw_1.GetItemString(ii_ultgetrow,"fatprofo_prof_condicion_pago")   
		li_tipovent		= dw_1.GetItemNumber(ii_ultgetrow,"fatprofo_prof_tipo_venta")   
		ls_tipomov 		= dw_1.GetItemString(ii_ultgetrow,"fatprofo_prof_tipo_movimiento")   
		li_numtraspa 	= dw_1.GetItemNumber(ii_ultgetrow,"fatprofo_prof_no_traspaso")  

		ldt_fecha_pedido 	= datetime(date(gf_fecha_serv()))
		ldt_fecha_crea 	= ldt_fecha_pedido
		ldt_fecha_mod 		= ldt_fecha_pedido
		li_dias_pago 		= dw_1.GetItemNumber(ii_ultgetrow,"fatprofo_prof_dias_pago")  

		ls_anombre  		= dw_1.GetItemString(ii_ultgetrow,"fatprofo_prof_a_nombre") 
		ls_direccion  		= dw_1.GetItemString(ii_ultgetrow,"fatprofo_prof_a_nombre_direccion") 
		ls_despachado  	= dw_1.GetItemString(ii_ultgetrow,"fatprofo_prof_despachado")  
		ls_consignado		= dw_1.GetItemString(ii_ultgetrow,"fatprofo_prof_consignado")  
		ls_no_emb		   = dw_1.GetItemString(ii_ultgetrow,"fatprofo_prof_con_emb_no") 
		
		ls_via = dw_1.GetItemString(ii_ultgetrow,"fatprofo_prof_via")      
		
		ls_origen = dw_1.GetItemString(ii_ultgetrow,"prof_origen_venta")

		ls_marca  = dw_1.GetItemString(ii_ultgetrow,"fatprofo_prof_marca")      
		li_bultostotal = 0  
		ld_cubicaje   	= 0
		li_pesototal 	= 0
		ls_unidpeso 	= 	dw_1.GetItemString(ii_ultgetrow,"fatprofo_prof_unidad_peso")
		li_gastostot  	= 0
		ld_montototal 	= 0
		ls_decu_subt_det = dw_1.GetItemString(ii_ultgetrow,"fatprofo_prof_descu_subt_deta")   
		li_por_descuento = dw_1.GetItemNumber(ii_ultgetrow,"fatprofo_prof_por_descuento")    

		ls_comentario 	  = dw_1.GetItemString(ii_ultgetrow,"fatprofo_prof_comentario") 
		ls_estado = "A"
		ls_factura_de_bodega = dw_1.GetItemString(ii_ultgetrow,"prof_factura_de_bodega") 
		li_cuatro_decimales  = dw_1.GetItemNumber(ii_ultgetrow,"prof_cuatro_decimales")
		li_precio_a_utilizar = dw_1.Getitemnumber(ii_ultgetrow,"prof_precio_a_utilizar")
		ld_costos_totales    = dw_1.Getitemnumber(ii_ultgetrow,"prof_costos_total")
		ls_user					= dw_1.GetItemString(ii_ultgetrow,"prof_usuario") 
	
		ldt_fecha_fin_plazo = gf_recupera_dias(li_dias_pago, date(ldt_fecha_pedido))
	
		INSERT INTO fatpedid
			(pedi_g_financiero,
			pedi_empresa,
			pedi_tipo,
			pedi_no_pedido,
			pedi_ann,
			pedi_cliente,
			pedi_ruc_cliente,
			pedi_condicion_pago,
			pedi_tipo_venta,
			pedi_tipo_movimiento,
			pedi_no_traspaso,
			pedi_fecha,
			pedi_fecha_creacion,
			pedi_fecha_modificacion,
			pedi_dias_pago,
			pedi_consignado,
			pedi_a_nombre,
			pedi_a_nombre_direccion,
			pedi_despachado,
			pedi_via,
			pedi_con_emb_no,
			pedi_marca,
			pedi_bultos_total,
			pedi_cubicaje_total,
			pedi_peso_total,
			pedi_unidad_peso,
			pedi_gastos_total,
			pedi_monto_total,
			pedi_descu_subt_deta,
			pedi_por_descuento,
			pedi_supervisor,
			pedi_monto_final,
			pedi_comentario,
			pedi_estado,
         pedi_actualizo_cargos,   
         pedi_actualizo_vendedor,
			pedi_factura_de_bodega,
			pedi_cuatro_decimales,
			pedi_precio_a_utilizar,
			pedi_costos_total,
			pedi_usuario,
			pedi_fecha_fin_plazo,
			pedi_origen_venta)
		VALUES
			(:str.g_financiero,
			:str.empresa,
			:ls_tipo_fac,
			:ls_num_sec,
			:ll_annio,//w_fa_fondo.str_para.ano,
			:ll_cliente,
			:ls_ruc_cli,
			:ls_condi_pag,
			:li_tipovent,
			:ls_tipomov,
			:li_numtraspa,
			:ldt_fecha_pedido,
			:ldt_fecha_crea,
			:ldt_fecha_mod,
			:li_dias_pago,
			:ls_consignado,
			:ls_anombre,
			:ls_direccion,
			:ls_despachado,
			:ls_via,
			:ls_no_emb,
			:ls_marca,
			:li_bultostotal,
			:ld_cubicaje,
			:li_pesototal,
			:ls_unidpeso,
			:li_gastostot,
			:ld_montototal,
			:ls_decu_subt_det,
			:li_por_descuento,
			:ls_supervi,
			:ld_monto_final,
			:ls_comentario,
			:ls_estado,
			'S',
			'S',
			:ls_factura_de_bodega,
			:li_cuatro_decimales,
			:li_precio_a_utilizar,
			:ld_costos_totales,
			:ls_user,
			:ldt_fecha_fin_plazo,
			:ls_origen);
			
		if sqlca.sqlcode = -1 then
			li_dbcode = sqlca.sqldbcode
			ls_errtext = sqlca.sqlerrtext
			rollback using sqlca;
			messagebox("Error # "+string(li_dbcode),'Descripción del error: '+ls_errtext)
			return
		else

	// Cursor de cargos 
			declare cur_fadproca cursor for
			
			SELECT fadproca.prca_codigo_cargo, fadproca.prca_monto
			FROM fadproca
			WHERE ( fadproca.prca_g_financiero = :str.g_financiero ) AND
					( fadproca.prca_empresa = :str.empresa ) AND
					( fadproca.prca_ann = :li_ann ) AND
					( fadproca.prca_no_proforma = :ls_no_prof );
			
			if sqlca.sqlcode = -1 then
				mensaje("Información (wf_efectuar_pase)","Error al Seleccionar en fadproca",sqlca.sqlerrtext)
				return
			end if
			
			Open cur_fadproca;
			
			Fetch cur_fadproca into :ll_cargo, :ld_monto;
			
			if sqlca.sqlcode = -1 then
				ls_errtext = sqlca.sqlerrtext
				li_dbcode = sqlca.sqldbcode
				close cur_fadproca;

				Messagebox("Error # "+string(li_dbcode),"Error en la asignación de datos. "+&
								'Descripción del error'+ls_errtext)
				return
			end if
				
			Do While sqlca.sqlcode = 0
				
				INSERT INTO fadpecar  
					(peca_g_financiero,   
					peca_empresa,   
					peca_no_pedido,   
					peca_ann,   
					peca_codigo_cargo,   
					peca_monto )  
				VALUES
					(:str.g_financiero,   
					:str.empresa,   
					:ls_num_sec,   
					:ll_annio, //w_fa_fondo.str_para.ano,   
					:ll_cargo,   
					:ld_monto);
					
				if sqlca.sqlcode = -1 then
					li_dbcode = sqlca.sqldbcode
					ls_errtext = sqlca.sqlerrtext
					rollback using sqlca;
					close cur_fadproca;
					messagebox("Error # "+string(li_dbcode),'Descripción del error: '+ls_errtext)
					return
				end iF
					
				fetch cur_fadproca into :ll_cargo, :ld_monto;
				
				if sqlca.sqlcode = -1 then
					li_dbcode = sqlca.sqldbcode
					ls_errtext = sqlca.sqlerrtext
					rollback using sqlca;
					close cur_fadproca;
					messagebox("Error # "+string(li_dbcode),'Descripción del error: '+ls_errtext)
					return
				end if
				
			loop
			
			close cur_fadproca;
			
			// Cursor de vendedores
			declare cur_fadvenpe cursor for
			
			SELECT fadvenpr.vpro_tipo, fadvenpr.vpro_vendedor
			FROM fadvenpr
			WHERE ( fadvenpr.vpro_g_financiero = :str.g_financiero ) AND
					( fadvenpr.vpro_empresa = :str.empresa ) AND
					( fadvenpr.vpro_no_proforma = :ls_no_prof ) AND
					( fadvenpr.vpro_ann = :li_ann );
			
			if sqlca.sqlcode = -1 then
				li_dbcode = sqlca.sqldbcode
				ls_errtext = sqlca.sqlerrtext
				rollback using sqlca;
				mensaje("Error # "+string(li_dbcode),"Error en la Seleccionar de Datos", &
							'Descripción del error: '+ls_errtext)
				return
			end if
					
			Open cur_fadvenpe;
			
			Fetch cur_fadvenpe into :ls_tipo_fac,:ll_vendedor;
			
			if sqlca.sqlcode = -1 then
				li_dbcode = sqlca.sqldbcode
				ls_errtext = sqlca.sqlerrtext
				rollback using sqlca;
				close cur_fadvenpe;
				Messagebox("Error # "+string(li_dbcode),"Fallo en la asignación de los datos"+&
								'Descripción del error: '+ls_errtext)
				return
			end if
			
			Do While sqlca.Sqlcode = 0
				
				INSERT INTO fadvenpe
					(vped_g_financiero,   
					vped_empresa,   
					vped_tipo,   
					vped_no_pedido,   
					vped_ann,   
					vped_vendedor)  
				VALUES
					(:str.g_financiero,   
					:str.empresa, 
					:ls_tipo_fac,
					:ls_num_sec,   
					:ll_annio, //w_fa_fondo.str_para.ano,   
					:ll_vendedor);
						
				if sqlca.sqlcode = -1 then
					li_dbcode = sqlca.sqldbcode
					ls_errtext = sqlca.sqlerrtext
					rollback using sqlca;
					close cur_fadvenpe;
					messagebox("Error # "+string(li_dbcode),'Descripción del error: '+ls_errtext)
					return
				end if
				
				Fetch cur_fadvenpe into :ls_tipo_fac,:ll_vendedor;
				
				if sqlca.sqlcode = -1 then
					li_dbcode = sqlca.sqldbcode
					ls_errtext = sqlca.sqlerrtext
					rollback using sqlca;
					close cur_fadvenpe;
					messagebox("Error # "+string(li_dbcode),'Descripción del error: '+ls_errtext)
					return
				end if
				
			loop
							
			close cur_fadvenpe;	  
			
			ls_prof_unica = dw_4.GetItemString(1,"dpro_no_proforma")
			
			for li_i = 1 to dw_4.RowCount()
				ls_no_proforma = dw_4.GetItemString(li_i,"dpro_no_proforma")
				
				li_linea = dw_4.GetItemNumber(li_i,"dpro_linea")				
				ls_prod_serv  	= dw_4.GetItemString(li_i,"dpro_producto_servicio") 
				ls_cod_item  	= dw_4.GetItemString(li_i,"dpro_codigo_item") 
				ls_desc_alter  = dw_4.GetItemString(li_i,"dpro_descripcion_alterna")
				ld_cubicaje   	= truncate(round(dw_4.GetItemNumber(li_i,"dpro_cubucaje"),4),4)
				ld_peso   		= truncate(round(dw_4.GetItemNumber(li_i,"dpro_peso"),4),4)
				ls_uni_peso   	= dw_4.GetItemString(li_i,"dpro_unidad_peso")
				ls_uni_prod   	= dw_4.GetItemString(li_i,"dpro_unidad_producto")
				ld_precio_my  	= dw_4.GetItemNumber(li_i,"dpro_precio_mayor") 
				ld_precio_mn  	= dw_4.GetItemNumber(li_i,"dpro_precio_menor")
				ls_bodega 		= dw_4.GetItemString(li_i,"dpro_bodega")
				ld_costo_fob   = dw_4.GetItemNumber(li_i,"dpro_costo_fob")
				ld_costo_cif   = dw_4.GetItemNumber(li_i,"dpro_costo_cif")
				ld_precio_uni  = dw_4.GetItemNumber(li_i,"dpro_precio_unidad_producto")
				ls_uni_venta   = dw_4.GetItemString(li_i,"dpro_unidad_venta")
				li_vendedor    = dw_4.getitemnumber(li_i,"dpro_vendedor")
				ll_cantidad   	= dw_4.GetItemNumber(li_i,"c_cant_pas")
				li_fraccion   	= dw_4.GetItemNumber(li_i,"c_cant_frac")

//				ld_monto_tot   = dw_4.GetItemNumber(li_i,"dpro_monto_total")
				li_por_desc   	= dw_4.GetItemNumber(li_i,"dpro_por_descuento")
				ldt_fecha_reg  = dw_4.GetItemdatetime(li_i,"dpro_fecha_reg")
				ls_usuario   	= dw_4.GetItemString(li_i,"dpro_usuario")
				ls_supervisor  = dw_4.GetItemString(li_i,"dpro_supervisor")
				li_bultos   	= dw_4.GetItemNumber(li_i,"dpro_bultos")
				ls_ubicacion  	= dw_4.GetItemString(li_i,"dpro_ubicacion")
				ll_pasada 		= dw_4.GetItemNumber(li_i,"dpro_pasada")
				ll_bulto_inicio= dw_4.GetItemNumber(li_i,"dpro_bulto_inicio")
				ll_bulto_fin	= dw_4.GetItemNumber(li_i,"dpro_bulto_fin")
				
				ld_precio_original = dw_4.GetItemNumber(li_i,"dpro_precio_original")				
				ld_costo_total 	 = dw_4.GetItemNumber(li_i,"dpro_costo_total")				
				//para que cuando es mas de una proforma, el indice siga incrementandose
				if ls_prof_unica <> ls_no_proforma then
					ll_index ++
				else
					ll_index		   = dw_4.GetItemNumber(li_i,"dpro_index")
				end if
				
				ll_convert = gf_unidad_venta(ls_uni_venta,gf_medi_prod(ls_uni_prod))
				if ll_convert = 0 then ll_convert = 1
				ld_precio =  ld_precio_uni / ll_convert
			 	//El precio 2 es Para calcular los montos totales, cuando se aplica descuento
				ld_precio2 = ld_precio_original / ll_convert

				//Para el calculo del costo total por linea
				ll_cant_a_pasar = dw_4.GetItemNumber(li_i,"c_a_pasar")
				ld_costo_uni   = ld_costo_cif / ll_convert	//costo minimo
			   ld_costo_total = ld_costo_uni * ll_cant_a_pasar //costo total				 
				 
			 CHOOSE CASE ls_decu_subt_det
				CASE "D"
					ld_monto_tot_pas = round(ld_precio2 * dw_4.GetItemNumber(li_i,"c_a_pasar"),2)
					ld_monto_tot = ld_monto_tot_pas
					ld_monto_tot_pas = round(ld_precio * dw_4.GetItemNumber(li_i,"c_a_pasar"),2)
					ld_monto_fin =  ld_monto_tot_pas

//Lo que esta en comentario estaba antes, ahora calcula el monto final en base al precio
//del producto

//				   if li_por_desc <> 0 and not isnull(li_por_desc) then					
//						ld_monto_fin =  ld_monto_tot - (ld_monto_tot * (li_por_desc/100))
//					else
//						ld_monto_fin =  ld_monto_tot
//					end if
				CASE ELSE 
					ld_monto_tot_pas = round(ld_precio * dw_4.GetItemNumber(li_i,"c_a_pasar"),2)
					ld_monto_tot = ld_monto_tot_pas
					ld_monto_fin =  ld_monto_tot 
			 END CHOOSE
			 
	//calcula la disponibilidad a la fecha
		wf_calcula_disponible(ls_cod_item, ll_disponible, ll_cant_a_pasar)
			 
			INSERT INTO fadpedid  
         ( dped_g_financiero,   
           dped_empresa,   
           dped_no_pedido,   
           dped_ann,   
           dped_linea,   
           dped_producto_servicio,   
           dped_codigo_item,   
           dped_descripcion_alterna,   
           dped_cubicaje,   
           dped_peso,   
           dped_unidad_peso,   
           dped_unidad_producto,   
           dped_precio_mayor,   
           dped_precio_menor,   
           dped_bodega,   
           dped_costo_fob,   
           dped_costo_cif,   
           dped_precio_unidad_producto,   
           dped_unidad_venta,   
           dped_cantidad,   
           dped_fraccion,   
           dped_monto_total,   
           dped_por_descuento,   
           dped_monto_final,   
           dped_fecha_reg,   
           dped_usuario,   
           dped_supervisor,   
           dped_bultos,   
           dped_ubicacion,   
           dped_pasada,
			  dped_index,
			  dped_bulto_inicio,
			  dped_bulto_fin,
			  dped_precio_original,
			  dped_costo_total,
			  dped_disponible,
			  dped_vendedor)  
			  VALUES ( :str.g_financiero,   
						  :str.empresa,   
						  :ls_num_sec,
						  :ll_annio,//w_fa_fondo.str_para.ano,   
						  :li_i,   
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
						  :ls_ubicacion,   
						  0,
						  :ll_index,
						  :ll_bulto_inicio,
						  :ll_bulto_fin,
						  :ld_precio_original,
						  :ld_costo_total,
						  :ll_disponible,
						  :li_vendedor)  ;
			  
			  	If sqlca.sqlcode = -1 then
					li_dbcode = sqlca.sqldbcode
					ls_errtext = sqlca.sqlerrtext
				  	rollback using sqlca;
				  	messagebox("Error al insertar en detalle de pedido ",ls_errtext)
				  	return
				End If
				
				UPDATE fadprofo  
				  SET dpro_pasada = :ll_pasada 
				WHERE ( dpro_g_financiero = :str.g_financiero ) AND  
						( dpro_empresa = :str.empresa ) AND  
						( dpro_no_proforma = :ls_no_proforma ) AND
						( dpro_ann = :li_ann ) AND
						( dpro_linea = :li_linea) AND
						( dpro_codigo_item = :ls_cod_item) ;
						
				If sqlca.sqlcode = -1 then
					li_dbcode = sqlca.sqldbcode
					ls_errtext = sqlca.sqlerrtext
				  	rollback using sqlca;
					mensaje("Error al actualizar cantidad pasada",ls_errtext,"")
				  	return
				End If
			Next			
		End If //del sqlca.sqlcode = -1
	Else // del if message.stringparm <> '0'
		
		For li_c = 1 to dw_4.RowCount()
			dw_4.SetItem(li_c,"dpro_pasada",0)
		next
		Return
	End If
Else // del if message.Doubleparm <> 0
	For li_c = 1 to dw_4.RowCount()
		dw_4.SetItem(li_c,"dpro_pasada",0)
	next
	Return
End If

  SELECT sum(fadpedid.dped_bultos), 
         sum(fadpedid.dped_peso),   
         sum(fadpedid.dped_cubicaje),  
			sum(fadpedid.dped_monto_total),
			sum(fadpedid.dped_monto_final),
			sum(fadpedid.dped_costo_total)
    INTO :ll_tot_bultos,   
         :ld_tot_peso,   
         :ld_tot_cubicaje,
			:ld_tot_montotot,
			:ld_tot_montofin,
			:ld_fact_costo_total
    FROM fadpedid  
   WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
         ( fadpedid.dped_empresa = :str.empresa ) AND  
         ( fadpedid.dped_no_pedido = :ls_num_sec ) AND  
         ( fadpedid.dped_ann = :ll_annio ) ;
		
		If sqlca.sqlcode = -1 then
			ls_errtext = sqlca.sqlerrtext
			rollback using sqlca;
			mensaje("Error al obtener totales del pedido",ls_errtext,"")
			return
		End If
		
	SELECT sum(fadpecar.peca_monto)
	 INTO :ld_tot_gastostot
	 FROM fadpecar
	WHERE ( fadpecar.peca_g_financiero = :str.g_financiero ) AND  
         ( fadpecar.peca_empresa = :str.empresa ) AND   
         ( fadpecar.peca_no_pedido = :ls_num_sec ) AND
			( fadpecar.peca_ann = :ll_annio);
		
		If sqlca.sqlcode = -1 then
			ls_errtext = sqlca.sqlerrtext
			rollback using sqlca;
			mensaje("Error al obtener total del gasto",ls_errtext,"")
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
	
If li_error = -1 then
  	messagebox("Error",sqlca.sqlerrtext)
  	rollback using sqlca;
  	return
End If	
	
  UPDATE fatpedid  
     SET pedi_peso_total = :ld_tot_peso,   
         pedi_cubicaje_total = :ld_tot_cubicaje,   
         pedi_bultos_total = :ll_tot_bultos,   
         pedi_monto_total =  :ld_tot_montotot,
			pedi_gastos_total = :ld_tot_gastostot,
			pedi_monto_final = :ld_final,
			pedi_costos_total = :ld_fact_costo_total
	WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
         ( fatpedid.pedi_empresa = :str.empresa ) AND  
         ( fatpedid.pedi_no_pedido =  :ls_num_sec) AND  
         ( fatpedid.pedi_ann = :ll_annio )   ;

			If sqlca.sqlcode = -1 then
				ls_errtext = sqlca.sqlerrtext
				rollback using sqlca;
				mensaje("Error al setear totales en Fatpedid",ls_errtext,"")
				return
			End If
commit;	

mensaje("AVISO","Se ha efectuado el Pase Exitosamente","")
				
ll_cliente = idch_cliente.GetItemnumber(idch_cliente.GetRow(),"terc_tercero")

If dw_1.Retrieve(str.g_financiero,str.empresa,ll_cliente) < 1 then dw_3.Reset()

SELECT Count(*) 
 INTO :li_existe
 FROM fadprofo,
         fatprofo
   WHERE ( fatprofo.prof_g_financiero = fadprofo.dpro_g_financiero ) and
         ( fatprofo.prof_empresa = fadprofo.dpro_empresa ) and
         ( fatprofo.prof_no_proforma = fadprofo.dpro_no_proforma ) and
         ( fatprofo.prof_ann = fadprofo.dpro_ann ) and
			( fatprofo.prof_g_financiero = :str.g_financiero) AND
         ( fatprofo.prof_empresa = :str.empresa ) and
         ( fatprofo.prof_no_proforma = :ls_no_prof ) and
         ( fatprofo.prof_ann = :li_ann ) and
            fadprofo.dpro_pasada <  (fadprofo.dpro_fraccion + fadprofo.dpro_cantidad * (SELECT inamedid.medi_cantidad
   FROM    inamedid
   WHERE inamedid.medi_medida = fadprofo.dpro_unidad_venta)) ;
		If sqlca.sqlcode = -1 then
			ls_error =sqlca.sqlerrtext
			rollback using sqlca;
			mensaje("Error ","Error al verificar lo pasado "+ls_error,"")
			return
		End If

If li_existe = 0 then
	  UPDATE fatprofo  
		  SET prof_estado = "P"  
		WHERE ( fatprofo.prof_g_financiero = :str.g_financiero ) AND  
				( fatprofo.prof_empresa 	= :str.empresa ) AND  
				( fatprofo.prof_no_proforma 	= :ls_no_prof ) AND  
				( fatprofo.prof_ann = :li_ann )   ;

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

public function boolean wf_calcula_disponible (string as_producto, ref long al_disponible, long al_pedido);long ll_disponible, ll_existencia, ll_reserva

  SELECT isnull(inmprodu.prod_existencia_total  ,0)
    INTO :ll_existencia  
    FROM inmprodu  
   WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
         ( inmprodu.prod_empresa = :str.empresa ) AND  
         ( inmprodu.prod_producto = :as_producto )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al buscar existencias '+ sqlca.sqlerrtext,1,1,'E')
	end if

		declare sp_reserva procedure for fa_reservados_totaldos
		@g_financiero = :str.g_financiero ,
		@empresa = :str.empresa,
		@codigo_producto = :as_producto;
		
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al declarar cursor '+sqlca.sqlerrtext,1,1,'E')
			return false
		end if
		
		execute sp_reserva ;
		
		do while sqlca.sqlcode = 0
			fetch sp_reserva into :ll_reserva ;
		loop
		
		close sp_reserva ;
	
		if isnull(ll_reserva) then ll_reserva = 0	

		al_disponible = ll_existencia - ll_reserva - al_pedido

return true
end function

on w_fa_co_prof_pasa_ped.create
int iCurrent
call super::create
this.gb_nose=create gb_nose
this.gb_2=create gb_2
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.dw_2=create dw_2
this.rb_4=create rb_4
this.rb_5=create rb_5
this.rb_6=create rb_6
this.rb_7=create rb_7
this.pb_1=create pb_1
this.em_1=create em_1
this.em_2=create em_2
this.st_2=create st_2
this.st_3=create st_3
this.dw_3=create dw_3
this.pb_3=create pb_3
this.pb_4=create pb_4
this.dw_5=create dw_5
this.cb_1=create cb_1
this.cb_2=create cb_2
this.gb_4=create gb_4
this.dw_6=create dw_6
this.dw_4=create dw_4
this.st_1=create st_1
this.st_7=create st_7
this.st_8=create st_8
this.pb_2=create pb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_nose
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.rb_1
this.Control[iCurrent+4]=this.rb_2
this.Control[iCurrent+5]=this.rb_3
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.rb_4
this.Control[iCurrent+8]=this.rb_5
this.Control[iCurrent+9]=this.rb_6
this.Control[iCurrent+10]=this.rb_7
this.Control[iCurrent+11]=this.pb_1
this.Control[iCurrent+12]=this.em_1
this.Control[iCurrent+13]=this.em_2
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.st_3
this.Control[iCurrent+16]=this.dw_3
this.Control[iCurrent+17]=this.pb_3
this.Control[iCurrent+18]=this.pb_4
this.Control[iCurrent+19]=this.dw_5
this.Control[iCurrent+20]=this.cb_1
this.Control[iCurrent+21]=this.cb_2
this.Control[iCurrent+22]=this.gb_4
this.Control[iCurrent+23]=this.dw_6
this.Control[iCurrent+24]=this.dw_4
this.Control[iCurrent+25]=this.st_1
this.Control[iCurrent+26]=this.st_7
this.Control[iCurrent+27]=this.st_8
this.Control[iCurrent+28]=this.pb_2
this.Control[iCurrent+29]=this.gb_3
end on

on w_fa_co_prof_pasa_ped.destroy
call super::destroy
destroy(this.gb_nose)
destroy(this.gb_2)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.dw_2)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.rb_6)
destroy(this.rb_7)
destroy(this.pb_1)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_3)
destroy(this.pb_3)
destroy(this.pb_4)
destroy(this.dw_5)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.gb_4)
destroy(this.dw_6)
destroy(this.dw_4)
destroy(this.st_1)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.pb_2)
destroy(this.gb_3)
end on

event ue_post_open;// Overrride
string		ls_vienede, ls_where,ls_medact
long			ll_recupero

DataWindowChild child_produc

dw_1.SetTransObject(sqlca)
dw_2.SetTransObject(sqlca)
dw_3.SetTransObject(sqlca)
dw_4.SetTransObject(sqlca)
dw_6.SetTransObject(sqlca)

dw_2.InsertRow(0)
dw_2.setfocus()
dw_2.SetColumn("texto")

dw_3.GetChild('dpro_codigo_item',child_produc)
child_produc.SetTransObject(sqlca)
child_produc.Retrieve(str.g_financiero,str.empresa)

dw_4.GetChild('dpro_codigo_item',child_produc)
child_produc.SetTransObject(sqlca)
child_produc.Retrieve(str.g_financiero,str.empresa)

dw_4.GetChild("dpro_unidad_venta", idw_child_uni)
idw_child_uni.setTransObject(sqlca)
idw_child_uni.Retrieve()

dw_5.Accepttext()
dw_5.GetChild("notercero",idch_cliente)

idch_cliente.SetTransObject(sqlca)
dw_6.InsertRow(0)

SELECT count(*)
INTO :ll_recupero
FROM ccmclien
WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND
		( ccmclien.clie_empresa = :str.empresa );
			
if sqlca.sqlcode = -1 then
	mensaje("Información","Error al Seleccionar el número de registros de la tabla ccmclien",'Descripción del error: '+sqlca.sqlerrtext)
	return
end if

if ll_recupero < 1 then
	idch_cliente.InsertRow(0)
else
	idch_cliente.Retrieve(str.g_financiero,str.empresa)
end if

dw_5.ScrollToRow(dw_5.InsertRow(0))
dw_5.SetFocus()

pb_2.DisabledName = str.path+"\art\pasar_rp.bmp"
pb_2.Enabled = false

str.frame.SetMicroHelp("Seleccione una Línea y Presione la Tecla Enter para Cargar la Información")

end event

event open;//Override
this.y = 5
st_nom_ventana.text = this.classname()
this.triggerevent("ue_post_open")

end event

event resize;// Comentario utilizado para colocar el OverRide

end event

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_co_prof_pasa_ped
boolean visible = false
integer x = 18
integer y = 1628
long backcolor = 74481808
end type

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_co_prof_pasa_ped
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_co_prof_pasa_ped
event ue_down pbm_dwnkey
event ue_post ( )
integer y = 108
integer width = 2871
integer height = 404
integer taborder = 120
string dataobject = "dw_co_fa_proapasar"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

event dw_1::doubleclicked;call super::doubleclicked;//This.Postevent("ue_entercol")
end event

event dw_1::rowfocuschanged;//Recupera los datos del detalle haciendi referencia al encabezado
//Jorge Herrera 28/04/1999
String ls_prof, ls_tipo
Integer li_ano, li_rows

this.SelectRow(0,FALSE)
this.SelectRow(currentrow,TRUE)

li_rows = this.RowCount()
If this.RowCount() < 1 Or currentrow = 0 then return
If currentrow = this.GetRow() Then

ls_prof = GetitemString(currentrow ,"fatprofo_prof_no_proforma")
li_ano =  GetitemNumber(currentrow ,"fatprofo_prof_ann")
ls_tipo = GetitemString(currentrow ,"fatprofo_prof_tipo")
parent.SetRedraw(False)
dw_3.Retrieve(str.g_financiero,str.empresa,ls_prof,li_ano)
wf_cant_apasar(ls_tipo)
parent.SetRedraw(true)

End If

str.frame.setmicrohelp('Fila '+string(currentrow)+' de '+string(this.RowCount()))

end event

event dw_1::clicked;/*Jorge Herrera*/      //Fecha: 24/2/99

String ls_prof, ls_tipo
Integer li_ano

If this.RowCount() < 1 Or Row = 0 then return

this.SelectRow(0,FALSE)
this.SelectRow(row,TRUE)

ls_prof = GetitemString(row ,"fatprofo_prof_no_proforma")
li_ano =  GetitemNumber(row ,"fatprofo_prof_ann")
ls_tipo = GetitemString(row ,"fatprofo_prof_tipo")

this.SetRedraw(False)
dw_3.Retrieve(str.g_financiero,str.empresa,ls_prof,li_ano)
wf_cant_apasar(ls_tipo)
this.SetRedraw(True)

idw_cual = this
pb_3.Text = "PASAR TODOS"
pb_4.enabled = false
ii_escpri = 0

end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_co_prof_pasa_ped
integer x = 23
integer y = 24
integer width = 2912
integer height = 504
integer taborder = 0
long textcolor = 8388608
long backcolor = 74481808
string text = "Encabezado"
end type

type gb_nose from groupbox within w_fa_co_prof_pasa_ped
integer x = 27
integer y = 532
integer width = 2363
integer height = 400
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 74481808
string text = "Detalle"
end type

type gb_2 from groupbox within w_fa_co_prof_pasa_ped
integer x = 18
integer y = 1452
integer width = 2377
integer height = 168
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
string text = "Búsquedas"
end type

type rb_1 from radiobutton within w_fa_co_prof_pasa_ped
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

type rb_2 from radiobutton within w_fa_co_prof_pasa_ped
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

type rb_3 from radiobutton within w_fa_co_prof_pasa_ped
event clicked pbm_bnclicked
integer x = 965
integer y = 1512
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

type dw_2 from datawindow within w_fa_co_prof_pasa_ped
event editchanged pbm_dwnchanging
integer x = 1449
integer y = 1504
integer width = 773
integer height = 92
integer taborder = 100
boolean bringtotop = true
string dataobject = "dw_texto"
boolean border = false
boolean livescroll = true
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
	Formato =  "fatprofo_prof_a_nombre like " +"'"+data+"%"+"'"
	
ELSEIF rb_4.Checked = True THEN /*Proforma*/
	Formato =  "fatprofo_prof_no_proforma like " +"'"+data+"%"+"'"	

ELSEIF rb_5.Checked = True THEN /*Estado*/
		
	Formato =  "estado like " +"'"+data+"%"+"'"

ELSEIF rb_6.Checked = True THEN /*Fecha*/
	Formato =  " date(fatprofo_prof_fecha) Between " + &
	                  "Date(" + "'" + em_1.text + "'" + ")" + " And " + & 
					"Date("+ "'" +em_2.text +"'"+")"

ELSEIF rb_7.Checked = True THEN /*Vendedor*/
	Formato =  "nombre like " +"'"+data+"%"+"'"

//ELSE /*Proforma*/
//	Formato =  "String("  + "fatprofo_prof_no_proforma)"  + "like "  +"'"+data+"%"+"'"
END IF

If Formato <> "" Then
	dw_1.Setfilter(formato)
	dw_1.Filter()
	If dw_1.RowCount() > 0 Then dw_3.Reset()
//		dw_1.Trigger Event RowFocusChanged(1)

End If


end event

type rb_4 from radiobutton within w_fa_co_prof_pasa_ped
integer x = 485
integer y = 1516
integer width = 325
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 74481808
string text = "Proforma"
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()

end event

type rb_5 from radiobutton within w_fa_co_prof_pasa_ped
integer x = 64
integer y = 1512
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

type rb_6 from radiobutton within w_fa_co_prof_pasa_ped
boolean visible = false
integer x = 1115
integer y = 1516
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

type rb_7 from radiobutton within w_fa_co_prof_pasa_ped
boolean visible = false
integer x = 955
integer y = 1516
integer width = 411
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 74481808
string text = "Vendedor"
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()

end event

type pb_1 from picturebutton within w_fa_co_prof_pasa_ped
event clicked pbm_bnclicked
boolean visible = false
integer x = 2235
integer y = 1512
integer width = 101
integer height = 88
integer taborder = 110
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

type em_1 from editmask within w_fa_co_prof_pasa_ped
boolean visible = false
integer x = 1600
integer y = 1512
integer width = 256
integer height = 84
integer taborder = 80
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

type em_2 from editmask within w_fa_co_prof_pasa_ped
boolean visible = false
integer x = 1975
integer y = 1512
integer width = 256
integer height = 84
integer taborder = 90
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

type st_2 from statictext within w_fa_co_prof_pasa_ped
boolean visible = false
integer x = 1422
integer y = 1512
integer width = 183
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Entre"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_fa_co_prof_pasa_ped
boolean visible = false
integer x = 1874
integer y = 1512
integer width = 87
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "y"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_fa_co_prof_pasa_ped
event ue_lbuttonup pbm_dwnlbuttonup
integer x = 82
integer y = 592
integer width = 2258
integer height = 328
integer taborder = 140
boolean bringtotop = true
string dataobject = "dw_co_fa_profpasped"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
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
pb_3.Text = "PASAR"
pb_4.enabled = false
ii_clicked = row
//messagebox("",row)
//this.SelectRow(0,FALSE)
//this.SelectRow(row,TRUE)
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
String  ls_uni, ls_item,ls_profor,ls_cod_item
long    ll_cantidad, ll_fraccion,ll_conv, ll_i, ll_pasado,ll_cant_pas,  ll_c, &
		  ll_anno,ll_linea, ll_unimin
Integer li_rows
long	  ll_cant_frac

this.SetRedraw(False)
this.SetFilter("")
this.Filter()

li_rows = this.RowCount()

For ll_i = 1 to li_rows

	ls_item = This.Getitemstring(ll_i,"dpro_codigo_item")
	ls_uni = This.GetitemString(ll_i,"dpro_unidad_venta")
	ll_cantidad = This.GetitemNumber(ll_i,"dpro_cantidad")
	ll_fraccion = This.GetitemNumber(ll_i,"dpro_fraccion")
	ll_pasado = This.GetitemNumber(ll_i,"dpro_pasada")

//	ll_unimin = gf_fa_convertmin( ls_uni , ll_cantidad , ll_fraccion )
	ll_unimin = 0
	gf_fa_convertmin_new(ll_unimin, ls_uni , ll_cantidad , ll_fraccion )

//	gf_fa_convertuni(ls_uni,ll_unimin - ll_pasado,ll_cant_pas,ld_cant_frac)
	gf_fa_convertuni_new(ls_uni, ll_unimin - ll_pasado ,ll_cant_pas , ll_cant_frac)

	this.SetItem(ll_i,"c_cant_pas",ll_cant_pas)
	this.SetITem(ll_i,"c_cant_frac",ll_cant_frac)
	this.SetItem(ll_i,"c_por_pasar",ll_unimin)
Next

this.SetFilter("c_cant_pas > 0 OR c_cant_frac > 0")
this.Filter()

If dw_4.RowCount() > 0 then
li_rows = this.RowCount()
For ll_c = 1 to dw_4.RowCount()
	ls_profor = dw_4.getItemString(ll_c,"dpro_no_proforma")
	ll_anno = dw_4.getItemNumber(ll_c,"dpro_ann")
	ll_linea =  dw_4.getItemNumber(ll_c,"dpro_linea")
	ls_cod_item =  dw_4.getItemString(ll_c,"dpro_codigo_item")
	
	For ll_i = 1 to li_rows
		
		If This.Getitemstring(ll_i,"dpro_codigo_item") = ls_cod_item AND &
			This.Getitemnumber(ll_i,"dpro_linea") = ll_linea AND &
			This.Getitemnumber(ll_i,"dpro_ann") = ll_anno AND &
			This.GetitemString(ll_i,"dpro_no_proforma") = ls_profor Then
			this.Deleterow(ll_i)
			ll_i = ll_i - 1
			li_rows = this.RowCount()
		End IF
	Next
Next
End If

this.SetRedraw(True)
end event

event rowfocuschanged;str.frame.setmicrohelp('Fila '+string(currentrow)+' de '+string(this.RowCount()))

end event

type pb_3 from picturebutton within w_fa_co_prof_pasa_ped
integer x = 2441
integer y = 696
integer width = 430
integer height = 108
integer taborder = 170
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "PASAR"
end type

event clicked;parent.Triggerevent("ue_pasarow")

end event

type pb_4 from picturebutton within w_fa_co_prof_pasa_ped
integer x = 2441
integer y = 1088
integer width = 430
integer height = 108
integer taborder = 150
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "RETORNAR"
end type

event clicked;parent.Triggerevent("ue_pasarow")

end event

type dw_5 from datawindow within w_fa_co_prof_pasa_ped
event ue_key pbm_dwnkey
integer x = 50
integer y = 8
integer width = 1257
integer height = 96
integer taborder = 130
boolean bringtotop = true
string dataobject = "dw_dd_fa_clientes_proformas"
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
					dw_1.Retrieve(str.g_financiero,str.empresa,ll_clien)
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
	dw_3.Reset()
Else
	pb_2.pictureName = str.path +"\art\pasar_rp.bmp"
	pb_2.enabled = true
End IF
end event

type cb_1 from commandbutton within w_fa_co_prof_pasa_ped
boolean visible = false
integer x = 2505
integer y = 828
integer width = 247
integer height = 108
integer taborder = 190
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;//gf_next_sec("0","RC")
end event

type cb_2 from commandbutton within w_fa_co_prof_pasa_ped
boolean visible = false
integer x = 2501
integer y = 952
integer width = 247
integer height = 108
integer taborder = 200
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;
disconnect ;
end event

type gb_4 from groupbox within w_fa_co_prof_pasa_ped
integer x = 18
integer y = 956
integer width = 2373
integer height = 492
integer taborder = 210
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 74481808
string text = "Pasar"
end type

type dw_6 from datawindow within w_fa_co_prof_pasa_ped
integer x = 64
integer y = 1352
integer width = 2258
integer height = 80
integer taborder = 180
boolean bringtotop = true
string dataobject = "dw_man_fa_exist"
boolean border = false
boolean livescroll = true
end type

type dw_4 from datawindow within w_fa_co_prof_pasa_ped
event ue_key pbm_dwnkey
event ue_postkey ( )
integer x = 82
integer y = 1016
integer width = 2258
integer height = 332
integer taborder = 220
boolean bringtotop = true
string dataobject = "dw_co_fa_profpasped"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_key;//string ls_columna
//
//ls_columna = This.GetColumnName()
//
//If ls_columna = "c_cant_pas" Or ls_columna = "c_cant_frac" then
//	
//
////	this.PostEvent("ue_postKey")
//	
//End IF
//
end event

event ue_postkey;//long 	ll_cantidad, ll_fraccion, &
//		ll_pasado, ll_unimin, ll_vendido, &
//		ll_totvenpas, ll_linea, ll_row, ll_cont
//string 	ls_coditem, ls_bodega, ls_ubicacion, ls_uni, &
//			ls_coditem2, ls_bodega2, ls_ubicacion2, ls_nomcolumna
//			
//ll_row = this.Rowcount()
//ls_nomcolumna = this.GetColumnName()
//If ll_row  < 1  then return
//
//this.GetText()
//This.AcceptText()
//
//ls_coditem = This.Getitemstring(this.GetRow(),"dpro_codigo_item")
//ls_bodega = This.Getitemstring(this.GetRow(),"dpro_bodega")
//ls_ubicacion = This.Getitemstring(this.GetRow(),"dpro_ubicacion")
//
//ls_uni = This.GetitemString(this.GetRow(),"dpro_unidad_venta")
//ll_cantidad = This.GetitemNumber(this.GetRow(),"c_cant_pas")
//ll_fraccion = This.GetitemNumber(this.GetRow(),"c_cant_frac")
//ll_pasado = This.GetitemNumber(this.GetRow(),"dpro_pasada")
//ll_vendido = This.GetitemNumber(this.GetRow(),"c_por_pasar")
//
//messagebox("frac",ll_fraccion)
//
////ll_unimin = gf_fa_convertmin( ls_uni , ll_cantidad , ll_fraccion )
//
//ll_totvenpas = ll_vendido - ll_pasado
//
//ll_unimin = gf_fa_convertmin( ls_uni , ll_cantidad , ll_fraccion )
//
//
//If  ll_unimin  <= ll_totvenpas then
//	this.SetItem(this.GetRow(),"c_a_pasar",ll_unimin)
//	
////	If ll_row  > 1 then
////
////	For ll_cont = 1 to ll_row
////		
////		If this.GetRow() <> ll_cont then
////					
////			ls_coditem2 = dw_4.Getitemstring(ll_cont,"dpro_codigo_item")
////			ls_bodega2 = dw_4.Getitemstring(ll_cont,"dpro_bodega")
////			ls_ubicacion2 = dw_4.Getitemstring(ll_cont,"dpro_ubicacion")
////			
////			IF ls_coditem = ls_coditem2  and &
////					ls_bodega = ls_bodega2 and &
////						ls_ubicacion = ls_ubicacion2 THEN	
////				ib_flag = true
////				wf_profident(ls_coditem,ls_bodega,ls_ubicacion)
////			End IF
////		End IF
////	Next 		
////	End If
//	
//Else
//	Mensaje("ADVERTENCIA","Cantida sobrepasada","")
//	If ls_nomcolumna = "c_cant_pas" then
//		this.ReselectRow(this.GetRow())
//	ElseIf ls_nomcolumna = "c_cant_frac" then
//		this.ReselectRow(this.GetRow())
//	End IF
//	
////gf_fa_convertuni(ls_uni,ll_unimin - ll_pasado,ll_cant_pas,ll_cant_frac)
////this.SetItem(this.GetRow(),"c_cant_pas",ll_cant_pas)
////this.SetITem(this.GetRow(),"c_cant_frac",ll_cant_frac)
//End IF
//
end event

event clicked;idw_cual = this
pb_4.Text = "RETORNAR"
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
	ls_coditem = This.Getitemstring(this.GetRow(),"dpro_codigo_item")
	ls_bodega = This.Getitemstring(this.GetRow(),"dpro_bodega")
	ls_ubicacion = This.Getitemstring(this.GetRow(),"dpro_ubicacion")
	ll_linea = This.GetItemNumber(this.GetRow(),"dpro_linea")
	
	If ll_row  > 1 then
	For ll_cont = 1 to ll_row - 1
		
		ls_coditem2 = dw_4.Getitemstring(ll_cont,"dpro_codigo_item")
		ls_bodega2 = dw_4.Getitemstring(ll_cont,"dpro_bodega")
		ls_ubicacion2 = dw_4.Getitemstring(ll_cont,"dpro_ubicacion")

		
		IF ls_coditem = ls_coditem2  and &
				ls_bodega = ls_bodega2 and &
					ls_ubicacion = ls_ubicacion2 THEN	
					ib_flag = true
		End IF
	Next 
	End If
	
//	messagebox("Find",this.Find("dpro_codigo_item = '"+ls_coditem + "' AND dpro_bodega = '"+ls_bodega+ "' AND dpro_ubicacion = '"+ls_ubicacion +"'", 1,this.RowCount()))
 
// 
// 	ls_medactual = this.GetItemString(currentrow,"dpro_unidad_producto")
// 
//   SELECT inamedid.medi_tipo_medida  
//    INTO :ll_ucom  
//    FROM inamedid  
//   WHERE inamedid.medi_medida = :ls_medactual   ;
//
//	ls_filtro = "medi_tipo_medida ="+ string(ll_ucom)
	
//	idw_child_uni.Filter()
	

//If this.Rowcount() > 0 then
//messagebox("",this.GetRow())
//messagebox("",this.GetcolumnName())

ls_coditem = This.Getitemstring(this.GetRow(),"dpro_codigo_item")
ls_bodega = This.Getitemstring(this.GetRow(),"dpro_bodega")
ls_ubicacion = This.Getitemstring(this.GetRow(),"dpro_ubicacion")
ll_linea = This.GetItemNumber(this.GetRow(),"dpro_linea")


//If dw_6.Retrieve(str.g_financiero,str.empresa,ls_coditem,ls_bodega,ls_ubicacion) <> 1 then return

dw_6.SetFilter("mbod_producto = '"+ls_coditem + "' AND mbod_bodega = '"+ls_bodega+ "' AND mbod_ubicacion = '"+ls_ubicacion +"'")
dw_6.Filter()

//wf_caldisp(ls_coditem,ls_bodega,ls_ubicacion, ll_linea)
End If

str.frame.setmicrohelp('Fila '+string(currentrow)+' de '+string(this.RowCount()))

end event

event itemfocuschanged;string ls_coditem, ls_bodega, ls_ubicacion
long  ll_linea

If this.Rowcount() > 0 then
	ls_coditem = This.Getitemstring(row,"dpro_codigo_item")
	ls_bodega = This.Getitemstring(row,"dpro_bodega")
	ls_ubicacion = This.Getitemstring(row,"dpro_ubicacion")
	
	If dw_6.Retrieve(str.g_financiero,str.empresa,ls_coditem,ls_bodega,ls_ubicacion) <> 1 then return
	wf_caldisp(ls_coditem,ls_bodega,ls_ubicacion)
End If



end event

event editchanged;long 	ll_pasado, ll_unimin, ll_vendido, 	ld_totvenpas, &
		ll_totvenpas, ll_linea, ll_row, ll_cont
string 	ls_coditem, ls_bodega, ls_ubicacion, ls_uni, &
			ls_coditem2, ls_bodega2, ls_ubicacion2, ls_nomcolumna
ll_row = this.Rowcount()

ls_nomcolumna = this.GetColumnName()

If ll_row  < 1  then return

CHOOSE CASE ls_nomcolumna
	CASE "c_cant_pas"
		il_cantidad = long(this.GetText())
		il_fraccion = This.GetitemNumber(Row,"c_cant_frac")
	CASE "c_cant_frac"
		il_fraccion = long(this.GetText())
		il_cantidad = This.GetitemNumber(Row,"c_cant_pas")
END CHOOSE

ls_uni = This.GetitemString(Row,"dpro_unidad_venta")
ll_pasado = This.GetitemNumber(Row,"dpro_pasada")
ll_vendido = This.GetitemNumber(Row,"c_por_pasar")

ll_totvenpas = ll_vendido - ll_pasado
//ld_unimin = gf_fa_convertmin( ls_uni , il_cantidad , id_fraccion )
ll_unimin = 0	// devuelve total de piezas
gf_fa_convertmin_new(ll_unimin, ls_uni , il_cantidad , il_fraccion )

If  ll_unimin  <= ll_totvenpas then
	this.SetItem(Row,"c_a_pasar",ll_unimin)
Else
	Mensaje("ADVERTENCIA","Cantida sobrepasada","")
	If ls_nomcolumna = "c_cant_pas" then
		this.SetItem(row,"c_cant_pas",This.GetitemNumber(Row,"c_cant_pas",Primary!,true))
	ElseIf ls_nomcolumna = "c_cant_frac" then
		this.SetITem(row,"c_cant_frac",This.GetitemNumber(Row,"c_cant_frac",Primary!,true))
	End IF
//	ld_unimin = gf_fa_convertmin( ls_uni ,This.GetitemNumber(Row,"c_cant_pas",Primary!,true) ,&
//	This.GetitemNumber(Row,"c_cant_frac",Primary!,true)) )
	ll_unimin = 0	// devuelve total de piezas
	gf_fa_convertmin_new(ll_unimin, ls_uni , This.GetitemNumber(Row,"c_cant_pas",Primary!,true) , This.GetitemNumber(Row,"c_cant_frac",Primary!,true))
					
End IF
end event

type st_1 from statictext within w_fa_co_prof_pasa_ped
integer x = 2427
integer y = 684
integer width = 453
integer height = 128
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_7 from statictext within w_fa_co_prof_pasa_ped
integer x = 2427
integer y = 1076
integer width = 453
integer height = 128
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_8 from statictext within w_fa_co_prof_pasa_ped
integer x = 2528
integer y = 1368
integer width = 256
integer height = 228
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_fa_co_prof_pasa_ped
integer x = 2542
integer y = 1376
integer width = 233
integer height = 208
integer taborder = 230
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\harr2000\art\pasar_rp.bmp"
alignment htextalign = left!
end type

event clicked;parent.TriggerEvent("ue_pase")

end event

type gb_3 from groupbox within w_fa_co_prof_pasa_ped
integer x = 2418
integer y = 1300
integer width = 471
integer height = 320
integer taborder = 160
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 74481808
string text = "Ejecutar el Pase"
end type

