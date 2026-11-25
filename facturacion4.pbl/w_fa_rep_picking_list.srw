//objectcomments Reporte que se Remite a la Bodega para la Generación del Packing List
forward
global type w_fa_rep_picking_list from w_fa_padre_reportes
end type
type st_2 from statictext within w_fa_rep_picking_list
end type
type em_ann from editmask within w_fa_rep_picking_list
end type
type sle_pedido from singlelineedit within w_fa_rep_picking_list
end type
type pb_1 from picturebutton within w_fa_rep_picking_list
end type
type st_3 from statictext within w_fa_rep_picking_list
end type
type st_4 from statictext within w_fa_rep_picking_list
end type
type ddlb_1 from dropdownlistbox within w_fa_rep_picking_list
end type
type ddlb_2 from dropdownlistbox within w_fa_rep_picking_list
end type
type st_1 from statictext within w_fa_rep_picking_list
end type
type st_tipo from statictext within w_fa_rep_picking_list
end type
type cb_aceptar from commandbutton within w_fa_rep_picking_list
end type
type cbx_directo from checkbox within w_fa_rep_picking_list
end type
end forward

global type w_fa_rep_picking_list from w_fa_padre_reportes
boolean visible = false
integer x = 1271
integer y = 160
integer width = 1632
integer height = 620
string title = " Lista de Empaque de Verificación"
string menuname = ""
boolean controlmenu = false
boolean maxbox = false
boolean resizable = false
string icon = "Application!"
event ue_help ( )
st_2 st_2
em_ann em_ann
sle_pedido sle_pedido
pb_1 pb_1
st_3 st_3
st_4 st_4
ddlb_1 ddlb_1
ddlb_2 ddlb_2
st_1 st_1
st_tipo st_tipo
cb_aceptar cb_aceptar
cbx_directo cbx_directo
end type
global w_fa_rep_picking_list w_fa_rep_picking_list

type variables
//Variable para asignar el nombre de la Empresa al DW
string is_empresa, is_pedido

integer ii_ann
string is_pedid, is_tipo
window iw_pedidos

//Variable tipo Estructura
str_fa_carg_ped str_pedi

Datawindowchild dwc_tipo_fact
end variables

forward prototypes
public subroutine wf_botones ()
public subroutine wf_buscar_factura ()
public subroutine wf_buscar_pedido ()
public subroutine wf_buscar_proforma ()
end prototypes

event ue_help;choose case str_pedi.vienede
	case	"FA"	
		wf_buscar_factura()
	case	"PE"	
		wf_buscar_pedido()
	case  "PR"	
		wf_buscar_proforma()
end choose
end event

public subroutine wf_botones ();//Deshabilitar botones no necesarios.
//	m_fa_padre.m_edicin.m_siguienteregistro.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_registroanterior.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_ultimoregistro.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_primerregistro.toolbaritemvisible=false

   m_fa_padre.m_archivo.m_vistapreliminar.toolbaritemvisible=false
   m_fa_padre.m_edicin.m_sortear.toolbaritemvisible=false
	m_fa_padre.m_edicin.m_filtrar.toolbaritemvisible=false


end subroutine

public subroutine wf_buscar_factura ();//Llamado de la ventana de busqueda

OpenWithParm(w_fa_co_facturas, "Factura")

// Toma el Numero de Proforma si es que el usuario selecciono alguno
String ls_retorno, ls_pedi, ls_tipo, ls_expresion
integer li_pos, li_an, li_pos2
Long		ll_row

ls_retorno = Message.StringParm		

li_pos = pos(ls_retorno,"=",1)		// Posicion donde inicia el "="

li_pos2 = pos(ls_retorno,"_",li_pos)// Posicion donde inicia el "_"

ls_pedi = left(ls_retorno,li_pos - 1)	// Extrae el numero del pedido

ls_tipo= mid(ls_retorno,li_pos + 1,li_pos2 - (li_pos + 1))  //Extrae si es por mayor o menor

