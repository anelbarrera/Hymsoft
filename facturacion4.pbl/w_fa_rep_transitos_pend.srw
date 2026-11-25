//objectcomments Ventana de Impresión del listado de los Pedidos Reservados pendientes de Factura
forward
global type w_fa_rep_transitos_pend from w_fa_padre_reportes
end type
end forward

global type w_fa_rep_transitos_pend from w_fa_padre_reportes
integer width = 2912
integer height = 1524
string title = "(FA) Reporte de Productos Reservados en Tránsito"
string menuname = "m_hs"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
end type
global w_fa_rep_transitos_pend w_fa_rep_transitos_pend

on w_fa_rep_transitos_pend.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_hs" then this.MenuID = create m_hs
end on

on w_fa_rep_transitos_pend.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;str_rangofecha lstr_rangfech
string ls_empresa
datetime	ldt_fecha1,ldt_fecha2

lstr_rangfech = message.powerObjectParm
ldt_fecha1 = datetime(lstr_rangfech.fecha1,00:00:00)
ldt_fecha2 = datetime(lstr_rangfech.fecha2,23:59:59)
If lstr_rangfech.opcion = 'Tránsito' then
	dw_1.DataObject = "dw_fa_rep_prod_tran"
elseif  lstr_rangfech.opcion = 'Confirmacion' then
	
	dw_1.DataObject = "dw_fa_rep_prod_conf"
elseif lstr_rangfech.opcion = 'Ambos' then
	dw_1.DataObject = "dw_fa_rep_prod_conf_tran"
end If

dw = dw_1
dw.settransobject(sqlca)

//******************************************************************************************

	 If w_hs_frame.str_para.utiliza_decimales = 1 Then	 //Con decimales		
		
		If dw_1.Describe("fadpedid_dped_cantidad.x") <> "?" And &
		   dw_1.Describe("fadpedid_dped_cantidad.x") <> "!" Then
			dw_1.modify("fadpedid_dped_cantidad.format='###,###,##0.00'")
			
		End If			 

		If dw_1.Describe("cantidad_por_producto.x") <> "?" And &
		   dw_1.Describe("cantidad_por_producto.x") <> "!" Then

		   dw_1.modify("cantidad_por_producto.format='###,###,##0.00'")
			
		End if
		
		//		
	
		If dw_1.Describe("fadpedid_dped_fraccion.x") <> "?" And &
		                 dw_1.Describe("fadpedid_dped_fraccion.x") <> "!" Then
							  
		 dw_1.modify("fadpedid_dped_fraccion.visible=False")
		 
		End If			 

		If dw_1.Describe("t_14.x") <> "?" And dw_1.Describe("t_14.x") <> "!" Then
			
		 dw_1.modify("t_14.visible=False")
		 
		End If			 		

		If dw_1.Describe("t_15.x") <> "?" And dw_1.Describe("t_15.x") <> "!" Then
			
		 dw_1.modify("t_15.visible=False")
		 
		End If			 		

		If dw_1.Describe("fraccion_por_producto.x") <> "?" And &
		   dw_1.Describe("fraccion_por_producto.x") <> "!" Then		
			
			dw_1.modify("fraccion_por_producto.visible=False")		
			
		End If		
		
		//	
		
		
	 Else	                          							//Sin Decimales
		
	
			If dw_1.Describe("fadpedid_dped_fraccion.x") <> "?" And &
								  dw_1.Describe("fadpedid_dped_fraccion.x") <> "!" Then
	
			 dw_1.modify("fadpedid_dped_fraccion.visible=True")
		
			End If			 
			
			If dw_1.Describe("t_14.x") <> "?" And dw_1.Describe("t_14.x") <> "!" Then
	
			 dw_1.modify("t_14.visible=True")
			 
			End If			 		
			
			If dw_1.Describe("t_15.x") <> "?" And dw_1.Describe("t_15.x") <> "!" Then
	
			 dw_1.modify("t_15.visible=True")
			 
			End If			 				
			
			If dw_1.Describe("fraccion_por_producto.x") <> "?" And &
				dw_1.Describe("fraccion_por_producto.x") <> "!" Then		
	
				dw_1.modify("fraccion_por_producto.visible=True")		
				
			End If			
		
		//
		
	 End If		  									 

//******************************************************************************************

dw.object.fecha_repo.expression= "'Del día: "+string(lstr_rangfech.fecha1)+" al "+string(lstr_rangfech.fecha2)+"'"
dw.object.data_window.expression= "'"+dw_1.dataobject+"'"
ls_empresa = gf_dg_nombre_empresa()
if dw.Describe("nomb_empresa.x") <> "?" and dw.Describe("nomb_empresa.x") <> "!" then &
dw.object.nomb_empresa.expression= "'"+ls_empresa+"'"

dw.Object.datawindow.print.preview = true
//if lstr_rangfech.opcion = 'Ambos' then
//	dw.retrieve(str.g_financiero,str.empresa,ldt_fecha1,ldt_fecha2)
//else
dw.retrieve(str.g_financiero,str.empresa,lstr_rangfech.fecha1,lstr_rangfech.fecha2)
//end if

//if dw.rowcount() = 0 then 
//	Messagebox('Aviso','No Existe Información...')
//	return
//End if	
	


end event

event resize;//Override
this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 278
gb_1.width  = this.width  - 63
gb_1.height = this.height - 220


st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180
this.SetRedraw(true)
end event

event close;Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
end event

event closequery;call super::closequery;constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)

This.SetRedraw(false)
end event

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_rep_transitos_pend
boolean visible = false
integer x = 37
integer y = 1288
end type

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_rep_transitos_pend
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_rep_transitos_pend
integer y = 44
integer width = 2789
integer height = 1216
string dataobject = "dw_fa_rep_prod_tran"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_rep_transitos_pend
integer y = 4
integer width = 2821
integer height = 1268
end type

