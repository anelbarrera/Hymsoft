//objectcomments Busqueda Rapida de Productos en Confirmación
forward
global type w_fa_co_bus_productos_confirma from w_fa_padre_reportes
end type
type gb_3 from groupbox within w_fa_co_bus_productos_confirma
end type
type gb_nose from groupbox within w_fa_co_bus_productos_confirma
end type
type gb_2 from groupbox within w_fa_co_bus_productos_confirma
end type
type rb_2 from radiobutton within w_fa_co_bus_productos_confirma
end type
type rb_3 from radiobutton within w_fa_co_bus_productos_confirma
end type
type dw_2 from datawindow within w_fa_co_bus_productos_confirma
end type
type rb_1 from radiobutton within w_fa_co_bus_productos_confirma
end type
type rb_4 from radiobutton within w_fa_co_bus_productos_confirma
end type
type rb_5 from radiobutton within w_fa_co_bus_productos_confirma
end type
type rb_6 from radiobutton within w_fa_co_bus_productos_confirma
end type
type em_1 from editmask within w_fa_co_bus_productos_confirma
end type
type em_2 from editmask within w_fa_co_bus_productos_confirma
end type
type pb_1 from picturebutton within w_fa_co_bus_productos_confirma
end type
type st_2 from statictext within w_fa_co_bus_productos_confirma
end type
type st_3 from statictext within w_fa_co_bus_productos_confirma
end type
end forward

global type w_fa_co_bus_productos_confirma from w_fa_padre_reportes
integer x = 151
integer y = 400
integer width = 3319
integer height = 1312
string title = "(FA) Consulta de Productos"
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
gb_3 gb_3
gb_nose gb_nose
gb_2 gb_2
rb_2 rb_2
rb_3 rb_3
dw_2 dw_2
rb_1 rb_1
rb_4 rb_4
rb_5 rb_5
rb_6 rb_6
em_1 em_1
em_2 em_2
pb_1 pb_1
st_2 st_2
st_3 st_3
end type
global w_fa_co_bus_productos_confirma w_fa_co_bus_productos_confirma

type variables
window iw_this
end variables

forward prototypes
public subroutine wf_nofecha ()
public subroutine wf_fecha ()
end prototypes

public subroutine wf_nofecha ();dw_2.visible = True
em_1.visible = false
em_2.visible = false
pb_1.visible = false
st_2.visible = false
st_3.visible = false
dw_2.setfocus()
dw_2.SetColumn("texto")
end subroutine

public subroutine wf_fecha ();dw_2.visible = false
em_1.visible = True
em_2.visible = True
pb_1.visible = True
st_2.visible = True
st_3.visible = True
em_1.setfocus()

end subroutine

on w_fa_co_bus_productos_confirma.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.gb_nose=create gb_nose
this.gb_2=create gb_2
this.rb_2=create rb_2
this.rb_3=create rb_3
this.dw_2=create dw_2
this.rb_1=create rb_1
this.rb_4=create rb_4
this.rb_5=create rb_5
this.rb_6=create rb_6
this.em_1=create em_1
this.em_2=create em_2
this.pb_1=create pb_1
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.gb_nose
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.rb_2
this.Control[iCurrent+5]=this.rb_3
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.rb_1
this.Control[iCurrent+8]=this.rb_4
this.Control[iCurrent+9]=this.rb_5
this.Control[iCurrent+10]=this.rb_6
this.Control[iCurrent+11]=this.em_1
this.Control[iCurrent+12]=this.em_2
this.Control[iCurrent+13]=this.pb_1
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.st_3
end on

on w_fa_co_bus_productos_confirma.destroy
call super::destroy
destroy(this.gb_3)
destroy(this.gb_nose)
destroy(this.gb_2)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.dw_2)
destroy(this.rb_1)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.rb_6)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.st_3)
end on

event ue_post_open;//Override
/* dw corresponde al datawindows que se desea imprimir, por tanto
   si desea asignarle otro nombre haga lo siguiente 
	dw = otro_nombre */
string ls_tipo_reserva
iw_this = message.powerobjectparm

iw_this.Dynamic wf_tipo_reserva(ls_tipo_reserva)

if ls_tipo_reserva = 'T' then
	dw_1.dataobject = 'dw_co_fa_bus_productos_transito'
