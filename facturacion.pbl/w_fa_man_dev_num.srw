//objectcomments Asignación del Número de la factura y otros detalles en las Devoluciones
forward
global type w_fa_man_dev_num from window
end type
type cb_3 from commandbutton within w_fa_man_dev_num
end type
type sle_1 from singlelineedit within w_fa_man_dev_num
end type
type st_5 from statictext within w_fa_man_dev_num
end type
type cbx_cliente from checkbox within w_fa_man_dev_num
end type
type cbx_inventario from checkbox within w_fa_man_dev_num
end type
type em_fecha from editmask within w_fa_man_dev_num
end type
type st_4 from statictext within w_fa_man_dev_num
end type
type p_1 from picture within w_fa_man_dev_num
end type
type st_pedido from statictext within w_fa_man_dev_num
end type
type st_3 from statictext within w_fa_man_dev_num
end type
type st_num_movi from statictext within w_fa_man_dev_num
end type
type st_movimiento from statictext within w_fa_man_dev_num
end type
type st_nombre from statictext within w_fa_man_dev_num
end type
type st_codigo from statictext within w_fa_man_dev_num
end type
type st_2 from statictext within w_fa_man_dev_num
end type
type cbx_setup from checkbox within w_fa_man_dev_num
end type
type st_nom_ventana from statictext within w_fa_man_dev_num
end type
type cb_2 from commandbutton within w_fa_man_dev_num
end type
type sle_no_factura from singlelineedit within w_fa_man_dev_num
end type
type st_1 from statictext within w_fa_man_dev_num
end type
type cb_1 from commandbutton within w_fa_man_dev_num
end type
type gb_2 from groupbox within w_fa_man_dev_num
end type
type gb_1 from groupbox within w_fa_man_dev_num
end type
end forward

global type w_fa_man_dev_num from window
integer x = 832
integer y = 360
integer width = 1993
integer height = 1132
boolean titlebar = true
string title = "(FA) Imprimir Devoluciones"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79416533
event ue_post_open ( )
event ue_syscommand pbm_syscommand
cb_3 cb_3
sle_1 sle_1
st_5 st_5
cbx_cliente cbx_cliente
cbx_inventario cbx_inventario
em_fecha em_fecha
st_4 st_4
p_1 p_1
st_pedido st_pedido
st_3 st_3
st_num_movi st_num_movi
st_movimiento st_movimiento
st_nombre st_nombre
st_codigo st_codigo
st_2 st_2
cbx_setup cbx_setup
st_nom_ventana st_nom_ventana
cb_2 cb_2
sle_no_factura sle_no_factura
st_1 st_1
cb_1 cb_1
gb_2 gb_2
gb_1 gb_1
end type
global w_fa_man_dev_num w_fa_man_dev_num

type variables
//Variables
Datawindow idw_dw, dw
integer ii_pormayor, ii_invent, ii_cliente,ii_an, ii_sec_fac_nc
string is_pedido, is_retornar, is_tipo_fac
end variables

forward prototypes
public function string wf_verifica_secuencia ()
public function string wf_busca_fac (long al_max)
public function string wf_valida_secuencia (string as_sec, integer ai_flag)
public function string wf_secuencia_cxc ()
end prototypes

event ue_post_open;string 	ls_tipo_movi, ls_tipo_venta, ls_estado, ls_factura, ls_secuencia
date 		lda_fecha
integer   li_fac_igual_pedido
long 		ll_num_cli, ll_num_movi

//Recibe el Datawindow como parametro
idw_dw = message.PowerobjectParm

if idw_dw.rowcount() = 0 then
	mensaje("Atención Sr. Usuario","No se Pudieron Recuperar los Datos Satisfactoriamente","")
	this.triggerevent("close")
else
	//Extraigo el pedido y el pormayor del datawindow de parametros
	is_pedido  = idw_dw.getitemstring(idw_dw.getrow(),"fact_no_pedido")
	is_tipo_fac= idw_dw.getitemString(idw_dw.getrow(),"fact_tipo")
	ii_an		  = idw_dw.getitemnumber(idw_dw.getrow(),"fact_ann")
	
	//Asigno los campos del datawindow a los de la ventana (Solo lectura)
	
	st_pedido.text = idw_dw.getitemstring(idw_dw.getrow(),"fact_no_pedido")
	ll_num_cli = idw_dw.getitemnumber(idw_dw.getrow(),"fact_cliente")
	st_nombre.text = idw_dw.getitemstring(idw_dw.getrow(),"fact_a_nombre")
	ll_num_movi = idw_dw.getitemnumber(idw_dw.getrow(),"fact_no_traspaso")
	ls_tipo_movi = idw_dw.getitemstring(idw_dw.getrow(),"fact_tipo_movimiento")
