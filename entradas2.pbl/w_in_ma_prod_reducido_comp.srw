//objectcomments  
forward
global type w_in_ma_prod_reducido_comp from w_in_padre
end type
type cb_1 from commandbutton within w_in_ma_prod_reducido_comp
end type
type cb_2 from commandbutton within w_in_ma_prod_reducido_comp
end type
type cb_3 from commandbutton within w_in_ma_prod_reducido_comp
end type
type gb_1 from groupbox within w_in_ma_prod_reducido_comp
end type
end forward

global type w_in_ma_prod_reducido_comp from w_in_padre
integer width = 3054
integer height = 1740
string title = "(IN) Mantenimiento"
string menuname = "m_hs"
boolean controlmenu = false
boolean maxbox = false
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
gb_1 gb_1
end type
global w_in_ma_prod_reducido_comp w_in_ma_prod_reducido_comp

type variables

end variables

event ue_post_open;call super::ue_post_open;DataWindowChild	ldwc_

dw_1.Getchild("prod_division",ldwc_)
ldwc_.Settransobject(sqlca)
if ldwc_.Retrieve(str.g_financiero,str.empresa) = 0 then ldwc_.insertrow(0)
//gf_cr_haydata_dd(ldwc_)

dw_1.Getchild("prod_grupo",ldwc_)
ldwc_.Settransobject(sqlca)
if ldwc_.Retrieve(str.g_financiero,str.empresa,'') = 0 then ldwc_.insertrow(0)
//gf_cr_haydata_dd(ldwc_)

dw_1.Getchild("prod_sub_grupo",ldwc_)
ldwc_.Settransobject(sqlca)
if ldwc_.Retrieve(str.g_financiero,str.empresa,'','') = 0 then ldwc_.insertrow(0)
//gf_cr_haydata_dd(ldwc_)	

dw_1.Getchild("prod_clase",ldwc_)
ldwc_.Settransobject(sqlca)
if ldwc_.Retrieve(str.g_financiero,str.empresa,'','','') = 0 then ldwc_.insertrow(0)
//gf_cr_haydata_dd(ldwc_)

end event

on w_in_ma_prod_reducido_comp.create
int iCurrent
call super::create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.gb_1
end on

on w_in_ma_prod_reducido_comp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.gb_1)
end on

event ue_aceptar;dw.accepttext()
long ll_update
window lw_ventana
string ls_titulo, ls_bodega,ls_ubicacion, ls_prod
decimal{4} ld_precio, ld_costo

dw.setitem(1,"prod_g_financiero",str.g_financiero)
dw.setitem(1,"prod_empresa",str.empresa)
ld_costo =  dw.getitemdecimal(1,"prod_costo_unitario")

ll_update=dw.update()
if ll_update = 1  then
	ls_prod	 =	dw.getitemstring(1,"prod_producto")
	ld_precio =	dw.getitemdecimal(1,"prod_precio_mayor")
	ld_costo	 =	dw.getitemdecimal(1,"prod_costo_unitario")
	
//	select max(ubic_bodega), max(ubic_ubicacion) 
//	into   :ls_bodega, :ls_ubicacion
//	  from inaubica 
//	  where ubic_g_financiero = :str.g_financiero and 
//	  		  ubic_empresa = :str.empresa and
// 			  ubic_bodega + ubic_ubicacion  <> :w_cr_fondo.is_bodega + :w_cr_fondo.is_ubicacion
//	  group by ubic_g_financiero , ubic_empresa ; 

//	INSERT INTO inmbodeg  
//         ( mbod_g_financiero,   
//           mbod_empresa,   
//           mbod_bodega,   
//           mbod_ubicacion,   
//           mbod_producto,   
//           mbod_costo_cif,   
//           mbod_cantidad,   
//           mbod_cantidad_fisico,   
//           mbod_precio_mayor,     
//           mbod_id )  
//  VALUES ( :str.g_financiero,   
//           :str.empresa,
//			  :ls_bodega,
//			  :ls_ubicacion,
//           :ls_prod,   
//           :ld_costo,   
//           0,   
//           0,   
//           :ld_precio,      
//           :str.usuario )  ;

