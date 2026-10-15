//objectcomments RadioButton ancestor
forward
global type u_rba from radiobutton
end type
end forward

global type u_rba from radiobutton
int Width=247
int Height=73
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
event we_nchittest pbm_nchittest
end type
global u_rba u_rba

type variables
PROTECTED:

String i_s_microhelp	// Default MicroHelp for Object focus
String i_s_helpkey		// Default key into Help file
end variables

forward prototypes
public subroutine fu_set_microhelp (string a_s_microhelp)
public subroutine fu_set_helpkey (string a_s_helpkey)
public function string fu_get_microhelp ()
public function string fu_get_helpkey ()
end prototypes

event we_nchittest;// Set microhelp

IF IsValid (str.frame) THEN
	str.frame.SetMicrohelp(this.fu_get_microhelp ())
END IF

end event

public subroutine fu_set_microhelp (string a_s_microhelp);// Set value of instance variable to value passed.

i_s_microhelp = a_s_microhelp
end subroutine

public subroutine fu_set_helpkey (string a_s_helpkey);// Set value of instance variable to value passed.

i_s_helpkey = a_s_helpkey
end subroutine

public function string fu_get_microhelp ();// Return value of instance variable.

RETURN i_s_microhelp
end function

public function string fu_get_helpkey ();// Return value of instance variable.

RETURN i_s_helpkey
end function