li_an		=	integer(mid(ls_retorno,li_pos2 + 1))

	
If ls_pedi <> "" Then
	
	sle_pedido.text = ls_pedi			// Pedido
	str_pedi.pedido = ls_pedi
	is_pedido		 = ls_pedi

	str_pedi.tipo = ls_tipo	
	is_tipo = ls_tipo
	ls_expresion = "dgmsubse_subs_sub_trans ="+'"'+ls_tipo+'"'
	
	ll_row = dwc_tipo_fact.Find ( ls_expresion, 1, dwc_tipo_fact.rowcount() )
	If ll_row <> 0 then 
		dwc_tipo_fact.ScrollToRow(ll_row)
		str_pedi.tipo = dwc_tipo_fact.GetItemString(ll_row,"dgmsubse_subs_sub_trans")
		dw_1.SetItem(1,"serd_sub_trans",str_pedi.tipo)
		is_tipo = str_pedi.tipo
	else
		mensaje("","El tipo de factura ha sido borrado de la tabla de dgmserdr","")
		return
	end if

	em_ann.text   = string(li_an)
	str_pedi.ano  = li_an	
	ii_ann		  = li_an	
	
End If



end subroutine

public subroutine wf_buscar_pedido ();OpenWithParm(w_fa_co_pedidos_picking,"Pedidos")

// Toma el Numero del Pedido si es que el usuario selecciono alguno
String ls_cadena
integer li_pos

ls_cadena = Message.StringParm

If ls_cadena <> "" Then 
	li_pos = pos(ls_cadena,"=",1)
	
	is_pedido 		 = left(ls_cadena,li_pos -1)
	sle_pedido.text = left(ls_cadena,li_pos -1)
	str_pedi.pedido = left(ls_cadena,li_pos -1)
	
	str_pedi.ano = integer(mid(ls_cadena,li_pos+1))
	em_ann.text = mid(ls_cadena,li_pos+1)
	ii_ann = integer(mid(ls_cadena,li_pos+1))
	
   
End If


end subroutine

public subroutine wf_buscar_proforma ();OpenWithParm(w_fa_co_proformas, "Proforma")

// Toma el Numero del Pedido si es que el usuario selecciono alguno
String ls_cadena
integer li_pos

ls_cadena = Message.StringParm

If ls_cadena <> "" Then 
	li_pos = pos(ls_cadena,"=",1)
	
	is_pedido 		 = left(ls_cadena,li_pos -1)
	sle_pedido.text = left(ls_cadena,li_pos -1)
	str_pedi.pedido = left(ls_cadena,li_pos -1)
	
	str_pedi.ano = integer(mid(ls_cadena,li_pos+1))
	em_ann.text = mid(ls_cadena,li_pos+1)
	ii_ann = integer(mid(ls_cadena,li_pos+1))
End If


end subroutine

on w_fa_rep_picking_list.create
int iCurrent
call super::create
this.st_2=create st_2
this.em_ann=create em_ann
this.sle_pedido=create sle_pedido
this.pb_1=create pb_1
this.st_3=create st_3
this.st_4=create st_4
this.ddlb_1=create ddlb_1
this.ddlb_2=create ddlb_2
this.st_1=create st_1
this.st_tipo=create st_tipo
this.cb_aceptar=create cb_aceptar
this.cbx_directo=create cbx_directo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.em_ann
this.Control[iCurrent+3]=this.sle_pedido
this.Control[iCurrent+4]=this.pb_1
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.ddlb_1
this.Control[iCurrent+8]=this.ddlb_2
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.st_tipo
this.Control[iCurrent+11]=this.cb_aceptar
this.Control[iCurrent+12]=this.cbx_directo
end on

on w_fa_rep_picking_list.destroy
call super::destroy
destroy(this.st_2)
destroy(this.em_ann)
destroy(this.sle_pedido)
destroy(this.pb_1)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.ddlb_1)
destroy(this.ddlb_2)
destroy(this.st_1)
destroy(this.st_tipo)
destroy(this.cb_aceptar)
destroy(this.cbx_directo)
end on

event ue_post_open;//Override

//ddlb_1.sorted = false
ddlb_2.sorted = false

str_pedi = Message.PowerObjectParm

