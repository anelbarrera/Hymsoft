//objectcomments Ventana de Impresión del Informe de Mercancías Agotadas ( No incluye pedidos reservados )
forward
global type w_fa_rep_merc_agotada_imp from w_fa_padre_reportes
end type
end forward

global type w_fa_rep_merc_agotada_imp from w_fa_padre_reportes
integer width = 2976
integer height = 1576
string title = "(FA) Informe de Mercancías Agotadas sin Considerar Pedidos Reservados"
string menuname = "m_hs"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
end type
global w_fa_rep_merc_agotada_imp w_fa_rep_merc_agotada_imp

on w_fa_rep_merc_agotada_imp.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_hs" then this.MenuID = create m_hs
end on

on w_fa_rep_merc_agotada_imp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_post_open;call super::ue_post_open;str_rangofecha lstr_rangfech

lstr_rangfech = message.powerObjectParm

dw.Object.datawindow.print.preview = true
dw.retrieve(str.g_financiero,str.empresa,lstr_rangfech.fecha1,lstr_rangfech.fecha2)
end event

event closequery;call super::closequery;constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)

This.SetRedraw(false)
end event

event close;Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
end event

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_rep_merc_agotada_imp
integer x = 41
integer y = 1344
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_rep_merc_agotada_imp
integer x = 59
integer width = 2830
integer height = 1244
string dataobject = "dw_fa_rep_merc_agotada"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_rep_merc_agotada_imp
integer x = 46
integer y = 16
integer width = 2862
integer height = 1300
end type

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_rep_merc_agotada_imp
end type

