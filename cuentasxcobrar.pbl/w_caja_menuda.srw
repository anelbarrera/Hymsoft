//objectcomments Caja Menuda
forward
global type w_caja_menuda from w_fa_padre_reportes
end type
type st_sel_marca from statictext within w_caja_menuda
end type
type dw_2 from datawindow within w_caja_menuda
end type
type pb_1 from picturebutton within w_caja_menuda
end type
type cb_1 from commandbutton within w_caja_menuda
end type
type pb_2 from picturebutton within w_caja_menuda
end type
type dw_3 from datawindow within w_caja_menuda
end type
type uo_1 from u_ddcalen within w_caja_menuda
end type
type uo_2 from u_ddcalen within w_caja_menuda
end type
end forward

global type w_caja_menuda from w_fa_padre_reportes
integer x = 0
integer y = 0
integer width = 1317
integer height = 2536
string title = "Caja Menuda"
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 12639424
st_sel_marca st_sel_marca
dw_2 dw_2
pb_1 pb_1
cb_1 cb_1
pb_2 pb_2
dw_3 dw_3
uo_1 uo_1
uo_2 uo_2
end type
global w_caja_menuda w_caja_menuda

type variables
datawindowchild idwc_cliente, idwc_producto

end variables

forward prototypes
public function boolean wf_saldo_anterior (datetime adt_fecha_inicio)
public function boolean wf_ingresos (datetime adt_fecha_caja, datetime adt_fecha_fin)
public function boolean wf_egresos (datetime adt_fecha_caja, datetime adt_fecha_fin)
end prototypes

public function boolean wf_saldo_anterior (datetime adt_fecha_inicio);//Recupera el saldo anterior
decimal{2} ld_saldo
 DECLARE caja CURSOR FOR  
  SELECT cajamenuda.caja_saldo_actual  
    FROM cajamenuda  
   WHERE ( cajamenuda.caja_g_financiero = :str.g_financiero ) AND  
         ( cajamenuda.caja_empresa = :str.empresa ) AND  
         ( cajamenuda.caja_fecha_cierre < :adt_fecha_inicio ) AND
			( cajamenuda.caja_fecha_cierre >= dateadd(dd,-7,:adt_fecha_inicio ))
			order by caja_fecha_cierre desc ;
		if sqlca.sqlcode = -1 then
			gf_mensaje("","Error al declarar el Cursor "+sqlca.sqlerrtext,1,1,'E')
		end if
		
	 OPEN caja;
	 
	 if sqlca.sqlcode = -1 then
		gf_mensaje("","Error al Abrir el Cursor "+sqlca.sqlerrtext,1,1,'E')
	 end if

	fetch caja into :ld_saldo;
	
	if ld_saldo <> 0 then
		dw_2.setitem(1,'caja_saldo',ld_saldo)
	end if

	close caja;
	
return true
end function

public function boolean wf_ingresos (datetime adt_fecha_caja, datetime adt_fecha_fin);decimal{2} ld_efectivo, ld_tarjeta, ld_cheque, ld_vuelto, ld_transferencia

  SELECT isnull(sum(movi_efectivo),0),   
         isnull(sum(movi_cheque),0),   
         isnull(sum(movi_tarjeta),0) - isnull(sum(movi_comision),0),   
         isnull(sum(movi_vuelto),0) ,
	    isnull(sum(movi_transferencia),0)
    INTO :ld_efectivo,   
         :ld_cheque,   
         :ld_tarjeta,   
         :ld_vuelto,
		:ld_transferencia
    FROM cctmovim  
   WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
         ( cctmovim.movi_empresa = :str.empresa ) AND  
         ( cctmovim.movi_aplicacion = 'CC' ) AND  
         ( cctmovim.movi_tipo_transaccion = 'RC' ) AND  
         ( cctmovim.movi_fecha_tran >= :adt_fecha_caja ) AND
         ( cctmovim.movi_fecha_tran <= :adt_fecha_fin ) ;			
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al recuperar los ingresos '+sqlca.sqlerrtext,1,1,'E')
				return false
			end if

			dw_2.setitem(1,'caja_ing_efectivo',ld_efectivo + ld_transferencia)
			dw_2.setitem(1,'caja_ing_cheque',ld_cheque)
			dw_2.setitem(1,'caja_ing_tarjeta',ld_tarjeta)
			dw_2.setitem(1,'caja_ing_vuelto',ld_vuelto)

return true

end function

public function boolean wf_egresos (datetime adt_fecha_caja, datetime adt_fecha_fin);decimal{2} ld_efectivo, ld_tarjeta, ld_cheque

