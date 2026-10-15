forward
global type w_r_toolbars from Window
end type
type cbx_showtoolbar from checkbox within w_r_toolbars
end type
type rb_floating from radiobutton within w_r_toolbars
end type
type rb_bottom from radiobutton within w_r_toolbars
end type
type rb_right from radiobutton within w_r_toolbars
end type
type rb_top from radiobutton within w_r_toolbars
end type
type rb_left from radiobutton within w_r_toolbars
end type
type cbx_show_tips from checkbox within w_r_toolbars
end type
type cbx_showtext from checkbox within w_r_toolbars
end type
type cb_done from commandbutton within w_r_toolbars
end type
type gb_move from groupbox within w_r_toolbars
end type
end forward

global type w_r_toolbars from Window
int X=901
int Y=621
int Width=1148
int Height=697
boolean TitleBar=true
string Title="Personalizar Barra"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
cbx_showtoolbar cbx_showtoolbar
rb_floating rb_floating
rb_bottom rb_bottom
rb_right rb_right
rb_top rb_top
rb_left rb_left
cbx_show_tips cbx_show_tips
cbx_showtext cbx_showtext
cb_done cb_done
gb_move gb_move
end type
global w_r_toolbars w_r_toolbars

type variables
window iw_win_ref
application iapp_ref
end variables

event open;//se pasa una ventana como parametro
iw_win_ref = message.powerobjectparm

if not(IsValid(iw_win_ref)) then
	iw_win_ref = str.frame.GetActiveSheet()
end if

if not(IsValid(iw_win_ref)) then
	iw_win_ref = str.frame
end if

//	Colocar los radio buttons para reflejar el estado de la barra.
choose case iw_win_ref.toolbaralignment
case alignatbottom! 
	rb_bottom.checked = TRUE
case alignatleft!
	rb_left.checked = TRUE
case alignatright!
	rb_right.checked = TRUE
case alignattop! 
	rb_top.checked = TRUE
case floating!
	rb_floating.checked = TRUE
end choose

//	tomar la applicación.
iapp_ref = getapplication()

//	Colocar los check boxes para reflejar el estado de la barra.
cbx_showtoolbar.checked = iw_win_ref.toolbarvisible
cbx_showtext.checked = iapp_ref.toolbartext
cbx_show_tips.checked = iapp_ref.toolbartips
	
end event

on w_r_toolbars.create
this.cbx_showtoolbar=create cbx_showtoolbar
this.rb_floating=create rb_floating
this.rb_bottom=create rb_bottom
this.rb_right=create rb_right
this.rb_top=create rb_top
this.rb_left=create rb_left
this.cbx_show_tips=create cbx_show_tips
this.cbx_showtext=create cbx_showtext
this.cb_done=create cb_done
this.gb_move=create gb_move
this.Control[]={ this.cbx_showtoolbar,&
this.rb_floating,&
this.rb_bottom,&
this.rb_right,&
this.rb_top,&
this.rb_left,&
this.cbx_show_tips,&
this.cbx_showtext,&
this.cb_done,&
this.gb_move}
end on

on w_r_toolbars.destroy
destroy(this.cbx_showtoolbar)
destroy(this.rb_floating)
destroy(this.rb_bottom)
destroy(this.rb_right)
destroy(this.rb_top)
destroy(this.rb_left)
destroy(this.cbx_show_tips)
destroy(this.cbx_showtext)
destroy(this.cb_done)
destroy(this.gb_move)
end on

type cbx_showtoolbar from checkbox within w_r_toolbars
int X=526
int Y=77
int Width=595
int Height=73
string Text="&Ver Barra"
BorderStyle BorderStyle=StyleLowered!
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;iw_win_ref.ToolbarVisible = this.checked

end event

type rb_floating from radiobutton within w_r_toolbars
int X=110
int Y=441
int Width=343
int Height=73
string Text="&Flotando"
BorderStyle BorderStyle=StyleLowered!
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;iw_win_ref.toolbaralignment = floating!

end event

type rb_bottom from radiobutton within w_r_toolbars
int X=110
int Y=353
int Width=311
int Height=73
string Text="A&bajo"
BorderStyle BorderStyle=StyleLowered!
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;iw_win_ref.toolbaralignment = alignatbottom!

end event

type rb_right from radiobutton within w_r_toolbars
int X=110
int Y=265
int Width=343
int Height=73
string Text="&Derecha"
BorderStyle BorderStyle=StyleLowered!
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;iw_win_ref.toolbaralignment = alignatright!

end event

type rb_top from radiobutton within w_r_toolbars
int X=110
int Y=177
int Width=284
int Height=73
string Text="&Arriba"
BorderStyle BorderStyle=StyleLowered!
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;iw_win_ref.toolbaralignment = alignattop!

end event

type rb_left from radiobutton within w_r_toolbars
int X=110
int Y=89
int Width=339
int Height=73
string Text="&Izquierda"
BorderStyle BorderStyle=StyleLowered!
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;iw_win_ref.toolbaralignment = alignatleft!

end event

type cbx_show_tips from checkbox within w_r_toolbars
int X=526
int Y=169
int Width=586
int Height=73
string Text="Ver &PowerTips"
BorderStyle BorderStyle=StyleLowered!
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;iapp_ref.toolbartips = this.checked

end event

type cbx_showtext from checkbox within w_r_toolbars
int X=526
int Y=257
int Width=426
int Height=73
string Text="Ver Te&xto"
BorderStyle BorderStyle=StyleLowered!
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;iapp_ref.toolbartext = this.checked

end event

type cb_done from commandbutton within w_r_toolbars
int X=700
int Y=449
int Width=357
int Height=101
int TabOrder=20
string Text="Aceptar"
boolean Default=true
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(parent)

end event

type gb_move from groupbox within w_r_toolbars
int X=55
int Y=17
int Width=412
int Height=529
int TabOrder=10
string Text="Mover"
BorderStyle BorderStyle=StyleLowered!
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

