//objectcomments Consulta de transacciones de clientes Vista Previa
forward
global type w_historial_cliente from w_fa_padre_reportes
end type
type st_sel_marca from statictext within w_historial_cliente
end type
type ddlb_1 from dropdownlistbox within w_historial_cliente
end type
type cb_consultar from commandbutton within w_historial_cliente
end type
type cb_2 from commandbutton within w_historial_cliente
end type
type dw_2 from datawindow within w_historial_cliente
end type
type uo_1 from u_ddcalen within w_historial_cliente
end type
type uo_2 from u_ddcalen within w_historial_cliente
end type
type pb_1 from picturebutton within w_historial_cliente
end type
type dw_3 from datawindow within w_historial_cliente
end type
type dw_4 from datawindow within w_historial_cliente
end type
end forward

global type w_historial_cliente from w_fa_padre_reportes
integer width = 5097
integer height = 2656
string title = "Historial de Ventas por Cliente"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 12639424
st_sel_marca st_sel_marca
ddlb_1 ddlb_1
cb_consultar cb_consultar
cb_2 cb_2
dw_2 dw_2
uo_1 uo_1
uo_2 uo_2
pb_1 pb_1
dw_3 dw_3
dw_4 dw_4
end type
global w_historial_cliente w_historial_cliente

type variables
datawindowchild idwc_cliente, idwc_producto

end variables

forward prototypes
public subroutine wf_costo_en_letra ()
end prototypes

public subroutine wf_costo_en_letra ();integer i, li_total
decimal{2} ld_costo, ld_margen, ld_porc_costo, ld_porc_venta
string ls_costo, ls_margen, ls_porc_costo, ls_porc_venta

li_total = dw_2.rowcount()
for i = 1 to li_total
	yield()
	if dw_2.getitemstring(i,'costo_letras') = '' or isnull(dw_2.getitemstring(i,'costo_letras')) then
		ld_costo = dw_2.getitemnumber(i,'facd_costo_cif')
		ls_costo = gf_clave_costos(ld_costo)		
		dw_2.setitem(i,'costo_letras',ls_costo)	
	end if
	if dw_2.getitemstring(i,'margen_letras') = '' or isnull(dw_2.getitemstring(i,'margen_letras')) then
		ld_margen = dw_2.getitemnumber(i,'ganancia')
		ls_margen = gf_clave_costos(ld_margen)		
		dw_2.setitem(i,'margen_letras',ls_margen)	
	end if
	if dw_2.getitemstring(i,'porc_costo_letras') = '' or isnull(dw_2.getitemstring(i,'porc_costo_letras')) then
		ld_porc_costo = dw_2.getitemnumber(i,'porc_costo')
		ls_porc_costo = gf_clave_costos(ld_porc_costo)		
		dw_2.setitem(i,'porc_costo_letras',ls_porc_costo)	
	end if
	if dw_2.getitemstring(i,'porc_venta_letras') = '' or isnull(dw_2.getitemstring(i,'porc_venta_letras')) then
		ld_porc_venta = dw_2.getitemnumber(i,'porc_venta')
		ls_porc_venta = gf_clave_costos(ld_porc_venta)		
		dw_2.setitem(i,'porc_venta_letras',ls_porc_venta)	
	end if
next
end subroutine

on w_historial_cliente.create
int iCurrent
call super::create
this.st_sel_marca=create st_sel_marca
this.ddlb_1=create ddlb_1
this.cb_consultar=create cb_consultar
this.cb_2=create cb_2
this.dw_2=create dw_2
this.uo_1=create uo_1
this.uo_2=create uo_2
this.pb_1=create pb_1
this.dw_3=create dw_3
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_sel_marca
this.Control[iCurrent+2]=this.ddlb_1
this.Control[iCurrent+3]=this.cb_consultar
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.uo_2
this.Control[iCurrent+8]=this.pb_1
this.Control[iCurrent+9]=this.dw_3
this.Control[iCurrent+10]=this.dw_4
end on

on w_historial_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_sel_marca)
destroy(this.ddlb_1)
destroy(this.cb_consultar)
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.pb_1)
destroy(this.dw_3)
destroy(this.dw_4)
end on

event ue_post_open;//Override
datetime ldt_inicio, ldt_fin
string ls_empresa
//override

dw_1.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)

