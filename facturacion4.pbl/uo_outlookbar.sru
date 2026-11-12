//objectcomments Outlook Bar - inherited from DataWindow
forward
global type uo_outlookbar from datawindow
end type
end forward

global type uo_outlookbar from datawindow
integer width = 462
integer height = 1352
integer taborder = 1
string dataobject = "d_outlookbar_view"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event lbuttonup pbm_dwnlbuttonup
event mousemove pbm_mousemove
event ue_itemclicked ( long row,  long iconid,  string objectname,  string objecttype,  string triggerorpost )
event ue_rbuttondown_icon ( integer xpos,  integer ypos,  long row,  dwobject dwo,  long iconid )
event micro pbm_nchittest
end type
global uo_outlookbar uo_outlookbar

type variables
String is_PictureBorder, is_current_object
Integer ii_action
Boolean ib_Debug = True
DataStore ids_Data

PRIVATE:
Integer ii_GroupsOnTop = 1
String is_CurrentGroup
String is_NullString // Set to null in constructor event
Boolean ib_LargeIcons = True
m_outlookbar_menu im_PopupMenu
end variables

forward prototypes
public function integer of_rebuild_groups ()
public function integer of_paint ()
public subroutine of_rebuild_icons ()
public subroutine of_reset ()
public function integer of_additem (string ps_groupname)
public function integer of_additem (string ps_groupname, string ps_icontext, string ps_iconbitmap, long pl_iconid)
public function integer of_additem (string ps_groupname, string ps_icontext, string ps_iconbitmap, long pl_iconid, string ps_objectname, string ps_objecttype)
public function integer of_additem (string ps_groupname, string ps_icontext, string ps_iconbitmap, integer pl_iconid, string ps_objectname, string ps_objecttype, string ps_trigorpost)
public subroutine of_largeicons ()
public subroutine of_smallicons ()
private function integer of_addgroupicon (string ps_groupname, string ps_icontext, string ps_iconbitmap, long pl_iconid, string ps_objectname, string ps_objecttype, string ps_trigorpost)
end prototypes

event lbuttonup;String ls_Object

ls_Object = Lower(This.GetObjectAtPointer())
IF ((Left(ls_Object, 8) = "f_bitmap") OR (Left(ls_Object, 8) = "icontext")) AND (is_PictureBorder = "5") THEN
	is_PictureBorder ="6"
	This.Object.f_bitmap.Border = "0~tIF (CurrentRow() = GetRow(), 6, 0)"
END IF

end event

event mousemove;String ls_object


ls_object = Lower(This.GetObjectAtPointer())

If is_current_object = ls_object Then	Return

This.SetRedraw(False)

IF (Left(ls_Object, 8) = "f_bitmap") OR (Left(ls_Object, 8) = "icontext") THEN
	This.SetRow(Long(Mid(ls_Object, Pos(ls_Object, "~t") + 1)))
	This.Object.f_bitmap.Border = "0~tIF (CurrentRow() = GetRow(), " + is_PictureBorder + ", 0)"
ELSE
	This.Object.f_bitmap.Border = "0"
END IF

This.SetRedraw(True)

is_current_object = ls_object
////////
IF (Left(ls_object, 5) = "st_up") THEN // Up arrow
	If This.Object.st_up.color = '255' Then	Return

	ii_action = 1
	This.Object.st_up.color = RGB(255,0,0)
	This.Object.st_down.color = RGB(0,0,0)
ELSEIF (Left(ls_object, 7) = "st_down") THEN // Down arrow
	If This.Object.st_down.color = '255' Then		Return
	
	ii_action = 2
	This.Object.st_up.color = RGB(0,0,0)
	This.Object.st_down.color = RGB(255,0,0)
ELSE
	If This.Object.st_up.color = '0' and This.Object.st_down.color = '0' Then	Return
		
	ii_action = 0
	This.Object.st_up.color = RGB(0,0,0)
	This.Object.st_down.color = RGB(0,0,0)
END IF
end event

event ue_itemclicked;// This event is triggered when the user clicks on
// on one of the icons (not groups).
// There are several arguments to this event.

end event

event ue_rbuttondown_icon;// Over-ride this event to display your own pop-up menu
// when the user RClicks on the icon / icon text

Window lw_Window

