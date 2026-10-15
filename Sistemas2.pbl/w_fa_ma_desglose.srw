//objectcomments Ventana de Captura de Desglose de Pedidos
forward
global type w_fa_ma_desglose from window
end type
type cbx_ocultadw from checkbox within w_fa_ma_desglose
end type
type st_nom_ventana from statictext within w_fa_ma_desglose
end type
type cb_salir from commandbutton within w_fa_ma_desglose
end type
type sle_codigo from singlelineedit within w_fa_ma_desglose
end type
type st_3 from statictext within w_fa_ma_desglose
end type
type dw_3 from datawindow within w_fa_ma_desglose
end type
type sle_total_f from singlelineedit within w_fa_ma_desglose
end type
type sle_total_c from singlelineedit within w_fa_ma_desglose
end type
type st_2 from statictext within w_fa_ma_desglose
end type
type st_titulo from statictext within w_fa_ma_desglose
end type
type cb_1 from commandbutton within w_fa_ma_desglose
end type
type dw_4 from datawindow within w_fa_ma_desglose
end type
type dw_2 from datawindow within w_fa_ma_desglose
end type
type dw_1 from datawindow within w_fa_ma_desglose
end type
type st_4 from statictext within w_fa_ma_desglose
end type
type st_5 from statictext within w_fa_ma_desglose
end type
end forward

global type w_fa_ma_desglose from window
integer x = 247
integer y = 388
integer width = 2880
integer height = 888
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
event ue_postopen ( )
cbx_ocultadw cbx_ocultadw
st_nom_ventana st_nom_ventana
cb_salir cb_salir
sle_codigo sle_codigo
st_3 st_3
dw_3 dw_3
sle_total_f sle_total_f
sle_total_c sle_total_c
st_2 st_2
st_titulo st_titulo
cb_1 cb_1
dw_4 dw_4
dw_2 dw_2
dw_1 dw_1
st_4 st_4
st_5 st_5
end type
global w_fa_ma_desglose w_fa_ma_desglose

type variables
long il_largos, il_color, il_yy, il_tallas, ia_multiplos[], il_canti, il_fraccion
string ia_largos[], ia_taman[], ia_codigos[], is_col,is_unidad
integer ii_linea
boolean lb_cambio = false, lb_salvo
integer ii
str_fa_detalles str_datos

end variables

forward prototypes
public subroutine wf_create_texto ()
public function integer wf_setear_colores ()
public function integer wf_setear_largos ()
public function integer wf_proteger_campos ()
public function integer wf_habilitar_existentes ()
public subroutine wf_convert_uni (string as_med, long al_fracciones, ref long al_cantidad, ref long al_fraccion)
public function integer wf_guardar ()
public function long wf_convert_min (string as_med, long al_cantidad, long al_fraccion)
public function string wf_find_grupo ()
public function integer wf_setear_cantidades (long al_filas)
public function integer wf_convierte_a_uni_disponibles (datawindow adw_dw, integer ai_row, string as_unidad, long al_asignada, long al_disponible)
public function integer wf_setear_disponibles (long al_filas)
public function integer wf_recuperar ()
public function integer wf_create_dw ()
public subroutine wf_recupera_desglose_renglon ()
public subroutine wf_actualiza_reserva ()
public subroutine wf_actualiza_dw_pedido (string ls_dw, datawindow adw, string ls_expresion_pedido, long ll_cantidad_edit, long ll_fraccion_edit, string ls_cod_tama, string ls_cod_largo, string ls_cod_color)
public subroutine wf_recuperar_todo ()
end prototypes

event ue_postopen;this.height = 904
st_titulo.visible = false

gf_center_win(This)

str_datos = Message.PowerObjectParm
st_nom_ventana.text = this.classname()

dw_1.settransobject(sqlca)

if str_datos.viene_de='factura' then
	dw_4.DataObject ='dw_ma_fa_desgloce_factura_new'
	dw_3.DataObject ='dw_ma_fa_desgloce_total_factura'
else
	dw_4.DataObject ='dw_ma_fa_desgloce_pedido_new'
	dw_3.DataObject ='dw_ma_fa_desgloce_total_pedido'
end if
dw_4.settransobject(sqlca)

dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_2.retrieve(str.g_financiero,str.empresa,str_datos.producto,str_datos.bodega,str_datos.ubicacion,str_datos.cod_clase_tam)

this.title = str_datos.titulo
If wf_create_dw() = 0 Then 
	this.TriggerEvent("close")
	return
End If

/*Recupera los valores de la tabla de indmodet para cargar la matriz */
If wf_recuperar() =0 Then
	this.TriggerEvent("close")
	return
End If

end event

public subroutine wf_create_texto ();string ls_textos, ls_resultado = "", ls_text = "", ls_font = ''
long   ll_y = 20, ll_x = 512, ll_width = 231, i=1, ll_ancho=0, ll_cant_largos, ll_multiplo, &
		 ll_total_tallas, ll_sesgo = 0

ll_total_tallas = il_tallas

ll_cant_largos = il_largos

// Ancho de los Largos "231"

ls_font = " font.height='-7' "

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

public function integer wf_setear_colores ();integer  i,j=0
string	ls_producto, ls_color, ls_cod_color, ls_expresion
Long		ll_row

for i = 1 to dw_2.rowcount()
	ls_cod_color	=  dw_2.getitemstring(i,"cod_color")
	ls_color			=  dw_2.getitemstring(i,"color")
	ls_expresion	=	"acol_num_color = '"+ls_cod_color+"'"
	ll_row			= dw_1.Find(ls_expresion,1,dw_1.rowcount())
	
	if ll_row = 0 then
		j ++
		il_color ++
		dw_1.InsertRow(0)
		dw_1.Setitem(j,"acol_num_color",ls_cod_color)
		dw_1.Setitem(j,"color",ls_color)
	end if
Next

return 1
end function

public function integer wf_setear_largos ();long 	  i, ll_row, ll_row2=1, ll_lineas=0, j=0, k=0, l=0, ll_cantidad
string  ls_cod_tama, ls_cod_largo, ls_expresion, ls_cod_color, ls_lar_abreviado  = ' ', ls_tam_abreviado = ' '

ll_lineas = dw_2.Rowcount()

for i = 1 to ll_lineas
	
	ls_cod_largo	=	dw_2.Getitemstring(i,"cod_largo")
	ls_cod_tama		=	dw_2.Getitemstring(i,"cod_tama")
	ls_cod_color	=	dw_2.Getitemstring(i,"cod_color")
	
	ls_expresion	=	"cod_tama = '"+ls_cod_tama+"' and cod_largo = '"+ls_cod_largo+"'"
	
	j ++
	ls_lar_abreviado =	dw_2.Getitemstring(i,"alar_abrev")	
	if isnull(ls_lar_abreviado) then ls_lar_abreviado = ' '
	ia_largos[j]     =  ls_lar_abreviado //Inserta la abreviatura de largo en el Arreglo
	//Para setear los tamaños o tallas
	if i = 1 then
		k ++
		ls_tam_abreviado=  dw_2.Getitemstring(i,"atam_abrev")
		if isnull(ls_tam_abreviado) then ls_tam_abreviado = ' '
		ia_taman[k]     =  ls_tam_abreviado	//Inserta el tamaño abreviado en el Arreglo
		//Setea los Multiplos o cantidad de ocurrencias de los cargos para un tamaño
	else
		if dw_2.getitemstring(i -1,"cod_tama") <> ls_cod_tama then
			k ++
			ia_taman[k]     =  dw_2.Getitemstring(i,"atam_abrev")	//Inserta el tamaño abreviado en el Arreglo
			//Setea los Multiplos o cantidad de ocurrencias de los cargos para un tamaño
			l=0			
		end if
	end if

	l ++
	ia_multiplos[k] =  l 
		
	ll_row		=	 dw_2.Find(ls_expresion,ll_row2 ,ll_lineas)
	
	ll_row2 		=  ll_row
	
	ll_row =	dw_2.Find(ls_expresion,ll_row2 + 1 ,ll_lineas)	
	if ll_row > 0 then
		i = ll_row
		ll_row2 	=  ll_row
	end if