//  SELECT isnull( sum(deta_efectivo) ,0),   
//         isnull( sum(deta_cheque) ,0),   
//         isnull( sum(deta_tarjeta) ,0)  
//    INTO :ld_efectivo,   
//         :ld_cheque,   
//         :ld_tarjeta  
//    FROM badetalledep,   
//         batdiari  
//   WHERE ( batdiari.btdi_g_financiero = badetalledep.deta_g_financiero ) and  
//         ( batdiari.btdi_empresa = badetalledep.deta_empresa ) and  
//         ( batdiari.btdi_transaccion = badetalledep.deta_tipo_transaccion ) and  
//         ( batdiari.btdi_sub_trans = badetalledep.deta_sub_transaccion ) and  
//         ( batdiari.btdi_no_documento = badetalledep.deta_documento ) and  
//         ( batdiari.btdi_ano = badetalledep.deta_anno ) and  
//         ( batdiari.btdi_banco = badetalledep.deta_banco ) and  
//         ( batdiari.btdi_no_cuenta = badetalledep.deta_cuenta ) and  
//         ( ( batdiari.btdi_g_financiero = :str.g_financiero ) AND  
//         ( batdiari.btdi_empresa = :str.empresa ) AND  
//         ( batdiari.btdi_transaccion = 'SD' ) AND  
//         ( batdiari.btdi_sub_trans = '0' ) AND  
//         ( batdiari.btdi_fecha_trans >= :adt_fecha_caja ) AND  
//         ( batdiari.btdi_fecha_trans <= :adt_fecha_fin ) AND  
//         ( batdiari.btdi_estado = 'I' ));

  SELECT //isnull(sum(movi_monto),0)
         isnull(sum(movi_efectivo),0),   
         isnull(sum(movi_cheque),0)
    INTO :ld_efectivo,   
         :ld_cheque   
 //        :ld_tarjeta
    FROM cctmovim  
   WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
         ( cctmovim.movi_empresa = :str.empresa ) AND  
         ( cctmovim.movi_aplicacion = 'CC' ) AND  
         ( cctmovim.movi_tipo_transaccion = 'ND' ) AND  
			( cctmovim.movi_sub_transaccion = '0' ) AND  
         ( cctmovim.movi_fecha_tran >= :adt_fecha_caja ) AND
         ( cctmovim.movi_fecha_tran <= :adt_fecha_fin ) ;			
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al recuperar los ingresos '+sqlca.sqlerrtext,1,1,'E')
				return false
			end if


			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al recuperar los Egresos '+sqlca.sqlerrtext,1,1,'E')
				return false
			end if

			dw_2.setitem(1,'caja_egre_efectivo',ld_efectivo)
			dw_2.setitem(1,'caje_egre_cheque',ld_cheque)
			dw_2.setitem(1,'caja_egre_tarjeta',ld_tarjeta)

return true

end function

on w_caja_menuda.create
int iCurrent
call super::create
this.st_sel_marca=create st_sel_marca
this.dw_2=create dw_2
this.pb_1=create pb_1
this.cb_1=create cb_1
this.pb_2=create pb_2
this.dw_3=create dw_3
this.uo_1=create uo_1
this.uo_2=create uo_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_sel_marca
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.pb_2
this.Control[iCurrent+6]=this.dw_3
this.Control[iCurrent+7]=this.uo_1
this.Control[iCurrent+8]=this.uo_2
end on

on w_caja_menuda.destroy
call super::destroy
destroy(this.st_sel_marca)
destroy(this.dw_2)
destroy(this.pb_1)
destroy(this.cb_1)
destroy(this.pb_2)
destroy(this.dw_3)
destroy(this.uo_1)
destroy(this.uo_2)
end on

event ue_post_open;//Override
datetime ldt_inicio, ldt_fin
integer li_caja_cerrada
decimal{2} ld_saldo
//override
if dw_2.rowcount() > 0 then
	ldt_inicio = dw_2.getitemdatetime(1,'caja_fecha_inicio')
	ldt_fin	  = ldt_inicio	
else
	ldt_inicio = datetime(date(gf_fecha_serv()))
	ldt_fin	  = ldt_inicio
end if
if dw_2.retrieve(str.g_financiero, str.empresa, 1, ldt_inicio) = 0 then
	dw_2.insertrow(1)
	dw_2.setitem(1,'caja_fecha_inicio',ldt_inicio)
	dw_2.setitem(1,'caja_fecha_cierre',ldt_fin)	
	dw_2.setitem(1,'caja_g_financiero', str.g_financiero)
	dw_2.setitem(1,'caja_empresa', str.empresa)
	dw_2.setitem(1,'caja_id',1)
	dw_2.setitem(1,'caja_cerrada',0)	
	wf_ingresos(ldt_inicio, ldt_fin)
	wf_egresos(ldt_inicio, ldt_fin)	
	wf_saldo_anterior(ldt_inicio)
