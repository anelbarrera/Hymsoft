//objectcomments Despliega los informes de ventas
forward
global type w_fa_informe_general from w_fa_padre_reportes
end type
type cbx_exist from checkbox within w_fa_informe_general
end type
type em_cantidad from editmask within w_fa_informe_general
end type
type st_pie from statictext within w_fa_informe_general
end type
end forward

global type w_fa_informe_general from w_fa_padre_reportes
integer x = 23
integer y = 172
integer width = 2994
integer height = 1648
string title = ""
cbx_exist cbx_exist
em_cantidad em_cantidad
st_pie st_pie
end type
global w_fa_informe_general w_fa_informe_general

type variables
str_fa_informe	str_informe

//date		fecha_inicial, fecha_final
//datastore		lds_kardex

end variables

forward prototypes
public function integer wf_verificar_actual ()
public subroutine wf_datawindow ()
end prototypes

public function integer wf_verificar_actual ();long	ll_filas

Select Count(*)
Into   :ll_filas
From   inmprodu
Where  prod_g_financiero = :str.g_financiero and
       prod_empresa = :str.empresa;

// Gianni Araúz (19/01/2000)
if sqlca.sqlcode = -1 then
	messagebox('Error','No se pudo recuperar el número de registros de productos.',StopSign!)
	close(this)
	return -1
end if
// Fin Gianni

If ll_filas = 0 Then
	mensaje('Información','No Existen Productos Creados Para Generar Este Informe','')
	close(this)
	return -1
End If

Select Count(*)
Into   :ll_filas
From   intmovim
Where  tmov_g_financiero = :str.g_financiero and
       tmov_empresa = :str.empresa;

// Gianni Araúz (19/01/2000)
if sqlca.sqlcode = -1 then
	messagebox('Error','No se pudo recuperar el número de registros de movimientos',StopSign!)
	close(this)
	return -1
end if
// Fin Gianni

If ll_filas = 0 Then
	mensaje('Información', 'No Existen Transaccion de Inventario Creadas para Generar Este Informe','')
	Close (This)
	Return -1
End If

Return 1

end function

public subroutine wf_datawindow ();
String ls_sql, ls_desc1, ls_desc2, ls_desc3, ls_desc4, ls_desc5
String ls_c1, ls_c2, ls_c3, ls_c4, ls_c5

ls_sql = dw_1.GetSqlSelect()

If str_informe.compute[1] <> "" Then
   ls_desc1 = 'c_descripcion1 = '+'"'+str_informe.encabezado[1]+'"+'+'" : "+'+str_informe.compute[1]+'+" - "+'+str_informe.descripcion[1]
   ls_c1    = 'c_compute1 = '+str_informe.compute[1]
	gf_replace_cadena(ls_sql,'c_descripcion1 = ""',ls_desc1)
	gf_replace_cadena(ls_sql,'c_compute1 = ""',ls_c1)
End If

If str_informe.compute[2] <> "" Then
   ls_desc2 = 'c_descripcion2 = '+'"'+str_informe.encabezado[2]+'"+'+'" : "+'+str_informe.compute[2]+'+" - "+'+str_informe.descripcion[2]
   ls_c2    = 'c_compute2 = '+str_informe.compute[2]
   gf_replace_cadena(ls_sql,'c_descripcion2 = ""',ls_desc2)
	gf_replace_cadena(ls_sql,'c_compute2 = ""',ls_c2)
End If

if str_informe.opcion_menu <> 'RMS' then
	If str_informe.compute[3] <> "" Then
		ls_desc3 = 'c_descripcion3 = '+'"'+str_informe.encabezado[3]+'"+'+'" : "+'+str_informe.compute[3]+'+" - "+'+str_informe.descripcion[3]	
		ls_c3    = 'c_compute3 = '+str_informe.compute[3]
		gf_replace_cadena(ls_sql,'c_descripcion3 = ""',ls_desc3)
		gf_replace_cadena(ls_sql,'c_compute3 = ""',ls_c3)
	End If
	
	If str_informe.compute[4] <> "" Then
		ls_desc4 = 'c_descripcion4 = '+'"'+str_informe.encabezado[4]+'"+'+'" : "+'+str_informe.compute[4]+'+" - "+'+str_informe.descripcion[4]
		ls_c4    = 'c_compute4 = '+str_informe.compute[4]
		gf_replace_cadena(ls_sql,'c_descripcion4 = ""',ls_desc4)
		gf_replace_cadena(ls_sql,'c_compute4 = ""',ls_c4)
	End If
	
	If str_informe.compute[5] <> "" Then
		ls_desc5 = 'c_descripcion5 = '+'"'+str_informe.encabezado[5]+'"+'+'" : "+'+str_informe.compute[5]+'+" - "+'+str_informe.descripcion[5]	
		ls_c5    = 'c_compute5 = '+str_informe.compute[5]
		gf_replace_cadena(ls_sql,'c_descripcion5 = ""',ls_desc5)
		gf_replace_cadena(ls_sql,'c_compute5 = ""',ls_c5)
	End If
