//objectcomments Ventana Ancestro donde se heredan todas las ventanas
forward
global type w_a from Window
end type
type st_msghlp from statictext within w_a
end type
type st_window_name from statictext within w_a
end type
end forward

global type w_a from Window
int X=832
int Y=360
int Width=1998
int Height=1208
boolean TitleBar=true
string Title="Untitled"
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_syscommand pbm_syscommand
event ue_micro pbm_nchittest
event ue_close pbm_custom01
event ue_printsetup pbm_custom02
event ue_init pbm_custom03
event ue_buscar pbm_custom04
event ue_salvar pbm_custom05
event ue_editar pbm_custom06
event ue_insertar pbm_custom07
event ue_borrar pbm_custom08
event ue_encontrar pbm_custom09
event ue_w_controls pbm_custom10
event ue_mas pbm_custom11
event ue_aceptar pbm_custom12
event ue_about pbm_custom13
event ue_pertenece pbm_custom14
event ue_print pbm_custom15
event ue_primer_reg ( )
event ue_reg_anterior ( )
event ue_siguiente_reg ( )
event ue_ultimo_reg ( )
st_msghlp st_msghlp
st_window_name st_window_name
end type
global w_a w_a

type prototypes
Subroutine DrawMenuBar(uint a_WindowHandle) Library "user32"
Function Boolean AppendMenuA(long a_MenuHandle, uint Flags, uint NewItemID, &
                 string NewItem) Library "user32" alias for "AppendMenuA;Ansi"
Function Boolean InsertMenuA(long a_hmenu, uint uItemm, uint fuflags, &
                 uint idNewItem, string lpszNewItem) Library "user32" alias for "InsertMenuA;Ansi"
Function Uint GetMenuStringA(long a_MenuHandle, uint MenuItemID, &
                  ref string MenuString, int MaxStringLenght, uint Flags) Library "user32" alias for "GetMenuStringA;Ansi"
Function Long GetSystemMenu(long a_hwnd, boolean fRevert) Library "user32"
end prototypes

type variables
PROTECTED:
Boolean i_b_max = true, i_b_min = true, &
              i_b_restore = true, i_b_close_x = true, &
              ib_acerca = true
String     is_nombre
Integer   ii_helpon


end variables

forward prototypes
private function string wf_win_style ()
public subroutine wf_respond ()
public subroutine wf_display_help (string as_msg, long al_width, long al_hight)
end prototypes

event ue_syscommand;/*******************************************************************************************
*	System Name:	SEGURIDAD
*								Sistema de Seguridad
********************************************************************************************
*	
*	PROPOSITO:
*	 Para tener la oportunidad de heredar y poder escoger que facilidades se le darian o no 
*	 al usuario sobre la ventana, capturando el 'wordparm de windows'
*	
*	OBJETO:						TIPO						NOMBRE						EVENTO
*									----						------						------
*								  Ventana					 w_a						ue_syscommand
*	
*	PARAMETROS:				 RECIBIDOS					ENVIADO
*								 ---------					-------
*								  Ninguno					Ninguno
*	
*	AUTOR:				Herick Guillén
*	------
*	DÍA DE CREACIÓN:	07 de Setpiembre de 1998
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
*					DERECHO DE AUTOR (c) 1998	HARR. , S.A.									 
*******************************************************************************************/


This.TriggerEvent("ue_w_controls")

If commandtype = 1319 Then This.TriggerEvent("ue_about")

CHOOSE CASE commandtype
	Case 61824
		ii_helpon++
	CASE 61472					// Minimized
		IF Not i_b_min  THEN Return(1)
	CASE 61728					// Restore
		IF Not i_b_restore THEN Return(1)
	CASE 61488					// Maximized
		IF Not i_b_max THEN Return(1)
	CASE 61536					// Close System Menu or [X]
		IF Not i_b_close_x THEN Return(1)
		This.TriggerEvent("ue_close")
		Message.Processed = True		
END CHOOSE
end event

event ue_micro;//If IsValid(w_frame) and Not gb_micro_mensaje Then	w_frame.SetMicroHelp("Listo")
end event

event ue_close;gf_win_used_by_user(is_nombre, false)


end event

event ue_printsetup;PrintSetup ()
end event

event ue_init;is_nombre = This.ClassName()

st_window_name.text = is_nombre
st_window_name.width = len(st_window_name.text) * 35

gf_win_used_by_user(is_nombre, true)
end event

