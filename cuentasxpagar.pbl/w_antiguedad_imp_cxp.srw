forward
global type w_antiguedad_imp_cxp from w_cc_padre_reporte
end type
type pb_1 from picturebutton within w_antiguedad_imp_cxp
end type
type cb_1 from commandbutton within w_antiguedad_imp_cxp
end type
end forward

global type w_antiguedad_imp_cxp from w_cc_padre_reporte
integer x = 5
integer y = 100
integer width = 3534
integer height = 1980
string title = "Saldos de Proveedores"
string menuname = "m_hs"
boolean controlmenu = false
boolean resizable = true
windowtype windowtype = main!
long backcolor = 8421376
pb_1 pb_1
cb_1 cb_1
end type
global w_antiguedad_imp_cxp w_antiguedad_imp_cxp

type variables
str_rangofecha istr_rangfech

end variables

forward prototypes
public subroutine wf_botones ()
end prototypes

public subroutine wf_botones ();// Deshabilita algunas Opciones del Menú 

//	m_cc_principal.m_edicin.m_cancelar.toolbaritemvisible=false
//	m_cc_principal.m_edicin.m_cancelar.visible=false
	
	m_cc_principal.m_archivo.m_guardar.toolbaritemvisible=false
	m_cc_principal.m_archivo.m_guardar.visible=false
	m_cc_principal.m_archivo.m_guardar.enabled=false
	/*Filtrar*/
	m_cc_principal.m_edicin.m_filtrar.toolbaritemvisible=false
	m_cc_principal.m_edicin.m_filtrar.visible=false
	
	/*Sortear*/
	m_cc_principal.m_edicin.m_sortear.toolbaritemvisible=false
	m_cc_principal.m_edicin.m_sortear.visible=false
	
	/*Primer Reg*/
	m_cc_principal.m_edicin.m_primerregistro.toolbaritemvisible=false
	m_cc_principal.m_edicin.m_primerregistro.visible=false
	
	/*Ultimo Reg*/
	m_cc_principal.m_edicin.m_ultimoregistro.toolbaritemvisible=false
	m_cc_principal.m_edicin.m_ultimoregistro.visible=false
	
	m_cc_principal.m_edicin.m_busqueda.toolbaritemvisible=false
	m_cc_principal.m_edicin.m_busqueda.visible=false
	/*Sig Reg*/
	m_cc_principal.m_edicin.m_siguienteregistro.toolbaritemvisible=false
	m_cc_principal.m_edicin.m_siguienteregistro.visible=false
	
  /*Reg Ant*/
	m_cc_principal.m_edicin.m_registroanterior.toolbaritemvisible=false
	m_cc_principal.m_edicin.m_registroanterior.visible=false

  /*Imprimir*/
   m_cc_principal.m_archivo.m_imprimir.toolbaritemvisible=true
	m_cc_principal.m_archivo.m_imprimir.visible=true
	
  /*Insertar*/
	m_cc_principal.m_edicin.m_insertar.toolbaritemvisible=false
	m_cc_principal.m_edicin.m_insertar.visible=false
	
	/*Adicionar*/
	m_cc_principal.m_edicin.m_adicionar.toolbaritemvisible=false
	m_cc_principal.m_edicin.m_adicionar.visible=false
	
	/*Eliminar*/
	m_cc_principal.m_edicin.m_eliminar.toolbaritemvisible=false
	m_cc_principal.m_edicin.m_eliminar.visible=false
	
end subroutine

on w_antiguedad_imp_cxp.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.pb_1=create pb_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.cb_1
end on

on w_antiguedad_imp_cxp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.cb_1)
end on

event resize;//OVERRIDE
//this.SetRedraw(false)
dw_1.width  = this.width  - 125
dw_1.height = this.height - 300
gb_1.width  = this.width  - 63
gb_1.height = this.height - 150
//
//
//st_nom_ventana.x = 28
//st_nom_ventana.y = this.height - 180
//this.SetRedraw(true)
end event

event ue_post_open;call super::ue_post_open;string ls_fecha
date ld_fecha

ls_fecha = Message.StringParm	

dw.Object.datawindow.print.preview = true

dw.retrieve(str.g_financiero,str.empresa)

