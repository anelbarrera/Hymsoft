//objectcomments  
forward
global type w_dashboard from window
end type
type pb_recuperar from picturebutton within w_dashboard
end type
type wb_dashboard from webbrowser within w_dashboard
end type
type st_3 from statictext within w_dashboard
end type
type ddlb_vendedor from dropdownlistbox within w_dashboard
end type
type st_2 from statictext within w_dashboard
end type
type st_1 from statictext within w_dashboard
end type
type dp_hasta from datepicker within w_dashboard
end type
type dp_desde from datepicker within w_dashboard
end type
end forward

global type w_dashboard from window
integer width = 4718
integer height = 2644
boolean titlebar = true
string title = "Dashboard"
string menuname = "m_fa_rep"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
windowanimationstyle openanimation = rightroll!
windowanimationstyle closeanimation = leftroll!
pb_recuperar pb_recuperar
wb_dashboard wb_dashboard
st_3 st_3
ddlb_vendedor ddlb_vendedor
st_2 st_2
st_1 st_1
dp_hasta dp_hasta
dp_desde dp_desde
end type
global w_dashboard w_dashboard

forward prototypes
public subroutine wf_cargar_dashboard ()
end prototypes

public subroutine wf_cargar_dashboard ();DataStore lds
long ll_row, ll_facturas, ll_facturas_hoy, ll_facturas_semana, ll_facturas_ann
string ls_labels
string ls_values
string ls_js, ls_fecha1
datetime ldt_fecha1, ldt_fecha2, ldt_fecha1_ayer, ldt_fecha2_ayer, ldt_fecha1_mes_anterior, ldt_fecha2_mes_anterior
string ls_file
decimal{2} ld_ventas_hoy, ld_ventas_mes, ld_promedio, ld_ventas_ayer, ld_ventas_mes_anterior, ld_ventas_semana_anterior, &
						ld_ventas_semana, ld_ventas_ann, ld_ventas_ann_anterior
integer li_mes_anterior, li_ann, li_dia_final, li_semana_actual

//ls_file = GetCurrentDirectory() + "\\index_dashboard.html"
//wb_dashboard.Navigate(ls_file)
ldt_fecha1 = dp_desde.value
ldt_fecha2 = dp_hasta.value

 //Top Productos
 ls_labels = ''
 ls_values = ''
 lds = CREATE DataStore
lds.DataObject = "d_dashboard_top_productos"
lds.SetTransObject(SQLCA)
lds.Retrieve(str.g_financiero, str.empresa, ldt_fecha1, ldt_fecha2)

FOR ll_row = 1 TO lds.RowCount()

    ls_labels += "'" + mid(lds.Object.prod_descripcion[ll_row],1,15) + "',"
    ls_values += String(lds.Object.vendidos[ll_row]) + ","

NEXT
destroy lds

ls_labels = Left(ls_labels, Len(ls_labels)-1)
ls_values = Left(ls_values, Len(ls_values)-1)
ls_js = "cargarTopProductos([" + ls_labels + "],[" + ls_values + "])"
wb_dashboard.evaluatejavascriptsync(ls_js)


//Ventas Mensuales
lds = CREATE DataStore
ls_labels = ''
ls_values = ''
lds.DataObject = "d_dashboard_ventas_mes"
lds.SetTransObject(SQLCA)
lds.Retrieve(str.g_financiero, str.empresa, ldt_fecha1, ldt_fecha2)

FOR ll_row = 1 TO lds.RowCount()

    ls_labels += "'" + lds.Object.nombre_mes[ll_row] + "',"
    ls_values += String(lds.Object.total_ventas[ll_row]) + ","

NEXT
destroy lds

ls_labels = Left(ls_labels, Len(ls_labels)-1)
ls_values = Left(ls_values, Len(ls_values)-1)

ls_js = "cargarVentasMes([" + ls_labels + "],[" + ls_values + "])"

wb_dashboard.evaluatejavascriptsync(ls_js)


//Vendedores
 ls_labels = ''
 ls_values = ''
 lds = CREATE DataStore
lds.DataObject = "d_dashboard_vendedores"
lds.SetTransObject(SQLCA)
lds.Retrieve(str.g_financiero, str.empresa, ldt_fecha1, ldt_fecha2)

FOR ll_row = 1 TO lds.RowCount()
    ls_labels += "'" + lds.Object.vendedor[ll_row] + "',"
    ls_values += String(lds.Object.total_ventas[ll_row]) + ","

NEXT
destroy lds

