forward
global type w_mant_gastos from w_fa_padre
end type
type dw_2 from datawindow within w_mant_gastos
end type
type dw_3 from datawindow within w_mant_gastos
end type
end forward

global type w_mant_gastos from w_fa_padre
integer width = 3383
integer height = 1720
string title = "Asignacion de Gastos"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 8421376
string icon = "AppIcon!"
windowanimationstyle openanimation = toproll!
windowanimationstyle closeanimation = toproll!
dw_2 dw_2
dw_3 dw_3
end type
global w_mant_gastos w_mant_gastos

type variables
datawindowchild idwc_clientes, idwc_tran, idwc_stran, idwc_sin, idwc_nave
string is_tran, is_stran, is_tran_automatica, is_ult_tran
integer ii_ann, ii_act = 0, ii_inserta = 1
long il_cliente
boolean ib_eliminar = false
end variables

forward prototypes
public function string wf_secuencia_tran ()
public subroutine wf_verificar_transitos (string as_sin)
public function string wf_busca_transito ()
end prototypes

public function string wf_secuencia_tran ();string ls_sec
long ll_max
integer li_existe, li_ann

li_ann = dw_1.getitemnumber(1,'movi_anno')

select max(convert(numeric(8),mser_secuencia))
into :ll_max
from dgmserie
where mser_g_financiero = :str.g_financiero and
	 	mser_empresa		= :str.empresa and
		mser_tipo_transaccion = :is_tran ;
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
				movi_tipo_transaccion = :is_tran and
				movi_sub_transaccion = :is_stran and
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

public subroutine wf_verificar_transitos (string as_sin);// Busca todo los tránsitos abiertos para un barco y los muestra en un mensaje.

integer li_cont
string ls_mensaje,ls_transito,ls_puerto,ls_descrip_puerto
long ll_fila
datetime ldt_fecha_llegada


SELECT count(*)  
  INTO :li_cont
  FROM ntransito  
 WHERE ( ntransito.tran_g_financiero = :str.g_financiero ) AND  
		 ( ntransito.tran_empresa = :str.empresa ) AND  
		 ( ntransito.tran_barco = :as_sin )   AND
		 ( ntransito.tran_estado = 'A' ) ;

if sqlca.sqlcode = - 1 then
	mensaje('Atención','Error al Seleccionar registros en NATRANSITO', sqlca.sqlerrtext)
	return
end if

IF li_cont > 0 THEN
	dw_2.retrieve(str.g_financiero,str.empresa,as_sin)
	IF dw_2.rowcount() > 0 THEN
		ls_mensaje = 'EL BARCO SELECCIONADO TIENE LOS SIGUIENTES TRÁNSITOS ABIERTOS: ~n'
		FOR ll_fila = 1 TO dw_2.rowcount()
			ls_transito = dw_2.getitemstring(ll_fila,"tran_transito")
			ldt_fecha_llegada = dw_2.getitemdatetime(ll_fila,"tran_fecha_llegada")
			ls_puerto = dw_2.getitemstring(ll_fila,"tran_puerto")
			
			SELECT nmpuerto.mpuert_nombre  
			  INTO :ls_descrip_puerto 
			  FROM nmpuerto  
			 WHERE nmpuerto.mpuert_puerto = :ls_puerto   ;

			if sqlca.sqlcode = - 1 then
				mensaje('Atención','Error al Seleccionar registros ', sqlca.sqlerrtext)
				return
			end if
			
			ls_mensaje = ls_mensaje + '~n' + ls_transito + '    ' + string(ldt_fecha_llegada,'mm/dd/yyyy') + '    ' + ls_descrip_puerto
		NEXT	
		messagebox("Atención",ls_mensaje + '~n~nVERIFIQUE LA INFORMACIÓN, PARA EVITAR QUE HAYA DUPLICIDAD DE LA MISMA.')
	END IF
END IF
end subroutine

public function string wf_busca_transito ();string ls_iniciales, ls_transito, ls_tran
long ll_transito
date ldt_fecha
integer li_existe

