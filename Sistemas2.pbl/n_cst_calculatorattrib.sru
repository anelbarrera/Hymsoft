forward
global type n_cst_calculatorattrib from nonvisualobject
end type
end forward

global type n_cst_calculatorattrib from nonvisualobject autoinstantiate
end type

type variables
Public:

boolean 	ib_dropdown = False
end variables

on n_cst_calculatorattrib.create
TriggerEvent( this, "constructor" )
end on

on n_cst_calculatorattrib.destroy
TriggerEvent( this, "destructor" )
end on

