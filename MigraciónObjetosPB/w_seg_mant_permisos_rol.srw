$PBExportHeader$w_seg_mant_permisos_rol.srw
forward
global type w_seg_mant_permisos_rol from window
end type
type uo_permisos from uo_mant_permisos_rol within w_seg_mant_permisos_rol
end type
end forward

global type w_seg_mant_permisos_rol from window
integer width = 3960
integer height = 2260
boolean titlebar = true
string title = "Roles y Permisos del RibbonBar"
boolean controlmenu = true
boolean resizable = true
windowtype windowtype = response!
long backcolor = 16381425
boolean center = true
uo_permisos uo_permisos
end type
global w_seg_mant_permisos_rol w_seg_mant_permisos_rol

on w_seg_mant_permisos_rol.create
this.uo_permisos=create uo_permisos
this.Control[]={this.uo_permisos}
end on

on w_seg_mant_permisos_rol.destroy
destroy(this.uo_permisos)
end on

event open;// uo_mant_permisos_rol ya ejecuta of_init() en su evento Constructor
uo_permisos.of_redimensionar(This.WorkSpaceWidth(), This.WorkSpaceHeight())
end event

event resize;IF sizetype = 1 THEN RETURN // Minimizada
uo_permisos.of_redimensionar(newwidth, newheight)
end event

event closequery;Integer li_resp

uo_permisos.dw_matriz.AcceptText()

IF uo_permisos.dw_matriz.ModifiedCount() > 0 THEN
	li_resp = MessageBox("Cambios sin guardar", &
		"Hay permisos modificados sin grabar. ¿Desea guardarlos antes de salir?", &
		Question!, YesNoCancel!)

	CHOOSE CASE li_resp
		CASE 1 // Sí: grabar y cerrar
			IF uo_permisos.of_grabar() <> 1 THEN RETURN 1
		CASE 2 // No: cerrar descartando cambios
			RETURN 0
		CASE 3 // Cancelar: permanecer en la ventana
			RETURN 1
	END CHOOSE
END IF

RETURN 0
end event

type uo_permisos from uo_mant_permisos_rol within w_seg_mant_permisos_rol
integer x = 0
integer y = 0
integer taborder = 10
end type

on uo_permisos.destroy
call uo_mant_permisos_rol::destroy
end on