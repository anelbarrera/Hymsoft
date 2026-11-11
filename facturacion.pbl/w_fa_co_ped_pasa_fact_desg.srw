//objectcomments Ventana de PAse de Pedido a Factura (Desglose)
forward
global type w_fa_co_ped_pasa_fact_desg from w_fa_padre
end type
type gb_2 from groupbox within w_fa_co_ped_pasa_fact_desg
end type
type gb_1 from groupbox within w_fa_co_ped_pasa_fact_desg
end type
type st_1 from statictext within w_fa_co_ped_pasa_fact_desg
end type
type dw_2 from datawindow within w_fa_co_ped_pasa_fact_desg
end type
type st_2 from statictext within w_fa_co_ped_pasa_fact_desg
end type
type st_3 from statictext within w_fa_co_ped_pasa_fact_desg
end type
type st_entero_asig from statictext within w_fa_co_ped_pasa_fact_desg
end type
type st_frac_asig from statictext within w_fa_co_ped_pasa_fact_desg
end type
type st_frac_faltan from statictext within w_fa_co_ped_pasa_fact_desg
end type
type st_entero_faltan from statictext within w_fa_co_ped_pasa_fact_desg
end type
end forward

global type w_fa_co_ped_pasa_fact_desg from w_fa_padre
int Width=2021
int Height=1448
WindowType WindowType=response!
boolean TitleBar=true
string Title="Desglose de Cantidades a Pasar..."
long BackColor=79739096
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
gb_2 gb_2
gb_1 gb_1
st_1 st_1
dw_2 dw_2
st_2 st_2
st_3 st_3
st_entero_asig st_entero_asig
st_frac_asig st_frac_asig
st_frac_faltan st_frac_faltan
st_entero_faltan st_entero_faltan
end type
global w_fa_co_ped_pasa_fact_desg w_fa_co_ped_pasa_fact_desg

type variables
Decimal		id_cantidad
str_desglose	istr_parm
end variables

forward prototypes
public subroutine wf_convert_uni (string as_med, long al_fracciones, ref long al_cantidad, ref long al_fraccion)
public subroutine wf_convert_cant (string as_unidad, long al_cantidad, integer ai_row)
public subroutine wf_totales ()
public function integer wf_entero2dec (long al_row)
public subroutine wf_cerrar ()
end prototypes

public subroutine wf_convert_uni (string as_med, long al_fracciones, ref long al_cantidad, ref long al_fraccion);/*Esta Función Convierte de Unidad Minima a la Unidad que se Quiere*/
//Llamada desde: ue_postitem, retrieveend del dw2

Double ld_total,ld_ucom, ld_mconvera,ld_frac

 
/*Extrae la Unidad comun "Pedo/Unidades/etc "*/
ld_ucom = gf_medi_prod(as_med)


/*Retorna el Factor de Converción a unidades minimas*/
ld_mconvera = gf_unidad_venta(as_med, ld_ucom)


If ld_mconvera <= 0 Then ld_mconvera = 1

ld_total = ( al_fracciones / ld_mconvera) 

ld_frac = (Mod(al_fracciones, ld_mconvera))
////messagebox("1",ld_frac)
//ld_frac = ld_frac*ld_mconvera
//messagebox("2",ld_frac)
//If ld_frac > ld_mconvera Then ld_frac = ld_frac /100

al_cantidad = Long(ld_total)
al_fraccion = ld_frac
end subroutine

public subroutine wf_convert_cant (string as_unidad, long al_cantidad, integer ai_row);//Para mostrar lo Asignado y lo disponible en Cantidad Fraccion

Long  ll_cant_asig=0, ll_frac_asig=0, ll_cant_disp=0, ll_frac_disp=0
	
wf_convert_uni(as_unidad,al_cantidad,ll_cant_asig, ll_frac_asig) //Conv. la Cantidad
dw_1.Setitem(ai_row,"cantidad",ll_cant_asig)	
dw_1.Setitem(ai_row,"fraccion",ll_frac_asig)	

end subroutine

public subroutine wf_totales ();// Calcula el total Desglosado

Long		ll_cantidad
String	ls_unidad
Double	ld_cantidad, ld_antes, ld_c_asig

// Actualizando los TOTALES
ls_unidad 	= dw_1.GetItemString (1, 'unidad_venta')
ld_cantidad = dw_1.GetItemNumber (dw_1.RowCount(), 'dcpe_cantidad_total')
ld_antes 	= ld_cantidad
gf_fa_convert_cant (ll_cantidad, ld_cantidad, 'A', ls_unidad)
//MessageBOx (string (ld_antes), string (ll_cantidad) + '-' + string (ld_cantidad))

