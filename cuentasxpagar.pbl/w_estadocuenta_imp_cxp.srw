//objectcomments Ventana del Informe del  Estado de Cuentas
forward
global type w_estadocuenta_imp_cxp from w_fa_padre_reportes
end type
end forward

global type w_estadocuenta_imp_cxp from w_fa_padre_reportes
boolean visible = false
integer x = 128
integer y = 100
integer width = 2309
integer height = 1240
string title = "Estado de Cuenta del Proveedor"
long backcolor = 12639424
end type
global w_estadocuenta_imp_cxp w_estadocuenta_imp_cxp

type variables
str_rangofecha istr_rangfech

decimal idec_saldo_anterior
string  is_tip_busca, is_rango_descri,is_muestra_nombre
str_cc_formatos str_formato
end variables

forward prototypes
public subroutine wf_control_columna (integer registro)
public subroutine wf_asignar_antig ()
public function boolean wf_actualiza_antiguedad (datetime adt_desde, datetime adt_hasta, long al_tercero, long al_dias_limite)
public function boolean wf_asigna_antig_moroso ()
public function string wf_secuencia_tran ()
public function boolean wf_antiguedad ()
end prototypes

public subroutine wf_control_columna (integer registro);
if registro <= 12  then
	dw.modify('rr_6.width= 1513')
	dw.modify('l_11.x2= 1531')
	dw.modify('l_15.visible=false')
	dw.modify('ccatpan_tpan_col13_t.visible= false')
	dw.modify('ccatpan_tpan_col13.visible= false')
	dw.modify('ccatpan_tpan_col21_t_1.x=1175')
	dw.modify('ccatpan_tpan_col21_1.x=1175')
end if

if registro <= 11  then
	dw.modify('rr_6.width= 1143')
	dw.modify('l_11.x2= 1161')
	dw.modify('l_14.visible=false')
	dw.modify('ccatpan_tpan_col12_t.visible= false')
	dw.modify('ccatpan_tpan_col12.visible= false')
	dw.modify('ccatpan_tpan_col21_t_1.x=800')
	dw.modify('ccatpan_tpan_col21_1.x=800')
end if

if registro <= 10 then
	dw.modify('rr_6.width= 768')
	dw.modify('l_11.x2= 782')
	dw.modify('l_13.visible=false')
	dw.modify('ccatpan_tpan_col11_t.visible= false')
	dw.modify('ccatpan_tpan_col11.visible= false')
	dw.modify('ccatpan_tpan_col21_t_1.x=425')
	dw.modify('ccatpan_tpan_col21_1.x=425')
end if

if registro <= 9 then
	dw.modify('rr_6.width= 393')
	dw.modify('l_11.x2= 411')
	dw.modify('l_12.visible=false')
	dw.modify('ccatpan_tpan_col10_t.visible= false')
	dw.modify('ccatpan_tpan_col10.visible= false')
	dw.modify('ccatpan_tpan_col21_t_1.x=41')
	dw.modify('ccatpan_tpan_col21_1.x=41')
end if
	
end subroutine

public subroutine wf_asignar_antig ();string ls_error
integer li_count
/* convierte una antiguedad Vertical en Horizontal */
/* Elimina los Valores Actuales */ 

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
	
/* Inserta los nuevos valores */ 
  INSERT INTO ccatpan  
         ( tpan_g_financiero,   
           tpan_empresa,   
           tpan_tercero,
			  tpan_saldo_anterior,
           tpan_col1,   
           tpan_col2,   
           tpan_col3,   
           tpan_col4,   
           tpan_col5,   
           tpan_col6,   
           tpan_col7,   
           tpan_col8,   
           tpan_col9,   
           tpan_col10,   
           tpan_col11, 
	        tpan_col12, 
           tpan_col13, 
           tpan_col21,   
           tpan_col1_t,   
           tpan_col2_t,   
           tpan_col3_t,   
           tpan_col4_t,   
           tpan_col5_t,   
           tpan_col6_t,   
           tpan_col7_t,   
           tpan_col8_t,   
           tpan_col9_t,   
           tpan_col10_t,   
           tpan_col11_t,
           tpan_col12_t,
           tpan_col13_t,
           tpan_col21_t,
			  tpan_maquina)   
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
		( ccatempa.tmpa_usuario_maquina = :str.maquina)
GROUP BY ccatempa.tmpa_g_financiero,   
         ccatempa.tmpa_empresa,   
         ccatempa.tmpa_tercero ;
if sqlca.sqlcode = -1 then
	ls_error = sqlca.sqlerrtext
	rollback;
	mensaje('Aviso ','Error al insertar en ccatpan',ls_error)
	return
