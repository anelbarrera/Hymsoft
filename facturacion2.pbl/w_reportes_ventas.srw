//objectcomments Informe de Ventas Por Cliente, Resumido y Detallado con Rango de Fechas
forward
global type w_reportes_ventas from w_fa_padre_reportes
end type
type cb_consultar from commandbutton within w_reportes_ventas
end type
type ddlb_cliente from dropdownlistbox within w_reportes_ventas
end type
type em_fecha_inicial from editmask within w_reportes_ventas
end type
type em_fecha_final from editmask within w_reportes_ventas
end type
type ddlb_tipo from dropdownlistbox within w_reportes_ventas
end type
type cbx_todos from checkbox within w_reportes_ventas
end type
type st_3 from statictext within w_reportes_ventas
end type
type st_1 from statictext within w_reportes_ventas
end type
type st_2 from statictext within w_reportes_ventas
end type
type st_4 from statictext within w_reportes_ventas
end type
type ddlb_informe from dropdownlistbox within w_reportes_ventas
end type
type st_5 from statictext within w_reportes_ventas
end type
type st_6 from statictext within w_reportes_ventas
end type
type ddlb_orden from dropdownlistbox within w_reportes_ventas
end type
type cbx_des from checkbox within w_reportes_ventas
end type
type ddlb_1 from dropdownlistbox within w_reportes_ventas
end type
type cbx_quitar_desc from checkbox within w_reportes_ventas
end type
type cb_salir from commandbutton within w_reportes_ventas
end type
type rb_factura from radiobutton within w_reportes_ventas
end type
type rb_cliente from radiobutton within w_reportes_ventas
end type
type cbx_vend from checkbox within w_reportes_ventas
end type
type rb_producto from radiobutton within w_reportes_ventas
end type
type cbx_diario from checkbox within w_reportes_ventas
end type
type cbx_mensual from checkbox within w_reportes_ventas
end type
type calendario from picture within w_reportes_ventas
end type
type calendario2 from picture within w_reportes_ventas
end type
type uo_1 from u_ddcalen within w_reportes_ventas
end type
type uo_2 from u_ddcalen within w_reportes_ventas
end type
type cb_1 from commandbutton within w_reportes_ventas
end type
type cbx_pais from checkbox within w_reportes_ventas
end type
type cbx_itbm from checkbox within w_reportes_ventas
end type
type rb_resumen_anual from radiobutton within w_reportes_ventas
end type
type rb_div_grupo from radiobutton within w_reportes_ventas
end type
type rb_resumen_pais from radiobutton within w_reportes_ventas
end type
type cbx_global from checkbox within w_reportes_ventas
end type
type gb_2 from groupbox within w_reportes_ventas
end type
type gb_3 from groupbox within w_reportes_ventas
end type
end forward

global type w_reportes_ventas from w_fa_padre_reportes
string tag = "Informe de Ventas Por Cliente"
integer x = 165
integer y = 20
integer width = 3232
integer height = 1120
string title = "Informe de Ventas"
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 12639424
cb_consultar cb_consultar
ddlb_cliente ddlb_cliente
em_fecha_inicial em_fecha_inicial
em_fecha_final em_fecha_final
ddlb_tipo ddlb_tipo
cbx_todos cbx_todos
st_3 st_3
st_1 st_1
st_2 st_2
st_4 st_4
ddlb_informe ddlb_informe
st_5 st_5
st_6 st_6
ddlb_orden ddlb_orden
cbx_des cbx_des
ddlb_1 ddlb_1
cbx_quitar_desc cbx_quitar_desc
cb_salir cb_salir
rb_factura rb_factura
rb_cliente rb_cliente
cbx_vend cbx_vend
rb_producto rb_producto
cbx_diario cbx_diario
cbx_mensual cbx_mensual
calendario calendario
calendario2 calendario2
uo_1 uo_1
uo_2 uo_2
cb_1 cb_1
cbx_pais cbx_pais
cbx_itbm cbx_itbm
rb_resumen_anual rb_resumen_anual
rb_div_grupo rb_div_grupo
rb_resumen_pais rb_resumen_pais
cbx_global cbx_global
gb_2 gb_2
gb_3 gb_3
end type
global w_reportes_ventas w_reportes_ventas

type variables
//Variables de Instancia

string is_nativo  //SQL original

string is_orden, is_empresa, is_tipo, is_fpago

//datawindow dw_impresion
integer ii_ultima_seleccion, ii_ultimo_orden, ii_dia, ii_mes, ii_ann

str_fa_ventaclie str_venta

str_fa_ventafact  str_informe

str_fa_ventafact  str_informe_prod
end variables

forward prototypes
public subroutine wf_botones ()
public subroutine wf_valida_fechas (ref date fecha_ini, ref date fecha_fin, integer desde_fecha)
public subroutine wf_ocultar_asterisco ()
public subroutine wf_avance (long al_avance, long al_total)
public subroutine wf_setear_sql (string ls_nombre, string ls_tipo)
end prototypes

public subroutine wf_botones ();//Deshabilitar botones no necesarios.
//	m_fa_padre.m_edicin.m_siguienteregistro.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_registroanterior.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_ultimoregistro.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_primerregistro.toolbaritemvisible=false
//	m_fa_padre.m_archivo.m_vistapreliminar.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_sortear.toolbaritemvisible=false
//	m_fa_padre.m_edicin.m_filtrar.toolbaritemvisible=false


end subroutine

public subroutine wf_valida_fechas (ref date fecha_ini, ref date fecha_fin, integer desde_fecha);// Función que valida la correcta introducción de las Fechas

Choose Case desde_fecha 

  Case 1
	
	If  fecha_ini > fecha_fin Then
	
		fecha_ini = fecha_fin
	
		messagebox("ATENCIÓN SR. USUARIO","Fecha Incorrecta Cambiada por Fecha Final", Exclamation!)
	
	End If

  Case 2

	If fecha_fin < fecha_ini Then
	
		fecha_fin = fecha_ini

		messagebox("ATENCIÓN SR. USUARIO","Fecha Incorrecta ha sido ajustada a la Inicial", Exclamation!)
	
	End If

End Choose
end subroutine

public subroutine wf_ocultar_asterisco ();//Función que oculta los asterisco que indican el tipo de ordenamiento que tiene el informe.

		dw_1.object.fech.visible = 0
		dw_1.object.factura.visible = 0

end subroutine

public subroutine wf_avance (long al_avance, long al_total);//Marca el Avance en la barra

//ole_1.Object.Value = (al_avance / al_total) * 100
end subroutine

public subroutine wf_setear_sql (string ls_nombre, string ls_tipo);//Función que Setea el SQl dependiendo si son todos los clientes o si selecciono uno
//específico

String ls_where, ls_original, ls_signo, ls_inicio, ls_final, ls_factu_estado,ls_fecha1,ls_fecha2


dw_1.SetSQLSelect(is_nativo)     //Setea el SQL Original (Sin filtros) al Data Window

ls_original	= dw_1.getsqlselect()

//Para saber por que tipo de factura filtrar
If ls_tipo  = "TODAS" Then
	ls_signo = "<>"
Else
	ls_tipo = Mid(ls_tipo, 1, 2)
	ls_signo = "="
End If

//Para el Rango de Fechas
If em_fecha_inicial.text <> "" And em_fecha_final.text <> "" Then	
	ls_inicio = gf_cambia_fecha(em_fecha_inicial.text,0)
	ls_final  = gf_cambia_fecha(em_fecha_final.text,1)
	ls_fecha1 = String(date(em_fecha_inicial.text))
	ls_fecha2 = String(date(em_fecha_final.text))
End If

//Para filtrar por el estado de las facturas
ls_factu_estado = left(ddlb_1.text,1)

