forward
global type w_cargos_ped from window
end type
type dw_1 from datawindow within w_cargos_ped
end type
end forward

global type w_cargos_ped from window
integer width = 1417
integer height = 1108
boolean titlebar = true
string title = "Cargos del Pedido"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
dw_1 dw_1
end type
global w_cargos_ped w_cargos_ped

type variables
datawindowchild idwc_cargos
// Nombre de los Campos
String is_ca_cargo ,is_ca_monto,is_ca_ped,is_ca_prede,&
          is_ca_an, is_ca_tipo
str_fa_cargo_fac   i_str
Boolean ib_cambio = false

end variables

on w_cargos_ped.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_cargos_ped.destroy
destroy(this.dw_1)
end on

event open;this.y = 0
this.x = 805
this.width = 1417
this.height= 1108
dw_1.settransobject(sqlca)
dw_1.getchild('peca_codigo_cargo', idwc_cargos)
idwc_cargos.settransobject(sqlca)
idwc_cargos.retrieve(str.g_financiero, str.empresa)

i_str = Message.PowerObjectParm

//si el estado viene nulo, asigna activo
if i_str.estado = '' or isnull(i_str.estado) then i_str.estado = 'A' 

if dw_1.retrieve(str.g_financiero, str.empresa, i_str.pedido,i_str.an) = 0 then
	dw_1.insertrow(0)	
	dw_1.setitem(1,'peca_g_financiero', str.g_financiero)
	dw_1.setitem(1,'peca_empresa',str.empresa)
	dw_1.setitem(1,'peca_no_pedido', i_str.pedido)	
	dw_1.setitem(1,'peca_ann', i_str.an)

end if


 
end event

type dw_1 from datawindow within w_cargos_ped
integer x = 14
integer y = 36
integer width = 1326
integer height = 884
integer taborder = 10
string title = "none"
string dataobject = "dw_cargos_pedidos"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;this.accepttext()
choose case dwo.name
	case 'b_adicionar_cargos'
		dw_1.scrolltorow(insertrow(0))	
		dw_1.setitem(dw_1.getrow(),'peca_g_financiero', str.g_financiero)
		dw_1.setitem(dw_1.getrow(),'peca_empresa',str.empresa)
		dw_1.setitem(dw_1.getrow(),'peca_no_pedido', i_str.pedido)	
		dw_1.setitem(dw_1.getrow(),'peca_ann', i_str.an)
		
	case 'b_cerrar', 'b_grabar'
		
		double ld_gastos
	
		if i_str.estado <> 'A' then return
			
		if dw_1.rowcount() > 0 then
			ld_gastos = round(dw_1.getitemnumber(1,"suma"),2)
			IF ISNULL(ld_gastos)  then ld_gastos = 0
			if ld_gastos <> 0 then
				i_str.window.Dynamic wf_cargos(ld_gastos)
			else
				if dwo.name = 'b_cerrar' then
					close(parent)
					return
				else
					i_str.window.Dynamic wf_cargos(0)					
				end if
			end if
		else
			i_str.window.Dynamic wf_cargos(0)
		end if
	
		long ll_update
		
		ll_update=dw_1.update()
	
		if ll_update = 1  then
		
		  UPDATE fatpedid
			  SET pedi_actualizo_cargos = 'S'
			WHERE ( fatpedid.pedi_g_financiero  = :str.g_financiero ) AND
					( fatpedid.pedi_empresa 		= :str.empresa ) AND
					( fatpedid.pedi_no_pedido 		= :i_str.pedido ) AND
					( fatpedid.pedi_ann 				= :i_str.an );
					
			if sqlca.sqlcode = -1 then
				gf_mensaje("","Error al Actualizar el campo de Actualizó Cargos en Pedidos "+sqlca.sqlerrtext,1,1,"E")
				rollback ;
				return
			end if
			
			commit using sqlca;	
			
			ib_cambio = false
			
		else
			
			rollback using sqlca;
			gf_mensaje("Atención","¡Error al Actualizar ! "+sqlca.sqlerrtext,1,1,"E")
		
		end if
		
		if dwo.name = 'b_cerrar' then
			close(parent)
		end if

end choose
end event