ls_labels = Left(ls_labels, Len(ls_labels)-1)
ls_values = Left(ls_values, Len(ls_values)-1)

ls_js = "cargarVendedores([" + ls_labels + "],[" + ls_values + "])"

wb_dashboard.evaluatejavascriptsync(ls_js)

//Departamentos
 ls_labels = ''
 ls_values = ''
 lds = CREATE DataStore
lds.DataObject = "d_dashboard_departamentos"
lds.SetTransObject(SQLCA)
lds.Retrieve(str.g_financiero, str.empresa, ldt_fecha1, ldt_fecha2)

FOR ll_row = 1 TO lds.RowCount()	
    ls_labels += "'" + lds.Object.adiv_nombre_div[ll_row] + "',"
    ls_values += String(lds.Object.total[ll_row]) + ","
	if ll_row = 15 then exit
NEXT
destroy lds

ls_labels = Left(ls_labels, Len(ls_labels)-1)
ls_values = Left(ls_values, Len(ls_values)-1)

ls_js = "cargarDepartamentos([" + ls_labels + "],[" + ls_values + "])"

wb_dashboard.evaluatejavascriptsync(ls_js)


// Actualizar KPI HTML
ls_fecha1 = string(date(gf_fecha_serv()))
ldt_fecha1 = datetime(date(ls_fecha1), time('00:00:00'))
ldt_fecha2 = ldt_fecha1
	
	 SELECT isnull(SUM( case when f.fact_nota_credito = 1 then f.fact_monto_fact_total * -1 else f.fact_monto_fact_total end ),0) total  , isnull(count(case when f.fact_nota_credito = 1 then -1 else 1 end ) ,0)
	   into :ld_ventas_hoy, :ll_facturas_hoy
    FROM fatdiari f 			       
   WHERE  ( f.fact_g_financiero = :str.g_financiero ) AND  
         ( f.fact_empresa = :str.empresa ) AND  
		 ( convert(datetime, CAST(f.fact_fecha AS DATE), 103) >= convert( datetime, CAST(:ldt_fecha1 AS DATE),103) ) AND
		 ( convert(datetime, CAST(f.fact_fecha AS DATE), 103) <= convert( datetime, CAST(:ldt_fecha2 AS DATE),103) ) and 
		 (f.fact_estado = 'I'); 
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al buscar '+sqlca.sqlerrtext,1,1,'E')
	end if
	
//Desplegar la venta de ayer
ldt_fecha1_ayer = datetime(relativedate(date(ldt_fecha1),-1),time('00:00:00'))
ldt_fecha2_ayer = ldt_fecha1_ayer
	 SELECT isnull(SUM(case when f.fact_nota_credito = 1 then f.fact_monto_fact_total * -1 else f.fact_monto_fact_total end ),0) total 
	   into :ld_ventas_ayer
    FROM fatdiari f 			       
   WHERE  ( f.fact_g_financiero = :str.g_financiero ) AND  
         ( f.fact_empresa = :str.empresa ) AND  
		 ( convert(datetime, CAST(f.fact_fecha AS DATE), 103) >= convert( datetime, CAST(:ldt_fecha1_ayer AS DATE),103) ) AND
		 ( convert(datetime, CAST(f.fact_fecha AS DATE), 103) <= convert( datetime, CAST(:ldt_fecha2_ayer AS DATE),103) ) and 
		 (f.fact_estado = 'I'); 
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al buscar '+sqlca.sqlerrtext,1,1,'E')
	end if
	
//ls_js = "document.getElementById('ventas_ayer').innerText = '$" + String(ld_ventas_ayer, '#,##0.00') + "';"
ls_js = "actualizarKPI([" + string(ld_ventas_hoy) + "],[" + string(ld_ventas_ayer) + "], [" + string(ll_facturas_hoy) + "])"

// Ejecutar JavaScript en el WebView
wb_dashboard.evaluatejavascriptsync(ls_js)			//Actualiza ventas hoy y ventas ayer

//Fecha hoy en kpi ventas hoy y ayer
ls_js = "cargarFechaHoy()"
wb_dashboard.evaluatejavascriptsync(ls_js)
//Fecha Ann
ls_js = "cargarFechaAnn()"
wb_dashboard.evaluatejavascriptsync(ls_js)
//Fecha Mes
ls_js = "cargarFechaMes()"
wb_dashboard.evaluatejavascriptsync(ls_js)

