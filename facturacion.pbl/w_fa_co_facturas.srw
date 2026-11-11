//objectcomments Consulta de Facturas
forward
global type w_fa_co_facturas from w_fa_padre_reportes
end type
type gb_3 from groupbox within w_fa_co_facturas
end type
type gb_nose from groupbox within w_fa_co_facturas
end type
type gb_2 from groupbox within w_fa_co_facturas
end type
type rb_1 from radiobutton within w_fa_co_facturas
end type
type rb_2 from radiobutton within w_fa_co_facturas
end type
type rb_3 from radiobutton within w_fa_co_facturas
end type
type dw_2 from datawindow within w_fa_co_facturas
end type
type rb_4 from radiobutton within w_fa_co_facturas
end type
type rb_5 from radiobutton within w_fa_co_facturas
end type
type rb_6 from radiobutton within w_fa_co_facturas
end type
type rb_7 from radiobutton within w_fa_co_facturas
end type
type pb_1 from picturebutton within w_fa_co_facturas
end type
type em_1 from editmask within w_fa_co_facturas
end type
type em_2 from editmask within w_fa_co_facturas
end type
type st_2 from statictext within w_fa_co_facturas
end type
type st_3 from statictext within w_fa_co_facturas
end type
type rb_8 from radiobutton within w_fa_co_facturas
end type
end forward

global type w_fa_co_facturas from w_fa_padre_reportes
integer x = 5
integer y = 20
integer width = 2747
integer height = 1180
string title = "(FA) Consulta de Facturas"
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
gb_3 gb_3
gb_nose gb_nose
gb_2 gb_2
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
dw_2 dw_2
rb_4 rb_4
rb_5 rb_5
rb_6 rb_6
rb_7 rb_7
pb_1 pb_1
em_1 em_1
em_2 em_2
st_2 st_2
st_3 st_3
rb_8 rb_8
end type
global w_fa_co_facturas w_fa_co_facturas

type variables
String	is_vienede
end variables

forward prototypes
public subroutine wf_fecha ()
public subroutine wf_nofecha ()
public function string wf_verificar (string ls_original)
public function string wf_armar_sql (string ls_vienede)
end prototypes

public subroutine wf_fecha ();dw_2.visible = false
em_1.visible = True
em_1.text = string(today())
em_2.visible = True
em_2.text = string(today())
pb_1.visible = True
st_2.visible = True
st_3.visible = True
em_1.setfocus()

end subroutine

public subroutine wf_nofecha ();dw_2.visible = True
em_1.visible = false
em_2.visible = false
pb_1.visible = false
st_2.visible = false
st_3.visible = false
dw_2.setfocus()
dw_2.SetColumn("Texto")
end subroutine

public function string wf_verificar (string ls_original);//Se verifican las opciones de parámetros y se filtra
string ls_where
  
  if w_fa_fondo.str_para.mostrar <> 0 then  //mostrar un Año específico

	CHOOSE CASE w_fa_fondo.str_para.desde	//Si es desde el año en adelante o el año exclusivo.
		CASE 0

		 ls_where = ls_original + " and  &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+" ) and &
					 (fatdiari.fact_ann = "+string(w_fa_fondo.str_para.mostrar)+" ) AND &
 					 ( fatdiari.fact_no_pedido not like '%NC%' )"	
		CASE 1
		 ls_where = ls_original + " and  &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+" ) and &
					 (fatdiari.fact_ann >= "+string(w_fa_fondo.str_para.mostrar)+" ) AND &
 					 ( fatdiari.fact_no_pedido not like '%NC%' )"		
	END CHOOSE			
	
  else
		 ls_where = ls_original + " and  &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+" ) AND &
 					 ( fatdiari.fact_no_pedido not like '%NC%' )"	
  end if
return(ls_where)
end function

public function string wf_armar_sql (string ls_vienede);// Función que arma el Sql de el DataWindow, y dependiendo de donde se llama, factura o consultas
// Filtra segun parámetros iniciales o no
string ls_where, ls_original

