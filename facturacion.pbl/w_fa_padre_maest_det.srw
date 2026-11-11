//objectcomments Padre de las ventanas de Encabezado Detalle
forward
global type w_fa_padre_maest_det from w_granpa_maest_det
end type
end forward

global type w_fa_padre_maest_det from w_granpa_maest_det
long BackColor=79416533
end type
global w_fa_padre_maest_det w_fa_padre_maest_det

on w_fa_padre_maest_det.create
call super::create
end on

on w_fa_padre_maest_det.destroy
call super::destroy
end on

event ue_post_open;call super::ue_post_open;gf_fa_pro_servi()
end event

event key;if Key = KeyEscape! then
	this.Postevent("close")
end if
end event

event close;if isvalid(this) then close(this)
end event

type st_3 from w_granpa_maest_det`st_3 within w_fa_padre_maest_det
long BackColor=79416533
FontCharSet FontCharSet=Ansi!
end type

type gb_2 from w_granpa_maest_det`gb_2 within w_fa_padre_maest_det
long BackColor=79416533
FontCharSet FontCharSet=Ansi!
end type

type gb_1 from w_granpa_maest_det`gb_1 within w_fa_padre_maest_det
long BackColor=79416533
FontCharSet FontCharSet=Ansi!
end type

