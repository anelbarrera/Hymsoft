//objectcomments Ventana para el Pase a Contabilidad
forward
global type w_fa_man_pase_a_conta from w_fa_padre_reportes
end type
type em_fecha_inicial from editmask within w_fa_man_pase_a_conta
end type
type em_fecha_final from editmask within w_fa_man_pase_a_conta
end type
type st_3 from statictext within w_fa_man_pase_a_conta
end type
type st_1 from statictext within w_fa_man_pase_a_conta
end type
type gb_4 from groupbox within w_fa_man_pase_a_conta
end type
type gb_2 from groupbox within w_fa_man_pase_a_conta
end type
type dw_2 from uo_outlookbar within w_fa_man_pase_a_conta
end type
type cbx_fechas from checkbox within w_fa_man_pase_a_conta
end type
type pb_1 from picturebutton within w_fa_man_pase_a_conta
end type
type r_1 from rectangle within w_fa_man_pase_a_conta
end type
type st_4 from statictext within w_fa_man_pase_a_conta
end type
type pb_2 from picturebutton within w_fa_man_pase_a_conta
end type
type dw_3 from datawindow within w_fa_man_pase_a_conta
end type
type st_2 from statictext within w_fa_man_pase_a_conta
end type
type st_5 from statictext within w_fa_man_pase_a_conta
end type
type em_1 from editmask within w_fa_man_pase_a_conta
end type
type em_2 from editmask within w_fa_man_pase_a_conta
end type
type cbx_fac from checkbox within w_fa_man_pase_a_conta
end type
type pb_3 from picturebutton within w_fa_man_pase_a_conta
end type
type gb_3 from groupbox within w_fa_man_pase_a_conta
end type
type uo_animate from u_animate within w_fa_man_pase_a_conta
end type
type cb_descartar from commandbutton within w_fa_man_pase_a_conta
end type
end forward

global type w_fa_man_pase_a_conta from w_fa_padre_reportes
string tag = "Pase a Contabilidad"
integer x = 165
integer y = 20
integer width = 3383
integer height = 1820
string title = " Pase de Factura a Contabilidad"
string menuname = "m_hs"
boolean controlmenu = false
string icon = "Application!"
boolean clientedge = true
em_fecha_inicial em_fecha_inicial
em_fecha_final em_fecha_final
st_3 st_3
st_1 st_1
gb_4 gb_4
gb_2 gb_2
dw_2 dw_2
cbx_fechas cbx_fechas
pb_1 pb_1
r_1 r_1
st_4 st_4
pb_2 pb_2
dw_3 dw_3
st_2 st_2
st_5 st_5
em_1 em_1
em_2 em_2
cbx_fac cbx_fac
pb_3 pb_3
gb_3 gb_3
uo_animate uo_animate
cb_descartar cb_descartar
end type
global w_fa_man_pase_a_conta w_fa_man_pase_a_conta

type prototypes
//function boolean beep(long dwfreq, long dwduration) LIBRARY "Kernel32"
Function boolean Beep(long dwFreq, long dwDuration) Library "Kernel32"
Function boolean ExitWindowsEx( UINT  fuOptions,uint dwReserved ) Library "User32"
Function boolean ExitWindows(uint  dwReserved,	uint uReserved ) Library "User32"
//Function boolean SystemParametersInfo (UINT wAction ,UINT wParam, ANY pvParam, UINT fWinIni ) Library "User32"
Function long SystemParametersInfoA(Long wAction ,Long wParam, String pvParam, Long fWinIni ) Library "User32" alias for "SystemParametersInfoA;Ansi"
//Funciones para la animacion


end prototypes

type variables

Integer			ii_frame
String			is_filename

//Variables de Instancia
string is_orden, is_empresa, is_nativo  //SQL original
string is_logo, is_logo_f, is_filename_avi

//datawindow dw_impresion
integer ii_ultima_seleccion, ii_ultimo_orden, ii_cont, ii_venta_por, &
            ii_linea=0
decimal id_debito, id_credito

long il_old_row

//Data Stores, para Hacer el Pase
DataStore ids_tdiari, ids_ddiari, ids_cargos, &
ids_region, ids_tipofac, ids_tipos
end variables

forward prototypes
public subroutine wf_botones ()
public subroutine wf_valida_fechas (ref date fecha_ini, ref date fecha_fin, integer desde_fecha)
public subroutine wf_preview_venta_region (integer ai_fila, datawindow adw_dw1)
public function string wf_recupera_desc_cuenta (string as_cuenta)
public subroutine wf_preview_descuento (integer ai_fila, datawindow adw_dw1)
public subroutine wf_preview_descuento_region (integer ai_fila, datawindow adw_dw1)
public function integer wf_inserta_descuento_region (integer ai_fila, datawindow adw_dw1)
public subroutine wf_elimina_registro ()
public function string wf_descripcion (integer ai_fila, datawindow adw_dw1)
public subroutine wf_preview_inserta_cliente (long ai_fila, datawindow adw_dw1)
public subroutine wf_crear_data_store (string as_tipo)
public subroutine wf_preview_cargos (integer ai_fila, datawindow adw_dw1)
public subroutine wf_setear_sql ()
public function integer wf_inserta_cargos (integer ai_fila, datawindow adw_dw1)
public subroutine wf_asigna_logos ()
public subroutine wf_crear_preview (long ai_fila, datawindow adw_dw1)
public subroutine wf_preview_venta_tipo (integer ai_fila, datawindow adw_dw1)
public function integer wf_inserta_descuento (integer ai_fila, datawindow adw_dw1)
public subroutine wf_inserta_encabezado (integer ai_fila, datawindow adw_dw1)
public function integer wf_inserta_cliente (integer ai_fila, datawindow adw_dw1)
public function integer wf_inserta_detalle (integer ai_fila, datawindow adw_dw1)
public function integer wf_inserta_venta_region (integer ai_fila, datawindow adw_dw1)
public function integer wf_inserta_venta_tipo (integer ai_fila, datawindow adw_dw1)
public subroutine wf_avance (long al_avance, long al_total)
end prototypes

public subroutine wf_botones ();//// Deshabilitar botones no necesarios.
//	m_fa_padre.m_edicin.m_siguienteregistro.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_registroanterior.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_ultimoregistro.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_primerregistro.toolbaritemvisible=false
//	m_fa_padre.m_archivo.m_vistapreliminar.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_sortear.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_filtrar.toolbaritemvisible=false
//	m_fa_padre.m_ventanas.m_zoom2.toolbaritemvisible=false
//	m_fa_padre.m_ventanas.m_zoom3.toolbaritemvisible=false
//	m_fa_padre.m_ventanas.m_regla.toolbaritemvisible=false	
end subroutine

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

public subroutine wf_preview_venta_region (integer ai_fila, datawindow adw_dw1);//Inserta los Montos de las Ventas, Por Region de la Venta
string  ls_tipo, ls_cuenta, ls_desc
long 	  ll_ultima, ll_pais
integer li_region

//Recupera el Pais y la Region de Venta.
ll_pais   = adw_dw1.GetItemNumber(ai_fila,"terc_pais")
li_region = adw_dw1.GetItemNumber(ai_fila,"terc_region")

//Recupera las Cuentas Contables por La Region en donde se Hizo la Venta
if ids_region.Retrieve(str.g_financiero, str.empresa, ll_pais, li_region) < 1 then 
	gf_mensaje("","Verifique las Cuentas Contables para la Region del Cliente "+string(adw_dw1.Getitemnumber(ai_fila,"fact_cliente")),1,1,"S")
end if

//Recupera el Tipo de Venta.
ls_tipo = adw_dw1.GetItemstring(ai_fila,"fact_condicion_pago")

//Incrementa la linea
ii_linea ++

//Inserta una linea en el detalle (DGDDIARI)
dw_3.InsertRow(0)

ll_ultima = dw_3.Rowcount()

//Setea la Linea
dw_3.SetItem(ll_ultima,"ddia_no_linea",ii_linea)

//Setea el tipo de Transaccion y subtransaccion
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Si es devolucion
	dw_3.SetItem(ll_ultima,"ddia_tipo_transaccion","NC")
	dw_3.SetItem(ll_ultima,"ddia_sub_tipo_transaccion","2")	
else																	  //Si es Factura
	dw_3.SetItem(ll_ultima,"ddia_tipo_transaccion","FA")			
	//Concepto, por mayor o menor en Subtransaccion
	dw_3.SetItem(ll_ultima,"ddia_sub_tipo_transaccion",adw_dw1.GetitemString(ai_fila,"fact_tipo"))	
end if

//Dependiendo del Tipo de Transaccion y del Tipo de Factura, Recupera la Cuenta
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Si es devolucion, Recupera las Cuentas
  if ids_region.rowcount() > 0 then
	choose case ls_tipo
		case "CO"	
			ls_cuenta = ids_region.GetItemString(1,"rege_cta_vta_contado")			
		case "CR"	
			ls_cuenta = ids_region.GetItemString(1,"rege_cta_vta_credito")				
		case "CD"	
			ls_cuenta = ids_region.GetItemString(1,"rege_cta_vta_cod")				
	end choose		
  end if	
elseif ids_region.rowcount() > 0 then  //Debito Si es Factura
	choose case ls_tipo
		case "CO"	
			ls_cuenta = ids_region.GetItemString(1,"rege_cta_devol_contado")							
		case "CR"	
			ls_cuenta = ids_region.GetItemString(1,"rege_cta_devol_credito")										
		case "CD"	
			ls_cuenta = ids_region.GetItemString(1,"rege_cta_devol_cod")										
	end choose
end if
//Verifica el numero de cuenta, y lo Inserta
if isnull(ls_cuenta) or ls_cuenta = '' then
	gf_mensaje("","Debe Asignar la Cuenta Contable a Todas las Regiones, Para Poder Hacer el Pase",1,1,"S")
	dw_3.SetItem(ll_ultima,"ddia_mg_cuenta","NO ASIGNADA")	
else
	dw_3.SetItem(ll_ultima,"ddia_mg_cuenta",ls_cuenta)	
end if

//Nombre de la Cuenta
ls_desc = wf_recupera_desc_cuenta(ls_cuenta)
if ls_desc <> '' and not isnull(ls_desc) then
	dw_3.SetItem(ll_ultima,"descripcion",ls_desc)
else
	//Dependiendo del Tipo de Venta, setea la descripcion
	choose case ls_tipo
		case "CO"	
			ls_desc = "VTA. CONTADO"							
		case "CR"	
			ls_desc = "VTA. CREDITO"							
		case "CD"	
			ls_desc = "VTA. COD"							
	end choose		
	dw_3.SetItem(ll_ultima,"descripcion",ls_desc)
end if	

//Inserta la Descripcion del Cliente
dw_3.SetItem(ll_ultima,"cliente",adw_dw1.Getitemstring(ai_fila,"terc_descripcion"))	
//Inserta el Monto Total de la Factura
dw_3.SetItem(ll_ultima,"ddia_monto",truncate(round(adw_dw1.Getitemnumber(ai_fila,"fact_monto_fact_total"),2),2))
//Valida si es Factura o devolucion
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Credito Si es devolucion
	dw_3.SetItem(ll_ultima,"ddia_naturaleza","D")
else																	  //Debito Si es Factura
	dw_3.SetItem(ll_ultima,"ddia_naturaleza","C")			
end if
//Fecha de la Transaccion
dw_3.SetItem(ll_ultima,"tdia_fecha_transaccion",adw_dw1.GetitemDatetime(ai_fila,"fact_fecha"))			
//Documento Anexo = Numero del Pedido como referencia
dw_3.SetItem(ll_ultima,"tdia_no_documento",adw_dw1.GetitemString(ai_fila,"fact_no_factura"))
//Logos de la Empresa
dw_3.SetItem(ll_ultima,"fara_logo",is_logo)
dw_3.SetItem(ll_ultima,"fara_logo_f",is_logo_f)
//Setea el Numero de Pedido al Dw de Preview
dw_3.Setitem(ll_ultima,"ddia_no_pedido",adw_dw1.GetitemString(ai_fila,"fact_no_pedido"))
end subroutine

public function string wf_recupera_desc_cuenta (string as_cuenta);//Funcion que recupera la descripcion de la cuenta y la setea al DW de Preview
string ls_cuenta

  SELECT dgmplanc.mg_descripcion  
    INTO :ls_cuenta  
    FROM dgmplanc  
   WHERE ( dgmplanc.mg_g_financiero = :str.g_financiero ) AND  
         ( dgmplanc.mg_empresa = :str.empresa ) AND  
         ( dgmplanc.mg_cuenta = :as_cuenta )   ;

if sqlca.sqlcode = -1 then
	gf_mensaje("","Error al Seleccionar la Descripcion de la Cuenta "+sqlca.sqlerrtext,1,1,"E")
end if

return(ls_cuenta)

end function

public subroutine wf_preview_descuento (integer ai_fila, datawindow adw_dw1);//Inserta la Linea de descuento en ventas, si hubo ??
// si es = a no Aplica, Retorna
if adw_dw1.GetitemString(ai_fila,"fact_descuento_subt_deta") = 'N' then return 
	
string  ls_tipo, ls_cuenta, ls_desc
long 	  ll_ultima
double  ld_monto, ld_monto_final, ld_monto_gasto

//Incrementa la linea
ii_linea ++
//Recupera el Tipo de Venta.
ls_tipo = adw_dw1.GetItemstring(ai_fila,"fact_condicion_pago")
dw_3.InsertRow(0)

ll_ultima = dw_3.Rowcount()

//Setea la Linea
dw_3.SetItem(ll_ultima,"ddia_no_linea",ii_linea)

//Setea el tipo de Transaccion y subtransaccion
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Si es devolucion
	dw_3.SetItem(ll_ultima,"ddia_tipo_transaccion","NC")
	dw_3.SetItem(ll_ultima,"ddia_sub_tipo_transaccion","2")	
else																	  //Si es Factura
	dw_3.SetItem(ll_ultima,"ddia_tipo_transaccion","FA")			
	//Concepto, por mayor o menor en Subtransaccion
	dw_3.SetItem(ll_ultima,"ddia_sub_tipo_transaccion",adw_dw1.GetitemString(ai_fila,"fact_tipo"))
