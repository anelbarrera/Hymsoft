//objectcomments Ventana para Seleccionar el o los artículos a Devolver
forward
global type w_fa_man_modi_devol_art from window
end type
type dw_1 from datawindow within w_fa_man_modi_devol_art
end type
type st_1 from statictext within w_fa_man_modi_devol_art
end type
type gb_1 from groupbox within w_fa_man_modi_devol_art
end type
end forward

global type w_fa_man_modi_devol_art from window
integer x = 379
integer y = 324
integer width = 3287
integer height = 1176
boolean titlebar = true
string title = "Seleccione el Artículo"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79416533
event ue_post_open ( )
dw_1 dw_1
st_1 st_1
gb_1 gb_1
end type
global w_fa_man_modi_devol_art w_fa_man_modi_devol_art

type variables
//Data window con la información
datawindow ildw_2

//Variable tipo estructura, para aceptar el parametro de la ventana principal
str_fa_devolucion str_argumen

//
long il_old_row, il_modifica

//Para guardar las cantidades a Devolver parcialmente
long ii_cantidad, ii_fraccion
end variables

forward prototypes
public function integer wf_cantidad_total (long cantidad, integer fraccion, string ls_unidad_prod, string ls_unidad_venta)
public subroutine wf_cantidad_a_devolver (string unidad_venta, long cantidad, integer fraccion, integer devuelta, string unidad_prod)
public subroutine wf_modifica_precio ()
end prototypes

event ue_post_open;long ll_recuperados

dw_1.Settransobject(sqlca)
dw_1.SetRowFocusIndicator(Hand!)

st_1.text = this.classname()

str_argumen = Message.PowerObjectParm

//Recupera todos los registros
ll_recuperados = dw_1.retrieve(str.g_financiero, str.empresa, str_argumen.pedido, str_argumen.an, str_argumen.tipo)

//Filtra por los que no estan en la ventana de devolucion
dw_1.Setfilter(str_argumen.cadena_filtro)
dw_1.Filter()

//cantidad y fraccion a solo lectura
dw_1.Modify("facd_cantidad.Edit.DisplayOnly=yes")
dw_1.Modify("facd_cantidad_fraccion.Edit.DisplayOnly=yes")	
dw_1.Setfocus()

wf_modifica_precio()

if dw_1.rowcount() = 0 then
	messagebox("ATENCIÓN SR. USUARIO","No hay Registros Disponibles para Selección",Exclamation!)
	close(this)
end if
end event

public function integer wf_cantidad_total (long cantidad, integer fraccion, string ls_unidad_prod, string ls_unidad_venta); long ll_ucom, ll_total , ll_mconvera
 
  //Tipo de medida de la unidad del producto	(UNIDADES, UNIDAD DE PESO, CONVERSIONES, ETC)
  // Devuleve 10 en caso de que sea una medida
 ll_ucom = gf_medi_prod(ls_unidad_prod)
  
 //* Carga Los Datos de Converción de la Unidad Actual
 ll_mconvera = gf_unidad_venta(ls_unidad_venta, ll_ucom)
 
 if ll_mconvera = 0 or isnull(ll_mconvera) then
 	messagebox("ATENCIÓN SR. USUARIO", "Verifique las unidades del producto",Exclamation!)
	return 2
 end if

	ll_total = ( cantidad * ll_mconvera ) + fraccion

return (ll_total)
end function

public subroutine wf_cantidad_a_devolver (string unidad_venta, long cantidad, integer fraccion, integer devuelta, string unidad_prod);//Función que Transforma las cantidades a piezas y las asigna a las variables de instancia
// ii_cantidad e ii_fraccion en su respectiva unidad de venta
long   ll_cant_total, ll_diferencia, ll_largo, ll_recorrido, ll_divisor, ll_pos = 0, ll_frac_redondeada
double ld_tempo, ld_frac_devol
long   ll_ucon, ll_mconvera 
string ls_tempo, ls_divisor = "1"

ii_fraccion = 0
ll_cant_total = wf_cantidad_total(cantidad, fraccion, unidad_prod, unidad_venta)
ll_diferencia = ll_cant_total - devuelta

//Para convertir segun la unidad de venta
ll_ucon = gf_medi_prod(unidad_prod)  //Codigo de la Medida del Producto
ll_mconvera = gf_unidad_venta(unidad_venta, ll_ucon)  //Medida del producto

if ll_mconvera = 0 or isnull(ll_mconvera) then ll_mconvera = 1   //Para que no divida por cero
ll_largo = len(string(ll_mconvera))

for ll_recorrido = 2 to ll_largo
	 ls_divisor = ls_divisor + "0"	
end for

ll_divisor = integer(ls_divisor)
ii_cantidad = Truncate(ll_diferencia / ll_mconvera,0)  //Valor enteros

