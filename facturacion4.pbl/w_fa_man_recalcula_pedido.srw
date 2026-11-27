//objectcomments Recalcula el Peso y/o el Cubicaje del Pedido
forward
global type w_fa_man_recalcula_pedido from w_fa_padre
end type
type gb_anio from groupbox within w_fa_man_recalcula_pedido
end type
type cb_1 from commandbutton within w_fa_man_recalcula_pedido
end type
type cb_2 from commandbutton within w_fa_man_recalcula_pedido
end type
type st_1 from statictext within w_fa_man_recalcula_pedido
end type
type cbx_cubicaje from checkbox within w_fa_man_recalcula_pedido
end type
type cbx_peso from checkbox within w_fa_man_recalcula_pedido
end type
type em_desde from editmask within w_fa_man_recalcula_pedido
end type
type st_2 from statictext within w_fa_man_recalcula_pedido
end type
type st_3 from statictext within w_fa_man_recalcula_pedido
end type
type em_hasta from editmask within w_fa_man_recalcula_pedido
end type
end forward

global type w_fa_man_recalcula_pedido from w_fa_padre
integer width = 1669
integer height = 836
string title = " Recalcular Peso y/o Cubicaje del Pedido"
string menuname = "m_hs"
boolean controlmenu = false
long backcolor = 79741120
event ue_enter pbm_dwndragenter
gb_anio gb_anio
cb_1 cb_1
cb_2 cb_2
st_1 st_1
cbx_cubicaje cbx_cubicaje
cbx_peso cbx_peso
em_desde em_desde
st_2 st_2
st_3 st_3
em_hasta em_hasta
end type
global w_fa_man_recalcula_pedido w_fa_man_recalcula_pedido

type variables
// Para el filtro de la unidad
datawindowchild idwc_tipo, dwc_fac_pedi
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

on w_fa_man_recalcula_pedido.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.gb_anio=create gb_anio
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_1=create st_1
this.cbx_cubicaje=create cbx_cubicaje
this.cbx_peso=create cbx_peso
this.em_desde=create em_desde
this.st_2=create st_2
this.st_3=create st_3
this.em_hasta=create em_hasta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_anio
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cbx_cubicaje
this.Control[iCurrent+6]=this.cbx_peso
this.Control[iCurrent+7]=this.em_desde
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.em_hasta
end on

on w_fa_man_recalcula_pedido.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_anio)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.cbx_cubicaje)
destroy(this.cbx_peso)
destroy(this.em_desde)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.em_hasta)
end on

event ue_post_open;//Override
date ld_desde, ld_hasta
is_nombre = This.ClassName()

dw.settransobject(sqlca)

st_nom_ventana.text = is_nombre

//OpenWithParm(w_fa_man_clave_pedido, this)
//
//If is_user = "*" then
//	close(this)
//else
	
		
	dw_1.settransobject(sqlca)
	dw_1.GetChild ("pedi_no_pedido",dwc_fac_pedi)
	dwc_fac_pedi.Settransobject(SQLCA);
	if dw_1.rowcount()  = 0 then
		em_hasta.text = string(date(gf_fecha_serv()))
		em_desde.text = string(relativedate(date(gf_fecha_serv()), - 360))
	else
		dw_1.reset()
	end if
	ld_desde = date(em_desde.text)
	ld_hasta = date(em_hasta.text)	
	if dwc_fac_pedi.retrieve(str.g_financiero,str.empresa, ld_desde, ld_hasta) = 0 then
		dwc_fac_pedi.insertrow(0)
	end if
	dw_1.insertrow(0)
	
	//dw_1.retrieve(str.g_financiero, str.empresa)
	dw_1.SetFocus()
//End if
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

event activate;call super::activate;gnv_seg.of_aplicar_acciones_ventana(w_hs_frame.rbb_1, this.tag)
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_man_recalcula_pedido
boolean visible = false
integer x = 27
integer y = 524
integer width = 709
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_man_recalcula_pedido
event ue_filtra_unidad ( )
integer x = 443
integer y = 256
integer width = 617
integer height = 88
string dataobject = "dw_dd_fa_costos_pedidos"
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

