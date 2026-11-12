//objectcomments Ventana Para que se Calcule el Cubicaje
forward
global type w_fa_man_cubic_packing from Window
end type
type st_nom_ventana from statictext within w_fa_man_cubic_packing
end type
type st_microhelp from statictext within w_fa_man_cubic_packing
end type
type dw_1 from datawindow within w_fa_man_cubic_packing
end type
type st_unidad from statictext within w_fa_man_cubic_packing
end type
type cb_2 from commandbutton within w_fa_man_cubic_packing
end type
type cb_1 from commandbutton within w_fa_man_cubic_packing
end type
type st_4 from statictext within w_fa_man_cubic_packing
end type
type em_4 from editmask within w_fa_man_cubic_packing
end type
type em_3 from editmask within w_fa_man_cubic_packing
end type
type em_2 from editmask within w_fa_man_cubic_packing
end type
type em_1 from editmask within w_fa_man_cubic_packing
end type
type st_3 from statictext within w_fa_man_cubic_packing
end type
type st_2 from statictext within w_fa_man_cubic_packing
end type
type st_1 from statictext within w_fa_man_cubic_packing
end type
type ole_1 from olecontrol within w_fa_man_cubic_packing
end type
type gb_2 from groupbox within w_fa_man_cubic_packing
end type
type gb_1 from groupbox within w_fa_man_cubic_packing
end type
end forward

global type w_fa_man_cubic_packing from Window
int X=823
int Y=360
int Width=1733
int Height=912
boolean TitleBar=true
string Title="(FA) Cubicaje"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
event ue_postopen ( )
st_nom_ventana st_nom_ventana
st_microhelp st_microhelp
dw_1 dw_1
st_unidad st_unidad
cb_2 cb_2
cb_1 cb_1
st_4 st_4
em_4 em_4
em_3 em_3
em_2 em_2
em_1 em_1
st_3 st_3
st_2 st_2
st_1 st_1
ole_1 ole_1
gb_2 gb_2
gb_1 gb_1
end type
global w_fa_man_cubic_packing w_fa_man_cubic_packing

type variables
Window iw_packing
str_fa_cubicaje str_cubicaje
DatawindowChild  idwc_medidas
end variables

forward prototypes
public subroutine wf_calcular ()
public subroutine wf_setear_medida ()
public function double wf_recupera_conver (string as_medida)
end prototypes

event ue_postopen;string ls_unidad_cub

iw_packing   = str.frame.GetActiveSheet()
str_cubicaje = Message.PowerObjectParm
st_nom_ventana.text = this.classname()
em_1.text 		= string(str_cubicaje.largo)
em_2.text 		= string(str_cubicaje.alto)
em_3.text 		= string(str_cubicaje.ancho)
em_4.text 		= string(str_cubicaje.cubicaje)

  SELECT inamedid.medi_descripcion  
    INTO :ls_unidad_cub  
    FROM inamedid  
   WHERE inamedid.medi_medida = :str_cubicaje.unidad_cub   ;
	
			if sqlca.sqlcode = -1 then
			mensaje("Información (ue_postopen)","Error al Seleccionar en inamedid",sqlca.sqlerrtext)
			return 
		end if

st_unidad.text = ls_unidad_cub

wf_setear_medida()


end event

public subroutine wf_calcular ();//Calcula el Cubicaje
String ls_uni_comp, ls_uni_cubi
Double ld_cubicaje, ld_conver_pies_cub, ld_conver_metros_cub, ld_conver_cent_cub

//Unidad de los Compuestos
ls_uni_comp = dw_1.Getitemstring(dw_1.getrow(),"empa_codigo")

//Unidad del Cubicaje
ls_uni_cubi = str_cubicaje.unidad_cub

//Contiene el valor cúbico de la medida seleccionada 
ld_cubicaje = double(em_1.text) * double(em_2.text) * double(em_3.text)

//Si hay algún componente en 0, que retorne y no calcule
if ld_cubicaje = 0 then	return

