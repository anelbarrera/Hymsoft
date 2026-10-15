//objectcomments Consulta  y Busqueda Rapida de Clientes o Terceros
forward
global type w_fa_co_clien from w_fa_padre
end type
type gb_2 from groupbox within w_fa_co_clien
end type
type gb_1 from groupbox within w_fa_co_clien
end type
type rb_1 from radiobutton within w_fa_co_clien
end type
type rb_2 from radiobutton within w_fa_co_clien
end type
type rb_3 from radiobutton within w_fa_co_clien
end type
type dw_2 from datawindow within w_fa_co_clien
end type
end forward

global type w_fa_co_clien from w_fa_padre
int Width=2245
int Height=1056
WindowType WindowType=response!
boolean TitleBar=true
string Title="(FA) Consulta de Clientes Crédito"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
gb_2 gb_2
gb_1 gb_1
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
dw_2 dw_2
end type
global w_fa_co_clien w_fa_co_clien

on w_fa_co_clien.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.rb_1
this.Control[iCurrent+4]=this.rb_2
this.Control[iCurrent+5]=this.rb_3
this.Control[iCurrent+6]=this.dw_2
end on

on w_fa_co_clien.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.dw_2)
end on

event open;long ll_recupero

gf_center_win(This)
gf_acelerador()

dw = dw_1

This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)
str.frame.SetRedraw ( True )

dw_1.SetTransObject (SQLCA)

  SELECT count(*)  
    INTO :ll_recupero  
    FROM ccmclien,   
         dgmterce  
   WHERE ( ( ccmclien.clie_g_financiero = :str.g_financiero ) AND  
         ( ccmclien.clie_empresa = :str.empresa ) )   ;
			
		if sqlca.sqlcode = -1 then
			mensaje("Información 1","Error al Seleccionar el count en la tabla ccmclien",sqlca.sqlerrtext)
			return
		end if				


		if ll_recupero > 0 then
			dw_1.Retrieve(str.g_financiero, str.empresa)
		else
			dw_1.insertrow(0)
		end if

dw_2.insertrow(0)

st_nom_ventana.text = this.classname()

dw_2.Setfocus()

end event

event resize;//
end event

event close;//override
end event

event key;//Override
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_fa_co_clien
int X=55
int Y=888
int Width=951
end type

type dw_1 from w_fa_padre`dw_1 within w_fa_co_clien
int X=41
int Y=48
int Width=2117
int TabOrder=50
string DataObject="dw_co_fa_lista_clientes"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event dw_1::rbuttondown;//
end event

event dw_1::doubleclicked;This.TriggerEvent("ue_entercol")
end event

event dw_1::ue_entercol;call super::ue_entercol;Long ll_codigo

//Messagebox("Enter","")
ll_codigo = GetItemNumber(This.Getrow(),"terc_tercero")
CloseWithReturn(Parent,ll_codigo)
end event

type st_ayuda from w_fa_padre`st_ayuda within w_fa_co_clien
boolean BringToTop=true
end type

type gb_2 from groupbox within w_fa_co_clien
int X=27
int Y=652
int Width=2153
int Height=208
string Text="Busquedas"
long BackColor=79416533
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_fa_co_clien
int X=23
int Width=2158
int Height=652
long BackColor=79416533
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_1 from radiobutton within w_fa_co_clien
int X=105
int Y=740
int Width=247
int Height=76
int TabOrder=10
boolean BringToTop=true
string Text="Cliente"
boolean Checked=true
boolean LeftText=true
long BackColor=79416533
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Dw_2.Postevent("editchanged")
end event

type rb_2 from radiobutton within w_fa_co_clien
int X=475
int Y=740
int Width=219
int Height=76
int TabOrder=20
boolean BringToTop=true
string Text="R.U.C."
boolean LeftText=true
long BackColor=79416533
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Dw_2.Postevent("editchanged")
end event

type rb_3 from radiobutton within w_fa_co_clien
int X=818
int Y=740
int Width=270
int Height=76
int TabOrder=30
boolean BringToTop=true
string Text="Nombre"
boolean LeftText=true
long BackColor=79416533
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Dw_2.Postevent("editchanged")
end event

type dw_2 from datawindow within w_fa_co_clien
event ue_escape pbm_dwescape
int X=1248
int Y=724
int Width=846
int Height=92
int TabOrder=40
boolean BringToTop=true
string DataObject="dw_texto"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event ue_escape;parent.postevent("close")
end event

event editchanged;
String ls_letra,formato,ls_setting
This.accepttext()
ls_letra =This.getitemstring(1,1) 

If Match (ls_letra, "%") = True Then Return
If ls_letra = "Texto" Then Return

IF rb_1.Checked = True THEN
	Formato = "String("  + "terc_tercero)"  + "like "   + "'" + ls_letra +"%" + "'"

ELSEIF rb_2.Checked = True THEN
		Formato = "terc_identificacion like " +"'"+ls_letra+"%"+"'"
	
    ELSEIF rb_3.Checked = True THEN
	       Formato = "terc_descripcion like " +"'"+ls_letra+"%"+"'"
		 
//      	ELSE
//           Formato = "dgapais.pais_descripcion like " +"'"+ls_letra+"%"+"'"
	      END IF
  

// Filtra
If Formato <> "" Then
dw_1.SetFilter ( Formato)
dw_1.Filter()

End If
end event

