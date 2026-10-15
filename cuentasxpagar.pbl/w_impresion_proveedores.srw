//objectcomments Consulta de Facturas
forward
global type w_impresion_proveedores from w_fa_padre_reportes
end type
end forward

global type w_impresion_proveedores from w_fa_padre_reportes
integer x = 5
integer y = 20
integer width = 3822
integer height = 2488
string title = "Impresion de los Proveedores"
long backcolor = 12639424
windowanimationstyle openanimation = toproll!
windowanimationstyle closeanimation = topslide!
event ue_buscar ( )
end type
global w_impresion_proveedores w_impresion_proveedores

type variables
string  is_tipo,is_pedido
integer ii_ann

datawindowchild idw_child
end variables

forward prototypes
public subroutine wf_fecha ()
public subroutine wf_nofecha ()
public function string wf_verificar (string ls_original)
end prototypes

public subroutine wf_fecha ();//dw_2.visible = false
//em_1.visible = True
//em_1.text = string(today())
//em_2.visible = True
//em_2.text = string(today())
//pb_1.visible = True
//st_2.visible = True
//st_3.visible = True
//em_1.setfocus()
//
end subroutine

public subroutine wf_nofecha ();//dw_2.visible = true
//em_1.visible = false
//em_2.visible = false
//pb_1.visible = false
//st_2.visible = false
//st_3.visible = false
//dw_2.setfocus()
//dw_2.SetColumn("Texto")
//
end subroutine

public function string wf_verificar (string ls_original);//Se verifican las opciones de parámetros y se filtra
string ls_where
  
  if w_fa_fondo.str_para.mostrar <> 0 then  //mostrar un Año específico

	CHOOSE CASE w_fa_fondo.str_para.desde	//Si es desde el año en adelante o el año exclusivo.
		CASE 0

		 ls_where = ls_original + " where &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+" ) and &
					 (fatdiari.fact_ann = "+string(w_fa_fondo.str_para.mostrar)+" ) AND &
 					 ( fatdiari.fact_no_pedido not like '%NC%' )"	
		CASE 1
		 ls_where = ls_original + " where  &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+" ) and &
					 (fatdiari.fact_ann >= "+string(w_fa_fondo.str_para.mostrar)+" ) AND &
 					 ( fatdiari.fact_no_pedido not like '%NC%' )"		
	END CHOOSE			
	
  else
		 ls_where = ls_original + " where  &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) AND &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+" ) AND &
 					 ( fatdiari.fact_no_pedido not like '%NC%' )"	
  end if
  
  if pos(gf_dg_nombre_empresa(),'ELBROS') > 0 then
	  ls_where = ls_where + " and (fatdiari.fact_no_factura <> '0' )"
  end if	
  
return(ls_where)
end function

on w_impresion_proveedores.create
call super::create
end on

on w_impresion_proveedores.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_post_open;// Override
str_secuencia_doc lstr_sec
string ls_vienede, ls_where, ls_pedido, ls_dw, ls_titulo, ls_empresa
integer li_ann
long	 ll_recup

dw = dw_1 
dw.settransobject(sqlca)
//dw.object.datawindow.readonly = 'yes'
ls_titulo = 'LISTADO GENERAL DE PROVEEDORES'
ls_empresa = gf_dg_nombre_empresa()
dw.object.empresanom.expression = "'"+ls_empresa+"'"

dw.retrieve(str.g_financiero, str.empresa)
dw.object.titulo_fecha.expression = "'"+ls_titulo+"'"
dw.Object.datawindow.print.preview = true


end event

event resize;//Override No borrar no tocar
dw_1.Width  = newwidth - 85
dw_1.Height = newheight - 145


end event

event key;call super::key;//Override

end event

event open;call super::open;
this.y = 0
this.x = 805

end event

event ue_imprimir;//override
dw = dw_1
OpenWithParm(w_dw_print_options, dw)
If Message.DoubleParm = -1 Then Return
dw.Print(True)

end event

event ue_print;//override
dw = dw_1
OpenWithParm(w_dw_print_options, dw)
If Message.DoubleParm = -1 Then Return
dw.Print(True)

end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_impresion_proveedores
integer x = 1879
integer y = 1492
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_impresion_proveedores
boolean visible = false
integer x = 41
integer y = 1752
integer width = 101
integer height = 64
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_impresion_proveedores
event ue_down pbm_dwnkey
event ue_entercol ( )
integer x = 46
integer y = 68
integer width = 3648
integer height = 2144
integer taborder = 130
string dataobject = "dw_impresion_proveedores_generales"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = false
end type

event dw_1::ue_down;// Si el Usuario Dio Enter

if key = Keyenter! Then
	This.Postevent("ue_entercol")
	return(2)
End If

end event

event dw_1::doubleclicked;call super::doubleclicked;//this.triggerevent("ue_entercol")

end event

event dw_1::ue_microayuda;////OVERRIDE
//// Evento que muestra una pequeña Ayuda dependiendo en que columna se encuentre el mouse
//
//Integer li_pos, li_x, li_y
//String ls_objeto, ls_col
//
//ls_objeto = This.GetObjectAtPointer()
//li_pos = pos  (ls_objeto,"~t")
//ls_col = left (ls_objeto, li_pos - 1)
//
//
//li_x	 = str.frame.GetActiveSheet ().PointerX () //- 900
//li_y	 = str.frame.GetActiveSheet ().PointerY () //- 200
//
//// Dependiendo de la Columna el Mensaje de Ayuda varía
//CHOOSE CASE right(ls_col,2)
//	CASE '_t'
////		messagebox("!","Invisible")
//		If st_ayuda.Visible Then Return
//		st_ayuda.Move (li_x, li_y)
//		st_ayuda.Text 	= "Haga click para ordenar por la Columna de " + this.describe(ls_col+".text")
//		st_ayuda.Width 	= Len (st_ayuda.Text) * 28
//		st_ayuda.Visible = TRUE	
//	CASE ELSE
//	st_ayuda.Visible = FALSE
//END CHOOSE
//
end event

event dw_1::clicked;//Scrip que Permite Ordenar Ascendentemente, o Descendente en caso que se de click nuevamente
//en la misma columna.

string ls_objeto, ls_column
integer li_pos 
long ll_tercero
date fecha, fecha1
	
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

if ls_column = 'dgmterce_terc_descripcion' then
	datetime ldt_fecha_saldos
	ll_tercero = dw_1.getitemnumber(row,'terc_tercero')
	fecha	= relativedate(date(gf_fecha_serv()), - 365)
//	fecha = date('01/01/'+string(year(date(gf_fecha_serv()))))
	fecha1 = date(gf_fecha_serv())
	
  SELECT cpmparam.para_fecha_inicio  
    INTO :ldt_fecha_saldos  
    FROM cpmparam  
   WHERE ( cpmparam.para_g_financiero = :str.g_financiero ) AND  
         ( cpmparam.para_empresa = :str.empresa )  ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al buscar fecha '+sqlca.sqlerrtext,1,1,'E')
			return
		end if
	
	if fecha < date(ldt_fecha_saldos) then
		fecha = relativedate(date(ldt_fecha_saldos), 1)
	end if
	
	str_rangofecha str_formato1		
	str_formato1.codigo = ll_tercero
	str_formato1.fecha1  = fecha
	str_formato1.fecha2  = fecha1
	Opensheetwithparm(w_estadocuenta_imp_cxp,str_formato1,str.frame,2,layered!)
	
end if
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_impresion_proveedores
integer x = 18
integer y = 0
integer width = 3753
integer height = 2248
integer taborder = 0
long backcolor = 12639424
end type

