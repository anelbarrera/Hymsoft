//objectcomments (D)movimiento general de productos
forward
global type w_in_movi_prod_kardex from w_fa_padre_reportes
end type
type dw_2 from datawindow within w_in_movi_prod_kardex
end type
type dw_bodega from datawindow within w_in_movi_prod_kardex
end type
type st_bodega from statictext within w_in_movi_prod_kardex
end type
type dw_ubicacion from datawindow within w_in_movi_prod_kardex
end type
type dw_3 from datawindow within w_in_movi_prod_kardex
end type
type dw_transaccion from datawindow within w_in_movi_prod_kardex
end type
type st_1 from statictext within w_in_movi_prod_kardex
end type
type ln_2 from line within w_in_movi_prod_kardex
end type
type ln_1 from line within w_in_movi_prod_kardex
end type
type st_ubicacion from statictext within w_in_movi_prod_kardex
end type
type dw_5 from datawindow within w_in_movi_prod_kardex
end type
type uo_1 from u_ddcalen within w_in_movi_prod_kardex
end type
type uo_2 from u_ddcalen within w_in_movi_prod_kardex
end type
type dw_4 from datawindow within w_in_movi_prod_kardex
end type
type dw_6 from datawindow within w_in_movi_prod_kardex
end type
type dw_7 from datawindow within w_in_movi_prod_kardex
end type
type cbx_agrupar_por_cliente from checkbox within w_in_movi_prod_kardex
end type
type dw_8 from datawindow within w_in_movi_prod_kardex
end type
end forward

global type w_in_movi_prod_kardex from w_fa_padre_reportes
integer width = 4343
integer height = 2736
event ue_buscar ( )
event ue_busqueda ( )
event ue_carga ( )
dw_2 dw_2
dw_bodega dw_bodega
st_bodega st_bodega
dw_ubicacion dw_ubicacion
dw_3 dw_3
dw_transaccion dw_transaccion
st_1 st_1
ln_2 ln_2
ln_1 ln_1
st_ubicacion st_ubicacion
dw_5 dw_5
uo_1 uo_1
uo_2 uo_2
dw_4 dw_4
dw_6 dw_6
dw_7 dw_7
cbx_agrupar_por_cliente cbx_agrupar_por_cliente
dw_8 dw_8
end type
global w_in_movi_prod_kardex w_in_movi_prod_kardex

type prototypes
Function long ShellExecuteA (ulong hwind, string lpOperation, string lpFile, string lpParameters, string lpDirectory, long nShowCmd) library "shell32.dll" alias for "ShellExecuteA;Ansi"
FUNCTION boolean ShowWindow(ulong hWnd, int nCmdShow) LIBRARY "user32.dll"
FUNCTION boolean LockWindowUpdate(ulong hWndLock) LIBRARY "user32.dll"
end prototypes

type variables
datawindow dw1,dw2,dw3,dw4,dw5,dw6,dw7
date fecha_inicial,fecha_final
str_kardex str_opcion
DataStore lds_kardex
String is_tipo_trans, is_trans_descrip, is_bodega, is_ubicacion, is_costo_en_clave, is_cadena_costo
DataWindowChild iwc_ubicacion
boolean ib_continuar
integer ii_por_linea, ii_especial, ii_letra_por_default, ii_costo_en_letras
string  is_prod_buscar,is_busqueda
window iw_this
str_rangofecha istr_rangfech, lstr_rangfech
Boolean ib_producto_cargado = False

end variables

forward prototypes
public subroutine wf_siempre ()
public subroutine wf_con_fraccion2 (datastore dst_a)
public subroutine wf_con_fraccion (datawindow dw_a)
public function integer wf_verificar_existe (string ls_producto)
public function string wf_asigna_ultima_busqueda ()
public subroutine wf_promedio ()
public subroutine wf_calcular_promedio_ds ()
public subroutine wf_setear_formato2 (datastore dst_a)
public function boolean wf_recuperar_promedio ()
public subroutine wf_setear_formato (ref datawindow dw_a)
public subroutine wf_asigna_busqueda (string as_codigo, integer ai_por_linea)
public subroutine wf_recuperar ()
public function boolean wf_asigna_codigos_alternos (string as_cod_prod, string as_codigo_secundario)
public subroutine wf_actualiza_antiguedad (string idioma)
public subroutine wf_setear_producto (string as_producto)
public subroutine wf_asignar (string as_producto)
end prototypes

event ue_buscar;dw_1.triggerevent("ue_buscar")
end event

event ue_busqueda();This.Postevent("ue_buscar")
end event

event ue_carga();integer i ,ii
string ls_empresa
//this.width=2917
//this.height=1645  


THIS.SetToolbar(1, true, alignattop!)
THIS.SetToolbarPos(1, 1, 50, false)
this.y=1

dw_3.visible = False
dw_4.visible = true

str_opcion                = Message.PowerObjectParm

This.Title                = str_opcion.titulo_ventana

ls_empresa = gf_dg_nombre_empresa()

dw_3.DataObject           = str_opcion.dwpantalla
dw_4.DataObject           = str_opcion.dwreporte
dw_transaccion.DataObject = 'dw_in_trans_kardex_sel'
dw_bodega.DataObject      = 'dw_in_bod_kardex_sel'
dw_ubicacion.DataObject   = 'dw_in_ubic_kardex_sel'



dw1=dw_1           //producto//
dw2=dw_2           //fecha//
dw3=dw_3           //kardex//
dw4=dw_4           //impresion//
dw3.ShareData(dw4)
dw3.visible = False
dw4.visible = False
dw5=dw_transaccion //tipo transaccion//
dw6=dw_bodega        //tipo de Bodega  //
dw7=dw_ubicacion

If str_opcion.opcion_menu <> 'TR' Then
	dw5.Visible = False	
Else
	dw5.Visible = True
//	dw6.Visible = False
//	dw7.Visible = False
End if

If str_opcion.opcion_ventana = 'P' Then
	st_bodega.Visible = False
	dw6.Visible = False
	st_ubicacion.Visible = False
	dw7.Visible = False
ElseIf str_opcion.opcion_ventana = 'B' Then
	st_ubicacion.Visible = False
	dw7.Visible = False
End If
	
If str_opcion.opcion_menu = 'MG' or str_opcion.opcion_menu = 'MCP' &
or str_opcion.opcion_menu = 'PRO' and str_opcion.opcion_ventana = 'B' Then
	st_bodega.x = 41
	dw6.x = 361
ElseIf str_opcion.opcion_menu = 'MG' or str_opcion.opcion_menu = 'MCP' or &
str_opcion.opcion_menu = 'PRO' and str_opcion.opcion_ventana = 'U' Then
   st_bodega.x = 41
	dw6.x = 361	
End If

If str_opcion.opcion_menu = 'MG' or str_opcion.opcion_menu = 'MCP' or &
str_opcion.opcion_menu = 'PRO' and str_opcion.opcion_ventana = 'U' Then
   st_ubicacion.text = 'Ubicac.'
	st_ubicacion.width = 206
	st_ubicacion.x = 654
	dw7.x = 864
End If

dw_1.setfocus()
This.setredraw(True)
end event

public subroutine wf_siempre ();//string ls_prod
end subroutine

public subroutine wf_con_fraccion2 (datastore dst_a);return
string /*ls_formato,*/ ls_error, ls_fraccion
//datastore lds_kardex
//
//lds_kardex = dst_a

Select  para_uso_desglose
Into      :ls_fraccion
From   inaparam
Where para_g_financiero = :str.g_financiero and
		   para_empresa       = :str.empresa ;	

If SQLCA.SQLCode = -1 then
	ls_error = SQLCA.SQLErrText
	rollback;
	Messagebox('Aviso',ls_error)
	return
end if	

//ls_formato =  gf_in_formato_decimal()

//MG
//Movimientos Solamente - Todas las Bodegas
If str_opcion.opcion_ventana = "P"  Or str_opcion.opcion_ventana = "B" Or &
   str_opcion.opcion_ventana = "U"  Then 
	
	If str_opcion.opcion_menu = 'MG' Then // or str_opcion.opcion_menu = 'MCP' Then

		If ls_fraccion = 'P' Then
		
			lds_kardex.modify("entrada2.visible= True")
			lds_kardex.modify("salida2.visible= True")
			lds_kardex.modify("ajuste2.visible= True")
			lds_kardex.modify("total2.visible= True")
			lds_kardex.modify("rfraccion.visible= True")
			lds_kardex.modify("t_01.visible= True")
			lds_kardex.modify("t_02.visible= True")
			lds_kardex.modify("t_03.visible= True")
			lds_kardex.modify("t_04.visible= True")
			lds_kardex.modify("t_05.visible= True")
			lds_kardex.modify("t_06.visible= True")
			lds_kardex.modify("dmov_cant1.visible= True")			
			
	   Else
			
			lds_kardex.modify("entrada2.visible= False")
			lds_kardex.modify("salida2.visible=False")
			lds_kardex.modify("ajuste2.visible= False")
			lds_kardex.modify("total2.visible=False")
			lds_kardex.modify("rfraccion.visible=False")
			lds_kardex.modify("t_01.visible=False")
			lds_kardex.modify("t_02.visible=False")
			lds_kardex.modify("t_03.visible=False")
			lds_kardex.modify("t_04.visible=False")
			lds_kardex.modify("t_05.visible=False")
			lds_kardex.modify("t_06.visible=False")		
			lds_kardex.modify("dmov_cant1.visible=False")						
		
	  End if	
	  
	End if
End if	

//MG

end subroutine

public subroutine wf_con_fraccion (datawindow dw_a);return
//*****        Función para hacer invisible o visible los campos de fracción        ******//

string ls_formato, ls_error, ls_fraccion
datawindow dw_t

dw_t = dw_a

Select  para_uso_desglose
Into    :ls_fraccion
From    inaparam
Where   para_g_financiero = :str.g_financiero And
		  para_empresa      = :str.empresa ;	

If SQLCA.SQLCode = -1 then
	ls_error = SQLCA.SQLErrText
	rollback;
	Messagebox('Aviso',ls_error)
	Return
end if	

if ls_fraccion = "" Or Isnull(ls_fraccion) Then ls_fraccion = "P"  

//MG
//Movimientos Solamente - Todas las Bodegas
If str_opcion.opcion_ventana = "P"  Or str_opcion.opcion_ventana = "B" Or &
   str_opcion.opcion_ventana = "U"  Then 
	If str_opcion.opcion_menu = 'MG' Or str_opcion.opcion_menu = 'TR' Or &
	   str_opcion.opcion_menu = 'MCP' Or str_opcion.opcion_menu = 'PRO' Then

		If ls_fraccion = "P" Then
		
			if dw_t.describe("entrada2.x") <> "?" Or  dw_t.describe("entrada2.x") <> "?" then &
			   dw_t.modify("entrada2.visible= True")
			if dw_t.describe("salida2.x") <> "?" Or  dw_t.describe("salida2.x") <> "?" then &				
				dw_t.modify("salida2.visible= True")
			if dw_t.describe("ajuste2.x") <> "?" Or  dw_t.describe("ajuste2.x") <> "?" then &			
				dw_t.modify("ajuste2.visible= True")
			if dw_t.describe("total2.x") <> "?" Or  dw_t.describe("total2.x") <> "?" then &			
				dw_t.modify("total2.visible= True")
			if dw_t.describe("rfraccion.x") <> "?" Or  dw_t.describe("rfraccion.x") <> "?" then &			
				dw_t.modify("rfraccion.visible= True")
			if dw_t.describe("t_01.x") <> "?" Or  dw_t.describe("t_01.x") <> "?" then &			
				dw_t.modify("t_01.visible= True")
			if dw_t.describe("t_02.x") <> "?" Or  dw_t.describe("t_02.x") <> "?" then &			
				dw_t.modify("t_02.visible= True")
			if dw_t.describe("t_03.x") <> "?" Or  dw_t.describe("t_03.x") <> "?" then &			
				dw_t.modify("t_03.visible= True")
			if dw_t.describe("t_04.x") <> "?" Or  dw_t.describe("t_04.x") <> "?" then &			
				dw_t.modify("t_04.visible= True")
			if dw_t.describe("t_05.x") <> "?" Or  dw_t.describe("t_05.x") <> "?" then &			
				dw_t.modify("t_05.visible= True")
			if dw_t.describe("t_06.x") <> "?" Or  dw_t.describe("t_06.x") <> "?" then &			
				dw_t.modify("t_06.visible= True")
			if dw_t.describe("dmov_cant1.x") <> "?" Or  dw_t.describe("dmov_cant1.x") <> "?" then &			
				dw_t.modify("dmov_cant1.visible= True")			
			if dw_t.describe("t_07.x") <> "?" Or  dw_t.describe("t_07.x") <> "?" then &			
				dw_t.modify("t_07.visible=true")											
			if dw_t.describe("fraccion.x") <> "?" Or  dw_t.describe("fraccion.x") <> "?" then &			
				dw_t.modify("fraccion.visible= True")	
			if dw_t.describe("frac.x") <> "?" Or  dw_t.describe("frac.x") <> "?" then &			
				dw_t.modify("frac.visible= True")				
				
	   Else
			
			if dw_t.describe("entrada2.x") <> "?" Or  dw_t.describe("entrada2.x") <> "?" then &
			   dw_t.modify("entrada2.visible = False")
			if dw_t.describe("salida2.x") <> "?" Or  dw_t.describe("salida2.x") <> "?" then &				
				dw_t.modify("salida2.visible =  False")
			if dw_t.describe("ajuste2.x") <> "?" Or  dw_t.describe("ajuste2.x") <> "?" then &			
				dw_t.modify("ajuste2.visible = False")
			if dw_t.describe("total2.x") <> "?" Or  dw_t.describe("total2.x") <> "?" then &			
				dw_t.modify("total2.visible = False")
			if dw_t.describe("rfraccion.x") <> "?" Or  dw_t.describe("rfraccion.x") <> "?" then &			
				dw_t.modify("rfraccion.visible = False")
			if dw_t.describe("t_01.x") <> "?" Or  dw_t.describe("t_01.x") <> "?" then &			
				dw_t.modify("t_01.visible = False")
			if dw_t.describe("t_02.x") <> "?" Or  dw_t.describe("t_02.x") <> "?" then &			
				dw_t.modify("t_02.visible = False")
			if dw_t.describe("t_03.x") <> "?" Or  dw_t.describe("t_03.x") <> "?" then &			
				dw_t.modify("t_03.visible = False")
			if dw_t.describe("t_04.x") <> "?" Or  dw_t.describe("t_04.x") <> "?" then &			
				dw_t.modify("t_04.visible = False")
			if dw_t.describe("t_05.x") <> "?" Or  dw_t.describe("t_05.x") <> "?" then &			
				dw_t.modify("t_05.visible = False")
			if dw_t.describe("t_06.x") <> "?" Or  dw_t.describe("t_06.x") <> "?" then &			
				dw_t.modify("t_06.visible = False")
			if dw_t.describe("dmov_cant1.x") <> "?" Or  dw_t.describe("dmov_cant1.x") <> "?" then &			
				dw_t.modify("dmov_cant1.visible =  False")			
			if dw_t.describe("t_07.x") <> "?" Or  dw_t.describe("t_07.x") <> "?" then &			
				dw_t.modify("t_07.visible = False")											
			if dw_t.describe("fraccion.x") <> "?" Or  dw_t.describe("fraccion.x") <> "?" then &			
				dw_t.modify("fraccion.visible =  False")	
			if dw_t.describe("frac.x") <> "?" Or  dw_t.describe("frac.x") <> "?" then &			
				dw_t.modify("frac.visible = False ")				
				
	  End if	
	  
	End if
End if	

//MG
end subroutine

public function integer wf_verificar_existe (string ls_producto);string ls_product
integer valor
select prod_producto
into : ls_product
from inmprodu
where (prod_g_financiero =: str.g_financiero) and
      (prod_empresa =: str.empresa) and
		(prod_producto =: ls_producto);
		
		if ls_product <> ls_producto or ls_producto = '' then
			valor = 0
		else
			valor = 1
		end if
		
		return valor
end function

public function string wf_asigna_ultima_busqueda ();//Función en la que se asigna dinamicamente la ultima busqueda a la ventana de busqueda
return is_prod_buscar
end function

public subroutine wf_promedio ();//***************************************************************************//
// Funcion Utilizada para los Kardex de Movimiento Con Costo Promedio        //
//***************************************************************************//
wf_recuperar_promedio()

//Calculo del Costo Promedio ************************************************
If ib_continuar = True Then
Integer   li_con
Double    ld_costo_pro,ld_costo, ld_saldo_pro, ld_saldo, ld_intermedio
String    ls_tipo
double ld_cantidad,ld_medida,ld_cantidad_pro,ld_costo_pro2

ld_cantidad_pro=0
ld_costo_pro   = 0
ld_costo       = 0
ld_saldo_pro   = 0
ld_saldo       = 0
ld_intermedio  = 0

For li_con = 1 To dw3.RowCount()
	 ld_saldo = dw3.GetItemNumber(li_con,"dmov_cantidad") + &
	 dw3.GetItemNumber(li_con,"dmov_cant1") / dw3.GetItemNumber &
	 (li_con,"inamedid_medi_cantidad_b")
if isnull(ld_saldo) then  ld_saldo=0
	 If dw3.GetItemString(li_con,"intmovim_tmov_tipo")='C' Then
		 ld_saldo = - ld_saldo
	 End If 
	 ld_costo = dw3.GetItemDecimal(li_con,"costo_total") 
