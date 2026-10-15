//objectcomments Ventana de los informes de antiguedad
forward
global type w_inf_cc_antiguedad from w_cc_padre_reporte
end type
type cb_1 from commandbutton within w_inf_cc_antiguedad
end type
type ddlb_1 from dropdownlistbox within w_inf_cc_antiguedad
end type
type st_1 from statictext within w_inf_cc_antiguedad
end type
type dw_cc_inf_antigc2 from commandbutton within w_inf_cc_antiguedad
end type
type dw_cc_inf_antigc3 from commandbutton within w_inf_cc_antiguedad
end type
type st_3 from statictext within w_inf_cc_antiguedad
end type
type st_4 from statictext within w_inf_cc_antiguedad
end type
type st_2 from statictext within w_inf_cc_antiguedad
end type
type cbx_1 from checkbox within w_inf_cc_antiguedad
end type
type ddlb_2 from dropdownlistbox within w_inf_cc_antiguedad
end type
type st_5 from statictext within w_inf_cc_antiguedad
end type
type ddlb_3 from dropdownlistbox within w_inf_cc_antiguedad
end type
type st_6 from statictext within w_inf_cc_antiguedad
end type
type em_1 from editmask within w_inf_cc_antiguedad
end type
type dw_2 from datawindow within w_inf_cc_antiguedad
end type
type dw_3 from datawindow within w_inf_cc_antiguedad
end type
type cbx_por_pais from checkbox within w_inf_cc_antiguedad
end type
type dw_4 from datawindow within w_inf_cc_antiguedad
end type
end forward

global type w_inf_cc_antiguedad from w_cc_padre_reporte
integer width = 5646
integer height = 1696
string title = "Detalle de la Antigüedad de Saldos de Clientes"
string menuname = "m_cc_principal_listados"
boolean resizable = true
windowtype windowtype = main!
long backcolor = 12639424
integer transparency = 70
windowanimationstyle openanimation = toproll!
windowanimationstyle closeanimation = topslide!
cb_1 cb_1
ddlb_1 ddlb_1
st_1 st_1
dw_cc_inf_antigc2 dw_cc_inf_antigc2
dw_cc_inf_antigc3 dw_cc_inf_antigc3
st_3 st_3
st_4 st_4
st_2 st_2
cbx_1 cbx_1
ddlb_2 ddlb_2
st_5 st_5
ddlb_3 ddlb_3
st_6 st_6
em_1 em_1
dw_2 dw_2
dw_3 dw_3
cbx_por_pais cbx_por_pais
dw_4 dw_4
end type
global w_inf_cc_antiguedad w_inf_cc_antiguedad

type variables
str_rangofecha istr_rangfech
string  is_pais,is_pais_region= 'N',is_objeto
datawindowchild idwc_pais, idwc_region
 
end variables

forward prototypes
public subroutine wf_totales_invisibles (integer columna)
public subroutine wf_columnas_visibles ()
end prototypes

public subroutine wf_totales_invisibles (integer columna);//TOTALES QUE DEBEN ESTAR INVISIBLES

		//totales columna 4
		if columna = 3 then
		dw.modify('noventa.visible= false')
		dw.modify('noventa1.visible= false')
		dw.modify('noventa2.visible= false')
		dw.modify('noventa3.visible= false')
		dw.modify('noventa4.visible= false')
		end if
		
		//totales columna 5
		if columna <= 4 then
		dw.modify('cientoveinte.visible= false')
		dw.modify('cientoveinte1.visible= false')
		dw.modify('cientoveinte2.visible= false')
		dw.modify('cientoveinte3.visible= false')
		dw.modify('cientoveinte4.visible= false')//vendedor
		end if		
		
		//totales columna 6
		if columna <= 5 then
		dw.modify('cientocincuenta.visible= false')
		dw.modify('cientocincuenta1.visible= false')
		dw.modify('cientocincuenta2.visible= false')
		dw.modify('cientocincuenta3.visible= false')
		dw.modify('cientocincuenta4.visible= false')
		end if
		
		//totales columna 7
		if columna <= 6 then
		dw.modify('cientochenta.visible= false')
		dw.modify('cientochenta1.visible= false')
		dw.modify('cientochenta2.visible= false')
		dw.modify('cientochenta3.visible= false')
		dw.modify('cientochenta4.visible= false')
		end if
	
	  //totales columna 8
	  if columna <= 7 then
		dw.modify('docientosdiez.visible= false')
		dw.modify('docientosdiez1.visible= false')
		dw.modify('docientosdiez2.visible= false')
		dw.modify('docientosdiez3.visible= false')
		dw.modify('docientosdiez4.visible= false')
		end if
		
		//totales columna 9
		if columna <= 8 then
		dw.modify('docientoscuarenta.visible= false')
		dw.modify('docientoscuarenta1.visible= false')
		dw.modify('docientoscuarenta2.visible= false')
		dw.modify('docientoscuarenta3.visible= false')
		dw.modify('docientoscuarenta4.visible= false')		
		end if
	
	   //totales columna 10
		if columna <= 9 then
		dw.modify('docientosetenta.visible= false')
		dw.modify('docientosetenta1.visible= false')
		dw.modify('docientosetenta2.visible= false')
		dw.modify('docientosetenta3.visible= false')
		dw.modify('docientosetenta4.visible= false')
		end if
	
	 //totales columna 11
		if columna <= 10 then
		dw.modify('trecientos.visible= false')
		dw.modify('trecientos1.visible= false')
		dw.modify('trecientos2.visible= false')
		dw.modify('trecientos3.visible= false')
		dw.modify('trecientos4.visible= false')
		end if
		
		//totales columna 12
		if columna <= 11 then
		dw.modify('trecientostreinta.visible= false')
		dw.modify('trecientostreinta1.visible= false')
		dw.modify('trecientostreinta2.visible= false')
		dw.modify('trecientostreinta3.visible= false')
		dw.modify('trecientostreinta4.visible= false')
		end if
	
	   //totales columna 13
		if columna <= 12 then
		dw.modify('trecientosetenta.visible= false')
		dw.modify('trecientosetenta1.visible= false')
		dw.modify('trecientosetenta2.visible= false')
		dw.modify('trecientosetenta3.visible= false')
		dw.modify('trecientosetenta4.visible= false')
		end if
		
		//totales columna 14
		if columna <= 13 then
		dw.modify('trecientonoventa.visible= false')
		dw.modify('trecientonoventa1.visible= false')
		dw.modify('trecientonoventa2.visible= false')
		dw.modify('trecientonoventa3.visible= false')
		dw.modify('trecientonoventa4.visible= false')
		end if
end subroutine

public subroutine wf_columnas_visibles ();integer li_antiguedad
string  ls_error
//Pone invisible y mueve la columna de saldo total dependiendo del rango de antigüedad
SELECT count(*)  
 INTO :li_antiguedad  
 FROM ccaantig  
WHERE ( ccaantig.ccan_g_financiero = :str.g_financiero ) AND  
		( ccaantig.ccan_empresa = :str.empresa )  AND
		( ccaantig.ccan_codigo = :istr_rangfech.tipo_antiguedad );
if sqlca.sqldbcode = -1 then
	ls_error = sqlca.sqlerrtext
	rollback;
	mensaje('Error','Ha ocurrido un error al recuperar parametro de antigüedad',ls_error)
end if
if isnull(li_antiguedad) then li_antiguedad = 0

//Llama la funcion que elimina columnas del dw

CHOOSE CASE li_antiguedad
	CASE	3//30 días
		//ENCABEZADOS Y DETALLE QUE DEBEN ESTAR INVISIBLES
		dw.modify('tpan_col4_t.visible= false')
		dw.modify('tpan_col4.visible= false')
		dw.modify('tpan_col5_t.visible= false')
		dw.modify('tpan_col5.visible= false')
		dw.modify('tpan_col6_t.visible= false')
		dw.modify('tpan_col6.visible= false')
		dw.modify('tpan_col7_t.visible= false')
		dw.modify('tpan_col7.visible= false')
		dw.modify('tpan_col8_t.visible= false')
		dw.modify('tpan_col8.visible= false')
		dw.modify('tpan_col9_t.visible= false')
		dw.modify('tpan_col9.visible= false')
		dw.modify('tpan_col10_t.visible= false')
		dw.modify('tpan_col10.visible= false')
		dw.modify('tpan_col11_t.visible= false')
		dw.modify('tpan_col11.visible= false')
		dw.modify('tpan_col12_t.visible= false')
		dw.modify('tpan_col12.visible= false')
		dw.modify('tpan_col13_t.visible= false')
		dw.modify('tpan_col13.visible= false')
		dw.modify('tpan_col14_t.visible= false')
		dw.modify('tpan_col14.visible= false')
		dw.modify('tpan_col15_t.visible= false')
		dw.modify('tpan_col15.visible= false')
		dw.modify('tpan_col16_t.visible= false')
		dw.modify('tpan_col16.visible= false')

		wf_totales_invisibles(3)
		
		//se mueve el campo de saldo total
		dw.modify('tpan_col21_t.x= 2459')
		dw.modify('tpan_col21.x= 2459')
		dw.modify('total.x= 2459')		
		dw.modify('total1.x= 2459')
		dw.modify('total2.x= 2459')
		dw.modify('total3.x= 2459')
		dw.modify('total4.x= 2459')
		
		//lineas de division
		dw.modify('l_1.x2= 2939')
		dw.modify('l_2.x2= 2939')
		dw.modify('l_3.x2= 2939')
		dw.modify('l_4.x2= 2939')
		dw.modify('l_5.x2= 2939')
		dw.modify('l_8.x2= 2939')
		dw.modify('l_7.x2= 2939')
		dw.modify('l_6.x2= 2939')
		dw.modify('l_9.x2= 2939')
		dw.modify('l_10.x2= 2939')
		

//
CASE 4//60
	dw.modify('tpan_col5_t.visible= false')
	dw.modify('tpan_col5.visible= false')
	dw.modify('tpan_col6_t.visible= false')
	dw.modify('tpan_col6.visible= false')
	dw.modify('tpan_col7_t.visible= false')
	dw.modify('tpan_col7.visible= false')
	dw.modify('tpan_col8_t.visible= false')
	dw.modify('tpan_col8.visible= false')
	dw.modify('tpan_col9_t.visible= false')
	dw.modify('tpan_col9.visible= false')
	dw.modify('tpan_col10_t.visible= false')
	dw.modify('tpan_col10.visible= false')
	dw.modify('tpan_col11_t.visible= false')
	dw.modify('tpan_col11.visible= false')
	dw.modify('tpan_col12_t.visible= false')
	dw.modify('tpan_col12.visible= false')
	dw.modify('tpan_col13_t.visible= false')
	dw.modify('tpan_col13.visible= false')
	dw.modify('tpan_col14_t.visible= false')
	dw.modify('tpan_col14.visible= false')
	dw.modify('tpan_col15_t.visible= false')
	dw.modify('tpan_col15.visible= false')
	dw.modify('tpan_col16_t.visible= false')
	dw.modify('tpan_col16.visible= false')

	//TOTALES QUE DEBEN ESTAR INVISIBLES
    wf_totales_invisibles(4)
	
	//**se mueven a cero para quew no salga una hoja en blanco****
	//totales columna 4
   dw.modify('tpan_col4_t.x=2459')
	dw.modify('tpan_col4.x=2459')

	dw.modify('noventa.x= 2459')
	dw.modify('noventa1.x= 2459')
	dw.modify('noventa2.x= 2459')
	dw.modify('noventa3.x= 2459')
	dw.modify('noventa4.x= 2459')
	
	//se mueve el campo de saldo total
	dw.modify('tpan_col21_t.x= 2802')
	dw.modify('tpan_col21.x= 2802')
	dw.modify('total.x= 2802')		
	dw.modify('total1.x= 2802')
	dw.modify('total2.x= 2802')
	dw.modify('total3.x= 2802')
	dw.modify('total4.x= 2802')
	
	//lineas de division
	dw.modify('l_1.x2= 3150')
	dw.modify('l_2.x2= 3150')
	dw.modify('l_3.x2= 3150')
	dw.modify('l_4.x2= 3150')
	dw.modify('l_5.x2= 3150')
	dw.modify('l_8.x2= 3150')
	dw.modify('l_7.x2= 3150')
	dw.modify('l_6.x2= 3150')
	dw.modify('l_9.x2= 3150')
	dw.modify('l_10.x2= 3150')
	
		
