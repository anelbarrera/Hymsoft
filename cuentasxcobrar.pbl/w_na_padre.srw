//objectcomments Padre en la Herencia del Sistema de Facturacion
forward
global type w_na_padre from w_granpa
end type
type st_ayuda from statictext within w_na_padre
end type
type dw_10 from datawindow within w_na_padre
end type
end forward

global type w_na_padre from w_granpa
long backcolor = 79416533
event ue_zoom_down ( )
event ue_borrar ( )
event ue_save_as ( )
st_ayuda st_ayuda
dw_10 dw_10
end type
global w_na_padre w_na_padre

type variables
Datawindow dw_impresion
Boolean ib_modify
String  is_ultima_, is_orden_

boolean ib_aceptar
end variables

event ue_save_as;//
dw.saveas()
end event

on w_na_padre.create
int iCurrent
call super::create
this.st_ayuda=create st_ayuda
this.dw_10=create dw_10
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_ayuda
this.Control[iCurrent+2]=this.dw_10
end on

event open;call super::open;
This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)

//Configurar los Accesos

//mf_accesos(this.menuid, this)

str.frame.SetRedraw ( True )
end event

on w_na_padre.destroy
call super::destroy
destroy(this.st_ayuda)
destroy(this.dw_10)
end on

event ue_post_open;call super::ue_post_open;if isvalid(m_na_principal) then
  m_na_principal.m_ventanas.m_regla.toolbaritemvisible=false

end if 	

end event

event key;if Key = KeyEscape! then
	this.Postevent("close")
end if
end event

event close;if isvalid(this) then close(this)

end event

event ue_aceptar;//override
long ll_update
window lw_ventana
string ls_titulo

//lw_ventana = this.getactivesheet()
//ls_titulo = lw_ventana.title

ll_update=dw.update()

if ll_update = 1  then
	commit using sqlca;
	mensaje("Información","¡Actualización Exitosa !","")
else
	rollback using sqlca;
	mensaje("Atención","¡Error al Actualizar !",sqlca.sqlerrtext)
end if



end event

event ue_pre_aceptar;call super::ue_pre_aceptar;sqlca.autocommit = true
end event

event resize;call super::resize;dw_1.Resize(This.Width - 170, This.Height - 330)
//gb_1.width  = this.width  - 63
//gb_1.height = this.height - 220
st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180
end event

event ue_filter;call super::ue_filter;//Para recalcular los grupos, despues de filtrar
dw.groupcalc()
end event

type st_nom_ventana from w_granpa`st_nom_ventana within w_na_padre
boolean visible = false
long backcolor = 79416533
end type

type dw_1 from w_granpa`dw_1 within w_na_padre
event ue_escape pbm_dwescape
event ue_tabfinal pbm_dwntabout
end type

event dw_1::ue_escape;parent.Postevent("close")
end event

event dw_1::ue_tabfinal;call super::ue_tabfinal;parent.triggerevent("ue_adicionar")
end event

event dw_1::rbuttondown;call super::rbuttondown;m_na_principal.M_edicin.PopMenu(parent.PointerX( ), parent.PointerY( ))
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;gf_micro_ayuda(this)
end event

event dw_1::clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto
integer li_pos 

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
end event

type st_ayuda from statictext within w_na_padre
boolean visible = false
integer x = 462
integer y = 412
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15793151
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_10 from datawindow within w_na_padre
event ue_enter pbm_dwnprocessenter
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
event ue_mousemove pbm_mousemove
event ue_down pbm_dwnkey
boolean visible = false
integer x = 869
integer y = 228
integer width = 119
integer height = 108
integer taborder = 30
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
//gf_al_enabled_save(str.frame.GetActiveSheet().MenuName, True)
end event

event rowfocuschanged;///* Marca la linea selecionada con un color azul */
//dw.selectrow(0,false)
//dw.selectrow(getrow(),true)
end event