ld_cantidad=dw_3.getitemnumber(li_con,"cantidad_total") 				 
ld_medida=dw_3.getitemnumber(li_con,"inamedid_medi_cantidad_b")
//ld_costo = dw_3.getitemdecimal(li_con,"costo_total")
	 ls_tipo = dw3.GetItemString(li_con,'dmov_tipo_transaccion')

	 If ld_costo <> 0 Then 
    	If ld_saldo + ld_saldo_pro <> 0 Then
			If ls_tipo = 'AC' Then
				ld_costo_pro = ld_costo_pro + ld_costo
			Else 	
//			   ld_costo_pro = Round(Round(ld_saldo * ld_costo + ld_costo_pro * ld_saldo_pro,4)&
//				/ Round(ld_saldo + ld_saldo_pro,4),4)
            if ld_saldo_pro > 0 then
					ld_costo_pro=round((ld_costo_pro2 * ld_saldo_pro)+(ld_costo*ld_saldo),6)
				else
					ld_costo_pro=ld_costo*round(ld_saldo_pro+ld_cantidad,6)
				end if
         		ld_cantidad_pro=round(ld_saldo_pro+ld_cantidad,6)

				 	End If
	   End if		
	 End if 
 	 	 ld_saldo_pro = ld_saldo + ld_saldo_pro	 
		
		if ld_cantidad_pro <> 0 then ld_costo_pro2=round(ld_costo_pro / ld_cantidad_pro,6)
             dw3.SetItem(li_con,"cc2",ld_costo_pro2)
	 
Next
Else
	Return
End If



If dw3.Visible = False Then
   
	dw4.SetRedraw(TRUE)
	dw4.Visible = True 
	dw4.Hide()
	dw4.Show()
	dw4.SetRedraw(True)
	dw4.SetPosition(ToBottom!)
	
	dw3.SetRedraw(TRUE)	
	dw3.Hide()
	dw3.Visible = True
	dw3.Show()
	dw3.SetRedraw(True) 	
	
	This.SetRedraw(TRUE)
//	This.Height = 1645
	This.SetRedraw(True)
	dw2.SetFocus()
End If
dw3.SetFocus()
DW3.groupcalc()
//DW3.scrolltorow(dw3.rowcount())
DW3.scrolltorow(1)



end subroutine

public subroutine wf_calcular_promedio_ds ();//**************************************************************************//
// Funcion que calcula el costo promedio del DataStore de Costo Promedio    //
//**************************************************************************//
Integer   li_con
Double    ld_costo_pro,ld_costo, ld_saldo_pro, ld_saldo, ld_intermedio
String    ls_tipo

ld_costo_pro  = 0.0
ld_costo      = 0.0
ld_saldo_pro  = 0.0
ld_saldo      = 0.0
ld_intermedio = 0.0

For li_con = 1 To lds_kardex.RowCount()	 
	 ld_saldo = lds_kardex.GetItemNumber(li_con,"dmov_cantidad") &
	 + lds_kardex.GetItemNumber(li_con,"dmov_cant1") &
	 / lds_kardex.GetItemNumber(li_con,"inamedid_medi_cantidad_b")	 
	 
	 If lds_kardex.GetItemString(li_con,"intmovim_tmov_tipo")='C' Then
		 ld_saldo = - ld_saldo
	 End If 
	 
	 ld_costo = lds_kardex.GetItemDecimal(li_con,"costo_ent") 
	 ls_tipo  = lds_kardex.GetItemString(li_con,'dmov_tipo_transaccion')

	 If ld_costo <> 0 Then 
    	If ld_saldo + ld_saldo_pro <> 0 Then
		 	If ls_tipo = 'AC' or ls_tipo = 'AE'  Then
				ld_costo_pro = ld_costo
			Else 	
			   ld_costo_pro = Round(Round(ld_saldo * ld_costo + ld_costo_pro * ld_saldo_pro,4)&
				/ Round(ld_saldo + ld_saldo_pro,4),4)	
		 	End If
	   End If 
	 End If 
	 ld_saldo_pro = ld_saldo + ld_saldo_pro	 
	 lds_kardex.SetItem(li_con,"cc2",ld_costo_pro) 
Next
end subroutine

public subroutine wf_setear_formato2 (datastore dst_a);return
string ls_formato, ls_fraccion, ls_error

Select  para_uso_desglose
Into      :ls_fraccion
From   inaparam
Where para_g_financiero = :str.g_financiero and
		   para_empresa       = :str.empresa ;	

If SQLCA.SQLCode = -1 then
	ls_error = SQLCA.SQLErrText
	rollback;
	Messagebox('Aviso',ls_error)
	return
end if	

ls_formato =  gf_in_formato_decimal()

//MG
////Movimientos Solamente - Todas las Bodegas
If str_opcion.opcion_ventana = "P" Or str_opcion.opcion_ventana = "B" Or &
   str_opcion.opcion_ventana = "U"  Then 
	
	If str_opcion.opcion_menu = 'MG' Then // or str_opcion.opcion_menu = 'MCP' Then
		lds_kardex.modify("entrada1.format='"+ ls_formato +"'")
		if ls_fraccion<> 'P' then lds_kardex.modify("entrada1.width=390")
		lds_kardex.modify("salida1.format='"+ ls_formato +"'")
		lds_kardex.modify("ajuste1.format='"+ ls_formato +"'")
		lds_kardex.modify("total1.format='"+ ls_formato +"'")
		lds_kardex.modify("rentero.format='"+ ls_formato +"'")
		lds_kardex.modify("dmov_cantidad.format='"+ ls_formato +"'")
		lds_kardex.modify("saldo.format='"+ ls_formato +"'")
	end if
	
end if	
//MG



end subroutine

public function boolean wf_recuperar_promedio ();//*********************************************************************************//
// Funcion que recupera todos los valores de los Datawindows utilizados para el    //
// costo promedio                                                                  //
//*********************************************************************************//

////////////////D E C L A R A C I O N  D E  V A R I A B L E S////////
String   ls_prod,ls_descripcion_medida,ls_total,ls_um,ls_medida,ls_desc_medida
Decimal  ld_total_final  
Double   ld_fila, ld_promedio, ld_costo_promed, ld_fraccion, ld_cantidad_total
DateTime dt_fecha1,dt_fecha2,dt_anterior,dt_posterior
Time     tiempo1 = 00:00:00, tiempo2 = 23:59:59
Integer  li_unidad_medida
/////////////////////////////////////////////////////////////////////

dw1.AcceptText()
dw2.AcceptText()
ib_continuar = False
ls_prod       = dw1.GetItemString (dw1.GetRow(),'prod_producto')
fecha_inicial = dw2.GetItemDate   (dw2.GetRow(),'fecha_inicial')
fecha_final   = dw2.GetItemDate   (dw2.GetRow(),'fecha_final')
	
/////////////////////////////////////////////////////////////
dt_fecha1    =  DateTime (fecha_inicial,tiempo1)
dt_fecha2    =  DateTime (fecha_final,tiempo2)
dt_anterior  =  DateTime (date("01/01/1980"),tiempo1)
dt_posterior =  DateTime (relativedate(fecha_inicial,-1),tiempo2)
//////////////recuperamos los datos//////////////////////////
	
dw3.SetTransObject(Sqlca)

wf_setear_formato(dw3)
wf_con_fraccion(dw3)

//*****************validacion del retrieve del datawindow de dw3 (pantalla)**********
If str_opcion.opcion_ventana = "P"  Then  //por producto general*********************
	   dw3.Retrieve(str.g_financiero,str.empresa,ls_prod,dt_fecha1,dt_fecha2)
ElseIf str_opcion.opcion_ventana = "B" Then //por bodega******************************
	   dw3.retrieve(str.g_financiero,str.empresa,ls_prod,is_bodega,dt_fecha1,dt_fecha2)

ElseIf str_opcion.opcion_ventana = "U" Then //por ubicacion***************************
	   dw3.retrieve(str.g_financiero,str.empresa,ls_prod,is_bodega,is_ubicacion,dt_fecha1,dt_fecha2)
End If
//***********************************************************************************
If dw3.RowCount() = 0 Then
		MessageBox('Atención','Este producto no ha tenido movimiento' ,StopSign!)
		Return ib_continuar
End If

////////BUSCAMOS LA UNIDAD Y CANTIDAD DE LA UNIDAD DE MEDIDA////////////////////////
ls_descripcion_medida = dw1.GetItemString(dw1.GetRow(),'inamedid_medi_descripcion')
	//////////////////////////////////////////////////////////////////////////////////
	
///*******************///
///creamos datastore  ///

lds_kardex = Create DataStore
lds_kardex.DataObject = str_opcion.dwpantalla
lds_kardex.SetTransObject(Sqlca)

//****************************Validacion para el retrieve del datastore**********************
If str_opcion.opcion_ventana = "P" Then //por producto***************************************
  	   lds_kardex.Retrieve(str.g_financiero,str.empresa,ls_prod,dt_anterior,dt_posterior)
ElseIf str_opcion.opcion_ventana = "B" Then //por bodega*************************************
	   lds_kardex.Retrieve(str.g_financiero,str.empresa,ls_prod,is_bodega,dt_anterior,dt_posterior)
ElseIf str_opcion.opcion_ventana = "U" Then //por ubicacion**********************************
	   lds_kardex.Retrieve(str.g_financiero,str.empresa,ls_prod,is_bodega,is_ubicacion,dt_anterior,dt_posterior)
End If
wf_calcular_promedio_ds()  //Calcular el costo promedio del DataStore********************

//***************************************************************************************
If lds_kardex.rowcount() > 0 then
   ls_um             = lds_kardex.GetItemString(lds_kardex.RowCount(),'dmov_unidad_medida')
	ld_total_final    = lds_kardex.GetItemNumber(lds_kardex.RowCount(),'total_final')
	ld_promedio       = lds_kardex.GetItemNumber(lds_Kardex.RowCount(),'cc2')
	ld_costo_promed   = lds_kardex.GetItemNumber(lds_kardex.RowCount(),'costo_ent')
	ld_fraccion       = Mod(ld_total_final,lds_kardex.GetItemNumber(lds_kardex.Rowcount(),'inamedid_medi_cantidad_b'))
	ld_cantidad_total = Truncate(ld_total_final/lds_kardex.GetItemNumber(lds_kardex.Rowcount(),'inamedid_medi_cantidad_b'),0)
Else
	ld_total_final = 0.00
End If
//	messagebox('costos_promedio',string(ld_promedio))	

//SETEAMOS LOS VALORES AL DATAWINDOW DW3//

li_unidad_medida = dw1.GetItemNumber(1,'inamedid_medi_cantidad')
If dw3.Rowcount() > 0 Then
   ls_medida        = dw3.GetItemString(1,'inmprodu_medida')
   ls_desc_medida   = dw3.GetItemString(1,'inamedid_medi_descripcion')
End If
dw3.InsertRow(1)
dw3.SetItem        (1,'cc2',ld_promedio)
dw3.SetItem        (1,'dmov_costo',ld_promedio)
dw3.SetItem        (1,"ccantidad_piezas",ld_total_final)
dw3.SetItem        (1,'dmov_cantidad',ld_cantidad_total)


If str_opcion.opcion_menu <> 'TR' Then
   dw3.SetItem     (1,'dmov_tipo_transaccion','EN')
	dw3.SetItem     (1,'intmovim_tmov_tipo_transaccion','EN')
Else
	dw3.SetItem     (1,'dmov_tipo_transaccion',is_tipo_trans)
	dw3.SetItem     (1,'intmovim_tmov_tipo_transaccion',is_tipo_trans)	
End If
dw3.SetItem        (1,'intmovim_tmov_fecha',dt_posterior)
dw3.SetItem        (1,'dmov_cant1',ld_fraccion)
dw3.SetItem        (1,'inamedid_medida_producto',li_unidad_medida)
dw3.SetItem        (1,'inamedid_medi_cantidad_b',li_unidad_medida)
dw3.SetItem        (1,'dmov_documento','Balance')

If str_opcion.opcion_ventana = 'P' Then
	dw3.SetItem        (1,'dmov_bodega','XXX')
   dw3.SetItem        (1,'dmov_ubicacion','XXX')
ElseIf str_opcion.opcion_ventana = 'B' Then
	dw3.SetItem        (1,'dmov_bodega',is_bodega)
   dw3.SetItem        (1,'dmov_ubicacion','XXX')
Else
   dw3.SetItem        (1,'dmov_bodega',is_bodega)
   dw3.SetItem        (1,'dmov_ubicacion',is_ubicacion)
End If

dw3.SetItem(1,'intmovim_tmov_tipo','D')

dw3.SetItem        (1,'dmov_unidad_medida',ls_um)
dw3.SetItem        (1,'inmprodu_prod_medida',ls_um)
dw3.SetItem        (1,'inamedid_medi_descripcion',ls_descripcion_medida )
dw3.SetItem        (1,'inmprodu_medida',ls_medida)
dw3.SetItem        (1,'dgmterce_terc_descripcion','B A L A N C E')
dw3.SetItem        (1,'tercero','B A L A N C E')


//***********************************************************************************
string ls_descrip_producto,ls_empaque_descrip,ls_foto,ls_foto_f
integer li_empaque_cantidad

ls_descrip_producto = dw1.GetitemString(1,'inmprodu_prod_descripcion')
dw3.SetItem           (1,'inmprodu_prod_descripcion',ls_descrip_producto)
ls_empaque_descrip  = dw1.GetItemString(1,'inmprodu_prod_empaque_descripcion')
dw3.SetItem           (1,'inmprodu_prod_empaque_descripcion',ls_empaque_descrip)
ls_desc_medida      = dw1.GetItemString(1,'inamedid_medi_descripcion')
dw3.SetItem           (1,'inamedid_medida_empaque',ls_desc_medida)
dw3.SetItem           (1,"dmov_producto",ls_prod)
li_empaque_cantidad = dw1.GetItemNumber(1,'inmprodu_prod_empaque')
dw3.SetItem           (1,'inmprodu_prod_empaque',li_empaque_cantidad)
//////////////////////////////////////////////////

///DESTRUIMOS EL DATASTORE////
   Destroy lds_kardex
////////////////////

dw3.accepttext()
dw4.accepttext()

ib_continuar = True
dw3.SetFocus()
//DW3.scrolltorow(dw3.rowcount())
DW3.groupcalc()
DW3.scrolltorow(1)


Return ib_continuar


end function

public subroutine wf_setear_formato (ref datawindow dw_a);//return
//*Función para setear los formatos de decimales a los campos de cantidades del dw3*//

string ls_formato, ls_fraccion, ls_error
datawindow dw_t
integer li_decimal

dw_t = dw_a

Select para_uso_desglose, para_decimal_cantidad
Into   :ls_fraccion, :li_decimal
From   inaparam
Where  para_g_financiero = :str.g_financiero and
		 para_empresa      = :str.empresa ;	

If SQLCA.SQLCode = -1 Then
	ls_error = SQLCA.SQLErrText
	Rollback;
	Messagebox('Aviso',ls_error)
	Return
End If	

if isnull(li_decimal) then li_decimal = 0

If li_decimal > 0 Then
	ls_formato = "###,###,##0."+ fill("0",li_decimal) 
Else
	ls_formato = "###,###,##0"
End If

//Informes de Kardex
If str_opcion.opcion_ventana = "P"  Or str_opcion.opcion_ventana = "B" Or &
   str_opcion.opcion_ventana = "U"  Then  
	If str_opcion.opcion_menu = 'MG' Or str_opcion.opcion_menu = 'TR' Or &
	   str_opcion.opcion_menu = 'MCP' Or str_opcion.opcion_menu = 'PRO' Then
		

		If dw_t.describe("entrada1.x") <> "?" Or  dw_t.describe("entrada1.x") <> "?" Then 
		 dw_t.modify("entrada1.format='"+ ls_formato +"'") 
 	   End if 
			
		If dw_t.describe(".x") <> "?" Or  dw_t.describe(".x") <> "?" Then 
			dw_t.modify("salida1.format='"+ ls_formato +"'")
		End If	
		
		If dw_t.describe(".x") <> "?" Or  dw_t.describe(".x") <> "?" Then 
			dw_t.modify("ajuste1.format='"+ ls_formato +"'")
		End If				
		
		If dw_t.describe(".x") <> "?" Or  dw_t.describe(".x") <> "?" Then 
			dw_t.modify("total1.format='"+ ls_formato +"'")
		End If				

		if dw_t.describe("rentero.x") <> "?" Or dw_t.describe("rentero.x") <> "!" Then
			dw_t.modify("rentero.format='"+ ls_formato +"'")
		End If	
		
		             
		If dw_t.describe(".x") <> "?" Or  dw_t.describe(".x") <> "?" Then 
			dw_t.modify("dmov_cantidad.format='"+ ls_formato +"'")
		End If				
		
		If dw_t.describe(".x") <> "?" Or  dw_t.describe(".x") <> "?" Then 
			dw_t.modify("saldo.format='"+ ls_formato +"'")
		End If				

		
		If dw_t.describe(".x") <> "?" Or  dw_t.describe(".x") <> "?" Then 
			dw_t.modify("cantidad_final.format='"+ ls_formato +"'")
		End If				
	
	end if
end if	


end subroutine

public subroutine wf_asigna_busqueda (string as_codigo, integer ai_por_linea);//Funcion llamada desde ventana de busqueda, para asignar los valores
is_prod_buscar = as_codigo
ii_por_linea	= ai_por_linea
end subroutine

