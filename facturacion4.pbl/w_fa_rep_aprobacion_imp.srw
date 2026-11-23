//objectcomments Ventana en donde se Desplegará el Data Window de impresion de las Comisiones
forward
global type w_fa_rep_aprobacion_imp from w_fa_padre_reportes
end type
type cbx_mantener from checkbox within w_fa_rep_aprobacion_imp
end type
end forward

global type w_fa_rep_aprobacion_imp from w_fa_padre_reportes
integer width = 3333
integer height = 1840
string title = "Control de Pedidos Aprobados"
string menuname = "m_hs"
boolean controlmenu = false
cbx_mantener cbx_mantener
end type
global w_fa_rep_aprobacion_imp w_fa_rep_aprobacion_imp

type variables
string is_pedido
integer ii_ann
end variables

on w_fa_rep_aprobacion_imp.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.cbx_mantener=create cbx_mantener
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_mantener
end on

on w_fa_rep_aprobacion_imp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_mantener)
end on

event ue_post_open;call super::ue_post_open;string ls_empre, ls_fecha, ls_pedido
long   ll_ann

is_pedido = message.stringParm

//messagebox('pedido', )
//m_fa_rep.m_edicin.m_filtrar.toolbaritemvisible=false
//m_fa_rep.m_edicin.m_sortear.toolbaritemvisible=false

dw.Object.datawindow.print.preview = true

//dw.retrieve(str.g_financiero,str.empresa, )/*,lstr_rangfech.fecha1,lstr_rangfech.fecha2 */
ii_ann = w_hs_frame.str_para.ano
long ll_recupero
ll_recupero = dw.Retrieve(str.g_financiero, str.empresa, is_pedido, ii_ann)
ls_empre = gf_dg_nombre_empresa()
dw.object.empresa.expression = "'"+ls_empre+"'"

this.triggerevent('ue_print')

//Fecha del Informe
//ls_fecha = 'Desde '+ string(lstr_rangfech.fecha1) + ' Hasta '+ string(lstr_rangfech.fecha2)
//dw.object.fecha.expression = "'"+ls_fecha+"'"


end event

event resize;//Override
this.SetRedraw(false)
dw_1.width  = this.width  - 99
dw_1.height = this.height - 320
gb_1.width  = this.width  - 63
gb_1.height = this.height - 320

cbx_mantener.y = this.height - 280
st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180
this.SetRedraw(true)
end event

event open;call super::open;this.Setredraw(false)

end event

event ue_print;//override
date ldt_actual
datetime ldt_fecha_anterior
OpenWithParm(w_dw_print_options, dw)
If Message.DoubleParm = -1 Then Return

