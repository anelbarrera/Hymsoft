forward
global type w_cierre_caja from w_na_padre
end type
type st_1 from statictext within w_cierre_caja
end type
type dw_2 from datawindow within w_cierre_caja
end type
type cbx_1 from checkbox within w_cierre_caja
end type
type cb_1 from commandbutton within w_cierre_caja
end type
type dw_3 from datawindow within w_cierre_caja
end type
type cb_2 from commandbutton within w_cierre_caja
end type
type em_rango_inicio from editmask within w_cierre_caja
end type
type st_4 from statictext within w_cierre_caja
end type
type st_5 from statictext within w_cierre_caja
end type
type st_6 from statictext within w_cierre_caja
end type
type em_rango_fin from editmask within w_cierre_caja
end type
type cb_3 from commandbutton within w_cierre_caja
end type
type em_1 from editmask within w_cierre_caja
end type
type st_3 from statictext within w_cierre_caja
end type
type gb_1 from groupbox within w_cierre_caja
end type
type gb_2 from groupbox within w_cierre_caja
end type
end forward

global type w_cierre_caja from w_na_padre
integer width = 3662
integer height = 2148
string title = "Cierre de Caja Menuda"
boolean maxbox = false
long backcolor = 12639424
string icon = "AppIcon!"
st_1 st_1
dw_2 dw_2
cbx_1 cbx_1
cb_1 cb_1
dw_3 dw_3
cb_2 cb_2
em_rango_inicio em_rango_inicio
st_4 st_4
st_5 st_5
st_6 st_6
em_rango_fin em_rango_fin
cb_3 cb_3
em_1 em_1
st_3 st_3
gb_1 gb_1
gb_2 gb_2
end type
global w_cierre_caja w_cierre_caja

type variables
integer ii_switch 
end variables

on w_cierre_caja.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_2=create dw_2
this.cbx_1=create cbx_1
this.cb_1=create cb_1
this.dw_3=create dw_3
this.cb_2=create cb_2
this.em_rango_inicio=create em_rango_inicio
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.em_rango_fin=create em_rango_fin
this.cb_3=create cb_3
this.em_1=create em_1
this.st_3=create st_3
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cbx_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.em_rango_inicio
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_5
this.Control[iCurrent+10]=this.st_6
this.Control[iCurrent+11]=this.em_rango_fin
this.Control[iCurrent+12]=this.cb_3
this.Control[iCurrent+13]=this.em_1
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.gb_1
this.Control[iCurrent+16]=this.gb_2
end on

on w_cierre_caja.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.cbx_1)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.cb_2)
destroy(this.em_rango_inicio)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.em_rango_fin)
destroy(this.cb_3)
destroy(this.em_1)
destroy(this.st_3)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;//
gb_2.height = newheight - 430
dw_1.height = newheight - 510
//st_nom_ventana.y = newheight - 100
//cb_1.y = newheight - 110
end event

event ue_hay_data;//
end event

event ue_post_open;call super::ue_post_open;datawindowchild ldwc_barco

dw_2.retrieve()
dw_2.insertrow(0)

if pos(str.empr_acceso_especial, 'OCEAN') > 0 then
	dw_3.dataobject  = 'dw_na_rep_caja_menuda_2_2o'
	dw_3.settransobject(sqlca)
end if

em_1.text = string(date(gf_fecha_serv()))

//dw_1.retrieve(str.g_financiero, str.empresa)

//dw_3.getchild("natdesem_desem_no_caso_1",ldwc_no_caso)
//ldwc_no_caso.settransobject(sqlca)
//IF ldwc_no_caso.retrieve(str.g_financiero,str.empresa) = 0 THEN
//	ldwc_no_caso.insertrow(0)
//END IF

dw_3.getchild('ntdesem_desem_transito',ldwc_barco)
ldwc_barco.settransobject(sqlca);
if ldwc_barco.retrieve(str.g_financiero, str.empresa) = 0 then
	ldwc_barco.insertrow(1)
end if

end event

event open;//override
sqlca.autocommit = true
//gf_acelerador()
dw = dw_1

this.y = 0
this.x = 805

This.Icon = str.icono

this.postevent("ue_post_open")

This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)

//Configurar los Accesos

//mf_accesos(this.menuid, this)

str.frame.SetRedraw ( True )
end event

type st_nom_ventana from w_na_padre`st_nom_ventana within w_cierre_caja
integer x = 14
integer y = 1932
integer width = 73
end type

type dw_1 from w_na_padre`dw_1 within w_cierre_caja
integer x = 64
integer y = 316
integer width = 3488
integer height = 1588
integer taborder = 70
string dataobject = "dw_na_aprobacion_desem"
boolean vscrollbar = true
end type

event dw_1::constructor;call super::constructor;this.settransobject(sqlca)
end event

event dw_1::itemchanged;call super::itemchanged;integer li_ap, li_re

if dwo.name = 'ap' then

	if data = '1' then
		dw_1.setitem(dw_1.getrow(), 're', 0)
	end if


elseif dwo.name = 're' then

	if data = '1' then
		dw_1.setitem(dw_1.getrow(), 'ap', 0)
	end if

end if
end event

event dw_1::doubleclicked;call super::doubleclicked;string ls_wording

