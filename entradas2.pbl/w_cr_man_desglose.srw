//objectcomments  
forward
global type w_cr_man_desglose from window
end type
type st_1 from statictext within w_cr_man_desglose
end type
type em_fraccion from editmask within w_cr_man_desglose
end type
type st_2 from statictext within w_cr_man_desglose
end type
type em_cantidad from editmask within w_cr_man_desglose
end type
type cb_2 from commandbutton within w_cr_man_desglose
end type
type cb_1 from commandbutton within w_cr_man_desglose
end type
type dw_4 from datawindow within w_cr_man_desglose
end type
type dw_2 from datawindow within w_cr_man_desglose
end type
type dw_1 from datawindow within w_cr_man_desglose
end type
type dw_3 from datawindow within w_cr_man_desglose
end type
end forward

global type w_cr_man_desglose from window
string tag = "Salvar (Control + S)     Salvar y Salir (Control + X)"
integer x = 247
integer y = 388
integer width = 3232
integer height = 1052
boolean titlebar = true
windowtype windowtype = response!
long backcolor = 79741120
event ue_postopen ( )
event ue_dwnkey pbm_dwnkey
event ue_syscommand pbm_syscommand
st_1 st_1
em_fraccion em_fraccion
st_2 st_2
em_cantidad em_cantidad
cb_2 cb_2
cb_1 cb_1
dw_4 dw_4
dw_2 dw_2
dw_1 dw_1
dw_3 dw_3
end type
global w_cr_man_desglose w_cr_man_desglose

type variables
long	il_largos, il_color, il_yy, il_tallas, ia_multiplos[], &
	il_canti, il_fraccion
string	ia_largos[], ia_taman[], ia_codigos[], is_col
integer	ii_linea
boolean	lb_cambio = false, ib_no_cerrar, ib_cerrar, &
	ib_syscommand

str_in_desglose	str_desglose
str_detalles	str_datos

end variables

forward prototypes
public subroutine wf_create_texto ()
public function integer wf_setear_colores ()
public function integer wf_setear_largos ()
public function integer wf_proteger_campos ()
public function integer wf_habilitar_existentes ()
public subroutine wf_convert_uni (string as_med, long al_fracciones, ref long al_cantidad, ref long al_fraccion)
public subroutine wf_scroll_a_disponibles (datawindow aldw_3, string as_cod_color, string as_cod_tama, string as_cod_largo)
public function string wf_find_grupo ()
public function integer wf_setear_asignadas ()
public function integer wf_valida_cantidad (datawindow adw_dw1, long al_linea, string as_vienede, string as_cod_color, string as_cod_tama, string as_cod_largo, string as_cod_grupo)
public function integer wf_convierte_a_uni_disponibles (datawindow adw_dw, integer ai_row, string as_unidad, long al_asignada, long al_disponible)
public function integer wf_setear_disponibles (long al_filas)
public subroutine wf_create_dw ()
public function integer wf_setear_cantidades (long al_filas)
public function long wf_convert_min (string as_med, long al_cantidad, long al_fraccion)
public function integer wf_guardar ()
public subroutine wf_recuperar ()
end prototypes

event ue_postopen;integer	li_fil, li_col

str_datos = Message.PowerObjectParm

em_cantidad.text = string(str_datos.cantidad_max)
em_fraccion.text = string(str_datos.fraccion_max)

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_4.settransobject(sqlca)

dw_2.retrieve(str.g_financiero,str.empresa,str_datos.producto,str_datos.parte,str_datos.cod_color)

if dw_2.rowcount() < 1 then
	messagebox("Colores/Largos/Tamaños no Asignados a esta Referencia.",&
	"A este producto no se le puede procesar el desglose.",StopSign!)
	closewithreturn(this,1)
   return
end if

this.title = str_datos.titulo

wf_create_dw()

// Recupera los valores de la tabla de crdcanoc para cargar la matriz

wf_recuperar()

// Gianni Araúz (29/03/2000)
// Pasar la información de la ventana de Pase y proteger las columnas con valor cero o nulo

if str_datos.opcion = 'PEA' then
	w_cz_pases_confirmacion.dw_5.sharedata(dw_4)
else
	wf_recuperar()
	w_cz_ma_confirmacion.dw_2.sharedata(dw_4)
end if

dw_1.setfocus()

setpointer(arrow!)

end event

event ue_dwnkey;// Activa salvar y salir de la ventana de desglose

// Modificado por Gianni Araúz (27/03/2000)
// Para el caso del Pase de Entradas Anticipadas

if keydown(keyControl!) and keydown(keyS!) then
   cb_1.triggerevent(clicked!)	// Salvar los Cambios
	return 2
end if

if keydown(keyControl!) and keydown(keyX!) then
	if str_datos.opcion = 'PEA' then
		cb_1.triggerevent(clicked!)
//		dw_1.accepttext()
//		w_cz_pases_confirmacion.dw_3.setitem(str_datos.renglon,"dcof_cant1",&
//		dw_1.getitemnumber(1,"Stotal_f"))
//		closewithreturn(this,dw_1.getitemnumber(1,"Stotal_c"))
	else
		cb_1.triggerevent(clicked!)
	end if
end if

end event

event ue_syscommand;// Gianni Araúz (04/04/2000)


//if commandtype = 61536 then
//	ib_syscommand = true
//	if str_datos.opcion = 'PEA' then
//		dw_1.accepttext()
//		closewithreturn(this,dw_1.getitemnumber(1,"Stotal_c"))
//	else
//		close(this)
//	end if
//end if

end event

public subroutine wf_create_texto ();string	ls_textos, ls_resultado = "", ls_text = "", ls_font = ''
long		ll_y = 20, ll_x = 512, ll_width = 231, i=1, ll_ancho=0, ll_cant_largos, ll_multiplo, &
			ll_total_tallas, ll_sesgo = 0

ll_total_tallas = il_tallas

ll_cant_largos = il_largos

// Ancho de los Largos "231"

//	if w_fa_fondo.str_para.titulo_abreviado = 1 then
//		ls_font = " font.height='-8' "
//	else
		ls_font = " font.height='-7' "
//	end if

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

public function integer wf_setear_largos ();long		i, ll_row, ll_row2=1, ll_lineas=0, j=0, k=0, l=0, ll_cantidad
string	ls_cod_tama, ls_cod_largo, ls_expresion, ls_cod_color, ls_lar_abreviado  = ' ', &
			ls_tam_abreviado = ' '

ll_lineas = dw_2.Rowcount()

for i = 1 to ll_lineas
	
	ls_cod_largo	=	dw_2.Getitemstring(i,"cod_largo")
	ls_cod_tama		=	dw_2.Getitemstring(i,"cod_tama")
	ls_cod_color	=	dw_2.Getitemstring(i,"cod_color")
	