ldt_fecha = date(gf_fecha_serv())

  SELECT nmparam.para_emp_iniciales,   
			isnull(nmparam.para_ult_transito, '')
	 INTO :ls_iniciales,   
			:ls_transito  
	 FROM nmparam  
	WHERE ( nmparam.para_g_financiero = :str.g_financiero ) AND  
			( nmparam.para_empresa = :str.empresa )   ;
		if sqlca.sqlcode = -1 then
			mensaje('Atención', 'Error al Actualizar Registros en NAMPARAM', sqlca.sqlerrtext)
		end if

if ls_transito = '' then ls_transito = '0'
ll_transito = long(ls_transito) + 1

ls_transito = string(ll_transito)
is_ult_tran = string(ll_transito)

CHOOSE CASE len(ls_transito)
CASE 1
	ls_transito = '000'+ls_transito
CASE 2
	ls_transito = '00'+ls_transito
CASE 3
	ls_transito = '0'+ls_transito
CASE 4
	ls_transito = +ls_transito
END CHOOSE

ls_tran = ls_iniciales + '-'+ls_transito+'-'+ string(year(ldt_fecha))

  SELECT count(ntransito.tran_transito)
    INTO :li_existe  
    FROM ntransito  
   WHERE ( ntransito.tran_g_financiero = :str.g_financiero ) AND  
         ( ntransito.tran_empresa = :str.empresa ) AND  
         ( ntransito.tran_transito = :ls_tran )   ;
	if sqlca.sqlcode = -1 then
		mensaje('Atención', 'Error al Seleccionar Registros en NATRANSITO', sqlca.sqlerrtext)
	end if

if li_existe > 0 then

  DO	//Ciclo para verificar si existe el transito, si existe, incremente hasta encontrar el ultimo
	
		ll_transito = long(ls_transito) + 1
	
		ls_transito = string(ll_transito)
		is_ult_tran = string(ll_transito)
		
		CHOOSE CASE len(ls_transito)
		CASE 1
			ls_transito = '000'+ls_transito
		CASE 2
			ls_transito = '00'+ls_transito
		CASE 3
			ls_transito = '0'+ls_transito
		CASE 4
			ls_transito = +ls_transito
		END CHOOSE
	
		ls_tran = ls_iniciales + '-'+ls_transito+'-'+ string(year(ldt_fecha))
	
		  SELECT count(ntransito.tran_transito)
			 INTO :li_existe  
			 FROM ntransito  
			WHERE ( ntransito.tran_g_financiero = :str.g_financiero ) AND  
					( ntransito.tran_empresa = :str.empresa ) AND  
					( ntransito.tran_transito = :ls_tran )   ;
			if sqlca.sqlcode = -1 then
				mensaje('Atención', 'Error al Actualizar Registros en NATRANSITO', sqlca.sqlerrtext)
			end if
			
	LOOP UNTIL li_existe = 0
end if

return ls_tran
end function

on w_mant_gastos.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
end on

on w_mant_gastos.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.dw_3)
end on

event ue_post_open;//override
str_secuencia_doc lstr_sec
string ls_documento
integer li_ann
datawindowchild ldwc_cobrador, ldwc_child
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

dw_1.getchild('inag_cuenta', ldwc_child)
ldwc_child.settransobject(sqlca)
ldwc_child.retrieve(str.g_financiero, str.empresa)

dw_1.retrieve(str.g_financiero, str.empresa)

dw_1.setitemstatus(1,0,primary!,NotModified!) 

this.width = 3374
end event

event ue_aceptar;//override
long ll_update, ll_count, ll_codigo
string ls_titulo, ls_error, ls_codigo, ls_desc

dw_1.accepttext()

for ll_count = 1 to dw_1.rowcount()
	ls_codigo = dw_1.getitemstring(ll_count, 'inag_cod')

	if ls_codigo  = ''  or isnull(ls_codigo) then
		gf_mensaje('', 'Debe asignar un codigo de gasto... Verifique', 1,1,'E')
		return
	end if

	ls_desc = dw_1.getitemstring(ll_count, 'inag_descripcion')

	if ls_desc = '' or isnull(ls_desc) then
		gf_mensaje('', 'Asigne la descripción del gasto... Verifique', 1,1,'E')
		return
	end if

