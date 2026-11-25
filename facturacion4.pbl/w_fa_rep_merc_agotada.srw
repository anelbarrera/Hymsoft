//objectcomments Ventana Rango Fecha del Informe de Mercancía Agotada
forward
global type w_fa_rep_merc_agotada from w_fa_rep_rango_fecha
end type
end forward

global type w_fa_rep_merc_agotada from w_fa_rep_rango_fecha
integer width = 2057
integer height = 824
string title = "Informe de Merc. Agotadas - Excluye Ped. Reservados"
string menuname = ""
boolean controlmenu = false
boolean minbox = false
end type
global w_fa_rep_merc_agotada w_fa_rep_merc_agotada

event open;call super::open;String ls_dato


//If IsValid(m_fa_principal) then 
//	ls_dato = m_fa_principal.m_reportes.m_mercancasagotadas.m_sinconsiderarpedidosreservados.Text	
//	m_fa_principal.m_edicin.enabled = false
//	this.settoolbar(1,False)
//else
//	this.changemenu(m_fa_principal)
//	ls_dato = m_fa_principal.m_reportes.m_mercancasagotadas.m_sinconsiderarpedidosreservados.Text	
//	m_fa_principal.m_edicin.enabled = false
//	this.settoolbar(1,False)
//end if


st_nom_inf.text = "Inf. de Merc. Agotadas " + ls_dato


end event

event ue_vistaprevia;//OVERRIDE ANCESTOR SCRIPT

str_rangofecha lstr_rangfech

If isDate(em_1.text) then
	If isDate(em_2.text) then
		If date(em_1.text) <= date(em_2.text) then
			
			lstr_rangfech.fecha1 = date(em_1.text)
			lstr_rangfech.fecha2 = date(em_2.text)
	
			OpenSheetWithParm(w_fa_rep_merc_agotada_imp,lstr_rangfech,this,1,Layered!)
	
//			m_fa_principal.m_edicin.enabled = false
			this.settoolbar(1,False)
		
		Else
			Mensaje("Aviso","El Rango de Fecha es Inválido","Cersiórese de que el Rango de fecha DESDE no sea Mayor que el Rango de fecha HASTA")
		End If
	Else
		Mensaje("Aviso","La fecha HASTA es Inválida","Cersiórese de que la fecha esta en el formato válido DIA/MES/AÑO")
	End If
Else
	Mensaje("Aviso","La fecha DESDE es Inválida","Cersiórese de que la fecha esta en el formato válido DIA/MES/AÑO")
End IF	

//Copiarlo idéntico solo cambiar la ventana y el menu

end event

on w_fa_rep_merc_agotada.create
call super::create
end on

on w_fa_rep_merc_agotada.destroy
call super::destroy
end on

event ue_post_open;//Override
/* dw corresponde al datawindows que se desea imprimir, por tanto
   si desea asignarle otro nombre haga lo siguiente 
	dw = otro_nombre */
dw = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()

end event

event close;Window lw_frame

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

type st_nom_ventana from w_fa_rep_rango_fecha`st_nom_ventana within w_fa_rep_merc_agotada
boolean visible = false
integer x = 59
integer y = 580
integer height = 60
end type

type gb_1 from w_fa_rep_rango_fecha`gb_1 within w_fa_rep_merc_agotada
integer x = 50
integer y = 268
integer width = 1536
integer height = 264
string text = " Fecha de Agotamiento "
end type

type st_1 from w_fa_rep_rango_fecha`st_1 within w_fa_rep_merc_agotada
integer x = 82
integer y = 392
integer width = 233
fontcharset fontcharset = ansi!
string text = "Desde :  "
end type

type em_1 from w_fa_rep_rango_fecha`em_1 within w_fa_rep_merc_agotada
integer x = 293
integer y = 384
end type

type st_2 from w_fa_rep_rango_fecha`st_2 within w_fa_rep_merc_agotada
integer x = 864
integer y = 392
boolean enabled = true
end type

type em_2 from w_fa_rep_rango_fecha`em_2 within w_fa_rep_merc_agotada
integer x = 1051
integer y = 384
end type

type st_nom_inf from w_fa_rep_rango_fecha`st_nom_inf within w_fa_rep_merc_agotada
integer x = 261
integer y = 28
integer width = 1696
end type

type cb_1 from w_fa_rep_rango_fecha`cb_1 within w_fa_rep_merc_agotada
integer x = 1614
integer y = 364
end type

type p_1 from w_fa_rep_rango_fecha`p_1 within w_fa_rep_merc_agotada
end type

type pb_1 from w_fa_rep_rango_fecha`pb_1 within w_fa_rep_merc_agotada
integer x = 681
integer y = 376
end type

type pb_2 from w_fa_rep_rango_fecha`pb_2 within w_fa_rep_merc_agotada
integer x = 1440
integer y = 376
end type

type st_ayuda from w_fa_rep_rango_fecha`st_ayuda within w_fa_rep_merc_agotada
end type

type dw_1 from w_fa_rep_rango_fecha`dw_1 within w_fa_rep_merc_agotada
end type

type st_7 from w_fa_rep_rango_fecha`st_7 within w_fa_rep_merc_agotada
end type

