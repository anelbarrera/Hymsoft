forward
global type n_cst_winsrv_shell32 from n_cst_winsrv
end type
end forward

type shfileopstruct from structure
	unsignedlong		hwnd
	unsignedlong		wfunc
	string		pfrom
	string		pto
	unsignedinteger		fflags
	boolean		banyoperationsaborted
	unsignedlong		hnamemappings
	string		lpszprogresstitle
end type

type browseinfo from structure
	long		hwndowner
	long		pidlroot
	string		pszdisplayname
	string		lpsztitle
	unsignedinteger		ulflags
	long		lpfn
	long		lparam
	integer		iimage
end type

type notifyicondata from structure
	long		cbsize
	long		hwnd
	long		uid
	long		uflags
	long		ucallbackmsg
	long		hicon
	character		sztip[64]
end type

type shitemid from structure
	unsignedinteger		cb
	character		abID[1]
end type

type itemidlist from structure
	shitemid		mkid
end type

global type n_cst_winsrv_shell32 from n_cst_winsrv autoinstantiate
end type

type prototypes
// Shell functions
FUNCTION long ExtractIconA( ulong hInst, string lpszFileName, int nIconIndex ) LIBRARY "shell32.dll" alias for "ExtractIconA;Ansi" 
FUNCTION long SHBrowseForFolder( REF BROWSEINFO lpBi ) LIBRARY "SHELL32.DLL" alias for "SHBrowseForFolder;Ansi"
FUNCTION long Shell_NotifyIcon( ulong dwMessage, REF NOTIFYICONDATA lpData ) LIBRARY "shell32.dll" alias for "Shell_NotifyIcon;Ansi"
FUNCTION long SHFileOperationA( SHFILEOPSTRUCT lpFileOp ) LIBRARY "SHELL32.DLL" alias for "SHFileOperationA;Ansi"
FUNCTION boolean SHGetPathFromIDList( ulong pidl, REF string pszBuffer ) LIBRARY "shell32.dll" alias for "SHGetPathFromIDList;Ansi"
FUNCTION boolean SHGetPathFromIDList( ITEMIDLIST ppidl, REF string pszBuffer ) LIBRARY "shell32.dll" alias for "SHGetPathFromIDList;Ansi"
FUNCTION long SHGetSpecialFolderLocation( ulong hwndOwner, ulong nFolder, REF long lpPidl ) LIBRARY "shell32.dll"
FUNCTION long ShellExecuteA( ulong hWnd, string Operation, string lpFile, string lpParameters, string lpDirectory, int nShowCmd ) LIBRARY "shell32.dll" alias for "ShellExecuteA;Ansi"
FUNCTION long SHFormatDrive( ulong hWnd, ulong iDrive, ulong iCapacity, ulong iType ) LIBRARY "shell32.dll"
SUBROUTINE SHAddToRecentDocs( uint uFlags, string pv ) LIBRARY "shell32.dll" alias for "SHAddToRecentDocs;Ansi" 

// Helper functions
FUNCTION long LoadIconA( ulong hInst, long resourceID ) LIBRARY "user32.dll"
FUNCTION long LoadImageA( ulong hInst, string lpszName, uint uType, int a, int b, uint l ) LIBRARY "user32.dll" alias for "LoadImageA;Ansi"
SUBROUTINE CoTaskMemFree( ulong lpVoid ) LIBRARY "ole32.dll"
FUNCTION ulong GetFileVersionInfoSizeA( REF string lpFilename, REF ulong lpdwHandle ) LIBRARY "version.dll" alias for "GetFileVersionInfoSizeA;Ansi"
FUNCTION boolean GetFileVersionInfoA( REF string lpFilename, REF ulong lpdwHandle, ulong dwLen, REF string lpData ) LIBRARY "version.dll" alias for "GetFileVersionInfoA;Ansi"
FUNCTION integer GetUserDefaultLangID() LIBRARY "kernel32.dll"
FUNCTION boolean VerQueryValueA( REF string lpBlock, string lpSubBlock, REF long lpBuffer, REF uint puLen ) LIBRARY "version.dll" alias for "VerQueryValueA;Ansi" 
SUBROUTINE CopyMemory( REF string d, long s, long l ) LIBRARY "kernel32.dll" ALIAS FOR "RtlMoveMemory;Ansi"
SUBROUTINE CopyMemory( REF TRANSARRAY d, long s, long l ) LIBRARY 'kernel32.dll' ALIAS FOR "RtlMoveMemory;Ansi"

end prototypes

type variables
private:
boolean ib_systemtray	= FALSE

// Structures
NOTIFYICONDATA		ipData
BROWSEINFO		ibi
SHFILEOPSTRUCT	ipFileOp

public:
// Last visited folder (pointer to IDLIST)
long			ii_pidl

// File operation types
CONSTANT uint FO_MOVE	= 1
CONSTANT uint FO_COPY	= 2
CONSTANT uint FO_DELETE	= 3
CONSTANT uint FO_RENAME	= 4

