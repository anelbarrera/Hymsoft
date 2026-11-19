//objectcomments Para poner Activa dicha Factura
forward
global type w_fa_habilitar_factura from w_fa_padre
end type
type gb_anio from groupbox within w_fa_habilitar_factura
end type
type cb_1 from commandbutton within w_fa_habilitar_factura
end type
type cb_2 from commandbutton within w_fa_habilitar_factura
end type
type st_1 from statictext within w_fa_habilitar_factura
end type
type rb_pedido from radiobutton within w_fa_habilitar_factura
end type
type rb_factura from radiobutton within w_fa_habilitar_factura
end type
end forward

global type w_fa_habilitar_factura from w_fa_padre
integer width = 1463
integer height = 884
string title = "Habilitar una Factura Actualizada"
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
end type
global w_fa_habilitar_factura w_fa_habilitar_factura

type variables
// Para el filtro de la unidad
datawindowchild idwc_tipo, dwc_fac_pedi
String is_ped_sel, is_fact_sel, is_tipo_repl,is_tipo_sel, is_pedido_repl, is_user
Integer ii_ann_sel, ii_ann_repl, ii_mes, ii_ann
String is_syntax
end variables

forward prototypes
public subroutine wf_setear_user (string as_user)
public subroutine wf_selec_datawindow ()
public subroutine wf_botones ()
end prototypes

public subroutine wf_setear_user (string as_user);//se asigna el usuario desde la ventana de clave con Dynamic
is_user = as_user
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
dwc_fac_pedi.insertrow(0)
dw_1.InsertRow(0)

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

on w_fa_habilitar_factura.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.gb_anio=create gb_anio
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_1=create st_1
this.rb_pedido=create rb_pedido
this.rb_factura=create rb_factura
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_anio
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.rb_pedido
this.Control[iCurrent+6]=this.rb_factura
end on

on w_fa_habilitar_factura.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_anio)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.rb_pedido)
destroy(this.rb_factura)
end on

event ue_post_open;//Override
is_nombre = This.ClassName()

dw.settransobject(sqlca)

st_nom_ventana.text = is_nombre

/*ADDED BY HGN/05/07/2002*/
//String	ls_autoriza_s_n,ls_autoriza
//is_user =''
//if w_hs_frame.str_aplica_links.controla_modificaciones =1 then /*Controla modificaciones*/	
//	is_user ='yes'
//	openwithparm(w_dg_man_clave,ls_autoriza)
	
//	ls_autoriza_s_n = Message.StringParm 
	
//	CHOOSE CASE ls_autoriza_s_n
//	CASE '1'	//Usuario Autorizado
//	CASE '2'	//Usuario no Autorizado
//		messagebox('Atención ','Estimado Usuario Ud. no está autorizado para Activar Facturas, consulte a su Supervisor...!!!')
//		close(this)
//		return
//	CASE ELSE
//		close(this)
//		return
//	END CHOOSE

//end if

///**/
//If is_user <> 'yes' then	//Si no pasó por control de modificaciones
//	OpenWithParm(w_fa_man_clave_pedido, this)
	
//	If is_user = "*" then
//		close(this)
//		return
//	end if
	
//	is_user ='yes'
//	openwithparm(w_dg_man_clave,ls_autoriza)
	
//	ls_autoriza_s_n = Message.StringParm 
	
//	CHOOSE CASE ls_autoriza_s_n
//	CASE '1'	//Usuario Autorizado
//	CASE '2'	//Usuario no Autorizado
//		messagebox('Atención ','Estimado Usuario Ud. no está autorizado para Activar Facturas, consulte a su Supervisor...!!!')
//		close(this)
//		return
//	CASE ELSE
//		close(this)
//		return
//	END CHOOSE
	
//end if

rb_factura.checked = true
	
