//objectcomments Reporte de Transacciones de cuentas por cobrar
forward
global type w_reporte_transacciones_cc from w_cc_padre_reporte
end type
end forward

global type w_reporte_transacciones_cc from w_cc_padre_reporte
string tag = "m_cc_principal_listados"
integer width = 3570
integer height = 1632
string title = "Informe de Pagos"
string menuname = "m_cc_principal_listados"
boolean resizable = true
windowtype windowtype = main!
long backcolor = 12639424
end type
global w_reporte_transacciones_cc w_reporte_transacciones_cc

type variables
str_rangofecha lstr_rangfech, istr_rangfech
end variables

forward prototypes
public subroutine wf_actualiza_antiguedad (string idioma)
end prototypes

public subroutine wf_actualiza_antiguedad (string idioma);Integer  li_registros, li_i, li_empresa, li_grupofin, li_emp, li_dberror, &
         li_tipo, li_socio, li_audit
decimal  ld_x, ld_y, ld_monto
string   ls_db_err,ls_where_select, ls_error
long 		ll_tercero
Datetime ld_tiempo1, ld_tiempo2
Datastore lds_cliente, lds_tercero_empresa, lds_tercero_gf, lds_tercero_pais

DELETE FROM ccatempa
WHERE ( ccatempa.tmpa_g_financiero 	= :str.g_financiero 	) AND  
      ( ccatempa.tmpa_empresa 		= :str.empresa 		) and
		( ccatempa.tmpa_usuario_maquina = :str.maquina 		) ;
if sqlca.sqlcode = -1 then
	messagebox('error','error al elimianr registros desde ccatempa')
end if

DELETE FROM cchestado  
WHERE ( cchestado.est_g_financiero =:str.g_financiero  ) AND  
		( cchestado.est_empresa =:str.empresa  ) AND  
		( cchestado.est_usuario_maquina =:str.maquina  )   ;
if sqlca.sqlcode = -1 then
	mensaje('Error','Error eliminando de cchestado','')
end if

//datastore	lds_tercero_empresa, lds_tercero_gf,lds_cliente, lds_tercero_pais
Datawindowchild ldwc_sub_tran, ldwc_pais, ldwc_region

lds_cliente 			= create ds_dg_import_file
lds_tercero_empresa 	= create ds_dg_import_file
lds_tercero_gf 		= create ds_dg_import_file
lds_tercero_pais	 	= create ds_dg_import_file


lds_cliente.dataobject = 'dw_cc_inf_terceros_rango_1_nom'
//****************

lds_cliente.settransobject(sqlca)

istr_rangfech =  lstr_rangfech
ld_tiempo1 = Datetime(istr_rangfech.fecha1,00:00:00)
ld_tiempo2 = Datetime(istr_rangfech.fecha2,00:00:00)

//lstr_rangfech.tip_cliente = il_tip_cliente

CHOOSE CASE istr_rangfech.opcion
	CASE 'P' //Por Cliente 
			
		//**filtra el dw por tipo de cliente
		if lstr_rangfech.tip_cliente = 'P' then
			if not isnull(istr_rangfech.tipo_cliesp) then li_tipo = 1
			if not isnull(istr_rangfech.tipo_socio)  then li_socio = 1
			if not isnull(istr_rangfech.tipo_auditor) then li_audit = 1
		
			if li_tipo = 1 then
				lds_cliente.setfilter("ccmclien_clie_clasificacion="+string(lstr_rangfech.tipo_cliesp))
				lds_cliente.filter()
			elseif li_socio = 1 then
				lds_cliente.setfilter("clie_socio="+string(lstr_rangfech.tipo_socio))
				lds_cliente.filter()
			elseif li_audit = 1 then
				lds_cliente.setfilter("clie_auditor="+string(lstr_rangfech.tipo_auditor))
				lds_cliente.filter()
			end if
						
		elseif lstr_rangfech.tip_cliente = 'T' then
			lds_cliente.Setfilter('')
			lds_cliente.filter()
		end if
      //***

			lds_cliente.retrieve(str.g_financiero,str.empresa,istr_rangfech.nombre1,istr_rangfech.nombre2)
			li_registros = lds_cliente.rowcount()
			
			ls_where_select="( terc_descripcion + convert(char(5),dgmterce.terc_tercero) between '"+lstr_rangfech.nombre1+"' and '"+lstr_rangfech.nombre2+"' )"
		
		for li_i = 1 to li_registros 
			//ole_1.object.value 	= (li_i/lds_cliente.rowcount()) * 100		
			//valida que el cliente sea visible, si no tiene permisos, que se devuelva
				ll_tercero 				= lds_cliente.getitemnumber(li_i,"ccmclien_clie_tercero")										
				gf_antiguedad_x_cliente(ld_tiempo2, ll_tercero,idioma,ld_tiempo1)
				istr_rangfech.tipo_antig = 'N'
		next
		//ole_1.visible = false

