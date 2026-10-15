//objectcomments Balance de Pruebas
forward
global type w_cierre_mensual from w_fa_padre_reportes
end type
type st_sel_marca from statictext within w_cierre_mensual
end type
type ddlb_1 from dropdownlistbox within w_cierre_mensual
end type
type cb_cerrar from commandbutton within w_cierre_mensual
end type
type cb_2 from commandbutton within w_cierre_mensual
end type
type em_ann from editmask within w_cierre_mensual
end type
type st_1 from statictext within w_cierre_mensual
end type
type ddlb_mes from dropdownlistbox within w_cierre_mensual
end type
end forward

global type w_cierre_mensual from w_fa_padre_reportes
integer width = 1440
integer height = 852
string title = "Cierre Mensual de Contabilidad"
boolean minbox = false
boolean maxbox = false
long backcolor = 12639424
windowanimationstyle openanimation = bottomslide!
st_sel_marca st_sel_marca
ddlb_1 ddlb_1
cb_cerrar cb_cerrar
cb_2 cb_2
em_ann em_ann
st_1 st_1
ddlb_mes ddlb_mes
end type
global w_cierre_mensual w_cierre_mensual

type variables
str_fa_ventafact str_informe
datawindowchild idwc_cuenta, idwc_cuenta2
integer ii_banco, ii_mes, ii_ann
string is_cuenta

end variables

on w_cierre_mensual.create
int iCurrent
call super::create
this.st_sel_marca=create st_sel_marca
this.ddlb_1=create ddlb_1
this.cb_cerrar=create cb_cerrar
this.cb_2=create cb_2
this.em_ann=create em_ann
this.st_1=create st_1
this.ddlb_mes=create ddlb_mes
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_sel_marca
this.Control[iCurrent+2]=this.ddlb_1
this.Control[iCurrent+3]=this.cb_cerrar
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.em_ann
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.ddlb_mes
end on

on w_cierre_mensual.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_sel_marca)
destroy(this.ddlb_1)
destroy(this.cb_cerrar)
destroy(this.cb_2)
destroy(this.em_ann)
destroy(this.st_1)
destroy(this.ddlb_mes)
end on

event ue_post_open;//override
string  ls_dinero, ls_tran, ls_documento, ls_stran, ls_ref, ls_cuenta, ls_masca, ls_empre
Integer li_ann, li_banco
datetime ldt_desde, ldt_hasta
string mes[12] 
mes[1] = 'ENERO'; mes[2] = 'FEBRERO';mes[3] = 'MARZO';mes[4] = 'ABRIL';mes[5] = 'MAYO';mes[6] = 'JUNIO';
mes[7] = 'JULIO';mes[8] = 'AGOSTO';mes[9] = 'SEPTIEMBRE';mes[10] = 'OCTUBRE';mes[11] = 'NOVIEMBRE';mes[12] = 'DICIEMBRE';

  SELECT comparam.para_ann_actual,   
         comparam.para_mes_actual  
    INTO :ii_ann,   
         :ii_mes  
    FROM comparam  
   WHERE ( comparam.para_g_financiero = :str.g_financiero ) AND  
         ( comparam.para_empresa = :str.empresa )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al buscar mes '+sqlca.sqlerrtext,1,1,'E')
		return
	end if

if ii_ann = 0 or ii_mes = 0 then
	gf_mensaje('','Debe definir los Parametros Generales de Contabilidad, Verifique !!!',1,1,'E')
	return
end if

//ldt_desde = datetime(relativedate(date(gf_fecha_serv()), - 30),00:00:00)
//ii_ann = year(date(gf_fecha_serv()))
//ii_mes = month(date(gf_fecha_serv()))
ldt_desde = datetime(date('01/'+string(ii_mes)+'/'+string(ii_ann)),00:00:00)

em_ann.text   = string(ii_ann)
ddlb_mes.text = mes[ii_mes]


end event

event resize;//Override
//this.SetRedraw(false)

//this.SetRedraw(true)
end event

event open;call super::open;//str_informe = Message.PowerObjectParm
this.y = 0
this.x = 805

end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_cierre_mensual
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_cierre_mensual
boolean visible = false
integer x = 32
integer y = 1384
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_cierre_mensual
boolean visible = false
integer x = 41
integer y = 200
integer width = 3749
integer height = 2256
integer taborder = 10
string dataobject = "dw_reporte_balance_resumido"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::doubleclicked;call super::doubleclicked;string         ls_pointer
long           li_fila
datetime       ldt_fecha1
window		   lw_child
str_rangofecha	str_rangofecha_opcion
str_fa_bus_var str_busqueda

