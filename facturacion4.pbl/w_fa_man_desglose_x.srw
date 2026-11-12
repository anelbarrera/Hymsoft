//objectcomments  
forward
global type w_fa_man_desglose_x from window
end type
type dw_2 from datawindow within w_fa_man_desglose_x
end type
type st_1 from statictext within w_fa_man_desglose_x
end type
type st_5 from statictext within w_fa_man_desglose_x
end type
type cb_1 from commandbutton within w_fa_man_desglose_x
end type
type cb_salir from commandbutton within w_fa_man_desglose_x
end type
type st_2 from statictext within w_fa_man_desglose_x
end type
type dw_4 from datawindow within w_fa_man_desglose_x
end type
type dw_3 from datawindow within w_fa_man_desglose_x
end type
type st_3 from statictext within w_fa_man_desglose_x
end type
type st_22 from statictext within w_fa_man_desglose_x
end type
type ole_1 from olecustomcontrol within w_fa_man_desglose_x
end type
type dw_1 from datawindow within w_fa_man_desglose_x
end type
end forward

global type w_fa_man_desglose_x from window
integer x = 133
integer y = 112
integer width = 2702
integer height = 1336
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
event ue_postopen ( )
dw_2 dw_2
st_1 st_1
st_5 st_5
cb_1 cb_1
cb_salir cb_salir
st_2 st_2
dw_4 dw_4
dw_3 dw_3
st_3 st_3
st_22 st_22
ole_1 ole_1
dw_1 dw_1
end type
global w_fa_man_desglose_x w_fa_man_desglose_x

type variables
long il_largos, il_color, il_yy, il_tallas, ia_multiplos[], il_canti, il_fraccion
string ia_largos[], ia_taman[], ia_codigos[], is_col
integer ii_linea
str_fa_desglose str_desglose
boolean lb_cambio = false,lb_salvo
Decimal	id_cantidad, id_disponible
end variables

forward prototypes
public subroutine wf_convert_uni (string as_med, long al_fracciones, ref long al_cantidad, ref long al_fraccion)
public function integer wf_convierte_a_uni_disponibles (datawindow adw_dw, integer ai_row, string as_unidad, long al_asignada, long al_disponible)
public function string wf_find_grupo ()
public function integer wf_proteger_campos ()
public function integer wf_setear_largos ()
public function long wf_convert_min (string as_med, long al_cantidad, long al_fraccion)
public subroutine wf_create_texto ()
public function integer wf_valida_cantidad (datawindow adw_dw1, long al_linea, string as_vienede, string as_cod_color, string as_cod_tama, string as_cod_largo, string as_cod_grupo)
public subroutine wf_scroll_a_disponibles (datawindow aldw_3, string as_cod_color, string as_cod_tama, string as_cod_largo)
public function integer wf_setear_colores ()
public function integer wf_create_dw_lista ()
public function integer wf_guardar ()
public function integer wf_habilitar_existentes ()
public subroutine wf_recuperar ()
public subroutine wf_avance (long inicio, long final)
end prototypes

event ue_postopen;Decimal ld_asignada,ld_reservada,ld_disponible,ld_asignada_reng_actual, ld_dispo_total
long ll_resultado, i, ll_row
String 	ls_expresion,ls_error, ls_status

id_cantidad = str_desglose.cantidad
str_desglose.cantidad =0
str_desglose.cambio = false

dw_1.settransobject(sqlca)
dw_4.settransobject(sqlca)	// Línea de la Lista de Empaque

// dw_3 línea del pedido
if str_desglose.vienede = 'PE' then 
	dw_2.Dataobject = "dw_ma_fa_cant_pedi_packing_disp_esp_det"	   // Total Reservado y disponible
	dw_3.Dataobject = "dw_ma_fa_cant_pedi_packing_disp_especial"	// Reservado de la linea del pedido
else
	dw_3.Dataobject = "dw_ma_fa_cant_fact_packing_disp_especial"		
	dw_2.Dataobject = "dw_ma_fa_cant_fact_packing_disp_esp_det"	
end if

dw_3.settransobject(sqlca)
dw_2.settransobject(sqlca)

If str_desglose.vienede	='FA' then
	ll_row = dw_3.Retrieve(str.g_financiero,str.empresa,str_desglose.pedido,str_desglose.ann,str_desglose.tipo,str_desglose.linea_ori)
	dw_2.Retrieve(str.g_financiero,str.empresa,str_desglose.pedido,str_desglose.ann,str_desglose.tipo)
Else
	ll_row = dw_3.Retrieve(str.g_financiero,str.empresa,str_desglose.pedido,str_desglose.ann,str_desglose.linea_ori)
	dw_2.Retrieve(str.g_financiero,str.empresa,str_desglose.pedido,str_desglose.ann)
End if

If ll_row < 1 then
	messagebox("Atención","No existe detalle de la línea "+string(str_desglose.linea_ori)+' del pedido No. '+str_desglose.pedido)
	dw_3.InsertRow(0)
end if


If dw_2.rowcount() > 0 then

	ls_expresion = "codigo_item = '"+str_desglose.producto+"' and linea = "+string(str_desglose.linea_ori)
	
	ll_row = dw_2.Find(ls_expresion,1,dw_2.Rowcount())
	
	if ll_row > 0 then
		dw_2.Scrolltorow(ll_row)
		//Cantidad disponible  (cant reservada total - dped_cant_asignada  total)
		ld_asignada = dw_2.GetItemNumber(ll_row,"asignada") 
		ld_reservada = dw_2.GetItemNumber(ll_row,"cantidad") 
		ld_dispo_total = dw_2.GetItemNumber(ll_row,"dispo_total") 
	else
		gf_mensaje("","No se ubico el renglon en el pedido ",1,1,"E")
		dw_2.Insertrow(0)
		ld_asignada = 0
		ld_reservada = 0
		ld_dispo_total = 0
	end if
else
	gf_mensaje("","No se recuperó registro del pedido ",1,1,"E")
	dw_2.Insertrow(0)
	ld_asignada = 0
	ld_reservada = 0
	ld_dispo_total = 0
end if

SELECT fadempaq.empa_cantidad
 INTO :ld_asignada_reng_actual
 FROM fadempaq  
WHERE ( fadempaq.empa_g_financiero = :str.g_financiero ) AND  
		( fadempaq.empa_empresa = :str.empresa) AND  
		( fadempaq.empa_lista_empaque = :str_desglose.empaque	 ) AND  
		( fadempaq.empa_ann = :str_desglose.ann_empa ) AND  
		( fadempaq.empa_linea_original = :str_desglose.linea_ori ) AND  
		( fadempaq.empa_linea = :str_desglose.linea )  ;

If SQLCA.sqlcode = -1 then
	ls_error = sqlca.sqlerrText
	mensaje("Atención","Error al leer el yardaje asignado de la linea en (fadempaq) ",ls_error)
	return 
end if			