public subroutine wf_recuperar ();//***********************************************************************************//
//Esta Función es Utilizada para realizar la recuperacion de los Kardex de:          //
//-- Movimiento General                                                              //
//-- Movimiento por Tipo de Transaccion                                              //
//-- Movimiento con Costos y Precios Aplicado                                        //
//***********************************************************************************//

////////////////D E C L A R A C I O N  D E  V A R I A B L E S////////
String   ls_prod,ls_descripcion_medida,ls_total,ls_um,ls_medida,ls_desc_medida
Decimal  ld_total_final  
Integer   li_tipo_medida
Double   ld_fila, ld_fraccion, ld_cantidad_total
DateTime dt_fecha1,dt_fecha2,dt_anterior,dt_posterior
Time     tiempo1 = 00:00:00, tiempo2 = 23:59:59
/* Alexis Receda - Uso de Medidas con Decimales 18 Dic 2000 */
decimal {6}  li_unidad_medida
decimal {8}  ld_costo_promedio

/* */
/////////////////////////////////////////////////////////////////////

dw1.AcceptText()
dw2.AcceptText()
ls_prod       = dw1.GetItemString (dw1.GetRow(),'prod_producto')
fecha_inicial = dw2.GetItemDate   (dw2.GetRow(),'fecha_inicial')
fecha_final   = dw2.GetItemDate   (dw2.GetRow(),'fecha_final')
	
/////////////////////////////////////////////////////////////
dt_fecha1    =  DateTime (fecha_inicial,tiempo1)
dt_fecha2    =  DateTime (fecha_final,tiempo2)
dt_anterior  =  DateTime (date("01/01/1980"),tiempo1)
dt_posterior =  DateTime (relativedate(fecha_inicial,-1),tiempo2)
//////////////recuperamos los datos//////////////////////////

//str.frame.SetRedraw(TRUE)	
	
dw3.SetTransObject(Sqlca)
//dw_3.SetRedraw(TRUE)

wf_setear_formato(dw3)
wf_con_fraccion(dw3)

//*****************validacion del retrieve del datawindow de dw3 (pantalla)**********


If str_opcion.opcion_ventana = "P"  Then  //por producto general*********************
	If str_opcion.opcion_menu = 'MG' or str_opcion.opcion_menu = 'MCP' Then
	
	   dw3.Retrieve(str.g_financiero,str.empresa,ls_prod,dt_fecha1,dt_fecha2)

	ElseIf str_opcion.opcion_menu = 'TR' Then
		dw3.Retrieve(str.g_financiero,str.empresa,is_tipo_trans,ls_prod,dt_fecha1,dt_fecha2)

	End If
ElseIf str_opcion.opcion_ventana = "B" Then //por bodega******************************
	If str_opcion.opcion_menu = 'MG' or str_opcion.opcion_menu = 'MCP' Then

    dw3.retrieve(str.g_financiero,str.empresa,ls_prod,is_bodega,dt_fecha1,dt_fecha2)
		
	ElseIf str_opcion.opcion_menu = 'TR' Then

		dw3.Retrieve(str.g_financiero,str.empresa,ls_prod,is_bodega,dt_fecha1,dt_fecha2,is_tipo_trans)
		
	End If
ElseIf str_opcion.opcion_ventana = "U" Then //por ubicacion***************************
	If str_opcion.opcion_menu = 'MG' or str_opcion.opcion_menu = 'MCP' Then

	   dw3.retrieve(str.g_financiero,str.empresa,ls_prod,is_bodega,is_ubicacion,dt_fecha1,dt_fecha2)

	ElseIf str_opcion.opcion_menu = 'TR' Then
		dw3.Retrieve(str.g_financiero,str.empresa,ls_prod,is_bodega,is_ubicacion,dt_fecha1,dt_fecha2,is_tipo_trans)

	End If
End If

//***********************************************************************************

/* Bloqueado If para buscar saldo Anterior del producto ( and False) * * Alexis 15 / V / 2001 */
If dw3.RowCount() = 0 and false Then
		This.SetRedraw(True)
		MessageBox('Atención','Este producto no ha tenido movimiento' ,StopSign!)
		Return
End If

////////BUSCAMOS LA UNIDAD Y CANTIDAD DE LA UNIDAD DE MEDIDA////////////////////////
ls_descripcion_medida = dw1.GetItemString(dw1.GetRow(),'inamedid_medi_descripcion')
	//////////////////////////////////////////////////////////////////////////////////
	
///*******************///
///creamos datastore  ///
lds_kardex = Create ds_dg_import_file
lds_kardex.DataObject = str_opcion.dwpantalla
lds_kardex.SetTransObject(Sqlca)

//wf_setear_formato2(lds_kardex)
//wf_con_fraccion2(lds_kardex)

//****************************Validacion para el retrieve del datastore**********************
If str_opcion.opcion_ventana = "P" Then //por producto***************************************
   If str_opcion.opcion_menu = 'MG' or str_opcion.opcion_menu = 'MCP'  Then
		
	   lds_kardex.Retrieve(str.g_financiero,str.empresa,ls_prod,dt_anterior,dt_posterior)

   ElseIf str_opcion.opcion_menu = 'TR' Then
		lds_kardex.Retrieve(str.g_financiero,str.empresa,is_tipo_trans,ls_prod,dt_anterior,dt_posterior)

   End If
ElseIf str_opcion.opcion_ventana = "B" Then //por bodega*************************************
	If str_opcion.opcion_menu = 'MG' or str_opcion.opcion_menu = 'MCP'  Then
	   lds_kardex.Retrieve(str.g_financiero,str.empresa,ls_prod,is_bodega,dt_anterior,dt_posterior)

   ElseIf str_opcion.opcion_menu = 'TR' Then
		lds_kardex.Retrieve(str.g_financiero,str.empresa,ls_prod,is_bodega,dt_anterior,dt_posterior,is_tipo_trans)

   End If
ElseIf str_opcion.opcion_ventana = "U" Then //por ubicacion**********************************
	If str_opcion.opcion_menu = 'MG' or str_opcion.opcion_menu = 'MCP'  Then
	   lds_kardex.Retrieve(str.g_financiero,str.empresa,ls_prod,is_bodega,is_ubicacion,dt_anterior,dt_posterior)

   ElseIf str_opcion.opcion_menu = 'TR' Then
		lds_kardex.Retrieve(str.g_financiero,str.empresa,ls_prod,is_bodega,is_ubicacion,dt_anterior,dt_posterior,is_tipo_trans)

   End If
	
End If


//wf_setear_formato2(lds_kardex)
//wf_con_fraccion2(lds_kardex)

li_unidad_medida = dw1.GetItemNumber(1,'inamedid_medi_cantidad')  
li_tipo_medida = dw1.GetItemNumber(1,'medi_tipo_medida')  

//***************************************************************************************
If lds_kardex.rowcount() > 0 then
     ls_um          = lds_kardex.GetItemString(lds_kardex.RowCount(),'dmov_unidad_medida')
     ld_total_final = lds_kardex.GetItemNumber(lds_kardex.RowCount(),'total_final')
	ld_costo_promedio =   lds_kardex.GetItemNumber(lds_kardex.RowCount(),'dmov_costo_promedio')
     ld_fraccion       = Mod     (ld_total_final,li_unidad_medida)
     ld_cantidad_total = Truncate(ld_total_final/li_unidad_medida,2)
Else
	ld_total_final = 0.00
End If
		

//SETEAMOS LOS VALORES AL DATAWINDOW DW3//


dw3.SetItem        (1,'inamedid_medida_producto',li_unidad_medida)
If dw3.Rowcount() > 0 Then
   ls_medida        = dw3.GetItemString(1,'inmprodu_medida')
   ls_desc_medida   = dw3.GetItemString(1,'inamedid_medi_descripcion')
End If

/* Balance solo cuando tenga saldo (Alexis -  5/Mar/01 )*/
if not (isnull(ld_total_final) or ld_total_final = 0) then 


dw3.InsertRow(1)
dw_3.setitem(1,'ver_en_letras',ii_letra_por_default)	
dw_3.setitem(1,'costo_en_letras',ii_costo_en_letras)	
dw3.SetItem        (1,"ccantidad_piezas",ld_total_final)
If str_opcion.opcion_menu <> 'TR' Then
   dw3.SetItem     (1,'dmov_tipo_transaccion','EN')
	dw3.SetItem     (1,'intmovim_tmov_tipo_transaccion','EN')
Else
	dw3.SetItem     (1,'dmov_tipo_transaccion',is_tipo_trans)
	dw3.SetItem     (1,'intmovim_tmov_tipo_transaccion',is_tipo_trans)	
End If
dw3.SetItem        (1,'intmovim_tmov_fecha',dt_posterior)
dw3.SetItem        (1,'dmov_cantidad',ld_cantidad_total)
dw3.SetItem        (1,'dmov_cant1',ld_fraccion)
dw3.SetItem        (1,'inamedid_medida_producto',li_unidad_medida)
dw3.SetItem        (1,'dmov_documento','Balance')
dw3.SetItem        (1,'medi_tipo_medida',li_tipo_medida)
dw3.SetItem        (1,'dmov_costo_promedio',ld_costo_promedio)

If str_opcion.opcion_ventana = 'P' Then
	dw3.SetItem        (1,'dmov_bodega','XXX')
   dw3.SetItem        (1,'dmov_ubicacion','XXX')
ElseIf str_opcion.opcion_ventana = 'B' Then
	dw3.SetItem        (1,'dmov_bodega',is_bodega)
   dw3.SetItem        (1,'dmov_ubicacion','XXX')
Else
   dw3.SetItem        (1,'dmov_bodega',is_bodega)
   dw3.SetItem        (1,'dmov_ubicacion',is_ubicacion)
End If


//If ld_total_final >= 0 Then
   dw3.SetItem(1,'intmovim_tmov_tipo','D')
//Else
//	dw3.SetItem(1,'intmovim_tmov_tipo','C')
//End If

dw3.SetItem        (1,'dmov_unidad_medida',ls_um)
dw3.SetItem        (1,'inmprodu_prod_medida',ls_um)
dw3.SetItem        (1,'inamedid_medi_descripcion',ls_descripcion_medida )

If dw3.describe("inamedid_medi_abre_a.x") <> "?" And dw3.describe("inamedid_medi_abre_a.x") <> "!" Then	
	dw3.SetItem        (1,'inamedid_medi_abre_a',ls_descripcion_medida )
end if
dw3.SetItem        (1,'inmprodu_medida',ls_medida)
dw3.SetItem        (1,'inmprodu_prod_definicion',dw1.GetItemNumber(1,'prod_definicion'))
dw3.SetItem        (1,'dgmterce_terc_descripcion','B A L A N C E')


//***********************************************************************************
string ls_descrip_producto,ls_empaque_descrip,ls_foto,ls_foto_f
integer li_empaque_cantidad

ls_descrip_producto = dw1.GetitemString(1,'inmprodu_prod_descripcion')
dw3.SetItem           (1,'inmprodu_prod_descripcion',ls_descrip_producto)
ls_empaque_descrip  = dw1.GetItemString(1,'inmprodu_prod_empaque_descripcion')
dw3.SetItem           (1,'inmprodu_prod_empaque_descripcion',ls_empaque_descrip)
ls_desc_medida      = dw1.GetItemString(1,'inamedid_medi_descripcion')
dw3.SetItem           (1,'inamedid_medida_empaque',ls_desc_medida)
dw3.SetItem           (1,"dmov_producto",ls_prod)
li_empaque_cantidad = dw1.GetItemNumber(1,'inmprodu_prod_empaque')
dw3.SetItem           (1,'inmprodu_prod_empaque',li_empaque_cantidad)
//////////////////////////////////////////////////
end if
///DESTRUIMOS EL DATASTORE////
   Destroy lds_kardex
////////////////////

If dw3.Visible = False Then
   
//	dw4.SetRedraw(TRUE)
	dw4.Visible = True 
	dw4.Hide()
	dw4.Show()
//	dw4.SetRedraw(True)
	dw4.SetPosition(ToBottom!)
	
//	dw3.SetRedraw(TRUE)	
	dw3.Hide()
	dw3.Visible = True
	dw3.Show()
//	dw3.SetRedraw(True) 	
	
//	This.Height = 1645
//	dw2.SetFocus()
End If
if dw3.Rowcount() = 0 Then
//	mensaje("Atención ","No hay datos para este informe","")
	This.SetRedraw(True)
    str.frame.SetMicroHelp("No hay datos para este informe")
	Return
else 
    str.frame.SetMicroHelp("Listo")
End If

//dw3.SetFocus() //comentado

//DW3.groupcalc()
//DW3.scrolltorow(1)

//str.frame.SetRedraw(True)
end subroutine

public function boolean wf_asigna_codigos_alternos (string as_cod_prod, string as_codigo_secundario);string ls_secundario, ls_taman, ls_descrip_tam
Integer i
		//Declara el cursor para agrupar las tallas de los otros productos
		 DECLARE secundarios_cur CURSOR FOR
		  SELECT inmprodu.prod_producto, prod_cod_clase_tam        
		  FROM inmprodu  
		WHERE ( ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
				( inmprodu.prod_empresa = :str.empresa ) AND  
				( inmprodu.prod_producto_dos = :as_codigo_secundario ) AND  
				( inmprodu.prod_producto <> :as_cod_prod ) )    ;
	
				if sqlca.sqlcode = -1 then
					mensaje("Aviso","Error al declarar cursor " + sqlca.sqlerrtext,"")
				end if
	
				open secundarios_cur ;
				
				if sqlca.sqlcode = -1 then
					mensaje("Aviso","Error al Abrir cursor " + sqlca.sqlerrtext,"")
				end if
				
				fetch secundarios_cur into :ls_secundario, :ls_taman ;
				
				do while sqlca.sqlcode = 0 					
					i ++				
						//Busca el tamaño del producto alterno y lo asigna
					  SELECT cracltam.acta_descripcion  
						 INTO :ls_descrip_tam  
						 FROM cracltam  
						WHERE ( cracltam.acta_g_financiero = :str.g_financiero ) AND  
								( cracltam.acta_empresa = :str.empresa ) AND  
								( cracltam.acta_cod_clase_tam = :ls_taman )  ;
							if sqlca.sqlcode = -1 then
								mensaje("Aviso","Error al seleccionar el tamano "+sqlca.sqlerrtext,"")
							end if

					choose case i
						case	1
							dw_1.setitem(1,'secundario1',ls_secundario)									
							dw_1.setitem(1,'taman1',ls_descrip_tam)		
						case	2
							dw_1.setitem(1,'secundario2',ls_secundario)	
							dw_1.setitem(1,'taman2',ls_descrip_tam)									
						case	3
							dw_1.setitem(1,'secundario3',ls_secundario)							
							dw_1.setitem(1,'taman3',ls_descrip_tam)									
						case	4
							dw_1.setitem(1,'secundario4',ls_secundario)							
							dw_1.setitem(1,'taman4',ls_descrip_tam)									
					end choose
					fetch secundarios_cur into :ls_secundario, :ls_taman ;
				loop
				close secundarios_cur;
				
return true
end function

public subroutine wf_actualiza_antiguedad (string idioma);Integer  li_registros, li_i, li_empresa, li_grupofin, li_emp, li_dberror, &
         li_tipo, li_socio, li_audit
decimal  ld_x, ld_y, ld_monto
string   ls_db_err,ls_where_select, ls_error
long 		ll_tercero
Datetime ld_tiempo1, ld_tiempo2
Datastore lds_cliente, lds_tercero_empresa, lds_tercero_gf, lds_tercero_pais

DELETE FROM ccatempa
WHERE ( ccatempa.tmpa_g_financiero 	= :str.g_financiero 	) AND  
      ( ccatempa.tmpa_empresa 		= :str.empresa 		) and
		( ccatempa.tmpa_usuario_maquina = :str.maquina 		) ;
if sqlca.sqlcode = -1 then
	messagebox('error','error al elimianr registros desde ccatempa')
end if

DELETE FROM cchestado  
WHERE ( cchestado.est_g_financiero =:str.g_financiero  ) AND  
		( cchestado.est_empresa =:str.empresa  ) AND  
		( cchestado.est_usuario_maquina =:str.maquina  )   ;
if sqlca.sqlcode = -1 then
	mensaje('Error','Error eliminando de cchestado','')
end if

//datastore	lds_tercero_empresa, lds_tercero_gf,lds_cliente, lds_tercero_pais
Datawindowchild ldwc_sub_tran, ldwc_pais, ldwc_region

lds_cliente 			= create ds_dg_import_file
lds_tercero_empresa 	= create ds_dg_import_file
lds_tercero_gf 		= create ds_dg_import_file
lds_tercero_pais	 	= create ds_dg_import_file


lds_cliente.dataobject = 'dw_cc_inf_terceros_rango_1_nom'
//****************

lds_cliente.settransobject(sqlca)

istr_rangfech =  lstr_rangfech
ld_tiempo1 = Datetime(istr_rangfech.fecha1,00:00:00)
ld_tiempo2 = Datetime(istr_rangfech.fecha2,00:00:00)

//lstr_rangfech.tip_cliente = il_tip_cliente

