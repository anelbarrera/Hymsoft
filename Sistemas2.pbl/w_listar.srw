forward
global type w_listar from Window
end type
type lb_2 from listbox within w_listar
end type
type dw_1 from datawindow within w_listar
end type
type cb_2 from commandbutton within w_listar
end type
type lb_1 from listbox within w_listar
end type
type cb_1 from commandbutton within w_listar
end type
end forward

global type w_listar from Window
int X=823
int Y=360
int Width=3246
int Height=1488
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
lb_2 lb_2
dw_1 dw_1
cb_2 cb_2
lb_1 lb_1
cb_1 cb_1
end type
global w_listar w_listar

type variables
INTEGER II
end variables

on w_listar.create
this.lb_2=create lb_2
this.dw_1=create dw_1
this.cb_2=create cb_2
this.lb_1=create lb_1
this.cb_1=create cb_1
this.Control[]={this.lb_2,&
this.dw_1,&
this.cb_2,&
this.lb_1,&
this.cb_1}
end on

on w_listar.destroy
destroy(this.lb_2)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.lb_1)
destroy(this.cb_1)
end on

event open;dw_1.Settransobject(sqlca)
end event

type lb_2 from listbox within w_listar
int X=983
int Y=40
int Width=754
int Height=544
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within w_listar
int X=142
int Y=740
int Width=2153
int Height=528
int TabOrder=30
string DataObject="dw_listador_bmp"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_2 from commandbutton within w_listar
int X=1838
int Y=140
int Width=955
int Height=108
int TabOrder=40
string Text="Recorrer"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// Copia las listas al data windows para se salvado posterior mente


integer li_index, li_total, i
string ls_Item

li_total = lb_1.TotalItems()
for  i = 1 to li_total
	li_Index = lb_1.SelectItem(i)	
	ls_Item = lb_1.SelectedItem()
	dw_1.Scrolltorow(dw_1.insertrow(0))	
	dw_1.Setitem(dw_1.GetRow(),"dato",'\harr2000\art\'+ls_item)
next

li_total = lb_2.TotalItems()
for  i = 1 to li_total
	li_Index = lb_2.SelectItem(i)	
	ls_Item = lb_2.SelectedItem()
	dw_1.Scrolltorow(dw_1.insertrow(0))	
	dw_1.Setitem(dw_1.GetRow(),"dato",'\harr2000\art\'+ls_item)
next

end event

type lb_1 from listbox within w_listar
int X=151
int Y=40
int Width=754
int Height=544
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_listar
int X=1838
int Y=364
int Width=955
int Height=108
int TabOrder=20
string Text="Recuperar lista de *.bmp / *.ico"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;lb_1.DirList("f:\harr2000\art\*.bmp", 0)
lb_2.DirList("f:\harr2000\art\*.ico", 0)


end event