//Todos los Clientes o algunos
If cbx_todos.Checked = True Then
	 ls_where = ls_original + " And  &
					 ( fatdiari.fact_g_financiero = "+ string(str.g_financiero) +" ) And &
					 ( fatdiari.fact_empresa = "+ string(str.empresa) +" ) And &
					 ( fatdiari.fact_estado  = '"+ls_factu_estado+"' ) And &
					 ( fatdiari.fact_condicion_pago "+ ls_signo +" '"+ ls_tipo +"' ) And  &
					 ( fatdiari.fact_fecha >= '"+ls_fecha1  +"' ) And &
		 			 ( fatdiari.fact_fecha < DateAdd(dd,1, '"+ls_fecha2+"'))"
					 
Else	
	ls_where = ls_original + " And  &
					 ( fatdiari.fact_g_financiero = "+string(str.g_financiero)+" ) And &
					 ( fatdiari.fact_empresa = "+string(str.empresa)+ " ) And &
					 ( fatdiari.fact_estado  = '"+ls_factu_estado+"' ) And &
					 ( dgmterce.terc_descripcion = '"+ ls_nombre + "' ) And &
 					 ( fatdiari.fact_condicion_pago "+ls_signo+" '"+ls_tipo+"' ) And  &
					 ( fatdiari.fact_fecha >= '"+ls_fecha1  +"' ) And &
		 			 ( fatdiari.fact_fecha < DateAdd(dd,1, '"+ls_fecha2+"'))"
End If

dw_1.SetSQLSelect(ls_where)		//Setea el SQL al Data Window

str_informe.ls_where	= dw_1.getsqlselect()

If sqlca.sqlcode = -1 Then
	
	messagebox("ATENCIÓN SR. USUARIO","Error "+sqlca.sqlerrtext)
	
End If	

end subroutine

on w_reportes_ventas.create
int iCurrent
call super::create
this.cb_consultar=create cb_consultar
this.ddlb_cliente=create ddlb_cliente
this.em_fecha_inicial=create em_fecha_inicial
this.em_fecha_final=create em_fecha_final
this.ddlb_tipo=create ddlb_tipo
this.cbx_todos=create cbx_todos
this.st_3=create st_3
this.st_1=create st_1
this.st_2=create st_2
this.st_4=create st_4
this.ddlb_informe=create ddlb_informe
this.st_5=create st_5
this.st_6=create st_6
this.ddlb_orden=create ddlb_orden
this.cbx_des=create cbx_des
this.ddlb_1=create ddlb_1
this.cbx_quitar_desc=create cbx_quitar_desc
this.cb_salir=create cb_salir
this.rb_factura=create rb_factura
this.rb_cliente=create rb_cliente
this.cbx_vend=create cbx_vend
this.rb_producto=create rb_producto
this.cbx_diario=create cbx_diario
this.cbx_mensual=create cbx_mensual
this.calendario=create calendario
this.calendario2=create calendario2
this.uo_1=create uo_1
this.uo_2=create uo_2
this.cb_1=create cb_1
this.cbx_pais=create cbx_pais
this.cbx_itbm=create cbx_itbm
this.rb_resumen_anual=create rb_resumen_anual
this.rb_div_grupo=create rb_div_grupo
this.rb_resumen_pais=create rb_resumen_pais
this.cbx_global=create cbx_global
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_consultar
this.Control[iCurrent+2]=this.ddlb_cliente
this.Control[iCurrent+3]=this.em_fecha_inicial
this.Control[iCurrent+4]=this.em_fecha_final
this.Control[iCurrent+5]=this.ddlb_tipo
this.Control[iCurrent+6]=this.cbx_todos
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.ddlb_informe
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.st_6
this.Control[iCurrent+14]=this.ddlb_orden
this.Control[iCurrent+15]=this.cbx_des
this.Control[iCurrent+16]=this.ddlb_1
this.Control[iCurrent+17]=this.cbx_quitar_desc
this.Control[iCurrent+18]=this.cb_salir
this.Control[iCurrent+19]=this.rb_factura
this.Control[iCurrent+20]=this.rb_cliente
this.Control[iCurrent+21]=this.cbx_vend
this.Control[iCurrent+22]=this.rb_producto
this.Control[iCurrent+23]=this.cbx_diario
this.Control[iCurrent+24]=this.cbx_mensual
this.Control[iCurrent+25]=this.calendario
this.Control[iCurrent+26]=this.calendario2
this.Control[iCurrent+27]=this.uo_1
this.Control[iCurrent+28]=this.uo_2
this.Control[iCurrent+29]=this.cb_1
this.Control[iCurrent+30]=this.cbx_pais
this.Control[iCurrent+31]=this.cbx_itbm
this.Control[iCurrent+32]=this.rb_resumen_anual
this.Control[iCurrent+33]=this.rb_div_grupo
this.Control[iCurrent+34]=this.rb_resumen_pais
this.Control[iCurrent+35]=this.cbx_global
this.Control[iCurrent+36]=this.gb_2
this.Control[iCurrent+37]=this.gb_3
end on

on w_reportes_ventas.destroy
call super::destroy
destroy(this.cb_consultar)
destroy(this.ddlb_cliente)
destroy(this.em_fecha_inicial)
destroy(this.em_fecha_final)
destroy(this.ddlb_tipo)
destroy(this.cbx_todos)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_4)
destroy(this.ddlb_informe)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.ddlb_orden)
destroy(this.cbx_des)
destroy(this.ddlb_1)
destroy(this.cbx_quitar_desc)
destroy(this.cb_salir)
destroy(this.rb_factura)
destroy(this.rb_cliente)
destroy(this.cbx_vend)
destroy(this.rb_producto)
destroy(this.cbx_diario)
destroy(this.cbx_mensual)
destroy(this.calendario)
destroy(this.calendario2)
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.cb_1)
destroy(this.cbx_pais)
destroy(this.cbx_itbm)
destroy(this.rb_resumen_anual)
destroy(this.rb_div_grupo)
destroy(this.rb_resumen_pais)
destroy(this.cbx_global)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event resize;//this.X=5
//tHIS.Y=5
//
end event

event ue_post_open;//Override
//////////////////////////////////////////////////////////////////////////
//    Load the ddlb with cliente names from the cliente table.          //
//////////////////////////////////////////////////////////////////////////
String	ls_select, ls_nombre
date ldt_fecha_ini 
/* dw corresponde al datawindows que se desea imprimir, por tanto
   si desea asignarle otro nombre haga lo siguiente 
	dw = otro_nombre */
dw = dw_1
dw.settransobject(sqlca)
st_nom_ventana.text = this.classname()

cbx_todos.visible = false
ddlb_cliente.visible = false
st_2.visible = false

wf_botones()
If str.contabiliza = 0 Then 
	If dw_1.DataObject <> "dw_facturas_resumidas" Then	
		dw_1.DataObject = "dw_facturas_resumidas"
	End If
else
	If dw_1.DataObject <> "dw_fa_rep_ventas_fac_res_new" Then	
		dw_1.DataObject = "dw_fa_rep_ventas_fac_res_new"
	End If
end if

dw_1.SetTransObject (sqlca)
dw_1.InsertRow (0)
dw_impresion = dw_1

//if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 then
//	cbx_quitar_desc.visible = true
//end if

is_empresa = gf_fa_nom_empr( str.g_financiero , str.empresa  ) 
dw_1.object.empresa.expression = "'"+ is_empresa +"'"

ldt_fecha_ini = Date(gf_fecha_serv())
ii_ann = year(ldt_fecha_ini)
ii_mes  = month(ldt_fecha_ini)
ii_dia  = day(ldt_fecha_ini)

