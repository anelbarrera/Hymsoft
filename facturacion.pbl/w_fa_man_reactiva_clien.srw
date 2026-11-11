//objectcomments Ventana que actualiza el monto de las facturas de los clientes en Cuentas por Cobrar
forward
global type w_fa_man_reactiva_clien from w_fa_padre
end type
type gb_3 from groupbox within w_fa_man_reactiva_clien
end type
type gb_2 from groupbox within w_fa_man_reactiva_clien
end type
type gb_1 from groupbox within w_fa_man_reactiva_clien
end type
type st_2 from statictext within w_fa_man_reactiva_clien
end type
type rb_1 from radiobutton within w_fa_man_reactiva_clien
end type
type rb_2 from radiobutton within w_fa_man_reactiva_clien
end type
type rb_3 from radiobutton within w_fa_man_reactiva_clien
end type
type rb_4 from radiobutton within w_fa_man_reactiva_clien
end type
type rb_5 from radiobutton within w_fa_man_reactiva_clien
end type
type dw_2 from datawindow within w_fa_man_reactiva_clien
end type
type st_hasta from statictext within w_fa_man_reactiva_clien
end type
type rb_todas from radiobutton within w_fa_man_reactiva_clien
end type
type rb_desmarcar from radiobutton within w_fa_man_reactiva_clien
end type
type cb_imprimir from commandbutton within w_fa_man_reactiva_clien
end type
type st_3 from statictext within w_fa_man_reactiva_clien
end type
type dw_3 from datawindow within w_fa_man_reactiva_clien
end type
type em_desde from editmask within w_fa_man_reactiva_clien
end type
type em_hasta from editmask within w_fa_man_reactiva_clien
end type
type cbx_1 from checkbox within w_fa_man_reactiva_clien
end type
type cb_1 from commandbutton within w_fa_man_reactiva_clien
end type
type gb_periodo from groupbox within w_fa_man_reactiva_clien
end type
type st_31 from statictext within w_fa_man_reactiva_clien
end type
type cbx_2 from checkbox within w_fa_man_reactiva_clien
end type
type cbx_3 from checkbox within w_fa_man_reactiva_clien
end type
type cbx_4 from checkbox within w_fa_man_reactiva_clien
end type
type cbx_5 from checkbox within w_fa_man_reactiva_clien
end type
end forward

global type w_fa_man_reactiva_clien from w_fa_padre
integer width = 2807
integer height = 1552
string title = "(FA) Reactivar Factura para el Pase a Inventarios / CXC / Contabilidad"
string menuname = "m_hs"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
st_2 st_2
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
rb_5 rb_5
dw_2 dw_2
st_hasta st_hasta
rb_todas rb_todas
rb_desmarcar rb_desmarcar
cb_imprimir cb_imprimir
st_3 st_3
dw_3 dw_3
em_desde em_desde
em_hasta em_hasta
cbx_1 cbx_1
cb_1 cb_1
gb_periodo gb_periodo
st_31 st_31
cbx_2 cbx_2
cbx_3 cbx_3
cbx_4 cbx_4
cbx_5 cbx_5
end type
global w_fa_man_reactiva_clien w_fa_man_reactiva_clien

type variables
string is_filter
str_fa_carg_ped str_pedi
datetime idt_fecha_invent
date idt_fecha_cxc, idt_fecha_conta
string is_user

end variables

forward prototypes
public subroutine wf_botones ()
end prototypes

public subroutine wf_botones ();//// Deshabilita algunas Opciones del Menú 
//   /*Insertar*/
//	m_fa_principal.m_edicin.m_insertar.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_insertar.visible=false
	
//	/*Adicionar*/
//	m_fa_principal.m_edicin.m_adicionar.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_adicionar.visible=false
	
//	/*Filtrar*/
//	m_fa_principal.m_edicin.m_filtrar.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_filtrar.visible=false
	
//	/*Sortear*/
//	m_fa_principal.m_edicin.m_sortear.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_sortear.visible=false
	
//	/*Primer Reg*/
//	m_fa_principal.m_edicin.m_primerregistro.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_primerregistro.visible=false
	
