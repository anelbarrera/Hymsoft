//objectcomments (D) Consultas Rapidas
forward
global type w_in_cod_trans_gen from w_in_padre_reportes
end type
type tab_1 from tab within w_in_cod_trans_gen
end type
type tabpage_1 from userobject within tab_1
end type
type dw_consulta from datawindow within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type st_6 from statictext within tabpage_1
end type
type em_1 from editmask within tabpage_1
end type
type st_7 from statictext within tabpage_1
end type
type em_2 from editmask within tabpage_1
end type
type pb_1 from picturebutton within tabpage_1
end type
type ddplb_1 from dropdownpicturelistbox within tabpage_1
end type
type gb_4 from groupbox within tabpage_1
end type
type gb_7 from groupbox within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type gb_3 from groupbox within tabpage_1
end type
type dw_buscar from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_consulta dw_consulta
cb_1 cb_1
st_6 st_6
em_1 em_1
st_7 st_7
em_2 em_2
pb_1 pb_1
ddplb_1 ddplb_1
gb_4 gb_4
gb_7 gb_7
st_1 st_1
st_2 st_2
gb_3 gb_3
dw_buscar dw_buscar
end type
type tabpage_2 from userobject within tab_1
end type
type dw_reporte from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_reporte dw_reporte
end type
type tab_1 from tab within w_in_cod_trans_gen
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type ln_3 from line within w_in_cod_trans_gen
end type
type st_nombre from statictext within w_in_cod_trans_gen
end type
type cb_2 from commandbutton within w_in_cod_trans_gen
end type
type gb_5 from groupbox within w_in_cod_trans_gen
end type
end forward

global type w_in_cod_trans_gen from w_in_padre_reportes
integer width = 3264
integer height = 1736
string menuname = "m_hs"
boolean controlmenu = false
long backcolor = 553648127
tab_1 tab_1
ln_3 ln_3
st_nombre st_nombre
cb_2 cb_2
gb_5 gb_5
end type
global w_in_cod_trans_gen w_in_cod_trans_gen

type variables
datawindow dw1,dw2,dw3
integer ii_tipo
str_kardex str_opcion
end variables

forward prototypes
public subroutine wf_fecha ()
public subroutine wf_nofecha ()
public subroutine wf_recuperar_general ()
public subroutine wf_recuperar_existencia ()
public subroutine wf_recuperar_prod1 ()
public subroutine wf_recuperar_prod2 ()
public subroutine wf_recuperar_pbu ()
public subroutine wf_recuperar_bod_ubi ()
public subroutine wf_recuperar_arancel ()
public subroutine wf_recuperar_proveedor ()
end prototypes

public subroutine wf_fecha ();//dw2.visible = false
tab_1.tabpage_1.em_1.visible = True
tab_1.tabpage_1.em_2.visible = True
tab_1.tabpage_1.pb_1.visible = True
tab_1.tabpage_1.st_6.visible = True
tab_1.tabpage_1.st_7.visible = True

tab_1.tabpage_1.em_1.setfocus()
dw1.reset()
dw1.insertrow(1)
dw1.SetColumn("texto")

end subroutine

public subroutine wf_nofecha ();//dw1.visible = True
tab_1.tabpage_1.em_1.visible = false
tab_1.tabpage_1.em_2.visible = false
tab_1.tabpage_1.pb_1.visible = false
tab_1.tabpage_1.st_6.visible = false
tab_1.tabpage_1.st_7.visible = false

dw1.setfocus()
dw1.reset()
dw1.insertrow(1)
dw1.SetColumn("texto")
end subroutine

public subroutine wf_recuperar_general ();// Script que filta los Items de Dw_1
// Daniel Vergara 07/05/1998
String ls_letra,formato,ls_setting
dw1.accepttext()
ls_letra =dw1.getitemstring(1,1) 

/* Si en la cadena viene un % se retorna automaticamente */
If Match (ls_letra, "%") = True Then Return
If ls_letra = "Texto" and Tab_1.TabPage_1.em_1.text = "" Then Return


// Permite Modificar el estado Con la Finalidad de que Funcione el Filtrado
      ls_setting = dw2.Describe("DataWindow.Retrieve.AsNeeded")
       If ls_setting = "yes" Then 
           dw2.Modify("DataWindow.Retrieve.AsNeeded=No")	
       End If	



IF ii_tipo = 1 THEN /*Codigo*/
	Formato =  "indmovim_dmov_producto like "   + "'" + ls_letra +"%" + "'"

ELSEIF ii_tipo = 2 THEN /*Descripción*/
	
	Formato =  "inmprodu_prod_descripcion like " +"'"+ls_letra+"%"+"'"
	
ELSEIF ii_tipo = 3 THEN /* Producto dos*/
	Formato =  "inmprodu_prod_producto_dos like " +"'"+ls_letra+"%"+"'"

