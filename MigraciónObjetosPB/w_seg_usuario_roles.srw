$PBExportHeader$w_seg_usuario_roles.srw
forward
global type w_seg_usuario_roles from window
end type
type cb_admin_roles from commandbutton within w_seg_usuario_roles
end type
type cb_cerrar from commandbutton within w_seg_usuario_roles
end type
type cb_grabar from commandbutton within w_seg_usuario_roles
end type
type uo_roles from uo_seg_usuario_roles within w_seg_usuario_roles
end type
end forward

global type w_seg_usuario_roles from window
integer width = 2380
integer height = 1780
boolean titlebar = true
string title = "Asignación de Roles al Usuario"
boolean controlmenu = true
boolean resizable = true
windowtype windowtype = response!
long backcolor = 16381425
boolean center = true
cb_admin_roles cb_admin_roles
cb_cerrar cb_cerrar
cb_grabar cb_grabar
uo_roles uo_roles
end type
global w_seg_usuario_roles w_seg_usuario_roles

type variables
Protected:
String is_id_usuario = ""
String is_nombre_usuario = ""
end variables

forward prototypes
public subroutine of_layout (integer ai_width, integer ai_height)
end prototypes

public subroutine of_layout (integer ai_width, integer ai_height);Integer li_bar_h, li_btn_y

li_bar_h = 144
uo_roles.of_redimensionar(ai_width, Max(400, ai_height - li_bar_h))

li_btn_y = ai_height - 116

cb_admin_roles.X = 32
cb_admin_roles.Y = li_btn_y

cb_cerrar.X = ai_width - cb_cerrar.Width - 32
cb_cerrar.Y = li_btn_y

cb_grabar.X = cb_cerrar.X - cb_grabar.Width - 20
cb_grabar.Y = li_btn_y
end subroutine

on w_seg_usuario_roles.create
this.cb_admin_roles=create cb_admin_roles
this.cb_cerrar=create cb_cerrar
this.cb_grabar=create cb_grabar
this.uo_roles=create uo_roles
this.Control[]={this.cb_admin_roles,&
this.cb_cerrar,&
this.cb_grabar,&
this.uo_roles}
end on

on w_seg_usuario_roles.destroy
destroy(this.cb_admin_roles)
destroy(this.cb_cerrar)
destroy(this.cb_grabar)
destroy(this.uo_roles)
end on

event open;String ls_parm
Long   ll_pos

ls_parm = Trim(Message.StringParm)
ll_pos  = Pos(ls_parm, "|")

IF ll_pos > 0 THEN
	is_id_usuario     = Trim(Left(ls_parm, ll_pos - 1))
	is_nombre_usuario = Trim(Mid(ls_parm, ll_pos + 1))
ELSE
	is_id_usuario     = ls_parm
	is_nombre_usuario = ""
END IF

IF is_id_usuario = "" THEN
	MessageBox("Validación", "Debe seleccionar un usuario válido antes de asignar roles.", Exclamation!)
	Close(This)
	RETURN
END IF

This.Title = "Roles del Usuario - " + is_id_usuario
uo_roles.of_cargar(is_id_usuario, is_nombre_usuario)
of_layout(This.WorkSpaceWidth(), This.WorkSpaceHeight())
end event

event resize;IF sizetype = 1 THEN RETURN // Minimizada
of_layout(newwidth, newheight)
end event

event closequery;Integer li_resp

IF uo_roles.of_hay_cambios() THEN
	li_resp = MessageBox("Cambios sin guardar", &
		"Hay cambios pendientes en los roles de este usuario. ¿Desea guardarlos antes de salir?", &
		Question!, YesNoCancel!)

	CHOOSE CASE li_resp
		CASE 1 // Sí: grabar y salir
			IF uo_roles.of_grabar(is_id_usuario) <> 1 THEN RETURN 1
		CASE 2 // No: descartar cambios
			RETURN 0
		CASE 3 // Cancelar: permanecer en la ventana
			RETURN 1
	END CHOOSE
END IF

RETURN 0
end event

type cb_admin_roles from commandbutton within w_seg_usuario_roles
integer x = 32
integer y = 1528
integer width = 760
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 600
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Administrar Roles y Permisos..."
end type

event clicked;IF uo_roles.of_hay_cambios() THEN
	IF MessageBox("Cambios pendientes", &
		"Tiene cambios sin grabar en los roles de este usuario. ¿Desea guardarlos antes de administrar roles?", &
		Question!, YesNo!) = 1 THEN
		IF uo_roles.of_grabar(is_id_usuario) <> 1 THEN RETURN
	END IF
END IF

Open(w_seg_mant_permisos_rol)
uo_roles.of_cargar(is_id_usuario, is_nombre_usuario)
end event

type cb_cerrar from commandbutton within w_seg_usuario_roles
integer x = 2004
integer y = 1528
integer width = 320
integer height = 92
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cerrar"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, 0)
end event

type cb_grabar from commandbutton within w_seg_usuario_roles
integer x = 1664
integer y = 1528
integer width = 320
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Grabar"
boolean default = true
end type

event clicked;IF uo_roles.of_grabar(is_id_usuario) = 1 THEN
	MessageBox("Seguridad", "Roles del usuario actualizados correctamente.", Information!)
	CloseWithReturn(Parent, 1)
END IF
end event

type uo_roles from uo_seg_usuario_roles within w_seg_usuario_roles
integer x = 0
integer y = 0
integer taborder = 10
end type

on uo_roles.destroy
call uo_seg_usuario_roles::destroy
end on