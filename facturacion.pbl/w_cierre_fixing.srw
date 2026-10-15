//objectcomments Ventana para la captura de cierre de Fixing
forward
global type w_cierre_fixing from w_fa_padre
end type
type dw_2 from datawindow within w_cierre_fixing
end type
type pb_1 from picturebutton within w_cierre_fixing
end type
type st_1 from statictext within w_cierre_fixing
end type
type cb_1 from commandbutton within w_cierre_fixing
end type
type cb_2 from commandbutton within w_cierre_fixing
end type
type cbx_cierre from checkbox within w_cierre_fixing
end type
type pb_2 from picturebutton within w_cierre_fixing
end type
type st_2 from statictext within w_cierre_fixing
end type
type uo_1 from u_ddcalen within w_cierre_fixing
end type
type uo_2 from u_ddcalen within w_cierre_fixing
end type
end forward

global type w_cierre_fixing from w_fa_padre
integer width = 1893
integer height = 1188
string title = "Ajustes de Cierre"
long backcolor = 8421376
dw_2 dw_2
pb_1 pb_1
st_1 st_1
cb_1 cb_1
cb_2 cb_2
cbx_cierre cbx_cierre
pb_2 pb_2
st_2 st_2
uo_1 uo_1
uo_2 uo_2
end type
global w_cierre_fixing w_cierre_fixing

type variables
datawindowchild idwc_clientes, idwc_tran, idwc_stran
string is_tran, is_stran, is_tran_automatica
integer ii_ann
end variables

forward prototypes
public function string wf_secuencia_tran ()
public function boolean wf_calcula_media ()
end prototypes

public function string wf_secuencia_tran ();string ls_sec
long ll_max
integer li_existe, li_ann

select isnull(max(convert(numeric(10),contrato)),0)
into :ll_max
from fixing
where grupo = :str.g_financiero and
	 	empresa		= :str.empresa ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al seleccionar secuencia '+sqlca.sqlerrtext,1,1,'E')
			return ''
		end if
		
		ll_max = ll_max + 1		
		
		ls_sec = string(ll_max)

//	DO WHILE true
//		ll_max = ll_max + 1		
//		ls_sec = string(ll_max)
//		
//		select count(*) into :li_existe
//		from cctmovim
//		where movi_g_financiero = :str.g_financiero and
//				movi_empresa		= :str.empresa and
//				movi_tipo_transaccion = :is_tran and
//				movi_sub_transaccion = :is_stran and
//				movi_documento 	=  :ls_sec and
//				movi_anno			=  :li_ann ;
//				if sqlca.sqlcode = -1 then
//					gf_mensaje('','Error al validar existencia '+sqlca.sqlerrtext,1,1,'E')
//					return ''
//				end if
//										
//			if li_existe = 0 then
//				exit
//			end if
//	LOOP

return ls_sec
end function

public function boolean wf_calcula_media ();decimal ld_precio, ld_cantidad, ld_calo, ld_mano_de_obra, ld_media, ld_gramos, ld_valor

ld_precio   = dw_1.getitemnumber(1,'precio_onza')
if isnull(ld_precio) then ld_precio = 0
ld_cantidad = dw_1.getitemnumber(1,'cantidad_onza')
if isnull(ld_cantidad) then ld_cantidad = 0
ld_calo		= dw_1.getitemnumber(1,'calo')
if isnull(ld_calo) then ld_calo = 0
ld_mano_de_obra = dw_1.getitemnumber(1,'mano_de_obra')
if isnull(ld_mano_de_obra) then ld_mano_de_obra = 0

ld_media    = ( ld_precio / 31.1035 ) * ld_calo + ld_mano_de_obra
dw_1.setitem(1,'media',ld_media)

ld_gramos  = (ld_cantidad  * 31.1035 ) / ld_calo 
dw_1.setitem(1,'total_gramos',ld_gramos)

ld_valor = ld_media * ld_gramos
dw_1.setitem(1,'valor',ld_valor)

return true

end function

on w_cierre_fixing.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.pb_1=create pb_1
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cbx_cierre=create cbx_cierre
this.pb_2=create pb_2
this.st_2=create st_2
this.uo_1=create uo_1
this.uo_2=create uo_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cbx_cierre
this.Control[iCurrent+7]=this.pb_2
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.uo_1
this.Control[iCurrent+10]=this.uo_2
end on

on w_cierre_fixing.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cbx_cierre)
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.uo_1)
destroy(this.uo_2)
end on