//	ls_expresion 	=	"cod_color = '"+ls_cod_color+"' and cod_tama = '"+ls_cod_tama+"' and cod_largo = '"+ls_cod_largo+"'"

	ls_expresion	=	"cod_tama = '"+ls_cod_tama+"' and cod_largo = '"+ls_cod_largo+"'"
	//"cod_color = '"+ls_cod_color+"' and 
	
	j ++
	//if w_fa_fondo.str_para.titulo_abreviado = 1 then
		ls_lar_abreviado =	dw_2.Getitemstring(i,"alar_abrev")	
		if isnull(ls_lar_abreviado) then ls_lar_abreviado = ' '
		ia_largos[j]     =  ls_lar_abreviado //Inserta la abreviatura de largo en el Arreglo
//	else
//		ia_largos[j]    =  dw_2.Getitemstring(i,"descrip_largo")	//Inserta el nombre del largo en el Arreglo
//	end if
	//Para setear los tamaños o tallas
	if i = 1 then
		k ++
	//	if w_fa_fondo.str_para.titulo_abreviado = 1  then
			ls_tam_abreviado=  dw_2.Getitemstring(i,"atam_abrev")
			if isnull(ls_tam_abreviado) then ls_tam_abreviado = ' '
			ia_taman[k]     =  ls_tam_abreviado	//Inserta el tamaño abreviado en el Arreglo
	//	else
		//	ia_taman[k]     =  dw_2.Getitemstring(i,"descrip_tama")	//Inserta el nombre del tamaño en el Arreglo
	//	end if
		//Setea los Multiplos o cantidad de ocurrencias de los cargos para un tamaño
		l ++
		ia_multiplos[k] =  l 		
	else
		if dw_2.getitemstring(i -1,"cod_tama") <> ls_cod_tama then
			k ++
		//	if w_fa_fondo.str_para.titulo_abreviado = 1 then
				ia_taman[k]     =  dw_2.Getitemstring(i,"atam_abrev")	//Inserta el tamaño abreviado en el Arreglo
//			else
//				ia_taman[k]     =  dw_2.Getitemstring(i,"descrip_tama")	//Inserta nombre del tamaño en el Arreglo
//			end if
			//Setea los Multiplos o cantidad de ocurrencias de los cargos para un tamaño
			l=0			
			l ++
			ia_multiplos[k] =  l 			
		else
			//Setea los Multiplos o cantidad de ocurrencias de los cargos para un tamaño
			l ++
			ia_multiplos[k] =  l 
		end if
	end if
		
	ll_row = dw_2.Find(ls_expresion,ll_row2 ,ll_lineas)
	
	ll_row2 = ll_row
	
//	do While ll_row > 0
//		
//		//Guarda el codigo de tamaño y largo en el arreglo, Para Proteger
//		ls_cod_color			=	dw_2.Getitemstring(ll_row,"cod_color")
//		ll_cantidad				=	0
//		
//		//dw_2.GetitemNumber(ll_row,"cantidad") //poner
//		
//		ia_codigos[ll_row]	=	string(ll_cantidad)+" "+ls_cod_color+" "+ls_cod_tama + " "+ls_cod_largo+" "+string(j)
//		
//		if ll_row2 + 1 > ll_lineas then
//			exit
//		end if
//		
		ll_row =	dw_2.Find(ls_expresion,ll_row2 + 1 ,ll_lineas)	
		if ll_row > 0 then
			i = ll_row
			ll_row2 	=  ll_row
		end if
//	loop

next
j = 0
for i = 1 to ll_lineas
	j ++
	ls_cod_largo	=	dw_2.Getitemstring(i,"cod_largo")
	ls_cod_tama		=	dw_2.Getitemstring(i,"cod_tama")
	ls_cod_color	=	dw_2.Getitemstring(i,"cod_color")
	
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
string  ls_cod_color, ls_cod_color2, ls_num_largo, ls_unidad
long	  ll_lineas, ll_tot_codigos, ll_cantidad, ll_canti, ll_fraccion

ll_lineas = dw_1.Rowcount()
ll_tot_codigos = upperbound(ia_codigos)

//ls_unidad		=	dw_2.Getitemstring(1,"unidad_venta") //Unidad de Venta
ls_unidad = 'PZ'
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
//			  dw_1.Setitem(i,"p"+ls_num_largo,0)
			  dw_1.Setitem(i,"tcodigo"+ls_num_largo,ia_codigos[j])
		  	  dw_1.Setitem(i,"c"+ls_num_largo,0)
  			  dw_1.Setitem(i,"f"+ls_num_largo,0)
		     if isnull(dw_1.getitemnumber(i,"c"+ls_num_largo)) then
				  messagebox("Es nulo",ls_num_largo)
			  end if			  
//			  ll_cantidad  = long(left(ia_codigos[j],pos(ia_codigos[j]," ")-1))
			  //Función que convierte a la unidad de medida
//			  wf_convert_uni(ls_unidad,ll_cantidad,ll_canti,ll_fraccion)
//			  dw_1.Setitem(i,"c"+ls_num_largo,ll_canti)
// 		  dw_1.Setitem(i,"f"+ls_num_largo,ll_fraccion)
 		  end if
	 next
next

return 1

end function

public subroutine wf_convert_uni (string as_med, long al_fracciones, ref long al_cantidad, ref long al_fraccion);/*Esta Función Convierte de Unidad Minima a la Unidad que se Quiere*/
//Llamada desde: wf_habilita_existentes()

Double ld_total,ld_ucom, ld_mconvera,ld_frac

 
/*Extrae la Unidad comun "Peso/Unidades/etc "*/
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

public subroutine wf_scroll_a_disponibles (datawindow aldw_3, string as_cod_color, string as_cod_tama, string as_cod_largo);//Dirige el cursor del dw3 al producto actual
//Lamada desde: itemfocuschanged del dw1, ue_postitem

string  ls_expresion
Long    ll_row
Integer li_resultado

//ls_expresion = "linea = "+string(ii_linea)+" and cod_color = '"+as_cod_color+"' and cod_tama = '"+as_cod_tama+"' and cod_largo = '"+as_cod_largo+"'" 

//messagebox("",ls_expresion)

//ll_row = aldw_3.Find(ls_expresion,1,aldw_3.Rowcount())
////messagebox("Scroll to --> ",string(ll_row) +" de "+string(aldw_5.rowcount()))
//
//if ll_row > 0 then
//	li_resultado = aldw_3.Scrolltorow(ll_row)
//else
//	gf_mensaje("","No Pudo Encontrar el Producto Actual",1,1,"E")
//end if
//
end subroutine

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

public function integer wf_setear_asignadas ();//Setea las Cantidades Asignadas, Para todos los Campos
if dw_3.Rowcount() < 1 then return 1