//	commit ;
	messagebox("Aviso"," ¡ Actualización Exitosa ! ")
	dw.reset()
	dw.insertrow(0)
else
	rollback ;
	messagebox("Aviso","¡ Error al Actualizar !")
end if
gf_in_enabled_save(str.frame.GetActiveSheet().MenuName, False)


end event

event ue_adicionar;dw.reset()

dw.setcolumn(1)
dw.scrolltorow(dw.insertrow(0))
dw.setcolumn(1)



end event

event ue_buscar;long						ll_num_prove, ll_row
string					ls_syntax, ls_codigo,  ls_syntax_res
integer					li_len
str_dg_dynamic_find	lstr_df
datawindowchild		ldwc_

/***************************************************************************************
 *										                                  								*
 *  									Búsqueda Dinámica de Secuencia y Productos					*
 ***************************************************************************************/
 
	
	lstr_df.texto_campo [1,1] = "inmprodu.prod_producto"
	lstr_df.texto_campo [1,2] = "Producto"
	lstr_df.texto_campo [1,3] = "prod_producto"
	lstr_df.texto_campo [1,4] = "V"
	lstr_df.texto_campo [2,1] = "inmprodu.prod_descripcion"
	lstr_df.texto_campo [2,2] = "Descripción"
	lstr_df.texto_campo [2,3] = ""
	lstr_df.texto_campo [2,4] = "V"
	// Gianni Araúz (17/03/2000)

	
	lstr_df.tabla 		  = " inmprodu "
	lstr_df.tabla_where = " WHERE ( inmprodu.prod_g_financiero = "+ string(str.g_financiero)+" ) AND " +&
                         "( inmprodu.prod_empresa = "+string(str.empresa)+" ) AND " +&
                         "( inmprodu.prod_status = 1 ) AND " +&
                         "( substring(inmprodu.prod_owner,1,1 ) = '1' ) " 
	
  // lstr_df.sql = ' '
 
	OpenWithParm(w_dg_a_custom_find,lstr_df)
	ls_syntax = Message.StringParm
	
	// Gianni Araúz (01/03/2000)
	if len(trim(ls_syntax)) = 0 then
		messagebox('Error','No se recuperaron los datos.',Exclamation!)
		return
	end if

	ls_syntax_res = Right(ls_syntax,Len(ls_syntax) - Pos(ls_syntax,"= '") - 2)
//	ls_codigo = left(ls_syntax_res,Pos(ls_syntax_res,"'  And") - 1)
	ls_codigo = ls_syntax_res
	gf_replace_cadena(ls_codigo,"'"," ")
	ls_codigo = left(Trim(ls_codigo)+fill(' ',20),20)
	
	if not IsNull(ls_codigo) and trim(ls_codigo) <> '' then
		dw.retrieve(str.g_financiero,str.empresa,ls_codigo)
	else
		return
	end If
	
end event

event open;call super::open;
//CHOOSE CASE str.aplicacion
//	CASE "CR"		
//		This.ChangeMenu (m_hs)
//		//m_hs.archivo.m_cerrar.toolbaritemvisible = False
//		//m_hs.ver.m_zoom.enabled				= FALSE
//		//m_hs.ver.m_verreglas.enabled			= FALSE
//	CASE "IN"
//		This.ChangeMenu (m_in_parametros)
//		m_in_parametros.m_archivo.m_imprimir.toolbaritemvisible = false
//	CASE ELSE
//		//MessageBox ("Aplicación",str.aplicacion)
//END CHOOSE
end event

