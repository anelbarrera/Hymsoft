//objectcomments Busqueda Rapida de Productos Incluidos y Por Incluir en el Packing List
forward
global type w_fa_co_productos_packing_cb from w_fa_padre_reportes
end type
type gb_3 from groupbox within w_fa_co_productos_packing_cb
end type
type gb_2 from groupbox within w_fa_co_productos_packing_cb
end type
type rb_2 from radiobutton within w_fa_co_productos_packing_cb
end type
type rb_3 from radiobutton within w_fa_co_productos_packing_cb
end type
type dw_2 from datawindow within w_fa_co_productos_packing_cb
end type
type rb_1 from radiobutton within w_fa_co_productos_packing_cb
end type
type rb_4 from radiobutton within w_fa_co_productos_packing_cb
end type
type rb_5 from radiobutton within w_fa_co_productos_packing_cb
end type
type rb_6 from radiobutton within w_fa_co_productos_packing_cb
end type
type em_1 from editmask within w_fa_co_productos_packing_cb
end type
type em_2 from editmask within w_fa_co_productos_packing_cb
end type
type pb_1 from picturebutton within w_fa_co_productos_packing_cb
end type
type st_2 from statictext within w_fa_co_productos_packing_cb
end type
type st_3 from statictext within w_fa_co_productos_packing_cb
end type
type cbx_ver from checkbox within w_fa_co_productos_packing_cb
end type
type st_microhelp from statictext within w_fa_co_productos_packing_cb
end type
end forward

global type w_fa_co_productos_packing_cb from w_fa_padre_reportes
integer width = 2642
integer height = 1264
string title = "(FA) Productos"
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
gb_3 gb_3
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
cbx_ver cbx_ver
st_microhelp st_microhelp
end type
global w_fa_co_productos_packing_cb w_fa_co_productos_packing_cb

type variables
str_fa_pedi_empaque str_empaque
string  is_filter
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

on w_fa_co_productos_packing_cb.create
int iCurrent
call super::create
this.gb_3=create gb_3
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
this.cbx_ver=create cbx_ver
this.st_microhelp=create st_microhelp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.rb_3
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.rb_1
this.Control[iCurrent+7]=this.rb_4
this.Control[iCurrent+8]=this.rb_5
this.Control[iCurrent+9]=this.rb_6
this.Control[iCurrent+10]=this.em_1
this.Control[iCurrent+11]=this.em_2
this.Control[iCurrent+12]=this.pb_1
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.cbx_ver
this.Control[iCurrent+16]=this.st_microhelp
end on

on w_fa_co_productos_packing_cb.destroy
call super::destroy
destroy(this.gb_3)
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
destroy(this.cbx_ver)
destroy(this.st_microhelp)
end on

event ue_post_open;call super::ue_post_open;Integer	li_anio
String	ls_pedido, ls_tipo

//Titulo de la Ventana
this.title = str_empaque.titulo

if str_empaque.fuente = 'PE' then
	If str_empaque.viene_de = 'w_fa_man_packing_list_x' then
		dw_1.Dataobject  = "dw_ma_fa_pedi_packing_tel"
	else
		dw_1.Dataobject  = "dw_ma_fa_pedi_packing_cb"
	end if
else
	If str_empaque.viene_de = 'w_fa_man_packing_list_x' then
		dw_1.Dataobject  = "dw_ma_fa_fact_packing_tel"
	else
		dw_1.Dataobject  = "dw_ma_fa_fact_packing_cb"
	end if
end if

is_filter = "compute_2 > 0 "

If str_empaque.viene_de = 'w_fa_man_packing_list_x' then
	dw_1.Object.Data = w_fa_man_packing_list_x.tab_1.tabpage_1.dw_4.Object.data
else
	dw_1.Object.Data = w_fa_man_packing_list.tab_1.tabpage_1.dw_4.Object.data
end if

/**/if str_empaque.viene_de = 'w_fa_man_packing_list_x' then  
	dw_1.settransobject(sqlca)
	If str_empaque.fuente = 'PE' then
		li_anio 	= dw_1.getItemNumber(1,'pedi_ann')
		ls_pedido=  dw_1.getItemString(1,'pedi_no_pedido')
		dw_1.Retrieve(str.g_financiero, str.empresa, ls_pedido, li_anio)
	else
		li_anio 	= dw_1.getItemNumber(1,'fact_ann')
		ls_pedido=  dw_1.getItemString(1,'fact_no_pedido')
		ls_tipo 	= dw_1.getItemString(1,'fact_tipo')
		dw_1.Retrieve(str.g_financiero, str.empresa, ls_pedido, li_anio, ls_tipo)
	end if
	w_fa_man_packing_list_x.tab_1.tabpage_1.dw_4.Object.data =dw_1.Object.Data
end if
/**/
dw_1.SetFilter (is_filter)
dw_1.Filter()

SetPointer(HourGlass!)

Dw_2.SetTransObject(SQLCA)
Dw_2.InsertRow(0)

