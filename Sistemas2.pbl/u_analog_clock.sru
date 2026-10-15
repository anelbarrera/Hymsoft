//objectcomments Graphic analog clock
forward
global type u_analog_clock from UserObject
end type
type st_7 from statictext within u_analog_clock
end type
type st_4 from statictext within u_analog_clock
end type
type st_10 from statictext within u_analog_clock
end type
type st_1 from statictext within u_analog_clock
end type
type st_5 from statictext within u_analog_clock
end type
type st_3 from statictext within u_analog_clock
end type
type st_6 from statictext within u_analog_clock
end type
type st_2 from statictext within u_analog_clock
end type
type st_11 from statictext within u_analog_clock
end type
type st_9 from statictext within u_analog_clock
end type
type st_12 from statictext within u_analog_clock
end type
type st_8 from statictext within u_analog_clock
end type
type oval_1 from oval within u_analog_clock
end type
type ln_hora from line within u_analog_clock
end type
type ln_minuto from line within u_analog_clock
end type
type ln_segundo from line within u_analog_clock
end type
end forward

global type u_analog_clock from UserObject
int Width=906
int Height=713
boolean Border=true
long BackColor=12632256
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
event timer pbm_timer
st_7 st_7
st_4 st_4
st_10 st_10
st_1 st_1
st_5 st_5
st_3 st_3
st_6 st_6
st_2 st_2
st_11 st_11
st_9 st_9
st_12 st_12
st_8 st_8
oval_1 oval_1
ln_hora ln_hora
ln_minuto ln_minuto
ln_segundo ln_segundo
end type
global u_analog_clock u_analog_clock

type prototypes

end prototypes

type variables
int         ii_midx, ii_midy
boolean ib_muestra
int         ii_oldx2, ii_oldx3, ii_oldy2, ii_oldy3
end variables

forward prototypes
public subroutine uf_start_ticking ()
public subroutine uf_stop_ticking ()
end prototypes

event timer;real	r_x
int	x2, y2, x3, y3

if not ib_muestra then
	ii_midy = this.height/2
	ii_midx = this.width/2

	ln_segundo.beginx = ii_midx
	ln_segundo.beginy = ii_midy

	ln_minuto.beginx = ii_midx 
	ln_minuto.beginy = ii_midy 

	ln_hora.beginx = ii_midx 
	ln_hora.beginy = ii_midy 
end if

//////////////////////////////////////////////////////////////////////
// Calculo y coloco el final de la x,y para los segundos
//////////////////////////////////////////////////////////////////////
r_x = 2 * Second (Now())
r_x = r_x / 60
r_x = Pi (r_x)

ln_segundo.endx  = ii_midx + 250 * Sin (r_x)	
ln_segundo.endy  = ii_midy - 220 * Cos (r_x)

//////////////////////////////////////////////////////////////////////
// Calculo el final de la x, y para los minutos
//////////////////////////////////////////////////////////////////////
r_x = 2 * (60 * Minute (Now()) + Second (Now()))
r_x = r_x / 3600
r_x = Pi (r_x)

/* Muevo la manecilla de los minuto solo cuando los minutos cambien */

x2 = Int (ii_midx + 240 * Sin(r_x))
if x2 <> ii_oldx2 or y2 <> ii_oldy2 then
	ln_minuto.endx = x2
	ii_oldx2        = x2
	y2              = Int (ii_midy - 210 * Cos(r_x))
	ln_minuto.endy = y2
	ii_oldy2        = y2
end if

//////////////////////////////////////////////////////////////////////
// Calculo el final de la x,y de la hora
//////////////////////////////////////////////////////////////////////
r_x = 2 * (3600 * Hour(Now()) + 60 * Minute (Now()) + Second(Now()))
r_x = r_x / 3600
r_x = r_x / 12
r_x = Pi (r_x)

//////////////////////////////////////////////////////////////////////
// Muevo la manecilla de la hora solo cuando esta halla cambiado
//////////////////////////////////////////////////////////////////////
x3 = Int (ii_midx + 175 * Sin (r_x))
if x3 <> ii_oldx3 then
	ln_hora.endx = x3
	ii_oldx3 = x3
end if

y3=Int (ii_midy - 155 * Cos(r_x))
if y3 <> ii_oldy3 then
	ln_hora.endy = y3
	ii_oldy3 = y3
end if

if ib_muestra = false then
	ib_muestra = true
	ln_segundo.Show()
	ln_segundo.LineColor = RGB(0, 255, 255)
	ln_minuto.Show()
	ln_minuto.LineColor = RGB(255, 0, 255)
	ln_hora.Show()
	ln_hora.LineColor = RGB(0, 0, 0)
end if







end event

public subroutine uf_start_ticking ();int	li_id

li_id = 1 
if li_id = 0 then
	MessageBox ("Error!", "No se logro comenzar el Timer!")