if ll_diferencia < ll_mconvera then
	ld_tempo = ll_diferencia
	ii_fraccion = ll_diferencia
else
	ld_tempo = round(ll_diferencia / ll_mconvera,ll_largo - 1)
	ll_pos = pos(string(ld_tempo),".")
end if

if ll_pos <> 0 then
	ls_tempo = mid(string(ld_tempo),ll_pos + 1)
	ll_frac_redondeada = round(integer(ls_tempo),ll_largo - 1)	
	ld_frac_devol = round(ll_frac_redondeada * ll_mconvera, ll_largo - 1)
	ii_fraccion = round(	ld_frac_devol / ll_divisor, ll_largo - 1)
end if
end subroutine

public subroutine wf_modifica_precio ();///Función que verifica el parámetro que define si se pueden modificar los precios o no
 string	ls_mod_precio

  SELECT faaparam.fara_modificar_precio  
    INTO :ls_mod_precio  
    FROM faaparam  
   WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
         ( faaparam.fara_empresa = :str.empresa )   ;

		if sqlca.sqlcode = -1 then
			mensaje("Aviso","Error al seleccionar el parametro",sqlca.sqlerrtext)
		end if

 if ls_mod_precio = 'S' then
	il_modifica = 1
else
	il_modifica = 0
end if
end subroutine

on w_fa_man_modi_devol_art.create
this.dw_1=create dw_1
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.dw_1,&
this.st_1,&
this.gb_1}
end on

on w_fa_man_modi_devol_art.destroy
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;this.postevent("ue_post_open")




end event

event resize;this.x = 5
this.y = 285
end event

event close;close(this)
end event

event key;if key = keyescape! then
	this.postevent("close")
end if
end event

type dw_1 from datawindow within w_fa_man_modi_devol_art
event ue_key pbm_dwnkey
event ue_enter pbm_dwnprocessenter
event ue_escape pbm_dwescape
integer x = 64
integer y = 76
integer width = 3150
integer height = 876
integer taborder = 20
string dataobject = "dw_ma_fa_ddevol"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_key;long ll_i
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
	this.SelectRow(This.GetRow() - 1, true)
ElseIf keyDown(KeyDownArrow!)then
	this.SelectRow(0,false)
	this.SelectRow(This.GetRow() + 1, true)
End If
end event

event ue_enter;this.triggerevent('doubleclicked')
end event

event ue_escape;parent.postevent("close")
end event

event clicked;//validaciones de las teclas
long ll_i

If keyDown(keyControl!) Then  
	If IsSelected(row) Then
		this.SelectRow(row,false)
	Else
		this.SelectRow(row,true)
	End if
ElseIf keyDown(KeyShift!) Then
	If row > il_old_row Then
		FOR ll_i = il_old_row TO row 
			this.SelectRow(ll_i,true)
		NEXT
	Else
		FOR ll_i = il_old_row TO row Step -1
			this.SelectRow(ll_i,true)
		NEXT
	End If
ElseIf keyDown(KeyLeftButton!) Then
	this.SelectRow(0,false)
	this.SelectRow(row,true)
End If
il_old_row = row

this.PostEvent("ue_despues_click")

end event

event doubleclicked;//Mueve la linea al DW del detalle de la Devolucion
string ls_pedido, ls_unidad_venta, ls_unidad_prod, ls_codigo
double ld_monto, ld_final, ld_precio, ld_descuento

long ll_pos, ll_ucom, ll_recorrido = 0, ll_linea, ll_cantidad, ll_fraccion, &
	  ll_total, ll_devuelta, ll_mconvera

