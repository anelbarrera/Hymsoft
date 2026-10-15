//objectcomments Para los subgrupos, divisiones, etc
forward
global type w_fa_clasif_infor_cod from w_fa_padre
end type
type gb_1 from groupbox within w_fa_clasif_infor_cod
end type
type sle_1 from singlelineedit within w_fa_clasif_infor_cod
end type
type st_1 from statictext within w_fa_clasif_infor_cod
end type
type uo_aceptar from uo_fa_boton within w_fa_clasif_infor_cod
end type
type uo_cancelar from uo_fa_boton within w_fa_clasif_infor_cod
end type
type st_aceptar from statictext within w_fa_clasif_infor_cod
end type
type st_cancelar from statictext within w_fa_clasif_infor_cod
end type
end forward

global type w_fa_clasif_infor_cod from w_fa_padre
int Width=1454
int Height=1360
WindowType WindowType=response!
boolean ControlMenu=false
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event ue_micro_ayuda pbm_nchittest
gb_1 gb_1
sle_1 sle_1
st_1 st_1
uo_aceptar uo_aceptar
uo_cancelar uo_cancelar
st_aceptar st_aceptar
st_cancelar st_cancelar
end type
global w_fa_clasif_infor_cod w_fa_clasif_infor_cod

type variables
string is_codigo
str_fa_informe str_datos
Integer ii_clase
end variables

event ue_micro_ayuda;st_aceptar.Visible  = False
st_cancelar.Visible = False

end event

on w_fa_clasif_infor_cod.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.sle_1=create sle_1
this.st_1=create st_1
this.uo_aceptar=create uo_aceptar
this.uo_cancelar=create uo_cancelar
this.st_aceptar=create st_aceptar
this.st_cancelar=create st_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.uo_aceptar
this.Control[iCurrent+5]=this.uo_cancelar
this.Control[iCurrent+6]=this.st_aceptar
this.Control[iCurrent+7]=this.st_cancelar
end on

on w_fa_clasif_infor_cod.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.uo_aceptar)
destroy(this.uo_cancelar)
destroy(this.st_aceptar)
destroy(this.st_cancelar)
end on

event open;call super::open;String	ls_titulo

str_datos = Message.PowerObjectParm

This.Title = str_datos.titulo_ventana

This.uo_cancelar. Dynamic  of_setpicture(str.path + "art\dba_cancel.bmp")
This.uo_aceptar.  Dynamic  of_setpicture(str.path + "art\acept_inab.bmp")
This.uo_aceptar.Enabled = False

end event

event ue_post_open;// Modificado por Gianni Araúz (03/02/2000)
// Ahora se pregunta por la opción del menú. Si es el reporte de Marca y Sub-Marca, entonces
// se pregunta si cambió la leyenda de DIVISIÓN a MARCA o de GRUPO a SUB-MARCA.

is_nombre = This.ClassName()
gf_win_used_by_user(is_nombre,true)
st_nom_ventana.text = is_nombre

this.visible=true

//if str_datos.opcion_menu = 'RMS' then
//	if str_datos.fecha_periodo = 'MS' then
//		if str_datos.cod_encabezado = 'M A R C A' then
//			dw_1.DataObject = 'dw_dd_fa_c_costos'
//			ii_clase = 1
//		elseif str_datos.cod_encabezado = 'S U B - M A R C A' then
//			dw_1.DataObject = 'dw_dd_fa_grupo'
//			ii_clase = 2
//		end if
//	elseif str_datos.fecha_periodo = 'DG' then
//		If str_datos.cod_encabezado = 'D I V I S I Ó N' Then
//			dw_1.DataObject = 'dw_dd_fa_c_costos'
//			ii_clase = 1
//		ElseIf str_datos.cod_encabezado = 'G R U P O' Then
//			dw_1.DataObject = 'dw_dd_fa_grupo'
//			ii_clase = 2
//		ElseIf str_datos.cod_encabezado = 'S U B_G R U P O' Then
//			dw_1.DataObject = 'dw_dd_fa_sub_grupo'
//			ii_clase = 3
//		ElseIf str_datos.cod_encabezado = 'C L A S E / L Í N E A' Then
//			dw_1.DataObject = 'dw_dd_fa_clase'
//			ii_clase = 4
//		ElseIf str_datos.cod_encabezado = 'M A R C A' Then
//			dw_1.DataObject = 'dw_dd_fa_marca'
//			ii_clase = 5
//		End If
//	end if
//else
	If str_datos.cod_encabezado = 'D I V I S I Ó N' Then
		dw_1.DataObject = 'dw_dd_fa_c_costos'
		ii_clase = 1
	ElseIf str_datos.cod_encabezado = 'G R U P O' Then
		dw_1.DataObject = 'dw_dd_fa_grupo_prod'
		ii_clase = 2
	ElseIf str_datos.cod_encabezado = 'S U B_G R U P O' Then
		dw_1.DataObject = 'dw_dd_fa_sub_grupo'
		ii_clase = 3
	ElseIf str_datos.cod_encabezado = 'C L A S E / L Í N E A' Then
		dw_1.DataObject = 'dw_dd_fa_clase_prod'
		ii_clase = 4
	ElseIf str_datos.cod_encabezado = 'M A R C A' Then
		dw_1.DataObject = 'dw_dd_fa_marca'
		ii_clase = 5
	End If
//end if

dw_1.SetTransObject(sqlca)

dw_1.Retrieve(str.g_financiero,str.empresa)

end event

event close;//override
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_clasif_infor_cod
int X=37
int Y=1200
int Width=910
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_clasif_infor_cod
int X=69
int Y=424
int Width=1298
int Height=732
int TabOrder=40
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