lw_Window = Parent
im_PopupMenu.m_outlook.PopMenu(lw_Window.PointerX(), lw_Window.PointerY())

end event

public function integer of_rebuild_groups ();// Close to Outlook's size and spacing.  Outlook's is actually taller,
// but it has vertically-centered text which PB can't do w/ static text.
CONSTANT Integer li_ButtonHeight = 70
// 14 seems to be the magic number for button spacing with out
// running into rounding errors when PB converts Units to Pixels.
CONSTANT Integer li_ButtonSpacing = 14

Integer li_GroupOn, li_NumGroups
String ls_ModStatement, ls_Error

// Strategy:  Group "buttons" are actually static text in the
// header and footer of the DW.  First destroy existing ones (in
// case it's a redrawing), then dynamically create them.  Those
// above the icons are in the header with the rest in the footer.

IF (ids_Data.RowCount() < 1) THEN Return -1
ids_Data.Sort()
ids_Data.SetFilter("(groupname <> groupname[-1]) OR GetRow() = 1")
ids_Data.Filter()
li_NumGroups = ids_Data.GetItemNumber(ids_Data.RowCount(), "f_groupcount")

// Destroy all previous groups
FOR li_GroupOn = 1 TO li_NumGroups
	This.Modify("Destroy group_" + String(li_GroupOn))
NEXT

FOR li_GroupOn = 1 TO li_NumGroups
	// Need to evaluate band and Y values
	IF (li_GroupOn <= ii_GroupsOnTop) THEN
		// Group is on top (header)
		ls_ModStatement = 'create text(band=header y="' + String(((li_GroupOn - 1) * li_ButtonSpacing) + ((li_GroupOn - 1) * li_ButtonHeight) + 3) + '"'
	ELSE
		// Group is on bottom (footer)
		ls_ModStatement = 'create text(band=footer y="' + String(((li_GroupOn - ii_GroupsOnTop - 1) * li_ButtonSpacing) + (((li_GroupOn - ii_GroupsOnTop) - 1) * li_ButtonHeight) + 5) + '"'
	END IF

	// Common syntax to build group / static text
	ls_ModStatement = ls_ModStatement + ' alignment="2" text="' + ids_Data.GetItemString(li_GroupOn, "GroupName") + '" ' + &
		' border="6" color="0" x="3"' + &
		' height="' + String(li_ButtonHeight) + '" width="' + String(This.Width - 27) + '" ' + &
		' font.face="MS Sans Serif" font.height="-9" name=group_' + String(li_GroupOn) + &
		' font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" ' + &
		' background.color="79741120")'

	ls_Error = This.Modify(ls_ModStatement)
	IF (ls_Error <> "") AND (ib_Debug) THEN
		MessageBox("Create Group Error", ls_Error + "~n~n" + ls_ModStatement)
	END IF
NEXT

// Space between buttons + button height
This.Object.DataWindow.Header.Height = (ii_GroupsOnTop * li_ButtonSpacing) + (ii_GroupsOnTop * li_ButtonHeight)
This.Object.DataWindow.Footer.Height = ((li_NumGroups - ii_GroupsOnTop) * li_ButtonSpacing) + ((li_NumGroups - ii_GroupsOnTop) * li_ButtonHeight) - 3

// Used in of_Rebuild_Icons() - easier to get when the Filter() is still set
is_CurrentGroup = ids_Data.GetItemString(ii_GroupsOnTop, "GroupName")

ids_Data.SetFilter("")
ids_Data.Filter()

Return 1

end function

public function integer of_paint ();// Redraw the outlook bar
Integer li_Ret

This.SetRedraw(False)
This.Reset()
li_Ret = This.of_Rebuild_Groups()
IF (li_Ret > 0) THEN
	This.of_Rebuild_Icons()
END IF

This.SetRedraw(True)

Return li_Ret

end function

public subroutine of_rebuild_icons ();// Display the icons - only display those icons in the currently active group
Long ll_RowOn, ll_RowCount, ll_RowInserted
String ls_GroupName

// Find first record in active group
ll_RowCount = ids_Data.RowCount()
ll_RowOn = ids_Data.Find("groupname = '" + is_CurrentGroup + "'", 1, ll_RowCount) -1

