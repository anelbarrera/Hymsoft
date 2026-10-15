//objectcomments Usuarios del Sistema
forward
global type w_usuarios from w_fa_padre
end type
type pb_empresas from picturebutton within w_usuarios
end type
type st_1 from statictext within w_usuarios
end type
type dw_2 from datawindow within w_usuarios
end type
type pb_1 from picturebutton within w_usuarios
end type
type st_2 from statictext within w_usuarios
end type
type gb_1 from groupbox within w_usuarios
end type
end forward

global type w_usuarios from w_fa_padre
integer width = 2725
integer height = 1664
string title = "Mantenimiento de Usuarios"
string icon = "AppIcon!"
windowanimationstyle openanimation = bottomroll!
windowanimationstyle closeanimation = bottomroll!
event ue_syscommand pbm_syscommand
pb_empresas pb_empresas
st_1 st_1
dw_2 dw_2
pb_1 pb_1
st_2 st_2
gb_1 gb_1
end type
global w_usuarios w_usuarios

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

on w_usuarios.create
int iCurrent
call super::create
this.pb_empresas=create pb_empresas
this.st_1=create st_1
this.dw_2=create dw_2
this.pb_1=create pb_1
this.st_2=create st_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_empresas
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.pb_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.gb_1
end on

on w_usuarios.destroy
call super::destroy
destroy(this.pb_empresas)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.gb_1)
end on

event ue_post_open;call super::ue_post_open;long ll_recupero = 0, li_tipo_pase
string ls_identifica, ls_masca
datawindowchild ldwc_vendedores

//Valida los cargos
dw_1.settransobject(sqlca);
dw_2.settransobject(sqlca);

dw_1.getchild('usua_vendedor', ldwc_vendedores)
ldwc_vendedores.settransobject(sqlca)
ldwc_vendedores.retrieve(str.g_financiero, str.empresa)

dw_1.insertrow(1)
			
//Pone invisible el insertar	
//m_fa_padre.m_edicin.m_insertar.toolbaritemvisible=false
//m_fa_padre.m_edicin.m_insertar.visible=false

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

event close;setredraw(false)
if isvalid(this) then close(this)
w_hs_frame.Post Event ue_evaluar_panel_acciones()
end event

event ue_hay_data;//Override
end event

event resize;call super::resize;dw_1.Resize(This.Width - 170, This.Height - 330)
gb_1.width  = this.width  - 63
gb_1.height = this.height - 220
st_nom_ventana.x = 28
st_nom_ventana.y = this.height - 180
end event

event open;//override
//gf_center_win(This)
gf_acelerador()
dw = dw_1
This.SetToolbar(1,true,AlignatTop!)
This.SetToolbarPos(1,1,50,false)
sqlca.autocommit = true
This.Icon = str.icono
this.y = 0
this.x = 805
this.postevent("ue_post_open")

//m_fa_principal.m_edicin.m_primerregistro.toolbaritemvisible= false
//m_fa_principal.m_edicin.m_registroanterior.toolbaritemvisible= false
//m_fa_principal.m_edicin.m_siguienteregistro.toolbaritemvisible= false
//m_fa_principal.m_edicin.m_ultimoregistro.toolbaritemvisible= false
//m_fa_principal.m_archivo.m_imprimir.toolbaritemvisible= false

w_hs_frame.Post Event ue_evaluar_panel_acciones()
end event

event ue_aceptar;//override
string ls_user
integer li_encontro
if dw_1.update() = -1 then
	gf_mensaje('','Error al actualizar '+sqlca.sqlerrtext,1,1,'E')
end if

	ls_user = dw_1.getitemstring(dw_1.getrow(),'usua_id')
	select count(*) into :li_encontro
	from usuarios_accesos where priv_g_financiero = :str.g_financiero and
										   priv_empresa 	  = :str.empresa and
										   priv_usuario 		  = :ls_user;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al validar existencia de accesos '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
	if li_encontro = 0 then
		  INSERT INTO usuarios_accesos  
					( priv_g_financiero,   
					  priv_empresa,   
					  priv_usuario    )  
		  VALUES ( :str.g_financiero,   
					  :str.empresa,   
					  :ls_user )  ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al insertar accesos '+sqlca.sqlerrtext,1,1,'E')
				return
			end if

	end if