ls_original = dw_1.GetsqlSelect()

if is_vienede = "Factura" or is_vienede = "Modi_factura" then //Modify HGN 28/03/01
	
	ls_where = wf_verificar(ls_original)

	If is_vienede = "Modi_factura" then
		ls_where =ls_where+ " and ( fatdiari.fact_estado = 'I') and (fatdiari.fact_act_conta <> 1 )"	
	end if

ElseIf is_vienede = "Devolucion" then
      ls_where = ls_original + " and  &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+" ) AND &
					  (fatdiari.fact_estado ='I' ) AND &
					  ( fatdiari.fact_no_pedido not like '%NC%' )"	
					
ElseIf is_vienede = "Modi_devolucion" then
      ls_where = ls_original + " and  &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+" ) AND &
					  (fatdiari.fact_estado ='I' ) AND &
					  ( fatdiari.fact_no_pedido like '%NC%' )"	
else		//Si es llamado de consultas
	if w_fa_fondo.str_para.afecta_consulta = 1 then		//Si los parámetros afectan consulta
		ls_where = wf_verificar(ls_original)  
	else
      ls_where = ls_original + " and  &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+" ) AND &
					 ( fatdiari.fact_no_pedido not like '%NC%' )"	
	end if				 
end if
return(ls_where)
end function

on w_fa_co_facturas.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.gb_nose=create gb_nose
this.gb_2=create gb_2
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.dw_2=create dw_2
this.rb_4=create rb_4
this.rb_5=create rb_5
this.rb_6=create rb_6
this.rb_7=create rb_7
this.pb_1=create pb_1
this.em_1=create em_1
this.em_2=create em_2
this.st_2=create st_2
this.st_3=create st_3
this.rb_8=create rb_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.gb_nose
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.rb_1
this.Control[iCurrent+5]=this.rb_2
this.Control[iCurrent+6]=this.rb_3
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.rb_4
this.Control[iCurrent+9]=this.rb_5
this.Control[iCurrent+10]=this.rb_6
this.Control[iCurrent+11]=this.rb_7
this.Control[iCurrent+12]=this.pb_1
this.Control[iCurrent+13]=this.em_1
this.Control[iCurrent+14]=this.em_2
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.st_3
this.Control[iCurrent+17]=this.rb_8
end on

on w_fa_co_facturas.destroy
call super::destroy
destroy(this.gb_3)
destroy(this.gb_nose)
destroy(this.gb_2)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.dw_2)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.rb_6)
destroy(this.rb_7)
destroy(this.pb_1)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.rb_8)
end on

event ue_post_open;//Override
string ls_where
long	 ll_recupero

/* dw corresponde al datawindows que se desea imprimir, por tanto
   si desea asignarle otro nombre haga lo siguiente 
	dw = otro_nombre */
dw = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()


is_vienede 	= Message.StringParm
ls_where 	= wf_armar_sql(is_vienede)

dw.SetSQLSelect(ls_where)		//Setea el SQL al Child de Facturas

SELECT count(*)  
 INTO :ll_recupero  
 FROM fatdiari  
WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
		( fatdiari.fact_empresa = :str.empresa )   ;
			
if sqlca.sqlcode = -1 then
	mensaje("Información 1","Error al Seleccionar la cantidad de registros en fatdiari",sqlca.sqlerrtext)
	return
end if				

if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 then
		dw_1.object.fatdiari_fact_ruc_cliente_t.text ='No. Cliente'
		rb_2.text ='No. Cliente'
end if
if ll_recupero = 0 then
	dw.insertrow(0)
else
	dw.Retrieve() 
end if	

dw_2.SetTransObject(SQLCA)
Dw_2.InsertRow(0)
dw_2.setfocus()
dw_2.SetColumn("texto")

str.frame.SetMicroHelp ("Seleccione una Linea y Precione la Tecla Enter para Cargar la Información")

pb_1.PictureName = "\harr2000\art\blind.bmp"

rb_4.checked= true
end event

