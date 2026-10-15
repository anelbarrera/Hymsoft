//objectcomments MultiLineEdit ancestor.
forward
global type u_mlea from multilineedit
end type
end forward

global type u_mlea from multilineedit
int Width=490
int Height=357
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
event we_keydown pbm_keydown
event we_keyup pbm_keyup
event we_lbuttonup pbm_lbuttonup
event we_nchittest pbm_nchittest
event we_char pbm_char
event ue_postchar pbm_custom01
event ue_setpos pbm_custom02
event ue_undo pbm_custom03
event ue_cut pbm_custom04
event ue_copy pbm_custom05
event ue_paste pbm_custom06
event ue_clear pbm_custom07
event ue_selectall pbm_custom08
event ue_reserved4powertool pbm_custom15
end type
global u_mlea u_mlea

type variables
PROTECTED:

Boolean i_b_autoselect	// Indicates whether text is selected automatically
Boolean i_b_modified	// Indicates the text has been modified

Integer i_i_cur_pos		// Current position (offset) of the cursor
Integer i_i_line_num	// Line number where cursor is located
Integer i_i_col_num		// Column number where cursor is located

String i_s_microhelp	// Default MicroHelp for Object focus
String i_s_helpkey		// Default key into Help file
end variables

forward prototypes
public function boolean fu_modified ()
public function boolean fu_set_autoselect (boolean a_b_autoselect)
public function boolean fu_get_autoselect ()
public function boolean fu_reset_modified ()
public subroutine fu_scroll_to_line (int a_i_line_num)
public subroutine fu_set_microhelp (string a_s_microhelp)
public subroutine fu_set_helpkey (string a_s_helpkey)
public function string fu_get_microhelp ()
public function string fu_get_helpkey ()
public subroutine fu_select_all ()
end prototypes

on we_keydown;// The Delete key does not trigger the Char event.

IF KeyDown (keyDelete!) THEN
	this.TriggerEvent ("we_char")
END IF
end on

on we_keyup;this.TriggerEvent ("ue_setpos")
end on

on we_lbuttonup;this.TriggerEvent ("ue_setpos")
end on

event we_nchittest;// Set microhelp

IF IsValid (str.frame) THEN
	str.frame.SetMicrohelp(this.fu_get_microhelp ())
END IF

end event

on we_char;// MLE may contain a maximum of 32000 characters

IF Len (this.text) > 32000 THEN
	IF NOT KeyDown (keyBack!) AND &
		NOT KeyDown (keyDelete!) THEN
		Beep (1)
		message.processed = TRUE
		Return
	END IF
END IF


this.PostEvent ("ue_postchar")
end on

on ue_postchar;i_b_modified = TRUE

this.TriggerEvent ("ue_setpos")
end on

on ue_setpos;// Get the current position (offset) and line of the cursor.  The
// column can be retrieved by subtracting the offset of the start
// of the line (from an SDK call) from the cursor offset.

UnsignedInteger EM_LINEINDEX = 1035


i_i_cur_pos = this.Position ()

i_i_line_num = this.SelectedLine ()

i_i_col_num = i_i_cur_pos - Send (Handle (this), EM_LINEINDEX, &
											i_i_line_num - 1, 0)
end on

on ue_undo;IF NOT this.CanUndo () THEN
	Beep (1)
	Return
END IF


IF this.displayonly THEN
	Beep (1)
	Return
END IF


this.Undo ()

i_b_modified = TRUE

this.SetFocus ()
end on

on ue_cut;IF this.displayonly THEN
	Beep (1)
	Return
END IF


this.Cut ()

i_b_modified = TRUE

this.SetFocus ()
end on

on ue_copy;this.Copy ()

this.SetFocus ()
end on

on ue_paste;IF Len (Clipboard ()) = 0 THEN
	Beep (1)
	Return
END IF


IF this.displayonly THEN
	Beep (1)
	Return
END IF


// MLE may contain a maximum of 32000 characters

IF Len (this.text) + Len (Clipboard ()) > 32000 THEN
	Beep (1)
	Return
END IF


this.Paste ()

i_b_modified = TRUE

this.TriggerEvent ("ue_setpos")

this.SetFocus ()
end on

on ue_clear;IF this.displayonly THEN
	Beep (1)
	Return
END IF


this.Clear ()

i_b_modified = TRUE

this.SetFocus ()
end on

on ue_selectall;this.SelectText (1, Len (this.text))

this.SetFocus ()
end on

public function boolean fu_modified ();// Return value of instance variable.

Return i_b_modified
end function

public function boolean fu_set_autoselect (boolean a_b_autoselect);Boolean b_return


b_return = i_b_autoselect

i_b_autoselect = a_b_autoselect

Return b_return
end function

public function boolean fu_get_autoselect ();Return i_b_autoselect
end function

public function boolean fu_reset_modified ();Boolean b_cur_value


b_cur_value = i_b_modified

i_b_modified = FALSE

Return b_cur_value
end function

public subroutine fu_scroll_to_line (int a_i_line_num);// Scroll such that the intended line is at the top of the display.

// First scroll to the top of the display.

this.Scroll (0 - this.LineCount ())


// Then scroll to the intended line.

this.Scroll (a_i_line_num)
end subroutine

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

public subroutine fu_select_all ();// Select all the text in the MLE.

this.SelectText(1, Len (this.text))
end subroutine

on getfocus;// Select text if autoselect = TRUE.

IF i_b_autoselect THEN
	this.SelectText (1, Len (this.text))
END IF
end on