dw_1.getchild('cliente',idwc_cliente)
dw_1.getchild('producto',idwc_producto)
idwc_cliente.settransobject(sqlca)
idwc_producto.settransobject(sqlca)
if idwc_cliente.retrieve(str.g_financiero, str.empresa) = 0 then idwc_cliente.insertrow(0)
if idwc_producto.retrieve(str.g_financiero, str.empresa) = 0 then idwc_producto.insertrow(0)
ldt_fin 	 = datetime(date(gf_fecha_serv()))
ldt_inicio  = datetime(relativedate(date(gf_fecha_serv()), - 1200))
dw_2.settransobject(sqlca)
dw_1.insertrow(1)
dw_1.setitem(1,'fecha1',ldt_inicio)
dw_1.setitem(1,'fecha2',ldt_fin)

ls_empresa = gf_fa_nom_empr( str.g_financiero , str.empresa  ) 
dw_3.object.empresa.expression = "'"+ ls_empresa +"'"
dw_3.object.datawindow.print.preview="yes"

dw_2.sharedata(dw_3)





end event

event resize;//Override
this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 325

this.SetRedraw(true)

end event

event open;//Override

this.y = 0
this.x = 805

dw = dw_2
dw_impresion = dw_1
dw_1.settransobject(sqlca)
st_nom_ventana.text = this.classname()

This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)

str.frame.SetRedraw ( True )

This.Icon = str.icono
this.postevent("ue_post_open")

end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_historial_cliente
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_historial_cliente
boolean visible = false
integer x = 32
integer y = 1384
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_historial_cliente
integer x = 27
integer y = 28
integer width = 4197
integer height = 212
string dataobject = "dw_external_historial"
boolean border = false
boolean livescroll = false
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

event dw_1::ue_microayuda;////override
////Para cuando pasa por encima del objeto
////Override
//
//Integer li_pos, li_x, li_y,li_largo
//String ls_objeto, ls_col
//
//ls_objeto = This.GetObjectAtPointer()
//li_pos = pos  (ls_objeto,"~t")
//ls_col = left (ls_objeto, li_pos - 1)
//
////li_x	 = str.frame.GetActiveSheet ().PointerX () 
////li_largo = len("Haga click para ordenar por la Columna de " + this.describe(ls_col+".text"))*28
//
//
////li_y	 = str.frame.GetActiveSheet ().PointerY () - 200
//
//// Dependiendo de la Columna el Mensaje de Ayuda varía
//CHOOSE CASE ls_col
//	CASE 'cctmovim_movi_a_nombre'
//		this.Modify("cctmovim_movi_a_nombre.Font.Underline='1'")
//		this.Modify("cctmovim_movi_a_nombre.Color='7536640'")
//
//	CASE ELSE
//		this.Modify("cctmovim_movi_a_nombre.Font.Underline='0'")
//		this.Modify("cctmovim_movi_a_nombre.Color='0'")
//
//END CHOOSE
end event

event dw_1::clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.
accepttext()
date 	ld_date,ld_ini_date, ld_hoy
string ls_objeto, ls_column
integer li_pos 

ls_objeto = This.GetObjectAtPointer()
ld_hoy = date(gf_fecha_Serv())
li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

ls_column = dwo.name

if ls_column = 'cctmovim_movi_a_nombre' then
	str_cc_formatos str_formato1		
	str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	str_formato1.tercero = dw_1.getitemNumber(1,"cctmovim_movi_tercero")
	OpenSheetwithparm(w_mant_clientes,str_formato1,parent,2, Original!)
elseif dwo.name='calendario' then
	ld_ini_date=date(dw_1.GetItemDateTime(dw_1.getrow(),"fecha1"))
	if year(ld_ini_date) = 1900 then
		ld_ini_date = ld_hoy
	end if
	if uo_1.visible=false then
		uo_1.wf_set_value(ld_ini_date)
		uo_1.visible=true
		uo_1.allow_close=false
		uo_1.inicializar()
		uo_1.TriggerEvent('ue_abrir')
	end if
elseif dwo.name='calendario2' then
	ld_ini_date=date(dw_1.GetItemDateTime(dw_1.getrow(),"fecha2"))
	if year(ld_ini_date) = 1900 then
		ld_ini_date = ld_hoy
	end if
	if uo_2.visible=false then
		uo_2.wf_set_value(ld_ini_date)
		uo_2.visible=true
		uo_2.allow_close=false
		uo_2.inicializar()
		uo_2.TriggerEvent('ue_abrir')
	end if
	
end if

end event

event dw_1::buttonclicked;call super::buttonclicked;//busqueda
long ll_codigo
integer li_encontro	
String  ls_codigo, ls_find,ls_codigo1,ls_lter,ls_des, ls_error, ls_cuenta
integer li_c, li_b
long    ll_lter

Datawindow        dww
str_dg_dynamic_find	lstr_df

