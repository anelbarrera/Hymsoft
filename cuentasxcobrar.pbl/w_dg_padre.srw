//objectcomments Ventana Padre de Datos Generales
forward
global type w_dg_padre from w_granpa
end type
end forward

global type w_dg_padre from w_granpa
integer width = 1093
integer height = 884
end type
global w_dg_padre w_dg_padre

on w_dg_padre.create
call super::create
end on

on w_dg_padre.destroy
call super::destroy
end on

event open;call super::open;sqlca.autocommit = true
This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)
end event

event key;if key = KeyEscape! then
	this.Postevent("close")
end if
end event

event close;if isvalid(this) then
	close (this)
end if	
end event

type st_nom_ventana from w_granpa`st_nom_ventana within w_dg_padre
end type

type dw_1 from w_granpa`dw_1 within w_dg_padre
event ue_escape pbm_dwescape
end type

