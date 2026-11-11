//objectcomments Ventana que muestra el datwindow donde selecciono la secuencia de la caja en la que voy a imprimir
forward
global type w_fa_man_fac_sec from Window
end type
type st_nom_ventana from statictext within w_fa_man_fac_sec
end type
type dw_1 from datawindow within w_fa_man_fac_sec
end type
type gb_1 from groupbox within w_fa_man_fac_sec
end type
type st_1 from statictext within w_fa_man_fac_sec
end type
end forward

global type w_fa_man_fac_sec from Window
int X=654
int Y=364
int Width=2377
int Height=648
boolean TitleBar=true
string Title="Secuencias Por Impresora (Cajas)"
long BackColor=79416533
boolean ControlMenu=true
WindowType WindowType=response!
st_nom_ventana st_nom_ventana
dw_1 dw_1
gb_1 gb_1
st_1 st_1
end type
global w_fa_man_fac_sec w_fa_man_fac_sec

type variables
string is_secuencia
end variables

on w_fa_man_fac_sec.create
this.st_nom_ventana=create st_nom_ventana
this.dw_1=create dw_1
this.gb_1=create gb_1
this.st_1=create st_1
this.Control[]={this.st_nom_ventana,&
this.dw_1,&
this.gb_1,&
this.st_1}
end on

on w_fa_man_fac_sec.destroy
destroy(this.st_nom_ventana)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.st_1)
end on

event open;string ls_parametro, ls_original, ls_where
//Recibe el parametro enviado desde la ventana de impresion de facturas
ls_parametro = message.StringParm

//Nombre de la ventana
st_nom_ventana.text = this.classname()

dw_1.settransobject(sqlca)			//Asigna el objeto transaccion

ls_original = GetSqlSelect(dw_1)

if ls_parametro = "PY" then		//Factura Al por mayor

   ls_where = ls_original+ "WHERE ( famcajap.faca_g_financiero = "+string(str.g_financiero)+") AND &
									( famcajap.faca_empresa = "+string(str.empresa )+") AND (famcajap.faca_venta = 'PY')" 

else

	ls_where = ls_original+ "WHERE ( famcajap.faca_g_financiero = "+string(str.g_financiero)+") AND &
									( famcajap.faca_empresa = "+string(str.empresa)+") AND (famcajap.faca_venta = 'PM')"	
end if

dw_1.SetSqlSelect(ls_where)

dw_1.retrieve()	//Recupera los datos o las impresoras de las cajas

// Para que se posicione en el campo de numero de proforma

dw_1.setfocus()
dw_1.setcolumn(3)
end event

event close;CloseWithReturn(this,is_secuencia)
end event

type st_nom_ventana from statictext within w_fa_man_fac_sec
int X=69
int Y=468
int Width=1015
int Height=76
boolean Enabled=false
string Text="Nom_ventana"
boolean FocusRectangle=false
long BackColor=79416533
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within w_fa_man_fac_sec
event ue_enter pbm_dwnprocessenter
int X=160
int Y=108
int Width=2080
int Height=268
int TabOrder=20
boolean BringToTop=true
string DataObject="dw_ma_fa_impresoras_sec"
boolean Border=false
boolean VScrollBar=true
boolean LiveScroll=true
end type

event ue_enter;is_secuencia = dw_1.getitemstring(dw_1.getrow(),"faca_secuencia")
close(parent)
end event

event doubleclicked;is_secuencia = dw_1.getitemstring(dw_1.getrow(),"faca_secuencia")
close(parent)
end event

type gb_1 from groupbox within w_fa_man_fac_sec
int X=27
int Y=28
int Width=2299
int Height=416
int TabOrder=10
string Text="Seleccione la Secuencia"
long BackColor=79416533
int TextSize=-10
int Weight=400
string FaceName="Arial"
boolean Italic=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_fa_man_fac_sec
int X=155
int Y=360
int Width=1157
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Haga Doble ClicK o Enter para Seleccionar"
boolean FocusRectangle=false
long BackColor=79416533
int TextSize=-10
int Weight=400
string FaceName="Arial"
boolean Italic=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