end if


//If str_informe.opcion_menu = 'IPP' or str_informe.opcion_menu = 'ICCP' Then
//	gf_replace_cadena(ls_sql,'porcentaje = 0','porcentaje = '+string(str_informe.porcentaje))
//End If

ls_sql = ls_sql + str_informe.cadena_where

dw_1.SetSqlSelect(ls_sql)

end subroutine

on w_fa_informe_general.create
int iCurrent
call super::create
this.cbx_exist=create cbx_exist
this.em_cantidad=create em_cantidad
this.st_pie=create st_pie
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_exist
this.Control[iCurrent+2]=this.em_cantidad
this.Control[iCurrent+3]=this.st_pie
end on

on w_fa_informe_general.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_exist)
destroy(this.em_cantidad)
destroy(this.st_pie)
end on

event open;call super::open;str_informe = Message.PowerObjectParm
sqlca.autocommit=true;
setpointer(hourglass!)


This.WindowState = Maximized!
This.Title = str_informe.titulo_ventana

dw_1.Hide()
dw_1.DataObject = str_informe.dwinforme	//borrar1 temporalmente

dw_1.SetTransObject(sqlca)

st_nom_ventana.text = this.classname()

end event

event ue_post_open;//Override
integer	li_cont, li_row, li_mes, li_fila=5,li_ultimo_dia
string	ls_var,ls_expresion, ls_compute, ls_descripcion
DateTime		ld_fecha_ini, ld_fecha_fin,ld_fecha3,ld_fecha4
Date		ldf_fecha,ld_fecha

//Para ocultar las opciones de consultas, cuando es Elbros

//Para ocultar las opciones de consultas, cuando es Elbros
//if pos(gf_dg_nombre_empresa(),'ELBROS') > 0 then gf_fa_cambiar_titulos(this.menuid)

For li_cont = 1 to li_fila	
    If str_informe.compute[li_cont] <> ""  Then
		choose case str_informe.opcion_menu
			case 'IVPP','IVPREG'	//Informe de Ventas por Producto	
				If str_informe.is_opcion ='Detallado' or str_informe.is_opcion ='Cantidad' or &
				str_informe.is_opcion ='Individual' then
		   		 dw_1.Modify ("DataWindow.Header." + string (li_cont) + ".Height = 85")
					 dw_1.Modify ("DataWindow.Trailer." + string (li_cont) + ".Height = 85")
				else
					 dw_1.Modify ("DataWindow.Trailer." + string (li_cont) + ".Height = 85")
				end if			 

			case 'IREG' //Informe de Regalias resumido y detallado para Foster
			 //se le suma 1 al grupo, ya que el primer grupo es el de pais y se valida
			 //para cuando es el resumido, no agrande el header de el subgrupo = tipo en Foster

				 //el detalle siempre lo hace
				 dw_1.Modify ("DataWindow.Trailer." + string (li_cont + 1) + ".Height = 85")
			    //cuando el informe es resumido, sin producto
			 	 If str_informe.is_opcion ='Resumido' then 							
					if li_cont = 5 then 
						ls_compute = "total"+string(li_cont)
						ls_descripcion = 'c_descripcion'+string(li_cont)
						dw_1.modify(ls_compute+".expression='"+ls_descripcion+"'")
						exit //para que salga sin agrandar el header del ultimo registro
					end if
					if str_informe.compute[li_cont + 1] <> "" then
						dw_1.Modify ("DataWindow.Header." + string (li_cont + 1) + ".Height = 85")
					else
						ls_compute = "total"+string(li_cont)
						ls_descripcion = 'c_descripcion'+string(li_cont)
						dw_1.modify(ls_compute+".expression='"+ls_descripcion+"'")
					end if
				 else //si es el detallado,  muestra el producto y siempre los totales
				 	dw_1.Modify ("DataWindow.Header." + string (li_cont + 1) + ".Height = 85")
	 			 end if
			case 'IVCOM'	/// Informe de Ventas Comparativo por tipo de Producto
				If str_informe.is_opcion ='Detallado' then
		   		 dw_1.Modify ("DataWindow.Header." + string (li_cont) + ".Height = 85")
					 dw_1.Modify ("DataWindow.Trailer." + string (li_cont) + ".Height = 85")
				else
					 dw_1.Modify ("DataWindow.Trailer." + string (li_cont) + ".Height = 85")
				end if			 

				ld_fecha =date('01/01/'+string(str_informe.anio))
				
				ld_fecha_ini = DateTime(ld_fecha,Time("00:00:00"))
				
				// Rutina para buscar el ultimo día del mes corriente
				ld_fecha =date('27/'+string(str_informe.mes)+'/'+string(str_informe.anio))
				
				ldf_fecha = ld_fecha
				
				do while month(ldf_fecha) = month(ld_fecha)
					ldf_fecha = relativeDate(ldf_fecha,1)
				loop
				
				ldf_fecha = relativeDate(ldf_fecha,-1)
				li_ultimo_dia = month(ldf_fecha)
				ld_fecha =date(string(li_ultimo_dia)+'/'+string(str_informe.mes)+'/'+string(str_informe.anio))
				
				ld_fecha_fin = DateTime(ld_fecha,Time("23:59:59"))
		
				// Fecha inicial año anterior
				ld_fecha =date('01/01/'+string(str_informe.anio - 1))
				
				ld_fecha3 = DateTime(ld_fecha,Time("00:00:00"))
		
				ld_fecha =date(string(li_ultimo_dia)+'/'+string(str_informe.mes)+'/'+string(str_informe.anio - 1))
		
				ld_fecha4 = DateTime(ld_fecha,Time("23:59:59"))
				
			case else
				 dw_1.Modify ("DataWindow.Header." + string (li_cont) + ".Height = 85")
				 dw_1.Modify ("DataWindow.Trailer." + string (li_cont) + ".Height = 85")
		end choose
    End If