Integer  i
Long		ll_cantidad, ll_asignada, ll_disponible, ll_linea
string   ls_unidad

ls_unidad =	dw_2.getitemstring(1,"unidad_venta")

for i = 1 to dw_3.Rowcount() - 1 //Para que no contemple el insertado al final
	
	ll_linea 	= dw_3.GetitemNumber(i,"linea") 
	
	if str_desglose.linea_ori = ll_linea then	//Si Pertenece a la Misma Linea, Setea
	
		ll_asignada 	= dw_3.GetitemNumber(i,"asignada")
		ll_disponible 	= dw_3.Getitemnumber(i,"cant_disponible")
	   ll_asignada 	+= ll_disponible
		dw_3.Setitem(i,"asignada",ll_asignada)
		dw_3.Setitem(i,"cant_disponible",0)
		//Distribuye lo disponible y lo asignado en Cantidad y Fraccion
		wf_convierte_a_uni_disponibles(dw_3,i,ls_unidad,ll_asignada ,0)

	end  if

Next

return 1

end function

public function integer wf_valida_cantidad (datawindow adw_dw1, long al_linea, string as_vienede, string as_cod_color, string as_cod_tama, string as_cod_largo, string as_cod_grupo);//Funciòn que valida la Cantidad Que se Introdujo y Setea la Cantidad que Queda Disponible
//Llamada desde: ue_postitem

Long        ll_cantidad, ll_fraccion, ll_total, ll_disponible, ll_asignada, ll_cant_anterior
Integer     li_linea, li_row
String		ls_producto, ls_unidad, ls_expresion
double		ld_peso,ld_cubicaje

//messagebox("columna",is_col)

	ll_cantidad	 =  adw_dw1.GetItemNumber(al_linea, "c"+mid(is_col,2))
	ll_fraccion	 =	 adw_dw1.GetItemNumber(al_linea, "f"+mid(is_col,2))
	ls_unidad    =  dw_2.Getitemstring(al_linea, "unidad_venta")
	ll_total		 =  wf_convert_min(ls_unidad,ll_cantidad, ll_fraccion)

	if ll_total = 0 then 
	//	gf_mensaje("","La Cantidad está en 0, al Salvar El Registro Será Eliminado",1,1,"E")
	end if
	
	ll_cant_anterior 	=  wf_convert_min(ls_unidad,il_canti, il_fraccion) //Cargadas en el Itemfocuschanged

	ls_expresion 		=  "cod_color = '"+as_cod_color+"' and cod_tama = '"+as_cod_tama+"' and cod_largo = '"+ &
								as_cod_largo + "' and cod_grupo_tam = '"+as_cod_grupo+"'"
	
//	messagebox("",ls_expresion)
//	messagebox("",dw_3.describe("datawindow.Syntax"))
	
	//Busca en el DW4
	li_row		 		=  dw_3.Find(ls_expresion,1,dw_3.Rowcount())
	
	if li_row > 0 then  //Si encuentra el Articulo en el dw4 Pedido
	
		ll_disponible = dw_3.Getitemnumber(li_row, "cant_disponible")
		
		ll_asignada	  = dw_3.Getitemnumber(li_row, "asignada")		
		
		if ll_disponible + ll_cant_anterior >= ll_total then
			
			dw_3.Setitem(li_row, "cant_disponible", ll_disponible + ll_cant_anterior - ll_total)
			dw_3.Setitem(li_row, "asignada" , ll_asignada - ll_cant_anterior + ll_total)
			//Distribuye lo disponible y lo asignado en Cantidad y Fraccion
			wf_convierte_a_uni_disponibles(dw_3,li_row,ls_unidad, ll_asignada - ll_cant_anterior + ll_total ,ll_disponible + ll_cant_anterior - ll_total)
		else
			gf_mensaje("","La Cantidad, Ha Sobrepasado lo Disponible",1,1,"E")
			
			if as_vienede = "CANTI" then
				adw_dw1.Setitem(al_linea,"c"+mid(is_col,2),0)
				//Se actualizan lo disponible y lo asignado sumando lo de la Fraccion
				dw_3.Setitem(li_row, "cant_disponible", ll_disponible + ll_cant_anterior - ll_fraccion)
				dw_3.Setitem(li_row, "asignada", ll_asignada - ll_cant_anterior + ll_fraccion)
				//Distribuye lo disponible y lo asignado en Cantidad y Fraccion
				wf_convierte_a_uni_disponibles(dw_3,li_row,ls_unidad,ll_asignada - ll_cant_anterior + ll_fraccion ,ll_disponible + ll_cant_anterior - ll_fraccion)
			else
				adw_dw1.Setitem(al_linea,"f"+mid(is_col,2),0)
				//Se actualizan lo disponible y lo asignado sumando lo de la Cantidad
				ll_total				=  wf_convert_min(ls_unidad,ll_cantidad, 0)
				dw_3.Setitem(li_row, "cant_disponible", ll_disponible + ll_cant_anterior - ll_total)
				dw_3.Setitem(li_row, "asignada", ll_asignada - ll_cant_anterior + ll_total)
				//Distribuye lo disponible y lo asignado en Cantidad y Fraccion
				wf_convierte_a_uni_disponibles(dw_3,li_row,ls_unidad,ll_asignada - ll_cant_anterior + ll_total ,ll_disponible + ll_cant_anterior - ll_total)
			end if	
			
			return -1
			
		end if
	else
		gf_mensaje("","No Pudo Rebajar la Cantidad Disponible, Verifique.",1,1,"E")
		return -1
	end if
return 1
end function

public function integer wf_convierte_a_uni_disponibles (datawindow adw_dw, integer ai_row, string as_unidad, long al_asignada, long al_disponible);//Para mostrar lo Asignado y lo disponible en Cantidad Fraccion
//Llamado desde: wf_valida_cantidad()

Long  ll_cant_asig=0, ll_frac_asig=0, ll_cant_disp=0, ll_frac_disp=0
	wf_convert_uni(as_unidad,al_asignada,ll_cant_asig, ll_frac_asig) //Conv. lo Asignado
	adw_dw.Setitem(ai_row,"cant_asig",ll_cant_asig)	
	adw_dw.Setitem(ai_row,"frac_asig",ll_frac_asig)	
	wf_convert_uni(as_unidad,al_disponible,ll_cant_disp, ll_frac_disp)//Conv. lo Disponible
	adw_dw.Setitem(ai_row,"cant_disp",ll_cant_disp)	
	adw_dw.Setitem(ai_row,"frac_disp",ll_frac_disp)			

return 1
end function