ELSEIF ii_tipo = 4 THEN /* descripcion dos*/
	Formato =  "inmprodu_prod_descripcion_dos like " +"'"+ls_letra+"%"+"'"

ELSEIF ii_tipo = 5 THEN /* bodega*/
	Formato =  "indmovim_dmov_bodega like " +"'"+ls_letra+"%"+"'"

ELSEIF ii_tipo = 6 THEN /* ubicacion*/
	Formato =  "indmovim_dmov_ubicacion like " +"'"+ls_letra+"%"+"'"
	
ELSEIF ii_tipo = 7 THEN /* documento*/
	Formato =  "indmovim_dmov_documento like " +"'"+ls_letra+"%"+"'"
	
ELSEIF ii_tipo = 8 THEN /* secuencia*/	
	Formato =  "String("  + "dmov_secuencia)"  + "like "   + "'" + ls_letra +"%" + "'"

ELSEIF ii_tipo = 9 THEN /* concepto*/	
	Formato =  "dgmsubse_subs_descripcion like " +"'"+ls_letra+"%"+"'"
	
ELSEIF ii_tipo = 10 THEN /* Fecha de Creación*/
Formato =  " date(intmovim_tmov_fecha) Between " + &
	                  "Date(" + "'" + Tab_1.TabPage_1.em_1.text + "'" + ")" + " And " + & 
					"Date("+ "'" +Tab_1.TabPage_1.em_2.text +"'"+")" 
END IF

// Filtra  Los Datos
If Formato <> "" Then
	dw2.SetFilter ( Formato)
	dw2.Filter()	
	dw3.SetFilter (Formato)
	dw3.Filter()
End If
end subroutine

public subroutine wf_recuperar_existencia ();// Script que filta los Items de Dw_1
// Daniel Vergara 07/05/1998
String ls_letra,formato,ls_setting
dw1.accepttext()
ls_letra =dw1.getitemstring(1,1) 

/* Si en la cadena viene un % se retorna automaticamente */
If Match (ls_letra, "%") = True Then Return
If ls_letra = "Texto" Then Return


// Permite Modificar el estado Con la Finalidad de que Funcione el Filtrado
      ls_setting = dw2.Describe("DataWindow.Retrieve.AsNeeded")
       If ls_setting = "yes" Then 
           dw2.Modify("DataWindow.Retrieve.AsNeeded=No")	
       End If	



IF ii_tipo = 1 THEN /*Codigo*/
	Formato =  "mbod_producto like "   + "'" + ls_letra +"%" + "'"

ELSEIF ii_tipo = 2 THEN /*Descripción*/
	
	Formato =  "prod_descripcion like " +"'"+ls_letra+"%"+"'"
	
ELSEIF ii_tipo = 3 THEN /* Producto dos*/
	Formato =  "prod_producto_dos like " +"'"+ls_letra+"%"+"'"

ELSEIF ii_tipo = 4 THEN /* descripcion dos*/
	Formato =  "prod_descripcion_dos like " +"'"+ls_letra+"%"+"'"

ELSEIF ii_tipo = 5 THEN /* division*/
	Formato =  "mbod_bodega like " +"'"+ls_letra+"%"+"'"

ELSEIF ii_tipo = 6 THEN /* linea*/
	Formato =  "mbod_ubicacion like " +"'"+ls_letra+"%"+"'"
END IF

// Filtra  Los Datos
If Formato <> "" Then
	dw2.SetFilter ( Formato)
	dw2.Filter()
	dw3.SetFilter (Formato)
	dw3.Filter()
End If
end subroutine

public subroutine wf_recuperar_prod1 ();// Script que filta los Items de Dw_1
// Daniel Vergara 07/05/1998
String ls_letra,formato,ls_setting
dw1.accepttext()
ls_letra =dw1.getitemstring(1,1) 

/* Si en la cadena viene un % se retorna automaticamente */
If Match (ls_letra, "%") = True Then Return
If ls_letra = "Texto" and Tab_1.TabPage_1.em_1.text = "" Then Return


// Permite Modificar el estado Con la Finalidad de que Funcione el Filtrado
      ls_setting = dw2.Describe("DataWindow.Retrieve.AsNeeded")
       If ls_setting = "yes" Then 
           dw2.Modify("DataWindow.Retrieve.AsNeeded=No")	
       End If	



IF ii_tipo = 1 THEN /*Codigo*/
	Formato =  "prod_producto like "   + "'" + ls_letra +"%" + "'"

ELSEIF ii_tipo = 2 THEN /*Descripción*/
	
	Formato =  "prod_descripcion like " +"'"+ls_letra+"%"+"'"
	
ELSEIF ii_tipo = 3 THEN /* Producto dos*/
	Formato =  "prod_producto_dos like " +"'"+ls_letra+"%"+"'"