next


j = 0
for i = 1 to ll_lineas
	j ++
	ls_cod_color	=	dw_2.Getitemstring(i,"cod_color")
	ls_cod_tama		=	dw_2.Getitemstring(i,"cod_tama")
	ls_cod_largo	=	dw_2.Getitemstring(i,"cod_largo")
	
	ia_codigos[i]	=	string(ll_cantidad)+" "+ls_cod_color+" "+ls_cod_tama + " "+ls_cod_largo+" "+string(j)
	if j = upperbound(ia_largos) then
		j = 0
	end if
Next

return 1
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

public function integer wf_habilitar_existentes ();//Función en la que se habilitan los campos que existen en el DW2 
//Y se setean los valores al codigo y cantidades
//Llamada desde wf_ceate_dw()
integer i, j, li_pos = 0, li_pos2 = 1
string  ls_cod_color, ls_cod_color2, ls_num_largo //, ls_unidad
long	  ll_lineas, ll_tot_codigos, ll_cantidad, ll_canti, ll_fraccion

ll_lineas = dw_1.Rowcount()
ll_tot_codigos = upperbound(ia_codigos)

is_unidad		=	str_datos.unid_medida //Unidad de Venta

for i = 1 to ll_lineas	
    ls_cod_color	=	dw_1.Getitemstring(i,"acol_num_color")		 
	 for j = 1 to ll_tot_codigos
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
			  dw_1.Setitem(i,"tcodigo"+ls_num_largo,ia_codigos[j])
		  	  dw_1.Setitem(i,"c"+ls_num_largo,0)
  			  dw_1.Setitem(i,"f"+ls_num_largo,0)
		     if isnull(dw_1.getitemnumber(i,"c"+ls_num_largo)) then
				  messagebox("Es nulo",ls_num_largo)
			  end if			  
 		  end if
	 next
next

return 1
end function

public subroutine wf_convert_uni (string as_med, long al_fracciones, ref long al_cantidad, ref long al_fraccion);/*Esta Función Convierte de Unidad Minima a la Unidad que se Quiere*/
//Llamada desde: wf_habilita_existentes()

Double ld_total
long   ll_mconvera, ll_ucom, ll_frac

 
/*Extrae la Unidad comun "Pedo/Unidades/etc "*/
ll_ucom = gf_medi_prod(as_med)


/*Retorna el Factor de Converción a unidades minimas*/
ll_mconvera = gf_unidad_venta(as_med, ll_ucom)

If ll_mconvera <= 0 Then ll_mconvera = 1

ld_total = ( al_fracciones / ll_mconvera) 

ll_frac = (Mod(al_fracciones, ll_mconvera))

al_cantidad = Long(ld_total)
al_fraccion = ll_frac

end subroutine

public function integer wf_guardar ();dw_1.accepttext()

string  ls_cod_color, ls_campo, ls_cod_tama, ls_cod_largo, ls_codigo, &
		  ls_column_name, ls_expresion,  ls_cod_grupo
integer i, j, k=0, li_columns, li_pos, li_pos2=1, li_resultado
Long    ll_row, ll_fila, ll_canti_total, ll_fraccion, ll_cantidad

li_columns = Integer(dw_1.Describe("DataWindow.Column.Count"))
//is_unidad		=	dw_2.Getitemstring(1,"prod_medida") //Unidad de Venta

is_unidad =  str_datos.unid_medida

str_datos.cantidad_max = 0 
str_datos.fraccion_max = 0

for i = 1 to dw_1.Rowcount()
	k = 0
	for j = 1 to li_columns
		
		ls_column_name = dw_1.Describe("#" + string(j) + ".Name")
		
		//RECUPERA EL NOMBRE DE LA COLUMNA
		
		if mid(ls_column_name,1,1)	= 'f'  then
			k ++
			//si el campo esta protegido, que siga con el siguiente

			if dw_1.getitemNumber(i,"p"+string(k)) = 1 then continue	

			//Extrae la Cantidad y Fraccion Para Guardarla
			ll_cantidad 	= dw_1.Getitemnumber(i,"c"+string(k))
			ll_fraccion 	= dw_1.Getitemnumber(i,"f"+string(k))		
			ll_canti_total = wf_convert_min(is_unidad,ll_cantidad,ll_fraccion)

			str_datos.cantidad_max =str_datos.cantidad_max + ll_cantidad
			str_datos.fraccion_max =str_datos.fraccion_max + ll_fraccion

			ls_codigo = '  '
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
			//Extrae el codigo del largo
			    
			ls_cod_largo = mid(ls_codigo,li_pos2 + 1, li_pos - li_pos2 - 1 )					
			
 		   ls_expresion ="desg_producto = '"+str_datos.producto+"' and desg_linea = "+string(str_datos.renglon)+" and desg_cod_grupo_tam = '"+str_datos.cod_clase_tam+"' and desg_color = '"+ls_cod_color+"' and desg_cod_talla = '"+ls_cod_tama+"' and desg_largo = '"+ls_cod_largo+"'"
			
			ll_row = dw_4.Find(ls_expresion,1,dw_4.Rowcount())

			if ll_row > 0 then
				//Afectar la Cantidad
				dw_4.setitem(ll_row,"desg_cantidad",ll_cantidad)				
				dw_4.setitem(ll_row,"desg_fraccion",ll_fraccion)
			else
				if IsNull(ll_cantidad) then ll_cantidad = 0
				if IsNull(ll_fraccion) then ll_fraccion = 0
				
				if  (ll_fraccion + ll_cantidad > 0)  then					
					
					dw_4.insertrow(0)
					
					ll_fila = dw_4.rowcount()
					
					dw_4.scrolltorow(ll_fila)
					
					dw_4.setitem(ll_fila,"desg_g_financiero",str.g_financiero)
					dw_4.setitem(ll_fila,"desg_empresa",str.empresa)
					
					dw_4.setitem(ll_fila,"desg_tipo",str_datos.tipo_transaccion)			
					dw_4.setitem(ll_fila,"desg_producto",str_datos.producto)			
					dw_4.setitem(ll_fila,"desg_anno",year(date(str_datos.fecha)))
					dw_4.setitem(ll_fila,"desg_linea",str_datos.renglon)
					
					dw_4.setitem(ll_fila,"desg_lin_desglose",ll_fila)
					
					dw_4.setitem(ll_fila,"desg_no_pedido",str_datos.no_pedido)
					
					dw_4.setitem(ll_fila,"desg_cod_grupo_tam",str_datos.cod_clase_tam)

					dw_4.setitem(ll_fila,"desg_cod_talla",ls_cod_tama)
					
					dw_4.setitem(ll_fila,"desg_largo",ls_cod_largo)
					dw_4.setitem(ll_fila,"desg_color",ls_cod_color)
					dw_4.setitem(ll_fila,"desg_unidad_medida",str_datos.unid_medida)										
					dw_4.setitem(ll_fila,"desg_cantidad",ll_cantidad)				
					dw_4.setitem(ll_fila,"desg_fraccion",ll_fraccion)
					
					dw_4.setitem(ll_fila,"desg_tipo",str_datos.tipo_transaccion)
				end if
				
			end if						
			
		end if
	next