if dwo.name = 'b_cliente' then
	ls_cuenta = dw_1.getitemstring(1,'cuenta')
	//SI ES CLIENTE CONTADO
	if ls_cuenta = '99999' then
		lstr_df.texto_campo [1,1] = "fatdiari.fact_a_nombre"
		lstr_df.texto_campo [1,2] = "Cliente Contado"
		lstr_df.texto_campo [1,3] = "fact_a_nombre"
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '1300'		
		
		lstr_df.tabla = " fatdiari "
		
		lstr_df.tabla_where = &
					"WHERE ( fatdiari.fact_ruc_cliente = '99999' ) and  " +&				
							 "(fatdiari.fact_g_financiero = " + string(str.g_financiero) + " and " +&
							 "fatdiari.fact_empresa = " + string(str.empresa) + ") group by fact_a_nombre "
		
				OpenWithParm(w_dg_a_custom_find, lstr_df)
				ls_find = Message.StringParm
			
			If len (ls_find) = 0 Then Return

			ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
			gf_replace_cadena(ls_codigo1,"'"," ")
			ls_codigo1 = Trim(ls_codigo1)
		
			dw_1.setitem(1,'nombre',ls_codigo1)
			dw_1.accepttext()
		

	else
		lstr_df.texto_campo [2,1] = "ccmclien.clie_ref_anterior" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [2,2] = "Cuenta"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '450'
		lstr_df.texto_campo [1,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [1,2] = "Descripción"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '700'		
		lstr_df.texto_campo [3,1] = "dgmterce.terc_tercero"
		lstr_df.texto_campo [3,2] = "Código Tercero"
		lstr_df.texto_campo [3,3] = "terc_tercero"
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [4,1] = "dgapais.pais_descripcion"
		lstr_df.texto_campo [4,2] = "País"
		lstr_df.texto_campo [4,3] = ""
		lstr_df.texto_campo [4,4] = 'V'
		lstr_df.texto_campo [4,5] = '550'
		
		lstr_df.tabla = " dgmterce, dgapais, ccmclien "
		
		
		lstr_df.tabla_where = &
					"WHERE ( dgmterce.terc_pais = dgapais.pais_pais ) and  " +&				
							 "(ccmclien.clie_g_financiero = " + string(str.g_financiero) + " and " +&
							 "ccmclien.clie_empresa = " + string(str.empresa) + ") 	and " +&
							"(dgmterce.terc_tercero = ccmclien.clie_tercero) "  							
		
				OpenWithParm(w_dg_a_custom_find, lstr_df)
				ls_find = Message.StringParm
			
			
			If len (ls_find) = 0 Then Return
				
				
			ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
			gf_replace_cadena(ls_codigo1,"'"," ")
			ls_codigo1 = Trim(ls_codigo1)
		
			dw_1.setitem(1,'cliente',long(ls_codigo1))
			dw_1.accepttext()
		
			li_encontro = idwc_cliente.find("terc_tercero = "+ls_codigo1,1,idwc_cliente.rowcount())
				if li_encontro > 0 then
					ls_cuenta= idwc_cliente.getitemString(li_encontro,'clie_ref_anterior')
					this.setitem(1,'cuenta',ls_cuenta)
				else
					this.setitem(1,'cuenta','')
				end if
			dw_1.setcolumn('cliente')
	end if
	dw_1.setitem(1,'producto','')
	dw_1.setitem(1,'modelo','')
	cb_consultar.triggerevent('clicked')
	
elseif dwo.name = 'b_producto' then

	lstr_df.texto_campo [2,1] = "inmprodu.prod_producto"
	lstr_df.texto_campo [2,2] = "Referencia"
	lstr_df.texto_campo [2,3] = "prod_producto"
	lstr_df.texto_campo [2,4] = 'V'
//	lstr_df.texto_campo [2,5] = '280'	
	lstr_df.texto_campo [1,1] = "inmprodu.prod_producto_dos"
	lstr_df.texto_campo [1,2] = "Modelo"
	lstr_df.texto_campo [1,3] = ""
	lstr_df.texto_campo [1,4] = 'V'
//	lstr_df.texto_campo [1,5] = '770'
	lstr_df.texto_campo [3,1] = "inmprodu.prod_descripcion"
	lstr_df.texto_campo [3,2] = "Descripcion"
	lstr_df.texto_campo [3,3] = ""
	lstr_df.texto_campo [3,4] = 'V'
	lstr_df.texto_campo [3,5] = '1070'
	
	lstr_df.texto_campo [4,1] = "convert(numeric(8,2),inmprodu.prod_existencia_total / medi_cantidad) prod_existencia_total"
	lstr_df.texto_campo [4,2] = "Exist."
	lstr_df.texto_campo [4,3] = ""
	lstr_df.texto_campo [4,4] = 'V'
	lstr_df.texto_campo [4,5] = '270'

	lstr_df.texto_campo [5,1] = "convert(numeric(8,2),inmprodu.prod_reserva_total / medi_cantidad) prod_reserva_total"
	lstr_df.texto_campo [5,2] = "Reserva"
	lstr_df.texto_campo [5,3] = ""
	lstr_df.texto_campo [5,4] = 'V'
	lstr_df.texto_campo [5,5] = '270'

	lstr_df.texto_campo [6,1] = "convert(numeric(8,2),(inmprodu.prod_existencia_total  - inmprodu.prod_reserva_total) / medi_cantidad) disponible"
	lstr_df.texto_campo [6,2] = "Dispo."
	lstr_df.texto_campo [6,3] = ""
	lstr_df.texto_campo [6,4] = 'V'
	lstr_df.texto_campo [6,5] = '270'

	lstr_df.texto_campo [7,1] = "convert(numeric(12), inmprodu.prod_empaque) prod_empaque"
	lstr_df.texto_campo [7,2] = "Empaque"
	lstr_df.texto_campo [7,3] = ""
	lstr_df.texto_campo [7,4] = 'V'
	lstr_df.texto_campo [7,5] = '270'
	
	lstr_df.texto_campo [8,1] = "inmprodu.prod_medida"
	lstr_df.texto_campo [8,2] = "Uni."
	lstr_df.texto_campo [8,3] = ""
	lstr_df.texto_campo [8,4] = 'V'
	lstr_df.texto_campo [8,5] = '120'
	lstr_df.texto_campo [9,1] = "cradivis.adiv_nombre_div"
	lstr_df.texto_campo [9,2] = "Division"
	lstr_df.texto_campo [9,3] = ""
	lstr_df.texto_campo [9,4] = 'V'
	lstr_df.texto_campo [9,5] = '870'
	lstr_df.texto_campo [10,1] = "cragrupo.agru_descripcion_grupo"
	lstr_df.texto_campo [10,2] = "Grupo"
	lstr_df.texto_campo [10,3] = ""
	lstr_df.texto_campo [10,4] = 'V'
	lstr_df.texto_campo [10,5] = '870'

	lstr_df.tabla = " inmprodu, cradivis, cragrupo, inamedid "
		
	lstr_df.tabla_where = &
		"WHERE ( cragrupo.agru_g_financiero = inmprodu.prod_g_financiero ) and  " +&
         "( cragrupo.agru_empresa = inmprodu.prod_empresa ) and  " +&
         "( cragrupo.agru_codigo_div = inmprodu.prod_division ) and " +&  
         "( cragrupo.agru_codigo_grupo = inmprodu.prod_grupo ) and " +&  			
         "( inmprodu.prod_g_financiero = cradivis.adiv_g_financiero ) and " +& 
         "( inmprodu.prod_empresa = cradivis.adiv_empresa ) and  " +&
         "( inmprodu.prod_division = cradivis.adiv_codigo_div ) and " +&  
         "( inmprodu.prod_medida = inamedid.medi_medida ) and " +&  			
		"( inmprodu.prod_status = 1 ) and " + &	
		"(inmprodu.prod_g_financiero = " + string(str.g_financiero) + ") and " +&
		"(inmprodu.prod_empresa = " + string(str.empresa) + ") "	
						 
	OpenWithParm(w_buscar_producto, lstr_df)
	ls_find = Message.StringParm
	
	If len (ls_find) = 0 Then Return
		
	ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo,"'"," ")
	ls_codigo = Trim(ls_codigo)
	this.setitem(this.getrow(),'producto',ls_codigo)
	
	  SELECT max(inmprodu.prod_producto_dos)
		 INTO :ls_codigo  
		 FROM inmprodu  
		WHERE ( inmprodu.prod_g_financiero = :str.g_financiero ) AND  
				( inmprodu.prod_empresa = :str.empresa ) AND  
				( inmprodu.prod_producto = :ls_codigo )   ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al buscar modelo '+sqlca.sqlerrtext,1,1,'E')
			return
		end if
		
		this.setitem(this.getrow(),'modelo',ls_codigo)
		this.setcolumn('modelo')
		this.setfocus()
		this.triggerevent('editchanged')
