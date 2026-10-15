forward
global type n_cst_calendarattrib from nonvisualobject
end type
end forward

global type n_cst_calendarattrib from nonvisualobject autoinstantiate
end type

type variables
Public:

boolean 	ib_dropdown = False
end variables

on n_cst_calendarattrib.create
TriggerEvent( this, "constructor" )
end on

on n_cst_calendarattrib.destroy
TriggerEvent( this, "destructor" )
end on