Choose case ls_uni_comp
	Case	'CM'		/*Centímetros*/
		Choose case ls_uni_cubi
			Case 'P3'	/* a pulgadas 3*/
				ld_conver_cent_cub = wf_recupera_conver("P3")	//Convierte de Pulg3 a Centim.3
				//Divido para encontrar las pulgadas cúbicas
				ld_cubicaje = ld_cubicaje / ld_conver_cent_cub
			Case 'PC'	/*a Pies 3*/
				ld_conver_cent_cub = wf_recupera_conver("P3")	//Convierte de Pulg.3 a Centim.3
				ld_conver_pies_cub   = wf_recupera_conver("PC")	 //Convierte de Pies3 a Pulgada3
				//Divido para sacarlo inversamente
				ld_cubicaje = (ld_cubicaje / ld_conver_cent_cub ) / ld_conver_pies_cub
			Case 'M3'	/* a Metros 3*/
				ld_conver_cent_cub = wf_recupera_conver("P3")	//Convierte de Pulg.3 a Centim.3
				ld_conver_metros_cub = wf_recupera_conver("M3")  //Convierte de Metros3 a Pulg. 3
				//Divido para sacarlo inversamente
				ld_cubicaje = (ld_cubicaje / ld_conver_cent_cub ) / ld_conver_metros_cub
		End choose
	Case	'PG'			/*Pulgadas*/
		Choose case ls_uni_cubi
			Case 'C3'
				ld_conver_cent_cub = wf_recupera_conver("P3")	//Convierte de Pulg3 a Centim.3
				ld_cubicaje = ld_cubicaje * ld_conver_cent_cub
			Case 'PC'	/*a Pies 3*/
				ld_conver_pies_cub   = wf_recupera_conver("PC")	 //Convierte de Pies3 a Pulgada3
				//Divido para encontrar los Pies Cubicos
				ld_cubicaje = ld_cubicaje / ld_conver_pies_cub				
			Case 'M3'	/*a Metros 3*/
				ld_conver_pies_cub   = wf_recupera_conver("PC")	 //Convierte de Pies3 a Pulgada3
				ld_conver_metros_cub = wf_recupera_conver("PU")  //Convierte de Pies3 a Metros3				
				ld_cubicaje = ( (ld_cubicaje / ld_conver_pies_cub ) * ld_conver_metros_cub )
		End choose		
	Case	'PI'		/*Pies*/
		Choose case ls_uni_cubi
			Case 'C3'	/* a Centimetros 3*/
				ld_conver_pies_cub   = wf_recupera_conver("PC")	 //Convierte de Pies3 a Pulgada3
				ld_conver_cent_cub = wf_recupera_conver("P3")	//Convierte de Pulg3 a Centim.3				
				ld_cubicaje = ld_cubicaje * ld_conver_pies_cub * ld_conver_cent_cub
			Case 'P3'	/* a Pulgadas 3*/
				ld_conver_pies_cub   = wf_recupera_conver("PC")	 //Convierte de Pies3 a Pulgada3
				ld_cubicaje = ld_cubicaje * ld_conver_pies_cub
			Case 'M3'	/* a Metros 3*/
				ld_conver_metros_cub = wf_recupera_conver("PU")  //Convierte de Pies3 a Metros3								
				ld_cubicaje = ld_cubicaje * ld_conver_metros_cub
		End choose		
	Case	'MT'		/*Metros*/
		Choose case ls_uni_cubi
			Case 'C3'	/*a Centimetros 3*/
				ld_conver_cent_cub = wf_recupera_conver("P3")	//Convierte de Pulg.3 a Centim.3
				ld_conver_metros_cub = wf_recupera_conver("M3") //Convierte de Metros3 a Pulg. 3
				ld_cubicaje = ld_cubicaje * ld_conver_cent_cub * ld_conver_metros_cub
				
			Case 'P3'	/*a Pulgadas 3*/
				ld_conver_metros_cub = wf_recupera_conver("M3") //Convierte de Metros3 a Pulg. 3
				ld_cubicaje = ld_cubicaje * ld_conver_metros_cub

			Case 'PC'	/*a Pies 3*/
				ld_conver_metros_cub = wf_recupera_conver("PU")  //Convierte de Pies3 a Metros3												
				//Divido para dar lo contrario
				ld_cubicaje = ld_cubicaje / ld_conver_metros_cub
				
		End choose		
End Choose

em_4.text = string(ld_cubicaje)
end subroutine

public subroutine wf_setear_medida ();//Función en la que se carga el DW de Medidas de longitud
string ls_cod, ls_descrip

dw_1.Scrolltorow(dw_1.Insertrow(0))
if str_cubicaje.unidad_comp = '' or isnull(str_cubicaje.unidad_comp) then
	dw_1.SetItem(dw_1.Getrow(),"empa_codigo","PG")
else
	dw_1.SetItem(dw_1.Getrow(),"empa_codigo",str_cubicaje.unidad_comp)
end if

