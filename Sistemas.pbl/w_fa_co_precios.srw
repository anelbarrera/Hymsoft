//objectcomments Muestra los Precios del Artículo
forward
global type w_fa_co_precios from Window
end type
type st_1 from statictext within w_fa_co_precios
end type
type lv_1 from listview within w_fa_co_precios
end type
end forward

global type w_fa_co_precios from Window
int X=832
int Y=360
int Width=814
int Height=728
boolean TitleBar=true
string Title="(FA) Precios"
string Tag="Muestra los precios de el articulo"
long BackColor=79416533
boolean ControlMenu=true
WindowType WindowType=response!
string Icon="\Art\MINUS.ico"
event ue_post_open ( )
event ue_carga ( )
st_1 st_1
lv_1 lv_1
end type
global w_fa_co_precios w_fa_co_precios

type variables
str_fa_precio istr_p
DataStore		ids_Products
end variables

event ue_post_open;SetPointer(Hourglass!)

// Using a datastore to retrieve data from the database
ids_Products = Create DataStore
ids_Products.DataObject = "dw_dd_precios"

// Set the large and small picture sizes
lv_1.LargePictureWidth = 38
lv_1.LargePictureHeight = 38
lv_1.SmallPictureWidth = 14
lv_1.SmallPictureHeight = 14

// Add Columns used in the listview
lv_1.AddColumn("Precio", Left!, 400)
lv_1.AddColumn("Tipo de Precio",left!, 375)

this.triggerevent("ue_carga")

end event

event ue_carga;// Nota: Es Necesario Trabajar con 12 Decimales al Momento de la Transformacion ya 
// que de lo contrario se Perdera dinero y existira inconsistencia de la Información

nvo_facturacion ov
Integer li_cnt,li_Rows
ListViewItem	llvi_Item
Double ld_mayor,ld_menor,ld_afiliado,ld_especial,ld_otro,ld_anterior,ld_mconver,&
       ld_mconvera/*Factor de convercion del precio Actual*/,ld_mconverb/*Factor de Con Del Nuevo Precio*/
String ls_ua /*Unidad anterior*/,ls_un /*Nueva Unidad*/,ls_item,ls_ruc,ls_medida,ls_enlace,ls_titulo, &
		 ls_mconver, ls_retorno, ls_uni_precio_anterior
Long   ll_ucom

SetPointer(Hourglass!)
// Baja Los Datos de la Estructura
ov  =  Create  nvo_facturacion

ls_item = istr_p.item
ll_ucom = istr_p.ucom
ls_ua   = istr_p.uni
ls_un   = istr_p.uni_selec
ls_ruc  = istr_p.ruc

// Limpia el ListView
// Retrieve data into the datastore
lv_1.DeleteItems()
ids_Products.SetTransObject(sqlca)

li_Rows = ids_Products.Retrieve(str.g_financiero,str.empresa,ls_item)

If li_Rows < 0 Then 
	MessageBox("Error","El Código de Producto No Se Cargo")
	this.Triggerevent("close")
Else
	
	ld_mayor 	=    Double(ids_Products.Object.prod_precio_mayor[1])
	ld_menor 	=    Double(ids_Products.Object.prod_precio_menor[1])
	ld_afiliado = 	  Double(ids_Products.Object.prod_precio_afiliadas[1])
	ld_especial =    Double(ids_Products.Object.prod_precio_especial[1])
	ld_otro  	=    Double(ids_Products.Object.prod_precio_otros[1])
	ls_retorno 	=    ov.precio_ante(ls_item,ls_ruc)
	
	ld_anterior = double(left(ls_retorno,pos(ls_retorno,"*") - 1))
	//messagebox("Precio Anterior", ld_anterior)	
	
	ls_uni_precio_anterior = mid(ls_retorno, pos(ls_retorno,"*") + 1)
//	messagebox("Unidad del Precio Anterior",ls_uni_precio_anterior)
  
	
//* Carga Los Datos de Converción de la Unidad Actual

 SELECT inamedid.medi_cantidad
 INTO		:ld_mconvera
 FROM  inamedid  
 WHERE inamedid.medi_tipo_medida = :ll_ucom and
       inamedid.medi_medida = :ls_ua;
		 
//* Carga Los Datos de Converción de la Unidad Nueva		 
SELECT inamedid.medi_cantidad
 INTO	 :ld_mconverb
 FROM  inamedid  
 WHERE inamedid.medi_tipo_medida = :ll_ucom and
       inamedid.medi_medida = :ls_un;