// File operation flags
CONSTANT uint FOF_MULTIDESTFILES 		= 1
CONSTANT uint FOF_CONFIRMMOUSE 		= 2
CONSTANT uint FOF_SILENT			= 4
CONSTANT uint FOF_RENAMEONCOLLISION	= 8
CONSTANT uint FOF_NOCONFIRMATION 	= 16
CONSTANT uint FOF_WANTMAPPINGHANDLE	= 32
CONSTANT uint FOF_ALLOWUNDO 		= 64
CONSTANT uint FOF_FILESONLY 		= 128
CONSTANT uint FOF_SIMPLEPROGRESS	= 256
CONSTANT uint FOF_NOCONFIRMMKDIR 	= 512
CONSTANT uint FOF_NOERRORUI		= 1024
CONSTANT uint FOF_NOCOPYSECURITYATTRIBS	= 2048

// Special folder flags
CONSTANT uint CSIDL_DESKTOP		= 0
CONSTANT uint CSIDL_INTERNET		= 1
CONSTANT uint CSIDL_PROGRAMS		= 2
CONSTANT uint CSIDL_CONTROLS		= 3
CONSTANT uint CSIDL_PRINTERS		= 4

CONSTANT uint CSIDL_PERSONAL		= 5
CONSTANT uint CSIDL_FAVORITES		= 6
CONSTANT uint CSIDL_STARTUP		= 7
CONSTANT uint CSIDL_RECENT		= 8
CONSTANT uint CSIDL_SENDTO		= 9
CONSTANT uint CSIDL_BITBUCKET		= 10
CONSTANT uint CSIDL_STARTMENU		= 11
CONSTANT uint CSIDL_DESKTOPDIRECTORY	= 16
CONSTANT uint CSIDL_DRIVES		= 17
CONSTANT uint CSIDL_NETWORK		= 18
CONSTANT uint CSIDL_NETHOOD		= 19
CONSTANT uint CSIDL_FONTS		= 20
CONSTANT uint CSIDL_TEMPLATES		= 21
CONSTANT uint CSIDL_COMMON_STARTMENU	= 22
CONSTANT uint CSIDL_COMMON_PROGRAMS	= 23
CONSTANT uint CSIDL_COMMON_STARTUP	= 24
CONSTANT uint CSIDL_COMMON_DESKTOPDIRECTORY	= 25
CONSTANT uint CSIDL_APPDATA		= 26
CONSTANT uint CSIDL_PRINTHOOD		= 27
CONSTANT uint CSIDL_INTERNET_CACHE	= 32
CONSTANT uint CSIDL_HISTORY		= 34

// Shell browsing flags
CONSTANT uint BIF_RETURNONLYFSDIRS	= 1
CONSTANT uint BIF_DONTGOBELOWDOMAIN	= 2
CONSTANT uint BIF_STATUSTEXT		= 4
CONSTANT uint BIF_RETURNFSANCESTORS	= 8
CONSTANT uint BIF_BROWSEFORCOMPUTER	= 4096
CONSTANT uint BIF_BROWSEFORPRINTER	= 8192

// Recent documents flags
CONSTANT uint SHARD_PATH = 2

// System tray flags
CONSTANT long NIF_MESSAGE	= 1
CONSTANT long NIF_ICON		= 2
CONSTANT long NIF_TIP		= 4
CONSTANT long NIM_ADD		= 0
CONSTANT long NIM_MODIFY		= 1
CONSTANT long NIM_DELETE		= 2

CONSTANT uint WM_MOUSEMOVE	= 512
CONSTANT uint WM_LBUTTONDOWN	= 513
CONSTANT uint WM_LBUTTONUP	= 514
CONSTANT uint WM_LBUTTONDBLCLK	= 515
CONSTANT uint WM_RBUTTONDOWN	= 516
CONSTANT uint WM_RBUTTONUP	= 517
CONSTANT uint WM_RBUTTONDBLCLK	= 518
CONSTANT uint WM_USER		= 1024

// Window state flags
CONSTANT uint SW_HIDE			= 0
CONSTANT uint SW_NORMAL			= 1
CONSTANT uint SW_SHOWMINIMIZED		= 2
CONSTANT uint SW_MAXIMIZE		= 3
CONSTANT uint SW_SHOWNOACTIVATE	= 4
CONSTANT uint SW_SHOW			= 5
CONSTANT uint SW_MINIMIZE			= 6
CONSTANT uint SW_SHOWMINNOACTIVE	= 7
CONSTANT uint SW_SHOWNA			= 8
CONSTANT uint SW_RESTORE		= 9
CONSTANT uint SW_SHOWDEFAULT		= 10

end variables