Next

wf_datawindow()

//dw_1.object.rango.expression = "'"+str_informe.fecha_periodo+"'"
ls_expresion = string(date(gf_fecha_serv()))
//dw_1.object.fecha.expression = "'"+ls_expresion+"'"

ls_expresion  = string(time(gf_fecha_serv()))
//dw_1.object.hora.expression = "'"+ls_expresion+"'"

ls_expresion=gf_dg_nombre_empresa()
//dw_1.object.empresa.expression = "'"+ls_expresion+"'"

ls_expresion=dw_1.DataObject
//dw_1.object.datawin.expression = "'"+ls_expresion+"'"
	
this.setredraw(false)
if str_informe.opcion_menu ='IVCOM' then
	dw_1.Retrieve(ld_fecha_ini,ld_fecha_fin,ld_fecha3,ld_fecha4)
	ls_expresion = gf_dg_mes(str_informe.mes)
	ls_expresion = ' Correspondiente al mes de '+ls_expresion+' de '+string(str_informe.anio)
	dw_1.object.rango.expression = "'"+ls_expresion+"'"
	dw_1.groupCalc()
else
	dw_1.Retrieve()
end if

this.setredraw(true)

If dw_1.Rowcount() > 0 Then
	li_row = 1
	dw_1.Object.DataWindow.Zoom = 100
	dw_1.Object.DataWindow.Print.Preview ="yes"
	dw_1.Object.DataWindow.Print.Preview.Zoom = 100
	dw_1.object.datawindow.print.preview.rulers ="yes"
//	gf_in_formato_decimal(dw_1)
Else
	li_row = 0
	Mensaje('Información','No existen registros con estas especificaciones','')		
End If

If li_row = 0 Then
	Close(This)
Else
	dw_1.Show()
	dw_1.setfocus()
End If

setpointer(arrow!)
end event

event ue_reg_anterior;dw.scrollpriorpage()
end event

event ue_siguiente_reg;dw.scrollnextpage()
end event

event resize;call super::resize;This.SetRedraw(False)
dw_1.SetRedraw(False)
dw_1.Hide()
st_nom_ventana.y = newheight - (st_nom_ventana.height + 10)
cbx_exist.y = st_nom_ventana.y
em_cantidad.y = st_nom_ventana.y
st_pie.y = st_nom_ventana.y
dw_1.Resize(newwidth - 50, newheight - 100)
gb_1.Width = newwidth - 75
gb_1.Height = newheight - 120

dw_1.Show()
dw_1.SetRedraw(True)
This.SetRedraw(True)

