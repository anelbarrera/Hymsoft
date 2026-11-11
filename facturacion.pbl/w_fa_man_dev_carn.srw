//objectcomments Ventana de aplicacion de Cargos a la Devolucion
forward
global type w_fa_man_dev_carn from w_fa_padre
end type
type gb_2 from groupbox within w_fa_man_dev_carn
end type
type gb_1 from groupbox within w_fa_man_dev_carn
end type
type dw_2 from datawindow within w_fa_man_dev_carn
end type
type cb_1 from commandbutton within w_fa_man_dev_carn
end type
type cb_2 from commandbutton within w_fa_man_dev_carn
end type
type cb_3 from commandbutton within w_fa_man_dev_carn
end type
end forward

global type w_fa_man_dev_carn from w_fa_padre
int X=165
int Y=412
int Width=2651
int Height=1004
WindowType WindowType=response!
boolean TitleBar=true
string Title="(FA) Cargos de la Factura"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event ue_syscommand pbm_syscommand
gb_2 gb_2
gb_1 gb_1
dw_2 dw_2
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
end type
global w_fa_man_dev_carn w_fa_man_dev_carn

type variables
// Nombre de los Campos
String is_ca_cargo ,is_ca_monto,is_ca_ped,is_ca_prede,&
          is_ca_an, is_ca_por_mayor
str_fa_cargo_fac  i_str


end variables

forward prototypes
public subroutine wf_calculos ()
public subroutine wf_carga_inicial ()
public subroutine wf_filtra ()
public subroutine wf_carga ()
public function boolean wf_existe (integer li_codigo)
public subroutine wf_setea_desc (integer codigo, long linea)
public subroutine wf_elimina_descripcion (datawindow adw_1, long linea)
end prototypes

event ue_syscommand;call super::ue_syscommand;if commandtype = 61536 then
	this.triggerevent("close")
end if	
end event

public subroutine wf_calculos ();// Una vez el usuario aplique un cargo
Integer li_cargo,li_boolena
string ls_sobre,ls_cargo
double ld_var,ld_monto

integer recorrido

li_cargo = dw_1.Getitemnumber(dw_1.getrow(),is_ca_cargo)

If dw_1.GetColumnName() = is_ca_cargo Then
	
	  SELECT faacargo.carg_sobre,   
         faacargo.carg_porcentaje,   
         faacargo.carg_variante ,
			faacargo.carg_descripcion
     INTO :ls_sobre,   
          :li_boolena,   
          :ld_var,
			 :ls_cargo
     FROM faacargo  
   WHERE faacargo.carg_cargo = :li_cargo ;
	
		if sqlca.sqlcode = -1 then
			mensaje("Información (wf_calculos)","Error al Seleccionar registros en faacargo",sqlca.sqlerrtext)
			return 
		end if

CHOOSE CASE ls_sobre
	CASE "B" /*Sobre los Bultos*/
		If li_boolena = 1 Then
		   ld_monto = (i_str.monto * (ld_var/100) ) * i_str.bultos
	   Else
			ld_monto = ld_var * i_str.bultos
		End If	
		
	CASE "S"	/*Sobre el subtotal*/
		If li_boolena = 1 Then
		   ld_monto = (i_str.monto * (ld_var/100) )
	   Else
			Messagebox("Advertencia","El Cargo " + ls_cargo +" ~n"  + "Ha sigo mal Configurado"&
			,stopsign!)
		End If	
		
	CASE "F"	/*Es un monto Fijo*/
		ld_monto = ld_var
	
END CHOOSE
	
dw_1.setitem(dw_1.Getrow(),is_ca_monto,ld_monto)	
wf_carga_gf_emp("dcar")		//Carga el grupo financiero y la empresa
dw_1.setitem(dw_1.getrow(),is_ca_por_mayor,i_str.tipo)
dw_1.setitem(dw_1.Getrow(),is_ca_ped,i_str.pedido)
dw_1.setitem(dw_1.getrow(),is_ca_an,i_str.an)

End If
end subroutine