forward prototypes
public function integer of_filecopy (string as_sourcefile, string as_targetfile)
public subroutine of_addtorecentdocs (string as_filename)
public subroutine of_clearrecentdocs ()
public function string of_browseforfolder (string as_title, boolean ab_fullpath)
public function string of_browseforprinter (string as_title)
public function integer of_browseurl (string as_url)
public function integer of_removefromsystray ()
public function boolean of_issystrayactive ()
public function integer of_filecopy (string as_sourcefile, string as_targetfile, unsignedinteger ai_flags)
public function integer of_filemove (string as_sourcefile, string as_targetfile, integer ai_flags)
public function integer of_filemove (string as_sourcefile, string as_targetfile)
public function integer of_filedelete (string as_sourcefile)
public function integer of_filedelete (string as_sourcefile, unsignedinteger ai_flags)
public function string of_browseforcomputer (string as_title)
public function integer of_formatdrive (character ac_drive)
public function string of_getspecialfolderpath (unsignedinteger ai_foldertype)
public function integer of_ExploreSpecialFolder (string as_folder)
public function string of_browseforfolder (string as_title, boolean ab_fullpath, boolean ab_uselastroot)
public function string of_browseforcomputer (string as_title, boolean ab_uselastroot)
public function string of_browseforprinter (string as_title, boolean ab_uselastroot)
public function integer of_modifysystray (string as_iconfname, string as_tiptext)
public function integer of_modifysystray (string as_tiptext)
public function integer of_addtosystray (string as_tiptext)
public function integer of_addtosystray (string as_iconfname, string as_tiptext)
public function integer of_getfileversioninfo (string as_filename, ref fileversioninfo astr_fvi)
end prototypes

public function integer of_filecopy (string as_sourcefile, string as_targetfile);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_FileCopy
//
//	Access:				public
//
//	Arguments:			string as_SourceFile		The file(s) to copy.
//							string as_TargetFile		The new file name or destination.
//															directory
//
//	Returns:				Integer
//							 1 if successful,
//							-1 if an error occurrs.
//
//	Description:		Copy a file or directory.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

Integer				li_rc

ipFileOp.hWnd		= Handle( iw_requestor )
ipFileOp.wFunc		= FO_COPY
ipFileOp.pFrom 	= Space( 256 )			// allocate memory first
ipFileOp.pFrom 	= as_SourceFile + Char(0)
ipFileOp.pTo		= Space( 256 )
ipFileOp.pTo		= as_TargetFile + Char(0)
ipFileOp.fFlags 	= 0						// default behaviou
ipFileOp.bAnyOperationsAborted = TRUE
ipFileOp.hNameMappings = 0
ipFileOp.lpszProgressTitle = Space( 10 )

li_rc = SHFileOperationA( ipFileOp )
IF li_rc <> 0 THEN
	RETURN -1
ELSE
	RETURN 1
END IF

end function

public subroutine of_addtorecentdocs (string as_filename);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_AddToRecentDocs
//
//	Access:				public
//
//	Arguments:			String as_filename	- filename to add to list
//
//	Returns:				None
//
//	Description:		Adds a document to the shell’s list of recently used
//							documents. The user gains access to the list through
//							the Start menu of the Windows taskbar. 
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

SHAddToRecentDocs( SHARD_PATH, as_filename )
 

end subroutine

public subroutine of_clearrecentdocs ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_ClearRecentDocs
//
//	Access:				public
//
//	Arguments:			
//
//	Returns:				None
//
//	Description:		Clears all documents from the shell’s list of recently used
//							documents. The user gains access to the list through
//							the Start menu of the Windows taskbar. 
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

String	ls_null

SetNull( ls_null )
SHAddToRecentDocs( SHARD_PATH, ls_null )
 

end subroutine

public function string of_browseforfolder (string as_title, boolean ab_fullpath);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_BrowseForFolder
//
//	Access:				public
//
//	Arguments:			Boolean	ab_fullpath	- return folder name only or fully 
//														  qualified path.
//							String	as_title  	- text to display in folder dialog
//
//	Returns:				String
//							The selected folder name if successful,
//							A NULL string if an error occurrs.
//
//	Description:		Displays the folder browse dialog box and enables the
//							user to select a specific folder
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

String		ls_null, ls_name, ls_title, ls_path, ls_folder
long			ll_pidl, ll_rc, ll_null
Integer		li_image

SetNull( ls_null )
SetNull( ll_Null )
ls_name = Space( 256 )
ls_title = as_title + char(0)

ibi.hWndOwner = Handle( iw_requestor )
ibi.pidlRoot = ll_Null
ibi.pszDisplayName = ls_name
ibi.lpszTitle = ls_title
ibi.ulFlags = BIF_RETURNONLYFSDIRS
ibi.lpfn = ll_null

ibi.lParam = ll_null
ibi.iImage = li_image

ll_pidl = SHBrowseForFolder( ibi )
IF ll_pidl > 0 THEN
	ls_path = Space( 256 )
	IF SHGetPathFromIDList( ll_pidl, ls_path ) THEN
		IF ab_fullpath THEN
			ls_folder = ls_path
		ELSE
			ls_folder = ibi.pszDisplayName
		END IF
		
		RETURN ls_folder
	END IF
ELSE
	RETURN ls_null
END IF

end function

public function string of_browseforprinter (string as_title);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_BrowseForPrinter
//
//	Access:				public
//
//	Arguments:			String as_title	- Text to display in browse dialog
//
//	Returns:				String
//							The selected printer name if successful,
//							A NULL string if an error occurrs.
//
//	Description:		Displays the shell browse dialog box and enables the user
//							to select a specific printer by name
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

