//objectcomments Ventana ancestro maestro de detalle
forward
global type w_granpa_maest_det from Window
end type
type st_3 from statictext within w_granpa_maest_det
end type
type st_msg_row from statictext within w_granpa_maest_det
end type
type dw_2 from datawindow within w_granpa_maest_det
end type
type dw_1 from datawindow within w_granpa_maest_det
end type
type sle_con from singlelineedit within w_granpa_maest_det
end type
type ddplb_1 from dropdownpicturelistbox within w_granpa_maest_det
end type
type gb_2 from groupbox within w_granpa_maest_det
end type
type gb_1 from groupbox within w_granpa_maest_det
end type
end forward

global type w_granpa_maest_det from Window
int X=672
int Y=264
int Width=2729
int Height=1508
boolean TitleBar=true
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean Resizable=true
event ue_init pbm_custom01
event ue_print pbm_custom02
event ue_insertar pbm_custom03
event ue_eliminar pbm_custom04
event ue_primer_reg pbm_custom05
event ue_reg_anterior pbm_custom06
event ue_siguiente_reg pbm_custom07
event ue_ultimo_reg pbm_custom08
event ue_sort pbm_custom09
event ue_filter pbm_custom10
event ue_pre_aceptar pbm_custom11
event ue_close pbm_custom12
event ue_syscommand pbm_syscommand
event ue_find pbm_custom13
event ue_restaurar pbm_custom14
event ue_post_open pbm_custom15
event ue_aceptar pbm_custom16
event ue_pre_eliminar pbm_custom17
st_3 st_3
st_msg_row st_msg_row
dw_2 dw_2
dw_1 dw_1
sle_con sle_con
ddplb_1 ddplb_1
gb_2 gb_2
gb_1 gb_1
end type
global w_granpa_maest_det w_granpa_maest_det

type variables
PROTECTED:
Boolean   ib_cual_dw = true, ib_mouse_up = true, ib_no_borrar
Boolean  ib_left_right
String       is_db_name[], is_tipo[],  is_db_err
Integer     ii_ddlb_idx
Long il_x, il_y
end variables

forward prototypes
public function boolean wf_rb_down (integer m_id)
public subroutine wf_set_dw_current (boolean ab_dw)
public subroutine wf_find_detalle (long linea)
public function long wf_next_client ()
public subroutine wf_add_column ()
end prototypes

event ue_print;//OpenWithParm(w_dw_print_options, dw_1)
end event

event ue_insertar;Long ll_codigo
DataWindow	ldw_cual
Int li_msg
Boolean lb_dw_modify = false
dwItemStatus l_status


//------------
//Salvo en Maestro si se pretende insertar un nuevo cliente
//------------

dw_1.AcceptText()

l_status = dw_1.GetItemStatus(dw_1.GetRow(), dw_1.GetColumn(), Primary!)

IF (l_status <> NotModified! AND l_status <> New!) OR ((dw_1.ModifiedCount() + dw_1.DeletedCount()) > 0) THEN &
	lb_dw_modify = true


IF lb_dw_modify THEN 
	li_msg = MessageBox("Aviso " + This.Title, "¿Desea Salvar los Cambios Realizados en la Transacción?", Question!, YesNo!, 1)
	If li_msg = 1 Then
		This.TriggerEvent("ue_pre_aceptar")
		If message.doubleparm = -1 Then Return(1)
	Else
		Return(1)
	End If
END IF


//---------------
// Insersión
//---------------
dw_2.AcceptText()

//IF ib_cual_dw THEN
//	ldw_cual = dw_1 
//	dw_2.Reset()
//ELSE
//	If dw_1.RowCount() > 0 Then
//		ll_codigo = long(dw_1.GetItemString(dw_1.GetRow(), 1))
//		if Len(Trim(String(ll_codigo))) > 0 then
//			ldw_cual = dw_2
//		else
//			Return
//		end if
//	Else
//		Return
//	End If
//END IF
//
//ldw_cual.ScrollToRow(ldw_cual.InsertRow(0))
//ldw_cual.SetFocus()
//
//If ldw_cual = dw_1 Then
//	dw_1.SetItem(dw_1.GetRow(), 1, wf_next_client())
//ElseIf ldw_cual = dw_2 Then
//	dw_2.SetItem(dw_2.GetRow(), 1, ll_codigo)	
//End If
end event