//gf_fecha_ini_fecha_fin(ii_mes,ii_ann,ldt_fecha_ini,ldt_fecha_fin)

	em_fecha_inicial.text = string(01)+ "/" +string(ii_mes)+ "/" +string(ii_ann)
	em_fecha_final.text =  string(gf_last_day(ii_mes,ii_ann))+ "/" +string(ii_mes)+ "/" +string(ii_ann)	

//	em_fecha_inicial.text = string(ii_dia)+ "/" +string(ii_mes)+ "/" +string(ii_ann)
//	em_fecha_final.text = string(ii_dia)+ "/" +string(ii_mes)+ "/" +string(ii_ann)

//em_fecha_inicial.text = "01/01/" + String (Year (Today()))
//em_fecha_final.text = String (Today())

Declare lcur_cust Cursor For 
 SELECT DISTINCT terc_descripcion 
    FROM dgmterce,   
         fatdiari  
   WHERE (terc_tercero = fact_cliente ) AND
			(fact_g_financiero = :str.g_financiero) AND
			(fact_empresa = :str.empresa );
			
		if sqlca.sqlcode = -1 then
			mensaje("Información 1","Error al Seleccionar en fatdiari",sqlca.sqlerrtext)
			return
		end if				

Open lcur_cust;


If sqlca.sqlcode < 0 Then
	MessageBox ("ATENCIÓN SR. USUARIO!", "Error :"+sqlca.sqlerrtext, exclamation!)
	Return
End If 


dw_1.SetRedraw(False)

Do While sqlca.sqlcode = 0
	Fetch lcur_cust Into :ls_nombre;
	If sqlca.sqlcode = 0 Then
		ddlb_cliente.AddItem (ls_nombre)
	ElseIf sqlca.sqlcode < 0 Then
		MessageBox ("DataBase Error", sqlca.sqlerrtext, exclamation!)
		Return
	Else
		Exit
	End If
Loop

is_nativo = dw_1.GetSqlSelect()  //Recupera el SQL original del Datawindow de reporte.

//messagebox("is_nativo",is_nativo)

ddlb_tipo.text    = "TODAS"
ddlb_informe.text = "RESUMIDO"
ddlb_orden.text   = "FACTURA"
ddlb_1.text			= "IMPRESAS"
is_tipo =  "RESUMIDO"

ii_ultimo_orden = 1

ii_ultima_seleccion = 1


//dw_1.SetRedraw(True)
Close lcur_cust;

rb_factura.checked = true
rb_factura.triggerevent( 'clicked')

this.setredraw(true)
end event

event open;call super::open;this.y = 0
this.x = 805

end event

type st_ayuda from w_fa_padre_reportes`st_ayuda within w_reportes_ventas
integer x = 0
integer y = 1012
end type

type st_nom_ventana from w_fa_padre_reportes`st_nom_ventana within w_reportes_ventas
boolean visible = false
integer x = 27
integer y = 936
integer width = 73
end type

type dw_1 from w_fa_padre_reportes`dw_1 within w_reportes_ventas
boolean visible = false
integer x = 46
integer y = 1008
integer width = 2720
integer height = 896
boolean enabled = false
string title = "Impresión"
string dataobject = "dw_fa_rep_ventas_fac_res_new"
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event dw_1::ue_escape;//Override
Send(Handle(dw_1), 274, 61728, 0)
end event

event dw_1::sqlpreview;call super::sqlpreview;if not rb_factura.checked then return

//messagebox('sqlsyntax',sqlsyntax)
String 	ls_where, ls_original, ls_signo, ls_signo2, ls_inicio, ls_final, ls_factu_estado,ls_fecha1,ls_fecha2
Date ldt_fecha1,ldt_fecha2
If is_fpago = "TODAS" Then
	ls_signo = "<>"
Else
	is_fpago = Mid(is_fpago, 1, 2)
	ls_signo = "="
End If

ls_signo2 = "="	

// If is_factura = "" Then
	If em_fecha_inicial.text = "" or em_fecha_final.text = "" Then
		mensaje("Atención ","Debe digitar el rango de fecha deseado correctamente o editar la factura a consultar ...","")
		Return
	Else
		ls_inicio = gf_cambia_fecha(em_fecha_inicial.text,0)
		ls_final  = gf_cambia_fecha(em_fecha_final.text,1)
		
		ldt_fecha1 = date(em_fecha_inicial.text)
	   ldt_fecha2 = date(em_fecha_final.text)
		ls_fecha1 = String(ldt_fecha1)
		ls_fecha2 = String(ldt_fecha2)
	End If
//End if

//Estado de las Facturas
ls_factu_estado = left(ddlb_1.text,1)

If true then //is_factura = "" Then

	ls_where = " and " + &
	"( fatdiari.fact_condicion_pago "+ls_signo+" '"+is_fpago+"' ) and  "+&
 	"( fatdiari.fact_estado  <> 'A' ) And "+&	
	"( fatdiari.fact_fecha >= '"+ls_fecha1+"' ) and "+&
	"( fatdiari.fact_fecha < dateadd(dd,1, '"+ls_fecha2+"' ))"
//Else
//	if not cbx_nc.checked then	//si es una factura
//		ls_where = " and " + & 
//		" ( fatdiari.fact_condicion_pago "+ls_signo+" '"+is_tipo+"' ) and "+&
//	 	" ( fatdiari.fact_estado  = '"+ls_factu_estado+"' ) And "+&		
//		" ( fatdiari.fact_no_factura = '"+is_factura+"' ) and "+&
//		" ( fatdiari.fact_no_pedido not like '%NC%' ) and "+&
//		" ( fatdiari.fact_ann	= "+string(ii_an)+" )"
//	else
//		ls_where = " and " + & 
//		" ( fatdiari.fact_condicion_pago "+ls_signo+" '"+is_tipo+"' ) and "+&
//	 	" ( fatdiari.fact_estado  = '"+ls_factu_estado+"' ) And "+&		
//		" ( fatdiari.fact_no_factura = '"+is_factura+"' ) and "+&
//		" ( fatdiari.fact_no_pedido like '%NC%' ) and "+&
//		" ( fatdiari.fact_ann	= "+string(ii_an)+" )"		
//	end if
End If
sqlsyntax += ls_where
str_informe.ls_where = ls_where
This.SetSqlPreview(sqlsyntax)


end event

event dw_1::retrieveend;call super::retrieveend;//Notas de Credito que afectan la ganancia

string ls_documento, ls_cuenta, ls_nombre
datetime ldt_desde, ldt_hasta, ldt_fecha
 
long ll_tercero
integer i
decimal{2} ld_monto
if dw_1.dataobject = 'dw_facturas_resumidas_hpsa' then
	
	ldt_desde = datetime(date(em_fecha_inicial.text), time('00:00:00'))
	ldt_hasta = datetime(date(em_fecha_final.text), time('23:59:59'))
	
	
	 DECLARE cur_nc CURSOR FOR  
  SELECT cctmovim.movi_documento,   
         cctmovim.movi_tercero,   
         cctmovim.movi_ruc_tercero,   
         cctmovim.movi_monto,   
         cctmovim.movi_fecha_tran,   
         cctmovim.movi_a_nombre  
    FROM cctmovim  
   WHERE ( cctmovim.movi_g_financiero = :str.g_financiero ) AND  
         ( cctmovim.movi_empresa = :str.empresa ) AND  
         ( cctmovim.movi_aplicacion = 'CC' ) AND  
         ( cctmovim.movi_tipo_transaccion = 'NC' ) AND  
         ( cctmovim.movi_fecha_tran >= :ldt_desde ) AND  
         ( cctmovim.movi_fecha_tran <= :ldt_hasta ) AND  
         ( cctmovim.movi_afecta_ganancia = 1 )   ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error en cursor '+sqlca.sqlerrtext,1,1,'E')
		return
	end if
	
	open cur_nc;
	
	fetch cur_nc into :ls_documento, :ll_tercero, :ls_cuenta, :ld_monto, :ldt_fecha, :ls_nombre ;
	i = rowcount
	do while sqlca.sqlcode = 0
		i ++
		this.insertrow(i)
		ld_monto = ld_monto * -1
		this.setitem(i,'fact_no_factura','NC-'+ls_documento)
		this.setitem(i,'fact_cliente',ll_tercero)
		this.setitem(i,'fact_ruc_cliente',ls_cuenta)
		this.setitem(i,'fact_monto_fact_total', ld_monto)
		this.setitem(i,'fact_fecha',ldt_fecha)
		this.setitem(i,'fact_a_nombre',ls_nombre)
		this.setitem(i,'costo_tot_c',0)
		this.setitem(i,'piezas',0)
		
	//	this.setitem(i,'operando',-1)
		fetch cur_nc into :ls_documento, :ll_tercero, :ls_cuenta, :ld_monto, :ldt_fecha, :ls_nombre ;
	loop
	close cur_nc ;
	this.sort()
	this.groupcalc()
	
end if
end event

type gb_1 from w_fa_padre_reportes`gb_1 within w_reportes_ventas
boolean visible = false
integer x = 2752
integer y = 8
integer width = 837
integer height = 1436
integer textsize = -12
end type