end if
end event

event dw_1::itemchanged;call super::itemchanged;this.accepttext()
string ls_cuenta, ls_item, ls_modelo, ls_nombre, ls_filter, ls_find, ls_codigo1
long   ll_tercero, ll_encontro
integer li_ultima_venta, li_existentes
parent.setredraw(false)
str_dg_dynamic_find	lstr_df

if this.getitemstring(1,'cuenta') <> '99999' then
	dw_2.setfilter('')
	dw_2.filter()
end if
	
choose case this.getcolumnname()
	case 'en_letra'
		if integer(data) = 1 then
			wf_costo_en_letra()		
			dw_2.Modify("facd_costo_cif.visible=false")
			dw_2.Modify("ganancia.visible=false")
			dw_2.Modify("porc_costo.visible=false")
			dw_2.Modify("porc_venta.visible=false")
		else
			dw_2.Modify("facd_costo_cif.visible=true")
			dw_2.Modify("ganancia.visible=true")
			dw_2.Modify("porc_costo.visible=true")
			dw_2.Modify("porc_venta.visible=true")
		end if
	case 'costo'
		if integer(data) = 1 then
//			dw_2.Modify("ganancia_t.X='3337'")
//			dw_2.Modify("ganancia.X='3333'")
//			dw_2.Modify("porc_costo_t.X='3653'")			
//			dw_2.Modify("porc_costo.X='3643'")
//			dw_2.Modify("porc_venta_t.X='3849'")			
//			dw_2.Modify("porc_venta.X='3840'")			
			dw_2.Modify("existencia.X='3968'")
			dw_2.Modify("existencia_t.X='3973'")
			dw_2.Modify("reserva.X='4274'")
			dw_2.Modify("reserva_t.X='4283'")	
			dw_2.Modify("disponible.X='4581'")
			dw_2.Modify("disponible_t.X='4594'")
			dw_2.Modify("fact_a_nombre.X='4891'")
			dw_2.Modify("fact_a_nombre_t.X='4905'")		
		else
