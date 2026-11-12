//objectcomments Ventana en donde se Desplegará el Data Window de impresion del Picking List de la Bodega
forward
global type w_fa_rep_imp_picking_list from w_fa_padre_reportes
end type
type dw_2 from datawindow within w_fa_rep_imp_picking_list
end type
type pb_5 from picturebutton within w_fa_rep_imp_picking_list
end type
end forward

global type w_fa_rep_imp_picking_list from w_fa_padre_reportes
integer width = 3333
integer height = 1752
string title = "Informe de Picking List"
string menuname = "m_fa_rep"
dw_2 dw_2
pb_5 pb_5
end type
global w_fa_rep_imp_picking_list w_fa_rep_imp_picking_list

type variables
//Variable tipo Estructura
str_fa_carg_ped str_pedi
boolean ib_disparar_close = true
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
string  ls_nombre, ls_resultado, ls_nombre_imp, ls_cod_imp, ls_dataobject

datawindow ldw_1

ldw_1 = dw_1

ls_dataobject = dw_1.dataobject

if pos(ls_dataobject,"_prof",1) > 0 then  //Para cuando es proforma
		 DECLARE cur_vende_prof CURSOR FOR
		  SELECT fadvenpr.vpro_vendedor,   
					famvende.vend_nombre+' '+famvende.vend_apellido nombre  
			 FROM fadvenpr,   
					famvende  
			WHERE ( famvende.vend_g_financiero = fadvenpr.vpro_g_financiero ) and  
					( famvende.vend_empresa = fadvenpr.vpro_empresa ) and  
					( famvende.vend_vendedor = fadvenpr.vpro_vendedor ) and  
					( ( fadvenpr.vpro_g_financiero = :str.g_financiero ) AND  
					( fadvenpr.vpro_empresa = :str.empresa ) AND  
					( fadvenpr.vpro_no_proforma = :str_pedi.pedido ) AND  
					( fadvenpr.vpro_ann = :str_pedi.ano ) ) ;			
					
		 OPEN cur_vende_prof;
		 
		 if sqlca.sqlcode = -1 then
			mensaje("Aviso","Error al Abrir el Cursor",sqlca.sqlerrtext)
		 end if
		 
		 FETCH cur_vende_prof INTO :li_codigo,:ls_nombre;
		 
		 IF SQLCA.SQLCODE = -1 THEN	
			MESSAGEBOX("ERROR","ERROR AL SELECCIONAR LOS VENDEDORES "+SQLCA.SQLERRTEXT)
			CLOSE cur_vende_prof;
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
			 FETCH cur_vende_prof INTO :li_codigo,:ls_nombre;	 
		 loop
		 
		 ls_resultado = ldw_1.modify("cod_vendedor.text='"+ls_cod_imp+"'")
		 ls_resultado = ldw_1.modify("nom_vendedor.text='"+ls_nombre_imp+"'")			
			 
		 CLOSE cur_vende_prof;

elseif pos(ls_dataobject,"_ped",1) > 0 then  //Para cuando es pedido
		
		 DECLARE cur_vende_pe CURSOR FOR
		  SELECT fadvenpe.vped_vendedor,   
					famvende.vend_nombre+' '+famvende.vend_apellido nombre  
			 FROM fadvenpe,   
					famvende  
			WHERE ( famvende.vend_g_financiero = fadvenpe.vped_g_financiero ) and  
					( famvende.vend_empresa = fadvenpe.vped_empresa ) and  
					( famvende.vend_vendedor = fadvenpe.vped_vendedor ) and  
					( ( fadvenpe.vped_g_financiero = :str.g_financiero ) AND  
					( fadvenpe.vped_empresa = :str.empresa ) AND  
					( fadvenpe.vped_no_pedido = :str_pedi.pedido ) AND  
					( fadvenpe.vped_ann = :str_pedi.ano ) ) ;			
					
		 OPEN cur_vende_pe;
		 
		 if sqlca.sqlcode = -1 then
			mensaje("Aviso","Error al Abrir el Cursor",sqlca.sqlerrtext)
		 end if
		 
		 FETCH cur_vende_pe INTO :li_codigo,:ls_nombre;
		 
		 IF SQLCA.SQLCODE = -1 THEN	
			MESSAGEBOX("ERROR","ERROR AL SELECCIONAR LOS VENDEDORES "+SQLCA.SQLERRTEXT)
			CLOSE cur_vende_pe;
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
			 FETCH cur_vende_pe INTO :li_codigo,:ls_nombre;	 
		 loop
		 
		 ls_resultado = ldw_1.modify("cod_vendedor.text='"+ls_cod_imp+"'")
		 ls_resultado = ldw_1.modify("nom_vendedor.text='"+ls_nombre_imp+"'")			
			 
		 CLOSE cur_vende_pe;
							
	