String		ls_null, ls_name, ls_title, ls_path, ls_printer
long			ll_pidl, ll_rc, ll_null
Integer		li_image

SetNull( ls_null )
SetNull( ll_Null )
ls_name = Space( 256 )
ls_title = as_title + char(0)

ibi.hWndOwner = Handle( iw_requestor )
ibi.pidlRoot = ll_Null
ibi.pszDisplayName = ls_name
ibi.lpszTitle = ls_title
ibi.ulFlags = BIF_BROWSEFORPRINTER
ibi.lpfn = ll_null
ibi.lParam = ll_null
ibi.iImage = li_image

ll_pidl = SHBrowseForFolder( ibi )
IF ll_pidl > 0 THEN
	ls_path = Space( 256 )
	IF SHGetPathFromIDList( ll_pidl, ls_path ) THEN
		ls_printer = ls_path + ibi.pszDisplayName
		RETURN ls_printer
	END IF
ELSE
	RETURN ls_null
END IF

end function

public function integer of_browseurl (string as_url);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_BrowseURL
//
//	Access:				public
//
//	Arguments:			String as_url			- URL to browse
//
//	Returns:				Integer
//							 1 - success
//							-1 - error
//
//	Description:		Opens the specified URL in the default web browser.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

Long		ll_rc
String	ls_null

SetNull( ls_null )
ll_rc = ShellExecuteA ( Handle( iw_requestor ), &
								"open", &
								as_url + Char(0), &
								ls_null, ls_null, SW_NORMAL )

IF ll_rc > 32 THEN	// 0-32 are OS error codes
	RETURN 1
ELSE
	RETURN -1
END IF
end function

public function integer of_removefromsystray ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_RemoveFromSysTray
//
//	Access:				public
//
//	Arguments:			None
//
//	Returns:				Integer
//							 1 - success
//							-1 - error
//
//	Description:		Removes an icon from the system tray area. 
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

NOTIFYICONDATA	lpData
Long				ll_rc

lpData.hWnd		= Handle( iw_requestor )
lpData.uID		= lpData.hWnd
lpData.cbSize	= 88

ll_rc = Shell_NotifyIcon( NIM_DELETE, lpData )
IF ll_rc = 0 THEN
	RETURN -1
ELSE
	ib_SystemTray = FALSE
	RETURN 1
END IF
end function

public function boolean of_issystrayactive ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_IsSysTrayActive
//
//	Access:				public
//
//	Arguments:			None
//
//	Returns:				Boolean
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//

//////////////////////////////////////////////////////////////////////////////

RETURN ib_SystemTray
end function

public function integer of_filecopy (string as_sourcefile, string as_targetfile, unsignedinteger ai_flags);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_FileCopy
//
//	Access:				public
//
//	Arguments:			string as_SourceFile		The file to copy.
//							string as_TargetFile		The new file name or detination
//															directory
//							uint   ai_flags			File operation flags (0 - default )
//
//	Returns:				Integer
//							 1 if successful,
//							-1 if an error occurrs.
//
//	Description:		Copy a file or directory.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

Integer				li_rc

ipFileOp.hWnd		= Handle( iw_requestor )
ipFileOp.wFunc		= FO_COPY
ipFileOp.pFrom 	= Space( 256 )			// allocate memory first
ipFileOp.pFrom 	= as_SourceFile + Char(0)
ipFileOp.pTo		= Space( 256 )
ipFileOp.pTo		= as_TargetFile + Char(0)
ipFileOp.fFlags 	= ai_flags
ipFileOp.bAnyOperationsAborted = TRUE
ipFileOp.hNameMappings = 0

li_rc = SHFileOperationA( ipFileOp )
IF li_rc <> 0 THEN
	RETURN -1
ELSE
	RETURN 1
END IF

end function

public function integer of_filemove (string as_sourcefile, string as_targetfile, integer ai_flags);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_FileMove
//
//	Access:				public
//
//	Arguments:			string as_SourceFile			The file to rename.
//							string as_TargetFile			The new file name.
//							uint   ai_flags				File operation flags (0 - default )
//
//	Returns:				Integer
//							 1 if successful,
//							-1 if an error occurrs.
//
//	Description:		Move a file or directory.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

Integer				li_rc
SHFileOpStruct		lpFileOp

ipFileOp.hWnd		= Handle( iw_requestor )
ipFileOp.wFunc		= FO_MOVE
ipFileOp.pFrom 	= Space( 256 )			// allocate memory first
ipFileOp.pFrom 	= as_SourceFile + Char(0)
ipFileOp.pTo		= Space( 256 )
ipFileOp.pTo		= as_TargetFile + Char(0)
ipFileOp.fFlags 	= ai_flags
ipFileOp.bAnyOperationsAborted = TRUE
ipFileOp.hNameMappings = 0

li_rc = SHFileOperationA( ipFileOp )
IF li_rc <> 0 THEN
	RETURN -1
ELSE
	RETURN 1
END IF

end function