end if

//Dependiendo del tipo, selecciona la cuenta
choose case ls_tipo
	case "CO"	
		ls_cuenta = ids_tipofac.GetItemString(1,"fara_cta_desc_contado")			
	case "CR"	
		ls_cuenta = ids_tipofac.GetItemString(1,"fara_cta_desc_credito")				
	case "CD"	
		ls_cuenta = ids_tipofac.GetItemString(1,"fara_cta_desc_cod")				
end choose		

//Verifica el numero de cuenta, y lo Inserta
if isnull(ls_cuenta) or ls_cuenta = '' then
	gf_mensaje("","Debe Asignar la Cuenta Contable al los Tipos de Ventas, Para Poder Hacer el Pase",1,1,"S")
	dw_3.SetItem(ll_ultima,"ddia_mg_cuenta","NO-ASIGNADA")		
else
	dw_3.SetItem(ll_ultima,"ddia_mg_cuenta",ls_cuenta)	
end if

//Nombre de la Cuenta
ls_desc = wf_recupera_desc_cuenta(ls_cuenta)
if ls_desc <> '' and not isnull(ls_desc) then
	dw_3.SetItem(ll_ultima,"descripcion",ls_desc)
else
	dw_3.SetItem(ll_ultima,"descripcion","DESCUENTO")
end if	
//Inserta la Descripcion del Cliente
dw_3.SetItem(ll_ultima,"cliente",adw_dw1.Getitemstring(ai_fila,"terc_descripcion"))
//Inserta el Monto del Descuento
ld_monto       = truncate(round(adw_dw1.Getitemnumber(ai_fila,"fact_monto_fact_total"),2),2)
ld_monto_final = truncate(round(adw_dw1.Getitemnumber(ai_fila,"fact_monto_final"),2),2)
ld_monto_gasto = truncate(round(adw_dw1.Getitemnumber(ai_fila,"fact_gastos_total"),2),2)

dw_3.SetItem(ll_ultima,"ddia_monto",abs(ld_monto_final - (ld_monto + ld_monto_gasto)))

//Valida si es Factura o devolucion
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Credito Si es devolucion
	dw_3.SetItem(ll_ultima,"ddia_naturaleza","C")
	//setea el monto a la variable de control	
	//	id_credito = id_credito + abs( ld_monto_final - (ld_monto + ld_monto_gasto))					
else																	  //Debito Si es Factura
	dw_3.SetItem(ll_ultima,"ddia_naturaleza","D")			
	//setea el monto a la variable de control	
	//	id_debito = id_debito + abs(ld_monto_final - (ld_monto + ld_monto_gasto))	
end if
//Fecha
dw_3.SetItem(ll_ultima,"tdia_fecha_transaccion",adw_dw1.GetitemDateTime(ai_fila,"fact_fecha"))

//Documento
dw_3.SetItem(ll_ultima,"tdia_no_documento",adw_dw1.GetitemString(ai_fila,"fact_no_factura"))

//Logos de la Empresa
dw_3.SetItem(ll_ultima,"fara_logo",is_logo)
dw_3.SetItem(ll_ultima,"fara_logo_f",is_logo_f)

//Setea el Numero de Pedido al Dw de Preview
dw_3.Setitem(ll_ultima,"ddia_no_pedido",adw_dw1.GetitemString(ai_fila,"fact_no_pedido"))

end subroutine

public subroutine wf_preview_descuento_region (integer ai_fila, datawindow adw_dw1);//Inserta la Linea de descuento en ventas, si hubo ??
// si es = a no Aplica, Retorna
if adw_dw1.GetitemString(ai_fila,"fact_descuento_subt_deta") = 'N' then return 

	
//Inserta los Montos del Descuento, Por Region de la Venta
string  ls_tipo, ls_cuenta, ls_desc
long 	  ll_ultima, ll_pais
integer li_region
double  ld_monto, ld_monto_final, ld_monto_gasto

//Recupera el Pais y la Region de Venta.
ll_pais   = adw_dw1.GetItemNumber(ai_fila,"terc_pais")
li_region = adw_dw1.GetItemNumber(ai_fila,"terc_region")

//Recupera las Cuentas Contables por La Region en donde se Hizo la Venta
if ids_region.Retrieve(str.g_financiero, str.empresa, ll_pais, li_region) < 1 then 
	gf_mensaje("","Verifique las Cuentas Contables para la Region del Cliente "+string(adw_dw1.Getitemnumber(ai_fila,"fact_cliente")),1,1,"S")
end if

//Recupera el Tipo de Venta.
ls_tipo = adw_dw1.GetItemstring(ai_fila,"fact_condicion_pago")

//Incrementa la linea
ii_linea ++

//Inserta una linea en el detalle (DGDDIARI)
dw_3.InsertRow(0)

ll_ultima = dw_3.Rowcount()

//Setea la Linea
dw_3.SetItem(ll_ultima,"ddia_no_linea",ii_linea)

//Setea el tipo de Transaccion y subtransaccion
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Si es devolucion
	dw_3.SetItem(ll_ultima,"ddia_tipo_transaccion","NC")
	dw_3.SetItem(ll_ultima,"ddia_sub_tipo_transaccion","2")	
else																	  //Si es Factura
	dw_3.SetItem(ll_ultima,"ddia_tipo_transaccion","FA")			
	//Concepto, por mayor o menor en Subtransaccion
	dw_3.SetItem(ll_ultima,"ddia_sub_tipo_transaccion",adw_dw1.GetitemString(ai_fila,"fact_tipo"))	
end if
//Dependiendo del Tipo de Factura, Recupera la Cuenta
	choose case ls_tipo
		case "CO"	
			ls_cuenta = ids_region.GetItemString(1,"rege_cta_desc_contado")			
		case "CR"	
			ls_cuenta = ids_region.GetItemString(1,"rege_cta_desc_credito")				
		case "CD"	
			ls_cuenta = ids_region.GetItemString(1,"rege_cta_desc_cod")				
	end choose		
//Verifica el numero de cuenta, y lo Inserta
if isnull(ls_cuenta) or ls_cuenta = '' then
	gf_mensaje("","Debe Asignar la Cuenta Contable a Todas las Regiones, Para Poder Hacer el Pase",1,1,"S")
	dw_3.SetItem(ll_ultima,"ddia_mg_cuenta","NO ASIGNADA")
else
	dw_3.SetItem(ll_ultima,"ddia_mg_cuenta",ls_cuenta)	
end if

//Nombre de la Cuenta
ls_desc = wf_recupera_desc_cuenta(ls_cuenta)
if ls_desc <> '' and not isnull(ls_desc) then
	dw_3.SetItem(ll_ultima,"descripcion",ls_desc)
else
	dw_3.SetItem(ll_ultima,"descripcion","DESCUENTO")
end if	

//Inserta la Descripcion del Cliente
dw_3.SetItem(ll_ultima,"cliente",adw_dw1.Getitemstring(ai_fila,"terc_descripcion"))	

//Inserta el Monto del Descuento
ld_monto_final = truncate(round(adw_dw1.Getitemnumber(ai_fila,"fact_monto_final"),2),2)
ld_monto       = truncate(round(adw_dw1.Getitemnumber(ai_fila,"fact_monto_fact_total"),2),2)
ld_monto_gasto = truncate(round(adw_dw1.Getitemnumber(ai_fila,"fact_gastos_total"),2),2)

dw_3.SetItem(ll_ultima,"ddia_monto",abs(ld_monto_final - (ld_monto + ld_monto_gasto)))
//Valida si es Factura o devolucion
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Credito Si es devolucion
	dw_3.SetItem(ll_ultima,"ddia_naturaleza","C")
	//setea el monto a la variable de control	
	//id_credito = id_credito + abs( ld_monto_final - (ld_monto + ld_monto_gasto))				
else																	  //Debito Si es Factura
	dw_3.SetItem(ll_ultima,"ddia_naturaleza","D")			
	//setea el monto a la variable de control	
	//id_debito = id_debito + abs(ld_monto_final - (ld_monto + ld_monto_gasto))
end if
//Fecha de la Transaccion
dw_3.SetItem(ll_ultima,"tdia_fecha_transaccion",adw_dw1.GetitemDatetime(ai_fila,"fact_fecha"))			
//Documento Anexo = Numero del Pedido como referencia
dw_3.SetItem(ll_ultima,"tdia_no_documento",adw_dw1.GetitemString(ai_fila,"fact_no_factura"))
//Logos de la Empresa
dw_3.SetItem(ll_ultima,"fara_logo",is_logo)
dw_3.SetItem(ll_ultima,"fara_logo_f",is_logo_f)
//Setea el Numero de Pedido al Dw de Preview
dw_3.Setitem(ll_ultima,"ddia_no_pedido",adw_dw1.GetitemString(ai_fila,"fact_no_pedido"))
end subroutine

public function integer wf_inserta_descuento_region (integer ai_fila, datawindow adw_dw1);//Inserta la Linea de descuento en ventas, si hubo ??
// si es = a no Aplica, Retorna
if adw_dw1.GetitemString(ai_fila,"fact_descuento_subt_deta") = 'N' then return 1

//Inserta los Montos de las Ventas, Por Region de la Venta
string  ls_tipo, ls_cuenta, ls_desc
long 	  ll_ultima, ll_pais
integer li_region
double  ld_monto, ld_monto_final, ld_monto_gasto

//Incrementa la linea del Detalle de Transacciones
ii_linea ++

//Recupera el Pais y la Region de Venta.
ll_pais   = adw_dw1.GetItemNumber(ai_fila,"terc_pais")
li_region = adw_dw1.GetItemNumber(ai_fila,"terc_region")

//Recupera las Cuentas Contables por La Region en donde se Hizo la Venta
if ids_region.Retrieve(str.g_financiero, str.empresa, ll_pais, li_region) < 1 then 
	gf_mensaje("","Verifique las Cuentas Contables para la Region del Cliente "+string(adw_dw1.Getitemnumber(ai_fila,"fact_cliente")),1,1,"S")
	return 0
end if

//Recupera el Tipo de Venta.
ls_tipo = adw_dw1.GetItemstring(ai_fila,"fact_condicion_pago")

//Inserta una linea en el detalle (DGDDIARI)
ids_ddiari.InsertRow(0)

ll_ultima = ids_ddiari.Rowcount()

//Setea el Grupo Financiero y Empresa a DGDDIARI
gf_setea_grupo_empresa_ds(ids_ddiari,"ddia",ll_ultima)
//Aplicacion de Facturacion
ids_ddiari.SetItem(ll_ultima,"ddia_aplicacion","FA")
//Setea el tipo de Transaccion y subtransaccion
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Si es devolucion
	ids_ddiari.SetItem(ll_ultima,"ddia_tipo_transaccion","NC")
	ids_ddiari.SetItem(ll_ultima,"ddia_sub_tipo_transaccion","2")	
else																	  //Si es Factura
	ids_ddiari.SetItem(ll_ultima,"ddia_tipo_transaccion","FA")			
	//Concepto, por mayor o menor en Subtransaccion
	ids_ddiari.SetItem(ll_ultima,"ddia_sub_tipo_transaccion",adw_dw1.GetitemString(ai_fila,"fact_tipo"))	
end if		
//Setea el numero de documento
ids_ddiari.Setitem(ll_ultima,"ddia_no_documento",adw_dw1.GetitemString(ai_fila,"fact_no_factura"))
//Setea la Linea
ids_ddiari.SetItem(ll_ultima,"ddia_no_linea",ii_linea)
//Dependiendo del Tipo de Factura, Recupera la Cuenta
	choose case ls_tipo
		case "CO"	
			ls_cuenta = ids_region.GetItemString(1,"rege_cta_desc_contado")			
		case "CR"	
			ls_cuenta = ids_region.GetItemString(1,"rege_cta_desc_credito")				
		case "CD"	
			ls_cuenta = ids_region.GetItemString(1,"rege_cta_desc_cod")				
	end choose		
//Verifica el numero de cuenta, y lo Inserta
if isnull(ls_cuenta) or ls_cuenta = '' then
	gf_mensaje("","Debe Asignar la Cuenta Contable a Todas las Regiones, Para Poder Hacer el Pase",1,1,"S")
	ids_ddiari.Deleterow(ll_ultima)
	return 0
else
	ids_ddiari.SetItem(ll_ultima,"ddia_mg_cuenta",ls_cuenta)	
end if

//Inserta el Monto del Descuento
ld_monto				= truncate(round(adw_dw1.Getitemnumber(ai_fila,"fact_monto_fact_total"),2),2)
ld_monto_final		= truncate(round(adw_dw1.Getitemnumber(ai_fila,"fact_monto_final"),2),2)
ld_monto_gasto		= truncate(round(adw_dw1.Getitemnumber(ai_fila,"fact_gastos_total"),2),2)

ids_ddiari.SetItem(ll_ultima,"ddia_monto",abs(ld_monto_final - (ld_monto + ld_monto_gasto)))
//Valida si es Factura o devolucion
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Credito Si es devolucion
	ids_ddiari.SetItem(ll_ultima,"ddia_naturaleza","C")
	//setea el monto a la variable de control	
	id_credito = id_credito + abs(ld_monto_final - (ld_monto + ld_monto_gasto))				
else																	  //Debito Si es Factura
	ids_ddiari.SetItem(ll_ultima,"ddia_naturaleza","D")			
	//setea el monto a la variable de control		
	id_debito = id_debito + abs(ld_monto_final - (ld_monto + ld_monto_gasto))		
end if
//Codigo del Tercero
ids_ddiari.SetItem(ll_ultima,"ddia_tercero",adw_dw1.GetitemNumber(ai_fila,"fact_cliente"))
//Documento Anexo = Numero del Pedido como referencia
ids_ddiari.SetItem(ll_ultima,"ddia_documento_anexo",adw_dw1.GetitemString(ai_fila,"fact_no_pedido"))
//Año del documento
ids_ddiari.SetItem(ll_ultima,"ddia_ann",adw_dw1.GetitemNumber(ai_fila,"fact_ann"))