event ue_eliminar;DataWindow	ldw_cual


If ib_cual_dw Then
	ldw_cual = dw_1
Else
	ldw_cual = dw_2
End If

//if ib_no_borrar and ldw_cual = dw_2 then 
////	ib_no_borrar = false
//	return
//end if
	
//ldw_cual.DeleteRow(0)

if ldw_cual.rowcount() > 0 then
	ldw_cual.deleterow(ldw_cual.getrow())
else 
	messagebox("Atención","No hay registros para borrar!")
end if
end event

event ue_primer_reg;DataWindow	ldw_cual


If ib_cual_dw Then
	ldw_cual = dw_1
Else
	ldw_cual = dw_2
End If

ldw_cual.ScrollToRow(1)
end event

event ue_reg_anterior;DataWindow	ldw_cual


If ib_cual_dw Then
	ldw_cual = dw_1
Else
	ldw_cual = dw_2
End If

ldw_cual.ScrollPriorRow()
end event

event ue_siguiente_reg;DataWindow	ldw_cual


If ib_cual_dw Then
	ldw_cual = dw_1
Else
	ldw_cual = dw_2
End If

ldw_cual.ScrollNextRow()
end event

event ue_ultimo_reg;DataWindow	ldw_cual


If ib_cual_dw Then
	ldw_cual = dw_1
Else
	ldw_cual = dw_2
End If

ldw_cual.ScrollToRow(dw_1.RowCount())
end event

event ue_sort;string	ls_o
DataWindow	ldw_cual


If ib_cual_dw Then
	ldw_cual = dw_1
Else
	ldw_cual = dw_2
End If

SetNull(ls_o)

ldw_cual.SetSort(ls_o)
ldw_cual.Sort()
end event

event ue_filter;string	ls_f
DataWindow	ldw_cual


If ib_cual_dw Then
	ldw_cual = dw_1
Else
	ldw_cual = dw_2
End If

SetNull(ls_f)

ldw_cual.SetFilter(ls_f)
ldw_cual.Filter()
end event

event ue_pre_aceptar;this.postevent("ue_aceptar")
yield()
end event

event ue_syscommand;If commandtype = 61536 Then
	Message.Processed = True
	Return 1
ElseIf commandtype = 4000 Then
	Open(w_acerca_de)
End If
end event

event ue_find;String	ls_filtro
Char		lc_type


dw_1.SetRedraw(false)

If Lower(Left(is_tipo[ii_ddlb_idx], 1)) = "c" Then
	ls_filtro = "Match(Upper(" + ddplb_1.text + "), '" + Upper(sle_con.text) + ")"
	lc_type = "c"
Else
	ls_filtro = "Match(string(" + ddplb_1.text + "), '" + sle_con.text + ")"
	lc_type = "n"
End If


If lc_type = "c" Then
	ls_filtro = Replace(ls_filtro, len(ls_filtro), 1, "+')")
Else
	ls_filtro = Replace(ls_filtro, len(ls_filtro), 1, "')")
End If
dw_1.SetFilter(ls_filtro)
dw_1.Filter()
dw_1.Sort()

dw_1.SetRedraw(true)
end event

event ue_restaurar;sle_con.text = ""
dw_1.SetFilter("")
dw_1.Filter()
end event

event ue_post_open;If dw_1.Retrieve() > 0 Then dw_2.Retrieve(dw_1.GetItemString(1, 1))

st_3.text = this.classname()
wf_add_column()
end event

event ue_aceptar;long ll_update_1,ll_update_2
//window lw_ventana
string ls_titulo

//lw_ventana = this.getactivesheet()
//ls_titulo = lw_ventana.title

ll_update_1=dw_1.update()
ll_update_2=dw_2.update()

if ll_update_1 = 1 and ll_update_2 = 1 then
	commit using sqlca;
else
	rollback using sqlca;
	mensaje("Atención","¡Error al Actualizar !", is_db_err)
end if
//dw_1.retrieve()
end event

event ue_pre_eliminar;this.postevent("ue_eliminar")
end event

