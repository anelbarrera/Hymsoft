//objectcomments Ventana donde se establece la Fecha hasta la cual se desea obtener el informe de los pedidos pendientes de facturar.
forward
global type w_fa_rep_productos_agotados from window
end type
type st_2 from statictext within w_fa_rep_productos_agotados
end type
type st_1 from statictext within w_fa_rep_productos_agotados
end type
type cb_1 from commandbutton within w_fa_rep_productos_agotados
end type
type dw_2 from datawindow within w_fa_rep_productos_agotados
end type
type dw_1 from datawindow within w_fa_rep_productos_agotados
end type
type gb_1 from groupbox within w_fa_rep_productos_agotados
end type
type em_1 from editmask within w_fa_rep_productos_agotados
end type
type sle_1 from singlelineedit within w_fa_rep_productos_agotados
end type
end forward

global type w_fa_rep_productos_agotados from window
integer width = 1527
integer height = 572
boolean titlebar = true
string title = "(FA)  Listado Productoss Agotados"
string menuname = "m_hs"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
event ue_print ( )
event ue_imprimir ( )
st_2 st_2
st_1 st_1
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
gb_1 gb_1
em_1 em_1
sle_1 sle_1
end type
global w_fa_rep_productos_agotados w_fa_rep_productos_agotados

forward prototypes
public subroutine wf_imprime_vendedor ()
end prototypes

event ue_print;OpenWithParm(w_dw_print_options, dw_1)

If Message.DoubleParm = -1 Then Return
dw_1.Print(True)
end event

event ue_imprimir();This.Triggerevent('ue_print')
end event

public subroutine wf_imprime_vendedor ();integer li_hay, li_codigo, i=0, li_vienede
long	  ll_ann
string  ls_nombre, ls_resultado, ls_nombre_imp, ls_cod_imp, ls_dataobject, ls_pedido, ls_tipo

datawindow ldw_1

ldw_1 = dw_1

ls_dataobject = dw_1.dataobject

If IsNull(ls_dataobject) then return

li_vienede = dw_1.getitemnumber(1,'agot_viene_de_factura')
ls_pedido  = dw_1.getitemstring(1,'fadagota_agot_no_pedido')
ll_ann	  = dw_1.getitemnumber(1,'fadagota_agot_anno')
ls_tipo	  = dw_1.getitemstring(1,'fadagota_agot_tipo')


if li_vienede = 1 then  //Para cuando es Factura
	
		 DECLARE cur_vende CURSOR FOR
		  SELECT fadvenfa.vfac_vendedor,   
					famvende.vend_nombre+' '+famvende.vend_apellido nombre  
			 FROM fadvenfa,   
					famvende  
			WHERE ( famvende.vend_g_financiero = fadvenfa.vfac_g_financiero ) and  
					( famvende.vend_empresa = fadvenfa.vfac_empresa ) and  
					( famvende.vend_vendedor = fadvenfa.vfac_vendedor ) and  
					( ( fadvenfa.vfac_g_financiero = :str.g_financiero ) AND  
					( fadvenfa.vfac_empresa = :str.empresa ) AND  
					( fadvenfa.vfac_tipo = :ls_tipo ) AND  
					( fadvenfa.vfac_no_pedido = :ls_pedido ) AND  
					( fadvenfa.vfac_ann = :ll_ann ) ) ;			 

		 OPEN cur_vende;
		 
		 if sqlca.sqlcode = -1 then
			mensaje("Aviso","Error al Abrir el Cursor",sqlca.sqlerrtext)
		 end if
		 
		 FETCH cur_vende INTO :li_codigo,:ls_nombre;
		 
		 IF SQLCA.SQLCODE = -1 THEN	
			MESSAGEBOX("ERROR","ERROR AL SELECCIONAR LOS VENDEDORES "+SQLCA.SQLERRTEXT)
			CLOSE cur_vende;
			RETURN
		 END IF	
		 
		 DO WHILE SQLCA.SQLCODE = 0
			 if i > 0 then //Si no es la primera vez ni la ultima, separa el codigo
				ls_nombre_imp += ' / '
				ls_cod_imp	+= ' / '		
			 end if	 
			 ls_nombre_imp += ls_nombre 	     //Concatena los codigos y nombres
			 ls_cod_imp		+= string(li_codigo)	 
			 i ++	 //Incrementa la i
			 FETCH cur_vende INTO :li_codigo,:ls_nombre;	 
		 loop
		 
		 ls_resultado = ldw_1.modify("cod_vendedor.text='"+ls_cod_imp+"'")
		 ls_resultado = ldw_1.modify("nom_vendedor.text='"+ls_nombre_imp+"'")			
			 
		 CLOSE cur_vende;
		 							
	
