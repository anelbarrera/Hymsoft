//objectcomments Para restaurar el pase de una proforma a pedidos
forward
global type w_fa_man_restaurar_lista_empaque from w_fa_padre
end type
type gb_anio from groupbox within w_fa_man_restaurar_lista_empaque
end type
type cb_1 from commandbutton within w_fa_man_restaurar_lista_empaque
end type
type cb_2 from commandbutton within w_fa_man_restaurar_lista_empaque
end type
type st_1 from statictext within w_fa_man_restaurar_lista_empaque
end type
type dw_2 from datawindow within w_fa_man_restaurar_lista_empaque
end type
type st_2 from statictext within w_fa_man_restaurar_lista_empaque
end type
type em_desde from editmask within w_fa_man_restaurar_lista_empaque
end type
type st_3 from statictext within w_fa_man_restaurar_lista_empaque
end type
type em_hasta from editmask within w_fa_man_restaurar_lista_empaque
end type
end forward

global type w_fa_man_restaurar_lista_empaque from w_fa_padre
integer width = 1591
integer height = 916
string title = "(FA) Restaurar Lista de Empaque"
string menuname = "m_hs"
boolean controlmenu = false
long backcolor = 79741120
event ue_enter pbm_dwndragenter
gb_anio gb_anio
cb_1 cb_1
cb_2 cb_2
st_1 st_1
dw_2 dw_2
st_2 st_2
em_desde em_desde
st_3 st_3
em_hasta em_hasta
end type
global w_fa_man_restaurar_lista_empaque w_fa_man_restaurar_lista_empaque

type variables
// Para el filtro de la unidad
datawindowchild idwc_tipo, dwc_fac_prof
String is_ped_sel, is_fact_sel, is_tipo_repl,is_tipo_sel, is_pedido_repl, is_user
Integer ii_ann_sel, ii_ann_repl
end variables

forward prototypes
public subroutine wf_setear_user (string as_user)
public subroutine wf_botones ()
end prototypes

public subroutine wf_setear_user (string as_user);//se asigna el usuario desde la ventana de clave con Dynamic
is_user = as_user
end subroutine

public subroutine wf_botones ();//// Deshabilita la opcion de insertar del menu 

//   /*Insertar*/
//	m_fa_padre.m_edicin.m_insertar.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_insertar.visible=false
	
//	/*Filtrar*/
//	m_fa_padre.m_edicin.m_filtrar.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_filtrar.visible=false
	
//	/*Sortear*/
//	m_fa_padre.m_edicin.m_sortear.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_sortear.visible=false
	
//  /*Imprimir*/
//   m_fa_padre.m_archivo.m_imprimir.toolbaritemvisible=false
//	m_fa_padre.m_archivo.m_imprimir.visible=false

	
	
//	/*Eliminar*/
////	m_fa_padre.m_edicin.m_eliminar.toolbaritemvisible=false
////	
	
////	/*Adicionar*/
////	m_fa_padre.m_edicin.m_adicionar.toolbaritemvisible=false
////	
	
////	/*Primer Reg*/
////	m_fa_padre.m_edicin.m_primerregistro.toolbaritemvisible=false
////	
	
////	/*Ultimo Reg*/
////	m_fa_padre.m_edicin.m_ultimoregistro.toolbaritemvisible=false
////	
	
	
////	/*Sig Reg*/
////	m_fa_padre.m_edicin.m_siguienteregistro.toolbaritemvisible=false
////	
	
////	/*Reg Ant*/
////	m_fa_padre.m_edicin.m_registroanterior.toolbaritemvisible=false
////	
	
////	

  


end subroutine

on w_fa_man_restaurar_lista_empaque.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.gb_anio=create gb_anio
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_1=create st_1
this.dw_2=create dw_2
this.st_2=create st_2
this.em_desde=create em_desde
this.st_3=create st_3
this.em_hasta=create em_hasta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_anio
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.em_desde
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.em_hasta
end on

on w_fa_man_restaurar_lista_empaque.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_anio)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.em_desde)
destroy(this.st_3)
destroy(this.em_hasta)
end on

event ue_post_open;//Override
date ld_desde, ld_hasta
is_nombre = This.ClassName()

dw.settransobject(sqlca)

st_nom_ventana.text = is_nombre