CHOOSE CASE istr_rangfech.opcion
	CASE 'P' //Por Cliente 
			
		//**filtra el dw por tipo de cliente
		if lstr_rangfech.tip_cliente = 'P' then
			if not isnull(istr_rangfech.tipo_cliesp) then li_tipo = 1
			if not isnull(istr_rangfech.tipo_socio)  then li_socio = 1
			if not isnull(istr_rangfech.tipo_auditor) then li_audit = 1
		
			if li_tipo = 1 then
				lds_cliente.setfilter("ccmclien_clie_clasificacion="+string(lstr_rangfech.tipo_cliesp))
				lds_cliente.filter()
			elseif li_socio = 1 then
				lds_cliente.setfilter("clie_socio="+string(lstr_rangfech.tipo_socio))
				lds_cliente.filter()
			elseif li_audit = 1 then
				lds_cliente.setfilter("clie_auditor="+string(lstr_rangfech.tipo_auditor))
				lds_cliente.filter()
			end if
						
		elseif lstr_rangfech.tip_cliente = 'T' then
			lds_cliente.Setfilter('')
			lds_cliente.filter()
		end if
      //***

			lds_cliente.retrieve(str.g_financiero,str.empresa,istr_rangfech.nombre1,istr_rangfech.nombre2)
			li_registros = lds_cliente.rowcount()
			
			ls_where_select="( terc_descripcion + convert(char(5),dgmterce.terc_tercero) between '"+lstr_rangfech.nombre1+"' and '"+lstr_rangfech.nombre2+"' )"
		
		for li_i = 1 to li_registros 
			//ole_1.object.value 	= (li_i/lds_cliente.rowcount()) * 100		
			//valida que el cliente sea visible, si no tiene permisos, que se devuelva
				ll_tercero 				= lds_cliente.getitemnumber(li_i,"ccmclien_clie_tercero")										
				gf_antiguedad_x_cliente(ld_tiempo2, ll_tercero,idioma,ld_tiempo1)
				istr_rangfech.tipo_antig = 'N'
		next
		//ole_1.visible = false

END CHOOSE

//ole_1.visible = false

IF ISVALID(lds_cliente)  THEN
	DESTROY lds_cliente
END IF
commit using sqlca;
return;
end subroutine

public subroutine wf_setear_producto (string as_producto);integer ll_encontro
string ls_modelo

dw_1.setitem(dw_1.getrow(),'prod_producto',as_producto)
dw_1.setcolumn('prod_producto')

				  SELECT inmprodu.prod_producto_dos  
						 INTO :ls_modelo  
						 FROM inmprodu  
						WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
								( inmprodu.prod_empresa = :str.empresa ) AND  
								( inmprodu.prod_producto = :as_producto )   ;
						if sqlca.sqlcode = -1 then
							gf_mensaje('','Error al Buscar Modelo '+sqlca.sqlerrtext,1,1,'E')
						end if
dw_1.setitem(dw_1.getrow(),'prod_producto_dos_1',ls_modelo)	
dw_1.accepttext()
dw_1.trigger event itemchanged(dw_1.getrow(), dw_1.object, as_producto)

end subroutine

public subroutine wf_asignar (string as_producto);dw_1.setitem(1,'prod_producto',as_producto)
dw_1.setfocus()
dw_1.setcolumn('prod_producto')
dw_1.triggerevent('itemchanged')
end subroutine

on w_in_movi_prod_kardex.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_bodega=create dw_bodega
this.st_bodega=create st_bodega
this.dw_ubicacion=create dw_ubicacion
this.dw_3=create dw_3
this.dw_transaccion=create dw_transaccion
this.st_1=create st_1
this.ln_2=create ln_2
this.ln_1=create ln_1
this.st_ubicacion=create st_ubicacion
this.dw_5=create dw_5
this.uo_1=create uo_1
this.uo_2=create uo_2
this.dw_4=create dw_4
this.dw_6=create dw_6
this.dw_7=create dw_7
this.cbx_agrupar_por_cliente=create cbx_agrupar_por_cliente
this.dw_8=create dw_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_bodega
this.Control[iCurrent+3]=this.st_bodega
this.Control[iCurrent+4]=this.dw_ubicacion
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.dw_transaccion
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.ln_2
this.Control[iCurrent+9]=this.ln_1
this.Control[iCurrent+10]=this.st_ubicacion
this.Control[iCurrent+11]=this.dw_5
this.Control[iCurrent+12]=this.uo_1
this.Control[iCurrent+13]=this.uo_2
this.Control[iCurrent+14]=this.dw_4
this.Control[iCurrent+15]=this.dw_6
this.Control[iCurrent+16]=this.dw_7
this.Control[iCurrent+17]=this.cbx_agrupar_por_cliente
this.Control[iCurrent+18]=this.dw_8
end on

on w_in_movi_prod_kardex.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_bodega)
destroy(this.st_bodega)
destroy(this.dw_ubicacion)
destroy(this.dw_3)
destroy(this.dw_transaccion)
destroy(this.st_1)
destroy(this.ln_2)
destroy(this.ln_1)
destroy(this.st_ubicacion)
destroy(this.dw_5)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.dw_4)
destroy(this.dw_6)
destroy(this.dw_7)
destroy(this.cbx_agrupar_por_cliente)
destroy(this.dw_8)
end on

event open;/* Se establece un tamaño especifico para todas las ventanas 
   heredadas de este padre */
This.visible = false
string ls_empresa
iw_this = this
this.y = 0
this.x = 805
This.setredraw(false)
//m_fa_rep.m_edicin.m_buscar.toolbaritemvisible = true

sqlca.autocommit = true
This.Icon = str.icono
  SELECT isnull(usua_letras_por_default,1), isnull(usua_costo_en_letras,1)
    INTO :ii_letra_por_default  , :ii_costo_en_letras
    FROM usuarios  
   WHERE usuarios.usua_id = :str.usuario   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al buscar parametro '+sqlca.sqlerrtext,1,1,'E')
	end if

	SELECT inaparam.para_costo_en_clave
	 INTO :is_costo_en_clave  
	 FROM inaparam  
	WHERE ( inaparam.para_g_financiero = :str.g_financiero ) AND  
			( inaparam.para_empresa = :str.empresa ) ;
			
   if sqlca.sqlcode = 0 then
		if isnull(is_costo_en_clave) then is_costo_en_clave = 'N'
	end if

	select para_clave_costos  //Clave de Costos
		into : is_cadena_costo
		from inaparam
		where (para_g_financiero =: str.g_financiero) and
				(para_empresa =: str.empresa);
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al buscar clave '+sqlca.sqlerrtext,1,1,'E')
		end if
this.postevent("ue_carga")	
this.postevent("ue_post_open")	




end event

event ue_post_open;
//************************************//
st_nom_ventana.text = this.classname()
//************************************//
 
this.SetRedraw(false)
string ls_empresa

//Para ocultar las opciones de consultas, cuando es Elbros
if pos(gf_dg_nombre_empresa(),'ELBROS') > 0 then gf_fa_cambiar_titulos(this.menuid)

//this.width = this.width + 35
//this.width = 3520
//this.height = this.height + 75
//DataWindowChild dwc_producto
//dw1.GetChild ('prod_producto',dwc_producto) //*****DropDown de Productos*****//
//dwc_producto.SetTransObject(Sqlca)
//dwc_producto.Retrieve(str.g_financiero,str.empresa)
//gf_hay_data_child(dwc_producto)

dw1.SetTransObject(Sqlca)
dw2.SetTransObject(Sqlca)
dw3.settransobject(sqlca)
dw4.settransobject(sqlca)
dw_6.settransobject(sqlca)
dw_7.settransobject(sqlca)
dw_8.settransobject(sqlca)
dw1.InsertRow(0)
if dw2.rowcount() = 0 then
	dw2.InsertRow(0)
end if

fecha_final = Date(gf_fecha_serv())
//if str.contabiliza = 0 then
	fecha_inicial = Date('01/01/1999') //+string(year(Date(gf_fecha_serv()))))
//else
//	fecha_inicial = Date('01/'+string(month(Date(gf_fecha_serv())))+'/'+string(year(Date(gf_fecha_serv()))))
//end if
dw2.SetItem(dw2.GetRow(),'fecha_inicial',fecha_inicial)
dw2.SetItem(dw2.GetRow(),'fecha_final',fecha_final)

If str_opcion.opcion_menu = 'TR' Then //Kardex por Tipo de Transaccion
	DataWindowChild dwc_tipo
	dw5.GetChild('mser_tipo_transaccion',dwc_tipo)
   dwc_tipo.SetTransObject(Sqlca)
   dwc_tipo.Retrieve(str.g_financiero,str.empresa,str.aplicacion)
	gf_hay_data_child(dwc_tipo)
   dw5.SetTransObject(Sqlca)
   dw5.InsertRow(0) 
End If

If str_opcion.opcion_ventana <> 'P' Then
	DataWindowChild dwc_bodega
	dw6.GetChild('abod_bodega',dwc_bodega)
   dwc_bodega.SetTransObject(Sqlca)
   dwc_bodega.Retrieve(str.g_financiero,str.empresa)
	gf_hay_data_child(dwc_bodega)
	dw6.SetTransObject(Sqlca)
	dw6.InsertRow(0)
End If


If str_opcion.opcion_ventana  = 'U' Then
	dw7.GetChild('dmov_ubicacion',iwc_ubicacion)
   iwc_ubicacion.SetTransObject(Sqlca)
   iwc_ubicacion.Retrieve(str.g_financiero,str.empresa)
   gf_hay_data_child(iwc_ubicacion)
	dw7.SetTransObject(Sqlca)
	dw7.InsertRow(0)
End If

dw=dw3

dw1.SetFocus()
str.frame.SetMicroHelp (" << F1 Para Seleccionar el Producto >> " )

If Not len(trim(str_opcion.kproducto))=0 then 
	dw_1.setitem(1,'prod_producto',str_opcion.kproducto)
	dw_1.accepttext()
	dw_1.triggerevent("itemchanged")
//      dw1.retrieve(str.g_financiero,str.empresa,str_opcion.kproducto)
//      dw3.reset()	
//	   dw4.reset()		
//		If str_opcion.opcion_ventana = 'P' And str_opcion.opcion_menu = 'MG'  then
//			wf_recuperar()				
//		ElseIf str_opcion.opcion_ventana = 'P' And str_opcion.opcion_menu = 'MCP'  then
//			wf_recuperar()			  
//		ElseIf str_opcion.opcion_menu = 'TR' Then
//			wf_recuperar()			  
//			dw5.SetFocus()
//		ElseIf str_opcion.opcion_ventana = 'B' and str_opcion.opcion_menu = 'MG' &
//			Or str_opcion.opcion_menu = 'MCP' Then
//			  wf_recuperar()			  
//			dw6.SetFocus()			
//		ElseIf str_opcion.opcion_ventana = 'U' and str_opcion.opcion_menu = 'MG' Then			
//			  wf_recuperar()			  
//			dw6.SetFocus()	
//		ElseIf str_opcion.opcion_ventana = 'U' and  str_opcion.opcion_menu = 'MCP' Then
//			  wf_recuperar()			  
//			dw6.SetFocus()
//		ElseIf str_opcion.opcion_menu = 'PRO' Then
//			If str_opcion.opcion_ventana = 'P' Then
//				wf_promedio()	
//			Else
//				dw6.SetFocus()				
//			End If
//		End If		
End if

ls_empresa = gf_dg_nombre_empresa()
if dw_3.describe('tmov_no_pedido.x') <> '?' and dw_3.describe('tmov_no_pedido.x') <> '!' then
	dw_3.modify('tmov_no_pedido.visible = true')	
	dw_3.modify('tmov_no_pedido_t.visible = true')		
end if

//Muestra el costo en numeros para usuarios especiales
 select usua_especial 
	into :ii_especial
	from ssmusuar
  where usua_id = :str.usuario ;
if sqlca.sqlcode = -1 then
	mensaje("Aviso","Error al seleccionar usuarios "+sqlca.sqlerrtext,"")
end if
dw_1.setitem(1,'user_especial', ii_especial)

if ii_especial = 1 then
	dw_1.modify('costo_clave.visible = false')	
	dw_1.modify('costo_cif.visible = true')	
else
	dw_1.modify('costo_cif.visible = false')	
	dw_1.modify('costo_clave.visible = true')		
end if

this.setredraw(true)

 
end event

event ue_print;dw=dw4
dw3.AcceptText()
OpenWithParm(w_dw_print_options, dw)

If Message.DoubleParm = -1 Then Return
dw.Print(True)
end event

event activate;//
end event

event ue_primer_reg;//dw=dw4
dw.scrolltorow(1)
end event

event ue_reg_anterior;//dw=dw4
dw.scrollpriorrow()
end event

event ue_siguiente_reg;//dw=dw4
dw.scrollnextrow()
//dw.scrollnextpage()
end event

event ue_ultimo_reg;//dw=dw4
dw.scrolltorow(dw.rowcount())
end event

event resize;
dw_3.Resize(newwidth - 40, newheight - 830)
//gb_2.Resize(newwidth - 60, newheight - 400)

//dw_3.x = 5
dw_3.y = 350
ln_2.beginy = dw_3.y - 4 
ln_1.beginy = dw_3.y - 12 
ln_2.endx = dw_3.width
ln_1.endx = dw_3.width 
dw_6.y = newheight - 470
dw_4.y = newheight - 400
//gb_2.y  = dw_3.y - 10
//gb_2.x  = dw_3.x - 15
//
//gb_2.width  = dw_3.width  + 25
//gb_2.height = dw_3.height  + 10
//

gb_1.width  = this.width  - 63
gb_1.height = newheight  - 325


//if dw_4.height < 200 then 
//	dw_4.y = dw_3.y + dw_3.height + 10
//	dw_4.x = dw_3.width  - 1641
//else 
//	dw_4.y = 0 
//	dw_4.x = 0
//	dw_4.width = this.width  - 20
//	dw_4.height = this.height - 100
//end if

//gb_ventana.y = dw_3.y + dw_3.height + 5


//st_nom_ventana.y =  dw_3.y + dw_3.height + 40

end event

event closequery;call super::closequery;constant int SW_HIDE = 0

ShowWindow(Handle(this), SW_HIDE)
end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_in_movi_prod_kardex
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_in_movi_prod_kardex
boolean visible = false
integer x = 23
integer y = 1600
integer width = 1234
integer height = 60
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_in_movi_prod_kardex
event ue_down pbm_dwnkey
event ue_helpcol ( )
event ue_enter pbm_dwnprocessenter
event ue_buscar ( )
event ue_postitemchanged ( )
integer x = 18
integer y = 4
integer width = 2898
integer height = 328
integer taborder = 10
string dataobject = "dw_in_produ_kardex_sel"
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

event dw_1::ue_down;integer li_fila

CHOOSE CASE key
		
	CASE KeyF1! 
		
//		This.Postevent("ue_helpcol")		
		This.Postevent("ue_buscar")		
	case KeyF3!
		str.frame.setredraw(false)
		if ii_letra_por_default = 1 then
			ii_letra_por_default = 0
		else
			ii_letra_por_default = 1
		end if
		dw_3.setitem(1,'ver_en_letras',ii_letra_por_default)
		li_fila = dw_3.getrow()
		dw_3.scrolltorow(dw_3.rowcount())
		dw_3.scrolltorow(li_fila)
		str.frame.setredraw(true)
	case KeyF4!
		str.frame.setredraw(false)
		if ii_costo_en_letras = 0 then
			ii_costo_en_letras = 1
		else
			ii_costo_en_letras = 0
		end if
		  UPDATE usuarios  
			  SET usua_costo_en_letras = :ii_costo_en_letras  
			WHERE usuarios.usua_id = :str.usuario   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al buscar default de costo en letras '+sqlca.sqlerrtext,1,1,'E')
			end if
		dw_3.setitem(1,'costo_en_letras',ii_costo_en_letras)		
		str.frame.setredraw(true)
END CHOOSE

if keydown(KeyF5!) then
	this.triggerevent('itemchanged')
end if
end event

event dw_1::ue_helpcol();//string ls_prod = ""
//if dw1.getcolumnName() = "prod_producto" then
//   openwithparm(w_in_co_bus_prod," ")
//	ls_prod = message.stringparm
//	if ls_prod = "" then
//		return
//	else
//		dw1.reset()
//		dw3.reset()
//		dw4.reset()		
//		dw1.retrieve(str.g_financiero,str.empresa,ls_prod)
//	   
//		If dw3.Visible = False and str_opcion.opcion_ventana = 'P' And str_opcion.opcion_menu = 'MG'  then
//			  wf_recuperar()		
//			  Parent.SetRedraw(TRUE)
//			  Parent.Height = 1645
//			  Parent.SetRedraw(True)
//			  dw3.Visible = True
//		ElseIf dw3.Visible = False and str_opcion.opcion_ventana = 'P' And str_opcion.opcion_menu = 'MCP'  then
//			  wf_recuperar()		
//			  Parent.SetRedraw(TRUE)
//			  Parent.Height = 1645
//			  Parent.SetRedraw(True)
//			  dw3.Visible = True
//		ElseIf str_opcion.opcion_menu = 'TR' Then
//			dw5.SetFocus()
//		ElseIf str_opcion.opcion_ventana = 'B' and str_opcion.opcion_menu = 'MG' &
//			Or str_opcion.opcion_menu = 'MCP' Then
//			dw6.SetFocus()			
//		ElseIf str_opcion.opcion_ventana = 'U' and str_opcion.opcion_menu = 'MG' &
//			Or str_opcion.opcion_menu = 'MCP' Then
//			dw6.SetFocus()		
//		End If
//	End If
//End If
end event

event dw_1::ue_enter;send(handle(this),256,9,long(0,0))
return 1
end event

event dw_1::ue_buscar();//Busqueda del producto
//
String  ls_syntax, ls_find,ls_codigo, ls_item, ls_modelo
integer li_c, li_b, li_pos, li_fila, li_fila2, li_especial
long    ll_lter, ll_encontro
string  ls_lter,ls_des