//			dw_2.Modify("ganancia_t.X='3063'")
//			dw_2.Modify("ganancia.X='3063'")
//			dw_2.Modify("porc_costo_t.X='3378'")			
//			dw_2.Modify("porc_costo.X='3374'")
//			dw_2.Modify("porc_venta_t.X='3575'")			
//			dw_2.Modify("porc_venta.X='3570'")
			dw_2.Modify("existencia.X='3077'")
			dw_2.Modify("existencia_t.X='3071'")
			dw_2.Modify("reserva.X='3387'")
			dw_2.Modify("reserva_t.X='3378'")	
			dw_2.Modify("disponible.X='3694'")
			dw_2.Modify("disponible_t.X='3689'")
			dw_2.Modify("fact_a_nombre.X='4009'")
			dw_2.Modify("fact_a_nombre_t.X='4000'")
		end if
	case 'existentes','ultima_venta'
		if this.getitemstring(1,'cuenta') = '99999' then ls_nombre = this.getitemstring(1,'nombre')
		ls_item	  = this.getitemstring(1,'producto')
		ls_modelo = this.getitemstring(1,'modelo')

		if len(ls_nombre) > 0 then
			ls_filter = 'left(upper(fact_a_nombre) ,'+ string(len(ls_nombre))+ ') = "'+upper(ls_nombre)+'"'			
		end if
		if len(ls_item) > 0 then
			if len(ls_filter) > 0 then
				ls_filter = ls_filter + ' and left(upper(facd_codigo_item) ,'+ string(len(ls_item))+ ') = "'+upper(ls_item)+'"'			
			else
				ls_filter = 'left(upper(facd_codigo_item) ,'+ string(len(ls_item))+ ') = "'+upper(ls_item)+'"'							
			end if
		end if
		if len(ls_modelo) > 0 then
			if len(ls_filter) > 0 then
				ls_filter = ls_filter+ ' and left(upper(prod_producto_dos) ,'+ string(len(ls_modelo))+ ') = "'+upper(ls_modelo)+'"'			
			else
				ls_filter = 'left(upper(prod_producto_dos) ,'+ string(len(ls_modelo))+ ') = "'+upper(ls_modelo)+'"'							
			end if
		end if
		
		if dwo.name = 'existentes' then
			li_existentes = long(data)
			li_ultima_venta = this.getitemnumber(1,'ultima_venta')
		else
			li_existentes = this.getitemnumber(1,'existentes')
			li_ultima_venta = long(data)
		end if

		if len(ls_filter) = 0 then
			if li_existentes = 1 then
				ls_filter = 'disponible > 0'
			end if
		else
			if li_existentes = 1 then
				ls_filter = ls_filter + ' and disponible > 0'
			end if
		end if
		
		if li_ultima_venta = 1 then
			if len(ls_filter) = 0 then
				ls_filter = 'mostrar_ultimo = 1'
			else
				ls_filter = ls_filter + ' and mostrar_ultimo = 1'
			end if
		end if		
		
		if len(ls_filter) = 0 then
			dw_2.setfilter('')
		else
			dw_2.setfilter(ls_filter)
		end if
	
		dw_2.filter()
		if dw_1.getitemnumber(1,'costo') = 1 and dw_1.getitemnumber(1,'en_letra') = 1 then
			wf_costo_en_letra()
		end if
	case 'cliente'
		ls_cuenta = idwc_cliente.getitemstring(idwc_cliente.getrow(),'clie_ref_anterior')
		this.setitem(row,'cuenta',ls_cuenta)
		
	case 'cuenta'
		ll_encontro = idwc_cliente.find("clie_ref_anterior = '"+data+"'",1,idwc_cliente.rowcount())
		if ll_encontro > 0 then
			ll_tercero = idwc_cliente.getitemnumber(ll_encontro,'terc_tercero')
			this.setitem(1,'cliente',ll_tercero)
			idwc_cliente.scrolltorow(ll_encontro)
		else
			this.setitem(1,'cliente',0)
		end if
		dw_1.setitem(1,'producto','')
		dw_1.setitem(1,'modelo','')
	
		if data = '99999' then
			lstr_df.texto_campo [1,1] = "fatdiari.fact_a_nombre"
			lstr_df.texto_campo [1,2] = "Cliente Contado"
			lstr_df.texto_campo [1,3] = "fact_a_nombre"
			lstr_df.texto_campo [1,4] = 'V'
			lstr_df.texto_campo [1,5] = '1300'		
			
			lstr_df.tabla = " fatdiari "
			
			lstr_df.tabla_where = &
						"WHERE ( fatdiari.fact_ruc_cliente = '99999' ) and  " +&				
								 "(fatdiari.fact_g_financiero = " + string(str.g_financiero) + " and " +&
								 "fatdiari.fact_empresa = " + string(str.empresa) + ") group by fact_a_nombre "
			
					OpenWithParm(w_dg_a_custom_find, lstr_df)
					ls_find = Message.StringParm
				
				If len (ls_find) = 0 Then 
					parent.setredraw(true)
					Return
				end if
	
				ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
				gf_replace_cadena(ls_codigo1,"'"," ")
				ls_codigo1 = Trim(ls_codigo1)
			
				dw_1.setitem(1,'nombre',ls_codigo1)
				dw_1.accepttext()
		end if	
