//objectcomments  
forward
global type w_fa_co_selec_modelo_print from w_fa_padre
end type
type cb_aceptar from commandbutton within w_fa_co_selec_modelo_print
end type
type st_1 from statictext within w_fa_co_selec_modelo_print
end type
type cb_cancelar from commandbutton within w_fa_co_selec_modelo_print
end type
type st_2 from statictext within w_fa_co_selec_modelo_print
end type
type sle_nom_ventana from singlelineedit within w_fa_co_selec_modelo_print
end type
type gb_1 from groupbox within w_fa_co_selec_modelo_print
end type
end forward

global type w_fa_co_selec_modelo_print from w_fa_padre
int Width=1842
int Height=688
WindowType WindowType=response!
boolean TitleBar=true
string Title="(FA) Ventana de Selección de Modelo de Impresoras"
boolean ControlMenu=false
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
ToolBarAlignment ToolBarAlignment=Floating!
cb_aceptar cb_aceptar
st_1 st_1
cb_cancelar cb_cancelar
st_2 st_2
sle_nom_ventana sle_nom_ventana
gb_1 gb_1
end type
global w_fa_co_selec_modelo_print w_fa_co_selec_modelo_print

type variables
str_fa_dimen_doc  str_fa_doctos
Long il_old_row

end variables

forward prototypes
public subroutine wf_aceptar ()
public subroutine wf_centrar ()
end prototypes

public subroutine wf_aceptar ();
If dw_1.Rowcount() = 1 Then
	this.hide()
	str_fa_doctos.largo_doc = dw_1.GetItemNumber(1,"primod_largo_doc") 
	str_fa_doctos.ancho_doc = dw_1.GetItemNumber(1,"primod_ancho_doc")
	str_fa_doctos.aceptar = true
	this.triggerevent("Close")
	return
Else
	If dw_1.IsSelected(dw_1.GetRow()) = TRUE Then
		//cargar estructura con los documentos
		str_fa_doctos.largo_doc = dw_1.GetItemNumber(dw_1.GetRow(),"primod_largo_doc") 
		str_fa_doctos.ancho_doc = dw_1.GetItemNumber(dw_1.GetRow(),"primod_ancho_doc")
		str_fa_doctos.aceptar = true
		this.triggerevent("Close")
	Else
		mensaje("Atención ","No hay registro seleccionado, selecciónelo ...","")
		Return
	End If
End If

end subroutine

public subroutine wf_centrar ();integer li_posicion_x,li_posicion_y

li_posicion_x=str.frame.width/2 - 60  - this.width/2
li_posicion_y=str.frame.height/2 -100 - this.height/2

if 0 > li_posicion_x then
	li_posicion_x=1
	this.HScrollBar = True
else
	this.HScrollBar = false
end if

if 0 > li_posicion_y then
	li_posicion_y = 1
	this.VScrollbar = true
else
	this.VScrollBar = False
end if
 this.x=li_posicion_x
 
end subroutine

on w_fa_co_selec_modelo_print.create
int iCurrent
call super::create
this.cb_aceptar=create cb_aceptar
this.st_1=create st_1
this.cb_cancelar=create cb_cancelar
this.st_2=create st_2
this.sle_nom_ventana=create sle_nom_ventana
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_aceptar
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_cancelar
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.sle_nom_ventana
this.Control[iCurrent+6]=this.gb_1
end on

on w_fa_co_selec_modelo_print.destroy
call super::destroy
destroy(this.cb_aceptar)
destroy(this.st_1)
destroy(this.cb_cancelar)
destroy(this.st_2)
destroy(this.sle_nom_ventana)
destroy(this.gb_1)
end on

event ue_post_open;/*carga los data windows */
sle_nom_ventana.text = this.classname()
this.y = 600
dw_1.settransObject(SQLCA)
If dw_1.retrieve() < 1 Then
	mensaje("Atención","No existen impresoras definidas para este Documento","")
	close(This)
	Return
End If
///********
If dw_1.rowcount() = 1 Then
	dw_1.setcolumn(1)
	dw_1.setfocus()
	dw_1.enabled = true
	wf_aceptar()
	close(This)
	Return
End if
//********
dw_1.setcolumn(1)
dw_1.setfocus()
dw_1.enabled = true
dw_1.ScrollTorow(1)
dw_1.SelectRow(1, true)


end event

event open;call super::open;wf_centrar()
end event

event resize;//Override
st_nom_ventana.y = newheight - (st_nom_ventana.height + 10)
dw_1.Resize(newwidth - 120, newheight - 185)
dw_1.x = 60
dw_1.Y = 50