Datawindow        dww
str_dg_dynamic_find	lstr_df

	if this.getcolumnname() = 'dmov_producto' then
		li_fila = 1
		li_fila2 = 2
	else
		li_fila = 2
		li_fila2 = 1
	end if
	
  SELECT isnull(usuarios.usua_especial,0)  
    INTO :li_especial  
    FROM usuarios  
   WHERE usuarios.usua_id = :str.usuario   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al buscar autorizado '+sqlca.sqlerrtext,1,1,'E')
	end if
	
	lstr_df.texto_campo [li_fila,1] = "inmprodu.prod_producto"
	lstr_df.texto_campo [li_fila,2] = "Referencia"
	lstr_df.texto_campo [li_fila,3] = "prod_producto"
	lstr_df.texto_campo [li_fila,4] = 'V'
//	lstr_df.texto_campo [1,5] = '280'	
	lstr_df.texto_campo [li_fila2,1] = "inmprodu.prod_producto_dos"
	lstr_df.texto_campo [li_fila2,2] = "Modelo"
	lstr_df.texto_campo [li_fila2,3] = ""
	lstr_df.texto_campo [li_fila2,4] = 'V'
	
	lstr_df.texto_campo [3,1] = "inmprodu.prod_descripcion"
	lstr_df.texto_campo [3,2] = "Descripcion"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [3,5] = '1070'
	
	lstr_df.texto_campo [4,1] = "datediff(month, prod_entrada_fecha, getdate()) mes"
	lstr_df.texto_campo [4,2] = "M"
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '100'
	
	lstr_df.texto_campo [5,1] = "convert(numeric(8,2),inmprodu.prod_existencia_total / medi_cantidad) prod_existencia_total"
	lstr_df.texto_campo [5,2] = "Exist."
	lstr_df.texto_campo [5,3] = ""
	lstr_df.texto_campo [5,4] = 'V'
	lstr_df.texto_campo [5,5] = '270'

	lstr_df.texto_campo [6,1] = "convert(numeric(8,2),inmprodu.prod_reserva_total / medi_cantidad) prod_reserva_total"
	lstr_df.texto_campo [6,2] = "Reserva"
	lstr_df.texto_campo [6,3] = ""
	lstr_df.texto_campo [6,4] = 'V'
	lstr_df.texto_campo [6,5] = '270'

	lstr_df.texto_campo [7,1] = "convert(numeric(8,2),(inmprodu.prod_existencia_total  - inmprodu.prod_reserva_total) / medi_cantidad) disponible"
	lstr_df.texto_campo [7,2] = "Dispo."
	lstr_df.texto_campo [7,3] = ""
	lstr_df.texto_campo [7,4] = 'V'
	lstr_df.texto_campo [7,5] = '270'

	lstr_df.texto_campo [8,1] = "convert(numeric(8), inmprodu.prod_empaque) prod_empaque"
	lstr_df.texto_campo [8,2] = "Empaque"
	lstr_df.texto_campo [8,3] = ""
	lstr_df.texto_campo [8,4] = 'V'
	lstr_df.texto_campo [8,5] = '270'
	
	lstr_df.texto_campo [9,1] = "inmprodu.prod_medida"
	lstr_df.texto_campo [9,2] = "Uni."
	lstr_df.texto_campo [9,3] = ""
	lstr_df.texto_campo [9,4] = 'V'
	lstr_df.texto_campo [9,5] = '120'
	if li_especial = 1 then
		lstr_df.texto_campo [10,1] = "inmprodu.prod_costo_fob"
		lstr_df.texto_campo [10,2] = "Info"
		lstr_df.texto_campo [10,3] = ""
		lstr_df.texto_campo [10,4] = 'V'
		lstr_df.texto_campo [10,5] = '230'
	
		lstr_df.texto_campo [11,1] = "cradivis.adiv_nombre_div"
		lstr_df.texto_campo [11,2] = "Division"
		lstr_df.texto_campo [11,3] = ""
		lstr_df.texto_campo [11,4] = 'V'
		lstr_df.texto_campo [11,5] = '870'
		
		lstr_df.texto_campo [12,1] = "cragrupo.agru_descripcion_grupo"
		lstr_df.texto_campo [12,2] = "Grupo"
		lstr_df.texto_campo [12,3] = ""
		lstr_df.texto_campo [12,4] = 'V'
		lstr_df.texto_campo [12,5] = '870'
	else
		lstr_df.texto_campo [10,1] = "cradivis.adiv_nombre_div"
		lstr_df.texto_campo [10,2] = "Division"
		lstr_df.texto_campo [10,3] = ""
		lstr_df.texto_campo [10,4] = 'V'
		lstr_df.texto_campo [10,5] = '870'
		
		lstr_df.texto_campo [11,1] = "cragrupo.agru_descripcion_grupo"
		lstr_df.texto_campo [11,2] = "Grupo"
		lstr_df.texto_campo [11,3] = ""
		lstr_df.texto_campo [11,4] = 'V'
		lstr_df.texto_campo [11,5] = '870'		
	end if
	lstr_df.tabla = " inmprodu, cradivis, cragrupo, inamedid "
		
	lstr_df.tabla_where = &
		"WHERE ( inmprodu.prod_g_financiero = cragrupo.agru_g_financiero ) and  " +&
         "( inmprodu.prod_empresa = cragrupo.agru_empresa  ) and  " +&
         "( inmprodu.prod_division = cragrupo.agru_codigo_div ) and " +&  
         "( inmprodu.prod_grupo = cragrupo.agru_codigo_grupo  ) and " +&  			
         "( inmprodu.prod_g_financiero = cradivis.adiv_g_financiero ) and " +& 
         "( inmprodu.prod_empresa = cradivis.adiv_empresa ) and  " +&
         "( inmprodu.prod_division = cradivis.adiv_codigo_div ) and " +&  
         "( inmprodu.prod_medida = inamedid.medi_medida ) and " +&  			
		"(inmprodu.prod_g_financiero = " + string(str.g_financiero) + ") and " +&
		"(inmprodu.prod_empresa = " + string(str.empresa) + ") "	

// 	OpenSheetWithParm(w_buscar_producto_mantener_abierta, lstr_df, w_fa_fondo, 2, Original!)
OpenWithParm(w_buscar_producto_mantener_abierta, lstr_df)
	 
//	OpenWithParm(w_buscar_producto, lstr_df)
	ls_syntax = Message.StringParm		
		
		IF NOT IsNull(ls_syntax) AND (ls_syntax <> "") Then 
//				//Para extraer el codigo del producto
//				li_pos	 = pos(ls_syntax,"= '",1)	
//				li_pos 	 += 3	
//				ls_item = mid(ls_syntax,li_pos, Pos(ls_syntax, "'",li_pos) - li_pos)
//				this.setitem(this.getrow(),"prod_producto",ls_item)
//					  SELECT inmprodu.prod_producto_dos  
//						 INTO :ls_modelo  
//						 FROM inmprodu  
//						WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
//								( inmprodu.prod_empresa = :str.empresa ) AND  
//								( inmprodu.prod_producto = :ls_codigo )   ;
//						if sqlca.sqlcode = -1 then
//							gf_mensaje('','Error al Buscar Modelo '+sqlca.sqlerrtext,1,1,'E')
//						end if
//				this.setitem(this.getrow(),'prod_producto_dos_1',ls_modelo)
//				this.accepttext()
//				This.Postevent("itemchanged")		
////				This.Post Event ue_postitemchanged(ls_item,this.getrow(),'prod_producto')
//				this.setcolumn('prod_producto')
//				This.Setfocus()
				wf_setear_producto(ls_syntax)
		End If
	 
end event

event dw_1::ue_postitemchanged;dw_1.SetFocus()
dw_1.setcolumn('prod_producto')

end event

event dw_1::clicked;dw=dw_1
this.accepttext()
string ls_col, ls_prod = '', ls_foto

ls_col = dwo.name

choose case ls_col
	case	'producto_t'
		string ls_producto
		str_kardex  str_opcion2
				
		if dw_1.rowcount() > 0 then
			ls_producto = dw_1.getitemstring(dw_1.getrow(),'prod_producto')				
		end if			
		str_opcion2.kproducto=ls_producto
	
		OpenSheetWithParm(w_productos,str_opcion2,str.frame,2,Original!)		
		
	case 'inmprodu_prod_foto_dir'
		if this.rowcount() = 0 then return
		ls_foto = this.getitemstring(1, "inmprodu_prod_foto_dir")
		if isvalid(w_imagen) then
			close(w_imagen)		
		end if
		openwithparm(w_imagen, ls_foto)
end choose

end event

event dw_1::dberror;// Rutina para los errores de la base de datod
// Daniel Vergara 22/07/1998


IF sqlerrtext <> "" THEN 
	OpenWithParm (w_error,sqlerrtext)
	gf_dberror(sqldbcode,sqlerrtext)	
	// Stop PowerBuilder from displaying the error
	RETURN 1
END IF
end event

event dw_1::constructor;///
end event

event dw_1::itemchanged;dw_4.visible = true
string ls_prod, ls_modelo, ls_medida, ls_codigo_secundario, ls_expresion, ls_clave, ls_fraccion, ls_error, ls_formato, ls_costo
integer li_resp, li_num_cv, li_cont, li_decimal, li_tipo_medida, i
decimal ld_reserva_total, ld_total, ld_conversion, ld_disponible, ld_exis_total, ld_exis_frac_total , ld_fraccion, ld_disponible_fraccion 
decimal{2} ld_precio_c, ldec_costo_cif, ld_costo_promedio, ld_costo
dw1.acceptText()
	
if dw1.getcolumnName() = 'prod_producto' or dw1.getcolumnName() = 'prod_producto_dos_1' then

	if dw1.getcolumnName() = 'prod_producto_dos_1' then
		ls_modelo = this.getitemstring(this.getrow(),'prod_producto_dos_1')
		  SELECT max(inmprodu.prod_producto)
			 INTO :ls_prod  
			 FROM inmprodu  
			WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
					( inmprodu.prod_empresa = :str.empresa ) AND  
					( inmprodu.prod_producto_dos = :ls_modelo )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Buscar Modelo '+sqlca.sqlerrtext,1,1,'E')
				str.frame.setredraw(true)
				return
			end if
			this.setitem(this.getrow(),'prod_producto',ls_prod)
	end if
	dw3.reset()	
	dw4.reset()
	dw5.reset()
	dw6.reset()
	dw7.reset()
	dw5.insertrow(0)
	dw6.insertrow(0)
	dw7.insertrow(0)
	is_bodega = ''
	is_ubicacion = ''
	ls_prod = upper(dw1.getitemstring(dw1.getrow(),'prod_producto'))
	if isnull(ls_prod) then ls_prod = ''

	dw_3.modify("reserva.text = '0'")
	dw_4.modify("reserva.text = '0'")
	dw_3.modify("reserva_fraccion.text = ''")
	dw_4.modify("reserva_fraccion.text = ''")	
	dw_4.modify("t_reser.text = ''")		
	dw_3.modify("disponible.text = '"+string(ld_exis_total)+"'")
	dw_4.modify("disponible.text = '"+string(ld_exis_total)+"'")	
	
	//verificamos si el producto existe//
	li_resp = wf_verificar_existe(ls_prod)
	
	if li_resp = 0 then
		messagebox("Atención","El producto no existe",stopsign!)
		dw3.reset()	
	    dw4.reset()
		return
	else	
      dw1.retrieve(str.g_financiero,str.empresa,ls_prod)
	  dw_6.retrieve(str.g_financiero, str.empresa, ls_prod)	
		ls_medida = dw1.getitemstring(dw1.getrow(),'medi_medida')		
      dw3.reset()	
	   dw4.reset()		
		If str_opcion.opcion_ventana = 'P' And str_opcion.opcion_menu = 'MG'  then
			  wf_recuperar()
		ElseIf str_opcion.opcion_ventana = 'P' And str_opcion.opcion_menu = 'MCP'  then
			  wf_recuperar()			  
		End If	

		
		//Se busca el formato de las cantidades
		Select para_uso_desglose, para_decimal_cantidad
		Into   :ls_fraccion, :li_decimal
		From   inaparam
		Where  para_g_financiero = :str.g_financiero and
				 para_empresa      = :str.empresa ;	
		
		If SQLCA.SQLCode = -1 Then
			ls_error = SQLCA.SQLErrText
			Rollback;
			Messagebox('Aviso',ls_error)
			Return
		End If	
		
		if isnull(li_decimal) then li_decimal = 0
		
		ls_prod       = dw_1.GetItemString (dw_1.GetRow(),'prod_producto')
		li_tipo_medida= dw_1.GetItemNumber (dw_1.GetRow(),'medi_tipo_medida')
				
		If li_tipo_medida = 5 Then
			ls_formato = "###,###,##0."+ fill("0",li_decimal) 
		Else
			ls_formato = "###,###,##0"
		End If			

		ld_costo_promedio = dw_1.getitemnumber(dw_1.getrow(),'prod_costo_promedio')
		ls_costo = gf_clave_costos(ld_costo_promedio)
		dw_1.setitem(1,'costo',ls_costo)
		
		if dw_3.rowcount() > 0 then		
			ld_exis_total 		 = truncate(dw_3.getitemnumber(dw_3.rowcount(),"total1") ,li_decimal)
			ld_exis_frac_total = truncate(dw_3.getitemnumber(dw_3.rowcount(),"total2") ,li_decimal)
			dw_3.setitem(1,"user_especial",ii_especial)
			if ii_especial = 1 then
//				dw_3.modify('precio_usuario_especial.visible = true')	
//				dw_4.modify('clave_costo.visible = false')	
//				dw_4.modify('clave_precio.visible = false')	
			else
//				dw_3.modify('precio_usuario_especial.visible = false')					
//				dw_4.modify('dmov_costo.visible = false')	
//				dw_4.modify('dmov_precio.visible = false')					
			end if
			
			dw_3.setitem(1,'ver_en_letras',ii_letra_por_default)	
			dw_3.setitem(1,'costo_en_letras',ii_costo_en_letras)	
			for i = 1 to dw_3.rowcount()
				yield()
					if dw_3.getitemstring(i,'dmov_aplicacion') = 'IN' then
						ld_costo = dw_3.getitemnumber(i,'dmov_costo_cif')
						ls_costo = gf_clave_costos_sin_select(ld_costo, is_cadena_costo)
					else
						ld_costo = dw_3.getitemnumber(i,'dmov_precio')
						ls_costo = gf_clave_costos_sin_select(ld_costo, is_cadena_costo)
					end if
					dw_3.setitem(i,'valor_en_letras',ls_costo)
					ld_costo = dw_3.getitemnumber(i,'porc_venta')
					ls_costo = gf_clave_costos_sin_select(ld_costo, is_cadena_costo)
					dw_3.setitem(i,'margen_en_letras',ls_costo)
			next
			ld_costo = dw_3.getitemnumber(1,'margen_final_numero')
			ls_costo = gf_clave_costos_sin_select(ld_costo, is_cadena_costo)
			dw_3.object.margen_final_letras.expression = "'"+ls_costo+"'"
//			dw_3.modify("margen_final_letras.expression = '"+ls_costo+"'")
		else
			ld_exis_total = 0
			ld_exis_frac_total = 0
		end if	
		
	 //Recupera la reserva total y la asigna
	   ld_reserva_total = 0
		dw_5.retrieve(str.g_financiero, str.empresa, ls_prod)
		if dw_5.rowcount() > 0 then
			ld_reserva_total = dw_5.getitemnumber(1,'reserva_total')
			if isnull(ld_reserva_total) then ld_reserva_total = 0
			
			ld_conversion	  = gf_unidad_venta(ls_medida, 10)
			if ld_reserva_total > 0 then
				ld_total			  = truncate( ld_reserva_total / ld_conversion, li_decimal)
			else
				ld_total = 0
			end if
			dw_3.modify("reserva.text = '"+string(ld_total, ls_formato)+"'")
			dw_4.modify("reserva.text = '"+string(ld_total, ls_formato)+"'")
			ld_disponible 		=  ld_exis_total - ld_total
			dw_3.modify("disponible.text = '"+string(ld_disponible, ls_formato)+"'")
			dw_4.modify("disponible.text = '"+string(ld_disponible, ls_formato)+"'")
						
			ld_fraccion = truncate(((ld_reserva_total / ld_conversion) - truncate( ld_reserva_total / ld_conversion ,0 )) * ld_conversion,0)
			
			if isnull(ld_fraccion) then ld_fraccion = 0
			if ld_fraccion > 0 then
				dw_3.modify("reserva_fraccion.text = '"+string(ld_fraccion)+"'")
				dw_4.modify("reserva_fraccion.text = '"+string(ld_fraccion)+"'")			
				dw_3.modify("t_reser.text = '/'")
				dw_4.modify("t_reser.text = '/'")
			else
				dw_3.modify("reserva_fraccion.text = ''")
				dw_4.modify("reserva_fraccion.text = ''")
				dw_3.modify("t_reser.text = ''")
				dw_4.modify("t_reser.text = ''")				
			end if
			
			ld_disponible_fraccion = ld_exis_frac_total - ld_fraccion
			if ld_disponible_fraccion > 0 then
				dw_3.modify("disponible_fraccion.text = '"+string(ld_disponible_fraccion)+"'")			
				dw_3.modify("t_dispo.text = '/'")
				dw_4.modify("disponible_fraccion.text = '"+string(ld_disponible_fraccion)+"'")			
				dw_4.modify("t_dispo.text = '/'")
			else
				dw_3.modify("t_dispo.text = ''")
				dw_3.modify("disponible_fraccion.text = ''")
				dw_4.modify("t_dispo.text = ''")
				dw_4.modify("disponible_fraccion.text = ''")
			end if			
		else
			dw_3.modify("reserva.text = '0'")
			dw_4.modify("reserva.text = '0'")
			dw_3.modify("reserva_fraccion.text = ''")
			dw_4.modify("reserva_fraccion.text = ''")	
			dw_3.modify("t_reser.text = ''")
			dw_4.modify("t_reser.text = ''")					
			dw_3.modify("disponible.text = '"+string(ld_exis_total, ls_formato)+"'")
			dw_4.modify("disponible.text = '"+string(ld_exis_total, ls_formato)+"'")
			if ld_exis_frac_total > 0 then 
				dw_3.modify("t_dispo.text = '/'")
				dw_3.modify("disponible_fraccion.text = '"+string(ld_exis_frac_total)+"'")
				dw_4.modify("t_dispo.text = '/'")
				dw_4.modify("disponible_fraccion.text = '"+string(ld_exis_frac_total)+"'")				
			else
				dw_3.modify("t_dispo.text = ''")
				dw_3.modify("disponible_fraccion.text = ''")
				dw_4.modify("t_dispo.text = ''")
				dw_4.modify("disponible_fraccion.text = ''")
			end if
		end if	
		
		
	End If