ELSEIF ii_tipo = 4 THEN /* descripcion dos*/
	Formato =  "prod_descripcion_dos like " +"'"+ls_letra+"%"+"'"

ELSEIF ii_tipo = 5 THEN /* grupo*/
	Formato =  "agru_descripcion_grupo like " +"'"+ls_letra+"%"+"'"

ELSEIF ii_tipo = 6 THEN /* Fecha de Creación*/
Formato =  " date(prod_fecha_creacion) Between " + &
	                  "Date(" + "'" + Tab_1.TabPage_1.em_1.text + "'" + ")" + " And " + & 
					"Date("+ "'" +Tab_1.TabPage_1.em_2.text +"'"+")" 
END IF

// Filtra  Los Datos
If Formato <> "" Then
	dw2.SetFilter ( Formato)
	dw2.Filter()
	dw3.SetFilter (Formato)
	dw3.Filter()
End If
end subroutine

public subroutine wf_recuperar_prod2 ();// Script que filta los Items de Dw_1
// Daniel Vergara 07/05/1998
String ls_letra,formato,ls_setting
dw1.accepttext()
ls_letra =dw1.getitemstring(1,1) 

/* Si en la cadena viene un % se retorna automaticamente */
If Match (ls_letra, "%") = True Then Return
If ls_letra = "Texto" Then Return


// Permite Modificar el estado Con la Finalidad de que Funcione el Filtrado
      ls_setting = dw2.Describe("DataWindow.Retrieve.AsNeeded")
       If ls_setting = "yes" Then 
           dw2.Modify("DataWindow.Retrieve.AsNeeded=No")	
       End If	



IF ii_tipo = 1 THEN /*Codigo*/
	Formato =  "prod_producto like "   + "'" + ls_letra +"%" + "'"

ELSEIF ii_tipo = 2 THEN /*Descripción*/
	
	Formato =  "prod_descripcion like " +"'"+ls_letra+"%"+"'"
	
ELSEIF ii_tipo = 3 THEN /* Producto dos*/
	Formato =  "prod_producto_dos like " +"'"+ls_letra+"%"+"'"

ELSEIF ii_tipo = 4 THEN /* descripcion dos*/
	Formato =  "prod_descripcion_dos like " +"'"+ls_letra+"%"+"'"

ELSEIF ii_tipo = 5 THEN /* division*/
	Formato =  "adiv_nombre_div like " +"'"+ls_letra+"%"+"'"

ELSEIF ii_tipo = 6 THEN /* linea*/
	Formato =  "alin_descripcion_linea like " +"'"+ls_letra+"%"+"'"
	
ELSEIF ii_tipo = 7 THEN /* marca*/
	Formato =  "amar_nombre_marca like " +"'"+ls_letra+"%"+"'"
	
//ELSEIF ii_tipo = 6 THEN /* Fecha de Creación*/
//Formato =  " date(prod_fecha_creacion) Between " + &
//	                  "Date(" + "'" + em_1.text + "'" + ")" + " And " + & 
//					"Date("+ "'" +em_2.text +"'"+")" 
END IF

// Filtra  Los Datos
If Formato <> "" Then
	dw2.SetFilter ( Formato)
	dw2.Filter()
	dw3.SetFilter (Formato)
	dw3.Filter()
End If
end subroutine

public subroutine wf_recuperar_pbu ();// Script que filta los Items de Dw_1
// Daniel Vergara 07/05/1998
String ls_letra,formato,ls_setting
dw1.accepttext()
ls_letra =dw1.getitemstring(1,1) 

/* Si en la cadena viene un % se retorna automaticamente */
If Match (ls_letra, "%") = True Then Return
If ls_letra = "Texto" Then Return


// Permite Modificar el estado Con la Finalidad de que Funcione el Filtrado
      ls_setting = dw2.Describe("DataWindow.Retrieve.AsNeeded")
       If ls_setting = "yes" Then 
           dw2.Modify("DataWindow.Retrieve.AsNeeded=No")	
       End If	



IF ii_tipo = 1 THEN /*Codigo*/
	Formato =  "inmbodeg_mbod_producto like "   + "'" + ls_letra +"%" + "'"

ELSEIF ii_tipo = 2 THEN /*Descripción*/
	
	Formato =  "inmprodu_prod_descripcion like " +"'"+ls_letra+"%"+"'"
	
ELSEIF ii_tipo = 3 THEN /* Producto dos*/
	Formato =  "inmprodu_prod_producto_dos like " +"'"+ls_letra+"%"+"'"

ELSEIF ii_tipo = 4 THEN /* descripcion dos*/
	Formato =  "inmprodu_prod_descripcion_dos like " +"'"+ls_letra+"%"+"'"

ELSEIF ii_tipo = 5 THEN /* division*/
	Formato =  "inmbodeg_mbod_bodega like " +"'"+ls_letra+"%"+"'"