end event

event closequery;call super::closequery;setredraw(false)
end event

type st_nom_ventana from w_fa_padre`st_nom_ventana within w_usuarios
boolean visible = false
integer y = 1264
integer width = 1147
integer taborder = 20
end type

type dw_1 from w_fa_padre`dw_1 within w_usuarios
event ue_escape pbm_dwescape
integer x = 14
integer y = 72
integer width = 2555
integer height = 1408
integer taborder = 10
string dataobject = "dw_usuarios"
boolean hscrollbar = true
end type

event dw_1::ue_escape;call super::ue_escape;////Codigo de Escape
//close(parent)
////parent.triggerevent("closequery")
////messagebox("Escape","Entro ...")
end event

event dw_1::itemchanged;call super::itemchanged;//Para que al momento de seleccionar un cargo fijo, setear NO al porcentaje y a nivel del
//campo en el DW, se proteje el campo


string ls_col, ls_usuario
this.accepttext()
ls_col = this.getcolumnname()
if ls_col = 'usua_id' then
	ls_usuario = this.getitemstring(1,'usua_id')
	if this.retrieve(ls_usuario) = 0 then
		this.insertrow(1)
		this.setitem(1,'usua_id',ls_usuario)
	end if
end if


end event

event dw_1::ue_tabfinal;call super::ue_tabfinal;this.setcolumn(2)
end event

event dw_1::ue_microayuda;//override
end event

event dw_1::buttonclicked;call super::buttonclicked;integer li_encontro
string ls_user

if dwo.name = 'b_cerrar' then
	if this.update() = -1 then
		gf_mensaje('','Error al actualizar '+sqlca.sqlerrtext,1,1,'E')
	end if
	close(parent)
elseif dwo.name = 'b_eliminar' then
	ls_user = this.getitemstring(1,'usua_id')
	if gf_mensaje('','Esta Seguro de Eliminar el Usuario'+ls_user+' ?',2,1,'Q') = 2 then return

		 sqlca.autocommit = false

		  DELETE FROM usuarios_accesos  
		WHERE ( usuarios_accesos.priv_g_financiero = :str.g_financiero ) AND  
				( usuarios_accesos.priv_empresa = :str.empresa ) AND  
				( usuarios_accesos.priv_usuario = :ls_user )   ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al eliminar accesos '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true				
				return
			end if

		this.deleterow(1)
		
		if this.update() = -1 then
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al eliminar usuario '+sqlca.sqlerrtext,1,1,'E')
				rollback;
				sqlca.autocommit = true
				return
			end if
		else
			this.insertrow(1)			
		end if
		commit;
		sqlca.autocommit = true

elseif dwo.name = 'b_grabar' then
	if dw_1.update() = -1 then
		gf_mensaje('','Error al Actualizar '+sqlca.sqlerrtext,1,1,'E')
	end if
	
	ls_user = dw_1.getitemstring(dw_1.getrow(),'usua_id')
	select count(*) into :li_encontro
	from usuarios_accesos where priv_g_financiero = :str.g_financiero and
										   priv_empresa 	  = :str.empresa and
										   priv_usuario 		  = :ls_user;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al validar existencia de accesos '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
	if li_encontro = 0 then
		  INSERT INTO usuarios_accesos  
					( priv_g_financiero,   
					  priv_empresa,   
					  priv_usuario    )  
		  VALUES ( :str.g_financiero,   
					  :str.empresa,   
					  :ls_user )  ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al insertar accesos '+sqlca.sqlerrtext,1,1,'E')
				return
			end if

	end if
