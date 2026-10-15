forward
global type w_ventas_producto from window
end type
type dw_1 from datawindow within w_ventas_producto
end type
end forward

global type w_ventas_producto from window
integer width = 1490
integer height = 1428
boolean titlebar = true
string title = "Ventas..."
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 10789024
string icon = "UserObject5!"
windowanimationstyle openanimation = leftroll!
windowanimationstyle closeanimation = leftroll!
dw_1 dw_1
end type
global w_ventas_producto w_ventas_producto

forward prototypes
public subroutine wf_asignar (string as_codigo)
end prototypes

public subroutine wf_asignar (string as_codigo);String ls_codigo, ls_nombre, ls_cadena_costo, ls_precio
datetime ldt_fecha
decimal{2} ld_precio, ld_cantidad
integer i = 0

ls_codigo = as_codigo

dw_1.reset()

select para_clave_costos  //Clave de Costos
	into : ls_cadena_costo
	from inaparam
	where (para_g_financiero =: str.g_financiero) and
			(para_empresa =: str.empresa);
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al buscar clave '+sqlca.sqlerrtext,1,1,'E')
	end if

dw_1.modify("t_precio_promedio.text = ''")	
	
 DECLARE cur_ventas CURSOR FOR  
	  SELECT case when fatdiari.fact_a_nombre = null or  fatdiari.fact_a_nombre = '' then dgmterce.terc_descripcion else fatdiari.fact_a_nombre end,   fatdiari.fact_fecha, faddiari.facd_precio_unidad_producto, faddiari.facd_cantidad
		 FROM faddiari,   
				fatdiari,
				dgmterce
		WHERE (fatdiari.fact_cliente = dgmterce.terc_tercero ) and
				( fatdiari.fact_g_financiero = faddiari.facd_g_financiero ) and  
				( fatdiari.fact_empresa = faddiari.facd_empresa ) and  
				( fatdiari.fact_tipo = faddiari.facd_tipo ) and  
				( fatdiari.fact_no_pedido = faddiari.facd_no_pedido ) and  
				( fatdiari.fact_ann = faddiari.facd_ann ) and  
				( ( fatdiari.fact_g_financiero = :str.g_financiero ) AND  
				( fatdiari.fact_empresa = :str.empresa ) AND  
				( faddiari.facd_codigo_item = :ls_codigo ) )   
	ORDER BY fatdiari.fact_fecha DESC  ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al Declarar Cursor '+sqlca.sqlerrtext,1,1,'E')
		return
	end if

	open cur_ventas;
	
	fetch cur_ventas into :ls_nombre, :ldt_fecha, :ld_precio, : ld_cantidad; 
	
	do while sqlca.sqlcode = 0
	
		i ++
		if i > 15 then
			ld_precio = dw_1.getitemnumber(1,'precio_promedio')
			ls_precio = gf_clave_costos_sin_select(ld_precio, ls_cadena_costo)		
			dw_1.modify("t_precio_promedio.text = '"+ls_precio+"'")
			close cur_ventas;
			return	
		end if
		dw_1.insertrow(i)
		dw_1.setitem(i,'nombre', ls_nombre)
		dw_1.setitem(i,'fecha', ldt_fecha)
		dw_1.setitem(i,'cantidad', ld_cantidad)
		dw_1.setitem(i,'precio_num', ld_precio)
		ls_precio = gf_clave_costos_sin_select(ld_precio, ls_cadena_costo)		
		dw_1.setitem(i,'precio', ls_precio)
		fetch cur_ventas into :ls_nombre, :ldt_fecha, :ld_precio, : ld_cantidad; 
	loop
	
	close cur_ventas;
	
	if dw_1.rowcount() > 1 then
		ld_precio = dw_1.getitemnumber(1,'precio_promedio')
		ls_precio = gf_clave_costos_sin_select(ld_precio, ls_cadena_costo)		
		dw_1.modify("t_precio_promedio.text = '"+ls_precio+"'")
	end if
	
end subroutine

on w_ventas_producto.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_ventas_producto.destroy
destroy(this.dw_1)
end on

event open;this.x = 5040
this.y = 1530
dw_1.insertrow(1)
string ls_codigo
ls_codigo = message.stringparm

//OpenSheet(w_captura_proformas,str.frame,2,Original!)
end event

event resize;dw_1.resize(newwidth - 100, newheight - 70)
dw_1.modify("foto.width='"+string(newwidth - 160)+"'")
dw_1.modify("foto.height='"+string(newheight - 200)+"'")
end event

type dw_1 from datawindow within w_ventas_producto
integer x = 46
integer y = 28
integer width = 1358
integer height = 1280
integer taborder = 10
string title = "none"
string dataobject = "dw_ventas_producto"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

