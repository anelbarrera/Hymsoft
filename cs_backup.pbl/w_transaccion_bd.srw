forward
global type w_transaccion_bd from window
end type
type pb_3 from picturebutton within w_transaccion_bd
end type
type pb_2 from picturebutton within w_transaccion_bd
end type
type pb_1 from picturebutton within w_transaccion_bd
end type
type st_2 from statictext within w_transaccion_bd
end type
type st_info from statictext within w_transaccion_bd
end type
type sle_directorio from singlelineedit within w_transaccion_bd
end type
type st_title from statictext within w_transaccion_bd
end type
type rr_1 from roundrectangle within w_transaccion_bd
end type
type rr_2 from roundrectangle within w_transaccion_bd
end type
end forward

global type w_transaccion_bd from window
integer width = 1815
integer height = 852
boolean titlebar = true
string title = "Crear Copia de Seguridad de la Base de Datos"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 134217728
string icon = "AppIcon!"
boolean center = true
event ue_close ( )
pb_3 pb_3
pb_2 pb_2
pb_1 pb_1
st_2 st_2
st_info st_info
sle_directorio sle_directorio
st_title st_title
rr_1 rr_1
rr_2 rr_2
end type
global w_transaccion_bd w_transaccion_bd

type variables
string vis_tipo_trans//1=Backup    2=Restaurar

end variables

event ue_close();close(this)
end event

on w_transaccion_bd.create
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_1=create pb_1
this.st_2=create st_2
this.st_info=create st_info
this.sle_directorio=create sle_directorio
this.st_title=create st_title
this.rr_1=create rr_1
this.rr_2=create rr_2
this.Control[]={this.pb_3,&
this.pb_2,&
this.pb_1,&
this.st_2,&
this.st_info,&
this.sle_directorio,&
this.st_title,&
this.rr_1,&
this.rr_2}
end on

on w_transaccion_bd.destroy
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.st_info)
destroy(this.sle_directorio)
destroy(this.st_title)
destroy(this.rr_1)
destroy(this.rr_2)
end on

event open;// vis_tipo_trans = 1  --> Crear Backup
// vis_tipo_trans = 2  --> Restaurar Backup

vis_tipo_trans=message.stringparm

if vis_tipo_trans <> '1' or isnull(vis_tipo_trans) then
	vis_tipo_trans = '2'
	title='Restaurar Copia de Seguridad de la Base de Datos'
	st_title.text='Seleccionar un archivo :'
	st_info.text='Se restaurará la copia de seguridad que ud. haya seleccionado. '
	st_2.text=''
end if

sle_directorio.text = "C:\Kitras_Sys\BD\"
end event

event close;gmenu = false; f_seguridad()
if changedirectory(vgs_path_app)<>1 then halt close
end event

type pb_3 from picturebutton within w_transaccion_bd
integer x = 1522
integer y = 136
integer width = 133
integer height = 96
integer taborder = 10
integer weight = 700
string text = "..."
end type

event clicked;integer li_rpta
string ls_path,ls_filename
ls_path=vgs_path_app

if vis_tipo_trans='1' then
	li_rpta=getfolder('Seleccione un directorio',ls_path)
	
	if li_rpta=1 then
		if right(ls_path,1)='\' then
			sle_directorio.text=ls_path
		else
			sle_directorio.text=ls_path + '\'
		end if
	end if
else
	li_rpta=GetFileOpenName ('Seleccione el archivo de copia de seguridad',ls_path,ls_filename,'BAK','Copias de Seguridad (*.bak),*.bak',vgs_path_app)
	
	if li_rpta=1 then
		sle_directorio.text=ls_path		
	end if
end if
end event

type pb_2 from picturebutton within w_transaccion_bd
integer x = 91
integer y = 580
integer width = 786
integer height = 96
integer taborder = 20
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string text = "&Aceptar"
boolean default = true
end type

event clicked;/* ----------- Jancarlo coaguila Perca ------------- */
integer li_rpta, li_file_copy
string ls_sql,ls_bd,ls_name,ls_path,ls_msg, ls_path1
//ls_bd=sqlca.database
ls_bd = "CS_KITRAS"
ls_path=sle_directorio.text


if trim(ls_path)='' or isnull(ls_path) then
	if vis_tipo_trans='1' then 
		ls_msg='Seleccione el directorio de destino donde se almacenará el backup.' 
	else 
		ls_msg='Seleccione el archivo de copia de seguridad que desea restaurar.'
	end if
	messagebox('Mensaje de Usuario',ls_msg,exclamation!)
	return
