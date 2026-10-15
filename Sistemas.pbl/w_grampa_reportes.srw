//objectcomments Ventana padre de reportes Nivel Principal (No Tocar)
forward
global type w_grampa_reportes from window
end type
type st_ayuda from statictext within w_grampa_reportes
end type
type st_nom_ventana from statictext within w_grampa_reportes
end type
type dw_1 from datawindow within w_grampa_reportes
end type
type gb_1 from groupbox within w_grampa_reportes
end type
end forward

global type w_grampa_reportes from window
integer x = 832
integer y = 360
integer width = 1998
integer height = 1208
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
event ue_post_open ( )
event ue_zoom ( )
event ue_zoom2 ( )
event ue_imprimir ( )
event ue_print ( )
event ue_sort ( )
event ue_filter ( )
event ue_primer_reg ( )
event ue_reg_anterior ( )
event ue_siguiente_reg ( )
event ue_ultimo_reg ( )
event ue_vista ( )
st_ayuda st_ayuda
st_nom_ventana st_nom_ventana
dw_1 dw_1
gb_1 gb_1
end type
global w_grampa_reportes w_grampa_reportes

type variables
Datawindow dw
string is_ultima_ = '', is_orden_ = ''
long li_w_ancho
end variables

event ue_post_open;/* dw corresponde al datawindows que se desea imprimir, por tanto
   si desea asignarle otro nombre haga lo siguiente 
	dw = otro_nombre */
dw = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()

end event

event ue_zoom;integer il_cont
/* Programacion utilizada para las vistas previas en el reportes
   de PowerBuilder */ /*Alexis Receda*/
if dw.object.datawindow.print.preview="no" then
   dw.object.datawindow.print.preview="yes"
else 
	dw.object.datawindow.print.preview="no"
end if

choose case il_cont 
	case 0 
      dw.Object.Datawindow.print.preview.zoom = 70
		il_cont = 1
	case 1 
      dw.Object.Datawindow.print.preview.zoom = 50
		il_cont = 2
	case 2
      dw.Object.Datawindow.print.preview.zoom = 100
		il_cont = 0
end choose
/* Final de Programacion */

/* Programacion de Daniel Vergara (El Padre de Reportes) 
integer il_cont
choose case il_cont 
	case 0 
		dw_1.Object.DataWindow.Zoom = 70
		dw_1.Modify("DataWindow.Zoom=70")
		il_cont = 1
	case 1 
		dw_1.Object.DataWindow.Zoom = 50
		dw_1.Modify("DataWindow.Zoom=50")
		il_cont = 2
	case 2
		dw_1.Object.DataWindow.Zoom = 100
		dw_1.Modify("DataWindow.Zoom=100")
		il_cont = 0
end choose */
end event

event ue_zoom2;integer li_zoom
li_zoom = str.zoom



		dw_1.Object.DataWindow.Zoom = li_zoom
		dw_1.Modify("DataWindow.print.preview.Zoom=" + string(li_zoom))


end event

event ue_imprimir;OpenWithParm(w_dw_print_options, dw)
If Message.DoubleParm = -1 Then Return
dw.Print(True)

end event

event ue_print;OpenWithParm(w_dw_print_options, dw)
If Message.DoubleParm = -1 Then Return
dw.Print(True)
end event

event ue_sort();string ls_var
setnull(ls_var)


dw.SetSort (ls_var)
dw.sort()
dw.groupcalc()
end event

event ue_filter();String var
SetNull(var)

// Open The Filter Window
dw.SetFilter(var)

// Execute the filter expresion definida to the user
dw.filter()
dw.groupcalc()
end event

event ue_primer_reg;dw.scrolltorow(1)
end event

event ue_reg_anterior;dw.scrollpriorrow()
end event

event ue_siguiente_reg;dw.scrollnextrow()
end event

event ue_ultimo_reg;dw.scrolltorow(dw.rowcount())
end event

event ue_vista;if dw.object.datawindow.print.preview="no" then
   dw.object.datawindow.print.preview="yes"
else 
	dw.object.datawindow.print.preview="no"
end if
end event

on w_grampa_reportes.create
this.st_ayuda=create st_ayuda
this.st_nom_ventana=create st_nom_ventana
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.st_ayuda,&
this.st_nom_ventana,&
this.dw_1,&
this.gb_1}
end on