event ue_about;open(w_acerca_de)
end event

private function string wf_win_style ();/*******************************************************************************************
*	System Name:	
*
********************************************************************************************
*	
*	PROPOSITO:
*	 Para saber en que estado se encuentra la ventana {Minimized, Maximized or Restore} 
*	 Solo para Descendientes. ¿Cómo llamar a esta función desde el 'descendiente'?
*	 Ejemplo:		$var = Super::wf_win_style()
*	
*	OBJETO:						TIPO						NOMBRE						EVENTO
*									----						------						------
*						  Función de Ventana				wf_win_style				xxxxxxxxxxxxx
*	
*	PARAMETROS:				 RECIBIDOS					ENVIADO
*								 ---------					-------
*								  Ninguno					String
*	
*	AUTOR:				Herick Guillén
*	------
*	DÍA DE CREACIÓN:	30 de Octuble de 1997
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
*					DERECHO DE AUTOR (c) 1998	HARR. , S.A.									 
*******************************************************************************************/




WindowState lws_stado


lws_stado = This.WindowState

IF lws_stado = Maximized! THEN
	Return("Maximized")
ELSEIF lws_stado = Minimized! THEN
	Return("Minimized")
ELSE
	Return("Normal")
END IF

end function

public subroutine wf_respond ();uo_respond	uo_res

uo_res = create uo_respond

uo_res.uf_help(handle(this))

destroy uo_res

end subroutine

public subroutine wf_display_help (string as_msg, long al_width, long al_hight);Long	ll_px, ll_py, ll_this_width, ll_this_height


ll_this_width  = this.width
ll_this_height = This.height
ll_px = this.PointerX() + 20 + al_width
ll_py = this.PointerY() + 70 + al_hight

If ll_px >= ll_this_width Then
	ll_px = ll_this_width - (al_width + 50)
Else
	ll_px = this.PointerX() + 20
End If
	
If ll_py >= ll_this_height Then
	ll_py = ll_this_height - (al_hight + 50)
Else
	ll_py = this.PointerY() + 70
End If

st_msghlp.text = as_msg

st_msghlp.width = al_width
st_msghlp.height = al_hight

st_msghlp.x = ll_px
st_msghlp.y = ll_py
st_msghlp.BringToTop = True
st_msghlp.show()
end subroutine

on w_a.create
this.st_msghlp=create st_msghlp
this.st_window_name=create st_window_name
this.Control[]={this.st_msghlp,&
this.st_window_name}
end on

on w_a.destroy
destroy(this.st_msghlp)
destroy(this.st_window_name)
end on

event open;/*******************************************************************************************
*	System Name:	SEGURIDAD
*								Sistema de Seguridad
********************************************************************************************
*	
*	PROPOSITO:
*	 Darle tiempo a la ventana para que pueda abrirse bien, osea cuando los objetos que se 
*	 encuentran en la ventana se puedan terminar de dibujar y esto no dara la impresion
*	 que la ventana se abrio lentamente o que el sistema esta pesado
*	
*	OBJETO:						TIPO						NOMBRE						EVENTO
*									----						------						------
*								  Ventana					 w_a							 open
*	
*	PARAMETROS:				 RECIBIDOS					ENVIADO
*								 ---------					-------
*								  Ninguno					Ninguno
*	
*	AUTOR:				Herick Guillén
*	------
*	DÍA DE CREACIÓN:	07 de Septiembre de 1998
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
*					DERECHO DE AUTOR (c) 1998	HARR. , S.A.									 
*******************************************************************************************/
sqlca.autocommit=true
gf_acelerador()

Long	ll_sysmenu


If Not ib_acerca then Return

ll_sysmenu = GetSystemMenu(Handle(this), False)

InsertMenuA(ll_sysmenu, 1, 0, 1319, "Acerca de...")

DrawMenuBar(handle(this))

ib_acerca = false

st_window_name.BackColor = this.BackColor

This.PostEvent("ue_init")
end event

event close;close(this)
end event

event resize;st_window_name.y = newheight - 80 
end event

type st_msghlp from statictext within w_a
int X=654
int Y=176
int Width=137
int Height=76
boolean Visible=false
boolean Enabled=false
boolean Border=true
boolean FocusRectangle=false
long BackColor=15793151
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_window_name from statictext within w_a
int X=105
int Y=904
int Width=146
int Height=76
boolean Enabled=false
string Text="none"
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