ELSEIF ii_tipo = 6 THEN /* linea*/
	Formato =  "inmbodeg_mbod_ubicacion like " +"'"+ls_letra+"%"+"'"
	
ELSEIF ii_tipo = 7 THEN /* marca*/
	Formato =  "inmprodu_prod_barra like " +"'"+ls_letra+"%"+"'"
	
//ELSEIF ii_tipo = 6 THEN /* Fecha de Creación*/
//Formato =  " date(prod_fecha_creacion) Between " + &
//	                  "Date(" + "'" + em_1.text + "'" + ")" + " And " + & 
//					"Date("+ "'" +em_2.text +"'"+")" 
END IF

// Filtra  Los Datos
If Formato <> "" Then
	dw2.SetFilter ( Formato)
	dw2.Filter()
	dw3.SetFilter (Formato)
	dw3.Filter()
End If
end subroutine

public subroutine wf_recuperar_bod_ubi ();// Script que filta los Items de Dw_1
// Daniel Vergara 07/05/1998
String ls_letra,formato,ls_setting
dw1.accepttext()
ls_letra =dw1.getitemstring(1,1) 

/* Si en la cadena viene un % se retorna automaticamente */
If Match (ls_letra, "%") = True Then Return
If ls_letra = "Texto" Then Return


// Permite Modificar el estado Con la Finalidad de que Funcione el Filtrado
      ls_setting = dw2.Describe("DataWindow.Retrieve.AsNeeded")
       If ls_setting = "yes" Then 
           dw2.Modify("DataWindow.Retrieve.AsNeeded=No")	
       End If	



IF ii_tipo = 1 THEN /*Codigo*/
	Formato =  "inabodeg_abod_bodega like "   + "'" + ls_letra +"%" + "'"

ELSEIF ii_tipo = 2 THEN /*Descripción*/
	
	Formato =  "inabodeg_abod_descripcion like " +"'"+ls_letra+"%"+"'"
	
ELSEIF ii_tipo = 3 THEN /* codigo ubicacion*/
	Formato =  "inaubica_ubic_ubicacion like " +"'"+ls_letra+"%"+"'"

ELSEIF ii_tipo = 4 THEN /* descripcion ubicacion*/
	Formato =  "inaubica_ubic_descripcion like " +"'"+ls_letra+"%"+"'"

END IF

// Filtra  Los Datos
If Formato <> "" Then
	dw2.SetFilter ( Formato)
	dw2.Filter()
	dw3.SetFilter (Formato)
	dw3.Filter()
End If
end subroutine

public subroutine wf_recuperar_arancel ();// Script que filta los Items de Dw_1
// Daniel Vergara 07/05/1998
String ls_letra,formato,ls_setting
dw1.accepttext()
ls_letra =dw1.getitemstring(1,1) 

/* Si en la cadena viene un % se retorna automaticamente */
If Match (ls_letra, "%") = True Then Return
If ls_letra = "Texto" Then Return


// Permite Modificar el estado Con la Finalidad de que Funcione el Filtrado
      ls_setting = dw2.Describe("DataWindow.Retrieve.AsNeeded")
       If ls_setting = "yes" Then 
           dw2.Modify("DataWindow.Retrieve.AsNeeded=No")	
       End If	



IF ii_tipo = 1 THEN /*Codigo*/
	Formato =  "aran_arancel like "   + "'" + ls_letra +"%" + "'"

ELSEIF ii_tipo = 2 THEN /*Descripción*/
	
	Formato =  "aran_descripcion like " +"'"+ls_letra+"%"+"'"

END IF

// Filtra  Los Datos
If Formato <> "" Then
	dw2.SetFilter ( Formato)
	dw2.Filter()
	dw3.SetFilter (Formato)
	dw3.Filter()
End If
end subroutine

public subroutine wf_recuperar_proveedor ();// Script que filta los Items de Dw_1
// Daniel Vergara 07/05/1998
String ls_letra,formato,ls_setting
dw1.accepttext()
ls_letra =dw1.getitemstring(1,1) 

/* Si en la cadena viene un % se retorna automaticamente */
If Match (ls_letra, "%") = True Then Return
If ls_letra = "Texto" Then Return


// Permite Modificar el estado Con la Finalidad de que Funcione el Filtrado
      ls_setting = dw2.Describe("DataWindow.Retrieve.AsNeeded")
       If ls_setting = "yes" Then 
           dw2.Modify("DataWindow.Retrieve.AsNeeded=No")	
       End If	



IF ii_tipo = 1 THEN /*Codigo*/
	Formato =  "string(terc_tercero) like "   + "'" + ls_letra +"%" + "'"

ELSEIF ii_tipo = 2 THEN /*Descripción*/
	
	Formato =  "terc_identificacion like " +"'"+ls_letra+"%"+"'"
	
ELSEIF ii_tipo = 3 THEN /* codigo ubicacion*/
	Formato =  "terc_descripcion like " +"'"+ls_letra+"%"+"'"