public function boolean wf_rb_down (integer m_id);//menu m
//
//m = this.menuid.item[m_id]
//
//IF NOT IsValid (m) THEN
//	return(false)
//END IF
//
//PopMenu (m, w_grampa_frame.PointerX (), &
//	w_grampa_frame.PointerY ())
//
//return(true)

menu m

m = This.menuid.item[m_id]

IF NOT IsValid (m) THEN
	return(false)
END IF
//messagebox("",string(m))
PopMenu (m, str.frame.PointerX (), &
	str.frame.PointerY ())

return(true)
end function

public subroutine wf_set_dw_current (boolean ab_dw);Integer 		li_colcount_1, li_colcount_2, li_colcount_gray, li_colcount_normal, li_i
String  		ls_colname_1[], ls_colname_2[], ls_colname_gray[], ls_colname_normal[]
DataWindow	ldw_gray, ldw_normal


dw_1.SetRedraw(false)
dw_2.SetRedraw(false)

li_colcount_1 = Integer(dw_1.Describe("DataWindow.Column.Count"))
li_colcount_2 = Integer(dw_2.Describe("DataWindow.Column.Count"))

FOR li_i=1 TO li_colcount_1
	ls_colname_1[li_i] = dw_1.Describe("#" + string(li_i) + ".Name")
NEXT

FOR li_i=1 TO li_colcount_2
	ls_colname_2[li_i] = dw_2.Describe("#" + string(li_i) + ".Name")
NEXT

//////////////////////////////
If Not ab_dw Then
	ldw_gray = dw_1
	ls_colname_gray = ls_colname_1
	li_colcount_gray = li_colcount_1
	ldw_normal = dw_2
	ls_colname_normal = ls_colname_2
	li_colcount_normal = li_colcount_2
Else
	ldw_gray = dw_2
	ls_colname_gray = ls_colname_2
	li_colcount_gray = li_colcount_2
	ldw_normal = dw_1
	ls_colname_normal = ls_colname_1
	li_colcount_normal = li_colcount_1
End If


FOR li_i=1 TO li_colcount_normal
	ldw_normal.Modify(ls_colname_normal[li_i] + ".color=8388608)")
	ldw_normal.Modify(ls_colname_normal[li_i] + "_t.color=0)")
NEXT	

FOR li_i=1 TO li_colcount_gray
	ldw_gray.Modify(ls_colname_gray[li_i] + ".color=8421504)")
	ldw_gray.Modify(ls_colname_gray[li_i] + "_t.color=8421504)")
NEXT

ldw_normal.Modify("DataWindow.Color=10789024")//ventana activa silver 12632256
ldw_gray.Modify("DataWindow.Color=12632256")//ventana inactiva midle gray 10789024

dw_1.SetRedraw(true)
dw_2.SetRedraw(true)
end subroutine

public subroutine wf_find_detalle (long linea);//If linea < 1 Then Return
//
//
//Long	ll_cliente
//
//ll_cliente = dw_1.GetItemNumber(linea, 1)
//
//If ll_cliente > 0 Then
//	dw_2.Retrieve(ll_cliente)
//Else
//	dw_2.Reset()
//End If
end subroutine

public function long wf_next_client ();Long	ll_next_client
  
  
  SELECT max("cliente"."num_cliente")  + 1
    INTO :ll_next_client  
    FROM "cliente"  ;

Return ll_next_client
end function

public subroutine wf_add_column ();Integer	li_i, li_columnas


li_columnas = Integer(dw_1.Describe("DataWindow.Column.Count"))

FOR li_i=1 TO li_columnas
	ddplb_1.AddItem(Upper(dw_1.Describe("#"+ string(li_i) + ".Name")))
	is_db_name[li_i] = dw_1.Describe("#"+ string(li_i) + ".dbName")
	is_tipo[li_i] = dw_1.Describe("#"+ string(li_i) + ".ColType")
NEXT

end subroutine

event open;int li_Count

//gf_set_about()
This.Icon = str.icono

dw_1.SetTransObject(sqlca)
dw_2.SetTransObject(sqlca)

gf_acelerador()

this.triggerevent("ue_init")

dw_2.SetRowFocusIndicator(Hand!)

//wf_manito(ib_left_right,il_x,il_y)

this.postevent("ue_post_open")

end event