/*ADDED BY HGN/05/07/2002*/ //cambio inicio
	
	
if pos( upper(str.empr_acceso_especial),'ACISA,') >0 then
	
	String	ls_autoriza_s_n,ls_autoriza
 is_user =''
	 if w_fa_fondo.str_aplica_links.controla_modificaciones =1 then /*Controla modificaciones*/	
		is_user ='yes'
		openwithparm(w_dg_man_clave,ls_autoriza)
		
		ls_autoriza_s_n = Message.StringParm 
		
		CHOOSE CASE ls_autoriza_s_n
		CASE '1'	//Usuario Autorizado
		CASE '2'	//Usuario no Autorizado
			messagebox('Atención ','Estimado Usuario Ud. no está autorizado para Restaurar Lista de Empaque, consulte a su Supervisor...!!!')
			close(this)
			return
		CASE ELSE
			close(this)
			return
		END CHOOSE
	
		end if
end if
//cambio final
		
	dw_1.settransobject(sqlca)
	dw_1.GetChild ("enca_lista_empaque",dwc_fac_prof)
	dwc_fac_prof.Settransobject(SQLCA);
	if dw_1.rowcount() > 0 then
		dw_1.reset()
	else
		em_hasta.text = string(date(gf_fecha_serv()))
		em_desde.text = string(relativedate(date(gf_fecha_serv()), - 360))
	end if
	ld_desde = date(em_desde.text)
	ld_hasta = relativedate(date(em_hasta.text)	, 1)
	
	if dwc_fac_prof.retrieve(str.g_financiero,str.empresa, ld_desde, ld_hasta) = 0 then
		dwc_fac_prof.insertrow(0)
	end if
	dw_1.insertrow(0)
	dw_1.SetFocus()
	dw_2.settransobject(sqlca)

end event

event show;
wf_botones()

end event

event closequery;//destroy io_encryptor
constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)

This.SetRedraw(false)
end event

event resize;//Override
end event

event close; 
Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
 
end event

event open;call super::open;IF Trim(Message.StringParm) <> "" THEN
	This.Tag = Trim(Message.StringParm)
END IF
end event

event activate;gnv_seg.of_aplicar_acciones_ventana(w_hs_frame.rbb_1, this.tag)
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_man_restaurar_lista_empaque
boolean visible = false
integer x = 14
integer y = 760
integer width = 736
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_man_restaurar_lista_empaque
event ue_filtra_unidad ( )
integer x = 434
integer y = 340
integer width = 581
integer height = 88
string dataobject = "dw_fa_man_restaurar_lista_empaque"
boolean border = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_1::getfocus;dw = dw_1


end event

event dw_1::rbuttondown;//
end event

event dw_1::itemchanged;call super::itemchanged;is_tipo_repl = data
end event

event dw_1::ue_microayuda;//override

end event

