//objectcomments User Object Standard (DATASTORE) utilizado por Ventanas que utilizan Desglose
forward
global type u_cfol_dw_excel from datastore
end type
end forward

global type u_cfol_dw_excel from datastore
event ue_save_excel1 ( )
event ue_ole_to_excel ( )
event ue_ole_close_excel ( )
event ue_save_excel2 ( )
end type
global u_cfol_dw_excel u_cfol_dw_excel

type variables
// Save Excel variables
int	ii_band_cnt, ii_det_cnt, ii_sum_cnt, &
	ii_head_cnt[], ii_trail_cnt[]
/* [band, column] */
String	is_head_name[9,50], is_trail_name[9,50], &
	is_detail_name[50], is_summary_name[50] /* computed column name */
String	is_head_type[9,50], is_trail_type[9,50], &
	is_detail_type[50], is_summary_type, is_file /* computed column type */
OLEObject	ioo_excel

window	iw_parent
end variables

forward prototypes
private function string of_getitem (long rownumber, string columntype, string columnname)
public subroutine of_populate_array (string theobjectname, string theobjecttype, string theobjectband)
private function string of_visible (long rownumber, string columnname)
private function string of_get_bandheight (string bandname)
private subroutine of_get_object_properties (string thecolumn, integer theoffset)
public subroutine of_initialize (window theparentwindow, datawindow thedatawindow, string thedataobject, string as_file)
end prototypes

event ue_save_excel1();int		i, li_pos1
String	ls_band_list, ls_col_type, ls_object_list


// Determine number of bands	
ls_band_list = This.Object.DataWindow.Bands
FOR i = 1 TO 9		// Assume no more than 9 bands
	li_pos1 = pos(ls_band_list, string(i))
	IF li_pos1 = 0 THEN EXIT
END FOR
ii_band_cnt = i - 1		// Number of bands


// Initialize variables
ii_det_cnt = 0
ii_sum_cnt = 0
FOR i = 1 TO ii_band_cnt
	ii_head_cnt[i] = 0
	ii_trail_cnt[i] = 0
END FOR


// Get list of objects.  
of_get_object_properties("column(name=",12)		// find all columns in all bands
of_get_object_properties("compute(name=",13)		// find all computed fields in all bands


This.Event ue_save_excel2()

end event

event ue_ole_to_excel();//iw_parent.SetMicroHelp ( "Open OLE to Excel" )


ioo_excel = CREATE OleObject

ioo_excel.ConnectToNewObject("Excel.Application")

ioo_excel.workbooks.Add()

end event

event ue_ole_close_excel();string	ls_filesuggest, ls_filesaved
int		li_rc


//iw_parent.SetMicroHelp ( "Close OLE to Excel" )

ls_filesuggest = is_file //"imreport.xls"

li_rc = GetFileSaveName( "Grabar Excel Spreadsheet", ls_filesuggest, ls_filesaved, ".xls", &
			"Excel Spreadsheet Files (*.XLS), *.XLS," )

IF li_rc = 1 THEN 
	IF FileExists ( ls_filesuggest ) THEN FileDelete ( ls_filesuggest )	// To prevent Excel questions
	ioo_excel.activeworkbook.saveas(ls_filesuggest) 

// if you don't close(), the spreadsheet remains in read-only state,
// even after closing this application and excel
	ioo_excel.activeworkbook.close()
ELSE
	ioo_excel.activeworkbook.close(false)		// don't save, disable prompting
END IF

ioo_excel.Application.quit				// Ensure Excel is closed properly
ioo_excel.DisconnectObject()

DESTROY ioo_excel

iw_parent.SetMicroHelp ( "Listo" )

end event

event ue_save_excel2();int		j, k, li_file_handle, li_level, li_det_cols, li_det_cols_cnt, li_excel_row
long		ll_row_chng[], ll_val, ll_row, ll_row_temp, ll_primary_count
string	ls_val, ls_col_name, ls_col_type, ls_line, ls_detailband_height, ls_visible, &
			ls_headerband_height[9], ls_trailerband_height[9]


// Counter used to set the proper excel row.  Can't use the report row!
li_excel_row = 0

// Start Ole connection
This.Event ue_ole_to_excel()


SetPointer ( HourGlass! )


// Determine the height of all the bands.  0-height bands will be skipped
ls_detailband_height = of_get_bandheight("detail" )

FOR li_level = 1 TO ii_band_cnt
	ls_headerband_height[li_level] = of_get_bandheight("header." + string(li_level))
	ls_trailerband_height[li_level] = of_get_bandheight("trailer." + string(li_level))
END FOR


