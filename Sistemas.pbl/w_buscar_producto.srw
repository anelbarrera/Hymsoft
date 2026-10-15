//objectcomments Ventana de Busquedas Dinamicas
forward
global type w_buscar_producto from window
end type
type uo_1 from u_buscar_producto within w_buscar_producto
end type
type cb_max from commandbutton within w_buscar_producto
end type
end forward

global type w_buscar_producto from window
integer x = 832
integer y = 360
integer width = 4389
integer height = 2068
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12639424
string icon = "AppIcon!"
event ue_init pbm_custom01
uo_1 uo_1
cb_max cb_max
end type
global w_buscar_producto w_buscar_producto

type variables
str_dg_dynamic_find   istr_df
long il_ancho, il_alto
end variables

event ue_init;/*******************************************************************************************
*	System Name:	HARR2000
*								Sistema HARR2000
********************************************************************************************
*	
*	PROPOSITO:
*	 Inicializar el objeto visual de búsqueda
*	
*	OBJETO:						TIPO						NOMBRE						EVENTO
*									----						------						------
*								  Ventana			  	w_a_custom_find				ue_init
*	
*	PARAMETROS:				 RECIBIDOS									ENVIADO
*								 ---------									-------
*							 	 xxxxxxxx									xxxxxxxx
*
*	FUNCIONES UTILIZADAS:		NOMBRE					ARGUMENTO			RETORNO		PASADA POR
*										------					---------			-------		----------
*										uf_carga_str			istr_df			 	xxxxxx			  R
*
*	
*	AUTOR:				Jair & Herick
*	------
*	DÍA DE CREACIÓN:	05 de Marzo de 1999
*	----------------
********************************************************************************************
*	Modificaciones:	
*	---------------
*	
*	
*	Fecha de la Modificación		Modificado por el Programador			Referencia
*	------------------------		-----------------------------			----------
*			11/1/2000							Renaul Medina
*	
********************************************************************************************
*					DERECHO DE AUTOR (c) 1998	HARR Computer and SoftWare, S.A.									 
*******************************************************************************************/

uo_1.uf_carga_str(istr_df)

/*Para que se posicione en la primera linea*/
if istr_df.posicionarse = 'S' then
	uo_1.dw_1.ScrolltoRow(1)
	uo_1.dw_1.Setfocus()	
	uo_1.uf_button_style("", "1")		//Carga la variable is_campo
	uo_1.wf_get_text(1)					//Setea el texto del campo a sle_1
else	
	uo_1.dw_1.SetRow(1)
end if

uo_1.dw_1.SelectRow(0, False)
uo_1.dw_1.SelectRow(1, True)

uo_1.dw_1.setfilter('prod_existencia_total > 0')
uo_1.dw_1.filter()

end event

on w_buscar_producto.create
this.uo_1=create uo_1
this.cb_max=create cb_max
this.Control[]={this.uo_1,&
this.cb_max}
end on

on w_buscar_producto.destroy
destroy(this.uo_1)
destroy(this.cb_max)
end on

event open;/*******************************************************************************************
*	System Name:	HARR2000
*								Sistema HARR2000
********************************************************************************************
*	
*	PROPOSITO:
*	 Recibir la estructura que se manda como parametro y validar que se encuentre
*	 correctamente con los datos necesarios
*	
*	OBJETO:						TIPO						NOMBRE						EVENTO
*									----						------						------
*								  Ventana			  	w_a_custom_find				open
*	
*	PARAMETROS:				 RECIBIDOS									ENVIADO
*								 ---------									-------
*							 	  istr_df									xxxxxxxx
*
*	FUNCIONES UTILIZADAS:		NOMBRE					ARGUMENTO			RETORNO		PASADA POR
*										------					---------			-------		----------
*										gf_center_win			ventana			 	xxxxxx			  V
*
*	
*	AUTOR:				Jair & Herick
*	------
*	DÍA DE CREACIÓN:	05 de Marzo de 1999
*	----------------
********************************************************************************************
*	Modificaciones:
*	---------------
*	
*	
*	Fecha de la Modificación		Modificado por el Programador			Referencia
*	------------------------		-----------------------------			----------
*	
*	
********************************************************************************************
*					DERECHO DE AUTOR (c) 1998	HARR Computer and SoftWare, S.A.									 
*******************************************************************************************/
il_alto = this.height
il_ancho = this.width

