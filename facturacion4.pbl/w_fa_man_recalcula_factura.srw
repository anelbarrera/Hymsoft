//objectcomments Recalcula el Peso y/o el Cubicaje de la Factura
forward
global type w_fa_man_recalcula_factura from w_fa_padre
end type
type gb_anio from groupbox within w_fa_man_recalcula_factura
end type
type cb_1 from commandbutton within w_fa_man_recalcula_factura
end type
type cb_2 from commandbutton within w_fa_man_recalcula_factura
end type
type st_1 from statictext within w_fa_man_recalcula_factura
end type
type rb_pedido from radiobutton within w_fa_man_recalcula_factura
end type
type rb_factura from radiobutton within w_fa_man_recalcula_factura
end type
type cbx_cubicaje from checkbox within w_fa_man_recalcula_factura
end type
type cbx_peso from checkbox within w_fa_man_recalcula_factura
end type
type st_2 from statictext within w_fa_man_recalcula_factura
end type
type em_desde from editmask within w_fa_man_recalcula_factura
end type
type em_hasta from editmask within w_fa_man_recalcula_factura
end type
type st_3 from statictext within w_fa_man_recalcula_factura
end type
end forward

global type w_fa_man_recalcula_factura from w_fa_padre
integer width = 1746
integer height = 916
string title = "Recalcular Peso y/o Cubicaje de la Factura"
string menuname = "m_hs"
boolean controlmenu = false
long backcolor = 79741120
event ue_enter pbm_dwndragenter
gb_anio gb_anio
cb_1 cb_1
cb_2 cb_2
st_1 st_1
rb_pedido rb_pedido
rb_factura rb_factura
cbx_cubicaje cbx_cubicaje
cbx_peso cbx_peso
st_2 st_2
em_desde em_desde
em_hasta em_hasta
st_3 st_3
end type
global w_fa_man_recalcula_factura w_fa_man_recalcula_factura

type variables
// Para el filtro de la unidad
datawindowchild idwc_tipo, dwc_fac_pedi
String is_ped_sel, is_fact_sel, is_tipo_repl,is_tipo_sel, is_pedido_repl, is_user
Integer ii_ann_sel, ii_ann_repl
end variables

forward prototypes
public subroutine wf_setear_user (string as_user)
public subroutine wf_botones ()
public subroutine wf_selec_datawindow ()
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

public subroutine wf_selec_datawindow ();date ld_desde, ld_hasta

If rb_factura.checked = true then
	dw_1.DataObject = 'dw_dd_fa_costos_factura'
Else
	dw_1.DataObject = 'dw_dd_fa_costos_factura_ped'
End If

dw_1.GetChild ("fact_no_pedido",dwc_fac_pedi)
dw_1.settransobject(sqlca)
dwc_fac_pedi.Settransobject(SQLCA);
ld_desde = date(em_desde.text)
ld_hasta = date(em_hasta.text)
dwc_fac_pedi.retrieve(str.g_financiero,str.empresa, ld_desde, ld_hasta)
dw_1.InsertRow(0)

end subroutine

on w_fa_man_recalcula_factura.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.gb_anio=create gb_anio
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_1=create st_1
this.rb_pedido=create rb_pedido
this.rb_factura=create rb_factura
this.cbx_cubicaje=create cbx_cubicaje
this.cbx_peso=create cbx_peso
this.st_2=create st_2
this.em_desde=create em_desde
this.em_hasta=create em_hasta
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_anio
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.rb_pedido
this.Control[iCurrent+6]=this.rb_factura
this.Control[iCurrent+7]=this.cbx_cubicaje
this.Control[iCurrent+8]=this.cbx_peso
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.em_desde
this.Control[iCurrent+11]=this.em_hasta
this.Control[iCurrent+12]=this.st_3
end on

on w_fa_man_recalcula_factura.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_anio)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.rb_pedido)
destroy(this.rb_factura)
destroy(this.cbx_cubicaje)
destroy(this.cbx_peso)
destroy(this.st_2)
destroy(this.em_desde)
destroy(this.em_hasta)
destroy(this.st_3)
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
	
	rb_factura.checked = true
	if dw_1.rowcount() = 0 then	
		em_hasta.text = string(date(gf_fecha_serv()))
		em_desde.text = string(relativedate(date(gf_fecha_serv()), - 360))
	else
		dw_1.reset()
	end if
	ld_desde = date(em_desde.text)
	ld_hasta = date(em_hasta.text)
	dw_1.settransobject(sqlca)
	dw_1.GetChild ("fact_no_pedido",dwc_fac_pedi)
	dwc_fac_pedi.Settransobject(SQLCA);
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

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_man_recalcula_factura
boolean visible = false
integer x = 27
integer y = 608
integer width = 709
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_man_recalcula_factura
event ue_filtra_unidad ( )
integer x = 677
integer y = 308
integer width = 617
integer height = 88
string dataobject = "dw_dd_fa_costos_factura"
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

