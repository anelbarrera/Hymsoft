forward
global type w_reservados from w_fa_padre_reportes
end type
type cb_imprimir from commandbutton within w_reservados
end type
type st_1 from statictext within w_reservados
end type
type dw_3 from datawindow within w_reservados
end type
type cb_cosultar from commandbutton within w_reservados
end type
type st_2 from statictext within w_reservados
end type
type dw_productos from datawindow within w_reservados
end type
type cb_1 from commandbutton within w_reservados
end type
type dw_2 from datawindow within w_reservados
end type
end forward

global type w_reservados from w_fa_padre_reportes
integer x = 46
integer y = 240
integer width = 3392
integer height = 2460
string title = "(FA) Consulta de Productos Reservados "
cb_imprimir cb_imprimir
st_1 st_1
dw_3 dw_3
cb_cosultar cb_cosultar
st_2 st_2
dw_productos dw_productos
cb_1 cb_1
dw_2 dw_2
end type
global w_reservados w_reservados

type variables
Datawindowchild dwc_producto
long ll_dw_ancho,ll_dw_alto
integer ii_flag = 1,ii_sw = 1
end variables

forward prototypes
public subroutine wf_actualizar_reservado (string as_producto)
public subroutine wf_recuperar (string data)
end prototypes

public subroutine wf_actualizar_reservado (string as_producto);string ls_error

//mensaje("Atención","Sr. Usuario, procure que al Ejecutar este Proceso, ningún usuario esté utilizando los Archivos de Facturación o Inventario, ya que se puede Bloquear la Base de datos e Incurrir en la Perdida de Datos.","")

//if gf_mensaje("","¿ Está seguro de Actualizar los Productos Reservados ? ",2,1,"E") = 1 then

// str.frame.setmicrohelp("Inicializando los Productos Reservados.............por favor Espere")

 sqlca.autocommit = false  

//str.frame.setmicrohelp("Actualizando los Productos Reservados.............por favor Espere")

/*Actualiza los reservados del producto, procedentes de pedidos*/

  UPDATE inmprodu  
     SET prod_reserva_total = 0
    FROM inmprodu
   WHERE	( inmprodu.prod_g_financiero = :str.g_financiero ) and
			( inmprodu.prod_empresa = :str.empresa) and
			( inmprodu.prod_producto = :as_producto );
	  if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje("Aviso","Error al Actualizar las Reservas de los Productos a 0",ls_error)
		sqlca.autocommit = true
		return
	  end if
	  
	  
  UPDATE inmprodu  
     SET prod_reserva_total = vi_reserva.reservado  
    FROM inmprodu,   
         vi_reserva  
   WHERE ( inmprodu.prod_g_financiero = vi_reserva.dped_g_financiero ) AND  
         ( inmprodu.prod_empresa = vi_reserva.dped_empresa ) AND  
         ( inmprodu.prod_producto = vi_reserva.dped_codigo_item )  and
			( inmprodu.prod_g_financiero = :str.g_financiero ) and
			( inmprodu.prod_empresa = :str.empresa) and
			( inmprodu.prod_producto = :as_producto );
	  if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje("Aviso","Error al Actualizar las Reservas de los Productos ",ls_error)
		sqlca.autocommit = true
		return
	  end if

/*Actualiza los reservados del producto, procedentes de factura*/
  UPDATE inmprodu  
     SET prod_reserva_total = prod_reserva_total + vi_reserva_fac.reservado
    FROM inmprodu,   
         vi_reserva_fac  
   WHERE ( inmprodu.prod_g_financiero = vi_reserva_fac.facd_g_financiero ) AND  
         ( inmprodu.prod_empresa = vi_reserva_fac.facd_empresa ) AND  
         ( inmprodu.prod_producto = vi_reserva_fac.facd_codigo_item ) AND
			( inmprodu.prod_g_financiero = :str.g_financiero ) and
			( inmprodu.prod_empresa = :str.empresa) and			
			( inmprodu.prod_producto = :as_producto);
			
	  if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje("Aviso","Error al Actualizar las Reservas de Productos ",ls_error)
		sqlca.autocommit = true
		return
	  end if

/*Para actualizar las cantidades pasadas con la cantidad total del Registro, si la cantidad
 pasada es mayor a la total*/
  UPDATE fadpedid  
     SET dped_pasada = fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion  
    FROM fadpedid,   
         inamedid  
   WHERE ( fadpedid.dped_pasada > fadpedid.dped_cantidad * inamedid.medi_cantidad + fadpedid.dped_fraccion ) AND  
         ( fadpedid.dped_unidad_venta = inamedid.medi_medida ) and
			( fadpedid.dped_g_financiero = :str.g_financiero ) and
			( fadpedid.dped_empresa	=	:str.empresa ) and
			( fadpedid.dped_codigo_item = :as_producto);
			
	  if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje("Aviso","Error al Actualizar las Cantidades Pasadas",ls_error)
		sqlca.autocommit = true
		return
	  end if