else
	li_caja_cerrada = dw_2.getitemnumber(1,'caja_cerrada')
	ldt_fin	  		 = dw_2.getitemdatetime(1,'caja_fecha_cierre')	
	if li_caja_cerrada = 0 then
		wf_ingresos(ldt_inicio, ldt_fin)
		wf_egresos(ldt_inicio, ldt_fin)		
		wf_saldo_anterior(ldt_inicio)		
		ld_saldo	= dw_2.getitemnumber(1,'tot_final')		
		dw_2.setitem(1,'caja_saldo_actual',ld_saldo)
	end if
end if

if dw_2.update() = -1 then
	gf_mensaje('','Verifique los valores '+sqlca.sqlerrtext,1,1,'E')
end if
end event

event resize;//Override
//this.SetRedraw(false)
//dw_1.width  = this.width  - 99
//dw_1.height = this.height - 278
//dw_2.height = this.height - 478
//
//this.SetRedraw(true)
//
end event

event open;//Override

this.y = 0
this.x = 805
//this.width = 3660

dw = dw_2
dw_impresion = dw_2
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
//This.SetToolbar(1,true,AlignatTop!)
//This.SetToolbarPos(1,1,50,false)

str.frame.SetRedraw ( True )

This.Icon = str.icono
this.postevent("ue_post_open")

end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_caja_menuda
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_caja_menuda
boolean visible = false
integer x = 32
integer y = 1384
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_caja_menuda
boolean visible = false
integer x = 27
integer y = 28
integer width = 3323
integer height = 144
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
	CASE 'cctmovim_movi_a_nombre'
		this.Modify("cctmovim_movi_a_nombre.Font.Underline='1'")
		this.Modify("cctmovim_movi_a_nombre.Color='7536640'")

	CASE ELSE
		this.Modify("cctmovim_movi_a_nombre.Font.Underline='0'")
		this.Modify("cctmovim_movi_a_nombre.Color='0'")

END CHOOSE
end event

event dw_1::clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto, ls_column
integer li_pos 

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

ls_column = dwo.name

if ls_column = 'cctmovim_movi_a_nombre' then
	str_cc_formatos str_formato1		
	str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	str_formato1.tercero = dw_1.getitemNumber(1,"cctmovim_movi_tercero")
	OpenSheetwithparm(w_mant_clientes,str_formato1,parent,2, Original!)
	
end if
end event

event dw_1::buttonclicked;call super::buttonclicked;//busqueda
long ll_codigo
integer li_encontro	
String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error
integer li_c, li_b
long    ll_lter

Datawindow        dww
str_dg_dynamic_find	lstr_df

if dwo.name = 'b_cliente' then
	
		lstr_df.texto_campo [1,1] = "ccmclien.clie_ref_anterior" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [1,2] = "Cuenta"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '450'
		lstr_df.texto_campo [2,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [2,2] = "Descripción"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '700'		
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
					"WHERE ( dgmterce.terc_pais *= dgapais.pais_pais ) and  " +&				
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
	dw_1.setitem(1,'cuenta', idwc_cliente.getitemstring(idwc_cliente.getrow(),'clie_ref_anterior'))
	dw_1.setcolumn('cliente')

elseif dwo.name = 'b_producto' then

	lstr_df.texto_campo [1,1] = "inmprodu.prod_producto"
	lstr_df.texto_campo [1,2] = "Referencia"
	lstr_df.texto_campo [1,3] = "prod_producto"
	lstr_df.texto_campo [1,4] = 'V'
//	lstr_df.texto_campo [1,5] = '280'	
	lstr_df.texto_campo [2,1] = "inmprodu.prod_descripcion"
	lstr_df.texto_campo [2,2] = "Descripcion"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '770'
	lstr_df.tabla = " inmprodu "
		
	lstr_df.tabla_where = &
				"WHERE (inmprodu.prod_g_financiero = " + string(str.g_financiero) + ") and " +&
						 "(inmprodu.prod_empresa = " + string(str.empresa) + ") "	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm
	
	If len (ls_find) = 0 Then Return
		
	ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo1,"'"," ")
	ls_codigo1 = Trim(ls_codigo1)
	this.setitem(this.getrow(),'item',ls_codigo1)
	this.setitem(this.getrow(),'producto',ls_codigo1)	
	this.accepttext()