on w_granpa_maest_det.create
this.st_3=create st_3
this.st_msg_row=create st_msg_row
this.dw_2=create dw_2
this.dw_1=create dw_1
this.sle_con=create sle_con
this.ddplb_1=create ddplb_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.st_3,&
this.st_msg_row,&
this.dw_2,&
this.dw_1,&
this.sle_con,&
this.ddplb_1,&
this.gb_2,&
this.gb_1}
end on

on w_granpa_maest_det.destroy
destroy(this.st_3)
destroy(this.st_msg_row)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.sle_con)
destroy(this.ddplb_1)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event resize;dw_2.Height = newheight - (150 + dw_2.y)
st_3.y = newheight -60
end event

event mousemove;/*******************************************************************************************
*	System Name:	HARR2000
*								Sistema HARR2000
********************************************************************************************
*	
*	PROPOSITO:
*	 Esconde el statictext que muestra en que registro se encuentra al desplazarse
*	 por el DW
*	
*	OBJETO:						TIPO						NOMBRE						EVENTO
*									----						------						------
*								  Window			  			w_client_info				mousemove
*	
*	PARAMETROS:				 RECIBIDOS									ENVIADO
*								 ---------									-------
*							 	  xxxxxxx									xxxxxxxx
*
*	FUNCIONES UTILIZADAS:		NOMBRE					ARGUMENTO			RETORNO		PASADA POR
*										------					---------			-------		----------
*										xxxxxxxxx				xxxxx				 	xxxxxx			  X
*
*	
*	AUTOR:				Herick Guillén
*	------
*	DÍA DE CREACIÓN:	08 de Septiembre de 1998
*	----------------
********************************************************************************************
*	Modificaciones:
*	---------------
*	
*	
*	Fecha de la Modificación		Modificado por el Programador			Referencia
*	------------------------		-----------------------------			----------
*	
*	
********************************************************************************************
*					DERECHO DE AUTOR (c) 1998	HARR, S.A.									 
*******************************************************************************************/

If ib_mouse_up Or st_msg_row.visible Then st_msg_row.hide()
end event

event closequery;Int li_msg
Boolean lb_dw_modify = false
dwItemStatus l_status_1, l_status_2


dw_1.AcceptText()
dw_2.AcceptText()

l_status_1 = dw_1.GetItemStatus(dw_1.GetRow(), dw_1.GetColumn(), Primary!)
l_status_2 = dw_2.GetItemStatus(dw_2.GetRow(), dw_2.GetColumn(), Primary!)

IF (l_status_1 <> NotModified! AND l_status_1 <> New!) OR ((dw_1.ModifiedCount() + dw_1.DeletedCount()) > 0) THEN &
	lb_dw_modify = true
	
IF (l_status_2 <> NotModified! AND l_status_2 <> New!) OR ((dw_2.ModifiedCount() + dw_2.DeletedCount()) > 0) THEN &
	lb_dw_modify = true


IF lb_dw_modify THEN 
	li_msg = MessageBox("Aviso " + This.Title, "¿Desea Salvar los Cambios Realizados?", Question!, yesnocancel!, 1)
	If li_msg = 1 Then
		This.TriggerEvent("ue_aceptar")
		If Len(Trim(is_db_err)) > 0 Then	Return
	ElseIf li_msg = 3 Then
		Return(1)
	End If
END IF

Close(this)

end event

type st_3 from statictext within w_granpa_maest_det
int X=55
int Y=1308
int Width=837
int Height=76
boolean Enabled=false
string Text="none"
boolean FocusRectangle=false
long BackColor=12632256
long BorderColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_msg_row from statictext within w_granpa_maest_det
int X=2683
int Y=192
int Width=274
int Height=76
boolean Visible=false
boolean Enabled=false
boolean Border=true
boolean FocusRectangle=false
long BackColor=15793151
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_2 from datawindow within w_granpa_maest_det
event micro pbm_nchittest
int X=46
int Y=836
int Width=2592
int Height=416
int TabOrder=60
string DragIcon="Application!"
string DataObject="dw_ma_ba_subtransprueba"
boolean Border=false
boolean VScrollBar=true
boolean LiveScroll=true
end type

event micro;If ib_mouse_up Or st_msg_row.visible Then st_msg_row.hide()
end event

event rbuttondown;if Not wf_rb_down(2) then
	messagebox("Error","Al presionar el Boton Derecho del Ratón",Exclamation!)
	Return
