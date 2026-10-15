//objectcomments (D)para abrir la configuracion de un registro creado para generar
forward
global type w_fa_abrir_informe from w_fa_padre
end type
type gb_1 from groupbox within w_fa_abrir_informe
end type
type sle_1 from singlelineedit within w_fa_abrir_informe
end type
type st_1 from statictext within w_fa_abrir_informe
end type
type uo_deleted from uo_fa_boton within w_fa_abrir_informe
end type
type uo_aceptar from uo_fa_boton within w_fa_abrir_informe
end type
type uo_cancelar from uo_fa_boton within w_fa_abrir_informe
end type
type st_eliminar from statictext within w_fa_abrir_informe
end type
type st_aceptar from statictext within w_fa_abrir_informe
end type
type st_cancelar from statictext within w_fa_abrir_informe
end type
end forward

global type w_fa_abrir_informe from w_fa_padre
int Width=2153
int Height=1460
WindowType WindowType=response!
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event ue_micro_ayuda pbm_nchittest
gb_1 gb_1
sle_1 sle_1
st_1 st_1
uo_deleted uo_deleted
uo_aceptar uo_aceptar
uo_cancelar uo_cancelar
st_eliminar st_eliminar
st_aceptar st_aceptar
st_cancelar st_cancelar
end type
global w_fa_abrir_informe w_fa_abrir_informe

type variables
string is_codigo
str_fa_informe str_informe
end variables

event ue_micro_ayuda;st_aceptar.Visible  = False
st_cancelar.Visible = False
st_eliminar.Visible = False
end event

on w_fa_abrir_informe.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.sle_1=create sle_1
this.st_1=create st_1
this.uo_deleted=create uo_deleted
this.uo_aceptar=create uo_aceptar
this.uo_cancelar=create uo_cancelar
this.st_eliminar=create st_eliminar
this.st_aceptar=create st_aceptar
this.st_cancelar=create st_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.uo_deleted
this.Control[iCurrent+5]=this.uo_aceptar
this.Control[iCurrent+6]=this.uo_cancelar
this.Control[iCurrent+7]=this.st_eliminar
this.Control[iCurrent+8]=this.st_aceptar
this.Control[iCurrent+9]=this.st_cancelar
end on

on w_fa_abrir_informe.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.uo_deleted)
destroy(this.uo_aceptar)
destroy(this.uo_cancelar)
destroy(this.st_eliminar)
destroy(this.st_aceptar)
destroy(this.st_cancelar)
end on

event open;call super::open;String ls_titulo
str_informe = Message.PowerObjectParm
This.Title = str_informe.titulo_ventana

This.uo_cancelar. Dynamic  of_setpicture(str.path + "art\dba_cancel.bmp")
This.uo_aceptar.  Dynamic  of_setpicture(str.path + "art\acept_inab.bmp")
This.uo_deleted.  Dynamic  of_setpicture(str.path + "imagenes\inventario\clear.bmp")
This.uo_aceptar.Enabled = False




end event

event ue_post_open;is_nombre = This.ClassName()
gf_win_used_by_user(is_nombre, true)
st_nom_ventana.text = is_nombre
this.visible=true



dw_1.SetTransObject(SQLCA)
dw_1.Retrieve(str.g_financiero,str.empresa,str_informe.opcion_menu)
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_abrir_informe
int X=59
int Y=1268
int Width=823
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_abrir_informe
int X=69
int Y=404
int Width=2007
int Height=804
int TabOrder=50
string DataObject="dw_ma_fa_abrir_informe"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

event dw_1::clicked;call super::clicked;dw = dw_1
/* Marca la linea selecionada con un color azul */
dw.SelectRow(0,False)
dw.SelectRow(dw.GetRow(),true)

dw.AcceptText()
Long ll_selected
ll_selected = dw.GetSelectedRow(0)
sle_1.Text  = dw.GetItemString(ll_selected,'repo_cod_reporte')
is_codigo   = dw.GetItemString(ll_selected,'repo_cod_reporte')
Parent.uo_aceptar.  Dynamic  of_setpicture(str.path + "art\dba_acept.bmp")
Parent.uo_aceptar.Enabled = True
end event