//	lda_fecha = date(idw_dw.getitemdatetime(idw_dw.getrow(),"fact_fecha"))
	st_codigo.text = string(ll_num_cli)
	st_num_movi.text = string(ll_num_movi)
	em_fecha.text =  w_fa_man_devolucion.em_fecha.text	
	
	CHOOSE CASE ls_tipo_movi
		CASE "T"
			st_movimiento.text="Traspaso :"		
		CASE "S"
			st_movimiento.text="Salida :"
		CASE "O"
			st_movimiento.text="Otros :"
	END CHOOSE
	
	//Asigno el estado de la Factura a una variable
	ls_estado  = idw_dw.getitemstring(idw_dw.getrow(),"fact_estado")
	ls_factura = idw_dw.getitemstring(idw_dw.getrow(),"fact_no_factura")
	
	//Nombre de la ventana
	st_nom_ventana.text = this.classname()
	
	ls_tipo_venta = w_fa_fondo.str_para.tipo
	li_fac_igual_pedido = w_fa_fondo.str_para.fac_igual_ped
	
	//Asigna el tipo de secuencia que utiliza el cliente, de facturas o de NC de CxC
	ii_sec_fac_nc = w_fa_fondo.str_para.nc_o_fac

	if ii_sec_fac_nc = 1 then //Si selecciona secuencias de facturas.

		if li_fac_igual_pedido = 0	then		//Si no son iguales las secuencias
		  if ls_estado = "I" then  //Factura ya fue Impresa
				sle_no_factura.text = ls_factura
				sle_no_factura.DisplayOnly = true
		  else
			
				SELECT faaparam.fara_ult_ultima_factura
				INTO :ls_secuencia  
				FROM faaparam  
				WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
					 ( faaparam.fara_empresa = :str.empresa )   ;

				if sqlca.sqlcode = -1 then
					gf_mensaje("","Error al seleccionar la secuencia "+sqlca.sqlerrtext,1,1,"")
					
				end if
				
				if ls_secuencia = '0' then ls_secuencia = '1'

				// Devuelve la próxima secuencia disponible
				ls_secuencia = wf_valida_secuencia(ls_secuencia,0)
				sle_no_factura.text = ls_secuencia
				
		  end if
		  
		else
			
			if ls_estado = "I" then  //Factura ya fue Impresa, lo puse aquí por si cambian esta opcion
				sle_no_factura.text = ls_factura
			else
			//Si son iguales las secuencias de pedidos a las de facturas
			//le seteo el numero de pedido a la factura	
			
			 sle_no_factura.text=is_pedido
			end if
			 
			 //De solo lectura
			 sle_no_factura.DisplayOnly = true
		end if
	else
		if ls_estado = "I" then  //Factura ya fue Impresa
			sle_no_factura.text = ls_factura
			sle_no_factura.DisplayOnly = true
		else
			sle_no_factura.text=wf_secuencia_cxc()
		end if
	end if
		
		//Asigno 1 (activo o Checked) a las variables de actualizacion de inventario y cliente
		//si el estado de la factura es activa, de lo contrario, pongo lo que tiene la BD.
	if ls_estado = "I" then
		ii_cliente = idw_dw.getitemnumber(idw_dw.getrow(),"fact_act_cliente")
		ii_invent = idw_dw.getitemnumber(idw_dw.getrow(),"fact_act_inventario")
		if ii_cliente = 1 then 	cbx_cliente.checked = true
		if ii_invent  = 1 then 	cbx_inventario.checked = true		
		cbx_cliente.Enabled = false
		cbx_inventario.Enabled = false
	else
		
		if w_fa_fondo.str_para.act_cliente = "S"	then
			ii_cliente	= 1
			cbx_cliente.checked = true
		else
			ii_cliente	= 0
			cbx_cliente.checked = false
		end if	
		
		if w_fa_fondo.str_para.act_inventario = "S"	then
			ii_invent	= 1
			cbx_inventario.checked = true
		else
			 ii_invent = 0
			 cbx_inventario.checked = false
		end if
		
	end if	
	
	p_1.picturename = str.path+"art\prnbatch.bmp"
	