If IsNull(ld_asignada_reng_actual) then ld_asignada_reng_actual = 0
If IsNull(ld_asignada) then ld_asignada = 0
If IsNull(ld_reservada) then ld_reservada = 0
If IsNull(ld_dispo_total) then ld_dispo_total = 0
//
SELECT fadempaq.empa_status
 INTO :ls_status
 FROM fadempaq  
WHERE ( fadempaq.empa_g_financiero = :str.g_financiero ) AND  
		( fadempaq.empa_empresa = :str.empresa) AND  
		( fadempaq.empa_lista_empaque = :str_desglose.empaque	 ) AND  
		( fadempaq.empa_ann = :str_desglose.ann_empa ) AND  
		( fadempaq.empa_linea_original = :str_desglose.linea_ori ) AND  
		( fadempaq.empa_linea = :str_desglose.linea )  ;

If SQLCA.sqlcode = -1 then
	ls_error = sqlca.sqlerrText
	mensaje("Atención","Error al leer el Status del registro (fadempaq) ",ls_error)
	return 
end if			

/*Valida si el Status es T= trabajado sólo puede modificar las cantidades de los 
rollos, no así el total de yardaje*/
					// Res total  - Asig total  + reserva de la lin L.Emp. - diponible total
If ls_status <>'T' then
//	ld_disponible = (ld_reservada - ld_asignada + ld_asignada_reng_actual - ld_dispo_total)*1.20
	ld_disponible = (ld_reservada - ld_asignada + ld_asignada_reng_actual )*1.20
else
	ld_disponible = (ld_reservada - ld_asignada + ld_asignada_reng_actual)
//	ld_disponible = (ld_reservada - ld_asignada + ld_asignada_reng_actual - ld_dispo_total)
end if

id_disponible = ld_disponible

/* El 20% adicional es la holgura permitida por efecto de que el yardaje 
	de los rollos de tela*/
il_color = 1	
IF ld_disponible <= 200 THEN
	il_color = 1
ELSEIF ld_disponible >= 200 and ld_disponible <= 400 THEN
	il_color = 2
ELSEIF ld_disponible >= 400 and ld_disponible <= 600 THEN
	il_color = 3
ELSEIF ld_disponible >= 600 and ld_disponible <= 800 then
	il_color = 4
ELSEIF ld_disponible >= 800 and ld_disponible <= 1000 then
	il_color = 5
ELSEIF ld_disponible >= 1000 and ld_disponible <= 1200 then
	il_color = 6
ELSEIF ld_disponible >= 1200 and ld_disponible <= 1400 then
	il_color = 7
ELSEIF ld_disponible >= 1400 and ld_disponible <= 1600 then
	il_color = 8
ELSEIF ld_disponible >= 1600 and ld_disponible <= 1800 then
	il_color = 9
ELSEIF ld_disponible >= 1800 and ld_disponible <= 2000 then
	il_color = 10
ELSEIF ld_disponible >= 2000 and ld_disponible <= 2200 then
	il_color = 11
ELSEIF ld_disponible >= 2200 and ld_disponible <= 2400 then
	il_color = 12
ELSEIF ld_disponible >= 2400 and ld_disponible <= 2600 then
	il_color = 13
ELSEIF ld_disponible >= 2600 and ld_disponible <= 2800 then
	il_color = 14
ELSEIF ld_disponible >= 2800 and ld_disponible <= 3000 then
	il_color = 15
ELSEIF ld_disponible >= 3000 and ld_disponible <= 3200 then
	il_color = 16
ELSEIF ld_disponible >= 3200 and ld_disponible <= 3400 then
	il_color = 17
ELSEIF ld_disponible >= 3400 and ld_disponible <= 3600 then
	il_color = 18
ELSEIF ld_disponible >= 3600 and ld_disponible <= 3800 then
	il_color = 19
ELSEIF ld_disponible >= 3800 and ld_disponible <= 4000 then
	il_color = 20
ELSEIF ld_disponible >= 4000 and ld_disponible <= 4200 then
	il_color = 21
ELSEIF ld_disponible >= 4200 and ld_disponible <= 4400 then
	il_color = 22
ELSEIF ld_disponible >= 4400 and ld_disponible <= 4600 then
	il_color = 23
ELSEIF ld_disponible >= 4600  then
	il_color = 30
END IF


// Recupera la línea
If dw_4.Retrieve(str.g_financiero,str.empresa,str_desglose.empaque,str_desglose.ann_empa,str_desglose.linea)< 1 then
	ll_row=dw_4.Insertrow(0)
	dw_4.setitem(ll_row,"fade_g_financiero",str.g_financiero)
	dw_4.setitem(ll_row,"fade_empresa",str.empresa)
	
	dw_4.setitem(ll_row,"fade_lista_empaque",str_desglose.empaque)
	dw_4.setitem(ll_row,"fade_ann",str_desglose.ann_empa)
	dw_4.setitem(ll_row,"fade_linea_refer",str_desglose.linea)
	dw_4.setitem(ll_row,"fade_linea",ll_row)
	dw_4.setitem(ll_row,"fade_no_pedido",str_desglose.pedido)
	dw_4.setitem(ll_row,"fade_ann_pedido",str_desglose.ann)
	dw_4.setitem(ll_row,"fade_tipo",str_desglose.tipo)
	dw_4.setitem(ll_row,"fade_grupo_tam",'01')
	dw_4.setitem(ll_row,"fade_color",'01')
	dw_4.setitem(ll_row,"fade_cantidad",0)
	dw_1.insertRow(0)
End if

this.title = str_desglose.titulo

If wf_create_dw_lista() = 0 then Return

/*Carga las cantidades recuperadas al datawindow de captura */
If dw_4.rowcount() > 0 then
	wf_recuperar()
End if

end event

public subroutine wf_convert_uni (string as_med, long al_fracciones, ref long al_cantidad, ref long al_fraccion);/*Esta Función Convierte de Unidad Minima a la Unidad que se Quiere*/
//Llamada desde: wf_habilita_existentes()

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

public function integer wf_convierte_a_uni_disponibles (datawindow adw_dw, integer ai_row, string as_unidad, long al_asignada, long al_disponible);//Para mostrar lo Asignado y lo disponible en Cantidad Fraccion
//Llamado desde: wf_valida_cantidad()
//
//Long  ll_cant_asig=0, ll_frac_asig=0, ll_cant_disp=0, ll_frac_disp=0
//	wf_convert_uni(as_unidad,al_asignada,ll_cant_asig, ll_frac_asig) //Conv. lo Asignado
//	adw_dw.Setitem(ai_row,"cant_asig",ll_cant_asig)	
//	adw_dw.Setitem(ai_row,"frac_asig",ll_frac_asig)	
//	wf_convert_uni(as_unidad,al_disponible,ll_cant_disp, ll_frac_disp)//Conv. lo Disponible
//	adw_dw.Setitem(ai_row,"cant_disp",ll_cant_disp)	
//	adw_dw.Setitem(ai_row,"frac_disp",ll_frac_disp)			

return 1
end function

