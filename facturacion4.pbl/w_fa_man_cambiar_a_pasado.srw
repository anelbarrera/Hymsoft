//objectcomments Para Poner como pasado un pedido
forward
global type w_fa_man_cambiar_a_pasado from w_fa_padre
end type
type gb_anio from groupbox within w_fa_man_cambiar_a_pasado
end type
type cb_1 from commandbutton within w_fa_man_cambiar_a_pasado
end type
type cb_2 from commandbutton within w_fa_man_cambiar_a_pasado
end type
type st_1 from statictext within w_fa_man_cambiar_a_pasado
end type
end forward

global type w_fa_man_cambiar_a_pasado from w_fa_padre
integer width = 1426
integer height = 720
string title = "Actualizar como Pasado un Pedido"
string menuname = "m_hs"
boolean controlmenu = false
long backcolor = 79741120
event ue_enter pbm_dwndragenter
gb_anio gb_anio
cb_1 cb_1
cb_2 cb_2
st_1 st_1
end type
global w_fa_man_cambiar_a_pasado w_fa_man_cambiar_a_pasado

type variables
// Para el filtro de la unidad
datawindowchild idwc_tipo, dwc_fac_pedi
String is_ped_sel, is_fact_sel, is_tipo_repl,is_tipo_sel, is_pedido_repl, is_user
Integer ii_ann_sel, ii_ann_repl
end variables

forward prototypes
public subroutine wf_setear_user (string as_user)
public subroutine wf_botones ()
public subroutine wf_actualiza_reservados ()
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

public subroutine wf_actualiza_reservados ();string ls_error

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
         ( inmprodu.prod_producto = vi_reserva.dped_codigo_item )   ;
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
         ( inmprodu.prod_producto = vi_reserva_fac.facd_codigo_item )   ;
			
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
         ( fadpedid.dped_unidad_venta = inamedid.medi_medida )  and
			( fadpedid.dped_g_financiero = :str.g_financiero ) and
			( fadpedid.dped_empresa	= :str.empresa );
			
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
         ( inmbodeg.mbod_producto = vi_reserva_fac_bodega.facd_codigo_item )   ;
			
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
         ( inmbodeg.mbod_producto = vi_reserva_ped_bodega.dped_codigo_item )   ;
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

on w_fa_man_cambiar_a_pasado.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.gb_anio=create gb_anio
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_anio
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.st_1
end on

on w_fa_man_cambiar_a_pasado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_anio)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_1)
end on

event ue_post_open;////Override
//string	ls_filtro
//is_nombre = This.ClassName()

//st_nom_ventana.text = is_nombre

////OpenWithParm(w_fa_man_clave_pedido, this)

////If is_user = "*" then
////	close(this)
////else	

////sle_ann.text = string(year(date(gf_fecha_serv())))
//This.SetRedraw(false)	
//dw_1.settransobject(sqlca)
//dw_1.GetChild ("pedi_no_pedido",dwc_fac_pedi)
//dwc_fac_pedi.Settransobject(SQLCA)
//dwc_fac_pedi.retrieve(str.g_financiero,str.empresa)
//dw_1.SetFocus()
//This.SetRedraw(true)

 //Override
// Recupera los datos mientras la ventana sigue oculta o sin redibujar
SetPointer(HourGlass!)

dwc_fac_pedi.Retrieve(str.g_financiero, str.empresa)

// Reactiva el dibujado y muestra la ventana ya armada
This.SetRedraw(True)
This.Visible = True
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

event close;call super::close; 
Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
 
end event

event open;call super::open; call super::open;
// Evita que cualquier cambio del padre se pinte prematuramente
this.visible = false
This.SetRedraw(False)
IF Trim(Message.StringParm) <> "" THEN
	This.Tag = Trim(Message.StringParm)
END IF

is_nombre = This.ClassName()
st_nom_ventana.text = is_nombre

dw_1.SetTransObject(sqlca)
dw_1.GetChild("pedi_no_pedido", dwc_fac_pedi)
dwc_fac_pedi.SetTransObject(sqlca)

// Si dw_1 necesita una fila en blanco para usar el DropDownDataWindow:
if dw_1.RowCount() = 0 then
	dw_1.InsertRow(0)
end if
 
end event

event activate;gnv_seg.of_aplicar_acciones_ventana(w_hs_frame.rbb_1, this.tag)
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_man_cambiar_a_pasado
boolean visible = false
integer x = 37
integer y = 436
integer width = 709
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_man_cambiar_a_pasado
event ue_filtra_unidad ( )
integer x = 366
integer y = 160
integer width = 599
integer height = 88
string dataobject = "dw_ma_fa_pedido_a_pasar1"
boolean livescroll = true
end type

