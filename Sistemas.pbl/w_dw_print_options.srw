//objectcomments Ventana de Selección de impresión estilo Win
forward
global type w_dw_print_options from window
end type
type cbx_formato from checkbox within w_dw_print_options
end type
type st_nom_ventana from statictext within w_dw_print_options
end type
type sle_6 from singlelineedit within w_dw_print_options
end type
type sle_5 from singlelineedit within w_dw_print_options
end type
type sle_4 from singlelineedit within w_dw_print_options
end type
type sle_3 from singlelineedit within w_dw_print_options
end type
type sle_2 from singlelineedit within w_dw_print_options
end type
type sle_1 from singlelineedit within w_dw_print_options
end type
type ddlb_range from dropdownlistbox within w_dw_print_options
end type
type st_4 from statictext within w_dw_print_options
end type
type cb_printer from commandbutton within w_dw_print_options
end type
type cb_cancel from commandbutton within w_dw_print_options
end type
type cbx_collate from checkbox within w_dw_print_options
end type
type cbx_print_to_file from checkbox within w_dw_print_options
end type
type st_3 from statictext within w_dw_print_options
end type
type sle_page_range from singlelineedit within w_dw_print_options
end type
type rb_pages from radiobutton within w_dw_print_options
end type
type rb_current_page from radiobutton within w_dw_print_options
end type
type rb_all from radiobutton within w_dw_print_options
end type
type em_copies from editmask within w_dw_print_options
end type
type st_2 from statictext within w_dw_print_options
end type
type sle_printer from singlelineedit within w_dw_print_options
end type
type st_1 from statictext within w_dw_print_options
end type
type cb_ok from commandbutton within w_dw_print_options
end type
type gb_3 from groupbox within w_dw_print_options
end type
type gb_2 from groupbox within w_dw_print_options
end type
type gb_1 from groupbox within w_dw_print_options
end type
end forward

global type w_dw_print_options from window
integer x = 672
integer y = 268
integer width = 2267
integer height = 1148
boolean titlebar = true
string title = "Opciones de Impresión"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
toolbaralignment toolbaralignment = alignatleft!
event ue_syccommand pbm_syscommand
cbx_formato cbx_formato
st_nom_ventana st_nom_ventana
sle_6 sle_6
sle_5 sle_5
sle_4 sle_4
sle_3 sle_3
sle_2 sle_2
sle_1 sle_1
ddlb_range ddlb_range
st_4 st_4
cb_printer cb_printer
cb_cancel cb_cancel
cbx_collate cbx_collate
cbx_print_to_file cbx_print_to_file
st_3 st_3
sle_page_range sle_page_range
rb_pages rb_pages
rb_current_page rb_current_page
rb_all rb_all
em_copies em_copies
st_2 st_2
sle_printer sle_printer
st_1 st_1
cb_ok cb_ok
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
end type
global w_dw_print_options w_dw_print_options

type variables
string is_page_range
datawindow idw_dw
end variables

forward prototypes
private subroutine wf_page_range (radiobutton who)
public subroutine centrar_w ()
end prototypes

event ue_syccommand;if commandtype = 61536 then
	closewithreturn(this,-1)
end if
end event

private subroutine wf_page_range (radiobutton who);choose case who
	case rb_all
		sle_page_range.text = ''
		sle_page_range.enabled = false
		is_page_range = 'a'
	case rb_current_page
		sle_page_range.text = ''
		sle_page_range.enabled = false
		is_page_range = 'c'
	case rb_pages		
		sle_page_range.enabled = true
		is_page_range = 'p'
end choose
end subroutine

public subroutine centrar_w ();integer li_posicion_x,li_posicion_y
li_posicion_x=str.frame.width/2  -20 - this.width/2 
li_posicion_y=str.frame.height/2 -100 - this.height/2 
if 0  > li_posicion_x then
	li_posicion_x = 1
	this.HScrollBar = TRUE
else
	this.HScrollBar = False
end if
if 0  > li_posicion_y then
	li_posicion_y = 1
	this.VScrollBar = TRUE
else
	this.VScrollBar = False
end if
this.x=li_posicion_x 
// this.y=li_posicion_y

end subroutine

event open;This.Icon = str.icono
// we assume that this window will be opened using openwitparm and that
// a datawindow control will be passed to it
centrar_w()
idw_dw = message.powerobjectparm
sle_printer.text = idw_dw.describe('datawindow.printer')
st_nom_ventana.text = this.classname()
is_page_range = 'a'
end event