end if

dw = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()
dw_impresion = dw_1

This.Setredraw(false)
dw_1.Setredraw(false)

dw.Retrieve(str.g_financiero,str.empresa)
SetPointer(HourGlass!)

dw_2.SetTransObject(SQLCA)
Dw_2.InsertRow(0)

/*** Setea el foco en la columna texto del dw_2 ****/
dw_2.setfocus()
dw_2.SetColumn("texto")
/**************/
This.Setredraw(true)
dw_1.Setredraw(true)
str.frame.SetMicroHelp ("Seleccione una Linea y Precione la Tecla Enter para Cargar la Información" )


end event

event resize;//Override
end event

event close;//Override
if isvalid(this) then close(this)

end event

event key;//Override
end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_co_bus_productos_confirma
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_co_bus_productos_confirma
integer x = 14
integer y = 1160
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_co_bus_productos_confirma
event ue_down pbm_dwnkey
event ue_entercol ( )
event ue_escape pbm_dwescape
integer x = 23
integer y = 40
integer width = 3191
integer height = 804
integer taborder = 100
string dataobject = "dw_co_fa_bus_productos_confirma"
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

event dw_1::ue_down;//Si el Usuario Dio Enter
If key = Keyenter! Then 
	This.Postevent("ue_entercol")
	return(2)
//ElseIf key = KeyUpArrow! Then
//This.ScrollPriorRow ( ) 
//
//ElseIf key = KeyDownArrow! Then
//This.ScrollNextRow ( ) 	
End If	



end event

event dw_1::ue_entercol;String  ls_prod, ls_numero
integer li_linea
long    ll_ann

ls_prod 		 = GetitemString(This.Getrow() ,"prod_producto")
ls_numero	 = Getitemstring(This.Getrow() ,"numero")
ll_ann 		 = GetitemNumber(This.Getrow() ,"ann")
li_linea		 = GetitemNumber(This.Getrow() ,"linea")

iw_this.dynamic wf_asigna_valores(ls_prod,ls_numero,ll_ann,li_linea)
//messagebox("Devuelve",ls_prod+"_"+ls_bodega+"-"+ls_ubicacion+"  fila "+string(this.getrow()))

parent.postevent('close')
end event

event dw_1::rbuttondown;//
end event

event dw_1::doubleclicked;call super::doubleclicked;This.TriggerEvent("ue_entercol")
end event

event dw_1::ue_microayuda;//OVERRIDE
/*
	Evento que muestra una pequeña Ayuda dependiendo en que columna se encuentre el mouse
*/

Integer li_pos, li_x, li_y
String ls_objeto, ls_col

ls_objeto = This.GetObjectAtPointer()
li_pos = pos  (ls_objeto,"~t")
ls_col = left (ls_objeto, li_pos - 1)


li_x	 = str.frame.GetActiveSheet ().PointerX () //- 900
li_y	 = str.frame.GetActiveSheet ().PointerY () //- 200

//messagebox("Apunta a :",ls_col)

// Dependiendo de la Columna el Mensaje de Ayuda varía
CHOOSE CASE right(ls_col,2)
	CASE '_t'
//		messagebox("!","Invisible")
		If st_ayuda.Visible Then Return
		st_ayuda.Move (li_x, li_y)
		st_ayuda.Text 	= "Haga click para ordenar por la Columna de " + this.describe(ls_col+".text")
		st_ayuda.Width 	= Len (st_ayuda.Text) * 28
		st_ayuda.Visible = TRUE	
	CASE ELSE
	st_ayuda.Visible = FALSE
END CHOOSE
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_co_bus_productos_confirma
integer x = 5
integer y = 0
integer width = 3227
integer height = 872
integer taborder = 0
end type

type gb_3 from groupbox within w_fa_co_bus_productos_confirma
integer x = 1280
integer y = 928
integer width = 1134
integer height = 180
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
borderstyle borderstyle = styleraised!
end type

type gb_nose from groupbox within w_fa_co_bus_productos_confirma
integer x = 5
integer width = 2597
integer height = 736
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_2 from groupbox within w_fa_co_bus_productos_confirma
integer x = 5
integer y = 872
integer width = 2597
integer height = 268
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Busquedas"
end type