/*** Setea el foco en la columna texto del dw_2 ****/
dw_2.setfocus()
dw_2.SetColumn("texto")
if str_empaque.producto <> "" and not isnull(str_empaque.producto ) then
	dw_2.SetItem(1,"texto",str_empaque.producto)
	dw_2.Postevent("editchanged")
end if
/**************/
This.Setredraw(true)
dw_1.Setredraw(true)
str.frame.SetRedraw (true)

str.frame.SetMicroHelp ("Seleccione una Linea y Precione la Tecla Enter para Cargar la Información" )
end event

event resize;//Override
end event

event key;//Override

if keydown(keyEscape!) then
	this.Postevent("close")
end if
end event

event open;//OVERRIDE
/***************************/
gf_center_win(This)
/**************************/

This.Setredraw(false)
dw_1.Setredraw(false)
str.frame.SetRedraw ( false )

dw = dw_1
dw_impresion = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()

//Configurar los Accesos
//mf_accesos(this.menuid, this)

This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)
This.icon = str.icono

str_empaque = Message.PowerObjectParm

This.Postevent("ue_post_open")

end event

event timer;st_microhelp.Visible = FALSE
end event

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_co_productos_packing_cb
integer x = 14
integer y = 1112
end type

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_co_productos_packing_cb
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_co_productos_packing_cb
event ue_down pbm_dwnkey
event ue_entercol ( )
event ue_escape pbm_dwescape
event ue_sobre pbm_nchittest
integer x = 9
integer y = 36
integer width = 2592
integer height = 772
integer taborder = 110
string dataobject = "dw_ma_fa_pedi_packing_tel"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

event dw_1::ue_down;//Si el Usuario Dio Enter
If key = Keyenter! Then 

	This.Postevent("ue_entercol")
	return(2)
	
Elseif  keydown(KeyEscape!) then
	parent.postevent("close")
End If
end event

event dw_1::ue_entercol;String  ls_prod, ls_ubicacion, ls_bodega
Integer li_linea
decimal	  ld_disponible = 0

//ld_disponible = This.GetitemNumber(This.Getrow() ,"cant_disponible") 
ld_disponible = This.GetitemNumber(This.Getrow() ,"compute_2") 

if ld_disponible <= 0 then 
	  // Mensaje en el Microhelp	
	
		If st_microhelp.Visible Then Return
		st_microhelp.Move (45, 32 )
		st_microhelp.Text 	= "No Podrá Seleccionar este Artículo, Ya Que No Tiene Disponible"
		st_microhelp.Width 	= Len (st_microhelp.Text) * 28
		st_microhelp.Visible = TRUE

 	   timer(2)
	 	return
elseif not str_empaque.devuelve then
		//// Mensaje en el Microhelp
	
		If st_microhelp.Visible Then Return
		st_microhelp.Move (45, 32 )
		st_microhelp.Text 	= "No Podrá Seleccionar este Artículo, Debe Posicionarse en una Linea Nueva"
		st_microhelp.Width 	= Len (st_microhelp.Text) * 28
		st_microhelp.Visible = TRUE

 	   timer(3)
	 	return
end if

ls_prod 		  = This.GetitemString(This.Getrow() ,"codigo_item")
 
if str_empaque.fuente = 'PE' then 
	li_linea		  = This.GetitemNumber(This.Getrow() ,"dped_linea")
else
	li_linea		  = This.GetitemNumber(This.Getrow() ,"facd_linea")
end if

str.frame.Getactivesheet().Dynamic wf_setear_cod_prod(ls_prod, li_linea,ld_disponible)

close(parent)
end event

event dw_1::ue_sobre;//// Ayuda en el Microhelp
//
//String	ls_objeto, ls_row
//
//ls_objeto = GetObjectAtPointer ()
//ls_row	 = Right (ls_objeto, Len (ls_objeto) - Pos (ls_objeto, '~t') + 1)
//ls_objeto = Left (ls_objeto, Pos (ls_objeto, '~t') - 1)
//
//is_last_row = integer (ls_row)
////str.frame.Setmicrohelp("Antes de comparar, columna y objeto "+is_last_column +"  "+ls_objeto)
//If is_last_column = ls_objeto Then 
////	str.frame.Setmicrohelp("Entro al return, columna y objeto "+is_last_column +"  "+ls_objeto)
////	st_microhelp.Visible = FALSE	
//	Return
//end if
//
//is_last_column = lower (ls_objeto)
//
//integer	li_x, li_y
//
//li_x	 = str.frame.GetActiveSheet ().PointerX () 
//li_y	 = str.frame.GetActiveSheet ().PointerY ()
//
//choose case is_last_column 
//	case "sube"
////		If st_microhelp.Visible Then Return
////		st_microhelp.Move (li_x - 1700, li_y  + 30)
////		st_microhelp.Text 	= "Haga click para Subir el Registro o pulse << Shift+Flecha Arriba >>"
////		st_microhelp.Width 	= Len (st_microhelp.Text) * 28
////		st_microhelp.Visible = TRUE
////
//	case else
//		st_microhelp.Visible = FALSE
//		
//end choose
//
////timer(18)
end event