end if //del If rowcount() > 0
	
end event

event ue_syscommand;if commandtype = 61536 then
	message.Processed	= true
	return 1
end if
end event

public function string wf_verifica_secuencia ();integer li_max
string ls_estado


ls_estado=wf_busca_fac(li_max)

return ls_estado
end function

public function string wf_busca_fac (long al_max);integer li_existe,li_existep
long    ll_max
string  ls_max, ls_estado,ls_pedido

ls_pedido = st_pedido.text
ll_max = al_max

DO	
  ls_max = string(ll_max)

  SELECT count(*)
    INTO :li_existe  
    FROM fatdiari  
   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND
   		     ( fatdiari.fact_empresa = :str.empresa ) AND
			( fatdiari.fact_ann = :ii_an ) AND
			( fatdiari.fact_no_pedido like '%NC%' ) and	
	   		( fatdiari.fact_no_factura = :ls_max ) ;
			
			if sqlca.sqlcode = -1 then
				mensaje("Aviso","Error al Verificar Existencia de ",sqlca.sqlerrtext)					
			end if

      if li_existe > 0 then
		  SELECT count(*)
			 INTO :li_existep  
			 FROM fatdiari  
			WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND
					( fatdiari.fact_empresa = :str.empresa ) AND
					( fatdiari.fact_ann = :ii_an ) AND
		   		( fatdiari.fact_no_pedido = :ls_pedido ) and 
					( fatdiari.fact_no_factura = :ls_max );
					
					if sqlca.sqlcode = -1 then
						mensaje("Aviso","Error al Verificar Existencia de la factura",sqlca.sqlerrtext)
					end if
					
				If li_existep = 1 then
					li_existe = 0 /*La factura ya existe corresponde a este pedido*/
				end if
	   end if
		
		ll_max ++

	LOOP UNTIL li_existe = 0

return(ls_max)


/// comentado 08/08/2001
//integer li_existe
//long    ll_max
//string  ls_max, ls_estado
//
//ll_max = al_max
//
//DO	
//  ls_max = string(ll_max)
//
//  SELECT count(*)
//    INTO :li_existe  
//    FROM fatdiari  
//   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND
//         ( fatdiari.fact_empresa = :str.empresa ) AND
//			( fatdiari.fact_ann = :ii_an ) AND
//			( fatdiari.fact_no_pedido like '%NC%' ) and			
//   		( fatdiari.fact_no_factura = :ls_max ) ;
//			
//			if sqlca.sqlcode = -1 then
//				mensaje("Aviso","Error al Verificar Existencia de ",sqlca.sqlerrtext)					
//			end if
//	
//	//Selecciona el estado de dicha factura, si esta activa, que le ponga el numero de la factura
//	SELECT fact_estado
//    INTO :ls_estado  
//    FROM fatdiari  
//   WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND
//         ( fatdiari.fact_empresa = :str.empresa ) AND
//			( fatdiari.fact_ann = :ii_an ) AND			
//			( fatdiari.fact_no_pedido like '%NC%' ) and
//   		( fatdiari.fact_no_factura = :ls_max );		
//			if sqlca.sqlcode = -1 then
//				mensaje("Aviso","Error al Verificar el Estado de la Factura",sqlca.sqlerrtext)					
//			end if			
//		//para que salga		
//		if ls_estado = 'A' then
//			li_existe = 0
//		end if
//
//		ll_max = ll_max + 1
//
//	LOOP UNTIL li_existe = 0
//
//return(ls_max)
end function