public function integer of_filemove (string as_sourcefile, string as_targetfile);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_FileMove
//
//	Access:				public
//
//	Arguments:			string as_SourceFile			The file to rename.
//							string as_TargetFile			The new file name.
//							uint   ai_flags				File operation flags (0 - default )
//
//	Returns:				Integer
//							 1 if successful,
//							-1 if an error occurrs.
//
//	Description:		Move a file or directory.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

Integer				li_rc

ipFileOp.hWnd		= Handle( iw_requestor )
ipFileOp.wFunc		= FO_MOVE
ipFileOp.pFrom 	= Space( 256 )			// allocate memory first
ipFileOp.pFrom 	= as_SourceFile + Char(0)
ipFileOp.pTo		= Space( 256 )
ipFileOp.pTo		= as_TargetFile + Char(0)
ipFileOp.fFlags 	= 0
ipFileOp.bAnyOperationsAborted = TRUE
ipFileOp.hNameMappings = 0

li_rc = SHFileOperationA( ipFileOp )
IF li_rc <> 0 THEN
	RETURN -1
ELSE
	RETURN 1
END IF

end function

public function integer of_filedelete (string as_sourcefile);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_FileCopy
//
//	Access:				public
//
//	Arguments:			string as_SourceFile			The file(s) to delete
//
//	Returns:				Integer
//							 1 if successful,
//							-1 if an error occurrs.
//
//	Description:		Delete a file or directory.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

Integer				li_rc

ipFileOp.hWnd		= Handle( iw_requestor )
ipFileOp.wFunc		= FO_DELETE
ipFileOp.pFrom 	= Space( 256 )			// allocate memory first
ipFileOp.pFrom 	= as_SourceFile + Char(0)
ipFileOp.fFlags 	= FOF_ALLOWUNDO
ipFileOp.bAnyOperationsAborted = TRUE
ipFileOp.hNameMappings = 0
ipFileOp.lpszProgressTitle = Space( 10 )

li_rc = SHFileOperationA( ipFileOp )
IF li_rc <> 0 THEN
	RETURN -1
ELSE
	RETURN 1
END IF

end function

public function integer of_filedelete (string as_sourcefile, unsignedinteger ai_flags);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_FileCopy
//
//	Access:				public
//
//	Arguments:			string as_SourceFile		The file(s) to delete
//							uint   ai_flags			File operation flags (0 - default )
//
//	Returns:				Integer
//							 1 if successful,
//							-1 if an error occurrs.
//
//	Description:		Delete a file or directory.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

Integer				li_rc

ipFileOp.hWnd		= Handle( iw_requestor )
ipFileOp.wFunc		= FO_DELETE
ipFileOp.pFrom 	= Space( 256 )			// allocate memory first
ipFileOp.pFrom 	= as_SourceFile + Char(0)
ipFileOp.fFlags 	= FOF_ALLOWUNDO
ipFileOp.bAnyOperationsAborted = TRUE
ipFileOp.hNameMappings = 0
ipFileOp.lpszProgressTitle = Space( 10 )

li_rc = SHFileOperationA( ipFileOp )
IF li_rc <> 0 THEN
	RETURN -1
ELSE
	RETURN 1
END IF

end function

public function string of_browseforcomputer (string as_title);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_BrowseForComputer
//
//	Access:				public
//
//	Arguments:			String as_title	- Text to display in browse dialog
//
//	Returns:				String
//							The selected computer name if successful,
//							A NULL string if an error occurrs.
//
//	Description:		Displays the shell browse dialog box and enables the user
//							to select a specific computer by name
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

String		ls_null, ls_name, ls_title, ls_path, ls_computer
long			ll_pidl, ll_rc, ll_null
Integer		li_image

SetNull( ls_null )
SetNull( ll_Null )
ls_name = Space( 256 )
ls_title = as_title + char(0)

ibi.hWndOwner = Handle( iw_requestor )
ibi.pidlRoot = ll_Null
ibi.pszDisplayName = ls_name
ibi.lpszTitle = ls_title
ibi.ulFlags = BIF_BROWSEFORCOMPUTER
ibi.lpfn = ll_null
ibi.lParam = ll_null
ibi.iImage = li_image

ll_pidl = SHBrowseForFolder( ibi )
IF ll_pidl > 0 THEN
	ls_path = Space( 256 )
	IF SHGetPathFromIDList( ll_pidl, ls_path ) THEN
		ls_computer = ls_path + ibi.pszDisplayName
		RETURN ls_computer
	END IF
ELSE
	RETURN ls_null
END IF

end function

public function integer of_formatdrive (character ac_drive);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_FormatDrive
//
//	Access:				public
//
//	Arguments:			Character ac_drive	- drive to format (A-Z)
//
//	Returns:				Integer
//							 1 - success
//							-1 - error
//
//	Description:		Displays the shell's drive formatting dialog box.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

long ll_rc

ll_rc = SHFormatDrive( Handle( iw_requestor ), &
							  Asc( Upper( ac_drive ) ) - 65, &
							  0, 0 )
IF ll_rc = 0 THEN
	RETURN -1
ELSE
	RETURN 1
END IF

end function

