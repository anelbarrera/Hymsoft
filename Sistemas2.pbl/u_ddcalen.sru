forward
global type u_ddcalen from userobject
end type
type dw_cal from datawindow within u_ddcalen
end type
end forward

global type u_ddcalen from userobject
integer width = 727
integer height = 712
boolean border = true
long backcolor = 80269524
borderstyle borderstyle = styleraised!
long tabtextcolor = 33554432
event ue_abrir ( )
event ue_clicked ( )
event ue_losefocus ( )
event ue_cambio ( )
dw_cal dw_cal
end type
global u_ddcalen u_ddcalen

type variables
int ii_nday, ii_nmonth, ii_nyear
string is_old_column
string is_dateformat,is_date_selected
date id_dateselected
boolean set_date=false,allow_close=false

end variables

forward prototypes
public function date return_sel_date ()
public function int days_in_month (int ai_month, int ai_year)
public subroutine draw_month (integer ai_year, integer ai_month)
public subroutine enter_day_numbers (integer ai_startday, integer ai_daysinmonth)
public function int get_month_number (string as_month)
public function string get_month_string (integer ai_month)
public subroutine init_cal (date ad_start_date)
public subroutine set_date_format (string as_date_format)
public function integer of_valida_click (string arg_columna)
public subroutine wf_set_value (date ad_fecha)
public subroutine inicializar ()
end prototypes

event ue_abrir;BringToTop = TRUE
inicializar()
dw_cal.SetFocus()




end event

public function date return_sel_date ();//  Return the date selected
Return Date (is_date_selected) 

end function

public function int days_in_month (int ai_month, int ai_year);int li_daysinmonth
boolean lb_leapyear

CHOOSE CASE ai_month
	CASE 1, 3, 5, 7, 8, 10, 12
		li_daysinmonth = 31
	CASE 4, 6, 9, 11
		li_daysinmonth = 30
	CASE 2
		If Mod ( ai_year, 100 ) = 0 Then
			lb_leapyear = False
		ElseIf Mod ( ai_year, 4 ) = 0 Then 
			lb_leapyear = True
		Else 
			lb_leapyear = False
		End If
		If lb_leapyear Then
			li_daysinmonth = 29
		Else
			li_daysinmonth = 28
		End If
END CHOOSE

return li_daysinmonth
end function

public subroutine draw_month (integer ai_year, integer ai_month);int li_firstdaynum, li_cell, li_daysinmonth
date ld_firstday
string ls_month, ls_modify, ls_return
string ls_anio

SetPointer ( Hourglass! )
dw_cal.SetRedraw ( FALSE )

ii_nmonth = ai_month
ii_nyear = ai_year

li_daysinmonth = days_in_month ( ii_nmonth, ii_nyear )

ld_firstday = Date ( ii_nyear, ii_nmonth, 1 )

li_firstdaynum = DayNumber ( ld_firstday )

li_cell = li_firstdaynum + ii_nday - 1

If is_old_column <> "" Then
	ls_modify = is_old_column + ".border=0"
	ls_return = dw_cal.Modify ( ls_modify )
	If ls_return <> "" Then MessageBox ( "Modify", ls_return )
End If

ls_month = String ( ii_nyear )+'~r' +get_month_string ( ii_nmonth )
dw_cal.Modify ( "st_month.text=~"" + ls_month + "~"" )

enter_day_numbers ( li_firstdaynum, li_daysinmonth )

ls_anio=mid(string(ii_nyear),2,2)

if li_daysinmonth=28 and ii_nday>=29 then
	ii_nday=28
	li_cell = li_firstdaynum + ii_nday - 1	
end if

if li_daysinmonth=29 and ii_nday>=30 then
	ii_nday=29
	li_cell = li_firstdaynum + ii_nday - 1	
end if

if li_daysinmonth=30 and ii_nday>=31 then
	ii_nday=30
	li_cell = li_firstdaynum + ii_nday - 1	
end if

dw_cal.SetItem ( 1, li_cell, String ( ii_nday ) )

ls_modify = "#" + String ( li_cell ) + ".border=5"
ls_return = dw_cal.Modify ( ls_modify )
If ls_return <> "" Then MessageBox ( "Modify", ls_return )

is_old_column = dw_cal.Describe ( "#" + String ( li_cell ) + ".Name" ) 

SetPointer ( Arrow! )
dw_cal.SetRedraw ( TRUE )

end subroutine

public subroutine enter_day_numbers (integer ai_startday, integer ai_daysinmonth);int li_count, li_daycount
string ls_modify, ls_return

FOR li_count = 1 to ai_startday
    dw_cal.SetItem ( 1, li_count, "" )
