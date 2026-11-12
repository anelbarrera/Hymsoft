//objectcomments  
forward
global type u_animate from UserObject
end type
end forward

global type u_animate from UserObject
UserObjects ObjectType=ExternalVisual!
int Width=230
int Height=134
long BackColor=0
string ClassName="sysanimate32"
string LibraryName="comctl32.dll"
long Style=1174405122
end type
global u_animate u_animate

type prototypes
Subroutine InitCommonControls() Library 'comctl32.dll'
end prototypes

type variables
Private:
Constant UInt	WM_USER = 1024
Constant UInt	ACM_OPEN = (WM_USER+100)
Constant UInt	ACM_PLAY = (WM_USER+101)
Constant UInt	ACM_STOP = (WM_USER+102)
end variables

forward prototypes
public function long of_open (ref string as_name)
public function long of_play (unsignedinteger aui_from, unsignedinteger aui_to, unsignedinteger ai_repeat)
public function long of_stop ()
public function long of_close ()
public function long of_seek (unsignedinteger aui_frame)
end prototypes

public function long of_open (ref string as_name);Return Send(Handle(this), ACM_OPEN, 0, as_name)
end function

public function long of_play (unsignedinteger aui_from, unsignedinteger aui_to, unsignedinteger ai_repeat);Return Send(Handle(this), ACM_PLAY, ai_repeat, Long(aui_from, aui_to))
end function

public function long of_stop ();// Stops the AVI clip

Return Send(Handle(this), ACM_STOP, 0, 0)
end function

public function long of_close ();String ls_null ; SetNull(ls_null)


Return this.Of_Open(ls_null)
end function

public function long of_seek (unsignedinteger aui_frame);// Seeks a specific frame in the AVI clip and displays it.


Return this.Of_Play(aui_frame, aui_frame, 1)
end function

event constructor;// The InitCommonControls function ensures that the 
// common control dynamic-link library (DLL) is loaded.
InitCommonControls()
end event

event destructor;// I don't believe this is needed, but just for good measure.
// Close any AVI that has been previously opened.
this.Of_Close()
end event

