//objectcomments PFC Informational attributes
forward
global type n_cst_infoattrib from nonvisualobject
end type
end forward

global type n_cst_infoattrib from nonvisualobject autoinstantiate
end type
global n_cst_infoattrib n_cst_infoattrib

type variables
Public:

string	is_name
string	is_description

end variables

on n_cst_infoattrib.create
TriggerEvent( this, "constructor" )
end on

on n_cst_infoattrib.destroy
TriggerEvent( this, "destructor" )
end on