dw_1.settransobject(sqlca)
dw_1.GetChild ("fact_no_pedido",dwc_fac_pedi)
dwc_fac_pedi.Settransobject(SQLCA);
dwc_fac_pedi.retrieve(str.g_financiero,str.empresa)
dw_1.insertrow(0)

SELECT ccmparam.para_mes,   
		ccmparam.para_ano  
 INTO :ii_mes,   
		:ii_ann  
 FROM ccmparam  
WHERE ( ccmparam.para_g_financiero = :str.g_financiero ) AND  
		( ccmparam.para_empresa = :str.empresa )  ;
if sqlca.sqlcode = -1 then
	mensaje('Aviso','Error en la Selección del Período de CxC',sqlca.sqlerrtext)
end if

dw_1.SetFocus()

end event

event show;
wf_botones()

end event

event closequery;constant int SW_HIDE = 0
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

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_habilitar_factura
boolean visible = false
integer x = 37
integer y = 624
integer width = 709
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_habilitar_factura
event ue_filtra_unidad ( )
event syntax pbm_dwnsql
integer x = 585
integer y = 192
integer width = 617
integer height = 88
string dataobject = "dw_fa_habilita_factura"
boolean border = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_1::syntax;is_syntax =sqlsyntax
end event

event dw_1::getfocus;dw = dw_1


end event

event dw_1::rbuttondown;//
end event

event dw_1::itemchanged;call super::itemchanged;is_tipo_repl = data
end event

event dw_1::ue_microayuda;//Override
end event