end if
end subroutine

public subroutine uf_stop_ticking ();boolean	lb_ret

lb_ret = True 
if lb_ret = false then
	 MessageBox ("Error!", "El Timer especificado no esta activo!")
end if
end subroutine

on u_analog_clock.create
this.st_7=create st_7
this.st_4=create st_4
this.st_10=create st_10
this.st_1=create st_1
this.st_5=create st_5
this.st_3=create st_3
this.st_6=create st_6
this.st_2=create st_2
this.st_11=create st_11
this.st_9=create st_9
this.st_12=create st_12
this.st_8=create st_8
this.oval_1=create oval_1
this.ln_hora=create ln_hora
this.ln_minuto=create ln_minuto
this.ln_segundo=create ln_segundo
this.Control[]={ this.st_7,&
this.st_4,&
this.st_10,&
this.st_1,&
this.st_5,&
this.st_3,&
this.st_6,&
this.st_2,&
this.st_11,&
this.st_9,&
this.st_12,&
this.st_8,&
this.oval_1,&
this.ln_hora,&
this.ln_minuto,&
this.ln_segundo}
end on

on u_analog_clock.destroy
destroy(this.st_7)
destroy(this.st_4)
destroy(this.st_10)
destroy(this.st_1)
destroy(this.st_5)
destroy(this.st_3)
destroy(this.st_6)
destroy(this.st_2)
destroy(this.st_11)
destroy(this.st_9)
destroy(this.st_12)
destroy(this.st_8)
destroy(this.oval_1)
destroy(this.ln_hora)
destroy(this.ln_minuto)
destroy(this.ln_segundo)
end on

type st_7 from statictext within u_analog_clock
int X=407
int Y=581
int Width=92
int Height=73
boolean Enabled=false
string Text="6"
Alignment Alignment=Center!
long BackColor=16777215
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within u_analog_clock
int X=718
int Y=309
int Width=92
int Height=73
boolean Enabled=false
string Text="3"
Alignment Alignment=Center!
long TextColor=16777215
long BackColor=16711680
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_10 from statictext within u_analog_clock
int X=78
int Y=309
int Width=92
int Height=73
boolean Enabled=false
string Text="9"
Alignment Alignment=Center!
long TextColor=16777215
long BackColor=16711680
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_analog_clock
int X=407
int Y=61
int Width=92
int Height=73
boolean Enabled=false
string Text="12"
Alignment Alignment=Center!
long BackColor=16777215
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within u_analog_clock
int X=682
int Y=445
int Width=92
int Height=73
boolean Enabled=false
string Text="4"
Alignment Alignment=Center!
long BackColor=16776960
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within u_analog_clock
int X=682
int Y=181
int Width=92
int Height=73
boolean Enabled=false
string Text="2"
Alignment Alignment=Center!
long BackColor=65535
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within u_analog_clock
int X=563
int Y=549
int Width=92
int Height=73
boolean Enabled=false
string Text="5"
Alignment Alignment=Center!
long BackColor=16711935
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within u_analog_clock
int X=563
int Y=93
int Width=92
int Height=73
boolean Enabled=false
string Text="1"
Alignment Alignment=Center!
long BackColor=65280
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_11 from statictext within u_analog_clock
int X=124
int Y=445
int Width=92
int Height=73
boolean Enabled=false
string Text="8"
Alignment Alignment=Center!
long BackColor=65535
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_9 from statictext within u_analog_clock
int X=124
int Y=181
int Width=92
int Height=73
boolean Enabled=false
string Text="10"
Alignment Alignment=Center!
long BackColor=16776960
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_12 from statictext within u_analog_clock
int X=243
int Y=549
int Width=92
int Height=73
boolean Enabled=false
string Text="7"
Alignment Alignment=Center!
long BackColor=65280
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_8 from statictext within u_analog_clock
int X=243
int Y=93
int Width=92
int Height=73
boolean Enabled=false
string Text="11"
Alignment Alignment=Center!
long BackColor=16711935
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type oval_1 from oval within u_analog_clock
int X=119
int Y=93
int Width=645
int Height=517
boolean Enabled=false
int LineThickness=9
long LineColor=8421376
long FillColor=12632256
end type

type ln_hora from line within u_analog_clock
boolean Visible=false
boolean Enabled=false
int BeginX=476
int BeginY=333
int EndX=476
int EndY=189
int LineThickness=13
end type

type ln_minuto from line within u_analog_clock
boolean Visible=false
boolean Enabled=false
int BeginX=485
int BeginY=341
int EndX=677
int EndY=421
int LineThickness=9
end type

type ln_segundo from line within u_analog_clock
boolean Visible=false
boolean Enabled=false
int BeginX=467
int BeginY=333
int EndX=641
int EndY=493
int LineThickness=5
end type