return 1
end function

public subroutine wf_elimina_registro ();//Función que elimina el encabezado, en caso de que no encuentre alguna cuenta del detalle
integer i, il_total
string ls_documento, ls_tipo, ls_sub_tipo

ls_documento = ids_tdiari.Getitemstring(ids_tdiari.Rowcount(),"tdia_no_documento")


ids_tdiari.deleterow(ids_tdiari.Rowcount())  //Elimina Encabezado

  
 il_total = ids_ddiari.Rowcount()	    
 for i = 1 to il_total 
    if ids_ddiari.GetitemString(i,"ddia_no_documento") = ls_documento then		
		 ids_ddiari.Deleterow(i)
		 il_total --		//Decrementa
		 i --
	 end if	
 Next
end subroutine

public function string wf_descripcion (integer ai_fila, datawindow adw_dw1);//Concatena la Descripcion de la Factura o Devolucion 
string  ls_factura, ls_desc, ls_tipo, ls_pais
long    ll_ann, ll_cliente

ls_factura  = adw_dw1.GetitemString(ai_fila,"fact_no_factura")
ls_tipo 		= adw_dw1.GetitemString(ai_fila,"fact_tipo")
ll_ann      = adw_dw1.GetitemNumber(ai_fila,"fact_ann")
ll_cliente  = adw_dw1.GetitemNumber(ai_fila,"fact_cliente")
ls_desc     = adw_dw1.GetitemString(ai_fila,"fact_a_nombre")

  SELECT isnull(dgapais.pais_descripcion  ,'')
    INTO :ls_pais  
    FROM dgapais,   
         dgmterce  
   WHERE ( dgmterce.terc_pais = dgapais.pais_pais ) and  
         ( ( dgmterce.terc_tercero = :ll_cliente ) )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al Buscar Pais '+sqlca.sqlerrtext,1,1,'E')
	end if

if adw_dw1.Getitemnumber(ai_fila,"devolucion") =  1 then
   return ("Devolucion "+ls_pais+" -> NC/2 # "+ls_factura+" de "+string(ll_ann)+" a "+ls_desc+"  "+string(ll_cliente))	//2=Sub-transaccion de NC=2
else
	return ("Factura "+ls_pais+" -> FA/"+ls_tipo+" # "+ls_factura+" de "+string(ll_ann)+" a "+ls_desc+"  "+string(ll_cliente))
end if


end function

public subroutine wf_preview_inserta_cliente (long ai_fila, datawindow adw_dw1);//Inserta el Detalle del Monto que se le cargará al Cliente
long 	  ll_ultima
string  ls_cuenta, ls_desc
dw_3.InsertRow(0)

ll_ultima = dw_3.Rowcount()

//Setea la Linea
dw_3.SetItem(ll_ultima,"ddia_no_linea",ii_linea)
//Setea el tipo de Transaccion y subtransaccion
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Si es devolucion
	dw_3.SetItem(ll_ultima,"ddia_tipo_transaccion","NC")
	dw_3.SetItem(ll_ultima,"ddia_sub_tipo_transaccion","2")	
else																	  //Si es Factura
	dw_3.SetItem(ll_ultima,"ddia_tipo_transaccion","FA")			
	//Concepto, por mayor o menor en Subtransaccion
	dw_3.SetItem(ll_ultima,"ddia_sub_tipo_transaccion",adw_dw1.GetitemString(ai_fila,"fact_tipo"))
end if

//Verifica el numero de cuenta, y lo Inserta
ls_cuenta = adw_dw1.GetItemString(ai_fila,"clie_mg_cuenta")
if isnull(ls_cuenta) or ls_cuenta = '' then
	gf_mensaje("","Debe Asignar la Cuenta Contable al Cliente, Para Poder Hacer el Pase",1,1,"S")
	dw_3.SetItem(ll_ultima,"ddia_mg_cuenta","NO ASIGNADA")
else
	dw_3.SetItem(ll_ultima,"ddia_mg_cuenta",ls_cuenta)	
end if
//Inserta el Monto Total de la Factura
dw_3.SetItem(ll_ultima,"ddia_monto",truncate(round(adw_dw1.Getitemnumber(ai_fila,"fact_monto_final"),2),2))
//Valida si es Factura o devolucion
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Credito Si es devolucion
	dw_3.SetItem(ll_ultima,"ddia_naturaleza","C")
else																	  //Debito Si es Factura
	dw_3.SetItem(ll_ultima,"ddia_naturaleza","D")			
end if	
//Nombre de la Cuenta Cliente
ls_desc = adw_dw1.GetitemString(ai_fila,"fact_a_nombre" /*"mg_descripcion"*/)
if ls_desc = '' or isnull(ls_desc) then
	dw_3.SetItem(ll_ultima,"descripcion",adw_dw1.Getitemstring(ai_fila,"fact_a_nombre"))	
else
	dw_3.SetItem(ll_ultima,"descripcion",ls_desc)
end if
//Inserta la Descripcion del Cliente
dw_3.SetItem(ll_ultima,"cliente",adw_dw1.Getitemstring(ai_fila,"fact_a_nombre"))	
//Documento 
dw_3.SetItem(ll_ultima,"tdia_no_documento",adw_dw1.GetitemString(ai_fila,"fact_no_factura"))
//Fecha de la Transaccion
dw_3.SetItem(ll_ultima,"tdia_fecha_transaccion",adw_dw1.GetitemDatetime(ai_fila,"fact_fecha"))
//Logos de la Empresa
dw_3.SetItem(ll_ultima,"fara_logo",is_logo)
dw_3.SetItem(ll_ultima,"fara_logo_f",is_logo_f)
//Setea el Numero de Pedido al Dw de Preview
dw_3.Setitem(ll_ultima,"ddia_no_pedido",adw_dw1.GetitemString(ai_fila,"fact_no_pedido"))
end subroutine

public subroutine wf_crear_data_store (string as_tipo);//Se definen los DataStores
long ll_recupero

//Encabezado de las Transaccciones a Pasar
ids_tdiari = create ds_fa_man_pase_conta //User Object, tipo DataStore
ids_tdiari.DataObject = "dw_pr_fa_pase_contabilidad_enc"
ids_tdiari.SetTransObject(Sqlca)

//Detalle de las Transaccciones a Pasar
ids_ddiari = create ds_fa_man_pase_conta //User Object, tipo DataStore
ids_ddiari.DataObject = "dw_pr_fa_pase_detallado_a_conta"
ids_ddiari.SetTransObject(Sqlca)

//Cargos de las Facturas a Pasar a conta
ids_cargos = create ds_fa_man_pase_conta //User Object, tipo DataStore
ids_cargos.DataObject = "dw_pr_fa_cargos_pase_conta"
ids_cargos.SetTransObject(Sqlca)

if as_tipo = "TIPO" then //Si el Pase de las Ventas se Hará por el Tipo de Factura (CO, CR, COD)
	ids_tipofac = create ds_fa_man_pase_conta //User Object, tipo DataStore
	ids_tipofac.DataObject = "dw_pr_fa_ventas_tipo_pase_conta"
	ids_tipofac.SetTransObject(Sqlca)		
	
	SELECT count(*)  
    INTO :ll_recupero  
    FROM faaparam  
   WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
         ( faaparam.fara_empresa = :str.empresa )   ;	
			
	if ll_recupero = 0 then
		gf_mensaje("","Consulte con Soporte Técnico, Verificar las Cuentas Contables por Tipo de Factura en Datos Generales",1,1,"E")
	else
		ids_tipofac.Retrieve(str.g_financiero, str.empresa)
	end if

	//Datastore para los tipos de facturas
	ids_tipos = create ds_fa_man_pase_conta //User Object, tipo DataStore
	ids_tipos.DataObject = "dw_pr_fa_ventas_tipo_pase"
	ids_tipos.SetTransObject(Sqlca)		
	
	if ids_tipos.Retrieve(str.g_financiero, str.empresa) = 0 then
		ids_tipos.insertrow(0)		
		gf_mensaje("","Consulte con Soporte Técnico, Verificar las Cuentas Contables por Tipo de Factura en Datos Generales",1,1,"E")
	end if
	
else 							 //Si el Pase de las Ventas se Hará por la Region de la Venta
	ids_region = create ds_fa_man_pase_conta //User Object, tipo DataStore
	ids_region.DataObject = "dw_pr_fa_ventas_region_pase_conta"
	ids_region.SetTransObject(Sqlca)
	
	 SELECT count(*)  
	   INTO :ll_recupero  
	   FROM dgregiog  
	  WHERE ( dgregiog.rege_g_financiero = :str.g_financiero ) AND  
           ( dgregiog.rege_empresa = :str.empresa );
	
	if sqlca.sqlcode = -1 then
		gf_mensaje("","Error al Verificar Existencia de Regiones por GF "+sqlca.sqlerrtext,1,1,"E")
	end if
	
	if ll_recupero = 0 then
		gf_mensaje("","Consulte con Soporte Técnico, Verificar las Cuentas Contables por Region",1,1,"E")
	else
		ids_region.Retrieve(str.g_financiero, str.empresa)
	end if	
	
end if
end subroutine

public subroutine wf_preview_cargos (integer ai_fila, datawindow adw_dw1);//Inserta los Cargos de la Factura o Devolucion

//Inserta los Montos de los Cargos
string  ls_cuenta, ls_pedido, ls_desc, ls_tipo
long 	  ll_ultima, ll_ann
integer i
decimal  ld_monto 

//Recupera los Argumentos Necesarios para Recuperar los Cargos
ls_pedido   = adw_dw1.GetitemString(ai_fila,"fact_no_pedido")
ls_tipo     = adw_dw1.GetItemString(ai_fila,"fact_tipo")
ll_ann		= adw_dw1.GetitemNumber(ai_fila,"fact_ann")

//Recupera los Cargos
if ids_cargos.retrieve(str.g_financiero, str.empresa, ls_pedido, ls_tipo, ll_ann) = 0 then Return


//Recorre los Cargos y los Inserta en el Detalle (dgddiari)
for i = 1 to ids_cargos.Rowcount()				
		//Incrementa la linea
		ii_linea ++
		
		dw_3.InsertRow(0)				//Inserta en el detalle
		ll_ultima = dw_3.Rowcount()
		
		//Setea la Linea		
		dw_3.SetItem(ll_ultima,"ddia_no_linea",ii_linea)
		
		//Setea el tipo de Transaccion y subtransaccion
		if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Si es devolucion
			dw_3.SetItem(ll_ultima,"ddia_tipo_transaccion","NC")
			dw_3.SetItem(ll_ultima,"ddia_sub_tipo_transaccion","2")	
		else																	  //Si es Factura
			dw_3.SetItem(ll_ultima,"ddia_tipo_transaccion","FA")			
			//Concepto, por mayor o menor en Subtransaccion
			dw_3.SetItem(ll_ultima,"ddia_sub_tipo_transaccion",adw_dw1.GetitemString(ai_fila,"fact_tipo"))
		end if
		
		//Recupera la Cuenta
		ls_cuenta = ids_cargos.GetitemString(i,"carg_cuenta")
		//Verifica el numero de cuenta, y lo Inserta
		if isnull(ls_cuenta) or ls_cuenta = '' then			
			gf_mensaje("","Debe Asignar la Cuenta Contable al los Cargos, Para Poder Hacer el Pase",1,1,"S")
			dw_3.SetItem(ll_ultima,"ddia_mg_cuenta","NO ASIGNADA")	
		else
			dw_3.SetItem(ll_ultima,"ddia_mg_cuenta",ls_cuenta)
		end if
		//Inserta el Monto Total de la Factura		
		ld_monto = round(ids_cargos.Getitemdecimal(i,"dcar_monto"),2)

		//double ld_monto2
		//ld_monto2 = ids_cargos.Getitemnumber(i,"dcar_monto")
		//messagebox("Monto truncado y sin .. ",string(ld_monto)+"  "+string(ld_monto2))
		
		dw_3.SetItem(ll_ultima,"ddia_monto", ld_monto)
		//Valida si es Factura o devolucion
		if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Credito Si es devolucion
			dw_3.SetItem(ll_ultima,"ddia_naturaleza","D")
		else																	  //Debito Si es Factura
			dw_3.SetItem(ll_ultima,"ddia_naturaleza","C")			
		end if
		//Fecha de la Transaccion
		dw_3.SetItem(ll_ultima,"tdia_fecha_transaccion",adw_dw1.Getitemdatetime(ai_fila,"fact_fecha"))
		//Nombre de la Cuenta
		ls_desc = wf_recupera_desc_cuenta(ls_cuenta)
		if ls_desc <> '' and not isnull(ls_desc) then
			dw_3.SetItem(ll_ultima,"descripcion",ls_desc)
		else
			dw_3.SetItem(ll_ultima,"descripcion",ids_cargos.Getitemstring(i,"carg_descripcion"))
		end if	
		//Documento (Numero de la Factura)
		dw_3.SetItem(ll_ultima,"tdia_no_documento",adw_dw1.GetitemString(ai_fila,"fact_no_factura"))
		//Logos de la Empresa
		dw_3.SetItem(ll_ultima,"fara_logo",is_logo)

		dw_3.SetItem(ll_ultima,"fara_logo_f",is_logo_f)		
		//Setea el Numero de Pedido al Dw de Preview
		dw_3.Setitem(ll_ultima,"ddia_no_pedido",adw_dw1.GetitemString(ai_fila,"fact_no_pedido"))		
Next
end subroutine

public subroutine wf_setear_sql ();//Función que Setea el SQl 

String 	ls_where, ls_original, ls_signo, ls_inicio = '', ls_final= ''

dw_1.SetSQLSelect(is_nativo)		//Setea el SQL Original (Sin filtros) al Data Window

ls_original	= dw_1.getsqlselect()

//messagebox("Original",ls_original)