dw_1.GetChild("empa_codigo", idwc_medidas)
idwc_medidas.SetTransObject(sqlca)

 DECLARE cur_medidas CURSOR FOR  
  SELECT inamedid.medi_medida,   
         inamedid.medi_descripcion  
    FROM inamedid  
   WHERE inamedid.medi_tipo_medida = 1   ;		
	
  if sqlca.sqlcode = -1 then
		gf_mensaje("","Error al Declarar el Cursor "+sqlca.sqlerrtext,1,1,"E")
  end if

Open cur_medidas ;

  if sqlca.sqlcode = -1 then
		gf_mensaje("","Error al Abrir el Cursor "+sqlca.sqlerrtext,1,1,"E")
		close cur_medidas ;
		return
  end if


fetch cur_medidas into :ls_cod, :ls_descrip ;
  if sqlca.sqlcode = -1 then
		gf_mensaje("","Error en el Fetch "+sqlca.sqlerrtext,1,1,"E")
		close cur_medidas ;
		return
  end if
  
do while sqlca.sqlcode = 0		
	 idwc_medidas.scrolltorow( idwc_medidas.Insertrow(0))
	
	 idwc_medidas.SetItem( idwc_medidas.Getrow(),"medi_codigo",ls_cod)
	 idwc_medidas.SetItem( idwc_medidas.Getrow(),"medi_descrip",ls_descrip)
		
	fetch cur_medidas into :ls_cod, :ls_descrip ;	
	  if sqlca.sqlcode = -1 then
			gf_mensaje("","Error en el Fetch "+sqlca.sqlerrtext,1,1,"E")
			close cur_medidas ;
			return
	  end if	
loop	

Close cur_medidas ;
end subroutine

public function double wf_recupera_conver (string as_medida);//Función que recupera la cantidad para convertir las unidades
double ld_conver

  SELECT inamedid.medi_cantidad  
	 INTO :ld_conver  
	 FROM inamedid  
	WHERE inamedid.medi_medida = :as_medida   ;

	if sqlca.sqlcode = -1 then
		gf_mensaje("","Error al Seleccionar la Conversion "+sqlca.sqlerrtext,1,1,"E")
	end if

return ld_conver
end function

on w_fa_man_cubic_packing.create
this.st_nom_ventana=create st_nom_ventana
this.st_microhelp=create st_microhelp
this.dw_1=create dw_1
this.st_unidad=create st_unidad
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_4=create st_4
this.em_4=create em_4
this.em_3=create em_3
this.em_2=create em_2
this.em_1=create em_1
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.ole_1=create ole_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.st_nom_ventana,&
this.st_microhelp,&
this.dw_1,&
this.st_unidad,&
this.cb_2,&
this.cb_1,&
this.st_4,&
this.em_4,&
this.em_3,&
this.em_2,&
this.em_1,&
this.st_3,&
this.st_2,&
this.st_1,&
this.ole_1,&
this.gb_2,&
this.gb_1}
end on

on w_fa_man_cubic_packing.destroy
destroy(this.st_nom_ventana)
destroy(this.st_microhelp)
destroy(this.dw_1)
destroy(this.st_unidad)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_4)
destroy(this.em_4)
destroy(this.em_3)
destroy(this.em_2)
destroy(this.em_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ole_1)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;this.Setredraw(false)
dw_1.Settransobject(sqlca)
gf_center_win(this)
this.Postevent("ue_postopen")
this.Setredraw(true)
end event

event key;if Key = KeyEscape! then
	This.postevent("close")
end if
end event

event close;if isvalid(this) then close(this)
end event

type st_nom_ventana from statictext within w_fa_man_cubic_packing
int X=23
int Y=740
int Width=1070
int Height=76
boolean Enabled=false
string Text="none"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_microhelp from statictext within w_fa_man_cubic_packing
int X=46
int Y=568
int Width=361
int Height=68
boolean Visible=false
boolean Enabled=false
boolean Border=true
string Text="Dar Click"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=15793151
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within w_fa_man_cubic_packing
event ue_postitem ( )
event ue_sobre pbm_nchittest
int X=1230
int Y=64
int Width=421
int Height=76
int TabOrder=40
string DataObject="dw_dd_fa_medi_longitud"
BorderStyle BorderStyle=StyleLowered!
end type

event ue_postitem;wf_calcular()
end event