END CHOOSE

//ole_1.visible = false

IF ISVALID(lds_cliente)  THEN
	DESTROY lds_cliente
END IF
commit using sqlca;
return;
end subroutine

on w_reporte_transacciones_cc.create
call super::create
if this.MenuName = "m_cc_principal_listados" then this.MenuID = create m_cc_principal_listados
end on

on w_reporte_transacciones_cc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event resize;//Override
this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 278
gb_1.width  = this.width  - 60
gb_1.height = this.height - 200


st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180
this.SetRedraw(true)
end event

event ue_reg_anterior;//Override
dw.ScrollPriorPage( )
end event

event ue_siguiente_reg;call super::ue_siguiente_reg;//Override
dw.scrollNextpage()
end event

event ue_post_open;call super::ue_post_open;datetime ld_fecha1, ld_fecha2
integer li_grupo
string ls_empresa, ls_grupo, ls_tran
date ldt_fecha_anterior
decimal{2} ld_saldo_anterior

ls_empresa = gf_dg_nombre_empresa()

lstr_rangfech = message.powerObjectParm

select max(mser_descripcion) into :ls_tran from dgmserie where 
mser_g_financiero = : str.g_financiero and mser_empresa = : str.empresa and mser_tipo_transaccion = :lstr_rangfech.movimiento ;
if sqlca.sqlcode = -1 then
	gf_mensaje('','Error al seleccionar descripcion de la transaccion',1,1,'E')
end if

//Cambia DAtaWindow
if lstr_rangfech.tipo_reporte = 0 then
	choose case lstr_rangfech.movimiento
		case 'RC'
			if lstr_rangfech.opcion = 'V' then
				dw.Dataobject = 'dw_cobros_vendedor'
				this.title = 'Informe de Pagos por Vendedor'
			elseif lstr_rangfech.opcion = 'P' then
				dw.Dataobject = 'dw_cobros_pais'
				this.title = 'Informe de Pagos por Pais'
			else
				if lstr_rangfech.opcion_reporte = 'TODOS' then
					dw.Dataobject = 'dw_reporte_de_pagos_todos' 
					this.title = 'Informe de Pagos'
				else
					dw.Dataobject = 'dw_reporte_de_pagos'
					this.title = 'Informe de Pagos'
				end if
			end if
		case	else
			dw.Dataobject = 'dw_reporte_de_nd'
			if lstr_rangfech.opcion = 'P' then
				dw.Dataobject = 'dw_reporte_de_nd_pais'
			end if
			this.title = 'INFORME DE ' + ls_tran
	end choose
else
	if lstr_rangfech.opcion = 'B' then
		//dw_reporte_de_movimientos_cxc
		dw.dataobject = 'dw_cc_rep_balance_prueba'
		this.title = 'Balance de Prueba Cuentas por Cobrar'
	Elseif lstr_rangfech.opcion = 'M' then
		dw.dataobject = 'dw_reporte_de_movimientos_cxc'
		this.title = 'Movimiento General de Cuentas por Cobrar'
	else
		dw.dataobject = 'dw_reporte_de_transacciones_cxc'
		this.title = 'Informe de Transacciones'
	end if