public subroutine wf_carga_inicial ();// Una vez que el usuario aplique un cargo
Integer li_cargo,li_boolena
string ls_sobre,ls_cargo
double ld_var,ld_monto

	 DECLARE CARGOS CURSOR FOR
	  SELECT faacargo.carg_sobre,   
	         faacargo.carg_porcentaje,   
   	      faacargo.carg_variante ,
				faacargo.carg_descripcion,
				faacargo.carg_cargo
      FROM  faacargo
     WHERE  faacargo.carg_prede = 1 ;
	
 OPEN CARGOS;
 
 FETCH CARGOS INTO :ls_sobre,:li_boolena,:ld_var,:ls_cargo,:li_cargo;
 
 IF SQLCA.SQLCODE = -1 OR SQLCA.SQLCODE = 100 THEN
	
	MESSAGEBOX("ERROR","ERROR")
	CLOSE CARGOS;
	COMMIT;
	RETURN

 END IF	
 
 DO WHILE SQLCA.SQLCODE = 0

dw.scrolltorow(dw.insertrow(0))
dw.setcolumn(1)

  CHOOSE CASE ls_sobre
	CASE "B" /*Sobre los Bultos*/
		If li_boolena = 1 Then
		   ld_monto = (i_str.monto * (ld_var/100) ) * i_str.bultos
	   
	   Else
			ld_monto = ld_var * i_str.bultos
		End If	
		
	 CASE "S"	/*Sobre el subtotal*/
		If li_boolena = 1 Then
		   ld_monto = (i_str.monto * (ld_var/100) )
	   
	   Else
			Messagebox("Advertencia","El Cargo " + ls_cargo +" ~n"  + "Ha sigo mal Configuraco"&
			,stopsign!)
		End If	
		
		
	CASE "F"	/*Es un monto Fijo*/
		ld_monto = ld_var
	
END CHOOSE
	
    dw_1.setitem(dw_1.Getrow(),is_ca_monto,ld_monto)
    dw_1.setitem(dw_1.Getrow(),is_ca_cargo,li_cargo)
	 wf_carga_gf_emp("dcar")  // Carga el grupo financiero y la empresa
	 dw.setitem(dw.getrow(),is_ca_por_mayor,i_str.tipo)
	 dw_1.setitem(dw_1.Getrow(),is_ca_ped,i_str.pedido)
	 dw_1.setitem(dw_1.getrow(),is_ca_an,i_str.an)
	 dw.setitem(dw.Getrow(),"carg_descripcion",ls_cargo)

	 FETCH CARGOS INTO :ls_sobre,:li_boolena,:ld_var,:ls_cargo,:li_cargo;
	 
 LOOP
CLOSE CARGOS;

dw_1.Update()

dw_1.Retrieve(str.g_financiero,str.empresa,i_str.pedido,i_str.an,i_str.tipo)

end subroutine

public subroutine wf_filtra ();//Filtra para que los cargos no aparezcan en el DW - 2
Integer li_cont,li_re
String ls_cadena,ls_campo

ls_campo = "dcar_codigo"

FOR li_cont =1 TO dw_1.rowcount() 
	If li_cont = 1 Then
		ls_cadena = ls_campo + "<>" +string(dw_1.getitemnumber(li_cont,is_ca_cargo))
		//Inserta la descripcion en caso de que se haya modificado
		wf_setea_desc(dw_1.getitemnumber(li_cont,is_ca_cargo), li_cont)
	Else
		ls_cadena = ls_cadena + " And " + ls_campo + "<>" +string(dw_1.getitemnumber(li_cont,is_ca_cargo))
		//Inserta la descripcion en caso de que se haya modificado
		wf_setea_desc(dw_1.getitemnumber(li_cont,is_ca_cargo), li_cont)
	End If
NEXT

//Para que no se confirmen los seteos de las descripciones cambiadas.
dw_1.ResetUpdate()

dw_2.Setfilter(ls_cadena)
dw_2.Filter()
end subroutine

public subroutine wf_carga ();// Una vez el usuario aplique un cargo
Integer li_cargo,li_boolena
string ls_sobre,ls_cargo
double ld_var,ld_monto

dw = dw_2

