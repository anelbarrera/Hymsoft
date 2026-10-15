forward
global type w_pedidos_vencidos from window
end type
type cbx_no_mostrar from checkbox within w_pedidos_vencidos
end type
type dw_1 from datawindow within w_pedidos_vencidos
end type
end forward

global type w_pedidos_vencidos from window
boolean visible = false
integer width = 3310
integer height = 1900
boolean titlebar = true
string title = "Pedidos Vencidos"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 16711680
string icon = "AppIcon!"
boolean center = true
windowanimationstyle openanimation = centeranimation!
windowanimationstyle closeanimation = centeranimation!
event ue_key pbm_keydown
cbx_no_mostrar cbx_no_mostrar
dw_1 dw_1
end type
global w_pedidos_vencidos w_pedidos_vencidos

type variables
string is__ultima, is__orden
end variables

event ue_key;If Key = keyEscape! then
	this.postevent("close")
End if
end event

on w_pedidos_vencidos.create
this.cbx_no_mostrar=create cbx_no_mostrar
this.dw_1=create dw_1
this.Control[]={this.cbx_no_mostrar,&
this.dw_1}
end on

on w_pedidos_vencidos.destroy
destroy(this.cbx_no_mostrar)
destroy(this.dw_1)
end on

event open;integer li_existe
this.visible = false
	
sqlca.autocommit = true
dw_1.settransobject(sqlca)
if dw_1.retrieve(str.g_financiero, str.empresa) = 0 then
	this.postevent('close')
else
	dw_1.setfocus()
	this.visible = true
	
		  SELECT favervencidos.ver_vencidos  
			 INTO :li_existe  
			 FROM favervencidos  
			WHERE ( favervencidos.maquina = :str.maquina ) ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Validar Ver Vencidos '+sqlca.sqlerrtext,1,1,'E')
				return
			elseif sqlca.sqlcode = 100 then
				li_existe = 1
			end if
		if isnull(li_existe) then li_existe = 1
		if li_existe > 0 then
			cbx_no_mostrar.checked = true
		else
			cbx_no_mostrar.checked = false
		end if
end if

end event

event close;close(this)
end event

type cbx_no_mostrar from checkbox within w_pedidos_vencidos
integer x = 64
integer y = 1740
integer width = 1015
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 134217856
string text = "Mostrar al Entrar al Sistema  ?"
end type

event clicked;integer li_existe

 SELECT isnull(count(*),0)  
 INTO :li_existe  
 FROM favervencidos  
WHERE ( favervencidos.maquina = :str.maquina ) ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al Validar Ver Vencidos '+sqlca.sqlerrtext,1,1,'E')
		return
	end if
	
if this.checked then
	 
		if li_existe = 0 then
			  INSERT INTO favervencidos  
							( maquina,   
							  ver_vencidos )  
				  VALUES ( :str.maquina,   
							  1 )  ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Insertar Ver Vencidos '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
		else
			  UPDATE favervencidos  
			  SET ver_vencidos = 1  
			WHERE favervencidos.maquina = :str.maquina   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Actualizar Ver Vencidos '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
	
		end if	
else
		
		if li_existe = 0 then
			  INSERT INTO favervencidos  
							( maquina,   
							  ver_vencidos )  
				  VALUES ( :str.maquina,   
							  0 )  ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Insertar Ver Vencidos '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
		else
			  UPDATE favervencidos  
			  SET ver_vencidos = 0  
			WHERE favervencidos.maquina = :str.maquina   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Actualizar Ver Vencidos '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
	
		end if	
	
end if
end event

type dw_1 from datawindow within w_pedidos_vencidos
integer x = 69
integer y = 52
integer width = 3141
integer height = 1676
integer taborder = 10
string title = "Pedidos Vencidos"
string dataobject = "dw_pedidos_vencidos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto, ls_pedido
integer li_pos , li_ann

this.Setredraw(false)

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if right(ls_objeto,2)='_t' then

	ls_objeto = left(ls_objeto,len(ls_objeto)-2)
	
	if ls_objeto = is__ultima or is__ultima = "" then	//Si es la misma columna 
																	// o si es la primera vez
		if is__orden  = "" or is__orden = "D" then
			is__orden = 'A'		
			this.SetSort(ls_objeto+" A")	//Ordena Ascendente
			this.sort()		
		else
			is__orden = 'D'					
			this.SetSort(ls_objeto+" D")	//Ordena Descendente
			this.sort()				
		end if	
		is__ultima = ls_objeto		
	else				
			is__orden = 'A'
			this.SetSort(ls_objeto+" A")
			this.sort()
			is__ultima = ls_objeto
	end if

end if

if dwo.name = 'fact_no_pedido' then
	str_secuencia_doc lstr_sec
	ls_pedido = this.getitemstring(row,'fact_no_pedido')
	li_ann = this.getitemnumber(row,'fact_ann')
	lstr_sec.sec_manual = ls_pedido
	lstr_sec.ano = li_ann
	
	opensheetwithparm(w_pedidos_pendientes_fac,lstr_sec,w_fa_fondo,2,Original!)
end if

this.Setredraw(true)
end event