// Loop through rows in primary buffer
ll_primary_count = This.RowCount()		// Number of rows in primary buffer

FOR ll_row = 1 TO ll_primary_count
	
	FOR li_level = 1 TO ii_band_cnt
		ll_row_chng[li_level] = This.FindGroupChange ( ll_row, li_level )
		IF ll_row_chng[li_level] = ll_row THEN		// Group change
			// Process Header
			
			// If band height = 0 skip it
			IF ls_headerband_height[li_level] <> "0" THEN
				li_excel_row++
				FOR j = 1 TO 25
					ls_col_name = is_head_name[li_level, j]
					IF ls_col_name = "" THEN CONTINUE

					// Determine visiblity
					ls_visible = of_visible(ll_row, ls_col_name)
					IF ls_visible = "0" THEN CONTINUE					

					ls_col_type = is_head_type[li_level, j]
					ls_val = of_getitem(ll_row, ls_col_type, ls_col_name)
					ioo_excel.application.activeworkbook.worksheets(1).cells(li_excel_row,j).value = ls_val
				END FOR
			END IF
		ELSE
			CONTINUE
		END IF
	END FOR
				
	// Reset to the lowest level			
	li_level = li_level - 1
	
	// Determine when next group level break will occur
	ll_row_temp = This.FindGroupChange ( ll_row + 1, li_level )
	IF ll_row_temp = 0 THEN					// Last group
		ll_row_temp = ll_primary_count
	ELSE
		ll_row_temp = ll_row_temp - 1
	END IF
	
	
	// Process Detail rows from current row until next group level break row - 1
	// If band height = 0 skip it
	IF ls_detailband_height <> "0" THEN
		li_det_cols_cnt = upperbound(is_detail_name)		// number of columns in detail band
		FOR k = ll_row TO ll_row_temp
		// here process each row
			li_excel_row++
			FOR li_det_cols = 1 TO li_det_cols_cnt
				ls_col_name = is_detail_name[li_det_cols]
				IF ls_col_name = "" THEN CONTINUE

				// Determine visiblity
				ls_visible = of_visible(ll_row, ls_col_name)
				IF ls_visible = "0" THEN CONTINUE					
					
				ls_val = of_getitem(k, is_detail_type[li_det_cols], ls_col_name)
				ioo_excel.application.activeworkbook.worksheets(1).cells(li_excel_row,li_det_cols).value = ls_val
			END FOR
		END FOR
	END IF
	ll_row = ll_row_temp
	
	// Process Trailer.  Must go in reversed level order
	FOR li_level = ii_band_cnt TO 1 step -1
		ll_row_chng[li_level] = This.FindGroupChange ( ll_row + 1, li_level )
		IF ll_row_chng[li_level] = 0 THEN		// we are at the end of the group
			ll_row_chng[li_level] = ll_row
		ELSE
			ll_row_chng[li_level] = ll_row_chng[li_level] - 1
		END IF
		IF ll_row_chng[li_level] = ll_row THEN		// Group change will happen
			
			// If band height = 0 skip it
			IF ls_trailerband_height[li_level] <> "0" THEN
				li_excel_row++
				FOR j = 1 TO 25
					ls_col_name = is_trail_name[li_level, j]
					IF ls_col_name = "" THEN CONTINUE

					// Determine visiblity
					ls_visible = of_visible(ll_row, ls_col_name)
					IF ls_visible = "0" THEN CONTINUE					
			
					ls_col_type = is_trail_type[li_level, j]
					ls_val = of_getitem(ll_row, ls_col_type, ls_col_name)
					ioo_excel.application.activeworkbook.worksheets(1).cells(li_excel_row,j).value = ls_val
				END FOR
			END IF
		ELSE
			CONTINUE
		END IF
	END FOR
	
END FOR


// Close Ole connection
This.Event ue_ole_close_excel()

end event

private function string of_getitem (long rownumber, string columntype, string columnname);string	ls_val

CHOOSE CASE mid(columntype,1,5)
	CASE "numbe", "decim", "long"
			ls_val = string(This.GetItemNumber(rownumber, columnname,Primary!,False))
	CASE "date"
			ls_val = string(This.GetItemDate(rownumber, columnname,Primary!,False))
	CASE "datet"
			ls_val = string(This.GetItemDateTime(rownumber, columnname,Primary!,False))
	CASE "time", "times"
			ls_val = string(This.GetItemTime(rownumber, columnname,Primary!,False))
	CASE "char(", "char"
			ls_val = This.GetItemString(rownumber, columnname,Primary!,False)
	CASE ELSE
			ls_val = ""