//Ventas Anuales y Ann Anterior
lds = CREATE   DataStore
lds.DataObject = 'd_dashboard_ventas_ann'
lds.SetTransObject(SQLCA)
lds.Retrieve(str.g_financiero, str.empresa)
FOR ll_row = 1 TO lds.RowCount()	
    ld_ventas_ann = lds.Object.venta_anio[ll_row]
    ld_ventas_ann_anterior = lds.Object.venta_anio_anterior[ll_row] 
	 ll_facturas_ann = lds.Object.facturas_anio[ll_row] 
NEXT
destroy lds

ls_js = "actualizarKPIann("+ string(ld_ventas_ann) + "," + string(ld_ventas_ann_anterior) + " ,"+ String(ll_facturas_ann) + ")"
// Ejecutar JavaScript en el WebView
wb_dashboard.evaluatejavascriptsync(ls_js)
//Fin de Ventas Anuales

//Ventas Semana
lds = CREATE DataStore
lds.DataObject = "d_dashboard_ventas_semana"
lds.SetTransObject(SQLCA)
lds.Retrieve(str.g_financiero, str.empresa, ldt_fecha1, ldt_fecha2)

FOR ll_row = 1 TO lds.RowCount()	
    ll_facturas_semana = lds.Object.facturas_semana[ll_row]
    ld_ventas_semana = lds.Object.ventas_semana[ll_row] 
	 li_semana_actual = lds.Object.semana_actual[ll_row] 
	if ll_row = 15 then exit
NEXT
destroy lds

lds = CREATE DataStore
lds.DataObject = "d_dashboard_ventas_semana_anterior"
lds.SetTransObject(SQLCA)
lds.Retrieve(str.g_financiero, str.empresa, ldt_fecha1, ldt_fecha2)

FOR ll_row = 1 TO lds.RowCount()	
    //ll_facturas_semana = lds.Object.facturas_semana_anterior[ll_row]
    ld_ventas_semana_anterior = lds.Object.ventas_semana_anterior[ll_row] 
	if ll_row = 15 then exit
NEXT
destroy lds

ls_js = "actualizarKPIsemana(" + string(ld_ventas_semana) + "," + string(ld_ventas_semana_anterior) + " ," + String(ll_facturas_semana) + " ," + String(li_semana_actual) + " )"
wb_dashboard.evaluatejavascriptsync(ls_js)			//Actualiza Semana  y ventas Semana Anterior

//Venta Mes
li_ann = year(date(ldt_fecha1))

ldt_fecha1 = datetime(date('01/'+string(month(date(ldt_fecha1)))+'/'+string(li_ann )) , time('00:00:00'))
	 SELECT isnull(SUM(case when f.fact_nota_credito = 1 then f.fact_monto_fact_total * -1 else f.fact_monto_fact_total end ),0) total  , isnull(count(case when f.fact_nota_credito = 1 then -1 else 1 end ),0), isnull(AVG(f.fact_monto_fact_total),0)
	   into :ld_ventas_mes,:ll_facturas, :ld_promedio
    FROM fatdiari f 			       
   WHERE  ( f.fact_g_financiero = :str.g_financiero ) AND  
         ( f.fact_empresa = :str.empresa ) AND  
		 ( convert(datetime, CAST(f.fact_fecha AS DATE), 103) >= convert( datetime, CAST(:ldt_fecha1 AS DATE),103) ) AND
		 ( convert(datetime, CAST(f.fact_fecha AS DATE), 103) <= convert( datetime, CAST(:ldt_fecha2 AS DATE),103) ) AND
		 (f.fact_estado = 'I'); 
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al buscar '+sqlca.sqlerrtext,1,1,'E')
	end if
	
//Venta Mes anterior
   li_mes_anterior = month(date(ldt_fecha1))
   li_mes_anterior = li_mes_anterior - 1
	if li_mes_anterior = 0 then 
		li_mes_anterior = 12
		li_ann --
	end if
	li_dia_final = gf_last_day(li_mes_anterior, li_ann)
	ldt_fecha1_mes_anterior = datetime(date('01/'+string(li_mes_anterior)+'/'+string(li_ann )) , time('00:00:00'))
   ldt_fecha2_mes_anterior = datetime(date(string(li_dia_final)+'/'+string(li_mes_anterior)+'/'+string(li_ann )) , time('00:00:00'))

	 SELECT isnull(SUM(case when f.fact_nota_credito = 1 then f.fact_monto_fact_total * -1 else f.fact_monto_fact_total end ),0) total  
	   into :ld_ventas_mes_anterior
    FROM fatdiari f 			       
   WHERE  ( f.fact_g_financiero = :str.g_financiero ) AND  
         ( f.fact_empresa = :str.empresa ) AND  
		 ( convert(datetime, CAST(f.fact_fecha AS DATE), 103) >= convert( datetime, CAST(:ldt_fecha1_mes_anterior AS DATE),103) ) AND
		 ( convert(datetime, CAST(f.fact_fecha AS DATE), 103) <= convert( datetime, CAST(:ldt_fecha2_mes_anterior AS DATE),103) ) AND
		 (f.fact_estado = 'I'); 
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al buscar mes anterior '+sqlca.sqlerrtext,1,1,'E')
	end if
	