on w_dw_print_options.create
this.cbx_formato=create cbx_formato
this.st_nom_ventana=create st_nom_ventana
this.sle_6=create sle_6
this.sle_5=create sle_5
this.sle_4=create sle_4
this.sle_3=create sle_3
this.sle_2=create sle_2
this.sle_1=create sle_1
this.ddlb_range=create ddlb_range
this.st_4=create st_4
this.cb_printer=create cb_printer
this.cb_cancel=create cb_cancel
this.cbx_collate=create cbx_collate
this.cbx_print_to_file=create cbx_print_to_file
this.st_3=create st_3
this.sle_page_range=create sle_page_range
this.rb_pages=create rb_pages
this.rb_current_page=create rb_current_page
this.rb_all=create rb_all
this.em_copies=create em_copies
this.st_2=create st_2
this.sle_printer=create sle_printer
this.st_1=create st_1
this.cb_ok=create cb_ok
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.cbx_formato,&
this.st_nom_ventana,&
this.sle_6,&
this.sle_5,&
this.sle_4,&
this.sle_3,&
this.sle_2,&
this.sle_1,&
this.ddlb_range,&
this.st_4,&
this.cb_printer,&
this.cb_cancel,&
this.cbx_collate,&
this.cbx_print_to_file,&
this.st_3,&
this.sle_page_range,&
this.rb_pages,&
this.rb_current_page,&
this.rb_all,&
this.em_copies,&
this.st_2,&
this.sle_printer,&
this.st_1,&
this.cb_ok,&
this.gb_3,&
this.gb_2,&
this.gb_1}
end on

on w_dw_print_options.destroy
destroy(this.cbx_formato)
destroy(this.st_nom_ventana)
destroy(this.sle_6)
destroy(this.sle_5)
destroy(this.sle_4)
destroy(this.sle_3)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.ddlb_range)
destroy(this.st_4)
destroy(this.cb_printer)
destroy(this.cb_cancel)
destroy(this.cbx_collate)
destroy(this.cbx_print_to_file)
destroy(this.st_3)
destroy(this.sle_page_range)
destroy(this.rb_pages)
destroy(this.rb_current_page)
destroy(this.rb_all)
destroy(this.em_copies)
destroy(this.st_2)
destroy(this.sle_printer)
destroy(this.st_1)
destroy(this.cb_ok)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type cbx_formato from checkbox within w_dw_print_options
integer x = 869
integer y = 216
integer width = 795
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "Mantener Formato de la Factura"
end type

type st_nom_ventana from statictext within w_dw_print_options
boolean visible = false
integer x = 32
integer y = 968
integer width = 946
integer height = 68
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 77107328
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type sle_6 from singlelineedit within w_dw_print_options
integer x = 1623
integer y = 616
integer width = 87
integer height = 96
integer taborder = 81
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "   1"
boolean autohscroll = false
boolean displayonly = true
end type

type sle_5 from singlelineedit within w_dw_print_options
integer x = 1664
integer y = 580
integer width = 87
integer height = 96
integer taborder = 110
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "   2"
boolean autohscroll = false
boolean displayonly = true
end type

type sle_4 from singlelineedit within w_dw_print_options
integer x = 1701
integer y = 548
integer width = 87
integer height = 96
integer taborder = 90
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "   3"
boolean autohscroll = false
boolean displayonly = true
end type

type sle_3 from singlelineedit within w_dw_print_options
integer x = 1440
integer y = 616
integer width = 87
integer height = 96
integer taborder = 80
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "   1"
boolean autohscroll = false
boolean displayonly = true
end type

type sle_2 from singlelineedit within w_dw_print_options
integer x = 1481
integer y = 580
integer width = 87
integer height = 96
integer taborder = 120
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "   2"
boolean autohscroll = false
boolean displayonly = true
end type

type sle_1 from singlelineedit within w_dw_print_options
integer x = 1518
integer y = 548
integer width = 87
integer height = 96
integer taborder = 70
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "   3"
boolean autohscroll = false
boolean displayonly = true
end type

type ddlb_range from dropdownlistbox within w_dw_print_options
integer x = 270
integer y = 768
integer width = 1065
integer height = 288
integer taborder = 190
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "Todas las Páginas en Rango"
boolean sorted = false
string item[] = {"Todas las Páginas en Rango","Pares  (Páginas del Número Pares)","Impares Páginas del Número Impares)"}
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_dw_print_options
integer x = 64
integer y = 780
integer width = 187
integer height = 68
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78748035
boolean enabled = false
string text = "Imprimir:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_printer from commandbutton within w_dw_print_options
integer x = 1842
integer y = 80
integer width = 357
integer height = 88
integer taborder = 180
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Propiedades"
end type

event clicked;//printsetup()
//sle_printer.text = idw_dw.describe('datawindow.printer')

String ls_fullstring, ls_name
PrintSetup()
ls_fullstring = printGetPrinter() 
Long ll_place
ll_place=pos (ls_fullstring, "~t")
ls_name=left(ls_fullstring, ll_place -1)
sle_printer.text = ls_name
end event

type cb_cancel from commandbutton within w_dw_print_options
integer x = 1842
integer y = 856
integer width = 357
integer height = 88
integer taborder = 170
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancelar"
boolean cancel = true
end type

on clicked;closewithreturn(parent,-1)
end on

