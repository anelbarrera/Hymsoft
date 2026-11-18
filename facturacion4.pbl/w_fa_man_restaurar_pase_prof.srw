//objectcomments Para restaurar el pase de una proforma a pedidos
forward
global type w_fa_man_restaurar_pase_prof from w_fa_padre
end type
type gb_anio from groupbox within w_fa_man_restaurar_pase_prof
end type
type cb_1 from commandbutton within w_fa_man_restaurar_pase_prof
end type
type cb_2 from commandbutton within w_fa_man_restaurar_pase_prof
end type
type st_1 from statictext within w_fa_man_restaurar_pase_prof
end type
end forward

global type w_fa_man_restaurar_pase_prof from w_fa_padre
integer width = 1499
integer height = 720
string title = "(FA) Restaurar una Proforma Pasada"
string menuname = "m_hs"
boolean controlmenu = false
long backcolor = 79741120
event ue_enter pbm_dwndragenter
gb_anio gb_anio
cb_1 cb_1
cb_2 cb_2
st_1 st_1
end type
global w_fa_man_restaurar_pase_prof w_fa_man_restaurar_pase_prof

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

on w_fa_man_restaurar_pase_prof.create
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

on w_fa_man_restaurar_pase_prof.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_anio)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_1)
end on

event ue_post_open;//Override
is_nombre = This.ClassName()

dw.settransobject(sqlca)

st_nom_ventana.text = is_nombre

//OpenWithParm(w_fa_man_clave_pedido, this)

//If is_user = "*" then
//	close(this)
//else	
		
	dw_1.settransobject(sqlca)
	dw_1.GetChild ("prof_no_proforma",dwc_fac_prof)
	dwc_fac_prof.Settransobject(SQLCA);
	dwc_fac_prof.retrieve(str.g_financiero,str.empresa)
	dw_1.insertrow(0)
	dw_1.SetFocus()
//End if
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

event close;close(This)
Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
 
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_man_restaurar_pase_prof
boolean visible = false
integer x = 18
integer y = 436
integer width = 855
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_man_restaurar_pase_prof
event ue_filtra_unidad ( )
integer x = 389
integer y = 192
integer width = 581
integer height = 88
integer taborder = 10
string dataobject = "dw_ma_fa_proforma_a_restaurar"
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

type st_ayuda from w_fa_padre`st_ayuda within w_fa_man_restaurar_pase_prof
end type

type gb_anio from groupbox within w_fa_man_restaurar_pase_prof
integer x = 27
integer width = 1403
integer height = 388
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
end type

type cb_1 from commandbutton within w_fa_man_restaurar_pase_prof
integer x = 887
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

event clicked;String ls_no_proforma,ls_no_factura, ls_tipo_fac, ls_error, ls_restaurado_por
long ll_anio
Boolean	lb_validado,lb_salvo
lb_validado = true
lb_salvo = false
date		ldt_fecha

if gf_mensaje("","¿Está Seguro de Restaurar el Pase de la Proforma Seleccionada ?",2,1,"E") = 1 then
	
	ls_no_proforma = dwc_fac_prof.GetItemString(dwc_fac_prof.Getrow(),"prof_no_proforma")
	ll_anio		 = dwc_fac_prof.GetItemNumber(dwc_fac_prof.Getrow(),"prof_ann")

	ldt_fecha = date(gf_fecha_serv())
	ls_restaurado_por = str.usuario+"-"+string(ldt_fecha)
	
  sqlca.autocommit = false

  UPDATE fatprofo
     SET prof_estado = 'A' ,
	  		prof_restaurado_por = :ls_restaurado_por
   WHERE ( fatprofo.prof_g_financiero = :str.g_financiero ) AND  
         ( fatprofo.prof_empresa = :str.empresa ) AND  
         ( fatprofo.prof_no_proforma = :ls_no_proforma ) AND  
         ( fatprofo.prof_ann = :ll_anio )   ;
			
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al actualizar el Estado de la Proforma",ls_error)
			sqlca.autocommit = true
			return
		end if
	
	  UPDATE fadprofo  
		  SET dpro_pasada = 0  
		WHERE ( fadprofo.dpro_g_financiero = :str.g_financiero ) AND  
				( fadprofo.dpro_empresa = :str.empresa ) AND  
				( fadprofo.dpro_no_proforma = :ls_no_proforma ) AND  
				( fadprofo.dpro_ann = :ll_anio )   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje("Aviso","Error al actualizar la cantidad pasada en fadprofo",ls_error)
			sqlca.autocommit = true
			return
		end if			
	
	commit;
	
	sqlca.autocommit = true

//	gf_mensaje("","Actualización Exitosa",1,1,"E") //No poner RM
	str.frame.setmicrohelp('Proforma Restaurada Exitosamente')	
	dwc_fac_prof.retrieve(str.g_financiero,str.empresa)
	dw_1.reset()
	dw_1.InsertRow(1)	
	
end if
end event

type cb_2 from commandbutton within w_fa_man_restaurar_pase_prof
integer x = 1166
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

type st_1 from statictext within w_fa_man_restaurar_pase_prof
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
string text = "No. de la Proforma a Restaurar"
alignment alignment = center!
boolean focusrectangle = false
end type