type cb_consultar from commandbutton within w_reportes_ventas
string tag = "Presione para Consultar"
integer x = 983
integer y = 872
integer width = 411
integer height = 100
integer taborder = 150
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Generar"
boolean default = true
end type

event clicked;/////////////////////////////////////////////////////////////////////////////////////////////
// Verify that the cliente name retrieval argument has been entered, and then retrieve the //   
// DataWindow with arguments the user entered.                                             //  
/////////////////////////////////////////////////////////////////////////////////////////////
String  ls_nombre, ls_tipo, ls_formato
Integer li_cod_cliente, li_resultado
Long    ll_resultado

dw_1.AcceptText()

if rb_cliente.checked then
	
	If Len (ddlb_cliente.text) = 0 And cbx_todos.checked = False Then
	
		dw_1.Reset()
		MessageBox ("ATENCIÓN SR. USUARIO", "Debe Especificar un Cliente para Consultar")
	
	Else
		
		ls_nombre  = trim(ddlb_cliente.text)
		ls_tipo    = trim(ddlb_tipo.text)
	
		wf_setear_sql(ls_nombre, ls_tipo)
				
		//Cargando la Estructura que envía Datos a la Ventana de Impresión
		str_informe.tipo = is_tipo
		str_informe.fecha1 = em_fecha_inicial.text
		str_informe.fecha2 = em_fecha_final.text
		str_informe.desc_sino =0
		str_informe.tipo_accion = 1
		if cbx_global.checked then
			str_informe.cliente_global = 1
		else
			str_informe.cliente_global = 0
		end if
		
		str.frame.Setmicrohelp("Generación del Informe en proceso, por favor espere, gracias !!")
	
		OpenSheetWithParm(w_ventas_clientes_imp,str_informe,Parent,2,Layered!)
		
		str.frame.Setmicrohelp("Informe Listo.")
		
	End If
	
elseif rb_factura.checked then
	
	 //Cargando la Estructura que envía Datos a la Ventana de Impresión
	 is_fpago    = trim(ddlb_tipo.text)		 
   	 str_informe.tipo = is_tipo		
	 str_informe.fecha1 = em_fecha_inicial.text
	 str_informe.fecha2 = em_fecha_final.text
	 str_informe.tipo_accion = 0
	 if cbx_vend.checked then 
		str_informe.cod_vendedor = 999
	elseif cbx_itbm.checked then 
		str_informe.cod_vendedor = 777
	else
		str_informe.cod_vendedor = 0
		if cbx_pais.checked then
			str_informe.cod_vendedor = 888
		end if
	end if
	
 	 if dw_1.Retrieve(str.g_financiero,str.empresa) = 0 then		//Recupera los Datos
	  gf_mensaje('','No se recupero informacion, Verifique !!!',1,1,'E')
	  return
	 end if
 	 OpenSheetWithParm(w_ventas_facturas_imp,str_informe,Parent,2,Layered!)  
  
 	 str.frame.Setmicrohelp("Informe Listo.")
	  
else
	
	 str_informe_prod.fecha_inicio = date(em_fecha_inicial.text)
	 str_informe_prod.fecha_final = date(em_fecha_final.text)
	 str_informe_prod.tipo   = is_tipo
	 
 	 OpenSheetWithParm(w_resumen_ventas_prod,str_informe_prod,Parent,2,Layered!)  
  
 	 str.frame.Setmicrohelp("Informe Listo.")
	 
end if
end event

type ddlb_cliente from dropdownlistbox within w_reportes_ventas
integer x = 832
integer y = 568
integer width = 1102
integer height = 428
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman Baltic"
long backcolor = 16777215
boolean enabled = false
boolean allowedit = true
boolean vscrollbar = true
end type

type em_fecha_inicial from editmask within w_reportes_ventas
integer x = 905
integer y = 236
integer width = 443
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean spin = true
double increment = 1
end type

event modified;
//Si la fecha es modificada, se valida en la función wf_valida_fecha()

date lf_fecha_ini, lf_fecha_fin

lf_fecha_ini = date(em_fecha_inicial.text)
lf_fecha_fin = date(em_fecha_final.text)

wf_valida_fechas(lf_fecha_ini, lf_fecha_fin, 1)

if em_fecha_inicial.text <> string(lf_fecha_ini) then
	em_fecha_inicial.text = string(lf_fecha_ini)
end if

end event

event losefocus;triggerevent("modified")
end event

type em_fecha_final from editmask within w_reportes_ventas
integer x = 1641
integer y = 236
integer width = 439
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean spin = true
double increment = 1
end type

event modified;//Si la fecha es modificada, se valida en la función wf_valida_fecha()

date lf_fecha_ini, lf_fecha_fin

lf_fecha_ini = date(em_fecha_inicial.text)
lf_fecha_fin = date(em_fecha_final.text)

wf_valida_fechas(lf_fecha_ini, lf_fecha_fin, 2)  //el 2 indica que es la segunda fecha

//Optimizar, esta entrando aunque no cambie la fecha, porque el año de lf_fecha_fin va en 2 digitos

if em_fecha_final.text <> string(lf_fecha_fin) then
	
	em_fecha_final.text = string(lf_fecha_fin)
	
end if

end event

type ddlb_tipo from dropdownlistbox within w_reportes_ventas
boolean visible = false
integer x = 105
integer y = 1000
integer width = 622
integer height = 340
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman Baltic"
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"TODAS","CR - CREDITO","CO - CONTADO","CD - C.O.D."}
end type

event selectionchanged;if dw_1.rowcount() > 0 then
	
	//cb_consultar.Postevent("clicked")
	
end if
end event

type cbx_todos from checkbox within w_reportes_ventas
integer x = 1970
integer y = 572
integer width = 297
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Todos"
boolean checked = true
end type

event clicked;//Valida si esta checked o no y dependiendo de esto, habilita o deshabilita el Drop Down de 
//los clientes

If cbx_todos.Checked = True Then
	ddlb_cliente.enabled = False
Else
	ddlb_cliente.enabled = True	
End If	
end event