/*Actualiza los reservados por bodega, procedentes de factura*/
// str.frame.setmicrohelp("Actualizando los Productos Reservados por Bodega.............por favor Espere")

  UPDATE inmbodeg  
     SET mbod_reserva = 0
    FROM inmbodeg
   WHERE ( inmbodeg.mbod_g_financiero = :str.g_financiero ) and
			( inmbodeg.mbod_empresa = :str.empresa) and
			( inmbodeg.mbod_producto = :as_producto);
			
	  if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje("Aviso","Error al Actualizar las Reservas de productos por bodega a 0 ",ls_error)
		sqlca.autocommit = true
		return
	  end if


  UPDATE inmbodeg  
     SET mbod_reserva = vi_reserva_fac_bodega.reservado
    FROM inmbodeg,   
         vi_reserva_fac_bodega  
   WHERE ( inmbodeg.mbod_g_financiero = vi_reserva_fac_bodega.facd_g_financiero ) AND  
         ( inmbodeg.mbod_empresa = vi_reserva_fac_bodega.facd_empresa ) AND  
         ( inmbodeg.mbod_bodega = vi_reserva_fac_bodega.facd_bodega ) AND  
         ( inmbodeg.mbod_ubicacion = vi_reserva_fac_bodega.facd_ubicacion ) AND  
         ( inmbodeg.mbod_producto = vi_reserva_fac_bodega.facd_codigo_item ) AND
			( inmbodeg.mbod_g_financiero = :str.g_financiero ) and
			( inmbodeg.mbod_empresa = :str.empresa) and
			( inmbodeg.mbod_producto = :as_producto);
			
	  if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje("Aviso","Error al Actualizar las Reservas de productos por bodega ",ls_error)
		sqlca.autocommit = true
		return
	  end if
			

/*Actualiza los reservados por bodega, procedentes de pedidos*/
  UPDATE inmbodeg  
     SET mbod_reserva = mbod_reserva  +  vi_reserva_ped_bodega.reservado
    FROM inmbodeg,   
         vi_reserva_ped_bodega  
   WHERE ( inmbodeg.mbod_g_financiero = vi_reserva_ped_bodega.dped_g_financiero ) AND  
         ( inmbodeg.mbod_empresa = vi_reserva_ped_bodega.dped_empresa ) AND  
         ( inmbodeg.mbod_bodega = vi_reserva_ped_bodega.dped_bodega ) AND  
         ( inmbodeg.mbod_ubicacion = vi_reserva_ped_bodega.dped_ubicacion ) AND  
         ( inmbodeg.mbod_producto = vi_reserva_ped_bodega.dped_codigo_item ) AND
			( inmbodeg.mbod_g_financiero = :str.g_financiero ) and
			( inmbodeg.mbod_empresa = :str.empresa) and			
			( inmbodeg.mbod_producto = :as_producto );
			
	  if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje("Aviso","Error al Actualizar las Reservas de productos por bodega ",ls_error)
		sqlca.autocommit = true
		return
	  end if
	
	
	//Si no manda error , guarda en la base de datos
	
	commit;

	sqlca.autocommit = true	
	
//	gf_mensaje("","Actualización Exitosa de los Reservados",1,1,"E")
	
//end if //Del messagebox Aceptar o Cancelar
end subroutine