type st_ayuda from w_fa_padre`st_ayuda within w_fa_man_restaurar_lista_empaque
integer y = 540
end type

type gb_anio from groupbox within w_fa_man_restaurar_lista_empaque
integer x = 27
integer width = 1454
integer height = 508
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
end type

type cb_1 from commandbutton within w_fa_man_restaurar_lista_empaque
integer x = 773
integer y = 540
integer width = 247
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
boolean default = true
end type

event clicked;String 	ls_lista_empaque,ls_no_factura, ls_tipo_fac, ls_error,&
		 	ls_restaurado_por, ls_no_pedido, ls_uni_venta, ls_producto, ls_bodega, ls_ubicacion 
long 		ll_anio, ll_row, ll_existe, ll_cant_frac
Integer 	li_anio_ped, li_linea, li_lin_ref, li_rebajo = 0
Decimal{2}	ld_empa_cantidad, ld_pasada_uni, ld_reserva, ld_porcentaje,ld_pasado_demas = 0,ld_desreserva
Boolean	lb_validado,lb_salvo
date		ldt_fecha, ld_desde, ld_hasta

lb_validado = true
lb_salvo = false

if gf_mensaje("","¿Está Seguro de Restaurar la Lista de Empaque Seleccionada ?",2,1,"E") = 1 then
	
	ls_lista_empaque = dwc_fac_prof.GetItemString(dwc_fac_prof.Getrow(),"enca_lista_empaque")
	ll_anio		 = dwc_fac_prof.GetItemNumber(dwc_fac_prof.Getrow(),"enca_ann")

	ls_no_pedido = dwc_fac_prof.GetItemString(dwc_fac_prof.Getrow(),"enca_no_pedido")
	li_anio_ped	 = dwc_fac_prof.GetItemNumber(dwc_fac_prof.Getrow(),"enca_ann_pedido")

	ldt_fecha = date(gf_fecha_serv())
	ls_restaurado_por = str.usuario+"-"+string(ldt_fecha)
	
  sqlca.autocommit = false

  UPDATE fatempaq
     SET enca_pasado = 'N',
	  		enca_pase_fact = 0 
   WHERE ( fatempaq.enca_g_financiero = :str.g_financiero ) AND  
         ( fatempaq.enca_empresa = :str.empresa ) AND  
         ( fatempaq.enca_lista_empaque = :ls_lista_empaque ) AND  
         ( fatempaq.enca_ann = :ll_anio )   ;
			
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al Activar la Lista de Empaque",ls_error)
			sqlca.autocommit = true
			return
		end if
		
		//TEXTILERAS
		// ADDED BY HGN 31/08/01
		if pos(upper(str.nombre_empresa),'TEXTILES') > 0 OR &
			pos(upper(str.nombre_empresa),'VISION TEX') > 0  THEN

			//if pos(upper(str.nombre_empresa),'TEXTILES') > 0 then
			//	ld_porcentaje = 0.80
			//else
			//	ld_porcentaje = 0.85
			//end if
			
			/*Desmarca la lista de empaque para que pueda ser pasada a factura otra vez */
			
		  UPDATE fatempaq
			  SET enca_pase_fact = 0   
			WHERE ( fatempaq.enca_g_financiero = :str.g_financiero ) AND  
					( fatempaq.enca_empresa = :str.empresa ) AND  
					( fatempaq.enca_lista_empaque = :ls_lista_empaque) AND
					( fatempaq.enca_ann =  :ll_anio) ;
		
				If sqlca.sqlcode = -1 then
					ls_error =sqlca.sqlerrtext
					rollback using sqlca;
					mensaje("Error ","Error al desmarcar la Lista de Empaque como Pasada "+ls_error,"")
					sqlca.autocommit = true	
					return
				End If
				
			/*Rebajar de lo pasado del pedido lo que esta salvado en fadempaq*/
			If dw_2.retrieve(str.g_financiero,str.empresa,ll_anio,ls_lista_empaque) > 0  then
				li_rebajo = 0
				For ll_row = 1 to dw_2.rowcount()
					li_linea    = dw_2.GetItemNumber(ll_row,"empa_linea_original")		
					ld_empa_cantidad = round(dw_2.GetItemNumber(ll_row,"empa_cantidad"),2)		
					
					ld_desreserva = 	ld_empa_cantidad	//Cant a rebajar de inmprodu		
					ls_producto = dw_2.getitemstring(ll_row, 'empa_codigo_producto')
					ls_bodega	= dw_2.getitemstring(ll_row, 'empa_bodega')
					ls_ubicacion= dw_2.getitemstring(ll_row, 'empa_ubicacion')

					/*Si empa_cantidad < dped_cantidad y esta entre 80% y 100% 
					sumar la diferencia a lo pasado*/

				  SELECT fadpedid.dped_cantidad  
					 INTO :ld_reserva  
					 FROM fadpedid
					WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
							( fadpedid.dped_empresa = :str.empresa ) AND  
							( fadpedid.dped_ann = :li_anio_ped ) AND  
							( fadpedid.dped_no_pedido = :ls_no_pedido ) AND  
							( fadpedid.dped_linea = :li_linea )  ;

							If sqlca.sqlcode = -1 then
								ls_error =sqlca.sqlerrtext
								rollback using sqlca;
								mensaje("Error ","Error al leer cantidad reservada fadpedid"+ls_error,"")
								sqlca.autocommit = true	
								return
							end if
							
					If isNull(ld_reserva) then ld_reserva = 0
					ld_reserva = round(ld_reserva,2)
					
		//			if ld_empa_cantidad >= round(ld_reserva*ld_porcentaje,2) and ld_empa_cantidad <= round(ld_reserva,2) then
		//				ld_pasado_demas  =  ld_empa_cantidad - ld_reserva
		//				ld_desreserva = ld_reserva
		//			end if

					ls_uni_venta = dw_2.GetItemString(ll_row,"empa_unidad")		
					
					ll_cant_frac = 0
			  		gf_fa_convertmin_new_deci(ld_pasada_uni,ls_uni_venta,ld_empa_cantidad,ll_cant_frac)

					ld_pasada_uni = round(ld_pasada_uni,2)

				  UPDATE fadpedid
					  SET dped_pasada = (dped_pasada - :ld_pasada_uni)
					WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
							( fadpedid.dped_empresa = :str.empresa ) AND  
							( fadpedid.dped_ann = :li_anio_ped ) AND  
							( fadpedid.dped_no_pedido = :ls_no_pedido ) AND  
							( fadpedid.dped_linea = :li_linea )  ;

							If sqlca.sqlcode = -1 then
								ls_error =sqlca.sqlerrtext
								rollback using sqlca;					
								mensaje("Error ","Error al rebajar lo pasado del pedido "+ls_error,"")
								sqlca.autocommit = true
								return
							else
								li_rebajo = 1
							End If												
						//Actualiza la reserva en el Producto, al restaurar la lista de empaque
							
					  UPDATE inmprodu  
						  SET prod_reserva_total = prod_reserva_total  + :ld_pasada_uni  
						WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
								( inmprodu.prod_empresa = :str.empresa ) AND  
								( inmprodu.prod_producto = :ls_producto ) ;
								
							If sqlca.sqlcode = -1 then
								ls_error =sqlca.sqlerrtext
								rollback using sqlca;
								mensaje("Error ","Error al Aumentar la Reserva en Productos "+ls_error,"")
								sqlca.autocommit = true								
								return
							End if
					
						//Actualiza la reserva en el Producto de la bodega, al restaurar la lista de empaque
						
						  UPDATE inmbodeg  
							  SET mbod_reserva = mbod_reserva + :ld_pasada_uni  
							WHERE ( inmbodeg.mbod_g_financiero = :str.g_financiero ) AND  
									( inmbodeg.mbod_empresa = :str.empresa ) AND  
									( inmbodeg.mbod_bodega = :ls_bodega ) AND  
									( inmbodeg.mbod_ubicacion = :ls_ubicacion ) AND  
									( inmbodeg.mbod_producto = :ls_producto )  ; 
						
							If sqlca.sqlcode = -1 then
								ls_error =sqlca.sqlerrtext
								rollback using sqlca;
								mensaje("Error ","Error al Aumentar la Reserva en Productos por bodega"+ls_error,"")
								sqlca.autocommit = true								
								return
							End if					
		
				Next
				
				IF li_rebajo = 1 then
				  UPDATE fatpedid  
					  SET pedi_estado = 'A'  
					WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
							( fatpedid.pedi_empresa = :str.empresa ) AND  
							( fatpedid.pedi_ann = :li_anio_ped) AND  
							( fatpedid.pedi_no_pedido = :ls_no_pedido ) ;
			
					If sqlca.sqlcode = -1 then
						ls_error =sqlca.sqlerrtext
						rollback using sqlca;
						mensaje("Error ","Error al marcar estado del Pedido como Activo "+ls_error,"")
						sqlca.autocommit = true						
						return
					End If
				end if //del li_rebajo = 1
				
			end if //Del si Recupera mas de un Registro de la Lista de Empaque
			
		ELSE	//Para los clientes que no son textileras
			
			/*Rebajar de lo pasado del pedido lo que esta salvado en fadempaq*/
			If dw_2.retrieve(str.g_financiero,str.empresa,ll_anio,ls_lista_empaque) > 0  then
				li_rebajo = 0
				For ll_row = 1 to dw_2.rowcount()
					li_linea    = dw_2.GetItemNumber(ll_row,"empa_linea_original")		
					ld_empa_cantidad = round(dw_2.GetItemNumber(ll_row,"empa_cantidad"),2)	
					ls_producto = dw_2.getitemstring(ll_row, 'empa_codigo_producto')
					ls_bodega	= dw_2.getitemstring(ll_row, 'empa_bodega')
					ls_ubicacion= dw_2.getitemstring(ll_row, 'empa_ubicacion')
					
				  UPDATE fadpedid
					  SET dped_pasada = (dped_pasada - :ld_empa_cantidad)
					WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
							( fadpedid.dped_empresa = :str.empresa ) AND  
							( fadpedid.dped_ann = :li_anio_ped ) AND  
							( fadpedid.dped_no_pedido = :ls_no_pedido ) AND  
							( fadpedid.dped_linea = :li_linea )  ;

							If sqlca.sqlcode = -1 then
								ls_error =sqlca.sqlerrtext
								rollback using sqlca;
								mensaje("Error ","Error al rebajar lo pasado del pedido "+ls_error,"")
								sqlca.autocommit = true
								return
							else
								li_rebajo = 1
							End If
						
						//Actualiza la reserva en el Producto, al restaurar la lista de empaque
							
					  UPDATE inmprodu  
						  SET prod_reserva_total = prod_reserva_total  + :ld_empa_cantidad  
						WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
								( inmprodu.prod_empresa = :str.empresa ) AND  
								( inmprodu.prod_producto = :ls_producto ) ;
								
							If sqlca.sqlcode = -1 then
								ls_error =sqlca.sqlerrtext
								rollback using sqlca;
								mensaje("Error ","Error al Aumentar la Reserva en Productos "+ls_error,"")
								sqlca.autocommit = true								
								return
							End if
					
						//Actualiza la reserva en el Producto de la bodega, al restaurar la lista de empaque
						
						  UPDATE inmbodeg  
							  SET mbod_reserva = mbod_reserva + :ld_empa_cantidad  
							WHERE ( inmbodeg.mbod_g_financiero = :str.g_financiero ) AND  
									( inmbodeg.mbod_empresa = :str.empresa ) AND  
									( inmbodeg.mbod_bodega = :ls_bodega ) AND  
									( inmbodeg.mbod_ubicacion = :ls_ubicacion ) AND  
									( inmbodeg.mbod_producto = :ls_producto )  ; 
						
							If sqlca.sqlcode = -1 then
								ls_error =sqlca.sqlerrtext
								rollback using sqlca;
								mensaje("Error ","Error al Aumentar la Reserva en Productos por bodega"+ls_error,"")
								sqlca.autocommit = true								
								return
							End if					
		
				Next
				
				IF li_rebajo = 1 then
				  UPDATE fatpedid  
					  SET pedi_estado = 'A'  
					WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
							( fatpedid.pedi_empresa = :str.empresa ) AND  
							( fatpedid.pedi_ann = :li_anio_ped) AND  
							( fatpedid.pedi_no_pedido = :ls_no_pedido ) ;
			
					If sqlca.sqlcode = -1 then
						ls_error =sqlca.sqlerrtext
						rollback using sqlca;
						mensaje("Error ","Error al marcar estado del Pedido como Activo "+ls_error,"")
						sqlca.autocommit = true
						return
					End If
				end if //del li_rebajo = 1
				
			end if //Del si Recupera mas de un Registro de la Lista de Empaque		
			
		END IF	//Para las Textileras
		
	commit;
	
	sqlca.autocommit = true

	gf_mensaje("","Actualización Exitosa",1,1,"E")
	//gf_mensaje("","Debe proceder a borrar la factura correspondiente a esta lista de empaque..",1,1,"E")
	ld_desde = date(em_desde.text)
	ld_hasta = date(em_hasta.text)	

	if dwc_fac_prof.retrieve(str.g_financiero,str.empresa, ld_desde, ld_hasta) = 0 then
		dwc_fac_prof.insertrow(0)
	end if
	
	dw_1.reset()
	dw_1.InsertRow(1)	
	
end if //Del mensaje de seguridad
end event

type cb_2 from commandbutton within w_fa_man_restaurar_lista_empaque
integer x = 1051
integer y = 540
integer width = 265
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;close(parent)
end event

type st_1 from statictext within w_fa_man_restaurar_lista_empaque
integer x = 151
integer y = 232
integer width = 1207
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
string text = "No. de la Lista de Empaque a Restaurar"
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_fa_man_restaurar_lista_empaque
boolean visible = false
integer x = 69
integer y = 756
integer width = 1243
integer height = 220
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_fa_recupera_asignado_lemp_pedido"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_fa_man_restaurar_lista_empaque
integer x = 37
integer y = 72
integer width = 430
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
string text = "Fechas:    Desde:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_desde from editmask within w_fa_man_restaurar_lista_empaque
integer x = 485
integer y = 60
integer width = 370
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79416533
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

event modified;parent.triggerevent('ue_post_open')
end event

type st_3 from statictext within w_fa_man_restaurar_lista_empaque
integer x = 878
integer y = 76
integer width = 160
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
string text = "Hasta:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_hasta from editmask within w_fa_man_restaurar_lista_empaque
integer x = 1088
integer y = 56
integer width = 343
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79416533
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

event modified;parent.triggerevent('ue_post_open')
end event