public function string wf_find_grupo ();string ls_cod_grupo = '', ls_expresion
long   ll_row

ls_expresion = "linea = "+string(ii_linea)

//ll_row	=	dw_2.Find(ls_expresion,1,dw_2.Rowcount())

if ll_row > 0 then
//	ls_cod_grupo = dw_2.Getitemstring(ll_row,"grupo_tam")
end if

return ls_cod_grupo
end function

public function integer wf_proteger_campos ();string ls_column_name
integer i, j, k=0, li_columns

li_columns = Integer(dw_1.Describe("DataWindow.Column.Count"))
	
for i = 1 to dw_1.Rowcount()		
	k = 0
	for j = 3 to li_columns
		ls_column_name = dw_1.Describe("#" + string(j) + ".Name")  //RECUPERA EL NOMBRE DE LA COLUMNA	
		if mid(ls_column_name,1,1)	= 'f' then
			k ++
			dw_1.Setitem(i,"p"+string(k),1)
		end if
	next
next

return 1
end function

public function integer wf_setear_largos ();
integer d = 0,i
String ls_cod_tama

for i = 1 to 10
	ls_cod_tama		=	string(i,"00")
	ia_largos[i]   =  ls_cod_tama
next 

return 1
end function

public function long wf_convert_min (string as_med, long al_cantidad, long al_fraccion);/*Esta función recibe la cantidad y fracción y retorna todo convertido a fracción*/
//Llamada desde: retrieveend del DW 4, wf_validar_cantidad()

Long ll_ucom, ld_mconvera, ll_total

/*Extrae la Unidad comun "Pedo/Unidades/etc "*/
ll_ucom = gf_medi_prod(as_med)

/*Retorna el Factor de Converción a unidades minimas*/
ld_mconvera = gf_unidad_venta(as_med, ll_ucom)

If ld_mconvera <= 0 Then ld_mconvera = 1

ll_total = (al_cantidad * ld_mconvera) + al_fraccion

Return (ll_total)
end function

public subroutine wf_create_texto ();string ls_textos, ls_resultado = "", ls_text = "", ls_font = ''
long   ll_y = 20, ll_x = 250, ll_width = 231, i=1, ll_ancho=0, ll_cant_largos, ll_multiplo, &
		 ll_total_tallas, ll_sesgo = 0

ll_total_tallas = il_tallas

ll_cant_largos = il_largos

// Ancho de los Largos "231"

	if w_fa_fondo.str_para.titulo_abreviado = 1 then
		ls_font = " font.height='-8' "
	else
		ls_font = " font.height='-7' "
	end if

for i = 1 to ll_total_tallas	
	
	//Para que el Texto de los Tamaños, cuadren con los de los Cargos
	choose case ia_multiplos[i] 
		case	1
			ll_sesgo = 1			
		case	2
			ll_sesgo = 15 * ia_multiplos[i]
		case  3
			ll_sesgo = 16 * ia_multiplos[i] 
		case	4
			ll_sesgo = 17 * ia_multiplos[i] 			
		case	4
			ll_sesgo = 19 * ia_multiplos[i] 			
		case else	
			ll_sesgo = 21 * ia_multiplos[i] 			
	end choose
	
	ll_ancho = ll_width * ia_multiplos[i] + ll_sesgo
	ls_textos += " create text (band=header alignment='2' text='"+ia_taman[i]+"' border='6' color='0' x='"+string(ll_x)+"' y='"+string(ll_y)+"' height='56' width='"+string(ll_ancho)+"'  font.face='Arial' "+ls_font+" font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='553648127') "
	ll_x +=	ll_ancho + 21

next	

ls_resultado = dw_1.Modify(ls_textos)

if ls_resultado <> "" then
	messagebox("Error al crear textos",ls_resultado)
end if
end subroutine

public function integer wf_valida_cantidad (datawindow adw_dw1, long al_linea, string as_vienede, string as_cod_color, string as_cod_tama, string as_cod_largo, string as_cod_grupo);return 1
end function

public subroutine wf_scroll_a_disponibles (datawindow aldw_3, string as_cod_color, string as_cod_tama, string as_cod_largo);//
end subroutine

public function integer wf_setear_colores ();integer  i,j=0,li_columna =0
string	ls_producto, ls_color, ls_cod_color, ls_expresion
Long		ll_row

for i = 1 to il_color
	ls_cod_color	=  string(i,'00') 
	ls_color			=  string(i,'00')
	ls_expresion	=	"acol_num_color = '"+ls_cod_color+"'"
	
	ll_row			= dw_1.Find(ls_expresion,1,dw_1.rowcount())
	
	if ll_row = 0 then
		j ++
		ll_row = dw_1.InsertRow(0)
		dw_1.Setitem(i,"acol_num_color",ls_cod_color)
		dw_1.Setitem(i,"color",ls_color)
		
	end if
Next
return 1
end function

public function integer wf_create_dw_lista ();long		ll_y = 7, ll_x = 300, ll_x_texto = 152, ll_width = 133, ll_band_detail = 600, &
			ll_contador=0, ll_inicial[], ll_resp_x, ll_resp_y, ll_resp_i
string	ls_column_name, ls_dw_propiedades, is_sql, ls_syntaxis, ls_err, ls_describe, &
			ls_format, ls_editmask, ls_resultado='', la_inicial[], ls_suma_c, ls_suma_f
integer	li_columns, li_i, li_height, li_height_max, i, j=0
boolean	lb_height

// Inicialización de los arreglos utilizados

ia_largos[]    = la_inicial[]
ia_taman[]	   = la_inicial[]
ia_codigos[]   = la_inicial[]
ia_multiplos[] = ll_inicial[]

//Para Setear los Textos de los Largos en el arreglo
wf_setear_largos()

il_largos = UpperBound(ia_largos)
il_tallas = UpperBound(ia_taman)

// Gianni Araúz (04/04/2000)
// Si il_largos = 0 no se debe colocar la coma(,) después de la columna "color"
if il_largos > 0 then
	is_sql = " SELECT acol_num_color, '                    ' color, " // Nombre del color de 20
else
	is_sql = " SELECT acol_num_color, '                    ' color " // Nombre del color de 20
end if
// Fin Gianni

for i = 1 to il_largos // Crea tres computes, por cada largo (Cantidad, Fracción y Protegido)
	if i > 1 then is_sql += ", "										 
	is_sql += "0  p"+string(i)+", "		 // Campo que identifica si el Campo de Cant. y Frac.
													 // estará protegido o no
	is_sql += "0  c"+string(i)+", "						 
	is_sql += "0  f"+string(i)+", "		 
	is_sql += "'        '  tcodigo"+string(i)
	
next

is_sql = is_sql +" FROM cracolor  "

ls_syntaxis = SQLCA.SyntaxFromSQL(is_sql, "style(type=Tabular) datawindow(color = 79416533) ", ls_err)

/* Re-ubica las columnas antes de crear el data windows ( -1- ) */

ll_resp_i = 1