next
return 1
end function

public function long wf_convert_min (string as_med, long al_cantidad, long al_fraccion);/*Esta función recibe la cantidad y fracción y retorna todo convertido a fracción*/
//Llamada desde: retrieveend del DW 4, wf_validar_cantidad()

Long ll_ucom, ll_mconvera, ll_total

/*Extrae la Unidad comun "Pedo/Unidades/etc "*/
ll_ucom = gf_medi_prod(as_med)

/*Retorna el Factor de Converción a unidades minimas*/
ll_mconvera = gf_unidad_venta(as_med, ll_ucom)

If ll_mconvera <= 0 Then ll_mconvera = 1

ll_total = (al_cantidad * ll_mconvera) + al_fraccion

Return (ll_total)
end function

public function string wf_find_grupo ();//string ls_cod_grupo = '', ls_expresion
//long   ll_row
//
//ls_expresion = "linea = "+string(ii_linea)
//
//ll_row	=	dw_2.Find(ls_expresion,1,dw_2.Rowcount())
//
//if ll_row > 0 then
//	ls_cod_grupo = dw_2.Getitemstring(ll_row,"grupo_tam")
//end if
//
//return ls_cod_grupo
return dw_2.getitemstring(1,"cod_clase_tam")
end function

public function integer wf_setear_cantidades (long al_filas);//Recorre el dw y setea las cantidades en el dw2 que es el basico para armar el dw1
if al_filas < 1 then return 1

integer i
string  ls_expresion, ls_color, ls_tama, ls_largo, ls_cod_grupo
long    ll_row, ll_linea, ll_cantidad

for i = 1 to dw_2.Rowcount()
	dw_2.Setitem(i,"cantidad",0)
next

for i = 1 to al_filas
	
	ls_color		 =	dw_4.Getitemstring(i,"fade_color")
	ls_tama		 =	dw_4.Getitemstring(i,"fade_tama")	

	ls_largo		 =	dw_4.Getitemstring(i,"fade_tamb")	
	ls_cod_grupo = dw_4.Getitemstring(i,"fade_grupo_tam")
	ll_linea		 = dw_4.GetitemNumber(i,"fade_linea")
	ll_cantidad	 = dw_4.GetitemNumber(i,"fade_cantidad")
	
	ls_expresion = "linea = "+string(ll_linea)+" and cod_color = '"+ls_color+"' and cod_tama = '"+ls_tama+"'"+ &
						" and cod_largo = '"+ls_largo+"' and grupo_tam = '"+ls_cod_grupo+"'"					

	ll_row = dw_2.Find(ls_expresion,1,dw_2.Rowcount())
  
//	messagebox(ls_expresion,ll_cantidad)

	if ll_row > 0 then
		dw_2.Setitem(ll_row,"cantidad",ll_cantidad)
	end if

next

return 1
end function

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
//
return 1
end function

public function integer wf_setear_disponibles (long al_filas);////Recorre el dw y setea las cantidades en el dw2 que es el basico para armar el dw1
//if al_filas < 1 then return 1
//integer i
//string  ls_expresion, ls_color, ls_tama, ls_largo, ls_cod_grupo
//long    ll_row, ll_linea, ll_cantidad
//for i = 1 to dw_2.Rowcount()
//	dw_2.Setitem(i,"cantidad",0)
//next
//
//for i = 1 to al_filas
//	
//	ls_color		 =	dw_4.Getitemstring(i,"desg_color")
//	ls_tama		 =	dw_4.Getitemstring(i,"desg_cod_talla")	
//	ls_largo		 =	dw_4.Getitemstring(i,"desg_largo")	
//	ls_cod_grupo = dw_4.Getitemstring(i,"desg_cod_grupo_tam")
//	ll_linea		 = dw_4.GetitemNumber(i,"desg_linea")
//	ll_cantidad	 = dw_4.GetitemNumber(i,"cant_disponible")
//	
//	ls_expresion = "linea = "+string(ll_linea)+" and cod_color = '"+ls_color+"' and cod_tama = '"+ls_tama+"'"+&
//						" and cod_largo = '"+ls_largo+"' and grupo_tam = '"+ls_cod_grupo+"'"
//
//	ll_row = dw_2.Find(ls_expresion,1,dw_2.Rowcount())
//	
//	if ll_row > 0 then
//		dw_2.Setitem(ll_row,"cantidad",ll_cantidad)
//	end if
//	
//next
//
return 1
end function

public function integer wf_recuperar ();//Para Recuperar os Cambios en Indmodet

string  ls_cod_color, ls_campo, ls_cod_tama, ls_cod_largo, ls_codigo, &
		  ls_column_name, ls_expresion, ls_cod_grupo
integer i, j, k=0, li_columns, li_pos, li_pos2=1, li_resultado, li_seteada,li_autoriza
Long    ll_row, ll_fila, ll_canti_total, ll_fraccion, ll_cantidad

dw_1.accepttext()

//Datawindow que contiene el detalle reservado por el renglón
dw_4.retrieve(str.g_financiero,str.empresa, & 
				  str_datos.no_pedido,str_datos.anio, str_datos.renglon,str_datos.producto)

/*	Guardar valor de cantidad y fracción reservada para luego calcular y
grabar el resultado en la tabla de detalle de inventario */

For ll_fila = 1 to dw_4.rowcount()
	dw_4.setitem(ll_fila,"cant_reservada", dw_4.getitemNumber(ll_fila,"desg_cantidad"))
	dw_4.setitem(ll_fila,"frac_reservada", dw_4.getitemNumber(ll_fila,"desg_fraccion"))
Next

//Datawindow que contiene el detalle reservado del producto por el pedido
dw_3.retrieve(str.g_financiero,str.empresa, & 
				  str_datos.no_pedido,str_datos.anio, str_datos.producto,str_datos.bodega,str_datos.ubicacion)

For ll_fila = 1 to dw_3.rowcount()
	dw_3.setitem(ll_fila,"can_reserva_or", dw_3.getitemNumber(ll_fila,"desg_cantidad"))
	dw_3.setitem(ll_fila,"frac_reserva_or", dw_3.getitemNumber(ll_fila,"desg_fraccion"))
Next

//Datawindo de productos

If dw_2.retrieve(str.g_financiero,str.empresa,str_datos.producto,str_datos.bodega,str_datos.ubicacion,str_datos.cod_clase_tam) < 1 Then
	//Valida si se permite facturar o no en negativo
	mensaje("Atención ","No existe desglose del producto "+str_datos.producto+' en la bodega '+str_datos.bodega+' ubicacion '+str_datos.ubicacion,"")
	Return 0
End If

li_columns = Integer(dw_1.Describe("DataWindow.Column.Count"))

is_unidad		=	str_datos.unid_medida //Unidad de Venta