ls_wording = dw_1.getitemstring(dw_1.getrow(), 'desem_descripcion')

messagebox('Descripción Desembolso', ls_wording)
end event

type st_ayuda from w_na_padre`st_ayuda within w_cierre_caja
end type

type dw_10 from w_na_padre`dw_10 within w_cierre_caja
integer taborder = 90
end type

type st_1 from statictext within w_cierre_caja
integer x = 78
integer y = 148
integer width = 160
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16777215
long backcolor = 8421376
string text = "Caja:"
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_cierre_caja
integer x = 251
integer y = 136
integer width = 1019
integer height = 88
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dw_na_ext_caja"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

event itemchanged;boolean lb_checked

lb_checked = cbx_1.checked

//if lb_checked = false then
dw_1.setredraw(false)		
dw_1.retrieve(str.g_financiero, str.empresa)
dw_3.retrieve(str.g_financiero, str.empresa)

dw_1.setfilter("desem_caja =  '" + data + "'" )
dw_1.filter()

dw_3.setfilter("ntdesem_desem_caja =  '" + data + "'" )
dw_3.filter()
dw_1.setredraw(true)
//end if

//st_3.visible = false
//em_1.visible = false
//em_1.text = "00/00/0000"
cb_2.visible = false
ii_switch = 0
end event

type cbx_1 from checkbox within w_cierre_caja
boolean visible = false
integer x = 1303
integer y = 64
integer width = 279
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Todos"
boolean checked = true
end type

event clicked;string ls_usuario

if this.checked = true then
	dw_1.setfilter('')
	dw_1.filter()
else

	ls_usuario = dw_2.getitemstring(dw_2.getrow(), 'usuario')

	if ls_usuario = '' or isnull(ls_usuario) then return

	dw_1.setfilter("desem_usuario =  '" + ls_usuario + "'" )
	dw_1.filter()
end if
end event

type cb_1 from commandbutton within w_cierre_caja
integer x = 3136
integer y = 116
integer width = 411
integer height = 108
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cerrar Caja"
end type

event clicked;long ll_count,ll_fila,ll_tercero,ll_fila_2,ll_row
integer li_ap, li_re, li_cuenta, li_ann,li_mes,li_anno,li_dia,li_ann_2,li_cont,li_cont_1,li_cont_2, li_paga_itbm
string ls_error, ls_mg_barco, ls_tran2, ls_tran, ls_sub, ls_doc, ls_mg_enc, ls_code, ls_class, ls_cargado, &
		 ls_cuenta, ls_caja, ls_masca, ls_descrip_class, ls_desc, ls_paid_to,ls_fecha, ls_sort,ls_ruc,ls_estado, ls_referencia, ls_mg_itbm
string ls_descripcion,ls_naturaleza,ls_transito,ls_voucher,ls_mensaje,ls_retorno,ls_no_caso,ls_desc_class, ls_descripcion_corta
string ls_fecha_1,ls_comentario
datetime ldt_fecha, ldt_actual,ldt_fecha_reg,ldt_fecha_servidor,ldt_fecha_cierre,ldt_fecha_trans
date     ld_fecha,ldt_actual_2
decimal ldc_monto_t, ldc_valor_itbm, ldc_monto_final
boolean lb_estado_revision = false
integer li_anio_actual,li_anio_reg

dw_1.accepttext()

sqlca.autocommit = false

ldt_fecha_servidor = gf_fecha_serv()

ls_caja = dw_2.getitemstring(dw_2.getrow(),"caja")

// Mensaje enviado si la caja contiene vouchers con tránsito en estado de revisión.
ls_mensaje = 'NO SE PUEDE CERRAR LA CAJA PORQUE HAY COMPROBANTES QUE TIENEN TRÁNSITOS EN ESTADO DE REVISIÓN: ~n'

//dw_1.setsort("desem_fecha D")	
//dw_1.sort()
//ls_sort = dw_3.Describe("DataWindow.Table.Sort")
//dw_3.setsort("natdesem_desem_fecha D")	
//dw_3.sort()

li_anio_actual = year(date(ldt_fecha_servidor))
 
FOR ll_fila = 1 TO dw_1.rowcount()
	IF dw_1.getitemnumber(ll_fila,"ap") = 1 THEN
		ldt_fecha_reg = dw_1.getitemdatetime(ll_fila,"desem_fecha")
		li_anio_reg = year(date(ldt_fecha_reg))
		IF li_anio_reg < li_anio_actual THEN
			li_cont_1 += 1
		ELSE
			li_cont_2 += 1
		END IF 
	END IF
NEXT

