//objectcomments Reporte de Transacciones de cuentas por cobrar
forward
global type w_generar_cargos_por_mora from w_cc_padre_reporte
end type
type cb_1 from commandbutton within w_generar_cargos_por_mora
end type
type cb_2 from commandbutton within w_generar_cargos_por_mora
end type
type dw_2 from datawindow within w_generar_cargos_por_mora
end type
end forward

global type w_generar_cargos_por_mora from w_cc_padre_reporte
integer width = 3369
integer height = 2468
string title = "Generacion de Cargos por Morosidad Vencida"
boolean controlmenu = false
boolean resizable = true
windowtype windowtype = main!
long backcolor = 12639424
windowanimationstyle openanimation = centeranimation!
windowanimationstyle closeanimation = centeranimation!
cb_1 cb_1
cb_2 cb_2
dw_2 dw_2
end type
global w_generar_cargos_por_mora w_generar_cargos_por_mora

type prototypes
FUNCTION boolean ShowWindow(ulong hWnd, int nCmdShow) LIBRARY "user32.dll"
FUNCTION boolean LockWindowUpdate(ulong hWndLock) LIBRARY "user32.dll"
end prototypes

type variables
str_rangofecha lstr_rangfech
end variables

forward prototypes
public function boolean wf_antiguedad ()
public function boolean wf_asigna_antig ()
public function string wf_secuencia_tran ()
public function boolean wf_actualiza_antiguedad (datetime adt_desde, datetime adt_hasta, long al_tercero, long al_dias_limite)
end prototypes

public function boolean wf_antiguedad ();long ll_tercero, i, ll_dias
datetime ld_tiempo1, ld_tiempo2, ldt_fecha
date		ldt_fecha_desde, ldt_fecha_hasta
ldt_fecha = gf_fecha_serv()
ldt_fecha_hasta = date(ldt_fecha)
ldt_fecha_desde = relativedate(date(gf_fecha_serv()), - 365)
ld_tiempo1 = Datetime(ldt_fecha_desde,00:00:00)
ld_tiempo2 = Datetime(ldt_fecha_hasta,00:00:00)
str.frame.setmicrohelp('Configurando la Antiguedad')
for i = 1 to dw_2.rowcount()
	yield()
	ll_tercero = dw_2.getitemnumber(i,'clie_tercero')
	ll_dias	  = dw_2.getitemnumber(i,'dias_limite')
	wf_actualiza_antiguedad(ld_tiempo1, ld_tiempo2, ll_tercero, ll_dias)
	str.frame.setmicrohelp('Asignando Saldos   Registro: ' +string(i)+' de ' + string(dw_2.rowcount()))
	wf_asigna_antig()				
next
str.frame.setmicrohelp('Hymsoft')
return true
end function

public function boolean wf_asigna_antig ();string ls_error

  DELETE FROM ccatpan  
   WHERE ( ccatpan.tpan_g_financiero = :str.g_financiero ) AND  
         ( ccatpan.tpan_empresa = :str.empresa ) AND  
         ( ccatpan.tpan_maquina = :str.maquina )   ;
	if sqlca.sqlcode = -1 then
		ls_error = sqlca.sqlerrtext
		rollback;
		mensaje('Aviso','Error al eliminar ccatpan',ls_error)
		return false
	end if
	
	/* Inserta los nuevos valores */ 
  INSERT INTO ccatpan  
         ( tpan_g_financiero,tpan_empresa,tpan_tercero,tpan_saldo_anterior,
           tpan_col1,tpan_col2, tpan_col3,tpan_col4,tpan_col5,tpan_col6,   
           tpan_col7,tpan_col8,  tpan_col9, tpan_col10,tpan_col11,tpan_col12, 
           tpan_col13,tpan_col21,tpan_col1_t,tpan_col2_t,tpan_col3_t,   
           tpan_col4_t, tpan_col5_t,tpan_col6_t,tpan_col7_t,tpan_col8_t,   
           tpan_col9_t,tpan_col10_t,tpan_col11_t,tpan_col12_t,tpan_col13_t,
           tpan_col21_t,tpan_maquina)   
  SELECT ccatempa.tmpa_g_financiero,   
         ccatempa.tmpa_empresa,   
         ccatempa.tmpa_tercero,
			max( case ccatempa.tmpa_orden when 21 then ccatempa.tmpa_saldo_anterior  else ccatempa.tmpa_saldo_anterior end ),
			sum( case ccatempa.tmpa_orden when 1 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 2 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 3 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 4 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 5 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 6 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 7 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 8 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 9 then ccatempa.tmpa_monto else 0 end ),   
			sum( case ccatempa.tmpa_orden when 10 then ccatempa.tmpa_monto else 0 end ),  
			sum( case ccatempa.tmpa_orden when 11 then ccatempa.tmpa_monto else 0 end ),  
			sum( case ccatempa.tmpa_orden when 12 then ccatempa.tmpa_monto else 0 end ),  
			sum( case ccatempa.tmpa_orden when 13 then ccatempa.tmpa_monto else 0 end ),  
			sum( case ccatempa.tmpa_orden when 21 then ccatempa.tmpa_monto else 0 end ),   
         max( case ccatempa.tmpa_orden when 1 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 2 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 3 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 4 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 5 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 6 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 7 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 8 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 9 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 10 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 11 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 12 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 13 then ccatempa.tmpa_descantig  else '' end ),
         max( case ccatempa.tmpa_orden when 21 then ccatempa.tmpa_descantig  else '' end ),
			max(ccatempa.tmpa_usuario_maquina) FROM ccatempa 