event dw_1::rbuttondown;//
end event

event dw_1::doubleclicked;call super::doubleclicked;This.TriggerEvent("ue_entercol")
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_co_productos_packing_cb
integer x = 5
integer y = 0
integer width = 2615
integer height = 840
integer taborder = 0
end type

type gb_3 from groupbox within w_fa_co_productos_packing_cb
integer x = 1280
integer y = 884
integer width = 1019
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

type gb_2 from groupbox within w_fa_co_productos_packing_cb
integer x = 14
integer y = 848
integer width = 2606
integer height = 236
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Busquedas"
end type

type rb_2 from radiobutton within w_fa_co_productos_packing_cb
event clicked pbm_bnclicked
integer x = 425
integer y = 900
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

type rb_3 from radiobutton within w_fa_co_productos_packing_cb
event clicked pbm_bnclicked
integer x = 914
integer y = 904
integer width = 297
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

type dw_2 from datawindow within w_fa_co_productos_packing_cb
event ue_escape pbm_dwescape
integer x = 1335
integer y = 940
integer width = 891
integer height = 108
integer taborder = 100
boolean bringtotop = true
string dataobject = "dw_texto"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_escape;Parent.postevent("close")
end event

event editchanged;// Script que filtra los Items de Dw_1

String ls_letra,formato = "",ls_setting
This.accepttext()
ls_letra =This.getitemstring(1,1) 

// Permite Modificar el estado Con la Finalidad de que Funcione el Filtrado
IF rb_1.Checked = True THEN /*Codigo*/
	Formato =  " and codigo_item like " + "'" + ls_letra +"%" + "'"

ELSEIF rb_2.Checked = True THEN /*Descripción*/
	
	Formato =  " and prod_descripcion like " +"'"+ls_letra+"%"+"'"
	
ELSEIF rb_3.Checked = True THEN /* Unidad de Producto*/
  if str_empaque.fuente = 'PE' then
	Formato =  " and dped_unidad_venta like " +"'"+ls_letra+"%"+"'"
  else
	Formato =  " and facd_unidad_venta like " +"'"+ls_letra+"%"+"'"	
  end if
ELSEIF rb_4.Checked = True THEN /* Grupo*/
	Formato =  " and agru_descripcion_grupo like " +"'"+ls_letra+"%"+"'"

END IF

// Filtra  Los Datos
//If Formato <> "" Then
dw_1.SetFilter ( 	is_filter + Formato)
dw_1.Filter()
//End If
end event

type rb_1 from radiobutton within w_fa_co_productos_packing_cb
integer x = 50
integer y = 904
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
string text = "Código"
boolean checked = true
boolean lefttext = true
end type

event clicked;Dw_2.Postevent("editchanged")
wf_nofecha()
end event

type rb_4 from radiobutton within w_fa_co_productos_packing_cb
boolean visible = false
integer x = 46
integer y = 892
integer width = 306
integer height = 76
integer taborder = 60
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

type rb_5 from radiobutton within w_fa_co_productos_packing_cb
boolean visible = false
integer x = 425
integer y = 888
integer width = 430
integer height = 76
integer taborder = 90
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

type rb_6 from radiobutton within w_fa_co_productos_packing_cb
boolean visible = false
integer x = 1349
integer y = 1016
integer width = 430
integer height = 76
integer taborder = 80
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

type em_1 from editmask within w_fa_co_productos_packing_cb
boolean visible = false
integer x = 1522
integer y = 852
integer width = 302
integer height = 84
integer taborder = 120
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

type em_2 from editmask within w_fa_co_productos_packing_cb
boolean visible = false
integer x = 1925
integer y = 852
integer width = 302
integer height = 84
integer taborder = 70
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

type pb_1 from picturebutton within w_fa_co_productos_packing_cb
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

type st_2 from statictext within w_fa_co_productos_packing_cb
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

type st_3 from statictext within w_fa_co_productos_packing_cb
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

type cbx_ver from checkbox within w_fa_co_productos_packing_cb
integer x = 27
integer y = 996
integer width = 919
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
long backcolor = 79741120
string text = "Ver Todos los Productos "
boolean lefttext = true
borderstyle borderstyle = stylelowered!
boolean righttoleft = true
end type

event clicked;if cbx_ver.checked then
	is_filter = "cant_disponible <> 11111111111"
	cbx_ver.text = "Ver Los Productos Por Asignar "
else
	is_filter = "cant_disponible > 0 "
	cbx_ver.text = "Ver Todos los Productos "
end if

dw_1.SetFilter (is_filter)
dw_1.Filter()

end event

type st_microhelp from statictext within w_fa_co_productos_packing_cb
boolean visible = false
integer x = 1810
integer y = 1096
integer width = 507
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15793151
boolean enabled = false
string text = "microhelp"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