IF li_cont_1 > 0 and li_cont_2 > 0 THEN
	messagebox("Atención","Sr. Usuario, dentro del grupo de Comprobantes que quiere cerrar hay algunos que son de distintos años.  &
Solo puede cerrar la caja con Comprobantes que sean del mismo año. Verifique por favor.")
	return
END IF

FOR ll_fila_2 = 1 TO dw_1.rowcount()
	ls_transito = dw_1.getitemstring(ll_fila_2,'desem_transito')
	ls_voucher = string(dw_1.getitemnumber(ll_fila_2,'desem_desembolso'))
	li_ann_2 = dw_1.getitemnumber(ll_fila_2, 'desem_ann')
	IF ls_transito <> "" and not isnull(ls_transito) THEN
		SELECT count(*)  
		  INTO :li_cont  
		  FROM banadpagar,   
				 banatpagar  
		 WHERE ( banatpagar.tpaga_g_financiero = banadpagar.dpaga_g_financiero ) and  
				 ( banatpagar.tpaga_empresa = banadpagar.dpaga_empresa ) and  
				 ( banatpagar.tpaga_transito = banadpagar.dpaga_transito ) and  
				 ( banatpagar.tpaga_documento = banadpagar.dpaga_documento ) and  
				 ( banatpagar.tpaga_agno = banadpagar.dpaga_agno ) and  
				 ( banatpagar.tpaga_aplicacion = banadpagar.dpaga_aplicacion ) and  
				 ( banatpagar.tpaga_transaccion = banadpagar.dpaga_transaccion ) and  
				 ( banatpagar.tpaga_subtransaccion = banadpagar.dpaga_subtransaccion ) and  
				 ( ( banadpagar.dpaga_g_financiero = :str.g_financiero ) AND  
				 ( banadpagar.dpaga_empresa = :str.empresa ) AND  
				 ( banadpagar.dpaga_transito = :ls_transito ) AND  
				 ( banadpagar.dpaga_documento = :ls_voucher ) AND
				 ( banatpagar.tpaga_transaccion = 'CM' ) AND
				 ( banatpagar.tpaga_subtransaccion = 'CM') AND
				 ( banatpagar.tpaga_aplicacion = 'NA') AND
				 ( banatpagar.tpaga_agno = :li_ann_2 ))   ;
		
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			mensaje('', 'Error al Consultar registros.', ls_error)
			sqlca.autocommit = true
			return -1
		end if
		
		IF li_cont = 0 THEN
			SELECT ntransito.tran_estado  
			  INTO :ls_estado  
			  FROM ntransito  
			 WHERE ( ntransito.tran_g_financiero = :str.g_financiero ) AND  
					 ( ntransito.tran_empresa = :str.empresa ) AND  
					 ( ntransito.tran_transito = :ls_transito )   ;
	
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				mensaje('ERROR', 'Error al Consultar registros de Tramsitos.', ls_error)
				sqlca.autocommit = true
				return -1
			end if
			
			IF ls_estado = 'C' THEN
				sqlca.autocommit = true
				messagebox("Atención","Disculpe no se puede realizar el cierre de esta caja porque el tránsito en el voucher # " + ls_voucher + &
" se encuentra cerrado. Por favor consulte con el personal de contabilidad para solucionar esta situación.")
				return -1
			END IF
			IF ls_estado = 'R' THEN
				lb_estado_revision = true
				ls_mensaje = ls_mensaje + '~n~t~t~t~t' + ls_transito + "      Voucher # " + ls_voucher
			END IF
		END IF
	END IF
NEXT

IF lb_estado_revision = true THEN
	ls_mensaje = ls_mensaje + '~n~nDIRÍJASE A LOS SUPERVISORES DE CONTABILIDAD PARA INFORMAR LA SITUACIÓN Y SOLICITAR LA CONTRASEÑA. GRACIAS'
	IF messagebox("Atención",ls_mensaje,Question!,YesNo!) = 1 THEN
		OpenWithParm(w_dg_man_clave_2,"")
		ls_retorno = Message.StringParm
		IF ls_retorno <> '1' THEN
			return
		END IF
	ELSE
		return
	END IF
END IF

IF li_cont_1 > 0 and li_cont_2 = 0 THEN
	IF ii_switch = 0 THEN
		st_3.visible = true
		em_1.visible = true
		ii_switch = 1
		messagebox("Atención","Debe colocar una fecha de cierre para los Vouchers del año anterior y presionar nuevamente el botón de cerrar caja.")
		return
	ELSE
		ls_fecha_1 = em_1.text
		ls_fecha_1 = left(ls_fecha_1, 2) + '/'+mid(ls_fecha_1, 4,2) +'/'+ Mid(ls_fecha_1,7,4)
		ldt_fecha_cierre = datetime(date(ls_fecha_1),time(00:00:00))
		IF year(date(ldt_fecha_cierre)) = li_anio_actual THEN
			messagebox("Atención","Sr. Usuario, la fecha de cierre no puede ser del año actual, tiene que ser una fecha del año anterior.")
			return
		ELSEIF string(date(ldt_fecha_cierre)) = '01/01/1900' or isnull(ldt_fecha_cierre) THEN
			messagebox("Atención","Sr. Usuario, no puede dejar la fecha de cierre en blanco.")
			em_1.setfocus()
			return
		END IF
	END IF
END IF

ls_fecha_1 = em_1.text			//new
ls_fecha_1 = left(ls_fecha_1, 2) + '/'+mid(ls_fecha_1, 4,2) +'/'+ Mid(ls_fecha_1,7,4)		//new
ldt_fecha_cierre = datetime(date(ls_fecha_1),time(00:00:00))		//new
ldt_actual = ldt_fecha_cierre //gf_fecha_serv()		//new

for ll_count = 1 to dw_1.rowcount()
	li_ap = dw_1.getitemnumber(ll_count, 'ap')
	li_re = dw_1.getitemnumber(ll_count, 're')
	li_ann = dw_1.getitemnumber(ll_count, 'desem_ann')
	ldc_monto_t     = dw_1.getitemdecimal(ll_count, 'desem_monto')	
	ldc_valor_itbm  = dw_1.getitemdecimal(ll_count, 'desem_valor_itbm')	
	ldc_monto_final = dw_1.getitemdecimal(ll_count, 'desem_monto_final')
	li_paga_itbm = dw_1.getitemnumber(ll_count,'desem_paga_itbm')
	IF ii_switch = 1 THEN
		ldt_fecha_trans = ldt_fecha_cierre
	ELSE		
		ldt_fecha_trans = datetime(date(ldt_actual),time(00:00:00))
	END IF
	ldt_fecha = dw_1.getitemdatetime(ll_count, 'desem_fecha')
	ls_doc = string(dw_1.getitemnumber(ll_count, 'desem_desembolso'))
	ls_referencia = ls_doc
	ls_cargado = dw_1.getitemstring(ll_count, 'desem_cargado_a')
	ls_class = dw_1.getitemstring(ll_count, 'desem_class')
	ls_code = dw_1.getitemstring(ll_count, 'desem_transito')
	ls_cuenta = dw_1.getitemstring(ll_count, 'desem_cuenta_mg')
	ls_paid_to = dw_1.getitemstring(ll_count, 'desem_pagado_a')
	ll_tercero = dw_1.getitemnumber(ll_count, 'desem_tercero')
	ls_descripcion = dw_1.getitemstring(ll_count, 'desem_descripcion')
	ls_no_caso = dw_1.getitemstring(ll_count, 'desem_no_caso')
	
	dw_1.setitem(ll_count, 'desem_fecha_cambia_status',ldt_fecha_servidor)
	
	if isnull(ls_paid_to) then ls_paid_to = ''
	ls_desc	= f_null(ls_code) + ' ' + f_null(ls_paid_to)

	if li_ap = 1 then		
		dw_1.setitem(ll_count, 'desem_status', 'A')	
		ll_row = dw_3.find("ntdesem_desem_desembolso = " + string(ls_doc),1,dw_3.rowcount())
		dw_3.setitem(ll_row,'ind',1)

	  SELECT nmparam.para_tran_caja,
				nmparam.para_cuenta,
				nmparam.para_mg_cuenta_itbm
		 INTO :ls_tran2,
				:ls_mg_barco,
				:ls_mg_itbm
		 FROM nmparam  
		WHERE ( nmparam.para_g_financiero = :str.g_financiero ) AND  
				( nmparam.para_empresa = :str.empresa )   ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			sqlca.autocommit = true
			mensaje('ERROR', 'Error al Consultar registros en nmparam.', ls_error)
			return -1
		end if

		ls_tran = left(ls_tran2, 2)

		if len(ls_tran2) = 4 then
			ls_sub = right(ls_tran2, 2)
		elseif len(ls_tran2) = 5 then
			ls_sub = right(ls_tran2, 3)
		elseif len(ls_tran2) = 3 then
			ls_sub = right(ls_tran2, 1)
		end if
		
		SELECT ncargos.carg_descripcion  
		  INTO :ls_descrip_class  
		  FROM ncargos  
		 WHERE ( ncargos.carg_cargo = :ls_class ) ;
		
	 if sqlca.sqlcode = -1 then
		 ls_error = sqlca.sqlerrtext
		 rollback;
		 sqlca.autocommit = true
		 mensaje("Atención ","¡Error al Seleccionar Descripción del Class!", ls_error)						
		 return -1
	 end if	

//ENCABEZADO---------------------------------------------------------
  INSERT INTO cotdiari  
         ( diar_g_financiero,   
           diar_empresa,   
           diar_aplicacion_mg,   
           diar_tipo_transaccion,   
           diar_sub_trans,   
           diar_no_documento,   
           diar_no_referencia,  
		  diar_banco_cuenta,
           diar_ann,   
           diar_fecha_transaccion,   
           diar_descripcion,   
           diar_id,   
           diar_fecha_creacion,   
           diar_estado,   
           diar_monto,   
           diar_balance,   
           diar_modificado,   
           diar_cerrado,   
           diar_cierre_mensual,   
           diar_nombre )  
  VALUES ( :str.g_financiero,   
           :str.empresa,   
           'NA',   
           :ls_tran,   
           :ls_sub,   
           :ls_doc,   
           :ls_referencia,   
			  '1',
           :li_ann,   
           :ldt_fecha_trans,   
           :ls_desc,   
           :str.usuario,   
           :ldt_fecha_servidor,   
           'IM',   
           :ldc_monto_final,   
           1,   
           0,   
           'N',   
           'N',   
           :ls_paid_to )  ;
			  if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Insertar '+sqlca.sqlerrtext,1,1,'E')
					rollback;
					return -1
			  end if

//DETALLE--------------------------------------------------------------------------------
//Se comentó esto porque la información ya es grabada y actualizada en la captura de caja menuda.
//*** Darío E. Vásquez - 17/09/2005 ****
		if dw_1.getitemnumber(ll_count, 'desem_cuenta') = 1 then //CXC DEL BARCO
			DELETE banadpagar  
			 WHERE ( banadpagar.dpaga_g_financiero = :str.g_financiero ) AND  
					 ( banadpagar.dpaga_empresa = :str.empresa ) AND  
					 ( banadpagar.dpaga_transito = :ls_code ) AND  
					 ( banadpagar.dpaga_documento = :ls_doc ) AND  
					 ( banadpagar.dpaga_agno = :li_ann ) AND  
					 ( banadpagar.dpaga_aplicacion = 'NA' ) AND  
					 ( banadpagar.dpaga_transaccion = :ls_tran ) AND  
					 ( banadpagar.dpaga_subtransaccion = :ls_sub )   ;
			
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				sqlca.autocommit = true
				mensaje("Atención ","¡Error al Eliminar BANADPAGAR!", ls_error)				
				return -1
			end if
			
			DELETE banatpagar  
			 WHERE ( banatpagar.tpaga_g_financiero = :str.g_financiero ) AND  
					 ( banatpagar.tpaga_empresa = :str.empresa ) AND  
					 ( banatpagar.tpaga_transito = :ls_code ) AND  
					 ( banatpagar.tpaga_documento = :ls_doc ) AND  
					 ( banatpagar.tpaga_agno = :li_ann ) AND  
					 ( banatpagar.tpaga_aplicacion = 'NA' ) AND  
					 ( banatpagar.tpaga_transaccion = :ls_tran ) AND  
					 ( banatpagar.tpaga_subtransaccion = :ls_sub )   ;	
			
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				sqlca.autocommit = true
				mensaje("Atención ","¡Error al Eliminar BANATPAGAR!", ls_error)				
				return -1
			end if
				
			 INSERT INTO banatpagar  
						( tpaga_g_financiero,tpaga_empresa,tpaga_transito,tpaga_documento,   
						  tpaga_agno,tpaga_aplicacion,tpaga_transaccion,tpaga_subtransaccion,   
						  tpaga_monto_total,tpaga_usuario,tpaga_fecha,tpaga_referencia,
						  tpaga_naturaleza,tpaga_fecha_voucher,tpaga_fecha_registro)  
			  VALUES ( :str.g_financiero,:str.empresa,:ls_code,:ls_doc,   
						  :li_ann,'NA',:ls_tran,:ls_sub,   
						  :ldc_monto_final,:str.usuario,:ldt_fecha_trans,'',
						  'D',:ldt_fecha,:ldt_actual)  ;
						  
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				sqlca.autocommit = true
				mensaje("Atención ","¡Error al Insertar BANATPAGAR!", ls_error)					
				return -1
			end if		
			
			 INSERT INTO banadpagar  
						( dpaga_g_financiero,dpaga_empresa,dpaga_transito,dpaga_documento,   
						  dpaga_agno,dpaga_aplicacion,dpaga_transaccion,dpaga_subtransaccion,   
						  dpaga_cargo,dpaga_descripcion_cargo,dpaga_linea,dpaga_monto,   
						  dpaga_fecha,dpaga_no_cuenta,dpaga_cargado_a,dpaga_referencia,
						  dpaga_fecha_voucher)  
			  VALUES ( :str.g_financiero,:str.empresa,:ls_code,:ls_doc,   
						  :li_ann,'NA',:ls_tran,:ls_sub,   
						  :ls_class,:ls_descrip_class,1,:ldc_monto_final,   
						  :ldt_fecha_trans,0,:ls_cargado,'',
						  :ldt_fecha)  ;
						  
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				sqlca.autocommit = true
				mensaje("informacion","Error al Insertar en BANADPAGAR!",ls_error  )					
				return -1
			end if					
					
		elseif dw_1.getitemnumber(ll_count, 'desem_cuenta') = 2 then //CXC DEL CLIENTE
			DELETE cctmovim
			 WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
					 ( cctmovim.movi_empresa = :str.empresa ) AND  
					 ( cctmovim.movi_aplicacion = 'NA' ) AND  
					 ( cctmovim.movi_tipo_transaccion = 'NB' ) AND  
					 ( cctmovim.movi_sub_transaccion = 'NB' ) AND  
					 ( cctmovim.movi_documento = :ls_doc ) AND  
					 ( cctmovim.movi_anno = :li_ann ) AND  
					 ( cctmovim.movi_referencia = :ls_doc ) AND
					 ( cctmovim.movi_transaccion_origen = :ls_tran )	;

			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				sqlca.autocommit = true
				mensaje('ERROR', 'Error al Eliminar los registros en CCTMOVIM1.', ls_error)
				return -1
			end if	
			
			SELECT ccmclien.clie_ruc_tercero  
			  INTO :ls_ruc
			  FROM ccmclien  
			 WHERE ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
					 ( ccmclien.clie_empresa = :str.empresa ) AND  
					 ( ccmclien.clie_tercero = :ll_tercero )   ;
					 
			IF sqlca.sqlcode = -1 THEN
				rollback;
				sqlca.autocommit = true
				messagebox("Atención","Hubo un error al seleccionar en ccmclien.")
				return -1			
			END IF
			
			IF isnull(ls_class) or ls_class = '' THEN
				ls_comentario = ls_descripcion
			ELSE
				ls_comentario = ls_descrip_class
			END IF
			
			ls_descripcion_corta = mid(ls_comentario,1,250)
			
			ls_naturaleza = 'D'
			INSERT INTO cctmovim  
						( movi_g_financiero,movi_empresa,movi_aplicacion,movi_tipo_transaccion,movi_sub_transaccion,   
						  movi_documento,movi_anno,movi_referencia,movi_tercero,movi_ruc_tercero,movi_naturaleza,   
						  movi_monto,movi_fecha_tran,movi_fecha_reg,movi_usuario,movi_estado,movi_fecha_vence, 
						  movi_comentario,movi_afiliada,movi_cierre_mensual,movi_estado_pase_conta,
						  movi_deposito,movi_cant_depo_ante,movi_saldo,movi_tran_contado,
						  movi_impreso,movi_comision_pagada,movi_transaccion_origen, movi_comments)
			  VALUES ( :str.g_financiero,:str.empresa,'NA','NB','NB',
						  :ls_doc,:li_ann,:ls_doc,:ll_tercero,:ls_ruc,:ls_naturaleza,
						  :ldc_monto_final,:ldt_fecha_trans,:ldt_actual,:str.usuario,'IM',:ldt_fecha,
						  :ls_comentario,'0','N','E',0,0,:ldc_monto_final,'N',
						  'N','N','CM',:ls_descripcion_corta)  ;
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				sqlca.autocommit = true
				mensaje('ERROR', 'Error al Insertar registros en CCTMOVIM1.', ls_error)
				return -1
			end if	
			
		
		end if			
		
	  SELECT nmcaja.mcaj_cuenta  
		 INTO :ls_mg_enc  
		 FROM nmcaja  
		WHERE nmcaja.mcaj_caja =  :ls_caja  ;
		
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			sqlca.autocommit = true
			mensaje("informacion","Error al Consultar!",ls_error  )
			return -1
		end if

	if li_paga_itbm = 0 then

		  INSERT INTO coddiari  
					( ddia_g_financiero,   
					  ddia_empresa,   
					  ddia_aplicacion_mg,   
					  ddia_tipo_transaccion,   
					  ddia_sub_trans,   
					  ddia_no_documento,   
					  ddia_no_referencia,   
					  ddia_banco_cuenta,   
					  ddia_ann,   
					  ddia_linea,   
					  ddia_mg_cuenta,   
					  ddia_monto,   
					  ddia_naturaleza,   
					  ddia_id,   
					  ddia_fecha,   
					  ddia_transito,
					  ddia_tercero)  
		  VALUES ( :str.g_financiero,   
					  :str.empresa,   
					  'NA',   
					  :ls_tran,   
					  :ls_sub,   
					  :ls_doc,   
					  :ls_referencia,   
					  '1',   
					  :li_ann,   
					  1,   
					  :ls_mg_enc,   
					  :ldc_monto_final,   
					  'C',   
					  :str.usuario,   
					  :ldt_fecha_servidor,   
					  :ls_code,
					  :ll_tercero)  ;
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					sqlca.autocommit = true
					mensaje('', 'Error al Insertar registros en Contabilidad.', ls_error)
					return -1
				end if


			  INSERT INTO coddiari  
					( ddia_g_financiero,   
					  ddia_empresa,   
					  ddia_aplicacion_mg,   
					  ddia_tipo_transaccion,   
					  ddia_sub_trans,   
					  ddia_no_documento,   
					  ddia_no_referencia,   
					  ddia_banco_cuenta,   
					  ddia_ann,   
					  ddia_linea,   
					  ddia_mg_cuenta,   
					  ddia_monto,   
					  ddia_naturaleza,   
					  ddia_id,   
					  ddia_fecha,   
					  ddia_transito,
					  ddia_tercero)  
		  VALUES ( :str.g_financiero,   
					  :str.empresa,   
					  'NA',   
					  :ls_tran,   
					  :ls_sub,   
					  :ls_doc,   
					  :ls_referencia,   
					  '1',   
					  :li_ann,   
					  2,   
					  :ls_cuenta,   
					  :ldc_monto_final,   
					  'D',   
					  :str.usuario,   
					  :ldt_fecha_servidor,   
					  :ls_code,
					  :ll_tercero)  ;		
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				sqlca.autocommit = true
				mensaje('ERROR2', 'Error al Insertar registros en el Diario', ls_error)
				return -1
			end if				
		else  //SI LLEVA ITBM
			  INSERT INTO coddiari  
					( ddia_g_financiero,   
					  ddia_empresa,   
					  ddia_aplicacion_mg,   
					  ddia_tipo_transaccion,   
					  ddia_sub_trans,   
					  ddia_no_documento,   
					  ddia_no_referencia,   
					  ddia_banco_cuenta,   
					  ddia_ann,   
					  ddia_linea,   
					  ddia_mg_cuenta,   
					  ddia_monto,   
					  ddia_naturaleza,   
					  ddia_id,   
					  ddia_fecha,   
					  ddia_transito,
					  ddia_tercero)  
		  VALUES ( :str.g_financiero,   
					  :str.empresa,   
					  'NA',   
					  :ls_tran,   
					  :ls_sub,   
					  :ls_doc,   
					  :ls_referencia,   
					  '1',   
					  :li_ann,   
					  1,   
					  :ls_mg_enc,   
					  :ldc_monto_final,   
					  'C',   
					  :str.usuario,   
					  :ldt_fecha_servidor,   
					  :ls_code,
					  :ll_tercero)  ;
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					sqlca.autocommit = true
					mensaje('', 'Error al Insertar registros en Contabilidad. itbm ', ls_error)
					return -1
				end if


			  INSERT INTO coddiari  
					( ddia_g_financiero,   
					  ddia_empresa,   
					  ddia_aplicacion_mg,   
					  ddia_tipo_transaccion,   
					  ddia_sub_trans,   
					  ddia_no_documento,   
					  ddia_no_referencia,   
					  ddia_banco_cuenta,   
					  ddia_ann,   
					  ddia_linea,   
					  ddia_mg_cuenta,   
					  ddia_monto,   
					  ddia_naturaleza,   
					  ddia_id,   
					  ddia_fecha,   
					  ddia_transito,
					  ddia_tercero)  
		  VALUES ( :str.g_financiero,   
					  :str.empresa,   
					  'NA',   
					  :ls_tran,   
					  :ls_sub,   
					  :ls_doc,   
					  :ls_referencia,   
					  '1',   
					  :li_ann,   
					  2,   
					  :ls_cuenta,   
					  :ldc_monto_t,   
					  'D',   
					  :str.usuario,   
					  :ldt_fecha_servidor,   
					  :ls_code,
					  :ll_tercero)  ;		
				if sqlca.sqlcode = -1 then
					ls_error = sqlca.sqlerrtext
					rollback;
					sqlca.autocommit = true
					mensaje('ERROR2', 'Error al Insertar registros en el Diario', ls_error)
					return -1
				end if				
						
			  INSERT INTO coddiari  
					( ddia_g_financiero,   
					  ddia_empresa,   
					  ddia_aplicacion_mg,   
					  ddia_tipo_transaccion,   
					  ddia_sub_trans,   
					  ddia_no_documento,   
					  ddia_no_referencia,   
					  ddia_banco_cuenta,   
					  ddia_ann,   
					  ddia_linea,   
					  ddia_mg_cuenta,   
					  ddia_monto,   
					  ddia_naturaleza,   
					  ddia_id,   
					  ddia_fecha,   
					  ddia_transito,
					  ddia_tercero)  
		  VALUES ( :str.g_financiero,   
					  :str.empresa,   
					  'NA',   
					  :ls_tran,   
					  :ls_sub,   
					  :ls_doc,   
					  :ls_referencia,   
					  '1',   
					  :li_ann,   
					  3,   
					  :ls_mg_itbm,   
					  :ldc_valor_itbm,   
					  'D',   
					  :str.usuario,   
					  :ldt_fecha_servidor,   
					  :ls_code,
					  :ll_tercero)  ;		
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			rollback;
			sqlca.autocommit = true
			mensaje('ERROR2', 'Error al Insertar registros en el Diario', ls_error)
			return -1
		end if				


		end if
	else
//		dw_1.setitem(ll_count, 'desem_status', 'R')
		
		if dw_1.getitemnumber(ll_count, 'desem_cuenta') = 1 then //CXC DEL BARCO
			DELETE banadpagar  
			 WHERE ( banadpagar.dpaga_g_financiero = :str.g_financiero ) AND  
					 ( banadpagar.dpaga_empresa = :str.empresa ) AND  
					 ( banadpagar.dpaga_documento = :ls_doc ) AND  
					 ( banadpagar.dpaga_agno = :li_ann ) AND  
					 ( banadpagar.dpaga_aplicacion = 'NA' ) AND  
					 ( banadpagar.dpaga_transaccion = :ls_tran ) AND  
					 ( banadpagar.dpaga_subtransaccion = :ls_sub )   ;
			
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				sqlca.autocommit = true
				mensaje("Atención ","¡Error al Eliminar BANADPAGAR!", ls_error)				
				return -1
			end if
			
			DELETE banatpagar  
			 WHERE ( banatpagar.tpaga_g_financiero = :str.g_financiero ) AND  
					 ( banatpagar.tpaga_empresa = :str.empresa ) AND  
					 ( banatpagar.tpaga_documento = :ls_doc ) AND  
					 ( banatpagar.tpaga_agno = :li_ann ) AND  
					 ( banatpagar.tpaga_aplicacion = 'NA' ) AND  
					 ( banatpagar.tpaga_transaccion = :ls_tran ) AND  
					 ( banatpagar.tpaga_subtransaccion = :ls_sub )   ;	
			
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				sqlca.autocommit = true
				mensaje("Atención ","¡Error al Eliminar BANATPAGAR!", ls_error)				
				return -1
			end if
		elseif dw_1.getitemnumber(ll_count, 'desem_cuenta') = 2 then //CXC DEL CLIENTE
			DELETE cctmovim
			 WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
					 ( cctmovim.movi_empresa = :str.empresa ) AND  
					 ( cctmovim.movi_aplicacion = 'NA' ) AND  
					 ( cctmovim.movi_tipo_transaccion = 'NB' ) AND  
					 ( cctmovim.movi_sub_transaccion = 'NB' ) AND  
					 ( cctmovim.movi_documento = :ls_doc ) AND  
					 ( cctmovim.movi_anno = :li_ann ) AND  
					 ( cctmovim.movi_referencia = :ls_doc ) AND
					 ( cctmovim.movi_transaccion_origen = :ls_tran )	;

			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				rollback;
				sqlca.autocommit = true
				mensaje('ERROR', 'Error al Eliminar los registros en CCTMOVIM1.', ls_error)
				return -1
			end if	
		elseif dw_1.getitemnumber(ll_count, 'desem_cuenta') = 4 then //CXC DEL P AND I CLUB
					
		end if
	end if
next

if dw_1.update() = 1 then
	commit;
	sqlca.autocommit = true
	mensaje('Información', 'Operación Exitosa.', '')
	
	dw_3.setfilter('ind = 1')
	dw_3.filter()
	dw_3.setsort(ls_sort)	
	dw_3.sort()
	dw_3.groupcalc()
	dw_3.visible = true
	dw_3.object.datawindow.print.preview="yes"

	ls_masca = gf_co_mascara_de_cuentas()
	dw_3.MODIFY("ntdesem_desem_cuenta_mg.editmask.mask='"+ls_masca+"'")

	cb_2.visible = true
	
	dw_1.reset()
//	close(w_na_aprobaciones_desem)
else
	rollback;
	sqlca.autocommit = true
	mensaje('ATENCIÓN', 'Error al Actualizar.', '')
end if
sqlca.autocommit = true

end event

type dw_3 from datawindow within w_cierre_caja
boolean visible = false
integer x = 27
integer y = 244
integer width = 3424
integer height = 1780
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Reembolso"
string dataobject = "dw_na_rep_caja_menuda_2"
boolean controlmenu = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cb_2 from commandbutton within w_cierre_caja
boolean visible = false
integer x = 2240
integer y = 1312
integer width = 475
integer height = 100
integer taborder = 120
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Imprimir"
end type

event clicked;OpenWithParm(w_dw_print_options, dw_3)

If Message.DoubleParm = -1 Then Return
dw_3.Print(True)

end event

type em_rango_inicio from editmask within w_cierre_caja
integer x = 1541
integer y = 140
integer width = 311
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "#####"
boolean spin = true
end type

type st_4 from statictext within w_cierre_caja
integer x = 1595
integer y = 76
integer width = 535
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12639424
string text = "Comprobantes"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_cierre_caja
integer x = 1326
integer y = 160
integer width = 187
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12639424
string text = "Desde"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_6 from statictext within w_cierre_caja
integer x = 1888
integer y = 156
integer width = 178
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 12639424
string text = "Hasta"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_rango_fin from editmask within w_cierre_caja
integer x = 2089
integer y = 136
integer width = 311
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "#####"
boolean spin = true
end type

type cb_3 from commandbutton within w_cierre_caja
integer x = 2542
integer y = 136
integer width = 521
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Reporte de Cierre"
end type

event clicked;str_dg_general str_parametro
long ll_codigo_inicial, ll_codigo_final

if dw_1.rowcount() = 0 then return

setnull(str_parametro.variable1)
setnull(str_parametro.numero1)
setnull(str_parametro.numero2)

str_parametro.variable1 = dw_2.getitemstring(dw_2.getrow(),"caja")	//Caja de los Vouchers a Imprimir
str_parametro.numero1 = long(em_rango_inicio.text) 						//Rango del Voucher Inicial
str_parametro.numero2 = long(em_rango_fin.text)								//Rango del Voucher Final
str_parametro.numero3 = 0			 //Envio del Año, para que en sqlpreview no recupere por el año
str_parametro.variable2 = 'S'		 //Es el Estatus de los desembolsos, para que desde aqui solo salgan los que son Solicitudes

ll_codigo_inicial = dw_1.getitemnumber(1,"desem_desembolso")
ll_codigo_final = dw_1.getitemnumber(dw_1.rowcount(),"desem_desembolso")

IF str_parametro.numero1 <> 0 THEN
	IF str_parametro.numero1 < ll_codigo_inicial THEN
		messagebox("Error","El rango inicial no debe ser menor que el menor número que posee un voucher")
		return
	END IF
else
	str_parametro.numero1 = ll_codigo_inicial
END IF

IF str_parametro.numero2 <> 0 THEN
	IF str_parametro.numero2 > ll_codigo_final THEN
		messagebox("Error","El rango final no debe ser mayor que el mayor número que posee un voucher")
		return	
	END IF
ELSE
	str_parametro.numero2 = ll_codigo_final	
END IF

OpenSheetWithParm(w_na_rep_lote_caja_menuda,str_parametro,str.frame,9,Layered!)
end event

type em_1 from editmask within w_cierre_caja
integer x = 2633
integer y = 32
integer width = 402
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
boolean spin = true
end type

type st_3 from statictext within w_cierre_caja
integer x = 2194
integer y = 52
integer width = 425
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 553648127
string text = "Fecha de cierre"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_cierre_caja
integer x = 32
integer width = 3045
integer height = 276
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
end type

type gb_2 from groupbox within w_cierre_caja
integer x = 32
integer y = 268
integer width = 3547
integer height = 1680
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
end type