DECLARE CARGOS CURSOR FOR
	  SELECT faacargo.carg_sobre,
	         faacargo.carg_porcentaje,   
   	      faacargo.carg_variante,
				faacargo.carg_descripcion,
				faacargo.carg_cargo
     FROM faacargo ;
	
 OPEN CARGOS;
 
 FETCH CARGOS INTO :ls_sobre,:li_boolena,:ld_var,:ls_cargo,:li_cargo;
 IF SQLCA.SQLCODE = -1 OR SQLCA.SQLCODE = 100 THEN 
	MESSAGEBOX("ERROR","ERROR")
	CLOSE CARGOS;
	COMMIT;
	RETURN

 END IF	
 
 DO WHILE SQLCA.SQLCODE = 0

 dw.scrolltorow(dw.insertrow(0))
 dw.setcolumn(1)

  CHOOSE CASE ls_sobre
	CASE "B" /*Sobre los Bultos*/
		If li_boolena = 1 Then
		   ld_monto = (i_str.monto * (ld_var/100) ) * i_str.bultos
	   
	   Else
			ld_monto = ld_var * i_str.bultos
		End If	
		
	 CASE "S"	/*Sobre el subtotal*/
		If li_boolena = 1 Then
		   ld_monto = (i_str.monto * (ld_var/100) )
	   
	   Else
			Messagebox("Advertencia","El Cargo " + ls_cargo +" ~n"  + "Ha sigo mal Configurado"&
			,stopsign!)
		End If			
		
	CASE "F"	/*Es un monto Fijo*/
		ld_monto = ld_var
	
END CHOOSE
    dw.setitem(dw.Getrow(),is_ca_monto,ld_monto)	
    dw.setitem(dw.Getrow(),is_ca_cargo,li_cargo)
	 wf_carga_gf_emp("dcar")  // Carga el grupo financiero y la empresa
	 dw.setitem(dw.Getrow(),is_ca_ped,i_str.pedido)
	 dw.setitem(dw.getrow(),is_ca_por_mayor,i_str.tipo)
	 dw.setitem(dw.getrow(),is_ca_an,i_str.an)	 
	 dw.setitem(dw.Getrow(),"carg_descripcion",ls_cargo)
	 FETCH CARGOS INTO :ls_sobre,:li_boolena,:ld_var,:ls_cargo,:li_cargo;
 LOOP
CLOSE CARGOS;

dw = dw_1
wf_filtra()
end subroutine

public function boolean wf_existe (integer li_codigo);//Verifica si existe o no la descripción del cargo en la tabla de descripciones

integer li_existe = 0

  SELECT count(*)  
    INTO :li_existe  
    FROM fadcardes  
   WHERE ( fadcardes.card_g_financiero = :str.g_financiero ) AND  
         ( fadcardes.card_empresa = :str.empresa ) AND  
         ( fadcardes.card_por_mayor = :i_str.tipo ) AND  
         ( fadcardes.card_no_pedido = :i_str.pedido ) AND  
         ( fadcardes.card_ann = :i_str.an ) AND  
         ( fadcardes.card_codigo = :li_codigo )   ;
			
		if sqlca.sqlcode = -1 then
			mensaje("Información (wf_existe)","Error al Seleccionar en fadcardes",sqlca.sqlerrtext)
			return false
		end if

	if li_existe > 0 then
		return(true)		
	end if

return(false)
end function

public subroutine wf_setea_desc (integer codigo, long linea);//Función que setea la descripcion del cargo, si fue modificada
string ls_descrip

  SELECT fadcardes.card_descripcion
    INTO :ls_descrip
    FROM fadcardes  
   WHERE ( fadcardes.card_g_financiero = :str.g_financiero ) AND  
         ( fadcardes.card_empresa = :str.empresa ) AND  
         ( fadcardes.card_tipo = :i_str.tipo ) AND  
         ( fadcardes.card_no_pedido = :i_str.pedido ) AND  
         ( fadcardes.card_ann = :i_str.an ) AND  
         ( fadcardes.card_codigo = :codigo )   ;
			
		if sqlca.sqlcode = -1 then
			mensaje("Información (wf_setea_desc)","Error al Seleccionar la descripción en fadcardes",sqlca.sqlerrtext)
			return 
		end if

	if ls_descrip <> "" and not isnull(ls_descrip) then
		dw_1.setitem(linea, "carg_descripcion",ls_descrip)
		dw_1.Setitem(linea, "modificada", 1)
	end if