type st_ayuda from w_fa_padre`st_ayuda within w_fa_man_recalcula_factura
integer y = 492
end type

type gb_anio from groupbox within w_fa_man_recalcula_factura
integer x = 27
integer width = 1623
integer height = 572
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
end type

type cb_1 from commandbutton within w_fa_man_recalcula_factura
integer x = 1047
integer y = 568
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
date 	ld_desde, ld_hasta

lb_validado = true
lb_salvo = false
date		ldt_fecha

if not cbx_cubicaje.checked and not cbx_peso.checked then 
	mensaje("Aviso","Debe Seleccionar que requiere actualizar (Peso y/o cubicaje)","")
	return
end if

if gf_mensaje("","¿Está Seguro de Actualizar la Factura ?",2,1,"E") = 1 then
	
	ls_no_pedido = dwc_fac_pedi.GetItemString(dwc_fac_pedi.Getrow(),"fact_no_pedido")
	ls_tipo_fac	 = dwc_fac_pedi.GetItemString(dwc_fac_pedi.Getrow(),"fact_tipo")	
	ll_anio		 = dwc_fac_pedi.GetItemNumber(dwc_fac_pedi.Getrow(),"fact_ann")

	ldt_fecha = date(gf_fecha_serv())	
	
	sqlca.autocommit = true //Para que no bloquee

	/*PARA RECALCULAR EL CUBICAJE DE LA FACTURA SELECCIONADA*/	
	
	 DECLARE cur_factu CURSOR FOR  
	  SELECT faddiari.facd_linea,   
				faddiari.facd_codigo_item,   
				faddiari.facd_cubicaje,   
				faddiari.facd_peso,   
				faddiari.facd_unidad_producto,   
				faddiari.facd_unidad_venta,   
				faddiari.facd_cantidad,   
				faddiari.facd_cantidad_fraccion  
		 FROM faddiari  
		WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
				( faddiari.facd_empresa = :str.empresa ) AND  
				( faddiari.facd_tipo = :ls_tipo_fac ) AND  
				( faddiari.facd_no_pedido = :ls_no_pedido ) AND  
				( faddiari.facd_ann = :ll_anio )   ;
			
		if sqlca.sqlcode = -1 then
			mensaje("Aviso","Error al declarar el cursor con el detalle de la factura",sqlca.sqlerrtext)
			return
		end if

		open cur_factu;
		if sqlca.sqlcode = -1 then
			mensaje("Aviso","Error al Abrir el cursor con el detalle de la factura",sqlca.sqlerrtext)
			return
		end if
		
		

		FETCH cur_factu INTO :ll_linea, :ls_codigo_item, :ld_cubi, :ld_peso, :ls_uniprod, :ls_univen, :ld_gecan, :ll_gefrac;

		if sqlca.sqlcode = -1 then
			mensaje("Aviso","Error al asignar las variables del cursor",sqlca.sqlerrtext)
			return
		end if		
		
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
					mensaje("Aviso","Error al declarar el cursor con el detalle de la factura",sqlca.sqlerrtext)
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
			ll_mconverc = gf_unidad_venta(ls_unidad_empaque , il_ucom)			
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
				  UPDATE faddiari  
					  SET facd_cubicaje = :ld_resultado  
					WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
							( faddiari.facd_empresa = :str.empresa ) AND  
							( faddiari.facd_tipo = :ls_tipo_fac ) AND  
							( faddiari.facd_no_pedido = :ls_no_pedido ) AND  
							( faddiari.facd_ann = :ll_anio ) AND
							( faddiari.facd_codigo_item = :ls_codigo_item) AND 
							( faddiari.facd_linea = :ll_linea );
					
					if sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrtext
						rollback;
						mensaje("Aviso","Error al actualizar el cubicaje de la Factura",ls_error)
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
				  UPDATE faddiari  
					  SET facd_peso = :ld_resultado  
					WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
							( faddiari.facd_empresa = :str.empresa ) AND  
							( faddiari.facd_tipo = :ls_tipo_fac ) AND  
							( faddiari.facd_no_pedido = :ls_no_pedido ) AND  
							( faddiari.facd_ann = :ll_anio ) AND
							( faddiari.facd_codigo_item = :ls_codigo_item) AND 
							( faddiari.facd_linea = :ll_linea );
						
					if sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrtext
						rollback;
						mensaje("Aviso","Error al actualizar el Peso de la Factura",ls_error)
						sqlca.autocommit = true
						return
					end if
				end if								

			FETCH cur_factu INTO :ll_linea, :ls_codigo_item, :ld_cubi, :ld_peso, :ls_uniprod, :ls_univen, :ld_gecan, :ll_gefrac;
			
			if sqlca.sqlcode = -1 then
				mensaje("Aviso","Error al asignar las variables del cursor",sqlca.sqlerrtext)
				return
			end if		
			
		LOOP

	close cur_factu;	

	  UPDATE fatdiari
		  SET fact_cubicaje_total = (	select sum( faddiari.facd_cubicaje) 
												 FROM faddiari 							
										WHERE ( fatdiari.fact_g_financiero = faddiari.facd_g_financiero ) and 
												( fatdiari.fact_empresa = faddiari.facd_empresa ) and 
												( fatdiari.fact_tipo = faddiari.facd_tipo ) and 
												( fatdiari.fact_no_pedido = faddiari.facd_no_pedido ) and 
												( fatdiari.fact_ann = faddiari.facd_ann ) ),
		  		fact_peso_total = (	select sum( faddiari.facd_peso) 
												 FROM faddiari 							
										WHERE ( fatdiari.fact_g_financiero = faddiari.facd_g_financiero ) and 
												( fatdiari.fact_empresa = faddiari.facd_empresa ) and 
												( fatdiari.fact_tipo = faddiari.facd_tipo ) and 
												( fatdiari.fact_no_pedido = faddiari.facd_no_pedido ) and 
												( fatdiari.fact_ann = faddiari.facd_ann ) )		 		 
		FROM fatdiari
		where	( ( fatdiari.fact_g_financiero= :str.g_financiero ) AND  
				( fatdiari.fact_empresa 		= :str.empresa ) AND  
				( fatdiari.fact_no_pedido 		= :ls_no_pedido ) AND  
				( fatdiari.fact_tipo		 		= :ls_tipo_fac  ) AND  				
				( fatdiari.fact_ann 				= :ll_anio )  ) ;
		
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al actualizar el Peso y Cubicaje en el Encabezado de la Factura",ls_error)
			sqlca.autocommit = true
			return
		end if		
		
	/*PARA RECALCULAR EL CUBICAJE DE LA FACTURA SELECCIONADA*/					
	sqlca.autocommit = true

	gf_mensaje("","Actualización Exitosa",1,1,"E")
	
	dw_1.GetChild ("fact_no_pedido",dwc_fac_pedi)
	dwc_fac_pedi.Settransobject(SQLCA);
	ld_desde = date(em_desde.text)
	ld_hasta = date(em_hasta.text)	
	dwc_fac_pedi.retrieve(str.g_financiero,str.empresa, ld_desde, ld_hasta)
	dw_1.reset()
	dw_1.InsertRow(0)	
	
end if
end event

type cb_2 from commandbutton within w_fa_man_recalcula_factura
integer x = 1312
integer y = 568
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

type st_1 from statictext within w_fa_man_recalcula_factura
integer x = 430
integer y = 208
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
string text = "No. del Documento"
alignment alignment = center!
boolean focusrectangle = false
end type

type rb_pedido from radiobutton within w_fa_man_recalcula_factura
integer x = 142
integer y = 368
integer width = 338
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
string text = "  Pedido"
end type

event clicked;is_ped_sel=''
is_fact_sel=''

wf_selec_datawindow()

end event

type rb_factura from radiobutton within w_fa_man_recalcula_factura
integer x = 142
integer y = 268
integer width = 334
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
string text = "  Factura"
end type

event clicked;is_ped_sel=''
is_fact_sel=''
wf_selec_datawindow()


end event

type cbx_cubicaje from checkbox within w_fa_man_recalcula_factura
integer x = 489
integer y = 472
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

type cbx_peso from checkbox within w_fa_man_recalcula_factura
integer x = 887
integer y = 472
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

type st_2 from statictext within w_fa_man_recalcula_factura
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

type em_desde from editmask within w_fa_man_recalcula_factura
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

type em_hasta from editmask within w_fa_man_recalcula_factura
integer x = 1184
integer y = 56
integer width = 343
integer height = 84
integer taborder = 20
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

type st_3 from statictext within w_fa_man_recalcula_factura
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