elseif dwo.name = 'b_buscar' then
	
		//
	String  ls_find,ls_codigo
	integer li_c, li_b
	long    ll_lter
	string  ls_lter,ls_des
	
	Datawindow        dww
	str_dg_dynamic_find	lstr_df
	
		lstr_df.texto_campo [1,1] = "usuarios.usua_nombre"
		lstr_df.texto_campo [1,2] = "Nombre"
		lstr_df.texto_campo [1,3] = ""
		lstr_df.texto_campo [1,4] = 'V'
		lstr_df.texto_campo [1,5] = '780'	
		lstr_df.texto_campo [2,1] = "usuarios.usua_id"
		lstr_df.texto_campo [2,2] = "Usuario"
		lstr_df.texto_campo [2,3] = "usua_id"
		lstr_df.texto_campo [2,4] = 'V'
		lstr_df.texto_campo [2,5] = '280'
		lstr_df.texto_campo [3,1] = "usuarios.usua_estado"
		lstr_df.texto_campo [3,2] = "Estado"
		lstr_df.texto_campo [3,3] = ""
		lstr_df.texto_campo [3,4] = 'V'
		lstr_df.texto_campo [3,5] = '285'
		lstr_df.tabla = " usuarios  "
			
		lstr_df.tabla_where = ""
	
		OpenWithParm(w_dg_a_custom_find, lstr_df)
		ls_find = Message.StringParm
	
		If len (ls_find) = 0 Then Return
			
		ls_codigo =  String(Right ( ls_find, Len (ls_find) - Pos (ls_find, "=") ))
		gf_replace_cadena(ls_codigo,"'"," ")
		ls_codigo = Trim(ls_codigo)
		this.setitem(1,'usua_id',ls_codigo)
		this.setcolumn('usua_id')
		this.triggerevent('itemchanged')
	
end if
end event

