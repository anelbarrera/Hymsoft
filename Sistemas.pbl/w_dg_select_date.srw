//objectcomments Para Seleccionar la Fecha del Calendario
forward
global type w_dg_select_date from w_a
end type
type uo_1 from u_ddcal within w_dg_select_date
end type
end forward

global type w_dg_select_date from w_a
int Width=937
int Height=332
WindowType WindowType=response!
boolean TitleBar=true
string Title=""
long BackColor=12632256
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
uo_1 uo_1
end type
global w_dg_select_date w_dg_select_date

type prototypes
Function long SetWindowLongA(long handlewnd, int  nIndex, long lNewLong) Library "user32"

end prototypes

on w_dg_select_date.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_dg_select_date.destroy
call super::destroy
destroy(this.uo_1)
end on

event close;//override
end event

event ue_init;call super::ue_init;If IsDate(Message.StringParm) Then
	uo_1.init_cal(Date(Message.StringParm))
Else
	//uo_1.init_cal(gf_co_fecha_periodo())
	uo_1.init_cal(date(gf_fecha_serv()))
End If

uo_1.BringToTop = False
end event

event open;call super::open;gf_center_win(this)
SetWindowLongA(handle(this), -20, 128)
end event

event ue_close;call super::ue_close;CloseWithReturn(This, uo_1.sle_date.Text)
end event

type st_window_name from w_a`st_window_name within w_dg_select_date
int X=9
end type

type uo_1 from u_ddcal within w_dg_select_date
int X=14
int Y=0
int Width=896
int TabOrder=10
end type

event ue_clicked;call super::ue_clicked;If estado = "+" Then
	This.Height = 744
	Parent.Height = 780
	This.BringToTop = True
Else
	This.Height = 196
	Parent.Height = 300
	This.BringToTop = False
End If
end event

on uo_1.destroy
call u_ddcal::destroy
end on