////Títulos
//dw.modify('dgagrupf_grup_descripcion.x= 475')
//dw.modify('empresanom.x= 480')
//dw.modify('titulo.x= 475')
//dw.modify('t_1.x= 475')
//dw.modify('r_1.x= 402')
//
CASE 5//150
	
	dw.modify('tpan_col6_t.visible= false')
	dw.modify('tpan_col6.visible= false')
	dw.modify('tpan_col7_t.visible= false')
	dw.modify('tpan_col7.visible= false')
	dw.modify('tpan_col8_t.visible= false')
	dw.modify('tpan_col8.visible= false')
	dw.modify('tpan_col9_t.visible= false')
	dw.modify('tpan_col9.visible= false')
	dw.modify('tpan_col10_t.visible= false')
	dw.modify('tpan_col10.visible= false')
	dw.modify('tpan_col11_t.visible= false')
	dw.modify('tpan_col11.visible= false')
	dw.modify('tpan_col12_t.visible= false')
	dw.modify('tpan_col12.visible= false')
	dw.modify('tpan_col13_t.visible= false')
	dw.modify('tpan_col13.visible= false')
	dw.modify('tpan_col14_t.visible= false')
	dw.modify('tpan_col14.visible= false')
	dw.modify('tpan_col15_t.visible= false')
	dw.modify('tpan_col15.visible= false')
	dw.modify('tpan_col16_t.visible= false')
	dw.modify('tpan_col16.visible= false')

	//TOTALES
	wf_totales_invisibles(5)
	
	//mover campos
	//totales columna 4
   dw.modify('tpan_col4_t.x=2455')
	dw.modify('tpan_col4.x=2455')

	dw.modify('noventa.x= 2455')
	dw.modify('noventa1.x= 2455')
	dw.modify('noventa2.x= 2455')
	dw.modify('noventa3.x= 2455')
	dw.modify('noventa4.x= 2455')
	
	//totales columna 5
	dw.modify('tpan_col5_t.x= 2802')
	dw.modify('tpan_col5.x= 2802')
	dw.modify('cientoveinte.x= 2802')
	dw.modify('cientoveinte1.x= 2802')
	dw.modify('cientoveinte2.x= 2802')
	dw.modify('cientoveinte3.x= 2802')
	dw.modify('cientoveinte4.x= 2802')
	
	//*****
	//se mueve el campo de saldo total
	dw.modify('tpan_col21_t.x= 3154')
	dw.modify('tpan_col21.x= 3154')
	dw.modify('total.x= 3154')		
	dw.modify('total1.x= 3154')
	dw.modify('total2.x= 3154')
	dw.modify('total3.x= 3154')
	dw.modify('total4.x= 3154')
	
	//lineas de division
	dw.modify('l_1.x2= 3479')
	dw.modify('l_2.x2= 3479')
	dw.modify('l_3.x2= 3479')
	dw.modify('l_4.x2= 3479')
	dw.modify('l_5.x2= 3479')
	dw.modify('l_8.x2= 3479')
	dw.modify('l_7.x2= 3479')
	dw.modify('l_6.x2= 3479')
	dw.modify('l_9.x2= 3479')
	dw.modify('l_10.x2= 3479')		
//Títulos
dw.modify('dgagrupf_grup_descripcion.x= 475')
dw.modify('empresanom.x= 480')
dw.modify('titulo.x= 475')
dw.modify('t_1.x= 475')
dw.modify('r_1.x= 402')


CASE 6//180
dw.modify('tpan_col7_t.visible= false')
dw.modify('tpan_col7.visible= false')
dw.modify('tpan_col8_t.visible= false')
dw.modify('tpan_col8.visible= false')
dw.modify('tpan_col9_t.visible= false')
dw.modify('tpan_col9.visible= false')
dw.modify('tpan_col10_t.visible= false')
dw.modify('tpan_col10.visible= false')
dw.modify('tpan_col11_t.visible= false')
dw.modify('tpan_col11.visible= false')
dw.modify('tpan_col12_t.visible= false')
dw.modify('tpan_col12.visible= false')
dw.modify('tpan_col13_t.visible= false')
dw.modify('tpan_col13.visible= false')
dw.modify('tpan_col14_t.visible= false')
dw.modify('tpan_col14.visible= false')
dw.modify('tpan_col15_t.visible= false')
dw.modify('tpan_col15.visible= false')
dw.modify('tpan_col16_t.visible= false')
dw.modify('tpan_col16.visible= false')

//TOTALES
wf_totales_invisibles(6)

//totales
//totales columna 4
dw.modify('tpan_col4_t.x=2455')  //2455
dw.modify('tpan_col4.x=2455')

dw.modify('noventa.x= 2455')
dw.modify('noventa1.x= 2455')
dw.modify('noventa2.x= 2455')
dw.modify('noventa3.x= 2455')
dw.modify('noventa4.x= 2455')

//totales columna 5
dw.modify('tpan_col5_t.x= 2802')
dw.modify('tpan_col5.x= 2802')
dw.modify('cientoveinte.x= 2802')
dw.modify('cientoveinte1.x= 2802')
dw.modify('cientoveinte2.x= 2802')
dw.modify('cientoveinte3.x= 2802')
dw.modify('cientoveinte4.x= 2802')

//totales columna 6
dw.modify('tpan_col6_t.x= 3150')
dw.modify('tpan_col6.x= 3150')

dw.modify('cientocincuenta.x= 3150')
dw.modify('cientocincuenta1.x= 3150')
dw.modify('cientocincuenta2.x= 3150')
dw.modify('cientocincuenta3.x= 3150')
dw.modify('cientocincuenta4.x= 3150')

//se mueve el campo de saldo total
if str.empresa <> 1  and (pos(str.empr_acceso_especial, 'GOLD,') > 0 or pos(str.empr_acceso_especial, 'ADVANCED,') > 0) then //Si no es gold america abajo
	dw.modify('tpan_col21_t.x= 3502')
	dw.modify('tpan_col21.x= 3502')
	dw.modify('total.x= 3502')		
	dw.modify('total1.x= 3502')
	dw.modify('total2.x= 3502')
	dw.modify('total3.x= 3502')
	dw.modify('total4.x= 3502')
end if
//lineas de division
if str.empresa = 1 and pos(str.empr_acceso_especial, 'GOLD,') > 0 then
	dw.modify('l_1.x2= 3488') //3845
	dw.modify('l_2.x2= 3488')
	dw.modify('l_3.x2= 3488')	
	dw.modify('l_8.x2= 3488')
	dw.modify('l_7.x2= 3488')	
else
	dw.modify('l_1.x2= 3845') 
	dw.modify('l_2.x2= 3845')
	dw.modify('l_3.x2= 3845')	
	dw.modify('l_8.x2= 3845')
	dw.modify('l_7.x2= 3845')	
end if

//dw.modify('l_3.x2= 3845')
dw.modify('l_4.x2= 3845')
dw.modify('l_5.x2= 3845')
dw.modify('l_6.x2= 3845')
dw.modify('l_9.x2= 3845')
dw.modify('l_10.x2= 3845')		

//Títulos
dw.modify('dgagrupf_grup_descripcion.x= 475')
dw.modify('empresanom.x= 480')
dw.modify('titulo.x= 475')
dw.modify('t_1.x= 475')
dw.modify('r_1.x= 402')
	
CASE 7//210

dw.modify('tpan_col8_t.visible= false')
dw.modify('tpan_col8.visible= false')
dw.modify('tpan_col9_t.visible= false')
dw.modify('tpan_col9.visible= false')
dw.modify('tpan_col10_t.visible= false')
dw.modify('tpan_col10.visible= false')
dw.modify('tpan_col11_t.visible= false')
dw.modify('tpan_col11.visible= false')
dw.modify('tpan_col12_t.visible= false')
dw.modify('tpan_col12.visible= false')
dw.modify('tpan_col13_t.visible= false')
dw.modify('tpan_col13.visible= false')
dw.modify('tpan_col14_t.visible= false')
dw.modify('tpan_col14.visible= false')
dw.modify('tpan_col15_t.visible= false')
dw.modify('tpan_col15.visible= false')
dw.modify('tpan_col16_t.visible= false')
dw.modify('tpan_col16.visible= false')

//TOTALES
wf_totales_invisibles(7)

//mover columnas	
//totales columna 4
dw.modify('tpan_col4_t.x=2455')
dw.modify('tpan_col4.x=2455')

dw.modify('noventa.x= 2455')
dw.modify('noventa1.x= 2455')
dw.modify('noventa2.x= 2455')
dw.modify('noventa3.x= 2455')
dw.modify('noventa4.x= 2455')

//totales columna 5
dw.modify('tpan_col5_t.x= 2802')
dw.modify('tpan_col5.x= 2802')
dw.modify('cientoveinte.x= 2802')
dw.modify('cientoveinte1.x= 2802')
dw.modify('cientoveinte2.x= 2802')
dw.modify('cientoveinte3.x= 2802')
dw.modify('cientoveinte4.x= 2802')

//totales columna 6
dw.modify('tpan_col6_t.x= 3150')
dw.modify('tpan_col6.x= 3150')

dw.modify('cientocincuenta.x= 3150')
dw.modify('cientocincuenta1.x= 3150')
dw.modify('cientocincuenta2.x= 3150')
dw.modify('cientocincuenta3.x= 3150')
dw.modify('cientocincuenta4.x= 3150')

//totales columna 7
dw.modify('tpan_col7_t.x= 3497')
dw.modify('tpan_col7.x= 3497')

dw.modify('cientochenta.x= 3497')
dw.modify('cientochenta1.x= 3497')
dw.modify('cientochenta2.x= 3497')
dw.modify('cientochenta3.x= 3497')
dw.modify('cientochenta4.x= 3497')

/*//se mueve el campo de saldo total
dw.modify('tpan_col21_t.x= 3849')
dw.modify('tpan_col21.x= 3849')
dw.modify('total.x= 3849')		
dw.modify('total1.x= 3849')
dw.modify('total2.x= 3849')
dw.modify('total3.x= 3849')
dw.modify('total4.x= 3849')
*/

