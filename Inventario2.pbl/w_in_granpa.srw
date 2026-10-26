//objectcomments Ventana Padre de primer nivel (NO TOCAR)
forward
global type w_in_granpa from window
end type
type dw_2 from datawindow within w_in_granpa
end type
type st_nom_ventana from statictext within w_in_granpa
end type
type dw_1 from datawindow within w_in_granpa
end type
type gb_ventana from groupbox within w_in_granpa
end type
end forward

global type w_in_granpa from window
integer x = 55
integer y = 128
integer width = 1897
integer height = 1028
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
event ue_adicionar ( )
event ue_aceptar ( )
event ue_eliminar ( )
event ue_primer_reg ( )
event ue_reg_anterior ( )
event ue_siguiente_reg ( )
event ue_ultimo_reg ( )
event ue_imprimir ( )
event ue_post_open ( )
event ue_pre_aceptar ( )
event ue_pre_eliminar ( )
event ue_insertar ( )
event ue_hay_data ( )
event ue_copia_linea ( )
event ue_copia_todo ( )
event ue_remover_linea ( )
event ue_remover_todo ( )
event ue_filter ( )
event ue_sort ( )
event ue_print ( )
event ue_busqueda ( )
event ue_recuperar ( )
dw_2 dw_2
st_nom_ventana st_nom_ventana
dw_1 dw_1
gb_ventana gb_ventana
end type
global w_in_granpa w_in_granpa

type variables
integer ii_linea
datawindow dw
String  is_sqlpreview
String is_nombre
integer ii_ww,ii_wh
boolean ib_aceptar

end variables

forward prototypes
public subroutine wf_carga_gf_emp (readonly string ls_tabla)
public function integer wf_secuencia ()
end prototypes

event ue_adicionar;dw.setcolumn(1)
dw.scrolltorow(dw.insertrow(0))
dw.setcolumn(1)



end event

event ue_aceptar;long ll_update
window lw_ventana
string ls_titulo

//lw_ventana = this.getactivesheet()
//ls_titulo = lw_ventana.title

ll_update=dw.update()

if ll_update = 1  then
	commit using sqlca;
	//messagebox("Atención","¡Actualización Exitosa !")
else
	rollback using sqlca;
	//messagebox("Atención","¡Error al Actualizar !")
end if



end event

event ue_eliminar;if dw.rowcount() > 0 then
	dw.deleterow(dw.getrow())
else 
	messagebox("Atención","No hay registros para borrar!")
end if
end event

event ue_primer_reg;dw.scrolltorow(1)
end event

event ue_reg_anterior;dw.scrollpriorrow()
end event

event ue_siguiente_reg;dw.scrollnextrow()
end event

event ue_ultimo_reg;dw.scrolltorow(dw.rowcount())
end event

event ue_imprimir;dw.print()
end event

event ue_post_open;is_nombre = This.ClassName()

gf_win_used_by_user(is_nombre, true)

dw.settransobject(sqlca)

st_nom_ventana.text = is_nombre

THIS.postevent("ue_hay_data")

end event

event ue_pre_aceptar;//en el padre de su respectiva aplicacion, en este mismo evento, vuelva a poner TRUE
sqlca.autocommit = false
this.postevent("ue_aceptar")
yield()
end event

event ue_pre_eliminar;this.postevent("ue_eliminar")
end event

event ue_insertar;dw.setcolumn(1)
dw.scrolltorow(dw.insertrow(dw.Getrow()))
dw.setcolumn(1)

end event

event ue_hay_data;if dw.rowcount() = 0 then
	this.triggerevent("ue_adicionar")
end if

end event

event ue_filter;string var
SetNull(var)

// Open The Filter Window
dw.SetFilter(var)

// Execute the filter expresion definida to the user
dw.filter()
end event

event ue_sort;string ls_var
setnull(ls_var)


dw.SetSort (ls_var)
dw.sort()
end event

event ue_print;OpenWithParm(w_dw_print_options, dw)

If Message.DoubleParm = -1 Then Return
dw.Print(True)

end event