type st_3 from statictext within w_reportes_ventas
integer x = 1413
integer y = 244
integer width = 215
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "Hasta:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_reportes_ventas
integer x = 699
integer y = 248
integer width = 201
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "Desde:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_reportes_ventas
integer x = 590
integer y = 580
integer width = 224
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_reportes_ventas
boolean visible = false
integer x = 46
integer y = 920
integer width = 256
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "Facturas:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_informe from dropdownlistbox within w_reportes_ventas
integer x = 1189
integer y = 712
integer width = 645
integer height = 412
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman Baltic"
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
string item[] = {"DETALLADO","RESUMIDO"}
end type

event selectionchanged;parent.setredraw(False)


	ii_ultima_seleccion = index
	ddlb_orden.enabled = True			//Habilita el ordenamiento
	
   Choose Case ddlb_informe.text
		
	   Case "DETALLADO" 	
			if rb_cliente.checked then
				If dw_1.DataObject <> "dw_fa_rep_ventas_cli_new" Then	
					dw_1.DataObject = "dw_fa_rep_ventas_cli_new"
					is_nativo = dw_1.GetSqlSelect()  //Recupera el SQL original del Datawindow de reporte.				
				End If
				
			else
				if str.empresa = 1 and pos(str.empr_acceso_especial, 'GOLD,') > 0 then
					If dw_1.DataObject <> "dw_fa_rep_ventas_fac_new_abajo" Then	
						dw_1.DataObject = "dw_fa_rep_ventas_fac_new_abajo"
					End If
				else
					If dw_1.DataObject <> "dw_fa_rep_ventas_fac_new" Then	
						dw_1.DataObject = "dw_fa_rep_ventas_fac_new"
					End If
				end if
			end if
			is_tipo = "DETALLADO"
   	Case "RESUMIDO"			
			if rb_cliente.checked then
				if cbx_global.checked then
					If dw_1.DataObject <> "dw_fa_rep_ventas_cli_global_pais" Then	
						dw_1.DataObject = "dw_fa_rep_ventas_cli_global_pais"	
						is_nativo = dw_1.GetSqlSelect()  //Recupera el SQL original del Datawindow de reporte.				
					End If		
			   else
					If dw_1.DataObject <> "dw_fa_rep_ventas_cli_res_new" Then	
						dw_1.DataObject = "dw_fa_rep_ventas_cli_res_new"	
						is_nativo = dw_1.GetSqlSelect()  //Recupera el SQL original del Datawindow de reporte.				
					End If			
				End if
			else
				if cbx_vend.checked then
					If dw_1.DataObject <> "dw_reporte_facturas_x_vendedor_resumido" Then	
						dw_1.DataObject = "dw_reporte_facturas_x_vendedor_resumido"	
					End If							
				elseif pos(str.empr_acceso_especial, 'HPSA') > 0 then 
						If dw_1.DataObject <> "dw_facturas_resumidas_hpsa" Then	
							dw_1.DataObject  = "dw_facturas_resumidas_hpsa"	
						End If		
				else
					If str.empresa = 1 and pos(str.empr_acceso_especial, 'GOLD,') > 0 Then 
						If dw_1.DataObject <> "dw_facturas_resumidas" Then	
							dw_1.DataObject = "dw_facturas_resumidas"
						End If
					else
						If dw_1.DataObject <> "dw_fa_rep_ventas_fac_res_new" Then	
							dw_1.DataObject = "dw_fa_rep_ventas_fac_res_new"	
						End If					
					end if								
				end if
			end if
			is_tipo = "RESUMIDO" 
	  Case "GLOBAL"
			if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 then
				If dw_1.DataObject <> "dw_fa_rep_ventas_cli_glo_acisa" Then	
					dw_1.DataObject = "dw_fa_rep_ventas_cli_glo_acisa"	
					is_tipo = "GLOBAL"
					ddlb_orden.enabled = False //Deshabilita el orden, si selecciona global
					is_nativo = dw_1.GetSqlSelect()  //Recupera el SQL original del Datawindow de reporte.				
				End If	
			else
				If dw_1.DataObject <> "dw_fa_rep_ventas_cli_glo_new" Then	
					dw_1.DataObject = "dw_fa_rep_ventas_cli_glo_new"	
					is_tipo = "GLOBAL"
					ddlb_orden.enabled = False //Deshabilita el orden, si selecciona global
					is_nativo = dw_1.GetSqlSelect()  //Recupera el SQL original del Datawindow de reporte.				
				End If	
			end if
	  Case "POR DIVISION"
			if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 then
				If dw_1.DataObject <> "dw_fa_rep_ventas_cli_division_acisa" Then	
					dw_1.DataObject = "dw_fa_rep_ventas_cli_division_acisa"	
					ddlb_orden.enabled = False //Deshabilita el orden, si selecciona por division
					is_tipo = "POR DIVISION"
					is_nativo = dw_1.GetSqlSelect()  //Recupera el SQL original del Datawindow de reporte.				
				End If	
			else
				If dw_1.DataObject <> "dw_fa_rep_ventas_cli_division_new" Then	
					dw_1.DataObject = "dw_fa_rep_ventas_cli_division_new"	
					ddlb_orden.enabled = False //Deshabilita el orden, si selecciona por division
					is_tipo = "POR DIVISION"
					is_nativo = dw_1.GetSqlSelect()  //Recupera el SQL original del Datawindow de reporte.				
				End If	
			end if
	  Case "RESUMIDO POR DIVISION"
			if pos(Upper(str.empr_acceso_especial),'ACISA,') > 0 then
				If dw_1.DataObject <> "dw_fa_rep_ventas_cli_division_res_acisa" Then	
					dw_1.DataObject = "dw_fa_rep_ventas_cli_division_res_acisa"	
					ddlb_orden.enabled = False //Deshabilita el orden, si selecciona resumido por tipo				
					is_tipo = "RESUMIDO POR DIVISION"
					is_nativo = dw_1.GetSqlSelect()  //Recupera el SQL original del Datawindow de reporte.				
				End If			
			else
				If dw_1.DataObject <> "dw_fa_rep_ventas_cli_division_res_new" Then	
					dw_1.DataObject = "dw_fa_rep_ventas_cli_division_res_new"	
					ddlb_orden.enabled = False //Deshabilita el orden, si selecciona resumido por tipo				
					is_tipo = "RESUMIDO POR DIVISION"
					is_nativo = dw_1.GetSqlSelect()  //Recupera el SQL original del Datawindow de reporte.				
				End If
			end if
	End Choose
	
//messagebox("dw_1.dataobject",dw_1.dataobject)	
	
	dw_1.settransobject(sqlca)
	dw_1.object.empresa.expression = "'"+is_empresa+"'"
	


parent.setredraw(True)
end event

type st_5 from statictext within w_reportes_ventas
integer x = 873
integer y = 720
integer width = 279
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "Reporte: "
alignment alignment = right!
boolean focusrectangle = false
end type

type st_6 from statictext within w_reportes_ventas
boolean visible = false
integer x = 2080
integer y = 948
integer width = 398
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
boolean enabled = false
string text = "Ordenado Por:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_orden from dropdownlistbox within w_reportes_ventas
boolean visible = false
integer x = 2135
integer y = 924
integer width = 512
integer height = 224
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman Baltic"
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"FACTURA","FECHA"}
end type

event selectionchanged;str_fa_dw_rep lstr_dw
String ls_ordenar, ls_des

This.SetRedraw(False)

//Describe("DataWindow.Table.Sort")	

