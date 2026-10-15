forward
global type w_web_browser from window
end type
type wb_1 from webbrowser within w_web_browser
end type
end forward

global type w_web_browser from window
integer width = 3803
integer height = 1584
boolean titlebar = true
string title = "Presentacion"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
windowanimationstyle openanimation = centeranimation!
windowanimationstyle closeanimation = centeranimation!
wb_1 wb_1
end type
global w_web_browser w_web_browser

type variables
boolean ib_init

end variables

on w_web_browser.create
this.wb_1=create wb_1
this.Control[]={this.wb_1}
end on

on w_web_browser.destroy
destroy(this.wb_1)
end on

event open;string ls_archivo
ls_archivo = message.stringparm
wb_1.navigate( 'file:///' + ls_archivo )
ib_init = false //Instance Variables： Boolean ib_init
//li_Ret = wb_1.Zoom( 125 ) //125%



end event

event resize;wb_1.y = 0; wb_1.y = 0
wb_1.width = newwidth; wb_1.height = newheight
end event

type wb_1 from webbrowser within w_web_browser
integer x = 27
integer y = 28
integer width = 3566
integer height = 1376
end type

event navigationprogressindex;If Not ib_init Then
   If progressindex = 100 Then
      ib_init = true
//      print()
//	 wb_1.visible = true
   End If
End If

end event

