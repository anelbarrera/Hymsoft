forward
global type w_na_rep_lote_caja_menuda from w_na_padre_reportes
end type
end forward

global type w_na_rep_lote_caja_menuda from w_na_padre_reportes
string title = "Reporte de Comprobantes"
string menuname = "m_fa_rep"
long backcolor = 12639424
end type
global w_na_rep_lote_caja_menuda w_na_rep_lote_caja_menuda

type variables
string is_estado
end variables

on w_na_rep_lote_caja_menuda.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_fa_rep" then this.MenuID = create m_fa_rep
end on

on w_na_rep_lote_caja_menuda.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_post_open;call super::ue_post_open;str_dg_general str_parametro
string ls_masca
datawindowchild ldwc_barco
str_parametro = Message.PowerObjectParm

is_estado 	  = str_parametro.variable2	//Asigna el Estado, para que en el printpreview filtre por el estado

choose case str.empresa
	case	1		//Gateway
			dw_1.dataobject = 'dw_na_desem_imp'
	case	2	//Servicios Transcanaleros
			dw_1.dataobject = 'dw_na_desem_imp'		
	case	3		//Shipsagent
			dw_1.dataobject = 'dw_na_desem_imp'
	case	4		//Wilford
			dw_1.dataobject = 'dw_na_desem_imp'
	case	5		//C. Fernie
			dw_1.dataobject = 'dw_na_desem_imp'
	case	6		//Costamare
			dw_1.dataobject = 'dw_na_desem_imp_costamare'
	case else	
			dw_1.dataobject = 'dw_na_desem_imp'
end choose

dw_1.settransobject(sqlca)


dw_1.getchild('desem_transito_1',ldwc_barco)
ldwc_barco.settransobject(sqlca);
if ldwc_barco.retrieve(str.g_financiero, str.empresa) = 0 then
	ldwc_barco.insertrow(1)
end if

ls_masca = gf_co_mascara_de_cuentas()
dw_1.MODIFY("desem_cuenta_mg.editmask.mask='"+ls_masca+"'")

dw_1.retrieve(str.g_financiero,str.empresa,str_parametro.variable1, str_parametro.numero1, str_parametro.numero2)

dw_1.setsort('desem_desembolso ASC')
dw_1.sort()

dw_1.object.datawindow.print.preview="yes"

end event

type st_ayuda from w_na_padre_reportes`st_ayuda within w_na_rep_lote_caja_menuda
end type

type st_nom_ventana from w_na_padre_reportes`st_nom_ventana within w_na_rep_lote_caja_menuda
end type

type dw_1 from w_na_padre_reportes`dw_1 within w_na_rep_lote_caja_menuda
integer x = 55
string dataobject = "dw_na_lote_desem_imp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_syntax

ls_syntax = sqlsyntax

if is_estado = 'S' then
	ls_syntax = ls_syntax + " and ( ntdesem.desem_status = 'S' ) "
end if

dw_1.setsqlpreview(ls_syntax)
end event

type gb_1 from w_na_padre_reportes`gb_1 within w_na_rep_lote_caja_menuda
long backcolor = 12639424
end type