If dw_1.RowCount() > 0 Then
  If isnull(index) then index = 1
 
     If ii_ultimo_orden <> index Then	
  
        str.frame.setmicrohelp("Procesando... Por Favor Espere...")
	     ii_ultimo_orden = index	
  
        wf_ocultar_asterisco()	//Desmarca los asteriscos de orden.
  
        Choose Case ddlb_orden.text 
	       case "FACTURA"	
		         ls_ordenar = " fact_cliente A integer(fact_no_factura) "+is_orden+" fact_no_pedido "+is_orden+" fact_ann "+is_orden+" facd_index A"
					
		         dw_1.object.factura.visible = 1
	       Case Else
		         ls_ordenar = " fact_cliente A fact_fecha "+ is_orden+" integer(fact_no_factura) "+is_orden+" fact_no_pedido "+is_orden+" fact_ann "+is_orden+ "facd_index A"
		         dw_1.object.fech.visible = 1
        End Choose

	     dw_1.SetSort(ls_ordenar)
	     dw_1.Sort()
	     dw_1.GroupCalc()		
	 
   End If	
 
 
   lstr_dw.dw = dw_1

End If

This.SetRedraw(True)
end event

type cbx_des from checkbox within w_reportes_ventas
event clicked pbm_bnclicked
string tag = "Para ordenar descendentemente"
boolean visible = false
integer x = 2176
integer y = 952
integer width = 238
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79416533
string text = "Desc."
end type

event clicked;//Setea el tipo de orden, Ascendente o Descendente.

if cbx_des.checked = true then
	is_orden = "D"
else
	is_orden = "A"
end if

ii_ultimo_orden = 20 //Para forzarlo a que entre al ordenamiento

ddlb_orden.Postevent("Selectionchanged")
end event

type ddlb_1 from dropdownlistbox within w_reportes_ventas
boolean visible = false
integer x = 315
integer y = 920
integer width = 526
integer height = 228
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
string item[] = {"IMPRESAS","ACTIVAS"}
borderstyle borderstyle = stylelowered!
end type

type cbx_quitar_desc from checkbox within w_reportes_ventas
boolean visible = false
integer x = 2071
integer y = 1044
integer width = 690
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
string text = "Mostrar descuento ?"
boolean checked = true
end type

type cb_salir from commandbutton within w_reportes_ventas
string tag = "Presione para Consultar"
integer x = 1440
integer y = 872
integer width = 411
integer height = 100
integer taborder = 160
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Cancelar"
boolean default = true
end type

event clicked;close(parent)
end event

type rb_factura from radiobutton within w_reportes_ventas
integer x = 73
integer y = 432
integer width = 453
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = balticcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman Baltic"
long backcolor = 15793151
string text = "Por Facturas"
end type

event clicked;rb_cliente.checked = false
rb_producto.checked = false
cbx_todos.visible = false
rb_div_grupo.checked = false
rb_resumen_pais.checked = false
cbx_global.visible = false

ddlb_cliente.visible = false
st_2.visible = false

if this.checked then
	cbx_todos.enabled = false
	cbx_todos.checked = true
	cbx_vend.visible = true
	cbx_pais.visible = true
	cbx_itbm.visible = true
else
	rb_cliente.checked = true
	cbx_todos.enabled = true
	cbx_vend.visible = false
	cbx_pais.visible = false
	cbx_itbm.visible = false
end if

  Choose Case ddlb_informe.text				
	   Case "DETALLADO" 	
			if rb_factura.checked then
				If dw_1.DataObject <> "dw_fa_rep_ventas_fac_new" Then	
					dw_1.DataObject = "dw_fa_rep_ventas_fac_new"
				End If				
			end if
			is_tipo = "DETALLADO"
   	Case "RESUMIDO"			
			if rb_factura.checked then
				if cbx_vend.checked then
					If dw_1.DataObject <> "dw_reporte_facturas_x_vendedor_resumido" Then	
						dw_1.DataObject = "dw_reporte_facturas_x_vendedor_resumido"	
					End If			
				elseif cbx_pais.checked then
					If dw_1.DataObject <> "dw_facturas_resumidas_hpsa_pais" Then	
						dw_1.DataObject = "dw_facturas_resumidas_hpsa_pais"	
					End If			
				elseif cbx_itbm.checked then
					If dw_1.DataObject <> "dw_facturas_resumidas_itbm" Then	
						dw_1.DataObject = "dw_facturas_resumidas_itbm"	
					End If								
				else
					If str.empresa = 1 and pos(str.empr_acceso_especial, 'GOLD,') > 0 then 
						If dw_1.DataObject <> "dw_facturas_resumidas" Then	
							dw_1.DataObject = "dw_facturas_resumidas"
						End If
					elseif pos(str.empr_acceso_especial, 'HPSA') > 0 then 
						If dw_1.DataObject <> "dw_facturas_resumidas_hpsa" Then	
							dw_1.DataObject  = "dw_facturas_resumidas_hpsa"	
						End If		
					else
						If dw_1.DataObject <> "dw_fa_rep_ventas_fac_res_new" Then	
							dw_1.DataObject  = "dw_fa_rep_ventas_fac_res_new"	
						End If		
					end if
				end if
			end if
			is_tipo = "RESUMIDO" 			
	end choose
	dw_1.settransobject(sqlca)
end event

type rb_cliente from radiobutton within w_reportes_ventas
integer x = 576
integer y = 432
integer width = 471
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = balticcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman Baltic"
long backcolor = 15793151
string text = "Por Clientes"
end type

event clicked;rb_factura.checked = false
rb_producto.checked = false
rb_resumen_pais.checked = false

cbx_vend.visible = false
cbx_pais.visible = false

cbx_todos.visible = true
ddlb_cliente.visible = true
st_2.visible = true
cbx_global.visible = true

if this.checked then
	cbx_todos.enabled = true
else
	rb_factura.checked = true
	cbx_vend.visible = true
	cbx_todos.enabled = false
end if

  Choose Case ddlb_informe.text
		
	   Case "DETALLADO" 	
			if rb_cliente.checked then
				If dw_1.DataObject <> "dw_fa_rep_ventas_cli_new" Then	
					dw_1.DataObject = "dw_fa_rep_ventas_cli_new"
					is_nativo = dw_1.GetSqlSelect()  //Recupera el SQL original del Datawindow de reporte.				
				End If
			end if
			is_tipo = "DETALLADO"
   	Case "RESUMIDO"			
			if rb_cliente.checked then
				If dw_1.DataObject <> "dw_fa_rep_ventas_cli_res_new" Then	
					dw_1.DataObject = "dw_fa_rep_ventas_cli_res_new"	
					is_nativo = dw_1.GetSqlSelect()  //Recupera el SQL original del Datawindow de reporte.				
				End If			
			end if
			is_tipo = "RESUMIDO" 
			
	end choose
	dw_1.settransobject(sqlca)
end event

type cbx_vend from checkbox within w_reportes_ventas
boolean visible = false
integer x = 1938
integer y = 712
integer width = 457
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Por Vendedor"
end type

event clicked;ddlb_informe.text = 'RESUMIDO'
is_tipo = 'RESUMIDO'
cbx_pais.checked = false
cbx_itbm.checked = false
if cbx_vend.checked then
	If dw_1.DataObject <> "dw_reporte_facturas_x_vendedor_resumido" Then	
		dw_1.DataObject = "dw_reporte_facturas_x_vendedor_resumido"	
	End If							
else
	If str.empresa = 1 and pos(str.empr_acceso_especial, 'GOLD,') > 0 then //pos(upper(str.nombre_empresa),'GOLD') > 0 Then 
		If dw_1.DataObject <> "dw_facturas_resumidas" Then	
			dw_1.DataObject = "dw_facturas_resumidas"
		End If
	elseif pos(str.empr_acceso_especial, 'HPSA') > 0 then 
		If dw_1.DataObject <> "dw_facturas_resumidas_hpsa" Then	
			dw_1.DataObject  = "dw_facturas_resumidas_hpsa"	
		End If		
	else
		If dw_1.DataObject <> "dw_fa_rep_ventas_fac_res_new" Then	
			dw_1.DataObject = "dw_fa_rep_ventas_fac_res_new"	
		End If					
	end if
