//objectcomments Para Poner como pasado un pedido
forward
global type w_fa_man_cambiar_de_oc_a_existencias from w_fa_padre
end type
type gb_anio from groupbox within w_fa_man_cambiar_de_oc_a_existencias
end type
type cb_1 from commandbutton within w_fa_man_cambiar_de_oc_a_existencias
end type
type cb_2 from commandbutton within w_fa_man_cambiar_de_oc_a_existencias
end type
type st_1 from statictext within w_fa_man_cambiar_de_oc_a_existencias
end type
type em_ann from editmask within w_fa_man_cambiar_de_oc_a_existencias
end type
type st_2 from statictext within w_fa_man_cambiar_de_oc_a_existencias
end type
end forward

global type w_fa_man_cambiar_de_oc_a_existencias from w_fa_padre
integer width = 1426
integer height = 720
string title = "(FA) Actualizar Reserva de Productos en Existencias"
string menuname = "m_hs"
boolean controlmenu = false
long backcolor = 79741120
event ue_enter pbm_dwndragenter
gb_anio gb_anio
cb_1 cb_1
cb_2 cb_2
st_1 st_1
em_ann em_ann
st_2 st_2
end type
global w_fa_man_cambiar_de_oc_a_existencias w_fa_man_cambiar_de_oc_a_existencias

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

on w_fa_man_cambiar_de_oc_a_existencias.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.gb_anio=create gb_anio
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_1=create st_1
this.em_ann=create em_ann
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_anio
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.em_ann
this.Control[iCurrent+6]=this.st_2
end on

on w_fa_man_cambiar_de_oc_a_existencias.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_anio)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.em_ann)
destroy(this.st_2)
end on

event ue_post_open;//Override
string	ls_filtro
is_nombre = This.ClassName()

st_nom_ventana.text = is_nombre

//OpenWithParm(w_fa_man_clave_pedido, this)

//If is_user = "*" then
//	close(this)
//else	

em_ann.text = string(year(date(gf_fecha_serv())))
		
dw_1.settransobject(sqlca)
dw_1.insertrow(1)
dw_1.SetFocus()

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

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_man_cambiar_de_oc_a_existencias
boolean visible = false
integer x = 37
integer y = 436
integer width = 709
integer textsize = -7
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_man_cambiar_de_oc_a_existencias
event ue_filtra_unidad ( )
integer x = 635
integer y = 180
integer width = 430
integer height = 104
string dataobject = "dw_external_pedido"
boolean livescroll = true
end type

event dw_1::getfocus;dw = dw_1


end event

event dw_1::rbuttondown;//
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

event dw_1::ue_microayuda;//override
end event