public function string wf_valida_secuencia (string as_sec, integer ai_flag);string ls_secuencia 
long   ll_temp
integer li_existe
		 
  ll_temp = long(as_sec)												
  
  if ll_temp <= 0 then
	
	  ls_secuencia = as_sec
	  
		SELECT count(*)
		 INTO :li_existe  
		 FROM fatdiari  
		WHERE ( fatdiari.fact_g_financiero = :str.g_financiero ) AND
				( fatdiari.fact_empresa = :str.empresa ) AND
		//		( fatdiari.fact_tipo = :is_tipo ) AND
				( fatdiari.fact_ann = :ii_an ) AND	
				( fatdiari.fact_no_pedido like '%NC%' ) and
				( fatdiari.fact_no_factura = :ls_secuencia );			
			if sqlca.sqlcode = -1 then
				mensaje("Aviso","Error al Verificar Existencia de la Devolucion",sqlca.sqlerrtext)
			end if
		if li_existe > 0 then
			gf_mensaje("","Devolución ya Existe, Verifique.",1,1,"E")
			sle_no_factura.text = '0'
			return ''
		end if
		
  else												
	  ls_secuencia = wf_busca_fac(ll_temp)
  end if
  //cuando se llama desde el postopen, que no envíe el mensaje
  if ai_flag = 1 then  //Si es uno, es porque se llamó desde la modificación del numero
	  if as_sec <> ls_secuencia then
		 messagebox("ATENCIÓN SR. USUARIO","No. de Devolucion Ajustado al Siguiente Disponible",Exclamation!)	
	  end if
  end if

return(ls_secuencia)
end function

public function string wf_secuencia_cxc ();string ls_secuencia

//   SELECT faaparam.fara_ult_devolucion  
//    INTO :ls_secuencia  
//    FROM faaparam  
//   WHERE ( faaparam.fara_g_financiero = :str.g_financiero ) AND  
//         ( faaparam.fara_empresa = :str.empresa );
//		if sqlca.sqlcode = -1 then
//			mensaje('Aviso','Error al seleccionar la secuencia',sqlca.sqlerrtext)
//		end if
//	

  SELECT convert(varchar(8),max(mser_secuencia) + 1 )
    INTO :ls_secuencia
    FROM dgmserie  
   WHERE ( dgmserie.mser_g_financiero = :str.g_financiero ) AND  
         ( dgmserie.mser_empresa = :str.empresa ) AND  
         ( dgmserie.mser_tipo_transaccion = 'NC' ) ;
		if sqlca.sqlcode = -1 then
			mensaje('Aviso','Error al seleccionar la secuencia de NC',sqlca.sqlerrtext)
		end if

  ls_secuencia = wf_valida_secuencia(ls_secuencia, 0)	
 

return(ls_secuencia)
end function

on w_fa_man_dev_num.create
this.cb_3=create cb_3
this.sle_1=create sle_1
this.st_5=create st_5
this.cbx_cliente=create cbx_cliente
this.cbx_inventario=create cbx_inventario
this.em_fecha=create em_fecha
this.st_4=create st_4
this.p_1=create p_1
this.st_pedido=create st_pedido
this.st_3=create st_3
this.st_num_movi=create st_num_movi
this.st_movimiento=create st_movimiento
this.st_nombre=create st_nombre
this.st_codigo=create st_codigo
this.st_2=create st_2
this.cbx_setup=create cbx_setup
this.st_nom_ventana=create st_nom_ventana
this.cb_2=create cb_2
this.sle_no_factura=create sle_no_factura
this.st_1=create st_1
this.cb_1=create cb_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.cb_3,&
this.sle_1,&
this.st_5,&
this.cbx_cliente,&
this.cbx_inventario,&
this.em_fecha,&
this.st_4,&
this.p_1,&
this.st_pedido,&
this.st_3,&
this.st_num_movi,&
this.st_movimiento,&
this.st_nombre,&
this.st_codigo,&
this.st_2,&
this.cbx_setup,&
this.st_nom_ventana,&
this.cb_2,&
this.sle_no_factura,&
this.st_1,&
this.cb_1,&
this.gb_2,&
this.gb_1}
end on

on w_fa_man_dev_num.destroy
destroy(this.cb_3)
destroy(this.sle_1)
destroy(this.st_5)
destroy(this.cbx_cliente)
destroy(this.cbx_inventario)
destroy(this.em_fecha)
destroy(this.st_4)
destroy(this.p_1)
destroy(this.st_pedido)
destroy(this.st_3)
destroy(this.st_num_movi)
destroy(this.st_movimiento)
destroy(this.st_nombre)
destroy(this.st_codigo)
destroy(this.st_2)
destroy(this.cbx_setup)
destroy(this.st_nom_ventana)
destroy(this.cb_2)
destroy(this.sle_no_factura)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;this.postevent("ue_post_open")
end event