next

ll_update=dw.update()

if ll_update = 1  then
	commit using sqlca;
	//mensaje("Información","¡Actualización Exitosa !","")
else
	ls_error = sqlca.sqlerrtext
	rollback using sqlca;
	gf_mensaje("","¡Error al Actualizar el servicio "+ls_error,1,1,'E')
end if
end event

event ue_adicionar;call super::ue_adicionar;dw_1.setitem(dw_1.getrow(), 'inag_g_financiero', str.g_financiero)
dw_1.setitem(dw_1.getrow(), 'inag_empresa', str.empresa)

dw_1.setfocus()
dw_1.setcolumn('inag_cod')
end event

event resize;//override
//dw_1.Resize(This.Width - 270, This.Height - 430)
//pb_1.y = newheight - 200
//st_1.y = newheight - 180
//cb_3.y = newheight - 200

end event

event ue_print;////override
//string  ls_dinero, ls_tran, ls_doc
//Integer li_ann
//
//ls_tran = dw_1.getitemstring(1,'movi_tipo_transaccion')
//if ls_tran = 'RC' then
//	dw_2.dataobject = 'dw_imprimir_recibo'
//else
//	dw_2.dataobject = 'dw_imprimir_transacciones'
//end if
//dw_2.settransobject(sqlca)
//
//ls_doc  = dw_1.getitemstring(1,'movi_documento')
//li_ann  = dw_1.getitemnumber(1,'movi_anno')
//
//if dw_2.retrieve(str.g_financiero, str.empresa, ls_tran, ls_doc, li_ann) > 0 then
//	ls_dinero =  gf_numerlet(dw_1.getitemnumber(1,'movi_monto'),1)
//	if dw_2.describe("numero_letra.x") <> "!" and dw_2.describe("numero_letra.x") <> "?"then				
//		dw_2.object.numero_letra.expression = "'"+ls_dinero+"'"
//	end if
//	dw_2.Modify("DataWindow.Print.Preview=true")	
//else
//	gf_mensaje('','Transaccion no Registrada, Verifique!!!',1,1,'E')
//	return
//end if
//dw_2.visible = true
//
//OpenWithParm(w_dw_print_options, dw_2)
//dw_2.visible = false
//If Message.DoubleParm = -1 Then Return
//dw_2.Print(True)
//
end event

event key;//
end event

event ue_busqueda;call super::ue_busqueda;dw_1.triggerevent('ue_helpcol')
end event

event open;call super::open;this.y = 0
this.x = 805

end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_mant_gastos
boolean visible = false
integer width = 73
integer height = 36
string text = ""
end type