dw_1.Object.cant_t.Text = string (long (ll_cantidad))
dw_1.Object.frac_t.Text = string (long (ld_cantidad))

// Actualizando los SLE
// Cant a Asignar
ld_cantidad = double (id_cantidad)
ld_c_asig	= ld_cantidad
gf_fa_convert_cant (ll_cantidad, ld_cantidad, 'A', ls_unidad)

st_entero_asig.Text = string (ll_cantidad)
st_frac_asig.Text   = string (round (ld_cantidad,0))

// Cant que Falta por Asignar
//messagebox (string (ld_antes) +'_ld_antes', string (ld_c_asig) +'_ld_c_asig')
ld_c_asig = ld_c_asig - ld_antes
gf_fa_convert_cant (ll_cantidad, ld_c_asig, 'A', ls_unidad)

st_entero_faltan.Text = string (ll_cantidad)
st_frac_faltan.Text   = string (round (ld_c_asig,0))

end subroutine

public function integer wf_entero2dec (long al_row);// Convierte la CANTIDAD y FRACCION de un renglón en DECIMAL
//

Double	ld_fraccion
Integer	li_rtn
Long		ll_cantidad
String	ls_unidad

ls_unidad 	= dw_1.GetItemString (al_row, 'unidad_venta')
ll_cantidad = dw_1.GetItemNumber (al_row, 'cantidad')
ld_fraccion = dw_1.GetItemNumber (al_row, 'fraccion')
ld_fraccion = gf_fa_convert_cant (ll_cantidad, ld_fraccion, 'C', ls_unidad)
li_rtn = dw_1.SetItem (al_row, 'cantidad_convertida', ld_fraccion)

Return li_rtn

end function

public subroutine wf_cerrar ();// Actualiza las cantidades modificadas
//
//

Double	ld_cantidad
Long		ll_i, ll_max

ll_max = dw.RowCount ()
For ll_i = 1 To ll_max
	ld_cantidad = dw.GetItemNumber (ll_i, 'cantidad_convertida')
	dw.SetItem (ll_i, "dcpe_cantidad", ld_cantidad)
Next 


//istr_parm.ds.Object.Data = dw.Object.DataWindow.Data
//startrow, endrow, movebuffer, targetdw, beforerow,	targetbuffer )
istr_parm.ds.Reset ()
dw.RowsCopy (1, dw.RowCount (), Primary!, istr_parm.ds, 1, Primary!)
end subroutine

on w_fa_co_ped_pasa_fact_desg.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_1=create st_1
this.dw_2=create dw_2
this.st_2=create st_2
this.st_3=create st_3
this.st_entero_asig=create st_entero_asig
this.st_frac_asig=create st_frac_asig
this.st_frac_faltan=create st_frac_faltan
this.st_entero_faltan=create st_entero_faltan
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_entero_asig
this.Control[iCurrent+8]=this.st_frac_asig
this.Control[iCurrent+9]=this.st_frac_faltan
this.Control[iCurrent+10]=this.st_entero_faltan
end on

on w_fa_co_ped_pasa_fact_desg.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_entero_asig)
destroy(this.st_frac_asig)
destroy(this.st_frac_faltan)
destroy(this.st_entero_faltan)
end on

event open;call super::open;String			ls_bodega, ls_ubic, ls_producto


istr_parm = Message.PowerObjectParm

// Asignación de Data
dw.Object.DataWindow.Data = istr_parm.ds.Object.Data

// Filtro
dw.SetFilter (istr_parm.filtro)
dw.Filter ()

// Recuperando el DW de Existencia de Desglose
ls_bodega 	= istr_parm.cadena [3]
ls_ubic		= istr_parm.cadena [4]
ls_producto = istr_parm.cadena [5]
dw_2.SetTransObject (sqlca)
dw_2.Retrieve (str.g_financiero, str.empresa, ls_bodega, ls_ubic, ls_producto)

// Cantidad a DEsglosar
id_cantidad = istr_parm.cantidad

MessageBox (string(id_cantidad), istr_parm.filtro)
end event

event closequery;//Override
Decimal		ldc_total
Double		ld_fraccion
Integer		li_rtn
Long			ll_entero
String 		ls_unidad, ls_msg


ldc_total 	= dw_1.GetItemNumber (dw_1.RowCount(), 'dcpe_cantidad_total')
id_cantidad = Round (id_cantidad, 3)
ldc_total	= Round (ldc_total, 3)

// Se asigno más Desglose de posible
//
If id_cantidad < ldc_total Then
	Mensaje ('Atencion', 'Usted Ha asignado más desglose del posible. Verifique y ' +&
				'corriga ... ', '')
	Return 1
End If