type st_ayuda from w_fa_padre`st_ayuda within w_usuarios
end type

type pb_empresas from picturebutton within w_usuarios
integer x = 1957
integer y = 104
integer width = 183
integer height = 160
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = ".\Art\Banco_Sucur.bmp"
alignment htextalign = left!
string powertiptext = "Empresas para el usuario"
end type

event clicked;integer li_grupo, li_empre, i, li_encontro
string ls_empresa, ls_usuario, ls_find

ls_usuario = dw_1.getitemstring(dw_1.getrow(),'usua_id')

  SELECT isnull(count(*)  ,0)
    INTO :li_encontro  
    FROM usuarios  
   WHERE usuarios.usua_id = :ls_usuario   ;

if li_encontro = 0 then return

dw_2.reset()

ls_usuario = dw_1.getitemstring(dw_1.getrow(),'usua_id')

 DECLARE cur_empre CURSOR FOR  
  SELECT dgmempre.empr_g_financiero,   
         dgmempre.empr_empresa,   
         dgmempre.empr_razon_social  
    FROM dgmempre  
   WHERE dgmempre.empr_estado = 'A' ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','Error al declarar cursor '+sqlca.sqlerrtext,1,1,'E')
		return
	end if

	open cur_empre;
	
	fetch cur_empre into :li_grupo, :li_empre, :ls_empresa;

	do while sqlca.sqlcode = 0
		
		i = dw_2.insertrow(0)
		
		dw_2.setitem(i,'emus_g_financiero',li_grupo)
		dw_2.setitem(i,'emus_empresa',li_empre)
		dw_2.setitem(i,'nombre',ls_empresa)
		
		fetch cur_empre into :li_grupo, :li_empre, :ls_empresa;
			
	loop

	close cur_empre;

 DECLARE cur_users CURSOR FOR  
  SELECT empresas_usuario.emus_g_financiero,   
         empresas_usuario.emus_empresa  
    FROM empresas_usuario  
   WHERE empresas_usuario.emus_usuario = :ls_usuario ;
	if sqlca.sqlcode = -1 then
		gf_mensaje('','',1,1,'E')
		return
	end if

	open cur_users;
	
	fetch cur_users into :li_grupo, :li_empre ;
	
	do while sqlca.sqlcode = 0
		
		ls_find = 'emus_g_financiero = '+string(li_grupo)+ ' and emus_empresa = '+string(li_empre)
		
		li_encontro = dw_2.find(ls_find,1,dw_2.rowcount())
		
		if li_encontro > 0 then
			dw_2.setitem(li_encontro,'incluir',1)
		end if
		
		fetch cur_users into :li_grupo, :li_empre ;
	loop

	close cur_users;
	
dw_2.visible = true
end event

type st_1 from statictext within w_usuarios
integer x = 1842
integer y = 260
integer width = 402
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long textcolor = 33554432
long backcolor = 12639424
string text = "Empresas"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_usuarios
boolean visible = false
integer x = 1239
integer y = 368
integer width = 1262
integer height = 744
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Empresas para el Usuario"
string dataobject = "dw_empresas_usuario"
boolean border = false
boolean livescroll = true
end type

event buttonclicked;string ls_user
integer i, li_grupo, li_empre
if dwo.name = 'b_cancelar' then
	this.visible = false
	dw_1.setfocus()
elseif dwo.name = 'b_aceptar' then
	
	ls_user = dw_1.getitemstring(dw_1.getrow(),'usua_id')
	
  DELETE FROM empresas_usuario  
   WHERE empresas_usuario.emus_usuario = :ls_user  ;
		if sqlca.sqlcode = -1 then
			gf_mensaje('','Error al Eliminar '+sqlca.sqlerrtext,1,1,'E')
		end if
	
	for i = 1 to dw_2.rowcount()
		if dw_2.getitemnumber(i,'incluir') = 1 then
			li_grupo = dw_2.getitemnumber(i,'emus_g_financiero')
			li_empre = dw_2.getitemnumber(i,'emus_empresa')
			  INSERT INTO empresas_usuario  
						( emus_g_financiero,   
						  emus_empresa,   
						  emus_usuario )  
			  VALUES ( :li_grupo,   
						  :li_empre,   
						  :ls_user )  ;
				if sqlca.sqlcode = -1 then
					gf_mensaje('','Error al Insertar '+sqlca.sqlerrtext,1,1,'E')
				end if
			
		end if
	next
	this.visible = false	
	dw_1.setfocus()
end if
end event

type pb_1 from picturebutton within w_usuarios
integer x = 2290
integer y = 128
integer width = 110
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "CreateForeignKey!"
alignment htextalign = left!
string powertiptext = "Privilegios de acceso..."
end type

event clicked;string ls_user
integer li_encontro

ls_user = dw_1.getitemstring(dw_1.getrow(),'usua_id')

  SELECT isnull(count(*)  ,0)
    INTO :li_encontro  
    FROM usuarios  
   WHERE usuarios.usua_id = :ls_user   ;

if li_encontro = 0 then return

	select count(*) into :li_encontro
	from usuarios_accesos where priv_g_financiero = :str.g_financiero and
										   priv_empresa 	  = :str.empresa and
										   priv_usuario 		  = :ls_user;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al validar existencia de accesos '+sqlca.sqlerrtext,1,1,'E')
				return
			end if
	if li_encontro = 0 then
		  INSERT INTO usuarios_accesos  
					( priv_g_financiero,   
					  priv_empresa,   
					  priv_usuario    )  
		  VALUES ( :str.g_financiero,   
					  :str.empresa,   
					  :ls_user )  ;
			if sqlca.sqlcode = -1 then
				gf_mensaje('','Error al insertar accesos '+sqlca.sqlerrtext,1,1,'E')
				return
			end if

	end if


OpenSheetwithparm(w_asignar_privilegios_de_acceso,ls_user,w_fa_fondo,2, Original!)
end event

type st_2 from statictext within w_usuarios
integer x = 2213
integer y = 224
integer width = 274
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long textcolor = 33554432
long backcolor = 12639424
string text = "Accesos"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_usuarios
integer x = 5
integer y = 16
integer width = 2610
integer height = 1500
integer taborder = 50
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79416533
end type