on w_grampa_reportes.destroy
destroy(this.st_ayuda)
destroy(this.st_nom_ventana)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;This.Icon = str.icono
this.postevent("ue_post_open")
end event

event resize;li_w_ancho = newwidth
gf_centrar_dw(this,dw_1,gb_1,st_nom_ventana)
end event

type st_ayuda from statictext within w_grampa_reportes
boolean visible = false
integer x = 1408
integer y = 764
integer width = 247
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15793151
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_nom_ventana from statictext within w_grampa_reportes
integer y = 872
integer width = 1243
integer height = 56
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_grampa_reportes
event ue_microayuda pbm_nchittest
integer x = 270
integer y = 236
integer width = 1234
integer height = 360
integer taborder = 1
boolean livescroll = true
end type

event ue_microayuda;///*
//	Evento que muestra una pequeña Ayuda dependiendo en que columna se encuentre el mouse
//*/
//
//Integer li_pos, li_x, li_y
//String ls_objeto, ls_col
//
//ls_objeto = This.GetObjectAtPointer()
//li_pos = pos  (ls_objeto,"~t")
//ls_col = left (ls_objeto, li_pos - 1)
//
//
//li_x	 = str.frame.GetActiveSheet ().PointerX () //- 900
//li_y	 = str.frame.GetActiveSheet ().PointerY () - 200
//
////messagebox("Apunta a :",ls_col)
//
//// Dependiendo de la Columna el Mensaje de Ayuda varía
//CHOOSE CASE right(ls_col,2)
//	CASE '_t'
////		messagebox("!","Invisible")
//		If st_ayuda.Visible Then Return
//		st_ayuda.Move (li_x, li_y)
//		st_ayuda.Text 	= "Haga click para ordenar por la Columna de " + this.describe(ls_col+".text")
//		st_ayuda.Width 	= Len (st_ayuda.Text) * 28
//		st_ayuda.Visible = TRUE	
//	CASE ELSE
//	st_ayuda.Visible = FALSE
//END CHOOSE
//
////Integer li_pos, li_x, li_y,li_largo
////String ls_objeto, ls_col
////
////ls_objeto = This.GetObjectAtPointer()
////li_pos = pos  (ls_objeto,"~t")
////ls_col = left (ls_objeto, li_pos - 1)
////
////li_x	 = str.frame.GetActiveSheet ().PointerX () 
////li_largo = len("Haga click para ordenar por la Columna de " + this.describe(ls_col+".text"))*28
////
////If li_x +li_largo >(li_w_ancho +100) then
////	li_x = (li_w_ancho +100) - li_largo
////end if
////
////li_y	 = str.frame.GetActiveSheet ().PointerY () - 200
////
////// Dependiendo de la Columna el Mensaje de Ayuda varía
////CHOOSE CASE right(ls_col,2)
////	CASE '_t'
////		If st_ayuda.Visible Then Return
////		st_ayuda.Move (li_x, li_y)
////		st_ayuda.Text 	= "Haga click para ordenar por la Columna de " + this.describe(ls_col+".text")
////		st_ayuda.Width 	= Len (st_ayuda.Text) * 28
////		st_ayuda.Visible = TRUE	
////	CASE ELSE
////	st_ayuda.Visible = FALSE
////END CHOOSE
end event

event constructor;dw=this
end event

event clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto
integer li_pos 

this.Setredraw(false)

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if right(ls_objeto,2)='_t' then

	ls_objeto = left(ls_objeto,len(ls_objeto)-2)
	
	if ls_objeto = is_ultima_ or is_ultima_ = "" then	//Si es la misma columna 
																	// o si es la primera vez
		if is_orden_  = "" or is_orden_ = "D" then
			is_orden_ = 'A'		
			this.SetSort(ls_objeto+" A")	//Ordena Ascendente
			this.sort()		
		else
			is_orden_ = 'D'					
			this.SetSort(ls_objeto+" D")	//Ordena Descendente
			this.sort()				
		end if	
		is_ultima_ = ls_objeto		
	else				
			is_orden_ = 'A'
			this.SetSort(ls_objeto+" A")
			this.sort()
			is_ultima_ = ls_objeto
	end if

end if

this.Setredraw(true)
end event

type gb_1 from groupbox within w_grampa_reportes
integer x = 238
integer y = 180
integer width = 1298
integer height = 436
integer taborder = 1
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