else		//Para cuando es factura
	
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
		 
 end if	//del pos
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

on w_fa_rep_imp_picking_list.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_fa_rep" then this.MenuID = create m_fa_rep
this.dw_2=create dw_2
this.pb_5=create pb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.pb_5
end on

on w_fa_rep_imp_picking_list.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.pb_5)
end on

event ue_post_open;
//Override
Integer li_existe
string ls_empresa
ls_empresa = gf_dg_nombre_empresa()
st_nom_ventana.text = this.classname()

if dw_1.dataobject <> "" then
	 
	 choose case str_pedi.vienede
		case 'FA'

			If isNull(str_pedi.datawindow) then messagebox("dataobject Nulo",'')
						
			if dw_1.retrieve(str.g_financiero,str.empresa,str_pedi.tipo, str_pedi.pedido,str_pedi.ano) < 1 then
				gf_mensaje("","La Factura No Existe",1,1,"E")				
				str.frame.setredraw(true)				
				return
			end if
			//Para Asignar el Orden por default, si es 2 o nulo, queda con el orden por índice o creacion
			if w_fa_fondo.str_para.orden = 0 then //Orden por codigo
				dw_1.SetSort('facd_codigo_item A')
				dw_1.Sort()	
			elseif w_fa_fondo.str_para.orden = 1 then //Orden por descripcion
				dw_1.SetSort('facd_descripcion_alterna A facd_codigo_item A')
				dw_1.Sort()	
			else
				dw_1.SetSort('facd_index A')
				dw_1.Sort()	
			end if			

			//Si tienen seleccionada alguna ubicacion en transito, en parámetros
			if trim(w_fa_fondo.str_para.ubicacion_en_transito) <> '' and not isnull(w_fa_fondo.str_para.ubicacion_en_transito) then
				if dw_1.Describe("facd_ubicacion.x") <> "?" and dw_1.Describe("facd_ubicacion.x") <> "!" then 	 
					dw_1.setfilter("facd_ubicacion <> '"+w_fa_fondo.str_para.ubicacion_en_transito+"'")
					dw_1.filter()	
				end if
			end if
			
		CASE 'PE'

			if dw_1.retrieve(str.g_financiero,str.empresa, str_pedi.pedido,str_pedi.ano) < 1 then
				gf_mensaje("","El Pedido No Existe",1,1,"E")
				str.frame.setredraw(true)
				return
			end if
			//Para Asignar el Orden por default, si es 2 o nulo, queda con el orden por índice o creacion
			if w_fa_fondo.str_para.orden = 0 then //Orden por codigo
				dw_1.SetSort('dped_codigo_item A')
				dw_1.Sort()	
			elseif w_fa_fondo.str_para.orden = 1 then //Orden por descripcion,codigo
				dw_1.SetSort('dped_descripcion_alterna A dped_codigo_item A')
				dw_1.Sort()	
			else
				dw_1.SetSort('dped_index A')
				dw_1.Sort()	
			end if
			
			//Si tienen seleccionada alguna ubicacion en transito, en parámetros
			if trim(w_fa_fondo.str_para.ubicacion_en_transito) <> '' and not isnull(w_fa_fondo.str_para.ubicacion_en_transito) then
				if dw_1.Describe("dped_ubicacion.x") <> "?" and dw_1.Describe("dped_ubicacion.x") <> "!" then 	 				
					dw_1.setfilter("dped_ubicacion <> '"+w_fa_fondo.str_para.ubicacion_en_transito+"'")
					dw_1.filter()	
				end if
			end if
			
			  SELECT isnull(count(*)  ,0)
				 INTO :li_existe  
				 FROM fatpedid  
				WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
						( fatpedid.pedi_empresa = :str.empresa ) AND  
						( fatpedid.pedi_no_pedido = :str_pedi.pedido ) AND  
						( fatpedid.pedi_ann = :str_pedi.ano ) AND  
						( fatpedid.pedi_estado = 'R' )   ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Buscar Estado '+sqlca.sqlerrtext,1,1,'E')
					end if
				
				if li_existe = 0 then
					gf_mensaje('','El Pedido No Ha Sido Aprobado Aun, Verifique !!!',1,1,'Q')
				end if
					
		CASE 'PR'

			if dw_1.retrieve(str.g_financiero,str.empresa, str_pedi.pedido,str_pedi.ano) < 1 then
				gf_mensaje("","La Proforma No Existe",1,1,"E")
				str.frame.setredraw(true)				
				return
			end if		
			//Para Asignar el Orden por default, si es 2 o nulo, queda con el orden por índice o creacion
			if w_fa_fondo.str_para.orden = 0 then //Orden por codigo
				dw_1.SetSort('dpro_codigo_item A')
				dw_1.Sort()	
			elseif w_fa_fondo.str_para.orden = 1 then //Orden por descripcion,codigo
				dw_1.SetSort('dpro_descripcion_alterna A dpro_codigo_item A')
				dw_1.Sort()	
			else
				dw_1.SetSort('dpro_index A')
				dw_1.Sort()	
			end if
			//Si tienen seleccionada alguna ubicacion en transito, en parámetros
			if trim(w_fa_fondo.str_para.ubicacion_en_transito) <> '' and not isnull(w_fa_fondo.str_para.ubicacion_en_transito) then
				if dw_1.Describe("dpro_ubicacion.x") <> "?" and dw_1.Describe("dpro_ubicacion.x") <> "!" then 	 				
					dw_1.setfilter("dpro_ubicacion <> '"+w_fa_fondo.str_para.ubicacion_en_transito+"'")
					dw_1.filter()	
				end if
			end if			
			
	 end choose		

	time lt_hora
	date ldt_fecha
	ldt_fecha = date(gf_fecha_serv())
	dw_1.object.fech.expression = "'"+string(ldt_fecha)+"'"
	lt_hora = time(gf_fecha_serv())
	dw_1.object.hora.expression = "'"+string(lt_hora)+"'"

	if dw_1.dataobject = 'dw_fa_rep_picking_list_fac_tempo_cuba' then
		dw_1.modify("DataWindow.Zoom='80'")
	elseif dw_1.dataobject = 'dw_fa_rep_picking_list_fac_tempo_resum' then
		//dw_1.modify("DataWindow.Zoom='95'")
	end if

	dw_1.object.datawindow.print.preview = true
	dw_1.object.datawindow.print.preview.zoom=100
	dw_1.object.nom_empresa.expression = "'"+ls_empresa+"'"
	dw_impresion = dw_1													//Para los eventos de Zoom + / -