If cbx_fechas.Checked Then
	
	if em_fecha_inicial.text <> "" and em_fecha_final.text <> "" then	
		ls_inicio = gf_cambia_fecha(em_fecha_inicial.text,0)
	   ls_final  = gf_cambia_fecha(em_fecha_final.text,1)
	end if
	
   ls_where = ls_original + " and  &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+ " ) and &
					 ( fatdiari.fact_fecha >= '"+ ls_inicio +"' ) and &
		 			 ( fatdiari.fact_fecha < '"+ls_final+"')"					 	

ElseIf cbx_fac.checked then
	
   ls_where = ls_original + " and  &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+ " ) and &
					 ( convert(numeric(8,0),fatdiari.fact_no_factura) >= "+em_1.text+" ) and &
					 ( convert(numeric(8,0),fatdiari.fact_no_factura) <= "+em_2.text+")"	
Else
   ls_where = ls_original + " and  &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+ " )" 
End If

// messagebox("Where final",ls_where)

dw_1.SetSQLSelect(ls_where)		//Setea el SQL al Data Window

If sqlca.sqlcode = -1 Then
	
	messagebox("ATENCIÓN SR. USUARIO","Error "+sqlca.sqlerrtext)
	
End If	

dw_1.retrieve()

end subroutine

public function integer wf_inserta_cargos (integer ai_fila, datawindow adw_dw1);//Inserta los Cargos de la Factura o Devolucion

//Inserta los Montos de los Cargos
string  ls_cuenta, ls_pedido, ls_tipo
long 	  ll_ultima, ll_ann
integer i
decimal  ld_monto

//Recupera los Argumentos Necesarios para Recuperar los Cargos
ls_pedido   = adw_dw1.GetitemString(ai_fila,"fact_no_pedido")
ls_tipo 		= adw_dw1.GetItemString(ai_fila,"fact_tipo")
ll_ann		= adw_dw1.GetitemNumber(ai_fila,"fact_ann")

//Recupera los Cargos
if ids_cargos.retrieve(str.g_financiero, str.empresa, ls_pedido, ls_tipo, ll_ann) = 0 then Return 1


//Recorre los Cargos y los Inserta en el Detalle (dgddiari)
for i = 1 to ids_cargos.Rowcount()				
		ids_ddiari.InsertRow(0)				//Inserta en el detalle
		ll_ultima = ids_ddiari.Rowcount()
		//Incrementa la linea del Detalle de Transacciones
		ii_linea ++		
						
		//Setea el Grupo Financiero y Empresa a DGDDIARI
		gf_setea_grupo_empresa_ds(ids_ddiari,"ddia",ll_ultima)
		//Aplicacion de Facturacion
		ids_ddiari.SetItem(ll_ultima,"ddia_aplicacion","FA")
		//Setea el tipo de Transaccion y subtransaccion
		if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Si es devolucion
			ids_ddiari.SetItem(ll_ultima,"ddia_tipo_transaccion","NC")
			ids_ddiari.SetItem(ll_ultima,"ddia_sub_tipo_transaccion","2")	
		else																	  //Si es Factura
			ids_ddiari.SetItem(ll_ultima,"ddia_tipo_transaccion","FA")			
			//Concepto, o Subtransaccion
			ids_ddiari.SetItem(ll_ultima,"ddia_sub_tipo_transaccion",adw_dw1.GetitemString(ai_fila,"fact_tipo"))	
		end if		
		//Setea el numero de documento
		ids_ddiari.Setitem(ll_ultima,"ddia_no_documento",adw_dw1.GetitemString(ai_fila,"fact_no_factura"))
		//Setea la Linea
		ids_ddiari.SetItem(ll_ultima,"ddia_no_linea",ii_linea)
		//Recupera la Cuenta
		ls_cuenta = ids_cargos.GetitemString(i,"carg_cuenta")
		//Verifica el numero de cuenta, y lo Inserta
		if isnull(ls_cuenta) or ls_cuenta = '' then			
			gf_mensaje("","Debe Asignar la Cuenta Contable al los Cargos, Para Poder Hacer el Pase",1,1,"S")
			ids_ddiari.Deleterow(ll_ultima)
			return 0
		else
			ids_ddiari.SetItem(ll_ultima,"ddia_mg_cuenta",ls_cuenta)	
		end if
		//Inserta el Monto Total de la Factura
//		ld_monto = truncate(round(ids_cargos.Getitemnumber(i,"dcar_monto"),2),2)
		ld_monto = round(ids_cargos.Getitemdecimal(i,"dcar_monto"),2)
		ids_ddiari.SetItem(ll_ultima,"ddia_monto",ld_monto)
		//Valida si es Factura o devolucion
		if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Credito Si es devolucion
			ids_ddiari.SetItem(ll_ultima,"ddia_naturaleza","D")
			//setea el monto a la variable de control	
			id_debito = id_debito + ld_monto					
		else																	  //Debito Si es Factura
			ids_ddiari.SetItem(ll_ultima,"ddia_naturaleza","C")			
			//setea el monto a la variable de control	
			id_credito = id_credito + ld_monto					
		end if
		//Codigo del Tercero
		ids_ddiari.SetItem(ll_ultima,"ddia_tercero",adw_dw1.GetitemNumber(ai_fila,"fact_cliente"))
		//Documento Anexo = Numero del Pedido como referencia
		ids_ddiari.SetItem(ll_ultima,"ddia_documento_anexo",adw_dw1.GetitemString(ai_fila,"fact_no_pedido"))
		//Año del Documento
		ids_ddiari.SetItem(ll_ultima,"ddia_ann",ll_ann)		
Next

return 1
end function

public subroutine wf_asigna_logos ();//Asigna los Logos de la Empresa a las Variables de Instancia

  SELECT faaparam.fara_logo ,  faaparam.fara_logo_f
    INTO :is_logo,
	 		:is_logo_f
    FROM faaparam  
   WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
         ( faaparam.fara_empresa = :str.empresa )   ;

if sqlca.sqlcode = -1 then
	gf_mensaje("","Error al Seleccionar los Logos, "+sqlca.sqlerrtext,1,1,"E")
end if
end subroutine

public subroutine wf_crear_preview (long ai_fila, datawindow adw_dw1);//inserta en el Detalle de las Transacciones a Contabilidad (dgddiari)

//Inserta los Montos totales al Cliente en lado "CREDITO" o "DEBITO" si es Devolucion
wf_preview_inserta_cliente(ai_fila, adw_dw1)

//Inserta su contraparte en Ventas, Dependiendo de Que tipo de Ventas se Afectan,
//Por tipo de Factura o por Region
if ii_venta_por = 1 then //Cuando es por tipo de Factura
	wf_preview_venta_tipo(ai_fila, adw_dw1)
	//Inserta El descuento en venta, si lo hubo
	wf_preview_descuento(ai_fila, adw_dw1)	
else 							 //Por Region de la Venta
	wf_preview_venta_region(ai_fila, adw_dw1)
	//Inserta El descuento en venta, si lo hubo
	wf_preview_descuento_region(ai_fila, adw_dw1)	
end if

//Inserta los Cargos Correspondiente a la Factura o Devolucion
wf_preview_cargos(ai_fila, adw_dw1)


end subroutine

public subroutine wf_preview_venta_tipo (integer ai_fila, datawindow adw_dw1);//Inserta los Montos de las Ventas, Por tipo de Factura (CR, CO, C.O.D, Otros)
string  ls_tipo, ls_tipopago, ls_cuenta, ls_desc, ls_expresion
long 	  ll_ultima
Integer li_encontro

//Incrementa la linea
ii_linea ++
//Recupera el Tipo de Factura.
ls_tipo = adw_dw1.Getitemstring(ai_fila,"fact_tipo")
//Recupera el tipo de pago de la factura
ls_tipopago = adw_dw1.GetItemstring(ai_fila,"fact_condicion_pago")

dw_3.InsertRow(0)

ll_ultima = dw_3.Rowcount()

//Setea la Linea
dw_3.SetItem(ll_ultima,"ddia_no_linea",ii_linea)

//Setea el tipo de Transaccion y subtransaccion
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Si es devolucion
	dw_3.SetItem(ll_ultima,"ddia_tipo_transaccion","NC")
	dw_3.SetItem(ll_ultima,"ddia_sub_tipo_transaccion","2")	
else																	  //Si es Factura
	dw_3.SetItem(ll_ultima,"ddia_tipo_transaccion","FA")			
	//Concepto, por mayor o menor en Subtransaccion
	dw_3.SetItem(ll_ultima,"ddia_sub_tipo_transaccion",adw_dw1.GetitemString(ai_fila,"fact_tipo"))	
end if
//Dependiendo del Tipo de Transaccion y del Tipo de Factura, Recupera la Cuenta
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Si es devolucion, Recupera las Cuentas
	choose case ls_tipopago
		case "CO"	
			ls_cuenta = ids_tipofac.GetItemString(1,"fara_cta_vta_contado")			
		case "CR"	
			ls_cuenta = ids_tipofac.GetItemString(1,"fara_cta_vta_credito")				
		case "CD"	
			ls_cuenta = ids_tipofac.GetItemString(1,"fara_cta_vta_cod")				
	end choose																								
else																	  //Debito Si es Factura
//	choose case ls_tipo
//		case "CO"	
//			ls_cuenta = ids_tipofac.GetItemString(1,"fara_cta_devol_contado")							
//		case "CR"	
//			ls_cuenta = ids_tipofac.GetItemString(1,"fara_cta_devol_credito")										
//		case "CD"	
//			ls_cuenta = ids_tipofac.GetItemString(1,"fara_cta_devol_cod")										
//	end choose

// Busca el tipo de Factura en el child de subtransacciones por aplicacion
	ls_expresion = "serd_sub_trans = '"+ls_tipo+"'"
	li_encontro  = ids_tipos.Find(ls_expresion,1,ids_tipos.Rowcount())
	if li_encontro > 0 then
		ls_cuenta = ids_tipos.getitemstring(li_encontro,"mg_cuenta")
	end if
end if
//Verifica el numero de cuenta, y lo Inserta
if isnull(ls_cuenta) or trim(ls_cuenta) = '' then
	gf_mensaje("","Debe Asignar la Cuenta Contable al los Tipos de Ventas, Para Poder Hacer el Pase",1,1,"S")
	dw_3.SetItem(ll_ultima,"ddia_mg_cuenta","NO ASIGNADA")		
else
	dw_3.SetItem(ll_ultima,"ddia_mg_cuenta",ls_cuenta)	
end if

//Nombre de la Cuenta
ls_desc = wf_recupera_desc_cuenta(ls_cuenta)
if ls_desc <> '' and not isnull(ls_desc) then
	dw_3.SetItem(ll_ultima,"descripcion",ls_desc)
else
	//Dependiendo del Tipo de Venta, setea la descripcion
	choose case ls_tipopago
		case "CO"
			ls_desc = "VTA. CONTADO"							
		case "CR"	
			ls_desc = "VTA. CREDITO"							
		case "CD"	
			ls_desc = "VTA. COD"							
	end choose		
	dw_3.SetItem(ll_ultima,"descripcion",ls_desc)
end if	

//Inserta la Descripcion del Cliente
dw_3.SetItem(ll_ultima,"cliente",adw_dw1.Getitemstring(ai_fila,"terc_descripcion"))	
//Inserta el Monto Total de la Factura
//if adw_dw1.GetitemString(ai_fila,"fact_descuento_subt_deta") = 'N' then
dw_3.SetItem(ll_ultima,"ddia_monto",adw_dw1.Getitemnumber(ai_fila,"fact_monto_fact_total"))		
//else
//	dw_3.SetItem(ll_ultima,"ddia_monto",adw_dw1.Getitemnumber(ai_fila,"fact_monto_final"))
//end if

dw_3.SetItem(ll_ultima,"ddia_monto",truncate(round(adw_dw1.Getitemnumber(ai_fila,"fact_monto_fact_total"),2),2))
//Valida si es Factura o devolucion
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Credito Si es devolucion
	dw_3.SetItem(ll_ultima,"ddia_naturaleza","D")
else																	  //Debito Si es Factura
	dw_3.SetItem(ll_ultima,"ddia_naturaleza","C")			
end if
//Fecha
dw_3.SetItem(ll_ultima,"tdia_fecha_transaccion",adw_dw1.GetitemDateTime(ai_fila,"fact_fecha"))

//Documento
dw_3.SetItem(ll_ultima,"tdia_no_documento",adw_dw1.GetitemString(ai_fila,"fact_no_factura"))

//Logos de la Empresa
dw_3.SetItem(ll_ultima,"fara_logo",is_logo)
dw_3.SetItem(ll_ultima,"fara_logo_f",is_logo_f)

//Setea el Numero de Pedido al Dw de Preview
dw_3.Setitem(ll_ultima,"ddia_no_pedido",adw_dw1.GetitemString(ai_fila,"fact_no_pedido"))
end subroutine

public function integer wf_inserta_descuento (integer ai_fila, datawindow adw_dw1);//Inserta la Linea de descuento en ventas, si hubo ??
// si es = a no Aplica, Retorna
if adw_dw1.GetitemString(ai_fila,"fact_descuento_subt_deta") = 'N' then return 1

//Inserta los Montos de las Ventas, Por Region de la Venta
string  ls_tipo, ls_cuenta, ls_desc
long 	  ll_ultima
double  ld_monto, ld_monto_final, ld_monto_gasto

//Incrementa la linea del Detalle de Transacciones
ii_linea ++

//Recupera el Tipo de Venta.
ls_tipo = adw_dw1.GetItemstring(ai_fila,"fact_condicion_pago")

//Inserta una linea en el detalle (DGDDIARI)
ids_ddiari.InsertRow(0)

ll_ultima = ids_ddiari.Rowcount()

//Setea el Grupo Financiero y Empresa a DGDDIARI
gf_setea_grupo_empresa_ds(ids_ddiari,"ddia",ll_ultima)
//Aplicacion de Facturacion
ids_ddiari.SetItem(ll_ultima,"ddia_aplicacion","FA")
//Setea el tipo de Transaccion y subtransaccion
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Si es devolucion
	ids_ddiari.SetItem(ll_ultima,"ddia_tipo_transaccion","NC")
	ids_ddiari.SetItem(ll_ultima,"ddia_sub_tipo_transaccion","2")	