End If	

dw_4.visible = true

ls_codigo_secundario = dw_1.getitemstring(dw_1.getrow(),'prod_producto_dos')
if ls_codigo_secundario <> '' and not isnull(ls_codigo_secundario) then
	wf_asigna_codigos_alternos(ls_prod, ls_codigo_secundario)
end if

////Para que refleje el precio de venta
//ldec_costo_cif = round(dw1.getitemnumber(dw1.getrow(),"prod_costo_cif"),2)
//
//choose case ldec_costo_cif 
//	case 0 to 15.99,36 to 45.99,66 to 75.99
//		li_num_cv=1
//	case 16 to 25.99,46 to 55.99,76 to 86
//		li_num_cv=2
//	case 26 to 35.99,56 to 65.99,is > 86
//		li_num_cv=3
//end choose
//li_cont=1
//
//declare cr_clave cursor for
// select isnull(claco_codigo,'')
// from inaclaco
// where claco_g_financiero = :str.g_financiero and
//		 claco_empresa = :str.empresa 
//order by claco_codigo;
//open cr_clave;
//fetch cr_clave into :ls_clave;
//do while li_cont <> li_num_cv
//	li_cont++
//	fetch cr_clave into :ls_clave;
//loop
//close cr_clave;
////////////////////////////////////////
//

//DW3.scrolltorow(dw3.rowcount())
//DW3.scrolltorow(1)
DW3.groupcalc()
//DW3.scrolltorow(1)  //se comento el de arriba y se habilito este

dw_1.SetFocus()
dw_1.setcolumn('prod_producto')

dw_1.postevent('ue_postitemchanged') // 95-Y46220

end event

event dw_1::ue_microayuda;////Para cuando pasa por encima del objeto
////Override
return
//
//Integer li_pos, li_x, li_y,li_largo
//String ls_objeto, ls_col
//
//ls_objeto = This.GetObjectAtPointer()
//li_pos = pos  (ls_objeto,"~t")
//ls_col = left (ls_objeto, li_pos - 1)
//
////li_x	 = str.frame.GetActiveSheet ().PointerX () 
////li_largo = len("Haga click para ordenar por la Columna de " + this.describe(ls_col+".text"))*28
//
//
////li_y	 = str.frame.GetActiveSheet ().PointerY () - 200
//
//// Dependiendo de la Columna el Mensaje de Ayuda varía
//CHOOSE CASE ls_col
//	CASE 'producto_t'
//		this.Modify("producto_t.Font.Underline='1'")
//		this.Modify("producto_t.Color='63743'")
//	CASE ELSE
//		this.Modify("producto_t.Font.Underline='0'")
//		this.Modify("producto_t.Color='16316664'")
//
//END CHOOSE
end event

event dw_1::buttonclicked;call super::buttonclicked;if dwo.name = 'b_buscar' then
	This.Postevent("ue_buscar")		
end if
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged; 
DataWindowChild dwc_producto
 
IF dwo.name = "prod_producto" AND NOT ib_producto_cargado THEN
    SetPointer(HourGlass!)
    
    IF This.GetChild("prod_producto", dwc_producto) = 1 THEN
        dwc_producto.SetTransObject(SQLCA)
        dwc_producto.Retrieve(str.g_financiero, str.empresa)
		  gf_hay_data_child(dwc_producto)
        ib_producto_cargado = True
    END IF
    
    SetPointer(Arrow!)
END IF
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_in_movi_prod_kardex
boolean visible = false
integer x = 14
integer y = 520
integer width = 3447
integer height = 1584
integer taborder = 20
end type

type dw_2 from datawindow within w_in_movi_prod_kardex
event ue_post_item ( )
integer x = 2944
integer width = 571
integer height = 272
integer taborder = 90
boolean bringtotop = true
string dataobject = "dw_in_fecha_kardex_sel"
boolean border = false
end type

event ue_post_item();string ls_pro, ls_costo
decimal{2} ld_costo
integer i
ls_pro = dw1.GetItemString (dw1.GetRow(),'prod_producto')

//If str_opcion.opcion_ventana = 'P' Then  //General**********************//
//	If str_opcion.opcion_menu = 'MG' &
//	Or str_opcion.opcion_menu = 'MCP' Then
//      If ls_pro = "" Then
//	      MessageBox('-----Aviso-----','Seleccione el Producto',StopSign!)
//	      Return		
//      Else
	      dw3.reset()	
	      dw4.reset()
	      wf_recuperar()
		dw_3.setitem(1,'ver_en_letras',ii_letra_por_default)	
		dw_3.setitem(1,'costo_en_letras',ii_costo_en_letras)		

		for i = 1 to dw_3.rowcount()
			yield()
				if dw_3.getitemstring(i,'dmov_aplicacion') = 'IN' then
					ld_costo = dw_3.getitemnumber(i,'dmov_costo_cif')
					ls_costo = gf_clave_costos_sin_select(ld_costo, is_cadena_costo)
				else
					ld_costo = dw_3.getitemnumber(i,'dmov_precio')
					ls_costo = gf_clave_costos_sin_select(ld_costo, is_cadena_costo)
				end if
				dw_3.setitem(i,'valor_en_letras',ls_costo)
				ld_costo = dw_3.getitemnumber(i,'porc_venta')
				ls_costo = gf_clave_costos_sin_select(ld_costo, is_cadena_costo)
				dw_3.setitem(i,'margen_en_letras',ls_costo)
		next
		ld_costo = dw_3.getitemnumber(1,'margen_final_numero')
		ls_costo = gf_clave_costos_sin_select(ld_costo, is_cadena_costo)
		dw_3.object.margen_final_letras.expression = "'"+ls_costo+"'"

//      End If	
//	end if
//end if
dw3.SetFocus()
//DW3.scrolltorow(dw3.rowcount())
DW3.scrolltorow(1)
DW3.groupcalc()

//dw2.setitem(1,'fecha_inicial',fecha_inicial)
//dw2.setitem(1,'fecha_final',fecha_final)

end event

event itemchanged;String ls_pro, ls_tipo ,ls_bod
dw1.AcceptText()
dw2.accepttext()

//ls_pro = dw1.GetItemString (dw1.GetRow(),'prod_producto')

//If str_opcion.opcion_ventana = 'P' Then  //General**********************//
//	If str_opcion.opcion_menu = 'MG' &
//	Or str_opcion.opcion_menu = 'MCP' Then
//      If ls_pro = "" Then
//	      MessageBox('-----Aviso-----','Seleccione el Producto',StopSign!)
//	      Return		
//      Else

//	      dw3.reset()	
//	      dw4.reset()
//	      wf_recuperar()

//      End If	
//	end if
//end if
//dw3.SetFocus()
//DW3.scrolltorow(dw3.rowcount())
//DW3.scrolltorow(1)
//DW3.groupcalc()

//dw2.reset()
//dw_2.insertrow(1)
//dw2.setitem(1,'fecha_inicial',fecha_inicial)
//dw2.setitem(1,'fecha_final',fecha_final)

this.postevent('ue_post_item')
end event

event clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.
accepttext()

date 	ld_date,ld_ini_date, ld_hoy

if dwo.name='calendario' then
	ld_ini_date=dw_2.GetItemDate(dw_2.getrow(),"fecha_inicial")
	if year(ld_ini_date) = 1900 then
		ld_ini_date = ld_hoy
	end if
	if uo_1.visible=false then
		uo_1.wf_set_value(ld_ini_date)
		uo_1.visible=true
		uo_1.allow_close=false
		uo_1.inicializar()
		uo_1.TriggerEvent('ue_abrir')
	end if
elseif dwo.name='calendario2' then
	ld_ini_date=dw_2.GetItemDate(dw_2.getrow(),"fecha_final")
	if year(ld_ini_date) = 1900 then
		ld_ini_date = ld_hoy
	end if
	if uo_2.visible=false then
		uo_2.wf_set_value(ld_ini_date)
		uo_2.visible=true
		uo_2.allow_close=false
		uo_2.inicializar()
		uo_2.TriggerEvent('ue_abrir')
	end if

end if
end event

type dw_bodega from datawindow within w_in_movi_prod_kardex
integer x = 855
integer y = 156
integer width = 270
integer height = 80
integer taborder = 40
boolean bringtotop = true
boolean border = false
end type

event itemchanged;string ls_prod
str.frame.SetRedraw(TRUE)

If dw6.GetColumnName() = 'abod_bodega' Then
	dw1.AcceptText()
	ls_prod=dw1.GetItemString(dw1.GetRow(),'prod_producto')
	If ls_prod = "" Then
		MessageBox('-----Aviso-----','Seleccione el Producto a Consultar',StopSign!)
		str.frame.Setredraw(true)		
		Return 2
	End If
	
	If str_opcion.opcion_menu = 'TR' Then
		dw5.AcceptText()
		is_tipo_trans = dw5.GetItemString(dw5.GetRow(),'mser_tipo_transaccion')
		If is_tipo_trans = "" Then
		   MessageBox('-----Aviso-----','Seleccione la Transaccion a Consultar',StopSign!)
			str.frame.Setredraw(true)			
		   Return 2
	   End If
   End If
	
	dw3.reset()	
	dw4.reset()
	dw7.reset()
	dw7.insertrow(0)
	dw6.AcceptText()
	is_bodega = dw6.GetItemString(dw6.GetRow(),'abod_bodega')
	dw6.Retrieve(str.g_financiero,str.empresa,is_bodega)

	If str_opcion.opcion_menu = 'TR' and str_opcion.opcion_ventana = 'B'Then
		wf_recuperar()			// coment by hgn
	ElseIf str_opcion.opcion_menu = 'TR' and str_opcion.opcion_ventana = 'U'Then
	   iwc_ubicacion.SetFilter("ubic_bodega='"+is_bodega+"'")
      iwc_ubicacion.Filter()
   	dw7.setfocus()
   ElseIf str_opcion.opcion_ventana = 'B' and str_opcion.opcion_menu = 'MG'  Then

		wf_recuperar()	// coment by hgn

	ElseIf str_opcion.opcion_ventana = 'B' and  str_opcion.opcion_menu = 'MCP' Then

		wf_recuperar()	// coment by hgn
		
	ElseIf str_opcion.opcion_ventana = 'U' and str_opcion.opcion_menu = 'MG' Then
		iwc_ubicacion.SetFilter("ubic_bodega='"+is_bodega+"'")
      iwc_ubicacion.Filter()
   	dw7.setfocus()
	ElseIf str_opcion.opcion_ventana = 'U' and str_opcion.opcion_menu = 'MCP' Then
		iwc_ubicacion.SetFilter("ubic_bodega='"+is_bodega+"'")
      iwc_ubicacion.Filter()
   	dw7.setfocus()
	ElseIf str_opcion.opcion_menu = 'PRO' Then
		If str_opcion.opcion_ventana = 'B' Then
			wf_promedio() ///
		Else
			iwc_ubicacion.SetFilter("ubic_bodega='"+is_bodega+"'")
         iwc_ubicacion.Filter()
   	   dw7.setfocus()
		End If
	End If	
End If
dw_ubicacion.setfocus()

str.frame.Setredraw(true)
	
	
		
	
	

	
end event

type st_bodega from statictext within w_in_movi_prod_kardex
integer x = 603
integer y = 164
integer width = 206
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Bodega"
boolean focusrectangle = false
end type

type dw_ubicacion from datawindow within w_in_movi_prod_kardex
integer x = 1403
integer y = 156
integer width = 270
integer height = 80
integer taborder = 70
boolean bringtotop = true
boolean border = false
boolean livescroll = true
end type

event itemchanged;str.frame.SetRedraw(TRUE)

string ls_prod
If dw7.GetColumnName() = 'dmov_ubicacion' Then
	dw1.AcceptText()
	ls_prod=dw1.GetItemString(dw1.GetRow(),'prod_producto')
	If ls_prod = "" Then
		MessageBox('-----Aviso-----','Seleccione el Producto a Consultar',StopSign!)
		str.frame.Setredraw(true)		
		Return 2
	End If
	
	dw6.AcceptText()
	is_bodega = dw6.GetItemString(dw6.GetRow(),'abod_bodega')
	If is_bodega = "" Then
		MessageBox('-----Aviso-----','Seleccione la Bodega a Consultar',StopSign!)
		str.frame.Setredraw(true)		
		Return 2
	End If
	
	If str_opcion.opcion_menu = 'TR' Then
		dw5.AcceptText()
		is_tipo_trans = dw5.GetItemString(dw5.GetRow(),'mser_tipo_transaccion')
		If is_bodega = "" Then
		   MessageBox('-----Aviso-----','Seleccione la Transaccion a Consultar',StopSign!)
			str.frame.Setredraw(true)			
		   Return 2
	   End If
	End If
	
	dw3.reset()	
	dw4.reset()
	dw7.AcceptText()
	is_ubicacion = dw7.GetItemString(dw7.GetRow(),'dmov_ubicacion')
	dw7.Retrieve(str.g_financiero,str.empresa,is_bodega,is_ubicacion)
	
	If str_opcion.opcion_menu = 'TR' and str_opcion.opcion_ventana = 'U'Then
		wf_recuperar()				
   ElseIf str_opcion.opcion_ventana = 'U' and str_opcion.opcion_menu = 'MG' Then
		wf_recuperar()	
	ElseIf str_opcion.opcion_ventana = 'U' and str_opcion.opcion_menu = 'MCP' Then
		wf_recuperar()		
	ElseIf str_opcion.opcion_menu = 'PRO' and str_opcion.opcion_ventana = 'U' Then
		wf_promedio()
	End If	
End If

str.frame.Setredraw(true)
end event

type dw_3 from datawindow within w_in_movi_prod_kardex
event ue_dwnkey pbm_dwnkey
event ue_sobre pbm_nchittest
integer x = 18
integer y = 348
integer width = 4238
integer height = 1740
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "Detalle de Movimientos del Producto"
string dataobject = "dw_in_mcp_prod_kard_1"
boolean vscrollbar = true
boolean border = false
string icon = "UserObject5!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_dwnkey;integer li_fila
choose case key
	case KeyF3!
		str.frame.setredraw(false)
		if ii_letra_por_default = 1 then
			ii_letra_por_default = 0
		else
			ii_letra_por_default = 1
		end if
		dw_3.setitem(1,'ver_en_letras',ii_letra_por_default)
		li_fila = dw_3.getrow()
		dw_3.scrolltorow(dw_3.rowcount())
		dw_3.scrolltorow(li_fila)
		str.frame.setredraw(true)
	case KeyF4!
		str.frame.setredraw(false)
		if ii_costo_en_letras = 0 then
			ii_costo_en_letras = 1
		else
			ii_costo_en_letras = 0
		end if
		  UPDATE usuarios  
			  SET usua_costo_en_letras = :ii_costo_en_letras  
			WHERE usuarios.usua_id = :str.usuario   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al buscar default de costo en letras '+sqlca.sqlerrtext,1,1,'E')
			end if
		dw_3.setitem(1,'costo_en_letras',ii_costo_en_letras)		
		str.frame.setredraw(true)
end choose

