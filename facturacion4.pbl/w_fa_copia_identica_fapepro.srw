//objectcomments  
forward
global type w_fa_copia_identica_fapepro from w_fa_padre
end type
type gb_anio from groupbox within w_fa_copia_identica_fapepro
end type
type cb_1 from commandbutton within w_fa_copia_identica_fapepro
end type
type cb_2 from commandbutton within w_fa_copia_identica_fapepro
end type
type rb_factura from radiobutton within w_fa_copia_identica_fapepro
end type
type rb_pedido from radiobutton within w_fa_copia_identica_fapepro
end type
type st_1 from statictext within w_fa_copia_identica_fapepro
end type
type dw_2 from datawindow within w_fa_copia_identica_fapepro
end type
type sle_new_no_pedido from singlelineedit within w_fa_copia_identica_fapepro
end type
type rb_proforma from radiobutton within w_fa_copia_identica_fapepro
end type
type st_4 from statictext within w_fa_copia_identica_fapepro
end type
type rb_fac_proforma from radiobutton within w_fa_copia_identica_fapepro
end type
type st_2 from statictext within w_fa_copia_identica_fapepro
end type
type em_ann from editmask within w_fa_copia_identica_fapepro
end type
end forward

global type w_fa_copia_identica_fapepro from w_fa_padre
integer width = 2085
integer height = 836
string title = "Copia Identica - Factura / Pedido / Proforma"
string menuname = "m_hs"
boolean controlmenu = false
long backcolor = 79741120
event ue_enter pbm_dwndragenter
gb_anio gb_anio
cb_1 cb_1
cb_2 cb_2
rb_factura rb_factura
rb_pedido rb_pedido
st_1 st_1
dw_2 dw_2
sle_new_no_pedido sle_new_no_pedido
rb_proforma rb_proforma
st_4 st_4
rb_fac_proforma rb_fac_proforma
st_2 st_2
em_ann em_ann
end type
global w_fa_copia_identica_fapepro w_fa_copia_identica_fapepro

type variables
// Para el filtro de la unidad
datawindowchild idwc_tipo, dwc_fac_pedi
String is_ped_sel, is_fact_sel, is_pro_sel
String is_tipo_repl,is_tipo_sel, is_pedido_repl
Integer ii_ann_sel, ii_ann_repl, ii_ann
end variables

forward prototypes
public subroutine wf_botones ()
public subroutine wf_selec_datawindow ()
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

public subroutine wf_selec_datawindow ();If rb_factura.checked or rb_fac_proforma.checked then
	dw_2.DataObject = 'dw_change_factura_copia_identica'
Else
	If rb_pedido.checked  then
		dw_2.DataObject = 'dw_change_pedido_copia_identica'
	Else
		If rb_proforma.checked then
			dw_2.DataObject = 'dw_change_proforma_copia_identica'
		end if
	end if
End If

dw_2.GetChild ("fact_no_pedido",dwc_fac_pedi)
dw_2.settransobject(sqlca)
dwc_fac_pedi.Settransobject(SQLCA);
if dwc_fac_pedi.retrieve(str.g_financiero,str.empresa,ii_ann) = 0 then dwc_fac_pedi.insertrow(0)
dw_2.InsertRow(0)

end subroutine

on w_fa_copia_identica_fapepro.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.gb_anio=create gb_anio
this.cb_1=create cb_1
this.cb_2=create cb_2
this.rb_factura=create rb_factura
this.rb_pedido=create rb_pedido
this.st_1=create st_1
this.dw_2=create dw_2
this.sle_new_no_pedido=create sle_new_no_pedido
this.rb_proforma=create rb_proforma
this.st_4=create st_4
this.rb_fac_proforma=create rb_fac_proforma
this.st_2=create st_2
this.em_ann=create em_ann
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_anio
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.rb_factura
this.Control[iCurrent+5]=this.rb_pedido
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.sle_new_no_pedido
this.Control[iCurrent+9]=this.rb_proforma
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.rb_fac_proforma
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.em_ann
end on