//	/*Ultimo Reg*/
//	m_fa_principal.m_edicin.m_ultimoregistro.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_ultimoregistro.visible=false
	
//	/*Sig Reg*/
//	m_fa_principal.m_edicin.m_siguienteregistro.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_siguienteregistro.visible=false
	

//   /*Reg Ant*/
//	m_fa_principal.m_edicin.m_registroanterior.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_registroanterior.visible=false

//   /*Imprimir*/
//   m_fa_principal.m_archivo.m_imprimir.toolbaritemvisible=false
//	m_fa_principal.m_archivo.m_imprimir.visible=false
	
//	/*Eliminar*/
//	m_fa_principal.m_edicin.m_eliminar.toolbaritemvisible=false
//	m_fa_principal.m_edicin.m_eliminar.visible=false

end subroutine

on w_fa_man_reactiva_clien.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_2=create st_2
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.rb_4=create rb_4
this.rb_5=create rb_5
this.dw_2=create dw_2
this.st_hasta=create st_hasta
this.rb_todas=create rb_todas
this.rb_desmarcar=create rb_desmarcar
this.cb_imprimir=create cb_imprimir
this.st_3=create st_3
this.dw_3=create dw_3
this.em_desde=create em_desde
this.em_hasta=create em_hasta
this.cbx_1=create cbx_1
this.cb_1=create cb_1
this.gb_periodo=create gb_periodo
this.st_31=create st_31
this.cbx_2=create cbx_2
this.cbx_3=create cbx_3
this.cbx_4=create cbx_4
this.cbx_5=create cbx_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.rb_1
this.Control[iCurrent+6]=this.rb_2
this.Control[iCurrent+7]=this.rb_3
this.Control[iCurrent+8]=this.rb_4
this.Control[iCurrent+9]=this.rb_5
this.Control[iCurrent+10]=this.dw_2
this.Control[iCurrent+11]=this.st_hasta
this.Control[iCurrent+12]=this.rb_todas
this.Control[iCurrent+13]=this.rb_desmarcar
this.Control[iCurrent+14]=this.cb_imprimir
this.Control[iCurrent+15]=this.st_3
this.Control[iCurrent+16]=this.dw_3
this.Control[iCurrent+17]=this.em_desde
this.Control[iCurrent+18]=this.em_hasta
this.Control[iCurrent+19]=this.cbx_1
this.Control[iCurrent+20]=this.cb_1
this.Control[iCurrent+21]=this.gb_periodo
this.Control[iCurrent+22]=this.st_31
this.Control[iCurrent+23]=this.cbx_2
this.Control[iCurrent+24]=this.cbx_3
this.Control[iCurrent+25]=this.cbx_4
this.Control[iCurrent+26]=this.cbx_5
end on

on w_fa_man_reactiva_clien.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_2)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.dw_2)
destroy(this.st_hasta)
destroy(this.rb_todas)
destroy(this.rb_desmarcar)
destroy(this.cb_imprimir)
destroy(this.st_3)
destroy(this.dw_3)
destroy(this.em_desde)
destroy(this.em_hasta)
destroy(this.cbx_1)
destroy(this.cb_1)
destroy(this.gb_periodo)
destroy(this.st_31)
destroy(this.cbx_2)
destroy(this.cbx_3)
destroy(this.cbx_4)
destroy(this.cbx_5)
end on

event ue_post_open;integer li_mes, li_ann
em_desde.text = string(RelativeDate(date(gf_fecha_serv()), - 30))
em_hasta.text = string(date(gf_fecha_serv()))
	/*ADDED BY HGN/05/07/2002*/ //cambio inicio
	This.SetRedraw(False)
	if pos( upper(str.empr_acceso_especial),'ACISA,') >0 then
		String	ls_autoriza_s_n,ls_autoriza
		is_user =''
		if w_fa_fondo.str_aplica_links.controla_modificaciones =1 then /*Controla modificaciones*/	
			is_user ='yes'
			openwithparm(w_dg_man_clave,ls_autoriza)
			
			ls_autoriza_s_n = Message.StringParm 
			
			CHOOSE CASE ls_autoriza_s_n
			CASE '1'	//Usuario Autorizado
			CASE '2'	//Usuario no Autorizado
				messagebox('Atención ','Estimado Usuario Ud. no está autorizado para Restaurar Pedido para Pase IN, C*C CO, consulte a su Supervisor...!!!')
				close(this)
				return
			CASE ELSE
				close(this)
				return
			END CHOOSE
		
		end if
	end if