end if
dw_1.settransobject(sqlca)
dw_1.object.empresa.expression = "'"+is_empresa+"'"

end event

type rb_producto from radiobutton within w_reportes_ventas
integer x = 1088
integer y = 432
integer width = 448
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = balticcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman Baltic"
long backcolor = 15793151
string text = "Por Productos"
boolean checked = true
end type

event clicked;rb_factura.checked = false
rb_cliente.checked = false
rb_resumen_pais.checked = false
rb_div_grupo.checked = false
cbx_global.visible = false

cbx_vend.visible = false
cbx_pais.visible = false

cbx_todos.visible = false
ddlb_cliente.visible = false
st_2.visible = false
	
if not this.checked then
	rb_factura.triggerevent('clicked')
end if

end event

type cbx_diario from checkbox within w_reportes_ventas
integer x = 1006
integer y = 100
integer width = 462
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "Diario"
end type

event clicked;if this.checked then
	cbx_mensual.checked = false
	em_fecha_inicial.text = string(ii_dia)+ "/" +string(ii_mes)+ "/" +string(ii_ann)
	em_fecha_final.text = string(ii_dia)+ "/" +string(ii_mes)+ "/" +string(ii_ann)
else
	cbx_mensual.checked = true
	em_fecha_inicial.text = string(01)+ "/" +string(ii_mes)+ "/" +string(ii_ann)
	em_fecha_final.text =  string(gf_last_day(ii_mes,ii_ann))+ "/" +string(ii_mes)+ "/" +string(ii_ann)	
end if
end event

type cbx_mensual from checkbox within w_reportes_ventas
integer x = 1499
integer y = 100
integer width = 462
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12639424
string text = "Mensual"
boolean checked = true
end type

event clicked;if this.checked then
	cbx_diario.checked = false
	em_fecha_inicial.text = string(01)+ "/" +string(ii_mes)+ "/" +string(ii_ann)
	em_fecha_final.text =  string(gf_last_day(ii_mes,ii_ann))+ "/" +string(ii_mes)+ "/" +string(ii_ann)	
else
	cbx_diario.checked = true
	em_fecha_inicial.text = string(ii_dia)+ "/" +string(ii_mes)+ "/" +string(ii_ann)
	em_fecha_final.text = string(ii_dia)+ "/" +string(ii_mes)+ "/" +string(ii_ann)
end if
end event

type calendario from picture within w_reportes_ventas
integer x = 1349
integer y = 236
integer width = 69
integer height = 80
boolean bringtotop = true
string picturename = "C:\Sistemas\Hymsoft\Art\ddfec.bmp"
boolean focusrectangle = false
end type

event clicked;date 	ld_date,ld_ini_date, ld_hoy
//parent.height = 1144
	
	ld_ini_date=date(em_fecha_inicial.text)
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

end event

type calendario2 from picture within w_reportes_ventas
integer x = 2080
integer y = 236
integer width = 69
integer height = 80
boolean bringtotop = true
string picturename = "C:\Sistemas\Hymsoft\Art\ddfec.bmp"
boolean focusrectangle = false
end type

event clicked;date 	ld_date,ld_ini_date, ld_hoy
//parent.height = 1144
	
	ld_ini_date=date(em_fecha_final.text)
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

end event

type uo_1 from u_ddcalen within w_reportes_ventas
boolean visible = false
integer x = 178
integer y = 316
integer taborder = 70
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;em_fecha_inicial.text = string(uo_1.return_sel_date())

if uo_1.allow_close then
	this.visible=false
	em_fecha_inicial.SetFocus()
end if


end event

on uo_1.destroy
call u_ddcalen::destroy
end on

type uo_2 from u_ddcalen within w_reportes_ventas
boolean visible = false
integer x = 910
integer y = 312
integer taborder = 80
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_ddcalen::destroy
end event

event ue_clicked;call super::ue_clicked;em_fecha_final.text = string(uo_2.return_sel_date())

if uo_2.allow_close then
	this.visible=false
	em_fecha_final.SetFocus()
end if


end event

on uo_2.destroy
call u_ddcalen::destroy
end on

type cb_1 from commandbutton within w_reportes_ventas
integer x = 27
integer y = 704
integer width = 110
integer height = 84
integer taborder = 160
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "AC"
end type

event clicked;if str.usuario <> 'SA' then return

String	ls_fec_ini,ls_fec_fin,ls_error
integer  li_formato_decimal_costo
datetime ldt_fecha1, ldt_fecha2
if gf_mensaje('','Está seguro de Actualizar los Costos ?',2,1,'E') = 2 then return

//Formato de costos
li_formato_decimal_costo = 2 

ls_fec_ini = string(date(em_fecha_inicial.text),"mm/dd/yyyy") + ' 00:00:00'
ls_fec_fin = string(date(em_fecha_final.text),"mm/dd/yyyy") + ' 23:59:59'