end if
end event

event dw_1::itemchanged;call super::itemchanged;accepttext()
string ls_cuenta
long   ll_tercero, ll_encontro

choose case this.getcolumnname()
	case 'cliente'
		ls_cuenta = idwc_cliente.getitemstring(idwc_cliente.getrow(),'clie_ref_anterior')
		this.setitem(row,'cuenta',ls_cuenta)
		
	case 'cuenta'
		ll_encontro = idwc_cliente.find("clie_ref_anterior = '"+data+"'",1,idwc_cliente.rowcount())
		if ll_encontro > 0 then
			ll_tercero = idwc_cliente.getitemnumber(ll_encontro,'terc_tercero')
			this.setitem(1,'cliente',ll_tercero)
		else
			this.setitem(1,'cliente',0)
		end if
	case 'item'
		this.setitem(1,'producto',data)
	case 'producto'
		this.setitem(1,'item',data)
end choose
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_caja_menuda
boolean visible = false
integer x = 27
integer y = 192
integer width = 73
integer height = 48
long backcolor = 12639424
end type

type st_sel_marca from statictext within w_caja_menuda
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

type dw_2 from datawindow within w_caja_menuda
event ue_microhelp pbm_nchittest
integer x = 32
integer y = 24
integer width = 1239
integer height = 2272
integer taborder = 11
boolean bringtotop = true
string title = "none"
string dataobject = "dw_caja_menuda"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_microhelp;//override
//Para cuando pasa por encima del objeto
//Override
return

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
	CASE 'fact_no_factura'
		this.Modify("fact_no_factura.Font.Underline='1'")
		this.Modify("fact_no_factura.Color='7536640'")
	CASE 'cliente'
		this.Modify("cliente.Font.Underline='1'")
		this.Modify("cliente.Color='7536640'")
	CASE 'cuenta'
		this.Modify("cuenta.Font.Underline='1'")
		this.Modify("cuenta.Color='7536640'")

	CASE ELSE
		this.Modify("fact_no_factura.Font.Underline='0'")
		this.Modify("fact_no_factura.Color='0'")
		this.Modify("cliente.Font.Underline='0'")
		this.Modify("cliente.Color='0'")
		this.Modify("cuenta.Font.Underline='0'")
		this.Modify("cuenta.Color='0'")

END CHOOSE
end event

event clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.
accepttext()
string ls_objeto, ls_column
integer li_pos 
date 	ld_date,ld_ini_date, ld_hoy

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
ls_column = dwo.name


if ls_column = 'fact_no_factura' then

	if row = 0 then return
	
	str_secuencia_doc lstr_sec
	lstr_sec.ano = dw_2.getitemNumber(row,"fact_ann")
	lstr_sec.sec_manual = dw_2.getitemstring(row,"fact_no_factura")

	opensheetwithparm(w_facturas_actualizadas,lstr_sec,str.frame,2,layered!)

elseif ls_column = 'cliente' then
	if dw_2.rowcount() > 0 then
		str_cc_formatos str_formato2		
		str_formato2.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
		str_formato2.tercero = dw_2.getitemNumber(1,"fact_cliente")
		Opensheetwithparm(w_estadocuenta,str_formato2,str.frame,2,original!)
	end if
elseif ls_column = 'cuenta' then
	if dw_2.rowcount() > 0 then	
		str_cc_formatos str_formato3		
		str_formato3.tercero = dw_2.getitemnumber(1,'fact_cliente')
		OpenSheetwithparm(w_mant_clientes,str_formato3,parent,2, Original!)	
	end if
elseif dwo.name='calendario' then
	ld_ini_date=date(dw_2.GetItemDateTime(dw_2.getrow(),"caja_fecha_inicio"))
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
	ld_ini_date=date(dw_2.GetItemDateTime(dw_2.getrow(),"caja_fecha_cierre"))
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

event itemchanged;datetime ldt_inicio, ldt_fin
this.accepttext()
if dwo.name = 'caja_fecha_inicio' then	
	parent.triggerevent('ue_post_open')
elseif dwo.name = 'caja_fecha_cierre' then
	ldt_inicio = dw_2.getitemdatetime(1,'caja_fecha_inicio')
	ldt_fin	  = dw_2.getitemdatetime(1,'caja_fecha_cierre')
	wf_ingresos(ldt_inicio, ldt_fin)
	wf_egresos(ldt_inicio, ldt_fin)	
end if
end event