event dw_1::getfocus;dw = dw_1


end event

event dw_1::rbuttondown;//override
end event

event dw_1::itemchanged;is_tipo_repl = data
end event

event dw_1::ue_down;//
end event

event dw_1::ue_entercol;//
end event

event dw_1::ue_escape;//
end event

event dw_1::ue_tabfinal;//
end event

event dw_1::itemfocuschanged;//
end event

event dw_1::clicked;//
end event

event dw_1::ue_microayuda;//Override

end event

type st_ayuda from w_fa_padre`st_ayuda within w_fa_man_cambiar_a_pasado
end type

type gb_anio from groupbox within w_fa_man_cambiar_a_pasado
integer x = 27
integer width = 1321
integer height = 388
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
end type

type cb_1 from commandbutton within w_fa_man_cambiar_a_pasado
integer x = 773
integer y = 412
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

event clicked;String ls_no_pedido,ls_no_factura, ls_tipo_fac, ls_error, ls_restaurado_por
long ll_anio
Boolean	lb_validado,lb_salvo
lb_validado = true
lb_salvo = false
date		ldt_fecha

if gf_mensaje("","¿Está Seguro de Poner como Pasado el Pedido Seleccionado?",2,1,"E") = 1 then
	
	ls_no_pedido = dwc_fac_pedi.GetItemString(dwc_fac_pedi.Getrow(),"pedi_no_pedido")
	ll_anio		 = dwc_fac_pedi.GetItemNumber(dwc_fac_pedi.Getrow(),"pedi_ann")

//	ldt_fecha = date(gf_fecha_serv())
//	ls_restaurado_por = str.usuario+"-"+string(ldt_fecha)
	
  sqlca.autocommit = false

	 DECLARE proc_libera PROCEDURE FOR sp_libera_pedido_reservado
		@p_gf = :str.g_financiero,   
		@p_emp = :str.empresa,   
		@p_pedido = :ls_no_pedido,   
		@p_ann = :ll_anio  ;
		
	 if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al actualizar la Reserva en fadpedid ( Declarando  el Procedimiento)",ls_error)
			sqlca.autocommit = true
			return		 
	 end if
	 
	 execute proc_libera ;
//	 messagebox(string(sqlca.sqlcode),sqlca.sqlerrtext)
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al actualizar la Reserva en fadpedid (Procedimiento)",ls_error)
			sqlca.autocommit = true
			return
		end if			



  UPDATE fatpedid
     SET pedi_estado = 'P' 
   WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
         ( fatpedid.pedi_empresa = :str.empresa ) AND  
         ( fatpedid.pedi_no_pedido = :ls_no_pedido ) AND  
         ( fatpedid.pedi_ann = :ll_anio )   ;
			
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al actualizar el Estado del Pedido",ls_error)
			sqlca.autocommit = true
			return
		end if
	
	  UPDATE fadpedid  
		  SET dped_pasada = dped_cantidad * medi_cantidad + dped_fraccion  
		  from fadpedid, inamedid
		WHERE ( fadpedid.dped_unidad_venta = inamedid.medi_medida ) AND
				( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
				( fadpedid.dped_empresa = :str.empresa ) AND  
				( fadpedid.dped_no_pedido = :ls_no_pedido ) AND  
				( fadpedid.dped_ann = :ll_anio )   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al actualizar la cantidad pasada en fadpedid",ls_error)
			sqlca.autocommit = true
			return
		end if

//messagebox(string(str.g_financiero)+string(str.empresa),ls_no_pedido+'-'+string( ll_anio)	)
	
	commit;
	
	sqlca.autocommit = true

	gf_mensaje("","Actualización Exitosa",1,1,"E")
	
	//dwc_fac_pedi.retrieve(str.g_financiero,str.empresa) //comentado para que no se demore en recuperar nuevamente
	dw_1.reset()
	dw_1.InsertRow(1)	
	
end if
end event

type cb_2 from commandbutton within w_fa_man_cambiar_a_pasado
integer x = 1051
integer y = 412
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

type st_1 from statictext within w_fa_man_cambiar_a_pasado
integer x = 123
integer y = 72
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
string text = "No. del Pedido a Pasar"
alignment alignment = center!
boolean focusrectangle = false
end type