end subroutine

public subroutine wf_elimina_descripcion (datawindow adw_1, long linea);//Función que elimina la descripcion de la tabla, si es tipo modificada
integer li_modifico, li_codigo

li_modifico = adw_1.Getitemnumber(linea, "modificada")
li_codigo   = adw_1.GetItemnumber(linea,"dcar_codigo")

if li_modifico = 1 then
	DELETE FROM fadcardes  
   WHERE ( fadcardes.card_g_financiero = :str.g_financiero ) AND  
         ( fadcardes.card_empresa = :str.empresa ) AND  
         ( fadcardes.card_tipo = :i_str.tipo ) AND  
         ( fadcardes.card_no_pedido = :i_str.pedido ) AND  
         ( fadcardes.card_ann = :i_str.an ) AND  
         ( fadcardes.card_codigo = :li_codigo )   ;
end if	

if sqlca.sqlcode = -1 then
	messagebox("ATENCIÓN SR. USUARIO","Error al intentar eliminar el cargo "+sqlca.sqlerrtext ,Exclamation!)
end if	
end subroutine

on w_fa_man_dev_carn.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_2=create dw_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_3
end on

on w_fa_man_dev_carn.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event ue_post_open;dw_2.settransobject(sqlca)

//Código extraido del padre
st_nom_ventana.text = this.classname()
THIS.postevent("ue_hay_data")

// Recibe los valores de la Proforma
i_str = Message.PowerObjectParm

// Asignación de nombres de los campos
is_ca_cargo 	= "dcar_codigo"
is_ca_monto 	= "dcar_monto"
is_ca_ped  		= "dcar_no_pedido"
is_ca_an			= "dcar_ann"
is_ca_por_mayor= "dcar_tipo"
is_ca_prede 	= "carg_prede"

//DW_1.GetChild (is_ca_cargo,dch_cargos)
//dch_cargos.settransobject(sqlca)
//dch_cargos.retrieve()
//dch_cargos.SetFilter("faacargo_carg_prede <> 1")
//dch_cargos.Filter()

dw.settransobject(sqlca)
dw_1.Retrieve(str.g_financiero,str.empresa,i_str.pedido,i_str.an,i_str.tipo)
dw_1.Setfocus()
end event

event ue_hay_data;//no quitar
end event

event close;call super::close;double ld_gastos
if dw_1.rowcount() > 0 then
	ld_gastos = dw_1.getitemnumber(1,"suma")
	IF ISNULL(ld_gastos)  then ld_gastos = 0
	Beep(1)
	w_fa_man_devolucion.wf_cargos(dw_1.getitemnumber(1,"suma"))
else
	w_fa_man_devolucion.wf_cargos(0)
end if
close (this)
//Llamado a la función de la ventana de proforma, que asigna el total de cargos a la variable
//de total de cargos del encabezado
end event

event ue_adicionar;//dw_1.object.prca_codigo_cargo.protect = 0

long li_contadas
  SELECT count(*)  
    INTO :li_contadas  
    FROM faacargo using sqlca ;
	 
		if sqlca.sqlcode = -1 then
			mensaje("Información (ue_adicionar)","Error al Seleccionar en faacargo",sqlca.sqlerrtext)
			return 
		end if 

if DW_1.rowcount() < li_contadas then
dw.scrolltorow(dw.insertrow(0))
dw.setcolumn(1)
wf_filtra()
else
	Messagebox("Alto","No existen mas Cargos",stopsign!)
	return
end if	



end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_man_dev_carn
int X=23
int Y=832
int Width=1143
int Height=68
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_man_dev_carn
event ue_post_channged ( )
event ue_escape pbm_dwescape
event ue_enter pbm_dwnprocessenter
int X=1477
int Y=52
int Width=1115
int Height=740
int TabOrder=20
string DataObject="dw_ma_fa_carfactura"
boolean VScrollBar=true
end type

