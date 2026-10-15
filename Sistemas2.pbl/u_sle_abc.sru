//objectcomments Base SingleLineEdit ancestor
forward
global type u_sle_abc from u_slea
end type
end forward

global type u_sle_abc from u_slea
end type
global u_sle_abc u_sle_abc

event we_char;call super::we_char;IF (message.wordparm >= Asc ("[") AND &
	message.wordparm <= Asc ("`")) THEN
	Beep(1)
	message.processed = TRUE
ELSEIF (message.wordparm < Asc ("A") OR &
	 message.wordparm > Asc ("z")) AND &
	(message.wordparm <> 8) THEN
	Beep(1)
	message.processed = TRUE
END IF
end event

