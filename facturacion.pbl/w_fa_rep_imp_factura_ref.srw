//objectcomments  
forward
global type w_fa_rep_imp_factura_ref from w_fa_padre_reportes
end type
end forward

global type w_fa_rep_imp_factura_ref from w_fa_padre_reportes
integer width = 2789
integer height = 1532
string title = "(FA) Factura Resumida por Referencia"
string menuname = "m_fa_rep"
end type
global w_fa_rep_imp_factura_ref w_fa_rep_imp_factura_ref

type variables
//Variable tipo Estructura
str_fa_carg_ped str_pedi

//Flag para saber si hay Dos artículos iguales
integer ii_flag
end variables

forward prototypes
public subroutine wf_divide_incompletos (datawindow adw_1)
public function long wf_total_empaque (integer cantidad, datawindow adw_1, long arow)
public function double wf_unidad_conversion (datawindow adw_1, long arow)
public subroutine wf_imprime_vendedor ()
public function long wf_cantidad_total (integer cantidad, integer fraccion, datawindow adw_1, long row)
end prototypes

public subroutine wf_divide_incompletos (datawindow adw_1);//Divide los Productos en dos registros, si la cantidad despachada, no cuadra con el empaque
//del Producto

string	ls_unidad, ls_unidad_peso
integer	i, li_empaque, li_resultado, li_mod
double   ld_cantidad, ld_fraccion, ld_canti
long		ll_total_empaque, ll_total

ll_total = adw_1.Rowcount()

For i = 1 to ll_total
	
	//Recupera la Cantidad Total del Empaque
	li_empaque       = adw_1.GetitemNumber(i,"prod_empaque")
	ls_unidad		  = adw_1.GetitemString(i,"prod_empaque_um")
	ll_total_empaque = wf_total_empaque(li_empaque,adw_1,i)
	
	//Calcula la cantidad total de Unidades Facturadas
	ld_canti    = adw_1.GetItemNumber(i,"facd_cantidad")
	ld_fraccion = adw_1.GetItemNumber(i,"facd_cantidad_fraccion")
	ld_cantidad = wf_cantidad_total(ld_canti, ld_fraccion, adw_1, i)
	
	if ll_total_empaque <> 0 then //Para que no divida por cero
		li_mod = abs(mod(ld_cantidad, ll_total_empaque))	
		li_resultado = ld_cantidad / ll_total_empaque
	else
		li_resultado = ld_cantidad 
	end if

	if li_resultado <> 0 then //Si la cantidad facturada llega al empaque
			
		if li_mod <> 0 then
			ld_canti = li_resultado * ll_total_empaque
			adw_1.Setitem(i,"facd_cantidad",ld_canti)
			adw_1.Setitem(i,"facd_cantidad_fraccion",0)		
			adw_1.Setitem(i,"cambio","S")		//Para que cuando calcule la cantidad total,
														//solo lo haga para cuando no haya cambiado la fila
														//ya que aqui se setea las cantidades en piezas
			
			adw_1.InsertRow(i+1)		//Insertar una linea y todos los campos que se muestran
			adw_1.Setitem(i+1,"parcial","*")
			adw_1.Setitem(i+1,"mbod_cantidad",adw_1.GetitemNumber(i,"mbod_cantidad"))
	
			adw_1.Setitem(i+1,"facd_cantidad",li_mod)
			adw_1.Setitem(i+1,"disponible",adw_1.Getitemnumber(i,"disponible"))
			
			adw_1.Setitem(i+1,"facd_codigo_item",adw_1.GetitemString(i,"facd_codigo_item"))
			adw_1.Setitem(i+1,"facd_descripcion_alterna",adw_1.GetitemString(i,"facd_descripcion_alterna"))
			adw_1.Setitem(i+1,"facd_bodega",adw_1.GetitemString(i,"facd_bodega"))
			adw_1.Setitem(i+1,"facd_ubicacion",adw_1.GetitemString(i,"facd_ubicacion"))
			adw_1.Setitem(i+1,"prod_medida",adw_1.GetitemString(i,"prod_medida"))
			adw_1.Setitem(i+1,"prod_empaque",adw_1.GetitemNumber(i,"prod_empaque"))
			adw_1.Setitem(i+1,"prod_empaque_um",adw_1.GetitemString(i,"prod_empaque_um"))
			adw_1.Setitem(i+1,"medi_cantidad",adw_1.GetitemNumber(i,"medi_cantidad"))
			adw_1.Setitem(i+1,"facd_unidad_venta",adw_1.GetitemString(i,"facd_unidad_venta"))
			adw_1.Setitem(i+1,"facd_bultos",1)  //Es uno por default
	
	
			adw_1.Setitem(i+1,"facd_unidad_producto",adw_1.GetitemString(i,"facd_unidad_producto"))
			adw_1.Setitem(i+1,"facd_unidad_venta",adw_1.GetitemString(i,"facd_unidad_venta"))			
			
			adw_1.Setitem(i+1,"fact_unidad_peso",adw_1.GetitemString(i,"fact_unidad_peso"))
			adw_1.Setitem(i+1,"fact_peso_total",adw_1.GetitemNumber(i,"fact_peso_total"))
			adw_1.Setitem(i+1,"fact_cubicaje_total",adw_1.GetitemNumber(i,"fact_cubicaje_total"))
			adw_1.Setitem(i+1,"facd_usuario",adw_1.GetitemString(i,"facd_usuario"))			
			adw_1.Setitem(i+1,"fact_comentario",adw_1.GetitemString(i,"fact_comentario"))
			
			adw_1.Setitem(i+1,"fara_logo",adw_1.GetitemString(i,"fara_logo"))
			adw_1.Setitem(i+1,"fara_logo_f",adw_1.GetitemString(i,"fara_logo_f"))		
			ll_total = ll_total + 1
			i = i + 1
		end if
	 else
		///Si la cantidad facturada NO llega al empaque
			adw_1.Setitem(i,"parcial","*")
			adw_1.Setitem(i,"facd_bultos",1)  //Es uno por default		
	 end if