event dw_1::ue_escape;call super::ue_escape;parent.Postevent("close")
end event

event dw_1::ue_enter;call super::ue_enter;//Para que se dispare el evento clicked del boton asignar
cb_2.postevent("clicked")
end event

event dw_1::itemchanged;call super::itemchanged;This.postevent("ue_post_channged")
end event

event dw_1::retrieveend;If rowcount = 0 Then
  wf_carga_inicial()
else
  dw_2.reset() 	
  wf_carga()		//Carga el datawindow 2 y manda a filtrar por lo que este en el DW 1
End If

//Si el estado de la factura es eliminada o (impresa y no se puede modificar), habilita o 
//deshabilita el DW

if i_str.estado = "E" or (i_str.estado = "I" and w_fa_fondo.str_para.modi_fac = 0 )then
	this.enabled = false
	dw_2.enabled = false
	cb_1.enabled = false
	cb_2.enabled = false
	cb_3.enabled = false	
else
	this.enabled = true
	dw_2.enabled = true
	cb_1.enabled = true
	cb_2.enabled = true
	cb_3.enabled = true	
end if
end event

event dw_1::doubleclicked;call super::doubleclicked;//Para que se dispare el evento clicked del boton asignar
cb_2.postevent("clicked")
end event

event dw_1::editchanged;call super::editchanged;string ls_col, ls_original, ls_descrip, ls_descrip2, ls_descripcion
integer li_modifico

this.accepttext()

ls_col = this.Getcolumnname()

choose case ls_col
	case	 "carg_descripcion"  
		ls_original = this.Getitemstring(this.getrow(),"desc_original")
		ls_descrip  = this.Getitemstring(this.getrow(),"carg_descripcion")
		
		if ls_descrip <> ls_original then
			this.setitem(this.getrow(),"modificada",1)
		else
			wf_elimina_descripcion(this, row) //Elimina la descripcion de la tabla
			this.setitem(this.getrow(),"modificada",0)			
		end if

	case  "descrip"
		ls_original = this.Getitemstring(this.getrow(),"desc_original")
		ls_descrip  = this.Getitemstring(this.getrow(),"carg_descripcion")
		
		if ls_descrip <> ls_original then
			this.setitem(this.getrow(),"modificada",1)
		else
			wf_elimina_descripcion(this, row) //Elimina la descripcion de la tabla			
			this.setitem(this.getrow(),"modificada",0)			
		end if
end choose
end event

event dw_1::updatestart;//Para verificar y grabar cuales fueron las descripciones Que se modificaron.
integer li_recorrido, li_modifico, li_codigo
string ls_original, ls_descrip

for li_recorrido = 1 to dw_1.rowcount()
	li_modifico = this.Getitemnumber(li_recorrido,"modificada")
 if li_modifico = 1 then //Si la descripción fue modificada.
 
		ls_descrip  = this.Getitemstring(li_recorrido,"carg_descripcion")
		li_codigo   = this.GetItemnumber(li_recorrido,"dcar_codigo")
		
  if wf_existe(li_codigo) then	//Valida si existe el registro.
  UPDATE fadcardes
     SET card_descripcion = :ls_descrip  
   WHERE ( fadcardes.card_g_financiero = :str.g_financiero ) AND  
         ( fadcardes.card_empresa = :str.empresa ) AND  
         ( fadcardes.card_tipo = :i_str.tipo ) AND  
         ( fadcardes.card_no_pedido = :i_str.pedido ) AND  
         ( fadcardes.card_ann = :i_str.an ) AND  
         ( fadcardes.card_codigo = :li_codigo )   ;
			
	if sqlca.sqlcode = -1 then		  
		messagebox("ATENCIÓN SR. USUARIO","Error al Actualizar "+ sqlca.sqlerrtext)
	end if		
  else
	
	 INSERT INTO fadcardes  
         ( card_g_financiero,   
           card_empresa,   
           card_tipo,   
           card_no_pedido,   
           card_ann,   
           card_codigo,   
           card_descripcion )  
	 VALUES ( :str.g_financiero,   
           :str.empresa,   
           :i_str.tipo,   
           :i_str.pedido,   
           :i_str.an,   
           :li_codigo,   
           :ls_descrip )  ;	
			  
		if sqlca.sqlcode = -1 then		  
			messagebox("ATENCIÓN SR. USUARIO","Error al insertar "+ sqlca.sqlerrtext)
		end if
	end if
		
  end if