//dw_1.Insertrow(0)
//Child de Tipo de Factura
dw_1.GetChild('serd_sub_trans', dwc_tipo_fact)

dwc_tipo_fact.Settransobject(sqlca);
If dwc_tipo_fact.Retrieve(str.g_financiero, str.empresa,'FA') < 1 Then  dwc_tipo_fact.Insertrow(0)
dwc_tipo_fact.Scrolltorow(1)
dwc_tipo_fact.setfilter("subs_transaccion = 'FA'") //Para que no muestre las transacciones de FC (Contado)
dwc_tipo_fact.filter()


//dw_1.Retrieve(str.g_financiero,str.empresa,'FA') //Devuelve demasiadas lineas, Verificar
dw_1.insertrow(1)
if str_pedi.tipo = '' or isnull(str_pedi.tipo) then str_pedi.tipo = dwc_tipo_fact.getitemstring(1,'dgmsubse_subs_sub_trans')

dw_1.setitem(1,'serd_sub_trans',str_pedi.tipo)
is_tipo = str_pedi.tipo

//is_empresa = gf_dg_nombre_empresa()

if trim(str_pedi.pedido) <> "" and not isnull(str_pedi.pedido) then	
	is_pedido 	 = str_pedi.pedido
	ii_ann 		 = str_pedi.ano
	is_tipo = str_pedi.tipo
	if not isnull(is_tipo)  then
		st_tipo.visible = true
		dw_1.visible = True
	//	is_tipo = ''
		str_pedi.tipo = is_tipo
	end if
else	//Si se abrio la ventana y no se enviaron parametros
	if pos(upper(gf_dg_nombre_empresa()),'RODEO') > 0 then
		str_pedi.vienede 	= "FA"
		st_tipo.visible 	= true
		dw_1.visible 		= True
		str_pedi.tipo = is_tipo
		sle_pedido.Setfocus()
	else
		ddlb_2.SelectItem("PEDIDO",1)
		str_pedi.vienede = "PE"
		sle_pedido.Setfocus()
	end if
	ii_ann = w_hs_frame.str_para.ano
end if

choose case str_pedi.vienede
	case	"FA"
		ddlb_2.SelectItem("FACTURA",1)
	case  "PE"	
		ddlb_2.SelectItem("PEDIDO",1)
		dw_1.visible = false
		st_4.visible = false	
		st_tipo.visible  = false		
		sle_pedido.Setfocus()
	case  "PR"	
		ddlb_2.SelectItem("PROFORMA",1)
		dw_1.visible = false
		st_4.visible   = false	
		st_tipo.visible  = false		
		sle_pedido.Setfocus()
end choose

//Seteo Inicial


sle_pedido.text  = is_pedido
em_ann.text 	  = string(ii_ann)

if is_pedido <> "" and not isnull(is_pedido) and is_pedido <> "0" then
//	pb_1.TriggerEvent("clicked")
end if

pb_1.picturename = str.path+"art\blind.bmp"

//str.frame.setredraw(true)
//this.setredraw(false)
end event

event resize;//Override
//
//this.X=5
//tHIS.Y=5
//
end event

event key;call super::key;if key = keyF1! then
	this.Postevent("ue_help")
end if
end event

event open;//OVERRIDE
///***************************/
gf_center_win(This)
dw = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()

This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)
//str.frame.SetRedraw ( True )
This.Icon = str.icono
this.postevent("ue_post_open")
end event

event closequery;call super::closequery;constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)

This.SetRedraw(false)
end event

event close;Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
 
end event

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_rep_picking_list
boolean visible = false
integer x = 41
integer y = 432
integer width = 832
integer height = 72
end type

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_rep_picking_list
integer x = 1202
integer y = 772
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_rep_picking_list
boolean visible = false
integer x = 919
integer y = 272
integer width = 622
integer height = 80
integer taborder = 70
string dataobject = "dw_dd_fa_tipo_factura"
boolean livescroll = false
borderstyle borderstyle = stylelowered!
end type

event dw_1::ue_escape;//Override
end event