else																	  //Si es Factura
	ids_ddiari.SetItem(ll_ultima,"ddia_tipo_transaccion","FA")			
	//Concepto, por mayor o menor en Subtransaccion
	ids_ddiari.SetItem(ll_ultima,"ddia_sub_tipo_transaccion",adw_dw1.GetitemString(ai_fila,"fact_tipo"))
end if		

//Setea el numero de documento
ids_ddiari.Setitem(ll_ultima,"ddia_no_documento",adw_dw1.GetitemString(ai_fila,"fact_no_factura"))
//Setea la Linea
ids_ddiari.SetItem(ll_ultima,"ddia_no_linea",ii_linea)
//Dependiendo del Tipo de Factura, Recupera la Cuenta
choose case ls_tipo
	case "CO"	
		ls_cuenta = ids_tipofac.GetItemString(1,"fara_cta_desc_contado")			
	case "CR"	
		ls_cuenta = ids_tipofac.GetItemString(1,"fara_cta_desc_credito")				
	case "CD"	
		ls_cuenta = ids_tipofac.GetItemString(1,"fara_cta_desc_cod")				
end choose		
//Verifica el numero de cuenta, y lo Inserta
if isnull(ls_cuenta) or ls_cuenta = '' then
	gf_mensaje("","Debe Asignar la Cuenta Contable a los Descuentos en Ventas, Para Poder Hacer el Pase",1,1,"S")
	ids_ddiari.Deleterow(ll_ultima)
	return 0
else
	ids_ddiari.SetItem(ll_ultima,"ddia_mg_cuenta",ls_cuenta)	
end if

//Inserta el Monto del Descuento
ld_monto 		= truncate(round(adw_dw1.Getitemnumber(ai_fila,"fact_monto_fact_total"),2),2) 
ld_monto_final = truncate(round(adw_dw1.Getitemnumber(ai_fila,"fact_monto_final"),2),2)
ld_monto_gasto = truncate(round(adw_dw1.Getitemnumber(ai_fila,"fact_gastos_total"),2),2)

ids_ddiari.SetItem(ll_ultima,"ddia_monto",abs(ld_monto_final - (ld_monto + ld_monto_gasto)))
//Valida si es Factura o devolucion
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Credito Si es devolucion
	ids_ddiari.SetItem(ll_ultima,"ddia_naturaleza","C")
	//setea el monto a la variable de control	
	id_credito = id_credito + abs(ld_monto_final - (ld_monto + ld_monto_gasto))			
else																	  //Debito Si es Factura
	ids_ddiari.SetItem(ll_ultima,"ddia_naturaleza","D")				
	//setea el monto a la variable de control		
	id_debito = id_debito + abs(ld_monto_final - (ld_monto + ld_monto_gasto))	
end if
//Codigo del Tercero
ids_ddiari.SetItem(ll_ultima,"ddia_tercero",adw_dw1.GetitemNumber(ai_fila,"fact_cliente"))
//Documento Anexo = Numero del Pedido como referencia
ids_ddiari.SetItem(ll_ultima,"ddia_documento_anexo",adw_dw1.GetitemString(ai_fila,"fact_no_pedido"))
//Año del documento
ids_ddiari.SetItem(ll_ultima,"ddia_ann",adw_dw1.GetitemNumber(ai_fila,"fact_ann"))

return 1
end function

public subroutine wf_inserta_encabezado (integer ai_fila, datawindow adw_dw1);//Inserta en el Encabezado de DGTDIARI
long ll_ultima
decimal	ld_descuento_ncr,ld_monto_final
String	ls_cond_pago

ids_tdiari.InsertRow(0)
ll_ultima = ids_tdiari.RowCount()	//Carga la fila insertada a la variable
gf_setea_grupo_empresa_ds(ids_tdiari,"tdia",ll_ultima)  			  //Grupo y Empresa
//Setea Aplicacion = Facturacion
ids_tdiari.SetItem(ll_ultima,"tdia_aplicacion","FA")
//Setea el tipo de Transaccion y subtransaccion
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Si es devolucion
	ids_tdiari.SetItem(ll_ultima,"tdia_tipo_transaccion","NC")
	ids_tdiari.SetItem(ll_ultima,"tdia_sub_tipo_transaccion","2")	
else																	  //Si es Factura
	ids_tdiari.SetItem(ll_ultima,"tdia_tipo_transaccion","FA")			
	//Concepto, por mayor o menor en Subtransaccion
	ids_tdiari.SetItem(ll_ultima,"tdia_sub_tipo_transaccion",adw_dw1.GetitemString(ai_fila,"fact_tipo"))	
end if
//No de Factura como Numero de Documento
ids_tdiari.SetItem(ll_ultima,"tdia_no_documento",adw_dw1.Getitemstring(ai_fila,"fact_no_factura")) 
//Fecha de la Transaccion
ids_tdiari.SetItem(ll_ultima,"tdia_fecha_transaccion",adw_dw1.GetitemDatetime(ai_fila,"fact_fecha"))
//Descripcion del Pase
ids_tdiari.SetItem(ll_ultima,"tdia_descripcion",wf_descripcion(ai_fila,adw_dw1))
//Usuario
ids_tdiari.SetItem(ll_ultima,"tdia_id_registro",str.usuario)
//Fecha del Registro
ids_tdiari.SetItem(ll_ultima,"tdia_fecha_reg",gf_fecha_serv())
//Estado
ids_tdiari.SetItem(ll_ultima,"tdia_retenido",'N')
//Monto Total del Encabezado

ls_cond_pago = adw_dw1.GetitemString(ai_fila,"fact_condicion_pago")

ids_tdiari.SetItem(ll_ultima,"tdia_monto_total",truncate(round(adw_dw1.GetitemNumber(ai_fila,"fact_monto_final"),2),2))

if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 and ls_cond_pago ='CO' then
	
	ld_monto_final = truncate(round(adw_dw1.GetitemNumber(ai_fila,"fact_monto_final"),2),2)
	ld_descuento_ncr = truncate(round(adw_dw1.GetitemNumber(ai_fila,"fact_descuento_ncr"),2),2)
	if IsNull(ld_descuento_ncr) then ld_descuento_ncr =0
	
	ld_monto_final = ld_monto_final - ld_descuento_ncr
	ids_tdiari.SetItem(ll_ultima,"tdia_monto_total",ld_monto_final)

end if
//Año del documento
ids_tdiari.SetItem(ll_ultima,"tdia_ann",adw_dw1.GetitemNumber(ai_fila,"fact_ann"))

end subroutine

public function integer wf_inserta_cliente (integer ai_fila, datawindow adw_dw1);//Inserta el Detalle del Monto que se le cargará al Cliente
long 	  ll_ultima
string  ls_cuenta, ls_cond_pago
decimal  ld_monto,ld_monto_final, ld_descuento_ncr

ids_ddiari.InsertRow(0)

ll_ultima = ids_ddiari.Rowcount()
//Setea el Grupo Financiero y Empresa a DGDDIARI
gf_setea_grupo_empresa_ds(ids_ddiari,"ddia",ll_ultima)
//Aplicacion de Facturacion
ids_ddiari.SetItem(ll_ultima,"ddia_aplicacion","FA")
//Setea el tipo de Transaccion y subtransaccion
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Si es devolucion
	ids_ddiari.SetItem(ll_ultima,"ddia_tipo_transaccion","NC")
	ids_ddiari.SetItem(ll_ultima,"ddia_sub_tipo_transaccion","2")	
else																	  //Si es Factura
	ids_ddiari.SetItem(ll_ultima,"ddia_tipo_transaccion","FA")			
	//Concepto, por mayor o menor en Subtransaccion
	ids_ddiari.SetItem(ll_ultima,"ddia_sub_tipo_transaccion",adw_dw1.GetitemString(ai_fila,"fact_tipo"))	
end if
//Setea el numero de documento
ids_ddiari.SetItem(ll_ultima,"ddia_no_documento",adw_dw1.GetitemString(ai_fila,"fact_no_factura"))
//Numero de Linea 
ids_ddiari.SetItem(ll_ultima,"ddia_no_linea",ii_linea)
//Verifica el numero de cuenta, y lo Inserta
ls_cuenta = adw_dw1.GetItemString(ai_fila,"clie_mg_cuenta")
if isnull(ls_cuenta) or ls_cuenta = '' then
	gf_mensaje("","Debe Asignar la Cuenta Contable al Cliente, Para Poder Hacer el Pase",1,1,"S")
	ids_ddiari.Deleterow(ll_ultima)
	ii_linea -- //Decrementa la Linea
	return 0
else
	ids_ddiari.SetItem(ll_ultima,"ddia_mg_cuenta",ls_cuenta)	
end if
//Inserta el Monto Total de la Factura
ld_monto = truncate(round(adw_dw1.Getitemnumber(ai_fila,"fact_monto_final"),2),2)

/***********ADD BY HGN APLICA SOLO PARA ACISA***********************/
ls_cond_pago = adw_dw1.GetitemString(ai_fila,"fact_condicion_pago")

//ids_tdiari.SetItem(ll_ultima,"tdia_monto_total",truncate(round(adw_dw1.GetitemNumber(ai_fila,"fact_monto_final"),2),2))

ids_ddiari.SetItem(ll_ultima,"ddia_monto",ld_monto)

if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 and ls_cond_pago ='CO' then
	
	ld_descuento_ncr = truncate(round(adw_dw1.GetitemNumber(ai_fila,"fact_descuento_ncr"),2),2)
	
	if IsNull(ld_descuento_ncr) then ld_descuento_ncr =0
	
	ld_monto = ld_monto - ld_descuento_ncr
	ids_ddiari.SetItem(ll_ultima,"ddia_monto",ld_monto)

end if
/*FIN VALIDACION ACISA*/


//Valida si es Factura o devolucion
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Credito Si es devolucion
	ids_ddiari.SetItem(ll_ultima,"ddia_naturaleza","C")
	//setea el monto final a la variable de control
	id_credito = id_credito + ld_monto	
else																	  //Debito Si es Factura
	ids_ddiari.SetItem(ll_ultima,"ddia_naturaleza","D")			
	//setea el monto final a la variable de control	
	id_debito = id_debito + ld_monto
end if
//Codigo del Tercero
ids_ddiari.SetItem(ll_ultima,"ddia_tercero",adw_dw1.GetitemNumber(ai_fila,"fact_cliente"))
//Documento Anexo = Numero del Pedido como referencia
ids_ddiari.SetItem(ll_ultima,"ddia_documento_anexo",adw_dw1.GetitemString(ai_fila,"fact_no_pedido"))
//año del documento
ids_ddiari.SetItem(ll_ultima,"ddia_ann",adw_dw1.GetitemNumber(ai_fila,"fact_ann"))

return 1
end function

public function integer wf_inserta_detalle (integer ai_fila, datawindow adw_dw1);//inserta en el Detalle de las Transacciones a Contabilidad (dgddiari)
//blanque las variables de control
id_debito = 0
id_credito = 0
string ls_factura

//Inserta los Montos totales al Cliente en lado "CREDITO" o "DEBITO" si es Devolucion
if wf_inserta_cliente(ai_fila, adw_dw1) = 0 then return 0

//Inserta su contraparte en Ventas, Dependiendo de Que tipo de Ventas se Afectan,
//Por tipo de Factura o por Region
if ii_venta_por = 1 then //Cuando es por tipo de Factura
	if wf_inserta_venta_tipo(ai_fila, adw_dw1) = 0 then return 0
	//Inserta El descuento en venta, si lo hubo	
	if wf_inserta_descuento(ai_fila, adw_dw1) = 0 then return 0	
else
	if wf_inserta_venta_region(ai_fila, adw_dw1) = 0 then return 0
	//Inserta El descuento en venta, si lo hubo
	if wf_inserta_descuento_region(ai_fila, adw_dw1) = 0 then return 0		
end if

//Inserta los Cargos Correspondiente a la Factura o Devolucion
if wf_inserta_cargos(ai_fila, adw_dw1) = 0 then return 0

//Si la transaccion no está balanceada, que no la pase.

//if truncate(round(id_debito,2),2) <> truncate(round(id_credito,2),2) then 
if round(id_debito,2) <> round(id_credito,2) then 
	ls_factura = adw_dw1.getitemstring(ai_fila,"fact_no_factura")
	gf_mensaje("","El Documento "+ls_factura+" No está Balanceado, Verifique",1,1,"E")
	return 0 
end if
return 1
end function

public function integer wf_inserta_venta_region (integer ai_fila, datawindow adw_dw1);//Inserta los Montos de las Ventas, Por Region de la Venta
string  ls_tipo, ls_cuenta
long 	  ll_ultima, ll_pais
integer li_region
decimal  ld_monto,ld_descuento_ncr

//Incrementa la linea del Detalle de Transacciones
ii_linea ++

//Recupera el Pais y la Region de Venta.
ll_pais   = adw_dw1.GetItemNumber(ai_fila,"terc_pais")
li_region = adw_dw1.GetItemNumber(ai_fila,"terc_region")

//Recupera las Cuentas Contables por La Region en donde se Hizo la Venta
if ids_region.Retrieve(str.g_financiero, str.empresa, ll_pais, li_region) < 1 then 
	gf_mensaje("","Verifique las Cuentas Contables para la Region del Cliente "+string(adw_dw1.Getitemnumber(ai_fila,"fact_cliente")),1,1,"S")
	return 0
end if

//Recupera el Tipo de Venta.
ls_tipo = adw_dw1.GetItemstring(ai_fila,"fact_condicion_pago")

//Inserta una linea en el detalle (DGDDIARI)
ids_ddiari.InsertRow(0)

ll_ultima = ids_ddiari.Rowcount()

//Setea el Grupo Financiero y Empresa a DGDDIARI
gf_setea_grupo_empresa_ds(ids_ddiari,"ddia",ll_ultima)
//Aplicacion de Facturacion
ids_ddiari.SetItem(ll_ultima,"ddia_aplicacion","FA")
//Setea el tipo de Transaccion y subtransaccion
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Si es devolucion
	ids_ddiari.SetItem(ll_ultima,"ddia_tipo_transaccion","NC")
	ids_ddiari.SetItem(ll_ultima,"ddia_sub_tipo_transaccion","2")	
