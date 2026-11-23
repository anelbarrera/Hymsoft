//objectcomments Para restaurar el pase de un pedido a factura
forward
global type w_fa_rep_aprobacion from w_fa_padre
end type
type gb_anio from groupbox within w_fa_rep_aprobacion
end type
type cb_1 from commandbutton within w_fa_rep_aprobacion
end type
type cb_2 from commandbutton within w_fa_rep_aprobacion
end type
type st_1 from statictext within w_fa_rep_aprobacion
end type
end forward

global type w_fa_rep_aprobacion from w_fa_padre
integer width = 1426
integer height = 720
string title = "(FA) Busqueda de Pedidos Aprobados"
string menuname = "m_hs"
boolean controlmenu = false
long backcolor = 79741120
event ue_enter pbm_dwndragenter
gb_anio gb_anio
cb_1 cb_1
cb_2 cb_2
st_1 st_1
end type
global w_fa_rep_aprobacion w_fa_rep_aprobacion

type variables
// Para el filtro de la unidad
datawindowchild idwc_tipo, dwc_fac_pedi
String is_ped_sel, is_fact_sel, is_tipo_repl,is_tipo_sel, is_pedido_repl, is_user
Integer ii_ann_sel, ii_ann_repl
str_fa_carg_ped str_pedi
end variables

forward prototypes
public subroutine wf_botones ()
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

public subroutine wf_setear_user (string as_user);//se asigna el usuario desde la ventana de clave con Dynamic
is_user = as_user
end subroutine

on w_fa_rep_aprobacion.create
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

on w_fa_rep_aprobacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_anio)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_1)
end on

event ue_post_open;//Override
str_pedi = Message.PowerObjectParm

is_nombre = This.ClassName()

dw.settransobject(sqlca)

st_nom_ventana.text = is_nombre

//OpenWithParm(w_fa_man_clave_pedido, this)

If is_user = "*" then
	close(this)
else	
		
	dw_1.settransobject(sqlca)
	dw_1.GetChild ("pedi_no_pedido",dwc_fac_pedi)
	dwc_fac_pedi.Settransobject(SQLCA);
	dwc_fac_pedi.retrieve(str.g_financiero,str.empresa)
	dw_1.insertrow(0)
	dw_1.SetFocus()
End if

if trim(str_pedi.pedido) <> "" and not isnull(str_pedi.pedido) then	
	dw_1.setitem(1,'pedi_no_pedido',str_pedi.pedido)
	
end if
end event

event show;
wf_botones()

end event

event closequery;//destroy io_encryptor
constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)

This.SetRedraw(false)
end event

event resize;//override
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

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_rep_aprobacion
boolean visible = false
integer x = 37
integer y = 436
integer width = 709
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_rep_aprobacion
event ue_filtra_unidad ( )
integer x = 389
integer y = 192
integer width = 581
integer height = 88
string dataobject = "dw_ma_fa_pedido_aprobado"
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

event dw_1::ue_helpcol;call super::ue_helpcol;//override
end event

event dw_1::ue_microayuda;//Override
end event

type st_ayuda from w_fa_padre`st_ayuda within w_fa_rep_aprobacion
end type

type gb_anio from groupbox within w_fa_rep_aprobacion
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

type cb_1 from commandbutton within w_fa_rep_aprobacion
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
str_fa_detalles lstr_detalles
//if gf_mensaje("","¿Está Seguro de Restaurar el Pase del Pedido Seleccionado ?",2,1,"E") = 1 then
	
	ls_no_pedido = dwc_fac_pedi.GetItemString(dwc_fac_pedi.Getrow(),"pedi_no_pedido")
	ll_anio		 = dwc_fac_pedi.GetItemNumber(dwc_fac_pedi.Getrow(),"pedi_ann")
   lstr_detalles.no_pedido = ls_no_pedido


	ldt_fecha = date(gf_fecha_serv())
	ls_restaurado_por = str.usuario+"-"+string(ldt_fecha)
	
  sqlca.autocommit = false

//  UPDATE fatpedid
//     SET pedi_estado = 'A' ,
//	  		pedi_restaurado_por = :ls_restaurado_por
//   WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
//         ( fatpedid.pedi_empresa = :str.empresa ) AND  
//         ( fatpedid.pedi_no_pedido = :ls_no_pedido ) AND  
//         ( fatpedid.pedi_ann = :ll_anio )   ;
//			
//		if sqlca.sqlcode = -1 then
//			ls_error = sqlca.sqlerrtext
//			rollback;
//			mensaje("Aviso","Error al actualizar el Estado del Pedido",ls_error)
//			sqlca.autocommit = true
//			return
//		end if
	
//	  UPDATE fadpedid  
//		  SET dped_pasada = 0  
//		WHERE ( fadpedid.dped_g_financiero = :str.g_financiero ) AND  
//				( fadpedid.dped_empresa = :str.empresa ) AND  
//				( fadpedid.dped_no_pedido = :ls_no_pedido ) AND  
//				( fadpedid.dped_ann = :ll_anio )   ;
//		if sqlca.sqlcode = -1 then
//			ls_error = sqlca.sqlerrtext
//			rollback;
//			mensaje("Aviso","Error al actualizar la cantidad pasada en fadpedid",ls_error)
//			sqlca.autocommit = true
//			return
//		end if			
	
	commit;
	
	sqlca.autocommit = true
	
	//gf_mensaje("","Actualización Exitosa",1,1,"E")
//	If isDate(em_1.text) then
//	If isDate(em_2.text) then
//		lstr_rangfech.fecha1 = date(em_1.text)
//		lstr_rangfech.fecha2 = date(em_2.text)
//		OpenSheetWithParm(w_fa_rep_comision_imp,lstr_rangfech,this,1,Layered!)
//		This.Settoolbar(1,false)
//	Else
//		Mensaje("Aviso","La fecha HASTA es Invalida","Cersiorese de que la fecha esta en el formato valido DIA/MES/AÑO")
//	End If
//Else
//	Mensaje("Aviso","La fecha DESDE es Invalida","Cersiorese de que la fecha esta en el formato valido DIA/MES/AÑO")
//End IF	
//	OpenSheetWithParm(w_fa_rep_aprobacion_imp,lstr_rangfech,this,1,Layered!)
	
	OpenSheetWithParm(w_fa_rep_aprobacion_imp,ls_no_pedido,Parent,9, layered! )
	
	dwc_fac_pedi.retrieve(str.g_financiero,str.empresa)
	dw_1.reset()
	dw_1.InsertRow(1)	
	
//end if
end event

type cb_2 from commandbutton within w_fa_rep_aprobacion
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

type st_1 from statictext within w_fa_rep_aprobacion
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
string text = "Control de Pedidos Aprobados"
alignment alignment = center!
boolean focusrectangle = false
end type