event dw_1::itemchanged;CHOOSE CASE dw_1.Getcolumnname()
	CASE "serd_sub_trans"
		str_pedi.tipo = dwc_tipo_fact.GetItemString(dwc_tipo_fact.GetRow(),"dgmsubse_subs_sub_trans")
		is_tipo = str_pedi.tipo
END CHOOSE


end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_rep_picking_list
integer x = 23
integer y = 16
integer width = 1554
integer height = 388
integer taborder = 0
long textcolor = 8388608
string text = "Seleccione los Datos del Informe"
end type

type st_2 from statictext within w_fa_rep_picking_list
integer x = 841
integer y = 104
integer width = 137
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79416533
boolean enabled = false
string text = "Año :"
boolean focusrectangle = false
end type

type em_ann from editmask within w_fa_rep_picking_list
integer x = 974
integer y = 84
integer width = 261
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
borderstyle borderstyle = stylelowered!
string mask = "#,###"
boolean spin = true
double increment = 1
string minmax = "1900~~3000"
end type

type sle_pedido from singlelineedit within w_fa_rep_picking_list
integer x = 471
integer y = 88
integer width = 347
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type pb_1 from picturebutton within w_fa_rep_picking_list
integer x = 1294
integer y = 60
integer width = 146
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean default = true
string picturename = "Harr2000\art\blind.bmp"
alignment htextalign = left!
end type

event clicked;//llamado a la Ventana de Impresion
long ll_recupero = 0

is_pedido = sle_pedido.text
ii_ann	 = integer(em_ann.text)

str_pedi.pedido =  is_pedido
str_pedi.ano = ii_ann
str_pedi.tipo_formato   ='PIK'

if str_pedi.vienede = "FA" then
	str_pedi.tipo = is_tipo
	If len(trim(is_tipo)) =0 or Isnull(is_tipo) Then
		mensaje("Atención ","Seleccione un tipo de factura válido ..!!","")
		return
	End If
end if
If len(trim(is_pedido)) =0 or Isnull(is_pedido) Then
	mensaje("Atención ","Digite un número de documento válido ..!!","")
	return
End If

If IsNull(ii_ann) or ii_ann <1980 Then
	mensaje("Atención ","Asegúrese de que el año de la factura sea válido..!!","")
	return
End If

choose case str_pedi.vienede
 	case "PE"
		  SELECT count(1)  
			 INTO :ll_recupero  
			 FROM fadpedid,   
					fatpedid  
			WHERE ( fatpedid.pedi_g_financiero = fadpedid.dped_g_financiero ) and  
					( fatpedid.pedi_empresa = fadpedid.dped_empresa ) and  
					( fatpedid.pedi_no_pedido = fadpedid.dped_no_pedido ) and  
					( fatpedid.pedi_ann = fadpedid.dped_ann ) and  
					( ( fatpedid.pedi_g_financiero = :str.g_financiero  ) AND  
					( fatpedid.pedi_empresa = :str.empresa ) AND  
					( fatpedid.pedi_no_pedido = :is_pedido  ) AND  
					( fatpedid.pedi_ann = :ii_ann ) AND  
					( fatpedid.pedi_estado <>  'P' ) )   ;		

		if sqlca.sqlcode = -1 then
			gf_mensaje("","Error al Verificar Existencia en fadpedid y fatpedid "+sqlca.sqlerrtext,1,1,"E")
		end if
		str_pedi.cod_formato   ='PIKPED'
				
	case	"FA"		
		
	  SELECT count(1)  
		 INTO :ll_recupero  
		 FROM faddiari  
		WHERE ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
				( faddiari.facd_empresa = :str.empresa ) AND  
				( faddiari.facd_tipo = :is_tipo ) AND  
				( faddiari.facd_no_pedido = :is_pedido )  AND
				( faddiari.facd_ann = :ii_ann);
		if sqlca.sqlcode = -1 then
			gf_mensaje("","Error al Verificar Existencia en faddiari "+sqlca.sqlerrtext,1,1,"E")
		end if				
		str_pedi.cod_formato   ='PIKFAC'
	case	"PR"	
		SELECT count(1)  
		 INTO :ll_recupero  
		 FROM fadprofo  
		WHERE ( fadprofo.dpro_g_financiero = :str.g_financiero ) AND  
				( fadprofo.dpro_empresa = :str.empresa ) AND  
				( fadprofo.dpro_no_proforma = :is_pedido ) AND  
				( fadprofo.dpro_ann = :ii_ann )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje("","Error al Verificar Existencia en fadprofo "+sqlca.sqlerrtext,1,1,"E")
		end if				
		str_pedi.cod_formato   ='PIKPRO'
