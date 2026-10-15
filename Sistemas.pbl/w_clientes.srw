//objectcomments Clientes
forward
global type w_clientes from w_fa_padre
end type
type gb_1 from groupbox within w_clientes
end type
end forward

global type w_clientes from w_fa_padre
integer width = 2725
integer height = 1332
string title = "Mantenimiento de Clientes"
string icon = "AppIcon!"
event ue_syscommand pbm_syscommand
gb_1 gb_1
end type
global w_clientes w_clientes

type variables

end variables

forward prototypes
public function integer wf_max_cargo ()
end prototypes

event ue_syscommand;call super::ue_syscommand;if commandtype = 61536 then
	close(this)
end if
end event

public function integer wf_max_cargo ();Long li_secuen
  SELECT max(isnull(convert(numeric(10,0),clientes.codigo_cliente),0) )
    INTO :li_secuen  
    FROM clientes
	 WHERE ( clientes.grupo = :str.g_financiero ) AND  
         ( clientes.empresa = :str.empresa )   ;
			
		if sqlca.sqlcode = -1 then
			mensaje("Información","Error al Seleccionar un máximo en la tabla clientes",sqlca.sqlerrtext)
			return -1
		end if						

if isnull(li_secuen) then li_secuen = 0 

return li_secuen + 1
end function

on w_clientes.create
int iCurrent
call super::create
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
end on

on w_clientes.destroy
call super::destroy
destroy(this.gb_1)
end on

event ue_post_open;call super::ue_post_open;long ll_recupero = 0, li_tipo_pase
string ls_identifica, ls_masca

//Valida los cargos
dw_1.settransobject(sqlca);

dw_1.retrieve(str.g_financiero, str.empresa)
			
//Pone invisible el insertar	
//m_fa_padre.m_edicin.m_insertar.toolbaritemvisible=false
//m_fa_padre.m_edicin.m_insertar.visible=false

this.x = 805
end event

event ue_pre_aceptar;//Override
long ll_cargo = 0

//Si no se le ha asignado el codigo de cargo, busca el ultimo y lo asigna
dw_1.Accepttext()

//if dw_1.getitemstring(dw_1.getrow(),"codigo_estado") = '' or isnull(dw_1.getitemstring(dw_1.getrow(),"codigo_estado")) then
//	SELECT max(faacargo.carg_cargo)
//    INTO :ll_cargo
//    FROM faacargo
//	 WHERE ( faacargo.carg_g_financiero = :str.g_financiero ) AND
//         ( faacargo.carg_empresa = :str.empresa );
//	
//	 dw_1.Setitem(dw_1.getrow(),"carg_cargo", ll_cargo + 1)
//	 gf_mensaje("","El Código del Estado no puede estar en blanco, Verifique",1,1,"E")
//	 return
//end if

this.postevent("ue_aceptar")
yield()
end event

event ue_adicionar;//Override
string  ls_descrip
String ls_cargo

if dw_1.rowcount() = 0 then
	dw_1.InsertRow(0)
//	dw_1.SetItem(dw_1.Getrow(),"codigo_cliente", string(wf_max_cargo()))
	dw_1.Setcolumn(1)	
	//Seteo del grupo y la empresa en la linea que esta inserta por default
	dw_1.SetItem(dw_1.getrow(),"prod_empresa",str.empresa) 
	dw_1.SetItem(dw_1.getrow(),"prod_g_financiero",str.g_financiero) 	
else
	//ls_cargo   = dw_1.getitemString(dw_1.rowcount(),"codigo_estado")
	//ls_descrip = dw_1.getitemString(dw_1.rowcount(),"nombre_estado")
	
	//if ls_cargo = "" or isnull(ls_cargo) or ls_descrip = "  " or isnull(ls_descrip) then 
	//	gf_mensaje("","Debe Llenar el Registro Actual para Adicionar Otros",1,1,"E")
	//	return
	//else