event ue_post_open;//override
str_secuencia_doc lstr_sec
string ls_doc
integer li_ann
long ll_encontro
date ldt_fecha
datawindowchild ldwc_cobrador
dw_1.settransobject(sqlca)
this.y = 0
this.x = 805

lstr_sec = Message.PowerObjectParm
if isvalid(lstr_sec) then 
	ls_doc = lstr_sec.sec_manual
end if

dw_1.insertrow(1)

if ls_doc <> '' and not isnull(ls_doc) then
	dw_1.setitem(1,'contrato',ls_doc)
	dw_1.setcolumn('contrato')
	dw_1.accepttext()
	dw_1.trigger event itemchanged(1, dw_1.object, ls_doc)	

else
	ldt_fecha = date('01/'+string(month(date(gf_fecha_serv())))+'/'+string(year(date(gf_fecha_serv()))))
	dw_1.setitem(1,'fecha1', ldt_fecha)
	dw_1.setitem(1,'fecha2', date(gf_fecha_serv()))
	dw_1.setcolumn('k10')
	dw_1.setfocus()	
end if

end event

event ue_aceptar;//override
long ll_update, ll_doc, ll_encontro
integer li_ann
window lw_ventana
string ls_titulo, ls_doc
decimal{2} ldec_saldo, ld_monto

//lw_ventana = this.getactivesheet()
//ls_titulo = lw_ventana.title

dw_1.accepttext()
ls_doc = dw_1.getitemstring(dw_1.getrow(), 'contrato')
if ls_doc = '' or isnull(ls_doc) then
	gf_mensaje('','Debe digitar el documento antes de guardar, Verifique !!!',1,1,'E')
	dw_1.setcolumn('contrato')
	return
end if

if dw_1.getitemNumber(dw_1.getrow(), 'precio_onza') = 0 or isnull(dw_1.getitemNumber(dw_1.getrow(),'precio_onza')) then
	gf_mensaje('','Debe asignar el precio de la onza antes de guardar, Verifique !!!',1,1,'E')
	dw_1.setcolumn('precio_onza')
	return
end if

if dw_1.getitemNumber(dw_1.getrow(), 'cantidad_onza') = 0 or isnull(dw_1.getitemNumber(dw_1.getrow(),'cantidad_onza')) then
	gf_mensaje('','Debe asignar la cantidad de la onza antes de guardar, Verifique !!!',1,1,'E')
	dw_1.setcolumn('cantidad_onza')
	return
end if

ll_update=dw.update()

if ll_update = 1  then
	commit using sqlca;
//	gf_mensaje("Atención","¡Actualización Exitosa !",1,1,'E')
else
	rollback using sqlca;
	gf_mensaje("Atención","¡Error al Actualizar ! " + sqlca.sqlerrtext,1,1,'E')
end if


end event

event ue_adicionar;//override
string ls_tran, ls_subt, ls_naturaleza, ls_doc
if dw_1.rowcount() > 0 then
//	ls_tran = dw_1.getitemstring(1,'movi_tipo_transaccion')
//	ls_subt = dw_1.getitemstring(1,'movi_sub_transaccion')
	dw_1.reset()	
end if

dw_1.insertrow(1)
dw_1.setitem(1,'fecha', date(gf_fecha_serv()))
dw_1.setitem(1,'grupo',str.g_financiero)
dw_1.setitem(1,'empresa',str.empresa)
dw_1.setitem(1,'usuario', str.usuario)

ls_doc = wf_secuencia_tran()			
dw_1.setitem(1,'contrato',ls_doc)
dw_1.setcolumn('contrato')
dw_1.setfocus()

end event

event resize;//override
//dw_1.Resize(This.Width - 270, This.Height - 430)
//pb_1.y = newheight - 200
//st_1.y = newheight - 180

end event

event ue_print;//override
string  ls_dinero, ls_tran, ls_doc
Integer li_ann
datawindowchild ldwc_clientes


ls_doc = dw_1.getitemstring(1,'contrato')

if dw_2.retrieve(str.g_financiero, str.empresa, ls_doc) > 0 then
	dw_2.Modify("DataWindow.Print.Preview=true")	
else
	gf_mensaje('','Transaccion no Registrada, Verifique!!!',1,1,'E')
	return
end if

dw_2.object.empresanom.expression = "'"+str.nombre_empresa+"'"
dw_2.object.titulo_fecha.expression = "'"+"Cierre al " +gf_fecha_palabras(date(dw_1.getitemdatetime(1,'fecha')))+"'"

OpenWithParm(w_dw_print_options, dw_2)

