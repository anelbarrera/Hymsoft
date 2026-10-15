//objectcomments (D)permite colocar el nombre de la configuracion a salvar
forward
global type w_fa_salvar_config from w_fa_padre
end type
type sle_1 from singlelineedit within w_fa_salvar_config
end type
type st_1 from statictext within w_fa_salvar_config
end type
type sle_2 from singlelineedit within w_fa_salvar_config
end type
type st_2 from statictext within w_fa_salvar_config
end type
type uo_guardar from uo_fa_boton within w_fa_salvar_config
end type
type uo_cancelar from uo_fa_boton within w_fa_salvar_config
end type
type gb_1 from groupbox within w_fa_salvar_config
end type
type st_cancelar from statictext within w_fa_salvar_config
end type
type st_guardar from statictext within w_fa_salvar_config
end type
type ln_1 from line within w_fa_salvar_config
end type
type ln_2 from line within w_fa_salvar_config
end type
type ln_3 from line within w_fa_salvar_config
end type
type ln_4 from line within w_fa_salvar_config
end type
end forward

global type w_fa_salvar_config from w_fa_padre
int Width=1563
int Height=844
WindowType WindowType=response!
boolean TitleBar=true
string Title="(IN) Guardar Información"
boolean ControlMenu=false
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
sle_1 sle_1
st_1 st_1
sle_2 sle_2
st_2 st_2
uo_guardar uo_guardar
uo_cancelar uo_cancelar
gb_1 gb_1
st_cancelar st_cancelar
st_guardar st_guardar
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
ln_4 ln_4
end type
global w_fa_salvar_config w_fa_salvar_config

type variables
str_fa_informe str_inf
end variables

on w_fa_salvar_config.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
this.sle_2=create sle_2
this.st_2=create st_2
this.uo_guardar=create uo_guardar
this.uo_cancelar=create uo_cancelar
this.gb_1=create gb_1
this.st_cancelar=create st_cancelar
this.st_guardar=create st_guardar
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.ln_4=create ln_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.sle_2
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.uo_guardar
this.Control[iCurrent+6]=this.uo_cancelar
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.st_cancelar
this.Control[iCurrent+9]=this.st_guardar
this.Control[iCurrent+10]=this.ln_1
this.Control[iCurrent+11]=this.ln_2
this.Control[iCurrent+12]=this.ln_3
this.Control[iCurrent+13]=this.ln_4
end on

on w_fa_salvar_config.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.sle_2)
destroy(this.st_2)
destroy(this.uo_guardar)
destroy(this.uo_cancelar)
destroy(this.gb_1)
destroy(this.st_cancelar)
destroy(this.st_guardar)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
destroy(this.ln_4)
end on

event open;call super::open;This.uo_cancelar.Dynamic  of_setpicture(str.path +  "art\dba_cancel.bmp")
This.uo_guardar.    Dynamic  of_setpicture(str.path + "imagenes\inventario\disks03.bmp")

end event

event close;//override
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_salvar_config
int X=50
int Y=620
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_salvar_config
int TabOrder=50
boolean Visible=false
end type

type st_ayuda from w_fa_padre`st_ayuda within w_fa_salvar_config
boolean BringToTop=true
end type

type sle_1 from singlelineedit within w_fa_salvar_config
int X=512
int Y=292
int Width=567
int Height=84
int TabOrder=10
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
int Limit=20
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_fa_salvar_config
int X=146
int Y=304
int Width=361
int Height=72
boolean Enabled=false
boolean BringToTop=true
string Text="Código Registro:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_2 from singlelineedit within w_fa_salvar_config
int X=512
int Y=400
int Width=905
int Height=84
int TabOrder=20
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
int Limit=50
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_fa_salvar_config
int X=233
int Y=416
int Width=274
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Descripción:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_guardar from uo_fa_boton within w_fa_salvar_config
event ue_micro_help pbm_nchittest
int X=73
int Y=48
int TabOrder=30
boolean BringToTop=true
long BackColor=79741120
end type

event ue_micro_help;st_cancelar.Visible = False
st_guardar.Visible = True
end event

on uo_guardar.destroy
call uo_fa_boton::destroy
end on

event ue_clicked;If sle_1.Text = "" Then
	MessageBox('Aviso','Introduzca el Código del Reporte',StopSign!)
	Return
Else
	str_inf.codigo_reporte = sle_1.Text
	str_inf.descripcion_reporte = sle_2.Text
	CloseWithReturn(Parent,str_inf)
End If

end event

type uo_cancelar from uo_fa_boton within w_fa_salvar_config
event ue_micro_help pbm_nchittest
int X=297
int Y=48
int TabOrder=40
boolean BringToTop=true
long BackColor=79741120
end type

event ue_micro_help;st_cancelar.Visible = True
st_guardar.Visible = False
end event

on uo_cancelar.destroy
call uo_fa_boton::destroy
end on

event ue_clicked;str_inf.codigo_reporte = ""
	str_inf.descripcion_reporte = ""
CloseWithReturn(Parent,str_inf)
end event

type gb_1 from groupbox within w_fa_salvar_config
int X=55
int Y=4
int Width=494
int Height=180
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_cancelar from statictext within w_fa_salvar_config
int X=384
int Y=172
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

type st_guardar from statictext within w_fa_salvar_config
int X=78
int Y=172
int Width=247
int Height=60
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
string Text="Guardar"
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

type ln_1 from line within w_fa_salvar_config
boolean Enabled=false
int BeginX=59
int BeginY=224
int EndX=1504
int EndY=224
int LineThickness=4
long LineColor=8421504
end type

type ln_2 from line within w_fa_salvar_config
boolean Enabled=false
int BeginX=59
int BeginY=224
int EndX=59
int EndY=548
int LineThickness=4
long LineColor=8421504
end type

type ln_3 from line within w_fa_salvar_config
boolean Enabled=false
int BeginX=64
int BeginY=544
int EndX=1499
int EndY=544
int LineThickness=4
long LineColor=16777215
end type

type ln_4 from line within w_fa_salvar_config
boolean Enabled=false
int BeginX=1499
int BeginY=224
int EndX=1499
int EndY=548
int LineThickness=4
long LineColor=16777215
end type

