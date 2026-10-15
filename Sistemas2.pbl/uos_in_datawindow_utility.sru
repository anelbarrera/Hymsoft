forward
global type uos_in_datawindow_utility from datawindow
end type
end forward

global type uos_in_datawindow_utility from datawindow
integer width = 494
integer height = 360
integer taborder = 10
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event ue_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
end type
global uos_in_datawindow_utility uos_in_datawindow_utility

type variables
boolean	ib_no_insertar, ib_adicionar

end variables

event ue_enter;// Gianni Araúz (11/10/1999)
// Este script hace que el cursor se posicione en la siguiente columna (según el TabOrder)
// al presionar la tecla ENTER. Para esto, el tabsequence de dicha columna debe ser
// mayor que 0.

//	Modificado por Gianni Araúz (25/10/1999). Ahora se pregunta si desea insertar otro
//	registro, de no ser así permanece en la misma posición.

//	Modificado por Gianni Araúz (19/07/2000). Ahora se inserta el registro o se dispara el
// evento ue_adicionar.


string		ls_colum
long			ll_cont, ll_num_max_col, ll_tab_order, ll_tab_order_next
boolean		lb_exist_nextcol
window		lw_window

lw_window = str.frame.getactivesheet()

lb_exist_nextcol = true

if IsValid(this) then
	if this.AcceptText() < 0 then
		return 1
	end if
	lb_exist_nextcol = false
	ls_colum = GetColumnName()
	ll_num_max_col = long(this.object.datawindow.column.count)
	ll_tab_order = long(this.Describe(ls_colum + ".TabSequence"))
	for ll_cont = 1 to ll_num_max_col
		ls_colum = this.Describe("#" + string(ll_cont) + ".Name")
		ll_tab_order_next = long(this.Describe(ls_colum + ".TabSequence"))
		if ll_tab_order_next = ll_tab_order + 10 then
			lb_exist_nextcol = true
			ll_cont = ll_num_max_col
		end if
	next
end if

if not lb_exist_nextcol then
	if not ib_no_insertar then
		if this.getrow() = this.rowcount() then
			if messagebox('Información','¿Desea Insertar otro Registro?',Information!,Yesno!,1) = 1 then
				if ib_adicionar then
					lw_window.triggerevent('ue_adicionar')
				else
					this.InsertRow(0)
				end if
			else
				return 1
			end if
		else
			Send(Handle(this),256,9,long(0,0))
		end if
	else
		Send(Handle(this),256,9,long(0,0))
	end if
else
	Send(Handle(this),256,9,long(0,0))
end if

return 1

end event

event ue_dwnkey;// Gianni Araúz (11/10/1999)
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
	MessageBox('Ventana: '+parent.classname(),'NOMBRE DEL DATAWINDOW: '+ls_dw,Information!)
end if

end event

event dberror;// Gianni Araúz (06/06/2000)

// Modificado por Gianni Araúz (21/07/2000). Ahora se cierra la ventana si la tabla no tiene
// permisos.

string	ls_error, ls_dbcode

if trim(sqlerrtext) <> '' then
	ls_error = sqlerrtext+'.'
	ls_dbcode = string(sqldbcode)
	rollback;
	mensaje('Error # '+ls_dbcode,'Descripción: '+ls_error,'')
	return 1
end if

end event

on uos_in_datawindow_utility.create
end on

on uos_in_datawindow_utility.destroy
end on