end choose
parent.setredraw(true)
end event

event dw_1::editchanged;call super::editchanged;string ls_nombre, ls_filter, ls_modelo, ls_item
integer li_existencias, li_ultima_venta
this.accepttext()
//str.frame.setredraw(false)
//this.setredraw(false)
choose case this.getcolumnname() 
	case 'nombre', 'producto', 'modelo'
		
		if this.getitemstring(1,'cuenta') = '99999' then ls_nombre = this.getitemstring(1,'nombre')
		ls_item	  = this.getitemstring(1,'producto')
		ls_modelo = this.getitemstring(1,'modelo')

		if len(ls_nombre) > 0 then
			ls_filter = 'left(upper(fact_a_nombre) ,'+ string(len(ls_nombre))+ ') = "'+upper(ls_nombre)+'"'			
		end if
		if len(ls_item) > 0 then
			if len(ls_filter) > 0 then
				ls_filter = ls_filter + ' and left(upper(facd_codigo_item) ,'+ string(len(ls_item))+ ') = "'+upper(ls_item)+'"'			
			else
				ls_filter = 'left(upper(facd_codigo_item) ,'+ string(len(ls_item))+ ') = "'+upper(ls_item)+'"'							
			end if
		end if
		
		li_existencias = this.getitemnumber(1,'existentes')
		if li_existencias = 1 then
			if len(ls_filter) = 0 then
				ls_filter = 'disponible > 0'
			else
				ls_filter = ls_filter + ' and disponible > 0'
			end if
		end if		
		
		li_ultima_venta = this.getitemnumber(1,'ultima_venta')
		if li_ultima_venta = 1 then
			if len(ls_filter) = 0 then
				ls_filter = 'mostrar_ultimo = 1'
			else
				ls_filter = ls_filter + ' and mostrar_ultimo = 1'
			end if
		end if		

		if len(ls_modelo) > 0 then
			if len(ls_filter) > 0 then
				ls_filter = ls_filter+ ' and prod_producto_dos like "%'+upper(ls_modelo)+'%"'			
			else
				ls_filter = 'prod_producto_dos like "%'+upper(ls_modelo)+'%"'							
			end if
		end if

		if len(ls_filter) = 0 then
			dw_2.setfilter('')
		else
			dw_2.setfilter(ls_filter)
		end if
		
		dw_2.filter()
		if dw_1.getitemnumber(1,'costo') = 1 and dw_1.getitemnumber(1,'en_letra') = 1 then
			wf_costo_en_letra()
		end if
