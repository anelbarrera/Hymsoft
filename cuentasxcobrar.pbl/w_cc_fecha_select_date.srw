forward
global type w_cc_fecha_select_date from w_a
end type
type uo_1 from u_ddcal within w_cc_fecha_select_date
end type
end forward

global type w_cc_fecha_select_date from w_a
integer width = 937
integer height = 332
string title = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 12632256
uo_1 uo_1
end type
global w_cc_fecha_select_date w_cc_fecha_select_date

type prototypes
Function long SetWindowLongA(long handlewnd, int  nIndex, long lNewLong) Library "user32"

end prototypes

on w_cc_fecha_select_date.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_cc_fecha_select_date.destroy
call super::destroy
destroy(this.uo_1)
end on

event close;//override
end event

event ue_init;call super::ue_init;string	ls_fecha
date		ld_fecha

if IsNull(w_cc_fondo.str_para.mes) or w_cc_fondo.str_para.mes = 0 or &
	IsNull(w_cc_fondo.str_para.ano) or w_cc_fondo.str_para.ano = 0 then
	ls_fecha = string(date(gf_fecha_serv()),'dd/mm/yyyy')
else
	ls_fecha = string(day(date(gf_fecha_serv())))+'/'+string(w_cc_fondo.str_para.mes)+'/'+string(w_cc_fondo.str_para.ano)
end if

if isdate(string(date(message.stringparm))) then
	// Comentado por Gianni (26/12/2000). No envía correctamente el parámetro de la función
	//uo_1.init_cal(date(message.stringparm))
	
	// Gianni Araúz (26/12/2000). Capturar la fecha enviada desde la ventana padre.
	ld_fecha = date(message.stringparm)
	
	// Gianni Araúz (26/12/2000). Se trasladó la función que fija la fecha a este script.
	int		li_FirstDayNum, li_Cell, li_DaysInMonth
	string	ls_Year, ls_Month, ls_Return, ls_Cell
	date		ld_FirstDay
	
	// Insert a row into the script datawindow
	uo_1.dw_cal.InsertRow(0)
	
//	uo_1.sle_date.text = string(ad_start_date,'dd/mm/yyyy')
//	uo_1.sle_date.text = string(date(message.stringparm),'dd/mm/yyyy')
	uo_1.sle_date.text = message.stringparm
//	id_date_selected = ad_start_date
	uo_1.id_date_selected = ld_fecha
	
	//Set the variables for Day, Month and Year from the date passed to
	//the function
//	uo_1.ii_Month = Month(ld_fecha)
//	uo_1.ii_Year = Year(ld_fecha)
//	uo_1.ii_Day = Day(ld_fecha)
	uo_1.ii_month = integer(mid(uo_1.sle_date.text,4,2))
	uo_1.ii_year = integer(mid(uo_1.sle_date.text,7,4))
	uo_1.ii_day = integer(mid(uo_1.sle_date.text,1,2))
	
	//Find how many days in the relevant month
	li_daysinmonth = uo_1.days_in_month(uo_1.ii_month,uo_1.ii_year)
	
	//Find the date of the first day of this month
	ld_FirstDay = Date(uo_1.ii_Year,uo_1.ii_month,1)
	
	//What day of the week is the first day of the month
	li_FirstDayNum = DayNumber(ld_FirstDay)
	
	//Set the starting "cell" in the datawindow. i.e the column in which
	//the first day of the month will be displayed
	li_Cell = li_FirstDayNum + uo_1.ii_Day - 1
	
	//Set the Title of the calendar with the Month and Year
	ls_Month = uo_1.get_month_string(uo_1.ii_Month)+' '+string(uo_1.ii_Year)
	uo_1.dw_cal.object.st_month.text = ls_month
	
	//Enter the numbers of the days
	uo_1.enter_day_numbers(li_FirstDayNum,li_DaysInMonth)
	
	uo_1.dw_cal.SetItem(1,li_cell,string(Day(ld_fecha)))
	
	//Define the first Cell as a string
	ls_cell = 'cell'+string(li_cell)
	
	//Display the first day in bold (or 3D)
	uo_1.highlight_column(ls_cell)
	
	//Set the instance variable i_old_column to hold the current cell, so
	//when we change it, we know the old setting
	uo_1.is_old_column = ls_Cell
	
	// Fin Gianni
else
	//uo_1.init_cal(gf_fecha_periodo())
	//uo_1.init_cal(date(gf_fecha_serv()))
	uo_1.init_cal(date(ls_fecha))
end if

uo_1.bringtotop = False

end event

event open;call super::open;gf_center_win(this)
SetWindowLongA(handle(this), -20, 128)
end event

event ue_close;call super::ue_close;CloseWithReturn(This,uo_1.sle_date.text)

end event

type st_msghlp from w_a`st_msghlp within w_cc_fecha_select_date
end type

type st_window_name from w_a`st_window_name within w_cc_fecha_select_date
integer x = 9
end type

type uo_1 from u_ddcal within w_cc_fecha_select_date
integer x = 14
integer width = 896
integer taborder = 10
end type

event ue_clicked;call super::ue_clicked;If estado = "+" then
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

event constructor;call super::constructor;//sle_date.Text = String(Date(gf_fecha_serv()))
////
//id_date_selected = Date(gf_fecha_serv())
//
//pb_ddlb.PictureName = str.path + "art\arrow_down.bmp"
//
//dw_cal.Object.prevmonth.Visible = 0
//dw_cal.Object.prevyear.Visible = 0
//dw_cal.Object.nextmonth.Visible = 0
//dw_cal.Object.nextyear.Visible = 0
end event