end if

ib_cual_dw = false
wf_set_dw_current(ib_cual_dw)
end event

event dberror;If sqldbcode <> 0 Then
	is_db_err = "Error Texto~t" + sqlerrtext + &
					"~r~n~nLinea~t" + string(row)
	Return(1)
End If


end event

event clicked;ib_cual_dw = false
wf_set_dw_current(ib_cual_dw)
end event

event doubleclicked;ib_cual_dw = false
wf_set_dw_current(ib_cual_dw)
end event

event getfocus;ib_cual_dw = false
wf_set_dw_current(ib_cual_dw)
end event

type dw_1 from datawindow within w_granpa_maest_det
event lbuttondown pbm_lbuttondown
event lbuttonup pbm_lbuttonup
event mouse_move pbm_dwnmousemove
event ue_post pbm_custom01
event micro pbm_nchittest
int X=55
int Y=60
int Width=2592
int Height=684
int TabOrder=40
string DragIcon="Application!"
boolean Border=false
boolean VScrollBar=true
boolean LiveScroll=true
end type

event lbuttondown;ib_mouse_up = false
end event

event lbuttonup;ib_mouse_up = true
end event

event ue_post;dw_2.SetRedraw(False)
dw_2.Reset()
wf_find_detalle(This.GetRow())
dw_2.SetRedraw(True)
end event

event micro;If ib_mouse_up Or st_msg_row.visible Then st_msg_row.hide()
end event

event dberror;If sqldbcode <> 0 Then
	is_db_err = "Error Texto~t" + sqlerrtext + &
					"~r~n~nLinea ~t" + string(row)
	Return(1)
End If

				

end event

event rbuttondown;if Not wf_rb_down(2) then
	messagebox("Error","Al presionar el Boton Derecho del Ratón",Exclamation!)
	Return
end if

ib_cual_dw = true
wf_set_dw_current(ib_cual_dw)

This.PostEvent("ue_post")

end event

event clicked;ib_cual_dw = true
wf_set_dw_current(ib_cual_dw)

This.PostEvent("ue_post")
end event

event doubleclicked;ib_cual_dw = true
wf_set_dw_current(ib_cual_dw)

This.PostEvent("ue_post")
end event

event getfocus;ib_cual_dw = true
wf_set_dw_current(ib_cual_dw)

This.PostEvent("ue_post")
end event

event rowfocuschanged;ib_cual_dw = true
wf_set_dw_current(ib_cual_dw)

This.PostEvent("ue_post")
end event

event scrollvertical;Long posicion


posicion = truncate(scrollpos/804,0)

st_msg_row.text = " Linea " + string(posicion + 1)

st_msg_row.width = len(st_msg_row.text) * 30
st_msg_row.BringToTop = True

st_msg_row.x = this.width - st_msg_row.width

If parent.PointerY() > (this.y + this.height) Then
	st_msg_row.y = (this.y + this.height) - st_msg_row.width
ElseIf parent.PointerY() < this.y Then
	st_msg_row.y = this.y
Else
	st_msg_row.y = parent.PointerY()
End If

st_msg_row.visible = true
end event

type sle_con from singlelineedit within w_granpa_maest_det
event ue_post_modify pbm_custom01
event ue_keydown pbm_keydown
int X=2711
int Y=336
int Width=731
int Height=92
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=8388608
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_post_modify;If Len(Trim(this.text)) > 0 Then
	Parent.TriggerEvent("ue_find")
Else
	Parent.TriggerEvent("ue_restaurar")
End If
end event

event ue_keydown;This.PostEvent("ue_post_modify")
end event

type ddplb_1 from dropdownpicturelistbox within w_granpa_maest_det
event selectionchanged pbm_cbnselchange
int X=2706
int Y=68
int Width=731
int Height=356
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=true
boolean VScrollBar=true
long TextColor=8388608
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string PictureName[]={"Search!"}
long PictureMaskColor=536870912
end type

event selectionchanged;ii_ddlb_idx = index
end event

type gb_2 from groupbox within w_granpa_maest_det
int X=18
int Y=784
int Width=2638
int Height=492
int TabOrder=50
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_granpa_maest_det
int X=27
int Y=12
int Width=2638
int Height=764
int TabOrder=10
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