public subroutine wf_recuperar (string data);	 integer i
    double ld_existencia, ld_reserva, ld_fac_conver
    String   ls_descripcion,ls_prod_uni, ls_foto
			
  SELECT productos.prod_descripcion,
			productos.prod_unidad
    INTO :ls_descripcion,
			:ls_prod_uni			
    FROM productos  
   WHERE ( productos.prod_g_financiero = :str.g_financiero ) AND  
         ( productos.prod_empresa = :str.empresa ) AND  
         ( productos.prod_producto = :data )   ;

		if SQLCA.sqlcode = 0 then

		//	ld_fac_conver = gf_unidad_venta(ls_prod_uni, gf_medi_prod(ls_prod_uni))

		//	if IsNull(ld_fac_conver) OR ld_fac_conver = 0 then ld_fac_conver = 1 
				
		//	ld_existencia = round(ld_existencia/ld_fac_conver,2)
		//	ld_reserva    = round(ld_reserva/ld_fac_conver,2)
			
			dw_2.SetItem(1,"prod_descripcion",ls_descripcion)
			dw_2.SetItem(1,"prod_unidad",ls_prod_uni)			
			
			  SELECT sum( orden_detalle.deta_cantidad )  
				 INTO :ld_existencia  
				 FROM orden_detalle  
				WHERE ( orden_detalle.deta_g_financiero = :str.g_financiero ) AND  
						( orden_detalle.deta_empresa = :str.empresa ) AND  
						( orden_detalle.deta_referencia = :data )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al buscar existencias '+sqlca.sqlerrtext,1,1,'E')
				end if
			
			dw_2.SetItem(1,"existencia",ld_existencia)
			
			  SELECT sum( dped_cantidad )  
				 INTO :ld_reserva
				 FROM pedidos_detalle  
				WHERE ( pedidos_detalle.dped_g_financiero = :str.g_financiero ) AND  
						( pedidos_detalle.dped_empresa = :str.empresa ) AND  
						( pedidos_detalle.dped_producto = :data )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al buscar reserva '+sqlca.sqlerrtext,1,1,'E')
				end if
			
			dw_2.SetItem(1,"reservados",ld_reserva)
			
		//	dw_2.SetItem(1,"prod_medida",ls_prod_uni)
		//	dw_2.SetItem(1,"multiplicador",ld_fac_conver)
			dw_2.Setitem(1,"prod_producto",data)

			this.setredraw(false)
			if dw_1.retrieve(str.g_financiero,str.empresa,data) > 0 then
				for i = 1 to dw_1.rowcount()
					dw_1.SetItem(i,"existencia",ld_existencia)
				next
			end if
			this.setredraw(true)
			If dw_1.rowcount() > 0 then
				cb_imprimir.enabled = true
			else
				cb_imprimir.enabled = false
			end if
		else
			mensaje("Atención ","Código No existe ...!!!","")
			dw_2.SetItem(1,"prod_descripcion",'')
			dw_2.SetItem(1,"existencia",0)
			dw_2.SetItem(1,"reservados",0)
			dw_2.Setitem(1,"prod_producto",data)
		end if

end subroutine

on w_reservados.create
int iCurrent
call super::create
this.cb_imprimir=create cb_imprimir
this.st_1=create st_1
this.dw_3=create dw_3
this.cb_cosultar=create cb_cosultar
this.st_2=create st_2
this.dw_productos=create dw_productos
this.cb_1=create cb_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_imprimir
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.cb_cosultar
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.dw_productos
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.dw_2
end on

on w_reservados.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_imprimir)
destroy(this.st_1)
destroy(this.dw_3)
destroy(this.cb_cosultar)
destroy(this.st_2)
destroy(this.dw_productos)
destroy(this.cb_1)
destroy(this.dw_2)
end on

event resize;//Override
this.SetRedraw(false)

st_nom_ventana.y = newheight - (st_nom_ventana.height + 10)
cb_1.y = newheight - (cb_1.height + 10)
dw_1.x=46
dw_1.y=325

ll_dw_ancho = newwidth - 100
ll_dw_alto  = newheight - 180 - 280

dw_1.Resize(ll_dw_ancho, ll_dw_alto)
gb_1.x = dw_1.x - 40
gb_1.y = dw_1.y - 40
gb_1.Width  = ll_dw_ancho + 80
gb_1.Height = ll_dw_alto  + 80

this.SetRedraw(true)

end event

event ue_post_open;//Override
long		ll_especial
string ls_producto

//gf_center_win(This)
//this.y=1
//This.SetRedraw(False)

dw_1.settransobject(sqlca);

//para verificar si se solicito la opcion desde pedidos o de proformas

dw_2.GetChild("prod_producto",dwc_producto)

dwc_producto.SetTransObject(SQLCA);

If dwc_producto.retrieve(str.g_financiero,str.empresa) < 1 then dwc_producto.Insertrow(0)

dw_2.settransobject(sqlca)
dw_2.scrollToRow(dw_2.Insertrow(0))
dw_3.settransobject(sqlca)
dw_1.scrollToRow(dw_1.Insertrow(0))
st_nom_ventana.text = This.Classname()

/*RECUPERA LOS PRODUCTOS*/
dw_productos.settransobject(sqlca)
if dw_productos.retrieve(str.g_financiero, str.empresa) = 0 then
	messagebox("Atencion","No hay productos para consultar...Verifique")
end if

//Si se envia el producto como argumento desde el kardex
if len(ls_producto) > 0 then
	dw_2.setitem(1,"prod_producto",ls_producto)		
	dw_2.accepttext()
	dw_2.Post Event ue_postitemchanged(ls_producto,1,"prod_producto")
end if

this.y = 0
this.x = 805

dw_2.setfocus()

This.SetRedraw(True)
end event

