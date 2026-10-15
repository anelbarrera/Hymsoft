//objectcomments J.V.B.
forward
global type w_espere from Window
end type
type cb_1 from commandbutton within w_espere
end type
type oval_1 from oval within w_espere
end type
type st_1 from statictext within w_espere
end type
type p_1 from picture within w_espere
end type
type p_2 from picture within w_espere
end type
end forward

global type w_espere from Window
int X=827
int Y=512
int Width=923
int Height=724
boolean Enabled=false
long BackColor=12632256
boolean ToolBarVisible=false
WindowType WindowType=popup!
event ue_post_open ( )
cb_1 cb_1
oval_1 oval_1
st_1 st_1
p_1 p_1
p_2 p_2
end type
global w_espere w_espere

type variables
Integer ii_bugs,  ii_bugs2, ii_bugs3

string  s_path ,   s_path2 
end variables

event ue_post_open;//if ii_bugs <= 0 then
//   timer(0.2)
//else
//	timer(0.0)
//	ii_bugs= integer('')
//end if
//
end event

event open;String	ls_path

ii_bugs = 1
gf_center_win(this)
ls_path = str.path
gf_find_path(ls_path)
//s_path = ls_path + "art\n"

s_path = "\harr2000\art\n"
timer(0.1)
//s_path =  'c:\jorge\aplicaiciones pb5\

//s_path2 = 'c:\jorge\aplicaiciones pb5\ani\ha'

//this.postevent('ue_post_open')
end event

on w_espere.create
this.cb_1=create cb_1
this.oval_1=create oval_1
this.st_1=create st_1
this.p_1=create p_1
this.p_2=create p_2
this.Control[]={this.cb_1,&
this.oval_1,&
this.st_1,&
this.p_1,&
this.p_2}
end on

on w_espere.destroy
destroy(this.cb_1)
destroy(this.oval_1)
destroy(this.st_1)
destroy(this.p_1)
destroy(this.p_2)
end on

event timer;string ld_df[]

ii_bugs++
ii_bugs2++

ld_df[1] = '                 Esp'
ld_df[2] = '              Espere'
ld_df[3] = '           Espere un'
ld_df[4] = '        Espere un mo'
ld_df[5] = '     Espere un momen'
ld_df[6] = '   Espere un momento'
ld_df[7] = 'Espere un momento...'
ld_df[8] = 'ere un momento...   '
ld_df[9] = ' un momento...      '
ld_df[10]= 'momento...          '
ld_df[11]= 'nto...              '
ld_df[12]= '.                   '
ld_df[13]= '                    '
//// Espere un momento... 
//If ii_bugs <= 6 Then
//	p_1.picturename = s_path  + String(ii_bugs) + '.bmp'
////	ld_df[ii_bugs]
////	p_2.picturename = s_path2 + String(ii_bugs) + '.bmp'
//Else
//	ii_bugs = 1
//	p_1.picturename = s_path  + String(ii_bugs) + '.bmp'	
////	p_2.picturename = s_path2 + String(ii_bugs) + '.bmp'
//End If

If ii_bugs2 <= 13 Then
		st_1.text = ld_df[ii_bugs2]
	If ii_bugs2 <= 6 Then
		st_1.Alignment= right!
	else
		st_1.Alignment  = left!
//		If ii_bugs2 = 7 Then  st_1.Alignment =  Center!
	end if

else
	ii_bugs2 = 0
	
if  ii_bugs3	<= 0 then
	ii_bugs3	= 1
	st_1.y =  456
else
	ii_bugs3	= 0
   st_1.y =  140   //456
end if

end if
yield()

end event

type cb_1 from commandbutton within w_espere
int X=1047
int Y=768
int Width=197
int Height=108
int TabOrder=30
boolean Visible=false
string Text="y"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;timer(0.2)

end event

type oval_1 from oval within w_espere
int X=32
int Y=108
int Width=599
int Height=600
boolean Enabled=false
int LineThickness=4
long LineColor=29738437
long FillColor=29738437
end type

type st_1 from statictext within w_espere
int X=110
int Y=92
int Width=686
int Height=68
boolean Enabled=false
boolean BringToTop=true
string Text=" Espere un momento... "
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=16777215
int TextSize=-11
int Weight=700
string FaceName="Garamond"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type p_1 from picture within w_espere
int X=187
int Y=160
int Width=535
int Height=320
string PictureName="\harr2000\Art\harr_logo.bmp"
boolean FocusRectangle=false
end type

event clicked;if ii_bugs <= 0 then
   timer(0.2)
else
	timer(0.0)
	ii_bugs= integer('')
end if

end event

type p_2 from picture within w_espere
int Width=919
int Height=732
string PictureName="\harr2000\art\ha1.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