end if
dw.SettransObject(sqlca)
ld_fecha1 = datetime(lstr_rangfech.fecha1)
ld_fecha2 = datetime(lstr_rangfech.fecha2)
dw.Object.datawindow.print.preview = true
if lstr_rangfech.opcion = 'V' or lstr_rangfech.tipo_reporte = 1 then
	dw.retrieve(str.g_financiero,str.empresa, ld_fecha1, ld_fecha2)
	if lstr_rangfech.opcion = 'M' and dw.rowcount() > 0 then
		ld_saldo_anterior = gf_saldo_anterior_global(ld_fecha1, str.g_financiero, str.empresa )	
		if ld_saldo_anterior <> 0 then
			dw_1.RowsCopy(1, 1, Primary!, dw_1, 1, Primary!)
			ldt_fecha_anterior = RelativeDate(date(ld_fecha1), -1)
			if ld_saldo_anterior > 0 then
				dw_1.setitem(1,'debito',ld_saldo_anterior)
				dw_1.setitem(1,'credito',0.00)
			else
				dw_1.setitem(1,'credito',abs(ld_saldo_anterior))						
				dw_1.setitem(1,'debito',0.00)
			end if
			dw_1.setitem(1,'ccmclien_clie_ref_anterior','')
			dw_1.setitem(1,'movi_documento','')
			dw_1.setitem(1,'cctmovim_movi_tercero',0)			
			dw_1.setitem(1,'cctmovim_movi_historica','')			
			dw_1.setitem(1,'movi_tipo_transaccion	','')			
			dw_1.setitem(1,'cctmovim_movi_fecha_tran',ldt_fecha_anterior)
			dw_1.setitem(1,'dgmterce_terc_descripcion','SALDO ANTERIOR:')			
		end if
	end if
else
	dw.retrieve(str.g_financiero,str.empresa, ld_fecha1, ld_fecha2, lstr_rangfech.movimiento, ls_tran)	
	if lstr_rangfech.opcion = 'P' and lstr_rangfech.resumido = 1 then //and ( ls_tran = 'RC' or ls_tran = 'NC' or ls_tran = 'ND' )then
		dw.Modify("DataWindow.Detail.Height='0'")
		dw.Modify("DataWindow.Header.2.Height='0'")
		dw.Modify("DataWindow.Trailer.2.Height='0'")
	end if
end if

//filtra por clienteif 
if lstr_rangfech.cliente <> 0 then
	dw.setfilter('cctmovim_movi_tercero = '+string(lstr_rangfech.cliente))
	dw.filter()
	dw.groupcalc()
elseif lstr_rangfech.tipo_cliesp <> 99 then
	dw.setfilter('clie_clasificacion = '+string(lstr_rangfech.tipo_cliesp))
	dw.filter()
	dw.groupcalc()
end if

//dw.object.grupo.expression = "'"+ls_grupo+"'"
dw.object.empresanom.expression = "'"+ls_empresa+"'"
dw.object.rango_fecha.expression = "'"+"Desde el " +gf_fecha_palabras(lstr_rangfech.fecha1)+" al "+gf_fecha_palabras(lstr_rangfech.fecha2)+"'"

//dw.object.rango_fecha.expression = "'"+gf_fecha_palabras(lstr_rangfech.fecha1)+"'"

end event

event ue_zoom_down;call super::ue_zoom_down;//Zoom the display area of the datawindow down//

string ls_factor
integer li_factor
m_cc_principal_listados  lm_menu

//get the current zoom//

ls_factor = dw.object.datawindow.print.preview.zoom
li_factor = integer (ls_factor)

//only zoom down if magnification is greater than 20%//

if li_factor >= 40 and li_factor <= 100 then
	li_factor = li_factor -20
else
	//if magnification is currently 200%, zoom down to 100%
	if li_factor = 200 then
		li_factor = 100
	end if
end if

//set the new zoom level//

dw.object.datawindow.print.preview.zoom = li_factor

//check/uncheck the zoom menu items//
lm_menu = this.menuid

lm_menu.m_ventana.m_zoom.m_20%.checked = false
lm_menu.m_ventana.m_zoom.m_40%.checked = false
lm_menu.m_ventana.m_zoom.m_60%.checked = false
lm_menu.m_ventana.m_zoom.m_80%.checked = false
lm_menu.m_ventana.m_zoom.m_100%.checked = false
lm_menu.m_ventana.m_zoom.m_200%.checked = false

choose case li_factor
	case 20
		lm_menu.m_ventana.m_zoom.m_20%.checked = true
	case 40
		lm_menu.m_ventana.m_zoom.m_40%.checked = true
	case 60
		lm_menu.m_ventana.m_zoom.m_60%.checked = true
	case 80
		lm_menu.m_ventana.m_zoom.m_80%.checked = true
	case 100
		lm_menu.m_ventana.m_zoom.m_100%.checked = true
	case 200
		lm_menu.m_ventana.m_zoom.m_200%.checked = true
end choose

end event

event open;//override

/* Se establece un tamaño especifico para todas las ventanas 
   heredadas de este padre */