public function integer wf_setear_disponibles (long al_filas);//Recorre el dw y setea las cantidades en el dw2 que es el basico para armar el dw1
if al_filas < 1 then return 1
integer i
string  ls_expresion, ls_color, ls_tama, ls_largo, ls_cod_grupo
long    ll_row, ll_linea, ll_cantidad
for i = 1 to dw_2.Rowcount()
	dw_2.Setitem(i,"cantidad",0)
next

for i = 1 to al_filas
	
	ls_color		 =	dw_3.Getitemstring(i,"cod_color")
	ls_tama		 =	dw_3.Getitemstring(i,"cod_tama")	
	ls_largo		 =	dw_3.Getitemstring(i,"cod_largo")	
	ls_cod_grupo = dw_3.Getitemstring(i,"cod_grupo_tam")
	ll_linea		 = dw_3.GetitemNumber(i,"linea")
	ll_cantidad	 = dw_3.GetitemNumber(i,"cant_disponible")
	
	ls_expresion = "linea = "+string(ll_linea)+" and cod_color = '"+ls_color+"' and cod_tama = '"+ls_tama+"'"+&
						" and cod_largo = '"+ls_largo+"' and grupo_tam = '"+ls_cod_grupo+"'"

	ll_row = dw_2.Find(ls_expresion,1,dw_2.Rowcount())
	
	if ll_row > 0 then
		dw_2.Setitem(ll_row,"cantidad",ll_cantidad)
	end if
	
next

return 1
end function

public subroutine wf_create_dw ();long		ll_y = 7,  ll_x = 400, ll_x_texto = 260, ll_width = 133, ll_band_detail = 600, &
			ll_contador=0, ll_inicial[], ll_resp_x, ll_resp_y, ll_resp_i
String	ls_column_name, ls_dw_propiedades, is_sql, ls_syntaxis, ls_err, ls_describe, &
			ls_format, ls_editmask, ls_resultado='', la_inicial[], ls_suma_c, ls_suma_f
Integer	li_columns, li_i, li_height, li_height_max, i, j=0
Boolean	lb_height

// Inicialización de los arreglos utilizados

ia_largos[]    = la_inicial[]
ia_taman[]	   = la_inicial[]
ia_codigos[]   = la_inicial[]
ia_multiplos[] = ll_inicial[]

// Para Setear los Textos de los Largos en el arreglo
wf_setear_largos()

il_largos = UpperBound(ia_largos)
il_tallas = UpperBound(ia_taman)

// Gianni Araúz (16/02/2000)
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

is_sql = is_sql +" FROM cracolor "

ls_syntaxis = sqlca.SyntaxFromSQL(is_sql,"style(type=Tabular) datawindow(color = 79416533) ",ls_err)

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

/* (-1-) */

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

if Len(ls_err) > 0 then
	dw_1.SetRedraw(true)
	messagebox("Error 1",ls_err)
	Return
end if

dw_1.Create(ls_syntaxis,ls_err)	//CREA EL DW 

If Len(ls_err) > 0 Then 
	dw_1.SetRedraw(True)	
	messagebox("Error 2",ls_err)
	Return
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
			
	if mid(ls_column_name,1,1) = "f" then		// Si es un campo de Fracción
		ll_x += 138				// Separación entre la cantidad y la fracción
		ll_width = 85
		if str_datos.med_cant = 1 then
			ll_width = 0
		end if
		ls_format = '##0'
		ls_editmask = '###'
	elseif mid(ls_column_name,1,1) = "c" then	// Si es un campo de Cantidad
		ls_format = '#####0'
		ls_editmask = '######'
		ll_x += 115				// Separación entre la fracción y la siguiente Cantidad
		ll_width = 133
		if str_datos.med_cant = 1 then
			ll_width += 85
		end if
		
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

/* Adición 24/08/99 */
	
/* Establece la posición y el formato para el total de una fila (Cantidad entera) */
ls_format = '######'
ll_x += 115
ll_width = 150

if str_datos.med_cant = 1 then
	ll_width += 85
end if

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

/* Establece la posición y el formato para el total de una fila (Cantidad Fracción)*/
ll_x += 158				// Separación entre la cantidad y la fracción
ll_width = 85
if str_datos.med_cant = 1 then
	ll_width = 0
end if
ls_format = '###'
ls_dw_propiedades = ls_dw_propiedades + "Total_f.x='"+string(ll_x)+"' "
ls_dw_propiedades = ls_dw_propiedades + "Total_f.width='"+string(ll_width)+"' "
ls_dw_propiedades = ls_dw_propiedades + "Total_f.format= '"+ls_format+"' "
/* Establece la posición y el formato para el total del pie de página para 
	la Columna de Total por fila (Fracción)*/
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
end if

//Agrandar el tamaño del Header
dw_1.Modify("DataWindow.Header.Height='152'")
dw_1.Modify("DataWindow.Footer.Height='94'")
dw_1.Modify("DataWindow.detail.Height='68'")

wf_create_texto()

//Para setear los colores e Insertar la Cantidad de Colores
wf_setear_colores()

//wf_proteger_campos()

wf_habilitar_existentes()

ls_describe = dw_1.Describe("datawindow.syntax")

//Ancho del DW
//if ll_x_texto + 350  <= 2396  then //<= 1116 sin el despliegue de lo disponible
//	dw_1.width = 2500
//else
//	dw_1.width = ll_x_texto + 350
//end if
//
if dw_1.Width > 3000 then
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

//Ancho de la Ventana
//if ll_x_texto + 450 < 2619 then			//< 1339 sin el despliegue de los disponible
//	This.Width = 2619
//else
//	This.Width = ll_x_texto + 450
//end if

dw_1.Setfocus()

//Ubica la Ventana en el Centro
// gf_center_win(this)

//Para mostrar la ventana
this.show()

end subroutine

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

public function long wf_convert_min (string as_med, long al_cantidad, long al_fraccion);/*Esta función recibe la cantidad y fracción y retorna todo convertido a fracción*/
//Llamada desde: retrieveend del DW 4, wf_validar_cantidad()

Long	ll_ucom, ld_mconvera, ll_total

/*Extrae la Unidad comun "Pedo/Unidades/etc "*/
ll_ucom = gf_medi_prod(as_med)

/*Retorna el Factor de Conversión a unidades mínimas*/
ld_mconvera = gf_unidad_venta(as_med, ll_ucom)

If ld_mconvera <= 0 Then ld_mconvera = 1

ll_total = (al_cantidad * ld_mconvera) + al_fraccion

Return (ll_total)

end function

public function integer wf_guardar ();// Para Guardar los Cambios en Fademdes
// Llamada desde: ue_keydown()
// Modificado por Gianni Araúz (28/04/2000)


string	ls_cod_color, ls_campo, ls_cod_tama, ls_cod_largo, ls_codigo, &
			ls_column_name, ls_expresion, ls_unidad, ls_cod_grupo
