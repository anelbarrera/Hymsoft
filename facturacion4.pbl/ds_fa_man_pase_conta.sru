//objectcomments Utilizado para Almacenar Temporalmente la Información de los DW que se Pasarán a Contabilidad. (Cargos, Regiones, Encabezado y Detalle de Transacciones a Pasar, etc.)
forward
global type ds_fa_man_pase_conta from datastore
end type
end forward

global type ds_fa_man_pase_conta from datastore
end type
global ds_fa_man_pase_conta ds_fa_man_pase_conta

event dberror;gf_mensaje("","Error al Actualizar el DataStore "+sqlerrtext,1,1,"E")

end event

on ds_fa_man_pase_conta.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on ds_fa_man_pase_conta.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