type st_ayuda from w_fa_padre`st_ayuda within w_fa_habilitar_factura
end type

type gb_anio from groupbox within w_fa_habilitar_factura
integer x = 27
integer width = 1349
integer height = 544
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
end type

type cb_1 from commandbutton within w_fa_habilitar_factura
integer x = 773
integer y = 580
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

event clicked;String ls_no_pedido,ls_no_factura, ls_tipo_fac, ls_error, ls_habilitada_por, ls_termino, ls_tran, ls_nota_debito
long ll_anio, ll_secuencia, ll_existe
Boolean	lb_validado,lb_salvo
lb_validado = true
lb_salvo = false
date		ldt_fecha, ldt_fecha_fac

if gf_mensaje("","¿Está Seguro de Habilitar Esta Factura ?",2,1,"E") = 1 then
	
	ls_no_pedido = dwc_fac_pedi.GetItemString(dwc_fac_pedi.Getrow(),"fact_no_pedido")
	ls_tipo_fac	 = dwc_fac_pedi.GetItemString(dwc_fac_pedi.Getrow(),"fact_tipo")	
	ll_anio		 = dwc_fac_pedi.GetItemNumber(dwc_fac_pedi.Getrow(),"fact_ann")
	ls_no_factura= dwc_fac_pedi.GetItemString(dwc_fac_pedi.Getrow(),"fact_no_factura")
	ls_termino	 = dwc_fac_pedi.GetItemString(dwc_fac_pedi.Getrow(),"fact_condicion_pago")
	ldt_fecha_fac= date(dwc_fac_pedi.GetItemDatetime(dwc_fac_pedi.Getrow(),"fact_fecha"))

	
	select isnull(fact_nota_debito,'')
		into  :ls_nota_debito
		from fatdiari
		WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
		( fatdiari.fact_empresa = :str.empresa ) AND  
		( fatdiari.fact_tipo = :ls_tipo_fac ) AND  
		( fatdiari.fact_no_pedido = :ls_no_pedido ) AND  
		( fatdiari.fact_ann = :ll_anio ) AND  
		( fatdiari.fact_genera_nd = 1 ) AND
		( fatdiari.fact_no_factura = :ls_no_factura);						
		if sqlca.sqlerrtext <> "" then	
			ls_error = sqlca.sqlerrtext
			rollback ;
			Mensaje("Error","Error al Actualizar Factura ",ls_error)	
			return
		end if					

	
	//Valida que si la factura tiene fecha de un mes cerrado en CXC, no permite habilitarla
	if year(ldt_fecha_fac)*100+month(ldt_fecha_fac) < ii_ann*100+ii_mes then
		mensaje('Aviso','Sr. Usuario, está intentando habilitar una Factura que pertence a un mes cerrado de Cuentas por Cobrar','')
		return
	end if
	
	if ls_termino = 'CO' then
		ls_tran = 'FC'
	else
		ls_tran = 'FA'
	end if

	ldt_fecha = date(gf_fecha_serv())	
	ls_habilitada_por = str.usuario+"-"+string(ldt_fecha)
	
  sqlca.autocommit = false

	/*Elimina el Movimiento de Cuentas por Cobrar*/
  DELETE FROM cctmovim  
   WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
         ( cctmovim.movi_empresa = :str.empresa ) AND  
         ( cctmovim.movi_aplicacion = 'FA' ) AND  
         ( cctmovim.movi_tipo_transaccion = :ls_tran ) AND  			
         ( cctmovim.movi_sub_transaccion = :ls_tipo_fac ) AND  
         ( cctmovim.movi_documento = :ls_no_factura ) AND  
         ( cctmovim.movi_anno = :ll_anio );
			
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al eliminar de cctmovim",ls_error)
			sqlca.autocommit = true
			return
		end if	
		
			/*Elimina documentos aplicado a esta factura*/
			DELETE FROM ccdrefac
				 FROM ccdrefac  
				WHERE ( ccdrefac.refa_g_financiero = :str.g_financiero ) AND  
						( ccdrefac.refa_empresa = :str.empresa ) AND  
						( ccdrefac.refa_aplicacion_origen = 'FA' ) AND  
						( ccdrefac.refa_transaccion = :ls_tran ) AND  
						( ccdrefac.refa_sub_transaccion = :ls_tipo_fac ) AND  
						( ccdrefac.refa_referencia = :ls_no_factura ) AND  
						( ccdrefac.refa_doc_ano = :ll_anio )   ;
	
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso","Error al eliminar documentos aplicados en ccdrefac",ls_error)
				sqlca.autocommit = true
				return
			end if	
		
	/*Elimina de Inventarios*/		
	  ll_secuencia = long(ls_no_factura)
	  if ll_secuencia <= 0 then	//si tiene letras o  caracteres especiales	  
		  DELETE FROM indmovim  
			WHERE ( indmovim.dmov_g_financiero = :str.g_financiero ) AND  
					( indmovim.dmov_empresa = :str.empresa ) AND  
					( indmovim.dmov_aplicacion = 'FA' ) AND  
					( indmovim.dmov_tipo_transaccion = 'SA' ) AND  
					( indmovim.dmov_concepto = :ls_tipo_fac ) AND  
					( indmovim.dmov_anual = :ll_anio ) AND  
					( indmovim.dmov_documento = :ls_no_factura ) ;			  
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso","Error al eliminar detalle de inventario",ls_error)
				sqlca.autocommit = true
				return
			end if			
			
			/*Elimina el Encabezado de inventario*/			
			  DELETE FROM intmovim  
				WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
						( intmovim.tmov_empresa = :str.empresa ) AND  
						( intmovim.tmov_aplicacion = 'FA' ) AND  
						( intmovim.tmov_tipo_transaccion = 'SA' ) AND  
						( intmovim.tmov_documento = :ls_no_factura ) AND  
						( intmovim.tmov_concepto = :ls_tipo_fac ) AND  
						( intmovim.tmov_anual = :ll_anio )   ;
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso","Error al eliminar el encabezado de inventario",ls_error)
				sqlca.autocommit = true
				return
			end if																
					
	  else	  
		  DELETE FROM indmovim  
			WHERE ( indmovim.dmov_g_financiero = :str.g_financiero ) AND  
					( indmovim.dmov_empresa = :str.empresa ) AND  
					( indmovim.dmov_aplicacion = 'FA' ) AND  
					( indmovim.dmov_tipo_transaccion = 'SA' ) AND  
					( indmovim.dmov_concepto = :ls_tipo_fac ) AND  
					( indmovim.dmov_secuencia = :ll_secuencia ) AND  
					( indmovim.dmov_anual = :ll_anio ) AND  
					( indmovim.dmov_documento = :ls_no_factura ) ;		
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso","Error al eliminar detalle de inventario",ls_error)
				sqlca.autocommit = true
				return
			end if	
			/*Elimina los Cargos de Inventario*/
		  DELETE FROM indgasto  
			WHERE ( indgasto.gast_g_financiero = :str.g_financiero ) AND  
					( indgasto.gast_empresa = :str.empresa ) AND  
					( indgasto.gast_aplicacion = 'FA' ) AND  
					( indgasto.gast_transaccion = 'SA' ) AND  
					( indgasto.gast_concepto = :ls_tipo_fac ) AND  
					( indgasto.gast_secuencia = :ll_secuencia ) AND  
					( indgasto.gast_ann = :ll_anio ) ;					
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso","Error al eliminar detalle de los cargos de inventario",ls_error)
				sqlca.autocommit = true
				return
			end if						
			
			/*Elimina el Encabezado de inventario*/			
			  DELETE FROM intmovim  
				WHERE ( intmovim.tmov_g_financiero = :str.g_financiero ) AND  
						( intmovim.tmov_empresa = :str.empresa ) AND  
						( intmovim.tmov_aplicacion = 'FA' ) AND  
						( intmovim.tmov_tipo_transaccion = 'SA' ) AND  
						( intmovim.tmov_secuencia = :ll_secuencia ) AND  
						( intmovim.tmov_concepto = :ls_tipo_fac ) AND  
						( intmovim.tmov_documento = :ls_no_factura ) AND
						( intmovim.tmov_anual = :ll_anio )   ;
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso","Error al eliminar el encabezado de inventario",ls_error)
				sqlca.autocommit = true
				return
			end if						
			
  end if		//del ll_secuencia <= 0
		
	//Elimina de Fadagotados_fac
	DELETE  FROM fadagotadosfac  
   WHERE ( fadagotadosfac.agot_g_financiero = :str.g_financiero ) AND  
         ( fadagotadosfac.agot_empresa = :str.empresa ) AND  
         ( fadagotadosfac.agot_no_pedido = :ls_no_pedido ) AND  
         ( fadagotadosfac.agot_anno = :ll_anio ) AND  
         ( fadagotadosfac.agot_no_factura = :ls_no_factura )    ;
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso","Error al Eliminar Agotados ",ls_error)
				sqlca.autocommit = true
				return
			end if						
		
	/*Activacion de la Factura*/
  UPDATE fatdiari  
     SET fact_estado = 'A' ,
	  		fact_habilitada_por = :ls_habilitada_por,
			fact_act_cliente	  = 0,
			fact_act_inventario = 0
//			fact_no_factura = ''
   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
         ( fatdiari.fact_empresa = :str.empresa ) AND  
         ( fatdiari.fact_tipo = :ls_tipo_fac ) AND  
         ( fatdiari.fact_no_pedido = :ls_no_pedido ) AND  
         ( fatdiari.fact_ann = :ll_anio )   ;
			
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al actualizar el Estado",ls_error)
			sqlca.autocommit = true
			return
		end if	
	
		 DECLARE proc_reserva PROCEDURE FOR sp_reserva_factura_activada  
         @p_gf = :str.g_financiero,   
         @p_emp = :str.empresa,   
         @p_pedido = :ls_no_pedido,   
		@p_tipo	= :ls_tipo_fac,
         @p_ann = :ll_anio  ;
		 
		 execute proc_reserva ;
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso","Error al actualizar la Reserva en faddiari (Procedimiento)",ls_error)
				sqlca.autocommit = true
				return
			end if			
	
	//Elimina la Nota de Debito si tenia previamente
	if len(ls_nota_debito) > 0 then
		
		  DELETE FROM dgddiari  
			WHERE ( dgddiari.ddia_g_financiero = :str.g_financiero ) AND  
					( dgddiari.ddia_empresa = :str.empresa ) AND  
					( dgddiari.ddia_aplicacion = 'CC' ) AND  
					( dgddiari.ddia_tipo_transaccion = 'ND' ) AND  
					( dgddiari.ddia_sub_tipo_transaccion = '2' ) AND  
					( dgddiari.ddia_no_documento = :ls_nota_debito ) AND  
					( dgddiari.ddia_ann = :ll_anio )   ;
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso","Error al Eliminar Enlace de ND ",ls_error)
				sqlca.autocommit = true
				return
			end if						
				
			  DELETE FROM dgtdiari  
			WHERE ( dgtdiari.tdia_g_financiero = :str.g_financiero ) AND  
					( dgtdiari.tdia_empresa = :str.empresa ) AND  
					( dgtdiari.tdia_aplicacion = 'CC' ) AND  
					( dgtdiari.tdia_tipo_transaccion = 'ND' ) AND  
					( dgtdiari.tdia_sub_tipo_transaccion = '2' ) AND  
					( dgtdiari.tdia_no_documento = :ls_nota_debito ) AND  
					( dgtdiari.tdia_ann = :ll_anio )   ;
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso","Error al Eliminar Enlace de ND Encabezado ",ls_error)
				sqlca.autocommit = true
				return
			end if						
		
			
			  DELETE FROM ccdcarpa  
				WHERE ( ccdcarpa.carp_g_financiero = :str.g_financiero ) AND  
						( ccdcarpa.carp_empresa = :str.empresa ) AND  
						( ccdcarpa.carp_tipo_transaccion = 'ND' ) AND  
						( ccdcarpa.carp_sub_transaccion = '2' ) AND  
						( ccdcarpa.carp_documento = :ls_nota_debito ) AND  
						( ccdcarpa.carp_anno = :ll_anio )   ;					
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso","Error al Eliminar detalle de ND ccdcarpa",ls_error)
				sqlca.autocommit = true
				return
			end if						
			
			  DELETE FROM cctcarpa  
				WHERE ( cctcarpa.carp_g_financiero = :str.g_financiero ) AND  
						( cctcarpa.carp_empresa = :str.empresa ) AND  
						( cctcarpa.carp_tipo_transaccion = 'ND' ) AND  
						( cctcarpa.carp_sub_transaccion = '2' ) AND  
						( cctcarpa.carp_documento = :ls_nota_debito ) AND  
						( cctcarpa.carp_anno = :ll_anio )   ;					
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje("Aviso","Error al Eliminar detalle de ND ccdcarpa",ls_error)
				sqlca.autocommit = true
				return
			end if						
		
		
		
	end if
	//Final de eliminacion de la nota de debito
	
	commit;
	
	sqlca.autocommit = true

	gf_mensaje("","Actualización Exitosa",1,1,"E")
	
	close(parent)
	
	/* se comento para que solo ejecute una activacion y salga
	dw_1.GetChild ("fact_no_pedido",dwc_fac_pedi)
	dwc_fac_pedi.Settransobject(SQLCA);
	dwc_fac_pedi.retrieve(str.g_financiero,str.empresa)
	dwc_fac_pedi.insertrow(0)
	dw_1.reset()
	dw_1.InsertRow(0)	
	*/

end if
end event

type cb_2 from commandbutton within w_fa_habilitar_factura
integer x = 1051
integer y = 580
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

type st_1 from statictext within w_fa_habilitar_factura
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

type rb_pedido from radiobutton within w_fa_habilitar_factura
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

type rb_factura from radiobutton within w_fa_habilitar_factura
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