Next
 
end subroutine

public function long wf_total_empaque (integer cantidad, datawindow adw_1, long arow);//Función que devuelve la cantidad total pedida en piezas

 double ld_mconvera 
 string ls_unidad_prod, ls_unidad
 long   ll_ucom,  ll_total 
 
 ls_unidad_prod  = adw_1.GetItemString(arow,"facd_unidad_producto")
		
 ls_unidad = adw_1.GetItemString(arow,"prod_empaque_um")
  
 //Tipo de medida de la unidad del producto	(UNIDADES, UNIDAD DE PESO, CONVERSIONES, ETC)
 // Devuleve 10 en caso de que sea una medida  
  
 ll_ucom = gf_medi_prod(ls_unidad_prod)
  
 //* Carga Los Datos de Converción de la Unidad Actual
 ld_mconvera = gf_unidad_venta(ls_unidad, ll_ucom)
 
 if ld_mconvera = 0 or isnull(ld_mconvera) then
 
 	messagebox("ATENCIÓN SR. USUARIO", "Verifique las Unidades del Producto",Exclamation!)

	return 2
 
 end if

	ll_total = ( cantidad * ld_mconvera )

return (ll_total)
end function

public function double wf_unidad_conversion (datawindow adw_1, long arow);//Función que devuelve la cantidad total pedida en piezas

 double ld_mconver
 string ls_unidad_prod, ls_unidad_venta
 long   ll_ucom,  ll_total 
 
 ls_unidad_prod  = adw_1.GetItemString(arow,"facd_unidad_producto")
		
 ls_unidad_venta = adw_1.GetItemString(arow,"facd_unidad_venta")
  
 //Tipo de medida de la unidad del producto	(UNIDADES, UNIDAD DE PESO, CONVERSIONES, ETC)
 // Devuleve 10 en caso de que sea una medida  
  
 ll_ucom = gf_medi_prod(ls_unidad_prod)
  
 //* Carga Los Datos de Converción de la Unidad Actual
 ld_mconver = gf_unidad_venta(ls_unidad_venta, ll_ucom)
 
 if ld_mconver = 0 or isnull(ld_mconver) then
 
 	messagebox("ATENCIÓN SR. USUARIO", "Verifique las Unidades del Producto",Exclamation!)

	return 2
 
 end if
 
