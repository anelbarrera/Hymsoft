//objectcomments Muestra una selección de Colores
forward
global type uo_change_color from nonvisualobject
end type
end forward

type os_ChooseColor from structure
	long		lstructsize
	unsignedlong		hwndowner
	unsignedlong		hinstance
	long		rgbresult
	blob		lpcustcolors
	long		flags
	long		lcustdata
	long		lpfnhook
	long		lptemplatename
end type

global type uo_change_color from nonvisualobject
end type
global uo_change_color uo_change_color

type prototypes
function boolean ChooseColorA( REF os_ChooseColor  lpcc ) library "comdlg32.dll" alias for "ChooseColorA;Ansi"
end prototypes

type variables
Private:
os_ChooseColor istr_ChooseColor
long il_CustomInitColors[16]
blob{64} ibl_CustomColors
end variables

forward prototypes
public function boolean of_shoosecolor (ref long al_rgbresult)
end prototypes

public function boolean of_shoosecolor (ref long al_rgbresult);boolean lb_ok

istr_ChooseColor.rgbresult = al_rgbresult

lb_ok = ChooseColorA ( istr_choosecolor )

al_rgbresult = istr_ChooseColor.rgbresult 

return lb_ok
end function

event constructor;//Herick

// inicializa la informacion choosecolor

// convierte el array default custom color a una variable blob
blobedit(ibl_customcolors,1,il_custominitcolors)

// permite apuntar los elementos de la structure a un array blob
istr_choosecolor.lpcustcolors = ibl_customcolors 

// defino el tamaño
istr_choosecolor.lStructSize = 36

// sin dueño
SetNull(istr_choosecolor.hwndOwner)

// coloco el flag
istr_choosecolor.flags = 1
end event

on uo_change_color.create
TriggerEvent( this, "constructor" )
end on

on uo_change_color.destroy
TriggerEvent( this, "destructor" )
end on