END IF

// Filtra  Los Datos
If Formato <> "" Then
	dw2.SetFilter ( Formato)
	dw2.Filter()
	dw3.SetFilter (Formato)
	dw3.Filter()
End If
end subroutine

on w_in_cod_trans_gen.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_hs" then this.MenuID = create m_hs
this.tab_1=create tab_1
this.ln_3=create ln_3
this.st_nombre=create st_nombre
this.cb_2=create cb_2
this.gb_5=create gb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.ln_3
this.Control[iCurrent+3]=this.st_nombre
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.gb_5
end on

on w_in_cod_trans_gen.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.ln_3)
destroy(this.st_nombre)
destroy(this.cb_2)
destroy(this.gb_5)
end on

event ue_post_open;String ls_path
Integer li_pic
st_nombre.text = this.classname()
//***************************************************************************//

sqlca.autocommit = true

dw2.DataObject = str_opcion.dwinforme_1

dw3.DataObject = str_opcion.dwinforme_2

//***************************************************************************//
//se llena el DropDownListBox dependiendo de la consulta a generar           //
//***************************************************************************//
If str_opcion.opcion_menu = 'CGF' Or & 
   str_opcion.opcion_menu = 'CTE' Or &
	str_opcion.opcion_menu = 'CTS' Or &
	str_opcion.opcion_menu = 'CAP' Or &
	str_opcion.opcion_menu = 'CAE' Or &
   str_opcion.opcion_menu = 'CAC' Then
	ls_path = str.path + 'art\dba_acept.bmp'
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Código de Producto",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Descripción",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Código de Producto Dos",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Descripcion Dos",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Código de Bodega",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Código de Ubicación",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Documento",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Num. Secuencia",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Concepto",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Fecha",li_pic)
	
	Tab_1.TabPage_1.ddplb_1.Text = 'Código de Producto'
	
ElseIf str_opcion.opcion_menu = 'CEC'  or &
	    str_opcion.opcion_menu = 'CEP'  or &
		 str_opcion.opcion_menu = 'CEPC' or &
		 str_opcion.opcion_menu = 'CES'  or &
		 str_opcion.opcion_menu = 'CPBU' Then
	ls_path = str.path + 'art\dba_acept.bmp'
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Código de Producto",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Descripción",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Código de Producto Dos",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Descripcion Dos",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Código de Bodega",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Código de Ubicación",li_pic)
	If str_opcion.opcion_menu = 'CPBU' Then
		li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	   Tab_1.TabPage_1.ddplb_1.AddItem("Código de Barra",li_pic)
	End If	
	
	Tab_1.TabPage_1.ddplb_1.Text = 'Código de Producto'
	
ElseIf str_opcion.opcion_menu = 'CP1' Then
	ls_path = str.path + 'art\dba_acept.bmp'
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Código de Producto",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Descripción",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Código de Producto Dos",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Descripcion Dos",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Código de Grupo",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Fecha de Creación",li_pic)	
	
	Tab_1.TabPage_1.ddplb_1.Text = 'Código de Producto'
	
ElseIf str_opcion.opcion_menu = 'CP2' Then
	ls_path = str.path + 'art\dba_acept.bmp'
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Código de Producto",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Descripción",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Código de Producto Dos",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Descripcion Dos",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Código de Division",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Código Clase/Linea",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Código Marca",li_pic)
	
	Tab_1.TabPage_1.ddplb_1.Text = 'Código de Producto'
	
ElseIf str_opcion.opcion_menu = 'CBU' Then
	ls_path = str.path + 'art\dba_acept.bmp'
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Código de Bodega",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Descripción Bodega",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Código de Ubicación",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Descripción Ubicación",li_pic)
	
	Tab_1.TabPage_1.ddplb_1.Text = 'Código de Bodega'
	
ElseIf str_opcion.opcion_menu = 'CAR' Then
	ls_path = str.path + 'art\dba_acept.bmp'
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Código de Arancel",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Descripción",li_pic)
	
	Tab_1.TabPage_1.ddplb_1.Text = 'Código de Arancel'

ElseIf str_opcion.opcion_menu = 'CPR' Then
	ls_path = str.path + 'art\dba_acept.bmp'
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Código de Proveedor",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Código de Identificación",li_pic)
	li_pic = Tab_1.TabPage_1.ddplb_1.AddPicture(ls_path)
	Tab_1.TabPage_1.ddplb_1.AddItem("Descripción",li_pic)
	
	Tab_1.TabPage_1.ddplb_1.Text = 'Código de Proveedor'
End If

dw2.settransobject(sqlca)

dw3.settransobject(sqlca)


dw2.Retrieve(str.g_financiero,str.empresa)
Yield()
dw2.ShareData(dw3)

//dw3.Retrieve(str.g_financiero,str.empresa)
//Yield()