return(ld_mconver)
end function

public subroutine wf_imprime_vendedor ();integer li_hay, li_codigo, i=0
string  ls_nombre, ls_resultado, ls_nombre_imp, ls_cod_imp

datawindow ldw_1

ldw_1 = dw_1
		
		 DECLARE cur_vende CURSOR FOR
		  SELECT fadvenfa.vfac_vendedor,   
					famvende.vend_nombre+' '+famvende.vend_apellido nombre  
			 FROM fadvenfa,   
					famvende  
			WHERE ( famvende.vend_g_financiero = fadvenfa.vfac_g_financiero ) and  
					( famvende.vend_empresa = fadvenfa.vfac_empresa ) and  
					( famvende.vend_vendedor = fadvenfa.vfac_vendedor ) and  
					( ( fadvenfa.vfac_g_financiero = :str.g_financiero ) AND  
					( fadvenfa.vfac_empresa = :str.empresa ) AND  
					( fadvenfa.vfac_tipo = :str_pedi.tipo ) AND  
					( fadvenfa.vfac_no_pedido = :str_pedi.pedido ) AND  
					( fadvenfa.vfac_ann = :str_pedi.ano ) ) ;			 
	
 OPEN cur_vende;
 
 if sqlca.sqlcode = -1 then
	mensaje("Aviso","Error al Abrir el Cursor",sqlca.sqlerrtext)
 end if
 
 FETCH cur_vende INTO :li_codigo,:ls_nombre;
 
 IF SQLCA.SQLCODE = -1 THEN	
	MESSAGEBOX("ERROR","ERROR AL SELECCIONAR LOS VENDEDORES "+SQLCA.SQLERRTEXT)
	CLOSE cur_vende;
	RETURN
 END IF	
 
 DO WHILE SQLCA.SQLCODE = 0
	 if i > 0 then //Si no es la primera vez ni la ultima, separa el codigo
	 	ls_nombre_imp += ' / '
		ls_cod_imp	+= ' / '		
	 end if	 
	 ls_nombre_imp += ls_nombre 	     //Concatena los codigos y nombres
	 ls_cod_imp		+= string(li_codigo)	 
	 i ++	 //Incrementa la i
	 FETCH cur_vende INTO :li_codigo,:ls_nombre;	 
 loop
 
 ls_resultado = ldw_1.modify("cod_vendedor.text='"+ls_cod_imp+"'")
 ls_resultado = ldw_1.modify("nom_vendedor.text='"+ls_nombre_imp+"'")			
	 
 CLOSE cur_vende;
end subroutine

public function long wf_cantidad_total (integer cantidad, integer fraccion, datawindow adw_1, long row);//Función que devuelve la cantidad total pedida en piezas

 double ld_mconvera 
 string ls_unidad_prod, ls_unidad_venta
 long   ll_ucom,  ll_total 
 
 ls_unidad_prod  = adw_1.GetItemString(row,"facd_unidad_producto")
		
 ls_unidad_venta = adw_1.GetItemString(row,"facd_unidad_venta")
  
 //Tipo de medida de la unidad del producto	(UNIDADES, UNIDAD DE PESO, CONVERSIONES, ETC)
 // Devuleve 10 en caso de que sea una medida    
 ll_ucom = gf_medi_prod(ls_unidad_prod)
 
 //* Carga Los Datos de Converción de la Unidad Actual
 ld_mconvera = gf_unidad_venta(ls_unidad_venta, ll_ucom)
 
 if ld_mconvera = 0 or isnull(ld_mconvera) then
 
 	messagebox("ATENCIÓN SR. USUARIO", "Verifique las Unidades del Producto",Exclamation!)

	return 2
 
 end if

	ll_total = ( cantidad * ld_mconvera ) + fraccion