event ue_print;OpenWithParm(w_dw_print_options, dw_3)
If Message.DoubleParm = -1 Then Return
dw_3.Print(True)
end event

event ue_primer_reg;//Override
long ll_row
string ls_codigo, ls_sort
	dw_productos.scrolltorow(1)
	ls_codigo = dw_productos.getitemstring(1,'producto')
	wf_recuperar(ls_codigo)
		if dw_2.object.color_orden.expression = '1' then
			dw_2.setcolumn(2)
		end if

end event

event ue_reg_anterior;//override
long ll_row
string ls_codigo, ls_sort
	ll_row = dw_productos.getrow()
	if ll_row > 1 then
		dw_productos.scrolltorow(ll_row - 1)
		ls_codigo = dw_productos.getitemstring(ll_row - 1,'producto')
		wf_recuperar(ls_codigo)
		if dw_2.object.color_orden.expression = '1' then
			dw_2.setcolumn(2)
		end if		
	end if	

end event

event ue_siguiente_reg;//override
long ll_row
string ls_codigo, ls_sort
	ll_row = dw_productos.getrow()
	if ll_row < dw_productos.rowcount() then
		dw_productos.scrolltorow(ll_row + 1)
		ls_codigo = dw_productos.getitemstring(ll_row + 1,'producto')
//		sqlca.autocommit = true;				
//		if dw_1.retrieve(str.g_financiero, str.empresa, ls_codigo) = 0 then
//			messagebox("Atencion","No se encontro el producto "+ ls_codigo)
//		end if
//		sqlca.autocommit = false;		
		wf_recuperar(ls_codigo)
		if dw_2.object.color_orden.expression = '1' then
			dw_2.setcolumn(2)
		end if
	end if		
end event

event ue_ultimo_reg;//Override
long ll_row
string ls_codigo, ls_sort
	ll_row = dw_productos.rowcount()
	if ll_row > 1 then
		dw_productos.scrolltorow(ll_row)
		ls_codigo = dw_productos.getitemstring(ll_row,'producto')
		wf_recuperar(ls_codigo)
		if dw_2.object.color_orden.expression = '1' then
			dw_2.setcolumn(2)
		end if		
	end if	

end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_reservados
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_reservados
boolean visible = false
integer x = 32
integer y = 1296
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_reservados
event ue_down pbm_dwnkey
integer x = 23
integer y = 360
integer width = 3227
integer height = 1796
integer taborder = 10
string dataobject = "dw_detalle_reservados"
boolean vscrollbar = true
end type

event dw_1::ue_down;string ls_codigo
if keydown(KeyF5!) then
	ls_codigo = dw_productos.getitemstring(dw_productos.getrow(),"producto")
	dw_2.trigger event itemchanged(dw_2.getrow(),dw_2.object.prod_producto,ls_codigo)	
end if
end event

event dw_1::retrieveend;call super::retrieveend;//Double	ld_existencia, ld_fac_conver
//Decimal  ld_reserva_total, ld_reserva_fraccion, ld_reserva_completa, ld_reserva_total_unidades
//Long		ll_row
//String	ls_prod_uni, ls_producto
//ld_existencia = dw_2.GetItemNumber(1,"prod_existencia_total")
//ls_prod_uni   = dw_2.GetItemString(1,"prod_medida")
//ls_producto   = dw_2.GetItemString(1,"prod_producto")
//
//ld_fac_conver = gf_unidad_venta(ls_prod_uni, gf_medi_prod(ls_prod_uni))
//
//For ll_row = 1 to dw_1.Rowcount()
//	dw_1.SetItem(ll_row,'existencia',ld_existencia)
//	dw_1.SetItem(ll_row,"unidad_producto",ls_prod_uni)
//	dw_1.SetItem(ll_row,"medi_cant_prod",ld_fac_conver)
//Next
//
//if dw_1.rowcount() > 0 then	
//	ld_reserva_completa  = dw_1.getitemnumber(1,'reserva_total')
//	ld_reserva_total 		= dw_1.getitemnumber(1,'reserva_final')
//	ld_reserva_fraccion  = dw_1.getitemnumber(1,'reserva_final_fraccion')
//	ld_reserva_total_unidades = dw_1.getitemnumber(1,'total_pendiente')
//	
//	dw_2.object.reserva.expression 		 = string(ld_reserva_total)
//	dw_2.object.reserva_frac.expression  = string(ld_reserva_fraccion)
//	dw_2.object.reserva_total.expression = string(ld_reserva_completa)
//	
//	  UPDATE inmprodu  
//     SET prod_reserva_total = :ld_reserva_total_unidades 
//   WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
//         ( inmprodu.prod_empresa = :str.empresa ) AND  
//         ( inmprodu.prod_producto = :ls_producto ) ;
//		if sqlca.sqlcode = -1 then
//			gf_mensaje('','Error al actualizar la reserva '+sqlca.sqlerrtext,1,1,'E')			
//		end if
//	
//else
//	
//	dw_2.object.reserva.expression 		= string(0)
//	dw_2.object.reserva_frac.expression = string(0)	
//	dw_2.object.reserva_total.expression = string(0)	
//
//  UPDATE inmprodu  
//     SET prod_reserva_total = 0
//   WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
//         ( inmprodu.prod_empresa = :str.empresa ) AND  
//         ( inmprodu.prod_producto = :ls_producto ) ;
//		if sqlca.sqlcode = -1 then
//			gf_mensaje('','Error al actualizar la reserva '+sqlca.sqlerrtext,1,1,'E')			
//		end if
//	
//end if
end event

