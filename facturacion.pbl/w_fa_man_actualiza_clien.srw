//objectcomments Ventana que actualiza el monto de las facturas de los clientes en Cuentas por Cobrar
forward
global type w_fa_man_actualiza_clien from w_fa_padre
end type
type st_1 from statictext within w_fa_man_actualiza_clien
end type
type gb_periodo from groupbox within w_fa_man_actualiza_clien
end type
type gb_3 from groupbox within w_fa_man_actualiza_clien
end type
type gb_2 from groupbox within w_fa_man_actualiza_clien
end type
type gb_1 from groupbox within w_fa_man_actualiza_clien
end type
type st_2 from statictext within w_fa_man_actualiza_clien
end type
type rb_1 from radiobutton within w_fa_man_actualiza_clien
end type
type rb_2 from radiobutton within w_fa_man_actualiza_clien
end type
type rb_3 from radiobutton within w_fa_man_actualiza_clien
end type
type rb_4 from radiobutton within w_fa_man_actualiza_clien
end type
type rb_5 from radiobutton within w_fa_man_actualiza_clien
end type
type dw_2 from datawindow within w_fa_man_actualiza_clien
end type
type sle_desde from singlelineedit within w_fa_man_actualiza_clien
end type
type st_hasta from statictext within w_fa_man_actualiza_clien
end type
type sle_hasta from singlelineedit within w_fa_man_actualiza_clien
end type
type rb_todas from radiobutton within w_fa_man_actualiza_clien
end type
type rb_desmarcar from radiobutton within w_fa_man_actualiza_clien
end type
type cb_1 from commandbutton within w_fa_man_actualiza_clien
end type
type cb_imprimir from commandbutton within w_fa_man_actualiza_clien
end type
type st_3 from statictext within w_fa_man_actualiza_clien
end type
type dw_3 from datawindow within w_fa_man_actualiza_clien
end type
end forward

global type w_fa_man_actualiza_clien from w_fa_padre
integer width = 2807
integer height = 1552
string title = "(FA) Actualización de Clientes en CxC"
string menuname = "m_hs"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
st_1 st_1
gb_periodo gb_periodo
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
sle_desde sle_desde
st_hasta st_hasta
sle_hasta sle_hasta
rb_todas rb_todas
rb_desmarcar rb_desmarcar
cb_1 cb_1
cb_imprimir cb_imprimir
st_3 st_3
dw_3 dw_3
end type
global w_fa_man_actualiza_clien w_fa_man_actualiza_clien

type variables
string is_filter
str_fa_carg_ped str_pedi

end variables

forward prototypes
public subroutine wf_valida_rango ()
public subroutine wf_botones ()
public function integer wf_inserta_mov (integer li_filas)
end prototypes

public subroutine wf_valida_rango ();String ls_letra,formato,ls_setting
Date	ldt_fecha
Datetime	ldt_fecha_inicial, ldt_fecha_final
Long	ll_count

IF (trim(sle_desde.text) <>'' and not isNull(sle_desde.text)) then
	
   If (trim(sle_hasta.text) ='' or isNull(sle_hasta.text))  then
		mensaje("Atención ","Si desea filtrar por rango de fecha, asegúrese de que el mismo sea correcto, de lo contrario, borre ambas fechas","")
		sle_hasta.Setfocus()
		Return
	end If
	
	IF date(trim(sle_hasta.text)) >= date(trim(sle_desde.text)) Then
		 
		If  date(sle_desde.text) <= date('01/01/1900') Then
			 mensaje("Atención ","Digite una fecha hasta Válida, por favor","")
			 this.setfocus()
			 return
		Else
			//Permite modificar el estado con la finalidad de que funcione el filtrado
			ls_setting = dw_1.Describe("DataWindow.Retrieve.AsNeeded")
			
			If ls_setting = "yes" Then 
				dw_1.Modify("DataWindow.Retrieve.AsNeeded=No")	
			End If	
			
			IF trim(sle_desde.text) <>'' and not isNull(sle_desde.text) Then
				ldt_fecha = date(sle_desde.text)
	
				ldt_fecha_inicial = Datetime(date(sle_desde.text),00:00:00)
				ldt_fecha_final 	= Datetime(date(sle_hasta.text),23:59:59)
			
				formato = "fatdiari_fact_fecha_creacion >= datetime('" + string(ldt_fecha_inicial) +"')"
				formato += " and fatdiari_fact_fecha_creacion <= datetime('" + string(ldt_fecha_final) +"')"
			
			END IF
			  
			// Filtra
			If Formato <> "" Then
				dw_1.SetFilter ( Formato)
				dw_1.Filter()
				If dw_1.Rowcount() > 0 then
					//For ll_count = 1 to dw_1.rowcount()
					//	dw_1.SetItem(ll_count,"fact_act_cliente",1)
					//Next
					//mensaje("Atención ","El proceso de SELECCION DE FACTURAS ha culminado, proceda a salvar ","")
				Else
					mensaje("Atención ","No hay facturas por actualizar en este período","")
				End If
			End If	
		End if
	Else
		mensaje("Atención "," La fecha HASTA no puede ser menor que la fecha DESDE ","")
		sle_desde.SetFocus()
		return
	End If
