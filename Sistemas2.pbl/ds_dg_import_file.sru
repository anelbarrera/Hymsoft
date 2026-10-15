//objectcomments DS utilizado para Importar los Datos Iniciales del Sistema
forward
global type ds_dg_import_file from datastore
end type
end forward

global type ds_dg_import_file from datastore
end type
global ds_dg_import_file ds_dg_import_file

on ds_dg_import_file.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on ds_dg_import_file.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

event dberror;gf_mensaje("","Error al Actualizar "+sqlerrtext,1,1,"E")
end event