event close;CloseWithReturn(this,is_retornar)
end event

type cb_3 from commandbutton within w_fa_man_dev_num
integer x = 1239
integer y = 720
integer width = 361
integer height = 104
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Actualizar"
end type

event clicked;// Para la impresion de la factura
integer	li_resultado, li_inven, li_cliente
String	lsqlerrtext
dw = idw_dw

Message.DoubleParm = 0

if sle_no_factura.text = "0" or isnull(sle_no_factura.text) or sle_no_factura.text = " " then
	
	messagebox("ATENCION SR. USUARIO","Introduzca el # de Devolucion Correcto",stopsign!)

	sle_no_factura.setfocus()
	
	sle_no_factura.undo()		//Restaura el Numero de Factura anterior

else
	
	cb_1.enabled = false //Deshabilito impresion
	
	// Si marco el checkbotom entra al setup de impresión
	if cbx_setup.checked = true then OpenWithParm(w_dw_print_options, dw)
	
	If Message.DoubleParm = -1 Then 
		cb_1.enabled = true
		cb_2.enabled = true
		Return
	end if
	
	cb_2.enabled = false
	
	li_resultado = 1 //dw.Print(true)		//Manda a imprimir la factura

	// Valida si se le dio cancelar a la impresion, que no cierre la ventana
	
	if isvalid(dw) then	is_retornar=sle_no_factura.text+"="+string(li_resultado)+"_"+string(ii_invent)+"*"+string(ii_cliente)+"\"+em_fecha.text
	
	close(parent)
	
end if	
end event

type sle_1 from singlelineedit within w_fa_man_dev_num
string tag = "Que no se habilite el boton de imprimir si no se ha introducido la autorizacion"
integer x = 754
integer y = 532
integer width = 338
integer height = 80
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_fa_man_dev_num
integer x = 206
integer y = 548
integer width = 485
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
boolean enabled = false
string text = "Autorizada por :"
alignment alignment = right!
boolean focusrectangle = false
end type

type cbx_cliente from checkbox within w_fa_man_dev_num
integer x = 1371
integer y = 560
integer width = 315
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Cliente"
end type

event clicked;//Seteo el valor de 0 o 1 aL CLIENTE
integer li_seguro
if cbx_cliente.Checked = true then
	ii_cliente	=	1
else
	li_seguro = messagebox("ATENCIÓN SR. USUARIO","Está seguro de NO afectar la Cuenta del Cliente",question!,YesNo!,2)
	if li_seguro = 1 then
		ii_cliente 	= 	0
	else
		cbx_cliente.Checked = true
	end if	
end if

end event

type cbx_inventario from checkbox within w_fa_man_dev_num
integer x = 1371
integer y = 468
integer width = 411
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Inventario"
end type

event clicked;//Seteo el valor de 0 o 1 al inventario
integer li_seguro
if cbx_inventario.Checked = true then
	ii_invent	=	1
else
	li_seguro = messagebox("ATENCIÓN SR. USUARIO","Está seguro de NO rebajar la mercancía de Inventario",question!,YesNo!,2)
	if li_seguro = 1 then
		ii_invent 	= 	0
	else
		cbx_inventario.Checked = true
	end if	
end if

end event

type em_fecha from editmask within w_fa_man_dev_num
string tag = "Fecha de la factura"
integer x = 1394
integer y = 100
integer width = 384
integer height = 80
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
string displaydata = "8"
end type

type st_4 from statictext within w_fa_man_dev_num
integer x = 1175
integer y = 112
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
boolean enabled = false
string text = "Fecha :"
boolean focusrectangle = false
end type

type p_1 from picture within w_fa_man_dev_num
integer x = 421
integer y = 732
integer width = 96
integer height = 84
boolean originalsize = true
string picturename = "\art\prnbatch.bmp"
boolean focusrectangle = false
end type