NEXT

FOR li_count = 1 to ai_daysinmonth
    li_daycount = ai_startday + li_count - 1
    dw_cal.SetItem ( 1, li_daycount, String ( li_count ) )
NEXT

li_daycount = li_daycount + 1

FOR li_count = li_daycount to 42
    dw_cal.SetItem ( 1, li_count, "" )
NEXT

If is_old_column <> "" Then
	ls_modify = is_old_Column + ".border=0"
	ls_return = dw_cal.Modify ( ls_modify )
	If ls_return <> "" Then MessageBox ( "Modify", ls_return )
End If

is_old_column = ""
end subroutine

public function int get_month_number (string as_month);int li_month_number

CHOOSE CASE as_month
	CASE "Jan"
		li_month_number = 1
	CASE "Feb"
		li_month_number = 2
	CASE "Mar"
		li_month_number = 3
	CASE "Apr"
		li_month_number = 4
	CASE "May"
		li_month_number = 5
	CASE "Jun"
		li_month_number = 6
	CASE "Jul"
		li_month_number = 7
	CASE "Aug"
		li_month_number = 8
	CASE "Sep"
		li_month_number = 9
	CASE "Oct"
		li_month_number = 10
	CASE "Nov"
		li_month_number = 11
	CASE "Dec"
		li_month_number = 12
END CHOOSE

return li_month_number
end function

public function string get_month_string (integer ai_month);string ls_month

CHOOSE CASE ai_month
	CASE 1
		ls_month = "Enero"
	CASE 2
		ls_month = "Febrero"
	CASE 3
		ls_month = "Marzo"
	CASE 4
		ls_month = "Abril"
	CASE 5
		ls_month = "Mayo"
	CASE 6
		ls_month = "Junio"
	CASE 7
		ls_month = "Julio"
	CASE 8
		ls_month = "Agosto"
	CASE 9
		ls_month = "Septiembre"
	CASE 10
		ls_month = "Octubre"
	CASE 11
		ls_month = "Noviembre"
	CASE 12
		ls_month = "Diciembre"
END CHOOSE

return ls_month
end function

public subroutine init_cal (date ad_start_date);int li_firstday, li_cell, li_daysinmonth
string ls_month, ls_modify, ls_return
date ld_firstday

dw_cal.InsertRow ( 0 )

ii_nMonth = Month ( ad_start_date )
ii_nYear  = Year  ( ad_start_date )
ii_nDay   = Day   ( ad_start_date )

li_daysinmonth = days_in_month ( ii_nMonth, ii_nYear )

ld_firstday = Date ( ii_nYear, ii_nMonth, 1 )

li_firstday = DayNumber ( ld_firstday )

li_cell = li_firstday + ii_nDay - 1

ls_month =  String ( ii_nYear )+ '~r' +get_month_string ( ii_nMonth )
dw_cal.Modify ( "st_month.text=~"" + ls_month + "~"" )

enter_day_numbers ( li_firstday, li_daysinmonth )

dw_cal.SetItem ( 1, li_cell, String ( Day ( ad_start_date ) ) )

ls_modify = "#" + String ( li_cell ) + ".border=5"
ls_return = dw_cal.Modify ( ls_modify )
If ls_return <> "" Then MessageBox ( "Modify", ls_return )

is_old_column = dw_cal.Describe ( "#" + String ( li_cell ) + ".Name" )

end subroutine

public subroutine set_date_format (string as_date_format);is_dateformat = as_date_format



end subroutine

public function integer of_valida_click (string arg_columna);integer li_flag = 1

CHOOSE CASE arg_columna
	CASE 'cell1'
	CASE 'cell2'
	CASE 'cell3'
	CASE 'cell4'
	CASE 'cell5'
	CASE 'cell6'
	CASE 'cell7'
	CASE 'cell8'
	CASE 'cell9'
	CASE 'cell10'
	CASE 'cell11'
	CASE 'cell12'
	CASE 'cell13'
	CASE 'cell14'
	CASE 'cell15'
	CASE 'cell16'
	CASE 'cell17'
	CASE 'cell18'
	CASE 'cell19'
	CASE 'cell20'
	CASE 'cell21'
	CASE 'cell22'
	CASE 'cell23'
	CASE 'cell24'
	CASE 'cell25'
	CASE 'cell26'
	CASE 'cell27'
	CASE 'cell28'
	CASE 'cell29'
	CASE 'cell30'
	CASE 'cell31'
	CASE 'cell32'
	CASE 'cell33'
	CASE 'cell34'
	CASE 'cell35'
	CASE 'cell36'
	CASE 'cell37'
	CASE 'cell38'
	CASE 'cell39'
	CASE 'cell40'
	CASE 'cell41'
	CASE 'cell42'
	CASE 'cell43'
	CASE 'cell44'
	CASE 'cell45'
	CASE 'cell46'
	CASE ELSE
		li_flag=0
