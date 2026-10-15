forward
global type w_select_empr from w_a
end type
type dw_1 from datawindow within w_select_empr
end type
type gb_1 from groupbox within w_select_empr
end type
type cb_1 from commandbutton within w_select_empr
end type
end forward

global type w_select_empr from w_a
int Width=1577
int Height=1012
WindowType WindowType=response!
boolean TitleBar=true
string Title="Empresas"
long BackColor=12632256
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
dw_1 dw_1
gb_1 gb_1
cb_1 cb_1
end type
global w_select_empr w_select_empr

event resize;call super::resize;dw_1.Resize(newwidth - 100, newheight - 200)

end event

on w_select_empr.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.gb_1=create gb_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.cb_1
end on

on w_select_empr.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.cb_1)
end on

event open;call super::open;gf_center_win(this)

dw_1.SetTransObject(sqlca)

end event

event ue_init;is_nombre = This.ClassName()

st_window_name.text = is_nombre
st_window_name.width = len(st_window_name.text) * 35


dw_1.Retrieve(str.aplicacion, str.usuario, str.g_financiero)

end event

event ue_syscommand;// Omitir el Ancestro

If commandtype = 61536 And Not IsValid(str.frame) Then
	str.g_financiero = 0
	str.empresa = 0
End If

end event

event ue_close;This.TriggerEvent(Close!)
end event

type st_msghlp from w_a`st_msghlp within w_select_empr
int X=658
int Y=180
end type

type st_window_name from w_a`st_window_name within w_select_empr
int X=46
int Y=828
end type

type dw_1 from datawindow within w_select_empr
event ue_enter pbm_dwnkey
int X=55
int Y=92
int Width=1440
int Height=656
int TabOrder=10
boolean BringToTop=true
string DataObject="dw_select_empr"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event ue_enter;If KeyDown(KeyEnter!) Then
	If dw_1.GetSelectedRow(0) = dw_1.RowCount() Then
		dw_1.ScrollToRow(1)
		Return(1)
		Message.Processed = true
	End If
End If
end event

event clicked;This.SelectRow(0, False)

If row < 1 Then	Return

This.SelectRow(row, True)
end event

event doubleclicked;This.SelectRow(0, False)

If row < 1 Then	Return

This.SelectRow(row, True)

str.g_financiero = dw_1.GetItemNumber(row, "dgmempre_empr_g_financiero")
str.empresa = dw_1.GetItemNumber(row, "dgmempre_empr_empresa")

Close(Parent)
end event

event rowfocuschanged;This.SelectRow(0, False)
This.SelectRow(currentrow, True)
end event

type gb_1 from groupbox within w_select_empr
int X=32
int Y=20
int Width=1495
int Height=784
int TabOrder=20
string Text="Realice un Double Click en la Empresa Deseada"
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_select_empr
int X=1198
int Y=820
int Width=293
int Height=92
int TabOrder=20
boolean BringToTop=true
string Text="&Buscar"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String				ls_syntax
str_dg_dynamic_find	lstr_df

lstr_df.texto_campo[1, 1] = "dgmempre.empr_razon_social"
lstr_df.texto_campo[1, 2] = "Empresa"
lstr_df.texto_campo[1, 3] = "dgmempre_empr_razon_social"
lstr_df.texto_campo[1, 4] = "V"
lstr_df.texto_campo[1, 5] = "800"
lstr_df.texto_campo[2, 1] = "dgmempre.empr_empresa"
lstr_df.texto_campo[2, 2] = "Codigo"
lstr_df.texto_campo[2, 3] = "dgmempre_empr_empresa"
lstr_df.texto_campo[2, 4] = "V"
lstr_df.texto_campo[2, 5] = "200"
lstr_df.texto_campo[3, 1] = "dgagrupf.grup_descripcion"
lstr_df.texto_campo[3, 2] = "Grupo Financiero"
lstr_df.texto_campo[3, 3] = "dgagrupf_grup_descripcion"
lstr_df.texto_campo[3, 4] = "V"
lstr_df.texto_campo[3, 5] = "700"
lstr_df.tabla				  = " dgmempre,  ssmgrupusemp, dgagrupf  "
lstr_df.tabla_where		  = " WHERE ( ssmgrupusemp.grue_g_financiero = dgmempre.empr_g_financiero ) and  "+ &
						          " ( ssmgrupusemp.grue_empresa = dgmempre.empr_empresa ) and  "+&
							       " ( dgagrupf.grup_g_financiero = dgmempre.empr_g_financiero ) and  "+&
							       "  ( ( dgmempre.empr_estado = 'A' ) AND  "+&
      							 "  ( ssmgrupusemp.grue_estado = 'A' ) AND "+&									 
									 "  ( ssmgrupusemp.grue_aplicacion = '"+ String(str.aplicacion) + "' ) AND " +& 
  							       "  ( ssmgrupusemp.grue_usuario = '"+String(str.usuario) + "' ) AND "+&
 	       						 "  ( ssmgrupusemp.grue_g_financiero = "+String(str.g_financiero) + ") )"
			
OpenWithParm(w_dg_a_custom_find, lstr_df)

ls_syntax = Message.StringParm

//mensaje("",ls_syntax,"")

If Len(Trim(ls_syntax)) > 0 Then dw_1.ScrollToRow(dw_1.Find(ls_syntax, 1, dw_1.RowCount()))
end event

