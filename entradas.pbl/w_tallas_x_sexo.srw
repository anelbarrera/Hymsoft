//objectcomments  
forward
global type w_tallas_x_sexo from window
end type
type dw_2 from datawindow within w_tallas_x_sexo
end type
type dw_1 from datawindow within w_tallas_x_sexo
end type
end forward

global type w_tallas_x_sexo from window
integer width = 2514
integer height = 1716
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12639424
windowanimationstyle openanimation = toproll!
windowanimationstyle closeanimation = topslide!
event ue_escape pbm_keydown
dw_2 dw_2
dw_1 dw_1
end type
global w_tallas_x_sexo w_tallas_x_sexo

type variables
datawindowchild idwc_tallas
// Nombre de los Campos
String is_ca_cargo ,is_ca_monto,is_ca_ped,is_ca_prede,&
          is_ca_an, is_ca_tipo, is_ultima_, is_orden_

Boolean ib_cambio = false
str_secuencia_doc istr_cat
end variables

event ue_escape;if Key = KeyEscape! then
	this.postevent('close')
end if
end event

on w_tallas_x_sexo.create
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.dw_2,&
this.dw_1}
end on

on w_tallas_x_sexo.destroy
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;gf_center_win(this)
string ls_masca
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

istr_cat = message.powerobjectparm

if isvalid(istr_cat) then

	dw_2.getchild('sextal_codtalla',idwc_tallas)
	idwc_tallas.settransobject(sqlca)
	idwc_tallas.retrieve(str.g_financiero, str.empresa)
	idwc_tallas.insertrow(1)
	
	dw_1.retrieve(str.g_financiero, str.empresa)
	dw_2.retrieve(str.g_financiero, str.empresa, istr_cat.categoria)

	this.title = 'Asignacion de Tallas a '+istr_cat.descripcion
	dw_2.title = 'Tallas Asignadas a '+istr_cat.descripcion
else
	close(this)
end if


end event

event close;if isvalid(this) then close(this)
end event

type dw_2 from datawindow within w_tallas_x_sexo
integer x = 1307
integer y = 8
integer width = 1111
integer height = 1528
integer taborder = 20
boolean titlebar = true
string title = "Tallas Asociadas a ....."
string dataobject = "dw_tallas_asociadas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;integer i, li_encontro
string ls_find

for i = 1 to rowcount
	
	ls_find = 'talla_codigo = "'+this.getitemstring(i,'sextal_codtalla')+'"'
	li_encontro = dw_1.find(ls_find,1,dw_1.rowcount())
	if li_encontro > 0 then
		dw_1.setitem(li_encontro,'incluir',1)
	end if
	
next
end event

type dw_1 from datawindow within w_tallas_x_sexo
integer x = 14
integer y = 8
integer width = 1147
integer height = 1536
integer taborder = 10
boolean titlebar = true
string title = "Tallas"
string dataobject = "dw_tallas_asociar"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;if dwo.name = 'b_cerrar' then
	if dw_2.update() = -1 then
		gf_mensaje('','Error al Actualizar '+ sqlca.sqlerrtext,1,1,'E')
	end if
	close(parent)
elseif dwo.name = 'b_grabar' then
	if dw_2.update() = -1 then
		gf_mensaje('','Error al Actualizar '+ sqlca.sqlerrtext,1,1,'E')
	end if
end if
end event

event clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto
integer li_pos 

this.Setredraw(false)

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if right(ls_objeto,2)='_t' then

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

end if

this.Setredraw(true)

end event

event itemchanged;this.accepttext()

if dwo.name = 'incluir' then

	integer li_incluir, li_encontro
	string ls_cuenta, ls_find
	
	li_incluir = integer(data)//this.getitemnumber(row,'incluir')
	
	if li_incluir = 1 then
		dw_2.scrolltorow(dw_2.insertrow(0))
		dw_2.setitem(dw_2.rowcount(),'sextal_g_financiero', str.g_financiero)
		dw_2.setitem(dw_2.rowcount(),'sextal_empresa', str.empresa)	
		dw_2.setitem(dw_2.rowcount(),'sextal_codsexo', istr_cat.categoria)
		dw_2.setitem(dw_2.rowcount(),'sextal_codtalla', this.getitemstring(row,'talla_codigo'))
		dw_2.setitem(dw_2.rowcount(),'sextal_codtalla_1', this.getitemstring(row,'talla_codigo'))	
	else
		ls_cuenta = this.getitemstring(row,'talla_codigo')
		ls_find = 'sextal_codtalla = "'+ls_cuenta+'"'
		li_encontro = dw_2.find(ls_find,1,dw_2.rowcount())
		if li_encontro > 0 then
			dw_2.deleterow(li_encontro)
		end if
	end if

end if
end event

