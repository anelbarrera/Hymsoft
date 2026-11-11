//objectcomments  
forward
global type w_fa_co_pedidos_sala_vta from w_fa_padre
end type
type gb_1 from groupbox within w_fa_co_pedidos_sala_vta
end type
type cb_1 from commandbutton within w_fa_co_pedidos_sala_vta
end type
type st_1 from statictext within w_fa_co_pedidos_sala_vta
end type
end forward

global type w_fa_co_pedidos_sala_vta from w_fa_padre
int Width=1810
int Height=1108
WindowType WindowType=response!
boolean TitleBar=true
string Title="(FA) Pedidos de Sala de Vta. Pendientes por Pasar"
long BackColor=79741120
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
gb_1 gb_1
cb_1 cb_1
st_1 st_1
end type
global w_fa_co_pedidos_sala_vta w_fa_co_pedidos_sala_vta

on w_fa_co_pedidos_sala_vta.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.cb_1=create cb_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_1
end on

on w_fa_co_pedidos_sala_vta.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.st_1)
end on

event ue_post_open;call super::ue_post_open;//,w_fa_fondo.str_para.cliente_contado
If dw_1.Retrieve(str.g_financiero,str.empresa,w_fa_fondo.str_para.ano)< 1 Then
	mensaje("Atención","No hay pedidos de Sala de Venta pendientes por pasar a factura ..Gracias","")
	close(this)
	return
end if

end event

event ue_aceptar;//Override
end event

event ue_adicionar;//Override
end event

event ue_eliminar;//Override
end event

event ue_insertar;//Override
end event

event ue_imprimir;//Override
end event

event closequery;//Override
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_co_pedidos_sala_vta
int X=64
int Y=908
int Height=80
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_co_pedidos_sala_vta
int X=69
int Width=1637
int Height=804
int TabOrder=10
string DataObject="dw_co_fa_pedidos_sala_vta"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
end type

type st_ayuda from w_fa_padre`st_ayuda within w_fa_co_pedidos_sala_vta
boolean BringToTop=true
end type

type gb_1 from groupbox within w_fa_co_pedidos_sala_vta
int X=41
int Y=12
int Width=1687
int Height=880
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_fa_co_pedidos_sala_vta
int X=1463
int Y=920
int Width=256
int Height=88
int TabOrder=11
boolean BringToTop=true
string Text="Cerrar"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.triggerevent("close")
end event

type st_1 from statictext within w_fa_co_pedidos_sala_vta
int X=1454
int Y=912
int Width=270
int Height=100
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