// Verificando que se haya desglosado en su totalidad la línea del Detalle
//
If id_cantidad <> ldc_total Then
	ld_fraccion = ldc_total - id_cantidad
	ls_unidad 	= dw_1.GetItemString (1, 'unidad_venta')
	gf_fa_convert_cant (ll_entero, ld_fraccion, 'A', ls_unidad)
	
	ls_msg = string (abs(ll_entero)) + ' ' + ls_unidad + ' ' + string (abs(ld_fraccion))
	li_rtn = MessageBox ('Advertencia', 'No se desglosado por completo la línea de ' +&
								'Detalle. Faltan por asignar ' + ls_msg + ' ¿Desea salir de'+&
								' la ventana de Desglose?', question!, YesNo! )
	If li_rtn = 2 Then Return 1
End If

wf_cerrar ()
dw.SetFilter ('')
dw.Filter ()

// Retornando Valor (Cantidad Total Asignada en el Desglose)
Message.DoubleParm = ldc_total
end event

event ue_post_open;call super::ue_post_open;Integer	li_rtn
Long		ll_i, ll_max
String	ls_filtro, ls_clase_tam, ls_tama, ls_tamb, ls_color

If dw_1.RowCount() = 0 Then Return

// Filtrando el DW de existencia 
ls_clase_tam = dw_1.GetItemString (1, 1)
ls_tama  	 = dw_1.GetItemString (1, 2)
ls_tamb		 = dw_1.GetItemString (1, 3)
ls_color		 = dw_1.GetItemString (1, 4)

ls_filtro 	 = "mbde_cod_clase_tam = '" + ls_clase_tam + "' And mbde_cod_tamano = '" +&
					ls_tama + "' And mbde_largo = '" + ls_tamb + "' And mbde_color = '"   +&
					ls_color + "'"

dw_2.SetFilter (ls_filtro)
dw_2.Filter ()


// Conviertiendo las cantidades
ll_max = dw_1.RowCount ()
For ll_i = 1 To ll_max
	wf_entero2dec (ll_i)
Next

// Calcula Totales
wf_totales ()
end event

event ue_hay_data;// Override
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_co_ped_pasa_fact_desg
int X=23
int Y=1268
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_co_ped_pasa_fact_desg
event ue_post_itemchanged ( long row,  double data,  dwobject dwo )
int X=55
int Y=168
int Width=1883
int Height=752
int TabOrder=10
string DataObject="dw_co_fa_pedpasfac_desg"
boolean HScrollBar=true
boolean LiveScroll=true
end type

event dw_1::ue_post_itemchanged;// Disparado inmediatamente despues del evento itemchanged
// Valida la Data introducida
Double		ld_fraccion
Decimal		ldc_cantidad
Long			ll_cantidad
String		ls_unidad

wf_totales ()
ldc_cantidad = dw_1.GetItemNumber (dw_1.RowCount(), 'dcpe_cantidad_total')

// Actualizando el campo de cantidad
wf_entero2dec  (row)

If id_cantidad > ldc_cantidad Then
	//SetItem (row, ldc_cantidad, data)
	SetItem (row, long (dwo.id), data)
	Post wf_totales ()
Else

End If

Post wf_totales ()
end event

event dw_1::editchanged;Double	ld_fraccion, ld_cant, ld_cant_por_pasar
Long		ll_cantidad
String	ls_unidad


If dwo.name = 'cantidad' Or dwo.name = 'fraccion' Then

	If dwo.name = 'cantidad' Then
		ld_fraccion = GetItemNumber (row, 'fraccion')
		ll_cantidad = long (data)
	Else
		ll_cantidad = GetItemNumber (row, 'cantidad')
		ld_fraccion = double (data)
	End If
	
	ls_unidad	 = GetItemString (row, 'unidad_venta')	
	
	ld_cant_por_pasar = GetItemNumber (row, 'cant_por_pasar')
	
	ld_cant  = gf_fa_convert_cant (ll_cantidad, ld_fraccion, 'C', ls_unidad)
	If ld_cant > ld_cant_por_pasar Then 
		Mensaje ('Atencion','Cantidad Sobrepasada.', '')
		// Seteando la cantidad Original
		gf_fa_convert_cant (ll_cantidad, ld_cant_por_pasar, 'A', ls_unidad)
		SetItem (row, 'cantidad', ll_cantidad)
		SetItem (row, 'fraccion', long (ld_cant_por_pasar))
	End If
End If
end event

event dw_1::rowfocuschanged;Integer	li_rtn
String	ls_filtro, ls_clase_tam, ls_tama, ls_tamb, ls_color

If currentrow = 0 Then Return

// Filtrando el DW de existencia 
ls_clase_tam = dw_1.GetItemString (currentrow, 1)
ls_tama  	 = dw_1.GetItemString (currentrow, 2)
ls_tamb		 = dw_1.GetItemString (currentrow, 3)
ls_color		 = dw_1.GetItemString (currentrow, 4)