end choose
//this.setredraw(true)
//str.frame.setredraw(true)
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_historial_cliente
boolean visible = false
integer x = 27
integer y = 192
integer width = 73
integer height = 48
long backcolor = 12639424
end type

type st_sel_marca from statictext within w_historial_cliente
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

type ddlb_1 from dropdownlistbox within w_historial_cliente
boolean visible = false
integer x = 2240
integer y = 1388
integer width = 754
integer height = 244
integer taborder = 51
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

type cb_consultar from commandbutton within w_historial_cliente
integer x = 3506
integer y = 32
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
string text = "Consultar"
boolean default = true
end type

event clicked;string ls_producto, ls_cuenta, ls_nombre, ls_filter
integer li_existencias, li_ultima_venta
datetime ldt_inicio, ldt_fin
long	ll_cliente
Decimal{2} ld_valor1, ld_valor2, ld_total, ld_total_gramos, ld_corriente, ld_corriente_gramos
dw_1.accepttext()
ll_cliente  = dw_1.getitemnumber(1,'cliente')
if ll_cliente = 0 or isnull(ll_cliente) then 
	gf_mensaje('','Debe seleccionar un cliente, Verifique !!!',1,1,'E')
	return
end if
//str.frame.setredraw(false)

ldt_inicio  = dw_1.getitemdatetime(1,'fecha1')
ldt_fin	   = dw_1.getitemdatetime(1,'fecha2')

dw_1.setitem(1,'producto','')
dw_1.setitem(1,'modelo','')

if dw_1.getitemstring(1,'cuenta') = '99999' then
	if dw_1.getitemstring(1,'nombre') = '' or isnull(dw_1.getitemstring(1,'nombre')) then
		
		return
	end if
end if

if dw_2.retrieve(str.g_financiero, str.empresa, ll_cliente, ldt_inicio, ldt_fin) = 0 then			
	dw_2.insertrow(1)
	dw_2.setitem(1,'facd_codigo_item',ls_producto)
else
	if dw_1.getitemnumber(1,'costo') = 1 and dw_1.getitemnumber(1,'en_letra') = 1 then
		wf_costo_en_letra()
	end if
end if
//Filtra por Existencias o Ultima Venta
li_existencias = dw_1.getitemnumber(1,'existentes')
if li_existencias = 1 then
	if len(ls_filter) = 0 then
		ls_filter = 'disponible > 0'
	else
		ls_filter = ls_filter + ' and disponible > 0'
	end if
end if		

li_ultima_venta = dw_1.getitemnumber(1,'ultima_venta')
if li_ultima_venta = 1 then
	if len(ls_filter) = 0 then
		ls_filter = 'mostrar_ultimo = 1'
	else
		ls_filter = ls_filter + ' and mostrar_ultimo = 1'
	end if
end if		

if len(ls_filter) = 0 then
	dw_2.setfilter('')
else
	dw_2.setfilter(ls_filter)
end if
dw_2.filter()


ls_cuenta = idwc_cliente.getitemstring(idwc_cliente.getrow(),'clie_ref_anterior')
if ls_cuenta = '99999' then
	ls_nombre = dw_1.getitemstring(1,'nombre')
else
	ls_nombre = idwc_cliente.getitemstring(idwc_cliente.getrow(),'terc_descripcion')
end if
dw_3.object.cliente.expression = "'"+ ls_nombre + " - "+ls_cuenta+"'"

//str.frame.setredraw(true)
end event

type cb_2 from commandbutton within w_historial_cliente
integer x = 3858
integer y = 32
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

type dw_2 from datawindow within w_historial_cliente
integer x = 27
integer y = 248
integer width = 5042
integer height = 2232
integer taborder = 11
boolean bringtotop = true
string title = "none"
string dataobject = "dw_consulta_historial_cliente"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto
integer li_pos 

this.Setredraw(false)

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if right(ls_objeto,2)='_t' then

	ls_objeto = left(ls_objeto,len(ls_objeto)-2)
	
	if ls_objeto = is_ultima_ or is_ultima_ = "" then	//Si es la misma columna 
																	// o si es la primera vez
		if is_orden_  = "" or is_orden_ = "D" then
			is_orden_ = 'A'		
			this.SetSort(ls_objeto+" A")	//Ordena Ascendente
			this.sort()		
		else
			is_orden_ = 'D'					
			this.SetSort(ls_objeto+" D")	//Ordena Descendente
			this.sort()				
		end if	
		is_ultima_ = ls_objeto		
	else				
			is_orden_ = 'A'
			this.SetSort(ls_objeto+" A")
			this.sort()
			is_ultima_ = ls_objeto
	end if

end if

this.Setredraw(true)
end event