else	
	commit ; 
	//mensaje('','Inserto en CCATPAN','')
end if


end subroutine

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

public function boolean wf_asigna_antig_moroso ();string ls_error

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
//				movi_sub_transaccion = 'IN' and
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

public function boolean wf_antiguedad ();//long ll_tercero, i, ll_dias
//datetime ld_tiempo1, ld_tiempo2, ldt_fecha
//date		ldt_fecha_desde, ldt_fecha_hasta
//ldt_fecha = gf_fecha_serv()
//ldt_fecha_hasta = date(ldt_fecha)
//ldt_fecha_desde = relativedate(date(gf_fecha_serv()), - 365)
//ld_tiempo1 = Datetime(ldt_fecha_desde,00:00:00)
//ld_tiempo2 = Datetime(ldt_fecha_hasta,00:00:00)
//str.frame.setmicrohelp('Configurando la Antiguedad')
//for i = 1 to dw_2.rowcount()
//	ll_tercero = dw_2.getitemnumber(i,'clie_tercero')
//	ll_dias	  = dw_2.getitemnumber(i,'dias_limite')
//	wf_actualiza_antiguedad(ld_tiempo1, ld_tiempo2, ll_tercero, ll_dias)
//	str.frame.setmicrohelp('Asignando Valores al Formato')
//	wf_asigna_antig_moroso()				
//next
return true
end function

on w_estadocuenta_imp_cxp.create
call super::create
end on

on w_estadocuenta_imp_cxp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event resize;//Override
str.frame.setredraw(false)

//this.width = newwidth - 20
//this.height = newheight - 30

dw_1.width = this.width  - 50
dw_1.height = this.height - 150

gb_1.width = this.width  - 40
gb_1.height = this.height - 272

str.frame.setredraw(true)
end event

event ue_post_open;Integer  li_registros, li_i, li_empresa, li_grupofin, li_cliente , li_emp, li_dberror,&
         li_tip_cliente, li_grupo, li_tipo = 0, li_socio = 0, li_audit = 0, li_estadoc
decimal  ld_x, ld_y, ld_monto, ldec_sal_ant
string   ls_db_err, ls_fecha_est, ls_fecha_text, ls_mensaje, ls_datawindow, nombre_de_data, ls_err
long 		ll_tercero, ll_err
Datetime ld_tiempo1, ld_tiempo2
date ld_fecha_2, fecha1, fecha

Datawindowchild ldwc_sub_tran, ldwc_pais, ldwc_region, ldwc_credito
//dw_1.SetRedraw ( false )


dw_1.show() 
dw = dw_1
//dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()
//gf_center_win(this)

istr_rangfech = message.powerObjectParm

ll_tercero = istr_rangfech.codigo
fecha = istr_rangfech.fecha1
fecha1 = istr_rangfech.fecha2
// Se Desabilitan Botones del menu Principal

if not isvalid(m_fa_rep) then ChangeMenu(m_fa_rep)
m_fa_rep.m_archivo.m_guardar.toolbaritemvisible				=false
m_fa_rep.m_archivo.m_guardar.visible							=false
m_fa_rep.m_archivo.m_guardar.enabled							=false
m_fa_rep.m_edicin.m_primerregistro.toolbaritemvisible		=true
m_fa_rep.m_edicin.m_primerregistro.visible			  		=true
m_fa_rep.m_edicin.m_adicionar.toolbaritemvisible			=false
m_fa_rep.m_edicin.m_adicionar.visible							=false
m_fa_rep.m_edicin.m_insertar.toolbaritemvisible				=false
m_fa_rep.m_edicin.m_insertar.visible							=false
m_fa_rep.m_edicin.m_eliminar.toolbaritemvisible				=false
m_fa_rep.m_edicin.m_eliminar.visible							=false
m_fa_rep.m_edicin.m_filtrar.toolbaritemvisible				=true
m_fa_rep.m_edicin.m_filtrar.visible								=true
m_fa_rep.m_edicin.m_sortear.toolbaritemvisible				=true
m_fa_rep.m_edicin.m_sortear.visible								=true
m_fa_rep.m_edicin.m_busqueda.toolbaritemvisible				=false
m_fa_rep.m_edicin.m_busqueda.visible							=false
m_fa_rep.m_edicin.m_ultimoregistro.toolbaritemvisible		=true
m_fa_rep.m_edicin.m_ultimoregistro.visible					=true
m_fa_rep.m_edicin.m_siguienteregistro.toolbaritemvisible	=true
m_fa_rep.m_edicin.m_siguienteregistro.visible				=true
m_fa_rep.m_edicin.m_registroanterior.toolbaritemvisible	=true
m_fa_rep.m_edicin.m_registroanterior.visible					=true