end event

event ue_print;//OVERRIDE
OpenWithParm(w_dw_print_options, dw)
If Message.DoubleParm = -1 Then Return
//Para poner invisible el nombre del datawindow en la impresion
if dw.Describe("datawin.x") <> "?" and dw.Describe("datawin.x") <> "!" then &
	dw.object.datawin.visible = "0"

	dw.Print(True)

//Para poner visible el nombre del datawindow
if dw.Describe("datawin.x") <> "?" and dw.Describe("datawin.x") <> "!" then &
	dw.object.datawin.visible = "1"	
end event

event ue_filter;call super::ue_filter;dw_1.groupcalc()
end event

event ue_sort;call super::ue_sort;dw_1.groupcalc()
end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_informe_general
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_informe_general
integer x = 32
integer y = 1372
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_informe_general
event ue_dwnkey pbm_dwnkey
integer x = 18
integer y = 32
integer width = 2834
integer height = 1300
integer taborder = 10
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event dw_1::ue_dwnkey;//Despliega el nombre del dw cuando se presiona Control + N
datawindow		ldw

if keydown(keycontrol!) and keydown(keyN!) then
	if getfocus().typeof() = datawindow! then
		ldw = getfocus()
		messagebox('ATENCIÓN','NOMBRE DEL DATAWINDOW: '+ldw.dataobject)
	end if
end if

end event

event dw_1::sqlpreview;//
String ls_sql, ls_desc1, ls_desc2, ls_desc3, ls_desc4, ls_desc5
String ls_c1, ls_c2, ls_c3, ls_c4, ls_c5

ls_sql = sqlsyntax

If str_informe.compute[1] <> "" Then
   ls_desc1 = 'c_descripcion1 = '+'"'+str_informe.encabezado[1]+'"+'+'" : "+'+str_informe.compute[1]+'+" - "+'+str_informe.descripcion[1]
   ls_c1    = 'c_compute1 = '+str_informe.compute[1]
	gf_replace_cadena(ls_sql,'c_descripcion1 = ""',ls_desc1)
	gf_replace_cadena(ls_sql,'c_compute1 = ""',ls_c1)
End If


If str_informe.compute[2] <> "" Then
   ls_desc2 = 'c_descripcion2 = '+'"'+str_informe.encabezado[2]+'"+'+'" : "+'+str_informe.compute[2]+'+" - "+'+str_informe.descripcion[2]
   ls_c2    = 'c_compute2 = '+str_informe.compute[2]
   gf_replace_cadena(ls_sql,'c_descripcion2 = ""',ls_desc2)
	gf_replace_cadena(ls_sql,'c_compute2 = ""',ls_c2)
End If

If str_informe.compute[3] <> "" Then
   ls_desc3 = 'c_descripcion3 = '+'"'+str_informe.encabezado[3]+'"+'+'" : "+'+str_informe.compute[3]+'+" - "+'+str_informe.descripcion[3]	
   ls_c3    = 'c_compute3 = '+str_informe.compute[3]
   gf_replace_cadena(ls_sql,'c_descripcion3 = ""',ls_desc3)
	gf_replace_cadena(ls_sql,'c_compute3 = ""',ls_c3)
End If

If str_informe.compute[4] <> "" Then
   ls_desc4 = 'c_descripcion4 = '+'"'+str_informe.encabezado[4]+'"+'+'" : "+'+str_informe.compute[4]+'+" - "+'+str_informe.descripcion[4]
   ls_c4    = 'c_compute4 = '+str_informe.compute[4]
   gf_replace_cadena(ls_sql,'c_descripcion4 = ""',ls_desc4)
	gf_replace_cadena(ls_sql,'c_compute4 = ""',ls_c4)
End If


If str_informe.compute[5] <> "" Then
   ls_desc5 = 'c_descripcion5 = '+'"'+str_informe.encabezado[5]+'"+'+'" : "+'+str_informe.compute[5]+'+" - "+'+str_informe.descripcion[5]	
   ls_c5    = 'c_compute5 = '+str_informe.compute[5]
   gf_replace_cadena(ls_sql,'c_descripcion5 = ""',ls_desc5)
	gf_replace_cadena(ls_sql,'c_compute5 = ""',ls_c5)
End If