type st_nom_ventana from w_in_padre`st_nom_ventana within w_in_ma_prod_reducido_comp
boolean visible = false
integer x = 46
integer y = 1472
integer width = 878
end type

type dw_1 from w_in_padre`dw_1 within w_in_ma_prod_reducido_comp
integer x = 32
integer y = 20
integer width = 2944
integer height = 1380
string dataobject = "dw_man_in_prod_resumido_comp"
end type

event dw_1::clicked;call super::clicked;//This.SelectRow(0, FALSE)
//This.SelectRow(row, TRUE)
end event

event dw_1::ue_helpcol;// Toma la Columna en la cual el usuario pidio ayuda

String ls_col,ls_item

ls_col = This.GetColumnName()

CHOOSE CASE ls_col		
	CASE "prod_producto"  /*Codigo de Producto*/
		  parent.triggerevent("ue_buscar")
END CHOOSE




end event

event dw_1::itemchanged;call super::itemchanged;// Copia y pega en tu ventana

DataWindowChild	ldwc_
string	ls_var,ls_filtro,ls_nulo, ls_grupo, ls_sub_grupo, ls_linea, ls_division
decimal	{4} ld_cubicaje 
long		ll_empaque
Integer	li_rtn

accepttext()

ll_empaque = this.getitemnumber(1,"prod_empaque")
if ll_empaque = 0 or isnull(ll_empaque) then ll_empaque = 1

if dw_1.GetColumnName () =  "prod_producto"  or &
    dw_1.GetItemStatus (dw_1.getrow(),0,primary! ) = new! then		
	  if not isnull (data) then	
		  this.setredraw(false)
		  dw.retrieve(str.g_financiero,str.empresa,data)
		  
		  if dw.rowcount() = 0 then 
			  dw.insertrow(0)
			  dw.setitem(1,"prod_producto",data)
	 	  end if			
		  this.setredraw(true)					  
	  end if	
end if

Choose Case dwo.name
	Case "prod_producto"

		ls_division = this.getitemstring(row,'prod_division')
		ls_grupo	 	= this.getitemstring(row,'prod_grupo')
		ls_sub_grupo = this.getitemstring(row,'prod_sub_grupo')		
		
		//recupera los grupos
		this.GetChild('prod_grupo',ldwc_)
		ldwc_.SettransObject(Sqlca)
		if ldwc_.retrieve(str.g_financiero,str.empresa,ls_division) = 0 then ldwc_.Insertrow(0)

		
		//recupera los subgrupos
		this.GetChild('prod_sub_grupo',ldwc_)
		ldwc_.SettransObject(Sqlca)
		if ldwc_.retrieve(str.g_financiero,str.empresa,ls_division,ls_grupo) = 0 then ldwc_.Insertrow(0)

		
		//recupera las lineas
		this.GetChild('prod_clase',ldwc_)
		ldwc_.SettransObject(Sqlca)
		if ldwc_.retrieve(str.g_financiero,str.empresa,ls_division,ls_grupo,ls_sub_grupo) = 0 then ldwc_.Insertrow(0)

	
	Case "prod_division"
		setnull(ls_nulo)
		this.setitem(row,'prod_grupo',ls_nulo)
		this.setitem(row,'prod_sub_grupo',ls_nulo)
		this.setitem(row,'prod_clase',ls_nulo)
		
		//recupera los grupos
		this.GetChild('prod_grupo',ldwc_)
		ldwc_.SettransObject(Sqlca)
		if ldwc_.retrieve(str.g_financiero,str.empresa,data) = 0 then ldwc_.Insertrow(0)
		ls_grupo = ldwc_.getitemstring(1,'agru_codigo_grupo')		
		this.setitem(row,'prod_grupo',ls_grupo)
		
		//recupera los subgrupos
		this.GetChild('prod_sub_grupo',ldwc_)
		ldwc_.SettransObject(Sqlca)
		if ldwc_.retrieve(str.g_financiero,str.empresa,data,ls_grupo) = 0 then ldwc_.Insertrow(0)
		ls_sub_grupo = ldwc_.getitemstring(1,'asub_codigo_subgrupo')		
		this.setitem(row,'prod_sub_grupo',ls_sub_grupo)
		
		//recupera las lineas
		this.GetChild('prod_clase',ldwc_)
		ldwc_.SettransObject(Sqlca)
		if ldwc_.retrieve(str.g_financiero,str.empresa,data,ls_grupo,ls_sub_grupo) = 0 then ldwc_.Insertrow(0)
		ls_linea = ldwc_.getitemstring(1,'alin_codigo_linea')		
		this.setitem(row,'prod_clase',ls_linea)			

	Case "prod_grupo"
		setnull(ls_nulo)
		this.setitem(row,'prod_sub_grupo',ls_nulo)
		this.setitem(row,'prod_clase',ls_nulo)
		
		this.GetChild('prod_sub_grupo',ldwc_)
		ldwc_.SettransObject(Sqlca)
		if ldwc_.retrieve(str.g_financiero,str.empresa,this.getitemstring(row,"prod_division"),data) = 0 then ldwc_.Insertrow(0)
	
	Case "prod_sub_grupo"
		setnull(ls_nulo)
		this.setitem(row,'prod_clase',ls_nulo)
		
		this.GetChild('prod_clase',ldwc_)
		ldwc_.SettransObject(Sqlca)
		if ldwc_.retrieve(str.g_financiero,str.empresa,this.GetItemString(row,"prod_division"),this.GetItemString(row,"prod_grupo"),data) = 0 then ldwc_.Insertrow(0)