//ld_tiempo1 = Datetime(istr_rangfech.fecha1,00:00:00)
//ld_tiempo2 = Datetime(istr_rangfech.fecha2,00:00:00)

		delete from cpatempa 
		where tmpa_g_financiero = :str.g_financiero 	and
				tmpa_empresa		= :str.empresa;
		
		If sqlca.sqlcode = -1 then
			ll_err = sqlca.sqldbcode
			ls_err  = sqlca.SQLErrText
			rollback;
			mensaje("Error"+string(ll_err),"Eliminando registros de cpatempa ",&
			'Descripción del error: '+ls_err)
			
			return
		end if	
		gf_cp_antiguedad_x_proveedor_prueba(datetime(fecha1),ll_tercero)
  //	
	//
		dw_1.SetRedraw(false)
		//dw3.dataobject = 'dw_cp_est_cuen_x_provee'
		dw_1.dataobject = 'dw_cp_est_cuen_x_provee3'
		dw_1.SetTransObject(SQLCA)
		
		//ldec_saldo_actual = wf_saldo_proveedor(ll_tercero,fecha)
		//ldec_saldo_actual = gf_cp_saldo_anterior(ll_tercero,datetime(fecha))
		dw_1.retrieve(str.g_financiero,str.empresa,fecha,fecha1,ll_tercero)
		
		datetime ldt_fecha1
		ldt_fecha1 = datetime(fecha)
		if dw_1.rowcount() = 0 then 
			ldec_sal_ant = gf_cp_saldo_anterior(ll_tercero,ldt_fecha1)
			if isnull(ldec_sal_ant) then ldec_sal_ant = 0
			
			if ldec_sal_ant <> 0 then 
				dw_1.insertrow(0)				
				dw_1.setitem(1,'cptmovim_movi_fecha_tran',datetime(fecha))
				dw_1.setitem(1,'dgmserie_mser_descripcion','Saldo Anterior')
				dw_1.setitem(1,'saldo_inicio',ldec_sal_ant)
				
			end if
		end if
		if dw_1.rowcount() > 0 then
		//	dw3.setitem(1,'saldo_u',ldec_saldo_actual)
			dw_1.object.datawindow.print.preview 		 =true
			dw_1.object.datawindow.print.preview.zoom  = 100
		end if
		
dw_1.GroupCalc ( )
dw_1.setfocus()
if dw_1.rowcount() <= 0 then close(this)
end event

event ue_reg_anterior;//Override
dw.ScrollPriorPage( )
end event

event ue_primer_reg;//Override
dw.scrollNextpage()
end event

event close;if isvalid(w_estadocuenta_imp_cxp) then
	close(w_estadocuenta_imp_cxp)
end if
close(this)
end event

event ue_filter;call super::ue_filter;String var
SetNull(var)

// Open The Filter Window
dw.SetFilter(var)

// Execute the filter expresion definida to the user
dw.filter()

dw_1.groupcalc()
end event

event ue_sort;call super::ue_sort;dw_1.groupcalc()
end event

event open;call super::open;this.y = 0
this.x = 805
this.width = str.frame.width - 860

end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_estadocuenta_imp_cxp
integer x = 2213
integer y = 1480
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_estadocuenta_imp_cxp
boolean visible = false
integer x = 37
integer y = 956
integer width = 1280
integer height = 80
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_estadocuenta_imp_cxp
integer x = 5
integer y = 8
integer width = 2203
integer height = 896
integer taborder = 10
string dataobject = "dw_cp_est_cuen_x_provee3"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event dw_1::constructor;this.settransobject(sqlca)
dw=this
this.visible = true
end event

event dw_1::sqlpreview;call super::sqlpreview;String  ls_sql
datetime ld_tiempo1,ld_tiempo2
long     ll_t

ll_t = 99999

ls_sql = sqlsyntax

if istr_rangfech.opcion = 'P'then//por cliente

	CHOOSE CASE istr_rangfech.tipo_orden//is_tip_busca
		CASE  'N'//por cliente