//se mueve el campo de saldo total
if str.empresa <> 1 and pos(str.empr_acceso_especial, 'GOLD,') > 0 then //Si no es gold america abajo
	dw.modify('tpan_col21_t.x= 3502')
	dw.modify('tpan_col21.x= 3502')
	dw.modify('total.x= 3502')		
	dw.modify('total1.x= 3502')
	dw.modify('total2.x= 3502')
	dw.modify('total3.x= 3502')
	dw.modify('total4.x= 3502')
end if


//lineas de division
if str.empresa = 1 and pos(str.empr_acceso_especial, 'GOLD,') > 0  then
	dw.modify('l_1.x2= 3845') //3488
	dw.modify('l_2.x2= 3845')
	dw.modify('l_3.x2= 3845')	
	dw.modify('l_4.x2= 3845')	
	dw.modify('l_5.x2= 3845')	
	dw.modify('l_8.x2= 3845')
	dw.modify('l_7.x2= 3845')	
else
	dw.modify('l_1.x2= 4197')
	dw.modify('l_2.x2= 4197')
	dw.modify('l_3.x2= 4197')
	dw.modify('l_4.x2= 4197')
	dw.modify('l_5.x2= 4197')
	dw.modify('l_8.x2= 4197')
	dw.modify('l_7.x2= 4197')
end if

//lineas de division
dw.modify('l_6.x2= 4197')
dw.modify('l_9.x2= 4197')
dw.modify('l_10.x2= 4197')

//Títulos
dw.modify('dgagrupf_grup_descripcion.x= 975')
dw.modify('empresanom.x= 980')
dw.modify('titulo.x= 975')
dw.modify('t_1.x= 975')
dw.modify('r_1.x= 902')
	
CASE 8//250

dw.modify('tpan_col9_t.visible= false')
dw.modify('tpan_col9.visible= false')
dw.modify('tpan_col10_t.visible= false')
dw.modify('tpan_col10.visible= false')
dw.modify('tpan_col11_t.visible= false')
dw.modify('tpan_col11.visible= false')
dw.modify('tpan_col12_t.visible= false')
dw.modify('tpan_col12.visible= false')
dw.modify('tpan_col13_t.visible= false')
dw.modify('tpan_col13.visible= false')
dw.modify('tpan_col14_t.visible= false')
dw.modify('tpan_col14.visible= false')
dw.modify('tpan_col15_t.visible= false')
dw.modify('tpan_col15.visible= false')
dw.modify('tpan_col16_t.visible= false')
dw.modify('tpan_col16.visible= false')

//TOTALES
wf_totales_invisibles(8)

//mover columnas
//totales columna 4
dw.modify('tpan_col4_t.x=2455')
dw.modify('tpan_col4.x=2455')

dw.modify('noventa.x= 2455')
dw.modify('noventa1.x= 2455')
dw.modify('noventa2.x= 2455')
dw.modify('noventa3.x= 2455')
dw.modify('noventa4.x= 2455')

//totales columna 5
dw.modify('tpan_col5_t.x= 2802')
dw.modify('tpan_col5.x= 2802')
dw.modify('cientoveinte.x= 2802')
dw.modify('cientoveinte1.x= 2802')
dw.modify('cientoveinte2.x= 2802')
dw.modify('cientoveinte3.x= 2802')
dw.modify('cientoveinte4.x= 2802')

//totales columna 6
dw.modify('tpan_col6_t.x= 3150')
dw.modify('tpan_col6.x= 3150')

dw.modify('cientocincuenta.x= 3150')
dw.modify('cientocincuenta1.x= 3150')
dw.modify('cientocincuenta2.x= 3150')
dw.modify('cientocincuenta3.x= 3150')
dw.modify('cientocincuenta4.x= 3150')
//totales columna 7
dw.modify('tpan_col7_t.x= 3497')
dw.modify('tpan_col7.x= 3497')

dw.modify('cientochenta.x= 3497')
dw.modify('cientochenta1.x= 3497')
dw.modify('cientochenta2.x= 3497')
dw.modify('cientochenta3.x= 3497')
dw.modify('cientochenta4.x= 3497')
//totales columna 8
dw.modify('tpan_col8_t.x= 3845')
dw.modify('tpan_col8.x= 3845')

dw.modify('docientosdiez.x= 3845')
dw.modify('docientosdiez1.x= 3845')
dw.modify('docientosdiez2.x= 3845')
dw.modify('docientosdiez3.x= 3845')
dw.modify('docientosdiez4.x= 3845')

//se mueve el campo de saldo total
dw.modify('tpan_col21_t.x= 4192')
dw.modify('tpan_col21.x= 4192')
dw.modify('total.x= 4192')		
dw.modify('total1.x= 4192')
dw.modify('total2.x= 4192')
dw.modify('total3.x= 4192')
dw.modify('total4.x= 4192')
//lineas de division
dw.modify('l_1.x2= 4526')
dw.modify('l_2.x2= 4526')
dw.modify('l_3.x2= 4526')
dw.modify('l_4.x2= 4526')
dw.modify('l_5.x2= 4526')
dw.modify('l_8.x2= 4526')
dw.modify('l_7.x2= 4526')
dw.modify('l_6.x2= 4526')
dw.modify('l_9.x2= 4526')
dw.modify('l_10.x2= 4526')		

//Títulos
dw.modify('dgagrupf_grup_descripcion.x= 975')
dw.modify('empresanom.x= 980')
dw.modify('titulo.x= 975')
dw.modify('t_1.x= 975')
dw.modify('r_1.x= 902')
	
CASE 9//280
dw.modify('tpan_col10_t.visible= false')
dw.modify('tpan_col10.visible= false')
dw.modify('tpan_col11_t.visible= false')
dw.modify('tpan_col11.visible= false')
dw.modify('tpan_col12_t.visible= false')
dw.modify('tpan_col12.visible= false')
dw.modify('tpan_col13_t.visible= false')
dw.modify('tpan_col13.visible= false')
dw.modify('tpan_col14_t.visible= false')
dw.modify('tpan_col14.visible= false')
dw.modify('tpan_col15_t.visible= false')
dw.modify('tpan_col15.visible= false')
dw.modify('tpan_col16_t.visible= false')
dw.modify('tpan_col16.visible= false')

//TOTALES
wf_totales_invisibles(9)

//mover columnas
//totales columna 4
dw.modify('tpan_col4_t.x=2455')
dw.modify('tpan_col4.x=2455')

dw.modify('noventa.x= 2455')
dw.modify('noventa1.x= 2455')
dw.modify('noventa2.x= 2455')
dw.modify('noventa3.x= 2455')
dw.modify('noventa4.x= 2455')
//totales columna 5
dw.modify('tpan_col5_t.x= 2802')
dw.modify('tpan_col5.x= 2802')
dw.modify('cientoveinte.x= 2802')
dw.modify('cientoveinte1.x= 2802')
dw.modify('cientoveinte2.x= 2802')
dw.modify('cientoveinte3.x= 2802')
dw.modify('cientoveinte4.x= 2802')	
//totales columna 6
dw.modify('tpan_col6_t.x= 3150')
dw.modify('tpan_col6.x= 3150')

dw.modify('cientocincuenta.x= 3150')
dw.modify('cientocincuenta1.x= 3150')
dw.modify('cientocincuenta2.x= 3150')
dw.modify('cientocincuenta3.x= 3150')
dw.modify('cientocincuenta4.x= 3150')
//totales columna 7
dw.modify('tpan_col7_t.x= 3497')
dw.modify('tpan_col7.x= 3497')

dw.modify('cientochenta.x= 3497')
dw.modify('cientochenta1.x= 3497')
dw.modify('cientochenta2.x= 3497')
dw.modify('cientochenta3.x= 3497')
dw.modify('cientochenta4.x= 3497')
//totales columna 8
dw.modify('tpan_col8_t.x= 3845')
dw.modify('tpan_col8.x= 3845')

dw.modify('docientosdiez.x= 3845')
dw.modify('docientosdiez1.x= 3845')
dw.modify('docientosdiez2.x= 3845')
dw.modify('docientosdiez3.x= 3845')
dw.modify('docientosdiez4.x= 3845')
//totales columna 9
dw.modify('tpan_col9_t.x= 4192')
dw.modify('tpan_col9.x= 4192')

dw.modify('docientoscuarenta.x= 4192')
dw.modify('docientoscuarenta1.x= 4192')
dw.modify('docientoscuarenta2.x= 4192')
dw.modify('docientoscuarenta3.x= 4192')
dw.modify('docientoscuarenta4.x= 4192')
//se mueve el campo de saldo total
dw.modify('tpan_col21_t.x= 4535')
dw.modify('tpan_col21.x= 4535')
dw.modify('total.x= 4535')		
dw.modify('total1.x= 4535')
dw.modify('total2.x= 4535')
dw.modify('total3.x= 4535')
dw.modify('total4.x= 4535')
//lineas de division
dw.modify('l_1.x2= 4896')
dw.modify('l_2.x2= 4896')
dw.modify('l_3.x2= 4896')
dw.modify('l_4.x2= 4896')
dw.modify('l_5.x2= 4896')
dw.modify('l_8.x2= 4896')
dw.modify('l_7.x2= 4896')
dw.modify('l_6.x2= 4896')
dw.modify('l_9.x2= 4896')
dw.modify('l_10.x2= 4896')

//Títulos
dw.modify('dgagrupf_grup_descripcion.x= 1075')
dw.modify('empresanom.x= 1080')
dw.modify('titulo.x= 1075')
dw.modify('t_1.x= 1075')
dw.modify('r_1.x= 1002')


CASE 10//310
	
dw.modify('tpan_col11_t.visible= false')
dw.modify('tpan_col11.visible= false')
dw.modify('tpan_col12_t.visible= false')
dw.modify('tpan_col12.visible= false')
dw.modify('tpan_col13_t.visible= false')
dw.modify('tpan_col13.visible= false')
dw.modify('tpan_col14_t.visible= false')
dw.modify('tpan_col14.visible= false')
dw.modify('tpan_col15_t.visible= false')
dw.modify('tpan_col15.visible= false')
dw.modify('tpan_col16_t.visible= false')
dw.modify('tpan_col16.visible= false')

//TOTALES
wf_totales_invisibles(10)

//mover clumnas
//totales columna 4
dw.modify('tpan_col4_t.x=2455')
dw.modify('tpan_col4.x=2455')

dw.modify('noventa.x= 2455')
dw.modify('noventa1.x= 2455')
dw.modify('noventa2.x= 2455')
dw.modify('noventa3.x= 2455')
dw.modify('noventa4.x= 2455')

//totales columna 5
dw.modify('tpan_col5_t.x= 2802')
dw.modify('tpan_col5.x= 2802')
dw.modify('cientoveinte.x= 2802')
dw.modify('cientoveinte1.x= 2802')
dw.modify('cientoveinte2.x= 2802')
dw.modify('cientoveinte3.x= 2802')
dw.modify('cientoveinte4.x= 2802')	
//totales columna 6
dw.modify('tpan_col6_t.x= 3150')
dw.modify('tpan_col6.x= 3150')

dw.modify('cientocincuenta.x= 3150')
dw.modify('cientocincuenta1.x= 3150')
dw.modify('cientocincuenta2.x= 3150')
dw.modify('cientocincuenta3.x= 3150')
dw.modify('cientocincuenta4.x= 3150')
//totales columna 7
dw.modify('tpan_col7_t.x= 3497')
dw.modify('tpan_col7.x= 3497')