DO WHILE ll_resp_i <> 0  // Ciclo para asignar las x = 0 en las columnas del dw a crear */
	ll_resp_x = pos(ls_syntaxis,'x=',ll_resp_i)
	if ll_resp_x <> 0 then
		ll_resp_y = pos(upper(ls_syntaxis),'Y=',ll_resp_x)
		ls_syntaxis = replace(ls_syntaxis,ll_resp_x+3,ll_resp_y - 4 - ll_resp_x,'0"')
	end if
	if ll_resp_x > 0 then 
		ll_resp_i = ll_resp_x + 10
	else 
		ll_resp_i = 0
	end if

LOOP

for i = 1 to il_largos // * Crea los totales por columna para el desglose de productos 

	if i = 1 then 
		ls_suma_c = 'c'+string(i)        
		ls_suma_f = 'f'+string(i)
	else 
		ls_suma_c += '+c'+string(i)        
		ls_suma_f += '+f'+string(i)
	end if 
	ls_syntaxis = ls_syntaxis + &
	' compute(band=footer alignment="1" expression="sum(c'+string(i)+' for all)"border="5" color="0" x="0" y="12" height="48" width="133" format="[general]"  name=sc' +string(i) + '  font.face="Arial" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="16777215" )'
	ls_syntaxis = ls_syntaxis + &
	' compute(band=footer alignment="1" expression="sum(f'+string(i)+' for all)"border="5" color="0" x="0" y="12" height="48" width="133" format="[general]"  name=sf' +string(i) + '  font.face="Arial" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="16777215" )'
next

/* Crea el total por línea para colores en el desglose de productos */

ls_syntaxis = ls_syntaxis + &
' compute(band=detail alignment="1" expression=" '+ls_suma_c+' "border="5" color="0" x="0" y="8" height="48" width="133" format="[general]"  name=Total_c  font.face="Arial" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="16777215" )'	

ls_syntaxis = ls_syntaxis + &			
' compute(band=detail alignment="1" expression=" '+ls_suma_f+' "border="5" color="0" x="0" y="8" height="48" width="133" format="[general]"  name=Total_f font.face="Arial" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="16777215" )'	

ls_syntaxis = ls_syntaxis + &			
' compute(band=footer alignment="1" expression=" sum(total_c for all) "border="5" color="0" x="0" y="20" height="48" width="133" format="[general]"  name=STotal_c font.face="Arial" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="16777215" )'	

ls_syntaxis = ls_syntaxis + &			
' compute(band=footer alignment="1" expression=" sum(total_f for all) "border="5" color="0" x="0" y="20" height="48" width="133" format="[general]"  name=STotal_f font.face="Arial" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="16777215" )'					

ls_syntaxis = ls_syntaxis + &
'rectangle(band=footer x="5" y="0" height="8" width="11" name=linea1 brush.hatch="6" '+ & 
'brush.color="0" pen.style="0" pen.width="5" pen.color="0"  background.mode="2" background.color="0" )'

ls_syntaxis = ls_syntaxis + &
'rectangle(band=footer x="5" y="0" height="8" width="11" name=linea2 brush.hatch="6" '+ & 
'brush.color="0" pen.style="0" pen.width="5" pen.color="0"  background.mode="2" background.color="0" )'

ls_syntaxis = ls_syntaxis + &
'text(band=footer alignment="0" text="T O T A L "border="0" color="0" x="15" y="20" ' + & 
'height="48" width="274"  name=texto  font.face="Arial" font.height="-8" ' + & 
'font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2"'+ &
'background.color=" 79416533" )'

ls_syntaxis = ls_syntaxis + &
'text(band=header alignment="0" text="T O T A L"border="0" color="0" x="7" y="52"'+ & 
' height="56" width="200"  name=t_total  font.face="Arial" font.height="-8" '+ & 
'font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.' + & 
'mode="1" background.color="553648127" )'

ls_syntaxis = ls_syntaxis + &
'text(band=header alignment="0" text=""border="6" color="0" x="7" y="15"'+ & 
' height="90" width="200"  name=t_total_m  font.face="Arial" font.height="-8" '+ & 
'font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.' + & 
'mode="1" background.color="553648127" )'

If Len(ls_err) > 0 Then 
	dw_1.SetRedraw(True)	
	messagebox("Error",ls_err)
	Return 0
End If

dw_1.Create(ls_syntaxis, ls_err)		//CREA EL DW 

If Len(ls_err) > 0 Then 
	dw_1.SetRedraw(True)	
	messagebox("Error",ls_err)
	Return 0
End If

ls_resultado += dw_1.Modify("DataWindow.Detail.Height.AutoSize=Yes")

if ls_resultado <> "" then
	messagebox("Error en el Modify ","Error al Incrementar la Banda del Detalle "+dw_1.Modify("DataWindow.Detail.Height='"+string(ll_band_detail)+"'"))
	Return 0
end if

li_columns = Integer(dw_1.Describe("DataWindow.Column.Count"))


if IsNull(li_columns) or li_columns = 0 then li_columns = 1

ole_1.object.value = 0