DO
	// Handle loop exiting conditions up here
	ll_RowOn ++
	IF (ll_RowOn > ll_RowCount) THEN Exit
	// Still the group we're working on?
	IF (ids_Data.GetItemString(ll_RowOn, "groupname") <> is_CurrentGroup) THEN Exit
	// Is a bitmap defined for this row?
	IF (IsNull(ids_Data.GetItemString(ll_RowOn, "BitmapName"))) THEN Continue
	
	ll_RowInserted = This.InsertRow(0)
	This.SetItem(ll_RowInserted, "BitmapName", ids_Data.GetItemString(ll_RowOn, "BitmapName"))
	This.SetItem(ll_RowInserted, "IconText", ids_Data.GetItemString(ll_RowOn, "IconText"))
	This.SetItem(ll_RowInserted, "IconID", ids_Data.GetItemNumber(ll_RowOn, "IconID"))
	This.SetItem(ll_RowInserted, "ObjectName", ids_Data.GetItemString(ll_RowOn, "ObjectName"))
	This.SetItem(ll_RowInserted, "ObjectType", ids_Data.GetItemString(ll_RowOn, "ObjectType"))
	This.SetItem(ll_RowInserted, "PostOrTrigger", ids_Data.GetItemString(ll_RowOn, "PostOrTrigger"))
LOOP UNTIL (False)

Return

end subroutine

public subroutine of_reset ();// Clear everything previously added
ids_Data.DataObject = "d_outlookbar_data"
This.DataObject = "d_outlookbar_view"
ii_GroupsOnTop = 1
is_CurrentGroup = ""

end subroutine

public function integer of_additem (string ps_groupname);// Add group only
IF (IsNull(ps_GroupName)) OR (Trim(ps_GroupName) = "") THEN Return -1

Return of_AddGroupIcon(ps_GroupName, is_NullString, is_NullString, 0, is_NullString, is_NullString, "")

end function

public function integer of_additem (string ps_groupname, string ps_icontext, string ps_iconbitmap, long pl_iconid);// Add group and icon
IF (IsNull(ps_GroupName)) OR (Trim(ps_GroupName) = "") THEN Return -1
IF (IsNull(ps_IconText)) OR (Trim(ps_IconText) = "") THEN Return -2
IF (IsNull(ps_IconBitmap)) OR (Trim(ps_IconBitmap) = "") THEN Return -3
IF (IsNull(pl_IconID)) THEN Return -4

Return of_AddGroupIcon(ps_GroupName, ps_IconText, ps_IconBitmap, pl_IconID, is_NullString, is_NullString, "")

end function

public function integer of_additem (string ps_groupname, string ps_icontext, string ps_iconbitmap, long pl_iconid, string ps_objectname, string ps_objecttype);// Add group, icon, and object to open
IF (IsNull(ps_GroupName)) OR (Trim(ps_GroupName) = "") THEN Return -1
IF (IsNull(ps_IconText)) OR (Trim(ps_IconText) = "") THEN Return -2
IF (IsNull(ps_IconBitmap)) OR (Trim(ps_IconBitmap) = "") THEN Return -3
IF (IsNull(pl_IconID)) THEN Return -4

IF (IsNull(ps_ObjectName)) OR (Trim(ps_ObjectName) = "") THEN Return -5

ps_ObjectType = Upper(ps_ObjectType)
IF (IsNull(ps_ObjectType)) OR (Trim(ps_ObjectType) = "") THEN Return -6
IF (ps_ObjectType <> "W") AND (ps_ObjectType <> "U") THEN Return -6


Return of_AddGroupIcon(ps_GroupName, ps_IconText, ps_IconBitmap, pl_IconID, ps_ObjectName, ps_ObjectType, "")

end function

public function integer of_additem (string ps_groupname, string ps_icontext, string ps_iconbitmap, integer pl_iconid, string ps_objectname, string ps_objecttype, string ps_trigorpost);// Add group, icon, object to open, and trigger or post
IF (IsNull(ps_GroupName)) OR (Trim(ps_GroupName) = "") THEN Return -1
IF (IsNull(ps_IconText)) OR (Trim(ps_IconText) = "") THEN Return -2
IF (IsNull(ps_IconBitmap)) OR (Trim(ps_IconBitmap) = "") THEN Return -3
IF (IsNull(pl_IconID)) THEN Return -4
IF (IsNull(ps_ObjectName)) OR (Trim(ps_ObjectName) = "") THEN Return -5