//		  if dw_1.Dataobject = 'dw_cc_inf_estcuen_ingles' or &
//			  dw_1.Dataobject = 'dw_cc_inf_est_cuen_x_cliente'or & 
//			  dw_1.Dataobject = 'dw_cc_inf_est_cuen_x_cliente_sql' then
			  
			ls_sql+=  " AND  " + &
			"  ( ccmclien.clie_ref_anterior >= '"  + istr_rangfech.desdeclienteref + "' ) AND "  + &
			"  ( ccmclien.clie_ref_anterior <= '" + istr_rangfech.hastaclienteref + "' ) AND "  + &
			"  ( vi_cc_movimientos.movi_estado = '"+'IM'+"') and"+&
			"  (ccatpan.tpan_maquina ='"+str.maquina+"')"
				
			//end if
		CASE 'A'
//		if dw_1.Dataobject = 'dw_cc_inf_estcuen_ingles'  or &
//				dw_1.Dataobject = 'dw_cc_inf_est_cuen_x_cliente'or & 
//				dw_1.Dataobject = 'dw_cc_inf_est_cuen_x_cliente_sql'then

				if istr_rangfech.tipo_antig = 'S' then
					ls_sql+=  " AND  " + &
					"  ( rtrim(dgmterce.terc_descripcion) + convert(char(5),dgmterce.terc_tercero) >= "  +"'"+ istr_rangfech.nombre1 +"'"+ " ) AND "  + &
					"  ( rtrim(dgmterce.terc_descripcion) + convert(char(5),dgmterce.terc_tercero) <= " + "'"+istr_rangfech.nombre2 + "'"+") and " + &
					"  ( vi_cc_movimientos.movi_estado = '"+'IM'+"') and "+&
					"  ( vi_cc_movimientos.movi_tran_contado <> '"+'S'+"') and"+&
					"  (ccatpan.tpan_maquina ='"+str.maquina+"')"
				else
					//mensaje('','istr_rangfech.nombre1 :'+istr_rangfech.nombre1 +' istr_rangfech.nombre2: '+istr_rangfech.nombre2,'')
						ls_sql+=  " AND  " + &
					"  ( rtrim(dgmterce.terc_descripcion) + convert(char(5),dgmterce.terc_tercero) >= "  +"'"+ istr_rangfech.nombre1 +"'"+ " ) AND "  + &
					"  ( rtrim(dgmterce.terc_descripcion) + convert(char(5),dgmterce.terc_tercero) <= " + "'"+istr_rangfech.nombre2 + "'"+") and " + &
					"  ( vi_cc_movimientos.movi_estado = '"+'IM'+"') and "+&
					"  ( vi_cc_movimientos.movi_tran_contado <> '"+'S'+"') and "+ &
					"  (ccatpan.tpan_maquina ='"+str.maquina+"')"
				
				end if
			//end if
		CASE 'C'
//			if dw_1.Dataobject = 'dw_cc_inf_estcuen_ingles' or &
//				dw_1.Dataobject = 'dw_cc_inf_est_cuen_x_cliente' or & 
//			   dw_1.Dataobject = 'dw_cc_inf_est_cuen_x_cliente_sql' then
			ls_sql+=  " AND  " + &
			"  ( ccmclien.clie_ruc_tercero >= '"  + istr_rangfech.ruccli1 + "' ) AND "  + &
			"  ( ccmclien.clie_ruc_tercero <= '" + istr_rangfech.ruccli2 + "') and  " + &
			"  ( vi_cc_movimientos.movi_estado = '"+'IM'+"') and"+&
			"  (ccatpan.tpan_maquina ='"+str.maquina+"')"

			//end if
	 CASE  ELSE//Por tercero o por ruc
//		if dw_1.Dataobject = 'dw_cc_inf_estcuen_ingles' or &
//			dw_1.Dataobject = 'dw_cc_inf_est_cuen_x_cliente' or & 
//			dw_1.Dataobject = 'dw_cc_inf_est_cuen_x_cliente_sql' then
			
//			ls_sql+=  " AND  " + &
//			"  ( ccmclien.clie_tercero >= " + string(istr_rangfech.desdecliente) + " ) AND "  + &
//			"  ( ccmclien.clie_tercero <= " + string(istr_rangfech.hastacliente) + " ) AND "  + &
//			"  ( vi_cc_movimientos.movi_estado = '"+'IM'+"') and"+&
//			"  (ccatpan.tpan_maquina ='"+str.maquina+"')"
//				
//			elseif dw_1.DAtaobject = 'dw_cc_inf_est_cuen_x_cliente' then
			
			ls_sql+=  " AND  " + &
			"  ( ccmclien.clie_tercero >= " + string(istr_rangfech.desdecliente) + " ) AND "  + &
			"  ( ccmclien.clie_tercero <= " + string(istr_rangfech.hastacliente) + " ) AND "  + &
			"  ( vi_cc_movimientos.movi_estado = '"+'IM'+"') AND "+&
			"  ( vi_cc_movimientos.movi_tercero <> "+ string(ll_t)+") and"+&
			"  (ccatpan.tpan_maquina ='"+str.maquina+"')"
	//	end if
	
	END CHOOSE