else																	  //Si es Factura
	ids_ddiari.SetItem(ll_ultima,"ddia_tipo_transaccion","FA")			
	//Concepto, por mayor o menor en Subtransaccion
	ids_ddiari.SetItem(ll_ultima,"ddia_sub_tipo_transaccion",adw_dw1.GetitemString(ai_fila,"fact_tipo"))
end if
//Setea el numero de documento
ids_ddiari.Setitem(ll_ultima,"ddia_no_documento",adw_dw1.GetitemString(ai_fila,"fact_no_factura"))
//Setea la Linea
ids_ddiari.SetItem(ll_ultima,"ddia_no_linea",ii_linea)
//Dependiendo del Tipo de Transaccion y del Tipo de Factura, Recupera la Cuenta
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Si es devolucion, Recupera las Cuentas
	choose case ls_tipo
		case "CO"	
			ls_cuenta = ids_region.GetItemString(1,"rege_cta_vta_contado")			
		case "CR"	
			ls_cuenta = ids_region.GetItemString(1,"rege_cta_vta_credito")				
		case "CD"	
			ls_cuenta = ids_region.GetItemString(1,"rege_cta_vta_cod")				
	end choose		
else																	  //Debito Si es Factura
	choose case ls_tipo
		case "CO"	
			ls_cuenta = ids_region.GetItemString(1,"rege_cta_devol_contado")							
		case "CR"	
			ls_cuenta = ids_region.GetItemString(1,"rege_cta_devol_credito")										
		case "CD"	
			ls_cuenta = ids_region.GetItemString(1,"rege_cta_devol_cod")										
	end choose
end if
//Verifica el numero de cuenta, y lo Inserta
if isnull(ls_cuenta) or ls_cuenta = '' then
	gf_mensaje("","Debe Asignar la Cuenta Contable a Todas las Regiones, Para Hacer el Pase",1,1,"S")
	ids_ddiari.Deleterow(ll_ultima)
	ii_linea -- //Decrementa la Linea
	return 0
else
	ids_ddiari.SetItem(ll_ultima,"ddia_mg_cuenta",ls_cuenta)	
end if
//Inserta el Monto Total de la Factura
ld_monto = truncate(round(adw_dw1.Getitemnumber(ai_fila,"fact_monto_fact_total"),2),2)

ids_ddiari.SetItem(ll_ultima,"ddia_monto",ld_monto)

/***********ADD BY HGN APLICA SOLO PARA ACISA***********************/
//ls_cond_pago = adw_dw1.GetitemString(ai_fila,"fact_condicion_pago")

if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 and ls_tipo ='CO' then
	
	ld_descuento_ncr = truncate(round(adw_dw1.GetitemNumber(ai_fila,"fact_descuento_ncr"),2),2)
	
	if IsNull(ld_descuento_ncr) then ld_descuento_ncr =0
	
	ld_monto = ld_monto - ld_descuento_ncr
	ids_ddiari.SetItem(ll_ultima,"ddia_monto",ld_monto)

end if
/*FIN VALIDACION ACISA*/


//Valida si es Factura o devolucion
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Credito Si es devolucion
	ids_ddiari.SetItem(ll_ultima,"ddia_naturaleza","D")
	//setea el monto a la variable de control	
	id_debito  = id_debito + ld_monto			
else																	  //Debito Si es Factura	
	ids_ddiari.SetItem(ll_ultima,"ddia_naturaleza","C")			
	//setea el monto a la variable de control
	id_credito = id_credito + ld_monto
end if
//Codigo del Tercero
ids_ddiari.SetItem(ll_ultima,"ddia_tercero",adw_dw1.GetitemNumber(ai_fila,"fact_cliente"))
//Documento Anexo = Numero del Pedido como referencia
ids_ddiari.SetItem(ll_ultima,"ddia_documento_anexo",adw_dw1.GetitemString(ai_fila,"fact_no_pedido"))
//Año del documento
ids_ddiari.SetItem(ll_ultima,"ddia_ann",adw_dw1.GetitemNumber(ai_fila,"fact_ann"))


return 1
end function

public function integer wf_inserta_venta_tipo (integer ai_fila, datawindow adw_dw1);//Inserta los Montos de las Ventas, Por tipo de Factura (CR, CO, C.O.D)
string  ls_tipo, ls_cuenta, ls_tipopago, ls_expresion, ls_cond_pago
long 	  ll_ultima
decimal ld_monto,ld_descuento_ncr
integer li_encontro

//Incrementa la linea del Detalle de Transacciones
ii_linea ++

//Recupera el Tipo de Factura.
ls_tipo     = adw_dw1.GetItemstring(ai_fila,"fact_tipo")
//Recupera el Tipo de forma de pago de la factura.
ls_tipopago = adw_dw1.GetItemstring(ai_fila,"fact_condicion_pago")

ids_ddiari.InsertRow(0)

ll_ultima = ids_ddiari.Rowcount()
//Setea el Grupo Financiero y Empresa a DGDDIARI
gf_setea_grupo_empresa_ds(ids_ddiari,"ddia",ll_ultima)
//Aplicacion de Facturacion
ids_ddiari.SetItem(ll_ultima,"ddia_aplicacion","FA")
//Setea el tipo de Transaccion y subtransaccion
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Si es devolucion
	ids_ddiari.SetItem(ll_ultima,"ddia_tipo_transaccion","NC")
	ids_ddiari.SetItem(ll_ultima,"ddia_sub_tipo_transaccion","2")	
else																	  //Si es Factura
	ids_ddiari.SetItem(ll_ultima,"ddia_tipo_transaccion","FA")			
	//Concepto, por mayor o menor en Subtransaccion
	ids_ddiari.SetItem(ll_ultima,"ddia_sub_tipo_transaccion",adw_dw1.GetitemString(ai_fila,"fact_tipo"))
end if
//Setea el numero de documento
ids_ddiari.Setitem(ll_ultima,"ddia_no_documento",adw_dw1.GetitemString(ai_fila,"fact_no_factura"))
//Setea la Linea
ids_ddiari.SetItem(ll_ultima,"ddia_no_linea",ii_linea)
//Dependiendo del Tipo de Transaccion y del Tipo de Factura, Recupera la Cuenta
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Si es devolucion, Recupera las Cuentas
	choose case ls_tipopago
		case "CO"	
			ls_cuenta = ids_tipofac.GetItemString(1,"fara_cta_vta_contado")			
		case "CR"	
			ls_cuenta = ids_tipofac.GetItemString(1,"fara_cta_vta_credito")				
		case "CD"	
			ls_cuenta = ids_tipofac.GetItemString(1,"fara_cta_vta_cod")				
	end choose		
else																	  //Debito Si es Factura
//	choose case ls_tipo
//		case "CO"	
//			ls_cuenta = ids_tipofac.GetItemString(1,"fara_cta_devol_contado")							
//		case "CR"	
//			ls_cuenta = ids_tipofac.GetItemString(1,"fara_cta_devol_credito")										
//		case "CD"	
//			ls_cuenta = ids_tipofac.GetItemString(1,"fara_cta_devol_cod")										
//	end choose
	ls_expresion = "serd_sub_trans = '"+ls_tipo+"'"
	li_encontro  = ids_tipos.Find(ls_expresion,1,ids_tipos.Rowcount())
	if li_encontro > 0 then
		ls_cuenta = ids_tipos.getitemstring(li_encontro,"mg_cuenta")
	end if
end if
//Verifica el numero de cuenta, y lo Inserta
if isnull(ls_cuenta) or ls_cuenta = '' then
	gf_mensaje("","Debe Asignar la Cuenta Contable al los Tipos de Ventas, Para Hacer el Pase",1,1,"S")
	ids_ddiari.Deleterow(ll_ultima)
	ii_linea -- //Decrementa la Linea
	return 0 
else
	ids_ddiari.SetItem(ll_ultima,"ddia_mg_cuenta",ls_cuenta)	
end if
//Inserta el Monto Total de la Factura
ld_monto = truncate(round(adw_dw1.Getitemnumber(ai_fila,"fact_monto_fact_total"),2),2)

ids_ddiari.SetItem(ll_ultima,"ddia_monto",ld_monto)

/***********ADD BY HGN APLICA SOLO PARA ACISA***********************/
ls_cond_pago = adw_dw1.GetitemString(ai_fila,"fact_condicion_pago")

if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 and ls_cond_pago ='CO' then
	
	ld_descuento_ncr = truncate(round(adw_dw1.GetitemNumber(ai_fila,"fact_descuento_ncr"),2),2)
	
	if IsNull(ld_descuento_ncr) then ld_descuento_ncr =0
	
	ld_monto = ld_monto - ld_descuento_ncr
	ids_ddiari.SetItem(ll_ultima,"ddia_monto",ld_monto)

end if
/*FIN VALIDACION ACISA*/

//Valida si es Factura o devolucion
if adw_dw1.GetitemNumber(ai_fila,"devolucion") = 1 then //Credito Si es devolucion
	ids_ddiari.SetItem(ll_ultima,"ddia_naturaleza","D")
	//setea el monto a la variable de control	
	id_debito = id_debito + ld_monto
else																	  //Debito Si es Factura
	//setea el monto a la variable de control	
	id_credito = id_credito + ld_monto		
	ids_ddiari.SetItem(ll_ultima,"ddia_naturaleza","C")			
end if
//Codigo del Tercero
ids_ddiari.SetItem(ll_ultima,"ddia_tercero",adw_dw1.GetitemNumber(ai_fila,"fact_cliente"))
//Documento Anexo = Numero del Pedido como referencia
ids_ddiari.SetItem(ll_ultima,"ddia_documento_anexo",adw_dw1.GetitemString(ai_fila,"fact_no_pedido"))
//Año del documento
ids_ddiari.SetItem(ll_ultima,"ddia_ann",adw_dw1.GetitemNumber(ai_fila,"fact_ann"))

return 1
end function

public subroutine wf_avance (long al_avance, long al_total);//Marca el Avance en la barra

//ole_1.Object.Value = (al_avance / al_total) * 100
end subroutine

on w_fa_man_pase_a_conta.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.em_fecha_inicial=create em_fecha_inicial
this.em_fecha_final=create em_fecha_final
this.st_3=create st_3
this.st_1=create st_1
this.gb_4=create gb_4
this.gb_2=create gb_2
this.dw_2=create dw_2
this.cbx_fechas=create cbx_fechas
this.pb_1=create pb_1
this.r_1=create r_1
this.st_4=create st_4
this.pb_2=create pb_2
this.dw_3=create dw_3
this.st_2=create st_2
this.st_5=create st_5
this.em_1=create em_1
this.em_2=create em_2
this.cbx_fac=create cbx_fac
this.pb_3=create pb_3
this.gb_3=create gb_3
this.uo_animate=create uo_animate
this.cb_descartar=create cb_descartar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_fecha_inicial
this.Control[iCurrent+2]=this.em_fecha_final
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.gb_4
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.cbx_fechas
this.Control[iCurrent+9]=this.pb_1
this.Control[iCurrent+10]=this.r_1
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.pb_2
this.Control[iCurrent+13]=this.dw_3
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.st_5
this.Control[iCurrent+16]=this.em_1
this.Control[iCurrent+17]=this.em_2
this.Control[iCurrent+18]=this.cbx_fac
this.Control[iCurrent+19]=this.pb_3
this.Control[iCurrent+20]=this.gb_3
this.Control[iCurrent+21]=this.uo_animate
this.Control[iCurrent+22]=this.cb_descartar
end on

on w_fa_man_pase_a_conta.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_fecha_inicial)
destroy(this.em_fecha_final)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.dw_2)
destroy(this.cbx_fechas)
destroy(this.pb_1)
destroy(this.r_1)
destroy(this.st_4)
destroy(this.pb_2)
destroy(this.dw_3)
destroy(this.st_2)
destroy(this.st_5)
destroy(this.em_1)
destroy(this.em_2)
destroy(this.cbx_fac)
destroy(this.pb_3)
destroy(this.gb_3)
destroy(this.uo_animate)
destroy(this.cb_descartar)
end on

event resize;this.X=5
tHIS.Y=5
//
end event

event ue_post_open;//Override
datetime ldt_fecha

/* dw corresponde al datawindows que se desea imprimir, por tanto
   si desea asignarle otro nombre haga lo siguiente 
	dw = otro_nombre */
dw = dw_1
dw_impresion =dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()

//Asigna la Imagen a la Ventana
dw_2.dataobject = "dw_ma_fa_imagen_pase"
dw_2.Settransobject(sqlca)
dw_2.Insertrow(0)
dw_2.Setitem(1,1,str.path+"art\pase_contabilidad.bmp")

//Inicializa el dw3 que es el de Preview
dw_3.dataobject = "dw_ma_fa_imp_pase_a_conta"
dw_3.SetTransObject(sqlca)

//Oculta Botones
wf_botones()

//Extrae el Sql Original
is_nativo = dw_1.Getsqlselect()

//Setea el Sql y Recupera los datos de la Factura
wf_setear_sql()
	
  SELECT faaparam.fara_pase_region_o_tipo  
    INTO :ii_venta_por	
    FROM faaparam  
   WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
         ( faaparam.fara_empresa = :str.empresa )   ;
	
	if sqlca.sqlcode = -1 then
		gf_mensaje("","Error al Seleccionar de Parametros "+sqlca.sqlerrtext,1,1,"E")
	end if

 if ii_venta_por = 1 then  // Las Ventas Se Pasan Por Tipo de Factura, (Contado, Credito, COD)
   //Recupera los Tipos de Ventas de Parámetros
	//Inicializa los DataStore´s que Utilizarán el Pase	
   wf_crear_data_store("TIPO")

 else
	//Recupera las Ventas de las Regiones
	//Inicializa los DataStore´s que Utilizarán el Pase	
   wf_crear_data_store("REGION")
	
 end if	
