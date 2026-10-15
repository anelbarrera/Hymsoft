//objectcomments Búsqueda Dinámica
forward
global type w_dg_a_custom_find2 from w_dg_a_custom_find
end type
type st_1 from statictext within w_dg_a_custom_find2
end type
type st_3 from statictext within w_dg_a_custom_find2
end type
type st_2 from statictext within w_dg_a_custom_find2
end type
end forward

global type w_dg_a_custom_find2 from w_dg_a_custom_find
int Width=2135
int Height=1504
long BackColor=79739096
boolean ControlMenu=true
st_1 st_1
st_3 st_3
st_2 st_2
end type
global w_dg_a_custom_find2 w_dg_a_custom_find2

type variables
String		is_param
Integer		ii_control
end variables

on w_dg_a_custom_find2.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_3=create st_3
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.st_2
end on

on w_dg_a_custom_find2.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_2)
end on

event open;// Override

/*******************************************************************************************
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
*								  Ventana			  	w_dg_a_custom_find				open
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

str_dg_fa_dynamic_find		lstr_df

gf_center_win(this)

lstr_df = Message.PowerObjectParm
istr_df = lstr_df.str_df

If IsNull(istr_df) Or Not IsValid(istr_df) Then
	CloseWithReturn(This, "")
	Return
End If

If IsNull (lstr_df.param) Then
	is_param = ''
Else
	is_param = lstr_df.param
End If 
This.PostEvent("ue_init")

// Configurando la ventana según los Parámetros
Title 		= lstr_df.titulo
st_2.Text	= lstr_df.Texto
end event

event ue_init;call super::ue_init;If is_param = 'TER' Then
	
End If

//Title = 
end event

event closequery;String	ls_null

// Si no cierra por ACEPTAR o CANCELAR
// Sólo cuando el Parámetro de Apertura es 'TER'
If ii_control <> 1 And is_param = 'TER' Then
	SetNull (ls_null)
	Message.StringParm = ls_null
End If
end event

type uo_1 from w_dg_a_custom_find`uo_1 within w_dg_a_custom_find2
event ue_nuevo ( )
int Y=244
int Height=1168
end type

event uo_1::ue_nuevo;//MessageBox ('Nuevo uo','Creando nuevo.....')
end event

event uo_1::ue_cancelar;// Override
ii_control = 1
call super::ue_cancelar
end event

event uo_1::ue_aceptar;// Override
ii_control = 1
call super::ue_aceptar
end event

event uo_1::ue_change_title;//
end event

type st_1 from statictext within w_dg_a_custom_find2
int X=581
int Y=1236
int Width=329
int Height=60
boolean Enabled=false
boolean BringToTop=true
string Text="Nuevo"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_dg_a_custom_find2
int X=37
int Y=28
int Width=2048
int Height=224
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_dg_a_custom_find2
int X=73
int Y=48
int Width=1975
int Height=188
boolean Enabled=false
boolean BringToTop=true
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

