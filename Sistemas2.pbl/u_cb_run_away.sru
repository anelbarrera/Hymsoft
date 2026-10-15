//objectcomments This button runs away from the pointer
forward
global type u_cb_run_away from u_cba
end type
end forward

global type u_cb_run_away from u_cba
string Text="&Close"
event we_move pbm_move
event ue_place_again pbm_custom01
end type
global u_cb_run_away u_cb_run_away

type variables
Integer i_i_new_x

Integer i_i_new_y

Integer i_i_times_moved
end variables

on we_move;call u_cba::we_move;i_i_new_x = this.X
i_i_new_y = this.Y

CHOOSE CASE i_o_parent_type
CASE Window!
	IF this.X < 1 THEN
		i_i_new_x = 1
	ELSEIF this.X + this.Width > i_w_parent.Width THEN 
		i_i_new_x = i_w_parent.Width - this.Width
	END IF
	IF this.Y < 1 THEN 
		i_i_new_y = 1
	ELSEIF this.Y + this.Height + 150 > i_w_parent.Height  THEN 
		i_i_new_y = i_w_parent.Height - this.Height - 150
	END IF
CASE UserObject!
	IF this.X < 1 THEN
		i_i_new_x = 1
	ELSEIF this.X + this.Width > i_u_parent.Width THEN 
		i_i_new_x = i_u_parent.Width - this.Width
	END IF
	IF this.Y < 1 THEN 
		i_i_new_y = 1
	ELSEIF this.Y + this.Height + 150 > i_u_parent.Height  THEN 
		i_i_new_y = i_u_parent.Height - this.Height - 150
	END IF
END CHOOSE

IF this.Width > 1 THEN
	TriggerEvent ("ue_place_again")
END IF
end on

on ue_place_again;call u_cba::ue_place_again;IF this.x <> i_i_new_x THEN
	this.x = i_i_new_x
END IF

IF this.y <> i_i_new_y THEN
	this.y = i_i_new_y
END IF

i_i_times_moved = i_i_times_moved + 1

IF i_i_times_moved > 100 THEN
	this.Width = 1
	this.Height = 1
	this.Hide()
	this.Enabled = false
END IF
end on

on constructor;call u_cba::constructor;fu_setevent ("ue_close")

fu_set_microhelp ("Atrapame si puedes!")
end on

on we_nchittest;call u_cba::we_nchittest;CHOOSE CASE i_o_parent_type
CASE Window!
	IF Rand(2) - 1 = 1 THEN
		this.Move (x - Rand (i_w_parent.Width), &
						y - Rand (i_w_parent.Height))
	ELSE
		this.Move (x + Rand (i_w_parent.Width), &
						y + Rand (i_w_parent.Height))
	END IF
CASE UserObject!
	IF Rand(2) - 1 = 1 THEN
		this.Move (x - Rand (i_u_parent.Width), &
						y - Rand (i_u_parent.Height))
	ELSE
		this.Move (x + Rand (i_u_parent.Width), &
						y + Rand (i_u_parent.Height))
	END IF
END CHOOSE

this.Show ()
end on

event clicked;call super::clicked;MessageBox("Heeee!!!", "Cual es la Persecusion", Question!)
end event