public function string of_getspecialfolderpath (unsignedinteger ai_foldertype);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_GetSpecialFolderPath
//
//	Access:				public
//
//	Arguments:			Integer	ai_folderType - folder of interest
//
//	Returns:				String
//							The full path to the requested folder if successful,
//							A NULL string if an error occurrs.
//
//	Description:		Returns the file system path to a special folder.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

String		ls_null, ls_path
long			ll_pidl, ll_rc

SetNull( ls_null )

ll_rc = SHGetSpecialFolderLocation( Handle( iw_requestor ), ai_folderType, REF ll_pidl )
IF ll_rc <> 0 THEN
	RETURN ls_null
END IF

ls_path = Space( 256 )
IF SHGetPathFromIDList( ll_pidl, ls_path ) THEN
	RETURN ls_path
ELSE
	RETURN ls_null
END IF

end function

public function integer of_ExploreSpecialFolder (string as_folder);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_ExploreSpecialFolder
//
//	Access:				public
//
//	Arguments:			String as_folder			- folder to explore
//
//	Returns:				Integer
//							 1 - success
//							-1 - error
//
//	Description:		Explores a specified folder.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

Long		ll_rc
String	ls_null

SetNull( ls_null )
ll_rc = ShellExecuteA ( Handle( iw_requestor ), &
								"explore", &
								as_folder + Char(0), &
								ls_null, ls_null, SW_NORMAL )

IF ll_rc > 32 THEN	// 0-32 are OS error codes
	RETURN 1
ELSE
	RETURN -1
END IF
end function

public function string of_browseforfolder (string as_title, boolean ab_fullpath, boolean ab_uselastroot);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_BrowseForFolder
//
//	Access:				public
//
//	Arguments:			String	as_title  	- text to display in folder dialog
//							Boolean	ab_fullpath	- return folder name only or fully 
//														  qualified path.
//							Boolean	ab_uselastroot - start browsing at the last
//															  opened folder.
//
//	Returns:				String
//							The selected folder name if successful,
//							A NULL string if an error occurrs.
//
//	Description:		Displays the folder browse dialog box and enables the
//							user to select a specific folder
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

// Check arguments
IF NOT ab_uselastroot THEN
	RETURN of_BrowseForFolder( as_title, ab_fullpath )
END IF

String		ls_null, ls_name, ls_title, ls_path, ls_folder
long			ll_rc, ll_null
Integer		li_image

SetNull( ls_null )
SetNull( ll_null )
ls_name = Space( 256 )
ls_title = as_title + char(0)

ibi.hWndOwner = Handle( iw_requestor )
ibi.pidlRoot = ii_pidl
ibi.pszDisplayName = ls_name
ibi.lpszTitle = ls_title
ibi.ulFlags = BIF_RETURNONLYFSDIRS
ibi.lpfn = ll_null
ibi.lParam = ll_null
ibi.iImage = li_image

ii_pidl = SHBrowseForFolder( ibi )
IF ii_pidl > 0 THEN
	ls_path = Space( 256 )
	IF SHGetPathFromIDList( ii_pidl, ls_path ) THEN
		IF ab_fullpath THEN
			ls_folder = ls_path
		ELSE
			ls_folder = ibi.pszDisplayName
		END IF
		
		RETURN ls_folder
	END IF
ELSE
	RETURN ls_null
END IF

end function

public function string of_browseforcomputer (string as_title, boolean ab_uselastroot);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_BrowseForComputer
//
//	Access:				public
//
//	Arguments:			String  as_title	- Text to display in browse dialog
//							Boolean ab_uselastroot	- start browsing from the last
//															  browsed item.
//
//	Returns:				String
//							The selected computer name if successful,
//							A NULL string if an error occurrs.
//
//	Description:		Displays the shell browse dialog box and enables the user
//							to select a specific computer by name
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

// Check arguments
IF NOT ab_uselastroot THEN
	RETURN of_BrowseForComputer( as_title )
END IF

String		ls_null, ls_name, ls_title, ls_path, ls_computer
long			ll_rc, ll_null
Integer		li_image

SetNull( ls_null )
SetNull( ll_null )
ls_name = Space( 256 )
ls_title = as_title + char(0)

ibi.hWndOwner = Handle( iw_requestor )
ibi.pidlRoot = ii_pidl
ibi.pszDisplayName = ls_name
ibi.lpszTitle = ls_title
ibi.ulFlags = BIF_BROWSEFORCOMPUTER
ibi.lpfn = ll_null
ibi.lParam = ll_null
ibi.iImage = li_image

ii_pidl = SHBrowseForFolder( ibi )
IF ii_pidl > 0 THEN
	ls_path = Space( 256 )
	IF SHGetPathFromIDList( ii_pidl, ls_path ) THEN
		ls_computer = ls_path + ibi.pszDisplayName
		RETURN ls_computer
	END IF
ELSE
	RETURN ls_null
END IF

end function

