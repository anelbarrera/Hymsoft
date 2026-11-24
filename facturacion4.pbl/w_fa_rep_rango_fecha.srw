//objectcomments Ventana que Genera los Informes con un Rango de Fecha
forward
global type w_fa_rep_rango_fecha from w_fa_padre_reportes
end type
type st_1 from statictext within w_fa_rep_rango_fecha
end type
type em_1 from editmask within w_fa_rep_rango_fecha
end type
type st_2 from statictext within w_fa_rep_rango_fecha
end type
type em_2 from editmask within w_fa_rep_rango_fecha
end type
type st_nom_inf from statictext within w_fa_rep_rango_fecha
end type
type cb_1 from commandbutton within w_fa_rep_rango_fecha
end type
type p_1 from picture within w_fa_rep_rango_fecha
end type
type pb_1 from picturebutton within w_fa_rep_rango_fecha
end type
type pb_2 from picturebutton within w_fa_rep_rango_fecha
end type
type st_7 from statictext within w_fa_rep_rango_fecha
end type
end forward

global type w_fa_rep_rango_fecha from w_fa_padre_reportes
int Width=2139
int Height=820
boolean MaxBox=false
boolean Resizable=false
event ue_vistaprevia ( )
st_1 st_1
em_1 em_1
st_2 st_2
em_2 em_2
st_nom_inf st_nom_inf
cb_1 cb_1
p_1 p_1
pb_1 pb_1
pb_2 pb_2
st_7 st_7
end type
global w_fa_rep_rango_fecha w_fa_rep_rango_fecha

forward prototypes
public subroutine wf_valida_fechas (ref date fecha_ini, ref date fecha_fin, integer desde_fecha)
end prototypes

event ue_vistaprevia;call super::ue_vistaprevia;//str_rangofecha lstr_rangfech
//
//If isDate(em_1.text) then
//	If isDate(em_2.text) then
//	
//		lstr_rangfech.fecha1 = date(em_1.text)
//		lstr_rangfech.fecha2 = date(em_2.text)
//	
//		OpenSheetWithParm(w_inf_cc_movmes,lstr_rangfech,this,1,Original!)
//	
//	
//	Else
//		Mensaje("Aviso","La fecha HASTA es Invalida","Cersiorese de que la fecha esta en el formato valido DIA/MES/AÑO")
//	End If
//Else
//	Mensaje("Aviso","La fecha DESDE es Invalida","Cersiorese de que la fecha esta en el formato valido DIA/MES/AÑO")
//End IF	
////copiarlo identico solo cambiar la ventana y el menu
//
end event

public subroutine wf_valida_fechas (ref date fecha_ini, ref date fecha_fin, integer desde_fecha);// Función que valida la correcta introducción de las fachas.

choose case desde_fecha 

  case 1
	
	if  fecha_ini > fecha_fin then
	
		fecha_ini = fecha_fin
	
		messagebox("ATENCIÓN SR. USUARIO","Fecha Incorrecta Cambiada por Fecha Final", Exclamation!)
	
	end if

  case 2

	if fecha_fin < fecha_ini then
	
		fecha_fin = fecha_ini

		messagebox("ATENCIÓN SR. USUARIO","Fecha Incorrecta ha sido ajustada a la Inicial", Exclamation!)
	
	end if

end choose
end subroutine

on w_fa_rep_rango_fecha.create
int iCurrent
call super::create
this.st_1=create st_1
this.em_1=create em_1
this.st_2=create st_2
this.em_2=create em_2
this.st_nom_inf=create st_nom_inf
this.cb_1=create cb_1
this.p_1=create p_1
this.pb_1=create pb_1
this.pb_2=create pb_2
this.st_7=create st_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.em_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_2
this.Control[iCurrent+5]=this.st_nom_inf
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.p_1
this.Control[iCurrent+8]=this.pb_1
this.Control[iCurrent+9]=this.pb_2
this.Control[iCurrent+10]=this.st_7
end on

on w_fa_rep_rango_fecha.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.st_2)
destroy(this.em_2)
destroy(this.st_nom_inf)
destroy(this.cb_1)
destroy(this.p_1)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.st_7)
end on

event open;call super::open;gf_center_win(This)

integer li_mes, li_ano
date ldt_fecha_ser

p_1.PictureName = "" + str.path +"\Art\Day.bmp "

ldt_fecha_ser = date(gf_fecha_serv())
li_mes 		  = month(ldt_fecha_ser)
li_ano		  = year(ldt_fecha_ser)

