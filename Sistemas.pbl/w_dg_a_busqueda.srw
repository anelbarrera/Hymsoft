//objectcomments Ventana de Busquedas Dinamicas
forward
global type w_dg_a_busqueda from window
end type
type cbx_1 from checkbox within w_dg_a_busqueda
end type
type uo_1 from u_dg_custom_find within w_dg_a_busqueda
end type
end forward

global type w_dg_a_busqueda from window
integer x = 603
integer y = 248
integer width = 2162
integer height = 1272
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = popup!
long backcolor = 79741120
event ue_init pbm_custom01
event ue_syscommand pbm_syscommand
cbx_1 cbx_1
uo_1 uo_1
end type
global w_dg_a_busqueda w_dg_a_busqueda

type variables
str_dg_dynamic_find   istr_df
end variables

forward prototypes
public subroutine wf_asigna_estructura (str_dg_dynamic_find astr_df)
end prototypes

event ue_init;//Se crea el dw, propiedades y recupera
uo_1.uf_carga_str(istr_df)

/*Para que se posicione en la primera linea*/
if istr_df.posicionarse = 'S' then
	uo_1.dw_1.ScrolltoRow(1)
	uo_1.dw_1.Setfocus()	
	uo_1.uf_button_style("", "1")		//Carga la variable is_campo
	if uo_1.dw_1.rowcount() > 0 then
		uo_1.wf_get_text(1)					//Setea el texto del campo a sle_1
	end if
else	
	uo_1.dw_1.SetRow(1)
end if

uo_1.dw_1.SelectRow(0, False)
uo_1.dw_1.SelectRow(1, True)

end event

event ue_syscommand;if commandtype = 61536 then
	w_dg_a_busqueda.hide()
	message.Processed	= true	
	return 1
end if
end event

public subroutine wf_asigna_estructura (str_dg_dynamic_find astr_df);//asigna la estructura a la variable tipo estructura
istr_df = astr_df
//messagebox("Filtro",istr_df.filtrar)

uo_1.sle_1.text = istr_df.filtrar

uo_1.triggerevent("ue_find")

///*Para que se posicione en la primera linea*/
//if istr_df.posicionarse = 'S' then
//	uo_1.dw_1.ScrolltoRow(1)
//	uo_1.dw_1.Setfocus()	
//	uo_1.uf_button_style("", "1")		//Carga la variable is_campo
////	uo_1.wf_get_text(1)					//Setea el texto del campo a sle_1
//else	
//	uo_1.dw_1.SetRow(1)
//end if

uo_1.dw_1.SelectRow(0, False)
uo_1.dw_1.SelectRow(1, True)

end subroutine

on w_dg_a_busqueda.create
this.cbx_1=create cbx_1
this.uo_1=create uo_1
this.Control[]={this.cbx_1,&
this.uo_1}
end on

on w_dg_a_busqueda.destroy
destroy(this.cbx_1)
destroy(this.uo_1)
end on

event open;
gf_center_win(this)

istr_df = Message.PowerObjectParm

If IsNull(istr_df) Or Not IsValid(istr_df) Then
	//	CloseWithReturn(This,"")
	this.hide()
	Return
End If

This.PostEvent("ue_init")

end event

event key;if key = KeyEscape! then
	uo_1.Postevent("ue_cancelar")
end if

end event

event activate;//Para deschequear el recuperar todos
cbx_1.checked = false
end event

type cbx_1 from checkbox within w_dg_a_busqueda
integer x = 974
integer y = 1100
integer width = 517
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Recuperar todos"
borderstyle borderstyle = stylelowered!
end type

event clicked;if cbx_1.checked then
	istr_df.tabla_where = &
   "WHERE ( inmprodu.prod_g_financiero = inmbodeg.mbod_g_financiero ) and "+& 
         "( inmprodu.prod_empresa  = inmbodeg.mbod_empresa ) and "+& 
         "( inmprodu.prod_producto = inmbodeg.mbod_producto ) and "+& 	
         "( inamedid.medi_medida = inmprodu.prod_medida ) and "+& 	
         "( ( inmbodeg.mbod_g_financiero = " + String(str.g_financiero) + " ) AND " +& 
         "( inmbodeg.mbod_empresa = " +String(str.empresa) + " )) And " +&			
         "( inmprodu.prod_status = 1 ) "	
			
	parent.triggerevent("ue_init")
end if
end event

type uo_1 from u_dg_custom_find within w_dg_a_busqueda
event destroy ( )
integer x = 5
integer height = 1144
integer taborder = 10
end type

on uo_1.destroy
call u_dg_custom_find::destroy
end on

event ue_aceptar;call super::ue_aceptar;
//CloseWithReturn(Parent,is_syntax_rtn)

//messagebox("Devuelve",is_syntax_rtn)

str.frame.getactivesheet().Dynamic wf_recupera_producto(is_syntax_rtn)

is_syntax_rtn = ''

//messagebox("aceptar","Oculta")

w_dg_a_busqueda.hide()
//w_dg_a_busqueda.visible = false

//parent.trigger event ue_syscommand(61472,1,1)
//str.frame.setredraw(true)

end event

event ue_cancelar;//CloseWithReturn(Parent,"")
w_dg_a_busqueda.hide()

end event

event ue_change_title;Parent.Title = "Buscar por " + as_column

end event