type pb_1 from picturebutton within w_caja_menuda
integer x = 41
integer y = 2320
integer width = 133
integer height = 112
integer taborder = 11
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "C:\Sistemas\HYMSOFT\Art\dba_cancel.bmp"
alignment htextalign = left!
string powertiptext = "Cerrar la Ventana"
end type

event clicked;parent.triggerevent('close')
end event

type cb_1 from commandbutton within w_caja_menuda
integer x = 343
integer y = 2320
integer width = 571
integer height = 108
integer taborder = 11
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "CIERRE DE CAJA"
end type

event clicked;datetime ldt_fecha, ldt_fecha_cierre
decimal{2} ld_saldo

if gf_mensaje('','Esta seguro de cerrar la Caja ?',2,1,'E') = 2 then return

ldt_fecha	  		= dw_2.getitemdatetime(1,'caja_fecha_inicio')
ldt_fecha_cierre  = dw_2.getitemdatetime(1,'caja_fecha_cierre')
ld_saldo				= dw_2.getitemnumber(1,'tot_final')

//validar si hay diferencia de mas de un dia en las fechas, mande un mensaje de advertencia

  UPDATE cajamenuda  
     SET caja_fecha_cierre = :ldt_fecha_cierre,   
         caja_cerrada 		= 1,   
         caja_saldo_actual = :ld_saldo  
   WHERE ( cajamenuda.caja_g_financiero = :str.g_financiero ) AND  
         ( cajamenuda.caja_empresa = :str.empresa ) AND  
         ( cajamenuda.caja_id = 1 ) AND  
         ( cajamenuda.caja_fecha_inicio = :ldt_fecha ) ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Actualizar cierre '+sqlca.sqlerrtext,1,1,'E')
			rollback;
		end if

  UPDATE cctmovim  
     SET movi_cierre_mensual = 'S'  
   WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
         ( cctmovim.movi_empresa = :str.empresa ) AND  
         ( cctmovim.movi_fecha_tran = :ldt_fecha )  ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Actualizar cierre en el Movimiento '+sqlca.sqlerrtext,1,1,'E')
			rollback;
		end if

commit;
		
parent.triggerevent('ue_post_open')
end event

type pb_2 from picturebutton within w_caja_menuda
integer x = 1120
integer y = 2320
integer width = 133
integer height = 116
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "C:\Sistemas\HYMSOFT\Art\PRNBATCH.BMP"
alignment htextalign = left!
string powertiptext = "Informe de Caja"
end type

event clicked;string ls_empresa, ls_titulo
datetime ldt_inicio
ldt_inicio = dw_2.getitemdatetime(1,'caja_fecha_inicio')

if dw_3.retrieve(str.g_financiero, str.empresa, 1, ldt_inicio) = 0 then return

ls_empresa = gf_dg_nombre_empresa()
ls_titulo = 'INFORME DE CAJA DEL '+string(ldt_inicio,'dd/mm/yyyy')
dw_3.object.empresanom.expression = "'"+ls_empresa+"'"
dw_3.Object.datawindow.print.preview = true
dw_3.object.titulo_fecha.expression = "'"+ls_titulo+"'"

OpenWithParm(w_dw_print_options, dw_3)

If Message.DoubleParm = -1 Then Return
dw_3.Print(True)

end event

type dw_3 from datawindow within w_caja_menuda
boolean visible = false
integer x = 69
integer y = 376
integer width = 379
integer height = 396
integer taborder = 11
boolean bringtotop = true
string title = "none"
string dataobject = "dw_caja_menuda_print"
boolean livescroll = true
end type

type uo_1 from u_ddcalen within w_caja_menuda
boolean visible = false
integer x = 320
integer y = 132
integer taborder = 11
boolean bringtotop = true
end type

on uo_1.destroy
call u_ddcalen::destroy
end on

event ue_clicked;call super::ue_clicked;dw_2.SetItem ( dw_2.getrow(), 'caja_fecha_inicio', uo_1.return_sel_date() )

if uo_1.allow_close then
	this.visible=false
	dw_2.SetFocus()
end if


end event

event destructor;call super::destructor;call u_ddcalen::destroy
end event

type uo_2 from u_ddcalen within w_caja_menuda
boolean visible = false
integer x = 421
integer y = 1452
integer taborder = 21
boolean bringtotop = true
end type

on uo_2.destroy
call u_ddcalen::destroy
end on

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;dw_2.SetItem ( dw_2.getrow(), 'caja_fecha_cierre', uo_2.return_sel_date() )

if uo_2.allow_close then
	this.visible=false
	dw_2.SetFocus()
end if


end event