event ue_busqueda;SetPointer(HourGlass!)
end event

event ue_recuperar;rollback using sqlca;
end event

public subroutine wf_carga_gf_emp (readonly string ls_tabla);dw.SetItem(dw.getrow(),ls_tabla+"_g_financiero", str.g_financiero) 
dw.SetItem(dw.getrow(),ls_tabla+"_empresa", str.empresa) 
end subroutine

public function integer wf_secuencia ();integer li_secuencia

li_secuencia = dw_1.rowcount()

return(li_secuencia)

end function

on w_in_granpa.create
this.dw_2=create dw_2
this.st_nom_ventana=create st_nom_ventana
this.dw_1=create dw_1
this.gb_ventana=create gb_ventana
this.Control[]={this.dw_2,&
this.st_nom_ventana,&
this.dw_1,&
this.gb_ventana}
end on

on w_in_granpa.destroy
destroy(this.dw_2)
destroy(this.st_nom_ventana)
destroy(this.dw_1)
destroy(this.gb_ventana)
end on

event open;gf_center_win(This)
gf_acelerador()
dw = dw_1

This.Icon = str.icono

this.postevent("ue_post_open")



end event

event closequery;long respuesta
if dw.accepttext() = 1 then  
	if dw.modifiedcount() > 0 or dw.deletedcount() > 0 then
//		respuesta = messagebox("Atención","El registro en "+this.title+ " no ha sido guardado!...~n ~t Desea guardarlo &
//ahora?",question!,YesNoCancel!) 
		respuesta = MessageBox("Atención -- " + str.nombre + " " + str.apellido, &
										"No se han Salvado los Cambios." + &
										"~n~n ¿Desea Salvar Ahora?", Question!, YesNoCancel!) 
		choose case respuesta 
			case 1 				
				this.triggerevent("ue_pre_aceptar")
			case 2
				
		   case 3
				return 1
		end choose
	end if
end if

//Para que al salir de la ventana libere las paginas
commit ;

gf_win_used_by_user(is_nombre, false)
end event

type dw_2 from datawindow within w_in_granpa
event ue_enter pbm_dwnprocessenter
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
event ue_mousemove pbm_mousemove
event ue_down pbm_dwnkey
boolean visible = false
integer x = 14
integer y = 32
integer width = 119
integer height = 108
integer taborder = 11
boolean bringtotop = true
boolean livescroll = true
end type

event ue_enter;send(handle(this),256,9,long(0,0))
return 1
end event

event ue_down;// Gianni Araúz (11/10/1999)
// Este script hace que aparezca el nombre del DataWindow Object y el nombre de la
// columna cuando se presionan las teclas "Control" y "N".


string		 ls_clase, ls_dw='', ls_columna='', ls_columna1=''
	
if keydown(keycontrol!) and keydown(keyN!) then
	ls_dw = this.DataObject
	Clipboard(ls_dw)
	ls_columna = GetColumnName()
	ls_columna1 = describe('#'+string(GetColumn())+'.dbname')
	if isnull(ls_columna) or trim(ls_columna) = '' then return
	if isnull(ls_columna1) or trim(ls_columna1) = '' then return
	if trim(ls_columna) = trim(ls_columna1) then
		MessageBox('NOMBRE DEL DATAWINDOW: '+ls_dw,'NOMBRE DE LA COLUMNA: '+ls_columna,&
			Information!)
	else
		MessageBox('NOMBRE DEL DATAWINDOW: '+ls_dw,'NOMBRE DE LA COLUMNA: '+ls_columna+&
					'~nNOMBRE EN LA BASE DE DATOS: '+ls_columna1)
	end if
end if

// Modificado por Gianni Araúz (30/05/2000)
// Para el caso de los reportes, sólo debe mostrar el nombre del DataWindow

if keydown(keycontrol!) and keydown(keyM!) then
	ls_dw = this.DataObject
	if isnull(ls_dw) or trim(ls_dw) = '' then return
	MessageBox('Usuario: '+str.usuario,'NOMBRE DEL DATAWINDOW: '+ls_dw,Information!)
end if