end if

setpointer(hourglass!)

ls_name=ls_bd + '_' + string(today(),'dd-mm-yy') + '_' + string(now(),'hh-mm-ss') + '.bak'
SQLCA.AutoCommit=TRUE 

if vis_tipo_trans='1' then

	ls_sql="BACKUP DATABASE " + ls_bd + " TO DISK = '" + ls_path + ls_name + "' WITH FORMAT" 	

else

	if not f_connect_bd(false,'master') then
		messagebox('Proceso Denegado','El proceso no puede concluir. Por favor inténtelo mas tarde.',exclamation!)
		if not f_connect_bd(true,'') then
			halt close
		end if
		return
	else		
		ls_sql="RESTORE DATABASE " + ls_bd + " FROM DISK = '" + ls_path + "'"
	end if
end if

EXECUTE IMMEDIATE :ls_sql USING SQLCA;

if sqlca.sqlcode=0 then
	if vis_tipo_trans='1' then 
		ls_msg='El backup de la base de datos se generó satisfactoriamente. ~n~nUbicación ~t: ' + ls_path + ' ~nNombre del archivo ~t: ' + ls_name 
	else 
		ls_msg='La restauración de la base de datos se realizó sin ningún problema.'
	end if
	messagebox('Proceso Terminado',ls_msg)	
	
	
	//COPIA USB
		li_rpta=getfolder('Seleccione un directorio',ls_path1)
		
		if li_rpta=1 then
			if right(ls_path1,1)='\' then
				//sle_directorio.text=ls_path
				li_file_copy = filecopy(ls_path + ls_name, ls_path1 + ls_name)
			else
				//sle_directorio.text=ls_path + '\'
				li_file_copy = filecopy(ls_path + ls_name, ls_path1 + "\" + ls_name)
			end if
		end if
		
		if li_file_copy = 1 then
			messagebox('Atención', 'Actualización exitosa en disposito.')
		else
			messagebox('Atención', 'No se guardo archivo en USB.')
		end if
	
	//
	
	//parent.postevent('ue_close')
else
	if vis_tipo_trans='1' then 
		ls_msg='Se produjo un error al crear el backup de la base de datos. ' 
	else 
		ls_msg='Se produjo un error al restaurar la base de datos. '
	end if
	messagebox('Proceso Interrumpido. (Error Nº : ' + string(sqlca.sqldbcode) + ')',ls_msg + sqlca.sqlerrtext,exclamation!)
end if

//Volvemos a conectar la BD en caso que sea restauración
if vis_tipo_trans<>'1' then
	if not f_connect_bd(true,'') then
		halt close
		return
	end if
end if

SQLCA.AutoCommit=false
setpointer(arrow!)

/* ------------------------------------------------------- */
end event

type pb_1 from picturebutton within w_transaccion_bd
integer x = 910
integer y = 580
integer width = 786
integer height = 96
integer taborder = 30
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string text = "&Cerrar"
end type

event clicked;triggerevent(parent,'ue_close')
end event

type st_2 from statictext within w_transaccion_bd
integer x = 110
integer y = 372
integer width = 1605
integer height = 128
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 26172995
long backcolor = 134217728
string text = "El nombre del archivo tendrá la fecha y hora de su creación. Ejemplo : CS_KITRAS_03-06-14_10-02-30.bak"
boolean focusrectangle = false
end type

type st_info from statictext within w_transaccion_bd
integer x = 105
integer y = 248
integer width = 1545
integer height = 108
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 26172995
long backcolor = 134217728
string text = "Se creará un backup de la base de datos en el directorio que ud. haya seleccionado."
boolean focusrectangle = false
end type

type sle_directorio from singlelineedit within w_transaccion_bd
integer x = 110
integer y = 152
integer width = 1390
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type st_title from statictext within w_transaccion_bd
integer x = 105
integer y = 72
integer width = 763
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
long textcolor = 8388608
long backcolor = 134217728
string text = "Seleccionar un directorio :"
boolean focusrectangle = false
end type

type rr_1 from roundrectangle within w_transaccion_bd
long linecolor = 26172995
integer linethickness = 7
long fillcolor = 134217728
integer x = 46
integer y = 56
integer width = 1691
integer height = 464
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_2 from roundrectangle within w_transaccion_bd
long linecolor = 26172995
integer linethickness = 7
long fillcolor = 134217728
integer x = 46
integer y = 548
integer width = 1691
integer height = 168
integer cornerheight = 40
integer cornerwidth = 46
end type

