//objectcomments Ancestro que busca y filtra
forward
global type u_sle_find_filter from u_slea
end type
end forward

global type u_sle_find_filter from u_slea
end type
global u_sle_find_filter u_sle_find_filter

event ue_postchar;call super::ue_postchar;If Len(Trim(this.text)) > 0 Then
	Parent.TriggerEvent("ue_find")
Else
	Parent.TriggerEvent("ue_restaurar")
End If
end event

