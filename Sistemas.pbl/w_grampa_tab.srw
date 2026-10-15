//objectcomments Ventana de Tab Ancestro (NO TOCAR)
forward
global type w_grampa_tab from Window
end type
type tab_1 from tab within w_grampa_tab
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from datawindow within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from datawindow within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_3 from datawindow within tabpage_3
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
end type
type tabpage_3 from userobject within tab_1
dw_3 dw_3
end type
type tab_1 from tab within w_grampa_tab
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_grampa_tab from Window
int X=672
int Y=268
int Width=2149
int Height=1376
boolean TitleBar=true
string Title="Untitled"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_post_open ( )
event ue_aceptar ( )
event ue_valida_todo ( )
event ue_cancelar ( )
event ue_prox_dw ( )
event ue_reg_anterior ( )
event ue_siguiente_reg ( )
event ue_adicionar ( )
event ue_pre_aceptar ( )
event ue_eliminar ( )
event ue_pre_eliminar ( )
event ue_insertar ( )
event ue_ultimo_reg ( )
event ue_primer_reg ( )
event ue_print ( )
tab_1 tab_1
end type
global w_grampa_tab w_grampa_tab

type variables
DataWindow idw_d, idw_proximo
//* idw_d es el anterior 
integer ii_vandera,ii_nex_tab
Window iw_this
end variables

forward prototypes
public function string wf_tab (readonly integer li_tab)
public function datawindow wf_tab_prox (readonly integer li_tab)
public subroutine wf_guarda_anterior (readonly datawindow dw_anterior)
public function boolean w_valida_tab (readonly integer li_tab, readonly integer li_tab2)
public subroutine wf_g_f_e (readonly string ls_tabla)
public function boolean w_valida_yguar (readonly integer li_tab, readonly integer li_tab2)
end prototypes

event ue_post_open;// Copiar 

//Tab_1.tabpage_1.DW_1.SetTransObject(SQLCA);
//Tab_1.tabpage_2.DW_2.SetTransObject(SQLCA);
//Tab_1.tabpage_3.DW_3.SetTransObject(SQLCA);
//
//ii_vandera = 1 
//idw_proximo = Tab_1.tabpage_1.DW_1
//this.triggerevent("ue_prox_dw")

iw_this = this

end event

event ue_aceptar;long ll_update

ll_update=idw_proximo.update()
if ll_update = 1  then
	commit using sqlca;
	messagebox("Atención","¡Actualización Exitosa !")
else
	rollback using sqlca;
	messagebox("Atención","¡Error al Actualizar !")
end if



end event

event ue_valida_todo;


integer li_cont
Boolean lb_r


FOR li_cont=1 TO 3
	
	lb_r = w_valida_yguar(li_cont,li_cont)

	
NEXT














end event

event ue_cancelar;idw_d.RESET()














end event

event ue_prox_dw;// idw_proximo = datawindows solo tienes que hacer el retrieve y mandar los argumentos de tun
// datawindows ejemplo

//// elimirar esta linea


//
///// copiar esto
//
//CHOOSE CASE ii_nex_tab
//	CASE 1
//		idw_proximo.retrieve(str.g_financiero,str.empresa)
//	CASE 2
//		idw_proximo.retrieve()
//	CASE 3	
//		idw_proximo.retrieve()
//END CHOOSE
//
//


end event

event ue_reg_anterior;idw_proximo.scrollpriorrow()
end event

event ue_siguiente_reg;idw_proximo.scrollnextrow()
end event

event ue_adicionar;// Adiciona un nuevo Registro
// Adiciona un nuevo Registro

idw_proximo.scrolltorow(idw_proximo.insertrow(0))
idw_proximo.setcolumn(1)
end event

event ue_pre_aceptar;//en el padre de su respectiva aplicacion, en este mismo evento, vuelva a poner TRUE
sqlca.autocommit = false
this.postevent("ue_aceptar")
end event

event ue_eliminar;
integer codigo
if idw_proximo.rowcount() > 0 then
	
codigo =	idw_proximo.deleterow(idw_proximo.getrow())

	
else 
	messagebox("Atención","No hay registros para borrar!")
	
	
end if
end event

event ue_pre_eliminar;this.postevent("ue_eliminar")
end event

event ue_insertar;// Inserta un nuevo registro

idw_proximo.scrolltorow(idw_proximo.InsertRow(idw_proximo.getrow()))
idw_proximo.setcolumn(1)
end event

event ue_ultimo_reg;idw_proximo.scrolltorow(idw_proximo.rowcount())
end event

event ue_primer_reg;idw_proximo.scrolltorow(1)
end event

public function string wf_tab (readonly integer li_tab);// resibe el numero del tab actual
// setea el datawindows de ese tab para trabajar con el
// retorna el titulo del tab

CHOOSE CASE li_tab
	CASE 1
	   idw_d = Tab_1.tabpage_1.DW_1	

		return ("E"+Tab_1.tabpage_1.text)
		
		
	CASE 2
		idw_d = Tab_1.tabpage_2.DW_2
		
		return(Tab_1.tabpage_2.text)
		
	CASE 3	
		idw_d = Tab_1.tabpage_3.DW_3
		
		return(Tab_1.tabpage_2.text)
		
END CHOOSE
end function

public function datawindow wf_tab_prox (readonly integer li_tab);CHOOSE CASE li_tab
	CASE 1
	   return (Tab_1.tabpage_1.DW_1)
		
						
	CASE 2
		return(Tab_1.tabpage_2.DW_2)
		
				
	CASE 3	
		return(Tab_1.tabpage_3.DW_3)
				
		
END CHOOSE
end function

public subroutine wf_guarda_anterior (readonly datawindow dw_anterior);long ll_update