end for
end event

type st_ayuda from w_fa_padre`st_ayuda within w_fa_man_dev_carn
boolean BringToTop=true
end type

type gb_2 from groupbox within w_fa_man_dev_carn
int Width=1097
int Height=812
int TabOrder=10
string Text="Cargos no Aplicados"
long TextColor=255
long BackColor=79416533
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_fa_man_dev_carn
int X=1454
int Width=1157
int Height=816
int TabOrder=60
string Text="Aplicados"
long TextColor=32768
long BackColor=79416533
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_2 from datawindow within w_fa_man_dev_carn
event ue_escape pbm_dwescape
event ue_enter pbm_dwnprocessenter
int X=18
int Y=56
int Width=1065
int Height=732
int TabOrder=50
boolean BringToTop=true
string DataObject="dw_ma_fa_carfac_plan"
boolean Border=false
boolean HScrollBar=true
boolean LiveScroll=true
end type

event ue_escape;parent.Postevent("close")
end event

event ue_enter;//Para que se dispare el evento clicked del boton asignar
cb_1.postevent("clicked")
end event

event itemchanged;//parent.trigger event ue_syscommand(61536, 0 ,0)
parent.triggerevent("close")
end event

event doubleclicked;//Para que se dispare el evento clicked del boton asignar
cb_1.postevent("clicked")
end event

type cb_1 from commandbutton within w_fa_man_dev_carn
int X=1120
int Y=196
int Width=315
int Height=108
int TabOrder=40
boolean BringToTop=true
string Text="Aplicar >>"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//dw_2.object.data = dw_1.object.data.selected
dw_2.Rowsmove(dw_2.GetRow(),  dw_2.GetRow(), Primary!, dw_1, 1, Primary!)
dw_1.setfocus()
end event

type cb_2 from commandbutton within w_fa_man_dev_carn
event clicked pbm_bnclicked
int X=1120
int Y=336
int Width=315
int Height=108
int TabOrder=30
boolean BringToTop=true
string Text="<< Liberar"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// Libera un cargo siempre y cuando no sea fijo
Integer li_default,li_linea
 
li_linea = dw_1.Getrow()

If li_linea = 0  Then li_linea = 1 

// Valida si no existe error de línea
If dw_1.Rowcount() >= li_linea Then

// li_default = dw_1.getitemnumber(li_linea,is_ca_prede)

// If li_default  = 0  Then
// Lo quite para que pueda modificar el cargo predeterminado.
	wf_elimina_descripcion(dw_1, li_linea)

	dw_1.Rowscopy(li_linea,  li_linea, Primary!, dw_2, 1, Primary!)
	dw_1.deleterow(li_linea)
	
	commit;

//End If
End If

dw_1.setfocus()
end event

type cb_3 from commandbutton within w_fa_man_dev_carn
int X=1120
int Y=476
int Width=315
int Height=108
int TabOrder=23
boolean BringToTop=true
string Text="Reaplicar"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;  DELETE FROM fadcargo
   WHERE ( fadcargo.dcar_g_financiero = :str.g_financiero ) AND  
         ( fadcargo.dcar_empresa = :str.empresa ) AND  
      	( fadcargo.dcar_tipo = :i_str.tipo ) AND
			( fadcargo.dcar_no_pedido = :i_str.pedido ) AND
			( fadcargo.dcar_ann		  = :i_str.an );
			
		if sqlca.sqlcode = -1 then
			mensaje("Información(clicked)","Error al Eliminar en fadcargo",sqlca.sqlerrtext)
			return 
		end if		
			
dw_1.reset()
//wf_carga_inicial()
dw_1.setfocus()
end event