//Setea las Fechas del Filtrado
	ldt_fecha	= gf_fecha_serv()	
	em_fecha_inicial.text = "01/"+string(month(date(ldt_fecha)))+"/"+string(year(date(ldt_fecha)))
	em_fecha_final.text = string(date(ldt_fecha))

//Si no es el SA, deshabilita el boton de Descartar Pase
	if str.usuario <> 'SA' then cb_descartar.enabled = false

str.frame.Setredraw(true)
this.Setredraw(true)
end event

event close;
if isvalid(this) then 
	destroy ids_tdiari
	destroy ids_cargos
	destroy ids_ddiari
	destroy ids_region
	destroy ids_tipofac
	close(this)
end if
end event

event open;call super::open;//String ls_path
//String ls_systemdirectory = Space(256)
//
//
//// Application can only run on 32-Bit Windows.
//If ge_environment.OSMajorRevision <> 4 Then
//	MessageBox('Animate Demo', 'Animate Demo requires Windows 95 or later.', StopSign!)
//	Halt
//Else
//	// Check that the COMCTL32.DLL could be found.
//	GetSystemDirectory(ls_systemdirectory, Len(ls_systemdirectory))
//	
//	If NOT FileExists(ls_systemdirectory + '\comctl32.dll') Then
//		MessageBox('Animate Demo', 'Animate Demo requiere que comctl32.dll este presente en el directorio ' + ls_systemdirectory, StopSign!)
//	End If
//
//	// Get the location of the Demo AVI file.
//	ls_path = str.path
//	//this.Of_BrowseForFolder('Please select the location of the DEMO.AVI file.', True)
//
//	If NOT IsNull(ls_path) Then
//		// Validate the path and file.
//		is_filename_avi = ls_path + '\Art\DEMO.AVI'
//		If IsNull(ls_path) or not FileExists(is_filename_avi) Then
//			MessageBox('Animate Demo', 'Animate Demo no pudo localizar el archivo DEMO.AVI.', StopSign!)
//		End If
//	End If
//End If
end event

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_man_pase_a_conta
boolean visible = false
integer x = 32
integer y = 1408
fontcharset fontcharset = defaultcharset!
end type

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_man_pase_a_conta
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_man_pase_a_conta
event ue_key pbm_dwnkey
integer x = 503
integer y = 264
integer width = 2798
integer height = 1120
integer taborder = 80
string dataobject = "dw_ma_fa_pase_a_conta"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = false
borderstyle borderstyle = stylelowered!
end type

event dw_1::ue_key;long ll_i
If keyDown(KeyEnd!) and keyDown(KeyShift!) Then
	FOR ll_i = il_old_row TO this.RowCount()
		this.SelectRow(ll_i,true)
	NEXT
ElseIf keyDown(KeyHome!) and keyDown(KeyShift!) Then
		FOR ll_i = il_old_row TO 1 STEP -1
			this.SelectRow(ll_i,true)
		NEXT
	 ElseIf keyDown(KeyUpArrow!) and keyDown(KeyShift!) Then	 
				this.SelectRow(This.GetRow() - 1,true)
		  ElseIf keyDown(KeyDownArrow!) and keyDown(KeyShift!) Then	
					this.SelectRow(This.GetRow() + 1,true)
				ElseIf keyDown(KeyUpArrow!)then
						this.SelectRow(0,false)
						if this.Getrow() <> 1 then
							this.SelectRow(This.GetRow() - 1, true)																		
						end if
					 ElseIf keyDown(KeyDownArrow!)then							
							 this.SelectRow(0,false)
							 this.SelectRow(This.GetRow() + 1, true)
						  End If
end event

event dw_1::ue_escape;//Override
Send(Handle(dw_1), 274, 61728, 0)
end event

event dw_1::clicked;//validaciones de las teclas
long ll_i


If row = 0 then Return

If Keydown(KeyShift!) then
	dw_1.setredraw(false)
	If row > il_old_row Then
		FOR ll_i = il_old_row TO row 
			this.SelectRow(ll_i,true)
		NEXT
	Else
		FOR ll_i = il_old_row TO row Step -1
			this.SelectRow(ll_i,true)
		NEXT
	End If		
	dw_1.setredraw(true)

ElseIf Keydown(KeyControl!) then
		If IsSelected(row) Then
			this.SelectRow(row,false)
		Else
			this.SelectRow(row,true)
		End if		
Else

	this.SelectRow(0,FALSE)
	this.SelectRow(row,TRUE)
	
End If  

il_old_row = row

//If keyDown(keyControl!) Then  
//	If IsSelected(row) Then
//		this.SelectRow(row,false)
//	Else
//		this.SelectRow(row,true)
//	End if
//ElseIf keyDown(KeyShift!) Then
//	If row > il_old_row Then
//		FOR ll_i = il_old_row TO row 
//			this.SelectRow(ll_i,true)
//		NEXT
//	Else
//		FOR ll_i = il_old_row TO row Step -1
//			this.SelectRow(ll_i,true)
//		NEXT
//	End If
//ElseIf keyDown(KeyLeftButton!) Then
//	this.SelectRow(0,false)
//	this.SelectRow(row,true)
//End If
//il_old_row = row

end event

event dw_1::rowfocuschanged;//this.Postevent("clicked")
il_old_row = currentrow
end event

event dw_1::doubleclicked;string ls_campo, ls_ordenar, ls_tipo_orden

this.Accepttext()

ls_campo = this.Getcolumnname()

ls_tipo_orden = this.Getitemstring(1,"ordenamiento")

if trim(ls_tipo_orden) = "" or mid(ls_tipo_orden,2,1) = "D" then

	choose case ls_campo
		case "fact_fecha"	
			ls_ordenar = " fact_fecha A long(fact_no_factura) A long(fact_no_pedido) A"
			this.object.ordenamiento.expression = "'F'"
		case "numero"
			ls_ordenar = " long(fact_no_factura) A"
			this.object.ordenamiento.expression = "'N'"
		case "nombre"	
			ls_ordenar = " nombre A fact_fecha A long(fact_no_factura) A long(fact_no_pedido) A"			
			this.object.ordenamiento.expression = "'O'"			
		case "tipo"
			ls_ordenar = " fact_condicion_pago A fact_fecha A long(fact_no_factura) A long(fact_no_pedido) A"					
			this.object.ordenamiento.expression = "'C'"			
		case "vent_descripcion"	
			ls_ordenar = " fact_tipo_venta A fact_fecha A long(fact_no_factura) A long(fact_no_pedido) A"			
			this.object.ordenamiento.expression = "'T'"
		case "movimiento"	
			ls_ordenar = " fact_tipo_movimiento A fact_fecha A long(fact_no_factura) A long(fact_no_pedido) A"			
			this.object.ordenamiento.expression = "'M'"
		case "fact_monto_final"	
			ls_ordenar = " fact_monto_final A fact_fecha A long(fact_no_factura) A long(fact_no_pedido) A"			
			this.object.ordenamiento.expression = "'V'"			
	end choose
else
	choose case ls_campo
		case "fact_fecha"	
			ls_ordenar = " fact_fecha D long(fact_no_factura) D long(fact_no_pedido) D"
			this.object.ordenamiento.expression = "'FD'"
		case "numero"
			ls_ordenar = " long(fact_no_factura) D"		
			this.object.ordenamiento.expression = "'ND'"
		case "nombre"	
			ls_ordenar = " nombre D fact_fecha D long(fact_no_factura) D long(fact_no_pedido) D"			
			this.object.ordenamiento.expression = "'OD'"
		case "tipo"
			ls_ordenar = " fact_condicion_pago D fact_fecha D long(fact_no_factura) D long(fact_no_pedido) D"					
			this.object.ordenamiento.expression = "'CD'"
		case "vent_descripcion"	
			ls_ordenar = " fact_tipo_venta D fact_fecha D long(fact_no_factura) D long(fact_no_pedido) D"			
			this.object.ordenamiento.expression = "'TD'"
		case "movimiento"	
			ls_ordenar = " fact_tipo_movimiento D fact_fecha D long(fact_no_factura) D long(fact_no_pedido) D"			
			this.object.ordenamiento.expression = "'MD'"
		case "fact_monto_final"	
			ls_ordenar = " fact_monto_final D fact_fecha D long(fact_no_factura) D long(fact_no_pedido) D"
			this.object.ordenamiento.expression = "'VD'"
	end choose	
end if
dw_1.setsort(ls_ordenar)
dw_1.sort()
end event

event dw_1::itemfocuschanged;//Para mostrar el mensaje en el Microhelp.
gf_micro_ayuda(this)
end event

event dw_1::itemchanged;//string ls_col
//
//ls_col = this.Getcolumnname()
////this.Reselectrow(row)
//
//if ls_col = "fact_tipo_venta" or ls_col = "fact_tipo_movimiento" or ls_col = "fact_condicion_pago" then
//		if this.Reselectrow(row) = -1 then
//			gf_mensaje("","Error al Restaurar la Linea Modificada "+sqlca.sqlerrtext,1,1,"E")
//		else
//			return 2  //Para que no restaure por el valor modificado
//		end if	
//end if
//
end event

event dw_1::retrieveend;call super::retrieveend;long   i
string ls_termino, ls_movimiento

for i = 1 to rowcount
	if Match(this.getitemstring(i,"fact_no_pedido"), "NC") then
		this.Setitem(i,"devolucion",1)
	end if
	ls_termino = this.Getitemstring(i,"fact_condicion_pago")
	choose case ls_termino
		case "CR"	
			this.SetItem(i,"tipo","CREDITO")
		case "CO"	
			this.SetItem(i,"tipo","CONTADO")			
		case "CD"	
			this.SetItem(i,"tipo","C.O.D")			
	end choose			
	
	ls_movimiento = this.Getitemstring(i,"fact_tipo_movimiento")
	
	choose case ls_movimiento
		case "S"	
			this.SetItem(i,"movimiento","SALIDA")
		case "T"	
			this.SetItem(i,"movimiento","TRASPASO")			
		case "O"	
			this.SetItem(i,"movimiento","OTROS")			
	end choose			
		
	
next
end event

event dw_1::dberror;// Rutina para los errores de la base de datos

If sqlerrtext <> "" Then
	gf_dw_error(sqldbcode, sqlerrtext)
	Return 1
End If
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_man_pase_a_conta
boolean visible = false
integer x = 5
integer y = 0
integer width = 215
integer height = 156
integer taborder = 110
integer textsize = -12
fontcharset fontcharset = defaultcharset!
long backcolor = 12632256
end type

type em_fecha_inicial from editmask within w_fa_man_pase_a_conta
integer x = 1934
integer y = 124
integer width = 434
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean enabled = false
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean spin = true
double increment = 1
end type

event modified;//Si la fecha es modificada, se valida en la función wf_valida_fecha()

date lf_fecha_ini, lf_fecha_fin

lf_fecha_ini = date(em_fecha_inicial.text)
lf_fecha_fin = date(em_fecha_final.text)

wf_valida_fechas(lf_fecha_ini, lf_fecha_fin, 1)

if em_fecha_inicial.text <> string(lf_fecha_ini) then
	em_fecha_inicial.text = string(lf_fecha_ini)
end if

wf_setear_sql()
end event

event losefocus;triggerevent("modified")
end event

type em_fecha_final from editmask within w_fa_man_pase_a_conta
integer x = 2528
integer y = 128
integer width = 439
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean enabled = false
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean spin = true
double increment = 1
end type

event modified;//Si la fecha es modificada, se valida en la función wf_valida_fecha()

date lf_fecha_ini, lf_fecha_fin

lf_fecha_ini = date(em_fecha_inicial.text)
lf_fecha_fin = date(em_fecha_final.text)

wf_valida_fechas(lf_fecha_ini, lf_fecha_fin, 2)  //el 2 indica que es la segunda fecha

//Optimizar, esta entrando aunque no cambie la fecha, porque el año de lf_fecha_fin va en 2 digitos

if em_fecha_final.text <> string(lf_fecha_fin) then
	
	em_fecha_final.text = string(lf_fecha_fin)
	
end if

wf_setear_sql()

dw_1.Setfocus()
end event

type st_3 from statictext within w_fa_man_pase_a_conta
integer x = 2373
integer y = 140
integer width = 146
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Hasta"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_fa_man_pase_a_conta
integer x = 1751
integer y = 136
integer width = 178
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Desde"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_4 from groupbox within w_fa_man_pase_a_conta
integer x = 832
integer y = 52
integer width = 901
integer height = 188
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Facturas"
end type

type gb_2 from groupbox within w_fa_man_pase_a_conta
integer x = 1737
integer y = 52
integer width = 1280
integer height = 188
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Filtrar por Fecha"
end type

type dw_2 from uo_outlookbar within w_fa_man_pase_a_conta
integer x = 18
integer y = 36
integer height = 1348
integer taborder = 100
boolean bringtotop = true
string dataobject = "dw_ma_fa_imagen_pase"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event mousemove;//override
//This.Object.f_bitmap.Border = "0"

String ls_object, ls_border

ls_object = Lower(This.GetObjectAtPointer())
//	messagebox("Mouse move", "x = "+string(xpos)+" y= "+string(ypos))

ls_border = this.Describe("f_bitmap.Border")

if xpos > 448 then
	This.Object.f_bitmap.Border = "6"
else
   // messagebox("Compara el border = 6",ls_border)	
	
  if ls_border	<> "5" then
	  This.Object.f_bitmap.Border = "5"
  end if	
end if



end event

event clicked;//Override

String ls_Object
Integer li_GroupPressed, li_Pos


This.SetRedraw(False)

	is_PictureBorder = "5"
//	This.Object.f_bitmap.Border = "0~tIF (CurrentRow() = GetRow(), 5, 0)"
	This.Object.f_bitmap.Border = "5"