type st_pedido from statictext within w_fa_man_dev_num
integer x = 754
integer y = 188
integer width = 338
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_3 from statictext within w_fa_man_dev_num
integer x = 434
integer y = 196
integer width = 256
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
boolean enabled = false
string text = "Pedido :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_num_movi from statictext within w_fa_man_dev_num
integer x = 754
integer y = 432
integer width = 338
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_movimiento from statictext within w_fa_man_dev_num
integer x = 293
integer y = 448
integer width = 398
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
boolean enabled = false
string text = "movimiento"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre from statictext within w_fa_man_dev_num
integer x = 677
integer y = 304
integer width = 1184
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_codigo from statictext within w_fa_man_dev_num
integer x = 302
integer y = 304
integer width = 334
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within w_fa_man_dev_num
integer x = 59
integer y = 308
integer width = 238
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
boolean enabled = false
string text = "Cliente :"
boolean focusrectangle = false
end type

type cbx_setup from checkbox within w_fa_man_dev_num
integer x = 64
integer y = 844
integer width = 658
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Configurar Impresora"
boolean lefttext = true
end type

type st_nom_ventana from statictext within w_fa_man_dev_num
integer x = 27
integer y = 960
integer width = 1088
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
boolean enabled = false
string text = "Nom_ventana"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_fa_man_dev_num
integer x = 901
integer y = 720
integer width = 306
integer height = 104
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;is_retornar = sle_no_factura.text+"="+string(-1)+"_"+string(ii_invent)+"*"+string(ii_cliente)
close(parent)
end event

type sle_no_factura from singlelineedit within w_fa_man_dev_num
string tag = "Numero de la factura a grabar"
integer x = 754
integer y = 88
integer width = 338
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
boolean autohscroll = false
textcase textcase = upper!
integer limit = 8
borderstyle borderstyle = stylelowered!
end type

event modified;string ls_secuencia
// validar que la secuencia de la factura sea la correcta a imprimir y actualizar
// messagebox("modified",sle_no_factura.text)
// wf_verifica_secuencia()
ls_secuencia = wf_valida_secuencia(sle_no_factura.text,1)

if ls_secuencia <> sle_no_factura.text then
	sle_no_factura.text = ls_secuencia
end if
end event

type st_1 from statictext within w_fa_man_dev_num
integer x = 270
integer y = 100
integer width = 421
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
boolean enabled = false
string text = "Devolución # :"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_fa_man_dev_num
event clicked pbm_bnclicked
integer x = 544
integer y = 720
integer width = 325
integer height = 104
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Imprimir"
end type

event clicked;// Para la impresion de la factura
integer	li_resultado, li_inven, li_cliente
String	lsqlerrtext
long     i
dw = idw_dw

Message.DoubleParm = 0

if sle_no_factura.text = "0" or isnull(sle_no_factura.text) or sle_no_factura.text = " " then
	
	messagebox("ATENCION SR. USUARIO","Introduzca el # de Devolucion Correcto",stopsign!)

	sle_no_factura.setfocus()
	
	sle_no_factura.undo()		//Restaura el Numero de Factura anterior

else
	
	cb_1.enabled = false //Deshabilito impresion
	
	// Si marco el checkbotom entra al setup de impresión
	if cbx_setup.checked = true then OpenWithParm(w_dw_print_options, dw)
	
	If Message.DoubleParm = -1 Then 
		cb_1.enabled = true
		cb_2.enabled = true
		Return
	end if
	
	cb_2.enabled = false
	
	for i = 1 to dw.rowcount() //no funciona el First con la fecha
		dw.setitem(i,"fact_fecha", date(em_fecha.text))
		dw.setitem(i,"fact_no_factura",sle_no_factura.text)	//Seteo el No Factura
	next
	
	li_resultado = dw.Print(true)		//Manda a imprimir la factura

	// Valida si se le dio cancelar a la impresion, que no cierre la ventana
	
	if isvalid(dw) then	is_retornar=sle_no_factura.text+"="+string(li_resultado)+"_"+string(ii_invent)+"*"+string(ii_cliente)+"\"+em_fecha.text
	
	close(parent)
	
end if	
end event

type gb_2 from groupbox within w_fa_man_dev_num
integer x = 1225
integer y = 396
integer width = 645
integer height = 252
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Actualizar"
end type

type gb_1 from groupbox within w_fa_man_dev_num
integer x = 18
integer y = 12
integer width = 1934
integer height = 936
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79416533
string text = "Detalles de la Impresión"
end type