FOR li_i = 1 TO li_columns

	wf_avance(li_i,li_columns)
	
		str.frame.Setmicrohelp("Procesando la Configuración de la Columna "+string(li_i))
		
		ls_column_name = dw_1.Describe("#" + string(li_i) + ".Name")  //RECUPERA EL NOMBRE DE LA COLUMNA
		if li_i < 3 then
			if li_i = 2 then
				//Texto
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.Font.Weight=700 "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.width='150' "	
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.height='90' "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.border='6' "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.background.color='553648127' "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.x='50' "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.y='15' "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.Text='~LIN' "
				//Edit
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".Border='5~tif( getrow() = currentRow(),6,5) ' "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".background.Mode='2' "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".background.color='16777215~tif( getrow() = currentRow(), rgb(0,0,128), rgb(255,255,255)) ' "
		      ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".color='0~tif(getrow() = currentRow(),rgb(255,255,255),rgb(0,0,128) )' "											
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".TabSequence= "+string(li_i)+" "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".height='48' "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".width='150' "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".x='50' "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".y='8' "		
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".alignment='0' "	
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".edit.displayonly= Yes "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".edit.autohscroll=Yes "		
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".edit.focusrectangle=No "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".font.weight='700' "
			else
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.visible='0' "	//Texto
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".visible='0' "	//Edit del Codigo de Color
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".x='20' "	//Para que no se vea el scroll horizontal tan grande
																								//ya que aunque esten ocultos, hacen el espacio							
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.x='20' "
			end if
			continue
		end if
				
		if mid(ls_column_name,1,1) = "f" then		//Si es un campo de Fraccion
			ll_x += 138				// Separación entre la cantidad y la fraccion
			ll_width = 85
			ll_width = 0
			ls_format = '##0'
			ls_editmask = '###'
		elseif mid(ls_column_name,1,1) = "c" then	//Si es un campo de Cantidad
			ls_format = '#####0'
			ls_editmask = '######'
			ll_x += 40 //115				//Separacion entre la fraccion y la siguiente Cantidad
			ll_width = 133
			ll_width += 42 //85
			
		elseif mid(ls_column_name,1,1) = "p" or mid(ls_column_name,1,1) = "t" then //or ls_column_name = 'yy' then	 //Si es un campo de Proteccion
			ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".visible='0' "   //Campo
			ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".x='20' "	//Para que no se vea el scroll horizontal tan grande
																								//ya que aunque esten ocultos, hacen el espacio						
			ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.visible='0' "	//Texto
			ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.x='20' "	//Para que no se vea el scroll horizontal tan grande
																								//ya que aunque esten ocultos, hacen el espacio			
			//ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".protect='1' "	//Protegido
			continue	//Para que pase a la siguiente iteraccion y no siga abajo
		end if
		
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".Border='5~tif( getrow() = currentRow(),6,5) ' "
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".background.Mode='2' "
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".background.color='16777215~tif( getrow() = currentRow(),if(p"+mid(ls_column_name,2)+"=1,rgb(214,214,214) , rgb(0,0,128)), if( p"+mid(ls_column_name,2)+" = 1,rgb(214,214,214),  rgb(255,255,255))) ' "
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".TabSequence= "+string(li_i)+" "
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".height='48' "
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".width='"+string(ll_width)+"' "
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".x='"+string(ll_x)+"' "
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".y='8' "		
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".alignment='1' "
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".format= '"+ls_format+"' "
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".editmask.mask='"+ls_editmask+"' "
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".font.height='-8' "  //Tamaño del Font
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".font.weight='400' " //Normal 700=Negrita
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".font.pitch='2' "
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".font.family='2' "
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".font.italic='0' "
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".font.face='Arial' "
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".font.charset='0' "
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".editmask.focusrectangle=yes "		
      ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".color='0~tif(getrow() = currentRow(),rgb(255,255,255),rgb(0,0,128) )' "			
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".protect='0~tif(p"+mid(ls_column_name,2)+" = 1,1,0)' "
		if left(ls_column_name,1) = 'c' then 
			ls_dw_propiedades = ls_dw_propiedades + 's'+ls_column_name + ".x='"+string(ll_x)+"' "
			ls_dw_propiedades = ls_dw_propiedades + 's'+ls_column_name + ".width='"+string(ll_width)+"' "			
			ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".initial='0'"
			ls_dw_propiedades = ls_dw_propiedades + 's'+ls_column_name+".format= '"+ls_editmask+"' "
			ls_dw_propiedades = ls_dw_propiedades + 's'+ls_column_name + ".y='20' "					
		end if
		if left(ls_column_name,1) = 'f' then 
			ls_dw_propiedades = ls_dw_propiedades + 's'+ls_column_name + ".x='"+string(ll_x)+"' "
			ls_dw_propiedades = ls_dw_propiedades + 's'+ls_column_name + ".width='"+string(ll_width)+"' "
			ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".initial='0'"
			ls_dw_propiedades = ls_dw_propiedades + 's'+ls_column_name+".format= '"+ls_editmask+"' "			
			ls_dw_propiedades = ls_dw_propiedades + 's'+ls_column_name + ".y='20' "								
		end if

	if mid(ls_column_name,1,1)	= 'c' then
		ll_x_texto += 180 //253
		j ++		//Indice para extraer del arreglo		
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.font.height='-8' "
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.Font.Weight=700 " //Negrita			
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.width='164' "		
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.border='6' "
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.x='"+string(ll_x_texto)+"' "		
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.y='90' "								
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.Text='"+ia_largos[j]+"' "
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.background.color='553648127' "
// solo para verificar si pone invisible los textos de largos
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.visible='0' "	
	else
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.visible='0' "	
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.x='20' "	//Para que no se vea el scroll horizontal tan grande
	end if																							//ya que aunque esten ocultos, hacen el espacio

NEXT

/* Adición 24/08/99 */

/* Establece la posicion y el formato para el total de una fila (Cantidad entera) */
ls_format = '######'
ll_x += 115				
ll_width = 150	+85	
//ll_width += 85
ls_dw_propiedades = ls_dw_propiedades + "Total_c.x='"+string(ll_x)+"' "
ls_dw_propiedades = ls_dw_propiedades + "Total_c.width='"+string(ll_width)+"' "
ls_dw_propiedades = ls_dw_propiedades + "Total_c.format= '"+ls_format+"' "

/* Ubica el titulo para totales por linea */
ls_dw_propiedades = ls_dw_propiedades + "T_Total.x='"+string(ll_x+20)+"' "
ls_dw_propiedades = ls_dw_propiedades + "T_Total_m.x='"+string(ll_x)+"' "
ls_dw_propiedades = ls_dw_propiedades + "T_Total_m.width='"+string(235)+"' "

/* Establece la posicion y el formato para el total del pie de pagina para 
	la Columna de Total por fila */
ls_dw_propiedades = ls_dw_propiedades + "STotal_c.x='"+string(ll_x)+"' "
ls_dw_propiedades = ls_dw_propiedades + "STotal_c.width='"+string(ll_width)+"' "
ls_dw_propiedades = ls_dw_propiedades + "STotal_c.format= '"+ls_format+"' "

/* Establece la posicion y el formato para el total de una fila (Cantidad Fraccion)*/
ll_x += 158				// Separación entre la cantidad y la fraccion
//ll_width = 85
ll_width = 0

ls_dw_propiedades = ls_dw_propiedades + "Total_f.x='"+string(ll_x)+"' "
ls_dw_propiedades = ls_dw_propiedades + "Total_f.width='"+string(ll_width)+"' "
ls_dw_propiedades = ls_dw_propiedades + "Total_f.format= '"+ls_format+"' "
/* Establece la posicion y el formato para el total del pie de pagina para 
	la Columna de Total por fila (Fraccion)*/			
ls_dw_propiedades = ls_dw_propiedades + "STotal_f.x='"+string(ll_x)+"' "
ls_dw_propiedades = ls_dw_propiedades + "STotal_f.width='"+string(ll_width)+"' "
ls_dw_propiedades = ls_dw_propiedades + "STotal_f.format= '"+ls_format+"' "

/* Líneas de División entre el detalle y el Total */
ls_dw_propiedades = ls_dw_propiedades + "Linea1.width='"+string(ll_x+ll_width+0.219)+"' "
ls_dw_propiedades = ls_dw_propiedades + "Linea2.width='"+string(ll_x+ll_width+0.219)+"' "
ls_dw_propiedades = ls_dw_propiedades + "Linea2.y='82' "

/* El campo de color le quita el tab order */
ls_dw_propiedades = ls_dw_propiedades + "color.TabSequence= 0 "
/* */

str.frame.Setmicrohelp("")
	
ls_resultado= dw_1.Modify(ls_dw_propiedades) 

if ls_resultado <> "" then
	messagebox("Error al Personalizar el DW",ls_resultado)
	Return 0
end if