ls_js = "actualizarKPImes(" + string(ld_ventas_mes) + "," + string(ld_ventas_mes_anterior) + " ," + String(ll_facturas) + ")"

// Ejecutar JavaScript en el WebView
wb_dashboard.evaluatejavascriptsync(ls_js)			//Actualiza ventas Mes y ventas Mes Anterior


end subroutine

on w_dashboard.create
if this.MenuName = "m_fa_rep" then this.MenuID = create m_fa_rep
this.pb_recuperar=create pb_recuperar
this.wb_dashboard=create wb_dashboard
this.st_3=create st_3
this.ddlb_vendedor=create ddlb_vendedor
this.st_2=create st_2
this.st_1=create st_1
this.dp_hasta=create dp_hasta
this.dp_desde=create dp_desde
this.Control[]={this.pb_recuperar,&
this.wb_dashboard,&
this.st_3,&
this.ddlb_vendedor,&
this.st_2,&
this.st_1,&
this.dp_hasta,&
this.dp_desde}
end on

on w_dashboard.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_recuperar)
destroy(this.wb_dashboard)
destroy(this.st_3)
destroy(this.ddlb_vendedor)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dp_hasta)
destroy(this.dp_desde)
end on

event open;DataStore lds
long ll_row
string ls_labels
string ls_values
string ls_js
datetime ldt_fecha1, ldt_fecha2
string ls_file

ldt_fecha1 = datetime(date('01/01/'+string(year(date(gf_fecha_serv())))), time('00:00:00'))
ldt_fecha2 = datetime(date(gf_fecha_serv()), time('00:00:00'))
dp_desde.value = ldt_fecha1
dp_hasta.value = ldt_fecha2

ls_file = GetCurrentDirectory() + "\\index_dashboard.html"
wb_dashboard.Navigate(ls_file)

Timer(6000)

end event

event resize;wb_dashboard.height = newheight - 200
wb_dashboard.width = newwidth - 100
end event

event timer;pb_recuperar.triggerevent('clicked')
end event

type wb_dashboard from webbrowser within w_dashboard
integer x = 32
integer y = 128
integer width = 4498
integer height = 2304
end type

event navigationcompleted;//cb_actualizar.triggerevent('clicked')
wf_cargar_dashboard()
end event

event webmessagereceived;String ls_json
str_fa_dw_rep lstr_argumentos
JsonParser lnv_json
Long ll_root
Integer li_ann, li_dia_final
String ls_periodo
Double ld_venta
datetime ldt_fecha1, ldt_fecha2

// JSON recibido
ls_json = webmessage
// Crear parser
lnv_json = CREATE JsonParser
// Cargar JSON
lnv_json.LoadString(ls_json)
// Obtener nodo root
ll_root = lnv_json.GetRootItem()
// Extraer valores
ls_periodo = lnv_json.GetItemString(ll_root, "periodo")
ld_venta = lnv_json.GetItemNumber(ll_root, "venta")
DESTROY lnv_json