// **Carga los Datos en el listview**
For li_Cnt = 1 To 6
	
	
	CHOOSE CASE li_cnt
			
		// Precio Mayor	
	   CASE 1
			ls_titulo = "Precio Mayor"
			ld_mconver = ld_mayor
			
		// Precio Menor	
		CASE 2
			ls_titulo = "Precio Menor"
			ld_mconver = ld_menor
			
		// Precio Afiliados	
		CASE 3
			ls_titulo = "Precio Afiliados"
			ld_mconver = ld_afiliado
			
		// Precio Especial	
		CASE 4	
			ls_titulo = "Precio Especial"
			ld_mconver = ld_especial
			
		// Otros
		CASE 5
			ls_titulo = "Otros"
			ld_mconver = ld_otro
			
   	   // Precio Anterior	
		CASE 6
			ls_titulo = "Precio Anterior"
 		   ld_mconver = ld_anterior
			 
	 //Selecciona el valor de transformacion, segun la unidad de medida del precio anterior
			 SELECT inamedid.medi_cantidad
			 INTO		:ld_mconvera
			 FROM  inamedid  
			 WHERE inamedid.medi_tipo_medida = :ll_ucom and
					 inamedid.medi_medida = :ls_uni_precio_anterior;
					 
					 if sqlca.sqlcode = -1 then
						mensaje("Aviso","Error al Seleccionar el Valor de Conversión de la Unidad de Medida",sqlca.sqlerrtext)
					 end if
 		    
END CHOOSE

If ld_mconver > 0 Then 
	
 // Sección que Tranforma los Montos
 	  if ld_mconvera = 0 then
		
			ld_mconvera = 1
		
	  end if	
 
	 ld_mconver = (ld_mconver/ld_mconvera) * ld_mconverb	  

	  if w_fa_fondo.str_para.precio_clave = "S" then
			ls_mconver = gf_clave_precios(ld_mconver) //Pone en Clave el Precio
 	  else
	  		ls_mconver = string(ld_mconver,"###,###,###,##0.00")
	  end if
	  
		//Inclui la tercera columna para extraer el precio, ya que cuando era en clave no lo recuperaba
		llvi_Item.Label = ls_mconver + "~t" + ls_titulo + "~t" + string(ld_mconver,"###,###,###,##0.00")
	   lv_1.AddItem(llvi_Item)
	  
 End If	
 
Next	
// Destuye el uo
Destroy ov 
	  
	  		
End If			
//* Fin Del proceso

end event

on w_fa_co_precios.create
this.st_1=create st_1
this.lv_1=create lv_1
this.Control[]={this.st_1,&
this.lv_1}
end on

on w_fa_co_precios.destroy
destroy(this.st_1)
destroy(this.lv_1)
end on

event open;
istr_p = Message.PowerObjectParm

Post Event ue_post_open()
end event

event closequery;Destroy ids_Products
end event

type st_1 from statictext within w_fa_co_precios
int X=14
int Y=564
int Width=434
int Height=76
boolean Enabled=false
string Text="w_fa_co_precios"
boolean FocusRectangle=false
long BackColor=79416533
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type lv_1 from listview within w_fa_co_precios
int X=5
int Width=795
int Height=540
int TabOrder=1
string Tag="Ventana que muestra la lista de los precios"
BorderStyle BorderStyle=StyleLowered!
ListViewView View=ListViewReport!
int LargePictureWidth=32
int LargePictureHeight=32
long LargePictureMaskColor=553648127
int SmallPictureWidth=16
int SmallPictureHeight=16
long SmallPictureMaskColor=553648127
long StatePictureMaskColor=553648127
long TextColor=8388608
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event doubleclicked;//messagebox("doble c","")

String			ls_ID
Double ld_precio
GetItem(Selectedindex(),3, ls_ID)
//messagebox("doble c",ls_id)

If Trim(ls_ID) <> "" Then
	
	ld_precio = Double(ls_ID)
	
	CloseWithReturn(parent, ld_precio)
	
//	messagebox("row",string(ids_Products.getrow()))
//	messagebox("",string(index))
// messagebox("llvi_Item.Label",string(ls_ID))

End if





end event

event key;
if key = KeyEnter!   then 

this.Triggerevent(doubleclicked!)

End if
end event