event dw_1::ue_microayuda;//Override

Integer li_pos, li_x, li_y,li_largo
String ls_objeto, ls_col

ls_objeto = This.GetObjectAtPointer()
li_pos = pos  (ls_objeto,"~t")
ls_col = left (ls_objeto, li_pos - 1)

li_x	 = str.frame.GetActiveSheet ().PointerX () 
li_largo = len("Haga click para ordenar por la Columna de " + this.describe(ls_col+".text"))*28

If li_x +li_largo >(ll_dw_ancho +100) then
	li_x = (ll_dw_ancho +100) - li_largo
end if

li_y	 = str.frame.GetActiveSheet ().PointerY () - 200

// Dependiendo de la Columna el Mensaje de Ayuda varía
CHOOSE CASE right(ls_col,2)
	CASE '_t'
		If st_ayuda.Visible Then Return
		st_ayuda.Move (li_x, li_y)
		st_ayuda.Text 	= "Haga click para ordenar por la Columna de " + this.describe(ls_col+".text")
		st_ayuda.Width 	= Len (st_ayuda.Text) * 28
		st_ayuda.Visible = TRUE	
	CASE ELSE
	st_ayuda.Visible = FALSE
END CHOOSE
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_reservados
integer x = 5
integer y = 316
integer width = 3282
integer height = 1888
integer taborder = 40
end type

type cb_imprimir from commandbutton within w_reservados
boolean visible = false
integer x = 3008
integer y = 36
integer width = 265
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Previo"
end type

event clicked;Long ll_row
string ls_empre, ls_prod, ls_detalle, ls_descripcion, ls_prod_desc

parent.setredraw(false)
dw_3.reset()
ll_row = dw_1.RowsCopy(1,dw_1.rowcount(), primary!, dw_3, 1, primary!)
parent.setredraw(true)

If ll_row > 0 then
	dw_3.x = dw_1.x
	dw_3.y = dw_1.y
	dw_3.Height = dw_1.Height
	dw_3.width = dw_1.width
	dw_1.visible = false
	//nombre de la empresa
	ls_empre = gf_dg_nombre_empresa()
	dw_3.object.empresa.expression = "'"+ ls_empre +"'"
	//nombre del producto
	ls_prod = dw_2.getitemstring(dw_2.getrow(),"prod_producto")
	ls_descripcion = dw_2.getitemstring(dw_2.getrow(),"prod_descripcion")

	Integer	li_len, li_pos, li_len_a_remplazar
	string   ls_string,ls_cadena
	
	ls_string = '"'
	
	ls_cadena = UPPER(ls_descripcion)
	li_len = Len(ls_descripcion)
	
	li_pos = Pos(ls_cadena,ls_string,1)
	
	DO WHILE li_pos > 0
		If Mid(ls_cadena, li_pos, 1 ) = ls_string Then &
								ls_cadena = Replace(ls_cadena, li_pos, 1 , " " )
		li_pos = Pos(ls_cadena,ls_string)							
	LOOP
	
//	dw_3.object.prod.expression = "'"+ls_prod+" - " +ls_cadena+"'"
//	dw_3.object.datawindow.print.preview = True
//	dw_3.object.datawindow.print.preview.zoom = 100
	ls_prod_desc = ls_prod+" - " +ls_cadena
	dw_3.modify('produc.text = "'+ls_prod_desc+'"')
//	dw_3.modify("produc.text = 'PRODUCTO FIJO'")
	dw_3.object.datawindow.print.preview = True
	dw_3.object.datawindow.print.preview.zoom = 100
		
	dw_3.visible = true

	if ii_sw = 1 then
		dw_3.modify("acum_cantidad_t.visible = 1")
		dw_3.modify("acum_cantidad.visible = 1")
	else
		dw_3.modify("acum_cantidad_t.visible = 0")
		dw_3.modify("acum_cantidad.visible = 0")
	end if
	