public function string of_browseforprinter (string as_title, boolean ab_uselastroot);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_BrowseForPrinter
//
//	Access:				public
//
//	Arguments:			String  as_title	- Text to display in browse dialog
//							Boolean ab_uselastroot	- start browsing from the last 
//															  browsed item
//
//	Returns:				String
//							The selected printer name if successful,
//							A NULL string if an error occurrs.
//
//	Description:		Displays the shell browse dialog box and enables the user
//							to select a specific printer by name
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

// Check arguments
IF NOT ab_uselastroot THEN
	RETURN of_BrowseForPrinter( as_title )
END IF

String		ls_null, ls_name, ls_title, ls_path, ls_printer
long			ll_rc, ll_null
Integer		li_image

SetNull( ls_null )
SetNull( ll_Null )
ls_name = Space( 256 )
ls_title = as_title + char(0)

ibi.hWndOwner = Handle( iw_requestor )
ibi.pidlRoot = ii_pidl
ibi.pszDisplayName = ls_name
ibi.lpszTitle = ls_title
ibi.ulFlags = BIF_BROWSEFORPRINTER
ibi.lpfn = ll_null
ibi.lParam = ll_null
ibi.iImage = li_image

ii_pidl = SHBrowseForFolder( ibi )
IF ii_pidl > 0 THEN
	ls_path = Space( 256 )
	IF SHGetPathFromIDList( ii_pidl, ls_path ) THEN
		ls_printer = ls_path + ibi.pszDisplayName
		RETURN ls_printer
	END IF
ELSE
	RETURN ls_null
END IF

end function

public function integer of_modifysystray (string as_iconfname, string as_tiptext);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_ModifySysTray
//
//	Access:				public
//
//	Arguments:			String as_iconfname	- Filename for icon to be used
//							String as_tiptext		- Text to be displayed as tooltip
//
//	Returns:				Integer
//							 1 - success
//							-1 - error
//
//	Description:		Modifies an icon to the system tray area. 
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

Long				ll_rc

ipData.cbSize	= 88
ipData.hWnd		= Handle( iw_requestor )
ipData.uID		= ipData.hWnd
ipData.uFlags	= NIF_ICON + NIF_TIP + NIF_MESSAGE
ipData.szTip 	= as_tiptext + Char(0)
ipData.uCallbackMsg = WM_MOUSEMOVE
ipData.hIcon	= LoadImageA( 0, as_iconfname, 1, 0, 0, 80 )
IF ipData.hIcon <= 0 THEN
	RETURN -1
END IF

ll_rc = Shell_NotifyIcon( NIM_MODIFY, ipData )
IF ll_rc = 0 THEN
	RETURN -1
ELSE
	ib_SystemTray = TRUE
	RETURN 1
END IF
end function

public function integer of_modifysystray (string as_tiptext);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_ModifySysTray
//
//	Access:				public
//
//	Arguments:			String as_iconfname	- Filename for icon to be used
//							String as_tiptext		- Text to be displayed as tooltip
//
//	Returns:				Integer
//							 1 - success
//							-1 - error
//
//	Description:		Modifies an icon to the system tray area. 
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

Long				ll_rc

ipData.cbSize	= 88
ipData.hWnd		= Handle( iw_requestor )
ipData.uID		= ipData.hWnd
ipData.uFlags	= NIF_ICON + NIF_TIP + NIF_MESSAGE
ipData.szTip 	= as_tiptext + Char(0)
ipData.uCallbackMsg = WM_MOUSEMOVE
ipData.hIcon	= LoadIconA( Handle( GetApplication () ), Long( 1000, 0 ) )
IF ipData.hIcon <= 0 THEN
	RETURN -1
END IF

ll_rc = Shell_NotifyIcon( NIM_MODIFY, ipData )
IF ll_rc = 0 THEN
	RETURN -1
ELSE
	ib_SystemTray = TRUE
	RETURN 1
END IF
end function

public function integer of_addtosystray (string as_tiptext);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_AddToSysTray
//
//	Access:				public
//
//	Arguments:			String as_iconfname	- Filename for icon to be used
//							String as_tiptext		- Text to be displayed as tooltip
//
//	Returns:				Integer
//							 1 - success
//							-1 - error
//
//	Description:		Adds an icon to the system tray area. 
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

// Check if there is already a tray icon for the requestor
IF ib_SystemTray = TRUE THEN
	// Don't add a new one, modify the existing one
	RETURN of_ModifySysTray( as_tiptext )
END IF

Long				ll_rc

ipData.cbSize	= 88
ipData.hWnd		= Handle( iw_requestor )
ipData.uID		= ipData.hWnd
ipData.uFlags	= NIF_ICON + NIF_TIP + NIF_MESSAGE
ipData.szTip 	= as_tiptext + Char(0)
ipData.uCallbackMsg = WM_MOUSEMOVE
ipData.hIcon	= LoadIconA( Handle( GetApplication () ), Long( 1000, 0 ) )
IF ipData.hIcon <= 0 THEN
	RETURN -1
END IF

ll_rc = Shell_NotifyIcon( NIM_ADD, ipData )
IF ll_rc = 0 THEN
	RETURN -1
ELSE
	ib_SystemTray = TRUE
	RETURN 1
END IF
end function