dw1.SetTransObject(SQLCA)

Dw1.InsertRow(0)

//COMMIT USING SQLCA;

ii_tipo = 1

Tab_1.TabPage_1.ddplb_1.Text = 'Código de Producto'

/*** Setea el foco en la columna texto del dw_2 ****/
dw1.setfocus()
dw1.SetColumn("texto")
dw1.SetItem(1, "texto","Texto") 



end event

event open;call super::open; //wf_set_panel_visible("PAN_ACCIONES_CAT5", False)
 
 w_hs_frame lw_frame



If IsValid(lw_frame) Then
   lw_frame.wf_set_panel_visible("PAN_ACCIONES_CAT3", False) 
 End If
sqlca.autocommit=true
str_opcion = Message.PowerObjectParm

This.Title = str_opcion.titulo_ventana
dw1=tab_1.tabpage_1.dw_buscar
dw2=tab_1.tabpage_1.dw_consulta
dw3=tab_1.tabpage_2.dw_reporte
//dw2.ShareData(dw3)

//string ls_tipo1 = 'AE'
//string ls_tipo2 = 'SA'
//string ls_tipo3 = 'TR'
//string ls_tipo4 = 'EN'
//double ld_filas
//
//select count(*)
//into   :ld_filas
//from   intmovim
//where  tmov_g_financiero =: str.g_financiero and
//       tmov_empresa =: str.empresa and
//		 tmov_tipo_transaccion =: ls_tipo1 or
//		 tmov_tipo_transaccion =: ls_tipo2 or
//		 tmov_tipo_transaccion =: ls_tipo3 or
//		 tmov_tipo_transaccion =. ls_tipo4 ;
//		 
//if ld_filas = 0 then
//	mensaje('Informacion','No Existe Movimiento de Transacciones~r~n&
//	Generadas Para Consultar','')
//	close (this)
//end if
end event

event ue_print;//dw = dw3
//OpenWithParm(w_dw_print_options, dw)
//If Message.DoubleParm = -1 Then Return
//dw.Print(True)
end event

event ue_reg_anterior;dw3.scrollpriorpage()
end event

event ue_siguiente_reg;dw3.scrollnextpage()
end event

event ue_ultimo_reg;dw3.scrolltorow(dw3.rowcount())
end event

event ue_primer_reg;dw3.scrolltorow(1)
end event

event ue_sort;string ls_null, ls_ordena
setnull(ls_null)
dw2.setsort(ls_null) 
ls_ordena = dw2.Describe("datawindow.table.sort")
dw3.setsort(ls_ordena)
dw2.sort()
dw3.sort()
dw2.GroupCalc()
dw3.GroupCalc()
end event

event ue_filter;String var, ls_filter
SetNull(var)

// Open The Filter Window
dw2.SetFilter(var)
ls_filter = dw2.Describe("datawindow.Table.Filter")
dw3.SetFilter(ls_filter)
// Execute the filter expresion definida to the user
dw2.filter()
dw3.filter()
dw2.GroupCalc()
dw3.GroupCalc()
end event

event resize;call super::resize;st_nombre.y = newheight - (st_nom_ventana.height + 10)

tab_1.Resize(newwidth - 15, newheight - 90)
tab_1.tabpage_1.width = tab_1.width - 10 
tab_1.tabpage_1.dw_consulta.width = tab_1.width - 30 

tab_1.tabpage_1.height = tab_1.height - 150
tab_1.tabpage_1.dw_consulta.height = tab_1.tabpage_1.height - 200



tab_1.tabpage_2.width = tab_1.width - 10 
tab_1.tabpage_2.dw_reporte.width = tab_1.width - 30 

tab_1.tabpage_2.height = tab_1.height - 150
tab_1.tabpage_2.dw_reporte.height = tab_1.tabpage_2.height - 50



gb_1.Width = newwidth - 75
gb_1.Height = newheight - 120
end event

event key;call super::key;if key = KeyEscape! then
	PostEvent(close!)
end if
end event

event close;call super::close;Window lw_frame

lw_frame = ParentWindow()

If IsValid(lw_frame) Then
   lw_frame.PostEvent("ue_sheet_closed")
 End If
if isvalid(this) then close(this)
end event

event ue_imprimir;dw = dw3
OpenWithParm(w_dw_print_options, dw)
If Message.DoubleParm = -1 Then Return
dw.Print(True)
end event

type st_ayuda from w_in_padre_reportes`st_ayuda within w_in_cod_trans_gen
end type

type st_nom_ventana from w_in_padre_reportes`st_nom_ventana within w_in_cod_trans_gen
boolean visible = false
end type

type dw_1 from w_in_padre_reportes`dw_1 within w_in_cod_trans_gen
boolean visible = false
end type

event dw_1::constructor;//////
end event

type gb_1 from w_in_padre_reportes`gb_1 within w_in_cod_trans_gen
integer taborder = 50
end type