for i = 1 to dw_1.Rowcount()
	k = 0
	for j = 3 to li_columns
		
		ls_column_name = dw_1.Describe("#" + string(j) + ".Name")  
		//RECUPERA EL NOMBRE DE LA COLUMNA
		
		if mid(ls_column_name,1,1)	= 'f' then
			k ++
			//si el campo esta protegido, que siga con el siguiente
			if dw_1.getitemNumber(i,"p"+string(k)) = 1 then continue	
			//Extrae la Cantidad y Fraccion Para Guardarla
			ll_cantidad 	= dw_1.Getitemnumber(i,"c"+string(k))
			ll_fraccion 	= dw_1.Getitemnumber(i,"f"+string(k))		
			//ll_canti_total = wf_convert_min(is_unidad,ll_cantidad,ll_fraccion)

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
			
			li_pos2   = li_pos
			li_pos	 = pos(ls_codigo," ",li_pos2 + 1)
			//Extrae el codigo del largo
			    
			ls_cod_largo = mid(ls_codigo,li_pos2 + 1, li_pos - li_pos2 - 1 )					
			
			//Se extrae el codigo de grupo, del dw2
			
		   ls_expresion = "desg_producto = '"+str_datos.producto+"' and desg_linea = "+string(str_datos.renglon)+" and desg_cod_grupo_tam = '"+str_datos.cod_clase_tam+"' and desg_color = '"+ls_cod_color+"' and desg_cod_talla = '"+ls_cod_tama+"' and desg_largo = '"+ls_cod_largo+"'"
         
			ll_row = dw_4.Find(ls_expresion,1,dw_4.Rowcount())

	
			if ll_row > 0 then
				li_resultado = dw_4.Scrolltorow(ll_row)
				//Afectar la Cantidad
				ll_cantidad = dw_4.getitemnumber(ll_row,"desg_cantidad")
				ll_fraccion = dw_4.getitemnumber(ll_row,"desg_fraccion")

				If IsNull(ll_cantidad) then ll_cantidad =0
				If IsNull(ll_fraccion) then ll_fraccion =0

				li_seteada =dw_4.GetitemNumber(ll_row,"desg_seteada")

				if IsNull(li_seteada) then li_seteada = 0

				if not isnull(ll_cantidad) and li_seteada <> 9 then
					dw_1.setitem(i,"c"+string(k),ll_cantidad)
					dw_4.Setitem(ll_row,"desg_seteada",9)
				end if
				if not isnull(ll_fraccion) and li_seteada <> 9 then
					dw_1.setitem(i,"f"+string(k),ll_fraccion)	
					dw_4.Setitem(ll_row,"desg_seteada",9)
				end if
			end if						
		end if
	next
next
commit;
Return 1
end function

public function integer wf_create_dw ();long	  ll_y = 7,  ll_x = 400, ll_x_texto = 260, ll_width = 133, ll_band_detail = 600, ll_contador=0,&
        ll_inicial[]
String  ls_column_name, ls_dw_propiedades, is_sql, ls_syntaxis, ls_err, ls_describe, ls_format,&
		  ls_editmask, ls_resultado='', la_inicial[]
Integer li_columns, li_i, li_height, li_height_max, i, j=0
Boolean lb_height

If dw_2.retrieve(str.g_financiero,str.empresa,str_datos.producto,str_datos.bodega,str_datos.ubicacion,str_datos.cod_clase_tam) < 1 Then
	mensaje("Atención ","No existe desglose del producto "+str_datos.producto+' en la bodega '+str_datos.bodega+' ubicacion '+str_datos.ubicacion,"")
	return 0
End If

//Inicializacion de los arreglos utilizados

ia_largos[]    = la_inicial[]
ia_taman[]	   = la_inicial[]
ia_codigos[]   = la_inicial[]
ia_multiplos[] = ll_inicial[]

//Para Setear los Textos de los Largos en el arreglo
wf_setear_largos()

il_largos = UpperBound(ia_largos)
il_tallas = UpperBound(ia_taman)

	is_sql = "  SELECT acol_num_color, "

	is_sql += "'                    '  color, "		 //Nombre del color de 20
	
	for i = 1 to il_largos // * il_color //Crea tres computes, por cada largo (Cantidad, Fraccion y Protegido)
		if i > 1 then is_sql += ", "										 
		is_sql += "0  p"+string(i)+", "		 //Campo que me identifica si el Campo de Cant. y Frac.
								 						 //estará Protegido o no
		is_sql += "0  c"+string(i)+", "						 
		is_sql += "0  f"+string(i)+", "		 
		is_sql += "'        '  tcodigo"+string(i)
	next										 


	is_sql = is_sql +" FROM cracolor  "

ls_syntaxis = SQLCA.SyntaxFromSQL(is_sql, "style(type=Tabular) datawindow(color = 79416533) ", ls_err)
string ls_suma_c, ls_suma_f

/* Re-ubica las columnas antes de crear el data windows   ( -1- ) */
long ll_resp_x, ll_resp_y, ll_resp_i

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
/* (- 1 -) */


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
	
	
/* Crea el total por linea para colores en el desglose de productos */	
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
	'height="48" width="421"  name=texto  font.face="Arial" font.height="-8" ' + & 
	'font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2"'+ &
	'background.color=" 79416533" )'

	ls_syntaxis = ls_syntaxis + &
	'text(band=header alignment="0" text="T O T A L"border="0" color="0" x="7" y="52"'+ & 
	' height="56" width="200"  name=t_total  font.face="Arial" font.height="-8" '+ & 
	'font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.' + & 
	'mode="1" background.color="553648127" )'

	ls_syntaxis = ls_syntaxis + &
	'text(band=header alignment="0" text=""border="6" color="0" x="7" y="15"'+ & 
	' height="125" width="200"  name=t_total_m  font.face="Arial" font.height="-8" '+ & 
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
end if

li_columns = Integer(dw_1.Describe("DataWindow.Column.Count"))

FOR li_i = 1 TO li_columns
	
		str.frame.Setmicrohelp("Procesando la Configuración de la Columna "+string(li_columns))
		
		ls_column_name = dw_1.Describe("#" + string(li_i) + ".Name")  //RECUPERA EL NOMBRE DE LA COLUMNA
		if li_i < 3 then
			if li_i = 2 then
				//Texto
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.Font.Weight=700 "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.width='447' "	
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.height='125' "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.border='6' "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.background.color='553648127' "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.x='50' "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.y='20' "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.Text='~nCOLORES' "
				//Edit
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".Border='5~tif( getrow() = currentRow(),6,5) ' "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".background.Mode='2' "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".background.color='16777215~tif( getrow() = currentRow(), rgb(0,0,128), rgb(255,255,255)) ' "
		      ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".color='0~tif(getrow() = currentRow(),rgb(255,255,255),rgb(0,0,128) )' "											
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".TabSequence= "+string(li_i)+" "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".height='48' "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".width='447' "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".x='50' "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".y='8' "		
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".alignment='0' "	
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".edit.displayonly= Yes "
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".edit.autohscroll=Yes "		
				ls_dw_propiedades = ls_dw_propiedades + ls_column_name + ".edit.focusrectangle=Yes "
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
			ls_format = '##0'
			ls_editmask = '###'
		elseif mid(ls_column_name,1,1) = "c" then	//Si es un campo de Cantidad
			ls_format = '#####0'
			ls_editmask = '######'
			ll_x += 115				//Separacion entre la fraccion y la siguiente Cantidad
			ll_width = 133
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
		ll_x_texto += 253
		j ++		//Indice para extraer del arreglo		
//		if w_fa_fondo.str_para.titulo_abreviado = 1 then
			ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.font.height='-8' "
			ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.Font.Weight=700 " //Negrita			
//		else
//			ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.font.height='-7' "
//			ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.Font.Weight=400 "  //Sin negrita	
//		end if
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.width='231' "		

		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.border='6' "
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.x='"+string(ll_x_texto)+"' "		
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.y='90' "								
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.Text='"+ia_largos[j]+"' "
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.background.color='553648127' "
	else
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.visible='0' "	
		ls_dw_propiedades = ls_dw_propiedades + ls_column_name + "_t.x='20' "	//Para que no se vea el scroll horizontal tan grande
	end if																							//ya que aunque esten ocultos, hacen el espacio

NEXT