integer	i, j, k=0, li_columns, li_pos, li_pos2=1, li_resultado
long		ll_row, ll_fila, ll_canti_total, ll_fraccion, ll_cantidad, ll_cantpase, ll_cantpend
long		ll_cant_ant

dw_1.accepttext()

li_columns = integer(dw_1.Describe("DataWindow.Column.Count"))

for i = 1 to dw_1.Rowcount()
	k = 0
	for j = 3 to li_columns
		
		ls_column_name = dw_1.Describe("#" + string(j) + ".Name")
		
		// RECUPERA EL NOMBRE DE LA COLUMNA
		if mid(ls_column_name,1,1)	= 'f' then
			k ++
			// Si el campo está protegido, que siga con el siguiente
			if dw_1.getitemNumber(i,"p"+string(k)) = 1 then continue
			
			// Extrae la Cantidad y Fracción para Guardarla
			ll_cantidad = dw_1.Getitemnumber(i,"c"+string(k))
			ll_fraccion = dw_1.Getitemnumber(i,"f"+string(k))		
			
			// ll_canti_total = wf_convert_min(ls_unidad,ll_cantidad,ll_fraccion)
			
			ls_codigo = '  '
			ls_codigo = dw_1.Getitemstring(i,"tcodigo"+string(k))
			
			li_pos	 = pos(ls_codigo," ",1)
			li_pos2	 = li_pos
			li_pos	 = pos(ls_codigo," ",li_pos2 + 1)
			
			//Extrae el código del color
			ls_cod_color = mid(ls_codigo,li_pos2 + 1, li_pos - li_pos2 - 1 )
			li_pos2   = li_pos
			li_pos	 = pos(ls_codigo," ",li_pos2 + 1)
			
			//Extrae el código del tamaño
			ls_cod_tama = mid(ls_codigo,li_pos2 + 1, li_pos - li_pos2 - 1 )
			
			li_pos2   = li_pos
			li_pos	 = pos(ls_codigo," ",li_pos2 + 1)
			
			// Extrae el código del largo
			    
			ls_cod_largo = mid(ls_codigo,li_pos2 + 1, li_pos - li_pos2 - 1 )					
			
			// Se extrae el código de grupo, del dw2
			ls_cod_grupo = wf_find_grupo()
			
			ls_expresion = "dcoc_renglon = "+string(str_datos.renglon)+" and dcoc_color = '"&
								+ls_cod_color+ "' and dcoc_cod_tamano = '"&
								+ls_cod_tama+"' and dcoc_largo = '"+ls_cod_largo+"'"
			
			// Es la Línea del Empaque
			ll_row = dw_4.Find(ls_expresion,1,dw_4.Rowcount())
			
			if ll_row > 0 then
				li_resultado = dw_4.Scrolltorow(ll_row)
				
				// Gianni Araúz (03/04/2000)
				// Aumentar o disminuir la Cantidad de Pase o Pendiente
				
				if str_datos.opcion = 'PEA' then
					if ll_cantidad >= 0 then
						ll_cantpend = dw_4.object.dcoc_cant_pendiente[ll_row]
						
						if isnull(ll_cantpend) then ll_cantpend = 0
						
						ll_cantpase = dw_4.object.dcoc_cant_pase[ll_row]
						
						if isnull(ll_cantpase) then ll_cantpase = 0
						
						dw_4.setitem(ll_row,'dcoc_ultimo_pase',ll_cantidad)
						
						ll_cantpend -= ll_cantidad	// Gianni validar
						ll_cantpase += ll_cantidad
						
						dw_4.setitem(ll_row,'dcoc_cant_pendiente',ll_cantpend)
						dw_4.setitem(ll_row,'dcoc_cant_pase',ll_cantpase)
					else
						messagebox('Atención','Cantidad de Desglose no puede ser menor que cero',Exclamation!)
					end if
				else
					ll_cant_ant = dw_4.getitemnumber(ll_row,'dcoc_cantidad')
					ll_cantpend = dw_4.getitemnumber(ll_row,'dcoc_cant_pendiente')
					if isnull(ll_cant_ant) then ll_cant_ant = 0
					if isnull(ll_cantpend) then ll_cantpend = 0
					ll_cantpend = ll_cantpend + ll_cantidad - ll_cant_ant
					dw_4.setitem(ll_row,"dcoc_cant_pendiente",ll_cantpend)
					dw_4.setitem(ll_row,"dcoc_cantidad",ll_cantidad)
					dw_4.setitem(ll_row,"dcoc_cant1",ll_fraccion)
				end if
			else
				if not ((ll_cantidad = 0 or isnull(ll_cantidad)) and &
				(ll_fraccion = 0 or isnull(ll_fraccion))) then
					dw_4.scrolltorow(dw_4.insertrow(0))
					ll_fila = dw_4.getrow()
					dw_4.setitem(ll_fila,"dcoc_g_financiero",str.g_financiero)
					dw_4.setitem(ll_fila,"dcoc_empresa",str.empresa)
					dw_4.setitem(ll_fila,"dcoc_num_conf_oc",str_datos.concepto)
					dw_4.setitem(ll_fila,"dcoc_num_oc",1)
					dw_4.setitem(ll_fila,"dcoc_producto",str_datos.producto)
					dw_4.setitem(ll_fila,"dcoc_anno_oc",year(date(str_datos.fecha)))
					dw_4.setitem(ll_fila,"dcoc_num_renglon_oc",str_datos.renglon)
					dw_4.setitem(ll_fila,"dcoc_renglon",str_datos.renglon)
					dw_4.setitem(ll_fila,"dcoc_cod_clase_tam",ls_cod_grupo)
					dw_4.setitem(ll_fila,"dcoc_cod_tamano",ls_cod_tama)
					dw_4.setitem(ll_fila,"dcoc_codigo_tamano",ls_cod_tama)
					dw_4.setitem(ll_fila,"dcoc_largo",ls_cod_largo)
					dw_4.setitem(ll_fila,"dcoc_codigo_largo",ls_cod_largo)
					dw_4.setitem(ll_fila,"dcoc_color",ls_cod_color)
					dw_4.setitem(ll_fila,"dcoc_unidad_medida",str_datos.unid_medida)
					dw_4.setitem(ll_fila,"dcoc_board",str_datos.parte)
					
					// Gianni Araúz (04/04/2000)
					ll_cant_ant = dw_4.getitemnumber(ll_fila,'dcoc_cantidad')
					ll_cantpend = dw_4.getitemnumber(ll_fila,'dcoc_cant_pendiente')
					if isnull(ll_cant_ant) then ll_cant_ant = 0
					if isnull(ll_cantpend) then ll_cantpend = 0
					if ll_cantidad < ll_cant_ant then
						messagebox('Atención','Cantidad no puede ser menor que la utilizada '+&
										'en el Pase.',Exclamation!)
						return -1
					end if
					
					dw_4.setitem(ll_row,'dcoc_ultimo_pase',ll_cantidad)
					
					ll_cantpend = ll_cantpend + ll_cantidad - ll_cant_ant
					dw_4.setitem(ll_fila,"dcoc_cant_pendiente",ll_cantpend)
					// Fin Gianni
					
					dw_4.setitem(ll_fila,"dcoc_cantidad",ll_cantidad)
					dw_4.setitem(ll_fila,"dcoc_cant1",ll_fraccion)
					dw_4.accepttext()
				end if
			end if
			
		end if
	next