type rb_2 from radiobutton within w_fa_co_bus_productos_confirma
event clicked pbm_bnclicked
integer x = 425
integer y = 944
integer width = 430
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Descripción"
boolean lefttext = true
end type

event clicked;//Dw_2.Postevent("editchanged")
wf_nofecha()
end event

type rb_3 from radiobutton within w_fa_co_bus_productos_confirma
event clicked pbm_bnclicked
integer x = 878
integer y = 948
integer width = 334
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Unidad"
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()
end event

type dw_2 from datawindow within w_fa_co_bus_productos_confirma
event ue_escape pbm_dwescape
integer x = 1335
integer y = 984
integer width = 997
integer height = 100
integer taborder = 90
boolean bringtotop = true
string dataobject = "dw_texto"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_escape;Parent.postevent("close")
end event

event editchanged;// Script que filta los Items de Dw_1
String ls_letra,formato,ls_setting
This.accepttext()
ls_letra =This.getitemstring(1,1) 

IF rb_1.Checked = True THEN /*Codigo*/
	Formato =  "String("  + "prod_producto)"  + "like "   + "'" + ls_letra +"%" + "'"

ELSEIF rb_2.Checked = True THEN /*Descripción*/
	
	Formato =  "prod_descripcion like " +"'"+ls_letra+"%"+"'"
	
ELSEIF rb_3.Checked = True THEN /* Unidad de Producto*/
	Formato =  "medi_descripcion like " +"'"+ls_letra+"%"+"'"

ELSEIF rb_4.Checked = True THEN /* Grupo*/
	Formato =  "agru_descripcion_grupo like " +"'"+ls_letra+"%"+"'"

//ELSEIF rb_5.Checked = True THEN /* Proveedor*/
//	Formato =  "terc_descripcion like " +"'"+ls_letra+"%"+"'"

ELSEIF rb_6.Checked = True THEN /* Fecha de Creación*/
//	Formato =  " inmprodu_prod_fecha_creacion Between " + &
	//                  "Date(" + "'" + em_1.text + "'" + ")" + " And " + & 
		//			"Date("+ "'" +em_2.text +"'"+")"
END IF

// Filtra  Los Datos
If Formato <> "" Then
	dw_1.SetFilter ( Formato)
	dw_1.Filter()
End If
end event

type rb_1 from radiobutton within w_fa_co_bus_productos_confirma
integer x = 46
integer y = 944
integer width = 306
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Producto"
boolean checked = true
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()
end event

type rb_4 from radiobutton within w_fa_co_bus_productos_confirma
integer x = 46
integer y = 1028
integer width = 306
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Grupo"
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()
end event

type rb_5 from radiobutton within w_fa_co_bus_productos_confirma
boolean visible = false
integer x = 425
integer y = 888
integer width = 430
integer height = 76
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Proveedor"
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()
end event

type rb_6 from radiobutton within w_fa_co_bus_productos_confirma
boolean visible = false
integer x = 1349
integer y = 1016
integer width = 430
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "F. de Creación"
boolean lefttext = true
end type

event clicked;wf_fecha()
end event

type em_1 from editmask within w_fa_co_bus_productos_confirma
boolean visible = false
integer x = 1522
integer y = 852
integer width = 302
integer height = 84
integer taborder = 110
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
string displaydata = ""
end type

type em_2 from editmask within w_fa_co_bus_productos_confirma
boolean visible = false
integer x = 1925
integer y = 852
integer width = 302
integer height = 84
integer taborder = 60
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
string displaydata = ""
end type

type pb_1 from picturebutton within w_fa_co_bus_productos_confirma
event clicked pbm_bnclicked
boolean visible = false
integer x = 2245
integer y = 848
integer width = 101
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\art\blind.bmp"
end type

event clicked;If em_1.text <> "" And em_2.text <> "" Then
	dw_2.Triggerevent("editchanged")
else
	Messagebox("Alto","Es Requerida Una fecha para Realizar la Busqueda",StopSign!)
End If	
end event

type st_2 from statictext within w_fa_co_bus_productos_confirma
boolean visible = false
integer x = 1349
integer y = 860
integer width = 178
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

type st_3 from statictext within w_fa_co_bus_productos_confirma
boolean visible = false
integer x = 1819
integer y = 860
integer width = 96
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

