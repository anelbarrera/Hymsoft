//objectcomments Ventana Padre del sistema de Facturación
forward
global type w_fa_frame from w_grampa_frame
end type
end forward

global type w_fa_frame from w_grampa_frame
integer width = 5769
integer height = 3316
string title = "Sistema Integrado"
string menuname = "m_fa_padre"
boolean tabbedview = true
boolean maximizealltabbedsheets = true
string is_ddeappl = "DDE_HYMSOFT"
end type
global w_fa_frame w_fa_frame

type variables
string is_mensaje

end variables

forward prototypes
public subroutine wf_fondo ()
end prototypes

public subroutine wf_fondo ();//Long ll_x,ll_y,ll_ox,ll_oy,ll_cox,ll_coy
//String ls_foto
//
////-----------Logo dchain para planilla
//
//// Para X
//ll_x = This.width/2
//ll_ox = ole_1.width/2
//ll_cox = ll_x - ll_ox
//
//// Para Y
//
//
//ll_y = This.Height/2
//ll_oy = ole_1.Height/2
//ll_coy = ll_y - ll_oy
//
//ole_1.x = ll_cox
//ole_1.y = ll_coy
//ole_1.visible = true
////--------- hasta aqui
//
//ll_ox = sle_1.width/2
//ll_cox = ll_x - ll_ox
//ll_oy = sle_1.Height/2
//ll_coy = ll_y - ll_oy
//
//sle_1.x = ll_cox
//sle_1.y = ll_coy + 600
//
//
//
end subroutine

on w_fa_frame.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_fa_padre" then this.MenuID = create m_fa_padre
end on

on w_fa_frame.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_post_open;call super::ue_post_open;//

//wf_fondo()
OpenSheet(w_fa_fondo,str.frame,1,Layered!)


end event

event timer;
//if ii_cont < 90 then
// is_mensaje=	Mid (is_mensaje, ii_cont)
// this.SetMicroHelp (is_mensaje)

//ii_cont = ii_cont +1
//end if
//if ii_cont >=90 then
//timer(0)

//end if
	
	

end event

event close;call super::close;disconnect;
halt close
end event

event resize;call super::resize;//gb_1.height = newheight - 200
//gb_1.width  = newwidth - 100
//gb_1.x = 50
//gb_1.y = 100
//
//sle_2.width = newwidth - 190
end event