ll_update=dw_anterior.update()
if ll_update = 1  then
	commit using sqlca;
	messagebox("Atención","¡Actualización Exitosa !")
else
	rollback using sqlca;
	messagebox("Atención","¡Error al Actualizar !")
end if

end subroutine

public function boolean w_valida_tab (readonly integer li_tab, readonly integer li_tab2);string ls_titulo
long respuesta,ll_cont 


datawindow ldw_prox_dw

ls_titulo = wf_tab(li_tab)

idw_proximo = wf_tab_prox(li_tab2)


this.postevent('ue_prox_dw')



return(true)



	



		

	


		





end function

public subroutine wf_g_f_e (readonly string ls_tabla);idw_proximo.SetItem(idw_proximo.getrow(),ls_tabla+"_g_financiero", str.g_financiero) 
idw_proximo.SetItem(idw_proximo.getrow(),ls_tabla+"_empresa", str.empresa) 
end subroutine

public function boolean w_valida_yguar (readonly integer li_tab, readonly integer li_tab2);string ls_titulo
long respuesta,ll_cont 



dwItemStatus l_status,l_status2,l_status3


ls_titulo = wf_tab(li_tab)

idw_proximo = wf_tab_prox(li_tab2)


// Mira si el Dw del tab anterior tiene datos
// de Tenerlos mire si al cambiar de tab el Dw a sufrido modificaciones 
 IF idw_d.accepttext() = 1 THEN

	
 l_status = idw_d.GetItemStatus(idw_d.getrow(),0, Primary!)	
	
 if (l_status <> NotModified! and l_status <> new!) or idw_d.DeletedCount () <> 0 	then
	
		respuesta = MessageBox("Atención -- " + str.nombre + " " + str.apellido, &
										"No se han Salvado los Cambios." + &
										"~n~n ¿Desea Salvar Ahora?", Question!, YesNoCancel!)  
		choose case respuesta 
			case 1 
				wf_guarda_anterior(idw_d)
			case 2
				ROLLBACK using sqlca; 	
		   case 3
             return(true)
		end choose
	
	
	end if
	
END IF
 this.postevent('ue_prox_dw')



return(true)



	



		

	


		





end function

on w_grampa_tab.create
this.tab_1=create tab_1
this.Control[]={this.tab_1}
end on

on w_grampa_tab.destroy
destroy(this.tab_1)
end on

event open;This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)
str.frame.SetRedraw ( True )

This.Icon = str.icono
gf_acelerador()
THIS.postevent("UE_POST_OPEN")

end event

event closequery;this.triggerevent("ue_valida_todo")
end event

type tab_1 from tab within w_grampa_tab
int X=119
int Y=52
int Width=1842
int Height=1152
int TabOrder=1
boolean RaggedRight=true
int SelectedTab=1
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanged;
ii_nex_tab = newindex

if ii_vandera = 1 then
  w_valida_tab(oldindex,newindex)
end if





end event

type tabpage_1 from userobject within tab_1
event t1_ue_aceptar ( )
int X=18
int Y=112
int Width=1806
int Height=1024
long BackColor=79741120
string Text="none"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within tabpage_1
int X=96
int Y=248
int Width=1595
int Height=360
int TabOrder=2
boolean LiveScroll=true
end type

event dberror;// Rutina para los errores de la base de datod
// Daniel Vergara 22/07/1998


IF sqlerrtext <> "" THEN 
//	OpenWithParm (w_error,sqlerrtext)
	mensaje("Error del DataWindow: Nº" + string(sqldbcode) + " " + This.ClassName(), &
			  "Ha Ocurrido un Error al Manipular " + &
			  "la Información.    Si el Problema Persiste Comuniquese con su Administrador", + &
			  sqlerrtext)	// Herick
	gf_dberror(sqldbcode,sqlerrtext)	
	// Stop PowerBuilder from displaying the error
	RETURN 1
END IF

end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=112
int Width=1806
int Height=1024
long BackColor=79741120
string Text="none"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from datawindow within tabpage_2
int X=357
int Y=224
int Width=1147
int Height=360
int TabOrder=3
boolean LiveScroll=true
end type

event dberror;// Rutina para los errores de la base de datod
// Daniel Vergara 22/07/1998


IF sqlerrtext <> "" THEN 
//	OpenWithParm (w_error,sqlerrtext)
	mensaje("Error del DataWindow: Nº" + string(sqldbcode) + " " + This.ClassName(), &
			  "Ha Ocurrido un Error al Manipular " + &
			  "la Información.    Si el Problema Persiste Comuniquese con su Administrador", + &
			  sqlerrtext)	// Herick
	gf_dberror(sqldbcode,sqlerrtext)	
	// Stop PowerBuilder from displaying the error
	RETURN 1
END IF

end event

type tabpage_3 from userobject within tab_1
int X=18
int Y=112
int Width=1806
int Height=1024
long BackColor=79741120
string Text="none"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_3 dw_3
end type

on tabpage_3.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tabpage_3.destroy
destroy(this.dw_3)
end on

type dw_3 from datawindow within tabpage_3
int X=457
int Y=336
int Width=681
int Height=360
int TabOrder=4
boolean LiveScroll=true
end type

event dberror;// Rutina para los errores de la base de datod
// Daniel Vergara 22/07/1998


IF sqlerrtext <> "" THEN 
//	OpenWithParm (w_error,sqlerrtext)
	mensaje("Error del DataWindow: Nº" + string(sqldbcode) + " " + This.ClassName(), &
			  "Ha Ocurrido un Error al Manipular " + &
			  "la Información.    Si el Problema Persiste Comuniquese con su Administrador", + &
			  sqlerrtext)	// Herick
	gf_dberror(sqldbcode,sqlerrtext)	
	// Stop PowerBuilder from displaying the error
	RETURN 1
END IF

end event

