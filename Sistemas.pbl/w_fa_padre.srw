//objectcomments Padre en la Herencia del Sistema de Facturacion
forward
global type w_fa_padre from w_granpa
end type
type st_ayuda from statictext within w_fa_padre
end type
end forward

global type w_fa_padre from w_granpa
boolean visible = false
long backcolor = 79416533
event ue_zoom_down ( )
event ue_borrar ( )
event ue_save_as ( )
event ue_inicializar ( )
st_ayuda st_ayuda
end type
global w_fa_padre w_fa_padre

type variables
Datawindow dw_impresion
Boolean ib_modify
String  is_ultima_, is_orden_

boolean ib_aceptar
n_cst_winsrv_shell32	nv_f
end variables

forward prototypes
public subroutine wf_valida_menu ()
end prototypes

event ue_save_as();integer li_respuesta
string ls_path
//ls_title = this.title

li_respuesta = gf_mensaje('','Yes = Salvar a Excel, No = Otro Formato o Cancelar',4,1,'Q')
choose case li_respuesta
	case 1
		ls_path = nv_f.of_browseforfolder("Guardar Excel en ..",true)
		If Len(Trim(ls_path)) > 0 then		
			uf_save_dw_as_excel(dw,ls_path+'\'+this.title+'.xls')
		End If
	case 2
		dw.saveas()
end choose

end event

public subroutine wf_valida_menu ();If not IsValid(m_fa_principal) Then
	ChangeMenu(m_fa_principal)
End If
end subroutine

on w_fa_padre.create
int iCurrent
call super::create
this.st_ayuda=create st_ayuda
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_ayuda
end on

event open;call super::open;
This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)

//Configurar los Accesos

//mf_accesos(this.menuid, this)

str.frame.SetRedraw ( True )
//constant int GWL_STYLE = -16
//constant ulong WS_CLIPCHILDREN = 33554432 // 0x02000000
//ulong lul_style

//// Obtiene los estilos actuales y agrega WS_CLIPCHILDREN
//lul_style = GetWindowLongW(Handle(this), GWL_STYLE)
//if not (Mod(Int(lul_style / WS_CLIPCHILDREN), 2) = 1) then
//    SetWindowLongW(Handle(this), GWL_STYLE, lul_style + WS_CLIPCHILDREN)
//end if
 

// 4. Descongelar y hacer visible de un solo golpe
this.SetRedraw(True)
 
end event

on w_fa_padre.destroy
call super::destroy
destroy(this.st_ayuda)
end on

event ue_post_open;call super::ue_post_open;if isvalid(m_fa_principal) then
  m_fa_principal.m_ventanas.m_regla.toolbaritemvisible=false
  gf_fa_pro_servi()  //Verifica si hay facturacion de Servicios y habilita o deshabilita opciones
end if 	

end event

event key;if Key = KeyEscape! then
	this.Postevent("close")
end if
end event

event close;// Oculta la ventana instantáneamente (0 ms) antes de que Windows comience
// a destruir los controles hijos uno a uno en pantalla.
this.Hide()
this.SetRedraw(False)
<<<<<<< HEAD
=======

>>>>>>> feature/Inventario
end event

event ue_aceptar;call super::ue_aceptar;//override
long ll_update
window lw_ventana
string ls_titulo

//lw_ventana = this.getactivesheet()
//ls_titulo = lw_ventana.title

ll_update=dw.update()

if ll_update = 1  then
	commit using sqlca;
//	gf_mensaje("Atención","¡Actualización Exitosa !",1,1,'E')
else
	rollback using sqlca;
	gf_mensaje("Atención","¡Error al Actualizar ! " + sqlca.sqlerrtext,1,1,'E')
end if



end event

event ue_pre_aceptar;call super::ue_pre_aceptar;sqlca.autocommit = true
end event

event resize;call super::resize;dw_1.Resize(This.Width - 170, This.Height - 330)
//gb_1.width  = this.width  - 63
//gb_1.height = this.height - 220
st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180
end event

<<<<<<< HEAD
=======
event closequery;call super::closequery;constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)
end event

>>>>>>> feature/Inventario
type st_nom_ventana from w_granpa`st_nom_ventana within w_fa_padre
long backcolor = 79416533
end type

type dw_1 from w_granpa`dw_1 within w_fa_padre
event ue_escape pbm_dwescape
event ue_tabfinal pbm_dwntabout
event ue_microayuda pbm_nchittest
end type

event dw_1::ue_escape;parent.Postevent("close")
end event

event dw_1::ue_tabfinal;call super::ue_tabfinal;parent.triggerevent("ue_adicionar")
end event

event dw_1::ue_microayuda;/*
	Evento que muestra una pequeña Ayuda dependiendo en que columna se encuentre el mouse
*/

Integer li_pos, li_x, li_y
String ls_objeto, ls_col

ls_objeto = This.GetObjectAtPointer()
li_pos = pos  (ls_objeto,"~t")
ls_col = left (ls_objeto, li_pos - 1)


li_x	 = str.frame.GetActiveSheet ().PointerX () -80 //- 900
li_y	 = str.frame.GetActiveSheet ().PointerY () - 80 //- 200

//messagebox("Apunta a :",ls_col)

// Dependiendo de la Columna el Mensaje de Ayuda varía
CHOOSE CASE right(ls_col,2)
	CASE '_t'
//		messagebox("!","Invisible")
		If st_ayuda.Visible Then Return
		//st_ayuda.Move (li_x, li_y)
		st_ayuda.Move (0, 0)
		st_ayuda.Text 	= "Haga click para ordenar por la Columna de " + this.describe(ls_col+".text")
		st_ayuda.Width 	= Len (st_ayuda.Text) * 28
		st_ayuda.Visible = TRUE	
	CASE ELSE
	st_ayuda.Visible = FALSE
END CHOOSE
end event

event dw_1::rbuttondown;call super::rbuttondown;m_fa_principal.M_edicin.PopMenu(parent.PointerX( ), parent.PointerY( ))
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;gf_micro_ayuda(this)
end event

event dw_1::clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto
integer li_pos 

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if right(ls_objeto,2)='_t' then

	ls_objeto = left(ls_objeto,len(ls_objeto)-2)
	
	if ls_objeto = is_ultima_ or is_ultima_ = "" then	//Si es la misma columna 
																	// o si es la primera vez
		if is_orden_  = "" or is_orden_ = "D" then
			is_orden_ = 'A'		
			this.SetSort(ls_objeto+" A")	//Ordena Ascendente
			this.sort()		
		else
			is_orden_ = 'D'					
			this.SetSort(ls_objeto+" D")	//Ordena Descendente
			this.sort()				
		end if	
		is_ultima_ = ls_objeto		
	else				
			is_orden_ = 'A'
			this.SetSort(ls_objeto+" A")
			this.sort()
			is_ultima_ = ls_objeto
	end if

end if


end event

type st_ayuda from statictext within w_fa_padre
boolean visible = false
integer x = 462
integer y = 412
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15793151
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