/* Adicion 24/08/99 */

			/* Establece la posicion y el formato para el total de una fila (Cantidad entera) */
			ls_format = '######'
			ll_x += 115				
			ll_width = 150		
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
			ll_width = 85
			ls_format = '###'
			ls_dw_propiedades = ls_dw_propiedades + "Total_f.x='"+string(ll_x)+"' "
			ls_dw_propiedades = ls_dw_propiedades + "Total_f.width='"+string(ll_width)+"' "
			ls_dw_propiedades = ls_dw_propiedades + "Total_f.format= '"+ls_format+"' "
			/* Establece la posicion y el formato para el total del pie de pagina para 
			   la Columna de Total por fila (Fraccion)*/			
			ls_dw_propiedades = ls_dw_propiedades + "STotal_f.x='"+string(ll_x)+"' "
			ls_dw_propiedades = ls_dw_propiedades + "STotal_f.width='"+string(ll_width)+"' "
			ls_dw_propiedades = ls_dw_propiedades + "STotal_f.format= '"+ls_format+"' "
			/* Lineas de Division entre el detalle y el Total */
			ls_dw_propiedades = ls_dw_propiedades + "Linea1.width='"+string(ll_x+ll_width)+"' "
			ls_dw_propiedades = ls_dw_propiedades + "Linea2.width='"+string(ll_x+ll_width)+"' "
			ls_dw_propiedades = ls_dw_propiedades + "Linea2.y='82' "
			
			/* */ 
			


str.frame.Setmicrohelp("")
	
ls_resultado= dw_1.Modify(ls_dw_propiedades) 

if ls_resultado <> "" then
	messagebox("Error al Personalizar el DW",ls_resultado)
end if

//Agrandar el tamaño del Header
dw_1.Modify("DataWindow.Header.Height='152'")
dw_1.Modify("DataWindow.Footer.Height='94'")
dw_1.Modify("DataWindow.detail.Height='68'")

wf_create_texto()

//Para setear los colores e Insertar la Cantidad de Colores
wf_setear_colores()

wf_habilitar_existentes()

ls_describe = dw_1.Describe("datawindow.syntax")

//messagebox("Width",dw_1.width)

if dw_1.Width > 2800 then
	dw_1.hscrollbar = true	//Habilita scroll horizontal
else
	dw_1.hscrollbar = false
end if

//Scroll vertical del dw
if dw_1.Rowcount() > 6 then
	dw_1.vscrollbar = true	
else
	dw_1.vscrollbar = false
end if

dw_1.Setfocus()

//Para mostrar la ventana
this.show()
return 1
end function

public subroutine wf_recupera_desglose_renglon ();integer  li_resultado
Long ll_cantidad,ll_fraccion,ll_row,ll_tunidades, ll_cant, ll_frac
string	ls_expresion

ls_expresion = "desg_linea = "+string(str_datos.renglon)
dw_4.Setfilter(ls_expresion)
dw_4.Filter()

For ll_row = 1 to dw_4.rowcount()
	ll_cant = dw_4.GetItemNumber(ll_row,"desg_cantidad")
	If IsNull(ll_cant) then ll_cant = 0
	ll_cantidad = ll_cantidad + ll_cant

	ll_frac = dw_4.GetItemNumber(ll_row,"desg_fraccion")
	If IsNull(ll_frac) then ll_frac = 0
	ll_fraccion = ll_fraccion + ll_frac
Next
//Convierte a unidades mínimas
ll_tunidades = wf_convert_min(str_datos.unid_medida,ll_cantidad,ll_fraccion)

//Convierte a unidades y fracción
wf_convert_uni(str_datos.unid_medida,ll_tunidades,ll_cantidad,ll_fraccion)

str_datos.cantidad_max =ll_cantidad
str_datos.fraccion_max =ll_fraccion

end subroutine

public subroutine wf_actualiza_reserva ();Long	ll_fila, ll_cantidad, ll_fraccion, ll_tot_cant_reserva
Long	ll_tot_frac_reserva, ll_tunidades, ll_existencia
Long	ll_cant_save,ll_frac_save, ll_can_edit, ll_frac_edit
String	ls_color,ls_talla,ls_largo, ls_error

is_unidad = str_datos.unid_medida 

For ll_fila = 1 to dw_4.rowcount()
	ls_color = dw_4.getitemString(ll_fila,"desg_color")
	ls_talla = dw_4.getitemString(ll_fila,"desg_cod_talla")
	ls_largo = dw_4.getitemString(ll_fila,"desg_largo")

  SELECT inmbodet.mbde_reserva,
  			inmbodet.mbde_cantidad
  	 INTO :ll_tot_cant_reserva,
			:ll_existencia
    FROM inmbodet  
   WHERE ( inmbodet.mbde_g_financiero =:str.g_financiero) AND  
         ( inmbodet.mbde_empresa = :str.empresa ) AND  
         ( inmbodet.mbde_producto = :str_datos.producto ) AND  
         ( inmbodet.mbde_cod_clase_tam = :str_datos.cod_clase_tam ) AND  
         ( inmbodet.mbde_bodega = :str_datos.bodega ) AND  
         ( inmbodet.mbde_ubicacion = :str_datos.ubicacion ) AND  
         ( inmbodet.mbde_cod_tamano = :ls_talla ) AND  
         ( inmbodet.mbde_largo = :ls_largo ) AND  
         ( inmbodet.mbde_color = :ls_color )   ;
			
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			lb_salvo = false
			rollback;
			mensaje("Atención ","Error al seleccionar la Cantidad Reservada en inmbodet",ls_error)
			return
		end if	
		
	if IsNull(ll_tot_cant_reserva) then ll_tot_cant_reserva = 0
	if IsNull(ll_existencia) then ll_existencia = 0

	
	//Convierte a unidades y fracción
	wf_convert_uni(str_datos.unid_medida ,ll_tot_cant_reserva,ll_cantidad,ll_fraccion)

	if IsNull(ll_cantidad) then ll_cantidad = 0
	if IsNull(ll_fraccion) then ll_fraccion = 0
	
	ll_cant_save = dw_4.getitemNumber(ll_fila,"cant_reservada")
	ll_frac_save = dw_4.getitemNumber(ll_fila,"frac_reservada")

	if IsNull(ll_cant_save) then ll_cant_save = 0
	if IsNull(ll_frac_save) then ll_frac_save = 0
	
	ll_can_edit  = dw_4.getitemNumber(ll_fila,"desg_cantidad")
	ll_frac_edit = dw_4.getitemNumber(ll_fila,"desg_fraccion")

	if IsNull(ll_can_edit) then ll_can_edit = 0
	if IsNull(ll_frac_edit) then ll_frac_edit = 0
	
	ll_cantidad = ll_cantidad - ll_cant_save + ll_can_edit
	ll_fraccion = ll_fraccion - ll_frac_save + ll_frac_edit

	//Convierte a unidades mínimas
	ll_tunidades = wf_convert_min(str_datos.unid_medida,ll_cantidad,ll_fraccion)

	if IsNull(ll_tunidades) then ll_tunidades = 0
	
  UPDATE inmbodet  
     SET mbde_reserva = :ll_tunidades  
   WHERE ( inmbodet.mbde_g_financiero =:str.g_financiero) AND  
         ( inmbodet.mbde_empresa = :str.empresa ) AND  
         ( inmbodet.mbde_producto = :str_datos.producto ) AND  
         ( inmbodet.mbde_cod_clase_tam = :str_datos.cod_clase_tam ) AND  
         ( inmbodet.mbde_bodega = :str_datos.bodega ) AND  
         ( inmbodet.mbde_ubicacion = :str_datos.ubicacion ) AND  
         ( inmbodet.mbde_cod_tamano = :ls_talla ) AND  
         ( inmbodet.mbde_largo = :ls_largo ) AND  
         ( inmbodet.mbde_color = :ls_color )   ;

		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			lb_salvo = false
			rollback;
			mensaje("Atención ","Error al Actaulizar Cantidad Reservada en inmbodet",ls_error)
			lb_salvo = false
			return
		end if	