event dw_1::doubleclicked;dw = dw_1
/* Marca la linea selecionada con un color azul */
dw.SelectRow(0,False)
dw.SelectRow(dw.GetRow(),true)

dw.AcceptText()
Long ll_selected
ll_selected = dw.GetSelectedRow(0)
sle_1.Text  = dw.GetItemString(ll_selected,'repo_cod_reporte')
is_codigo   = dw.GetItemString(dw.GetRow(),'repo_cod_reporte')
Parent.uo_aceptar.  Dynamic  of_setpicture(str.path + "art\dba_acept.bmp")
Parent.uo_aceptar.Enabled = True
CloseWithReturn(Parent,is_codigo)
end event

type st_ayuda from w_fa_padre`st_ayuda within w_fa_abrir_informe
boolean BringToTop=true
end type

type gb_1 from groupbox within w_fa_abrir_informe
int X=41
int Y=352
int Width=2057
int Height=880
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

type sle_1 from singlelineedit within w_fa_abrir_informe
int X=261
int Y=264
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

event modified;is_codigo   = sle_1.Text
Parent.uo_aceptar.  Dynamic  of_setpicture(str.path + "art\dba_acept.bmp")
Parent.uo_aceptar.Enabled = True
end event

type st_1 from statictext within w_fa_abrir_informe
int X=46
int Y=272
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

type uo_deleted from uo_fa_boton within w_fa_abrir_informe
event ue_micro_help pbm_nchittest
int X=530
int Y=76
int TabOrder=20
boolean BringToTop=true
long BackColor=79741120
end type

event ue_micro_help;st_aceptar.Visible  = False
st_cancelar.Visible = False
st_eliminar.Visible = True
end event

on uo_deleted.destroy
call uo_fa_boton::destroy
end on

event ue_clicked;Long ll_resp
is_codigo = sle_1.Text
ll_resp = MessageBox('Question','¿Esta Seguro de Eliminar el Registro?',Question!,YesNo!,1)
If ll_resp = 1 Then
	dw_1.SetRedraw(False)
	dw_1.Hide()
	  DELETE FROM inreport  
     WHERE ( inreport.repo_grupo_financiero =:str.g_financiero ) AND  
           ( inreport.repo_empresa =:str.empresa ) AND  
           ( inreport.repo_cod_reporte =:is_codigo )   ;
			  
	dw_1.Reset()
	dw_1.Retrieve(str.g_financiero, str.empresa)
	dw_1.Show()
	dw_1.SetRedraw(True)
Else
	Return
End If


end event

type uo_aceptar from uo_fa_boton within w_fa_abrir_informe
event ue_micro_help pbm_nchittest
int X=73
int Y=76
int TabOrder=30
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

event ue_micro_help;st_aceptar.Visible  = True
st_cancelar.Visible = False
st_eliminar.Visible = False
end event

on uo_aceptar.destroy
call uo_fa_boton::destroy
end on

event ue_clicked;str.frame.SetRedraw(False)

is_codigo = sle_1.Text

CloseWithReturn(Parent,is_codigo)

str.frame.SetRedraw(True)

end event

type uo_cancelar from uo_fa_boton within w_fa_abrir_informe
event ue_micro_ayuda pbm_nchittest
int X=302
int Y=76
int TabOrder=40
boolean BringToTop=true
long BackColor=79741120
end type

event ue_micro_ayuda;st_aceptar.Visible = False
st_cancelar.Visible = True
st_eliminar.Visible = False
end event

on uo_cancelar.destroy
call uo_fa_boton::destroy
end on

event ue_clicked;str.frame.SetRedraw(False)
CloseWithReturn(Parent,"")
str.frame.SetRedraw(True)
end event

type st_eliminar from statictext within w_fa_abrir_informe
int X=78
int Y=196
int Width=229
int Height=60
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
string Text="Eliminar"
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

type st_aceptar from statictext within w_fa_abrir_informe
int X=306
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

type st_cancelar from statictext within w_fa_abrir_informe
int X=535
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