// Agrandar el tamaño del Header
dw_1.Modify("DataWindow.Header.Height='152'")
dw_1.Modify("DataWindow.Footer.Height='94'")
dw_1.Modify("DataWindow.detail.Height='68'")

wf_create_texto()

//Para setear los colores e Insertar la Cantidad de Colores
wf_setear_colores()

wf_habilitar_existentes()

dw_1.Setfocus()

// Ubica la Ventana en el Centro
gf_center_win(this)

this.show()
return 1
end function

public function integer wf_guardar ();//Para Guardar los Cambios en Fademdes
//Llamada desde: ue_keydown()

string  ls_cod_color, ls_campo, ls_cod_tama, ls_codigo, &
		  ls_column_name, ls_expresion, ls_unidad
integer i, j, k=0, li_columns, li_pos, li_pos2=1, li_resultado
Long    ll_row, ll_fila, ll_rows
Decimal	ld_cantidad

li_columns = Integer(dw_1.Describe("DataWindow.Column.Count"))

lb_salvo  = false

str_desglose.cantidad =0

ll_rows = dw_1.Rowcount()

ole_1.object.value = 0

for i = 1 to dw_1.Rowcount()

	wf_avance(i,ll_rows)
	
	str.frame.Setmicrohelp("Guardando fila No. "+string(i))
	
		k = 0
		for j = 3 to li_columns
			ls_column_name = dw_1.Describe("#" + string(j) + ".Name")  //RECUPERA EL NOMBRE DE LA COLUMNA
			if mid(ls_column_name,1,1)	= 'f' then
				k ++
	
				//si el campo esta protegido, que siga con el siguiente
				if dw_1.getitemNumber(i,"p"+string(k)) = 1 then continue
	
				//Extrae la Cantidad y Fraccion Para Guardarla
				ld_cantidad 	= dw_1.Getitemnumber(i,"c"+string(k))
			
				ls_codigo = dw_1.Getitemstring(i,"tcodigo"+string(k))
				
				li_pos	 = pos(ls_codigo," ",1)
				li_pos2	 = li_pos
				li_pos	 = pos(ls_codigo," ",li_pos2 + 1)
				//Extrae el codigo del color
				ls_cod_color = mid(ls_codigo,li_pos2 + 1, li_pos - li_pos2 - 1 )
	
				li_pos2   = li_pos
				li_pos	 = pos(ls_codigo," ",li_pos2 + 1)
				//Extrae el codigo del tamaño
				ls_cod_tama = mid(ls_codigo,li_pos2 + 1, li_pos - li_pos2 - 1 )
	
				li_pos2   = li_pos
				li_pos	 = pos(ls_codigo," ",li_pos2 + 1)
				
				ls_expresion = "fade_color = '"+ls_cod_color+"' and fade_grupo_tam = '"+ls_cod_tama+"'"
				
				ll_row = dw_4.Find(ls_expresion,1,dw_4.Rowcount())
				
				str_desglose.cantidad =str_desglose.cantidad + ld_cantidad
	
				if ll_row > 0 then
					dw_4.Scrolltorow(ll_row)
					//Afectar la Cantidad
					dw_4.setitem(ll_row,"fade_cantidad",ld_cantidad)
				else
					ll_fila = dw_4.insertrow(0)
					dw_4.scrolltorow(ll_fila)

					//gf_setea_grupo_empresa(dw_4,"fade")  //setea el grupo y empresa
					dw_4.setitem(ll_fila,"fade_g_financiero",str.g_financiero)
					dw_4.setitem(ll_fila,"fade_empresa",str.empresa)
					
					dw_4.setitem(ll_fila,"fade_lista_empaque",str_desglose.empaque)
					dw_4.setitem(ll_fila,"fade_ann",str_desglose.ann_empa)
					dw_4.setitem(ll_fila,"fade_linea_refer",str_desglose.linea)
					dw_4.setitem(ll_fila,"fade_linea",ll_fila)

					dw_4.setitem(ll_fila,"fade_no_pedido",str_desglose.pedido)
					dw_4.setitem(ll_fila,"fade_ann_pedido",str_desglose.ann)
					dw_4.setitem(ll_fila,"fade_tipo",str_desglose.tipo)
					dw_4.setitem(ll_fila,"fade_grupo_tam",ls_cod_tama)
					dw_4.setitem(ll_fila,"fade_color",ls_cod_color)
					dw_4.setitem(ll_fila,"fade_cantidad",ld_cantidad)
					
				end if						
				
			end if
		next
	next
	
	ll_row =0
	For i =1 to dw_4.rowcount()
		ld_cantidad = dw_4.GetitemNumber(i,"fade_cantidad")
		If IsNull(ld_cantidad) or ld_cantidad =0 then
			dw_4.Deleterow(i)
			i --
		else
			ll_row ++
		   dw_4.SetItem(ll_row,"fade_linea",ll_row)
		end if
	Next
	str.frame.Setmicrohelp("")
	
	ll_fila = dw_4.update()
	
	lb_cambio = false
	
	If ll_fila = 1 then
		commit ;
		dw_4.Retrieve(str.g_financiero,str.empresa,str_desglose.empaque,str_desglose.ann_empa,str_desglose.linea)
		gf_mensaje("","Actualización Exitosa",1,1,"E")
		lb_salvo  = true
	else
		lb_salvo  = false
	
		If ll_fila = -1 then
			rollback ;
			gf_mensaje("","Error al Actualizar "+sqlca.sqlerrtext,1,1,"E")
			return -1
		end if
	end if

return 0
end function

public function integer wf_habilitar_existentes ();//Función en la que se habilitan los campos que existen en el DW2 
//Y se setean los valores al codigo y cantidades
//Llamada desde wf_create_dw_lista()
integer i, j, li_pos = 0, li_pos2 = 1
string  ls_cod_color, ls_cod_color2, ls_num_largo, ls_cod_tama
long	  ll_cantidad

ole_1.object.value = 0

If IsNull(il_color) or il_color = 0 then il_color =1

for i = 1 to il_color

	wf_avance(i,il_color)
	
	str.frame.Setmicrohelp("Creando la columnas No. "+string(i))
	
    ls_cod_color	=	string(i,"00")
	 for j = 1 to 10
		
	/**/
		ls_cod_tama		=	string(j,"00")
		ia_largos[j]   =  ls_cod_tama
		ia_codigos[j]	=	string(ll_cantidad)+" "+ls_cod_color+" "+ls_cod_tama +' '+string(j)
	/**/
		
		  li_pos2 = 1
		  li_pos  = pos(ia_codigos[j]," ",li_pos2)		  		
		  li_pos2 = li_pos		  
		  li_pos = pos(ia_codigos[j]," ",li_pos2 + 1)
		  ls_cod_color2 = mid(ia_codigos[j],li_pos2+1,li_pos - li_pos2 - 1)
		  
		  if ls_cod_color = ls_cod_color2 then
			  li_pos2 = 1
			  li_pos = pos(ia_codigos[j]," ",li_pos2)
			  do while li_pos > 0
				  li_pos2= li_pos				
				  li_pos = pos(ia_codigos[j]," ",li_pos2+1)
			  loop
			  //Extrae el numero de la casilla o largo
			  ls_num_largo = mid(ia_codigos[j],li_pos2+1)			  
			  
			  dw_1.Setitem(i,"p"+ls_num_largo,0)
			  dw_1.Setitem(i,"tcodigo"+ls_num_largo,ia_codigos[j])
			  ll_cantidad  = long(left(ia_codigos[j],pos(ia_codigos[j]," ")-1))
			  dw_1.Setitem(i,"c"+ls_num_largo,ll_cantidad)
 		  end if
	 next