return (ll_total)
end function

on w_fa_rep_imp_factura_ref.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_fa_rep" then this.MenuID = create m_fa_rep
end on

on w_fa_rep_imp_factura_ref.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_post_open;//Override
string ls_empresa, ls_fecha, ls_hora
Datawindow ldw_1
Date	ld_fecha

ls_empresa = gf_dg_nombre_empresa()
st_nom_ventana.text = this.classname()

str_pedi.datawindow = trim(str_pedi.datawindow)

if pos(str.nombre_empresa,'ELECTROVISION') > 0 then 
	dw_1.dataobject = 'dw_fa_rep_actualiza_facturas'
else
	dw_1.dataobject = str_pedi.datawindow
end if

//dw_1.object.data = w_fa_rep_facturas_resumidas.dw_2.object.data
dw_1.object.data = str_pedi.dwobject.object.data

if dw_1.dataobject <> "" then

	m_fa_rep.m_edicin.m_filtrar.toolbaritemvisible = false
	m_fa_rep.m_edicin.m_sortear.toolbaritemvisible = false
	
	dw_1.object.datawindow.print.preview = true
//	dw_1.object.datawindow.print.preview.zoom =100
	dw_1.Modify("DataWindow.Print.Preview     = Yes")
	dw_1.Modify("DataWindow.Print.Margin.Top  = 01")
	dw_1.enabled = true
	dw_1.setfocus()

end if

If str_pedi.vienede = 'fact_res' then
	this.title = '(FA) Factura Resumida por Referencia'
	ld_fecha = date(dw_1.GetItemDateTime(1,"fact_fecha"))
	ls_fecha = gf_fecha_palabras(ld_fecha)
	if dw.Describe("fecha_c.x") <> "?" and dw.Describe("fecha_c.x") <> "!" then &
	dw_1.object.fecha_c.expression = "'"+ls_fecha+"'"
else
	If str_pedi.vienede = 'act_invent' then	
		this.title = '(FA) Reporte de Facturas a Actualizar a Inventario'
	else
		this.title = '(FA) Reporte de Facturas a Actualizar a Cuentas por Cobrar'
	end if
	ls_fecha = string(date(gf_fecha_serv()))
	ls_hora  = string(time(gf_fecha_serv()))
	if dw.Describe("fecha.x") <> "?" and dw.Describe("fecha.x") <> "!" then 
		dw_1.object.fecha.expression = "'"+ls_fecha+"'"
	end if
	if dw.Describe("hora.x") <> "?" and dw.Describe("hora.x") <> "!" then 
		dw_1.object.hora.expression = "'"+ls_hora+"'"
	end if
	if dw.Describe("data_window.x") <> "?" and dw.Describe("data_window.x") <> "!" then 
		dw_1.object.data_window.expression="'"+dw_1.dataobject+"'"
	end if
end if

IF w_fa_fondo.str_para.utiliza_decimales <> 1 then			
	if dw.Describe("empresa.x") <> "?" and dw.Describe("empresa.x") <> "!" then 
		dw_1.object.empresa.expression = "'"+ls_empresa+"'"
	end if
End If


str.frame.setredraw(true)
end event

event resize;//Override
this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 278
gb_1.width  = this.width  - 63
gb_1.height = this.height - 220


st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180
this.SetRedraw(true)
end event

event open;//Override
str.frame.Setredraw(false)
str_pedi = message.PowerObjectParm

gf_acelerador()
st_nom_ventana.text = this.classname()

This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)
str.frame.SetRedraw ( True )

This.Icon = str.icono
this.postevent("ue_post_open")

end event

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_rep_imp_factura_ref
integer x = 27
integer y = 1276
end type

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_rep_imp_factura_ref
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_rep_imp_factura_ref
integer x = 41
integer y = 64
integer width = 2651
integer height = 1148
integer taborder = 10
string dataobject = "dw_ca_fa_facturas_arancel_dapol1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_rep_imp_factura_ref
integer x = 18
integer y = 4
integer width = 2702
integer height = 1236
integer taborder = 20
end type