type st_ayuda from w_fa_padre`st_ayuda within w_fa_man_recalcula_pedido
integer y = 492
end type

type gb_anio from groupbox within w_fa_man_recalcula_pedido
integer x = 27
integer width = 1545
integer height = 480
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
end type

type cb_1 from commandbutton within w_fa_man_recalcula_pedido
integer x = 777
integer y = 492
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
end type

event clicked;String ls_no_pedido,ls_no_factura, ls_tipo_fac, ls_error, ls_habilitada_por, ls_codigo_item, &
		 ls_medac,ls_univen, ls_uniprod, ls_unidad_peso, ls_unidad_empaque
double ld_resultado, ld_cubifin, ld_total_minimo, ld_gecan, ld_gecubi, ld_cubi, ld_peso, ld_empaque
long ll_anio, ll_linea, ll_total,  ll_gefrac, ll_mconverc, ll_mconverb, il_ucom, ll_mconvera
Boolean	lb_validado,lb_salvo
date	 ld_desde, ld_hasta
lb_validado = true
lb_salvo = false
date		ldt_fecha

if not cbx_cubicaje.checked and not cbx_peso.checked then 
	mensaje("Aviso","Debe Seleccionar que requiere actualizar (Peso y/o cubicaje)","")
	return
end if

if gf_mensaje("","¿Está Seguro de Actualizar el Pedido ?",2,1,"E") = 1 then
	
	ls_no_pedido = dwc_fac_pedi.GetItemString(dwc_fac_pedi.Getrow(),"pedi_no_pedido")
	ll_anio		 = dwc_fac_pedi.GetItemNumber(dwc_fac_pedi.Getrow(),"pedi_ann")

	ldt_fecha = date(gf_fecha_serv())	

	/*PARA RECALCULAR EL CUBICAJE DE LA FACTURA SELECCIONADA*/	
	

	 DECLARE cur_pedidos CURSOR FOR  
	  SELECT fadpedid.dped_linea,   
				fadpedid.dped_codigo_item,   
				fadpedid.dped_cubicaje,   
				fadpedid.dped_peso,   
				fadpedid.dped_unidad_producto,   
				fadpedid.dped_unidad_venta,   
				fadpedid.dped_cantidad,   
				fadpedid.dped_fraccion  
		 FROM fadpedid  
		WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
				( fadpedid.dped_empresa = :str.empresa ) AND  
				( fadpedid.dped_no_pedido = :ls_no_pedido ) AND  
				( fadpedid.dped_ann = :ll_anio )   ;
			
		if sqlca.sqlcode = -1 then
			mensaje("Aviso","Error al declarar el cursor con el detalle de la factura",sqlca.sqlerrtext)
			return
		end if

		open cur_pedidos;
		if sqlca.sqlcode = -1 then
			mensaje("Aviso","Error al Abrir el cursor con el detalle del Pedido",sqlca.sqlerrtext)
			return
		end if
		
		

		FETCH cur_pedidos INTO :ll_linea, :ls_codigo_item, :ld_cubi, :ld_peso, :ls_uniprod, :ls_univen, :ld_gecan, :ll_gefrac;

		if sqlca.sqlcode = -1 then
			mensaje("Aviso","Error al asignar las variables del cursor",sqlca.sqlerrtext)
			return
		end if		
		
		sqlca.autocommit = true	//Que no bloquee
		
		DO WHILE sqlca.sqlcode = 0
	
			/*Selecciona algunos datos necesarios del producto*/
			  SELECT inmprodu.prod_peso,   
						inmprodu.prod_cubicaje,   
						inmprodu.prod_empaque,   
						inmprodu.prod_empaque_um,   
						inmprodu.prod_peso_unidad_medida  
				 INTO :ld_peso,   
						:ld_cubi,   
						:ld_empaque,   
						:ls_unidad_empaque,   
						:ls_unidad_peso  
				 FROM inmprodu  
				WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
						( inmprodu.prod_empresa = :str.empresa ) AND  
						( inmprodu.prod_producto = :ls_codigo_item ) ;
				if sqlca.sqlcode = -1 then
					mensaje("Aviso","Error al declarar el cursor con el detalle del Pedido",sqlca.sqlerrtext)
					return
				end if									
		
			//Tipo de medida de la unidad del producto	(UNIDADES, UNIDAD DE PESO, CONVERSIONES, ETC)	 
 			il_ucom = gf_medi_prod(ls_uniprod)

			//* Carga Los Datos de Converción de la Unidad del Producto a la Nueva unidad o 
			// Cantidad de unidades minimas de la unidade de venta
			ll_mconverb = gf_unidad_prod(ls_uniprod, il_ucom)
		   if ll_mconverb	= 0 then ll_mconverb = 1		

			//* cantidad de unidades minimas que tiene la unidad del producto
	      ll_mconvera = gf_unidad_venta(ls_univen, il_ucom)			  			 

			//Valor del empaque																				
			ll_mconverc = gf_unidad_venta(ls_unidad_empaque, il_ucom)			
			if ll_mconverc = 0 or isnull(ll_mconverc) then ll_mconverc = 1				
	
		//		Total minimo del cubicaje
				if ld_empaque = 0 or isnull(ld_empaque) then ld_empaque = 1
				ld_total_minimo = ld_cubi / ld_empaque / ll_mconverc
	
				if isnull(ld_total_minimo) then ld_total_minimo = 0			
				
				//total de cantidad en unidad minima																		
				ll_total = ld_gecan * ll_mconvera + ll_gefrac	
				
				ld_resultado = round(ll_total   *  ld_total_minimo ,4)
			 
			 //Si selecciono actualizar el cubicaje
			 if cbx_cubicaje.checked then
			  /*Actualiza el cubicaje de la linea de detalle de la factura*/
				  UPDATE fadpedid
					  SET dped_cubicaje = :ld_resultado  
					WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
							( fadpedid.dped_empresa = :str.empresa ) AND  
							( fadpedid.dped_no_pedido = :ls_no_pedido ) AND  
							( fadpedid.dped_ann = :ll_anio ) AND
							( fadpedid.dped_codigo_item = :ls_codigo_item) AND 
							( fadpedid.dped_linea = :ll_linea );
					
					if sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrtext
						rollback;
						mensaje("Aviso","Error al actualizar el cubicaje del Pedido",ls_error)
						sqlca.autocommit = true
						return
					end if
				end if
				
		//		Total minimo del Peso
				if ld_empaque = 0 or isnull(ld_empaque) then ld_empaque = 1
				ld_total_minimo = ld_peso / ld_empaque / ll_mconverc
				if isnull(ld_total_minimo) then ld_total_minimo = 0
				
				//El total de las cantidades se calcula arriba, solo una vez
				ld_resultado = round(ll_total   *  ld_total_minimo ,4)

			 //Si selecciono actualizar el peso
			 if cbx_peso.checked then
				  /*Actualiza el peso de la linea de detalle de la factura*/
				  UPDATE fadpedid
					  SET dped_peso = :ld_resultado  
					WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
							( fadpedid.dped_empresa = :str.empresa ) AND  
							( fadpedid.dped_no_pedido = :ls_no_pedido ) AND  
							( fadpedid.dped_ann = :ll_anio ) AND
							( fadpedid.dped_codigo_item = :ls_codigo_item) AND 
							( fadpedid.dped_linea = :ll_linea );
						
					if sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrtext
						rollback;
						mensaje("Aviso","Error al actualizar el Peso del Pedido",ls_error)
						sqlca.autocommit = true
						return
					end if
				end if								

			FETCH cur_pedidos INTO :ll_linea, :ls_codigo_item, :ld_cubi, :ld_peso, :ls_uniprod, :ls_univen, :ld_gecan, :ll_gefrac;
			
			if sqlca.sqlcode = -1 then
				mensaje("Aviso","Error al asignar las variables del cursor",sqlca.sqlerrtext)
				return
			end if		
			
		LOOP

	close cur_pedidos;	
		
	  UPDATE fatpedid
		  SET pedi_cubicaje_total = (	select sum( fadpedid.dped_cubicaje) 
												 FROM fadpedid 							
										WHERE ( fatpedid.pedi_g_financiero = fadpedid.dped_g_financiero ) and 
												( fatpedid.pedi_empresa = fadpedid.dped_empresa ) and 
												( fatpedid.pedi_no_pedido = fadpedid.dped_no_pedido ) and 
												( fatpedid.pedi_ann = fadpedid.dped_ann ) ),
		  		pedi_peso_total = (	select sum( fadpedid.dped_peso) 
												 FROM fadpedid 							
										WHERE ( fatpedid.pedi_g_financiero = fadpedid.dped_g_financiero ) and 
												( fatpedid.pedi_empresa = fadpedid.dped_empresa ) and 
												( fatpedid.pedi_no_pedido = fadpedid.dped_no_pedido ) and 
												( fatpedid.pedi_ann = fadpedid.dped_ann ) )		 		 
		FROM fatpedid
		where	( ( fatpedid.pedi_g_financiero= :str.g_financiero ) AND  
				( fatpedid.pedi_empresa 		= :str.empresa ) AND  
				( fatpedid.pedi_no_pedido 		= :ls_no_pedido ) AND  
				( fatpedid.pedi_ann 				= :ll_anio )  ) ;		
				
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al actualizar el Peso y Cubicaje en el Encabezado del Pedido",ls_error)
			sqlca.autocommit = true
			return
		end if
		
	/*PARA RECALCULAR EL CUBICAJE DE LA FACTURA SELECCIONADA*/					
	sqlca.autocommit = true

	gf_mensaje("","Actualización Exitosa",1,1,"E")
	
	dw_1.GetChild ("pedi_no_pedido",dwc_fac_pedi)
	dwc_fac_pedi.Settransobject(SQLCA);
	ld_desde = date(em_desde.text)
	ld_hasta = date(em_hasta.text)	
	dwc_fac_pedi.retrieve(str.g_financiero,str.empresa, ld_desde, ld_hasta)
	dw_1.reset()
	dw_1.InsertRow(0)	
	
end if
end event

type cb_2 from commandbutton within w_fa_man_recalcula_pedido
integer x = 1042
integer y = 492
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

type st_1 from statictext within w_fa_man_recalcula_pedido
integer x = 229
integer y = 172
integer width = 1093
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
string text = "No. del Pedido"
alignment alignment = center!
boolean focusrectangle = false
end type

type cbx_cubicaje from checkbox within w_fa_man_recalcula_pedido
integer x = 448
integer y = 368
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Cubicaje"
end type

type cbx_peso from checkbox within w_fa_man_recalcula_pedido
integer x = 823
integer y = 372
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Peso"
end type

type em_desde from editmask within w_fa_man_recalcula_pedido
integer x = 603
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

type st_2 from statictext within w_fa_man_recalcula_pedido
integer x = 69
integer y = 72
integer width = 507
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

type st_3 from statictext within w_fa_man_recalcula_pedido
integer x = 1001
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

type em_hasta from editmask within w_fa_man_recalcula_pedido
integer x = 1184
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