type gb_ventana from w_in_padre_reportes`gb_ventana within w_in_cod_trans_gen
boolean visible = false
end type

type gb_2 from w_in_padre_reportes`gb_2 within w_in_cod_trans_gen
boolean visible = false
integer x = 5
integer taborder = 60
end type

type tab_1 from tab within w_in_cod_trans_gen
integer y = 8
integer width = 2944
integer height = 1420
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean fixedwidth = true
boolean raggedright = true
boolean powertips = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;if newindex = 2 then
	if dw3.rowcount() > 0 then
	dw3.object.datawindow.print.preview ="yes"
   dw3.object.datawindow.print.preview.zoom =100
   end if
end if
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 2907
integer height = 1292
long backcolor = 12632256
string text = "Consulta"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
string picturename = "PasteSQL5!"
long picturemaskcolor = 553648127
string powertiptext = "Consulta"
dw_consulta dw_consulta
cb_1 cb_1
st_6 st_6
em_1 em_1
st_7 st_7
em_2 em_2
pb_1 pb_1
ddplb_1 ddplb_1
gb_4 gb_4
gb_7 gb_7
st_1 st_1
st_2 st_2
gb_3 gb_3
dw_buscar dw_buscar
end type

on tabpage_1.create
this.dw_consulta=create dw_consulta
this.cb_1=create cb_1
this.st_6=create st_6
this.em_1=create em_1
this.st_7=create st_7
this.em_2=create em_2
this.pb_1=create pb_1
this.ddplb_1=create ddplb_1
this.gb_4=create gb_4
this.gb_7=create gb_7
this.st_1=create st_1
this.st_2=create st_2
this.gb_3=create gb_3
this.dw_buscar=create dw_buscar
this.Control[]={this.dw_consulta,&
this.cb_1,&
this.st_6,&
this.em_1,&
this.st_7,&
this.em_2,&
this.pb_1,&
this.ddplb_1,&
this.gb_4,&
this.gb_7,&
this.st_1,&
this.st_2,&
this.gb_3,&
this.dw_buscar}
end on

on tabpage_1.destroy
destroy(this.dw_consulta)
destroy(this.cb_1)
destroy(this.st_6)
destroy(this.em_1)
destroy(this.st_7)
destroy(this.em_2)
destroy(this.pb_1)
destroy(this.ddplb_1)
destroy(this.gb_4)
destroy(this.gb_7)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.gb_3)
destroy(this.dw_buscar)
end on

type dw_consulta from datawindow within tabpage_1
integer y = 192
integer width = 2894
integer height = 1076
integer taborder = 41
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event sqlpreview;//mensaje("",this.dataobject,sqlsyntax  )
end event

type cb_1 from commandbutton within tabpage_1
integer x = 2528
integer y = 80
integer width = 297
integer height = 84
integer taborder = 23
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Ordenar"
end type

event clicked;Parent.TriggerEvent('ue_sort')
end event

type st_6 from statictext within tabpage_1
boolean visible = false
integer x = 901
integer y = 72
integer width = 192
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Entre"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_1 from editmask within tabpage_1
boolean visible = false
integer x = 1093
integer y = 72
integer width = 347
integer height = 76
integer taborder = 23
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean spin = true
string displaydata = ","
double increment = 1
end type

type st_7 from statictext within tabpage_1
boolean visible = false
integer x = 1431
integer y = 72
integer width = 165
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "y"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_2 from editmask within tabpage_1
boolean visible = false
integer x = 1595
integer y = 72
integer width = 347
integer height = 76
integer taborder = 24
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean spin = true
string displaydata = "~b"
double increment = 1
end type

type pb_1 from picturebutton within tabpage_1
boolean visible = false
integer x = 1934
integer y = 72
integer width = 197
integer height = 76
integer taborder = 25
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\harr2000\art\blind.bmp"
end type

event clicked;If em_1.text <> "" And em_2.text <> "" Then
	dw1.Triggerevent("editchanged")
else
	Messagebox("Alto","Es Requerida Una fecha para Realizar la Busqueda",StopSign!)
End If	
end event

type ddplb_1 from dropdownpicturelistbox within tabpage_1
integer x = 27
integer y = 72
integer width = 827
integer height = 636
integer taborder = 41
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Código Producto"
boolean autohscroll = true
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
long picturemaskcolor = 12639424
end type

event selectionchanged;ii_tipo = index
If str_opcion.opcion_menu = 'CGF' or &
   str_opcion.opcion_menu = 'CAC' or &
	str_opcion.opcion_menu = 'CTE' or &
	str_opcion.opcion_menu = 'CTS' or &
	str_opcion.opcion_menu = 'CAP' or &
	str_opcion.opcion_menu = 'CAE'  Then
   If ii_tipo <> 10 then
	   dw1.Postevent("editchanged")
      wf_nofecha()
   Else
	   dw1.Postevent("editchanged")
	   wf_fecha()
   End If