Next
if dw_4.update() =  1 then
	lb_salvo = true
else
	lb_salvo = false
end If

end subroutine

public subroutine wf_actualiza_dw_pedido (string ls_dw, datawindow adw, string ls_expresion_pedido, long ll_cantidad_edit, long ll_fraccion_edit, string ls_cod_tama, string ls_cod_largo, string ls_cod_color);//Esta función setea las cantidades editadas del producto 
//o los adiciona en el dw de detalle del renglón del pedido y en el de 
//total reservado de ese producto por el pedido

Long	ll_row,ll_tres_orig,ll_tres_new,ll_can_reserva_or, ll_frac_reserva_or
Long	ll_tcantidad, ll_tfraccion

ll_row = adw.Find(ls_expresion_pedido,1,adw.Rowcount()) 

if ll_row > 0  then
	if ls_dw ='3' then
		adw.SetItem(ll_row,"can_reserva_or",ll_cantidad_edit)
		adw.SetItem(ll_row,"frac_reserva_or",ll_fraccion_edit)
	else
		adw.SetItem(ll_row,"desg_cantidad",ll_cantidad_edit)
		adw.SetItem(ll_row,"desg_fraccion",ll_fraccion_edit)
	end if
Else
	ll_row = adw.insertrow(0)
			
	adw.scrolltorow(ll_row)
			
	adw.setitem(ll_row,"desg_g_financiero",str.g_financiero)
	adw.setitem(ll_row,"desg_empresa",str.empresa)
			
	adw.setitem(ll_row,"desg_tipo",str_datos.tipo_transaccion)			
	adw.setitem(ll_row,"desg_producto",str_datos.producto)			

	adw.SetItem(ll_row,"desg_bodega",str_datos.bodega)
	adw.SetItem(ll_row,"desg_ubicacion",str_datos.ubicacion)

	
	adw.setitem(ll_row,"desg_anno",year(date(str_datos.fecha)))
	adw.setitem(ll_row,"desg_linea",str_datos.renglon)
			
	adw.setitem(ll_row,"desg_lin_desglose",ll_row)
			
	adw.setitem(ll_row,"desg_no_pedido",str_datos.no_pedido)
	
	adw.setitem(ll_row,"desg_cod_grupo_tam",str_datos.cod_clase_tam)
	adw.setitem(ll_row,"desg_cod_talla",ls_cod_tama)
			
	adw.setitem(ll_row,"desg_largo",ls_cod_largo)
	adw.setitem(ll_row,"desg_color",ls_cod_color)
	adw.setitem(ll_row,"desg_unidad_medida",str_datos.unid_medida)										

	if ls_dw ='3' then
		adw.SetItem(ll_row,"can_reserva_or",ll_cantidad_edit)
		adw.SetItem(ll_row,"frac_reserva_or",ll_fraccion_edit)
	else
		adw.SetItem(ll_row,"desg_cantidad",ll_cantidad_edit)
		adw.SetItem(ll_row,"desg_fraccion",ll_fraccion_edit)
	end if
			
	adw.setitem(ll_row,"desg_tipo",str_datos.tipo_transaccion)

end if

end subroutine

public subroutine wf_recuperar_todo ();Long	ll_fila
//Datawindow que contiene el detalle reservado por el renglón
dw_4.retrieve(str.g_financiero,str.empresa, & 
				  str_datos.no_pedido,str_datos.anio, str_datos.renglon,str_datos.producto)

/*	Guardar valor de cantidad y fracción reservada para luego calcular y
grabar el resultado en la tabla de detalle de inventario */

For ll_fila = 1 to dw_4.rowcount()
	dw_4.setitem(ll_fila,"cant_reservada", dw_4.getitemNumber(ll_fila,"desg_cantidad"))
	dw_4.setitem(ll_fila,"frac_reservada", dw_4.getitemNumber(ll_fila,"desg_fraccion"))
Next

//Datawindow que contiene el detalle reservado del producto por el pedido
dw_3.retrieve(str.g_financiero,str.empresa, & 
				  str_datos.no_pedido,str_datos.anio, str_datos.producto,str_datos.bodega,str_datos.ubicacion)

For ll_fila = 1 to dw_3.rowcount()
	dw_3.setitem(ll_fila,"can_reserva_or", dw_3.getitemNumber(ll_fila,"desg_cantidad"))
	dw_3.setitem(ll_fila,"frac_reserva_or", dw_3.getitemNumber(ll_fila,"desg_fraccion"))
Next

//Datawindo de productos

dw_2.retrieve(str.g_financiero,str.empresa,str_datos.producto,str_datos.bodega,str_datos.ubicacion,str_datos.cod_clase_tam) 

end subroutine

on w_fa_ma_desglose.create
this.cbx_ocultadw=create cbx_ocultadw
this.st_nom_ventana=create st_nom_ventana
this.cb_salir=create cb_salir
this.sle_codigo=create sle_codigo
this.st_3=create st_3
this.dw_3=create dw_3
this.sle_total_f=create sle_total_f
this.sle_total_c=create sle_total_c
this.st_2=create st_2
this.st_titulo=create st_titulo
this.cb_1=create cb_1
this.dw_4=create dw_4
this.dw_2=create dw_2
this.dw_1=create dw_1
this.st_4=create st_4
this.st_5=create st_5
this.Control[]={this.cbx_ocultadw,&
this.st_nom_ventana,&
this.cb_salir,&
this.sle_codigo,&
this.st_3,&
this.dw_3,&
this.sle_total_f,&
this.sle_total_c,&
this.st_2,&
this.st_titulo,&
this.cb_1,&
this.dw_4,&
this.dw_2,&
this.dw_1,&
this.st_4,&
this.st_5}
end on

on w_fa_ma_desglose.destroy
destroy(this.cbx_ocultadw)
destroy(this.st_nom_ventana)
destroy(this.cb_salir)
destroy(this.sle_codigo)
destroy(this.st_3)
destroy(this.dw_3)
destroy(this.sle_total_f)
destroy(this.sle_total_c)
destroy(this.st_2)
destroy(this.st_titulo)
destroy(this.cb_1)
destroy(this.dw_4)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.st_4)
destroy(this.st_5)
end on

event open;//Oculto la ventana y se muestra luego de crear y cargar el dw
this.hide()

this.Postevent("ue_postopen")

end event

event key;if keydown(keyescape!) then
	this.Postevent("close")
end if
end event

event close;if isvalid(this) then
	CloseWithReturn(this,str_datos)
End If

end event

event closequery;integer  li_resultado
Long ll_cantidad,ll_fraccion,ll_row
string	ls_expresion

If lb_cambio and lb_salvo = false then
	li_resultado = gf_mensaje("","Desea Salvar Los Cambios Hechos ?",4,1,"E")

	choose case li_resultado
			
		case 1
			// Si salva
			this.cb_1.triggerevent("clicked")
		case 2
			// No salva
			//Recupera el detalle original salvado para calcular el total a setear en la ventana de pedidos
			dw_4.retrieve(str.g_financiero,str.empresa, & 
				  str_datos.no_pedido,str_datos.anio, str_datos.renglon,str_datos.producto)
			wf_recupera_desglose_renglon()
			lb_cambio = false
		case 3
			// Cancelar continúa en el desglose
			return 1
	end choose