type dw_1 from w_fa_padre`dw_1 within w_mant_gastos
integer x = 78
integer width = 3232
integer height = 1316
string dataobject = "dw_mant_gastos"
boolean vscrollbar = true
end type

event dw_1::itemchanged;call super::itemchanged;string  ls_column, ls_nave, ls_estado, ls_sin, ls_transito
integer li_return
long	  ll_existe

ls_column = this.getcolumnname()

if ls_column = 'tran_barco' then
	//////////////////////////////////////////
	wf_verificar_transitos(data)
	
	//Para Advertir que el transito, tiene movimiento
		ls_transito = this.getitemstring(row, 'tran_transito')
	
	  SELECT count(*)  
		 INTO :ll_existe  
		 FROM banatpagar  
		WHERE ( banatpagar.tpaga_g_financiero = :str.g_financiero ) AND  
				( banatpagar.tpaga_empresa = :str.empresa ) AND  
				( banatpagar.tpaga_transito = :ls_transito )  ;
		if sqlca.sqlcode = -1 then
			mensaje('Aviso','Error al Seleccionar Cantidad de Registros del Transito',sqlca.sqlerrtext)
			return 2
		end if
	if ll_existe > 0 then
		gf_mensaje('Aviso','Esta Intentando Cambiarle el Barco al Código '+ls_transito+', y ya Tiene Transacciones Registradas, Verifique !!!',1,1,'E')
	end if
	////////////////////////////////////////
	
	ls_nave = idwc_sin.getitemstring(idwc_sin.getrow(), 'nav_nombre')
	dw_1.setitem(dw_1.getrow(), 'nave', ls_nave)	
	
elseif ls_column = "nave" then
	//////////////////////////////////////////
	//Para Advertir que el transito, tiene movimiento
		ls_transito = this.getitemstring(row, 'tran_transito')
	
	  SELECT count(*)  
		 INTO :ll_existe  
		 FROM banatpagar  
		WHERE ( banatpagar.tpaga_g_financiero = :str.g_financiero ) AND  
				( banatpagar.tpaga_empresa = :str.empresa ) AND  
				( banatpagar.tpaga_transito = :ls_transito )  ;
		if sqlca.sqlcode = -1 then
			mensaje('Aviso','Error al Seleccionar Cantidad de Registros del Transito',sqlca.sqlerrtext)
			return 2
		end if
	if ll_existe > 0 then
		mensaje('Aviso','Esta Intentando Cambiarle el Barco al Código '+ls_transito+', y ya Tiene Transacciones Registradas, Verifique !!!','')
	end if
	////////////////////////////////////////
	
	ls_sin = idwc_nave.getitemstring(idwc_nave.getrow(), 'nav_sin')
	dw_1.setitem(dw_1.getrow(),'tran_barco', ls_sin)	

elseif ls_column = 'tran_estado' then
//	ls_estado = this.getitemstring(this.getrow(), 'tran_estado')
//
//	open(w_na_password)
//
//	li_return = Message.DoubleParm
//
//	if isnull(li_return) then li_return = 0
//
//	if li_return <> 1 then
//		this.setitem(this.getrow(), 'tran_estado', ls_estado)
//	end if
elseif ls_column = 'tran_transito' then
	this.triggerevent('ue_entercol')
end if
end event

event dw_1::buttonclicked;call super::buttonclicked;	String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error, ls_tran, ls_codigo,  ls_servicio, ls_comentario
	integer li_c, li_b
	long    ll_lter
	Datawindow        dww
	str_dg_dynamic_find	lstr_df

if dwo.name = 'b_cerrar' then
	parent.triggerevent('close')
elseif dwo.name = 'b_adicionar' then
	parent.triggerevent('ue_adicionar')
elseif dwo.name = 'b_grabar' then
	parent.triggerevent('ue_aceptar')
elseif dwo.name = 'b_eliminar' then
	parent.triggerevent('ue_eliminar')	
elseif dwo.name = 'b_buscar' then
	
end if
end event

event dw_1::itemfocuschanged;//override
this.accepttext()
string ls_tran, ls_doc
integer li_ann

//choose case this.getcolumnname()
//	case 'movi_tipo_transaccion'
//		ls_tran = this.getitemstring(1,'movi_tipo_transaccion')
//		idwc_stran.setfilter("dgmsubse_subs_transaccion = '"+ls_tran+"'")
//		idwc_stran.filter()
//		this.setitem(1,'movi_sub_transaccion','')
//end choose
end event

event dw_1::ue_microayuda;//override
end event

event dw_1::ue_helpcol;call super::ue_helpcol;string ls_column
long ll_found, ll_pasada, ll_clien
String ls_find,ls_codigo, ls_descrip
decimal ldec_precio

ls_column = dw_1.getcolumnname()

if ls_column = 'tran_owner' or ls_column = 'tran_charter' or ls_column = 'tran_other1' or &
	ls_column = 'tran_other2' or ls_column = 'tran_other2' or ls_column = 'tran_other3' or &
	ls_column = 'tran_other4' or ls_column = 'tran_other5' then

	str_dg_dynamic_find	lstr_df

		lstr_df.texto_campo [2,1] = "dgmterce.terc_tercero"
		lstr_df.texto_campo [2,2] = "Código"
		lstr_df.texto_campo [2,3] = "terc_tercero"
		lstr_df.texto_campo [2,4] = 'V'

		lstr_df.texto_campo [3,1] = "dgmterce.terc_identificacion"
		lstr_df.texto_campo [3,2] = "Identificación"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'

		lstr_df.texto_campo [1,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [1,2] = "Descripción"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '650'

		lstr_df.texto_campo [4,1] = "dgapais.pais_descripcion"
		lstr_df.texto_campo [4,2] = "País"
		lstr_df.texto_campo [4,3] = ""
		lstr_df.texto_campo [4,4] = 'V'
		lstr_df.texto_campo [4,5] = '500'


		lstr_df.tabla = " dgmterce, dgapais, ccmclien"

		lstr_df.tabla_where = &
					"WHERE ( dgmterce.terc_pais *= dgapais.pais_pais ) and  " +&
							"(ccmclien.clie_g_financiero = " + string(str.g_financiero) + " and " +&
							 "ccmclien.clie_empresa = " + string(str.empresa) + ") 	and " +&
							"(dgmterce.terc_tercero = ccmclien.clie_tercero ) "

		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm

		ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
		gf_replace_cadena(ls_codigo,"'"," ")
		ls_codigo = Trim(ls_codigo)

		if ls_codigo = '' or isnull(ls_codigo) then return
	
			ll_clien = long(ls_codigo)
	
			If IsNull(ll_clien) Then 
				Return
			Else
				if ls_column = 'tran_owner' then
					this.SetItem(this.getrow(),"tran_owner",ll_clien)
				elseif ls_column = 'tran_charter' then
					this.SetItem(this.getrow(),"tran_charter",ll_clien)
				elseif ls_column = 'tran_other1' then
					this.SetItem(this.getrow(),"tran_other1",ll_clien)
				elseif ls_column = 'tran_other2' then
					this.SetItem(this.getrow(),"tran_other2",ll_clien)
				elseif ls_column = 'tran_other3' then
					this.SetItem(this.getrow(),"tran_other3",ll_clien)
				elseif ls_column = 'tran_other4' then
					this.SetItem(this.getrow(),"tran_other4",ll_clien)
				elseif ls_column = 'tran_other5' then
					this.SetItem(this.getrow(),"tran_other5",ll_clien)
				end if
			End If	
	
end if
end event

event dw_1::ue_entercol;//
string ls_column, ls_tran, ls_sin, ls_nave, ls_estado,ls_transito,ls_transito_2
integer li_existe,li_ann

ls_column = this.getcolumnname()

if ls_column = 'tran_transito' then
	
	this.accepttext()
	
	ls_tran = this.getitemstring(this.getrow(), 'tran_transito')
	
	if len(ls_tran) = 1 then
		ls_transito = '000' + ls_tran
	elseif len(ls_tran) = 2 then
		ls_transito = '00' + ls_tran
	elseif len(ls_tran) = 3 then
		ls_transito = '0' + ls_tran
	else
		ls_transito = ls_tran
	end if

	li_ann = this.getitemnumber(1,"anno")

	ls_transito = "%" + ls_transito + "-" + string(li_ann) + "%"	

  SELECT count(ntransito.tran_transito)
	 INTO :li_existe  
	 FROM ntransito  
	WHERE ( ntransito.tran_g_financiero = :str.g_financiero ) AND  
			( ntransito.tran_empresa = :str.empresa ) AND  
			( ntransito.tran_transito like :ls_transito )   ;
	if sqlca.sqlcode = -1 then
		mensaje('Aviso','Error al Validar Existencia de Transitos',sqlca.sqlerrtext)
		return
	end if
	
	if li_existe > 0 then
		ii_act = 0		//Para que no intente adicionar un nuevo transito, si solo estoy modificando
		
		SELECT ntransito.tran_transito
		 INTO :ls_transito_2  
		 FROM ntransito  
		WHERE ( ntransito.tran_g_financiero = :str.g_financiero ) AND  
				( ntransito.tran_empresa = :str.empresa ) AND  
				( ntransito.tran_transito like :ls_transito )   ;
		if sqlca.sqlcode = -1 then
			mensaje('Aviso','Error al Validar Existencia de Transitos',sqlca.sqlerrtext)
			return
		end if
		
		dw_1.retrieve(str.g_financiero, str.empresa, ls_transito_2)			

		ls_sin = dw_1.getitemstring(dw_1.getrow(), 'tran_barco')
		dw_1.setitem(dw_1.getrow(), 'nave', ls_sin)

		ls_estado = dw_1.getitemstring(dw_1.getrow(), 'tran_estado')
		
		dw_1.setitem(1,"anno",li_ann)
		
//		if ls_estado <> 'A' then
//			cb_1.visible = true
//			cb_2.visible = true
//		end if
	else
		ls_transito = dw_1.getitemstring(dw_1.getrow(),"tran_transito")	
		dw_1.reset()
		parent.triggerevent('ue_adicionar')
//		if len(ls_tran) > 12 then	
//			this.setitem(this.getrow(), 'tran_transito', '')
//			parent.triggerevent('ue_adicionar')
//		else
//			this.setitem(this.getrow(), 'tran_transito', '')
//		end if

//		this.setitem(this.getrow(),'tran_transito',ls_transito)

	end if
end if
end event

event dw_1::doubleclicked;call super::doubleclicked;long ll_found,ll_fila
String ls_find,ls_codigo, ls_nombre,ls_mensaje,ls_transito,ls_puerto,ls_descrip_puerto
integer li_cont
datetime ldt_fecha_llegada

if this.getcolumnname() = 'tran_sin' or this.getcolumnname() = 'nave' then
	str_dg_dynamic_find	lstr_df
	
	lstr_df.texto_campo [1,1] = "nnave.nav_sin"
	lstr_df.texto_campo [1,2] = "SIN"
	lstr_df.texto_campo [1,3] = "nav_sin"
	lstr_df.texto_campo [1,4] = 'V'
	
	lstr_df.texto_campo [2,1] = "nnave.nav_nombre"
	lstr_df.texto_campo [2,2] = "Nombre"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = 'V'
	lstr_df.texto_campo [2,5] = '1200'
	
	lstr_df.tabla = "nnave"
	
	lstr_df.tabla_where = " nnave.nav_g_financiero =: "+string(str.g_financiero)+" and " +&
					 			 " nnave.nav_empresa =: "+string(str.empresa)
	
	OpenWithParm(w_dg_a_custom_find, lstr_df)
	ls_find = Message.StringParm
	
	ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo,"'"," ")
	ls_codigo = Trim(ls_codigo)
	
	if ls_codigo = '' or isnull(ls_codigo) then return
	
	  SELECT nnave.nav_nombre
		 INTO :ls_nombre
		 FROM nnave
		WHERE ( nnave.nav_sin = :ls_codigo )   ;
		if sqlca.sqlcode = - 1 then
			gf_mensaje('Atención','Error al Seleccionar registros '+ sqlca.sqlerrtext,1,1,'E')
			return
		end if
		
	wf_verificar_transitos(ls_codigo)
	
	dw_1.setitem(dw_1.getrow(), 'tran_barco', ls_codigo)
	dw_1.setitem(dw_1.getrow(), 'nave', ls_nombre)

end if

end event

event dw_1::getfocus;call super::getfocus;ii_inserta = 1
end event

event dw_1::ue_down;// Toma la Tecla que el usuario presione

CHOOSE CASE key
		
	CASE KeyF1! 
		
		This.Postevent("ue_helpcol")
		
	CASE	  Keyenter! 
		
//	     This.Triggerevent("ue_entercol")
//		  return(2)

		
END CHOOSE

end event

type st_ayuda from w_fa_padre`st_ayuda within w_mant_gastos
end type

type dw_2 from datawindow within w_mant_gastos
boolean visible = false
integer y = 1168
integer width = 544
integer height = 316
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Impresion del Recibo"
string dataobject = "dw_na_transitos_activos_por_barco"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "AppIcon!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_mant_gastos
boolean visible = false
integer x = 1019
integer y = 1360
integer width = 434
integer height = 768
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_transito"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