//	dw_1.object.datawin.expression = "'"+dw_1.dataobject+"'"	//Setea el nombre del Datawindow
	dw_1.SetFocus() //Setea el Foco al DW, puede dar Escape
	
	str.frame.setredraw(true)

	if str_pedi.directo_al_printer then
		this.triggerevent('ue_print')
		if ib_disparar_close then this.postevent('close')
	end if
	
	
end if
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
li_w_ancho = newwidth
gf_centrar_dw(this,dw_1,gb_1,st_nom_ventana)
this.SetRedraw(true)


end event

event open;call super::open;//m_fa_rep.disable()
SQLCA.autocommit = true
str.frame.Setredraw(false)
str_pedi = message.PowerObjectParm
If isNull(str_pedi) then messagebox("Verifique","Estructura nula")

str_pedi.datawindow = trim(str_pedi.datawindow)

dw_1.DataObject = str_pedi.datawindow
dw= dw_1
dw_1.settransobject(sqlca)

end event

event ue_print;//override
OpenWithParm(w_dw_print_options, dw)
If Message.DoubleParm = -1 Then 
	ib_disparar_close = false
	Return
end if
ib_disparar_close = false
dw.Print(True)
end event

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_rep_imp_picking_list
integer x = 23
integer y = 1512
end type

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_rep_imp_picking_list
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_rep_imp_picking_list
integer x = 37
integer y = 60
integer width = 3214
integer height = 1432
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event dw_1::retrieveend;call super::retrieveend;// Función que Verifica si hay bultos que no son completos

