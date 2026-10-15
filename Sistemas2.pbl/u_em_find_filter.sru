//objectcomments ancestro que busca y filtra
forward
global type u_em_find_filter from u_ema
end type
end forward

global type u_em_find_filter from u_ema
event we_keydown pbm_keydown
event we_char pbm_char
event ue_postchar pbm_custom01
end type
global u_em_find_filter u_em_find_filter

forward prototypes
public subroutine uf_change_mask (string as_mask_type, string as_mask)
end prototypes

event we_char;call super::we_char;// The Char event is triggered before the character is added to the text

PostEvent ("ue_postchar")
end event

event ue_postchar;call super::ue_postchar;If Len(Trim(this.text)) > 0 Then
	Parent.TriggerEvent("ue_find")
Else
	Parent.TriggerEvent("ue_restaurar")
End If
end event

public subroutine uf_change_mask (string as_mask_type, string as_mask);//CHOOSE CASE Upper(as_mask_type)
//	CASE "DATE"
//		this.MaskDataType = DateMask!
//	CASE "DATETIME"
//		this.MaskDataType = DateTimeMask!
//	CASE "DECIMAL"
//		this.MaskDataType = DecimalMask!
//	CASE "NUMERIC"
//		this.MaskDataType = NumericMask!
//	CASE "STRING"
//		this.MaskDataType = StringMask!
//	CASE "TIME"
//		this.MaskDataType = TimeMask!
//END CHOOSE

//this.mask = as_mask
end subroutine