WHERE ( ccatempa.tmpa_g_financiero = :str.g_financiero ) AND  
      ( ccatempa.tmpa_empresa = :str.empresa ) and
		( ccatempa.tmpa_usuario_maquina = :str.maquina) and
		( ccatempa.tmpa_maxdias >= tmpa_dias_morosos )
GROUP BY ccatempa.tmpa_g_financiero,   
         ccatempa.tmpa_empresa,   
         ccatempa.tmpa_tercero ;
if sqlca.sqlcode = -1 then
	ls_error = sqlca.sqlerrtext
	rollback;
	mensaje('Aviso ','Error al insertar en ccatpan',ls_error)
	return false
else	
	commit ; 
	//mensaje('','Inserto en CCATPAN','')
	
end if

return true
end function

public function string wf_secuencia_tran ();string ls_sec
long ll_max
integer li_existe, li_ann

li_ann = year(date(gf_fecha_serv()))

select max(convert(numeric(8),mser_secuencia))
into :ll_max
from dgmserie
where mser_g_financiero = :str.g_financiero and
	 	mser_empresa		= :str.empresa and
		mser_tipo_transaccion = 'ND' ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al seleccionar secuencia '+sqlca.sqlerrtext,1,1,'E')
			return ''
		end if
		

	DO WHILE true
		ll_max = ll_max + 1		
		ls_sec = string(ll_max)
		
		select count(*) into :li_existe
		from cctmovim
		where movi_g_financiero = :str.g_financiero and
				movi_empresa		= :str.empresa and
				movi_tipo_transaccion = 'ND' and
				movi_sub_transaccion = 'IN' and
				movi_documento 	=  :ls_sec and
				movi_anno			=  :li_ann ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al validar existencia '+sqlca.sqlerrtext,1,1,'E')
					return ''
				end if
										
			if li_existe = 0 then
				exit
			end if
	LOOP

return ls_sec
end function

public function boolean wf_actualiza_antiguedad (datetime adt_desde, datetime adt_hasta, long al_tercero, long al_dias_limite);
Integer  li_registros, li_i, li_empresa, li_grupofin, li_emp, li_dberror, &
         li_tipo, li_socio, li_audit
decimal  ld_x, ld_y, ld_monto
string   ls_db_err,ls_where_select, ls_error,ls_error_proc
long 		ll_tercero,ll_i,ll_proximo
Datetime ld_tiempo1, ld_tiempo2

DELETE FROM ccatempa
WHERE ( ccatempa.tmpa_g_financiero 	= :str.g_financiero 	) AND  
      ( ccatempa.tmpa_empresa 		= :str.empresa 		) and
		( ccatempa.tmpa_tercero 		= :al_tercero 			) AND
		( ccatempa.tmpa_usuario_maquina = :str.maquina 		) ;
if sqlca.sqlcode = -1 then
	messagebox('error','error al elimianr registros desde ccatempa')
end if

ld_tiempo1 = adt_desde
ld_tiempo2 = adt_hasta

ll_tercero = al_tercero
				
gf_antiguedad_x_cliente_moroso(ld_tiempo2, ll_tercero,'E',ld_tiempo1, al_dias_limite)


return true
end function

on w_generar_cargos_por_mora.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_2
end on