li_ann = year(date(dp_desde.value))
choose case ls_periodo
	case 'January', 'Enero'
		ldt_fecha1 = datetime(date('01/01/'+string(li_ann)),time('00:00:00'))
		li_dia_final = gf_last_day(01,li_ann)
		ldt_fecha2 = datetime(date(string(li_dia_final)+'/01/'+string(li_ann)),time('00:00:00'))
	case 'February', 'Febrero'
		ldt_fecha1 = datetime(date('01/02/'+string(li_ann)),time('00:00:00'))
		li_dia_final = gf_last_day(02,li_ann)
		ldt_fecha2 = datetime(date(string(li_dia_final)+'/02/'+string(li_ann)),time('00:00:00'))
	case 'March', 'Marzo'
		ldt_fecha1 = datetime(date('01/03/'+string(li_ann)),time('00:00:00'))
		li_dia_final = gf_last_day(03,li_ann)
		ldt_fecha2 = datetime(date(string(li_dia_final)+'/03/'+string(li_ann)),time('00:00:00'))
   case 'April', 'Abril'
		ldt_fecha1 = datetime(date('01/04/'+string(li_ann)),time('00:00:00'))
		li_dia_final = gf_last_day(04,li_ann)
		ldt_fecha2 = datetime(date(string(li_dia_final)+'/04/'+string(li_ann)),time('00:00:00'))
	case 'May', 'Mayo'
		ldt_fecha1 = datetime(date('01/05/'+string(li_ann)),time('00:00:00'))
		li_dia_final = gf_last_day(05,li_ann)
		ldt_fecha2 = datetime(date(string(li_dia_final)+'/05/'+string(li_ann)),time('00:00:00'))
	case 'June', 'Junio'
		ldt_fecha1 = datetime(date('01/06/'+string(li_ann)),time('00:00:00'))
		li_dia_final = gf_last_day(06,li_ann)
		ldt_fecha2 = datetime(date(string(li_dia_final)+'/06/'+string(li_ann)),time('00:00:00'))		
   case 'July', 'Julio'
		ldt_fecha1 = datetime(date('01/07/'+string(li_ann)),time('00:00:00'))
		li_dia_final = gf_last_day(07,li_ann)
		ldt_fecha2 = datetime(date(string(li_dia_final)+'/07/'+string(li_ann)),time('00:00:00'))
	case 'August', 'Agosto'
		ldt_fecha1 = datetime(date('01/08/'+string(li_ann)),time('00:00:00'))
		li_dia_final = gf_last_day(08,li_ann)
		ldt_fecha2 = datetime(date(string(li_dia_final)+'/08/'+string(li_ann)),time('00:00:00'))
	case 'September', 'Septiembre'
		ldt_fecha1 = datetime(date('01/09/'+string(li_ann)),time('00:00:00'))
		li_dia_final = gf_last_day(09,li_ann)
		ldt_fecha2 = datetime(date(string(li_dia_final)+'/09/'+string(li_ann)),time('00:00:00'))
   case 'October', 'Octubre'
		ldt_fecha1 = datetime(date('01/10/'+string(li_ann)),time('00:00:00'))
		li_dia_final = gf_last_day(10,li_ann)
		ldt_fecha2 = datetime(date(string(li_dia_final)+'/10/'+string(li_ann)),time('00:00:00'))
	case 'November', 'Noviembre'
		ldt_fecha1 = datetime(date('01/11/'+string(li_ann)),time('00:00:00'))
		li_dia_final = gf_last_day(11,li_ann)
		ldt_fecha2 = datetime(date(string(li_dia_final)+'/11/'+string(li_ann)),time('00:00:00'))
	case 'December', 'Diciembre'
		ldt_fecha1 = datetime(date('01/12/'+string(li_ann)),time('00:00:00'))
		li_dia_final = gf_last_day(12,li_ann)
		ldt_fecha2 = datetime(date(string(li_dia_final)+'/12/'+string(li_ann)),time('00:00:00'))				
end choose
lstr_argumentos.fecha_ini = ldt_fecha1
lstr_argumentos.fecha_fin = ldt_fecha2
openwithparm(w_detalle_ventas, lstr_argumentos)

end event

type dp_desde from datepicker within w_dashboard
integer x = 293
integer y = 20
integer width = 535
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2026-05-20"), Time("13:14:58.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

event valuechanged;pb_recuperar.triggerevent('clicked')
end event

type dp_hasta from datepicker within w_dashboard
integer x = 1115
integer y = 16
integer width = 535
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2026-05-20"), Time("13:14:58.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

event valuechanged;pb_recuperar.triggerevent('clicked')
end event

type st_1 from statictext within w_dashboard
integer x = 55
integer y = 36
integer width = 224
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Desde:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_dashboard
integer x = 896
integer y = 36
integer width = 201
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Hasta:"
boolean focusrectangle = false
end type

type ddlb_vendedor from dropdownlistbox within w_dashboard
boolean visible = false
integer x = 2057
integer y = 16
integer width = 640
integer height = 376
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_dashboard
boolean visible = false
integer x = 1755
integer y = 36
integer width = 302
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vendedor:"
boolean focusrectangle = false
end type

type pb_recuperar from picturebutton within w_dashboard
integer x = 1705
integer y = 12
integer width = 123
integer height = 108
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Compile1!"
alignment htextalign = left!
string powertiptext = "Recuperar Informacion..."
end type

event clicked;string ls_file
ls_file = GetCurrentDirectory() + "\\index_dashboard.html"
wb_dashboard.Navigate(ls_file)
end event

