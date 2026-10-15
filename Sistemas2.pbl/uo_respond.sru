forward
global type uo_respond from nonvisualobject
end type
end forward

global type uo_respond from nonvisualobject
end type
global uo_respond uo_respond

type prototypes
function long GetWindowLongA ( long hWindow, integer nIndex ) &
                                                                                         library 'User32.DLL'
function long SetWindowLongA ( long hWindow, integer nIndex, &
                                                           long dwNewLong )library 'User32.DLL'
end prototypes

forward prototypes
public subroutine uf_help (long al_handle)
end prototypes

public subroutine uf_help (long al_handle);// Herick 2/10/98


integer li_return
long ll_GWL_EXStyle

constant integer ici_GWL_EXStyle = -20 
constant integer ici_GWL_ID = -12 
constant long icl_WS_EX_ContextHelp = 1024 //0x00000400L

//al_handle = getcapture()

ll_GWL_EXStyle = GetWindowLongA ( al_handle, -20)

//messagebox("Open EXSTYLE",string(ll_gwl_exstyle))

ll_GWL_EXStyle += icl_WS_EX_ContextHelp

//messagebox("Open EXSTYLE + CONTEXHELP",string(ll_gwl_exstyle))

SetWindowLongA ( al_handle, ici_GWL_EXStyle, ll_GWL_EXStyle )
end subroutine

on uo_respond.create
TriggerEvent( this, "constructor" )
end on

on uo_respond.destroy
TriggerEvent( this, "destructor" )
end on