event dw_1::clicked;call super::clicked;long	ll_selected

dw = dw_1

if row < 1 then return

/* Marca la línea seleccionada con un color azul */
dw.SelectRow(0,False)
dw.SelectRow(row,true)

//dw.AcceptText()
ll_selected = dw.GetSelectedRow(0)

If ii_clase = 1 Then
	sle_1.Text  = dw.GetItemString(ll_selected,'adiv_codigo_div')
   str_datos.cod_tipo   = dw.GetItemString(ll_selected,'adiv_codigo_div')
ElseIf ii_clase = 2 Then
	sle_1.Text  = dw.GetItemString(ll_selected,'agru_codigo_grupo')
   str_datos.cod_tipo   = dw.GetItemString(ll_selected,'agru_codigo_grupo')
ElseIf ii_clase = 3 Then
	sle_1.Text  = dw.GetItemString(ll_selected,'asub_codigo_subgrupo')
   str_datos.cod_tipo   = dw.GetItemString(ll_selected,'asub_codigo_subgrupo')	
ElseIf ii_clase = 4 Then
	sle_1.Text  = dw.GetItemString(ll_selected,'alin_codigo_linea')
   str_datos.cod_tipo   = dw.GetItemString(ll_selected,'alin_codigo_linea')	
ElseIf ii_clase = 5 Then
	sle_1.Text  = dw.GetItemString(ll_selected,'amar_num_marca')
   str_datos.cod_tipo   = dw.GetItemString(ll_selected,'amar_num_marca')
End If

Parent.uo_aceptar.Dynamic of_setpicture(str.path + "art\dba_acept.bmp")
Parent.uo_aceptar.Enabled = True

end event

event dw_1::doubleclicked;Long	ll_selected

dw = dw_1

/* Marca la linea selecionada con un color azul */
dw.SelectRow(0,False)
dw.SelectRow(dw.GetRow(),true)

dw.AcceptText()
ll_selected = dw.GetSelectedRow(0)

If ii_clase = 1 Then
	sle_1.Text  = dw.GetItemString(ll_selected,'adiv_codigo_div')
   str_datos.cod_tipo   = dw.GetItemString(ll_selected,'adiv_codigo_div')
ElseIf ii_clase = 2 Then
	sle_1.Text  = dw.GetItemString(ll_selected,'agru_codigo_grupo')
   str_datos.cod_tipo   = dw.GetItemString(ll_selected,'agru_codigo_grupo')
ElseIf ii_clase = 3 Then
	sle_1.Text  = dw.GetItemString(ll_selected,'asub_codigo_subgrupo')
   str_datos.cod_tipo   = dw.GetItemString(ll_selected,'asub_codigo_subgrupo')	
ElseIf ii_clase = 4 Then
	sle_1.Text  = dw.GetItemString(ll_selected,'alin_codigo_linea')
   str_datos.cod_tipo   = dw.GetItemString(ll_selected,'alin_codigo_linea')	
ElseIf ii_clase = 5 Then
	sle_1.Text  = dw.GetItemString(ll_selected,'amar_num_marca')
   str_datos.cod_tipo   = dw.GetItemString(ll_selected,'amar_num_marca')
End If

Parent.uo_aceptar.Dynamic  of_setpicture(str.path + "art\dba_acept.bmp")
Parent.uo_aceptar.Enabled = True

CloseWithReturn(Parent,str_datos)

end event

type st_ayuda from w_fa_padre`st_ayuda within w_fa_clasif_infor_cod
boolean BringToTop=true
end type

type gb_1 from groupbox within w_fa_clasif_infor_cod
int X=41
int Y=368
int Width=1349
int Height=808
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_fa_clasif_infor_cod
int X=261
int Y=280
int Width=795
int Height=80
int TabOrder=10
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;str_datos.cod_tipo = sle_1.Text

Parent.uo_aceptar.Dynamic of_setpicture(str.path + "art\dba_acept.bmp")
Parent.uo_aceptar.Enabled = True

end event

type st_1 from statictext within w_fa_clasif_infor_cod
int X=46
int Y=288
int Width=206
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Código:"
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

type uo_aceptar from uo_fa_boton within w_fa_clasif_infor_cod
event ue_micro_help pbm_nchittest
int X=78
int Y=76
int TabOrder=20
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

event ue_micro_help;st_aceptar.Visible  = True
st_cancelar.Visible = False

end event

on uo_aceptar.destroy
call uo_fa_boton::destroy
end on

event ue_clicked;str_datos.cod_tipo = sle_1.Text

str.frame.SetRedraw(False)

CloseWithReturn(Parent,str_datos)

str.frame.SetRedraw(True)

end event

type uo_cancelar from uo_fa_boton within w_fa_clasif_infor_cod
event ue_micro_ayuda pbm_nchittest
int X=306
int Y=76
int TabOrder=30
boolean BringToTop=true
long BackColor=79741120
end type

event ue_micro_ayuda;st_aceptar.Visible = False
st_cancelar.Visible = True

end event

on uo_cancelar.destroy
call uo_fa_boton::destroy
end on

event ue_clicked;str_datos.cod_tipo = ''

str.frame.SetRedraw(False)

CloseWithReturn(Parent,str_datos)

str.frame.SetRedraw(True)

end event

type st_aceptar from statictext within w_fa_clasif_infor_cod
int X=78
int Y=196
int Width=229
int Height=60
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
string Text="Aceptar"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=15793151
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_cancelar from statictext within w_fa_clasif_infor_cod
int X=311
int Y=196
int Width=247
int Height=60
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
string Text="Cancelar"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=15793151
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