next

return 1

end function

public subroutine wf_recuperar ();// Para  los Cambios en crdcanoc
// Llamada desde: ue_keydown()


string	ls_cod_color, ls_campo, ls_cod_tama, ls_cod_largo, ls_codigo, &
			ls_column_name, ls_expresion, ls_unidad, ls_cod_grupo
integer	i, j, k=0, li_columns, li_pos, li_pos2=1, li_resultado
Long		ll_row, ll_fila, ll_canti_total, ll_fraccion, ll_cantidad

dw_1.accepttext()

dw_4.retrieve(str.g_financiero,str.empresa,str_datos.concepto,str_datos.anio,&
					str_datos.renglon,str_datos.producto,str_datos.parte,str_datos.cod_color)

li_columns = Integer(dw_1.Describe("DataWindow.Column.Count"))

//ls_unidad		=	dw_2.Getitemstring(1,"unidad_venta") //Unidad de Venta
ls_unidad = 'PZ'
	
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
			ll_cantidad = dw_1.Getitemnumber(i,"c"+string(k))
			ll_fraccion = dw_1.Getitemnumber(i,"f"+string(k))		
			//ll_canti_total = wf_convert_min(ls_unidad,ll_cantidad,ll_fraccion)
			
			ls_codigo = '  '
			ls_codigo = dw_1.Getitemstring(i,"tcodigo"+string(k))

			dw_1.Setitem(i,"c"+string(k),0)
			dw_1.Setitem(i,"f"+string(k),0)
			
			li_pos	 = pos(ls_codigo," ",1)
			li_pos2	 = li_pos
			li_pos	 = pos(ls_codigo," ",li_pos2 + 1)
			
			// Extrae el código del color
			ls_cod_color = mid(ls_codigo,li_pos2 + 1, li_pos - li_pos2 - 1 )
			
			li_pos2   = li_pos
			li_pos	 = pos(ls_codigo," ",li_pos2 + 1)
			
			// Extrae el código del tamaño
			ls_cod_tama = mid(ls_codigo,li_pos2 + 1, li_pos - li_pos2 - 1 )
			
			li_pos2   = li_pos
			li_pos	 = pos(ls_codigo," ",li_pos2 + 1)
			
			// Extrae el código del largo
			ls_cod_largo = mid(ls_codigo,li_pos2 + 1, li_pos - li_pos2 - 1 )					
			
			//Se extrae el codigo de grupo, del dw2
			ls_cod_grupo = wf_find_grupo()
			
			ls_expresion = "dcoc_renglon = "+string(str_datos.renglon)+" and dcoc_color = '"&
								+ls_cod_color+ "' and dcoc_cod_tamano = '"&
								+ls_cod_tama+"' and dcoc_largo = '"+ls_cod_largo+"'"

			//		Es la Linea del Empaque
			ll_row = dw_4.Find(ls_expresion,1,dw_4.Rowcount())
		
			if ll_row > 0 then
				li_resultado = dw_4.Scrolltorow(ll_row)
				
				// Gianni Araúz (28/04/2000)
				if str_datos.opcion = 'PEA' then
					ll_cantidad = dw_4.getitemnumber(ll_row,"dcoc_cant_pendiente")
				else
					ll_cantidad = dw_4.getitemnumber(ll_row,"dcoc_cantidad")
				end if
				// Fin Gianni
				
				ll_fraccion = dw_4.getitemnumber(ll_row,"dcoc_cant1")				
				if not isnull(ll_cantidad) then
					dw_1.setitem(i,"c"+string(k),ll_cantidad)
				end if
				if not isnull(ll_fraccion) then
					dw_1.setitem(i,"f"+string(k),ll_fraccion)	
				end if
			end if
		end if
	next
next

end subroutine

on w_cr_man_desglose.create
this.st_1=create st_1
this.em_fraccion=create em_fraccion
this.st_2=create st_2
this.em_cantidad=create em_cantidad
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_4=create dw_4
this.dw_2=create dw_2
this.dw_1=create dw_1
this.dw_3=create dw_3
this.Control[]={this.st_1,&
this.em_fraccion,&
this.st_2,&
this.em_cantidad,&
this.cb_2,&
this.cb_1,&
this.dw_4,&
this.dw_2,&
this.dw_1,&
this.dw_3}
end on

on w_cr_man_desglose.destroy
destroy(this.st_1)
destroy(this.em_fraccion)
destroy(this.st_2)
destroy(this.em_cantidad)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_4)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.dw_3)
end on

event open;// Centra la Ventana
// Oculta la ventana y se muestra luego de crear y cargar el dw

setpointer(hourglass!)

this.hide()

this.Postevent("ue_postopen")

end event

event key;if keydown(keyescape!) then
	this.Postevent("close")
end if

// Gianni Araúz (24/01/2000)
// Permite que se ejecute el script de los commandbuttons cuando se presiona enter. Para
// esto el foco debe estar sobre dicho botón.

if keydown(keyenter!) then
	if getfocus().typeof() = commandbutton! then getfocus().triggerevent(clicked!)
end if

end event

event closequery;//integer  li_resultado

////if not ib_syscommand then cb_1.triggerevent(clicked!)	// Salvar los Cambios

//cb_1.triggerevent(clicked!)
//
//ib_syscommand = false
//
//if ib_no_cerrar then
//	ib_no_cerrar = false
//	return 1
//end if

//if lb_cambio then	
//	li_resultado = gf_mensaje("","¿Desea Salvar los Cambios Realizados?",4,1,"E")
//	choose case li_resultado
//		case 1
//			cb_1.triggerevent(clicked!)
//		case 3
//			return 1
//	end choose
//	lb_cambio = false
//end if

end event

type st_1 from statictext within w_cr_man_desglose
boolean visible = false
integer x = 41
integer y = 872
integer width = 265
integer height = 76
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
string text = "Cantidad"
boolean focusrectangle = false
end type