end if
end event

type st_1 from statictext within w_reservados
boolean visible = false
integer x = 2994
integer y = 28
integer width = 288
integer height = 104
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_reservados
boolean visible = false
integer x = 101
integer y = 1384
integer width = 2514
integer height = 212
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_fa_rep_reserva_priview"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_cosultar from commandbutton within w_reservados
integer x = 3008
integer y = 144
integer width = 265
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cosultar"
boolean default = true
end type

event clicked;dw_1.visible = true
dw_3.visible = false

end event

type st_2 from statictext within w_reservados
integer x = 2994
integer y = 136
integer width = 288
integer height = 104
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_productos from datawindow within w_reservados
boolean visible = false
integer x = 1627
integer y = 436
integer width = 1147
integer height = 432
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "fa_dw_productos_datastore"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_reservados
boolean visible = false
integer x = 2245
integer y = 1328
integer width = 599
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualiza Reservados"
end type

event clicked;//Funcion que actualiza la reserva de el producto activo
string ls_producto
ls_producto = dw_2.getitemstring(1,'prod_producto')
wf_actualizar_reservado(ls_producto)
dw_2.trigger event ue_postitemchanged(ls_producto,1,'prod_producto')
dw_2.setfocus()
end event

type dw_2 from datawindow within w_reservados
event ue_postitemchanged ( string data,  long row,  string ls_columna )
event ue_down pbm_dwnkey
integer x = 9
integer width = 2976
integer height = 296
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_fa_rep_disponible_encab"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_postitemchanged;
//
long 	ld_existencia,ld_reserva, ld_fac_conver, ll_row
String	ls_descripcion,ls_prod_uni, ls_codigo, ls_sort, ls_descrip

CHOOSE CASE ls_columna
	CASE "prod_producto"
		dw_1.visible = true
		dw_3.visible = false
		ls_codigo = upper(data) //dw_productos.getitemstring(dw_productos.getrow(),"producto")
		ls_sort = dw_productos.Describe("DataWindow.Table.Sort") 
		if ls_sort <> "producto A" then			
			dw_productos.setsort("producto A")	
			dw_productos.sort()
			dw_2.object.color_orden.expression = '0'
		end if

		ll_row = dw_productos.find('producto = "'+ls_codigo+'"',1,dw_productos.rowcount())
		
		if ll_row > 0 then
			dw_productos.scrolltorow(ll_row)
			wf_recuperar(ls_codigo)
		//	return 2
		else
			ll_row = dw_productos.find('producto like "'+ls_codigo+'%"',1,dw_productos.rowcount())			
			if ll_row > 0 then
				dw_productos.scrolltorow(ll_row)
				ls_codigo = dw_productos.getitemstring(ll_row,'producto')				
				wf_recuperar(ls_codigo)
	//			return 2
			else	
				mensaje("Atención ","Código No existe ...!!!","")
//				return 2
			end if
		end if				
		this.setcolumn('prod_producto')
		this.setfocus()
	CASE "prod_descripcion"
		ls_descrip = data
		ls_sort = dw_productos.Describe("DataWindow.Table.Sort") 
		if ls_sort <> "descripcion A" then			
			dw_productos.setsort("descripcion A")	
			dw_productos.sort()
			dw_2.object.color_orden.expression = '1'
		end if
		
			ll_row = dw_productos.find('descripcion = "'+ls_descrip+'"',1,dw_productos.rowcount())
			if ll_row > 0 then
				dw_productos.scrolltorow(ll_row)
				ls_codigo = dw_productos.getitemstring(ll_row,"producto")
				wf_recuperar(ls_codigo)
				dw_2.setcolumn(2)				
			else
				ll_row = dw_productos.find('descripcion like "'+ls_descrip+'%"',1,dw_productos.rowcount())			
				if ll_row > 0 then
					dw_productos.scrolltorow(ll_row)
					ls_codigo = dw_productos.getitemstring(ll_row,'producto')
					wf_recuperar(ls_codigo)
					dw_2.setcolumn(2)					
				else	
					mensaje("Atención ","Código No existe ...!!!","")					
					dw_2.setcolumn(2)					
				end if
			end if						
END CHOOSE

end event