event ue_sobre;//Integer li_pos, li_x, li_y
//String ls_objeto, ls_col
//
//ls_objeto = This.GetObjectAtPointer()
//li_pos = pos  (ls_objeto,"~t")
//ls_col = left (ls_objeto, li_pos - 1)
//
//
////li_x	 = str.frame.GetActiveSheet ().PointerX () - 900
////li_y	 = str.frame.GetActiveSheet ().PointerY () + 30
//
//li_x = 20
//li_y = 80
//
//// Dependiendo de la Columna el Mensaje de Ayuda varía
//CHOOSE CASE ls_col
//	CASE "empa_codigo"
//		If st_microhelp.Visible Then Return
//		st_microhelp.Move (li_x, li_y)
//		st_microhelp.Text 	= "Haga click para Cambiar de Unidad de Medida"
//		st_microhelp.Width 	= Len (st_microhelp.Text) * 28
//		st_microhelp.Visible = TRUE		
//	CASE ELSE
//		st_microhelp.Visible = FALSE
//END CHOOSE
end event

event itemchanged;this.PostEvent("ue_postitem")
end event

event losefocus;st_microhelp.visible = false
end event

type st_unidad from statictext within w_fa_man_cubic_packing
int X=869
int Y=480
int Width=681
int Height=84
boolean Enabled=false
string Text="u. cub."
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=67108864
int TextSize=-9
int Weight=700
string FaceName="Calisto MT"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_fa_man_cubic_packing
int X=873
int Y=600
int Width=279
int Height=92
int TabOrder=60
string Text="Cancelar"
boolean Cancel=true
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_fa_man_cubic_packing
int X=480
int Y=604
int Width=274
int Height=92
int TabOrder=50
string Text="Aceptar"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_unidad_comp

ls_unidad_comp = dw_1.Getitemstring(dw_1.Getrow(),"empa_codigo")

if double(em_1.text) * double(em_2.text) * double(em_3.text) = 0 then
	//Si algun componente está en 0, pregunta si desea continuar o no
	if gf_mensaje("","El Cubicaje No fue Calculado, Algún Componente Está en 0"+"~n ~n ~t"+"      Desea Continuar ?",2,2,"S") = 2 then
		return
	end if
end if

iw_packing.Dynamic wf_setear_cubic(double(em_1.text), double(em_2.text), double(em_3.text), double(em_4.text),ls_unidad_comp)

parent.Post Event Key(KeyEscape!, 0)
end event

type st_4 from statictext within w_fa_man_cubic_packing
int X=535
int Y=392
int Width=343
int Height=76
boolean Enabled=false
string Text="Cubicaje:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-12
int Weight=700
string FaceName="Franklin Gothic Book"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_4 from editmask within w_fa_man_cubic_packing
int X=873
int Y=396
int Width=507
int Height=80
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="##,###,###.########"
boolean DisplayOnly=true
long TextColor=33554432
int TextSize=-9
int Weight=700
string FaceName="Calisto MT"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type em_3 from editmask within w_fa_man_cubic_packing
int X=878
int Y=260
int Width=334
int Height=76
int TabOrder=30
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="##,###.0000"
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Calisto MT"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

event modified;wf_calcular()
end event

type em_2 from editmask within w_fa_man_cubic_packing
int X=878
int Y=164
int Width=334
int Height=76
int TabOrder=20
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="##,###.0000"
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Calisto MT"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

event modified;wf_calcular()
end event

type em_1 from editmask within w_fa_man_cubic_packing
int X=878
int Y=64
int Width=334
int Height=76
int TabOrder=10
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="##,###.0000"
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="Calisto MT"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

event modified;wf_calcular()
end event

type st_3 from statictext within w_fa_man_cubic_packing
int X=571
int Y=64
int Width=279
int Height=76
boolean Enabled=false
string Text="Largo:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-11
int Weight=700
string FaceName="Franklin Gothic Book"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_fa_man_cubic_packing
int X=517
int Y=264
int Width=334
int Height=76
boolean Enabled=false
string Text="Ancho:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-11
int Weight=700
string FaceName="Franklin Gothic Book"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_fa_man_cubic_packing
int X=585
int Y=164
int Width=265
int Height=76
boolean Enabled=false
string Text="Alto:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-11
int Weight=700
string FaceName="Franklin Gothic Book"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ole_1 from olecontrol within w_fa_man_cubic_packing
int X=41
int Y=80
int Width=453
int Height=412
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
omContentsAllowed ContentsAllowed=ContainsAny!
omDisplayType DisplayType=DisplayAsContent!
omLinkUpdateOptions LinkUpdateOptions=LinkUpdateManual!
string BinaryKey="w_fa_man_cubic_packing.win"
end type

type gb_2 from groupbox within w_fa_man_cubic_packing
int X=521
int Y=348
int Width=1120
int Height=224
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Calisto MT"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_fa_man_cubic_packing
int X=9
int Width=1687
int Height=728
string Text="Cubicaje del Producto"
BorderStyle BorderStyle=StyleLowered!
long TextColor=8388608
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

