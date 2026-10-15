//objectcomments Ventana padre principal de cuentas por cobrar
forward
global type w_cc_padre from w_granpa
end type
end forward

global type w_cc_padre from w_granpa
integer width = 1234
integer height = 1008
string menuname = "m_fa_principal"
boolean maxbox = false
boolean resizable = false
string icon = "\Art\Mapif5l.ico"
end type
global w_cc_padre w_cc_padre

on w_cc_padre.create
call super::create
if this.MenuName = "m_fa_principal" then this.MenuID = create m_fa_principal
end on

on w_cc_padre.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)
//str.frame.SetRedraw ( True )
sqlca.AutoCommit = true

if not isvalid(m_fa_principal) then changemenu(m_fa_principal)

m_fa_principal.m_archivo.m_guardar.ToolbarItemVisible  = false
m_fa_principal.m_archivo.m_imprimir.ToolbarItemVisible = false	
m_fa_principal.m_archivo.m_cerrar.ToolbarItemVisible   = true	

end event

event resize;call super::resize;// Centrar los objetos de la ventana padre
//gf_center_parent_items(this, gb_1, st_nom_ventana, 25, sizetype)
//return 0
end event

type st_nom_ventana from w_granpa`st_nom_ventana within w_cc_padre
integer x = 32
integer y = 744
end type

type dw_1 from w_granpa`dw_1 within w_cc_padre
integer x = 78
integer y = 40
integer width = 1015
integer height = 656
end type

