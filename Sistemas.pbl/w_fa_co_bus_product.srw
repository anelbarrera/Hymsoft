//objectcomments Busqueda Rapida de Productos
forward
global type w_fa_co_bus_product from w_fa_padre_reportes
end type
type gb_3 from groupbox within w_fa_co_bus_product
end type
type gb_nose from groupbox within w_fa_co_bus_product
end type
type gb_2 from groupbox within w_fa_co_bus_product
end type
type rb_2 from radiobutton within w_fa_co_bus_product
end type
type rb_3 from radiobutton within w_fa_co_bus_product
end type
type dw_2 from datawindow within w_fa_co_bus_product
end type
type rb_1 from radiobutton within w_fa_co_bus_product
end type
type rb_4 from radiobutton within w_fa_co_bus_product
end type
type rb_5 from radiobutton within w_fa_co_bus_product
end type
type rb_6 from radiobutton within w_fa_co_bus_product
end type
type em_1 from editmask within w_fa_co_bus_product
end type
type em_2 from editmask within w_fa_co_bus_product
end type
type pb_1 from picturebutton within w_fa_co_bus_product
end type
type st_2 from statictext within w_fa_co_bus_product
end type
type st_3 from statictext within w_fa_co_bus_product
end type
end forward

global type w_fa_co_bus_product from w_fa_padre_reportes
int Width=3319
int Height=1180
WindowType WindowType=response!
boolean TitleBar=true
string Title="(FA) Consulta de Productos"
string MenuName=""
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
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
global w_fa_co_bus_product w_fa_co_bus_product

forward prototypes
public subroutine wf_fecha ()
public subroutine wf_nofecha ()
end prototypes

public subroutine wf_fecha ();dw_2.visible = false
em_1.visible = True
em_2.visible = True
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
dw_2.SetColumn("texto")
end subroutine

on w_fa_co_bus_product.create
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

on w_fa_co_bus_product.destroy
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
end event

event key;//Override
end event

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_co_bus_product
int X=14
int Y=1024
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_co_bus_product
event ue_down pbm_dwnkey
event ue_entercol ( )
event ue_escape pbm_dwescape
int X=23
int Y=44
int Width=3191
int Height=664
int TabOrder=100
string DataObject="dw_co_fa_bus_productos"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
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

event dw_1::ue_entercol;call super::ue_entercol;String  ls_prod, ls_ubicacion, ls_bodega

ls_prod 		 = GetitemString(This.Getrow() ,"prod_producto")
ls_bodega	 = Getitemstring(This.Getrow() ,"mbod_bodega")
ls_ubicacion = Getitemstring(This.Getrow() ,"mbod_ubicacion")

//messagebox("Devuelve",ls_prod+"_"+ls_bodega+"-"+ls_ubicacion+"  fila "+string(this.getrow()))

CloseWithReturn ( parent, ls_prod+"_"+ls_bodega+"-"+ls_ubicacion)
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

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_co_bus_product
int X=5
int Y=0
int Width=3227
int Height=736
int TabOrder=0
end type

type gb_3 from groupbox within w_fa_co_bus_product
int X=1280
int Y=792
int Width=1134
int Height=180
BorderStyle BorderStyle=StyleRaised!
long BackColor=79416533
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_nose from groupbox within w_fa_co_bus_product
int X=5
int Width=2597
int Height=736
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_fa_co_bus_product
int X=5
int Y=736
int Width=2597
int Height=268
string Text="Busquedas"
long BackColor=79416533
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_2 from radiobutton within w_fa_co_bus_product
event clicked pbm_bnclicked
int X=425
int Y=808
int Width=430
int Height=76
int TabOrder=20
boolean BringToTop=true
string Text="Descripción"
boolean LeftText=true
long BackColor=79416533
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//Dw_2.Postevent("editchanged")
wf_nofecha()
end event

type rb_3 from radiobutton within w_fa_co_bus_product
event clicked pbm_bnclicked
int X=878
int Y=812
int Width=334
int Height=76
int TabOrder=30
boolean BringToTop=true
string Text="Unidad"
boolean LeftText=true
long BackColor=79416533
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()
end event

type dw_2 from datawindow within w_fa_co_bus_product
event ue_escape pbm_dwescape
int X=1335
int Y=848
int Width=997
int Height=92
int TabOrder=90
boolean BringToTop=true
string DataObject="dw_texto"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event ue_escape;Parent.postevent("close")
end event

event editchanged;// Script que filta los Items de Dw_1
String ls_letra,formato,ls_setting
This.accepttext()
ls_letra =This.getitemstring(1,1) 

// Permite Modificar el estado Con la Finalidad de que Funcione el Filtrado

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

type rb_1 from radiobutton within w_fa_co_bus_product
int X=46
int Y=808
int Width=306
int Height=76
int TabOrder=10
boolean BringToTop=true
string Text="Código"
boolean Checked=true
boolean LeftText=true
long BackColor=79416533
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()
end event

type rb_4 from radiobutton within w_fa_co_bus_product
int X=46
int Y=892
int Width=306
int Height=76
int TabOrder=50
boolean BringToTop=true
string Text="Grupo"
boolean LeftText=true
long BackColor=79416533
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()
end event

type rb_5 from radiobutton within w_fa_co_bus_product
int X=425
int Y=888
int Width=430
int Height=76
int TabOrder=80
boolean Visible=false
boolean BringToTop=true
string Text="Proveedor"
boolean LeftText=true
long BackColor=79416533
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()
end event

type rb_6 from radiobutton within w_fa_co_bus_product
int X=1349
int Y=1016
int Width=430
int Height=76
int TabOrder=70
boolean Visible=false
boolean BringToTop=true
string Text="F. de Creación"
boolean LeftText=true
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_fecha()
end event

type em_1 from editmask within w_fa_co_bus_product
int X=1522
int Y=852
int Width=302
int Height=84
int TabOrder=110
boolean Visible=false
boolean BringToTop=true
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yyyy"
MaskDataType MaskDataType=DateMask!
string DisplayData=""
long BackColor=16777215
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_2 from editmask within w_fa_co_bus_product
int X=1925
int Y=852
int Width=302
int Height=84
int TabOrder=60
boolean Visible=false
boolean BringToTop=true
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yyyy"
MaskDataType MaskDataType=DateMask!
string DisplayData=""
long BackColor=16777215
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type pb_1 from picturebutton within w_fa_co_bus_product
event clicked pbm_bnclicked
int X=2245
int Y=848
int Width=101
int Height=88
int TabOrder=40
boolean Visible=false
boolean BringToTop=true
string PictureName="\art\blind.bmp"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;If em_1.text <> "" And em_2.text <> "" Then
	dw_2.Triggerevent("editchanged")
else
	Messagebox("Alto","Es Requerida Una fecha para Realizar la Busqueda",StopSign!)
End If	
end event

type st_2 from statictext within w_fa_co_bus_product
int X=1349
int Y=860
int Width=178
int Height=76
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="Entre"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_fa_co_bus_product
int X=1819
int Y=860
int Width=96
int Height=76
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
string Text="y"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