integer i, li_medida, li_mod, li_resultado, li_reg
string  ls_codigo, ls_unidad, ls_observacion
decimal ld_reserva_total, ld_existencia, ld_existencia_fraccion, ld_total, ld_fraccion, ld_conversion, ld_costo_fob, ld_cantidad, ld_cantidad_1, &
		  ld_cantidad_total
sqlca.autocommit = true
if str_pedi.vienede =  'PE' then

	for li_reg = 1 to rowcount()
	
		ls_codigo = dw_1.getitemstring(li_reg, 'facd_codigo_item')
		dw_2.retrieve(str.g_financiero, str.empresa, ls_codigo)
		
		if dw_2.rowcount() > 0 then
			ld_reserva_total = dw_2.getitemnumber(1,'reserva_total')
			  SELECT sum(isnull(prod_existencia_total,0))  
			 INTO :ld_existencia  
			 FROM inmprodu  
			WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
					( inmprodu.prod_empresa in (:str.empresa, 8) ) AND  
					( inmprodu.prod_producto = :ls_codigo )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Buscar Existencia '+sqlca.sqlerrtext,1,1,'E')
				end if
//			ld_existencia 	  = dw_1.getitemnumber(li_reg,'existencia_total')
			ls_unidad 		  = dw_1.getitemstring(li_reg,'facd_unidad_venta')
			//Para restar lo de el pedido actual y no reflejar la disminucion dos veces
			ld_cantidad		  = dw_1.getitemNumber(li_reg,'facd_cantidad')		
			ld_cantidad_1	  = dw_1.getitemNumber(li_reg,'facd_cantidad_fraccion')		
			ld_conversion	  = gf_unidad_venta(ls_unidad, 10)
			ld_cantidad_total= (ld_cantidad * ld_conversion) + ld_cantidad_1	//cantidad pedida
			
			ld_total			  = truncate( (ld_existencia - ld_reserva_total + ld_cantidad_total) / ld_conversion, 0)
			dw_1.setitem(li_reg, 'disponible', ld_total)
			ld_fraccion = (((ld_existencia - ld_reserva_total + ld_cantidad_total) / ld_conversion) - truncate( (ld_existencia - ld_reserva_total + ld_cantidad_total ) / ld_conversion ,0 )) * 12
			dw_1.setitem(li_reg, 'disponible_fraccion', ld_fraccion  )
	
			ld_total			  = truncate( (ld_existencia - ld_reserva_total) / ld_conversion, 0)
			dw_1.setitem(li_reg, 'disponible_real', ld_total)
			ld_fraccion = (((ld_existencia - ld_reserva_total) / ld_conversion) - truncate( (ld_existencia - ld_reserva_total ) / ld_conversion ,0 )) * 12
			dw_1.setitem(li_reg, 'disponible_fraccion_real', ld_fraccion  )	
		
		end if	
		
		select prod_color_spaniol into :ls_observacion from inmprodu where prod_g_financiero = :str.g_financiero and prod_empresa = :str.empresa and prod_producto = :ls_codigo ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al buscar observacion '+sqlca.sqlerrtext,1,1,'E')
		end if
		if pos(upper(ls_observacion),'BC') > 0 then
			this.setitem(li_reg,'bad_composition',1)
		end if
		
	next
	
END IF
//Para Imprimir el codigo o el nombre de los vendedores
wf_imprime_vendedor()
sqlca.autocommit = true
end event

event dw_1::sqlpreview;call super::sqlpreview;//messagebox("",sqlsyntax)
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_rep_imp_picking_list
integer x = 18
integer y = 4
integer width = 3264
integer height = 1504
end type

type dw_2 from datawindow within w_fa_rep_imp_picking_list
boolean visible = false
integer x = 160
integer y = 120
integer width = 411
integer height = 432
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_fa_rep_reservados"
boolean livescroll = true
end type

event constructor;dw_2.settransobject(sqlca)
end event

type pb_5 from picturebutton within w_fa_rep_imp_picking_list
boolean visible = false
integer x = 3045
integer width = 128
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Harr2000\Art\excel.jpg"
alignment htextalign = left!
end type

event clicked;string ls_file

ls_file = '' //'Picking_de_Ped_'+dw_1.getitemstring(dw_1.getrow(),'pedi_no_pedido')

u_cfol_dw_excel	luo_excel

luo_excel = CREATE u_cfol_dw_excel

//luo_excel.of_initialize ( w_fa_rep_imp_picking_list, dw_1.dataobject, ls_file )

DESTROY luo_excel

end event