event ue_down;
//if keydown(KeyF1!) then this.Post event doubleclicked(1,1,1,this.object.prod_producto)
this.accepttext()
//Teclas de funciones
long ll_row 
string ls_codigo, ls_sort
if keydown(KeyF1!) then
	//Para la Ayuda de Productos	
	//Busqueda de productos
	string  ls_syntax, ls_cadena, ls_item
	integer li_pos
	str_dg_dynamic_find lstr_df
	
	//dw = tab_1.tabpage_gnrles.dw_generales
	
	lstr_df.texto_campo[1, 1] = "productos.prod_producto"
	lstr_df.texto_campo[1, 2] = "ID de Ref."
	lstr_df.texto_campo[1, 3] = "prod_producto"
	lstr_df.texto_campo[1, 4] = "V"
	lstr_df.texto_campo[1, 5] = "300"
	
	lstr_df.texto_campo[2, 1] = "productos.prod_descripcion"
	lstr_df.texto_campo[2, 2] = "Descripción"
	//lstr_df.texto_campo[2, 3] = "prod_descripcion"
	lstr_df.texto_campo[2, 3] = ""
	lstr_df.texto_campo[2, 4] = "V"
	lstr_df.texto_campo[2, 5] = "600"
	
	lstr_df.tabla = " productos "
	
	
	lstr_df.tabla_where = &
		"WHERE ( ( productos.prod_g_financiero = " + String(str.g_financiero) + " ) AND " +& 
				"( productos.prod_empresa = " +String(str.empresa) + " ))" 
				
	yield()
	
	OpenWithParm(w_dg_a_custom_find /*w_cr_busqueda*/, lstr_df)
	
	ls_syntax = Message.StringParm
	//messagebox("",ls_syntax)	
		
		IF NOT IsNull(ls_syntax) AND (ls_syntax <> "") Then 
				//Para extraer el codigo del producto
				li_pos	 = pos(ls_syntax,"= '",1)	
				li_pos 	 += 3	
				ls_item = mid(ls_syntax,li_pos, Pos(ls_syntax, "'",li_pos) - li_pos)
				this.setitem(this.getrow(),"prod_producto",ls_item)
				this.accepttext()
				This.Post Event ue_postitemchanged(ls_item,this.getrow(),'prod_producto')
				this.setcolumn('prod_producto')
				This.Setfocus()
		End If
	 
elseif keyDown(KeyUpArrow!) then
	parent.triggerevent('ue_reg_anterior')
	return 2	
elseif keyDown(KeyDownArrow!) then	
	parent.triggerevent('ue_siguiente_reg')
//	dw_1.Modify("DataWindow.VerticalScrollPosition='1'")	
	return 2
elseif keydown(KeyControl!) and keydown(KeyC!) then
	ls_codigo = dw_productos.getitemstring(dw_productos.getrow(),"producto")
	ls_sort = dw_productos.Describe("DataWindow.Table.Sort") 
	if ls_sort <> "producto A" then		
		dw_productos.setsort("producto A")
		dw_productos.sort()
		dw_2.object.color_orden.expression = '0'
		ll_row = dw_productos.find('producto = "'+ls_codigo+'"',1,dw_productos.rowcount())
		if ll_row > 0 then
			dw_productos.scrolltorow(ll_row)
		end if
	end if
	dw_2.setcolumn(1)
elseif keydown(KeyControl!) and keydown(KeyD!) then
	ls_codigo = dw_productos.getitemstring(dw_productos.getrow(),"producto")
	ls_sort = dw_productos.Describe("DataWindow.Table.Sort") 
	if ls_sort <> "descripcion A" then			
		dw_productos.setsort("descripcion A")	
		dw_productos.sort()
		dw_2.object.color_orden.expression = '1'		
		ll_row = dw_productos.find('producto = "'+ls_codigo+'"',1,dw_productos.rowcount())
		if ll_row > 0 then
			dw_productos.scrolltorow(ll_row)
		end if		
	end if	
	dw_2.setcolumn(2)	
elseif keydown(KeyControl!) and keydown(Keyend!) then
	parent.triggerevent('ue_ultimo_reg')
	return 2
elseif keydown(KeyControl!) and keydown(Keyhome!) then
	parent.triggerevent('ue_primer_reg')
	return 2
elseif keydown(KeyControl!) and keydown(KeyB!) then
	parent.triggerevent('ue_buscar')	
elseif keydown(KeyF5!) or keydown(KeyEnter!) then
	ls_codigo = dw_2.getitemstring(1,'prod_producto')//dw_productos.getitemstring(dw_productos.getrow(),"producto")
	ll_row = dw_productos.find('producto = "'+ls_codigo+'"',1,dw_productos.rowcount())
		if ll_row > 0 then
			dw_productos.scrolltorow(ll_row)
		end if			
	this.trigger event itemchanged(this.getrow(),This.object.prod_producto,ls_codigo)		
end if
end event

event clicked;dw=this

end event

event editchanged;If not IsValid(m_fa_rep) Then
	ChangeMenu(m_fa_rep)