ps_ObjectType = Upper(ps_ObjectType)
IF (IsNull(ps_ObjectType)) OR (Trim(ps_ObjectType) = "") THEN Return -6
IF (ps_ObjectType <> "W") AND (ps_ObjectType <> "U") THEN Return -6

IF (IsNull(ps_TrigOrPost)) THEN ps_TrigOrPost = "" // Nulls not allowed

Return of_AddGroupIcon(ps_GroupName, ps_IconText, ps_IconBitmap, pl_IconID, ps_ObjectName, ps_ObjectType, ps_TrigOrPost)

end function

public subroutine of_largeicons ();// Display the icons in "large", or 32x32 mode with text underneath
IF (ib_LargeIcons) THEN Return // Nothing to do

ib_LargeIcons = True

This.SetRedraw(False)
This.Object.f_bitmap.Width = "151"
This.Object.f_bitmap.Height = "129"
This.Object.f_bitmap.X = String((This.Width / 2) - (Long(This.Object.f_bitmap.Width) / 2))
This.Object.IconText.Height = "109"
This.Object.IconText.X = String((This.Width / 2) - (Long(This.Object.IconText.Width) / 2))
This.Object.IconText.Y = "144"
This.Object.IconText.Alignment = "2" // Center
This.Object.DataWindow.Detail.Height = "257"
This.SetRedraw(True)
end subroutine

public subroutine of_smallicons ();// Display the icons in "small", or 8x8 mode with text to the right
IF (NOT ib_LargeIcons) THEN Return // Nothing to do

ib_LargeIcons = False

This.SetRedraw(False)
This.Object.f_bitmap.Width = 70
This.Object.f_bitmap.Height = 60
This.Object.f_bitmap.X = 25
This.Object.IconText.Height = 57
This.Object.IconText.X = 115
This.Object.IconText.Y = This.Object.f_bitmap.Y
This.Object.IconText.Alignment = "0" // Left justified
This.Object.DataWindow.Detail.Height = 100
This.SetRedraw(True)

end subroutine

private function integer of_addgroupicon (string ps_groupname, string ps_icontext, string ps_iconbitmap, long pl_iconid, string ps_objectname, string ps_objecttype, string ps_trigorpost);// PRIVATE function called by the of_AddItem() functions
// Return values:	 1 = Success
//						-9 = Unable to insert row into DataStore

Long ll_RowOn, ll_GroupID

// Get the internally assigned Group_ID.  This is used
// for sorting purposes when getting the list of unique groups
//messagebox('ps_groupname',ps_groupname)

ll_RowOn = ids_Data.Find("GroupName = '" + ps_groupname + "'", 1, ids_Data.RowCount())
IF (ll_RowOn < 1) THEN
	IF (ids_Data.RowCount() < 1) THEN
		ll_GroupID = 1
	ELSE
		//messagebox("Rowcount",ids_Data.RowCount())
		ll_GroupID = ids_Data.GetItemNumber(ids_Data.RowCount(), "f_GroupCount") + 1
	END IF
ELSE
	ll_GroupID = ids_Data.GetItemNumber(ll_RowOn, "Group_ID")
END IF

ll_RowOn = ids_Data.InsertRow(0)
IF (ll_RowOn < 1) THEN Return -9

ids_Data.SetItem(ll_RowOn, "GroupName", ps_groupname)
ids_Data.SetItem(ll_RowOn, "Group_ID", ll_GroupID)
ids_Data.SetItem(ll_RowOn, "BitmapName", ps_IconBitmap)
ids_Data.SetItem(ll_RowOn, "IconText", ps_IconText)
ids_Data.SetItem(ll_RowOn, "IconID", pl_IconID)
ids_Data.SetItem(ll_RowOn, "ObjectName", ps_ObjectName)
ids_Data.SetItem(ll_RowOn, "ObjectType", ps_ObjectType)
ids_Data.SetItem(ll_RowOn, "PostOrTrigger", ps_TrigOrPost)

Return 1

end function

event clicked;String ls_Object
Integer li_GroupPressed, li_Pos


This.SetRedraw(False)