on w_generar_cargos_por_mora.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_2)
end on

event resize;//Override
this.SetRedraw(false)
dw_1.width  = this.width  - 190
dw_1.height = this.height - 478
gb_1.width  = this.width  - 120
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


str.frame.setredraw(true)

ls_empresa = gf_dg_nombre_empresa()

//lstr_rangfech = message.powerObjectParm

//Cambia DAtaWindow
dw.SettransObject(sqlca)
dw_2.SettransObject(sqlca)
//ld_fecha1 = datetime(lstr_rangfech.fecha1)
//ld_fecha2 = datetime(lstr_rangfech.fecha2)
//dw.Object.datawindow.print.preview = true
if dw_2.retrieve(str.g_financiero, str.empresa) > 0 then
	if wf_antiguedad() then
		dw.retrieve(str.g_financiero,str.empresa, str.maquina)
	end if
end if

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
sqlca.autocommit = true
THIS.SetToolbar(1, true, alignattop!)
THIS.SetToolbarPos(1, 1, 50, false)
This.Icon = str.icono
this.y = 0
this.x = 805
this.postevent("ue_post_open")
end event

event closequery;call super::closequery;constant int SW_HIDE = 0
 
ShowWindow(Handle(this), SW_HIDE)
 
end event

event close;call super::close;Window lw_frame

lw_frame = ParentWindow()

If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_sheet_closed")
 End If
end event

type st_ayuda from w_cc_padre_reporte`st_ayuda within w_generar_cargos_por_mora
end type

type st_nom_ventana from w_cc_padre_reporte`st_nom_ventana within w_generar_cargos_por_mora
boolean visible = false
integer y = 1380
end type

type dw_1 from w_cc_padre_reporte`dw_1 within w_generar_cargos_por_mora
integer y = 72
integer width = 3214
integer height = 1936
string dataobject = "dw_clientes_morosos"
boolean hscrollbar = false
boolean hsplitscroll = false
end type

event dw_1::sqlpreview;sqlsyntax += lstr_rangfech.cadena

This.SetSqlPreview(sqlsyntax)
end event

event dw_1::clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto, ls_column
integer li_pos , i, li_valor

ls_column = dwo.name

if ls_column = 'dgmterce_terc_descripcion' then
	if row = 0  then return
	str_cc_formatos str_formato1		
	str_formato1.tipo_bd = Pos(SQLCA.DBMS, "SQL Server")//0 sql
	str_formato1.tercero = dw_1.getitemNumber(row,"clie_tercero")
	Opensheetwithparm(w_estadocuenta,str_formato1,str.frame,2,original!)
elseif ls_column = 'aplicar_t' then
	if this.getitemnumber(1,'aplicar')= 0 then
		li_valor = 1
	else
		li_valor = 0
	end if
	
	for i = 1 to this.rowcount()
		this.setitem(i,'aplicar',li_valor)
	next
	return
end if

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

end event

event dw_1::ue_microayuda;//override

end event

type gb_1 from w_cc_padre_reporte`gb_1 within w_generar_cargos_por_mora
integer y = 4
integer height = 2280
long backcolor = 12639424
end type

type cb_1 from commandbutton within w_generar_cargos_por_mora
integer x = 1230
integer y = 2112
integer width = 357
integer height = 116
integer taborder = 11
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar"
end type

event clicked;integer i, li_ann 
long ll_cliente, ll_secuencia
decimal{2} ld_cargo
string ls_comentario, ls_ruc, ls_error, ls_nombre, ls_secuencia
datetime ldt_fecha, ldt_fechavence

dw_1.setfilter('cargo > 0 and aplicar = 1')
dw_1.filter()

if dw_1.rowcount() = 0 then 
	gf_mensaje('','No ha seleccionado ningun registro, verifique !!!',1,1,'E')	
	dw_1.setfilter('saldo  > 0')
	dw_1.filter()	
	return
end if