else
	If lb_cambio = false then
		dw_4.retrieve(str.g_financiero,str.empresa, & 
					  str_datos.no_pedido,str_datos.anio, str_datos.renglon,str_datos.producto)
		//Recupera el detalle original salvado para calcular el total a setear en la ventana de pedidos
		wf_recupera_desglose_renglon()
	end If
end if


end event

event resize;//If cbx_ocultadw.checked = true then
//	this.height = newheight - dw_2.height
//else
//	this.height = newheight + dw_2.height
//end If
st_nom_ventana.y =newheight - st_nom_ventana.height +10
st_nom_ventana.x =40


end event

type cbx_ocultadw from checkbox within w_fa_ma_desglose
integer x = 2514
integer y = 720
integer width = 302
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Detalle"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

event clicked;
If cbx_ocultadw.checked = true then
	parent.height = 904
	st_titulo.visible = false
else
	parent.height = 1588
	st_titulo.visible = true
end If
gf_center_win(parent)

end event

type st_nom_ventana from statictext within w_fa_ma_desglose
integer x = 23
integer y = 1428
integer width = 978
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type cb_salir from commandbutton within w_fa_ma_desglose
integer x = 2235
integer y = 720
integer width = 247
integer height = 76
integer taborder = 40
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

type sle_codigo from singlelineedit within w_fa_ma_desglose
boolean visible = false
integer x = 361
integer y = 716
integer width = 425
integer height = 76
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_fa_ma_desglose
boolean visible = false
integer x = 187
integer y = 1720
integer width = 2487
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 65535
boolean enabled = false
string text = "CANTIDAD TOTAL RESERVADA DEL PRODUCTO,BOD. Y UBICACION  EN ESTE PEDIDO"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_fa_ma_desglose
boolean visible = false
integer x = 41
integer y = 1752
integer width = 2802
integer height = 360
integer taborder = 60
string dataobject = "dw_ma_fa_desgloce_total_pedido"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_total_f from singlelineedit within w_fa_ma_desglose
boolean visible = false
integer x = 3031
integer y = 1180
integer width = 238
integer height = 80
integer taborder = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_total_c from singlelineedit within w_fa_ma_desglose
boolean visible = false
integer x = 3031
integer y = 1044
integer width = 238
integer height = 80
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_fa_ma_desglose
boolean visible = false
integer x = 146
integer y = 1188
integer width = 2551
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 65535
boolean enabled = false
string text = "CANTIDAD TOTAL RESERVADA DEL PRODUCTO,BOD. Y UBICACION  EN ESTE RENGLON"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_titulo from statictext within w_fa_ma_desglose
boolean visible = false
integer x = 818
integer y = 720
integer width = 1106
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 16711680
boolean enabled = false
string text = "EXISTENCIAS EN INVENTARIO"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_fa_ma_desglose
integer x = 1961
integer y = 720
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

wf_actualiza_reserva()	// calcula y actualiza la reserva en inventario

if lb_salvo = true then
	commit;
	mensaje("Atencion"," Actualización exitosa","")
//	dw_4.retrieve(str.g_financiero,str.empresa, & 
//		  str_datos.no_pedido,str_datos.anio, str_datos.renglon,str_datos.producto)
	wf_recuperar_todo()
	wf_recupera_desglose_renglon()
else
	rollback;
	mensaje("Atencion","  Error al salvar el desglose del producto","")
end if

setpointer(arrow!)	
end event

type dw_4 from datawindow within w_fa_ma_desglose
boolean visible = false
integer x = 37
integer y = 1256
integer width = 2798
integer height = 296
integer taborder = 50
string dataobject = "dw_ma_fa_desgloce_pedido_new"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
end type

type dw_2 from datawindow within w_fa_ma_desglose
boolean visible = false
integer x = 37
integer y = 824
integer width = 2798
integer height = 292
integer taborder = 40
string dataobject = "dw_fa_detalle_inventario"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_fa_ma_desglose
event ue_keydown pbm_dwnkey
event type integer ue_postitem ( long row,  dwobject dwo,  string data,  string columna )
event ue_enter pbm_dwnprocessenter
integer x = 37
integer y = 24
integer width = 2802
integer height = 680
integer taborder = 10
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;long 		ll_column
integer  li_columns
string	ls_colum, ls_column_name

ll_column = this.Getcolumn()
ls_colum	 = this.Getcolumnname()

if keydown(keyA!) then	
	if len(ls_colum)=2 then
//		messagebox("",this.getitemstring(this.getrow(),"tcodigo"+right(ls_colum,1)))
	else 
//		messagebox("",this.getitemstring(this.getrow(),"tcodigo"+right(ls_colum,2)))		
	end if
end if


if keydown(keyControl!) and keydown(keyS!) then
	setpointer(hourglass!)	
   cb_1.triggerevent(clicked!)		//Salvar Los Cambios	
	return 2
	setpointer(arrow!)	
end if

if keydown(keyControl!) and keydown(keyX!) then
   cb_salir.triggerevent(clicked!)		//Boton de salir
//	lb_cambio = false
//	close(parent)
end if

end event

event ue_postitem;Long 	   ll_cantidad, ll_fraccion, ll_canti_total, ll_row,ll_cant_exist, ll_disponible
Long		ll_cantidad_reserva,ll_cantidad_edit,ll_fraccion_edit,ll_total_unid_edit
Long		ll_tot_res_original,ll_tot_reserva_new
Long		ll_reserva_pedido, ll_tot_res_linea,ll_can_reserva_or,ll_frac_reserva_or, ll_can_reserva_lin, ll_frac_reserva_lin  	

Integer  li_pos, li_pos2, li_resultado
String	ls_codigo, ls_cod_color, ls_cod_tama, ls_cod_largo, ls_cod_grupo, ls_expresion, &
			ls_num_largo, ls_expresion_pedido,ls_fraccion,ls_cantidad, ls_filtro

lb_cambio = true

//is_unidad = dw_2.GetitemString(1,"prod_medida")
is_unidad = str_datos.unid_medida

if mid(is_col,1,1) = "c" or mid(is_col,1,1) = "f" then

	ls_codigo	=	dw_1.GetitemString(row,"tcodigo"+mid(is_col,2))

	//Extrae el numero de la casilla o largo
	ls_num_largo = mid(is_col,2) //mid(ls_codigos,li_pos2+1)			  		

	//Extrae la Cantidad y Fraccion Para Guardarla
	ll_cantidad 	= dw_1.Getitemnumber(row,"c"+ls_num_largo)
	ll_fraccion 	= dw_1.Getitemnumber(row,"f"+ls_num_largo)
	ll_canti_total = wf_convert_min(is_unidad,ll_cantidad,ll_fraccion)
		
	// pos(cadena_de_busqueda,cadena_a_buscar,pos_inicial)

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
	
	// Expresion para buscar en detalle de inventario
	
	ls_expresion = "prod_producto = '"+str_datos.producto+"' and mbde_cod_clase_tam = '"+str_datos.cod_clase_tam+"' and cod_color = '"+ls_cod_color+"' and cod_tama = '"+ls_cod_tama+"' and cod_largo = '"+ls_cod_largo+"'"
	sle_codigo.text = ls_cod_color+' '+ls_cod_tama+' '+ls_cod_largo
	//Verifica la existencia en inventario
	
	ll_row = dw_2.Find(ls_expresion,1,dw_2.Rowcount())
	ll_cant_exist = 0
	ll_cantidad_reserva = 0
	
	If ll_row >0 Then
	// las cantidades están en unidades mínimas
		ll_cant_exist 			= dw_2.getItemNumber(ll_row,"mbde_cantidad") //Doc
		ll_cantidad_reserva 	= dw_2.getItemNumber(ll_row,"mbde_reserva") //pzas
