//objectcomments Para poner Activa dicha Factura
forward
global type w_fa_cambio_num_factura from w_fa_padre
end type
type gb_anio from groupbox within w_fa_cambio_num_factura
end type
type cb_1 from commandbutton within w_fa_cambio_num_factura
end type
type cb_2 from commandbutton within w_fa_cambio_num_factura
end type
type st_1 from statictext within w_fa_cambio_num_factura
end type
type rb_pedido from radiobutton within w_fa_cambio_num_factura
end type
type rb_factura from radiobutton within w_fa_cambio_num_factura
end type
type em_factura from editmask within w_fa_cambio_num_factura
end type
type st_2 from statictext within w_fa_cambio_num_factura
end type
end forward

global type w_fa_cambio_num_factura from w_fa_padre
integer width = 1710
integer height = 880
string title = " Cambiar Numero de una Factura"
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
em_factura em_factura
st_2 st_2
end type
global w_fa_cambio_num_factura w_fa_cambio_num_factura

type variables
// Para el filtro de la unidad
datawindowchild idwc_tipo, dwc_fac_pedi
String is_ped_sel, is_fact_sel, is_tipo_repl,is_tipo_sel, is_pedido_repl, is_user
Integer ii_ann_sel, ii_ann_repl
end variables

forward prototypes
public subroutine wf_botones ()
public subroutine wf_selec_datawindow ()
public subroutine wf_setear_user (string as_user)
end prototypes

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

public subroutine wf_selec_datawindow ();If rb_factura.checked = true then
	dw_1.DataObject = 'dw_fa_habilita_factura'
Else
	dw_1.DataObject = 'dw_fa_habilita_pedido'
End If

dw_1.GetChild ("fact_no_pedido",dwc_fac_pedi)
dw_1.settransobject(sqlca)
dwc_fac_pedi.Settransobject(SQLCA);
dwc_fac_pedi.retrieve(str.g_financiero,str.empresa)
dw_1.InsertRow(0)

end subroutine

public subroutine wf_setear_user (string as_user);//se asigna el usuario desde la ventana de clave con Dynamic
is_user = as_user
end subroutine

on w_fa_cambio_num_factura.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.gb_anio=create gb_anio
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_1=create st_1
this.rb_pedido=create rb_pedido
this.rb_factura=create rb_factura
this.em_factura=create em_factura
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_anio
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.rb_pedido
this.Control[iCurrent+6]=this.rb_factura
this.Control[iCurrent+7]=this.em_factura
this.Control[iCurrent+8]=this.st_2
end on

on w_fa_cambio_num_factura.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_anio)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.rb_pedido)
destroy(this.rb_factura)
destroy(this.em_factura)
destroy(this.st_2)
end on

event ue_post_open;//Override
is_nombre = This.ClassName()

dw.settransobject(sqlca)

st_nom_ventana.text = is_nombre

//OpenWithParm(w_fa_man_clave_pedido, this)
//
//If is_user = "*" then
//	close(this)
//else
//	
	rb_factura.checked = true
		
	dw_1.settransobject(sqlca)
	dw_1.GetChild ("fact_no_pedido",dwc_fac_pedi)
	dwc_fac_pedi.Settransobject(SQLCA);
	dwc_fac_pedi.retrieve(str.g_financiero,str.empresa)
	dw_1.insertrow(0)
	
	//dw_1.retrieve(str.g_financiero, str.empresa)
	dw_1.SetFocus()
//End if
end event

event show;
//wf_botones()

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

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_cambio_num_factura
boolean visible = false
integer x = 18
integer y = 588
integer width = 709
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_cambio_num_factura
event ue_filtra_unidad ( )
integer x = 585
integer y = 192
integer width = 617
integer height = 88
integer taborder = 10
string dataobject = "dw_fa_habilita_factura"
boolean border = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_1::getfocus;dw = dw_1


end event

event dw_1::rbuttondown;//override
end event

event dw_1::itemchanged;call super::itemchanged;is_tipo_repl = data
end event

event dw_1::ue_microayuda;//override
end event