event resize;//Override No borrar no tocar
end event

event key;//Override
end event

event close;// Override

end event

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_co_facturas
integer x = 59
integer y = 1028
end type

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_co_facturas
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_co_facturas
event ue_down pbm_dwnkey
event ue_entercol ( )
integer x = 32
integer y = 48
integer width = 2642
integer height = 664
integer taborder = 120
string dataobject = "dw_co_fa_facturas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

event dw_1::ue_down;//Si el Usuario Dio Enter
If key = Keyenter! Then 
	This.Postevent("ue_entercol")
	return(2)
End If	



end event

event dw_1::ue_entercol();String ls_ped,ls_retorna,ls_tipo_fac
integer li_pormayor, li_an

ls_ped = GetitemString(This.Getrow() ,"fatdiari_fact_no_pedido")		//No de pedido

ls_tipo_fac = GetitemString(This.Getrow() ,"fatdiari_fact_tipo")		//Tipo
li_an			= Getitemnumber(This.Getrow(),"fatdiari_fact_ann") //Año
// Valor de retorno 

ls_retorna=ls_ped+"="+ls_tipo_fac+"_"+string(li_an)	//Retorna el valor concatenado del pedido+"="+pormayor

CloseWithReturn ( parent, ls_retorna)
end event

event dw_1::doubleclicked;call super::doubleclicked;//this.triggerevent("ue_entercol")

String ls_ped,ls_retorna,ls_tipo_fac
integer li_pormayor, li_an

ls_ped = GetitemString(row ,"fatdiari_fact_no_pedido")		//No de pedido

ls_tipo_fac = GetitemString(row ,"fatdiari_fact_tipo")		//Tipo
li_an			= Getitemnumber(row,"fatdiari_fact_ann") //Año
// Valor de retorno 

ls_retorna=ls_ped+"="+ls_tipo_fac+"_"+string(li_an)	//Retorna el valor concatenado del pedido+"="+pormayor

CloseWithReturn ( parent, ls_retorna)
end event

event dw_1::ue_microayuda;//OVERRIDE

end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_co_facturas
integer x = 9
integer y = 0
integer width = 2702
integer height = 736
integer taborder = 0
end type

type gb_3 from groupbox within w_fa_co_facturas
integer x = 1504
integer y = 784
integer width = 1179
integer height = 184
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
borderstyle borderstyle = styleraised!
end type

type gb_nose from groupbox within w_fa_co_facturas
integer x = 9
integer width = 2702
integer height = 736
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_2 from groupbox within w_fa_co_facturas
integer x = 9
integer y = 740
integer width = 2706
integer height = 272
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Busquedas"
end type

type rb_1 from radiobutton within w_fa_co_facturas
event clicked pbm_bnclicked
integer x = 672
integer y = 912
integer width = 375
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Nom Cliente"
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()

end event

type rb_2 from radiobutton within w_fa_co_facturas
event clicked pbm_bnclicked
integer x = 1074
integer y = 912
integer width = 306
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "R.U.C."
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()

end event

type rb_3 from radiobutton within w_fa_co_facturas
event clicked pbm_bnclicked
integer x = 622
integer y = 812
integer width = 320
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "A Nombre"
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()

end event

type dw_2 from datawindow within w_fa_co_facturas
event editchanged pbm_dwnchanging
integer x = 1536
integer y = 844
integer width = 1056
integer height = 92
integer taborder = 100
boolean bringtotop = true
string dataobject = "dw_texto"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event editchanged;String ls_letra,formato,ls_setting,ls_estado
This.accepttext()

ls_letra =This.getitemstring(1,1)

If Match (ls_letra, "%") = True Then Return

If ls_letra = "Texto" and em_1.text = "" Then Return

// Permite Modificar el estado Con la Finalidad de que Funcione el Filtrado
ls_setting = dw_1.Describe("DataWindow.Retrieve.AsNeeded")
If ls_setting = "yes" Then 
	dw_1.Modify("DataWindow.Retrieve.AsNeeded=No")	
End If	