else		//Para cuando es Pedido

			 DECLARE cur_vende_pe CURSOR FOR
		  SELECT fadvenpe.vped_vendedor,   
					famvende.vend_nombre+' '+famvende.vend_apellido nombre  
			 FROM fadvenpe,   
					famvende  
			WHERE ( famvende.vend_g_financiero = fadvenpe.vped_g_financiero ) and  
					( famvende.vend_empresa = fadvenpe.vped_empresa ) and  
					( famvende.vend_vendedor = fadvenpe.vped_vendedor ) and  
					( ( fadvenpe.vped_g_financiero = :str.g_financiero ) AND  
					( fadvenpe.vped_empresa = :str.empresa ) AND  
					( fadvenpe.vped_no_pedido = :ls_pedido ) AND  
					( fadvenpe.vped_ann = :ll_ann ) ) ;			
					
		 OPEN cur_vende_pe;
		 
		 if sqlca.sqlcode = -1 then
			mensaje("Aviso","Error al Abrir el Cursor",sqlca.sqlerrtext)
		 end if
		 
		 FETCH cur_vende_pe INTO :li_codigo,:ls_nombre;
		 
		 IF SQLCA.SQLCODE = -1 THEN	
			MESSAGEBOX("ERROR","ERROR AL SELECCIONAR LOS VENDEDORES "+SQLCA.SQLERRTEXT)
			CLOSE cur_vende_pe;
			RETURN
		 END IF	
		 
		 DO WHILE SQLCA.SQLCODE = 0
			 if i > 0 then //Si no es la primera vez ni la ultima, separa el codigo
				ls_nombre_imp += ' / '
				ls_cod_imp	+= ' / '		
			 end if	 
			 ls_nombre_imp += ls_nombre 	     //Concatena los codigos y nombres
			 ls_cod_imp		+= string(li_codigo)	 
			 i ++	 //Incrementa la i
			 FETCH cur_vende_pe INTO :li_codigo,:ls_nombre;	 
		 loop
		 
		 ls_resultado = ldw_1.modify("cod_vendedor.text='"+ls_cod_imp+"'")
		 ls_resultado = ldw_1.modify("nom_vendedor.text='"+ls_nombre_imp+"'")			
			 
		 CLOSE cur_vende_pe;

 end if	//del pos
end subroutine

on w_fa_rep_productos_agotados.create
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_1=create gb_1
this.em_1=create em_1
this.sle_1=create sle_1
this.Control[]={this.st_2,&
this.st_1,&
this.cb_1,&
this.dw_2,&
this.dw_1,&
this.gb_1,&
this.em_1,&
this.sle_1}
end on

on w_fa_rep_productos_agotados.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.em_1)
destroy(this.sle_1)
end on

event open;string is_nombre
IF Trim(Message.StringParm) <> "" THEN
	This.Tag = Trim(Message.StringParm)
END IF
this.width  = 1381
this.height = 360

This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)

is_nombre = This.ClassName()
gf_win_used_by_user(is_nombre, true)
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
//st_nom_ventana.text = is_nombre
dw_1.Object.datawindow.print.preview = true

 gf_center_win(This)

 
end event

event resize;dw_1.width = newwidth - 100
dw_1.height = newheight - 250
end event

event close;Window lw_frame

setredraw(false)
lw_frame = ParentWindow()
If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_evaluar_panel_acciones")
 End If
if isvalid(this) then close(this)
end event

event closequery;constant int SW_HIDE = 0
ShowWindow(Handle(this), SW_HIDE)

This.SetRedraw(false)
end event

event activate;gnv_seg.of_aplicar_acciones_ventana(w_hs_frame.rbb_1, this.tag)
end event