type st_ayuda from w_fa_padre`st_ayuda within w_fa_cambio_num_factura
integer x = 782
integer y = 588
end type

type gb_anio from groupbox within w_fa_cambio_num_factura
integer x = 27
integer width = 1499
integer height = 560
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
end type

type cb_1 from commandbutton within w_fa_cambio_num_factura
integer x = 1042
integer y = 572
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

event clicked;String ls_no_pedido,ls_no_factura, ls_tipo_fac, ls_error, ls_habilitada_por, ls_factura, ls_factura_anterior
long ll_anio, ll_factura, ll_factura_anterior
Boolean	lb_validado,lb_salvo
lb_validado = true
lb_salvo = false
date		ldt_fecha

if gf_mensaje("","¿Está Seguro de Cambiarle el Número a la Factura ?",2,1,"E") = 1 then
	
	ls_factura = em_factura.text
	
	ls_factura_anterior	= dwc_fac_pedi.GetItemString(dwc_fac_pedi.Getrow(),"fact_no_factura")
	ls_no_pedido = dwc_fac_pedi.GetItemString(dwc_fac_pedi.Getrow(),"fact_no_pedido")
	ls_tipo_fac	 = dwc_fac_pedi.GetItemString(dwc_fac_pedi.Getrow(),"fact_tipo")	
	ll_anio		 = dwc_fac_pedi.GetItemNumber(dwc_fac_pedi.Getrow(),"fact_ann")

	ll_factura_anterior = long(ls_factura_anterior)
	ll_factura = long(ls_factura)
	if ll_factura <=0 then
		mensaje('Aviso','Debe introducir un Numero Válido','')
		return
	end if

	ldt_fecha = date(gf_fecha_serv())	
	ls_habilitada_por = str.usuario+"-"+string(ldt_fecha)
	
  sqlca.autocommit = false

  UPDATE fatdiari  
     SET fact_no_factura = :ls_factura	,
		   fact_habilitada_por = :ls_habilitada_por
   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
         ( fatdiari.fact_empresa = :str.empresa ) AND  
         ( fatdiari.fact_tipo = :ls_tipo_fac ) AND  
         ( fatdiari.fact_no_pedido = :ls_no_pedido ) AND  
         ( fatdiari.fact_ann = :ll_anio )   ;
			
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al Cambiar la Factura en Fatdiari",ls_error)
			sqlca.autocommit = true
			return
		end if

	/*Actualizando en CCTMOVIM*/
	  UPDATE cctmovim  
		  SET movi_documento = :ls_factura  
		WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
				( cctmovim.movi_empresa = :str.empresa ) AND  
				( cctmovim.movi_aplicacion = 'FA' ) AND  
				( cctmovim.movi_documento = :ls_factura_anterior ) AND  
				( cctmovim.movi_anno = :ll_anio ) ;

		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al Cambiar el Documento en CCTMOVIM",ls_error)
			sqlca.autocommit = true
			return
		end if

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
           tmov_no_pedido )  
     SELECT intmovim.tmov_g_financiero,   
            intmovim.tmov_empresa,   
            intmovim.tmov_aplicacion,   
            intmovim.tmov_tipo_transaccion,   
				:ll_factura,   
            intmovim.tmov_concepto,   
            intmovim.tmov_anual,   
            intmovim.tmov_descripcion,   
            intmovim.tmov_fecha,   
            intmovim.tmov_autoriza,   
            :ls_factura,   
            intmovim.tmov_fecha_registro,   
            intmovim.tmov_terceros,   
            intmovim.tmov_comentario,   
            intmovim.tmov_tipo_costo,   
            intmovim.tmov_id,   
            intmovim.tmov_tipo,   
            intmovim.tmov_estado,   
            intmovim.tmov_anulado,   
            intmovim.tmov_total_cargos,   
            intmovim.tmov_fecha_actualizacion,   
            intmovim.tmov_documento_entrada,   
            intmovim.tmov_estado_costo,   
            intmovim.tmov_forma_costeo,   
            intmovim.tmov_tipo_trafico,   
            intmovim.tmov_documento_comercial,   
            intmovim.tmov_fecha_cierre_mensual,   
            intmovim.tmov_cuenta,   
            intmovim.tmov_nombre_tercero,   
            intmovim.tmov_pase,   
            intmovim.tmov_moneda,   
            intmovim.tmov_cambio,   
            intmovim.tmov_constante,   
            intmovim.tmov_descuento,   
            intmovim.tmov_tipo_gasto,   
            intmovim.tmov_por_admin,   
            intmovim.tmov_no_pedido  
       FROM intmovim  
      WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
            ( intmovim.tmov_empresa = :str.empresa ) AND  
            ( intmovim.tmov_aplicacion = 'FA' ) AND  
            ( intmovim.tmov_secuencia = :ll_factura_anterior ) AND  
            ( intmovim.tmov_anual = :ll_anio )  ;	
	
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al Cambiar el Documento en INTMOVIM",ls_error)
			sqlca.autocommit = true
			return
		end if


  INSERT INTO indgasto  
         ( gast_g_financiero,   
           gast_empresa,   
           gast_aplicacion,   
           gast_transaccion,   
           gast_concepto,   
           gast_secuencia,   
           gast_linea,   
           gast_ann,   
           gast_descripcion,   
           gast_valor,   
           gast_anulado,   
           gast_tipo )  
     SELECT indgasto.gast_g_financiero,   
            indgasto.gast_empresa,   
            indgasto.gast_aplicacion,   
            indgasto.gast_transaccion,   
            indgasto.gast_concepto,   
				:ll_factura,   
            indgasto.gast_linea,   
            indgasto.gast_ann,   
            indgasto.gast_descripcion,   
            indgasto.gast_valor,   
            indgasto.gast_anulado,   
            indgasto.gast_tipo  
       FROM indgasto  
      WHERE ( indgasto.gast_g_financiero = :str.g_financiero ) AND  
            ( indgasto.gast_empresa = :str.empresa ) AND  
            ( indgasto.gast_aplicacion = 'FA' ) AND  
            ( indgasto.gast_secuencia = :ll_factura_anterior ) AND  
            ( indgasto.gast_ann = :ll_anio )   ;

		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al Cambiar el Documento en INDGASTO",ls_error)			
			sqlca.autocommit = true
			return
		end if
	
	
	  INSERT INTO indmovim  
         ( dmov_g_financiero,   
           dmov_empresa,   
           dmov_aplicacion,   
           dmov_tipo_transaccion,   
           dmov_concepto,   
           dmov_secuencia,   
           dmov_anual,   
           dmov_linea,   
           dmov_documento,   
           dmov_linea_referencia,   
           dmov_bodega,   
           dmov_ubicacion,   
           dmov_producto,   
           dmov_cantidad,   
           dmov_cant1,   
           dmov_unidad_medida,   
           dmov_costo,   
           dmov_precio,   
           dmov_cubicaje,   
           dmov_peso,   
           dmov_bulto,   
           dmov_costo_cif,   
           dmov_cargos,   
           dmov_precio_ent,   
           dmov_id,   
           dmov_bodega_destino,   
           dmov_ubicacion_destino,   
           dmov_fabricante,   
           dmov_anulado,   
           dmov_id_precio,   
           dmov_fecha_agotado,   
           dmov_existe_detalle,   
           dmov_num_orden,   
           dmov_comentarios,   
           dmov_clave,   
           dmov_costo_fob,   
           dmov_precio1,   
           dmov_precio2,   
           dmov_precio3,   
           dmov_secuencia_ea,   
           dmov_terceros_ea,   
           dmov_numpo_ea,   
           dmov_board,   
           dmov_color,   
           dmov_porcentaje_gasto )  
     SELECT indmovim.dmov_g_financiero,   
            indmovim.dmov_empresa,   
            indmovim.dmov_aplicacion,   
            indmovim.dmov_tipo_transaccion,   
            indmovim.dmov_concepto,   
            :ll_factura,   
            indmovim.dmov_anual,   
            indmovim.dmov_linea,   
            indmovim.dmov_documento,   
            indmovim.dmov_linea_referencia,   
            indmovim.dmov_bodega,   
            indmovim.dmov_ubicacion,   
            indmovim.dmov_producto,   
            indmovim.dmov_cantidad,   
            indmovim.dmov_cant1,   
            indmovim.dmov_unidad_medida,   
            indmovim.dmov_costo,   
            indmovim.dmov_precio,   
            indmovim.dmov_cubicaje,   
            indmovim.dmov_peso,   
            indmovim.dmov_bulto,   
            indmovim.dmov_costo_cif,   
            indmovim.dmov_cargos,   
            indmovim.dmov_precio_ent,   
            indmovim.dmov_id,   
            indmovim.dmov_bodega_destino,   
            indmovim.dmov_ubicacion_destino,   
            indmovim.dmov_fabricante,   
            indmovim.dmov_anulado,   
            indmovim.dmov_id_precio,   
            indmovim.dmov_fecha_agotado,   
            indmovim.dmov_existe_detalle,   
            indmovim.dmov_num_orden,   
            indmovim.dmov_comentarios,   
            indmovim.dmov_clave,   
            indmovim.dmov_costo_fob,   
            indmovim.dmov_precio1,   
            indmovim.dmov_precio2,   
            indmovim.dmov_precio3,   
            indmovim.dmov_secuencia_ea,   
            indmovim.dmov_terceros_ea,   
            indmovim.dmov_numpo_ea,   
            indmovim.dmov_board,   
            indmovim.dmov_color,   
            indmovim.dmov_porcentaje_gasto  
       FROM indmovim  
      WHERE ( indmovim.dmov_g_financiero = :str.g_financiero ) AND  
            ( indmovim.dmov_empresa = :str.empresa ) AND  
            ( indmovim.dmov_aplicacion = 'FA' ) AND  
            ( indmovim.dmov_secuencia = :ll_factura_anterior ) AND  
            ( indmovim.dmov_anual = :ll_anio )   ;

	
	
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al Cambiar el Documento en INDMOVIM",ls_error)
			sqlca.autocommit = true
			return
		end if
	
	
		  DELETE FROM indmovim  
			WHERE ( indmovim.dmov_g_financiero = :str.g_financiero ) AND  
					( indmovim.dmov_empresa = :str.empresa ) AND  
					( indmovim.dmov_aplicacion = 'FA' ) AND  
					( indmovim.dmov_secuencia = :ll_factura_anterior ) AND  
					( indmovim.dmov_anual = :ll_anio ) ;  
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso","Error al Eliminar el Documento en INDMOVIM",ls_error)
				sqlca.autocommit = true
				return
			end if
			
		  DELETE FROM indgasto  
			WHERE ( indgasto.gast_g_financiero = :str.g_financiero ) AND  
					( indgasto.gast_empresa = :str.empresa ) AND  
					( indgasto.gast_aplicacion = 'FA' ) AND  
					( indgasto.gast_secuencia = :ll_factura_anterior ) AND  
					( indgasto.gast_ann = :ll_anio )  ; 
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso","Error al Eliminar el Documento en INDGASTOS",ls_error)
				sqlca.autocommit = true
				return
			end if	
		
		  DELETE FROM intmovim  
			WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
					( intmovim.tmov_empresa = :str.empresa ) AND  
					( intmovim.tmov_aplicacion = 'FA' ) AND  
					( intmovim.tmov_secuencia = :ll_factura_anterior ) AND  
					( intmovim.tmov_anual = :ll_anio )  ; 
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso","Error al Eliminar el Documento en INTMOVIM",ls_error)
				sqlca.autocommit = true
				return
			end if
	
	commit;
	
	sqlca.autocommit = true

	gf_mensaje("","Actualización Exitosa",1,1,"E")
	
	dw_1.GetChild ("fact_no_pedido",dwc_fac_pedi)
	dwc_fac_pedi.Settransobject(SQLCA);
	dwc_fac_pedi.retrieve(str.g_financiero,str.empresa)
	dw_1.reset()
	dw_1.InsertRow(0)	
	
end if
end event

type cb_2 from commandbutton within w_fa_cambio_num_factura
integer x = 1317
integer y = 576
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

type st_1 from statictext within w_fa_cambio_num_factura
integer x = 160
integer y = 56
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

type rb_pedido from radiobutton within w_fa_cambio_num_factura
integer x = 142
integer y = 256
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

type rb_factura from radiobutton within w_fa_cambio_num_factura
integer x = 142
integer y = 156
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

type em_factura from editmask within w_fa_cambio_num_factura
integer x = 809
integer y = 368
integer width = 352
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
maskdatatype maskdatatype = stringmask!
end type

type st_2 from statictext within w_fa_cambio_num_factura
integer x = 133
integer y = 392
integer width = 645
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Número Nuevo:"
alignment alignment = right!
boolean focusrectangle = false
end type