End If	 

end subroutine

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

public function integer wf_inserta_mov (integer li_filas);//Función que Actualiza las Transacciones en la Tabla de Movimientos 
long     ll_actualiza, ll_cliente 
String   ls_no_fact, ls_trans, ls_apli, ls_ruc, ls_mov, &
         ls_estado, ls_documento, ls_sub_trans, ls_comen, ls_nombre
Integer  li_anno
Double   ld_monto
Datetime ldt_fecha, ldt_fecha_reg, ldt_fechavence
			 
ls_trans = 'FA'
ls_apli = 'FA'
ls_mov = 'D'
ls_estado = 'IM'
ldt_fecha_reg = gf_fecha_serv()
					
ls_sub_trans	= dw_1.GetItemString(li_filas,"fact_tipo")
li_anno 			= dw_1.GetItemNumber(li_filas,3) 
ls_no_fact 		= dw_1.GetItemString(li_filas,4)
ll_cliente 		= dw_1.GetItemNumber(li_filas,5)
ls_ruc 			= dw_1.getItemString(li_filas,6)
ld_monto 		= truncate(round(dw_1.GetItemNumber(li_filas,7),2),2)
ls_documento	= dw_1.GetItemString(li_filas,"fact_no_pedido")
ldt_fecha		= dw_1.getitemdatetime(li_filas,"fact_fecha")
ls_comen		   =  dw_1.getitemstring(li_filas,"fact_comentario")
ls_nombre	   =  dw_1.getitemstring(li_filas,"fact_a_nombre")
ldt_fechavence =  dw_1.getitemdatetime(li_filas,"fact_fecha_fin_plazo")

INSERT INTO  cctmovim (cctmovim.movi_g_financiero, 	cctmovim.movi_empresa,
				 cctmovim.movi_aplicacion,			cctmovim.movi_tipo_transaccion,
				 cctmovim.movi_documento,			cctmovim.movi_anno,
				 cctmovim.movi_tercero,				cctmovim.movi_ruc_tercero,
				 cctmovim.movi_naturaleza,			cctmovim.movi_monto,
				 cctmovim.movi_fecha_tran,			cctmovim.movi_fecha_reg,
				 cctmovim.movi_usuario,				cctmovim.movi_estado,
				 cctmovim.movi_sub_transaccion, 	cctmovim.movi_referencia,
				 cctmovim.movi_comentario,       cctmovim.movi_fecha_vence,
				 cctmovim.movi_saldo, 				cctmovim.movi_a_nombre)
		VALUES (:str.g_financiero,			:str.empresa,
				 :ls_apli,						:ls_trans,
				 :ls_no_fact,					:li_anno,
				 :ll_cliente,					:ls_ruc,
				 :ls_mov,    					:ld_monto,
				 :ldt_fecha,    				:ldt_fecha_reg,
				 :str.usuario,					:ls_estado,
				 :ls_sub_trans,				:ls_documento,
				 :ls_comen,						:ldt_fechavence,
				 :ld_monto,						:ls_nombre);
	 
ll_actualiza = sqlca.sqlcode

If ll_actualiza <> -1 Then
	ll_actualiza = 1
End If
		
Return(ll_actualiza)
end function

on w_fa_man_actualiza_clien.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.st_1=create st_1
this.gb_periodo=create gb_periodo
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
this.sle_desde=create sle_desde
this.st_hasta=create st_hasta
this.sle_hasta=create sle_hasta
this.rb_todas=create rb_todas
this.rb_desmarcar=create rb_desmarcar
this.cb_1=create cb_1
this.cb_imprimir=create cb_imprimir
this.st_3=create st_3
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.gb_periodo
this.Control[iCurrent+3]=this.gb_3
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.rb_1
this.Control[iCurrent+8]=this.rb_2
this.Control[iCurrent+9]=this.rb_3
this.Control[iCurrent+10]=this.rb_4
this.Control[iCurrent+11]=this.rb_5
this.Control[iCurrent+12]=this.dw_2
this.Control[iCurrent+13]=this.sle_desde
this.Control[iCurrent+14]=this.st_hasta
this.Control[iCurrent+15]=this.sle_hasta
this.Control[iCurrent+16]=this.rb_todas
this.Control[iCurrent+17]=this.rb_desmarcar
this.Control[iCurrent+18]=this.cb_1
this.Control[iCurrent+19]=this.cb_imprimir
this.Control[iCurrent+20]=this.st_3
this.Control[iCurrent+21]=this.dw_3
end on