dw.modify('cientochenta.x= 3497')
dw.modify('cientochenta1.x= 3497')
dw.modify('cientochenta2.x= 3497')
dw.modify('cientochenta3.x= 3497')
dw.modify('cientochenta4.x= 3497')
//totales columna 8
dw.modify('tpan_col8_t.x= 3845')
dw.modify('tpan_col8.x= 3845')

dw.modify('docientosdiez.x= 3845')
dw.modify('docientosdiez1.x= 3845')
dw.modify('docientosdiez2.x= 3845')
dw.modify('docientosdiez3.x= 3845')
dw.modify('docientosdiez4.x= 3845')
//totales columna 9
dw.modify('tpan_col9_t.x= 4192')
dw.modify('tpan_col9.x= 4192')

dw.modify('docientoscuarenta.x= 4192')
dw.modify('docientoscuarenta1.x= 4192')
dw.modify('docientoscuarenta2.x= 4192')
dw.modify('docientoscuarenta3.x= 4192')
dw.modify('docientoscuarenta4.x= 4192')
//totales columna 10
dw.modify('tpan_col10_t.x= 4539')
dw.modify('tpan_col10.x= 4539')

dw.modify('docientosetenta.x= 4539')
dw.modify('docientosetenta1.x= 4539')
dw.modify('docientosetenta2.x= 4539')
dw.modify('docientosetenta3.x= 4539')
dw.modify('docientosetenta4.x= 4539')

//se mueve el campo de saldo total
dw.modify('tpan_col21_t.x= 4882')
dw.modify('tpan_col21.x= 4882')
dw.modify('total.x= 4882')		
dw.modify('total1.x= 4882')
dw.modify('total2.x= 4882')
dw.modify('total3.x= 4882')
dw.modify('total4.x= 4882')
//lineas de division
dw.modify('l_1.x2= 5221')
dw.modify('l_2.x2= 5221')
dw.modify('l_3.x2= 5221')
dw.modify('l_4.x2= 5221')
dw.modify('l_5.x2= 5221')
dw.modify('l_8.x2= 5221')
dw.modify('l_7.x2= 5221')
dw.modify('l_6.x2= 5221')
dw.modify('l_9.x2= 5221')
dw.modify('l_10.x2= 5221')		

//Títulos
dw.modify('dgagrupf_grup_descripcion.x= 1075')
dw.modify('empresanom.x= 1080')
dw.modify('titulo.x= 1075')
dw.modify('t_1.x= 1075')
dw.modify('r_1.x= 1002')

CASE 11//310
	
dw.modify('tpan_col12_t.visible= false')
dw.modify('tpan_col12.visible= false')
dw.modify('tpan_col13_t.visible= false')
dw.modify('tpan_col13.visible= false')
dw.modify('tpan_col14_t.visible= false')
dw.modify('tpan_col14.visible= false')
dw.modify('tpan_col15_t.visible= false')
dw.modify('tpan_col15.visible= false')
dw.modify('tpan_col16_t.visible= false')
dw.modify('tpan_col16.visible= false')

//TOTALES
wf_totales_invisibles(11)

//mover clumnas
//totales columna 4
dw.modify('tpan_col4_t.x=2455')
dw.modify('tpan_col4.x=2455')

dw.modify('noventa.x= 2455')
dw.modify('noventa1.x= 2455')
dw.modify('noventa2.x= 2455')
dw.modify('noventa3.x= 2455')
dw.modify('noventa4.x= 2455')
//totales columna 5
dw.modify('tpan_col5_t.x= 2802')
dw.modify('tpan_col5.x= 2802')
dw.modify('cientoveinte.x= 2802')
dw.modify('cientoveinte1.x= 2802')
dw.modify('cientoveinte2.x= 2802')
dw.modify('cientoveinte3.x= 2802')
dw.modify('cientoveinte4.x= 2802')	
//totales columna 6
dw.modify('tpan_col6_t.x= 3150')
dw.modify('tpan_col6.x= 3150')

dw.modify('cientocincuenta.x= 3150')
dw.modify('cientocincuenta1.x= 3150')
dw.modify('cientocincuenta2.x= 3150')
dw.modify('cientocincuenta3.x= 3150')
dw.modify('cientocincuenta4.x= 3150')
//totales columna 7
dw.modify('tpan_col7_t.x= 3497')
dw.modify('tpan_col7.x= 3497')

dw.modify('cientochenta.x= 3497')
dw.modify('cientochenta1.x= 3497')
dw.modify('cientochenta2.x= 3497')
dw.modify('cientochenta3.x= 3497')
dw.modify('cientochenta4.x= 3497')
//totales columna 8
dw.modify('tpan_col8_t.x= 3845')
dw.modify('tpan_col8.x= 3845')

dw.modify('docientosdiez.x= 3845')
dw.modify('docientosdiez1.x= 3845')
dw.modify('docientosdiez2.x= 3845')
dw.modify('docientosdiez3.x= 3845')
dw.modify('docientosdiez4.x= 3845')
//totales columna 9
dw.modify('tpan_col9_t.x= 4192')
dw.modify('tpan_col9.x= 4192')

dw.modify('docientoscuarenta.x= 4192')
dw.modify('docientoscuarenta1.x= 4192')
dw.modify('docientoscuarenta2.x= 4192')
dw.modify('docientoscuarenta3.x= 4192')
dw.modify('docientoscuarenta4.x= 4192')
//totales columna 10
dw.modify('tpan_col10_t.x= 4539')
dw.modify('tpan_col10.x= 4539')

dw.modify('docientosetenta.x= 4539')
dw.modify('docientosetenta1.x= 4539')
dw.modify('docientosetenta2.x= 4539')
dw.modify('docientosetenta3.x= 4539')
dw.modify('docientosetenta4.x= 4539')
//totales columna 11
dw.modify('tpan_col11_t.x= 4887')
dw.modify('tpan_col11.x= 4887')

dw.modify('trecientos.x= 4887')
dw.modify('trecientos1.x= 4887')
dw.modify('trecientos2.x= 4887')
dw.modify('trecientos3.x= 4887')
dw.modify('trecientos4.x= 4887')

//se mueve el campo de saldo total
dw.modify('tpan_col21_t.x= 5230')
dw.modify('tpan_col21.x= 5230')
dw.modify('total.x= 5230')		
dw.modify('total1.x= 5230')
dw.modify('total2.x= 5230')
dw.modify('total3.x= 5230')
dw.modify('total4.x= 5230')
//lineas de division
dw.modify('l_1.x2= 5573')
dw.modify('l_2.x2= 5573')
dw.modify('l_3.x2= 5573')
dw.modify('l_4.x2= 5573')
dw.modify('l_5.x2= 5573')
dw.modify('l_8.x2= 5573')
dw.modify('l_7.x2= 5573')
dw.modify('l_6.x2= 5573')
dw.modify('l_9.x2= 5573')
dw.modify('l_10.x2= 5573')		

//Títulos
dw.modify('dgagrupf_grup_descripcion.x= 1075')
dw.modify('empresanom.x= 1080')
dw.modify('titulo.x= 1075')
dw.modify('t_1.x= 1075')
dw.modify('r_1.x= 1002')

CASE 12//310
	
dw.modify('tpan_col13_t.visible= false')
dw.modify('tpan_col13.visible= false')
dw.modify('tpan_col14_t.visible= false')
dw.modify('tpan_col14.visible= false')
dw.modify('tpan_col15_t.visible= false')
dw.modify('tpan_col15.visible= false')
dw.modify('tpan_col16_t.visible= false')
dw.modify('tpan_col16.visible= false')

//TOTALES
wf_totales_invisibles(12)

//mover clumnas
//totales columna 4
dw.modify('tpan_col4_t.x=2455')
dw.modify('tpan_col4.x=2455')

dw.modify('noventa.x= 2455')
dw.modify('noventa1.x= 2455')
dw.modify('noventa2.x= 2455')
dw.modify('noventa3.x= 2455')
dw.modify('noventa4.x= 2455')
//totales columna 5
dw.modify('tpan_col5_t.x= 2802')
dw.modify('tpan_col5.x= 2802')
dw.modify('cientoveinte.x= 2802')
dw.modify('cientoveinte1.x= 2802')
dw.modify('cientoveinte2.x= 2802')
dw.modify('cientoveinte3.x= 2802')
dw.modify('cientoveinte4.x= 2802')	
//totales columna 6
dw.modify('tpan_col6_t.x= 3150')
dw.modify('tpan_col6.x= 3150')

dw.modify('cientocincuenta.x= 3150')
dw.modify('cientocincuenta1.x= 3150')
dw.modify('cientocincuenta2.x= 3150')
dw.modify('cientocincuenta3.x= 3150')
dw.modify('cientocincuenta4.x= 3150')
//totales columna 7
dw.modify('tpan_col7_t.x= 3497')
dw.modify('tpan_col7.x= 3497')

dw.modify('cientochenta.x= 3497')
dw.modify('cientochenta1.x= 3497')
dw.modify('cientochenta2.x= 3497')
dw.modify('cientochenta3.x= 3497')
dw.modify('cientochenta4.x= 3497')
//totales columna 8
dw.modify('tpan_col8_t.x= 3845')
dw.modify('tpan_col8.x= 3845')

dw.modify('docientosdiez.x= 3845')
dw.modify('docientosdiez1.x= 3845')
dw.modify('docientosdiez2.x= 3845')
dw.modify('docientosdiez3.x= 3845')
dw.modify('docientosdiez4.x= 3845')
//totales columna 9
dw.modify('tpan_col9_t.x= 4192')
dw.modify('tpan_col9.x= 4192')

dw.modify('docientoscuarenta.x= 4192')
dw.modify('docientoscuarenta1.x= 4192')
dw.modify('docientoscuarenta2.x= 4192')
dw.modify('docientoscuarenta3.x= 4192')
dw.modify('docientoscuarenta4.x= 4192')
//totales columna 10
dw.modify('tpan_col10_t.x= 4539')
dw.modify('tpan_col10.x= 4539')

dw.modify('docientosetenta.x= 4539')
dw.modify('docientosetenta1.x= 4539')
dw.modify('docientosetenta2.x= 4539')
dw.modify('docientosetenta3.x= 4539')
dw.modify('docientosetenta4.x= 4539')
//totales columna 11
dw.modify('tpan_col11_t.x= 4887')
dw.modify('tpan_col11.x= 4887')

dw.modify('trecientos.x= 4887')
dw.modify('trecientos1.x= 4887')
dw.modify('trecientos2.x= 4887')
dw.modify('trecientos3.x= 4887')
dw.modify('trecientos4.x= 4887')
//totales columna 12
dw.modify('tpan_col12_t.x= 5234')
dw.modify('tpan_col12.x= 5234')

dw.modify('trecientostreinta.x= 5234')
dw.modify('trecientostreinta1.x= 5234')
dw.modify('trecientostreinta2.x= 5234')
dw.modify('trecientostreinta3.x= 5234')
dw.modify('trecientostreinta4.x= 5234')

//se mueve el campo de saldo total
dw.modify('tpan_col21_t.x= 5577')
dw.modify('tpan_col21.x= 5577')
dw.modify('total.x= 5577')		
dw.modify('total1.x= 5577')
dw.modify('total2.x= 5577')
dw.modify('total3.x= 5577')
dw.modify('total4.x= 5577')
//lineas de division
dw.modify('l_1.x2= 5915')
dw.modify('l_2.x2= 5915')
dw.modify('l_3.x2= 5915')
dw.modify('l_4.x2= 5915')
dw.modify('l_5.x2= 5915')
dw.modify('l_8.x2= 5915')
dw.modify('l_7.x2= 5915')
dw.modify('l_6.x2= 5915')
dw.modify('l_9.x2= 5915')
dw.modify('l_10.x2= 5915')		