// Get object that was clicked
ls_Object = Lower(This.GetObjectAtPointer())

IF (Left(ls_Object, 8) = "f_bitmap") OR (Left(ls_Object, 8) = "icontext") THEN
	// Icon or icon's text
	is_PictureBorder = "5"
	This.Object.f_bitmap.Border = "0~tIF (CurrentRow() = GetRow(), 5, 0)"
	if row = 0 then return
	This.Event ue_ItemClicked(Row, This.GetItemNumber(Row, "IconID"), This.GetItemString(Row, "ObjectName"), This.GetItemString(Row, "ObjectType"), This.GetItemString(Row, "PostOrTrigger"))
ELSEIF (Left(ls_Object, 5) = "st_up") THEN // Up arrow
	// Set border down the back up for button-pressed effect
	This.Object.st_up.Border = "5"
	This.SetRow(Long(This.Object.DataWindow.FirstRowOnPage))
	This.ScrollPriorRow()
	This.Object.st_up.Border = "6"
ELSEIF (Left(ls_Object, 7) = "st_down") THEN // Down arrow
	This.Object.st_down.Border = "5"
	This.SetRow(Long(This.Object.DataWindow.LastRowOnPage))
	This.ScrollNextRow()
	This.Object.st_down.Border = "6"
ELSEIF (Left(ls_Object, 6) = "group_") THEN // Group button
	li_Pos = Pos(ls_Object, "~t")
	// If group isn't already currently active, the redraw the DW
	IF (ii_GroupsOnTop <> Integer(Mid(ls_Object, 7, li_Pos - 7))) THEN
		ii_GroupsOnTop = Integer(Mid(ls_Object, 7, li_Pos - 7))
//		messagebox("Grupo","Blanquear dw"+is_current_object)
	   This.Event ue_ItemClicked(0, 0, "", "", "")		
		This.of_Paint()
	END IF
END IF

This.SetRedraw(True)
end event

event resize;Integer li_GroupOn, li_NumGroups

// Only large icons get resized (actually re-centered)
IF (ib_LargeIcons) THEN
	This.Object.f_bitmap.X = String((This.Width / 2) - (Long(This.Object.f_bitmap.Width) / 2))
	This.Object.IconText.X = String((This.Width / 2) - (Long(This.Object.IconText.Width) / 2))
END IF

// Right-justify the arrows
This.Object.st_up.X = String(This.Width - 100)
This.Object.st_down.X = This.Object.st_up.X

// Resize the width of the group buttons
IF (ids_Data.RowCount() > 1) THEN
	li_NumGroups = ids_Data.GetItemNumber(ids_Data.RowCount(), "f_groupcount")
	
	FOR li_GroupOn = 1 TO li_NumGroups
		This.Modify("group_" + String(li_GroupOn) + ".Width = " + String(This.Width - 27))
	NEXT
END IF

end event

event rowfocuschanged;is_PictureBorder = "6"

end event

event constructor;ids_Data = Create DataStore

ids_Data.DataObject = "d_outlookbar_data"

SetNull(is_NullString)
im_PopupMenu = Create m_outlookbar_menu

im_PopupMenu.ivo_Parent = This // Allows the menu to call this objects functions

end event

event destructor;IF (IsValid(im_PopupMenu)) THEN Destroy im_PopupMenu
IF (IsValid(ids_Data)) THEN Destroy ids_Data

end event

event rbuttondown;Window lw_Window

IF (Left(dwo.Name, 6) = "group_") THEN
	im_PopupMenu.m_outlook.m_renamegroup.Enabled = True
	im_PopupMenu.m_outlook.m_removegroup.Enabled = True
ELSE
	im_PopupMenu.m_outlook.m_renamegroup.Enabled = False
	im_PopupMenu.m_outlook.m_removegroup.Enabled = False
END IF

IF (dwo.Name = "f_bitmap") OR (dwo.Name = "icontext") THEN
	This.Event ue_RButtonDown_Icon(XPos, YPos, Row, dwo, This.GetItemNumber(Row, "IconID"))
ELSE
	lw_Window = Parent
	im_PopupMenu.m_outlook.PopMenu(lw_Window.PointerX(), lw_Window.PointerY())
END IF

end event

on uo_outlookbar.create
end on

on uo_outlookbar.destroy
end on