next
str.frame.Setmicrohelp("")

return 1
end function

public subroutine wf_recuperar ();//Para Recuperar os Cambios en 

string  ls_cod_color,  ls_cod_tama,  ls_codigo, &
		  ls_column_name, ls_expresion
integer i, j, k=0, li_columns, li_pos, li_pos2=1
Long    ll_row, ll_fila
Decimal	ld_cantidad

dw_1.accepttext()
ll_row = dw_1.Rowcount()
li_columns = Integer(dw_1.Describe("DataWindow.Column.Count"))
ole_1.object.value = 0

If IsNull(ll_row) or ll_row <= 0 then return

for i = 1 to dw_1.Rowcount()

	wf_avance(i,ll_row)
	
	str.frame.Setmicrohelp("Recuperando fila No. "+string(i))
	k = 0
	for j = 3 to li_columns
		
		ls_column_name = dw_1.Describe("#" + string(j) + ".Name")  
		//RECUPERA EL NOMBRE DE LA COLUMNA
		
		if mid(ls_column_name,1,1)	= 'f' then
			k ++

			//si el campo esta protegido, que siga con el siguiente
			if dw_1.getitemNumber(i,"p"+string(k)) = 1 then continue

			ls_codigo = '  '
			ls_codigo = dw_1.Getitemstring(i,"tcodigo"+string(k))
			if IsNull(ls_codigo) then
				dw_1.setitem(i,"p"+string(k),1)
			end If
		   dw_1.Setitem(i,"c"+string(k),0)
		   dw_1.Setitem(i,"f"+string(k),0)
			
			li_pos	 = pos(ls_codigo," ",1)
			li_pos2	 = li_pos
			li_pos	 = pos(ls_codigo," ",li_pos2 + 1)
			//Extrae el codigo del color
			ls_cod_color = mid(ls_codigo,li_pos2 + 1, li_pos - li_pos2 - 1 )
			
			li_pos2   = li_pos
			li_pos	 = pos(ls_codigo," ",li_pos2 + 1)
			//Extrae el codigo del tamaño
			ls_cod_tama = mid(ls_codigo,li_pos2 + 1, li_pos - li_pos2 - 1 )
			
			//Se extrae el codigo de grupo, del dw2
			
			ls_expresion = "fade_color = '"+ls_cod_color+"' and fade_grupo_tam = '"+ls_cod_tama+"'"
         
			ll_row = dw_4.Find(ls_expresion,1,dw_4.Rowcount())

	
			if ll_row > 0 then
				dw_4.Scrolltorow(ll_row)
				//Toma la cantidad recuperada para setearla al datawindow de captura (dw_1)
				ld_cantidad = dw_4.getitemnumber(ll_row,"fade_cantidad")

				If IsNull(ld_cantidad) then ld_cantidad =0

				dw_1.setitem(i,"c"+string(k),ld_cantidad)
			End if
		end if
	next
next
ole_1.object.value = 0
str.frame.Setmicrohelp(" ")

end subroutine

public subroutine wf_avance (long inicio, long final);// Marca el Avance en la barra
if isNull(inicio) then inicio = 1
if isNull(final) or final=0 then final = 1
ole_1.Object.Value = (inicio / final) * 100

end subroutine

on w_fa_man_desglose_x.create
this.dw_2=create dw_2
this.st_1=create st_1
this.st_5=create st_5
this.cb_1=create cb_1
this.cb_salir=create cb_salir
this.st_2=create st_2
this.dw_4=create dw_4
this.dw_3=create dw_3
this.st_3=create st_3
this.st_22=create st_22
this.ole_1=create ole_1
this.dw_1=create dw_1
this.Control[]={this.dw_2,&
this.st_1,&
this.st_5,&
this.cb_1,&
this.cb_salir,&
this.st_2,&
this.dw_4,&
this.dw_3,&
this.st_3,&
this.st_22,&
this.ole_1,&
this.dw_1}
end on

on w_fa_man_desglose_x.destroy
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.st_5)
destroy(this.cb_1)
destroy(this.cb_salir)
destroy(this.st_2)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.st_3)
destroy(this.st_22)
destroy(this.ole_1)
destroy(this.dw_1)
end on

event open;//Centrea la Ventana
//Oculto la ventana y se muestra luego de crear y cargar el dw
//this.hide()
str_desglose = Message.PowerObjectParm

this.Postevent("ue_postopen")

end event

event key;if keydown(keyescape!) then
	this.Postevent("close")
end if
end event

event close;str_desglose.cambio = lb_salvo
//////
if isvalid(this) then
	CloseWithReturn(this,str_desglose)
End If


end event

event closequery;integer  li_resultado

If lb_cambio then	
	li_resultado = gf_mensaje("","Desea Salvar Los Cambios Hechos ?",4,1,"E")
	choose case li_resultado
		case 1
			wf_guardar()			
		case 3
			return 1
	end choose
	lb_cambio = false
end if

end event

event resize;long	ll_dw_ancho,ll_dw_alto
this.SetRedraw(false)

dw_1.x=32
dw_1.y=20

ll_dw_ancho = 2629
ll_dw_alto  = 1072

dw_1.Resize(ll_dw_ancho, ll_dw_alto)
this.SetRedraw(true)

end event

type dw_2 from datawindow within w_fa_man_desglose_x
integer x = 37
integer y = 1268
integer width = 1961
integer height = 136
integer taborder = 50
string title = "none"
string dataobject = "dw_ma_fa_cant_pedi_packing_disp_esp_det"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_fa_man_desglose_x
integer x = 37
integer y = 1124
integer width = 165
integer height = 64
integer textsize = -10
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

type st_5 from statictext within w_fa_man_desglose_x
integer x = 846
integer y = -148
integer width = 261
integer height = 88
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_fa_man_desglose_x
integer x = 2021
integer y = 1152
integer width = 247
integer height = 76
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
string text = "Salvar"
end type

event clicked;setpointer(hourglass!)	

wf_guardar()				//Salvar Los Cambios 

setpointer(arrow!)	
end event

type cb_salir from commandbutton within w_fa_man_desglose_x
integer x = 2377
integer y = 1152
integer width = 247
integer height = 76
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
string text = "Salir"
end type

event clicked;parent.triggerevent("closequery")
parent.triggerevent("close")

end event

