forward
global type w_fa_rep_grafica_ventas_anual from w_fa_padre_reportes
end type
type dw_2 from datawindow within w_fa_rep_grafica_ventas_anual
end type
type st_1 from statictext within w_fa_rep_grafica_ventas_anual
end type
type st_2 from statictext within w_fa_rep_grafica_ventas_anual
end type
type dw_3 from datawindow within w_fa_rep_grafica_ventas_anual
end type
type cb_1 from commandbutton within w_fa_rep_grafica_ventas_anual
end type
type cb_2 from commandbutton within w_fa_rep_grafica_ventas_anual
end type
end forward

global type w_fa_rep_grafica_ventas_anual from w_fa_padre_reportes
integer width = 3575
integer height = 2100
string title = "Resumen Anual de Ventas"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
dw_2 dw_2
st_1 st_1
st_2 st_2
dw_3 dw_3
cb_1 cb_1
cb_2 cb_2
end type
global w_fa_rep_grafica_ventas_anual w_fa_rep_grafica_ventas_anual

type variables
datawindowchild dch_ruclco , dch_ano
string is_codigo 
long ii_ano 
end variables

on w_fa_rep_grafica_ventas_anual.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.st_1=create st_1
this.st_2=create st_2
this.dw_3=create dw_3
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
end on

on w_fa_rep_grafica_ventas_anual.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;string ls_empre, ls_logo
str_rangofecha lstr_rangfech

lstr_rangfech = message.powerObjectParm
//If lstr_rangfech.opcion = 'Pedido' then
//	dw_1.DataObject = "dw_fa_rep_valor_pedidos"
//else
//end If


dw_2.GetChild ("cliente",dch_ruclco)
dch_ruclco.SetTransObject(SQLCA)

dw_3.GetChild ("ano",dch_ano)
dch_ano.SetTransObject(SQLCA)


if dch_ruclco.retrieve(str.g_financiero,str.empresa) = 0 then
   dch_ruclco.InsertRow(0)
end if

dch_ano.retrieve()
dch_ano.InsertRow(0)



dw = dw_1
dw.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)

dw_2.InsertRow(0)
dw_3.InsertRow(0)
ls_empre = gf_dg_nombre_empresa()
dw.object.empresa.text =  ls_empre 

//ls_logo = gf_logo_empr_foto_chica_fa()
//dw.object.logo_chico.expression = "bitmap ('"+ls_logo+"')"
//dw.object.logo_fondo.expression = "bitmap ('"+ls_logo+"')"
//dw.retrieve(str.g_financiero,str.empresa,lstr_rangfech.fecha1,lstr_rangfech.fecha2, lstr_rangfech.opcion)
dw.Object.datawindow.print.preview = true




end event

event resize;//Override
//this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 278
gb_1.width  = this.width  - 63
gb_1.height = this.height - 220
//
//
//st_nom_ventana.x = 28
//st_nom_ventana.y = this.height - 180
//this.SetRedraw(true)
end event

event ue_post_open;//Override
dw = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()
dw_impresion = dw

dw_3.setitem(1,'ano',year(date(gf_fecha_serv())))
end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_rep_grafica_ventas_anual
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_rep_grafica_ventas_anual
boolean visible = false
integer x = 41
integer y = 1864
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_rep_grafica_ventas_anual
integer y = 168
integer width = 3465
integer height = 1636
integer taborder = 10
string dataobject = "dw_ma_fa_compose_graf_anual"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::retrieveend;call super::retrieveend;if rowcount > 0 then cb_2.enabled = true
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_rep_grafica_ventas_anual
integer x = 41
integer y = 124
integer width = 3506
integer height = 1712
integer taborder = 20
end type

type dw_2 from datawindow within w_fa_rep_grafica_ventas_anual
boolean visible = false
integer x = 512
integer y = 36
integer width = 681
integer height = 92
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ma_fa_external_cliente"
boolean livescroll = true
end type

event itemchanged;dw_2.accepttext()

is_codigo =  dw_2.getitemstring(row,'cliente')
end event

type st_1 from statictext within w_fa_rep_grafica_ventas_anual
boolean visible = false
integer x = 169
integer y = 36
integer width = 343
integer height = 88
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Cliente :"
boolean focusrectangle = false
end type

type st_2 from statictext within w_fa_rep_grafica_ventas_anual
integer x = 224
integer y = 32
integer width = 192
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Año:"
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_fa_rep_grafica_ventas_anual
integer x = 489
integer y = 20
integer width = 306
integer height = 104
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ma_fa_external_ano"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;dw_3.accepttext()
ii_ano =  dw_3.getitemnumber(row,'ano')
end event

event rowfocuschanged;dw_3.accepttext()
ii_ano =  dw_3.getitemnumber(currentrow,'ano')
end event

type cb_1 from commandbutton within w_fa_rep_grafica_ventas_anual
integer x = 914
integer y = 20
integer width = 439
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar"
end type

event clicked;dw_3.accepttext()

ii_ano =  dw_3.getitemnumber(dw_3.getrow(),'ano')

 if dw.retrieve(str.g_financiero,str.empresa,ii_ano) = 0 then
	
    mensaje('Aviso', 'No Existe Información para Generar Reporte Grafico del año'  + string(ii_ano) ,' ' )	
 
 end if	


//integer     li_resul,i,li_resp=5
//string      ls_mensaje
//
//dw_3.accepttext()
//
//ii_ano =  dw_3.getitemnumber(dw_3.getrow(),'ano')
//
//if isnull(ii_ano) then
//	messagebox("Atención","Debe Especificar el año para generar la grafica")
//	dw_3.setfocus()
//	return
//end if
//li_resul = messagebox("","ESTÁ SEGURO DE APLICAR LOS PREMIADOS ",Question!, OKCancel!, 2)
//if li_resul = 1 then	
//	DECLARE aplicar_grafica  procedure for sp_fa_grafica_ventas_anual_1
//		@grupo1   =  :str.g_financiero, 
//		@empresa1 =  :str.empresa,
//		@ann      =  :ii_ano
//
//		USING SQLCA;	
//		DO WHILE li_resp = 5	
////			ole_1.visible = true
//			DO WHILE i<> 100
//				i++			
////				ole_1.Object.Value = i	
//				if li_resp = 5 then
//					EXECUTE aplicar_grafica ;
//					li_resp = sqlca.sqlcode 
//				end if 
//				if li_resp = -1 then exit
//			LOOP		
//		LOOP
////		ole_1.visible = false
//end if
//	IF li_resp = -1 then 
//		ls_mensaje = SQLCA.SqlErrtext
//		Rollback using sqlca;
////		ole_1.visible = false
//		mensaje("ERROR ",upper(ls_mensaje),"")
//	else
//		if li_resul = 1 then	
//			commit USING SQLCA;
//			mensaje("ATENCIÓN","LA ACTUALIZACIÓN DE LOS PREMIADOS SE HA REALIZADO EXITOSAMENTE","")
////			close(parent)
//		else
//			if li_resul = 2 then
//				dw_3.setfocus()
////				SelectText(this, 1, len(this.text))
//				return
//			end if
//		end if
//	end if
//
end event

type cb_2 from commandbutton within w_fa_rep_grafica_ventas_anual
boolean visible = false
integer x = 1403
integer y = 32
integer width = 448
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Estilos"
end type

event clicked;OpenWithParm(w_graph_type, dw_1)
end event