if not cbx_mantener.checked then

	ldt_fecha_anterior = dw_1.getitemdatetime(1,'fatpedid_pedi_fecha')
	
	ldt_actual = date(gf_fecha_serv())
	  UPDATE fatpedid  
		  SET pedi_fecha_original = pedi_fecha,   
					pedi_fecha = :ldt_actual
		WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
				( fatpedid.pedi_empresa = :str.empresa ) AND  
				( fatpedid.pedi_no_pedido = :is_pedido ) AND  
				( fatpedid.pedi_ann = :ii_ann ) AND  
			( fatpedid.pedi_fecha_original = null );
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al Actualizar la fecha '+sqlca.sqlerrtext,1,1,'E')
	end if
	dw.setitem(1,'fatpedid_pedi_fecha',ldt_actual)
	
	
	string ls_secuencia
	long  ll_secuencia
	Integer li_existe
	
		ls_secuencia = dw_1.getitemstring(1,'pedi_secuencia_diaria')
		if date(ldt_fecha_anterior) <> ldt_actual then 
			ls_secuencia = ''
			  UPDATE fatpedid  
				  SET pedi_secuencia_diaria = '0'
				WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
						( fatpedid.pedi_empresa = :str.empresa ) AND  
						( fatpedid.pedi_no_pedido = :is_pedido ) AND  
						( fatpedid.pedi_ann = :ii_ann );
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al Actualizar la fecha '+sqlca.sqlerrtext,1,1,'E')
			end if
			
		end if
	
		if (isnull(ls_secuencia) or ls_secuencia = ''  or ls_secuencia = '0') then
		
			SELECT isnull(convert(varchar(8),max(convert(numeric(8,0),pedi_secuencia_diaria))),'0')  
					 INTO :ls_secuencia  
					 FROM fatpedid  
					WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
							( fatpedid.pedi_empresa = :str.empresa ) AND  
							( fatpedid.pedi_fecha = :ldt_actual ) ;
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Buscar Existencia '+sqlca.sqlerrtext,1,1,'E')
						return
					end if	
					
			ll_secuencia = long(ls_secuencia)
			li_existe = 1
			
			do while li_existe > 0
				ll_secuencia ++
				ls_secuencia = string(ll_secuencia)
				  SELECT count(*)  
					 INTO :li_existe  
					 FROM fatpedid  
					WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
							( fatpedid.pedi_empresa = :str.empresa ) AND  
							( fatpedid.pedi_fecha = :ldt_actual  ) AND  //Tenia and fecha_original = null
							( fatpedid.pedi_secuencia_diaria = :ls_secuencia );
					if sqlca.sqlcode = -1 then
						gf_mensaje('','Error al Buscar Existencia '+sqlca.sqlerrtext,1,1,'E')
						return
					end if	
			loop
			
			  UPDATE fatpedid  
				  SET pedi_secuencia_diaria = :ls_secuencia  
				WHERE ( fatpedid.pedi_g_financiero = :str.g_financiero ) AND  
						( fatpedid.pedi_empresa = :str.empresa ) AND  
						( fatpedid.pedi_no_pedido = :is_pedido ) AND  
						( fatpedid.pedi_ann = :ii_ann )   ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Actualizar Secuencia '+sqlca.sqlerrtext,1,1,'E')
					rollback;
					return
				end if			
			
			dw_1.setitem(1,'pedi_secuencia_diaria',ls_secuencia)		
		end if
end if

dw.Print(True)
end event

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_fa_rep_aprobacion_imp
boolean visible = false
integer x = 23
integer y = 1512
end type

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_fa_rep_aprobacion_imp
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_fa_rep_aprobacion_imp
integer x = 32
integer y = 48
integer width = 3214
integer height = 1432
string dataobject = "dw_fa_rep_aprobacion"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event dw_1::retrieveend;call super::retrieveend;Integer li_vendedor
String	ls_nom_vend, ls_apellido_vend, ls_empleado

li_vendedor = dw_1.GetItemNumber(1,'vped_vendedor')
//vped_vendedor

  SELECT famvende.vend_nombre,   
  			famvende.vend_apellido,
         famvende.vend_empleado  
    INTO :ls_nom_vend,   
         :ls_apellido_vend,
			:ls_empleado
    FROM famvende  
   WHERE ( famvende.vend_g_financiero = :str.g_financiero ) AND  
         ( famvende.vend_empresa = :str.empresa ) AND  
         ( famvende.vend_vendedor = :li_vendedor )   ;
	If sqlca.sqlcode = -1 then
		mensaje('Error','Se ha producido un error al leer el vendedor ',sqlca.sqlerrText)
		return
	end if
	
	dw_1.SetItem(1,'nombre_vendedor',ls_nom_vend)
	dw_1.SetItem(1,'apellido_vendedor',ls_apellido_vend)

end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_fa_rep_aprobacion_imp
integer x = 14
integer y = 4
integer width = 3264
integer height = 1504
end type

type cbx_mantener from checkbox within w_fa_rep_aprobacion_imp
integer x = 101
integer y = 1544
integer width = 517
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mantener Fecha ?"
end type