//
//
//
//// Get object that was clicked
//ls_Object = Lower(This.GetObjectAtPointer())
//
//IF (Left(ls_Object, 8) = "f_bitmap") OR (Left(ls_Object, 8) = "icontext") THEN
//	// Icon or icon's text
//	is_PictureBorder = "5"
//	This.Object.f_bitmap.Border = "0~tIF (CurrentRow() = GetRow(), 5, 0)"
//	This.Event ue_ItemClicked(Row, This.GetItemNumber(Row, "IconID"), This.GetItemString(Row, "ObjectName"), This.GetItemString(Row, "ObjectType"), This.GetItemString(Row, "PostOrTrigger"))
//ELSEIF (Left(ls_Object, 5) = "st_up") THEN // Up arrow
//	// Set border down the back up for button-pressed effect
//	This.Object.st_up.Border = "5"
//	This.SetRow(Long(This.Object.DataWindow.FirstRowOnPage))
//	This.ScrollPriorRow()
//	This.Object.st_up.Border = "6"
//ELSEIF (Left(ls_Object, 7) = "st_down") THEN // Down arrow
//	This.Object.st_down.Border = "5"
//	This.SetRow(Long(This.Object.DataWindow.LastRowOnPage))
//	This.ScrollNextRow()
//	This.Object.st_down.Border = "6"
//ELSEIF (Left(ls_Object, 6) = "group_") THEN // Group button
//	li_Pos = Pos(ls_Object, "~t")
//	// If group isn't already currently active, the redraw the DW
//	IF (ii_GroupsOnTop <> Integer(Mid(ls_Object, 7, li_Pos - 7))) THEN
//		ii_GroupsOnTop = Integer(Mid(ls_Object, 7, li_Pos - 7))
//		This.of_Paint()
//	END IF
//END IF
//
This.SetRedraw(True)
end event

event ue_rbuttondown_icon;//Override
end event

event lbuttonup;//Override
end event

event losefocus;This.Object.f_bitmap.Border = "0"
end event

event getfocus;This.Object.f_bitmap.Border = "6"
end event

type cbx_fechas from checkbox within w_fa_man_pase_a_conta
integer x = 2217
integer y = 48
integer width = 69
integer height = 72
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
end type

event clicked;if cbx_fechas.checked then
	cbx_fac.checked = false
	em_1.enabled    = false
	em_2.enabled    = false	
	em_fecha_inicial.enabled = true
	em_fecha_final.enabled   = true
	wf_setear_sql()
else
	em_fecha_inicial.enabled = false
	em_fecha_final.enabled   = false	
	wf_setear_sql()	
end if

dw_1.Setfocus()
end event

type pb_1 from picturebutton within w_fa_man_pase_a_conta
boolean visible = false
integer x = 1536
integer y = 1392
integer width = 498
integer height = 88
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "ok"
end type

event clicked;//Pase de las Facturas a Contabilidad

//boolean rtn
long rtn
//long ll_freq = 500, ll_dur = 20
integer i = 0
string  ls_path

//uo_factura bee

//bee = create uo_factura

//beep(370,5000)
//beep(500,20000)
//beep(30000,10500)

//beep(370,5000)
//beep(500,20000)
//beep(30000,10500)

//rtn =ExitWindowsEx(3,4)
//rtn = ExitWindows(0,0)
ls_path = "C:\Renaul\bmps\Pres.BMP"
rtn = SystemParametersInfoA(20 ,0, ls_path, 3) // fUpdateProfile Variable del ultimo parametro
//Long SPI_SCREENSAVERRUNNING = 17
//Boolean pOld = true

//rtn = SystemParametersInfo(SPI_SCREENSAVERRUNNING ,1, pOld, 0)  //SPI_SETSCREENSAVEACTIVE  

//messagebox("Retorno",rtn)
//ExitWindowsEx()
//Function boolean ExitWindowEx(uint dwReserved, uint uReserved) LIBRARY "User32.dll"

//BOOL ExitWindowsEx(UINT  fuOptions,	  DWORD  dwReserved );

//Scrip
//boolean rtn
//ExitWindowEx(0,0)
end event

type r_1 from rectangle within w_fa_man_pase_a_conta
long linecolor = 8388736
integer linethickness = 4
long fillcolor = 8388736
integer x = 2679
integer y = 1404
integer width = 64
integer height = 52
end type

type st_4 from statictext within w_fa_man_pase_a_conta
integer x = 2770
integer y = 1400
integer width = 443
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Baskerville"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Devoluciones"
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_fa_man_pase_a_conta
string tag = "Pase"
integer x = 3022
integer y = 96
integer width = 251
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pase"
end type

event clicked;//Ejecutar el Pase

long	  ll_ann, i
string  ls_factura, ls_tipo, ls_error
boolean lb_paso = false

if dw_1.RowCount() < 1 then Return

if gf_mensaje("","Se Dispone a Hacer el Pase de las Facturas Seleccionadas, A Contabilidad. Esta Seguro",2,2,"Q") = 2 then return

 //Blanquea los DataStore´s	
 ids_tdiari.reset()
 ids_ddiari.reset()

uo_animate.visible = true
// There are 26 frames in this demo AVI file.
// 1st parameter is the starting frame,
// 2nd parameter is the ending frame (or -1 for all),
// 3rd parameter is the number of times to play the AVI. -1 plays indefinately.
uo_animate.Of_Play(1, -1, -1)
for i = 1 to dw_1.Rowcount()
	str.frame.setmicrohelp("Procesando el Registro " + string(i) + " de " + string(dw_1.rowcount()))
 //Marca el Avance en la barra de Progreso		
 wf_avance(i, dw_1.Rowcount())
 
	if dw_1.IsSelected(i) then	
//		ole_1.Show()				
		//inserta en el Encabezado de Contabilidad (dgtdiari)
		wf_inserta_encabezado(i,dw_1)	
		//Inicializa el numero de linea, para efectos del Detalle
		ii_linea = 1
		//inserta en el Detalle de Contabilidad (dgddiari)		
		if wf_inserta_detalle(i,dw_1)	= 1 then  //Si todo esta Bien
			//Setea 1 a Actualiza Conta y setea la fecha del Pase		
			dw_1.SetItem(i,"fact_act_conta",1)
			dw_1.SetItem(i,"fact_fecha_act_conta",gf_fecha_serv())
			lb_paso = true
		else		//Si no encuentro alguna cuenta, elimina la transaccion completa	
			wf_elimina_registro()
		end if
	end if
next //Fin del For Principal

//Oculta la barra de Progreso
//ole_1.Hide()

uo_animate.of_close()

uo_animate.visible = false
// Si no hay ninguno seleccionado, retorna
if not lb_paso then return

sqlca.autocommit = false

if ids_tdiari.Update() = 1 then			//Encabezado del Pase
	if ids_ddiari.Update() = 1 then		//Detalle del Pase
		//Pone las Propiedades de Update a los Campos de Pase de fatdiari
		dw_1.Modify("DataWindow.Table.UpdateTable='fatdiari'")	
		dw_1.Modify("DataWindow.Table.UpdateKeyinPlace=Yes")		
		dw_1.Modify("DataWindow.Table.UpdateWhere='1'")
		dw_1.Modify("fact_act_conta.Update=Yes")
		dw_1.Modify("fact_fecha_act_conta.Update=Yes")		
		
		if dw_1.Update() = 1 then			//Actualiza dw_1
			commit;
			gf_mensaje("","Pase a Contabilidad Ejecutado Satisfactoriamente",1,1,"E")
		else
			ls_error = sqlca.sqlerrtext
			rollback;
			gf_mensaje("","Error al Actualizar los Campos de Actualiza Conta. y Fecha del DW 1 "+ls_error,1,1,"E")
		end if	
	else
		ls_error = sqlca.sqlerrtext
		rollback;
		gf_mensaje("","Error al Actualizar El Pase a Contabilidad (Detalle) "+ls_error,1,1,"E")	
	end if
else
	ls_error = sqlca.sqlerrtext	
	rollback ;
	gf_mensaje("","Error al Actualizar El Pase a Contabilidad (Encabezado) "+ls_error,1,1,"E")	
end if

sqlca.autocommit = true

//Recupera nuevamente los Registros por pasar
wf_setear_sql()
end event

type dw_3 from datawindow within w_fa_man_pase_a_conta
boolean visible = false
integer x = 2034
integer y = 1380
integer width = 251
integer height = 116
integer taborder = 140
boolean bringtotop = true
string dataobject = "dw_ma_fa_imp_pase_a_conta"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_fa_man_pase_a_conta
integer x = 864
integer y = 136
integer width = 206
integer height = 76
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
string text = "Desde"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_fa_man_pase_a_conta
integer x = 1294
integer y = 136
integer width = 183
integer height = 76
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
string text = "Hasta"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_1 from editmask within w_fa_man_pase_a_conta
integer x = 1065
integer y = 128
integer width = 219
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type em_2 from editmask within w_fa_man_pase_a_conta
integer x = 1477
integer y = 128
integer width = 219
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

event modified;if long(em_2.text) >= long(em_1.text) or em_2.text <> "0" or em_2.text <> '' then
	wf_setear_sql()
	dw_1.Setfocus()
end if	

end event

type cbx_fac from checkbox within w_fa_man_pase_a_conta
integer x = 1125
integer y = 48
integer width = 69
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 79741120
boolean righttoleft = true
end type

event clicked;
if cbx_fac.checked then
	cbx_fechas.checked  = false
	em_fecha_inicial.enabled = false
	em_fecha_final.enabled = false
	em_1.enabled = true
	em_2.enabled = true
	em_1.Setfocus()
else
	em_1.enabled = false
	em_2.enabled = false
	wf_setear_sql()
end if
end event

type pb_3 from picturebutton within w_fa_man_pase_a_conta
integer x = 539
integer y = 96
integer width = 251
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Previo"
end type

event clicked;//Ejecutar la Vista Preeliminar
//the arrogance of the man comes before their ruin, the humility precedes to the glory.

SetPointer(HourGlass!)

long	  i
boolean lb_paso = false

if dw_1.RowCount() < 1 then Return

 //Asigna los Logos de la Empresa a las Variables de Instancia
 wf_asigna_logos()

 //Blanquea El dw de Impresion
 dw_3.reset()

uo_animate.visible = true
// There are 26 frames in this demo AVI file.
// 1st parameter is the starting frame,
// 2nd parameter is the ending frame (or -1 for all),
// 3rd parameter is the number of times to play the AVI. -1 plays indefinately.
uo_animate.Of_Play(1, -1, -1)


for i = 1 to dw_1.Rowcount()		
 
 //Marca el Avance en la barra de Progreso		
 wf_avance(i, dw_1.Rowcount())
 
	if dw_1.IsSelected(i) then
		//Muestra la Barra de Progreso
		ii_linea = 1		
		//inserta en el Detalle de Contabilidad (dgddiari)		
		wf_crear_preview(i,dw_1)
		lb_paso = true
	end if
next //Fin del For Principal	

// Si no hay ninguno seleccionado, retorna
if not lb_paso then return

//Oculta la barra de Progreso
//oculta la animacion
uo_animate.of_close()
uo_animate.visible = false
//Abre la Ventana Preview
This.SetRedraw(False)

	OpenSheet(w_fa_rep_preview_pase_conta,str.frame,9,Layered!)	

This.SetRedraw(True)

end event

type gb_3 from groupbox within w_fa_man_pase_a_conta
integer x = 503
integer width = 2802
integer height = 252
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79416533
string text = "Selección de Registros"
end type

type uo_animate from u_animate within w_fa_man_pase_a_conta
boolean visible = false
integer x = 1298
integer y = 1392
integer width = 1353
integer height = 208
integer taborder = 140
boolean border = true
end type

event constructor;call super::constructor;// Disable the border.
// I put a border on this control for demonstration purposes only
// and it makes is easier to place on the window at design time.
this.Border = False

// Open the AVI file in the Animate control.
is_filename_avi = str.path + '\Art\DEMO.AVI'

this.Of_Open(is_filename_avi)

// There are 26 frames in this demo AVI file.
// 1st parameter is the starting frame,
// 2nd parameter is the ending frame (or -1 for all),
// 3rd parameter is the number of times to play the AVI. -1 plays indefinately.

// This will play the AVI forever.
//this.Of_Play(1, -1, -1)
end event

type cb_descartar from commandbutton within w_fa_man_pase_a_conta
integer x = 2693
integer y = 1480
integer width = 434
integer height = 100
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Descartar Pase"
end type

event clicked;//Ejecutar el Pase

long	  ll_ann, i
string  ls_factura, ls_tipo, ls_error
boolean lb_paso = false

if dw_1.RowCount() < 1 then Return

if gf_mensaje("","Se Dispone a Descartar el Pase a Contabilidad de las Facturas Seleccionadas, . Esta Seguro",2,2,"Q") = 2 then return


for i = 1 to dw_1.Rowcount()
 //Marca el Avance en la barra de Progreso		
 
	if dw_1.IsSelected(i) then	
		//Setea 1 a Actualiza Conta y setea la fecha del Pase		
			dw_1.SetItem(i,"fact_act_conta",1)
			dw_1.SetItem(i,"fact_fecha_descarte",gf_fecha_serv())		
			dw_1.SetItem(i,"fact_descartada_por", str.usuario )					
			lb_paso = true
	end if
next //Fin del For Principal

// Si no hay ninguno seleccionado, retorna
if not lb_paso then return

sqlca.autocommit = false

//Pone las Propiedades de Update a los Campos de Pase de fatdiari
dw_1.Modify("DataWindow.Table.UpdateTable='fatdiari'")	
dw_1.Modify("DataWindow.Table.UpdateKeyinPlace=Yes")		
dw_1.Modify("DataWindow.Table.UpdateWhere='1'")
dw_1.Modify("fact_act_conta.Update=Yes")
dw_1.Modify("fact_fecha_act_conta.Update=Yes")	
dw_1.Modify("fact_fecha_descarte.Update=Yes")	
dw_1.Modify("fact_descartada_por.Update=Yes")	

if dw_1.Update() = 1 then			//Actualiza dw_1
	commit;
	gf_mensaje("","Descarte de Transacciones Exitoso",1,1,"E")
else
	ls_error = sqlca.sqlerrtext
	rollback;
	gf_mensaje("","Error al Descartar las Transacciones"+ls_error,1,1,"E")
end if	

sqlca.autocommit = true

//Recupera nuevamente los Registros por pasar

wf_setear_sql()

end event