ls_filtro 	 = "mbde_cod_clase_tam = '" + ls_clase_tam + "' And mbde_cod_tamano = '" +&
					ls_tama + "' And mbde_largo = '" + ls_tamb + "' And mbde_color = '"   +&
					ls_color + "'"

dw_2.SetFilter (ls_filtro)
dw_2.Filter ()


end event

event dw_1::itemchanged;call super::itemchanged;Double	ld_cantidad, ld_cantpasar
Integer	li_rtn
String	ls_unidad, ls_mensaje
Long		ll_cantidad, ll_fraccion, ll_disponible, ll_reservado

// Verificando si se sobrepasa lo reservado
ls_unidad 	= dw_1.GetItemString (row, 'unidad_venta')
ll_cantidad = dw_1.GetItemNumber (row, 'cantidad')
ll_fraccion = dw_1.GetItemNumber (row, 'fraccion')
ll_cantidad = gf_fa_convertmin (ls_unidad, ll_cantidad, ll_fraccion)

ll_reservado = dw_2.GetItemNumber (1, 'mbde_reserva')
ll_disponible= dw_2.GetItemNumber (1, 'disponible')
ld_cantpasar = GetItemNumber (row, 'cant_por_pasar')

If dwo.name = 'cantidad' Then 
	ll_cantidad  = long (data)
ElseIf dwo.name = 'fraccion' Then
	ll_fraccion  = long (data)
End If

// Convirtiendo a la Unidad Minima
ll_cantidad = gf_fa_convertmin (ls_unidad, ll_cantidad, ll_fraccion)

gf_fa_convert_cant (ll_fraccion, ld_cantpasar, 'C', ls_unidad)
ll_cantidad -= gf_fa_convertmin (ls_unidad, ll_fraccion, long(ld_cantpasar))

// Comparando si se va a asignar más de lo disponible
If (ll_cantidad) > ll_disponible Then
	ls_mensaje = 'Usted ha intentado reservar ' + string (ll_cantidad + ll_reservado) +&
					 '.~r~nSólo se dispone de ' + string (ll_disponible) + ' en bodega. ' +&
					 '~r~n¿Está seguro de que desea exceder la cantidad?'

	li_rtn = MessageBox ('Advertencia', ls_mensaje, question!, YesNo!)
	
	If li_rtn = 2 Then Return 2
End If


ld_cantidad = ll_fraccion
ld_cantidad = gf_fa_convert_cant (ll_cantidad, ld_cantidad, 'A', ls_unidad)

Post Event ue_post_itemchanged (row, ld_cantidad, dwo)

end event

type gb_2 from groupbox within w_fa_co_ped_pasa_fact_desg
int X=18
int Y=944
int Width=1961
int Height=284
int TabOrder=20
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

type gb_1 from groupbox within w_fa_co_ped_pasa_fact_desg
int X=18
int Y=128
int Width=1961
int Height=808
int TabOrder=40
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

type st_1 from statictext within w_fa_co_ped_pasa_fact_desg
int X=14
int Y=20
int Width=1961
int Height=120
boolean Enabled=false
boolean BringToTop=true
string Text="Desglose de Cantidades"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=15793151
long BackColor=8388608
int TextSize=-18
int Weight=700
string FaceName="Times New Roman"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type dw_2 from datawindow within w_fa_co_ped_pasa_fact_desg
int X=23
int Y=1120
int Width=1947
int Height=88
int TabOrder=30
boolean BringToTop=true
string DataObject="dw_man_fa_exist_desglose"
boolean Border=false
boolean LiveScroll=true
end type

type st_2 from statictext within w_fa_co_ped_pasa_fact_desg
int X=1019
int Y=1028
int Width=466
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Faltan por Asignar"
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

type st_3 from statictext within w_fa_co_ped_pasa_fact_desg
int X=41
int Y=1028
int Width=389
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Cant. a Asignar"
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

type st_entero_asig from statictext within w_fa_co_ped_pasa_fact_desg
int X=439
int Y=1012
int Width=311
int Height=80
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Right!
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

type st_frac_asig from statictext within w_fa_co_ped_pasa_fact_desg
int X=754
int Y=1012
int Width=137
int Height=80
boolean Enabled=false
boolean BringToTop=true
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

type st_frac_faltan from statictext within w_fa_co_ped_pasa_fact_desg
int X=1810
int Y=1012
int Width=137
int Height=80
boolean Enabled=false
boolean BringToTop=true
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

type st_entero_faltan from statictext within w_fa_co_ped_pasa_fact_desg
int X=1495
int Y=1012
int Width=311
int Height=80
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Right!
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