IF rb_1.Checked = True THEN /*Cliente*/
	Formato =  "String("  + "dgmterce_terc_descripcion)"  + "like "   + "'" + ls_letra +"%" + "'"

ELSEIF rb_2.Checked = True THEN /*Ruc*/
	
	Formato =  "fatdiari_fact_ruc_cliente like " +"'"+ls_letra+"%"+"'"
ELSEIF rb_3.Checked = True THEN /*A Nombre*/
	Formato =  "fatdiari_fact_a_nombre like " +"'"+ls_letra+"%"+"'"

ELSEIF rb_5.Checked = True THEN /*Estado*/
		
	Formato =  "fatdiari_fact_estado like " +"'"+ls_letra+"%"+"'"

ELSEIF rb_6.Checked = True THEN /*Fecha*/
	
	// FORMATO ORIGINAL
	Formato =  " date(fatdiari_fact_fecha) Between " + &
							"Date(" + "'" + em_1.text + "'" + ")" + " And " + & 
					"Date("+ "'" +em_2.text +"'"+")" 

ELSEIF rb_7.Checked = True THEN /*Pais*/
	Formato =  "dgapais_pais_descripcion like " +"'"+ls_letra+"%"+"'"

ELSEIf rb_4.Checked = True THEN /*pedido*/
	if ls_letra = "N" then
		Formato =  "String("  + "fatdiari_fact_no_pedido)"  + "like "  +"'"+"%"+ls_letra+"%"+"'"
	else	
	  Formato =  "String("  + "fatdiari_fact_no_pedido)"  + "like "  +"'"+ls_letra+"%"+"'"
	end if  
ELSEIf rb_8.Checked = True THEN /*factura*/

	Formato =  "String("  + "fatdiari_fact_no_factura)"  + "like "  +"'"+"%"+ls_letra+"%"+"'"

END IF

If Formato <> "" Then
	dw_1.SetFilter ( Formato)
	dw_1.Filter()
End If
end event

type rb_4 from radiobutton within w_fa_co_facturas
integer x = 41
integer y = 912
integer width = 261
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Pedido"
boolean checked = true
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()

end event

type rb_5 from radiobutton within w_fa_co_facturas
integer x = 41
integer y = 812
integer width = 242
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Estado"
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()
end event

type rb_6 from radiobutton within w_fa_co_facturas
integer x = 320
integer y = 812
integer width = 242
integer height = 76
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Fecha"
boolean lefttext = true
end type

event clicked;wf_fecha()
end event

type rb_7 from radiobutton within w_fa_co_facturas
integer x = 1001
integer y = 812
integer width = 256
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "País"
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()
end event

type pb_1 from picturebutton within w_fa_co_facturas
event clicked pbm_bnclicked
boolean visible = false
integer x = 2551
integer y = 848
integer width = 101
integer height = 88
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "\art\blind.bmp"
end type

event clicked;IF em_2.text = "" then
	em_2.text = em_1.text 
end if	

If em_1.text <> "" And em_2.text <> "" Then
	dw_2.Triggerevent("editchanged")
else
	Messagebox("Alto","Es Requerida Una fecha para Realizar la Busqueda",StopSign!)
End If	
end event

type em_1 from editmask within w_fa_co_facturas
boolean visible = false
integer x = 1710
integer y = 848
integer width = 343
integer height = 84
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
string displaydata = "~b"
end type

type em_2 from editmask within w_fa_co_facturas
boolean visible = false
integer x = 2171
integer y = 848
integer width = 343
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
string displaydata = "~b"
end type

type st_2 from statictext within w_fa_co_facturas
boolean visible = false
integer x = 1541
integer y = 860
integer width = 183
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Entre"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_fa_co_facturas
boolean visible = false
integer x = 2062
integer y = 856
integer width = 87
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "y"
alignment alignment = center!
boolean focusrectangle = false
end type

type rb_8 from radiobutton within w_fa_co_facturas
integer x = 361
integer y = 916
integer width = 265
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Factura"
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()

end event