//		dw.scrolltorow(dw.insertrow(0))		
//		if dw_1.getitemnumber(dw_1.getrow(),"empresa") = 0 or isnull(dw_1.getitemnumber(dw_1.getrow(),"empresa")) then	
//			//Seteo el Grupo y Empresa de la linea que se inserta
//			//gf_setea_grupo_empresa(dw_1,"")	
//			dw_1.SetItem(dw_1.getrow(),"empresa",str.empresa)
//			
//	//		mensaje("Aviso","Entró","")
//			dw_1.setitemstatus(dw_1.getrow(),0,Primary!,NotModified!)
//		end if		
//		
//		if dw_1.deletedcount() = 0 then dw_1.SetItem(dw_1.Getrow(),"codigo_estado", string(wf_max_cargo()))
		dw_1.setitemstatus(dw_1.getrow(),0,Primary!,NotModified!)
		dw_1.Setcolumn(1)
//	end if
end if	

end event

event ue_eliminar;//Override
long ll_count
String ls_codigo

if dw.rowcount() > 0 then
	ls_codigo = dw_1.getitemString(dw_1.getrow(),'prod_producto')	
	dw.deleterow(dw.getrow())
	
	if dw_1.rowcount() = 0 then 
		dw_1.insertrow(0)
//	if dw_1.deletedcount() = 0 then	dw_1.SetItem(dw_1.Getrow(),"codigo_cliente", string(wf_max_cargo()))
		dw_1.Setcolumn(1)		
	end if
else 
	messagebox("Atención","No hay registros para borrar!")
end if

end event

event key;//override
end event

event close;if isvalid(this) then close(this)
end event

event ue_hay_data;//Override
end event

event resize;call super::resize;dw_1.Resize(This.Width - 170, This.Height - 330)
gb_1.width  = this.width  - 63
gb_1.height = this.height - 220
st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180
end event

event open;call super::open;//THIS.X = 1
//THIS.Y = 1
//m_fa_principal.m_edicin.m_primerregistro.toolbaritemvisible= false
//m_fa_principal.m_edicin.m_registroanterior.toolbaritemvisible= false
//m_fa_principal.m_edicin.m_siguienteregistro.toolbaritemvisible= false
//m_fa_principal.m_edicin.m_ultimoregistro.toolbaritemvisible= false
//m_fa_principal.m_archivo.m_imprimir.toolbaritemvisible= false
end event

event ue_aceptar;//override
integer i
for i = 1 to dw_1.rowcount()
	dw_1.setitem(i,'prod_g_financiero', str.g_financiero)
	dw_1.setitem(i,'prod_empresa', str.empresa)
next
if dw_1.update() = -1 then
	gf_mensaje('','Error al actualizar '+sqlca.sqlerrtext,1,1,'E')
end if

end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_clientes
boolean visible = false
integer y = 1264
integer width = 1147
integer taborder = 20
end type

type dw_1 from w_fa_padre`dw_1 within w_clientes
event ue_escape pbm_dwescape
integer x = 14
integer y = 72
integer width = 2555
integer height = 1044
integer taborder = 10
string dataobject = "dw_clientes"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::ue_escape;call super::ue_escape;////Codigo de Escape
//close(parent)
////parent.triggerevent("closequery")
////messagebox("Escape","Entro ...")
end event

event dw_1::itemchanged;call super::itemchanged;//Para que al momento de seleccionar un cargo fijo, setear NO al porcentaje y a nivel del
//campo en el DW, se proteje el campo


string ls_col
this.accepttext()
//w_colores.triggerevent("ue_pre_aceptar")


end event

event dw_1::ue_tabfinal;call super::ue_tabfinal;this.setcolumn(2)
end event

event dw_1::ue_microayuda;//override
end event

event dw_1::buttonclicked;call super::buttonclicked;integer i
if dwo.name = 'b_cerrar' then
	if this.update() = -1 then
		gf_mensaje('','Error al actualizar '+sqlca.sqlerrtext,1,1,'E')
	end if
	close(parent)
end if
end event

type st_ayuda from w_fa_padre`st_ayuda within w_clientes
end type

type gb_1 from groupbox within w_clientes
integer x = 5
integer y = 16
integer width = 2610
integer height = 1148
integer taborder = 50
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79416533
end type

