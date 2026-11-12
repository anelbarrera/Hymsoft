//objectcomments Ventana para Mostrar la Vista Preeliminar del Pase a Conta
forward
global type w_fa_rep_preview_pase_conta from w_fa_padre_reportes
end type
end forward

global type w_fa_rep_preview_pase_conta from w_fa_padre_reportes
int Width=3063
int Height=1624
boolean TitleBar=true
string Title="(FA) Informe de Transacciones Por Pasar a Contabilidad"
string MenuName="m_fa_rep"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
end type
global w_fa_rep_preview_pase_conta w_fa_rep_preview_pase_conta

on w_fa_rep_preview_pase_conta.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_fa_rep" then this.MenuID = create m_fa_rep
end on

on w_fa_rep_preview_pase_conta.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_post_open;//Override
string ls_ordenar
//Asignacion del DW de Preview
dw_1.object.data = w_fa_man_pase_a_conta.dw_3.object.data

//Para setear el nombre de la Cia. al DW de impresion.
if dw_1.Describe("nom_empresa.x") <> "?" and dw_1.Describe("nom_empresa.x") <> "!" then
	dw_1.object.nom_empresa.expression = "'"+gf_dg_nombre_empresa() +"'"
end if	

//Seteo Fecha y Hora
time lt_hora
date ldt_fecha
ldt_fecha = date(gf_fecha_serv())
dw_1.object.fech.expression = "'"+string(ldt_fecha)+"'"
lt_hora = time(gf_fecha_serv())
dw_1.object.hora.expression = "'"+string(lt_hora)+"'"

//Setea el Nombre del DW
dw_1.object.st_dw.expression = "'"+dw_1.dataobject+"'"

//Setea la mascara de las cuentas
dw_1.modify("ddia_mg_cuenta.editmask.mask='"+gf_co_mascara_de_cuentas()+"'")

//Setea el Nombre de la Ventana
st_nom_ventana.text = this.Classname()

dw_1.object.datawindow.print.preview = true
dw_1.object.datawindow.print.preview.zoom=100

ls_ordenar = " tdia_fecha_transaccion A ddia_no_pedido A tdia_no_documento A ddia_no_linea A"
dw_1.SetSort(ls_ordenar)
dw_1.Sort()

//dw_impresion = dw_1
end event

event resize;//Override
this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 278
gb_1.width  = this.width  - 63
gb_1.height = this.height - 220


st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180
this.SetRedraw(true)

end event

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_rep_preview_pase_conta
int X=37
int Y=1384
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_rep_preview_pase_conta
int X=41
int Y=44
int Width=2976
int Height=1308
string DataObject="dw_ma_fa_imp_pase_a_conta"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=true
boolean VScrollBar=true
end type

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_rep_preview_pase_conta
int X=27
int Y=0
int Width=3013
int Height=1364
end type