//If str_informe.opcion_menu = 'IEN' Then
//	gf_replace_cadena(ls_sql,'c_fecha_periodo = ""','c_fecha_periodo = '+'"'+str_informe.periodo+'"')
//End If
//
//If str_informe.opcion_menu = 'IBPR' Then
//	gf_replace_cadena(ls_sql,'c_punto = ""','c_punto = '+'"'+str_informe.periodo+'"')
//End If
//
//If str_informe.opcion_menu = 'IPP' Then
//	gf_replace_cadena(ls_sql,'porcentaje = 0','porcentaje = '+string(str_informe.porcentaje))
//End If


This.SetSqlPreview(ls_sql)

end event

event dw_1::constructor;//
end event

event dw_1::ue_microayuda;call super::ue_microayuda;// Gianni Araúz (12/02/2000)
// Cierra la ventana cuando se presiona Control + w


datawindow	ldw

if keydown(keycontrol!) and keydown(keyN!) then
	messagebox('','Entré')
	if getfocus().typeof() = datawindow! then
		ldw = getfocus()
		messagebox('Atención','Nombre de la ventana: '+ldw.dataobject)
	end if
end if

end event

event dw_1::clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string	ls_objeto
integer	li_pos 

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if right(ls_objeto,2)='_t' then
	
	this.Setredraw(false)

	ls_objeto = left(ls_objeto,len(ls_objeto)-2)
	
	if ls_objeto = is_ultima_ or is_ultima_ = "" then	//Si es la misma columna 
																	// o si es la primera vez
		if is_orden_  = "" or is_orden_ = "D" then
			is_orden_ = 'A'		
			this.SetSort(ls_objeto+" A")	//Ordena Ascendente
			this.sort()		
		else
			is_orden_ = 'D'					
			this.SetSort(ls_objeto+" D")	//Ordena Descendente
			this.sort()				
		end if	
		is_ultima_ = ls_objeto		
	else				
			is_orden_ = 'A'
			this.SetSort(ls_objeto+" A")
			this.sort()
			is_ultima_ = ls_objeto
	end if
	
	this.Setredraw(true)

end if

end event

event dw_1::retrieveend;call super::retrieveend;String  ls_unidad_vta, ls_unidad_prod,ls_nombre, ls_tipo,ls_pedido,ls_error
Double  ld_costo_cif, ld_cantidad, ld_cant_fracc, ld_costo_total
Integer li_codigo, li_anio
Date	ld_fecha
Long	ll_row

Parent.SetRedraw(False)

choose case str_informe.opcion_menu 
  case 'IVPP','IVCOM','IVPREG'
	//Función que calcula el costo total, en los informes de ventas	
	If Rowcount > 0 Then				
		For ll_row = 1 To Rowcount
			
			ls_unidad_vta  = dw_1.GetItemString(ll_row,"facd_unidad_venta")
			ls_unidad_prod = dw_1.GetItemString(ll_row,"facd_unidad_producto")
			ld_costo_cif   = dw_1.GetItemNumber(ll_row,"facd_costo_cif")
			ld_cantidad    = dw_1.GetItemNumber(ll_row,"facd_cantidad")
			ld_cant_fracc  = dw_1.GetItemNumber(ll_row,"facd_cantidad_fraccion")			
					
			ld_costo_total = Round(gf_costo_total(ls_unidad_vta, ls_unidad_prod, ld_costo_cif, &
																ld_cantidad, ld_cant_fracc),2)	
			dw_1.SetItem(ll_row,"costo_total",ld_costo_total)
			
		next
	End If
end choose

Parent.SetRedraw(True)

end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_informe_general
integer taborder = 20
end type

type cbx_exist from checkbox within w_fa_informe_general
integer x = 1317
integer y = 1356
integer width = 974
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sólo con existencias mayores a  :"
borderstyle borderstyle = stylelowered!
end type

event clicked;//Filtra los que tienen existencias
string ls_filtro
long ll_cantidad
if this.checked then
	ll_cantidad = long(em_cantidad.text)
	if isnull(ll_cantidad) then ll_cantidad = 0
	ls_filtro = 'inmprodu_prod_existencia_total > '+string(ll_cantidad)
	dw_1.setfilter(ls_filtro)
else
	dw_1.setfilter('')
end if
dw_1.filter()
dw_1.groupcalc()
end event

type em_cantidad from editmask within w_fa_informe_general
integer x = 2286
integer y = 1352
integer width = 347
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,##0"
end type

event modified;if cbx_exist.checked then
	cbx_exist.triggerevent('clicked')
end if
end event

type st_pie from statictext within w_fa_informe_general
integer x = 2647
integer y = 1364
integer width = 238
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "En piezas"
boolean focusrectangle = false
end type

