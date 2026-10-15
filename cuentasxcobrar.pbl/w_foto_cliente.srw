forward
global type w_foto_cliente from window
end type
type cb_1 from commandbutton within w_foto_cliente
end type
type dw_1 from datawindow within w_foto_cliente
end type
end forward

global type w_foto_cliente from window
integer width = 2789
integer height = 1716
boolean titlebar = true
string title = "Identificacion del Cliente"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12639424
string icon = "AppIcon!"
boolean center = true
windowanimationstyle openanimation = centeranimation!
windowanimationstyle closeanimation = fadeanimation!
cb_1 cb_1
dw_1 dw_1
end type
global w_foto_cliente w_foto_cliente

on w_foto_cliente.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_1}
end on

on w_foto_cliente.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;string ls_foto, ls_filter, ls_path, ls_nomfile
integer li_rtn

this.y = 200
this.x = 1200

dw_1.settransobject(sqlca)
dw_1.insertrow(1)
ls_foto = message.stringparm

if ls_foto <> '' and not isnull(ls_foto) then
	dw_1.setitem(1,'foto',ls_foto)
else
		ls_filter = "Achivos de Fotos (*.jpg),*.jpg," +&
					"Archivos de Fotos (*.gif),*.gif," +&
					"Archivos de Fotos (*.pdf),*.pdf," +&
					"Archivos de Fotos(*.bmp),*.bmp"
	
	li_rtn = GetFileOpenName("Asignar Foto ",ls_path,ls_nomfile,"jpg",ls_filter)
	
	if li_rtn = 1 then
		dw_1.SetItem(dw_1.Getrow(),"foto",ls_path)
	end if

end if
end event

type cb_1 from commandbutton within w_foto_cliente
integer x = 1170
integer y = 1484
integer width = 402
integer height = 116
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
end type

event clicked;string ls_foto
ls_foto = dw_1.getitemstring(1,'foto')
closewithreturn(w_foto_cliente, ls_foto)
end event

type dw_1 from datawindow within w_foto_cliente
integer x = 9
integer y = 16
integer width = 2743
integer height = 1432
integer taborder = 10
string title = "none"
string dataobject = "dw_fotos"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string ls_foto, ls_filter, ls_path, ls_nomfile
integer li_rtn

		ls_filter = "Achivos de Fotos (*.jpg),*.jpg," +&
					"Archivos de Fotos (*.gif),*.gif," +&
					"Archivos de Fotos (*.pdf),*.pdf," +&
					"Archivos de Fotos(*.bmp),*.bmp"
	
	li_rtn = GetFileOpenName("Asignar Foto ",ls_path,ls_nomfile,"jpg",ls_filter)
	
	if li_rtn = 1 then
		dw_1.SetItem(dw_1.Getrow(),"foto",ls_path)
	end if


end event