dw_1.object.fecha.Expression ="'"+ ls_fecha+"'"

end event

event ue_reg_anterior;dw.ScrollPriorPage( )
end event

event ue_siguiente_reg;dw.scrollNextpage()
end event

event open;//override
This.Icon = str.icono
this.postevent("ue_post_open")

sqlca.autocommit = true
//this.width=3000
//this.height=1557
//

THIS.SetToolbar(1, true, alignattop!)
THIS.SetToolbarPos(1, 1, 50, false)
//gf_center_win(This)

end event

<<<<<<< HEAD
=======
event ue_vista;//if dw_1.object.datawindow.print.preview="no" then
//   dw_1.object.datawindow.print.preview="yes"
//else 
//	dw_1.object.datawindow.print.preview="no"
//end if

string ls_estado
ls_estado = dw.Describe("DataWindow.Print.Preview")
If Upper(ls_estado) = 'YES' Then
	dw.Modify("DataWindow.Print.Preview = No")
Else
	dw.Modify("DataWindow.Print.Preview = Yes")
End If
 
end event

>>>>>>> feature/Inventario
type st_ayuda from w_cc_padre_reporte`st_ayuda within w_antiguedad_imp_cxp
end type

type st_nom_ventana from w_cc_padre_reporte`st_nom_ventana within w_antiguedad_imp_cxp
boolean visible = false
integer x = 37
integer y = 1744
integer width = 55
end type

type dw_1 from w_cc_padre_reporte`dw_1 within w_antiguedad_imp_cxp
integer x = 37
integer y = 76
integer width = 3419
integer height = 1604
integer taborder = 10
string dataobject = "dw_cp_antiguedad_proveedores"
end type

event dw_1::clicked;call super::clicked;////
//string ls_proveedor
//long ll_tercero
//date fecha, fecha1
//
//	fecha	= relativedate(date(gf_fecha_serv()), - 365)
////	fecha = date('01/01/'+string(year(date(gf_fecha_serv()))))
//	fecha1 = date(gf_fecha_serv())
//			
//	str_rangofecha str_formato1		
//	ls_proveedor = dw_1.getitemString(row,"prov_cod_proveedor")
//	
//	SELECT isnull(cpmprove.prov_tercero  ,0)
//    INTO :ll_tercero  
//    FROM cpmprove  
//   WHERE ( cpmprove.prov_g_financiero = :str.g_financiero ) AND  
//         ( cpmprove.prov_empresa = :str.empresa ) AND  
//         ( cpmprove.prov_cod_proveedor = :ls_proveedor )  ;
//		if sqlca.sqlcode = -1 then
//			gf_mensaje('','Error al seleccionar codigo '+sqlca.sqlerrtext,1,1,'E')
//			return
//		end if
//	
//	str_formato1.codigo = ll_tercero
//	str_formato1.fecha1  = fecha
//	str_formato1.fecha2  = fecha1	
//	Opensheetwithparm(w_estadocuenta_imp_cxp,str_formato1,str.frame,2,layered!)
end event

type gb_1 from w_cc_padre_reporte`gb_1 within w_antiguedad_imp_cxp
integer x = 14
integer width = 3470
integer height = 1660
integer taborder = 30
long backcolor = 8421376
end type

type pb_1 from picturebutton within w_antiguedad_imp_cxp
boolean visible = false
integer x = 3273
integer y = 1704
integer width = 146
integer height = 120
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
alignment htextalign = left!
end type

event clicked;parent.TriggerEvent("ue_print")
end event

type cb_1 from commandbutton within w_antiguedad_imp_cxp
boolean visible = false
integer x = 2309
integer y = 1740
integer width = 992
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reporte de Antiguiedad sin líneas"
end type

event clicked;if dw_1.object.dw_1.dataobject = 'dw_cp_nestinf_antiguedad_grid' then 
	dw_1.object.dw_1.dataobject = 'dw_cp_nestinf_antiguedad'
	this.text = 'Reporte de Antiguiedad sin líneas'
else 
	dw_1.object.dw_1.dataobject = 'dw_cp_nestinf_antiguedad_grid'
	this.text = 'Reporte de Antiguiedad con líneas'	
end if
dw.reset()
dw.retrieve(str.g_financiero,str.empresa)









end event