//// Gianni Araúz (11/10/1999)
//// Este script hace que aparezca el nombre del DataWindow Object y el nombre de la
//// columna cuando se presionan las teclas "Control" y "N".
//
//long         ll_encontro,ll_fila
//string		 ls_clase, ls_dw='', ls_columna='', ls_columna1='',ls_expresion
//str_in_bus_var str_busqueda
//	
//if keydown(keycontrol!) and keydown(keyN!) then
//	ls_dw = this.DataObject
//	Clipboard(ls_dw)
//	ls_columna = GetColumnName()
//	ls_columna1 = describe('#'+string(GetColumn())+'.dbname')
//	if isnull(ls_columna) or trim(ls_columna) = '' then return
//	if isnull(ls_columna1) or trim(ls_columna1) = '' then return
//	if trim(ls_columna) = trim(ls_columna1) then
//		MessageBox('NOMBRE DEL DATAWINDOW: '+ls_dw,'NOMBRE DE LA COLUMNA: '+ls_columna,&
//			Information!)
//	else
//		MessageBox('NOMBRE DEL DATAWINDOW: '+ls_dw,'NOMBRE DE LA COLUMNA: '+ls_columna+&
//					'~nNOMBRE EN LA BASE DE DATOS: '+ls_columna1)
//	end if
//end if
//
//// Modificado por Gianni Araúz (30/05/2000)
//// Para el caso de los reportes, sólo debe mostrar el nombre del DataWindow
//
//if keydown(keycontrol!) and keydown(keyM!) then
//	ls_dw = this.DataObject
//	if isnull(ls_dw) or trim(ls_dw) = '' then return
//	MessageBox('Ventana: '+parent.classname(),'NOMBRE DEL DATAWINDOW: '+ls_dw,Information!)
//elseif keydown(KeyF5!) then
//	dw_1.triggerevent('itemchanged')
//end if
//
///* No debe pasar si hay registros en blanco */
//if this.rowcount() < 1 then return 
//
//if (keydown(keyControl!) and keydown(KeyD!)) then
//	IF not  is_busqueda = 'D' then is_prod_buscar = ''
//	is_busqueda = 'D'
//	
//
//	str_busqueda.opcion = 'C'
//	str_busqueda.ventana = iw_this	
//	openwithparm(w_in_co_busqueda,str_busqueda)
//	
//		if is_prod_buscar <> '' then
//			ls_expresion = "dmov_documento = '"+is_prod_buscar+"'"
////			ll_fila = this.getrow() + 1
//			ll_fila = 1
//			if ll_fila >= this.rowcount() then return
//			ll_encontro = this.find(ls_expresion, ll_fila ,this.rowcount())
//			if ll_encontro > 0 then
//				this.scrolltorow(ll_encontro)
//			else
//				ls_expresion = "dmov_documento like '%"+is_prod_buscar+"%'"
//				ll_encontro = this.find(ls_expresion, ll_fila ,this.rowcount())
//				if ll_encontro > 0 then
//					this.scrolltorow(ll_encontro)
//				else
//					gf_mensaje("","Documento no Encontrado",1,1,"E")
//				end if
//			end if
//		end if
//end if
//
//if (keydown(keyControl!) and keydown(KeyC!)) then
//	IF not  is_busqueda = 'C' then is_prod_buscar = ''
//	is_busqueda = 'C'
//
//	str_busqueda.opcion = 'C'
//	str_busqueda.ventana = iw_this
//	
//
//	
//	openwithparm(w_in_co_busqueda,str_busqueda)
//	
//		if is_prod_buscar <> '' then
//			ls_expresion = "cliente = '"+is_prod_buscar+"'"
////			ll_fila = this.getrow() + 1
//			ll_fila = 1
//			if ll_fila >= this.rowcount() then return
//			ll_encontro = this.find(ls_expresion, ll_fila ,this.rowcount())
//			if ll_encontro > 0 then
//				this.scrolltorow(ll_encontro)
//			else
//				ls_expresion = "cliente like '%"+is_prod_buscar+"%'"
//				ll_encontro = this.find(ls_expresion, ll_fila ,this.rowcount())
//				if ll_encontro > 0 then
//					this.scrolltorow(ll_encontro)
//				else
//					gf_mensaje("","Cliente o Proveedor no Encontrado",1,1,"E")
//				end if
//			end if
//		end if
//end if
//
//if (keydown(keyControl!) and keydown(KeyI!)) then
//	IF not  is_busqueda = 'E' then is_prod_buscar = ''	
//	is_busqueda = 'E'
//
//	str_busqueda.opcion =  is_busqueda
//	str_busqueda.ventana = iw_this
//	
//
//	
//	openwithparm(w_in_co_busqueda,str_busqueda)
//	
//		if is_prod_buscar <> '' then
//			ls_expresion = "tmov_no_pedido = '"+is_prod_buscar+"'"
////			ll_fila = this.getrow() + 1
//			ll_fila = 1
//			if ll_fila >= this.rowcount() then return
//			ll_encontro = this.find(ls_expresion, ll_fila ,this.rowcount())
//			if ll_encontro > 0 then
//				this.scrolltorow(ll_encontro)
//			else
//				ls_expresion = "tmov_no_pedido like '%"+is_prod_buscar+"%'"
//				ll_encontro = this.find(ls_expresion, ll_fila ,this.rowcount())
//				if ll_encontro > 0 then
//					this.scrolltorow(ll_encontro)
//				else
//					gf_mensaje("","Numero de Pedido no Encontrado",1,1,"E")
//				end if
//			end if
//		end if
//end if
//
//
//
//if (keydown(keyControl!) and keydown(KeyS!)) then
//	IF not  is_busqueda = 'S' then is_prod_buscar = ''	
//	is_busqueda = 'S'
//
//	str_busqueda.opcion =  is_busqueda
//	str_busqueda.ventana = iw_this
//	
//
//	
//	openwithparm(w_in_co_busqueda,str_busqueda)
//	
//		if is_prod_buscar <> '' then
//			ls_expresion = "dmov_secuencia = "+is_prod_buscar+""
////			ll_fila = this.getrow() + 1
//			ll_fila = 1
//			if ll_fila >= this.rowcount() then return
//			ll_encontro = this.find(ls_expresion, ll_fila ,this.rowcount())
//			if ll_encontro > 0 then
//				this.scrolltorow(ll_encontro)
//			else
//				ls_expresion = "STRING(dmov_secuencia) like '%"+is_prod_buscar+"%'"
//				ll_encontro = this.find(ls_expresion, ll_fila ,this.rowcount())
//				if ll_encontro > 0 then
//					this.scrolltorow(ll_encontro)
//				else
//					gf_mensaje("","Secuencia no Encontrada",1,1,"E")
//				end if
//			end if
//		end if
//end if
//
//
//
//if (keydown(keyControl!) and keydown(KeyP!)) then
//	ll_fila = this.getrow() + 1
////	if ll_fila >= this.rowcount() then return
//	ll_encontro = this.find(ls_expresion, ll_fila ,this.rowcount())
//	if ll_encontro > 0 then
//		this.scrolltorow(ll_encontro)
//	else
//		if is_busqueda = 'C' then
//			if ll_fila > this.rowcount() then ll_fila = 1
//			ls_expresion = "cliente like '%"+is_prod_buscar+"%'"
//			ll_encontro = this.find(ls_expresion, ll_fila ,this.rowcount())
//			if ll_encontro > 0 then
//				this.scrolltorow(ll_encontro)
//			else
//				ll_fila = 1
//				ls_expresion = "cliente like '%"+is_prod_buscar+"%'"
//				ll_encontro = this.find(ls_expresion, ll_fila ,this.rowcount())
//				this.scrolltorow(ll_encontro)
//			end if
//		else
//			if ll_fila > this.rowcount() then ll_fila = 1
//			ls_expresion = "dmov_documento like '%"+is_prod_buscar+"%'"
//			ll_encontro = this.find(ls_expresion, ll_fila,this.rowcount())
//			if ll_encontro > 0 then
//				this.scrolltorow(ll_encontro)
//			else
//				ll_fila = 1
//				ls_expresion = "dmov_documento like '%"+is_prod_buscar+"%'"
//				ll_encontro = this.find(ls_expresion, ll_fila ,this.rowcount())
//				this.scrolltorow(ll_encontro)
//			end if
//		end if
//	end if
//end if
//
//if (keydown(keyControl!) and keydown(KeyB!)) then
//	ll_fila = this.getrow() - 1
//	if ll_fila >= this.rowcount() then return
//	ll_encontro = this.find(ls_expresion, ll_fila,1)
//	if ll_encontro > 0 then
//		this.scrolltorow(ll_encontro)
//	else
//		if is_busqueda = 'C' then
//			if ll_fila = 0 then ll_fila = this.rowcount()
//			ls_expresion = "cliente like '%"+is_prod_buscar+"%'"
//			ll_encontro = this.find(ls_expresion, ll_fila,1)
//			if ll_encontro > 0 then
//				this.scrolltorow(ll_encontro)
//			else
//				ll_fila = this.rowcount() 
//				ls_expresion = "cliente like '%"+is_prod_buscar+"%'"
//				ll_encontro = this.find(ls_expresion, ll_fila ,1)
//				this.scrolltorow(ll_encontro)
//			end if
//		else
//			if ll_fila = 0 then ll_fila = this.rowcount()
//			ls_expresion = "dmov_documento like '%"+is_prod_buscar+"%'"
//			ll_encontro = this.find(ls_expresion, ll_fila,1)
//			if ll_encontro > 0 then
//				this.scrolltorow(ll_encontro)
//			else
//				ll_fila = this.rowcount()
//				ls_expresion = "dmov_documento like '%"+is_prod_buscar+"%'"
//				ll_encontro = this.find(ls_expresion, ll_fila ,1)
//				this.scrolltorow(ll_encontro)
//			end if
//		end if
//	end if
//end if
//
//
//if (keydown(keyControl!) and keydown(KeyU!)) then
//	if this.getitemstring(this.getrow(),'dmov_tipo_transaccion')  = 'EN' then
//		Window lw_child_v	
//		str_busqueda.opcion = 'Automa' 
//		str_busqueda.aplicacion = 'IN'
//		str_busqueda.transaccion = 'EN'
//		str_busqueda.concepto = this.getitemstring(this.getrow(),'intmovim_tmov_concepto')
//		str_busqueda.secuencia = this.getitemnumber(this.getrow(),'dmov_secuencia')
//		str_busqueda.ann = year(date(this.getitemdatetime(this.getrow(),'intmovim_tmov_fecha')))	
//		OpenSheetWithParm(lw_child_v,str_busqueda,"w_in_con_entrada",str.frame,11,original!)
//	end if
//end if
//
//
//
// 
//
//
//
end event

event ue_sobre;//Para cuando pasa por encima del objeto
//Override
return

Integer li_pos, li_x, li_y,li_largo
String ls_objeto, ls_col

ls_objeto = This.GetObjectAtPointer()
li_pos = pos  (ls_objeto,"~t")
ls_col = left (ls_objeto, li_pos - 1)

//li_x	 = str.frame.GetActiveSheet ().PointerX () 
//li_largo = len("Haga click para ordenar por la Columna de " + this.describe(ls_col+".text"))*28


//li_y	 = str.frame.GetActiveSheet ().PointerY () - 200

// Dependiendo de la Columna el Mensaje de Ayuda varía
CHOOSE CASE ls_col
	CASE 't_reserva'
		this.Modify("t_reserva.Font.Underline='1'")
		this.Modify("t_reserva.Color='16711680'")
	CASE 'dmov_documento'
		this.Modify("dmov_documento.Font.Underline='1'")
		this.Modify("dmov_documento.Color='2047'")//'7536640'")
	CASE 'tmov_nombre_tercero'
		this.Modify("tmov_nombre_tercero.Font.Underline='1'")
		this.Modify("tmov_nombre_tercero.Color='2047'")

	CASE ELSE
		this.Modify("t_reserva.Font.Underline='0'")
		this.Modify("t_reserva.Color='0'")
		this.Modify("dmov_documento.Font.Underline='0'")
		this.Modify("dmov_documento.Color='0'")
		this.Modify("tmov_nombre_tercero.Font.Underline='0'")
		this.Modify("tmov_nombre_tercero.Color='0'")

END CHOOSE
end event

event clicked;dw=dw_3

//Llama a la ventana de Pedidos Reservados
String ls_producto, ls_objeto, ls_null, ls_foto, ls_error, ls_nombre, ls_expresion
integer li_pos, li_ann
long ll_tercero,ll_secuencia
time lt_time

lt_time = time('')
ls_objeto = dwo.name

if ls_objeto = 'reserva' or ls_objeto = 'reserva_fraccion' or ls_objeto = 't_reserva' then
	
	str_fa_formato lstr_datawindow
	lstr_datawindow.datawindow = "dw_fa_rep_reserva_existencia_new"
	ls_producto = dw_1.getitemstring(1,"prod_producto")
	lstr_datawindow.producto = ls_producto
	
	OpenSheetWithParm(w_disponibles,lstr_datawindow, str.frame,2, Original!)
	
elseif ls_objeto = "dmov_documento" then
	
	if row = 0 then return
	
	if dw_3.getitemstring(row,"dmov_aplicacion") <> "FA" then	 return
	str_secuencia_doc lstr_sec
	lstr_sec.ano = dw_3.getitemNumber(row,"dmov_anual")
	lstr_sec.sec_manual = dw_3.getitemstring(row,"dmov_documento")
	opensheetwithparm(w_facturas_actualizadas, lstr_sec,str.frame,2,layered!)

elseif ls_objeto = "dmov_secuencia" then
		
		if dw_3.getitemstring(row,"dmov_aplicacion") <> "IN" then return			
		if dw_3.getitemstring(row,"dmov_tipo_transaccion") = "EN" then 
			ll_secuencia = dw_3.getitemnumber(row,'dmov_secuencia')
			li_ann			= dw_3.getitemnumber(row,'dmov_anual')
			dw_7.retrieve(str.g_financiero, str.empresa, ll_secuencia , li_ann)
			if dw_7.rowcount() = 0 then return
			ls_expresion = str.nombre_empresa
			dw_7.object.nom_empresa.expression = "'"+ls_expresion+"'"
			dw_7.visible = true
		elseif dw_3.getitemstring(row,"dmov_tipo_transaccion") = "AE" then 
			ll_secuencia = dw_3.getitemnumber(row,'dmov_secuencia')
			li_ann			= dw_3.getitemnumber(row,'dmov_anual')
			dw_8.retrieve(str.g_financiero, str.empresa, ll_secuencia , li_ann)
			if dw_8.rowcount() = 0 then return
			ls_expresion = str.nombre_empresa
			dw_8.object.nom_empresa.expression = "'"+ls_expresion+"'"
			dw_8.object.datawindow.print.preview = 'yes'
			dw_8.visible = true
			
		end if
elseif ls_objeto = "cliente" or ls_objeto = "tmov_nombre_tercero"  then
		if dw_3.getitemstring(row,"dmov_aplicacion") <> "FA" then return
	
		str_cc_formatos str_formato1		
		str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
		str_formato1.tercero = dw_3.getitemNumber(row,"tmov_terceros")
		date ldt_fecha
		ldt_fecha = date(gf_fecha_serv())
		lstr_rangfech.fecha1 = date('01/01/'+string(year(ldt_fecha) - 1 ))
		lstr_rangfech.fecha2 = ldt_fecha
	
		//Elimina las tablas temporales 
	  DELETE FROM ccatpan  
		WHERE ( ccatpan.tpan_g_financiero = :str.g_financiero ) AND  
				( ccatpan.tpan_empresa = :str.empresa ) AND  
				( ccatpan.tpan_maquina = :str.maquina )   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje('Aviso','Error al eliminar ccatpan',ls_error)
			return
		end if
			
		DELETE FROM ccatempa
		WHERE ( ccatempa.tmpa_g_financiero 	= :str.g_financiero 	) AND  
				( ccatempa.tmpa_empresa 		= :str.empresa 		) and
				( ccatempa.tmpa_usuario_maquina = :str.maquina 		) ;
		if sqlca.sqlcode = -1 then
			messagebox('error','error al elimianr registros desde ccatempa')
		end if
		
		  DELETE FROM ccatemaf
			WHERE ( tmaf_g_financiero = :str.g_financiero ) AND  
					( tmaf_empresa = :str.empresa ) AND  
					( tmaf_usuario_maquina = :str.maquina )   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje('Aviso','Error al eliminar ccatemaf',ls_error)
			return
		end if
		
		DELETE FROM cchestado  
		WHERE ( cchestado.est_g_financiero =:str.g_financiero  ) AND  
				( cchestado.est_empresa =:str.empresa  ) AND  
				( cchestado.est_usuario_maquina =:str.maquina  )   ;
		if sqlca.sqlcode = -1 then
			mensaje('Error','Error eliminando de cchestado','')
		end if
	
		lstr_rangfech.opcion = 'P'
		lstr_rangfech.mensaje = "P"
		lstr_rangfech.cadena = "N"
		lstr_rangfech.tipo_orden = 'C'//ruc
		lstr_rangfech.tipo_accion = '1'  //solo con movimientos
		lstr_rangfech.idioma = 'E' // en espanol
		lstr_rangfech.tip_cliente = 'T'//todos
		lstr_rangfech.preimpreso = 'N'//preimpresos
		lstr_rangfech.tipo_fecha  = '2'  
		lstr_rangfech.piepag      = '2'  
		lstr_rangfech.tipocliente = 'N'
		lstr_rangfech.tipo_orden = 'A'
		string ls_ruc
		  SELECT ccmclien.clie_ruc_tercero, dgmterce.terc_descripcion  
		 INTO :ls_ruc , :ls_nombre 
		 FROM ccmclien,   
				dgmterce  
		WHERE ( ccmclien.clie_tercero = dgmterce.terc_tercero ) and  
				( ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
				( ccmclien.clie_empresa = :str.empresa ) AND  
				( ccmclien.clie_tercero = :str_formato1.tercero ) )   ;

		lstr_rangfech.nombre1 = ls_nombre+string(str_formato1.tercero)
		lstr_rangfech.nombre2 = ls_nombre+string(str_formato1.tercero)
	
		
		lstr_rangfech.desdeclienteref = ls_ruc//str_formato1.tercero
		lstr_rangfech.hastaclienteref = ls_ruc//str_formato1.tercero
							
		if not isnull(lstr_rangfech.fecha1) and not isnull(lstr_rangfech.fecha2) or &
				lstr_rangfech.fecha1 <> date('00/00/0000') and lstr_rangfech.fecha2 <> date('00/00/0000')then
				commit using sqlca;
				wf_actualiza_antiguedad('E')
				OpenSheetWithParm(w_estadocuenta_imp,lstr_rangfech,str.frame,2, layered!)			
		end if	
	
	
	//Opensheetwithparm(w_estadocuenta,str_formato1,str.frame,2,original!)
	
	
	

	
	//Opensheetwithparm(w_estadocuenta,str_formato1,str.frame,2,original!)