End Choose


CHOOSE CASE dw_1.GetColumnName ()
case "cubicaje"
//	ld_cubicaje = this.getitemnumber(1,"cubicaje")
//	this.setitem(1,"prod_cubicaje",round(ld_cubicaje / ll_empaque,4))	  
	ld_cubicaje = this.getitemnumber(1,"prod_cubicaje")
	this.setitem(1,"prod_cubicaje",round(ld_cubicaje,4))	  
case "peso"
//	ld_cubicaje = this.getitemnumber(1,"peso")
//	this.setitem(1,"prod_peso",round(ld_cubicaje / ll_empaque,4))	  
	ld_cubicaje = this.getitemnumber(1,"prod_peso")
	this.setitem(1,"prod_peso",round(ld_cubicaje,4))	  
case "prod_medida"	
	this.setitem(1,"prod_empaque_um",this.getitemstring(1,"prod_medida"))
END CHOOSE

end event

type dw_2 from w_in_padre`dw_2 within w_in_ma_prod_reducido_comp
end type

type gb_ventana from w_in_padre`gb_ventana within w_in_ma_prod_reducido_comp
integer x = 18
integer y = 1436
integer width = 960
integer height = 100
integer taborder = 0
end type

type cb_1 from commandbutton within w_in_ma_prod_reducido_comp
integer x = 1650
integer y = 1412
integer width = 1239
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Comentarios para el uso de la Ventana"
end type

event clicked;OPEN(W_IN_MAN_PROD_COMENTARIO)
end event

type cb_2 from commandbutton within w_in_ma_prod_reducido_comp
boolean visible = false
integer x = 1029
integer y = 1412
integer width = 297
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Salvar"
end type

event clicked;parent.triggerevent('ue_aceptar')
end event

type cb_3 from commandbutton within w_in_ma_prod_reducido_comp
boolean visible = false
integer x = 1335
integer y = 1412
integer width = 297
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Sa&lir"
end type

event clicked;if messagebox('Información','¿Está seguro que desea salir de la Ventana?',&
					Question!,YesNo!,2) = 1 then close(parent)
end event

type gb_1 from groupbox within w_in_ma_prod_reducido_comp
integer x = 1001
integer y = 1368
integer width = 1915
integer height = 164
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