ldt_fecha1 = datetime(date(em_fecha_inicial.text),time('00:00:00'))
ldt_fecha2 = datetime(date(em_fecha_final.text),time('23:59:59'))
		
		 update  faddiari set facd_costo_cif =   
					convert(numeric(12,2),ROUND((IsNull ( inmprodu.prod_costo_cif,0) / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad,2)) ,   
					facd_costo_fob =   
					convert(numeric(12,2),ROUND((IsNull (inmprodu.prod_costo_fob,0) / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad,2)) ,   			
					faddiari.facd_costo_total = 
					convert(numeric(12,2),convert(numeric(12,2),ROUND((IsNull(inmprodu.prod_costo_cif,0) / inamedid_b.medi_cantidad ) * inamedid_a.medi_cantidad,2)) * (isNull(faddiari.facd_cantidad ,0)+ ( IsNull(faddiari.facd_cantidad_fraccion,0) /   inamedid_a.medi_cantidad )) )  
			 FROM faddiari,   
					fatdiari,   
					inamedid inamedid_a,   
					inamedid inamedid_b,   
					inmprodu  
			WHERE ( faddiari.facd_g_financiero = fatdiari.fact_g_financiero ) and  
					( faddiari.facd_empresa = fatdiari.fact_empresa ) and  
					( faddiari.facd_tipo = fatdiari.fact_tipo ) and  
					( faddiari.facd_no_pedido = fatdiari.fact_no_pedido ) and  
					( faddiari.facd_ann = fatdiari.fact_ann ) and  
					( faddiari.facd_unidad_venta = inamedid_a.medi_medida ) and  
					( inamedid_b.medi_medida = inmprodu.prod_medida ) and  
					( faddiari.facd_codigo_item = inmprodu.prod_producto ) and  
					( faddiari.facd_g_financiero = inmprodu.prod_g_financiero ) and  
					( faddiari.facd_empresa = inmprodu.prod_empresa ) and  
					( ( faddiari.facd_g_financiero = :str.g_financiero ) AND  
					( faddiari.facd_empresa = :str.empresa ) AND  
					( fatdiari.fact_fecha >= :ldt_fecha1 and  fatdiari.fact_fecha <= :ldt_fecha2 ) ) ;
		
									
					If sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrText
						Rollback;
						mensaje("Atención","Error al actualizar el costo del detalle de faddiari ",ls_error)
						return 
					end if
		//Actualiza el costo de la factura
		
	update  fatdiari  set fact_costos_total = 
		( SELECT sum(faddiari.facd_costo_total)   
			 FROM faddiari
			WHERE ( faddiari.facd_g_financiero = fatdiari.fact_g_financiero ) and  
					( faddiari.facd_empresa = fatdiari.fact_empresa ) and  
					( faddiari.facd_tipo = fatdiari.fact_tipo ) and  
					( faddiari.facd_no_pedido = fatdiari.fact_no_pedido ) and  
					( faddiari.facd_ann = fatdiari.fact_ann ) 
		GROUP BY faddiari.facd_g_financiero,   
					faddiari.facd_empresa,   
					faddiari.facd_tipo,   
					faddiari.facd_no_pedido,   
					faddiari.facd_ann)
			WHERE  (fatdiari.fact_g_financiero = :str.g_financiero ) AND  
					 (fatdiari.fact_empresa = :str.empresa ) AND  
					( fatdiari.fact_fecha >= :ldt_fecha1 and fatdiari.fact_fecha <= :ldt_fecha2 ) ;
		
					If sqlca.sqlcode = -1 then
						ls_error = sqlca.sqlerrText
						Rollback;
						mensaje("Atención","Error al actualizar el costo total de la factura fatdiari ",ls_error)
						return 
					end if

mensaje("Atención","Actualización Exitosa de los Costos",'')

return
end event

type cbx_pais from checkbox within w_reportes_ventas
boolean visible = false
integer x = 1943
integer y = 804
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Por País"
end type

event clicked;ddlb_informe.text = 'RESUMIDO'
is_tipo = 'RESUMIDO'
cbx_vend.checked = false
cbx_itbm.checked = false
if cbx_pais.checked then
	If dw_1.DataObject <> "dw_facturas_resumidas_hpsa_pais" Then	
		dw_1.DataObject = "dw_facturas_resumidas_hpsa_pais"	
	End If							
else
	If str.empresa = 1 and pos(str.empr_acceso_especial, 'GOLD,') > 0 then //pos(upper(str.nombre_empresa),'GOLD') > 0 Then 
		If dw_1.DataObject <> "dw_facturas_resumidas" Then	
			dw_1.DataObject = "dw_facturas_resumidas"
		End If
	elseif pos(str.empr_acceso_especial, 'HPSA') > 0 then 
		If dw_1.DataObject <> "dw_facturas_resumidas_hpsa" Then	
			dw_1.DataObject  = "dw_facturas_resumidas_hpsa"	
		End If		
	else
		If dw_1.DataObject <> "dw_fa_rep_ventas_fac_res_new" Then	
			dw_1.DataObject = "dw_fa_rep_ventas_fac_res_new"	
		End If					
	end if
end if
dw_1.settransobject(sqlca)
dw_1.object.empresa.expression = "'"+is_empresa+"'"

end event

type cbx_itbm from checkbox within w_reportes_ventas
boolean visible = false
integer x = 1943
integer y = 896
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "I.T.B.M."
end type

event clicked;ddlb_informe.text = 'RESUMIDO'
is_tipo = 'RESUMIDO'
cbx_vend.checked = false
cbx_pais.checked = false
if cbx_itbm.checked then
	If dw_1.DataObject <> "dw_facturas_resumidas_itbm" Then	
		dw_1.DataObject = "dw_facturas_resumidas_itbm"	
	End If							
else
	If str.empresa = 1 and pos(str.empr_acceso_especial, 'GOLD,') > 0 then //pos(upper(str.nombre_empresa),'GOLD') > 0 Then 
		If dw_1.DataObject <> "dw_facturas_resumidas" Then	
			dw_1.DataObject = "dw_facturas_resumidas"
		End If
	elseif pos(str.empr_acceso_especial, 'HPSA') > 0 then 
		If dw_1.DataObject <> "dw_facturas_resumidas_hpsa" Then	
			dw_1.DataObject  = "dw_facturas_resumidas_hpsa"	
		End If		
	else
		If dw_1.DataObject <> "dw_fa_rep_ventas_fac_res_new" Then	
			dw_1.DataObject = "dw_fa_rep_ventas_fac_res_new"	
		End If					
	end if
end if
dw_1.settransobject(sqlca)
dw_1.object.empresa.expression = "'"+is_empresa+"'"

end event

type rb_resumen_anual from radiobutton within w_reportes_ventas
integer x = 1577
integer y = 432
integer width = 471
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = balticcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman Baltic"
long backcolor = 15793151
string text = "Resumen Anual"
end type

event clicked;rb_factura.checked = false
rb_cliente.checked = false
rb_producto.checked = false

cbx_vend.visible = false
cbx_pais.visible = false

cbx_todos.visible = false
ddlb_cliente.visible = false
st_2.visible = false
	
if not this.checked then
	rb_factura.triggerevent('clicked')
else
	opensheet(w_fa_rep_grafica_ventas_anual, str.frame, 2, Layered!)
end if

end event

type gb_2 from groupbox within w_reportes_ventas
integer x = 686
integer y = 24
integer width = 1568
integer height = 332
integer taborder = 11
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8421376
long backcolor = 12639424
string text = "Rango de Fechas"
end type

type gb_3 from groupbox within w_reportes_ventas
integer x = 18
integer y = 380
integer width = 3145
integer height = 152
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = balticcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman Baltic"
long textcolor = 15793151
long backcolor = 8421376
string text = "Seleccion"
end type

type rb_div_grupo from radiobutton within w_reportes_ventas
integer x = 2094
integer y = 428
integer width = 485
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = balticcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman Baltic"
long backcolor = 15793151
string text = "Division / Grupo"
end type

event clicked;rb_factura.checked = false
rb_cliente.checked = false
rb_producto.checked = false
rb_resumen_anual.checked = false
cbx_global.visible = false

cbx_vend.visible = false
cbx_pais.visible = false

cbx_todos.visible = false
ddlb_cliente.visible = false
st_2.visible = false
str_informe.fecha_inicio = date(em_fecha_inicial.text)
str_informe.fecha_final = date(em_fecha_final.text)
	 
if not this.checked then
	rb_factura.triggerevent('clicked')
else
	OpenSheetWithParm(w_ventas_division_grupo,str_informe, str.frame, 2, Layered!)
end if

end event

type rb_resumen_pais from radiobutton within w_reportes_ventas
integer x = 2615
integer y = 428
integer width = 485
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = balticcharset!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman Baltic"
long backcolor = 15793151
string text = "Resumen Pais"
end type

event clicked;rb_factura.checked = false
rb_cliente.checked = false
rb_producto.checked = false
rb_resumen_anual.checked = false
rb_div_grupo.checked = false
cbx_global.visible = false

cbx_vend.visible = false
cbx_pais.visible = false

cbx_todos.visible = false
ddlb_cliente.visible = false
st_2.visible = false
str_informe.fecha_inicio = date(em_fecha_inicial.text)
str_informe.fecha_final = date(em_fecha_final.text)
	 
if not this.checked then
	rb_factura.triggerevent('clicked')
else
	OpenSheetWithParm(w_ventas_resumen_pais,str_informe, str.frame, 2, Layered!)
end if

end event

type cbx_global from checkbox within w_reportes_ventas
integer x = 1975
integer y = 676
integer width = 402
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Global"
end type

event clicked;if cbx_global.checked then
	If dw_1.DataObject <> "dw_fa_rep_ventas_cli_global_pais" Then	
		dw_1.DataObject = "dw_fa_rep_ventas_cli_global_pais"	
		is_nativo = dw_1.GetSqlSelect()  //Recupera el SQL original del Datawindow de reporte.				
	End If		
else
	If dw_1.DataObject <> "dw_fa_rep_ventas_cli_res_new" Then	
		dw_1.DataObject = "dw_fa_rep_ventas_cli_res_new"	
		is_nativo = dw_1.GetSqlSelect()  //Recupera el SQL original del Datawindow de reporte.				
	End If			
End if
end event