//	dw_3.trigger event doubleclicked(1,1,row,object)
elseif ls_objeto = "inmprodu_prod_foto_dir_1" then
	setnull(ls_null)
	ls_foto = this.getitemstring(1, "inmprodu_prod_foto_dir_1")
	if fileexists(ls_foto) then
//		if isvalid(w_imagen) then
//			close(w_imagen)		
//		end if
		
//		openwithparm(w_imagen, ls_foto)
		
		//Run("C:\WINDOWS\system32\mspaint.exe "+ls_foto, Maximized!)
		//shellExecuteA(Handle(this),ls_null, "rundll32.exe %SystemRoot%\system32\shimgvw.dll,ImageView_Fullscreen", ls_null , ls_null, 1 )				
		//shellExecuteA(Handle(this),ls_null, "C:\WINDOWS\system32\mspaint.exe", ls_foto , ls_null, 1 )		
		
	else
		gf_mensaje("","La foto no ha sido asignada o no se encuentra la ruta, verifique !!!",1,1,"E")
	end if
end if
end event

event retrieveend;decimal ll_costo,ll_precio
string ls_clave_costo 
/* Asigna el Mod a los campos*/
/* Bloque de If salta el saldo ( and false )  * * Alexis Receda 15 / V / 2001 */

//If this.rowcount() = 0 and false Then
If this.rowcount() = 0  Then
//	mensaje("Atención ","No hay data para este informe ","")
//	this.insertrow(0)
	this.setredraw(true)
	Return
End If

dw_3.SetRedraw(TRUE)
/* Alexis Receda - 18 Dic 2000 */
/* 1 */
//this.object.entrada2.Expression = string(mod(round(this.getitemnumber(1,"entradas"),6),round(this.getitemnumber(1,"inamedid_medida_producto"),6)))
//this.object.salida2.Expression = string(mod(round(this.getitemnumber(1,"salidas"),6),round(this.getitemnumber(1,"inamedid_medida_producto"),6)))
//this.object.ajuste2.Expression = string(mod(round(this.getitemnumber(1,"ajustes"),6),round(this.getitemnumber(1,"inamedid_medida_producto"),6)))
//this.object.total2.Expression = string(mod(round(this.getitemnumber(1,"total"),6),round(this.getitemnumber(1,"inamedid_medida_producto"),6)))
//
//integer i 

//for i = 1 to this.rowcount() 
//	this.setitem(i,"frac",mod( round(this.getitemnumber(i,"fila1"),6) , round(this.getitemnumber(1,"inamedid_medida_producto"),6) ) )
//next
/* 1 */

if is_costo_en_clave = 'S' then
//	dw_3.modify("c_costo.visible = 0")
	dw_3.modify("clave_costo.visible = 1")
//	dw_3.modify("c_precio.visible = 0")
	dw_3.modify("precio_clave.visible = 1")
else
//	dw_3.modify("c_costo.visible = 1")
	dw_3.modify("clave_costo.visible = 0")
//	dw_3.modify("c_precio.visible = 1")
	dw_3.modify("precio_clave.visible = 0")
end if
IF dw_3.describe("clave_costo.x")  <> "?" AND   dw_3.describe("clave_costo.x")  <> "!" THEN 
   if dw_3.DataObject = "dw_in_prom_prod_kard_1_electro" or &
	   dw_3.DataObject = "dw_in_prom_bod_kard_1_electro" or &
		dw_3.DataObject = "dw_in_prom_ubic_kard_1_electro" or &
		dw_3.DataObject = "dw_in_prom_prod_kard_1" or &
		dw_3.DataObject = "dw_in_prom_bod_kard_1" or &
		dw_3.DataObject = "dw_in_prom_ubic_kard_1" then
		if is_costo_en_clave = 'S' then
			dw_3.modify("costo_ent.visible = 0")
			dw_3.modify("clave_costo.visible = 1")
		else
			dw_3.modify("clave_costo.visible = 0")
			dw_3.modify("costo_ent.visible = 1")
		end if
		ll_costo = dw_3.getitemnumber(dw_3.getrow(),"costo_ent")
	else
		IF dw_3.describe("c_costo.x")  <> "?" AND   dw_3.describe("c_costo.x")  <> "!" THEN 
			ll_costo = dw_3.getitemnumber(dw_3.getrow(),"c_costo")
		END IF
	end if
	if isnull(ll_costo) then ll_costo = 0
	ls_clave_costo = gf_clave_costos(ll_costo)
	if isnull(ls_clave_costo) then ls_clave_costo = '0'
//	dw_3.object.clave_costo.expression = "'"+ls_clave_costo+"'"
end if
IF dw_3.describe("precio_clave.x")  <> "?" AND   dw_3.describe("precio_clave.x")  <> "!" THEN 
	IF dw_3.describe("c_precio.x")  <> "?" AND   dw_3.describe("c_precio.x")  <> "!" THEN 
		ll_precio = dw_3.getitemnumber(dw_3.getrow(),"c_precio")
	end if
	if isnull(ll_precio) then ll_precio = 0
	ls_clave_costo = gf_clave_precios(ll_precio)
	if isnull(ls_clave_costo) then ls_clave_costo = '0'
//	dw_3.object.precio_clave.expression = "'"+ls_clave_costo+"'"
end if

dw3.SetFocus()
DW3.scrolltorow(1)

DW3.groupcalc()

dw_3.setredraw(true)

end event

event sqlpreview;//mensaje('','',sqlsyntax)
end event

event doubleclicked;//Llama a la ventana de Pedidos Reservados
String ls_producto, ls_objeto, ls_null, ls_foto, ls_error
integer li_pos
long ll_tercero

ls_objeto = dwo.name

if ls_objeto = 'reserva' or ls_objeto = 'reserva_fraccion' or ls_objeto = 't_reserva' then
	str_fa_formato lstr_datawindow
	lstr_datawindow.datawindow = "dw_fa_rep_reserva_existencia_new"
	ls_producto = dw_1.getitemstring(1,"prod_producto")
	lstr_datawindow.producto = ls_producto
	
	OpenSheetWithParm(w_disponibles,lstr_datawindow, str.frame,2, Original!)
	
elseif ls_objeto = "dmov_documento" then
	
	if row = 0 then return
	if dw_3.getitemstring(row,"dmov_aplicacion") <> "FA" then return	
	str_secuencia_doc lstr_sec
	lstr_sec.ano = dw_3.getitemNumber(row,"dmov_anual")
	lstr_sec.sec_manual = dw_3.getitemstring(row,"dmov_documento")
	opensheetwithparm(w_facturas_actualizadas, lstr_sec,str.frame,2,layered!)
elseif ls_objeto = "cliente" or ls_objeto = "tmov_nombre_tercero"  then
	if dw_3.getitemstring(row,"dmov_aplicacion") <> "FA" then return
	
		str_cc_formatos str_formato1		
		str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
		str_formato1.tercero = dw_3.getitemNumber(row,"tmov_terceros")
		date ldt_fecha
		ldt_fecha = date(gf_fecha_Serv())
		lstr_rangfech.fecha1 = date('01/01/'+string(year(ldt_fecha) - 1 ))
		lstr_rangfech.fecha2 = ldt_fecha
	
		//Elimina las tablas temporales 
	  DELETE FROM ccatpan  
		WHERE ( ccatpan.tpan_g_financiero = :str.g_financiero ) AND  
				( ccatpan.tpan_empresa = :str.empresa ) AND  
				( ccatpan.tpan_maquina = :str.maquina )   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje('Aviso','Error al eliminar ccatpan',ls_error)
			return
		end if
			
		DELETE FROM ccatempa
		WHERE ( ccatempa.tmpa_g_financiero 	= :str.g_financiero 	) AND  
				( ccatempa.tmpa_empresa 		= :str.empresa 		) and
				( ccatempa.tmpa_usuario_maquina = :str.maquina 		) ;
		if sqlca.sqlcode = -1 then
			messagebox('error','error al elimianr registros desde ccatempa')
		end if
		
		  DELETE FROM ccatemaf
			WHERE ( tmaf_g_financiero = :str.g_financiero ) AND  
					( tmaf_empresa = :str.empresa ) AND  
					( tmaf_usuario_maquina = :str.maquina )   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje('Aviso','Error al eliminar ccatemaf',ls_error)
			return
		end if
		
		DELETE FROM cchestado  
		WHERE ( cchestado.est_g_financiero =:str.g_financiero  ) AND  
				( cchestado.est_empresa =:str.empresa  ) AND  
				( cchestado.est_usuario_maquina =:str.maquina  )   ;
		if sqlca.sqlcode = -1 then
			mensaje('Error','Error eliminando de cchestado','')
		end if
	
		lstr_rangfech.opcion = 'P'
		lstr_rangfech.mensaje = "P"
		lstr_rangfech.cadena = "N"
		lstr_rangfech.tipo_orden = 'C'//ruc
		lstr_rangfech.tipo_accion = '1'  //solo con movimientos
		lstr_rangfech.idioma = 'E' // en espanol
		lstr_rangfech.tip_cliente = 'T'//todos
		lstr_rangfech.preimpreso = 'N'//preimpresos
		lstr_rangfech.tipo_fecha  = '2'  
		lstr_rangfech.piepag      = '2'  
		lstr_rangfech.tipocliente = 'N'
		lstr_rangfech.tipo_orden = 'A'
		lstr_rangfech.nombre1 = dw_3.GetItemstring(row,"tmov_nombre_tercero")+string(str_formato1.tercero)
		lstr_rangfech.nombre2 = dw_3.GetItemstring(row,"tmov_nombre_tercero")+string(str_formato1.tercero)
		string ls_ruc
		  SELECT ccmclien.clie_ruc_tercero  
		 INTO :ls_ruc  
		 FROM ccmclien,   
				dgmterce  
		WHERE ( ccmclien.clie_tercero = dgmterce.terc_tercero ) and  
				( ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
				( ccmclien.clie_empresa = :str.empresa ) AND  
				( ccmclien.clie_tercero = :str_formato1.tercero ) )   ;
	
		
		lstr_rangfech.desdeclienteref = ls_ruc//str_formato1.tercero
		lstr_rangfech.hastaclienteref = ls_ruc//str_formato1.tercero
							
		if not isnull(lstr_rangfech.fecha1) and not isnull(lstr_rangfech.fecha2) or &
				lstr_rangfech.fecha1 <> date('00/00/0000') and lstr_rangfech.fecha2 <> date('00/00/0000')then
				commit using sqlca;
				wf_actualiza_antiguedad('E')
				OpenSheetWithParm(w_estadocuenta_imp,lstr_rangfech,str.frame,2, layered!)			
		end if	
	
	
	//Opensheetwithparm(w_estadocuenta,str_formato1,str.frame,2,original!)
	
	
	
	
elseif ls_objeto = "inmprodu_prod_foto_dir_2" then
	setnull(ls_null)
	ls_foto = this.getitemstring(1, "inmprodu_prod_foto_dir_1")
	if fileexists(ls_foto) then
		//shellExecuteA(Handle(this),ls_null, "C:\WINDOWS\system32\mspaint.exe", ls_foto , ls_null, 1 )
		
//		openwithparm(w_imagen, ls_foto)
	else
		gf_mensaje("","La foto no ha sido asignada o no se encuentra la ruta, verifique !!!",1,1,"E")
	end if
	
end if
end event

type dw_transaccion from datawindow within w_in_movi_prod_kardex
integer x = 315
integer y = 152
integer width = 265
integer height = 80
integer taborder = 30
boolean bringtotop = true
boolean border = false
boolean livescroll = true
end type

event itemchanged;call super::itemchanged;String ls_produ

If dw5.GetColumnName() = 'mser_tipo_transaccion' Then
	
	dw1.AcceptText()
	dw5.AcceptText()
	ls_produ = dw1.GetItemString(dw1.GetRow(),'prod_producto')
	If ls_produ = "" Then
		MessageBox('-----Aviso----','Seleccione el Producto',StopSign!)
		dw5.Reset()
		dw5.InsertRow(0)

		Return
	End If
	is_tipo_trans = dw5.GetItemString(dw5.GetRow(),'mser_tipo_transaccion')
	

	dw5.Retrieve(str.g_financiero,str.empresa,str.aplicacion,is_tipo_trans)
	

	If dw_transaccion.Rowcount() > 0 Then
		 is_trans_descrip = dw5.GetItemString(dw5.GetRow(),'mser_descripcion')
	End If
	dw3.reset()	
	dw4.reset()
		
//	If str_opcion.opcion_menu = 'TR' and str_opcion.opcion_ventana = 'P' Then
	
	If str_opcion.opcion_ventana = 'P' or str_opcion.opcion_ventana = 'B' or &
	   str_opcion.opcion_ventana = 'U' Then

		wf_recuperar()			
	Else
		dw6.SetFocus()
	End If
	
End If

dw_bodega.setfocus()	
end event

type st_1 from statictext within w_in_movi_prod_kardex
boolean visible = false
integer x = 2409
integer y = 188
integer width = 457
integer height = 68
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type ln_2 from line within w_in_movi_prod_kardex
boolean visible = false
long linecolor = 8421504
integer linethickness = 4
integer beginy = 272
integer endx = 3419
integer endy = 272
end type

type ln_1 from line within w_in_movi_prod_kardex
boolean visible = false
long linecolor = 16777215
integer linethickness = 4
integer beginy = 300
integer endx = 3419
integer endy = 300
end type

type st_ubicacion from statictext within w_in_movi_prod_kardex
integer x = 1147
integer y = 168
integer width = 233
integer height = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Ubicacion"
boolean focusrectangle = false
end type

type dw_5 from datawindow within w_in_movi_prod_kardex
boolean visible = false
integer x = 119
integer y = 824
integer width = 690
integer height = 204
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_fa_rep_reservados"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;dw_5.settransobject(sqlca)
end event

type uo_1 from u_ddcalen within w_in_movi_prod_kardex
boolean visible = false
integer x = 2757
integer y = 136
integer taborder = 31
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;dw_2.SetItem ( dw_2.getrow(), 'fecha_inicial', uo_1.return_sel_date() )

if uo_1.allow_close then
	this.visible=false
	dw_2.SetFocus()
	wf_recuperar()
end if


end event

on uo_1.destroy
call u_ddcalen::destroy
end on

type uo_2 from u_ddcalen within w_in_movi_prod_kardex
boolean visible = false
integer x = 2757
integer y = 264
integer taborder = 41
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;dw_2.SetItem ( dw_2.getrow(), 'fecha_final', uo_2.return_sel_date() )

if uo_2.allow_close then
	this.visible=false
	dw_2.SetFocus()
	wf_recuperar()
end if


end event

on uo_2.destroy
call u_ddcalen::destroy
end on

type dw_4 from datawindow within w_in_movi_prod_kardex
integer x = 2066
integer y = 2176
integer width = 1641
integer height = 280
integer taborder = 80
boolean bringtotop = true
boolean titlebar = true
string title = "Impresion del Kardex"
string dataobject = "dw_in_mcp_prod_kard_2_arriba"
boolean controlmenu = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "AppIcon!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event resize;if dw_4.height < 200 then 
	dw_4.y = dw_3.y + dw_3.height + 5
	dw_4.x = dw_3.width  - 1641
end if
end event

type dw_6 from datawindow within w_in_movi_prod_kardex
integer x = 18
integer y = 2088
integer width = 1943
integer height = 468
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dw_existencia_bodegas"
boolean border = false
boolean livescroll = true
end type

event clicked;string ls_producto

choose case dwo.name
	case 'reserva1', 'reserva2','reserva3','reserva4','reserva5','reserva6','reserva7'
			str_fa_formato lstr_datawindow
			lstr_datawindow.datawindow = "dw_fa_rep_reserva_existencia_new"
			ls_producto = dw_1.getitemstring(1,"prod_producto")
			lstr_datawindow.producto = ls_producto
			
			OpenSheetWithParm(w_disponibles,lstr_datawindow, str.frame,2, Original!)
end choose
end event

type dw_7 from datawindow within w_in_movi_prod_kardex
boolean visible = false
integer x = 608
integer y = 164
integer width = 3703
integer height = 2104
integer taborder = 50
boolean bringtotop = true
boolean titlebar = true
string title = "Entrada al Inventario"
string dataobject = "dw_rep_entrada_arriba"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean border = false
string icon = "Report5!"
boolean livescroll = true
end type

type cbx_agrupar_por_cliente from checkbox within w_in_movi_prod_kardex
integer x = 2958
integer y = 264
integer width = 640
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Agrupar por Cliente"
end type

event clicked;if this.checked then
	dw_3.setsort('cliente, intmovim_tmov_fecha, tmov_fecha_registro, dmov_fecha_registro')
else
	dw_3.setsort('intmovim_tmov_fecha, tmov_fecha_registro, dmov_fecha_registro')	
end if
dw_3.sort()

end event

type dw_8 from datawindow within w_in_movi_prod_kardex
boolean visible = false
integer x = 229
integer y = 80
integer width = 4041
integer height = 2104
integer taborder = 60
boolean bringtotop = true
boolean titlebar = true
string title = "Ajuste de Inventario"
string dataobject = "dw_rep_ajustes_costeando"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean border = false
string icon = "Report5!"
boolean livescroll = true
end type