//cambio final


dw_1.SetTransObject(Sqlca)
dw_2.SetTransObject(Sqlca)


//dw_1.Retrieve(str.g_financiero,str.empresa)
dw_1.insertrow(0)

dw_2.InsertRow(0)
dw_2.SetFocus()

//Selecciona la fecha de cierre de inventario

  SELECT inaparam.para_cierre_inventario  
    INTO :idt_fecha_invent  
    FROM inaparam  
   WHERE ( inaparam.para_g_financiero = :str.g_financiero ) AND  
         ( inaparam.para_empresa = :str.empresa );
	if sqlca.sqlcode = -1 then
		mensaje('Aviso','Error al Seleccionar la Fecha de Parámetros de Inventarios',sqlca.sqlerrtext)
	end if

if idt_fecha_invent < datetime('01/01/1999 00:00:00') or isnull(idt_fecha_invent) then 
	idt_fecha_invent = datetime(RelativeDate(date(gf_fecha_serv()), - 365))
end if

//Selecciona la fecha de cierre de cuentas por cobrar
	
  SELECT ccmparam.para_mes,   
         ccmparam.para_ano  
    INTO :li_mes,   
         :li_ann  
    FROM ccmparam  
   WHERE ( ccmparam.para_g_financiero = :str.g_financiero ) AND  
         ( ccmparam.para_empresa = :str.empresa )   ;
	if sqlca.sqlcode = -1 then
		mensaje('Aviso','Error al Seleccionar la Fecha de Parámetros de CXC',sqlca.sqlerrtext)
	end if

idt_fecha_cxc = date('01/'+string(li_mes)+'/'+string(li_ann))

if idt_fecha_cxc < date('01/01/1990') or isnull(idt_fecha_cxc) then 
	idt_fecha_cxc = date(RelativeDate(date(gf_fecha_serv()), - 365))
end if

//Seleccion del mes de proceso de contabilidad
  SELECT comparam.para_an_fiscal_actual,   
         comparam.para_mes_fiscal_actual  
    INTO :li_ann,   
         :li_mes  
    FROM comparam  
   WHERE ( comparam.para_g_financiero = :str.g_financiero ) AND  
         ( comparam.para_empresa = :str.empresa );
	if sqlca.sqlcode = -1 then
		mensaje('Aviso','Error al Seleccionar la Fecha de Parámetros de Contabilidad',sqlca.sqlerrtext)
	end if

idt_fecha_conta = date('01/'+string(li_mes)+'/'+string(li_ann))

if idt_fecha_conta < date('01/01/1990') or isnull(idt_fecha_conta) then 
	idt_fecha_conta = date(RelativeDate(date(gf_fecha_serv()), - 365))
end if

This.SetRedraw(True)
end event

event ue_aceptar;//Override Ancestor Script
Long    ll_update, i
Integer li_reg_check, li_filas, li_insert_mov, li_error, li_anio
string ls_error, ls_no_pedido, ls_tipo_fac

dw_1.AcceptText()

if gf_mensaje("","¿ Está Seguro que Desea ACTUALIZAR las Transacciones Seleccionadas ?",2,1,"E") = 2 then return

sqlca.autocommit = false