em_1.text = "01/01/" + string(li_ano)
//em_2.text = string(gf_last_day(li_mes,li_ano)) + "/" + string(li_mes) + "/" + string(li_ano)
em_2.text = string(ldt_fecha_ser)




end event

event resize;//Override
end event

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_rep_rango_fecha
int X=41
int Y=544
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_rep_rango_fecha
int X=27
int Y=20
int Width=302
int Height=132
int TabOrder=50
boolean Visible=false
end type

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_rep_rango_fecha
int X=137
int Y=244
int Width=1509
int Height=204
int TabOrder=60
string Text="Rango de Fecha"
long TextColor=8388608
end type

type st_1 from statictext within w_fa_rep_rango_fecha
int X=160
int Y=336
int Width=219
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Desde:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=79416533
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_1 from editmask within w_fa_rep_rango_fecha
int X=384
int Y=324
int Width=379
int Height=76
int TabOrder=30
boolean BringToTop=true
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yyyy"
MaskDataType MaskDataType=DateMask!
boolean Spin=true
string DisplayData="À"
double Increment=1
long TextColor=8388608
long BackColor=16777215
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;
//Si la fecha es modificada, se valida en la función wf_valida_fecha()

date lf_fecha_ini, lf_fecha_fin

lf_fecha_ini = date(em_1.text)
lf_fecha_fin = date(em_2.text)

wf_valida_fechas(lf_fecha_ini, lf_fecha_fin, 1)

if em_1.text <> string(lf_fecha_ini) then
	em_1.text = string(lf_fecha_ini)
end if

end event

event losefocus;triggerevent("modified")
end event

type st_2 from statictext within w_fa_rep_rango_fecha
int X=928
int Y=336
int Width=197
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Hasta :"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79416533
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_2 from editmask within w_fa_rep_rango_fecha
int X=1115
int Y=324
int Width=379
int Height=76
int TabOrder=20
boolean BringToTop=true
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yyyy"
MaskDataType MaskDataType=DateMask!
boolean Spin=true
string DisplayData=""
double Increment=1
long TextColor=8388608
long BackColor=16777215
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;//Si la fecha es modificada, se valida en la función wf_valida_fecha()

date lf_fecha_ini, lf_fecha_fin

lf_fecha_ini = date(em_1.text)
lf_fecha_fin = date(em_2.text)

wf_valida_fechas(lf_fecha_ini, lf_fecha_fin, 2)  //el 2 indica que es la segunda fecha

//Optimizar, esta entrando aunque no cambie la fecha, porque el año de lf_fecha_fin va en 2 digitos

if em_2.text <> string(lf_fecha_fin) then
	
	em_2.text = string(lf_fecha_fin)
	
end if

end event

type st_nom_inf from statictext within w_fa_rep_rango_fecha
int X=274
int Y=24
int Width=1623
int Height=200
boolean Enabled=false
boolean BringToTop=true
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=79416533
int TextSize=-16
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_fa_rep_rango_fecha
event mousemove pbm_nchittest
int X=1682
int Y=320
int Width=389
int Height=84
int TabOrder=10
boolean BringToTop=true
string Text="Generar"
boolean Default=true
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.TriggerEvent("ue_vistaprevia")
end event

type p_1 from picture within w_fa_rep_rango_fecha
int X=27
int Y=40
int Width=219
int Height=188
boolean BringToTop=true
boolean FocusRectangle=false
end type

type pb_1 from picturebutton within w_fa_rep_rango_fecha
int X=777
int Y=320
int Width=101
int Height=88
int TabOrder=40
boolean BringToTop=true
string PictureName="f:\harr2000\art\min_calendar.bmp"
boolean OriginalSize=true
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_mes, ls_ano

Open(w_dg_select_date)

em_1.text = Message.StringParm

ls_mes = string(month(date(em_1.text)))
ls_ano = string(year(date(em_1.text)))

em_2.text = string(gf_last_day(integer(ls_mes),integer(ls_ano))) + "/" + string(ls_mes) + "/" + string(ls_ano)

end event

type pb_2 from picturebutton within w_fa_rep_rango_fecha
int X=1509
int Y=320
int Width=101
int Height=88
int TabOrder=31
boolean BringToTop=true
string PictureName="f:\harr2000\art\min_calendar.bmp"
boolean OriginalSize=true
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_mes, ls_ano

Open(w_dg_select_date)

em_2.text = Message.StringParm

ls_mes = string(month(date(em_1.text)))
ls_ano = string(year(date(em_1.text)))

end event

type st_7 from statictext within w_fa_rep_rango_fecha
int X=1719
int Y=544
int Width=247
int Height=76
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-11
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