on w_fa_copia_identica_fapepro.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_anio)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.rb_factura)
destroy(this.rb_pedido)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.sle_new_no_pedido)
destroy(this.rb_proforma)
destroy(this.st_4)
destroy(this.rb_fac_proforma)
destroy(this.st_2)
destroy(this.em_ann)
end on

event ue_post_open;call super::ue_post_open;////dch_bodega.retrieve(str.g_financiero, str.empresa)
//
dw_1.settransobject(sqlca)
DW_1.GetChild ("fact_tipo",idwc_tipo)
idwc_tipo.Settransobject(SQLCA);
idwc_tipo.retrieve(str.g_financiero, str.empresa, "FA")


////Recupera los tipos de Facturas Activas
//
//if idwc_tipo.retrieve(str.g_financiero, str.empresa, "FA") = 0 then
//	mensaje("Aviso","Sr. Usuario, Debe definir los tipos de Facturas en Datos Generales","En (DG), Entre en Parámetros / "+&
//			 +"Parámetros Iniciales / Transacciones / Asociar las Sub-transacciones a Facturación.")
//	idwc_tipo.insertrow(0)
//	this.Postevent("close")
//end if
//
//dw_1.InsertRow(0)
//dw_1.SetFocus()
//
end event

event show;
wf_botones()

end event

event closequery;constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)

This.SetRedraw(false)
end event

event open;call super::open;//dw_1.enabled = false
//dw_1.visible = false
//sle_anio.enabled = false
//sle_anio.visible = false
//sle_new_no_pedido.enabled = false
//sle_new_no_pedido.visible = false
em_ann.text = string(year(date(gf_fecha_serv())))
ii_ann = integer(em_ann.text)
dw_2.DataObject = 'dw_change_factura_copia_identica'
dw_2.settransobject(sqlca)

dw_2.GetChild ("fact_no_pedido",dwc_fac_pedi)
dwc_fac_pedi.Settransobject(SQLCA);
if dwc_fac_pedi.retrieve(str.g_financiero,str.empresa,ii_ann) = 0 then dwc_fac_pedi.insertrow(0)
dw_2.InsertRow(0)


//rb_factura.checked = true


end event

event resize;//Override
end event

event close;//close(This)
Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
 
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_copia_identica_fapepro
boolean visible = false
integer x = 46
integer y = 544
integer width = 754
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_copia_identica_fapepro
event ue_filtra_unidad ( )
boolean visible = false
integer x = 1001
integer y = 340
integer width = 96
integer height = 84
integer taborder = 0
string dataobject = "dw_fa_change_key"
end type

event dw_1::getfocus;//dw = dw_1


end event

event dw_1::rbuttondown;//
end event

event dw_1::itemchanged;call super::itemchanged;is_tipo_repl = data
end event