//Títulos
dw.modify('dgagrupf_grup_descripcion.x= 1075')
dw.modify('empresanom.x= 1080')
dw.modify('titulo.x= 1075')
dw.modify('t_1.x= 1075')
dw.modify('r_1.x= 1002')

case 13
dw.modify('tpan_col14_t.visible= false')
dw.modify('tpan_col14.visible= false')
dw.modify('tpan_col15_t.visible= false')
dw.modify('tpan_col15.visible= false')
dw.modify('tpan_col16_t.visible= false')
dw.modify('tpan_col16.visible= false')

//mover columnas
//totales columna 4
dw.modify('tpan_col4_t.x=2455')
dw.modify('tpan_col4.x=2455')

dw.modify('noventa.x= 2455')
dw.modify('noventa1.x= 2455')
dw.modify('noventa2.x= 2455')
dw.modify('noventa3.x= 2455')
dw.modify('noventa4.x= 2455')
//totales columna 5
dw.modify('tpan_col5_t.x= 2802')
dw.modify('tpan_col5.x= 2802')
dw.modify('cientoveinte.x= 2802')
dw.modify('cientoveinte1.x= 2802')
dw.modify('cientoveinte2.x= 2802')
dw.modify('cientoveinte3.x= 2802')
dw.modify('cientoveinte4.x= 2802')	
//totales columna 6
dw.modify('tpan_col6_t.x= 3150')
dw.modify('tpan_col6.x= 3150')

dw.modify('cientocincuenta.x= 3150')
dw.modify('cientocincuenta1.x= 3150')
dw.modify('cientocincuenta2.x= 3150')
dw.modify('cientocincuenta3.x= 3150')
dw.modify('cientocincuenta4.x= 3150')
//totales columna 7
dw.modify('tpan_col7_t.x= 3497')
dw.modify('tpan_col7.x= 3497')

dw.modify('cientochenta.x= 3497')
dw.modify('cientochenta1.x= 3497')
dw.modify('cientochenta2.x= 3497')
dw.modify('cientochenta3.x= 3497')
dw.modify('cientochenta4.x= 3497')
//totales columna 8
dw.modify('tpan_col8_t.x= 3845')
dw.modify('tpan_col8.x= 3845')

dw.modify('docientosdiez.x= 3845')
dw.modify('docientosdiez1.x= 3845')
dw.modify('docientosdiez2.x= 3845')
dw.modify('docientosdiez3.x= 3845')
dw.modify('docientosdiez4.x= 3845')
//totales columna 9
dw.modify('tpan_col9_t.x= 4192')
dw.modify('tpan_col9.x= 4192')

dw.modify('docientoscuarenta.x= 4192')
dw.modify('docientoscuarenta1.x= 4192')
dw.modify('docientoscuarenta2.x= 4192')
dw.modify('docientoscuarenta3.x= 4192')
dw.modify('docientoscuarenta4.x= 4192')
//totales columna 10
dw.modify('tpan_col10_t.x= 4539')
dw.modify('tpan_col10.x= 4539')

dw.modify('docientosetenta.x= 4539')
dw.modify('docientosetenta1.x= 4539')
dw.modify('docientosetenta2.x= 4539')
dw.modify('docientosetenta3.x= 4539')
dw.modify('docientosetenta4.x= 4539')
//totales columna 11
dw.modify('tpan_col11_t.x= 4887')
dw.modify('tpan_col11.x= 4887')

dw.modify('trecientos.x= 4887')
dw.modify('trecientos1.x= 4887')
dw.modify('trecientos2.x= 4887')
dw.modify('trecientos3.x= 4887')
dw.modify('trecientos4.x= 4887')
//totales columna 12
dw.modify('tpan_col12_t.x= 5234')
dw.modify('tpan_col12.x= 5234')

dw.modify('trecientostreinta.x= 5234')
dw.modify('trecientostreinta1.x= 5234')
dw.modify('trecientostreinta2.x= 5234')
dw.modify('trecientostreinta3.x= 5234')
dw.modify('trecientostreinta4.x= 5234')
//totales columna 13
dw.modify('tpan_col13_t.x= 5582')
dw.modify('tpan_col13.x= 5582')

dw.modify('trecientosesenta.x= 5582')
dw.modify('trecientosesenta1.x= 5582')
dw.modify('trecientosesenta2.x= 5582')
dw.modify('trecientosesenta3.x= 5582')
dw.modify('trecientosesenta4.x= 5582')

dw.modify('trecientosetenta.x= 5582')
dw.modify('trecientosetenta1.x= 5582')
dw.modify('trecientosetenta2.x= 5582')
dw.modify('trecientosetenta3.x= 5582')
dw.modify('trecientosetenta4.x= 5582')


//totales
dw.modify('tpan_col21_t.x= 5929') 
dw.modify('tpan_col21.x= 5929')
//totales columna 21
dw.modify('total.x=5929')
dw.modify('total1.x=5929')
dw.modify('total2.x=5929')
dw.modify('total3.x=5929')
dw.modify('total4.x=5929')
//lineas de division
dw.modify('l_1.x2= 6267')
dw.modify('l_2.x2= 6267')
dw.modify('l_3.x2= 6267')
dw.modify('l_4.x2= 6267')
dw.modify('l_5.x2= 6267')
dw.modify('l_8.x2= 6267')
dw.modify('l_7.x2= 6267')
dw.modify('l_6.x2= 6267')
dw.modify('l_9.x2= 6267')
dw.modify('l_10.x2= 6267')		

//Títulos
dw.modify('dgagrupf_grup_descripcion.x= 1075')
dw.modify('empresanom.x= 1080')
dw.modify('titulo.x= 1075')
dw.modify('t_1.x= 1075')
dw.modify('r_1.x= 1002')

case 14

dw.modify('tpan_col15_t.visible= false')
dw.modify('tpan_col15.visible= false')
dw.modify('tpan_col16_t.visible= false')
dw.modify('tpan_col16.visible= false')

//mover columnas
//totales columna 4
dw.modify('tpan_col4_t.x=2455')
dw.modify('tpan_col4.x=2455')

dw.modify('noventa.x= 2455')
dw.modify('noventa1.x= 2455')
dw.modify('noventa2.x= 2455')
dw.modify('noventa3.x= 2455')
dw.modify('noventa4.x= 2455')
//totales columna 5
dw.modify('tpan_col5_t.x= 2802')
dw.modify('tpan_col5.x= 2802')
dw.modify('cientoveinte.x= 2802')
dw.modify('cientoveinte1.x= 2802')
dw.modify('cientoveinte2.x= 2802')
dw.modify('cientoveinte3.x= 2802')
dw.modify('cientoveinte4.x= 2802')	
//totales columna 6
dw.modify('tpan_col6_t.x= 3150')
dw.modify('tpan_col6.x= 3150')

dw.modify('cientocincuenta.x= 3150')
dw.modify('cientocincuenta1.x= 3150')
dw.modify('cientocincuenta2.x= 3150')
dw.modify('cientocincuenta3.x= 3150')
dw.modify('cientocincuenta4.x= 3150')
//totales columna 7
dw.modify('tpan_col7_t.x= 3497')
dw.modify('tpan_col7.x= 3497')

dw.modify('cientochenta.x= 3497')
dw.modify('cientochenta1.x= 3497')
dw.modify('cientochenta2.x= 3497')
dw.modify('cientochenta3.x= 3497')
dw.modify('cientochenta4.x= 3497')
//totales columna 8
dw.modify('tpan_col8_t.x= 3845')
dw.modify('tpan_col8.x= 3845')

dw.modify('docientosdiez.x= 3845')
dw.modify('docientosdiez1.x= 3845')
dw.modify('docientosdiez2.x= 3845')
dw.modify('docientosdiez3.x= 3845')
dw.modify('docientosdiez4.x= 3845')
//totales columna 9
dw.modify('tpan_col9_t.x= 4192')
dw.modify('tpan_col9.x= 4192')

dw.modify('docientoscuarenta.x= 4192')
dw.modify('docientoscuarenta1.x= 4192')
dw.modify('docientoscuarenta2.x= 4192')
dw.modify('docientoscuarenta3.x= 4192')
dw.modify('docientoscuarenta4.x= 4192')
//totales columna 10
dw.modify('tpan_col10_t.x= 4539')
dw.modify('tpan_col10.x= 4539')

dw.modify('docientosetenta.x= 4539')
dw.modify('docientosetenta1.x= 4539')
dw.modify('docientosetenta2.x= 4539')
dw.modify('docientosetenta3.x= 4539')
dw.modify('docientosetenta4.x= 4539')
//totales columna 11
dw.modify('tpan_col11_t.x= 4887')
dw.modify('tpan_col11.x= 4887')

dw.modify('trecientos.x= 4887')
dw.modify('trecientos1.x= 4887')
dw.modify('trecientos2.x= 4887')
dw.modify('trecientos3.x= 4887')
dw.modify('trecientos4.x= 4887')
//totales columna 12
dw.modify('tpan_col12_t.x= 5234')
dw.modify('tpan_col12.x= 5234')

dw.modify('trecientostreinta.x= 5234')
dw.modify('trecientostreinta1.x= 5234')
dw.modify('trecientostreinta2.x= 5234')
dw.modify('trecientostreinta3.x= 5234')
dw.modify('trecientostreinta4.x= 5234')
//totales columna 13
dw.modify('tpan_col13_t.x= 5582')
dw.modify('tpan_col13.x= 5582')

dw.modify('trecientosetenta.x= 5582')
dw.modify('trecientosetenta1.x= 5582')
dw.modify('trecientosetenta2.x= 5582')
dw.modify('trecientosetenta3.x= 5582')
dw.modify('trecientosetenta4.x= 5582')

//totales columna 14
dw.modify('tpan_col14_t.x= 5930')
dw.modify('tpan_col14.x= 5930')
dw.modify('trecientonoventa.x= 5930')
dw.modify('trecientonoventa1.x= 5930')
dw.modify('trecientonoventa2.x= 5930')
dw.modify('trecientonoventa3.x= 5930')
dw.modify('trecientonoventa4.x= 5930')

//totales
dw.modify('tpan_col21_t.x= 6277') 
dw.modify('tpan_col21.x= 6277')
//totales columna 21
dw.modify('total.x=6277')
dw.modify('total1.x=6277')
dw.modify('total2.x=6277')
dw.modify('total3.x=6277')
dw.modify('total4.x=6277')
//lineas de division
dw.modify('l_1.x2= 6615')
dw.modify('l_2.x2= 6615')
dw.modify('l_3.x2= 6615')
dw.modify('l_4.x2= 6615')
dw.modify('l_5.x2= 6615')
dw.modify('l_8.x2= 6615')
dw.modify('l_7.x2= 6615')
dw.modify('l_6.x2= 6615')
dw.modify('l_9.x2= 6615')
dw.modify('l_10.x2= 6615')		

//Títulos
dw.modify('dgagrupf_grup_descripcion.x= 1075')
dw.modify('empresanom.x= 1080')
dw.modify('titulo.x= 1075')
dw.modify('t_1.x= 1075')
dw.modify('r_1.x= 1002')