End If

end event

event getfocus;dw = this
If not IsValid(m_fa_rep) Then
	ChangeMenu(m_fa_rep)
End If

end event

event itemchanged;this.accepttext()
This.Post Event ue_postitemchanged(data,row,dw.getcolumnname())

end event

event doubleclicked;//Para la Ayuda de Productos

If dwo.name = 'prod_producto - deshabilitado' Then
	
	//Busqueda de productos
	string  ls_codigo, ls_syntax, ls_cadena, ls_item
	integer li_pos
	str_dg_dynamic_find lstr_df
	
	//dw = tab_1.tabpage_gnrles.dw_generales
	
	lstr_df.texto_campo[1, 1] = "inmprodu.prod_producto"
	lstr_df.texto_campo[1, 2] = "ID de Ref."
	lstr_df.texto_campo[1, 3] = "prod_producto"
	lstr_df.texto_campo[1, 4] = "V"
	lstr_df.texto_campo[1, 5] = "300"
	
	lstr_df.texto_campo[2, 1] = "inmprodu.prod_descripcion"
	lstr_df.texto_campo[2, 2] = "Descripción"
	//lstr_df.texto_campo[2, 3] = "prod_descripcion"
	lstr_df.texto_campo[2, 3] = ""
	lstr_df.texto_campo[2, 4] = "V"
	lstr_df.texto_campo[2, 5] = "600"
	
	lstr_df.texto_campo[3, 1] = "inmprodu.prod_existencia_total"
	lstr_df.texto_campo[3, 2] = "Exist."
	////lstr_df.texto_campo[3, 3] = "~tdd/mm/yyyy~tprod_ultima_actualizacion"
	//lstr_df.texto_campo[3, 3] = ""
	lstr_df.texto_campo[3, 4] = "V"
	lstr_df.texto_campo[3, 5] = "350"
	
	lstr_df.texto_campo[4, 1] = "inmprodu.prod_reserva_total"
	lstr_df.texto_campo[4, 2] = "Reserva"
	//lstr_df.texto_campo[4, 3] = ""
	lstr_df.texto_campo[4, 4] = "V"
	lstr_df.texto_campo[4, 5] = "350"
	
	//lstr_df.texto_campo[5, 1] = "inmbodeg.mbod_cantidad"
	//lstr_df.texto_campo[5, 2] = "Cant."
	////lstr_df.texto_campo[5, 3] = "prod_grupo"
	//lstr_df.texto_campo[5, 3] = ""
	//lstr_df.texto_campo[5, 4] = "V"
	//lstr_df.texto_campo[5, 5] = "280"
	
	lstr_df.texto_campo[5, 1] = "inmprodu.prod_peso"
	lstr_df.texto_campo[5, 2] = "Peso"
	//lstr_df.texto_campo[6, 3] = "prod_sub_grupo"
	lstr_df.texto_campo[5, 3] = ""
	lstr_df.texto_campo[5, 4] = "V"
	
	lstr_df.texto_campo[6, 1] = "inmprodu.prod_cubicaje"
	lstr_df.texto_campo[6, 2] = "Cubicaje"
	//lstr_df.texto_campo[7, 3] = "prod_clase"
	lstr_df.texto_campo[6, 3] = ""
	lstr_df.texto_campo[6, 4] = "V"
	
	lstr_df.tabla = " craestat, inmprodu "
	
	
	lstr_df.tabla_where = &
		"WHERE ( inmprodu.prod_estatus_ref = craestat.aest_cod_estatus ) and " +&
				"( ( inmprodu.prod_g_financiero = " + String(str.g_financiero) + " ) AND " +& 
				"( inmprodu.prod_empresa = " +String(str.empresa) + " )) And " +&
				"( inmprodu.prod_status = 1 ) AND "+& 
				"(SubString(inmprodu.prod_owner,"+String(ii_flag)+",1) = '1')" +ls_cadena		
	
	yield()
	
	OpenWithParm(w_dg_a_custom_find /*w_cr_busqueda*/, lstr_df)
	
	ls_syntax = Message.StringParm
	//messagebox("",ls_syntax)	
		
		IF NOT IsNull(ls_syntax) AND (ls_syntax <> "") Then 
				//Para extraer el codigo del producto
				li_pos	 = pos(ls_syntax,"= '",1)	
				li_pos 	 += 3	
				ls_item = mid(ls_syntax,li_pos, Pos(ls_syntax, "'",li_pos) - li_pos)
				this.setitem(this.getrow(),"prod_producto",ls_item)
				this.accepttext()
				This.Post Event ue_postitemchanged(ls_item,this.getrow(),'prod_producto')
		End If
	 
End if
end event

