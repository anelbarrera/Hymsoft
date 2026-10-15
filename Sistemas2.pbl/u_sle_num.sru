//objectcomments Base SingleLineEdit ancestor
forward
global type u_sle_num from u_slea
end type
end forward

global type u_sle_num from u_slea
end type
global u_sle_num u_sle_num

event we_char;call super::we_char;// Reject any characters other than '0' thru '9' or BackSpace

IF (message.wordparm < Asc ("0") OR &
	 message.wordparm > Asc ("9")) AND &
	(message.wordparm <> 8) THEN
	Beep(1)
	message.processed = TRUE
END IF
end event