If Message.DoubleParm = -1 Then Return
dw_2.Print(True)

end event

event ue_eliminar;//override
this.setredraw(false)
if dw.rowcount() > 0 then
	if gf_mensaje('','Esta seguro de eliminar la transaccion ??',2,1,'E') = 2 then 
		this.setredraw(true)
		return		
	end if
	dw.deleterow(dw.getrow())
	if dw.update() = 1 then
		this.triggerevent('ue_adicionar')
	end if
else 
	messagebox("Atención","No hay registros para borrar!")
end if
this.setredraw(true)
end event

event closequery;//override

end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_cierre_fixing
boolean visible = false
integer width = 73
integer height = 36
string text = ""
end type

type dw_1 from w_fa_padre`dw_1 within w_cierre_fixing
integer x = 69
integer y = 44
integer width = 1737
integer height = 744
string dataobject = "dw_cierre_fixing"
end type

event dw_1::itemchanged;call super::itemchanged;this.accepttext()
string ls_tran, ls_doc, ls_subt, ls_naturaleza
integer li_ann
decimal{2} ldec_saldo, ld_tarjeta, ld_porcentaje

choose case this.getcolumnname()
	case 'contrato'
		integer li_existe
		ls_doc = this.getitemstring(1,'contrato')
		if	this.retrieve(str.g_financiero, str.empresa, ls_doc) = 0 then
			parent.triggerevent('ue_adicionar')
			this.setitem(1,'contrato',ls_doc)
			this.setcolumn('contrato')
		else
			this.setcolumn('contrato')
		end if
	case 'kilates'
		choose case integer(data)
			case 10
				this.setitem(1,'calo',0.438)
			case 18
				this.setitem(1,'calo',0.780)				
			case else
				this.setitem(1,'calo',0)
		end choose
		wf_calcula_media()		
	case 'precio_onza', 'cantidad_onza', 'calo', 'mano_de_obra'
		wf_calcula_media()
end choose
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

event dw_1::ue_helpcol;call super::ue_helpcol;	String  ls_find,ls_codigo1,ls_lter,ls_des, ls_error, ls_tran, ls_codigo
	integer li_c, li_b, li_ann
	long    ll_lter
	Datawindow        dww
	str_dg_dynamic_find	lstr_df

if this.getcolumnname() = 'movi_documento' then
		//Busqueda del producto
	//	
	ls_tran = this.getitemstring(1,'movi_tipo_transaccion')
	li_ann = this.getitemnumber(1,'movi_anno')
	
	if ls_tran = '' or isnull(ls_tran) then
		gf_mensaje('','Seleccione una Transaccion para buscar Documentos',1,1,'E')
		return
	end if
	
	
		lstr_df.texto_campo [1,1] = "cctmovim.movi_documento"
		lstr_df.texto_campo [1,2] = "Documento"
		lstr_df.texto_campo [1,3] = "movi_documento"
		lstr_df.texto_campo [1,4] = 'V'
	//	lstr_df.texto_campo [1,5] = '280'	
		lstr_df.texto_campo [2,1] = "cctmovim.movi_a_nombre"
		lstr_df.texto_campo [2,2] = "A Nombre de"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '770'
		lstr_df.texto_campo [3,1] = "cctmovim.movi_fecha_tran"
		lstr_df.texto_campo [3,2] = "Fecha"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [3,5] = '285'
		lstr_df.tabla = " cctmovim "
			
		lstr_df.tabla_where = &
					"WHERE (cctmovim.movi_g_financiero = " + string(str.g_financiero) + ") and " +&
							 "(cctmovim.movi_empresa = " + string(str.empresa) + ") and " +&
							 "(cctmovim.movi_anno = " + string(li_ann) + ") and " +&
							 "(cctmovim.movi_tipo_transaccion = '"+ls_tran+"') and " +&
							 "(cctmovim.movi_tipo_transaccion + movi_sub_transaccion <> 'ND8') "
							 
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	
	If len (ls_find) = 0 Then Return
		
	ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo,"'"," ")
	ls_codigo = Trim(ls_codigo)
	this.setitem(1,'movi_documento',ls_codigo)
	this.setcolumn('movi_documento')
	this.accepttext()
	this.trigger event itemchanged(1, object, ls_codigo)
	
elseif this.getcolumnname() = 'movi_tercero' then
			
		lstr_df.texto_campo [1,1] = "ccmclien.clie_ref_anterior" //"dgmterce.terc_identificacion"
		lstr_df.texto_campo [1,2] = "Codigo"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '350'
		lstr_df.texto_campo [2,1] = "dgmterce.terc_descripcion"
		lstr_df.texto_campo [2,2] = "Descripción"
		lstr_df.texto_campo [2,3] = ""
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '700'		
		lstr_df.texto_campo [3,1] = "dgmterce.terc_tercero"
		lstr_df.texto_campo [3,2] = "Secuencial"
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
							"(dgmterce.terc_tercero = ccmclien.clie_tercero)"
		
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
	
	If len (ls_find) = 0 Then Return
		
		
	ls_codigo1 =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
	gf_replace_cadena(ls_codigo1,"'"," ")
	ls_codigo1 = Trim(ls_codigo1)

	dw_1.setitem(1,'movi_tercero',long(ls_codigo1))
	dw_1.accepttext()
	dw_1.setcolumn('movi_tercero')
	dw_1.trigger event itemchanged(1,object,ls_codigo1)
	
end if
end event

event dw_1::ue_tabfinal;//override
end event

event dw_1::clicked;//override
date 	ld_date,ld_ini_date, ld_hoy
accepttext()

ld_hoy = date(gf_fecha_serv())

if dwo.name='calendario' then
	ld_ini_date=dw_1.GetItemDate(dw_1.getrow(),"fecha1")
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
	ld_ini_date=dw_1.GetItemDate(dw_1.getrow(),"fecha2")
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

type st_ayuda from w_fa_padre`st_ayuda within w_cierre_fixing
end type