for ll_recorrido = 1 to this.rowcount()
	if this.isSelected(ll_recorrido) or ll_recorrido = this.getrow() then
		
		//Seteo el numero de linea a un compute, para que el registro sea unico
		ll_linea = dw_1.getitemnumber(ll_recorrido,"facd_linea")		
		
		dw_1.setitem(ll_recorrido,"linea", ll_linea)
		dw_1.setitem(ll_recorrido,"facd_linea_articulo_dev", ll_linea)
		
		ll_cantidad = dw_1.getitemnumber(ll_recorrido,"facd_cantidad")		
		ll_fraccion = dw_1.getitemnumber(ll_recorrido,"facd_cantidad_fraccion")
		
		//Extraigo la cantidad devuelta
		ll_devuelta = this.Getitemnumber(ll_recorrido,"facd_cant_devuelta")

		dw_1.setitem(ll_recorrido,"cantidad", ll_cantidad)		
		dw_1.setitem(ll_recorrido, "fraccion", ll_fraccion)		
				
		ls_unidad_prod= dw_1.GetItemString(ll_recorrido,"facd_unidad_producto")
		ls_unidad_venta= dw_1.GetItemString(ll_recorrido,"facd_unidad_venta")		
		
		//Función que calcula la cantidad total del articulo en Piezas
		ll_total = wf_cantidad_total(ll_cantidad, ll_fraccion, ls_unidad_prod, ls_unidad_venta)
						
		dw_1.setitem(ll_recorrido, "devuelta", ll_devuelta)  //Cantidades devueltas
		dw_1.setitem(ll_recorrido, "total", ll_total)		
		
		//Tipo de medida de la unidad del producto	(UNIDADES, UNIDAD DE PESO, CONVERSIONES, ETC)
		// Devuleve 10 en caso de que sea una medida
		 ll_ucom = gf_medi_prod(ls_unidad_prod)
  
		 //* Carga Los Datos de Converción de la Unidad Actual
		 ll_mconvera = gf_unidad_venta(ls_unidad_venta, ll_ucom)
 
		if ll_mconvera = 0 or isnull(ll_mconvera) then
 			messagebox("ATENCIÓN SR. USUARIO", "Verifique las Unidades del Producto",Exclamation!)
			return 
 		end if
		
		ld_monto= This.GetItemnumber(ll_recorrido,"facd_monto_total")
		
		this.setitem(this.getrow(),"monto",ld_monto)		  	
		
		ld_final= This.GetItemNumber(ll_recorrido,"facd_monto_final")
		
	   this.setitem(this.getrow(),"monto_fin",ld_final)
		
		ls_pedido = str_argumen.pedido2 //Con el NC
		
		ll_pos = Pos(ls_pedido, "NC")
				
		dw_1.Setitem(ll_recorrido,"facd_no_pedido",ls_pedido)
		dw_1.Setitem(ll_recorrido,"facd_pedido_original",left(ls_pedido,ll_pos - 1))			
				
		if ll_total - ll_devuelta = 0 then
			ls_codigo = this.getitemstring(ll_recorrido,"facd_codigo_item")
			gf_mensaje("","El artículo " + ls_codigo + "  " + "fue devuelto en su totalidad", &
						  1,1,"E")			
			//messagebox("ATENCIÓN SR. USUARIO","El artículo " + ls_codigo + "  " + "fue devuelto en su totalidad")
		else	
			//Seteo la cantidad que se va a devolver, segun la unidad de venta del producto
			if ll_devuelta <> 0 then  //si ya se devolvio anteriormente
				wf_cantidad_a_devolver(ls_unidad_venta, ll_cantidad, ll_fraccion, ll_devuelta, ls_unidad_prod)
				
				ll_cantidad = ii_cantidad
				ll_fraccion = ii_fraccion
				
				dw_1.setitem(ll_recorrido,"facd_cantidad", ll_cantidad)		
				dw_1.setitem(ll_recorrido,"facd_cantidad_fraccion", ll_fraccion)		
				
				//Para que los compute tomen los valores iniciales, que se permitan devolver
				dw_1.setitem(ll_recorrido,"cantidad", ll_cantidad)		
				dw_1.setitem(ll_recorrido,"fraccion", ll_fraccion)		

				//Para que calcule los bultos de la mercancía a devolver
			   w_fa_man_modi_devolucion.dw_2.trigger event ue_bultos(ll_cantidad, ll_fraccion)		  
		
				ld_precio   = This.GetItemNumber(This.getrow(),"facd_precio_unidad_producto") 
				ld_monto  =  (ld_precio * ll_cantidad) + ( ( ld_precio / ll_mconvera ) * ll_fraccion )
 
				 this.setitem(this.getrow(),"facd_monto_total",ld_monto)
 				 this.setitem(this.getrow(),"monto",ld_monto) //Para restaurar en caso de error
 
				 if ld_descuento <> 0.00 then
					this.setitem(this.getrow(),"facd_monto_final",ld_monto - (ld_monto * (ld_descuento / 100) ))
				 	this.setitem(this.getrow(),"monto_fin",ld_monto - (ld_monto * (ld_descuento / 100) ))
				 else
				 	this.setitem(this.getrow(),"facd_monto_final",ld_monto)
				 	this.setitem(this.getrow(),"monto_fin",ld_monto) 
				 end if				 
			end if
			
			dw_1.RowsMove( ll_recorrido, ll_recorrido, primary!, w_fa_man_modi_devolucion.dw_2,100, primary!)
			w_fa_man_modi_devolucion.dw_2.setitem(w_fa_man_modi_devolucion.dw_2.rowcount(),"mod_precio",il_modifica)

		end if	
		
	end if

end for

if this.rowcount() = 0 then
	close(parent)
end if
end event

type st_1 from statictext within w_fa_man_modi_devol_art
integer x = 37
integer y = 992
integer width = 1179
integer height = 76
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_fa_man_modi_devol_art
integer x = 37
integer width = 3218
integer height = 964
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
end type