END CHOOSE

if dw.describe("alias.x") <> '!' and dw.describe("alias.x") <> '?' then 
	dw.modify('alias.x=' +dw.describe('t_1.x')  )
end if 
end subroutine

on w_inf_cc_antiguedad.create
int iCurrent
call super::create
if this.MenuName = "m_cc_principal_listados" then this.MenuID = create m_cc_principal_listados
this.cb_1=create cb_1
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.dw_cc_inf_antigc2=create dw_cc_inf_antigc2
this.dw_cc_inf_antigc3=create dw_cc_inf_antigc3
this.st_3=create st_3
this.st_4=create st_4
this.st_2=create st_2
this.cbx_1=create cbx_1
this.ddlb_2=create ddlb_2
this.st_5=create st_5
this.ddlb_3=create ddlb_3
this.st_6=create st_6
this.em_1=create em_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cbx_por_pais=create cbx_por_pais
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.ddlb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_cc_inf_antigc2
this.Control[iCurrent+5]=this.dw_cc_inf_antigc3
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.cbx_1
this.Control[iCurrent+10]=this.ddlb_2
this.Control[iCurrent+11]=this.st_5
this.Control[iCurrent+12]=this.ddlb_3
this.Control[iCurrent+13]=this.st_6
this.Control[iCurrent+14]=this.em_1
this.Control[iCurrent+15]=this.dw_2
this.Control[iCurrent+16]=this.dw_3
this.Control[iCurrent+17]=this.cbx_por_pais
this.Control[iCurrent+18]=this.dw_4
end on

on w_inf_cc_antiguedad.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.dw_cc_inf_antigc2)
destroy(this.dw_cc_inf_antigc3)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.cbx_1)
destroy(this.ddlb_2)
destroy(this.st_5)
destroy(this.ddlb_3)
destroy(this.st_6)
destroy(this.em_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cbx_por_pais)
destroy(this.dw_4)
end on

event resize;//OVERRIDE
this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 350
gb_1.width  = this.width  - 60
gb_1.height = this.height - 233


st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 175
this.SetRedraw(true)
end event

event ue_post_open;call super::ue_post_open;datetime	ld_date
string	ls_mensaje, ls_empre, ls_fecha, ls_hora, ls_porcentaje, ls_error, ls_filter
integer	li_reg,li_antiguedad, li_pais

//str.frame.setredraw(false)
istr_rangfech = Message.PowerObjectParm
//cbx_1.visible = false
datawindowchild ldwc_tipo
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_3.insertrow(1)
dw_3.setitem(1,'tipo',0)
dw_2.getchild('tipo',ldwc_tipo)
ldwc_tipo.settransobject(sqlca)
ldwc_tipo.retrieve(str.g_financiero, str.empresa)
ldwc_tipo.insertrow(1)
ldwc_tipo.setitem(1,'tpcli_codigo',99)
ldwc_tipo.setitem(1,'tpcli_descripcion','VER TODOS')
dw_2.insertrow(1)
dw_2.setitem(1,'tipo',99)


SELECT isnull(para_para_antig_fact,'SI'),isnull(ccmparam.para_antiguedad_pais,'R'),
		 isnull(ccmparam.para_cambio_pais_region,'N')
INTO :ls_porcentaje,:is_pais, :is_pais_region
FROM ccmparam
WHERE ( para_g_financiero = :str.g_financiero ) and
		( para_empresa = :str.empresa );

if sqlca.sqlcode = -1 then
	ls_error = sqlca.sqlerrtext
	rollback;
	gf_mensaje('Error','Descripción: '+ls_error,1,1,'E')
	return
end if

SELECT count(*)
INTO :li_reg
FROM ccaantig
WHERE ( ccan_g_financiero = :str.g_financiero ) and
      ( ccan_empresa = :str.empresa ) and
	 ( ccan_codigo = :istr_rangfech.tipo_antiguedad )	;

if sqlca.sqlcode = -1 then
	ls_error = sqlca.sqlerrtext
	rollback;
	mensaje('Error','Descripción: ',ls_error)
	return
end if


ld_date    = datetime(istr_rangfech.fecha2,00:00:00)
ls_mensaje = 'Al '+gf_fecha_palabras(date(ld_date))

if isnull(istr_rangfech.ceros) then istr_rangfech.ceros = 'N'//con 

//Cambia el datawindow Object dependiendo del caso
if istr_rangfech.op_vende = 'A' then
	dw.dataobject = 'dw_cc_inf_antigclientes_resumido_pais'//resumido
elseif istr_rangfech.op_vende = 'E' then
	dw.dataobject = 'dw_cc_inf_antiguedad_resumido_region'//resumido
elseif istr_rangfech.op_vende = 'V'then
	dw.dataobject = 'dw_cc_inf_antigvendedor_conceros_cte'//vendedores
elseif istr_rangfech.op_vende = 'P' then//por pais
//	cbx_1.visible = true
	if is_pais = 'P' then //parametro como mostrar reporte de pais
		dw.dataobject = 'dw_cc_inf_antigclientes_pais_solo'//solo el pais
	else
		cbx_por_pais.visible = true
		dw_4.visible = true
		dw.dataobject = 'dw_cc_inf_antigclientes_conceros_cte_sr'//normal PAIS
	end if
else
	//dw.dataobject = 'dw_cc_inf_antigclientes_conceros_cte_sr'//normal
	dw.dataobject = 'dw_cc_inf_antigclientes_total'				  //TODOS
end if

dw.settransobject(sqlca)
if dw.retrieve(str.g_financiero,str.empresa, str.maquina) = 0 then
	str.frame.setredraw(true)
	this.postevent('close')
	return
end if

//Si es por pais recupera las regiones para filtrar
if istr_rangfech.op_vende = 'P' then//por pais
	li_pais = dw_1.getitemnumber(1,'dgapais_pais_pais')
	dw_4.getchild('region',idwc_region)
	idwc_region.settransobject(sqlca)
	idwc_region.retrieve(li_pais)
	dw_4.insertrow(1)
end if

//Llama la funcion para poner invisible las columnas
wf_columnas_visibles()
//************  *************  ***************  ***************  *********** ********
// Reporte Ordenado por cliente
// Controla que muestre los ceros o no en el reporte

if istr_rangfech.ceros = 'N' then//ceros o no
	dw.object.ceros.expression = "'"+'N'+"'"

	if ls_porcentaje <> 'SI' then//porcentaje
		dw.object.porcentaje.expression = "'"+'N'+"'"
		if is_pais = 'P' and istr_rangfech.op_vende = 'P' then
			//dw.dataobject = 'dw_cc_inf_antigclientes_sinceros_cte_sr'
		else
			//dw.dataobject = 'dw_cc_inf_antigclientes_sinceros_cte'
			
		end if
	else
		dw.object.porcentaje.expression = "'"+'S'+"'"
		if is_pais = 'P' and istr_rangfech.op_vende = 'P' then//solo pais 
			//dw.dataobject = 'dw_cc_antiguiedad_per' //PRUEBA DW SIN CROSSTAB
			//dw.dataobject = 'dw_cc_inf_antigclientes_sinceros_por_sr'
		else
			//dw.dataobject = 'dw_cc_inf_antigclientes_sinceros_porcent'//porcentaje con region
		end if
	end if
else
	dw.object.ceros.expression = "'"+'S'+"'"
	if ls_porcentaje <> 'SI' then//sin porcentaje
		dw.object.porcentaje.expression = "'"+'N'+"'"
		if is_pais = 'P' and istr_rangfech.op_vende = 'P' then//solo pais 
			//dw.dataobject = 'dw_cc_inf_antigclientes_conceros_cte_sr'//sin region
		else
			//dw.dataobject = 'dw_cc_inf_antigclientes_conceros_cte'
		end if
	else
		dw.object.porcentaje.expression = "'"+'S'+"'"
		//dw.dataobject = 'dw_cc_inf_antigclientes_porcentaje'
	end if
end if
//end if
//---------------orden de reportes airsea------------------//

if istr_rangfech.op_vende = 'C' and istr_rangfech.opcion_reporte = 'A' and ls_porcentaje <> 'SI' then
	dw.object.porcentaje.expression = "'"+'N'+"'"
	if istr_rangfech.ceros= 'N' then
		dw.object.ceros.expression = "'"+'N'+"'"
		//dw.dataobject = 'dw_cc_inf_antigclientes_sinceros_cte_alf'
	else
		dw.object.ceros.expression = "'"+'S'+"'"
		//dw.dataobject = 'dw_cc_inf_antigclientes_conceros_cte_alf'
	end if
elseif istr_rangfech.op_vende = 'C' and istr_rangfech.opcion_reporte = 'A' and ls_porcentaje = 'SI' then 		
	dw.object.porcentaje.expression = "'"+'S'+"'"
	if istr_rangfech.ceros= 'N' then
		dw.object.ceros.expression = "'"+'N'+"'"
		//dw.dataobject = 'dw_cc_inf_antigclientes_sc_cte_alf_por'
	else
		dw.object.ceros.expression = "'"+'S'+"'"
		//dw.dataobject = 'dw_cc_inf_antigclientes_cc_cte_alf_por'
	end if
	
elseif istr_rangfech.op_vende = 'C' and istr_rangfech.opcion_reporte = 'C' and ls_porcentaje <> 'SI'  then
	dw.object.porcentaje.expression = "'"+'N'+"'"
	if istr_rangfech.ceros= 'N' then
		dw.object.ceros.expression = "'"+'N'+"'"
		if is_pais = 'P' and istr_rangfech.op_vende = 'P' then//solo pais
			//dw.dataobject = 'dw_cc_inf_antigclientes_sinceros_cte_sr'
		else
			//dw.dataobject = 'dw_cc_inf_antigclientes_sinceros_cte'
		end if
	else
		dw.object.ceros.expression = "'"+'S'+"'"
		if is_pais = 'P' and istr_rangfech.op_vende = 'P' then//solo pais
			//dw.dataobject = 'dw_cc_inf_antigclientes_conceros_cte_sr'
		else
			//dw.dataobject = 'dw_cc_inf_antigclientes_conceros_cte'
		end if
	end if
	
elseif istr_rangfech.op_vende = 'C' and istr_rangfech.opcion_reporte = 'C' and ls_porcentaje = 'SI'  then
	dw.object.porcentaje.expression = "'"+'S'+"'"
	if istr_rangfech.ceros = 'N' then
		dw.object.ceros.expression = "'"+'N'+"'"
		if is_pais = 'P' and istr_rangfech.op_vende = 'P' then//solo pais 
			//dw.dataobject = 'dw_cc_inf_antigclientes_sinceros_por_sr'
		else
			//dw.dataobject = 'dw_cc_inf_antigclientes_sinceros_porcent'
		end if	
	else//conceros y porcentaje
		dw.object.ceros.expression = "'"+'S'+"'"
		//dw.dataobject = 'dw_cc_inf_antigclientes_porcentaje'
	end if
elseif istr_rangfech.op_vende = 'C' and istr_rangfech.opcion_reporte = 'R' and ls_porcentaje <> 'SI' then 	
	dw.object.porcentaje.expression = "'"+'N'+"'"
	if istr_rangfech.ceros= 'N' then
		dw.object.ceros.expression = "'"+'N'+"'"
	else
		dw.object.ceros.expression = "'"+'S'+"'"
	end if