if gf_mensaje('','Esta Seguro de Generar los cargos por morosidad ?',2,1,'Q') = 1 then
	sqlca.autocommit = false
	ls_comentario = 'Cargo por morosidad vencida'
	ldt_fecha = datetime(date(gf_fecha_serv()))
	li_ann 	 = year(date(ldt_fecha))
	ldt_fechavence = datetime(relativedate(date(ldt_fecha), 30))
	ls_secuencia = wf_secuencia_tran()	
	
	for i = 1 to dw_1.rowcount()
		dw_1.scrolltorow(i)
		ll_cliente = dw_1.getitemnumber(i,'clie_tercero')
		ls_ruc	  = dw_1.getitemstring(i,'ccmclien_clie_ref_anterior')
		ld_cargo	  = dw_1.getitemnumber(i,'cargo')				
		ls_nombre  = dw_1.getitemstring(i,'dgmterce_terc_descripcion')
		
		//Inserta en la Tabla CCTMOVIM
		  INSERT INTO cctmovim  
					( movi_g_financiero,   
					  movi_empresa,   
					  movi_aplicacion,   
					  movi_tipo_transaccion,   
					  movi_documento,   
					  movi_anno,			
					  movi_sub_transaccion,   			  
					  movi_tercero,   
					  movi_ruc_tercero,   			  
					  movi_referencia,   
					  movi_naturaleza,   
					  movi_monto,   
					  movi_fecha_tran,   
					  movi_usuario,
					  movi_estado,
					  movi_fecha_vence,
					  movi_comentario,
					  movi_saldo,
					  movi_a_nombre,
					  movi_historica,
					  movi_comments)
		  VALUES ( :str.g_financiero,
					  :str.empresa,   
					  'CC',   
					  'ND',   
					  :ls_secuencia,   
					  :li_ann,	  
					  'IN',			//Intereses
					  :ll_cliente,   
					  :ls_ruc,
					  :ls_secuencia, 			 
					  "D",
					  :ld_cargo,   
					  :ldt_fecha,   
					  :str.usuario,
					  "IM",
					  :ldt_fechavence,
					  :ls_comentario,
					  :ld_cargo,
					  :ls_nombre,
					  'S',
					  :ls_comentario) ;

				if sqlca.sqlerrtext <> "" then	
					ls_error = sqlca.sqlerrtext
					sqlca.autocommit = true
					rollback ;
					gf_mensaje("Error","Error al Actualizar el Cliente " +ls_error,1,1,'E')	
					return
				end if	
	
				  UPDATE ccmclien  
			     SET clie_fecha_intereses = :ldt_fecha  
					WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
							( ccmclien.clie_empresa = :str.empresa ) AND  
							( ccmclien.clie_tercero = :ll_cliente ) ;
					if sqlca.sqlerrtext <> "" then	
						ls_error = sqlca.sqlerrtext
						sqlca.autocommit = true
						rollback ;
						gf_mensaje("Error","Error al Actualizar fecha en el cliente " +ls_error,1,1,'E')	
						return
					end if	
				
				//Incrementa la secuencia para el siguiente cliente
				ls_secuencia = string(long(ls_secuencia) + 1)
				
	next
	
	ll_secuencia = long(ls_secuencia) - 1
	
	  UPDATE dgmserie  
     SET mser_secuencia = :ll_secuencia
   WHERE ( dgmserie.mser_g_financiero = :str.g_financiero ) AND  
         ( dgmserie.mser_empresa = :str.empresa ) AND  
         ( dgmserie.mser_tipo_transaccion = 'ND' ) ;
				if sqlca.sqlerrtext <> "" then	
					ls_error = sqlca.sqlerrtext
					sqlca.autocommit = true
					rollback ;
					gf_mensaje("Error","Error al Actualizar la secuencia " +ls_error,1,1,'E')	
					return
				end if	
	
	commit;
	sqlca.autocommit = true
	
	gf_mensaje('','Generacion Exitosa de los Cargos por Morosidad',1,1,'E')	

	dw_1.setfilter('saldo  > 0')
	dw_1.filter()	
	dw_1.reset()
	if dw_2.retrieve(str.g_financiero, str.empresa) > 0 then
		if wf_antiguedad() then
			dw.retrieve(str.g_financiero,str.empresa, str.maquina)
		end if
	end if	

else //Si responde no a la pregunta
	return
end if

sqlca.autocommit = true
	
return
end event

type cb_2 from commandbutton within w_generar_cargos_por_mora
integer x = 1682
integer y = 2112
integer width = 357
integer height = 116
integer taborder = 21
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;close(parent)
end event

type dw_2 from datawindow within w_generar_cargos_por_mora
boolean visible = false
integer x = 78
integer y = 444
integer width = 434
integer height = 768
integer taborder = 11
boolean bringtotop = true
string title = "none"
string dataobject = "dw_clientes_a_generar"
boolean livescroll = true
end type