gf_center_win(this)

istr_df = Message.PowerObjectParm

If IsNull(istr_df) Or Not IsValid(istr_df) Then
	CloseWithReturn(This,"")
	Return
End If

This.PostEvent("ue_init")

end event

event key;if key = KeyEscape! then
	uo_1.Postevent("ue_cancelar")
end if
if keydown(keyControl!) and keydown(keyM!)  then
//	cb_max.triggerevent(Clicked!)
end if


end event

event resize;uo_1.Width = newwidth - 10  
uo_1.Height  = newHeight -20
uo_1.dw_2.y = uo_1.Height - 210
uo_1.dw_3.x = uo_1.width - 625
uo_1.dw_3.y = uo_1.sle_1.y

uo_1.dw_1.Height = uo_1.Height - 375
uo_1.dw_1.width = uo_1.width - 700
uo_1.dw_1.x = 37 
uo_1.dw_1.y = 144

uo_1.dw_2.x = ((uo_1.width - 700 - uo_1.dw_2.width) / 2) 
cb_max.y  = newHeight - 120
cb_max.x  = newWidth - 385


uo_1.sle_1.setfocus()
end event

type uo_1 from u_buscar_producto within w_buscar_producto
integer y = 32
integer taborder = 10
end type

on uo_1.destroy
call u_buscar_producto::destroy
end on

event ue_aceptar;call super::ue_aceptar;/*******************************************************************************************
*	System Name:	HARR2000
*								Sistema HARR2000
********************************************************************************************
*	
*	PROPOSITO:
*	 Retornar la syntax que se debe utilizar con la función Find de DW's
*	
*	OBJETO:						TIPO						NOMBRE						EVENTO
*									----						------						------
*								  user_object			  	uo_1							ue_aceptar
*	
*	PARAMETROS:				 RECIBIDOS									ENVIADO
*								 ---------									-------
*							 	 wparam										xxxxxxxx
*								 lparam										xxxxxxxx
*
*	FUNCIONES UTILIZADAS:		NOMBRE					ARGUMENTO			RETORNO		PASADA POR
*										------					---------			-------		----------
*										xxxxxxxx					xxxxxxxx			 	xxxxxx			  X
*
*	
*	AUTOR:				Herick & Jair
*	------
*	DÍA DE CREACIÓN:	05 de Marzo de 1999
*	----------------
********************************************************************************************
*	Modificaciones:
*	---------------
*	
*	
*	Fecha de la Modificación		Modificado por el Programador			Referencia
*	------------------------		-----------------------------			----------
*	
*	
********************************************************************************************
*					DERECHO DE AUTOR (c) 1998	HARR Computer and SoftWare, S.A.									 
*******************************************************************************************/

CloseWithReturn(Parent,is_syntax_rtn)

end event

event ue_cancelar;call super::ue_cancelar;CloseWithReturn(Parent,"")

end event

event ue_change_title;call super::ue_change_title;Parent.Title = "Buscar por " + as_column

end event

event destructor;call super::destructor;call u_buscar_producto::destructor
end event

type cb_max from commandbutton within w_buscar_producto
boolean visible = false
integer x = 1655
integer y = 1172
integer width = 325
integer height = 108
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Maximizar"
end type

event clicked;
if	this.text = 'Maximizar' then 
	parent.setredraw(false)	
	parent.x =  30
	parent.y  = 30
	parent.Height =  str.frame.height - 150
	parent.Width  = str.frame.width - 100
	this.text = 'Minimizar'
	uo_1.dw_1.TitleBar = TRUE
	uo_1.dw_1.MaxBox = TRUE
	parent.setredraw(true)		
else  	
	parent.Height =   il_alto 
	parent.Width  = il_ancho 
	this.text = 'Maximizar'
	uo_1.dw_1.TitleBar = false
	uo_1.dw_1.MaxBox = false
	gf_center_win(parent)		
End if 


end event