elseif istr_rangfech.op_vende = 'C' and istr_rangfech.opcion_reporte = 'R' and ls_porcentaje = 'SI' then 			
	dw.object.porcentaje.expression = "'"+'S'+"'"
	if istr_rangfech.ceros= 'N' then
		dw.object.ceros.expression = "'"+'N'+"'"
	else
		dw.object.ceros.expression = "'"+'S'+"'"
		
	end if
end if

if istr_rangfech.op_vende = 'V' and istr_rangfech.ceros <> 'N' and ls_porcentaje <> 'SI' then 
	dw.object.porcentaje.expression = "'"+'N'+"'"
	dw.object.ceros.expression = "'"+'S'+"'"	
	
elseif istr_rangfech.op_vende = 'V' and istr_rangfech.ceros = 'N'  and ls_porcentaje <> 'SI' then
	dw.object.porcentaje.expression = "'"+'N'+"'"
	dw.object.ceros.expression = "'"+'N'+"'"	
	
elseif istr_rangfech.op_vende = 'V' and istr_rangfech.ceros <> 'N' and ls_porcentaje = 'SI' then 
	dw.object.porcentaje.expression = "'"+'S'+"'"
	dw.object.ceros.expression = "'"+'S'+"'"	
	
elseif istr_rangfech.op_vende = 'V' and istr_rangfech.ceros = 'N' and ls_porcentaje = 'SI' then 
	dw.object.porcentaje.expression = "'"+'S'+"'"
	dw.object.ceros.expression = "'"+'N'+"'"	
	
end if


// Modificado por Gianni Araúz (27/12/2000). Tamaño y Orientación de Página de de los
// reportes de Resumido por País y País-Región.
if istr_rangfech.op_vende = 'A' or istr_rangfech.op_vende = 'E' then
	choose case li_reg
		case 1 to 6
			dw_1.Modify("DataWindow.Print.paper.size = '1'")
			dw_1.Modify("DataWindow.Print.Orientation = '2'")
		case 7 to 9
			dw_1.Modify("DataWindow.Print.paper.size = '1'")
			dw_1.Modify("DataWindow.Print.Orientation = '1'")
		case else
			dw_1.Modify("DataWindow.Print.paper.size = '5'")
			dw_1.Modify("DataWindow.Print.Orientation = '1'")
	end choose
else
	choose case li_reg
		case 1 to 5
			dw_1.Modify("DataWindow.Print.paper.size = '1'")
		   dw_1.Modify("DataWindow.Print.Orientation = '2'")
		case 6 to 8
			dw_1.Modify("DataWindow.Print.Orientation = '1'")
			dw_1.Modify("DataWindow.Print.paper.size = '4'")
		case else
			dw_1.Modify("DataWindow.Print.Orientation = '1'")
			dw_1.Modify("DataWindow.Print.paper.size = '5'")
	end choose

end if


if dw.rowcount() > 0 then
	ls_empre = gf_dg_nombre_empresa()
	
	dw_1.object.empresanom.expression = "'"+ls_empre+"'"
	dw_1.object.titulo.expression = "'"+ls_mensaje+"'"
	dw_1.object.porcentaje.expression = "'"+ls_porcentaje+"'"
	dw_1.object.pais_regiont.expression = "'"+is_pais_region+"'"
	
	// Incluido el 25/07/2000 por RM
	ls_fecha = 'FECHA:'  + " " +string(gf_fecha_serv(),'dd/mmm/yyyy')
	if dw_1.describe("fecha.x") <> "?" and dw_1.describe("fecha.x") <> "!" then &
		dw_1.object.fecha.expression = "'"+ls_fecha+"'"
	
	ls_hora = 'HORA:' + " " +string(time(gf_fecha_serv()),'hh:mm:ss AM/PM')	// Gianni (27/12/2000). Se incluyó formato de hora.
	if dw_1.describe("hora.x") <> "?" and dw_1.describe("hora.x") <> "!" then &
		dw_1.object.hora.expression = "'"+ls_hora+"'"
end if
//Irving Aguilar 3 de Septiembre de 2004
If istr_rangfech.aliasempresa then
	if dw.describe("c_alias.x") <> '!' and dw.describe("c_alias.x") <> '?' then &
	dw.modify("c_alias.Expression='1'")
else
	if dw.describe("c_alias.x") <> '!' and dw.describe("c_alias.x") <> '?' then &
	dw.modify("c_alias.Expression='0'")
end if	
//Irving Aguilar 3 de Septiembre de 2004
//messagebox("Pase",dw.dataobject)

ls_filter = 'clie_clasificacion <> 4'
dw_1.setfilter(ls_filter)
dw_1.filter()
dw_1.groupcalc()

dw.Object.datawindow.print.preview = true
//dw.Object.DataWindow.Print.Preview.Rulers='Yes'
str.frame.setredraw(true)
end event

event ue_reg_anterior;dw.ScrollPriorPage( )
end event

event ue_siguiente_reg;dw.scrollNextpage()
end event

event ue_sort;string ls_orden
setnull(ls_orden)
dw_1.setsort(ls_orden)
dw_1.sort()
end event

event ue_zoom;// Programación utilizada para las vistas previas en el reportes de PowerBuilder

opensheetwithparm(w_zoom,dw_1,this,1,original!)

end event

event key;call super::key;
if key = keyenter! then

	if getfocus().typeof() = commandbutton! then getfocus().triggerevent(clicked!)
end if

end event

type st_ayuda from w_cc_padre_reporte`st_ayuda within w_inf_cc_antiguedad
end type

type st_nom_ventana from w_cc_padre_reporte`st_nom_ventana within w_inf_cc_antiguedad
boolean visible = false
integer y = 1384
integer width = 73
end type

type dw_1 from w_cc_padre_reporte`dw_1 within w_inf_cc_antiguedad
event ue_down pbm_keydown
integer x = 32
integer y = 200
integer width = 3680
integer height = 1140
integer taborder = 70
string dataobject = "dw_cc_inf_antigclientes_total"
end type

event dw_1::ue_down;
string	ls_clase, ls_dw='', ls_columna='', ls_columna1=''
	  
if keydown(keycontrol!) and keydown(keyN!) then
	ls_dw = this.DataObject
	Clipboard(ls_dw)
	ls_columna = GetColumnName()
	ls_columna1 = describe('#'+string(GetColumn())+'.dbname')
	if isnull(ls_columna) or trim(ls_columna) = '' then return
	if isnull(ls_columna1) or trim(ls_columna1) = '' then return
	if trim(ls_columna) = trim(ls_columna1) then
		MessageBox('NOMBRE DEL DATAWINDOW: '+ls_dw,'NOMBRE DE LA COLUMNA: '+ls_columna,&
			Information!)
	else
		MessageBox('NOMBRE DEL DATAWINDOW: '+ls_dw,'NOMBRE DE LA COLUMNA: '+ls_columna+&
					'~nNOMBRE EN LA BASE DE DATOS: '+ls_columna1)
	end if
end if


if keydown(keycontrol!) and keydown(keyM!) then
	ls_dw = this.DataObject
//	if isnull(ls_dw) or trim(ls_dw) = '' then return
	MessageBox('Usuario: '+str.usuario,'NOMBRE DEL DATAWINDOW: '+ls_dw,Information!)
end if

end event

event dw_1::clicked;string ls_column
ls_column = dwo.name
if ls_column = 'dgmterce_terc_descripcion' then
	str_cc_formatos str_formato1		
	str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	str_formato1.tercero = dw_1.getitemNumber(row,"tpan_tercero")
	Opensheetwithparm(w_estadocuenta,str_formato1,str.frame,2,original!)
	
elseif ls_column = 'ccmclien_clie_ref_anterior' then
	str_cc_formatos str_formato2		
	str_formato2.tercero = dw_1.getitemnumber(row,'tpan_tercero')
	OpenSheetwithparm(w_mant_clientes,str_formato2,parent,2, Original!)
end if
end event

event dw_1::doubleclicked;//OverRide
string         ls_pointer
datetime       ldt_fecha1
long           li_fila
window		   lw_child

ls_pointer = dw_1.GetObjectAtPointer()
li_fila = integer(trim(mid(ls_pointer,27)))

ls_pointer = Left(ls_pointer,  Pos(ls_pointer, "~t") - 1)

if pos(ls_pointer,'ccmclien_clie_ref_anterior') > 0 and right(ls_pointer,27) <> '_t'  then 
		istr_rangfech.cadena = 'Factura'
		istr_rangfech.desdecliente  = dw_1.getitemnumber(li_fila,'tpan_tercero')
		istr_rangfech.hastacliente  = dw_1.getitemnumber(li_fila,'tpan_tercero')
	   OpenSheetWithParm(lw_child,istr_rangfech,"w_cc_co_cliente_especifico",str.frame,11,Original!)
end if


end event

event dw_1::ue_microayuda;//override
//override
//Para cuando pasa por encima del objeto
//Override
return

end event

type gb_1 from w_cc_padre_reporte`gb_1 within w_inf_cc_antiguedad
integer x = 9
integer y = 148
integer width = 3735
integer height = 1212
integer taborder = 0
long backcolor = 12639424
end type

type cb_1 from commandbutton within w_inf_cc_antiguedad
boolean visible = false
integer x = 978
integer y = 172
integer width = 270
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ordenar"
end type

event clicked;//dw_1.object.datawindow.print.preview.rulers = 'yes'

end event

event constructor;this.visible = false
end event