//integer i ,ii
sqlca.autocommit = true
this.y=1
this.x=1
//this.width=3000
//this.height=1557
//
if isnull(m_cc_principal_listados) then ChangeMenu(m_cc_principal_listados) 
m_cc_principal_listados.m_archivo.m_guardar.ToolbarItemVisible= false

THIS.SetToolbar(1, true, alignattop!)
THIS.SetToolbarPos(1, 1, 50, false)

This.Icon = str.icono
this.postevent("ue_post_open")
end event

type st_ayuda from w_cc_padre_reporte`st_ayuda within w_reporte_transacciones_cc
end type

type st_nom_ventana from w_cc_padre_reporte`st_nom_ventana within w_reporte_transacciones_cc
boolean visible = false
integer y = 1380
end type

type dw_1 from w_cc_padre_reporte`dw_1 within w_reporte_transacciones_cc
integer x = 27
integer y = 56
integer width = 3465
string dataobject = "dw_reporte_de_pagos"
boolean hscrollbar = false
boolean hsplitscroll = false
end type

event dw_1::sqlpreview;string ls_tipo
choose case lstr_rangfech.opcion_reporte
	case 'EFECTIVO'
		ls_tipo = ' AND cctmovim.movi_efectivo > 0 '
		this.modify('titulo.text="INFORME DE PAGOS - EFECTIVO"')
	case 'CHEQUE'
		ls_tipo = ' AND cctmovim.movi_cheque > 0 '
		this.modify('titulo.text="INFORME DE PAGOS - CHEQUE"')		
	case 'TARJETA'
		ls_tipo = ' AND cctmovim.movi_tarjeta > 0 '
		this.modify('titulo.text="INFORME DE PAGOS - TARJETA"')		
	case 'TRANSFERENCIA'
		ls_tipo = ' AND cctmovim.movi_transferencia > 0 '
		this.modify('titulo.text="INFORME DE PAGOS - TRANSFERENCIA"')
	case else
		ls_tipo = ''
end choose
if len(ls_tipo) > 0 then
	sqlsyntax += lstr_rangfech.cadena + ls_tipo
end if

This.SetSqlPreview(sqlsyntax)
end event

event dw_1::clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto, ls_column, ls_error, ls_nombre
integer li_pos 

ls_objeto = This.GetObjectAtPointer()

li_pos 	 =  Pos(ls_objeto, "~t")
ls_objeto = Left(ls_objeto, li_pos - 1)

if right(ls_objeto,2)='_t' then

	ls_objeto = left(ls_objeto,len(ls_objeto)-2)
	
	if ls_objeto = is_ultima or is_ultima = "" then	//Si es la misma columna 
																	// o si es la primera vez
		if is_orden  = "" or is_orden = "D" then
			is_orden = 'A'		
			this.SetSort(ls_objeto+" A")	//Ordena Ascendente
			this.sort()		
		else
			is_orden = 'D'					
			this.SetSort(ls_objeto+" D")	//Ordena Descendente
			this.sort()				
		end if	
		is_ultima = ls_objeto		
	else				
			is_orden = 'A'
			this.SetSort(ls_objeto+" A")
			this.sort()
			is_ultima = ls_objeto
	end if

end if
ls_column = dwo.name
if ls_column = "movi_documento" then
	
	if row = 0 then return
	
	str_secuencia_doc lstr_sec
	lstr_sec.ano = dw_1.getitemNumber(row,"movi_anno")
	lstr_sec.sec_manual = dw_1.getitemstring(row,"movi_documento")
	lstr_sec.tran	= dw_1.getitemstring(row,"movi_tipo_transaccion")
	lstr_sec.subtran	= dw_1.getitemstring(row,"movi_sub_transaccion")	
	lstr_sec.aplicacion = dw_1.getitemstring(row,"movi_aplicacion")	
	opensheetwithparm(w_consulta_transacciones, lstr_sec,str.frame,2,original!)
	
elseif ls_column = 'dgmterce_terc_descripcion' then
		str_cc_formatos str_formato1		
		str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
		str_formato1.tercero = dw_1.getitemNumber(row,"cctmovim_movi_tercero")
		date ldt_fecha
		ldt_fecha = date(gf_fecha_Serv())
		lstr_rangfech.fecha1 = date(relativedate(date(gf_fecha_serv()), - 120)) //date('01/01/'+string(year(ldt_fecha) - 1 ))
		lstr_rangfech.fecha2 = ldt_fecha
	
		//Elimina las tablas temporales 
	  DELETE FROM ccatpan  
		WHERE ( ccatpan.tpan_g_financiero = :str.g_financiero ) AND  
				( ccatpan.tpan_empresa = :str.empresa ) AND  
				( ccatpan.tpan_maquina = :str.maquina )   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje('Aviso','Error al eliminar ccatpan',ls_error)
			return
		end if
			
		DELETE FROM ccatempa
		WHERE ( ccatempa.tmpa_g_financiero 	= :str.g_financiero 	) AND  
				( ccatempa.tmpa_empresa 		= :str.empresa 		) and
				( ccatempa.tmpa_usuario_maquina = :str.maquina 		) ;
		if sqlca.sqlcode = -1 then
			messagebox('error','error al elimianr registros desde ccatempa')
		end if
		
		  DELETE FROM ccatemaf
			WHERE ( tmaf_g_financiero = :str.g_financiero ) AND  
					( tmaf_empresa = :str.empresa ) AND  
					( tmaf_usuario_maquina = :str.maquina )   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje('Aviso','Error al eliminar ccatemaf',ls_error)
			return
		end if
		
		DELETE FROM cchestado  
		WHERE ( cchestado.est_g_financiero =:str.g_financiero  ) AND  
				( cchestado.est_empresa =:str.empresa  ) AND  
				( cchestado.est_usuario_maquina =:str.maquina  )   ;
		if sqlca.sqlcode = -1 then
			mensaje('Error','Error eliminando de cchestado','')
		end if
	
		lstr_rangfech.opcion = 'P'
		lstr_rangfech.mensaje = "P"
		lstr_rangfech.cadena = "N"
		lstr_rangfech.tipo_orden = 'C'//ruc
		lstr_rangfech.tipo_accion = '1'  //solo con movimientos
		lstr_rangfech.idioma = 'E' // en espanol
		lstr_rangfech.tip_cliente = 'T'//todos
		lstr_rangfech.preimpreso = 'N'//preimpresos
		lstr_rangfech.tipo_fecha  = '2'  
		lstr_rangfech.piepag      = '2'  
		lstr_rangfech.tipocliente = 'N'
		lstr_rangfech.tipo_orden = 'A'
		  SELECT terc_descripcion  
			 INTO :ls_nombre
			 FROM dgmterce  
			WHERE ( dgmterce.terc_tercero = :str_formato1.tercero ) ;

		lstr_rangfech.nombre1 = ls_nombre+string(str_formato1.tercero)
		lstr_rangfech.nombre2 = ls_nombre+string(str_formato1.tercero)
		string ls_ruc
		ls_ruc = dw_1.getitemstring(row,'ccmclien_clie_ref_anterior')
		lstr_rangfech.desdeclienteref = ls_ruc//str_formato1.tercero
		lstr_rangfech.hastaclienteref = ls_ruc//str_formato1.tercero
							
		if not isnull(lstr_rangfech.fecha1) and not isnull(lstr_rangfech.fecha2) or &
				lstr_rangfech.fecha1 <> date('00/00/0000') and lstr_rangfech.fecha2 <> date('00/00/0000')then
				commit using sqlca;
				wf_actualiza_antiguedad('E')
				OpenSheetWithParm(w_estadocuenta_imp,lstr_rangfech,str.frame,2, layered!)			
		end if	

end if
end event

event dw_1::ue_microayuda;//override
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
	CASE 'movi_documento'
		this.Modify("movi_documento.Font.Underline='1'")
		this.Modify("movi_documento.Color='7536640'")
	CASE 'dgmterce_terc_descripcion'
		this.Modify("dgmterce_terc_descripcion.Font.Underline='1'")
		this.Modify("dgmterce_terc_descripcion.Color='7536640'")
	CASE ELSE
		this.Modify("movi_documento.Font.Underline='0'")
		this.Modify("movi_documento.Color='0'")
		this.Modify("dgmterce_terc_descripcion.Font.Underline='0'")
		this.Modify("dgmterce_terc_descripcion.Color='0'")

END CHOOSE
end event

type gb_1 from w_cc_padre_reporte`gb_1 within w_reporte_transacciones_cc
integer y = 4
integer width = 3515
integer height = 1348
long backcolor = 12639424
end type