ll_update = dw.update()
If ll_update = 1  And li_error = 0 Then
		if dw.dataobject = 'dw_ma_fa_reactiva_inve' then
			dw.setfilter('fact_act_inventario = 0')
			dw.filter()
			
			for i = 1 to dw.rowcount()

				 ls_no_pedido = dw.getitemstring(i,'fact_no_pedido')
				 ls_tipo_fac  = dw.getitemstring(i,'fact_tipo')
				 li_anio		  = dw.getitemnumber(i,'fact_ann')
				 
				 DECLARE proc_reserva PROCEDURE FOR sp_reserva_factura_activada  
					@p_gf = :str.g_financiero,   
					@p_emp = :str.empresa,   
					@p_pedido = :ls_no_pedido,   
					@p_tipo	= :ls_tipo_fac,
					@p_ann = :li_anio  ;
				 
				 execute proc_reserva ;
					if sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrtext
						rollback;
						mensaje("Aviso","Error al actualizar la Reserva en faddiari (Procedimiento)",ls_error)
						sqlca.autocommit = true
						dw.setfilter('')
						dw.filter()										
						return
					end if														
					

			next
			
			dw.setfilter('')
			dw.filter()			
		end if			

	Commit Using Sqlca;
	messagebox("Atención","¡Actualización Exitosa !")
		 
	This.SetRedraw(False)
	dw_1.Retrieve(str.g_financiero,str.empresa)
	This.SetRedraw(True)
Else
	messagebox("Atención Sr. Usuario","¡Error al Actualizar ! "+sqlca.sqlerrtext)
	Rollback Using Sqlca;			
	dw_1.Retrieve(str.g_financiero,str.empresa)			
End If

sqlca.autocommit = true
end event

event open;//This.SetRedraw(False)
////wf_botones()

//This.SetRedraw(True)

dw = dw_1
this.postevent("ue_post_open")

end event

event resize;//Override
end event

event close;Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
 
end event

event closequery;constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)

This.SetRedraw(false)
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_man_reactiva_clien
boolean visible = false
integer x = 27
integer y = 1284
integer width = 832
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_man_reactiva_clien
integer x = 37
integer y = 116
integer width = 2697
integer height = 820
integer taborder = 0
string dataobject = "dw_ma_fa_reactiva_inve"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_1::sqlpreview;call super::sqlpreview;datetime		ldt_fecha_inventario

if cbx_4.checked = true then
	if cbx_3.checked then //Si es de CXC
		if date(em_desde.text) < idt_fecha_cxc then
			em_desde.text = string(date(idt_fecha_cxc))
			mensaje('Aviso','No se pueden Reabrir transacciones que pertenecen a un mes Cerrado (CXC)','')			
		end if	
	elseif cbx_5.checked then //Si es Contabilidad
		if date(em_desde.text) < idt_fecha_conta then 
			em_desde.text = string(idt_fecha_conta)
			mensaje('Aviso','No se pueden Reabrir transacciones que pertenecen a un mes Cerrado (Conta.)','')
		end if
	else						 	  //Si es Inventario
		if date(em_desde.text) < date(idt_fecha_conta) then
			em_desde.text = string(date(idt_fecha_conta))
			mensaje('Aviso','No se pueden Reabrir transacciones que pertenecen a un mes Cerrado (Invent.)','')			
		end if
	end if
	//Recupera
	sqlsyntax = sqlsyntax + " and (fatdiari.fact_fecha >= '" + string(date(em_desde.text),"mm/dd/yyyy") + " 00:00:00') and (fatdiari.fact_fecha <= '"+string(date(em_hasta.text),"mm/dd/yyyy")+ " 23:59:59') " 	
	This.SetSqlPreview(sqlsyntax)				
end if


end event

