forward
global type w_foto_producto from window
end type
type dw_1 from datawindow within w_foto_producto
end type
end forward

global type w_foto_producto from window
integer width = 1445
integer height = 1488
boolean titlebar = true
string title = "Foto..."
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
global w_foto_producto w_foto_producto

forward prototypes
public subroutine wf_asignar (string as_foto, long al_cantidad, decimal ad_precio)
end prototypes

public subroutine wf_asignar (string as_foto, long al_cantidad, decimal ad_precio);dw_1.setitem(1,'foto',as_foto)
dw_1.setitem(1,'cantidad',al_cantidad)
dw_1.setitem(1,'precio',ad_precio)


end subroutine

on w_foto_producto.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_foto_producto.destroy
destroy(this.dw_1)
end on

event open;this.x = 5040
this.y = 0
dw_1.insertrow(1)
str_foto_cantidad_precio lstr_foto_cantidad_precio

lstr_foto_cantidad_precio = message.powerobjectparm

dw_1.setitem(1,'foto', lstr_foto_cantidad_precio.foto)
dw_1.setitem(1,'cantidad', lstr_foto_cantidad_precio.ultima_cantidad)
dw_1.setitem(1,'precio', lstr_foto_cantidad_precio.ultimo_precio)

//OpenSheet(w_captura_proformas,str.frame,2,Original!)
end event

event resize;dw_1.resize(newwidth - 100, newheight - 70)
dw_1.modify("foto.width='"+string(newwidth - 160)+"'")
dw_1.modify("foto.height='"+string(newheight - 200)+"'")
end event

type dw_1 from datawindow within w_foto_producto
integer x = 46
integer y = 28
integer width = 1312
integer height = 1328
integer taborder = 10
string title = "none"
string dataobject = "dw_foto_producto"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