//If pos(upper(str.nombre_empresa),'ELECTROVISION') > 0 Then 
if w_fa_fondo.str_aplica_links.habilita_links = 1	then
	ls_pointer = dw_1.GetObjectAtPointer()
	li_fila = integer(trim(mid(ls_pointer,7)))
	if pos(ls_pointer,'numero') > 0 then 
		str_rangofecha_opcion.opcion = 'Kardex'
		str_rangofecha_opcion.orden = dw_1.getitemstring(li_fila,'fact_no_factura')
		if w_fa_fondo.str_aplica_links.factura_activa_fa = 'A' then
			OpenSheetWithParm(lw_child,str_rangofecha_opcion,"w_fa_co_facturas_cab_det_99_e",str.frame,11,Original!)
		end if
	else
		if pos(ls_pointer,'nomcli') > 0 then 
			str_rangofecha_opcion.opcion = 'Kardex'
			str_rangofecha_opcion.cliente = dw_1.getitemnumber(li_fila,'terc_tercero')
//			ldt_fecha1 = dw_1.getitemdatetime(li_fila,'fact_fecha')
			str_rangofecha_opcion.fecha1 = date('01/01/1990')
			if w_fa_fondo.str_aplica_links.cxc_activa_cc = 'A' then
				OpenSheetWithParm(lw_child,str_rangofecha_opcion,"w_fa_co_mov_cliente_saldo",str.frame,11,Original!)
			end if
		end if
	end if
end if 

//	dw_3.Object.dmov_secuencia.Pointer = 'Cross!'

end event

event dw_1::ue_microayuda;//override
//Para cuando pasa por encima del objeto
//Override

Integer li_pos, li_x, li_y,li_largo
String ls_objeto, ls_col

ls_objeto = This.GetObjectAtPointer()
li_pos = pos  (ls_objeto,"~t")
ls_col = left (ls_objeto, li_pos - 1)

//li_x	 = str.frame.GetActiveSheet ().PointerX () 
//li_largo = len("Haga click para ordenar por la Columna de " + this.describe(ls_col+".text"))*28


//li_y	 = str.frame.GetActiveSheet ().PointerY () - 200

// Dependiendo de la Columna el Mensaje de Ayuda varía
CHOOSE CASE ls_col
	CASE 'mg_descripcion'
		this.Modify("mg_descripcion.Font.Underline='1'")
		this.Modify("mg_descripcion.Color='7536640'")
	CASE 'mayo_cuenta'
		this.Modify("mayo_cuenta.Font.Underline='1'")
		this.Modify("mayo_cuenta.Color='7536640'")
	CASE ELSE
		this.Modify("mg_descripcion.Font.Underline='0'")
		this.Modify("mg_descripcion.Color='0'")
		this.Modify("mayo_cuenta.Font.Underline='0'")
		this.Modify("mayo_cuenta.Color='0'")

END CHOOSE
end event

event dw_1::clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto, ls_column
integer li_pos, li_mes, li_ann 
datetime ldt_desde, ldt_hasta
date ld_desde, ld_hasta
ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

ls_column = dwo.name

if dw_1.dataobject = 'dw_reporte_balance_detallado' then

	if ls_column = 'mg_descripcion' or ls_column = 'mayo_cuenta' then
		str_cc_formatos str_formato1	
		if dw_1.getitemnumber(row,'mg_nivel') = 1 then return  
		str_formato1.cuenta = dw_1.getitemstring(row,'mayo_cuenta')
		li_mes = ii_mes 
		li_ann = ii_ann 
		gf_fecha_ini_fecha_fin(li_mes, li_ann, ld_desde, ld_hasta)
		ldt_desde = datetime(ld_desde,00:00:00)
		ldt_hasta = datetime(ld_hasta,23:59:59)
	
		str_formato1.fecha1 = ldt_desde
		str_formato1.fecha2 = ldt_hasta
		OpenSheetwithparm(w_reporte_historico_cuentas,str_formato1,parent,2, layered!)
		
	end if
	
else
	if ls_column = 'mg_descripcion' or ls_column = 'mayo_cuenta' then
		str_cc_formatos str_formato2	
		if dw_1.getitemnumber(row,'mg_nivel') <> 1 then return  
		str_formato2.cuenta = dw_1.getitemstring(row,'mayo_cuenta')
		li_mes = ii_mes 
		li_ann = ii_ann
		gf_fecha_ini_fecha_fin(li_mes, li_ann, ld_desde, ld_hasta)
		ldt_desde = datetime(ld_desde,00:00:00)
		
		str_formato2.fecha1 = ldt_desde

		OpenSheetwithparm(w_reporte_auxiliares,str_formato2,parent,2, layered!)
		
	end if