type st_ayuda from w_fa_padre`st_ayuda within w_fa_man_reactiva_clien
end type

type gb_3 from groupbox within w_fa_man_reactiva_clien
integer x = 23
integer y = 956
integer width = 1504
integer height = 292
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79416533
string text = " Búsquedas "
end type

type gb_2 from groupbox within w_fa_man_reactiva_clien
integer x = 1541
integer y = 956
integer width = 507
integer height = 292
integer textsize = -6
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
end type

type gb_1 from groupbox within w_fa_man_reactiva_clien
integer x = 18
integer width = 2734
integer height = 956
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long backcolor = 79416533
string text = "Recuperar de "
end type

type st_2 from statictext within w_fa_man_reactiva_clien
integer x = 2107
integer y = 1044
integer width = 210
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long backcolor = 79416533
boolean enabled = false
string text = "Desde :"
boolean focusrectangle = false
end type

type rb_1 from radiobutton within w_fa_man_reactiva_clien
integer x = 50
integer y = 1024
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Cliente"
boolean lefttext = true
end type

event clicked;dw_2.PostEvent("edithchanged")
end event

type rb_2 from radiobutton within w_fa_man_reactiva_clien
integer x = 338
integer y = 1024
integer width = 251
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "# R.U.C."
boolean lefttext = true
end type

event clicked;dw_2.PostEvent("edithchanged")
end event

type rb_3 from radiobutton within w_fa_man_reactiva_clien
integer x = 631
integer y = 1024
integer width = 238
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "# Ped. "
boolean lefttext = true
end type

event clicked;dw_2.PostEvent("edithchanged")
end event

type rb_4 from radiobutton within w_fa_man_reactiva_clien
integer x = 64
integer y = 1132
integer width = 233
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "# Fact."
boolean lefttext = true
end type

event clicked;dw_2.PostEvent("edithchanged")
end event

type rb_5 from radiobutton within w_fa_man_reactiva_clien
integer x = 343
integer y = 1132
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Monto"
boolean lefttext = true
end type

event clicked;dw_2.PostEvent("edithchanged")
end event

type dw_2 from datawindow within w_fa_man_reactiva_clien
integer x = 901
integer y = 1016
integer width = 576
integer height = 80
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_texto"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event editchanged;String ls_letra,formato,ls_setting
This.accepttext()
ls_letra =This.getitemstring(1,1) 

If Match (ls_letra, "%") = True  Then 
	dw_1.SetFilter ("")
	dw_1.Filter()
	Return
End if

If ls_letra = "Texto"  Then Return

//Permite modificar el estado con la finalidad de que funcione el filtrado
ls_setting = dw_1.Describe("DataWindow.Retrieve.AsNeeded")

If ls_setting = "yes" Then 
   dw_1.Modify("DataWindow.Retrieve.AsNeeded=No")	
End If	

IF rb_4.Checked = True THEN

		Formato = "fact_no_factura like " +"'"+ls_letra+"%"+"'"

ELSEIF rb_2.Checked = True THEN

		Formato = "fact_ruc_cliente like " +"'"+ls_letra+"%"+"'"
	
    ELSEIF rb_1.Checked = True THEN
		
	       Formato = "dgmterce_terc_descripcion like " +"'"+ls_letra+"%"+"'"
		
		  ELSEIF rb_3.Checked = True THEN

		      Formato = "String("  + "fact_no_pedido)"  + "like "   + "'" + ls_letra +"%" + "'"
			
			 ELSEIF rb_5.Checked = True THEN

					Formato = "String("  + "fact_monto_final)"  + "like "   + "'" + ls_letra +"%" + "'"
END IF
  
// Filtra

If Formato <> "" Then
	dw_1.SetFilter (Formato)
	dw_1.Filter()
End If
end event

type st_hasta from statictext within w_fa_man_reactiva_clien
integer x = 2107
integer y = 1136
integer width = 238
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long backcolor = 79416533
boolean enabled = false
string text = "Hasta :"
boolean focusrectangle = false
end type

type rb_todas from radiobutton within w_fa_man_reactiva_clien
integer x = 1595
integer y = 1028
integer width = 425
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
string text = "Marcar Todas "
boolean lefttext = true
end type

event clicked;Long	ll_count
If dw_1.Rowcount() > 0 then
	if dw_1.dataobject = 'dw_ma_fa_reactiva_conta' then
		For ll_count = 1 to dw_1.rowcount()
			dw_1.SetItem(ll_count,"fatdiari_fact_act_conta",0)
		Next					
	else
		For ll_count = 1 to dw_1.rowcount()
			dw_1.SetItem(ll_count,"fact_act_inventario",0)
		Next	
	end if
Else
	mensaje("Atención ","No hay facturas por actualizar en este período","")
End If

end event

type rb_desmarcar from radiobutton within w_fa_man_reactiva_clien
integer x = 1595
integer y = 1132
integer width = 425
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
string text = "Desmarcar"
boolean lefttext = true
end type

event clicked;Long	ll_count

If dw_1.Rowcount() > 0 then
  For ll_count = 1 to dw_1.rowcount()
	if dw_1.dataobject = 'dw_ma_fa_reactiva_conta' then
		If dw_1.GetItemNumber(ll_count,"fatdiari_fact_act_conta") = 0 Then
			dw_1.SetItem(ll_count,"fatdiari_fact_act_conta",1)
		End if	
	else
		If dw_1.GetItemNumber(ll_count,"fact_act_inventario") = 0 Then
			dw_1.SetItem(ll_count,"fact_act_inventario",1)
		End If
	end if
  Next
	//mensaje("Atención ","El proceso de selección ha culminado con éxito ","")
Else
	mensaje("Atención ","No hay facturas seleccionadas","")
End If

end event

type cb_imprimir from commandbutton within w_fa_man_reactiva_clien
integer x = 2281
integer y = 1268
integer width = 471
integer height = 96
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar Reporte"
end type

event clicked;Long	ll_filas,ll_row
String	ls_filtro

If dw_1.rowcount() = 0 then Return


	dw_3.Reset()
	ll_filas =dw_1.RowsCopy(1,dw_1.rowcount(), primary!, dw_3, 1, primary!)
	If dw_3.rowcount() <= 0 then
		mensaje("Atención","No hay data para este reporte.. seleccione las facturas a pasar","")
		return
	end if
	str_pedi.vienede = 'act_clien'	
	str_pedi.dwobject = dw_3
	if cbx_2.checked then 
		str_pedi.datawindow = 'dw_fa_rep_reactiva_inve'
	elseif cbx_3.checked  then
		str_pedi.datawindow = 'dw_fa_rep_reactiva_cliente'
	else 
		return
	end if
	str.frame.SetRedraw ( false )
	OpenSheetWithParm(w_fa_rep_imp_factura_ref, str_pedi, str.frame,9,Layered!)
	str.frame.SetRedraw ( true )


end event

type st_3 from statictext within w_fa_man_reactiva_clien
integer x = 2272
integer y = 1260
integer width = 485
integer height = 108
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_fa_man_reactiva_clien
boolean visible = false
integer x = 87
integer y = 1392
integer width = 2661
integer height = 348
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_fa_rep_actualiza_clien"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type em_desde from editmask within w_fa_man_reactiva_clien
integer x = 2350
integer y = 1028
integer width = 343
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

event modified;IF trim(em_desde.text) <> '' and not isNull(em_desde.text) Then
	if cbx_2.checked then 	//si es para restaurar inventario		
		If date(em_desde.text) < date(idt_fecha_invent) Then
			 mensaje("Atención ","Digite una fecha correcta o  superior al mes de proceso de inventario","")
			 em_desde.text = string(date(idt_fecha_invent))		 
			 this.setfocus()
			 return
		End if
	Elseif cbx_3.checked then  //Si es para restaurar cuentas por cobrar
		If date(em_desde.text) < idt_fecha_cxc Then
			 mensaje("Atención ","Digite una fecha correcta o  superior al mes de proceso de Cuentas por Cobrar","")
			 em_desde.text = string(idt_fecha_cxc)
			 this.setfocus()
			 return
		End if				
	Else//Si es conta
		If date(em_desde.text) < idt_fecha_conta Then
			 mensaje("Atención ","Digite una fecha correcta o  superior al mes de proceso de Contabilidad","")
			 em_desde.text = string(idt_fecha_conta)
			 this.setfocus()
			 return
		End if				
	End if
End If
end event

type em_hasta from editmask within w_fa_man_reactiva_clien
integer x = 2350
integer y = 1136
integer width = 343
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type cbx_1 from checkbox within w_fa_man_reactiva_clien
integer x = 2149
integer y = 956
integer width = 539
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
string text = "Filtrar por Fechas"
boolean checked = true
end type

event clicked;
string ls_filtro 
IF cbx_1.checked then 
	ls_filtro = "string(fact_fecha,'yyyy/mm/dd') >= '"  & 
				+string(date(em_desde.text),"yyyy/mm/dd")+"' and "  + &
				"string(fact_fecha,'yyyy/mm/dd') <= '"  & 
				+string(date(em_hasta.text),"yyyy/mm/dd") + "'"
	dw_1.SetFilter(ls_filtro)
	dw_1.Filter( )
else 
	dw_1.SetFilter("")
	dw_1.Filter( )
end if
end event

type cb_1 from commandbutton within w_fa_man_reactiva_clien
integer x = 997
integer y = 1128
integer width = 471
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Eliminar Filtros"
end type

event clicked;dw_1.SetFilter ("")
dw_1.Filter()


end event

type gb_periodo from groupbox within w_fa_man_reactiva_clien
integer x = 2066
integer y = 956
integer width = 686
integer height = 292
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
end type

type st_31 from statictext within w_fa_man_reactiva_clien
integer x = 987
integer y = 1120
integer width = 485
integer height = 108
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cbx_2 from checkbox within w_fa_man_reactiva_clien
integer x = 389
integer y = 48
integer width = 430
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 8388608
long backcolor = 79416533
string text = "Inventarios"
end type

event clicked;cbx_2.checked = true
if cbx_2.checked then 
	cbx_3.checked = false
	cbx_5.checked = false
//   st_1.text ='Activacion de Facturas para el Pase a Inventarios '	
	parent.title ='Activacion de Facturas para el Pase a Inventarios '	
	cb_imprimir.enabled = true	
   if dw_1.dataobject <> 'dw_ma_fa_reactiva_inve' then
		dw_1.dataobject = 'dw_ma_fa_reactiva_inve'
		//em_desde.text = string(RelativeDate(date(gf_fecha_serv()), - 30))
		//em_hasta.text = string(date(gf_fecha_serv()))
	end if
	dw_1.SetTransObject(Sqlca)
	dw_1.retrieve(str.g_financiero, str.empresa)
else 
	cb_imprimir.enabled = false
end if
end event

type cbx_3 from checkbox within w_fa_man_reactiva_clien
integer x = 978
integer y = 52
integer width = 603
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 8388608
long backcolor = 79416533
string text = "Cuentas X Cobrar"
boolean checked = true
end type

event clicked;cbx_3.checked = true
if cbx_3.checked then 
	cbx_2.checked = false
	cbx_5.checked = false
//   st_1.text ='Activacion de Facturas para el Pase a Cuentas por Cobrar '	
   parent.title = 'Activacion de Facturas para el Pase a Cuentas por Cobrar '	
	cb_imprimir.enabled = true	
  if dw_1.dataobject <> 'dw_ma_fa_reactiva_clien' then
	   dw_1.dataobject = 'dw_ma_fa_reactiva_clien'
//		em_desde.text = string(RelativeDate(date(gf_fecha_serv()), - 30))
//		em_hasta.text = string(date(gf_fecha_serv()))
	end if	
	dw_1.SetTransObject(Sqlca)
	dw_1.retrieve(str.g_financiero, str.empresa)
else 
	cb_imprimir.enabled = false
end if
end event

type cbx_4 from checkbox within w_fa_man_reactiva_clien
integer x = 2377
integer y = 40
integer width = 370
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
string text = "Usar Fecha"
boolean checked = true
end type

type cbx_5 from checkbox within w_fa_man_reactiva_clien
integer x = 1678
integer y = 40
integer width = 439
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 8388608
long backcolor = 79416533
string text = "Contabilidad"
end type

event clicked;cbx_5.checked = true
if cbx_5.checked then 
	cbx_2.checked = false
	cbx_3.checked = false
//   st_1.text ='Activacion de Facturas para el Pase a Cuentas por Cobrar '	
   parent.title = 'Activacion de Facturas para el Pase a Contabilidad '	
	cb_imprimir.enabled = true	
  if dw_1.dataobject <> 'dw_ma_fa_reactiva_conta' then
	   dw_1.dataobject = 'dw_ma_fa_reactiva_conta'
		//em_desde.text = string(RelativeDate(date(gf_fecha_serv()), - 30))
		//em_hasta.text = string(date(gf_fecha_serv()))
	end if	
	dw_1.SetTransObject(Sqlca)
	dw_1.retrieve(str.g_financiero, str.empresa)
else 
	cb_imprimir.enabled = false
end if
end event