//		is_unidad = str_datos.unid_medida
	Else
		mensaje("Atención ","NO hay existencia disponible","")
		ls_fraccion = 'f'+mid(columna,2,len(columna) - 1)
		ls_cantidad = 'c'+mid(columna,2,len(columna) - 1)
		dw_1.SetItem(row,ls_cantidad,0)
		dw_1.SetItem(row,ls_fraccion,0)
		return 0
	End If
	
	// Toma la cantidad editada del dw_1 y convierte a unidad minima
	ll_cantidad_edit	 =  this.GetItemNumber(row, "c"+mid(is_col,2))
	ll_fraccion_edit	 =	 this.GetItemNumber(row, "f"+mid(is_col,2))

	if IsNull(ll_cantidad_edit) Then ll_cantidad_edit =0
	if IsNull(ll_fraccion_edit) Then ll_fraccion_edit =0
	if IsNull(ll_total_unid_edit) Then ll_total_unid_edit =0

	If (ll_cantidad_edit + ll_fraccion_edit) > 0 Then
		ll_total_unid_edit =  wf_convert_min(is_unidad,ll_cantidad_edit, ll_fraccion_edit)
	End If
	
	if IsNull(ll_cant_exist) Then ll_cant_exist =0
	
	If ll_cant_exist <> 0 then
//		ll_cant_exist = wf_convert_min(is_unidad,ll_cant_exist, 0)
	end if
	
	if IsNull(ll_cantidad_reserva) Then ll_cantidad_reserva =0

	//*******************************************************************
	// Cálculo de la reserva total del producto

	ls_filtro = "desg_producto = '"+str_datos.producto+"' and desg_cod_grupo_tam = '"+str_datos.cod_clase_tam+"' and desg_color = '"+ls_cod_color+"' and desg_cod_talla = '"+ls_cod_tama+"' and desg_largo = '"+ls_cod_largo+"'"

	dw_3.SetFilter(ls_filtro)
	dw_3.Filter()
	
	ls_expresion_pedido = "desg_producto = '"+str_datos.producto+"' and desg_linea = "+string(str_datos.renglon)+" and desg_cod_grupo_tam = '"+str_datos.cod_clase_tam+"' and desg_color = '"+ls_cod_color+"' and desg_cod_talla = '"+ls_cod_tama+"' and desg_largo = '"+ls_cod_largo+"'"
	ll_row = dw_3.Find(ls_expresion_pedido,1,dw_3.Rowcount()) 
	
	ll_reserva_pedido = 0
	ll_tot_res_linea = 0
	
	if dw_3.rowcount() > 0  then
		// Total unidades reservadas originales
		ll_can_reserva_or  = dw_3.GetItemNumber(1,"can_reserva_or")
		ll_frac_reserva_or = dw_3.GetItemNumber(1,"frac_reserva_or")
	
		if Isnull(ll_can_reserva_or)  then ll_can_reserva_or  = 0
		if Isnull(ll_frac_reserva_or) then ll_frac_reserva_or = 0
	
		if ll_can_reserva_or > 0 or ll_frac_reserva_or > 0 Then
			ll_reserva_pedido = wf_convert_min(is_unidad,ll_can_reserva_or, ll_frac_reserva_or)
		end If
		
		If ll_row > 0 then
			//Obtengo reserva de la línea
			ll_can_reserva_lin  = dw_3.GetItemNumber(ll_row,"can_reserva_or")
			ll_frac_reserva_lin = dw_3.GetItemNumber(ll_row,"frac_reserva_or")
	
			if Isnull(ll_can_reserva_lin) then ll_can_reserva_lin = 0
			if Isnull(ll_frac_reserva_lin) then ll_frac_reserva_lin = 0
	
			if ll_can_reserva_lin > 0 or ll_frac_reserva_lin > 0 then
				ll_tot_res_linea = wf_convert_min(is_unidad,ll_can_reserva_or, ll_frac_reserva_or)
			end if
		End If
	end if

	// reserva total del pedido = res original - reserva de la linea 
	ll_reserva_pedido = ll_reserva_pedido - ll_tot_res_linea 
	
	//************Calcula cantidad disponible en inventario *************	
	ll_disponible = ll_cant_exist - ll_cantidad_reserva - ll_reserva_pedido // En unidades
	//*******************************************************************
	
	//Conviete las unidades mínimas a  Cantidad y piezas
	If ll_total_unid_edit <= ll_disponible then
		wf_convert_uni(is_unidad,ll_total_unid_edit,ll_cantidad_edit,ll_fraccion_edit)
	else
		wf_convert_uni(is_unidad,ll_disponible,ll_cantidad_edit,ll_fraccion_edit)
		mensaje("Atención ","Sólo quedan "+string(ll_disponible)+' unidades disponibles',"")
	end if
	//Setea las cantidades disponibles en el dw de captura
	if ll_fraccion_edit < 0 then ll_fraccion_edit =0
	if ll_fraccion_edit < 0 then ll_fraccion_edit =0
	
	ls_fraccion = 'f'+mid(columna,2,len(columna) - 1)
	ls_cantidad = 'c'+mid(columna,2,len(columna) - 1)
	dw_1.SetItem(row,ls_cantidad,ll_cantidad_edit)
	dw_1.SetItem(row,ls_fraccion,ll_fraccion_edit)
	If ll_total_unid_edit > ll_disponible then
		dw_1.SetColumn(columna)
	end If

	//Expresion para buscar en el detalle del pedido dw_4 que contiene la linea del pedido										desg_cod_grupo_tam												desg_color									desg_cod_talla									desg_largo
	//Si existe se regraba sino, se inserta   									desg_linea   
		
	ls_expresion_pedido = "desg_producto = '"+str_datos.producto+"' and desg_linea = "+string(str_datos.renglon)+" and desg_cod_grupo_tam = '"+str_datos.cod_clase_tam+"' and desg_color = '"+ls_cod_color+"' and desg_cod_talla = '"+ls_cod_tama+"' and desg_largo = '"+ls_cod_largo+"'"

	wf_actualiza_dw_pedido('4',dw_4,ls_expresion_pedido,ll_cantidad_edit,ll_fraccion_edit,ls_cod_tama,ls_cod_largo,ls_cod_color)

	dw_3.SetFilter("")
	dw_3.Filter()
	
	// Actualiza dw_3 el cual contiene la totalidad del pedido
	wf_actualiza_dw_pedido('3',dw_3,ls_expresion_pedido,ll_cantidad_edit,ll_fraccion_edit,ls_cod_tama,ls_cod_largo,ls_cod_color)
end if

return 1
end event

event ue_enter;send(handle(this),256,9,long(0,0))
return 1
end event

event itemchanged;string ls_columna 
ls_columna = This.GetColumnName()

If mid(ls_columna,1,1) = 'f' Then
	il_fraccion 	= dw_1.Getitemnumber(row,ls_columna)
End If
If  mid(ls_columna,1,1) = 'c' Then
	il_canti    	= dw_1.Getitemnumber(row,ls_columna)
End If

this.Post event ue_postitem(row, dwo, data,ls_columna)
end event

event editchanged;lb_cambio = true

is_col = This.GetColumnName()
sle_total_c.text = string(dw_1.GetItemNumber(1,"STotal_c"))
sle_total_f.text = string(dw_1.GetItemNumber(1,"STotal_f"))

end event

type st_4 from statictext within w_fa_ma_desglose
integer x = 1952
integer y = 712
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

type st_5 from statictext within w_fa_ma_desglose
integer x = 2226
integer y = 712
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