type st_2 from statictext within w_fa_man_desglose_x
boolean visible = false
integer x = 786
integer y = 1340
integer width = 1211
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detalle de la Línea de la lista de Empque"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_4 from datawindow within w_fa_man_desglose_x
integer x = 197
integer y = 1408
integer width = 2569
integer height = 388
integer taborder = 40
string dataobject = "dw_ma_fa_desglose_packing_lin"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_fa_man_desglose_x
boolean visible = false
integer x = 41
integer y = 972
integer width = 2569
integer height = 132
integer taborder = 20
boolean border = false
end type

type st_3 from statictext within w_fa_man_desglose_x
integer x = 2011
integer y = 1144
integer width = 261
integer height = 88
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_22 from statictext within w_fa_man_desglose_x
integer x = 2373
integer y = 1144
integer width = 261
integer height = 88
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type ole_1 from olecustomcontrol within w_fa_man_desglose_x
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
integer x = 69
integer y = 36
integer width = 2459
integer height = 128
integer taborder = 10
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_fa_man_desglose_x.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type dw_1 from datawindow within w_fa_man_desglose_x
event ue_keydown pbm_dwnkey
event type integer ue_postitem ( long row,  dwobject dwo,  string data,  string columna )
event ue_enter pbm_dwnprocessenter
integer x = 27
integer y = 32
integer width = 2629
integer height = 1084
integer taborder = 10
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;long 		ll_column
integer  li_columns
string	ls_colum, ls_column_name

ll_column = this.Getcolumn()
ls_colum	 = this.Getcolumnname()


if keydown(keyA!) then	
	messagebox("",ls_colum)
end if

if keydown(keyenter!) then
	
	is_col = This.GetColumnName()
	
	if mid(ls_colum,1,1) = 'c' and ls_colum <> "color" then
		this.Setcolumn(ll_column + 1)		//Para saltar a la fraccion
	else
		
	li_columns = Integer(dw_1.Describe("DataWindow.Column.Count"))		
	ls_column_name = dw_1.Describe("#" + string(li_columns - 1) + ".Name")  //RECUPERA EL NOMBRE DE LA COLUMNA
		
		if ls_column_name = ls_colum then
			this.Setcolumn(2)		//Para saltar al campo inicial
		elseif ls_colum = "color" then
			this.Setcolumn(ll_column + 2)   //Si está en el campo de color
		else
			this.Setcolumn(ll_column + 3)	  //Para saltar el campo oculto de Protegido
		end if
		
	end if
	
   return 2
	
elseif keydown(KeyPageDown!) then
	return 2
elseif keydown(keyControl!) and keydown(keyS!) then
	if lb_cambio then wf_guardar()			//Salvar Los Cambios
	return 2
end if
end event

event ue_postitem;//Post itemchanged 
String	ls_codigo, ls_num_largo, ls_cantidad
Decimal	ld_total,ld_cantidad

lb_cambio = true

if mid(is_col,1,1) = "c"  then
	
		ls_codigo	=	dw_1.GetitemString(row,"tcodigo"+mid(is_col,2))

		//Extrae el numero de la casilla o largo
		ls_num_largo = mid(is_col,2) 			  		
	
		//Extrae la Cantidad y Fraccion Para Guardarla
		ld_cantidad 	= dw_1.Getitemnumber(row,"c"+ls_num_largo)

		//Total de yds contenidas en el dw_1
		ld_total = dw_1.GetItemNumber(1,"STotal_c")
		If IsNull(ld_total) then ld_total = 0
	
		If ld_total > id_disponible then
			/* Modificacion Realizada a pendicion del Cliente Textiles (--) */
			messagebox("Atención ","La cantidad total registrada excede a la disponible de este renglón del pedido + el 20% autorizado por la Gerencia ")
			ls_cantidad = 'c'+mid(columna,2,len(columna) - 1)

			dw_1.SetItem(row,ls_cantidad,0) 

			ld_total = dw_1.GetItemNumber(1,"STotal_c")
/***/		ld_cantidad = id_disponible - ld_total

			If IsNull(ld_cantidad) then ld_cantidad = 0
		   IF ld_cantidad >= 0	THEN 
				messagebox("Atención ","Sólo se dispone de "+string(ld_cantidad,'##,##0.00'))
				dw_1.SetItem(row,ls_cantidad,ld_cantidad)
			ELSE 
				messagebox("Atención ","Se ha sobrepasado en  "+string(ABS(ld_cantidad),'##,##0.00'))
				dw_1.SetItem(row,ls_cantidad,0)
			END IF
			
			dw_1.SetColumn(columna)
		End If
			
end if 

return 1
end event

event ue_enter;send(handle(this),256,9,long(0,0))
return 1
end event

event itemfocuschanged;//Hace un Scroll al Registro Que muestra lo disponible y asignado por casilla

if dw_1.rowcount() < 1 then return

Integer li_pos, li_pos2=1
string  ls_cod_color, ls_campo, ls_cod_tama, ls_cod_largo, ls_numero_campo, ls_codigo

ls_campo 		 = dwo.name

if ls_campo = "color" then
//	dw_3.Scrolltorow(dw_3.rowcount())
	return
end if

if mid(ls_campo,1,1) = "c" then
	ls_numero_campo = mid(ls_campo,pos(ls_campo,"c") + 1)	
	il_canti    = this.GetitemNumber(row,"c"+ls_numero_campo)
elseif mid(ls_campo,1,1) = "f" then
	ls_numero_campo = mid(ls_campo,pos(ls_campo,"f") + 1)		
	il_fraccion = this.GetitemNumber(row,"f"+ls_numero_campo)		
else
	return
end if

//Codig concatenado
ls_codigo = this.getitemstring(row,"tcodigo"+ls_numero_campo)

li_pos	 = pos(ls_codigo," ",1)
li_pos2	 = li_pos
li_pos	 = pos(ls_codigo," ",li_pos2 + 1)
//Extrae el codigo del color
ls_cod_color = mid(ls_codigo,li_pos2 + 1, li_pos - li_pos2 - 1 )

li_pos2   = li_pos
li_pos	 = pos(ls_codigo," ",li_pos2 + 1)
//Extrae el codigo del tamaño
ls_cod_tama = mid(ls_codigo,li_pos2 + 1, li_pos - li_pos2 - 1 )

li_pos2   = li_pos
li_pos	 = pos(ls_codigo," ",li_pos2 + 1)
//Extrae el codigo del largo
ls_cod_largo = mid(ls_codigo,li_pos2 + 1, li_pos - li_pos2 - 1 )

if ls_cod_color = '' or isnull(ls_cod_color) then
//	dw_3.Scrolltorow(dw_3.insertrow(0))
	return 2
end if

//Dirige el cursor al producto actual
//wf_scroll_a_disponibles(dw_3, ls_cod_color, ls_cod_tama, ls_cod_largo)
end event

event itemchanged;string ls_columna 
ls_columna = This.GetColumnName()

this.Post event ue_postitem(row, dwo, data,ls_columna)
end event

event editchanged;
lb_cambio = true

is_col = This.GetColumnName()
end event

