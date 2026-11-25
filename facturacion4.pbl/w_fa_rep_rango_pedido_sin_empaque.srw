//objectcomments  
forward
global type w_fa_rep_rango_pedido_sin_empaque from w_fa_rep_rango_fecha
end type
end forward

global type w_fa_rep_rango_pedido_sin_empaque from w_fa_rep_rango_fecha
integer width = 1710
integer height = 768
string title = "(FA) Reporte de Pedidos Sin Empaque"
string menuname = "m_hs"
boolean controlmenu = false
boolean minbox = false
end type
global w_fa_rep_rango_pedido_sin_empaque w_fa_rep_rango_pedido_sin_empaque

type variables
str_rangofecha lstr_rangfech

end variables

event open;This.Icon = str.icono
this.postevent("ue_post_open")

gf_acelerador()

This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)
str.frame.SetRedraw ( True )

gf_center_win(This)
integer li_mes, li_ano
date ldt_fecha_ser

p_1.PictureName = "" + str.path +"\Art\Day.bmp "
ldt_fecha_ser = date(gf_fecha_serv())
li_mes 		  = month(ldt_fecha_ser)
li_ano		  = year(ldt_fecha_ser)

em_1.text = "01/01/" + string(li_ano)
em_2.text = string(ldt_fecha_ser)

String ls_dato
//If IsValid(m_fa_principal) then 
//	m_fa_principal.m_edicin.enabled = false
//	this.settoolbar(1,False)
//else
//	this.changemenu(m_fa_principal)
//	m_fa_principal.m_edicin.enabled = false
//	this.settoolbar(1,False)
//end if
st_nom_inf.text = "Informe de Pedidos Sin Empaque"

end event

event ue_vistaprevia;call super::ue_vistaprevia;//lstr_rangfech.opcion
/*
If IsNull(lstr_rangfech.opcion) or lstr_rangfech.opcion ='' then
	lstr_rangfech.opcion= 'Resumido por Grupo'
end if
*/
If isDate(em_1.text) then
	If isDate(em_2.text) then
		If date(em_1.text) <= date(em_2.text) then
	
		  lstr_rangfech.fecha1 = date(em_1.text)
		  lstr_rangfech.fecha2 = date(em_2.text)

		  OpenSheetWithParm(w_fa_rep_pedidos_sin_empaque,lstr_rangfech,this,1,Layered!)
		 // m_fa_principal.m_edicin.enabled = false
		  this.settoolbar(1,False)
		 
	   Else
		  Mensaje("Aviso","El Rango de Fecha es Inválido","Cerciórese de que el Rango de fecha DESDE no sea Mayor que el Rango de fecha HASTA")
	   End If
	
	Else
		Mensaje("Aviso","La fecha HASTA es Inválida","Cerciórese de que la fecha esté en el formato Válido: DIA/MES/AÑO")
	End If
Else
	Mensaje("Aviso","La fecha DESDE es Inválida","Cerciórese de que la fecha esté en el formato Válido: DIA/MES/AÑO")
End IF	

end event

on w_fa_rep_rango_pedido_sin_empaque.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_hs" then this.MenuID = create m_hs
end on

on w_fa_rep_rango_pedido_sin_empaque.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_post_open;//Override
/* dw corresponde al datawindows que se desea imprimir, por tanto
   si desea asignarle otro nombre haga lo siguiente 
	dw = otro_nombre */
dw = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()

end event

event close;call super::close;Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
end event

event closequery;call super::closequery;constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)

This.SetRedraw(false)
end event

type st_nom_ventana from w_fa_rep_rango_fecha`st_nom_ventana within w_fa_rep_rango_pedido_sin_empaque
integer x = 50
integer y = 492
integer width = 1038
end type

type st_ayuda from w_fa_rep_rango_fecha`st_ayuda within w_fa_rep_rango_pedido_sin_empaque
end type

type dw_1 from w_fa_rep_rango_fecha`dw_1 within w_fa_rep_rango_pedido_sin_empaque
integer y = 32
integer taborder = 70
end type

type gb_1 from w_fa_rep_rango_fecha`gb_1 within w_fa_rep_rango_pedido_sin_empaque
integer x = 50
integer y = 240
integer width = 1559
integer height = 196
integer taborder = 80
long backcolor = 79741120
string text = "  Rango de Fecha "
end type

type st_1 from w_fa_rep_rango_fecha`st_1 within w_fa_rep_rango_pedido_sin_empaque
integer x = 91
integer y = 328
integer width = 197
fontcharset fontcharset = ansi!
string text = "Desde :  "
end type

type em_1 from w_fa_rep_rango_fecha`em_1 within w_fa_rep_rango_pedido_sin_empaque
integer x = 297
integer y = 320
integer width = 384
end type

type st_2 from w_fa_rep_rango_fecha`st_2 within w_fa_rep_rango_pedido_sin_empaque
integer x = 873
integer y = 328
integer width = 165
boolean enabled = true
end type

type em_2 from w_fa_rep_rango_fecha`em_2 within w_fa_rep_rango_pedido_sin_empaque
integer x = 1047
integer y = 320
end type

type st_nom_inf from w_fa_rep_rango_fecha`st_nom_inf within w_fa_rep_rango_pedido_sin_empaque
integer x = 293
integer y = 68
integer width = 1362
integer height = 116
integer textsize = -12
boolean border = true
borderstyle borderstyle = styleraised!
end type

type cb_1 from w_fa_rep_rango_fecha`cb_1 within w_fa_rep_rango_pedido_sin_empaque
integer x = 1243
integer y = 492
end type

event cb_1::clicked;call super::clicked;//Dispara vista previa del Padre
end event

type p_1 from w_fa_rep_rango_fecha`p_1 within w_fa_rep_rango_pedido_sin_empaque
integer y = 24
end type

type pb_1 from w_fa_rep_rango_fecha`pb_1 within w_fa_rep_rango_pedido_sin_empaque
integer x = 690
integer y = 316
integer taborder = 60
end type

type pb_2 from w_fa_rep_rango_fecha`pb_2 within w_fa_rep_rango_pedido_sin_empaque
integer x = 1435
integer y = 316
integer taborder = 40
end type

type st_7 from w_fa_rep_rango_fecha`st_7 within w_fa_rep_rango_pedido_sin_empaque
end type