end choose

if ll_recupero = 0 then
   gf_mensaje("","El Documento No Existe, no Tiene Detalle o ya fue pasado, Verifique",1,1,"E")
else	
	str_pedi.reporte_o_para ='REP'
	//
		Boolean  ab_imprimir
		Integer	li_existe = 0
		Boolean	lb_aceptar = false
		
		gf_fa_selec_formato(li_existe,lb_aceptar,str_pedi.tipo_formato,str_pedi.cod_formato,str_pedi.datawindow)
		
		If lb_aceptar = false then
			return
		end if
		
		If li_existe <= 0 then
			mensaje("Atención ","El formato del documento no ha sido configurado, por favor contacte al personal de soporte técnico o a su programador..gracias.. !!","")
			return
		end if
		
		if cbx_directo.checked then
			str_pedi.directo_al_printer = true
		else
			str_pedi.directo_al_printer = false
		end if
		
		If li_existe > 1 then
			str.frame.SetRedraw ( false )
			OpenSheetWithParm(w_fa_man_selec_formatos, str_pedi, str.frame,9,Original!)
			str.frame.SetRedraw ( true )
		else
			str.frame.SetRedraw ( false )
			OpenSheetWithParm(w_fa_rep_imp_picking_list, str_pedi, str.frame,9,Layered!)
			str.frame.SetRedraw ( true )
		end If
end if
end event

type st_3 from statictext within w_fa_rep_picking_list
integer x = 1243
integer y = 172
integer width = 265
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79416533
boolean enabled = false
string text = "Consultar"
boolean focusrectangle = false
end type

type st_4 from statictext within w_fa_rep_picking_list
boolean visible = false
integer x = 361
integer y = 704
integer width = 293
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Por Mayor:"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_fa_rep_picking_list
boolean visible = false
integer x = 731
integer y = 688
integer width = 247
integer height = 228
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
string item[] = {"SI","NO"}
end type

event selectionchanged;choose case index
	case 1
		str_pedi.tipo = '1'
	   is_tipo = '1'
	case 2
		str_pedi.tipo = '0'
		is_tipo = '0'		
end choose
end event

type ddlb_2 from dropdownlistbox within w_fa_rep_picking_list
integer x = 55
integer y = 84
integer width = 389
integer height = 280
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean sorted = false
string item[] = {"PROFORMA","PEDIDO","FACTURA"}
end type

event selectionchanged;st_4.visible   = false
st_tipo.visible 	= false
dw_1.visible 		= False

choose case index		
	case 1
		str_pedi.vienede 	= "PR"
	case 2
		str_pedi.vienede 	= "PE"
	case 3
		str_pedi.vienede 	= "FA"
		st_tipo.visible 	= true
		dw_1.visible 		= True
	//	is_tipo = ''
		str_pedi.tipo = is_tipo
end choose
end event

type st_1 from statictext within w_fa_rep_picking_list
integer x = 41
integer y = 272
integer width = 357
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79416533
boolean enabled = false
string text = "F1 para Ayuda"
boolean focusrectangle = false
end type

type st_tipo from statictext within w_fa_rep_picking_list
boolean visible = false
integer x = 507
integer y = 272
integer width = 389
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79416533
string text = "Tipo Factura"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_aceptar from commandbutton within w_fa_rep_picking_list
integer x = 1280
integer y = 416
integer width = 288
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;pb_1.TriggerEvent("clicked")
end event

type cbx_directo from checkbox within w_fa_rep_picking_list
integer x = 1001
integer y = 432
integer width = 265
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
string text = "Directo"
boolean checked = true
end type