type em_fraccion from editmask within w_cr_man_desglose
boolean visible = false
integer x = 777
integer y = 860
integer width = 197
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type st_2 from statictext within w_cr_man_desglose
boolean visible = false
integer x = 727
integer y = 864
integer width = 55
integer height = 76
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "/"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_cantidad from editmask within w_cr_man_desglose
boolean visible = false
integer x = 325
integer y = 860
integer width = 407
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = decimalmask!
string mask = "##,###"
end type

type cb_2 from commandbutton within w_cr_man_desglose
integer x = 5
integer y = 852
integer width = 2683
integer height = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Salvar (Control + S)     Salvar y Salir (Control + X)"
end type

type cb_1 from commandbutton within w_cr_man_desglose
event ue_dwnkey pbm_dwnkey
integer x = 2720
integer y = 852
integer width = 475
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
string text = "&Aceptar"
end type

event ue_dwnkey;/* Activa salvar y salir de la ventana de desglose */

if keydown(keyControl!) and keydown(keyS!) then
   this.triggerevent(clicked!)		//Salvar Los Cambios
	lb_cambio = false
	return 2
end if

if keydown(keyControl!) and keydown(keyX!) then
	if str_datos.opcion = 'PEA' then
		cb_1.triggerevent(clicked!)
//		dw_1.accepttext()
//		w_cz_pases_confirmacion.dw_3.setitem(str_datos.renglon,"dcof_cant1",&
//		dw_1.getitemnumber(1,"Stotal_f"))
//		closewithreturn(parent,dw_1.getitemnumber(1,"Stotal_c"))
	else
		this.triggerevent(clicked!)
	end if
end if

end event

event clicked;// Salvar los Cambios


long		ld_totcant, ld_totfrac

setpointer(hourglass!)

dw_1.accepttext()

if str_datos.opcion = 'PEA' then
	if dw_1.getitemnumber(1,"Stotal_c") > round(0.05*str_datos.cantidad_max+str_datos.cantidad_max,0) then
		messagebox('Atención','Cantidad de Desglose excede a la Cantidad Permitida.',Exclamation!)
		ib_no_cerrar = true
		return
	end if
end if

if wf_guardar() = -1 then
	ib_no_cerrar = true
	messagebox('Atención','Ha ocurrido un error al momento de almacenar la información.',Exclamation!)
	return
end if

if str_datos.opcion <> 'PEA' then
	ld_totcant = dw_1.getitemnumber(1,"Stotal_c")
	ld_totfrac = dw_1.getitemnumber(1,"Stotal_f")
	w_cz_ma_confirmacion.tab_1.tabpage_2.dw_detalle.setitem(str_datos.fila,"dcof_cantidad_total",ld_totcant)
	w_cz_ma_confirmacion.tab_1.tabpage_2.dw_detalle.setitem(str_datos.fila,"dcof_cant1",ld_totfrac)
	
//	if dw_4.update() = 1 then
//		str.frame.Setmicrohelp("¡Actualización exitosa!")
//	else
//		rollback;
//		w_cz_ma_confirmacion.tab_1.tabpage_2.dw_detalle.setitem(str_datos.fila,'dcof_cantidad_total',0)
//		messagebox('Atención','¡No se actualizó la información!',Exclamation!)
//		return
//	end if
	
	closewithreturn(parent,0)
else
	w_cz_pases_confirmacion.dw_3.setitem(str_datos.fila,"dcof_cant1",&
	dw_1.getitemnumber(1,"Stotal_f"))
	closewithreturn(parent,dw_1.getitemnumber(1,"Stotal_c"))
end if

//lb_cambio =  false

setpointer(arrow!)

end event

type dw_4 from datawindow within w_cr_man_desglose
integer x = 50
integer y = 1084
integer width = 3168
integer height = 236
string dataobject = "dw_cr_man_desglose"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type dw_2 from datawindow within w_cr_man_desglose
integer x = 64
integer y = 1328
integer width = 3099
integer height = 240
boolean enabled = false
string dataobject = "dw_in_ahora_desglose"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_cr_man_desglose
event ue_keydown pbm_dwnkey
event type integer ue_postitem ( long row,  dwobject dwo,  string data )
event ue_enter pbm_dwnprocessenter
integer x = 5
integer y = 20
integer width = 3195
integer height = 804
integer taborder = 10
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;long 		ll_column
integer  li_columns
string	ls_colum, ls_column_name

ll_column = this.Getcolumn()
ls_colum	 = this.Getcolumnname()

if keydown(keyA!) then
	if len(ls_colum) = 2 then
		messagebox('',this.getitemstring(this.getrow(),"tcodigo"+right(ls_colum,1)))
	else
		messagebox('',this.getitemstring(this.getrow(),"tcodigo"+right(ls_colum,2)))
	end if
end if

//if keydown(keyenter!) then

//	
//	is_col = This.GetColumnName()
//	
//	if mid(ls_colum,1,1) = 'c' and ls_colum <> "color" then
//		this.Setcolumn(ll_column + 1)		//Para saltar a la fraccion
//	else
//		
//	li_columns = Integer(dw_1.Describe("DataWindow.Column.Count"))		
//	ls_column_name = dw_1.Describe("#" + string(li_columns - 1) + ".Name")  //RECUPERA EL NOMBRE DE LA COLUMNA
//		
//		if ls_column_name = ls_colum then
//			this.Setcolumn(2)		//Para saltar al campo inicial
//		elseif ls_colum = "color" then
//			this.Setcolumn(ll_column + 2)   //Si está en el campo de color
//		else
//			this.Setcolumn(ll_column + 3)	  // Para saltar el campo oculto de protegido
//		end if
//		
//	end if
//	
//   return 2
//	
//elseif keydown(KeyPageDown!) then
////	return 2

if keydown(keyControl!) and keydown(keyS!) then
	setpointer(hourglass!)
	wf_guardar()	// Salvar Los Cambios
	return 2
	setpointer(arrow!)
end if

if keydown(keyControl!) and keydown(keyX!) then
	if str_datos.opcion = 'PEA' then
		cb_1.triggerevent(clicked!)
//		dw_1.accepttext()
//		w_cz_pases_confirmacion.dw_3.setitem(str_datos.renglon,"dcof_cant1",&
//		dw_1.getitemnumber(1,"Stotal_f"))
//		closewithreturn(parent,dw_1.getitemnumber(1,"Stotal_c"))
	else
		cb_1.triggerevent(clicked!)
	end if
end if

// Gianni Araúz (01/04/1999)
// Este script hace que aparezca el nombre del DataWindow Object y el nombre de la
// columna cuando se presiona la teclas "Control" y "N".

string		 ls_clase, ls_dw='', ls_columna='', ls_columna1=''
	