END CHOOSE

IF IsNull(ls_val) THEN ls_val = ""

RETURN ls_val
	
end function

public subroutine of_populate_array (string theobjectname, string theobjecttype, string theobjectband);// Populate arrays

int  li_level

CHOOSE CASE theobjectband
	CASE "header", "footer"
		// ignore page header and footer
	CASE "detail"
		ii_det_cnt++
		is_detail_name[ii_det_cnt] = theobjectname
		is_detail_type[ii_det_cnt] = theobjecttype
	CASE "summary"
		ii_sum_cnt++
		is_summary_name[ii_sum_cnt] = theobjectname
		is_summary_name[ii_sum_cnt] = theobjecttype
	CASE ELSE		// group bands
		CHOOSE CASE mid(theobjectband,1,7)
			CASE "header."
				li_level = integer(mid(theobjectband,8))
				ii_head_cnt[li_level]++
				is_head_name[li_level, ii_head_cnt[li_level]] = theobjectname
				is_head_type[li_level, ii_head_cnt[li_level]] = theobjecttype
			CASE "trailer"
				li_level = integer(mid(theobjectband,9))
				ii_trail_cnt[li_level]++
				is_trail_name[li_level, ii_trail_cnt[li_level]] = theobjectname
				is_trail_type[li_level, ii_trail_cnt[li_level]] = theobjecttype
	END CHOOSE
END CHOOSE

RETURN
end subroutine

private function string of_visible (long rownumber, string columnname);// Determine if object is visible

string	ls_visible
int		li_pos

ls_visible = columnname + ".Visible"

ls_visible = This.Describe(ls_visible)
li_pos = pos(ls_visible,"~t") + 1
ls_visible = mid(ls_visible, li_pos)

IF len(ls_visible) <> 1 THEN ls_visible = left(ls_visible, len(ls_visible) - 1)

ls_visible = "Evaluate('" + ls_visible + "', " + string(rownumber) + ")"
ls_visible = This.Describe(ls_visible)


RETURN ls_visible

end function

private function string of_get_bandheight (string bandname);// Get height of band

string	ls_band_height, ls_band_no

ls_band_no = "datawindow." + bandname + ".height"
ls_band_height = This.Describe(ls_band_no)

RETURN ls_band_height

end function

private subroutine of_get_object_properties (string thecolumn, integer theoffset);// Determine for an object in which band it is


string	ls_object_list, ls_syntax, ls_colname, ls_band, ls_describe, ls_coltype, ls_visible
Long		i, li_pos, li_len, li_space

// Assign unnamed objects a name!
ls_object_list = This.Object.DataWindow.Objects


// Look for columns
ls_syntax = This.Object.DataWindow.Syntax
li_len = len(ls_syntax)

FOR i = 1 TO li_len
	// Get columnname
	li_pos = pos(ls_syntax, thecolumn,i)
	IF li_pos = 0 THEN EXIT
	li_pos = li_pos + theoffset
	li_space = pos(ls_syntax, " " , li_pos)
	ls_colname = mid(ls_syntax, li_pos, li_space - li_pos)
	
	// Determine visibility.  This fails if a column is in multiple bands
	ls_describe = ls_colname + ".Visible"
	ls_visible = This.Describe(ls_describe) 
	
	IF ls_visible = "0" THEN 
		i = li_pos
		CONTINUE
	END IF

	// Get column type
	ls_describe = ls_colname + ".coltype"
	ls_coltype = This.Describe(ls_describe)

	// Get band
	li_pos = pos(ls_syntax, "band=", li_space) + 5
	ls_band = mid(ls_syntax,li_pos,7)		// First 7 characters
	
	CHOOSE CASE ls_band
		CASE "header "
			ls_band = "header"
		CASE "footer "
			ls_band = "footer"
		CASE "detail "
			ls_band = "detail"
		CASE "summary"
		CASE "header."
			ls_band = mid(ls_syntax,li_pos,8)	// assume no more than 9 bands
		CASE "trailer"
			ls_band = mid(ls_syntax,li_pos,9)	// assume no more than 9 bands
	END CHOOSE

	i = li_pos
	This.of_populate_array ( ls_colname, ls_coltype, ls_band )
	
END FOR

RETURN

end subroutine

public subroutine of_initialize (window theparentwindow, datawindow thedatawindow, string thedataobject, string as_file);iw_parent = theparentwindow

This.Dataobject = thedataobject
thedatawindow.Sharedata(this)
is_file = as_file
This.Event ue_save_excel1()
	
end subroutine

on u_cfol_dw_excel.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_cfol_dw_excel.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