type ddlb_1 from dropdownlistbox within w_inf_cc_antiguedad
integer x = 462
integer y = 24
integer width = 434
integer height = 328
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
string text = "none"
boolean vscrollbar = true
string item[] = {"8 1/2 X 11 in","8 1/2 X 14 in","Default(0)"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;dw_1.accepttext()
if index = 1 then
	dw_1.modify("Datawindow.print.paper.size = '1'")
elseif index = 2 then
	dw_1.modify("Datawindow.print.paper.size = '5'")
else
	dw_1.modify("Datawindow.print.paper.size = '0'")
end if

end event

type st_1 from statictext within w_inf_cc_antiguedad
integer x = 41
integer y = 40
integer width = 398
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Tamaño Página:"
boolean focusrectangle = false
end type

type dw_cc_inf_antigc2 from commandbutton within w_inf_cc_antiguedad
boolean visible = false
integer x = 800
integer y = 156
integer width = 160
integer height = 76
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;// Gianni Araúz (27/12/2000)
// Aumentar la visual de los nested reports (el ancho de los datawindows control).

long	ll_width

ll_width = long(dw_1.object.dw_1.width) + 75

dw_1.object.dw_1.width = string(ll_width)

ll_width = long(dw_1.object.dw_1.width)

ll_width = long(dw_1.object.dw_1.object.dw_1.width) + 75

dw_1.object.dw_1.object.dw_1.width = string(ll_width)

ll_width = long(dw_1.object.dw_1.object.dw_1.width)



end event

type dw_cc_inf_antigc3 from commandbutton within w_inf_cc_antiguedad
boolean visible = false
integer x = 603
integer y = 156
integer width = 160
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<<"
end type

event clicked;// Gianni Araúz (27/12/2000)
// Disminuir la visual de los nested reports (el ancho de los datawindows control).

long	ll_width

ll_width = long(dw_1.object.dw_1.width) - 75

dw_1.object.dw_1.width = string(ll_width)

ll_width = long(dw_1.object.dw_1.width)

ll_width = long(dw_1.object.dw_1.object.dw_1.width) - 75

dw_1.object.dw_1.object.dw_1.width = string(ll_width)

ll_width = long(dw_1.object.dw_1.object.dw_1.width)

end event

type st_3 from statictext within w_inf_cc_antiguedad
boolean visible = false
integer y = 148
integer width = 183
integer height = 88
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_4 from statictext within w_inf_cc_antiguedad
boolean visible = false
integer x = 197
integer y = 148
integer width = 183
integer height = 88
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within w_inf_cc_antiguedad
boolean visible = false
integer x = 411
integer y = 164
integer width = 169
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 78682240
string text = "Visual:"
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_inf_cc_antiguedad
boolean visible = false
integer x = 1490
integer y = 164
integer width = 594
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Totales por Región"
boolean checked = true
end type

event clicked;if this.checked = true then
	dw_1.Modify("DataWindow.Trailer.2.Height=96")
	dw_1.SetSort('dgapais_pais_descripcion A, dgaregio_regi_descripcion A,ccmclien_clie_ref_anterior A' )
	dw_1.Sort()
else
	dw_1.Modify("DataWindow.Trailer.2.Height=2")
	dw_1.SetSort('dgapais_pais_descripcion A, ccmclien_clie_ref_anterior A' )
	dw_1.Sort()
end if

dw_1.groupcalc()

end event

type ddlb_2 from dropdownlistbox within w_inf_cc_antiguedad
integer x = 1961
integer y = 16
integer width = 215
integer height = 532
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean allowedit = true
boolean sorted = false
string item[] = {"50%","75%","80%","85%","90%","95%","100%"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//dw_1.accepttext()
if index = 1 then
	dw_1.Object.datawindow.zoom = 50
elseif index = 2 then
	dw_1.Object.datawindow.zoom = 75
elseif index = 3 then
	dw_1.Object.datawindow.zoom = 80
elseif index = 4 then
	dw_1.Object.datawindow.zoom = 85
elseif index = 5 then
	dw_1.Object.datawindow.zoom = 90
elseif index = 6 then
	dw_1.Object.datawindow.zoom = 95
elseif index = 7 then
	dw_1.Object.datawindow.zoom = 100
	
end if
end event

event modified;long ll_zoom
if mid(this.text,len(this.text) - 1,1) = '%' then
	ll_zoom = long(mid(this.text,1,len(this.text) - 1))
else
	ll_zoom = long(this.text)
end if
dw_1.Object.datawindow.zoom = ll_zoom
end event

type st_5 from statictext within w_inf_cc_antiguedad
integer x = 1723
integer y = 36
integer width = 224
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Tamaño:"
boolean focusrectangle = false
end type

type ddlb_3 from dropdownlistbox within w_inf_cc_antiguedad
integer x = 1266
integer y = 28
integer width = 425
integer height = 352
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
string item[] = {"Vertical","Horizontal"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string	ls_empre, ls_mensaje, ls_fecha, ls_hora
datetime	ld_date
integer	li_reg

ld_date = datetime(istr_rangfech.fecha2,00:00:00)
ls_mensaje = 'Al '+gf_fecha_palabras(date(ld_date))

if index = 1 then
	dw_1.modify("Datawindow.print.orientation = '1'")
elseif index = 2 then
	dw_1.modify("Datawindow.print.orientation = '2'")
	//dw_1.modify("Datawindow.print.paper.size  = '5'")
end if

ls_empre = gf_dg_nombre_empresa()
dw_1.object.empresanom.expression = "'"+ls_empre+"'"
dw_1.object.titulo.expression = "'" + ls_mensaje+"'"

// Incluido el 25/07/2000 por RM
ls_fecha = 'FECHA :' + " " +string(gf_fecha_serv(),'dd/mmm/yyyy')
if dw_1.describe("fecha.x") <> "?" and dw_1.describe("fecha.x") <> "!" then &
	dw_1.object.fecha.expression = "'"+ls_fecha+"'"

ls_hora = 'HORA :' + " " +string(time(gf_fecha_serv()),'hh:mm:ss AM/PM')	// Gianni (27/12/2000). Se incluyó formato de hora.
if dw_1.describe("hora.x") <> "?" and dw_1.describe("hora.x") <> "!" then &
	dw_1.object.hora.expression = "'"+ls_hora+"'"

end event

type st_6 from statictext within w_inf_cc_antiguedad
integer x = 946
integer y = 40
integer width = 315
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Orientación:"
boolean focusrectangle = false
end type

type em_1 from editmask within w_inf_cc_antiguedad
boolean visible = false
integer x = 1275
integer y = 156
integer width = 183
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

event modified;long ll_tam
ll_tam = long(em_1.text)
dw_1.accepttext()
dw_1.Object.datawindow.zoom = ll_tam
end event

type dw_2 from datawindow within w_inf_cc_antiguedad
integer x = 4498
integer y = 16
integer width = 1143
integer height = 96
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_tipo"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_filter
integer li_tipo_cli, li_tipo, li_region
dw_3.accepttext()
dw_2.accepttext()

li_region = dw_4.getitemnumber(1,'region')
li_tipo_cli = integer(data)

if li_tipo_cli = 99 then
	ls_filter = 'clie_clasificacion <> 4'
else
	ls_filter = 'clie_clasificacion = '+string(li_tipo_cli)
end if

if li_region > 0 then
	ls_filter = ls_filter + ' and dgaregio_regi_codigo_region = '+string(li_region)
end if

li_tipo = dw_3.getitemnumber(1,'tipo')

choose case li_tipo
	case 1 
		ls_filter = ls_filter + ' and tpan_col2 > 0'
	case 2 
		ls_filter = ls_filter + ' and tpan_col3 > 0'
	case 3 
		ls_filter = ls_filter + ' and tpan_col4 > 0'
	case 4 
		ls_filter = ls_filter + ' and tpan_col5 > 0'
	case 5 
		ls_filter = ls_filter + ' and tpan_col6 > 0'
	case 6 
		ls_filter = ls_filter + ' and tpan_col7 > 0'
	case 7 
		ls_filter = ls_filter + ' and tpan_col8 > 0'
	case 8 
		ls_filter = ls_filter + ' and tpan_col9 > 0'
end choose

dw_1.setfilter(ls_filter)
dw_1.filter()
dw_1.groupcalc()
end event

type dw_3 from datawindow within w_inf_cc_antiguedad
integer x = 2194
integer y = 20
integer width = 965
integer height = 96
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_morosidad"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_filter
integer li_tipo, li_tipo_cli

li_tipo = integer(data)

choose case li_tipo
	case 0 
		ls_filter = ''
	case 1 
		ls_filter = 'tpan_col2 > 0 or tpan_col3 > 0 or tpan_col4 > 0 or tpan_col5 > 0 or tpan_col6 > 0 or tpan_col7 > 0 or tpan_col8 > 0 or tpan_col9 > 0 or tpan_col10 > 0 or tpan_col11 > 0'
	case 2 
		ls_filter = 'tpan_col3 > 0 or tpan_col4 > 0 or tpan_col5 > 0 or tpan_col6 > 0 or tpan_col7 > 0 or tpan_col8 > 0 or tpan_col9 > 0 or tpan_col10 > 0 or tpan_col11 > 0'
	case 3 
		ls_filter = 'tpan_col4 > 0 or tpan_col5 > 0 or tpan_col6 > 0 or tpan_col7 > 0 or tpan_col8 > 0 or tpan_col9 > 0 or tpan_col10 > 0 or tpan_col11 > 0'
	case 4 
		ls_filter = 'tpan_col5 > 0 or tpan_col6 > 0 or tpan_col7 > 0 or tpan_col8 > 0 or tpan_col9 > 0 or tpan_col10 > 0 or tpan_col11 > 0'
	case 5 
		ls_filter = 'tpan_col6 > 0 or tpan_col7 > 0 or tpan_col8 > 0 or tpan_col9 > 0 or tpan_col10 > 0 or tpan_col11 > 0'
	case 6 
		ls_filter = 'tpan_col7 > 0 or tpan_col8 > 0 or tpan_col9 > 0 or tpan_col10 > 0 or tpan_col11 > 0'
	case 7 
		ls_filter = 'tpan_col8 > 0 or tpan_col9 > 0 or tpan_col10 > 0 or tpan_col11 > 0'
	case 8 
		ls_filter = 'tpan_col9 > 0 or tpan_col10 > 0 or tpan_col11 > 0'
	case 9
		ls_filter = 'tpan_col10 > 0 or tpan_col11 > 0'
	case 10
		ls_filter = 'tpan_col11 > 0'	
	case 11
		
	case else
		ls_filter = ''
end choose

li_tipo_cli = dw_2.getitemnumber(1,'tipo')

if li_tipo_cli = 99 then
	if len(ls_filter) > 0 then
		ls_filter = ls_filter +' and clie_clasificacion <> 4'
	else
		ls_filter = 'clie_clasificacion <> 4'
	end if
else
	if len(ls_filter) > 0 then
		ls_filter = ls_filter + ' and clie_clasificacion = '+string(li_tipo_cli)
	else
		ls_filter = 'clie_clasificacion = '+string(li_tipo_cli)
	end if
end if

dw_1.setfilter(ls_filter)
dw_1.filter()
dw_1.groupcalc()
end event

type cbx_por_pais from checkbox within w_inf_cc_antiguedad
boolean visible = false
integer x = 3177
integer y = 28
integer width = 334
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = " Por País"
end type

event clicked;parent.setredraw(false)
if this.checked then
   dw_1.Modify ("DataWindow.Header.2.Height = 0")
   dw_1.Modify ("DataWindow.Trailer.2.Height = 0")	
   this.text = ' Por Región'
   dw_1.modify("l_3.visible = false")	
   dw_1.setsort('dgapais_pais_descripcion, dgmterce_terc_descripcion, ccmclien_clie_ref_anterior')	   	
else
   dw_1.Modify ("DataWindow.Header.2.Height = 100")
   dw_1.Modify ("DataWindow.Trailer.2.Height = 104")		
   this.text = ' Por País'	
   dw_1.modify("l_3.visible = true")	
   dw_1.setsort('dgapais_pais_descripcion, dgaregio_regi_descripcion, dgmterce_terc_descripcion, ccmclien_clie_ref_anterior')	
end if
dw_1.sort()
dw_1.groupcalc()
parent.setredraw(true)
end event

type dw_4 from datawindow within w_inf_cc_antiguedad
boolean visible = false
integer x = 3525
integer y = 16
integer width = 965
integer height = 96
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "dw_external_morosidad_regiones"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_filter
integer li_region, li_tipo_cli

li_region = integer(data)

li_tipo_cli = dw_2.getitemnumber(1,'tipo')

if li_tipo_cli = 99 then
	ls_filter = 'clie_clasificacion <> 4'
else
	ls_filter = 'clie_clasificacion = '+string(li_tipo_cli)
end if

if len(ls_filter) > 0 then
	if li_region > 0 then
		ls_filter = ls_filter + ' and dgaregio_regi_codigo_region = '+string(li_region)
	end if
else
	if li_region > 0 then
		ls_filter = 'dgaregio_regi_codigo_region = '+string(li_region)
	else
		ls_filter = ''
	end if
end if

dw_1.setfilter(ls_filter)
dw_1.filter()
dw_1.groupcalc()
end event

