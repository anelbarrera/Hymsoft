forward
global type w_a_custom_find from Window
end type
type uo_1 from u_custom_find within w_a_custom_find
end type
end forward

global type w_a_custom_find from Window
int X=832
int Y=360
int Width=2121
int Height=1240
boolean TitleBar=true
long BackColor=79416533
WindowType WindowType=response!
event ue_init pbm_custom01
uo_1 uo_1
end type
global w_a_custom_find w_a_custom_find

type variables
str_dynamic_find   istr_df
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
*	
*	
********************************************************************************************
*					DERECHO DE AUTOR (c) 1998	HARR Computer and SoftWare, S.A.									 
*******************************************************************************************/

uo_1.uf_carga_str(istr_df)

end event

on w_a_custom_find.create
this.uo_1=create uo_1
this.Control[]={this.uo_1}
end on

on w_a_custom_find.destroy
destroy(this.uo_1)
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

gf_center_win(this)

istr_df = Message.PowerObjectParm

If IsNull(istr_df) Or Not IsValid(istr_df) Then
	CloseWithReturn(This,"")
	Return
End If

This.PostEvent("ue_init")

end event

type uo_1 from u_custom_find within w_a_custom_find
int X=0
int Y=0
int TabOrder=1
end type

on uo_1.destroy
call u_custom_find::destroy
end on

event ue_cancelar;call super::ue_cancelar;/*******************************************************************************************
*	System Name:	HARR2000
*								Sistema HARR2000
********************************************************************************************
*	
*	PROPOSITO:
*	 Retornar un string vacio ya que se cancelo la busqueda
*	
*	OBJETO:						TIPO						NOMBRE						EVENTO
*									----						------						------
*								  user_object			  	uo_1							ue_cancelar
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

CloseWithReturn(Parent, "")
end event

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
//messagebox("u_custom_find:uo_1:ue_aceptar", is_syntax_rtn)
CloseWithReturn(Parent, is_syntax_rtn)
end event

event ue_change_title;call super::ue_change_title;Parent.Title = "Buscar por " + as_column
end event