on w_fa_man_actualiza_clien.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.gb_periodo)
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
destroy(this.sle_desde)
destroy(this.st_hasta)
destroy(this.sle_hasta)
destroy(this.rb_todas)
destroy(this.rb_desmarcar)
destroy(this.cb_1)
destroy(this.cb_imprimir)
destroy(this.st_3)
destroy(this.dw_3)
end on

event ue_post_open;call super::ue_post_open;sle_desde.text = string(date(gf_fecha_serv()))
sle_hasta.text = string(date(gf_fecha_serv()))

dw_1.SetTransObject(Sqlca)
dw_2.SetTransObject(Sqlca)

dw_1.Retrieve(str.g_financiero,str.empresa)

dw_2.InsertRow(0)
dw_2.SetFocus()

end event

event ue_aceptar;//Override Ancestor Script
Long    ll_update
Integer li_reg_check, li_filas, li_insert_mov, li_error

dw_1.AcceptText()

if gf_mensaje("","¿ Está Seguro que Desea ACTUALIZAR las Transacciones Seleccionadas ?",2,1,"E") = 2 then return

	For li_filas = 1 to dw_1.Rowcount()
		If dw_1.GetItemNumber(li_filas,"fact_act_cliente") = 1 Then
				li_reg_check ++ 
				li_insert_mov = wf_inserta_mov(li_filas)
				If li_insert_mov <> 1 Then
					li_error ++
				End If
  		End If
	Next	

If li_reg_check > 0 Then
	ll_update = dw.update()

		If ll_update = 1  And li_error = 0 Then
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
		
Else
	mensaje("Atención Sr. Usuario:", "Seleccione el documento que desea actualizar...","") 	
End If
end event