ElseIf str_opcion.opcion_menu = 'CEC'  or &
	    str_opcion.opcion_menu = 'CEP'  or &
		 str_opcion.opcion_menu = 'CEPC' or &
		 str_opcion.opcion_menu = 'CES'  or &
		 str_opcion.opcion_menu = 'CP2'  or &
		 str_opcion.opcion_menu = 'CBU'  or &
		 str_opcion.opcion_menu = 'CAR'  or &
		 str_opcion.opcion_menu = 'CPR'  or &
		 str_opcion.opcion_menu = 'CPBU' Then
		 wf_nofecha()
	    dw1.Postevent("editchanged")
ElseIf str_opcion.opcion_menu = 'CP1'  Then
	    if ii_tipo <> 6 then
	       dw1.Postevent("editchanged")
          wf_nofecha()
       else
	       dw1.Postevent("editchanged")
	       wf_fecha()
       end if
End If
end event

type gb_4 from groupbox within tabpage_1
integer x = 18
integer y = 32
integer width = 846
integer height = 148
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_7 from groupbox within tabpage_1
integer x = 2510
integer y = 40
integer width = 329
integer height = 136
integer taborder = 24
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
end type

type st_1 from statictext within tabpage_1
integer x = 5
integer width = 462
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tipo de Busqueda"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_1
integer x = 873
integer width = 361
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Buscar Por"
boolean focusrectangle = false
end type

type gb_3 from groupbox within tabpage_1
integer x = 887
integer y = 24
integer width = 1285
integer height = 148
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_buscar from datawindow within tabpage_1
integer x = 896
integer y = 64
integer width = 1248
integer height = 88
integer taborder = 21
boolean bringtotop = true
string dataobject = "dw_in_texto"
borderstyle borderstyle = stylelowered!
end type

event editchanged;If str_opcion.opcion_menu = 'CGF' Or &
   str_opcion.opcion_menu = 'CTE' Or &
	str_opcion.opcion_menu = 'CTS' Or &
	str_opcion.opcion_menu = 'CAP' Or &
	str_opcion.opcion_menu = 'CAE' Or &
   str_opcion.opcion_menu = 'CAC' Then
	wf_recuperar_general()
ElseIf str_opcion.opcion_menu = 'CEC'  Or & 
	    str_opcion.opcion_menu = 'CEP'  Or &
		 str_opcion.opcion_menu = 'CEPC' Or &
		 str_opcion.opcion_menu = 'CES'  Then
		 wf_recuperar_existencia()
ElseIf str_opcion.opcion_menu = 'CP1' Then  //Consulta de productos (1)
		 wf_recuperar_prod1()
ElseIf str_opcion.opcion_menu = 'CP2' Then //Consulta de Productos (2)
		 wf_recuperar_prod2()
ElseIf str_opcion.opcion_menu = 'CPBU' Then //productos por bodega y ubicacion
		 wf_recuperar_pbu()
ElseIf str_opcion.opcion_menu = 'CBU' Then //bodega y ubicacion
		 wf_recuperar_bod_ubi()
ElseIf str_opcion.opcion_menu = 'CAR' Then //Arancel
		 wf_recuperar_arancel()
ElseIf str_opcion.opcion_menu = 'CPR' Then //proveedor
		 wf_recuperar_proveedor()
End If



end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 2907
integer height = 1292
long backcolor = 12632256
string text = "Reporte"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
string picturename = "Custom050!"
long picturemaskcolor = 553648127
string powertiptext = "Reporte"
dw_reporte dw_reporte
end type

on tabpage_2.create
this.dw_reporte=create dw_reporte
this.Control[]={this.dw_reporte}
end on

on tabpage_2.destroy
destroy(this.dw_reporte)
end on

type dw_reporte from datawindow within tabpage_2
integer y = 8
integer width = 2834
integer height = 1228
integer taborder = 42
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event sqlpreview;mensaje("",this.dataobject,sqlsyntax  )
end event

type ln_3 from line within w_in_cod_trans_gen
long linecolor = 8421504
integer linethickness = 8
integer beginy = 44
integer endx = 2843
integer endy = 44
end type

type st_nombre from statictext within w_in_cod_trans_gen
boolean visible = false
integer x = 37
integer y = 1468
integer width = 1326
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_in_cod_trans_gen
boolean visible = false
integer x = 1682
integer y = 1432
integer width = 457
integer height = 120
integer taborder = 20
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;dw2.Retrieve(str.g_financiero,str.empresa)
//Yield()
dw3.Retrieve(str.g_financiero,str.empresa)

end event

type gb_5 from groupbox within w_in_cod_trans_gen
integer x = 91
integer y = 92
integer width = 494
integer height = 360
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