type dw_2 from datawindow within w_cierre_fixing
boolean visible = false
integer x = 87
integer y = 12
integer width = 3232
integer height = 1388
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Impresion del Recibo"
string dataobject = "dw_fixing_impresion"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "AppIcon!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_1 from picturebutton within w_cierre_fixing
integer x = 3163
integer y = 1216
integer width = 178
integer height = 152
integer taborder = 31
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "C:\Harr2000\Art\NOTE04.BMP"
alignment htextalign = left!
end type

event clicked;long ll_tercero
ll_tercero = dw_1.getitemnumber(1,'movi_tercero')
str_cc_formatos str_formato2		
str_formato2.tercero = ll_tercero
if ll_tercero > 0 then
	Opensheetwithparm(w_notas,str_formato2,str.frame,2,original!)
end if

end event

type st_1 from statictext within w_cierre_fixing
integer x = 2871
integer y = 1220
integer width = 274
integer height = 144
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
string text = "Notas del Cliente"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_cierre_fixing
integer x = 453
integer y = 828
integer width = 407
integer height = 104
integer taborder = 41
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked;if gf_mensaje('','Esta Seguro de Actualizar los Costos ?',2,1,'E') = 2 then return

decimal{6} ld_precio, ld_cantidad, ld_calo, ld_mano_de_obra, ld_media, ld_gramos, ld_valor, ld_costo_10k, ld_costo_18k, ld_costo_24k		
integer li_kilates
datetime ldt_fecha1, ldt_fecha2
string ls_contrato, ls_error

ldt_fecha1 = datetime(dw_1.getitemdate(1,'fecha1'))
ldt_fecha2 = datetime(dw_1.getitemdate(1,'fecha2'))

ld_costo_10k = dw_1.getitemnumber(1,'k10')
ld_costo_18k = dw_1.getitemnumber(1,'k18')
ld_costo_24k = dw_1.getitemnumber(1,'k24')