end event

event itemchanged;ib_aceptar = true
gf_in_enabled_save(str.frame.GetActiveSheet().MenuName, True)
end event

event rowfocuschanged;///* Marca la linea selecionada con un color azul */
//dw.selectrow(0,false)
//dw.selectrow(getrow(),true)
end event

type st_nom_ventana from statictext within w_in_granpa
integer x = 41
integer y = 816
integer width = 800
integer height = 56
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 80263328
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_in_granpa
event ue_item_cambiando pbm_lvnitemchanging
event ue_down pbm_dwnkey
event ue_entercol ( )
event ue_helpcol ( )
event ue_enter pbm_dwnprocessenter
integer x = 128
integer y = 84
integer width = 1403
integer height = 576
integer taborder = 1
boolean hscrollbar = true
boolean border = false
end type

event ue_down;// Toma la Tecla que el usuario presione

CHOOSE CASE key
		
	CASE KeyF1! 
		
		This.Postevent("ue_helpcol")
		
	CASE	  Keyenter! 
		
	     This.Triggerevent("ue_entercol")
//		  return(2)

		
END CHOOSE


// Gianni Araúz (11/10/1999)
// Este script hace que aparezca el nombre del DataWindow Object y el nombre de la
// columna cuando se presionan las teclas "Control" y "N".


string		 ls_clase, ls_dw='', ls_columna='', ls_columna1=''
	
if keydown(keycontrol!) and keydown(keyN!) then
	ls_dw = this.DataObject
	Clipboard(ls_dw)
	ls_columna = GetColumnName()
	ls_columna1 = describe('#'+string(GetColumn())+'.dbname')
	if isnull(ls_columna) or trim(ls_columna) = '' then return
	if isnull(ls_columna1) or trim(ls_columna1) = '' then return
	if trim(ls_columna) = trim(ls_columna1) then
		MessageBox('NOMBRE DEL DATAWINDOW: '+ls_dw,'NOMBRE DE LA COLUMNA: '+ls_columna,&
			Information!)
	else
		MessageBox('NOMBRE DEL DATAWINDOW: '+ls_dw,'NOMBRE DE LA COLUMNA: '+ls_columna+&
					'~nNOMBRE EN LA BASE DE DATOS: '+ls_columna1)
	end if
end if

// Modificado por Gianni Araúz (30/05/2000)
// Para el caso de los reportes, sólo debe mostrar el nombre del DataWindow

if keydown(keycontrol!) and keydown(keyM!) then
	ls_dw = this.DataObject
	if isnull(ls_dw) or trim(ls_dw) = '' then return
	MessageBox('Usuario: '+str.usuario,'NOMBRE DEL DATAWINDOW: '+ls_dw,Information!)
end if

end event

event ue_entercol;//send(handle(this),256,9,long(0,0))
//return 1
end event

event ue_helpcol;// Toma la Columna en la cual el usuario pidio ayuda

String ls_col,ls_item

ls_col = This.GetColumnName()

//CHOOSE CASE ls_col
//		
//	CASE " "  /*Precio*/
//		
//END CHOOSE
//



end event

event ue_enter;send(handle(this),256,9,long(0,0))
return 1
end event

event itemchanged;// Copia y pega en tu ventana


//string ls_var
//
//
//if Dw_1.GetColumnName () = "serv_servicio"  & 
//   and dw_1.GetItemStatus (dw_1.getrow(),0,primary! ) = new! then
//	
//	
//	  if not isnull (data) then
//		
//		wf_carga_gf_emp("serv")
//		
//	  end if
//	
//	
//end if
//


end event

event dberror;// Rutina para los errores de la base de datod

If sqlerrtext <> "" Then
	gf_dw_error(sqldbcode, sqlerrtext)
	Return 1
End If
end event

event clicked;dw=this
end event

event rbuttondown;m_in_padre.m_edicion.PopMenu(parent.PointerX( ), parent.PointerY( ))
end event

type gb_ventana from groupbox within w_in_granpa
integer x = 14
integer y = 772
integer width = 859
integer height = 116
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

