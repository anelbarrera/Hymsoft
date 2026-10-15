//objectcomments Ventana Frame Ancestro (NO TOCAR)
forward
global type w_grampa_frame from window
end type
type mdi_1 from mdiclient within w_grampa_frame
end type
type mditbb_1 from tabbedbar within w_grampa_frame
end type
type mdirbb_1 from ribbonbar within w_grampa_frame
end type
end forward

global type w_grampa_frame from window
integer x = 832
integer y = 360
integer width = 1541
integer height = 1280
boolean titlebar = true
string title = "Untitled"
string menuname = "m_granpa"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_post_open ( )
mdi_1 mdi_1
mditbb_1 mditbb_1
mdirbb_1 mdirbb_1
end type
global w_grampa_frame w_grampa_frame

type variables
Integer ii_cont
String   is_ddeappl = "DDE_HARR", &
            is_ddetopic = "DDE", &
            is_item1="Data1", &
            is_item2="Data2", &
            is_item3="Data3", &
            is_start = 'No'
end variables

event ue_post_open();string ls_titulo
ls_titulo = this.title
this.title="Sistema Integrado de Trafico"
//gf_dg_nom_empresa(str.g_financiero,str.empresa)+' -- '+ls_titulo
end event

on w_grampa_frame.create
if this.MenuName = "m_granpa" then this.MenuID = create m_granpa
this.mdi_1=create mdi_1
this.mditbb_1=create mditbb_1
this.mdirbb_1=create mdirbb_1
this.Control[]={this.mdi_1,&
this.mditbb_1,&
this.mdirbb_1}
end on

on w_grampa_frame.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.mditbb_1)
destroy(this.mdirbb_1)
end on

event open;This.Icon = str.icono
//mf_accesos(this.menuid, this)

this.triggerevent("ue_post_open")
str.frame = this
// messagebox("Start DDE","Aplicacion "+ is_ddeappl+"  Topic "+is_ddetopic+"  item1 "+is_item1+"  item2 "+is_item2+"  item3 "+is_item3)

if startserverdde(is_ddeappl,is_ddetopic,is_item1,is_item2,is_item3) = 1 then is_start = 'Si'
end event

event close;//gf_clean_bitacora()

stopserverdde(is_ddeappl,is_ddetopic)
//if isvalid(w_dde_client) then close(w_dde_client)

//2 open the window without show the login window
//OpenWithParm(w_clave, "No Password")
end event

event remoteexec;String data, appl, topic


If getcommandddeorigin(appl) <> 1 Or getcommanddde(data) <> 1 Then
	MessageBox("", false)
	respondremote(false)
Else
	MessageBox("", true)
	respondremote(true)
End If
end event

event remotehotlinkstart;//HotLink

string item, appl, topic


getdataddeorigin(appl,topic,item)

choose case item
	case is_item1
		MessageBox("Start", "1")
	case is_item2
		MessageBox("Start", "2")
	case is_item3
		MessageBox("Start", "3")
	case else
		respondremote(false)
		return
end choose

respondremote(true)
end event

event remotehotlinkstop;//HotLink

string item,appl,topic


beep(1)

getdataddeorigin(appl,topic,item)

choose case item
	case is_item1
		MessageBox("Stop", "1")
	case is_item2
		MessageBox("Stop", "2")
	case is_item3
		MessageBox("Stop", "3")
	case else
		respondremote(false)
		return
end choose

respondremote(true)


end event

event remoterequest;//Getremote 

string data,appl,topic


getdataddeorigin(appl,topic,data)

choose case data
	case is_item1
		data = "Item_1"
	case is_item2
		data = "Item_2"
	case is_item3
		data = "Item_3"
	case else
		data = "Petición Desconocida"
end choose

setdatadde(data)

end event

event activate;//str.frame.setmicrohelp("Activo frame")
end event

event deactivate;str.frame.setmicrohelp("Sistema Hymsoft")
end event

type mdi_1 from mdiclient within w_grampa_frame
long BackColor=16777215
end type

type mditbb_1 from tabbedbar within w_grampa_frame
int X=0
int Y=0
int Width=0
int Height=104
end type

type mdirbb_1 from ribbonbar within w_grampa_frame
int X=0
int Y=0
int Width=0
int Height=596
end type