if keydown(keycontrol!) and keydown(keyN!) then
	ls_dw = this.DataObject
	Clipboard(ls_dw)
	ls_columna = GetColumnName()
	ls_columna1 = describe('#'+string(GetColumn())+'.dbname')
	if trim(ls_columna) = trim(ls_columna1) then
		MessageBox('NOMBRE DEL DATAWINDOW: '+ls_dw,'NOMBRE DE LA COLUMNA: '+ls_columna,&
			Information!)
	else
		MessageBox('NOMBRE DEL DATAWINDOW: '+ls_dw,'NOMBRE DE LA COLUMNA: '+ls_columna+&
					'~nNOMBRE EN LA BASE DE DATOS: '+ls_columna1)
	end if
end if

end event

event ue_postitem;////Post itemchanged
//Long 	   ll_cantidad, ll_fraccion, ll_canti_total, ll_row
//Integer  li_pos, li_pos2, li_resultado
//String	ls_codigo, ls_cod_color, ls_cod_tama, ls_cod_largo, ls_cod_grupo, ls_expresion, &
//			ls_unidad, ls_num_largo
//
//lb_cambio = true
//
////ls_unidad = dw_2.GetitemString(1,"unidad_venta")
//ls_unidad = 'PZ'
//if mid(is_col,1,1) = "c" or mid(is_col,1,1) = "f" then
//	
//			ls_codigo	=	dw_1.GetitemString(row,"tcodigo"+mid(is_col,2))
//	
//		   //Extrae el numero de la casilla o largo
//		   ls_num_largo = mid(is_col,2) //mid(ls_codigos,li_pos2+1)			  		
//		
//			//Extrae la Cantidad y Fraccion Para Guardarla
//			ll_cantidad 	= dw_1.Getitemnumber(row,"c"+ls_num_largo)
//			ll_fraccion 	= dw_1.Getitemnumber(row,"f"+ls_num_largo)
//			ll_canti_total = wf_convert_min(ls_unidad,ll_cantidad,ll_fraccion)
//			
////			ls_codigo = dw_1.Getitemstring(row,"tcodigo"+ls_num_largo)
//			li_pos	 = pos(ls_codigo," ",1)
//			li_pos2	 = li_pos
//			li_pos	 = pos(ls_codigo," ",li_pos2 + 1)
//			//Extrae el codigo del color
//			ls_cod_color = mid(ls_codigo,li_pos2 + 1, li_pos - li_pos2 - 1 )
//			
//			li_pos2   = li_pos
//			li_pos	 = pos(ls_codigo," ",li_pos2 + 1)
//			//Extrae el codigo del tamaño
//			ls_cod_tama = mid(ls_codigo,li_pos2 + 1, li_pos - li_pos2 - 1 )
//			
//			li_pos2   = li_pos
//			li_pos	 = pos(ls_codigo," ",li_pos2 + 1)
//			//Extrae el codigo del largo
//			ls_cod_largo = mid(ls_codigo,li_pos2 + 1, li_pos - li_pos2 - 1 )					
//			
//			//Se extrae el codigo de grupo, del dw2
//			ls_cod_grupo = wf_find_grupo()
//			
//			ls_expresion = "linea = "+string(ii_linea)+" and cod_color = '"+ls_cod_color+"' and cod_tama = '"+ls_cod_tama+"' and cod_largo = '"+ls_cod_largo+"'"
//			
////			messagebox("",ls_expresion)
//			
//			ll_row = dw_3.Find(ls_expresion,1,dw_3.Rowcount())
//			//messagebox("Scroll to --> ",string(ll_row) +" de "+string(aldw_5.rowcount()))
//			
//			if ll_row > 0 and false then
//				//Afectar la Cantidad				
//				
//				//Validar la cantidad y  si todo ok entonces mostrar la diferencia				
//				//dw_3.setitem(ll_row,"cantidad",ll_canti_total)
//			
//				if mid(is_col,1,1) = "c" then
//					il_fraccion  = this.GetitemNumber(row,"f"+ls_num_largo)		
//					li_resultado = wf_valida_cantidad(This, row, "CANTI",ls_cod_color, ls_cod_tama, ls_cod_largo, ls_cod_grupo)
//					if li_resultado = -1 then 
//						this.Setcolumn(long(string(dwo.id)))
//						return 2	
//					end if			
//				else					
//					il_canti    = this.GetitemNumber(row,"c"+ls_num_largo)
//					li_resultado = wf_valida_cantidad(This, row, "FRAC",ls_cod_color, ls_cod_tama, ls_cod_largo, ls_cod_grupo)
//					if li_resultado = -1 then 
//						this.Setcolumn(long(string(dwo.id)))
//						return 2			
//					end if
//				end if
//			end if
//			
//end if //Principal
//
return 1
end event

event ue_enter;send(handle(this),256,9,long(0,0))
return 1
end event

event itemfocuschanged;// Hace un Scroll al Registro Que muestra lo disponible y asignado por casilla


Integer	li_pos, li_pos2=1
string	ls_cod_color, ls_campo, ls_cod_tama, ls_cod_largo, ls_numero_campo, ls_codigo

if dw_1.rowcount() < 1 then return

ls_campo = dwo.name

if ls_campo = "color" then
	dw_3.Scrolltorow(dw_3.rowcount())
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
	dw_3.Scrolltorow(dw_3.insertrow(0))
	return 2
end if

//Dirige el cursor al producto actual
wf_scroll_a_disponibles(dw_3, ls_cod_color, ls_cod_tama, ls_cod_largo)

end event

event clicked;//////string ls_protec
////ls_protec = dw_1.Describe("p"+mid(string(dwo.name),2)+".protect")
////messagebox("Protec",ls_protec)
////if ls_protec = "1" then return
////
////wf_setear_yy(string(dwo.name))
//string ls_objeto
//
//ls_objeto = This.GetObjectAtPointer()
//integer li_pos 
//
//li_pos 	 =  Pos(ls_objeto, "~t")
//ls_objeto = Left(ls_objeto, li_pos - 1)
//messagebox("Objeto",ls_objeto)
//////
//messagebox("Objeto.expresion",this.Describe(ls_objeto+".expression"))
//// messagebox("Objeto.expresion",this.Describe(ls_objeto+".height"))
//messagebox("Objeto.Valor",this.getitemnumber(this.getrow(),ls_objeto))
////messagebox("Color",this.describe(ls_objeto+".color"))
////this.modify(ls_objeto+".background.color='553648127'")
////this.modify(ls_objeto+".color='0'")
////
////messagebox("Color",this.describe(ls_objeto+".color"))

end event

event editchanged;
lb_cambio = true

is_col = This.GetColumnName()

end event

event losefocus;cb_1.setfocus()

end event

type dw_3 from datawindow within w_cr_man_desglose
boolean visible = false
integer x = 247
integer y = 988
integer width = 2537
integer height = 120
boolean enabled = false
borderstyle borderstyle = styleraised!
end type