public function integer of_addtosystray (string as_iconfname, string as_tiptext);//////////////////////////////////////////////////////////////////////////////
//
//	Function:			of_AddToSysTray
//
//	Access:				public
//
//	Arguments:			String as_iconfname	- Filename for icon to be used
//							String as_tiptext		- Text to be displayed as tooltip
//
//	Returns:				Integer
//							 1 - success
//							-1 - error
//
//	Description:		Adds an icon to the system tray area. 
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////

// Check if there is already a tray icon for the requestor
IF ib_SystemTray = TRUE THEN
	// Don't add a new one, modify the existing one
	RETURN of_ModifySysTray( as_iconfname, as_tiptext )
END IF

Long				ll_rc

ipData.cbSize	= 88
ipData.hWnd		= Handle( iw_requestor )
ipData.uID		= ipData.hWnd
ipData.uFlags	= NIF_ICON + NIF_TIP + NIF_MESSAGE
ipData.szTip 	= as_tiptext + Char(0)
ipData.uCallbackMsg = WM_MOUSEMOVE
ipData.hIcon	= LoadImageA( 0, as_iconfname, 1, 0, 0, 80 )
IF ipData.hIcon <= 0 THEN
	RETURN -1
END IF

ll_rc = Shell_NotifyIcon( NIM_ADD, ipData )
IF ll_rc = 0 THEN
	RETURN -1
ELSE
	ib_SystemTray = TRUE
	RETURN 1
END IF
end function

public function integer of_getfileversioninfo (string as_filename, ref fileversioninfo astr_fvi);/////////////////////////////////////////////////////////////////////
//
// Function:	of_GetFileVersionInfo
// extended object from Lijun Yang
/////////////////////////////////////////////////////////////////////

ulong	dwHandle
ulong	dwLength
string	ls_versionkeys[12] = { "ProductName", "ProductVersion", &
			"OriginalFilename", "FileDescription", "FileVersion", &
			"CompanyName", "LegalCopyright", "LegalTrademarks", &
			"InternalName", "PrivateBuild", "SpecialBuild", "Comments" }
string	ls_versioninfo[12]

dwLength = GetFileVersionInfoSizeA( as_filename, dwHandle )
IF dwLength <= 0 THEN
	// No version information available
		  RETURN -1
END IF

TRANSARRAY	lst_trans
string		ls_Buff, ls_key, ls_language, ls_charset
uint			lui_length
integer		i
long			ll_pointer

// Allocate version information buffer
ls_Buff = Space( dwLength )
ls_key = Space(80)

// Get version information
IF NOT GetFileVersionInfoA( as_filename, dwHandle, dwLength, ls_Buff ) THEN
	RETURN -1
END IF

// Get the structure language ID and character set
ls_key = "\VarFileInfo\Translation"
IF NOT VerQueryValueA( ls_Buff, ls_key, ll_pointer, lui_length ) THEN
	RETURN -1
END IF

// ll_pointer contains a pointer to the structure, copy that into a local variable
CopyMemory( lst_trans, ll_pointer, lui_length )

// Convert the langid and char set into 4-digit hex value
//n_cst_numerical	inv_num
//
//ls_language  = inv_num.of_Hex( lst_trans.wLanguageId )
ls_language  = Fill( '0', 4 - Len( ls_language ) ) + ls_language

//ls_charset = inv_num.of_Hex( lst_trans.wCharacterSet )
ls_charset = Fill( '0', 4 - Len( ls_charset ) ) + ls_charset

// If version info exists, and the key query is successful, add
//  the value.  Otherwise, the value for the key is NULL.
FOR i = 1 TO 12 
	ls_key = "\StringFileInfo\" + ls_language + ls_charset + "\" + ls_versionkeys[i]
	IF NOT VerQueryValueA( ls_buff, ls_key, ll_pointer, lui_length ) OR &
		lui_length <= 0 THEN
		ls_versioninfo[i] = ""
	ELSE
		// ll_pointer contains a pointer to the string, copy that into a local variable
		ls_versioninfo[i] = Space( lui_length )
		CopyMemory( ls_versioninfo[i], ll_pointer, lui_length )
	END IF
NEXT

astr_fvi.ProductName = ls_versioninfo[1]
astr_fvi.ProductVersion = ls_versioninfo[2]
astr_fvi.OriginalFilename = ls_versioninfo[3]
astr_fvi.FileDescription = ls_versioninfo[4]
astr_fvi.FileVersion = ls_versioninfo[5]
astr_fvi.CompanyName = ls_versioninfo[6]
astr_fvi.LegalCopyright = ls_versioninfo[7]
astr_fvi.LegalTrademarks = ls_versioninfo[8]
astr_fvi.InternalName = ls_versioninfo[9]
astr_fvi.PrivateBuild = ls_versioninfo[10]
astr_fvi.SpecialBuild = ls_versioninfo[11]
astr_fvi.Comments = ls_versioninfo[12]

RETURN 1

end function

on n_cst_winsrv_shell32.create
TriggerEvent( this, "constructor" )
end on

on n_cst_winsrv_shell32.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;SetNull( ii_pidl )
end event