elseif istr_rangfech.opcion = 'R' or istr_rangfech.opcion = 'G' or istr_rangfech.opcion = 'F'then//por pais/empresa y grupo
	ls_sql+=  " AND  " + &
	"  (ccatpan.tpan_maquina ='"+str.maquina+"')"
end if

//mensaje('',ls_sql,'')
This.SetSqlPreview(ls_sql)



end event

event dw_1::printstart;call super::printstart;//

string ls_resp
ls_resp=dw_1.Describe("DataWindow.Syntax")

If dw_1.Describe("t_dw_name.x") <> "?" And dw_1.Describe("t_dw_name.x") <> "!" Then
	if pos(ls_resp,"t_dw_name") > 0 then this.object.t_dw_name.visible=false	
end if
If dw_1.Describe("data_windo.x") <> "?" And dw_1.Describe("data_windo.x") <> "!" Then
	if pos(ls_resp,"data_windo") > 0 then this.object.t_dw_name.visible=false	
end if
If dw_1.Describe("data_window.x") <> "?" And dw_1.Describe("data_window.x") <> "!" Then
	if pos(ls_resp,"data_window") > 0 then this.object.t_dw_name.visible=false	
end if
end event

event dw_1::printend;call super::printend;
string ls_resp
ls_resp=dw_1.Describe("DataWindow.Syntax")

If dw_1.Describe("t_dw_name.x") <> "?" And dw_1.Describe("t_dw_name.x") <> "!" Then
	if pos(ls_resp,"t_dw_name") > 0 then this.object.t_dw_name.visible=true	
end if
If dw_1.Describe("data_windo.x") <> "?" And dw_1.Describe("data_windo.x") <> "!" Then
	if pos(ls_resp,"data_windo") > 0 then this.object.t_dw_name.visible=true
end if
If dw_1.Describe("data_window.x") <> "?" And dw_1.Describe("data_window.x") <> "!" Then
	if pos(ls_resp,"data_window") > 0 then this.object.t_dw_name.visible=true
end if
end event

event dw_1::doubleclicked;call super::doubleclicked;//Llama a la ventana de Pedidos Reservados
String ls_producto, ls_objeto
integer li_pos
long ll_tercero

ls_objeto = dwo.name

if ls_objeto = "vi_cc_movimientos_movi_documento" then
	
	if row = 0 then return
	
	if dw_1.getitemstring(row,'movi_aplicacion') <> 'FA' then return
	
	str_secuencia_doc lstr_sec
	lstr_sec.ano = dw_1.getitemNumber(row,"movi_ann")
	lstr_sec.sec_manual = dw_1.getitemstring(row,"vi_cc_movimientos_movi_documento")
	opensheetwithparm(w_facturas_actualizadas,lstr_sec,str.frame,9,layered!)
end if


end event

event dw_1::clicked;call super::clicked;string ls_column
ls_column = dwo.name
if ls_column = "documento" then
	
	if row = 0 then return
	
	str_secuencia_doc lstr_sec
	lstr_sec.ano = dw_1.getitemNumber(row,"cptmovim_movi_anno")
	lstr_sec.sec_manual = dw_1.getitemstring(row,"cptmovim_movi_documento")
	lstr_sec.tran	= dw_1.getitemstring(row,"cptmovim_movi_tipo_transaccion")
	lstr_sec.subtran	= dw_1.getitemstring(row,"cptmovim_movi_sub_transaccion")	
	lstr_sec.referencia  = dw_1.getitemstring(row,"cptmovim_movi_referencia")	
	
//	if this.getitemstring(row,'movi_aplicacion') = 'BA' then
//		gf_mensaje('','Transaccion de Bancos',1,1,'E')
//	else
		opensheetwithparm(w_consulta_transacciones_cxp, lstr_sec,str.frame,2,original!)
//	end if
elseif ls_column = 'dgmterce_terc_descripcion' then
	str_cc_formatos str_formato1		
	str_formato1.tercero = dw_1.getitemNumber(1,"cptmovim_movi_tercero")
	OpenSheetwithparm(w_mant_proveedores,str_formato1,parent,2, Original!)

end if
end event

event dw_1::ue_microayuda;//override

end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_estadocuenta_imp_cxp
integer x = 2117
integer y = 568
integer width = 69
integer height = 84
integer taborder = 20
end type

event gb_1::constructor;this.visible = false
end event