declare fixing cursor for 
  SELECT fixing.contrato,   
         fixing.kilates,   
         fixing.precio_onza,   
         fixing.cantidad_onza,   
         fixing.mano_de_obra,   
         fixing.calo,
			fixing.total_gramos
    FROM  fixing  
   WHERE ( fixing.cerrado = 0 ) and  
         ( ( fixing.grupo = :str.g_financiero ) AND  
         ( fixing.empresa = :str.empresa ) AND  
         ( fixing.fecha >= :ldt_fecha1 ) AND  
         ( fixing.fecha <= :ldt_fecha2 ) )    ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al declarar cursor '+sqlca.sqlerrtext,1,1,'E')
			end if
			
 OPEN fixing;
 
 if sqlca.sqlcode = -1 then
	mensaje("Aviso","Error al Abrir el Cursor",sqlca.sqlerrtext)
 end if
 
 FETCH fixing INTO :ls_contrato,:li_kilates, :ld_precio, :ld_cantidad, :ld_mano_de_obra, :ld_calo, :ld_gramos ;
 
 IF SQLCA.SQLCODE = -1 THEN	
	MESSAGEBOX("ERROR","ERROR AL SELECCIONAR REGISTROS "+SQLCA.SQLERRTEXT)
	CLOSE fixing;
	RETURN 
 END IF	

 sqlca.autocommit = false
 
 DO WHILE SQLCA.SQLCODE = 0
	
	if isnull(ld_precio) then ld_precio = 0
	if isnull(ld_cantidad) then ld_cantidad = 0
	if isnull(ld_calo) then ld_calo = 0
	if isnull(ld_mano_de_obra) then ld_mano_de_obra = 0
	
	choose case li_kilates
		case 10
			ld_mano_de_obra = ld_costo_10k
		case 18
			ld_mano_de_obra = ld_costo_18k
		case 24
			ld_mano_de_obra = ld_costo_24k
	end choose
	
	if ld_mano_de_obra <> 0 then
		ld_media    = ( ld_precio / 31.1035 ) * ld_calo + ld_mano_de_obra	
		ld_valor = ld_media * ld_gramos		 
		//actualiza la media y los gramos
		  UPDATE fixing  
			  SET mano_de_obra = :ld_mano_de_obra,
			  		media 		 = :ld_media,   
					valor 		 = :ld_valor  
			WHERE ( fixing.grupo = :str.g_financiero ) AND  
					( fixing.empresa = :str.empresa ) AND  
					( fixing.contrato = :ls_contrato ) ;
			if sqlca.sqlcode = -1 then
				ls_error = sqlca.sqlerrtext
				gf_mensaje('','Error al actualizar datos del fixing '+ls_error,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if				
	end if 
	
	if cbx_cierre.checked then
	  //actualiza la media y los gramos
	  UPDATE fixing  
		  SET cerrado = 1
		WHERE ( fixing.grupo    = :str.g_financiero ) AND  
				( fixing.empresa  = :str.empresa ) AND  
				( fixing.contrato = :ls_contrato ) ;
		if sqlca.sqlcode = -1 then
			ls_error = sqlca.sqlerrtext
			gf_mensaje('','Error al actualizar datos del cierre '+ls_error,1,1,'E')
			rollback;
			sqlca.autocommit = true
			return
		end if		
	end if
	
 	FETCH fixing INTO :ls_contrato,:li_kilates, :ld_precio, :ld_cantidad, :ld_mano_de_obra, :ld_calo, :ld_gramos ;
 
 loop

 commit;
 
 sqlca.autocommit = true
 
 CLOSE fixing;
 
 gf_mensaje('','Actualización Exitosa',1,1,'E')
end event

type cb_2 from commandbutton within w_cierre_fixing
integer x = 960
integer y = 828
integer width = 402
integer height = 104
integer taborder = 51
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

type cbx_cierre from checkbox within w_cierre_fixing
integer x = 78
integer y = 960
integer width = 704
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 8421376
string text = "Cierre del Período"
end type

event clicked;if this.checked then
	if gf_mensaje('','Está Seguro de Generar el Cierre del Período Seleccionado ?',2,1,'E') = 2 then return	
end if
end event

type pb_2 from picturebutton within w_cierre_fixing
integer x = 1541
integer y = 836
integer width = 110
integer height = 96
integer taborder = 61
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "C:\Sistemas\HYMSOFT\Art\PRINTER.bmp"
alignment htextalign = left!
end type

event clicked;str_rangofecha lstr_rangfech

lstr_rangfech.fecha1 = dw_1.getitemdate(1,'fecha1')
lstr_rangfech.fecha2 = dw_1.getitemdate(1,'fecha2')

OpenSheetWithParm(w_reporte_fixing_imp,lstr_rangfech,parent,1,Layered!)

end event

type st_2 from statictext within w_cierre_fixing
integer x = 1445
integer y = 928
integer width = 288
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 8421376
string text = "Reporte"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_1 from u_ddcalen within w_cierre_fixing
boolean visible = false
integer x = 187
integer y = 224
integer taborder = 70
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;dw_1.setitem(1,'fecha1',uo_1.return_sel_date())

if uo_1.allow_close then
	this.visible=false
	dw_1.SetFocus()
end if


end event

on uo_1.destroy
call u_ddcalen::destroy
end on

type uo_2 from u_ddcalen within w_cierre_fixing
boolean visible = false
integer x = 1006
integer y = 228
integer taborder = 80
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;dw_1.setitem(1,'fecha2',uo_2.return_sel_date())

if uo_2.allow_close then
	this.visible=false
	dw_1.SetFocus()
end if


end event

on uo_2.destroy
call u_ddcalen::destroy
end on