event open;call super::open;This.SetRedraw(False)
wf_botones()
This.SetRedraw(True)
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

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_man_actualiza_clien
boolean visible = false
integer x = 27
integer y = 1284
integer width = 1083
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_man_actualiza_clien
integer x = 37
integer y = 116
integer width = 2697
integer height = 820
integer taborder = 0
string dataobject = "dw_ma_fa_actualiza_clien"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_ayuda from w_fa_padre`st_ayuda within w_fa_man_actualiza_clien
end type

type st_1 from statictext within w_fa_man_actualiza_clien
integer x = 41
integer y = 40
integer width = 2697
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 8388608
long backcolor = 79416533
boolean enabled = false
string text = "Actualizaciones de Clientes en Cuentas por Cobrar"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type gb_periodo from groupbox within w_fa_man_actualiza_clien
integer x = 2066
integer y = 956
integer width = 686
integer height = 292
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
string text = "               Período"
end type

type gb_3 from groupbox within w_fa_man_actualiza_clien
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

type gb_2 from groupbox within w_fa_man_actualiza_clien
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

type gb_1 from groupbox within w_fa_man_actualiza_clien
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
end type

type st_2 from statictext within w_fa_man_actualiza_clien
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

type rb_1 from radiobutton within w_fa_man_actualiza_clien
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

type rb_2 from radiobutton within w_fa_man_actualiza_clien
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

type rb_3 from radiobutton within w_fa_man_actualiza_clien
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

type rb_4 from radiobutton within w_fa_man_actualiza_clien
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

type rb_5 from radiobutton within w_fa_man_actualiza_clien
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

type dw_2 from datawindow within w_fa_man_actualiza_clien
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

type sle_desde from singlelineedit within w_fa_man_actualiza_clien
event key pbm_keydown
integer x = 2350
integer y = 1032
integer width = 343
integer height = 68
integer taborder = 20
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

event key;//if Key = KeyEnter! then
//	messagebox("","Voy al editchanged desde keyenter")
//	is_viene_de = '1'
//
//	dw_2.Triggerevent("edithchanged")
//end if
end event

event modified;IF trim(sle_desde.text) <>'' and not isNull(sle_desde.text) Then
	If date(sle_desde.text) <= date('01/01/1900')  Then
		 mensaje("Atención ","Digite una fecha correcta, por favor","")
		 this.setfocus()
		 return
	End if
End If
		 
end event

type st_hasta from statictext within w_fa_man_actualiza_clien
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

type sle_hasta from singlelineedit within w_fa_man_actualiza_clien
event key pbm_keydown
integer x = 2354
integer y = 1136
integer width = 343
integer height = 68
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

event key;if Key = KeyEnter! then
	wf_valida_rango()
end if
end event

event modified;//wf_valida_rango()

IF (trim(sle_desde.text) <>'' and not isNull(sle_desde.text)) then
	
   If (trim(sle_hasta.text) ='' or isNull(sle_hasta.text))  then
		mensaje("Atención ","Si desea filtrar por rango de fecha, asegúrese de que el mismo sea correcto, de lo contrario, borre ambas fechas","")
		sle_hasta.Setfocus()
		Return
	end If
	
	IF date(trim(sle_hasta.text)) < date(trim(sle_desde.text)) or &
		date(sle_desde.text) <= date('01/01/1900') Then
		 mensaje("Atención ","Verifique que el rango de fecha sea Válido, por favor","")
		 sle_desde.setfocus()
		 return
	End If
End If	 

end event

type rb_todas from radiobutton within w_fa_man_actualiza_clien
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

dw_1.SetFilter ("")
dw_1.Filter()

If dw_1.Rowcount() > 0 then
	For ll_count = 1 to dw_1.rowcount()
		dw_1.SetItem(ll_count,"fact_act_cliente",1)
	Next
	//mensaje("Atención ","El proceso de marcado ha culminado con éxito, proceda a salvar ","")
Else
	mensaje("Atención ","No hay facturas por actualizar en este período","")
End If

end event

type rb_desmarcar from radiobutton within w_fa_man_actualiza_clien
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
		If dw_1.GetItemNumber(ll_count,"fact_act_cliente") = 1 Then
			dw_1.SetItem(ll_count,"fact_act_cliente",0)
		End If
	Next
	//mensaje("Atención ","El proceso de selección ha culminado con éxito ","")
Else
	mensaje("Atención ","No hay facturas seleccionadas","")
End If

end event

type cb_1 from commandbutton within w_fa_man_actualiza_clien
integer x = 1362
integer y = 1272
integer width = 699
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Descartar Transacciones"
end type

event clicked;integer li_reg_check, li_filas
long    ll_update

dw_1.AcceptText()

if gf_mensaje("","¿ Está Seguro que Desea DESCARTAR las Transacciones Seleccionadas ?",2,1,"E") = 2 then return

	For li_filas = 1 to dw_1.Rowcount()
		If dw_1.GetItemNumber(li_filas,"fact_act_cliente") = 1 Then
				li_reg_check ++ 
				exit //para que salga del ciclo
  		End If
	Next	

If li_reg_check > 0 Then
	ll_update = dw.update()

		If ll_update = 1 Then
			Commit Using Sqlca;
			messagebox("Atención","¡Actualización Exitosa !")
			
			This.SetRedraw(False)
			dw_1.Retrieve(str.g_financiero,str.empresa)
			This.SetRedraw(True)
			
		Else
			messagebox("Atención Sr. Usuario","¡Error al Actualizar ! "+sqlca.sqlerrtext)
			Rollback Using Sqlca;			
		End If
		
Else
	mensaje("Atención Sr. Usuario:", "Seleccione el documento que desea actualizar...","") 	
End If
end event

type cb_imprimir from commandbutton within w_fa_man_actualiza_clien
integer x = 2281
integer y = 1268
integer width = 471
integer height = 96
integer taborder = 60
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

ll_row =0
For ll_filas = 1 to dw_1.rowcount()
	If dw_1.GetItemNumber(ll_filas,"fact_act_cliente") =1 then
		ll_row ++
	end if
next

If ll_row > 0 then
	ls_filtro = "fact_act_cliente= 1"
	dw_1.SetFilter(ls_filtro)
	dw_1.Filter( )
	dw_3.Reset()

	ll_filas =dw_1.RowsCopy(1,dw_1.rowcount(), primary!, dw_3, 1, primary!)
	If dw_3.rowcount() <= 0 then
		mensaje("Atención","No hay data para este reporte.. seleccione las facturas a pasar","")
		return
	end if
	str_pedi.vienede = 'act_clien'	
	str_pedi.dwobject = dw_3
	str_pedi.datawindow = 'dw_fa_rep_actualiza_clien'
	str.frame.SetRedraw ( false )
	OpenSheetWithParm(w_fa_rep_imp_factura_ref, str_pedi, str.frame,9,Layered!)
	str.frame.SetRedraw ( true )
else
	mensaje("Atención ","No hay ninguna factura seleccionada, selecciónela para proceder, dé click en el campo incluir a cada factura que desee incluir","")
end if
dw_1.SetFilter('')
dw_1.Filter( )


if not isvalid(m_fa_padre) then
	w_fa_man_actualiza_clien.Changemenu(m_fa_principal)
	wf_botones()
end if

end event

type st_3 from statictext within w_fa_man_actualiza_clien
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

type dw_3 from datawindow within w_fa_man_actualiza_clien
boolean visible = false
integer x = 87
integer y = 1392
integer width = 2661
integer height = 348
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_fa_rep_actualiza_clien"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

