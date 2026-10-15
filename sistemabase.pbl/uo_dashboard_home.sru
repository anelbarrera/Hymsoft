//objectcomments  
forward
global type uo_dashboard_home from uo_base_module
end type
type st_title from statictext within uo_dashboard_home
end type
type r_card1 from rectangle within uo_dashboard_home
end type
type st_kpi1_val from statictext within uo_dashboard_home
end type
type st_kpi1_lbl from statictext within uo_dashboard_home
end type
type r_card2 from rectangle within uo_dashboard_home
end type
type st_kpi2_val from statictext within uo_dashboard_home
end type
type st_kpi2_lbl from statictext within uo_dashboard_home
end type
type r_card3 from rectangle within uo_dashboard_home
end type
type st_kpi3_val from statictext within uo_dashboard_home
end type
type st_kpi3_lbl from statictext within uo_dashboard_home
end type
end forward

global type uo_dashboard_home from uo_base_module
integer width = 3200
integer height = 2000
event resize pbm_size
st_title st_title
r_card1 r_card1
st_kpi1_val st_kpi1_val
st_kpi1_lbl st_kpi1_lbl
r_card2 r_card2
st_kpi2_val st_kpi2_val
st_kpi2_lbl st_kpi2_lbl
r_card3 r_card3
st_kpi3_val st_kpi3_val
st_kpi3_lbl st_kpi3_lbl
end type
global uo_dashboard_home uo_dashboard_home

event resize;long ll_card_w, ll_margin = 40, ll_top = 220
ll_card_w = (newwidth - (ll_margin * 4)) / 3

if ll_card_w < 400 then ll_card_w = 400

// Card 1 (Info)
r_card1.Move(ll_margin, ll_top)
r_card1.Resize(ll_card_w, 300)
st_kpi1_val.Move(ll_margin + 30, ll_top + 30)
st_kpi1_val.Resize(ll_card_w - 60, 110)
st_kpi1_lbl.Move(ll_margin + 30, ll_top + 150)
st_kpi1_lbl.Resize(ll_card_w - 60, 80)

// Card 2 (Success)
r_card2.Move(ll_margin * 2 + ll_card_w, ll_top)
r_card2.Resize(ll_card_w, 300)
st_kpi2_val.Move(ll_margin * 2 + ll_card_w + 30, ll_top + 30)
st_kpi2_val.Resize(ll_card_w - 60, 110)
st_kpi2_lbl.Move(ll_margin * 2 + ll_card_w + 30, ll_top + 150)
st_kpi2_lbl.Resize(ll_card_w - 60, 80)

// Card 3 (Warning)
r_card3.Move(ll_margin * 3 + (ll_card_w * 2), ll_top)
r_card3.Resize(ll_card_w, 300)
st_kpi3_val.Move(ll_margin * 3 + (ll_card_w * 2) + 30, ll_top + 30)
st_kpi3_val.Resize(ll_card_w - 60, 110)
st_kpi3_lbl.Move(ll_margin * 3 + (ll_card_w * 2) + 30, ll_top + 150)
st_kpi3_lbl.Resize(ll_card_w - 60, 80)
end event

on uo_dashboard_home.create
int iCurrent
call super::create
this.st_title=create st_title
this.r_card1=create r_card1
this.st_kpi1_val=create st_kpi1_val
this.st_kpi1_lbl=create st_kpi1_lbl
this.r_card2=create r_card2
this.st_kpi2_val=create st_kpi2_val
this.st_kpi2_lbl=create st_kpi2_lbl
this.r_card3=create r_card3
this.st_kpi3_val=create st_kpi3_val
this.st_kpi3_lbl=create st_kpi3_lbl
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_title
this.Control[iCurrent+2]=this.r_card1
this.Control[iCurrent+3]=this.st_kpi1_val
this.Control[iCurrent+4]=this.st_kpi1_lbl
this.Control[iCurrent+5]=this.r_card2
this.Control[iCurrent+6]=this.st_kpi2_val
this.Control[iCurrent+7]=this.st_kpi2_lbl
this.Control[iCurrent+8]=this.r_card3
this.Control[iCurrent+9]=this.st_kpi3_val
this.Control[iCurrent+10]=this.st_kpi3_lbl
end on

on uo_dashboard_home.destroy
call super::destroy
destroy(this.st_title)
destroy(this.r_card1)
destroy(this.st_kpi1_val)
destroy(this.st_kpi1_lbl)
destroy(this.r_card2)
destroy(this.st_kpi2_val)
destroy(this.st_kpi2_lbl)
destroy(this.r_card3)
destroy(this.st_kpi3_val)
destroy(this.st_kpi3_lbl)
end on

type st_title from statictext within uo_dashboard_home
integer x = 40
integer y = 40
integer width = 900
integer height = 110
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 2763306
long backcolor = 16053497
string text = "Panel Principal"
boolean focusrectangle = false
end type

type r_card1 from rectangle within uo_dashboard_home
long linecolor = 12099607
integer linethickness = 1
long fillcolor = 12099607
integer x = 40
integer y = 220
integer width = 700
integer height = 300
end type

type st_kpi1_val from statictext within uo_dashboard_home
integer x = 70
integer y = 250
integer width = 640
integer height = 110
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16777215
long backcolor = 12099607
string text = "1,248"
boolean focusrectangle = false
end type

type st_kpi1_lbl from statictext within uo_dashboard_home
integer x = 70
integer y = 370
integer width = 640
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16777215
long backcolor = 12099607
string text = "Nuevos Clientes"
boolean focusrectangle = false
end type

type r_card2 from rectangle within uo_dashboard_home
long linecolor = 4369192
integer linethickness = 1
long fillcolor = 4369192
integer x = 780
integer y = 220
integer width = 700
integer height = 300
end type

type st_kpi2_val from statictext within uo_dashboard_home
integer x = 810
integer y = 250
integer width = 640
integer height = 110
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16777215
long backcolor = 4369192
string text = "$45,210"
boolean focusrectangle = false
end type

type st_kpi2_lbl from statictext within uo_dashboard_home
integer x = 810
integer y = 370
integer width = 640
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16777215
long backcolor = 4369192
string text = "Ventas del Mes"
boolean focusrectangle = false
end type

type r_card3 from rectangle within uo_dashboard_home
long linecolor = 4964095
integer linethickness = 1
long fillcolor = 4964095
integer x = 1520
integer y = 220
integer width = 700
integer height = 300
end type

type st_kpi3_val from statictext within uo_dashboard_home
integer x = 1550
integer y = 250
integer width = 640
integer height = 110
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 2763306
long backcolor = 4964095
string text = "98.4 %"
boolean focusrectangle = false
end type

type st_kpi3_lbl from statictext within uo_dashboard_home
integer x = 1550
integer y = 370
integer width = 640
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 2763306
long backcolor = 4964095
string text = "Efectividad Cobros"
boolean focusrectangle = false
end type