event retrieveend;long i, ll_total, ll_encontro, ll_siguiente, ll_disponible
integer li_encontro
string ls_producto, ls_find, ls_factura, ls_modelo

ll_total = rowcount

this.setsort('fact_fecha D, left(facd_codigo_item,5), fact_fecha_creacion')
this.sort()

for i = 1 to ll_total
	yield()
	str.frame.setmicrohelp('Procesando el Registro '+string(i)+' de '+string(ll_total))
	//if i = 1 then
		ll_siguiente = i + 1
	//end if
	ll_disponible = this.getitemnumber(i,'disponible')
	ls_producto  = this.getitemstring(i,'facd_codigo_item')
	ls_factura	= this.getitemstring(i,'fact_no_factura')
	
	ls_find = "left(facd_codigo_item,5) = '"+left(ls_producto,5)+"' and fact_no_factura <> '"+ls_factura+"'"
	
	ll_encontro = 0
	if ll_siguiente <= ll_total then ll_encontro = this.find(ls_find,ll_siguiente, ll_total)
		
	if ll_encontro > 0 then
		//this.deleterow(ll_encontro)
		//i --
		//ll_total --
		this.setitem(ll_encontro,'mostrar_ultimo',0)
	end if
	if ll_disponible <= 0 then
		if dw_4.retrieve(str.g_financiero, str.empresa,mid(ls_producto,1,5)+'%') > 0 then		
			li_encontro = this.find('left(facd_codigo_item,5) = "'+left(ls_producto,5)+'"',1,this.rowcount())
		//	if li_encontro > 0 and li_encontro <> i then
				this.setitem(i,'es_familia',1)
				this.setitem(i,'existencia',dw_4.getitemnumber(1,'existencia'))
				this.setitem(i,'reserva',dw_4.getitemnumber(1,'reserva'))
				this.setitem(i,'disponible',dw_4.getitemnumber(1,'disponible'))
				this.setitem(i,'facd_codigo_item',dw_4.getitemstring(1,'inmprodu_prod_producto'))
				this.setitem(i,'prod_producto_dos',dw_4.getitemstring(1,'prod_producto_dos'))
				//this.setitem(i,'facd_costo_cif',dw_4.getitemnumber(1,'prod_costo_promedio'))
		//	end if			
		end if
	end if
next
str.frame.setmicrohelp('Hymsoft')
this.setsort('fact_fecha D, prod_producto_dos')
this.sort()

end event

event sqlpreview;string ls_sintax, ls_cuenta, ls_nombre
ls_cuenta = dw_1.getitemstring(1,'cuenta')
ls_nombre = dw_1.getitemstring(1,'nombre')
if ls_cuenta = '99999' and len(ls_nombre) > 0 then
	ls_sintax = sqlsyntax
	ls_sintax = ls_sintax + ' and ( fact_a_nombre = "'+ls_nombre+'") '
	this.setsqlpreview(ls_sintax)
end if
end event

type uo_1 from u_ddcalen within w_historial_cliente
boolean visible = false
integer x = 1966
integer y = 128
integer taborder = 21
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;dw_1.SetItem ( dw_1.getrow(), 'fecha1', uo_1.return_sel_date() )

if uo_1.allow_close then
	this.visible=false
	dw_1.SetFocus()
end if


end event

on uo_1.destroy
call u_ddcalen::destroy
end on

type uo_2 from u_ddcalen within w_historial_cliente
boolean visible = false
integer x = 2693
integer y = 128
integer taborder = 31
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;dw_1.SetItem ( dw_1.getrow(), 'fecha2', uo_2.return_sel_date() )

if uo_2.allow_close then
	this.visible=false
	dw_1.SetFocus()
end if


end event

on uo_2.destroy
call u_ddcalen::destroy
end on

type pb_1 from picturebutton within w_historial_cliente
integer x = 4261
integer y = 36
integer width = 110
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "Print!"
alignment htextalign = left!
end type

event clicked;dw_3.visible = true
OpenWithParm(w_dw_print_options, dw_3)
If Message.DoubleParm = -1 Then Return
dw_3.Print(True)
end event

type dw_3 from datawindow within w_historial_cliente
boolean visible = false
integer x = 155
integer y = 288
integer width = 4046
integer height = 1952
integer taborder = 11
string dragicon = "AppIcon!"
boolean bringtotop = true
boolean titlebar = true
string title = "Reporte Historial de Ventas"
string dataobject = "dw_reporte_historial_cliente"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
string icon = "AppIcon!"
boolean livescroll = true
end type

type dw_4 from datawindow within w_historial_cliente
boolean visible = false
integer x = 105
integer y = 632
integer width = 5042
integer height = 2232
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "dw_consulta_historial_cliente_familias"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