cb_aceptar.y = newheight - (cb_aceptar.height + 10)
cb_aceptar.x = dw_1.x + dw_1.Width - (cb_aceptar.Width + 10 )
st_1.y = cb_aceptar.y -10
st_1.x = dw_1.x + dw_1.Width - (st_1.Width )

cb_cancelar.y = newheight - (cb_cancelar.height + 10)
cb_cancelar.x = dw_1.x + dw_1.Width - (cb_cancelar.Width + cb_aceptar.Width +50)
st_2.y = cb_cancelar.y -10
st_2.x = dw_1.x + dw_1.Width - (st_2.Width + st_1.Width + 30 )

gb_1.Width  = newwidth - 75
gb_1.Height = newheight - 120



end event

event close;if isvalid(this) then
	CloseWithReturn(this,str_fa_doctos)
End If

end event

event closequery;//Override
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_co_selec_modelo_print
int X=41
int Y=1092
int Height=76
boolean Visible=false
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_co_selec_modelo_print
event ue_post_change ( )
event ue_post_clicked ( )
event ue_set_column ( )
event ue_adicionar ( )
event ue_valida_existen ( )
event key pbm_keydown
int X=32
int Y=44
int Width=1755
int Height=444
int TabOrder=10
string DataObject="dw_ca_fa_selec_modelo_print"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event dw_1::key;//long ll_i
//
//If keyDown(KeyEnd!) and keyDown(KeyShift!) Then
//	FOR ll_i = il_old_row TO this.RowCount()
//		this.SelectRow(ll_i,true)
//	NEXT
//ElseIf keyDown(KeyHome!) and keyDown(KeyShift!) Then
//	FOR ll_i = il_old_row TO 1 STEP -1
//		this.SelectRow(ll_i,true)
//	NEXT
//ElseIf keyDown(KeyUpArrow!) and keyDown(KeyShift!) Then	 
//	this.SelectRow(This.GetRow() - 1,true)
//ElseIf keyDown(KeyDownArrow!) and keyDown(KeyShift!) Then	
//	this.SelectRow(This.GetRow() + 1,true)
//ElseIf keyDown(KeyUpArrow!)then
//	this.SelectRow(0,false)
//	this.SelectRow(This.GetRow() - 1, true)
//ElseIf keyDown(KeyDownArrow!)then
//	this.SelectRow(0,false)
//	this.SelectRow(This.GetRow() + 1, true)
//End If

end event

event dw_1::clicked;dw=this
//validaciones de las teclas

//If keyDown(keyControl!) Then  
//	If IsSelected(row) Then
//		this.SelectRow(row,false)
//	Else
//		this.SelectRow(row,true)
//	End if
//ElseIf keyDown(KeyShift!) Then
//	FOR ll_i = il_old_row TO row
//		this.SelectRow(ll_i,true)
//	NEXT
//Else
If keyDown(KeyLeftButton!) Then
	this.SelectRow(0,false)
	this.SelectRow(row,true)
End If
il_old_row = row

//***************  ***************  ***************//
//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto
integer li_pos 

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
end event

event dw_1::editchanged;If not IsValid(m_fa_principal) Then
	ChangeMenu(m_fa_principal)
End If
end event

event dw_1::doubleclicked;cb_aceptar.Postevent("clicked")
end event

type st_ayuda from w_fa_padre`st_ayuda within w_fa_co_selec_modelo_print
boolean BringToTop=true
end type

type cb_aceptar from commandbutton within w_fa_co_selec_modelo_print
int X=1179
int Y=508
int Width=265
int Height=72
int TabOrder=20
boolean BringToTop=true
string Text="Aceptar"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_aceptar()
end event

type st_1 from statictext within w_fa_co_selec_modelo_print
int X=1170
int Y=500
int Width=279
int Height=84
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancelar from commandbutton within w_fa_co_selec_modelo_print
int X=1472
int Y=508
int Width=265
int Height=72
int TabOrder=30
string Text="Cancelar"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;str_fa_doctos.aceptar = false
Parent.triggerevent("Close")

end event

type st_2 from statictext within w_fa_co_selec_modelo_print
int X=1463
int Y=500
int Width=279
int Height=84
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_nom_ventana from singlelineedit within w_fa_co_selec_modelo_print
int X=46
int Y=516
int Width=727
int Height=64
int TabOrder=40
boolean BringToTop=true
boolean Border=false
boolean AutoHScroll=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_fa_co_selec_modelo_print
int X=50
int Y=660
int Width=759
int Height=120
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