type st_ayuda from w_fa_padre`st_ayuda within w_fa_man_cambiar_de_oc_a_existencias
end type

type gb_anio from groupbox within w_fa_man_cambiar_de_oc_a_existencias
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

type cb_1 from commandbutton within w_fa_man_cambiar_de_oc_a_existencias
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

event clicked;String ls_no_pedido,ls_no_factura, ls_tipo_fac, ls_error, ls_restaurado_por, ls_item, ls_bodega, ls_ubicacion
long ll_anio
integer li_linea
Boolean	lb_validado,lb_salvo
lb_validado = true
lb_salvo = false
date		ldt_fecha

if gf_mensaje("","¿Está Seguro de Actualizar las Reservas del Pedido?",2,1,"E") = 1 then
	dw_1.accepttext()
	
	ls_no_pedido = dw_1.getitemstring(1,'pedido')
	ll_anio		 = integer(em_ann.text)

//	ldt_fecha = date(gf_fecha_serv())
//	ls_restaurado_por = str.usuario+"-"+string(ldt_fecha)
	
  sqlca.autocommit = false

  SELECT max(fadpedid.dped_linea)
  	into :li_linea
    FROM fadpedid  
   WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
         ( fadpedid.dped_empresa = :str.empresa ) AND  
         ( fadpedid.dped_no_pedido = :ls_no_pedido ) AND  
         ( fadpedid.dped_ann = :ll_anio ) AND  
		( fadpedid.dped_reserva_origen = 'E') ;
        // ( fadpedid.dped_bodega+fadpedid.dped_ubicacion = :w_fa_fondo.str_para.bodega_en_transito + :w_fa_fondo.str_para.ubicacion_en_transito  )   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al Buscar linea ",ls_error)
			sqlca.autocommit = true
			return
		end if
		
	 DECLARE cur_pedido CURSOR FOR  
  SELECT fadpedid.dped_codigo_item  
    FROM fadpedid  
   WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
         ( fadpedid.dped_empresa = :str.empresa ) AND  
         ( fadpedid.dped_no_pedido = :ls_no_pedido ) AND  
         ( fadpedid.dped_ann = :ll_anio ) AND  
		( fadpedid.dped_reserva_origen <> 'E') order by dped_index;
        // ( fadpedid.dped_bodega+fadpedid.dped_ubicacion = :w_fa_fondo.str_para.bodega_en_transito + :w_fa_fondo.str_para.ubicacion_en_transito  )   ;
  
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al Declarar la Reserva de las Existencias Futuras",ls_error)
			sqlca.autocommit = true
			return
		end if
		
		open cur_pedido ;
		
		fetch cur_pedido into :ls_item ;
		if isnull(li_linea) then li_linea = 0
		DO WHILE SQLCA.sqlcode = 0							
			li_linea ++
			//busca la bodega con existencias
			 DECLARE cur_bodegas CURSOR FOR  
			  SELECT inmbodeg.mbod_bodega,   
						inmbodeg.mbod_ubicacion  
				 FROM inmbodeg  
				WHERE ( inmbodeg.mbod_g_financiero = :str.g_financiero ) AND  
						( inmbodeg.mbod_empresa = :str.empresa ) AND  
						( inmbodeg.mbod_producto = :ls_item ) AND
						( inmbodeg.mbod_bodega + inmbodeg.mbod_ubicacion <> :w_fa_fondo.str_para.bodega_en_transito +:w_fa_fondo.str_para.ubicacion_en_transito  ) 
				ORDER BY inmbodeg.mbod_cantidad DESC  ;
							if sqlca.sqlcode = -1 then
								ls_error = sqlca.sqlerrtext
								rollback;
								mensaje("Aviso","Error al actualizar la Reserva de las Existencias Futuras inmbodeg Item "+ls_item,ls_error)
								sqlca.autocommit = true
								return
							end if
							
				open cur_bodegas ;
				
				fetch cur_bodegas into: ls_bodega, :ls_ubicacion;
			
				if SQLCA.sqlcode = 0 then
					
				//actualiza el pedido
				  UPDATE fadpedid  
					  SET dped_bodega = :ls_bodega,   
							dped_ubicacion = :ls_ubicacion,   
							dped_reserva_origen = 'E' ,
			//				dped_linea = :li_linea,
							dped_index = :li_linea
					WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
							( fadpedid.dped_empresa = :str.empresa ) AND  
							( fadpedid.dped_no_pedido = :ls_no_pedido ) AND  
							( fadpedid.dped_ann = :ll_anio ) AND  
							( fadpedid.dped_codigo_item = :ls_item ) AND  
							( fadpedid.dped_reserva_origen <> 'E') ;							
//							( fadpedid.dped_bodega +fadpedid.dped_ubicacion = :w_fa_fondo.str_para.bodega_en_transito +:w_fa_fondo.str_para.ubicacion_en_transito  )   ;
								if sqlca.sqlcode = -1 then
									ls_error = sqlca.sqlerrtext
									rollback;
									mensaje("Aviso","Error al actualizar la Reserva de las Existencias Futuras en Pedido Item "+ls_item,ls_error)
									sqlca.autocommit = true
									return
								end if
								
					end if	//del fetch de la bodega		
					
					close cur_bodegas;
					
			FETCH cur_pedido INTO :ls_item;
		LOOP

		close cur_pedido;
//messagebox(string(str.g_financiero)+string(str.empresa),ls_no_pedido+'-'+string( ll_anio)	)
	
	commit;
	
	sqlca.autocommit = true

	gf_mensaje("","Actualización Exitosa",1,1,"E")
	
	//dwc_fac_pedi.retrieve(str.g_financiero,str.empresa) //comentado para que no se demore en recuperar nuevamente
	dw_1.reset()
	dw_1.InsertRow(1)	
	
end if
end event

type cb_2 from commandbutton within w_fa_man_cambiar_de_oc_a_existencias
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

type st_1 from statictext within w_fa_man_cambiar_de_oc_a_existencias
integer x = 123
integer y = 72
integer width = 1134
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
string text = "No. del Pedido a Reservar Existencias"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_ann from editmask within w_fa_man_cambiar_de_oc_a_existencias
integer x = 224
integer y = 176
integer width = 329
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean border = false
alignment alignment = center!
string mask = "###0"
boolean spin = true
double increment = 1
string minmax = "2000~~4000"
end type

type st_2 from statictext within w_fa_man_cambiar_de_oc_a_existencias
integer x = 50
integer y = 192
integer width = 169
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año:"
alignment alignment = center!
boolean focusrectangle = false
end type

