//objectcomments New! Used on the enhanced w_mdi_clock Window
forward
global type u_mdi_clock_item from UserObject
end type
type st_1 from statictext within u_mdi_clock_item
end type
type ln_gray from line within u_mdi_clock_item
end type
type ln_white from line within u_mdi_clock_item
end type
end forward

global type u_mdi_clock_item from UserObject
int Width=549
int Height=73
long BackColor=79741120
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
event micro pbm_nchittest
st_1 st_1
ln_gray ln_gray
ln_white ln_white
end type
global u_mdi_clock_item u_mdi_clock_item

forward prototypes
public subroutine uf_set_text (string txt)
public subroutine uf_set_width (int wdth, alignment align)
end prototypes

public subroutine uf_set_text (string txt);st_1.text = txt
end subroutine

public subroutine uf_set_width (int wdth, alignment align);this.width = wdth
st_1.width = wdth - st_1.x
st_1.alignment = align
end subroutine

on u_mdi_clock_item.create
this.st_1=create st_1
this.ln_gray=create ln_gray
this.ln_white=create ln_white
this.Control[]={ this.st_1,&
this.ln_gray,&
this.ln_white}
end on

on u_mdi_clock_item.destroy
destroy(this.st_1)
destroy(this.ln_gray)
destroy(this.ln_white)
end on

event rbuttondown;If IsNumber(left(st_1.text, 2)) Then	
	opensheet(w_reloj, str.frame, 0, original!)
End If
end event

type st_1 from statictext within u_mdi_clock_item
int X=14
int Width=526
int Height=61
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=80263328
int TextSize=-7
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ln_gray from line within u_mdi_clock_item
boolean Enabled=false
int BeginX=10
int EndX=10
int EndY=61
int LineThickness=5
long LineColor=8421504
end type

type ln_white from line within u_mdi_clock_item
boolean Enabled=false
int EndY=61
int LineThickness=5
long LineColor=16777215
end type

