//objectcomments  
forward
global type w_detalle_ventas from window
end type
type dw_1 from datawindow within w_detalle_ventas
end type
end forward

global type w_detalle_ventas from window
accessiblerole accessiblerole = defaultrole!
integer x = 0
integer y = 0
integer width = 3616
integer height = 2596
boolean enabled = true
boolean titlebar = true
string title = "Detalle Ventas"
boolean controlmenu = true
boolean minbox = false
boolean maxbox = false
boolean hscrollbar = false
boolean vscrollbar = false
boolean resizable = false
boolean border = true
windowtype windowtype = response!
windowstate windowstate = normal!
long backcolor = 67108864
string icon = "AppIcon!"
integer unitsperline = 0
integer linesperpage = 0
integer unitspercolumn = 0
integer columnsperpage = 0
boolean bringtotop = false
boolean toolbarvisible = true
toolbaralignment toolbaralignment = alignattop!
integer toolbarx = 0
integer toolbary = 0
integer toolbarwidth = 0
integer toolbarheight = 0
boolean righttoleft = false
boolean keyboardicon = true
boolean clientedge = false
boolean palettewindow = false
boolean contexthelp = false
boolean center = true
integer transparency = 0
windowanimationstyle openanimation = centeranimation!
windowanimationstyle closeanimation = centeranimation!
integer animationtime = 200
windowdockoptions windowdockoptions = windowdockoptionall!
windowdockstate windowdockstate = windowdockstatedocked!
long tabbeddocumenttabsareacolor = 1073741824
long tabbeddocumenttabsareagradientcolor = 1073741824
boolean tabbeddocumenttabsareagradientvert = false
long tabbedwindowtabsareacolor = 1073741824
long tabbedwindowtabsareagradientcolor = 1073741824
boolean tabbedwindowtabsareagradientvert = false
long titlebaractivecolor = 134217730
long titlebaractivegradientcolor = 134217730
boolean titlebaractivegradientvert = false
long titlebaractivetextcolor = 0
long titlebarinactivecolor = 134217731
long titlebarinactivegradientcolor = 134217731
boolean titlebarinactivegradientvert = false
long titlebarinactivetextcolor = 0
windowdocktabshape tabbeddocumenttabshape = windowdocktabrectangular!
windowdocktabclosebutton tabbeddocumenttabclosebutton = windowdocktabclosebuttononactive!
boolean tabbeddocumenttabicon = true
boolean tabbeddocumenttabscroll = false
windowdocktabshape tabbedwindowtabshape = windowdocktabrectangular!
windowdocktabclosebutton tabbedwindowtabclosebutton = windowdocktabclosebuttonnone!
boolean tabbedwindowtabicon = true
boolean tabbedwindowtabscroll = false
boolean tabbeddocumenttabcolorsusetheme = true
long tabbeddocumentactivetabbackcolor = 1073741824
long tabbeddocumentactivetabgradientbackcolor = 1073741824
long tabbeddocumentactivetabtextcolor = 0
long tabbeddocumentinactivetabbackcolor = 67108864
long tabbeddocumentinactivetabgradientbackcolor = 67108864
long tabbeddocumentinactivetabtextcolor = 0
long tabbeddocumentmouseovertabbackcolor = 67108864
long tabbeddocumentmouseovertabgradientbackcolor = 67108864
long tabbeddocumentmouseovertabtextcolor = 0
boolean tabbedwindowtabcolorsusetheme = true
long tabbedwindowactivetabbackcolor = 1073741824
long tabbedwindowactivetabgradientbackcolor = 1073741824
long tabbedwindowactivetabtextcolor = 0
long tabbedwindowinactivetabbackcolor = 67108864
long tabbedwindowinactivetabgradientbackcolor = 67108864
long tabbedwindowinactivetabtextcolor = 0
long tabbedwindowmouseovertabbackcolor = 67108864
long tabbedwindowmouseovertabgradientbackcolor = 67108864
long tabbedwindowmouseovertabtextcolor = 0
boolean toolbarinsheet = false
boolean tabbedview = false
boolean maximizealltabbedsheets = false
boolean displaymenuasribbonbar = false
boolean sheetlistvisible = true
integer sheetlistimagesize = 0
string sheetlistimage = "RibbonSmallButtonDefault!"
string sheetlisttext = "SheetList"
string sheetlistpaneltext = "SheetList"
dw_1 dw_1
end type
global w_detalle_ventas w_detalle_ventas

on w_detalle_ventas.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_detalle_ventas.destroy
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
str_fa_dw_rep lstr_argumentos

lstr_argumentos = message.powerobjectparm

dw_1.retrieve(str.g_financiero, str.empresa, lstr_argumentos.fecha_ini, lstr_argumentos.fecha_fin)
end event

type dw_1 from datawindow within w_detalle_ventas
integer x = 27
integer y = 40
integer width = 3538
integer height = 2428
integer taborder = 10
string title = "none"
string dataobject = "dw_detalle_ventas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