END CHOOSE

Return (li_flag)
end function

public subroutine wf_set_value (date ad_fecha);is_date_selected=string(ad_fecha,is_dateformat)
end subroutine

public subroutine inicializar ();	dw_cal.Reset ( )
	If is_date_selected = "" Then
		init_cal ( today ( ) )
	Else
		init_cal ( Date ( is_date_selected ) )
	End If
end subroutine

on u_ddcalen.create
this.dw_cal=create dw_cal
this.Control[]={this.dw_cal}
end on

on u_ddcalen.destroy
destroy(this.dw_cal)
end on

event constructor;set_date_format('dd/mm/yyyy')
is_date_selected=""

end event

type dw_cal from datawindow within u_ddcalen
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
event ue_mousemove pbm_dwnmousemove
integer width = 704
integer height = 692
integer taborder = 10
string dataobject = "d_calendario"
borderstyle borderstyle = stylelowered!
end type

event ue_lbuttonup;if set_date then
		Parent.TriggerEvent('ue_clicked')
end if

end event

event clicked;string ls_day, ls_modify, ls_return
string ls_clicked_col

IF dwo.Name = "datawindow" Then Return 

allow_close=false
set_date=false

CHOOSE CASE dwo.name
	CASE 'cb_hoy'	
		wf_set_value(today())
		set_date=true
		allow_close=true
	CASE 'p_prev'
		ii_nMonth = ii_nMonth - 1
		If ii_nMonth = 0 Then
			ii_nMonth = 12
			ii_nYear = ii_nYear - 1
		End If
				
		draw_month ( ii_nYear, ii_nMonth )
		ls_day = dw_cal.GetItemString ( 1, is_old_column )
		If ls_day = "" Then Return
		ii_nDay = Integer ( ls_day )
		
		wf_set_value(Date ( ii_nyear, ii_nmonth, ii_nday))
		set_date=true
	CASE 'p_next'
		ii_nMonth = ii_nMonth + 1
		If ii_nMonth = 13 Then
			ii_nMonth = 1
			ii_nYear = ii_nYear + 1
		End If
		draw_month ( ii_nYear, ii_nMonth )
		ls_day = dw_cal.GetItemString ( 1, is_old_column )
		If ls_day = "" Then Return
		ii_nDay = Integer ( ls_day )

		wf_set_value(Date ( ii_nyear, ii_nmonth, ii_nday))
		set_date=true
	CASE 'p_anio_anterior'
		ii_nyear --
		draw_month ( ii_nYear, ii_nMonth )
		ls_day = dw_cal.GetItemString ( 1, is_old_column )
		If ls_day = "" Then Return
		ii_nDay = Integer ( ls_day )

		wf_set_value(Date ( ii_nyear, ii_nmonth, ii_nday))
		set_date=true
	CASE 'p_anio_proximo'
		ii_nyear ++
		draw_month ( ii_nYear, ii_nMonth )		
		ls_day = dw_cal.GetItemString ( 1, is_old_column )
		If ls_day = "" Then Return
		ii_nDay = Integer ( ls_day )

		wf_set_value(Date ( ii_nyear, ii_nmonth, ii_nday))	
		set_date=true
	CASE ELSE
		ls_clicked_col = dwo.Name

		If of_valida_click(ls_clicked_col) = 0 Then Return
		
		ls_day = dw_cal.GetItemString ( 1, ls_clicked_col )
		If ls_day = "" Then Return
		
		ii_nDay = Integer ( ls_day )
		
		dw_cal.SetItem ( 1, ls_clicked_col, ls_day )
		
		ls_modify = ls_clicked_col + ".border=5"
		
		ls_return = dw_cal.Modify ( ls_modify )
		If ls_return <> "" Then MessageBox ( "Modify", ls_return )
		
		If is_old_column <> "" Then
			ls_modify = is_old_Column + ".border=0"
			ls_return = dw_cal.Modify ( ls_modify )
			If ls_return <> "" Then MessageBox ( "Modify", ls_return )
		End If
		is_old_column = ls_clicked_col
		wf_set_value(Date ( ii_nyear, ii_nmonth, ii_nday))
		set_date=true
		allow_close=true
END CHOOSE
end event

event losefocus;allow_close=true
Parent.TriggerEvent('ue_clicked')
end event