type st_2 from statictext within w_fa_rep_productos_agotados
integer x = 434
integer y = 72
integer width = 261
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "# Pedido:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_fa_rep_productos_agotados
integer x = 50
integer y = 72
integer width = 151
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año:"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_fa_rep_productos_agotados
integer x = 1065
integer y = 52
integer width = 256
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Listado"
end type

event clicked;long ll_anio

ll_anio = long( em_1.text)
dw_1.visible = false
dw_2.retrieve(str.g_financiero, str.empresa, ll_anio)
if dw_2.rowcount() > 0 then
  dw_2.visible = true
    w_fa_rep_productos_agotados.width     = 1381
    w_fa_rep_productos_agotados.height    = 1104
else
	dw_2.visible = false
	dw_1.visible = false
	 w_fa_rep_productos_agotados.width  = 1381
    w_fa_rep_productos_agotados.height = 360
end if

gf_center_win(parent)
end event

type dw_2 from datawindow within w_fa_rep_productos_agotados
boolean visible = false
integer x = 219
integer y = 188
integer width = 923
integer height = 696
integer taborder = 10
boolean titlebar = true
string title = "Selección de Pedido"
string dataobject = "dw_dd_fa_pedido_agotado"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;String ls_no_pedido
Long ll_anno, ll_linea
if this.rowcount() > 0 then
	
ls_no_pedido = this.getitemString(row, 'agot_no_pedido')
ll_anno      = this.getitemNumber(row, 'agot_anno')

sle_1.text = ls_no_pedido

ll_linea = dw_1.retrieve(str.g_financiero,str.empresa, ls_no_pedido, ll_anno)

if ll_linea > 0 then 

 this.visible = false
 w_fa_rep_productos_agotados.width  =  3456
 w_fa_rep_productos_agotados.height =  1552
 dw_1.visible = true
else
 w_fa_rep_productos_agotados.width  = 11381
 w_fa_rep_productos_agotados.height = 1104
 dw_1.visible = false
 MessageBox("AVISO","Pedido # "+ ls_no_pedido + ", Año "+string(ll_anno) +" No Tiene Agotados")
end if
else
 w_fa_rep_productos_agotados.width  = 1381
 w_fa_rep_productos_agotados.height = 360
end if

gf_center_win(parent)
end event

type dw_1 from datawindow within w_fa_rep_productos_agotados
boolean visible = false
integer y = 188
integer width = 3406
integer height = 1228
integer taborder = 20
string dataobject = "dw_fa_rep_agotada_pedido"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;//Para Imprimir el codigo o el nombre de los vendedores
If dw_1.Rowcount() > 0 then 
	wf_imprime_vendedor()
end if
end event

type gb_1 from groupbox within w_fa_rep_productos_agotados
integer x = 27
integer width = 1307
integer height = 176
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Selección"
end type

type em_1 from editmask within w_fa_rep_productos_agotados
event ue_key pbm_keydown
integer x = 174
integer y = 56
integer width = 256
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "2001"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy"
boolean spin = true
end type

event ue_key;//
CHOOSE CASE key
	CASE keyenter!
 sle_1.setfocus() 
END CHOOSE

end event

type sle_1 from singlelineedit within w_fa_rep_productos_agotados
event ue_key pbm_keydown
integer x = 672
integer y = 56
integer width = 361
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event ue_key;CHOOSE CASE key
	CASE keyenter!
 cb_1.setfocus()
// cb_1.triggerevent("Clicked")
END CHOOSE

end event

event modified;String ls_no_pedido
Long ll_anno, ll_linea

ls_no_pedido = sle_1.text
ll_anno      = long(em_1.text)

ll_linea = dw_1.retrieve(str.g_financiero,str.empresa, ls_no_pedido, ll_anno)

if ll_linea > 0 then 

 w_fa_rep_productos_agotados.width  =  3456
 w_fa_rep_productos_agotados.height =  1552
 dw_1.visible = true
 
else
 w_fa_rep_productos_agotados.width  = 1381
 w_fa_rep_productos_agotados.height = 1104
 dw_1.visible = false
 MessageBox("AVISO","Pedido # "+ ls_no_pedido + ", Año "+string(ll_anno) +" No Existe o No Tiene Agotados")
end if

gf_center_win(parent)
end event