type st_ayuda from w_fa_padre`st_ayuda within w_fa_copia_identica_fapepro
integer x = 1115
integer y = 340
end type

type gb_anio from groupbox within w_fa_copia_identica_fapepro
integer x = 27
integer width = 1989
integer height = 488
integer taborder = 10
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
end type

type cb_1 from commandbutton within w_fa_copia_identica_fapepro
integer x = 992
integer y = 524
integer width = 270
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;String   ls_no_pedido, ls_no_factura, ls_tipo_fac, ls_ultima_secuencia, ls_sqlerrtext
Integer  li_anio,ll_sw
Boolean	lb_validado,lb_salvo   
long		ll_reg

lb_validado = true
lb_salvo = false

//If dwc_fac_pedi.GetItemString(dwc_fac_pedi.Getrow(),"fatdiari_fact_estado") ='I' then
//	mensaje("Atención","Esta factura ya fue impresa y por lo tanto no puede ser modificada....!!","")
//	lb_validado = false
//	return
//end if

li_anio  = integer(em_ann.text)

If rb_factura.checked = true then
//	is_fact_sel = data
	If is_fact_sel+is_ped_sel ='' or IsNull(is_fact_sel) THEN
//	or Long(is_fact_sel+is_ped_sel) <= 0 Then
		mensaje("Atención","Debe editar un Número de factura válido","")
		dw_2.SetColumn(1)
		dw_2.SetFocus()
		lb_validado = false
		Return
	else
		ll_sw = 1
		select count(*)
		into :ll_reg
		from fatdiari
		where fact_g_financiero = :str.g_financiero
		and   fact_empresa = :str.empresa
		and   fact_no_pedido = :sle_new_no_pedido.text 
		and  fact_ann = :li_anio ;
		if sqlca.sqlcode = -1 then
			ls_sqlerrtext = sqlca.sqlerrtext
			mensaje("Información","Error al verificar registro en fatdiari",ls_sqlerrtext)
			return
		end if			
		

      if ll_reg > 0 then
			messagebox("ATENCION","LA SECUENCIA YA EXISTE")
			return
		end if
	end If
Else
	If rb_pedido.checked = true then
//	is_ped_sel = data
		If is_ped_sel ='' or IsNull(is_ped_sel) Then
			mensaje("Atención","Debe editar un Número de Pedido válido","")
			dw_2.SetColumn(1)
			dw_2.SetFocus()
			lb_validado = false
			Return
		else
			ll_sw = 2
			select count(*)
			into :ll_reg
			from fatpedid
			where pedi_g_financiero = :str.g_financiero
			and   pedi_empresa = :str.empresa
			and   pedi_no_pedido = :sle_new_no_pedido.text 
			and   pedi_ann = :li_anio ;
		if sqlca.sqlcode = -1 then
			ls_sqlerrtext = sqlca.sqlerrtext
			mensaje("Información","Error al verificar registro en fatpedid",ls_sqlerrtext)
			return
		end if			
	
			if ll_reg > 0 then
				messagebox("ATENCION","LA SECUENCIA YA EXISTE")
				return
			end if
		end If
	Else
		If rb_proforma.checked = true then
	//	is_ped_sel = data
			If is_pro_sel ='' or IsNull(is_pro_sel) Then
				mensaje("Atención","Debe editar un Número de Proforma válido","")
				dw_2.SetColumn(1)
				dw_2.SetFocus()
				lb_validado = false
				Return
			else
				ll_sw = 3
				is_ped_sel = is_pro_sel
				select count(*)
				into :ll_reg
				from fatprofo
				where prof_g_financiero = :str.g_financiero
				and   prof_empresa = :str.empresa
				and   prof_no_proforma = :sle_new_no_pedido.text
				and  prof_ann = :li_anio ;
				if sqlca.sqlcode = -1 then
					ls_sqlerrtext = sqlca.sqlerrtext
					mensaje("Información","Error al verificar registro en fatprofo",ls_sqlerrtext)
					return
				end if			

		
				if ll_reg > 0 then
					messagebox("ATENCION","LA SECUENCIA YA EXISTE")
					return
				end if
			end If
	Else
		If rb_fac_proforma.checked = true then
	//	is_ped_sel = data
			If is_ped_sel ='' or IsNull(is_ped_sel) Then
				mensaje("Atención","Debe editar un Número de Factura válido","")
				dw_2.SetColumn(1)
				dw_2.SetFocus()
				lb_validado = false
				Return
			else
				ll_sw = 4
				select count(*)
				into :ll_reg
				from fatprofo
				where prof_g_financiero = :str.g_financiero
				and   prof_empresa = :str.empresa
				and   prof_no_proforma = :sle_new_no_pedido.text 
				and   prof_ann	= :ii_ann_sel ;	//Valida si existe en el mismo año de la factura
				
				if sqlca.sqlcode = -1 then
					ls_sqlerrtext = sqlca.sqlerrtext
					mensaje("Información","Error al verificar registro en fatprofo",ls_sqlerrtext)
					return
				end if					
		
				if ll_reg > 0 then
					messagebox("ATENCION","LA SECUENCIA YA EXISTE")
					return
				end if
			end If				
		 end if
		End if		
	end if
End If

if ll_sw = 4 then	//Si es copia de factura a proforma, la copia en su mismo año
	ii_ann_repl = ii_ann_sel
else
	ii_ann_repl = w_fa_fondo.str_para.ano	//Para que la copia la haga para el año de parametros
end if

is_pedido_repl = sle_new_no_pedido.text
//
If lb_validado = true then
	gf_fa_copia_identica_doc(is_ped_sel, is_fact_sel, is_tipo_sel, ii_ann_sel ,is_tipo_repl, ii_ann_repl,is_pedido_repl,lb_salvo, ll_sw)
	If lb_salvo = true then
		sle_new_no_pedido.text='' 
		dw_2.reset()
		dw_2.insertrow(0)
		dwc_fac_pedi.retrieve(str.g_financiero,str.empresa,ii_ann)
	End If
else
	mensaje("","Los parámetros requeridos no han sido especificados adecuadamente","")
	return
End If

end event

type cb_2 from commandbutton within w_fa_copia_identica_fapepro
integer x = 1335
integer y = 524
integer width = 265
integer height = 108
integer taborder = 50
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

type rb_factura from radiobutton within w_fa_copia_identica_fapepro
integer x = 78
integer y = 88
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
boolean checked = true
end type

event clicked;is_ped_sel=''
is_fact_sel=''
is_pro_sel=''
sle_new_no_pedido.text='' 
wf_selec_datawindow()


end event

type rb_pedido from radiobutton within w_fa_copia_identica_fapepro
integer x = 471
integer y = 88
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
is_pro_sel=''
sle_new_no_pedido.text='' 
wf_selec_datawindow()

end event

type st_1 from statictext within w_fa_copia_identica_fapepro
integer x = 105
integer y = 208
integer width = 389
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
boolean enabled = false
string text = "No. Documento"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_fa_copia_identica_fapepro
integer x = 599
integer y = 208
integer width = 617
integer height = 88
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_change_factura"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string	ls_ultima_secuencia, ls_secuencia
long		ll_secuencia
integer li_existe, li_ann

li_ann = long(em_ann.text)
If rb_factura.checked = true then
	is_fact_sel = data
	is_ped_sel  = dwc_fac_pedi.GetItemString(dwc_fac_pedi.GetRow(),"fact_no_pedido")
	is_tipo_sel = dwc_fac_pedi.GetItemString(dwc_fac_pedi.GetRow(),"fact_tipo")
	ii_ann_sel  = dwc_fac_pedi.GetItemNumber(dwc_fac_pedi.GetRow(),"fact_ann")

	select fara_ult_pedido
	into :ls_ultima_secuencia
	from faaparam
	where fara_g_financiero = :str.g_financiero
	and   fara_empresa = :str.empresa ;
	if sqlca.sqlcode = 0 then
      ll_secuencia = long(ls_ultima_secuencia) + 1
		sle_new_no_pedido.text = string(ll_secuencia)
	end if
Else
	If rb_pedido.checked = true then
		is_ped_sel = data
		is_tipo_sel = dwc_fac_pedi.GetItemString(dwc_fac_pedi.GetRow(),"fatpedid_pedi_tipo")
		ii_ann_sel  = dwc_fac_pedi.GetItemNumber(dwc_fac_pedi.GetRow(),"fatpedid_pedi_ann")

		select fara_ult_pedido
		into :ls_ultima_secuencia
		from faaparam
		where fara_g_financiero = :str.g_financiero
		and   fara_empresa = :str.empresa ;
		if sqlca.sqlcode = 0 then
			ll_secuencia = long(ls_ultima_secuencia) + 1
			sle_new_no_pedido.text = string(ll_secuencia)
		end if
	Else
		If rb_proforma.checked = true then
			is_pro_sel = data
			is_tipo_sel = dwc_fac_pedi.GetItemString(dwc_fac_pedi.GetRow(),"fatprofo_prof_tipo")
			ii_ann_sel  = dwc_fac_pedi.GetItemNumber(dwc_fac_pedi.GetRow(),"fatprofo_prof_ann")

			select fara_ult_proforma
			into :ls_ultima_secuencia
			from faaparam
			where fara_g_financiero = :str.g_financiero
			and   fara_empresa = :str.empresa ;
			if sqlca.sqlcode = 0 then
				ll_secuencia = long(ls_ultima_secuencia) + 1
				sle_new_no_pedido.text = string(ll_secuencia)
			end if
		Else
			If rb_fac_proforma.checked = true then
				is_fact_sel = data
				is_ped_sel  = dwc_fac_pedi.GetItemString(dwc_fac_pedi.GetRow(),"fact_no_pedido")
				is_tipo_sel = dwc_fac_pedi.GetItemString(dwc_fac_pedi.GetRow(),"fact_tipo")
				ii_ann_sel  = dwc_fac_pedi.GetItemNumber(dwc_fac_pedi.GetRow(),"fact_ann")

				//sle_new_no_pedido.text = is_ped_sel
//Se puso en comentario, ya que se asume que el mismo numero de la factura, es el que llevara la proforma
				select fara_ult_proforma
				into :ls_ultima_secuencia
				from faaparam
				where fara_g_financiero = :str.g_financiero
						and   fara_empresa = :str.empresa ;
				if sqlca.sqlcode = 0 then
					ll_secuencia = long(ls_ultima_secuencia) + 1
					sle_new_no_pedido.text = string(ll_secuencia)
				end if
				
				do while true
					
					  SELECT count(*)  
						 INTO :li_existe  
						 FROM fatprofo  
						WHERE ( fatprofo.prof_g_financiero = :str.g_financiero ) AND  
								( fatprofo.prof_empresa = :str.empresa ) AND  
								( fatprofo.prof_no_proforma = :ls_secuencia) AND  
								( fatprofo.prof_ann = :li_ann )   ;
							if sqlca.sqlcode = -1 then
								gf_mensaje('','Error al validar existencia '+sqlca.sqlerrtext,1,1,'E')
							end if
						if li_existe > 0 then
							ll_secuencia  ++
							ls_secuencia = string(ll_secuencia)
						else
							exit
						end if						
				loop
				sle_new_no_pedido.text = string(ll_secuencia)
			end if
		end if		
	end if
End If

//is_tipo_sel = dwc_fac_pedi.GetItemString(dwc_fac_pedi.GetRow(),"fact_tipo")
//ii_ann_sel  = dwc_fac_pedi.GetItemNumber(dwc_fac_pedi.GetRow(),"fact_ann")

end event

type sle_new_no_pedido from singlelineedit within w_fa_copia_identica_fapepro
integer x = 599
integer y = 340
integer width = 398
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;is_pedido_repl = sle_new_no_pedido.text
end event

type rb_proforma from radiobutton within w_fa_copia_identica_fapepro
integer x = 878
integer y = 88
integer width = 389
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "  Proforma"
end type

event clicked;is_ped_sel=''
is_fact_sel=''
is_pro_sel=''
sle_new_no_pedido.text='' 
wf_selec_datawindow()

end event

type st_4 from statictext within w_fa_copia_identica_fapepro
integer x = 105
integer y = 340
integer width = 343
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Secuencia"
boolean focusrectangle = false
end type

type rb_fac_proforma from radiobutton within w_fa_copia_identica_fapepro
integer x = 1298
integer y = 88
integer width = 695
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "De Factura a Proforma"
end type

event clicked;is_ped_sel=''
is_fact_sel=''
is_pro_sel=''
sle_new_no_pedido.text='' 
wf_selec_datawindow()

end event

type st_2 from statictext within w_fa_copia_identica_fapepro
integer x = 1422
integer y = 220
integer width = 133
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año:"
boolean focusrectangle = false
end type

type em_ann from editmask within w_fa_copia_identica_fapepro
integer x = 1559
integer y = 204
integer width = 192
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###0"
end type

event modified;ii_ann = integer(em_ann.text)

dw_2.GetChild ("fact_no_pedido",dwc_fac_pedi)
dw_2.settransobject(sqlca)
dwc_fac_pedi.Settransobject(SQLCA);
if dwc_fac_pedi.retrieve(str.g_financiero,str.empresa,ii_ann) = 0 then dwc_fac_pedi.insertrow(0)
dw_2.InsertRow(0)

end event