type cbx_collate from checkbox within w_dw_print_options
integer x = 1824
integer y = 612
integer width = 379
integer height = 68
integer taborder = 150
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78748035
string text = "Intercalada"
boolean checked = true
end type

type cbx_print_to_file from checkbox within w_dw_print_options
integer x = 315
integer y = 212
integer width = 466
integer height = 68
integer taborder = 140
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "Impresión Archivo"
end type

type st_3 from statictext within w_dw_print_options
integer x = 105
integer y = 616
integer width = 1198
integer height = 112
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78748035
boolean enabled = false
string text = "Escriba el número de página e intervalos separados por comas, Ejemplo: 2,5,8-10"
boolean focusrectangle = false
end type

type sle_page_range from singlelineedit within w_dw_print_options
integer x = 370
integer y = 516
integer width = 882
integer height = 84
integer taborder = 130
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 16777215
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type rb_pages from radiobutton within w_dw_print_options
integer x = 101
integer y = 528
integer width = 297
integer height = 68
integer taborder = 100
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78748035
string text = "Pagina:"
end type

on clicked;wf_page_range(this)
end on

type rb_current_page from radiobutton within w_dw_print_options
integer x = 101
integer y = 452
integer width = 567
integer height = 68
integer taborder = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78748035
string text = "Pagina Actual "
end type

event clicked;wf_page_range(this)
end event

type rb_all from radiobutton within w_dw_print_options
integer x = 101
integer y = 384
integer width = 242
integer height = 68
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78748035
string text = "&Todo"
boolean checked = true
end type

on clicked;wf_page_range(this)
end on

type em_copies from editmask within w_dw_print_options
integer x = 1851
integer y = 412
integer width = 242
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "1"
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type st_2 from statictext within w_dw_print_options
integer x = 1422
integer y = 428
integer width = 421
integer height = 68
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78748035
boolean enabled = false
string text = "Número de Copias:"
boolean focusrectangle = false
end type

type sle_printer from singlelineedit within w_dw_print_options
integer x = 306
integer y = 84
integer width = 1435
integer height = 84
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 16777215
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_dw_print_options
integer x = 73
integer y = 92
integer width = 224
integer height = 68
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78748035
boolean enabled = false
string text = "Nombre:"
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_dw_print_options
integer x = 1399
integer y = 856
integer width = 357
integer height = 88
integer taborder = 160
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Aceptar"
boolean default = true
end type

event clicked;string tmp, command
long   row 
string docname, named
int	 value

choose case lower(left(ddlb_range.text,1)) // determine rangeinclude (all,even,odd)
	case 't' // all
		tmp = '0'
	case 'p' // even
		tmp = '1'
	case 'i' //odd
		tmp = '2'
end choose
command = 'datawindow.print.page.rangeinclude = '+tmp
if cbx_collate.checked then // collate output ?
	command = command +  " datawindow.print.collate = yes"
else
	command = command +  " datawindow.print.collate = no"
end if
choose case is_page_range // did they pick a page range?
	case 'a'  // all
		tmp = ' '
	case 'c' // current page?
		row = idw_dw.getrow()
		tmp = idw_dw.describe("evaluate('page()',"+string(row)+")")
	case 'p' // a range?
		tmp = sle_page_range.text
end choose		
if len(tmp) > 0 then command = command +  " datawindow.print.page.range = '"+tmp+"'"

// number of copies ?
if len(em_copies.text) > 0 then command = command +  " datawindow.print.copies = "+em_copies.text

if cbx_print_to_file.checked then // print to file ?
	value = GetFileSaveName("Print To File", docname, named, "PRN", "Print (*.PRN),*.PRN")
	if value = 1 then 
		command = command + " datawindow.print.filename = '"+docname+"'"
	else // they canceled out of the dialog so quit completely
		return
	end if
end if

if cbx_formato.checked then
	if idw_dw.Describe("mantener.x") <> "?" and idw_dw.Describe("mantener.x") <> "!" then &
	idw_dw.object.mantener.expression = "'" + string(1) + "'"
else
	if idw_dw.Describe("mantener.x") <> "?" and idw_dw.Describe("mantener.x") <> "!" then &
	idw_dw.object.mantener.expression = "'" + string(0) + "'"
end if

// now alter the datawindow
tmp = idw_dw.modify(command)
if len(tmp) > 0 then // if error the display the 
	messagebox('Error Setting Print Options','Error message = ' + tmp + '~r~nCommand = ' + command)
	return
end if

closewithreturn(parent,1)
end event

type gb_3 from groupbox within w_dw_print_options
integer x = 1385
integer y = 316
integer width = 837
integer height = 424
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78748035
string text = "Copias"
end type

type gb_2 from groupbox within w_dw_print_options
integer x = 27
integer y = 16
integer width = 2199
integer height = 288
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 77107328
string text = "Impresora"
end type

type gb_1 from groupbox within w_dw_print_options
integer x = 23
integer y = 316
integer width = 1312
integer height = 424
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78748035
string text = "Rango de Pagina"
end type