end if
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_cierre_mensual
boolean visible = false
integer x = 27
integer y = 192
integer width = 2967
integer height = 1364
integer taborder = 20
long backcolor = 12639424
end type

type st_sel_marca from statictext within w_cierre_mensual
boolean visible = false
integer x = 1541
integer y = 1408
integer width = 640
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleccione la Marca"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_cierre_mensual
boolean visible = false
integer x = 2240
integer y = 1388
integer width = 754
integer height = 244
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
boolean vscrollbar = true
string item[] = {"NATURAL EXCHANGE","PUNTOCOM","TODAS"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String	ls_filtro
ls_filtro = 'PC'

if index = 1 then	//NATURAL
	dw_1.setFilter("fact_ruc_cliente not like '" +ls_filtro+ "%'")
	dw_1.filter()
	dw_1.groupcalc()
elseIf index = 2 then //PUNTO COM
	dw_1.setFilter( "fact_ruc_cliente like '" +ls_filtro+ "%'")
	dw_1.filter()
	dw_1.groupcalc()
elseIf index = 3 then //TOTAL
	ls_filtro = 'XX'
	dw_1.setFilter( "fact_ruc_cliente not like '" +ls_filtro+ "%'")
	dw_1.filter()
	dw_1.groupcalc()
end if

end event

type cb_cerrar from commandbutton within w_cierre_mensual
integer x = 283
integer y = 384
integer width = 343
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
boolean default = true
end type

event clicked;string ls_dinero, ls_tran, ls_documento, ls_fecha_text, ls_cuenta1, ls_cuenta2
integer li_ann, li_mes, li_caracteres_nivel1
date ldt_hasta

if gf_mensaje('','Esta Seguro de Procesar el Cierre Mensual de Contabilidad ?',2,2,'E') = 2 then return

li_ann = ii_ann
li_mes = ii_mes

if li_mes = 12 then
	li_ann ++
	li_mes = 1
else
	li_mes ++
	ii_mes ++
end if

ldt_hasta = date('01/'+string(li_mes)+'/'+string(li_ann))

sqlca.autocommit = false

  UPDATE cotdiari  
     SET diar_cerrado = 'S',   
         diar_cierre_mensual = 'S'  
   WHERE ( cotdiari.diar_g_financiero = :str.g_financiero ) AND  
         ( cotdiari.diar_empresa = :str.empresa ) AND  
         ( cotdiari.diar_fecha_transaccion < :ldt_hasta ) AND  
         ( cotdiari.diar_cierre_mensual = 'N' )  ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al actualizar el mes '+sqlca.sqlerrtext,1,1,'E')
		rollback;
		sqlca.autocommit = true
		return
	end if
	
	UPDATE comparam  
	  SET para_ann_actual = :li_ann,   
			para_mes_actual = :li_mes,
			para_ann_inicio_periodo = :li_ann,
			para_mes_inicio_periodo = 1,
			para_ann_fin_periodo = :li_ann,
			para_mes_fin_periodo = 12
   WHERE ( comparam.para_g_financiero = :str.g_financiero ) AND  
         ( comparam.para_empresa = :str.empresa ) ;
			
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al Actualizar el mes '+sqlca.sqlerrtext,1,1,'E')
		rollback;
		sqlca.autocommit = true
		return
	end if

commit;

sqlca.autocommit = true

gf_mensaje('','Cierre Satisfactorio',1,1,'E')

parent.triggerevent('ue_post_open')
end event

type cb_2 from commandbutton within w_cierre_mensual
integer x = 773
integer y = 384
integer width = 343
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
end type

event clicked;parent.triggerevent('close')
end event

type em_ann from editmask within w_cierre_mensual
integer x = 155
integer y = 100
integer width = 215
integer height = 76
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
boolean displayonly = true
string mask = "###0"
end type

event modified;ii_ann = integer(this.text)
end event

type st_1 from statictext within w_cierre_mensual
integer x = 407
integer y = 116
integer width = 197
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Mes:"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_mes from dropdownlistbox within w_cierre_mensual
integer x = 599
integer y = 100
integer width = 658
integer height = 836
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
boolean sorted = false
string item[] = {"ENERO","FEBRERO","MARZO","ABRIL","MAYO","JUNIO","JULIO","AGOSTO","SEPTIEMBRE","OCTUBRE","NOVIEMBRE","DICIEMBRE"}
end type

event selectionchanged;ii_mes = index
end event

